unit untExportaTintometricosTerceirosNexa;

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
  TExportaTintometricosTerceirosNexa = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProNex: String; //Produto de venda Nexa;
    stlDiluentes: TStringList;
    qryDiluentes: TUniQuery;
    qryBasEmp: TUniQuery; //Base por Empresa
    strAcrMob: String;
    blnDiluido: Boolean;
    function fRetValorAcrMobCfgTin(): String;
    function fArredondaNex(fltValor: Double): Double;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fFormataFloatNexa(fltNumero: Double; intDecimais: Integer): Double;
    function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;

    procedure pCriaTabelaExportacao; Override;
  Public
    function fNomeTabela(): String; override;
    function fCamposTabela(): String; override;
    function fCamposSelect(): String; override;
    function fQuantidadeFormulacao(): Integer; override;
    function fFatorTinta(): Double; override;
    function fRetDescricao(): String; override;
    function fRetItemBase(): String; override;
    function fRetMD5KEY(): String; override;
    function fRetFormula(intCont: Integer): String; override;
    function fRetQuantidade(intCont: Integer): String; override;
    function fSQLInsert(): String; override;
    function fRetornaColorantes(): String; override;
    function fRetornaBases(): String; override;
    function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;
    function fRetEmbalagem(qryColorantes: TUniQuery): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; override;
    function fRetTipoCor(): String; override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; override;
    function fCarregarBasesEmpresa(): String;
    function fRetItemVenda(strTipCor: String): String;
    function fConfProdutoVendaCriada(): Boolean;
    function fRetItemProNexa(): String;
    function fRetEmbalagemLT(strTipCor: String): String;
    function fRetEmbalagemGL(strTipCor: String): String;
    function fRetEmbalagemBD(strTipCor: String): String;
    function fRetEmbalagemTB(strTipCor: String): String;
    function fRetEmbalagemCP(): String;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;


    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery;
      qryBases: TUniQuery); override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); override;
    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure Execute; override;
    procedure CarregarDados;
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure GetDiluentes(qryTinta: TUniQuery);
    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;

implementation

{ TExportaTintometricosTerceirosNexa }

procedure TExportaTintometricosTerceirosNexa.CarregarDados;
begin
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  stlDiluentes := TStringList.Create;
  qryDiluentes := fCriaQuery();
  qryBasEmp := fCriaQuery();
  qryBasEmp.Close;
  qryBasEmp.SQL.Clear;
  qryBasEmp.SQL.Add(fCarregarBasesEmpresa);
  qryBasEmp.Open;
end;

constructor TExportaTintometricosTerceirosNexa.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProNex := '';
  pPreencheEmbalagens;
  CarregarDados;
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosNexa.Destroy;
begin
  inherited;
  FreeAndNil(stlDiluentes);
  FreeAndNil(qryDiluentes);
  FreeAndNil(qryBasEmp);

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosNexa.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosNexa.fArredondaNex(
  fltValor: Double): Double;
Var
  strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);

  If fStrToFloat(strAux) = 0 Then
    strAux := Format('%.2f', [fltValor]);

  Result := fStrToFloat(strAux);
end;

function TExportaTintometricosTerceirosNexa.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    NEX_DESCOR,         ';
  Result := Result + '    NEX_TIPO__,         ';
  Result := Result + '    BAS_TIPO__,         ';
  Result := Result + '    MON_DESCRI,         ';
  Result := Result + '    NEX_VEICUL,         ';
  Result := Result + '    SUBSTR(NEX_A_N_O_, 1, 4) AS ANO_INICIAL,         ';
  Result := Result + '    SUBSTR(NEX_A_N_O_, 6, 4) AS ANO_FINAL,           ';
  Result := Result + '    NEX_CODCOR,         ';
  Result := Result + '    NEX_CODATC,         ';
  Result := Result + '    NEX_MONTAD,         ';
  Result := Result + '    NEX_A_N_O_,         ';
  Result := Result + '    NEX_MARCA_,         ';
  Result := Result + '    NEX_VARIAN,         ';
  Result := Result + '    NEX_REFERE,         ';
  Result := Result + '    NEX_SISTEM,         ';
  Result := Result + '    NEX_PAISES,         ';
  Result := Result + '    NEX_ORIGEM,         ';
  Result := Result + '    NEX_UTILIZ,         ';
  Result := Result + '    NEX_EFEFIN,         ';
  Result := Result + '    NEX_ACRMOB,         ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    NEX_CODB' + fStrZero(intContador, 2) + ',     ';
    Result := Result + '    NEX_QTDB' + fStrZero(intContador, 2) + ',     ';
  End;

  Result := Result + '    NEX_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    NEX_CADNEX          ';
  Result := Result + '  LEFT JOIN NEX_CADMON ON        ';
  Result := Result + '    NEX_MONTAD = MON_CODMON             ';
  Result := Result + '  INNER JOIN NEX_CADBAS ON       ';
  Result := Result + '    NEX_CODB01 = BAS_CODBAS   AND       ';
  Result := Result + '    IFNULL(NEX_ATIVO_, "S") = "S"       ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    TRUE                ';
end;

function TExportaTintometricosTerceirosNexa.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE    ' + fNomeTabela() +   ' (   ';
  Result := Result + '    NEX_DESCOR VARCHAR(102),        ';
  Result := Result + '    NEX_CODCOR VARCHAR(100),        ';
  Result := Result + '    NEX_CODATC VARCHAR(25),         ';
  Result := Result + '    NEX_MARCA_ VARCHAR(15),         ';
  Result := Result + '    NEX_SISTEM VARCHAR(45),         ';
  Result := Result + '    NEX_UTILIZ VARCHAR(10),         ';
  Result := Result + '    NEX_EFEFIN VARCHAR(50),         ';
  Result := Result + '    NEX_ORIGEM VARCHAR(175),        ';
  Result := Result + '    NEX_PAISES VARCHAR(50),         ';
  Result := Result + '    NEX_VEICUL VARCHAR(255),        ';
  Result := Result + '    NEX_MONTAD VARCHAR(16),         ';
  Result := Result + '    NEX_TIPO__ VARCHAR(30),         ';
  Result := Result + '    NEX_MD5KEY VARCHAR(35),         ';

  Result := Result + '    NEX_CODITE VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    NEX_CODDIL VARCHAR(20),         ';
  Result := Result + '    NEX_PORDIL DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRECLT DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRECGL DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRECBD DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRECTB DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRECCP DECIMAL(12,4),       ';

  Result := Result + '    NEX_PREDLT DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREDGL DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREDBD DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREDTB DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREDCP DECIMAL(12,4),       ';

  Result := Result + '    NEX_PCUSCL DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSCG DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSCB DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSCT DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSCC DECIMAL(12,4),       ';

  Result := Result + '    NEX_PCUSDL DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSDG DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSDB DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSDT DECIMAL(12,4),       ';
  Result := Result + '    NEX_PCUSDC DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRCLT1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCLT2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCLT3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCLT4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCLT5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCLT6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCLT7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRDLT1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDLT2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDLT3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDLT4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDLT5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDLT6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDLT7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRCGL1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCGL2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCGL3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCGL4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCGL5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCGL6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCGL7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRDGL1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDGL2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDGL3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDGL4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDGL5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDGL6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDGL7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRCBD1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCBD2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCBD3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCBD4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCBD5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCBD6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCBD7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRDBD1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDBD2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDBD3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDBD4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDBD5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDBD6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDBD7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRCTB1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCTB2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCTB3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCTB4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCTB5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCTB6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCTB7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRDTB1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDTB2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDTB3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDTB4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDTB5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDTB6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDTB7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRCCP1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCCP2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCCP3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCCP4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCCP5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCCP6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRCCP7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_PRDCP1 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDCP2 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDCP3 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDCP4 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDCP5 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDCP6 DECIMAL(12,4),       ';
  Result := Result + '    NEX_PRDCP7 DECIMAL(12,4),       ';

  Result := Result + '    NEX_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    NEX_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    NEX_EMBABD VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    NEX_EMBATB VARCHAR(' + fTamCodIte.ToString() + '),          ';
  Result := Result + '    NEX_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),          ';

  Result := Result + '    NEX_VOLULT DECIMAL(12,4),       ';
  Result := Result + '    NEX_VOLUGL DECIMAL(12,4),       ';
  Result := Result + '    NEX_VOLUBD DECIMAL(12,4),       ';
  Result := Result + '    NEX_VOLUTB DECIMAL(12,4),       ';
  Result := Result + '    NEX_VOLUCP DECIMAL(12,4),       ';

  Result := Result + '    NEX_PREELT DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREEGL DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREEBD DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREETB DECIMAL(12,4),       ';
  Result := Result + '    NEX_PREECP DECIMAL(12,4),       ';

  Result := Result + '    NEX_TIPOLT CHAR(2),             ';
  Result := Result + '    NEX_TIPOGL CHAR(2),             ';
  Result := Result + '    NEX_TIPOBD CHAR(2),             ';
  Result := Result + '    NEX_TIPOTB CHAR(2),             ';
  Result := Result + '    NEX_TIPOCP CHAR(2)              ';
  Result := Result + '          );                        ';
end;

function TExportaTintometricosTerceirosNexa.fCarregarBasesEmpresa: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,       ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                  ';
  Result := Result + '    NEX_BASEMP B        ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    B.BAS_CODITE = G.ITE_CODITE             ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"       ';
end;

function TExportaTintometricosTerceirosNexa.fConfProdutoVendaCriada: Boolean;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    qryGen := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    CFG_CODCFG        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    CFGTIN            ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    CFG_IDEPRO = "NEX"  AND                 ';
    strSQL := strSQL + '    CFG_CODCFG = "PROACS" AND               ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosNexa.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosNexa.fFormataFloatNexa(fltNumero: Double;
  intDecimais: Integer): Double;
begin
  Result := fRoundFiveUp(fltNumero, intDecimais);
end;

function TExportaTintometricosTerceirosNexa.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('NEX_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('NEX_CODB' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosNexa.fNomeTabela: String;
begin
  Result := 'NEX_CADNEX_SIT';
end;

function TExportaTintometricosTerceirosNexa.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosNexa.fRetDescricao: String;
begin
  Result := 'NEX_DESCOR';
end;

function TExportaTintometricosTerceirosNexa.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosNexa.fRetEmbalagemBD(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('2K', strTipCor) > 0 Then
    Result := 'NEXAPMLA2K'
  Else If Pos('ACS (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMLAAC'
  Else If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMLAEV'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'NEXAPMLAIN'
  Else If Pos('FLAT CLEAR', strTipCor) > 0 Then
    Result := 'NEXAPMLASG'
  Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
    Result := 'NEXAPMLASG'
  Else If Pos('TURBO PLUS', strTipCor) > 0 Then
    Result := 'NEXAPMLATP'
  Else If Pos('ZYNAMIX', strTipCor) > 0 Then
    Result := 'NEXAPMLAZY';
end;

function TExportaTintometricosTerceirosNexa.fRetEmbalagemCP: String;
begin
  Result := 'NEXACOP';
end;

function TExportaTintometricosTerceirosNexa.fRetEmbalagemGL(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('2K', strTipCor) > 0 Then
    Result := 'NEXAPMG2K'
  Else If Pos('ACS (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMGAC'
  Else If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMGEV'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'NEXAPMGIN'
  Else If Pos('FLAT CLEAR', strTipCor) > 0 Then
    Result := 'NEXAPMGSG'
  Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
    Result := 'NEXAPMGSG'
  Else If Pos('TURBO PLUS', strTipCor) > 0 Then
    Result := 'NEXAPMGTP'
  Else If Pos('ZYNAMIX', strTipCor) > 0 Then
    Result := 'NEXAPMGZY'
end;

function TExportaTintometricosTerceirosNexa.fRetEmbalagemLT(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('2K', strTipCor) > 0 Then
    Result := 'NEXAPML2K'
  Else If Pos('ACS (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMLAC'
  Else If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMLEV'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'NEXAPMLIN'
  Else If Pos('FLAT CLEAR', strTipCor) > 0 Then
    Result := 'NEXAPMLSG'
  Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
    Result := 'NEXAPMLSG'
  Else If Pos('TURBO PLUS', strTipCor) > 0 Then
    Result := 'NEXAPMLTP'
  Else If Pos('ZYNAMIX', strTipCor) > 0 Then
    Result := 'NEXAPMLZY';
end;

function TExportaTintometricosTerceirosNexa.fRetEmbalagemTB(
  strTipCor: String): String;
begin
  Result := '';

  If Pos('2K', strTipCor) > 0 Then
    Result := 'NEXAPMT2K'
  Else If Pos('ACS (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMTAC'
  Else If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
    Result := 'NEXAPMTEV'
  Else If Pos('INDUSTRAN', strTipCor) > 0 Then
    Result := 'NEXAPMTIN'
  Else If Pos('FLAT CLEAR', strTipCor) > 0 Then
    Result := 'NEXAPMTSG'
  Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
    Result := 'NEXAPMTSG'
  Else If Pos('TURBO PLUS', strTipCor) > 0 Then
    Result := 'NEXAPMTTP'
  Else If Pos('ZYNAMIX', strTipCor) > 0 Then
    Result := 'NEXAPMTZY'
end;

function TExportaTintometricosTerceirosNexa.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'NEX_CODB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosNexa.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosNexa.fRetItemProNexa: String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    CFG_VALCFG          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGTIN              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    CFG_IDEPRO = "NEX"  AND               ';
    strSQL := strSQL + '    CFG_CODCFG = "PRONEXA"  AND           ';
    strSQL := strSQL + '    CFG_CODEMP = "' + Vs_StrCodEmp + '"   ';

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosNexa.fRetItemVenda(strTipCor: String): String;
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
    strSQL := strSQL + '    CFG_IDEPRO = "NEX" AND                ';
    strSQL := strSQL + '    CFG_CODCFG = :CODCFG  AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);

    If Pos('2K', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PRONEXA'
    Else If Pos('ACS (LA)', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROACS'
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROIND'
    Else If Pos('FLAT CLEAR', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROSPE'
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROSPE'
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROZYN'
    Else If Pos('ACS EVOLUTION (LA)', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROEVO'
    Else If Pos('TURBO PLUS', strTipCor) > 0 Then
      qryGen.ParamByName('CODCFG').AsString := 'PROTUR';

    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;

    If (fEmptyStr(Result)) And (Not fConfProdutoVendaCriada) Then
      Result := fRetItemProNexa();
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosNexa.fRetMD5KEY: String;
begin
  Result := 'NEX_MD5KEY';
end;

function TExportaTintometricosTerceirosNexa.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                      ';
  Result := Result + '    BAS_CODITE,               ';
  Result := Result + '    BAS_CODBAS,               ';
  Result := Result + '    BAS_EMBALA,               ';
  Result := Result + '    BAS_PESESP,               ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,      ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,     ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,     ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,     ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,     ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,     ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,     ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,     ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7      ';
  Result := Result + '  FROM                        ';
  Result := Result + '    NEX_CADBAS B              ';
  Result := Result + '  INNER JOIN CADITE I ON              ';
  Result := Result + '    B.BAS_CODITE = I.ITE_CODITE               ';
  Result := Result + '  INNER JOIN ITEGER G ON              ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE               ';
  Result := Result + '  WHERE                       ';
  Result := Result + '    G.ITE_CODEMP = "' + Vs_StrCodEmp + '"     ';
end;

function TExportaTintometricosTerceirosNexa.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor'])
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD(dicRetorno['tipcor'])
  Else If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB(dicRetorno['tipcor'])
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP();
end;

function TExportaTintometricosTerceirosNexa.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosNexa.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosNexa.fRetornaPercentualAcrescimo(
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
    strSQL := strSQL + '    CFG_IDEPRO = "NEX" AND                ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND             ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"   ';

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

function TExportaTintometricosTerceirosNexa.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosNexa.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'NEX_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosNexa.fRetTipoCor: String;
begin
  Result := 'NEX_TIPO__';
end;

function TExportaTintometricosTerceirosNexa.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "NEX" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosNexa.fRoundFiveUp(fltValue: Double;
  intDigits: Integer): Double;
var
  intDig: Integer;
  strVal: String;
begin
  strVal := FloatToStr(fltValue);
  intDig := Pos(FormatSettings.DecimalSeparator, strVal);

  If intDig > 0 Then
    intDig := Length(MidStr(strVal, intDig + 1, Length(strVal) - intDig));

  If (intDig > 0) And (intDig > intDigits) And (strVal[Length(strVal)] = '5') Then
  Begin
    strVal[Length(strVal)] := '6';
  End;

  Result := strToFloatDef(FloatToStrF(strToFloatDef(strVal, 0), ffFixed, 12, intDigits), 0);
end;

function TExportaTintometricosTerceirosNexa.fSQLInsert: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  INSERT INTO   ' + fNomeTabela + '   (     ';
  Result := Result + '    NEX_DESCOR,           ';
  Result := Result + '    NEX_CODCOR,           ';
  Result := Result + '    NEX_CODATC,           ';
  Result := Result + '    NEX_MARCA_,           ';
  Result := Result + '    NEX_SISTEM,           ';
  Result := Result + '    NEX_UTILIZ,           ';
  Result := Result + '    NEX_EFEFIN,           ';
  Result := Result + '    NEX_ORIGEM,           ';
  Result := Result + '    NEX_PAISES,           ';
  Result := Result + '    NEX_VEICUL,           ';
  Result := Result + '    NEX_MONTAD,           ';
  Result := Result + '    NEX_TIPO__,           ';
  Result := Result + '    NEX_MD5KEY,           ';
  Result := Result + '    NEX_CODITE,           ';
  Result := Result + '    NEX_CODDIL,           ';
  Result := Result + '    NEX_PORDIL,           ';
  Result := Result + '    NEX_PRECLT,           ';
  Result := Result + '    NEX_PRECGL,           ';
  Result := Result + '    NEX_PRECBD,           ';
  Result := Result + '    NEX_PRECTB,           ';
  Result := Result + '    NEX_PRECCP,           ';
  Result := Result + '    NEX_PREDLT,           ';
  Result := Result + '    NEX_PREDGL,           ';
  Result := Result + '    NEX_PREDBD,           ';
  Result := Result + '    NEX_PREDTB,           ';
  Result := Result + '    NEX_PREDCP,           ';
  Result := Result + '    NEX_PCUSCL,           ';
  Result := Result + '    NEX_PCUSCG,           ';
  Result := Result + '    NEX_PCUSCB,           ';
  Result := Result + '    NEX_PCUSCT,           ';
  Result := Result + '    NEX_PCUSCC,           ';
  Result := Result + '    NEX_PCUSDL,           ';
  Result := Result + '    NEX_PCUSDG,           ';
  Result := Result + '    NEX_PCUSDB,           ';
  Result := Result + '    NEX_PCUSDT,           ';
  Result := Result + '    NEX_PCUSDC,           ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result + '    NEX_PRCLT' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRDLT' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRCGL' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRDGL' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRCBD' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRDBD' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRCTB' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRDTB' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRCCP' + IntToStr(intContador) + ',     ';
    Result := Result + '    NEX_PRDCP' + IntToStr(intContador) + ',     ';
  End;

  Result := Result + '    NEX_EMBALT,           ';
  Result := Result + '    NEX_EMBAGL,           ';
  Result := Result + '    NEX_EMBABD,           ';
  Result := Result + '    NEX_EMBATB,           ';
  Result := Result + '    NEX_EMBACP,           ';
  Result := Result + '    NEX_VOLULT,           ';
  Result := Result + '    NEX_VOLUGL,           ';
  Result := Result + '    NEX_VOLUBD,           ';
  Result := Result + '    NEX_VOLUTB,           ';
  Result := Result + '    NEX_VOLUCP,           ';
  Result := Result + '    NEX_PREELT,           ';
  Result := Result + '    NEX_PREEGL,           ';
  Result := Result + '    NEX_PREEBD,           ';
  Result := Result + '    NEX_PREETB,           ';
  Result := Result + '    NEX_PREECP,           ';
  Result := Result + '    NEX_TIPOLT,           ';
  Result := Result + '    NEX_TIPOGL,           ';
  Result := Result + '    NEX_TIPOBD,           ';
  Result := Result + '    NEX_TIPOTB,           ';
  Result := Result + '    NEX_TIPOCP            ';
  Result := Result + '            )                               ';
  Result := Result + '  VALUES        ' + '       (               ';
  Result := Result + '    :DESCOR,              ';
  Result := Result + '    :CODCOR,              ';
  Result := Result + '    :CODATC,              ';
  Result := Result + '    :MARCA_,              ';
  Result := Result + '    :SISTEM,              ';
  Result := Result + '    :UTILIZ,              ';
  Result := Result + '    :EFEFIN,              ';
  Result := Result + '    :ORIGEM,              ';
  Result := Result + '    :PAISES,              ';
  Result := Result + '    :VEICUL,              ';
  Result := Result + '    :MONTAD,              ';
  Result := Result + '    :TIPO__,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';
  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECBD,              ';
  Result := Result + '    :PRECTB,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDBD,              ';
  Result := Result + '    :PREDTB,              ';
  Result := Result + '    :PREDCP,              ';
  Result := Result + '    :PCUSCL,              ';
  Result := Result + '    :PCUSCG,              ';
  Result := Result + '    :PCUSCB,              ';
  Result := Result + '    :PCUSCT,              ';
  Result := Result + '    :PCUSCC,              ';
  Result := Result + '    :PCUSDL,              ';
  Result := Result + '    :PCUSDG,              ';
  Result := Result + '    :PCUSDB,              ';
  Result := Result + '    :PCUSDT,              ';
  Result := Result + '    :PCUSDC,              ';

  For intContador := 1 To 7 Do
  Begin
    Result := Result + '    :PRCLT' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRDLT' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRCGL' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRDGL' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRCBD' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRDBD' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRCTB' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRDTB' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRCCP' + IntToStr(intContador) + ',      ';
    Result := Result + '    :PRDCP' + IntToStr(intContador) + ',      ';
  End;

  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBABD,              ';
  Result := Result + '    :EMBATB,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLUBD,              ';
  Result := Result + '    :VOLUTB,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREEBD,              ';
  Result := Result + '    :PREETB,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOBD,              ';
  Result := Result + '    :TIPOTB,              ';
  Result := Result + '    :TIPOCP               ';
  Result := Result + '          );                                ';
end;

function TExportaTintometricosTerceirosNexa.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosNexa.GetDiluentes(qryTinta: TUniQuery);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin

  stlDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT       ';
  strSQL := strSQL + '    *                   ';
  strSQL := strSQL + '  FROM                  ';
  strSQL := strSQL + '    NEX_CADBAS B        ';
  strSQL := strSQL + '  INNER JOIN PPG_CADDIL D ON          ';
  strSQL := strSQL + '    B.BAS_CODBAS = D.DIL_CODDIL             ';
  strSQL := strSQL + '  WHERE                 ';
  strSQL := strSQL + '    BAS_TIPO__ = :TIPO  AND           ';
  strSQL := strSQL + '    ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) OR   ';
  strSQL := strSQL + '    (:SISTEM = "PERSONALIZADA"));     ';

  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('TIPO').AsString := qryTinta.FieldByName('NEX_TIPO__').AsString;
    qryGen.ParamByName('SISTEM').AsString := qryTinta.FieldByName('NEX_SISTEM').AsString;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      stlDiluentes.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
      qryGen.Next;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosNexa.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('DESCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_DESCOR').AsString);
  DataSet.ParamByName('CODCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_CODCOR').AsString);
  DataSet.ParamByName('CODATC').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_CODATC').AsString);
  DataSet.ParamByName('MARCA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_MARCA_').AsString);
  DataSet.ParamByName('SISTEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_SISTEM').AsString);
  DataSet.ParamByName('UTILIZ').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_UTILIZ').AsString);
  DataSet.ParamByName('EFEFIN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_EFEFIN').AsString);
  DataSet.ParamByName('ORIGEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_ORIGEM').AsString);
  DataSet.ParamByName('PAISES').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_PAISES').AsString);
  DataSet.ParamByName('VEICUL').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_VEICUL').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_MONTAD').AsString);
  DataSet.ParamByName('TIPO__').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('NEX_TIPO__').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('NEX_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProNex;
  DataSet.ParamByName('PCUSCL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUSDL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUSCG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUSDG').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUSCB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUSDB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
  DataSet.ParamByName('PCUSCT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUSDT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUSCC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUSDC').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('NEX_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('NEX_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosNexa.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    //Embalagens
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    *                   ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CFGTIN              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    CFG_IDEPRO = "NEX"  AND                 ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES"  AND       ';
    strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

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

procedure TExportaTintometricosTerceirosNexa.pCriaTabelaExportacao;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fCamposTabela);
      ExecSQL;
      Close;
      SQL.Clear;
      SQL.Add('ALTER TABLE ' + fNomeTabela + ' ADD UNIQUE KEY (' + fRetMD5KEY + ')');
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosNexa.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosNexa.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "NEX"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT (          ';
    strSQL := strSQL + '    LOG_IDEPRO,       ';
    strSQL := strSQL + '    LOG_DTAEXE,       ';
    strSQL := strSQL + '    LOG_HOREXE,       ';
    strSQL := strSQL + '    LOG_EXECUT        ';
    strSQL := strSQL + '          )                         ';
    strSQL := strSQL + '  VALUES    (                       ';
    strSQL := strSQL + '    "NEX",            ';
    strSQL := strSQL + '    :DTAEXE,          ';
    strSQL := strSQL + '    :HOREXE,          ';
    strSQL := strSQL + '    :EXECUT           ';
    strSQL := strSQL + '          )                         ';

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

procedure TExportaTintometricosTerceirosNexa.pPreencheArrayEmbalagem;
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

  //Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 200.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
end;

procedure TExportaTintometricosTerceirosNexa.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosNexa.pProcessaTabelaCores(
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
    qryInsert.Params.ArraySize := 100;
    intContador := 0;

  {$IFDEF LINUX}
    If VS_ExitProcessSignal Then
      Break;
  {$ENDIF}

    For intRegistros := 0 To Pred(100) Do
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
        //For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        For intEmb := 0 To 3 Do
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
      pGravaTintometricoPorTintaTerceiros(qryInsert, fltPreven, qryGen, intContador);

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

procedure TExportaTintometricosTerceirosNexa.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intCont: Integer;
  fltTotalVolumeAtual: Double;
  fltTotalVolumeDiluido: Double;
  fltTaxa: Double;
  fltPorDil: Double;
  strSQL: String;
begin
  blnDiluido := False;
  GetDiluentes(qryGen);

  If Pos('PERSONALIZ', qryGen.FieldByName('NEX_SISTEM').AsString) > 0 Then
    dicRetorno['NVFORMULA'] := 'S'
  Else
    dicRetorno['NVFORMULA'] := 'N';

  strSQL := '';
  strSQL := strSQL + '  SELECT DISTINCT               ';
  strSQL := strSQL + '    *                           ';
  strSQL := strSQL + '  FROM                          ';
  strSQL := strSQL + '    NEX_CADBAS B                ';
  strSQL := strSQL + '  INNER JOIN PPG_CADDIL D ON            ';
  strSQL := strSQL + '    B.BAS_CODBAS = D.DIL_CODDIL                         ';
  strSQL := strSQL + '  WHERE                         ';
  strSQL := strSQL + '    BAS_TIPO__ = :TIPO__ AND                            ';
  strSQL := strSQL + '    ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) OR     ';
  strSQL := strSQL + '    (:SISTEM = "PERSONALIZADA")) AND                    ';
  strSQL := strSQL + '    D.DIL_CODDIL = :DILUEN                              ';

  qryDiluentes.Close;
  qryDiluentes.SQL.Clear;
  qryDiluentes.SQL.Add(strSQL);
  qryDiluentes.ParamByName('TIPO__').AsString := qryGen.FieldByName('NEX_TIPO__').AsString;
  qryDiluentes.ParamByName('SISTEM').AsString := qryGen.FieldByName('NEX_SISTEM').AsString;


  If stlDiluentes.Count > 0 Then
    qryDiluentes.ParamByName('DILUEN').AsString := stlDiluentes[0]
  Else
    qryDiluentes.ParamByName('DILUEN').AsString := '';

  qryDiluentes.Open;

  If qryDiluentes.IsEmpty Then
    Exit;

  blnDiluido := True;

  fltTotalVolumeAtual := 0;

  For intCont := 1 To fQuantidadeFormulacao() Do
  Begin

    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intCont, 2)], [])) Then
      Break;

    fltTotalVolumeAtual := fltTotalVolumeAtual +
      (qryGen.FieldByName(fRetQuantidade(intCont)).AsFloat / qryBases.FieldByName('BAS_PESESP').AsFloat);
  End;

  fltPorDil := qryDiluentes.FieldByName('DIL_MINIMO').AsFloat;

  fltTotalVolumeDiluido := fltTotalVolumeAtual +
    (fltPorDil * fltTotalVolumeAtual / 100);
  fltTaxa := (fltTotalVolumeAtual / fltTotalVolumeDiluido);

  //Adicionando o diluente na ultima posicao
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
    Begin
      dicRetorno['base' + fStrZero(intCont, 2)] := qryDiluentes.FieldByName('BAS_CODBAS').AsString;
      dicRetorno['qtdb' + fStrZero(intCont, 2)] := 0;
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := ((fltPorDil * fltTotalVolumeAtual / 100) * qryDiluentes.FieldByName('BAS_PESESP').AsFloat);

      dicRetorno['coddil'] := qryDiluentes.FieldByName('BAS_CODBAS').AsString;
      dicRetorno['pordil'] := qryDiluentes.FieldByName('DIL_MINIMO').AsFloat;
      Break;
    End;
  End;

  //Aplicando a taxa de diluicao
  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], ''))) Then
      Break;

    If IfNull(dicRetorno['qtdb' + fStrZero(intCont, 2)], 0) > 0 Then
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := dicRetorno['qtdb' + fStrZero(intCont, 2)] * fltTaxa
    Else
      dicRetorno['qtdd' + fStrZero(intCont, 2)] := dicRetorno['qtdd' + fStrZero(intCont, 2)] * fltTaxa;
  End;
end;

procedure TExportaTintometricosTerceirosNexa.pRetPrecosAdicionais(
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
  strEmb: String;
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltEmbala          := 0;

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

        If dicRetorno['NVFORMULA'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];
          ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := fArredondaNex(fFormataFloatNexa(dicRetorno['qtdb' + fStrZero(intContador, 2)], 1));
          ArrComponentes[intContador].Quantiddil := fArredondaNex(fFormataFloatNexa(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 1));
        End;
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

          If qryBasEmp.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
          Begin
            If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBasEmp.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End
          Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
            fltEmbala := fRetEmbalagem(qryBases);

          //Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantCon) * fltPrecoBase) / fltEmbala);
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantDil) * fltPrecoBase) / fltEmbala);
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

      //Calcula Preço de Custo
      fltPrecoCustoTotalCon := 0;
      fltPrecoCustoTotalDil := 0;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBasEmp.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreCusPro
          Else
            fltPrecoBase := qryBasEmp.FieldByName('PRECUS').AsFloat;
        End
        Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreCusPro
          Else
            fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
          fltEmbala := fRetEmbalagem(qryBases);

        //Preco de custo concentrado
        fltQuantCon := (ArrComponentes[intContador].Quantidade * arrEmbalagens[intEmb].fltVolume / 1);
        fltPrecoCustoCon := (fltQuantCon * fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preco de custo diluido
        fltQuantDil := (ArrComponentes[intContador].Quantiddil * arrEmbalagens[intEmb].fltVolume / 1);
        fltPrecoCustoDil := (fltQuantDil * fltPrecoBase / fltEmbala);
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

procedure TExportaTintometricosTerceirosNexa.pRetPrecoTintas(
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
begin
  fltPrecoBase       := 0;
  fltPrecoEmbalagem  := 0;
  fltPreCusPro       := 0;
  fltPreVenPro       := 0;
  strCodCli          := '';
  strCodCnd          := '';
  intPrzMed          := 0;
  fltEmbala          := 0;


  strTabelaUnica := dicRetorno['tabelaunica'];

  strProNex := fRetItemVenda(dicRetorno['tipcor']);

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


        If dicRetorno['NVFORMULA'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];
          ArrComponentes[intContador].Quantiddil := IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := fArredondaNex(fFormataFloatNexa(dicRetorno['qtdb' + fStrZero(intContador, 2)], 1));
          ArrComponentes[intContador].Quantiddil := fArredondaNex(fFormataFloatNexa(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0), 1));
        End;
      End;

      //Calcula o preco de venda
      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBasEmp.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBasEmp.FieldByName('ITE_PREVEN').AsFloat;
        End
        Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
          fltEmbala := fRetEmbalagem(qryBases);

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantCon) * fltPrecoBase) / fltEmbala);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := (((arrEmbalagens[intEmb].fltVolume / 1 * fltQuantDil) * fltPrecoBase) / fltEmbala);
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

procedure TExportaTintometricosTerceirosNexa.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosNexa.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  pCriaClientEmbalagem(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.
