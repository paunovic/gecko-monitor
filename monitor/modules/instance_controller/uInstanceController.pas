unit uInstanceController;

interface

type
  TInstanceController = class
                        private
                          const MUTEX_NAME = 'GeckoInstanceController';
                          class var FMutex: THandle;
                        public
                          class function IsAlphaInstance: Boolean;
                          class procedure RegisterInstance;
                          class procedure UnregisterInstance;
                        end;

implementation

uses
  Winapi.Windows;

class function TInstanceController.IsAlphaInstance: Boolean;
var
  hMutex: THandle;
begin
  hMutex := OpenMutex(SYNCHRONIZE, FALSE, MUTEX_NAME);
  if hMutex <> 0 then
  begin
    CloseHandle(hMutex);
    result := FALSE;
  end
  else
    result := TRUE;
end;

class procedure TInstanceController.RegisterInstance;
begin
  FMutex := CreateMutex(nil, FALSE, MUTEX_NAME);
end;

class procedure TInstanceController.UnregisterInstance;
begin
  ReleaseMutex(FMutex);
end;

end.
