unit untCliPro;

interface


uses SysUtils, Uni, Contnrs, Classes, cxProgressBar, ExtCtrls, Forms, StdCtrls,
  UniClientDataSet, UniDataSetProvider, System.Variants;


Type

  TCliPro = class(TComponent)
  private
    FAutInc: String;
    FCodCli: String;
    FCodPro: String;
    FNomPro: String;
    FCodUni: String;
    FDesUni: String;
    FUnidad: String;
    FCod_NF: String;
    FCodBar: String;
    FDes_NF: String;

    qryCliPro: TUniQuery;
    qryConPro: TUniQuery;

    function getAutInc: String;
    function getCodCli: String;
    function getCodPro: String;
    function getNomPro: String;
    function getCodUni: String;
    function getDesUni: String;
    function getUnidad: String;
    function getCod_NF: String;
    function getCodBar: String;
    function getDes_NF: String;

    procedure setAutInc(const Value: String);
    procedure setCodCli(const Value: String);
    procedure setCodPro(const Value: String);
    procedure setCodUni(const Value: String);
    procedure setDesUni(const Value: String);
    procedure setUnidad(const Value: String);
    procedure setNomPro(const Value: String);
    procedure setCod_NF(const Value: String);
    procedure setCodBar(const Value: String);
    procedure setDes_NF(const Value: String);

    procedure pZeraValores;
    function fRemoveQuebraLinha(const strTexto: String): String;
    class procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);

  protected

  public

    Constructor Create(AOwner: TComponent); reintroduce; overload;
    Constructor Create(AOwner: TComponent; Const strCodCli, strCodPro, strNomPro, strCodUni, strDesUni, strSigUni, strCod_NF, strCodBar: String); reintroduce; overload;
    Destructor Destroy; override;

    procedure pInsereCliPro;
    function fRetProdutos(const strCodCli: String; Var cdsCliPro: TUniClientDataSet; Var dspCliPro: TUniDataSetProvider; pgbProgresso: TcxProgressBar): Boolean;

    class procedure pApagarCadPro(const strCodCli: String);

    property strAutInc: String Read getAutInc Write setAutInc;
    property strCodCli: String Read getCodCli Write setCodCli;
    property strCodPro: String Read getCodPro Write setCodPro;
    property strNomPro: String Read getNomPro Write setNomPro;
    property strCodUni: String Read getCodUni Write setCodUni;
    property strDesUni: String Read getDesUni Write setDesUni;
    property strUnidad: String Read getUnidad Write setUnidad;
    property strCod_NF: String Read getCod_NF Write setCod_NF;
    property strCodBar: String Read getCodBar Write setCodBar;
    property strDes_NF: String Read getDes_NF Write setDes_NF;

  End;

implementation

uses untFuncoesSimples, untFuncoes, StrUtils;


{ TCliPro }

constructor TCliPro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  qryCliPro := fCriaQuery(Self);
  qryConPro := fCriaQuery(Self);
  pZeraValores;
end;

constructor TCliPro.Create(AOwner: TComponent; const strCodCli, strCodPro,
  strNomPro, strCodUni, strDesUni, strSigUni, strCod_NF, strCodBar : String);
begin
  inherited Create(AOwner);

  qryCliPro := fCriaQuery(Self);

  FCodCli := strCodCli;
  FCodPro := strCodPro;
  FNomPro := strNomPro;
  FCodUni := strCodUni;
  FDesUni := strDesUni;
  FUnidad := strSigUni;
  FCod_NF := strCod_NF;
  FCodBar := strCodBar;
  FDes_NF := strDes_NF;
end;

destructor TCliPro.Destroy;
begin
  inherited;
end;

function TCliPro.fRemoveQuebraLinha(const strTexto: String): String;
begin
  Result := AnsiReplaceStr(AnsiLowerCase(strTexto), '\n', '');
end;

function TCliPro.fRetProdutos(const strCodCli: String;  Var cdsCliPro: TUniClientDataSet; Var dspCliPro: TUniDataSetProvider; pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := false;
  Try

    if (pgbProgresso <> nil) then
      pInfoStatusGravacao('Aguarde...Preparando produtos relacionados: ', pgbProgresso);

    qryConPro.Close;
    qryConPro.SQL.Clear;
    qryConPro.SQL.Add('SELECT');
    qryConPro.SQL.Add('  CLIPRO.AUTOINCREM AS AUTINC, ');
    qryConPro.SQL.Add('  CLI_CODCLI AS CODCLI,');
    qryConPro.SQL.Add('  CLI_CODITE AS CODPRO,');
    qryConPro.SQL.Add('  ITE_DESITE AS NOMPRO,');
    qryConPro.SQL.Add('  COALESCE(CLI_CODUNI, ITE_CODUNI) AS CODUNI,');
    qryConPro.SQL.Add('  UNI_DESUNI AS DESUNI,');
    qryConPro.SQL.Add('  UNI_SIGUNI AS UNIDAD,');
    qryConPro.SQL.Add('  CLI_COD_NF AS COD_NF,');
    qryConPro.SQL.Add('  CLI_CODBAR AS CODBAR,');
    qryConPro.SQL.Add('  CLI_DES_NF AS DES_NF ');
    qryConPro.SQL.Add('FROM');
    qryConPro.SQL.Add('  CLIPRO');
    qryConPro.SQL.Add('  JOIN CADITE ON ITE_CODITE = CLI_CODITE');
    qryConPro.SQL.Add('  LEFT JOIN CADUNI ON UNI_CODUNI = COALESCE(CLI_CODUNI, ITE_CODUNI)');
    qryConPro.SQL.Add('WHERE');
    qryConPro.SQL.Add('  CLI_CODCLI = :CODCLI');

    qryConPro.ParamByName('CODCLI').AsString := strCodCli;
    qryConPro.Open;
    pSetaClient(qryConPro);

    dspCliPro.DataSet := qryConPro;
    cdsCliPro.SetProvider(dspCliPro);

    cdsCliPro.Close;
    dspCliPro.DataSet := qryConPro;
    cdsCliPro.SetProvider(dspCliPro);
    cdsCliPro.Open;
    pSetaClient(cdsCliPro);

  Finally

  End;
end;

function TCliPro.getCod_NF: String;
begin
  Result := FCod_NF;
end;

function TCliPro.getDes_NF: String;
begin
  Result := FDes_NF;
end;

function TCliPro.getAutInc: String;
begin
  Result := FAutInc;
end;

function TCliPro.getCodBar: String;
begin
  Result := FCodBar;
end;

function TCliPro.getCodCli: String;
begin
  Result := FCodCli;
end;

function TCliPro.getCodPro: String;
begin
  Result := FCodPro;
end;

function TCliPro.getNomPro: String;
begin
  Result := FNomPro;
end;

class procedure TCliPro.pApagarCadPro(const strCodCli: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('DELETE FROM CLIPRO WHERE CLI_CODCLI = :CODCLI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TCliPro.pInsereCliPro;
begin
  qryCliPro.Close;
  qryCliPro.SQL.Clear;
  qryCliPro.SQL.Add('INSERT INTO CLIPRO  ');
  qryCliPro.SQL.Add('(                   ');
  qryCliPro.SQL.Add('  CLI_CODCLI,       ');
  qryCliPro.SQL.Add('  CLI_CODITE,       ');
  qryCliPro.SQL.Add('  CLI_COD_NF,       ');
  qryCliPro.SQL.Add('  CLI_CODBAR,       ');
  qryCliPro.SQL.Add('  CLI_CODEMP,       ');
  qryCliPro.SQL.Add('  CLI_DES_NF,       ');
  qryCliPro.SQL.Add('  CLI_CODUNI,       ');
  qryCliPro.SQL.Add('  AUTOINCREM        ');
  qryCliPro.SQL.Add(') VALUES (          ');
  qryCliPro.SQL.Add('  :CODCLI,          ');
  qryCliPro.SQL.Add('  :CODITE,          ');
  qryCliPro.SQL.Add('  :COD_NF,          ');
  qryCliPro.SQL.Add('  :CODBAR,          ');
  qryCliPro.SQL.Add('  :CODEMP,          ');
  qryCliPro.SQL.Add('  :DES_NF,          ');
  qryCliPro.SQL.Add('  :CODUNI,          ');
  qryCliPro.SQL.Add('  :AUTINC)          ');

  qryCliPro.ParamByName('CODCLI').AsString := FCodCli;
  qryCliPro.ParamByName('CODITE').AsString := fRemoveQuebraLinha(FCodPro);
  qryCliPro.ParamByName('COD_NF').AsString := fRemoveQuebraLinha(FCod_NF);
  qryCliPro.ParamByName('CODBAR').AsString := fRemoveQuebraLinha(FCodBar);
  qryCliPro.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If (Not fEmptyStr(FCodUni)) Then
    qryCliPro.ParamByName('CODUNI').AsString := FCodUni
  Else
    qryCliPro.ParamByName('CODUNI').Value    := Null;

  if (Trim(FAutInc) <> '') then
    qryCliPro.ParamByName('AUTINC').AsString := FAutInc
  else
    qryCliPro.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIPRO', VS_strCodEmp);

  FDes_NF := fRemoveQuebraLinha(FDes_NF);

  If (Not fEmptyStr(FDes_NF)) Then
    qryCliPro.ParamByName('DES_NF').AsString := FDes_NF
  Else
    qryCliPro.ParamByName('DES_NF').Value    := Null;

  qryCliPro.ExecSQL;
  qryCliPro.Close;
end;

procedure TCliPro.pZeraValores;
begin
  FAutInc := '';
  FCodCli := '';
  FCodPro := '';
  FNomPro := '';
  FCodUni := '';
  FDesUni := '';
  FUnidad := '';
  FCod_NF := '';
  FCodBar := '';
  FDes_NF := '';
end;

procedure TCliPro.setCod_NF(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('O Código de impressão na NF tem que ser preenchido!');

  If (FCod_NF <> Value) Then
    FCod_NF := Value;
end;

procedure TCliPro.setDes_NF(const Value: String);
begin
  FDes_NF := Value;
end;

procedure TCliPro.setAutInc(const Value: String);
begin
  If (FAutInc <> Value) Then
    FAutInc := Value;
end;

procedure TCliPro.setCodBar(const Value: String);
begin
  FCodBar := Value;
end;

procedure TCliPro.setCodCli(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('O Cliente tem que ser preenchido!');

  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TCliPro.setCodPro(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pRaise('O Código do Item tem que ser preenchido!');

  If (FCodPro <> Value) Then
    FCodPro := Value;
end;

procedure TCliPro.setNomPro(const Value: String);
begin
  If (FNomPro <> Value) Then
    FNomPro := Value;
end;

function TCliPro.getCodUni: String;
begin
  Result := FCodUni;
end;

function TCliPro.getDesUni: String;
begin
  Result := FDesUni;
end;

function TCliPro.getUnidad: String;
begin
  Result := FUnidad;
end;

procedure TCliPro.setCodUni(const Value: String);
begin
  If (FCodUni <> Value) Then
    FCodUni := Value;
end;

procedure TCliPro.setDesUni(const Value: String);
begin
  If (FDesUni <> Value) Then
    FDesUni := Value;
end;

procedure TCliPro.setUnidad(const Value: String);
begin
  If (FUnidad <> Value) Then
    FUnidad := Value;
end;

class procedure TCliPro.pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
End;

end.
