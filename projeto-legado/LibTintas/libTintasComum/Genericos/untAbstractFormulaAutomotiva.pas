{******************************************************************************}
{* Classe abstrata que implementa o básico de todas as formulas automotivas.  *}
{***************************************************************************AC*}
unit untAbstractFormulaAutomotiva;

interface

uses
{$IFNDEF LINUX}
  EditFocus,
  ComCtrls,
{$ENDIF}



  untAbstractFormula, untIDataSet, Classes, SysUtils, untICalculadorFormulaAutomotiva,
  untBaseAutomotiva, untIDicionario, Variants, untISaldosColorantes, untFloatUtils,
  untVariantUtils, untStrUtils, untGenericTintaDeMaquina,
  untITintaDeMaquinaComponente,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo, untTipoCadastro,
  untTipoEmbalagem, untModoVenda, untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva,
  Math, untICalculadorFatVendasLibTintas, untIConfTinta, untAbstractTintaSQLServer;

Type
  TEmbalagemMudouEvent = procedure (strCodEmb: String) of object;

type
  TAbstractFormulaAutomotiva = class abstract (TAbstractFormula)
  private
    FEmbalagemMudou: TEmbalagemMudouEvent;

    blnConsiderarEmbalagem: Boolean;
    blnComCatalisador: Boolean;
    blnPerfomanceAgent: Boolean;

    fltEmbPrecoCusto: Double;
    fltEmbPrecoCustoReal: Double;
    fltEmbPrecoVenda: Double;

    fltEmbOutrosValores: Double;
    fltEmbIcmsSaida: Double;
    fltEmbImpostosFederais: Double;
    fltEmbDespesasOperacionais: Double;

    fltEmbPrecoMedio: Double;
    fltEmbPrecoUltimaCompra: Double;
    fltEmbPrecoUltimaCompraImpostos: Double;
    fltEmbPrecoCompraLiquido: Double;

    fltChaPrecoCusto: Double;
    fltChaPrecoCustoReal: Double;
    fltChaPrecoVenda: Double;
    fltChaOutrosValores: Double;
    fltChaIcmsSaida: Double;
    fltChaImpostosFederais: Double;
    fltChaDespesasOperacionais: Double;
    fltChaPrecoMedio: Double;
    fltChaPrecoUltimaCompra: Double;
    fltChaPrecoUltimaCompraImpostos: Double;
    fltChaPrecoCompraLiquido: Double;

    dataSetBases: IDataSet;
    dataSetBasesPorEmpresa: IDataSet;

    strDescricao: String;

    strPromoc: String;

    function GetAcertoValor: Boolean;
    function GetTemConcentrado: Boolean;
    function fTabPreco: String;


    procedure SetCodEmb(const Value: String);

    {Movido para o "public" devido a necessidade de chamadas externas com parâmetro}
    //procedure pCarregaPrecoPromocaoEmbalagem;

    procedure pZerarEmbalagens;
    Procedure pZerarChapinha;

  private
    fltOutrosValoresCon: Double;
    fltIcmsSaidaCon: Double;
    fltImpostosFederaisCon: Double;
    fltDespesasOperacionaisCon: Double;
    fltPrecoCustoCon: Double;
    fltPrecoCustoRealCon: Double;
    fltPrecoVendaCon: Double;
    fltPrecoMedioCon: Double;
    fltUltimoPrecoCompraCon: Double;
    fltUltimoPrecoCompraImpostosCon: Double;
    fltPrecoCompraLiquidoCon: Double;

    fltOutrosValoresDil: Double;
    fltIcmsSaidaDil: Double;
    fltImpostosFederaisDil: Double;
    fltDespesasOperacionaisDil: Double;
    fltPrecoCustoDil: Double;
    fltPrecoCustoRealDil: Double;
    fltPrecoVendaDil: Double;
    fltPrecoMedioDil: Double;
    fltUltimoPrecoCompraDil: Double;
    fltUltimoPrecoCompraImpostosDil: Double;
    fltPrecoCompraLiquidoDil: Double;

//    function GetVolumeConcentrado: Double;
//    function GetVolumeDiluido: Double;
  protected
    calculador: ICalculadorFormulaAutomotiva;
    FBlnCalculaUnitario: Boolean;

    strCodEmb: String;
    strCodCha: String;
    FTipoEmb: TTipoEmbalagem;

    fltVolumeOri: Double;
    fltVolumePorcDiluente: Double;
    fltVolumePro: Double;
    fltVolumeDiluido: Double;
    fltVolumeConcentrado: Double;
    FModoVenda: TModoVenda;

    {Maza Autom. Peso Cor / Peso Fórmula / Baixa Quantidade Digitada}
    fltPesCor : Double;
    fltPesFor : Double;
    strBaiQdi : String;

    blnUsaChapinha: Boolean;



    //Dados Adicionais
    blnDadosAdicionais: Boolean;
    strCaptionAdicional: String;
    stlListaAdicional: TStringList;
    stlListaDiluentes: TStringList;
    blnAdicionalConcentrado: Boolean; // Se os dados adicionais aparecem no modo concentrado
    blnAdicionalDiluido: Boolean; // Se os dados adicionais aparecem no modo diluido
    intIndiceAdicional: Integer;

    //Dados Catalizador
    intIndiceCatalizador: Integer;
    strCaptionCatalizador: String;
    stlListaCatalizador: TStringList;
    blnDadosCatalizador: Boolean;


    blnMostrarEmbalagem : Boolean;
    FErroIntegracao: Boolean;
    tintaSQLServer: TAbstractTintaSQLServer;

    strCodFormul: String;
    fltFatorAcerto: Double;
    strOprFlj: String;
    strEmpPrd: String;
    strEmpCd: String;
    strCD_S_N: String;
    strEmpFat: String;
    strFatS_N: String;

    strBaseQtdZerada: String; //Base com a quantidade zerada liberada por senha

    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLa: TStringList;

    strSistema : String;
    strProEmbCo: String; // Copo
    strProEmbSp: String; // Spray
    strProEmbTb: String; // Tambor
    strProEmbLa: String; // Lata
    strProEmbBa: String; // Balde
    strProEmbSs: String; // Spray Sintético
    strProEmbPo: String; // Spray Poliester
    strProEmbSd: String; // Spray Duco



    fltVolumePadraoSpray: Double;

    //Acrescimo mao de obra novas formulas
    fltAcrMob: Double;

    fltPorDil: Double;   // Valor da Porcentagem de Diluição
    strCodDil: String;  // Valor da String Diluente
    blnEdtDil: Boolean;  // Se ficará visivel o valor Porcentagem de Diluição
    blnHabDil: Boolean; // Trava do campo de Porcentagem de Diluição
    fltPorPer: Double; // Valor da Porcentagem Perfomance Agent
    blnRecarregarBases: Boolean; // Verifica se deve carregar as Bases SQLServer {Salcomix e Glasurit};
    blnResina325: Boolean;
    fltPesoEspecificoProduto: Double; //Variavel criado para identificar o peso especifico do Produto (Killing Industrial)
    strModVen: String;

  {$IFDEF LINUX}
    strCodDilLinux: String;
  {$ENDIF}

    strLinhaDiluido:String;
    strLinhaResina325:String;
    function fBaseDiluente(Base: TBaseAutomotiva) :Boolean;

    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; virtual; abstract;
    function fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double; virtual;

  protected
    function GetOutrosValores(): Double; override;
    function GetIcmsSaida(): Double; override;
    function GetImpostosFederais(): Double; override;
    function GetDespesasOperacionais(): Double; override;

    function GetPrecoMedio(): Double; override;
    function GetUltimoPrecoCompra(): Double; override;
    function GetUltimoPrecoCompraImpostos(): Double; override;
    function GetPrecoCompraLiquido(): Double; override;

    function GetPrecoCusto(): Double; override;
    function GetPrecoCustoReal(): Double; override;
    function GetPrecoVenda(): Double; override;

    function GetOutrosValoresCon(): Double;
    function GetIcmsSaidaCon(): Double;
    function GetImpostosFederaisCon(): Double;
    function GetDespesasOperacionaisCon(): Double;

    function GetPrecoMedioCon(): Double;
    function GetUltimoPrecoCompraCon(): Double;
    function GetUltimoPrecoCompraImpostosCon(): Double;
    function GetPrecoCompraLiquidoCon(): Double;

    function GetPrecoCustoCon(): Double;
    function GetPrecoCustoRealCon(): Double;
    function GetPrecoVendaCon(): Double;

    function GetOutrosValoresDil(): Double;
    function GetIcmsSaidaDil(): Double;
    function GetImpostosFederaisDil(): Double;
    function GetDespesasOperacionaisDil(): Double;

    function GetPrecoMedioDil(): Double;
    function GetUltimoPrecoCompraDil(): Double;
    function GetUltimoPrecoCompraImpostosDil(): Double;
    function GetPrecoCompraLiquidoDil(): Double;

    function GetPrecoCustoDil(): Double;
    function GetPrecoCustoRealDil(): Double;
    function GetPrecoVendaDil(): Double;
  protected
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const base: TBaseAutomotiva); virtual;
    function GetDataSetBases(): IDataSet;
    function GetDataSetBasesPorEmpresa(): IDataSet;
    function GetNomeTabelaBases(): String; virtual; abstract;
    function GetSelectBases(): String; virtual; abstract;
    function GetNomeCampoCustoBase: String; virtual; abstract;
    function GetNomeCampoVendaBase: String; virtual; abstract;
    function GetNomeCampoBaseCodIte: String; virtual;
    function GetBasesPorEmpresa(const dicRetorno: IDicionario): String; virtual;
    function GetBasPesGra(const dataSetBases: IDataSet): String; virtual;
  public

    procedure pCarregaPrecoPromocaoEmbalagem(strTabPre_ : String = ''; strOpcDoc : String = '');
    procedure pCarregaPrecoChapinha(strTabPre_: String = ''; strOpcDoc: String = '');
    function GetTemDiluido: Boolean; Virtual;

    procedure CarregarBases(const dicRetorno: IDicionario); virtual;
    procedure CarregarBasesPorEmpresa(const dicRetorno: IDicionario); virtual;
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Virtual;
    function GetProdutoChapinha(): String; Virtual;

    procedure RecalcularTabelas(dicRetorno: IDicionario); override;
    procedure RecalcularTabelasGeneric(dicRetorno: IDicionario); Virtual;
    function fRetornaTabelaBaseTinta(): String; virtual;
    procedure PreencheVolumeVenda(const dtsCadTin: IDataSet); virtual; abstract;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); virtual; abstract;

    function GetCodFormul(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetIndEmb(const dtsCadTin: IDataSet): integer; virtual; abstract;
    function GetProdutoVendaTinta(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetMontadora(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetAno(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetAcrescimoDespesaOperacionalTinta: Double; virtual; abstract;
    function GetPrefixoLitragem(const strModo: String): String; virtual; abstract;
    function GetUniversal(const dtsCadTin: IDataSet): string; virtual; abstract;
    function GetLinha(const dtsCadTin: IDataSet): string; virtual;
    function fDefiniTamTelaFormulacao(): Integer; Virtual;
    function fRetornaDiluente(strDiluente: String): String; Virtual;

    function fRetCampoTabelaPrecoTE(strCfgSis : String) : String;
    function fVerificaEmpresaSetada(): String; Virtual;
    function fHabilitaRdgModoVenda(const dtsCadTin: IDataSet; blnDiluido, blnConcentrado: Boolean): Boolean; Virtual;
    function fOpcaoRdgMovoVenda(const dtsCadTin: IDataSet; blnConcentrado: Boolean): Integer; Virtual;
    function fSprayVendaConcentrado(const dtsCadTin: IDataSet; ItemIndex: Integer): Integer; Virtual;
    function fOutrasEmbalagens(const dtsCadTin: IDataSet; ItemIndex: Integer): Integer; Virtual;


    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; virtual;
    procedure pCalcularDiluente(const strCodDil: string; const fltPorDil: Double; const dtsCadTin: IDataSet); virtual;

    function fGetCatalizador(const dtsCadTin: IDataSet): TStringList; virtual;
    function fCaptionCheckBinder(): String; Virtual;
    function fLeftPercentualBinder(): Integer; Virtual;
    function fLeftListaBinder(): Integer; Virtual;
    function fAumentarCampoDiluente(): Boolean; Virtual;
    function fUtilizaBlinder(): Boolean; Virtual;
    function fUtilizarPorcentagemAgentePerformance(AVisible: Boolean): Boolean; Virtual;
    function fVisibleBinder(const dtsCadTin: IDataSet): Boolean; Virtual;

    function fPossuiConexaoSQLServer(): Boolean; Virtual; //Salcomix e Glasurit
    function fModoIntegracaoSistema(): Boolean; Virtual; //Salcomix e Glasurit
    function GetLinhaFormulacao(const dtsCadTin: IDataSet): String; Virtual;
    function NomeTinta():String; virtual;
    procedure GetLinhaFormula(); virtual;
    procedure pCarregarBasesSQLServerCasoNecessario;  // Salcomix e Glasurit
    procedure pCarregarBasesSQLServer; virtual;
    procedure pConectarSQLServer(strIdCor:String; strLinha:String); virtual; // Salcomix e Glasurit
    function GetTintaSQLServer(strIdCor:String; strLInha:String): TAbstractTintaSQLServer; virtual;


    procedure PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet); virtual; abstract;
    procedure pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet); virtual; abstract;
    function GetVolumePermitido(const dtsCadTin: IDataSet; strTipoPre: String):Double; virtual; abstract;

    function fDefine4Por1: Boolean; virtual;
    function fDefinirPadraoDiluido: Boolean; virtual;

    function fRetQtdDiluente(strCodDil: String; strPercentual:String = '0' ): Double; virtual;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); virtual;
    procedure pReformulaNovoCatalizador(strCodCat: String; const dtsCadTin: IDataSet = Nil); Virtual;
    procedure pCalculaBaseAdicional(strPercentual: String = '20'; const dtsCadTin: IDataSet = Nil; strBaseAdicional: String = ''); Virtual;
    function SetItemIndexLinuxDiluente(const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer; Virtual;
    function fRetDiluente(strLinha: String): String; Virtual;


    //É utilizada somente para as tintas onde a quantidade mostrada é diferente da quantidade da formulacao
    procedure PreencheQuantidadeFormulacaoVendaEsp(const dtsCadTin: IDataSet); virtual;

    function GetVolumePadraSpray : Double; virtual; abstract;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; virtual; abstract;
    function GetVolumePadraCopo : Double;  virtual; abstract;
    function GetVolumePadraoSpraySint : Double;  virtual;
    function GetVolumePadraoSprayDuco : Double; virtual;
    function GetVolumePadraoSprayPoli : Double; virtual;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  virtual;
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; Virtual;


    //***************************
    //Volumes Maximo (Embalagem)/
    //*************************RG
    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoSpraySint(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoSprayPoli(dtsCadTin: IDataSet): Double; Virtual;
    function GetVolumeMaximoSprayDuco(dtsCadTin: IDataSet): Double; Virtual;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Virtual;
    function fBloqueiaTipoEmbalagem(): Boolean; Virtual;

    function fGetCamada(dtsCadTin: IDataSet): String; Virtual;


    function fValidaVolumeFormulucao(strTipoPre: String; const dtsCadTin: IDataSet): Boolean; virtual; abstract;
    function GetDescricaoBase(strCodBas: String): String; virtual; abstract;
    procedure pDefineVolumeOriginal; virtual; abstract;
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet = Nil); Virtual;
    procedure pAtuPorcentagemBlinder(const Formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet = Nil); Virtual;


    procedure pPreencheListaAdicionalBases; virtual;

    function GetCalcOutrosValores(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcPrecoMedio(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcImpostosFederais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcDespesasOperacionais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcPrecoCusto(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcPrecoCustoReal(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;
    function GetCalcPrecoVenda(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;

    //Utilizado somente calculador da tinta de maquina
    function GetCalcQuantidade(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; virtual; abstract;

    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); virtual; abstract;
    procedure pPreencherBaixaQtdDig(const dtsCadTin: IDataSet); Virtual;

    procedure CarregaPrecosBases; virtual;
    procedure CarregaPrecosBasesPorEmpresa; virtual;

    procedure CalcularPrecos; override;
    function GetCalculador(): ICalculadorFormulaAutomotiva;
    function GetSaldos: ISaldosColorantes; virtual;
    procedure pCalculaImpostosSaida(Var dicRetorno: IDicionario); Virtual;
    procedure AcertaImpostos(const fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Extended; dicRetorno: IDicionario); Virtual;
    function GetChaForEspecifico(const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String; virtual;


    function GetQualidade(const dtsCadTin: IDataSet): String; virtual;
    function GetChaFor(const dtsCadTin: IDataSet): String; virtual;
    function fTipoEmbalagem(intIndEmb: Integer; strQualid: String): Boolean; virtual;
    function fMostrarComCatalisador: Boolean; virtual; abstract;
    function fMostrarCatalizadorNv(const dtsCadTin: IDataSet): Boolean; Virtual;

    function fMostrarDil2: Boolean; virtual;
    function fConsiderarLinhaDesBas: Boolean; virtual;

    function fPorcentagemDiluicao(blnMostrar : Boolean = false) : Boolean; virtual;

    function fQuantidadeMenorIgualZero: Boolean; virtual;
    function fVolumeOriginalFator: Boolean; virtual;

    function fRetornaCatalisadorVenda(blnComCat: Boolean; strTipPre, strListaAdicional: String): String; virtual;

    function fPreencheCatalisadorNovo(): Boolean; Virtual;
    function fRetornaCatalisadorNovo(dtsCadTin: IDataSet): String; Virtual;

  {$IFNDEF LINUX}
    procedure pModoVendaClick(Var edtVolume: TEditFocus; intModoVenda, intListaAdic: Integer); virtual;
  {$ENDIF}
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; virtual;

    function fVolumeMaximoSpraySint(fltVolumeMaximoSpraySint: Double): Double; virtual;
    function fEncontrouNoCadastroDeBases(Base: TBaseAutomotiva): Boolean; virtual;

    function fCalculoA(Formula: TAbstractFormulaAutomotiva;
      strConDil: String; idxBase: Integer; strLinha: String): Double; virtual;
    function fCalculoB(Formula: TAbstractFormulaAutomotiva;
      strConDil: String; idxBase: Integer; strLinha: String): Double; virtual;
    function fCalculoBLinha08(Formula: TAbstractFormulaAutomotiva; strConDil: String;
      idxBase: Integer): Double; virtual;
    function fCalculoC(Formula: TAbstractFormulaAutomotiva; idxBase: Integer): Double; virtual;
    procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String;
      Var fltFatBas, fltPerDil: Double; strConDil: String); virtual;

{$IFNDEF LINUX}
    procedure DefineRegraListaAdicionalChange(var edtVolume: TEditFocus); virtual;
{$ENDIF}

{$IFNDEF LINUX}
    procedure pReajustarColunasFormulacao(var lsvFormulacao: TListView); virtual;
{$ENDIF}

{$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer); virtual;
{$ENDIF}

{$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer;
      strLinha: String; strTipBas: String); virtual;
{$ENDIF}


  public
    tintaDeMaquina: array[TModoVenda] of TGenericTintaDeMaquina;
    calculadorFatVendas: ICalculadorFatVendasLibTintas;
    function GetDescricao(const dtsCadTin: IDataSet): String; virtual; abstract;
  public
    constructor Create(const strTabPre: String); virtual;
    destructor Destroy; override;
  public
    property CodEmb: String read strCodEmb write SetCodEmb;
    Property ChaPrecoCusto: Double Read fltChaPrecoCusto;
    Property ChaPrecoCustoReal: Double Read fltChaPrecoCustoReal;
    Property ChaPrecoVenda: Double Read fltChaPrecoVenda;
    Property ChaOutrosValores: Double read fltChaOutrosValores write fltChaOutrosValores;
    Property ChaIcmsSaida: Double read fltChaIcmsSaida write fltChaIcmsSaida;
    Property ChaImpostosFederais: Double read fltChaImpostosFederais write fltChaImpostosFederais;
    Property ChaDespesasOperacionais: Double read fltChaDespesasOperacionais write fltChaDespesasOperacionais;
    Property ChaPrecoMedio: Double read fltChaPrecoMedio write fltChaPrecoMedio;
    Property ChaPrecoUltimaCompra: Double read fltChaPrecoUltimaCompra write fltChaPrecoUltimaCompra;
    Property ChaPrecoUltimaCompraImpostos: Double read fltChaPrecoUltimaCompraImpostos write fltChaPrecoUltimaCompraImpostos;
    Property ChaPrecoCompraLiquido: Double read fltChaPrecoCompraLiquido write fltChaPrecoCompraLiquido;
    Property UsaChapinha: Boolean Read blnUsaChapinha Write blnUsaChapinha;
    Property ProCha: String Read strCodCha Write strCodCha;
    property EmbPrecoCusto: Double read fltEmbPrecoCusto;
    property EmbPrecoCustoReal: Double read fltEmbPrecoCustoReal;
    property BasesDataSet: IDataSet read GetDataSetBases;
    property BasesPorEmpresaDataSet: IDataSet read GetDataSetBasesPorEmpresa;
    property EmbPrecoVenda: Double read fltEmbPrecoVenda;

    property Descricao: String read strDescricao write strDescricao;
    property Promoc: String read strPromoc write strPromoc;

    property FatorAcerto: Double read fltFatorAcerto write fltFatorAcerto;

    property EmbOutrosValores: Double read fltEmbOutrosValores write fltEmbOutrosValores;
    property EmbIcmsSaida: Double read fltEmbIcmsSaida write fltEmbIcmsSaida;
    property EmbImpostosFederais: Double read fltEmbImpostosFederais write fltEmbImpostosFederais;
    property EmbDespesasOperacionais: Double read fltEmbDespesasOperacionais write fltEmbDespesasOperacionais;

    property EmbPrecoMedio: Double read fltEmbPrecoMedio write fltEmbPrecoMedio;
    property EmbPrecoUltimaCompra: Double read fltEmbPrecoUltimaCompra write fltEmbPrecoUltimaCompra;
    property EmbPrecoUltimaCompraImpostos: Double read fltEmbPrecoUltimaCompraImpostos write fltEmbPrecoUltimaCompraImpostos;
    property EmbPrecoCompraLiquido: Double read fltEmbPrecoCompraLiquido write fltEmbPrecoCompraLiquido;

//    property tintaDeMaquina: TGenericTintaDeMaquina read FTintaDeMaquina;

    property OnEmbalagemMudou: TEmbalagemMudouEvent Read FEmbalagemMudou Write FEmbalagemMudou;

    property ComCatalisador : Boolean read blnComCatalisador write blnComCatalisador;
    property PerfomanceAgent: Boolean read blnPerfomanceAgent write blnPerfomanceAgent;
    property ConsiderarEmbalagem: Boolean read blnConsiderarEmbalagem write blnConsiderarEmbalagem;

    property blnTemDiluido: Boolean read GetTemDiluido;
    property blnTemConcentrado: Boolean read GetTemConcentrado;
    property tpeTipEmb: TTipoEmbalagem Read FTipoEmb Write FTipoEmb;


    property VolumePorcDiluente : Double Read fltVolumePorcDiluente Write fltVolumePorcDiluente;

    property VolumeOri: Double Read fltVolumeOri Write fltVolumeOri;
    property VolumePro: Double Read fltVolumePro Write fltVolumePro;
    property VolumeDiluido: Double read fltVolumeDiluido Write fltVolumeDiluido;
    property VolumeConcentrado: Double read fltVolumeConcentrado Write fltVolumeConcentrado;
    property AcertoValor: Boolean Read GetAcertoValor;

    property PesoCor : Double read fltPesCor Write fltPesCor;
    property PesoFor : Double read fltPesFor Write fltPesFor;
    property BaiQDig : String read strBaiQdi Write strBaiQdi;


    property mveModoVenda: TModoVenda Read FModoVenda Write FModoVenda;

    property DadosAdicionais: Boolean Read blnDadosAdicionais;
    property CaptionAdicional: String Read strCaptionAdicional;
    property ListaAdicional: TStringList Read stlListaAdicional;
    property AdicionalConcentrado: Boolean Read blnAdicionalConcentrado;
    property AdicionalDiluido: Boolean Read blnAdicionalDiluido;
    property IndiceAdicional: Integer Read intIndiceAdicional Write intIndiceAdicional;

    property DadosCatalizador: Boolean Read blnDadosCatalizador;
    property ListaCatalizador: TStringList Read stlListaCatalizador;
    property ListaDiluentes: TStringList Read stlListaDiluentes;
    property CaptionCatalizador: String Read strCaptionCatalizador;
    property IndiceCatalizador: Integer Read intIndiceCatalizador Write intIndiceCatalizador;

    property MostrarEmbalagem: boolean Read blnMostrarEmbalagem;

    property CodFormul: String read strCodFormul Write strCodFormul;
    property OprFlj: String read strOprFlj Write strOprFlj;
    property EmpresaProducao: String read strEmpPrd Write strEmpPrd;
    property EmpCd_: String read strEmpCd Write strEmpCd;
    property CD_S_N: String read strCD_S_N Write strCD_S_N;
    property EmpFat: String Read strEmpFat Write strEmpFat;
    property FatS_N: String Read strFatS_N Write strFatS_N;

    property BaseQtdZerada: String read strBaseQtdZerada Write strBaseQtdZerada;

    property blnCalculaUnitario: Boolean read FBlnCalculaUnitario write FBlnCalculaUnitario;

    property DesEmb: TStringList Read stlDesEmb;
    property ProEmbLt: TStringList Read stlProEmbLt;
    property ProEmbGl: TStringList Read stlProEmbGl;
    property ProEmbLa: TStringList Read stlProEmbLa;

    property Sistema: String Read strSistema Write strSistema; // Copo

    property sProEmbCo: String Read strProEmbCo Write strProEmbCo; // Copo
    property sProEmbSp: String Read strProEmbSp Write strProEmbSp; // Spray
    property sProEmbTb: String Read strProEmbTb Write strProEmbTb; // Tambor
    property sProEmbLa: String Read strProEmbLa Write strProEmbLa; // Lata
    property sProEmbBa: String Read strProEmbBa Write strProEmbBa; // Balde
    property sProEmbSs: String Read strProEmbSs Write strProEmbSs; // Spray Sintético
    property sProEmbPo: String Read strProEmbPo Write strProEmbPo; // Spray Poliester
    property sProEmbSd: String Read strProEmbSd Write strProEmbSd; // Spray Duco




    property VolumePadraoSpray: Double Read fltVolumePadraoSpray;

    property OutrosValoresCon: Double read GetOutrosValoresCon;
    property IcmsSaidaCon: Double read GetIcmsSaidaCon;
    property ImpostosFederaisCon: Double read GetImpostosFederaisCon;
    property DespesasOperacionaisCon: Double read GetDespesasOperacionaisCon;

    property PrecoMedioCon: Double read GetPrecoMedioCon;
    property UltimoPrecoCompraCon: Double read GetUltimoPrecoCompraCon;
    property UltimoPrecoCompraImpostosCon: Double read GetUltimoPrecoCompraImpostosCon;
    property PrecoCompraLiquidoCon: Double read GetPrecoCompraLiquidoCon;

    property PrecoCustoCon: Double read GetPrecoCustoCon;
    property PrecoVendaCon: Double read GetPrecoVendaCon;
    property PrecoCustoRealCon: Double read GetPrecoCustoRealCon;

    property OutrosValoresDil: Double read GetOutrosValoresDil;
    property IcmsSaidaDil: Double read GetIcmsSaidaDil;
    property ImpostosFederaisDil: Double read GetImpostosFederaisDil;
    property DespesasOperacionaisDil: Double read GetDespesasOperacionaisDil;

    property PrecoMedioDil: Double read GetPrecoMedioDil;
    property UltimoPrecoCompraDil: Double read GetUltimoPrecoCompraDil;
    property UltimoPrecoCompraImpostosDil: Double read GetUltimoPrecoCompraImpostosDil;
    property PrecoCompraLiquidoDil: Double read GetPrecoCompraLiquidoDil;

    property PrecoCustoDil: Double read GetPrecoCustoDil;
    property PrecoVendaDil: Double read GetPrecoVendaDil;
    property PrecoCustoRealDil: Double read GetPrecoCustoRealDil;

    property AcrMob: Double Read fltAcrMob Write fltAcrMob;
    property PorDil: Double Read fltPorDil Write fltPorDil;
    property PorPer: Double Read fltPorPer Write fltPorPer;
    property EdtDil: boolean Read blnEdtDil Write blnEdtDil;
    property HabDil: boolean Read blnHabDil Write blnHabDil;
    property blnErroIntegracao: Boolean Read FErroIntegracao Write FErroIntegracao;
    property RecBases: Boolean Read blnRecarregarBases Write blnRecarregarBases;
    property LinhaDil: String Read strLinhaDiluido Write strLinhaDiluido;
    property LinhaRes: String Read strLinhaResina325 write strLinhaResina325;
    property Resina325: Boolean Read blnResina325 write blnResina325;
    property PesEspProduto: Double Read fltPesoEspecificoProduto Write fltPesoEspecificoProduto;
    property ModVen: String Read strModVen Write strModVen;
    Property CodDil: String Read strCodDil Write strCodDil;
  {$IFDEF LINUX}
    property DilLinux: String Read strCodDilLinux Write strCodDilLinux;
  {$ENDIF}

  end;

implementation

uses
  untAutcomTintaFactory, untGenericSaldosColorantes;

{ TAbstractFormulaAutomotiva }

procedure TAbstractFormulaAutomotiva.AcertaImpostos(const fltOutVal, fltIcmSai,
  fltImpFed, fltDesOpe: Extended; dicRetorno: IDicionario);
begin
  dicRetorno['outval'] := fltOutVal;
  dicRetorno['icmsai'] := fltIcmSai;
  dicRetorno['impfed'] := fltImpFed;
  dicRetorno['desope'] := fltDesOpe;
end;

procedure TAbstractFormulaAutomotiva.CalcularPrecos;
begin
  GetCalculador.Calcular;

  fltPrecoVendaCon                := GetCalculador.PrecoVendaCon;
  fltPrecoCustoCon                := GetCalculador.PrecoCustoCon;
  fltPrecoCustoRealCon            := GetCalculador.PrecoCustoRealCon;
  fltOutrosValoresCon             := GetCalculador.OutrosValoresCon;
  fltIcmsSaidaCon                 := GetCalculador.IcmsSaidaCon;
  fltImpostosFederaisCon          := GetCalculador.ImpostosFederaisCon;
  fltDespesasOperacionaisCon      := GetCalculador.DespesasOperacionaisCon;
  fltPrecoMedioCon                := GetCalculador.PrecoMedioCon;
  fltUltimoPrecoCompraCon         := GetCalculador.UltimoPrecoCompraCon;
  fltUltimoPrecoCompraImpostosCon := GetCalculador.UltimoPrecoCompraImpostosCon;
  fltPrecoCompraLiquidoCon        := GetCalculador.PrecoCompraLiquidoCon;

  fltPrecoVendaDil                := GetCalculador.PrecoVendaDil;
  fltPrecoCustoDil                := GetCalculador.PrecoCustoDil;
  fltPrecoCustoRealDil            := GetCalculador.PrecoCustoRealDil;
  fltOutrosValoresDil             := GetCalculador.OutrosValoresDil;
  fltIcmsSaidaDil                 := GetCalculador.IcmsSaidaDil;
  fltImpostosFederaisDil          := GetCalculador.ImpostosFederaisDil;
  fltDespesasOperacionaisDil      := GetCalculador.DespesasOperacionaisDil;
  fltPrecoMedioDil                := GetCalculador.PrecoMedioDil;
  fltUltimoPrecoCompraDil         := GetCalculador.UltimoPrecoCompraDil;
  fltUltimoPrecoCompraImpostosDil := GetCalculador.UltimoPrecoCompraImpostosDil;
  fltPrecoCompraLiquidoDil        := GetCalculador.PrecoCompraLiquidoDil;
end;

function TAbstractFormulaAutomotiva.fAumentarCampoDiluente: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fBaseDiluente(Base: TBaseAutomotiva): Boolean;
begin
  Result := ((Base.QuantidadeConcentrado <= 0)  And (Base.QuantidadeDiluido > 0));
end;

function TAbstractFormulaAutomotiva.fBloqueiaTipoEmbalagem: Boolean;
begin
  Result := True;
end;

function TAbstractFormulaAutomotiva.fCalculaQuantidadeParaBaixaEstoque(
  Base: TBaseAutomotiva): Double;
begin
  // Somente Salcomix e Glasurit
  If ((Base.QuantidadePadraoCon > 0) Or (Base.QuantidadePadraoDil > 0)) Then
    Result := TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else If (GetIdePro = 'LAZ') Then
    Result := TFloatUtils.fFormataFloatLaz(TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri))
  Else If (GetIdePro = 'DUP') Then
    Result := RoundTo(TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri), -1)
  Else
    Result := TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TAbstractFormulaAutomotiva.fCalculoA(
  Formula: TAbstractFormulaAutomotiva; strConDil: String; idxBase: Integer;
  strLinha: String): Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.fCalculoB(
  Formula: TAbstractFormulaAutomotiva; strConDil: String; idxBase: Integer;
  strLinha: String): Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.fCalculoBLinha08(
  Formula: TAbstractFormulaAutomotiva; strConDil: String;
  idxBase: Integer): Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.fCalculoC(
  Formula: TAbstractFormulaAutomotiva; idxBase: Integer): Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.fCaptionCheckBinder: String;
begin
  Result := 'Com Catalisador?';
end;

function TAbstractFormulaAutomotiva.fConsiderarLinhaDesBas: Boolean;
begin
  Result := false;
end;

function TAbstractFormulaAutomotiva.fDefine4Por1: Boolean;
begin
  Result := false;
end;

function TAbstractFormulaAutomotiva.fDefinirPadraoDiluido: Boolean;
begin
  Result := false;
end;


function TAbstractFormulaAutomotiva.fDefiniTamTelaFormulacao: Integer;
begin
  Result := 794;
end;

function TAbstractFormulaAutomotiva.fEncontrouNoCadastroDeBases(
  Base: TBaseAutomotiva): Boolean;
begin
  Result := GetDataSetBases.Locate('BAS_CODBAS', Base.CodigoBase, []);
end;

function TAbstractFormulaAutomotiva.fExisteConfiguracao(dtsCadTin: IDataSet;
  strEmbalagem: String): Boolean;
begin
  Result := True;
end;

function TAbstractFormulaAutomotiva.fGetCamada(dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.fGetCatalizador(
  const dtsCadTin: IDataSet): TStringList;
begin
  Result := Nil;
end;

function TAbstractFormulaAutomotiva.fGetDiluentes(const dtsCadTin: IDataSet): TStringList;
begin
  Result := Nil;
end;

function TAbstractFormulaAutomotiva.fHabilitaRdgModoVenda(
  const dtsCadTin: IDataSet; blnDiluido, blnConcentrado: Boolean): Boolean;
begin
  Result := blnConcentrado And blnDiluido;
end;

function TAbstractFormulaAutomotiva.fLeftListaBinder: Integer;
begin
  Result := 8;
end;

function TAbstractFormulaAutomotiva.fLeftPercentualBinder: Integer;
begin
  Result := 174;
end;

function TAbstractFormulaAutomotiva.fModoIntegracaoSistema: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fMostrarCatalizadorNv(const dtsCadTin: IDataSet): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fMostrarDil2: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fOpcaoRdgMovoVenda(
  const dtsCadTin: IDataSet; blnConcentrado: Boolean): Integer;
begin
  Result := TAutcomTintaFactory.Get.IIF(blnConcentrado, 0, 1);
end;

function TAbstractFormulaAutomotiva.fOutrasEmbalagens(const dtsCadTin: IDataSet;
  ItemIndex: Integer): Integer;
begin
  Result := ItemIndex;
end;

function TAbstractFormulaAutomotiva.fPorcentagemDiluicao(blnMostrar : Boolean = false): Boolean;
begin
  Result := blnMostrar;
end;

function TAbstractFormulaAutomotiva.fPossuiConexaoSQLServer: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fPreencheCatalisadorNovo: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fQuantidadeMenorIgualZero: Boolean;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFator: Double;
begin
  Result := False;

  If Self.VolumeOri > 0 Then
    fltFator := Self.VolumePro / Self.VolumeOri
  Else
    fltFator := 1;

  If Self.VolumeOri > 1 Then
    fltFator := fltFator * 1000;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If mveModoVenda = mvConcentrado Then
    Begin
      If (Base.TipoBase = 'B') And ((Base.QuantidadeConcentrado * fltFator) <= 0) And (Not fBaseDiluente(Base))Then
      Begin
        Result := False;
        Continue;
      End;
    End
    Else
    Begin
      If ((Base.QuantidadeDiluido * fltFator) <= 0) Then
      Begin
        Result := False;
        Continue;
      End;
    End;
  End;
end;

function TAbstractFormulaAutomotiva.fRetCampoTabelaPrecoTE(strCfgSis: String): String;
begin
  Result := 'ITE_PREVE1';

  If pos('VE', strCfgSis) > 0 Then
    Result := 'ITE_PRE' + strCfgSis

  else
  If strCfgSis = 'ULT' Then
    Result := 'ITE_PREULT'

  else
  If strCfgSis = 'MED' Then
    Result := 'ITE_PREMED'

  else
  If strCfgSis = 'CUS' Then
    Result := 'ITE_PRECUS'

  else
  If strCfgSis = 'IMP' Then
    Result := 'ITE_IMPULT'

  else
  If strCfgSis = 'SIC' Then
    Result := 'ITE_MEDSIC';

end;

function TAbstractFormulaAutomotiva.fRetDiluente(strLinha: String): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.fRetornaCatalisadorNovo(
  dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.fRetornaCatalisadorVenda(blnComCat: Boolean;
  strTipPre, strListaAdicional: String): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.fRetornaDiluente(
  strDiluente: String): String;
begin
  Result := strDiluente;
end;

function TAbstractFormulaAutomotiva.fRetornaTabelaBaseTinta: String;
begin
  Result := GetNomeTabelaBases;
end;

function TAbstractFormulaAutomotiva.fRetQtdDiluente(strCodDil: String;
  strPercentual:String): Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.fSprayVendaConcentrado(
  const dtsCadTin: IDataSet; ItemIndex: Integer): Integer;
begin
  Result := ItemIndex;
end;

function TAbstractFormulaAutomotiva.GetAcertoValor: Boolean;
begin
  Result := (TAutcomTintaFactory.Get.fCfgSis('ACEAUT', 256, fVerificaEmpresaSetada) = 'V');
end;

function TAbstractFormulaAutomotiva.GetBasesPorEmpresa(const dicRetorno: IDicionario): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.GetBasPesGra(
  const dataSetBases: IDataSet): String;
begin
  Result := 'N';
end;

function TAbstractFormulaAutomotiva.GetCalculador: ICalculadorFormulaAutomotiva;
begin
  if not Assigned(calculador) then
    calculador := GetCalculadorInterno;

  Result := calculador;
end;

function TAbstractFormulaAutomotiva.GetChaFor(
  const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := dicRetorno['chafor'];
end;

function TAbstractFormulaAutomotiva.GetDataSetBases: IDataSet;
begin
  if not Assigned(dataSetBases) then
  begin
    dataSetBases := TAutcomTintaFactory.Get.fGetDataSet;
  end;

  Result := dataSetBases;
end;

function TAbstractFormulaAutomotiva.GetDataSetBasesPorEmpresa: IDataSet;
begin
  if not Assigned(dataSetBasesPorEmpresa) then
  begin
    dataSetBasesPorEmpresa := TAutcomTintaFactory.Get.fGetDataSet;
  end;

  Result := dataSetBasesPorEmpresa;

end;

function TAbstractFormulaAutomotiva.GetDespesasOperacionais: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetDespesasOperacionaisCon: Double;
begin
  Result := fltDespesasOperacionaisCon;
end;

function TAbstractFormulaAutomotiva.GetDespesasOperacionaisDil: Double;
begin
  Result := fltDespesasOperacionaisDil
end;

function TAbstractFormulaAutomotiva.GetIcmsSaida: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetIcmsSaidaCon: Double;
begin
  Result := fltIcmsSaidaCon;
end;

function TAbstractFormulaAutomotiva.GetIcmsSaidaDil: Double;
begin
  Result := fltIcmsSaidaDil
end;

function TAbstractFormulaAutomotiva.GetImpostosFederais: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetImpostosFederaisCon: Double;
begin
  Result := fltImpostosFederaisCon;
end;

function TAbstractFormulaAutomotiva.GetImpostosFederaisDil: Double;
begin
  Result := fltImpostosFederaisDil;
end;


function TAbstractFormulaAutomotiva.GetLinha(const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

procedure TAbstractFormulaAutomotiva.GetLinhaFormula;
begin
  //
end;

function TAbstractFormulaAutomotiva.GetLinhaFormulacao(
  const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TAbstractFormulaAutomotiva.NomeTinta: String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.GetOutrosValores: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetOutrosValoresCon: Double;
begin
  Result := fltOutrosValoresCon;
end;

function TAbstractFormulaAutomotiva.GetOutrosValoresDil: Double;
begin
  Result := fltOutrosValoresDil;
end;

function TAbstractFormulaAutomotiva.GetPrecoCompraLiquido: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetPrecoCompraLiquidoCon: Double;
begin
  Result := fltPrecoCompraLiquidoCon;
end;

function TAbstractFormulaAutomotiva.GetPrecoCompraLiquidoDil: Double;
begin
  Result := fltPrecoCompraLiquidoDil;
end;

function TAbstractFormulaAutomotiva.GetPrecoCusto: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetPrecoCustoCon: Double;
begin
  Result := fltPrecoCustoCon;
end;

function TAbstractFormulaAutomotiva.GetPrecoCustoDil: Double;
begin
  Result := fltPrecoCustoDil;
end;

function TAbstractFormulaAutomotiva.GetPrecoCustoReal: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetPrecoCustoRealCon: Double;
begin
  Result := fltPrecoCustoRealCon;
end;

function TAbstractFormulaAutomotiva.GetPrecoCustoRealDil: Double;
begin
  Result := fltPrecoCustoRealDil;
end;

function TAbstractFormulaAutomotiva.GetPrecoMedio: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetPrecoMedioCon: Double;
begin
  Result := fltPrecoMedioCon;
end;

function TAbstractFormulaAutomotiva.GetPrecoMedioDil: Double;
begin
  Result := fltPrecoMedioDil;
end;

function TAbstractFormulaAutomotiva.GetPrecoVenda: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetPrecoVendaCon: Double;
begin
  Result := fltPrecoVendaCon;
end;

function TAbstractFormulaAutomotiva.GetPrecoVendaDil: Double;
begin
  Result := fltPrecoVendaDil;
end;

function TAbstractFormulaAutomotiva.GetProdutoChapinha: String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.GetQualidade(
  const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TAbstractFormulaAutomotiva.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  base: TBaseAutomotiva;
  fltQtdFormul: Double;
begin
  saldos := TGenericSaldosColorantes.Create();

  for intCont := 0 to Self.Count - 1 do
  begin
    base := TBaseAutomotiva(Self.Items[intCont]);

    If (Not TStrUtils.fEmptyStr(Base.LinhaBase)) Then
      GetDataSetBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), [])
    Else
      GetDataSetBases.Locate('BAS_CODBAS', base.CodigoBase, []);


    if (Base.TipoBase = 'C') and not(self.blnComCatalisador) then
      Continue;

    fltQtdFormul := fCalculaQuantidadeParaBaixaEstoque(Base);

    if fltQtdFormul > 0 then
    begin
      saldos.Adicionar(TGenericSaldoColorante.Create(
        1,
        Descricao,
        GetDataSetBases.FieldByName('BAS_CODITE').AsString,
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [
          GetDataSetBases.FieldByName('BAS_CODITE').AsString]), ''),
        Base.CodigoBase,
        fltQtdFormul,
        BASE_AUTOMOTIVA,
        'N',
        0.0));
    end;
  end;

  Result := saldos;
end;

function TAbstractFormulaAutomotiva.GetTemConcentrado: Boolean;
  Var
    intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To Count -1 Do
  Begin
    If (TBaseAutomotiva(Items[intIndex]).QuantidadeConcentrado > 0) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TAbstractFormulaAutomotiva.GetTemDiluido: Boolean;
Var
  intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To Count -1 Do
  Begin
    If (TBaseAutomotiva(Items[intIndex]).QuantidadeDiluido > 0) Or
       (TBaseAutomotiva(Items[intIndex]).QuantidadeDiluido2 > 0) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TAbstractFormulaAutomotiva.GetTintaSQLServer(strIdCor:String; strLinha:String): TAbstractTintaSQLServer;
begin
  Result := Nil;
end;

function TAbstractFormulaAutomotiva.GetUltimoPrecoCompra: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetUltimoPrecoCompraCon: Double;
begin
  Result := fltUltimoPrecoCompraCon;
end;

function TAbstractFormulaAutomotiva.GetUltimoPrecoCompraDil: Double;
begin
  Result := fltUltimoPrecoCompraDil;
end;

function TAbstractFormulaAutomotiva.GetUltimoPrecoCompraImpostos: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetUltimoPrecoCompraImpostosCon: Double;
begin
  Result := fltUltimoPrecoCompraImpostosCon;
end;

function TAbstractFormulaAutomotiva.GetUltimoPrecoCompraImpostosDil: Double;
begin
  Result := fltUltimoPrecoCompraImpostosDil;
end;


function TAbstractFormulaAutomotiva.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.500;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 4.000;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.400;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoSprayDuco(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.150;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoSprayPoli(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.150;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoSpraySint(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.150;
end;

function TAbstractFormulaAutomotiva.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  Result := 200.000;
end;

function TAbstractFormulaAutomotiva.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;
end;

function TAbstractFormulaAutomotiva.GetVolumePadraoBalde(dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;
end;

function TAbstractFormulaAutomotiva.GetVolumePadraoLata(dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;
end;

function TAbstractFormulaAutomotiva.GetVolumePadraoSprayDuco: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetVolumePadraoSprayPoli: Double;
begin
  Result := 0;
end;

function TAbstractFormulaAutomotiva.GetVolumePadraoSpraySint: Double;
begin
  Result := 0;
end;

{function TAbstractFormulaAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := fltVolumeConcentrado;
end;

function TAbstractFormulaAutomotiva.GetVolumeDiluido: Double;
begin
  Result := fltVolumeDiluido;
end;}

procedure TAbstractFormulaAutomotiva.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet) ;
begin
  //
end;

procedure TAbstractFormulaAutomotiva.pAtuPorcentagemBlinder(
  const Formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  //
end;

procedure TAbstractFormulaAutomotiva.pCalculaBaseAdicional(strPercentual: String = '20'; const dtsCadTin: IDataSet = Nil; strBaseAdicional: String = '');
begin
  //
end;

procedure TAbstractFormulaAutomotiva.pCalculaImpostosSaida(Var dicRetorno: IDicionario);
var
  componente: ITintaDeMaquinaComponente;
  strNomeProd: String;
begin
  SetQtdEmb(TVariantUtils.IfNull(dicRetorno['qtdemb'], 1));

  tintaDeMaquina[mvConcentrado].SetQuantidade(intQtdEmb);
  tintaDeMaquina[mvDiluido].SetQuantidade(intQtdEmb);

  strNomeProd := VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [strCodEmb]), '');

  componente := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.Create(strCodEmb));
  if not Assigned(componente) then
  begin
    componente := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
      strCodEmb, strNomeProd, EmbDespesasOperacionais, EmbIcmsSaida,
      EmbImpostosFederais, EmbOutrosValores, EmbPrecoCusto, EmbPrecoCustoReal, EmbPrecoMedio,
      EmbPrecoVenda, intQtdEmb, tmctEmbalagemAutomotiva
    ));

    tintaDeMaquina[mvDiluido].Adicionar(componente);
  end;

  componente.Quantidade                := intQtdEmb;
  componente.CodIte                    := strCodEmb;
  componente.PrecoCusto                := EmbPrecoCusto;
  componente.PrecoVenda                := EmbPrecoVenda;
  componente.PrecoCustoReal            := EmbPrecoCustoReal;
  componente.Descricao                 := strNomeProd;
  componente.PrecoMedio                := EmbPrecoMedio;
  componente.Tipo                      := tmctEmbalagemAutomotiva;
  componente.IcmsSaida                 := EmbIcmsSaida;
  componente.OutrosValores             := EmbOutrosValores;
  componente.ImpostosFederais          := EmbImpostosFederais;
  componente.DespesasOperacionais      := EmbDespesasOperacionais;
  componente.UltimoPrecoCompraImpostos := EmbPrecoUltimaCompraImpostos;

  if dicRetorno['tippre'] = 'C' then
  begin
    dicRetorno['outval'] := OutrosValoresCon;
    dicRetorno['icmsai'] := IcmsSaidaCon;
    dicRetorno['impfed'] := ImpostosFederaisCon;
    dicRetorno['desope'] := DespesasOperacionaisCon;
  end
  else
  begin
    dicRetorno['outval'] := OutrosValoresDil;
    dicRetorno['icmsai'] := IcmsSaidaDil;
    dicRetorno['impfed'] := ImpostosFederaisDil;
    dicRetorno['desope'] := DespesasOperacionaisDil;
  end;

  AcertaImpostos(
    dicRetorno['outval'] + EmbOutrosValores,
    dicRetorno['icmsai'] + EmbIcmsSaida,
    dicRetorno['impfed'] + EmbImpostosFederais,
    dicRetorno['desope'] + EmbDespesasOperacionais,
    dicRetorno);
end;

procedure TAbstractFormulaAutomotiva.pCarregaPrecoChapinha(strTabPre_,
  strOpcDoc: String);
Var
  DataSetChapinha: IDataSet;
  fltPreCusPro, fltPreVenPro,
  fltDesOpeTinta, fltPerAcr: Double;
  strSQL, strCodEmpresa: String;
  blnEmPromo: Boolean;
  dicDados: IDicionario;
  Chapinha: ITintaDeMaquinaComponente;
  strNomeProd: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  If TStrUtils.fEmptyStr(strCodCha) Then
  Begin
    pZerarChapinha;
    Exit;
  End;

  If Not blnUsaChapinha Then
  Begin
    pZerarChapinha;
    Exit;
  End;

  If (Not TStrUtils.fEmptyStr(strTabPre_)) Then
    pZerarChapinha;

  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');
  fltPerAcr      := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('APREVE') / 100.0;
  strCodEmpresa := fVerificaEmpresaSetada();

  Try
    Try
      strSQL := '';
      strSQL := strSQL +
        '  SELECT          ' +
        '     G.ITE_PRECUS ' +
        '   , G.ITE_ICMSAI ' +
        '   , G.ITE_IMPFED ' +
        '   , G.ITE_DESOPE ' +
        '   , G.ITE_OUTVAL ' +
        '   , G.ITE_PREMED ' +
        '   , G.ITE_IMPULT ' +
        '   , G.ITE_PREULT ' +
        '   , G.ITE_PRECOM ' +
        '   , G.ITE_DESF01 ' +
        '   , G.ITE_DESF02 ' +
        '   , G.ITE_DESF03 ' +
        '   , G.ITE_DESF04 ' +
        '   , G.ITE_DESF05 ' +
        '   , G.ITE_DESF06 ' +
        '   , I.ITE_ITEATI ';

      If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
        strSQL := strSQL + '   , I.ITE_IMPDIR  '
      Else
        strSQL := strSQL + '   , G.ITE_IMPDIR  ';

      If strOpcDoc = 'TE' Then
      Begin
        strSQL := strSQL + ' , G.'+ fRetCampoTabelaPrecoTE(TAutcomTintaFactory.Get.fCfgSis('TEPREV')) + ' AS ITE_PREVEN ';
      End
      Else If Not TStrUtils.fEmptyStr(strTabPre_) Then
      Begin
        strSQL := strSQL + ' , G.ITE_PREVE' + strTabPre_ + ' AS ITE_PREVEN ';
      End
      Else
      Begin
        If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
          strSQL := strSQL + ' , G.ITE_PREVE1 AS ITE_PREVEN '
        Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
          strSQL := strSQL + ' , G.ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN '
        Else
          strSQL := strSQL + ' , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ';
      End;

      strSQL := strSQL +
      '    FROM                         ' +
      '      ITEGER G                   ' +
      '      JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ' +
      '   WHERE                         ' +
      '      I.ITE_CODITE = :CODITE AND ' +
      '      G.ITE_CODEMP = :CODEMP     ';

      DataSetChapinha := TAutcomTintaFactory.Get.fGetDataSet;
      DataSetChapinha.SQL := strSQL;
      DataSetChapinha.ParamByName('CODITE').AsString := strCodCha;
      DataSetChapinha.ParamByName('CODEMP').AsString := strCodEmpresa;
      DataSetChapinha.Open;

      If (DataSetChapinha.FieldByName('ITE_ITEATI').AsString = 'N') Then
        Raise Exception.CreateFmt('O produto chapinha %s não está ativo, Favor verificar!', [strCodCha]);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(strCodCha, TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(strTabPre_), fTabPreco, strTabPre_), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      If (blnEmPromo) And (Not Self.blnProPre) Then
      Begin
        fltChaPrecoVenda := fltPreVenPro;
        fltChaPrecoCusto := fltPreCusPro;


        If strTabPre = strTabPreTin Then
          strPromoc := 'S';

        If fltChaPrecoCusto = 0 Then
          fltChaPrecoCusto := DataSetChapinha.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        fltChaPrecoVenda := DataSetChapinha.FieldByName('ITE_PREVEN').AsFloat;
        fltChaPrecoCusto := DataSetChapinha.FieldByName('ITE_PRECUS').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          strPromoc := 'S';
      End;

      fltChaPrecoMedio                := DataSetChapinha.FieldByName('ITE_PREMED').AsFloat;
      fltChaPrecoUltimaCompra         := DataSetChapinha.FieldByName('ITE_PREULT').AsFloat;
      fltChaPrecoUltimaCompraImpostos := DataSetChapinha.FieldByName('ITE_IMPULT').AsFloat;
      fltChaPrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                             DataSetChapinha.FieldByName('ITE_PRECOM').AsFloat, DataSetChapinha.Fieldbyname('ITE_DESF01').AsFloat,
                                                             DataSetChapinha.Fieldbyname('ITE_DESF02').AsFloat, DataSetChapinha.Fieldbyname('ITE_DESF03').AsFloat,
                                                             DataSetChapinha.Fieldbyname('ITE_DESF04').AsFloat, DataSetChapinha.Fieldbyname('ITE_DESF05').AsFloat,
                                                             DataSetChapinha.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));
      fltChaOutrosValores             := DataSetChapinha.FieldByName('ITE_OUTVAL').AsFloat;


      dicDados := TAutcomTintaFactory.Get.GetDicionario;
      dicDados['preven'] := fltChaPrecoVenda;
      dicDados['precus'] := fltChaPrecoCusto;
      dicDados['outval'] := DataSetChapinha.FieldByName('ITE_OUTVAL').AsFloat;
      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        dicDados['icmsai'] := calculadorFatVendas.fCalculaAliquota(strCodCha, DataSetChapinha.FieldByName('ITE_IMPDIR').AsString)
      Else
        dicDados['icmsai'] := DataSetChapinha.FieldByName('ITE_ICMSAI').AsFloat;
      dicDados['impfed'] := DataSetChapinha.FieldByName('ITE_IMPFED').AsFloat;
      dicDados['desope'] := DataSetChapinha.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

      fltChaPrecoCustoReal            := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        fltChaIcmsSaida                 := calculadorFatVendas.fCalculaAliquota(strCodCha, DataSetChapinha.FieldByName('ITE_IMPDIR').AsString)
      Else
        fltChaIcmsSaida                 := DataSetChapinha.FieldByName('ITE_ICMSAI').AsFloat;

      fltChaPrecoVenda                := fltChaPrecoVenda * (1 + fltPerAcr);
      fltChaIcmsSaida                 := (fltChaIcmsSaida * fltChaPrecoVenda / 100);
      fltChaImpostosFederais          := (DataSetChapinha.FieldByName('ITE_IMPFED').AsFloat * fltChaPrecoVenda / 100);
      fltChaDespesasOperacionais      := (((DataSetChapinha.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * fltChaPrecoVenda) / 100);

      strNomeProd := VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [strCodCha]), '');
      Chapinha := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.Create(strCodCha));

      If Not Assigned(Chapinha) Then
      Begin
        Chapinha := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(strCodCha, strNomeProd, ChaDespesasOperacionais, ChaIcmsSaida,
          ChaImpostosFederais, ChaOutrosValores, ChaPrecoCusto, ChaPrecoCustoReal, ChaPrecoMedio, ChaPrecoVenda, 1, tmctEmbalagemAutomotiva));

        tintaDeMaquina[mvDiluido].Adicionar(Chapinha);
      End;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
  End;
end;

procedure TAbstractFormulaAutomotiva.pCarregaPrecoPromocaoEmbalagem(strTabPre_ : String = ''; strOpcDoc : String = '');
var
  dataSetCalculo: IDataSet;
  fltPreCusPro,
  fltPreVenPro: Double;
  fltDesOpeTinta: Double;
  fltPerAcr: Double;
  strSql: String;
  strCodEmpresa: String;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;

  function fPrecoCusto2Base: Double;
  var
    dicDados: IDicionario;
  begin
    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := fltEmbPrecoVenda;
    dicDados['precus'] := fltEmbPrecoCusto;
    dicDados['outval'] := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;

    If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      dicDados['icmsai'] := calculadorFatVendas.fCalculaAliquota(strCodEmb, dataSetCalculo.FieldByName('ITE_IMPDIR').AsString)
    Else
      dicDados['icmsai'] := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat;

    dicDados['impfed'] := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat;
    dicDados['desope'] := dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

    Result := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
  end;
begin

  If TStrUtils.fEmptyStr(strCodEmb) Then
  Begin

    fltEmbPrecoVenda                := 0;
    fltEmbPrecoCusto                := 0;
    fltEmbPrecoMedio                := 0;
    fltEmbPrecoUltimaCompra         := 0;
    fltEmbPrecoUltimaCompraImpostos := 0;
    fltEmbPrecoCompraLiquido        := 0;
    fltEmbOutrosValores             := 0;
    fltEmbPrecoCustoReal            := 0;
    fltEmbIcmsSaida                 := 0;
    fltEmbImpostosFederais          := 0;
    fltEmbDespesasOperacionais      := 0;
    fltEmbPrecoVenda                := 0;

    Exit;

  End;

  dataSetCalculo := nil;

  If (Not blnConsiderarEmbalagem) Or (Not TStrUtils.fEmptyStr(strTabPre_)) Then
    pZerarEmbalagens;

  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');
  fltPerAcr      := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('APREVE') / 100.0;

  strCodEmpresa := fVerificaEmpresaSetada();

  strSql := '';

  Try
    Try
      dataSetCalculo := TAutcomTintaFactory.Get.fGetDataSet;
      strSql :=
      '  SELECT          ' +
      '     G.ITE_PRECUS ' +
      '   , G.ITE_ICMSAI ' +
      '   , G.ITE_IMPFED ' +
      '   , G.ITE_DESOPE ' +
      '   , G.ITE_OUTVAL ' +
      '   , G.ITE_PREMED ' +
      '   , G.ITE_IMPULT ' +
      '   , G.ITE_PREULT ' +
      '   , G.ITE_PRECOM ' +
      '   , G.ITE_DESF01 ' +
      '   , G.ITE_DESF02 ' +
      '   , G.ITE_DESF03 ' +
      '   , G.ITE_DESF04 ' +
      '   , G.ITE_DESF05 ' +
      '   , G.ITE_DESF06 ' +
      '   , I.ITE_ITEATI ';

      If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
        strSql := strSql + '   , I.ITE_IMPDIR  '
      else
        strSql := strSql + '   , G.ITE_IMPDIR  ';

      If strOpcDoc = 'TE' Then
      Begin
        strSql := strSql + ' , G.'+fRetCampoTabelaPrecoTE(TAutcomTintaFactory.Get.fCfgSis('TEPREV')) + ' AS ITE_PREVEN ';
      end
      Else

      If Not TStrUtils.fEmptyStr(strTabPre_) Then
      Begin
        strSql := strSql +
        ' , G.ITE_PREVE' + strTabPre_ + ' AS ITE_PREVEN ';
      End
      Else
      Begin

        If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
          strSql := strSql + ' , G.ITE_PREVE1 AS ITE_PREVEN '
        Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') and BlnCalculaUnitario Then
          strSql := strSql + ' , G.ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN '
        Else
          strSql := strSql + ' , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ';

      End;

      strSql := strSql +
      '    FROM                         ' +
      '      ITEGER G                   ' +
      '      JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ' +
      '   WHERE                         ' +
      '      I.ITE_CODITE = :CODITE AND ' +
      '      G.ITE_CODEMP = :CODEMP     ';

      dataSetCalculo.SQL := strSql;
      dataSetCalculo.ParamByName('CODITE').AsString := strCodEmb;

      If (Not TStrUtils.fEmptyStr(Self.EmpresaProducao)) And (Self.OprFlj = 'S') Then
        dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpresaProducao
      Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        dataSetCalculo.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

      dataSetCalculo.Open;

      If (dataSetCalculo.FieldByName('ITE_ITEATI').AsString = 'N') Then
      Begin
        raise Exception.CreateFmt('O produto embalagem %s não está ativo, Favor verificar!', [strCodEmb]);
      End;

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(strCodEmb, TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(strTabPre_), fTabPreco, strTabPre_), strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      If (blnEmPromo) And (Not Self.blnProPre) Then
      Begin
        fltEmbPrecoVenda := fltPreVenPro;
        fltEmbPrecoCusto := fltPreCusPro;

        If strTabPre = strTabPreTin Then
          strPromoc := 'S';

        If fltEmbPrecoCusto = 0 Then
          fltEmbPrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat
      End
      Else
      Begin
        fltEmbPrecoVenda := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
        fltEmbPrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;


        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          strPromoc := 'S';
      End;

      fltEmbPrecoMedio                := dataSetCalculo.FieldByName('ITE_PREMED').AsFloat;
      fltEmbPrecoUltimaCompra         := dataSetCalculo.FieldByName('ITE_PREULT').AsFloat;
      fltEmbPrecoUltimaCompraImpostos := dataSetCalculo.FieldByName('ITE_IMPULT').AsFloat;
      fltEmbPrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                             dataSetCalculo.FieldByName('ITE_PRECOM').AsFloat, dataSetCalculo.Fieldbyname('ITE_DESF01').AsFloat,
                                                             dataSetCalculo.Fieldbyname('ITE_DESF02').AsFloat, dataSetCalculo.Fieldbyname('ITE_DESF03').AsFloat,
                                                             dataSetCalculo.Fieldbyname('ITE_DESF04').AsFloat, dataSetCalculo.Fieldbyname('ITE_DESF05').AsFloat,
                                                             dataSetCalculo.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));
      fltEmbOutrosValores             := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;
      fltEmbPrecoCustoReal            := fPrecoCusto2Base;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        fltEmbIcmsSaida                 := calculadorFatVendas.fCalculaAliquota(strCodEmb, dataSetCalculo.FieldByName('ITE_IMPDIR').AsString)
      Else
        fltEmbIcmsSaida                 := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat;

      fltEmbPrecoVenda                := fltEmbPrecoVenda * (1 + fltPerAcr);
      fltEmbIcmsSaida                 := (fltEmbIcmsSaida * fltEmbPrecoVenda / 100);
      fltEmbImpostosFederais          := (dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat * fltEmbPrecoVenda / 100);
      fltEmbDespesasOperacionais      := (((dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * fltEmbPrecoVenda) / 100);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TAbstractFormulaAutomotiva.pCarregarBasesSQLServer;
begin
//
end;

procedure TAbstractFormulaAutomotiva.pCarregarBasesSQLServerCasoNecessario;
begin
  If (RecBases) Then
  Begin
    pCarregarBasesSQLServer;
    Self.RecBases := False;
  End;
end;

procedure TAbstractFormulaAutomotiva.pConectarSQLServer(strIdCor,
  strLinha: String);
begin
  tintaSQLServer := GetTintaSQLServer(strIdCor, strLinha);
end;

{$IFNDEF LINUX}
procedure TAbstractFormulaAutomotiva.pModoVendaClick(var edtVolume: TEditFocus;
  intModoVenda, intListaAdic: Integer);
begin
 //
end;
{$ENDIF}

procedure TAbstractFormulaAutomotiva.pPreencheListaAdicionalBases;
begin
 //
end;

procedure TAbstractFormulaAutomotiva.pPreencherBaixaQtdDig(
  const dtsCadTin: IDataSet);
begin
  //
end;

{$IFNDEF LINUX}
procedure TAbstractFormulaAutomotiva.pReajustarColunasFormulacao(
  var lsvFormulacao: TListView);
begin
  //
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TAbstractFormulaAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
//
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TAbstractFormulaAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
 //
end;
{$ENDIF}


procedure TAbstractFormulaAutomotiva.PreencheQuantidadeFormulacaoVendaEsp(
  const dtsCadTin: IDataSet);
begin
  //
end;

procedure TAbstractFormulaAutomotiva.pCalcularDiluente(const strCodDil: string; const fltPorDil: Double; const dtsCadTin: IDataSet);
begin
//
end;

procedure TAbstractFormulaAutomotiva.pReformulaNovo(strCodDil: String;
  strPercentual:String; const dtsCadTin: IDataSet);
begin
  //
end;

procedure TAbstractFormulaAutomotiva.pReformulaNovoCatalizador(
  strCodCat: String; const dtsCadTin: IDataSet);
begin
  //
end;

procedure TAbstractFormulaAutomotiva.pRetornaInfoLinha(strLinha: String;
  var strLinDil, strBasDil: String; var fltFatBas, fltPerDil: Double;
  strConDil: String);
begin

end;

procedure TAbstractFormulaAutomotiva.pZerarChapinha;
begin
  fltChaPrecoCustoReal            := 0.0;
  fltChaPrecoMedio                := 0.0;
  fltChaPrecoUltimaCompra         := 0.0;
  fltChaPrecoUltimaCompraImpostos := 0.0;
  fltChaPrecoCompraLiquido        := 0.0;
  fltChaOutrosValores             := 0.0;
  fltChaIcmsSaida                 := 0.0;
  fltChaImpostosFederais          := 0.0;
  fltChaDespesasOperacionais      := 0.0;
  fltChaPrecoVenda                := 0.0;
  fltChaPrecoCusto                := 0.0;
end;

procedure TAbstractFormulaAutomotiva.pZerarEmbalagens;
begin
  fltEmbPrecoCustoReal            := 0.0;
  fltEmbPrecoMedio                := 0.0;
  fltEmbPrecoUltimaCompra         := 0.0;
  fltEmbPrecoUltimaCompraImpostos := 0.0;
  fltEmbPrecoCompraLiquido        := 0.0;
  fltEmbOutrosValores             := 0.0;
  fltEmbIcmsSaida                 := 0.0;
  fltEmbImpostosFederais          := 0.0;
  fltEmbDespesasOperacionais      := 0.0;
  fltEmbPrecoVenda                := 0.0;
end;

function TAbstractFormulaAutomotiva.fTabPreco: String;
begin
  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    Result := '1';
  end
  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') and BlnCalculaUnitario Then
  begin
    Result := TAutcomTintaFactory.Get.fCfgSis('TABPRE');
  end
  else
  begin
    Result := Self.strTabPre;
  end;
end;

function TAbstractFormulaAutomotiva.fTipoEmbalagem(intIndEmb: Integer;
  strQualid: String): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fUtilizaBlinder: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaAutomotiva.fUtilizarPorcentagemAgentePerformance(
  AVisible: Boolean): Boolean;
begin
  Result := AVisible;
end;

function TAbstractFormulaAutomotiva.fVerificaEmpresaSetada: String;
begin
  If (Not TStrUtils.fEmptyStr(Self.EmpresaProducao)) And (Self.OprFlj = 'S') Then
    Result := Self.EmpresaProducao
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    Result := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    Result := Self.EmpFat
  Else
    Result := TAutcomTintaFactory.Get.GetCodEmp;
end;

function TAbstractFormulaAutomotiva.fVisibleBinder(const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TAbstractFormulaAutomotiva.fVolumeMaximoSpraySint(
  fltVolumeMaximoSpraySint: Double): Double;
begin
  Result := fltVolumeMaximoSpraySint;
end;

function TAbstractFormulaAutomotiva.fVolumeOriginalFator: Boolean;
begin
  Result := Self.VolumeOri > 1;
end;

function TAbstractFormulaAutomotiva.fVolumePadraoLitro(
  fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double;
begin
  Result := fltVolumePadraoLitro;
end;

procedure TAbstractFormulaAutomotiva.CarregaPrecosBases;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  strCodEmpresa: String;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin

  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

  strCodEmpresa := fVerificaEmpresaSetada();

  Self.pPreencheListaAdicionalBases;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);
    If GetDataSetBases.Locate('BAS_CODBAS', Base.CodigoBase, []) Then
    Begin
      Base.OutrosValores             := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
      Base.CodIte                    := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
      Base.ImpDir                    := GetDataSetBases.FieldByName('ITE_IMPDIR').AsString;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
        Base.IcmsSaida               := calculadorFatVendas.fCalculaAliquota(Base.CodIte, Base.ImpDir)
      Else
        Base.IcmsSaida               := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat;

      Base.ImpostosFederais          := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat;
      Base.DespesasOperacionais      := GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

      Base.PrecoMedio                := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
      Base.UltimoPrecoCompra         := GetDataSetBases.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos := GetDataSetBases.FieldByName('ITE_IMPULT').AsFloat;
      Base.PrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                                                     GetDataSetBases.Fieldbyname('ITE_PRECOM').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF01').AsFloat,
                                                                                     GetDataSetBases.Fieldbyname('ITE_DESF02').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF03').AsFloat,
                                                                                     GetDataSetBases.Fieldbyname('ITE_DESF04').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF05').AsFloat,
                                                                                     GetDataSetBases.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

      Base.Embalagem                 := GetDataSetBases.FieldByName('BAS_EMBALA').AsFloat;
      Base.PesoEspecifico            := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;
      Base.PesGra                    := GetBasPesGra(GetDataSetBases);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBases.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);
      if (blnEmPromo) And (Not Self.blnProPre) then
      begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 then
          Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
      end
      else
      begin
        Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      end;
      CarregaPrecosColorantesAdicional(GetDataSetBases, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TAbstractFormulaAutomotiva.CarregaPrecosBasesPorEmpresa;
begin
 //
end;

procedure TAbstractFormulaAutomotiva.CarregaPrecosColorantesAdicional(
  const dataSetBases: IDataSet; const base: TBaseAutomotiva);
begin
//
end;

procedure TAbstractFormulaAutomotiva.CarregarBases(const dicRetorno: IDicionario);
var
  strSql    : String;
begin
  strSql := GetSelectBases;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , ' + GetNomeCampoCustoBase + ' AS ITE_PRECUS ' +
      '   , ' + GetNomeCampoVendaBase + ' AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' + GetNomeTabelaBases + ' B     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON B.BAS_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON G.ITE_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  strSql := strSql + GetBasesPorEmpresa(dicRetorno);

  GetDataSetBases.SQL := strSql;

  If Not TStrUtils.fEmptyStr(Self.EmpresaProducao) And (Self.OprFlj = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpresaProducao
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetBases.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetBases.Open;
end;

procedure TAbstractFormulaAutomotiva.CarregarBasesPorEmpresa(
  const dicRetorno: IDicionario);
begin
 // Utilizada pela lib PPG
end;

constructor TAbstractFormulaAutomotiva.Create(const strTabPre: String);
begin
  inherited Create(TBaseAutomotiva);
  Self.strTabPre                := strTabPre;
  Self.FBlnCalculaUnitario      := True;

  tintaDeMaquina[mvConcentrado] := TGenericTintaDeMaquina.Create();
  tintaDeMaquina[mvDiluido]     := TGenericTintaDeMaquina.Create();

  Self.blnComCatalisador        := False;
  Self.blnPerfomanceAgent       := False;
  Self.blnConsiderarEmbalagem   := True;

  If TStrUtils.fEmptyStr(strTabPre) Then
    Self.strTabPre := '1';

  Self.strTabPreTin       := Self.strTabPre;

  blnDadosAdicionais      := False;
  blnMostrarEmbalagem     := False;
  strCaptionAdicional     := '';
  stlListaAdicional       := TStringList.Create;
  stlListaDiluentes       := TStringList.Create;
  blnAdicionalConcentrado := False;
  blnAdicionalDiluido     := False;
  intIndiceAdicional      := -1;

  If Not Self.AcertoValor Then
    fltFatorAcerto          := 1.0
  Else
    fltFatorAcerto          := 0.0;

  strCodFormul            := '';
  strBaseQtdZerada        := '';

  blnDadosCatalizador     := False;
  strCaptionCatalizador   := '';
  stlListaCatalizador     := TStringList.Create;
  intIndiceCatalizador    := -1;



  stlDesEmb               := TStringList.Create;
  stlProEmbLt             := TStringList.Create;
  stlProEmbGl             := TStringList.Create;
  stlProEmbLa             := TStringList.Create;

  FEmbalagemMudou := Nil;
end;

{$IFNDEF LINUX}
procedure TAbstractFormulaAutomotiva.DefineRegraListaAdicionalChange(
  var edtVolume: TEditFocus);
begin

end;
{$ENDIF}

destructor TAbstractFormulaAutomotiva.Destroy;
begin
  dataSetBases := nil;

  if Assigned(stlListaAdicional) then FreeAndNil(stlListaAdicional);
  if Assigned(stlListaDiluentes) then FreeAndNil(stlListaDiluentes);
  If Assigned(stlListaCatalizador) Then FreeAndNil(stlListaCatalizador);
  if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
  if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
  if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);

  inherited;
end;

procedure TAbstractFormulaAutomotiva.RecalcularTabelas(dicRetorno: IDicionario);
begin
  RecalcularTabelasGeneric(dicRetorno);
end;

procedure TAbstractFormulaAutomotiva.RecalcularTabelasGeneric(
  dicRetorno: IDicionario);
var
  strTabelas: String;
  strTabelaAtual: String;
  intContador: Integer;
begin
  strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
  If Length(strTabelas) < 7 Then
    strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

  Self.FBlnCalculaUnitario := False;

  strTabPreTin := TVariantUtils.IfNull(dicRetorno['tabpre'],0);
  strTabelaAtual := Self.strTabPre;
  For intContador := 1 To Length(strTabelas) Do
  Begin
    if strTabelas[intContador] = 'S' then
    begin
      Self.strTabPre := IntToStr(intContador);

      Self.CarregarBases(dicRetorno);
      Self.CarregarBasesPorEmpresa(dicRetorno);

      Self.CarregaPrecosBases;
      Self.CarregaPrecosBasesPorEmpresa;

      Self.CalcularPrecos;

      {Carrega preço da embalagem conforme tabela de preço!}
      Self.pCarregaPrecoPromocaoEmbalagem(Self.strTabPre);
      Self.pCarregaPrecoChapinha(Self.strTabPre);

      If dicRetorno['tippre'] = 'C' Then
      Begin
        If PrecoVendaCon > 0 Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (PrecoVendaCon + EmbPrecoVenda) * (1 + AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := PrecoVendaCon + EmbPrecoVenda + AcrMob;

          If Self.UsaChapinha Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + ChaPrecoVenda;

          dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];

          If Self.AcertoValor Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Self.FatorAcerto
          Else
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Self.FatorAcerto;
        End;
      End
      Else
      Begin
        If (PrecoVendaDil > 0) Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (PrecoVendaDil + EmbPrecoVenda) * (1 + AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := PrecoVendaDil + EmbPrecoVenda + AcrMob;

          If Self.UsaChapinha Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + ChaPrecoVenda;

          dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];

          If Self.AcertoValor Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Self.FatorAcerto
          Else
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Self.FatorAcerto;
        End;
      End;

      If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
      Begin
        dicRetorno['promoc'] := Self.Promoc;
        pCalculaImpostosSaida(dicRetorno);
      End;
    end;
  End;
  Self.strTabPre := strTabelaAtual;
  dicRetorno['fatace'] := fltFatorAcerto;
{$IFNDEF LINUX}
  If Self.AcertoValor Then
    dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(fltFatorAcerto > 0, 'S', 'N')
  Else
    dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(fltFatorAcerto > 1, 'S', 'N');
{$ENDIF}
end;

procedure TAbstractFormulaAutomotiva.SetCodEmb(const Value: String);
begin

  strCodEmb := Value;
  pCarregaPrecoPromocaoEmbalagem('', FstrOpcDoc);

  If Assigned(FEmbalagemMudou) Then
    FEmbalagemMudou(Value);

end;

function TAbstractFormulaAutomotiva.SetItemIndexLinuxDiluente(
  const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer;
begin
  Result := 0;
end;

end.
