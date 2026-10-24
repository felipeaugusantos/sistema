unit untExportaTintometricosTerceirosMazaAutomotiva;

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
  TExportaTintometricosTerceirosMazaAutomotiva = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProMza: String;  // Produto de Venda Maza Automotiva
    fltPesCor: Double;
    fltPesFor: Double;
    blnQtdQdi: Boolean;
    strAcrMob: String;
    qryCadBas: TUniQuery;
    qryDiluente: TUniQuery;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    procedure pCarregaDiluente();
    procedure pPesoEspecifico();
    function fPesoEspecifico(strBase: String): Double;
    function fRetDiluente(strLinha: String): String;
    function fRetPorDiluente(strLinha: String): Double;
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
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); Override;
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
    function fRetEmbalagemCO(): String;
    function fRetEmbalagemSP(): String;
  End;

implementation

{ TExportaTintometricosTerceirosMazaAutomotiva }

constructor TExportaTintometricosTerceirosMazaAutomotiva.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProMza := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
  pPesoEspecifico();
  pCarregaDiluente();
end;

destructor TExportaTintometricosTerceirosMazaAutomotiva.Destroy;
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    MZA_CODIGO,       ';
  Result := Result + '    MZA_DESCRI,       ';
  Result := Result + '    MZA_DTACAD,       ';
  Result := Result + '    MZA_VARIAC,       ';
  Result := Result + '    MZA_OBSERV,       ';
  Result := Result + '    MZA_ANOCOR,       ';
  Result := Result + '    MZA_PESCOR,       ';
  Result := Result + '    MZA_PESFOR,       ';
  Result := Result + '    MZA_BAIQDI,       ';
  Result := Result + '    MZA_LINHA_,       ';
  Result := Result + '    LIN_DESCRI,       ';
  Result := Result + '    MON_DESCRI,       ';
  Result := Result + '    MZA_CODNFM,       ';
  Result := Result + '    MZA_UNIVER,       ';
  Result := Result + '    MZA_CODMON,       ';
  Result := Result + '    MZA_ACRMOB,       ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    MZA_FORM' + fStrZero(intContador, 2) + ',   ';
    Result := Result + '    MZA_QTDC' + fStrZero(intContador, 2) + ',   ';
  End;

  Result := Result + '    MZA_MD5KEY        ';
  Result := Result + '  FROM                ';
  Result := Result + '    MZA_CADMZA        ';
  Result := Result + '  LEFT JOIN MZA_CADMON ON       ';
  Result := Result + '    MON_CODMON = MZA_CODMON           ';
  Result := Result + '  LEFT JOIN MZA_CADLIN ON       ';
  Result := Result + '    LIN_CODIGO = MZA_LINHA_           ';
  Result := Result + '  WHERE               ';
  Result := Result + '    TRUE              ';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + ' (  ';
  Result := Result + '    MZA_CODIGO VARCHAR(15),       ';
  Result := Result + '    MZA_DESCRI VARCHAR(50),       ';
  Result := Result + '    MZA_LINHA_ CHAR(3),           ';
  Result := Result + '    MZA_UNIVER VARCHAR(12),       ';
  Result := Result + '    MZA_OBSERV VARCHAR(34),       ';
  Result := Result + '    MZA_CODMON CHAR(3),           ';
  Result := Result + '    MZA_MD5KEY VARCHAR(32),       ';

  Result := Result + '    MZA_CODITE VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZA_CODDIL VARCHAR(20),       ';
  Result := Result + '    MZA_PORDIL DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRECLT DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRECGL DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRECLA DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRECCP DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRECSP DECIMAL(12,4),     ';

  Result := Result + '    MZA_PREDLT DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREDGL DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREDLA DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREDCP DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREDSP DECIMAL(12,4),     ';

  Result := Result + '    MZA_PCUSCL DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSCG DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSCA DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSCC DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSCS DECIMAL(12,4),     ';

  Result := Result + '    MZA_PCUSDL DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSDG DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSDA DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSDC DECIMAL(12,4),     ';
  Result := Result + '    MZA_PCUSDS DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRCLT1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLT2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLT3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLT4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLT5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLT6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLT7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRDLT1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLT2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLT3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLT4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLT5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLT6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLT7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRCGL1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCGL2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCGL3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCGL4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCGL5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCGL6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCGL7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRDGL1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDGL2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDGL3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDGL4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDGL5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDGL6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDGL7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRCLA1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLA2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLA3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLA4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLA5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLA6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCLA7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRDLA1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLA2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLA3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLA4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLA5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLA6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDLA7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRCCP1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCCP2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCCP3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCCP4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCCP5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCCP6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCCP7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRDCP1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDCP2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDCP3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDCP4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDCP5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDCP6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDCP7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRCSP1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCSP2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCSP3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCSP4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCSP5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCSP6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRCSP7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_PRDSP1 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDSP2 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDSP3 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDSP4 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDSP5 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDSP6 DECIMAL(12,4),     ';
  Result := Result + '    MZA_PRDSP7 DECIMAL(12,4),     ';

  Result := Result + '    MZA_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZA_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZA_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZA_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),        ';
  Result := Result + '    MZA_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),        ';

  Result := Result + '    MZA_VOLULT DECIMAL(12,4),     ';
  Result := Result + '    MZA_VOLUGL DECIMAL(12,4),     ';
  Result := Result + '    MZA_VOLULA DECIMAL(12,4),     ';
  Result := Result + '    MZA_VOLUCP DECIMAL(12,4),     ';
  Result := Result + '    MZA_VOLUSP DECIMAL(12,4),     ';

  Result := Result + '    MZA_PREELT DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREEGL DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREELA DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREECP DECIMAL(12,4),     ';
  Result := Result + '    MZA_PREESP DECIMAL(12,4),     ';

  Result := Result + '    MZA_TIPOLT CHAR(2),           ';
  Result := Result + '    MZA_TIPOGL CHAR(2),           ';
  Result := Result + '    MZA_TIPOLA CHAR(2),           ';
  Result := Result + '    MZA_TIPOCP CHAR(2),           ';
  Result := Result + '    MZA_TIPOSP CHAR(2)            ';
  Result := Result + '            );                    ';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fNomeTabela: String;
begin
  Result := 'MZA_CADMZA_SIT';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fPesoEspecifico(
  strBase: String): Double;
begin
  Result := 1;

  If qryCadBas.Locate('BAS_CODBAS', strBase, []) Then
    Result := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetDescricao: String;
begin
  Result := 'MZA_DESCRI';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetDiluente(
  strLinha: String): String;
begin
  Result := 'DILUENTE';

  If Pos(strLinha, 'MTS_MTB_MTF_MTN_PU2_MPU_MPF_FPU_') > 0 Then
    Result := 'MAZA THINNER P/ PU 5230'
  Else If Pos(strLinha, 'MBR_MFS_MSB_EI_FLC_MLC_MLX_FLX_') > 0 Then
    Result := 'MAZA THINNER SM 800'
  Else If Pos(strLinha, 'MPC_MPR_MAB_') > 0 Then
    Result := 'MAZA DILUENTE P/ EPOXI DP-003'
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetEmbalagemCO: String;
begin
  Result := 'MZACOP';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetEmbalagemGL: String;
begin
  Result := 'MZAGAL';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetEmbalagemLA: String;
begin
  Result := 'MZALAT';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetEmbalagemLT: String;
begin
  Result := 'MZALIT';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetEmbalagemSP: String;
begin
  Result := 'MZASPR';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'MZA_FORM' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetItemVenda(
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
    strSQL := strSQL + '    CFG_IDEPRO = "MZA" AND              ';
    strSQL := strSQL + '    CFG_CODCFG = "MZAPRO" AND           ';
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

function TExportaTintometricosTerceirosMazaAutomotiva.fRetMD5KEY: String;
begin
  Result := 'MZA_MD5KEY';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_DESCRI,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    BAS_EMBALA,         ';
  Result := Result + '    BAS_PESESP,         ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,        ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                  ';
  Result := Result + '    MZA_CADBAS B        ';
  Result := Result + '  INNER JOIN CADITE I ON        ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE           ';
  Result := Result + '  INNER JOIN ITEGER G ON        ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE           ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '" ';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetornaCampoEmbalagem(
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
    Result := fRetEmbalagemCO()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP();
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "MZA" AND              ';
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

function TExportaTintometricosTerceirosMazaAutomotiva.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetPorDiluente(
  strLinha: String): Double;
begin
  Result := 20;

  If strLinha = 'MLC' Then
    Result := 100;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'MZA_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetTipoCor: String;
begin
  Result := 'MZA_LINHA_';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "MZA" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela() + ' (  ';
  Result := Result + '    MZA_CODIGO,         ';
  Result := Result + '    MZA_DESCRI,         ';
  Result := Result + '    MZA_LINHA_,         ';
  Result := Result + '    MZA_UNIVER,         ';
  Result := Result + '    MZA_OBSERV,         ';
  Result := Result + '    MZA_CODMON,         ';
  Result := Result + '    MZA_MD5KEY,         ';

  Result := Result + '    MZA_CODITE,         ';
  Result := Result + '    MZA_CODDIL,         ';
  Result := Result + '    MZA_PORDIL,         ';

  Result := Result + '    MZA_PRECLT,         ';
  Result := Result + '    MZA_PRECGL,         ';
  Result := Result + '    MZA_PRECLA,         ';
  Result := Result + '    MZA_PRECCP,         ';
  Result := Result + '    MZA_PRECSP,         ';

  Result := Result + '    MZA_PREDLT,         ';
  Result := Result + '    MZA_PREDGL,         ';
  Result := Result + '    MZA_PREDLA,         ';
  Result := Result + '    MZA_PREDCP,         ';
  Result := Result + '    MZA_PREDSP,         ';

  Result := Result + '    MZA_PCUSCL,         ';
  Result := Result + '    MZA_PCUSCG,         ';
  Result := Result + '    MZA_PCUSCA,         ';
  Result := Result + '    MZA_PCUSCC,         ';
  Result := Result + '    MZA_PCUSCS,         ';
  Result := Result + '    MZA_PCUSDL,         ';
  Result := Result + '    MZA_PCUSDG,         ';
  Result := Result + '    MZA_PCUSDA,         ';
  Result := Result + '    MZA_PCUSDC,         ';
  Result := Result + '    MZA_PCUSDS,         ';

  Result := Result + '    MZA_PRCLT1,         ';
  Result := Result + '    MZA_PRCLT2,         ';
  Result := Result + '    MZA_PRCLT3,         ';
  Result := Result + '    MZA_PRCLT4,         ';
  Result := Result + '    MZA_PRCLT5,         ';
  Result := Result + '    MZA_PRCLT6,         ';
  Result := Result + '    MZA_PRCLT7,         ';

  Result := Result + '    MZA_PRDLT1,         ';
  Result := Result + '    MZA_PRDLT2,         ';
  Result := Result + '    MZA_PRDLT3,         ';
  Result := Result + '    MZA_PRDLT4,         ';
  Result := Result + '    MZA_PRDLT5,         ';
  Result := Result + '    MZA_PRDLT6,         ';
  Result := Result + '    MZA_PRDLT7,         ';

  Result := Result + '    MZA_PRCGL1,         ';
  Result := Result + '    MZA_PRCGL2,         ';
  Result := Result + '    MZA_PRCGL3,         ';
  Result := Result + '    MZA_PRCGL4,         ';
  Result := Result + '    MZA_PRCGL5,         ';
  Result := Result + '    MZA_PRCGL6,         ';
  Result := Result + '    MZA_PRCGL7,         ';

  Result := Result + '    MZA_PRDGL1,         ';
  Result := Result + '    MZA_PRDGL2,         ';
  Result := Result + '    MZA_PRDGL3,         ';
  Result := Result + '    MZA_PRDGL4,         ';
  Result := Result + '    MZA_PRDGL5,         ';
  Result := Result + '    MZA_PRDGL6,         ';
  Result := Result + '    MZA_PRDGL7,         ';

  Result := Result + '    MZA_PRCLA1,         ';
  Result := Result + '    MZA_PRCLA2,         ';
  Result := Result + '    MZA_PRCLA3,         ';
  Result := Result + '    MZA_PRCLA4,         ';
  Result := Result + '    MZA_PRCLA5,         ';
  Result := Result + '    MZA_PRCLA6,         ';
  Result := Result + '    MZA_PRCLA7,         ';

  Result := Result + '    MZA_PRDLA1,         ';
  Result := Result + '    MZA_PRDLA2,         ';
  Result := Result + '    MZA_PRDLA3,         ';
  Result := Result + '    MZA_PRDLA4,         ';
  Result := Result + '    MZA_PRDLA5,         ';
  Result := Result + '    MZA_PRDLA6,         ';
  Result := Result + '    MZA_PRDLA7,         ';

  Result := Result + '    MZA_PRCCP1,         ';
  Result := Result + '    MZA_PRCCP2,         ';
  Result := Result + '    MZA_PRCCP3,         ';
  Result := Result + '    MZA_PRCCP4,         ';
  Result := Result + '    MZA_PRCCP5,         ';
  Result := Result + '    MZA_PRCCP6,         ';
  Result := Result + '    MZA_PRCCP7,         ';

  Result := Result + '    MZA_PRDCP1,         ';
  Result := Result + '    MZA_PRDCP2,         ';
  Result := Result + '    MZA_PRDCP3,         ';
  Result := Result + '    MZA_PRDCP4,         ';
  Result := Result + '    MZA_PRDCP5,         ';
  Result := Result + '    MZA_PRDCP6,         ';
  Result := Result + '    MZA_PRDCP7,         ';

  Result := Result + '    MZA_PRCSP1,         ';
  Result := Result + '    MZA_PRCSP2,         ';
  Result := Result + '    MZA_PRCSP3,         ';
  Result := Result + '    MZA_PRCSP4,         ';
  Result := Result + '    MZA_PRCSP5,         ';
  Result := Result + '    MZA_PRCSP6,         ';
  Result := Result + '    MZA_PRCSP7,         ';

  Result := Result + '    MZA_PRDSP1,         ';
  Result := Result + '    MZA_PRDSP2,         ';
  Result := Result + '    MZA_PRDSP3,         ';
  Result := Result + '    MZA_PRDSP4,         ';
  Result := Result + '    MZA_PRDSP5,         ';
  Result := Result + '    MZA_PRDSP6,         ';
  Result := Result + '    MZA_PRDSP7,         ';

  Result := Result + '    MZA_EMBALT,         ';
  Result := Result + '    MZA_EMBAGL,         ';
  Result := Result + '    MZA_EMBALA,         ';
  Result := Result + '    MZA_EMBACP,         ';
  Result := Result + '    MZA_EMBASP,         ';

  Result := Result + '    MZA_VOLULT,         ';
  Result := Result + '    MZA_VOLUGL,         ';
  Result := Result + '    MZA_VOLULA,         ';
  Result := Result + '    MZA_VOLUCP,         ';
  Result := Result + '    MZA_VOLUSP,         ';

  Result := Result + '    MZA_PREELT,         ';
  Result := Result + '    MZA_PREEGL,         ';
  Result := Result + '    MZA_PREELA,         ';
  Result := Result + '    MZA_PREECP,         ';
  Result := Result + '    MZA_PREESP,         ';

  Result := Result + '    MZA_TIPOLT,         ';
  Result := Result + '    MZA_TIPOGL,         ';
  Result := Result + '    MZA_TIPOLA,         ';
  Result := Result + '    MZA_TIPOCP,         ';
  Result := Result + '    MZA_TIPOSP          ';
  Result := Result + '          )             ';
  Result := Result + '  VALUES    (                            ';
  Result := Result + '    :CODIGO,            ';
  Result := Result + '    :DESCRI,            ';
  Result := Result + '    :LINHA_,            ';
  Result := Result + '    :UNIVER,            ';
  Result := Result + '    :OBSERV,            ';
  Result := Result + '    :CODMON,            ';
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

  Result := Result + '    :PCUSCL,            ';
  Result := Result + '    :PCUSCG,            ';
  Result := Result + '    :PCUSCA,            ';
  Result := Result + '    :PCUSCC,            ';
  Result := Result + '    :PCUSCS,            ';
  Result := Result + '    :PCUSDL,            ';
  Result := Result + '    :PCUSDG,            ';
  Result := Result + '    :PCUSDA,            ';
  Result := Result + '    :PCUSDC,            ';
  Result := Result + '    :PCUSDS,            ';

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
  Result := Result + '          );                             ';
end;

function TExportaTintometricosTerceirosMazaAutomotiva.fValorQuantidade(
  fltValor: Double; fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
  Begin
    Result := fltValor + fltAcrMob;
  End;
end;

procedure TExportaTintometricosTerceirosMazaAutomotiva.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZA_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZA_DESCRI').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZA_LINHA_').AsString);
  DataSet.ParamByName('UNIVER').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZA_UNIVER').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZA_OBSERV').AsString);
  DataSet.ParamByName('CODMON').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MZA_CODMON').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('MZA_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProMza;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUSCA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUSCC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUSDC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUSCS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUSDS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
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
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('MZA_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('MZA_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosMazaAutomotiva.pCarregaDiluente;
begin
  qryDiluente := fCriaQuery();
  qryDiluente.Close;
  qryDiluente.SQL.Clear;
  qryDiluente.SQL.Add('  SELECT * FROM MZA_CADBAS B    ');
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    *               ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    CFGTIN          ';
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    CFG_IDEPRO = "MZA" AND              ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND    ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '" ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen)
  End;
end;

procedure TExportaTintometricosTerceirosMazaAutomotiva.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '    DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "MZA"     ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT  (         ';
    strSQL := strSQL + '    LOG_IDEPRO,       ';
    strSQL := strSQL + '    LOG_DTAEXE,       ';
    strSQL := strSQL + '    LOG_HOREXE,       ';
    strSQL := strSQL + '    LOG_EXECUT        ';
    strSQL := strSQL + '        )                           ';
    strSQL := strSQL + '  VALUES  (                         ';
    strSQL := strSQL + '    "MZA",            ';
    strSQL := strSQL + '    :DTAEXE,          ';
    strSQL := strSQL + '    :HOREXE,          ';
    strSQL := strSQL + '    :EXECUT           ';
    strSQL := strSQL + '          );                        ';

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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pPesoEspecifico;
begin
  qryCadBas := fCriaQuery();
  qryCadBas.SQL.Add('SELECT * FROM MZA_CADBAS ');
  qryCadBas.Open;
end;

procedure TExportaTintometricosTerceirosMazaAutomotiva.pPreencheArrayEmbalagem;
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosMazaAutomotiva.pProcessaTabelaCores(
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

          If (qryGen.FieldByName('MZA_LINHA_').AsString <> 'MHS') And
            (qryGen.FieldByName('MZA_LINHA_').AsString <> 'MPL') Then
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
  fltQuantidade: Double;
  fltVolumeAtual: Double;
begin
  fltPesCor := qryGen.FieldByName('MZA_PESCOR').AsFloat;
  fltPesFor := qryGen.FieldByName('MZA_PESFOR').AsFloat;
  blnQtdQdi := (qryGen.FieldByName('MZA_BAIQDI').AsString = 'S');

  fltQuantidade := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('MZA_QTDC' + fStrZero(intContador, 2)).AsFloat / fPesoEspecifico(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString);

    fltQuantidade := fltQuantidade + dicRetorno['qtdb' + fStrZero(intContador, 2)];
  End;

  fltVolumeAtual := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString) Then
      Break;

    dicRetorno['qtdb' + fStrZero(intContador, 2)] := dicRetorno['qtdb' + fStrZero(intContador, 2)] * 900 / fltQuantidade;

    fltVolumeAtual := fltVolumeAtual + dicRetorno['qtdb' + fStrZero(intContador, 2)];

    If blnQtdQdi Then
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('MZA_QTDC' + fStrZero(intContador, 2)).AsFloat
    Else
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := dicRetorno['qtdb' + fStrZero(intContador, 2)] * fPesoEspecifico(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString);
  End;

  If (qryGen.FieldByName('MZA_LINHA_').AsString = 'MHS') Or
    (qryGen.FieldByName('MZA_LINHA_').AsString = 'MPL') Then
    Exit;

  Try
    If Not qryDiluente.Locate('BAS_DESCRI', fRetDiluente(qryGen.FieldByName('MZA_LINHA_').AsString), []) Then
      Exit;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If fEmptyStr(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString) Then
        Break;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] :=  dicRetorno['qtdb' + fStrZero(intContador, 2)] / fPesoEspecifico(qryGen.FieldByName('MZA_FORM' + fstrZero(intContador, 2)).AsString);
      dicRetorno['qtdd' + fStrZero(intContador, 2)] :=  ((dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1000) / (1000 + (fRetPorDiluente(qryGen.FieldByName('MZA_LINHA_').AsString) * 10)));
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFormataFloat(dicRetorno['qtdd' + fStrZero(intContador, 2)] * fPesoEspecifico(qryGen.FieldByName('MZA_FORM' + fstrZero(intContador, 2)).AsString), 2);
    End;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If fEmptyStr(qryGen.FieldByName('MZA_FORM' + fStrZero(intContador, 2)).AsString) Then
      Begin
        dicRetorno['base' + fStrZero(intContador, 2)] := qryDiluente.FieldByName('BAS_CODBAS').AsString;
        dicRetorno['coddil'] := qryDiluente.FieldByName('BAS_CODBAS').AsString;
        dicRetorno['pordil'] := fRetPorDiluente(qryGen.FieldByName('MZA_LINHA_').AsString);
        dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0.0;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (fltVolumeAtual) * (fRetPorDiluente(qryGen.FieldByName('MZA_LINHA_').AsString) / 100);
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := dicRetorno['qtdd' + fStrZero(intContador, 2)] * qryDiluente.FieldByName('BAS_PESESP').AsFloat;
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := (dicRetorno['qtdd' + fStrZero(intContador, 2)] * 1 * 1000) / (1 * 1000 + (fRetPorDiluente(qryGen.FieldByName('MZA_LINHA_').AsString) * 10));
        Break;
      End;
    End;
  Finally
  End;
end;

procedure TExportaTintometricosTerceirosMazaAutomotiva.pRetPrecosAdicionais(
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

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmb].strSigEmb;


    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(arrComponentes, fQuantidadeFormulacao);

      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * arrEmbalagens[intEmb].fltVolume / 0.9;
        ArrComponentes[intContador].Quantiddil := fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 3) * arrEmbalagens[intEmb].fltVolume / 0.9;
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

          //Preco de Venda Diluido
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pRetPrecoTintas(
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

  strTabelaUnica := dicRetorno['tabelaunica'];
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
        ArrComponentes[intContador].Quantidade := fFormataFloat(IfNull(dicRetorno['qtdb' + fStrZero(intContador, 2)], 0), 3) * arrEmbalagens[intEmb].fltVolume / 0.9;
        ArrComponentes[intContador].Quantiddil := fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 3) * arrEmbalagens[intEmb].fltVolume / 0.9;
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

        //Preco de Venda Diluido
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosMazaAutomotiva.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  inherited;
  pCriaClientEmbalagem(Conexao);
  strProMza := fRetItemVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.

