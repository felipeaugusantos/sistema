unit untGNREWebService;

interface

Uses Classes, Forms, SysUtils, Uni, Data.DB,
     Windows, untFuncoesSimples, CAPICOM_TLB, Soap.Win.CertHelper, Winapi.WinInet,
     Winapi.ActiveX, Soap.SOAPHTTPTrans, HTTPSend, blcksock, synautil, ssl_openssl,
     Xml.XMLDoc, Xml.XMLIntf, System.StrUtils, untFuncoes, untTypesSistema, System.JSON;

Type
  TConexao     = (EmbarcaderoHttpReqResp, SynapseHttpSend);
  TWebService  = (GnrePernambuco, GnreEspiritoSanto, GnreSaoPaulo);
  TWebServicePernambucoVersao = (Versao1, Versao2);

  TConfiguracoes = Record
    GnreSt : String;
    GnreDf : String;
    GnreFc : String;
    GnrePagarSt : String;
    GnrePagarDf : String;
    GnrePagarFc : String;
    GnreForSt : String;
    GnreForDf : String;
    GnreForFc : String;
    GnrePorSt : String;
    GnrePorDf : String;
    GnrePorFc : String;
    DuaReceitaSt : String;
    DuaReceitaDf : String;
    DuaReceitaFc : String;
    DareReceitaSt : String;
    DareReceitaDf : String;
    DareReceitaFcpOp : String;
    DareReceitaFcpSt : String;
    DareReceitaFcpDf : String;
    DareServicoSt : String;
    DareServicoDf : String;
    DareServicoFcpOp : String;
    DareServicoFcpSt : String;
    DareServicoFcpDf : String;
    DareApiKey : String;
    UsarCapicom: Boolean;
    UsarCapicomArquivoPFX: Boolean;
    CertificadoArquivoPFX: String;
    CertificadoArquivoPEM: String;
    CertificadoArquivoKEY: String;
    CertificadoSenha: String;
    SerialCertificado: String;
    Homologacao: Boolean;
    GnreApuracao: Boolean;
    ToleranciaBoleto : Double;
  End;

  TDadosGuia = Record
    UfFavorecida : String;
    DataEmissao: String;
    DataVencimento: String;
    DataPagamento: String;
    ValorICMS: String;
    ValorFECP: String;
    ValorGNRE: String;
    ValorST: Double;
    ValorDIFAL: Double;
    ChaveDeAcesso: String;
    ChaveDeApuracao: String;
    CodigoDaReceita: String;
    NotaFiscal: String;
    Identificacao: String;
    CadFisAutoincrem: String;

    ContribuinteEmitenteCNPJ: String;
    ContribuinteEmitenteIE: String;
    ContribuinteEmitenteRazaoSocial: String;
    ContribuinteEmitenteEndereco: String;
    ContribuinteEmitenteMunicipio: String;
    ContribuinteEmitenteUf: String;
    ContribuinteEmitenteCep: String;
    ContribuinteEmitenteTelefone: String;

    ContribuinteDestinatarioTipoPessoa: String;
    ContribuinteDestinatarioCnpj: String;
    ContribuinteDestinatarioInscrEstadual: String;
    ContribuinteDestinatarioRazaoSocial: String;
    ContribuinteDestinatarioMunicipio: String;
    ContribuinteDestinatarioMunicipioEspiritoSanto: String;
  End;

  TComponente = Record
    TimeOut : Integer;
    URL     : String;
    XML     : String;
    SoapAction : String;
    MimeType : String;
  End;

  TBoleto = Record
    DataVencimento  : String;
    LinhaDigitavel  : String;
    CodigoDeBarras  : String;
    QrCode          : String;
    NumeroDeControle: String;
    Valor           : Double;
    Juros           : Double;
    Multa           : Double;
  End;

  TRetorno = Record
    XML            : String;
    Recibo         : String;
    mensagem       : String;
    ChaveDeAcesso  : String;
    ChaveDeApuracao: String;
    CodigoDaReceita: String;
    CodigoConvenio : String;
    HttpStatus     : Integer;
    HttpStatusText : String;
    Boleto         : TBoleto;
  End;

  TWSGnre = class(TComponent)
  private
    FRegGuia: TStringList;

    function fEnviarEmbarcaderoHttpReqResp: Boolean;
    procedure OnBeforePostCertificado(const HTTPReqResp: THTTPReqResp; Data: Pointer);
    function fEnviarSynapseHttpSend: Boolean;
    function fReceita: String;
    function fReceitaDareFcp:String;
    function fServico:String;
    function fServicoDareFcp:String;
    function fApuracao:String;
    function fDetalhamentoReceita: String;
    function fProduto: String;
    function fTipoAmbiente: String;
    function fVersao: String;
    function fTipoReceita: String;
    function fDocumentoOrigem: String;
    function fConvenio: String;
    function fCodigoConvenio: String;
    function fDocumentoDestinatario: String;
    function fInscricaoEstadualDestinatario: String;
    function fReferencia: String;
    function fCampoExtra: String;
    function fRetornaIdentificacaoContribuinteEmitente: String;
    function fXMLAmbiente: String;
    procedure pXmlRecepcao;
    procedure pXmlResultado;
    function fEnviar: Boolean;
    function fValidaXml(ARecepcao: Boolean): Boolean;
    function fGetTagXML(ATag, AXML: String): String;
    function fRetornaMotivoDaRejeicao(const AXMLString: string): string;
    function fRejeicao: TStringList;
    procedure pRetornaRejeicao(ACodRej, ADesRej, ACamRej: String; var AGuias: TStringList);
    function fProcurarElemento(ElementoPai: IXMLNode;  strNome: String): IXMLNode;
    procedure pGravaFISGNR(AIncLogGnr: String);
    procedure pGravaLog(ADescri, AXml, ARetorno: String);
    function fColetaDadosDoBoleto: Boolean;
    function fValidaCodigoDeBarras: Boolean;
    function fValidaValorDoBoleto: Boolean;
    function fWebServiceURL: String;
    function fGerarEnvio: Boolean;
    function fGerarRetorno: Boolean;
    procedure pRejeicaoVersao1(var ACodRej, ADesRej, ACamRej: String; var AGuias: TStringList);
    procedure pRejeicaoVersao2(var ACodRej, ADesRej, ACamRej: String; var AGuias: TStringList);
    function fValidaXmlSituacao(ARecepcao: Boolean): Boolean;
    function fWhileNodeGuias(ANodGuias: IXmlNode): Boolean;
    function fWhileNodeMotivosRejeicao(ANodMotivo: IXmlNode): Boolean;
    function fCampoExtraChaveDeAcesso(AExtraCodigo, AExtraTipo: String): String;
    function fCampoExtraDataDeEmissao(AExtraCodigo, AExtraTipo: String): String;
    function fCampoExtraNotaFiscal(AExtraCodigo, AExtraTipo: String): String;
    function fCampoExtraObservacao(AExtraCodigo, AExtraTipo: String): String;
    function fValorPrincipal: String;
    procedure pTempoDeEspera(ATentativa: Integer);
    procedure pTratarFalhas;
    function fGetValorXmlAttribute(ANode: IXMLNode; ANomeName, AAttribute, AValor: String): Double;
    function RetornaCampoJSON(const AJsonTexto: string; ACampo: String): string;
    function ExtrairMensagensErro(const AJson: string): string;
    function LerXmlRespostaDUA(const AXmlString: string): Boolean;
    function fRetornaXmlEnvioSaoPaulo: String;
    function fRetornaXmlEnvioPernambuco: String;
    function fRetornaXmlEnvioEspiritoSanto: String;
    function fGerarGuiaSaoPaulo: Boolean;
    function fGerarGuiaPernambuco: Boolean;
    function fGerarGuiaEspiritoSanto: Boolean;

  public
    TipoReceita    : TTipoReceitaGnre;
    TipoWebService : TWebService;
    VersaoGnrePE   : TWebServicePernambucoVersao;
    Componente     : TComponente;
    Configuracoes  : TConfiguracoes;
    DadosGuia      : TDadosGuia;
    Retorno        : TRetorno;

    function fGerarGuia: Boolean;
  End;

implementation

function TWSGnre.fEnviarEmbarcaderoHttpReqResp: Boolean;
var
   LRequester: THTTPReqResp;
   LStrem: TStringStream;
begin
   Result := True;
   LStrem := nil;

   try
     try
       LRequester := THTTPReqResp.Create(nil);
       LRequester.ConnectTimeout    := Componente.TimeOut;
       LRequester.ReceiveTimeout    := Componente.TimeOut;
       LRequester.SendTimeout       := Componente.TimeOut;
       LRequester.MaxSinglePostSize := 1000000;
       LRequester.URL               := Componente.URL;
       LRequester.UseUTF8InHeader   := True;
       LRequester.OnBeforePost      := OnBeforePostCertificado;
       LStrem := TStringStream.Create;
       LRequester.Execute(Componente.XML, LStrem);
       Sleep(500);
       Retorno.XML := LStrem.DataString;
     Except
       On E: Exception Do
       Begin
         Result := False;
         Retorno.Mensagem := E.Message;
       End;
     End;
   finally
     if Assigned(LRequester) then
       FreeAndNil(LRequester);

     if Assigned(LStrem) then
       FreeAndNil(LStrem);
   end;
end;

procedure TWSGnre.OnBeforePostCertificado(const HTTPReqResp: THTTPReqResp; Data: Pointer);
var
  LCertificado: ICertificate2;
  LCertContext: ICertContext;
  LPCertContext: PCCERT_CONTEXT;
  LContentHeader: string;
const
  LContentTypeTemplate: string = 'Content-Type: %s';
begin
  If Configuracoes.UsarCapicomArquivoPFX Then
  Begin
    LCertificado := CoCertificate.Create;
    LCertificado.Load(Configuracoes.CertificadoArquivoPFX, Configuracoes.CertificadoSenha, CAPICOM_KEY_STORAGE_DEFAULT, CAPICOM_CURRENT_USER_KEY);
  End
  Else
  Begin
    LCertificado := fGetCertificadoSerial(Configuracoes.SerialCertificado);
  End;

  if Assigned(LCertificado) then
  begin
    if Supports(LCertificado, ICertContext, LCertContext) then
    begin
       LCertContext.Get_CertContext(Integer(LPCertContext));

       if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, LPCertContext, Sizeof(CERT_CONTEXT) * 5) then
          raise Exception.Create('OnBeforePostCertificado: Error Message'+IntToStr(GetLastError));

       LContentHeader := Format(LContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
       HttpAddRequestHeaders(Data, PChar(LContentHeader), length(LContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
       HTTPReqResp.CheckContentType;
    end;
  end;
end;

function TWSGnre.fEnviarSynapseHttpSend: Boolean;
var
  LHTTPSend: THTTPSend;
  LFDataReq, LFDataResp: TMemoryStream;
begin
  Try
    LHTTPSend := THTTPSend.Create;
    Try
      LHTTPSend.UserAgent := 'Synapse OpenSSL Citel';
      LHTTPSend.Protocol  := '1.1';
      LHTTPSend.MimeType  := Componente.MimeType;
      LHTTPSend.Headers.Add('SOAPAction: "' + Componente.SoapAction + '"');

      If TipoWebService = GnreSaoPaulo Then
      Begin
        LHTTPSend.Headers.Add('Connection: keep-alive');
        LHTTPSend.Headers.Add('api-key: '+Configuracoes.DareApiKey);
      End
      Else
      Begin
        LHTTPSend.sock.SSL.CertificateFile := Configuracoes.CertificadoArquivoPEM;
        LHTTPSend.sock.SSL.PrivateKeyFile  := Configuracoes.CertificadoArquivoKEY;
        LHTTPSend.Sock.SSL.KeyPassword     := Configuracoes.CertificadoSenha;
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout(Componente.TimeOut);
      LHTTPSend.Sock.ConnectionTimeout   := 5000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.SocksTimeout        := Componente.TimeOut;
      LHTTPSend.Sock.HTTPTunnelTimeout   := Componente.TimeOut;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString( UTF8Encode(Componente.XML) ));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If LHTTPSend.HTTPMethod('POST', Componente.URL) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          Retorno.XML := UTF8ToString( ReadStrFromStream(LFDataResp, LFDataResp.Size) );
        Finally
          FreeAndNil(LFDataResp);
        End;

        Result := True;
      End
      Else
      Begin
        Retorno.Mensagem := LHTTPSend.Sock.LastErrorDesc ;
        Result := False;
      End;

      Retorno.HttpStatus     := LHTTPSend.ResultCode;
      Retorno.HttpStatusText := LHTTPSend.ResultString;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      Retorno.Mensagem := E.Message;
    End;
  End;
end;

function TWSGnre.fTipoAmbiente: String;
begin
  Result := 'PRODUCAO';
end;

function TWSGnre.fVersao: String;
begin
  Result := IIF(VersaoGnrePE = Versao1 ,'1.00', '2.00');
end;

function TWSGnre.fTipoReceita: String;
begin
  case TipoReceita of
       ST: Result := 'ST';
      FCP: Result := 'FCP';
    DIFAL: Result := 'DIFAL';
  end;
end;

function TWSGnre.fReceitaDareFcp:String;
begin
  Result := Configuracoes.DareReceitaFcpOp;

  If DadosGuia.ValorST > 0 Then
    Result := Configuracoes.DareReceitaFcpSt;

  If DadosGuia.ValorDIFAL > 0 Then
    Result := Configuracoes.DareReceitaFcpDf;
end;

function TWSGnre.fReceita:String;
begin
  case TipoWebService of
        GnreSaoPaulo: Begin
                        case TipoReceita of
                             ST: Result := Configuracoes.DareReceitaSt;
                            FCP: Result := fReceitaDareFcp;
                          DIFAL: Result := Configuracoes.DareReceitaDf;
                        end;
                      End;
      GnrePernambuco: Begin
                        case TipoReceita of
                             ST: Result := fStrZero(Configuracoes.GnreSt, 06);
                            FCP: Result := fStrZero(Configuracoes.GnreFc, 06);
                          DIFAL: Result := fStrZero(Configuracoes.GnreDf, 06);
                        end;
                      End;
   GnreEspiritoSanto: Begin
                        case TipoReceita of
                             ST: Result := Configuracoes.DuaReceitaSt;
                            FCP: Result := Configuracoes.DuaReceitaFc;
                          DIFAL: Result := Configuracoes.DuaReceitaDf;
                        end;
                      End;
  End;
end;

function TWSGnre.fServicoDareFcp:String;
begin
  Result := Configuracoes.DareServicoFcpOp;

  If DadosGuia.ValorST > 0 Then
    Result := Configuracoes.DareServicoFcpSt;

  If DadosGuia.ValorDIFAL > 0 Then
    Result := Configuracoes.DareServicoFcpDf;
end;

function TWSGnre.fServico:String;
begin
  case TipoReceita of
       ST: Result := Configuracoes.DareServicoSt;
      FCP: Result := fServicoDareFcp;
    DIFAL: Result := Configuracoes.DareServicoDf;
  end;
end;

function TWSGnre.fApuracao:String;
begin
  Result := 'N';

  If not Configuracoes.GnreApuracao Then
    Exit;

  Result := 'S';
end;

function TWSGnre.fDetalhamentoReceita:String;
var
  LReceita: String;
Begin
  LReceita := fCampoTabela('CFG_DETREC','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                  [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  If not fEmptyStr(LReceita) then
    Result := IIF( (VersaoGnrePE = Versao1), '  <c25_detalhamentoReceita>'+Trim(LReceita)+'</c25_detalhamentoReceita> ', '  <detalhamentoReceita>'+Trim(LReceita)+'</detalhamentoReceita> ');

End;

function TWSGnre.fProduto:String;
var
  LProduto: String;
begin

  LProduto := fCampoTabela('CFG_CODPRO','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                  [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  If not fEmptyStr(LProduto) Then
    Result := IIF( (VersaoGnrePE = Versao1), '<c26_produto>'+Trim(LProduto)+'</c26_produto>', '<produto>'+Trim(LProduto)+'</produto>');

End;

function TWSGnre.fDocumentoOrigem:String;
var
  LTipoCodigo: String;
  LDocumentoOrigem: String;
  LValorDocumentoOrigem: String;
begin

  LTipoCodigo := fCampoTabela('CFG_TIPCOD','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                               [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  LDocumentoOrigem := fCampoTabela('CFG_TIPDOC','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                          [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  If LDocumentoOrigem = 'CHAVE DE ACESSO' Then
    LValorDocumentoOrigem := DadosGuia.ChaveDeAcesso
  Else
    LValorDocumentoOrigem := DadosGuia.NotaFiscal;

  If not fEmptyStr(LTipoCodigo) Then
    Result := IIF( (VersaoGnrePE = Versao1), '<c28_tipoDocOrigem>'+Trim(LTipoCodigo)+'</c28_tipoDocOrigem>  <c04_docOrigem>'+Trim(LValorDocumentoOrigem)+'</c04_docOrigem> ',
                                             '<documentoOrigem tipo="'+Trim(LTipoCodigo)+'" >'+Trim(LValorDocumentoOrigem)+'</documentoOrigem> ');
end;

function TWSGnre.fCodigoConvenio: String;
begin
  Result := fCampoTabela('CFG_CONVEN','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);
end;

function TWSGnre.fConvenio: String;
var
  LConvenio: String;
begin

  LConvenio := fCodigoConvenio;

  If not fEmptyStr(LConvenio) Then
    Result := IIF( (VersaoGnrePE = Versao1),'<c15_convenio>'+Trim(LConvenio)+'</c15_convenio>','<convenio>'+Trim(LConvenio)+'</convenio>');

end;

function TWSGnre.fDocumentoDestinatario: String;
var
  LEnviarInscrEstadual: Boolean;
begin

  LEnviarInscrEstadual := (Trim(fCampoTabela('CFG_ENV_IE','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                                    [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao])) = 'S');

  If DadosGuia.ContribuinteDestinatarioTipoPessoa = '1' Then
  Begin
    Result := '<CNPJ>'+Trim(fTiraCaracEspeciaisPonto(  DadosGuia.ContribuinteDestinatarioCnpj ))+'</CNPJ> ';

    If LEnviarInscrEstadual Then
      Result := Result + '<IE>'+DadosGuia.ContribuinteDestinatarioInscrEstadual+'</IE> ';
  End
  Else
  Begin
    Result := '<CPF>'+DadosGuia.ContribuinteDestinatarioCnpj+'</CPF> ';
  End;

end;

function TWSGnre.fInscricaoEstadualDestinatario: String;
var
  LEnviarInscrEstadual: Boolean;
begin

  If (VersaoGnrePE = Versao1) Then
  Begin
    LEnviarInscrEstadual := (fCampoTabela('CFG_ENV_IE','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                                 [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]) = 'S');

    If not (DadosGuia.ContribuinteDestinatarioTipoPessoa = '1') Then
      Exit;

    If fEmptyStr(DadosGuia.ContribuinteDestinatarioInscrEstadual) Then
      Exit;

    If not LEnviarInscrEstadual Then
      Exit;

    Result := '<c36_inscricaoEstadualDestinatario>'+ DadosGuia.ContribuinteDestinatarioInscrEstadual +'</c36_inscricaoEstadualDestinatario> ';

  End;

End;

function TWSGnre.fReferencia: String;
var
  LReferencia: String;
  LTipoReferencia: Integer;
begin

  LReferencia := fCampoTabela('CFG_TIPREF','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                     [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  LTipoReferencia := StrToIntDef(LReferencia, 0);

  If LTipoReferencia > 0 Then
  Begin
    Result := Result + IIF((VersaoGnrePE = Versao1), '<c05_referencia>', '<referencia>');

    Case LTipoReferencia of
      1:Begin // 1 = MÊS, ANO
          Result := Result + '<mes>'+FormatDateTime('MM', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</mes>';
          Result := Result + '<ano>'+FormatDateTime('yyyy', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</ano>';
        End;
      2:Begin // 2 = MÊS, ANO, PERÍODO
          Result := Result + '<periodo>0</periodo> ';
          Result := Result + '<mes>'+FormatDateTime('MM', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</mes>';
          Result := Result + '<ano>'+FormatDateTime('yyyy', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</ano>';
        End;
      3:Begin // 2 = MÊS, ANO, PERÍODO, PARCELA
          Result := Result + '<periodo>0</periodo> ';
          Result := Result + '<mes>'+FormatDateTime('MM', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</mes>';
          Result := Result + '<ano>'+FormatDateTime('yyyy', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</ano> ';
          Result := Result + '<parcela>1</parcela> ';
        End;
    End;

    Result := Result + IIF((VersaoGnrePE = Versao1), '</c05_referencia>', '</referencia>');
  End;

end;

function TWSGnre.fCampoExtraNotaFiscal(AExtraCodigo, AExtraTipo: String): String;
begin
  Result := IIF((VersaoGnrePE = Versao1), '<c39_camposExtras>', '<camposExtras>');
  Result := Result + '<campoExtra> ';
  Result := Result + ' <codigo>'+AExtraCodigo+'</codigo> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '<tipo>'+AExtraTipo+'</tipo> ','');
  Result := Result + ' <valor>'+DadosGuia.NotaFiscal+'</valor> ';
  Result := Result + '</campoExtra> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '</c39_camposExtras>', '</camposExtras>');
end;

function TWSGnre.fCampoExtraChaveDeAcesso(AExtraCodigo, AExtraTipo: String): String;
begin
  Result := IIF((VersaoGnrePE = Versao1), '<c39_camposExtras>', '<camposExtras>');
  Result := Result + '<campoExtra> ';
  Result := Result + ' <codigo>'+AExtraCodigo+'</codigo> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '<tipo>'+AExtraTipo+'</tipo> ','');
  Result := Result + ' <valor>'+DadosGuia.ChaveDeAcesso+'</valor> ';
  Result := Result + '</campoExtra> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '</c39_camposExtras>', '</camposExtras>');
end;

function TWSGnre.fCampoExtraDataDeEmissao(AExtraCodigo, AExtraTipo: String): String;
begin
  Result := IIF((VersaoGnrePE = Versao1), '<c39_camposExtras>', '<camposExtras>');
  Result := Result + '<campoExtra> ';
  Result := Result + ' <codigo>'+AExtraCodigo+'</codigo> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '<tipo>'+AExtraTipo+'</tipo> ','');
  Result := Result + ' <valor>'+FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataEmissao, 0))+'</valor> ';
  Result := Result + '</campoExtra> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '</c39_camposExtras>', '</camposExtras>');
end;

function TWSGnre.fCampoExtraObservacao(AExtraCodigo, AExtraTipo: String): String;
var
  LObservacao: String;
begin
  LObservacao := 'Referente a Nota Fiscal '+DadosGuia.NotaFiscal;

  Result := IIF((VersaoGnrePE = Versao1), '<c39_camposExtras>', '<camposExtras>');

  Result := Result + '<campoExtra> ';
  Result := Result + ' <codigo>'+AExtraCodigo+'</codigo> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '<tipo>'+AExtraTipo+'</tipo> ','');
  Result := Result + ' <valor>'+LObservacao+'</valor> ';
  Result := Result + '</campoExtra> ';

  Result := Result + '<campoExtra> ';
  Result := Result + ' <codigo>80</codigo> ';
  Result := Result + IIF((VersaoGnrePE = Versao1), '<tipo>'+AExtraTipo+'</tipo> ','');
  Result := Result + ' <valor>'+DadosGuia.ChaveDeAcesso+'</valor> ';
  Result := Result + '</campoExtra> ';

  Result := Result + IIF((VersaoGnrePE = Versao1), '</c39_camposExtras>', '</camposExtras>');
end;

function TWSGnre.fCampoExtra: String;
var
  LExtraTipo: String;
  LExtraCodigo: String;
  LExtraTitulo: String;
begin

  LExtraTipo   := fCampoTabela('CFG_EXTTIP','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                      [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  LExtraCodigo := fCampoTabela('CFG_EXTCOD','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                      [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  LExtraTitulo := fCampoTabela('CFG_EXTDOC','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                      [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao]);

  If fEmptyStr(LExtraTitulo) Then
    Exit;

  If fEmptyStr(LExtraCodigo) Then
    Exit;

  If LExtraTitulo = 'NOTA FISCAL' Then
    Result := fCampoExtraNotaFiscal(LExtraCodigo, LExtraTipo);

  If LExtraTitulo = 'CHAVE DE ACESSO' Then
    Result := fCampoExtraChaveDeAcesso(LExtraCodigo, LExtraTipo);

  If LExtraTitulo = 'DATA DE EMISSAO' Then
    Result := fCampoExtraDataDeEmissao(LExtraCodigo, LExtraTipo);

  If LExtraTitulo = 'OBSERVACAO' Then
    Result := fCampoExtraObservacao(LExtraCodigo, LExtraTipo);

end;

function TWSGnre.fValorPrincipal: String;
begin
  If DadosGuia.UfFavorecida = 'RJ' Then
  Begin
    Result :=          '    <valor tipo="11" >'+DadosGuia.ValorICMS+'</valor> ';
    Result := Result + '    <valor tipo="21" >'+DadosGuia.ValorICMS+'</valor> ';
    Result := Result + '    <valor tipo="12" >'+DadosGuia.ValorFECP+'</valor> ';
    Result := Result + '    <valor tipo="22" >'+DadosGuia.ValorFECP+'</valor> ';
  End
  Else
  Begin
    Result :=          '    <valor tipo="11" >'+DadosGuia.ValorGNRE+'</valor> ';
    Result := Result + '    <valor tipo="21" >'+DadosGuia.ValorGNRE+'</valor> ';
  End;
end;

function TWSGnre.fRetornaIdentificacaoContribuinteEmitente: String;
var
  LEnviarInscrEstadual: Boolean;
begin
  LEnviarInscrEstadual := False;

  If Configuracoes.GnreApuracao Then
    LEnviarInscrEstadual := (Trim(fCampoTabela('CFG_ENV_IE','CFGGNR', ['CFG_ESTADO','CFG_TIPAMB','CFG_VERSAO','CFG_TIPREC','CFG_GNRAPU'],
                                                                      [DadosGuia.UfFavorecida, fTipoAmbiente, fVersao, fTipoReceita, fApuracao])) = 'S');

  Result := '<CNPJ>'+ DadosGuia.ContribuinteEmitenteCNPJ +'</CNPJ> ';

  If not LEnviarInscrEstadual Then
    Exit;

  Result := '<IE>'+ DadosGuia.ContribuinteEmitenteIE +'</IE> ';
end;

function TWSGnre.fRetornaXmlEnvioSaoPaulo: String;
var
  LJson   : TJSONObject;
  LErro   : TJSONObject;
  LReceita: TJSONObject;
begin
  LJson := TJSONObject.Create;
  try
    LErro := TJSONObject.Create;
    LErro.AddPair('estaOk', TJSONBool.Create(True));

    LReceita := TJSONObject.Create;
    LReceita.AddPair('codigo', fReceita);
    LReceita.AddPair('codigoServicoDARE', fServico);
    LReceita.AddPair('escopoUso', TJSONNumber.Create(0));
    LReceita.AddPair('habilitadoAdministrativo', TJSONBool.Create(False));

    LJson.AddPair('numeroControleDarePrincipal', TJSONNumber.Create(0));
    LJson.AddPair('gerarPDF', TJSONBool.Create(False));
    LJson.AddPair('codigoBarra44', TJSONNull.Create);
    LJson.AddPair('codigoBarra48', TJSONNull.Create);
    LJson.AddPair('cnpj', DadosGuia.ContribuinteEmitenteCNPJ);
    LJson.AddPair('cpf', TJSONNull.Create);
    LJson.AddPair('cpr', TJSONNull.Create);
    LJson.AddPair('cidade', DadosGuia.ContribuinteEmitenteMunicipio);
    LJson.AddPair('dataVencimento', FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataVencimento, 0)) + 'T00:00:00-03:00');
    LJson.AddPair('documentoImpressao', TJSONNull.Create);
    LJson.AddPair('endereco', DadosGuia.ContribuinteEmitenteEndereco);
    LJson.AddPair('erro', LErro);
    LJson.AddPair('funcionalidadeOrigem', TJSONNumber.Create(0));
    LJson.AddPair('observacao', 'Nota Fiscal ' + DadosGuia.NotaFiscal);
    LJson.AddPair('pixCopiaCola', TJSONNull.Create);
    LJson.AddPair('possiveisReceitas', TJSONNull.Create);
    LJson.AddPair('razaoSocial', DadosGuia.ContribuinteEmitenteRazaoSocial);
    LJson.AddPair('receita', LReceita);
    LJson.AddPair('referencia', FormatDateTime('MM/yyyy', StrToDateTimeDef(DadosGuia.DataEmissao, 0)));
    LJson.AddPair('telefone', '');
    LJson.AddPair('uf', 'SP');
    LJson.AddPair('valor', DadosGuia.ValorGNRE);
    LJson.AddPair('valorJuros', TJSONNumber.Create(0));
    LJson.AddPair('valorMulta', TJSONNumber.Create(0));
    LJson.AddPair('valorTotal', TJSONNumber.Create(0));
    LJson.AddPair('linha06', DadosGuia.NotaFiscal);

    Result := LJson.ToJSON;
  finally
    LJson.Free;
  end;
end;

function TWSGnre.fRetornaXmlEnvioPernambuco: String;
var
  LHeader : String;
  LBody   : String;
  LFooter : String;
begin
  LHeader := '<?xml version="1.0" encoding="UTF-8"?> '+
               '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"> '+
               '    <soap12:Header> '+
               '        <gnreCabecMsg xmlns="http://www.gnre.pe.gov.br/webservice/processar"> '+
               '            <versaoDados>'+fVersao+'</versaoDados> '+
               '        </gnreCabecMsg> '+
               '    </soap12:Header> '+
               '    <soap12:Body> '+
               '        <gnreDadosMsg xmlns="http://www.gnre.pe.gov.br/webservice/GnreLoteRecepcao"> '+
               '            <TLote_GNRE '+IIF((VersaoGnrePE = Versao1),'','versao="2.00"')+' xmlns="http://www.gnre.pe.gov.br"> '+
               '              <guias> ';

  If VersaoGnrePE = Versao1 Then
  Begin
    LBody :=        '<TDadosGNRE> ';
    LBody := LBody + '  <c01_UfFavorecida>'+ DadosGuia.UfFavorecida +'</c01_UfFavorecida> ';
    LBody := LBody + '  <c02_receita>'+ fReceita +'</c02_receita> ';
    LBody := LBody + fDetalhamentoReceita;
    LBody := LBody + fProduto;
    LBody := LBody + '  <c27_tipoIdentificacaoEmitente>1</c27_tipoIdentificacaoEmitente> ';
    LBody := LBody + '  <c03_idContribuinteEmitente> ';
    LBody := LBody + fRetornaIdentificacaoContribuinteEmitente;
    LBody := LBody + '  </c03_idContribuinteEmitente> ';
    LBody := LBody + fDocumentoOrigem;
    LBody := LBody + '  <c06_valorPrincipal>'+ DadosGuia.ValorGNRE +'</c06_valorPrincipal> ';
    LBody := LBody + '  <c10_valorTotal>'+ DadosGuia.ValorGNRE +'</c10_valorTotal> ';
    LBody := LBody + '  <c14_dataVencimento>'+ FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataVencimento, 0)) + '</c14_dataVencimento> ';
    LBody := LBody + fConvenio;
    LBody := LBody + '  <c16_razaoSocialEmitente>'+ DadosGuia.ContribuinteEmitenteRazaoSocial +'</c16_razaoSocialEmitente> ';
    LBody := LBody + '  <c18_enderecoEmitente>'+ DadosGuia.ContribuinteEmitenteEndereco +'</c18_enderecoEmitente> ';
    LBody := LBody + '  <c19_municipioEmitente>'+ DadosGuia.ContribuinteEmitenteMunicipio + '</c19_municipioEmitente> ';
    LBody := LBody + '  <c20_ufEnderecoEmitente>'+ DadosGuia.ContribuinteEmitenteUf +'</c20_ufEnderecoEmitente> ';
    LBody := LBody + '  <c21_cepEmitente>'+ DadosGuia.ContribuinteEmitenteCep +'</c21_cepEmitente> ';
    LBody := LBody + '  <c22_telefoneEmitente>'+ DadosGuia.ContribuinteEmitenteTelefone +'</c22_telefoneEmitente> ';

    If not Configuracoes.GnreApuracao Then
    Begin
      LBody := LBody + '  <c34_tipoIdentificacaoDestinatario>'+ DadosGuia.ContribuinteDestinatarioTipoPessoa +'</c34_tipoIdentificacaoDestinatario> ';
      LBody := LBody + '  <c35_idContribuinteDestinatario> ';
      LBody := LBody + fDocumentoDestinatario;
      LBody := LBody + '  </c35_idContribuinteDestinatario> ';
      LBody := LBody + fInscricaoEstadualDestinatario;
      LBody := LBody + '  <c37_razaoSocialDestinatario>'+ DadosGuia.ContribuinteDestinatarioRazaoSocial +'</c37_razaoSocialDestinatario> ';
      LBody := LBody + '  <c38_municipioDestinatario>'+ DadosGuia.ContribuinteDestinatarioMunicipio +'</c38_municipioDestinatario> ';
    End;

    LBody := LBody + '  <c33_dataPagamento>'+ FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataPagamento, 0)) +'</c33_dataPagamento> ';
    LBody := LBody + fReferencia;
    LBody := LBody + fCampoExtra;
    LBody := LBody + '</TDadosGNRE> ';
  End;

  If VersaoGnrePE = Versao2 Then
  Begin
    LBody :=        '<TDadosGNRE versao="2.00"> ';
    LBody := LBody + '  <ufFavorecida>'+ DadosGuia.UfFavorecida +'</ufFavorecida> ';
    LBody := LBody + '  <tipoGnre>0</tipoGnre> ';
    LBody := LBody + '  <contribuinteEmitente> ';
    LBody := LBody + '   <identificacao> ';
    LBody := LBody + fRetornaIdentificacaoContribuinteEmitente;
    LBody := LBody + '   </identificacao> ';
    LBody := LBody + '   <razaoSocial>'+ DadosGuia.ContribuinteEmitenteRazaoSocial +'</razaoSocial> ';
    LBody := LBody + '   <endereco>'+ DadosGuia.ContribuinteEmitenteEndereco +'</endereco> ';
    LBody := LBody + '   <municipio>'+ DadosGuia.ContribuinteEmitenteMunicipio + '</municipio> ';
    LBody := LBody + '   <uf>'+ DadosGuia.ContribuinteEmitenteUf +'</uf> ';
    LBody := LBody + '   <cep>'+ DadosGuia.ContribuinteEmitenteCep +'</cep> ';
    LBody := LBody + '   <telefone>'+ DadosGuia.ContribuinteEmitenteTelefone +'</telefone> ';
    LBody := LBody + '  </contribuinteEmitente> ';
    LBody := LBody + '  <itensGNRE> ';
    LBody := LBody + '   <item> ';
    LBody := LBody + '    <receita>'+fReceita+'</receita> ';
    LBody := LBody + fDetalhamentoReceita;
    LBody := LBody + fDocumentoOrigem;
    LBody := LBody + fProduto;
    LBody := LBody + fReferencia;
    LBody := LBody + '    <dataVencimento>'+ FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataVencimento, 0)) + '</dataVencimento> ';
    LBody := LBody + fValorPrincipal;
    LBody := LBody + fConvenio;

    If not Configuracoes.GnreApuracao Then
    Begin
      LBody := LBody + '    <contribuinteDestinatario> ';
      LBody := LBody + '     <identificacao> ';
      LBody := LBody + fDocumentoDestinatario;
      LBody := LBody + '     </identificacao> ';
      LBody := LBody + '     <razaoSocial>'+ DadosGuia.ContribuinteDestinatarioRazaoSocial +'</razaoSocial> ';
      LBody := LBody + '     <municipio>'+ DadosGuia.ContribuinteDestinatarioMunicipio +'</municipio> ';
      LBody := LBody + '    </contribuinteDestinatario> ';
    End;

    LBody := LBody + fCampoExtra;
    LBody := LBody + '   </item> ';
    LBody := LBody + '  </itensGNRE> ';
    LBody := LBody + '   <valorGNRE>'+ DadosGuia.ValorGNRE +'</valorGNRE> ';
    LBody := LBody + '   <dataPagamento>'+ FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataPagamento, 0)) +'</dataPagamento> ';
    LBody := LBody + '  </TDadosGNRE>  ';
  End;

  LFooter := '                </guias> '+
             '            </TLote_GNRE> '+
             '        </gnreDadosMsg> '+
             '    </soap12:Body> '+
             '</soap12:Envelope> ';

  Result := fTrimAll(LHeader + LBody + LFooter);
end;

function TWSGnre.fRetornaXmlEnvioEspiritoSanto: String;
begin
  Result := '<?xml version="1.0" encoding="utf-8"?> '+
            '<soap:Envelope '+
            ' xmlns:soap="http://www.w3.org/2003/05/soap-envelope" '+
            ' xmlns:duae="http://www.sefaz.es.gov.br/duae"> '+
            ' <soap:Header> '+
            ' <duae:DuaServiceHeader> '+
            ' <duae:versao>1.01</duae:versao> '+
            ' </duae:DuaServiceHeader> '+
            ' </soap:Header> '+
            ' <soap:Body> '+
            ' <duae:duaEmissao> '+
            ' <duae:duaDadosMsg> '+
            ' <emisDua '+
            ' versao="1.01" '+
            ' xmlns="http://www.sefaz.es.gov.br/duae"> '+
            ' <tpAmb>1</tpAmb> '+
            ' <cnpjEmi>'+DadosGuia.ContribuinteEmitenteCNPJ+'</cnpjEmi> '+
            ' <cnpjOrg>27080571000130</cnpjOrg> '+
            ' <cArea>5</cArea> '+
            ' <cServ>'+fReceita+'</cServ> '+
            ' <cnpjPes>'+DadosGuia.ContribuinteEmitenteCNPJ+'</cnpjPes> '+
            ' <dRef>'+FormatDateTime('yyyy-MM', StrToDateTimeDef(DadosGuia.DataEmissao, 0))+'</dRef> '+
            ' <dVen>'+FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataVencimento, 0))+'</dVen> '+
            ' <dPag>'+FormatDateTime('yyyy-MM-dd', StrToDateTimeDef(DadosGuia.DataPagamento, 0))+'</dPag> '+
            ' <cMun>'+DadosGuia.ContribuinteDestinatarioMunicipioEspiritoSanto+'</cMun> '+
            ' <xInf>Ref. Nfe: '+DadosGuia.NotaFiscal+' Chave de Acesso: '+DadosGuia.ChaveDeAcesso+'</xInf> '+
            ' <vRec>'+DadosGuia.ValorGNRE+'</vRec> '+
            ' <xIde>'+DadosGuia.Identificacao+'</xIde> '+
            ' <fPix>true</fPix> '+
            ' </emisDua> '+
            ' </duae:duaDadosMsg> '+
            ' </duae:duaEmissao> '+
            ' </soap:Body> '+
            '</soap:Envelope> ';
end;

procedure TWSGnre.pXmlRecepcao;
begin
  case TipoWebService of
          GnreSaoPaulo: Componente.XML := fRetornaXmlEnvioSaoPaulo;
        GnrePernambuco: Componente.XML := fRetornaXmlEnvioPernambuco;
     GnreEspiritoSanto: Componente.XML := fRetornaXmlEnvioEspiritoSanto;
  end;

  pGravaLog(IIF(TipoWebService = GnreSaoPaulo,'GERAÇÃO DO JSON', 'GERAÇÃO DO XML'), Componente.XML, '');
end;

function TWSGnre.fXMLAmbiente: String;
Begin
  result := IIF( Configuracoes.Homologacao, '2', '1');
End;

procedure TWSGnre.pXmlResultado;
Begin
  Componente.XML := '<?xml version="1.0" encoding="UTF-8"?> '+
                    '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"> '+
                    '    <soap12:Header> '+
                    '        <gnreCabecMsg xmlns="http://www.gnre.pe.gov.br/wsdl/consultar"> '+
                    '            <versaoDados>'+fVersao+'</versaoDados> '+
                    '        </gnreCabecMsg> '+
                    '    </soap12:Header> '+
                    '    <soap12:Body> '+
                    '        <gnreDadosMsg xmlns="http://www.gnre.pe.gov.br/webservice/GnreResultadoLote"> '+
                    '            <TConsLote_GNRE xmlns="http://www.gnre.pe.gov.br"> '+
                    '                <ambiente>'+fXMLAmbiente+'</ambiente> '+
                    '                <numeroRecibo>'+Retorno.Recibo+'</numeroRecibo> '+
                    '            </TConsLote_GNRE> '+
                    '        </gnreDadosMsg> '+
                    '    </soap12:Body> '+
                    '</soap12:Envelope> ';

  Componente.XML := Trim(Componente.XML);
End;

function TWSGnre.fGetTagXML(ATag, AXML: String): String;
var LTagIni,
    LTagFin : String;
    LPosIni,
    LPosFin : Integer;
begin
  LTagIni := ATag;
  LTagFin := '/' + ATag;

  If (Pos(LTagIni, AXML) = 0) Then
    Exit;

  If (Pos(LTagFin, AXML) = 0) then
    Exit;

  LPosIni := Pos(LTagIni, AXML) + Length(LTagIni);
  LPosFin := Pos(LTagFin, AXML);
  Result  := Copy(AXML, LPosIni+1, (LPosFin - LPosIni)-2);
end;

function TWSGnre.fRetornaMotivoDaRejeicao(const AXMLString: string): string;
var
  XMLDoc: IXMLDocument;

  function LocalizarNoPorNome(ANode: IXMLNode; const ANomeLocal: string): IXMLNode;
  var
    I: Integer;
    ResultNode: IXMLNode;
  begin
    Result := nil;
    if not Assigned(ANode) then
      Exit;

    if SameText(ANode.LocalName, ANomeLocal) then
      Exit(ANode);

    for I := 0 to ANode.ChildNodes.Count - 1 do
    begin
      ResultNode := LocalizarNoPorNome(ANode.ChildNodes[I], ANomeLocal);
      if ResultNode <> nil then
        Exit(ResultNode);
    end;
  end;

var
  NoMotivo: IXMLNode;
  NoDescricao: IXMLNode;
begin
  Result := '';
  if AXMLString.IsEmpty then
    Exit;

  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.LoadFromXML(AXMLString);
    XMLDoc.Active := True;

    NoMotivo := LocalizarNoPorNome(XMLDoc.DocumentElement, 'motivo');
    if NoMotivo <> nil then
    begin
      NoDescricao := LocalizarNoPorNome(NoMotivo, 'descricao');
      if NoDescricao <> nil then
        Result := NoDescricao.Text;
    end;
  except
    Result := 'Não foi possível identificar o motivo informado pela Sefaz. Por favor, tente novamente em alguns minutos.';
  end;
end;

function TWSGnre.fValidaXmlSituacao(ARecepcao: Boolean): Boolean;
var
  LXmlWS: String;
  LCodSit: String;
  LDesSit: String;
  LMotRej: String;

  function fRetornoOK: Boolean;
  begin
    Result := False;

    If (LCodSit = '100') Then
      Exit(True);

    If (LCodSit = '402') And fEmptyStr(LMotRej) Then
      Exit(True);
  end;

Begin

  LXmlWS := Retorno.XML;
  LCodSit := Trim(fTiraCaracEspeciais( fGetTagXML('ns1:codigo', LXmlWS) ));
  LDesSit := Trim(fTiraCaracEspeciais( fGetTagXML('ns1:descricao', LXmlWS) ));
  LMotRej := Trim(fTiraCaracEspeciais( fRetornaMotivoDaRejeicao(LXmlWS) ));

  If (VersaoGnrePE = Versao2) Then
    FRegGuia.Text := LXmlWS;

  If fRetornoOK Then
  Begin
    Result := True;
    Retorno.Mensagem := LCodSit + ' - ' + LDesSit;
  End
  Else
  Begin
    Retorno.Mensagem := 'Erro no processamento, verifique a mensagem da Sefaz.'+#13+
                         LCodSit + ' - ' + IIF(fEmptyStr(LMotRej), LDesSit, LMotRej);

    If not ARecepcao Then
    Begin
      Retorno.Mensagem := fRejeicao.Text;
    End;

    Result := False;
  End;
End;

function TWSGnre.fValidaXml(ARecepcao: Boolean): Boolean;
var
  LXmlWS: String;
  LCodSit: String;
  LDesSit: String;
Begin
  Result := True;

  LXmlWS := Retorno.XML;
  LCodSit := Trim(fTiraCaracEspeciais( fGetTagXML('ns1:codigo', LXmlWS) ));
  LDesSit := Trim(fTiraCaracEspeciais( fGetTagXML('ns1:descricao', LXmlWS) ));

  If ARecepcao Then
  Begin
    Retorno.Recibo := fGetTagXML('ns1:numero',LXmlWS);
  End
  Else
  Begin
    Retorno.Recibo := fGetTagXML('ns1:numeroRecibo',LXmlWS);
    FRegGuia.Text  := fGetTagXML('ns1:resultado',LXmlWS);
  End;

  If fEmptyStr(LCodSit) Then
  Begin
    Retorno.Mensagem := 'Sefaz - Não foi possível '+IIF(ARecepcao,'enviar','consultar')+ ' o lote de guias GNRE.';
    Result := False;
  End;

  If Result Then
     Result := fValidaXmlSituacao(ARecepcao);

  If not ((Retorno.HttpStatus >= 200) and (Retorno.HttpStatus <= 299)) Then
    pGravaLog(IIF(ARecepcao,'ENVIO DO LOTE','RETORNO DO LOTE'), LXmlWS, 'Código: '+ IntToStr(Retorno.HttpStatus) +'  Descrição: '+ Retorno.HttpStatusText)
  Else
    pGravaLog(IIF(ARecepcao,'ENVIO DO LOTE','RETORNO DO LOTE'), LXmlWS, 'Recibo: '+ Retorno.Recibo +'  Situação: '+ LCodSit +' - '+ LDesSit);
End;

function TWSGnre.fWhileNodeGuias(ANodGuias: IXmlNode): Boolean;
begin
  Result := False;

  If not Assigned(ANodGuias) Then
    Exit;

  If not (ANodGuias.GetNodeName = 'ns1:guia') Then
    Exit;

  Result := True;
end;

function TWSGnre.fGetValorXmlAttribute(ANode: IXMLNode; ANomeName, AAttribute, AValor: String): Double;
var
  LContador: Integer;
begin
  Result := 0;

  For LContador := 0 to ANode.ChildNodes.Count - 1 Do
  Begin
    If (ANode.ChildNodes.Get(LContador).NodeName <> ANomeName) Then
      Continue;

    If (ANode.ChildNodes.Get(LContador).GetAttribute(AAttribute) = AValor) Then
    Begin
      Result := StrToFloatDef(AnsiReplaceStr(ANode.ChildNodes.Get(LContador).NodeValue,'.',','), 0);
      Break;
    End;
  End;
end;

function TWSGnre.fValidaCodigoDeBarras: Boolean;
Begin
  Result := not fEmptyStr(AnsiReplaceStr( Retorno.Boleto.CodigoDeBarras, '0', '' ));

  If not Result Then
    Retorno.Mensagem := 'O Webservice da Sefaz gerou guias com códigos de barras zerados.';

End;

function TWSGnre.fValidaValorDoBoleto: Boolean;
var
  LValorBoleto: Double;
  LValorJuros : Double;
  LValorMulta : Double;
  LValorImposto: Double;
  LValorDiferenca: Double;
  LCodigoDeBarras: String;
Begin
  If Length(Retorno.Boleto.CodigoDeBarras) = 48 Then
  Begin
    LCodigoDeBarras := Retorno.Boleto.CodigoDeBarras;

    LCodigoDeBarras := Copy(LCodigoDeBarras, 1,  11) +
                       Copy(LCodigoDeBarras, 13, 11) +
                       Copy(LCodigoDeBarras, 25, 11) +
                       Copy(LCodigoDeBarras, 37, 11) ;

    LValorBoleto := StrToFloatDef(Copy(LCodigoDeBarras, 5, 11), 0) / 100;
  End
  Else
    LValorBoleto := StrToFloatDef(Copy(Retorno.Boleto.CodigoDeBarras,   5, 11), 0) / 100;

  LValorImposto   := StrToFloatDef(AnsiReplaceStr(DadosGuia.ValorGNRE,'.',','), 0);
  LValorJuros     := Retorno.Boleto.Juros;
  LValorMulta     := Retorno.Boleto.Multa;
  LValorImposto   := LValorImposto + LValorJuros + LValorMulta;

  LValorDiferenca := (LValorBoleto - LValorImposto);

  Result := not (LValorDiferenca > Configuracoes.ToleranciaBoleto);

  If not Result Then
    Retorno.Mensagem :=  'O valor de retorno da Sefaz diverge do valor enviado pelo Autcom. Por esse motivo, a guia não será emitida. '+
                         'Por favor, tente refazer o procedimento. Caso a divergência de valores persista, entre em contato imediatamente com a Citel.';
End;

procedure TWSGnre.pRetornaRejeicao(ACodRej, ADesRej, ACamRej: String; var AGuias: TStringList);
var
  LRetorno: String;
Begin
  If (VersaoGnrePE = Versao1) Then
  Begin
    LRetorno := 'Rejeição: ' + ACodRej + '-' + ADesRej;
  End;

  If (VersaoGnrePE = Versao2) Then
  Begin
    LRetorno := 'Rejeição: ' + ACodRej + '-' + ADesRej + IIF(fEmptyStr(ACamRej),' ', ' Campo: ' + ACamRej);
  End;

  If (ACodRej = '197') Or
     ((ACodRej = '703') And
        ((pos('CAMPOS DEVEM VIR ANTES DELE' ,UpperCase(fTiraCaracEspeciais(LRetorno))) > 0)  Or
         (pos('O XML ESTA INCOMPLETO'       ,UpperCase(fTiraCaracEspeciais(LRetorno))) > 0)  Or
         (pos('FALHA NA COMUNICACAO'        ,UpperCase(fTiraCaracEspeciais(LRetorno))) > 0))) Then
  Begin
    AGuias.Text := LRetorno + ' ' +#13+
                              'A Sefaz da UF selecionada está temporariamente indisponível.'+#13+
                              'Por favor, aguarde alguns minutos e tente novamente.';
  End
  Else
    AGuias.Add(LRetorno);
End;

function TWSGnre.fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
begin
  If ElementoPai = nil Then
  Begin
    Result := nil;
    Exit;
  End;

  If ElementoPai.LocalName = strNome Then
  Begin
    Result := ElementoPai;
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.ChildNodes.First, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.NextSibling, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := nil;
end;

procedure TWSGnre.pRejeicaoVersao1(var ACodRej: String; var ADesRej: String; var ACamRej: String; var AGuias: TStringList);
var
  LContador: Integer;
begin
  For LContador := 0 To FRegGuia.Count - 1 Do
  Begin

    If Copy(FRegGuia[LContador], 1, 1) = '2' Then
    Begin
      ACodRej := Copy(FRegGuia[LContador],36,   3);
      ADesRej := Copy(FRegGuia[LContador],39, 393);
      ADesRej := Trim(fTiraCaracEspeciais(ADesRej));
    End;

    If not fEmptyStr(ACodRej) then
    Begin
      pRetornaRejeicao(ACodRej, ADesRej, '', AGuias);
      ACodRej := '';
      ADesRej := '';
    End;
  End;
end;

function TWSGnre.fWhileNodeMotivosRejeicao(ANodMotivo: IXmlNode): Boolean;
begin
  Result := False;

  If not Assigned(ANodMotivo) Then
    Exit;

  If not (ANodMotivo.GetNodeName = 'ns1:motivosRejeicao') Then
    Exit;

  Result := True;
end;

procedure TWSGnre.pRejeicaoVersao2(var ACodRej: String; var ADesRej: String; var ACamRej: String; var AGuias: TStringList);
var
  LXmlDoc: TXMLDocument;
  LNodMotivo:IXmlNode;
  LNodMotivos:IXmlNode;
begin
  Try
    LXmlDoc := TXMLDocument.Create(Self);

    LXmlDoc.Xml := FRegGuia;

    LXmlDoc.Active := True;

    LNodMotivos := fProcurarElemento(LXmlDoc.Node, 'motivosRejeicao');

    While fWhileNodeMotivosRejeicao(LNodMotivos) Do
    Begin
      LNodMotivo := fProcurarElemento(LNodMotivos, 'motivo');

      If Assigned(LNodMotivo) Then
      Begin
        ACodRej := fGetValorXml(LNodMotivo, 'ns1:codigo') ;
        ADesRej := fGetValorXml(LNodMotivo, 'ns1:descricao') ;
        ACamRej := fGetValorXml(LNodMotivo, 'ns1:campo') ;

        If not fEmptyStr(ACodRej) then
        Begin
          pRetornaRejeicao(ACodRej, ADesRej, ACamRej, AGuias);
        End;
      End;

      LNodMotivos := LNodMotivos.NextSibling;
    End;

  Finally
    FreeAndNil(LXmlDoc);
  End;
end;

Function TWSGnre.fRejeicao: TStringList;
var LContador: Integer;
    LCodRej: String;
    LDesRej: String;
    LCamRej: String;
    LGuias: TStringList;
    LRelacao: TStringList;
Begin
  LGuias   := TStringList.Create;
  LRelacao := TStringList.Create;

  Try
    If (VersaoGnrePE = Versao1) Then
      pRejeicaoVersao1(LCodRej, LDesRej, LCamRej, LGuias)
    Else
      pRejeicaoVersao2(LCodRej, LDesRej, LCamRej, LGuias);

    If fEmptyStr(LGuias.Text) Then
    Begin
      LRelacao.Add('O WebService da Sefaz retornou as guias sem o código de situação do processo.');
      LRelacao.Add('Aguarde alguns minutos e tente novamente.');
    End
    Else
    Begin
      For LContador := 0 To LGuias.Count - 1 Do
        LRelacao.Add(LGuias[LContador]);
    End;

  Finally
    Result := LRelacao ;
  End;
End;

procedure TWSGnre.pGravaLog(ADescri, AXml, ARetorno: String);
var
  LqryLogGnr: TUniQuery;
  LAutInc: String;

  function fRetornaTipoLeiaute: String;
  begin
    case TipoWebService of
            GnreSaoPaulo: Result := 'DARE-SP';
          GnrePernambuco: Result := 'GNRE - NACIONAL';
       GnreEspiritoSanto: Result := 'DUA-ES';
    end;
  end;

begin
  LqryLogGnr := fCriaQuery(Nil);

  Try
    If Configuracoes.GnreApuracao Then
    Begin
      LAutInc := fRetAutoIncrem('LOGGNA', VS_strCodEmp);

      LqryLogGnr.SQL.Add('SELECT * FROM LOGGNA WHERE FALSE');
      LqryLogGnr.Open;

      LqryLogGnr.Insert;
      LqryLogGnr.FieldByName('AUTOINCREM').AsString   := LAutInc;
      LqryLogGnr.FieldByName('LOG_APUGNR').AsString   := DadosGuia.ChaveDeApuracao;
      LqryLogGnr.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      LqryLogGnr.FieldByName('LOG_VERSAO').AsString   := IIF(VersaoGnrePE = Versao1, '1.00', '2.00');
      LqryLogGnr.FieldByName('LOG_TIPGNR').AsString   := fTipoReceita;
      LqryLogGnr.FieldByName('LOG_DESCRI').AsString   := ADescri;
      LqryLogGnr.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
      LqryLogGnr.FieldByName('LOG_DTAGNR').AsDateTime := VS_Date;
      LqryLogGnr.FieldByName('LOG_HORGNR').AsDateTime := fTime();
      LqryLogGnr.FieldByName('LOG_MSG_WS').AsString   := ARetorno;
      LqryLogGnr.FieldByName('LOG_ARQXML').AsString   := AXml;
      LqryLogGnr.FieldByName('LOG_DTAVEN').AsDateTime := StrToDate( DadosGuia.DataVencimento );
      LqryLogGnr.FieldByName('LOG_DTAPAG').AsDateTime := StrToDate( DadosGuia.DataPagamento );
      LqryLogGnr.Post;
      LqryLogGnr.Close;
    End
    Else
    Begin
      LAutInc := fRetAutoIncrem('LOGGNR', VS_strCodEmp);

      pGravaFISGNR(LAutInc);

      LqryLogGnr.SQL.Add('SELECT * FROM LOGGNR WHERE FALSE');
      LqryLogGnr.Open;

      LqryLogGnr.Insert;
      LqryLogGnr.FieldByName('AUTOINCREM').AsString   := LAutInc;
      LqryLogGnr.FieldByName('LOG_TIPGNR').AsString   := fTipoReceita;
      LqryLogGnr.FieldByName('LOG_DESCRI').AsString   := ADescri;
      LqryLogGnr.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      LqryLogGnr.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
      LqryLogGnr.FieldByName('LOG_DTAGNR').AsDateTime := VS_Date;
      LqryLogGnr.FieldByName('LOG_HORGNR').AsDateTime := fTime();
      LqryLogGnr.FieldByName('LOG_MSG_WS').AsString   := ARetorno;
      LqryLogGnr.FieldByName('LOG_ARQXML').AsString   := AXml;
      LqryLogGnr.FieldByName('LOG_LAYENV').AsString   := fRetornaTipoLeiaute;
      LqryLogGnr.FieldByName('LOG_VERSAO').AsString   := IIF(VersaoGnrePE = Versao1, '1.00', '2.00');
      LqryLogGnr.FieldByName('LOG_DTAVEN').AsDateTime := StrToDate( DadosGuia.DataVencimento );
      LqryLogGnr.FieldByName('LOG_DTAPAG').AsDateTime := StrToDate( DadosGuia.DataPagamento );
      LqryLogGnr.Post;
      LqryLogGnr.Close;
    End;

  Finally
    FreeAndNil(LqryLogGnr);
  End;
end;

procedure TWSGnre.pGravaFISGNR(AIncLogGnr: String);
var
  LqryFisGnr: TUniQuery;
begin
  LqryFisGnr:= fCriaQuery(Nil);

  Try
    LqryFisGnr.SQL.Add('SELECT * FROM FISGNR WHERE FALSE');
    LqryFisGnr.Open;

    LqryFisGnr.Insert;
    LqryFisGnr.FieldByName('GNR_CADFIS').AsString   := DadosGuia.CadFisAutoincrem;
    LqryFisGnr.FieldByName('GNR_LOGGNR').AsString   := AIncLogGnr;
    LqryFisGnr.Post;

    LqryFisGnr.Close;

  Finally
    FreeAndNil(LqryFisGnr);
  End;
end;

function TWSGnre.fColetaDadosDoBoleto: Boolean;
var LContador: Integer;
    LIdentificador: String;
    LXmlDoc: TXMLDocument;
    LNodGuias:IXmlNode;
    LNodDados:IXmlNode;
begin
  Result := True;

  Try
    Retorno.ChaveDeAcesso   := DadosGuia.ChaveDeAcesso;
    Retorno.ChaveDeApuracao := DadosGuia.ChaveDeApuracao;
    Retorno.CodigoDaReceita := fReceita;
    Retorno.CodigoConvenio  := fCodigoConvenio;

    If (VersaoGnrePE = Versao1) Then
    Begin
      For LContador := 0 To FRegGuia.Count - 1 Do
      Begin
        LIdentificador := Copy(FRegGuia[LContador], 1, 1);

        If LIdentificador = '1' Then
        Begin
          Retorno.Boleto.Valor            := StrToFloatDef(Copy(FRegGuia[LContador], 919,  15), 0) / 100;
          Retorno.Boleto.Juros            := StrToFloatDef(Copy(FRegGuia[LContador], 949,  15), 0) / 100;
          Retorno.Boleto.Multa            := StrToFloatDef(Copy(FRegGuia[LContador], 964,  15), 0) / 100;
          Retorno.Boleto.Valor            := Retorno.Boleto.Valor + Retorno.Boleto.Juros + Retorno.Boleto.Multa;
          Retorno.Boleto.LinhaDigitavel   := Copy(FRegGuia[LContador], 979,  48);
          Retorno.Boleto.CodigoDeBarras   := Copy(FRegGuia[LContador],1027,  44);
          Retorno.Boleto.NumeroDeControle := Copy(FRegGuia[LContador],1072,  16);
        End;

      End;
    End;

    If (VersaoGnrePE = Versao2) Then
    Begin
      Try
        LXmlDoc := TXMLDocument.Create(Self);

        LXmlDoc.Xml := FRegGuia;
        LXmlDoc.Active := True;

        LNodGuias := fProcurarElemento(LXmlDoc.Node, 'guia');

        While fWhileNodeGuias(LNodGuias) Do
        Begin

          LNodDados := fProcurarElemento(LNodGuias, 'guia');

          If Assigned(LNodDados) Then
          Begin
            Retorno.Boleto.Valor            := fGetValorXml(LNodDados, 'ns1:valorGNRE',  varDouble);
            Retorno.Boleto.CodigoDeBarras   := fGetValorXml(LNodDados, 'ns1:codigoBarras') ;
            Retorno.Boleto.LinhaDigitavel   := fGetValorXml(LNodDados, 'ns1:linhaDigitavel') ;
            Retorno.Boleto.QrCode           := fGetValorXml(LNodDados, 'ns1:qrcodePayload') ;
            Retorno.Boleto.NumeroDeControle := fGetValorXml(LNodDados, 'ns1:nossoNumero') ;
          End;

          LNodDados := fProcurarElemento(LNodGuias, 'item');

          If Assigned(LNodDados) Then
          Begin
            If Pos(DadosGuia.UfFavorecida, 'GO_PE_TO_') > 0 Then
            Begin
              Retorno.Boleto.Multa := fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','31');
              Retorno.Boleto.Juros := fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','41');
              Retorno.Boleto.Juros := Retorno.Boleto.Juros + fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','51');
            End
            Else
            Begin
              Retorno.Boleto.Juros := fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','31');
              Retorno.Boleto.Juros := Retorno.Boleto.Juros + fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','41');
              Retorno.Boleto.Juros := Retorno.Boleto.Juros + fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','51');

              Retorno.Boleto.Multa := fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','32');
              Retorno.Boleto.Multa := Retorno.Boleto.Multa + fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','42');
              Retorno.Boleto.Multa := Retorno.Boleto.Multa + fGetValorXmlAttribute(LNodDados, 'ns1:valor','tipo','52');
            End;
          End;

          LNodGuias := LNodGuias.NextSibling;
        End;

      Finally
        FreeAndNil(LXmlDoc);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      Retorno.Mensagem := E.Message;
    End;
  End;

end;

function TWSGnre.fWebServiceURL: String;
begin
  Case TipoWebService of
        GnreSaoPaulo: Begin
                        If Configuracoes.Homologacao Then
                          Result := 'https://apigateway-hml.fazenda.sp.gov.br/dare-icms/dare-unitario/emitir'
                        Else
                          Result := 'https://apigateway.fazenda.sp.gov.br/dare-icms/dare-unitario/emitir';
                      End;
      GnrePernambuco: Begin
                        If Configuracoes.Homologacao Then
                          Result := 'https://www.testegnre.pe.gov.br/gnreWS/services'
                        Else
                          Result := 'https://www.gnre.pe.gov.br/gnreWS/services';
                      End;
   GnreEspiritoSanto: Begin
                        If Configuracoes.Homologacao Then
                          Result := 'https://homologacao.sefaz.es.gov.br/WsDua/DuaService.asmx'
                        Else
                          Result := 'https://app.sefaz.es.gov.br/WsDua/DuaService.asmx';
                      End;
  End;
end;

function TWSGnre.fGerarEnvio: Boolean;
begin
  pXmlRecepcao;

  Result := fEnviar;

  If Result Then
    Result := fValidaXml(True);
end;

function TWSGnre.fGerarRetorno: Boolean;
begin
  pXmlResultado;

  Result := fEnviar;

  If Result Then
    Result := fValidaXml(False);
end;

procedure TWSGnre.pTempoDeEspera(ATentativa: Integer);
begin
  Case ATentativa Of
    1: Sleep(250);
    2: Sleep(250);
  End;
end;

function TWSGnre.RetornaCampoJSON(const AJsonTexto: string; ACampo: String): string;
var
  LValue: TJSONValue;
begin
  Result := '';

  if Trim(AJsonTexto) = '' then
    Exit;

  LValue := TJSONObject.ParseJSONValue(AJsonTexto);
  try
    if LValue is TJSONObject then
      TJSONObject(LValue).TryGetValue<string>(ACampo, Result);
  finally
    LValue.Free;
  end;
end;

function TWSGnre.ExtrairMensagensErro(const AJson: string): string;
var
  LJson: string;
  LValue: TJSONValue;
  LJsonObj: TJSONObject;
  LErroObj: TJSONObject;
  LMsgArray: TJSONArray;
  I: Integer;
begin
  Result := '';

  LJson := AJson.Trim;

  if LJson.IsEmpty then
    Exit;

  try
    LValue := TJSONObject.ParseJSONValue(LJson);
    try
      if LValue is TJSONObject then
      begin
        LJsonObj := TJSONObject(LValue);

        if LJsonObj.TryGetValue<TJSONObject>('erro', LErroObj) then
        begin
          if LErroObj.TryGetValue<TJSONArray>('mensagens', LMsgArray) then
          begin
            for I := 0 to LMsgArray.Count - 1 do
            begin
              if Result <> '' then
                Result := Result + sLineBreak;

              Result := Result + LMsgArray.Items[I].Value;
            end;
          end;
        end;
      end;
    finally
      LValue.Free;
    end;

    if Result.IsEmpty then
      Result := LJson;
  except
    on E: Exception do
      Result := 'Erro ao processar JSON: ' + E.Message;
  end;
end;

function TWSGnre.LerXmlRespostaDUA(const AXmlString: string): Boolean;
var
  XmlDoc: IXMLDocument;

  function LocalizarNoPorNome(const ANode: IXMLNode; const ATagName: string): IXMLNode;
  var
    I: Integer;
    NoResultado: IXMLNode;
  begin
    Result := nil;

    if UpperCase(ANode.LocalName) = UpperCase(ATagName) then
    begin
      Result := ANode;
      Exit;
    end;

    if ANode.HasChildNodes then
    begin
      for I := 0 to ANode.ChildNodes.Count - 1 do
      begin
        NoResultado := LocalizarNoPorNome(ANode.ChildNodes[I], ATagName);
        if NoResultado <> nil then
        begin
          Result := NoResultado;
          Exit;
        end;
      end;
    end;
  end;

  function ObterTextoTag(const ATagName: string): string;
  var
    NodeFound: IXMLNode;
  begin
    Result := '';
    NodeFound := LocalizarNoPorNome(XmlDoc.DocumentElement, ATagName);
    if NodeFound <> nil then
      Result := NodeFound.Text;
  end;

begin
  Result := False;

  if fEmptyStr(AXmlString) then
    Exit;

  XmlDoc := TXMLDocument.Create(nil);
  try
    Try
      XmlDoc.Active := False;
      XmlDoc.Options := [doNodeAutoIndent];
      XmlDoc.LoadFromXML(AXmlString);
      XmlDoc.Active := True;

      If (ObterTextoTag('cStat') = '105') Then
      Begin
        Retorno.ChaveDeAcesso   := DadosGuia.ChaveDeAcesso;
        Retorno.ChaveDeApuracao := DadosGuia.ChaveDeApuracao;
        Retorno.CodigoDaReceita := fReceita;
        Retorno.CodigoConvenio  := fCodigoConvenio;

        Retorno.Boleto.Valor            := StrToFloatDef(AnsiReplaceStr(ObterTextoTag('vTot'),'.',','), 0);
        Retorno.Boleto.CodigoDeBarras   := ObterTextoTag('nBar');
        Retorno.Boleto.QrCode           := ObterTextoTag('xPix');
        Retorno.Boleto.NumeroDeControle := ObterTextoTag('nDua');

        Result := True;
      End;

      Retorno.Mensagem := ObterTextoTag('cStat') + ' - ' + ObterTextoTag('xMotivo');

     Except
       On E: Exception Do
       Begin
         Retorno.Mensagem := E.Message;
       End;
     End;
  finally
    XmlDoc := nil;
  end;
end;

function TWSGnre.fGerarGuiaSaoPaulo: Boolean;
var
  LTentativas: Integer;
begin
  LTentativas := 0;

  Componente.URL        := fWebServiceURL;
  Componente.SoapAction := 'emitir';
  Componente.MimeType   := 'application/json-patch+json; charset=utf-8';
  Componente.TimeOut    := 15000;

  pXmlRecepcao;

  repeat
    Inc(LTentativas);
    Result := fEnviar;
    Sleep(1000);

    If not Result Then
      Continue;

    If not ((Retorno.HttpStatus >= 200) and (Retorno.HttpStatus <= 299)) Then
    Begin
      Retorno.Mensagem := Format('SEFAZ retornou %d (%s).%s%s',
        [Retorno.HttpStatus, Retorno.HttpStatusText, sLineBreak,
         ExtrairMensagensErro(Retorno.XML)]);
      Result := False;
      Continue;
    End;

    If fEmptyStr(RetornaCampoJSON(Retorno.XML, 'numeroControleDarePrincipal')) Then
    Begin
      Retorno.Mensagem := ExtrairMensagensErro(Retorno.XML);
      Result := False;
    End;
  until (LTentativas = 2) Or (Result);

  If Result Then
  Begin
    Retorno.ChaveDeAcesso   := DadosGuia.ChaveDeAcesso;
    Retorno.ChaveDeApuracao := DadosGuia.ChaveDeApuracao;
    Retorno.CodigoDaReceita := fReceita;
    Retorno.CodigoConvenio  := fCodigoConvenio;

    Retorno.Boleto.Valor            := StrToFloatDef(AnsiReplaceStr(RetornaCampoJSON(Retorno.XML, 'valorTotal'),'.',','), 0);
    Retorno.Boleto.Juros            := StrToFloatDef(AnsiReplaceStr(RetornaCampoJSON(Retorno.XML, 'valorJuros'),'.',','), 0);
    Retorno.Boleto.Multa            := StrToFloatDef(AnsiReplaceStr(RetornaCampoJSON(Retorno.XML, 'valorMulta'),'.',','), 0);
    Retorno.Boleto.LinhaDigitavel   := RetornaCampoJSON(Retorno.XML, 'codigoBarra48');
    Retorno.Boleto.CodigoDeBarras   := RetornaCampoJSON(Retorno.XML, 'codigoBarra44');
    Retorno.Boleto.QrCode           := RetornaCampoJSON(Retorno.XML, 'pixCopiaCola');
    Retorno.Boleto.NumeroDeControle := RetornaCampoJSON(Retorno.XML, 'numeroControleDarePrincipal');

    Retorno.Mensagem := 'DARE-SP gerada com sucesso.';
  End
  Else
    Retorno.Mensagem := 'Não foi possível gerar DARE-SP.'+#13+ Retorno.Mensagem;

  pGravaLog('RETORNO DO LOTE', Retorno.XML, Retorno.Mensagem);
end;

function TWSGnre.fGerarGuiaPernambuco: Boolean;
var
  LURL: String;
  LTentativas: Integer;
begin
  LTentativas := 0;

  LURL := fWebServiceURL;

  Componente.MimeType := 'application/soap+xml; charset=utf-8';
  Componente.TimeOut  := 15000;

  If Configuracoes.UsarCapicom Then
  Begin
    Componente.URL := LURL + '/GnreLoteRecepcao?wsdl';

    Result := fGerarEnvio;

    if Result Then
    Begin
      Componente.URL := LURL + '/GnreResultadoLote?wsdl';

      repeat
        Inc(LTentativas);
        pTempoDeEspera(LTentativas);
        Result := fGerarRetorno;
      until (LTentativas = 2) Or (Result);
    End;
  End
  Else
  Begin
    Componente.URL := LURL + '/GnreLoteRecepcao?wsdl';
    Componente.SoapAction := 'http://www.gnre.pe.gov.br/webservice/GnreLoteRecepcao';

    Result := fGerarEnvio;

    If Result Then
    Begin
      Componente.URL := LURL + '/GnreResultadoLote?wsdl';
      Componente.SoapAction := 'http://www.gnre.pe.gov.br/webservice/GnreResultadoLote';

      repeat
        Inc(LTentativas);
        pTempoDeEspera(LTentativas);
        Result := fGerarRetorno;
      until (LTentativas = 2) Or (Result);
    End;
  End;

  If Result Then
    Result := fColetaDadosDoBoleto;

end;

function TWSGnre.fGerarGuiaEspiritoSanto: Boolean;
var
  LTentativas: Integer;
begin
  LTentativas := 0;

  Componente.URL        := fWebServiceURL;
  Componente.SoapAction := 'http://www.sefaz.es.gov.br/duae/duaEmissao';
  Componente.MimeType   := 'text/xml; charset=utf-8';
  Componente.TimeOut    := 15000;

  pXmlRecepcao;

  repeat
    Inc(LTentativas);
    Result := fEnviar;
    Sleep(1000);

    If not Result Then
      Continue;

    If not ((Retorno.HttpStatus >= 200) and (Retorno.HttpStatus <= 299)) Then
    Begin
      Retorno.Mensagem := Format('SEFAZ retornou %d (%s).', [Retorno.HttpStatus, Retorno.HttpStatusText]);
      Result := False;
      Continue;
    End;
  until (LTentativas = 2) Or (Result);

  If Result Then
    Result := LerXmlRespostaDUA(Retorno.XML)
  Else
    Retorno.Mensagem := 'Não foi possível gerar DUA-ES.'+#13+ Retorno.Mensagem;

  pGravaLog('RETORNO DO LOTE', Retorno.XML, Retorno.Mensagem);
end;

function TWSGnre.fGerarGuia: Boolean;
begin
  Result := False;

  FRegGuia := TStringList.Create;

  Try
    case TipoWebService of
            GnreSaoPaulo: Result := fGerarGuiaSaoPaulo;
          GnrePernambuco: Result := fGerarGuiaPernambuco;
       GnreEspiritoSanto: Result := fGerarGuiaEspiritoSanto;
    end;

    If Result Then
      Result := fValidaCodigoDeBarras;

    If Result Then
      Result := fValidaValorDoBoleto;

  Finally
    FreeAndNil(FRegGuia);
  End;
end;

procedure TWSGnre.pTratarFalhas;
begin
  If (pos('CONNECTION TIMED OUT'           ,UpperCase(Retorno.Mensagem)) > 0) Or
     (pos('NETWORK SUBSYSTEM IS UNUSABLE'  ,UpperCase(Retorno.Mensagem)) > 0) Then
  Begin
    Retorno.Mensagem := 'A conexão com a Sefaz esta indisponível no momento.'+#13+
                        'Aguarde alguns minutos e tente novamente.'+#13+
                        Retorno.Mensagem;

    pGravaLog('FALHA DE CONEXÃO', Retorno.XML, Retorno.Mensagem);
  End;

  If (pos('ENCODING ROUTINES' ,UpperCase(Retorno.Mensagem)) > 0) Then
  Begin
    Retorno.Mensagem := 'A senha do certificado digital contém caracteres inválidos.'+#13+
                        Retorno.Mensagem;

    pGravaLog('ERRO NO CERTIFICADO DIGITAL', Retorno.XML, Retorno.Mensagem);
  End;
end;

function TWSGnre.fEnviar:Boolean;
begin
  If TipoWebService = GnrePernambuco Then
  Begin
    If Configuracoes.UsarCapicom Then
      Result := fEnviarEmbarcaderoHttpReqResp
    Else
      Result := fEnviarSynapseHttpSend;
  End
  Else
    Result := fEnviarSynapseHttpSend;

  If not Result Then
    pTratarFalhas;
end;

end.
