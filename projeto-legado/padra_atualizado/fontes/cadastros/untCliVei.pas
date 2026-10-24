unit untCliVei;

interface

uses SysUtils, Uni, Contnrs, Classes;

Type

TCliVei = class(TComponent)
  private
    FAutInc: String;
    FCodCli: String;
    FPlaVei: String;
    FModVei: String;
    FMarVei: String;
    FCorVei: String;
    FAnoVei: String;
    FVeiAti: String;

    qryCliVei: TUniQuery;

    procedure pZeraValores;
    procedure pAtualizaDadosVeiculo;

  protected
    procedure setCodCli(const Value: String);
    procedure setPlaVei(const Value: String);
    procedure setVeiAti(const Value: String);
  public

    Constructor Create(AOwner: TComponent); reintroduce; overload;
    Constructor Create(AOwner: TComponent; Const strCodCli, strAutInc: String); reintroduce; overload;
    Destructor Destroy; override;

    procedure pInsereCliVei;
    class procedure pApagarCliVei(const strCodCli: String);
    class function fRetVeiculos(const strCodCli: String): TObjectList;
    class procedure pDesvinculaVeiculo(const strCodCli, strPlaVei: string);

    property strCodCli: String Read FCodCli Write setCodCli;
    property strPlaVei: String Read FPlaVei Write setPlaVei;
    property strVeiAti: String Read FVeiAti Write setVeiAti;
    property strAnoVei: String Read FAnoVei;
    property strCorVei: String Read FCorVei;
    property strModVei: String Read FModVei;
    property strMarVei: String Read FMarVei;
    property strAutInc: String Read FAutInc;

  End;

implementation

uses  untFuncoesSimples, untConstantes, Data.DB, untTypesSistema;

{ TCliVei }

constructor TCliVei.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  qryCliVei := fCriaQuery(Self);
  pZeraValores;
end;

constructor TCliVei.Create(AOwner: TComponent; const strCodCli, strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  inherited Create(AOwner);
  qryCliVei := fCriaQuery(Self);
  qryAux    := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT                            ');
  qryAux.SQL.Add('  CLI_CODCLI,                     ');
  qryAux.SQL.Add('  CLI_PLAVEI,                     ');
  qryAux.SQL.Add('  CLI_VEIATI                      ');
  qryAux.SQL.Add('FROM                              ');
  qryAux.SQL.Add('  CLIVEI                          ');
  qryAux.SQL.Add('WHERE                             ');
  qryAux.SQL.Add('  CLI_CODCLI = :CODCLI AND        ');
  qryAux.SQL.Add('  AUTOINCREM = :AUTINC            ');

  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    FCodCli := qryAux.FieldByName('CLI_CODCLI').AsString;
    FPlaVei := qryAux.FieldByName('CLI_PLAVEI').AsString;
    FVeiAti := qryAux.FieldByName('CLI_VEIATI').AsString;

    pAtualizaDadosVeiculo;
  End;

  FreeAndNil(qryAux);
end;

procedure TCliVei.pAtualizaDadosVeiculo;
  Var
    qryAux: TUniQuery;
begin
  qryAux    := fCriaQuery(Self);

  qryAux.SQL.Add('SELECT         ');
  qryAux.SQL.Add('  CLIVEI.AUTOINCREM,  ');
  qryAux.SQL.Add('  VEI_ANOVEI,  ');
  qryAux.SQL.Add('  COR_DESCOR,  ');
  qryAux.SQL.Add('  MAR_DESMAR,  ');
  qryAux.SQL.Add('  MOD_DESMOD   ');
  qryAux.SQL.Add('FROM           ');
  qryAux.SQL.Add('  CADVEI       ');
  qryAux.SQL.Add('  LEFT JOIN CORVEI ON VEI_CODCOR = COR_CODCOR ');
  qryAux.SQL.Add('  LEFT JOIN MARVEI ON VEI_CODMAR = MAR_CODMAR ');
  qryAux.SQL.Add('  LEFT JOIN MODVEI ON VEI_CODMOD = MOD_CODMOD ');
  qryAux.SQL.Add('  LEFT JOIN CLIVEI ON (CLIVEI.CLI_PLAVEI = :PLAVEI AND CLIVEI.CLI_CODCLI = :CODCLI) ');

  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  VEI_PLAVEI = :PLAVEI ');

  qryAux.ParamByName('PLAVEI').AsString := FPlaVei;
  qryAux.ParamByName('CODCLI').AsString := FCodCli;
  qryAux.Open;

  FAutInc := qryAux.FieldByName('AUTOINCREM').AsString;
  FAnoVei := qryAux.FieldByName('VEI_ANOVEI').AsString;
  FCorVei := qryAux.FieldByName('COR_DESCOR').AsString;
  FMarVei := qryAux.FieldByName('MAR_DESMAR').AsString;
  FModVei := qryAux.FieldByName('MOD_DESMOD').AsString;

  FreeAndNil(qryAux);
end;

class procedure TCliVei.pDesvinculaVeiculo(const strCodCli, strPlaVei: string);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('DELETE FROM CLIVEI WHERE CLI_CODCLI = :CODCLI AND CLI_PLAVEI = :PLAVEI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('PLAVEI').AsString := strPlaVei;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

destructor TCliVei.Destroy;
begin
  inherited;
end;

class function TCliVei.fRetVeiculos(const strCodCli: String): TObjectList;
  Var
    qryAux: TUniQuery;
begin
  Result := TObjectList.Create(True);
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT AUTOINCREM FROM CLIVEI WHERE CLI_CODCLI = :CODCLI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TCliVei.Create(nil, strCodCli, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

class procedure TCliVei.pApagarCliVei(const strCodCli: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('DELETE FROM CLIVEI WHERE CLI_CODCLI = :CODCLI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TCliVei.pInsereCliVei;
begin
  setCodCli(FCodCli);
  setPlaVei(FPlaVei);
  setVeiAti(FVeiAti);

  qryCliVei.Close;
  qryCliVei.SQL.Clear;
  qryCliVei.SQL.Add('INSERT INTO CLIVEI  ');
  qryCliVei.SQL.Add('(                   ');
  qryCliVei.SQL.Add('  CLI_CODCLI,       ');
  qryCliVei.SQL.Add('  CLI_PLAVEI,       ');
  qryCliVei.SQL.Add('  CLI_VEIATI,       ');
  qryCliVei.SQL.Add('  AUTOINCREM        ');
  qryCliVei.SQL.Add(') VALUES (          ');
  qryCliVei.SQL.Add('  :CODCLI,          ');
  qryCliVei.SQL.Add('  :PLAVEI,          ');
  qryCliVei.SQL.Add('  :VEIATI,          ');
  qryCliVei.SQL.Add('  :AUTINC)          ');

  qryCliVei.ParamByName('CODCLI').AsString := FCodCli;
  qryCliVei.ParamByName('PLAVEI').AsString := FPlaVei;
  qryCliVei.ParamByName('VEIATI').AsString := FVeiAti;

  if Trim(FAutInc) <> '' then
    qryCliVei.ParamByName('AUTINC').AsString := FAutInc
  else
    qryCliVei.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIVEI', VS_strCodEmp);

  qryCliVei.ExecSQL;
  qryCliVei.Close;
end;

procedure TCliVei.pZeraValores;
begin
  FAutInc := '';
  FCodCli := '';
  FPlaVei := '';
  FModVei := '';
  FMarVei := '';
  FCorVei := '';
  FAnoVei := '';
  FVeiAti := '';
end;

procedure TCliVei.setVeiAti(const Value: String);
begin
  If Pos(Value, 'S_N_') <= 0 Then
    Raise ExceptionAutCom.Create('O campo ativo deve ser (S)im ou (N)ão!');
  FVeiAti := Value;
end;

procedure TCliVei.setCodCli(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Cliente tem que ser preenchido!');

  If (fEmptyStr(fRetNomCliente(Value))) Then
    Raise ExceptionAutCom.Create('O Cliente informado não existe!');

  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TCliVei.setPlaVei(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('A Placa do veículo deve ser informada!');

  If (fEmptyStr(fRetornaDescricaoVeic(Value))) Then
    Raise ExceptionAutCom.Create('Nenhum veículo cadastrado com esta Placa!');

  FPlaVei := Value;
  pAtualizaDadosVeiculo;
end;

end.
