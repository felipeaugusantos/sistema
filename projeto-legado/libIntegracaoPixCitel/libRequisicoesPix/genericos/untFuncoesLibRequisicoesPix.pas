unit untFuncoesLibRequisicoesPix;

interface
Uses untTRequisicoesPixTls13, System.SysUtils;

procedure CriaRequisicoes;

function GetToken(ACodigoBanco,
                  ALinkRequisicao,
                  ANomeCertificado,
                  AChaveBasic,
                  AClientID,
                  AClientSecret: String): String; stdcall;

function GetTokenSicoob(ALinkRequisicao,
                        ANomeCertificado,
                        AClientID,
                        AClientSecret,
                        ACertificadoCRT,
                        ACertificadoKey,
                        ASenhaCertificado: String): String; stdcall;

function GetTokenSynalist(ACodigoBanco,
                          ALinkRequisicao,
                          ANomeCertificado,
                          AChaveBasic,
                          AClientID,
                          AClientSecret,
                          ACertificadoCRT,
                          ACertificadoKey,
                          ASenhaCertificado: String): String; stdcall;

function CriarCobranca(ACodigoBanco,
                       ALinkRequisicao,
                       ANomeCertificado,
                       AToken,
                       ACorpoRequisicao,
                       AClientID,
                       AClientSecret: String): String; stdcall;

function CriarCobrancaSynalist(ACodigoBanco,
                               ALinkRequisicao,
                               AToken,
                               ACorpoRequisicao,
                               AClientID,
                               AClientSecret,
                               AArquivoCrt,
                               AArquivoKey,
                               ASenhaCertificado: String): String; stdcall;

function AlterarCobranca(ACodigoBanco,
                         ALinkRequisicao,
                         ANomeCertificado,
                         AToken,
                         ACorpoRequisicao,
                         AClientID,
                         AClientSecret: String): String; stdcall;

function AlterarCobrancaSynalist(ACodigoBanco,
                                 ALinkRequisicao,
                                 AToken,
                                 ACorpoRequisicao,
                                 AClientID,
                                 AClientSecret,
                                 AArquivoCrt,
                                 AArquivoKey,
                                 ASenhaCertificado: String): String; stdcall;

function ConsultarCobrancaPorIxId(ACodigoBanco,
                                  ALinkRequisicao,
                                  ANomeCertificado,
                                  AToken,
                                  AClientID,
                                  AClientSecret: String): String; stdcall;

function ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
                                          ALinkRequisicao,
                                          AToken,
                                          AClientID,
                                          AClientSecret,
                                          AArquivoCrt,
                                          AArquivoKey,
                                          ASenhaCertificado: String): String; stdcall;

function SolicitarDevolucao(ACodigoBanco,
                            ALinkRequisicao,
                            ANomeCertificado,
                            ACorpoRequisicao,
                            AToken,
                            AClientID,
                            AClientSecret: String): String; stdcall;

function SolicitarDevolucaoSynalist(ACodigoBanco,
                                    ALinkRequisicao,
                                    ACorpoRequisicao,
                                    AToken,
                                    AClientID,
                                    AClientSecret,
                                    AArquivoCrt,
                                    AArquivoKey,
                                    ASenhaCertificado: String): String; stdcall;

{ SHIPAY }
function GetTokenShipay(ACodigoBanco,
                        ALinkRequisicao,
                        ANomeCertificado,
                        AChaveAccess,
                        AClientID,
                        AClientSecret: String): String; stdcall;

function CriarCobrancaShipay(ACodigoBanco,
                             ALinkRequisicao,
                             ANomeCertificado,
                             AToken,
                             ACorpoRequisicao,
                             AClientID,
                             AClientSecret: String): String; stdcall;

function ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
                                           ALinkRequisicao,
                                           ANomeCertificado,
                                           AToken,
                                           AClientID,
                                           AClientSecret: String): String; stdcall;

function CancelarCobrancaShipay(ACodigoBanco,
                                ALinkRequisicao,
                                ANomeCertificado,
                                AToken,
                                AClientID,
                                AClientSecret: String): String; stdcall;

function SolicitarDevolucaoShipay(ACodigoBanco,
                                  ALinkRequisicao,
                                  ANomeCertificado,
                                  ACorpoRequisicao,
                                  AToken,
                                  AClientID,
                                  AClientSecret: String): String; stdcall;

Var
  FRequisicoes: TRequisicoesPixTls13;

implementation

procedure CriaRequisicoes;
Begin
  if Not Assigned(FRequisicoes) then
    FRequisicoes := TRequisicoesPixTls13.Create;
End;

function GetToken(ACodigoBanco,
                  ALinkRequisicao,
                  ANomeCertificado,
                  AChaveBasic,
                  AClientID,
                  AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.GetToken(ACodigoBanco,
                                    ALinkRequisicao,
                                    ANomeCertificado,
                                    AChaveBasic,
                                    AClientID,
                                    AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function GetTokenSicoob(ALinkRequisicao,
                        ANomeCertificado,
                        AClientID,
                        AClientSecret,
                        ACertificadoCRT,
                        ACertificadoKey,
                        ASenhaCertificado: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.GetTokenSicoob(ALinkRequisicao,
                                          ANomeCertificado,
                                          AClientID,
                                          AClientSecret,
                                          ACertificadoCRT,
                                          ACertificadoKey,
                                          ASenhaCertificado);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function GetTokenSynalist(ACodigoBanco,
                          ALinkRequisicao,
                          ANomeCertificado,
                          AChaveBasic,
                          AClientID,
                          AClientSecret,
                          ACertificadoCRT,
                          ACertificadoKey,
                          ASenhaCertificado: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.GetTokenSynalist(ACodigoBanco,
                                            ALinkRequisicao,
                                            ANomeCertificado,
                                            AChaveBasic,
                                            AClientID,
                                            AClientSecret,
                                            ACertificadoCRT,
                                            ACertificadoKey,
                                            ASenhaCertificado);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function GetTokenShipay(ACodigoBanco,
                        ALinkRequisicao,
                        ANomeCertificado,
                        AChaveAccess,
                        AClientID,
                        AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.GetTokenShipay(ACodigoBanco,
                                          ALinkRequisicao,
                                          ANomeCertificado,
                                          AChaveAccess,
                                          AClientID,
                                          AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function CriarCobranca(ACodigoBanco,
                       ALinkRequisicao,
                       ANomeCertificado,
                       AToken,
                       ACorpoRequisicao,
                       AClientID,
                       AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.CriarCobranca(ACodigoBanco,
                                         ALinkRequisicao,
                                         ANomeCertificado,
                                         AToken,
                                         ACorpoRequisicao,
                                         AClientID,
                                         AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function CriarCobrancaSynalist(ACodigoBanco,
                               ALinkRequisicao,
                               AToken,
                               ACorpoRequisicao,
                               AClientID,
                               AClientSecret,
                               AArquivoCrt,
                               AArquivoKey,
                               ASenhaCertificado: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.CriarCobrancaSynalist(ACodigoBanco,
                                                 ALinkRequisicao,
                                                 AToken,
                                                 ACorpoRequisicao,
                                                 AClientID,
                                                 AClientSecret,
                                                 AArquivoCrt,
                                                 AArquivoKey,
                                                 ASenhaCertificado);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function CriarCobrancaShipay(ACodigoBanco,
                             ALinkRequisicao,
                             ANomeCertificado,
                             AToken,
                             ACorpoRequisicao,
                             AClientID,
                             AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.CriarCobrancaShipay(ACodigoBanco,
                                               ALinkRequisicao,
                                               ANomeCertificado,
                                               AToken,
                                               ACorpoRequisicao,
                                               AClientID,
                                               AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function AlterarCobranca(ACodigoBanco,
                         ALinkRequisicao,
                         ANomeCertificado,
                         AToken,
                         ACorpoRequisicao,
                         AClientID,
                         AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.AlterarCobranca(ACodigoBanco,
                                           ALinkRequisicao,
                                           ANomeCertificado,
                                           AToken,
                                           ACorpoRequisicao,
                                           AClientID,
                                           AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function AlterarCobrancaSynalist(ACodigoBanco,
                                 ALinkRequisicao,
                                 AToken,
                                 ACorpoRequisicao,
                                 AClientID,
                                 AClientSecret,
                                 AArquivoCrt,
                                 AArquivoKey,
                                 ASenhaCertificado: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.AlterarCobrancaSynalist(ACodigoBanco,
                                                   ALinkRequisicao,
                                                   AToken,
                                                   ACorpoRequisicao,
                                                   AClientID,
                                                   AClientSecret,
                                                   AArquivoCrt,
                                                   AArquivoKey,
                                                   ASenhaCertificado);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function ConsultarCobrancaPorIxId(ACodigoBanco,
                                  ALinkRequisicao,
                                  ANomeCertificado,
                                  AToken,
                                  AClientID,
                                  AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.ConsultarCobrancaPorIxId(ACodigoBanco,
                                                    ALinkRequisicao,
                                                    ANomeCertificado,
                                                    AToken,
                                                    AClientID,
                                                    AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
                                          ALinkRequisicao,
                                          AToken,
                                          AClientID,
                                          AClientSecret,
                                          AArquivoCrt,
                                          AArquivoKey,
                                          ASenhaCertificado: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
                                                            ALinkRequisicao,
                                                            AToken,
                                                            AClientID,
                                                            AClientSecret,
                                                            AArquivoCrt,
                                                            AArquivoKey,
                                                            ASenhaCertificado);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function SolicitarDevolucao(ACodigoBanco,
                            ALinkRequisicao,
                            ANomeCertificado,
                            ACorpoRequisicao,
                            AToken,
                            AClientID,
                            AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.SolicitarDevolucao(ACodigoBanco,
                                              ALinkRequisicao,
                                              ANomeCertificado,
                                              ACorpoRequisicao,
                                              AToken,
                                              AClientID,
                                              AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function SolicitarDevolucaoSynalist(ACodigoBanco,
                                    ALinkRequisicao,
                                    ACorpoRequisicao,
                                    AToken,
                                    AClientID,
                                    AClientSecret,
                                    AArquivoCrt,
                                    AArquivoKey,
                                    ASenhaCertificado: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.SolicitarDevolucaoSynalist(ACodigoBanco,
                                                      ALinkRequisicao,
                                                      ACorpoRequisicao,
                                                      AToken,
                                                      AClientID,
                                                      AClientSecret,
                                                      AArquivoCrt,
                                                      AArquivoKey,
                                                      ASenhaCertificado);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
                                           ALinkRequisicao,
                                           ANomeCertificado,
                                           AToken,
                                           AClientID,
                                           AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
                                                             ALinkRequisicao,
                                                             ANomeCertificado,
                                                             AToken,
                                                             AClientID,
                                                             AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function CancelarCobrancaShipay(ACodigoBanco,
                                ALinkRequisicao,
                                ANomeCertificado,
                                AToken,
                                AClientID,
                                AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.CancelarCobrancaShipay(ACodigoBanco,
                                                  ALinkRequisicao,
                                                  ANomeCertificado,
                                                  AToken,
                                                  AClientID,
                                                  AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

function SolicitarDevolucaoShipay(ACodigoBanco,
                                  ALinkRequisicao,
                                  ANomeCertificado,
                                  ACorpoRequisicao,
                                  AToken,
                                  AClientID,
                                  AClientSecret: String): String; stdcall;
Begin
  CriaRequisicoes;

  Try
    Result := FRequisicoes.SolicitarDevolucaoShipay(ACodigoBanco,
                                                    ALinkRequisicao,
                                                    ANomeCertificado,
                                                    ACorpoRequisicao,
                                                    AToken,
                                                    AClientID,
                                                    AClientSecret);
  Finally
    FreeAndNil(FRequisicoes);
  End;
End;

end.
