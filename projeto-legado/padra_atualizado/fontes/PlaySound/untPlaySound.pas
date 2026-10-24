unit untPlaySound;

interface

uses Vcl.Forms, Vcl.MPlayer, System.Generics.Collections;

type
  TPlaySound = class
  private type
    TPlayer = class
    private
      FFileName: String;
      FLoaded: Boolean;
      FForm: TForm;
      FMediaPlayer: TMediaPlayer;
    private
      procedure LoadFile;
      procedure Execute;
    public
      class function New(AFileName: String): TPlaySound.TPlayer;
      destructor Destroy; override;
    end;
  public type
    Cache = class
    private
      class var Players: TDictionary<String, TPlaySound.TPlayer>;
    public
      class function Find(AFile: String): TPlayer;
      class procedure Clear;
      class procedure Add(AContainer: TPlaySound.TPlayer);
    end;
  public
    class procedure Execute(AFileName: String);
  end;

implementation

uses System.SysUtils;

{ TPlaySound }

class procedure TPlaySound.Execute(AFileName: String);
var
  LContainer: TPlaySound.TPlayer;
begin
  LContainer := TPlaySound.Cache.Find(AFileName);

  If Not Assigned(LContainer) Then
  Begin
    LContainer := TPlaySound.TPlayer.New(AFileName);
    TPlaySound.Cache.Add(LContainer);
  End;

  LContainer.LoadFile;

  LContainer.Execute;
end;

{ TPlaySound.Container }

destructor TPlaySound.TPlayer.Destroy;
begin
  FMediaPlayer.Close;
  FMediaPlayer.Destroy;
  FForm.Destroy;
  inherited;
end;

procedure TPlaySound.TPlayer.Execute;
begin
  FMediaPlayer.Wait := True;
  FMediaPlayer.play;
end;

procedure TPlaySound.TPlayer.LoadFile;
begin
  If Not FLoaded Then
  Begin
    FMediaPlayer.Open;
    FLoaded := True;
  End;
end;

class function TPlaySound.TPlayer.New(AFileName: String): TPlaySound.TPlayer;
begin
  Result := TPlaySound.TPlayer.Create;
  Result.FForm := TForm.Create(nil);
  Result.FFileName := AFileName;
  Result.FLoaded := False;
  Result.FMediaPlayer := TMediaPlayer.Create(Result.FForm);
  Result.FMediaPlayer.Parent := Result.FForm;
  Result.FMediaPlayer.DeviceType := dtAutoSelect;
  Result.FMediaPlayer.FileName := AFileName;
end;

{ TPlaySound.Cache }

class procedure TPlaySound.Cache.Add(AContainer: TPlaySound.TPlayer);
begin
  Players.AddOrSetValue(AContainer.FFileName, AContainer);
end;

class procedure TPlaySound.Cache.Clear;
Var
  LContainer: TPlaySound.TPlayer;
begin
  For LContainer In Players.Values Do
    LContainer.Destroy;
  Players.Clear;
end;

class function TPlaySound.Cache.Find(AFile: String): TPlayer;
begin
  Result := nil;
  If Players.ContainsKey(AFile) Then
    Result := Players[AFile];
end;

initialization

TPlaySound.Cache.Players := TDictionary<String, TPlaySound.TPlayer>.Create;

finalization

  TPlaySound.Cache.Clear;
  FreeAndNil(TPlaySound.Cache.Players);

end.
