unit untExportaTintometricosTerceirosGeneral;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math,
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosGeneral = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProGen: String;
    strAcrMob: String;
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
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;


    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;

    function fRetProdutoVenda(Conexao: TUniConnection): String;
    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemSP(): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;
    destructor Destroy; Override;

  End;

implementation

{ TExportaTintometricosTerceirosGeneral }

constructor TExportaTintometricosTerceirosGeneral.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProGen := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosGeneral.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosGeneral.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosGeneral.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    GEN_CODIGO,       ';
  Result := Result + '    GEN_DESCRI,       ';
  Result := Result + '    GEN_VARIAC,       ';
  Result := Result + '    GEN_OBSERV,       ';
  Result := Result + '    MON_DESCRI,       ';
  Result := Result + '    GEN_ANOINI,       ';
  Result := Result + '    GEN_ANOFIM,       ';
  Result := Result + '    GEN_DTACAD,       ';
  Result := Result + '    GEN_CODNFM,       ';
  Result := Result + '    GEN_CODMON,       ';
  Result := Result + '    GEN_ACRMOB,       ';
  Result := Result + '    GEN_DILUID,       ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    GEN_FORM' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    GEN_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    GEN_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    GEN_CADGEN        ';
  Result := Result + '  LEFT JOIN GEN_CADMON ON       ';
  Result := Result + '    MON_CODMON = GEN_CODMON     ';
  Result := Result + '  WHERE               ';
  Result := Result + '    TRUE              ';
end;

function TExportaTintometricosTerceirosGeneral.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + '   (     ';
  Result := Result + '    GEN_CODIGO VARCHAR(45) DEFAULT NULL,          ';
  Result := Result + '    GEN_DESCRI VARCHAR(60) DEFAULT NULL,          ';
  Result := Result + '    GEN_VARIAC INT(11) DEFAULT NULL,              ';
  Result := Result + '    GEN_CODMON VARCHAR(30) DEFAULT NULL,          ';
  Result := Result + '    GEN_DESMON VARCHAR(60) DEFAULT NULL,          ';
  Result := Result + '    GEN_ANOINI INT(11) DEFAULT NULL,              ';
  Result := Result + '    GEN_ANOFIM INT(11) DEFAULT NULL,              ';
  Result := Result + '    GEN_DILUID CHAR(3) DEFAULT NULL,              ';
  Result := Result + '    GEN_MD5KEY VARCHAR(32) DEFAULT NULL,          ';
  Result := Result + '    GEN_CODITE VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    GEN_CODDIL VARCHAR(20) DEFAULT NULL,          ';
  Result := Result + '    GEN_PORDIL DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRECLT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRECGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRECCP DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRECSP DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PREDLT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PREDGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PREDCP DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PREDSP DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PCUSCL DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Litro Concentrado
  Result := Result + '    GEN_PCUSDL DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Litro Diluido
  Result := Result + '    GEN_PCUSCG DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Galão Concentrado
  Result := Result + '    GEN_PCUSDG DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Galão Diluido
  Result := Result + '    GEN_PCUSCC DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Copo Concentrado
  Result := Result + '    GEN_PCUSDC DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Copo Diluido
  Result := Result + '    GEN_PCUSCS DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Spray Concentrado
  Result := Result + '    GEN_PCUSDS DECIMAL(12,4) DEFAULT 0.0000,      ';  // Preço de Custo - Spray Diluido

  {* PREÇO DE VENDA - TABELA DE CLIENTES 'PREVE1' AO 'PREVE7' *}

  Result := Result + '    GEN_PRCLT1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCLT2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCLT3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCLT4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCLT5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCLT6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCLT7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRDLT1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDLT2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDLT3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDLT4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDLT5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDLT6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDLT7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRCGL1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCGL2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCGL3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCGL4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCGL5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCGL6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCGL7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRDGL1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDGL2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDGL3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDGL4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDGL5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDGL6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDGL7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRCCP1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCCP2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCCP3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCCP4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCCP5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCCP6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCCP7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRDCP1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDCP2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDCP3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDCP4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDCP5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDCP6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDCP7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRCSP1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCSP2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCSP3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCSP4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCSP5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCSP6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRCSP7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PRDSP1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDSP2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDSP3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDSP4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDSP5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDSP6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PRDSP7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_EMBALT VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    GEN_EMBAGL VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    GEN_EMBACP VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    GEN_EMBASP VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';

  Result := Result + '    GEN_VOLULT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_VOLUGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_VOLUCP DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_VOLUSP DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_PREELT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PREEGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PREECP DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    GEN_PREESP DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    GEN_TIPOLT CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    GEN_TIPOGL CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    GEN_TIPOCP CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    GEN_TIPOSP CHAR(2) DEFAULT NULL               ';
  Result := Result + '              )' + ';                             ';
end;

function TExportaTintometricosTerceirosGeneral.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosGeneral.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('GEN_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('GEN_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosGeneral.fNomeTabela: String;
begin
  Result := 'GEN_CADGEN_SIT';
end;

function TExportaTintometricosTerceirosGeneral.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosGeneral.fRetDescricao: String;
begin
  Result := 'GEN_DESCRI';
end;

function TExportaTintometricosTerceirosGeneral.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosGeneral.fRetEmbalagemCP: String;
begin
  Result := 'GENCOP';
end;

function TExportaTintometricosTerceirosGeneral.fRetEmbalagemGL: String;
begin
  Result := 'GENGAL';
end;

function TExportaTintometricosTerceirosGeneral.fRetEmbalagemLT: String;
begin
  Result := 'GENLIT';
end;

function TExportaTintometricosTerceirosGeneral.fRetEmbalagemSP: String;
begin
  Result := 'GENSPR';
end;

function TExportaTintometricosTerceirosGeneral.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'GEN_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosGeneral.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosGeneral.fRetMD5KEY: String;
begin
  Result := 'GEN_MD5KEY';
end;

function TExportaTintometricosTerceirosGeneral.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    BAS_CODBAS,     ';
  Result := Result + '    BAS_DESCRI,     ';
  Result := Result + '    BAS_EMBALA,     ';
  Result := Result + '    BAS_PESESP,     ';
  Result := Result + '    BAS_CODITE,     ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,   ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM              ';
  Result := Result + '    GEN_CADBAS B    ';
  Result := Result + '  INNER JOIN CADITE I ON      ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE     ';
  Result := Result + '  INNER JOIN ITEGER G ON      ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE     ';
  Result := Result + '  WHERE             ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosGeneral.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP();
end;

function TExportaTintometricosTerceirosGeneral.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosGeneral.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosGeneral.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    CFG_VALCFG      ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CFGTIN          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    CFG_IDEPRO = "GEN"  AND       ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND     ';
    strSQL := strSQL + '    CFG_CODEMP = '  + QuotedStr(VS_strCodEmp);

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0);

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosGeneral.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosGeneral.fRetProdutoVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    CFG_VALCFG      ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CFGTIN          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    CFG_IDEPRO = "GEN" AND        ';
    strSQL := strSQL + '    CFG_CODCFG = "GENPRO" AND     ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND      ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

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

function TExportaTintometricosTerceirosGeneral.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'GEN_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosGeneral.fRetTipoCor: String;
begin
  Result := 'GEN_OBSERV';
end;

function TExportaTintometricosTerceirosGeneral.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "GEN" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosGeneral.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + '   (     ';
  Result := Result + '    GEN_CODIGO,           ';
  Result := Result + '    GEN_DESCRI,           ';
  Result := Result + '    GEN_VARIAC,           ';
  Result := Result + '    GEN_CODMON,           ';
  Result := Result + '    GEN_DESMON,           ';
  Result := Result + '    GEN_ANOINI,           ';
  Result := Result + '    GEN_ANOFIM,           ';
  Result := Result + '    GEN_DILUID,           ';
  Result := Result + '    GEN_MD5KEY,           ';
  Result := Result + '    GEN_CODITE,           ';
  Result := Result + '    GEN_CODDIL,           ';
  Result := Result + '    GEN_PORDIL,           ';

  Result := Result + '    GEN_PRECLT,           ';
  Result := Result + '    GEN_PRECGL,           ';
  Result := Result + '    GEN_PRECCP,           ';
  Result := Result + '    GEN_PRECSP,           ';

  Result := Result + '    GEN_PREDLT,           ';
  Result := Result + '    GEN_PREDGL,           ';
  Result := Result + '    GEN_PREDCP,           ';
  Result := Result + '    GEN_PREDSP,           ';

  Result := Result + '    GEN_PCUSCL,           ';
  Result := Result + '    GEN_PCUSDL,           ';
  Result := Result + '    GEN_PCUSCG,           ';
  Result := Result + '    GEN_PCUSDG,           ';
  Result := Result + '    GEN_PCUSCC,           ';
  Result := Result + '    GEN_PCUSDC,           ';
  Result := Result + '    GEN_PCUSCS,           ';
  Result := Result + '    GEN_PCUSDS,           ';

  Result := Result + '    GEN_PRCLT1,           ';
  Result := Result + '    GEN_PRCLT2,           ';
  Result := Result + '    GEN_PRCLT3,           ';
  Result := Result + '    GEN_PRCLT4,           ';
  Result := Result + '    GEN_PRCLT5,           ';
  Result := Result + '    GEN_PRCLT6,           ';
  Result := Result + '    GEN_PRCLT7,           ';

  Result := Result + '    GEN_PRDLT1,           ';
  Result := Result + '    GEN_PRDLT2,           ';
  Result := Result + '    GEN_PRDLT3,           ';
  Result := Result + '    GEN_PRDLT4,           ';
  Result := Result + '    GEN_PRDLT5,           ';
  Result := Result + '    GEN_PRDLT6,           ';
  Result := Result + '    GEN_PRDLT7,           ';

  Result := Result + '    GEN_PRCGL1,           ';
  Result := Result + '    GEN_PRCGL2,           ';
  Result := Result + '    GEN_PRCGL3,           ';
  Result := Result + '    GEN_PRCGL4,           ';
  Result := Result + '    GEN_PRCGL5,           ';
  Result := Result + '    GEN_PRCGL6,           ';
  Result := Result + '    GEN_PRCGL7,           ';

  Result := Result + '    GEN_PRDGL1,           ';
  Result := Result + '    GEN_PRDGL2,           ';
  Result := Result + '    GEN_PRDGL3,           ';
  Result := Result + '    GEN_PRDGL4,           ';
  Result := Result + '    GEN_PRDGL5,           ';
  Result := Result + '    GEN_PRDGL6,           ';
  Result := Result + '    GEN_PRDGL7,           ';

  Result := Result + '    GEN_PRCCP1,           ';
  Result := Result + '    GEN_PRCCP2,           ';
  Result := Result + '    GEN_PRCCP3,           ';
  Result := Result + '    GEN_PRCCP4,           ';
  Result := Result + '    GEN_PRCCP5,           ';
  Result := Result + '    GEN_PRCCP6,           ';
  Result := Result + '    GEN_PRCCP7,           ';

  Result := Result + '    GEN_PRDCP1,           ';
  Result := Result + '    GEN_PRDCP2,           ';
  Result := Result + '    GEN_PRDCP3,           ';
  Result := Result + '    GEN_PRDCP4,           ';
  Result := Result + '    GEN_PRDCP5,           ';
  Result := Result + '    GEN_PRDCP6,           ';
  Result := Result + '    GEN_PRDCP7,           ';

  Result := Result + '    GEN_PRCSP1,           ';
  Result := Result + '    GEN_PRCSP2,           ';
  Result := Result + '    GEN_PRCSP3,           ';
  Result := Result + '    GEN_PRCSP4,           ';
  Result := Result + '    GEN_PRCSP5,           ';
  Result := Result + '    GEN_PRCSP6,           ';
  Result := Result + '    GEN_PRCSP7,           ';

  Result := Result + '    GEN_PRDSP1,           ';
  Result := Result + '    GEN_PRDSP2,           ';
  Result := Result + '    GEN_PRDSP3,           ';
  Result := Result + '    GEN_PRDSP4,           ';
  Result := Result + '    GEN_PRDSP5,           ';
  Result := Result + '    GEN_PRDSP6,           ';
  Result := Result + '    GEN_PRDSP7,           ';


  Result := Result + '    GEN_EMBALT,           ';
  Result := Result + '    GEN_EMBAGL,           ';
  Result := Result + '    GEN_EMBACP,           ';
  Result := Result + '    GEN_EMBASP,           ';

  Result := Result + '    GEN_VOLULT,           ';
  Result := Result + '    GEN_VOLUGL,           ';
  Result := Result + '    GEN_VOLUCP,           ';
  Result := Result + '    GEN_VOLUSP,           ';

  Result := Result + '    GEN_PREELT,           ';
  Result := Result + '    GEN_PREEGL,           ';
  Result := Result + '    GEN_PREECP,           ';
  Result := Result + '    GEN_PREESP,           ';

  Result := Result + '    GEN_TIPOLT,           ';
  Result := Result + '    GEN_TIPOGL,           ';
  Result := Result + '    GEN_TIPOCP,           ';
  Result := Result + '    GEN_TIPOSP            ';
  Result := Result + '        )                 ';
  Result := Result + '  VALUES  ' + '   (       ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :VARIAC,              ';
  Result := Result + '    :CODMON,              ';
  Result := Result + '    :DESMON,              ';
  Result := Result + '    :ANOINI,              ';
  Result := Result + '    :ANOFIM,              ';
  Result := Result + '    :DILUID,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';

  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PRECSP,              ';

  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDCP,              ';
  Result := Result + '    :PREDSP,              ';

  Result := Result + '    :PCUSCL,              ';
  Result := Result + '    :PCUSDL,              ';
  Result := Result + '    :PCUSCG,              ';
  Result := Result + '    :PCUSDG,              ';
  Result := Result + '    :PCUSCC,              ';
  Result := Result + '    :PCUSDC,              ';
  Result := Result + '    :PCUSCS,              ';
  Result := Result + '    :PCUSDS,              ';

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

  Result := Result + '    :PRCSP1,              ';
  Result := Result + '    :PRCSP2,              ';
  Result := Result + '    :PRCSP3,              ';
  Result := Result + '    :PRCSP4,              ';
  Result := Result + '    :PRCSP5,              ';
  Result := Result + '    :PRCSP6,              ';
  Result := Result + '    :PRCSP7,              ';

  Result := Result + '    :PRDSP1,              ';
  Result := Result + '    :PRDSP2,              ';
  Result := Result + '    :PRDSP3,              ';
  Result := Result + '    :PRDSP4,              ';
  Result := Result + '    :PRDSP5,              ';
  Result := Result + '    :PRDSP6,              ';
  Result := Result + '    :PRDSP7,              ';

  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :EMBASP,              ';

  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :VOLUSP,              ';

  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :PREESP,              ';

  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOCP,              ';
  Result := Result + '    :TIPOSP               ';
  Result := Result + '      );                  ';
end;

function TExportaTintometricosTerceirosGeneral.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosGeneral.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('GEN_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('GEN_DESCRI').AsString);
  DataSet.ParamByName('VARIAC').AsIntegers[intParam] := qryTInta.FieldByName('GEN_VARIAC').AsInteger;
  DataSet.ParamByName('CODMON').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('GEN_CODMON').AsString);
  DataSet.ParamByName('DESMON').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('MON_DESCRI').AsString);
  DataSet.ParamByName('ANOINI').AsIntegers[intParam] := qryTinta.FieldByName('GEN_ANOINI').AsInteger;
  DataSet.ParamByName('ANOFIM').AsIntegers[intParam] := qryTinta.FieldByName('GEN_ANOFIM').AsInteger;
  DataSet.ParamByName('DILUID').AsStrings[intParam]  := fRemoveAcento(qryTinta.FieldByName('GEN_DILUID').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam]  := qryTinta.FieldByName('GEN_MD5KEY').ASString;
  DataSet.ParamByName('CODITE').AsStrings[intParam]  := strProGen;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUSCC').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUSDC').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUSCS').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUSDS').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('GEN_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('GEN_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosGeneral.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add('  WHERE CFG_IDEPRO = "GEN" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;
    End;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosGeneral.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosGeneral.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "GEN"  ');
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('  INSERT INTO LOGTIN_SIT  (       ');
    qryGen.SQL.Add('    LOG_IDEPRO,                   ');
    qryGen.SQL.Add('    LOG_DTAEXE,                   ');
    qryGen.SQL.Add('    LOG_HOREXE,                   ');
    qryGen.SQL.Add('    LOG_EXECUT                    ');
    qryGen.SQL.Add('              )                   ');
    qryGen.SQL.Add('  VALUES  (                       ');
    qryGen.SQL.Add('    "GEN",                        ');
    qryGen.SQL.Add('    :DTAEXE,                      ');
    qryGen.SQL.Add('    :HOREXE,                      ');
    qryGen.SQL.Add('    :EXECUT                       ');
    qryGen.SQL.Add('            );                    ');

    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGEn.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosGeneral.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  //Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.900;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.600;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.450;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[LEngth(arrEmbalagens) - 1].fltVolume := 0.190;
end;

procedure TExportaTintometricosTerceirosGeneral.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosGeneral.pProcessaTabelaCores(
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

          If qryGen.FieldByName('GEN_DILUID').AsString = 'S' Then
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

procedure TExportaTintometricosTerceirosGeneral.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
  intDiluente: Integer;
begin

  If qryGen.FieldByName('GEN_DILUID').AsString <> 'S' Then
    Exit; //Concentrado

  intDiluente := 1;

  For intContador := 1 To fQuantidadeFormulacao() Do     //Concentrado e Diluido
  Begin

    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat * 5 / 6;

    intDiluente := intDiluente + 1;
  End;

  dicRetorno['base' + fStrZero(intDiluente, 2)] := '7540563';
  dicRetorno['qtdb' + fStrZero(intDiluente, 2)] := 0.0;
  dicRetorno['qtdd' + fStrZero(intDiluente, 2)] := 110.13 * 900 / 750;
  dicRetorno['coddil'] := '7540563';
  dicRetorno['pordil'] := 0.0;
end;

procedure TExportaTintometricosTerceirosGeneral.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  intPreVen: Integer;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPrecoCustoCon,
  fltPrecoCustoDil,
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
  fltVolumeOri: Double;
  strEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem   :=  0;
  fltPreCusPro        :=  0;
  fltPreVenPro        :=  0;
  strCodCli           :=  '';
  strCodCnd           :=  '';
  intPrzMed           :=  0;
  fltVolumeOri        :=  0.900;

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];
  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmb].strSigEmb;

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    //Verificar se existe produto vinculado
    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(arrComponentes, fQuantidadeFormulacao());

      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / fltVolumeOri);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / fltVolumeOri);
      End;

      For intPreVen := 1 To 7 Do
      Begin
        fltPrecoVendaTotalCon := 0;
        fltPrecoVendaTotalDil := 0;

        If stlTabPre[intPreVen] <> 'S' Then
          Continue;

        For intContador := 1 To Length(arrComponentes) Do
        Begin

          If fEmptyStr(ArrComponentes[intContador].Componente) Then
            Break;

          If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltEmbala  := fRetEmbalagem(qryBases);

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

        //Preco de venda concentrado
        If fltPrecoVendaTotalCon > 0 Then
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        //Preco de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      //Calcula o preço de Custo
      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

      For intContador := 1 To Length(arrComponentes) Do
      Begin

        If fEmptyStr(ArrComponentes[intContador].Componente) Then
            Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        fltEmbala  := fRetEmbalagem(qryBases);

        //Preco de custo concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := fltQuantCon * (fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preco de custo diluido
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

      //Preco de custo concentrado
      If fltPrecoCustoTotalCon > 0 Then
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon +
          (fltPerAcr * fltPrecoCustoTotalCon) + fltPrecoEmbalagem;

      //Preco de custo diluido
      If fltPrecoCustoTotalDil > 0 Then
       fltPrecoCustoTotalDil := fltPrecoCustoTotalDil +
          (fltPerAcr * fltPrecoCustoTotalDil) + fltPrecoEmbalagem;

      dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
      dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosGeneral.pRetPrecoTintas(
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
  fltVolumeOri: Double;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem   :=  0;
  fltPreCusPro        :=  0;
  fltPreVenPro        :=  0;
  strCodCli           :=  '';
  strCodCnd           :=  '';
  intPrzMed           :=  0;
  fltVolumeOri        :=  0.900;

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];

  //fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoVendaTotalDil := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

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
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / fltVolumeOri);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / fltVolumeOri);
      End;

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
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

        fltEmbala  := fRetEmbalagem(qryBases);

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
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;

  pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);
end;

procedure TExportaTintometricosTerceirosGeneral.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosGeneral.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProGen := fRetProdutoVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.
