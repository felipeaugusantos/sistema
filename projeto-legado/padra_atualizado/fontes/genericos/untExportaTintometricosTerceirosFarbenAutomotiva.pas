unit untExportaTintometricosTerceirosFarbenAutomotiva;

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
  TExportaTintometricosTerceirosFarbenAutomotiva = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProFar: String;
    stlDiluentes: TStringList;
    strAcrMob: String;
    blnDiluente: Boolean;
    blnConcentrado: Boolean;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;
    function fRetornarDensidade(strCodBas : String) : Double;
  Protected
    procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
    procedure pCriaTabelaExportacao; Override;


  {$IFDEF LINUX}
    procedure pValidarPrecoExportacaoFarben(AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double; dicPrecos: TDicionario; APrefix: String; ADiluente: String);
  {$ENDIF}
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
    function fRetCODEMP: String; Override;
    function fRetTipoCor(): String; Override;
    function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; Override;
    function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; Override;
    function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; Override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;

    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemTB(): String;
    function fRetEmbalagemSP(): String;
    function fRetProdutoVenda(Conexao: TUniConnection): String;

    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabelasVenda(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure CarregarDados();


    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
    destructor Destroy; Override;
  End;

implementation

{ TExportaTintometricosTerceirosFarbenAutomotiva }

procedure TExportaTintometricosTerceirosFarbenAutomotiva.CarregarDados;
Var
  qryGen: TUniQuery;
begin
  stlDiluentes := TStringList.Create();
  stlDiluentes.Clear;

  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT          ');
    qryGen.SQL.Add('    *             ');
    qryGen.SQL.Add('  FROM            ');
    qryGen.SQL.Add('    FAR_CADBAS    ');
    qryGen.SQL.Add('  INNER JOIN CADITE ON      ');
    qryGen.SQL.Add('    BAS_CODITE = ITE_CODITE     ');
    qryGen.SQL.Add('  WHERE BAS_CODBAS IN ("558.400", "558.000")      ');
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit;

    While Not qryGen.Eof Do
    Begin
      stlDiluentes.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

constructor TExportaTintometricosTerceirosFarbenAutomotiva.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProFar := '';
  pPreencheEmbalagens;
  CarregarDados;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosFarbenAutomotiva.Destroy;
begin
  inherited;
  If Assigned(stlDiluentes) Then
    FreeAndNil(stlDiluentes);

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fArredondaValor(
  fltValor: Double; intCasas: Integer): Double;
begin
  Result := fStrToFloat(FormatFloat('0.' + fStrZero(0, intCasas), fltValor));
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fCamposSelect: String;
Var
  intCont: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    F.FAR_CODNFM,         ';
  Result := Result + '    F.FAR_DESCRI,         ';
  Result := Result + '    M.FAR_DESMON,         ';
  Result := Result + '    F.FAR_O_E_M_,         ';
  Result := Result + '    F.FAR_A_N_O_,         ';
  Result := Result + '    F.FAR_SETOR_,         ';
  Result := Result + '    F.FAR_LINHA_,         ';
  Result := Result + '    F.FAR_CODEMP,         ';
  Result := Result + '    F.FAR_MONTAD,         ';
  Result := Result + '    F.FAR_CODSEQ,         ';
  Result := Result + '    F.FAR_ACRMOB,         ';
  Result := Result + '    F.FAR_TIPPRG,         ';
  Result := Result + '    F.FAR_OBSERV,         ';

  For intCont := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    F.FAR_CODB' + fStrZero(intCont, 2) + ',       ';
    Result := Result + '    F.FAR_QTDC' + fStrZero(intCont, 2) + ',       ';
    Result := Result + '    F.FAR_QTDD' + fStrZero(intCont, 2) + ',       ';
  End;

  Result := Result + '    F.FAR_MD5KEY          ';
  Result := Result + '  FROM                    ';
  Result := Result + '    FAR_CADFAR F          ';
  Result := Result + '  LEFT JOIN FAR_CADMON M ON           ';
  Result := Result + '    (F.FAR_MONTAD = M.FAR_CODMON)           ';
  Result := Result + '  WHERE                   ';
  Result := Result + '    TRUE;                 ';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE ' + fNomeTabela() + '    (       ';
  Result := Result + '    FAR_CODNFM VARCHAR(15),           ';
  Result := Result + '    FAR_DESCRI VARCHAR(60),           ';
  Result := Result + '    FAR_LINHA_ CHAR(2),               ';
  Result := Result + '    FAR_O_E_M_ VARCHAR(5),            ';
  Result := Result + '    FAR_MONTAD CHAR(4),               ';
  Result := Result + '    FAR_A_N_O_ CHAR(4),               ';
  Result := Result + '    FAR_SETOR_ CHAR(1),               ';
  Result := Result + '    FAR_TIPPRG CHAR(1),               ';
  Result := Result + '    FAR_OBSERV VARCHAR(255),          ';
  Result := Result + '    FAR_MD5KEY VARCHAR(32),           ';

  Result := Result + '    FAR_CODITE VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    FAR_CODDIL VARCHAR(20),           ';
  Result := Result + '    FAR_PORDIL DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRECLT DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRECGL DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRECLA DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRECCP DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRECTB DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRECSP DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PREDLT DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREDGL DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREDLA DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREDCP DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREDTB DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREDSP DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PCUCLT DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUCGL DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUCLA DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUCCP DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUCTB DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUCSP DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PCUDLT DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUDGL DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUDLA DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUDCP DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUDTB DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PCUDSP DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRCLT1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLT2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLT3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLT4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLT5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLT6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLT7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRDLT1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLT2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLT3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLT4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLT5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLT6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLT7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRCGL1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCGL2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCGL3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCGL4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCGL5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCGL6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCGL7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRDGL1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDGL2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDGL3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDGL4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDGL5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDGL6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDGL7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRCLA1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLA2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLA3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLA4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLA5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLA6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCLA7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRDLA1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLA2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLA3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLA4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLA5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLA6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDLA7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRCCP1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCCP2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCCP3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCCP4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCCP5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCCP6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCCP7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRDCP1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDCP2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDCP3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDCP4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDCP5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDCP6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDCP7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRCTB1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCTB2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCTB3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCTB4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCTB5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCTB6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCTB7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRDTB1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDTB2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDTB3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDTB4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDTB5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDTB6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDTB7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRCSP1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCSP2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCSP3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCSP4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCSP5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCSP6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRCSP7 DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PRDSP1 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDSP2 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDSP3 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDSP4 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDSP5 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDSP6 DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PRDSP7 DECIMAL(12, 4),        ';


  Result := Result + '    FAR_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    FAR_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    FAR_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    FAR_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    FAR_EMBATB VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    FAR_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),            ';

  Result := Result + '    FAR_VOLULT DECIMAL(12, 4),        ';
  Result := Result + '    FAR_VOLUGL DECIMAL(12, 4),        ';
  Result := Result + '    FAR_VOLULA DECIMAL(12, 4),        ';
  Result := Result + '    FAR_VOLUCP DECIMAL(12, 4),        ';
  Result := Result + '    FAR_VOLUTB DECIMAL(12, 4),        ';
  Result := Result + '    FAR_VOLUSP DECIMAL(12, 4),        ';

  Result := Result + '    FAR_PREELT DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREEGL DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREELA DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREECP DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREETB DECIMAL(12, 4),        ';
  Result := Result + '    FAR_PREESP DECIMAL(12, 4),        ';

  Result := Result + '    FAR_TIPOLT CHAR(2),               ';
  Result := Result + '    FAR_TIPOGL CHAR(2),               ';
  Result := Result + '    FAR_TIPOLA CHAR(2),               ';
  Result := Result + '    FAR_TIPOCP CHAR(2),               ';
  Result := Result + '    FAR_TIPOTB CHAR(2),               ';
  Result := Result + '    FAR_TIPOSP CHAR(2)                ';
  Result := Result + '                  );                  ';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 4;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := Result + 1;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fGetTipoFormula(
  qryGen: TUniQuery; qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
Begin
  If (qryGen.FieldByName('FAR_TIPPRG').AsString = '3') And (qryGen.FieldByName('FAR_LINHA_').AsString = 'PE') Then
    Result := 1
  Else
    Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fNomeTabela: String;
begin
  Result := 'FAR_CADFAR_SIT';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetCODEMP: String;
begin
  Result := 'FAR_CODDIL';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetDescricao: String;
begin
  Result := 'FAR_DESCRI';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_DENSID').AsFloat;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagemCP: String;
begin
  Result := 'FARPCP';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagemGL: String;
begin
  Result := 'FARPGL';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagemLA: String;
begin
  Result := 'FARPSP';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagemLT: String;
begin
  Result := 'FARPLT';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagemSP: String;
begin
  Result := 'FARPSY';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetEmbalagemTB: String;
begin
  Result := 'FARPTB';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'FAR_CODB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetMD5KEY: String;
begin
  Result := 'FAR_MD5KEY';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT                    ';
  Result := Result + '    BAS_CODBAS,             ';
  Result := Result + '    BAS_DENSID,             ';
  Result := Result + '    BAS_DESCRI,             ';
  Result := Result + '    BAS_EMBALA,             ';
  Result := Result + '    BAS_CODITE,             ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN,      ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                      ';
  Result := Result + '    FAR_CADBAS              ';
  Result := Result + '  INNER JOIN CADITE I ON            ';
  Result := Result + '    BAS_CODITE = I.ITE_CODITE             ';
  Result := Result + '  INNER JOIN ITEGER G ON            ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE           ';
  Result := Result + '  WHERE                     ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaCampoEmbalagem(
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
  Else If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP();
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaFatorDensidade(
  strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := 0;

    strSQL := '';
    strSQL := strSQL + '  SELECT                        ';
    strSQL := strSQL + '    CFG_VALCFG                  ';
    strSQL := strSQL + '  FROM                          ';
    strSQL := strSQL + '    CFGTIN                      ';
    strSQL := strSQL + '  WHERE                         ';
    strSQL := strSQL + '    CFG_IDEPRO = "FAR" AND            ';
    strSQL := strSQL + '    CFG_CODCFG = "APREVE" AND         ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

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

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornarDensidade(
  strCodBas: String): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                        ';
    strSQL := strSQL + '    BAS_DENSID                  ';
    strSQL := strSQL + '  FROM                          ';
    strSQL := strSQL + '    FAR_CADBAS                  ';
    strSQL := strSQL + '  WHERE                         ';
    strSQL := strSQL + '    BAS_CODBAS = :CODBAS        ';

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_DENSID').AsFloat;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetornaTotalDensidade(
  strTipPrg: String; fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetProdutoVenda(
  Conexao: TUniConnection): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT                  ';
  strSQL := strSQL + '    CFG_VALCFG            ';
  strSQL := strSQL + '  FROM                    ';
  strSQL := strSQL + '    CFGTIN                ';
  strSQL := strSQL + '  WHERE                   ';
  strSQL := strSQL + '    CFG_IDEPRO = "FAR" AND          ';
  strSQL := strSQL + '    CFG_CODCFG = "FARPRO" AND       ';
  strSQL := strSQL + '    CFG_CODEMP = "' + VS_strCodEmp + '"     ';

  qryGen := fCriaQuery(Nil, Conexao);
  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.Open;

  Result := qryGen.FieldByName('CFG_VALCFG').AsString;

  FreeAndNil(qryGen);
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'FAR_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetTipoCor: String;
begin
  Result := 'FAR_DESCRI';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "FAR" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + ' (         ';
  Result := Result + '    FAR_CODNFM,               ';
  Result := Result + '    FAR_DESCRI,               ';
  Result := Result + '    FAR_LINHA_,               ';
  Result := Result + '    FAR_O_E_M_,               ';
  Result := Result + '    FAR_MONTAD,               ';
  Result := Result + '    FAR_A_N_O_,               ';
  Result := Result + '    FAR_SETOR_,               ';
  Result := Result + '    FAR_TIPPRG,               ';
  Result := Result + '    FAR_OBSERV,               ';
  Result := Result + '    FAR_MD5KEY,               ';
  Result := Result + '    FAR_CODITE,               ';
  Result := Result + '    FAR_CODDIL,               ';
  Result := Result + '    FAR_PORDIL,               ';

  Result := Result + '    FAR_PRECLT,               ';
  Result := Result + '    FAR_PRECGL,               ';
  Result := Result + '    FAR_PRECLA,               ';
  Result := Result + '    FAR_PRECCP,               ';
  Result := Result + '    FAR_PRECTB,               ';
  Result := Result + '    FAR_PRECSP,               ';

  Result := Result + '    FAR_PREDLT,               ';
  Result := Result + '    FAR_PREDGL,               ';
  Result := Result + '    FAR_PREDLA,               ';
  Result := Result + '    FAR_PREDCP,               ';
  Result := Result + '    FAR_PREDTB,               ';
  Result := Result + '    FAR_PREDSP,               ';

  Result := Result + '    FAR_PCUCLT,               ';
  Result := Result + '    FAR_PCUCGL,               ';
  Result := Result + '    FAR_PCUCLA,               ';
  Result := Result + '    FAR_PCUCCP,               ';
  Result := Result + '    FAR_PCUCTB,               ';
  Result := Result + '    FAR_PCUCSP,               ';

  Result := Result + '    FAR_PCUDLT,               ';
  Result := Result + '    FAR_PCUDGL,               ';
  Result := Result + '    FAR_PCUDLA,               ';
  Result := Result + '    FAR_PCUDCP,               ';
  Result := Result + '    FAR_PCUDTB,               ';
  Result := Result + '    FAR_PCUDSP,               ';

  Result := Result + '    FAR_PRCLT1,               ';
  Result := Result + '    FAR_PRCLT2,               ';
  Result := Result + '    FAR_PRCLT3,               ';
  Result := Result + '    FAR_PRCLT4,               ';
  Result := Result + '    FAR_PRCLT5,               ';
  Result := Result + '    FAR_PRCLT6,               ';
  Result := Result + '    FAR_PRCLT7,               ';

  Result := Result + '    FAR_PRDLT1,               ';
  Result := Result + '    FAR_PRDLT2,               ';
  Result := Result + '    FAR_PRDLT3,               ';
  Result := Result + '    FAR_PRDLT4,               ';
  Result := Result + '    FAR_PRDLT5,               ';
  Result := Result + '    FAR_PRDLT6,               ';
  Result := Result + '    FAR_PRDLT7,               ';

  Result := Result + '    FAR_PRCGL1,               ';
  Result := Result + '    FAR_PRCGL2,               ';
  Result := Result + '    FAR_PRCGL3,               ';
  Result := Result + '    FAR_PRCGL4,               ';
  Result := Result + '    FAR_PRCGL5,               ';
  Result := Result + '    FAR_PRCGL6,               ';
  Result := Result + '    FAR_PRCGL7,               ';

  Result := Result + '    FAR_PRDGL1,               ';
  Result := Result + '    FAR_PRDGL2,               ';
  Result := Result + '    FAR_PRDGL3,               ';
  Result := Result + '    FAR_PRDGL4,               ';
  Result := Result + '    FAR_PRDGL5,               ';
  Result := Result + '    FAR_PRDGL6,               ';
  Result := Result + '    FAR_PRDGL7,               ';

  Result := Result + '    FAR_PRCLA1,               ';
  Result := Result + '    FAR_PRCLA2,               ';
  Result := Result + '    FAR_PRCLA3,               ';
  Result := Result + '    FAR_PRCLA4,               ';
  Result := Result + '    FAR_PRCLA5,               ';
  Result := Result + '    FAR_PRCLA6,               ';
  Result := Result + '    FAR_PRCLA7,               ';

  Result := Result + '    FAR_PRDLA1,               ';
  Result := Result + '    FAR_PRDLA2,               ';
  Result := Result + '    FAR_PRDLA3,               ';
  Result := Result + '    FAR_PRDLA4,               ';
  Result := Result + '    FAR_PRDLA5,               ';
  Result := Result + '    FAR_PRDLA6,               ';
  Result := Result + '    FAR_PRDLA7,               ';

  Result := Result + '    FAR_PRCCP1,               ';
  Result := Result + '    FAR_PRCCP2,               ';
  Result := Result + '    FAR_PRCCP3,               ';
  Result := Result + '    FAR_PRCCP4,               ';
  Result := Result + '    FAR_PRCCP5,               ';
  Result := Result + '    FAR_PRCCP6,               ';
  Result := Result + '    FAR_PRCCP7,               ';

  Result := Result + '    FAR_PRDCP1,               ';
  Result := Result + '    FAR_PRDCP2,               ';
  Result := Result + '    FAR_PRDCP3,               ';
  Result := Result + '    FAR_PRDCP4,               ';
  Result := Result + '    FAR_PRDCP5,               ';
  Result := Result + '    FAR_PRDCP6,               ';
  Result := Result + '    FAR_PRDCP7,               ';

  Result := Result + '    FAR_PRCTB1,               ';
  Result := Result + '    FAR_PRCTB2,               ';
  Result := Result + '    FAR_PRCTB3,               ';
  Result := Result + '    FAR_PRCTB4,               ';
  Result := Result + '    FAR_PRCTB5,               ';
  Result := Result + '    FAR_PRCTB6,               ';
  Result := Result + '    FAR_PRCTB7,               ';

  Result := Result + '    FAR_PRDTB1,               ';
  Result := Result + '    FAR_PRDTB2,               ';
  Result := Result + '    FAR_PRDTB3,               ';
  Result := Result + '    FAR_PRDTB4,               ';
  Result := Result + '    FAR_PRDTB5,               ';
  Result := Result + '    FAR_PRDTB6,               ';
  Result := Result + '    FAR_PRDTB7,               ';

  Result := Result + '    FAR_PRCSP1,               ';
  Result := Result + '    FAR_PRCSP2,               ';
  Result := Result + '    FAR_PRCSP3,               ';
  Result := Result + '    FAR_PRCSP4,               ';
  Result := Result + '    FAR_PRCSP5,               ';
  Result := Result + '    FAR_PRCSP6,               ';
  Result := Result + '    FAR_PRCSP7,               ';

  Result := Result + '    FAR_PRDSP1,               ';
  Result := Result + '    FAR_PRDSP2,               ';
  Result := Result + '    FAR_PRDSP3,               ';
  Result := Result + '    FAR_PRDSP4,               ';
  Result := Result + '    FAR_PRDSP5,               ';
  Result := Result + '    FAR_PRDSP6,               ';
  Result := Result + '    FAR_PRDSP7,               ';

  Result := Result + '    FAR_EMBALT,               ';
  Result := Result + '    FAR_EMBAGL,               ';
  Result := Result + '    FAR_EMBALA,               ';
  Result := Result + '    FAR_EMBACP,               ';
  Result := Result + '    FAR_EMBATB,               ';
  Result := Result + '    FAR_EMBASP,               ';

  Result := Result + '    FAR_VOLULT,               ';
  Result := Result + '    FAR_VOLUGL,               ';
  Result := Result + '    FAR_VOLULA,               ';
  Result := Result + '    FAR_VOLUCP,               ';
  Result := Result + '    FAR_VOLUTB,               ';
  Result := Result + '    FAR_VOLUSP,               ';

  Result := Result + '    FAR_PREELT,               ';
  Result := Result + '    FAR_PREEGL,               ';
  Result := Result + '    FAR_PREELA,               ';
  Result := Result + '    FAR_PREECP,               ';
  Result := Result + '    FAR_PREETB,               ';
  Result := Result + '    FAR_PREESP,               ';

  Result := Result + '    FAR_TIPOLT,               ';
  Result := Result + '    FAR_TIPOGL,               ';
  Result := Result + '    FAR_TIPOLA,               ';
  Result := Result + '    FAR_TIPOCP,               ';
  Result := Result + '    FAR_TIPOTB,               ';
  Result := Result + '    FAR_TIPOSP                ';
  Result := Result + '        )                     ';
  Result := Result + '  VALUES '  + '   (           ';
  Result := Result + '    :CODNFM,                  ';
  Result := Result + '    :DESCRI,                  ';
  Result := Result + '    :LINHA_,                  ';
  Result := Result + '    :O_E_M_,                  ';
  Result := Result + '    :MONTAD,                  ';
  Result := Result + '    :A_N_O_,                  ';
  Result := Result + '    :SETOR_,                  ';
  Result := Result + '    :TIPPRG,                  ';
  Result := Result + '    :OBSERV,                  ';
  Result := Result + '    :MD5KEY,                  ';
  Result := Result + '    :CODITE,                  ';
  Result := Result + '    :CODDIL,                  ';
  Result := Result + '    :PORDIL,                  ';

  Result := Result + '    :PRECLT,                  ';
  Result := Result + '    :PRECGL,                  ';
  Result := Result + '    :PRECLA,                  ';
  Result := Result + '    :PRECCP,                  ';
  Result := Result + '    :PRECTB,                  ';
  Result := Result + '    :PRECSP,                  ';

  Result := Result + '    :PREDLT,                  ';
  Result := Result + '    :PREDGL,                  ';
  Result := Result + '    :PREDLA,                  ';
  Result := Result + '    :PREDCP,                  ';
  Result := Result + '    :PREDTB,                  ';
  Result := Result + '    :PREDSP,                  ';

  Result := Result + '    :PCUCLT,                  ';
  Result := Result + '    :PCUCGL,                  ';
  Result := Result + '    :PCUCLA,                  ';
  Result := Result + '    :PCUCCP,                  ';
  Result := Result + '    :PCUCTB,                  ';
  Result := Result + '    :PCUCSP,                  ';

  Result := Result + '    :PCUDLT,                  ';
  Result := Result + '    :PCUDGL,                  ';
  Result := Result + '    :PCUDLA,                  ';
  Result := Result + '    :PCUDCP,                  ';
  Result := Result + '    :PCUDTB,                  ';
  Result := Result + '    :PCUDSP,                  ';

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

  Result := Result + '    :PRCLA1,                  ';
  Result := Result + '    :PRCLA2,                  ';
  Result := Result + '    :PRCLA3,                  ';
  Result := Result + '    :PRCLA4,                  ';
  Result := Result + '    :PRCLA5,                  ';
  Result := Result + '    :PRCLA6,                  ';
  Result := Result + '    :PRCLA7,                  ';

  Result := Result + '    :PRDLA1,                  ';
  Result := Result + '    :PRDLA2,                  ';
  Result := Result + '    :PRDLA3,                  ';
  Result := Result + '    :PRDLA4,                  ';
  Result := Result + '    :PRDLA5,                  ';
  Result := Result + '    :PRDLA6,                  ';
  Result := Result + '    :PRDLA7,                  ';

  Result := Result + '    :PRCCP1,                  ';
  Result := Result + '    :PRCCP2,                  ';
  Result := Result + '    :PRCCP3,                  ';
  Result := Result + '    :PRCCP4,                  ';
  Result := Result + '    :PRCCP5,                  ';
  Result := Result + '    :PRCCP6,                  ';
  Result := Result + '    :PRCCP7,                  ';

  Result := Result + '    :PRDCP1,                  ';
  Result := Result + '    :PRDCP2,                  ';
  Result := Result + '    :PRDCP3,                  ';
  Result := Result + '    :PRDCP4,                  ';
  Result := Result + '    :PRDCP5,                  ';
  Result := Result + '    :PRDCP6,                  ';
  Result := Result + '    :PRDCP7,                  ';

  Result := Result + '    :PRCTB1,                  ';
  Result := Result + '    :PRCTB2,                  ';
  Result := Result + '    :PRCTB3,                  ';
  Result := Result + '    :PRCTB4,                  ';
  Result := Result + '    :PRCTB5,                  ';
  Result := Result + '    :PRCTB6,                  ';
  Result := Result + '    :PRCTB7,                  ';

  Result := Result + '    :PRDTB1,                  ';
  Result := Result + '    :PRDTB2,                  ';
  Result := Result + '    :PRDTB3,                  ';
  Result := Result + '    :PRDTB4,                  ';
  Result := Result + '    :PRDTB5,                  ';
  Result := Result + '    :PRDTB6,                  ';
  Result := Result + '    :PRDTB7,                  ';

  Result := Result + '    :PRCSP1,                  ';
  Result := Result + '    :PRCSP2,                  ';
  Result := Result + '    :PRCSP3,                  ';
  Result := Result + '    :PRCSP4,                  ';
  Result := Result + '    :PRCSP5,                  ';
  Result := Result + '    :PRCSP6,                  ';
  Result := Result + '    :PRCSP7,                  ';

  Result := Result + '    :PRDSP1,                  ';
  Result := Result + '    :PRDSP2,                  ';
  Result := Result + '    :PRDSP3,                  ';
  Result := Result + '    :PRDSP4,                  ';
  Result := Result + '    :PRDSP5,                  ';
  Result := Result + '    :PRDSP6,                  ';
  Result := Result + '    :PRDSP7,                  ';


  Result := Result + '    :EMBALT,                  ';
  Result := Result + '    :EMBAGL,                  ';
  Result := Result + '    :EMBALA,                  ';
  Result := Result + '    :EMBACP,                  ';
  Result := Result + '    :EMBATB,                  ';
  Result := Result + '    :EMBASP,                  ';

  Result := Result + '    :VOLULT,                  ';
  Result := Result + '    :VOLUGL,                  ';
  Result := Result + '    :VOLULA,                  ';
  Result := Result + '    :VOLUCP,                  ';
  Result := Result + '    :VOLUTB,                  ';
  Result := Result + '    :VOLUSP,                  ';

  Result := Result + '    :PREELT,                  ';
  Result := Result + '    :PREEGL,                  ';
  Result := Result + '    :PREELA,                  ';
  Result := Result + '    :PREECP,                  ';
  Result := Result + '    :PREETB,                  ';
  Result := Result + '    :PREESP,                  ';

  Result := Result + '    :TIPOLT,                  ';
  Result := Result + '    :TIPOGL,                  ';
  Result := Result + '    :TIPOLA,                  ';
  Result := Result + '    :TIPOCP,                  ';
  Result := Result + '    :TIPOTB,                  ';
  Result := Result + '    :TIPOSP                   ';
  Result := Result + '          );                  ';
end;

function TExportaTintometricosTerceirosFarbenAutomotiva.fValorQuantidade(
  fltValor, fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODNFM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_CODNFM').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_DESCRI').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_LINHA_').AsString);
  DataSet.ParamByName('O_E_M_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_O_E_M_').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_MONTAD').AsString);
  DataSet.ParamByName('A_N_O_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_A_N_O_').AsString);
  DataSet.ParamByName('SETOR_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_SETOR_').AsString);
  DataSet.ParamByName('TIPPRG').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_TIPPRG').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('FAR_OBSERV').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('FAR_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProFar;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUCTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUDTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
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
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('FAR_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('FAR_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryEmb: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    *                     ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    CFGTIN                ';
    strSQL := strSQL + '  WHERE                   ';
    strSQL := strSQL + '    CFG_IDEPRO = "FAR" AND          ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

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

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pCriaTabelaExportacao;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(fCamposTabela);
    qryGen.ExecSQL;
    qryGen.Close;
    qryGen.SQL.Clear;

    qryGen.SQL.Add('ALTER TABLE ' + fNomeTabela + ' ADD UNIQUE KEY (' + fRetMD5KEY + ', ' + fRetCODEMP + ')');

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryLog: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "FAR"       ';

    qryLog := fCriaQuery(Nil, Conexao);
    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add(strSQL);
    qryLog.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT      (         ';
    strSQL := strSQL + '    LOG_IDEPRO,           ';
    strSQL := strSQL + '    LOG_DTAEXE,           ';
    strSQL := strSQL + '    LOG_HOREXE,           ';
    strSQL := strSQL + '    LOG_EXECUT            ';
    strSQL := strSQL + '          )                             ';
    strSQL := strSQL + '  VALUES          (                     ';
    strSQL := strSQL + '    "FAR",                ';
    strSQL := strSQL + '    :DTAEXE,              ';
    strSQL := strSQL + '    :HOREXE,              ';
    strSQL := strSQL + '    :EXECUT               ';
    strSQL := strSQL + '          );                            ';

    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add(strSQL);
    qryLog.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryLog.ParamByName('HOREXE').AsDateTime := Time;
    qryLog.ParamByName('EXECUT').AsString   := strStatus;
    qryLog.ExecSQL;
  Finally
    FreeAndNil(qryLog);
  End;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  //Embalagem Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.900;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Embalagem Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.600;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Embalagem Lata
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Embalagem Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.450;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Embalagem Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 200.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Embalagem Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.400;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intEmb: Integer;
  intQtdDiluente: Integer;
  blnBaseNAmarrada: Boolean;
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
    qryInsert.Params.ArraySize := 3;
    intContador := 0;
    intDiluente := 0;

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


      blnBaseNAmarrada := (fGetTipoFormula(qryGen, qryBases) = 3);

      If blnBaseNAmarrada Then
      Begin
        If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

        qryGen.Next;
        Continue;
      End;

      For intQtdDiluente := 0 To fGetTipoFormula(qryGen, qryBases) Do
      Begin
        pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);
        pRecalculaFormula(dicRetorno, qryGen, qryBases);
        pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

      {$IFDEF LINUX}
        If FValidateIndexList.Contains(qryGen.RecNo) Then
        Begin
          For intEmb := 0 To 3 Do
          Begin

            If blnConcentrado Then
            Begin
              pValidarPrecoExportacaoFarben(qryGen.FieldByName(fRetMD5KEY).AsString,
                arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON', arrPrecosPorEmb[intEmb].strCodDil);
            End;

            If blnDiluente Then
            Begin
              pValidarPrecoExportacaoFarben(qryGen.FieldByName(fRetMD5KEY).AsString,
                arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
                arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL', arrPrecosPorEmb[intEmb].strCodDil);
            End;
          End;
        End;
      {$ENDIF}

        fltPreven := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
        pGravaTintometricoTabelasTerceiros(qryInsert, fltPreven, qryGen, intContador);
        Inc(intContador, 1);
        Inc(intDiluente, 1);
      End;

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
          Synchronize(pStep);

      If Not qryGen.Eof Then
        qryGen.Next
      Else
        Break;
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

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  blnNovaFormula: Boolean;
  intContador: Integer;
  fltFatorDensidade  : Double;
  fltTotalDensidade  : Double;
  fltTotalPorcentagem: Double;
  fltFatorPorcentagem: Double;
  qryDiluente: TUniQuery;
  fltQtd: Double;

  fltPeso: Double;
  fltPesoTotal: Double;
begin
  dicRetorno['VolumeOri'] := 0.900;
  blnDiluente := False;

  If qryGen.FieldByName(fRetQuantidade(1)).AsFloat <= 0 Then
    blnConcentrado := False
  Else
    blnConcentrado := True;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin

    If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;


    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := fFormataFloat(qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat, 3);
    dicRetorno['qtdd' + fStrZero(intContador, 2)] := fFOrmataFloat(qryGen.FieldByName('FAR_QTDD' + fStrZero(intContador, 2)).AsFloat, 3);
  End;



  blnNovaFormula := Pos('ESP', qryGen.FieldByName('FAR_CODNFM').AsString) > 0;

  If Not blnNovaFormula Then
  Begin
    fltTotalPorcentagem := 0;
    fltTotalDensidade   := 0;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
        Break;

      {FATOR DA DENSIDADE}
      Try
        fltFatorDensidade := fRetornaFatorDensidade(qryGen.FieldByName('FAR_TIPPRG').AsString,
          qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat,
          fRetornarDensidade(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString));

      Except
        fltFatorDensidade := 1;
      End;

       {SOMATORIO DA PORCENTAGEM}
      fltTotalPorcentagem := fltTotalPorcentagem + qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat;

       {SOMATORIO DA DENSIDADE}
      fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
    End;

    Try
      fltTotalDensidade := fRetornaTotalDensidade(qryGen.FieldByName('FAR_TIPPRG').AsString,
        fltTotalPorcentagem, fltTotalDensidade)
    Except
      fltTotalDensidade := 1;
    End;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
        Break;

      fltQtd := fArredondaValor(0.900 * fltTotalDensidade *
        (qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat / 100) * 1000,
        fCasasDecimaisQtd(qryGen.FieldByName('FAR_TIPPRG').AsString));


      dicRetorno['qtdb' + fStrZero(intContador, 2)] := fltQtd;
    End;

    fltTotalPorcentagem := 0;
    fltTotalDensidade   := 0;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
        Break;

      {FATOR DA DENSIDADE}
       fltFatorDensidade := qryGen.FieldByName('FAR_QTDD' + fStrZero(intContador, 2)).AsFloat / fRetornarDensidade(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString);
      {SOMATORIO DA PORCENTAGEM}
       fltTotalPorcentagem := fltTotalPorcentagem + qryGen.FieldByName('FAR_QTDD' + fStrZero(intContador, 2)).AsFloat;
      {SOMATORIO DA DENSIDADE}
      fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
    End;

    Try
      fltTotalDensidade := fltTotalPorcentagem / fltTotalDensidade;
    Except
      fltTotalDensidade := 1;
    End;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin

      If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
        Break;

      fltQtd := fArredondaValor(0.900 * fltTotalDensidade * (qryGen.FieldByName('FAR_QTDD' + fStrZero(intContador, 2)).AsFloat / 100) * 1000, 5);

      dicRetorno['qtdd' + fStrZero(intContador, 2)] := fltQtd;
    End;
  End;

  If (qryGen.FieldByName('FAR_LINHA_').AsString <> 'PE') And
    (qryGen.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

  If (qryGen.FieldByName('FAR_LINHA_').AsString <> 'PE') And
    (qryGen.FieldByName('FAR_TIPPRG').AsString = '3') Then
    Exit;

  If (qryGen.FieldByName('FAR_LINHA_').AsString = 'PE') And
    (qryGen.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

  Try
    blnDiluente := True;

    qryDiluente := fCriaQuery();
    qryDiluente.Close;
    qryDiluente.SQL.Clear;
    qryDiluente.SQL.Add('  SELECT           ');
    qryDiluente.SQL.Add('    *              ');
    qryDiluente.SQL.Add('  FROM             ');
    qryDiluente.SQL.Add('    FAR_CADBAS     ');
    qryDiluente.SQL.Add('  WHERE BAS_CODBAS = :CODDIL     ');
    qryDiluente.ParamByName('CODDIL').AsString := stlDiluentes[intDiluente];
    qryDiluente.Open;

    If qryGen.IsEmpty Then
      Exit;

    fltFatorPorcentagem := 180;

    For intContador := 1 To fQuantidadeFormulacao() Do
    Begin
      If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
        Break;

      dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat * 100 / fltFatorPorcentagem;
    End;

    If Not blnNovaFormula Then
    Begin
      fltTotalPorcentagem := 0;
      fltTotalDensidade := 0;
      fltPesoTotal := 0;

      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin
        If fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
          Break;

        dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat * 100 / fltFatorPorcentagem;

        {FATOR DENSIDADE}
        fltFatorDensidade := fFormataFloat(qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat * 100 / fltFatorPorcentagem, 4);

        fltPeso :=  fFormataFloat(fltFatorDensidade / fRetornarDensidade(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString), 4);

        {SOMATORIA PORCENTAGEM}
        fltTotalPorcentagem := fltTotalPorcentagem + fFormataFloat(qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat * 100 / fltFatorPorcentagem, 2);

        {SOMATORIA DENSIDADE}
        fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
        fltPesoTotal := fltPesoTotal + fltPeso;
      End;

      {SOMATORIA DENSIDADE + DEN. DILUENTE}
      fltFatorDensidade := fFormataFloat(80 * 100 / fltFatorPorcentagem, 4);
      fltPesoTotal := fltPesoTotal + (fltFatorDensidade / fRetornarDensidade(stlDiluentes[intDiluente]));

      Try
        fltTotalDensidade := fRetornaTotalDensidade(qryGen.FieldByName('FAR_TIPPRG').AsString,
                                                    100,
                                                    fltPesoTotal);

      Except
        fltTotalDensidade := 1;
      End;

      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin
        If Not fEmptyStr(qryGen.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString) Then
          dicRetorno['qtdd' + fStrZero(intContador, 2)] := 0.900 * fltTotalDensidade * (qryGen.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat / fltFatorPorcentagem) * 1000
        Else
        Begin
          dicRetorno['base' + fStrZero(intContador, 2)] := stlDiluentes[intDiluente];
          dicRetorno['coddil'] := stlDiluentes[intDiluente];
          dicRetorno['pordil'] := 80;
          dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0.0;
          dicRetorno['qtdd' + fStrZero(intContador, 2)] := fArredondaValor(0.900 * fltTotalDensidade * (80 / fltFatorPorcentagem) * 1000, 5);
          Break;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryDiluente);
  End;
end;

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pRetPrecosAdicionais(
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
        ArrComponentes[intContador].Quantidade := fFormataFloat((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']), 3);
        ArrComponentes[intContador].Quantiddil := fFormataFloat((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']), 3);
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

        If IsInfinite(fltPrecoVendaTotalCon) Or IsNan(fltPrecoVendaTotalCon) Then
          fltPrecoVendaTotalCon := 0.0;

        If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
          fltPrecoVendaTotalDil := 0.0;

        //Retorna preco da embalagem
        If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
        Begin
          If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
          Else
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
        End;

        If fltPrecoVendaTotalCon > 0 Then
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

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
            fltPrecoBase := fltPreCusPro
          Else
            fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        fltEmbala  := fRetEmbalagem(qryBases);

        //Preco de venda concentrado
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

      If IsInfinite(fltPrecoCustoTotalCon) Or IsNan(fltPrecoCustoTotalCon) Then
        fltPrecoCustoTotalCon := 0.0;

      If IsInfinite(fltPrecoCustoTotalDil) Or IsNan(fltPrecoCustoTotalDil) Then
        fltPrecoCustoTotalDil := 0.0;

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

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pRetPrecoTintas(
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
        ArrComponentes[intContador].Quantidade := fFormataFloat((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']), 3);
        ArrComponentes[intContador].Quantiddil := fFormataFloat((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']), 3);

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

      If IsInfinite(fltPrecoVendaTotalCon) Or IsNan(fltPrecoVendaTotalCon) Then
        fltPrecoVendaTotalCon := 0.0;

      If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
        fltPrecoVendaTotalDil := 0.0;

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

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosFarbenAutomotiva.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  inherited;
  pCriaClientEmbalagem(Conexao);
  strProFar := fRetProdutoVenda(Conexao);
  pRetTabelasVenda(Conexao);
end;

{$IFDEF LINUX}
procedure TExportaTintometricosTerceirosFarbenAutomotiva.pValidarPrecoExportacaoFarben(
  AMd5Key, AEmbPro, AModVen, ASigEmb: string; fltPreVen: Double;
  dicPrecos: TDicionario; APrefix, ADiluente: String);
var
  LValInfo: TValidateInf;
begin
  LValInfo.strIdePro := FIdePro;
  LValInfo.strMD5Key := AMd5Key;
  LValInfo.strEmbPro := AEmbPro;
  LValInfo.strTabPre := fRetornaTabelaPreco;
  LValInfo.strModVen := AModVen;
  LValInfo.fltPreVen := fltPreVen;
  LValInfo.strCodDil := ADiluente;
  LValInfo.fltPreCus := IfNull(dicPrecos['PRECUS' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe1 := IfNull(dicPrecos['PREVE1' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe2 := IfNull(dicPrecos['PREVE2' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe3 := IfNull(dicPrecos['PREVE3' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe4 := IfNull(dicPrecos['PREVE4' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe5 := IfNull(dicPrecos['PREVE5' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe6 := IfNull(dicPrecos['PREVE6' + APrefix + ASigEmb], 0.0);
  LValInfo.fltPreVe7 := IfNull(dicPrecos['PREVE7' + APrefix + ASigEmb], 0.0);
  pValidacaoFormula(LValInfo, VS_strCodEmp);
end;
{$ENDIF}


end.
