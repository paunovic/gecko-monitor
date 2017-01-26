unit uScreenshotter;

interface

uses
  Winapi.Windows, Vcl.ExtCtrls, Vcl.Graphics, Vcl.Imaging.JPEG;

type
  TScreenshotterNewScreenshot = procedure(Sender: TObject; const AScreenshot : TJPEGImage) of object;

  TScreenshotter = class
                   private
                     const
                       CAPTUREBLT = $40000000;

                     var
                       FIntervalTimer  : TTimer;
                       FScreenshotMode : Integer;

                       FOnNewScreenshot: TScreenshotterNewScreenshot;

                     procedure TakeScreenshot(ABitmap: Vcl.Graphics.TBitmap; const AWindowHandle: HWND = 0); overload;
                     procedure IntervalTimerTimer(Sender: TObject);
                   protected
                   public
                     constructor Create;
                     destructor Destroy; override;

                     procedure TakeScreenshot(const AWindowHandle: HWND = 0); overload;

                     property IntervalTimer : TTimer read FIntervalTimer;
                     property ScreenshotMode: Integer read FScreenshotMode write FScreenshotMode;
                     property OnNewScreenhot: TScreenshotterNewScreenshot read FOnNewScreenshot write FOnNewScreenshot;
                   end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  Vcl.Forms,
  uCommon;


constructor TScreenshotter.Create;
begin
  FIntervalTimer := TTimer.Create(nil);
  FIntervalTimer.OnTimer := IntervalTimerTimer;
  FIntervalTimer.Enabled := FALSE;
end;

destructor TScreenshotter.Destroy;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  FIntervalTimer.Free;

  inherited;
end;

procedure TScreenshotter.TakeScreenshot(ABitmap: Vcl.Graphics.TBitmap; const AWindowHandle : HWND = 0);
var
  DC     : HDC;
  winRect: TRect;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  if AWindowHandle = 0 then
  begin
    DC := GetDC(0);
    winRect := Screen.DesktopRect;
  end
  else
  begin
    DC := GetWindowDC(AWindowHandle);
    GetWindowRect(AWindowHandle, winRect);
  end;

  ABitmap.Canvas.Lock;
  try
    ABitmap.Width := winRect.Width;
    ABitmap.Height := winRect.Height;
    BitBlt(ABitmap.Canvas.Handle, 0, 0, ABitmap.Width, ABitmap.Height, DC, 0, 0, SRCCOPY or CAPTUREBLT);
  finally
    ABitmap.Canvas.Unlock;
    ReleaseDC(AWindowHandle, DC);
  end;
end;

procedure TScreenshotter.TakeScreenshot(const AWindowHandle: HWND = 0);
var
  bmp: TBitmap;
  jpg: TJPEGImage;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  bmp := TBitmap.Create;
  try
    TakeScreenshot(bmp, AWindowHandle);
    jpg := TJPEGImage.Create;
    try
      jpg.Assign(bmp);
      if Assigned(FOnNewScreenshot) then
        FOnNewScreenshot(self, jpg);
    finally
      jpg.Free;
    end;
  finally
    bmp.Free;
  end;
end;

procedure TScreenshotter.IntervalTimerTimer(Sender: TObject);
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  case FScreenshotMode of
    1: TakeScreenshot;
    2: TakeScreenshot(GetForegroundWindow);
  else
    TakeScreenshot;
  end;
end;

end.
