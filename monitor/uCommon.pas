//
// Common functions
//

unit uCommon;

interface

uses
  Winapi.Windows, Vcl.Controls, Vcl.Graphics, System.Classes, System.SysUtils, Winapi.IPTypes, cxImage, cxGraphics;

const
  CR   = #13;
  LF   = #10;
  CRLF = #13#10;

type
  TAlignType = (atLeft, atRight, atBoth);

  PNetworkInterfaces = ^TNetworkInterfaces;
  TNetworkInterfaces = record
                         Count : Integer;
                         Items : Array of PIP_ADAPTER_ADDRESSES;
                       end;

procedure Log(const AFile, ALine : String);
procedure Debug(const AModule, AProc: String);
procedure PNGResToImage(const AImage : TcxImage; const AResourceName : String);
procedure SetBackground(const AControl : TWinControl; const AResourceName : String);
function GetProcessName(const AID : DWORD) : String;
function GetUnicastIP(AFirstUnicastAddress : PIP_ADAPTER_UNICAST_ADDRESS) : String;
function GetNetworkInterfaces(var ANetworkInterfaces : TNetworkInterfaces) : Integer;
function Match(const AStr1, AStr2 : String; const ACaseSensitive : Boolean = TRUE) : Boolean;
function GetWindowCaption(const AHWND: HWND): String;
function SafeEncode(const AString: String; const ASafeSet: TSysCharSet = ['a'..'z', 'A'..'Z', '0'..'9', '_', '-', ' ', '.']): String;
function BufPos(const ABuffer: System.SysUtils.TByteArray; const ABufferSize: Integer; const AString: String): Integer;
function StripNonAsciiExceptCRLF(const AValue: AnsiString): AnsiString;
procedure ShellOpen(const AFileName : String; const AParams : PChar = nil; const ADirectory : PChar = nil; const AShowCmd: Integer = SW_SHOW);
function EnumerateFiles(const APath, AFilemask : String; const ASearchSubdirs : Boolean; var AFiles : TStringList) : Integer;
function AlignString(const AString: String; const ALength: Integer; const AAlignType: TAlignType = atLeft; const AAlignChar: Char = ' '): String;
function AddToImageList(const AFile: String; const AImageList: TcxImageList): Integer;
function IsUserAnAdmin : Boolean;
function RunAs(const ADomain, AUsername, APassword, ACommandLine : String; var AProcessInfo : TProcessInformation) : Integer;
procedure ShortCutToHotKey(const AHotKey: TShortCut; var AKey: Word; var AModifiers: UINT);

implementation

uses
  Vcl.ExtCtrls, Vcl.Imaging.PNGImage, Vcl.Forms, Winapi.TlHelp32, Winapi.ShellApi, Vcl.Menus,
  Winapi.Winsock2, Winapi.IPHlpApi, System.Masks, Vcl.Imaging.JPEG;

var
  ProcessStartTime: DWORD;


procedure Log(const AFile, ALine : String);
//
// Writes line in file
//
var
  fs : TStreamWriter;
begin
  fs := TStreamWriter.Create(AFile, TRUE);
  try
    fs.WriteLine(ALine);
  finally
    fs.Free;
  end;
end;

procedure Debug(const AModule, AProc: String);
//
// Debug
//
const
  DEBUG_FILE = 'debug.txt';
var
  timeFromStart: Double;
begin
  timeFromStart := (GetTickCount - ProcessStartTime) / 1000;
  Log(DEBUG_FILE, Format('[%s] %s.%s()', [FormatFloat('00000000.000', timeFromStart), AModule, AProc]));
end;

procedure SetBackground(const AControl : TWinControl; const AResourceName : String);
//
// Load image from resources, create TImage for specified control and set it as it's background
//
var
  pngimg     : TPNGImage;
  background : TImage;
begin
  pngimg := TPNGImage.Create;
  try
    pngimg.LoadFromResourceName(HInstance, AResourceName);
    background := TImage.Create(AControl);
    background.Parent := AControl;
    background.Name := 'imgBackground' + AControl.Name;
    background.Align := alClient;
    background.Center := TRUE;
    background.Picture.Assign(pngimg);
    background.SendToBack;
  finally
    pngimg.Free;
  end;
end;

procedure PNGResToImage(const AImage : TcxImage; const AResourceName : String);
//
// Load PNG image from resources and assign it to specified image
//
var
  pngimg : TPNGImage;
begin
  pngimg := TPNGImage.Create;
  try
    pngimg.LoadFromResourceName(HInstance, AResourceName);
    AImage.Picture.Bitmap.Assign(pngimg);
  finally
    pngimg.Free;
  end;
end;

function GetProcessName(const AID : DWORD) : String;
//
// Returns process name from PID
//
var
  hSnapshot : THandle;
  pEntry    : TProcessEntry32;
begin
  result := '';
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  pEntry.dwSize := SizeOf(TProcessEntry32);
  If Process32First(hSnapshot, pEntry) Then
  Begin
    If pEntry.th32ProcessID = AID Then
      result := String(pEntry.szExeFile)
    else
      While (result = '') and
            (Process32Next(hSnapshot, pEntry)) Do
        If pEntry.th32ProcessID = AID Then
          result := String(pEntry.szExeFile);
  End;
  CloseHandle(hSnapshot);
end;

function GetUnicastIP(AFirstUnicastAddress : PIP_ADAPTER_UNICAST_ADDRESS) : String;
var
  addr    : Array[0..MAX_PATH - 1] of Char;
  addrLen : DWORD;
begin
  result := '';
  while Assigned(AFirstUnicastAddress) do
  begin
    if AFirstUnicastAddress.Address.lpSockaddr.sa_family = AF_INET then
    begin
      addrlen := SizeOf(addr);
      if WSAAddressToString(TSockAddr(AFirstUnicastAddress.Address.lpSockaddr^), AFirstUnicastAddress.Address.iSockaddrLength, nil, addr, addrLen) = ERROR_SUCCESS then
      begin
        result := Copy(addr, 0, addrLen - 1);
        Break;
      end;
    end;
    AFirstUnicastAddress := AFirstUnicastAddress.Next;
  end;
end;

function GetNetworkInterfaces(var ANetworkInterfaces : TNetworkInterfaces) : Integer;
var
  pAdapterAddresses : PIP_ADAPTER_ADDRESSES;
  Status            : DWORD;
  BufLen            : DWORD;
  C1                : Integer;
  WSAData           : TWSAData;
begin
  for C1 := 0 to ANetworkInterfaces.Count - 1 do
    if Assigned(ANetworkInterfaces.Items[C1]) then
      FreeMem(ANetworkInterfaces.Items[C1], SizeOf(IP_ADAPTER_ADDRESSES));

  ANetworkInterfaces.Count := 0;
  SetLength(ANetworkInterfaces.Items, ANetworkInterfaces.Count);

  WSAStartup(MAKEWORD(2, 2), WSAData);

  BufLen := 0;
  Status := GetAdaptersAddresses(0, 0, nil, nil, @BufLen);
  if Status = ERROR_BUFFER_OVERFLOW then
  begin
    pAdapterAddresses := AllocMem(BufLen);
    if GetAdaptersAddresses(0, 0, nil, pAdapterAddresses, @BufLen) = ERROR_SUCCESS then
    begin
      while Assigned(pAdapterAddresses) do
      begin
        if GetUnicastIP(pAdapterAddresses^.FirstUnicastAddress) <> '' then
        begin
          Inc(ANetworkInterfaces.Count);
          SetLength(ANetworkInterfaces.Items, ANetworkInterfaces.Count);
          ANetworkInterfaces.Items[ANetworkInterfaces.Count - 1] := AllocMem(SizeOf(IP_ADAPTER_ADDRESSES));
          Move(pAdapterAddresses^, ANetworkInterfaces.Items[ANetworkInterfaces.Count - 1]^, SizeOf(IP_ADAPTER_ADDRESSES));
        end;
        pAdapterAddresses := pAdapterAddresses^.Next;
      end;
    end;
    FreeMem(pAdapterAddresses, BufLen);
  end;

  WSACleanup;

  result := ANetworkInterfaces.Count;
end;

function Match(const AStr1, AStr2 : String; const ACaseSensitive : Boolean = TRUE) : Boolean;

  function MatchPattern(str1, str2 : PWideChar) : Boolean;
  begin
    if StrComp(str2, '*') = 0 then
      result := TRUE
    else
      if (str1^ = #0) and
         (str2^ <> #0) then
        result := FALSE
      else
        if str1^ = #0 then
          result := TRUE
        else
          case str2^ of
            '*': If MatchPattern(str1, @str2[1]) then
                   result := TRUE
                 else
                   result := MatchPattern(@str1[1], str2);
            '?': result := MatchPattern(@str1[1], @str2[1]);
          else
            if str1^ = str2^ then
              result := MatchPattern(@str1[1], @str2[1])
            else
              result := FALSE;
          end;
  end;

begin
  if ACaseSensitive then
    result := MatchPattern(PWideChar(AStr1), PWideChar(AStr2)) or
              MatchPattern(PWideChar(AStr2), PWideChar(AStr1))
  else
    result := MatchPattern(PWideChar(LowerCase(AStr1)), PWideChar(LowerCase(AStr2))) or
              MatchPattern(PWideChar(LowerCase(AStr2)), PWideChar(LowerCase(AStr1)));
end;
function GetWindowCaption(const AHWND: HWND): String;
var
  winText : Array[0..MAX_PATH - 1] of Char;
begin
  result := '';
  if GetWindowText(AHWND, winText, SizeOf(winText) - 1) <> 0 then
    result := winText;
end;

function SafeEncode(const AString: String; const ASafeSet: TSysCharSet = ['a'..'z', 'A'..'Z', '0'..'9', '_', '-', ' ', '.']): String;
var
  C1: Integer;
begin
  result := AString;
  for C1 := 1 to Length(result) do
    if not CharInSet(result[C1], ASafeSet) then
      result[C1] := '_';
end;

function BufPos(const ABuffer: System.SysUtils.TByteArray; const ABufferSize: Integer; const AString: String): Integer;
var
  C1    : Integer;
  tmp   : String;
  strlen: Integer;
begin
  if (AString <> '') and
     (ABufferSize > 0) then
  begin
    strlen := Length(AString);
    SetLength(tmp, strlen);
    for C1 := 0 to ABufferSize - strlen do
    begin
      Move(ABuffer[C1], tmp[1], strlen * SizeOf(Char));
      if tmp = AString then
        Exit(C1);
    end;
  end;

  Exit(0);
end;

function StripNonAsciiExceptCRLF(const AValue: AnsiString): AnsiString;
var
  ch: AnsiChar;
begin
  result := '';
  for ch in AValue do
    if CharInSet(ch, [#32..#127, #13, #10]) then
      result := result + ch;
end;

procedure ShellOpen(const AFileName : String; const AParams : PChar = nil; const ADirectory : PChar = nil; const AShowCmd: Integer = SW_SHOW);
begin
  ShellExecute(0, 'open', PChar(AFileName), AParams, ADirectory, AShowCmd);
end;

function EnumerateFiles(const APath, AFilemask : String; const ASearchSubdirs : Boolean; var AFiles : TStringList) : Integer;
var
  SearchRec : TSearchRec;
  IsFound   : Boolean;
begin
  result := 0;
  IsFound := FindFirst(IncludeTrailingPathDelimiter(APath) + '*.*', faAnyFile, SearchRec) = 0;
  While IsFound Do
  Begin
    If (SearchRec.Name <> '.') and (SearchRec.Name <> '..') Then
    Begin
      If (ASearchSubdirs) and
         (SearchRec.Attr and faDirectory = faDirectory) Then
        Inc(result, EnumerateFiles(IncludeTrailingPathDelimiter(APath) + SearchRec.Name, AFilemask, ASearchSubdirs, AFiles))
      else
        If Match(SearchRec.Name, AFilemask) Then
        Begin
          AFiles.Add(IncludeTrailingPathDelimiter(APath) + SearchRec.Name);
          Inc(result);
        End;
    End;
    IsFound := FindNext(SearchRec) = 0;
  End;
  FindClose(SearchRec);
end;

function AlignString(const AString: String; const ALength: Integer; const AAlignType: TAlignType = atLeft; const AAlignChar: Char = ' '): String;
var
  both: Integer;
begin
  result := AString;
  both := 1;
  while Length(result) < ALength do
  begin
    case AAlignType of
      atLeft : result := result + AAlignChar;
      atRight: result := AAlignChar + result;
      atBoth : begin
                 if both = 1 then
                   result := result + AAlignChar
                 else
                   result := AAlignChar + result;
                 both := -both;
               end;
    end;
  end;
end;

function AddToImageList(const AFile: String; const AImageList: TcxImageList): Integer;
var
  jpg: TJPEGImage;
  bmp: TBitmap;
begin
  jpg := TJPEGImage.Create;
  jpg.LoadFromFile(AFile);
  bmp := TBitmap.Create;
  bmp.PixelFormat := pf24bit;
  bmp.Width := AImageList.Width;
  bmp.Height := AImageList.Height;
  bmp.Canvas.StretchDraw(Rect(0, 0, bmp.Width, bmp.Height), jpg);
  result := AImageList.Add(bmp, nil);
  bmp.Free;
  jpg.Free;
end;

function IsUserAnAdmin : Boolean;
const
  SECURITY_NT_AUTHORITY       : TSIDIdentifierAuthority = (Value : (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS     = $00000220;
var
  hAccessToken       : THandle;
  ptgGroups          : PTokenGroups;
  dwInfoBufferSize   : DWORD;
  psidAdministrators : PSID;
  C1                 : Integer;
  bSuccess           : BOOL;
begin
  result := FALSE;

  if (OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, hAccessToken)) or
     ((GetLastError = ERROR_NO_TOKEN) and
      (OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hAccessToken))) then
  begin
    GetMem(ptgGroups, 1024);

    bSuccess := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, 1024, dwInfoBufferSize);

    CloseHandle(hAccessToken);

    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdministrators);

      for C1 := 0 to ptgGroups.GroupCount - 1 do
        if EqualSid(psidAdministrators, ptgGroups.Groups[C1].Sid) then
        begin
          result := TRUE;
          Break;
        end;

      FreeSid(psidAdministrators);
    end;

    FreeMem(ptgGroups);
  end;
end;

//
// Run process as specified user
//
function RunAs(const ADomain, AUsername, APassword, ACommandLine : String; var AProcessInfo : TProcessInformation) : Integer;
const
  LOGON_WITH_PROFILE        = $00000001;
  LOGON_NETCREDENTIALS_ONLY = $00000002;

  LIB_COUNT = 2;
  LIB_NAMES : Array[0..LIB_COUNT - 1] of String = ('advapi32.dll', 'userenv.dll');
var
  startupInfo     : TStartupInfo;
  hToken          : THandle;
  cUserProfile    : Array[0..MAX_PATH] of AnsiChar;
  userProfileSize : DWORD;
  C1              : Integer;
  LIB_HANDLES     : Array[0..LIB_COUNT - 1] of THandle;

  CreateProcessWithLogonW  : function(lpUsername, lpDomain, lpPassword: LPCWSTR; dwLogonFlags: DWORD; lpApplicationName: LPCWSTR; lpCommandLine: LPWSTR;
                                      dwCreationFlags: DWORD; lpEnvironment: pointer; lpCurrentDirectory: LPCWSTR;  const lpStartupInfo: TStartupInfo;
                                      var lpProcessInformation: PROCESS_INFORMATION): BOOL; stdcall; // external 'advapi32.dll';
  GetUserProfileDirectoryA : function(hToken: THandle; lpProfileDir: pchar; var lpcchSize: dword): longbool; stdcall; // external 'userenv.dll';
//  CreateEnvironmentBlock   : function(var lpEnvironment: pointer; hToken: THandle; bInherit: BOOL): BOOL; stdcall; // external 'userenv.dll';
//  DestroyEnvironmentBlock  : function(lpEnvironment: pointer): BOOL; stdcall; // external 'userenv.dll';
//  LoadUserProfileA         : function(hToken : THandle; var profileInfo : TProfileInfo) : BOOL; stdcall; // external 'userenv.dll';
//  UnloadUserProfile        : function(hToken, HKEY : THandle) : BOOL; stdcall; // external 'userenv.dll';
begin
  result := 0;

  for C1 := 0 to LIB_COUNT - 1 do
  begin
    LIB_HANDLES[C1] := LoadLibrary(PChar(LIB_NAMES[C1]));
    if LIB_HANDLES[C1] = 0 then
    begin
      result := GetLastError;
      Break;
    end;
  end;

  try
    if result = 0 then
    begin
      CreateProcessWithLogonW := GetProcAddress(LIB_HANDLES[0], 'CreateProcessWithLogonW');
      if Assigned(CreateProcessWithLogonW) then
      begin
        GetUserProfileDirectoryA := GetProcAddress(LIB_HANDLES[1], 'GetUserProfileDirectoryA');
        if Assigned(GetUserProfileDirectoryA) then
        begin
          if LogonUserW(PWideChar(AUsername), PWideChar(ADomain), PWideChar(APassword), LOGON32_LOGON_INTERACTIVE, LOGON32_PROVIDER_DEFAULT, hToken) then
          begin
            userProfileSize := SizeOf(cUserProfile);
            if GetUserProfileDirectoryA(hToken, @cUserProfile[0], userProfileSize) then
            begin
              ZeroMemory(@AProcessInfo, SizeOf(TProcessInformation));
              ZeroMemory(@startupInfo, SizeOf(TStartupInfo));
              if (not CreateProcessWithLogonW(PWideChar(AUsername), PWideChar(ADomain), PWideChar(APassword), LOGON_WITH_PROFILE, nil, PWideChar(ACommandLine), CREATE_UNICODE_ENVIRONMENT, nil, PWideChar(String(cUserProfile)), startupInfo, AProcessInfo)) and
                 (not CreateProcessWithLogonW(PWideChar(AUsername), PWideChar(ADomain), PWideChar(APassword), LOGON_NETCREDENTIALS_ONLY, nil, PWideChar(ACommandLine), CREATE_UNICODE_ENVIRONMENT, nil, PWideChar(String(cUserProfile)), startupInfo, AProcessInfo)) then
                result := GetLastError;
            end
            else
              result := GetLastError;
          end
          else
            result := GetLastError;
        end
        else
          result := GetLastError;
      end
      else
        result := GetLastError;
    end;
  finally
    for C1 := 0 to LIB_COUNT - 1 do
      if LIB_HANDLES[C1] <> 0 then
        FreeLibrary(LIB_HANDLES[C1]);
  end;
end;

procedure ShortCutToHotKey(const AHotKey: TShortCut; var AKey: Word; var AModifiers: UINT);
var
  shift: TShiftState;
begin
  ShortCutToKey(AHotKey, AKey, shift);
  AModifiers := 0;
  if (ssShift in shift) then
    AModifiers := AModifiers or MOD_SHIFT;
  if (ssAlt in shift) then
    AModifiers := AModifiers or MOD_ALT;
  if (ssCtrl in shift) then
    AModifiers := AModifiers or MOD_CONTROL;
end;



initialization
  ProcessStartTime := GetTickCount;

end.

