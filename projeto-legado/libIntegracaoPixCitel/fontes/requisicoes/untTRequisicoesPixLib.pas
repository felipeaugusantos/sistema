unit untTRequisicoesPixLib;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Winapi.Windows, Winapi.Messages,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
{$ENDIF}
  System.SysUtils, System.Variants, untInterfacePixTefBridge,
  System.Classes, System.StrUtils, System.JSON;

Type
  TRequisicoesPixLib = class({$IFDEF LINUX}TComponent{$ELSE}TForm{$ENDIF})
  private
    class function fJsonStrToFloat(const AValor: String; ADefault: Double = 0): Double;
  public
    class var RequisicaoAtualizadaShipay: String;

    class function GetToken(ACodigoBanco,
                            ALinkRequisicao,
                            ANomeCertificado,
                            AChaveBasic,
                            AClientID,
                            AClientSecret: String): String;

    class function GetTokenSicoob(ALinkRequisicao,
                                  ANomeCertificado,
                                  AClientID,
                                  AClientSecret,
                                  ACertificadoCRT,
                                  ACertificadoKey,
                                  ASenhaCertificado: String): String;

    class function GetTokenSynalist(ACodigoBanco,
                                    ALinkRequisicao,
                                    ANomeCertificado,
                                    AChaveBasic,
                                    AClientID,
                                    AClientSecret,
                                    ACertificadoCRT,
                                    ACertificadoKey,
                                    ASenhaCertificado: String): String;

    class function CriarCobranca(ACodigoBanco,
                                 ALinkRequisicao,
                                 ANomeCertificado,
                                 AToken,
                                 ACorpoRequisicao,
                                 AClientID,
                                 AClientSecret: String): String;

    class function CriarCobrancaTefScope(const ACorpoRequisicao,
                                               ACodigoOperador,
                                               ACnpjEmpresa,
                                               ANomeEmpresa: String;
                                         out   AJsonRequest,
                                               AJsonResponse,
                                               AJsonDados: String): Boolean;

    class function CriarCobrancaSynalist(ACodigoBanco,
                                         ALinkRequisicao,
                                         ANomeCertificado,
                                         AToken,
                                         ACorpoRequisicao,
                                         AClientID,
                                         AClientSecret,
                                         ACertificadoCRT,
                                         ACertificadoKey,
                                         ASenhaCertificado: String): String;

    class function AlterarCobranca(ACodigoBanco,
                                   ALinkRequisicao,
                                   ANomeCertificado,
                                   AToken,
                                   ACorpoRequisicao,
                                   AClientID,
                                   AClientSecret: String): String;

    class function AlterarCobrancaSynalist(ACodigoBanco,
                                           ALinkRequisicao,
                                           ANomeCertificado,
                                           AToken,
                                           ACorpoRequisicao,
                                           AClientID,
                                           AClientSecret,
                                           ACertificadoCRT,
                                           ACertificadoKey,
                                           ASenhaCertificado: String): String;

    class function ConsultarCobrancaPorIxId(ACodigoBanco,
                                            ALinkRequisicao,
                                            ANomeCertificado,
                                            AToken,
                                            AClientID,
                                            AClientSecret: String): String;

    class function ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
                                                    ALinkRequisicao,
                                                    ANomeCertificado,
                                                    AToken,
                                                    AClientID,
                                                    AClientSecret,
                                                    ACertificadoCRT,
                                                    ACertificadoKey,
                                                    ASenhaCertificado: String): String;

    class function SolicitarDevolucao(ACodigoBanco,
                                      ALinkRequisicao,
                                      ANomeCertificado,
                                      ACorpoRequisicao,
                                      AToken,
                                      AClientID,
                                      AClientSecret: String): String;

    class function SolicitarDevolucaoSynalist(ACodigoBanco,
                                              ALinkRequisicao,
                                              ANomeCertificado,
                                              ACorpoRequisicao,
                                              AToken,
                                              AClientID,
                                              AClientSecret,
                                              ACertificadoCRT,
                                              ACertificadoKey,
                                              ASenhaCertificado: String): String;

    { SHIPAY }
    class function GetTokenShipay(ACodigoBanco,
                                  ALinkRequisicao,
                                  ANomeCertificado,
                                  AChaveAccess,
                                  AClientID,
                                  AClientSecret: String): String;

    class function CriarCobrancaShipay(ACodigoBanco,
                                       ALinkRequisicao,
                                       ANomeCertificado,
                                       AToken,
                                       ACorpoRequisicao,
                                       AClientID,
                                       AClientSecret: String): String;

    class function ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
                                                     ALinkRequisicao,
                                                     ANomeCertificado,
                                                     AToken,
                                                     AClientID,
                                                     AClientSecret: String): String;

    class function CancelarCobrancaShipay(ACodigoBanco,
                                          ALinkRequisicao,
                                          ANomeCertificado,
                                          AToken,
                                          AClientID,
                                          AClientSecret: String): String;

    class function SolicitarDevolucaoShipay(ACodigoBanco,
                                            ALinkRequisicao,
                                            ANomeCertificado,
                                            ACorpoRequisicao,
                                            AToken,
                                            AClientID,
                                            AClientSecret: String): String;

    class function SolicitarDevolucaoTefScope(const AControle: String;
                                              const ADadosRequest: String;
                                              const AOperador: String): String;
  end;

implementation
Uses untTFuncoesAuxiliaresPix;
{ TRequisicoesPixLib }

class function TRequisicoesPixLib.AlterarCobranca(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    AlterarCobranca: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    AlterarCobranca := GetProcAddress(LHandleRequisicoesPix, 'AlterarCobranca');
    Result := AlterarCobranca(ACodigoBanco,
                              ALinkRequisicao,
                              ANomeCertificado,
                              AToken,
                              ACorpoRequisicao,
                              AClientID,
                              AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If Not MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := TFuncoesPix.GeraJsonErro(ACodigoBanco,
                                         'Ocorreu um erro ao alterar a cobrança Pix. Código do retorno: ' + LJsonObject.GetValue<String>('codigo') + #13 +
                                         'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(ACodigoBanco,
                                                                                             LJsonObject.GetValue<String>('codigo'),
                                                                                             LJsonObject.GetValue('resultado').ToString,
                                                                                             LJsonObject.GetValue('resultado').ToString),
                                         '')
    Else
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.AlterarCobrancaSynalist(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret, ACertificadoCRT, ACertificadoKey,
  ASenhaCertificado: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    FExisteRotinaSynalist: Boolean;

    AlterarCobrancaSynalist: function(ACodigoBanco, ALinkRequisicao, AToken, ACorpoRequisicao, AClientID, AClientSecret, ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  FExisteRotinaSynalist := True;

  Try
    AlterarCobrancaSynalist := GetProcAddress(LHandleRequisicoesPix, 'AlterarCobrancaSynalist');

    Try
      Result := AlterarCobrancaSynalist(ACodigoBanco,
                                       ALinkRequisicao,
                                       AToken,
                                       ACorpoRequisicao,
                                       AClientID,
                                       AClientSecret,
                                       ACertificadoCRT,
                                       ACertificadoKey,
                                       ASenhaCertificado);

      LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

      If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
        Result := LJsonObject.GetValue('resultado').ToString;
    Except
      FExisteRotinaSynalist := False;
    End;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;

  If Not FExisteRotinaSynalist Then
    Result := Self.AlterarCobranca(ACodigoBanco,
                                   ALinkRequisicao,
                                   ANomeCertificado,
                                   AToken,
                                   ACorpoRequisicao,
                                   AClientID,
                                   AClientSecret);
end;

class function TRequisicoesPixLib.CancelarCobrancaShipay(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    CancelarCobrancaShipay: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    CancelarCobrancaShipay := GetProcAddress(LHandleRequisicoesPix, 'CancelarCobrancaShipay');
    Result := CancelarCobrancaShipay(ACodigoBanco,
                                     ALinkRequisicao,
                                     ANomeCertificado,
                                     AToken,
                                     AClientID,
                                     AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.ConsultarCobrancaPorIxId(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    ConsultarCobrancaPorIxId: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    ConsultarCobrancaPorIxId := GetProcAddress(LHandleRequisicoesPix, 'ConsultarCobrancaPorIxId');
    Result := ConsultarCobrancaPorIxId(ACodigoBanco,
                                       ALinkRequisicao,
                                       ANomeCertificado,
                                       AToken,
                                       AClientID,
                                       AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If Not MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := TFuncoesPix.GeraJsonErro(ACodigoBanco,
                                         'Ocorreu um erro ao consultar a cobrança Pix. Código do retorno: ' + LJsonObject.GetValue<String>('codigo') + #13 +
                                         'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(ACodigoBanco,
                                                                                             LJsonObject.GetValue<String>('codigo'),
                                                                                             LJsonObject.GetValue('resultado').ToString,
                                                                                             LJsonObject.GetValue('resultado').ToString),
                                         '')
    Else
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, AClientID, AClientSecret,
  ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    FExisteRotinaSynalist: Boolean;

    ConsultarCobrancaPorIxIdSynalist: function(ACodigoBanco, ALinkRequisicao, AToken, AClientID, AClientSecret, ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  FExisteRotinaSynalist := True;

  Try
    ConsultarCobrancaPorIxIdSynalist := GetProcAddress(LHandleRequisicoesPix, 'ConsultarCobrancaPorIxIdSynalist');

    Try
      Result := ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
                                                 ALinkRequisicao,
                                                 AToken,
                                                 AClientID,
                                                 AClientSecret,
                                                 ACertificadoCRT,
                                                 ACertificadoKey,
                                                 ASenhaCertificado);

      LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

      If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
        Result := LJsonObject.GetValue('resultado').ToString;
    Except
      FExisteRotinaSynalist := False;
    End;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;

  If Not FExisteRotinaSynalist Then
    Result := Self.ConsultarCobrancaPorIxId(ACodigoBanco,
                                            ALinkRequisicao,
                                            ANomeCertificado,
                                            AToken,
                                            AClientID,
                                            AClientSecret);
end;

class function TRequisicoesPixLib.ConsultarCobrancaPorOrderIdShipay(
  ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    ConsultarCobrancaPorOrderIdShipay: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    ConsultarCobrancaPorOrderIdShipay := GetProcAddress(LHandleRequisicoesPix, 'ConsultarCobrancaPorOrderIdShipay');
    Result := ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
                                                ALinkRequisicao,
                                                ANomeCertificado,
                                                AToken,
                                                AClientID,
                                                AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.CriarCobranca(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    CriarCobranca: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    CriarCobranca := GetProcAddress(LHandleRequisicoesPix, 'CriarCobranca');
    Result := CriarCobranca(ACodigoBanco,
                            ALinkRequisicao,
                            ANomeCertificado,
                            AToken,
                            ACorpoRequisicao,
                            AClientID,
                            AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If Not MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := TFuncoesPix.GeraJsonErro(ACodigoBanco,
                                         'Ocorreu um erro ao criar a cobrança Pix. Código do retorno: ' + LJsonObject.GetValue<String>('codigo') + #13 +
                                         'Erro gerado: ' + TFuncoesPix.RetornaErroPeloCodigo(ACodigoBanco,
                                                                                             LJsonObject.GetValue<String>('codigo'),
                                                                                             LJsonObject.GetValue('resultado').ToString,
                                                                                             LJsonObject.GetValue('resultado').ToString),
                                         '')
    Else
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.CriarCobrancaShipay(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll,
    LLinkRequisicao: String;

    LJsonObject: TJsonObject;

    CriarCobrancaShipay: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    LLinkRequisicao := ALinkRequisicao;
    If Pos('expiration', ACorpoRequisicao) > 0 Then
      LLinkRequisicao := LLinkRequisicao.Replace('/order', '/orderv');

    RequisicaoAtualizadaShipay := ACorpoRequisicao;

    CriarCobrancaShipay := GetProcAddress(LHandleRequisicoesPix, 'CriarCobrancaShipay');
    Result := CriarCobrancaShipay(ACodigoBanco,
                                  LLinkRequisicao,
                                  ANomeCertificado,
                                  AToken,
                                  ACorpoRequisicao,
                                  AClientID,
                                  AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.CriarCobrancaSynalist(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret, ACertificadoCRT, ACertificadoKey,
  ASenhaCertificado: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    FExisteRotinaSynalist: Boolean;

    CriarCobrancaSynalist: function(ACodigoBanco, ALinkRequisicao, AToken, ACorpoRequisicao, AClientID, AClientSecret, ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  FExisteRotinaSynalist := True;

  Try
    CriarCobrancaSynalist := GetProcAddress(LHandleRequisicoesPix, 'CriarCobrancaSynalist');

    Try
      Result := CriarCobrancaSynalist(ACodigoBanco,
                                      ALinkRequisicao,
                                      AToken,
                                      ACorpoRequisicao,
                                      AClientID,
                                      AClientSecret,
                                      ACertificadoCRT,
                                      ACertificadoKey,
                                      ASenhaCertificado);

      LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

      If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
        Result := LJsonObject.GetValue('resultado').ToString;
    Except
      FExisteRotinaSynalist := False;
    End;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;

  If Not FExisteRotinaSynalist Then
    Result := Self.CriarCobranca(ACodigoBanco,
                                 ALinkRequisicao,
                                 ANomeCertificado,
                                 AToken,
                                 ACorpoRequisicao,
                                 AClientID,
                                 AClientSecret);
end;

class function TRequisicoesPixLib.CriarCobrancaTefScope(
  const ACorpoRequisicao, ACodigoOperador, ACnpjEmpresa, ANomeEmpresa: String;
  out AJsonRequest, AJsonResponse, AJsonDados: String): Boolean;
var
  LRetorno: TRetornoTransacaoPixTef;
  LValor: Double;
  LobjRoot, LobjValor: TJSONObject;
  LValorOriginal: String;
  LValorChave: String;
  LValorSolicitacaoPagador: String;
  LValue: TJSONValue;
begin
  Result := False;

  if not Assigned(objBridgeTef) then
    Exit;

  AJsonRequest := EmptyStr;
  AJsonResponse := EmptyStr;
  AJsonDados := EmptyStr;
  LValor := 0.00;
  LValue := TJSONObject.ParseJSONValue(ACorpoRequisicao);
  try
    if not (LValue is TJSONObject) then
      raise Exception.Create('JSON inválido em [CriarCobrancaTefScope]');

    LobjRoot := TJSONObject(LValue);
    if not Assigned(LobjRoot) then
      raise Exception.Create('JSON inválido em [CriarCobrancaTefScope]');

    LobjValor := LobjRoot.GetValue<TJSONObject>('valor');
    if not Assigned(LobjValor) then
      raise Exception.Create('Bloco "valor" ausente no JSON [CriarCobrancaTefScope]');

    if not LobjValor.TryGetValue<String>('original', LValorOriginal) then
      LValorOriginal := '0';
    LValor := fJsonStrToFloat(LValorOriginal);

    if not LobjRoot.TryGetValue<String>('chave', LValorChave) then
      LValorChave := EmptyStr;

    if not LobjRoot.TryGetValue<String>('solicitacaoPagador', LValorSolicitacaoPagador) then
      LValorSolicitacaoPagador := EmptyStr;

  finally
    FreeAndNil(LValue);
  end;

  if objBridgeTef.fIniciarTransacaoPix(LValor,
                                       AnsiString(ACodigoOperador),
                                       AnsiString(LValorChave),
                                       AnsiString(LValorSolicitacaoPagador),
                                       AnsiString(ACnpjEmpresa),
                                       AnsiString(ANomeEmpresa),
                                       LRetorno
                                       ) then
  begin
    AJsonRequest := String(LRetorno.JsonRequestPagamentoPix);
    AJsonResponse := String(LRetorno.JsonResponsePagamentoPix);
    AJsonDados := String(LRetorno.JsonDadosPagamentoPix);
    Result := True;
  end;

end;

class function TRequisicoesPixLib.fJsonStrToFloat(const AValor: String;
  ADefault: Double): Double;
var
  LfmtInv: TFormatSettings;
begin
  LfmtInv := TFormatSettings.Invariant;
  if not TryStrToFloat(AValor, Result, LfmtInv) then
    Result := ADefault;
end;

class function TRequisicoesPixLib.GetToken(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AChaveBasic, AClientID, AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    GetToken: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AChaveBasic, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    GetToken := GetProcAddress(LHandleRequisicoesPix, 'GetToken');
    Result := GetToken(ACodigoBanco,
                       ALinkRequisicao,
                       ANomeCertificado,
                       AChaveBasic,
                       AClientID,
                       AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.GetTokenSicoob(ALinkRequisicao,
  ANomeCertificado, AClientID, AClientSecret, ACertificadoCRT,
  ACertificadoKey, ASenhaCertificado: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    GetTokenSicoob: function(ALinkRequisicao, ANomeCertificado, AClientID, AClientSecret, ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    GetTokenSicoob := GetProcAddress(LHandleRequisicoesPix, 'GetTokenSicoob');
    Result := GetTokenSicoob(ALinkRequisicao,
                             ANomeCertificado,
                             AClientID,
                             AClientSecret,
                             ACertificadoCRT,
                             ACertificadoKey,
                             ASenhaCertificado);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.GetTokenSynalist(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AChaveBasic, AClientID, AClientSecret,
  ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    GetTokenSynalist: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AChaveBasic, AClientID, AClientSecret, ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    GetTokenSynalist := GetProcAddress(LHandleRequisicoesPix, 'GetTokenSynalist');
    Result := GetTokenSynalist(ACodigoBanco,
                               ALinkRequisicao,
                               ANomeCertificado,
                               AChaveBasic,
                               AClientID,
                               AClientSecret,
                               ACertificadoCRT,
                               ACertificadoKey,
                               ASenhaCertificado);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.GetTokenShipay(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AChaveAccess, AClientID, AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    GetTokenShipay: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, AChaveAccess, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    GetTokenShipay := GetProcAddress(LHandleRequisicoesPix, 'GetTokenShipay');
    Result := GetTokenShipay(ACodigoBanco,
                             ALinkRequisicao,
                             ANomeCertificado,
                             AChaveAccess,
                             AClientID,
                             AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;

end;

class function TRequisicoesPixLib.SolicitarDevolucao(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, ACorpoRequisicao, AToken, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    SolicitarDevolucao: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, ACorpoRequisicao, AToken, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    SolicitarDevolucao := GetProcAddress(LHandleRequisicoesPix, 'SolicitarDevolucao');
    Result := SolicitarDevolucao(ACodigoBanco,
                                 ALinkRequisicao,
                                 ANomeCertificado,
                                 ACorpoRequisicao,
                                 AToken,
                                 AClientID,
                                 AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If Not MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := TFuncoesPix.GeraJsonErro(ACodigoBanco,
                                         'Ocorreu um erro ao solicitar a devolução.' + #13 +
                                           'Código: ' + LJsonObject.GetValue<String>('codigo') + ' - ' + LJsonObject.GetValue<String>('resultado'),
                                         '');
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.SolicitarDevolucaoShipay(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, ACorpoRequisicao, AToken, AClientID,
  AClientSecret: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    SolicitarDevolucaoShipay: function(ACodigoBanco, ALinkRequisicao, ANomeCertificado, ACorpoRequisicao, AToken, AClientID, AClientSecret: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  Try
    SolicitarDevolucaoShipay := GetProcAddress(LHandleRequisicoesPix, 'SolicitarDevolucaoShipay');
    Result := SolicitarDevolucaoShipay(ACodigoBanco,
                                       ALinkRequisicao,
                                       ANomeCertificado,
                                       ACorpoRequisicao,
                                       AToken,
                                       AClientID,
                                       AClientSecret);

    LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

    If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
      Result := LJsonObject.GetValue('resultado').ToString;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;
end;

class function TRequisicoesPixLib.SolicitarDevolucaoSynalist(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, ACorpoRequisicao, AToken, AClientID,
  AClientSecret, ACertificadoCRT, ACertificadoKey,
  ASenhaCertificado: String): String;
  Var
    LHandleRequisicoesPix: THandle;

    LCaminhoDll: String;

    LJsonObject: TJsonObject;

    FExisteRotinaSynalist: Boolean;

    SolicitarDevolucaoSynalist: function(ACodigoBanco, ALinkRequisicao, ACorpoRequisicao, AToken, AClientID, AClientSecret, ACertificadoCRT, ACertificadoKey, ASenhaCertificado: String): String; StdCall;
begin
  LCaminhoDll := '.\libRequisicoesPix.dll';

  If Not FileExists(LCaminhoDll) Then
    Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

  LHandleRequisicoesPix := LoadLibrary(PChar(LCaminhoDll));

  FExisteRotinaSynalist := True;

  Try
    SolicitarDevolucaoSynalist := GetProcAddress(LHandleRequisicoesPix, 'SolicitarDevolucaoSynalist');

    Try
      Result := SolicitarDevolucaoSynalist(ACodigoBanco,
                                           ALinkRequisicao,
                                           ACorpoRequisicao,
                                           AToken,
                                           AClientID,
                                           AClientSecret,
                                           ACertificadoCRT,
                                           ACertificadoKey,
                                           ASenhaCertificado);

      LJsonObject := TJSONObject.ParseJSONValue(Result) as TJSONObject;

      If MatchStr(LJsonObject.GetValue<String>('codigo'), ['200', '201']) Then
        Result := LJsonObject.GetValue('resultado').ToString;
    Except
      FExisteRotinaSynalist := False;
    End;
  Finally
    LHandleRequisicoesPix := 0;

    FreeLibrary(LHandleRequisicoesPix);
  End;

  If Not FExisteRotinaSynalist Then
    Result := Self.SolicitarDevolucao(ACodigoBanco,
                                      ALinkRequisicao,
                                      ANomeCertificado,
                                      ACorpoRequisicao,
                                      AToken,
                                      AClientID,
                                      AClientSecret);
end;

class function TRequisicoesPixLib.SolicitarDevolucaoTefScope(
  const AControle: String; const ADadosRequest: String;
  const AOperador: String): String;
var
  LRetorno: TRetornoTransacaoPixTef;
  LobjRoot: TJSONObject;
  LValorOriginal: String;
  LValor: Double;
  LValue: TJSONValue;
begin
  Result := EmptyStr;
  if not Assigned(objBridgeTef) then
    Exit;
  LValor := 0.00;
  LValue := TJSONObject.ParseJSONValue(ADadosRequest);
  try
    if not (LValue is TJSONObject) then
      raise Exception.Create('JSON inválido em [SolicitarDevolucaoTefScope]');

    LobjRoot := TJSONObject(LValue);
    if not Assigned(LobjRoot) then
      raise Exception.Create('JSON inválido em [SolicitarDevolucaoTefScope]');

    if not LobjRoot.TryGetValue<String>('valor', LValorOriginal) then
      LValorOriginal := '0';
    LValor := fJsonStrToFloat(LValorOriginal);
  finally
    FreeAndNil(LValue);
  end;

  if objBridgeTef.fCancelarTransacaoPix(LValor,
                                        AnsiString(AControle),
                                        AnsiString(AOperador),
                                        LRetorno
                                        ) then
  begin
    Result := String(LRetorno.JsonResponseDevolucaoPix);
  end;
end;

end.
