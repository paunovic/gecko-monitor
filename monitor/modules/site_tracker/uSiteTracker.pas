unit uSiteTracker;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  PerlRegEx;

type
  TSiteNewHost = procedure(Sender: TObject; const AHost, AResource, AReferer: String) of object;

  TSiteTracker = class
                 private
                   FOnNewHost: TSiteNewHost;
                   FRegEx    : TPerlRegEx;
                 protected
                 public
                   constructor Create;
                   destructor Destroy; override;

                   procedure ParseData(const ABuffer : TMemoryStream);

                   property OnNewHost: TSiteNewHost read FOnNewHost write FOnNewHost;
                 end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  uCommon;

constructor TSiteTracker.Create;
begin
  FRegEx := TPerlRegEx.Create;
  FRegEx.Options := FRegEx.Options + [preSingleLine];
  FRegEx.RegEx := 'GET\ .*\/[0-9]\.[0-9].*Host:\ .*(?:(?!GET\ .*HTTP))+';
end;

destructor TSiteTracker.Destroy;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FRegEx.Free;

  inherited;
end;

procedure TSiteTracker.ParseData(const ABuffer: TMemoryStream);
var
  host    : String;
  resource: String;
  referer : String;
  regstr  : String;
  str     : AnsiString;
begin
  SetLength(str, ABuffer.Size);
  ABuffer.ReadBuffer(str[1], ABuffer.Size);
  str := StripNonAsciiExceptCRLF(str);

  FRegEx.Subject := UTF8String(str);

  FRegEx.Match;
  while FRegEx.FoundMatch do
  begin
    regstr := String(FRegEx.MatchedText);

    resource := regstr;

    Delete(resource, 1, 4);
    resource := Copy(resource, 1, Pos(' ', resource) - 1);
    if resource = '/' then
      resource := '';

    host := regstr;
    Delete(host, 1, Pos('Host: ', host) + 5);
    host := Copy(host, 1, Pos(#$D, host) - 1);

    if Pos('Referer: ', regstr) > 0 then
    begin
      referer := regstr;
      Delete(referer, 1, Pos('Referer: ', referer) + 8);
      referer := Copy(referer, 1, Pos(#$D, referer) - 1);
    end;

    if Assigned(FOnNewHost) then
      FOnNewHost(self, host, resource, referer);

    FRegEx.MatchAgain;
  end;
end;

end.
