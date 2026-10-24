unit untExportaTintometricosTerceirosBrazilianColor;

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
  TExportaTintometricosTerceirosBrazilianColor = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProBzc: String;
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

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;

    function fRetornaProdutoParaVenda(Conexao: TUniConnection): String;
    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;

implementation

{ TExportaTintometricosTerceirosBrazilianColor }

constructor TExportaTintometricosTerceirosBrazilianColor.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProBzc := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosBrazilianColor.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosBrazilianColor.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosBrazilianColor.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    BZC_CODIGO,           ';
  Result := Result + '    BZC_CODNFM,           ';
  Result := Result + '    BZC_DESCRI,           ';
  Result := Result + '    BZC_ESPECI,           ';
  Result := Result + '    BZC_REVISA,           ';
  Result := Result + '    BZC_CODSUF,           ';
  Result := Result + '    BZC_AUTORI,           ';
  Result := Result + '    BZC_CODUNI,           ';
  Result := Result + '    BZC_A_N_O_,           ';
  Result := Result + '    BZC_CODMON,           ';
  Result := Result + '    BZC_LINHA_,           ';
  Result := Result + '    MON_DESCRI,           ';
  Result := Result + '    BZC_TIPO__,           ';
  Result := Result + '    BZC_DTACAD,           ';
  Result := Result + '    BZC_ACRMOB,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    BZC_BASE' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    BZC_QTDC' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    BZC_QTDD' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    BZC_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    BZC_CADBZC            ';
  Result := Result + '  LEFT JOIN BZC_CADMON ON       ';
  Result := Result + '    BZC_CODMON = MON_CODMON         ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosBrazilianColor.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + ' (       ';
  Result := Result + '    BZC_CODIGO VARCHAR(15) DEFAULT NULL,          ';
  Result := Result + '    BZC_DESCRI VARCHAR(100) DEFAULT NULL,         ';
  Result := Result + '    BZC_CODUNI VARCHAR(30) DEFAULT NULL,          ';
  Result := Result + '    BZC_A_N_O_ VARCHAR(4) DEFAULT NULL,           ';
  Result := Result + '    BZC_CODMON VARCHAR(5) DEFAULT NULL,           ';
  Result := Result + '    BZC_REVISA VARCHAR(10) DEFAULT NULL,          ';
  Result := Result + '    BZC_ESPECI VARCHAR(255) DEFAULT NULL,         ';
  Result := Result + '    BZC_TIPO__ VARCHAR(50) DEFAULT NULL,          ';
  Result := Result + '    BZC_AUTORI VARCHAR(50) DEFAULT NULL,          ';
  Result := Result + '    BZC_LINHA_ VARCHAR(35) DEFAULT NULL,          ';
  Result := Result + '    BZC_CODITE VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    BZC_MD5KEY VARCHAR(32) DEFAULT NULL,          ';

  Result := Result + '    BZC_CODDIL VARCHAR(20) DEFAULT NULL,          ';
  Result := Result + '    BZC_PORDIL DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRECLT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRECGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRECLA DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PREDLT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PREDGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PREDLA DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PCUCLT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PCUCGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PCUCLA DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PCUDLT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PCUDGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PCUDLA DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRCLT1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLT2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLT3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLT4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLT5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLT6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLT7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRDLT1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLT2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLT3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLT4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLT5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLT6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLT7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRCGL1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCGL2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCGL3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCGL4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCGL5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCGL6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCGL7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRDGL1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDGL2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDGL3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDGL4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDGL5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDGL6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDGL7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRCLA1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLA2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLA3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLA4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLA5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLA6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRCLA7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PRDLA1 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLA2 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLA3 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLA4 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLA5 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLA6 DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PRDLA7 DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_EMBALT VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    BZC_EMBAGL VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';
  Result := Result + '    BZC_EMBALA VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,           ';

  Result := Result + '    BZC_VOLULT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_VOLUGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_VOLULA DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_PREELT DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PREEGL DECIMAL(12,4) DEFAULT 0.0000,      ';
  Result := Result + '    BZC_PREELA DECIMAL(12,4) DEFAULT 0.0000,      ';

  Result := Result + '    BZC_TIPOLT CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    BZC_TIPOGL CHAR(2) DEFAULT NULL,              ';
  Result := Result + '    BZC_TIPOLA CHAR(2) DEFAULT NULL               ';
  Result := Result + '          );                                      ';
end;

function TExportaTintometricosTerceirosBrazilianColor.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosBrazilianColor.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('BZC_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('BZC_BASE' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosBrazilianColor.fNomeTabela: String;
begin
  Result := 'BZC_CADBZC_SIT';
end;

function TExportaTintometricosTerceirosBrazilianColor.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetDescricao: String;
begin
  Result := 'BZC_DESCRI';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetEmbalagemGL: String;
begin
  Result := 'EMBGAL';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetEmbalagemLA: String;
begin
  Result := 'EMBLAT';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetEmbalagemLT: String;
begin
  Result := 'EMBLIT';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'BZC_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetMD5KEY: String;
begin
  Result := 'BZC_MD5KEY';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    BAS_CODBAS,           ';
  Result := Result + '    BAS_DESBAS,           ';
  Result := Result + '    BAS_CODITE,           ';
  Result := Result + '    BAS_ESPECI,           ';
  Result := Result + '    BAS_PESESP,           ';
  Result := Result + '    BAS_EMBALA,           ';
  Result := Result + '    ITE_PREVE'  + fRetornaTabelaPreco + ' AS ITE_PREVEN,  ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                    ';
  Result := Result + '    BZC_CADBAS B           ';
  Result := Result + '  INNER JOIN CADITE I ON        ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE      ';
  Result := Result + '  INNER JOIN ITEGER G ON        ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE     ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    G.ITE_CODEMP = '  + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA();
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT        ';
    strSQL := strSQL + '    CFG_VALCFG        ';
    strSQL := strSQL + '  FROM          ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE         ';
    strSQL := strSQL + '    CFG_IDEPRO = "BZC" AND      ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND   ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

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

function TExportaTintometricosTerceirosBrazilianColor.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetornaProdutoParaVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "BZC" AND    ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND    ';
    strSQL := strSQL + '    CFG_CODCFG = "CODPRO" AND   ';
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

function TExportaTintometricosTerceirosBrazilianColor.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'BZC_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetTipoCor: String;
begin
  Result := 'BZC_LINHA_';
end;

function TExportaTintometricosTerceirosBrazilianColor.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "BZC" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;
function TExportaTintometricosTerceirosBrazilianColor.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + '   (     ';
  Result := Result + '    BZC_CODIGO,             ';
  Result := Result + '    BZC_DESCRI,             ';
  Result := Result + '    BZC_CODUNI,             ';
  Result := Result + '    BZC_A_N_O_,             ';
  Result := Result + '    BZC_CODMON,             ';
  Result := Result + '    BZC_REVISA,             ';
  Result := Result + '    BZC_ESPECI,             ';
  Result := Result + '    BZC_TIPO__,             ';
  Result := Result + '    BZC_AUTORI,             ';
  Result := Result + '    BZC_LINHA_,             ';
  Result := Result + '    BZC_CODITE,             ';
  Result := Result + '    BZC_MD5KEY,             ';
  Result := Result + '    BZC_CODDIL,             ';
  Result := Result + '    BZC_PORDIL,             ';
  Result := Result + '    BZC_PRECLT,             ';
  Result := Result + '    BZC_PRECGL,             ';
  Result := Result + '    BZC_PRECLA,             ';
  Result := Result + '    BZC_PREDLT,             ';
  Result := Result + '    BZC_PREDGL,             ';
  Result := Result + '    BZC_PREDLA,             ';
  Result := Result + '    BZC_PCUCLT,             ';
  Result := Result + '    BZC_PCUDLT,             ';
  Result := Result + '    BZC_PCUCGL,             ';
  Result := Result + '    BZC_PCUDGL,             ';
  Result := Result + '    BZC_PCUCLA,             ';
  Result := Result + '    BZC_PCUDLA,             ';
  Result := Result + '    BZC_PRCLT1,             ';
  Result := Result + '    BZC_PRCLT2,             ';
  Result := Result + '    BZC_PRCLT3,             ';
  Result := Result + '    BZC_PRCLT4,             ';
  Result := Result + '    BZC_PRCLT5,             ';
  Result := Result + '    BZC_PRCLT6,             ';
  Result := Result + '    BZC_PRCLT7,             ';
  Result := Result + '    BZC_PRDLT1,             ';
  Result := Result + '    BZC_PRDLT2,             ';
  Result := Result + '    BZC_PRDLT3,             ';
  Result := Result + '    BZC_PRDLT4,             ';
  Result := Result + '    BZC_PRDLT5,             ';
  Result := Result + '    BZC_PRDLT6,             ';
  Result := Result + '    BZC_PRDLT7,             ';
  Result := Result + '    BZC_PRCGL1,             ';
  Result := Result + '    BZC_PRCGL2,             ';
  Result := Result + '    BZC_PRCGL3,             ';
  Result := Result + '    BZC_PRCGL4,             ';
  Result := Result + '    BZC_PRCGL5,             ';
  Result := Result + '    BZC_PRCGL6,             ';
  Result := Result + '    BZC_PRCGL7,             ';
  Result := Result + '    BZC_PRDGL1,             ';
  Result := Result + '    BZC_PRDGL2,             ';
  Result := Result + '    BZC_PRDGL3,             ';
  Result := Result + '    BZC_PRDGL4,             ';
  Result := Result + '    BZC_PRDGL5,             ';
  Result := Result + '    BZC_PRDGL6,             ';
  Result := Result + '    BZC_PRDGL7,             ';
  Result := Result + '    BZC_PRCLA1,             ';
  Result := Result + '    BZC_PRCLA2,             ';
  Result := Result + '    BZC_PRCLA3,             ';
  Result := Result + '    BZC_PRCLA4,             ';
  Result := Result + '    BZC_PRCLA5,             ';
  Result := Result + '    BZC_PRCLA6,             ';
  Result := Result + '    BZC_PRCLA7,             ';
  Result := Result + '    BZC_PRDLA1,             ';
  Result := Result + '    BZC_PRDLA2,             ';
  Result := Result + '    BZC_PRDLA3,             ';
  Result := Result + '    BZC_PRDLA4,             ';
  Result := Result + '    BZC_PRDLA5,             ';
  Result := Result + '    BZC_PRDLA6,             ';
  Result := Result + '    BZC_PRDLA7,             ';
  Result := Result + '    BZC_EMBALT,             ';
  Result := Result + '    BZC_EMBAGL,             ';
  Result := Result + '    BZC_EMBALA,             ';
  Result := Result + '    BZC_VOLULT,             ';
  Result := Result + '    BZC_VOLUGL,             ';
  Result := Result + '    BZC_VOLULA,             ';
  Result := Result + '    BZC_PREELT,             ';
  Result := Result + '    BZC_PREEGL,             ';
  Result := Result + '    BZC_PREELA,             ';
  Result := Result + '    BZC_TIPOLT,             ';
  Result := Result + '    BZC_TIPOGL,             ';
  Result := Result + '    BZC_TIPOLA              ';
  Result := Result + '      )                     ';
  Result := Result + '  VALUES  ' + '   (         ';
  Result := Result + '    :CODIGO,                ';
  Result := Result + '    :DESCRI,                ';
  Result := Result + '    :CODUNI,                ';
  Result := Result + '    :A_N_O_,                ';
  Result := Result + '    :CODMON,                ';
  Result := Result + '    :REVISA,                ';
  Result := Result + '    :ESPECI,                ';
  Result := Result + '    :TIPO__,                ';
  Result := Result + '    :AUTORI,                ';
  Result := Result + '    :LINHA_,                ';
  Result := Result + '    :CODITE,                ';
  Result := Result + '    :MD5KEY,                ';
  Result := Result + '    :CODDIL,                ';
  Result := Result + '    :PORDIL,                ';
  Result := Result + '    :PRECLT,                ';
  Result := Result + '    :PRECGL,                ';
  Result := Result + '    :PRECLA,                ';
  Result := Result + '    :PREDLT,                ';
  Result := Result + '    :PREDGL,                ';
  Result := Result + '    :PREDLA,                ';
  Result := Result + '    :PCUCLT,                ';
  Result := Result + '    :PCUDLT,                ';
  Result := Result + '    :PCUCGL,                ';
  Result := Result + '    :PCUDGL,                ';
  Result := Result + '    :PCUCLA,                ';
  Result := Result + '    :PCUDLA,                ';
  Result := Result + '    :PRCLT1,                ';
  Result := Result + '    :PRCLT2,                ';
  Result := Result + '    :PRCLT3,                ';
  Result := Result + '    :PRCLT4,                ';
  Result := Result + '    :PRCLT5,                ';
  Result := Result + '    :PRCLT6,                ';
  Result := Result + '    :PRCLT7,                ';
  Result := Result + '    :PRDLT1,                ';
  Result := Result + '    :PRDLT2,                ';
  Result := Result + '    :PRDLT3,                ';
  Result := Result + '    :PRDLT4,                ';
  Result := Result + '    :PRDLT5,                ';
  Result := Result + '    :PRDLT6,                ';
  Result := Result + '    :PRDLT7,                ';
  Result := Result + '    :PRCGL1,                ';
  Result := Result + '    :PRCGL2,                ';
  Result := Result + '    :PRCGL3,                ';
  Result := Result + '    :PRCGL4,                ';
  Result := Result + '    :PRCGL5,                ';
  Result := Result + '    :PRCGL6,                ';
  Result := Result + '    :PRCGL7,                ';
  Result := Result + '    :PRDGL1,                ';
  Result := Result + '    :PRDGL2,                ';
  Result := Result + '    :PRDGL3,                ';
  Result := Result + '    :PRDGL4,                ';
  Result := Result + '    :PRDGL5,                ';
  Result := Result + '    :PRDGL6,                ';
  Result := Result + '    :PRDGL7,                ';
  Result := Result + '    :PRCLA1,                ';
  Result := Result + '    :PRCLA2,                ';
  Result := Result + '    :PRCLA3,                ';
  Result := Result + '    :PRCLA4,                ';
  Result := Result + '    :PRCLA5,                ';
  Result := Result + '    :PRCLA6,                ';
  Result := Result + '    :PRCLA7,                ';
  Result := Result + '    :PRDLA1,                ';
  Result := Result + '    :PRDLA2,                ';
  Result := Result + '    :PRDLA3,                ';
  Result := Result + '    :PRDLA4,                ';
  Result := Result + '    :PRDLA5,                ';
  Result := Result + '    :PRDLA6,                ';
  Result := Result + '    :PRDLA7,                ';
  Result := Result + '    :EMBALT,                ';
  Result := Result + '    :EMBAGL,                ';
  Result := Result + '    :EMBALA,                ';
  Result := Result + '    :VOLULT,                ';
  Result := Result + '    :VOLUGL,                ';
  Result := Result + '    :VOLULA,                ';
  Result := Result + '    :PREELT,                ';
  Result := Result + '    :PREEGL,                ';
  Result := Result + '    :PREELA,                ';
  Result := Result + '    :TIPOLT,                ';
  Result := Result + '    :TIPOGL,                ';
  Result := Result + '    :TIPOLA                 ';
  Result := Result + '      );                    ';
end;

function TExportaTintometricosTerceirosBrazilianColor.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosBrazilianColor.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_DESCRI').AsString);
  DataSet.ParamByName('CODUNI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_CODUNI').AsString);
  DataSet.ParamByName('A_N_O_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_A_N_O_').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_CODMON').AsString);
  DataSet.ParamByName('REVISA').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_REVISA').AsString);
  DataSet.ParamByName('ESPECI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_ESPECI').AsString);
  DataSet.ParamByName('TIPO__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_TIPO__').AsString);
  DataSet.ParamByName('AUTORI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_AUTORI').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZC_LINHA_').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('BZC_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProBzc;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]   := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
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
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('BZC_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('BZC_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosBrazilianColor.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
     strSQL := '';
     strSQL := strSQL + ' SELECT                ';
     strSQL := strSQL + '   *                   ';
     strSQL := strSQL + ' FROM                  ';
     strSQL := strSQL + '   CFGTIN              ';
     strSQL := strSQL + ' WHERE                 ';
     strSQL := strSQL + '   CFG_IDEPRO = "BZC" AND      ';
     strSQL := strSQL + '   CFG_GRUCFG = "CONFIGURACOES"  AND     ';
     strSQL := strSQL + '   CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

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

procedure TExportaTintometricosTerceirosBrazilianColor.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosBrazilianColor.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "BZC"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO ' + ' LOGTIN_SIT  ' + ' (     ';
    strSQL := strSQL + '    LOG_IDEPRO,             ';
    strSQL := strSQL + '    LOG_DTAEXE,             ';
    strSQL := strSQL + '    LOG_HOREXE,             ';
    strSQL := strSQL + '    LOG_EXECUT              ';
    strSQL := strSQL + '        )                   ';
    strSQL := strSQL + '  VALUES  ' + ' (           ';
    strSQL := strSQL + '    "BZC",                  ';
    strSQL := strSQL + '    :DTAEXE,                ';
    strSQL := strSQL + '    :HOREXE,                ';
    strSQL := strSQL + '    :EXECUT                 ';
    strSQL := strSQL + '      );                    ';

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

procedure TExportaTintometricosTerceirosBrazilianColor.pPreencheArrayEmbalagem;
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

  //Lata
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.00;
end;

procedure TExportaTintometricosTerceirosBrazilianColor.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosBrazilianColor.pProcessaTabelaCores(
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
         If qryGen.FieldByName('BZC_QTDC01').AsFloat > 0 Then
         Begin
          pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');
         End;

          If qryGen.FieldByName('BZC_QTDD01').AsFloat > 0 Then
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

procedure TExportaTintometricosTerceirosBrazilianColor.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  inherited;

  If qryGen.FieldByName('BZC_QTDD01').AsFloat <= 0 Then
    Exit; //Formula apenas concentrada

  If (qryGen.FieldByName('BZC_QTDC01').AsFloat > 0) And (qryGen.FieldByName('BZC_QTDD01').AsFloat > 0) Then     // Concentrado e Diluido
  Begin

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
        Break;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('BZC_QTDD' + fStrZero(intContador, 2)).AsFloat;
    End;
  End
  Else If (qryGen.FieldByName('BZC_QTDD01').AsFloat > 0) Then    // Apenas Diluido
  Begin

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
        Break;

      dicRetorno['qtdc' + fStrZero(intContador, 2)] := 0.0000;
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('BZC_QTDD' + fStrZero(intContador, 2)).AsFloat;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosBrazilianColor.pRetPrecosAdicionais(
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
  fltPrecoCustoCon,
  fltPrecoCustoDil,
  fltPrecoCustoTotalCon,
  fltPrecoCustoTotalDil,
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
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltVolumeOri       := 0.900;

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));
  strTabelaUnica := dicRetorno['tabelaunica'];
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

      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

      //Calcula o Preço de Custo
      For intContador := 1 To Length(ArrComponentes) Do
      Begin

        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreCusPro
          Else
            fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        fltEmbala  := fRetEmbalagem(qryBases);

        //Preco de custo concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon   := fltQuantCon * (fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preço de custo diluido
        fltQuantDil := arrComponentes[intContador].Quantiddil;
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

      If fltPrecoCustoTotalCon > 0 Then
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoEmbalagem;

      If fltPrecoCustoTotalDil > 0 Then
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoEmbalagem;

      dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
      dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosBrazilianColor.pRetPrecoTintas(
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
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltVolumeOri       := 0.900;

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  strTabelaUnica := dicRetorno['tabelaunica'];

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

procedure TExportaTintometricosTerceirosBrazilianColor.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosBrazilianColor.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProBzc := fRetornaProdutoParaVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.
