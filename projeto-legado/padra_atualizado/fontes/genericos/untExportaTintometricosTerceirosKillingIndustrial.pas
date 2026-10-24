unit untExportaTintometricosTerceirosKillingIndustrial;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, Math, strUtils,
  untThreadExportacaoTerceiros, DateUtils,
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosKillingIndustrial = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProKin: String; //Produto de venda Killing Industrial
    fltPesoProduto: Double;
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
    function fRetTipoCor(): String; Override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;  blnAuto: Boolean = False); override;
    destructor Destroy; override;

    function fRetItemVenda(Conexao: TUniConnection): String;
    function fRetEmbLt(strTipCor: String): String;
    function fRetEmbGl(strTipCor: String): String;
    function fRetEmbLa(strTipCor: String): String;
    function fRetEmbCp(strTipCor: String): String;
    function fRetEmbSp(strTipCor: String): String;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagens;
    procedure pCriaClienteEmbalagem(Conexao: TUniConnection);
    procedure pTabelasVendas(Conexao: TUniConnection);
  End;

implementation

{ TExportaTintometricosTerceirosKillingIndustrial }

constructor TExportaTintometricosTerceirosKillingIndustrial.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  pPreencheEmbalagens;
  strProKin := '';
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosKillingIndustrial.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    KIN_CODIGO,           ';
  Result := Result + '    KIN_NOMCOR,           ';
  Result := Result + '    KIN_PRODUT,           ';
  Result := Result + '    KIN_SISTEM,           ';
  Result := Result + '    KIN_ORIGEM,           ';
  Result := Result + '    KIN_CODMON,           ';
  Result := Result + '    KIN_LINHA_,           ';
  Result := Result + '    KIN_ANOCOR,           ';
  Result := Result + '    KIN_DESMON,           ';
  Result := Result + '    KIN_DESLIN,           ';
  Result := Result + '    KIN_DTACAD,           ';
  Result := Result + '    KIN_DESCRI,           ';
  Result := Result + '    KIN_ACRMOB,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    KIN_BASE' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    KIN_QTDB' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    KIN_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    KIN_CADKIN            ';
  Result := Result + '  LEFT JOIN KIN_CADMON  ON        ';
  Result := Result + '    MON_CODMON = KIN_CODMON               ';
  Result := Result + '  LEFT JOIN KIN_CADLIN  ON        ';
  Result := Result + '    LIN_CODIGO = KIN_LINHA_               ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela + '   (       ';
  Result := Result + '    KIN_CODIGO VARCHAR(15),         ';
  Result := Result + '    KIN_NOMCOR VARCHAR(50),         ';
  Result := Result + '    KIN_PRODUT VARCHAR(30),         ';
  Result := Result + '    KIN_SISTEM VARCHAR(20),         ';
  Result := Result + '    KIN_ORIGEM VARCHAR(50),         ';
  Result := Result + '    KIN_CODMON CHAR(3),             ';
  Result := Result + '    KIN_LINHA_ CHAR(3),             ';
  Result := Result + '    KIN_ANOCOR CHAR(4),             ';
  Result := Result + '    KIN_DESMON VARCHAR(60),         ';
  Result := Result + '    KIN_DESLIN VARCHAR(60),         ';
  Result := Result + '    KIN_DESCRI VARCHAR(50),         ';
  Result := Result + '    KIN_MD5KEY VARCHAR(32),         ';
  Result := Result + '    KIN_CODITE VARCHAR(' + fTamCodIte.ToString() + '),          ';

  Result := Result + '    KIN_CODDIL VARCHAR(20),         ';
  Result := Result + '    KIN_PORDIL DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRECLA DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRECCP DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRECSP DECIMAL(12,4),       ';

  Result := Result + '    KIN_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREDLA DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREDCP DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREDSP DECIMAL(12,4),       ';

  Result := Result + '    KIN_PCUCLT DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUCGL DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUCLA DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUCCP DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUCSP DECIMAL(12,4),       ';

  Result := Result + '    KIN_PCUDLT DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUDGL DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUDLA DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUDCP DECIMAL(12,4),       ';
  Result := Result + '    KIN_PCUDSP DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLT7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLT7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCGL7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDGL7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRCLA1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLA2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLA3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLA4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLA5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLA6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCLA7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRDLA1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLA2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLA3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLA4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLA5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLA6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDLA7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRCCP1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCCP2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCCP3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCCP4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCCP5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCCP6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCCP7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRDCP1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDCP2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDCP3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDCP4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDCP5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDCP6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDCP7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRCSP1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCSP2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCSP3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCSP4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCSP5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCSP6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRCSP7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_PRDSP1 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDSP2 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDSP3 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDSP4 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDSP5 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDSP6 DECIMAL(12,4),       ';
  Result := Result + '    KIN_PRDSP7 DECIMAL(12,4),       ';

  Result := Result + '    KIN_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    KIN_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    KIN_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    KIN_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    KIN_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),          ';

  Result := Result + '    KIN_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    KIN_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    KIN_VOLULA DECIMAL(12,4),       ';
  Result := Result + '    KIN_VOLUCP DECIMAL(12,4),       ';
  Result := Result + '    KIN_VOLUSP DECIMAL(12,4),       ';

  Result := Result + '    KIN_PREELT DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREELA DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREECP DECIMAL(12,4),       ';
  Result := Result + '    KIN_PREESP DECIMAL(12,4),       ';

  Result := Result + '    KIN_TIPOLT CHAR(2),             ';
  Result := Result + '    KIN_TIPOGL CHAR(2),             ';
  Result := Result + '    KIN_TIPOLA CHAR(2),             ';
  Result := Result + '    KIN_TIPOCP CHAR(2),             ';
  Result := Result + '    KIN_TIPOSP CHAR(2)              ';
  Result := Result + '                  );                            ';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('KIN_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('KIN_BASE' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fNomeTabela: String;
begin
  Result := 'KIN_CADKIN_SIT';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetDescricao: String;
begin
  Result := 'KIN_DESCRI';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetEmbCp(
  strTipCor: String): String;
begin
  Result := 'KINCOP';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetEmbGl(
  strTipCor: String): String;
begin
  Result := 'KINGAL';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetEmbLa(
  strTipCor: String): String;
begin
  Result := 'KINLAT';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetEmbLt(
  strTipCor: String): String;
begin
  Result := 'KINLIT';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetEmbSp(
  strTipCor: String): String;
begin
  Result := 'KINSPR';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'KIN_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetItemVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    CFG_VALCFG        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "KIN" AND      ';
    strSQL := strSQL + '    CFG_CODCFG = "KINPRO" AND   ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

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

function TExportaTintometricosTerceirosKillingIndustrial.fRetMD5KEY: String;
begin
  Result := 'KIN_MD5KEY';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT            ';
  Result := Result + '    BAS_CODBAS,     ';
  Result := Result + '    BAS_DESCRI,     ';
  Result := Result + '    BAS_CODITE,     ';
  Result := Result + '    BAS_EMBALA,     ';
  Result := Result + '    BAS_PESESP,     ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,    ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM              ';
  Result := Result + '    KIN_CADBAS B    ';
  Result := Result + '  INNER JOIN CADITE I ON        ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE         ';
  Result := Result + '  INNER JOIN ITEGER G ON        ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE         ';
  Result := Result + '  WHERE             ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"    ';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
   Result := fRetEmbLt(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbGl(dicRetorno['tipcor'])
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbLa(dicRetorno['tipcor'])
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbCp(dicRetorno['tipcor'])
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbSp(dicRetorno['tipcor']);
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    CFG_VALCFG      ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CFGTIN          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    CFG_IDEPRO = "KIN" AND      ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND   ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'KIN_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetTipoCor: String;
begin
  Result := 'KIN_SISTEM';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "KIN" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosKillingIndustrial.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO    ' + fNomeTabela + '  (       ';
  Result := Result + '    KIN_CODIGO,         ';
  Result := Result + '    KIN_NOMCOR,         ';
  Result := Result + '    KIN_PRODUT,         ';
  Result := Result + '    KIN_SISTEM,         ';
  Result := Result + '    KIN_ORIGEM,         ';
  Result := Result + '    KIN_CODMON,         ';
  Result := Result + '    KIN_LINHA_,         ';
  Result := Result + '    KIN_ANOCOR,         ';
  Result := Result + '    KIN_DESMON,         ';
  Result := Result + '    KIN_DESLIN,         ';
  Result := Result + '    KIN_DESCRI,         ';
  Result := Result + '    KIN_MD5KEY,         ';

  Result := Result + '    KIN_CODITE,         ';
  Result := Result + '    KIN_CODDIL,         ';
  Result := Result + '    KIN_PORDIL,         ';

  Result := Result + '    KIN_PRECLT,         ';
  Result := Result + '    KIN_PRECGL,         ';
  Result := Result + '    KIN_PRECLA,         ';
  Result := Result + '    KIN_PRECCP,         ';
  Result := Result + '    KIN_PRECSP,         ';
  Result := Result + '    KIN_PREDLT,         ';
  Result := Result + '    KIN_PREDGL,         ';
  Result := Result + '    KIN_PREDLA,         ';
  Result := Result + '    KIN_PREDCP,         ';
  Result := Result + '    KIN_PREDSP,         ';
  Result := Result + '    KIN_PCUCLT,         ';
  Result := Result + '    KIN_PCUCGL,         ';
  Result := Result + '    KIN_PCUCLA,         ';
  Result := Result + '    KIN_PCUCCP,         ';
  Result := Result + '    KIN_PCUCSP,         ';
  Result := Result + '    KIN_PCUDLT,         ';
  Result := Result + '    KIN_PCUDGL,         ';
  Result := Result + '    KIN_PCUDLA,         ';
  Result := Result + '    KIN_PCUDCP,         ';
  Result := Result + '    KIN_PCUDSP,         ';
  Result := Result + '    KIN_PRCLT1,         ';
  Result := Result + '    KIN_PRCLT2,         ';
  Result := Result + '    KIN_PRCLT3,         ';
  Result := Result + '    KIN_PRCLT4,         ';
  Result := Result + '    KIN_PRCLT5,         ';
  Result := Result + '    KIN_PRCLT6,         ';
  Result := Result + '    KIN_PRCLT7,         ';
  Result := Result + '    KIN_PRDLT1,         ';
  Result := Result + '    KIN_PRDLT2,         ';
  Result := Result + '    KIN_PRDLT3,         ';
  Result := Result + '    KIN_PRDLT4,         ';
  Result := Result + '    KIN_PRDLT5,         ';
  Result := Result + '    KIN_PRDLT6,         ';
  Result := Result + '    KIN_PRDLT7,         ';
  Result := Result + '    KIN_PRCGL1,         ';
  Result := Result + '    KIN_PRCGL2,         ';
  Result := Result + '    KIN_PRCGL3,         ';
  Result := Result + '    KIN_PRCGL4,         ';
  Result := Result + '    KIN_PRCGL5,         ';
  Result := Result + '    KIN_PRCGL6,         ';
  Result := Result + '    KIN_PRCGL7,         ';
  Result := Result + '    KIN_PRDGL1,         ';
  Result := Result + '    KIN_PRDGL2,         ';
  Result := Result + '    KIN_PRDGL3,         ';
  Result := Result + '    KIN_PRDGL4,         ';
  Result := Result + '    KIN_PRDGL5,         ';
  Result := Result + '    KIN_PRDGL6,         ';
  Result := Result + '    KIN_PRDGL7,         ';
  Result := Result + '    KIN_PRCLA1,         ';
  Result := Result + '    KIN_PRCLA2,         ';
  Result := Result + '    KIN_PRCLA3,         ';
  Result := Result + '    KIN_PRCLA4,         ';
  Result := Result + '    KIN_PRCLA5,         ';
  Result := Result + '    KIN_PRCLA6,         ';
  Result := Result + '    KIN_PRCLA7,         ';
  Result := Result + '    KIN_PRDLA1,         ';
  Result := Result + '    KIN_PRDLA2,         ';
  Result := Result + '    KIN_PRDLA3,         ';
  Result := Result + '    KIN_PRDLA4,         ';
  Result := Result + '    KIN_PRDLA5,         ';
  Result := Result + '    KIN_PRDLA6,         ';
  Result := Result + '    KIN_PRDLA7,         ';
  Result := Result + '    KIN_PRCCP1,         ';
  Result := Result + '    KIN_PRCCP2,         ';
  Result := Result + '    KIN_PRCCP3,         ';
  Result := Result + '    KIN_PRCCP4,         ';
  Result := Result + '    KIN_PRCCP5,         ';
  Result := Result + '    KIN_PRCCP6,         ';
  Result := Result + '    KIN_PRCCP7,         ';
  Result := Result + '    KIN_PRDCP1,         ';
  Result := Result + '    KIN_PRDCP2,         ';
  Result := Result + '    KIN_PRDCP3,         ';
  Result := Result + '    KIN_PRDCP4,         ';
  Result := Result + '    KIN_PRDCP5,         ';
  Result := Result + '    KIN_PRDCP6,         ';
  Result := Result + '    KIN_PRDCP7,         ';
  Result := Result + '    KIN_PRCSP1,         ';
  Result := Result + '    KIN_PRCSP2,         ';
  Result := Result + '    KIN_PRCSP3,         ';
  Result := Result + '    KIN_PRCSP4,         ';
  Result := Result + '    KIN_PRCSP5,         ';
  Result := Result + '    KIN_PRCSP6,         ';
  Result := Result + '    KIN_PRCSP7,         ';
  Result := Result + '    KIN_PRDSP1,         ';
  Result := Result + '    KIN_PRDSP2,         ';
  Result := Result + '    KIN_PRDSP3,         ';
  Result := Result + '    KIN_PRDSP4,         ';
  Result := Result + '    KIN_PRDSP5,         ';
  Result := Result + '    KIN_PRDSP6,         ';
  Result := Result + '    KIN_PRDSP7,         ';
  Result := Result + '    KIN_EMBALT,         ';
  Result := Result + '    KIN_EMBAGL,         ';
  Result := Result + '    KIN_EMBALA,         ';
  Result := Result + '    KIN_EMBACP,         ';
  Result := Result + '    KIN_EMBASP,         ';
  Result := Result + '    KIN_VOLULT,         ';
  Result := Result + '    KIN_VOLUGL,         ';
  Result := Result + '    KIN_VOLULA,         ';
  Result := Result + '    KIN_VOLUCP,         ';
  Result := Result + '    KIN_VOLUSP,         ';
  Result := Result + '    KIN_PREELT,         ';
  Result := Result + '    KIN_PREEGL,         ';
  Result := Result + '    KIN_PREELA,         ';
  Result := Result + '    KIN_PREECP,         ';
  Result := Result + '    KIN_PREESP,         ';
  Result := Result + '    KIN_TIPOLT,         ';
  Result := Result + '    KIN_TIPOGL,         ';
  Result := Result + '    KIN_TIPOLA,         ';
  Result := Result + '    KIN_TIPOCP,         ';
  Result := Result + '    KIN_TIPOSP          ';
  Result := Result + '                    )                         ';
  Result := Result + '    VALUES            (                       ';
  Result := Result + '    :CODIGO,            ';
  Result := Result + '    :NOMCOR,            ';
  Result := Result + '    :PRODUT,            ';
  Result := Result + '    :SISTEM,            ';
  Result := Result + '    :ORIGEM,            ';
  Result := Result + '    :CODMON,            ';
  Result := Result + '    :LINHA_,            ';
  Result := Result + '    :ANOCOR,            ';
  Result := Result + '    :DESMON,            ';
  Result := Result + '    :DESLIN,            ';
  Result := Result + '    :DESCRI,            ';
  Result := Result + '    :MD5KEY,            ';
  Result := Result + '    :CODITE,            ';
  Result := Result + '    :CODDIL,            ';
  Result := Result + '    :PORDIL,            ';
  Result := Result + '    :PRECLT,            ';
  Result := Result + '    :PRECGL,            ';
  Result := Result + '    :PRECLA,            ';
  Result := Result + '    :PRECCP,            ';
  Result := Result + '    :PRECSP,            ';
  Result := Result + '    :PREDLT,            ';
  Result := Result + '    :PREDGL,            ';
  Result := Result + '    :PREDLA,            ';
  Result := Result + '    :PREDCP,            ';
  Result := Result + '    :PREDSP,            ';
  Result := Result + '    :PCUCLT,            ';
  Result := Result + '    :PCUCGL,            ';
  Result := Result + '    :PCUCLA,            ';
  Result := Result + '    :PCUCCP,            ';
  Result := Result + '    :PCUCSP,            ';
  Result := Result + '    :PCUDLT,            ';
  Result := Result + '    :PCUDGL,            ';
  Result := Result + '    :PCUDLA,            ';
  Result := Result + '    :PCUDCP,            ';
  Result := Result + '    :PCUDSP,            ';
  Result := Result + '    :PRCLT1,            ';
  Result := Result + '    :PRCLT2,            ';
  Result := Result + '    :PRCLT3,            ';
  Result := Result + '    :PRCLT4,            ';
  Result := Result + '    :PRCLT5,            ';
  Result := Result + '    :PRCLT6,            ';
  Result := Result + '    :PRCLT7,            ';
  Result := Result + '    :PRDLT1,            ';
  Result := Result + '    :PRDLT2,            ';
  Result := Result + '    :PRDLT3,            ';
  Result := Result + '    :PRDLT4,            ';
  Result := Result + '    :PRDLT5,            ';
  Result := Result + '    :PRDLT6,            ';
  Result := Result + '    :PRDLT7,            ';
  Result := Result + '    :PRCGL1,            ';
  Result := Result + '    :PRCGL2,            ';
  Result := Result + '    :PRCGL3,            ';
  Result := Result + '    :PRCGL4,            ';
  Result := Result + '    :PRCGL5,            ';
  Result := Result + '    :PRCGL6,            ';
  Result := Result + '    :PRCGL7,            ';
  Result := Result + '    :PRDGL1,            ';
  Result := Result + '    :PRDGL2,            ';
  Result := Result + '    :PRDGL3,            ';
  Result := Result + '    :PRDGL4,            ';
  Result := Result + '    :PRDGL5,            ';
  Result := Result + '    :PRDGL6,            ';
  Result := Result + '    :PRDGL7,            ';
  Result := Result + '    :PRCLA1,            ';
  Result := Result + '    :PRCLA2,            ';
  Result := Result + '    :PRCLA3,            ';
  Result := Result + '    :PRCLA4,            ';
  Result := Result + '    :PRCLA5,            ';
  Result := Result + '    :PRCLA6,            ';
  Result := Result + '    :PRCLA7,            ';
  Result := Result + '    :PRDLA1,            ';
  Result := Result + '    :PRDLA2,            ';
  Result := Result + '    :PRDLA3,            ';
  Result := Result + '    :PRDLA4,            ';
  Result := Result + '    :PRDLA5,            ';
  Result := Result + '    :PRDLA6,            ';
  Result := Result + '    :PRDLA7,            ';
  Result := Result + '    :PRCCP1,            ';
  Result := Result + '    :PRCCP2,            ';
  Result := Result + '    :PRCCP3,            ';
  Result := Result + '    :PRCCP4,            ';
  Result := Result + '    :PRCCP5,            ';
  Result := Result + '    :PRCCP6,            ';
  Result := Result + '    :PRCCP7,            ';
  Result := Result + '    :PRDCP1,            ';
  Result := Result + '    :PRDCP2,            ';
  Result := Result + '    :PRDCP3,            ';
  Result := Result + '    :PRDCP4,            ';
  Result := Result + '    :PRDCP5,            ';
  Result := Result + '    :PRDCP6,            ';
  Result := Result + '    :PRDCP7,            ';
  Result := Result + '    :PRCSP1,            ';
  Result := Result + '    :PRCSP2,            ';
  Result := Result + '    :PRCSP3,            ';
  Result := Result + '    :PRCSP4,            ';
  Result := Result + '    :PRCSP5,            ';
  Result := Result + '    :PRCSP6,            ';
  Result := Result + '    :PRCSP7,            ';
  Result := Result + '    :PRDSP1,            ';
  Result := Result + '    :PRDSP2,            ';
  Result := Result + '    :PRDSP3,            ';
  Result := Result + '    :PRDSP4,            ';
  Result := Result + '    :PRDSP5,            ';
  Result := Result + '    :PRDSP6,            ';
  Result := Result + '    :PRDSP7,            ';
  Result := Result + '    :EMBALT,            ';
  Result := Result + '    :EMBAGL,            ';
  Result := Result + '    :EMBALA,            ';
  Result := Result + '    :EMBACP,            ';
  Result := Result + '    :EMBASP,            ';
  Result := Result + '    :VOLULT,            ';
  Result := Result + '    :VOLUGL,            ';
  Result := Result + '    :VOLULA,            ';
  Result := Result + '    :VOLUCP,            ';
  Result := Result + '    :VOLUSP,            ';
  Result := Result + '    :PREELT,            ';
  Result := Result + '    :PREEGL,            ';
  Result := Result + '    :PREELA,            ';
  Result := Result + '    :PREECP,            ';
  Result := Result + '    :PREESP,            ';
  Result := Result + '    :TIPOLT,            ';
  Result := Result + '    :TIPOGL,            ';
  Result := Result + '    :TIPOLA,            ';
  Result := Result + '    :TIPOCP,            ';
  Result := Result + '    :TIPOSP             ';
  Result := Result + '          );                                  ';
end;

function TExportaTintometricosTerceirosKillingIndustrial.fValorQuantidade(
  fltValor, fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_CODIGO').AsString);
  DataSet.ParamByName('NOMCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_NOMCOR').AsString);
  DataSet.ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_PRODUT').AsString);
  DataSet.ParamByName('SISTEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_SISTEM').AsString);
  DataSet.ParamByName('ORIGEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_ORIGEM').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_CODMON').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_LINHA_').AsString);
  DataSet.ParamByName('ANOCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_ANOCOR').AsString);
  DataSet.ParamByName('DESMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_DESMON').AsString);
  DataSet.ParamByName('DESLIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_DESLIN').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('KIN_DESCRI').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('KIN_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProKin;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0);
      DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('KIN_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('KIN_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pCriaClienteEmbalagem(
  Conexao: TUniConnection);
var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    *                 ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE CFG_IDEPRO = "KIN" AND                ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND          ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"       ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosKillingIndustrial.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    qryGen := fCriaQuery(Nil, COnexao);

    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "KIN"     ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT  (       ';
    strSQL := strSQL + '    LOG_IDEPRO,       ';
    strSQL := strSQL + '    LOG_DTAEXE,       ';
    strSQL := strSQL + '    LOG_HOREXE,       ';
    strSQL := strSQL + '    LOG_EXECUT        ';
    strSQL := strSQL + '              )                   ';
    strSQL := strSQL + '  VALUES  (                       ';
    strSQL := strSQL + '    "KIN",            ';
    strSQL := strSQL + '    :DTAEXE,          ';
    strSQL := strSQL + '    :HOREXE,          ';
    strSQL := strSQL + '    :EXECUT           ';
    strSQL := strSQL + '          );                      ';

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

procedure TExportaTintometricosTerceirosKillingIndustrial.pPreencheArrayEmbalagens;
begin
  SetLength(arrEmbalagens, 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.900;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.600;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.100;
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagens;
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pProcessaTabelaCores(
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
      pRecalculaFormula(dicRetorno, qryGen, qryBases);
      pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        Begin
          pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');
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

procedure TExportaTintometricosTerceirosKillingIndustrial.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  fltPesoProduto := 0;

  For intContador := 1 To 20 Do
  Begin
    If fEmptyStr(qryGen.FieldByName('KIN_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('KIN_BASE' + fStrZero(intContador, 2)).AsString, []) Then
      Break;

    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;

    fltPesoProduto := fltPesoProduto + (1 / qryBases.FieldByName('BAS_PESESP').AsFloat * qryGen.FieldByName('KIN_QTDB' + fStrZero(intContador, 2)).AsFloat);
  End;

  fltPesoProduto := (100 / fltPesoProduto);
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  intPreVen: Integer;
  fltQuantCon,
  fltPrecoVendaCon,
  fltPrecoVendaTotalCon,
  fltQuantDil,
  fltPrecoVendaDil,
  fltPrecoVendaTotalDil,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
  fltPrecoCustoCon,
  fltPrecoCustoDil,
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
  fltPesEsp: Double;
  strEmb: String;
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
  dicPrecoAdicional.Limpar;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmb].strSigEmb;

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

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

        arrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        arrComponentes[intContador].Quantidade := ((fltPesoProduto / 100) * dicRetorno['qtdb' + fStrZero(intContador, 2)]) * (arrEmbalagens[intEmb].fltVolume * 1000);
        arrComponentes[intContador].Quantiddil := 0.0;
      End;

      For intPreVen := 1 To 7 Do
      Begin
        fltPrecoVendaTotalCon := 0;
        fltPrecoVendaTotalDil := 0;

        If stlTabPre[intPreVen] <> 'S' Then
          Continue;

        For intContador := 1 To Length(ArrComponentes) Do
        Begin

          If fEmptyStr(arrComponentes[intContador].Componente) Then
            Break;

          If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltEmbala := fRetEmbalagem(qryBases);
          fltPesEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

          //Preço de venda concentrado
          fltQuantCon := arrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / (fltEmbala * fltPesEsp));
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          //Preço de venda diluido
          fltQuantDil := arrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / (fltEmbala * fltPesEsp));
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
        End;

        //Retorna Preço de Embalagem
        If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
        Begin
          If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
          Else
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
        End;

        //Preço de Venda Concentrado
        If fltPrecoVendaTotalCon > 0 Then
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      //Calcula Preço de custo
      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(arrComponentes[intContador].Componente) Then
            Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreCusPro
          Else
            fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        fltEmbala := fRetEmbalagem(qryBases);
        fltPesEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        //Preço de venda concentrado
        fltQuantCon := arrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := fltQuantCon * (fltPrecoBase / (fltEmbala * fltPesEsp));
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preço de venda diluido
        fltQuantDil := arrComponentes[intContador].Quantiddil;
        fltPrecoCustoDil := fltQuantDil * (fltPrecoBase / (fltEmbala * fltPesEsp));
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

      //Preço de Venda Concentrado
      If fltPrecoCustoTotalCon > 0 Then
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon +
          (fltPerAcr * fltPrecoCustoTotalCon) + fltPrecoEmbalagem;

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

procedure TExportaTintometricosTerceirosKillingIndustrial.pRetPrecoTintas(
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
  fltPesEsp: Double;
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
      SetLength(arrComponentes, fQuantidadeFormulacao);

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        arrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        arrComponentes[intContador].Quantidade := ((fltPesoProduto / 100) * dicRetorno['qtdb' + fStrZero(intContador, 2)]) * (arrEmbalagens[intEmb].fltVolume * 1000);
        arrComponentes[intContador].Quantiddil := 0.0;
      End;

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(arrComponentes[intContador].Componente) Then
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
        fltPesEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        //Preço de venda concentrado
        fltQuantCon := arrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / (fltEmbala * fltPesEsp));
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preço de venda diluido
        fltQuantDil := arrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / (fltEmbala * fltPesEsp));
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      //Retorna Preço de Embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem(
            cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      //Preço de Venda Concentrado
      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

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

procedure TExportaTintometricosTerceirosKillingIndustrial.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  strProKin := fRetItemVenda(Conexao);
  pCriaClienteEmbalagem(Conexao);
  pTabelasVendas(Conexao);
end;

procedure TExportaTintometricosTerceirosKillingIndustrial.pTabelasVendas(
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

end.
