{ ****************************************************************************** }
{ * Classe abstrata que implementa o básico de todas as formulas imobiliárias. * }
{ ***************************************************************************PH* }
unit untAbstractFormulaImobiliaria;

interface

uses
{$IFDEF LINUX}

{$ELSE}
  Vcl.ComCtrls, Forms,
{$ENDIF}
  untAbstractFormula, untIDataSet, Classes, SysUtils,
  untICalculadorFormulaImobiliaria,
  untColorante, untIDicionario, Variants, untISaldosColorantes,
  untVariantUtils, untStrUtils, untGenericTintaDeMaquina,
  untTintaDeMaquinaComponenteComparerBaseImobiliaria,
  untITintaDeMaquinaComponente,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untTipoCadastro, untFloatUtils,
  untICalculadorFatVendasLibTintas;

Type
  ExceptionAutCom = Class(Exception);

type
  TAbstractFormulaImobiliaria = class abstract(TAbstractFormula)
  private
    strItemBaseOriginal: String;
    strItemBase: String;
    strUnidade: String;
    strDescricao: String;
    intMaxEmbalagem:Integer;
    strPromoc: String;
    strEmbalagem: TStringList;
    blnEhPromocaoPrecoFixo : Boolean;
    fltFatorPrecoFixo : Double;
    strBaseEntrouEmPromocaoPrecoFixo : String;
  private
    fltOutrosValores: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    fltPrecoVenda: Double;
    fltPrecoMedio: Double;
    fltUltimoPrecoCompra: Double;
    fltUltimoPrecoCompraImpostos: Double;
    fltPrecoCompraLiquido: Double;
  protected
    calculador: ICalculadorFormulaImobiliaria;
    BlnCalculaUnitario: Boolean;
    FTintaDeMaquina: TGenericTintaDeMaquina;
    fltPrecoCustoEmbalagem: Double;
    fltPrecoCustoRealEmbalagem: Double;
    fltPrecoVendaEmbalagem: Double;
    fltOutrosValoresEmbalagem: Double;
    fltIcmSaidaEmbalagem: Double;
    fltImpostosFederaisEmbalagem: Double;
    fltDespesasOperacionaisEmbalagem: Double;
    fltPrecoMedioEmbalagem: Double;
    fltPrecoUltimaCompraEmbalagem: Double;
    fltImpostosUltimaCompraEmbalagem: Double;
    fltPrecoCompraLiqEmbalagem: Double;

    fltBasePrecoCusto: Double;
    fltBasePrecoCustoReal: Double;
    fltBasePrecoVenda: Double;
    fltBaseOutrosValores: Double;
    fltBaseIcmsSaida: Double;
    fltBaseImpostosFederais: Double;
    fltBaseDespesasOperacionais: Double;
    fltPesoEspecificoBase: Double;
    fltBasePrecoMedio: Double;
    fltBasePrecoUltimaCompra: Double;
    fltImpostosUltimaCompraBase: Double;
    fltBasePrecoUltimaCompraImpostos: Double;
    fltBasePrecoCompraLiquido: Double;

    fltColPrecoCustoInd:Double;
    fltColPrecoCustoRealInd:Double;
    fltColPrecoVendaInd:Double;
    fltColOutrosValoresInd:Double;
    fltColIcmSaidaInd:Double;
    fltColImpostosFederaisInd:Double;
    fltColDespesasOperacionaisInd:Double;
    fltColPrecoMedioInd:Double;
    fltColPrecoUltimaCompraInd:Double;
    fltColImpostosUltimaCompraInd:Double;
    fltColPrecoCompraLiquidoInd:Double;




    dataSetColorantes: IDataSet;
    dataSetEmbalagens: IDataSet;
    dataSetBases: IDataSet;

    blnUsaCatalisador: Boolean;
    blnPersonalizada: Boolean;
    fltAcrMob: Double;
    strPromocaoPrecoFixoSobreValorFinal : String;
    strCalculouColorante : String;
    fltPrecoTotalColorantes : Double;

    strCodigoEmbalagemBase: string;
    strEmbalagemBase: String;
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria;
      virtual; abstract;
  protected
    strEmpPrd: String;
    strOprFlj: String;
    strEmpCd: String;
    strCD_S_N: String;
    strEmpFat: String;
    strFatS_N: String;
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

    function GetOutrosValoresIndustrial(): Double; virtual;
    function GetIcmsSaidaIndustrial(): Double; virtual;
    function GetImpostosFederaisIndustrial(): Double; virtual;
    function GetDespesasOperacionaisIndustrial(): Double; virtual;
    function GetPrecoMedioIndustrial(): Double; virtual;
    function GetUltimoPrecoCompraIndustrial(): Double; virtual;
    function GetUltimoPrecoCompraImpostosIndustrial(): Double; virtual;
    function GetPrecoCompraLiquidoIndustrial(): Double; virtual;
    function GetPrecoCustoIndustrial(): Double; virtual;
    function GetPrecoCustoRealIndustrial(): Double; virtual;
    function GetPrecoVendaIndustrial(): Double; virtual;

  protected
    function GetTintaDeMaquina(): TGenericTintaDeMaquina;
    procedure SetItemBase(const Value: String); virtual;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes
      : IDataSet; const colorante: TColorante); virtual;
    function GetDataSetColorantes(): IDataSet;
    function GetDataSetBases(): IDataSet;
    function GetDataSetEmbalagens(): IDataSet;
    procedure SetUsaCatalisador(const Value: Boolean);

    function GetVolumeColorante(): Double;
    function GetVolumeBase(): Double;
    function GetVolumeFinal(): Double;
    procedure SetVolumeFinal(const Value: Double);
    function GetTemCatalisador(): Boolean; virtual;

    function GetNomeTabelaColorantes(): String; virtual; abstract;
    function GetNomeCampoCustoBase: String; virtual; abstract;
    function GetNomeCampoVendaBase: String; virtual; abstract;
    function GetNomeTabelaBase: String; virtual; abstract;
    function GetNomeCampoBaseCodIte: String; virtual;
  public
    // Volumes
    dtsCadTin: IDataSet;
    fltVolumeBaseOriginal: Double;
    fltVolumeColorantesOriginal: Double;
    fltVolumeOriginal: Double;
    fltVolumeBase: Double;
    fltVolumeColorantes: Double;
    fltVolume: Double;
    procedure CarregarColorantes; virtual;
    procedure ZerarPrecos;
    procedure CarregarBases; virtual;
    procedure CarregarEmbalagens; virtual;
    procedure RecalcularTabelas(dicRetorno: IDicionario); override;
    function fRetornaTabelaColoranteTinta(): String; virtual;
    function GetItemBaseOriginal(const strIteTin: String): String;
      virtual; abstract;
    function GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
      virtual; abstract;
    function GetCodigoProdutoEmbalagem(): string; virtual;

    function GetDataSetMensAlerta(const dtsCadTin: IDataSet): IDataSet; virtual;
    function fUsaMensAlertaNovo(const dtsCadTin: IDataSet): Boolean; Virtual;
    Procedure GetDataSetMensAlertaNovo(const dtsCadTin: IDataSet); Virtual;
    function GetPrefixoFormulacaoCatalisador(): String; virtual;
    function GetPrefixoQuantidadeCatalisador(): String; virtual;
    function GetPrefixoFormulacaoBase(): String; Virtual;
    function GetPrefixoQuantidadeBase(): String; Virtual;
    function GetPrefixoPercentual(): String; Virtual;
    function GetPrefixoPercentualBase(): String; Virtual;

    function GetVolumeOriginal(const dtsCadTin: IDataSet):Double; virtual;
    function GetVolumeBaseOriginal(const dtsCadTin: IDataSet):Double; virtual;
    function GetVolumeColoranteOriginal(const dtsCadTin: IDataSet):Double; virtual;
    function GetUsaCatalisador(const dtsCadTin: IDataSet):Boolean; virtual;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); virtual;
    function fVerificaEmpresaSetada(): String; Virtual;





    procedure CarregaPrecosColorantes; virtual;
    procedure GetEmbalagensDisponivels(const dicEmbalagens: IDicionario;
      const dicCodigosEmbalagens: IDicionario; const dicProdutosBase: IDicionario); virtual;

    procedure CarregarPrecosBases; overload; virtual;
    procedure CarregarPrecosBasesEmbalagem(const strCodigoEmbalagemBase: string); virtual;
    procedure CarregaPrecosEmbalagens; virtual;
    procedure CalcularPrecosIndustrial; virtual;
    procedure CalcularPrecos; override;
    function GetCalculador(): ICalculadorFormulaImobiliaria;
    function GetSaldos: ISaldosColorantes; virtual;
    function GetNomeCampoColDesCol: String; virtual; abstract;
    function fMostraQuantidadeEmOnca(Var strOnca: String;
      const fltQtdCol: Double): Boolean; virtual;
    function fMostraQuantidadeAutomatica(const fltQtdCol: Double)
      : Boolean; Virtual;
    function fMostrarFormulacaoIndustrial(): Boolean; Virtual;

    function fUtilizaQuantidadeBase(): Boolean; Virtual;


    function GetQuantidadeDadosTintometricos(const dtsCadTin: IDataSet;
      strPrefixoQuantidade: String; strCont: String): Double; virtual;

    function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double)
      : Double; virtual;

    procedure MlParaOnca(fltMl: Double; var intParteInteira: Integer;
      var fltParteFracao: Double); virtual;

    {$IFNDEF LINUX}
    procedure pAjustaFormulacao(lsvFormulacao: TListView; Form: TForm); Virtual;
    procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Virtual;
    {$ENDIF}
    function fAlteraFormulacao(): Boolean; Virtual;

    function GetChaForEspecifico(const dicRetorno: IDicionario;
      const dtsCadTin: IDataSet): String; virtual;

  public
    calculadorFatVendas: ICalculadorFatVendasLibTintas;
    function GetUnidade(const dtsCadTin: IDataSet): String; virtual; abstract;
    function GetDescricao(const dtsCadTin: IDataSet): String; virtual; abstract;
  public
    constructor Create(const strTabPre: String);
    destructor Destroy; override;
  public
    property ItemBaseOriginal: String read strItemBaseOriginal
      write strItemBaseOriginal;
    property ItemBase: String read strItemBase write SetItemBase;
    property ColorantesDataSet: IDataSet read GetDataSetColorantes;
    property EmbalagensDataSet: IDataSet read GetDataSetEmbalagens;
    property UsaCatalisador: Boolean read blnUsaCatalisador
      write SetUsaCatalisador;
    property TemCatalisador: Boolean read GetTemCatalisador;
    property CodigoEmbalagemBase: string read strCodigoEmbalagemBase
      write strCodigoEmbalagemBase;
    property EmbalagemBase: string read strEmbalagemBase write strEmbalagemBase;
    property Personalizada: Boolean read blnPersonalizada
      write blnPersonalizada;
    property BasesDataSet: IDataSet read GetDataSetBases;

    property Unidade: String read strUnidade write strUnidade;
    property Descricao: String read strDescricao write strDescricao;
    property Promoc: String read strPromoc write strPromoc;

    property BasePrecoCusto: Double read fltBasePrecoCusto;
    property BasePrecoCustoReal: Double read fltBasePrecoCustoReal;
    property BasePrecoVenda: Double read fltBasePrecoVenda;
    property BaseOutrosValores: Double read fltBaseOutrosValores;
    property BaseIcmsSaida: Double read fltBaseIcmsSaida;
    property BaseImpostosFederais: Double read fltBaseImpostosFederais;
    property BaseDespesasOperacionais: Double read fltBaseDespesasOperacionais;
    property BasePesoEspecifico: Double read fltPesoEspecificoBase;
    property BaseImpostosUltimaCompra: Double read fltImpostosUltimaCompraBase;

    property ColorantePrecoCusto: Double read fltColPrecoCustoInd;
    property ColorantePrecoVenda: Double read fltColPrecoVendaInd;
    property ColorantePrecoCustoReal: Double read fltColPrecoCustoRealInd;
    property ColoranteOutrosValores:Double read fltColOutrosValoresInd;
    property ColoranteIcmsSaida: Double read fltColIcmSaidaInd;
    property ColoranteImpostosFederais: Double read fltColImpostosFederaisInd;
    property ColoranteDespesasOperacionais: Double read fltColDespesasOperacionaisInd;
    property ColorantePrecoMedio: Double read fltColPrecoMedioInd;
    property ColorantePrecoUltimaCompra: Double read fltColPrecoUltimaCompraInd;
    property ColoranteImpostosUltimaCompra: Double read fltColImpostosUltimaCompraInd;
    property ColorantePrecoCompraLiquido: Double read fltColPrecoCompraLiquidoInd;


    property PrecoCustoEmbalagem: Double read fltPrecoCustoEmbalagem;
    property PrecoCustoRealEmbalagem: Double read fltPrecoCustoRealEmbalagem;
    property PrecoVendaEmbalagem: Double read fltPrecoVendaEmbalagem;
    property OutrosValoresEmbalagem: Double read fltOutrosValoresEmbalagem;
    property IcmSaidaEmbalagem: Double read fltIcmSaidaEmbalagem;
    property ImpostosFederaisEmbalagem: Double read fltImpostosFederaisEmbalagem;
    property DespesasOperacionaisEmbalagem: Double read fltDespesasOperacionaisEmbalagem;
    property PrecoMedioEmbalagem: Double read fltPrecoMedioEmbalagem;
    property PrecoUltimaCompraEmbalagem: Double read fltPrecoUltimaCompraEmbalagem;
    property ImpostosUltimaCompraEmbalagem: Double read fltImpostosUltimaCompraEmbalagem;
    property PrecoCompraLiqEmbalagem: Double read fltPrecoCompraLiqEmbalagem;
    property MaxEmbalagem: Integer read intMaxEmbalagem write intMaxEmbalagem;
    property DescEmbalagem: TStringList read strEmbalagem;

    property VolumeBase: Double read GetVolumeBase;
    property VolumeColorantes: Double read GetVolumeColorante;
    property VolumeFinal: Double read GetVolumeFinal write SetVolumeFinal;
    property VolumeOriginal: Double read fltVolumeOriginal;

    property BasePrecoMedio: Double read fltBasePrecoMedio write fltBasePrecoMedio;
    property BasePrecoUltimaCompra: Double read fltBasePrecoUltimaCompra write fltBasePrecoUltimaCompra;
    property BasePrecoUltimaCompraImpostos: Double read fltBasePrecoUltimaCompraImpostos write fltBasePrecoUltimaCompraImpostos;
    property BasePrecoCompraLiquido: Double read fltBasePrecoCompraLiquido write fltBasePrecoCompraLiquido;

    property OutrosValoresIndustrial: Double read GetOutrosValoresIndustrial;
    property IcmsSaidaIndustrial: Double read GetIcmsSaidaIndustrial;
    property ImpostosFederaisIndustrial: Double read GetImpostosFederaisIndustrial;
    property DespesasOperacionaisIndustrial: Double read GetDespesasOperacionaisIndustrial;

    property PrecoMedioIndustrial: Double read GetPrecoMedioIndustrial;
    property UltimoPrecoCompraIndustrial: Double read GetUltimoPrecoCompraIndustrial;
    property UltimoPrecoCompraImpostosIndustrial: Double read GetUltimoPrecoCompraImpostosIndustrial;
    property PrecoCompraLiquidoIndustrial: Double read GetPrecoCompraLiquidoIndustrial;

    property PrecoCustoIndustrial: Double read GetPrecoCustoIndustrial;
    property PrecoVendaIndustrial: Double read GetPrecoVendaIndustrial;
    property PrecoCustoRealIndustrial: Double read GetPrecoCustoRealIndustrial;

    property tintaDeMaquina: TGenericTintaDeMaquina read FTintaDeMaquina;

    property EmpPrd: String Read strEmpPrd Write strEmpPrd;
    property OprFlj: String Read strOprFlj Write strOprFlj;
    property EmpCd_: String Read strEmpCd  Write strEmpCd;
    property Cd_S_N: String Read strCD_S_N Write strCD_S_N;
    property EmpFat: String Read strEmpFat Write strEmpFat;
    property FatS_N: String Read strFatS_N Write strFatS_N;
    property AcrMob: Double Read fltAcrMob Write fltAcrMob;
    property PromocaoPrecoFixoSobreValorFinal : String read strPromocaoPrecoFixoSobreValorFinal write strPromocaoPrecoFixoSobreValorFinal;
    property CalculouColorante : String read strCalculouColorante write strCalculouColorante;
    property PrecoTotalColorantes : Double read fltPrecoTotalColorantes write fltPrecoTotalColorantes;
  end;

implementation

uses
  untAutcomTintaFactory, untGenericSaldosColorantes;

{ TAbstractFormulaImobiliaria }

procedure TAbstractFormulaImobiliaria.CalcularPrecos;
begin
  GetCalculador.Calcular;

  fltPrecoVenda := GetCalculador.PrecoVenda;
  fltPrecoCusto := GetCalculador.PrecoCusto;
  fltPrecoCustoReal := GetCalculador.PrecoCustoReal;
  fltOutrosValores := GetCalculador.OutrosValores;
  fltIcmsSaida := GetCalculador.IcmsSaida;
  fltImpostosFederais := GetCalculador.ImpostosFederais;
  fltDespesasOperacionais := GetCalculador.DespesasOperacionais;

  fltPrecoMedio := GetCalculador.PrecoMedio;
  fltUltimoPrecoCompra := GetCalculador.UltimoPrecoCompra;
  fltUltimoPrecoCompraImpostos := GetCalculador.UltimoPrecoCompraImpostos;
  fltPrecoCompraLiquido := GetCalculador.PrecoCompraLiquido;
end;

function TAbstractFormulaImobiliaria.fAlteraFormulacao: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.fMostraQuantidadeAutomatica(const fltQtdCol
  : Double): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.fMostraQuantidadeEmOnca
  (Var strOnca: String; const fltQtdCol: Double): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.fMostrarFormulacaoIndustrial: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.fRetornaTabelaColoranteTinta: String;
begin
  Result := GetNomeTabelaColorantes;
end;

function TAbstractFormulaImobiliaria.fUsaMensAlertaNovo(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.fUtilizaQuantidadeBase: Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.fVerificaEmpresaSetada: String;
begin
  If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    Result := Self.EmpPrd
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    Result := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    Result := Self.EmpFat
  Else
    Result := TAutcomTintaFactory.Get.GetCodEmp;
end;

function TAbstractFormulaImobiliaria.GetCalculador
  : ICalculadorFormulaImobiliaria;
begin
  if not Assigned(calculador) then
    calculador := GetCalculadorInterno;

  Result := calculador;
end;


function TAbstractFormulaImobiliaria.GetChaForEspecifico(const dicRetorno
  : IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := dicRetorno['chafor'];
end;

function TAbstractFormulaImobiliaria.GetCodigoProdutoEmbalagem: string;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetDataSetBases: IDataSet;
begin
  If Not Assigned(dataSetBases) Then
  Begin
    dataSetBases := TAutcomTintaFactory.Get.fGetDataSet;
  End;

  Result := dataSetBases;
end;

function TAbstractFormulaImobiliaria.GetDataSetColorantes: IDataSet;
begin
  if not Assigned(dataSetColorantes) then
  begin
    dataSetColorantes := TAutcomTintaFactory.Get.fGetDataSet;
  end;

  Result := dataSetColorantes;
end;

function TAbstractFormulaImobiliaria.GetDataSetEmbalagens: IDataSet;
begin
  If Not Assigned(dataSetEmbalagens) Then
  Begin
    dataSetEmbalagens := TAutcomTintaFactory.Get.fGetDataSet;
  End;

  Result := dataSetEmbalagens;
end;

function TAbstractFormulaImobiliaria.GetDespesasOperacionais: Double;
begin
  Result := fltDespesasOperacionais;
end;

function TAbstractFormulaImobiliaria.GetDespesasOperacionaisIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColDespesasOperacionaisInd + fltDespesasOperacionaisEmbalagem
  Else
    Result := fltColDespesasOperacionaisInd + fltBaseDespesasOperacionais;
end;

procedure TAbstractFormulaImobiliaria.GetEmbalagensDisponivels(
  const dicEmbalagens, dicCodigosEmbalagens, dicProdutosBase: IDicionario);
begin
  //
end;

function TAbstractFormulaImobiliaria.GetIcmsSaida: Double;
begin
  Result := fltIcmsSaida;
end;

function TAbstractFormulaImobiliaria.GetIcmsSaidaIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColIcmSaidaInd + fltIcmSaidaEmbalagem
  Else
    Result := fltColIcmSaidaInd + fltBaseIcmsSaida;
end;

function TAbstractFormulaImobiliaria.GetImpostosFederais: Double;
begin
  Result := fltImpostosFederais;
end;

function TAbstractFormulaImobiliaria.GetImpostosFederaisIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColImpostosFederaisInd + fltImpostosFederaisEmbalagem
  Else
    Result := fltColImpostosFederaisInd + fltBaseImpostosFederais;
end;

function TAbstractFormulaImobiliaria.GetDataSetMensAlerta(const dtsCadTin
  : IDataSet): IDataSet;
begin
  Result := Nil;
end;

procedure TAbstractFormulaImobiliaria.GetDataSetMensAlertaNovo(
  const dtsCadTin: IDataSet);
begin
  //
end;

function TAbstractFormulaImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TAbstractFormulaImobiliaria.GetOutrosValores: Double;
begin
  Result := fltOutrosValores;
end;

function TAbstractFormulaImobiliaria.GetOutrosValoresIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColOutrosValoresInd + fltOutrosValoresEmbalagem
  Else
    Result := fltColOutrosValoresInd + fltBaseOutrosValores;
end;

function TAbstractFormulaImobiliaria.GetPrecoCompraLiquido: Double;
begin
  Result := fltPrecoCompraLiquido;
end;

function TAbstractFormulaImobiliaria.GetPrecoCompraLiquidoIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColPrecoCompraLiquidoInd + fltPrecoCompraLiqEmbalagem
  Else
    Result := fltColPrecoCompraLiquidoInd + fltBasePrecoCompraLiquido;
end;

function TAbstractFormulaImobiliaria.GetPrecoCusto: Double;
begin
  Result := fltPrecoCusto;
end;

function TAbstractFormulaImobiliaria.GetPrecoCustoIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColPrecoCustoInd + fltPrecoCustoEmbalagem
  Else
    Result := fltColPrecoCustoInd + fltBasePrecoCusto;
end;

function TAbstractFormulaImobiliaria.GetPrecoCustoReal: Double;
begin
  Result := fltPrecoCustoReal;
end;

function TAbstractFormulaImobiliaria.GetPrecoCustoRealIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColPrecoCustoRealInd + fltPrecoCustoRealEmbalagem
  Else
    Result := fltColPrecoCustoRealInd + fltBasePrecoCustoReal;
end;

function TAbstractFormulaImobiliaria.GetPrecoMedio: Double;
begin
  Result := fltPrecoMedio;
end;

function TAbstractFormulaImobiliaria.GetPrecoMedioIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColPrecoMedioInd + fltPrecoMedioEmbalagem
  Else
    Result := fltColPrecoMedioInd + fltBasePrecoMedio;
end;

function TAbstractFormulaImobiliaria.GetPrecoVenda: Double;
begin
  Result := fltPrecoVenda;
end;

function TAbstractFormulaImobiliaria.GetPrecoVendaIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColPrecoVendaInd + fltPrecoVendaEmbalagem
  Else
    Result := fltColPrecoVendaInd + fltBasePrecoVenda;
end;

function TAbstractFormulaImobiliaria.GetPrefixoPercentualBase: String;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetPrefixoFormulacaoBase: String;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetPrefixoFormulacaoCatalisador: String;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetPrefixoPercentual: String;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetPrefixoQuantidadeBase: String;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetPrefixoQuantidadeCatalisador: String;
begin
  Result := '';
end;

function TAbstractFormulaImobiliaria.GetQuantidadeDadosTintometricos
  (const dtsCadTin: IDataSet; strPrefixoQuantidade, strCont: String): Double;
begin
  Result := dtsCadTin.FieldByName(strPrefixoQuantidade + strCont).AsFloat;
end;

function TAbstractFormulaImobiliaria.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  colorante: TColorante;
begin
  saldos := TGenericSaldosColorantes.Create();

  for intCont := 0 to Self.Count - 1 do
  begin
    colorante := TColorante(Self.Items[intCont]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);

    if colorante.Quantidade > 0 then
    begin
      saldos.Adicionar(TGenericSaldoColorante.Create(1,
        Descricao,
        GetDataSetColorantes.FieldByName('COL_CODITE').AsString,
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
        ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE',
        'ITE_DESITE', [GetDataSetColorantes.FieldByName('COL_CODITE').AsString]
        ), ''),
        colorante.CodigoColorante,
        colorante.Quantidade * FatorEstoque,
        COLORANTE_IMOBILIARIO,
        'N',
        0.0));
    end;
  end;

  saldos.Adicionar(TGenericSaldoColorante.Create(1,
    Descricao,
    ItemBase,
    VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
    ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE',
    [ItemBase]), ''),
    ItemBase,
    1,
    BASE_IMOBILIARIA,
    'N',
    0.0));

  Result := saldos;
end;

function TAbstractFormulaImobiliaria.GetTemCatalisador(): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.GetTintaDeMaquina: TGenericTintaDeMaquina;
begin
  Result := FTintaDeMaquina;
end;

function TAbstractFormulaImobiliaria.GetUltimoPrecoCompra: Double;
begin
  Result := fltUltimoPrecoCompra;
end;

function TAbstractFormulaImobiliaria.GetUltimoPrecoCompraImpostos: Double;
begin
  Result := fltUltimoPrecoCompraImpostos;
end;

function TAbstractFormulaImobiliaria.GetUltimoPrecoCompraImpostosIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColImpostosUltimaCompraInd + fltImpostosUltimaCompraEmbalagem
  Else
    Result := fltColImpostosUltimaCompraInd + fltImpostosUltimaCompraBase;
end;

function TAbstractFormulaImobiliaria.GetUltimoPrecoCompraIndustrial: Double;
begin
  If blnPersonalizada Then
    Result := fltColPrecoUltimaCompraInd + fltPrecoUltimaCompraEmbalagem
  Else
    Result := fltColPrecoUltimaCompraInd + fltBasePrecoUltimaCompra;
end;

function TAbstractFormulaImobiliaria.GetUsaCatalisador(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := False;
end;

function TAbstractFormulaImobiliaria.GetVolumeBase: Double;
begin
  Result := fltVolumeBase;
end;

function TAbstractFormulaImobiliaria.GetVolumeBaseOriginal(
  const dtsCadTin: IDataSet): Double;
begin
  Result := 1;
end;

function TAbstractFormulaImobiliaria.GetVolumeColorante: Double;
Var
  intContador: Integer;
begin
  Result := 0;
  For intContador := 0 To Self.Count - 1 Do
  Begin
    Result := Result + TColorante(Self.Items[intContador]).Quantidade;
  End;
end;

function TAbstractFormulaImobiliaria.GetVolumeColoranteOriginal(
  const dtsCadTin: IDataSet): Double;
begin
  Result := 1;
end;

function TAbstractFormulaImobiliaria.GetVolumeFinal: Double;
begin
  If fltVolume = 0 Then
    SetVolumeFinal(fltVolumeOriginal);

  Result := fltVolumeBase + fltVolumeColorantes;
end;

function TAbstractFormulaImobiliaria.GetVolumeOriginal(
  const dtsCadTin: IDataSet): Double;
begin
  Result := 1;
end;

procedure TAbstractFormulaImobiliaria.MlParaOnca(fltMl: Double;
  var intParteInteira: Integer; var fltParteFracao: Double);
var
  fltCalculo: Double;
begin
  fltCalculo := ((fltMl / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := TAutcomTintaFactory.Get.fStrToFloat
    (FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
end;

function TAbstractFormulaImobiliaria.OncaParaMl(intParteInteira: Integer;
  fltParteFracao: Double): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat
    (FormatFloat('0.000', (intParteInteira * 29.5735295625) +
    (fltParteFracao * 0.61611520)));
end;

{$IFNDEF LINUX}
procedure TAbstractFormulaImobiliaria.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
begin
  //
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TAbstractFormulaImobiliaria.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  //
end;
{$ENDIF}

procedure TAbstractFormulaImobiliaria.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := 0;
end;

procedure TAbstractFormulaImobiliaria.CalcularPrecosIndustrial;
begin
  GetCalculador.Calcular;

  fltPrecoVenda := GetCalculador.PrecoVenda;
  fltPrecoCusto := GetCalculador.PrecoCusto;
  fltPrecoCustoReal := GetCalculador.PrecoCustoReal;
  fltOutrosValores := GetCalculador.OutrosValores;
  fltIcmsSaida := GetCalculador.IcmsSaida;
  fltImpostosFederais := GetCalculador.ImpostosFederais;
  fltDespesasOperacionais := GetCalculador.DespesasOperacionais;

  fltPrecoMedio := GetCalculador.PrecoMedio;
  fltUltimoPrecoCompra := GetCalculador.UltimoPrecoCompra;
  fltUltimoPrecoCompraImpostos := GetCalculador.UltimoPrecoCompraImpostos;
  fltPrecoCompraLiquido := GetCalculador.PrecoCompraLiquido;
end;

procedure TAbstractFormulaImobiliaria.CarregaPrecosColorantes;
var
  intContador: Integer;
  colorante: TColorante;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  strCodEmpresa: String;
  blnEmPromo: Boolean;
  blnPrecoFixoCol : Boolean;
begin

  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro)
    .fGetDouble('DESOPE');

  strCodEmpresa := fVerificaEmpresaSetada();

  For intContador := 0 To Self.Count - 1 Do
  Begin
    colorante := TColorante(Self.Items[intContador]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);
    colorante.DescricaoColorante := GetDataSetColorantes.FieldByName('COL_DESCRI').AsString;
    colorante.OutrosValores := GetDataSetColorantes.FieldByName('ITE_OUTVAL').AsFloat;

    colorante.CodIte := GetDataSetColorantes.FieldByName('COL_CODITE').AsString;
    colorante.ImpDir := GetDataSetColorantes.FieldByName('ITE_IMPDIR').AsString;

    If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
      colorante.IcmsSaida := calculadorFatVendas.fCalculaAliquota(colorante.CodIte, colorante.ImpDir)
    Else
      colorante.IcmsSaida := GetDataSetColorantes.FieldByName('ITE_ICMSAI').AsFloat;

    colorante.ImpostosFederais := GetDataSetColorantes.FieldByName('ITE_IMPFED').AsFloat;
    colorante.DespesasOperacionais := GetDataSetColorantes.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

    colorante.PrecoMedio := GetDataSetColorantes.FieldByName('ITE_PREMED').AsFloat;
    colorante.UltimoPrecoCompra := GetDataSetColorantes.FieldByName('ITE_PREULT').AsFloat;
    colorante.UltimoPrecoCompraImpostos := GetDataSetColorantes.FieldByName('ITE_IMPULT').AsFloat;
    colorante.PrecoCompraLiquido := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                              GetDataSetColorantes.FieldByName('ITE_PRECOM').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF01').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF02').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF03').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF04').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF05').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF06').AsFloat),
                                                              TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

    blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetColorantes.FieldByName('COL_CODITE').AsString,
                                                           strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                           fltPreCus, fltPreVen, blnPrecoFixoCol,
                                                           strCodEmpresa);

    If (Self.strBaseEntrouEmPromocaoPrecoFixo = 'S') And (TFloatUtils.fFormataFloat(Self.fltFatorPrecoFixo, 2) > 0) Then
    Begin
      Self.Promoc := 'S';
      colorante.PrecoCusto := fltPreCus;
      If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := TFloatUtils.fFormataFloat(GetDataSetColorantes.FieldByName('ITE_PREVEN').AsFloat * Self.fltFatorPrecoFixo, 2);
      If colorante.PrecoCusto = 0 Then
        colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else If (blnEmPromo) And (Not Self.blnProPre) And (TAutcomTintaFactory.Get.fCfgSis('COLPRO') = '2') then
    begin
      colorante.PrecoCusto := fltPreCus;

      If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := fltPreVen;

      If strTabPre = strTabPreTin Then
        Self.Promoc := 'S';

      If colorante.PrecoCusto = 0 Then
        colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;
    end
    else
    begin
      colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;

      If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := GetDataSetColorantes.FieldByName('ITE_PREVEN').AsFloat;

      If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
        Self.Promoc := 'S';

      // Self.Promoc := 'N';
    end;
    CarregaPrecosColorantesAdicional(GetDataSetColorantes, colorante);
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TAbstractFormulaImobiliaria.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
end;

procedure TAbstractFormulaImobiliaria.CarregaPrecosEmbalagens;
begin
  Try
    Try
      Self.fltPrecoCustoEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_PRECUS').AsFloat;
      Self.fltPrecoVendaEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_PREVEN').AsFloat;
      Self.fltPrecoCustoRealEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_PREVEN').AsFloat;
      Self.fltOutrosValoresEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_OUTVAL').AsFloat;
      Self.fltIcmSaidaEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_ICMSAI').AsFloat;
      Self.fltImpostosFederaisEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_IMPFED').AsFloat;
      Self.fltDespesasOperacionaisEmbalagem := GetDataSetEmbalagens.FieldByName('ITE_DESOPE').AsFloat;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally

  End;
end;

procedure TAbstractFormulaImobiliaria.CarregarBases;
begin
  //
end;

procedure TAbstractFormulaImobiliaria.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ';

  If Self.GetIdePro = 'INK' Then
    strSql := strSQL + '  , COL_EMBALA   ';

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , ' + GetNomeCampoColDesCol
  else
    strSql := strSql + ', "" AS COL_DESCRI ';

  strSql := strSql +
    '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' +
    '   , ITE_OUTVAL ' +
    '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ' +
    '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' +
    '   , ITE_PREULT ' +
    '   , ITE_PRECOM ' +
    '   , ITE_DESF01 ' +
    '   , ITE_DESF02 ' +
    '   , ITE_DESF03 ' +
    '   , ITE_DESF04 ' +
    '   , ITE_DESF05 ' +
    '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    strSql := strSql + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' +     GetNomeTabelaColorantes + ' C ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON C.COL_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON C.COL_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  GetDataSetColorantes.SQL := strSql;

  If Not (TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If Not (TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetCOlorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;
end;

procedure TAbstractFormulaImobiliaria.CarregarEmbalagens;
begin
  //
end;

procedure TAbstractFormulaImobiliaria.CarregarPrecosBases;
begin
  //
end;

procedure TAbstractFormulaImobiliaria.CarregarPrecosBasesEmbalagem
  (const strCodigoEmbalagemBase: string);
begin
  //
end;

constructor TAbstractFormulaImobiliaria.Create(const strTabPre: String);
begin
  inherited Create(TColorante);
  Self.strTabPre := strTabPre;
  Self.strTabPreTin := strTabPre;
  Self.blnPersonalizada := False;
  Self.BlnCalculaUnitario := True;
  Self.blnEhPromocaoPrecoFixo := False;
  Self.fltFatorPrecoFixo := 0;
  Self.strBaseEntrouEmPromocaoPrecoFixo := '';
  Self.strCalculouColorante := '';
  Self.fltPrecoTotalColorantes := 0;
  FTintaDeMaquina := TGenericTintaDeMaquina.Create();
  strEmbalagem := TStringList.Create;

  If TStrUtils.fEmptyStr(Self.strTabPre) Then
    Self.strTabPre := '1';

  CarregarBases;
  CarregarEmbalagens;
end;

destructor TAbstractFormulaImobiliaria.Destroy;
begin
  dataSetColorantes := nil;
  dataSetEmbalagens := nil;
  dataSetBases := nil;
  FreeAndNil(strEmbalagem);
  ZerarPrecos;
  inherited;
end;

procedure TAbstractFormulaImobiliaria.RecalcularTabelas
  (dicRetorno: IDicionario);
var
  strTabelas: String;
  intContador: Integer;
  strTabelaUnica: String;
  strTabelaAtual: String;
begin
  strTabelaUnica := TVariantUtils.IfNull(dicRetorno['tabelaunica'], '');

  Self.BlnCalculaUnitario := False;

  strTabPreTin := TVariantUtils.IfNull(dicRetorno['tabpre'],0);

  Self.Promoc := 'N';

  If (not TStrUtils.fEmptyStr(strTabelaUnica)) Then
  Begin
    Self.strTabPre := strTabelaUnica;
    Self.fltBasePrecoCusto := 0.0;
    Self.fltBasePrecoCustoReal := 0.0;

    Self.CarregarColorantes;

    Self.SetItemBase(Self.strItemBase);

    If Not Self.fMostrarFormulacaoIndustrial Then
    Begin
      Self.CarregaPrecosColorantes;
      Self.CalcularPrecos;

      If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
        dicRetorno['preve' + strTabelaUnica] := (Self.PrecoVenda + Self.BasePrecoVenda) * (1 + Self.AcrMob / 100)
      Else
        dicRetorno['preve' + strTabelaUnica] := Self.PrecoVenda + Self.BasePrecoVenda + Self.AcrMob;

      dicRetorno['promoc'] := Self.Promoc;
      dicRetorno['outval'] := Self.OutrosValores + Self.BaseOutrosValores;
      dicRetorno['icmsai'] := Self.IcmsSaida + Self.BaseIcmsSaida;
      dicRetorno['impfed'] := Self.ImpostosFederais + Self.BaseImpostosFederais;
      dicRetorno['desope'] := Self.DespesasOperacionais + Self.BaseDespesasOperacionais;
    End
    Else
    Begin
      Self.CarregarBases;
      Self.CalcularPrecosIndustrial;

      If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
        dicRetorno['preve' + strTabelaUnica] := Self.PrecoVendaIndustrial * (1 + Self.AcrMob / 100)
      Else
        dicRetorno['preve' + strTabelaUnica] := Self.PrecoVendaIndustrial + Self.AcrMob;

      dicRetorno['promoc'] := Self.Promoc;
      dicRetorno['outval'] := Self.OutrosValoresIndustrial;
      dicRetorno['icmsai'] := Self.IcmsSaidaIndustrial;
      dicRetorno['impfed'] := Self.ImpostosFederaisIndustrial;
      dicRetorno['desope'] := Self.DespesasOperacionaisIndustrial;
    End;
  End
  Else
  Begin
    strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
    If Length(strTabelas) < 7 Then
      strTabelas := strTabelas + StringOfChar('N', 7 - Length(strTabelas));

    strTabelaAtual := Self.strTabPre;
    For intContador := 1 To Length(strTabelas) Do
    Begin
      If strTabelas[intContador] = 'S' Then
      Begin
        Self.strTabPre := IntToStr(intContador);
        Self.fltBasePrecoCusto := 0.0;
        Self.fltBasePrecoCustoReal := 0.0;

        Self.CarregarColorantes;
        Self.SetItemBase(Self.strItemBase);

        If Not Self.fMostrarFormulacaoIndustrial Then
        Begin
          Self.CarregaPrecosColorantes;
          Self.CalcularPrecos;


          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (Self.PrecoVenda + Self.BasePrecoVenda) * (1 + Self.AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := Self.PrecoVenda + Self.BasePrecoVenda + Self.AcrMob;

          if intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) then
          begin
            dicRetorno['promoc'] := Self.Promoc;

            dicRetorno['outval'] := Self.OutrosValores + Self.BaseOutrosValores;
            dicRetorno['icmsai'] := Self.IcmsSaida + Self.BaseIcmsSaida;
            dicRetorno['impfed'] := Self.ImpostosFederais + Self.BaseImpostosFederais;
            dicRetorno['desope'] := Self.DespesasOperacionais + Self.BaseDespesasOperacionais;
          end;
        End
        Else
        Begin
          Self.CarregarBases;
          Self.CalcularPrecosIndustrial;

          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := Self.PrecoVendaIndustrial * (1 + Self.AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := Self.PrecoVendaIndustrial + Self.AcrMob;

          If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
          Begin
            dicRetorno['promoc'] := Self.Promoc;
            dicRetorno['outval'] := Self.OutrosValoresIndustrial;
            dicRetorno['icmsai'] := Self.IcmsSaidaIndustrial;
            dicRetorno['impfed'] := Self.ImpostosFederaisIndustrial;
            dicRetorno['desope'] := Self.DespesasOperacionaisIndustrial;
          End;
        End;
      End;
    End;
    Self.strTabPre := strTabelaAtual;
  End;

end;

procedure TAbstractFormulaImobiliaria.SetItemBase(const Value: String);
var
  dataSetCalculo: IDataSet;
  strSql: String;
  fltPreCusPro, fltPreVenPro: Double;
  fltDesOpeTinta: Double;
  fltPerAcr: Double;
  base: ITintaDeMaquinaComponente;
  strCodEmpresa: String;
  blnEmPromo: Boolean;

  function fPrecoCusto2Base: Double;
  var
    dicDados: IDicionario;
  begin
    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
    dicDados['precus'] := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
    dicDados['outval'] := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;

    If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      dicDados['icmsai'] := calculadorFatVendas.fCalculaAliquota(Value, dataSetCalculo.FieldByName('ITE_IMPDIR').AsString)
    Else
      dicDados['icmsai'] := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat;

    dicDados['impfed'] := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat;
    dicDados['desope'] := dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

    Result := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
  end;

begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Value)));

  Self.strItemBase := Value;
  dataSetCalculo := nil;

  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');
  fltPerAcr := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('APREVE') / 100.0;

  strCodEmpresa := fVerificaEmpresaSetada();

  Try
    Try
      Self.blnEhPromocaoPrecoFixo := False;
      Self.fltFatorPrecoFixo := 0;
      Self.strBaseEntrouEmPromocaoPrecoFixo := '';

      dataSetCalculo := TAutcomTintaFactory.Get.fGetDataSet;
      strSql := ' SELECT          ' +
                '     I.ITE_ITEATI  ' +
                '   , I.ITE_CODITE  ' +
                '   , ITE_OUTVAL    ' +
                '   , ITE_ICMSAI    ' +
                '   , ITE_IMPFED    ' +
                '   , ITE_DESOPE    ' +
                '   , ITE_PREMED    ' +
                '   , ITE_PREULT    ' +
                '   , ITE_IMPULT    ' +
                '   , ITE_PRECOM    ' +
                '   , ITE_DESF01    ' +
                '   , ITE_DESF02    ' +
                '   , ITE_DESF03    ' +
                '   , ITE_DESF04    ' +
                '   , ITE_DESF05    ' +
                '   , ITE_DESF06    ';

      If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
        strSql := strSql + '   , I.ITE_IMPDIR  '
      else
        strSql := strSql + '   , G.ITE_IMPDIR  ';

      If Value = strItemBaseOriginal Then
      Begin

        If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
        begin
          strSql := strSql + '   , ' + GetNomeCampoCustoBase + ' AS ITE_PRECUS ' + '   , ' + GetNomeCampoVendaBase + ' AS ITE_PREVEN ';
        end
        Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
        Begin
          strSql := strSql + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
        End
        Else
        Begin
          strSql := strSql + '   , ITE_PRECUS ' +
                             '   , ITE_PREVE'+ Self.strTabPre + ' AS ITE_PREVEN ';
        End;

        strSql := strSql +
        ' FROM                             ' +
        '   ' + GetNomeTabelaBase + ' B                   ' +
          '   INNER JOIN ITEGER G            ' +
          '     ON ' + GetNomeCampoBaseCodIte + ' = G.ITE_CODITE ' +
          ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ' +
          ' WHERE G.ITE_CODEMP = :CODEMP       ' +
          '   AND G.ITE_CODITE = :CODITE       ';
      End
      Else
      Begin

        If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
        Begin
          strSql := strSql + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
        End
        Else
        Begin
          strSql := strSql + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ Self.strTabPre + ' AS ITE_PREVEN ';
        End;

        strSql := strSql +
          ' FROM                             ' +
          '   ITEGER G                       ' +
          ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ' +
          ' WHERE G.ITE_CODEMP = :CODEMP       ' +
          '   AND G.ITE_CODITE = :CODITE       ';
      End;

      dataSetCalculo.SQL := strSql;

      If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
        dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        dataSetCalculo.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

      dataSetCalculo.ParamByName('CODITE').AsString := Value;
      dataSetCalculo.Open;

      If (dataSetCalculo.FieldByName('ITE_ITEATI').AsString = 'N') Then
      begin
        raise ExceptionAutCom.CreateFmt('O produto Base %s não está ativo, Favor verificar!', [Value]);
      end;

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(dataSetCalculo.FieldByName('ITE_CODITE').AsString, strTabPre,
                                                             Self.strCodCli, Self.strCodCnd, Self.intPrzMed, fltPreCusPro,
                                                             fltPreVenPro, Self.blnEhPromocaoPrecoFixo,
                                                             strCodEmpresa, TFloatUtils.fFormataFloat(fltPrecoTotalColorantes, 2));

      If (blnEmPromo) And (Not Self.blnProPre) And (Self.blnEhPromocaoPrecoFixo) Then
      Begin
        Self.strPromocaoPrecoFixoSobreValorFinal := 'S';
        blnEmPromo := (Self.strCalculouColorante = 'S');
      End;

      If (Self.strCalculouColorante = 'S') And (Self.strPromocaoPrecoFixoSobreValorFinal = 'S') Then
      begin
        Self.fltFatorPrecoFixo := (fltPreVenPro / (dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat + TFloatUtils.fFormataFloat(fltPrecoTotalColorantes, 2)));
        If (TFloatUtils.fFormataFloat(Self.fltFatorPrecoFixo, 2) > 0) Then
          fltPreVenPro := fltPreVenPro - TFloatUtils.fFormataFloat(fltPrecoTotalColorantes * fltFatorPrecoFixo, 2);
      End;

      If (blnEmPromo) And (Not Self.blnProPre) Then
      Begin
        fltBasePrecoVenda := fltPreVenPro;
        fltBasePrecoCusto := fltPreCusPro;

        If strTabPre = strTabPreTin Then
          strPromoc := 'S';

        If fltBasePrecoCusto = 0 Then
          fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        fltBasePrecoVenda := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
        fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          strPromoc := 'S';

       // strPromoc := 'N';
      End;

      If (blnEmPromo) And (Not Self.blnProPre) And (Self.blnEhPromocaoPrecoFixo) Then
        Self.strBaseEntrouEmPromocaoPrecoFixo := strPromoc;

      fltBasePrecoCustoReal := fPrecoCusto2Base;

      fltBasePrecoMedio := dataSetCalculo.FieldByName('ITE_PREMED').AsFloat;
      fltBasePrecoUltimaCompra := dataSetCalculo.FieldByName('ITE_PREULT').AsFloat;
      fltBasePrecoUltimaCompraImpostos := dataSetCalculo.FieldByName('ITE_IMPULT').AsFloat;
      fltBasePrecoCompraLiquido := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                              dataSetCalculo.FieldByName('ITE_PRECOM').AsFloat,
                                                              dataSetCalculo.FieldByName('ITE_DESF01').AsFloat,
                                                              dataSetCalculo.FieldByName('ITE_DESF02').AsFloat,
                                                              dataSetCalculo.FieldByName('ITE_DESF03').AsFloat,
                                                              dataSetCalculo.FieldByName('ITE_DESF04').AsFloat,
                                                              dataSetCalculo.FieldByName('ITE_DESF05').AsFloat,
                                                              dataSetCalculo.FieldByName('ITE_DESF06').AsFloat),
                                                              TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));;

      fltBaseOutrosValores := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;

      fltBasePrecoVenda := fltBasePrecoVenda * (1 + fltPerAcr);

      if TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And
        Assigned(calculadorFatVendas) then
      begin
        fltBaseIcmsSaida := calculadorFatVendas.fCalculaAliquota(Value, dataSetCalculo.FieldByName('ITE_IMPDIR').AsString);
        fltBaseIcmsSaida := fltBaseIcmsSaida * fltBasePrecoVenda / 100;
      end
      else
        fltBaseIcmsSaida := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat * fltBasePrecoVenda / 100;

      fltBaseImpostosFederais     := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat * fltBasePrecoVenda / 100;
      fltBaseDespesasOperacionais := (((dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * fltBasePrecoVenda) / 100);

      base := tintaDeMaquina.Localizar
        (TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Value));
      if not Assigned(base) then
      begin
        base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create
          (Value, TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(Value,
          ttBases), fltBaseDespesasOperacionais, fltBaseIcmsSaida,
          fltBaseImpostosFederais, fltBaseOutrosValores, fltBasePrecoCusto,
          fltBasePrecoCustoReal, fltBasePrecoMedio, fltBasePrecoVenda, 1,
          tmctBaseImobiliaria, fltBasePrecoUltimaCompra,
          fltBasePrecoUltimaCompraImpostos, fltBasePrecoCompraLiquido));
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TAbstractFormulaImobiliaria.SetUsaCatalisador(const Value: Boolean);
begin
  blnUsaCatalisador := Value;
end;

procedure TAbstractFormulaImobiliaria.SetVolumeFinal(const Value: Double);
Var
  fltFator: Double;
  intContador: Integer;
begin
  fltFator := Value / (fltVolumeBaseOriginal + fltVolumeColorantesOriginal);
  fltVolume := fltVolumeOriginal * fltFator;
  fltVolumeBase := fltVolumeBaseOriginal * fltFator;
  fltVolumeColorantes := fltVolumeColorantesOriginal * fltFator;

  For intContador := 0 To Self.Count - 1 Do
  Begin
    TColorante(Self.Items[intContador]).AplicarFator(fltFator);
  End;

end;

procedure TAbstractFormulaImobiliaria.ZerarPrecos;
begin
  fltColPrecoCustoInd := 0;
  fltColPrecoCustoRealInd := 0;
  fltColPrecoVendaInd := 0;
  fltColOutrosValoresInd := 0;
  fltColIcmSaidaInd := 0;
  fltColImpostosFederaisInd := 0;
  fltColDespesasOperacionaisInd := 0;
  fltColPrecoMedioInd := 0;
  fltColPrecoUltimaCompraInd := 0;
  fltColImpostosUltimaCompraInd := 0;
  fltColPrecoCompraLiquidoInd := 0;

  fltBasePrecoCusto:= 0;
  fltBasePrecoCustoReal := 0;
  fltBasePrecoVenda := 0;
  fltBaseOutrosValores := 0;
  fltBaseIcmsSaida := 0;
  fltBaseImpostosFederais := 0;
  fltBaseDespesasOperacionais := 0;
  fltPesoEspecificoBase := 0;
  fltBasePrecoMedio := 0;
  fltBasePrecoUltimaCompra := 0;
  fltBasePrecoUltimaCompraImpostos := 0;
  fltBasePrecoCompraLiquido := 0;

  fltPrecoCustoEmbalagem := 0;
  fltPrecoCustoRealEmbalagem := 0;
  fltPrecoVendaEmbalagem := 0;
  fltOutrosValoresEmbalagem := 0;
  fltIcmSaidaEmbalagem := 0;
  fltImpostosFederaisEmbalagem := 0;
  fltDespesasOperacionaisEmbalagem := 0;
  fltPrecoMedioEmbalagem := 0;
  fltPrecoUltimaCompraEmbalagem := 0;
  fltImpostosUltimaCompraEmbalagem := 0;
  fltPrecoCompraLiqEmbalagem := 0;

end;

end.


