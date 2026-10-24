unit untExportaTintometricosTerceirosBrasimixAutomotiva;

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
  untThreadExportacaoTerceiros, DateUtils, Math,
  untExportaTintometricosTerceirosAutomotiva,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

Type
  TExportaTintometricosTerceirosBrasimixAutomotiva = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProBza: String; // Produto para venda Brasimix
    strAcrMob: String;
    blnConcentrado: Boolean;
    function fRetValorAcrMobCfgTin(): String;
    function fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
  Protected
   procedure pProcessaTabelaCores(qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery;
       strTabUni, strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario); Override;
  Public
    function fNomeTabela(): String; Override;
    function fQuantidadeFormulacao: Integer; Override;
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

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
    procedure Execute; override;

    function fRetornaProdutoParaVenda(Conexao: TUniConnection): String;
    procedure pCriaClientEmbalagem(Conexao: TUniConnection);

    function fRetEmbalagemLT(strTipoCor: String): String;
    function fRetEmbalagemGL(strTipoCor: String): String;
    function fRetEmbalagemLA(StrTipoCor: String): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemSP(): String;

    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure pRetTabelasPreco(Conexao: TUniConnection);
    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;

    destructor Destroy; Override;




  End;

implementation

{ TExportaTintometricosTerceirosBrasimixAutomotiva }

constructor TExportaTintometricosTerceirosBrasimixAutomotiva.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  pPreencheEmbalagens;
  strProBza := '';
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosBrasimixAutomotiva.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.Execute;
begin
  inherited;

end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '   BZA_MONTAD,                        ';
  Result := Result + '   BZA_A_N_O_,                        ';
  Result := Result + '   BZA_DESCRI,                        ';
  Result := Result + '   BZA_CODUNI,                        ';
  Result := Result + '   BZA_ARQTXT,                        ';
  Result := Result + '   BZA_CODNFM,                        ';
  Result := Result + '   BZA_ACRMOB,                        ';


  For intContador := 1 To 20 Do
  Begin
    Result := Result + '   BZA_CODB' + fStrZero(intContador, 2) +   ',  ';
    Result := Result + '   BZA_QTDB' + fStrZero(intContador, 2) +   ',  ';
  End;
  Result := Result + '    BZA_MD5KEY                        ';

  Result := Result + '  FROM                                ';
  Result := Result + '    BZA_CADBZA                        ';

  Result := Result + '  WHERE TRUE                          ';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fCamposTabela: String;
begin
  Result := '';
  Result := Result + ' CREATE TABLE ' + fNomeTabela + '(  ';
  Result := Result + '  BZA_MONTAD VARCHAR(15),           ';
  Result := Result + '  BZA_A_N_O_ VARCHAR(4),            ';
  Result := Result + '  BZA_DESCRI VARCHAR(60),           ';
  Result := Result + '  BZA_CODUNI VARCHAR(15),           ';
  Result := Result + '  BZA_ARQTXT VARCHAR(25),           ';
  Result := Result + '  BZA_CODNFM VARCHAR(20),           ';
  Result := Result + '  BZA_MD5KEY VARCHAR(32),           ';
  Result := Result + '  BZA_CODITE VARCHAR(' + fTamCodIte.ToString() + '),            ';
 // Result := Result + '  BZA_TIPO__ VARCHAR(20),           ';

  Result := Result + '  BZA_CODDIL VARCHAR(20),           ';
  Result := Result + '  BZA_PORDIL DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRECLT DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRECGL DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRECLA DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRECCP DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRECSP DECIMAL(12,4),         ';

  Result := Result + '  BZA_PREDLT DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREDGL DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREDLA DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREDCP DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREDSP DECIMAL(12,4),         ';

  Result := Result + '  BZA_PCUCLT DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUCGL DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUCLA DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUCCP DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUCSP DECIMAL(12,4),         ';

  Result := Result + '  BZA_PCUDLT DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUDGL DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUDLA DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUDCP DECIMAL(12,4),         ';
  Result := Result + '  BZA_PCUDSP DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRCLT1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLT2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLT3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLT4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLT5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLT6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLT7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRDLT1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLT2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLT3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLT4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLT5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLT6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLT7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRCGL1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCGL2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCGL3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCGL4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCGL5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCGL6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCGL7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRDGL1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDGL2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDGL3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDGL4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDGL5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDGL6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDGL7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRCLA1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLA2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLA3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLA4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLA5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLA6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCLA7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRDLA1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLA2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLA3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLA4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLA5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLA6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDLA7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRCCP1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCCP2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCCP3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCCP4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCCP5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCCP6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCCP7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRDCP1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDCP2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDCP3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDCP4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDCP5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDCP6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDCP7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRCSP1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCSP2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCSP3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCSP4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCSP5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCSP6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRCSP7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_PRDSP1 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDSP2 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDSP3 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDSP4 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDSP5 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDSP6 DECIMAL(12,4),         ';
  Result := Result + '  BZA_PRDSP7 DECIMAL(12,4),         ';

  Result := Result + '  BZA_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '  BZA_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '  BZA_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '  BZA_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '  BZA_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),            ';

  Result := Result + '  BZA_VOLULT DECIMAL(12,4),         ';
  Result := Result + '  BZA_VOLUGL DECIMAL(12,4),         ';
  Result := Result + '  BZA_VOLULA DECIMAL(12,4),         ';
  Result := Result + '  BZA_VOLUCP DECIMAL(12,4),         ';
  Result := Result + '  BZA_VOLUSP DECIMAL(12,4),         ';

  Result := Result + '  BZA_PREELT DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREEGL DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREELA DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREECP DECIMAL(12,4),         ';
  Result := Result + '  BZA_PREESP DECIMAL(12,4),         ';

  Result := Result + '  BZA_TIPOLT CHAR(2),               ';
  Result := Result + '  BZA_TIPOGL CHAR(2),               ';
  Result := Result + '  BZA_TIPOLA CHAR(2),               ';
  Result := Result + '  BZA_TIPOCP CHAR(2),               ';
  Result := Result + '  BZA_TIPOSP CHAR(2)                ';
  Result := Result + '    );                              ';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fGetTipoFormula(
  qryGen, qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('BZA_CODB' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('BZA_CODB' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fNomeTabela: String;
begin
  Result := 'BZA_CADBZA_SIT';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fQuantidadeFormulacao(): Integer;
Begin
  Result := 20;
End;


function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetDescricao: String;
begin
  Result := 'BZA_DESCRI';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESPEC').AsFloat);
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetEmbalagemCP(): String;
begin
  Result := 'BZACOP';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetEmbalagemGL(strTipoCor: String): String;
begin
  Result := '';

  If Pos('SINT.', strTipoCor) > 0 Then
    Result := 'BZAIGL'
  Else If Pos('SINTETICO', strTipoCor) > 0 Then
    Result := 'BZAIGL'
  Else If Pos('LACA', strTipoCor) > 0 Then
    Result := 'BZAGLA'
  Else If Pos('POLIESTER', strTipoCor) > 0 Then
    Result := 'BZAGPO'
  Else If Pos('POLIURETANO', strTipoCor) > 0 Then
    Result := 'BZAGPU'
  Else If Pos('EPOXI', strTipoCor) > 0 Then
    Result := 'BZAGPE'
  Else If Pos('EPOX', strTipoCor) > 0 Then
    Result := 'BZAGPE';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetEmbalagemLA(StrTipoCor: String): String;
begin
  Result := '';

  If Pos('SINT.', strTipoCor) > 0 Then
    Result := 'BZALAS'
  Else If Pos('SINTETICO', strTipoCor) > 0 Then
    Result := 'BZALAS'
  Else If Pos('LACA', strTipoCor) > 0 Then
    Result := 'BZALAL'
  Else If Pos('POLIESTER', strTipoCor) > 0 Then
    Result := 'BZALAP'
  Else If Pos('POLIURETANO', strTipoCor) > 0 Then
    Result := 'BZALAU'
  Else If Pos('EPOXI', strTipoCor) > 0 Then
    Result := 'BZALAE'
  Else If Pos('EPOX', strTipoCor) > 0 Then
    Result := 'BZALAE';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetEmbalagemLT(strTipoCor: String): String;
begin
  Result := '';

  If Pos('SINT.', strTipoCor) > 0 Then
    Result := 'BZAIEM'
  Else If Pos('SINTETICO', strTipoCor) > 0 Then
    Result := 'BZAIEM'
  Else If Pos('LACA', strTipoCor) > 0 Then
    Result := 'BZALLA'
  Else If Pos('POLIESTER', strTipoCor) > 0 Then
    Result := 'BZALPO'
  Else If Pos('POLIURETANO', strTipoCor) > 0 Then
    Result := 'BZALPU'
  Else If Pos('EPOXI', strTipoCor) > 0 Then
    Result := 'BZALPE'
  Else If Pos('EPOX', strTipoCor) > 0 Then
    Result := 'BZALPE';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetEmbalagemSP(): String;
begin
  Result := 'BZASPR';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'BZA_CODB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetMD5KEY: String;
begin
  Result := 'BZA_MD5KEY';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaBases: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   BAS_CODITE, ';
  Result := Result + '   BAS_CODBAS, ';
  Result := Result + '   BAS_EMBALA, ';
  Result := Result + '   BAS_PESPEC, ';
  Result := Result + '   ITE_PREVE' + fRetornaTabelaPreco + ' AS ITE_PREVEN, ';
  Result := Result + '   G.ITE_PRECUS AS PRECUS,      ';
  Result := Result + '   G.ITE_PREVE1 AS PREVE1,      ';
  Result := Result + '   G.ITE_PREVE2 AS PREVE2,      ';
  Result := Result + '   G.ITE_PREVE3 AS PREVE3,      ';
  Result := Result + '   G.ITE_PREVE4 AS PREVE4,      ';
  Result := Result + '   G.ITE_PREVE5 AS PREVE5,      ';
  Result := Result + '   G.ITE_PREVE6 AS PREVE6,      ';
  Result := Result + '   G.ITE_PREVE7 AS PREVE7       ';
  Result := Result + '  FROM                                 ';
  Result := Result + '    BZA_CADBAS B                       ';
  Result := Result + '    INNER JOIN CADITE I                ';
  Result := Result + '      ON B.BAS_CODITE = I.ITE_CODITE   ';
  Result := Result + '    INNER JOIN ITEGER G                ';
  Result := Result + '      ON I.ITE_CODITE = G.ITE_CODITE   ';
  Result := Result + '  WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor'])
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA(dicRetorno['tipcor'])
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSP;
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add(' WHERE CFG_IDEPRO = "BZA"  AND ');
      SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND  ');
      SQL.Add('       CFG_CODCFG = "APREVE" ');
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

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'BZA_QTDB' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetTipoCor: String;
begin
  Result := 'BZA_ARQTXT';
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "BZA" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela + ' (         ';

  Result := Result + '    BZA_MONTAD,                             ';
  Result := Result + '    BZA_A_N_O_,                             ';
  Result := Result + '    BZA_DESCRI,                             ';
  Result := Result + '    BZA_CODUNI,                             ';
  Result := Result + '    BZA_ARQTXT,                             ';
  Result := Result + '    BZA_CODNFM,                             ';
  Result := Result + '    BZA_MD5KEY,                             ';
  Result := Result + '    BZA_CODITE,                             ';
//  Result := Result + '    BZA_TIPO__,                             ';

  Result := Result + '    BZA_CODDIL,                             ';
  Result := Result + '    BZA_PORDIL,                             ';

  Result := Result + '    BZA_PRECLT,                             ';
  Result := Result + '    BZA_PRECGL,                             ';
  Result := Result + '    BZA_PRECLA,                             ';
  Result := Result + '    BZA_PRECCP,                             ';
  Result := Result + '    BZA_PRECSP,                             ';

  Result := Result + '    BZA_PREDLT,                             ';
  Result := Result + '    BZA_PREDGL,                             ';
  Result := Result + '    BZA_PREDLA,                             ';
  Result := Result + '    BZA_PREDCP,                             ';
  Result := Result + '    BZA_PREDSP,                             ';

  Result := Result + '    BZA_PCUCLT,                             ';
  Result := Result + '    BZA_PCUCGL,                             ';
  Result := Result + '    BZA_PCUCLA,                             ';
  Result := Result + '    BZA_PCUCCP,                             ';
  Result := Result + '    BZA_PCUCSP,                             ';

  Result := Result + '    BZA_PCUDLT,                             ';
  Result := Result + '    BZA_PCUDGL,                             ';
  Result := Result + '    BZA_PCUDLA,                             ';
  Result := Result + '    BZA_PCUDCP,                             ';
  Result := Result + '    BZA_PCUDSP,                             ';

  Result := Result + '    BZA_PRCLT1,                             ';
  Result := Result + '    BZA_PRCLT2,                             ';
  Result := Result + '    BZA_PRCLT3,                             ';
  Result := Result + '    BZA_PRCLT4,                             ';
  Result := Result + '    BZA_PRCLT5,                             ';
  Result := Result + '    BZA_PRCLT6,                             ';
  Result := Result + '    BZA_PRCLT7,                             ';

  Result := Result + '    BZA_PRDLT1,                             ';
  Result := Result + '    BZA_PRDLT2,                             ';
  Result := Result + '    BZA_PRDLT3,                             ';
  Result := Result + '    BZA_PRDLT4,                             ';
  Result := Result + '    BZA_PRDLT5,                             ';
  Result := Result + '    BZA_PRDLT6,                             ';
  Result := Result + '    BZA_PRDLT7,                             ';

  Result := Result + '    BZA_PRCGL1,                             ';
  Result := Result + '    BZA_PRCGL2,                             ';
  Result := Result + '    BZA_PRCGL3,                             ';
  Result := Result + '    BZA_PRCGL4,                             ';
  Result := Result + '    BZA_PRCGL5,                             ';
  Result := Result + '    BZA_PRCGL6,                             ';
  Result := Result + '    BZA_PRCGL7,                             ';

  Result := Result + '    BZA_PRDGL1,                             ';
  Result := Result + '    BZA_PRDGL2,                             ';
  Result := Result + '    BZA_PRDGL3,                             ';
  Result := Result + '    BZA_PRDGL4,                             ';
  Result := Result + '    BZA_PRDGL5,                             ';
  Result := Result + '    BZA_PRDGL6,                             ';
  Result := Result + '    BZA_PRDGL7,                             ';

  Result := Result + '    BZA_PRCLA1,                             ';
  Result := Result + '    BZA_PRCLA2,                             ';
  Result := Result + '    BZA_PRCLA3,                             ';
  Result := Result + '    BZA_PRCLA4,                             ';
  Result := Result + '    BZA_PRCLA5,                             ';
  Result := Result + '    BZA_PRCLA6,                             ';
  Result := Result + '    BZA_PRCLA7,                             ';

  Result := Result + '    BZA_PRDLA1,                             ';
  Result := Result + '    BZA_PRDLA2,                             ';
  Result := Result + '    BZA_PRDLA3,                             ';
  Result := Result + '    BZA_PRDLA4,                             ';
  Result := Result + '    BZA_PRDLA5,                             ';
  Result := Result + '    BZA_PRDLA6,                             ';
  Result := Result + '    BZA_PRDLA7,                             ';

  Result := Result + '    BZA_PRCCP1,                             ';
  Result := Result + '    BZA_PRCCP2,                             ';
  Result := Result + '    BZA_PRCCP3,                             ';
  Result := Result + '    BZA_PRCCP4,                             ';
  Result := Result + '    BZA_PRCCP5,                             ';
  Result := Result + '    BZA_PRCCP6,                             ';
  Result := Result + '    BZA_PRCCP7,                             ';

  Result := Result + '    BZA_PRDCP1,                             ';
  Result := Result + '    BZA_PRDCP2,                             ';
  Result := Result + '    BZA_PRDCP3,                             ';
  Result := Result + '    BZA_PRDCP4,                             ';
  Result := Result + '    BZA_PRDCP5,                             ';
  Result := Result + '    BZA_PRDCP6,                             ';
  Result := Result + '    BZA_PRDCP7,                             ';

  Result := Result + '    BZA_PRCSP1,                             ';
  Result := Result + '    BZA_PRCSP2,                             ';
  Result := Result + '    BZA_PRCSP3,                             ';
  Result := Result + '    BZA_PRCSP4,                             ';
  Result := Result + '    BZA_PRCSP5,                             ';
  Result := Result + '    BZA_PRCSP6,                             ';
  Result := Result + '    BZA_PRCSP7,                             ';

  Result := Result + '    BZA_PRDSP1,                             ';
  Result := Result + '    BZA_PRDSP2,                             ';
  Result := Result + '    BZA_PRDSP3,                             ';
  Result := Result + '    BZA_PRDSP4,                             ';
  Result := Result + '    BZA_PRDSP5,                             ';
  Result := Result + '    BZA_PRDSP6,                             ';
  Result := Result + '    BZA_PRDSP7,                             ';

  Result := Result + '    BZA_EMBALT,                             ';
  Result := Result + '    BZA_EMBAGL,                             ';
  Result := Result + '    BZA_EMBALA,                             ';
  Result := Result + '    BZA_EMBACP,                             ';
  Result := Result + '    BZA_EMBASP,                             ';

  Result := Result + '    BZA_VOLULT,                             ';
  Result := Result + '    BZA_VOLUGL,                             ';
  Result := Result + '    BZA_VOLULA,                             ';
  Result := Result + '    BZA_VOLUCP,                             ';
  Result := Result + '    BZA_VOLUSP,                             ';

  Result := Result + '    BZA_PREELT,                             ';
  Result := Result + '    BZA_PREEGL,                             ';
  Result := Result + '    BZA_PREELA,                             ';
  Result := Result + '    BZA_PREECP,                             ';
  Result := Result + '    BZA_PREESP,                             ';

  Result := Result + '    BZA_TIPOLT,                             ';
  Result := Result + '    BZA_TIPOGL,                             ';
  Result := Result + '    BZA_TIPOLA,                             ';
  Result := Result + '    BZA_TIPOCP,                             ';
  Result := Result + '    BZA_TIPOSP                              ';
  Result := Result + '                )                           ';

  Result := Result + '  VALUES (                                  ';

  Result := Result + '    :MONTAD,                                ';
  Result := Result + '    :A_N_O_,                                ';
  Result := Result + '    :DESCRI,                                ';
  Result := Result + '    :CODUNI,                                ';
  Result := Result + '    :ARQTXT,                                ';
  Result := Result + '    :CODNFM,                                ';
  Result := Result + '    :MD5KEY,                                ';
  Result := Result + '    :CODITE,                                ';
//  Result := Result + '    :TIPO__,                                ';

  Result := Result + '    :CODDIL,                                ';
  Result := Result + '    :PORDIL,                                ';

  Result := Result + '    :PRECLT,                                ';
  Result := Result + '    :PRECGL,                                ';
  Result := Result + '    :PRECLA,                                ';
  Result := Result + '    :PRECCP,                                ';
  Result := Result + '    :PRECSP,                                ';

  Result := Result + '    :PREDLT,                                ';
  Result := Result + '    :PREDGL,                                ';
  Result := Result + '    :PREDLA,                                ';
  Result := Result + '    :PREDCP,                                ';
  Result := Result + '    :PREDSP,                                ';

  Result := Result + '    :PCUCLT,                                ';
  Result := Result + '    :PCUCGL,                                ';
  Result := Result + '    :PCUCLA,                                ';
  Result := Result + '    :PCUCCP,                                ';
  Result := Result + '    :PCUCSP,                                ';

  Result := Result + '    :PCUDLT,                                ';
  Result := Result + '    :PCUDGL,                                ';
  Result := Result + '    :PCUDLA,                                ';
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

  Result := Result + '    :PRCLA1,                                ';
  Result := Result + '    :PRCLA2,                                ';
  Result := Result + '    :PRCLA3,                                ';
  Result := Result + '    :PRCLA4,                                ';
  Result := Result + '    :PRCLA5,                                ';
  Result := Result + '    :PRCLA6,                                ';
  Result := Result + '    :PRCLA7,                                ';

  Result := Result + '    :PRDLA1,                                ';
  Result := Result + '    :PRDLA2,                                ';
  Result := Result + '    :PRDLA3,                                ';
  Result := Result + '    :PRDLA4,                                ';
  Result := Result + '    :PRDLA5,                                ';
  Result := Result + '    :PRDLA6,                                ';
  Result := Result + '    :PRDLA7,                                ';

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
  Result := Result + '    :EMBALA,                                ';
  Result := Result + '    :EMBACP,                                ';
  Result := Result + '    :EMBASP,                                ';

  Result := Result + '    :VOLULT,                                ';
  Result := Result + '    :VOLUGL,                                ';
  Result := Result + '    :VOLULA,                                ';
  Result := Result + '    :VOLUCP,                                ';
  Result := Result + '    :VOLUSP,                                ';

  Result := Result + '    :PREELT,                                ';
  Result := Result + '    :PREEGL,                                ';
  Result := Result + '    :PREELA,                                ';
  Result := Result + '    :PREECP,                                ';
  Result := Result + '    :PREESP,                                ';

  Result := Result + '    :TIPOLT,                                ';
  Result := Result + '    :TIPOGL,                                ';
  Result := Result + '    :TIPOLA,                                ';
  Result := Result + '    :TIPOCP,                                ';
  Result := Result + '    :TIPOSP                                 ';
  Result := Result + '                );                          ';

end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fValorQuantidade(
  fltValor, fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

function TExportaTintometricosTerceirosBrasimixAutomotiva.fRetornaProdutoParaVenda(
  Conexao: TUniConnection): String;
var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add('  WHERE CFG_IDEPRO = "BZA" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODCFG = "PROBZA" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;

      Result := qryGen.FieldByName('CFG_VALCFG').AsString;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZA_MONTAD').AsString);
  DataSet.ParamByName('A_N_O_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZA_A_N_O_').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZA_DESCRI').AsString);
  DataSet.ParamByName('CODUNI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZA_CODUNI').AsString);
  DataSet.ParamByName('ARQTXT').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZA_ARQTXT').AsString);
  DataSet.ParamByName('CODNFM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('BZA_CODNFM').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('BZA_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProBza;
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
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
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
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('BZA_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('BZA_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pCriaClientEmbalagem(
  Conexao: TUniConnection);
var
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
      SQL.Add('  WHERE CFG_IDEPRO = "BZA" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;
    End;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "BZA" ');
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('  INSERT INTO LOGTIN_SIT (        ');
    qryGen.SQL.Add('    LOG_IDEPRO,                   ');
    qryGen.SQL.Add('    LOG_DTAEXE,                   ');
    qryGen.SQL.Add('    LOG_HOREXE,                   ');
    qryGen.SQL.Add('    LOG_EXECUT                    ');
    qryGen.SQL.Add('              )                   ');
    qryGen.SQL.Add('  VALUES                 (        ');
    qryGen.SQL.Add('    "BZA",                        ');
    qryGen.SQL.Add('    :DTAEXE,                      ');
    qryGen.SQL.Add('    :HOREXE,                      ');
    qryGen.SQL.Add('    :EXECUT                       ');
    qryGen.SQL.Add('              );                  ');

    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString   := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pPreencheArrayEmbalagem;
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

  //Lata
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.0;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.400;

end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pProcessaTabelaCores(
  qryInsert: TFDQuery; qryGen, qryBases, qryColorantes: TUniQuery; strTabUni,
  strTabPre: String; fltPerAcr: Double; dicRetorno: TDicionario);
Var
  fltPreVen  : Double;
  intContador: Integer;
  intRegistros: Integer;
  intEmb: Integer;
begin
  If Not FAutoma Then
    FProgresso.Position := 0;

{$IFDEF LINUX}
  FInicioExportacao := Now;
{$ENDIF}

{$IFDEF LINUX}
  pGerarArrayValidacao(qryGen.RecordCount);
{$ENDIF}

  qryGen.First;

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
          If blnConcentrado Then
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

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intCont: Integer;
  intInc: Integer;
begin
  blnConcentrado := True;

  For intCont := 1 To fQuantidadeFormulacao Do
  Begin
    If fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intCont, 2)], '')) Then
      Break;

    If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intCont, 2)], [])) Then
      Break;

    If (qryGen.FieldByName('BZA_CODB' + fStrZero(intCont, 2)).AsString = 'DILUEN') Or
      (qryGen.FieldByName('BZA_CODB' + fStrZero(intCont, 2)).AsString = 'TD00050') Then
    Begin
      blnConcentrado := False;
      //Zerar as bases concentradas pois contem diluente
      For intInc := 1 To fQuantidadeFormulacao Do
      Begin

        If fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intInc, 2)], '')) Then
          Break;

        dicRetorno['qtdb' + fStrZero(intInc, 2)] := 0.0000;
        dicRetorno['qtdd' + fStrZero(intInc, 2)] := qryGen.FieldByName(fRetQuantidade(intInc)).AsFloat;

      End;

      dicRetorno['coddil'] := dicRetorno['base' + fStrZero(intCont, 2)];
      dicRetorno['pordil'] := 0.0000;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pRetPrecosAdicionais(
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

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        fltEmbala := fRetEmbalagem(qryBases);

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * (arrEmbalagens[intEmb].fltVolume / 0.9)) / fltEmbala);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * (arrEmbalagens[intEmb].fltVolume / 0.9)) / fltEmbala);
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

          //Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := (fltQuantCon * fltPrecoBase);
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;


          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := (fltQuantDil * fltPrecoBase);
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

        //Preço de venda concentrado
        If fltPrecoVendaTotalCon > 0 Then
          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        //Preço de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon;
        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil;
      End;

      fltPrecoCustoTotalCon := 0.0;
      fltPrecoCustoTotalDil := 0.0;

      //Calcula o preco de custo
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

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := (fltQuantCon * fltPrecoBase);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;


        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoCustoDil := (fltQuantDil * fltPrecoBase);
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

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pRetPrecoTintas(
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

        ArrComponentes[intContador].Componente := dicRetorno['base' + fStrZero(intContador, 2)];
        ArrComponentes[intContador].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * (arrEmbalagens[intEmb].fltVolume / 0.9)) / fltEmbala);
        ArrComponentes[intContador].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * (arrEmbalagens[intEmb].fltVolume / 0.9)) / fltEmbala);
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

        //Preco de venda concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoVendaCon := (fltQuantCon * fltPrecoBase);
        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;


        //Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoVendaDil := (fltQuantDil * fltPrecoBase);
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

  pRetPrecosAdicionais(dicRetorno, qryCOlorantes, qryBases, fltPerAcr);
end;

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pRetTabelasPreco(
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

procedure TExportaTintometricosTerceirosBrasimixAutomotiva.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
Begin
  strProBza := fRetornaProdutoParaVenda(Conexao);
  pCriaClientEmbalagem(Conexao);
  pRetTabelasPreco(Conexao);
End;


end.


