unit untNFEServiceImpl;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Forms, Dialogs,
{$ENDIF}
  untInterfaces, untFonteDados, untValidadorNFE,  Classes,
  DB, untUtil, untVerificaIntegradorNFe, StrUtils, IdHTTP,
  IdSSLOpenSSL, IdSSLOpenSSLHeaders;

Type
  INFEFactory = interface
    function CreateNFE(fonteDados: IFonteDados): INFE;
    function CreateNFEnt(fonteDados: IFonteDados): INFE;
    function CreateValidadorItem: IValidadorItem;
  end;

  TNFEFactory = class(TInterfacedObject, INFEFactory)
    function CreateNFE(fonteDados: IFonteDados): INFE;
    function CreateNFEnt(fonteDados: IFonteDados): INFE;
    function CreateValidadorItem: IValidadorItem;
    function fAmbienteOffLine(strURL: String): Boolean;
  private

  End;

  TNFESFactory = class(TInterfacedObject, INFEFactory)
    function CreateNFE(fonteDados: IFonteDados): INFE;
    function CreateNFEnt(fonteDados: IFonteDados): INFE;
    function CreateValidadorItem: IValidadorItem;
  End;

  TNFSEnotasFactory = class(TInterfacedObject, INFEFactory)
    function CreateNFE(fonteDados: IFonteDados): INFE;
    function CreateNFEnt(fonteDados: IFonteDados): INFE;
    function CreateValidadorItem: IValidadorItem;
  End;

Type
  TNFEServiceImpl = class(TInterfacedObject, INFEService, INFEAdministrativoService)
    private
      NFE: INFE;
      fonte: IFonteDados;
      formatador: IFonteDadosFormatador;
      validador: IValidadorNFE;
    public
      constructor Create(fonteDados: IFonteDados;
        formatadorFD: IFonteDadosFormatador;
        validadorNFE: IValidadorNFE;
        NFE: INFE);
      destructor Destroy; override;

      function fEnviarNota: Boolean;
      function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
      function fRetXmlNfe(strChaveAcesso: string): string;
      function fProcessarEnvio: TRetornoNFE;
      function fProcessarCancelamento: TRetornoNFE;

      function fVerificarStatusNota(strNumDoc, strSerie: String): Boolean;
      function fProcessarStatusNota: TRetornoNFE;

      function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String): TRetornoStatusNFE; overload;

      procedure pReimprimirDanfe(strChaveAcesso: String); overload;

      function fMensagemErro: String;

      function fSuportaFuncoesAdministrativas: Boolean;
      procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer);
      procedure pReimprimirDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = ''); overload;
      procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
        strNumeroFinal, strDescricao: String);

      function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
        intTipo, intStatus: Integer): TStringList;
      function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
      function fEnviaNFCeXmlOffLine: Boolean;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

      function fCarregarNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): String;

      function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;

      function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

      procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

      function fConsultaStatusDFe(strChaveAcesso: string): String;
      function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
      function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;

      function fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

      function fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
  End;

implementation

uses
  SysUtils, untNFESFit, untNFEFit400, untNFEFit400Ent,
  untSATCFE, untNFCEFit400, untNFSEnotas, untConstantesNFe;

{ TNFEServiceImpl }

constructor TNFEServiceImpl.Create(fonteDados: IFonteDados;
  formatadorFD: IFonteDadosFormatador;
  validadorNFE: IValidadorNFE;
  NFE: INFE);
begin
  fonte := fonteDados;
  Self.NFE := NFE;
  formatador := formatadorFD;
  validador := validadorNFE;
end;

destructor TNFEServiceImpl.Destroy;
begin
  //
  inherited;
end;

function TNFEServiceImpl.fRetXmlNfe(strChaveAcesso: string): string;
begin
  Result := NFE.fRetXmlNfe(strChaveAcesso);
End;

function TNFEServiceImpl.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
Begin
  Result := NFE.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
End;

function TNFEServiceImpl.fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
  Var
    resultadoValidacao: TResultadoValidacao;
begin
  resultadoValidacao := validador.fValidarCancelamento(strMotivo);
  If Not resultadoValidacao.fValido Then
    Raise ErrosValidacaoNFE.Create('Houveram erros durante o envio do cancelamento.',
      resultadoValidacao);

  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);

  Result := NFE.fCancelarNota(strNumDoc, strSerie, strMotivo);

  If Assigned(resultadoValidacao) Then
    FreeAndNil(resultadoValidacao);
end;

function TNFEServiceImpl.fCarregarNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): String;
begin
  Result := NFE.fCarregaNfePdf(AChaveAcesso, ANomeArquivo, AExtensao, AIgnorarLayoutSimplificado);
end;

function TNFEServiceImpl.fConsultaCadastro(strUf, strCnpj,
  strIe: String): TRetornoConsultaCadastro;
begin
  Result := NFE.fConsultaCadastro(strUf, strCnpj, strIe);
end;

function TNFEServiceImpl.fEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  Result := NFE.fEnviaCartaCorrecao(strChaveAcesso, stlCorrecoes, strImpressora, intSequencial);
end;

function TNFEServiceImpl.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := NFE.fEnviaNFCeXmlOffLine;
End;

function TNFEServiceImpl.fEnviarNota: Boolean;
  Var
    resultadoValidacao: TResultadoValidacao;
begin
  fonte.pCarregarDados;
  fonte.pInicio;

  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);

  fonte.pInicio;
  While (formatador.fTemDados) Do
  Begin
    NFE.pAdicionaItem(formatador.fFormataDadosItem);
  End;

  resultadoValidacao := validador.fValidarEnvio(fonte);
  If Not resultadoValidacao.fValido Then
    Raise ErrosValidacaoNFE.Create('Houve erros durante o envio da nota fiscal eletronica.',
      resultadoValidacao);

  Result := NFE.fEnviarNota;

  If Assigned(resultadoValidacao) Then
    FreeAndNil(resultadoValidacao);
end;

function TNFEServiceImpl.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
begin
  Result := NFE.fListagemNotas(strCodEmp, dtaDtaIni, dtaDtaFin, intTipo, intStatus);
end;

function TNFEServiceImpl.fMensagemErro: String;
begin
  Result := NFE.fMensagemErro;
end;

function TNFEServiceImpl.fProcessarEnvio: TRetornoNFE;
begin
  fonte.pCarregarDados;
  fonte.pInicio;
  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);
  Result := NFE.fProcessarEnvio;
end;

function TNFEServiceImpl.fVerificarStatusNota(strNumDoc,
  strSerie: String): Boolean;
begin
  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);
  Result := NFE.fVerificarStatusNota;
end;

function TNFEServiceImpl.fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String): TRetornoStatusNFE;
begin
  Result := NFE.fVerificarStatusServico(strCnpjEmitente, strIESEmitente);
end;

function TNFEServiceImpl.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := NFE.fVerificarStatusServico(strCnpjEmitente, strIESEmitente, strRetornoConsulta);
end;

function TNFEServiceImpl.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := NFE.fSuportaFuncoesAdministrativas;
end;

procedure TNFEServiceImpl.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  fonte.pCarregarDados;
  NFE.pEnviaCartaCorrecao(strChaveAcesso, stlCorrecoes, strImpressora, intSequencial);
end;

procedure TNFEServiceImpl.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
begin
  fonte.pCarregarDados;
  NFE.pInutilizarNumeros(strAno, strSerie, strNumeroInicial, strNumeroFinal,
    strDescricao);
end;

procedure TNFEServiceImpl.pReimprimirDanfe(strChaveAcesso,
  strImpressora: String; strImprimirTelaPDF: String = '');
begin
  NFE.pReimprimeDanfe(strChaveAcesso, strImpressora, strImprimirTelaPDF);
end;

procedure TNFEServiceImpl.pReimprimirDanfe(strChaveAcesso: String);
begin
  NFE.pReimprimeDanfe(strChaveAcesso);
end;

function TNFEServiceImpl.fProcessarStatusNota: TRetornoNFE;
begin
  fonte.pCarregarDados;
  fonte.pInicio;
  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);
  Result := NFE.fProcessarStatusNota;
end;

function TNFEServiceImpl.fProcessarCancelamento: TRetornoNFE;
begin
  fonte.pCarregarDados;
  fonte.pInicio;
  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);
  Result := NFE.fProcessarCancelamento;
end;

procedure TNFEServiceImpl.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin
  fonte.pCarregarDados;
  fonte.pInicio;
  formatador.pSetaFonteDados(fonte);

  NFE.pSetaDadosEmitente(formatador.fFormataDadosEmitente);
  NFE.pSetaDadosGerais(formatador.fFormataDadosGerais);
  NFE.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso);
end;

function TNFEServiceImpl.fConsultaStatusDFe(strChaveAcesso: string): String;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fConsultaStatusDFe(strChaveAcesso);
end;

function TNFEServiceImpl.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fConsultaStatusCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie);
end;

function TNFEServiceImpl.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento: String; const strModeloFiscal : String = '55'): String;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fConsultaStatusInutilizado(strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strModeloFiscal);
end;

function TNFEServiceImpl.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData);
end;

function TNFEServiceImpl.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie);
end;

function TNFEServiceImpl.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData);
end;

function TNFEServiceImpl.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  formatador.pSetaFonteDados(fonte);
  Result := NFE.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie);
end;

{ TNFEFactory }

function TNFEFactory.CreateNFE(fonteDados: IFonteDados): INFE;
  Var
    strArquivo: String;
    strPathOpcoes: String;
    blnOffLine: Boolean;
    strMsgErr: String;
    strModeEnvSoap: String;
begin
  pLogImp('TNFEFactory.CreateNFE >');

  strArquivo := '';

  fonteDados.pCarregarDados;

  VS_PDFtoPrinter := fUtilizaPDFtoPrinter(fonteDados);

  If (fonteDados.fDadosGerais.strEspDoc = 'IF') And
     (fCfgSisFonte(fonteDados, 'USASAT') = 'S') Then
  Begin
    pLogImp('VS_PathSat: ' + VS_PathSat );
    If Not fEmptyStr(VS_PathSat) Then
    Begin
      strPathOpcoes := VS_PathSat;
    End
    Else
    Begin
      strPathOpcoes := fCfgSisFonte(fonteDados, 'PATSAT');
    End;
    pLogImp('strPathOpcoes: ' + strPathOpcoes );

    If (Not fEmptyStr(fArqIniLocal(0, 'SATCFE', 'PDV', '', strPathOpcoes + PATH_SEPARATOR + 'opcoes_sat.ini'))) Then
    Begin
      Result := TSATCFE.Create(fonteDados);
      pLogImp('TNFEFactory.CreateNFE < TSATCFE.Create(fonteDados); Exit;');
      Exit;
    End
    Else If DirectoryExists(strPathOpcoes) Then
    Begin
      strMsgErr := 'Atenção: configurado para utilizar SAT mas não foi possível ler as ' +
        'configurações do arquivo em ' + strPathOpcoes + '. Por favor, verifique.';

      pLogImp(strMsgErr);
      Raise Exception.Create(strMsgErr);
    End
    Else
    Begin
      pLogImp('TNFEFactory.CreateNFE: Abortada');
      Abort;
    End;
  End;

  If fCfgSisFonte(fonteDados,'USAOFF') = 'S' Then
    blnOffLine := fAmbienteOffLine(fCfgSisFonte(fonteDados,'URLOFF'))
  Else
    blnOffLine := False;

  strModeEnvSoap := fCfgSisFonte(fonteDados, 'MDEVAR');

  If blnOffLine Then
    fonteDados.pNFCeOffLineConfiguracoes(fonteDados.fDadosGerais.strCodEmp);

  pCarregaVerificadorVersaoNFe(fonteDados.fDadosEmitente.strCnpj, blnOffLine, strModeEnvSoap);

  If (fonteDados.fDadosGerais.strEspDoc = 'IF') Then
    Result := TNFCEFit400.Create(fonteDados, blnOffLine)
  Else
    Result := TNFEFit400.Create(fonteDados);

  pLogImp('TNFEFactory.CreateNFE <');
end;

function TNFEFactory.CreateNFEnt(fonteDados: IFonteDados): INFE;
begin
  fonteDados.pCarregarDados;
  Result := TNFEFit400Ent.Create(fonteDados);
end;

function TNFEFactory.CreateValidadorItem: IValidadorItem;
  Var
    strArquivo: String;
begin
  strArquivo := '';

  Result := TNFEValidadorItem200.Create;
end;

function TNFEFactory.fAmbienteOffLine(strURL: String): Boolean;
var wsHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
Begin
 {$IFDEF LINUX}
  IdOpenSSLSetLibPath(GetCurrentDir);//Forçar libcrypto.so e libssl.so da pasta do programa.
 {$ENDIF}

  IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  wsHTTP := TIdHTTP.Create(Application);
  Try
    Try
     {$IF Defined(VER250) Or Defined(UNIDAC)}
     IdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
     {$IFEND};

      wsHTTP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
      wsHTTP.ReadTimeout    := 10000;
      wsHTTP.ConnectTimeout := 10000;
      wsHTTP.Get(strURL);
      result := not wsHTTP.Connected;
    Except
      On E: Exception Do
      Begin
        result := (Pos('Already connected', E.Message) = 0);
      End;
    End;
  Finally
    FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
    FreeAndNil(wsHTTP);
  End;
End;

{ TNFESFactory }

function TNFESFactory.CreateNFE(fonteDados: IFonteDados): INFE;
begin
  Result := TNFESFit.Create(fonteDados);
end;

function TNFESFactory.CreateNFEnt(fonteDados: IFonteDados): INFE;
begin
  Result := TNFESFit.Create(fonteDados);
end;

function TNFESFactory.CreateValidadorItem: IValidadorItem;
begin
  Result := TNFESValidadorPainelFiscal.Create;
end;

{ TNFSEnotasFactory }

function TNFSEnotasFactory.CreateNFE(fonteDados: IFonteDados): INFE;
begin
  Result := TNFSEnotas.Create(fonteDados);
end;

function TNFSEnotasFactory.CreateNFEnt(fonteDados: IFonteDados): INFE;
begin
  Result := TNFSEnotas.Create(fonteDados);
end;

function TNFSEnotasFactory.CreateValidadorItem: IValidadorItem;
begin
  Result := TNFESValidadorPainelFiscal.Create;
end;

end.
