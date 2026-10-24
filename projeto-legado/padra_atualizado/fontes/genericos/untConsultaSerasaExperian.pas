unit untConsultaSerasaExperian;

// Relatório Avançado PJ Analitico - Dados Cadastrais Avançados, Anotações Negativas, Consultas à Serasa e Dados Analíticos;

interface

Uses SysUtils,REST.Types, REST.Client,System.JSON,untFuncoesSimples,
     System.Classes,Vcl.Forms,untGravando
     ,IdURI,IdHTTP,IdSSLOpenSSL,IdComponent,untDigValor,
     Vcl.Controls,Uni,untFuncoesGenerica,UniClientDataSet,
     untRelatorioSerasaExperian,StrUtils,
     HTTPSend, blcksock, synautil, DateUtils, System.JSON.Types,System.Variants, Data.DB,System.JSON.Readers;

Type
  TDadosToken = Record
  private
    FAccessToken : String;
    FExpiracao: Integer;
    FRefreshTime: TTime;
    FException : String;
    function GetAccessToken: String;
  Public
    Property AccessToken : String  Read GetAccessToken  Write FAccessToken;
  end;

Type
  TDadosConsulta = Record
  private
    FDocumento: String;
    FPessoaFisica:Boolean;
  end;

Type
  TConsultaSerasaExperian = class
  Private

    FcdsConsulta: TUniClientDataSet;
    FcdsScore: TUniClientDataSet;
    FcdsQSAReport: TUniClientDataSet;
    FcdsPartnerCompleteReport_Partners: TUniClientDataSet;
    FcdsDirectorCompleteReport_Directors: TUniClientDataSet;
    FcdsNegativeData_pefin: TUniClientDataSet;
    FcdsNegativeData_refin: TUniClientDataSet;
    FcdsNegativeData_collectionRecords: TUniClientDataSet;
    FcdsNegativeData_check: TUniClientDataSet;
    FcdsNegativeData_notary: TUniClientDataSet;

    FcdsFactsJudgementFilings: TUniClientDataSet;
    FcdsFactsBankrupts: TUniClientDataSet;
    FcdsFactsInquiryCompany: TUniClientDataSet;
    //FcdsInquiryQuantityHistorical: TUniClientDataSet;
    FcdsNegativeSummary: TUniClientDataSet;

    FRelatorioSerasaExperian : TfrmRelatorioSerasaExperian;

    FDadosToken : TDadosToken;
    FUrlToken: String;
    FUrlConsulta:String;
    FUsuario: String;
    FSenha: String;
    FHomologacao: Boolean;
    FAmbiente: String;
    FDadosConsulta : TDadosConsulta;
    FException: String;
    FMensagemErroAmigavel: String;
    procedure DefinirUrl;
    procedure GerarToken;
    function VerificaDadosConsulta:Boolean;
    procedure ConsultaSerasaExperian_PJ;
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function ExtrairJsonObject(AObjeto: TJsonObject;ANomeJson: String): TJsonObject;
    function ExtrairJsonArray(AObjeto: TJsonObject;ANomeJsonArray: String): TJSONArray;
    function RetornaDataFormatada(ADate:String):String;
    procedure ExibirRelatorio;
    function RetornaJsonErro(AComponente: THTTPSend; AErroException: String = ''): String;

    Procedure CriaCds_Consulta();
    Procedure CriaCds_Score();
    Procedure CriaCds_QSAReport();
    Procedure CriaCds_PartnerCompleteReport_Partners();
    Procedure CriaCds_DirectorCompleteReport_Directors();
    procedure CriaCds_NegativeData_pefin;
    procedure CriaCds_NegativeData_refin;
    procedure CriaCds_NegativeData_collectionRecords;
    procedure CriaCds_Facts_JudgementFilings;
    procedure CriaCds_Facts_Bankrupts;
    procedure CriaCds_Facts_InquiryCompany;
    procedure CriaCds_NegativeData_check;
    procedure CriaCds_NegativeData_notary;
    //procedure CriaCds_Facts_InquiryQuantityHistorical;
    procedure CriaCds_NegativeSummary;

    Procedure CriaCds();
    Procedure LoadFromJson(const AJson: string);
    Procedure AddField(cds: TUniClientDataSet; const FieldName, FieldType: string; Size: Integer = 0);
    Procedure CarregaIdentificationReport(JSON: TJSONObject);
    Procedure CarregaScore(JSON: TJSONObject);
    Procedure CarregaReciprocity(JSON: TJSONObject);
    Procedure Carrega_QSAReport(JSON: TJSONObject);
    Procedure Carrega_PartnersList(JSON: TJSONObject);
    Procedure Carrega_DirectorsList(JSON: TJSONObject);
    Procedure Carrega_negativeData_pefin(JSON: TJSONObject);
    Procedure Carrega_negativeData_refin(JSON: TJSONObject);
    Procedure Carrega_negativeData_collectionRecords(JSON: TJSONObject);

    Procedure Carrega_negativeData_check(JSON: TJSONObject);
    Procedure Carrega_negativeData_notary(JSON: TJSONObject);
    Procedure Carrega_facts_judgementFilings(JSON: TJSONObject);
    Procedure Carrega_facts_Bankrupts(JSON: TJSONObject);
    Procedure Carrega_facts_inquiryCompanyResponse(JSON: TJSONObject);

    Procedure Carrega_negativeSummary(JSON: TJSONObject);

    procedure LeRetornoeExibeRelatorio(AResponse: String);

    function RetornaQuantidadeChequeDevolvido: Integer;
    function RetornaQuantidadeProtesto: Integer;
    procedure AtualizaTotalizadores();

  Public
    Constructor Create; reintroduce;
    Destructor Destroy; override;
    function RealizarConsulta(ADocumento:String; Var ADecisao: String): Boolean;
    procedure SavePDF(ACaminho:String);

    Property cdsConsulta              : TUniClientDataSet Read FcdsConsulta;
    Property cdsQSAReport             : TUniClientDataSet Read FcdsQSAReport;
    Property QuantidadeProtesto       : Integer           Read RetornaQuantidadeProtesto;
    Property QuantidadeChequeDevolvido: Integer           Read RetornaQuantidadeChequeDevolvido;
  End;

  const
    C_URL     = 'https://api.serasaexperian.com.br/credit-services/business-information-report/v1/reports?reportName=';
    C_URL_HOM = 'https://uat-api.serasaexperian.com.br/credit-services/business-information-report/v1/reports?reportName=';

    C_URL_OAUTH_PROD = 'https://api.serasaexperian.com.br/security/iam/v1/client-identities/login';
    C_URL_OAUTH_HOM  = 'https://uat-api.serasaexperian.com.br/security/iam/v1/client-identities/login';

implementation

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  If Not fEmptyStr(Self.FException) Then Raise SysUtils.Exception.Create(Self.FException)
  Else Result := Self.FAccessToken;
end;

{ TConsultaSerasaExperian }

Procedure TConsultaSerasaExperian.GerarToken();
  var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta: String;
    LJsonObject: TJSONObject;
begin

  Try
    LHTTPSend := THTTPSend.Create;
    LHTTPSend.MimeType  := 'application/json; charset=utf-8';
    LHTTPSend.Protocol  := '1.1';

    Try
      LHTTPSend.Headers.Add('Authorization: ' + fRetornaChaveBasic(FUsuario, FSenha) );
      LHTTPSend.Headers.Add('Content-Type: application/json' );
      LHTTPSend.Headers.Add('Content-Length: 0');

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      If LHTTPSend.HTTPMethod('POST', FUrlToken) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
          Begin
            Raise Exception.Create(LHTTPSend.ResultCode.ToString + ' - ' +
                                   LResposta);
          End;

          LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
          FDadosToken.FAccessToken := LJsonObject.GetValue<String>('accessToken');
          FDadosToken.FExpiracao   := LJsonObject.GetValue<Integer>('expiresIn');
          FDadosToken.FRefreshTime := IncSecond(fNow, LJsonObject.GetValue<Integer>('expiresIn'));

        Finally
          FreeAndNil(LFDataResp);
        End;

      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;

  Except

     On E: Exception Do
     Begin
        FDadosToken.FException := 'Ocorreu um erro ao realizar a autenticação na API do Serasa Experian.' + #13 +
                                  'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                  FAmbiente + '.' + ' Erro:' + E.Message;
     End;

  End;

end;

procedure TConsultaSerasaExperian.ConsultaSerasaExperian_PJ;
 Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LRelatorioContrato,
    LFeaturesContrato : String;

    LMsgErro,
    LResposta,
    LStrFeaturesContratoParam : String;

    //stlTexto: TStringList;
begin
  LHTTPSend := Nil;
  Try
      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LRelatorioContrato := 'RELATORIO_AVANCADO_PJ_ANALITICO';
      LFeaturesContrato  := 'QSA_AVANCADO,SCORE_POSITIVO';

      LStrFeaturesContratoParam := '&optionalFeatures='+LFeaturesContrato;

      LHTTPSend.Headers.Add('Authorization: Bearer ' + FDadosToken.GetAccessToken );
      LHTTPSend.Headers.Add('Content-Type: application/json' );
      LHTTPSend.Headers.Add('X-Document-Id: ' + FDadosConsulta.FDocumento);
      LHTTPSend.Headers.Add('Content-Length: 0');

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      Try

        If LHTTPSend.HTTPMethod('GET', (FUrlConsulta + LRelatorioContrato + LStrFeaturesContratoParam) ) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            If Not MatchStr(LHTTPSend.ResultCode.ToString, ['200', '201']) Then
            Begin
              FException := LHTTPSend.ResultCode.ToString + ' - ' + LResposta;
              Raise Exception.Create(LHTTPSend.ResultCode.ToString + ' - ' + LResposta);
            End;

           {stlTexto := TStringList.Create;
            stlTexto.LoadFromFile('C:\Users\tiago.ferreira\Documents\autpas\Arquivos Bancos\serasa\Json_Relato.json');
            LResposta := stlTexto.Text;}

            LeRetornoeExibeRelatorio(LResposta);

          Finally
            If Assigned(LFDataResp) Then
               FreeAndNil(LFDataResp);
          End;

        End;

      Except
        On E: Exception Do
        Begin
          LMsgErro := RetornaJsonErro(LHTTPSend, E.Message);

          If (LHTTPSend.ResultCode = 412) And (LMsgErro.ToUpper.Contains('[USER-NOT-AUTHORIZED]')) Then
          Begin
            FMensagemErroAmigavel := 'As credenciais configuradas não possuem acesso ao: ' + #13 +
                                 LRelatorioContrato + ',' + #13 +
                                 LFeaturesContrato  + #13#13 +
                                 'Verifique os acessos acima junto ao serviço Serasa Experian.';
          End
          Else
          Begin
            Raise Exception.Create(LMsgErro);
          End;
        End
      End;

  Finally
    FreeAndNil(LHTTPSend);
    Application.ProcessMessages;
  End;

end;

constructor TConsultaSerasaExperian.Create;
begin
  FHomologacao := fCfgSis('HOMEXP', varBoolean);
  FUsuario     := fCfgSis('CIDEXP');
  FSenha       := fCfgSis('CSCEXP');
  FAmbiente    := IIF(FHomologacao,'Homologação','Produção');
  DefinirUrl;
  FException := '';
  FMensagemErroAmigavel := '';
end;

procedure TConsultaSerasaExperian.DefinirUrl;
begin
  FUrlToken    := IIF(FHomologacao,C_URL_OAUTH_HOM,C_URL_OAUTH_PROD);
  FUrlConsulta := IIF(FHomologacao,C_URL_HOM,C_URL);
end;

destructor TConsultaSerasaExperian.Destroy;
begin

  If Assigned(FcdsConsulta) Then FreeAndNil(FcdsConsulta);
  If Assigned(FcdsScore)    Then FreeAndNil(FcdsScore);
  If Assigned(FcdsNegativeData_pefin) Then FreeAndNil(FcdsNegativeData_pefin);
  If Assigned(FcdsNegativeData_refin) Then FreeAndNil(FcdsNegativeData_refin);
  If Assigned(FcdsNegativeData_collectionRecords) Then FreeAndNil(FcdsNegativeData_collectionRecords);
  If Assigned(FcdsNegativeData_check) Then FreeAndNil(FcdsNegativeData_check);
  If Assigned(FcdsNegativeData_notary) Then FreeAndNil(FcdsNegativeData_notary);
  If Assigned(FcdsFactsJudgementFilings) Then FreeAndNil(FcdsFactsJudgementFilings);
  If Assigned(FcdsFactsBankrupts) Then FreeAndNil(FcdsFactsBankrupts);
  If Assigned(FcdsFactsInquiryCompany) Then FreeAndNil(FcdsFactsInquiryCompany);
  If Assigned(FcdsQSAReport) Then FreeAndNil(FcdsQSAReport);
  If Assigned(FcdsPartnerCompleteReport_Partners) Then FreeAndNil(FcdsPartnerCompleteReport_Partners);
  If Assigned(FcdsDirectorCompleteReport_Directors) Then FreeAndNil(FcdsDirectorCompleteReport_Directors);
  If Assigned(FcdsNegativeSummary) Then FreeAndNil(FcdsNegativeSummary);

  inherited;
end;

procedure TConsultaSerasaExperian.ExibirRelatorio;
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

    pCriarFormularios(TfrmRelatorioSerasaExperian, FRelatorioSerasaExperian);

    FRelatorioSerasaExperian.DataSource_identificationReport.DataSet           := FcdsConsulta;
    FRelatorioSerasaExperian.DataSource_Score.DataSet                          := FcdsScore;
    FRelatorioSerasaExperian.DataSource_Negativedata_pefin.DataSet             := FcdsNegativeData_pefin;
    FRelatorioSerasaExperian.DataSource_Negativedata_refin.DataSet             := FcdsNegativeData_refin;
    FRelatorioSerasaExperian.DataSource_collectionRecords.DataSet              := FcdsNegativeData_collectionRecords;
    FRelatorioSerasaExperian.DataSource_check.DataSet                          := FcdsNegativeData_check;
    FRelatorioSerasaExperian.DataSource_notary.DataSet                         := FcdsNegativeData_notary;
    FRelatorioSerasaExperian.DataSource_judgementFilings.DataSet               := FcdsFactsJudgementFilings;
    FRelatorioSerasaExperian.DataSource_Bankrupts.DataSet                      := FcdsFactsBankrupts;
    FRelatorioSerasaExperian.DataSource_inquiryCompanyResponse.DataSet         := FcdsFactsInquiryCompany;
    FRelatorioSerasaExperian.DataSource_QSAReport.DataSet                      := FcdsQSAReport;
    FRelatorioSerasaExperian.DataSource_PartnerCompleteReport_Partners.DataSet := FcdsPartnerCompleteReport_Partners;
    FRelatorioSerasaExperian.DataSource_DirectorCompleteReport_Directors.DataSet := FcdsDirectorCompleteReport_Directors;
    FRelatorioSerasaExperian.DataSource_NegativeSummary.DataSet                := FcdsNegativeSummary;

    If Not LVideo Then
    Begin
      pCarregaConfImpr(qryCfgRel, 'ConsultaSerasaExperian');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strTipImp := 'J';

      If fEmptyStr(strNomImp) Then
         fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

      If VerImpressoraONLINE(strNomImp) <> 0 Then
         strNomImp := ' ';

      If Not fEmptyStr(strNomImp) Then
      Begin
        FRelatorioSerasaExperian.frxRelatorioPJConsulta.PrintOptions.ShowDialog := False;
        FRelatorioSerasaExperian.frxRelatorioPJConsulta.PrintOptions.Printer    := strNomImp;
      End;

    End;

    If FRelatorioSerasaExperian.frxRelatorioPJConsulta.PrepareReport Then
    Begin
      If Not LVideo Then
         pPrintReport('TConsultaSerasaExperian','Consulta Serasa Experian', strNomImp, FRelatorioSerasaExperian.frxRelatorioPJConsulta)
      Else
         pPreviewReport('TConsultaSerasaExperian','Consulta Serasa Experian', FRelatorioSerasaExperian.frxRelatorioPJConsulta);
         //FRelatorioSerasaExperian.frxRelatorioPJConsulta.DesignReport(True);
    End;

  Finally
    FreeAndNil(qryCfgRel);
  End;
end;

function TConsultaSerasaExperian.ExtrairJsonArray(AObjeto: TJsonObject;
  ANomeJsonArray: String): TJSONArray;
begin
  Result := Nil;
  Try
    Result := AObjeto.GetValue(ANomeJsonArray) as TJsonArray;
  Except
    //
  End;
end;

function TConsultaSerasaExperian.ExtrairJsonObject(AObjeto: TJsonObject;
  ANomeJson: String): TJsonObject;
begin
  Result := Nil;
  Try
    Result := AObjeto.GetValue<TJSONObject>(ANomeJson) as TJSONObject;
  Except
    //
  End;
end;

function TConsultaSerasaExperian.VerificaDadosConsulta: Boolean;
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
                      'ao serviço Serasa Experian na configuração [CFG_CIDEXP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(FSenha) Then
  Begin
    fMensagem('AVISO','Para usar está funcionalidade é necessário configurar a senha de acesso '+
                      'ao serviço Serasa Experian na configuração [CFG_CSCEXP]!', ['&O K']);
    Result := False;
  End;

  If fEmptyStr(fTiraCaracEspeciais(FDadosConsulta.FDocumento)) Then
  Begin
    fMensagem('AVISO','Número do documento (CPF/CNPJ) não informado!', ['&O K']);
    Result := False;
  End;

end;


function TConsultaSerasaExperian.RealizarConsulta(ADocumento: String; var ADecisao: String): Boolean;
begin
  Result := False;
  FMensagemErroAmigavel := '';
  FException := '';

  FDadosConsulta.FPessoaFisica   := (Length(fTiraCaracEspeciais(ADocumento)) = 11);
  FDadosConsulta.FDocumento      := ADocumento;

  If Not VerificaDadosConsulta Then
    Exit;

  TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
  TfrmGravando.fExecutarModalA(ConsultaSerasaExperian_PJ,'Aguarde, Consultando...', '');

  If Not fEmptyStr(FMensagemErroAmigavel) Then
  Begin
    fMensagem('ATENÇÃO!', FMensagemErroAmigavel, ['&Ok']);
    Exit;
  End;

  If Not fEmptyStr(FException) Then
    Raise Exception.Create(FException);

  If Assigned(FcdsConsulta) Then
     If FcdsConsulta.RecordCount > 0 Then
        Result := True;
end;

function TConsultaSerasaExperian.RetornaDataFormatada(ADate: String): String;
begin
  Result := '';

  If fEmptyStr(ADate) Then
    Exit;


  If (ADate.Length = 6) Then
    Result :=  Concat(Copy(ADate, 5, 2),'/',LeftStr(ADate, 4))
  Else
    Result := Concat(RightStr(ADate, 2),'/',Copy(ADate, 6, 2),'/',LeftStr(ADate, 4));

End;

function TConsultaSerasaExperian.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';

  If Not Assigned(AObjeto) Then
    Exit;

  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

procedure TConsultaSerasaExperian.SavePDF(ACaminho: String);
begin
  If Not DirectoryExists(ACaminho) Then
     fCriaDiretorio(ACaminho);

  FRelatorioSerasaExperian.frxRelatorioPJConsulta.ShowProgress := False;
  FRelatorioSerasaExperian.frxPDFExportConsulta.FileName     := 'Consulta Serasa Experian ' + FormatDateTime('YYYYDDMM', VS_Date) + '.pdf';
  FRelatorioSerasaExperian.frxPDFExportConsulta.DefaultPath  := ACaminho;
  FRelatorioSerasaExperian.frxPDFExportConsulta.ShowDialog   := False;
  FRelatorioSerasaExperian.frxPDFExportConsulta.ShowProgress := False;
  FRelatorioSerasaExperian.frxRelatorioPJConsulta.Export(FRelatorioSerasaExperian.frxPDFExportConsulta);
end;

function TConsultaSerasaExperian.RetornaJsonErro(AComponente: THTTPSend;
  AErroException: String = ''): String;
  Var
    LErroString: String;

    LFDataResp: TMemoryStream;
begin
  Result := AComponente.Sock.GetErrorDescEx + '-' + AComponente.Sock.LastErrorDesc;
  LFDataResp := TMemoryStream.Create;

  Try
    If AComponente.Document <> Nil Then
    Begin
      AComponente.Document.Position := 0;

      LFDataResp.LoadFromStream(AComponente.Document);

      LFDataResp.Position := 0;
      LErroString := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
      FException := LErroString;
      If Not LErroString.Trim.IsEmpty Then
        Result := LErroString;
    End;

    If Not AErroException.IsEmpty Then
    Begin
      If Not Result.Equals(AErroException) Then
        Result := Result + ' - ' + AErroException;
    End;
  Finally
    FreeAndNil(LFDataResp);
  End;
end;

Procedure TConsultaSerasaExperian.CriaCds();
Begin
   FcdsConsulta  := TUniClientDataSet.Create(nil);
   FcdsScore     := TUniClientDataSet.Create(nil);
   FcdsQSAReport := TUniClientDataSet.Create(nil);
   FcdsPartnerCompleteReport_Partners   := TUniClientDataSet.Create(nil);
   FcdsDirectorCompleteReport_Directors := TUniClientDataSet.Create(nil);
   FcdsNegativeData_pefin := TUniClientDataSet.Create(nil);
   FcdsNegativeData_refin := TUniClientDataSet.Create(nil);
   FcdsNegativeData_collectionRecords := TUniClientDataSet.Create(nil);
   FcdsNegativeData_check    := TUniClientDataSet.Create(nil);
   FcdsNegativeData_notary   := TUniClientDataSet.Create(nil);
   FcdsFactsJudgementFilings := TUniClientDataSet.Create(nil);
   FcdsFactsBankrupts        := TUniClientDataSet.Create(nil);
   FcdsFactsInquiryCompany   := TUniClientDataSet.Create(nil);
   //FcdsInquiryQuantityHistorical := TUniClientDataSet.Create(nil);
   FcdsNegativeSummary       := TUniClientDataSet.Create(nil);

   CriaCds_Consulta;
   CriaCds_Score;
   CriaCds_QSAReport;
   CriaCds_PartnerCompleteReport_Partners;
   CriaCds_DirectorCompleteReport_Directors;
   CriaCds_NegativeData_pefin;
   CriaCds_NegativeData_refin;
   CriaCds_NegativeData_collectionRecords;
   CriaCds_NegativeData_check;
   CriaCds_NegativeData_notary;
   CriaCds_Facts_JudgementFilings;
   CriaCds_Facts_Bankrupts;
   CriaCds_Facts_InquiryCompany;
   CriaCds_NegativeSummary
End;

Procedure TConsultaSerasaExperian.CriaCds_Consulta();
Begin
    FcdsConsulta.Close;
    FcdsConsulta.FieldDefs.Clear;

    AddField(FcdsConsulta, 'EMPRESA_LOGADA', 'string', 200);
    AddField(FcdsConsulta, 'RAZAO_SOCIAL', 'string', 150);
    AddField(FcdsConsulta, 'CNPJ_CPF', 'string', 20);
    AddField(FcdsConsulta, 'UPDATE_DATE', 'string', 10);
    AddField(FcdsConsulta, 'DOCUMENT_NUMBER', 'string', 14);
    AddField(FcdsConsulta, 'STATUS_REGISTRATION', 'string', 100);
    AddField(FcdsConsulta, 'STATUS_CODE', 'string', 10);
    AddField(FcdsConsulta, 'STATUS_DESC', 'string', 50);
    AddField(FcdsConsulta, 'COMPANY_NAME', 'string', 150);
    AddField(FcdsConsulta, 'PARTNERSHIP', 'string', 100);
    AddField(FcdsConsulta, 'COMPANY_REGISTER', 'string', 20);
    AddField(FcdsConsulta, 'COMPANY_REGISTER_DATE', 'string', 10);
    AddField(FcdsConsulta, 'COMPANY_FOUNDATION', 'string', 10);
    AddField(FcdsConsulta, 'NUMBER_EMPLOYEES', 'integer');
    AddField(FcdsConsulta, 'ECONOMIC_ACTIVITY', 'string', 200);
    AddField(FcdsConsulta, 'IMPORT_PURCHASES', 'float');
    AddField(FcdsConsulta, 'EXPORT_SALES', 'float');
    AddField(FcdsConsulta, 'CNAE', 'string', 20);
    AddField(FcdsConsulta, 'SERASA_ACTIVE_CODE', 'string', 20);
    AddField(FcdsConsulta, 'BRANCH_OFFICES', 'string', 10);
    AddField(FcdsConsulta, 'NIRE_NUMBER', 'string', 20);
    AddField(FcdsConsulta, 'LEGAL_NATURE_CODE', 'string', 10);
    AddField(FcdsConsulta, 'ADDRESS_LINE', 'string', 200);
    AddField(FcdsConsulta, 'ZIP_CODE', 'string', 10);
    AddField(FcdsConsulta, 'DISTRICT', 'string', 100);
    AddField(FcdsConsulta, 'CITY', 'string', 100);
    AddField(FcdsConsulta, 'STATE', 'string', 2);
    AddField(FcdsConsulta, 'RECIPROCITY_MESSAGE', 'string', 500);
    AddField(FcdsConsulta, 'COMPANY_URL', 'string', 100);
    AddField(FcdsConsulta, 'TAXOPTION', 'string', 100);

    //Totalizadores
    AddField(FcdsConsulta, 'QTDE_SOCIOS', 'integer');
    AddField(FcdsConsulta, 'QTDE_DIRETORES', 'integer');
    AddField(FcdsConsulta, 'QTDE_OCORRENCIAS_NEG', 'integer');

    FcdsConsulta.CreateDataSet;
End;

Procedure TConsultaSerasaExperian.CriaCds_Score();
Begin
    FcdsScore.Close;
    FcdsScore.FieldDefs.Clear;

    AddField(FcdsScore, 'SCORE', 'integer');
    AddField(FcdsScore, 'SCOREMODEL', 'string', 50);
    AddField(FcdsScore, 'DEFAULTRATE', 'float');
    AddField(FcdsScore, 'MESSAGE', 'string', 500);

    FcdsScore.CreateDataSet;
End;

Procedure TConsultaSerasaExperian.CriaCds_QSAReport();
Begin
    FcdsQSAReport.Close;
    FcdsQSAReport.FieldDefs.Clear;

    AddField(FcdsQSAReport, 'SOCIALCAPITALVALUE', 'float');
    AddField(FcdsQSAReport, 'ACCOMPLISHEDVALUE', 'float');
    AddField(FcdsQSAReport, 'INFORMATIONUPDATEDATE', 'string', 10);
    AddField(FcdsQSAReport, 'COUNTRYORIGIN', 'string', 50);
    AddField(FcdsQSAReport, 'CONTROLTYPE', 'string', 50);
    AddField(FcdsQSAReport, 'NATURE', 'string', 50);

    FcdsQSAReport.CreateDataSet;
End;

Procedure TConsultaSerasaExperian.CriaCds_PartnerCompleteReport_Partners();
Begin
    FcdsPartnerCompleteReport_Partners.Close;
    FcdsPartnerCompleteReport_Partners.FieldDefs.Clear;

    AddField(FcdsPartnerCompleteReport_Partners, 'DOCUMENTTYPE', 'string', 20);
    AddField(FcdsPartnerCompleteReport_Partners, 'DOCUMENTID', 'string', 20);
    AddField(FcdsPartnerCompleteReport_Partners, 'NAME', 'string', 20);
    AddField(FcdsPartnerCompleteReport_Partners, 'SINCEDATE', 'string', 10);
    AddField(FcdsPartnerCompleteReport_Partners, 'NATIONALITY', 'string', 60);
    AddField(FcdsPartnerCompleteReport_Partners, 'RESTRICTIONSIGN', 'string', 200);
    AddField(FcdsPartnerCompleteReport_Partners, 'DOCUMENTCONSISTENCY', 'string', 20);
    AddField(FcdsPartnerCompleteReport_Partners, 'CAPITALTOTALVALUE', 'float');
    AddField(FcdsPartnerCompleteReport_Partners, 'CAPITALVOTERVALUE', 'float');

    FcdsPartnerCompleteReport_Partners.CreateDataSet;
End;

Procedure TConsultaSerasaExperian.LoadFromJson(const AJson: string);
var
  JSONObject, Report: TJSONObject;
Begin
  JSONObject := TJSONObject.ParseJSONValue(AJson) AS TJSONObject;

  Try
    Report := JSONObject.GetValue<TJSONArray>('reports').Items[0] AS TJSONObject;

    CriaCds();

    CarregaIdentificationReport(Report);
    CarregaScore(JSONObject);
    CarregaReciprocity(Report);
    Carrega_QSAReport(JSONObject);
    Carrega_PartnersList(JSONObject);
    Carrega_DirectorsList(JSONObject);
    Carrega_negativeData_pefin(Report);
    Carrega_negativeData_refin(Report);
    Carrega_negativeData_collectionRecords(Report);
    Carrega_negativeData_check(Report);
    Carrega_negativeData_notary(Report);
    Carrega_facts_judgementFilings(Report);
    Carrega_facts_Bankrupts(Report);
    Carrega_facts_inquiryCompanyResponse(Report);
    Carrega_negativeSummary(Report);

    AtualizaTotalizadores();

  Finally
    JSONObject.Free;
  End;

End;

Procedure TConsultaSerasaExperian.AddField(cds: TUniClientDataSet; const FieldName, FieldType: string; Size: Integer);
Begin
  If cds.FieldDefs.IndexOf(FieldName) < 0 Then
  Begin
    If FieldType = 'string' Then
      cds.FieldDefs.Add(FieldName, ftString, Size)
    Else If FieldType = 'integer' Then
      cds.FieldDefs.Add(FieldName, ftInteger)
    Else If FieldType = 'float' Then
      cds.FieldDefs.Add(FieldName, ftFloat)
    Else If FieldType = 'date' Then
      cds.FieldDefs.Add(FieldName, ftDate)
    Else If FieldType = 'boolean' Then
      cds.FieldDefs.Add(FieldName, ftBoolean);
  End;
End;

Procedure TConsultaSerasaExperian.CarregaIdentificationReport(JSON: TJSONObject);
var
  Ident: TJSONObject;
  Addr: TJSONObject;
Begin
  Ident := JSON.Values['identificationReport'] AS TJSONObject;

  If Ident = nil Then
     Exit;

  FcdsConsulta.Open;
  FcdsConsulta.Append;

  Addr := Ident.Values['address'] AS TJSONObject;

  FcdsConsulta.FieldByName('EMPRESA_LOGADA').AsString        := Concat(VS_strCodEmp,' - ',fRetNomeEmpresaSelec(VS_strCodEmp));
  FcdsConsulta.FieldByName('RAZAO_SOCIAL').AsString          := Ident.GetValue<string>('companyName', ''); //RetornaValorJson(LJsonObjectValue,'companyName');
  FcdsConsulta.FieldByName('CNPJ_CPF').AsString              := fFormataCpfCgc(FDadosConsulta.FDocumento,fSetaPais);

  FcdsConsulta.FieldByName('UPDATE_DATE').AsString           := RetornaDataFormatada(Ident.GetValue<string>('updateDate', ''));
  FcdsConsulta.FieldByName('DOCUMENT_NUMBER').AsString       := Ident.GetValue<string>('documentNumber', '');
  FcdsConsulta.FieldByName('STATUS_REGISTRATION').AsString   := Ident.GetValue<string>('statusRegistration', '');
  FcdsConsulta.FieldByName('STATUS_CODE').AsString           := Ident.GetValue<string>('statusCode', '');
  FcdsConsulta.FieldByName('STATUS_DESC').AsString           := Ident.GetValue<string>('statusCodeDescription', '');
  FcdsConsulta.FieldByName('COMPANY_NAME').AsString          := Ident.GetValue<string>('companyName', '');
  FcdsConsulta.FieldByName('PARTNERSHIP').AsString           := Ident.GetValue<string>('partnership', '');
  FcdsConsulta.FieldByName('COMPANY_REGISTER').AsString      := Ident.GetValue<string>('companyRegister', '');
  FcdsConsulta.FieldByName('COMPANY_REGISTER_DATE').AsString := RetornaDataFormatada(Ident.GetValue<string>('companyRegisterDate', ''));
  FcdsConsulta.FieldByName('COMPANY_FOUNDATION').AsString    := Ident.GetValue<string>('companyFoundation', '');
  FcdsConsulta.FieldByName('NUMBER_EMPLOYEES').AsInteger     := Ident.GetValue<Integer>('numberEmployees', 0);
  FcdsConsulta.FieldByName('ECONOMIC_ACTIVITY').AsString     := Ident.GetValue<string>('economicActivity', '');
  FcdsConsulta.FieldByName('IMPORT_PURCHASES').AsFloat       := Ident.GetValue<Double>('importPurchases', 0.0);
  FcdsConsulta.FieldByName('EXPORT_SALES').AsFloat           := Ident.GetValue<Double>('exportSales', 0.0);
  FcdsConsulta.FieldByName('CNAE').AsString                  := Ident.GetValue<string>('cnae', '');
  FcdsConsulta.FieldByName('SERASA_ACTIVE_CODE').AsString    := Ident.GetValue<string>('serasaActiveCode', '');
  FcdsConsulta.FieldByName('BRANCH_OFFICES').AsString        := Ident.GetValue<string>('branchOffices', '');
  FcdsConsulta.FieldByName('NIRE_NUMBER').AsString           := Ident.GetValue<string>('nireNumber', '');
  FcdsConsulta.FieldByName('LEGAL_NATURE_CODE').AsString     := Ident.GetValue<string>('legalNatureCode', '');
  FcdsConsulta.FieldByName('COMPANY_URL').AsString           := Ident.GetValue<string>('companyUrl', '');
  FcdsConsulta.FieldByName('TAXOPTION').AsString             := Ident.GetValue<string>('taxOption', '');

  If Addr <> nil Then
  Begin
    FcdsConsulta.FieldByName('ADDRESS_LINE').AsString := Addr.GetValue<string>('addressLine', '');
    FcdsConsulta.FieldByName('ZIP_CODE').AsString     := Addr.GetValue<string>('zipCode', '');
    FcdsConsulta.FieldByName('DISTRICT').AsString     := Addr.GetValue<string>('district', '');
    FcdsConsulta.FieldByName('CITY').AsString         := Addr.GetValue<string>('city', '');
    FcdsConsulta.FieldByName('STATE').AsString        := Addr.GetValue<string>('state', '');
  End;

  FcdsConsulta.Post;
End;

Procedure TConsultaSerasaExperian.CarregaScore(JSON: TJSONObject);
var
  Score: TJSONObject;
  LJsonObjectData :  TJsonObject;
Begin

  LJsonObjectData := ExtrairJsonObject(JSON,'optionalFeatures');

  If LJsonObjectData = nil Then
     Exit;

  Score := LJsonObjectData.GetValue<TJSONObject>('score');
  If Score = nil Then
     Exit;

  FcdsScore.Open;
  FcdsScore.Append;

  FcdsScore.FieldByName('SCORE').AsInteger     := Score.GetValue<Integer>('score', 0);
  FcdsScore.FieldByName('SCOREMODEL').AsString := Score.GetValue<string>('scoreModel', '');
  FcdsScore.FieldByName('DEFAULTRATE').AsFloat := Score.GetValue<Double>('defaultRate', 0.0);
  FcdsScore.FieldByName('MESSAGE').AsString    := Score.GetValue<string>('message', '');

  FcdsScore.Post;
End;

Procedure TConsultaSerasaExperian.CarregaReciprocity(JSON: TJSONObject);
var
  Msg: String;
  LJsonObjectValue, reciprocityData: TJSONObject;
Begin

  LJsonObjectValue := JSON.Values['additionalInformationReport'] AS TJSONObject;

  If LJsonObjectValue = nil Then
     Exit;

  reciprocityData := ExtrairJsonObject(LJsonObjectValue,'reciprocityData');
  If reciprocityData = nil Then

     Exit;

  Msg := reciprocityData.GetValue<string>('reciprocityMessageDescription', '');

  If Msg <> '' Then
  Begin
     FcdsConsulta.Edit;
     FcdsConsulta.FieldByName('RECIPROCITY_MESSAGE').AsString := Msg;
     FcdsConsulta.Post;
  End;
End;

Procedure TConsultaSerasaExperian.Carrega_QSAReport(JSON: TJSONObject);
var
  QSAReport: TJSONObject;

  LJsonObjectData :  TJsonObject;
  LcompanyData : TJsonObject;
Begin

  LJsonObjectData := ExtrairJsonObject(JSON,'optionalFeatures');

  If LJsonObjectData = nil Then
     Exit;

  QSAReport := LJsonObjectData.GetValue<TJSONObject>('QSAReport');
  If QSAReport = nil Then
     Exit;

  LcompanyData := ExtrairJsonObject(QSAReport,'companyData');
  If LcompanyData = nil Then
     Exit;

  FcdsQSAReport.Open;
  FcdsQSAReport.Append;

  FcdsQSAReport.FieldByName('socialCapitalValue').AsFloat     := LcompanyData.GetValue<Double>('socialCapitalValue', 0);
  FcdsQSAReport.FieldByName('accomplishedValue').AsFloat      := LcompanyData.GetValue<Double>('accomplishedValue', 0);
  FcdsQSAReport.FieldByName('informationUpdateDate').AsString := RetornaDataFormatada(LcompanyData.GetValue<string>('informationUpdateDate', ''));
  FcdsQSAReport.FieldByName('countryOrigin').AsString         := LcompanyData.GetValue<string>('countryOrigin', '');
  FcdsQSAReport.FieldByName('controlType').AsString           := LcompanyData.GetValue<string>('controlType', '');
  FcdsQSAReport.FieldByName('nature').AsString                := LcompanyData.GetValue<string>('nature', '');

  FcdsQSAReport.Post;
End;

// ### PartnerCompleteReport -> PartnersList ###
Procedure TConsultaSerasaExperian.Carrega_PartnersList(JSON: TJSONObject);
var
  OptionalFeatures, QSAReport, LpartnerCompleteReport: TJSONObject;
  LJsonArrayPartners: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectPartner: TJSONObject;
begin
  // Primeiro navega até partnerCompleteReport
  OptionalFeatures := JSON.GetValue<TJSONObject>('optionalFeatures');
  if OptionalFeatures = nil then
    Exit;

  QSAReport := OptionalFeatures.GetValue<TJSONObject>('QSAReport');
  if QSAReport = nil then
    Exit;

  LpartnerCompleteReport := ExtrairJsonObject(QSAReport, 'partnerCompleteReport');
  if LpartnerCompleteReport = nil then
    Exit;

  // Extrai a lista de partners
  LJsonArrayPartners := ExtrairJsonArray(LpartnerCompleteReport, 'partnersList');
  if LJsonArrayPartners = nil then
    Exit;

  FcdsPartnerCompleteReport_Partners.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayPartners do
  begin
    LJsonObjectPartner := LJsonValue as TJSONObject;
                                                                                      fFormataCpfCgc(FDadosConsulta.FDocumento,fSetaPais);
    FcdsPartnerCompleteReport_Partners.Append;

    FcdsPartnerCompleteReport_Partners.FieldByName('DOCUMENTTYPE').AsString        := RetornaValorJson(LJsonObjectPartner, 'documentType');
    FcdsPartnerCompleteReport_Partners.FieldByName('DOCUMENTID').AsString          := fFormataCpfCgc(RetornaValorJson(LJsonObjectPartner, 'documentId'),fSetaPais);
    FcdsPartnerCompleteReport_Partners.FieldByName('NAME').AsString                := RetornaValorJson(LJsonObjectPartner, 'name');
    FcdsPartnerCompleteReport_Partners.FieldByName('SINCEDATE').AsString           := RetornaDataFormatada(RetornaValorJson(LJsonObjectPartner, 'sinceDate'));
    FcdsPartnerCompleteReport_Partners.FieldByName('NATIONALITY').AsString         := RetornaValorJson(LJsonObjectPartner, 'nationality');
    FcdsPartnerCompleteReport_Partners.FieldByName('RESTRICTIONSIGN').AsString     := RetornaValorJson(LJsonObjectPartner, 'restrictionSign');
    FcdsPartnerCompleteReport_Partners.FieldByName('DOCUMENTCONSISTENCY').AsString := RetornaValorJson(LJsonObjectPartner, 'documentConsistency');
    FcdsPartnerCompleteReport_Partners.FieldByName('CAPITALTOTALVALUE').AsFloat    := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectPartner, 'capitalTotalValue')), 2);
    FcdsPartnerCompleteReport_Partners.FieldByName('CAPITALVOTERVALUE').AsFloat    := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectPartner, 'capitalVoterValue')), 2);
                                                                                      //Ident.GetValue<Double>('importPurchases', 0.0);
    FcdsPartnerCompleteReport_Partners.Post;
  end;

End;

// ### PartnerCompleteReport -> DirectorList ###
Procedure TConsultaSerasaExperian.Carrega_DirectorsList(JSON: TJSONObject);
var
  OptionalFeatures, QSAReport, LDirectorCompleteReport: TJSONObject;
  LJsonArrayDirectors: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectDirector: TJSONObject;
begin
  // Primeiro navega até directorCompleteReport
  OptionalFeatures := JSON.GetValue<TJSONObject>('optionalFeatures');
  if OptionalFeatures = nil then
    Exit;

  QSAReport := OptionalFeatures.GetValue<TJSONObject>('QSAReport');
  if QSAReport = nil then
    Exit;

  LDirectorCompleteReport := ExtrairJsonObject(QSAReport, 'directorCompleteReport');
  if LDirectorCompleteReport = nil then
    Exit;

  // Extrai a lista de directors
  LJsonArrayDirectors := ExtrairJsonArray(LDirectorCompleteReport, 'directorsList');
  if LJsonArrayDirectors = nil then
    Exit;

  FcdsDirectorCompleteReport_Directors.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayDirectors do
  begin
    LJsonObjectDirector := LJsonValue as TJSONObject;

    FcdsDirectorCompleteReport_Directors.Append;

    FcdsDirectorCompleteReport_Directors.FieldByName('DOCUMENTTYPE').AsString          := RetornaValorJson(LJsonObjectDirector, 'documentType');
    FcdsDirectorCompleteReport_Directors.FieldByName('DOCUMENTID').AsString            := fFormataCpfCgc(RetornaValorJson(LJsonObjectDirector, 'documentId'),fSetaPais);
    FcdsDirectorCompleteReport_Directors.FieldByName('NAME').AsString                  := RetornaValorJson(LJsonObjectDirector, 'name');
    FcdsDirectorCompleteReport_Directors.FieldByName('ROLE').AsString                  := RetornaValorJson(LJsonObjectDirector, 'role');
    FcdsDirectorCompleteReport_Directors.FieldByName('SINCEDATE').AsString             := RetornaDataFormatada(RetornaValorJson(LJsonObjectDirector, 'sinceDate'));
    FcdsDirectorCompleteReport_Directors.FieldByName('NATIONALITY').AsString           := RetornaValorJson(LJsonObjectDirector, 'nationality');
    FcdsDirectorCompleteReport_Directors.FieldByName('RESTRICTIONSIGN').AsString       := RetornaValorJson(LJsonObjectDirector, 'restrictionSign');
    FcdsDirectorCompleteReport_Directors.FieldByName('DOCUMENTCONSISTENCY').AsString   := RetornaValorJson(LJsonObjectDirector, 'documentConsistency');
    FcdsDirectorCompleteReport_Directors.FieldByName('STATUS').AsString                := RetornaValorJson(LJsonObjectDirector, 'status');
    FcdsDirectorCompleteReport_Directors.FieldByName('INFORMATIONUPDATEDATE').AsString := RetornaDataFormatada(RetornaValorJson(LJsonObjectDirector, 'informationUpdateDate'));

    FcdsDirectorCompleteReport_Directors.Post;
  end;
End;

Procedure TConsultaSerasaExperian.CriaCds_DirectorCompleteReport_Directors();
Begin

    FcdsDirectorCompleteReport_Directors.Close;
    FcdsDirectorCompleteReport_Directors.FieldDefs.Clear;

    AddField(FcdsDirectorCompleteReport_Directors, 'DOCUMENTTYPE', 'string', 20);
    AddField(FcdsDirectorCompleteReport_Directors, 'DOCUMENTID', 'string', 20);
    AddField(FcdsDirectorCompleteReport_Directors, 'NAME', 'string', 50);
    AddField(FcdsDirectorCompleteReport_Directors, 'ROLE', 'string', 30);
    AddField(FcdsDirectorCompleteReport_Directors, 'SINCEDATE', 'string', 10);
    AddField(FcdsDirectorCompleteReport_Directors, 'NATIONALITY', 'string', 60);
    AddField(FcdsDirectorCompleteReport_Directors, 'RESTRICTIONSIGN', 'string', 200);
    AddField(FcdsDirectorCompleteReport_Directors, 'DOCUMENTCONSISTENCY', 'string', 20);
    AddField(FcdsDirectorCompleteReport_Directors, 'STATUS', 'string', 10);
    AddField(FcdsDirectorCompleteReport_Directors, 'INFORMATIONUPDATEDATE', 'string', 10);

    FcdsDirectorCompleteReport_Directors.CreateDataSet;

End;

// ### negativeData pefin ###
Procedure TConsultaSerasaExperian.Carrega_negativeData_pefin(JSON: TJSONObject);
var
  negativeData, pefin, summary: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  pefin_firstOccurrence,
  pefin_lastOccurrence,
  pefin_count : String;
  pefin_balance : Double;
begin

  // Primeiro navega até negativeDate
  negativeData := JSON.GetValue<TJSONObject>('negativeData');
  if negativeData = nil then
    Exit;

  pefin := negativeData.GetValue<TJSONObject>('pefin');
  if pefin = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(pefin, 'summary');
  if summary = nil then
    Exit;

  pefin_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  pefin_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  pefin_count           := RetornaValorJson(summary, 'count');
  pefin_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  // Extrai a lista de partners
  LJsonArrayResponse := ExtrairJsonArray(pefin, 'pefinResponse');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsNegativeData_pefin.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsNegativeData_pefin.Append;

    FcdsNegativeData_pefin.FieldByName('OccurrenceDate').AsString        := RetornaDataFormatada(RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsNegativeData_pefin.FieldByName('LegalNature').AsString           := RetornaValorJson(LJsonObjectResponse, 'legalNature');
    FcdsNegativeData_pefin.FieldByName('LegalNatureId').AsString         := RetornaValorJson(LJsonObjectResponse, 'legalNatureId');
    FcdsNegativeData_pefin.FieldByName('ContractId').AsString            := RetornaValorJson(LJsonObjectResponse, 'contractId');
    FcdsNegativeData_pefin.FieldByName('creditorName').AsString          := RetornaValorJson(LJsonObjectResponse, 'creditorName');
    FcdsNegativeData_pefin.FieldByName('amount').AsFloat                 := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectResponse, 'amount')), 2);
    FcdsNegativeData_pefin.FieldByName('Principal').AsString             := RetornaValorJson(LJsonObjectResponse, 'principal');
    FcdsNegativeData_pefin.FieldByName('Cadus').AsString                 := RetornaValorJson(LJsonObjectResponse, 'cadus');

    FcdsNegativeData_pefin.FieldByName('firstOccurrence').AsString       := pefin_firstOccurrence;
    FcdsNegativeData_pefin.FieldByName('lastOccurrence').AsString        := pefin_lastOccurrence;
    FcdsNegativeData_pefin.FieldByName('count').AsString                 := pefin_count;
    FcdsNegativeData_pefin.FieldByName('balance').AsFloat                := pefin_balance;

    FcdsNegativeData_pefin.Post;
  end;

End;

// ### negativeData refin ###
Procedure TConsultaSerasaExperian.Carrega_negativeData_refin(JSON: TJSONObject);
var
  negativeData, refin, summary: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  refin_firstOccurrence,
  refin_lastOccurrence,
  refin_count : String;
  refin_balance : Double;
begin

  // Primeiro navega até negativeDate
  negativeData := JSON.GetValue<TJSONObject>('negativeData');
  if negativeData = nil then
    Exit;

  refin := negativeData.GetValue<TJSONObject>('refin');
  if refin = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(refin, 'summary');
  if summary = nil then
    Exit;

  refin_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  refin_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  refin_count           := RetornaValorJson(summary, 'count');
  refin_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  // Extrai a lista de partners
  LJsonArrayResponse := ExtrairJsonArray(refin, 'refinResponse');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsNegativeData_refin.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsNegativeData_refin.Append;

    FcdsNegativeData_refin.FieldByName('OccurrenceDate').AsString   := RetornaDataFormatada(RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsNegativeData_refin.FieldByName('LegalNature').AsString      := RetornaValorJson(LJsonObjectResponse, 'legalNature');
    FcdsNegativeData_refin.FieldByName('LegalNatureId').AsString   := RetornaValorJson(LJsonObjectResponse, 'legalNatureId');
    FcdsNegativeData_refin.FieldByName('contractId').AsString      := RetornaValorJson(LJsonObjectResponse, 'contractId');
    FcdsNegativeData_refin.FieldByName('amount').AsFloat           := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectResponse, 'amount')), 2);
    FcdsNegativeData_refin.FieldByName('Principal').AsString       := RetornaValorJson(LJsonObjectResponse, 'principal');
    FcdsNegativeData_refin.FieldByName('Cadus').AsString           := RetornaValorJson(LJsonObjectResponse, 'cadus');

    FcdsNegativeData_refin.FieldByName('firstOccurrence').AsString  := refin_firstOccurrence;
    FcdsNegativeData_refin.FieldByName('lastOccurrence').AsString   := refin_lastOccurrence;
    FcdsNegativeData_refin.FieldByName('count').AsString            := refin_count;
    FcdsNegativeData_refin.FieldByName('balance').AsFloat           := refin_balance;

    FcdsNegativeData_refin.Post;
  end;

End;

// ### negativeData collectionRecords ###
Procedure TConsultaSerasaExperian.Carrega_negativeData_collectionRecords(JSON: TJSONObject);
var
  negativeData, collectionRecords, summary: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  collectionRecords_firstOccurrence,
  collectionRecords_lastOccurrence,
  collectionRecords_count : String;
  collectionRecords_balance : Double;
begin

  // Primeiro navega até negativeDate
  negativeData := JSON.GetValue<TJSONObject>('negativeData');
  if negativeData = nil then
    Exit;

  collectionRecords := negativeData.GetValue<TJSONObject>('collectionRecords');
  if collectionRecords = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(collectionRecords, 'summary');
  if summary = nil then
    Exit;

  collectionRecords_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  collectionRecords_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  collectionRecords_count           := RetornaValorJson(summary, 'count');
  collectionRecords_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  // Extrai a lista de partners
  LJsonArrayResponse := ExtrairJsonArray(collectionRecords, 'collectionRecordsResponse');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsNegativeData_collectionRecords.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsNegativeData_collectionRecords.Append;

    FcdsNegativeData_collectionRecords.FieldByName('OccurrenceDate').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsNegativeData_collectionRecords.FieldByName('LegalNature').AsString     := RetornaValorJson(LJsonObjectResponse, 'legalNature');
    FcdsNegativeData_collectionRecords.FieldByName('LegalNatureId').AsString   := RetornaValorJson(LJsonObjectResponse, 'legalNatureId');
    FcdsNegativeData_collectionRecords.FieldByName('contractId').AsString      := RetornaValorJson(LJsonObjectResponse, 'contractId');
    FcdsNegativeData_collectionRecords.FieldByName('amount').AsFloat           := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectResponse, 'amount')), 2);
    FcdsNegativeData_collectionRecords.FieldByName('Principal').AsString       := RetornaValorJson(LJsonObjectResponse, 'principal');
    FcdsNegativeData_collectionRecords.FieldByName('debtMode').AsString        := RetornaValorJson(LJsonObjectResponse, 'debtMode');
    FcdsNegativeData_collectionRecords.FieldByName('Cadus').AsString           := RetornaValorJson(LJsonObjectResponse, 'cadus');

    FcdsNegativeData_collectionRecords.FieldByName('firstOccurrence').AsString  := collectionRecords_firstOccurrence;
    FcdsNegativeData_collectionRecords.FieldByName('lastOccurrence').AsString   := collectionRecords_lastOccurrence;
    FcdsNegativeData_collectionRecords.FieldByName('count').AsString            := collectionRecords_count;
    FcdsNegativeData_collectionRecords.FieldByName('balance').AsFloat           := collectionRecords_balance;

    FcdsNegativeData_collectionRecords.Post;
  end;

End;

// ### negativeData check ###
Procedure TConsultaSerasaExperian.Carrega_negativeData_check(JSON: TJSONObject);
var
  negativeData, check, summary: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  check_firstOccurrence,
  check_lastOccurrence,
  check_count : String;
  check_balance : Double;
begin

  // Primeiro navega até negativeDate
  negativeData := JSON.GetValue<TJSONObject>('negativeData');
  if negativeData = nil then
    Exit;

  check := negativeData.GetValue<TJSONObject>('check');
  if check = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(check, 'summary');
  if summary = nil then
    Exit;

  check_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  check_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  check_count           := RetornaValorJson(summary, 'count');
  check_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  // Extrai a lista de partners
  LJsonArrayResponse := ExtrairJsonArray(check, 'checkResponse');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsNegativeData_check.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsNegativeData_check.Append;

    FcdsNegativeData_check.FieldByName('OccurrenceDate').AsString  := RetornaDataFormatada(RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsNegativeData_check.FieldByName('alinea').AsString          := RetornaValorJson(LJsonObjectResponse, 'alinea');
    FcdsNegativeData_check.FieldByName('bankName').AsString        := RetornaValorJson(LJsonObjectResponse, 'bankName');
    FcdsNegativeData_check.FieldByName('bankAgencyId').AsString    := RetornaValorJson(LJsonObjectResponse, 'bankAgencyId');
    FcdsNegativeData_check.FieldByName('checkNumber').AsString     := RetornaValorJson(LJsonObjectResponse, 'checkNumber');
    FcdsNegativeData_check.FieldByName('checkCount').AsString      := RetornaValorJson(LJsonObjectResponse, 'checkCount');
    FcdsNegativeData_check.FieldByName('Cadus').AsString           := RetornaValorJson(LJsonObjectResponse, 'cadus');

    FcdsNegativeData_check.FieldByName('firstOccurrence').AsString  := check_firstOccurrence;
    FcdsNegativeData_check.FieldByName('lastOccurrence').AsString   := check_lastOccurrence;
    FcdsNegativeData_check.FieldByName('count').AsString            := check_count;
    FcdsNegativeData_check.FieldByName('balance').AsFloat           := check_balance;

    FcdsNegativeData_check.Post;
  end;

End;

// ### negativeData notary ###
Procedure TConsultaSerasaExperian.Carrega_negativeData_notary(JSON: TJSONObject);
var
  negativeData, notary, summary: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  notary_firstOccurrence,
  notary_lastOccurrence,
  notary_count : String;
  notary_balance : Double;
begin

  // Primeiro navega até negativeDate
  negativeData := JSON.GetValue<TJSONObject>('negativeData');
  if negativeData = nil then
    Exit;

  notary := negativeData.GetValue<TJSONObject>('notary');
  if notary = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(notary, 'summary');
  if summary = nil then
    Exit;

  notary_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  notary_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  notary_count           := RetornaValorJson(summary, 'count');
  notary_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  // Extrai a lista de partners
  LJsonArrayResponse := ExtrairJsonArray(notary, 'notaryResponse');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsNegativeData_notary.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsNegativeData_notary.Append;

    FcdsNegativeData_notary.FieldByName('OccurrenceDate').AsString  := (RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsNegativeData_notary.FieldByName('amount').AsFloat           := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectResponse, 'amount')), 2);
    FcdsNegativeData_notary.FieldByName('officeNumber').AsString      := RetornaValorJson(LJsonObjectResponse, 'officeNumber');
    FcdsNegativeData_notary.FieldByName('Cadus').AsString           := RetornaValorJson(LJsonObjectResponse, 'cadus');

    FcdsNegativeData_notary.FieldByName('firstOccurrence').AsString  := notary_firstOccurrence;
    FcdsNegativeData_notary.FieldByName('lastOccurrence').AsString   := notary_lastOccurrence;
    FcdsNegativeData_notary.FieldByName('count').AsString            := notary_count;
    FcdsNegativeData_notary.FieldByName('balance').AsFloat           := notary_balance;

    FcdsNegativeData_notary.Post;
  end;

End;

// ### facts ###
Procedure TConsultaSerasaExperian.Carrega_facts_judgementFilings(JSON: TJSONObject);
var
  facts, judgementFilings, summary: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  judgementFilings_firstOccurrence,
  judgementFilings_lastOccurrence,
  judgementFilings_count : String;
  judgementFilings_balance : Double;
begin

  // Primeiro navega até negativeDate
  facts := JSON.GetValue<TJSONObject>('facts');
  if facts = nil then
    Exit;

  judgementFilings := facts.GetValue<TJSONObject>('judgementFilings');
  if judgementFilings = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(judgementFilings, 'summary');
  if summary = nil then
    Exit;

  judgementFilings_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  judgementFilings_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  judgementFilings_count           := RetornaValorJson(summary, 'count');
  judgementFilings_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  // Extrai a lista
  LJsonArrayResponse := ExtrairJsonArray(judgementFilings, 'judgementFilingsResponse');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsFactsJudgementFilings.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsFactsJudgementFilings.Append;

    FcdsFactsJudgementFilings.FieldByName('OccurrenceDate').AsString        := RetornaDataFormatada(RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsFactsJudgementFilings.FieldByName('LegalNature').AsString           := RetornaValorJson(LJsonObjectResponse, 'legalNature');
    FcdsFactsJudgementFilings.FieldByName('LegalNatureId').AsString         := RetornaValorJson(LJsonObjectResponse, 'legalNatureId');
    FcdsFactsJudgementFilings.FieldByName('amount').AsFloat                 := fFormataFloat(fStrToFloat(RetornaValorJson(LJsonObjectResponse, 'amount')), 2);
    FcdsFactsJudgementFilings.FieldByName('Distributor').AsString           := RetornaValorJson(LJsonObjectResponse, 'distributor');
    FcdsFactsJudgementFilings.FieldByName('CivilCourt').AsString            := RetornaValorJson(LJsonObjectResponse, 'civilCourt');
    FcdsFactsJudgementFilings.FieldByName('Principal').AsString             := RetornaValorJson(LJsonObjectResponse, 'principal');
    FcdsFactsJudgementFilings.FieldByName('Cadus').AsString                 := RetornaValorJson(LJsonObjectResponse, 'cadus');

    FcdsFactsJudgementFilings.FieldByName('firstOccurrence').AsString       := judgementFilings_firstOccurrence;
    FcdsFactsJudgementFilings.FieldByName('lastOccurrence').AsString        := judgementFilings_lastOccurrence;
    FcdsFactsJudgementFilings.FieldByName('count').AsString                 := judgementFilings_count;
    FcdsFactsJudgementFilings.FieldByName('balance').AsFloat                := judgementFilings_balance;

    FcdsFactsJudgementFilings.Post;
  end;

End;

// ### facts - Bankrupts ###
Procedure TConsultaSerasaExperian.Carrega_facts_Bankrupts(JSON: TJSONObject);
var
  facts, Bankrupts, summary: TJSONObject;

  Bankrupts_count : String;
  Bankrupts_balance : Double;
begin

  // Primeiro navega até negativeDate
  facts := JSON.GetValue<TJSONObject>('facts');
  if facts = nil then
    Exit;

  Bankrupts := facts.GetValue<TJSONObject>('bankrupts');
  if Bankrupts = nil then
    Exit;

  // Sumary
  summary := ExtrairJsonObject(Bankrupts, 'summary');
  if summary = nil then
    Exit;

  Bankrupts_count   := RetornaValorJson(summary, 'count');
  Bankrupts_balance := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);

  FcdsFactsBankrupts.Open;
  FcdsFactsBankrupts.Append;
  FcdsFactsBankrupts.FieldByName('count').AsString  := Bankrupts_count;
  FcdsFactsBankrupts.FieldByName('balance').AsFloat := Bankrupts_balance;
  FcdsFactsBankrupts.Post;

End;

// ### facts InquiryCompany ###
Procedure TConsultaSerasaExperian.Carrega_facts_inquiryCompanyResponse(JSON: TJSONObject);
var
  facts, inquiryCompanyResponse: TJSONObject;
  LJsonArrayResponse: TJSONArray;
  LJsonValue: TJsonValue;
  LJsonObjectResponse: TJSONObject;

  //inquiryCompanyResponse_firstOccurrence,
  //inquiryCompanyResponse_lastOccurrence,
  //inquiryCompanyResponse_count : String;
  //inquiryCompanyResponse_balance : Double;
begin

  // Primeiro navega até negativeDate
  facts := JSON.GetValue<TJSONObject>('facts');
  if facts = nil then
    Exit;

  inquiryCompanyResponse := facts.GetValue<TJSONObject>('inquiryCompanyResponse');
  if inquiryCompanyResponse = nil then
    Exit;

  // Sumary
{  summary := ExtrairJsonObject(inquiryCompanyResponse, 'summary');
  if summary = nil then
    Exit;

  inquiryCompanyResponse_firstOccurrence := RetornaValorJson(summary, 'firstOccurrence');
  inquiryCompanyResponse_lastOccurrence  := RetornaValorJson(summary, 'lastOccurrence');
  inquiryCompanyResponse_count           := RetornaValorJson(summary, 'count');
  inquiryCompanyResponse_balance         := fFormataFloat(fStrToFloat(RetornaValorJson(summary, 'balance')), 2);}

  // Extrai a lista
  LJsonArrayResponse := ExtrairJsonArray(inquiryCompanyResponse, 'results');
  if LJsonArrayResponse = nil then
    Exit;

  FcdsFactsInquiryCompany.Open;

  // Agora percorre todos os registros do array
  for LJsonValue in LJsonArrayResponse do
  begin
    LJsonObjectResponse := LJsonValue as TJSONObject;

    FcdsFactsInquiryCompany.Append;

    FcdsFactsInquiryCompany.FieldByName('OccurrenceDate').AsString        := RetornaDataFormatada(RetornaValorJson(LJsonObjectResponse, 'occurrenceDate'));
    FcdsFactsInquiryCompany.FieldByName('CompanyName').AsString           := RetornaValorJson(LJsonObjectResponse, 'companyName');
    FcdsFactsInquiryCompany.FieldByName('CompanyDocumentId').AsString     := RetornaValorJson(LJsonObjectResponse, 'companyDocumentId');
    FcdsFactsInquiryCompany.FieldByName('CompanyAlias').AsString          := RetornaValorJson(LJsonObjectResponse, 'companyAlias');
    FcdsFactsInquiryCompany.FieldByName('DaysQuantity').AsString          := RetornaValorJson(LJsonObjectResponse, 'daysQuantity');

    FcdsFactsInquiryCompany.Post;
  end;

End;

procedure TConsultaSerasaExperian.Carrega_negativeSummary(JSON: TJSONObject);
var
  LJsonNegativeSummary: TJSONObject;
Begin
  LJsonNegativeSummary := JSON.Values['negativeSummary'] AS TJSONObject;

  If LJsonNegativeSummary = nil Then
     Exit;

  FcdsNegativeSummary.Open;
  FcdsNegativeSummary.Append;
  FcdsNegativeSummary.FieldByName('negative_message').AsString := RetornaValorJson(LJsonNegativeSummary, 'message');
  FcdsNegativeSummary.Post;
end;

procedure TConsultaSerasaExperian.CriaCds_NegativeData_pefin;
begin
  //pefin

  //pefin->pefinResponse
  FcdsNegativeData_pefin.Close;
  FcdsNegativeData_pefin.FieldDefs.Clear;
  AddField(FcdsNegativeData_pefin, 'OccurrenceDate', 'string',10);
  AddField(FcdsNegativeData_pefin, 'LegalNature', 'string', 100);
  AddField(FcdsNegativeData_pefin, 'LegalNatureId', 'string', 50);
  AddField(FcdsNegativeData_pefin, 'ContractId','string', 100);
  AddField(FcdsNegativeData_pefin, 'creditorName', 'string', 100);
  AddField(FcdsNegativeData_pefin, 'amount', 'float');
  AddField(FcdsNegativeData_pefin, 'Principal', 'string',30);
  AddField(FcdsNegativeData_pefin, 'Cadus', 'string', 50);

  //pefin->summary
  AddField(FcdsNegativeData_pefin, 'FirstOccurrence', 'string',10);
  AddField(FcdsNegativeData_pefin, 'LastOccurrence', 'string',10);
  AddField(FcdsNegativeData_pefin, 'Count', 'integer');
  AddField(FcdsNegativeData_pefin, 'Balance', 'float');
  FcdsNegativeData_pefin.CreateDataSet;
End;

procedure TConsultaSerasaExperian.CriaCds_NegativeData_refin;
begin
  //refin

  //refin->refinResponse
  FcdsNegativeData_refin.Close;
  FcdsNegativeData_refin.FieldDefs.Clear;
  AddField(FcdsNegativeData_refin, 'OccurrenceDate', 'string',10);
  AddField(FcdsNegativeData_refin, 'LegalNature', 'string', 100);
  AddField(FcdsNegativeData_refin, 'LegalNatureId', 'string', 50);
  AddField(FcdsNegativeData_refin, 'ContractId','string', 100);
  AddField(FcdsNegativeData_refin, 'amount', 'float');
  AddField(FcdsNegativeData_refin, 'Principal', 'string',30);
  AddField(FcdsNegativeData_refin, 'Cadus', 'string', 50);

  //pefin->summary
  AddField(FcdsNegativeData_refin, 'FirstOccurrence', 'string',10);
  AddField(FcdsNegativeData_refin, 'LastOccurrence', 'string',10);
  AddField(FcdsNegativeData_refin, 'Count', 'integer');
  AddField(FcdsNegativeData_refin, 'Balance', 'float');
  FcdsNegativeData_refin.CreateDataSet;
End;

procedure TConsultaSerasaExperian.CriaCds_NegativeData_collectionRecords;
begin
  //refin

  //refin->refinResponse
  FcdsNegativeData_collectionRecords.Close;
  FcdsNegativeData_collectionRecords.FieldDefs.Clear;
  AddField(FcdsNegativeData_collectionRecords, 'OccurrenceDate', 'string',10);
  AddField(FcdsNegativeData_collectionRecords, 'LegalNature', 'string', 100);
  AddField(FcdsNegativeData_collectionRecords, 'LegalNatureId', 'string', 50);
  AddField(FcdsNegativeData_collectionRecords, 'ContractId','string', 100);
  AddField(FcdsNegativeData_collectionRecords, 'amount', 'float');
  AddField(FcdsNegativeData_collectionRecords, 'Principal', 'string',30);
  AddField(FcdsNegativeData_collectionRecords, 'debtMode', 'string',60);
  AddField(FcdsNegativeData_collectionRecords, 'Cadus', 'string', 50);

  //pefin->summary
  AddField(FcdsNegativeData_collectionRecords, 'FirstOccurrence', 'string',10);
  AddField(FcdsNegativeData_collectionRecords, 'LastOccurrence', 'string',10);
  AddField(FcdsNegativeData_collectionRecords, 'Count', 'integer');
  AddField(FcdsNegativeData_collectionRecords, 'Balance', 'float');
  FcdsNegativeData_collectionRecords.CreateDataSet;
End;

procedure TConsultaSerasaExperian.CriaCds_NegativeData_check;
begin
  //refin

  //refin->refinResponse
  FcdsNegativeData_check.Close;
  FcdsNegativeData_check.FieldDefs.Clear;
  AddField(FcdsNegativeData_check, 'OccurrenceDate', 'string',10);
  AddField(FcdsNegativeData_check, 'alinea', 'string', 100);
  AddField(FcdsNegativeData_check, 'bankName', 'string', 100);
  AddField(FcdsNegativeData_check, 'bankAgencyId','string', 100);
  AddField(FcdsNegativeData_check, 'checkNumber', 'string',30);
  AddField(FcdsNegativeData_check, 'checkCount', 'string',60);
  AddField(FcdsNegativeData_check, 'Cadus', 'string', 50);

  //pefin->summary
  AddField(FcdsNegativeData_check, 'FirstOccurrence', 'string',10);
  AddField(FcdsNegativeData_check, 'LastOccurrence', 'string',10);
  AddField(FcdsNegativeData_check, 'Count', 'integer');
  AddField(FcdsNegativeData_check, 'Balance', 'float');
  FcdsNegativeData_check.CreateDataSet;
End;

procedure TConsultaSerasaExperian.CriaCds_NegativeData_notary;
begin
  //refin

  //refin->refinResponse
  FcdsNegativeData_notary.Close;
  FcdsNegativeData_notary.FieldDefs.Clear;
  AddField(FcdsNegativeData_notary, 'OccurrenceDate', 'string',10);
  AddField(FcdsNegativeData_notary, 'amount', 'float');
  AddField(FcdsNegativeData_notary, 'officeNumber', 'string',30);
  AddField(FcdsNegativeData_notary, 'Cadus', 'string', 50);

  //pefin->summary
  AddField(FcdsNegativeData_notary, 'FirstOccurrence', 'string',10);
  AddField(FcdsNegativeData_notary, 'LastOccurrence', 'string',10);
  AddField(FcdsNegativeData_notary, 'Count', 'integer');
  AddField(FcdsNegativeData_notary, 'Balance', 'float');
  FcdsNegativeData_notary.CreateDataSet;
End;

procedure TConsultaSerasaExperian.CriaCds_Facts_JudgementFilings;
begin
  FcdsFactsJudgementFilings.Close;
  FcdsFactsJudgementFilings.FieldDefs.Clear;
  AddField(FcdsFactsJudgementFilings, 'OccurrenceDate', 'string',10);
  AddField(FcdsFactsJudgementFilings, 'LegalNatureId', 'string', 50);
  AddField(FcdsFactsJudgementFilings, 'LegalNature', 'string', 100);
  AddField(FcdsFactsJudgementFilings, 'Amount', 'float');
  AddField(FcdsFactsJudgementFilings, 'Distributor' ,'string', 100);
  AddField(FcdsFactsJudgementFilings, 'CivilCourt','string', 100);
  AddField(FcdsFactsJudgementFilings, 'Principal', 'boolean');
  AddField(FcdsFactsJudgementFilings, 'Cadus', 'string', 50);

  //JudgementFilings->summary
  AddField(FcdsFactsJudgementFilings, 'FirstOccurrence', 'string',10);
  AddField(FcdsFactsJudgementFilings, 'LastOccurrence', 'string',10);
  AddField(FcdsFactsJudgementFilings, 'Count', 'integer');
  AddField(FcdsFactsJudgementFilings, 'Balance', 'float');

  FcdsFactsJudgementFilings.CreateDataSet;
end;

procedure TConsultaSerasaExperian.CriaCds_Facts_Bankrupts;
begin
  FcdsFactsBankrupts.Close;
  FcdsFactsBankrupts.FieldDefs.Clear;

  //Bankrupts->summary
  AddField(FcdsFactsBankrupts, 'Count', 'integer');
  AddField(FcdsFactsBankrupts, 'Balance', 'float');

  FcdsFactsBankrupts.CreateDataSet;
end;

procedure TConsultaSerasaExperian.CriaCds_Facts_InquiryCompany;
begin
  FcdsFactsInquiryCompany.Close;
  FcdsFactsInquiryCompany.FieldDefs.Clear;
  AddField(FcdsFactsInquiryCompany, 'OccurrenceDate', 'string', 10);
  AddField(FcdsFactsInquiryCompany, 'CompanyName', 'string', 150);
  AddField(FcdsFactsInquiryCompany, 'CompanyDocumentId', 'string', 20);
  AddField(FcdsFactsInquiryCompany, 'CompanyAlias', 'string', 150);
  AddField(FcdsFactsInquiryCompany, 'DaysQuantity', 'integer');
  FcdsFactsInquiryCompany.CreateDataSet;
end;

{procedure TConsultaSerasaExperian.CriaCds_Facts_InquiryQuantityHistorical;
begin
  FcdsInquiryQuantityHistorical.Close;
  FcdsInquiryQuantityHistorical.FieldDefs.Clear;
  AddField(FcdsInquiryQuantityHistorical, 'InquiryDate', 'string', 7); // Ex: 2025-03
  AddField(FcdsInquiryQuantityHistorical, 'Occurrences', 'integer');
  FcdsInquiryQuantityHistorical.CreateDataSet;
end;}

procedure TConsultaSerasaExperian.CriaCds_NegativeSummary;
begin
  FcdsNegativeSummary.Close;
  FcdsNegativeSummary.FieldDefs.Clear;
  AddField(FcdsNegativeSummary, 'negative_message', 'string', 250);
  FcdsNegativeSummary.CreateDataSet;
end;

procedure TConsultaSerasaExperian.LeRetornoeExibeRelatorio(AResponse: String);
Begin

  Try
    LoadFromJson(AResponse);
    ExibirRelatorio();
  Finally
  End;

End;

function TConsultaSerasaExperian.RetornaQuantidadeChequeDevolvido: Integer;
  Var
    LValor : String;
begin
  LValor := FcdsNegativeData_check.FieldByName('COUNT').AsString;

  If fEmptyStr(LValor) Then
     Result := 0
  Else
     Result := StrToInt(LValor);
end;


function TConsultaSerasaExperian.RetornaQuantidadeProtesto: Integer;
  Var
    LValor : String;
begin
  LValor := FcdsNegativeData_notary.FieldByName('COUNT').AsString;

  If fEmptyStr(LValor) Then
     Result := 0
  Else
     Result := StrToInt(LValor);
end;

procedure TConsultaSerasaExperian.AtualizaTotalizadores();
 Var
     iqtdeSocio,
     iqtdeDiretor,
     iqtdeOco_neg : Integer;
Begin

  iqtdeSocio   := FcdsPartnerCompleteReport_Partners.Recordcount;
  iqtdeDiretor := FcdsDirectorCompleteReport_Directors.Recordcount;
  iqtdeOco_neg := FcdsNegativeData_pefin.FieldByName('Count').AsInteger +
                  FcdsNegativeData_refin.FieldByName('Count').AsInteger +
                  FcdsNegativeData_collectionRecords.FieldByName('Count').AsInteger +
                  FcdsFactsBankrupts.FieldByName('Count').AsInteger +
                  FcdsFactsJudgementFilings.FieldByName('Count').AsInteger +
                  FcdsNegativeData_notary.FieldByName('Count').AsInteger +
                  FcdsNegativeData_check.FieldByName('Count').AsInteger;

  FcdsConsulta.Edit;
  FcdsConsulta.FieldByName('QTDE_SOCIOS').AsInteger          := iqtdeSocio;
  FcdsConsulta.FieldByName('QTDE_DIRETORES').AsInteger       := iqtdeDiretor;
  FcdsConsulta.FieldByName('QTDE_OCORRENCIAS_NEG').AsInteger := iqtdeOco_neg;
  FcdsConsulta.Open;
  FcdsConsulta.Post;

End;

end.
