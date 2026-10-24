unit untExportaTintometricosTerceirosMazaIndustrial;

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
  TExportaTintometricosTerceirosMazaIndustrial = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProMzd: String;
    fltPesCor: Double;
    fltPesFor: Double;
    blnQtdQdi: Boolean;
    strAcrMob: String;
    qryCadBas: TUniQuery;
    qryDiluente: TUniQuery;
    function fRetValorAcrMobCfgTin(): String;
    procedure pCarregaDiluente();
    procedure pPesoEspecifico();
    function fPesoEspecifico(strBase: String): Double;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fRetDiluente(strLinha: String): String;
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
    function fRetornaBases(): String; Override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; Override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;

    function fRetTipoCor(): String; Override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;
    destructor Destroy; Override;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;

    function fRetItemVenda(Conexao: TUniConnection): String;

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemSP(): String;
  End;


implementation

{ TExportaTintometricosTerceirosMazaIndustrial }

constructor TExportaTintometricosTerceirosMazaIndustrial.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProMzd := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
  pPesoEspecifico();
  pCarregaDiluente();
end;

destructor TExportaTintometricosTerceirosMazaIndustrial.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);

  If Assigned(qryCadBas) Then
    FreeAndNil(qryCadBas);

  If Assigned(qryDiluente) Then
    FreeAndNil(qryDiluente);
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fCamposSelect: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    MZD_CODIGO,       ';
  Result := Result + '    MZD_DTACAD,       ';
  Result := Result + '    MZD_DESCRI,       ';
  Result := Result + '    MZD_VARIAC,       ';
  Result := Result + '    MZD_OBSERV,       ';
  Result := Result + '    MZD_ANOCOR,       ';
  Result := Result + '    MZD_PESCOR,       ';
  Result := Result + '    MZD_PESFOR,       ';
  Result := Result + '    MZD_BAIQDI,       ';
  Result := Result + '    MZD_LINHA_,       ';
  Result := Result + '    LIN_DESCRI,       ';
  Result := Result + '    MON_DESCRI,       ';
  Result := Result + '    MZD_CODNFM,       ';
  Result := Result + '    MZD_UNIVER,       ';
  Result := Result + '    MZD_CODMON,       ';
  Result := Result + '    MZD_ACRMOB,       ';

  For intCont := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    MZD_FORM' + fStrZero(intCont, 2) + ',   ';
    Result := Result + '    MZD_QTDC' + fStrZero(intCont, 2) + ',   ';
  End;

  Result := Result + '    MZD_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    MZD_CADMZD        ';
  Result := Result + '  LEFT JOIN MZD_CADMON ON         ';
  Result := Result + '    MON_CODMON = MZD_CODMON               ';
  Result := Result + '  LEFT JOIN MZD_CADLIN ON         ';
  Result := Result + '    LIN_CODIGO = MZD_LINHA_               ';
  Result := Result + '  WHERE               ';
  Result := Result + '    TRUE;             ';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + ' (  ';
  Result := Result + '    MZD_CODIGO VARCHAR(15),       ';
  Result := Result + '    MZD_DESCRI VARCHAR(50),       ';
  Result := Result + '    MZD_LINHA_ CHAR(3),           ';
  Result := Result + '    MZD_VARIAC VARCHAR(4),        ';
  Result := Result + '    MZD_OBSERV VARCHAR(34),       ';
  Result := Result + '    MZD_UNIVER VARCHAR(12),       ';
  Result := Result + '    MZD_CODMON CHAR(3),           ';
  Result := Result + '    MZD_MD5KEY VARCHAR(32),       ';

  Result := Result + '    MZD_CODITE VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZD_CODDIL VARCHAR(20),       ';
  Result := Result + '    MZD_PORDIL DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRECLT DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRECGL DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRECLA DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRECCP DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRECSP DECIMAL(12,4),     ';

  Result := Result + '    MZD_PREDLT DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREDGL DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREDLA DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREDCP DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREDSP DECIMAL(12,4),     ';

  Result := Result + '    MZD_PCUCLT DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUCGL DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUCLA DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUCCP DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUCSP DECIMAL(12,4),     ';

  Result := Result + '    MZD_PCUDLT DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUDGL DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUDLA DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUDCP DECIMAL(12,4),     ';
  Result := Result + '    MZD_PCUDSP DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRCLT1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLT2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLT3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLT4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLT5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLT6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLT7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRDLT1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLT2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLT3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLT4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLT5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLT6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLT7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRCGL1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCGL2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCGL3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCGL4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCGL5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCGL6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCGL7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRDGL1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDGL2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDGL3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDGL4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDGL5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDGL6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDGL7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRCLA1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLA2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLA3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLA4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLA5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLA6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCLA7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRDLA1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLA2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLA3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLA4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLA5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLA6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDLA7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRCCP1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCCP2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCCP3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCCP4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCCP5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCCP6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCCP7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRDCP1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDCP2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDCP3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDCP4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDCP5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDCP6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDCP7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRCSP1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCSP2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCSP3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCSP4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCSP5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCSP6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRCSP7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_PRDSP1 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDSP2 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDSP3 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDSP4 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDSP5 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDSP6 DECIMAL(12,4),     ';
  Result := Result + '    MZD_PRDSP7 DECIMAL(12,4),     ';

  Result := Result + '    MZD_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZD_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZD_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZD_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZD_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),        ';

  Result := Result + '    MZD_VOLULT DECIMAL(12,4),     ';
  Result := Result + '    MZD_VOLUGL DECIMAL(12,4),     ';
  Result := Result + '    MZD_VOLULA DECIMAL(12,4),     ';
  Result := Result + '    MZD_VOLUCP DECIMAL(12,4),     ';
  Result := Result + '    MZD_VOLUSP DECIMAL(12,4),     ';

  Result := Result + '    MZD_PREELT DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREEGL DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREELA DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREECP DECIMAL(12,4),     ';
  Result := Result + '    MZD_PREESP DECIMAL(12,4),     ';

  Result := Result + '    MZD_TIPOLT CHAR(2),           ';
  Result := Result + '    MZD_TIPOGL CHAR(2),           ';
  Result := Result + '    MZD_TIPOLA CHAR(2),           ';
  Result := Result + '    MZD_TIPOCP CHAR(2),           ';
  Result := Result + '    MZD_TIPOSP CHAR(2)            ';
  Result := Result + '            );                    ';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fNomeTabela: String;
begin
  Result := 'MZD_CADMZD_SIT';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fPesoEspecifico(
  strBase: String): Double;
begin
  Result := 1;

  If qryCadBas.Locate('BAS_CODBAS', strBase, []) Then
    Result := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetDescricao: String;
begin
  Result := 'MZD_DESCRI';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetDiluente(
  strLinha: String): String;
begin
  Result := 'DILUENTE';

  If Pos(strLinha, 'MTS_MTB_MTF_MTN_PU2_MPU_MPF_FPU_') > 0 Then
    Result := 'MAZA THINNER P/ PU 5230'
  Else If Pos(strLinha, 'MBR_MFS_MSB_EI_FLC_MLC_MLX_FLX_') > 0 Then
    Result := 'MAZA THINNER SM 800'
  Else If Pos(strLinha, 'MPC_MPR_MAB_') > 0 Then
    Result := 'MAZA DILUENTE P/ EPOXI DP-003';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetEmbalagemCP: String;
begin
  Result := 'MZDCOP';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetEmbalagemGL: String;
begin
  Result := 'MZDGAL';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetEmbalagemLA: String;
begin
  Result := 'MZDLAT';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetEmbalagemLT: String;
begin
  Result := 'MZDLIT';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetEmbalagemSP: String;
begin
  Result := 'MZDSPR';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'MZD_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetItemVenda(
  Conexao: TUniConnection): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    CFG_VALCFG        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "MZD" AND              ';
    strSQL := strSQL + '    CFG_CODCFG = "MZDPRO" AND           ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '" ';

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

function TExportaTintometricosTerceirosMazaIndustrial.fRetMD5KEY: String;
begin
  Result := 'MZD_MD5KEY';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_DESCRI,         ';
  Result := Result + '    BAS_EMBALA,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    BAS_PESESP,         ';
  Result := Result + '    BAS_LINHA_,         ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,       ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                  ';
  Result := Result + '    MZD_CADBAS          ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    BAS_CODITE = I.ITE_CODITE             ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE           ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '" ';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA()
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP();
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    CFG_VALCFG        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "MZD"  AND             ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND           ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '" ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If Not fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'MZD_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetTipoCor: String;
begin
  Result := 'MZD_LINHA_';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "MZD" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosMazaIndustrial.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela + '   (       ';
  Result := Result + '    MZD_CODIGO,           ';
  Result := Result + '    MZD_DESCRI,           ';
  Result := Result + '    MZD_LINHA_,           ';
  Result := Result + '    MZD_VARIAC,           ';
  Result := Result + '    MZD_OBSERV,           ';
  Result := Result + '    MZD_UNIVER,           ';
  Result := Result + '    MZD_CODMON,           ';
  Result := Result + '    MZD_MD5KEY,           ';
  Result := Result + '    MZD_CODITE,           ';
  Result := Result + '    MZD_CODDIL,           ';
  Result := Result + '    MZD_PORDIL,           ';
  Result := Result + '    MZD_PRECLT,           ';
  Result := Result + '    MZD_PRECGL,           ';
  Result := Result + '    MZD_PRECLA,           ';
  Result := Result + '    MZD_PRECCP,           ';
  Result := Result + '    MZD_PRECSP,           ';
  Result := Result + '    MZD_PREDLT,           ';
  Result := Result + '    MZD_PREDGL,           ';
  Result := Result + '    MZD_PREDLA,           ';
  Result := Result + '    MZD_PREDCP,           ';
  Result := Result + '    MZD_PREDSP,           ';
  Result := Result + '    MZD_PCUCLT,           ';
  Result := Result + '    MZD_PCUCGL,           ';
  Result := Result + '    MZD_PCUCLA,           ';
  Result := Result + '    MZD_PCUCCP,           ';
  Result := Result + '    MZD_PCUCSP,           ';
  Result := Result + '    MZD_PCUDLT,           ';
  Result := Result + '    MZD_PCUDGL,           ';
  Result := Result + '    MZD_PCUDLA,           ';
  Result := Result + '    MZD_PCUDCP,           ';
  Result := Result + '    MZD_PCUDSP,           ';
  Result := Result + '    MZD_PRCLT1,           ';
  Result := Result + '    MZD_PRCLT2,           ';
  Result := Result + '    MZD_PRCLT3,           ';
  Result := Result + '    MZD_PRCLT4,           ';
  Result := Result + '    MZD_PRCLT5,           ';
  Result := Result + '    MZD_PRCLT6,           ';
  Result := Result + '    MZD_PRCLT7,           ';
  Result := Result + '    MZD_PRDLT1,           ';
  Result := Result + '    MZD_PRDLT2,           ';
  Result := Result + '    MZD_PRDLT3,           ';
  Result := Result + '    MZD_PRDLT4,           ';
  Result := Result + '    MZD_PRDLT5,           ';
  Result := Result + '    MZD_PRDLT6,           ';
  Result := Result + '    MZD_PRDLT7,           ';
  Result := Result + '    MZD_PRCGL1,           ';
  Result := Result + '    MZD_PRCGL2,           ';
  Result := Result + '    MZD_PRCGL3,           ';
  Result := Result + '    MZD_PRCGL4,           ';
  Result := Result + '    MZD_PRCGL5,           ';
  Result := Result + '    MZD_PRCGL6,           ';
  Result := Result + '    MZD_PRCGL7,           ';
  Result := Result + '    MZD_PRDGL1,           ';
  Result := Result + '    MZD_PRDGL2,           ';
  Result := Result + '    MZD_PRDGL3,           ';
  Result := Result + '    MZD_PRDGL4,           ';
  Result := Result + '    MZD_PRDGL5,           ';
  Result := Result + '    MZD_PRDGL6,           ';
  Result := Result + '    MZD_PRDGL7,           ';
  Result := Result + '    MZD_PRCLA1,           ';
  Result := Result + '    MZD_PRCLA2,           ';
  Result := Result + '    MZD_PRCLA3,           ';
  Result := Result + '    MZD_PRCLA4,           ';
  Result := Result + '    MZD_PRCLA5,           ';
  Result := Result + '    MZD_PRCLA6,           ';
  Result := Result + '    MZD_PRCLA7,           ';
  Result := Result + '    MZD_PRDLA1,           ';
  Result := Result + '    MZD_PRDLA2,           ';
  Result := Result + '    MZD_PRDLA3,           ';
  Result := Result + '    MZD_PRDLA4,           ';
  Result := Result + '    MZD_PRDLA5,           ';
  Result := Result + '    MZD_PRDLA6,           ';
  Result := Result + '    MZD_PRDLA7,           ';
  Result := Result + '    MZD_PRCCP1,           ';
  Result := Result + '    MZD_PRCCP2,           ';
  Result := Result + '    MZD_PRCCP3,           ';
  Result := Result + '    MZD_PRCCP4,           ';
  Result := Result + '    MZD_PRCCP5,           ';
  Result := Result + '    MZD_PRCCP6,           ';
  Result := Result + '    MZD_PRCCP7,           ';
  Result := Result + '    MZD_PRDCP1,           ';
  Result := Result + '    MZD_PRDCP2,           ';
  Result := Result + '    MZD_PRDCP3,           ';
  Result := Result + '    MZD_PRDCP4,           ';
  Result := Result + '    MZD_PRDCP5,           ';
  Result := Result + '    MZD_PRDCP6,           ';
  Result := Result + '    MZD_PRDCP7,           ';
  Result := Result + '    MZD_PRCSP1,           ';
  Result := Result + '    MZD_PRCSP2,           ';
  Result := Result + '    MZD_PRCSP3,           ';
  Result := Result + '    MZD_PRCSP4,           ';
  Result := Result + '    MZD_PRCSP5,           ';
  Result := Result + '    MZD_PRCSP6,           ';
  Result := Result + '    MZD_PRCSP7,           ';
  Result := Result + '    MZD_PRDSP1,           ';
  Result := Result + '    MZD_PRDSP2,           ';
  Result := Result + '    MZD_PRDSP3,           ';
  Result := Result + '    MZD_PRDSP4,           ';
  Result := Result + '    MZD_PRDSP5,           ';
  Result := Result + '    MZD_PRDSP6,           ';
  Result := Result + '    MZD_PRDSP7,           ';
  Result := Result + '    MZD_EMBALT,           ';
  Result := Result + '    MZD_EMBAGL,           ';
  Result := Result + '    MZD_EMBALA,           ';
  Result := Result + '    MZD_EMBACP,           ';
  Result := Result + '    MZD_EMBASP,           ';
  Result := Result + '    MZD_VOLULT,           ';
  Result := Result + '    MZD_VOLUGL,           ';
  Result := Result + '    MZD_VOLULA,           ';
  Result := Result + '    MZD_VOLUCP,           ';
  Result := Result + '    MZD_VOLUSP,           ';
  Result := Result + '    MZD_PREELT,           ';
  Result := Result + '    MZD_PREEGL,           ';
  Result := Result + '    MZD_PREELA,           ';
  Result := Result + '    MZD_PREECP,           ';
  Result := Result + '    MZD_PREESP,           ';
  Result := Result + '    MZD_TIPOLT,           ';
  Result := Result + '    MZD_TIPOGL,           ';
  Result := Result + '    MZD_TIPOLA,           ';
  Result := Result + '    MZD_TIPOCP,           ';
  Result := Result + '    MZD_TIPOSP            ';
  Result := Result + '          )                                   ';
  Result := Result + '  VALUES        ' +       '      (            ';
  Result := Result + '    :CODIGO,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :LINHA_,              ';
  Result := Result + '    :VARIAC,              ';
  Result := Result + '    :OBSERV,              ';
  Result := Result + '    :UNIVER,              ';
  Result := Result + '    :CODMON,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECLA,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PRECSP,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDLA,              ';
  Result := Result + '    :PREDCP,              ';
  Result := Result + '    :PREDSP,              ';
  Result := Result + '    :PCUCLT,              ';
  Result := Result + '    :PCUCGL,              ';
  Result := Result + '    :PCUCLA,              ';
  Result := Result + '    :PCUCCP,              ';
  Result := Result + '    :PCUCSP,              ';
  Result := Result + '    :PCUDLT,              ';
  Result := Result + '    :PCUDGL,              ';
  Result := Result + '    :PCUDLA,              ';
  Result := Result + '    :PCUDCP,              ';
  Result := Result + '    :PCUDSP,              ';
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
  Result := Result + '    :PRCLA1,              ';
  Result := Result + '    :PRCLA2,              ';
  Result := Result + '    :PRCLA3,              ';
  Result := Result + '    :PRCLA4,              ';
  Result := Result + '    :PRCLA5,              ';
  Result := Result + '    :PRCLA6,              ';
  Result := Result + '    :PRCLA7,              ';
  Result := Result + '    :PRDLA1,              ';
  Result := Result + '    :PRDLA2,              ';
  Result := Result + '    :PRDLA3,              ';
  Result := Result + '    :PRDLA4,              ';
  Result := Result + '    :PRDLA5,              ';
  Result := Result + '    :PRDLA6,              ';
  Result := Result + '    :PRDLA7,              ';
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
  Result := Result + '    :EMBALA,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :EMBASP,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLULA,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :VOLUSP,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREELA,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :PREESP,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOLA,              ';
  Result := Result + '    :TIPOCP,              ';
  Result := Result + '    :TIPOSP               ';
  Result := Result + '        );                                    ';
end;

function TExportaTintometricosTerceirosMazaIndustrial.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_DESCRI').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_LINHA_').AsString);
  DataSet.ParamByName('VARIAC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_VARIAC').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_OBSERV').AsString);
  DataSet.ParamByName('UNIVER').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_UNIVER').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZD_CODMON').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('MZD_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProMzd;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
    End;
  End;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
    Begin
      DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
      DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
      DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
      DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
      DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('MZD_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('MZD_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pCarregaDiluente;
begin
  qryDiluente := fCriaQuery();
  qryDiluente.Close;
  qryDiluente.SQL.Clear;
  qryDiluente.SQL.Add('  SELECT * FROM MZD_CADBAS B    ');
  qryDiluente.SQL.Add('    INNER JOIN CADITE I ON      ');
  qryDiluente.SQL.Add('  B.BAS_CODITE = I.ITE_CODITE   ');
  qryDiluente.SQL.Add('    INNER JOIN ITEGER G ON      ');
  qryDiluente.SQL.Add('  I.ITE_CODITE = G.ITE_CODITE AND   ');
  qryDiluente.SQL.Add('  G.ITE_CODEMP = :CODEMP    ');
  qryDiluente.SQL.Add('  WHERE BAS_EFEITO = :EFEITO        ');

  qryDiluente.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  qryDiluente.ParamByName('EFEITO').AsString  := 'DILUENTE';
  qryDiluente.Open;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    *                 ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "MZD" AND              ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND    ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '" ';

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

procedure TExportaTintometricosTerceirosMazaIndustrial.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosMazaIndustrial.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "MZD"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT (        ';
    strSQL := strSQL + '    LOG_IDEPRO,         ';
    strSQL := strSQL + '    LOG_DTAEXE,         ';
    strSQL := strSQL + '    LOG_HOREXE,         ';
    strSQL := strSQL + '    LOG_EXECUT          ';
    strSQL := strSQL + '          )                       ';
    strSQL := strSQL + '  VALUES    (                     ';
    strSQL := strSQL + '    "MZD",              ';
    strSQL := strSQL + '    :DTAEXE,            ';
    strSQL := strSQL + '    :HOREXE,            ';
    strSQL := strSQL + '    :EXECUT             ';
    strSQL := strSQL + '            )                     ';

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

procedure TExportaTintometricosTerceirosMazaIndustrial.pPesoEspecifico;
begin
  qryCadBas := fCriaQuery();
  qryCadBas.SQL.Add('SELECT * FROM MZD_CADBAS ');
  qryCadBas.Open;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pPreencheArrayEmbalagem;
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
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.450;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.190;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pProcessaTabelaCores(
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

procedure TExportaTintometricosTerceirosMazaIndustrial.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
  fltQuantidade: Double;
  fltVolumeAtual: Double;
begin
  fltPesCor := qryGen.FieldByName('MZD_PESCOR').AsFloat;
  fltPesFor := qryGen.FieldByName('MZD_PESFOR').AsFloat;
  blnQtdQdi := (qryGen.FieldByName('MZD_BAIQDI').AsString = 'S');

  fltQuantidade := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('MZD_QTDC' + fStrZero(intContador, 2)).AsFloat / fPesoEspecifico(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString);

    fltQuantidade := fltQuantidade + dicRetorno['qtdb' + fStrZero(intContador, 2)];
  End;

  fltVolumeAtual := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    dicRetorno['qtdb' + fStrZero(intContador, 2)] := dicRetorno['qtdb' + fStrZero(intContador, 2)] * 900 / fltQuantidade;

    fltVolumeAtual := fltVolumeAtual + dicRetorno['qtdb' + fStrZero(intContador, 2)];

    If blnQtdQdi Then
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('MZD_QTDC' + fStrZero(intContador, 2)).AsFloat
    Else
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := dicRetorno['qtdb' + fStrZero(intContador, 2)] * fPesoEspecifico(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString);
  End;

  Try


    If Not qryDiluente.Locate('BAS_DESCRI', fRetDiluente(qryGen.FieldByName('MZD_LINHA_').AsString), []) Then
      Exit;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If fEmptyStr(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString) Then
        Break;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] :=  dicRetorno['qtdb' + fStrZero(intContador, 2)] / fPesoEspecifico(qryGen.FieldByName('MZD_FORM' + fstrZero(intContador, 2)).AsString);
      dicRetorno['qtdd' + fStrZero(intContador, 2)] :=  ((dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / (1000 + (20 * 10)));
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat(dicRetorno['qtdd' + fStrZero(intContador, 2)] * fPesoEspecifico(qryGen.FieldByName('MZD_FORM' + fstrZero(intContador, 2)).AsString), 2);
    End;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If fEmptyStr(qryGen.FieldByName('MZD_FORM' + fStrZero(intContador, 2)).AsString) Then
      Begin
        dicRetorno['base' + fStrZero(intContador, 2)] := qryDiluente.FieldByName('BAS_CODBAS').AsString;
        dicRetorno['coddil'] := qryDiluente.FieldByName('BAS_CODBAS').AsString;
        dicRetorno['pordil'] := 20;
        dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0.0;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (fltVolumeAtual) * (20 / 100);
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := dicRetorno['qtdd' + fStrZero(intContador, 2)] * qryDiluente.FieldByName('BAS_PESESP').AsFloat;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1 * 1000) / (1 * 1000 + (20 * 10));
        Break;
      End;
    End;
  Finally
  End;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
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
  ArrComponentes: Array of TComp; // TArrComponentes;
  fltPreCusPro, fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
  intEmb: Integer;
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

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / 0.9;
        ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / 0.9;
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

          If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltEmbala := fRetEmbalagem(qryBases);
          fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

          // Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := (fltPrecoBase / fltEmbala) * (fltQuantCon / fltPesoEsp);
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          // Preco de venda Diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := (fltPrecoBase / fltEmbala) * (fltQuantDil / fltPesoEsp);
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

      //Calcula o Preço de custo
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
        fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        // Preco de Custo concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := (fltPrecoBase / fltEmbala) * (fltQuantCon / fltPesoEsp);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preco de Custo Diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoCustoDil := (fltPrecoBase / fltEmbala) * (fltQuantDil / fltPesoEsp);
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
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosMazaIndustrial.pRetPrecoTintas(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
Var
  intContador: Integer;
  fltQuantCon,
  fltQuantDil,
  fltPrecoVendaCon,
  fltPrecoVendaDil,
  fltPrecoVendaTotalCon,
  fltPrecoVendaTotalDil,
  fltPrecoBase,
  fltPrecoEmbalagem: Double;
  strTabelaUnica: String;
  ArrComponentes: Array of TComp; // TArrComponentes;
  fltPreCusPro, fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
  intEmb: Integer;
  strCamEmb: String;
  fltPesoEsp: Double;
begin
  fltPrecoBase := 0;
  fltPrecoEmbalagem := 0;
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  strCodCli := '';
  strCodCnd := '';
  intPrzMed := 0;


  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  // fazer o for das embalagens aqui
  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoVendaTotalDil := 0;

    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb,
      dicRetorno);

    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao);

      // Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := IfNull(dicRetorno['qtdb' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / 0.9;
        ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / 0.9;
      End;

      // Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin

        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador]
          .Componente, []) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        fltEmbala := fRetEmbalagem(qryBases);
        fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        // Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (fltPrecoBase / fltEmbala) * (fltQuantCon / fltPesoEsp);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        // Preco de venda Diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := (fltPrecoBase / fltEmbala) * (fltQuantDil / fltPesoEsp);
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      // Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
        Else
          fltPrecoEmbalagem := fRetornaPrecoVendaEmbalagem
            (cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      // Preco de venda concentrado
      If fltPrecoVendaTotalCon > 0 Then
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
          (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

      // Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      // Adiciona informacoes no array para gravar
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

procedure TExportaTintometricosTerceirosMazaIndustrial.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosMazaIndustrial.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  strProMzd := fRetItemVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.

