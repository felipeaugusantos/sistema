unit Genericos.Classes.OcultaTelas;

interface

uses Vcl.ExtCtrls, System.Classes, Uni, untFuncoesSimples, System.SysUtils, Winapi.Windows, Vcl.Dialogs, Messages;

Type
  TOcultaTelas = class
  private
    stlTelas: TStringList;
    stlTeclaEnvio: TStringList;
    tmrTimer: TTimer;

    procedure pCarregarTelas(strTipoTelas: string);
    procedure pTimer(Sender: TObject);

  public
    constructor Create(strTipoTelas: string);
    destructor Destroy; override;

    procedure Start;
    procedure Stop;
  end;

implementation

{ TOcultaTelas }

constructor TOcultaTelas.Create(strTipoTelas: string);
begin
  Self.stlTelas := TStringList.Create;
  Self.stlTeclaEnvio := TStringList.Create;
  pCarregarTelas(strTipoTelas);
end;

destructor TOcultaTelas.Destroy;
begin
  FreeAndNil(Self.stlTelas);
  FreeAndNil(Self.stlTeclaEnvio);
  if Assigned(Self.tmrTimer) then
    Self.tmrTimer.Destroy;

  inherited;
end;

procedure TOcultaTelas.pCarregarTelas(strTipoTelas: string);
var
  qryTelas: TUniQuery;
begin
  qryTelas := fCriaQuery();
  try
    qryTelas.SQL.Text := 'SELECT TEL_NOMTEL, IFNULL(TEL_ENVTEC,"") ENVTEC FROM CADTEL WHERE TEL_TIPTEL = :TIPTEL ORDER BY TEL_ORDEM_';
    qryTelas.ParamByName('TIPTEL').AsString := strTipoTelas;
    qryTelas.Open;
    Self.stlTelas.Clear;
    while not qryTelas.Eof do
    begin
      Self.stlTelas.Add(qryTelas.FieldByName('TEL_NOMTEL').AsString);
      Self.stlTeclaEnvio.Add(qryTelas.FieldByName('ENVTEC').AsString);

      qryTelas.Next;
    end;
  finally
    FreeAndNil(qryTelas);
  end
end;

procedure TOcultaTelas.pTimer(Sender: TObject);
var
  intCont: Integer;
  strTecla: Char;
begin
  Self.tmrTimer.Enabled := False;

  for intCont := 0 to Self.stlTelas.Count -1 do
  begin
    ShowWindow(FindWindow(Nil, Pchar(Self.stlTelas[intCont])), SW_HIDE);
    if not fEmptyStr(Self.stlTeclaEnvio[intCont]) then
    begin
      strTecla := Self.stlTeclaEnvio[intCont][1];
      PostMessage(FindWindow(Nil, Pchar(Self.stlTelas[intCont])), WM_CHAR, ord(strTecla), 0);
    end;
  end;

  Self.tmrTimer.Enabled := True;
end;

procedure TOcultaTelas.Start;
begin
  if not Assigned(Self.tmrTimer) then
  begin
    Self.tmrTimer := TTimer.Create(Nil);
    Self.tmrTimer.Enabled := False;
    Self.tmrTimer.Interval := 1;
    Self.tmrTimer.OnTimer := pTimer;
  end;

  Self.tmrTimer.Enabled := True;
end;

procedure TOcultaTelas.Stop;
begin
  Self.tmrTimer.Enabled := False;
end;

end.
