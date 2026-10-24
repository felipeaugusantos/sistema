unit untExportaTintometricosTerceirosDuxone;

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
  TExportaTintometricosTerceirosDuxone = Class(TExportaTintometricosTerceirosAutomotiva)
  Private
    strProDux: String;
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
    function fGetTipoFormula(qryGen: TUniQuery; qryBases: TUniQuery): Integer; Override;
    function fGetPorLinha(): Integer; Override;
    procedure pGravaTintometricoPorTintaTerceiros(qryInsert: TFDQuery;
      fltPreVen: Double; qryTinta: TUniQuery; intParam: Integer = 0); override;

    procedure pAdicionaParamentros(Var DataSet: TFDQuery; qryTinta: TUniQuery;
      fltPreVen: Double; intParam: Integer = 0); Override;
    procedure pSetaParametrosEspecificos(Conexao: TUniConnection); Override;
    procedure pIncluirLogTinSite(Conexao: TUniConnection; strStatus: String); Override;
    procedure pRecalculaFormula(dicRetorno: TDicionario; qryGen: TUniQuery; qryBases: TUniQuery); Override;
    procedure pRetPrecoTintas(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); override;
    procedure pRetPrecosAdicionais(dicRetorno: TDicionario; qryColorantes,
      qryBases: TUniQuery; fltPerAcr: Double); Override;


   //Embalagens
    function fRetEmbalagemLT(): String;
    function fRetEmbalagemGL(): String;
    function fRetEmbalagemLA(): String;
    function fRetEmbalagemTB(): String;
    function fRetEmbalagemBD(): String;
    function fRetEmbalagemCP(): String;
    function fRetEmbalagemSS(): String;
    function fRetEmbalagemSP(): String;
    function fRetEmbalagemSD(): String;
    function fRetProdutoVenda(Conexao: TUniConnection): String;


    procedure pCriaClientEmbalagem(Conexao: TUniConnection);
    procedure pRetTabVendas(Conexao: TUniConnection);
    procedure pPreencheEmbalagens;
    procedure pPreencheArrayEmbalagem;
    procedure Execute; override;



   constructor Create(pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean = False); Override;
   destructor Destroy; Override;

  End;

implementation

{ TExportaTintometricosTerceirosDuxone }

constructor TExportaTintometricosTerceirosDuxone.Create(
  pgbProgresso: TcxProgressBar; strIdePro: String; blnAuto: Boolean);
begin
  inherited;
  strProDux := '';
  pPreencheEmbalagens;
  dicPrecoAdicional := TDicionario.Create();
  stlTabPre := TStringList.Create();
  strAcrMob := fRetValorAcrMobCfgTin();
end;

destructor TExportaTintometricosTerceirosDuxone.Destroy;
begin
  inherited;

  If Assigned(dicPrecoAdicional) Then
    FreeAndNil(dicPrecoAdicional);

  If Assigned(stlTabPre) Then
    FreeAndNil(stlTabPre);
end;

procedure TExportaTintometricosTerceirosDuxone.Execute;
begin
  inherited;
end;

function TExportaTintometricosTerceirosDuxone.fCamposSelect: String;
Var
  intContador: Integer;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    DUX_CODDUX,         ';
  Result := Result + '    DUX_CODOEM,         ';
  Result := Result + '    DUX_LINHA_,         ';
  Result := Result + '    DUX_QUALID,         ';
  Result := Result + '    DUX_ALTERN,         ';
  Result := Result + '    DUX_REGIAO,         ';
  Result := Result + '    DUX_DESCRI,         ';
  Result := Result + '    DUX_MONTAD,         ';
  Result := Result + '    DUX_ANOCOR,         ';
  Result := Result + '    DUX_LITRAG,         ';
  Result := Result + '    DUX_DTACAD,         ';
  Result := Result + '    DUX_CODSEQ,         ';
  Result := Result + '    DUX_CODNFM,         ';
  Result := Result + '    DUX_ACRMOB,         ';
  Result := Result + '    DUX_OBSERV,         ';

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    Result := Result + '    DUX_BASE' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DUX_QTDC' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DUX_QTDD' + fStrZero(intContador, 2) + ',       ';
    Result := Result + '    DUX_TIPB' + fStrZero(intContador, 2) + ',       ';
  End;

  Result := Result + '    DUX_MD5KEY          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    DUX_CADDUX          ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    TRUE                ';
  Result := Result + '  AND DUX_REGIAO = "' + arrLinha[intLinha].strNome + '"   ';
end;

function TExportaTintometricosTerceirosDuxone.fCamposTabela: String;
begin
  Result := '';
  Result := Result + '  CREATE TABLE  '  + fNomeTabela() + '  (         ';
  Result := Result + '    DUX_CODDUX VARCHAR(15),           ';
  Result := Result + '    DUX_CODOEM VARCHAR(40),           ';
  Result := Result + '    DUX_LINHA_ VARCHAR(20),           ';
  Result := Result + '    DUX_QUALID VARCHAR(20),           ';
  Result := Result + '    DUX_ALTERN CHAR(3),               ';
  Result := Result + '    DUX_REGIAO CHAR(2),               ';
  Result := Result + '    DUX_DESCRI VARCHAR(40),           ';
  Result := Result + '    DUX_MONTAD VARCHAR(25),           ';
  Result := Result + '    DUX_OBSERV VARCHAR(255),          ';
  Result := Result + '    DUX_MD5KEY VARCHAR(32),           ';

  Result := Result + '    DUX_CODITE VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_CODDIL VARCHAR(20),           ';
  Result := Result + '    DUX_PORDIL DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRECLT DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECGL DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECLA DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECTB DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECBD DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECCP DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECSS DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECSP DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRECSD DECIMAL(12,4),         ';

  Result := Result + '    DUX_PREDLT DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDGL DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDLA DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDTB DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDBD DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDCP DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDSS DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDSP DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREDSD DECIMAL(12,4),         ';

  Result := Result + '    DUX_PCUCLT DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCGL DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCLA DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCTB DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCBD DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCCP DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCSS DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCSP DECIMAL(12,4),         '; //Preço de Custo Concentrado
  Result := Result + '    DUX_PCUCSD DECIMAL(12,4),         '; //Preço de Custo Concentrado

  Result := Result + '    DUX_PCUDLT DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDGL DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDLA DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDTB DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDBD DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDCP DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDSS DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDSP DECIMAL(12,4),         '; //Preço de Custo Diluido
  Result := Result + '    DUX_PCUDSD DECIMAL(12,4),         '; //Preço de Custo Diluido

  {* PREÇO DE VENDA 1 A 7 - TABELA DE CLIENTES *}

  Result := Result + '    DUX_PRCLT1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLT2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLT3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLT4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLT5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLT6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLT7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDLT1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLT2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLT3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLT4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLT5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLT6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLT7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCGL1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCGL2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCGL3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCGL4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCGL5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCGL6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCGL7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDGL1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDGL2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDGL3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDGL4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDGL5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDGL6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDGL7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCLA1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLA2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLA3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLA4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLA5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLA6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCLA7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDLA1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLA2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLA3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLA4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLA5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLA6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDLA7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCTB1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCTB2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCTB3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCTB4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCTB5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCTB6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCTB7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDTB1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDTB2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDTB3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDTB4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDTB5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDTB6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDTB7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCBD1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCBD2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCBD3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCBD4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCBD5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCBD6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCBD7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDBD1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDBD2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDBD3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDBD4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDBD5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDBD6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDBD7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCCP1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCCP2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCCP3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCCP4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCCP5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCCP6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCCP7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDCP1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDCP2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDCP3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDCP4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDCP5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDCP6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDCP7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCSS1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSS2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSS3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSS4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSS5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSS6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSS7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDSS1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSS2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSS3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSS4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSS5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSS6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSS7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCSP1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSP2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSP3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSP4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSP5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSP6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSP7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDSP1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSP2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSP3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSP4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSP5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSP6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSP7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRCSD1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSD2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSD3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSD4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSD5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSD6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRCSD7 DECIMAL(12,4),         ';

  Result := Result + '    DUX_PRDSD1 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSD2 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSD3 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSD4 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSD5 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSD6 DECIMAL(12,4),         ';
  Result := Result + '    DUX_PRDSD7 DECIMAL(12,4),         ';


  Result := Result + '    DUX_EMBALT VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBAGL VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBALA VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBATB VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBABD VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBACP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBASS VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBASP VARCHAR(' + fTamCodIte.ToString() + '),            ';
  Result := Result + '    DUX_EMBASD VARCHAR(' + fTamCodIte.ToString() + '),            ';


  Result := Result + '    DUX_VOLULT DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUGL DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLULA DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUTB DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUBD DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUCP DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUSS DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUSP DECIMAL(12,4),         ';
  Result := Result + '    DUX_VOLUSD DECIMAL(12,4),         ';

  Result := Result + '    DUX_PREELT DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREEGL DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREELA DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREETB DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREEBD DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREECP DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREESS DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREESP DECIMAL(12,4),         ';
  Result := Result + '    DUX_PREESD DECIMAL(12,4),         ';

  Result := Result + '    DUX_TIPOLT CHAR(2),               ';
  Result := Result + '    DUX_TIPOGL CHAR(2),               ';
  Result := Result + '    DUX_TIPOLA CHAR(2),               ';
  Result := Result + '    DUX_TIPOTB CHAR(2),               ';
  Result := Result + '    DUX_TIPOBD CHAR(2),               ';
  Result := Result + '    DUX_TIPOCP CHAR(2),               ';
  Result := Result + '    DUX_TIPOSS CHAR(2),               ';
  Result := Result + '    DUX_TIPOSP CHAR(2),               ';
  Result := Result + '    DUX_TIPOSD CHAR(2)                ';
  Result := Result + '                );                    ';
end;

function TExportaTintometricosTerceirosDuxone.fFatorTinta: Double;
begin
  Result := 0;
end;

function TExportaTintometricosTerceirosDuxone.fGetPorLinha: Integer;
Var
  qryGen: TUniQuery;
begin
  Try
    SetLength(arrLinha, 0);

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT DISTINCT DUX_REGIAO FROM DUX_CADDUX      ');
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      SetLength(arrLinha, Length(arrLinha) + 1);
      arrLinha[Length(arrLinha) - 1].strNome := qryGen.FieldByName('DUX_REGIAO').AsString;

      qryGen.Next;
    End;

    Result := Length(arrLinha);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDuxone.fGetTipoFormula(qryGen,
  qryBases: TUniQuery): Integer;
Var
  intContador: Integer;
begin
  Result := 0;

  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If fEmptyStr(qryGen.FieldByName('DUX_BASE' + fStrZero(intContador, 2)).AsString) Then
      Break;

    If Not qryBases.Locate('BAS_CODBAS', qryGen.FieldByName('DUX_BASE' + fStrZero(intContador, 2)).AsString, []) Then
    Begin
      Result := 3;
      Break;
    End;
  End;
end;

function TExportaTintometricosTerceirosDuxone.fNomeTabela: String;
begin
  Result := 'DUX_CADDUX_SIT';
end;

function TExportaTintometricosTerceirosDuxone.fQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TExportaTintometricosTerceirosDuxone.fRetDescricao: String;
begin
  Result := 'DUX_DESCRI';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagem(
  qryColorantes: TUniQuery): Double;
begin
  If qryColorantes.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat
  Else
    Result := qryColorantes.FieldByName('BAS_EMBALA').AsFloat * qryColorantes.FieldByName('BAS_PESESP').AsFloat;
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemBD: String;
begin
  Result := 'ITEBAL';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemCP: String;
begin
  Result := 'ITECOP';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemGL: String;
begin
  Result := 'ITEGAL';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemLA: String;
begin
  Result := 'ITELAT';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemLT: String;
begin
  Result := 'ITE1_4';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemSD: String;
begin
  Result := 'ITESDU';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemSP: String;
begin
  Result := 'ITESPO';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemSS: String;
begin
  Result := 'ITESPS';
end;

function TExportaTintometricosTerceirosDuxone.fRetEmbalagemTB: String;
begin
  Result := 'ITETAM';
end;

function TExportaTintometricosTerceirosDuxone.fRetFormula(
  intCont: Integer): String;
begin
  Result := 'DUX_BASE' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosDuxone.fRetItemBase: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosDuxone.fRetMD5KEY: String;
begin
  Result := 'DUX_MD5KEY';
end;

function TExportaTintometricosTerceirosDuxone.fRetornaBases: String;
begin
  Result := '';
  Result := Result + '  SELECT              ';
  Result := Result + '    BAS_CODBAS,       ';
  Result := Result + '    BAS_DESBAS,       ';
  Result := Result + '    BAS_CODITE,       ';
  Result := Result + '    BAS_EMBALA,       ';
  Result := Result + '    BAS_PESESP,       ';
  Result := Result + '    BAS_PESGRA,       ';
  Result := Result + '    ITE_PREVE' + fRetornaTabelaPreco + '  AS ITE_PREVEN,     ';
  Result := Result + '    G.ITE_PRECUS AS PRECUS,       ';
  Result := Result + '    G.ITE_PREVE1 AS PREVE1,       ';
  Result := Result + '    G.ITE_PREVE2 AS PREVE2,       ';
  Result := Result + '    G.ITE_PREVE3 AS PREVE3,       ';
  Result := Result + '    G.ITE_PREVE4 AS PREVE4,       ';
  Result := Result + '    G.ITE_PREVE5 AS PREVE5,       ';
  Result := Result + '    G.ITE_PREVE6 AS PREVE6,       ';
  Result := Result + '    G.ITE_PREVE7 AS PREVE7        ';
  Result := Result + '  FROM                ';
  Result := Result + '    DUX_CADBAS        ';
  Result := Result + '  INNER JOIN CADITE I ON        ';
  Result := Result + '    BAS_CODITE = ITE_CODITE         ';
  Result := Result + '  INNER JOIN ITEGER G ON        ';
  Result := Result + '    I.ITE_CODITE = G.ITE_CODITE     ';
  Result := Result + '  WHERE               ';
  Result := Result + '    G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
end;

function TExportaTintometricosTerceirosDuxone.fRetornaCampoEmbalagem(
  strSigEmb: String; dicRetorno: TDicionario): String;
begin
  Result := '';

  If strSigEmb = 'LT' Then
    Result := fRetEmbalagemLT()
  Else If strSigEmb = 'GL' Then
    Result := fRetEmbalagemGL()
  Else If strSigEmb = 'LA' Then
    Result := fRetEmbalagemLA()
  Else If strSigEmb = 'TB' Then
    Result := fRetEmbalagemTB()
  Else If strSigEmb = 'BD' Then
    Result := fRetEmbalagemBD()
  Else If strSigEmb = 'CP' Then
    Result := fRetEmbalagemCP()
  Else If strSigEmb = 'SS' Then
    Result := fRetEmbalagemSS()
  Else If strSigEMb = 'SP' Then
    Result := fRetEmbalagemSP()
  Else If strSigEmb = 'SD' Then
    Result := fRetEmbalagemSD();
end;

function TExportaTintometricosTerceirosDuxone.fRetornaCodigoDiluente(
  dicRetorno: TDicionario): String;
begin
  Result := IfNull(dicRetorno['coddil'], '');
end;

function TExportaTintometricosTerceirosDuxone.fRetornaColorantes: String;
begin
  Result := '';
end;

function TExportaTintometricosTerceirosDuxone.fRetornaPercentualAcrescimo(
  Conexao: TUniConnection): Double;
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

function TExportaTintometricosTerceirosDuxone.fRetornaPorcentagemDiluente(
  dicRetorno: TDicionario): Double;
begin
  Result := IfNull(dicRetorno['pordil'], 0);
end;

function TExportaTintometricosTerceirosDuxone.fRetProdutoVenda(
  Conexao: TUniConnection): String;
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
    strSQL := strSQL + '    CFG_IDEPRO = "DUX" AND        ';
    strSQL := strSQL + '    CFG_CODCFG = "PRODUX" AND     ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND        ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(QryGen);
  End;
end;

function TExportaTintometricosTerceirosDuxone.fRetQuantidade(
  intCont: Integer): String;
begin
  Result := 'DUX_QTDC' + fStrZero(intCont, 2);
end;

function TExportaTintometricosTerceirosDuxone.fRetTipoCor: String;
begin
  Result := 'DUX_LINHA_';
end;

function TExportaTintometricosTerceirosDuxone.fRetValorAcrMobCfgTin: String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT CFG_VALCFG               ');
    qryGen.SQL.Add('    FROM CFGTIN                  ');
    qryGen.SQL.Add(' WHERE CFG_IDEPRO = "DUX" AND    ');
    qryGen.SQL.Add('       CFG_CODCFG = "ACRMOB" AND ');
    qryGen.SQL.Add('       CFG_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryGen.Open;

    Result := qryGen.FieldByName('CFG_VALCFG').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TExportaTintometricosTerceirosDuxone.fSQLInsert: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO ' + fNomeTabela() +   '   (     ';
  Result := Result + '    DUX_CODDUX,           ';
  Result := Result + '    DUX_CODOEM,           ';
  Result := Result + '    DUX_LINHA_,           ';
  Result := Result + '    DUX_QUALID,           ';
  Result := Result + '    DUX_ALTERN,           ';
  Result := Result + '    DUX_REGIAO,           ';
  Result := Result + '    DUX_DESCRI,           ';
  Result := Result + '    DUX_MONTAD,           ';
  Result := Result + '    DUX_OBSERV,           ';
  Result := Result + '    DUX_MD5KEY,           ';
  Result := Result + '    DUX_CODITE,           ';
  Result := Result + '    DUX_CODDIL,           ';
  Result := Result + '    DUX_PORDIL,           ';

  Result := Result + '    DUX_PRECLT,           ';
  Result := Result + '    DUX_PRECGL,           ';
  Result := Result + '    DUX_PRECLA,           ';
  Result := Result + '    DUX_PRECTB,           ';
  Result := Result + '    DUX_PRECBD,           ';
  Result := Result + '    DUX_PRECCP,           ';
  Result := Result + '    DUX_PRECSS,           ';
  Result := Result + '    DUX_PRECSP,           ';
  Result := Result + '    DUX_PRECSD,           ';

  Result := Result + '    DUX_PREDLT,           ';
  Result := Result + '    DUX_PREDGL,           ';
  Result := Result + '    DUX_PREDLA,           ';
  Result := Result + '    DUX_PREDTB,           ';
  Result := Result + '    DUX_PREDBD,           ';
  Result := Result + '    DUX_PREDCP,           ';
  Result := Result + '    DUX_PREDSS,           ';
  Result := Result + '    DUX_PREDSP,           ';
  Result := Result + '    DUX_PREDSD,           ';

  Result := Result + '    DUX_PCUCLT,           ';
  Result := Result + '    DUX_PCUCGL,           ';
  Result := Result + '    DUX_PCUCLA,           ';
  Result := Result + '    DUX_PCUCTB,           ';
  Result := Result + '    DUX_PCUCBD,           ';
  Result := Result + '    DUX_PCUCCP,           ';
  Result := Result + '    DUX_PCUCSS,           ';
  Result := Result + '    DUX_PCUCSP,           ';
  Result := Result + '    DUX_PCUCSD,           ';

  Result := Result + '    DUX_PCUDLT,           ';
  Result := Result + '    DUX_PCUDGL,           ';
  Result := Result + '    DUX_PCUDLA,           ';
  Result := Result + '    DUX_PCUDTB,           ';
  Result := Result + '    DUX_PCUDBD,           ';
  Result := Result + '    DUX_PCUDCP,           ';
  Result := Result + '    DUX_PCUDSS,           ';
  Result := Result + '    DUX_PCUDSP,           ';
  Result := Result + '    DUX_PCUDSD,           ';

  Result := Result + '    DUX_PRCLT1,           ';
  Result := Result + '    DUX_PRCLT2,           ';
  Result := Result + '    DUX_PRCLT3,           ';
  Result := Result + '    DUX_PRCLT4,           ';
  Result := Result + '    DUX_PRCLT5,           ';
  Result := Result + '    DUX_PRCLT6,           ';
  Result := Result + '    DUX_PRCLT7,           ';

  Result := Result + '    DUX_PRDLT1,           ';
  Result := Result + '    DUX_PRDLT2,           ';
  Result := Result + '    DUX_PRDLT3,           ';
  Result := Result + '    DUX_PRDLT4,           ';
  Result := Result + '    DUX_PRDLT5,           ';
  Result := Result + '    DUX_PRDLT6,           ';
  Result := Result + '    DUX_PRDLT7,           ';

  Result := Result + '    DUX_PRCGL1,           ';
  Result := Result + '    DUX_PRCGL2,           ';
  Result := Result + '    DUX_PRCGL3,           ';
  Result := Result + '    DUX_PRCGL4,           ';
  Result := Result + '    DUX_PRCGL5,           ';
  Result := Result + '    DUX_PRCGL6,           ';
  Result := Result + '    DUX_PRCGL7,           ';

  Result := Result + '    DUX_PRDGL1,           ';
  Result := Result + '    DUX_PRDGL2,           ';
  Result := Result + '    DUX_PRDGL3,           ';
  Result := Result + '    DUX_PRDGL4,           ';
  Result := Result + '    DUX_PRDGL5,           ';
  Result := Result + '    DUX_PRDGL6,           ';
  Result := Result + '    DUX_PRDGL7,           ';

  Result := Result + '    DUX_PRCLA1,           ';
  Result := Result + '    DUX_PRCLA2,           ';
  Result := Result + '    DUX_PRCLA3,           ';
  Result := Result + '    DUX_PRCLA4,           ';
  Result := Result + '    DUX_PRCLA5,           ';
  Result := Result + '    DUX_PRCLA6,           ';
  Result := Result + '    DUX_PRCLA7,           ';

  Result := Result + '    DUX_PRDLA1,           ';
  Result := Result + '    DUX_PRDLA2,           ';
  Result := Result + '    DUX_PRDLA3,           ';
  Result := Result + '    DUX_PRDLA4,           ';
  Result := Result + '    DUX_PRDLA5,           ';
  Result := Result + '    DUX_PRDLA6,           ';
  Result := Result + '    DUX_PRDLA7,           ';

  Result := Result + '    DUX_PRCTB1,           ';
  Result := Result + '    DUX_PRCTB2,           ';
  Result := Result + '    DUX_PRCTB3,           ';
  Result := Result + '    DUX_PRCTB4,           ';
  Result := Result + '    DUX_PRCTB5,           ';
  Result := Result + '    DUX_PRCTB6,           ';
  Result := Result + '    DUX_PRCTB7,           ';

  Result := Result + '    DUX_PRDTB1,           ';
  Result := Result + '    DUX_PRDTB2,           ';
  Result := Result + '    DUX_PRDTB3,           ';
  Result := Result + '    DUX_PRDTB4,           ';
  Result := Result + '    DUX_PRDTB5,           ';
  Result := Result + '    DUX_PRDTB6,           ';
  Result := Result + '    DUX_PRDTB7,           ';

  Result := Result + '    DUX_PRCBD1,           ';
  Result := Result + '    DUX_PRCBD2,           ';
  Result := Result + '    DUX_PRCBD3,           ';
  Result := Result + '    DUX_PRCBD4,           ';
  Result := Result + '    DUX_PRCBD5,           ';
  Result := Result + '    DUX_PRCBD6,           ';
  Result := Result + '    DUX_PRCBD7,           ';

  Result := Result + '    DUX_PRDBD1,           ';
  Result := Result + '    DUX_PRDBD2,           ';
  Result := Result + '    DUX_PRDBD3,           ';
  Result := Result + '    DUX_PRDBD4,           ';
  Result := Result + '    DUX_PRDBD5,           ';
  Result := Result + '    DUX_PRDBD6,           ';
  Result := Result + '    DUX_PRDBD7,           ';

  Result := Result + '    DUX_PRCCP1,           ';
  Result := Result + '    DUX_PRCCP2,           ';
  Result := Result + '    DUX_PRCCP3,           ';
  Result := Result + '    DUX_PRCCP4,           ';
  Result := Result + '    DUX_PRCCP5,           ';
  Result := Result + '    DUX_PRCCP6,           ';
  Result := Result + '    DUX_PRCCP7,           ';

  Result := Result + '    DUX_PRDCP1,           ';
  Result := Result + '    DUX_PRDCP2,           ';
  Result := Result + '    DUX_PRDCP3,           ';
  Result := Result + '    DUX_PRDCP4,           ';
  Result := Result + '    DUX_PRDCP5,           ';
  Result := Result + '    DUX_PRDCP6,           ';
  Result := Result + '    DUX_PRDCP7,           ';

  Result := Result + '    DUX_PRCSS1,           ';
  Result := Result + '    DUX_PRCSS2,           ';
  Result := Result + '    DUX_PRCSS3,           ';
  Result := Result + '    DUX_PRCSS4,           ';
  Result := Result + '    DUX_PRCSS5,           ';
  Result := Result + '    DUX_PRCSS6,           ';
  Result := Result + '    DUX_PRCSS7,           ';

  Result := Result + '    DUX_PRDSS1,           ';
  Result := Result + '    DUX_PRDSS2,           ';
  Result := Result + '    DUX_PRDSS3,           ';
  Result := Result + '    DUX_PRDSS4,           ';
  Result := Result + '    DUX_PRDSS5,           ';
  Result := Result + '    DUX_PRDSS6,           ';
  Result := Result + '    DUX_PRDSS7,           ';

  Result := Result + '    DUX_PRCSP1,           ';
  Result := Result + '    DUX_PRCSP2,           ';
  Result := Result + '    DUX_PRCSP3,           ';
  Result := Result + '    DUX_PRCSP4,           ';
  Result := Result + '    DUX_PRCSP5,           ';
  Result := Result + '    DUX_PRCSP6,           ';
  Result := Result + '    DUX_PRCSP7,           ';

  Result := Result + '    DUX_PRDSP1,           ';
  Result := Result + '    DUX_PRDSP2,           ';
  Result := Result + '    DUX_PRDSP3,           ';
  Result := Result + '    DUX_PRDSP4,           ';
  Result := Result + '    DUX_PRDSP5,           ';
  Result := Result + '    DUX_PRDSP6,           ';
  Result := Result + '    DUX_PRDSP7,           ';

  Result := Result + '    DUX_PRCSD1,           ';
  Result := Result + '    DUX_PRCSD2,           ';
  Result := Result + '    DUX_PRCSD3,           ';
  Result := Result + '    DUX_PRCSD4,           ';
  Result := Result + '    DUX_PRCSD5,           ';
  Result := Result + '    DUX_PRCSD6,           ';
  Result := Result + '    DUX_PRCSD7,           ';

  Result := Result + '    DUX_PRDSD1,           ';
  Result := Result + '    DUX_PRDSD2,           ';
  Result := Result + '    DUX_PRDSD3,           ';
  Result := Result + '    DUX_PRDSD4,           ';
  Result := Result + '    DUX_PRDSD5,           ';
  Result := Result + '    DUX_PRDSD6,           ';
  Result := Result + '    DUX_PRDSD7,           ';

  Result := Result + '    DUX_EMBALT,           ';
  Result := Result + '    DUX_EMBAGL,           ';
  Result := Result + '    DUX_EMBALA,           ';
  Result := Result + '    DUX_EMBATB,           ';
  Result := Result + '    DUX_EMBABD,           ';
  Result := Result + '    DUX_EMBACP,           ';
  Result := Result + '    DUX_EMBASS,           ';
  Result := Result + '    DUX_EMBASP,           ';
  Result := Result + '    DUX_EMBASD,           ';

  Result := Result + '    DUX_VOLULT,           ';
  Result := Result + '    DUX_VOLUGL,           ';
  Result := Result + '    DUX_VOLULA,           ';
  Result := Result + '    DUX_VOLUTB,           ';
  Result := Result + '    DUX_VOLUBD,           ';
  Result := Result + '    DUX_VOLUCP,           ';
  Result := Result + '    DUX_VOLUSS,           ';
  Result := Result + '    DUX_VOLUSP,           ';
  Result := Result + '    DUX_VOLUSD,           ';

  Result := Result + '    DUX_PREELT,           ';
  Result := Result + '    DUX_PREEGL,           ';
  Result := Result + '    DUX_PREELA,           ';
  Result := Result + '    DUX_PREETB,           ';
  Result := Result + '    DUX_PREEBD,           ';
  Result := Result + '    DUX_PREECP,           ';
  Result := Result + '    DUX_PREESS,           ';
  Result := Result + '    DUX_PREESP,           ';
  Result := Result + '    DUX_PREESD,           ';

  Result := Result + '    DUX_TIPOLT,           ';
  Result := Result + '    DUX_TIPOGL,           ';
  Result := Result + '    DUX_TIPOLA,           ';
  Result := Result + '    DUX_TIPOTB,           ';
  Result := Result + '    DUX_TIPOBD,           ';
  Result := Result + '    DUX_TIPOCP,           ';
  Result := Result + '    DUX_TIPOSS,           ';
  Result := Result + '    DUX_TIPOSP,           ';
  Result := Result + '    DUX_TIPOSD            ';
  Result := Result + '        )                 ';
  Result := Result + '  VALUES  ' + ' (         ';
  Result := Result + '    :CODDUX,              ';
  Result := Result + '    :CODOEM,              ';
  Result := Result + '    :LINHA_,              ';
  Result := Result + '    :QUALID,              ';
  Result := Result + '    :ALTERN,              ';
  Result := Result + '    :REGIAO,              ';
  Result := Result + '    :DESCRI,              ';
  Result := Result + '    :MONTAD,              ';
  Result := Result + '    :OBSERV,              ';
  Result := Result + '    :MD5KEY,              ';
  Result := Result + '    :CODITE,              ';
  Result := Result + '    :CODDIL,              ';
  Result := Result + '    :PORDIL,              ';

  Result := Result + '    :PRECLT,              ';
  Result := Result + '    :PRECGL,              ';
  Result := Result + '    :PRECLA,              ';
  Result := Result + '    :PRECTB,              ';
  Result := Result + '    :PRECBD,              ';
  Result := Result + '    :PRECCP,              ';
  Result := Result + '    :PRECSS,              ';
  Result := Result + '    :PRECSP,              ';
  Result := Result + '    :PRECSD,              ';

  Result := Result + '    :PREDLT,              ';
  Result := Result + '    :PREDGL,              ';
  Result := Result + '    :PREDLA,              ';
  Result := Result + '    :PREDTB,              ';
  Result := Result + '    :PREDBD,              ';
  Result := Result + '    :PREDCP,              ';
  Result := Result + '    :PREDSS,              ';
  Result := Result + '    :PREDSP,              ';
  Result := Result + '    :PREDSD,              ';

  Result := Result + '    :PCUCLT,              ';
  Result := Result + '    :PCUCGL,              ';
  Result := Result + '    :PCUCLA,              ';
  Result := Result + '    :PCUCTB,              ';
  Result := Result + '    :PCUCBD,              ';
  Result := Result + '    :PCUCCP,              ';
  Result := Result + '    :PCUCSS,              ';
  Result := Result + '    :PCUCSP,              ';
  Result := Result + '    :PCUCSD,              ';

  Result := Result + '    :PCUDLT,              ';
  Result := Result + '    :PCUDGL,              ';
  Result := Result + '    :PCUDLA,              ';
  Result := Result + '    :PCUDTB,              ';
  Result := Result + '    :PCUDBD,              ';
  Result := Result + '    :PCUDCP,              ';
  Result := Result + '    :PCUDSS,              ';
  Result := Result + '    :PCUDSP,              ';
  Result := Result + '    :PCUDSD,              ';

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


  Result := Result + '    :PRCTB1,              ';
  Result := Result + '    :PRCTB2,              ';
  Result := Result + '    :PRCTB3,              ';
  Result := Result + '    :PRCTB4,              ';
  Result := Result + '    :PRCTB5,              ';
  Result := Result + '    :PRCTB6,              ';
  Result := Result + '    :PRCTB7,              ';

  Result := Result + '    :PRDTB1,              ';
  Result := Result + '    :PRDTB2,              ';
  Result := Result + '    :PRDTB3,              ';
  Result := Result + '    :PRDTB4,              ';
  Result := Result + '    :PRDTB5,              ';
  Result := Result + '    :PRDTB6,              ';
  Result := Result + '    :PRDTB7,              ';

  Result := Result + '    :PRCBD1,              ';
  Result := Result + '    :PRCBD2,              ';
  Result := Result + '    :PRCBD3,              ';
  Result := Result + '    :PRCBD4,              ';
  Result := Result + '    :PRCBD5,              ';
  Result := Result + '    :PRCBD6,              ';
  Result := Result + '    :PRCBD7,              ';

  Result := Result + '    :PRDBD1,              ';
  Result := Result + '    :PRDBD2,              ';
  Result := Result + '    :PRDBD3,              ';
  Result := Result + '    :PRDBD4,              ';
  Result := Result + '    :PRDBD5,              ';
  Result := Result + '    :PRDBD6,              ';
  Result := Result + '    :PRDBD7,              ';

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

  Result := Result + '    :PRCSS1,              ';
  Result := Result + '    :PRCSS2,              ';
  Result := Result + '    :PRCSS3,              ';
  Result := Result + '    :PRCSS4,              ';
  Result := Result + '    :PRCSS5,              ';
  Result := Result + '    :PRCSS6,              ';
  Result := Result + '    :PRCSS7,              ';

  Result := Result + '    :PRDSS1,              ';
  Result := Result + '    :PRDSS2,              ';
  Result := Result + '    :PRDSS3,              ';
  Result := Result + '    :PRDSS4,              ';
  Result := Result + '    :PRDSS5,              ';
  Result := Result + '    :PRDSS6,              ';
  Result := Result + '    :PRDSS7,              ';

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

  Result := Result + '    :PRCSD1,              ';
  Result := Result + '    :PRCSD2,              ';
  Result := Result + '    :PRCSD3,              ';
  Result := Result + '    :PRCSD4,              ';
  Result := Result + '    :PRCSD5,              ';
  Result := Result + '    :PRCSD6,              ';
  Result := Result + '    :PRCSD7,              ';

  Result := Result + '    :PRDSD1,              ';
  Result := Result + '    :PRDSD2,              ';
  Result := Result + '    :PRDSD3,              ';
  Result := Result + '    :PRDSD4,              ';
  Result := Result + '    :PRDSD5,              ';
  Result := Result + '    :PRDSD6,              ';
  Result := Result + '    :PRDSD7,              ';

  Result := Result + '    :EMBALT,              ';
  Result := Result + '    :EMBAGL,              ';
  Result := Result + '    :EMBALA,              ';
  Result := Result + '    :EMBATB,              ';
  Result := Result + '    :EMBABD,              ';
  Result := Result + '    :EMBACP,              ';
  Result := Result + '    :EMBASS,              ';
  Result := Result + '    :EMBASP,              ';
  Result := Result + '    :EMBASD,              ';

  Result := Result + '    :VOLULT,              ';
  Result := Result + '    :VOLUGL,              ';
  Result := Result + '    :VOLULA,              ';
  Result := Result + '    :VOLUTB,              ';
  Result := Result + '    :VOLUBD,              ';
  Result := Result + '    :VOLUCP,              ';
  Result := Result + '    :VOLUSS,              ';
  Result := Result + '    :VOLUSP,              ';
  Result := Result + '    :VOLUSD,              ';

  Result := Result + '    :PREELT,              ';
  Result := Result + '    :PREEGL,              ';
  Result := Result + '    :PREELA,              ';
  Result := Result + '    :PREETB,              ';
  Result := Result + '    :PREEBD,              ';
  Result := Result + '    :PREECP,              ';
  Result := Result + '    :PREESS,              ';
  Result := Result + '    :PREESP,              ';
  Result := Result + '    :PREESD,              ';

  Result := Result + '    :TIPOLT,              ';
  Result := Result + '    :TIPOGL,              ';
  Result := Result + '    :TIPOLA,              ';
  Result := Result + '    :TIPOTB,              ';
  Result := Result + '    :TIPOBD,              ';
  Result := Result + '    :TIPOCP,              ';
  Result := Result + '    :TIPOSS,              ';
  Result := Result + '    :TIPOSP,              ';
  Result := Result + '    :TIPOSD               ';
  Result := Result + '        );                ';

end;

function TExportaTintometricosTerceirosDuxone.fValorQuantidade(fltValor,
  fltAcrMob: Double): Double;
begin
  If fltValor <= 0 Then
    Result := 0
  Else
    Result := fltValor + fltAcrMob;
end;

procedure TExportaTintometricosTerceirosDuxone.pAdicionaParamentros(
  var DataSet: TFDQuery; qryTinta: TUniQuery; fltPreVen: Double; intParam: Integer = 0);
Var
  intContador: Integer;
  intEmb: Integer;
begin
  DataSet.ParamByName('CODDUX').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_CODDUX').AsString);
  DataSet.ParamByName('CODOEM').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_CODOEM').AsString);
  DataSet.ParamByName('QUALID').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_QUALID').AsString);
  DataSet.ParamByName('LINHA_').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_LINHA_').AsString);
  DataSet.ParamByName('ALTERN').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_ALTERN').AsString);
  DataSet.ParamByName('REGIAO').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_REGIAO').AsString);
  DataSet.ParamByName('DESCRI').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_DESCRI').AsString);
  DataSet.ParamByName('MONTAD').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_MONTAD').AsString);
  DataSet.ParamByName('OBSERV').AsStrings[intParam] := fRemoveAcento(qryTinta.FieldByName('DUX_OBSERV').AsString);
  DataSet.ParamByName('MD5KEY').AsStrings[intParam] := qryTinta.FieldByName('DUX_MD5KEY').AsString;
  DataSet.ParamByName('CODITE').AsStrings[intParam] := strProDux;
  DataSet.ParamByName('PCUCLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLT'], 0.0);
  DataSet.ParamByName('PCUCGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONGL'], 0.0);
  DataSet.ParamByName('PCUCLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONLA'], 0.0);
  DataSet.ParamByName('PCUCTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONTB'], 0.0);
  DataSet.ParamByName('PCUCBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONBD'], 0.0);
  DataSet.ParamByName('PCUCCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONCP'], 0.0);
  DataSet.ParamByName('PCUCSS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSS'], 0.0);
  DataSet.ParamByName('PCUCSP').AsFloats[intParam] := IfNull(dicPrecoAdicional['PRECUS_CONSP'], 0.0);
  DataSet.ParamByName('PCUCSD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_CONSD'], 0.0);
  DataSet.ParamByName('PCUDLT').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLT'], 0.0);
  DataSet.ParamByName('PCUDGL').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILGL'], 0.0);
  DataSet.ParamByName('PCUDLA').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILLA'], 0.0);
  DataSet.ParamByName('PCUDTB').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILTB'], 0.0);
  DataSet.ParamByName('PCUDBD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILBD'], 0.0);
  DataSet.ParamByName('PCUDCP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILCP'], 0.0);
  DataSet.ParamByName('PCUDSS').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSS'], 0.0);
  DataSet.ParamByName('PCUDSP').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSP'], 0.0);
  DataSet.ParamByName('PCUDSD').AsFloats[intParam]  := IfNull(dicPrecoAdicional['PRECUS_DILSD'], 0.0);

  For intEmb := 0 To Length(arrEmbalagens) - 1 Do
  Begin
    If strAcrMob = '1' Then
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := arrPrecosPorEmb[intEmb].fltValCon * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
      arrPrecosPorEmb[intEmb].fltValDil := arrPrecosPorEmb[intEmb].fltValDil * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
    End
    Else
    Begin
      arrPrecosPorEmb[intEmb].fltValCon := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValCon, qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
      arrPrecosPorEmb[intEmb].fltValDil := fValorQuantidade(arrPrecosPorEmb[intEmb].fltValDil, qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
    End;
  End;

  For intContador := 1 To 7 Do
  Begin
    If stlTabPre[intContador] <> 'S' Then
    Begin
      DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0);
      DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0);
      DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0);
      DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0);
      DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0);
      DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0);
      DataSet.ParamByName('PRCSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSS'], 0.0);
      DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0);
      DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0);
      DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0);
      DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0);
      DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0);
      DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0);
      DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0);
      DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0);
      DataSet.ParamByName('PRDSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSS'], 0.0);
      DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0);
      DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0);
    End
    Else
    Begin
      If strAcrMob = '1' Then
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSS'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam]:= IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSS' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSS'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
        DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0) * (1 + qryTinta.FieldByName('DUX_ACRMOB').AsFloat / 100);
      End
      Else
      Begin
        DataSet.ParamByName('PRCLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLT'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONGL'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONLA'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONTB'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONBD'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONCP'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSS' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSS'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSP'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRCSD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_CONSD'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLT' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLT'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDGL' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILGL'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDLA' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILLA'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDTB' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILTB'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDBD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILBD'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDCP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILCP'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSS' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSS'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSP' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSP'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
        DataSet.ParamByName('PRDSD' + IntToStr(intContador)).AsFloats[intParam] := fValorQuantidade(IfNull(dicPrecoAdicional['PREVE' + IntToStr(intContador) + '_DILSD'], 0.0), qryTinta.FieldByName('DUX_ACRMOB').AsFloat);
      End;
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDuxone.pCriaClientEmbalagem(
  Conexao: TUniConnection);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT          ';
    strSQL := strSQL + '    *             ';
    strSQL := strSQL + '  FROM            ';
    strSQL := strSQL + '    CFGTIN        ';
    strSQL := strSQL + '  WHERE           ';
    strSQL := strSQL + '    CFG_IDEPRO = "DUX" AND      ';
    strSQL := strSQL + '    CFG_GRUCFG = "CONFIGURACOES" AND      ';
    strSQL := strSQL + '    CFG_CODEMP = ' + QuotedStr(VS_strCodEmp);

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

procedure TExportaTintometricosTerceirosDuxone.pGravaTintometricoPorTintaTerceiros(
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

procedure TExportaTintometricosTerceirosDuxone.pIncluirLogTinSite(
  Conexao: TUniConnection; strStatus: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  DELETE FROM LOGTIN_SIT WHERE LOG_IDEPRO = "DUX"   ';

    qryGen := fCriaQuery(Nil, Conexao);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ExecSQL;

    strSQL := '';
    strSQL := strSQL + '  INSERT INTO LOGTIN_SIT  (       ';
    strSQL := strSQL + '    LOG_IDEPRO,           ';
    strSQL := strSQL + '    LOG_DTAEXE,           ';
    strSQL := strSQL + '    LOG_HOREXE,           ';
    strSQL := strSQL + '    LOG_EXECUT            ';
    strSQL := strSQL + '        )                         ';
    strSQL := strSQL + '    VALUES    (                   ';
    strSQL := strSQL + '    "DUX",                ';
    strSQL := strSQL + '    :DTAEXE,              ';
    strSQL := strSQL + '    :HOREXE,              ';
    strSQL := strSQL + '    :EXECUT               ';
    strSQL := strSQL + '        );                        ';

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

procedure TExportaTintometricosTerceirosDuxone.pPreencheArrayEmbalagem;
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

  //Balde
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Balde';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'BD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 18.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Tambor
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Tambor';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'TB';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 196.000;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Copo
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Copo';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'CP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.500;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Sintetico
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Sintetico';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SS';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Poliester
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Poliester';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SP';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
  SetLength(arrEmbalagens, Length(arrEmbalagens) + 1);

  //Spray Duco
  arrEmbalagens[Length(arrEmbalagens) - 1].strNomEmb := 'Spray Duco';
  arrEmbalagens[Length(arrEmbalagens) - 1].strSigEmb := 'SD';
  arrEmbalagens[Length(arrEmbalagens) - 1].fltVolume := 0.150;
end;

procedure TExportaTintometricosTerceirosDuxone.pPreencheEmbalagens;
begin
  pPreencheArrayEmbalagem;
end;

procedure TExportaTintometricosTerceirosDuxone.pProcessaTabelaCores(
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
        For intEmb := 0 To 4 Do
        Begin
          If qryGen.FieldByName('DUX_QTDC01').AsFloat > 0 Then
            pValidarPrecoExportacao(qryGen.FieldByName(fRetMD5KEY).AsString,
                     arrEmbalagens[intEmb].strNomEmb, 'C', arrEmbalagens[intEmb].strSigEmb,
                     arrPrecosPorEmb[intEmb].fltValCon, dicPrecoAdicional, '_CON');

          If qryGen.FieldByName('DUX_QTDD01').AsFloat > 0 Then
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

procedure TExportaTintometricosTerceirosDuxone.pRecalculaFormula(
  dicRetorno: TDicionario; qryGen, qryBases: TUniQuery);
Var
  intContador: Integer;
begin
  inherited;
  //Preenchendo as quantidades da formula
  For intContador := 1 To fQuantidadeFormulacao() Do
  Begin
    If  fEmptyStr(qryGen.FieldByName(fRetFormula(intContador)).AsString) Then
      Break;

    dicRetorno['base' + fStrZero(intContador, 2)] := qryGen.FieldByName(fRetFormula(intContador)).AsString;

    If fEmptyStr(qryGen.FieldByName('DUX_CODNFM').AsString) Then
    Begin
      dicRetorno['Nfm'] := 'N';
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := RoundTo(qryGen.FieldByName('DUX_QTDC' + fStrZero(intContador, 2)).AsFloat, -1);
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := RoundTo(qryGen.FieldByName('DUX_QTDD' + fStrZero(intContador, 2)).AsFloat, -1);
    End
    Else
    Begin
      dicRetorno['Nfm'] := 'S';
      dicRetorno['qtdb' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUX_QTDC' + fStrZero(intContador, 2)).AsFloat;
      dicRetorno['qtdd' + fStrZero(intContador, 2)] := qryGen.FieldByName('DUX_QTDD' + fStrZero(intContador, 2)).AsFloat;
    End;
  End;

  dicRetorno['VolumeOri'] := qryGen.FieldByName('DUX_LITRAG').AsFloat / 1000;
end;

procedure TExportaTintometricosTerceirosDuxone.pRetPrecosAdicionais(
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

        If dicRetorno['Nfm'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := (dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']);
          ArrComponentes[intContador].Quantiddil := (IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := RoundTo(fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri'], 2), -1);
          ArrComponentes[intContador].Quantiddil := RoundTo(fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri'], 2), -1);
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
            fltPrecoEmbalagem := fSelecionaPrecoVendaEmbalagemTabClientes(
            cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr, intPreVen);
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

      //Calcula o Preço de Custo
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

        //Preco de custo concentrado
        fltQuantCon := ArrComponentes[intContador].Quantidade;
        fltPrecoCustoCon := fltQuantCon * (fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon + fltPrecoCustoCon;

        fltQuantDil := ArrComponentes[intContador].Quantiddil;
        fltPrecoCustoDil := fltQuantDil * (fltPrecoBase / fltEmbala);
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil + fltPrecoCustoDil;
      End;

      //Retorna preco da embalagem
      If cdsEmbalagens.Locate('CFG_CODCFG', strCamEmb, []) Then
      Begin
        If fCarregaPromocao(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString,
          strTabelaUnica, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          fltPrecoEmbalagem := fltPreCusPro + (fltPerAcr * fltPreCusPro)
        Else
          fltPrecoEmbalagem := fSelecionaPrecoCustoEmbalagem(cdsEmbalagens.FieldByName('CFG_VALCFG').AsString, fltPerAcr);
      End;

      If fltPrecoCustoTotalCon > 0 Then
        fltPrecoCustoTotalCon := fltPrecoCustoTotalCon +
          (fltPerAcr * fltPrecoCustoTotalCon) + fltPrecoEmbalagem;

      If fltPrecoCustoTotalDil > 0 Then
        fltPrecoCustoTotalDil := fltPrecoCustoTotalDil +
          (fltPerAcr * fltPrecoCustoTotalDil) + fltPrecoEmbalagem;

      dicPrecoAdicional['PRECUS_CON' + strEmb] := fltPrecoCustoTotalCon;
      dicPrecoAdicional['PRECUS_DIL' + strEmb] := fltPrecoCustoTotalDil;
    Finally
      SetLength(ArrComponentes, 0);
    End;
  End;
end;

procedure TExportaTintometricosTerceirosDuxone.pRetPrecoTintas(
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

        If dicRetorno['Nfm'] = 'S' Then
        Begin
          ArrComponentes[intContador].Quantidade := (dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']);
          ArrComponentes[intContador].Quantiddil := (IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri']);
        End
        Else
        Begin
          ArrComponentes[intContador].Quantidade := RoundTo(fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri'], 2), -1);
          ArrComponentes[intContador].Quantiddil := RoundTo(fFormataFloat(IfNull(dicRetorno['qtdd' + fStrZero(intContador, 2)], 0) * arrEmbalagens[intEmb].fltVolume / dicRetorno['VolumeOri'], 2), -1);
        End;
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

procedure TExportaTintometricosTerceirosDuxone.pRetTabVendas(
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

procedure TExportaTintometricosTerceirosDuxone.pSetaParametrosEspecificos(
  Conexao: TUniConnection);
begin
  strProDux := fRetProdutoVenda(Conexao);
  pCriaClientEmbalagem(Conexao);
  pRetTabVendas(Conexao);
end;

end.
