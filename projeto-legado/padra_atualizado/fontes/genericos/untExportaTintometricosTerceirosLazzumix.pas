unit untExportaTintometricosTerceirosLazzumix;

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
  TExportaTintometricosTerceirosLazzumix = Class(TExportaTintometricosTerceirosAutomotiva)
   Private
     strProLaz: String;
     fltPerIpi: Double;
     fltPerFre: Double;
     fltPerRet: Double;
     fltPerAdc: Double;
     fltPerPer: Double;
     fltMarLuc: Double;
     fltVOriDil: Double;
     fltVOriCon: Double;
     strAcrMob: String;
     qryBasEmp: TUniQuery; //Base por Empresa
     function fSelectBasesEmpresas(): String;
     procedure pAbrirCadBasesEmpresas();
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
      function fRetornaCodigoDiluente(dicRetorno: TDicionario): String; override;
      function fRetornaPorcentagemDiluente(dicRetorno: TDicionario): Double; override;
      function fRetornaBases: String; override;
      function fRetornaPercentualAcrescimo(Conexao: TUniConnection): Double; override;
      function fRetEmbalagem(qryColorantes: TUniQuery): Double; override;
      function fRetornaCampoEmbalagem(strSigEmb: String; dicRetorno: TDicionario): String; override;

      procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
      procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); override;
      procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); override;
      procedure pSetaParametrosEspecificos(Conexao: TUniConnection); override;
      procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery); Reintroduce;
      procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; arrComponentes: Array Of TComp; intEmbalagem: Integer); Reintroduce;
      procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;
      procedure Execute; override;

      constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;  blnAuto: Boolean = False); override;
      destructor Destroy; override;
      function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;



      function fRetEmbalagemLT(strTipoCor: String): String;
      function fRetEmbalagemGL(strTipoCor: String): String;
      function fRetEmbalagemLA(strTipoCor: String): String;
      function fRetEmbalagemCP(): String;
      function fRetEmbalagemSP(): String;
      function fRetornaProdutoParaVenda(Conexao: TUniConnection): String;
      function fRetornaPercentualFrete(Conexao: TUniConnection): Double;
      function fRetornaPercentualIPI(Conexao: TUniConnection): Double;
      function fRetornaPercentualRetido(Conexao: TUniConnection): Double;
      function fRetornaPercentualAdicionais(Conexao: TUniConnection): Double;
      function fRetornaPercentualPerda(Conexao: TUniConnection): Double;
      function fRetornaMargemLucro(Conexao: TUniConnection): Double;

      procedure pPreencheEmbalagens;
      procedure pPreencheArrayEmbalagem;
      procedure pCriaClientEmbalagem(Conexao: TUniConnection);
      procedure pRetTabelasVenda(Conexao: TUniConnection);
      function fFormataFloatLaz(fltValor: Double): Double;
  End;


implementation

{ TExportaTintometricosTerceirosLazzumix }

constructor TExportaTintometricosTerceirosLazzumix.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  pPreencheEmbalagens;
  strProLaz := '';
  fltPerIpi := 0.0;
  fltPerFre := 0.0;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
  pAbrirCadBasesEmpresas();
end;

destructor TExportaTintometricosTerceirosLazzumix.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);

  If Assigned(qryBasEmp) Then
    FreeAndNil(qryBasEmp);
end;

procedure TExportaTintometricosTerceirosLazzumix.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosLazzumix.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                              ';
  Result := Result + '    MIX_CODIGO,                       ';
  Result := Result + '    MIX_DESCRI,                       ';
  Result := Result + '    MIX_REFERE,                       ';
  Result := Result + '    MIX_MONTAD,                       ';
  Result := Result + '    MIX_DTACAD,                       ';
  Result := Result + '    MIX_A_N_O_,                       ';
  Result := Result + '    MIX_UNIVER,                       ';
  Result := Result + '    MIX_VOLCON,                       ';
  Result := Result + '    MIX_VOLDIL,                       ';
  Result := Result + '    MIX_VOLMID,                       ';
  Result := Result + '    MIX_VOLMIC,                       ';


  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    MIX_BASE' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    MIX_QTDC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    MIX_QTDD' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    MIX_ACRMOB                        ';
  Result := Result + '  FROM                                ';
  Result := Result + '    LAZ_CADMIX                        ';
end;

function TExportaTintometricosTerceirosLazzumix.fCamposTabela: String;
begin
  Result := ' CREATE TABLE ' + fNomeTabela() + '    (     ';
  Result := Result + '    MIX_CODIGO VARCHAR(25),                     ';
  Result := Result + '    MIX_DESCRI VARCHAR(65),                     ';
  Result := Result + '    MIX_REFERE VARCHAR(15),                     ';
  Result := Result + '    MIX_MONTAD VARCHAR(15),                     ';
  Result := Result + '    MIX_A_N_O_ VARCHAR(4),                      ';
  Result := Result + '    MIX_UNIVER VARCHAR(15),                     ';
  Result := Result + '    MIX_MD5KEY VARCHAR(32),                     ';
  Result := Result + '    MIX_CODITE VARCHAR(' + fTamCodIte.ToString() + '),                      '; // Campos referentes a LAZ_CADMIX;
 //-------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_CODDIL VARCHAR(20),                     ';
  Result := Result + '    MIX_PORDIL DECIMAL(12,4),                   '; // Campos referentes a diluentes
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRECLT DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRECGL DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRECLA DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRECCP DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRECSP DECIMAL(12,4),                   '; // Campos referentes ao preço concentrado de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PREDLT DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREDGL DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREDLA DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREDCP DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREDSP DECIMAL(12,4),                   '; // Campos referentes ao preço diluido de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PCUCLT DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUCGL DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUCLA DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUCCP DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUCSP DECIMAL(12,4),                   '; // Campos referentes ao preço de custo concentrado de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PCUDLT DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUDGL DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUDLA DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUDCP DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PCUDSP DECIMAL(12,4),                   '; // Campos referentes ao preço de Custo diluido de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRCLT1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLT2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLT3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLT4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLT5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLT6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLT7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Litro - concentrado
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRDLT1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLT2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLT3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLT4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLT5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLT6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLT7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Litro - diluido
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRCGL1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCGL2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCGL3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCGL4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCGL5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCGL6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCGL7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Galão - concentrado
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRDGL1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDGL2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDGL3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDGL4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDGL5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDGL6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDGL7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Galão - diluido
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRCLA1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLA2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLA3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLA4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLA5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLA6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCLA7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Lata - concentrado
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRDLA1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLA2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLA3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLA4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLA5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLA6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDLA7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Lata - diluido
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRCCP1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCCP2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCCP3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCCP4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCCP5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCCP6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCCP7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Copo - concentrado
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRDCP1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDCP2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDCP3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDCP4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDCP5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDCP6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDCP7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Copo - diluido
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRCSP1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCSP2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCSP3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCSP4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCSP5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCSP6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRCSP7 DECIMAL(12,4),                   '; // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Spray - concentrado
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PRDSP1 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDSP2 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDSP3 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDSP4 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDSP5 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDSP6 DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PRDSP7 DECIMAL(12,4),                   ';  // Campos referentes ao preço de venda (Tabelas de clientes 1 a 7) da embalagem Spray - diluido
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),                      ';
  Result := Result + '    MIX_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),                      ';
  Result := Result + '    MIX_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),                      ';
  Result := Result + '    MIX_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),                      ';
  Result := Result + '    MIX_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),                      '; // Campos referentes ao produto de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_VOLULT DECIMAL(12,4),                   ';
  Result := Result + '    MIX_VOLUGL DECIMAL(12,4),                   ';
  Result := Result + '    MIX_VOLULA DECIMAL(12,4),                   ';
  Result := Result + '    MIX_VOLUCP DECIMAL(12,4),                   ';
  Result := Result + '    MIX_VOLUSP DECIMAL(12,4),                   '; // Campos referentes ao volume de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_PREELT DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREEGL DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREELA DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREECP DECIMAL(12,4),                   ';
  Result := Result + '    MIX_PREESP DECIMAL(12,4),                   '; // Campos referente ao preço de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    MIX_TIPOLT CHAR(2),                         ';
  Result := Result + '    MIX_TIPOGL CHAR(2),                         ';
  Result := Result + '    MIX_TIPOLA CHAR(2),                         ';
  Result := Result + '    MIX_TIPOCP CHAR(2),                         ';
  Result := Result + '    MIX_TIPOSP CHAR(2)                          '; // Campos referente ao tipo de cada embalagem
 //--------------------------------------------------------------------------------------------------------
  Result := Result + '    );                                          '; // Fim da tabela
end;

function TExportaTintometricosTerceirosLazzumix.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosLazzumix.fFormataFloatLaz(
  fltValor: Double): Double;
Var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);

  if Pos(',',strValor) > 0 then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  else
    strValor2 := '0';

  if strValor2 >= '5' then
  begin
    strValor2 := Copy(strValor,1,Pos(',',strValor) + 2);
    strValor2 := FormatFloat('###,#0.0',fStrToFloat(strValor2));
    Result := fStrToFloat(strValor2);
  end
  else if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := fStrToFloat(strValor2);
  end;
end;

function TExportaTintometricosTerceirosLazzumix.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fNomeTabela: String;
begin
  Result := 'LAZ_CADMIX_SIT';
end;

function TExportaTintometricosTerceirosLazzumix.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosLazzumix.fRetDescricao: String;
begin
  Result := 'MIX_DESCRI';
end;

function TExportaTintometricosTerceirosLazzumix.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  Result := (qryColorantes.FieldByName('BAS_EMBALA').AsFloat *
    qryColorantes.FieldByName('BAS_PESESP').AsFloat);
end;

function TExportaTintometricosTerceirosLazzumix.fRetEmbalagemCP: String;
begin
  Result := 'LAZCOP';
end;

function TExportaTintometricosTerceirosLazzumix.fRetEmbalagemGL(
  strTipoCor: String): String;
begin
  If strTipoCor = 'LAZZURIL' Then
    Result := 'LAZIGL'
  Else If strTipoCor = 'LAZZULAC' Then
    Result := 'LAZGLA'
  Else If strTipoCor = 'LAZZUDUR' Then
    Result := 'LAZGPO'
  Else if Pos('LEGACY', strTipoCor) > 0 Then
    Result := 'LAZGLL'
  Else If strTipoCor = 'POLIURETANO' Then
    Result := 'LAZGPU'
  Else If strTipoCor = 'LAZZUCRIL' Then
    Result := 'LAZGCR'
  Else If strTipoCor = 'FLEET COLOR' Then
    Result := 'LAZGFL'
  Else if Pos('ULTRA', strTipoCor) > 0 Then
    Result := 'ULTRABASEGL'
  Else If strTipoCor = 'LAZZUDUR PU MS' Then
    Result := 'PUMSGL'
  Else if Pos('SHERTRUCK', strTipoCor) > 0 Then
    Result := 'SHERGL'
  Else If strTipoCor = 'PERSONALIZADA' Then
    Result := 'LAZNGL';
end;

function TExportaTintometricosTerceirosLazzumix.fRetEmbalagemLA(
  strTipoCor: String): String;
begin
  If strTipoCor = 'LAZZURIL' Then
    Result := 'LAZILA'
  Else If strTipoCor = 'LAZZULAC' Then
    Result := 'LAZLAZ'
  Else If strTipoCor = 'LAZZUDUR' Then
    Result := 'LAZLDU'
  Else if Pos('LEGACY', strTipoCor) > 0 Then
    Result := 'LAZLAL'
  Else If strTipoCor = 'POLIURETANO' Then
    Result := 'LAZLAP'
  Else If strTipoCor = 'LAZZUCRIL' Then
    Result := 'LAZLIL'
  Else If strTipoCor = 'FLEET COLOR' Then
    Result := 'LAZLCO'
  Else if Pos('ULTRA', strTipoCor) > 0 Then
    Result := 'ULTRABASELA'
  Else If strTipoCor = 'LAZZUDUR PU MS' Then
    Result := 'PUMSLA'
  Else if Pos('SHERTRUCK', strTipoCor) > 0 Then
    Result := 'SHERLA'
  Else If strTipoCor = 'PERSONALIZADA' Then
    Result := 'LAZNLA';
end;

function TExportaTintometricosTerceirosLazzumix.fRetEmbalagemLT(
  strTipoCor: String): String;
begin
  If strTipoCor = 'LAZZURIL' Then
    Result := 'LAZIEM'
  Else If strTipoCor = 'LAZZULAC' Then
    Result := 'LAZLLA'
  Else If strTipoCor = 'LAZZUDUR' Then
    Result := 'LAZLPO'
  Else if Pos('LEGACY', strTipoCor) > 0 Then
    Result := 'LAZLTL'
  Else If strTipoCor = 'POLIURETANO' Then
    Result := 'LAZLPU'
  Else If strTipoCor = 'LAZZUCRIL' Then
    Result := 'LAZLCR'
  Else If strTipoCor = 'FLEET COLOR' Then
    Result := 'LAZLFL'
  Else if Pos('ULTRA', strTipoCor) > 0 Then
    Result := 'ULTRABASELT'
  Else If strTipoCor = 'LAZZUDUR PU MS' Then
    Result := 'PUMSLT'
  Else if Pos('SHERTRUCK', strTipoCor) > 0 Then
    Result := 'SHERLT'
  Else If strTipoCor = 'PERSONALIZADA' Then
    Result := 'LAZNLT';
end;

function TExportaTintometricosTerceirosLazzumix.fRetEmbalagemSP: String;
begin
  Result := 'LAZSPR';
end;

function TExportaTintometricosTerceirosLazzumix.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'MIX_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosLazzumix.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosLazzumix.fRetMD5KEY: String;
begin
  Result := 'MIX_CODIGO';
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaBases: String;
begin
  Result := ' SELECT                  ' +
            '   BAS_CODBAS,           ' +
            '   BAS_CODITE,           ' +
            '   BAS_EMBALA,           ' +
            '   BAS_DESBAS,           ' +
            '   BAS_PESESP,           ' +
            '   ITE_PREVE'  + fRetornaTabelaPreco + ' AS ITE_PREVEN, ' +
            '   G.ITE_PRECUS AS PRECUS,   ' +
            '   G.ITE_PREVE1 AS PREVE1,   ' +
            '   G.ITE_PREVE2 AS PREVE2,   ' +
            '   G.ITE_PREVE3 AS PREVE3,   ' +
            '   G.ITE_PREVE4 AS PREVE4,   ' +
            '   G.ITE_PREVE5 AS PREVE5,   ' +
            '   G.ITE_PREVE6 AS PREVE6,   ' +
            '   G.ITE_PREVE7 AS PREVE7    ' +
            ' FROM                    ' +
            '   LAZ_CADBAS B          ' +
            '     INNER JOIN CADITE I ON      ' +
            '       B.BAS_CODITE = I.ITE_CODITE     ' +
            '     INNER JOIN ITEGER G ON      ' +
            '       I.ITE_CODITE = G.ITE_CODITE     ' +
            ' WHERE                   ' +
            '   G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLt(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGl(dicRetorno['tipcor'])
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLa(dicRetorno['tipcor'])
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCp()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSp();
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaMargemLucro(
  Conexao: TUniConnection): Double;
Var
  qryMar: TUniQuery;
begin
  Try
    qryMar := fCriaQuery(Nil, Conexao);
    qryMar.Close;
    qryMar.SQL.Clear;
    qryMar.SQL.Add('    SELECT CFG_VALCFG FROM CFGTIN   ');
    qryMar.SQL.Add('      WHERE CFG_GRUCFG = "CONFIGURACOES" AND    ');
    qryMar.SQL.Add('        CFG_IDEPRO = "LAZ" AND CFG_CODCFG = "MARLUC" AND    ');
    qryMar.SQL.Add('        CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryMar.Open;

    If fEmptyStr(qryMar.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryMar.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryMar);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT CFG_VALCFG FROM CFGTIN  ');
    qryGen.SQL.Add('    WHERE CFG_IDEPRO = "LAZ"  AND   ');
    qryGen.SQL.Add('      CFG_CODEMP = ' + QuotedStr(VS_strCodEmp) + '  AND ');
    qryGen.SQL.Add('      CFG_CODCFG = "APREVE"         ');
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPercentualAdicionais(
  Conexao: TUniConnection): Double;
Var
  qryAdc: TUniQuery;
begin
  Try
    qryAdc := fCriaQuery(Nil, Conexao);
    qryAdc.Close;
    qryAdc.SQL.Clear;
    qryAdc.SQL.Add('  SELECT CFG_VALCFG FROM CFGTIN     ');
    qryAdc.SQL.Add('    WHERE CFG_IDEPRO = "LAZ" AND    ');
    qryAdc.SQL.Add('      CFG_CODCFG = "PERADC" AND    ');
    qryAdc.SQL.Add('      CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryAdc.SQL.Add('      CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryAdc.Open;

    If fEmptyStr(qryAdc.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryAdc.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryAdc);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPercentualFrete(
  Conexao: TUniConnection): Double;
Var
  qryPer: TUniQuery;
begin
  Try
    qryPer := fCriaQuery(Nil, Conexao);
    qryPer.Close;
    qryPer.SQL.Clear;
    qryPer.SQL.Add('  SELECT CFG_VALCFG FROM CFGTIN     ');
    qryPer.SQL.Add('    WHERE CFG_IDEPRO = "LAZ"  AND   ');
    qryPer.SQL.Add('      CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryPer.SQL.Add('      CFG_CODCFG = "PERFRE" AND     ');
    qryPer.SQL.Add('      CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryPer.Open;

    If fEmptyStr(qryPer.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryPer.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryPer);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPercentualIPI(
  Conexao: TUniConnection): Double;
Var
  qryIpi: TUniQuery;
begin
  Try
    qryIpi := fCriaQuery(Nil, Conexao);
    qryIpi.Close;
    qryIpi.SQL.Clear;
    qryIpi.SQL.Add('  SELECT CFG_VALCFG FROM CFGTIN   ');
    qryIpi.SQL.Add('    WHERE CFG_IDEPRO = "LAZ"  AND     ');
    qryIpi.SQL.Add('      CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryIpi.SQL.Add('      CFG_CODCFG = "PERIPI" AND    ');
    qryIpi.SQL.Add('      CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryIpi.Open;

    If fEmptyStr(qryIpi.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryIpi.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryIpi);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPercentualPerda(
  Conexao: TUniConnection): Double;
Var
  qryPer: TUniQuery;
begin
  Try
    qryPer := fCriaQuery(Nil, Conexao);
    qryPer.Close;
    qryPer.SQL.Clear;
    qryPer.SQL.Add('  SELECT CFG_VALCFG FROM CFGTIN    ');
    qryPer.SQL.Add('    WHERE CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryPer.SQL.Add('      CFG_IDEPRO = "LAZ" AND CFG_CODCFG = "PERPER" AND  ');
    qryPer.SQL.Add('      CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryPer.Open;

    If fEmptyStr(qryPer.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryPer.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryPer);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPercentualRetido(
  Conexao: TUniConnection): Double;
Var
  qryRet: TUniQuery;
begin
  Try
    qryRet := fCriaQuery(Nil, Conexao);
    qryRet.Close;
    qryRet.SQL.Clear;
    qryRet.SQL.Add('   SELECT CFG_VALCFG FROM CFGTIN     ');
    qryRet.SQL.Add('     WHERE CFG_GRUCFG = "CONFIGURACOES" AND   ');
    qryRet.SQL.Add('       CFG_IDEPRO = "LAZ" AND CFG_CODCFG = "PERRET" AND   ');
    qryRet.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryRet.Open;

    If fEmptyStr(qryRet.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := (fStrToFloat(qryRet.FieldByName('CFG_VALCFG').AsString) / 100.0);
  Finally
    FreeAndNil(qryRet);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosLazzumix.fRetornaProdutoParaVenda(
  Conexao: TUniConnection): String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT CFG_VALCFG FROM CFGTIN   ');
    qryGen.SQL.Add('    WHERE CFG_IDEPRO = "LAZ"  AND ');
    qryGen.SQL.Add('      CFG_GRUCFG = "CONFIGURACOES"  AND   ');
    qryGen.SQL.Add('      CFG_CODCFG = "PROLAZ" AND   ');
    qryGen.SQL.Add('      CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'MIX_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosLazzumix.fRetTipoCor: String;
begin
  Result := 'MIX_REFERE';
end;

function TExportaTintometricosTerceirosLazzumix.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "LAZ" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosLazzumix.fSelectBasesEmpresas: String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODEMP,         ';
  Result := Result + '    BAS_CODITE,         ';
  Result := Result + '    BAS_EMBALA,         ';
  Result := Result + '    BAS_PESESP,         ';
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
  Result := Result + '    LAZ_BASEMP B        ';
  Result := Result + '  INNER JOIN ITEGER G ON          ';
  Result := Result + '    B.BAS_CODITE = G.ITE_CODITE             ';
  Result := Result + '  INNER JOIN CADITE I ON          ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE             ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    G.ITE_CODEMP = "' + VS_strCodEmp + '"  AND     ';
  Result := Result + '    B.BAS_CODEMP = "' + VS_strCodEmp + '"   ';
end;

function TExportaTintometricosTerceirosLazzumix.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + ' (         ';

  Result := Result + '    MIX_CODIGO,                       ';
  Result := Result + '    MIX_DESCRI,                       ';
  Result := Result + '    MIX_REFERE,                       ';
  Result := Result + '    MIX_MONTAD,                       ';
  Result := Result + '    MIX_A_N_O_,                       ';
  Result := Result + '    MIX_UNIVER,                       ';
  Result := Result + '    MIX_MD5KEY,                       ';
  Result := Result + '    MIX_CODITE,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_CODDIL,                       ';
  Result := Result + '    MIX_PORDIL,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PRECLT,                       ';
  Result := Result + '    MIX_PRECGL,                       ';
  Result := Result + '    MIX_PRECLA,                       ';
  Result := Result + '    MIX_PRECCP,                       ';
  Result := Result + '    MIX_PRECSP,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PREDLT,                       ';
  Result := Result + '    MIX_PREDGL,                       ';
  Result := Result + '    MIX_PREDLA,                       ';
  Result := Result + '    MIX_PREDCP,                       ';
  Result := Result + '    MIX_PREDSP,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PCUCLT,                       ';
  Result := Result + '    MIX_PCUCGL,                       ';
  Result := Result + '    MIX_PCUCLA,                       ';
  Result := Result + '    MIX_PCUCCP,                       ';
  Result := Result + '    MIX_PCUCSP,                       ';
  Result := Result + '    MIX_PCUDLT,                       ';
  Result := Result + '    MIX_PCUDGL,                       ';
  Result := Result + '    MIX_PCUDLA,                       ';
  Result := Result + '    MIX_PCUDCP,                       ';
  Result := Result + '    MIX_PCUDSP,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PRCLT1,                       ';
  Result := Result + '    MIX_PRCLT2,                       ';
  Result := Result + '    MIX_PRCLT3,                       ';
  Result := Result + '    MIX_PRCLT4,                       ';
  Result := Result + '    MIX_PRCLT5,                       ';
  Result := Result + '    MIX_PRCLT6,                       ';
  Result := Result + '    MIX_PRCLT7,                       ';
  Result := Result + '    MIX_PRDLT1,                       ';
  Result := Result + '    MIX_PRDLT2,                       ';
  Result := Result + '    MIX_PRDLT3,                       ';
  Result := Result + '    MIX_PRDLT4,                       ';
  Result := Result + '    MIX_PRDLT5,                       ';
  Result := Result + '    MIX_PRDLT6,                       ';
  Result := Result + '    MIX_PRDLT7,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PRCGL1,                       ';
  Result := Result + '    MIX_PRCGL2,                       ';
  Result := Result + '    MIX_PRCGL3,                       ';
  Result := Result + '    MIX_PRCGL4,                       ';
  Result := Result + '    MIX_PRCGL5,                       ';
  Result := Result + '    MIX_PRCGL6,                       ';
  Result := Result + '    MIX_PRCGL7,                       ';
  Result := Result + '    MIX_PRDGL1,                       ';
  Result := Result + '    MIX_PRDGL2,                       ';
  Result := Result + '    MIX_PRDGL3,                       ';
  Result := Result + '    MIX_PRDGL4,                       ';
  Result := Result + '    MIX_PRDGL5,                       ';
  Result := Result + '    MIX_PRDGL6,                       ';
  Result := Result + '    MIX_PRDGL7,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PRCLA1,                       ';
  Result := Result + '    MIX_PRCLA2,                       ';
  Result := Result + '    MIX_PRCLA3,                       ';
  Result := Result + '    MIX_PRCLA4,                       ';
  Result := Result + '    MIX_PRCLA5,                       ';
  Result := Result + '    MIX_PRCLA6,                       ';
  Result := Result + '    MIX_PRCLA7,                       ';
  Result := Result + '    MIX_PRDLA1,                       ';
  Result := Result + '    MIX_PRDLA2,                       ';
  Result := Result + '    MIX_PRDLA3,                       ';
  Result := Result + '    MIX_PRDLA4,                       ';
  Result := Result + '    MIX_PRDLA5,                       ';
  Result := Result + '    MIX_PRDLA6,                       ';
  Result := Result + '    MIX_PRDLA7,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PRCCP1,                       ';
  Result := Result + '    MIX_PRCCP2,                       ';
  Result := Result + '    MIX_PRCCP3,                       ';
  Result := Result + '    MIX_PRCCP4,                       ';
  Result := Result + '    MIX_PRCCP5,                       ';
  Result := Result + '    MIX_PRCCP6,                       ';
  Result := Result + '    MIX_PRCCP7,                       ';
  Result := Result + '    MIX_PRDCP1,                       ';
  Result := Result + '    MIX_PRDCP2,                       ';
  Result := Result + '    MIX_PRDCP3,                       ';
  Result := Result + '    MIX_PRDCP4,                       ';
  Result := Result + '    MIX_PRDCP5,                       ';
  Result := Result + '    MIX_PRDCP6,                       ';
  Result := Result + '    MIX_PRDCP7,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PRCSP1,                       ';
  Result := Result + '    MIX_PRCSP2,                       ';
  Result := Result + '    MIX_PRCSP3,                       ';
  Result := Result + '    MIX_PRCSP4,                       ';
  Result := Result + '    MIX_PRCSP5,                       ';
  Result := Result + '    MIX_PRCSP6,                       ';
  Result := Result + '    MIX_PRCSP7,                       ';
  Result := Result + '    MIX_PRDSP1,                       ';
  Result := Result + '    MIX_PRDSP2,                       ';
  Result := Result + '    MIX_PRDSP3,                       ';
  Result := Result + '    MIX_PRDSP4,                       ';
  Result := Result + '    MIX_PRDSP5,                       ';
  Result := Result + '    MIX_PRDSP6,                       ';
  Result := Result + '    MIX_PRDSP7,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_EMBALT,                       ';
  Result := Result + '    MIX_EMBAGL,                       ';
  Result := Result + '    MIX_EMBALA,                       ';
  Result := Result + '    MIX_EMBACP,                       ';
  Result := Result + '    MIX_EMBASP,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_VOLULT,                       ';
  Result := Result + '    MIX_VOLUGL,                       ';
  Result := Result + '    MIX_VOLULA,                       ';
  Result := Result + '    MIX_VOLUCP,                       ';
  Result := Result + '    MIX_VOLUSP,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_PREELT,                       ';
  Result := Result + '    MIX_PREEGL,                       ';
  Result := Result + '    MIX_PREELA,                       ';
  Result := Result + '    MIX_PREECP,                       ';
  Result := Result + '    MIX_PREESP,                       ';
 //---------------------------------------------------------------
  Result := Result + '    MIX_TIPOLT,                       ';
  Result := Result + '    MIX_TIPOGL,                       ';
  Result := Result + '    MIX_TIPOLA,                       ';
  Result := Result + '    MIX_TIPOCP,                       ';
  Result := Result + '    MIX_TIPOSP                        ';
 //---------------------------------------------------------------
  Result := Result + '    )                                 ';

  Result := Result + '  VALUES  (                           ';

  Result := Result + '    :CODIGO,                          ';
  Result := Result + '    :DESCRI,                          ';
  Result := Result + '    :REFERE,                          ';
  Result := Result + '    :MONTAD,                          ';
  Result := Result + '    :A_N_O_,                          ';
  Result := Result + '    :UNIVER,                          ';
  Result := Result + '    :MD5KEY,                          ';
  Result := Result + '    :CODITE,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :CODDIL,                          ';
  Result := Result + '    :PORDIL,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PRECLT,                          ';
  Result := Result + '    :PRECGL,                          ';
  Result := Result + '    :PRECLA,                          ';
  Result := Result + '    :PRECCP,                          ';
  Result := Result + '    :PRECSP,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PREDLT,                          ';
  Result := Result + '    :PREDGL,                          ';
  Result := Result + '    :PREDLA,                          ';
  Result := Result + '    :PREDCP,                          ';
  Result := Result + '    :PREDSP,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PCUCLT,                          ';
  Result := Result + '    :PCUCGL,                          ';
  Result := Result + '    :PCUCLA,                          ';
  Result := Result + '    :PCUCCP,                          ';
  Result := Result + '    :PCUCSP,                          ';
  Result := Result + '    :PCUDLT,                          ';
  Result := Result + '    :PCUDGL,                          ';
  Result := Result + '    :PCUDLA,                          ';
  Result := Result + '    :PCUDCP,                          ';
  Result := Result + '    :PCUDSP,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PRCLT1,                          ';
  Result := Result + '    :PRCLT2,                          ';
  Result := Result + '    :PRCLT3,                          ';
  Result := Result + '    :PRCLT4,                          ';
  Result := Result + '    :PRCLT5,                          ';
  Result := Result + '    :PRCLT6,                          ';
  Result := Result + '    :PRCLT7,                          ';
  Result := Result + '    :PRDLT1,                          ';
  Result := Result + '    :PRDLT2,                          ';
  Result := Result + '    :PRDLT3,                          ';
  Result := Result + '    :PRDLT4,                          ';
  Result := Result + '    :PRDLT5,                          ';
  Result := Result + '    :PRDLT6,                          ';
  Result := Result + '    :PRDLT7,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PRCGL1,                          ';
  Result := Result + '    :PRCGL2,                          ';
  Result := Result + '    :PRCGL3,                          ';
  Result := Result + '    :PRCGL4,                          ';
  Result := Result + '    :PRCGL5,                          ';
  Result := Result + '    :PRCGL6,                          ';
  Result := Result + '    :PRCGL7,                          ';
  Result := Result + '    :PRDGL1,                          ';
  Result := Result + '    :PRDGL2,                          ';
  Result := Result + '    :PRDGL3,                          ';
  Result := Result + '    :PRDGL4,                          ';
  Result := Result + '    :PRDGL5,                          ';
  Result := Result + '    :PRDGL6,                          ';
  Result := Result + '    :PRDGL7,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PRCLA1,                          ';
  Result := Result + '    :PRCLA2,                          ';
  Result := Result + '    :PRCLA3,                          ';
  Result := Result + '    :PRCLA4,                          ';
  Result := Result + '    :PRCLA5,                          ';
  Result := Result + '    :PRCLA6,                          ';
  Result := Result + '    :PRCLA7,                          ';
  Result := Result + '    :PRDLA1,                          ';
  Result := Result + '    :PRDLA2,                          ';
  Result := Result + '    :PRDLA3,                          ';
  Result := Result + '    :PRDLA4,                          ';
  Result := Result + '    :PRDLA5,                          ';
  Result := Result + '    :PRDLA6,                          ';
  Result := Result + '    :PRDLA7,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PRCCP1,                          ';
  Result := Result + '    :PRCCP2,                          ';
  Result := Result + '    :PRCCP3,                          ';
  Result := Result + '    :PRCCP4,                          ';
  Result := Result + '    :PRCCP5,                          ';
  Result := Result + '    :PRCCP6,                          ';
  Result := Result + '    :PRCCP7,                          ';
  Result := Result + '    :PRDCP1,                          ';
  Result := Result + '    :PRDCP2,                          ';
  Result := Result + '    :PRDCP3,                          ';
  Result := Result + '    :PRDCP4,                          ';
  Result := Result + '    :PRDCP5,                          ';
  Result := Result + '    :PRDCP6,                          ';
  Result := Result + '    :PRDCP7,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PRCSP1,                          ';
  Result := Result + '    :PRCSP2,                          ';
  Result := Result + '    :PRCSP3,                          ';
  Result := Result + '    :PRCSP4,                          ';
  Result := Result + '    :PRCSP5,                          ';
  Result := Result + '    :PRCSP6,                          ';
  Result := Result + '    :PRCSP7,                          ';
  Result := Result + '    :PRDSP1,                          ';
  Result := Result + '    :PRDSP2,                          ';
  Result := Result + '    :PRDSP3,                          ';
  Result := Result + '    :PRDSP4,                          ';
  Result := Result + '    :PRDSP5,                          ';
  Result := Result + '    :PRDSP6,                          ';
  Result := Result + '    :PRDSP7,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :EMBALT,                          ';
  Result := Result + '    :EMBAGL,                          ';
  Result := Result + '    :EMBALA,                          ';
  Result := Result + '    :EMBACP,                          ';
  Result := Result + '    :EMBASP,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :VOLULT,                          ';
  Result := Result + '    :VOLUGL,                          ';
  Result := Result + '    :VOLULA,                          ';
  Result := Result + '    :VOLUCP,                          ';
  Result := Result + '    :VOLUSP,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :PREELT,                          ';
  Result := Result + '    :PREEGL,                          ';
  Result := Result + '    :PREELA,                          ';
  Result := Result + '    :PREECP,                          ';
  Result := Result + '    :PREESP,                          ';
 //---------------------------------------------------------------
  Result := Result + '    :TIPOLT,                          ';
  Result := Result + '    :TIPOGL,                          ';
  Result := Result + '    :TIPOLA,                          ';
  Result := Result + '    :TIPOCP,                          ';
  Result := Result + '    :TIPOSP                           ';
 //---------------------------------------------------------------
  Result := Result + '    );                                ';


end;

function TExportaTintometricosTerceirosLazzumix.fValorQuantidade(
  fltValor: Double; fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
  Begin
    Result := fltValor + fltAcrMob;
  End;
end;

procedure TExportaTintometricosTerceirosLazzumix.pAbrirCadBasesEmpresas;
begin
  qryBasEmp := fCriaQuery();
  qryBasEmp.Close;
  qryBasEmp.SQL.Clear;
  qryBasEmp.SQL.Add(fSelectBasesEmpresas);
  qryBasEmp.Open;
end;

procedure TExportaTintometricosTerceirosLazzumix.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODIGO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIX_CODIGO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIX_DESCRI').AsString);
  DataSet.ParamByName('REFERE').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIX_REFERE').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIX_MONTAD').AsString);
  DataSet.ParamByName('A_N_O_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIX_A_N_O_').AsString);
  DataSet.ParamByName('UNIVER').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('MIX_UNIVER').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('MIX_CODIGO').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProLaz;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
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
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
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
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('MIX_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('MIX_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosLazzumix.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryEmb: TUniQuery;
begin
  Try
    qryEmb := fCriaQuery(Nil, Conexao);
    qryEmb.Close;
    qryEmb.SQL.Clear;
    qryEmb.SQL.Add('  SELECT                      ');
    qryEmb.SQL.Add('    *                         ');
    qryEmb.SQL.Add('  FROM                        ');
    qryEmb.SQL.Add('    CFGTIN                    ');
    qryEmb.SQL.Add('  WHERE CFG_IDEPRO = "LAZ" AND    ');
    qryEmb.SQL.Add('    CFG_GRUCFG = "CONFIGURACOES" AND  ');
    qryEmb.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryEmb.Open;

    cdsEmbalagens := fCriaClientDatset(qryEmb, False, Nil, False);
  Finally
    FreeAndNil(qryEmb);
  End;
end;

procedure TExportaTintometricosTerceirosLazzumix.pGravaTintometricoPorTintaTerceiros(
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
  {$IFNDEF LINUX}
    SetLength(arrPrecosPorEmb, 0);
  {$ENDIF}
  End;
end;

procedure TExportaTintometricosTerceirosLazzumix.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryLog: TUniQuery;
begin
  Try
    qryLog := fCriaQuery(Nil, Conexao);

    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add('  DELETE FROM LOGTIN_SIT    ');
    qryLog.SQL.Add('    WHERE LOG_IDEPRO = "LAZ"    ');
    qryLog.ExecSQL;

    qryLog.Close;
    qryLog.SQL.Clear;
    qryLog.SQL.Add('  INSERT INTO LOGTIN_SIT  (     ');
    qryLog.SQL.Add('    LOG_IDEPRO,     ');
    qryLog.SQL.Add('    LOG_DTAEXE,     ');
    qryLog.SQL.Add('    LOG_HOREXE,     ');
    qryLog.SQL.Add('    LOG_EXECUT      ');
    qryLog.SQL.Add(' )  VALUES    (                 ' );
    qryLog.SQL.Add('    "LAZ", :DTAEXE, :HOREXE, :EXECUT ) ');

    qryLog.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryLog.ParamByName('HOREXE').AsDateTime := Time;
    qryLog.ParamByName('EXECUT').AsString   := strStatus;
    qryLog.ExecSQL;
  Finally
    FreeAndNil(qryLog);
  End;
end;

procedure TExportaTintometricosTerceirosLazzumix.pPreencheArrayEmbalagem;
begin
  SetLength(arrEmbalagens, 1);

  // Litro
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Litro';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LT';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.900;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Galão
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Galão';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'GL';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 3.600;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Lata
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Lata';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'LA';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.00;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Spray
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.100;
end;

procedure TExportaTintometricosTerceirosLazzumix.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosLazzumix.pProcessaTabelaCores(
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


      dicRetorno.Limpar;
      pPreencheDicRetorno(dicRetorno, qryGen, strTabUni, strTabPre);
      pRecalculaFormula(dicRetorno, qryGen, qryBases);
      pRetPrecoTintas(dicRetorno, qryColorantes, qryBases, fltPerAcr, qryGen);
      fltPreVen := IfNull(dicRetorno['preve'+dicRetorno['tabelaunica']], 0.0);
      pGravaTintometricoTabelasTerceiros(qryInsert, fltPreVen, qryGen, intContador);

      If ((qryGen.RecNo mod 100 = 0) Or (qryGen.RecNo = intMax)) And (Not FAutoma) Then
        Synchronize(pStep);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To Length(arrEmbalagens) - 1 Do
        Begin
          If qryGen.FieldByName('MIX_QTDC01').AsFloat > 0  Then
          Begin
            If arrPrecosPorEmb[intEmb].fltValCon > 0 Then
            Begin
              pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');
            End;
          End;

          If qryGen.FieldByName('MIX_QTDD01').AsFloat > 0 Then
          Begin
            If arrPrecosPorEmb[intEmb].fltValDil > 0 Then
            Begin
              pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                arrEmbalagens[intEmb].strNomEmb, 'D', arrEmbalagens[intEmb].strSigEmb,
                arrPrecosPorEmb[intEmb].fltValDil, dicPrecoAdicional, '_DIL');
            End;
          End;
        End;
      End;

      SetLength(arrPrecosPorEmb, 0);
    {$ENDIF}

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

procedure TExportaTintometricosTerceirosLazzumix.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
begin
  fltVOriCon := qryGen.FieldByName('MIX_VOLCON').AsFloat / 1000;
  fltVOriDil := qryGen.FieldByName('MIX_VOLCON').AsFloat / 1000;

  If qryGen.FieldByName('MIX_QTDD01').AsFloat <= 0 Then
    Exit; // Concentrado

  fltVOriDil := qryGen.FieldByName('MIX_VOLDIL').AsFloat / 1000;

  If (qryGen.FieldByName('MIX_QTDC01').AsFloat <= 0) And (qryGen.FieldByName('MIX_QTDD01').AsFloat > 0) Then
    fltVOriCon := qryGen.FieldByName('MIX_VOLDIL').AsFloat / 1000;
end;

procedure TExportaTintometricosTerceirosLazzumix.pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double; arrComponentes: Array Of TComp; intEmbalagem: Integer);
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
  fltPreCusPro,
  fltPreVenPro: Double;
  strCodCli, strCodCnd: String;
  intPrzMed: Integer;
  fltEmbala: Double;
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
  fltEmbala          := 1;


  strTabelaUnica := dicRetorno['tabelaunica'];
  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));

  strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmbalagem].strSigEmb, dicRetorno);
  strEmb := arrEmbalagens[intEmbalagem].strSigEmb;

  If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
    Exit;

  If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
    Exit;

  For intPreVen := 1 To 7 Do
  Begin
    fltPrecoVendaTotalCon := 0;
    fltPrecoVendaTotalDil := 0;

    If stlTabPre[intPreVen] <> 'S' Then
      Continue;

    For intContador := 1 To Length(ArrComponentes) Do
    Begin
      If fEmptyStr(IfNull(ArrComponentes[intContador].Componente, '')) Then
        Break;

      If qryBasEmp.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
      Begin
        If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreVenPro
        Else
          fltPrecoBase := qryBasEmp.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;

        fltEmbala  := fRetEmbalagem(qryBasEmp);
      End
      Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
      Begin
        If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
          IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoBase := fltPreVenPro
        Else
          fltPrecoBase := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;

        fltEmbala  := fRetEmbalagem(qryBases);
      End;


      //Preco de venda concentrado
      fltQuantCon := ArrComponentes[intContador].Quantidade;
      fltPrecoVendaCon := fltQuantCon  * (fltPrecoBase / fltEmbala);
      fltPrecoVendaCon := fltPrecoVendaCon + (fltPerFre * fltPrecoVendaCon);
      fltPrecoVendaCon := fltPrecoVendaCon + (fltPerIpi * fltPrecoVendaCon);
      fltPrecoVendaCon := fltPrecoVendaCon + (fltPerRet * fltPrecoVendaCon);
      fltPrecoVendaCon := fltPrecoVendaCon + (fltPerAdc * fltPrecoVendaCon);
      fltPrecoVendaCon := fltPrecoVendaCon + (fltPerPer * fltPrecoVendaCon);
      fltPrecoVendaCon := fltPrecoVendaCon + (fltMarLuc * fltPrecoVendaCon);

      fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

      //Preco de venda diluido
      fltQuantDil := ArrComponentes[intContador].Quantiddil;
      fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala);
      fltPrecoVendaDil := fltPrecoVendaDil + (fltPerFre * fltPrecoVendaDil);
      fltPrecoVendaDil := fltPrecoVendaDil + (fltPerIpi * fltPrecoVendaDil);
      fltPrecoVendaDil := fltPrecoVendaDil + (fltPerRet * fltPrecoVendaDil);
      fltPrecoVendaDil := fltPrecoVendaDil + (fltPerAdc * fltPrecoVendaDil);
      fltPrecoVendaDil := fltPrecoVendaDil + (fltPerPer * fltPrecoVendaDil);
      fltPrecoVendaDil := fltPrecoVendaDil + (fltMarLuc * fltPrecoVendaDil);

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

  //Calcula preço de custo
  fltPrecoCustoTotalCon := 0;
  fltPrecoCustoTotalDil := 0;

  For intContador := 1 To Length(ArrComponentes) Do
  Begin
    If fEmptyStr(IfNull(ArrComponentes[intContador].Componente, '')) Then
      Break;

    If qryBasEmp.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
    Begin
      If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
        strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreCusPro
      Else
        fltPrecoBase := qryBasEmp.FieldByName('PRECUS').AsFloat;

      fltEmbala  := fRetEmbalagem(qryBasEmp);
    End
    Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
    Begin
      If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
        strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        fltPrecoBase := fltPreCusPro
      Else
        fltPrecoBase := qryBases.FieldByName('PRECUS').AsFloat;

      fltEmbala  := fRetEmbalagem(qryBases);
    End;

    //Preco de custo concentrado
    fltQuantCon := ArrComponentes[intContador].Quantidade;
    fltPrecoCustoCon := fltQuantCon  * (fltPrecoBase / fltEmbala);
    fltPrecoCustoCon := fltPrecoCustoCon + (fltPerFre * fltPrecoCustoCon);
    fltPrecoCustoCon := fltPrecoCustoCon + (fltPerIpi * fltPrecoCustoCon);
    fltPrecoCustoCon := fltPrecoCustoCon + (fltPerRet * fltPrecoCustoCon);
    fltPrecoCustoCon := fltPrecoCustoCon + (fltPerAdc * fltPrecoCustoCon);
    fltPrecoCustoCon := fltPrecoCustoCon + (fltPerPer * fltPrecoCustoCon);
    fltPrecoCustoCon := fltPrecoCustoCon + (fltMarLuc * fltPrecoCustoCon);
    fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

    //Preco de custo diluido
    fltQuantDil := ArrComponentes[intContador].Quantiddil;
    fltPrecoCustoDil := fltQuantDil * (fltPrecoBase / fltEmbala);
    fltPrecoCustoDil := fltPrecoCustoDil + (fltPerFre * fltPrecoCustoDil);
    fltPrecoCustoDil := fltPrecoCustoDil + (fltPerIpi * fltPrecoCustoDil);
    fltPrecoCustoDil := fltPrecoCustoDil + (fltPerRet * fltPrecoCustoDil);
    fltPrecoCustoDil := fltPrecoCustoDil + (fltPerAdc * fltPrecoCustoDil);
    fltPrecoCustoDil := fltPrecoCustoDil + (fltPerPer * fltPrecoCustoDil);
    fltPrecoCustoDil := fltPrecoCustoDil + (fltMarLuc * fltPrecoCustoDil);
    fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
  End;

  If IsInfinite(fltPrecoCustoTotalCon) Or IsNan(fltPrecoCustoTotalCon) Then
    fltPrecoCustoTotalCon := 0.0;

  If IsInfinite(fltPrecoCustoTotalDil) Or IsNan(fltPrecoCustoTotalDil) Then
    fltPrecoCustoTotalDil := 0.0;

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
end;

procedure TExportaTintometricosTerceirosLazzumix.pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double; qryGen: TUniQuery);
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
  fltEmbala          := 1;

  strTabelaUnica := dicRetorno['tabelaunica'];
  SetLength(arrPrecosPorEmb, Length(arrEmbalagens));
  dicPrecoAdicional.Limpar;

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
      SetLength(ArrComponentes, fQuantidadeFormulacao + 2);

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin

        If (fEmptyStr(IfNull(qryGen.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString, ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString, [])) Then
          Break;

        ArrComponentes[intContador].Componente  := qryGen.FieldByName('MIX_BASE' + fStrZero(intContador, 2)).AsString;
        ArrComponentes[intContador].Quantidade  := fFormataFloatLaz(IfNull(qryGen.FieldByName('MIX_QTDC' + fStrZero(intContador, 2)).AsFloat, 0.0) * arrEmbalagens[intEmb].fltVolume / fltVOriCon);
        ArrComponentes[intContador].Quantiddil  := fFormataFloatLaz(IfNull(qryGen.FieldByName('MIX_QTDD' + fStrZero(intContador, 2)).AsFloat, 0.0) * arrEmbalagens[intEmb].fltVolume / fltVOriDil);
      End;

      intContador := 1;

      //Calcula o preco de venda
       While Not fEmptyStr(ArrComponentes[intContador].Componente) Do
       Begin

         If fEmptyStr(IfNull(ArrComponentes[intContador].Componente, '')) Then
           Break;

          If qryBasEmp.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
          Begin
            If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString,
              strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBasEmp.FieldByName('ITE_PREVEN').AsFloat;

            fltEmbala  := fRetEmbalagem(qryBasEmp);
          End
          Else If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
          Begin
            If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
              strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
              fltPrecoBase := fltPreVenPro
            Else
              fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;

            fltEmbala  := fRetEmbalagem(qryBases);
          End;

          //Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;
          fltPrecoVendaCon := fltQuantCon  * (fltPrecoBase / fltEmbala);
          fltPrecoVendaCon := fltPrecoVendaCon + (fltPerFre * fltPrecoVendaCon);
          fltPrecoVendaCon := fltPrecoVendaCon + (fltPerIpi * fltPrecoVendaCon);
          fltPrecoVendaCon := fltPrecoVendaCon + (fltPerRet * fltPrecoVendaCon);
          fltPrecoVendaCon := fltPrecoVendaCon + (fltPerAdc * fltPrecoVendaCon);
          fltPrecoVendaCon := fltPrecoVendaCon + (fltPerPer * fltPrecoVendaCon);
          fltPrecoVendaCon := fltPrecoVendaCon + (fltMarLuc * fltPrecoVendaCon);

          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala);
          fltPrecoVendaDil := fltPrecoVendaDil + (fltPerFre * fltPrecoVendaDil);
          fltPrecoVendaDil := fltPrecoVendaDil + (fltPerIpi * fltPrecoVendaDil);
          fltPrecoVendaDil := fltPrecoVendaDil + (fltPerRet * fltPrecoVendaDil);
          fltPrecoVendaDil := fltPrecoVendaDil + (fltPerAdc * fltPrecoVendaDil);
          fltPrecoVendaDil := fltPrecoVendaDil + (fltPerPer * fltPrecoVendaDil);
          fltPrecoVendaDil := fltPrecoVendaDil + (fltMarLuc * fltPrecoVendaDil);

          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;

         Inc(intContador);
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
      arrPrecosPorEmb[intEmb].strCodDil := IIF(qryGen.FieldByName('MIX_QTDD01').AsFloat > 0, 'DILUIDO', '');
      arrPrecosPorEmb[intEmb].fltPorDil := 0.0;

      pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr, arrComponentes, intEmb);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosLazzumix.pRetTabelasVenda(
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

procedure TExportaTintometricosTerceirosLazzumix.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  strProLaz := fRetornaProdutoParaVenda(Conexao);
  fltPerFre := fRetornaPercentualFrete(Conexao);
  fltPerIpi := fRetornaPercentualIPI(Conexao);
  fltPerRet := fRetornaPercentualRetido(Conexao);
  fltPerAdc := fRetornaPercentualAdicionais(Conexao);
  fltPerPer := fRetornaPercentualPerda(Conexao);
  fltMarLuc := fRetornaMargemLucro(Conexao);
  pCriaClientEmbalagem(Conexao);
  pRetTabelasVenda(Conexao);
end;

end.

