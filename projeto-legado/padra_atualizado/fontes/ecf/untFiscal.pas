{**************************************************}
{* UNIT COM AS FUNCOES DO ECF (IMPRESSORA FISCAL) *}
{*                                                *}
{* MODELO....: (GENERICA)                         *}
{* DATA......: 27/02/2007                         *}
{* AUTOR.....: MARLON ANDREI DE CARVALHO          *}
{*                                                *}
{***********************************************MA*}
unit untFiscal;

interface

Uses
{$IFDEF LINUX}

{$ELSE}
  Windows, Messages, Graphics, Controls, Forms, Dialogs,
{$ENDIF}
  SysUtils, Variants, Classes, StrUtils, IniFiles, untFuncoesGenerica, Uni;

Const
  BEMATECH20_40   = 'BEMATECH-MP2100THFI / MP40';
  BEMATECH25_SU   = 'BEMATECH-MP25FI OU SUPERIOR';
  BEMATECH_MP20   = 'BEMATECH-MP20';

  SWEDA_ST120     = 'SWEDA ST120';
  ELGIN_1FIT      = 'ELGIN 1FIT';
  DARUMA_FS600    = 'DARUMA FS600';
  DARUMA_FS700_SU = 'DARUMA FS700 OU SUPERIOR';
  DARUMA32        = 'DARUMA';
  CONST_EPSON     = 'EPSON';

  VAL_APR_IBPT : String = 'Trib.Ap.R$ ';
  FONTE_IBPT   : String = '/Fonte:IBPT';
  FEDERAL      : String = ' Fed';
  ESTADUAL     : String = ' Est';
  MUNICIPAL    : String = ' Mun';

  {**************************************}
  {* CONSTANTES COM MSG PADRÃO DE ARRECA*}
  {* DAÇÃO PARA CUPONS FISCAIS          *}
  {***********************************VA*}
  strMsgArreTribu48     : string='Vlr. Aproxi. Tributos R$';//24 CARACTES - EM 48 COLS
  strMsgArreTribuRedz48 : string='Vlr. Apr. Tribut. R$';    //20 CARACTES - EM 48 COLS

  strMsgArreTribu40     : string='Vlr.Apr.Trib.R$';         //15 CARACTES - EM 40 COLS
  strMsgArreTribuRedz40 : string='Vlr.Ap.Trib.R$';          //14 CARACTES - EM 40 COLS

  procedure pCarregarSignBema;
  procedure pAssinarDigitalmente(strNomeArquivo: AnsiString);

Type
  TCodigoBarras = (cbEAN13, cbEAN39);
  TFonteImpFiscal = (fiNegrito, fiItalico, fiSublinhado, fiExpandido, fiCondensado);
  TFontesImpFiscal = Set Of TFonteImpFiscal;
  EErroImpressaoECF = class(Exception);

Type
  TTotalizadores = Record
    strCodTot: String;
    fltValAcu: Double;
  End;

Type
  TDadosReducao = Record
    strNumCrz: String;
    strNumCOORZ: String;
    strNumCRO: String;
    dtaDtaMov: TDateTime;
    arrTotali: Array Of TTotalizadores;
  End;

Type
  TEstadoECF = (ecfPronta, ecfCupomAberto, ecfVinculadoAberto, ecfGerencialAberto, ecfTrabalhando);

Type
  TMetodoTotalItem = function (fltQtdIte, fltUnitar: Double): Double of object;

type
  TUntFiscal = class(TObject)

  constructor Create;

  private
    FPais: TPais;
    strPatArqDll: String;
    
    function fEmptyStr(strString : String) : Boolean;
    function fStrZero(Zeros:string;Quant:integer):String;
    function fGravaArqLog(fltQtdIte, fltUnitar, fltValDes: Double;
      strAlqIcm, strUnidad, strCodIte, strDescri,
      strLegend: String): Boolean;

  public
    strNumDoc: String;
    strCodCli: String;
    strNomCli: String;
    strCodVen: String;
    strNomVen: STring;
    strEndCli: String;
    strBaiCli: String;
    strCepCli: String;
    strCidCli: String;
    strEstCli: String;
    strCgcCpf: String;
    strIesCli: String;
    strRG_Cli: String;
    fltIcmDev: Double;
    fltImpPag: Double;
    fltPeImPg: Double;
    fltFedImp: Double;
    fltPeImFd: Double;
    fltEstImp: Double;
    fltPeImEs: Double;
    fltMunImp: Double;
    fltPeImMn: Double;

    function  pSetModEcf( strParModEcf: String ): Boolean;
    function  fGetModEcf: String;
    function  fGetCodEcf: String;
    function  fParEcf: Boolean;
    function  fParRdz: Boolean;
    function  fRetImpRdz: Boolean;

    function  fIniciaEcf( var strCodErr: String; strPatDll: String; strPorta: String='COM1' ): Boolean;
    function  fFinalizaEcf( var strCodErr: String ): Boolean;
    function  fAbreCupom( var strCodErr: String; strCpf: String ): Boolean;
    function  fAbreCupomVinculado( var strCodErr: String; strDesFormaPgto: String; fltValor: Double; strNumCupom: String): Boolean;
    function  fFechaCupomVinculado( var strCodErr: String): Boolean;
    function  fUsaCupomVinculado( var strCodErr: String; strLinha: String): Boolean;

    function  fVendeItem( var strCodErr: String; fltQtdIte, fltUnitar: Double; strAlqIcm: String; fltValDes: Double; strUnidad, strCodIte, strDescri, strLegend: String): Boolean;
    function  fTotalizaItens( var strCodErr: String; fltValDes, fltTotImp, fltTotGer: Double ): Boolean;
    function  fPagamento( var strCodErr: String; strCodMod, strDesMod: String; fltValMod: Double; blnSubtTroco: Boolean; strInfAdi: String ): Boolean;
    function  fTotalizaCupom( var strCodErr: String; strObserv: String ): Boolean;
    function  fCancelaCupom( var strCodErr: String ): Boolean;

    function  fReducaoZ( strData, strHora: String; var strCodErr: String; blnRelGer: Boolean = False ): Boolean;
    function  fLeituraX( var strCodErr: String; blnRelGer: Boolean = False ): Boolean;
    function  fAbreGaveta( var strCodErr: String ): Boolean;

    function  fRetMensErro( strCodErr: String; blnMostraMsg: Boolean=False ): String;
    function  fRetImpLigada( Var strCodErr: String ): Boolean;
    function  fRetAliquotas( Var strCodErr: String; Var strAliquotas: String ): Boolean;

    function  fLeituraMemFiscal(Var strCodErr: String;             // STRING DE RETORNO DO ERRO
                                    strParIni,                     // PARAMETRO INICIAL
                                    strParFin: String;             // PARAMETRO FINAL
                                    intTipLei: Integer ): Boolean; // TIPO DE LEITURA 0/1 DATA/REDUCAO

    function  fCadastraFormasPagamento( var strCodErr: String): boolean;

    function fNumeroSerie(Var strNumSer, strCodErr: String): Boolean;
    function fRetornaCoo(Var strNumCoo, strCodErr: String): Boolean;
    function fArredonda(fltValor: Double): Double;
    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double; fltTotIte, fltDesEsp: Double): Double;
    function fRetTotalItem(fltQtdIte, fltUnitar: Double): Double;

    function fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String;

    function fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
      strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;

    function fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
    function fRelatorioGerencial(strTexto: String): Boolean;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean;
    function fVerificaCupomAberto: Boolean;

    function fCalculaValorIcms(fltValorBruto: Double): Double; virtual;

  End;

  {**************************************}
  {* CLASSE QUE UM DIA VAI SUBSTITUIR A *}
  {* TUNTFISCAL SE DEUS QUISER          *}
  {***********************************AF*}
Type
  TFiscal = class(TComponent)
    Protected
      FPatDll: String;
      FPorta: String;
    Protected
      function fRetornaObsFechamento: String; virtual;
    Public
      strNumDoc: String;
      strCodCli: String;
      strNomCli: String;
      strCodVen: String;
      strNomVen: STring;
      strEndCli: String;
      strBaiCli: String;
      strCepCli: String;
      strCidCli: String;
      strEstCli: String;
      strCgcCpf: String;
      strIesCli: String;
      strRG_Cli: String;
      strCpfCli: String;
      strCpfClie: String;
      strTelCli: String;
      fltIcmDev: Double;
      fltImpPag: Double;
      fltPeImPg: Double;
      fltFedImp: Double;
      fltPeImFd: Double;
      fltEstImp: Double;
      fltPeImEs: Double;
      fltMunImp: Double;
      fltPeImMn: Double;

      strCpfCupomFiscal: AnsiString;
      strNomeCupomFiscal: AnsiString;
      strEndereCupomFiscal: AnsiString;

      strMenPaf01: String;
      strMenPaf02: String;

      fltTotSis: Double;

      strUltIndiceTri: String;
      fltUltDesEspIte: Double;
      fltUltAcrescIte: Double;

      blnApenasItensCheckOutF11: Boolean;      

      class function fCriarImpressora(Owner: TComponent; strModelo, strPatDll, strPorta: String): TFiscal;

      function fAbreCupom: Boolean; Virtual; Abstract;
      function fFechaCupom: Boolean; Virtual; Abstract;
      function fRegistraItem(strCodIte, strDesIte, strUnidad: String;
        fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean; Overload; Virtual; Abstract;
      function fRegistraItem(strCodIte, strDesIte, strUnidad,
        strAlqIcm: String; fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double): Boolean; Overload; Virtual; Abstract;
      function fCancelaItem(strItem: String): Boolean; Virtual; Abstract;
      function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Virtual; Abstract;
      function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Virtual; Abstract;
      function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Virtual; Abstract;
      function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Virtual; Abstract;
      function fReducaoZ(strData, strHora: String): Boolean; Virtual; Abstract;
      function fAbreGaveta: Boolean; Virtual; Abstract;
      function fStatusImpressora: String; Virtual; Abstract;
      function fAbrePortaImpressora: Boolean; Virtual; Abstract;
      function fCancelaCupom: Boolean; Virtual; Abstract;
      function fRetornaCOO: String; Virtual; Abstract;
      function fNumeroSerie: String; Virtual; Abstract;
      function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Virtual; Abstract;
      function fVerErro(blnMostraErro: Boolean = True): Boolean; Virtual; Abstract;
      function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Virtual; Abstract;
      function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; virtual;
      function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; Virtual; Abstract;
      function fRelatorioGerencial(strTexto: String): Boolean; Virtual; Abstract;
      function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Virtual; Abstract;
      function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Virtual; Abstract;
      function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; Virtual; Abstract;
      function fUsaCNFVinculado(strTexto: String): Boolean; Virtual; Abstract;
      function fVerificaCupomAberto: Boolean; Virtual;
      procedure pFechaPortaImpressora; Virtual; Abstract;
      procedure pPausaLeitura; Virtual; Abstract;
      function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double; virtual;
      function fRetTotalSistema(fltQtdIte, fltUnitar: Double): Double; virtual;     
      function fArredonda(fltValor: Double; intDecimal: Integer): Double; Virtual;

      function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; Virtual; Abstract;
      function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; Virtual; Abstract;
      function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; virtual; Abstract;

      function fModeloEcf: String; virtual; abstract;
      function fNumeroUsuario: String; virtual; abstract;
      function fNumeroCCF: String; virtual; abstract;
      function fDataEcf: TDateTime; virtual; abstract;
      function fHoraEcf: TDateTime; virtual; abstract;
      function fUltimoItemVendido: String; virtual; abstract;
      function fNumeroGNF: String; virtual; abstract;
      function fNumeroGRG: String; virtual; abstract;
      function fNumeroCDC: String; virtual; abstract;
      function fDadosUltimaReducao(Var drzDadosReducao: TDadosReducao): Boolean; virtual; abstract;
      function fVendaBruta: Double; virtual; abstract;
      function fNumeroCaixa: String; virtual; abstract;
      function fNumeroCNPJUsuario: String; virtual; abstract;
      function fNumeroIEUsuario: String; virtual; abstract;
      function fVersaoSoftwareBasico: String; virtual; abstract;
      function fDataGravacaoSoftwareBasico: TDateTime; virtual; abstract;
      function fHoraGravacaoSoftwareBasico: TDateTime; virtual; abstract;
      function fTipoECF: String; virtual; abstract;
      function fMarcaECF: String; virtual; abstract;
      function fGrandeTotal: Double; virtual; abstract;
      function fMFDAdicional: String; virtual; abstract;

      function fSangria(fltValor: Double): Boolean; virtual; abstract;
      function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; virtual; abstract;

      function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
        strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
        strNumCep, strFone01, strNumFax, strContat: String): Boolean; virtual; abstract;

      function fUltimoComandoComErro: Boolean; virtual; abstract;

      function fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String; virtual;

      function fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
        strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean; virtual;

      function fCalculaValorIcms(fltValorBruto: Double): Double; virtual;

      function fAcionaGuilhotina: Boolean; virtual;

      function fReducaoZPendente: Boolean; virtual;

      function fExcedeuLinhasDocumento: Boolean; virtual;

      property strPatDll: String Read FPatDll;
      property strPorta: String Read FPorta;
  End;

Type
  TFiscalBrd = class(TComponent)
  private

    FModEcf: String;

    fltTotEcf: Double;
    fltTotSis: Double;
    intDecUni: Integer;
    intDecQtd: Integer;

    strCacheCcf: String;
    strCacheCoo: String;
    strCacheNumUsu: String;

    function GetCpfCli: String;
    function GetMenPaf01: String;
    procedure SetMenPaf01(const Value: String);
    function GetMenPaf02: String;
    procedure SetMenPaf02(const Value: String);
    function GetModEcf: String;
    function GetNumUsu: String;
    function GetCNPJUsuario: String;
    function GetNumeroCaixa: String;
    function GetVersaoSB: String;
    function GetDataGravacaoSB: TDateTime;
    function GetHoraGravacaoSB: TDateTime;
    function GetIEUsuario: String;
    function GetTipoECF: String;
    function GetMarcaECF: String;
    function GetCpfCupomFiscal: String;
    procedure SetCpfCupomFiscal(const Value: String);
    function GetEndereCupomFiscal: String;
    function GetNomeCupomFiscal: String;
    function GetApenasItensCheckOutF11: Boolean;
    procedure SetEndereCupomFiscal(const Value: String);
    procedure SetNomeCupomFiscal(const Value: String);
    procedure SetApenasItensCheckOutF11(const Value: Boolean);
    procedure pTrocaCaracteresEspeciais(const strArquivio: String);

    procedure pPreencheVariaveisImpressoraInterna;

    function fPathEcfIni: String;
    function GetTotalSistema: String;
  Protected
    impInterna: TFiscal;
    estado: TEstadoECF;
    fltQtdItens: Double;
    intUltimoItem: Integer;
    objIni: TIniFile;

    function fEstadoToStr(estadoCvt: TEstadoECF): String;
    function fStrToEstado(strEstado: String): TEstadoECF;

    procedure pSetaEstado(estadoNovo: TEstadoECF);
    procedure pPronta;
    procedure pCupomAberto;
    procedure pVinculadoAberto;
    procedure pGerencialAberto;
    procedure pTrabalhando;

  Public

    strFormaPgtoVinculado: String;
    strNumDoc: String;
    strCodCli: String;
    strNomCli: String;
    strCodVen: String;
    strNomVen: STring;
    strEndCli: String;
    strBaiCli: String;
    strCepCli: String;
    strCidCli: String;
    strEstCli: String;
    strCgcCpf: String;
    strIesCli: String;
    strRG_Cli: String;
    strCpfClie: String;
    strTelCli: String;
    fltIcmDev: Double;
    fltImpPag: Double;
    fltPeImPg: Double;
    fltFedImp: Double;
    fltPeImFd: Double;
    fltEstImp: Double;
    fltPeImEs: Double;
    fltMunImp: Double;
    fltPeImMn: Double;

    strEndEntCli: String;
    strBaiEntCli: String;
    strCepEntCli: String;
    strCidEntCli: String;
    strEstEntCli: String;

	  function fAbreCupom: Boolean;
	  function fFechaCupom: Boolean;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String; fltAlqIcm,
      fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
    function fCancelaItem(strItem: String; fltQtdIte, fltUnitar: Double): Boolean;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; 
//    function fRegistraAcrDes(fltDesEsp: Double): Boolean; overload;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean;
    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean;
    function fReducaoZ(strData, strHora: String): Boolean;
    function fAbreGaveta: Boolean;
    function fStatusImpressora: String;
    function fAbrePortaImpressora: Boolean;
    function fCancelaCupom: Boolean;
    function fRetornaCOO: String;
    function fNumeroSerie: String;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String;
    function fVerErro(blnMostraErro: Boolean = True): Boolean;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String;

    function fRetTotalEcf(fltQtdIte, fltUnitar: Double; fltTotIte, fltDesEsp: Double): Double;
    function fRetTotalItem(fltQtdIte, fltUnitar: Double): Double;
    function fArredonda(fltValor: Double; intDecimal: Integer): Double;

    procedure pFechaPortaImpressora;
    procedure pPausaLeitura;

    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String;
      blnMostrarErro: Boolean = True; strQtdPar: String = ''): Boolean;
    function fFechaCNFVinculado(blnMostrarErro: Boolean = True): Boolean;
    function fUsaCNFVinculado(strTexto: String; blnMostrarErro: Boolean = True): Boolean;

    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean;
    function fRelatorioGerencial(strTexto: String; blnMostrarErro: Boolean = True): Boolean;
    function fFechaRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean;

    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean;
    function fDadosUltimaReducao(Var drzDadosReducao: TDadosReducao): Boolean;

    function fDataEcf: TDateTime;
    function fHoraEcf: TDateTime;

    function fGrandeTotal: Double;
    function fMFDAdicional: String;

    function fVendaBruta: Double;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean;

    function fNumeroCCF: String;

    function fSangria(fltValor: Double): Boolean;
    function fSuprimento(fltValor: Double; strModalidade: String = 'Dinheiro'): Boolean;

    {*****************************************}
    {* MÉTODOS AUXILIARES.                   *}
    {**************************************MV*}
    function fVinculadoAberto: Boolean;
    function fHouveIncrementoDeCRO: Boolean;

    procedure pGravaDadosUltReducao(drzDadosReducao: TDadosReducao);

    function fUltimoComandoComErro: Boolean;

    function fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String;

    function fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
      strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;

    function fCalculaValorIcms(fltValorBruto: Double): Double;
    function fCalculaTotalSistema(fltQtdIte, fltUnitar: Double): Double;

    function fAcionaGuilhotina: Boolean;

    function fArquivoEcfIniValido(var strArquivo: String): Boolean;
    function fValidaSerieECFEmpresa(var strNumSer: String): Boolean;

    function fReducaoZPendente: Boolean;

    function fExcedeuLinhasDocumento: Boolean;

    function fVerificaCupomAberto: Boolean;

    Constructor Create(Owner: TComponent; strModelo: String); Reintroduce;
    Destructor Destroy; override;

    property strCnpjEmp: String Read GetCpfCli;
    property strMenPaf01: String Read GetMenPaf01 Write SetMenPaf01;
    property strMenPaf02: String Read GetMenPaf02 Write SetMenPaf02;

    property strModEcf: String Read GetModEcf;
    property strNumUsu: String Read GetNumUsu;
    property strNumeroCaixa: String Read GetNumeroCaixa;
    property strCNPJUsuario: String Read GetCNPJUsuario;
    property strIEUsuario: String Read GetIEUsuario;
    property strVersaoSB: String Read GetVersaoSB;
    property dtaDataGravacaoSB: TDateTime Read GetDataGravacaoSB;
    property dtaHoraGravacaoSB: TDateTime Read GetHoraGravacaoSB;
    property strTipoECF: String Read GetTipoECF;
    property strMarca: String Read GetMarcaECF;

    property strCpfCupomFiscal: String Read GetCpfCupomFiscal Write SetCpfCupomFiscal;
    property strNomeCupomFiscal: String Read GetNomeCupomFiscal Write SetNomeCupomFiscal;
    property strEndereCupomFiscal: String Read GetEndereCupomFiscal Write SetEndereCupomFiscal;

    property blnApenasItensCheckOutF11: Boolean Read GetApenasItensCheckOutF11 Write SetApenasItensCheckOutF11;

    property EstadoECF: TEstadoECF Read estado;

    property strTotalSistema: String read GetTotalsistema;
  End;

procedure pCalculaAcrDesItem(objEcf: TFiscal; fltQtdEcf, fltUniEcf, fltQtdSis,
  fltUniSis, fltDesEspSis: Double; Var fltDescon, fltAcresc: Double); overload;

procedure pCalculaAcrDesItem(metodoTotalEcf, metodoTotalSis: TMetodoTotalItem; fltQtdEcf, fltUniEcf, fltQtdSis,
  fltUniSis, fltDesEspSis: Double; Var fltDescon, fltAcresc: Double); overload;

procedure pMarcaCupomImpresso(strSeqGer, strNumDoc, strEspDoc,  strCodEmp,
  strCodCli, strSerie, strNumSer, strNumCoo, strNumCcf, strNomArq: String);

function fTiraCaracteresEspeciaisImp(strTexto: String): String;
function fCriaEcfModeloVelho: TUntFiscal;

Var
  Fiscal: TUntFiscal;
  VS_objFiscal: TFiscalBrd;
  blnVerificaTef: Boolean;

  HandleSignBema: Cardinal;
  {*****************************************}
  {* FUNÇÃO PARA ASSINATURA DIGITAL        *}
  {**************************************MV*}
  generateEAD: function( cNomeArquivo: AnsiString; cChavePublica: AnsiString; cChavePrivada: AnsiString; cEAD:AnsiString; iSign: Integer): integer; stdcall;

implementation

uses untBematech, untFuncoes, untfuncoesSimples, untSweda9000, untSweda7000,
  untDaruma, untBematechNDll, untSchalterSCFI1E, untEpson, untElgin1FIT,
  untPafRegistroR04, untPafRegistroR06, untPafGerais, untPafRegistroR05,
  untPafRegistroR07, untPafRegistroR01, untPafRegistroR02, untPafRegistroR03,
  untSwedaST120, untConstantes, untDarumaFramework, untDaruma32,
  untObservacao, Data.DB, untTypesSistema;

Var
  strModEcf  : String = '';
  strCodEcf  : String = '';
  Bematech   : TUntBematech;
  Sweda      : TUntSweda9000;
  Sweda7000  : TUntSweda7000;
  Daruma     : TUntDaruma;
  SchalterSCFI1E: TSchalterSCFI1E;
  Epson         : TEpson;
  Elgin1FIT: TElgin1FIT;
  DarumaFS700_SU: TDaruma;

procedure pCalculaAcrDesItem(objEcf: TFiscal; fltQtdEcf, fltUniEcf, fltQtdSis,
  fltUniSis, fltDesEspSis: Double; Var fltDescon, fltAcresc: Double);
begin
  pCalculaAcrDesItem(objEcf.fRetTotalImpressora, objEcf.fRetTotalSistema, fltQtdEcf, fltUniEcf, fltQtdSis,
    fltUniSis, fltDesEspSis, fltDescon, fltAcresc);
end;

procedure pCalculaAcrDesItem(metodoTotalEcf, metodoTotalSis: TMetodoTotalItem; fltQtdEcf, fltUniEcf, fltQtdSis,
  fltUniSis, fltDesEspSis: Double; Var fltDescon, fltAcresc: Double);
  Var
    fltTotImp: Double;
    fltTotSis: Double;
begin
  fltDescon := 0;
  fltAcresc := 0;

  If fCfgSis('MDADCF') = '1' Then
  Begin
    fltTotImp := metodoTotalEcf(fltQtdEcf, fltUniEcf);

    fltTotSis := metodoTotalSis(fltQtdSis, fltUniSis) - fltDesEspSis;

    If fltTotImp > fltTotSis Then
    Begin
      fltDescon := fltTotImp - fltTotSis;
    End
    Else
    Begin
      fltAcresc := fltTotSis - fltTotImp;
    End;
  End;
end;

constructor TUntFiscal.Create;
begin
  FPais := fSetaPais;
end;

{*****************************************}
{* EXECUTA UM IIF, IGUAL O CLIPPER :^)   *}
{**************************************MV*}
{  function TUntFiscal.fIIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2;
end;
}
{**************************************}
{*  VERIFICA SE UMA STRING ESTA VAZIA *}
{***********************************MV*}
function TUntFiscal.fEmptyStr(strString : String) : Boolean;
Begin

  Result := False;

  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');

  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;

End;

{***************************************}
{* Insere Zeros à frente de uma string *}
{************************************DV*}
function TUntFiscal.fStrZero(Zeros:string;Quant:integer):String;
Var
  I,Tamanho:integer;
  Aux: string;
Begin

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';

  For I := 1 To Tamanho Do
    If Aux[i] <> ',' Then
      Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';

  for I:=1 to Quant-Tamanho do
    Zeros:=Zeros + '0';

  Aux := Zeros + Aux;

  fStrZero := Aux;

End;

{*****************************************}
{* SETA MODELO DE IMPRESSORA UTILIZADA   *}
{**************************************MA*}
procedure pMarcaCupomImpresso(strSeqGer, strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie, strNumSer, strNumCoo, strNumCcf,
  strNomArq: String);
  Var
    strSQL   : String;
    strTblGer: String;
    strTblDet: String;
    qryGenGer: TUniQuery;
Begin
  Try
    qryGenGer := fCriaQuery(Nil);

    Screen.Cursor := crHourGlass;

    If (strNomArq = 'MOVGER') Then
    Begin
      strTblGer := 'MOVGER';
      strTblDet := 'MOVDET';
    End
    Else
    Begin
      strTblGer := 'NOTGER';
      strTblDet := 'NOTDET';
    End;

    {*****************************************}
    {* MARCA MOVGER COMO JA FATURADO         *}
    {**************************************MA*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + ' ' + strTblGer + ' ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   GER_IMPRES = TRUE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   AUTOINCREM = :AUTOINCREM ';

    With qryGenGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOINCREM').AsString := strSeqGer;
      ExecSql;
      Close;

    End;

    {*****************************************}
    {* MARCA MOVDET COMO JA FATURADO         *}
    {**************************************MA*}
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + ' ' + strTblDet + ' ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   DET_IMPRES = TRUE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

    With qryGenGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      ExecSql;
      Close;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FGO_NUMCCF = :NUMCCF ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMFAT = :NUMFAT AND ';
    strSQL := strSQL + '  FGO_TIPFAT = :TIPFAT AND ';
    strSQL := strSQL + '  FGO_EMPFAT = :CODEMP ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMCCF').AsString := strNumCcf;

      ParamByName('NUMFAT').AsString := strNumDoc;
      ParamByName('TIPFAT').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      ExecSQL;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADFIS ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FIS_NUMSER = IF(:NUMSER = "", NULL, :NUMSER), ';
    strSQL := strSQL + '  FIS_NUMCOO = IF(:NUMCOO = "", NULL, :NUMCOO) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FIS_FORCLI = :CODCLI AND ';

    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((FIS_SERIE_ IS NULL) OR (FIS_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '  FIS_TIP_FC = "C" ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMSER').AsString := strNumSer;
      ParamByName('NUMCOO').AsString := strNumCoo;

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If (Not fEmptyStr(strSerie)) Then
        ParamByName('SERIE_').AsString := strSerie;

      ExecSQL;
      Close;
    End;

    Screen.Cursor := crDefault;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[pMarcaCupomImpresso]');
  End;

  FreeAndNil(qryGenGer);
end;

function TUntFiscal.pSetModEcf( strParModEcf: String ): Boolean;
  Var   arrListaEcf : array[1..20] of String;
        intContador : Integer;
Begin

  Result := True;

  {*****************************************}
  {* SE CRIAR UMA IMPRESSORA NOVA,ADICIONAR*}
  {* NA LISTAGEM ABAIXO.                   *}
  {**************************************MA*}
  arrListaEcf[ 1 ] := 'SCHALTER SCFI 1E';
  arrListaEcf[ 2 ] := 'BEMATECH-MP2100THFI';
  arrListaEcf[ 3 ] := 'SWEDA-9000';
  arrListaEcf[ 4 ] := 'SWEDA-7000';
  arrListaEcf[ 5 ] := 'DARUMA';
  arrListaEcf[ 6 ] := 'EPSON';
  arrListaEcf[ 7 ] := 'ELGIN 1FIT';
  arrListaEcf[ 8 ] := 'DARUMA FS700 OU SUPERIOR';
  arrListaEcf[ 9 ] := 'SWEDA ST120';

  {************************************************************************************}
  {* ACRESCENTADO UM NOVO MODELO DE IMPRESSORA PARA A BEMATECH.                       *}
  {* ESSE NOVO MODELO SE DIFERENCIA APENAS PELO CADASTRAMENTO DAS FORMAS DE PAGAMENTO *}
  {*********************************************************************************LA*}
  If SameText(BEMATECH20_40,strParModEcf) Or SameText(BEMATECH25_SU,strParModEcf) Or
     SameText(BEMATECH_MP20,strParModEcf)                                         Then
    strParModEcf := arrListaEcf[ 2 ];

  strModEcf := strParModEcf;
  strCodEcf := '';

  For intContador := 1 to 20 Do
  Begin

    If Not ( Pos( strModEcf, arrListaEcf[ intContador ] ) = 0 ) Then
    Begin
      strCodEcf := fStrZero( IntToStr( intContador ), 3 );
      Exit;
    End;

  End;

  If fEmptyStr( strCodEcf ) Then
    Result := False;

End;

{*****************************************}
{* RETORNA MODELO DE IMPRESSORA UTILIZADA*}
{**************************************MA*}
function TUntFiscal.fGetModEcf: String;
Begin
  Result := strModEcf;
End;

{*****************************************}
{* RETORNA CODIGO DA IMPRESSORA UTILIZADA*}
{**************************************MA*}
function TUntFiscal.fGetCodEcf: String;
Begin
  Result := strCodEcf;
End;

{*****************************************}
{* INICIALIZA ECF                        *}
{**************************************MA*}
function TUntFiscal.fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
  strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;
begin
  Result := True;

  {*******************************************}
  {* DARUMA FS700 OU SUPERIOR                *}
  {****************************************JC*}
  If UpperCase( strCodEcf ) = '008' Then
    Result := DarumaFS700_SU.fImprimirCodigoBarras(cbTipo, strCodigo, strLargura, strAltura, strOrientacao, strImpTexto, strTextoLivre);
end;

function TUntFiscal.fIniciaEcf( var strCodErr: String; strPatDll: String; strPorta: String='COM1' ): Boolean;

Begin

  Result := True;

  If Not ( RightStr( Trim( strPatDll ), 1 ) = '\' ) Then
    strPatDll := Trim( strPatDll ) + '\';

  Try

    {***********************************}
    {* SCHALTER ECF SCFI 1E            *}
    {********************************MA*}
    If UpperCase( strCodEcf ) = '001' Then
    Begin

      Result := False;
      strPatArqDll := strPatDll;
      If Not FileExists( strPatDll + 'DLL32PHI.DLL' ) Then
      Begin
        strCodErr := IntToStr( -999 );
        Exit;
      End;

      SchalterSCFI1E := TSchalterSCFI1E.Create(Nil, strPatDll, strPorta);
      SchalterSCFI1E.blnModoNovo := False;
      SchalterSCFI1E.strCodVen   := strCodVen;
      SchalterSCFI1E.strNomVen   := strNomVen;
      SchalterSCFI1E.strNumDoc   := strNumDoc;
      SchalterSCFI1E.strCodCli   := strCodCli;
      SchalterSCFI1E.strNomCli   := strNomCli;
      SchalterSCFI1E.strEndCli   := strEndCli;
      SchalterSCFI1E.strBaiCli   := strBaiCli;
      SchalterSCFI1E.strCepCli   := strCepCli;
      SchalterSCFI1E.strCidCli   := strCidCli;
      SchalterSCFI1E.strEstCli   := strEstCli;
      SchalterSCFI1E.strCgcCpf   := strCgcCpf;
      SchalterSCFI1E.strIesCli   := strIesCli;
      SchalterSCFI1E.strRG_Cli   := strRG_Cli;
      SchalterSCFI1E.fltICMDev   := fltICMDev;
      SchalterSCFI1E.fltImpPag   := fltImpPag;
      SchalterSCFI1E.fltPeImPg   := fltPeImPg;
      SchalterSCFI1E.fltFedImp   := fltFedImp;
      SchalterSCFI1E.fltPeImFd   := fltPeImFd;
      SchalterSCFI1E.fltEstImp   := fltEstImp;
      SchalterSCFI1E.fltPeImEs   := fltPeImEs;
      SchalterSCFI1E.fltMunImp   := fltMunImp;
      SchalterSCFI1E.fltPeImMn   := fltPeImMn;

      SchalterSCFI1E.fAbrePortaImpressora;
      strCodErr := IntToStr(SchalterSCFI1E.intRetorno);

      Result := ( strCodErr = '0' );

    End

    {***********************************}
    {* BEMATECH                        *}
    {********************************MA*}
    Else If UpperCase( strCodEcf ) = '002' Then
    Begin

      Bematech := TUntBematech.Create;
      Bematech.pSetPatDll( strPatDll + 'BemaFI32.dll' );
      strCodErr := IntToStr( Bematech.fInicia );

      //fSetDll( 'BemaFI32.dll' );
      //bematechInicia;
      Result := True;

    End

    {***********************************}
    {* SWEDA 9000                      *}
    {********************************MA*}
    Else If UpperCase( strCodEcf ) = '003' Then
    Begin

      Sweda := TUntSweda9000.Create;
      Sweda.pSetPatDll( strPatDll + 'SWECF.DLL' ); // Nao usado mas é aqui q deveria ser
      Sweda.fInicia( StrToInt( RightStr( Trim( strPorta ), 1 ) ) );

      Result := True;

    End

    {***********************************}
    {* SWEDA 7000                      *}
    {********************************MA*}
    Else If UpperCase( strCodEcf ) = '004' Then
    Begin

      Sweda7000 := TUntSweda7000.Create;
      Sweda7000.pSetPatDll( strPatDll + 'SWECF.DLL' ); // Nao usado mas é aqui q deveria ser
      Sweda7000.fInicia( StrToInt( RightStr( Trim( strPorta ), 1 ) ) );

      Result := True;

    End

    {*******************************************}
    {* DARUMA                                  *}
    {****************************************MV*}
    Else If (UpperCase(strCodEcf) = '005') Then
    Begin

      strPatArqDll := strPatDll;
      If (Not FileExists(strPatDll + 'Daruma32.dll')) Then
      Begin
        strCodErr := '-999';
        Result := False;
        Exit;
      End;

      Daruma := TUntDaruma.Create;
      Daruma.pSetPatDll(strPatDll + 'Daruma32.dll');
      strCodErr := IntToStr(Daruma.fInicia);

      Result := True;

    End

    {***********************************}
    {* EPSON                           *}
    {********************************AF*}
    Else If UpperCase( strCodEcf ) = '006' Then
    Begin

      Epson := TEpson.Create(Nil, strPorta);
      Epson.blnModoNovo := False;
      Epson.strCodVen   := strCodVen;
      Epson.strNomVen   := strNomVen;
      Epson.strNumDoc   := strNumDoc;
      Epson.strCodCli   := strCodCli;
      Epson.strNomCli   := strNomCli;
      Epson.strEndCli   := strEndCli;
      Epson.strBaiCli   := strBaiCli;
      Epson.strCepCli   := strCepCli;
      Epson.strCidCli   := strCidCli;
      Epson.strEstCli   := strEstCli;
      Epson.strCgcCpf   := strCgcCpf;
      Epson.strIesCli   := strIesCli;
      Epson.strRG_Cli   := strRG_Cli;
      Epson.fltICMDev   := fltICMDev;
      Epson.fltImpPag   := fltImpPag;
      Epson.fltPeImPg   := fltPeImPg;
      Epson.fltFedImp   := fltFedImp;
      Epson.fltPeImFd   := fltPeImFd;
      Epson.fltEstImp   := fltEstImp;
      Epson.fltPeImEs   := fltPeImEs;
      Epson.fltMunImp   := fltMunImp;
      Epson.fltPeImMn   := fltPeImMn;

      Epson.fAbrePortaImpressora;
      strCodErr := IntToStr(Epson.intRetorno);

      Result := ( strCodErr = '0' );
    End

    Else If (UpperCase( strCodEcf ) = '007') Then
    Begin
      Elgin1FIT := TElgin1FIT.Create(Nil, False);
      Elgin1FIT.strCodVen   := strCodVen;
      Elgin1FIT.strNomVen   := strNomVen;
      Elgin1FIT.strNumDoc   := strNumDoc;
      Elgin1FIT.strCodCli   := strCodCli;
      Elgin1FIT.strNomCli   := strNomCli;
      Elgin1FIT.strEndCli   := strEndCli;
      Elgin1FIT.strBaiCli   := strBaiCli;
      Elgin1FIT.strCepCli   := strCepCli;
      Elgin1FIT.strCidCli   := strCidCli;
      Elgin1FIT.strEstCli   := strEstCli;
      Elgin1FIT.strCgcCpf   := strCgcCpf;
      Elgin1FIT.strIesCli   := strIesCli;
      Elgin1FIT.strRG_Cli   := strRG_Cli;
      Elgin1FIT.fltICMDev   := fltICMDev;
      Elgin1FIT.fltImpPag   := fltImpPag;
      Elgin1FIT.fltPeImPg   := fltPeImPg;
      Elgin1FIT.fltFedImp   := fltFedImp;
      Elgin1FIT.fltPeImFd   := fltPeImFd;
      Elgin1FIT.fltEstImp   := fltEstImp;
      Elgin1FIT.fltPeImEs   := fltPeImEs;
      Elgin1FIT.fltMunImp   := fltMunImp;
      Elgin1FIT.fltPeImMn   := fltPeImMn;

      Result := Elgin1FIT.blnSucesso;

    End

    Else If (UpperCase( strCodEcf ) = '008') Then
    Begin
      DarumaFS700_SU := TDaruma.Create(Nil, False);
      DarumaFS700_SU.strCodVen   := strCodVen;
      DarumaFS700_SU.strNomVen   := strNomVen;
      DarumaFS700_SU.strNumDoc   := strNumDoc;
      DarumaFS700_SU.strCodCli   := strCodCli;
      DarumaFS700_SU.strNomCli   := strNomCli;
      DarumaFS700_SU.strEndCli   := strEndCli;
      DarumaFS700_SU.strBaiCli   := strBaiCli;
      DarumaFS700_SU.strCepCli   := strCepCli;
      DarumaFS700_SU.strCidCli   := strCidCli;
      DarumaFS700_SU.strEstCli   := strEstCli;
      DarumaFS700_SU.strCgcCpf   := strCgcCpf;
      DarumaFS700_SU.strIesCli   := strIesCli;
      DarumaFS700_SU.strRG_Cli   := strRG_Cli;
      DarumaFS700_SU.fltICMDev   := fltICMDev;
      DarumaFS700_SU.fltImpPag   := fltImpPag;
      DarumaFS700_SU.fltPeImPg   := fltPeImPg;
      DarumaFS700_SU.fltFedImp   := fltFedImp;
      DarumaFS700_SU.fltPeImFd   := fltPeImFd;
      DarumaFS700_SU.fltEstImp   := fltEstImp;
      DarumaFS700_SU.fltPeImEs   := fltPeImEs;
      DarumaFS700_SU.fltMunImp   := fltMunImp;
      DarumaFS700_SU.fltPeImMn   := fltPeImMn;

      Result := DarumaFS700_SU.blnSucesso;

    End
    {***********************************}
    {* SWEDA ST120                     *}
    {********************************MA*}
    Else If UpperCase( strCodEcf ) = '009' Then
    Begin

      If Not FileExists( strPatDll + 'SWECF.DLL' ) Then
      Begin
        strCodErr := IntToStr( -999 );
        Result := False;
        Exit;
      End;
     (*
      SwedaST120 := TSwedaST120.Create(nil);
      SwedaST120.pSetPatDll( strPatDll + 'SWECF.DLL' ); // Nao usado mas é aqui q deveria ser
      SwedaST120.fInicia( StrToInt( RightStr( Trim( strPorta ), 1 ) ) );
      *)
      Result := True;

    End;


  Except
    Result := False;
  End;

End;

{*****************************************}
{* FINALIZA ECF                          *}
{**************************************MA*}
function TUntFiscal.fFinalizaEcf( var strCodErr: String ): Boolean;
//    Var pchBuffer: PChar;
//        intACK: Integer;
//        intST1: Integer;
//        intST2: Integer;
Begin

  Result := True;
//    pchBuffer := '';

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin

    //      

  End

  {***********************************}
  {* SWEDA 9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    Result := ( Sweda.fFinaliza = 0 );

  End

  {***********************************}
  {* SWEDA 7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    Result := ( Sweda7000.fFinaliza = 0 );

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    Result := (Daruma.fFinaliza = 0);
  End

  {*******************************************}
  {* EPSON                                   *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '006') Then
  Begin
    Epson.pFechaPortaImpressora;
    Result := True;
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    FreeAndNil(Elgin1FIT);
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    FreeAndNil(DarumaFS700_SU);
  End;

End;

function TUntFiscal.fFormatarTextoImp(strTexto: String;
  FonteEstilos: TFontesImpFiscal): String;
begin
  Result := strTexto;

  {*******************************************}
  {* DARUMA FS700 OU SUPERIOR                *}
  {****************************************JC*}
  If UpperCase( strCodEcf ) = '008' Then
    Result := DarumaFS700_SU.fFormatarTextoImp(strTexto, FonteEstilos);
end;

function TUntFiscal.fCadastraFormasPagamento( var strCodErr: String): boolean;
  Var
      intACK: Integer;
      intST1: Integer;
      intST2: Integer;
Begin
  Result := True;

  {***********************************}
  {* BEMATECH                        *}
  {********************************LA*}
  If UpperCase( strCodEcf ) = '002' Then
  Begin
    strCodErr := IntToStr( Bematech.fCadastraFormasPagamento );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fCadastraFormasPagamento);

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {*******************************************}
  {* DARUMA FS700 OU SUPERIOR                *}
  {****************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fCadastraFormasPagamento;
  End;

End;

function TUntFiscal.fCalculaValorIcms(fltValorBruto: Double): Double;
begin
  {***********************************}
  {* BEMATECH                        *}
  {********************************LA*}
  If UpperCase( strCodEcf ) = '002' Then
  Begin
    Result := fTruncaFloat(fltValorBruto, 2);
  End
  Else
  Begin
    Result := fFormataFloat(fltValorBruto, 2);
  End;

end;

{*****************************************}
{* ABRE CUPOM FISCAL                     *}
{**************************************MA*}
function TUntFiscal.fAbreCupom( var strCodErr: String; strCpf: String): Boolean;
  Var //pchBuffer: PChar;
      intACK: Integer;
      intST1: Integer;
      intST2: Integer;
Begin

  Result := True;
  strCpf := fTiraCaracteresEspeciaisImp(strCpf);

  If fEmptyStr(strCpf) Then
    strCpf := fRetornaCpfCnpfVazio('2');

//    pchBuffer := '';

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fAbreCupom;
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result    := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH                        *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fAbreCupom( strCpf ) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA 9000                     *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fAbreCupom( strCpf );
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* SWEDA                           *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fAbreCupom( strCpf );
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fAbreCupom(strCpf));

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fAbreCupom;
    strCodErr := IntToStr(Epson.intRetorno);
    Result    := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Elgin1FIT.strCpfClie := strCpf;
    Elgin1FIT.strCpfCupomFiscal := AnsiString(strCpf);
    Result := Elgin1FIT.fAbreCupom;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    DarumaFS700_SU.strCpfClie := strCpf;
    DarumaFS700_SU.strCpfCupomFiscal := AnsiString(strCpf);
    Result := DarumaFS700_SU.fAbreCupom;  
  End;

End;

{*****************************************}
{* EFETUA A VENDA DO ITEM                *}
{**************************************MA*}
function TUntFiscal.fVendeItem( var strCodErr: String; fltQtdIte,
  fltUnitar: Double; strAlqIcm: String; fltValDes: Double; strUnidad, strCodIte, strDescri,
  strLegend: String): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  strDescri := Trim( strDescri );
  Result    := True;

  strCodIte := fTiraCaracteresEspeciaisImp(strCodIte);
  strDescri := fTiraCaracteresEspeciaisImp(strDescri);
  strUnidad := fTiraCaracteresEspeciaisImp(strUnidad);

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fRegistraItemVelho(strCodIte, strDescri, strUnidad, fStrToFloat(strAlqIcm),
      fltQtdIte, fltUnitar);
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH MP-2100                *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fVendeItem( strCodIte, strDescri, strAlqIcm, 'F', fltQtdIte, 2, fltUnitar, '$', strUnidad, fltValDes ) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );
//    Result := True;

  End


  {***********************************}
  {* SWEDA-9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fVendeItem( strCodIte, strDescri, strAlqIcm, 'F', fltQtdIte, 2, fltUnitar, '$', fltValDes );
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin

      If ( fRetMensErro( strCodErr ) = '') Or
         ( Pos(fRetMensErro( strCodErr ), 'Tempo de espera') > 0 ) Then
      Begin
        Result := True;
      End;

    End;

  End

  {***********************************}
  {* SWEDA-7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fVendeItem( strCodIte, strDescri, strAlqIcm, 'F', fltQtdIte, 2, fltUnitar, '$', fltValDes );
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin

      If ( fRetMensErro( strCodErr ) = '') Or
         ( Pos(fRetMensErro( strCodErr ), 'Tempo de espera') > 0 ) Then
      Begin
        Result := True;
      End;

    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fVendeItem(strCodIte, strDescri, strAlqIcm, 'F', fltQtdIte, 2, fltUnitar, '$', fltValDes));

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fRegistraItem(strCodIte, strDescri, strUnidad, strAlqIcm, fltQtdIte, fltUnitar, '', fltValDes);
    strCodErr := IntToStr(Epson.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fRegistraItem(strCodIte, strDescri, strUnidad, strAlqIcm, fltQtdIte, fltUnitar, '', fltValDes);
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fRegistraItem(strCodIte, strDescri, strUnidad, strAlqIcm, fltQtdIte, fltUnitar, '', fltValDes);
  End;

  If Not( Result ) Then
  Begin
    fGravaArqLog(fltQtdIte, fltUnitar, fltValDes, strAlqIcm, strUnidad, strCodIte, strDescri, strLegend);
  End;

End;

function TUntFiscal.fVerificaCupomAberto: Boolean;
begin
  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************RN*}
  Result := false;
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    Result := SchalterSCFI1E.fVerificaCupomAberto;
  End

  {***********************************}
  {* SWEDA 9000                     *}
  {********************************RN*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin
    Result := Sweda9000.fVerificaCupomAberto;
  End

  {***********************************}
  {* SWEDA                           *}
  {********************************RN*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin
    Result := Sweda7000.fVerificaCupomAberto; 
  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************RN*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    Result := Daruma.fVerificaCupomAberto;
  End

  {***********************************}
  {* EPSON                           *}
  {********************************RN*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Result := Epson.fVerificaCupomAberto;
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************RN*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fVerificaCupomAberto;  
  End;

end;

{*****************************************}
{* TOTALIZA ITENS                        *}
{**************************************MA*}
function TUntFiscal.fTotalizaItens( var strCodErr: String; fltValDes, fltTotImp, fltTotGer: Double ): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
    strAcrDes: String;
Begin
  Result    := True;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fRegistraAcrDes('D', '$', FloatToStr(fltValDes), 0, 0);
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH - MP2100               *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strAcrDes := 'D';
    fltValDes := 0;

    If fFormataFloat( fltTotImp, 2 ) > fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'D';
      fltValDes := fltTotImp - fltTotGer;
    End
    Else If fFormataFloat( fltTotImp, 2 ) < fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'A';
      fltValDes := fltTotGer - fltTotImp;
    End;

    strCodErr := IntToStr( Bematech.fIniciaFechamentoCupom( strAcrDes, '$', fltValDes ) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA-9000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    Sleep(1000);

    strAcrDes := 'D';

    If fFormataFloat( fltTotImp, 2 ) > fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'D';
      fltValDes := fltTotImp - fltTotGer;
    End
    Else If fFormataFloat( fltTotImp, 2 ) < fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'A';
      fltValDes := fltTotGer - fltTotImp;
    End;
    
    If fltValDes > 0.0 Then
    Begin

      If strAcrDes = 'D' Then
        strCodErr :=  Sweda.fDescEspecial( fltValDes )
      Else
        strCodErr :=  Sweda.fAcrescimo( fltValDes );

      Sleep(1000);

      Result := ( LeftStr( strCodErr, 2 ) = '.+' );

      If  fEmptyStr( fRetMensErro( strCodErr ) ) Then
        Result := True;
    End
    Else
    Begin
      strCodErr := '.+';
      Result := (strCodErr = '.+')  Or ( fEmptyStr(strCodErr) );

      If Not( Result ) Then
      Begin
        fGravaArqLog(0, 0, fltValDes, 'NAO GRAVA', 'NAO GRAVA', 'COD. ERRO: [' + strCodErr + ']', 'NAO GRAVA', 'NAO GRAVA');
        ShowMessage( strCodErr );
        Result := fRetMensErro( strCodErr ) = '';
      End;
    End;

  End

  {***********************************}
  {* SWEDA-7000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strAcrDes := 'D';
    fltValDes := 0;

    If fFormataFloat( fltTotImp, 2 ) > fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'D';
      fltValDes := fltTotImp - fltTotGer;
    End
    Else If fFormataFloat( fltTotImp, 2 ) < fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'A';
      fltValDes := fltTotGer - fltTotImp;
    End;

    Sleep(1000);

    If fltValDes > 0.0 Then
    Begin

      If strAcrDes = 'D' Then
        strCodErr := Sweda7000.fDescEspecial(fltValDes)
      Else
        strCodErr := Sweda7000.fAcrescimo(fltValDes);

      Sleep(1000);

      Result := ( LeftStr( strCodErr, 2 ) = '.+' );

      If  fEmptyStr( fRetMensErro( strCodErr ) ) Then
        Result := True;
    End
    Else
    Begin
      strCodErr := '.+';
      Result := (strCodErr = '.+')  Or ( fEmptyStr(strCodErr) );

      If Not( Result ) Then
      Begin
        fGravaArqLog(0, 0, fltValDes, 'NAO GRAVA', 'NAO GRAVA', 'COD. ERRO: [' + strCodErr + ']', 'NAO GRAVA', 'NAO GRAVA');
        ShowMessage( strCodErr );
        Result := fRetMensErro( strCodErr ) = '';
      End;
    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin

    strAcrDes := 'D';
    fltValDes := 0;

    If fFormataFloat( fltTotImp, 2 ) > fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'D';
      fltValDes := fltTotImp - fltTotGer;
    End
    Else If  fFormataFloat( fltTotImp, 2 ) < fFormataFloat( fltTotGer, 2 ) Then
    Begin
      strAcrDes := 'A';
      fltValDes := fltTotGer - fltTotImp;
    End;

    fltValDes := fFormataFloat(fltValDes, 2);
    strCodErr := IntToStr(Daruma.fIniciaFechamentoCupom(strAcrDes, '$', fltValDes));

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fRegistraAcrDes('D', '$', FloatToStr(fltValDes), 0, 0);
    strCodErr := IntToStr(Epson.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fRegistraAcrDes(strAcrDes, '$', FloatToStr(fltValDes), fltTotGer, fltTotImp);
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fRegistraAcrDes(strAcrDes, '$', FloatToStr(fltValDes), fltTotGer, fltTotImp);
  End;

End;

{*****************************************}
{* TOTALIZA CUPOM                        *}
{**************************************MA*}
function TUntFiscal.fTotalizaCupom( var strCodErr: String; strObserv: String ): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  Result    := True;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fFechaCupom; 
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
  End

  {***********************************}
  {* BEMATECH - MP2100               *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fTerminaFechamentoCupom( strObserv ) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA-9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fTerminaFechamentoCupom( strObserv );
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* SWEDA-7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fTerminaFechamentoCupom( strObserv );
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fTerminaFechamentoCupom(strObserv));

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.strCodVen := strCodVen;
    Epson.strNomVen := strNomVen;
    Epson.strNumDoc := strNumDoc;
    Epson.strCodCli := strCodCli;
    Epson.strNomCli := strNomCli;
    Epson.strEndCli := strEndCli;
    Epson.strBaiCli := strBaiCli;
    Epson.strCepCli := strCepCli;
    Epson.strCidCli := strCidCli;
    Epson.strEstCli := strEstCli;
    Epson.strCgcCpf := strCgcCpf;
    Epson.strIesCli := strIesCli;
    Epson.strRG_Cli := strRG_Cli;
    Epson.fltICMDev := fltICMDev;
    Epson.fltImpPag := fltImpPag;
    Epson.fltPeImPg := fltPeImPg;
    Epson.fltFedImp := fltFedImp;
    Epson.fltPeImFd := fltPeImFd;
    Epson.fltEstImp := fltEstImp;
    Epson.fltPeImEs := fltPeImEs;
    Epson.fltMunImp := fltMunImp;
    Epson.fltPeImMn := fltPeImMn;

    Epson.fFechaCupom;
    strCodErr := IntToStr(Epson.intRetorno);
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Elgin1FIT.strMensFechamento := AnsiString(strObserv);
    Result := Elgin1FIT.fFechaCupom;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    DarumaFS700_SU.strMsgFechamento := strObserv;
    Result := DarumaFS700_SU.fFechaCupom;
  End;

End;

{*****************************************}
{* INFORMA AS FORMAS DE PAGAMENTO        *}
{* (MODALIDADES)                         *}
{**************************************MA*}
function TUntFiscal.fPagamento( var strCodErr: String; strCodMod, strDesMod: String; fltValMod: Double; blnSubtTroco: Boolean; strInfAdi: String ): Boolean;
  Var //pchBuffer: PChar;

      intACK : Integer;
      intST1 : Integer;
      intST2 : Integer;

{        pchCodMod: PChar;
      pchValMod: PChar;
      chaSubTro: Char;
}
Begin

//    pchBuffer := '';
  Result    := True;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fRegistraModalidades(strCodMod, strDesMod, fltValMod, strInfAdi); 
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result    := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH - MP2100               *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fEfetuaFormaPagamentoDescricao( strCodMod, fltValMod, strInfAdi ) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA - 9000                    *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fEfetuaFormaPagamentoIndice( strCodMod, fltValMod, strInfAdi );
    Result    :=  ( LeftStr( strCodErr, 2 ) = '.+' ) Or fEmptyStr(strCodErr);

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End; 

  End

  {***********************************}
  {* SWEDA - 7000                    *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fEfetuaFormaPagamentoIndice( strCodMod, fltValMod, strInfAdi );
    Result    :=  ( LeftStr( strCodErr, 2 ) = '.+' ) Or fEmptyStr(strCodErr);

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fEfetuaFormaPagamentoDescricao(strDesMod, fltValMod, strInfAdi));

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fRegistraModalidades(strCodMod, strDesMod, fltValMod, strInfAdi);
    strCodErr := IntToStr(Epson.intRetorno);
    Result    := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fRegistraModalidades(strCodMod, strDesMod, fltValMod, strInfAdi);
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fRegistraModalidades(strCodMod, strDesMod, fltValMod, strInfAdi);
  End;
  
End;

{*****************************************}
{* REDUCAO Z                             *}
{**************************************MA*}
function TUntFiscal.fReducaoZ( strData, strHora: String; var strCodErr: String; blnRelGer: Boolean = False ): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  Result := False;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fReducaoZ(strData, strHora);
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fReducaoZ(strData, strHora) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( strCodErr = '1' );
//    Result := True;

  End

  {***********************************}
  {* SWEDA - 9000                    *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fReducaoZ;
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* SWEDA - 7000                    *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fReducaoZ;
    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fReducaoZ(strData, strHora));

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (strCodErr = '1');
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fReducaoZ( strData, strHora );
    strCodErr := IntToStr(Epson.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fReducaoZ( strData, strHora );
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fReducaoZ( strData, strHora );
  End;

End;

function TUntFiscal.fRelatorioGerencial(strTexto: String): Boolean;
begin
  Result := False;

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************AF*}
  If UpperCase( strCodEcf ) = '002' Then
    Result := Bematech.fRelatorioGerencial(strTexto) = 1;

  {*******************************************}
  {* DARUMA FS700 OU SUPERIOR                *}
  {****************************************JC*}
  If UpperCase( strCodEcf ) = '008' Then
    Result := DarumaFS700_SU.fRelatorioGerencial(strTexto);
end;

{*****************************************}
{* LEITURA X                             *}
{**************************************MA*}
function TUntFiscal.fLeituraX( var strCodErr: String; blnRelGer: Boolean = False ): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin
  Result := False;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fLeituraX;
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fLeituraX );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA 9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fLeituraX;

    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* SWEDA 7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fLeituraX;

    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fLeituraX);

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fLeituraX;
    strCodErr := IntToStr(Epson.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fLeituraX;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fLeituraX;
  End;

End;

function TUntFiscal.fParEcf: Boolean;
  Var
    strInform: String;
Begin
  Result := False;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
    Result := True

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
    Result := True

  {***********************************}
  {* SWEDA 9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
    Result := True

  {***********************************}
  {* SWEDA 7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin
    Sweda7000.fParEcf;
    Result := True;
  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    Daruma.fLerAliquotasComIndice(strInform);
    fMensagem('Alíquotas',strInform,['&OK']);
    Result := True;
  End

  {*******************************************}
  {* EPSON                                   *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '006') Then
  Begin
    fMensagem('Alíquotas',Epson.fRetParEcf,['&OK']);
    Result := True;
  End;

End;

function TUntFiscal.fParRdz: Boolean;
Begin
  Result := False;

  {*******************************************}
  {* EPSON                                   *}
  {****************************************MV*}
  If (UpperCase(strCodEcf) = '006') Then
  Begin
    pCriarFormularios(TfrmObservacao, frmObservacao);
    frmObservacao.memObs.Lines.Add(Epson.fRetParRdz);
    frmObservacao.showModal;
    pFreeandnil(frmObservacao);
    Result := True;
  End;

End;

function TUntFiscal.fRetImpRdz: Boolean;
Begin
  Result := False;

  {*******************************************}
  {* EPSON                                   *}
  {****************************************MV*}
  If (UpperCase(strCodEcf) = '006') Then
  Begin
    Epson.fRetImpRdz();
    Result := True;
  End;

End;

{*****************************************}
{* ABERTURA DA GAVETA                    *}
{**************************************MA*}
function TUntFiscal.fAbreGaveta( var strCodErr: String ): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fAbreGaveta; 
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End
  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fAbreGaveta );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fAbreGaveta);

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fAbreGaveta;
    strCodErr := IntToStr(Epson.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fAbreGaveta;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fAbreGaveta;
  End

  Else
  Begin

    {strCodErr := IntToStr(Sweda.fAbreGaveta);

    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;} //ALEXANDRE

    strCodErr := '0';

    Result := True;

  End;

End;

function TUntFiscal.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  Result := False;

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************AF*}
  If UpperCase( strCodEcf ) = '002' Then
    Result := True;

  {*******************************************}
  {* DARUMA FS700 OU SUPERIOR                *}
  {****************************************JC*}
  If UpperCase( strCodEcf ) = '008' Then
    Result := DarumaFS700_SU.fAbreRelatorioGerencial(blnMostrarErro);
end;

{*****************************************}
{* RETORNA MENSAGEM DE ERRO DA IMPRESSORA*}
{**************************************MA*}
function TUntFiscal.fRetMensErro( strCodErr: String; blnMostraMsg: Boolean=False ): String;
  Var intCodErr: Integer;
      intACK, intST1, intST2: Integer;
//        intRetorno: Integer;
      intPosStr: Integer;
Begin

  Result    := '';
  intCodErr := 0;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin

    If (intCodErr = -999) Then
      Result := 'Não foi possivel encontrar a biblioteca DLL32PHI.DLL na pasta: ' + strPatArqDll
    Else If strCodErr <> '0' Then
    Begin
      SchalterSCFI1E.fCancelaVenda;
      SchalterSCFI1E.intRetorno := StrToInt(strCodErr);
      Result := SchalterSCFI1E.fRetMensErro;
    End;

  End

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    intCodErr := StrToInt( strCodErr );

    //Sem Erro
    If ( intCodErr = 1 ) Then
      Result := ''
    Else
    If ( intCodErr = -999 ) Then
      Result := 'Não foi possivel encontrar a DLL da Impressora Fiscal !'
    Else If ( intCodErr > 0 ) Then
    Begin

      {***********************************}
      {* CHECA SENSORES DA IMPRESSORA    *}
      {********************************MA*}
      intACK := StrToInt( Copy( strCodErr, 1, 3 ) );
      intST1 := StrToInt( Copy( strCodErr, 4, 3 ) );
      intST2 := StrToInt( Copy( strCodErr, 7, 3 ) );


      If ( intACK = 21 ) Then
        Result := 'Recebimento incorreto da impressora (NAK).';

      If ( intACK = 6 ) Then
      Begin

        Result := '';

        If intST1 >= 128 Then                  // bit 7
        Begin
          Result := Result + ' Fim de Papel,';
          intST1 := intST1 - 128;
        End;

        If intST1 >= 64 Then                  // bit 6
        Begin
          Result := Result + ' Pouco Papel,';
          intST1 := intST1 - 64;
        End;

        If intST1 >= 32 Then                  // bit 5
        Begin
          Result := Result + ' Erro no Relógio,';
          intST1 := intST1 - 32;
        End;

        If intST1 >= 16 Then                  // bit 4
        Begin
          Result := Result + ' Impressora em Erro,';
          intST1 := intST1 - 16;
        End;

        If intST1 >= 8 Then                  // bit 3
        Begin
          Result := Result + ' Comando não iniciado com ESC,';
          intST1 := intST1 - 8;
        End;

        If intST1 >= 4 Then                  // bit 2
        Begin
          Result := Result + ' Comando Inexistente,';
          intST1 := intST1 - 4;
        End;

        If intST1 >= 2 Then                  // bit 1
        Begin
          Result := Result + ' Cupom Aberto,';
          intST1 := intST1 - 2;
        End;

        If intST1 >= 1 Then                  // bit 0
        Begin
          Result := Result + ' Número de Parâmetro(s) Inválido(s),';
//            intST1 := intST1 - 1;
        End;

        //Codificando o ST2
        If intST2 >= 128 Then                  // bit 7
        Begin
          Result := Result + ' Tipo de Parâmetro de Comando Inválido,';
          intST2 := intST2 - 128;
        End;

        If intST2 >= 64 Then                  // bit 6
        Begin
          Result := Result + ' Memória Fiscal Lotada,';
          intST2 := intST2 - 64;
        End;

        If intST2 >= 32 Then                  // bit 5
        Begin
          Result := Result + ' Erro na Memória RAM,';
          intST2 := intST2 - 32;
        End;

        If intST2 >= 16 Then                  // bit 4
        Begin
          Result := Result + ' Alíquota Não Programada,';
          intST2 := intST2 - 16;
        End;

        If intST2 >= 8 Then                  // bit 3
        Begin
          Result := Result + ' Capacidade de Alíquotas Lotada,';
          intST2 := intST2 - 8;
        End;

        If intST2 >= 4 Then                  // bit 2
        Begin
          Result := Result + ' Cancelamento Não Permitido,';
          intST2 := intST2 - 4;
        End;

        If intST2 >= 2 Then                  // bit 1
        Begin
          Result := Result + ' CNPJ/IE do Proprietário Não Programado,';
          intST2 := intST2 - 2;
        End;

        If intST2 >= 1 Then                  // bit 0
        Begin
           Result := Result + ' Comando (MAC) Não Executado,';
//             intST2 := intST2 - 1;
        End;

        Result := Trim( Result );

        If Result <> '' Then
          Result := LeftStr( Result, Length( Result ) -1 ) + '.';

      End;

    End
    Else
    If ( intCodErr < 0 ) Then
    Begin

      intCodErr := ( intCodErr * -1 );

      case intCodErr of
        00 : Result := 'Erro de Comunicação !';
        01 : Result := 'Erro de Execução na Função. Verifique!';
        02 : Result := 'Parâmetro Inválido !';
        03 : Result := 'Alíquota não programada !';
        04 : Result := 'Arquivo BemaFI32.INI não encontrado. Verifique!';
        05 : Result := 'Erro ao Abrir a Porta de Comunicação';
        06 : Result := 'Impressora Desligada ou Desconectada';
        07 : Result := 'Banco Não Cadastrado no Arquivo BemaFI32.ini';
        08 : Result := 'Erro ao Criar ou Gravar no Arquivo Retorno.txt ou Status.txt';
        18 : Result := 'Não foi possível abrir arquivo INTPOS.001 !';
        19 : Result := 'Parâmetro diferentes !';
        20 : Result := 'Transação cancelada pelo Operador !';
        21 : Result := 'A Transação não foi aprovada !';
        22 : Result := 'Não foi possível terminar a Impressão !';
        23 : Result := 'Não foi possível terminar a Operação !';
        24 : Result := 'Forma de pagamento não programada.';
        25 : Result := 'Totalizador não fiscal não programado.';
        26 : Result := 'Transação já Efetuada !';
        28 : Result := 'Não há Informações para serem Impressas !';
      End;

    End;

  End

  {***********************************}
  {* SWEDA 9000 / 7000               *}
  {********************************MA*}
  Else If Pos(UpperCase( strCodEcf ), '003_004') > 0 Then
  Begin

    If ( Trim( strCodErr ) = '-999' ) Then
    Begin

      Result := 'Não foi possivel comunicar-se com a Impressora. Verifique as Configurações, a DLL e tente novamente !';

    End
    Else
    Begin

      intPosStr := Pos( 'ERRO-', strCodErr );

      If ( intPosStr > 0 ) Then
      Begin

        If ( Copy( strCodErr, ( intPosStr + 5 ), 5 ) = 'CANC:' ) Then
          Result := 'Não há nenhum cupom para ser cancelado !'
        Else
          Result := AnsiReplaceStr( Copy( strCodErr, ( intPosStr + 5 ), 100 ), '}', '' )

      End
      Else
      Begin

        If Copy( strCodErr, 2, 1 ) = '-' Then
        Begin

          If Copy( strCodErr, 6, 1 ) = '1' Then
            Result := 'Impressora desligada ou desconectada !'
          Else If Copy( strCodErr, 6, 1 ) = '2' Then
            Result := 'Ocorreu um erro ao comunicar-se com a impressora. Verifique se ela está conectada corretamente e ligada !'
          Else If Copy( strCodErr, 6, 1 ) = '5' Then
            Result := 'Impressora sem papel/Papel se esgotando !'
          Else If Copy( strCodErr, 6, 1 ) = '6' Then
            Result := 'Tempo de espera de recepção da ECF esgotado !'
          Else
            Result := 'Impressora sem papel/Papel se esgotando !';

        End;

      End;

    End;

  End

  Else If UpperCase( strCodEcf ) = '005' Then
  Begin

    intCodErr := StrToInt( strCodErr );

    //Sem Erro
    If ( intCodErr = 1 ) Then
      Result := ''
    Else If ( intCodErr = -999 ) Then
      Result := 'Não foi possivel encontrar a biblioteca Daruma32.dll na pasta: ' + strPatArqDll
    Else If ( intCodErr > 0 ) Then
    Begin

      {***********************************}
      {* CHECA SENSORES DA IMPRESSORA    *}
      {********************************MA*}
      intACK := StrToInt( Copy( strCodErr, 1, 3 ) );
      intST1 := StrToInt( Copy( strCodErr, 4, 3 ) );
      intST2 := StrToInt( Copy( strCodErr, 7, 3 ) );

      If ( intACK = 21 ) Then
        Result := 'Recebimento incorreto da impressora (NAK).';

      If ( intACK = 6 ) Then
      Begin

        Result := '';

        If intSt1 >= 128 Then // bit 7
        Begin
          intSt1 := intSt1 - 128;
          Result := Result + 'O papel acabou ';
        End;

        If intSt1 >= 64 Then // bit 6
        Begin
          intSt1 := intSt1 - 64;
          Result := Result + 'O papel esta acabando ';
        End;

        If intSt1 >= 32 Then // bit 5
        Begin
          intSt1 := intSt1 - 32;
          Result := Result + 'Erro no relógio da impressora ';
        End;

        If intSt1 >= 16 Then // bit 4
        Begin
          intSt1 := intSt1 - 16;
          Result := Result + 'Impressora em erro ';
        End;

        If intSt1 >= 8 Then // bit 3
        Begin
          intSt1 := intSt1 - 8;
          Result := Result + 'Primeiro dado do método não foi ESC ';
        End;

        If intSt1 >= 4 Then // bit 2
        Begin
          intSt1 := intSt1 - 4;
          Result := Result + 'Método inexistente ';
        End;

        If intSt1 >= 2 Then // bit 1
        Begin
          intSt1 := intSt1 - 2;
          Result := Result + 'Cupom fiscal aberto ';
        End;

        If intSt1 >= 1 Then // bit 0
        Begin
//            intSt1 := intSt1 - 1;
          Result := Result + 'Número de parâmetro(s) inválido(s) ';
        End;


        If intSt2 >= 128 Then // bit 7
        Begin
          intSt2 := intSt2 - 128;
          Result := Result + 'Tipo de parâmetro do método inválido ';
        End;

        If intSt2 >= 64 Then // bit 6
        Begin
        intSt2 := intSt2 - 64;
        Result := Result + 'Memória fiscal cheia ';
        End;

        If intSt2 >= 32 Then // bit 5
        Begin
          intSt2 := intSt2 - 32;
          Result := Result + 'Erro na memória RAM ';
        End;

        If intSt2 >= 16 Then // bit 4
        Begin
          intSt2 := intSt2 - 16;
          Result := Result + 'Alíquota não definida ';
        End;

        If intSt2 >= 8 Then // bit 3
        Begin
          intSt2 := intSt2 - 8;
          Result := Result + 'Capacidade de alíquotas esgotada ';
        End;

        If intSt2 >= 4 Then // bit 2
        Begin
          intSt2 := intSt2 - 4;
          Result := Result + 'Este cancelamento não é permitido ';
        End;

        If intSt2 >= 2 Then // bit 1
        Begin
          intSt2 := intSt2 - 2;
          Result := Result + 'CNPJ/IE do Proprietário não definidos ';
        End;

        If intSt2 >= 1 Then // bit 0
        Begin
//            intSt2 := intSt2 - 1;
          Result := Result + 'Método não executado ';
        End;

      End;

    End;


  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    If strCodErr <> '0' Then
    Begin
      Epson.intRetorno := StrToInt(strCodErr);
      Result := Epson.fRetMensErro;
      Epson.fCancelaCupom;
    End;

  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    If (Not Elgin1FIT.blnSucesso) Then
    Begin
      Result := Elgin1FIT.fRetMensErro;
      Elgin1FIT.fCancelaCupom;
    End;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    If (Not DarumaFS700_SU.blnSucesso) Then
    Begin
      Result := DarumaFS700_SU.strMsgErro;
      DarumaFS700_SU.fCancelaCupom;
    End;
  End;

  If blnMostraMsg And ( Not ( Result = '' ) ) Then
    fMensagem('ATENÇÃO!', Result, ['&Ok']);

End;

{*****************************************}
{* RETORNA TRUE SE IMPRESSORA LIGADA     *}
{**************************************MA*}
function  TUntFiscal.fRetImpLigada( Var strCodErr: String ): Boolean;
Begin

  Result := True;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fStatusImpressora;
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fImpressoraLigada );
    Result := ( strCodErr = '1' );

  End

  {***********************************}
  {* SWEDA 9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fImpressoraLigada;
    Result := ( Copy( strCodErr, 4, 1 ) <> '1' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* SWEDA 7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fImpressoraLigada;
    Result := ( Copy( strCodErr, 4, 1 ) <> '1' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* DARUMA                          *}
  {********************************MA*}
  Else If UpperCase(strCodEcf) = '005' Then
  Begin
    strCodErr := IntToStr(Daruma.fImpressoraLigada);
    Result := (strCodErr = '1');
  End

  {*****************************************}
  {* EPSON                                 *}
  {**************************************AF*}
  Else If UpperCase(strCodEcf) = '006' Then
  Begin
    strCodErr := Epson.fStatusImpressora;
    Result := (strCodErr = '1');
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    strCodErr := Elgin1FIT.fStatusImpressora;
    Result := Elgin1FIT.blnSucesso;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    strCodErr := DarumaFS700_SU.fStatusImpressora;
    Result := DarumaFS700_SU.blnSucesso;
  End;

End;

{*****************************************}
{* CANCELA CUPOM FISCAL                  *}
{**************************************MA*}
function TUntFiscal.fCancelaCupom( var strCodErr: String ): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  Result := True;
  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fCancelaCupom; 
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {***********************************}
  {* BEMATECH                        *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fCancelaCupom() );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA-9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

    strCodErr := Sweda.fCancelaCupom();
    Result := fEmptyStr( strCodErr );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* SWEDA-7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

    strCodErr := Sweda7000.fCancelaCupom();
    Result := fEmptyStr( strCodErr );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End

  {***********************************}
  {* DARUMA                          *}
  {********************************MV*}
  Else If UpperCase( strCodEcf ) = '005' Then
  Begin
    strCodErr := IntToStr(Daruma.fCancelaCupom);

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fCancelaCupom;
    strCodErr := IntToStr(Epson.intRetorno);
    Result := ( strCodErr = '0' );
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fCancelaCupom;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fCancelaCupom;
  End;

End;

{*****************************************}
{* EFETUA A VENDA DO ITEM                *}
{**************************************MA*}
function  TUntFiscal.fRetAliquotas( Var strCodErr: String; Var strAliquotas: String ): Boolean;
  Var
      intACK: Integer;
      intST1: Integer;
      intST2: Integer;
Begin

  Result := True;

  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    Result := True;
  End

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fRetornaAliquotas( strAliquotas ) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fRetornaAliquotas(strAliquotas));

    If (strCodErr = '1') Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);      
  End

  {***********************************}
  {* EPSON                           *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Result := True;
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := True;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := True;
  End;

End;

function TUntFiscal.fGravaArqLog(fltQtdIte,
                                 fltUnitar,
                                 fltValDes: Double;
                                 strAlqIcm,
                                 strUnidad,
                                 strCodIte,
                                 strDescri,
                                 strLegend: String ): Boolean;
  Var
    txfArqLog : TextFile;
    strQtdIte : String;
    strUnitar : String;
    strValDes : String;
    strNomArq : String;

begin

  Try
    Result := True;

    strNomArq := fCfgSis('DIRINI') + '\' + FormatDateTime('dd-mm', Vs_Date) + '.TXT';

    strCodIte := 'COD. ITE.: [' + strCodIte + ']';
    strDescri := 'DESCRICAO: [' + strDescri + ']';
    strUnidad := 'UNIDADE .: [' + strUnidad + ']';
    strLegend := 'LEGENDA .: [' + strLegend + ']';
    strAlqIcm := 'ALQ. ICM.: [' + strAlqIcm + ']';

    Try
      strQtdIte := 'QTD. ITE.: [' + FloatToStr(fltQtdIte) + ']';
    Except
      strQtdIte := 'QTD. ITE.: [QTD. INVALIDO]';
    End;


    Try
      strUnitar := 'VR. UNIT.: [' + FloatToStr(fltUnitar) + ']';
    Except
      strQtdIte := 'QTD. ITE.: [VR. UNITARIO]';
    End;


    Try
      strValDes := 'VR. DESC.: [' + FloatToStr(fltValDes) + ']';
    Except
      strQtdIte := 'QTD. ITE.: [VR. DESCONTO]';
    End;


    AssignFile(txfArqLog, strNomArq);
    Rewrite(txfArqLog);
    Writeln(txfArqLog, strCodIte);
    Writeln(txfArqLog, strDescri);
    Writeln(txfArqLog, strUnidad);
    Writeln(txfArqLog, strLegend);
    Writeln(txfArqLog, strAlqIcm);
    Writeln(txfArqLog, strQtdIte);
    Writeln(txfArqLog, strUnitar);
    Writeln(txfArqLog, strValDes);
    CloseFile(txfArqLog);

  Except
    fMensagem('ATENÇÃO!', 'Não consegui criar arquivo de log. Verifique o path da impressora fiscal!', ['&Ok']);
    Result := False;
  End;


end;


//*************************************************//
// EFETUA A LEITURA DA MEMORIA FISCAL.             //
// A LEITURA PODE SER POR UM PERIODO DE DATAS OU   //
// DE REDUCAO.                                     //
//**********************************************ED*//
function TUntFiscal.fLeituraMemFiscal(Var strCodErr: String;         // STRING DE RETORNO DO ERRO
                                      strParIni,                     // PARAMETRO INICIAL
                                      strParFin: String;             // PARAMETRO FINAL
                                      intTipLei: Integer ): Boolean; // TIPO DE LEITURA 0/1 DATA/REDUCAO

    Var //pchBuffer: PChar;
        intACK: Integer;
        intST1: Integer;
        intST2: Integer;
Begin

  Result := True;

//  pchBuffer := '';

  //*************************************************//
  // SCHALTER ECF SCFI 1E                            //
  //**********************************************ED*//
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    SchalterSCFI1E.fLeituraMemFiscal(strParIni, strParFin, intTipLei);
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := (strCodErr = '0');
  End
  {***********************************}
  {* BEMATECH                        *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin
    //*************************************************//
    // INDICA QUE A REDUCAO DEVE SER POR DATA          //
    //**********************************************ED*//
    If intTipLei = 0 Then
      strCodErr := IntToStr( Bematech.fLeituraMF_Data(strParIni, strParFin) )
    Else
      strCodErr := IntToStr( Bematech.fLeituraMF_Reducao(strParIni, strParFin) );
    //*************************************************//
    // TRATA O LOG DE RETORNO                          //
    //**********************************************ED*//
    If ( strCodErr = '1' ) Then
    Begin
      intACK := 0;
      intST1 := 0;
      intST2 := 0;
      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );
    End;
    Result := ( StrToInt( strCodErr ) = 1 );
  End

  Else If UpperCase( strCodEcf ) = '003' Then
  Begin
    If intTipLei = 0 Then
      strCodErr := Sweda.fLeMemFiscal(StrToDate(strParIni), StrToDate(strParFin))
    Else
      strCodErr := Sweda.fLeMemFiscalReducao(strParIni, strParFin);

    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;

  End
  {***********************************}
  {* SWEDA-7000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin
    If intTipLei = 0 Then
      strCodErr := Sweda7000.fLeMemFiscal(StrToDate(strParIni), StrToDate(strParFin))
    Else
      strCodErr := Sweda7000.fLeMemFiscalReducao(strParIni, strParFin);

    Result := ( LeftStr( strCodErr, 2 ) = '.+' );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr ) = '';
    End;
  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    //*************************************************//
    // INDICA QUE A REDUCAO DEVE SER POR DATA          //
    //**********************************************ED*//
    If intTipLei = 0 Then
      strCodErr := IntToStr(Daruma.fLeituraMF_Data(strParIni, strParFin))
    Else
      strCodErr := IntToStr(Daruma.fLeituraMF_Reducao(strParIni, strParFin));

    //*************************************************//
    // TRATA O LOG DE RETORNO                          //
    //**********************************************ED*//
    If (strCodErr = '1') Then
    Begin
      intACK := 0;
      intST1 := 0;
      intST2 := 0;
      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);
    End;
    Result := (StrToInt(strCodErr) = 1);
  End

  {************************************}
  {* EPSON                            *}
  {*********************************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    Epson.fLeituraMemFiscal(strParIni, strParFin, intTipLei);
    strCodErr := IntToStr(Epson.intRetorno);
    Result := (strCodErr = '0');
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    Result := Elgin1FIT.fLeituraMemFiscal(strParIni, strParFin, intTipLei);
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    Result := DarumaFS700_SU.fLeituraMemFiscal(strParIni, strParFin, intTipLei);
  End;

End;


function TUntFiscal.fNumeroSerie(var strNumSer, strCodErr: String): Boolean;
  Var
//    pchBuffer: PChar;
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
begin
  Result := True;
//  pchBuffer := '';

  strNumSer := '';
  //*************************************************//
  // SCHALTER ECF SCFI 1E                            //
  //**********************************************ED*//
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    strNumSer := SchalterSCFI1E.fNumeroSerie;
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := (strCodErr = '0');
  End

  {***********************************}
  {* BEMATECH                        *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr(Bematech.fNumeroSerie(strNumSer));

    //*************************************************//
    // TRATA O LOG DE RETORNO                          //
    //**********************************************ED*//
    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA-9000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

  End

  {***********************************}
  {* SWEDA-7000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fNumeroSerie(strNumSer));

    //*************************************************//
    // TRATA O LOG DE RETORNO                          //
    //**********************************************ED*//
    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {************************}
  {* EPSON                *}
  {*********************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    strNumSer := Epson.fNumeroSerie;
    strCodErr := IntToStr(Epson.intRetorno);
    Result := (strCodErr = '0');
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    strNumSer := Elgin1FIT.fNumeroSerie;
    Result := Elgin1FIT.blnSucesso;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    strNumSer := DarumaFS700_SU.fNumeroSerie;
    Result    := DarumaFS700_SU.blnSucesso;
  End;

end;

function TUntFiscal.fRetornaCoo(var strNumCoo, strCodErr: String): Boolean;
  Var
//    pchBuffer: PChar;
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
begin
  Result := True;
  strNumCoo := '';

  //*************************************************//
  // SCHALTER ECF SCFI 1E                            //
  //**********************************************ED*//
  If UpperCase( strCodEcf ) = '001' Then
  Begin
    strNumCoo := SchalterSCFI1E.fRetornaCOO;
    strCodErr := IntToStr(SchalterSCFI1E.intRetorno);
    Result := (strCodErr = '0');
  End

  {***********************************}
  {* BEMATECH                        *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '002' Then
  Begin
    strCodErr := IntToStr(Bematech.fRetornaCoo(strNumCoo));

    //*************************************************//
    // TRATA O LOG DE RETORNO                          //
    //**********************************************ED*//
    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

  End

  {***********************************}
  {* SWEDA-9000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '003' Then
  Begin

  End

  {***********************************}
  {* SWEDA-7000                      *}
  {********************************ED*}
  Else If UpperCase( strCodEcf ) = '004' Then
  Begin

  End

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
  Begin
    strCodErr := IntToStr(Daruma.fRetornaCoo(strNumCoo));

    //*************************************************//
    // TRATA O LOG DE RETORNO                          //
    //**********************************************ED*//
    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero(IntToStr(Daruma.fRetorno(intACK, intST1, intST2)), 9);

    End;

    Result := (StrToInt(strCodErr) = 1);
  End

  {*********************}
  {* EPSON             *}
  {******************AF*}
  Else If UpperCase( strCodEcf ) = '006' Then
  Begin
    strNumCoo := Epson.fRetornaCOO;
    strCodErr := IntToStr(Epson.intRetorno);
    Result := (strCodErr = '0');
  End

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
  Begin
    strNumCoo := Elgin1FIT.fRetornaCoo;
    Result := Elgin1FIT.blnSucesso;
  End

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
  Begin
    strNumCoo := DarumaFS700_SU.fRetornaCoo;
    Result    := DarumaFS700_SU.blnSucesso;
  End;

end;

{****************************************************}
{* CRIA A CLASSE DA IMPRESSORA QUE ESTÁ CONFIGURADA *}
{*************************************************AF*}
function TFiscal.fCalculaValorIcms(fltValorBruto: Double): Double;
begin
  Result := fFormataFloat(fltValorBruto, 2);
end;

class function TFiscal.fCriarImpressora(Owner: TComponent; strModelo, strPatDll, strPorta: String): TFiscal;
begin

  //If strModelo = 'SWEDA 9000III' Then
  //  Result := TSweda9000III.Create(Owner)

  //Else If strModelo = 'SWEDA 7000' Then
  //  Result := TSweda7000.Create(Owner)

  //Else If strModelo = 'SWEDA ST120' Then
  //  Result :=  TSwedaST120.Create(Owner)

  If (strModelo = BEMATECH20_40) Or (strModelo = BEMATECH25_SU) Or (strModelo = BEMATECH_MP20) Then
    Result := TBematech.Create(Owner)

  Else If (strModelo = SWEDA_ST120) Then
    Result := TSwedaST120.Create(Owner)

  Else If (strmodelo = ELGIN_1FIT) Then
    Result := TElgin1FIT.Create(Owner, True)

  Else If (strmodelo = DARUMA_FS700_SU) Then
    Result := TDaruma.Create(Owner)

  Else If (strmodelo = DARUMA32) Then
    Result := TDaruma32.Create(Owner)

  Else If (strModelo = CONST_EPSON) Then
    Result := TEpson.Create(Owner, '')

  Else
    Result := Nil;

  If (Assigned(Result)) Then
  Begin
    Result.strCpfCupomFiscal    := '';
    Result.strNomeCupomFiscal   := '';
    Result.strEndereCupomFiscal := '';
  End;

end;

function TFiscal.fExcedeuLinhasDocumento: Boolean;
begin
  Result := False;
end;

function TFiscal.fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String;
begin
  Result := strTexto;
end;

function TFiscal.fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
  strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;
begin
  Result := True;
end;

function TUntFiscal.fArredonda(fltValor: Double): Double;
begin

  Result := 0;
  {***********************************}
  {* SCHALTER ECF SCFI 1E            *}
  {********************************AF*}
  If UpperCase( strCodEcf ) = '001' Then
    Result := SchalterSCFI1E.fArredonda(fltValor)

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************AF*}
  Else If UpperCase( strCodEcf ) = '002' Then
    Result := Bematech.fArredonda(fltValor)

  {***********************************}
  {* SWEDA 9000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '003' Then
    Result := Sweda.fArredonda(fltValor)

  {***********************************}
  {* SWEDA 7000                      *}
  {********************************MA*}
  Else If UpperCase( strCodEcf ) = '004' Then
    Result := Sweda7000.fArredonda(fltValor)

  {*******************************************}
  {* DARUMA                                  *}
  {****************************************MV*}
  Else If (UpperCase(strCodEcf) = '005') Then
    Result := Daruma.fArredonda(fltValor)

  {******************************************}
  {* EPSON                                  *}
  {***************************************AF*}
  Else If (UpperCase(strCodEcf) = '006') Then
    Result := fltValor

  {*****************************************}
  {* ELGIN 1FIT                            *}
  {**************************************MV*}
  Else If (UpperCase(strCodEcf) = '007') Then
    Result := fltValor

  {*****************************************}
  {* DARUMA FS700 OU SUPERIOR              *}
  {**************************************JC*}
  Else If (UpperCase(strCodEcf) = '008') Then
    Result := fltValor;

end;

function TFiscal.fReducaoZPendente: Boolean;
begin
  Result := False;
end;

function TFiscal.fRetornaObsFechamento: String;
  Var
    strMens,
    strImpPag: String;
    blnImpPag: Boolean;        
Begin
  strMens := '';

  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));

  If blnImpPag Then
  Begin
    If Not fUsaImpostoFonteIBPT Then
    Begin
      If fltImpPag < 1000 Then
        strMens := strMens + fPadR('Vlr Aprox do Tributo "R$' + FormatFloat('#,##0.00', fltImpPag) +
                                   '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48)
      Else
        strMens := strMens + fPadR('Vlr Apr Tributos "R$' + FormatFloat('#,##0.00', fltImpPag) +
                                   '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48);
    End
    Else
    Begin
      strImpPag := '';
      strImpPag := strImpPag + VAL_APR_IBPT;

      If (fltFedImp <> 0.00) Then
        strImpPag := strImpPag + FormatFloat('#,##0.00', fltFedImp) + FEDERAL;

      If (fltEstImp <> 0.00) Then
        strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltEstImp) + ESTADUAL;

      If (fltMunImp <> 0.00) Then
        strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltMunImp) + MUNICIPAL;

      strImpPag := strImpPag + FONTE_IBPT;
      strMens := strMens + Copy(fPadR(strImpPag, 48), 1, 48);
    End;
  End;

  strCgcCpf := fFormataCpfCgc(strCgcCpf, fSetaPais);
  If Pos('/', strCgcCpf) > 0 Then
  Begin
    strCgcCpf := 'CNPJ: ' + strCgcCpf;
    strIesCli := 'IES.: ' + strIesCli;
  End
  Else
  Begin
    strCgcCpf := 'CPF: ' + strCgcCpf;
    strIesCli := 'RG.: ' + strRG_Cli;
  End;

  strMens := strMens + fPadR(IIF(fCfgSis('IMPCAC', varBoolean),'Cupom Fiscal: ' + strNumDoc + '-IF      ','') + 'Fone: ' + fFormataFone(strTelCli), 48);
  strMens := strMens + fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48);
  strMens := strMens + fPadR(strEndCli + ' - ' + strBaiCli, 48);

  If Not blnImpPag Then
    strMens := strMens + fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48);
    
  strMens := strMens + fPadR(strCGCCPF + ' - ' + strIESCli, 48);
  strMens := strMens + fPadR('Vendedor: ' + strNomVen, 48);

  If fCfgSis('SIMNAC', varBoolean) Then
    strMens := strMens + fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48);

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
    strMens := strMens + fPadR( 'MINAS LEGAL', 40)
  Else    
  If fCfgSis('CUPMAN', varBoolean) Then
    strMens := strMens + fPadR( 'VALIDO PARA O CUPOM MANIA.ICMS DEVIDO: ' + FormatFloat('#0.00', fltIcmDev), 48);


  Result := strMens;

end;

function TUntFiscal.fRetTotalImpressora(fltQtdIte, fltUnitar: Double; fltTotIte, fltDesEsp: Double): Double;
begin
  If fCfgSis('MDADCF') = '1' Then
  Begin
    Result := (fltTotIte - fltDesEsp);
  End
  Else
  Begin
    Result := fRetTotalItem(fltQtdIte, fltUnitar);
  End;
end;

function TUntFiscal.fRetTotalItem(fltQtdIte,
  fltUnitar: Double): Double;
begin
  {*****************************************}
  {* BEMATECH                              *}
  {**************************************MV*}
  If UpperCase( strCodEcf ) = '002' Then
  Begin
    Result := fTruncaFloat(fFormataFloat(fltQtdIte, 3) *
                           fFormataFloat(fltUniTar, 3), 2);
  End
  {*****************************************}
  {* DARUMA                                *}
  {**************************************MV*}
  Else If UpperCase( strCodEcf ) = '005' Then
  Begin
    fltQtdIte := fFormataFloat(fltQtdIte, 3);
    fltUnitar := fFormataFloat(fltUnitar, 2);
    Result    := fTruncaFloat(fltQtdIte * fltUnitar, 2);
  End

  Else
  Begin
    Result := fFormataFloat(fltQtdIte * fltUnitar, 2);
  End;
end;

function TUntFiscal.fAbreCupomVinculado( var strCodErr: String; strDesFormaPgto: String; fltValor: Double; strNumCupom: String): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  Result := True;

  {***********************************}
  {* BEMATECH                        *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fAbreCupomVinculado(strDesFormaPgto, fltValor, strNumCupom) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro(strCodErr, TRUE ) = '';
    End;

  End

End;

function TUntFiscal.fFechaCupomVinculado( var strCodErr: String): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin
  Result := True;

  {***********************************}
  {* BEMATECH                        *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fFechaCupomVinculado );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr, TRUE  ) = '';
    End;

  End

End;

function TUntFiscal.fFechaRelatorioGerencial(blnVerErro: Boolean): Boolean;
begin
  Result := False;

  {***********************************}
  {* BEMATECH MP 2100 TH FI          *}
  {********************************AF*}
  If UpperCase( strCodEcf ) = '002' Then
    Result := Bematech.fFechaRelatorioGerencial(blnVerErro) = 1;  

  {*******************************************}
  {* DARUMA FS700 OU SUPERIOR                *}
  {****************************************JC*}
  If UpperCase( strCodEcf ) = '008' Then
    Result := DarumaFS700_SU.fFechaRelatorioGerencial(blnVerErro);
end;

function TUntFiscal.fUsaCupomVinculado( var strCodErr: String; strLinha: String): Boolean;
  Var
    intACK: Integer;
    intST1: Integer;
    intST2: Integer;
Begin

  Result := True;

  {***********************************}
  {* BEMATECH                        *}
  {********************************MA*}
  If UpperCase( strCodEcf ) = '002' Then
  Begin

    strCodErr := IntToStr( Bematech.fUsaCupomVinculado(strLinha) );

    If ( strCodErr = '1' ) Then
    Begin

      intACK := 0;
      intST1 := 0;
      intST2 := 0;

      strCodErr := fStrZero( IntToStr( Bematech.fRetorno(intACK, intST1, intST2 ) ), 9 );

    End;

    Result := ( StrToInt( strCodErr ) = 1 );

    If Not( Result ) Then
    Begin
      Result := fRetMensErro( strCodErr, TRUE  ) = '';
    End;

  End

End;

{*****************************************************}
{* ALGUMAS IMPRESSORAS O ARREDONDAMENTO EH DIFERENTE *}
{**************************************************AF*}
function TFiscal.fAcionaGuilhotina: Boolean;
begin
  Result := True;
end;

function TFiscal.fArredonda(fltValor: Double; intDecimal: Integer): Double;
begin
  Result := fFormataFloat(fltValor, intdecimal);
end;

function TFiscalBrd.GetCpfCli: String;
begin
  Result := impInterna.fNumeroCNPJUsuario;
end;

function TFiscalBrd.GetMenPaf01: String;
begin
  Result := impInterna.strMenPaf01;
end;

procedure TFiscalBrd.SetMenPaf01(const Value: String);
begin
  impInterna.strMenPaf01 := Value;
end;

function TFiscalBrd.GetMenPaf02: String;
begin
  Result := impInterna.strMenPaf02;
end;

procedure TFiscalBrd.SetMenPaf02(const Value: String);
begin
  impInterna.strMenPaf02 := Value;
end;

function TFiscalBrd.GetModEcf: String;
begin
  Result := FModEcf;
end;

function TFiscalBrd.GetNumUsu: String;
begin
  If fEmptyStr(Trim(strCacheNumUsu)) Then
    strCacheNumUsu := impInterna.fNumeroUsuario;
    
  Result := strCacheNumUsu;
end;

function TFiscalBrd.GetCNPJUsuario: String;
begin
  Result := impInterna.fNumeroCNPJUsuario;
end;

function TFiscalBrd.GetNumeroCaixa: String;
begin
  Result := impInterna.fNumeroCaixa;
end;

function TFiscalBrd.GetVersaoSB: String;
begin
  Result := impInterna.fVersaoSoftwareBasico;
end;

function TFiscalBrd.GetDataGravacaoSB: TDateTime;
begin
  Result := impInterna.fDataGravacaoSoftwareBasico;
end;

function TFiscalBrd.GetHoraGravacaoSB: TDateTime;
begin
  Result := impInterna.fHoraGravacaoSoftwareBasico;
end;

function TFiscalBrd.GetIEUsuario: String;
begin
  Result := impInterna.fNumeroIEUsuario;
end;

function TFiscalBrd.GetTipoECF: String;
begin
  REsult := impInterna.fTipoECF;
end;

function TFiscalBrd.GetTotalSistema: String;
begin
  If Pos('EPSON', strMarca) > 0 Then
    Result := FloatToStrF(impInterna.fltTotSis, ffNumber, 12, 2)
  Else
    Result := '';
end;

function TFiscalBrd.GetMarcaECF: String;
begin
  Result := impInterna.fMarcaECF;
end;

function TFiscalBrd.GetCpfCupomFiscal: String;
begin
  Result := String(impInterna.strCpfCupomFiscal);
end;

procedure TFiscalBrd.SetCpfCupomFiscal(const Value: String);
begin
  impInterna.strCpfCupomFiscal := AnsiString(Value);
end;

function TFiscalBrd.GetEndereCupomFiscal: String;
begin
  Result := String(impInterna.strEndereCupomFiscal);
end;

function TFiscalBrd.GetApenasItensCheckOutF11: Boolean;
begin
  Result := impInterna.blnApenasItensCheckOutF11;
end;

function TFiscalBrd.GetNomeCupomFiscal: String;
begin
  Result := String(impInterna.strNomeCupomFiscal);
end;

procedure TFiscalBrd.SetEndereCupomFiscal(const Value: String);
begin
  impInterna.strEndereCupomFiscal := AnsiString(Value);
end;

procedure TFiscalBrd.SetNomeCupomFiscal(const Value: String);
begin
  impInterna.strNomeCupomFiscal := AnsiString(Value);
end;

procedure TFiscalBrd.SetApenasItensCheckOutF11(const Value: Boolean);
begin
  impInterna.blnApenasItensCheckOutF11 := Value;
end;

function TFiscalBrd.fEstadoToStr(estadoCvt: TEstadoECF): String;
begin
  If (estadoCvt = ecfPronta) Then
    Result := '0'
  Else If (estadoCvt = ecfCupomAberto) Then
    Result := '1'
  Else If (estadoCvt = ecfVinculadoAberto) Then
    Result := '2'
  Else If (estadoCvt = ecfGerencialAberto) Then
    Result := '3'
  Else If (estadoCvt = ecfTrabalhando) Then
    Result := '4'
  Else
    Result := '-1';
End;

function TFiscalBrd.fExcedeuLinhasDocumento: Boolean;
begin
  Try
    If Pos('EPSON', strMarca) > 0 Then
      Result := impInterna.fExcedeuLinhasDocumento
    Else
      Result := False;
  Except
    On E: Exception Do
      Result := False;
  End;
end;

function TFiscalBrd.fStrToEstado(strEstado: String): TEstadoECF;
begin
  If (strEstado = '0') Then
    Result := ecfPronta
  Else If (strEstado = '1') Then
    Result := ecfCupomAberto
  Else If (strEstado = '2') Then
    Result := ecfVinculadoAberto
  Else If (strEstado = '3') Then
    Result := ecfGerencialAberto
  Else If (strEstado = '4') Then
    Result := ecfTrabalhando
  Else
    Result := ecfPronta;
end;

procedure TFiscalBrd.pSetaEstado(estadoNovo: TEstadoECF);
begin
  estado := estadoNovo;
  objIni.WriteString('ECF','ESTADO', fEstadoToStr(estado));

  If estado = ecfPronta Then
  Begin
    fltQtdItens   := 0;
    fltTotSis     := 0;
    fltTotEcf     := 0;
    intUltimoItem := 0;
    objIni.WriteFloat('ECF', 'QTDITE', fltQtdItens);
    objIni.WriteFloat('ECF', 'TOTECF', fltTotEcf);
    objIni.WriteFloat('ECF', 'TOTSIS', fltTotSis);
    objIni.WriteInteger('ECF', 'ULTITE', intUltimoItem);
    objIni.UpdateFile;
  End;

end;

procedure TFiscalBrd.pPronta;
begin
  pSetaEstado(ecfPronta);

  strCacheCoo := '';
end;

procedure TFiscalBrd.pCupomAberto;
begin
  pSetaEstado(ecfCupomAberto);
end;

procedure TFiscalBrd.pVinculadoAberto;
begin
  pSetaEstado(ecfVinculadoAberto);
end;

procedure TFiscalBrd.pGerencialAberto;
begin
  pSetaEstado(ecfGerencialAberto);
end;

procedure TFiscalBrd.pTrabalhando;
begin
  pSetaEstado(ecfTrabalhando);
end;

function TFiscalBrd.fAbreCupom: Boolean;
begin
  pPreencheVariaveisImpressoraInterna;

  Result := impInterna.fAbreCupom;

  If Result Then
  Begin
    strCacheCcf := '';
    strCacheCoo := '';

    pCupomAberto;

    pCriaRegistroR04(fNumeroSerie,
                     fMFDAdicional,
                     strModEcf,
                     strNumUsu,
                     fNumeroCCF,
                     fRetornaCOO,
                     '',
                     strCgcCpf,
                     VS_Date);
  End;
end;

procedure TFiscalBrd.pPreencheVariaveisImpressoraInterna;
begin
  impInterna.strNumDoc  := fTiraCaracteresEspeciaisImp(Self.strNumDoc);
  impInterna.strCodCli  := fTiraCaracteresEspeciaisImp(Self.strCodCli);
  impInterna.strNomCli  := fTiraCaracteresEspeciaisImp(Self.strNomCli);
  impInterna.strCodVen  := fTiraCaracteresEspeciaisImp(Self.strCodVen);
  impInterna.strNomVen  := fTiraCaracteresEspeciaisImp(Self.strNomVen);
  impInterna.strEndCli  := fTiraCaracteresEspeciaisImp(Self.strEndCli);
  impInterna.strBaiCli  := fTiraCaracteresEspeciaisImp(Self.strBaiCli);
  impInterna.strCepCli  := fTiraCaracteresEspeciaisImp(Self.strCepCli);
  impInterna.strCidCli  := fTiraCaracteresEspeciaisImp(Self.strCidCli);
  impInterna.strEstCli  := fTiraCaracteresEspeciaisImp(Self.strEstCli);
  impInterna.strCgcCpf  := fTiraCaracteresEspeciaisImp(Self.strCgcCpf);
  impInterna.strIesCli  := fTiraCaracteresEspeciaisImp(Self.strIesCli);
  impInterna.strRG_Cli  := fTiraCaracteresEspeciaisImp(Self.strRG_Cli);
  impInterna.strCpfClie := fTiraCaracteresEspeciaisImp(Self.strCpfClie);
  impInterna.strTelCli  := fTiraCaracteresEspeciaisImp(Self.strTelCli);
  impInterna.fltIcmDev  := Self.fltIcmDev;
  impInterna.fltImpPag  := Self.fltImpPag;
  impInterna.fltPeImPg  := Self.fltPeImPg;
  impInterna.fltFedImp  := Self.fltFedImp;
  impInterna.fltPeImFd  := Self.fltPeImFd;
  impInterna.fltEstImp  := Self.fltEstImp;
  impInterna.fltPeImEs  := Self.fltPeImEs;
  impInterna.fltMunImp  := Self.fltMunImp;
  impInterna.fltPeImMn  := Self.fltPeImMn;
end;

function TFiscalBrd.fFechaCupom: Boolean;
begin
  pPreencheVariaveisImpressoraInterna;

  impInterna.fltTotSis := Self.fltTotSis;
  Result := impInterna.fFechaCupom;

  If Result Then
  Begin

    pCriarRegistroR06(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      fRetornaCOO,
                      '',
                      '',
                      '',
                      'RV');

    pAtualizarRegistroR06(fNumeroSerie,
                          fMFDAdicional,
                          strModEcf,
                          strNumUsu,
                          fRetornaCOO,
                          VS_date,
                          impInterna.fHoraEcf);

    pAtualizaGT(fGrandeTotal);

    //pTotalizarPagamentos(impInterna.fDataEcf);

    pPronta;
  End;
end;

function TFiscalBrd.fRegistraItem(strCodIte, strDesIte, strUnidad: String;
  fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String;
  fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strTotali: String;
    intContador: Integer;
    strI_PP_T: String;

    function fRetTotali(strIndTri: String): String;
    begin
      {*****************************************}
      {* CASO FOR UM INDICE, É TRIBUTADO       *}
      {**************************************MV*}
      If fIsNumber(impInterna.strUltIndiceTri) Then
      Begin
        Result := impInterna.strUltIndiceTri + 'T' + fValNumForm(fltAlqIcm, 4, 2);
      End
      Else
      Begin
        Result := impInterna.strUltIndiceTri + '1';
      End;
    end;

begin

  If fEmptyStr(strUnidad) Then
  Begin
    strUnidad := 'UN';
  End;

  strUnidad := LeftStr(strUnidad, 2);
  For intContador := 1 To Length(strUnidad) Do
  Begin
    If Pos(Copy(strUnidad, intContador, 1), '0123456789') > 0 Then
    Begin
      strUnidad := 'UN';
      Break;
    End;
  End;

  strCodIte := fTiraCaracteresEspeciaisImp(strCodIte);
  strDesIte := fTiraCaracteresEspeciaisImp(strDesIte);
  strUnidad := fTiraCaracteresEspeciaisImp(strUnidad);

  pLog('Antes fRegistraItem');
  Result := impInterna.fRegistraItem(strCodIte, strDesIte, strUnidad, fltAlqIcm,
    fltQtdIte, fltUnitar, strCodFis, fltDesEsp, fltTotal);
  pLog('Depois fRegistraItem');

  If (Result) Then
  Begin
    strI_PP_T := fRetornaI_PP_T(strCodIte);

    fltTotEcf := fltTotEcf + VS_objFiscal.fRetTotalItem(fltQtdIte,
                                                        fltUnitar);

    fltTotSis := fltTotSis + VS_objFiscal.fCalculaTotalSistema(fltQtdIte,
                                                               fltUnitar);

    fltQtdItens := fltQtdItens + 1;
    Inc(intUltimoItem);
    objIni.WriteFloat('ECF', 'QTDITE', fltQtdItens);
    objIni.WriteFloat('ECF', 'TOTECF', fltTotEcf);
    objIni.WriteFloat('ECF', 'TOTSIS', fltTotSis);
    objIni.WriteInteger('ECF', 'ULTITE', intUltimoItem);
    objIni.UpdateFile;

    strTotali := '';
    if fIsNumber(impInterna.strUltIndiceTri) then
      strTotali := fRetornaTotAliEcfAlq(fltAlqIcm);

    if (fEmptyStr(strTotali)) then
      strTotali := fRetTotali(impInterna.strUltIndiceTri);

    pCriaRegistroR05(fNumeroSerie,
                     fMFDAdicional,
                     strModEcf,
                     strNumUsu,
                     fNumeroCCF,
                     fRetornaCOO,
                     impInterna.fUltimoItemVendido,
                     strCodIte,
                     strDesIte,
                     fltQtdIte,
                     strUnidad,
                     fltUnitar,
                     impInterna.fltUltDesEspIte,
                     impInterna.fltUltAcrescIte,
                     fFormataFloat(fltQtdIte * fltUnitar, 2) - impInterna.fltUltDesEspIte + impInterna.fltUltAcrescIte,
                     strTotali,
                     intDecQtd,
                     intDecUni,
                     VS_date,
                     strI_PP_T);
    pLog('Depois PAFR05');
  End;
end;

function TFiscalBrd.fCancelaItem(strItem: String; fltQtdIte, fltUnitar: Double): Boolean;
begin
  Result := impInterna.fCancelaItem(strItem);

  If (Result) Then
  Begin

    fltTotEcf := fltTotEcf + VS_objFiscal.fRetTotalItem(fltQtdIte,
                                                        fltUnitar);

    fltTotSis := fltTotSis + VS_objFiscal.fCalculaTotalSistema(fltQtdIte,
                                                               fltUnitar);

    fltQtdItens := fltQtdItens - 1;
    objIni.WriteFloat('ECF', 'QTDITE', fltQtdItens);
    objIni.WriteFloat('ECF', 'TOTECF', fltTotEcf);
    objIni.WriteFloat('ECF', 'TOTSIS', fltTotSis);
    objIni.UpdateFile;

    pCancelarRegistroR05(fNumeroSerie,
                         fMFDAdicional,
                         strModEcf,
                         strNumUsu,
                         fRetornaCOO,
                         strItem,
                         False,
                         '');
  End;
end;

function TFiscalBrd.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := impInterna.fImpLinFiscal(strAtrib, strLinha);
end;

function TFiscalBrd.fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
  strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean;
begin
  Result := impInterna.fImprimirCodigoBarras(cbTipo, strCodigo, strLargura, strAltura, strOrientacao, strImpTexto, strTextoLivre);
end;

function TFiscalBrd.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean;
  Var
    fltDesAcres: Double;
begin

  If fFormataFloat( fltTotImp, 2 ) > fFormataFloat( fltTotal, 2 ) Then
  Begin
    fltDesAcres := fltTotImp - fltTotal;
    strAcrDes := 'D';
  End
  Else
  Begin
    fltDesAcres := fltTotal - fltTotImp;
    strAcrDes := 'A';
  End;

  Result := impInterna.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC, fltTotal, fltTotImp);

  If (Result) And (VS_strUsaPaf = 'S') Then
  Begin
    pFecharRegistroR04(fNumeroSerie,
                       fMFDAdicional,
                       strModEcf,
                       strNumUsu,
                       fRetornaCOO,
                       fltTotImp,
                       IIF(strAcrDes='D', fltDesAcres, 0.00),
                       'V',
                       IIF(strAcrDes='A', fltDesAcres, 0.00),
                       'V',
                       fltTotal,
                       0.0,
                       strAcrDes);

    if (fltDesAcres > 0) then
      pRateioAcrDescNosRetistrosR05(fNumeroSerie, fRetornaCOO, strAcrDes, fltDesAcres);
  End;

end;

//function TFiscalBrd.fRegistraAcrDes(fltDesEsp: Double): Boolean;
//  Var
//    fltTotDif: Double;
//    fltTotLiq: Double;
//    strAcrDes: String;
//begin
//  fltTotDif := fltTotSis - fltDesEsp - fltTotEcf;
//  fltTotDif := fRetTotalEcf(1, fltTotDif);
//
//  fltTotLiq := fltTotEcf + fltTotDif;
//
//  If fltTotDif > 0 Then
//  Begin
//    strAcrDes := 'A';
//  End
//  Else
//  Begin
//    strAcrDes := 'D';
//    fltTotDif := (-1) * fltTotDif;
//  End;
//
//  Result := impInterna.fRegistraAcrDes(strAcrDes, '$', FloatToStr(fltTotDif), fltTotSis, fltTotEcf);
//
//  If (Result) Then
//  Begin
//    pFecharRegistroR04(fNumeroSerie,
//                       fMFDAdicional,
//                       strModEcf,
//                       strNumUsu,
//                       fRetornaCOO,
//                       fltTotSis,
//                       IIF(strAcrDes='D', fltTotDif, 0.00),
//                       'V',
//                       IIF(strAcrDes='A', fltTotDif, 0.00),
//                       'V',
//                       fltTotLiq,
//                       0.0,
//                       strAcrDes);
//  End;
//
//end;

function TFiscalBrd.fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean;
begin

  Result := True;

  If fltQtdItens <= 0 Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'É necessário informar ao menos um item para informar uma modalidade.',
      ['&Ok']);
  End;

  If Result Then
    Result := impInterna.fRegistraModalidades(strCodMod, strDesMod, fltValMod, strInfAdi);

  If Result Then
  Begin

    pCriarRegistroR07(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      fRetornaCOO,
                      fNumeroCCF,
                      '',
                      strDesMod,
                      fltValMod,
                      impInterna.fDataEcf);

  End;
end;

function TFiscalBrd.fLeituraX(strParam: String;
  blnPergunta: Boolean): Boolean;
begin
  Result := impInterna.fLeituraX(strParam, blnPergunta);
end;

function TFiscalBrd.fReducaoZ(strData, strHora: String): Boolean;
  Var
    drzDadosReducao: TDadosReducao;
begin
  Result := impInterna.fReducaoZ(strData, strHora);

  If (Result) Then
  Begin
    If (fDadosUltimaReducao(drzDadosReducao)) Then
    Begin
      pGravaDadosUltReducao(drzDadosReducao);
    End
    Else
    Begin
      fMensagem('ATENÇÃO', 'Não foi possível capturar os dados da Redução Z.' + #13#10 +
                           'Será necessário fazê-lo através do menu Util -> Capturar dados da Redução Z.', ['&Ok']);
    End;
  End;

end;

function TFiscalBrd.fReducaoZPendente: Boolean;
begin
  Result := impInterna.fReducaoZPendente;
end;

function TFiscalBrd.fAbreGaveta: Boolean;
begin
  Result := impInterna.fAbreGaveta;
end;

function TFiscalBrd.fStatusImpressora: String;
begin
  Result := impInterna.fStatusImpressora;
end;

function TFiscalBrd.fAbrePortaImpressora: Boolean;
begin
  Result := fAbrePortaImpressora;
end;

function TFiscalBrd.fCancelaCupom: Boolean;
  Var
    strNumCOO,
    strNumCCF: String;
begin

  strNumCOO := fRetornaCOO;
  strNumCCF := impInterna.fNumeroCCF;

  Result := impInterna.fCancelaCupom;

  pPronta;

  If Result Then
  Begin
    pCancelarRegistroR04(fNumeroSerie,
                        fMFDAdicional,
                        strModEcf,
                        strNumUsu,
                        strNumCOO);

    pCancelarRegistroR05(fNumeroSerie,
                         fMFDAdicional,
                         strModEcf,
                         strNumUsu,
                         strNumCOO,
                         '',
                         True,
                         strNumCCF);

    pEstornarRegistroR07(fNumeroSerie,
                         fMFDAdicional,
                         strModEcf,
                         strNumUsu,
                         strNumCCF);

    pAtualizaGT(fGrandeTotal);
  End;
end;

function TFiscalBrd.fRetornaCOO: String;
begin
  If fEmptyStr(strCacheCoo) Then
  Begin
    strCacheCoo := impInterna.fRetornaCOO;
  End;
  Result := strCacheCoo;
end;

function TFiscalBrd.fNumeroSerie: String;
begin
  Result := impInterna.fNumeroSerie;
end;

function TFiscalBrd.fPathEcfIni: String;
  Var
    strPathEcfIni : String;
begin
  strPathEcfIni := fCfgSis('DIRINI');
  If Not DirectoryExists(strPathEcfIni) Then
    strPathEcfIni := ExtractFilePath(Application.ExeName);
  Result := strPathEcfIni;
end;

function TFiscalBrd.fexecutaCMD(strCmd: String;
  blnRetorna: Boolean): String;
begin
  Result := impInterna.fexecutaCMD(strCmd, blnRetorna);
end;

function TFiscalBrd.fVerErro(blnMostraErro: Boolean): Boolean;
begin
  Result := impInterna.fVerErro(blnMostraErro);
end;

function TFiscalBrd.fVerificaCupomAberto: Boolean;
begin
  Result := impInterna.fVerificaCupomAberto;
end;

function TFiscalBrd.fCalcAliquota(strCodFiscal: String;
  fltAliquota: Double; intTipRet: Integer): String;
begin
  Result := impInterna.fCalcAliquota(strCodFiscal, fltAliquota, intTipRet);
end;

function TFiscalBrd.fCalculaValorIcms(fltValorBruto: Double): Double;
begin
  Result := impInterna.fCalculaValorIcms(fltValorBruto);
end;

function TFiscalBrd.fCalculaTotalSistema(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := impInterna.fRetTotalSistema(fltQtdIte, fltUnitar);
end;

function TFiscalBrd.fRetTotalEcf(fltQtdIte, fltUnitar: Double; fltTotIte, fltDesEsp: Double): Double;
begin
  If fCfgSis('MDADCF') = '1' Then
  Begin
    Result := (fltTotIte - fltDesEsp);
  End
  Else
  Begin
    Result := impInterna.fRetTotalImpressora(fltQtdIte, fltUnitar);
  End;
end;

function TFiscalBrd.fRetTotalItem(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := impInterna.fRetTotalImpressora(fltQtdIte, fltUnitar);
end;

function TFiscalBrd.fArredonda(fltValor: Double; intDecimal: Integer): Double;
begin
  Result := impInterna.fArredonda(fltValor, intDecimal);
end;

procedure TFiscalBrd.pFechaPortaImpressora;
begin
  impInterna.pFechaPortaImpressora;
end;

procedure TFiscalBrd.pPausaLeitura;
begin
  impInterna.pPausaLeitura;
end;

function TFiscalBrd.fAbreCNFVinculado(strDesFormaPgto, strValor,
  strNumCupom: String; blnMostrarErro: Boolean = True; strQtdPar: String = ''): Boolean;
begin
  Result := impInterna.fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom, strQtdPar);
  If Result Then
  Begin

    strCacheCcf := '';
    strCacheCoo := '';

    strFormaPgtoVinculado := strDesFormaPgto;
    objIni.WriteString('ECF', 'MODVINC', strFormaPgtoVinculado);
    objIni.UpdateFile;

    pVinculadoAberto;

    pCriarRegistroR06(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      fRetornaCOO,
                      impInterna.fNumeroGNF,
                      impInterna.fNumeroGRG,
                      impInterna.fNumeroCDC,
                      'CC');

  End;
end;

function TFiscalBrd.fFechaCNFVinculado(blnMostrarErro: Boolean): Boolean;
begin
  Result := True;
  If estado = ecfVinculadoAberto Then
  Begin
    Result := impInterna.fFechaCNFVinculado(blnMostrarErro);

    If (Result) Then
    Begin
      pAtualizarRegistroR06(fNumeroSerie,
                            fMFDAdicional,
                            strModEcf,
                            strNumUsu,
                            fRetornaCOO,
                            impInterna.fDataEcf,
                            impInterna.fHoraEcf);

      pAtualizarRegistroR07(fNumeroSerie,
                            fMFDAdicional,
                            strModEcf,
                            strNumUsu,
                            impInterna.fNumeroCCF,
                            strFormaPgtoVinculado,
                            impInterna.fNumeroGNF);

      //pTotalizarPagamentos(impInterna.fDataEcf);

      strFormaPgtoVinculado := '';
      objIni.WriteString('ECF', 'MODVINC', strFormaPgtoVinculado);
      objIni.UpdateFile;
    End;

    pPronta;
  End;
end;

function TFiscalBrd.fUsaCNFVinculado(strTexto: String;
  blnMostrarErro: Boolean): Boolean;
begin
  Result := impInterna.fUsaCNFVinculado(strTexto);
end;

function TFiscalBrd.fRelatorioGerencial(strTexto: String;
  blnMostrarErro: Boolean): Boolean;
begin
  Result := True;
  If (estado <> ecfGerencialAberto) Then
  Begin
    Result := fAbreRelatorioGerencial(blnMostrarErro);
  End;

  If Result Then
  Begin
    Result := impInterna.fRelatorioGerencial(strTexto);
    If Result Then
    Begin
      If (estado <> ecfGerencialAberto) Then
      Begin
        pCriarRegistroR06(fNumeroSerie,
                          fMFDAdicional,
                          strModEcf,
                          impInterna.fNumeroUsuario,
                          fRetornaCOO,
                          impInterna.fNumeroGNF,
                          impInterna.fNumeroGRG,
                          '',
                          'RG');
      End;
      pGerencialAberto;
    End;
  End;
end;

function TFiscalBrd.fFechaRelatorioGerencial(
  blnMostrarErro: Boolean): Boolean;
begin
  Result := True;
  If estado = ecfGerencialAberto Then
  Begin
    Result := impInterna.fFechaRelatorioGerencial(blnMostrarErro);

    If (Result) Then
    Begin
      pAtualizarRegistroR06(fNumeroSerie,
                            fMFDAdicional,
                            strModEcf,
                            strNumUsu,
                            fRetornaCOO,
                            impInterna.fDataEcf,
                            impInterna.fHoraEcf);

      If (Not fEmptyStr(strFormaPgtoVinculado)) Then
      Begin
        pAtualizarRegistroR07(fNumeroSerie,
                              fMFDAdicional,
                              strModEcf,
                              strNumUsu,
                              impInterna.fNumeroCCF,
                              strFormaPgtoVinculado,
                              impInterna.fNumeroGNF);

        //pTotalizarPagamentos(impInterna.fDataEcf);

        strFormaPgtoVinculado := '';
        objIni.WriteString('ECF', 'MODVINC', strFormaPgtoVinculado);
        objIni.UpdateFile;
      End;
    End;
  End;

  pPronta;
end;

function TFiscalBrd.fFormatarTextoImp(strTexto: String;
  FonteEstilos: TFontesImpFiscal): String;
begin
  Result := impInterna.fFormatarTextoImp(strTexto, FonteEstilos);
end;

function TFiscalBrd.fLeituraMemoriaFiscal(blnCompleta: Boolean;
  strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean;
begin
  pTrabalhando;
  Result := impInterna.fLeituraMemoriaFiscal(blnCompleta, strTipoFiltro,
    strFiltroIni, strFiltroFin);
  pPronta;
end;

function TFiscalBrd.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
begin
  pTrabalhando;
  Result := impInterna.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
    strArquivoSaida);
  pPronta;
end;

function TFiscalBrd.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
begin
  pTrabalhando;
  Result := impInterna.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
    strRazSocEmp, strEndereEmp);

  pTrocaCaracteresEspeciais(strArquivoSaida);

  pPronta;
end;

procedure TFiscalBrd.pTrocaCaracteresEspeciais(const strArquivio: String);
  Var
    stlArq: TStringList;
    strConteudo: String;
begin
  stlArq := TStringList.Create;
  stlArq.LoadFromFile(strArquivio);

  strConteudo := stlArq.Text;
  strConteudo := AnsiReplaceStr(strConteudo, #181, #193);
  strConteudo := AnsiReplaceStr(strConteudo, #128, #199);
  strConteudo := AnsiReplaceStr(strConteudo, #233, #218);
  strConteudo := AnsiReplaceStr(strConteudo, #210, #202);

  stlArq.Clear;
  stlArq.Text := strConteudo;
  stlArq.SaveToFile(strArquivio);

  FreeAndNil(stlArq);
end;

function TFiscalBrd.fDadosUltimaReducao(
  var drzDadosReducao: TDadosReducao): Boolean;
begin
  result := impInterna.fDadosUltimaReducao(drzDadosReducao);
end;

function TFiscalBrd.fDataEcf: TDateTime;
begin
  Result := impInterna.fDataEcf;
end;

function TFiscalBrd.fHoraEcf: TDateTime;
begin
  Result := impInterna.fHoraEcf;
end;

function TFiscalBrd.fGrandeTotal: Double;
begin
  Result := impInterna.fGrandeTotal;
end;

function TFiscalBrd.fVendaBruta: Double;
begin
  Result := impInterna.fVendaBruta;
end;

function TFiscalBrd.fGerarSintegra(blnApenas75: Boolean; strArquivo,
  strMes, strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro,
  strCidade, strNumCep, strFone01, strNumFax, strContat: String): Boolean;
begin

  strRazSoc := Copy(strRazSoc, 1, 35);
  strEndere := Copy(strEndere, 1, 34);
  strNumEnd := Copy(strNumEnd, 1, 05);
  strComple := Copy(strComple, 1, 22);
  strBairro := Copy(strBairro, 1, 15);
  strCidade := Copy(strCidade, 1, 30);
  strNumCep := Copy(fTiraCaracEspeciais(strNumCep), 1, 08);
  strFone01 := Copy(fTiraCaracEspeciais(strFone01), 1, 12);
  strNumFax := Copy(fTiraCaracEspeciais(strNumFax), 1, 10);
  strContat := Copy(strContat, 1, 18);

  If fEmptyStr(strContat) Then
    strContat := 'NAO INFORMADO';

  Result := impInterna.fGerarSintegra(blnApenas75, strArquivo,
    strMes, strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro,
    strCidade, strNumCep, strFone01, strNumFax, strContat);
end;

function TFiscalBrd.fNumeroCCF: String;
begin
  If fEmptyStr(strCacheCcf) Then
  Begin
    strCacheCcf := impInterna.fNumeroCCF;
  End;
  Result := strCacheCcf;
end;

function TFiscalBrd.fSangria(fltValor: Double): Boolean;
begin
  Result := impInterna.fSangria(fltValor);

  If Result Then
  Begin
    strCacheCcf := '';
    strCacheCoo := '';

    pCriarRegistroR06(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      fRetornaCOO,
                      impInterna.fNumeroGNF,
                      '',
                      '',
                      'CN');

    pAtualizarRegistroR06(fNumeroSerie,
                          fMFDAdicional,
                          strModEcf,
                          strNumUsu,
                          fRetornaCOO,
                          fDataEcf,
                          fHoraEcf);
  End;
end;

function TFiscalBrd.fSuprimento(fltValor: Double; strModalidade: String = 'Dinheiro'): Boolean;
begin
  Result := impInterna.fSuprimento(fltValor, strModalidade);

  If (Result) Then
  Begin
    strCacheCcf := '';
    strCacheCoo := '';

    pCriarRegistroR06(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      fRetornaCOO,
                      impInterna.fNumeroGNF,
                      '',
                      '',
                      'CN');

    pAtualizarRegistroR06(fNumeroSerie,
                          fMFDAdicional,
                          strModEcf,
                          strNumUsu,
                          fRetornaCOO,
                          fDataEcf,
                          fHoraEcf);

    pCriarRegistroR07(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      fRetornaCOO,
                      '',
                      impInterna.fNumeroGNF,
                      strModalidade,
                      fltValor,
                      fDataEcf);

    //pTotalizarPagamentos(impInterna.fDataEcf);
  End;
end;

function TFiscalBrd.fVinculadoAberto: Boolean;
begin
  Result := (estado = ecfVinculadoAberto);
end;

function TFiscalBrd.fHouveIncrementoDeCRO: Boolean;
  Var
    drzDadosRed: TDadosReducao;
    strUltNumCRO: String;
begin
  strUltNumCRO := fPafUltNumCRO(fNumeroSerie);
  fDadosUltimaReducao(drzDadosRed);

  If (Not fEmptyStr(strUltNumCRO))           And
     (drzDadosRed.strNumCRO <> strUltNumCRO) Then
  Begin
    Result := True;
  End
  Else
  Begin
    Result := False;
  End;
end;

procedure TFiscalBrd.pGravaDadosUltReducao(drzDadosReducao: TDadosReducao);
  Var
    intContador: Integer;
begin
  pCriarRegistroR01(fNumeroSerie,
                    fMFDAdicional,
                    impInterna.fTipoECF,
                    strMarca,
                    strModEcf,
                    strVersaoSB,
                    dtaDataGravacaoSB,
                    dtaHoraGravacaoSB,
                    StrToInt(impInterna.fNumeroCaixa),
                    strCNPJUsuario,
                    strIEUsuario,
                    '51212899000125',
                    '',
                    '',
                    'CITEL ANÁLISE E PROGRAMAÇÃO DE SISTEMAS',
                    '0104',
                    drzDadosReducao.dtaDtaMov);

  pCriarRegistroR02(fNumeroSerie,
                    fMFDAdicional,
                    strModEcf,
                    strNumUsu,
                    drzDadosReducao.strNumCRZ,
                    drzDadosReducao.strNumCOORZ,
                    drzDadosReducao.strNumCRO,
                    drzDadosReducao.dtaDtaMov,
                    impInterna.fDataEcf,
                    impInterna.fHoraEcf,
                    impInterna.fVendaBruta,
                    'N');

  For intContador := Low(drzDadosReducao.arrTotali) To High(drzDadosReducao.arrTotali) Do
  Begin
    pAlteraTotAliEcfAlq(drzDadosReducao.arrTotali[intContador].strCodTot);

    pCriarRegistroR03(fNumeroSerie,
                      fMFDAdicional,
                      strModEcf,
                      strNumUsu,
                      drzDadosReducao.strNumCrz,
                      drzDadosReducao.arrTotali[intContador].strCodTot,
                      drzDadosReducao.arrTotali[intContador].fltValAcu,
                      drzDadosReducao.dtaDtaMov);
  End;

  pTotalizarPagamentos(drzDadosReducao.dtaDtaMov, fNumeroSerie);

end;

function TFiscalBrd.fUltimoComandoComErro: Boolean;
begin
  Result := impInterna.fUltimoComandoComErro;
end;

constructor TFiscalBrd.Create(Owner: TComponent; strModelo: String);
begin
  inherited Create(Owner);

  intDecQtd := fCfgSis('DECQTD', varInteger);
  intDecUni := fCfgSis('DECUNI', varInteger);

  Try
    impInterna := TFiscal.fCriarImpressora(Self, strModelo, '', '');
  Except
    On E: Exception Do
    Begin
      Raise ExceptionAutCom.Create(E.Message + sLineBreak +
        'Por favor, verifique se a impressora está ligada ou configurada corretamente (path de configuração, modelo, etc).' + sLineBreak +
        'Para verificar configurações do ECF, vá em Util -> Configuração do Sistema -> Cupom Fiscal.' );
    End;
  End;

  objIni := TIniFile.Create(fPathEcfIni + '\' + fNumeroSerie + 'ecf.ini');
  estado := fStrToEstado(objIni.ReadString('ECF', 'ESTADO', '0'));
  fltQtdItens   := objIni.ReadFloat('ECF', 'QTDITE', 0);
  fltTotEcf     := objIni.ReadFloat('ECF', 'TOTECF', 0);
  fltTotSis     := objIni.ReadFloat('ECF', 'TOTSIS', 0);
  intUltimoItem := objIni.ReadInteger('ECF', 'ULTITE', 0);
  strFormaPgtoVinculado := objIni.ReadString('ECF', 'MODVINC', '');

  FModEcf := StrPas(PChar(impInterna.fModeloEcf));
  strCacheNumUsu := '';
end;

destructor TFiscalBrd.Destroy;
begin
  FreeLibrary(HandleSignBema);
  HandleSignBema := 0;
  generateEAD := Nil;
  FreeAndNil(objIni);
  FreeAndNil(impInterna);
  inherited Destroy;
end;

function TFiscal.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
begin
  Result := True;
end;

function TFiscalBrd.fAbreRelatorioGerencial(
  blnMostrarErro: Boolean): Boolean;
begin
  Result := impInterna.fAbreRelatorioGerencial(blnMostrarErro);
  If Result Then
  Begin
    strCacheCcf := '';
    strCacheCoo := '';

    If (estado <> ecfGerencialAberto) Then
    Begin
      pCriarRegistroR06(fNumeroSerie,
                        fMFDAdicional,
                        strModEcf,
                        impInterna.fNumeroUsuario,
                        fRetornaCOO,
                        impInterna.fNumeroGNF,
                        impInterna.fNumeroGRG,
                        '',
                        'RG');
    End;
    pGerencialAberto;
  End;
end;

function TFiscalBrd.fAcionaGuilhotina: Boolean;
begin
  Result := impInterna.fAcionaGuilhotina;
end;

function TFiscalBrd.fMFDAdicional: String;
begin
  Result := impInterna.fMFDAdicional;
end;

function TFiscalBrd.fArquivoEcfIniValido(var strArquivo: String): Boolean;
  Var
    strNumeroSerie : String;
    strCodigoEcf : String;
begin
  Result := False;
  Try
    strCodigoEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA', '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
    strNumeroSerie := fCampoTabela('ECF_NUMSER', 'CADECF', ['ECF_CODECF'], [strCodigoEcf]);

    If Not Assigned(objIni) Then
      Exit;

    strArquivo := 'Arquivo Criado: ' + objIni.FileName;

    If (fEmptyStr(objIni.FileName)) Then
      Exit;

    If (fPathEcfIni + '\' + strNumeroSerie + 'ecf.ini') <> (objIni.FileName) Then
    Begin
      strArquivo := strArquivo + sLineBreak +
                    'Arquivo Correto: ' + fPathEcfIni + '\' + strNumeroSerie + 'ecf.ini';
      Exit;
    End;

    If Not FileExists(objIni.FileName) Then
      Exit;

    Result := True;
  Except
    Result := False;
  End;
end;

function TFiscalBrd.fValidaSerieECFEmpresa(var strNumSer: String): Boolean;
  Var
    qryCadEcf : TUniQuery;
begin
  qryCadEcf := fCriaQuery(Nil);
  strNumSer := '';
  Try
    Result := True;
    qryCadEcf.Close;
    qryCadEcf.SQL.Clear;
    qryCadEcf.SQL.Add(' SELECT ECF_CODECF ');
    qryCadEcf.SQL.Add('   FROM CADECF ');
    qryCadEcf.SQL.Add('  WHERE ECF_NUMSER = :NUMSER ');
    qryCadEcf.SQL.Add('    AND ECF_CODEMP = :CODEMP ');
    qryCadEcf.ParamByName('NUMSER').AsString := Self.fNumeroSerie;
    qryCadEcf.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadEcf.Open;

    If (qryCadEcf.IsEmpty) Then
    Begin
      Result := False;
      strNumSer := Self.fNumeroSerie;
    End;

    qryCadEcf.Close;
  Finally
    FreeAndNil(qryCadEcf);
  End;
end;

procedure pAssinarDigitalmente(strNomeArquivo: AnsiString);
  Var
    strEad: AnsiString;
begin
  If fCfgSis('CASGBM', varBoolean) Then
  Begin
    pCarregarSignBema;
  End
  Else
  Begin
    If Not Assigned(generateEAD) Then
      pCarregarSignBema;
  End;

  SetLength(strEad, 256);
  generateEAD(strNomeArquivo, CHAVE_PUBLICA, CHAVE_PRIVADA, strEad, 1);
end;

procedure pCarregarSignBema;
  Var
    strDllSignBema: String;
    intNumTent: Integer;
  Const
    MAX_TENTATIVAS = 5;
begin

  If Assigned(generateEAD) Then
  Begin
    FreeLibrary(HandleSignBema);
    HandleSignBema := 0;
  End;

  strDllSignBema := ExtractFilePath(Application.ExeName) + 'sign_bema.dll';
  intNumTent := 0;

  If FileExists( strDllSignBema ) Then
  Begin
    While (intNumTent < MAX_TENTATIVAS) And (HandleSignBema <= 0) Do
    Begin
      HandleSignBema := LoadLibrary(PChar(strDllSignBema));
      Sleep(200);
      Inc(intNumTent);
    End;

    If HandleSignBema = 0 Then
      fMensagem('ATENÇÃO!', 'Não foi possível carregar a dll sign_bema.dll.' + #13#10 + 'Verifique se o .Net Framework está atualizado.', ['&Ok']);

    generateEAD := GetProcAddress(HandleSignBema, pChar('generateEAD'));
  End
  Else
  Begin
    HandleSignBema := 0;
    fMensagem('ATENÇÃO!', 'Não foi possível encontrar a dll sign_bema.dll.', ['&Ok']);
  End;
end;

function TFiscal.fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := fFormataFloat(fltQtdIte * fltUnitar, 2);
end;

function TFiscal.fRetTotalSistema(fltQtdIte, fltUnitar: Double): Double;
begin
  Result := fFormataFloat(fltQtdIte * fltUnitar, 2);
end;

function TFiscal.fVerificaCupomAberto: Boolean;
begin
  Result := False;
end;

function fTiraCaracteresEspeciaisImp(strTexto: String): String;
begin
//  Result := fTiraCaracEspeciais(strTexto, True, False, False, False, True, False);
  Result := strTexto;
end;

function fCriaEcfModeloVelho: TUntFiscal;
  Var
    strPatIni: String;
    strCodEcf: String;
    strModEcf: String;
    strPorta: String;
    strCodErr: String;
begin
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
  strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

  Result := TUntFiscal.Create;

  If Not Result.pSetModEcf( strModEcf ) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não foi possivel setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
    Result.fFinalizaEcf(strCodErr);
    Result.Free;
    Result := Nil;
  End
  Else If Not Result.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
  Begin
    fMensagem('ATENÇÃO!', Result.fRetMensErro( strCodErr ), ['&Ok']);
    Result.fFinalizaEcf(strCodErr);
    Result.Free;
    Result := Nil;
  End
  Else If Not Result.fRetImpLigada( strCodErr ) Then
  Begin
    fMensagem('ATENÇÃO!', Result.fRetMensErro( strCodErr ), ['&Ok']);
    Result.fFinalizaEcf(strCodErr);
    Result.Free;
    Result := Nil;
  End
end;

End.

