unit uStartup;

interface

type
  TStartup = class
               class function Install: Boolean;
               class procedure Uninstall;
             end;

implementation

uses
  Winapi.Windows, System.Win.Registry, System.SysUtils;

const
  KEY_ROOT = HKEY_LOCAL_MACHINE;
  KEY_PATH = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Run';
  KEY_NAME = 'Windows USB Compliance Driver';

class function TStartup.Install: Boolean;
var
  reg: TRegistry;
begin
  result := FALSE;
  reg := TRegistry.Create;
  try
    reg.RootKey := KEY_ROOT;
    if reg.OpenKey(KEY_PATH, TRUE) then
    begin
      reg.WriteString(KEY_NAME, Format('"%s"', [ParamStr(0)]));
      reg.CloseKey;
      Exit(TRUE);
    end;
  finally
    reg.Free;
  end;
end;

class procedure TStartup.Uninstall;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := KEY_ROOT;
    if reg.OpenKey(KEY_PATH, TRUE) then
    begin
      reg.DeleteValue(KEY_NAME);
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
end;

end.
