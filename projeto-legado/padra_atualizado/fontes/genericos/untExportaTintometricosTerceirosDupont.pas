unit untExportaTintometricosTerceirosDupont;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples, Windows, Messages,
  cxProgressBar, UniClientDataSet,
  FireDAC.VCLUI.Wait, untConexaoThread,
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
  TExportaTintometricosTerceirosDupont = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProDup: String;
    Banco: TUniConnection;
    fltVolumeOri: Double;
    blnNaoDiluido: Boolean;
    blnCatalize: Boolean;
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

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery; fltPerAcr: Double); override;
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    // Produto
    function fRetProdutoVenda(dicRetorno: TDicionario): String;
    function fLinProdutoVenda(strTipCor: String): String;

    // Embalagens
    function fRetEmbalagemLT(strTipoCor: String): String;
    function fRetEmbalagemGL(strTipoCor: String): String;
    function fRetEmbalagemLA(strTipoCor: String): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemBD(): String;
    function fRetEmbalagemTB(): String;
    function fRetEmbalagemSS(): String;
    function fRetEmbalagemSD(): String;
    function fRetEmbalagemPO(): String;
    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;

    procedure Execute; override;

    constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String;
      blnAuto: Boolean = False); Override;

    destructor Destroy; Override;

  End;

implementation

{ TExportaTintometricosTerceirosDupont }

constructor TExportaTintometricosTerceirosDupont.Create
  (pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
{$IFDEF LINUX}
  objConnectionsManager.BeginConnection();
  Banco := objConnectionsManager.CurrentConnection.GetObject as TUniConnection;
{$ELSE}
  Banco := VS_objConexaoThread.GetConexao;
{$ENDIF}
  strProDup := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosDupont.Destroy;
begin
  inherited;

{$IFDEF LINUX}
  FreeAndNil(Banco);
{$ELSE}
  VS_objConexaoThread.RemoveConnection(GetCurrentThreadId);
{$ENDIF}

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosDupont.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosDupont.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                                  ';
  Result := Result + '    DUP_CODDUP,                           ';
  Result := Result + '    DUP_CODOEM,                           ';
  Result := Result + '    DUP_LINHA_,                           ';
  Result := Result + '    DUP_QUALID,                           ';
  Result := Result + '    DUP_ALTERN,                           ';
  Result := Result + '    DUP_REGIAO,                           ';
  Result := Result + '    DUP_DESCRI,                           ';
  Result := Result + '    DUP_MONTAD,                           ';
  Result := Result + '    DUP_ANOCOR,                           ';
  Result := Result + '    DUP_LITRAG,                           ';
  Result := Result + '    DUP_CATALI,                           ';
  Result := Result + '    DUP_OBSERV,                           ';
  Result := Result + '    DUP_ACRMOB,                           ';

  For intContador := 1 To 20 Do
  Begin
    Result := Result + '    DUP_BASE' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    DUP_QTDC' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    DUP_QTDD' + fStrZero(intContador, 2) + ', ';
    Result := Result + '    DUP_TIPB' + fStrZero(intContador, 2) + ', ';
  End;

  Result := Result + '    DUP_MD5KEY                            ';
  Result := Result + '  FROM                                    ';
  Result := Result + '    DUP_CADDUP                            ';
  Result := Result + '  WHERE TRUE                              ';
end;

function TExportaTintometricosTerceirosDupont.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  ' + fNomeTabela() + '   (             ';
  Result := Result + '    DUP_CODDUP VARCHAR(15) DEFAULT NULL,              ';
  Result := Result + '    DUP_CODOEM VARCHAR(30) DEFAULT NULL,              ';
  Result := Result + '    DUP_LINHA_ VARCHAR(7) DEFAULT NULL,               ';
  Result := Result + '    DUP_QUALID CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_ALTERN CHAR(3) DEFAULT NULL,                  ';
  Result := Result + '    DUP_REGIAO CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_DESCRI VARCHAR(40) DEFAULT NULL,              ';
  Result := Result + '    DUP_MONTAD VARCHAR(20) DEFAULT NULL,              ';
  Result := Result + '    DUP_ANOCOR VARCHAR(4) DEFAULT NULL,               ';
  Result := Result + '    DUP_LITRAG DECIMAL(12,2) DEFAULT 0.00,            ';
  Result := Result + '    DUP_CATALI TEXT DEFAULT NULL,                     ';
  Result := Result + '    DUP_OBSERV VARCHAR(255) DEFAULT NULL,             ';
  Result := Result + '    DUP_MD5KEY VARCHAR(32) DEFAULT NULL,              ';

  Result := Result + '    DUP_CODITE VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_CODDIL VARCHAR(20) DEFAULT NULL,              ';
  Result := Result + '    DUP_PORDIL DECIMAL(12, 4) DEFAULT 0.0000,         ';

  Result := Result + '    DUP_PRECLT DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECGL DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECLA DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECCP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECSP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECBD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECTB DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECSD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PRECPO DECIMAL(12, 4) DEFAULT 0.0000,         ';

  Result := Result + '    DUP_PREDLT DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDGL DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDLA DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDCP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDSP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDBD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDTB DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDSD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREDPO DECIMAL(12, 4) DEFAULT 0.0000,         ';

  Result := Result + '    DUP_PCATLT DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Litro
  Result := Result + '    DUP_PCATGL DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Galão
  Result := Result + '    DUP_PCATLA DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Lata
  Result := Result + '    DUP_PCATCP DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Copo
  Result := Result + '    DUP_PCATSP DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Spray
  Result := Result + '    DUP_PCATBD DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Balde
  Result := Result + '    DUP_PCATTB DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Tambor
  Result := Result + '    DUP_PCATSD DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Spray Duco
  Result := Result + '    DUP_PCATPO DECIMAL(12, 4) DEFAULT 0.0000,         ';  // Preço com Catalisador - Spray Poliester

  Result := Result + '    DUP_PCUCLT DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Litro
  Result := Result + '    DUP_PCUCGL DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Galão
  Result := Result + '    DUP_PCUCLA DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Lata
  Result := Result + '    DUP_PCUCCP DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Copo
  Result := Result + '    DUP_PCUCSP DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Spray Sintetico
  Result := Result + '    DUP_PCUCBD DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Balde
  Result := Result + '    DUP_PCUCTB DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Tambor
  Result := Result + '    DUP_PCUCSD DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Spray Duco
  Result := Result + '    DUP_PCUCPO DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Concentrado Spray Poliester

  Result := Result + '    DUP_PCUDLT DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Litro
  Result := Result + '    DUP_PCUDGL DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Galão
  Result := Result + '    DUP_PCUDLA DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Lata
  Result := Result + '    DUP_PCUDCP DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Copo
  Result := Result + '    DUP_PCUDSP DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Spray Sintetico
  Result := Result + '    DUP_PCUDBD DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Balde
  Result := Result + '    DUP_PCUDTB DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Tambor
  Result := Result + '    DUP_PCUDSD DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Spray Duco
  Result := Result + '    DUP_PCUDPO DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Diluido Spray Poliester

  Result := Result + '    DUP_PCCALT DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Litro
  Result := Result + '    DUP_PCCAGL DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Galão
  Result := Result + '    DUP_PCCALA DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Lata
  Result := Result + '    DUP_PCCACP DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Copo
  Result := Result + '    DUP_PCCASP DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Spray Sintetico
  Result := Result + '    DUP_PCCABD DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Balde
  Result := Result + '    DUP_PCCATB DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Tambor
  Result := Result + '    DUP_PCCASD DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Spray Duco
  Result := Result + '    DUP_PCCAPO DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Custo - Com Catalisador - Diluido Spray Poliester

  Result := Result + '    DUP_PRCLT1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Litro Concentrado
  Result := Result + '    DUP_PRCLT2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Litro Concentrado
  Result := Result + '    DUP_PRCLT3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Litro Concentrado
  Result := Result + '    DUP_PRCLT4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Litro Concentrado
  Result := Result + '    DUP_PRCLT5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Litro Concentrado
  Result := Result + '    DUP_PRCLT6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Litro Concentrado
  Result := Result + '    DUP_PRCLT7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Litro Concentrado

  Result := Result + '    DUP_PRDLT1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Litro Diluido
  Result := Result + '    DUP_PRDLT2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Litro Diluido
  Result := Result + '    DUP_PRDLT3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Litro Diluido
  Result := Result + '    DUP_PRDLT4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Litro Diluido
  Result := Result + '    DUP_PRDLT5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Litro Diluido
  Result := Result + '    DUP_PRDLT6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Litro Diluido
  Result := Result + '    DUP_PRDLT7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Litro Diluido

  Result := Result + '    DUP_PCALT1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Litro Diluido
  Result := Result + '    DUP_PCALT2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Litro Diluido
  Result := Result + '    DUP_PCALT3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Litro Diluido
  Result := Result + '    DUP_PCALT4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Litro Diluido
  Result := Result + '    DUP_PCALT5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Litro Diluido
  Result := Result + '    DUP_PCALT6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Litro Diluido
  Result := Result + '    DUP_PCALT7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Litro Diluido

  Result := Result + '    DUP_PRCGL1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Galão Concentrado
  Result := Result + '    DUP_PRCGL2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Galão Concentrado
  Result := Result + '    DUP_PRCGL3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Galão Concentrado
  Result := Result + '    DUP_PRCGL4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Galão Concentrado
  Result := Result + '    DUP_PRCGL5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Galão Concentrado
  Result := Result + '    DUP_PRCGL6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Galão Concentrado
  Result := Result + '    DUP_PRCGL7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Galão Concentrado

  Result := Result + '    DUP_PRDGL1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Galão Diluido
  Result := Result + '    DUP_PRDGL2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Galão Diluido
  Result := Result + '    DUP_PRDGL3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Galão Diluido
  Result := Result + '    DUP_PRDGL4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Galão Diluido
  Result := Result + '    DUP_PRDGL5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Galão Diluido
  Result := Result + '    DUP_PRDGL6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Galão Diluido
  Result := Result + '    DUP_PRDGL7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Galão Diluido

  Result := Result + '    DUP_PCAGL1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Galão Diluido
  Result := Result + '    DUP_PCAGL2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Galão Diluido
  Result := Result + '    DUP_PCAGL3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Galão Diluido
  Result := Result + '    DUP_PCAGL4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Galão Diluido
  Result := Result + '    DUP_PCAGL5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Galão Diluido
  Result := Result + '    DUP_PCAGL6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Galão Diluido
  Result := Result + '    DUP_PCAGL7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Galão Diluido

  Result := Result + '    DUP_PRCLA1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Lata Concentrado
  Result := Result + '    DUP_PRCLA2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Lata Concentrado
  Result := Result + '    DUP_PRCLA3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Lata Concentrado
  Result := Result + '    DUP_PRCLA4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Lata Concentrado
  Result := Result + '    DUP_PRCLA5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Lata Concentrado
  Result := Result + '    DUP_PRCLA6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Lata Concentrado
  Result := Result + '    DUP_PRCLA7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Lata Concentrado

  Result := Result + '    DUP_PRDLA1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Lata Diluido
  Result := Result + '    DUP_PRDLA2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Lata Diluido
  Result := Result + '    DUP_PRDLA3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Lata Diluido
  Result := Result + '    DUP_PRDLA4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Lata Diluido
  Result := Result + '    DUP_PRDLA5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Lata Diluido
  Result := Result + '    DUP_PRDLA6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Lata Diluido
  Result := Result + '    DUP_PRDLA7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Lata Diluido

  Result := Result + '    DUP_PCALA1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Lata Diluido
  Result := Result + '    DUP_PCALA2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Lata Diluido
  Result := Result + '    DUP_PCALA3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Lata Diluido
  Result := Result + '    DUP_PCALA4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Lata Diluido
  Result := Result + '    DUP_PCALA5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Lata Diluido
  Result := Result + '    DUP_PCALA6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Lata Diluido
  Result := Result + '    DUP_PCALA7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Lata Diluido

  Result := Result + '    DUP_PRCCP1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Copo Concentrado
  Result := Result + '    DUP_PRCCP2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Copo Concentrado
  Result := Result + '    DUP_PRCCP3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Copo Concentrado
  Result := Result + '    DUP_PRCCP4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Copo Concentrado
  Result := Result + '    DUP_PRCCP5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Copo Concentrado
  Result := Result + '    DUP_PRCCP6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Copo Concentrado
  Result := Result + '    DUP_PRCCP7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Copo Concentrado

  Result := Result + '    DUP_PRDCP1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Copo Diluido
  Result := Result + '    DUP_PRDCP2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Copo Diluido
  Result := Result + '    DUP_PRDCP3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Copo Diluido
  Result := Result + '    DUP_PRDCP4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Copo Diluido
  Result := Result + '    DUP_PRDCP5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Copo Diluido
  Result := Result + '    DUP_PRDCP6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Copo Diluido
  Result := Result + '    DUP_PRDCP7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Copo Diluido

  Result := Result + '    DUP_PCACP1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Copo Diluido
  Result := Result + '    DUP_PCACP2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Copo Diluido
  Result := Result + '    DUP_PCACP3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Copo Diluido
  Result := Result + '    DUP_PCACP4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Copo Diluido
  Result := Result + '    DUP_PCACP5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Copo Diluido
  Result := Result + '    DUP_PCACP6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Copo Diluido
  Result := Result + '    DUP_PCACP7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Copo Diluido

  Result := Result + '    DUP_PRCSP1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Spray Sintetico Concentrado
  Result := Result + '    DUP_PRCSP2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Spray Sintetico Concentrado
  Result := Result + '    DUP_PRCSP3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Spray Sintetico Concentrado
  Result := Result + '    DUP_PRCSP4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Spray Sintetico Concentrado
  Result := Result + '    DUP_PRCSP5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Spray Sintetico Concentrado
  Result := Result + '    DUP_PRCSP6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Spray Sintetico Concentrado
  Result := Result + '    DUP_PRCSP7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Spray Sintetico Concentrado

  Result := Result + '    DUP_PRDSP1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Spray Sintetico Diluido
  Result := Result + '    DUP_PRDSP2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Spray Sintetico Diluido
  Result := Result + '    DUP_PRDSP3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Spray Sintetico Diluido
  Result := Result + '    DUP_PRDSP4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Spray Sintetico Diluido
  Result := Result + '    DUP_PRDSP5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Spray Sintetico Diluido
  Result := Result + '    DUP_PRDSP6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Spray Sintetico Diluido
  Result := Result + '    DUP_PRDSP7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Spray Sintetico Diluido

  Result := Result + '    DUP_PCASP1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Spray Sintetico Diluido
  Result := Result + '    DUP_PCASP2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Spray Sintetico Diluido
  Result := Result + '    DUP_PCASP3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Spray Sintetico Diluido
  Result := Result + '    DUP_PCASP4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Spray Sintetico Diluido
  Result := Result + '    DUP_PCASP5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Spray Sintetico Diluido
  Result := Result + '    DUP_PCASP6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Spray Sintetico Diluido
  Result := Result + '    DUP_PCASP7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Spray Sintetico Diluido

  Result := Result + '    DUP_PRCBD1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Balde Concentrado
  Result := Result + '    DUP_PRCBD2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Balde Concentrado
  Result := Result + '    DUP_PRCBD3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Balde Concentrado
  Result := Result + '    DUP_PRCBD4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Balde Concentrado
  Result := Result + '    DUP_PRCBD5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Balde Concentrado
  Result := Result + '    DUP_PRCBD6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Balde Concentrado
  Result := Result + '    DUP_PRCBD7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Balde Concentrado

  Result := Result + '    DUP_PRDBD1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Balde Diluido
  Result := Result + '    DUP_PRDBD2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Balde Diluido
  Result := Result + '    DUP_PRDBD3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Balde Diluido
  Result := Result + '    DUP_PRDBD4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Balde Diluido
  Result := Result + '    DUP_PRDBD5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Balde Diluido
  Result := Result + '    DUP_PRDBD6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Balde Diluido
  Result := Result + '    DUP_PRDBD7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Balde Diluido

  Result := Result + '    DUP_PCABD1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Balde Diluido
  Result := Result + '    DUP_PCABD2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Balde Diluido
  Result := Result + '    DUP_PCABD3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Balde Diluido
  Result := Result + '    DUP_PCABD4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Balde Diluido
  Result := Result + '    DUP_PCABD5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Balde Diluido
  Result := Result + '    DUP_PCABD6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Balde Diluido
  Result := Result + '    DUP_PCABD7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Balde Diluido

  Result := Result + '    DUP_PRCTB1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Tambor Concentrado
  Result := Result + '    DUP_PRCTB2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Tambor Concentrado
  Result := Result + '    DUP_PRCTB3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Tambor Concentrado
  Result := Result + '    DUP_PRCTB4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Tambor Concentrado
  Result := Result + '    DUP_PRCTB5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Tambor Concentrado
  Result := Result + '    DUP_PRCTB6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Tambor Concentrado
  Result := Result + '    DUP_PRCTB7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Tambor Concentrado

  Result := Result + '    DUP_PRDTB1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Tambor Diluido
  Result := Result + '    DUP_PRDTB2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Tambor Diluido
  Result := Result + '    DUP_PRDTB3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Tambor Diluido
  Result := Result + '    DUP_PRDTB4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Tambor Diluido
  Result := Result + '    DUP_PRDTB5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Tambor Diluido
  Result := Result + '    DUP_PRDTB6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Tambor Diluido
  Result := Result + '    DUP_PRDTB7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Tambor Diluido

  Result := Result + '    DUP_PCATB1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Tambor Diluido
  Result := Result + '    DUP_PCATB2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Tambor Diluido
  Result := Result + '    DUP_PCATB3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Tambor Diluido
  Result := Result + '    DUP_PCATB4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Tambor Diluido
  Result := Result + '    DUP_PCATB5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Tambor Diluido
  Result := Result + '    DUP_PCATB6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Tambor Diluido
  Result := Result + '    DUP_PCATB7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Tambor Diluido

  Result := Result + '    DUP_PRCSD1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Spray Duco Concentrado
  Result := Result + '    DUP_PRCSD2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Spray Duco Concentrado
  Result := Result + '    DUP_PRCSD3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Spray Duco Concentrado
  Result := Result + '    DUP_PRCSD4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Spray Duco Concentrado
  Result := Result + '    DUP_PRCSD5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Spray Duco Concentrado
  Result := Result + '    DUP_PRCSD6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Spray Duco Concentrado
  Result := Result + '    DUP_PRCSD7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Spray Duco Concentrado

  Result := Result + '    DUP_PRDSD1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Spray Duco Diluido
  Result := Result + '    DUP_PRDSD2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Spray Duco Diluido
  Result := Result + '    DUP_PRDSD3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Spray Duco Diluido
  Result := Result + '    DUP_PRDSD4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Spray Duco Diluido
  Result := Result + '    DUP_PRDSD5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Spray Duco Diluido
  Result := Result + '    DUP_PRDSD6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Spray Duco Diluido
  Result := Result + '    DUP_PRDSD7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Spray Duco Diluido

  Result := Result + '    DUP_PCASD1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Spray Duco Diluido
  Result := Result + '    DUP_PCASD2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Spray Duco Diluido
  Result := Result + '    DUP_PCASD3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Spray Duco Diluido
  Result := Result + '    DUP_PCASD4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Spray Duco Diluido
  Result := Result + '    DUP_PCASD5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Spray Duco Diluido
  Result := Result + '    DUP_PCASD6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Spray Duco Diluido
  Result := Result + '    DUP_PCASD7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Spray Duco Diluido

  Result := Result + '    DUP_PRCPO1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Spray Poliester Concentrado
  Result := Result + '    DUP_PRCPO2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Spray Poliester Concentrado
  Result := Result + '    DUP_PRCPO3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Spray Poliester Concentrado
  Result := Result + '    DUP_PRCPO4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Spray Poliester Concentrado
  Result := Result + '    DUP_PRCPO5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Spray Poliester Concentrado
  Result := Result + '    DUP_PRCPO6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Spray Poliester Concentrado
  Result := Result + '    DUP_PRCPO7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Spray Poliester Concentrado

  Result := Result + '    DUP_PRDPO1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 - Spray Poliester Diluido
  Result := Result + '    DUP_PRDPO2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 - Spray Poliester Diluido
  Result := Result + '    DUP_PRDPO3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 - Spray Poliester Diluido
  Result := Result + '    DUP_PRDPO4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 - Spray Poliester Diluido
  Result := Result + '    DUP_PRDPO5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 - Spray Poliester Diluido
  Result := Result + '    DUP_PRDPO6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 - Spray Poliester Diluido
  Result := Result + '    DUP_PRDPO7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 - Spray Poliester Diluido

  Result := Result + '    DUP_PCAPO1 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE1 Com Catalisador - Spray Poliester Diluido
  Result := Result + '    DUP_PCAPO2 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE2 Com Catalisador - Spray Poliester Diluido
  Result := Result + '    DUP_PCAPO3 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE3 Com Catalisador - Spray Poliester Diluido
  Result := Result + '    DUP_PCAPO4 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE4 Com Catalisador - Spray Poliester Diluido
  Result := Result + '    DUP_PCAPO5 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE5 Com Catalisador - Spray Poliester Diluido
  Result := Result + '    DUP_PCAPO6 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE6 Com Catalisador - Spray Poliester Diluido
  Result := Result + '    DUP_PCAPO7 DECIMAL(12, 4) DEFAULT 0.0000,         '; // Preço de Venda PREVE7 Com Catalisador - Spray Poliester Diluido

  Result := Result + '    DUP_EMBALT VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBAGL VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBALA VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBACP VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBASP VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBABD VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBATB VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBASD VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';
  Result := Result + '    DUP_EMBAPO VARCHAR(' + fTamCodIte.ToString() + ') DEFAULT NULL,               ';

  Result := Result + '    DUP_VOLULT DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUGL DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLULA DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUCP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUSP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUBD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUTB DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUSD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_VOLUPO DECIMAL(12, 4) DEFAULT 0.0000,         ';

  Result := Result + '    DUP_PREELT DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREEGL DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREELA DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREECP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREESP DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREEBD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREETB DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREESD DECIMAL(12, 4) DEFAULT 0.0000,         ';
  Result := Result + '    DUP_PREEPO DECIMAL(12, 4) DEFAULT 0.0000,         ';

  Result := Result + '    DUP_TIPOLT CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOGL CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOLA CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOCP CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOSP CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOBD CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOTB CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOSD CHAR(2) DEFAULT NULL,                  ';
  Result := Result + '    DUP_TIPOPO CHAR(2) DEFAULT NULL                   ';
  Result := Result + '                );                                    ';

end;

function TExportaTintometricosTerceirosDupont.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosDupont.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosDupont.fLinProdutoVenda
  (strTipCor: String): String;
begin
  Result := '';

  If Pos('DUXONE', strTipCor) > 0 Then
    Result := 'PRODUX'
  Else If Pos('NASON', strTipCor) > 0 Then
    Result := 'PRONAS'
  Else If Pos('CHROMA', strTipCor) > 0 Then
    Result := 'PROCHR'
  Else If Pos('IMRON', strTipCor) > 0 Then
    Result := 'PROIRO'
  Else If Pos('CORMAX', strTipCor) > 0 Then
    Result := 'PROCOR';
end;

function TExportaTintometricosTerceirosDupont.fNomeTabela: String;
begin
  Result := 'DUP_CADDUP_SIT';
end;

function TExportaTintometricosTerceirosDupont.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosDupont.fRetDescricao: String;
begin
  Result := 'DUP_DESCRI';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagem
  (qryColorantes: TUniQuery): Double;
begin
  Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat;
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemBD: String;
begin
  Result := 'ITEBAL';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemCP: String;
begin
  Result := 'ITECOP';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemGL
  (strTipoCor: String): String;
begin
  Result := '';

  If Pos('DUXONE', strTipoCor) > 0 Then
    Result := 'ITEGAL'
  Else If Pos('NASON', strTipoCor) > 0 Then
    Result := 'NASOGL'
  Else If Pos('CHROMA', strTipoCor) > 0 Then
    Result := 'CHROGL'
  Else If Pos('IMRON', strTipoCor) > 0 Then
    Result := 'IMROGL'
  Else If Pos('CORMAX', strTipoCor) > 0 Then
    Result := 'CORMGL';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemLA
  (strTipoCor: String): String;
begin
  Result := '';

  If Pos('DUXONE', strTipoCor) > 0 Then
    Result := 'ITELAT'
  Else If Pos('NASON', strTipoCor) > 0 Then
    Result := 'NASOLA'
  Else If Pos('CHROMA', strTipoCor) > 0 Then
    Result := 'CHROLA'
  Else If Pos('IMRON', strTipoCor) > 0 Then
    Result := 'IMROLA'
  Else If Pos('CORMAX', strTipoCor) > 0 Then
    Result := 'CORMLA';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemLT
  (strTipoCor: String): String;
begin
  Result := '';

  If Pos('DUXONE', strTipoCor) > 0 Then
    Result := 'ITE1_4'
  Else If Pos('NASON', strTipoCor) > 0 Then
    Result := 'NASOLT'
  Else If Pos('CHROMA', strTipoCor) > 0 Then
    Result := 'CHROLT'
  Else If Pos('IMRON', strTipoCor) > 0 Then
    Result := 'IMROLT'
  Else If Pos('CORMAX', strTipoCor) > 0 Then
    Result := 'CORMLT';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemPO: String;
begin
  Result := 'ITESPO';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemSD: String;
begin
  Result := 'ITESDU';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemSS: String;
begin
  Result := 'ITESPS';
end;

function TExportaTintometricosTerceirosDupont.fRetEmbalagemTB: String;
begin
  Result := 'ITETAM';
end;

function TExportaTintometricosTerceirosDupont.fRetFormula
  (intCont: Integer): String;
begin
  Result := 'DUP_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosDupont.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosDupont.fRetMD5KEY: String;
begin
  Result := 'DUP_MD5KEY';
end;

function TExportaTintometricosTerceirosDupont.fRetornaBases: String;
begin
  Result := '';
  Result := Result +  '  SELECT                                                  ';
  Result := Result +  '    BAS_CODITE,                                           ';
  Result := Result +  '    BAS_CODBAS,                                           ';
  Result := Result +  '    BAS_EMBALA,                                           ';
  Result := Result +  '    BAS_PESESP,                                           ';
  Result := Result +  '    BAS_PESGRA,                                           ';
  Result := Result +  '    ITE_PREVE' + fRetornaTabelaPreco +' AS ITE_PREVEN,    ';
  Result := Result +  '    G.ITE_PRECUS AS PRECUS,            ';
  Result := Result +  '    G.ITE_PREVE1 AS PREVE1,            ';
  Result := Result +  '    G.ITE_PREVE2 AS PREVE2,            ';
  Result := Result +  '    G.ITE_PREVE3 AS PREVE3,            ';
  Result := Result +  '    G.ITE_PREVE4 AS PREVE4,            ';
  Result := Result +  '    G.ITE_PREVE5 AS PREVE5,            ';
  Result := Result +  '    G.ITE_PREVE6 AS PREVE6,            ';
  Result := Result +  '    G.ITE_PREVE7 AS PREVE7             ';
  Result := Result +  '  FROM                                                    ';
  Result := Result +  '    DUP_CADBAS B                                          ';
  Result := Result +  '    INNER JOIN CADITE I                                   ';
  Result := Result +  '      ON B.BAS_CODITE = I.ITE_CODITE                      ';
  Result := Result +  '    INNER JOIN ITEGER G                                   ';
  Result := Result +  '      ON I.ITE_CODITE = G.ITE_CODITE                      ';
  Result := Result +  '  WHERE                                                   ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) +  '        ';

end;

function TExportaTintometricosTerceirosDupont.fRetornaCampoEmbalagem
  (strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT(dicRetorno['tipcor'])
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL(dicRetorno['tipcor'])
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA(dicRetorno['tipcor'])
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SP' Then
    Result := fRetEmbalagemSS()
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD()
  Else If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB()
  Else If strSigEmb = 'SD' Then
    Result := fRetEmbalagemSD()
  Else If strSigEmb = 'PO' Then
    Result := fRetEmbalagemPO();
end;

function TExportaTintometricosTerceirosDupont.fRetornaCodigoDiluente
  (dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosDupont.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosDupont.fRetornaPercentualAcrescimo
  (Conexao: TUniConnection): Double;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT                                              ');
    qryGen.SQL.Add('    CFG_VALCFG                                        ');
    qryGen.SQL.Add('  FROM                                                ');
    qryGen.SQL.Add('    CFGTIN                                            ');
    qryGen.SQL.Add('  WHERE                                               ');
    qryGen.SQL.Add('    CFG_IDEPRO = "DUP"  AND                           ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND  ');
    qryGen.SQL.Add('    CFG_CODCFG = "APREVE"                             ');
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CFG_VALCFG').AsString) Then
      Result := 0
    Else
      Result := fStrToFloat(qryGen.FieldByName('CFG_VALCFG').AsString) / 100.0;


  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDupont.fRetornaPorcentagemDiluente
  (dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosDupont.fRetProdutoVenda
  (dicRetorno: TDicionario): String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Banco);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT                                  ');
    qryGen.SQL.Add('    CFG_VALCFG                            ');
    qryGen.SQL.Add('  FROM                                    ');
    qryGen.SQL.Add('    CFGTIN                                ');
    qryGen.SQL.Add('  WHERE                                   ');
    qryGen.SQL.Add('    CFG_IDEPRO = "DUP" AND                ');
    qryGen.SQL.Add('    CFG_GRUCFG = "CONFIGURACOES" AND      ');
    qryGen.SQL.Add('    CFG_CODCFG = ' +
      QuotedStr(fLinProdutoVenda(dicRetorno['tipcor'])) + ' AND   ');
    qryGen.SQL.Add('    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDupont.fRetQuantidade
  (intCont: Integer): String;
begin
  Result := 'DUP_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosDupont.fRetTipoCor: String;
begin
  Result := 'DUP_LINHA_';
end;

function TExportaTintometricosTerceirosDupont.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "DUP" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDupont.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() + ' (       ';
  Result := Result + '    DUP_CODDUP,                             ';
  Result := Result + '    DUP_CODOEM,                             ';
  Result := Result + '    DUP_LINHA_,                             ';
  Result := Result + '    DUP_QUALID,                             ';
  Result := Result + '    DUP_ALTERN,                             ';
  Result := Result + '    DUP_REGIAO,                             ';
  Result := Result + '    DUP_DESCRI,                             ';
  Result := Result + '    DUP_MONTAD,                             ';
  Result := Result + '    DUP_ANOCOR,                             ';
  Result := Result + '    DUP_LITRAG,                             ';
  Result := Result + '    DUP_CATALI,                             ';
  Result := Result + '    DUP_OBSERV,                             ';
  Result := Result + '    DUP_MD5KEY,                             ';

  Result := Result + '    DUP_CODITE,                             ';
  Result := Result + '    DUP_CODDIL,                             ';
  Result := Result + '    DUP_PORDIL,                             ';

  Result := Result + '    DUP_PRECLT,                             ';
  Result := Result + '    DUP_PRECGL,                             ';
  Result := Result + '    DUP_PRECLA,                             ';
  Result := Result + '    DUP_PRECCP,                             ';
  Result := Result + '    DUP_PRECSP,                             ';
  Result := Result + '    DUP_PRECBD,                             ';
  Result := Result + '    DUP_PRECTB,                             ';
  Result := Result + '    DUP_PRECSD,                             ';
  Result := Result + '    DUP_PRECPO,                             ';

  Result := Result + '    DUP_PREDLT,                             ';
  Result := Result + '    DUP_PREDGL,                             ';
  Result := Result + '    DUP_PREDLA,                             ';
  Result := Result + '    DUP_PREDCP,                             ';
  Result := Result + '    DUP_PREDSP,                             ';
  Result := Result + '    DUP_PREDBD,                             ';
  Result := Result + '    DUP_PREDTB,                             ';
  Result := Result + '    DUP_PREDSD,                             ';
  Result := Result + '    DUP_PREDPO,                             ';

  Result := Result + '    DUP_PCUCLT,                             ';
  Result := Result + '    DUP_PCUDLT,                             ';
  Result := Result + '    DUP_PCUCGL,                             ';
  Result := Result + '    DUP_PCUDGL,                             ';
  Result := Result + '    DUP_PCUCLA,                             ';
  Result := Result + '    DUP_PCUDLA,                             ';
  Result := Result + '    DUP_PCUCCP,                             ';
  Result := Result + '    DUP_PCUDCP,                             ';
  Result := Result + '    DUP_PCUCSP,                             ';
  Result := Result + '    DUP_PCUDSP,                             ';
  Result := Result + '    DUP_PCUCBD,                             ';
  Result := Result + '    DUP_PCUDBD,                             ';
  Result := Result + '    DUP_PCUCTB,                             ';
  Result := Result + '    DUP_PCUDTB,                             ';
  Result := Result + '    DUP_PCUCSD,                             ';
  Result := Result + '    DUP_PCUDSD,                             ';
  Result := Result + '    DUP_PCUCPO,                             ';
  Result := Result + '    DUP_PCUDPO,                             ';

  Result := Result + '    DUP_PRCLT1,                             ';
  Result := Result + '    DUP_PRCLT2,                             ';
  Result := Result + '    DUP_PRCLT3,                             ';
  Result := Result + '    DUP_PRCLT4,                             ';
  Result := Result + '    DUP_PRCLT5,                             ';
  Result := Result + '    DUP_PRCLT6,                             ';
  Result := Result + '    DUP_PRCLT7,                             ';

  Result := Result + '    DUP_PRDLT1,                             ';
  Result := Result + '    DUP_PRDLT2,                             ';
  Result := Result + '    DUP_PRDLT3,                             ';
  Result := Result + '    DUP_PRDLT4,                             ';
  Result := Result + '    DUP_PRDLT5,                             ';
  Result := Result + '    DUP_PRDLT6,                             ';
  Result := Result + '    DUP_PRDLT7,                             ';

  Result := Result + '    DUP_PRCGL1,                             ';
  Result := Result + '    DUP_PRCGL2,                             ';
  Result := Result + '    DUP_PRCGL3,                             ';
  Result := Result + '    DUP_PRCGL4,                             ';
  Result := Result + '    DUP_PRCGL5,                             ';
  Result := Result + '    DUP_PRCGL6,                             ';
  Result := Result + '    DUP_PRCGL7,                             ';

  Result := Result + '    DUP_PRDGL1,                             ';
  Result := Result + '    DUP_PRDGL2,                             ';
  Result := Result + '    DUP_PRDGL3,                             ';
  Result := Result + '    DUP_PRDGL4,                             ';
  Result := Result + '    DUP_PRDGL5,                             ';
  Result := Result + '    DUP_PRDGL6,                             ';
  Result := Result + '    DUP_PRDGL7,                             ';

  Result := Result + '    DUP_PRCLA1,                             ';
  Result := Result + '    DUP_PRCLA2,                             ';
  Result := Result + '    DUP_PRCLA3,                             ';
  Result := Result + '    DUP_PRCLA4,                             ';
  Result := Result + '    DUP_PRCLA5,                             ';
  Result := Result + '    DUP_PRCLA6,                             ';
  Result := Result + '    DUP_PRCLA7,                             ';

  Result := Result + '    DUP_PRDLA1,                             ';
  Result := Result + '    DUP_PRDLA2,                             ';
  Result := Result + '    DUP_PRDLA3,                             ';
  Result := Result + '    DUP_PRDLA4,                             ';
  Result := Result + '    DUP_PRDLA5,                             ';
  Result := Result + '    DUP_PRDLA6,                             ';
  Result := Result + '    DUP_PRDLA7,                             ';

  Result := Result + '    DUP_PRCCP1,                             ';
  Result := Result + '    DUP_PRCCP2,                             ';
  Result := Result + '    DUP_PRCCP3,                             ';
  Result := Result + '    DUP_PRCCP4,                             ';
  Result := Result + '    DUP_PRCCP5,                             ';
  Result := Result + '    DUP_PRCCP6,                             ';
  Result := Result + '    DUP_PRCCP7,                             ';

  Result := Result + '    DUP_PRDCP1,                             ';
  Result := Result + '    DUP_PRDCP2,                             ';
  Result := Result + '    DUP_PRDCP3,                             ';
  Result := Result + '    DUP_PRDCP4,                             ';
  Result := Result + '    DUP_PRDCP5,                             ';
  Result := Result + '    DUP_PRDCP6,                             ';
  Result := Result + '    DUP_PRDCP7,                             ';

  Result := Result + '    DUP_PRCSP1,                             ';
  Result := Result + '    DUP_PRCSP2,                             ';
  Result := Result + '    DUP_PRCSP3,                             ';
  Result := Result + '    DUP_PRCSP4,                             ';
  Result := Result + '    DUP_PRCSP5,                             ';
  Result := Result + '    DUP_PRCSP6,                             ';
  Result := Result + '    DUP_PRCSP7,                             ';

  Result := Result + '    DUP_PRDSP1,                             ';
  Result := Result + '    DUP_PRDSP2,                             ';
  Result := Result + '    DUP_PRDSP3,                             ';
  Result := Result + '    DUP_PRDSP4,                             ';
  Result := Result + '    DUP_PRDSP5,                             ';
  Result := Result + '    DUP_PRDSP6,                             ';
  Result := Result + '    DUP_PRDSP7,                             ';

  Result := Result + '    DUP_PRCBD1,                             ';
  Result := Result + '    DUP_PRCBD2,                             ';
  Result := Result + '    DUP_PRCBD3,                             ';
  Result := Result + '    DUP_PRCBD4,                             ';
  Result := Result + '    DUP_PRCBD5,                             ';
  Result := Result + '    DUP_PRCBD6,                             ';
  Result := Result + '    DUP_PRCBD7,                             ';

  Result := Result + '    DUP_PRDBD1,                             ';
  Result := Result + '    DUP_PRDBD2,                             ';
  Result := Result + '    DUP_PRDBD3,                             ';
  Result := Result + '    DUP_PRDBD4,                             ';
  Result := Result + '    DUP_PRDBD5,                             ';
  Result := Result + '    DUP_PRDBD6,                             ';
  Result := Result + '    DUP_PRDBD7,                             ';

  Result := Result + '    DUP_PRCTB1,                             ';
  Result := Result + '    DUP_PRCTB2,                             ';
  Result := Result + '    DUP_PRCTB3,                             ';
  Result := Result + '    DUP_PRCTB4,                             ';
  Result := Result + '    DUP_PRCTB5,                             ';
  Result := Result + '    DUP_PRCTB6,                             ';
  Result := Result + '    DUP_PRCTB7,                             ';

  Result := Result + '    DUP_PRDTB1,                             ';
  Result := Result + '    DUP_PRDTB2,                             ';
  Result := Result + '    DUP_PRDTB3,                             ';
  Result := Result + '    DUP_PRDTB4,                             ';
  Result := Result + '    DUP_PRDTB5,                             ';
  Result := Result + '    DUP_PRDTB6,                             ';
  Result := Result + '    DUP_PRDTB7,                             ';

  Result := Result + '    DUP_PRCSD1,                             ';
  Result := Result + '    DUP_PRCSD2,                             ';
  Result := Result + '    DUP_PRCSD3,                             ';
  Result := Result + '    DUP_PRCSD4,                             ';
  Result := Result + '    DUP_PRCSD5,                             ';
  Result := Result + '    DUP_PRCSD6,                             ';
  Result := Result + '    DUP_PRCSD7,                             ';

  Result := Result + '    DUP_PRDSD1,                             ';
  Result := Result + '    DUP_PRDSD2,                             ';
  Result := Result + '    DUP_PRDSD3,                             ';
  Result := Result + '    DUP_PRDSD4,                             ';
  Result := Result + '    DUP_PRDSD5,                             ';
  Result := Result + '    DUP_PRDSD6,                             ';
  Result := Result + '    DUP_PRDSD7,                             ';

  Result := Result + '    DUP_PRCPO1,                             ';
  Result := Result + '    DUP_PRCPO2,                             ';
  Result := Result + '    DUP_PRCPO3,                             ';
  Result := Result + '    DUP_PRCPO4,                             ';
  Result := Result + '    DUP_PRCPO5,                             ';
  Result := Result + '    DUP_PRCPO6,                             ';
  Result := Result + '    DUP_PRCPO7,                             ';

  Result := Result + '    DUP_PRDPO1,                             ';
  Result := Result + '    DUP_PRDPO2,                             ';
  Result := Result + '    DUP_PRDPO3,                             ';
  Result := Result + '    DUP_PRDPO4,                             ';
  Result := Result + '    DUP_PRDPO5,                             ';
  Result := Result + '    DUP_PRDPO6,                             ';
  Result := Result + '    DUP_PRDPO7,                             ';

  Result := Result + '    DUP_EMBALT,                             ';
  Result := Result + '    DUP_EMBAGL,                             ';
  Result := Result + '    DUP_EMBALA,                             ';
  Result := Result + '    DUP_EMBACP,                             ';
  Result := Result + '    DUP_EMBASP,                             ';
  Result := Result + '    DUP_EMBABD,                             ';
  Result := Result + '    DUP_EMBATB,                             ';
  Result := Result + '    DUP_EMBASD,                             ';
  Result := Result + '    DUP_EMBAPO,                             ';

  Result := Result + '    DUP_VOLULT,                             ';
  Result := Result + '    DUP_VOLUGL,                             ';
  Result := Result + '    DUP_VOLULA,                             ';
  Result := Result + '    DUP_VOLUCP,                             ';
  Result := Result + '    DUP_VOLUSP,                             ';
  Result := Result + '    DUP_VOLUBD,                             ';
  Result := Result + '    DUP_VOLUTB,                             ';
  Result := Result + '    DUP_VOLUSD,                             ';
  Result := Result + '    DUP_VOLUPO,                             ';

  Result := Result + '    DUP_PREELT,                             ';
  Result := Result + '    DUP_PREEGL,                             ';
  Result := Result + '    DUP_PREELA,                             ';
  Result := Result + '    DUP_PREECP,                             ';
  Result := Result + '    DUP_PREESP,                             ';
  Result := Result + '    DUP_PREEBD,                             ';
  Result := Result + '    DUP_PREETB,                             ';
  Result := Result + '    DUP_PREESD,                             ';
  Result := Result + '    DUP_PREEPO,                             ';

  Result := Result + '    DUP_TIPOLT,                             ';
  Result := Result + '    DUP_TIPOGL,                             ';
  Result := Result + '    DUP_TIPOLA,                             ';
  Result := Result + '    DUP_TIPOCP,                             ';
  Result := Result + '    DUP_TIPOSP,                             ';
  Result := Result + '    DUP_TIPOBD,                             ';
  Result := Result + '    DUP_TIPOTB,                             ';
  Result := Result + '    DUP_TIPOSD,                             ';
  Result := Result + '    DUP_TIPOPO,                             ';

  Result := Result + '    DUP_PCCALT,                             ';
  Result := Result + '    DUP_PCCAGL,                             ';
  Result := Result + '    DUP_PCCALA,                             ';
  Result := Result + '    DUP_PCCACP,                             ';
  Result := Result + '    DUP_PCCASP,                             ';
  Result := Result + '    DUP_PCCABD,                             ';
  Result := Result + '    DUP_PCCATB,                             ';
  Result := Result + '    DUP_PCCASD,                             ';
  Result := Result + '    DUP_PCCAPO,                             ';

  Result := Result + '    DUP_PCATLT,                             ';
  Result := Result + '    DUP_PCATGL,                             ';
  Result := Result + '    DUP_PCATLA,                             ';
  Result := Result + '    DUP_PCATCP,                             ';
  Result := Result + '    DUP_PCATSP,                             ';
  Result := Result + '    DUP_PCATBD,                             ';
  Result := Result + '    DUP_PCATTB,                             ';
  Result := Result + '    DUP_PCATSD,                             ';
  Result := Result + '    DUP_PCATPO,                             ';

  Result := Result + '    DUP_PCALT1,                             ';
  Result := Result + '    DUP_PCALT2,                             ';
  Result := Result + '    DUP_PCALT3,                             ';
  Result := Result + '    DUP_PCALT4,                             ';
  Result := Result + '    DUP_PCALT5,                             ';
  Result := Result + '    DUP_PCALT6,                             ';
  Result := Result + '    DUP_PCALT7,                             ';

  Result := Result + '    DUP_PCAGL1,                             ';
  Result := Result + '    DUP_PCAGL2,                             ';
  Result := Result + '    DUP_PCAGL3,                             ';
  Result := Result + '    DUP_PCAGL4,                             ';
  Result := Result + '    DUP_PCAGL5,                             ';
  Result := Result + '    DUP_PCAGL6,                             ';
  Result := Result + '    DUP_PCAGL7,                             ';

  Result := Result + '    DUP_PCALA1,                             ';
  Result := Result + '    DUP_PCALA2,                             ';
  Result := Result + '    DUP_PCALA3,                             ';
  Result := Result + '    DUP_PCALA4,                             ';
  Result := Result + '    DUP_PCALA5,                             ';
  Result := Result + '    DUP_PCALA6,                             ';
  Result := Result + '    DUP_PCALA7,                             ';

  Result := Result + '    DUP_PCACP1,                             ';
  Result := Result + '    DUP_PCACP2,                             ';
  Result := Result + '    DUP_PCACP3,                             ';
  Result := Result + '    DUP_PCACP4,                             ';
  Result := Result + '    DUP_PCACP5,                             ';
  Result := Result + '    DUP_PCACP6,                             ';
  Result := Result + '    DUP_PCACP7,                             ';

  Result := Result + '    DUP_PCASP1,                             ';
  Result := Result + '    DUP_PCASP2,                             ';
  Result := Result + '    DUP_PCASP3,                             ';
  Result := Result + '    DUP_PCASP4,                             ';
  Result := Result + '    DUP_PCASP5,                             ';
  Result := Result + '    DUP_PCASP6,                             ';
  Result := Result + '    DUP_PCASP7,                             ';

  Result := Result + '    DUP_PCABD1,                             ';
  Result := Result + '    DUP_PCABD2,                             ';
  Result := Result + '    DUP_PCABD3,                             ';
  Result := Result + '    DUP_PCABD4,                             ';
  Result := Result + '    DUP_PCABD5,                             ';
  Result := Result + '    DUP_PCABD6,                             ';
  Result := Result + '    DUP_PCABD7,                             ';

  Result := Result + '    DUP_PCATB1,                             ';
  Result := Result + '    DUP_PCATB2,                             ';
  Result := Result + '    DUP_PCATB3,                             ';
  Result := Result + '    DUP_PCATB4,                             ';
  Result := Result + '    DUP_PCATB5,                             ';
  Result := Result + '    DUP_PCATB6,                             ';
  Result := Result + '    DUP_PCATB7,                             ';

  Result := Result + '    DUP_PCASD1,                             ';
  Result := Result + '    DUP_PCASD2,                             ';
  Result := Result + '    DUP_PCASD3,                             ';
  Result := Result + '    DUP_PCASD4,                             ';
  Result := Result + '    DUP_PCASD5,                             ';
  Result := Result + '    DUP_PCASD6,                             ';
  Result := Result + '    DUP_PCASD7,                             ';

  Result := Result + '    DUP_PCAPO1,                             ';
  Result := Result + '    DUP_PCAPO2,                             ';
  Result := Result + '    DUP_PCAPO3,                             ';
  Result := Result + '    DUP_PCAPO4,                             ';
  Result := Result + '    DUP_PCAPO5,                             ';
  Result := Result + '    DUP_PCAPO6,                             ';
  Result := Result + '    DUP_PCAPO7                              ';



  Result := Result + '                )                           ';

  Result := Result + '  VALUES        (                           ';
  Result := Result + '    :CODDUP,                                ';
  Result := Result + '    :CODOEM,                                ';
  Result := Result + '    :LINHA_,                                ';
  Result := Result + '    :QUALID,                                ';
  Result := Result + '    :ALTERN,                                ';
  Result := Result + '    :REGIAO,                                ';
  Result := Result + '    :DESCRI,                                ';
  Result := Result + '    :MONTAD,                                ';
  Result := Result + '    :ANOCOR,                                ';
  Result := Result + '    :LITRAG,                                ';
  Result := Result + '    :CATALI,                                ';
  Result := Result + '    :OBSERV,                                ';
  Result := Result + '    :MD5KEY,                                ';

  Result := Result + '    :CODITE,                                ';
  Result := Result + '    :CODDIL,                                ';
  Result := Result + '    :PORDIL,                                ';

  Result := Result + '    :PRECLT,                                ';
  Result := Result + '    :PRECGL,                                ';
  Result := Result + '    :PRECLA,                                ';
  Result := Result + '    :PRECCP,                                ';
  Result := Result + '    :PRECSP,                                ';
  Result := Result + '    :PRECBD,                                ';
  Result := Result + '    :PRECTB,                                ';
  Result := Result + '    :PRECSD,                                ';
  Result := Result + '    :PRECPO,                                ';

  Result := Result + '    :PREDLT,                                ';
  Result := Result + '    :PREDGL,                                ';
  Result := Result + '    :PREDLA,                                ';
  Result := Result + '    :PREDCP,                                ';
  Result := Result + '    :PREDSP,                                ';
  Result := Result + '    :PREDBD,                                ';
  Result := Result + '    :PREDTB,                                ';
  Result := Result + '    :PREDSD,                                ';
  Result := Result + '    :PREDPO,                                ';

  Result := Result + '    :PCUCLT,                                ';
  Result := Result + '    :PCUDLT,                                ';
  Result := Result + '    :PCUCGL,                                ';
  Result := Result + '    :PCUDGL,                                ';
  Result := Result + '    :PCUCLA,                                ';
  Result := Result + '    :PCUDLA,                                ';
  Result := Result + '    :PCUCCP,                                ';
  Result := Result + '    :PCUDCP,                                ';
  Result := Result + '    :PCUCSP,                                ';
  Result := Result + '    :PCUDSP,                                ';
  Result := Result + '    :PCUCBD,                                ';
  Result := Result + '    :PCUDBD,                                ';
  Result := Result + '    :PCUCTB,                                ';
  Result := Result + '    :PCUDTB,                                ';
  Result := Result + '    :PCUCSD,                                ';
  Result := Result + '    :PCUDSD,                                ';
  Result := Result + '    :PCUCPO,                                ';
  Result := Result + '    :PCUDPO,                                ';

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

  Result := Result + '    :PRCTB1,                                ';
  Result := Result + '    :PRCTB2,                                ';
  Result := Result + '    :PRCTB3,                                ';
  Result := Result + '    :PRCTB4,                                ';
  Result := Result + '    :PRCTB5,                                ';
  Result := Result + '    :PRCTB6,                                ';
  Result := Result + '    :PRCTB7,                                ';

  Result := Result + '    :PRDTB1,                                ';
  Result := Result + '    :PRDTB2,                                ';
  Result := Result + '    :PRDTB3,                                ';
  Result := Result + '    :PRDTB4,                                ';
  Result := Result + '    :PRDTB5,                                ';
  Result := Result + '    :PRDTB6,                                ';
  Result := Result + '    :PRDTB7,                                ';

  Result := Result + '    :PRCSD1,                                ';
  Result := Result + '    :PRCSD2,                                ';
  Result := Result + '    :PRCSD3,                                ';
  Result := Result + '    :PRCSD4,                                ';
  Result := Result + '    :PRCSD5,                                ';
  Result := Result + '    :PRCSD6,                                ';
  Result := Result + '    :PRCSD7,                                ';

  Result := Result + '    :PRDSD1,                                ';
  Result := Result + '    :PRDSD2,                                ';
  Result := Result + '    :PRDSD3,                                ';
  Result := Result + '    :PRDSD4,                                ';
  Result := Result + '    :PRDSD5,                                ';
  Result := Result + '    :PRDSD6,                                ';
  Result := Result + '    :PRDSD7,                                ';

  Result := Result + '    :PRCPO1,                                ';
  Result := Result + '    :PRCPO2,                                ';
  Result := Result + '    :PRCPO3,                                ';
  Result := Result + '    :PRCPO4,                                ';
  Result := Result + '    :PRCPO5,                                ';
  Result := Result + '    :PRCPO6,                                ';
  Result := Result + '    :PRCPO7,                                ';

  Result := Result + '    :PRDPO1,                                ';
  Result := Result + '    :PRDPO2,                                ';
  Result := Result + '    :PRDPO3,                                ';
  Result := Result + '    :PRDPO4,                                ';
  Result := Result + '    :PRDPO5,                                ';
  Result := Result + '    :PRDPO6,                                ';
  Result := Result + '    :PRDPO7,                                ';

  Result := Result + '    :EMBALT,                                ';
  Result := Result + '    :EMBAGL,                                ';
  Result := Result + '    :EMBALA,                                ';
  Result := Result + '    :EMBACP,                                ';
  Result := Result + '    :EMBASP,                                ';
  Result := Result + '    :EMBABD,                                ';
  Result := Result + '    :EMBATB,                                ';
  Result := Result + '    :EMBASD,                                ';
  Result := Result + '    :EMBAPO,                                ';

  Result := Result + '    :VOLULT,                                ';
  Result := Result + '    :VOLUGL,                                ';
  Result := Result + '    :VOLULA,                                ';
  Result := Result + '    :VOLUCP,                                ';
  Result := Result + '    :VOLUSP,                                ';
  Result := Result + '    :VOLUBD,                                ';
  Result := Result + '    :VOLUTB,                                ';
  Result := Result + '    :VOLUSD,                                ';
  Result := Result + '    :VOLUPO,                                ';

  Result := Result + '    :PREELT,                                ';
  Result := Result + '    :PREEGL,                                ';
  Result := Result + '    :PREELA,                                ';
  Result := Result + '    :PREECP,                                ';
  Result := Result + '    :PREESP,                                ';
  Result := Result + '    :PREEBD,                                ';
  Result := Result + '    :PREETB,                                ';
  Result := Result + '    :PREESD,                                ';
  Result := Result + '    :PREEPO,                                ';

  Result := Result + '    :TIPOLT,                                ';
  Result := Result + '    :TIPOGL,                                ';
  Result := Result + '    :TIPOLA,                                ';
  Result := Result + '    :TIPOCP,                                ';
  Result := Result + '    :TIPOSP,                                ';
  Result := Result + '    :TIPOBD,                                ';
  Result := Result + '    :TIPOTB,                                ';
  Result := Result + '    :TIPOSD,                                ';
  Result := Result + '    :TIPOPO,                                ';

  Result := Result + '    :PCCALT,                                ';
  Result := Result + '    :PCCAGL,                                ';
  Result := Result + '    :PCCALA,                                ';
  Result := Result + '    :PCCACP,                                ';
  Result := Result + '    :PCCASP,                                ';
  Result := Result + '    :PCCABD,                                ';
  Result := Result + '    :PCCATB,                                ';
  Result := Result + '    :PCCASD,                                ';
  Result := Result + '    :PCCAPO,                                ';

  Result := Result + '    :PCATLT,                                ';
  Result := Result + '    :PCATGL,                                ';
  Result := Result + '    :PCATLA,                                ';
  Result := Result + '    :PCATCP,                                ';
  Result := Result + '    :PCATSP,                                ';
  Result := Result + '    :PCATBD,                                ';
  Result := Result + '    :PCATTB,                                ';
  Result := Result + '    :PCATSD,                                ';
  Result := Result + '    :PCATPO,                                ';

  Result := Result + '    :PCALT1,                                ';
  Result := Result + '    :PCALT2,                                ';
  Result := Result + '    :PCALT3,                                ';
  Result := Result + '    :PCALT4,                                ';
  Result := Result + '    :PCALT5,                                ';
  Result := Result + '    :PCALT6,                                ';
  Result := Result + '    :PCALT7,                                ';

  Result := Result + '    :PCAGL1,                                ';
  Result := Result + '    :PCAGL2,                                ';
  Result := Result + '    :PCAGL3,                                ';
  Result := Result + '    :PCAGL4,                                ';
  Result := Result + '    :PCAGL5,                                ';
  Result := Result + '    :PCAGL6,                                ';
  Result := Result + '    :PCAGL7,                                ';

  Result := Result + '    :PCALA1,                                ';
  Result := Result + '    :PCALA2,                                ';
  Result := Result + '    :PCALA3,                                ';
  Result := Result + '    :PCALA4,                                ';
  Result := Result + '    :PCALA5,                                ';
  Result := Result + '    :PCALA6,                                ';
  Result := Result + '    :PCALA7,                                ';

  Result := Result + '    :PCACP1,                                ';
  Result := Result + '    :PCACP2,                                ';
  Result := Result + '    :PCACP3,                                ';
  Result := Result + '    :PCACP4,                                ';
  Result := Result + '    :PCACP5,                                ';
  Result := Result + '    :PCACP6,                                ';
  Result := Result + '    :PCACP7,                                ';

  Result := Result + '    :PCASP1,                                ';
  Result := Result + '    :PCASP2,                                ';
  Result := Result + '    :PCASP3,                                ';
  Result := Result + '    :PCASP4,                                ';
  Result := Result + '    :PCASP5,                                ';
  Result := Result + '    :PCASP6,                                ';
  Result := Result + '    :PCASP7,                                ';

  Result := Result + '    :PCABD1,                                ';
  Result := Result + '    :PCABD2,                                ';
  Result := Result + '    :PCABD3,                                ';
  Result := Result + '    :PCABD4,                                ';
  Result := Result + '    :PCABD5,                                ';
  Result := Result + '    :PCABD6,                                ';
  Result := Result + '    :PCABD7,                                ';

  Result := Result + '    :PCATB1,                                ';
  Result := Result + '    :PCATB2,                                ';
  Result := Result + '    :PCATB3,                                ';
  Result := Result + '    :PCATB4,                                ';
  Result := Result + '    :PCATB5,                                ';
  Result := Result + '    :PCATB6,                                ';
  Result := Result + '    :PCATB7,                                ';

  Result := Result + '    :PCASD1,                                ';
  Result := Result + '    :PCASD2,                                ';
  Result := Result + '    :PCASD3,                                ';
  Result := Result + '    :PCASD4,                                ';
  Result := Result + '    :PCASD5,                                ';
  Result := Result + '    :PCASD6,                                ';
  Result := Result + '    :PCASD7,                                ';

  Result := Result + '    :PCAPO1,                                ';
  Result := Result + '    :PCAPO2,                                ';
  Result := Result + '    :PCAPO3,                                ';
  Result := Result + '    :PCAPO4,                                ';
  Result := Result + '    :PCAPO5,                                ';
  Result := Result + '    :PCAPO6,                                ';
  Result := Result + '    :PCAPO7                                 ';

  Result := Result + '              );                            ';

end;

function TExportaTintometricosTerceirosDupont.fValorQuantidade(fltValor: Double; fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosDupont.pAdicionaParamentros
  (var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODDUP').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_CODDUP').AsString);
  DataSet.ParamByName('CODOEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_CODOEM').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_LINHA_').AsString);
  DataSet.ParamByName('QUALID').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_QUALID').AsString);
  DataSet.ParamByName('ALTERN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_ALTERN').AsString);
  DataSet.ParamByName('REGIAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_REGIAO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_DESCRI').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_MONTAD').AsString);
  DataSet.ParamByName('ANOCOR').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_ANOCOR').AsString);
  DataSet.ParamByName('LITRAG').AsFloats[intParam] :=  qryTinta.FieldByName('DUP_LITRAG').AsFloat;
  DataSet.ParamByName('CATALI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_CATALI').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUP_OBSERV').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('DUP_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProDup; // PRODUTO VENDA;

  DataSet.ParamByName('PCUCLT').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);
  DataSet.ParamByName('PCUCBD').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUDBD').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
  DataSet.ParamByName('PCUCTB').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUDTB').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUCSD').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONSD'], 0.0);
  DataSet.ParamByName('PCUDSD').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILSD'], 0.0);
  DataSet.ParamByName('PCUCPO').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONPO'], 0.0);
  DataSet.ParamByName('PCUDPO').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILPO'], 0.0);

  DataSet.ParamByName('PCCALT').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATLT'], 0.0);
  DataSet.ParamByName('PCCAGL').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATGL'], 0.0);
  DataSet.ParamByName('PCCALA').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATLA'], 0.0);
  DataSet.ParamByName('PCCACP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATCP'], 0.0);
  DataSet.ParamByName('PCCASP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATSP'], 0.0);
  DataSet.ParamByName('PCCABD').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATBD'], 0.0);
  DataSet.ParamByName('PCCATB').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATTB'], 0.0);
  DataSet.ParamByName('PCCASD').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATSD'], 0.0);
  DataSet.ParamByName('PCCAPO').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_DILCATPO'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    End;
  End;


  If strAcrMob = '1' Then
  Begin
    DataSet.ParamByName('PCATLT').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT0'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATGL').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT1'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATLA').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT2'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATCP').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT3'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATSP').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT4'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATBD').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT5'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATTB').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT6'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATSD').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT7'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
    DataSet.ParamByName('PCATPO').AsFloats[intParam] := IfNull(dicPrecoAdicional['VENDACAT8'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
  End
  Else
  Begin
    DataSet.ParamByName('PCATLT').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT0'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATGL').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT1'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATLA').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT2'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATCP').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT3'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATSP').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT4'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATBD').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT5'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATTB').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT6'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATSD').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT7'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
    DataSet.ParamByName('PCATPO').AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['VENDACAT8'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
  End;


  For IntContador := 1 To 7 Do
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
      DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
      DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0);
      DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0);
      DataSet.ParamByName('PRCPO' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONPO'], 0.0);
      DataSet.ParamByName('PRDPO' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILPO'], 0.0);

      DataSet.ParamByName('PCALT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATLT'], 0.0);
      DataSet.ParamByName('PCAGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATGL'], 0.0);
      DataSet.ParamByName('PCALA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATLA'], 0.0);
      DataSet.ParamByName('PCACP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATCP'], 0.0);
      DataSet.ParamByName('PCASP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATSP'], 0.0);
      DataSet.ParamByName('PCABD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATBD'], 0.0);
      DataSet.ParamByName('PCATB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATTB'], 0.0);
      DataSet.ParamByName('PCASD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATSD'], 0.0);
      DataSet.ParamByName('PCAPO' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATPO'], 0.0);
      End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0)* (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0)* (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCPO' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONPO'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDPO' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILPO'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);

        DataSet.ParamByName('PCALT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATLT'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCAGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATGL'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCALA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATLA'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCACP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATCP'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCASP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATSP'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCABD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATBD'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCATB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATTB'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCASD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATSD'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PCAPO' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATPO'], 0.0) * (1 + qryTinta.FieldByName('DUP_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCPO' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONPO'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDPO' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILPO'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);

        DataSet.ParamByName('PCALT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATLT'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCAGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATGL'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCALA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATLA'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCACP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATCP'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCASP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATSP'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCABD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATBD'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCATB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATTB'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCASD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATSD'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
        DataSet.ParamByName('PCAPO' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCATPO'], 0.0), qryTinta.FieldByName('DUP_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDupont.pIncluirLogTinSite
  (Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil, Conexao);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "DUP"  ');
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('  INSERT INTO LOGTIN_SIT  (       ');
    qryGen.SQL.Add('    LOG_IDEPRO,                   ');
    qryGen.SQL.Add('    LOG_DTAEXE,                   ');
    qryGen.SQL.Add('    LOG_HOREXE,                   ');
    qryGen.SQL.Add('    LOG_EXECUT                    ');
    qryGen.SQL.Add('              )                   ');
    qryGen.SQL.Add('  VALUES  (                       ');
    qryGen.SQL.Add('    "DUP",                        ');
    qryGen.SQL.Add('    :DTAEXE,                      ');
    qryGen.SQL.Add('    :HOREXE,                      ');
    qryGen.SQL.Add('    :EXECUT                       ');
    qryGen.SQL.Add('            );                    ');

    qryGen.ParamByName('DTAEXE').AsDateTime := VS_Date;
    qryGen.ParamByName('HOREXE').AsDateTime := Time;
    qryGen.ParamByName('EXECUT').AsString := strStatus;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosDupont.pPreencheArrayEmbalagem;
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
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Spray Sintetico
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Sintetico';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 196.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Spray Duco
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Duco';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  // Spray Poliester
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Poliester';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'PO';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;

end;

procedure TExportaTintometricosTerceirosDupont.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem
end;

procedure TExportaTintometricosTerceirosDupont.pProcessaTabelaCores(
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
      pRecalculaFormula(dicRetorno, qryGen, qryBases);
      pRetornaPrecoTinta(dicRetorno, qryColorantes, qryBases, fltPerAcr);

    {$IFDEF LINUX}
      If FValidateIndexList.Contains(qryGen.RecNo) Then
      Begin
        For intEmb := 0 To 3 Do
        Begin

          If qryGen.FieldByName('DUP_QTDC01').AsFloat > 0 Then
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                     arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                     arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');

          If qryGen.FieldByName('DUP_QTDD01').AsFloat > 0 Then
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

procedure TExportaTintometricosTerceirosDupont.pRecalculaFormula
  (dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  For intContador := 1 To fQuantidadeFormulacao Do
  Begin
    If fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;
    dicRetorno['qtdb' + fStrZero(intContador, 2)] := RoundTo(qryGen.FieldByName(fRetQuantidade(intContador)).AsFloat, -1);
  End;

  blnNaoDiluido := ((qryGen.FieldByName('DUP_LINHA_').AsString = 'DUXONE') And
    (qryGen.FieldByName('DUP_QUALID').AsString = 'BP')) Or (qryGen.FieldByName('DUP_LINHA_').AsString = 'CORMAX');

  blnCatalize := False;

  fltVolumeOri := qryGen.FieldByName('DUP_LITRAG').AsFloat / 1000;

  If qryGen.FieldByName('DUP_QTDD01').AsFloat <= 0 Then // Concentrado
    Exit;

  If blnNaoDiluido Then
    Exit;

  If (qryGen.FieldByName('DUP_QTDC01').AsFloat > 0) And
    (qryGen.FieldByName('DUP_QTDD01').AsFloat > 0) Then // Concentrado e Diluido
  Begin
    For intContador := 1 To fQuantidadeFormulacao Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (qryGen.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString = 'C') Then
        blnCatalize := True;

      If Copy(dicRetorno['descri'], 1, 3) = 'ESP' Then
      Begin
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat;
        dicRetorno['tipb' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString;
      End
      Else
      Begin
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := RoundTo(qryGen.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat, -1);
        dicRetorno['tipb' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString;
      End;
    End;

    dicRetorno['coddil'] := 'CONDIL';
    dicRetorno['pordil'] := 0.0000;
  End
  Else If (qryGen.FieldByName('DUP_QTDC01').AsFloat <= 0) And
    (qryGen.FieldByName('DUP_QTDD01').AsFloat > 0) Then // Diluido
  Begin

    For intContador := 1 To fQuantidadeFormulacao Do
    Begin

      If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

      If (qryGen.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString = 'C') Then
        blnCatalize := True;

      dicRetorno['qtdb' + fStrZero(intContador, 2)] := 0.0000;

      If Copy(dicRetorno['descri'], 1, 3) = 'ESP' Then
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat
      Else
        dicRetorno['qtdd' + fStrZero(intContador, 2)] := RoundTo(qryGen.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat, - 1);

      dicRetorno['tipb' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUP_TIPB' + fStrZero(intContador, 2)).AsString;
    End;

    dicRetorno['coddil'] := 'DILUIDO';
    dicRetorno['pordil'] := 0.0000;
  End;
end;

procedure TExportaTintometricosTerceirosDupont.pRetPrecosAdicionais(
  dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
  intContador, intEmb, intPreVen: Integer;
  fltPrecoVendaCon, fltPrecoVendaTotalCon: Double;
  fltPrecoVendaDil, fltPrecoVendaTotalDil: Double;
  fltPrecoCustoCon, fltPrecoCustoTotalCon: Double;
  fltPrecoCustoDil, fltPrecoCustoTotalDil: Double;
  fltPreCusPro, fltPreVenPro: Double;
  fltQuantCon, fltQuantDil: Double;
  fltPrecoVenda, fltPrecoCusto: Double;
  fltPrecoEmbalagem, fltEmbalagem,
  fltPesoEsp: Double;
  strTabelaUnica, strCodCli,
  strCodCnd, strCamEmb: String;
  intPrzMed: Integer;
  ArrComponentes: Array of TComp;
  strEmb: String;
  iQuantidade: Integer;
begin
  fltPrecoEmbalagem := 0;
  fltPrecoVenda := 0;
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  strCodCli := '';
  strCodCnd := '';
  intPrzMed := 0;

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
      SetLength(ArrComponentes, fQuantidadeFormulacao());

      iQuantidade := 1;

      //Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        If dicRetorno['tipb' + fStrZero(intContador, 2)] <> 'C' Then
        Begin
          ArrComponentes[iQuantidade].Componente := dicRetorno['base' + fStrZero(intContador, 2)];

          If Copy(dicRetorno['descri'], 1, 3) = 'ESP' Then
          Begin
            ArrComponentes[iQuantidade].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / fltVolumeOri);
            ArrComponentes[iQuantidade].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) /fltVolumeOri);
          End
          Else
          Begin
            ArrComponentes[iQuantidade].Quantidade := ((RoundTo(dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / fltVolumeOri, - 1)));
            ArrComponentes[iQuantidade].Quantiddil := ((RoundTo(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / fltVolumeOri , - 1)));
          End;

          Inc(iQuantidade);
        End
        Else
          Continue;
      End;

      //Calculando Preços de vendas (Tabelas dos Clientes) Diluidos e Concentrados
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
              fltPrecoVenda := fltPreVenPro
            Else
              fltPrecoVenda := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltEmbalagem := fRetEmbalagem(qryBases);

          fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

          //Preco de venda concentrado
          fltQuantCon := ArrComponentes[intContador].Quantidade;

          If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
            fltPrecoVendaCon := fltQuantCon * (fltPrecoVenda / fltEmbalagem)
          Else
            fltPrecoVendaCon := fltQuantCon * (fltPrecoVenda / fltEmbalagem / fltPesoEsp);

          fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;
          If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
            fltPrecoVendaDil := fltQuantDil * (fltPrecoVenda / fltEmbalagem)
          Else
            fltPrecoVendaDil := fltQuantDil * (fltPrecoVenda / fltEmbalagem / fltPesoEsp);

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
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, IntPreVen);
        End;

        //Preco de venda concentrado
        If fltPrecoVendaTotalCon > 0 Then
          dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_CON' + strEmb] := fltPrecoVendaTotalCon +
            (fltPerAcr * fltPrecoVendaTotalCon) + fltPrecoEmbalagem;

        If blnNaoDiluido Then
          fltPrecoVendaTotalDil := 0;

        //Preco de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DIL' + strEmb] := fltPrecoVendaTotalDil +
            (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

      End;

      fltPrecoCustoTotalCon := 0.0;
      fltPrecoCustoTotalDil := 0.0;
      fltPrecoCusto := 0.0;

      //Preço de Custo Concentrado e Diluido(Por Embalagem);
      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin

        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica , strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoCusto := fltPreCusPro
          Else
            fltPrecoCusto := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        fltEmbalagem := fRetEmbalagem(qryBases);

        fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        //Preço de Custo Concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;

        If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
          fltPrecoCustoCon := fltQuantCon * (fltPrecoCusto / fltEmbalagem)
        Else
          fltPrecoCustoCon := fltQuantCon * (fltPrecoCusto / fltEmbalagem / fltPesoEsp);

        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        //Preço de Custo Diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;

        If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
          fltPrecoCustoDil := fltQuantDil * (fltPrecoCusto / fltEmbalagem)
        Else
          fltPrecoCustoDil := fltQuantDil * (fltPrecoCusto / fltEmbalagem / fltPesoEsp);

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

      If fltPrecoCustoTotalCon > 0 Then
        dicPrecoAdicional['PRECUS_CON' + strEmb] := IfNull((fltPrecoCustoTotalCon + fltPrecoEmbalagem), 0.0);

      If blnNaoDiluido Then
        fltPrecoCustoTotalDil := 0;

      If fltPrecoCustoTotalDil > 0 Then
        dicPrecoAdicional['PRECUS_DIL' + strEmb] := IfNull((fltPrecoCustoTotalDil + fltPrecoEmbalagem), 0.0);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;

  If blnNaoDiluido Then
    Exit;

  If Not blnCatalize Then
    Exit;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    iQuantidade := 1;
    strCamEmb := fRetornaCampoEmbalagem(arrEmbalagens[intEmb].strSigEmb, dicRetorno);
    strEmb := arrEmbalagens[intEmb].strSigEmb;

    //Verificar se existe a embalagem
    If (Not cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, [])) Then
      Continue;

    //Verificar se existe produto vinculado
    If fEmptyStr(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString) Then
      Continue;

    Try
      SetLength(ArrComponentes, fQuantidadeFormulacao);

      For intContador := 1 To fQuantidadeFormulacao Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
        Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        ArrComponentes[iQuantidade].Componente := dicRetorno['base' + fStrZero(intContador, 2)];

        If Copy(dicRetorno['descri'], 1, 3) = 'ESP' Then
          ArrComponentes[iQuantidade].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) /fltVolumeOri)
        Else
          ArrComponentes[iQuantidade].Quantiddil := ((RoundTo(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / fltVolumeOri, - 1)));

        Inc(iQuantidade);
      End;

      For intPreVen := 1 To 7 Do
      Begin
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
              fltPrecoVenda := fltPreVenPro
            Else
              fltPrecoVenda := qryBases.FieldByName('PREVE' + IntToStr(intPreVen)).AsFloat;
          End;

          fltEmbalagem := fRetEmbalagem(qryBases);

          fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

          //Preco de venda diluido
          fltQuantDil := ArrComponentes[intContador].Quantiddil;

          If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
            fltPrecoVendaDil := fltQuantDil * (fltPrecoVenda / fltEmbalagem)
          Else
            fltPrecoVendaDil := fltQuantDil * (fltPrecoVenda / fltEmbalagem / fltPesoEsp);

          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
        End;

        If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
          fltPrecoVendaTotalDil := 0.0;

        //Retorna preco da embalagem
        If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
        Begin
          If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
            IntToStr(intPreVen), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoEmbalagem := fltPreVenPro + (fltPerAcr * fltPreVenPro)
          Else
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, IntPreVen);
        End;

        //Preco de venda diluido
        If fltPrecoVendaTotalDil > 0 Then
          fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;

        dicPrecoAdicional['PREVE' + IntToStr(intPreVen) + '_DILCAT' + strEmb] := fltPrecoVendaTotalDil;
      End;

      fltPrecoCustoTotalDil := 0.0;
      fltPrecoCusto := 0.0;

      For intContador := 1 To fQuantidadeFormulacao() Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
        Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente,[]) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica , strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoCusto := fltPreCusPro
          Else
            fltPrecoCusto := qryBases.FieldByName('PRECUS').AsFloat;
        End;

        fltEmbalagem := fRetEmbalagem(qryBases);

        fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        //Preço de Custo Diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;

        If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
          fltPrecoCustoDil := fltQuantDil * (fltPrecoCusto / fltEmbalagem)
        Else
          fltPrecoCustoDil := fltQuantDil * (fltPrecoCusto / fltEmbalagem / fltPesoEsp);

        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
      End;

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

      If fltPrecoCustoTotalDil > 0 Then
        fltPrecoCustoTotalDil := IfNull((fltPrecoCustoTotalDil + fltPrecoEmbalagem), 0.0);

      dicPrecoAdicional['PRECUS_DILCAT' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDupont.pRetPrecoTintas
  (dicRetorno: TDicionario; qryColorantes, qryBases: TUniQuery;
  fltPerAcr: Double);
var
  intContador: Integer;
  fltQuantCon, fltPrecoVendaCon, fltPrecoVendaTotalCon, fltQuantDil,
    fltPrecoVendaDil, fltPrecoVendaTotalDil, fltPrecoBase,
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
  iQuantidade: Integer;
begin
  fltPrecoBase := 0;
  fltPrecoEmbalagem := 0;
  fltPreCusPro := 0;
  fltPreVenPro := 0;
  strCodCli := '';
  strCodCnd := '';
  intPrzMed := 0;


  strProDup := fRetProdutoVenda(dicRetorno);

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

      iQuantidade := 1;

      // Adiciona a formulacao no array
      For intContador := 1 To fQuantidadeFormulacao Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        If (Not qryBases.Locate('BAS_CODBAS', dicRetorno['base' + fStrZero(intContador, 2)], [])) Then
          Break;

        If dicRetorno['tipb' + fStrZero(intContador, 2)] <> 'C' Then
        Begin
          ArrComponentes[iQuantidade].Componente := dicRetorno['base' + fStrZero(intContador, 2)];

          If Copy(dicRetorno['descri'], 1, 3) = 'ESP' Then
          Begin
            ArrComponentes[iQuantidade].Quantidade := ((dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume) / fltVolumeOri);
            ArrComponentes[iQuantidade].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) /fltVolumeOri);
          End
          Else
          Begin
            ArrComponentes[iQuantidade].Quantidade := ((RoundTo(dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / fltVolumeOri, - 1)));
            ArrComponentes[iQuantidade].Quantiddil := ((RoundTo(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / fltVolumeOri , - 1)));
          End;

          Inc(iQuantidade);
        End
        Else
          Continue;
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

        If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
          fltPrecoVendaCon := fltQuantCon * (fltPrecoBase / fltEmbala)
        Else
          fltPrecoVendaCon := fltQuantCon *
            (fltPrecoBase / fltEmbala / fltPesoEsp);

        fltPrecoVendaTotalCon := fltPrecoVendaTotalCon + fltPrecoVendaCon;

        // Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
          fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala)
        Else
          fltPrecoVendaDil := fltQuantDil *
            (fltPrecoBase / fltEmbala / fltPesoEsp);

        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      If IsInfinite(fltPrecoVendaTotalCon) Or IsNan(fltPrecoVendaTotalCon) Then
        fltPrecoVendaTotalCon := 0.0;

      If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
        fltPrecoVendaTotalDil := 0.0;

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

      If blnNaoDiluido Then
        fltPrecoVendaTotalDil := 0;

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
      arrPrecosPorEmb[intEmb].fltPorDil := fRetornaPorcentagemDiluente
        (dicRetorno);
      arrPrecosPorEmb[intEmb].fltPorDil := fRetornaPorcentagemDiluente(dicRetorno);
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;

  pRetPrecosAdicionais(dicRetorno, qryColorantes, qryBases, fltPerAcr);

  If blnNaoDiluido Then
    Exit;

  If Not blnCatalize Then
    Exit;

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    fltPrecoVendaTotalDil := 0;
    iQuantidade := 1;

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

        ArrComponentes[iQuantidade].Componente := dicRetorno['base' + fStrZero(intContador, 2)];

        If Copy(dicRetorno['descri'], 1, 3) = 'ESP' Then
          ArrComponentes[iQuantidade].Quantiddil := ((IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume) /fltVolumeOri)
        Else
          ArrComponentes[iQuantidade].Quantiddil := ((RoundTo(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / fltVolumeOri, - 1)));

        Inc(iQuantidade);
      End;

      For intContador := 1 To Length(ArrComponentes) Do
      Begin
        If fEmptyStr(ArrComponentes[intContador].Componente) Then
          Break;

        If qryBases.Locate('BAS_CODBAS', ArrComponentes[intContador].Componente, []) Then
        Begin
          If fCarregaPromocao(qryBases.FieldByName('BAS_CODITE').AsString,
            strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
            fltPrecoBase := fltPreVenPro
          Else
            fltPrecoBase := qryBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        fltEmbala  := fRetEmbalagem(qryBases);
        fltPesoEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;

        // Preco de venda diluido
        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        If qryBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
          fltPrecoVendaDil := fltQuantDil * (fltPrecoBase / fltEmbala)
        Else
          fltPrecoVendaDil := fltQuantDil *
            (fltPrecoBase / fltEmbala / fltPesoEsp);

        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil + fltPrecoVendaDil;
      End;

      If IsInfinite(fltPrecoVendaTotalDil) Or IsNan(fltPrecoVendaTotalDil) Then
        fltPrecoVendaTotalDil := 0.0;

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

      // Preco de venda diluido
      If fltPrecoVendaTotalDil > 0 Then
        fltPrecoVendaTotalDil := fltPrecoVendaTotalDil +
          (fltPerAcr * fltPrecoVendaTotalDil) + fltPrecoEmbalagem;


      dicPrecoAdicional['VENDACAT' + IntToStr(intEmb)] := fltPrecoVendaTotalDil;
    Finally
      SetLength(arrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDupont.pSetaParametrosEspecificos
  (Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
  intContador: Integer;
begin
  pCriaClientEmbalagem(Conexao);

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

procedure TExportaTintometricosTerceirosDupont.pCriaClientEmbalagem
  (Conexao: TUniConnection);
Var
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
      SQL.Add('  WHERE CFG_IDEPRO = "DUP" ');
      SQL.Add('    AND CFG_GRUCFG = "CONFIGURACOES" ');
      SQL.Add('    AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
      Open;
    End;

    cdsEmbalagens := fCriaClientDatset(qryGen, False, Nil, False);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TExportaTintometricosTerceirosDupont.pGravaTintometricoPorTintaTerceiros(
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

end.
