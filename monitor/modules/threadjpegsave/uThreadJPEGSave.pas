unit uThreadJPEGSave;

interface

uses
  Vcl.Imaging.JPEG, System.Classes;

type
  PThreadImageInfo = ^TThreadImageInfo;
  TThreadImageInfo = record
                       Image   : TJPEGImage;
                       Filename: String;
                     end;

  TThreadJPEGSave = class(TThread)
                    private
                      FImageList: TThreadList;
                    protected
                      procedure Execute; override;
                    public
                      constructor Create;
                      destructor Destroy; override;

                      procedure Add(const AImage: TJPEGImage; AFilename: String);
                    end;

implementation

uses
  {$IFDEF DEBUG} JclDebug, {$ENDIF}
  System.SysUtils,
  uCommon;

constructor TThreadJPEGSave.Create;
begin
  inherited Create(TRUE);
  FreeOnTerminate := TRUE;

  FImageList := TThreadList.Create;
end;

destructor TThreadJPEGSave.Destroy;
var
  C1: Integer;
  L : TList;
begin
  L := FImageList.LockList;
  try
    for C1 := 0 to L.Count - 1 do
    begin
      PThreadImageInfo(L[C1])^.Image.Free;
      Dispose(PThreadImageInfo(L[C1]));
    end;
  finally
    FImageList.UnlockList;
  end;
  FImageList.Free;

  inherited;
end;

procedure TThreadJPEGSave.Add(const AImage: TJPEGImage; AFilename: String);
var
  L   : TList;
  item: PThreadImageInfo;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  Assert(Assigned(FImageList), 'Image list not assigned');
  L := FImageList.LockList;
  Assert(Assigned(L), 'LockList not assigned');
  try
    New(item);
    item^.Image := TJPEGImage.Create;
    item^.Image.Assign(AImage);
    item^.Filename := AFilename;
    L.Add(item);
  finally
    FImageList.UnlockList;
  end;
end;

procedure TThreadJPEGSave.Execute;
var
  L   : TList;
  item: PThreadImageInfo;
begin
  {$IFDEF DEBUG} Debug(ModuleByLevel, ProcByLevel); {$ENDIF}

  while not Terminated do
  begin
    L := FImageList.LockList;
    try
      if L.Count > 0 then
      begin
        item := PThreadImageInfo(L[0]);

        if not DirectoryExists(ExtractFilePath(item^.Filename)) then
          ForceDirectories(ExtractFilePath(item^.Filename));

        item^.Image.SaveToFile(item^.Filename);
        item^.Image.Free;
        Dispose(item);
        L.Delete(0);
      end;
    finally
      FImageList.UnlockList;
    end;

    Sleep(100);
  end;
end;

end.
