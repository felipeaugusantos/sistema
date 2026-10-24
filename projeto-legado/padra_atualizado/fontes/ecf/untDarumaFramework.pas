unit untDarumaFramework;

interface

  Uses Windows, untFiscal, Classes, SysUtils, Forms, Uni,
    StrUtils, MaskUtils, Dialogs, Graphics, untFuncoesGenerica, Math,
    untTypesSistema;

{**********************************************}
{* DADOS DA ULTIMA REDUCAO Z - 1164 POSICOES  *}
{**********************************************}
{* Data do Movimento 8           |0001 - 0008 *}
{* Grande Total  18              |0009 - 0026 *}
{* Grande Total Inicial 18       |0027 - 0044 *}
{* Descontos ICMS 14             |0045 - 0058 *}
{* Descontos ISS  14             |0059 - 0072 *}
{* Cancelamentos ICMS 14         |0073 - 0086 *}
{* Cancelamentos ISS 14          |0087 - 0100 *}
{* Acréscimos ICMS 14            |0101 - 0114 *}
{* Acréscimos ISS  14            |0115 - 0128 *}
{* Tributados ICMS/ISS 224       |0129 - 0352 *}
{* F1 ICMS  14                   |0353 - 0366 *}
{* F2 ICMS  14                   |0367 - 0380 *}
{* I1 ICMS  14                   |0381 - 0394 *}
{* I2 ICMS  14                   |0395 - 0408 *}
{* N1 ICMS  14                   |0409 - 0422 *}
{* N2 ICMS  14                   |0423 - 0436 *}
{* F1 ISS   14                   |0437 - 0450 *}
{* F2 ISS   14                   |0451 - 0464 *}
{* I1 ISS   14                   |0465 - 0478 *}
{* I2 ISS   14                   |0479 - 0492 *}
{* N1 ISS   14                   |0493 - 0506 *}
{* N2 ISS   14                   |0507 - 0520 *}
{* Totalizadores NF 280          |0521 - 0800 *}
{* Descontos NF  14              |0801 - 0814 *}
{* Cancelamentos NF 14           |0815 - 0828 *}
{* Acréscimos NF  14             |0829 - 0842 *}
{* Alíquotas  80                 |0843 - 0922 *}
{* CRO   4                       |0923 - 0926 *}
{* CRZ   4                       |0927 - 0930 *}
{* CRZ Restante  4               |0931 - 0934 *}
{* COO   6                       |0935 - 0940 *}
{* GNF   6                       |0941 - 0946 *}
{* CCF   6                       |0947 - 0952 *}
{* CVC   6                       |0953 - 0958 *}
{* GRG   6                       |0959 - 0964 *}
{* CFD   6                       |0965 - 0970 *}
{* CBP   6                       |0971 - 0976 *}
{* NFC   4                       |0977 - 0980 *}
{* CMV   4                       |0981 - 0984 *}
{* CFC   4                       |0985 - 0988 *}
{* CNC   4                       |0989 - 0992 *}
{* CBC   4                       |0993 - 0996 *}
{* NCN   4                       |0997 - 1000 *}
{* CDC   4                       |1001 - 1004 *}
{* CON   80                      |1005 - 1084 *}
{* CER   80                      |1085 - 1164 *}
{*******************************************JC*}

Type
  TarrFormasPagto = Array of String[16];

  TDaruma = class(TFiscal)

  private
    FVersaoSB: AnsiString;
    FDataGravacaoSB: TDateTime;
    FHoraGravacaoSB: TDateTime;
    FNumCaixa: AnsiString;
    FCNPJ: AnsiString;
    FIE: AnsiString;

    FCodRet : Integer;
    FNumErro: Integer;
    FNumAvis: Integer;
    FMsgRet_: String;
    FMsgErro: String;
    FMsgAvis: String;
    FfltTotImpInt: Double;

    FMsgFechamento: String;

    FPais: TPais;

    blnUltComandoErro: Boolean;

    blnModoNovo: Boolean;

    arrNomesFormasPagto: TarrFormasPagto;    

    function getSucesso: Boolean;
    function getMensErro: String;

    procedure pCarregaDataHoraGravSB;

    procedure pGerarErro(strMensagem: String);

    function fInicia     : Integer;
    function fFinaliza   : Integer;
    function fFmtDecimalDaruma: Integer;

  public
    function fVerErro(blnMostraErro: Boolean = True): Boolean; Override;

    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; Override;
    function fReducaoZ(strData, strHora: String): Boolean; Override;
    function fAbreGaveta: Boolean; Override;
    function fStatusImpressora: String; Override;
    function fAbreCupom: Boolean; Override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String;
      fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;Overload; Override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad,
      strAlqIcm: String; fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;Overload; 

    function fCancelaItem(strItem: String): Boolean; Override;
    function fCancelaCupom: Boolean; Override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; Override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; Override;
    function fFechaCupom: Boolean; Override;
    function fRetornaCOO: String; Override;
    function fRetornaCooInt: AnsiString;
    function fNumeroSerie: String; Override;
    function fNumeroSerieInt: AnsiString;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; Override;
    function fAbreRelatorioGerencial(blnMostrarErro: Boolean = True): Boolean; override;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; Override;
    function fRelatorioGerencial(strTexto: String): Boolean; Override;
    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; Override;
    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; Override;
    function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; Override;
    function fUsaCNFVinculado(strTexto: String): Boolean; Override;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; Override;
    function fAbrePortaImpressora: Boolean; Override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; Override;
    procedure pFechaPortaImpressora; Override;

    procedure pPausaLeitura; Override;

    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; override;

    function fLeituraMemFiscal(strParIni,                     // PARAMETRO INICIAL
                               strParFin: String;             // PARAMETRO FINAL
                               intTipLei: Integer ): Boolean; // TIPO DE LEITURA 0/1 DATA/REDUCAO

    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; override;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; override;

    function fModeloEcf: String; override;
    function fNumeroUsuario: String; override;
    function fNumeroCCF: String; override;
    function fNumeroCCFInt: AnsiString;
    function fDataEcf: TDateTime; override;
    function fDataEcfInt: TDateTime;
    function fHoraEcf: TDateTime; override;
    function fUltimoItemVendido: String; override;
    function fNumeroGNF: String; override;
    function fNumeroGRG: String; override;
    function fNumeroCDC: String; override;
    function fDadosUltimaReducao(Var drzDadosRed: TDadosReducao): Boolean; override;
    function fVendaBruta: Double; override;
    function fNumeroCaixa: String; override;
    function fNumeroCNPJUsuario: String; override;
    function fNumeroIEUsuario: String; override;
    function fVersaoSoftwareBasico: String; override;
    function fDataGravacaoSoftwareBasico: TDateTime; override;
    function fHoraGravacaoSoftwareBasico: TDateTime; override;
    function fTipoECF: String; override;
    function fMarcaECF: String; override;
    function fGrandeTotal: Double; override;
    function fMFDAdicional: String; override;

    function fSangria(fltValor: Double): Boolean; override;
    function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; override;

    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; override;

    function fUltimoComandoComErro: Boolean; override;

    function fRetTotalImpressora(fltQtdIte, fltUnitar: Double): Double; override;

    function fRetornaObsFechamento: String; override;

    function fCadastraFormasPagamento: Boolean;
    function fLeNomesFormasPagamento: Boolean;
    function fProgramaFormaPagamento(strFormasPagto, strSeparador: String): Boolean;
    function fVerificaFormasPagamento(var strFormasPagamento: String): Boolean;
    procedure pLeNomesFormasPagamentoBanco(var arrFormasBanco: TarrFormasPagto);

    function fLerAliquotasComIndice(Var strAliquotas: String): Boolean;

    function fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String; override;

    function fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
      strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1'; strTextoLivre: String = '   '): Boolean; override;

    function fVerificaCupomAberto: Boolean; override;

    function fAcionaGuilhotina: Boolean; override;

    Constructor Create(Owner: TComponent; blnModoNovo: Boolean = True); Reintroduce;
    Destructor Destroy; override;

  published
    property strMsgErro: String Read getMensErro;
    property blnSucesso: Boolean Read getSucesso;
    property strMsgFechamento: String Read FMsgFechamento Write FMsgFechamento;
  End;

  Const
    PSZ_TIPO_DATA  = '1';
    PSZ_TIPO_COO   = '2';
    PSZ_TIPO_DATAM = '3';

  Const
    INF_GRANDE_TOTAL     = '1';
    INF_GRANDE_TOTAL_INI = '2';
    INF_COO_GNF_CCF_GRG  = '21'; // 11 X 6 (CCF POS 25-31) (GNF POS 13-19) (GRG POS 43-49)
    INF_NUMERO_COO       = '26';
    INF_CDC              = '45';
    INF_DOCUME_ATUAL     = '56'; // 0-NENHUM 1-CF 2-CNF 3-CCD 4-RG
    INF_NUMERO_ULT_ITEM  = '58';
    INF_NUMERO_SERIE     = '77';
    INF_NUMERO_FABRIC    = '78';
    INF_TIPO_ECF         = '79';
    INF_MARCA_ECF        = '80';
    INF_MODELO_ECF       = '81';
    INF_VERSAO_SB        = '83';
    INF_DATA_ATUAL_SB    = '85';
    INF_CNPJ_USUARIO     = '90';
    INF_IES_USUARIO      = '91';
    INF_NUMERO_USUARIO   = '94';
    INF_ECF              = '107';
    INF_MEIOS_FPGTO      = '126'; // 20 X 15
    INF_ULTIMA_RED_Z     = '140';
    INF_PRIMEIRO_DOCUM   = '149';

  Var
    Handle      : THandle;
    strDllDaruma: String;

    strNumeroSerie: AnsiString;
    strNumeroCcf: AnsiString;
    strNumeroCoo: AnsiString;
    dtaData: TDateTime;

    iLeituraX_ECF_Daruma: function(): Integer; StdCall;
    iReducaoZ_ECF_Daruma: function( pszData:AnsiString; pszHora:AnsiString ): Integer; StdCall;
    iMFLer_ECF_Daruma: function( pszInicial:AnsiString; pszFinal:AnsiString ): Integer; StdCall;
    eDefinirProduto_Daruma: function( szProduto: AnsiString ): Integer; StdCall;
    eInterpretarErro_ECF_Daruma: function( iIndice:Integer; pszRetorno:AnsiString ): Integer; StdCall;
    eInterpretarAviso_ECF_Daruma: function( iIndice:Integer; pszRetorno:AnsiString ): Integer; StdCall;
    iRGAbrirPadrao_ECF_Daruma: function(): Integer; StdCall;
    iRGImprimirTexto_ECF_Daruma: function( pszTexto:AnsiString ): Integer; StdCall;
    iRGFechar_ECF_Daruma: function(): Integer; StdCall;
    eAbrirGaveta_ECF_Daruma: function(): Integer; StdCall;
    rStatusImpressora_ECF_Daruma: function( pszStatus:AnsiString ): Integer; StdCall;
    eBuscarPortaVelocidade_ECF_Daruma: function(): Integer; StdCall;
    rStatusUltimoCmdInt_ECF_Daruma: function( var piErro:integer;var piAviso:integer ): Integer; StdCall;
    iCFAbrir_ECF_Daruma: function( pszCPF: AnsiString; pszNome: AnsiString; pszEndereco: AnsiString ): Integer; StdCall;

    iCFVender_ECF_Daruma: function( pszCargaTributaria : AnsiString;
                                   pszQuantidade      : AnsiString;
                                   pszPrecoUnitario   : AnsiString;
                                   pszTipoDescAcresc  : AnsiString;
                                   pszValorDescAcresc : AnsiString;
                                   pszCodigoItem      : AnsiString;
                                   pszUnidadeMedida   : AnsiString;
                                   pszDescricaoItem   : AnsiString ): Integer; StdCall;

    rInfoEstendida_ECF_Daruma: function(int:integer; char:AnsiString): Integer; StdCall;
    iCFLancarAcrescimoItem_ECF_Daruma: function(pszNumItem:AnsiString;
                                                pszTipoDescAcresc:AnsiString;
                                                pszValorDescAcresc:AnsiString): Integer; StdCall;
    iCFLancarDescontoItem_ECF_Daruma: function(pszNumItem:AnsiString;
                                               pszTipoDescAcresc:AnsiString;
                                               pszValorDescAcresc:AnsiString): Integer; StdCall;
    iCFLancarAcrescimoUltimoItem_ECF_Daruma: function(pszTipoDescAcresc:AnsiString;
                                                      pszValorDescAcresc:AnsiString): Integer; StdCall;
    iCFLancarDescontoUltimoItem_ECF_Daruma: function(pszTipoDescAcresc: AnsiString;
                                                     pszValorDescAcresc:AnsiString): Integer; StdCall;

    iCFCancelarItem_ECF_Daruma: function( pszNumItem: AnsiString ): Integer; StdCall;
    iCFTotalizarCupom_ECF_Daruma: function( pszTipoDescAcresc: AnsiString; pszValorDescAcresc: AnsiString ): Integer; StdCall;
    iCFEfetuarPagamentoFormatado_ECF_Daruma: function( pszFormaPgto: AnsiString; pszValor: AnsiString ): Integer; StdCall;
    iCFEncerrarConfigMsg_ECF_Daruma: function( pszMensagem: AnsiString ): Integer; StdCall;
    iCFCancelar_ECF_Daruma: function(): Integer; StdCall;
    rRetornarInformacao_ECF_Daruma: function( pszIndice: AnsiString; pszRetornar: AnsiString ): Integer; StdCall;
    rLerAliquotas_ECF_Daruma: function( cAliquotas:AnsiString ): Integer; StdCall;
    iCCDAbrirPadrao_ECF_Daruma: function(): Integer; StdCall;
    iCCDImprimirTexto_ECF_Daruma: function( pszTexto:AnsiString ): Integer; StdCall;
    iCCDFechar_ECF_Daruma: function(): Integer; StdCall;
    confCadastrar_ECF_Daruma: function( pszCadastrar: AnsiString; pszValor: AnsiString; pszSeparador: AnsiString ): Integer; StdCall;
    rGerarRelatorio_ECF_Daruma: function(szRelatorio:AnsiString; szTipo:AnsiString; szInicial:AnsiString; szFinal:AnsiString): Integer; StdCall;
    rGerarEspelhoMFD_ECF_Daruma: function(pszTipo:AnsiString; pszInicial:AnsiString; pszFinal:AnsiString): Integer; StdCall;
    rDataHoraImpressora_ECF_Daruma: function(pszData:AnsiString;pszHora:AnsiString): Integer; StdCall;
    iSangria_ECF_Daruma: function(pszValor:AnsiString; pszMensagem:AnsiString): Integer; StdCall;
    iSuprimento_ECF_Daruma: function(pszValor:AnsiString; pszMensagem:AnsiString): Integer; StdCall;
    regAlterarValor_Daruma: function(pszPathChave:AnsiString; pszValor:AnsiString):Integer; StdCall;
    regSintegra_ECF_Daruma: function(pszChave:AnsiString;pszValor:AnsiString):Integer; StdCall;
    iImprimirCodigoBarras_ECF_Daruma: function(pszTipo:AnsiString; pszLargura:AnsiString; pszAltura:AnsiString; pszImprTexto:AnsiString; pszCodigo:AnsiString; pszOrientacao:AnsiString; pszTextoLivre:AnsiString): Integer; StdCall;
    eAcionarGuilhotina_ECF_Daruma: function(pszTipoCorte:string): Integer; StdCall;

    confProgramarAvancoPapel_ECF_Daruma: function( pszSepEntreLinhas     : AnsiString;
                                                  pszSepEntreDoc         : AnsiString;
                                                  pszLinhasGuilhotina    : AnsiString;
                                                  pszGuilhotina          : AnsiString;
                                                  pszImpClicheAntecipada : AnsiString ): Integer; StdCall;

    rCFVerificarStatus_ECF_Daruma: function(pszStatus: AnsiString;
                                            piStatus: Integer): Integer; StdCall;


implementation

uses
  untConstantes, untFuncoesSimples, untFuncoes, DateUtils, Data.DB, untConstantesNFe;

{ TDaruma }

constructor TDaruma.Create(Owner: TComponent; blnModoNovo: Boolean = True);
begin
  FPais := fSetaPais;

  Self.blnModoNovo := blnModoNovo;

  strCpfClie := '';
  strDllDaruma := fCfgSis('DIRINI') + '\DarumaFrameWork.dll';

  If fInicia <> 0 Then
  Begin
    pGerarErro('Não foi possível carregar a biblioteca DarumaFrameWork.dll na pasta: ' + fCfgSis('DIRINI') + '\');
    Exit;
  End;

  If Not FileExists(fCfgSis('DIRINI') + '\lebin.dll') Then
  Begin
    pGerarErro('Não foi possível carregar a biblioteca lebin.dll na pasta: ' + fCfgSis('DIRINI') + '\');
    Exit;
  End;

  If Not FileExists(fCfgSis('DIRINI') + '\LeituraMFDBin.dll') Then
  Begin
    pGerarErro('Não foi possível carregar a biblioteca LeituraMFDBin.dll na pasta: ' + fCfgSis('DIRINI') + '\');
    Exit;
  End;

  SetLength(FVersaoSB, 6);
  SetLength(FNumCaixa, 3);
  SetLength(FCNPJ, 20);
  SetLength(FIE, 20);

  FDataGravacaoSB := 0;
  FHoraGravacaoSB := 0;

  strNumeroSerie := fNumeroSerieInt;

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar o Número de Série da impressora.');
    Exit;
  End;

  strNumeroCcf   := fNumeroCCFInt;

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar Contador Cupom Fiscal (CCF).');
    Exit;
  End;

  strNumeroCoo   := fRetornaCooInt;

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar Contador Ordem Operação (COO).');
    Exit;
  End;

  dtaData := fDataEcfInt;

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar a data e a hora atual da impressora.');
    Exit;
  End;

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_VERSAO_SB, FVersaoSB);

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar versão do software básico.');
    Exit;
  End;

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_CNPJ_USUARIO, FCNPJ);

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar CNPJ do usuário.');
    Exit;
  End;

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_IES_USUARIO, FIE);

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar IE do usuário.');
    Exit;
  End;

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_ECF, FNumCaixa);

  If (Not fVerErro) Then
  Begin
    pGerarErro('Erro ao capturar número do caixa.');
    Exit;
  End;

  FMsgFechamento := '';
end;

destructor TDaruma.Destroy;
begin
  fFinaliza;
  inherited;
end;

function TDaruma.fAbreCNFVinculado(strDesFormaPgto, strValor,
  strNumCupom: String; strQtdPar: String = ''): Boolean;
begin
  FCodRet := iCCDAbrirPadrao_ECF_Daruma();
  Result  := fVerErro;
end;

function TDaruma.fAbreCupom: Boolean;
begin
  FfltTotImpInt := 0;
  
  strCpfCupomFiscal    := AnsiString(strCpfClie);
  strNomeCupomFiscal   := AnsiString(Copy(strNomCli, 1, 30));
  strEndereCupomFiscal := AnsiString(Copy(strEndCli + ' ' + strBaiCli, 1, 79));

  FCodRet := iCFAbrir_ECF_Daruma(strCpfCupomFiscal, strNomeCupomFiscal, strEndereCupomFiscal);
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := True;

  strNumeroCcf := fNumeroCCFInt;
  strNumeroCoo := fRetornaCooInt;
end;

function TDaruma.fAbreGaveta: Boolean;
begin
  FCodRet := eAbrirGaveta_ECF_Daruma();
  Result  := fVerErro;
end;

function TDaruma.fAbrePortaImpressora: Boolean;
begin
  Result := True;
end;

function TDaruma.fAbreRelatorioGerencial(blnMostrarErro: Boolean): Boolean;
//  var
//    strTipDoc: String;
begin
//  strTipDoc := StringOFChar(#0, 1);

//  FCodRet := rRetornarInformacao_ECF_Daruma(INF_DOCUME_ATUAL, strTipDoc);

//  caso o RG nao esteja aberto
//  If strTipDoc <> '4' Then
//  Begin
    FCodRet := iRGAbrirPadrao_ECF_Daruma();
    Result  := fVerErro(blnMostrarErro);
//  End
//  Else
//    Result := False;
  
end;

function TDaruma.fAcionaGuilhotina: Boolean;
begin
  FCodRet := eAcionarGuilhotina_ECF_Daruma('1');
  Result := fVerErro;
end;

function TDaruma.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
begin
  FCodRet := regAlterarValor_Daruma(AnsiString('START\LocalArquivosRelatorios'), AnsiString(ExtractFilePath(strArquivoSaida)));

  Result  := fVerErro(True);

  If Result Then
  Begin
    strDataIni := FormatDateTime('ddmmyyyy', StrToDate(strDataIni));
    strDataFin := FormatDateTime('ddmmyyyy', StrToDate(strDataFin));

    FCodRet := rGerarRelatorio_ECF_Daruma('MFD', 'DATAM', AnsiString(strDataIni), AnsiString(strDataFin));
    Result  := fVerErro(True);

    If Result Then
      RenameFile(ExtractFilePath(strArquivoSaida) + '\ATO_MFD_DATA.TXT', strArquivoSaida);
  End;
end;

function TDaruma.fCalcAliquota(strCodFiscal: String; fltAliquota: Double;
  intTipRet: Integer): String;
  Var
    strAliquota: String;
    strCODSTB  : String;
    strCODISE  : String;
    strCODNIN  : String;
    strCodAlq  : String;
    fltValAlq  : Double;
    strIdeSer  : String;
    strCod018  : String;
    strCodAtu  : String;
    strPriCod  : String;
    blnPrimei  : Boolean;
    strSQL     : String;
    qryTmpEcf  : TUniQuery;
    strPatIni  : String;
    strCodEcf  : String;
begin
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  Result := '';
  strAliquota := '';

  qryTmpEcf := fCriaQuery;
  With qryTmpEcf Do
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADECF ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ECF_CODECF = :CODECF ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    Open;

    strCODSTB := FieldByName( 'ECF_CODSTB' ).AsString;
    strCODISE := FieldByName( 'ECF_CODISE' ).AsString;
    strCODNIN := FieldByName( 'ECF_CODNIN' ).AsString;

    Close;
  End;

  If Pos( strCodFiscal, CST_ISENTO ) > 0 Then
    strAliquota := 'I'

  Else If Pos( strCodFiscal, CST_NAO_TRIBUTADO ) > 0 Then
    strAliquota := 'N'

  Else If Pos( strCodFiscal, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS ) > 0 Then
    strAliquota := 'F'

  Else If Pos( strCodFiscal, '_SSS_' ) > 0 Then
    strAliquota := 'S'

  Else
  Begin

    If ( fCfgSis('SIMPAU') = 'S' ) Then
//      strAliquota := FloatToStrF( fCfgSis('ICMSIM', varDouble), ffNumber, 5, 2 )
      strAliquota := FloatToStrF(fRetornaAliquotaIcmsInternaDoEstado(fCadEmp('ESTADO')), ffNumber, 5, 2)
    Else
    Begin

      If ( strEstCli = fCadEmp('ESTADO') ) Or fEmptyStr(strIESCli) Then
        strAliquota := FloatToStrF( fltAliquota, ffNumber, 5, 2 )
      Else
      Begin

        strAliquota := FloatToStrF( 0.00, ffNumber, 5, 2 );
        If ( strEstCli = fCadEmp('ESTADO') ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 )

        Else If ( Pos( strEstCli, '_PR_RJ_MG_RS_SC_SP_' ) > 0 ) Then
          strAliquota := FloatToStrF( 12.00, ffNumber, 5, 2 )

        Else
          strAliquota := FloatToStrF( 7.00, ffNumber, 5, 2 );

        If fEmptyStr( strIESCli ) And ( Not ( strEstCli = fCadEmp('ESTADO') ) ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 );

      End;

    End;

  End;

  If ( intTipRet = 1 ) Then
  Begin

    If strAliquota = 'F' Then
      strAliquota := fPadR( strCODSTB, 2 )
    Else If strAliquota = 'I' Then
      strAliquota := fPadR( strCODISE, 2 )
    Else If strAliquota = 'N' Then
      strAliquota := fPadR( strCODNIN, 2 )
    Else
    Begin

      With qryTmpEcf Do
      Begin
        strSql := '';
        strSql := strSql + ' SELECT * ';
        strSql := strSql + ' FROM ';
        strSql := strSql + '   ECFALQ ';
        strSql := strSql + ' WHERE ';
        strSql := strSql + '   ECF_CODECF = :CODECF ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODECF').AsString := strCodEcf;
        Open;

        If IsEmpty() Then
          Exit;

        First;

        strCod018 := '';
        strCodAtu := '';
        blnPrimei := True;

        While Not Eof Do
        Begin

          If blnPrimei Then
          Begin
            strPriCod := FieldByName( 'ECF_CODALQ' ).AsString;
            blnPrimei := True;
          End;

          strCodAlq := FieldByName( 'ECF_CODALQ' ).AsString;
          fltValAlq := FieldByName( 'ECF_PERALQ' ).AsFloat;
          strIdeSer := FieldByName( 'ECF_SERVIC' ).AsString;

          If fEmptyStr( strCod018 ) Then
            If FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = FloatToStrF( 18.00, ffNumber, 5, 2 ) Then
              strCod018 := strCodAlq;

          If strAliquota = 'S' Then
          Begin
            If fEmptyStr( strCodAtu ) Then
              strCodAtu := strCodAlq;
          End
          Else
          Begin
            If Pos( strAliquota, 'FIN' ) <= 0 Then
            Begin
              If ( FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = strAliquota ) Then
              Begin
                strCodAtu := strCodAlq;
                Break;
              End;
            End;
          End;

          Next;
        End;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strCod018;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strPriCod;

        strAliquota := strCodAtu;

        Close;
      End;

    End;

  End;

  Result := AnsiReplaceStr( strAliquota, '.', ',' );
  FreeAndNil(qryTmpEcf);
end;

function TDaruma.fCancelaCupom: Boolean;
begin
  FCodRet := iCFCancelar_ECF_Daruma();
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := False;
end;

function TDaruma.fCancelaItem(strItem: String): Boolean;
begin
  FCodRet := iCFCancelarItem_ECF_Daruma( AnsiString(strItem) );
  Result  := fVerErro;
end;

function TDaruma.fDadosUltimaReducao(var drzDadosRed: TDadosReducao): Boolean;
  Const
    arrPosTotali: Array[1..13] Of Array[1..2] Of String = (
      ('I1'   , '381'),
      ('N1'   , '409'),
      ('F1'   , '353'),
      ('IS1'  , '465'),
      ('NS1'  , '493'),
      ('FS1'  , '437'),
      ('DT'   , '045'),
      ('DS'   , '059'),
      ('AT'   , '101'),
      ('AS'   , '115'),
      ('Can-T', '073'),
      ('Can-S', '087'),
      ('OPNF' , '521'));//NAO FISCAIS 20 TOTALIZADORES DE 14 POSICOES
  Var
    strDadosRed: AnsiString;
    intConta: Integer;
    intPosAlqIcm: Integer;
    intPosValIcm: Integer;

    strDtaMov: String;
    strAlqIcm: String;
    strValIcm: String;
    intTamMat: Integer;
    intContador: Integer;
    intContOPNF: Integer;
    intPosiOPNF: Integer;

begin
  intConta     := 1;
  intPosValIcm := 129;
  intPosAlqIcm := 843;

  SetLength(strDadosRed, 1164);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_ULTIMA_RED_Z, strDadosRed);
  Result := fVerErro;

  If (Not Result) Then
    Exit;

  Try

    strDtaMov := Copy(String(strDadosRed), 1, 8);
    Insert('/', strDtaMov, 3);
    Insert('/', strDtaMov, 6);

    drzDadosRed.dtaDtaMov   := StrToDate(strDtaMov);

    drzDadosRed.strNumCRO   := Copy(String(strDadosRed), 923, 04);
    drzDadosRed.strNumCrz   := Copy(String(strDadosRed), 927, 04);
    drzDadosRed.strNumCOORZ := Copy(String(strDadosRed), 935, 06);

    SetLength(drzDadosRed.arrTotali, 0);

    {*****************************************}
    {* PEGA OS DADOS DA TRIBUTAÇÃO           *}
    {**************************************MV*}
    strAlqIcm := Copy(String(strDadosRed), intPosAlqIcm, 05);
    strValIcm := Copy(String(strDadosRed), intPosValIcm, 14);

    While (strAlqIcm <> '00000') Do
    Begin

      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      drzDadosRed.arrTotali[intTamMat].strCodTot := fStrZero(intConta, 02) + 'T' + RightStr(strAlqIcm, 4);
      drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(strValIcm) / 100;

      Inc(intPosAlqIcm, 05);
      Inc(intPosValIcm, 14);
      Inc(intConta);

      strAlqIcm := Copy(String(strDadosRed), intPosAlqIcm, 05);
      strValIcm := Copy(String(strDadosRed), intPosValIcm, 14);
    End;

    For intContador := Low(arrPosTotali) To High(arrPosTotali) Do
    Begin
      intTamMat := Length(drzDadosRed.arrTotali);
      SetLength(drzDadosRed.arrTotali, intTamMat+1);

      drzDadosRed.arrTotali[intTamMat].strCodTot := arrPosTotali[intContador][1];
      drzDadosRed.arrTotali[intTamMat].fltValAcu := 0.00;

      If arrPosTotali[intContador][1] <> 'OPNF' Then
      Begin
        strValIcm := Copy(String(strDadosRed), StrToInt(arrPosTotali[intContador][2]), 14);
        drzDadosRed.arrTotali[intTamMat].fltValAcu := fStrToFloat(strValIcm) / 100;
      End
      Else
      Begin
        intPosiOPNF := StrToInt(arrPosTotali[intContador][2]);

        For intContOPNF := 1 To 20 Do
        Begin
          strValIcm := Copy(String(strDadosRed), intPosiOPNF, 14);

          drzDadosRed.arrTotali[intTamMat].fltValAcu :=
            drzDadosRed.arrTotali[intTamMat].fltValAcu + (fStrToFloat(strValIcm) / 100);

          Inc(intPosiOPNF, 14);            
        End;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDadosUltimaReducao]');
    End;
  End;

end;

function TDaruma.fDataEcf: TDateTime;
begin
  Result := dtaData;
end;

function TDaruma.fDataEcfInt: TDateTime;
  Var
    strData: String;
    strHora: String;
begin
  //strData := '          ';
  //strHora := '          ';
  SetLength(strData, 10);
  SetLength(strHora, 10);

  FCodRet := rDataHoraImpressora_ECF_Daruma(AnsiString(strData), AnsiString(strHora));
  strData := LeftStr(strData, 8);

  If (Not fEmptyStr(strData)) Then
  Begin
    Insert('/', strData, 3);
    Insert('/', strData, 6);

    Result := StrToDateDef(strData,VS_Date);
  End
  Else
    Result := VS_Date;

end;

function TDaruma.fDataGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FDataGravacaoSB;
end;

function TDaruma.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  FCodRet := confProgramarAvancoPapel_ECF_Daruma('25', AnsiString(IntToStr(intEspacos)), AnsiString(IntToStr(intEspacos)), '1', '0');
  Result  := fVerErro;
end;

function TDaruma.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean;
  var
    strTipRel: String;
    strPathGeracao: String;
begin
  strPathGeracao := ExtractFilePath(strArquivoSaida) + '\' + fNumeroSerie + '\';

  If Not DirectoryExists(ExtractFilePath(strArquivoSaida)) Then
    CreateDir(ExtractFilePath(strArquivoSaida));

  If Not DirectoryExists(strPathGeracao) Then
    CreateDir(strPathGeracao);
  
  FCodRet := regAlterarValor_Daruma(AnsiString('START\LocalArquivos'), AnsiString(strPathGeracao));
  Result  := fVerErro(True);

  If Result Then
  Begin

    If strTipoFiltro = 'D' Then
    Begin
      strTipRel    := PSZ_TIPO_DATAM;
      strFiltroIni := FormatDateTime('ddmmyy', StrToDate(strFiltroIni));
      strFiltroFin := FormatDateTime('ddmmyy', StrToDate(strFiltroFin));
    End
    Else
      strTipRel := PSZ_TIPO_COO;

    FCodRet   := rGerarEspelhoMFD_ECF_Daruma(AnsiString(strTipRel), AnsiString(strFiltroIni), AnsiString(strFiltroFin));
    Result    := fVerErro(True);

    If Result Then
      RenameFile(strPathGeracao + '\Espelho_MFD.txt', strArquivoSaida);

  End;
end;

function TDaruma.fexecutaCMD(strCmd: String;
  blnRetorna: Boolean): String;
begin
  Result := '';
end;

function TDaruma.fFechaCNFVinculado(blnVerErro: Boolean): Boolean;
begin
  FCodRet := iCCDFechar_ECF_Daruma();
  Result  := fVerErro(blnVerErro);
end;

function TDaruma.fFechaCupom: Boolean;
  Var
    strMens: String;
begin
  If fEmptyStr(FMsgFechamento) Then
    strMens := fRetornaObsFechamento
  Else
    strMens := FMsgFechamento;

  FCodRet := iCFEncerrarConfigMsg_ECF_Daruma( AnsiString(strMens) );
  Result  := fVerErro;

  If Result Then
    VS_blnCupomAberto := False;
end;

function TDaruma.fFechaRelatorioGerencial(blnVerErro: Boolean): Boolean;
//  var
//    strTipDoc: String;
begin
//  strTipDoc := StringOFChar(#0, 1);
//
//  FCodRet := rRetornarInformacao_ECF_Daruma(INF_DOCUME_ATUAL, strTipDoc);

  //caso o RG esteja aberto
//  If strTipDoc = '4' Then
//  Begin
    FCodRet := iRGFechar_ECF_Daruma();
    Result  := fVerErro(blnVerErro);
//  End
//  Else
//    Result := True;

end;

function TDaruma.fFinaliza: Integer;
begin
  Result := 0;
end;

function TDaruma.fFormatarTextoImp(strTexto: String; FonteEstilos: TFontesImpFiscal): String;
begin
  If fiNegrito In FonteEstilos Then
    strTexto := '<b>' + strTexto + '</b>';

  If fiItalico In FonteEstilos Then
    strTexto := '<i>' + strTexto + '</i>';

  If fiSublinhado In FonteEstilos Then
    strTexto := '<s>' + strTexto + '</s>';

  If fiCondensado In FonteEstilos Then
    strTexto := '<c>' + strTexto + '</c>';

  If fiExpandido In FonteEstilos Then
    strTexto := '<e>' + strTexto + '</e>';

  Result := strTexto;  
end;

function TDaruma.fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes,
  strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
  strNumCep, strFone01, strNumFax, strContat: String): Boolean;
  var
    strPriDoc: AnsiString;
    strDtaPri: String;
    strDtaIni: String;
    strDtaFin: String;

  function fRegSintegra(strNome, strValor: String): Boolean;
  begin
    Result := True;
    If Not fEmptyStr(strValor) Then
    Begin
      FCodRet := regSintegra_ECF_Daruma(AnsiString(strNome), AnsiString(strValor));
      Result  := fVerErro;
    End;
  end;

begin
  strDtaIni := '01' + FormatSettings.DateSeparator + strMes + FormatSettings.DateSeparator + strAno;
  strDtaFin := DateToStr(EndOfTheMonth( StrToDate(strDtaIni) ) );

  SetLength(strPriDoc, 22);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_PRIMEIRO_DOCUM, strPriDoc);
  Result  := fVerErro;

  If Result Then
  Begin
    strDtaPri := Copy(String(strPriDoc), 9, 8);

    strDtaPri := Copy(strDtaPri, 1, 2) + '/' +
                 Copy(strDtaPri, 3, 2) + '/' +
                 Copy(strDtaPri, 5, 4);

    If StrToDate(strDtaPri) > StrToDate(strDtaIni) Then
      strDtaIni := strDtaPri;
  End;

  strDtaIni := FormatDateTime('ddmmyyyy', StrToDate(strDtaIni));
  strDtaFin := FormatDateTime('ddmmyyyy', StrToDate(strDtaFin));

  FCodRet := regAlterarValor_Daruma(AnsiString('START\LocalArquivosRelatorios'), AnsiString(ExtractFilePath(strArquivo)));

  Result := fVerErro;

  Result  :=  Result                                      And
              fRegSintegra('Logradouro', strEndere)       And
              fRegSintegra('Numero', strNumEnd)           And
              fRegSintegra('Complemento', strComple)      And
              fRegSintegra('Bairro', strBairro)           And
              fRegSintegra('Municipio', strCidade)        And
              fRegSintegra('CEP', strNumCep)              And
              fRegSintegra('Contato_Telefone', strFone01) And
              fRegSintegra('Fax', strNumFax)              And
              fRegSintegra('Contato_Nome', strContat);

  If Result Then
  Begin
    FCodRet := rGerarRelatorio_ECF_Daruma('SINTEGRA', 'DATAM', AnsiString(strDtaIni), AnsiString(strDtaFin));
    Result  := fVerErro;

    If Result Then
      RenameFile(ExtractFilePath(strArquivo) + '\Sintegra.txt', strArquivo);
  End;

end;

function TDaruma.fGrandeTotal: Double;
  Var
    strGrandeTotal: AnsiString;
begin
  SetLength(strGrandeTotal, 18);

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_GRANDE_TOTAL, strGrandeTotal);
  Result  := 0;

  If (fVerErro) Then
    Result := fFormataFloat(fStrToFloat(String(strGrandeTotal)) / 100, 2);
end;

function TDaruma.fHoraEcf: TDateTime;
  Var
    strData: AnsiString;
    strHora: AnsiString;
begin
  strData := '';
  strHora := '';
  SetLength(strData, 8);
  SetLength(strHora, 6);

  FCodRet := rDataHoraImpressora_ECF_Daruma(AnsiString(strData), AnsiString(strHora));

  If (Not fEmptyStr(String(strData))) Then
  Begin
    Insert(':', strHora, 3);
    Insert(':', strHora, 6);

    Result := StrToTime(String(strHora));
  End
  Else
    Result := fTime();
    
end;

function TDaruma.fHoraGravacaoSoftwareBasico: TDateTime;
begin
  pCarregaDataHoraGravSB;
  Result := FHoraGravacaoSB;
end;

function TDaruma.fImpLinFiscal(strAtrib, strLinha: String): Boolean;
begin
  Result := True;
end;

function TDaruma.fImprimirCodigoBarras( cbTipo: TCodigoBarras; strCodigo, strLargura,
  strAltura: String; strOrientacao: string = 'h'; strImpTexto: String = '1';
  strTextoLivre: String = '   '): Boolean;
  var
    strTipo: String;
begin
  Case cbTipo Of
    cbEAN13: strTipo := '1';
    cbEAN39: strTipo := '6';
  End;

  If Length(strTextoLivre) = 0 Then
    strTextoLivre := '   ';

  FCodRet := iImprimirCodigoBarras_ECF_Daruma(AnsiString(strTipo), AnsiString(strLargura),
                                              AnsiString(strAltura), AnsiString(strImpTexto),
                                              AnsiString(strCodigo), AnsiString(strOrientacao),
                                              AnsiString(strTextoLivre));

  Result  := fVerErro;
end;

function TDaruma.fInicia: Integer;
begin

  Result := -999;

  If FileExists( strDllDaruma ) Then
  Begin
    Handle := LoadLibrary(PChar(strDllDaruma));

    iLeituraX_ECF_Daruma := GetProcAdDress(Handle, Pchar('iLeituraX_ECF_Daruma'));
    iReducaoZ_ECF_Daruma := GetProcAdDress(Handle, Pchar('iReducaoZ_ECF_Daruma'));
    iMFLer_ECF_Daruma := GetProcAdDress(Handle, Pchar('iMFLer_ECF_Daruma'));
    eDefinirProduto_Daruma := GetProcAdDress(Handle, Pchar('eDefinirProduto_Daruma'));
    eInterpretarErro_ECF_Daruma := GetProcAdDress(Handle, Pchar('eInterpretarErro_ECF_Daruma'));
    eInterpretarAviso_ECF_Daruma := GetProcAdDress(Handle, Pchar('eInterpretarAviso_ECF_Daruma'));
    iRGAbrirPadrao_ECF_Daruma := GetProcAdDress(Handle, Pchar('iRGAbrirPadrao_ECF_Daruma'));
    iRGImprimirTexto_ECF_Daruma := GetProcAdDress(Handle, Pchar('iRGImprimirTexto_ECF_Daruma'));
    iRGFechar_ECF_Daruma := GetProcAdDress(Handle, Pchar('iRGFechar_ECF_Daruma'));
    eAbrirGaveta_ECF_Daruma := GetProcAdDress(Handle, Pchar('eAbrirGaveta_ECF_Daruma'));
    rStatusImpressora_ECF_Daruma := GetProcAdDress(Handle, Pchar('rStatusImpressora_ECF_Daruma'));
    eBuscarPortaVelocidade_ECF_Daruma := GetProcAdDress(Handle, Pchar('eBuscarPortaVelocidade_ECF_Daruma'));
    rStatusUltimoCmdInt_ECF_Daruma := GetProcAdDress(Handle, Pchar('rStatusUltimoCmdInt_ECF_Daruma'));
    iCFAbrir_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFAbrir_ECF_Daruma'));
    iCFVender_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFVender_ECF_Daruma'));
    rInfoEstendida_ECF_Daruma := GetProcAdDress(Handle, Pchar('rInfoEstendida_ECF_Daruma'));
    iCFLancarAcrescimoItem_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFLancarAcrescimoItem_ECF_Daruma'));
    iCFLancarDescontoItem_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFLancarDescontoItem_ECF_Daruma'));
    iCFLancarAcrescimoUltimoItem_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFLancarAcrescimoUltimoItem_ECF_Daruma'));
    iCFLancarDescontoUltimoItem_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFLancarDescontoUltimoItem_ECF_Daruma'));
    iCFCancelarItem_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFCancelarItem_ECF_Daruma'));
    iCFTotalizarCupom_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFTotalizarCupom_ECF_Daruma'));
    iCFEfetuarPagamentoFormatado_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFEfetuarPagamentoFormatado_ECF_Daruma'));
    iCFEncerrarConfigMsg_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFEncerrarConfigMsg_ECF_Daruma'));
    iCFCancelar_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCFCancelar_ECF_Daruma'));
    rRetornarInformacao_ECF_Daruma := GetProcAdDress(Handle, Pchar('rRetornarInformacao_ECF_Daruma'));
    rLerAliquotas_ECF_Daruma := GetProcAdDress(Handle, Pchar('rLerAliquotas_ECF_Daruma'));
    iCCDAbrirPadrao_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCCDAbrirPadrao_ECF_Daruma'));
    iCCDImprimirTexto_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCCDImprimirTexto_ECF_Daruma'));
    iCCDFechar_ECF_Daruma := GetProcAdDress(Handle, Pchar('iCCDFechar_ECF_Daruma'));
    confCadastrar_ECF_Daruma := GetProcAdDress(Handle, Pchar('confCadastrar_ECF_Daruma'));
    rGerarRelatorio_ECF_Daruma := GetProcAdDress(Handle, Pchar('rGerarRelatorio_ECF_Daruma'));
    rGerarEspelhoMFD_ECF_Daruma := GetProcAdDress(Handle, Pchar('rGerarEspelhoMFD_ECF_Daruma'));
    rDataHoraImpressora_ECF_Daruma := GetProcAdDress(Handle, Pchar('rDataHoraImpressora_ECF_Daruma'));
    iSangria_ECF_Daruma := GetProcAdDress(Handle, Pchar('iSangria_ECF_Daruma'));
    iSuprimento_ECF_Daruma := GetProcAdDress(Handle, Pchar('iSuprimento_ECF_Daruma'));
    regAlterarValor_Daruma := GetProcAdDress(Handle, Pchar('regAlterarValor_Daruma'));
    regSintegra_ECF_Daruma := GetProcAdDress(Handle, Pchar('regSintegra_ECF_Daruma'));
    iImprimirCodigoBarras_ECF_Daruma := GetProcAdDress(Handle, Pchar('iImprimirCodigoBarras_ECF_Daruma'));
    confProgramarAvancoPapel_ECF_Daruma := GetProcAdDress(Handle, Pchar('confProgramarAvancoPapel_ECF_Daruma'));
    rCFVerificarStatus_ECF_Daruma := GetProcAdDress(Handle, Pchar('rCFVerificarStatus_ECF_Daruma'));
    eAcionarGuilhotina_ECF_Daruma := GetProcAdDress(Handle, Pchar('eAcionarGuilhotina_ECF_Daruma'));

    Result := 0;
  End;

end;

function TDaruma.fLeituraMemFiscal(strParIni, strParFin: String;
  intTipLei: Integer): Boolean;
begin
  If intTipLei = 0 Then
  Begin
    strParIni := FormatDateTime('ddmmyy', StrToDate(strParIni));
    strParFin := FormatDateTime('ddmmyy', StrToDate(strParFin));
  End;

  Result := fLeituraMemoriaFiscal(True, '', strParIni, strParFin);
end;

function TDaruma.fLeituraMemoriaFiscal(blnCompleta: Boolean;
  strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean;
begin
  FCodRet := regAlterarValor_Daruma('ECF\LMFCompleta', AnsiString(IIF(blnCompleta, '1', '0')));
  Result := fVerErro(True);

  If Result Then
  Begin
    FCodRet := iMFLer_ECF_Daruma( AnsiString( strFiltroIni ), AnsiString( strFiltroFin));
    Result  := fVerErro(True);
  End;
end;

function TDaruma.fLeituraX(strParam: String;
  blnPergunta: Boolean): Boolean;
begin
  FCodRet := iLeituraX_ECF_Daruma();
  Result  := fVerErro;
end;

function TDaruma.fMarcaECF: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 20);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_MARCA_ECF, strResult);
  Result  := Trim(String(strResult));
end;

function TDaruma.fMFDAdicional: String;
begin
  Result := '';
end;

function TDaruma.fModeloEcf: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 20);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_MODELO_ECF, strResult);
  Result  := Trim(String(strResult));
end;

function TDaruma.fNumeroCaixa: String;
begin
  Result := String(FNumCaixa);
end;

function TDaruma.fNumeroCCF: String;
begin
  Result := String(strNumeroCcf);
end;

function TDaruma.fNumeroCCFInt: AnsiString;
begin
  SetLength(Result, 66); // 11 X 6

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_COO_GNF_CCF_GRG, Result);

  If fVerErro(True) Then
    Result := Copy(Result, 25, 6);
end;

function TDaruma.fNumeroCDC: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 4);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_CDC, strResult);
  Result := String(strResult);
end;

function TDaruma.fNumeroCNPJUsuario: String;
begin
  Result := String(FCNPJ);
end;

function TDaruma.fNumeroGNF: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 66); // 11 X 6

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_COO_GNF_CCF_GRG, strResult);

  If fVerErro(True) Then
    Result := Copy(String(strResult), 13, 6);
end;

function TDaruma.fNumeroGRG: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 66); //11 X 6

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_COO_GNF_CCF_GRG, strResult);

  If fVerErro(True) Then
    Result := Copy(String(strResult), 43, 6);
end;

function TDaruma.fNumeroIEUsuario: String;
begin
  Result := String(FIE);
end;

function TDaruma.fNumeroSerie: String;
begin
  Result := LeftStr(String(strNumeroSerie), 20);
end;

function TDaruma.fNumeroSerieInt: AnsiString;
begin
  SetLength(Result, 21);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_NUMERO_FABRIC, Result);
  Result  := LeftStr(Result, 20);
end;

function TDaruma.fNumeroUsuario: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 2);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_NUMERO_USUARIO, strResult);
  Result := String(strResult);
end;

function TDaruma.fReducaoZ(strData, strHora: String): Boolean;
begin
  If fEmptyStr(strData) Then
    strData := ' ';

  If fEmptyStr(strHora) Then
    strHora := ' ';

  FCodRet := iReducaoZ_ECF_Daruma(AnsiString(strData), AnsiString(strHora));
  Result  := fVerErro;
end;

function TDaruma.fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String;
  fltTotal, fltTotImp: Double): Boolean;
  Var
    fltValDes: Double;
    strDesEsp: String;
    fltTotImpTmp: Double;
begin
  strAcrDes := 'D';
  fltValDes := 0;

  If FfltTotImpInt > 0 Then
    fltTotImpTmp := FfltTotImpInt
  Else
    fltTotImpTmp := fltTotImp;

  If fFormataFloat( fltTotImpTmp, 2 ) > fFormataFloat( fltTotal, 2 ) Then
  Begin
    strAcrDes := 'D';
    fltValDes := fltTotImpTmp - fltTotal;
  End
  Else If fFormataFloat( fltTotImpTmp, 2 ) < fFormataFloat( fltTotal, 2 ) Then
  Begin
    strAcrDes := 'A';
    fltValDes := fltTotal - fltTotImpTmp;
  End;

  strDesEsp := FloatToStrF( fltValDes, ffNumber, 14, 2 );
  strDesEsp := AnsiReplaceStr( strDesEsp, '.', '' );
  strDesEsp := AnsiReplaceStr( strDesEsp, ',', '' );
  strDesEsp := fPadL(strDesEsp, 14, '0');

  strAcrDes := strAcrDes + strTip_AC;

  FCodRet := iCFTotalizarCupom_ECF_Daruma(AnsiString(strAcrDes), AnsiString(strDesEsp));

  Result  := fVerErro;
end;

function TDaruma.fRegistraItem(strCodIte, strDesIte, strUnidad: String;
  fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strAlqIcm: String;
begin
  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm, 1);

  Result := fRegistraItem(strCodIte,
                          strDesIte,
                          strUnidad,
                          strAlqIcm,
                          fltQtdIte,
                          fltUnitar,
                          strCodFis,
                          fltDesEsp,
                          fltTotal);
end;

function TDaruma.fRegistraItem(strCodIte, strDesIte, strUnidad, strAlqIcm: String;
  fltQtdIte, fltUnitar: Double; strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    strQuanti: String;
    strUnitar: String;
    strDesAcr: String;
    strTipDesAcr: String;
    strRetValItem: AnsiString;
    fltValIteImp,
    fltValIteSis: Double;
begin
  fltValIteImp := 0.0;
  strQuanti    := FloatToStrF( fltQtdIte, ffNumber, 7, 3 );
  strUnitar := FloatToStrF( fltUnitar, ffNumber, 8, fFmtDecimalDaruma );

  pCalculaAcrDesItem(Self, fStrToFloat(strQuanti), fStrToFloat(strUnitar),
    fltQtdIte, fltUnitar, fltDesEsp, fltUltDesEspIte, fltUltAcrescIte);

  {*******************************************************************************************}
  {* (*) SE A CONFIGURAÇÂO CFG_MDADCF FOR IGUAL 1, O DESCONTO/ACRESIMO TEM QUE SER ZERO,     *}
  {* POIS IRÁ CALCLAR O MESMO LOGO ABAIXO. SE FOR IGUAL A 2, SEMPRE VEM ZERADO, POIS O MESMO *}
  {* É DADO NO FINAL DO CUPOM FISCAL                                                         *}
  {* CFG_MDADCF = 1 (DESCONTO ITEM A ITEM)                                                   *}
  {* CFG_MDADCF = 2 (DESCONTO FINAL DO CUPOM)                                                *}
  {****************************************************************************************FC*}
  If (fCfgSis('MDADCF') = '1') Then
  Begin
    strDesAcr    := '0,00';
    strTipDesACr := 'D$';
  End
  Else If fltUltDesEspIte > 0 Then
  Begin
    strDesAcr := FloatToStrF(fltUltDesEspIte, ffNumber, 8, 2 );
    strTipDesACr := 'D$';
  End
  Else
  Begin
    strDesAcr := FloatToStrF(fltUltAcrescIte, ffNumber, 8, 2 );
    strTipDesACr := 'A$';
  End;

  FCodRet := iCFVender_ECF_Daruma(AnsiString(strAlqIcm),
                                  AnsiString(strQuanti),
                                  AnsiString(strUnitar),
                                  AnsiString(strTipDesACr),
                                  AnsiString(strDesAcr), //(*)
                                  AnsiString(strCodIte),
                                  AnsiString(strUnidad),
                                  AnsiString(Trim(strDesIte)));
  Result  := fVerErro;

  If Result Then
  Begin
    fltValIteImp := fFormataFloat(fltQtdIte * fltUnitar, 2);
    strRetValItem := AnsiString(StringOfChar(#0, 30));

    if (fltValIteImp < 1000) then
    begin
      FCodRet := rInfoEstendida_ECF_Daruma(3, strRetValItem);
      Result  := fVerErro;
      strRetValItem := AnsiString(Trim(String(strRetValItem)));

      If Not fEmptyStr(fRetSomenteNumeros(String(strRetValItem))) Then
        fltValIteImp := fStrToFloat(LeftStr(String(strRetValItem), Length(String(strRetValItem))-2) + ',' + RightStr(String(strRetValItem), 2));
    end;
  End;

  If Result And (fCfgSis('MDADCF') = '1') Then
  Begin
    If Result Then
    Begin
      If (fltTotal <> 0) Then
        fltValIteSis := fltTotal
      Else
        fltValIteSis := (fFormataFloat(fltQtdIte * fltUnitar, 2)) - fltDesEsp;
        
      If fFormataFloat(fltValIteSis, 2) <> fFormataFloat(fltValIteImp, 2) Then
      Begin
        If fFormataFloat(fltValIteSis, 2) > fFormataFloat(fltValIteImp, 2) Then
        Begin
          strRetValItem := AnsiString(FloatToStrF(fltValIteSis - fltValIteImp, ffNumber, 12, 2));
          iCFLancarAcrescimoUltimoItem_ECF_Daruma('A$', strRetValItem);
        End
        Else
        Begin
          strRetValItem := AnsiString(FloatToStrF(fltValIteImp - fltValIteSis, ffNumber, 12, 2));
          iCFLancarDescontoUltimoItem_ECF_Daruma('D$', strRetValItem);
        End;

        Result  := fVerErro;
      End;
    End;
  End
  Else If Result And (fCfgSis('MDADCF') = '2') Then
    FfltTotImpInt := FfltTotImpInt + fltValIteImp;

  If fIsNumber(strAlqIcm) Then
    strUltIndiceTri := strAlqIcm
  Else
    strUltIndiceTri := LeftStr(strAlqIcm, 1);
end;

function TDaruma.fFmtDecimalDaruma: Integer;
  var intDec: Integer;
begin
  intDec := fCfgSis('DECUNI', varInteger);
  If intDec > 3 Then
    intDec := 3
  Else If intDec < 2 Then
    intDec := 2;
  Result := intDec;
end;

function TDaruma.fRegistraModalidades(strCodMod, strDesMod: String;
  fltValMod: Double; strInfAdi: String): Boolean;
  Var
    strValor: String;
begin
  strValor := FloatToStrF(fltValMod, ffFixed, 11,2);
  strValor := AnsiReplaceStr(strValor, '.', '');

  FCodRet := iCFEfetuarPagamentoFormatado_ECF_Daruma(AnsiString(strDesMod), AnsiString(strValor));
  Result  := fVerErro;
end;

function TDaruma.fRelatorioGerencial(strTexto: String): Boolean;
begin
  FCodRet := iRGImprimirTexto_ECF_Daruma(AnsiString(strTexto) );
  Result  := fVerErro;
end;

function TDaruma.getMensErro: String;
begin
  Result := FMsgRet_ + FMsgErro + FMsgAvis;
end;

function TDaruma.fRetornaCoo: String;
begin
  Result  := String(fRetornaCooInt);
end;

function TDaruma.fRetornaCooInt: AnsiString;
begin
  SetLength(Result,6);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_NUMERO_COO, Result);
end;


function TDaruma.fRetornaObsFechamento: String;
  Var
    strCupMan,
    strMinLeg,
    strImpPag: string;
    blnImpPag: Boolean;
    intLinMsg : Integer;
    intQtdNps : Integer;

  procedure pAddMensagem(strValue: String);
  begin
    If (Not fEmptyStr(strValue)) Then
    Begin
      Result := Result + strValue;
      intLinMsg := intLinMsg + 1;
    End;
  end;

  function fTemLinhaDisponivel: Boolean;
  begin
    Result := (intLinMsg < fCfgSis('QMXMCU', varInteger));
  end;

begin
  Result := '';
  strCupMan := '';
  strMinLeg := '';
  intLinMsg := 0;

  strCgcCpf := fFormataCpfCgc(strCgcCpf, FPais);
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

  If (VS_strUsaPaf = 'S') And Not fEmptyStr(strMenPaf01) Then
    pAddMensagem(fPadR(strMenPaf01, 48));

  If (VS_strUsaPaf = 'S') And Not fEmptyStr(strMenPaf02) Then
    pAddMensagem(fPadR(strMenPaf02, 48));

  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));

  If blnImpPag Then
  Begin
    If Not fUsaImpostoFonteIBPT Then
    Begin
      If fltImpPag < 1000 Then
        pAddMensagem(fPadR('Vlr Aprox do Tributo "R$' + FormatFloat('#,##0.00', fltImpPag) +
                           '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48))
      Else
        pAddMensagem(fPadR('Vlr Apr Tributos "R$' + FormatFloat('#,##0.00', fltImpPag) +
                           '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 48));
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
      strImpPag := Copy(fPadR(strImpPag, 48), 1, 48);
      pAddMensagem(strImpPag);
    End;
  End;

  If VS_strUsaPaf = 'S' Then
  Begin
    pAddMensagem(fPadR(fRetDocMaisTelParaIF(strNumDoc, strTelCli, 48), 48));

    If Not blnImpPag Then
      pAddMensagem(fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48));

    If fEmptyStr(strMenPaf02) Then
      pAddMensagem(fPadR(strEndCli + ' - ' + strBaiCli, 48));
  End
  Else
  Begin
    pAddMensagem(fPadR(fRetDocMaisTelParaIF(strNumDoc, strTelCli, 48), 48));
    pAddMensagem(fPadR(LeftStr(strNomCli, 39) + '-' + strCodCli, 48));
    pAddMensagem(fPadR(strEndCli + ' - ' + strBaiCli, 48));

    If Not blnImpPag Then
      pAddMensagem(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 48));
  End;

  If fCfgSis('ORGDFI', varBoolean) Then
    pAddMensagem(fPadR( 'PROCON-'+fCadEmp('ESTADO')+': ' + fCfgSis('ENDPRC') + ' TEL: ' + fCfgSis('TELPRC') , 48))

  Else If fCfgSis('SIMNAC', varBoolean) Then
    pAddMensagem(fPadR( 'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC', 48));

  If fCfgSis('ORGDFI', varBoolean) And (Not fEmptyStr(fCfgSis('ENDALE'))) Then
    pAddMensagem(fPadR( 'ALERJ: ' + fCfgSis('ENDALE') + ' TEL: ' + fCfgSis('TELALE') , 48));

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
  Begin
    strMinLeg := fPadR( 'MINAS LEGAL:' + Trim(fTiraCaracEspeciais(fNumeroCNPJUsuario, True, True, True)) + ' ' +
                        FormatDateTime('ddmmyyyy', fDataEcfInt) +
                        fPadL(AnsiReplaceStr(FloatToStrF(fltTotSis, ffNumber, 12, 2), '.', ''), 8, ' '), 48);

    pAddMensagem(strMinLeg);
  End
  Else
  If fCfgSis('CUPMAN', varBoolean) Then
  Begin
    strCupMan := fPadR( 'CUPOM MANIA, CONCORRA A PRÊMIOS VEND:' + strNomVen, 48);
    strCupMan := strCupMan + fPadR( 'ENVIE SMS P/ 6789:' + Trim(fTiraCaracEspeciais(fNumeroIEUsuario, True, True)) +
                                    FormatDateTime('ddmmyyyy', fDataEcfInt) +
                                    fRetornaCOO +
                                    RightStr(fNumeroCaixa, 3), 48);
    pAddMensagem(strCupMan);
  End;

  If(fEmptyStr(strMinLeg) And fEmptyStr(strCupMan)) Then
  Begin
    pAddMensagem(fPadR('Vendedor: ' + strNomVen, 48));
  End;

  If (fTemLinhaDisponivel) And
     (fCfgSis('UTINPS', varBoolean)) And
     (fGanhouNetpoints(strNumDoc,
                       'IF',
                       VS_strCodEmp,
                       strCodCli,
                       fSerieIF,
                       intQtdNps)) Then
  Begin
    pAddMensagem(Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]));
  End;
end;


function TDaruma.fRetTotalImpressora(fltQtdIte,
  fltUnitar: Double): Double;
begin
  fltQtdIte := fFormataFloat(fltQtdIte, 3);
  fltUnitar := fFormataFloat(fltUnitar, fFmtDecimalDaruma);
  Result    := fFormataFloat(fltQtdIte * fltUnitar, 2);
end;

function TDaruma.fSangria(fltValor: Double): Boolean;
  Var
    strValor: AnsiString;
begin
  strValor := AnsiString(FloatToStrF(fltValor, ffNumber, 12, 2));
  FCodRet  := iSangria_ECF_Daruma(strValor, '');
  Result   := fVerErro;
end;

function TDaruma.fStatusImpressora: String;
  Var
    strStatusEcf: AnsiString;
begin
  SetLength(strStatusEcf,14);

  FCodRet := rStatusImpressora_ECF_Daruma(strStatusEcf);

  If FCodRet <> 1 Then
  Begin
    FCodRet:= eBuscarPortaVelocidade_ECF_Daruma();

    If FCodRet = 1 Then
      regAlterarValor_Daruma('ECF\RetornarAvisoErro', '1');
  End;

  Result  := IntToStr(FCodRet);
end;

function TDaruma.fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean;
  Var
    strValor: AnsiString;
begin
  strValor := AnsiString(FloatToStrF(fltValor, ffNumber, 12, 2));
  FCodRet  := iSuprimento_ECF_Daruma(strValor, AnsiString(strModalidade));
  Result   := fVerErro;
end;

function TDaruma.fTipoECF: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 07);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_TIPO_ECF, strResult);
  Result  := Trim(String(strResult));
end;

function TDaruma.fUltimoComandoComErro: Boolean;
begin
  Result := blnUltComandoErro;
end;

function TDaruma.fUltimoItemVendido: String;
  Var
    strResult: AnsiString;
begin
  SetLength(strResult, 3);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_NUMERO_ULT_ITEM, strResult);
  Result := String(strResult);
end;

function TDaruma.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  FCodRet := iCCDImprimirTexto_ECF_Daruma( AnsiString(strTexto) );
  Result  := fVerErro;
end;

function TDaruma.fVendaBruta: Double;
  Var
    strGrandeTotalInicial: AnsiString;
begin
  SetLength(strGrandeTotalInicial, 18);

  FCodRet := rRetornarInformacao_ECF_Daruma(INF_GRANDE_TOTAL_INI, strGrandeTotalInicial);
  Result  := 0;

  If (fVerErro) Then
  Begin
    Result := fGrandeTotal - fFormataFloat(fStrToFloat(String(strGrandeTotalInicial)) / 100, 2);
  End;

end;

function TDaruma.fVerErro(blnMostraErro: Boolean): Boolean;
  Var
    strMsgErroRet: AnsiString;
    strMsgAvisRet: AnsiString;
begin
  If Not blnModoNovo Then
    blnMostraErro := False;

  FNumErro := 0;
  FNumAvis := 0;
  SetLength(strMsgErroRet, 200);
  SetLength(strMsgAvisRet, 200);

  If FCodRet <> 0 Then
  Begin

    rStatusUltimoCmdInt_ECF_Daruma(FNumErro, FNumAvis);

    Case FCodRet Of
         0: FMsgRet_ := 'Erro durante a execução';
         1: FMsgRet_ := 'Operação realizada com sucesso';
        -1: FMsgRet_ := 'Erro do Método';
         2: FMsgRet_ := 'Parâmetro incorreto';
        -3: FMsgRet_ := 'Alíquota (Situação tributária) não programada';
        -4: FMsgRet_ := 'Chave do Registry não encontrada';
        -5: FMsgRet_ := 'Erro ao Abrir a porta de Comunicação';
        -6: FMsgRet_ := 'Impressora Desligada';
        -7: FMsgRet_ := 'Erro no Número do Banco';
        -8: FMsgRet_ := 'Erro ao Gravar as informações no arquivo de Status ou de Retorno de Info';
        -9: FMsgRet_ := 'Erro ao Fechar a porta de Comunicação';
       -10: FMsgRet_ := 'Se o ECF não tem forma de pagamento e não permite cadastrar esta forma';
       -12: FMsgRet_ := 'A função executou o comando porém o ECF sinalizou Erro.';
       -24: FMsgRet_ := 'Forma de Pagamento não Programada';
       -25: FMsgRet_ := 'Totalizador nao ECF Não Vinculado nao Programado';
       -27: FMsgRet_ := 'Foi Detectado Erro ou Warning na Impressora';
       -28: FMsgRet_ := 'Time-Out';
       -40: FMsgRet_ := 'Tag XML Inválida';
       -50: FMsgRet_ := 'Problemas ao Criar Chave no Registry';
       -51: FMsgRet_ := 'Erro ao Gravar LOG';
       -52: FMsgRet_ := 'Erro ao abrir arquivo';
       -53: FMsgRet_ := 'Fim de arquivo';
       -60: FMsgRet_ := 'Erro na tag de formatacao DHTML';
       -90: FMsgRet_ := 'Erro Configurar a Porta de Comunicação';
       -99: FMsgRet_ := 'Parâmetro inválido ou ponteiro nulo de parâmetro';
      -101: FMsgRet_ := 'Erro ao LER ou ESCREVER arquivo';
      -102: FMsgRet_ := 'Erro ao LER ou ESCREVER arquivo';
      -103: FMsgRet_ :=	'Não foram encontradas as DLLs auxiliares (lebin.dll e LeituraMFDBin.dll)';
      -104: FMsgRet_ := 'Data informada é inferior ao primeiro documento emitido';
      -105: FMsgRet_ := 'Data informada é maior que a ultima redução Z impressa';
      -106: FMsgRet_ := 'Não há movimento no período informado';
      Else  FMsgRet_ := 'Retorno desconhecido...';
    End;

  End;

  If FNumErro = 0 Then
    FMsgErro := ''
  Else
  Begin
    eInterpretarErro_ECF_Daruma(FNumErro, strMsgErroRet);
    FMsgErro := String(strMsgErroRet);
  End;

  If FNumAvis = 0 Then
    FMsgAvis := ''
  Else
  Begin
    eInterpretarAviso_ECF_Daruma(FNumAvis, strMsgAvisRet);
    FMsgAvis := String(strMsgAvisRet);
  End;

  If FCodRet = 1 Then
    FMsgRet_ := '';

  If Not fEmptyStr(FMsgRet_) Then
    FMsgRet_ := '[' + IntToStr(FCodRet) + '] - ' + Trim(FMsgRet_) + #13#10;

  If Not fEmptyStr(FMsgErro) Then
    FMsgErro := '[' + IntToStr(FNumErro) + '] - ' + Trim(FMsgErro) + #13#10;

  If Not fEmptyStr(FMsgAvis) Then
    FMsgAvis := '[' + IntToStr(FNumAvis) + '] - ' + Trim(FMsgAvis) + #13#10;

  Result := True;

  {***********************************************************************}
  {* VOLTEI ESSA VERIFICAÇÃO, POIS NÃO ERA NECESSÁRIA. O PROBLEMA É QUE  *}
  {* HAVIA SIDO REMOVIDO A FUNÇÃO QUE VERIFICA SE TEM ERRO NOS COMANDOS. *}
  {********************************************************************MV*}
  If (Not fEmptyStr(FMsgErro)) Or (FCodRet < 1) Then
  Begin
    If FNumErro > 0 Then
    Begin
      Result := False;
    End;
  End;

  If (Not result) And blnMostraErro Then
  Begin
//    BlockInput(False);
    fMensagem('', getMensErro, ['&Ok']);
//    BlockInput(FTravado);
  End;

end;

function TDaruma.fVersaoSoftwareBasico: String;
begin
  Result := String(FVersaoSB);
end;

function TDaruma.getSucesso: Boolean;
begin
  Result := (FCodRet = 1);
end;

procedure TDaruma.pCarregaDataHoraGravSB;
  Var
    strDtaAtuSb: AnsiString;
begin
  If (FDataGravacaoSB = 0) Then
  Begin
    SetLength(strDtaAtuSb, 14);

    FCodRet := rRetornarInformacao_ECF_Daruma(INF_DATA_ATUAL_SB, strDtaAtuSb);

    If (Not fVerErro) Then
      Raise Exception.Create('Erro ao capturar hora da gravação do software básico.');

    FDataGravacaoSB := StrToDate(Copy(String(strDtaAtuSb),01,2) + '/' + Copy(String(strDtaAtuSb),03,2) + '/' + Copy(String(strDtaAtuSb),05,4));
    FHoraGravacaoSB := StrToTime(Copy(String(strDtaAtuSb),09,2) + ':' + Copy(String(strDtaAtuSb),11,2) + ':' + Copy(String(strDtaAtuSb),13,2));
  End;
end;

procedure TDaruma.pFechaPortaImpressora;
begin
  inherited;
end;

procedure TDaruma.pGerarErro(strMensagem: String);
begin
  If blnModoNovo Then
    Raise ExceptionAutCom.Create(strMensagem)
  Else
  Begin
    FCodRet  := 0;
    FMsgAvis := strMensagem;
  End;
end;

procedure TDaruma.pPausaLeitura;
begin
  inherited;       
end;

function TDaruma.fCadastraFormasPagamento: Boolean;
  Const
    SEPARADOR = '|';
  Var
    arrFormasBanco: TarrFormasPagto;
    strFormasPagto: String;
    intBanco, intImp: integer;
    blnAchou: boolean;
Begin
  result := fLeNomesFormasPagamento;

  pLeNomesFormasPagamentoBanco(arrFormasBanco);

  strFormasPagto := '';

  For intBanco := Low(arrFormasBanco) To High(arrFormasBanco) Do
  Begin
    blnAchou := false;
    For intImp := Low(arrNomesFormasPagto) To High(arrNomesFormasPagto) Do
       If SameText(UpperCase(Trim(String(arrFormasBanco[intBanco]))),UpperCase(Trim(String(arrNomesFormasPagto[intImp])))) Then
       Begin
         blnAchou := True;
         Break;
       End;

    If Not blnAchou Then
      strFormasPagto := strFormasPagto + String(arrFormasBanco[intBanco]) + SEPARADOR;
  End;

  strFormasPagto := LeftStr(strFormasPagto, Length(strFormasPagto) -1);

  If Not fEmptyStr(strFormasPagto) Then
    result := fProgramaFormaPagamento(strFormasPagto, SEPARADOR);

  SetLength(arrFormasBanco,0);
  SetLength(arrNomesFormasPagto,0);
End;

function TDaruma.fLeNomesFormasPagamento: Boolean;
  Var
    strNome, strFormasPagamento: String;
    intContador: Integer;
Begin
  Result := fVerificaFormasPagamento(strFormasPagamento);

  if Result Then
  Begin
    SetLength(arrNomesFormasPagto,0);

    For intContador := 1 To 20 Do
    Begin
      strNome := Trim(Copy(strFormasPagamento, 1, 15));

      If strNome <> '' Then
      Begin
        Setlength(arrNomesFormasPagto,Succ(Length(arrNomesFormasPagto)));
        arrNomesFormasPagto[High(arrNomesFormasPagto)] := ShortString(strNome);
      End;

      Delete(strFormasPagamento, 1, 15);
    End;

  End;
End;

procedure TDaruma.pLeNomesFormasPagamentoBanco(Var arrFormasBanco: TarrFormasPagto);
  Var
    strSQL: String;
    qryGen: TUniQuery;
    strPatIni: String;
Begin
  SetLength(arrFormasBanco,0);

  qryGen := fCriaQuery;

  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '   * ';
  strSql := strSql + ' FROM ';
  strSql := strSql + '   ECFMOD ';
  strSql := strSql + ' WHERE ';
  strSql := strSql + '   ECF_CODECF = :CODECF ';


  With qryGen Do
  Begin

    Close;
    Sql.Clear;
    Sql.Add(strSql);
    strPatIni := fCfgSis('DIRINI');
    ParamByName('CODECF').AsString := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA', '', strPatIni + '/opcoes_fiscal.ini' );

    Open;

    First;
    while Not Eof Do
    Begin
      Setlength(arrFormasBanco,Succ(Length(arrFormasBanco)));
      arrFormasBanco[High(arrFormasBanco)] := ShortString(FieldByName('ECF_DESMOD').AsString);
      Next;
    End;

    Close;

  End;
  FreeAndNil(qryGen);

End;

function TDaruma.fProgramaFormaPagamento(strFormasPagto, strSeparador: String) : Boolean;
Begin
  FCodRet := confCadastrar_ECF_Daruma('FGTO', AnsiString(strFormasPagto), AnsiString(strSeparador));
  Result  := fVerErro;
End;

function TDaruma.fVerificaCupomAberto: Boolean; 
var strStatus: AnsiString;
    intStatus: Integer;
begin
  intStatus := 0;
  
  SetLength(strStatus, 2);
  rCFVerificarStatus_ECF_Daruma(strStatus, intStatus);
  If intStatus > 0 Then
    Result:=True
  Else
    Result:=False;
end;

function TDaruma.fVerificaFormasPagamento(var strFormasPagamento: String) : Boolean;
  Var
    strResult: AnsiString;
Begin
  SetLength(strResult, 300);
  FCodRet := rRetornarInformacao_ECF_Daruma(INF_MEIOS_FPGTO, strResult);

  strFormasPagamento := String(strResult);
  Result  := fVerErro;
end;

function TDaruma.fLerAliquotasComIndice(Var strAliquotas: String): Boolean;
begin
  SetLength (strAliquotas, 150);
  FCodRet := rLerAliquotas_ECF_Daruma(AnsiString(strAliquotas));
  Result  := fVerErro;
end;

end.                      
