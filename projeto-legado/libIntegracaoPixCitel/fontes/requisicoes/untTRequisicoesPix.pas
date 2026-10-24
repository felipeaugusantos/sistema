unit untTRequisicoesPix;

interface

Uses
 {$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untTypesSistema,
 {$ELSE}
  Forms, WinAPI.Windows,
 {$ENDIF}
  Uni, System.SysUtils, System.Classes, System.StrUtils, IdSSL, IdSSLOpenSSL,
  Json, untTiposPix, System.Generics.Collections, DateUtils,
  untInterfacesIntegracaoPixCitel, IdCoder, IdCoder3to4, IdCoderMIME,
  HTTPSend, blcksock, synautil, ssl_openssl, untIDataset;

Type
  TRequisicoesPix = class(TInterfacedObject, IRequisicoesPix)
  private
    FLinkAutenticacaoPix,
    FLinkCriarCobrancaPix,
    FLinkAlterarCobrancaPix,
    FLinkConsultarPixUnico,
    FLinkConsultaQRCode,
    FLinkSolicitarDevolucao,

    FLinkQRCodeCitelInclusao,
    FLinkQRCodeCitelExclusao,

    FVersaoAPI: String;

    FChavePix,
    FAutorizacao,
    FAppDevKey,
    FAutoIncremPix,
    FAutoIncremMovPix,
    FClientID,
    FClientSecret,
    FCodigoDoBanco,
    FPortadorConta,
    FEmpresaConfiguracao,
    FNomeEmpresaChave,
    FCidadeEmpresaChave,
    FCertificadoCRT,
    FCertificadoKey,
    FSenhaCertificado,
    FNomeCertificado,
    FHomologacao,
    FCNPJChavePix,
    FRefreshToken,
    FTxIdRemoverBancoBtg,
    FIdentificacaoConta,
    FRetornoBancoToken,
    FErroConexaoToken,

    FRequisicaoAtualizadaShipay,

    FCodigoRetornoErro: String;

    FUtilizaShipay: Boolean;
    FUtilizaTefScope: Boolean;

    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;

    FValidarErro401403,
    FTratarErroSynalist,
    FPossuiLinkCitel,
    FGravaAutorizacaoPix,
    FSicrediUsaPfx: Boolean;

    FExecutandoPeloRobo,
    FIgnorarErro404Robo: String;

    FExpiracaoQRCode: Integer;
    FCodigoHttpToken: Integer;
    FCodigoSocketToken: Integer;

    FValidadeCertificadoConta: TDateTime;

   {$IFDEF LINUX}
    FLastError: string;
   {$ENDIF}

    Const
      TIMEOUT_REQUISICOES: Integer = 30000;
      TIMEOUT_REQUISICOES_TELA: Integer = 7000;
      TOTAL_TENTATIVAS_TIMEOUT: Integer = 3;

    procedure CarregaLinksDoBanco(ACodigoDoBanco: String);
    procedure CarregaLinksDeHomologacao(ACodigoDoBanco: String);
    procedure CarregaLinksDeProducao(ACodigoDoBanco: String);
    procedure CarregaLinksTabela(ACodigoDoBanco, AAmbiente: String);

    procedure CarregaDadosChavePix(AAutoIncremPix: String);
    procedure CarregaCertificadosChavePix(ADataset: IDataset);

    function GetToken(AAutorizacao: String): String;
    function GetTokenBanco(ABanco: String): String;

    function RetornaValorCampoExistente(ADataset: IDataset;
                                        ANomeCampo: String;
                                        AValorDefaultCampoInexistente: String = ''): String;

    //SYNALIST
    procedure PreencheCertificadosSynalist(var ARequisicao: THTTPSend;
                                           ABanco: String);
    procedure OnHeartBeat(Sender: TObject);

    function GetTokenBancoSynalist(ABanco: String;
                                   AMineType: String = 'application/x-www-form-urlencoded'): String;
    function RetornaDadosRequisicaoToken(ABanco: String): String;
    function RetornaHeadersToken(ABanco: String): TStringList;
    function RetornaParametrosRefreshBtgPactual: String;

    function CriarCobrancaSynalist(ALinkRequisicao,
                                   ADadosRequisicao: String): String;
    function RetornaHeadersCobranca(ABanco: String): TStringList;
    function RetornaMimeTypeCobranca(ABanco: String): String;

    function ConsultarPixPorTxIdSynalist(ALinkRequisicao: String): String;

    function AlterarCobrancaSynalist(ALinkRequisicao,
                                     ADadosRequisicao: String): String;

    function SolicitarDevolucaoSynalist(ALinkRequisicao,
                                        ADadosDevolucao: String): String;

    function RemoverCobrancaBtgPactual(ALinkRequisicao: String): String;
    //**********

    function RetornaDescricaoErroToken(AResposta:String): String;
    function MontaMensagemErroAutenticacao(const AAmbiente: String): String;

    function RetornaRequisicaoComTextoQRCode(ARetorno: String): String;

    function GerarTxIdParaRequisicao: String;

    procedure CarregaCertificados;

    procedure ApagaArquivosDeCertificados;

    function RetornaTextoQRCodeFormatado(ADadosRetorno: TDadosRetornoPixConsulta): String;

    procedure OnGetPassword(var Password: String);

    procedure AguardaAtualizacao(ATempoAguardar: Int64);

    procedure LimparDadosDeTokensECertificados;

    function RefazerConsultaPorTxId(ATxIdPix: String; AString: Boolean): String;

    procedure ValidacoesIniciaisParaUsoDaRotina;

    function IncluirQRCodePixBaseCitel(ADadosRetorno,
                                       ARequisicao: String;
                                       ATransactionType: String = ''): String;

    procedure GravarToken(AAccessToken: String;
                          AExpiracao: Integer);
    function RetornaTokenDB(out AExpiracao: Integer;
                            out ADataCriacao: TDateTime): String;
    function SelecionaTokenChaveGravado: String;

    procedure VerificaSeRetornouErro(ARetorno: String);
    function RetornaCodigoRespostaErro: Integer;

    procedure GravarLOGERR_PixToken(AMensagemErroRequisicao,
                                    AMensagemErroDelphi,
                                    ADadosRequisicao,
                                    ALinkRequisicao: String);

    procedure GravarLOGERR_PixTipo(AMensagemErroRequisicao,
                                   AMensagemErroDelphi,
                                   ADadosRequisicao,
                                   ALinkRequisicao,
                                   ATxIdPix: String;
                                   ATipoRequisicao: TTipoRequisicaoPix);

    function TrataErroConsultaTxId(AException: Exception;
                                   ATxIdPix: String;
                                   AString: Boolean): String;

    function TrataErroCriarCobrancaTxId(AException: Exception;
                                        ATxIdPix,
                                        ADadosRequisicao,
                                        ALinkRequisicao: String): String;

    function TrataErroToken(AException: Exception;
                            ADadosParametros,
                            ALinkRequisicao: String): String;

    function RetornaValorCampoCasoExista(ADataset: IDataset;
                                         ACampo: String;
                                         AValorDefault: String = ''): String;

    procedure LimparTabelaTokens;

    function DeveIgnorarErro404: Boolean;
  public
    constructor Create; overload;
    constructor Create(AAutoIncremPix: String); overload;
    constructor Create(AAutoIncremPix,
                       AEmpresaChave: String); overload;
    destructor Destroy; override;

    procedure VerificarToken;

    function CriarCobranca(ADadosRequisicao: String): String; overload;

    function AlterarCobranca(ADadosRequisicao,
                             ATxIdPix: String): String;

    function ConsultarPixPorTxId(ATxIdPix: String): TDadosRetornoPixConsulta; overload;
    function ConsultarPixPorTxId(ATxIdPix: String; AString: Boolean): String; overload;

    function GetDadosRequisicaoPixAVista: TDadosRequisicaoPixAVista;

    function GetChavePix: String;

    function GetAutoIncremMovPix: String;

    function SolicitarDevolucao(AIDPagamento, AIdDevolucao, ADadosDevolucao: String): String;

    function ConsultarDevolucao(AIDPagamento, AIdDevolucao: String): String;

    function ValidarDadosAutenticacao: String;

    function CancelarCobrancaShipay(AOrderId: String): String;

    function ConsultarPixPorTxId(ATxIdPix: String; AString: Boolean; ADadosRequisicao: String): String; overload;

    function GetRequisicaoPixAtualizadaShipay: String;

    function RemoverQRCodePixBaseCitel(ACNPJEmpresa, ACodigoEmpresa, AIxIdPix: String; AGravarLogErr: Boolean): Boolean;

    procedure SetExecutandoPeloRobo(AValor: String);

    function IncluirQRCodePixBoletoBaseCitel(ACodigoBanco,
                                             ATxIdPix,
                                             AQRCodePix,
                                             ADataCriacao,
                                             AExpiracao,
                                             AValorPix: String): String;

    function RetornaRefreshTokenGerado(ACodigoBanco,
                                       AAutoIncremChavePix: String): String;

    function GetCodigoDoBanco: String;

   {$IFDEF LINUX}
    function GetLastError: string;
   {$ENDIF}
    function CriarCobrancaTefScope(const ACorpoRequisicao: String;
                                   out   AJsonRequest,
                                         AJsonResponse,
                                         AJsonDados: String): boolean;

    procedure SetTxIdRemoverBancoBtg(ATxIdRemover: String);

    procedure SetIgnorarErro404Robo(AValor: String);

    function CriarCobranca(ADadosRequisicao: String; ATransactionType: String = ''): String; overload;
  end;

Var
  VS_ListaToken: TList<TDadosToken>;
  VS_ListaCertificados: TList<TDadosCertificado>;

implementation

Uses
{$IFDEF LINUX}
{$ELSE}
  untWorkStationInfo,
{$ENDIF}
  untTRequisicoesPixLib, untTFuncoesAuxiliaresPix, untFuncoesSimples,
  untTRequisicoesCitelPix, untInterfacePixTefBridge;

{ TRequisicoesPix }

procedure TRequisicoesPix.AguardaAtualizacao(ATempoAguardar: Int64);
begin
  If MatchStr(FCodigoDoBanco, ['341', '756','422']) Then
    Sleep(ATempoAguardar);

  Application.ProcessMessages;
end;

function TRequisicoesPix.AlterarCobranca(ADadosRequisicao,
  ATxIdPix: String): String;
  var
    LLinkCobranca: String;

    LRespostaRequiscao: Integer;
begin
  Result := EmptyStr;

  Try
    ValidacoesIniciaisParaUsoDaRotina;

    CarregaCertificados;

    ADadosRequisicao := TFuncoesPix.RetornaDadosAlteracao(ADadosRequisicao,
                                                          FCodigoDoBanco);

    LLinkCobranca :=  FLinkAlterarCobrancaPix.Replace('[APP_DEV_KEY]', FAppDevKey)
                                             .Replace('[TXID]', ATxIdPix)
                                             .Replace('[CNPJ]', FCNPJChavePix);

    Application.ProcessMessages;

    If FCodigoDoBanco.Equals('208') Then
    Begin
      Try
        RemoverQRCodePixBaseCitel(untFuncoesSimples.RetornaCNPJEmpresaSelecionada(FEmpresaConfiguracao),
                                  FEmpresaConfiguracao,
                                  IIF(FTxIdRemoverBancoBtg.IsEmpty, ATxIdPix, FTxIdRemoverBancoBtg),
                                  True);

        Result := RemoverCobrancaBtgPactual(LLinkCobranca.Replace('[ORD_REF]', ATxIdPix));

        VerificaSeRetornouErro(Result);

        Exit;
      Finally
        FTxIdRemoverBancoBtg := EmptyStr;
      End;
    End;

    Result := AlterarCobrancaSynalist(LLinkCobranca,
                                      ADadosRequisicao.Replace(#13, EmptyStr));

    VerificaSeRetornouErro(Result);

    If Pos('REMOVIDA_PELO_USUARIO_RECEBEDOR', Result) > 0 Then
      RemoverQRCodePixBaseCitel(untFuncoesSimples.RetornaCNPJEmpresaSelecionada(FEmpresaConfiguracao),
                                FEmpresaConfiguracao,
                                ATxIdPix,
                                True);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}

      GravarLOGERR_PixTipo('',
                           E.Message,
                           ADadosRequisicao.Replace(#13, EmptyStr),
                           FLinkAlterarCobrancaPix.Replace('[TXID]', ATxIdPix)
                                                  .Replace('[APP_DEV_KEY]', FAppDevKey),
                           ATxIdPix,
                           trpAlterarCobranca);

      If TFuncoesPix.RetornaMensagemErroRequisicao(E.Message).IsEmpty Then
      Begin
        LRespostaRequiscao := RetornaCodigoRespostaErro;

        Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                           'Ocorreu um erro ao alterar a cobrança Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                           'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco  + IIF(FUtilizaShipay, 'S', ''),
                                                                                               LRespostaRequiscao.ToString,
                                                                                               E.Message,
                                                                                               E.Message),
                                           '');
      End
      Else
        Result := E.Message;
    End;
  End;
end;

function TRequisicoesPix.AlterarCobrancaSynalist(ALinkRequisicao,
  ADadosRequisicao: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta: String;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesPix.AlterarCobrancaSynalist');
 {$ENDIF}

  FTratarErroSynalist := True;

  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := RetornaMimeTypeCobranca(FCodigoDoBanco);
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.AddStrings(RetornaHeadersCobranca(FCodigoDoBanco));
      PreencheCertificadosSynalist(LHTTPSend, FCodigoDoBanco);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( TIMEOUT_REQUISICOES );
      LHTTPSend.Sock.ConnectionTimeout   := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.SocksTimeout        := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.HTTPTunnelTimeout   := TIMEOUT_REQUISICOES;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(ADadosRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      Try
        If LHTTPSend.HTTPMethod('PATCH', ALinkRequisicao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result := LResposta;

            If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
              Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                               LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End
        Else
          TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                 LHTTPSend.Sock.LastErrorDesc);
      Finally
        GravarLogAPI('TRequisicoesPix.AlterarCobrancaSynalist', ALinkRequisicao, 'PATCH', ADadosRequisicao, LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}
      Result := TFuncoesPix.RetornaResultadoRequisicao('-1',
                                                       E.Message);
    End;
  End;
end;

procedure TRequisicoesPix.ApagaArquivosDeCertificados;
  Var
    LCertificado: TDadosCertificado;
begin
  Try
    For LCertificado In VS_ListaCertificados Do
    Begin
      If FileExists(LCertificado.ArquivoCRT) Then
        DeleteFile(PChar(LCertificado.ArquivoCRT));

      If FileExists(LCertificado.ArquivoKey) Then
        DeleteFile(PChar(LCertificado.ArquivoKey));
    End;

    VS_ListaCertificados.Clear;
  Except

  end;
end;

function TRequisicoesPix.CancelarCobrancaShipay(AOrderId: String): String;
  Var
    LErro: String;
begin
  Result := TRequisicoesPixLib.CancelarCobrancaShipay(FCodigoDoBanco + 'S',
                                                      FLinkAlterarCobrancaPix.Replace('[TXID]', AOrderId),
                                                      FNomeCertificado,
                                                      GetToken(FAutorizacao),
                                                      FClientID,
                                                      FClientSecret);

  LErro := TFuncoesPix.RetornaMensagemErroRequisicao(Result);
  If Not LErro.IsEmpty Then
    GravarLOGERR_PixTipo('',
                         Result,
                         '',
                         FLinkAlterarCobrancaPix.Replace('[TXID]', AOrderId),
                         AOrderId,
                         trpAlterarCobranca);

  RemoverQRCodePixBaseCitel(untFuncoesSimples.RetornaCNPJEmpresaSelecionada(FEmpresaConfiguracao),
                            FEmpresaConfiguracao,
                            AOrderId,
                            True);
end;

procedure TRequisicoesPix.CarregaCertificados;
  Var
    LCertificado: TDadosCertificado;

    LStream: TMemoryStream;

    LDecoder: TIdDecoderMIME;

    LConnectionID: String;
    LPastaCertificado: String;
begin
  FProtocoloSSL.SSLOptions.CertFile := '';
  FProtocoloSSL.SSLOptions.KeyFile := '';

  If FCertificadoCRT.IsEmpty Then
    Exit;

  For LCertificado In VS_ListaCertificados Do
  Begin
    If Concat(LCertificado.Banco, LCertificado.Empresa, LCertificado.Portador) = Concat(FCodigoDoBanco, FEmpresaConfiguracao, FPortadorConta) Then
    Begin
      FProtocoloSSL.SSLOptions.CertFile := LCertificado.ArquivoCRT;
      FProtocoloSSL.SSLOptions.KeyFile := LCertificado.ArquivoKey;
      FProtocoloSSL.OnGetPassword := OnGetPassword;
      FProtocoloSSL.SSLOptions.Mode := sslmBoth;
      FProtocoloSSL.DefaultPort := 443;

      Exit;
    End;
  End;

  LPastaCertificado := ExtractFilePath(Application.ExeName)+'temp'+PathDelim;

  If Not DirectoryExists(LPastaCertificado) Then
    CreateDir(ExtractFilePath(LPastaCertificado));

  LConnectionID := fGetConnectionID;

  LDecoder := TIdDecoderMIME.Create(nil);
  LStream := TMemoryStream.Create;
  try
    LDecoder.DecodeStream(FCertificadoCRT, LStream);

    LStream.SaveToFile(LPastaCertificado + 'aut' + LConnectionID +
                                                   VS_FuncoesExternas.fGetEmpresaLogada +
                                                   VS_FuncoesExternas.fIRetOperadorLogado + 'r');
  finally
    LDecoder.Free;
    LStream.Free;
  end;

  AguardaAtualizacao(400);

  LDecoder := TIdDecoderMIME.Create(nil);
  LStream := TMemoryStream.Create;
  try
    LDecoder.DecodeStream(FCertificadoKey, LStream);

    LStream.SaveToFile(LPastaCertificado + 'aut' + LConnectionID +
                                                   VS_FuncoesExternas.fGetEmpresaLogada +
                                                   VS_FuncoesExternas.fIRetOperadorLogado + 'y');
  finally
    LDecoder.Free;
    LStream.Free;
  end;

  AguardaAtualizacao(400);

  LCertificado := TDadosCertificado.Create;
  LCertificado.Banco := FCodigoDoBanco;
  LCertificado.Empresa := FEmpresaConfiguracao;
  LCertificado.Portador := FPortadorConta;
  LCertificado.ArquivoCRT := LPastaCertificado + 'aut' + LConnectionID +
                                                         VS_FuncoesExternas.fGetEmpresaLogada +
                                                         VS_FuncoesExternas.fIRetOperadorLogado + 'r';
  LCertificado.ArquivoKey := LPastaCertificado + 'aut' + LConnectionID +
                                                         VS_FuncoesExternas.fGetEmpresaLogada +
                                                         VS_FuncoesExternas.fIRetOperadorLogado + 'y';

  VS_ListaCertificados.Add(LCertificado);

  FProtocoloSSL.SSLOptions.CertFile := LCertificado.ArquivoCRT;
  FProtocoloSSL.SSLOptions.KeyFile := LCertificado.ArquivoKey;
  FProtocoloSSL.SSLOptions.Mode := sslmBoth;
  FProtocoloSSL.DefaultPort := 443;

  FProtocoloSSL.OnGetPassword := OnGetPassword;
end;

procedure TRequisicoesPix.CarregaCertificadosChavePix(ADataset: IDataset);
  Var
    LConsulta: IDataset;
begin
  FCertificadoCRT := ADataset.FieldByName('CCA_ARQCRT').AsString;
  FCertificadoKey := ADataset.FieldByName('CCA_ARQKEY').AsString;

  FSenhaCertificado := ADataset.FieldByName('CCA_SENCER').AsString;

  If MatchStr(FCodigoDoBanco, ['001', '033', '756', '290','422']) Then
  Begin
    FCertificadoCRT := ADataset.FieldByName('CCA_ARQPFX').AsString;
    FCertificadoKey := ADataset.FieldByName('CCA_ARQPFX').AsString;
  End;

  If FCodigoDoBanco.Equals('748') Then
  Begin
    FSicrediUsaPfx := RetornaValorCampoExistente(ADataset, 'CCA_SICPFX', 'S').Equals('S');
    If FSicrediUsaPfx Then
    Begin
      FCertificadoCRT := ADataset.FieldByName('CCA_ARQPFX').AsString;
      FCertificadoKey := ADataset.FieldByName('CCA_ARQPFX').AsString;
    End;
  End;

  If RetornaValorCampoExistente(ADataset, 'CCA_PARCIT').Equals('S') Then
  Begin
    If Not FCodigoDoBanco.Equals('033') Then
      Exit;

    LConsulta := VS_FuncoesExternas.fGetDataSet;
    LConsulta.SQL := 'SELECT * FROM ATBCER WHERE CER_CODBCO="033"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    FCertificadoCRT := LConsulta.FieldByName('CER_ARQPFX').AsString;
    FCertificadoKey := LConsulta.FieldByName('CER_ARQPFX').AsString;

    FSenhaCertificado := fDecrypt(LConsulta.FieldByName('CER_SENCER').AsString);
  End;
end;

procedure TRequisicoesPix.CarregaDadosChavePix(AAutoIncremPix: String);
  Var
    LConsulta: IDataSet;
begin
  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT P.PIX_CHAVE_, ' +
                   '       POR.POR_CODPOR, ' +
                   '       E.EMP_NOMEMP, ' +
                   '       E.EMP_C_G_C_, ' +
                   '       CID.CID_NOMCID, ' +
                   '       C.* ' +
                   'FROM CCAPIX P ' +
                   'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                   'LEFT JOIN CADPOR POR ON POR.POR_CCAAUT=C.AUTOINCREM ' +
                   'JOIN CADEMP E ON E.EMP_CODEMP=C.CCA_CODEMP ' +
                   'LEFT JOIN CADCID CID ON CID.CID_CODCID=E.EMP_CODCID ' +
                   'WHERE P.AUTOINCREM="' + AAutoIncremPix + '"';

  LConsulta.Open;

  FChavePix := LConsulta.FieldByName('PIX_CHAVE_').AsString;
  FAutorizacao := LConsulta.FieldByName('CCA_AUTPIX').AsString;
  FAppDevKey := LConsulta.FieldByName('CCA_APPPIX').AsString;
  FCodigoDoBanco := LConsulta.FieldByName('CCA_CODBCO').AsString;
  FPortadorConta := LConsulta.FieldByName('POR_CODPOR').AsString;
  FAutoIncremPix := AAutoIncremPix;
  FNomeEmpresaChave := LConsulta.FieldByName('EMP_NOMEMP').AsString;
  FCidadeEmpresaChave := LConsulta.FieldByName('CID_NOMCID').AsString;
  FCNPJChavePix := LConsulta.FieldByName('EMP_C_G_C_').AsString;

  FIdentificacaoConta := 'empresa ' + RetornaValorCampoCasoExista(LConsulta, 'CCA_CODEMP', '') +
                         ', agência ' + RetornaValorCampoCasoExista(LConsulta, 'CCA_AGENCI', '') +
                         ', conta ' + RetornaValorCampoCasoExista(LConsulta, 'CCA_CODCTA', '');

  FValidadeCertificadoConta := 0;
  If Not RetornaValorCampoCasoExista(LConsulta, 'CCA_VALCER', '').IsEmpty Then
    FValidadeCertificadoConta := LConsulta.FindField('CCA_VALCER').AsDateTime;

  FRefreshToken := EmptyStr;

  FClientID := EmptyStr;
  FClientSecret := EmptyStr;
  FNomeCertificado := EmptyStr;
  FSicrediUsaPfx := False;
  If LConsulta.FindField('CCA_CLI_ID') <> Nil Then
  Begin
    FClientID := LConsulta.FieldByName('CCA_CLI_ID').AsString;
    FClientSecret := LConsulta.FieldByName('CCA_CLISEC').AsString;

    CarregaCertificadosChavePix(LConsulta);

    End;

  If LeftStr(FAutorizacao, 6) <> 'Basic ' Then
    FAutorizacao := 'Basic ' + FAutorizacao;

  FNomeCertificado := RetornaValorCampoCasoExista(LConsulta, 'CCA_NOMCER', '');

  FUtilizaShipay := RetornaValorCampoCasoExista(LConsulta, 'CCA_USASHP', 'N') = 'S';
  FUtilizaTefScope := (Assigned(objBridgeTef)) and (RetornaValorCampoCasoExista(LConsulta, 'CCA_PIXSCP', 'N') = 'S');

  FVersaoAPI := RetornaValorCampoCasoExista(LConsulta, 'CCA_VERAPI', '1');

  Try
    LConsulta.SQL := 'SELECT * FROM MOVPIX WHERE FALSE';
    LConsulta.Open;

    FPossuiLinkCitel := LConsulta.FindField('MPX_LNKCIT') <> Nil;
  Except
    FPossuiLinkCitel := False;
  End;

  LConsulta.Close;
  LConsulta.SQL := 'SHOW TABLES LIKE "AUTPIX"';
  LConsulta.Open;
  FGravaAutorizacaoPix := Not LConsulta.IsEmpty;

  LConsulta.Close;

  If Not TryStrToInt(untFuncoesSimples.fCfgSis('CFG_EXPPIX', VS_FuncoesExternas.fGetEmpresaLogada), FExpiracaoQRCode) Then
    FExpiracaoQRCode := 24;

  FExpiracaoQRCode := FExpiracaoQRCode * 60 * 60;
end;

procedure TRequisicoesPix.CarregaLinksDeHomologacao(ACodigoDoBanco: String);
begin
  If FUtilizaShipay Then
  Begin
    FLinkAutenticacaoPix := 'https://api-staging.shipay.com.br/pdvauth';
    FLinkCriarCobrancaPix := 'https://api-staging.shipay.com.br/order';
    FLinkAlterarCobrancaPix := 'https://api-staging.shipay.com.br/order/[TXID]';
    FLinkConsultarPixUnico := 'https://api-staging.shipay.com.br/order/[TXID]';
    FLinkSolicitarDevolucao := 'https://api-staging.shipay.com.br/order/[TXID]/refund';
  End
  Else If ACodigoDoBanco = '001' Then
  Begin
    FLinkAutenticacaoPix := 'https://oauth.hm.bb.com.br/oauth/token';
    FLinkCriarCobrancaPix := 'https://api.hm.bb.com.br/pix/v1/cobqrcode/?gw-dev-app-key=[APP_DEV_KEY]';
    FLinkAlterarCobrancaPix := 'https://api.hm.bb.com.br/pix/v1/cob/[TXID]?gw-dev-app-key=[APP_DEV_KEY]';
    FLinkConsultarPixUnico := 'https://api.hm.bb.com.br/pix/v1/cob/[TXID]?gw-dev-app-key=[APP_DEV_KEY]';
    FLinkSolicitarDevolucao := 'https://api.hm.bb.com.br/pix/v1/pix/[E2ID]/devolucao/[ID]?gw-dev-app-key=[APP_DEV_KEY]';

    If FVersaoAPI = '2' Then
    Begin
      FLinkAutenticacaoPix := 'https://oauth.hm.bb.com.br/oauth/token';
      FLinkCriarCobrancaPix := 'https://api.hm.bb.com.br/pix/v2/cob';
      FLinkAlterarCobrancaPix := 'https://api.hm.bb.com.br/pix/v2/cob/[TXID]';
      FLinkConsultarPixUnico := 'https://api.hm.bb.com.br/pix/v2/cob/[TXID]';
      FLinkSolicitarDevolucao := 'https://api.hm.bb.com.br/pix/v2/pix/[E2ID]/devolucao/[ID]';
    End;
  End
  Else If ACodigoDoBanco = '756' Then
  Begin
    FLinkAutenticacaoPix := 'https://api-homol.sicoob.com.br/cooperado/pix/token';
    FLinkCriarCobrancaPix := 'https://api-homol.sicoob.com.br/cooperado/pix/api/v2/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://api-homol.sicoob.com.br/cooperado/pix/api/v2/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://api-homol.sicoob.com.br/cooperado/pix/api/v2/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://api-homol.sicoob.com.br/cooperado/pix/api/v2/pix/[E2ID]/devolucao/[ID]';
  End
  Else If ACodigoDoBanco = '748' Then
  Begin
    FLinkAutenticacaoPix := 'https://api-pix-h.sicredi.com.br/oauth/token?grant_type=client_credentials&scope=cob.read+cob.write+pix.read';
    FLinkCriarCobrancaPix := 'https://api-pix-h.sicredi.com.br/api/v2/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://api-pix-h.sicredi.com.br/api/v2/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://api-pix-h.sicredi.com.br/api/v2/cob/[TXID]';
  End
  Else If ACodigoDoBanco = '290' Then
  Begin
    FLinkAutenticacaoPix := 'https://secure.sandbox.api.pagseguro.com/pix/oauth2';
    FLinkCriarCobrancaPix := 'https://secure.sandbox.api.pagseguro.com/instant-payments/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://secure.sandbox.api.pagseguro.com/instant-payments/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://secure.sandbox.api.pagseguro.com/instant-payments/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://secure.sandbox.api.pagseguro.com/instant-payments/pix/[E2ID]/devolucao/[ID]';
  End
  Else If ACodigoDoBanco = '208' Then
  Begin
    FLinkAutenticacaoPix := 'https://id.sandbox.btgpactual.com/oauth2/token';
    FLinkCriarCobrancaPix := 'https://api.sandbox.empresas.btgpactual.com/v1/companies/[CNPJ]/pix-cash-in/instant-collections';
    FLinkAlterarCobrancaPix := 'https://api.sandbox.empresas.btgpactual.com/v1/companies/[CNPJ]/pix-cash-in/locations/[ORD_REF]';
    FLinkConsultarPixUnico := 'https://api.sandbox.empresas.btgpactual.com/v1/companies/[CNPJ]/pix-cash-in/instant-collections?' +
                              'initialDate=[INITIAL_DATE]&finalDate=[FINAL_DATE]';
  End
  Else If ACodigoDoBanco = '422' Then
  Begin
    FLinkAutenticacaoPix := 'https://api.pix-h.safra.com.br/oauth/token';
    FLinkCriarCobrancaPix := 'https://api.pix-h.safra.com.br/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://api.pix-h.safra.com.br/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://api.pix-h.safra.com.br/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://api.pix-h.safra.com.br/pix/[E2ID]/devolucao/[ID]';
  End;

  CarregaLinksTabela(ACodigoDoBanco, 'H');
end;

procedure TRequisicoesPix.CarregaLinksDeProducao(ACodigoDoBanco: String);
begin
  If FUtilizaShipay Then
  Begin
    FLinkAutenticacaoPix := 'https://api-conexaoitau.shipay.com.br/pdvauth';
    FLinkCriarCobrancaPix := 'https://api-conexaoitau.shipay.com.br/order';
    FLinkAlterarCobrancaPix := 'https://api-conexaoitau.shipay.com.br/order/[TXID]';
    FLinkConsultarPixUnico := 'https://api-conexaoitau.shipay.com.br/order/[TXID]';
    FLinkSolicitarDevolucao := 'https://api-conexaoitau.shipay.com.br/order/[TXID]/refund';
  End
  Else If ACodigoDoBanco = '001' Then
  Begin
    FLinkAutenticacaoPix := 'https://oauth.bb.com.br/oauth/token';
    FLinkCriarCobrancaPix := 'https://api.bb.com.br/pix/v1/cobqrcode/?gw-dev-app-key=[APP_DEV_KEY]';
    FLinkAlterarCobrancaPix := 'https://api.bb.com.br/pix/v1/cob/[TXID]?gw-dev-app-key=[APP_DEV_KEY]';
    FLinkConsultarPixUnico := 'https://api.bb.com.br/pix/v1/cob/[TXID]?gw-dev-app-key=[APP_DEV_KEY]';
    FLinkSolicitarDevolucao := 'https://api.bb.com.br/pix/v1/pix/[E2ID]/devolucao/[ID]?gw-dev-app-key=[APP_DEV_KEY]';

     If FVersaoAPI = '2' Then
     Begin
       FLinkAutenticacaoPix := 'https://oauth.bb.com.br/oauth/token';
       FLinkCriarCobrancaPix := 'https://api-pix.bb.com.br/pix/v2/cob';
       FLinkAlterarCobrancaPix := 'https://api-pix.bb.com.br/pix/v2/cob/[TXID]';
       FLinkConsultarPixUnico := 'https://api-pix.bb.com.br/pix/v2/cob/[TXID]';
       FLinkSolicitarDevolucao := 'https://api-pix.bb.com.br/pix/v2/pix/[E2ID]/devolucao/[ID]';
     End;
  End
  Else If ACodigoDoBanco = '756' Then
  Begin
    FLinkAutenticacaoPix := 'https://auth.sicoob.com.br/auth/realms/cooperado/protocol/openid-connect/token';
    FLinkCriarCobrancaPix := 'https://api.sicoob.com.br/pix/api/v2/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://api.sicoob.com.br/pix/api/v2/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://api.sicoob.com.br/pix/api/v2/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://api.sicoob.com.br/pix/api/v2/pix/[E2ID]/devolucao/[ID]';
  End
  Else If ACodigoDoBanco = '748' Then
  Begin
    FLinkAutenticacaoPix := 'https://api-pix.sicredi.com.br/oauth/token?grant_type=client_credentials&scope=cob.read+cob.write+pix.read';
    FLinkCriarCobrancaPix := 'https://api-pix.sicredi.com.br/api/v2/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://api-pix.sicredi.com.br/api/v2/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://api-pix.sicredi.com.br/api/v2/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://api-pix.sicredi.com.br/api/v2/pix/[E2ID]/devolucao/[ID]';
  End
  Else If ACodigoDoBanco = '290' Then
  Begin
    FLinkAutenticacaoPix := 'https://secure.api.pagseguro.com/pix/oauth2';
    FLinkCriarCobrancaPix := 'https://secure.api.pagseguro.com/instant-payments/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://secure.api.pagseguro.com/instant-payments/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://secure.api.pagseguro.com/instant-payments/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://secure.api.pagseguro.com/instant-payments/pix/[E2ID]/devolucao/[ID]';
  End
  Else If ACodigoDoBanco = '208' Then
  Begin
    FLinkAutenticacaoPix := 'https://id.btgpactual.com/oauth2/token';
    FLinkCriarCobrancaPix := 'https://api.empresas.btgpactual.com/v1/companies/[CNPJ]/pix-cash-in/instant-collections';
    FLinkAlterarCobrancaPix := 'https://api.empresas.btgpactual.com/v1/companies/[CNPJ]/pix-cash-in/locations/[ORD_REF]';
    FLinkConsultarPixUnico := 'https://api.empresas.btgpactual.com/v1/companies/[CNPJ]/pix-cash-in/instant-collections?' +
                              'initialDate=[INITIAL_DATE]&finalDate=[FINAL_DATE]&locationId=[TXID]';
  End
  Else If ACodigoDoBanco = '422' Then
  Begin
    FLinkAutenticacaoPix := 'https://api.pix.safra.com.br/oauth/token';
    FLinkCriarCobrancaPix := 'https://api.pix.safra.com.br/cob/[TXID]';
    FLinkAlterarCobrancaPix := 'https://api.pix.safra.com.br/cob/[TXID]';
    FLinkConsultarPixUnico := 'https://api.pix.safra.com.br/cob/[TXID]';
    FLinkSolicitarDevolucao := 'https://api.pix.safra.com.br/pix/[E2ID]/devolucao/[ID]';
  End;

  CarregaLinksTabela(ACodigoDoBanco, 'P');
end;

procedure TRequisicoesPix.CarregaLinksDoBanco(ACodigoDoBanco: String);
begin
  FHomologacao := fCfgSis('HOMPIX', FEmpresaConfiguracao);

  FLinkCriarCobrancaPix := EmptyStr;
  FLinkAlterarCobrancaPix := EmptyStr;
  FLinkConsultarPixUnico := EmptyStr;
  FLinkAutenticacaoPix := EmptyStr;
  FLinkConsultaQRCode := EmptyStr;
  FLinkSolicitarDevolucao := EmptyStr;

  FLinkQRCodeCitelInclusao := 'https://pix.citelsoftware.com.br/';
  FLinkQRCodeCitelExclusao := 'https://pix.citelsoftware.com.br/[CNPJ]/[CODEMP]/[TXID]';

  CarregaLinksDeProducao(ACodigoDoBanco);
  If FHomologacao.Equals('S') Then
    CarregaLinksDeHomologacao(ACodigoDoBanco);
end;

procedure TRequisicoesPix.CarregaLinksTabela(ACodigoDoBanco,
  AAmbiente: String);
  Var
    LConsulta: IDataSet;

    LChaveAmbiente: String;

    LCampoVersaoExiste: Boolean;
begin
  //A PEDIDO DO RONALDO, SERÃO CARREGADOS OS LINKS APENAS PELA TABELA
  If Not fTabelaExiste('LNKBCO') Then
    Raise Exception.Create('Tabela dos links do Pix não existe. Entre em contato com a Citel.');

  LCampoVersaoExiste := fCampoExiste('LNKBCO', 'LNK_VERAPI');

  LChaveAmbiente := 'PROD';
  If AAmbiente.Equals('H') Then
    LChaveAmbiente := 'HOM';

  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT * ' +
                   'FROM LNKBCO ' +
                   'WHERE LNK_CODBCO=:CODBCO ' +
                   '  AND LNK_ROTINA="PIX" ' +
                   '  AND LNK_TIPAMB=:TIPAMB ';

  If LCampoVersaoExiste Then
  Begin
    If MatchStr(FVersaoAPI, ['1', EmptyStr]) Then
      LConsulta.SQL := LConsulta.SQL +
                       '  AND LNK_VERAPI IN ("1", "") '
    Else
      LConsulta.SQL := LConsulta.SQL +
                       '  AND LNK_VERAPI = "' + FVersaoAPI + '" ';
  End;

  LConsulta.SQL := LConsulta.SQL +
                   '  AND TRIM(COALESCE(LNK_URLLNK, "")) <> "" ' +

                   'UNION ' +

                   'SELECT * ' +
                   'FROM LNKBCO ' +
                   'WHERE LNK_CODBCO="999" ' +
                   '  AND LNK_ROTINA="CITEL" ' +
                   '  AND LNK_TIPAMB="P" ' +
                   '  AND TRIM(COALESCE(LNK_URLLNK, "")) <> "" ';

  LConsulta.ParamByName('CODBCO').AsString := ACodigoDoBanco;
  LConsulta.ParamByName('TIPAMB').AsString := AAmbiente;

  LConsulta.Open;

  If LConsulta.Locate('LNK_CHAVE_', 'TOKEN_PIX_' + LChaveAmbiente, []) Then
    FLinkAutenticacaoPix := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'CRIAR_PIX_' + LChaveAmbiente, []) Then
    FLinkCriarCobrancaPix := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_TXID_' + LChaveAmbiente, []) Then
    FLinkConsultarPixUnico := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'ALTERAR_PIX_' + LChaveAmbiente, []) Then
    FLinkAlterarCobrancaPix := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'CONSULTA_QR_' + LChaveAmbiente, []) Then
    FLinkConsultaQRCode := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'SOLICITA_DEV_' + LChaveAmbiente, []) Then
    FLinkSolicitarDevolucao := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'INCLUIR_LINK_QR_CITEL', []) Then
    FLinkQRCodeCitelInclusao := LConsulta.FieldByName('LNK_URLLNK').AsString;

  If LConsulta.Locate('LNK_CHAVE_', 'EXCLUIR_LINK_QR_CITEL', []) Then
    FLinkQRCodeCitelExclusao := LConsulta.FieldByName('LNK_URLLNK').AsString;

  LConsulta.Close;

  If Concat(FLinkAutenticacaoPix, FLinkCriarCobrancaPix).IsEmpty Then
    Raise Exception.Create('Links do Pix do banco ' + ACodigoDoBanco + ' não mapeados. Entre em contato com a Citel.');
end;

function TRequisicoesPix.ConsultarDevolucao(AIDPagamento,
  AIdDevolucao: String): String;
  var
    LLinkRequisicao: String;

    LRespostaRequiscao: Integer;
begin
  Try
    ValidacoesIniciaisParaUsoDaRotina;

    CarregaCertificados;

    Application.ProcessMessages;

    LLinkRequisicao := FLinkSolicitarDevolucao.Replace('[APP_DEV_KEY]', FAppDevKey);
    LLinkRequisicao := LLinkRequisicao.Replace('[E2ID]', AIDPagamento);
    LLinkRequisicao := LLinkRequisicao.Replace('[ID]', AIDDevolucao);

    Result := ConsultarPixPorTxIdSynalist(LLinkRequisicao);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}
      If TFuncoesPix.RetornaMensagemErroRequisicao(E.Message).IsEmpty Then
      Begin
        LRespostaRequiscao := RetornaCodigoRespostaErro;

        Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                           'Ocorreu um erro ao consultar a devolução Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                               'Erro gerado: ' + E.Message, '');
      End
      Else
        Result := E.Message;
    End;
  End;
end;

function TRequisicoesPix.ConsultarPixPorTxId(ATxIdPix: String; AString: Boolean): String;
  Var
    LLinkConsulta: String;
begin
  Result := '';

  Try
    ValidacoesIniciaisParaUsoDaRotina;

    If FUtilizaShipay Then
    Begin
      Result := TRequisicoesPixLib.ConsultarCobrancaPorOrderIdShipay(FCodigoDoBanco + 'S',
                                                                     FLinkConsultarPixUnico.Replace('[TXID]', ATxIdPix),
                                                                     FNomeCertificado,
                                                                     GetToken(FAutorizacao),
                                                                     FClientID,
                                                                     FClientSecret);

      VerificaSeRetornouErro(Result);

      Exit;
    End;

    CarregaCertificados;

    LLinkConsulta := FLinkConsultarPixUnico.Replace('[APP_DEV_KEY]', FAppDevKey);
    LLinkConsulta := LLinkConsulta.Replace('[TXID]', ATxIdPix)
                                  .Replace('[CNPJ]', FCNPJChavePix);

    If FCodigoDoBanco.Equals('208') Then
      LLinkConsulta := LLinkConsulta.Replace('[INITIAL_DATE]', TFuncoesPix.TransformaTDateTimeEmStringZulu(IncMonth(fNow, -1)))
                                    .Replace('[FINAL_DATE]', TFuncoesPix.TransformaTDateTimeEmStringZulu(IncSecond(fNow, +15)));

    If FVersaoAPI = '2' Then
      AguardaAtualizacao(800);

    If MatchStr(FCodigoDoBanco, ['756', '422']) Then
      AguardaAtualizacao(800);

    Result := ConsultarPixPorTxIdSynalist(LLinkConsulta);

    VerificaSeRetornouErro(Result);

    If FCodigoDoBanco.Equals('033') Then
      Result := TFuncoesPix.CorrigeDadosRetorno(Result)
    Else If FCodigoDoBanco.Equals('208') Then
      Result := TFuncoesPix.RetornaCobrancaPorTxIdBtgPactual(Result, ATxIdPix);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}

      // O tratamento roda dentro deste Except e ainda acessa banco e API. Excecao que escape
      // daqui atravessa a fronteira da .so, e no Linux o robo recebe E = nil e cai. Por isso
      // qualquer falha vira retorno de erro, como o chamador ja espera.
      Try
        Result := TrataErroConsultaTxId(E,
                                        ATxIdPix,
                                        AString);
      Except
        On ETratamento: Exception Do
        Begin
         {$IFDEF LINUX}
          WriteError(ETratamento.Message);
         {$ENDIF}

          Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                             'Ocorreu um erro ao consultar a cobrança Pix.' + #13 +
                                             'Erro gerado: ' + E.Message.Replace('\', ''),
                                             '');
        End;
      End;
    End;
  End;
end;

function TRequisicoesPix.ConsultarPixPorTxId(
  ATxIdPix: String): TDadosRetornoPixConsulta;
  var
    LResposta: String;
begin
  Try
    LResposta := ConsultarPixPorTxId(ATxIdPix, True);

    Result := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LResposta);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
      Result := nil;
     {$ELSE}
      Raise;
     {$ENDIF}
    End;
  End;
End;

constructor TRequisicoesPix.Create(AAutoIncremPix: String);
begin
  If FEmpresaConfiguracao.IsEmpty Then
    FEmpresaConfiguracao := VS_FuncoesExternas.fGetEmpresaLogada;

  FSicrediUsaPfx := False;

  CarregaDadosChavePix(AAutoIncremPix);

  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];

  If Not Assigned(VS_ListaToken) Then
    VS_ListaToken := TList<TDadosToken>.Create;

  If Not Assigned(VS_ListaCertificados) Then
    VS_ListaCertificados := TList<TDadosCertificado>.Create;

  FValidarErro401403 := True;

  FExecutandoPeloRobo := 'N';
  FIgnorarErro404Robo := 'N';

  FTratarErroSynalist := False;
  FTxIdRemoverBancoBtg := EmptyStr;

  CarregaLinksDoBanco(FCodigoDoBanco);
end;

constructor TRequisicoesPix.Create(AAutoIncremPix,
                                   AEmpresaChave: String);
begin
  FEmpresaConfiguracao := AEmpresaChave;

  FSicrediUsaPfx := False;

  CarregaDadosChavePix(AAutoIncremPix);

  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];

  If Not Assigned(VS_ListaToken) Then
    VS_ListaToken := TList<TDadosToken>.Create;

  If Not Assigned(VS_ListaCertificados) Then
    VS_ListaCertificados := TList<TDadosCertificado>.Create;

  FExecutandoPeloRobo := 'N';

  FTratarErroSynalist := False;

  CarregaLinksDoBanco(FCodigoDoBanco);
end;

constructor TRequisicoesPix.Create;
  Var
    LAutoIncremPix: String;
begin
  FEmpresaConfiguracao := VS_FuncoesExternas.fGetEmpresaLogada;

  LAutoIncremPix := fCfgSis('CHAPIX', FEmpresaConfiguracao);

  If LAutoIncremPix.IsEmpty Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'Para utilizar recebimento por Pix, deve ser selecionada a chave Pix padrão na configuração CFG_CHAPIX.', ['&Ok']);
    Exit;
  End;

  Self.Create(LAutoIncremPix);
end;

function TRequisicoesPix.CriarCobranca(ADadosRequisicao: String): String;
begin
  Result := CriarCobranca(ADadosRequisicao, '');
end;

function TRequisicoesPix.CriarCobranca(ADadosRequisicao, ATransactionType: String): String;
  var
    LResposta,
    LTxIdRequisicao: String;
begin
  Try
    ValidacoesIniciaisParaUsoDaRotina;

    FRequisicaoAtualizadaShipay := '';

    If FUtilizaShipay Then
    Begin
      If FHomologacao = 'N' Then
        ADadosRequisicao := ADadosRequisicao.Replace('"wallet": "shipay-pagador"', '"wallet": "pix"');

      LTxIdRequisicao := GerarTxIdParaRequisicao;

      LResposta := TRequisicoesPixLib.CriarCobrancaShipay(FCodigoDoBanco + 'S',
                                                          FLinkCriarCobrancaPix,
                                                          FNomeCertificado,
                                                          GetToken(FAutorizacao),
                                                          ADadosRequisicao.Replace(#13, EmptyStr).Replace('[ORDREF]', LTxIdRequisicao),
                                                          FClientID,
                                                          FClientSecret);

      VerificaSeRetornouErro(LResposta);

      Result := RetornaRequisicaoComTextoQRCode(LResposta);

      FRequisicaoAtualizadaShipay := TRequisicoesPixLib.RequisicaoAtualizadaShipay;

      If FPossuiLinkCitel Then
        Result := IncluirQRCodePixBaseCitel(Result,
                                            FRequisicaoAtualizadaShipay,
                                            ATransactionType);

      Exit;
    End;

    CarregaCertificados;

    ADadosRequisicao := TFuncoesPix.CorrigeCamposRequisicaoPorBanco(ADadosRequisicao, FCodigoDoBanco);

    Application.ProcessMessages;

    LTxIdRequisicao := EmptyStr;

    If FLinkCriarCobrancaPix.Contains('[TXID]') Then
      LTxIdRequisicao := GerarTxIdParaRequisicao;

    LResposta := CriarCobrancaSynalist(FLinkCriarCobrancaPix.Replace('[APP_DEV_KEY]', FAppDevKey)
                                                            .Replace('[TXID]', LTxIdRequisicao)
                                                            .Replace('[CNPJ]', FCNPJChavePix),
                                       ADadosRequisicao.Replace(#13, EmptyStr));

    VerificaSeRetornouErro(LResposta);

    Result := RetornaRequisicaoComTextoQRCode(LResposta);

    If FPossuiLinkCitel Then
      Result := IncluirQRCodePixBaseCitel(Result,
                                          ADadosRequisicao,
                                          ATransactionType);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
      Try
        Result := TrataErroCriarCobrancaTxId(E,
                                             LTxIdRequisicao,
                                             ADadosRequisicao,
                                             FLinkCriarCobrancaPix.Replace('[TXID]', LTxIdRequisicao)
                                                                  .Replace('[APP_DEV_KEY]', FAppDevKey));
      Except
        On EInner: Exception Do
        Begin
          WriteError('Falha secundária em TrataErroCriarCobrancaTxId: ' + EInner.Message);
          FLastError := E.Message;
          Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco, E.Message, '');
        End;
      End;
     {$ELSE}
      Result := TrataErroCriarCobrancaTxId(E,
                                           LTxIdRequisicao,
                                           ADadosRequisicao,
                                           FLinkCriarCobrancaPix.Replace('[TXID]', LTxIdRequisicao)
                                                                .Replace('[APP_DEV_KEY]', FAppDevKey));
     {$ENDIF}
    End;
  End;
end;

function TRequisicoesPix.CriarCobrancaSynalist(
  ALinkRequisicao, ADadosRequisicao: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta,
    LTipoRequisicao: String;

    LContador: Integer;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesPix.CriarCobrancaSynalist');
 {$ENDIF}

  FTratarErroSynalist := True;

  For LContador := 1 To TOTAL_TENTATIVAS_TIMEOUT Do
  Begin
    Try
      Try
        LHTTPSend :=THTTPSend.Create;
        LHTTPSend.MimeType  := RetornaMimeTypeCobranca(FCodigoDoBanco);
        LHTTPSend.Protocol  := '1.1';

        LHTTPSend.Headers.AddStrings(RetornaHeadersCobranca(FCodigoDoBanco));

        PreencheCertificadosSynalist(LHTTPSend, FCodigoDoBanco);

        LHTTPSend.Sock.SSL.SSLType:= LT_all;

        LHTTPSend.Sock.SetTimeout( TIMEOUT_REQUISICOES_TELA );
        LHTTPSend.Sock.ConnectionTimeout   := TIMEOUT_REQUISICOES_TELA;
        LHTTPSend.Sock.InterPacketTimeout  := False;
        LHTTPSend.Sock.NonblockSendTimeout := TIMEOUT_REQUISICOES_TELA;
        LHTTPSend.Sock.SocksTimeout        := TIMEOUT_REQUISICOES_TELA;
        LHTTPSend.Sock.HTTPTunnelTimeout   := TIMEOUT_REQUISICOES_TELA;

        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(ADadosRequisicao)));
          LHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;

        LTipoRequisicao := 'PUT';
        If MatchStr(Concat(FCodigoDoBanco, FVersaoAPI), ['0012', '2081']) Then
          LTipoRequisicao := 'POST';

        Try
          If LHTTPSend.HTTPMethod(LTipoRequisicao, ALinkRequisicao) Then
          Begin
            LHTTPSend.Document.Position := 0;

            Try
              LFDataResp := TMemoryStream.Create;
              LFDataResp.LoadFromStream(LHTTPSend.Document);

              LFDataResp.Position := 0;
              LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

              Result := LResposta;

              If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
                Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                                 LResposta);
            Finally
              FreeAndNil(LFDataResp);
            End;

          End
          Else
            Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                             LHTTPSend.Sock.LastErrorDesc);

          If MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
            Break;
        Finally
          GravarLogAPI('TRequisicoesPix.CriarCobrancaSynalist', ALinkRequisicao, LTipoRequisicao, ADadosRequisicao, LResposta, LHTTPSend);
        End;
      Finally
        FreeAndNil(LHTTPSend);
      End;
    Except
      On E: Exception Do
      Begin
       {$IFDEF LINUX}
        WriteError(E.Message);
        FLastError := E.Message;
       {$ENDIF}

        Result := TFuncoesPix.RetornaResultadoRequisicao('-1',
                                                         E.Message);

        If Not E.Message.Contains('Connection timed out') Then
          Break;

        Sleep(1000);
      End;
    End;
  End;
end;

function TRequisicoesPix.CriarCobrancaTefScope(const ACorpoRequisicao: String;
  out AJsonRequest, AJsonResponse, AJsonDados: String): boolean;
begin
  ValidacoesIniciaisParaUsoDaRotina;
  Result := TRequisicoesPixLib.CriarCobrancaTefScope(ACorpoRequisicao,
                                                     VS_FuncoesExternas.fIRetOperadorLogado,
                                                     FCNPJChavePix,
                                                     FNomeEmpresaChave,
                                                     AJsonRequest,
                                                     AJsonResponse,
                                                     AJsonDados);
end;

destructor TRequisicoesPix.Destroy;
begin
  FreeAndNil(FProtocoloSSL);

  ApagaArquivosDeCertificados;

  inherited;
end;

function TRequisicoesPix.DeveIgnorarErro404: Boolean;
begin
  If Not FExecutandoPeloRobo.Equals('S') Then
    Exit(False);

  Result := FIgnorarErro404Robo.Equals('S');
end;

function TRequisicoesPix.GerarTxIdParaRequisicao: String;
  Var
    LOperador: String;
begin
  Result := '';

  FAutoIncremMovPix := VS_FuncoesExternas.fIRetAutoIncrem('GERACAOTXIDPIX', VS_FuncoesExternas.fGetEmpresaLogada);

  If FAutoIncremMovPix.IsEmpty Then
    Exit;

  LOperador := VS_FuncoesExternas.fIRetOperadorLogado;
  If LOperador.IsEmpty Then
    LOperador := 'AUT';

  Result := Concat(untFuncoesSimples.RetornaCNPJEmpresaLogada,
                   FAutoIncremMovPix,
                   untFuncoesSimples.RetornaCurrentTimeStampServidor,
                   LOperador);

  Result := untFuncoesSimples.GetMD5(Result);
  If FCodigoDoBanco.Equals('033') Then
    Result := TRequisicoesCitelPix.ChaveSantanderCitel + RightStr(Result, Result.Length - 5);
end;

function TRequisicoesPix.GetAutoIncremMovPix: String;
begin
  Result := FAutoIncremMovPix;
end;

function TRequisicoesPix.GetChavePix: String;
begin
  Result := FChavePix;
end;

function TRequisicoesPix.GetCodigoDoBanco: String;
begin
  Result := FCodigoDoBanco;
end;

function TRequisicoesPix.GetDadosRequisicaoPixAVista: TDadosRequisicaoPixAVista;
begin
  Result := TDadosRequisicaoPixAVista.Create;
end;

{$IFDEF LINUX}
function TRequisicoesPix.GetLastError: string;
begin
  Result := FLastError;
end;
{$ENDIF}

function TRequisicoesPix.GetRequisicaoPixAtualizadaShipay: String;
begin
  Result := FRequisicaoAtualizadaShipay;
end;

function TRequisicoesPix.GetToken(AAutorizacao: String): String;
  Var
    LResposta: String;

    LJsonValue: TJSONValue;
    LJsonObject: TJSONObject;

    LToken,
    LTokenRemover: TDadosToken;

    LNecessitaRequisitarToken,
    LBancoPossuiToken: Boolean;

    LSegundosExpiracao: Integer;
begin
  LBancoPossuiToken := False;

  For LToken In VS_ListaToken Do
  Begin
    If Concat(LToken.Banco, LToken.Empresa, LToken.Portador) = Concat(FCodigoDoBanco, FEmpresaConfiguracao, FPortadorConta) Then
    Begin
      LBancoPossuiToken := True;

      LNecessitaRequisitarToken := IncSecond(LToken.DataLimite, -60) <= RetornaCurrentTimeStampServidorDataHora;

      If Not LNecessitaRequisitarToken Then
        Exit(LToken.Token)
      Else
        LTokenRemover := LToken;

      Break;
    End;
  End;

  If LBancoPossuiToken Then
  Begin
    VS_ListaToken.Delete(VS_ListaToken.IndexOf(LTokenRemover));
    FreeAndNil(LTokenRemover);
  End;

  Result := SelecionaTokenChaveGravado;
  If Not Result.IsEmpty Then
    Exit;

  Try
    Try
      LResposta := GetTokenBanco(FCodigoDoBanco);
    Finally
      Result := '';
      If Not LResposta.IsEmpty Then
      Begin
        // Em falha de token LResposta e o JSON de erro, sem access_token: o GetValue lanca e,
        // sem o Finally, o objeto vazava a cada ciclo do robo. O cast fica dentro do Try pelo
        // mesmo motivo (JSON que nao e objeto). Os dois valores sao lidos antes de criar o
        // LToken para que ele tambem nao fique orfao se faltar expires_in.
        LJsonValue := TJSONObject.ParseJSONValue(LResposta);
        Try
          LJsonObject := LJsonValue as TJSONObject;
          Result := LJsonObject.GetValue<String>('access_token');

          LSegundosExpiracao := 14400;
          If Not FUtilizaShipay Then
            LSegundosExpiracao := LJsonObject.GetValue<Integer>('expires_in');
        Finally
          FreeAndNil(LJsonValue);
        End;

        LToken := TDadosToken.Create;
        LToken.Banco := FCodigoDoBanco;
        LToken.Token := Result;
        LToken.Empresa := FEmpresaConfiguracao;
        LToken.Portador := FPortadorConta;
        LToken.DataLimite := IncSecond(RetornaCurrentTimeStampServidorDataHora, LSegundosExpiracao);

        VS_ListaToken.Add(LToken);

        GravarToken(Result,
                    LSegundosExpiracao);
      End;
    End;
  Except
    Raise Exception.Create(RetornaDescricaoErroToken(LResposta));
  End;
end;

function TRequisicoesPix.GetTokenBanco(ABanco: String): String;
  Var
    LParametros: TStringList;
begin
  FRetornoBancoToken := EmptyStr;
  FCodigoHttpToken := 0;
  FErroConexaoToken := EmptyStr;
  FCodigoSocketToken := 0;

  LParametros := TStringList.Create;

  Try
    Try
      If FUtilizaShipay Then
      Begin
        Result := GetTokenBancoSynalist(ABanco, 'application/json');

        VerificaSeRetornouErro(Result);

        Exit;
      End;

      CarregaCertificados;

      If MatchStr(ABanco, ['237']) Then
        LParametros.Add('grant_type=client_credentials');

      Result := GetTokenBancoSynalist(ABanco);

      VerificaSeRetornouErro(Result);

      If ABanco.Equals('208') Then
        TRequisicoesCitelPix.AtualizaRefreshTokenWebhookBtgPactual(FChavePix,
                                                                   FRefreshToken);
    Except
      On E: Exception Do
      Begin
       {$IFDEF LINUX}
        WriteError(E.Message);
        FLastError := E.Message;
       {$ENDIF}

        Result := TrataErroToken(E,
                                 LParametros.Text,
                                 FLinkAutenticacaoPix);
      End;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TRequisicoesPix.GetTokenBancoSynalist(ABanco: String;
  AMineType: String = 'application/x-www-form-urlencoded'): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp,
    LFDataReq: TMemoryStream;

    LResposta,
    LDadosRequisicao: String;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesPix.GetTokenBancoSynalist');
 {$ENDIF}

  LHTTPSend := THTTPSend.Create;

  Try
    LHTTPSend.MimeType  := AMineType;
    LHTTPSend.Protocol  := '1.1';

    LHTTPSend.Sock.SSL.SSLType:= LT_all;
    
    LHTTPSend.Sock.SetTimeout( TIMEOUT_REQUISICOES );
    LHTTPSend.Sock.ConnectionTimeout   := TIMEOUT_REQUISICOES;
    LHTTPSend.Sock.InterPacketTimeout  := False;
    LHTTPSend.Sock.NonblockSendTimeout := TIMEOUT_REQUISICOES;
    LHTTPSend.Sock.SocksTimeout        := TIMEOUT_REQUISICOES;
    LHTTPSend.Sock.HTTPTunnelTimeout   := TIMEOUT_REQUISICOES;

    Try
      LDadosRequisicao := RetornaDadosRequisicaoToken(ABanco);

      LHTTPSend.Headers.AddStrings(RetornaHeadersToken(ABanco));

      PreencheCertificadosSynalist(LHTTPSend, ABanco);

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      Try
        If LHTTPSend.HTTPMethod('POST', FLinkAutenticacaoPix) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result := LResposta;

            If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
            Begin
              FCodigoHttpToken := LHTTPSend.ResultCode;
              FRetornoBancoToken := LResposta;

              Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                               LResposta);
            End;
          Finally
            FreeAndNil(LFDataResp);
          End;

        End
        Else
        Begin
          FCodigoSocketToken := LHTTPSend.Sock.LastError;
          FErroConexaoToken := LHTTPSend.Sock.LastErrorDesc;

          Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.Sock.LastError.ToString,
                                                           LHTTPSend.Sock.LastErrorDesc);
        End;
      Finally
        GravarLogAPI('TRequisicoesPix.GetTokenBancoSynalist', FLinkAutenticacaoPix, 'POST', LDadosRequisicao, LResposta, LHTTPSend);
      End;
    Except
      On E: Exception Do
      Begin
       {$IFDEF LINUX}
        WriteError(E.Message);
        FLastError := E.Message;
       {$ENDIF}

        Result := TFuncoesPix.RetornaResultadoRequisicao('-1',
                                                         E.Message);
      End;
    End;
  Finally
    FreeAndNil(LHTTPSend);
  End;
end;

procedure TRequisicoesPix.GravarLOGERR_PixTipo(
  AMensagemErroRequisicao, AMensagemErroDelphi, ADadosRequisicao,
  ALinkRequisicao, ATxIdPix: String; ATipoRequisicao: TTipoRequisicaoPix);
  Var
    LMetodoRequisicao,
    LTextoErro,
    LTokenLog,
    LRetornoErroLOGERR_PIX: String;
begin
  If DeveIgnorarErro404 Then
  Begin
    If FCodigoRetornoErro.Equals('404') Then
      Exit;
  End;

  Case ATipoRequisicao Of
    trpCriarCobranca: LMetodoRequisicao := IIF(Not FUtilizaShipay, 'PUT', 'POST');
    trpAlterarCobranca: LMetodoRequisicao := 'PATCH';
    trpConsultarCobranca: LMetodoRequisicao := 'GET';
    trpSolicitarDevolucao: LMetodoRequisicao := 'DELETE';
  End;

  Case ATipoRequisicao Of
    trpCriarCobranca: LTextoErro := 'Ocorreu um erro ao criar a cobrança na API do Pix.';
    trpAlterarCobranca: LTextoErro := 'Ocorreu um erro ao ' + IIF(Not FUtilizaShipay, 'alterar ', 'cancelar ') + 'a cobrança na API do Pix.';
    trpConsultarCobranca: LTextoErro := 'Ocorreu um erro ao consultar a cobrança na API do Pix.';
    trpSolicitarDevolucao: LTextoErro := 'Ocorreu um erro ao solicitar a debolução da cobrança na API do Pix.';
  End;

  // Este log roda dentro do Except de quem chamou. Se o erro original foi de token, pedir o
  // token de novo falha de novo, e a excecao saia da .so - no Linux nao ha ShareMem, o robo
  // recebia E = nil e caia a cada ciclo (Aquarela, 06/10/2026 em diante). O token continua
  // no log quando existe; so a falha em obte-lo deixou de ser fatal.
  Try
    LTokenLog := GetToken(FAutorizacao);
  Except
    On E: Exception Do
      LTokenLog := '(token não obtido: ' + E.Message + ')';
  End;

  LRetornoErroLOGERR_PIX := IIF(FExecutandoPeloRobo = 'S', '[MonitorPagamentosPix] ', '') +
                            'Banco: ' + FCodigoDoBanco + #13 +
                            'Chave Pix da Conta: ' + FChavePix + #13 +
                            'TxId: ' + ATxIdPix + #13;

  If FUtilizaShipay Then
  Begin
    LRetornoErroLOGERR_PIX := LRetornoErroLOGERR_PIX +
                              'Código do Retorno: ' + FCodigoRetornoErro + #13 +
                              'Resultado API: ' + AMensagemErroDelphi + #13 +
                              'Retorno Erro: ' + AMensagemErroDelphi + #13 + #13 +
                              'Link da Requisição: ' + ALinkRequisicao + #13 +
                              'Método Requisição: ' + LMetodoRequisicao + #13 +
                              'Parâmetros Requisição: Authorization: ' + LTokenLog + #13 +
                              'Json Corpo Requisição: ' + ADadosRequisicao.Replace(#13, EmptyStr) + #13 +
                              '-------------------------------------' + #13 +
                             {$IFDEF LINUX}
                              'Nome da máquina: ' + VS_ComputerNetName + #13 +
                              'Usuário Windows: ' + VS_ComputerUser + #13 +
                              'IP da máquina: ' + VS_IPAddressAsString + #13 +
                             {$ELSE}
                              'Nome da máquina: ' + TWorkStationInfo.fGetWorkStationID + #13 +
                              'Usuário Windows: ' + GetUserFromWindows + #13 +
                              'IP da máquina: ' + TWorkStationInfo.fGetWorkStationIP + #13 +
                             {$ENDIF}
                              'Caminho: ' + ExtractFilePath(Application.ExeName) + #13 +
                              '-------------------------------------' + #13 + #13;

    GravarLogErr_Pix(IIF(FExecutandoPeloRobo = 'S', '[MonitorPagamentosPix] ', '') + LTextoErro + ' Shipay. Código do retorno: ' + FCodigoRetornoErro,
                     LRetornoErroLOGERR_PIX{$IFNDEF LINUX} + untFuncoesSimples.fRetornaStack{$ENDIF});
  End
  Else
  Begin
    LRetornoErroLOGERR_PIX := LRetornoErroLOGERR_PIX +
                              'Código do Retorno: ' + FCodigoRetornoErro + #13 +
                              'Resultado API: ' + AMensagemErroDelphi + #13 +
                              'Retorno Erro: ' + AMensagemErroDelphi + #13 + #13 +
                              'Link da Requisição: ' + ALinkRequisicao + #13 +
                              'Método Requisição: ' + LMetodoRequisicao + #13 +
                              'Parâmetros Requisição: Authorization: ' + LTokenLog + #13 +
                              'Json Corpo Requisição: ' + ADadosRequisicao.Replace(#13, EmptyStr) + #13 +
                              '-------------------------------------' + #13 +
                             {$IFDEF LINUX}
                              'Nome da máquina: ' + VS_ComputerNetName + #13 +
                              'Usuário Windows: ' + VS_ComputerUser + #13 +
                              'IP da máquina: ' + VS_IPAddressAsString + #13 +
                             {$ELSE}
                              'Nome da máquina: ' + TWorkStationInfo.fGetWorkStationID + #13 +
                              'Usuário Windows: ' + GetUserFromWindows + #13 +
                              'IP da máquina: ' + TWorkStationInfo.fGetWorkStationIP + #13 +
                             {$ENDIF}
                              'Caminho: ' + ExtractFilePath(Application.ExeName) + #13 +
                              '-------------------------------------' + #13 + #13;

    GravarLogErr_Pix(IIF(FExecutandoPeloRobo = 'S', '[MonitorPagamentosPix] ', '') + LTextoErro + ' Código do retorno: ' + FCodigoRetornoErro,
                     LRetornoErroLOGERR_PIX {$IFNDEF LINUX}+ untFuncoesSimples.fRetornaStack{$ENDIF});
  End;
end;

procedure TRequisicoesPix.GravarLOGERR_PixToken(
  AMensagemErroRequisicao,
  AMensagemErroDelphi, ADadosRequisicao, ALinkRequisicao: String);
  Var
    LRetornoErroLOGERR_PIX: String;
begin
  If DeveIgnorarErro404 Then
  Begin
    If FCodigoRetornoErro.Equals('404') Then
      Exit;
  End;

  LRetornoErroLOGERR_PIX := IIF(FExecutandoPeloRobo = 'S', '[MonitorPagamentosPix] ', '') +
                            'Banco: ' + FCodigoDoBanco + #13 +
                            'Chave Pix da Conta: ' + FChavePix + #13;

  If FUtilizaShipay Then
  Begin
    LRetornoErroLOGERR_PIX := LRetornoErroLOGERR_PIX +
                              'Código do Retorno: ' + FCodigoRetornoErro + #13 +
                              'Resultado API: ' + AMensagemErroDelphi + #13 +
                              'Retorno Erro: ' + AMensagemErroDelphi + #13 + #13 +
                              'Link da Requisição: ' + ALinkRequisicao + #13 +
                              'Parâmetros Requisição: Client Id: ' + FClientID + #13 +
                              'Client Secret: ' + FClientSecret + #13 +
                              'Autorização Basic: ' + FAutorizacao + #13 +
                              '-------------------------------------' + #13 +
                             {$IFDEF LINUX}
                              'Nome da máquina: ' + VS_ComputerNetName + #13 +
                              'Usuário Windows: ' + VS_ComputerUser + #13 +
                              'IP da máquina: ' + VS_IPAddressAsString + #13 +
                             {$ELSE}
                              'Nome da máquina: ' + TWorkStationInfo.fGetWorkStationID + #13 +
                              'Usuário Windows: ' + GetUserFromWindows + #13 +
                              'IP da máquina: ' + TWorkStationInfo.fGetWorkStationIP + #13 +
                             {$ENDIF}
                              'Caminho: ' + ExtractFilePath(Application.ExeName) + #13 +
                              '-------------------------------------' + #13 + #13;

    GravarLogErr_Pix(IIF(FExecutandoPeloRobo = 'S', '[MonitorPagamentosPix] ', '') + 'Ocorreu um erro ao realizar a autenticação na API do Pix Shipay. Código do retorno: ' + FCodigoRetornoErro,
                     LRetornoErroLOGERR_PIX{$IFNDEF LINUX} + untFuncoesSimples.fRetornaStack{$ENDIF});
  End
  Else
  Begin
    LRetornoErroLOGERR_PIX := LRetornoErroLOGERR_PIX +
                              'Código do Retorno: ' + FCodigoRetornoErro + #13 +
                              'Resultado API: ' + AMensagemErroDelphi + #13 +
                              'Retorno Erro: ' + AMensagemErroDelphi + #13 + #13 +
                              'Link da Requisição: ' + ALinkRequisicao + #13 +
                              'Parâmetros Requisição: Client Id: ' + FClientID + #13 +
                              'Client Secret: ' + FClientSecret + #13 +
                              'Autorização Basic: ' + FAutorizacao + #13 +
                              '-------------------------------------' + #13 +
                             {$IFDEF LINUX}
                              'Nome da máquina: ' + VS_ComputerNetName + #13 +
                              'Usuário Windows: ' + VS_ComputerUser + #13 +
                              'IP da máquina: ' + VS_IPAddressAsString + #13 +
                             {$ELSE}
                              'Nome da máquina: ' + TWorkStationInfo.fGetWorkStationID + #13 +
                              'Usuário Windows: ' + GetUserFromWindows + #13 +
                              'IP da máquina: ' + TWorkStationInfo.fGetWorkStationIP + #13 +
                             {$ENDIF}
                              'Caminho: ' + ExtractFilePath(Application.ExeName) + #13 +
                              '-------------------------------------' + #13 + #13;

    GravarLogErr_Pix(IIF(FExecutandoPeloRobo = 'S', '[MonitorPagamentosPix] ', '') + 'Ocorreu um erro ao realizar a autenticação na API do Pix. Código do retorno: ' + FCodigoRetornoErro,
                     LRetornoErroLOGERR_PIX{$IFNDEF LINUX} + untFuncoesSimples.fRetornaStack{$ENDIF});
  End;
end;

procedure TRequisicoesPix.GravarToken(AAccessToken: String;
  AExpiracao: Integer);
  Var
    LInserir: IDataset;

    LCampoRefresh: Boolean;
begin
  Try
    LInserir := VS_FuncoesExternas.fGetDataset;

    If Not FGravaAutorizacaoPix Then
      Exit;

    LInserir.SQL := 'SELECT * FROM AUTPIX WHERE FALSE';
    LInserir.Open;
    LCampoRefresh := LInserir.FindField('AUT_RTOKEN') <> Nil;

    LInserir.Close;
    LInserir.SQL := 'REPLACE INTO AUTPIX (AUT_DTACAD, AUT_SEQCHV, AUT_ATOKEN, AUT_EXPIRA) VALUES ' +
                    '                    (:DTACAD, :SEQCHV, :ATOKEN, :EXPIRA)';
    If LCampoRefresh Then
    Begin
      LInserir.SQL := 'REPLACE INTO AUTPIX (AUT_DTACAD, AUT_SEQCHV, AUT_ATOKEN, AUT_EXPIRA, AUT_RTOKEN) VALUES ' +
                      '                    (:DTACAD, :SEQCHV, :ATOKEN, :EXPIRA, :RTOKEN)';

      LInserir.ParamByName('RTOKEN').AsString := FRefreshToken;
    End;

    LInserir.ParamByName('DTACAD').AsDateTime := untFuncoesSimples.RetornaCurrentTimeStampServidorDataHora;
    LInserir.ParamByName('SEQCHV').AsString := FAutoIncremPix;
    LInserir.ParamByName('ATOKEN').AsString := AAccessToken;
    LInserir.ParamByName('EXPIRA').AsInteger := AExpiracao;

    LInserir.ExecSQL;
  Except

  End;
end;

function TRequisicoesPix.IncluirQRCodePixBaseCitel(
  ADadosRetorno, ARequisicao: String; ATransactionType: String = ''): String;
begin
  Result := TRequisicoesCitelPix.IncluirQRCodePixBaseCitel(FLinkQRCodeCitelInclusao,
                                                           ADadosRetorno,
                                                           ARequisicao,
                                                           FCodigoDoBanco,
                                                           FAutoIncremPix,
                                                           FUtilizaShipay,
                                                           ATransactionType);
end;

function TRequisicoesPix.IncluirQRCodePixBoletoBaseCitel(ACodigoBanco,
  ATxIdPix, AQRCodePix, ADataCriacao, AExpiracao, AValorPix: String): String;
  Var
    LDadosPixBoleto: TDadosPixBoleto;
begin
  LDadosPixBoleto.CodigoBanco := FCodigoDoBanco;
  LDadosPixBoleto.TxIdPix := ATxIdPix;
  LDadosPixBoleto.QRCodePix := AQRCodePix;
  LDadosPixBoleto.DataCriacao := ADataCriacao;
  LDadosPixBoleto.Expiracao := AExpiracao;
  LDadosPixBoleto.ValorPix := AValorPix;

  Result := TRequisicoesCitelPix.IncluirQRCodePixBoletoBaseCitel(FLinkQRCodeCitelInclusao,
                                                                 LDadosPixBoleto);
end;

procedure TRequisicoesPix.LimparDadosDeTokensECertificados;
begin
  If Assigned(VS_ListaToken) Then
    FreeAndNil(VS_ListaToken);

  ApagaArquivosDeCertificados;

  If Assigned(VS_ListaCertificados) Then
    FreeAndNil(VS_ListaCertificados);

  VS_ListaToken := TList<TDadosToken>.Create;
  VS_ListaCertificados := TList<TDadosCertificado>.Create;
end;

procedure TRequisicoesPix.LimparTabelaTokens;
  Var
    LRemover: IDataset;
begin
  If FUtilizaShipay Then
    Exit;

  If Not FGravaAutorizacaoPix Then
    Exit;

  Try
    LRemover := VS_FuncoesExternas.fGetDataset;

    LRemover.SQL := 'DELETE FROM AUTPIX WHERE AUT_SEQCHV=:SEQCHV';
    LRemover.ParamByName('SEQCHV').AsString := FAutoIncremPix;
    LRemover.ExecSQL;
  Except

  End;
end;

function TRequisicoesPix.RefazerConsultaPorTxId(ATxIdPix: String;
  AString: Boolean): String;
  Var
    LRetorno: String;

    LContador: Integer;
begin
  Result := '';

  FValidarErro401403 := False;

  For LContador := 0 To 2 Do
  Begin
    LimparDadosDeTokensECertificados;

    LRetorno := ConsultarPixPorTxId(ATxIdPix, AString);

    If TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetorno).Txid.Equals(ATxIdPix) Then
    Begin
      Result := LRetorno;

      FValidarErro401403 := True;

      Break;
    End;
  End;
end;

function TRequisicoesPix.RemoverCobrancaBtgPactual(
  ALinkRequisicao: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta: String;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesPix.RemoverCobrancaBtgPactual');
 {$ENDIF}

  FTratarErroSynalist := True;

  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.AddStrings(RetornaHeadersCobranca(FCodigoDoBanco));
      PreencheCertificadosSynalist(LHTTPSend, FCodigoDoBanco);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( TIMEOUT_REQUISICOES );
      LHTTPSend.Sock.ConnectionTimeout   := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.SocksTimeout        := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.HTTPTunnelTimeout   := TIMEOUT_REQUISICOES;

      Try
        If LHTTPSend.HTTPMethod('DELETE', ALinkRequisicao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result := LResposta;

            If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
              Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                               LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End
        Else
          TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                 LHTTPSend.Sock.LastErrorDesc);
      Finally
        GravarLogAPI('TRequisicoesPix.RemoverCobrancaBtgPactual', ALinkRequisicao, 'DELETE', '', LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}

      Result := TFuncoesPix.RetornaResultadoRequisicao('-1',
                                                       E.Message);
    End;
  End;
end;

function TRequisicoesPix.RemoverQRCodePixBaseCitel(ACNPJEmpresa, ACodigoEmpresa,
  AIxIdPix: String; AGravarLogErr: Boolean): Boolean;
  var
    LCNPJEmpresa: String;
begin
  LCNPJEmpresa := ACNPJEmpresa;
  If FHomologacao = 'S' Then
    LCNPJEmpresa := '11111111111111';

  Result := TRequisicoesCitelPix.RemoverQRCodePixBaseCitel(FLinkQRCodeCitelExclusao.Replace('[CNPJ]', LCNPJEmpresa)
                                                                                   .Replace('[CODEMP]', ACodigoEmpresa)
                                                                                   .Replace('[TXID]', AIxIdPix),
                                                           AGravarLogErr,
                                                           FPossuiLinkCitel);
end;

function TRequisicoesPix.RetornaCodigoRespostaErro: Integer;
begin
  Result := StrToIntDef(FCodigoRetornoErro, -1);
end;

function TRequisicoesPix.RetornaDadosRequisicaoToken(ABanco: String): String;
begin
  Try
    If FUtilizaShipay Then
      Exit('{' +
           '  "access_key": "' + FAppDevKey + '",' +
           '  "client_id": "' + FClientID + '",' +
           '  "secret_key": "' + FClientSecret + '"' +
           '}');

    Result := 'grant_type=client_credentials&' +
              'client_id=' + FClientID + '&' +
              'client_secret=' + FClientSecret;

    If ABanco.Equals('001') Then
    Begin
      Result := 'grant_type=client_credentials&' +
                'scope=cob.write cob.read cobv.write cobv.read pix.write pix.read ' +
                      'webhook.read webhook.write payloadlocation.write payloadlocation.read';

      If FVersaoAPI.Equals('1') Then
        Result := 'grant_type=client_credentials&' +
                  'scope=cob.read cob.write pix.read pix.write';
    End
    Else If ABanco.Equals('033') Then
      Result := 'client_id=' + FClientID + '&' +
                'client_secret=' + FClientSecret
    Else If ABanco.Equals('756') Then
      Result := Result + '&scope=cob.read cob.write pix.read pix.write'
    Else If ABanco.Equals('748') Then
      Result := EmptyStr
    Else If ABanco.Equals('237') THen
    Begin
      Result := 'grant_type=client_credentials';

      If Not FVersaoAPI.Equals('1') Then
        Result := 'grant_type=client_credentials&' +
                  'client_id=' + FClientID + '&' +
                  'client_secret=' + FClientSecret + '&' +
                  'scope=';
    End
    Else If ABanco.Equals('290') Then
      Result := 'grant_type=client_credentials&' +
                'scope=cob.read cob.write pix.read pix.write payloadlocation.read ' +
                ' payloadlocation.write webhook.read webhook.write'
    Else If ABanco.Equals('208') Then
      Result := RetornaParametrosRefreshBtgPactual
    Else If ABanco.Equals('422') Then
      Result := Result + '&scope=cob.read cob.write pix.read pix.write'
  Except
    Raise;
  End;
end;

function TRequisicoesPix.MontaMensagemErroAutenticacao(const AAmbiente: String): String;
  Var
    LRecusaCertificado: Boolean;
    LRetornoBanco: String;
begin
  Result := 'Ocorreu um erro ao realizar a autenticação na API do Banco ' + FCodigoDoBanco;

  // A conta vai so na mensagem do robo: ele percorre todas as contas e grava o erro em nome
  // da empresa 001, entao sem ela nao ha como saber qual falhou. No autcom o operador ja
  // esta na conta da venda, e o dialogo nao deve exibir agencia e conta.
  If FExecutandoPeloRobo = 'S' Then
    Result := Result + ' (' + FIdentificacaoConta + ')';

  Result := Result + '.' + #13;

  // Sem resposta HTTP o banco nao chegou a responder. Conexao derrubada (ECONNRESET 104 no
  // Linux, WSAECONNRESET 10054 no Windows) ou alerta TLS e como o banco recusa o certificado
  // no handshake - caso Aquarela 003, 13/10/2026, que trocou o 403 por reset. Erro de SSL/ASN1
  // e o certificado local que nao carregou - caso RC2 x OpenSSL 3, set/2026, codigo -2 com
  // "ASN1_get_object:header too long". Timeout, DNS e conexao recusada sao rede e nao devem
  // sugerir certificado.
  LRecusaCertificado := (FCodigoHttpToken = 401) Or (FCodigoHttpToken = 403) Or
                        (FCodigoSocketToken = 104) Or (FCodigoSocketToken = 10054) Or
                        ContainsText(FErroConexaoToken, 'reset') Or
                        ContainsText(FErroConexaoToken, 'certificate') Or
                        ContainsText(FErroConexaoToken, 'alert') Or
                        ContainsText(FErroConexaoToken, 'handshake') Or
                        ContainsText(FErroConexaoToken, 'SSL') Or
                        ContainsText(FErroConexaoToken, 'ASN1') Or
                        ContainsText(FErroConexaoToken, 'X509') Or
                        ContainsText(FErroConexaoToken, 'PEM');

  If FCodigoHttpToken = 0 Then
  Begin
    If LRecusaCertificado Then
      Result := Result + 'A conexão com o banco foi interrompida antes de qualquer resposta, o que costuma indicar problema com o certificado.' + #13
    Else
      Result := Result + 'Não foi possível se comunicar com o banco (falha de rede, tempo esgotado ou endereço não encontrado).' + #13;
  End;

  // CCA_VALCER e dado do cadastro, nao lido do certificado. Por isso so acrescenta o aviso,
  // sem impedir a chamada ao banco, e o texto diz "consta no cadastro".
  If LRecusaCertificado Then
  Begin
    If (FValidadeCertificadoConta > 0) And
       (FValidadeCertificadoConta < Trunc(RetornaCurrentTimeStampServidorDataHora)) Then
      Result := Result + 'O certificado consta no cadastro da conta com validade até ' +
                FormatDateTime('dd/mm/yyyy', FValidadeCertificadoConta) + '.' + #13 +
                'Instale o certificado renovado na conta bancária e vincule-o ao aplicativo do banco.' + #13
    Else
      Result := Result + 'Verifique as chaves de autenticação e o certificado da conta, e se estão liberados para o ambiente de ' +
                AAmbiente + '.' + #13;
  End;

  // O GeraJsonErro monta o JSON por concatenacao e so remove aspas: barra invertida do
  // banco viraria escape invalido e o JSON de erro deixaria de ser lido. Corpo em HTML
  // (pagina de firewall) e omitido, e o tamanho e limitado por ir para um dialogo.
  LRetornoBanco := FRetornoBancoToken;
  If FCodigoHttpToken = 0 Then
    LRetornoBanco := FErroConexaoToken;

  LRetornoBanco := LRetornoBanco.Replace(#13, ' ').Replace(#10, ' ').Replace(#9, ' ')
                                .Replace('\', '').Replace('"', '').Trim;
  While LRetornoBanco.Contains('  ') Do
    LRetornoBanco := LRetornoBanco.Replace('  ', ' ');

  If LRetornoBanco.StartsWith('<') Then
    LRetornoBanco := '(resposta em HTML, omitida)'
  Else If Length(LRetornoBanco) > 300 Then
    LRetornoBanco := Copy(LRetornoBanco, 1, 300) + '...';

  If FCodigoHttpToken = 0 Then
    Result := Result + 'Erro de comunicação (código ' + FCodigoSocketToken.ToString + ')'
  Else
    Result := Result + 'Retorno do banco (HTTP ' + FCodigoHttpToken.ToString + ')';

  If Not LRetornoBanco.IsEmpty Then
    Result := Result + ': ' + LRetornoBanco;
end;

function TRequisicoesPix.RetornaDescricaoErroToken(AResposta: String): String;
  Var
    LAmbiente: String;

    LJsonValue: TJSONValue;
    LJsonObject: TJsonObject;
begin
  LAmbiente := 'PRODUÇÃO';
  If FHomologacao <> 'N' Then
    LAmbiente := 'HOMOLOGAÇÃO';

  If (FCodigoHttpToken = 401) Or (FCodigoHttpToken = 403) Or (FCodigoSocketToken <> 0) Then
    Exit(TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                  MontaMensagemErroAutenticacao(LAmbiente), ''));

  Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                     'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                     'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                     LAmbiente + '.', '');

  // O Finally libera o JSON em todos os caminhos (Exit, fim normal e Except vazio): antes
  // ele vazava em toda falha de token que nao fosse 401/403, a cada ciclo do robo.
  LJsonValue := Nil;
  Try
    Try
      If FCodigoRetornoErro.Equals('992') Then
        Exit(TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                      'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                      'Erro gerado: ' + AResposta, ''));

      LJsonValue := TJSONObject.ParseJSONValue(AResposta);
      If Not (LJsonValue Is TJSONObject) Then
        Exit;

      LJsonObject := TJSONObject(LJsonValue);

      If LJsonObject.GetValue('codigo') = Nil Then
        Exit;

      If MatchStr(LJsonObject.GetValue<String>('codigo'), ['989', '990', '991', '992', '-1']) Then
      Begin
        Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                           'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                           'Erro gerado: ' + LJsonObject.GetValue<String>('resultado'), '');
      End;
    Except

    End;
  Finally
    FreeAndNil(LJsonValue);
  End;
end;

function TRequisicoesPix.RetornaHeadersCobranca(ABanco: String): TStringList;
begin
  Result := TStringList.Create;

  Try
    Result.Add('Authorization: Bearer ' + GetToken(FAutorizacao));

    If FUtilizaShipay Then
      Exit;

    If Not MatchStr(ABanco, ['033', '208', '422']) Then
      Result.Add('Content-Type: application/json');

    if ABanco = '756' then
      Result.Add('client_id: ' + FClientID)
    Else If Concat(ABanco, FVersaoAPI) = '0012' Then
      Result.Add('X-Application-Key: ' + FAppDevKey);
  Except
    Raise;
  End;
end;

function TRequisicoesPix.RetornaHeadersToken(ABanco: String): TStringList;
begin
  Result := TStringList.Create;

  If MatchStr(ABanco, ['001', '748', '237', '290', '208']) Then
    Result.Add('Authorization: ' + FAutorizacao);
end;

function TRequisicoesPix.RetornaMimeTypeCobranca(ABanco: String): String;
begin
  Result := 'application/json; charset=utf-8';
  If MatchStr(ABanco, ['422']) Then
    Result := 'application/json';
end;

function TRequisicoesPix.RetornaParametrosRefreshBtgPactual: String;
  Var
    LRefreshToken: String;
begin
  LRefreshToken := RetornaRefreshTokenGerado(FCodigoDoBanco, FAutoIncremPix);

  Result := 'grant_type=refresh_token&';

  Try
    If LRefreshToken.IsEmpty Then
    Begin
      LRefreshToken := TRequisicoesCitelPix.RetornaRefreshTokenWebhookBtgPactual(FChavePix,
                                                                                 FAutorizacao);

      LRefreshToken := TFuncoesPix.RetornaValorCampoJson('refreshToken', LRefreshToken);
    End;

    If Not LRefreshToken.IsEmpty Then
    Begin
      Result := Result + 'refresh_token=' + LRefreshToken;

      FRefreshToken := LRefreshToken;

      Exit;
    End;

    Raise Exception.Create(TFuncoesPix
                         .RetornaResultadoRequisicao('992',
                                                     'Não foi possível gerar o token, pois não foi realizada a liberação da aplicação no Banco BTG Pactual.' + #13 +
                                                     'Entre no cadastro de contas bancárias e clique em Validar Dados de Autorização.'));

  Except
    Raise;
  End;

end;

function TRequisicoesPix.RetornaRefreshTokenGerado(ACodigoBanco,
  AAutoIncremChavePix: String): String;
  Var
    LConsulta: IDataset;

    LJsonObject: TJsonObject;
begin
  Result := EmptyStr;

  If Not ACodigoBanco.Equals('208') Then
    Exit;

  LConsulta := VS_FuncoesExternas.fGetDataSet;

  Try
    LConsulta.SQL := 'SELECT * FROM AUTPIX WHERE AUT_SEQCHV="' + AAutoIncremChavePix + '"';
    LConsulta.Open;

    If LConsulta.FindField('AUT_RTOKEN') = Nil Then
      Exit;

    Result := LConsulta.FieldByName('AUT_RTOKEN').AsString;

    LConsulta.Close;

    If Not Result.IsEmpty Then
      Exit;

    LConsulta.SQL := 'SELECT P.PIX_CHAVE_, C.CCA_AUTPIX ' +
                     'FROM CCAPIX P ' +
                     'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                     'WHERE P.AUTOINCREM="' + AAutoIncremChavePix + '"';
    LConsulta.Open;

    LJsonObject := TJSONObject.ParseJSONValue(TRequisicoesCitelPix.RetornaRefreshTokenWebhookBtgPactual(LConsulta.FieldByName('PIX_CHAVE_').AsString,
                                                                                                        LConsulta.FieldByName('CCA_AUTPIX').AsString)) As TJsonObject;

    LConsulta.Close;

    If LJsonObject = Nil Then
      Exit;

    Result := TFuncoesPix.RetornaValorJson(LJsonObject, 'refreshToken');
  Except

  End;


end;

function TRequisicoesPix.RetornaRequisicaoComTextoQRCode(
  ARetorno: String): String;
  Var
    LDadosRetorno: TDadosRetornoPixConsulta;

    LTextoQRCode,
    LResposta: String;

    LJsonObject: TJsonObject;
begin
  Result := ARetorno;

  If Pos('"txid"', Result) <= 0 Then
    Exit;

  If Pos('"textoImagemQRcode"', Result) > 0 Then
    Exit;

  If Pos('"pixCopiaECola"', Result) > 0 Then
    Exit;

  If Pos('"brcode"', Result) > 0 Then
    Exit;

  If Pos('"qr_code_text"', Result) > 0 Then
    Exit;

  LDadosRetorno := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(Result);

  Try
    If FCodigoDoBanco = '033' Then
    Begin
      Result := TFuncoesPix.CorrigeDadosRetorno(Result);
      Result := TFuncoesPix.AdicionaTextoQRCode(Result, RetornaTextoQRCodeFormatado(LDadosRetorno));

      Exit;
    End;

    Try
      If FHomologacao = 'S' Then
        Sleep(3000);

      CarregaCertificados;

      Application.ProcessMessages;

      LResposta := ConsultarPixPorTxIdSynalist(FLinkConsultaQRCode.Replace('[TXID]', LDadosRetorno.TxId));
    Finally
      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;

      LTextoQRCode := '';
      If LJsonObject.GetValue('emv') <> Nil Then
        LTextoQRCode := LJsonObject.GetValue<String>('emv');

      Result := TFuncoesPix.AdicionaTextoQRCode(Result, LTextoQRCode);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}
      Raise;
    End;
  End;
end;

function TRequisicoesPix.RetornaTextoQRCodeFormatado(
  ADadosRetorno: TDadosRetornoPixConsulta): String;
  Var
    LCRC16: String;

    LTamanho: Integer;
begin
  Result := '000201' +
            '010212';

  LTamanho := ('0014br.gov.bcb.pix' +
               '25' + ADadosRetorno.LinkQrCode.Length.ToString +
               ADadosRetorno.LinkQrCode).Length;

  Result := Result + '26' + LTamanho.ToString +
                            '0014br.gov.bcb.pix' +
                            '25' + ADadosRetorno.LinkQrCode.Length.ToString + ADadosRetorno.LinkQrCode +
                            '52040000';


  Result := Result + '5303986';

  LTamanho := LeftStr(fTiraCaracEspeciais(FNomeEmpresaChave), 25).Trim.Length;

  Result := Result + '5802BR' +
                     '59' + fStrZero(LTamanho.ToString, 2) + LeftStr(fTiraCaracEspeciais(FNomeEmpresaChave), 25).Trim;

  LTamanho := LeftStr(fTiraCaracEspeciais(FCidadeEmpresaChave), 15).Trim.Length;

  Result := Result + '60' + fStrZero(LTamanho.ToString, 2) + LeftStr(fTiraCaracEspeciais(FCidadeEmpresaChave), 15).Trim +
                     '62070503***' +
                     '6304';

  LCRC16 := InttoHex(TFuncoesPix.CRC16CCITT(Result), 4);

  Result := Result + LCRC16;
end;

function TRequisicoesPix.RetornaTokenDB(out AExpiracao: Integer;
                                        out ADataCriacao: TDateTime): String;
  Var
    LConsulta: IDataset;
begin
  Result := '';

  AExpiracao := 0;

  Try
    LConsulta := VS_FuncoesExternas.fGetDataset;

    If Not FGravaAutorizacaoPix Then
      Exit;

    LConsulta.SQL := 'SELECT * FROM AUTPIX ' +
                     ' WHERE AUT_SEQCHV="' + FAutoIncremPix + '" ' +
                     ' ORDER BY AUT_DTACAD ';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      If IncSecond(LConsulta.FieldByName('AUT_DTACAD').AsFloat,
                   LConsulta.FieldByName('AUT_EXPIRA').AsInteger - 45) <= RetornaCurrentTimeStampServidorDataHora Then
        LConsulta.Delete
      Else
      Begin
        Result := LConsulta.FieldByName('AUT_ATOKEN').AsString;
        AExpiracao := LConsulta.FieldByName('AUT_EXPIRA').AsInteger;
        ADataCriacao := LConsulta.FieldByName('AUT_DTACAD').AsFloat;

        Break;
      End;
    End;

    LConsulta.Close;
  Except

  End;
end;

function TRequisicoesPix.RetornaValorCampoCasoExista(ADataset: IDataset;
  ACampo: String; AValorDefault: String): String;
begin
  Result := EmptyStr;

  If ADataset.FindField(ACampo) <> Nil Then
    Result := ADataset.FindField(ACampo).AsString;

  If Result.IsEmpty Then
    Result := AValorDefault;
end;

function TRequisicoesPix.RetornaValorCampoExistente(ADataset: IDataset;
  ANomeCampo, AValorDefaultCampoInexistente: String): String;
begin
  If ADataset.FindField(ANomeCampo) = Nil Then
    Exit(AValorDefaultCampoInexistente);

  Result := ADataset.FieldByName(ANomeCampo).AsString;
end;

procedure TRequisicoesPix.OnGetPassword(var Password: String);
begin
  Password := FSenhaCertificado;
end;

procedure TRequisicoesPix.OnHeartBeat(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TRequisicoesPix.PreencheCertificadosSynalist(var ARequisicao: THTTPSend; ABanco: String);
Var
  LUtilizaPfx: Boolean;
{$IFDEF LINUX}
  LCertPem, LKeyPem: string;
{$ENDIF}
begin
  ARequisicao.sock.OnHeartbeat := OnHeartBeat;

  ARequisicao.sock.SSL.PFXfile := EmptyStr;
  ARequisicao.Sock.SSL.KeyPassword := EmptyStr;

  ARequisicao.sock.SSL.CertificateFile := EmptyStr;
  ARequisicao.sock.ssl.PrivateKeyFile  := EmptyStr;
  ARequisicao.sock.ssl.Password := EmptyStr;
  ARequisicao.sock.HeartbeatRate:= 1500;

  ARequisicao.KeepAlive := False;

  If FUtilizaShipay Then
    Exit;

  If MatchStr(Concat(ABanco, FHomologacao), ['001S']) Then
    Exit;

  LUtilizaPfx := MatchStr(ABanco, ['001', '033', '756', '290', '422']);
  If Not LUtilizaPfx Then
    LUtilizaPfx := FSicrediUsaPfx;

  If LUtilizaPfx then
  Begin
   {$IFDEF LINUX}
    ConverterPFXParaPEM(FProtocoloSSL.SSLOptions.CertFile, FSenhaCertificado, LCertPem, LKeyPem);
    ARequisicao.Sock.SSL.CertificateFile := LCertPem;
    ARequisicao.Sock.SSL.PrivateKeyFile  := LKeyPem;
   {$ELSE}
    ARequisicao.sock.SSL.PFXfile     := FProtocoloSSL.SSLOptions.CertFile;
    ARequisicao.Sock.SSL.KeyPassword := FSenhaCertificado;
   {$ENDIF}
    If FProtocoloSSL.SSLOptions.CertFile.IsEmpty Then
    Begin
      If ABanco.Equals('033') Then
        Raise Exception.Create('Para utilizar o banco Santander após a atualização da API do Pix, é necessário ' + #13 +
                               'carregar o certificado PFX (A1) no Cadastro de Contas Bancárias da conta.');
    End;
  End
  Else
  Begin
    ARequisicao.sock.SSL.CertificateFile := FProtocoloSSL.SSLOptions.CertFile;
    ARequisicao.sock.ssl.PrivateKeyFile  := FProtocoloSSL.SSLOptions.KeyFile;
    ARequisicao.sock.ssl.Password := FSenhaCertificado;

    If MatchStr(ABanco, ['237', '748']) Then
      ARequisicao.Sock.SSL.KeyPassword := FSenhaCertificado;
  End;
end;

function TRequisicoesPix.SelecionaTokenChaveGravado: String;
  Var
    LToken: TDadosToken;

    LExpiracao: Integer;

    LDataToken: TDateTime;
begin
  Result := RetornaTokenDB(LExpiracao,
                           LDataToken);

  If Not Result.IsEmpty Then
  Begin
    LToken := TDadosToken.Create;
    LToken.Banco := FCodigoDoBanco;
    LToken.Token := Result;
    LToken.Empresa := FEmpresaConfiguracao;
    LToken.Portador := FPortadorConta;

    LToken.DataLimite := IncSecond(LDataToken, LExpiracao);

    VS_ListaToken.Add(LToken);
  End;
end;

procedure TRequisicoesPix.SetExecutandoPeloRobo(AValor: String);
begin
  FExecutandoPeloRobo := AValor;
end;

procedure TRequisicoesPix.SetIgnorarErro404Robo(AValor: String);
begin
  FIgnorarErro404Robo := AValor;
end;

procedure TRequisicoesPix.SetTxIdRemoverBancoBtg(ATxIdRemover: String);
begin
  FTxIdRemoverBancoBtg := ATxIdRemover;
end;

function TRequisicoesPix.SolicitarDevolucao(AIDPagamento, AIdDevolucao,
  ADadosDevolucao: String): String;
  var
    LLinkRequisicao: String;

    LParametros: TStringStream;

    LLista: TStringList;

    LRespostaRequiscao: Integer;
begin
  Try
    ValidacoesIniciaisParaUsoDaRotina;

    if FUtilizaTefScope then
    begin
      Result := TRequisicoesPixLib.SolicitarDevolucaoTefScope(AIDPagamento,
                                                              ADadosDevolucao,
                                                              VS_FuncoesExternas.fIRetOperadorLogado);
      Exit;
    end;

    If FUtilizaShipay Then
    Begin
      Result := TRequisicoesPixLib.SolicitarDevolucaoShipay(FCodigoDoBanco + 'S',
                                                            FLinkSolicitarDevolucao.Replace('[TXID]', AIDPagamento),
                                                            FNomeCertificado,
                                                            ADadosDevolucao,
                                                            GetToken(FAutorizacao),
                                                            FClientID,
                                                            FClientSecret);

      VerificaSeRetornouErro(Result);

      Exit;
    End;

    CarregaCertificados;

    LLista := TStringList.Create;
    LLista.Append(ADadosDevolucao);

    LParametros := TStringStream.Create(LLista.Text, TEncoding.UTF8);

    Application.ProcessMessages;

    LLinkRequisicao := FLinkSolicitarDevolucao.Replace('[APP_DEV_KEY]', FAppDevKey);
    LLinkRequisicao := LLinkRequisicao.Replace('[E2ID]', AIDPagamento);
    LLinkRequisicao := LLinkRequisicao.Replace('[ID]', AIDDevolucao);

    Result := SolicitarDevolucaoSynalist(LLinkRequisicao,
                                         ADadosDevolucao);

    VerificaSeRetornouErro(Result);
    
    FreeAndNil(LParametros);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}

      GravarLOGERR_PixTipo('',
                           E.Message,
                           ADadosDevolucao,
                           FLinkSolicitarDevolucao.Replace('[E2ID]', AIDPagamento)
                                                  .Replace('[APP_DEV_KEY]', FAppDevKey)
                                                  .Replace('[ID]', AIDDevolucao),
                           AIDPagamento,
                           trpSolicitarDevolucao);

      If TFuncoesPix.RetornaMensagemErroRequisicao(E.Message).IsEmpty Then
      Begin
        LRespostaRequiscao := RetornaCodigoRespostaErro;

        Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                           'Ocorreu um erro ao solicitar a devolução Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                           'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                               LRespostaRequiscao.ToString,
                                                                                               E.Message,
                                                                                               E.Message),
                                           '');
      End
      Else
        Result := E.Message;
    End;
  End;

  FreeAndNil(LLista);
end;

function TRequisicoesPix.SolicitarDevolucaoSynalist(ALinkRequisicao,
  ADadosDevolucao: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta: String;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesPix.SolicitarDevolucaoSynalist');
 {$ENDIF}

  FTratarErroSynalist := True;

  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := RetornaMimeTypeCobranca(FCodigoDoBanco);
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.AddStrings(RetornaHeadersCobranca(FCodigoDoBanco));
      PreencheCertificadosSynalist(LHTTPSend, FCodigoDoBanco);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( TIMEOUT_REQUISICOES );
      LHTTPSend.Sock.ConnectionTimeout   := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.SocksTimeout        := TIMEOUT_REQUISICOES;
      LHTTPSend.Sock.HTTPTunnelTimeout   := TIMEOUT_REQUISICOES;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(ADadosDevolucao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      Try
        If LHTTPSend.HTTPMethod('PUT', ALinkRequisicao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result := LResposta;

            If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
              Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                               LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End
        Else
          Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                           LHTTPSend.Sock.LastErrorDesc);
      Finally
        GravarLogAPI('TRequisicoesPix.SolicitarDevolucaoSynalist', ALinkRequisicao, 'PUT', ADadosDevolucao, LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}

      Result := TFuncoesPix.RetornaResultadoRequisicao('-1',
                                                       E.Message);
    End;
  End;
end;

function TRequisicoesPix.TrataErroConsultaTxId(
  AException: Exception; ATxIdPix: String;
  AString: Boolean): String;
  Var
    LRespostaRequiscao: Integer;

    LRefazerConsultaRetorno: String;
begin
  LRespostaRequiscao := RetornaCodigoRespostaErro;

  If FTratarErroSynalist Then
  Begin
    LRespostaRequiscao := StrToIntDef(FCodigoRetornoErro, -1);

    If FValidarErro401403 Then
    Begin
      If MatchStr(LRespostaRequiscao.ToString, ['401', '403', '404']) Then
      Begin
        LRefazerConsultaRetorno := RefazerConsultaPorTxId(ATxIdPix, AString);

        If TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRefazerConsultaRetorno).Txid.Equals(ATxIdPix) Then
        Begin
          Result := LRefazerConsultaRetorno;

          Exit;
        End;
      End;


      GravarLOGERR_PixTipo('',
                           AException.Message,
                           '',
                           FLinkConsultarPixUnico.Replace('[TXID]', ATxIdPix)
                                                 .Replace('[APP_DEV_KEY]', FAppDevKey),
                           ATxIdPix,
                           trpConsultarCobranca);
    End;

    Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                       'Ocorreu um erro ao consultar a cobrança Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                       'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                           LRespostaRequiscao.ToString,
                                                                                           AException.Message,
                                                                                           AException.Message),
                                       '');

    If FExecutandoPeloRobo.Equals('S') Then
      GravarLOGERR_PixTipo('',
                           AException.Message,
                           '',
                           FLinkConsultarPixUnico.Replace('[TXID]', ATxIdPix)
                                                 .Replace('[APP_DEV_KEY]', FAppDevKey),
                           ATxIdPix,
                           trpConsultarCobranca);

    Exit;
  End;

  If TFuncoesPix.RetornaMensagemErroRequisicao(AException.Message).IsEmpty Then
  Begin
    If FValidarErro401403 Then
    Begin
      If MatchStr(LRespostaRequiscao.ToString, ['401', '403']) Then
      Begin
        LRefazerConsultaRetorno := RefazerConsultaPorTxId(ATxIdPix, AString);

        If TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRefazerConsultaRetorno).Txid.Equals(ATxIdPix) Then
        Begin
          Result := LRefazerConsultaRetorno;

          Exit;
        End;
      End;


      GravarLOGERR_PixTipo('',
                           AException.Message,
                           '',
                           FLinkConsultarPixUnico.Replace('[TXID]', ATxIdPix)
                                                 .Replace('[APP_DEV_KEY]', FAppDevKey),
                           ATxIdPix,
                           trpConsultarCobranca);
    End;

    Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                       'Ocorreu um erro ao consultar a cobrança Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                       'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                           LRespostaRequiscao.ToString,
                                                                                           AException.Message,
                                                                                           AException.Message),
                                         '');
  End
  Else
  Begin
    GravarLOGERR_PixTipo('',
                         AException.Message,
                         '',
                         FLinkConsultarPixUnico.Replace('[TXID]', ATxIdPix)
                                               .Replace('[APP_DEV_KEY]', FAppDevKey),
                         ATxIdPix,
                         trpConsultarCobranca);

    If TFuncoesPix.RetornaMensagemErroRequisicao(AException.Message).IsEmpty Then
    Begin
      LRespostaRequiscao := RetornaCodigoRespostaErro;

      Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                         'Ocorreu um erro ao consultar a cobrança Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                         'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                             LRespostaRequiscao.ToString,
                                                                                             AException.Message,
                                                                                             AException.Message),
                                         '');
    End
    Else
      Result := AException.Message;
  End;
end;

function TRequisicoesPix.TrataErroCriarCobrancaTxId(AException: Exception;
  ATxIdPix, ADadosRequisicao, ALinkRequisicao: String): String;
  Var
    LRespostaRequiscao: Integer;
begin
  GravarLOGERR_PixTipo('',
                       AException.Message,
                       ADadosRequisicao.Replace(#13, EmptyStr),
                       ALinkRequisicao,
                       ATxIdPix,
                       trpCriarCobranca);

  If FTratarErroSynalist Then
  Begin
    LRespostaRequiscao := StrToIntDef(FCodigoRetornoErro, -1);

    Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                       'Ocorreu um erro ao criar a cobrança Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                       'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                           LRespostaRequiscao.ToString,
                                                                                           AException.Message,
                                                                                           AException.Message),
                                       '');
    Exit;
  End;

  If TFuncoesPix.RetornaMensagemErroRequisicao(AException.Message).IsEmpty Then
  Begin
    LRespostaRequiscao := RetornaCodigoRespostaErro;

    Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                       'Ocorreu um erro ao criar a cobrança Pix. Código do retorno: ' + LRespostaRequiscao.ToString + #13 +
                                       'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                           LRespostaRequiscao.ToString,
                                                                                           AException.Message,
                                                                                           AException.Message),
                                       '');
  End
  Else
    Result := AException.Message;
end;

function TRequisicoesPix.TrataErroToken(AException: Exception;
  ADadosParametros, ALinkRequisicao: String): String;
  Var
    LRetornoRequisicao: Integer;
begin
  GravarLOGERR_PixToken('',
                        AException.Message,
                        ADadosParametros,
                        ALinkRequisicao);

  If FTratarErroSynalist Then
  Begin
    LRetornoRequisicao := StrToIntDef(FCodigoRetornoErro, -1);

    Result := TFuncoesPix.GeraJsonErro(FCodigoDoBanco,
                                       'Ocorreu um erro retornar o token do Pix. Código do retorno: ' + LRetornoRequisicao.ToString + #13 +
                                       'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(FCodigoDoBanco + IIF(FUtilizaShipay, 'S', ''),
                                                                                           LRetornoRequisicao.ToString,
                                                                                           AException.Message,
                                                                                           AException.Message),
                                       '');
    Exit;
  End
  Else
    Result := AException.Message;
end;

procedure TRequisicoesPix.ValidacoesIniciaisParaUsoDaRotina;
begin
  If FChavePix.IsEmpty Then
    Raise Exception.Create('Chave Pix não foi selecionada.');

  If FAutorizacao.IsEmpty Then
    Raise Exception.Create('Autorização da conta Pix não cadastrada.');

  If FPortadorConta.IsEmpty Then
    Raise Exception.Create('A Chave Pix ' + FChavePix + ' não possui portador vinculado a conta corrente.' + #13 +
                           'Operação cancelada.');
end;

function TRequisicoesPix.ValidarDadosAutenticacao: String;
begin
  LimparDadosDeTokensECertificados;
  LimparTabelaTokens;

  Try
    Result := GetToken(FAutorizacao);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}
      Result := E.Message;
    End;
  End;
end;

procedure TRequisicoesPix.VerificarToken;
begin
  Try
    GetToken(FAutorizacao);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
      FLastError := E.Message;
     {$ENDIF}
      Raise;
    End;
  End;
end;

procedure TRequisicoesPix.VerificaSeRetornouErro(ARetorno: String);
begin
  FCodigoRetornoErro := TFuncoesPix.RetornaValorCampoJson('codigo', ARetorno);
  If Not MatchStr(FCodigoRetornoErro, ['200', '201', EmptyStr]) Then
    Raise Exception.Create(TFuncoesPix.RetornaValorCampoJson('resultado', ARetorno, True));
end;

function TRequisicoesPix.ConsultarPixPorTxId(ATxIdPix: String; AString: Boolean;
  ADadosRequisicao: String): String;
begin
  If Pos('"expiration":', ADadosRequisicao) > 0 Then
  Begin
    If Pos('/orderv', FLinkConsultarPixUnico) <= 0 Then
      FLinkConsultarPixUnico := FLinkConsultarPixUnico.Replace('/order', '/orderv');
  End;

  Result := ConsultarPixPorTxId(ATxIdPix, AString);
end;

function TRequisicoesPix.ConsultarPixPorTxIdSynalist(ALinkRequisicao: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta: String;

    LContador,
    LTimeoutRotina: Integer;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesPix.ConsultarPixPorTxIdSynalist');
 {$ENDIF}

  FTratarErroSynalist := True;

  LTimeoutRotina := TIMEOUT_REQUISICOES_TELA;
  if FExecutandoPeloRobo.Equals('S') then
    LTimeoutRotina := TIMEOUT_REQUISICOES;

  For LContador := 1 To TOTAL_TENTATIVAS_TIMEOUT Do
  Begin
    Try
      Try
        LHTTPSend :=THTTPSend.Create;
        LHTTPSend.MimeType  := RetornaMimeTypeCobranca(FCodigoDoBanco);
        LHTTPSend.Protocol  := '1.1';

        LHTTPSend.Headers.AddStrings(RetornaHeadersCobranca(FCodigoDoBanco));
        PreencheCertificadosSynalist(LHTTPSend, FCodigoDoBanco);

        LHTTPSend.Sock.SSL.SSLType:= LT_all;

        LHTTPSend.Sock.SetTimeout( LTimeoutRotina );
        LHTTPSend.Sock.ConnectionTimeout   := LTimeoutRotina;
        LHTTPSend.Sock.InterPacketTimeout  := False;
        LHTTPSend.Sock.NonblockSendTimeout := LTimeoutRotina;
        LHTTPSend.Sock.SocksTimeout        := LTimeoutRotina;
        LHTTPSend.Sock.HTTPTunnelTimeout   := LTimeoutRotina;

        Try
          If LHTTPSend.HTTPMethod('GET', ALinkRequisicao) Then
          Begin
            LHTTPSend.Document.Position := 0;

            Try
              LFDataResp := TMemoryStream.Create;
              LFDataResp.LoadFromStream(LHTTPSend.Document);

              LFDataResp.Position := 0;
              LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
              Result := LResposta;

              If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
                Result :=  TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                                  LResposta);
            Finally
              FreeAndNil(LFDataResp);
            End;

          End
          Else
            Result := TFuncoesPix.RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                             LHTTPSend.Sock.LastErrorDesc);

          If MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
            Break;
        Finally
          GravarLogAPI('TRequisicoesPix.ConsultarPixPorTxIdSynalist', ALinkRequisicao, 'GET', '', LResposta, LHTTPSend);
        End;
      Finally
        FreeAndNil(LHTTPSend);
      End;
    Except
      On E: Exception Do
      Begin
       {$IFDEF LINUX}
        WriteError(E.Message);
        FLastError := E.Message;
       {$ENDIF}
        Result := TFuncoesPix.RetornaResultadoRequisicao('-1',
                                                         E.Message);

        If Not E.Message.Contains('Connection timed out') Then
          Break;

        Sleep(1000);
      End;
    End;
  End;
end;

end.
