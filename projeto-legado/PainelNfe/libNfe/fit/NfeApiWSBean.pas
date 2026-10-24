unit NfeApiWSBean;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  ShellApi, Windows, Printers, Dialogs, Messages, Forms, ActiveX,
{$ENDIF}
{$IF RTLVersion >= 28}
  NetEncoding,
{$IFEND}
  Types, SOAPHTTPTrans, IdSSLOpenSSLHeaders,
  EncdDecd, Classes,
  DateUtils, OPToSOAPDomConv, StrUtils, XMLDoc, XMLIntf, untInterfaces,
  untInterfacesManifestoEletronico, untHttpTypes, untConstantesNFe;

Const
  FIT_COMANDO_ENVIO = 'FIT_NFE_ENVIA_TEXTO_INTEGRACAO_';
  FIT_COMANDO_CONS_SIT = 'FIT_NFE_CONSULTA_ID_NOTA_FISCAL';
  FIT_COMANDO_ENVIO_CTE = 'FIT_CTE_ENVIA_TEXTO_INTEGRACAO_';
  FIT_SERVICO_WS_NFEENVIARECEBEDADOS = 'NfeEnviaRecebeDados';
  FIT_SERVICO_WS_NFERECEBEDANFE = 'NfeRecebeDanfe';

type

  TAfterExecute = function(SOAPResponse: WideString): WideString of object;

  TNfeApiWS = class
    private
      fOnAfterExecute: TAfterExecute;
      FstrUrl: String;
      FstrNms: String;
      FmodeEnvSoap: TmodeEnvSoap;
      function fMontaRetornaEnvelope(const servico, nr_licenca: WideString; const nm_usuario: WideString; const nm_senha: WideString; const nm_servico: WideString; const dados: WideString): WideString;
      function fDecodeBase64ToByteDynArray(const strBase64: AnsiString): TByteDynArray;
      procedure pLevantaExcecao(intRespHttp: Integer; strResponse, strExcecao_: WideString);
      function fIsXml(const strCmd: WideString): Boolean;
    public
      constructor Create(strUrl: String; fOnAfterExecute: TAfterExecute; AmodeEnvSoap: TmodeEnvSoap);
      destructor Destroy; override;
      function NfeEnviaRecebeDados(const nr_licenca: WideString; const nm_usuario: WideString; const nm_senha: WideString; const nm_servico: WideString; const dados: WideString): WideString; stdcall;
      function NfeRecebeDanfe(const nr_licenca: WideString; const nm_usuario: WideString; const nm_senha: WideString; const nm_servico: WideString; const dados: WideString): TByteDynArray; stdcall;
  end;

  TWSNFeFitWrapper = class;

  IMetodoImpressao = interface(IInterface)
    function fComandoWebService: String;
    function fExtensaoArquivo: String;
    function fPrefixoArquivo: String;
    procedure pImprimeArquivo(strArquivo, strImpressora: String);
  end;

  TImpressaoPDF = class(TInterfacedObject, IMetodoImpressao)
    private
      strComando: String;
      strPrefixo: String;
    public
      constructor Create(strComando, strPrefixo: String);
      function fComandoWebService: String;
      function fExtensaoArquivo: String;
      function fPrefixoArquivo: String;
      procedure pImprimeArquivo(strArquivo, strImpressora: String);
  end;

  TImpressaoDireta = class(TInterfacedObject, IMetodoImpressao)
    private
      strComando: String;
      strPrefixo: String;

      strArquivoPDFtoPrinter: String;
      strArquivoNfePrinterExe: String;
      strArquivoFitPrinterJar: String;
    public
      constructor Create(strComando, strPrefixo: String);
      function fComandoWebService: String;
      function fExtensaoArquivo: String;
      function fPrefixoArquivo: String;
      procedure pImprimeArquivo(strArquivo, strImpressora: String);
  end;

  TImpressaoDiretaCitel = class
  public
    class procedure pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo: String; blnReimpressao: Boolean = False);
    class procedure pImprimirPDF(strCodigoEmpresa,
                                 strImpressora,
                                 strAcesso,
                                 strTipo           : String;
                                 blnReimpressao    : Boolean = False;
                                 strPDF_Diretorio  : String  = '';
                                 blnPDF_Apresentar : Boolean = False);
  end;


  TImpressaoIntegradorLocal = class(TInterfacedObject, IInterface)
    private
      strIntegrador: String;
      strImpressora: String;
      fitWrapper: TWSNFeFitWrapper;
    public
      constructor Create(fitWrapper: TWSNFeFitWrapper; strIntegrador, strImpressora: String);
      procedure pImprime(strIdNota: String);
  end;

  TMetodoImpressaoFactory = class(TInterfacedObject, IInterface)
    class function fCriarNotaFiscal(strPrefixo: String): IMetodoImpressao;
    class function fCriarCartaCorrecao(strPrefixo: String): IMetodoImpressao;
    class function fCriarNotaServico(strPrefixo: String): IMetodoImpressao;
    class function fCriarManifesto: IMetodoImpressao;
    class function fCriarConhecimento(strForcarImpressaoPDF: String = 'N'): IMetodoImpressao;
  end;

  TWSNfeFitRetorno = class(TInterfacedObject, IInterface)
    private
      FRetornoOk: Boolean;
      FTexto: String;
    public
      constructor Create(blnRetornoOk: Boolean; strTexto: String);
      function RetornoOk: Boolean;
      function Texto: String;
  end;

  TWSNFeFitWrapper = class(TObject)
    private
      WSFit: TNfeApiWS;
      FLicenca: String;
      FUsuario: String;
      FSenha: String;
      FUltimoRetorno: String;
      FUltimoRetornoCancelamento: String;
      FUltimoRetornoCartaCorrecao: String;
      FUrlAlternativa: String;
      FOffLine: Boolean;
      FmodeEnvSoap: TmodeEnvSoap;
      FSeparador: String;

      function fComunicaWebService(strComando, strTexto: String; strLocal: String=''): TWSNfeFitRetorno;
      procedure pCarregaWsFit;
      function OnAfterExecute(SOAPResponse: WideString): WideString;
      function fEscapeXml(const strXml: String): String;
      function fComunicaWebServiceInterna(strComando, strTexto,
        strLocal: String): TWSNfeFitRetorno;
      function fUtilizaSpoolImpressaoCitel(fonteDados: IFonteDados): Boolean;
      procedure pImprimeManifestoEletronicoViaNfeImpressao(const intViasServidor: Integer; const strImpressora, strNumDoc, strCodEmp: String; objLogPerformanceModelo: TLogPerformance=Nil);
      procedure pImprimeConhecimentoEletronicoViaNfeImpressao(const intViasServidor: Integer; const strImpressora, strNumDoc, strCodEmp: String; objLogPerformanceModelo: TLogPerformance=Nil);
    public
      constructor Create;
      destructor Destroy; override;
      function fEnviaTextoIntegracao(strDadosIntegracao: String;
        strSufixo: String; strComando: String=''; intColunaStatus:Integer=2;
        intStatusOk: TIntegerDynArray=Nil): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoDireto(strDadosIntegracao: String;
        strComando: String=FIT_COMANDO_ENVIO; strSufixo: String='NFE_FIT'): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoServico(strDadosIntegracao: String): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoMDFE(strDadosIntegracao: String): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoCTE(strDadosIntegracao: String): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoCTE_CANC(strDadosIntegracao: String): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoNFCE(strDadosIntegracao: String): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoNFCE_CANC(strDadosIntegracao: String;
        strSufixo: String; strComando: String=''): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoSAT_XML(strDadosIntegracao: String): TWSNfeFitRetorno;
      function fEnviaTextoIntegracaoEventoDFe(strDadosIntegracao: String): string;

      function fConsultaSituacaoId(strNumDoc, strSerie, strCodEmp: String): TWSNfeFitRetorno; overload;
      function fConsultaSituacaoId(strIdNota: String): TWSNfeFitRetorno; overload;
      function fConsultaSituacaoIdEspecie(strNumDoc, strSerie, strCodEmp, strEspDoc: String): TWSNfeFitRetorno;
      function fConsultaSituacaoIdManifesto(strTexto: String): TWSNfeFitRetorno;
      function fConsultaEncerramentoIdManifesto(strTexto: String): TWSNfeFitRetorno;
      function fConsultaSituacaoIdConhecimento(strTexto: String): TWSNfeFitRetorno;

      function fConsultaSituacaoCartaCorrecao(strChaveAcesso: String; intSequencial: Integer): TWSNfeFitRetorno;
      function fConsultaSituacaoInutilizacao(strCnpj, strSerie, strNumeroInicial: String; const strModeloFiscal : String = '55'): TWSNfeFitRetorno;
      function fConsultaSituacaoServico(strIdNota: String): TWSNfeFitRetorno;

      function fDownloadDanfe(strAcesso, strNumDoc, strImpressora: String;
        objMetodoImpressao: IMetodoImpressao; intViasServidor: Integer; strIdNota: String;
        objLogPerformanceModelo: TLogPerformance=Nil; fonteDados: IFonteDados = nil; blnContingencia: Boolean = False;
        intTipoEmissao: Integer = 0; strImprimirTelaPDF: String = '';
        tipoImpressao: TTipoImpressao = tiPadrao; strCodEmp: String = ''): String;
      procedure pDownloadXml(strAcesso, strIdNota, strNumDoc: String; strPathXml: String = 'XMLNFE';
        fonteDados: IFonteDados = nil);
      function fRetXMLNfe(strChaveAcesso: string): string;
      function fRetXMLCTe(strChaveAcesso: string): string;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

      function fEnviaTextoIntegracaoNFCE_XML_OFFLINE(strParametros: String): TWSNfeFitRetorno;

      function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; fonteDados: IFonteDados = nil; AIgnorarLayoutSimplificado: Boolean = False): string;

      procedure pDownloadPdfCTe(fonteDados: IFonteDados; ANumeroDocumento, AChaveAcesso: String; tipoImpressao: TTipoImpressao = tiPadrao);
      procedure pDownloadXmlCTe(fonteDados: IFonteDados; ANumeroDocumento, AChaveAcesso: String; ACancelamento: Boolean);
      procedure pDownloadXmlCCe(fonteDados: IFonteDados; ANumeroDocumento, AChaveAcesso, AProtocolo: String);

      function fConsultaStatusDFe(strComando, strChaveAcesso: String): TWSNfeFitRetorno;
      function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): TWSNfeFitRetorno;

      function fRetornaListaChavesAcessoTerceirosPeriodo(strCodEmp: string; dtaDtaIni, dtaDtaFim: TDateTime): string;
      function fRetornaListaChavesAcessoCTeTerceirosPeriodo(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;

      function fRetornaListaCanceladasPorDataCancelamento(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime; const tdfTipDFe: TTipDfe): string;

      function fConsultaSituacaoInutilizacaoTraduzido(const strCnpj_, strSerie_, strNumDoc: String): TRetornoNFE;
      function fConsultaStatusDFeTraduzido(const strChaAce: String): TRetornoNFE;

      function fStatusDenegada(intStatus: Integer): Boolean;
      function fConsultaSituacaoIdNFeNFCe(const strIdNota : String): TWSNfeFitRetorno;

      property strUltimoRetorno: String Read FUltimoRetorno;
      property strUltimoRetornoCancelamento: String Read FUltimoRetornoCancelamento;
      property strUltimoRetornoCartaCorrecao: String Read FUltimoRetornoCartaCorrecao;
      property strUrlAlternativa: String Read FUrlAlternativa Write FUrlAlternativa;
      property blnOffLine: Boolean Read FOffLine Write FOffLine;
      property modeEnvSoap: TmodeEnvSoap Read FmodeEnvSoap Write FmodeEnvSoap;
      property strSeparador: String Read FSeparador Write FSeparador;
  end;

function GetNfeApiWS(strUrl: string=''; OnAfterExecute: TAfterExecute=Nil; AmodeEnvSoap: TmodeEnvSoap=modeOpen): TNfeApiWS;
function fGetModeEnvSoap(fonteDados: IFonteDados): TmodeEnvSoap; Overload;
function fGetModeEnvSoap(fonteDados: IFonteDadosManifesto): TmodeEnvSoap; Overload;
function fGetModeEnvSoap(strValCfg: String): TmodeEnvSoap; Overload;
function fModeEnvSoapToString(AmodeEnvSoap: TmodeEnvSoap): String;
function fStringToModeEnvSoap(strMode: String): TmodeEnvSoap;
function fErroPassivelReenvio(strExcept: String): Boolean;

function fRetornaIdNfeFit(strCodEmp, strNumDoc, strSerie, strEspDoc: String): String;

function fRetNomeArquivoNfePrinterExe: String;
function fRetNomeArquivoFitPrinterJar: String;
function fRetNomeNfeImprimirExeCitel: String;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untWorkStationInfo,
{$ENDIF}
  SysUtils, untUtil, untConfigNFE, untImpressaoDiretaCitel,
  untLogDanfe, untExecuteSoapWithMode, untDicSis;

function GetNfeApiWS(strUrl: string=''; OnAfterExecute: TAfterExecute=Nil; AmodeEnvSoap: TmodeEnvSoap=modeOpen): TNfeApiWS;
begin
  Result := TNfeApiWS.Create(strUrl, OnAfterExecute, AmodeEnvSoap);
end;

function fGetModeEnvSoap(fonteDados: IFonteDados): TmodeEnvSoap;
  Var
    strValCfg: String;
    strCodEmp: String;
begin
  Try
    strCodEmp := '';
    If Assigned(objConfig) Then
      strCodEmp := objConfig.strCodEmp;

    If (Not fEmptyStr(strCodEmp)) Then
      strValCfg := fCfgSisFonte(fonteDados, 'MDEVAR', strCodEmp)
    Else
      strValCfg := fCfgSisFonte(fonteDados, 'MDEVAR');

    Result := fGetModeEnvSoap(strValCfg);
  Except
    Result := modeOpen;
  End;
end;

function fGetModeEnvSoap(fonteDados: IFonteDadosManifesto): TmodeEnvSoap;
  Var
    strValCfg: String;
    strCodEmp: String;
begin
  Try
    strCodEmp := '';
    If Assigned(objConfig) Then
      strCodEmp := objConfig.strCodEmp;

    If (Not fEmptyStr(strCodEmp)) Then
      strValCfg := fCfgSisFonteManifesto(fonteDados, 'MDEVAR', strCodEmp);

    Result := fGetModeEnvSoap(strValCfg);
  Except
    Result := modeOpen;
  End;
end;

function fGetModeEnvSoap(strValCfg: String): TmodeEnvSoap;
  Var
    stlModEnvLoc : TStringList;
    strNomeMaqui : String;
    strValLinArq : String;
    intIdx: Integer;
    modeEnvArq: TmodeEnvSoap;
    blnExisteLinhaIdentificadora: Boolean;
    blnUsaMetodoPersonalizado: Boolean;

    function fLinhaIdentificadoraMetodoEnvio: Boolean;
    begin
      Result := (fStringToModeEnvSoap(strValLinArq) In [modeOpen, modeHttp, modeOpAp]);
    end;

begin
  Result := modeOpen;
  If (strValCfg = cnstOpen) Then
    Result := modeOpen
  Else If (strValCfg = cnstHttp) Then
    Result := modeHttp
  Else If (strValCfg = cnstOpAp) Then
    Result := modeOpAp;

  //VERIFICA SE DETERMINADA MÁQUINA ESTÁ CONFIGURADA PARA USAR MÉTODO DE ENVIO PRÓPRIO (IGNORA A CFG_MDEVAR)
  If FileExists(cnstArqModEnvSoap) Then
  Begin
    Try
      {$IFDEF LINUX}
      strNomeMaqui := GetComputerNetName;
      {$ELSE}
      strNomeMaqui := TWorkStationInfo.fGetWorkstationID;
      {$ENDIF}
      pLogImp('Iniciando fGetModeEnvSoap() > Identificação de envio definido em arquivo.');
      pLogImp('Arquivo...: '+ExtractFilePath(Application.ExeName)+AnsiReplaceStr(cnstArqModEnvSoap,'.\',''));
      pLogImp('Máquina...: '+strNomeMaqui);
      stlModEnvLoc := TStringList.Create;
      stlModEnvLoc.LoadFromFile(cnstArqModEnvSoap);
      modeEnvArq := modeNull;
      blnExisteLinhaIdentificadora := False;
      blnUsaMetodoPersonalizado := False;
      Try
        For intIdx := 0 To stlModEnvLoc.Count-1 Do
        Begin
          strValLinArq := Trim(stlModEnvLoc[intIdx]);

          If (fLinhaIdentificadoraMetodoEnvio) Then
          Begin
            modeEnvArq := fStringToModeEnvSoap(strValLinArq);
            blnExisteLinhaIdentificadora := True;
          End;

          If (blnExisteLinhaIdentificadora) Then
          Begin
            If (Not fLinhaIdentificadoraMetodoEnvio) And (Not fEmptyStr(strValLinArq)) Then
            Begin
              If (strNomeMaqui = strValLinArq) Then
              Begin
                blnUsaMetodoPersonalizado := True;
                Result := modeEnvArq;
                Break;
              End;
            End;
          End;
        End;
      Finally
        FreeAndNil(stlModEnvLoc);
        If blnUsaMetodoPersonalizado Then
          pLogImp('Finalizando fGetModeEnvSoap < ' + strNomeMaqui + ' usa método de envio definido em '+cnstArqModEnvSoap+': '+fModeEnvSoapToString(Result))
        Else
          pLogImp('Finalizando fGetModeEnvSoap < ' + strNomeMaqui + ' usa método de envio da CFG_MDEVAR: '+fModeEnvSoapToString(Result));
      End;
    Except
      Result := modeOpen;
    End;
  End;
end;

function fModeEnvSoapToString(AmodeEnvSoap: TmodeEnvSoap): String;
begin
  Case AmodeEnvSoap Of
    modeOpen: Result := '[modeOpen]';
    modeHttp: Result := '[modeHttp]';
    modeOpAp: Result := '[modeOpAp]';
    modeNull: Result := '[modeNull]';
  End;
end;

function fStringToModeEnvSoap(strMode: String): TmodeEnvSoap;
begin
  Result := modeNull;
  If (strMode = '[modeOpen]') Then
    Result := modeOpen
  Else If (strMode = '[modeHttp]') Then
    Result := modeHttp
  Else If (strMode = '[modeOpAp]') Then
    Result := modeOpAp;
end;

function fErroPassivelReenvio(strExcept: String): Boolean;

   function fEhErroTratavel: Boolean;
   begin
     Result := False;

     //REPRODUZIR CONDIÇÃO QUE RESULTARÁ TRUE NA FUNÇÃO DE MESMO NOME DENTRO DO AUTCOM
     If (Pos('falha na', strExcept) > 0) Then
     Begin
       Result := (Pos('libeay32.dll', strExcept) > 0) Or
                 (Pos('ssl library', strExcept) > 0) Or
                 (Pos('http/1.1 502 bad gateway', strExcept) > 0) Or
                 (Pos('http/1.1 504 gateway time-out', strExcept) > 0) Or
                 (Pos('connect timed out', strExcept) > 0) Or
                 (Pos('connection timed out', strExcept) > 0);
     End;
   end;

begin
  Result := True;
  strExcept := AnsiLowerCase(strExcept);
  If (fEhErroTratavel) Then
  Begin
    Result := False;
  End;
end;

function fRetornaIdNfeFit(strCodEmp, strNumDoc, strSerie, strEspDoc: String): String;
begin
  If strEspDoc = 'IF' Then
  Begin
    Result :=  '88' + strCodEmp + untUtil.fStrZero(RightStr(strNumDoc, 9), 9) + strSerie;
  End
  Else
    Result := strCodEmp + untUtil.fStrZero(strNumDoc, 9) + strSerie;
end;

function fRetNomeNfeImprimirExeCitel: String;
begin
{$IF Defined(LINUX)}
  Result := ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'NFeImpressao';
{$ELSE}
  Result := ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'NFeImpressao.exe';
{$IFEND}
end;

function fRetNomeArquivoNfePrinterExe: String;
begin
  Result := 'c:' + PATH_SEPARATOR + 'NFEPRINTER' + PATH_SEPARATOR + 'nfe-printer.exe';
  If Not FileExists(Result) Then
  Begin
    Result := ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'nfe-printer.exe';
  End;
end;

function fRetNomeArquivoFitPrinterJar: String;
begin
  Result := 'c:' + PATH_SEPARATOR + 'NFEPRINTER' + PATH_SEPARATOR + 'FIT_PRINTER.jar';
  If Not FileExists(Result) Then
  Begin
    Result := ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'FIT_PRINTER.jar';
  End;
end;

{ TWSNfeFitRetorno }

constructor TWSNfeFitRetorno.Create(blnRetornoOk: Boolean; strTexto: String);
begin
  FRetornoOk := blnRetornoOk;
  FTexto := strTexto;
end;

function TWSNfeFitRetorno.RetornoOk: Boolean;
begin
  Result := FRetornoOk;
end;

function TWSNfeFitRetorno.Texto: String;
begin
  Result := FTexto;
end;

{ TWSNFeFitWrapper }

constructor TWSNFeFitWrapper.Create;
begin
  Self.WSFit := Nil;
  Self.FUrlAlternativa := '';
  Self.FOffLine := False;
  Self.FmodeEnvSoap := modeOpen;
  Self.FSeparador := '';
end;

destructor TWSNFeFitWrapper.Destroy;
begin
  If Assigned(Self.WSFit) Then
    FreeAndNil(Self.WSFit);

  inherited;
end;

procedure TWSNFeFitWrapper.pCarregaWsFit;
  Var
    strUrl: String;
begin
  If Not Assigned(WSFit) Then
  Begin
    strUrl := objConfig.strFitUrlWebService;

    If Not fEmptyStr(strUrlAlternativa) Then
      strUrl := strUrlAlternativa;

    pLogImp('pCarregaWsFit > strUrl = ' + strUrl);

    WSFit := GetNfeApiWS(strUrl, OnAfterExecute, FmodeEnvSoap);

    Self.FLicenca := objConfig.strFitLicenca;
    Self.FUsuario := objConfig.strFitUsuario;
    Self.FSenha   := objConfig.strFitSenha;
  End;
end;

function TWSNFeFitWrapper.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; fonteDados: IFonteDados = nil; AIgnorarLayoutSimplificado: Boolean = False): string;
begin
  Result := fonteDados.CarregarPDF(AChaveAcesso, ANomeArquivo, AExtensao, AIgnorarLayoutSimplificado);
end;

function TWSNFeFitWrapper.fComunicaWebService(strComando,
  strTexto: String; strLocal: String=''): TWSNfeFitRetorno;
  Var
    strMsg: String;
    resultValidacao: TResultadoValidacao;
begin
  pLogImp('Iniciando TWSNFeFitWrapper.fComunicaWebService');
  pLogImp('strComando.: ' + strComando);
  pLogImp('strTexto...: ' + strTexto);
  pLogImp('strLocal...: ' + strLocal);
  pCarregaWsFit;
  Try
    Result := fComunicaWebServiceInterna(strComando, strTexto, strLocal);
    pLogImp('Finalizando TWSNFeFitWrapper.fComunicaWebService Result = ' + Result.Texto);
    If strComando = FIT_COMANDO_CONS_SIT Then
      If Pos('nota fiscal nao encontrada', LowerCase(Result.Texto)) > 0 Then
      Begin
        resultValidacao := TResultadoValidacao.Create;
        resultValidacao.pAdicionarErro(Result.Texto, Nil);
        Raise ErrosValidacaoNFE.Create(Result.Texto, resultValidacao);
      End;
  Except
    On E: ESOAPHTTPException Do
    Begin
      strMsg := 'Problema na conexão com WebService ' + strLocal + #13#10 + E.Message +
        #13#10 + 'Tente enviar o documento novamente.';
      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMsg, Nil);
      pLogImp('Finalizando TWSNFeFitWrapper.fComunicaWebService > (E: ESOAPHTTPException) > ' + strMsg);
      Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
    End;

    On E: ESOAPDomConvertError Do
    Begin
      Result := Nil;
      If strComando <> 'FIT_NFE_LISTA_NFE_PROPRIA_TIPO_EMISSAO_PERIODO' Then
      Begin
        Raise;
      End;
    End;
  End;
end;

function TWSNFeFitWrapper.fComunicaWebServiceInterna(strComando, strTexto, strLocal: String): TWSNfeFitRetorno;
  Var
    strRetorno: String;

  procedure pEnviaRecebeDadosLocal;
  begin
    if (not blnOffLine) Then
    Begin
      strRetorno := WSFit.NfeEnviaRecebeDados(FLicenca, FUsuario, FSenha,
        strComando, strTexto);
    end;
    Result := TWSNfeFitRetorno.Create(True, strRetorno);
  end;

begin
  pLogImp('Iniciando TWSNFeFitWrapper.fComunicaWebServiceInterna');
  Try
    pLogImp('pEnviaRecebeDadosLocal');
    pEnviaRecebeDadosLocal;
    pLogImp('Finalizando TWSNFeFitWrapper.fComunicaWebServiceInterna');
  Except
    On E: ESOAPHTTPException Do
    Begin
      If fErroPassivelReenvio(E.Message) Then
      Begin
        Sleep(2000);
        pLogImp('TWSNFeFitWrapper.fComunicaWebServiceInterna > (E: ESOAPHTTPException) > '+ E.Message);
        pLogImp('pEnviaRecebeDadosLocal * ');
        pEnviaRecebeDadosLocal;
      End
      Else
      Begin
        Raise;
      End;
    End;

    On E: EAccessViolation Do
    Begin
      pLogImp('TWSNFeFitWrapper.fComunicaWebServiceInterna > (E: EAccessViolation) > '+ E.Message);
      If (Pos('dhcpcsvc', E.Message) > 0) Or
         (Pos('netprofm', E.Message) > 0) Or
         (Pos('mswsock' , E.Message) > 0) Or
         (Pos('rtutils' , E.Message) > 0) Or
         (Pos('fwpuclnt', E.Message) > 0) Then
      Begin
        Sleep(5000);
        pLogImp('pEnviaRecebeDadosLocal * ');
        pEnviaRecebeDadosLocal;
      End
      Else
      Begin
        Raise;
      End;
    End;

    On E: Exception Do
    Begin
      pLogImp('TWSNFeFitWrapper.fComunicaWebServiceInterna > (E: Exception) > '+ E.Message);
      If (Pos('unqualified', LowerCase(E.Message)) > 0) Or
         (Pos('client fault', LowerCase(E.Message)) > 0) Then
      Begin
        Sleep(5000);
        pLogImp('pEnviaRecebeDadosLocal * ');
        pEnviaRecebeDadosLocal;
      End
      Else
      Begin
        Raise;
      End;
    End;
  End;
end;

function TWSNFeFitWrapper.fRetXMLNfe(strChaveAcesso: string): string;
  Var
    retornoFit: TWSNfeFitRetorno;
    intContador: Integer;
    resultValidacao: TResultadoValidacao;
    strMsg: String;
begin
  Result := '';

  pCarregaWsFit;

  retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_CHAVE_ACESSO', strChaveAcesso);

  If retornoFit.RetornoOk Then
  Begin
    For intContador := 1 To Length(strUltimoRetorno) Do
    Begin
      result := Result + strUltimoRetorno[intContador];
    End;
  End
  Else
  Begin
    strMsg := 'Não foi possível recuperar o XML  ' + strChaveAcesso + '. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit)
End;

function TWSNFeFitWrapper.fStatusDenegada(intStatus: Integer): Boolean;
  Const
    STATUS_DENEGADOS: Array[1..5] Of Integer = (DENEGADA_110, DENEGADA_205, DENEGADA_301, DENEGADA_302, DENEGADA_303);
  Var
    intIdx: Integer;
begin
  Result := False;

  For intIdx := Low(STATUS_DENEGADOS) To High(STATUS_DENEGADOS) Do
  Begin
    If STATUS_DENEGADOS[intIdx] = intStatus Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TWSNFeFitWrapper.fRetXMLCTe(strChaveAcesso: string): string;
  Var
    retornoFit: TWSNfeFitRetorno;
    intContador: Integer;
    resultValidacao: TResultadoValidacao;
    strMsg: String;
begin
  Result := '';

  pCarregaWsFit;

  retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_CTE_CHAVE_ACESSO', strChaveAcesso);

  If retornoFit.RetornoOk Then
  Begin
    For intContador := 1 To Length(strUltimoRetorno) Do
    Begin
      result := Result + strUltimoRetorno[intContador];
    End;
  End
  Else
  Begin
    strMsg := 'Não foi possível recuperar o XML CTe  ' + strChaveAcesso + '. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit)
end;

function TWSNFeFitWrapper.fRetornaListaChavesAcessoTerceirosPeriodo(strCodEmp: string; dtaDtaIni, dtaDtaFim: TDateTime): string;
  Var
    retornoFit: TWSNfeFitRetorno;
    resultValidacao: TResultadoValidacao;
    strTexto: String;
    strMsg: String;
begin
  Result := '';

  pCarregaWsFit;

  strTexto := untUtil.fStrZero(strCodEmp, 5) + '|' + FormatDateTime('ddmmyyyy', dtaDtaIni) + '|' + FormatDateTime('ddmmyyyy', dtaDtaFim);

  retornoFit := fComunicaWebService('FIT_NFE_LISTA_CHAVE_ACESSO_TERCEIROS_PERIODO', strTexto);

  If retornoFit.RetornoOk Then
  Begin
    Result := retornoFit.Texto;
  End
  Else
  Begin
    strMsg := 'Não foi possível retornar a lista de chaves de acesso de terceiros. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit)
End;

function TWSNFeFitWrapper.fRetornaListaChavesAcessoCTeTerceirosPeriodo(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;
  Var
    retornoFit: TWSNfeFitRetorno;
    resultValidacao: TResultadoValidacao;
    strTexto: String;
    strMsg: String;
begin
  Result := '';

  pCarregaWsFit;

  strTexto := FormatDateTime('ddmmyyyy', dtaDtaIni) + '|' + FormatDateTime('ddmmyyyy', dtaDtaFim) + '|' + untUtil.fStrZero(strCodEmp, 5) + '|1|' + strCodNsu;

  retornoFit := fComunicaWebService('FIT_NFE_LISTA_CTE_PROPRIAS_TERCEIROS_NSU', strTexto);

  If retornoFit.RetornoOk Then
  Begin
    Result := retornoFit.Texto;
  End
  Else
  Begin
    strMsg := 'Não foi possível retornar a lista de chaves de acesso de CTe terceiros. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit)
End;

function TWSNFeFitWrapper.fRetornaListaCanceladasPorDataCancelamento(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime; const tdfTipDFe: TTipDfe): string;
  Var
    retornoFit: TWSNfeFitRetorno;
    resultValidacao: TResultadoValidacao;
    strTexto: String;
    strServi: String;
    strMsg: String;
begin
  Result := '';

  pCarregaWsFit;

  strTexto := Concat(strCodEmp + '|', FormatDateTime('ddmmyyyy', dtaDtaIni) + '|', FormatDateTime('ddmmyyyy', dtaDtaFim) + '|', strCodNsu + '|0|', '|');

  If (tdfTipDFe = NFe) Then
    strServi := 'FIT_NFE_LISTA_CHAVE_ACESSO_CANCELADAS_DT_AUT'
  Else If (tdfTipDFe = NFCe) Then
    strServi := 'FIT_NFCE_LISTA_CHAVE_ACESSO_CANCELADAS_DT_AUT';

  retornoFit := fComunicaWebService(strServi, strTexto);

  If retornoFit.RetornoOk Then
  Begin
    Result := retornoFit.Texto;
  End
  Else
  Begin
    strMsg := 'Não foi possível retornar a lista de chaves de acesso de CTe terceiros. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit)
end;

function TWSNFeFitWrapper.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
  Var
    qtdPipe, i : integer;
    retornoFit: TWSNfeFitRetorno;
    resultValidacao: TResultadoValidacao;
    strMsg,
    strtexto: String;
begin
  pCarregaWsFit;
  strTexto := 'NFE-ENVIO-MANIFEST-DEST' + //Tipo de Registro
              '|' +                       //ID de referencia
              '|' + strChaveAcesso +      //Numero chave de acesso
              '|' + '210200' +            //Tipo de Manifestação
              '|' +                       //Justificativa
              '|' +                       //Cnpj do Destinatario
              '|' +                       //Nome do Usuario
              '|';                        //Data e hora do evento

  retornoFit := fComunicaWebService('FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', strTexto);

  If retornoFit.RetornoOk Then
  Begin
    If Pos('Lote de evento processado(Confirmacao da Operacao)', retornoFit.Texto) > 0 Then
      Result := 'OK'
    Else
    Begin
      qtdPipe := 0;
      for i := 1 To Length(retornoFit.Texto) Do
      Begin
        If retornoFit.Texto[i] = '|' Then
          Inc(qtdPipe)
        Else
        Begin
          If qtdPipe = 4 Then
            Result := Result + retornoFit.Texto[i]
          Else If qtdPipe > 4 Then
            Break
        End;
      End;
    End;
  End
  Else
  Begin
    strMsg := 'Não foi possível Confirmar a Operação  ' + strChaveAcesso + '. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoEventoDFe(strDadosIntegracao: String): string;
  Var
    retornoFit: TWSNfeFitRetorno;
    resultValidacao: TResultadoValidacao;
    strMsg: String;
begin
  pCarregaWsFit;

  retornoFit := fComunicaWebService('FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', strDadosIntegracao);

  Try
    If retornoFit.RetornoOk Then
    Begin
      Result := retornoFit.Texto;
    End
    Else
    Begin
      strMsg := 'Não foi possível enviar o evento. '+#13+
                'Motivo: ' + retornoFit.Texto;

      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMsg, Nil);
      pLogImp(strMsg);
      Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
    End;

  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

procedure TWSNFeFitWrapper.pDownloadXml(strAcesso, strIdNota, strNumDoc: String; strPathXml: String = 'XMLNFE'; fonteDados: IFonteDados = nil);
  Var
    retornoFit: TWSNfeFitRetorno;
    xmlStream: TFileStream;
    intContador: Integer;
    resultValidacao: TResultadoValidacao;
    strMsg: String;
    LImprimeNFeCitel : Boolean;
    LCodigoEmpresa: string;
    LXMLJaBaixado: String;
begin
  if not (Assigned(fonteDados)) then
    Exit;

  LXMLJaBaixado := IIF(fonteDados.XMLJaBaixado(strAcesso), 'S', 'N');

  If (strPathXml <> 'XMLNFE_CANCEL') And (LXMLJaBaixado = 'S') Then
    Exit;

  LImprimeNFeCitel := False;
  if Assigned(fonteDados) then
  begin
    LCodigoEmpresa := fonteDados.fDadosGerais.strCodEmp;
    if fEmptyStr(LCodigoEmpresa) then
      LCodigoEmpresa := fonteDados.fGetCampoValor('NFE_CODEMP', 'NFE_ACESSO', strAcesso, 'LOGNFE');

    LImprimeNFeCitel := IIF(fEmptyStr(fCfgSisFonte(fonteDados, 'CITINF')), fCfgSisFonte(fonteDados, 'CITINF', LCodigoEmpresa) = 'S' , fCfgSisFonte(fonteDados, 'CITINF') = 'S');
    if (LImprimeNFeCitel) then
      LImprimeNFeCitel := (fonteDados.fDadosGerais.strEspDoc <> 'NS') or ((fonteDados.fDadosGerais.strEspDoc = 'NS') and (fCfgSisFonte(fonteDados, 'IMPNFS') = 'S'));

    if (fonteDados.fDadosGerais.strEspDoc = 'NS') and
       (fCfgSisFonte(fonteDados, 'NFSCIT', LCodigoEmpresa) = 'S') and
       (not fEmptyStr(strAcesso)) then
    begin
      pLogImp('pDownloadXml < Exit(CFG_NFSCIT = S, não pode fazer download pois o XML é gerado na emissão)');
      Exit;
    end;
  end;

  if strPathXml = EmptyStr then
    strPathXml := 'XMLNFE';

  pCarregaWsFit;

  if (fonteDados.fDadosGerais.strEspDoc = 'NS') then
  begin
    retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_NFSE_ID_NOTA_FISCAL', strIdNota, 'DOWNLOAD XML');
  end
  else IF (fonteDados.fDadosGerais.strEspDoc = 'IF') then
  begin
    retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_CHAVE_ACESSO', strAcesso, 'DOWNLOAD XML');
  end
  else
  begin
    retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_ID_NOTA_FISCAL', strIdNota, 'DOWNLOAD XML');
  end;

  If retornoFit.RetornoOk Then
  Begin
    If (Not fEmptyStr(strUltimoRetorno)) Then
    Begin
      If (Not fEmptyStr(strAcesso)) Then
      Begin
        fonteDados.pSalvarXMLNFeBD(strAcesso, strUltimoRetorno, LXMLJaBaixado);

        If (Not fEmptyStr(strUltimoRetornoCancelamento)) Then
        Begin
          fonteDados.pSalvarXmlDfeBD(fonteDados.fDadosGerais.strEspDoc + '_CANCELAMENTO', strAcesso, 'N/D', strUltimoRetornoCancelamento);
        End;
      End;

      If (FileExists('nfe.downloadxml')) Then
      begin
        strPathXml := fSepDir(fPnlDir('') + strPathXml);
        If Not DirectoryExists(strPathXml) Then
          CreateDir(strPathXml);

        strPathXml := strPathXml + strAcesso + '.xml';
        If FileExists(strPathXml) Then
          DeleteFile(strPathXml);

        xmlStream := TFileStream.Create(strPathXml, fmCreate);
        For intContador := 1 To Length(strUltimoRetorno) Do
        Begin
          xmlStream.Write(strUltimoRetorno[intContador], 1);
        End;
        FreeAndNil(xmlStream);
      end;
    End;
  End
  Else If (LImprimeNFeCitel) Then
  Begin
    strMsg := 'Não foi possível recuperar o XML na nota ' + strNumDoc + '. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

procedure TWSNFeFitWrapper.pDownloadPdfCTe(fonteDados: IFonteDados; ANumeroDocumento, AChaveAcesso: String;
  tipoImpressao: TTipoImpressao = tiPadrao);
Var
  danfe: TByteDynArray;
  danfeStringStream: TStringStream;
  strDanfe: String;
  byteAtual: Byte;
  intContador: Integer;
  resultValidacao: TResultadoValidacao;
  strMsg: String;
begin
  if not (Assigned(fonteDados)) then
    Exit;

  If tipoImpressao = tiNfeImpressao Then
    Exit;

  If fonteDados.PDFJaBaixado(AChaveAcesso) Then
     Exit;

  pCarregaWsFit;

  danfe := WSFit.NfeRecebeDanfe(FLicenca, FUsuario, FSenha, 'FIT_CTE_DACTE_CHAVE_ACESSO', AChaveAcesso);

  If Length(danfe) > 0 Then
  Begin
    danfeStringStream := TStringStream.Create(EmptyStr);

    Try
      For intContador := Low(danfe) To High(danfe) Do
      Begin
        byteAtual := danfe[intContador];
        danfeStringStream.Write(byteAtual, 1);
      End;
      strDanfe := danfeStringStream.DataString;
    Finally
      FreeAndNil(danfeStringStream);
    End;

    fonteDados.pSalvarPDFNFeBD(AChaveAcesso, strDanfe);
  End
  Else
  Begin
    strMsg := 'Não foi possível carregar a danfe do CTe ' + ANumeroDocumento;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;
end;

procedure TWSNFeFitWrapper.pDownloadXmlCTe(fonteDados: IFonteDados; ANumeroDocumento, AChaveAcesso: String; ACancelamento: Boolean);
Var
  retornoFit: TWSNfeFitRetorno;
  resultValidacao: TResultadoValidacao;
  strMsg: String;
begin
  if not (Assigned(fonteDados)) then
    Exit;

  If fEmptyStr(AChaveAcesso) Then
    Exit;

  If (not ACancelamento) Then
  Begin
    If fonteDados.XMLJaBaixado(AChaveAcesso) Then
      Exit;
  End;

  pCarregaWsFit;

  retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_CTE_CHAVE_ACESSO', AChaveAcesso, 'DOWNLOAD XML');

  If retornoFit.RetornoOk Then
  Begin
    If Not fonteDados.XMLJaBaixado(AChaveAcesso) Then
    Begin
      If Not fEmptyStr(strUltimoRetorno) Then
      Begin
        fonteDados.pSalvarXMLNFeBD(AChaveAcesso, strUltimoRetorno);
      End;
    End;

    If (Not fEmptyStr(strUltimoRetornoCancelamento)) Then
    Begin
      fonteDados.pSalvarXmlDfeBD('CT_CANCELAMENTO', AChaveAcesso, 'N/D', strUltimoRetornoCancelamento);
    End;
  End
  Else
  Begin
    strMsg := 'Não foi possível recuperar o XML do CTe ' + ANumeroDocumento + '. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

procedure TWSNFeFitWrapper.pDownloadXmlCCe(fonteDados: IFonteDados; ANumeroDocumento, AChaveAcesso, AProtocolo: String);
Var
  retornoFit: TWSNfeFitRetorno;
  resultValidacao: TResultadoValidacao;
  strMsg: String;
begin
  if not (Assigned(fonteDados)) then
    Exit;

  If fEmptyStr(AChaveAcesso) Then
    Exit;

  If fEmptyStr(AProtocolo) Then
    Exit;

  pCarregaWsFit;

  retornoFit := fComunicaWebService('FIT_NFE_RECEBE_XML_CHAVE_ACESSO', AChaveAcesso, 'DOWNLOAD XML');

  If retornoFit.RetornoOk Then
  Begin
    If (Not fEmptyStr(FUltimoRetornoCartaCorrecao)) Then
    Begin
      fonteDados.pSalvarXmlDfeBD('CC_CARTA_CORRECAO', AChaveAcesso, AProtocolo, FUltimoRetornoCartaCorrecao);
    End;
  End
  Else
  Begin
    strMsg := 'Não foi possível recuperar o XML do CCe ' + ANumeroDocumento + '. Motivo: ' + retornoFit.Texto;
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

procedure TWSNFeFitWrapper.pImprimeConhecimentoEletronicoViaNfeImpressao(
  const intViasServidor: Integer; const strImpressora, strNumDoc,
  strCodEmp: String; objLogPerformanceModelo: TLogPerformance);
  Var
    blnReimpressao : Boolean;
begin
 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Imprimindo Conhecimento Eletrônico, aguarde ...');
 {$IFEND}

  blnReimpressao := intViasServidor > 0;

  pLogImp('IMPRESSAO DIRETA CITEL - ' + strImpressora);

  TImpressaoDiretaCitel.pImprimir(strCodEmp, strImpressora, strNumDoc, 'CTE', blnReimpressao);
end;

procedure TWSNFeFitWrapper.pImprimeManifestoEletronicoViaNfeImpressao(
  const intViasServidor: Integer; const strImpressora, strNumDoc,
  strCodEmp: String; objLogPerformanceModelo: TLogPerformance);
  Var
    blnReimpressao : Boolean;
begin
 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Imprimindo Manifesto Eletrônico, aguarde ...');
 {$IFEND}

  blnReimpressao := intViasServidor > 0;

  pLogImp('IMPRESSAO DIRETA CITEL - ' + strImpressora);

  TImpressaoDiretaCitel.pImprimir(strCodEmp, strImpressora, strNumDoc, 'MDFE', blnReimpressao);
end;

function TWSNFeFitWrapper.fConsultaSituacaoCartaCorrecao(
  strChaveAcesso: String; intSequencial: Integer): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFE_CONSULTA_CCE_CHAVE_ACESSO', strChaveAcesso + '|' + IntToStr(intSequencial));
end;

function TWSNFeFitWrapper.fConsultaSituacaoId(strNumDoc,
  strSerie, strCodEmp: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, strCodEmp + untUtil.fStrZero(strNumDoc, 9) + strSerie);
  If (Pos('Processando/Transmitindo', Result.Texto) > 0) Then
  Begin
    Sleep(6000);
    Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, strCodEmp + untUtil.fStrZero(strNumDoc, 9) + strSerie);
  End;
end;

function TWSNFeFitWrapper.fConsultaSituacaoId(strIdNota: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, strIdNota);
end;

function TWSNFeFitWrapper.fConsultaSituacaoIdConhecimento(strTexto: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_CTE_CONSULTA_ID_CONHECIMENTO_TRANSP', strTexto);
end;

function TWSNFeFitWrapper.fConsultaSituacaoIdEspecie(strNumDoc,
  strSerie, strCodEmp, strEspDoc: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService(FIT_COMANDO_CONS_SIT, fRetornaIdNfeFit(strCodEmp, strNumDoc, strSerie, strEspDOc));
end;

function TWSNFeFitWrapper.fConsultaSituacaoIdManifesto(
  strTexto: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFE_CONSULTA_ID_MANIFESTO', strTexto);
end;

function TWSNFeFitWrapper.fConsultaSituacaoIdNFeNFCe(
  const strIdNota: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFE_CONSULTA_ID_NFE_NFCE', strIdNota);
end;

function TWSNFeFitWrapper.fConsultaSituacaoInutilizacaoTraduzido(const strCnpj_, strSerie_, strNumDoc: String): TRetornoNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
    LStatus,
    LMensagem,
    LMensagemErro: String;
begin
  retornoFit := Self.fConsultaSituacaoInutilizacao(strCnpj_, strSerie_, strNumDoc);

  LStatus       := fGetValorLinha(retornoFit.Texto, '|', 16);
  LMensagem     := fGetValorLinha(retornoFit.Texto, '|', 8);
  LMensagemErro := fGetValorLinha(retornoFit.Texto, '|', 17);

  If (StrToIntDef(LStatus, -1) = RET_INUTILIZACAO_OK) Then
    Result := TRetornoNFE.fCriaRetornoInutilizada(LMensagem)
  Else If fStatusDenegada(StrToIntDef(LStatus, -1)) Then
    Result := TRetornoNFE.fCriaRetornoDenegada(LMensagem)
  Else If (StrToIntDef(LStatus, -1) = 999) Then
    Result := TRetornoNFE.fCriaRetornoErro(LMensagemErro)
  Else
    Result := TRetornoNFE.fCriaRetornoErro('fConsultaSituacaoInutilizacaoTraduzido > Não consegui definir o status: '+LMensagem);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TWSNFeFitWrapper.fConsultaStatusDFeTraduzido(const strChaAce: String): TRetornoNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
    LsLDataAut,
    LProtocolo,
    LStatus,
    LMensagem,
    LCancelada: String;
    LdLDataAut: TDateTime;
begin
  retornoFit := Self.fConsultaStatusDFe('FIT_NFE_CONSULTA_CHAVE_ACESSO', strChaAce);

  LStatus    := fGetValorLinha(retornoFit.Texto, '|', 10);
  LMensagem  := fGetValorLinha(retornoFit.Texto, '|', 11);
  LProtocolo := fGetValorLinha(retornoFit.Texto, '|', 12);
  LCancelada := fGetValorLinha(retornoFit.Texto, '|', 20);
  LsLDataAut := fGetValorLinha(retornoFit.Texto, '|', 13);
  LdLDataAut := StrToDateTimeDef(Copy(LsLDataAut, 01, 02) + '/' +
                                 Copy(LsLDataAut, 03, 02) + '/' +
                                 Copy(LsLDataAut, 05, 04) + ' ' +
                                 Copy(LsLDataAut, 09, 02) + ':' +
                                 Copy(LsLDataAut, 11, 02) + ':' +
                                 Copy(LsLDataAut, 13, 02), 0);

  If (LCancelada = 'S') Then
    Result := TRetornoNFE.fCriaRetornoCancelada(LProtocolo, True)
  Else If (StrToIntDef(LStatus, -1) = RET_INUTILIZACAO_OK) Then
    Result := TRetornoNFE.fCriaRetornoInutilizada(LMensagem)
  Else If fStatusDenegada(StrToIntDef(LStatus, -1)) Then
    Result := TRetornoNFE.fCriaRetornoDenegada(LMensagem)
  Else If (StrToIntDef(LStatus, -1) = 999) Then
    Result := TRetornoNFE.fCriaRetornoErro(LMensagem)
  Else If (StrToIntDef(LStatus, -1) In [RET_STATUS_AUTORIZADA, RET_STATUS_AUTORIZADA_FORA_PRAZO, RET_STATUS_AUTORIZADA_FORA_PRAZO_2]) Then
    Result := TRetornoNFE.fCriaRetornoSucesso(LMensagem, strChaAce, LProtocolo, LdLDataAut)
  Else
    Result := TRetornoNFE.fCriaRetornoErro('fConsultaStatusDFeTraduzido > Não consegui definir o status: '+LMensagem);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TWSNFeFitWrapper.fConsultaEncerramentoIdManifesto(
  strTexto: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFE_CONSULTA_ENCERRAMENTO_MDFE_ID', strTexto);
end;

function TWSNFeFitWrapper.fConsultaSituacaoInutilizacao(strCnpj, strSerie,
  strNumeroInicial: String; const strModeloFiscal : String = '55'): TWSNfeFitRetorno;
  Var
    strTexto: String;
begin
  strTexto := strCnpj + '|' + strSerie + '|' + strNumeroInicial;
  If (strModeloFiscal <> '55') Then
    strTexto := strTexto + '|' + strModeloFiscal;
  Result := fComunicaWebService('FIT_NFE_CONSULTA_INUTILIZACAO', strTexto);
end;

function TWSNFeFitWrapper.fConsultaSituacaoServico(strIdNota: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFSE_CONSULTA_ID_NOTA_FISCAL', strIdNota)
end;

function TWSNFeFitWrapper.fUtilizaSpoolImpressaoCitel(fonteDados: IFonteDados): Boolean;
begin
  Result := (fCfgSisFonte(fonteDados, 'SPOIMP') = 'S') And (fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S') <> 'N');
end;

function TWSNFeFitWrapper.fDownloadDanfe(strAcesso, strNumDoc, strImpressora: String;
  objMetodoImpressao: IMetodoImpressao; intViasServidor: Integer; strIdNota: String;
  objLogPerformanceModelo: TLogPerformance=Nil; fonteDados: IFonteDados = nil;
  blnContingencia: Boolean = False; intTipoEmissao: Integer = 0;
  strImprimirTelaPDF: String = ''; tipoImpressao: TTipoImpressao = tiPadrao;
  strCodEmp: String = ''): String;
  Var
    danfe: TByteDynArray;
    danfeStream: TFileStream;
    danfeStringStream: TStringStream;
    strDanfe: String;
    strPathDanfe: String;
    byteAtual: Byte;
    intContador: Integer;
    resultValidacao: TResultadoValidacao;
    strMsg: String;

    strNomArq: String;
    strTexto: String;
    LImprimeNFeCitel : Boolean;
    LCodigoEmpresa: string;
    blnReimpressao : boolean;
    LImprimeCCeCitel : Boolean;
    LEhEmissaoPelaPropriaCitel: Boolean;
    LConsultarBaixarXML: Boolean;
    LConsultarBaixarPDF: Boolean;
    LPDFJaBaixado: String;

  procedure pImprimeCitelCCe;
  begin
   {$IF Defined(VER180)}
   {$ELSE}
    if Assigned(untUtil.OnNotificarProgresso) then
      untUtil.OnNotificarProgresso('Imprimindo Citel CCe, aguarde ...');
   {$IFEND}

    blnReimpressao := intViasServidor > 0;

    pLogImp('IMPRESSAO DIRETA CITEL - ' + strImpressora);

    TImpressaoDiretaCitel.pImprimir(LCodigoEmpresa, strImpressora, strAcesso, 'CCE', blnReimpressao);
  end;

  function fSalvaPDFNFeBD: Boolean;
  begin
    Result := False;

    If (fonteDados.fDadosGerais.strEspDoc = 'NF') And (fCfgSisFonte(fonteDados, 'CITINF') = 'S') Then
      Exit;

    If (fonteDados.fDadosGerais.strEspDoc = 'NS') And (fCfgSisFonte(fonteDados, 'IMPNFS') = 'S') Then
      Exit;

    Result := True;
  end;

  function fImprimirTelaPDFouPDF: Boolean;
  begin
    Result := False;

    If (strImprimirTelaPDF = 'TelaPDF') Then
    Begin
      Result := True;
      Exit;
    End;

    If (strImprimirTelaPDF = 'PDF') Then
    Begin
      Result := True;
      Exit;
    End;
  end;

  function fEhContingenciaMasDeveBaixarXML: Boolean;
  begin
    Result := blnContingencia And (Pos(IntToStr(intTipoEmissao), fCfgSisFonte(fonteDados, 'CTGXML')) > 0);
  end;

begin
 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Realizando download DANFE, aguarde ...');
 {$IFEND}

  pLogImp('Iniciando TWSNFeFitWrapper.fDownloadDanfe()');
  pLogImp('strAcesso..........: ' + strAcesso);
  pLogImp('strNumDoc..........: ' + strNumDoc);
  pLogImp('strImpressora......: ' + strImpressora);
  pLogImp('blnContingencia....: ' + fBooleanToString(blnContingencia));
  pLogImp('intTipoEmissao.....: ' + IntToStr(intTipoEmissao));
  pLogImp('strImprimirTelaPDF.: ' + strImprimirTelaPDF);

  LImprimeNFeCitel := False;
  LImprimeCCeCitel := False;
  LPDFJaBaixado    := '';

  LConsultarBaixarXML := True;
  LConsultarBaixarPDF := True;
  LEhEmissaoPelaPropriaCitel := False;

  If fEmptyStr(strIdNota) Then
    strIdNota := strAcesso;

  if Assigned(fonteDados) then
  begin
    LCodigoEmpresa := fonteDados.fDadosGerais.strCodEmp;
    If fEmptyStr(LCodigoEmpresa) Then
      LCodigoEmpresa := fonteDados.fGetCampoValor('NFE_CODEMP', 'NFE_ACESSO', strAcesso, 'LOGNFE');

    LImprimeNFeCitel := IIF(fEmptyStr(fCfgSisFonte(fonteDados, 'CITINF')), fCfgSisFonte(fonteDados, 'CITINF', LCodigoEmpresa) = 'S' , fCfgSisFonte(fonteDados, 'CITINF') = 'S');
    if (LImprimeNFeCitel) then
      LImprimeNFeCitel := (fonteDados.fDadosGerais.strEspDoc <> 'NS') Or ((fonteDados.fDadosGerais.strEspDoc = 'NS') And (fCfgSisFonte(fonteDados, 'IMPNFS') = 'S'));

    LImprimeCCeCitel := IIF(fEmptyStr(fCfgSisFonte(fonteDados, 'NFICCE')), fCfgSisFonte(fonteDados, 'NFICCE', LCodigoEmpresa) = 'S' , fCfgSisFonte(fonteDados, 'NFICCE') = 'S');
  end;

  If (Assigned(fonteDados)) Then
  Begin
    //CONFIGURAÇÃO CRIADA PARA IDENTIFICAR AS EMISSÕES DE NOTA DE SERVIÇO PELA CITEL
    If (fCfgSisFonte(fonteDados, 'AXCFNS') = 'S') Then
    Begin
      pLogImp(' ');
      pLogImp('LEhEmissaoPelaPropriaCitel.: = ' + fBooleanToString(LEhEmissaoPelaPropriaCitel));
      If (Not fEhParaImprimir(strImpressora)) Then
      Begin
        LConsultarBaixarXML := False;
        LConsultarBaixarPDF := False;
        LEhEmissaoPelaPropriaCitel := True;

        If LImprimeNFeCitel Then
        Begin
          LConsultarBaixarXML := fonteDados.fTabelaExiste('XMLNFE');
          LConsultarBaixarPDF := fonteDados.fTabelaExiste('PDFNFE');
        End;

        pLogImp('LImprimeNFeCitel...........: = ' + fBooleanToString(LImprimeNFeCitel));
        pLogImp('LImprimeCCeCitel...........: = ' + fBooleanToString(LImprimeCCeCitel));
        pLogImp('fImprimirTelaPDFouPDF......: = ' + fBooleanToString(fImprimirTelaPDFouPDF));
        pLogImp('LConsultarBaixarXML........: = ' + fBooleanToString(LConsultarBaixarXML));
        pLogImp('LConsultarBaixarPDF........: = ' + fBooleanToString(LConsultarBaixarPDF));
      End;
      pLogImp(' ');
    End;
  End;

  If (Not fImprimirTelaPDFouPDF) And (Not fEmptyStr(strAcesso)) Then
  Begin
    If (Assigned(fonteDados)) Then
    Begin
      If LConsultarBaixarXML Then
      Begin
        pLogImp('fonteDados.XMLJaBaixado >');
        If (Not fonteDados.XMLJaBaixado(strAcesso)) Then
        Begin
          If (Not blnContingencia) Or fEhContingenciaMasDeveBaixarXML Then
          Begin
            Try
              pLogImp('Não achou o XML então vai baixar > ' + strAcesso);
              pDownloadXml(strAcesso, strIdNota, strNumDoc, EmptyStr, fonteDados);
            Except
              On E: Exception Do
              Begin
                pLogImp('fonteDados.XMLJaBaixado < (Exception) ' + E.Message);
              End;
            End;
          End;
        End;
        pLogImp('fonteDados.XMLJaBaixado <');
      End;
    End;
  End;

  If (objMetodoImpressao.fPrefixoArquivo = 'CCe_') and (LImprimeCCeCitel) then
  Begin
    pLogImp('Imprimindo CCE');
    pImprimeCitelCCe;

    Exit;
  End
  Else If (objMetodoImpressao.fPrefixoArquivo = 'MDFE_') and
    (tipoImpressao = tiNfeImpressao) then
  Begin
    pLogImp('Imprimindo MDFE');
    pImprimeManifestoEletronicoViaNfeImpressao(intViasServidor, strImpressora, strNumDoc, strCodEmp, objLogPerformanceModelo);
    Exit;
  End
  Else If (objMetodoImpressao.fPrefixoArquivo = 'CTE_') and
    (tipoImpressao = tiNfeImpressao) then
  Begin
    pLogImp('Imprimindo CTE');
    pImprimeConhecimentoEletronicoViaNfeImpressao(intViasServidor, strImpressora, strNumDoc, strCodEmp, objLogPerformanceModelo);
    Exit;
  End
  Else if (LImprimeNFeCitel) and
    (not fImprimirTelaPDFouPDF) and
    ((not blnContingencia) Or fEhContingenciaMasDeveBaixarXML) and
    (objMetodoImpressao.fPrefixoArquivo <> 'CCe_') and
    (objMetodoImpressao.fPrefixoArquivo <> 'MDFE_') and
    (objMetodoImpressao.fPrefixoArquivo <> 'CTE_') then
  begin
   {$IF Defined(VER180)}
   {$ELSE}
    if Assigned(untUtil.OnNotificarProgresso) then
      untUtil.OnNotificarProgresso('Preparando para impressão, aguarde ...');
   {$IFEND}

    blnReimpressao := intViasServidor > 0;

    pLogImp('IMPRESSAO DIRETA CITEL - ' + strImpressora);
    pLogImp('Finalizando TWSNFeFitWrapper.fDownloadDanfe() > '+'[Vai chamar NFeImpressao] > Exit;');

    if fonteDados.fDadosGerais.strEspDoc = 'NS' then
      TImpressaoDiretaCitel.pImprimir(LCodigoEmpresa, strImpressora, strAcesso, 'NFS', blnReimpressao)
    else
      TImpressaoDiretaCitel.pImprimir(LCodigoEmpresa, strImpressora, strAcesso, 'NFE', blnReimpressao);

    Exit;
  end;

  If (Assigned(fonteDados)) And (strImprimirTelaPDF = 'PDF') Then
  Begin
    LPDFJaBaixado := IIF(fonteDados.PDFJaBaixado(strAcesso), 'S', 'N');

    If (LImprimeNFeCitel) Or (LPDFJaBaixado = 'S') Then
    Begin
      If LImprimeNFeCitel Then
        pLogImp('Finalizando TWSNFeFitWrapper.fDownloadDanfe() > '+'[PDF será gerado a seguir, se não existir, pelo NFeImpressao] > Exit;')
      Else
        pLogImp('Finalizando TWSNFeFitWrapper.fDownloadDanfe() > '+'[PDF já baixado] > Exit;');
      Exit;
    End;
  End;

  If (LEhEmissaoPelaPropriaCitel) Then
  Begin
    If (Not fImprimirTelaPDFouPDF) And (Not fEhParaImprimir(strImpressora)) And (Not LConsultarBaixarPDF) Then
    Begin
      pLogImp('Finalizando TWSNFeFitWrapper.fDownloadDanfe() > '+'[IMPRESSORA = '+strImpressora+' E CFG_AXCFNS = S] > Exit;');
      Exit;
    End;
  End;

  pCarregaWsFit;
  strNomArq := objMetodoImpressao.fPrefixoArquivo + IIF(fEmptyStr(strAcesso), strIdNota, strAcesso);

  strTexto := strIdNota;
  If intViasServidor > 0 Then
    strTexto := strTexto + '|' + IntToStr(intViasServidor);

  Try
    pLogImp('WSFit.NfeRecebeDanfe');
    danfe := WSFit.NfeRecebeDanfe(FLicenca, FUsuario, FSenha, objMetodoImpressao.fComandoWebService,
                                  IIF((fImprimirTelaPDFouPDF) And (not fEmptyStr(strAcesso)), strAcesso, strTexto));
  Except
    On E: ESOAPHTTPException Do
    Begin
      strMsg := 'RECUPERAR DANFE: Problema na conexão com WebService: ' + E.Message;
      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMsg, Nil);
      pLogImp('ESOAPHTTPException' + #13#10 + strMsg);
      Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
    End;

    On E: ESOAPDomConvertError Do
    Begin
      strMsg := 'Licença: ' + FLicenca + #13#10 +
                'Usuário: ' + FUsuario + #13#10 +
                'Comando: ' + objMetodoImpressao.fComandoWebService + #13#10 +
                'Texto..: ' + strTexto + #13#10;
      pLogImp('ESOAPDomConvertError' + #13#10 + strMsg);
      Raise ErrosValidacaoNFE.fCriaErroSimples('Danfe não encontrada para download.' + #13#10 + E.Message);
    End;

    On E: Exception Do
    Begin
      pLogImp('Erro: ' + E.Message);
      Raise ErrosValidacaoNFE.fCriaErroSimples(E.Message);
    End;
  End;

  If Length(danfe) <= 0 Then
  Begin
    strMsg := 'Não foi possível carregar a danfe da NFe ' + strNumDoc + '. Por favor, utilize a reimpressão.';
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If VS_PDFtoPrinter Then
    strPathDanfe := ExtractFileDir(fRetNomeArquivoPDFtoPrinter) + PATH_SEPARATOR + 'DANFE' + PATH_SEPARATOR
  Else
  Begin
    If FileExists(fRetNomeArquivoNfePrinterExe) Then
      strPathDanfe := ExtractFileDir(fRetNomeArquivoNfePrinterExe) + PATH_SEPARATOR + 'DANFE' + PATH_SEPARATOR
    Else
      strPathDanfe := ExtractFileDir(fRetNomeArquivoFitPrinterJar) + PATH_SEPARATOR + 'DANFE' + PATH_SEPARATOR;
  End;

  If Not DirectoryExists(strPathDanfe) Then
    CreateDir(strPathDanfe);

  strPathDanfe := strPathDanfe + strNomArq + objMetodoImpressao.fExtensaoArquivo;

  If strImprimirTelaPDF <> 'PDF' Then
  Begin
    pLogImp('Gerar arquivo '+strPathDanfe);

    If FileExists(strPathDanfe) Then
    Begin
      pLogImp('Arquivo '+strPathDanfe+' já existe!');
      If (LowerCase(objMetodoImpressao.fExtensaoArquivo) = '.zip') Then
      Begin
        If fArquivoEmUso(strPathDanfe) Then
        Begin
          //REQ.: 103158 OPERADOR CLICAVA VÁRIAS VEZES NO BOTÃO REIMPRESSÃO ANTES DO FIT-PRINTER ACABAR DE IMPRIMIR
          pLogImp('Arquivo '+strPathDanfe+' em uso!');
          Raise ErrosValidacaoNFE.fCriaErroSimples('Impressão da NFe ' + strNumDoc + ' em andamento. Aguarde!'+' <<SUBMAD>> ');
        End;
      End;

      pLogImp('Apagar arquivo '+strPathDanfe);
      DeleteFile(strPathDanfe);
    End;

    If FileExists(strPathDanfe) Then
    Begin
      pLogImp('Arquivo '+strPathDanfe+' não foi apagado então será usado ele mesmo');
    End
    Else
    Begin
      pLogImp('Escrever byte a byte > '+strPathDanfe);
      Try
        danfeStream := TFileStream.Create(strPathDanfe, fmCreate);
        Try
          For intContador := Low(danfe) To High(danfe) Do
          Begin
            byteAtual := danfe[intContador];
            danfeStream.Write(byteAtual, 1);
          End;
        Finally
          FreeAndNil(danfeStream);
        End;
      Except
        On E: Exception Do
        Begin
          pLogImp('Escrever byte a byte (Exception) '+strPathDanfe+' '+E.message);
        End;
      End;
      pLogImp('Escrever byte a byte < '+strPathDanfe);
    End;
  End;

  If (Assigned(fonteDados)) And (fImprimirTelaPDFouPDF) Then
  Begin
    If fSalvaPDFNFeBD Then
    Begin
      If LConsultarBaixarPDF Then
      Begin
        pLogImp('fonteDados.PDFJaBaixado >');
        If (LPDFJaBaixado = '') Then
          LPDFJaBaixado := IIF(fonteDados.PDFJaBaixado(strAcesso), 'S', 'N');

        If (LPDFJaBaixado <> 'S') Then
        Begin
          pLogImp('Não achou o PDF então vai baixar > ' + strAcesso);

          danfeStringStream := TStringStream.Create(''{$IFDEF LINUX},TEncoding.ANSI{$ENDIF});
          Try
            For intContador := Low(danfe) To High(danfe) Do
            Begin
              byteAtual := danfe[intContador];
              danfeStringStream.Write(byteAtual, 1);
            End;
            strDanfe := danfeStringStream.DataString;
          Finally
            FreeAndNil(danfeStringStream);
          End;

          fonteDados.pSalvarPDFNFeBD(strAcesso, strDanfe, LPDFJaBaixado);
        End;
        pLogImp('fonteDados.PDFJaBaixado <');
      End;
    End;
  End;

  {$IFDEF UNIDAC}
  If fUtilizaSpoolImpressaoCitel(fonteDados) And (Not fImprimirTelaPDFouPDF) Then
  begin
    blnReimpressao := intViasServidor > 0;

    pLogImp('IMPRESSAO DIRETA CITEL - ' + strImpressora);

    if fonteDados.fDadosGerais.strEspDoc = 'NS' then
    begin
      TImpressaoDiretaCitel.pImprimir(LCodigoEmpresa, strImpressora, strAcesso, 'NFS', blnReimpressao);
    end
    else
    begin
      TImpressaoDiretaCitel.pImprimir(LCodigoEmpresa, strImpressora, strAcesso, 'NFE', blnReimpressao);
    end;
  end
   Else If (strImprimirTelaPDF <> 'PDF') Then
  {$ENDIF}
  Begin
    If (fEhParaImprimir(strImpressora)) Then
    Begin
      pLogImp('objMetodoImpressao.pImprimeArquivo('+strPathDanfe+', '+strImpressora+');');

      If VS_PDFtoPrinter Then
      Begin
        If (FileExists(fRetNomeArquivoPDFtoPrinter)) Then
          pLogImp(fRetNomeArquivoPDFtoPrinter+ ' poderá ser usado!')
        Else
          pLogImp('ATENÇÃO: '+fRetNomeArquivoPDFtoPrinter + ' não existe no diretório do painel e isso pode estar impedindo a autorização caso seja esse o problema!');
      End
      Else
      Begin
        If (FileExists(fRetNomeArquivoFitPrinterJar)) Then
          pLogImp(fRetNomeArquivoFitPrinterJar+ ' poderá ser usado!')
        Else If (FileExists(fRetNomeArquivoNfePrinterExe)) Then
          pLogImp(fRetNomeArquivoNfePrinterExe+ ' poderá ser usado!')
        Else
          pLogImp('ATENÇÃO: '+fRetNomeArquivoFitPrinterJar + ' não existe no diretório do painel e isso pode estar impedindo a autorização caso seja esse o problema!')
      End;
    End;

    objMetodoImpressao.pImprimeArquivo(strPathDanfe, strImpressora);
  End;

  Result := strPathDanfe;
  pLogImp('Finalizando TWSNFeFitWrapper.fDownloadDanfe() > Result=' + Result);
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracao(strDadosIntegracao: String;
  strSufixo: String; strComando: String=''; intColunaStatus:Integer=2;
  intStatusOk: TIntegerDynArray=Nil): TWSNfeFitRetorno;
  Var
    intRetorno: Integer;
    strCmd: String;
  function StatusOk: Boolean;
    Var
      intContador: Integer;
  Begin
    Result := False;
    For intContador := Low(intStatusOk) To High(intStatusOk) Do
    Begin
      If intStatusOk[intContador] = intRetorno Then
      Begin
        Result := True;
        Break;
      End;
    End;
  end;
begin
  strCmd := FIT_COMANDO_ENVIO;
  If Not fEmptyStr(strComando) Then
    strCmd := strComando;

  Result := fComunicaWebService(strCmd+strSufixo, strDadosIntegracao);
  If (Assigned(Result)) And (Result.FRetornoOk) Then
  Begin
    intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', intColunaStatus), -1);
    If (AnsiStartsText('NFE-CANC', strDadosIntegracao)) And (intRetorno = 9) Then
    Begin
      intRetorno := 1;
    End;

    If Assigned(intStatusOk) Then
    Begin
      If Not StatusOk Then
      Begin
        Result.FRetornoOk := False;
      End;
    End
    Else
    Begin
      If (intRetorno <> 1) And (intRetorno <> 0) Then
      Begin
        Result.FRetornoOk := False;
      End;
    End;
  End;
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoCTE(strDadosIntegracao: String): TWSNfeFitRetorno;
const
  ARQUIVO_RECEBIDO : Integer = 1;
  RETORNO_NAO_OK : Boolean = False;
var
  intRetorno: Integer;
begin
  Result := fComunicaWebService(FIT_COMANDO_ENVIO_CTE + 'CTE_FIT', strDadosIntegracao);
  If Result.FRetornoOk Then
  Begin
    intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', 2), -1);
    If not (intRetorno In [0,1]) Then
      Result := TWSNfeFitRetorno.Create(RETORNO_NAO_OK, Result.Texto);
  End;
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoCTE_CANC(strDadosIntegracao: String): TWSNfeFitRetorno;
const
  ARQUIVO_RECEBIDO : Integer = 5;
  RETORNO_NAO_OK : Boolean = False;
var
  intRetorno: Integer;
begin
  Result := fComunicaWebService('FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_CTE', strDadosIntegracao);
  If Result.FRetornoOk Then
  Begin
    intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', 8), -1);
    if (intRetorno <> ARQUIVO_RECEBIDO) then
      Result := TWSNfeFitRetorno.Create(RETORNO_NAO_OK, Result.Texto);
  End;
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoNFCE_CANC(strDadosIntegracao: String;
  strSufixo: String; strComando: String=''): TWSNfeFitRetorno;
  Var
    intRetorno: Integer;
    strCmd: String;
    strRetorno: String;
    strAcesso: String;
begin
  strCmd := FIT_COMANDO_ENVIO;
  If Not fEmptyStr(strComando) Then
    strCmd := strComando;

  Result := fComunicaWebService(strCmd+strSufixo, strDadosIntegracao);
  If (Assigned(Result)) And (Result.FRetornoOk) Then
  Begin
    strAcesso := fGetValorLinha(Result.Texto, '|', 7);
    strRetorno := fGetValorLinha(Result.Texto, '|', 8);
    intRetorno := StrToIntDef(strRetorno, -1);
    If (AnsiStartsText('NFE-CANC', strDadosIntegracao)) And ( (intRetorno = 9) Or (strRetorno = 'S') Or (strRetorno = strAcesso) ) Then
    Begin
      intRetorno := 1;
    End;
    If (intRetorno <> 1) And (intRetorno <> 0) Then
    Begin
      Result := TWSNfeFitRetorno.Create(False, Result.Texto);
    End;
  End;
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoDireto(strDadosIntegracao: String;
  strComando: String=FIT_COMANDO_ENVIO; strSufixo: String='NFE_FIT'): TWSNfeFitRetorno;
  Var
    intRetorno: Integer;
begin
  Result := fComunicaWebService(strComando + strSufixo, strDadosIntegracao);
  If Result.FRetornoOk Then
  Begin
    intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', 2), -1);
    If (intRetorno <> 1) Then
    Begin
      Result := TWSNfeFitRetorno.Create(False, Result.Texto);
    End;
  End;
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoMDFE(
  strDadosIntegracao: String): TWSNfeFitRetorno;
  Const
    //ARQUIVO_RECUSADO : Integer = 0;
    ARQUIVO_RECEBIDO : Integer = 1;
    RETORNO_NAO_OK : Boolean = False;
  Var
    intRetorno: Integer;
begin
  Result := fComunicaWebService(FIT_COMANDO_ENVIO + 'MDFE_FIT', strDadosIntegracao);
  If Result.FRetornoOk Then
  Begin
    intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', 2), -1);

    if (intRetorno <> ARQUIVO_RECEBIDO) then
      Result := TWSNfeFitRetorno.Create(RETORNO_NAO_OK, Result.Texto);
  End;
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoNFCE(
  strDadosIntegracao: String): TWSNfeFitRetorno;
  Var
    intRetorno: Integer;
    intTentativas: Integer;
    stlArq: TStringList;
  Const
    MAX_TENTATIVAS = 10;
begin

  If blnOffLine Then
  Begin
    Result := TWSNfeFitRetorno.Create(False, 'NFCe Off-Line');
    Exit;
  End;

  intTentativas := 0;
  Repeat
    Result := fComunicaWebService('FIT_NFE_ENVIA_TEXTO_AUTORIZACAO_FIT_NFCE', strDadosIntegracao);

    stlArq := TStringLIst.Create;
    Try
      stlArq.Add(Result.Texto);
    Finally
      Try
        stlArq.SaveToFile(fPnlDir('ULTIMO_RETORNO_WS_NFCE.TXT'));
      Except

      End;
      FreeAndNil(stlArq);
    End;

    If Result.FRetornoOk Then
    Begin
      intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', 8, True), -1);
      If (intRetorno <> 5) Then
      Begin
        Result := TWSNfeFitRetorno.Create(False, Result.Texto);

        If (intRetorno in [0,1,2,3]) Or (fEmptyStr(Result.Texto)) Then
        Begin
          Inc(intTentativas);
          Sleep(1500);
        End
        Else
        Begin
          Break;
        End;
      End;
    End
    Else
    Begin
      Break;
    End;
  Until (Result.RetornoOk) Or (intTentativas >= MAX_TENTATIVAS);
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoSAT_XML(strDadosIntegracao: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFE_ENVIA_XML_DISTRIBUICAO_SINC2', strDadosIntegracao);
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoServico(
  strDadosIntegracao: String): TWSNfeFitRetorno;
  Var
    intRetorno: Integer;
begin
  Result := fComunicaWebService(FIT_COMANDO_ENVIO + 'NFSE_FIT', strDadosIntegracao);
  If Result.FRetornoOk Then
  Begin
    intRetorno := StrToIntDef(fGetValorLinha(Result.Texto, '|', 2), -1);
    If (intRetorno <> 1) Then
    Begin
      If (Pos('nota fiscal já autorizada ou em processamento id', AnsiLowerCase(Result.Texto)) > 0) Then
      Begin
        Result := TWSNfeFitRetorno.Create(True, Result.Texto);
      End
      Else
      Begin
        Result := TWSNfeFitRetorno.Create(False, Result.Texto);
      End;
    End
  End;
end;

function TWSNFeFitWrapper.OnAfterExecute(SOAPResponse: WideString): WideString;
  Var
    xml: IXMLDocument;
    retornos: IXMLNodeList;
    intContador: Integer;

    strXml: String;
    intPos: Integer;

  function fArquivoListagemCTe: Boolean;
  begin
    Result := (Pos(WideString('spedDocumentoFiscal'), SOAPResponse) > 0) And
              (Pos(WideString('documentoFiscal'), SOAPResponse) > 0) And
              (Pos(WideString('NR_CHAVE_ACESSO'), SOAPResponse) > 0) And
              (Pos(WideString('XML'), SOAPResponse) > 0);
  end;

begin
  FUltimoRetorno := '';
  FUltimoRetornoCancelamento  := '';
  FUltimoRetornoCartaCorrecao := '';

  xml := TXMLDocument.Create(nil);
  Try
    Try
      xml.LoadFromXML(SOAPResponse);
      xml.Active := True;

      retornos := xml.Node.ChildNodes[0].ChildNodes[1].ChildNodes[0].ChildNodes;

      If retornos.Count > 0 Then
      Begin
        FUltimoRetorno := retornos[0].Text;
        For intContador := 1 To retornos.Count -1 Do
        Begin
          If (FSeparador <> '') Then
            FUltimoRetorno := FUltimoRetorno + FSeparador
          Else
            FUltimoRetorno := FUltimoRetorno + #13#10;

          FUltimoRetorno := FUltimoRetorno + retornos[intContador].Text;
        End;

        If (Not fArquivoListagemCTe) Then
        Begin
          For intContador := 0 To retornos.Count -1 Do
          Begin
            If Pos('<descEvento>Cancelamento</descEvento>', retornos[intContador].Text) > 0 Then
            Begin
              FUltimoRetornoCancelamento := fEscapeXml(retornos[intContador].Text);
            End;

            If Pos('<descEvento>Carta de Correcao</descEvento>', retornos[intContador].Text) > 0 Then
            Begin
              FUltimoRetornoCartaCorrecao := fEscapeXml(retornos[intContador].Text);
            End;
          End;
        End;
      End;
    Except
      Try
        pLogImp('OnAfterExecute(Except) '+SOAPResponse);

        strXml := SOAPResponse;

        intPos := Pos('<return>', strXml);
        strXml := Copy(strXml, intPos+Length('<return>'), Length(strXml));

        intPos := Pos('</return>', strXml);
        strXml := Copy(strXml, 1, intPos-1);

        FUltimoRetorno := fEscapeXml(strXml);

        pLogImp('OnAfterExecute(Except) '+FUltimoRetorno);
      Except
        //
      End;
    End;
  Finally
    Result := FUltimoRetorno;
  End;

  if FUltimoRetorno <> '' then
    pLogImp(FUltimoRetorno);

  if FUltimoRetornoCancelamento <> '' then
    pLogImp(FUltimoRetornoCancelamento);

  if FUltimoRetornoCartaCorrecao <> '' then
    pLogImp(FUltimoRetornoCartaCorrecao);
end;

function TWSNFeFitWrapper.fEscapeXml(const strXml: String): String;
begin
  Result := AnsiReplaceStr(strXml, '&lt;', '<');
  Result := AnsiReplaceStr(Result, '&quot;', '"');
  Result := AnsiReplaceStr(Result, '&gt;', '>');
end;

function TWSNFeFitWrapper.fEnviaTextoIntegracaoNFCE_XML_OFFLINE(strParametros: String): TWSNfeFitRetorno;
Var
  resultValidacao: TResultadoValidacao;
  strMsg: String;
  intStatus: Integer;
begin
  pCarregaWsFit;

  Result := fComunicaWebService('FIT_NFE_ENVIA_XML_LIBERACAO_NFCE_OFFLINE', strParametros);

  If Result.RetornoOk And (not blnOffLine) Then
  Begin
    intStatus := StrToIntDef(fGetValorLinha(Result.Texto, '|', 1), 4);

    If (intStatus = 4) Then
      Result := TWSNfeFitRetorno.Create(False, Result.Texto);
  End
  Else
  Begin
    strMsg := IIF(blnOffLine,'Não foi possível conectar no WebService da FIT para transmitir o XML, tente mais tarde.',
                             'Não foi possível transmitir o XML da NFCe Off-Line. Motivo: '+ Result.Texto);

    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao, True);
  End;
End;

function TWSNFeFitWrapper.fConsultaStatusDFe(strComando, strChaveAcesso: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService(strComando, strChaveAcesso);
end;

function TWSNFeFitWrapper.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): TWSNfeFitRetorno;
begin
  Result := fComunicaWebService('FIT_NFE_CONSULTA_RET_CANC_ID_NOTA_FISCAL', fRetornaIdNfeFit(strCodEmp, fNumDocEnvio(strNumDoc), strSerie, strEspDoc));
end;

{ TImpressaoPDF }

constructor TImpressaoPDF.Create(strComando, strPrefixo: String);
begin
  Self.strComando := strComando;
  Self.strPrefixo := strPrefixo;
end;

function TImpressaoPDF.fComandoWebService: String;
begin
  Result := strComando;
end;

function TImpressaoPDF.fExtensaoArquivo: String;
begin
  Result := '.pdf';
end;

function TImpressaoPDF.fPrefixoArquivo: String;
begin
  Result := strPrefixo;
end;

procedure TImpressaoPDF.pImprimeArquivo(strArquivo, strImpressora: String);
{$IFDEF LINUX}
begin
  Writeln('TImpressaoPDF.pImprimeArquivo não possui implementação linux');
end;
{$ELSE}
  Var
    info: SHELLEXECUTEINFO;
    titulo: Array[0..199] Of Char;
    strTitulo: String;
    handlePdf: Cardinal;
    tmrTempo: TDateTime;
    blnSair: Boolean;
    Pdir: Pchar;
  Const
    TIMEOUT = 30;

  procedure pSendMinimize;
  begin
    Try
      SendMessage(handlePdf, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    Except

    End;
  end;

  procedure pSendClose;
    Var
      intCont: Integer;
  begin
    For intCont := 1 To 3 Do
    Begin
      Try
        SendMessage(handlePdf, WM_CLOSE, 0, 0);
      Except

      End;
    End;
  end;

  procedure pChecaTempo(blnTimeout: Boolean);
  begin
    if SecondsBetween(nOw(), tmrTempo) > TIMEOUT then
    Begin
      if blnTimeout then
      Begin
        Raise ExceptionNFePrinter.Create('Timeout na impressão, por favor verifique o caminho da impressora nas ' +
          'configurações da Nota Eletrônica Citel.' + #13#10 +
          'Caso já esteja correto, feche o Acrobat Reader e tente novamente.');
      End
      Else
      Begin
        pSendClose;
        blnSair := True;
      End;
    End;

  end;

  function fPegaHandle(strTitulo, strDanfe: String): Cardinal;
  begin
    Result := FindWindow('AcrobatSDIWindow', Nil);
    if Result <= 0 then
      Result := FindWindow(Nil, PChar(strTitulo));

    if Result <= 0 then
      Result := FindWindow(Nil, PChar(strDanfe + ' - ' + strTitulo));
  end;

begin
  If (Not fEhParaImprimir(strImpressora)) Then
  Begin
    Exit;
  End;

  If Assigned(objVirtualUIPrintPDF) Then
    objVirtualUIPrintPDF.PrintPDF(strArquivo);

  blnSair := False;
  tmrTempo := nOw();
  info.cbSize := SizeOf(SHELLEXECUTEINFO);
  info.fMask := SEE_MASK_FLAG_DDEWAIT Or SEE_MASK_NOCLOSEPROCESS;
  info.lpVerb := PChar('printto');
  info.lpFile := PChar(strArquivo);
  info.lpDirectory := PChar(ExtractFileDir(strArquivo));
  info.lpParameters := PChar('"' + strImpressora + '"');
  info.nShow := SW_MINIMIZE;
  info.hInstApp := 0;
  info.hProcess := 0;

  Try
    if (strImpressora = 'ImpressaoEmTelaPDF') then
    begin
      GetMem(Pdir, 256);
      StrPCopy(Pdir, strArquivo);
      shellExecute(0, nil, PChar(strArquivo), nil, Pdir, SW_NORMAL);
      FreeMem(Pdir, 256);
    end
    else
    begin
      ShellExecuteEx(@info);
    end;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao enviar documento para impressora.' + #13#10 +
        'Por favor, reenvie a nota.');
    End;
  End;

  If (info.hInstApp > 32) Then
  Begin

    Repeat
      handlePdf := fPegaHandle('Adobe Reader', ExtractFileName(strArquivo));
      If handlePdf > 0 Then
      Begin
        GetWindowText(handlePdf, titulo, 200);
        strTitulo := StrPas(titulo);
      End;
      Application.ProcessMessages;
      pChecaTempo(False);
    Until (handlePdf > 0) Or (blnSair);

    pSendMinimize;

    Repeat
      If handlePdf > 0 Then
      Begin
        GetWindowText(handlePdf, titulo, 200);
        strTitulo := StrPas(titulo);
      End;
      Application.ProcessMessages;
      pSendMinimize;
      sleep(100);
      pChecaTempo(False);
    Until ((Pos(ExtractFileName(strArquivo), strTitulo) > 0) And (handlePdf > 0)) Or (blnSair);

    Repeat
      If handlePdf > 0 Then
      Begin
        GetWindowText(handlePdf, titulo, 200);
        strTitulo := StrPas(titulo);
        pSendMinimize;
      End;
      pChecaTempo(False);
      Application.ProcessMessages;
    Until ((Pos(ExtractFileName(strArquivo), strTitulo) <= 0) And (handlePdf > 0)) Or (blnSair);

    TerminateProcess(info.hProcess, 0);
    pSendClose;

  End;

end;
{$ENDIF}

{ TMetodoImpressaoFactory }

class function TMetodoImpressaoFactory.fCriarCartaCorrecao(strPrefixo: String): IMetodoImpressao;
begin
  If VS_PDFtoPrinter Then
  Begin
    If Not FileExists(fRetNomeArquivoPDFtoPrinter) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DANFE_CCE_CHAVE_ACESSO', strPrefixo);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DANFE_CCE_CHAVE_ACESSO', strPrefixo);
    End;
  End
  Else
  Begin
    If (Not FileExists(fRetNomeArquivoNfePrinterExe)) And (Not FileExists(fRetNomeArquivoFitPrinterJar)) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DANFE_CCE_CHAVE_ACESSO', strPrefixo);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DANFE_SERIAL_CCE_CHAVE_ACESSO_V2', strPrefixo);
    End;
  End;
end;

class function TMetodoImpressaoFactory.fCriarConhecimento(strForcarImpressaoPDF: String = 'N'): IMetodoImpressao;
const
  PREFIXO_ARQ_CTE = 'CTE_';
begin
  If VS_PDFtoPrinter Then
  Begin
    If Not FileExists(fRetNomeArquivoPDFtoPrinter) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_CTE_DACTE_ID_CONHECIMENTO_TRANSPORTE', PREFIXO_ARQ_CTE);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_CTE_DACTE_ID_CONHECIMENTO_TRANSPORTE', PREFIXO_ARQ_CTE);
    End;
  End
  Else
  Begin
    If ((Not FileExists(fRetNomeArquivoNfePrinterExe)) And (Not FileExists(fRetNomeArquivoFitPrinterJar))) or (strForcarImpressaoPDF = 'S') Then
    Begin
      Result := TImpressaoPDF.Create('FIT_CTE_DACTE_ID_CONHECIMENTO_TRANSPORTE', PREFIXO_ARQ_CTE);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DACTE_SERIAL_ID_CONHECIMENTO', PREFIXO_ARQ_CTE);
    End;
  End;
end;

class function TMetodoImpressaoFactory.fCriarManifesto: IMetodoImpressao;
  Const
    PREFIXO_ARQ_MDFE = 'MDFE_';
begin
  If VS_PDFtoPrinter Then
  Begin
    If Not FileExists(fRetNomeArquivoPDFtoPrinter) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DAMDFE_ID_MANIFESTO', PREFIXO_ARQ_MDFE);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DAMDFE_ID_MANIFESTO', PREFIXO_ARQ_MDFE);
    End;
  End
  Else
  Begin
    If (Not FileExists(fRetNomeArquivoNfePrinterExe)) And (Not FileExists(fRetNomeArquivoFitPrinterJar)) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DAMDFE_ID_MANIFESTO', PREFIXO_ARQ_MDFE);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DAMDFE_SERIAL_ID_MANIFESTO', PREFIXO_ARQ_MDFE);
    End;
  End;
end;

class function TMetodoImpressaoFactory.fCriarNotaFiscal(strPrefixo: String): IMetodoImpressao;
begin
  If VS_PDFtoPrinter Then
  Begin
    If (strPrefixo = 'Tela') Or (Not FileExists(fRetNomeArquivoPDFtoPrinter)) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DANFE_CHAVE_ACESSO', strPrefixo);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DANFE_ID_NOTA_FISCAL', strPrefixo);
    End;
  End
  Else
  Begin
    If (strPrefixo = 'Tela') Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DANFE_CHAVE_ACESSO', strPrefixo);
    End
    Else if ((Not FileExists(fRetNomeArquivoNfePrinterExe)) And (Not FileExists(fRetNomeArquivoFitPrinterJar))) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFE_DANFE_ID_NOTA_FISCAL', strPrefixo);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFE_DANFE_SERIAL_ID_NOTA_FISCAL_V2', strPrefixo);
    End;
  End;
end;

class function TMetodoImpressaoFactory.fCriarNotaServico(strPrefixo: String): IMetodoImpressao;
begin
  If VS_PDFtoPrinter Then
  Begin
    If Not FileExists(fRetNomeArquivoPDFtoPrinter) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFSE_DANFE_ID_NOTA_FISCAL', strPrefixo);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFSE_DANFE_ID_NOTA_FISCAL', strPrefixo);
    End;
  End
  Else
  Begin
    If (Not FileExists(fRetNomeArquivoNfePrinterExe)) And (Not FileExists(fRetNomeArquivoFitPrinterJar)) Then
    Begin
      Result := TImpressaoPDF.Create('FIT_NFSE_DANFE_ID_NOTA_FISCAL', strPrefixo);
    End
    Else
    Begin
      Result := TImpressaoDireta.Create('FIT_NFSE_DANFE_SERIAL_ID_NOTA_FISCAL_V2', strPrefixo);
    End;
  End;
end;

{ TImpressaoDireta }

constructor TImpressaoDireta.Create(strComando, strPrefixo: String);
begin
  Self.strComando := strComando;
  Self.strPrefixo := strPrefixo;

  strArquivoNfePrinterExe := fRetNomeArquivoNfePrinterExe;
  strArquivoFitPrinterJar := fRetNomeArquivoFitPrinterJar;
  strArquivoPDFtoPrinter  := fRetNomeArquivoPDFtoPrinter;
end;

function TImpressaoDireta.fComandoWebService: String;
begin
  Result := strComando;
end;

function TImpressaoDireta.fExtensaoArquivo: String;
begin
  If VS_PDFtoPrinter Then
    Result := '.pdf'
  Else
    Result := '.zip';
end;

function TImpressaoDireta.fPrefixoArquivo: String;
begin
  Result := strPrefixo;
end;

procedure TImpressaoDireta.pImprimeArquivo(strArquivo, strImpressora: String);
{$IFDEF LINUX}
begin
  Writeln('TImpressaoDireta.pImprimeArquivo não possui implementação linux');
end;
{$ELSE}
  Var
    strCMD: String;
begin
  If (Not fEhParaImprimir(strImpressora)) Then
  begin
    Exit;
  end;

  If fEmptyStr(strImpressora) Or (Pos('>>',strImpressora) > 0) Then
  Begin
    Try
      strImpressora := Printer.Printers[Printer.PrinterIndex];
    Except
      On E: Exception Do
      Begin
        pLogImp('ERRO: '+E.Message);
        Exit;
      End;
    End;
  End;

  If (UpperCase(strImpressora) = 'EXPORTAR PARA PDF') Then
  Begin
    ShellExecute(0, NIL, PChar(strArquivo), NIL, '', SW_NORMAL);
  End
  Else
  Begin
    If VS_PDFtoPrinter Then
      strCMD := strArquivoPDFtoPrinter + ' ' + strArquivo + ' "' + strImpressora + '"'
    Else If FileExists(strArquivoFitPrinterJar) Then
      strCMD := ExtractFileDir(strArquivoFitPrinterJar) + PATH_SEPARATOR + 'jre6' + PATH_SEPARATOR + 'bin' + PATH_SEPARATOR + 'java -jar ' + strArquivoFitPrinterJar + ' ' + strArquivo + ' "' + strImpressora + '" 1'
    Else
      strCMD := strArquivoNfePrinterExe + ' ' + strArquivo + ' "' + strImpressora + '" 1';

    WinExec(PAnsiChar(AnsiString(strCMD)), SW_HIDE);

    pLogImp('COMANDO USADO: '+strCMD);
  End;
end;
{$ENDIF}

{ TImpressaoIntegradorLocal }

constructor TImpressaoIntegradorLocal.Create(fitWrapper: TWSNFeFitWrapper;
  strIntegrador, strImpressora: String);
begin
  Self.fitWrapper := fitWrapper;
  Self.strIntegrador := strIntegrador;
  Self.strImpressora := strImpressora;
end;

procedure TImpressaoIntegradorLocal.pImprime(strIdNota: String);
  Var
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
begin
  strTexto := strIntegrador + '|' + strImpressora + '|' + strIdNota + '|' + objConfig.strCodEmp;
  retornoFit := fitWrapper.fComunicaWebService('FIT_NFE_IMPRIME_DANFE_SERIAL_INTEGRADOR', strTexto);

  If Not retornoFit.RetornoOk Then
  Begin
    Raise Exception.Create('Houve um erro ao enviar a impressão: ' + retornoFit.Texto);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

{ TImpressaoDiretaCitel }

class procedure TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo: String; blnReimpressao: Boolean = False);
begin
 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Imprimindo ' + strTipo + ', aguarde ...');
 {$IFEND}
  untImpressaoDiretaCitel.TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo, blnReimpressao, VS_PidMD5DicSis);
end;

class procedure TImpressaoDiretaCitel.pImprimirPDF(strCodigoEmpresa,
                                                  strImpressora,
                                                  strAcesso,
                                                  strTipo           : String;
                                                  blnReimpressao    : Boolean = False;
                                                  strPDF_Diretorio  : String  = '';
                                                  blnPDF_Apresentar : Boolean = False);
begin
  untImpressaoDiretaCitel.TImpressaoDiretaCitel.pImprimirPDF(strCodigoEmpresa,
                                                             strImpressora,
                                                             strAcesso,
                                                             strTipo,
                                                             blnReimpressao,
                                                             strPDF_Diretorio,
                                                             blnPDF_Apresentar,
                                                             VS_PidMD5DicSis);
end;

//Atenção: NfeApiWSBean existe em libNefe.dll e NFeImpressao então, ao mudar algo na classe TNfeApiWS, alterar em ambos projetos!

{ TNfeApiWS }

constructor TNfeApiWS.Create(strUrl: String; fOnAfterExecute: TAfterExecute; AmodeEnvSoap: TmodeEnvSoap);
begin
  Self.fOnAfterExecute := fOnAfterExecute;
  Self.FstrUrl := strUrl;
  Self.FstrNms := 'http://server.api.ws.nfe.fitsistemas.com.br/';
  If Pos('citel.com.br', AnsiLowerCase(Self.FstrUrl)) > 0 Then
    Self.FstrNms := 'https://'+fExtraiHostDaUrl(Self.FstrUrl)+'/';
  Self.FmodeEnvSoap := AmodeEnvSoap;
end;

destructor TNfeApiWS.Destroy;
begin
  inherited;
end;

function TNfeApiWS.fMontaRetornaEnvelope(const servico, nr_licenca, nm_usuario, nm_senha,
  nm_servico, dados: WideString): WideString;
  Var
    LTeor: WideString;
begin
  LTeor := dados;

  If fIsXml(LTeor) Then
    LTeor := '<![CDATA['+LTeor+']]>';

  Result :=
    '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="'+FstrNms+'">'+
    '   <soapenv:Header/>'+
    '   <soapenv:Body>'+
    '      <ser:'+servico+'>'+
    '         <nr_licenca>'+nr_licenca+'</nr_licenca>'+
    '         <nm_usuario>'+nm_usuario+'</nm_usuario>'+
    '         <nm_senha>'+nm_senha+'</nm_senha>'+
    '         <nm_servico>'+nm_servico+'</nm_servico>'+
    '         <dados>'+LTeor+'</dados>'+
    '      </ser:'+servico+'>'+
    '   </soapenv:Body>'+
    '</soapenv:Envelope>';
end;

function TNfeApiWS.fDecodeBase64ToByteDynArray(const strBase64: AnsiString): TByteDynArray;
  Var
    {$IF RTLVersion >= 27}
    mmsArquivo: TBytesStream;
    {$ELSE}
    mmsArquivo: TStringStream;
    {$IFEND}
begin
  If (strBase64 = '') Then
    Raise ESOAPDomConvertError.Create('String base64 vazia');

  Try
    {$IF RTLVersion >= 27}
    mmsArquivo := TBytesStream.Create(DecodeBase64(strBase64));
    {$ELSE}
    mmsArquivo := TStringStream.Create(DecodeString(strBase64));
    {$IFEND}
    Try
      mmsArquivo.Position := 0;
      SetLength(Result, mmsArquivo.Size);
      mmsArquivo.Read(Result[0], mmsArquivo.Size);
    Finally
      mmsArquivo.Free;
    End;
  Except
    On E: Exception Do
      Raise ESOAPDomConvertError.Create('Erro na conversão da string base64 '+E.Message);
  End;
end;

procedure TNfeApiWS.pLevantaExcecao(intRespHttp: Integer; strResponse, strExcecao_: WideString);
begin
  If (intRespHttp >= 200) And (intRespHttp <= 299) Then
  Begin
    If (Pos('envelope', LowerCase(strResponse)) = 0) Then
    Begin
      Raise ESOAPHTTPException.Create('Não encontrado conteúdo SOAP na resposta');
    End;
  End
  Else If (intRespHttp = 0) Or (intRespHttp >= 500) Or (strExcecao_ <> '') Then
  Begin
    pLogImp('pLevantaExcecao > intRespHttp: '+IntToStr(intRespHttp) + ' - strResponse: ' + strResponse + ' - strExcecao_: ' + strExcecao_);
    Raise ESOAPHTTPException.Create('Falha na conexão HTTP - Exceção: '+strExcecao_)
  End;
end;

function TNfeApiWS.fIsXml(const strCmd: WideString): Boolean;
 Var
  aXMLDoc: IXMLDocument;
begin
  Result := False;
  If (Pos('<',strCmd) > 0) Then
  Begin
    pLogImp('fIsXml('+strCmd+')');
    aXmlDoc := TXMLDocument.Create(nil);
   {$IFNDEF LINUX}
    aXmlDoc.ParseOptions := [poValidateOnParse, poResolveExternals];
   {$ELSE}
    aXmlDoc.ParseOptions := [];
   {$ENDIF}
    Try
      aXmlDoc.LoadFromXML(strCmd);
      Result := True;
      pLogImp('fIsXml = Sim');
    Except
      pLogImp('fIsXml = Não');
    End;
  End;
end;

function TNfeApiWS.NfeEnviaRecebeDados(const nr_licenca, nm_usuario, nm_senha,
  nm_servico, dados: WideString): WideString;
  Var
    strEnvelope: WideString;
    strResponse: WideString;
    strExcecao_: WideString;
    intRespHttp: Integer;
begin
  Try
    strEnvelope := fMontaRetornaEnvelope(FIT_SERVICO_WS_NFEENVIARECEBEDADOS, nr_licenca, nm_usuario, nm_senha, nm_servico, dados);

    pLogImp('Env > fExecuteSoapWithMode: '+fModeEnvSoapToString(FmodeEnvSoap)+' '+nm_servico+' '+strEnvelope);

    intRespHttp := fExecuteSoapWithMode(Self.FstrUrl,
                                        TLS12,
                                        Self.FmodeEnvSoap,
                                        strEnvelope,
                                        strResponse,
                                        strExcecao_);

    pLogImp('Ret < fExecuteSoapWithMode: '+nm_servico+' ['+'HTTPCode: '+IntToStr(intRespHttp)+'] '+strResponse);

    pLevantaExcecao(intRespHttp, strResponse, strExcecao_);

    Result := Self.fOnAfterExecute(strResponse);
  Except
    On E: Exception Do
    Begin
      pLogImp('Exception - fExecuteSoapWithMode: '+E.Message);
      Raise;
    End;
  End;
end;

function TNfeApiWS.NfeRecebeDanfe(const nr_licenca, nm_usuario, nm_senha,
  nm_servico, dados: WideString): TByteDynArray;
  Var
    strEnvelope: WideString;
    strResponse: WideString;
    strExcecao_: WideString;
    intRespHttp: Integer;
begin
  Try
    strEnvelope := fMontaRetornaEnvelope(FIT_SERVICO_WS_NFERECEBEDANFE, nr_licenca, nm_usuario, nm_senha, nm_servico, dados);

    pLogImp('Env > fExecuteSoapWithMode: '+fModeEnvSoapToString(FmodeEnvSoap)+' '+nm_servico+' '+strEnvelope);

    intRespHttp := fExecuteSoapWithMode(Self.FstrUrl,
                                        TLS12,
                                        Self.FmodeEnvSoap,
                                        strEnvelope,
                                        strResponse,
                                        strExcecao_);

    pLogImp('Ret < fExecuteSoapWithMode: '+nm_servico+' ['+'HTTPCode: '+IntToStr(intRespHttp)+'] '+strResponse);

    pLevantaExcecao(intRespHttp, strResponse, strExcecao_);

    Result := fDecodeBase64ToByteDynArray(AnsiString(Self.fOnAfterExecute(strResponse)));
  Except
    On E: Exception Do
    Begin
      pLogImp('Exception - fExecuteSoapWithMode: '+E.Message);
      Raise;
    End;
  End;
end;

initialization
{$IFNDEF LINUX}
  CoInitialize(Nil);
{$ENDIF}

finalization
{$IFNDEF LINUX}
  CoUninitialize;
{$ENDIF}

end.
