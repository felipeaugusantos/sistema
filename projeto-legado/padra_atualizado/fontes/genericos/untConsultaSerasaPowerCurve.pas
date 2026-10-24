unit untConsultaSerasaPowerCurve;

interface

Uses SysUtils,REST.Types, REST.Client,System.JSON,untFuncoesSimples,
     System.Classes,Vcl.Forms,untGravando,IdURI,IdHTTP,IdSSLOpenSSL,IdComponent,
     untDigValor,Vcl.Controls,Uni,untFuncoesGenerica,UniClientDataSet,
     untRelatorioSerasaPowerCurve,StrUtils;


Type
  TDadosToken = Record
  private
    FAccessToken : String;
    FException : String;
    function GetAccessToken: String;
  Public
    Property AccessToken : String  Read GetAccessToken  Write FAccessToken;
  end;

Type
  TDadosConsulta = Record
  private
    FDocumento: String;
    FDataNascimento: String;
    FLimiteSolicitado: Double;
    FPessoaFisica:Boolean;
  end;

Type
  TConsultaSerasaPowerCurve = class
  Private
    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;

    FNovaProposta: TUniClientDataSet;
    FRelatorioSerasaPowerCurve : TfrmRelatorioSerasaPowerCurve;

    FDadosToken : TDadosToken;
    FUrlToken: String;
    FUrlNovaProposta:String;
    FUsuario: String;
    FSenha: String;
    FHomologacao: Boolean;
    FAmbiente: String;
    FDadosConsulta : TDadosConsulta;
    FException: String;
    procedure DefinirUrl;
    procedure GerarToken;
    function RetornaDomain:String;
    function RetornaRequisicaoToken:String;
    function RetornaRequisicaoNovaPropostaPessoaJuridica: String;
    function RetornaRequisicaoNovaPropostaPessoaFisica: String;
    procedure CriarComponentesRequisicao;
    procedure OnAfterExecute(Sender: TCustomRESTRequest);
    function VerificaDadosConsulta:Boolean;
    function RetornaLimiteSolicitado:Double;
    procedure ConsultaNovaProposta;
    function MensagemErro(AResponse:String): Boolean;
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function ExtrairJsonObject(AObjeto: TJsonObject;ANomeJson: String): TJsonObject;
    function ExtrairJsonArray(AObjeto: TJsonObject;ANomeJsonArray: String): TJSONArray;
    function RetornaValorArray(AObjeto:TJSONArray):String;
    function RetornaRequisicaoNovaProposta:String;
    function RetornaTemporaria:TUniQuery;
    procedure CarregarTemporaria(AResponse:String);
    function RetornaMensagemDecisao(AJson : TJsonObject):String;
    function RetornaDataFormatada(ADate:String):String;
    function RetornaValorFormatado(AValor:String):String;
    function RetornaQuantidadeAnotacoes(AQuantidade:String):String;
    procedure ExibirRelatorio;
    function RetornaQuantidadeProtesto: Integer;
    function RetornaQuantidadeChequeDevolvido: Integer;
  Public
    Constructor Create; reintroduce;
    Destructor Destroy; override;
    function RealizarConsulta(ADocumento:String; ADataNascimento:String; Var ADecisao: String): Boolean;
    procedure SavePDF(ACaminho:String);

    Property NovaProposta             : TUniClientDataSet Read FNovaProposta;
    Property QuantidadeProtesto       : Integer           Read RetornaQuantidadeProtesto;
    Property QuantidadeChequeDevolvido: Integer           Read RetornaQuantidadeChequeDevolvido;
  End;

implementation

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  If Not fEmptyStr(Self.FException) Then Raise SysUtils.Exception.Create(Self.FException)
  Else Result := Self.FAccessToken;
end;

{ TConsultaSerasaPowerCurve }

procedure TConsultaSerasaPowerCurve.CarregarTemporaria(AResponse: String);
  Var
    LJsonNovaProposta,
    LJsonObjectValue : TJsonObject;

    LJsonArray,
    LJsonArrayRelatoB49C,
    LJsonArrayAnotacoesFinanceirasPJ: TJSONArray;

    LJsonObjectData,
    LJsonObjectDVRelato: TJsonObject;
begin
  Try
    FNovaProposta := fCriaClientDatset(RetornaTemporaria);
    LJsonNovaProposta :=  TJSONObject.ParseJSONValue(AResponse) As TJSONObject;

    FNovaProposta.Insert;

    LJsonObjectData        := ExtrairJsonObject(LJsonNovaProposta,'data');
    LJsonObjectDVRelato    := ExtrairJsonObject(LJsonObjectData,'DV-Relato');
    LJsonArrayRelatoB49C   := ExtrairJsonArray(LJsonObjectDVRelato,'RelatoB49C');

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayRelatoB49C)) As TJSONObject;
    LJsonArrayAnotacoesFinanceirasPJ    := ExtrairJsonArray(LJsonObjectValue,'AnotacoesFinanceirasPJ');

    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'InformacoesPessoais');
    FNovaProposta.FieldByName('EMPRESA_LOGADA').AsString           := Concat(VS_strCodEmp,' - ',fRetNomeEmpresaSelec(VS_strCodEmp));
    FNovaProposta.FieldByName('RAZAO_SOCIAL').AsString             := RetornaValorJson(LJsonObjectValue,'RazaoSocial');
    FNovaProposta.FieldByName('CNPJ_CPF').AsString                 := fFormataCpfCgc(FDadosConsulta.FDocumento,fSetaPais);
    FNovaProposta.FieldByName('DATA_NASCIMENTO_FUNDACAO').AsString := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataFundacao'));

    LJsonArray := ExtrairJsonArray(LJsonObjectValue,'Enderecos');
    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArray)) As TJSONObject;
    FNovaProposta.FieldByName('CIDADE').AsString  := RetornaValorJson(LJsonObjectValue,'Cidade') ;
    FNovaProposta.FieldByName('ESTADO').AsString  := RetornaValorJson(LJsonObjectValue,'UF');

    LJsonObjectValue := ExtrairJsonObject(LJsonObjectData,'DV-RFInternal');
    LJsonArray := ExtrairJsonArray(LJsonObjectValue,'RFInternal');
    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArray)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'IC28_100');
    FNovaProposta.FieldByName('DATA_SITUACAO').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'Data Situacao'));
    FNovaProposta.FieldByName('SITUACAO_CNPJ_CPF').AsString  := RetornaValorJson(LJsonObjectValue,'Situacao');

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Pefin');
    FNovaProposta.FieldByName('QUANTIDADE_PEFIN').AsString   := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalPefin'));
    FNovaProposta.FieldByName('VALOR_TOTAL_PEFIN').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalPefin'));
    FNovaProposta.FieldByName('DATA_ULTIMO_PEFIN').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorrenciaPefin'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Refin');
    FNovaProposta.FieldByName('QUANTIDADE_REFIN').AsString   := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalRefin'));
    FNovaProposta.FieldByName('VALOR_TOTAL_REFIN').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalRefin'));
    FNovaProposta.FieldByName('DATA_ULTIMO_REFIN').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorrenciaRefin'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Protesto');
    FNovaProposta.FieldByName('QUANTIDADE_PROTESTO').AsString   := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalProtesto'));
    FNovaProposta.FieldByName('VALOR_TOTAL_PROTESTO').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalProtesto'));
    FNovaProposta.FieldByName('DATA_ULTIMO_PROTESTO').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorrenciaProtesto'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'DividaVencida');
    FNovaProposta.FieldByName('QUANTIDADE_DIVIDAS_VENCIDAS').AsString   := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalDividasVencidas'));
    FNovaProposta.FieldByName('VALOR_TOTAL_DIVIDAS_VENCIDAS').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalDividasVencidas'));
    FNovaProposta.FieldByName('DATA_ULTIMA_DIVIDA_VENCIDA').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorrenciaDividasVencidas'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Falencia');
    FNovaProposta.FieldByName('QUANTIDADE_FALENCIA_JUDICIAL').AsString    := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalFalencia'));
    FNovaProposta.FieldByName('VALOR_TOTAL_FALENCIA_JUDICIAL').AsString   := '';
    FNovaProposta.FieldByName('DATA_ULTIMA_FALENCIA_JUDICIAL').AsString   := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorFalencia'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Acao');
    FNovaProposta.FieldByName('QUANTIDADE_ACAO_JUDICIAL').AsString    := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalAcao'));
    FNovaProposta.FieldByName('VALOR_TOTAL_ACAO_JUDICIAL').AsString   := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalAcao'));
    FNovaProposta.FieldByName('DATA_ULTIMA_ACAO_JUDICIAL').AsString   := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaAcao'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'ChequeSemFundos');
    FNovaProposta.FieldByName('QUANTIDADE_CHEQUE_SEM_FUNDO').AsString    := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeCCF'));
    FNovaProposta.FieldByName('VALOR_TOTAL_CHEQUE_SEM_FUNDO').AsString   := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalCCF'));
    FNovaProposta.FieldByName('DATA_ULTIMO_CHEQUE_SEM_FUNDO').AsString   := RetornaDataFormatada(Concat(RetornaValorJson(LJsonObjectValue,'AnoFinal'),RetornaValorJson(LJsonObjectValue,'MesFinal')));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'ChequeSustado');
    FNovaProposta.FieldByName('QUANTIDADE_CHEQUE_SUSTADO_CANCELADO').AsString    := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalChequeSustado'));
    FNovaProposta.FieldByName('VALOR_TOTAL_CHEQUE_SUSTADO_CANCELADO').AsString   := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalSustadoCancelado'));
    FNovaProposta.FieldByName('DATA_ULTIMO_CHEQUE_SUSTADO_CANCELADO').AsString   := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorrenciaChequeSustado'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'FalenciasConcordatas');
    FNovaProposta.FieldByName('QUANTIDADE_FALENCIA_CONCORDATA').AsString    := RetornaQuantidadeAnotacoes(RetornaValorJson(LJsonObjectValue,'QuantidadeTotalFalenciasConcordatas'));
    FNovaProposta.FieldByName('VALOR_TOTAL_FALENCIA_CONCORDATA').AsString   := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorTotalSustadoFalenciasConcordatas'));
    FNovaProposta.FieldByName('DATA_ULTIMA_FALENCIA_CONCORDATA').AsString   := RetornaDataFormatada(RetornaValorJson(LJsonObjectValue,'DataUltimaOcorrenciaFalenciasConcordatas'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayRelatoB49C)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Modelos');
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'Score');

    FNovaProposta.FieldByName('SCORE_SERASA').AsString   := RetornaValorJson(LJsonObjectValue,'scoreSerasa');
    FNovaProposta.FieldByName('PRINAD_SERASA').AsString  := RetornaValorJson(LJsonObjectValue,'Prinad6m');
    FNovaProposta.FieldByName('MODELO_SERASA').AsString  := RetornaValorJson(LJsonObjectValue,'modelo');

    LJsonObjectValue := ExtrairJsonObject(LJsonObjectData,'DV-Results');
    LJsonArray := ExtrairJsonArray(LJsonObjectValue,'MergedResults');
    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArray)) As TJSONObject;

    FNovaProposta.FieldByName('MENSAGEM_DECISAO').AsString := RetornaMensagemDecisao(LJsonObjectValue);

    LJsonObjectValue := ExtrairJsonObject(LJsonObjectData,'DV-Application');
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'ProdutoSolicitado');
    FNovaProposta.FieldByName('VALOR_SOLICITADO').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorEmprestimoSolicitado'));

    LJsonObjectValue := ExtrairJsonObject(LJsonObjectData,'DV-Application');
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'ApplicationResults');
    FNovaProposta.FieldByName('VALOR_SUGERIDO').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'ValorCreditoRecomendado'));

    LJsonObjectValue := TJSONObject.ParseJSONValue(RetornaValorArray(LJsonArrayAnotacoesFinanceirasPJ)) As TJSONObject;
    LJsonObjectValue := ExtrairJsonObject(LJsonObjectValue,'RendaPresumida');
    FNovaProposta.FieldByName('FATURAMENTO').AsString  := RetornaValorFormatado(RetornaValorJson(LJsonObjectValue,'FaturamentoPresumido'));

    FNovaProposta.Post;

    ExibirRelatorio;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TConsultaSerasaPowerCurve.ConsultaNovaProposta;
begin

  Try
    FRestRequest.Params.Clear;
    FRestRequest.AddAuthParameter('Authorization','Bearer ' + FDadosToken.AccessToken,pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.Params.AddHeader('X-Screenless-Kill-Null', 'true');


    FRestRequest.Method := rmPOST;
    FRestRequest.Params.AddItem('body',
                                RetornaRequisicaoNovaProposta,
                                pkREQUESTBODY,
                                [poDoNotEncode],
                                ctAPPLICATION_JSON);

    FRestClient.BaseURL := FUrlNovaProposta;
    FRestRequest.Execute;

    If FRestResponse.StatusCode <> 200 Then
    Begin
      FException :=  'Status: ' + FRestResponse.StatusCode.ToString + ' Erro: ' + FRestResponse.Content;
      Exit;
    End;

    If MensagemErro(FRestResponse.Content) Then
      Exit;

    CarregarTemporaria(FRestResponse.Content);
  Except
    On E:Exception Do
    Begin
      FException := E.Message;
    End;
  End;
end;

constructor TConsultaSerasaPowerCurve.Create;
begin
  FHomologacao := fCfgSis('HOMPCC', varBoolean);
  FUsuario     := fCfgSis('USUPCC');
  FSenha       := fCfgSis('SENPCC');
  FAmbiente    := IIF(FHomologacao,'Homologação','Produção');
  DefinirUrl;
  CriarComponentesRequisicao;
  FException := '';
end;

procedure TConsultaSerasaPowerCurve.CriarComponentesRequisicao;
begin
  FRestClient := TRESTClient.Create(Nil);
  FRestClient.Accept              := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset       := 'UTF-8, *;q=0.8';
  FRestClient.ContentType         := 'application/json';
  FRestClient.HandleRedirects     := True;
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.Params.Clear;

  FRestResponse := TRESTResponse.Create(Nil);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(Nil);
  FRestRequest.Timeout            := 3600000;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Client             := FRestClient;
  FRestRequest.Response           := FRestResponse;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.OnAfterExecute     := OnAfterExecute;

  FRestRequest.Params.AddHeader('X-User-Domain',RetornaDomain);
  FRestRequest.Params.AddHeader('Username', FUsuario);
  FRestRequest.Params.AddHeader('X-Correlation-Id', 'bbcf5868-4440-4e2c-89f8-f9eb84ec83aa');
end;

procedure TConsultaSerasaPowerCurve.DefinirUrl;
begin
  FUrlToken := TIdURI.URLEncode(fCfgSis('PCCTKN'));
  FUrlNovaProposta := TIdURI.URLEncode(fCfgSis('PCCNVP'));
end;

destructor TConsultaSerasaPowerCurve.Destroy;
begin
  If Assigned(FRestClient) Then
    FreeAndNil(FRestClient);

  If Assigned(FRestRequest) Then
    FreeAndNil(FRestRequest);

  If Assigned(FRestResponse) Then
    FreeAndNil(FRestResponse);

  If Assigned(FNovaProposta) Then
    FreeAndNil(FNovaProposta);

  If Assigned(FRelatorioSerasaPowerCurve) Then
    FreeAndNil(FRelatorioSerasaPowerCurve);
  inherited;
end;

procedure TConsultaSerasaPowerCurve.ExibirRelatorio;
  Var
    LVideo  : Boolean;
    qryCfgRel : TUniQuery;
    strNomImp : String;
    strTipImp : String;
begin

  Try
    LVideo :=  (fMensagem('','Saída',['&Vídeo','&Imprimir']) = 1);
    qryCfgRel := fCriaQuery(Nil);
    strNomImp := '';
    strTipImp := '';

    pCriarFormularios(TfrmRelatorioSerasaPowerCurve, FRelatorioSerasaPowerCurve);
    FRelatorioSerasaPowerCurve.DataSourceNovaProposta.DataSet :=  FNovaProposta;

    If Not LVideo Then
    Begin
      pCarregaConfImpr(qryCfgRel, 'ConsultaSerasaPowerCurve');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strTipImp := 'J';

      If fEmptyStr(strNomImp) Then
        fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

      If VerImpressoraONLINE(strNomImp) <> 0 Then
        strNomImp := ' ';

      If Not fEmptyStr(strNomImp) Then
      Begin
        FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC.PrintOptions.ShowDialog := False;
        FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC.PrintOptions.Printer    := strNomImp;
      End;

    End;

    If FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC.PrepareReport Then
    Begin
      If Not LVideo Then
        pPrintReport('TConsultaSerasaPowerCurve','Consulta Serasa Power Curve', strNomImp, FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC)
      Else
        pPreviewReport('TConsultaSerasaPowerCurve','Consulta Serasa Power Curve', FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC);
    End;

  Finally
    FreeAndNil(qryCfgRel);
  End;
end;

function TConsultaSerasaPowerCurve.ExtrairJsonArray(AObjeto: TJsonObject;
  ANomeJsonArray: String): TJSONArray;
begin
  Result := Nil;
  Try
    Result := AObjeto.GetValue(ANomeJsonArray) as TJsonArray;
  Except
    //
  End;
end;

function TConsultaSerasaPowerCurve.ExtrairJsonObject(AObjeto: TJsonObject;
  ANomeJson: String): TJsonObject;
begin
  Result := Nil;
  Try
    Result := AObjeto.GetValue<TJSONObject>(ANomeJson) as TJSONObject;
  Except
    //
  End;
end;


procedure TConsultaSerasaPowerCurve.GerarToken;
  Var
    LJsonObject :TJsonObject;
begin

  Try
    FRestRequest.Method := rmPOST;
    FRestRequest.Params.AddItem('body',
                                 RetornaRequisicaoToken,
                                 pkREQUESTBODY,
                                 [poDoNotEncode],
                                 ctAPPLICATION_JSON);
    FRestClient.BaseURL := FUrlToken;
    FRestRequest.Execute;

    If FRestResponse.StatusCode <> 200 Then
      Raise Exception.Create('Status: ' + FRestResponse.StatusCode.ToString + ' Erro: ' + FRestResponse.Content);

    LJsonObject := TJSONObject.ParseJSONValue(FRestResponse.Content) as TJSONObject;
    FDadosToken.FAccessToken := LJsonObject.GetValue<string>('access_token');

    FreeAndNil(LJsonObject);
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      FDadosToken.FException := 'Ocorreu um erro ao realizar a autenticação na API do Serasa Power Curve.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 FAmbiente + '.'+' Erro:' + E.ErrorMessage;

    End;

    On E: Exception Do
    Begin
      FDadosToken.FException := 'Ocorreu um erro ao realizar a autenticação na API do Serasa Power Curve.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 FAmbiente + '.' + ' Erro:' + E.Message;
    End;
  End;

end;

function TConsultaSerasaPowerCurve.MensagemErro(AResponse: String): Boolean;
  Var
    LJsonObject: TJsonObject;
    LErro: String;
begin
  Try
    Result := False;

    LJsonObject := TJSONObject.Create;
    LJsonObject := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
    LJsonObject := LJsonObject.GetValue<TJSONObject>('data') as TJSONObject;
    LJsonObject := LJsonObject.GetValue<TJSONObject>('WorkingStorage') as TJSONObject;

    LErro := RetornaValorJson(LJsonObject,'Error Message');
    If Not fEmptyStr(LErro) Then
    Begin
      fMensagem('AVISO',LErro, ['&O K']);
      Result := True;
    End;

  Finally
    FreeAndNil(LJsonObject);
  End;
end;

procedure TConsultaSerasaPowerCurve.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TConsultaSerasaPowerCurve.VerificaDadosConsulta: Boolean;
begin
  Result := True;

  If FDadosConsulta.FPessoaFisica Then
  Begin
    fMensagem('ATENÇÃO!', 'Consulta não disponível para pessoa física!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fEmptyStr(FUsuario) Then
  Begin
    fMensagem('AVISO','Para usar está funcionalidade é necessário configurar o usúario de acesso '+
                      'ao serviço Serasa PowerCurve Crédito na configuração [CFG_USUPCC]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FSenha) Then
  Begin
    fMensagem('AVISO','Para usar está funcionalidade é necessário configurar a senha de acesso '+
                      'ao serviço Serasa PowerCurve Crédito na configuração [CFG_SENPCC]!', ['&O K']);
    Result := False;
  End;

  If (fEmptyStr(fTiraCaracEspeciais(FDadosConsulta.FDataNascimento))) Then
  Begin
   If FDadosConsulta.FPessoaFisica Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de nascimento deve ser informada quando for consulta a pessoa física!', ['&Ok']);
      Result := False;
    End;
  End;

  If fEmptyStr(fTiraCaracEspeciais(FDadosConsulta.FDocumento)) Then
  Begin
    fMensagem('AVISO','Número do documento (CPF/CNPJ) não informado!', ['&O K']);
    Result := False;
  End;

end;


function TConsultaSerasaPowerCurve.RealizarConsulta(ADocumento: String; ADataNascimento: String; var ADecisao: String): Boolean;
begin
  Result := False;

  Try
    FDadosConsulta.FPessoaFisica   := (Length(fTiraCaracEspeciais(ADocumento)) = 11);
    FDadosConsulta.FDocumento      := ADocumento;
    FDadosConsulta.FDataNascimento := ADataNascimento;

    If Not VerificaDadosConsulta Then
      Exit;

    FDadosConsulta.FLimiteSolicitado := RetornaLimiteSolicitado;

    If FDadosConsulta.FLimiteSolicitado = 0 Then
      Exit;

    TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
    TfrmGravando.fExecutarModalA(ConsultaNovaProposta,'Aguarde, Consultando Proposta.', '');

    If Not fEmptyStr(FException) Then
      Raise Exception.Create(FException);


    If Assigned(FNovaProposta) Then
      If FNovaProposta.RecordCount > 0 Then
        Result := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TConsultaSerasaPowerCurve.RetornaDataFormatada(ADate: String): String;
begin
  Result := '';

  If fEmptyStr(ADate) Then
    Exit;


  If (ADate.Length = 6) Then
    Result :=  Concat(Copy(ADate, 5, 2),'/',LeftStr(ADate, 4))
  Else
    Result := Concat(RightStr(ADate, 2),'/',Copy(ADate, 5, 2),'/',LeftStr(ADate, 4));

End;

function TConsultaSerasaPowerCurve.RetornaDomain: String;
begin
  Result := Trim(Copy(FUsuario,(Pos('@',FUsuario) + 1),FUsuario.Length));
end;

function TConsultaSerasaPowerCurve.RetornaRequisicaoNovaPropostaPessoaJuridica: String;
  Var
    LJson: TJsonObject;
    DvApplication: TJsonObject;
    ProdutoSolicitado: TJsonObject;
    DvApplicant: TJsonObject;
    Applicant: TJsonArray;
    ApplicantElement: TJsonObject;
begin
  Try
    DvApplication := TJSONObject.Create;
    DvApplication.AddPair('IDservico','NovaProposta');
    DvApplication.AddPair('Fonte','12345678');

    ProdutoSolicitado := TJSONObject.Create;
    ProdutoSolicitado.AddPair('Produto','EMPR');
    ProdutoSolicitado.AddPair('Subproduto1','Consulta PJ');
    ProdutoSolicitado.AddPair('Subproduto2','Consulta PJ');
    ProdutoSolicitado.AddPair('ValorEmprestimoSolicitado',IntToStr(fFloatToInt(FDadosConsulta.FLimiteSolicitado)));
    DvApplication.AddPair('ProdutoSolicitado',ProdutoSolicitado);

    DvApplicant := TJSONObject.Create;
    Applicant:= TJsonArray.Create;
    ApplicantElement := TJSONObject.Create;
    ApplicantElement.AddPair('CNPJ',FDadosConsulta.FDocumento);
    Applicant.AddElement(ApplicantElement);
    DvApplicant.AddPair('Applicant',Applicant);

    LJson := TJSONObject.Create;
    LJson.AddPair('DV-Application',DvApplication);
    LJson.AddPair('DV-Applicant',DvApplicant);


    Result:= LJson.ToString;

  Finally
    FreeAndNil(LJson);
  End;


end;


function TConsultaSerasaPowerCurve.RetornaRequisicaoNovaProposta: String;
begin
  If FDadosConsulta.FPessoaFisica Then Result := RetornaRequisicaoNovaPropostaPessoaFisica
  Else Result := RetornaRequisicaoNovaPropostaPessoaJuridica;
end;

function TConsultaSerasaPowerCurve.RetornaRequisicaoNovaPropostaPessoaFisica: String;
  Var
    LJson: TJsonObject;
    DvApplication: TJsonObject;
    ProdutoSolicitado: TJsonObject;
    DvApplicant: TJsonObject;
    Applicant: TJsonArray;
    ApplicantElement: TJsonObject;
begin
  Try
    DvApplication := TJSONObject.Create;
    DvApplication.AddPair('IDservico','NovaProposta');
    DvApplication.AddPair('Fonte','12345678');

    ProdutoSolicitado := TJSONObject.Create;
    ProdutoSolicitado.AddPair('Produto','CART');
    ProdutoSolicitado.AddPair('Subproduto1','Consulta PF');
    ProdutoSolicitado.AddPair('Subproduto2','Consulta PF');
    ProdutoSolicitado.AddPair('ValorEmprestimoSolicitado',IntToStr(fFloatToInt(FDadosConsulta.FLimiteSolicitado)));
    DvApplication.AddPair('ProdutoSolicitado',ProdutoSolicitado);

    DvApplicant := TJSONObject.Create;
    Applicant:= TJsonArray.Create;
    ApplicantElement := TJSONObject.Create;
    ApplicantElement.AddPair('CPF',FDadosConsulta.FDocumento);
    ApplicantElement.AddPair('DataNascimento',FormatDateTime('YYYYMMDD',StrToDate(FDadosConsulta.FDataNascimento)));
    Applicant.AddElement(ApplicantElement);
    DvApplicant.AddPair('Applicant',Applicant);

    LJson := TJSONObject.Create;
    LJson.AddPair('DV-Application',DvApplication);
    LJson.AddPair('DV-Applicant',DvApplicant);


    Result:= LJson.ToString;

  Finally
    FreeAndNil(LJson);
  End;


end;

function TConsultaSerasaPowerCurve.RetornaRequisicaoToken: String;
  Var
    LJson: TJsonObject;
begin
  Try
    LJson :=  TJSONObject.Create;

    LJson.AddPair('username',FUsuario);
    LJson.AddPair('password',FSenha);
    LJson.AddPair('client_id','QGsj6vlnsWcGNUCoxv5fNkL2KXmfafhr');
    LJson.AddPair('client_secret','4xf8KE0Pb52hK04y');

    Result:= LJson.ToString;

  Finally
    FreeAndNil(LJson);
  End;
end;


function TConsultaSerasaPowerCurve.RetornaTemporaria: TUniQuery;
  Var
    LSql: String;
begin
  Try

    LSql := 'SELECT '+
            '  *    '+
            'FROM   '+
            '  (SELECT                                                           '+
            '    CAST(" " AS CHAR(200)) AS EMPRESA_LOGADA,                       '+
            '    CAST(" " AS CHAR(200)) AS RAZAO_SOCIAL,                         '+
            '    CAST(" " AS CHAR(20))  AS CNPJ_CPF,                             '+
            '    CAST(" " AS CHAR(20))  AS DATA_NASCIMENTO_FUNDACAO,             '+
            '    CAST(" " AS CHAR(100)) AS CIDADE,                               '+
            '    CAST(" " AS CHAR(10))  AS ESTADO,                               '+
            '    CAST(" " AS CHAR(100)) AS DATA_SITUACAO,                        '+
            '    CAST(" " AS CHAR(100)) AS SITUACAO_CNPJ_CPF,                    '+
            '    CAST(" " AS CHAR(10))  AS SCORE_SERASA,                         '+
            '    CAST(" " AS CHAR(10))  AS MODELO_SERASA,                        '+
            '    CAST(" " AS CHAR(10))  AS PRINAD_SERASA,                        '+
            '    CAST(" " AS CHAR(500)) AS MENSAGEM_DECISAO,                     '+
            '    CAST(" " AS CHAR(15))  AS VALOR_SOLICITADO,                     '+
            '    CAST(" " AS CHAR(15))  AS VALOR_SUGERIDO,                       '+
            '    CAST(" " AS CHAR(15))  AS FATURAMENTO,                          '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_PEFIN,                     '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_PEFIN,                    '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMO_PEFIN,                    '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_REFIN,                     '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_REFIN,                    '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMO_REFIN,                    '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_CHEQUE_SEM_FUNDO,          '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_CHEQUE_SEM_FUNDO,         '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMO_CHEQUE_SEM_FUNDO,         '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_CHEQUE_SUSTADO_CANCELADO,  '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_CHEQUE_SUSTADO_CANCELADO, '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMO_CHEQUE_SUSTADO_CANCELADO, '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_PROTESTO,                  '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_PROTESTO,                 '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMO_PROTESTO,                 '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_FALENCIA_JUDICIAL,         '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_FALENCIA_JUDICIAL,        '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMA_FALENCIA_JUDICIAL,        '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_FALENCIA_CONCORDATA,       '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_FALENCIA_CONCORDATA,      '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMA_FALENCIA_CONCORDATA,      '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_ACAO_JUDICIAL,             '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_ACAO_JUDICIAL,            '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMA_ACAO_JUDICIAL,            '+

            '    CAST(" " AS CHAR(20))  AS QUANTIDADE_DIVIDAS_VENCIDAS,          '+
            '    CAST(" " AS CHAR(15))  AS VALOR_TOTAL_DIVIDAS_VENCIDAS,         '+
            '    CAST(" " AS CHAR(15))  AS DATA_ULTIMA_DIVIDA_VENCIDA            '+

            ') AS TEMPORARIA '+
            'WHERE FALSE ';

    Result := fCriaQuery(Nil);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(LSql);
    Result.Open;

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TConsultaSerasaPowerCurve.RetornaValorArray(
  AObjeto: TJSONArray): String;
  Var
    LJsonValue :TJsonValue;
begin
  Result := '';

  Try
    For LJsonValue In AObjeto Do
    Begin
      Result := LJsonValue.ToString;
      Exit;
    End;
  Except
    //
  End;
end;

function TConsultaSerasaPowerCurve.RetornaValorFormatado(
  AValor: String): String;
begin

  If fEmptyStr(AValor) Then
    Exit;

  Result := AValor.Replace('.',',')
end;

function TConsultaSerasaPowerCurve.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';

  If Not Assigned(AObjeto) Then
    Exit;

  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

procedure TConsultaSerasaPowerCurve.SavePDF(ACaminho: String);
begin
  If Not DirectoryExists(ACaminho) Then
    fCriaDiretorio(ACaminho);

  FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC.ShowProgress := False;
  FRelatorioSerasaPowerCurve.frxPDFExportNovaProposta.FileName     := 'Consulta PowerCurve ' + FormatDateTime('YYYYDDMM', VS_Date) + '.pdf';
  FRelatorioSerasaPowerCurve.frxPDFExportNovaProposta.DefaultPath  := ACaminho;
  FRelatorioSerasaPowerCurve.frxPDFExportNovaProposta.ShowDialog   := False;
  FRelatorioSerasaPowerCurve.frxPDFExportNovaProposta.ShowProgress := False;
  FRelatorioSerasaPowerCurve.frxRelatorioPJConsultaPCC.Export(FRelatorioSerasaPowerCurve.frxPDFExportNovaProposta);
end;

function TConsultaSerasaPowerCurve.RetornaLimiteSolicitado: Double;
  Var
    LFrmDigValor: TfrmDigValor;
begin
  Result := 0;
  Try
    pCriarFormularios(TfrmDigValor, LFrmDigValor);
    LFrmDigValor.Caption := 'Limite de Crédito';
    LFrmDigValor.blnPermiteZero := False;
    LFrmDigValor.blnPermiteMenorZero := False;
    LFrmDigValor.ShowModal;

    If LFrmDigValor.ModalResult <> mrOk Then
      Exit;

    Result := fFormataFloat(fStrToFloat(LFrmDigValor.edtValor.Text), 2);
  Finally
    pFreeAndNil(LFrmDigValor);
  End;

end;

function TConsultaSerasaPowerCurve.RetornaMensagemDecisao(AJson: TJsonObject): String;
  Var
    LJsonObjectValue: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
begin
  Result := '';

  Try
    LJsonObjectValue := ExtrairJsonObject(AJson,'ResultadoDecisao');
    Result := RetornaValorJson(LJsonObjectValue,'MensagemDecisao');

    LJsonArray := ExtrairJsonArray(LJsonObjectValue,'TabelaDecisao');
    For LJsonValue In LJsonArray Do
    Begin
      If Not fEmptyStr(LJsonValue.ToString.Replace('"','')) Then
        Result := Result + #13#10 + LJsonValue.ToString.Replace('"','');
    End;

  Except
    //
  End;

end;

function TConsultaSerasaPowerCurve.RetornaQuantidadeAnotacoes(
  AQuantidade: String): String;
begin
  Result := AQuantidade;
  If fEmptyStr(Result) Then
   Result := 'Nada Consta';
end;

function TConsultaSerasaPowerCurve.RetornaQuantidadeChequeDevolvido: Integer;
  Var
    LValor : String;
begin
  Result := 0;
  LValor := FNovaProposta.FieldByName('QUANTIDADE_CHEQUE_SUSTADO_CANCELADO').AsString;

  If Not LValor.Equals('Nada Consta') Then
    Result := StrToInt(LValor);

  LValor := FNovaProposta.FieldByName('QUANTIDADE_CHEQUE_SEM_FUNDO').AsString;

  If Not LValor.Equals('Nada Consta') Then
    Result := Result + StrToInt(LValor);
end;


function TConsultaSerasaPowerCurve.RetornaQuantidadeProtesto: Integer;
  Var
    LValor : String;
begin
  Result := 0;
  LValor := FNovaProposta.FieldByName('QUANTIDADE_PROTESTO').AsString;

  If Not LValor.Equals('Nada Consta') Then
    Result := StrToInt(LValor);
end;

end.
