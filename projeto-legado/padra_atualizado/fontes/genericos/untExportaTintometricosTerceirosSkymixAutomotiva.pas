unit untExportaTintometricosTerceirosSkymixAutomotiva;

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
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosSkymixAutomotiva = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProSky: String;
    blnConcentrado: Boolean;

    //Variaveis Calculo
    fltVIcmsVen: Double;
    fltPorICMS: Double;
    fltPorIPI: Double;
    fltDifIcmsVen: Double;
    fltVMVAIcmsVen: Double;
    fltVMVAVen: Double;
    fltVIPIVen: Double;
    fltPorMVA: Double;
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

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override; //Calculo Preço
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    // Produto para venda
    function fRetornaProdutoParaVenda(Conexao: TUniConnection): String;


    // Embalagens

    function fRetEmbalagemLT(strTipCor: String): String;
    function fRetEmbalagemGL(strTipCor: String): String;
    function fRetEmbalagemCp(): String;
    function fRetEmbalagemBD(): String;
	function fRetEmbalagemSP(): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);

    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;



  End;

implementation



{ TExportaTintometricosTerceirosSkymixAutomotiva }

constructor TExportaTintometricosTerceirosSkymixAutomotiva.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  pPreencheEmbalagens;
  strProSky := '';
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosSkymixAutomotiva.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                          ';
  Result := Result + '    SKY_CODPRO,                   ';
  Result := Result + '    SKY_DESCRI,                   ';
  Result := Result + '    SKY_ANOFAB,                   ';
  Result := Result + '    SKY_CODUNI,                   ';
  Result := Result + '    SKY_ANUANC,                   ';
  Result := Result + '    SKY_CORPAI,                   ';
  Result := Result + '    SKY_NACIMP,                   ';
  Result := Result + '    SKY_CODMON,                   ';
  Result := Result + '    SKY_CONDIL,                   ';
  Result := Result + '    SKY_CODSGR,                   ';
  Result := Result + '    SKY_CODGRU,                   ';
  Result := Result + '    GRU_LINHA_,                   ';
  Result := Result + '    SGR_ASPECT,                   ';
  Result := Result + '    SKY_VERSAO,                   ';
  Result := Result + '    SKY_CODNFM,                   ';
  Result := Result + '    SKY_VARIAN,                   ';
  Result := Result + '    SKY_OBS001,                   ';
  Result := Result + '    SKY_ACRMOB,                   ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    SKY_FORM' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    SKY_QTDB' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    SKY_QTDC' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    SKY_MD5KEY                    ';

  Result := Result + '  FROM                            ';

  Result := Result + '    SKY_CADSKY                    ';

  Result := Result + '    LEFT JOIN SKY_CADMON ON SKY_CODMON = MON_CODMON ';
  Result := Result + '    LEFT JOIN SKY_CADGRU ON SKY_CODGRU = GRU_CODGRU ';
  Result := Result + '    LEFT JOIN SKY_CADSGR ON SKY_CODSGR = SGR_CODSGR ';

  Result := Result + '  WHERE TRUE;        ';

end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela + ' (   ';
  Result := Result + '    SKY_CODPRO VARCHAR(12),             ';
  Result := Result + '    SKY_DESCRI VARCHAR(40),             ';
  Result := Result + '    SKY_ANOFAB VARCHAR(9),              ';
  Result := Result + '    SKY_CODUNI VARCHAR(20),             ';
  Result := Result + '    SKY_ANUANC VARCHAR(5),              ';
  Result := Result + '    SKY_CORPAI VARCHAR(5),              ';
  Result := Result + '    SKY_NACIMP CHAR(1),                 ';
  Result := Result + '    SKY_CODMON CHAR(3),                 ';
  Result := Result + '    SKY_CONDIL VARCHAR(11),             ';
  Result := Result + '    SKY_CODSGR VARCHAR(5),              ';
  Result := Result + '    SKY_DESSGR VARCHAR(10),             ';
  Result := Result + '    SKY_CODGRU VARCHAR(5),              ';
  Result := Result + '    SKY_LINHA_ VARCHAR(15),             ';
  Result := Result + '    SKY_VERSAO VARCHAR(5),              ';
  Result := Result + '    SKY_CODNFM VARCHAR(12),             ';
  Result := Result + '    SKY_VARIAN VARCHAR(255),            ';
  Result := Result + '    SKY_OBS001 VARCHAR(255),            ';
  Result := Result + '    SKY_MD5KEY VARCHAR(32),             ';

  Result := Result + '    SKY_CODITE VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    SKY_CODDIL VARCHAR(20),             ';
  Result := Result + '    SKY_PORDIL DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRECLT DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRECGL DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRECBD DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRECCP DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRECSP DECIMAL(12,4),           ';

  Result := Result + '    SKY_PREDLT DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREDGL DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREDBD DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREDCP DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREDSP DECIMAL(12,4),           ';

  Result := Result + '    SKY_PCUCLT DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUCGL DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUCBD DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUCCP DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUCSP DECIMAL(12,4),           ';

  Result := Result + '    SKY_PCUDLT DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUDGL DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUDBD DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUDCP DECIMAL(12,4),           ';
  Result := Result + '    SKY_PCUDSP DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRCLT1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCLT2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCLT3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCLT4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCLT5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCLT6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCLT7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRDLT1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDLT2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDLT3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDLT4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDLT5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDLT6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDLT7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRCGL1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCGL2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCGL3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCGL4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCGL5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCGL6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCGL7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRDGL1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDGL2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDGL3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDGL4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDGL5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDGL6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDGL7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRCBD1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCBD2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCBD3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCBD4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCBD5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCBD6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCBD7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRDBD1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDBD2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDBD3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDBD4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDBD5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDBD6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDBD7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRCCP1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCCP2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCCP3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCCP4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCCP5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCCP6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCCP7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRDCP1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDCP2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDCP3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDCP4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDCP5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDCP6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDCP7 DECIMAL(12,4),           ';
  
  Result := Result + '    SKY_PRCSP1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCSP2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCSP3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCSP4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCSP5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCSP6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRCSP7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_PRDSP1 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDSP2 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDSP3 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDSP4 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDSP5 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDSP6 DECIMAL(12,4),           ';
  Result := Result + '    SKY_PRDSP7 DECIMAL(12,4),           ';

  Result := Result + '    SKY_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    SKY_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    SKY_EMBABD VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    SKY_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),              ';
  Result := Result + '    SKY_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),              ';

  Result := Result + '    SKY_VOLULT DECIMAL(12,4),           ';
  Result := Result + '    SKY_VOLUGL DECIMAL(12,4),           ';
  Result := Result + '    SKY_VOLUBD DECIMAL(12,4),           ';
  Result := Result + '    SKY_VOLUCP DECIMAL(12,4),           ';
  Result := Result + '    SKY_VOLUSP DECIMAL(12,4),           ';

  Result := Result + '    SKY_PREELT DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREEGL DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREEBD DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREECP DECIMAL(12,4),           ';
  Result := Result + '    SKY_PREESP DECIMAL(12,4),           ';

  Result := Result + '    SKY_TIPOLT CHAR(2),                 ';
  Result := Result + '    SKY_TIPOGL CHAR(2),                 ';
  Result := Result + '    SKY_TIPOBD CHAR(2),                 ';
  Result := Result + '    SKY_TIPOCP CHAR(2),                 ';
  Result := Result + '    SKY_TIPOSP CHAR(2)                  ';
  Result := Result + '                  );                    ';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('SKY_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('SKY_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fNomeTabela: String;
begin
  Result := 'SKY_CADSKY_SIT';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetDescricao: String;
begin
  Result := 'SKY_DESCRI';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetEmbalagemBD: String;
begin
  Result := 'SKYPBD';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetEmbalagemCp: String;
begin
  Result := 'SKYPCP';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetEmbalagemSp: String;
begin
  Result := 'SKYPSP';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetEmbalagemGL(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('5', strTipCor) > 0 Then
    Result := 'SKYPGA'
  Else If Pos('2', strTipCor) > 0 Then
    Result := 'SKYPGA_POLIESTER'
  ELse If Pos('3', strTipCor) > 0 Then
    Result := 'SKYPGA_POLIESTER'
  Else If Pos('6', strTipCor) > 0 Then
    Result := 'SKYPGA_PU'
  Else If Pos('4', strTipCor) > 0 Then
    Result := 'SKYPGA_SINTETICO'
  Else If Pos('L', strTipCor) > 0 Then
    Result := 'SKYPGA_FROSFL'
  Else If Pos('S', strTipCor) > 0 Then
    Result := 'SKYPGA_FROSFS'
  Else If Pos('P', strTipCor) > 0 Then
    Result := 'SKYPGA_FROSFP';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetEmbalagemLT(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('5', strTipCor) > 0 Then
    Result := 'SKYPQU'
  Else If Pos('2', strTipCor) > 0 Then
    Result := 'SKYPQU_POLIESTER'
  Else If Pos('3', strTipCor) > 0 Then
    Result := 'SKYPQU_POLIESTER'
  Else If Pos('6', strTipCor) > 0 Then
    Result := 'SKYPQU_PU'
  Else If Pos('4', strTipCor) > 0 Then
    Result := 'SKYPQU_SINTETICO'
  Else If Pos('L', strTipCor) > 0 Then
    Result := 'SKYPQU_FROSFL'
  Else If Pos('S', strTipCor) > 0 Then
    Result := 'SKYPQU_FROSFS'
  Else If Pos('P', strTipCor) > 0 Then
    Result := 'SKYPQU_FROSFP';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'SKY_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetMD5KEY: String;
begin
  Result := 'SKY_MD5KEY';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   BAS_CODITE, ';
  Result := Result + '   BAS_CODBAS, ';
  Result := Result + '   BAS_EMBALA, ';
  Result := Result + '   BAS_PESESP, ';
  Result := Result + '   ITE_ICMSAI, ';
  Result := Result + '   ITE_IPISAI, ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN, ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,        ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,        ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,        ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,        ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,        ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,        ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,        ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7         ';
  Result := Result + '  FROM                                 ';
  Result := Result + '    SKY_CADBAS B                       ';
  Result := Result + '    INNER JOIN CADITE I                ';
  Result := Result + '      ON B.BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '    INNER JOIN ITEGER G                ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor'])
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP
  Else If strSigEmb = 'SP' Then
	Result := fRetEmbalagemSP;

end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('   SELECT CFG_VALCFG   ');
      SQL.Add('     FROM CFGTIN       ');
      SQL.Add('   WHERE CFG_IDEPRO = "SKY" AND    ');
      SQL.Add('         CFG_CODEMP = ' +  QuotedStr(VS_strCodEmp) + ' AND ' );
      SQL.Add('         CFG_CODCFG = "APREVE"     ');
      Open;

      If fEmptyStr(FieldByName('CFG_VALCFG').AsString) Then
        Result := 0
      Else
        Result := fStrToFloat(FieldByName('CFG_VALCFG').AsString) / 100.0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetornaProdutoParaVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('   SELECT CFG_VALCFG     ');
      SQL.Add('     FROM  CFGTIN        ');
      SQL.Add('   WHERE CFG_IDEPRO = "SKY" AND   ');
      SQL.Add('         CFG_GRUCFG = "CONFIGURACOES" AND   ');
      SQL.Add('         CFG_CODCFG = "SKYPRO" AND ');
      SQL.Add('         CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;
    End;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'SKY_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetTipoCor: String;
begin
  Result := 'SKY_CODGRU';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "SKY" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela + ' (         ';

  Result := Result + '    SKY_CODPRO,                             ';
  Result := Result + '    SKY_DESCRI,                             ';
  Result := Result + '    SKY_ANOFAB,                             ';
  Result := Result + '    SKY_CODUNI,                             ';
  Result := Result + '    SKY_ANUANC,                             ';
  Result := Result + '    SKY_CORPAI,                             ';
  Result := Result + '    SKY_NACIMP,                             ';
  Result := Result + '    SKY_CODMON,                             ';
  Result := Result + '    SKY_CONDIL,                             ';
  Result := Result + '    SKY_CODSGR,                             ';
  Result := Result + '    SKY_DESSGR,                             ';
  Result := Result + '    SKY_CODGRU,                             ';
  Result := Result + '    SKY_LINHA_,                             ';
  Result := Result + '    SKY_VERSAO,                             ';
  Result := Result + '    SKY_CODNFM,                             ';
  Result := Result + '    SKY_VARIAN,                             ';
  Result := Result + '    SKY_OBS001,                             ';
  Result := Result + '    SKY_MD5KEY,                             ';

  Result := Result + '    SKY_CODITE,                             ';
  Result := Result + '    SKY_CODDIL,                             ';
  Result := Result + '    SKY_PORDIL,                             ';

  Result := Result + '    SKY_PRECLT,                             ';
  Result := Result + '    SKY_PRECGL,                             ';
  Result := Result + '    SKY_PRECBD,                             ';
  Result := Result + '    SKY_PRECCP,                             ';
  Result := Result + '    SKY_PRECSP,                             ';

  Result := Result + '    SKY_PREDLT,                             ';
  Result := Result + '    SKY_PREDGL,                             ';
  Result := Result + '    SKY_PREDBD,                             ';
  Result := Result + '    SKY_PREDCP,                             ';
  Result := Result + '    SKY_PREDSP,                             ';

  Result := Result + '    SKY_PCUCLT,                             ';
  Result := Result + '    SKY_PCUCGL,                             ';
  Result := Result + '    SKY_PCUCBD,                             ';
  Result := Result + '    SKY_PCUCCP,                             ';
  Result := Result + '    SKY_PCUCSP,                             ';

  Result := Result + '    SKY_PCUDLT,                             ';
  Result := Result + '    SKY_PCUDGL,                             ';
  Result := Result + '    SKY_PCUDBD,                             ';
  Result := Result + '    SKY_PCUDCP,                             ';
  Result := Result + '    SKY_PCUDSP,                             ';

  Result := Result + '    SKY_PRCLT1,                             ';
  Result := Result + '    SKY_PRCLT2,                             ';
  Result := Result + '    SKY_PRCLT3,                             ';
  Result := Result + '    SKY_PRCLT4,                             ';
  Result := Result + '    SKY_PRCLT5,                             ';
  Result := Result + '    SKY_PRCLT6,                             ';
  Result := Result + '    SKY_PRCLT7,                             ';

  Result := Result + '    SKY_PRDLT1,                             ';
  Result := Result + '    SKY_PRDLT2,                             ';
  Result := Result + '    SKY_PRDLT3,                             ';
  Result := Result + '    SKY_PRDLT4,                             ';
  Result := Result + '    SKY_PRDLT5,                             ';
  Result := Result + '    SKY_PRDLT6,                             ';
  Result := Result + '    SKY_PRDLT7,                             ';

  Result := Result + '    SKY_PRCGL1,                             ';
  Result := Result + '    SKY_PRCGL2,                             ';
  Result := Result + '    SKY_PRCGL3,                             ';
  Result := Result + '    SKY_PRCGL4,                             ';
  Result := Result + '    SKY_PRCGL5,                             ';
  Result := Result + '    SKY_PRCGL6,                             ';
  Result := Result + '    SKY_PRCGL7,                             ';

  Result := Result + '    SKY_PRDGL1,                             ';
  Result := Result + '    SKY_PRDGL2,                             ';
  Result := Result + '    SKY_PRDGL3,                             ';
  Result := Result + '    SKY_PRDGL4,                             ';
  Result := Result + '    SKY_PRDGL5,                             ';
  Result := Result + '    SKY_PRDGL6,                             ';
  Result := Result + '    SKY_PRDGL7,                             ';

  Result := Result + '    SKY_PRCBD1,                             ';
  Result := Result + '    SKY_PRCBD2,                             ';
  Result := Result + '    SKY_PRCBD3,                             ';
  Result := Result + '    SKY_PRCBD4,                             ';
  Result := Result + '    SKY_PRCBD5,                             ';
  Result := Result + '    SKY_PRCBD6,                             ';
  Result := Result + '    SKY_PRCBD7,                             ';

  Result := Result + '    SKY_PRDBD1,                             ';
  Result := Result + '    SKY_PRDBD2,                             ';
  Result := Result + '    SKY_PRDBD3,                             ';
  Result := Result + '    SKY_PRDBD4,                             ';
  Result := Result + '    SKY_PRDBD5,                             ';
  Result := Result + '    SKY_PRDBD6,                             ';
  Result := Result + '    SKY_PRDBD7,                             ';

  Result := Result + '    SKY_PRCCP1,                             ';
  Result := Result + '    SKY_PRCCP2,                             ';
  Result := Result + '    SKY_PRCCP3,                             ';
  Result := Result + '    SKY_PRCCP4,                             ';
  Result := Result + '    SKY_PRCCP5,                             ';
  Result := Result + '    SKY_PRCCP6,                             ';
  Result := Result + '    SKY_PRCCP7,                             ';

  Result := Result + '    SKY_PRDCP1,                             ';
  Result := Result + '    SKY_PRDCP2,                             ';
  Result := Result + '    SKY_PRDCP3,                             ';
  Result := Result + '    SKY_PRDCP4,                             ';
  Result := Result + '    SKY_PRDCP5,                             ';
  Result := Result + '    SKY_PRDCP6,                             ';
  Result := Result + '    SKY_PRDCP7,                             ';
  
  Result := Result + '    SKY_PRCSP1,                             ';
  Result := Result + '    SKY_PRCSP2,                             ';
  Result := Result + '    SKY_PRCSP3,                             ';
  Result := Result + '    SKY_PRCSP4,                             ';
  Result := Result + '    SKY_PRCSP5,                             ';
  Result := Result + '    SKY_PRCSP6,                             ';
  Result := Result + '    SKY_PRCSP7,                             ';

  Result := Result + '    SKY_PRDSP1,                             ';
  Result := Result + '    SKY_PRDSP2,                             ';
  Result := Result + '    SKY_PRDSP3,                             ';
  Result := Result + '    SKY_PRDSP4,                             ';
  Result := Result + '    SKY_PRDSP5,                             ';
  Result := Result + '    SKY_PRDSP6,                             ';
  Result := Result + '    SKY_PRDSP7,                             ';

  Result := Result + '    SKY_EMBALT,                             ';
  Result := Result + '    SKY_EMBAGL,                             ';
  Result := Result + '    SKY_EMBABD,                             ';
  Result := Result + '    SKY_EMBACP,                             ';
  Result := Result + '    SKY_EMBASP,                             ';

  Result := Result + '    SKY_VOLULT,                             ';
  Result := Result + '    SKY_VOLUGL,                             ';
  Result := Result + '    SKY_VOLUBD,                             ';
  Result := Result + '    SKY_VOLUCP,                             ';
  Result := Result + '    SKY_VOLUSP,                             ';

  Result := Result + '    SKY_PREELT,                             ';
  Result := Result + '    SKY_PREEGL,                             ';
  Result := Result + '    SKY_PREEBD,                             ';
  Result := Result + '    SKY_PREECP,                             ';
  Result := Result + '    SKY_PREESP,                             ';

  Result := Result + '    SKY_TIPOLT,                             ';
  Result := Result + '    SKY_TIPOGL,                             ';
  Result := Result + '    SKY_TIPOBD,                             ';
  Result := Result + '    SKY_TIPOCP,                             ';
  Result := Result + '    SKY_TIPOSP                              ';
  Result := Result + '                  )                         ';

  Result := Result + '  VALUES  (                                 ';

  Result := Result + '    :CODPRO,                                ';
  Result := Result + '    :DESCRI,                                ';
  Result := Result + '    :ANOFAB,                                ';
  Result := Result + '    :CODUNI,                                ';
  Result := Result + '    :ANUANC,                                ';
  Result := Result + '    :CORPAI,                                ';
  Result := Result + '    :NACIMP,                                ';
  Result := Result + '    :CODMON,                                ';
  Result := Result + '    :CONDIL,                                ';
  Result := Result + '    :CODSGR,                                ';
  Result := Result + '    :DESSGR,                                ';
  Result := Result + '    :CODGRU,                                ';
  Result := Result + '    :LINHA_,                                ';
  Result := Result + '    :VERSAO,                                ';
  Result := Result + '    :CODNFM,                                ';
  Result := Result + '    :VARIAN,                                ';
  Result := Result + '    :OBS001,                                ';
  Result := Result + '    :MD5KEY,                                ';

  Result := Result + '    :CODITE,                                ';
  Result := Result + '    :CODDIL,                                ';
  Result := Result + '    :PORDIL,                                ';

  Result := Result + '    :PRECLT,                                ';
  Result := Result + '    :PRECGL,                                ';
  Result := Result + '    :PRECBD,                                ';
  Result := Result + '    :PRECCP,                                ';
  Result := Result + '    :PRECSP,                                ';

  Result := Result + '    :PREDLT,                                ';
  Result := Result + '    :PREDGL,                                ';
  Result := Result + '    :PREDBD,                                ';
  Result := Result + '    :PREDCP,                                ';
  Result := Result + '    :PREDSP,                                ';

  Result := Result + '    :PCUCLT,                                ';
  Result := Result + '    :PCUCGL,                                ';
  Result := Result + '    :PCUCBD,                                ';
  Result := Result + '    :PCUCCP,                                ';
  Result := Result + '    :PCUCSP,                                ';

  Result := Result + '    :PCUDLT,                                ';
  Result := Result + '    :PCUDGL,                                ';
  Result := Result + '    :PCUDBD,                                ';
  Result := Result + '    :PCUDCP,                                ';
  Result := Result + '    :PCUDSP,                                ';

  Result := Result + '    :PRCLT1,                                ';
  Result := Result + '    :PRCLT2,                                ';
  Result := Result + '    :PRCLT3,                                ';
  Result := Result + '    :PRCLT4,                                ';
  Result := Result + '    :PRCLT5,                                ';
  Result := Result + '    :PRCLT6,                                ';
  Result := Result + '    :PRCLT7,                                ';

  Result := Result + '    :PRDLT1,                                ';
  Result := Result + '    :PRDLT2,                                ';
  Result := Result + '    :PRDLT3,                                ';
  Result := Result + '    :PRDLT4,                                ';
  Result := Result + '    :PRDLT5,                                ';
  Result := Result + '    :PRDLT6,                                ';
  Result := Result + '    :PRDLT7,                                ';

  Result := Result + '    :PRCGL1,                                ';
  Result := Result + '    :PRCGL2,                                ';
  Result := Result + '    :PRCGL3,                                ';
  Result := Result + '    :PRCGL4,                                ';
  Result := Result + '    :PRCGL5,                                ';
  Result := Result + '    :PRCGL6,                                ';
  Result := Result + '    :PRCGL7,                                ';

  Result := Result + '    :PRDGL1,                                ';
  Result := Result + '    :PRDGL2,                                ';
  Result := Result + '    :PRDGL3,                                ';
  Result := Result + '    :PRDGL4,                                ';
  Result := Result + '    :PRDGL5,                                ';
  Result := Result + '    :PRDGL6,                                ';
  Result := Result + '    :PRDGL7,                                ';

  Result := Result + '    :PRCBD1,                                ';
  Result := Result + '    :PRCBD2,                                ';
  Result := Result + '    :PRCBD3,                                ';
  Result := Result + '    :PRCBD4,                                ';
  Result := Result + '    :PRCBD5,                                ';
  Result := Result + '    :PRCBD6,                                ';
  Result := Result + '    :PRCBD7,                                ';

  Result := Result + '    :PRDBD1,                                ';
  Result := Result + '    :PRDBD2,                                ';
  Result := Result + '    :PRDBD3,                                ';
  Result := Result + '    :PRDBD4,                                ';
  Result := Result + '    :PRDBD5,                                ';
  Result := Result + '    :PRDBD6,                                ';
  Result := Result + '    :PRDBD7,                                ';

  Result := Result + '    :PRCCP1,                                ';
  Result := Result + '    :PRCCP2,                                ';
  Result := Result + '    :PRCCP3,                                ';
  Result := Result + '    :PRCCP4,                                ';
  Result := Result + '    :PRCCP5,                                ';
  Result := Result + '    :PRCCP6,                                ';
  Result := Result + '    :PRCCP7,                                ';

  Result := Result + '    :PRDCP1,                                ';
  Result := Result + '    :PRDCP2,                                ';
  Result := Result + '    :PRDCP3,                                ';
  Result := Result + '    :PRDCP4,                                ';
  Result := Result + '    :PRDCP5,                                ';
  Result := Result + '    :PRDCP6,                                ';
  Result := Result + '    :PRDCP7,                                ';
  
  Result := Result + '    :PRCSP1,                                ';
  Result := Result + '    :PRCSP2,                                ';
  Result := Result + '    :PRCSP3,                                ';
  Result := Result + '    :PRCSP4,                                ';
  Result := Result + '    :PRCSP5,                                ';
  Result := Result + '    :PRCSP6,                                ';
  Result := Result + '    :PRCSP7,                                ';

  Result := Result + '    :PRDSP1,                                ';
  Result := Result + '    :PRDSP2,                                ';
  Result := Result + '    :PRDSP3,                                ';
  Result := Result + '    :PRDSP4,                                ';
  Result := Result + '    :PRDSP5,                                ';
  Result := Result + '    :PRDSP6,                                ';
  Result := Result + '    :PRDSP7,                                ';

  Result := Result + '    :EMBALT,                                ';
  Result := Result + '    :EMBAGL,                                ';
  Result := Result + '    :EMBABD,                                ';
  Result := Result + '    :EMBACP,                                ';
  Result := Result + '    :EMBASP,                                ';

  Result := Result + '    :VOLULT,                                ';
  Result := Result + '    :VOLUGL,                                ';
  Result := Result + '    :VOLUBD,                                ';
  Result := Result + '    :VOLUCP,                                ';
  Result := Result + '    :VOLUSP,                                ';

  Result := Result + '    :PREELT,                                ';
  Result := Result + '    :PREEGL,                                ';
  Result := Result + '    :PREEBD,                                ';
  Result := Result + '    :PREECP,                                ';
  Result := Result + '    :PREESP,                                ';

  Result := Result + '    :TIPOLT,                                ';
  Result := Result + '    :TIPOGL,                                ';
  Result := Result + '    :TIPOBD,                                ';
  Result := Result + '    :TIPOCP,                                 ';
  Result := Result + '    :TIPOSP                                 ';
  Result := Result + '                  );                        ';
end;

function TExportaTintometricosTerceirosSkymixAutomotiva.fValorQuantidade(
  fltValor, fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODPRO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CODPRO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_DESCRI').AsString);
  DataSet.ParamByName('ANOFAB').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_ANOFAB').AsString);
  DataSet.ParamByName('CODUNI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CODUNI').AsString);
  DataSet.ParamByName('ANUANC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_ANUANC').AsString);
  DataSet.ParamByName('CORPAI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CORPAI').AsString);
  DataSet.ParamByName('NACIMP').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_NACIMP').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CODMON').AsString);
  DataSet.ParamByName('CONDIL').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CONDIL').AsString);
  DataSet.ParamByName('CODSGR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CODSGR').AsString);
  DataSet.ParamByName('CODGRU').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CODGRU').AsString);
  DataSet.ParamByName('VERSAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_VERSAO').AsString);
  DataSet.ParamByName('CODNFM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_CODNFM').AsString);
  DataSet.ParamByName('VARIAN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_VARIAN').AsString);
  DataSet.ParamByName('DESSGR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SGR_ASPECT').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('GRU_LINHA_').AsString);
  DataSet.ParamByName('OBS001').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('SKY_OBS001').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('SKY_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProSky;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUCBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUDBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
      DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
  	  DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
		    DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('SKY_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
		    DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('SKY_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pCriaClientEmbalagem(
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
      SQL.Add('   SELECT *  ');
      SQL.Add('     FROM CFGTIN     ');
      SQL.Add('   WHERE CFG_IDEPRO = "SKY" AND    ');
      SQL.Add('         CFG_GRUCFG = "CONFIGURACOES"  AND  ');
      SQL.Add('         CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;
    End;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pProcessaTabelaCores(
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
        For intEmb := 0 To 2 Do
        Begin
          If blnConcentrado Then
          Begin
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
              arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
              arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');
          End
          Else
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

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intZerar: Integer;
begin
  blnConcentrado := True;

  If qryGen.FieldByName('SKY_CONDIL').AsString <> 'DILUIDO' Then
    Exit;

  blnConcentrado := False;

  For intZerar := 1 To fQuantidadeFormulacao Do //Zerando quantidades concentradas
  Begin
    If fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intZerar, 2)], '')) Then
      Break;

    If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intZerar, 2)], [])) Then
      Break;

    dicRetorno['qtdb' + fStrZero(intZerar, 2)] := 0.0000;
    dicRetorno['qtdd' + fStrZero(intZerar, 2)] := qryGen.FieldByName('SKY_QTDB' + fStrZero(intZerar, 2)).AsFloat;
  End;

  dicRetorno['coddil'] := 'TH700';
  dicRetorno['pordil'] := 0;
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
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
  fltFatCon: Double;
  fltFatDil: Double;
  strEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltPorMVA          := 0;

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

        fltEmbala := fRetEmbalagem(qryBases);

        If Not fEmptyStr(dicRetorno['qtdb' + fStrZero(intContador, 2)]) Then
        Begin
          fltFatCon := dicRetorno['qtdb'+ fStrZero(intContador, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat;
          fltFatCon := fltFatCon / fltEmbala;
        End
        Else
        Begin
          fltFatCon := 0;
        End;

        fltFatDil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);

        If fltFatDil <> 0 Then
        Begin
          fltFatDil := dicRetorno['qtdd'+ fStrZero(intContador, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat;
          fltFatDil := fltFatDil / fltEmbala;
        End
        Else
        Begin
          fltFatDil := 0;
        End;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := fltFatCon * arrEmbalagens[intEmb].fltVolume;
        ArrComponentes[intContador].Quantiddil := fltFatDil * arrEmbalagens[intEmb].fltVolume;
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

          If (ArrComponentes[intContador].Quantidade > 0) And (qryBases.FieldByName('BAS_CODBAS').AsString = 'TH700' ) Then
            Continue;

          fltPorICMS   := qryBases.FieldByName('ITE_ICMSAI').AsFloat / 100;
          fltPorIPI    := qryBases.FieldByName('ITE_IPISAI').AsFloat / 100;
          fltVIcmsVen  := fFormataFloat(fltPrecoBase, 4) * fFormataFloat(fltPorICMS, 4);

          fltVIPIVen   := fltPrecoBase * fltPorIPI;
          fltVIPIVen   := fltVIPIVen + fltPrecoBase;

          fltVMVAVen   := fltVIPIVen * fltPorMVA;
          fltVMVAVen   := fltPorMVA + fltVIPIVen;

          fltVMVAIcmsVen := fltVMVAVen * fltPORICMS;
          fltDifIcmsVen := fltVMVAIcmsVen - fltVIcmsVen;
          fltPrecoBase := fltVIPIVen + fltDifIcmsVen;



          //Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := (fltQuantCon * fltPrecoBase / 0.9);
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := (fltQuantDil * fltPrecoBase / 0.9);
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

        If (ArrComponentes[intContador].Quantidade > 0) And (qryBases.FieldByName('BAS_CODBAS').AsString = 'TH700' ) Then
            Continue;

        fltPorICMS   := qryBases.FieldByName('ITE_ICMSAI').AsFloat / 100;
        fltPorIPI    := qryBases.FieldByName('ITE_IPISAI').AsFloat / 100;
        fltVIcmsVen  := fFormataFloat(fltPrecoBase, 4) * fFormataFloat(fltPorICMS, 4);

        fltVIPIVen   := fltPrecoBase * fltPorIPI;
        fltVIPIVen   := fltVIPIVen + fltPrecoBase;

        fltVMVAVen   := fltVIPIVen * fltPorMVA;
        fltVMVAVen   := fltPorMVA + fltVIPIVen;

        fltVMVAIcmsVen := fltVMVAVen * fltPORICMS;
        fltDifIcmsVen := fltVMVAIcmsVen - fltVIcmsVen;
        fltPrecoBase := fltVIPIVen + fltDifIcmsVen;

        //Preco de custo concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := (fltQuantCon * fltPrecoBase / 0.9);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preco de custo diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoCustoDil := (fltQuantDil * fltPrecoBase / 0.9);
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

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
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
  fltFatCon: Double;
  fltFatDil: Double;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltPorMVA          := 0;

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

         fltEmbala := fRetEmbalagem(qryBases);

         If Not fEmptyStr(dicRetorno['qtdb' + fStrZero(intContador, 2)]) Then
         Begin
           fltFatCon := dicRetorno['qtdb'+ fStrZero(intContador, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat;
           fltFatCon := fltFatCon / fltEmbala;
         End
         Else
         Begin
           fltFatCon := 0;
         End;

         fltFatDil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);

         If fltFatDil <> 0 Then
         Begin
           fltFatDil := dicRetorno['qtdd'+ fStrZero(intContador, 2)] / qryBases.FieldByName('BAS_PESESP').AsFloat;
           fltFatDil := fltFatDil / fltEmbala;
         End
         Else
         Begin
           fltFatDil := 0;
         End;

         ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
         ArrComponentes[intContador].Quantidade := fltFatCon * arrEmbalagens[intEmb].fltVolume;
         ArrComponentes[intContador].Quantiddil := fltFatDil * arrEmbalagens[intEmb].fltVolume;
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

         If (ArrComponentes[intContador].Quantidade > 0) And (qryBases.FieldByName('BAS_CODBAS').AsString = 'TH700' ) Then
           Continue;

         fltPorICMS   := qryBases.FieldByName('ITE_ICMSAI').AsFloat / 100;
         fltPorIPI    := qryBases.FieldByName('ITE_IPISAI').AsFloat / 100;
         fltVIcmsVen  := fFormataFloat(fltPrecoBase, 4) * fFormataFloat(fltPorICMS, 4);

         fltVIPIVen   := fltPrecoBase * fltPorIPI;
         fltVIPIVen   := fltVIPIVen + fltPrecoBase;

         fltVMVAVen   := fltVIPIVen * fltPorMVA;
         fltVMVAVen   := fltPorMVA + fltVIPIVen;

         fltVMVAIcmsVen := fltVMVAVen * fltPORICMS;

         fltDifIcmsVen := fltVMVAIcmsVen - fltVIcmsVen;

         fltPrecoBase := fltVIPIVen + fltDifIcmsVen;



         //Preco de venda concentrado
         fltQuantCon := ArrComponentes[intContador].Quantidade;
         fltPrecoVendaCon := (fltQuantCon * fltPrecoBase / 0.9);
         fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

         //Preco de venda diluido
         fltQuantDil := ArrComponentes[intContador].Quantiddil;
         fltPrecoVendaDil := (fltQuantDil * fltPrecoBase / 0.9);
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

      pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  strProSky := fRetornaProdutoParaVenda(Conexao);
  pCriaClientEmbalagem(Conexao);
  pRetTabelasVenda(Conexao);
end;

procedure TExportaTintometricosTerceirosSkyMixAutomotiva.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  //Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.9;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.6;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);
  
  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.100;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.450;

end;

procedure TExportaTintometricosTerceirosSkymixAutomotiva.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "SKY"  ');
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('    INSERT INTO LOGTIN_SIT    (     ');
    qryGen.SQL.Add('      LOG_IDEPRO,                   ');
    qryGen.SQL.Add('      LOG_DTAEXE,                   ');
    qryGen.SQL.Add('      LOG_HOREXE,                   ');
    qryGen.SQL.Add('      LOG_EXECUT                    ');
    qryGen.SQL.Add('                )                   ');
    qryGen.SQL.Add('    VALUES (                        ');
    qryGen.SQL.Add('      "SKY",                        ');
    qryGen.SQL.Add('      :DTAEXE,                      ');
    qryGen.SQL.Add('      :HOREXE,                      ');
    qryGen.SQL.Add('      :EXECUT                       ');
    qryGen.SQL.Add('              );                    ');

    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.


