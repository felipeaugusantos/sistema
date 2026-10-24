unit untExportaTintometricosTerceirosAnjoAutomotiva;

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
  TExportaTintometricosTerceirosAnjoAutomotiva = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProAnj: String; // Produto para venda Anjo Automotiva
    strAcrMob: String;
    blnDiluido: Boolean;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  Public
    function fNomeTabela(): String; Override;
    function fCamposTabela(): String; Override;
    function fCamposSelect(): String; Override;
    function fQuantidadeFormulacao(): Integer; Override;
    function fFatorTinta(): Double; Override;
    function fRetDescricao(): String; Override;
    function fRetItemBase(): String; Override;
    function fRetMD5KEY(): String; Override;
    function fRetFormula(intCont: Integer): String; Override;
    function fRetQuantidade(intCont: Integer): String; Override;
    function fSQLInsert(): String; Override;
    function fRetornaColorantes(): String; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String;  dicRetorno: TDicionario): String; Override;
    function fRetTipoCor(): String; Override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    //Produto
    function fRetProdutoVenda(Conexao: TUniConnection): String;

    //Embalagem
    function fRetEmbalagemLT(strTipoCor: String): String;
    function fRetEmbalagemGL(strTipoCor: String): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasPreco(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;

    procedure Execute; override;
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;

  End;

implementation

{ TExportaTintometricosTerceirosAnjoAutomotiva }

constructor TExportaTintometricosTerceirosAnjoAutomotiva.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProAnj := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosAnjoAutomotiva.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    AJT_CODIGO,       ';
  Result := Result + '    AJT_DESCRI,       ';
  Result := Result + '    AJT_PRODUT,       ';
  Result := Result + '    AJT_ACABAM,       ';
  Result := Result + '    AJT_VARIAC,       ';
  Result := Result + '    AJT_CORMON,       ';
  Result := Result + '    AJT_ANOINI,       ';
  Result := Result + '    AJT_ANOFIM,       ';
  Result := Result + '    AJT_DTACAD,       ';
  Result := Result + '    AJT_OBSERV,       ';
  Result := Result + '    AJT_CODMON,       ';
  Result := Result + '    MON_DESCRI,       ';
  Result := Result + '    AJT_VOLUME,       ';
  Result := Result + '    AJT_GRAMA_,       ';
  Result := Result + '    AJT_ACRMOB,       ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    AJT_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    AJT_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    AJT_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    AJT_CADAJT        ';
  Result := Result + '  LEFT JOIN AJT_CADMON ON MON_CODMON = AJT_CODMON   ';
  Result := Result + '  WHERE               ';
  Result := Result + '    TRUE              ';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + ' (     ';
  Result := Result + '    AJT_CODIGO VARCHAR(15),             ';
  Result := Result + '    AJT_DESCRI VARCHAR(45),             ';
  Result := Result + '    AJT_PRODUT VARCHAR(100),            ';
  Result := Result + '    AJT_ACABAM VARCHAR(50),             ';
  Result := Result + '    AJT_VARIAC VARCHAR(25),             ';
  Result := Result + '    AJT_CORMON VARCHAR(30),             ';
  Result := Result + '    AJT_ANOINI CHAR(4),                 ';
  Result := Result + '    AJT_ANOFIM CHAR(4),                 ';
  Result := Result + '    AJT_CODMON CHAR(3),                 ';
  Result := Result + '    AJT_OBSERV VARCHAR(34),             ';
  Result := Result + '    AJT_MD5KEY VARCHAR(32),             ';

  Result := Result + '    AJT_CODITE VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    AJT_CODDIL VARCHAR(20),             ';
  Result := Result + '    AJT_PORDIL DECIMAL(12,4),           ';

  Result := Result + '    AJT_PRECLT DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRECGL DECIMAL(12, 4) DEFAULT 0.0000,       ';

  Result := Result + '    AJT_PREDLT DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PREDGL DECIMAL(12, 4) DEFAULT 0.0000,       ';

  Result := Result + '    AJT_PCUSCL DECIMAL(12, 4) DEFAULT 0.0000,       '; //Preço de Custo Concentrado 'Litro'
  Result := Result + '    AJT_PCUSDL DECIMAL(12, 4) DEFAULT 0.0000,       '; //Preço de Custo Diluido 'Litro'

  Result := Result + '    AJT_PCUSCG DECIMAL(12, 4) DEFAULT 0.0000,       '; //Preço de Custo Concentrado 'Galão'
  Result := Result + '    AJT_PCUSDG DECIMAL(12, 4) DEFAULT 0.0000,       '; //Preço de Custo Diluido 'Galão'


  {* PREÇO DE VENDA CONCENTRADO EMBALAGEM 'LITRO' 1 AO 7 - TABELA DE CLIENTES *}
  Result := Result + '    AJT_PRCLT1 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCLT2 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCLT3 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCLT4 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCLT5 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCLT6 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCLT7 DECIMAL(12, 4) DEFAULT 0.0000,       ';

  {* PREÇO DE VENDA DILUIDO EMBALAGEM 'LITRO' 1 AO 7 - TABELA DE CLIENTES *}
  Result := Result + '    AJT_PRDLT1 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDLT2 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDLT3 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDLT4 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDLT5 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDLT6 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDLT7 DECIMAL(12, 4) DEFAULT 0.0000,       ';

  {* PREÇO DE VENDA CONCENTRADO EMBALAGEM 'GALÃO' 1 AO 7 - TABELA DE CLIENTES *}
  Result := Result + '    AJT_PRCGL1 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCGL2 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCGL3 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCGL4 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCGL5 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCGL6 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRCGL7 DECIMAL(12, 4) DEFAULT 0.0000,       ';

  {* PREÇO DE VENDA DILUIDO EMBALAGEM 'GALÃO' 1 AO 7 - TABELA DE CLIENTES *}
  Result := Result + '    AJT_PRDGL1 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDGL2 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDGL3 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDGL4 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDGL5 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDGL6 DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PRDGL7 DECIMAL(12, 4) DEFAULT 0.0000,       ';


  Result := Result + '    AJT_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    AJT_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),              ';

  Result := Result + '    AJT_VOLULT DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_VOLUGL DECIMAL(12, 4) DEFAULT 0.0000,       ';

  Result := Result + '    AJT_PREELT DECIMAL(12, 4) DEFAULT 0.0000,       ';
  Result := Result + '    AJT_PREEGL DECIMAL(12, 4) DEFAULT 0.0000,       ';


  Result := Result + '    AJT_TIPOLT CHAR(2),                 ';
  Result := Result + '    AJT_TIPOGL CHAR(2)                  ';
  Result := Result + '          );                            ';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('AJT_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('AJT_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fNomeTabela: String;
begin
  Result := 'AJT_CADAJT_SIT';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetDescricao: String;
begin
  Result := 'AJT_DESCRI';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetEmbalagem(qryColorantes: TUniQuery): Double;
Begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
End;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetEmbalagemGL(
  strTipoCor: String): String;
begin
  If strTipoCor = 'POLIESTER' Then
    Result := 'AJTGAL_POLI'
  Else If strTipoCor = 'POLIURETANO' Then
    Result := 'AJTGAL_POLU'
  Else If strTipoCor = 'POLIURETANO CONCENTRADO' Then
    Result := 'AJTGAL_POLC'
  Else
    Result := '';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetEmbalagemLT(
  strTipoCor: String): String;
begin

  If strTipoCor = 'POLIESTER' Then
    Result := 'AJTLIT_POLI'
  Else If strTipoCor = 'POLIURETANO' Then
    Result := 'AJTLIT_POLU'
  Else If strTipoCor = 'POLIURETANO CONCENTRADO' Then
    Result := 'AJTLIT_POLC'
  Else
    Result := '';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'AJT_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetMD5KEY: String;
begin
  Result := 'AJT_MD5KEY';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT              ';
  Result := Result + '   BAS_CODITE,       ';
  Result := Result + '   BAS_DESCRI,       ';
  Result := Result + '   BAS_CODBAS,       ';
  Result := Result + '   BAS_PESESP,       ';
  Result := Result + '   BAS_EMBALA,       ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,   ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + ' FROM                ';
  Result := Result + '   AJT_CADBAS        ';
  Result := Result + ' INNER JOIN CADITE I ON      ';
  Result := Result + '   BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + ' INNER JOIN ITEGER G ON      ';
  Result := Result + '   I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + ' WHERE               ';
  Result := Result + '   G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor']);
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT        ');
    qryGen.SQL.Add('    CFG_VALCFG      ');
    qryGen.SQL.Add('  FROM          ');
    qryGen.SQL.Add('    CFGTIN          ');
    qryGen.SQL.Add('  WHERE         ');
    qryGen.SQL.Add('    CFG_IDEPRO = "AJT"  AND   ');
    qryGen.SQL.Add('    CFG_CODCFG = "APREVE" AND   ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetProdutoVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT            ');
    qryGen.SQL.Add('    CFG_VALCFG      ');
    qryGen.SQL.Add('  FROM              ');
    qryGen.SQL.Add('    CFGTIN          ');
    qryGen.SQL.Add('  WHERE CFG_IDEPRO = "AJT" AND      ');
    qryGen.SQL.Add('    CFG_CODCFG = "AJTPRO" AND       ');
    qryGen.SQL.Add('    CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'AJT_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetTipoCor: String;
begin
  Result := 'AJT_PRODUT';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "AJT" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + ' (     ';
  Result := Result + '    AJT_CODIGO,               ';
  Result := Result + '    AJT_DESCRI,               ';
  Result := Result + '    AJT_PRODUT,               ';
  Result := Result + '    AJT_ACABAM,               ';
  Result := Result + '    AJT_VARIAC,               ';
  Result := Result + '    AJT_ANOINI,               ';
  Result := Result + '    AJT_ANOFIM,               ';
  Result := Result + '    AJT_CORMON,               ';
  Result := Result + '    AJT_CODMON,               ';
  Result := Result + '    AJT_OBSERV,               ';
  Result := Result + '    AJT_MD5KEY,               ';
  Result := Result + '    AJT_CODITE,               ';
  Result := Result + '    AJT_CODDIL,               ';
  Result := Result + '    AJT_PORDIL,               ';
  Result := Result + '    AJT_PRECLT,               ';
  Result := Result + '    AJT_PRECGL,               ';
  Result := Result + '    AJT_PREDLT,               ';
  Result := Result + '    AJT_PREDGL,               ';
  Result := Result + '    AJT_PCUSCL,               ';
  Result := Result + '    AJT_PCUSDL,               ';
  Result := Result + '    AJT_PCUSCG,               ';
  Result := Result + '    AJT_PCUSDG,               ';

  Result := Result + '    AJT_PRCLT1,               ';
  Result := Result + '    AJT_PRCLT2,               ';
  Result := Result + '    AJT_PRCLT3,               ';
  Result := Result + '    AJT_PRCLT4,               ';
  Result := Result + '    AJT_PRCLT5,               ';
  Result := Result + '    AJT_PRCLT6,               ';
  Result := Result + '    AJT_PRCLT7,               ';

  Result := Result + '    AJT_PRDLT1,               ';
  Result := Result + '    AJT_PRDLT2,               ';
  Result := Result + '    AJT_PRDLT3,               ';
  Result := Result + '    AJT_PRDLT4,               ';
  Result := Result + '    AJT_PRDLT5,               ';
  Result := Result + '    AJT_PRDLT6,               ';
  Result := Result + '    AJT_PRDLT7,               ';

  Result := Result + '    AJT_PRCGL1,               ';
  Result := Result + '    AJT_PRCGL2,               ';
  Result := Result + '    AJT_PRCGL3,               ';
  Result := Result + '    AJT_PRCGL4,               ';
  Result := Result + '    AJT_PRCGL5,               ';
  Result := Result + '    AJT_PRCGL6,               ';
  Result := Result + '    AJT_PRCGL7,               ';

  Result := Result + '    AJT_PRDGL1,               ';
  Result := Result + '    AJT_PRDGL2,               ';
  Result := Result + '    AJT_PRDGL3,               ';
  Result := Result + '    AJT_PRDGL4,               ';
  Result := Result + '    AJT_PRDGL5,               ';
  Result := Result + '    AJT_PRDGL6,               ';
  Result := Result + '    AJT_PRDGL7,               ';

  Result := Result + '    AJT_EMBALT,               ';
  Result := Result + '    AJT_EMBAGL,               ';
  Result := Result + '    AJT_VOLULT,               ';
  Result := Result + '    AJT_VOLUGL,               ';
  Result := Result + '    AJT_PREELT,               ';
  Result := Result + '    AJT_PREEGL,               ';
  Result := Result + '    AJT_TIPOLT,               ';
  Result := Result + '    AJT_TIPOGL                ';
  Result := Result + '    )                         ';
  Result := Result + '  VALUES ' + '  (             ';
  Result := Result + '    :CODIGO,                  ';
  Result := Result + '    :DESCRI,                  ';
  Result := Result + '    :PRODUT,                  ';
  Result := Result + '    :ACABAM,                  ';
  Result := Result + '    :VARIAC,                  ';
  Result := Result + '    :ANOINI,                  ';
  Result := Result + '    :ANOFIM,                  ';
  Result := Result + '    :CORMON,                  ';
  Result := Result + '    :CODMON,                  ';
  Result := Result + '    :OBSERV,                  ';
  Result := Result + '    :MD5KEY,                  ';
  Result := Result + '    :CODITE,                  ';
  Result := Result + '    :CODDIL,                  ';
  Result := Result + '    :PORDIL,                  ';
  Result := Result + '    :PRECLT,                  ';
  Result := Result + '    :PRECGL,                  ';
  Result := Result + '    :PREDLT,                  ';
  Result := Result + '    :PREDGL,                  ';
  Result := Result + '    :PCUSCL,                  ';
  Result := Result + '    :PCUSDL,                  ';
  Result := Result + '    :PCUSCG,                  ';
  Result := Result + '    :PCUSDG,                  ';

  Result := Result + '    :PRCLT1,                  ';
  Result := Result + '    :PRCLT2,                  ';
  Result := Result + '    :PRCLT3,                  ';
  Result := Result + '    :PRCLT4,                  ';
  Result := Result + '    :PRCLT5,                  ';
  Result := Result + '    :PRCLT6,                  ';
  Result := Result + '    :PRCLT7,                  ';

  Result := Result + '    :PRDLT1,                  ';
  Result := Result + '    :PRDLT2,                  ';
  Result := Result + '    :PRDLT3,                  ';
  Result := Result + '    :PRDLT4,                  ';
  Result := Result + '    :PRDLT5,                  ';
  Result := Result + '    :PRDLT6,                  ';
  Result := Result + '    :PRDLT7,                  ';

  Result := Result + '    :PRCGL1,                  ';
  Result := Result + '    :PRCGL2,                  ';
  Result := Result + '    :PRCGL3,                  ';
  Result := Result + '    :PRCGL4,                  ';
  Result := Result + '    :PRCGL5,                  ';
  Result := Result + '    :PRCGL6,                  ';
  Result := Result + '    :PRCGL7,                  ';

  Result := Result + '    :PRDGL1,                  ';
  Result := Result + '    :PRDGL2,                  ';
  Result := Result + '    :PRDGL3,                  ';
  Result := Result + '    :PRDGL4,                  ';
  Result := Result + '    :PRDGL5,                  ';
  Result := Result + '    :PRDGL6,                  ';
  Result := Result + '    :PRDGL7,                  ';

  Result := Result + '    :EMBALT,                  ';
  Result := Result + '    :EMBAGL,                  ';
  Result := Result + '    :VOLULT,                  ';
  Result := Result + '    :VOLUGL,                  ';
  Result := Result + '    :PREELT,                  ';
  Result := Result + '    :PREEGL,                  ';
  Result := Result + '    :TIPOLT,                  ';
  Result := Result + '    :TIPOGL                   ';
  Result := Result + '        );                    ';
end;

function TExportaTintometricosTerceirosAnjoAutomotiva.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_CODIGO').AsString);
  DataSet.ParamByName('PRODUT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_PRODUT').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_DESCRI').AsString);
  DataSet.ParamByName('ACABAM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_ACABAM').AsString);
  DataSet.ParamByName('VARIAC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_VARIAC').AsString);
  DataSet.ParamByName('ANOINI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_ANOINI').AsString);
  DataSet.ParamByName('ANOFIM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_ANOFIM').AsString);
  DataSet.ParamByName('CORMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_CORMON').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_CODMON').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('AJT_OBSERV').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('AJT_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProAnj;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('AJT_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('AJT_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('AJT_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('AJT_ACRMOB').AsFloat);
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
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('AJT_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('AJT_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('AJT_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('AJT_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('AJT_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('AJT_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('AJT_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('AJT_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT        ');
    qryGen.SQL.Add('    * FROM CFGTIN     ');
    qryGen.SQL.Add('  WHERE CFG_IDEPRO = "AJT" AND  ');
    qryGen.SQL.Add('    CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pGravaTintometricoPorTintaTerceiros(
  qryInsert: TFDQuery; fltPreVen: Double; qryTinta: TUniQuery;
  intParam: Integer);
var
  intEmb: Integer;
  strSigEmb: String;
begin
  Try
    pAdicionaParamentros(qryInsert, qryTinta, fltPreVen, intParam);

    For intEmb := 0 To Length(arrEmbalagens) - 1 Do
    Begin
      strSigEmb := arrEmbalagens[intEmb].strSigEmb;

      qryInsert.ParamByName('PREC' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValCon; //preco concentrado
      qryInsert.ParamByName('PRED' + strSigEmb).AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltValDil; //preco diluido
      qryInsert.ParamByName('EMBA' + strSigEmb).AsStrings[intParam] := arrPrecosPorEmb[intEmb].strIteEmb; //Produto embalagem
      qryInsert.ParamByName('VOLU' + strSigEmb).AsFloats[intParam]  := arrEmbalagens[intEmb].fltVolume;   //Volume vendido
      qryInsert.ParamByName('PREE' + strSigEmb).AsFloats[intParam]  := arrPrecosporEmb[intEmb].fltPreEmb; //Preco da embalagem
      qryInsert.ParamByName('TIPO' + strSigEmb).AsStrings[intParam] := strSigEmb;                         //Tipo da embalagem
      qryInsert.ParamByName('CODDIL').AsStrings[intParam] := arrPrecosPorEmb[intEmb].strCodDil; //Código do diluente
      qryInsert.ParamByName('PORDIL').AsFloats[intParam]  := arrPrecosPorEmb[intEmb].fltPorDil;//Porcentagem do diluente
    End;
  Finally
    SetLength(arrPrecosPorEmb, 0);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryLog: TUniQuery;
begin
  Try
    qryLog := fCriaQuery(Nil, Conexao);
    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add('  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "AJT"   ');
    qryLog.ExecSQL;

    qryLog.SQL.Clear;
    qryLog.SQL.Add('  INSERT INTO LOGTIN_SIT  (       ');
    qryLog.SQL.Add('    LOG_IDEPRO,                   ');
    qryLog.SQL.Add('    LOG_DTAEXE,                   ');
    qryLog.SQL.Add('    LOG_HOREXE,                   ');
    qryLog.SQL.Add('    LOG_EXECUT                    ');
    qryLog.SQL.Add('              )                   ');
    qryLog.SQL.Add('  VALUES  (                       ');
    qryLog.SQL.Add('    "AJT",                        ');
    qryLog.SQL.Add('    :DTAEXE,                      ');
    qryLog.SQL.Add('    :HOREXE,                      ');
    qryLog.SQL.Add('    :EXECUT                       ');
    qryLog.SQL.Add('            );                    ');

    qryLog.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryLog.ParamByName('HOREXE').AsDateTime := Time;
    qryLog.ParamByName('EXECUT').AsString   := strStatus;
    qryLog.ExecSQL;
  Finally
    FreeAndNil(qryLog);
  End;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pPreencheArrayEmbalagem;
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
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pProcessaTabelaCores(
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
    qryInsert.Params.ArraySize := 500;
    intContador := 0;

  {$IFDEF LINUX}
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

    For intRegistros := 0 To Pred(500) Do
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
          If Not blnDiluido Then
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                  arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                  arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON')
          Else
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                  arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
                  arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL');
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

    If intContador > 0  Then
      qryInsert.Execute(intContador, 0);

  {$IFDEF LINUX}
    pEscreverLogProgresso(qryGen);
  {$ENDIF}
  End;

{$IFDEF LINUX}
  fValidarPrecosCalculado(True);
{$ENDIF}
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  blnDiluido := False;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin

    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;


    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;

    If qryGen.FieldByName(fRetFormula(intContador)).AsString = 'TH5003' Then
      blnDiluido := True;
  End;

  If Not blnDiluido Then
    Exit;    //Concentrado

  For intContador := 1 To fQuantidadeFormulacao() Do    // Diluido
  Begin

    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0.0;
    dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat;
  End;

  dicRetorno['coddil'] := 'TH5003';
  dicRetorno['pordil'] := 0.0;
end;

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador,
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
  fltVolumeOri       := 1;

  dicPrecoAdicional.Limpar;

  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

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
        ArrComponentes[intContador].Quantidade := (dicRetorno['qtdb' + fStrZero(intContador, 2)]) * (arrEmbalagens[intEmb].fltVolume / fltVolumeOri);
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

        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;


        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      fltPrecoCustoTotalCon := 0.0;
      fltPrecoCustoTotalDil := 0.0;

      For intContador := 1 To fQuantidadeFormulacao() Do
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

        //Preco de Custo concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := fltQuantCon * (fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preco de Custo diluido
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

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pRetPrecoTintas(
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
  fltVolumeOri       := 1;

  strTabelaUnica := dicRetorno['tabelaunica'];

  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

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
        ArrComponentes[intContador].Quantidade := (dicRetorno['qtdb' + fStrZero(intContador, 2)]) * (arrEmbalagens[intEmb].fltVolume / fltVolumeOri);
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

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pRetTabelasPreco(
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

procedure TExportaTintometricosTerceirosAnjoAutomotiva.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProAnj := fRetProdutoVenda(Conexao);
  pRetTabelasPreco(Conexao);
end;

end.
