unit untExportaTintometricosTerceirosStandox;

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
  untExportaTintometricosTerceirosAutomotiva, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosStandox = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProDox: String; //Produto de venda Standox
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
    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetItemVenda(Conexao: TUniConnection): String;
    function fRetQtdDiluente(strDiluente: String = ''; strPorcentagem: String = '10'): Double;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure pCarregarDados;
    procedure Execute; override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;


implementation

{ TExportaTintometricosTerceirosStandox }

constructor TExportaTintometricosTerceirosStandox.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProDox := '';
  pPreencheEmbalagens;
  pCarregarDados;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosStandox.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosStandox.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosStandox.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                  ';
  Result := Result + '    DOX_CODNFM,           ';
  Result := Result + '    DOX_MONTAD,           ';
  Result := Result + '    DOX_DESCRI,           ';
  Result := Result + '    DOX_ANOINI,           ';
  Result := Result + '    DOX_ANOFIN,           ';
  Result := Result + '    DOX_INFCOR,           ';
  Result := Result + '    DOX_PAINEL,           ';
  Result := Result + '    DOX_QUALID,           ';
  Result := Result + '    DOX_CATEGO,           ';
  Result := Result + '    DOX_VARIAN,           ';
  Result := Result + '    DOX_PAIS__,           ';
  Result := Result + '    DOX_CODSEQ,           ';
  Result := Result + '    DOX_CODDOX,           ';
  Result := Result + '    DOX_ACRMOB,           ';
  Result := Result + '    DOX_VERSAO,           ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    DOX_BASE' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    DOX_QTDC' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    DOX_MD5KEY            ';
  Result := Result + '  FROM                    ';
  Result := Result + '    DOX_CADDOX            ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosStandox.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() + '   (     ';
  Result := Result + '    DOX_CODDOX VARCHAR(15),         ';
  Result := Result + '    DOX_DESCRI VARCHAR(50),         ';
  Result := Result + '    DOX_MONTAD VARCHAR(20),         ';
  Result := Result + '    DOX_PAINEL VARCHAR(15),         ';
  Result := Result + '    DOX_INFCOR VARCHAR(20),         ';
  Result := Result + '    DOX_PAIS__ VARCHAR(30),         ';
  Result := Result + '    DOX_ANOINI VARCHAR(4),          ';
  Result := Result + '    DOX_ANOFIN VARCHAR(4),          ';
  Result := Result + '    DOX_QUALID VARCHAR(50),         ';
  Result := Result + '    DOX_CATEGO VARCHAR(30),         ';
  Result := Result + '    DOX_VERSAO VARCHAR(20),         ';
  Result := Result + '    DOX_MD5KEY VARCHAR(32),         ';
  Result := Result + '    DOX_CODITE VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    DOX_CODDIL VARCHAR(20),         ';
  Result := Result + '    DOX_PORDIL DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    DOX_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    DOX_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    DOX_PCUSCL DECIMAL(12,4),       ';
  Result := Result + '    DOX_PCUSDL DECIMAL(12,4),       ';
  Result := Result + '    DOX_PCUSCG DECIMAL(12,4),       ';
  Result := Result + '    DOX_PCUSDG DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCLT7 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDLT7 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRCGL7 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    DOX_PRDGL7 DECIMAL(12,4),       ';
  Result := Result + '    DOX_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    DOX_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    DOX_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    DOX_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    DOX_PREELT DECIMAL(12,4),       ';
  Result := Result + '    DOX_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    DOX_TIPOLT CHAR(2),             ';
  Result := Result + '    DOX_TIPOGL CHAR(2)              ';
  Result := Result + '            );                                  ';
end;

function TExportaTintometricosTerceirosStandox.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosStandox.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('DOX_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('DOX_BASE' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosStandox.fNomeTabela: String;
begin
  Result := 'DOX_CADDOX_SIT';
end;

function TExportaTintometricosTerceirosStandox.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosStandox.fRetDescricao: String;
begin
  Result := 'DOX_DESCRI';
end;

function TExportaTintometricosTerceirosStandox.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  If qryColorantes.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat
  Else
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosStandox.fRetEmbalagemGL: String;
begin
  Result := 'DOXPGL';
end;

function TExportaTintometricosTerceirosStandox.fRetEmbalagemLT: String;
begin
  Result := 'DOXPLT';
end;

function TExportaTintometricosTerceirosStandox.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'DOX_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosStandox.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosStandox.fRetItemVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "DOX" AND                  ';
    strSQL := strSQL + '    CFG_CODCFG = "PRODOX" AND               ';
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

function TExportaTintometricosTerceirosStandox.fRetMD5KEY: String;
begin
  Result := 'DOX_MD5KEY';
end;

function TExportaTintometricosTerceirosStandox.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    BAS_CODBAS,             ';
  Result := Result + '    BAS_CODITE,             ';
  Result := Result + '    BAS_EMBALA,             ';
  Result := Result + '    BAS_PESESP,             ';
  Result := Result + '    BAS_PESGRA,             ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                      ';
  Result := Result + '    DOX_CADBAS B            ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosStandox.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL();
end;

function TExportaTintometricosTerceirosStandox.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosStandox.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosStandox.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "DOX" AND                ';
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

function TExportaTintometricosTerceirosStandox.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosStandox.fRetQtdDiluente(strDiluente,
  strPorcentagem: String): Double;
begin
  Result := 0;

  If strDiluente = 'MSB 10-20' Then
    Result := 291.7
  Else If strDiluente = 'MSB 15-25' Then
    Result := 283.3
  Else If strDiluente = 'MSB 25-35' Then
    Result := 289.7
  Else If strDiluente = 'STBLCOATA' Then
    Result := IIF(strPorcentagem = '10', 92.7, 170.0)
  Else If strDiluente = 'STBLADJSL' Then
    Result := IIF(strPorcentagem = '10', 92.7, 170.0);
end;

function TExportaTintometricosTerceirosStandox.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'DOX_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosStandox.fRetTipoCor: String;
begin
  Result := 'DOX_INFCOR';
end;

function TExportaTintometricosTerceirosStandox.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "DOX" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosStandox.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + '   (     ';
  Result := Result + '    DOX_CODDOX,           ';
  Result := Result + '    DOX_DESCRI,           ';
  Result := Result + '    DOX_MONTAD,           ';
  Result := Result + '    DOX_PAINEL,           ';
  Result := Result + '    DOX_INFCOR,           ';
  Result := Result + '    DOX_PAIS__,           ';
  Result := Result + '    DOX_ANOINI,           ';
  Result := Result + '    DOX_ANOFIN,           ';
  Result := Result + '    DOX_QUALID,           ';
  Result := Result + '    DOX_CATEGO,           ';
  Result := Result + '    DOX_VERSAO,           ';
  Result := Result + '    DOX_MD5KEY,           ';
  Result := Result + '    DOX_CODITE,           ';
  Result := Result + '    DOX_CODDIL,           ';
  Result := Result + '    DOX_PORDIL,           ';
  Result := Result + '    DOX_PRECLT,           ';
  Result := Result + '    DOX_PRECGL,           ';
  Result := Result + '    DOX_PREDLT,           ';
  Result := Result + '    DOX_PREDGL,           ';
  Result := Result + '    DOX_PCUSCL,           ';
  Result := Result + '    DOX_PCUSDL,           ';
  Result := Result + '    DOX_PCUSCG,           ';
  Result := Result + '    DOX_PCUSDG,           ';
  Result := Result + '    DOX_PRCLT1,           ';
  Result := Result + '    DOX_PRCLT2,           ';
  Result := Result + '    DOX_PRCLT3,           ';
  Result := Result + '    DOX_PRCLT4,           ';
  Result := Result + '    DOX_PRCLT5,           ';
  Result := Result + '    DOX_PRCLT6,           ';
  Result := Result + '    DOX_PRCLT7,           ';
  Result := Result + '    DOX_PRDLT1,           ';
  Result := Result + '    DOX_PRDLT2,           ';
  Result := Result + '    DOX_PRDLT3,           ';
  Result := Result + '    DOX_PRDLT4,           ';
  Result := Result + '    DOX_PRDLT5,           ';
  Result := Result + '    DOX_PRDLT6,           ';
  Result := Result + '    DOX_PRDLT7,           ';
  Result := Result + '    DOX_PRCGL1,           ';
  Result := Result + '    DOX_PRCGL2,           ';
  Result := Result + '    DOX_PRCGL3,           ';
  Result := Result + '    DOX_PRCGL4,           ';
  Result := Result + '    DOX_PRCGL5,           ';
  Result := Result + '    DOX_PRCGL6,           ';
  Result := Result + '    DOX_PRCGL7,           ';
  Result := Result + '    DOX_PRDGL1,           ';
  Result := Result + '    DOX_PRDGL2,           ';
  Result := Result + '    DOX_PRDGL3,           ';
  Result := Result + '    DOX_PRDGL4,           ';
  Result := Result + '    DOX_PRDGL5,           ';
  Result := Result + '    DOX_PRDGL6,           ';
  Result := Result + '    DOX_PRDGL7,           ';
  Result := Result + '    DOX_EMBALT,           ';
  Result := Result + '    DOX_EMBAGL,           ';
  Result := Result + '    DOX_VOLULT,           ';
  Result := Result + '    DOX_VOLUGL,           ';
  Result := Result + '    DOX_PREELT,           ';
  Result := Result + '    DOX_PREEGL,           ';
  Result := Result + '    DOX_TIPOLT,           ';
  Result := Result + '    DOX_TIPOGL            ';
  Result := Result + '            )                                 ';
  Result := Result + '  VALUES        (                             ';
  Result := Result + '    :CODDOX,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :MONTAD,              ';
  Result := Result + '    :PAINEL,              ';
  Result := Result + '    :INFCOR,              ';
  Result := Result + '    :PAIS__,              ';
  Result := Result + '    :ANOINI,              ';
  Result := Result + '    :ANOFIN,              ';
  Result := Result + '    :QUALID,              ';
  Result := Result + '    :CATEGO,              ';
  Result := Result + '    :VERSAO,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PCUSCL,              ';
  Result := Result + '    :PCUSDL,              ';
  Result := Result + '    :PCUSCG,              ';
  Result := Result + '    :PCUSDG,              ';
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
  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL               ';
  Result := Result + '            );                                ';
end;

function TExportaTintometricosTerceirosStandox.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosStandox.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODDOX').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_CODDOX').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_DESCRI').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_MONTAD').AsString);
  DataSet.ParamByName('PAINEL').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_PAINEL').AsString);
  DataSet.ParamByName('INFCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_INFCOR').AsString);
  DataSet.ParamByName('PAIS__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_PAIS__').AsString);
  DataSet.ParamByName('ANOINI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_ANOINI').AsString);
  DataSet.ParamByName('ANOFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_ANOFIN').AsString);
  DataSet.ParamByName('QUALID').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_QUALID').AsString);
  DataSet.ParamByName('CATEGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_CATEGO').AsString);
  DataSet.ParamByName('VERSAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DOX_VERSAO').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('DOX_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProDox;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('DOX_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('DOX_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('DOX_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('DOX_ACRMOB').AsFloat);
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
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('DOX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('DOX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('DOX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('DOX_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('DOX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('DOX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('DOX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('DOX_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosStandox.pCarregarDados;
Var
  qryDiluente: TUniQuery;
  strSQL: String;
begin
  stlDiluentes := TStringList.Create();
  stlDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT             ';
  strSQL := strSQL + '    *                         ';
  strSQL := strSQL + '  FROM                        ';
  strSQL := strSQL + '    DOX_CADBAS B              ';
  strSQL := strSQL + '  INNER JOIN DOX_CADDIL D ON          ';
  strSQL := strSQL + '    D.DIL_CODDIL  = B.BAS_CODBAS              ';

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

procedure TExportaTintometricosTerceirosStandox.pCriaClientEmbalagem(
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
    strSQL := strSQL + '    CFG_IDEPRO = "DOX" AND                  ';
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

procedure TExportaTintometricosTerceirosStandox.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosStandox.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "DOX"       ';

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
    strSQL := strSQL + '    "DOX",              ';
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

procedure TExportaTintometricosTerceirosStandox.pPreencheArrayEmbalagem;
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

procedure TExportaTintometricosTerceirosStandox.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosStandox.pProcessaTabelaCores(
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

procedure TExportaTintometricosTerceirosStandox.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  qryDiluente: TUniQuery;
  strSQL: String;
  fltVolumeAtual: Double;
  intContador: Integer;
begin
  blnDiluido := False;

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT DISTINCT           ';
    strSQL := strSQL + '    *                       ';
    strSQL := strSQL + '  FROM                      ';
    strSQL := strSQL + '    DOX_CADBAS B            ';
    strSQL := strSQL + '  INNER JOIN DOX_CADDIL D ON          ';
    strSQL := strSQL + '    D.DIL_CODDIL = B.BAS_CODBAS             ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON              ';
    strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND         ';
    strSQL := strSQL + '    G.ITE_CODEMP = B.BAS_CODEMP             ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON              ';
    strSQL := strSQL + '    G.ITE_CODITE = I.ITE_CODITE             ';
    strSQL := strSQL + '  WHERE                     ';
    strSQL := strSQL + '    BAS_CODBAS = :CODBAS              ';


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

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
        Break;

      fltVolumeAtual := fltVolumeAtual + (qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat / qryBases.FieldByName('BAS_PESESP').AsFloat);
    End;

    //Aplicando a taxa de diluicao
    For intContador := 1 To fQuantidadeFormulacao () Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
        Break;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] := (qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat / qryBases.FieldByName('BAS_PESESP').AsFloat);
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / fltVolumeAtual;

      If (stlDiluentes[0] = 'STBLCOATA') Or (stlDiluentes[0] = 'STBLADJSL') Then
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / 1100
      Else
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / 1500;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat(dicRetorno['qtdd' + fStrZero(intContador, 2)] * qryBases.FieldByName('BAS_PESESP').AsFloat, 1);
    End;

    //Adicionando o diluente na ultima posicao
    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
      Begin
        dicRetorno['base' + fStrZero(intContador, 2)] := stlDiluentes[0];
        dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := fRetQtdDiluente(stlDiluentes[0], '10');

        dicRetorno['coddil'] := stlDiluentes[0];
        dicRetorno['pordil'] := 10;
        Break;
      End;
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosStandox.pRetPrecosAdicionais(
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

    //Verificar se existe a embalagem
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
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) /1);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) / 1);
      End;

      For intPreVen := 1 To 7 Do
      Begin
        fltPrecoVendaTotalCon := 0;
        fltPrecoVendaTotalDil := 0;

        If stlTabPre[intPreVen] <> 'S' Then
          COntinue;

        For intContador := 1 To fQuantidadeFormulacao() Do
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

      //Calcula o preço de custo
      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

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

        fltEmbala := fRetEmbalagem(qryBases);

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

procedure TExportaTintometricosTerceirosStandox.pRetPrecoTintas(
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
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;

  pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);
end;

procedure TExportaTintometricosTerceirosStandox.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosStandox.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProDox := fRetItemVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.
