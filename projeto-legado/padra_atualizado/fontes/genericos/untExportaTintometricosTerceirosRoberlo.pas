unit untExportaTintometricosTerceirosRoberlo;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
   Uni, SysUtils, Variants, Classes,
   untThreadExportacaoTerceiros, DateUtils,
   untExportaTintometricosTerceirosAutomotiva, DB, Math, StrUtils,
   FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
   FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
   FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
   FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
   FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosRoberlo = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProRob: String; //Produto de venda Roberlo
    stlDiluentes: TStringList;
    strAcrMob: String;
    blnDiluido: Boolean;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  Public
    function fNomeTabela(): String; Override;
    function fQuantidadeFormulacao(): Integer; Override;
    function fCamposTabela(): String; Override;
    function fCamposSelect(): String; Override;
    function fFatorTinta(): Double; Override;
    function fRetDescricao(): String; Override;
    function fRetItemBase(): String; Override;
    function fRetMD5KEY(): String; Override;
    function fRetFormula(intCont: Integer): String; Override;
    function fRetQuantidade(intCont: Integer): String; Override;
    function fSQLInsert(): String; Override;
    function fRetornaColorantes(): String; Override;
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fRetTipoCor(): String; Override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; arrComponentes: Array of TComp; intEmb: Integer); Reintroduce;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); Override;

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemCP(): String;
    function fRetItemVenda(Conexao: TUniConnection): String;
    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '50'): Double;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure pPreencheArrayEmbalagem;
    procedure pCarregarDados;
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;


implementation

{ TExportaTintometricosTerceirosRoberlo }

constructor TExportaTintometricosTerceirosRoberlo.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProRob := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
  pCarregarDados;
end;

destructor TExportaTintometricosTerceirosRoberlo.Destroy;
begin
  inherited;

  If Assigned(stlDiluentes) Then
    FreeAndNil(stlDiluentes);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);
end;

procedure TExportaTintometricosTerceirosRoberlo.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosRoberlo.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    ROB_CODIGO,           ';
  Result := Result + '    ROB_SERIE_,           ';
  Result := Result + '    ROB_MARCA_,           ';
  Result := Result + '    ROB_NOMCOR,           ';
  Result := Result + '    ROB_GRUCOR,           ';
  Result := Result + '    ROB_CAMADA,           ';
  Result := Result + '    ROB_CATALO,           ';
  Result := Result + '    ROB_MODELO,           ';
  Result := Result + '    ROB_REGIAO,           ';
  Result := Result + '    ROB_DTACAD,           ';
  Result := Result + '    ROB_VARIAN,           ';
  Result := Result + '    ROB_CODCOR,           ';
  Result := Result + '    ROB_ACRMOB,           ';
  Result := Result + '    ROB_ANOINI,           ';
  Result := Result + '    ROB_ANOFIN,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    ROB_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    ROB_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    ROB_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    ROB_CADROB            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE                  ';
end;

function TExportaTintometricosTerceirosRoberlo.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    ROB_CODIGO VARCHAR(15),         ';
  Result := Result + '    ROB_SERIE_ VARCHAR(20),         ';
  Result := Result + '    ROB_MARCA_ VARCHAR(30),         ';
  Result := Result + '    ROB_NOMCOR VARCHAR(50),         ';
  Result := Result + '    ROB_CODCOR VARCHAR(35),         ';
  Result := Result + '    ROB_ANOINI VARCHAR(4),          ';
  Result := Result + '    ROB_ANOFIN VARCHAR(4),          ';
  Result := Result + '    ROB_GRUCOR VARCHAR(25),         ';
  Result := Result + '    ROB_MODELO TEXT,                ';
  Result := Result + '    ROB_REGIAO VARCHAR(30),         ';
  Result := Result + '    ROB_CATALO VARCHAR(35),         ';
  Result := Result + '    ROB_MD5KEY VARCHAR(32),         ';
  Result := Result + '    ROB_CODITE VARCHAR(5),          ';
  Result := Result + '    ROB_CODDIL VARCHAR(20),         ';
  Result := Result + '    ROB_PORDIL DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRECCP DECIMAL(12,4),       ';
  Result := Result + '    ROB_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    ROB_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    ROB_PREDCP DECIMAL(12,4),       ';

  Result := Result + '    ROB_PCUSCL DECIMAL(12,4),       ';
  Result := Result + '    ROB_PCUSCG DECIMAL(12,4),       ';
  Result := Result + '    ROB_PCUSCC DECIMAL(12,4),       ';
  Result := Result + '    ROB_PCUSDL DECIMAL(12,4),       ';
  Result := Result + '    ROB_PCUSDG DECIMAL(12,4),       ';
  Result := Result + '    ROB_PCUSDC DECIMAL(12,4),       ';

  Result := Result + '    ROB_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCLT7 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDLT7 DECIMAL(12,4),       ';

  Result := Result + '    ROB_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCGL7 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDGL7 DECIMAL(12,4),       ';

  Result := Result + '    ROB_PRCCP1 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCCP2 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCCP3 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCCP4 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCCP5 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCCP6 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRCCP7 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP1 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP2 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP3 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP4 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP5 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP6 DECIMAL(12,4),       ';
  Result := Result + '    ROB_PRDCP7 DECIMAL(12,4),       ';

  Result := Result + '    ROB_EMBALT VARCHAR(5),          ';
  Result := Result + '    ROB_EMBAGL VARCHAR(5),          ';
  Result := Result + '    ROB_EMBACP VARCHAR(5),          ';
  Result := Result + '    ROB_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    ROB_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    ROB_VOLUCP DECIMAL(12,4),       ';
  Result := Result + '    ROB_PREELT DECIMAL(12,4),       ';
  Result := Result + '    ROB_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    ROB_PREECP DECIMAL(12,4),       ';
  Result := Result + '    ROB_TIPOLT CHAR(2),             ';
  Result := Result + '    ROB_TIPOGL CHAR(2),             ';
  Result := Result + '    ROB_TIPOCP CHAR(2)              ';
  Result := Result + '            );                                  ';
end;

function TExportaTintometricosTerceirosRoberlo.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosRoberlo.fNomeTabela: String;
begin
  Result := 'ROB_CADROB_SIT';
end;

function TExportaTintometricosTerceirosRoberlo.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosRoberlo.fRetDescricao: String;
begin
  Result := 'ROB_NOMCOR';
end;

function TExportaTintometricosTerceirosRoberlo.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosRoberlo.fRetEmbalagemCP: String;
begin
  Result := 'EMBCOP';
end;

function TExportaTintometricosTerceirosRoberlo.fRetEmbalagemGL: String;
begin
  Result := 'EMBGAL';
end;

function TExportaTintometricosTerceirosRoberlo.fRetEmbalagemLT: String;
begin
  Result := 'EMBLIT';
end;

function TExportaTintometricosTerceirosRoberlo.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'ROB_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosRoberlo.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosRoberlo.fRetItemVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    CFG_VALCFG            ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    CFGTIN                ';
    strSQL := strSQL + '  WHERE                   ';
    strSQL := strSQL + '    CFG_IDEPRO = "ROB" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "PROROB" AND               ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosRoberlo.fRetMD5KEY: String;
begin
  Result := 'ROB_MD5KEY';
end;

function TExportaTintometricosTerceirosRoberlo.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    BAS_CODBAS,             ';
  Result := Result + '    BAS_CODITE,             ';
  Result := Result + '    BAS_EMBALA,             ';
  Result := Result + '    BAS_PESESP,             ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                      ';
  Result := Result + '    ROB_CADBAS B            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosRoberlo.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP();
end;

function TExportaTintometricosTerceirosRoberlo.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosRoberlo.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosRoberlo.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    CFG_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGTIN              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    CFG_IDEPRO = "ROB" AND                ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := (fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosRoberlo.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosRoberlo.fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '50'): Double;
begin
  Result := ((fltVolumePro * 1000) * StrToFloat(strPercentual)) / 100
end;

function TExportaTintometricosTerceirosRoberlo.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'ROB_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosRoberlo.fRetTipoCor: String;
begin
  Result := 'ROB_MODELO';
end;

function TExportaTintometricosTerceirosRoberlo.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "ROB" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosRoberlo.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    ROB_CODIGO,           ';
  Result := Result + '    ROB_SERIE_,           ';
  Result := Result + '    ROB_MARCA_,           ';
  Result := Result + '    ROB_NOMCOR,           ';
  Result := Result + '    ROB_CODCOR,           ';
  Result := Result + '    ROB_ANOINI,           ';
  Result := Result + '    ROB_ANOFIN,           ';
  Result := Result + '    ROB_GRUCOR,           ';
  Result := Result + '    ROB_MODELO,           ';
  Result := Result + '    ROB_REGIAO,           ';
  Result := Result + '    ROB_CATALO,           ';
  Result := Result + '    ROB_MD5KEY,           ';
  Result := Result + '    ROB_CODITE,           ';
  Result := Result + '    ROB_CODDIL,           ';
  Result := Result + '    ROB_PORDIL,           ';
  Result := Result + '    ROB_PRECLT,           ';
  Result := Result + '    ROB_PRECGL,           ';
  Result := Result + '    ROB_PRECCP,           ';
  Result := Result + '    ROB_PREDLT,           ';
  Result := Result + '    ROB_PREDGL,           ';
  Result := Result + '    ROB_PREDCP,           ';

  Result := Result + '    ROB_PCUSCL,           ';
  Result := Result + '    ROB_PCUSCG,           ';
  Result := Result + '    ROB_PCUSCC,           ';
  Result := Result + '    ROB_PCUSDL,           ';
  Result := Result + '    ROB_PCUSDG,           ';
  Result := Result + '    ROB_PCUSDC,           ';

  Result := Result + '    ROB_PRCLT1,           ';
  Result := Result + '    ROB_PRCLT2,           ';
  Result := Result + '    ROB_PRCLT3,           ';
  Result := Result + '    ROB_PRCLT4,           ';
  Result := Result + '    ROB_PRCLT5,           ';
  Result := Result + '    ROB_PRCLT6,           ';
  Result := Result + '    ROB_PRCLT7,           ';
  Result := Result + '    ROB_PRDLT1,           ';
  Result := Result + '    ROB_PRDLT2,           ';
  Result := Result + '    ROB_PRDLT3,           ';
  Result := Result + '    ROB_PRDLT4,           ';
  Result := Result + '    ROB_PRDLT5,           ';
  Result := Result + '    ROB_PRDLT6,           ';
  Result := Result + '    ROB_PRDLT7,           ';

  Result := Result + '    ROB_PRCGL1,           ';
  Result := Result + '    ROB_PRCGL2,           ';
  Result := Result + '    ROB_PRCGL3,           ';
  Result := Result + '    ROB_PRCGL4,           ';
  Result := Result + '    ROB_PRCGL5,           ';
  Result := Result + '    ROB_PRCGL6,           ';
  Result := Result + '    ROB_PRCGL7,           ';
  Result := Result + '    ROB_PRDGL1,           ';
  Result := Result + '    ROB_PRDGL2,           ';
  Result := Result + '    ROB_PRDGL3,           ';
  Result := Result + '    ROB_PRDGL4,           ';
  Result := Result + '    ROB_PRDGL5,           ';
  Result := Result + '    ROB_PRDGL6,           ';
  Result := Result + '    ROB_PRDGL7,           ';

  Result := Result + '    ROB_PRCCP1,           ';
  Result := Result + '    ROB_PRCCP2,           ';
  Result := Result + '    ROB_PRCCP3,           ';
  Result := Result + '    ROB_PRCCP4,           ';
  Result := Result + '    ROB_PRCCP5,           ';
  Result := Result + '    ROB_PRCCP6,           ';
  Result := Result + '    ROB_PRCCP7,           ';
  Result := Result + '    ROB_PRDCP1,           ';
  Result := Result + '    ROB_PRDCP2,           ';
  Result := Result + '    ROB_PRDCP3,           ';
  Result := Result + '    ROB_PRDCP4,           ';
  Result := Result + '    ROB_PRDCP5,           ';
  Result := Result + '    ROB_PRDCP6,           ';
  Result := Result + '    ROB_PRDCP7,           ';

  Result := Result + '    ROB_EMBALT,           ';
  Result := Result + '    ROB_EMBAGL,           ';
  Result := Result + '    ROB_EMBACP,           ';
  Result := Result + '    ROB_VOLULT,           ';
  Result := Result + '    ROB_VOLUGL,           ';
  Result := Result + '    ROB_VOLUCP,           ';
  Result := Result + '    ROB_PREELT,           ';
  Result := Result + '    ROB_PREEGL,           ';
  Result := Result + '    ROB_PREECP,           ';
  Result := Result + '    ROB_TIPOLT,           ';
  Result := Result + '    ROB_TIPOGL,           ';
  Result := Result + '    ROB_TIPOCP            ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :SERIE_,              ';
  Result := Result + '    :MARCA_,              ';
  Result := Result + '    :NOMCOR,              ';
  Result := Result + '    :CODCOR,              ';
  Result := Result + '    :ANOINI,              ';
  Result := Result + '    :ANOFIN,              ';
  Result := Result + '    :GRUCOR,              ';
  Result := Result + '    :MODELO,              ';
  Result := Result + '    :REGIAO,              ';
  Result := Result + '    :CATALO,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDCP,              ';

  Result := Result + '    :PCUSCL,              ';
  Result := Result + '    :PCUSCG,              ';
  Result := Result + '    :PCUSCC,              ';
  Result := Result + '    :PCUSDL,              ';
  Result := Result + '    :PCUSDG,              ';
  Result := Result + '    :PCUSDC,              ';

  Result := Result + '    :PRCLT1,              ';
  Result := Result + '    :PRCLT2,              ';
  Result := Result + '    :PRCLT3,              ';
  Result := Result + '    :PRCLT4,              ';
  Result := Result + '    :PRCLT5,              ';
  Result := Result + '    :PRCLT6,              ';
  Result := Result + '    :PRCLT7,              ';
  Result := Result + '    :PRDLT1,              ';
  Result := Result + '    :PRDLT2,              ';
  Result := Result + '    :PRDLT3,              ';
  Result := Result + '    :PRDLT4,              ';
  Result := Result + '    :PRDLT5,              ';
  Result := Result + '    :PRDLT6,              ';
  Result := Result + '    :PRDLT7,              ';

  Result := Result + '    :PRCGL1,              ';
  Result := Result + '    :PRCGL2,              ';
  Result := Result + '    :PRCGL3,              ';
  Result := Result + '    :PRCGL4,              ';
  Result := Result + '    :PRCGL5,              ';
  Result := Result + '    :PRCGL6,              ';
  Result := Result + '    :PRCGL7,              ';
  Result := Result + '    :PRDGL1,              ';
  Result := Result + '    :PRDGL2,              ';
  Result := Result + '    :PRDGL3,              ';
  Result := Result + '    :PRDGL4,              ';
  Result := Result + '    :PRDGL5,              ';
  Result := Result + '    :PRDGL6,              ';
  Result := Result + '    :PRDGL7,              ';

  Result := Result + '    :PRCCP1,              ';
  Result := Result + '    :PRCCP2,              ';
  Result := Result + '    :PRCCP3,              ';
  Result := Result + '    :PRCCP4,              ';
  Result := Result + '    :PRCCP5,              ';
  Result := Result + '    :PRCCP6,              ';
  Result := Result + '    :PRCCP7,              ';
  Result := Result + '    :PRDCP1,              ';
  Result := Result + '    :PRDCP2,              ';
  Result := Result + '    :PRDCP3,              ';
  Result := Result + '    :PRDCP4,              ';
  Result := Result + '    :PRDCP5,              ';
  Result := Result + '    :PRDCP6,              ';
  Result := Result + '    :PRDCP7,              ';

  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOCP               ';
  Result := Result + '            );                                ';
end;

function TExportaTintometricosTerceirosRoberlo.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
  Begin
    Result := fltValor + fltAcrMob;
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pAdicionaParamentros(Var DataSet: TFDQuery;
      qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_CODIGO').AsString);
  DataSet.ParamByName('SERIE_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_SERIE_').AsString);
  DataSet.ParamByName('MARCA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_MARCA_').AsString);
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_NOMCOR').AsString);
  DataSet.ParamByName('CODCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_CODCOR').AsString);
  DataSet.ParamByName('ANOINI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_ANOINI').AsString);
  DataSet.ParamByName('ANOFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_ANOFIN').AsString);
  DataSet.ParamByName('GRUCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_GRUCOR').AsString);
  DataSet.ParamByName('MODELO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_MODELO').AsString);
  DataSet.ParamByName('REGIAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_REGIAO').AsString);
  DataSet.ParamByName('CATALO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('ROB_CATALO').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('ROB_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProRob;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUSCC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUSDC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
    End;
  End;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
    Begin
      DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
      DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
      DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
      DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('ROB_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('ROB_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pCarregarDados;
Var
  qryDiluente: TUniQuery;
  strSQL: String;
begin
  stlDiluentes := TStringList.Create();
  stlDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT                   ';
  strSQL := strSQL + '    *                               ';
  strSQL := strSQL + '  FROM                              ';
  strSQL := strSQL + '    ROB_CADBAS B                    ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON      ';
  strSQL := strSQL + '    B.BAS_CODITE = I.ITE_CODITE     ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON      ';
  strSQL := strSQL + '    I.ITE_CODITE = G.ITE_CODITE AND   ';
  strSQL := strSQL + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"  ';
  strSQL := strSQL + '  WHERE                             ';
  strSQL := strSQL + '    B.BAS_TIPBAS LIKE "%THINNER%"   ';

  Try
    qryDiluente := fCriaQuery();
    qryDiluente.Close;
    qryDiluente.SQL.Clear;
    qryDiluente.SQL.Add(strSQL);
    qryDiluente.Open;

    While Not qryDiluente.Eof Do
    Begin
      stlDiluentes.Add(qryDiluente.FieldByName('BAS_CODBAS').AsString);
      qryDiluente.Next;
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryEmb: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                    ';
    strSQL := strSQL + '    *                       ';
    strSQL := strSQL + '  FROM                      ';
    strSQL := strSQL + '    CFGTIN                  ';
    strSQL := strSQL + '  WHERE                     ';
    strSQL := strSQL + '    CFG_IDEPRO = "ROB" AND                  ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryEmb := fCriaQuery(Nil, Conexao);
    qryEmb.Close;
    qryEmb.SQL.Clear;
    qryEmb.SQL.Add(strSQL);
    qryEmb.Open;

    cdsEmbalagens := fCriaClientDatset(qryEmb, False, Nil, False);
  Finally
    FreeAndNil(qryEmb);
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
var
  intEmb: Integer;
  strSigEmb: String;
begin
  Try
    With qryInsert Do
    Begin
      pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);

      For intEmb := 0 To Length(arrEmbalagens) - 1 Do
      Begin
        strSigEmb := arrEmbalagens[intEmb].strSigEmb;

        ParamByName('PREC' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValCon; //preco concentrado
        ParamByName('PRED' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValDil; //preco diluido
        ParamByName('EMBA' + strSigEmb).AsStrings[intParam] := arrPrecosPorEmb[intEmb].strIteEmb; //Produto embalagem
        ParamByName('VOLU' + strSigEmb).AsFloats[intParam]  := arrEmbalagens[intEmb].fltVolume;   //Volume vendido
        ParamByName('PREE' + strSigEmb).AsFloats[intParam]  := arrPrecosporEmb[intEmb].fltPreEmb; //Preco da embalagem
        ParamByName('TIPO' + strSigEmb).AsStrings[intParam] := strSigEmb;                         //Tipo da embalagem
        ParamByName('CODDIL').AsStrings[intParam] := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
        ParamByName('PORDIL').AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
      End;
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "ROB"       ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT (            ';
    strSQL := strSQL + '    LOG_IDEPRO,         ';
    strSQL := strSQL + '    LOG_DTAEXE,         ';
    strSQL := strSQL + '    LOG_HOREXE,         ';
    strSQL := strSQL + '    LOG_EXECUT          ';
    strSQL := strSQL + '            )                         ';
    strSQL := strSQL + '  VALUES      (                       ';
    strSQL := strSQL + '    "ROB",              ';
    strSQL := strSQL + '    :DTAEXE,            ';
    strSQL := strSQL + '    :HOREXE,            ';
    strSQL := strSQL + '    :EXECUT             ';
    strSQL := strSQL + '          );                          ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  //Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 1.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
end;

procedure TExportaTintometricosTerceirosRoberlo.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosRoberlo.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intEmb: Integer;
begin
  qryGen.First;

  If Not FAutoma Then
    FProgresso.Position := 0;

{$IFDEF LINUX}
  FInicioExportacao := Now;
{$ENDIF}

{$IFDEF LINUX}
  pGerarArrayValidacao(qryGen.RecordCount);
{$ENDIF}

  While Not qryGen.Eof Do
  Begin
    qryInsert.Params.ClearValues();
    qryInsert.Params.ArraySize := 1;
    intContador := 0;

  {$IFDEF LINUX}
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

    For intRegistros := 0 To 0 Do
    Begin
    {$IFDEF LINUX}
      If VS_ExitProcessSignal Then
        Break;
    {$ENDIF}

      {************************************************************}
      {** VALIDAÇÃO FEITA PARA VERIFICAR SE EXISTE BASE AMARRADA **}
      {**         SE FOR 3 EXISTE BASE NÃO AMARRADA              **}
      {********************************************************RG**}
      If fGetTipoFormula(qryGen, qryBases) = 3 Then
      Begin
        If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

        qryGen.Next;
        Continue;
      End;

      pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);
      pRetornaQuantidadeFormulacao(dicRetorno, qryGen, qryBases);
      pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        Begin
          pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');

          If blnDiluido Then
          Begin
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL');
          End;
        End;
      End;
    {$ENDIF}


      fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

      If Not qryGen.Eof Then
        qryGen.Next
      Else
        Break;

      Inc(intContador, 1);
    End;

  {$IFDEF LINUX}
    If Not fValidarPrecosCalculado(False, 999) Then
      Break;
  {$ENDIF}

  {$IFDEF LINUX}
    pEscreverAguardeInserindo;
  {$ENDIF}

    If intContador > 0 Then
      qryInsert.Execute(intContador, 0);

  {$IFDEF LINUX}
    pEscreverLogProgresso(qryGen);
  {$ENDIF}
  End;

{$IFDEF LINUX}
  fValidarPrecosCalculado(True);
{$ENDIF}
end;

procedure TExportaTintometricosTerceirosRoberlo.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  qryDiluente: TUniQuery;
  strSQL: String;
  fltVolumeAtual: Double;
  fltQtdGrama: Double;
  intContador: Integer;
begin
  blnDiluido := False;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    *                     ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    ROB_CADBAS B          ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON         ';
    strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND         ';
    strSQL := strSQL + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"   ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON         ';
    strSQL := strSQL + '    I.ITE_CODITE =  G.ITE_CODITE            ';
    strSQL := strSQL + '  WHERE                   ';
    strSQL := strSQL + '    BAS_CODBAS = :CODBAS        ';


    qryDiluente := fCriaQuery();
    qryDiluente.Close;
    qryDiluente.SQL.Clear;
    qryDiluente.SQL.Add(strSQL);
    qryDiluente.ParamByName('CODBAS').AsString := stlDiluentes[0];
    qryDiluente.Open;

    If qryDiluente.IsEmpty Then
      Exit;

    blnDiluido := True;

    fltVolumeAtual := 0;

    //Calculando o volume das bases concentradas
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
        Break;

      fltQtdGrama := (qryGen.FieldByName('ROB_QTDB' + fStrZero(intContador, 2)).AsFloat / 100) * 1000;
      fltVolumeAtual := fltVolumeAtual + (fltQtdGrama / qryBases.FieldByName('BAS_PESESP').AsFloat);
    End;

    //Preenchendo Quantidades Concentradas
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
        Break;

      fltQtdGrama := (qryGen.FieldByName('ROB_QTDB' + fStrZero(intContador, 2)).AsFloat / 100) * 1000;
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := (fltQtdGrama / fltVolumeAtual) * 1000;
    End;

    fltVolumeAtual := 0;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
        Break;

      fltVolumeAtual := fltVolumeAtual + (dicRetorno['qtdb' + fStrZero(intContador, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat);
    End;

    //Aplicando a taxa de diluicao
    For intContador := 1 To fQuantidadeFormulacao () Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
        Break;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdb' + fStrZero(intContador, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat);
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / fltVolumeAtual;
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / 1500;
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat(dicRetorno['qtdd' + fStrZero(intContador, 2)] * qryBases.FieldByName('BAS_PESESP').AsFloat, 1);
    End;

    //Adicionando o diluente na ultima posicao
    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
      Begin

        If (Not qryBases.Locate('BAS_CODBAS', stlDiluentes[0], [])) Then
          Break;

        dicRetorno['base' + fStrZero(intContador, 2)] := stlDiluentes[0];
        dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := fRetQtdDiluente(1, stlDiluentes[0], '50');
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := dicRetorno['qtdd' + fStrZero(intContador, 2)] * qryBases.FieldByName('BAS_PESESP').AsFloat;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1 * 1000) / 1500;

        dicRetorno['coddil'] := stlDiluentes[0];
        dicRetorno['pordil'] := 50;
        Break;
      End;
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; arrComponentes: Array of TComp; intEmb: Integer);
Var
  intContador: Integer;
  intPreVen: Integer;
  fltQuantCon,
  fltQuantDil,
  fltPrecoVendaCon,
  fltPrecoVendaDil,
  fltPrecoVendaTotalCon,
  fltPrecoVendaTotalDil,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPrecoCustoCon,
  fltPrecoCustoDil,
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  fltPreCusPro, fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
  strCamEmb: String;
  fltPesoEsp: Double;
  strEmb: String;
begin
  fltPrecoBase := 0;
  fltPrecoEmbalagem := 0;
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  strCodCli := '';
  strCodCnd := '';
  intPrzMed := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];
  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
  strEmb := arrEmbalagens[intEmb].strSigEmb;


  If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
    Exit;

  If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
    Exit;

  Try
    For intPreVen := 1 To 7 Do
    Begin
      fltPrecoVendaTotalCon := 0;
      fltPrecoVendaTotalDil := 0;

      If stlTabPre[intPreVen] <> 'S' Then
        Continue;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
        End;

        fltEmbala := fRetEmbalagem(qryBases);

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / fltEmbala);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala);
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
      End;

      // Preco de venda concentrado
      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      // Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
      dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
    End;

    //Calcula o preço de custo
    fltPrecoCustoTotalCon := 0;
    fltPrecoCustoTotalDil := 0;

    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

      If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
      Begin
        If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreCusPro
        Else
          fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
      End;

      fltEmbala := fRetEmbalagem(qryBases);

      //Preco de custo concentrado
      fltQuantCon := ArrComponentes[intContador].Quantidade;
      fltPrecoCustoCon := fltQuantCon * (fltPrecoBase / fltEmbala);
      fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

      //Preco de venda diluido
      fltQuantDil := ArrComponentes[intContador].Quantiddil;
      fltPrecoCustoDil := fltQuantDil * (fltPrecoBase / fltEmbala);
      fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
    End;

    //Retorna preço de custo da embalagem
    If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
    Begin
      If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro)
      Else
        fltPrecoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
    End;

    // Preco de Custo concentrado
    If fltPrecoCustoTotalCon > 0 Then
      fltPrecoCustoTotalCon := fltPrecoCustoTotalCon +
        (fltPerAcr * fltPrecoCustoTotalCon) + fltPrecoEmbalagem;

    // Preco de Custo diluido
    If fltPrecoCustoTotalDil > 0 Then
      fltPrecoCustoTotalDil := fltPrecoCustoTotalDil +
        (fltPerAcr * fltPrecoCustoTotalDil) + fltPrecoEmbalagem;

    dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
    dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
  Finally
    //
  End;

end;

procedure TExportaTintometricosTerceirosRoberlo.pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; //TArrComponentes;
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
  intEmb: Integer;
  strCamEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;

  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  //fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoVendaTotalDil := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    //Verificar se existe a embalagem
    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    //Verificar se existe produto vinculado
    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao);

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) /1);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 1);
      End;

      //Calcula o preco de venda
      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        fltEmbala := fRetEmbalagem(qryBases);

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / fltEmbala);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala);
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(
            cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      //Preco de venda concentrado
      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      //Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      //Adiciona informacoes no array para gravar
      arrPrecosPorEmb[intEmb].strSigEmb := arrEmbalagens[intEmb].strSigEmb;
      arrPrecosPorEmb[intEmb].fltValCon := fltPrecoVendaTotalCon;
      arrPrecosPorEmb[intEmb].fltValDil := fltPrecoVendaTotalDil;
      arrPrecosPorEmb[intEmb].strIteEmb := cdsEmbalagens.FieldByName('CFG_VALCFG').AsString;
      arrPrecosPorEmb[intEmb].fltPreEmb := fltPrecoEmbalagem;
      arrPrecosPorEmb[intEmb].strCodDil := fRetornaCodigoDiluente(dicRetorno);
      arrPrecosPorEmb[intEmb].fltPorDil := fRetornaPorcentagemDiluente(dicRetorno);

      pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr, ArrComponentes, intEmb);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pRetTabelasVenda(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    SIS_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGSIS              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    SIS_CODEMP = "' + VS_strCodEmp + '" AND       ';
    strSQL := strSQL + '    SIS_CODCFG = "CFG_TABPRC"   AND               ';
    strSQL := strSQL + '    SIS_GRUCFG = "PRODUTOS"                       ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    strCfgPre := qryGen.FieldByName('SIS_VALCFG').AsString;
    stlTabPre.Clear;
    stlTabPre.Add(strCfgPre);

    For intContador := 1 To 7 Do
      stlTabPre.Add(Copy(strCfgPre, intContador, 1));
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosRoberlo.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProRob := fRetItemVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.
