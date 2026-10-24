unit untConsultaSCPCBoaVistaSophus;

interface

Uses SysUtils,REST.Types, REST.Client,System.JSON,untFuncoesSimples,
     System.Classes,Vcl.Forms,untGravando,IdURI,IdHTTP,IdSSLOpenSSL,IdComponent,
     Vcl.Controls,Uni,untFuncoesGenerica,UniClientDataSet,StrUtils,Winapi.ShellAPI,
     Winapi.Windows,Vcl.StdCtrls, MSHTML, ActiveX,System.Win.ComObj,Variants, System.NetEncoding,
     HTTPSend, blcksock, synautil;


Type
  TDadosConsulta = Record
  private
    FDocumento: String;
    FPessoaFisica:Boolean;
    FSolicitante: String;
  end;

Type
  TConsultaSCPCBoaVistaSophus = class
  Private
    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;

    FUrlConsulta:String;
    FCodigo: String;
    FSenha: String;
    FEntidade: String;
    FAmbiente: String;

    FUsuario: String;
    FChaveAcesso: String;

    FDadosConsulta : TDadosConsulta;
    FException: String;
    FContentException: String;
    FArquivoHTML: TStringList;
    FFileName:String;
    FConsultaFalhou: Boolean;

    procedure DefinirUrl;
    function VerificaDadosConsulta:Boolean;
    procedure ConsultaNovaProposta;
    function MensagemErro(AResponse:String; ATexto: String = ''): Boolean;
    function RetornaQuantidadeProtesto: Integer;
    function RetornaQuantidadeChequeDevolvido: Integer;
    procedure RemoveElement(AFrames: IHTMLElementCollection; AClassName:String);
    procedure AddOnClickBotaoImprimir(AFrames: IHTMLElementCollection);
    procedure PreparaHTML;
    function RetornaTextoErroTratado(strTexto, AErro: String; out AQtdLinhasMsg: Integer): String;
    function RetornaSolicitacao(): String;
    function JsonString(const AValue: string): string;
    function RetornaBasicAuth : String;
    function RetornaValorString(AValor: String; ATamanho: Integer): String;
    procedure OnHeartBeat(Sender: TObject);
  Public
    Constructor Create; reintroduce;
    Destructor Destroy; override;
    procedure SaveHTML(ACaminho: String);
    function RealizarConsulta(ADocumento, ASolicitante: String): Boolean;
    procedure ExibirRelatorio;

    Property QuantidadeProtesto       : Integer           Read RetornaQuantidadeProtesto;
    Property QuantidadeChequeDevolvido: Integer           Read RetornaQuantidadeChequeDevolvido;
  End;

implementation


{ TConsultaSCPCBoaVistaSophus }

procedure TConsultaSCPCBoaVistaSophus.OnHeartBeat(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TConsultaSCPCBoaVistaSophus.ConsultaNovaProposta;
var
  LHTTPSend: THTTPSend;
  LFDataReq, LFDataResp: TMemoryStream;
  LUrl, strRetorno, LSolicitacao : string;
begin
  FConsultaFalhou := False;

  LHTTPSend := THTTPSend.Create;
  try
    LHTTPSend.Sock.OnHeartbeat := OnHeartBeat;
    try
      LUrl := FUrlConsulta + '/consulta';

      LHTTPSend.Headers.Clear;
      LHTTPSend.Headers.Add('Accept: text/html');
      LHTTPSend.Headers.Add('Authorization: Basic ' + RetornaBasicAuth);

      LHTTPSend.MimeType := 'application/json; charset=utf-8';
      LHTTPSend.Protocol := '1.1';
      LHTTPSend.Sock.SSL.SSLType := LT_all;


      LHTTPSend.Sock.SetTimeout(30000);
      LHTTPSend.Sock.ConnectionTimeout := 30000;
      LHTTPSend.Sock.NonblockSendTimeout := 30000;

      LSolicitacao := RetornaSolicitacao;

      if not LSolicitacao.IsEmpty then
      begin
        LFDataReq := TMemoryStream.Create;
        try
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LSolicitacao)));
          LHTTPSend.Document.LoadFromStream(LFDataReq);
        finally
          LFDataReq.Free;
        end;
      end;

      if LHTTPSend.HTTPMethod('POST', LUrl) then
      begin
        LHTTPSend.Document.Position := 0;

        LFDataResp := TMemoryStream.Create;
        try
          LFDataResp.LoadFromStream(LHTTPSend.Document);
          LFDataResp.Position := 0;

          strRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          if LHTTPSend.ResultCode = 403 then
          begin
            FConsultaFalhou := True;
            FException := 'Não foi possível concluir a requisição, ' +
                          'verifique as suas credenciais e a liberação de IP junto a Sophus. ';
            Exit;
          end;

          if (LHTTPSend.ResultCode <> 200) Then
          begin
            FException := 'Status: ' + IntToStr(LHTTPSend.ResultCode) +
                          ' Erro: ' + strRetorno;
            FContentException := strRetorno;
            Exit;
          end;

          if MensagemErro(strRetorno) then
            Exit;

          FArquivoHTML.Add(strRetorno);

        finally
          LFDataResp.Free;
        end;

      end
      else
      begin
        FException := LHTTPSend.Sock.LastErrorDesc;
        raise Exception.Create(FException);
      end;

    except
      on E: Exception do
      begin
        FException := E.Message;
        raise;
      end;
    end;

  finally
    LHTTPSend.Free;
    Application.ProcessMessages;
  end;
end;

function TConsultaSCPCBoaVistaSophus.JsonString(const AValue: string): string;
var
  LJson: TJSONString;
begin
  LJson := TJSONString.Create(AValue);
  try
    Result := LJson.ToString;
  finally
    LJson.Free;
  end;
end;

function TConsultaSCPCBoaVistaSophus.RetornaSolicitacao(): String;
  Var
    LTransacao: String;
begin
  LTransacao := IIF(FDadosConsulta.FPessoaFisica,'353','627');

  If LTransacao = '353' Then
  Begin
    Result := Concat('{' + #13 + #9,
                         '"SPCA-XML":{ '+ #13 + #9 + #9,
                                       '"VERSAO": "14042025",'+ #13 + #9,
                                       '"SOLICITACAO": {' + #13 + #9,
                                                        '"S-REGIONAL":' + JsonString(FEntidade)  +','+ #13 + #9,
                                                        '"S-CODIGO": '  + JsonString(Fcodigo)    +','+ #13 + #9,
                                                        '"S-SENHA": '   + JsonString(FSenha) + ','+ #13 + #9,
                                                        '"S-CONSULTA": '+ LTransacao +','+ #13 + #9,
                                                        '"S-SOLICITANTE": ' + JsonString(RetornaValorString(FDadosConsulta.FSolicitante, 15)) + ','+ #13 + #9,
                                                        '"S-CPF": '     + JsonString(FDadosConsulta.FDocumento) + #13 + #9,
                                                      '}' + #13 + #9,
                                    '}' + #13 + #9,
                     '}');
  End
  Else If LTransacao = '627' Then
  Begin
    Result := Concat('{' + #13 + #9,
                         '"SPCA-XML":{ '+ #13 + #9 + #9,
                                       '"VERSAO": "14042025",'+ #13 + #9,
                                       '"SOLICITACAO": {' + #13 + #9,
                                                        '"S-REGIONAL":' + JsonString(FEntidade)  +','+ #13 + #9,
                                                        '"S-CODIGO": '  + JsonString(Fcodigo)    +','+ #13 + #9,
                                                        '"S-SENHA":  '  + JsonString(FSenha) + ','+ #13 + #9,
                                                        '"S-CONSULTA": '+ LTransacao +','+ #13 + #9,
                                                        '"S-SOLICITANTE": ' + JsonString(RetornaValorString(FDadosConsulta.FSolicitante, 15)) + ','+ #13 + #9,
                                                        '"S-CNPJ": '        + JsonString(FDadosConsulta.FDocumento) + #13 + #9,
                                                      '}' + #13 + #9,
                                    '}' + #13 + #9,
                     '}');
  End;

end;

Function TConsultaSCPCBoaVistaSophus.RetornaBasicAuth : String;
  var
    LobjB64: TBase64Encoding;
    LAuth: String;
begin
  Result := '';
  LobjB64 := TBase64Encoding.Create(0);

  try
    try
      LAuth := LobjB64.Encode(FUsuario +':'+ FChaveAcesso);
      Result := LAuth;
    except
      on E: Exception do
      begin
        raise Exception.Create('Erro ao gerar BasicAuth: ' + E.Message);
      end;
    end;
  finally
    LobjB64.Free;
  end;
end;

function TConsultaSCPCBoaVistaSophus.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);
end;

constructor TConsultaSCPCBoaVistaSophus.Create;
begin
  FCodigo      := fCfgSis('CODSOP');
  FSenha       := fCfgSis('SENSOP');
  FEntidade    := fCfgSis('ENTSOP');
  FUsuario     := fCfgSis('USUSOP');
  FChaveAcesso := fCfgSis('CHVSOP');

  FAmbiente   := 'Produção';
  DefinirUrl;
  FArquivoHTML := TStringList.Create;
  FException := '';
  FContentException := '';
  FConsultaFalhou := False;
end;

procedure TConsultaSCPCBoaVistaSophus.DefinirUrl;
begin
  //URL é a mesma para homologação e produção.
  //O ambiente é validado pelos dados de Usuário e Chave de Acesso.
  FUrlConsulta := TIdURI.URLEncode(fCfgSis('URLSOP'));
end;

destructor TConsultaSCPCBoaVistaSophus.Destroy;
begin
  If Assigned(FRestClient) Then
    FreeAndNil(FRestClient);

  If Assigned(FRestRequest) Then
    FreeAndNil(FRestRequest);

  If Assigned(FRestResponse) Then
    FreeAndNil(FRestResponse);

  If Assigned(FArquivoHTML) Then
    FreeAndNil(FArquivoHTML);

  inherited;
end;

procedure TConsultaSCPCBoaVistaSophus.ExibirRelatorio;
begin

  FFileName := '"' + FFileName + '"';

  If fCfgSis('SOPNAV', varString) = 'C' Then
     ShellExecute(Application.Handle,'open',PChar('chrome.exe'), PChar(FFileName), nil, SW_SHOWMAXIMIZED)
  Else
  If fCfgSis('SOPNAV', varString) = 'F' Then
     ShellExecute(Application.Handle,'open',PChar('firefox.exe'), PChar(FFileName), nil, SW_SHOWMAXIMIZED)
  Else
  If fCfgSis('SOPNAV', varString) = 'E' Then
     ShellExecute(Application.Handle,'open',PChar('msedge.exe'), PChar(FFileName), nil, SW_SHOWMAXIMIZED)
  Else
  If fCfgSis('SOPNAV', varString) = 'P' Then
     ShellExecute(Application.Handle,'open',PChar(FFileName),nil,nil,SW_SHOWMAXIMIZED); //Abre o navegador padrão.
end;

procedure TConsultaSCPCBoaVistaSophus.AddOnClickBotaoImprimir(AFrames: IHTMLElementCollection);
  Const
    ScriptPF: String = '<a id="btnImprimir"                   '+
                       '  class="hide-print botao_imprimir"   '+
                       '  title="Imprimir"                    '+
                       '  onclick="window.print()">           '+
                       '  Imprimir                            '+
                       '</a>                                  ';

    ScriptPJ: String = '<a id="btnImprimir"                   '+
                       '  class="hide-print botao_imprimir"   '+
                       '  title="Imprimir"                    '+
                       '  onclick="window.print()">           '+
                       '  <i class="fa fa-print"></i>         '+
                       '</a>                                  ';
  Var
    Element: IHTMLElement;
    i : integer;
Begin
  for i := 0 to AFrames.length - 1 do
  begin
    Element := AFrames.item(i, 0) as IHTMLElement;

    If Assigned(Element) Then
    Begin
      If (Pos('botao_imprimir',String(Element._className)) > 0)  Then
      Begin
        Element.outerHTML := IIF(FDadosConsulta.FPessoaFisica,ScriptPF,ScriptPJ);
        Break;
      End;
    End;
  end;
End;

Function TConsultaSCPCBoaVistaSophus.MensagemErro(AResponse: String; ATexto: String = ''): Boolean;
var
  LJsonObject, LSPCA, LResposta, LRetorno: TJSONObject;
  LErro: String;
  LStatus, LQtdLinhasMsg: Integer;
  LValue: TJSONValue;
Begin
  Result := False;

  LValue := TJSONObject.ParseJSONValue(AResponse);
  try
    if not (LValue is TJSONObject) then
       Exit;

    LJsonObject := TJSONObject(LValue);

    if not LJsonObject.TryGetValue<TJSONObject>('SPCA-XML', LSPCA) then
       Exit;

    if not Assigned(LSPCA) then
       Exit;

    if not LSPCA.TryGetValue<TJSONObject>('RESPOSTA', LResposta) then
       Exit;

    if not Assigned(LResposta) then
       Exit;

    if not LResposta.TryGetValue<TJSONObject>('RESPOSTA-RETORNO', LRetorno) then
       Exit;

    if not Assigned(LRetorno) then
       Exit;

    if not LRetorno.TryGetValue<Integer>('STATUS-RESPOSTA', LStatus) then
      LStatus := 0;

    if not LRetorno.TryGetValue<string>('MENSAGEM-RESPOSTA', LErro) then
      LErro := '';

    if LStatus <> 0 then
    begin
      LQtdLinhasMsg := -1;
      if Not fEmptyStr(ATexto) then
        LErro := RetornaTextoErroTratado(ATexto + #13, LErro, LQtdLinhasMsg);

      If fEmptyStr(LErro) Then
        LErro := Format('Ocorreu um erro ao realizar a consulta na API SCPC BOA VISTA.'+#13+'Status: %d', [LStatus]);

      fMensagem('AVISO', LErro, ['&O K'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, LQtdLinhasMsg);

      Result := True;
    end;

  finally
    FreeAndNil(LValue);
  end;
End;

function TConsultaSCPCBoaVistaSophus.RetornaTextoErroTratado(strTexto : String; AErro: String; out AQtdLinhasMsg: Integer): String;
begin
  Result := UpperCase(AErro);
  Result := fTiraCaracEspeciais(Result);
  AQtdLinhasMsg := -1;

  If Result.Contains('TRANSACAO 306 NAO CADASTRADA') Then
  Begin
     Result := 'A transação informada não está cadastrada/liberada para sua conta. ' +
               'Verifique junto ao SCPC Boa Vista quais produtos estão habilitados.' + #13 +
               AErro;
  End
  Else
  If Result.Contains('ACESSO DO ASSOCIADO NAO AUTORIZADO') Then
  Begin
     Result := 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
               FAmbiente + '.' + #13 +
               'Acesso do Associado não Autorizado, verifique junto a associação!'
  End
  Else
  If Result.Contains('CODIGO E/OU SENHA INVALIDOS') Then
  Begin
     Result := 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização no ambiente de ' +
               FAmbiente + '.' + #13 +
               'Código e/ou Senha Inválidos, verifique junto a associação!'
  End
  Else
  If Result.Contains('ENDERECO IP BLOQUEADO') Then
  Begin
     Result := 'Endereço IP Bloqueado, verifique junto a associação!';
  End
  Else
  If Result.Contains('ACESSO NAO PERMITIDO PARA ESTE MEIO DE ACESSO') Then
  Begin
     Result := 'Verifique se as chaves de autenticação da conta estão corretas e se estão liberadas para utilização por webservice/integração no ambiente de ' +
               FAmbiente + '.' + #13 + #13 +
               'Acesso não permitido para este meio de acesso, verifique junto a associação!';
     AQtdLinhasMsg := 5;
  End;

  Result := strTexto + Result;

end;

procedure TConsultaSCPCBoaVistaSophus.PreparaHTML;
  Var
    IDoc: IHTMLDocument2;
    Header: TStringList;
    v: Variant;
    ElementCollection: IHTMLElementCollection;
    Frames: IHTMLElementCollection;
    LNameFile:String;
begin
  Try
    Header := TStringList.Create;
    IDoc:= CreateComObject(Class_HTMLDOcument) as IHTMLDocument2;

    Try
      LNameFile :=  IIF(FDadosConsulta.FPessoaFisica,'HeaderAcertaPositivoSCPCSophus.html','HeaderDefineRiscoSCPCSophus.html');
      LNameFile := ExtractFilePath(Application.ExeName)+ LNameFile;

      If Not FileExists(LNameFile) Then
        Exit;

      Header.LoadFromFile(LNameFile,TEncoding.UTF8);

      Header.Text := Header.Text.Replace(
        'https://associado.scpc.inf.br/consultaDefine/font-awesome/css/font-awesome.min.css',
        'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'
      );

      if not Header.Text.ToLower.Contains('font-awesome') then
      begin
        Header.Text := Header.Text.Replace(
          '</head>',
          '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">' + sLineBreak + '</head>'
        );
      end;

      v := VarArrayCreate([0,0],VarVariant);
      v[0]:= FArquivoHTML.Text;

      IDoc.Write(PSafeArray(System.TVarData(v).VArray));
      IDoc.Close;

      While IDoc.readyState <> 'complete' Do
        Application.processMessages;

      ElementCollection := IDoc.body.all as IHTMLElementCollection;
      Frames := ElementCollection.tags('a') as IHTMLElementCollection;

      If Assigned(Frames) then
      begin
        AddOnClickBotaoImprimir(Frames);
        RemoveElement(Frames,'botao_salvar');
        RemoveElement(Frames,'botao_voltar');
      end;

      ElementCollection := IDoc.body.all as IHTMLElementCollection;
      Frames := ElementCollection.tags('footer') as IHTMLElementCollection;

      if Assigned(Frames) then
      begin
        RemoveElement(Frames,'hidden-print');
      end;

      ElementCollection := IDoc.body.all as IHTMLElementCollection;
      Frames := ElementCollection.tags('div') as IHTMLElementCollection;

      if Assigned(Frames) then
      begin
        RemoveElement(Frames,'gerenciamento-carteira');
      end;

      Header.Text := Header.Text.Replace('[BODY]',IDoc.body.outerHTML);
      FArquivoHTML.Text := Header.Text;

    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(Header);
  End;
end;

function TConsultaSCPCBoaVistaSophus.VerificaDadosConsulta: Boolean;
begin
  Result := True;

  If fEmptyStr(FCodigo) Then
  Begin
    fMensagem('AVISO','Para usar esta funcionalidade é necessário configurar o código de acesso '+
                      'a consulta SCPC Boa Vista - Sophus na configuração [CFG_CODSOP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FSenha) Then
  Begin
    fMensagem('AVISO','Para usar esta funcionalidade é necessário configurar a senha de acesso '+
                      'consulta SCPC Boa Vista - Sophus na configuração [CFG_SENSOP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FEntidade) Then
  Begin
    fMensagem('AVISO','Para usar esta funcionalidade é necessário configurar a entidade de acesso '+
                      'a consulta SCPC Boa Vista - Sophus na configuração [CFG_ENTSOP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FUsuario) Then
  Begin
    fMensagem('AVISO','Para usar esta funcionalidade é necessário configurar o usuário de acesso '+
                      'a consulta SCPC Boa Vista - Sophus na configuração [CFG_USUSOP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FChaveAcesso) Then
  Begin
    fMensagem('AVISO','Para usar esta funcionalidade é necessário configurar a Chave de acesso '+
                      'a consulta SCPC Boa Vista - Sophus na configuração [CFG_CHVSOP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FUrlConsulta) Then
  Begin
    fMensagem('AVISO','Para usar esta funcionalidade é necessário configurar a URL de acesso '+
                      'a consulta SCPC Boa Vista - Sophus na configuração [CFG_URLSOP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(fTiraCaracEspeciais(FDadosConsulta.FDocumento)) Then
  Begin
    fMensagem('AVISO','Número do documento (CPF/CNPJ) não informado!', ['&O K']);
    Result := False;
  End;

end;


function TConsultaSCPCBoaVistaSophus.RealizarConsulta(ADocumento, ASolicitante: String): Boolean;
begin
  Result := False;

  FDadosConsulta.FPessoaFisica := (Length(fTiraCaracEspeciais(ADocumento)) = 11);
  FDadosConsulta.FDocumento    := ADocumento;
  FDadosConsulta.FSolicitante  := ASolicitante;

  If Not VerificaDadosConsulta Then
    Exit;

  TfrmGravando.fExecutarModalA(ConsultaNovaProposta,'Aguarde, Realizando Consulta...', '');

  If Not fEmptyStr(FException) Then
  Begin
    If Not fEmptyStr(FContentException) then
    Begin
      If MensagemErro(FContentException,
                      'Ocorreu um erro ao realizar a consulta na API SCPC BOA VISTA.' + #13 ) Then
         Exit;

      If FException.Contains(FContentException) Then
        Raise Exception.CreateFmt('Ocorreu um erro ao realizar a consulta na API SCPC BOA VISTA:'#13'%s.', [FException])
      Else
        Raise Exception.CreateFmt('Ocorreu um erro ao realizar a consulta na API SCPC BOA VISTA:'#13'%s - %s', [FException, FContentException]);

    End
    Else
    begin
      if FConsultaFalhou then
      begin
        fMensagem('AVISO', FException, ['&O K']);
        Exit;
      end
      Else
       Raise Exception.Create(FException);
    end
  End;

  Result := True;
end;

procedure TConsultaSCPCBoaVistaSophus.RemoveElement(AFrames: IHTMLElementCollection; AClassName: String);
  Var
    Element: IHTMLElement;
    Frame: IHTMLDOMNode;
    i : integer;
Begin
  for i := 0 to AFrames.length - 1 do
  begin
    Element := AFrames.item(i, 0) as IHTMLElement;

    If Assigned(Element) Then
    Begin
      If (Pos(AClassName,String(Element._className)) > 0) Then
      Begin
        Frame := Element as IHTMLDOMNode;
        if Frame <> nil then
        begin
          Frame.parentNode.removeChild(Frame);
          Break;
        end;
      End;
    End;
  end;
End;

procedure TConsultaSCPCBoaVistaSophus.SaveHTML(ACaminho: String);
begin
  Try
    If Not DirectoryExists(ACaminho) Then
      fCriaDiretorio(ACaminho);

    TfrmGravando.fExecutarModalA(PreparaHTML,'Aguarde, Preparando relatório...', '');;
    FFileName := ACaminho + '\Consulta SCPC Boa Vista - Sophus ' + FormatDateTime('DDMMYYYY', VS_Date) + '.html';
    FArquivoHTML.SaveToFile(FFileName,TEncoding.UTF8);

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TConsultaSCPCBoaVistaSophus.RetornaQuantidadeChequeDevolvido: Integer;
begin
  Result := 0;
end;


function TConsultaSCPCBoaVistaSophus.RetornaQuantidadeProtesto: Integer;
begin
  Result := 0;
end;

end.
