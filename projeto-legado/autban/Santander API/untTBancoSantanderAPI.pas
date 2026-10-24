unit untTBancoSantanderAPI;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
     System.Json, System.DateUtils, System.RegularExpressions,
     Rest.Json, Uni, UniClientDataset, Data.DB,
     untTRestSynalistAutban, untTRegBol, untFuncoesBoleto, untGravando,
     untFuncoesSimples, untTypesSistema, Vcl.Forms, untArqNaoGravados, System.Math;

Type
  TRetornoPesquisaBancoSantanderAPI = class
  public
    id,
    messageField,
    paymentType,
    functionField,
    issueDate,
    paymentDate,
    creditDate,
    bankCode,
    paymentChannel,
    paymentKind,
    covenant,
    typeOfPersonAgreement,
    agreementDocument,
    bankNumber,
    clientNumber,
    participantCode,
    txId,
    payerDocumentType,
    payerDocumentNumber,
    payerName,
    finalBeneficiaryrDocumentType,
    finalBeneficiaryDocumentNumber,
    finalBeneficiaryDocumentName,
    dueDate,
    nominalValue,
    payedValue,
    interestValue,
    fine,
    deductionValue,
    rebateValue,
    iofValue,
    cnpjCliente,

    status,
    statusComplement,

    barCode,
    digitableLine: String;

    nomeDoArquivo,

    Ocorrencia,

    JsonBoleto,

    QrCodeEmv,
    QrCodeLinkCitel: String;
  end;

Type
  TDadosCarteira = Record
    CarteiraBanco,
    EmpresaCarteira,
    CarteiraCompleta,
    CNPJEmpresa,

    LinkApi,
    LinkTokenApi,
    LinkConsulta,
    LinkConsultaEspecifico,
    LinkInclusao,
    LinkBaixa,
    LinkInclusaoWorkSpace,
    LinkAlteracaoWorkSpace,
    LinkConsultaWorkSpace,

    LinkWebhookSantanderCitelGetCertificado,
    LinkWebhookSantanderCitelGetWorkSpaces,
    LinkWebhookSantanderCitelPatchWorkSpace,
    LinkWebhookSantanderCitelPostWorkSpace,
    LinkWebhookSantanderCitelGetBoletos,
    LinkWebhookSantanderCitelEmpresa,

    CodCarteira,
    IdentificacaoBanco,
    CodAgencia,
    ContaCorrente,
    CodCedente,
    Instrucao1,
    Instrucao2,
    Observacao1,
    Observacao2,
    Observacao3,
    Observacao4,
    Observacao5,
    QtdDiasProtesto,
    TipoDiasProtesto,
    QtdDiasCredito,
    PercentualMulta,

    Aceite,
    MostraSacadorAvalista,
    DupAgrupadas,

    WorkSpace,
    GerarQRCodePix,
    ClientId,
    ClientSecret,
    ChavePix,
    AutoIncremChavePix,
    CertificadoPfx,
    SenhaCertificado,

    EnviarSAcadorAvalista,
    NomeBeneficiario,
    EnderecoBeneficiario,
    ComplementoBeneficiario,
    BairroBeneficiario,
    CidadeBeneficiario,
    EstadoBeneficiario,
    CepBeneficiario,
    CNPJBeneficiario: String;

    Homologacao: Boolean;

    DadosChavePix: TUniClientDataSet;
    ConsiderarLiquidacaoPelaDataCredito: Boolean;
  end;

Type
  TBancoSantanderAPI = class(TObject)
  private
    FDadosCarteira: TDadosCarteira;

    FRestSynalist: TRestSynalistAutban;

    FListaRequisicaoRegistroBoleto: TList<TRequisicaoRegistroBoleto>;

    FRetornoBancoSantanderAPI: TRetornoBoletoSantander;

    FFaturamento,
    FTentarNovamente,
    FNossoNumeroDuplicado: Boolean;

    FPercentualMulta,
    FPercentualMora: Double;

    FTokenUsoAtual: String;

    procedure CarregaDadosCarteira(ACarteira: String);
    procedure CarregaDadosCertificado;
    procedure CarregaDadosChavePixDaCarteira;
    procedure CarregaLinksTabela;
    procedure ValidaSeTodosOsLinksEstaoMapeados;

    function PossuiTodosOsDadosParaRealizarAutorizacaoAPI: Boolean;

    //Auxiliares
    function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    function RetornaValorString(AValor: String;
                                ATamanho: Integer;
                                ATiraPonto: Boolean = True): String;

    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
                                             ADadosRetorno: TRetornoBoletoSantander);

    function AtualizaStatusRetornoErro(AStatusAtual: Integer;
                                       AErro: String): Integer;

    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function RetornaValorJsonValue(AObjeto: TJsonValue; ANomeCampo: String): String;
    function RetornaTextoErro(ACodigoRetorno,
                              ADadosRetorno: String): String;

    procedure AguardeCincoSegundos;

    procedure CorrigeDatas(var AValorCampo: String;
                           AProximoDia: Boolean = False;
                           ADiasParaSoma : Integer = 1);

    function UtilizaDescontoDePontualidade(AValDes:Double): Boolean;

    function DuplicataJaCadastradaNoBancoMasNaoAtualizadaPorAlgumErro(ACodigoRetorno: Integer;
                                                                      Var ARetornoPost: String;
                                                                      ADadosDuplicata,
                                                                      ADadosCliente: TDataset;
                                                                      ANossoNumero: String): Boolean;

    function DadosdoBoletoSaoDessaDuplicata(Var ARetornoPost: String;
                                            ANossoNumero: String;
                                            ADadosDuplicata,
                                            ADadosCliente: TDataset): Boolean;
    //End Auxiliares

    //API
    function RetornaWorkspacesAtivasCitel(ACNPJCliente: String): TJsonArray;

    function RetornaDadosInclusaoWorkspaceSantander(ACNPJEmpresa: String): TJsonObject;

    procedure RegistrarWorkspaceWebhookSantander(ARetornoWorkspace,
                                                 ACNPJEmpresa: String);

    function AtualizarWorkspaceAdicionandoConvenio(AJsonWorkspace: TJsonValue;
                                                   ACNPJEmpresa: String): Boolean;

    function RetornaTokenWebhookCitel(AWorkspace: String): String;
    //End API

    //Requisição
    function RetornaDadosDaRequisicao(ADadosDuplicata,
                                      ADadosCliente: TDataset;
                                      ANossoNumero: String;
                                      var ATxIdPix: String): String;

    function RetornaDadosPagadorBoleto(ADadosCliente: TDataset): TJsonObject;
    function RetornaDadosBeneficiarioBoleto: TJsonObject;

    procedure CarregaDescontosBoleto(var AJsonBoleto: TJsonObject;
                                     ADadosDuplicata: TDataset);
    procedure CarregaMultaBoleto(var AJsonBoleto: TJsonObject);
    procedure CarregaJurosMoraBoleto(var AJsonBoleto: TJsonObject);

    procedure CarregaDadosProtestoBoleto(var AJsonBoleto: TJsonObject);

    procedure CarregaDadosChavePixBoleto(var AJsonBoleto: TJsonObject;
                                         var ATxIdPix: String);

    function GerarTxIdBoleto: String;

    function RetornaMensagensBoleto: TJsonArray;

    function RetornaDadosRetornoInclusaoBoleto(ADadosRetorno: String;
                                               ADadosDuplicata: TDataset;
                                               ATxIdPix: String;
                                               AReimpressao: Boolean): TRetornoBoletoSantander;

    function TratarCamposValoresRequisicao(ARequisicao: String): String;
    //End Requisição

    //Alteração
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);

    function DeveLimparOsDadosDoBoletoCancelamento(AStatus: Integer;
                                                   ARetorno: String): Boolean;
    //end alteração

    //Consulta
    function RetornaDadosPesquisaBoletoWebhookCitel(ADadosBoleto: TJsonValue): TRetornoPesquisaBancoSantanderAPI;

    procedure CarregaOcorrenciaBaixa(var ABoleto: TRetornoPesquisaBancoSantanderAPI);

    function RetornaDuplicatasEntradaConfirmada(ADataInicial, ADataFinal: TDateTime): TUniClientDataSet;

    function ConsultaBoletosAPISantander(ADataInicial,
                                         ADataFinal: TDateTime;
                                         var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSantanderAPI>;

    function ConsultaBoletosAPISantanderDuplicata(ADadosDuplicata: TDataset; ANossoNumero: String): String;
    function TransformaJsonBankSplitEmCadastro(ARetornoGet: String): String;

    function RetornaDadosPesquisaBoletoAPISantander(ADadosBoleto: TJsonValue): TRetornoPesquisaBancoSantanderAPI;

    procedure ExibeFormMensagemErro(AMensagem: String);

    function LiquidacaoEhFutura(ACreditDate: String): Boolean;
    //End Consulta
  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    procedure GerarToken;

    procedure GerarWorkspaceSantander;
    function WorkspacePertenceAoClientIdDaCarteiraEEstaAtivo(AWorkSpaceId: String): Boolean;

    procedure ImportarCertificadoCitel;

    function CadastrarNovoBoleto(ADadosDuplicata,
                                 ADadosCliente: TDataSet;
                                 Var ANosNum: String): TRetornoBoletoSantander;

    procedure ReimpressaoDeBoleto(AAutoIncrem: String);

    procedure CancelarBoletos(ADataSet:TDataSet);

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: TDateTime;
                                       AProgresso: TfrmGravando;
                                       AAPICitel: Boolean = False): TList<TRetornoPesquisaBancoSantanderAPI>;

    procedure GravarDadosRequisicaoRegistroBoleto;

    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoSantanderAPI;
                                              out ADuplicata: TDuplicataCtr): Boolean;

    procedure ValidarDadosAutorizacao;

    property RetornoBancoSantanderAPI: TRetornoBoletoSantander read FRetornoBancoSantanderAPI write FRetornoBancoSantanderAPI;

    property PercentualMulta: Double    Read FPercentualMulta  Write FPercentualMulta;
    property PercentualMora: Double    Read FPercentualMora   Write FPercentualMora;

    property Faturamento: Boolean Read FFaturamento Write FFaturamento;
    property TentarNovamente: Boolean Read FTentarNovamente Write FTentarNovamente;

    property NossoNumeroDuplicado: Boolean read FNossoNumeroDuplicado write FNossoNumeroDuplicado;
  end;

implementation
Uses untFuncAutban, untLogCtr, untTFuncoesAuxiliaresPix;
{ TBancoSantanderAPI }

procedure TBancoSantanderAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TBancoSantanderAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
  ADadosRetorno: TRetornoBoletoSantander);
  Var
    LCadRec: TUniQuery;

    LSql: String;
begin
  Try
    LCadRec := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE    ';
    LSql := LSql + '  CADREC  ';
    LSql := LSql + 'SET ';
    LSql := LSql + '  CTR_BCOENV = :CODBCO, ';
    LSql := LSql + '  CTR_DTAENV = ' + fCurrentDate + ', ';
    LSql := LSql + '  CTR_TX_BOL = :TX_BOL, ';
    LSql := LSql + '  CTR_QRCODE = :QRCODE, ';
    LSql := LSql + '  CTR_PIXLOC = :PIXLOC, ';
    LSql := LSql + '  CTR_ID_BOL = :ID_BOL, ';
    LSql := LSql + '  CTR_LNKCIT = :LNKCIT ';
    LSql := LSql + 'WHERE ';
    LSql := LSql + '  AUTOINCREM = :AUTINC ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);
      LCadRec.ParamByName('CODBCO').AsString := '033';

      If Not ADadosRetorno.QrCodeTxId.IsEmpty Then
      Begin
        LCadRec.ParamByName('TX_BOL').AsString := ADadosRetorno.QrCodeTxId;
        LCadRec.ParamByName('QRCODE').AsString := ADadosRetorno.QrCodeEmv;
        LCadRec.ParamByName('PIXLOC').AsString := ADadosRetorno.QrCodeUrl;
        LCadRec.ParamByName('LNKCIT').AsString := ADadosRetorno.QrCodeLinkCitel;
      End;

      LCadRec.ParamByName('ID_BOL').AsString := ADadosRetorno.idBoleto;

      LCadRec.ParamByName('AUTINC').AsString := ACadRec.FieldByName('AUTOINCREM').AsString;
      LCadRec.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    LCadrec.Close;

    FreeAndNil(LCadRec);
  End;
end;

function TBancoSantanderAPI.AtualizarWorkspaceAdicionandoConvenio(
  AJsonWorkspace: TJsonValue; ACNPJEmpresa: String): Boolean;
  Var
    LJsonConvenios: TJsonArray;

    LJsonItem,
    LJsonRequisicao: TJsonObject;

    LParametros,
    LConveniosCadastrados: TStringList;

    LStatus: Integer;

    LConvenio,
    LRetornoPost,
    LRetornoCitel: String;
begin
  Result := False;

  LParametros := TStringList.Create;

  LConveniosCadastrados := TStringList.Create;
  LConveniosCadastrados.Delimiter := ',';
  LConveniosCadastrados.StrictDelimiter := True;

  Try
    LConveniosCadastrados.DelimitedText := RetornaValorJsonValue(AJsonWorkspace, 'convenios');
    LConveniosCadastrados.Add(FDadosCarteira.CodCedente);

    LJsonConvenios := TJsonArray.Create;
    For LConvenio In LConveniosCadastrados Do
    Begin
      LJsonItem := TJsonObject.Create;
      LJsonItem.AddPair('code', LConvenio);

      LJsonConvenios.Add(LJsonItem);
    End;

    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);

      LJsonRequisicao := TJsonObject.Create;
      LJsonRequisicao.AddPair('covenants', LJsonConvenios);

      LStatus := FRestSynalist.ExecuteRestSynalist('PATCH',
                                                   FDadosCarteira.LinkAlteracaoWorkSpace.Replace('[WORKSPACE]', RetornaValorJsonValue(AJsonWorkspace, 'id')),
                                                   LParametros,
                                                   LRetornoPost,
                                                   LJsonRequisicao.ToJSON);

      FreeAndNIl(LJsonRequisicao);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      LParametros.Clear;

      LParametros.Add('WebHookSantanderAuthorizationCitel: ' + RetornaTokenWebhookCitel(RetornaValorJsonValue(AJsonWorkspace, 'id')));
      LParametros.Add('WebHookSantanderWorkspace: ' + RetornaValorJsonValue(AJsonWorkspace, 'id'));

      LParametros.Add('convenios: ' + LConveniosCadastrados.CommaText.Replace('''', EmptyStr));
      LParametros.Add('operador: ' + strLoginUsuarioLogado);

      LRetornoPost := '{"jsonRecebido": "' + LRetornoPost + '"}';

      LStatus := FRestSynalist.ExecuteRestSynalist('PATCH',
                                                   FDadosCarteira.LinkWebhookSantanderCitelPatchWorkSpace.Replace('[CNPJ_EMPRESA]', ACNPJEmpresa)
                                                                                                         .Replace('[WORKSPACE_ID]', RetornaValorJsonValue(AJsonWorkspace, 'id')),
                                                   LParametros,
                                                   LRetornoCitel,
                                                   LRetornoPost,
                                                   EmptyStr,
                                                   False);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoCitel);

      Result := True;
    Except
      Raise;
    End;
  Finally
    FreeAndNil(LConveniosCadastrados);
    FreeAndNil(LParametros);
  End;

end;

function TBancoSantanderAPI.AtualizaStatusRetornoErro(AStatusAtual: Integer;
  AErro: String): Integer;
  Var
    LJSonObject: TJsonObject;
begin
  Result := AStatusAtual;

  If AErro.IsEmpty Then
    Exit;

  Try
    LJSonObject := TJSONObject.ParseJSONValue(AErro) As TJsonObject;

    If LJSonObject = Nil Then
      Exit;

    If LJSonObject.GetValue('_errorCode') = Nil Then
      Exit;

    If Not RetornaValorJson(LJsonObject, '_errorCode').IsEmpty Then
      Exit(StrToInt(RetornaValorJson(LJsonObject, '_errorCode')));
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoSantanderAPI.BaixaBoletoRegistrado(ADataSet: TDataSet);
  Var
    LRetorno,
    LDadosRequisicao: String;

    LRequisicaoAlteraBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;
    LCodConvInt : Integer;
begin
  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  FDadosCarteira.CarteiraCompleta;
  LRequisicaoAlteraBoleto.LCodBco := '033';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  If Not TryStrToInt(FDadosCarteira.CodCedente, LCodConvInt) Then
    Raise ExceptionAutcom.Create('O Convênio do Cedente deve possuir apenas números.');

  LDadosRequisicao := '{"covenantCode": "' + IntToStr(LCodConvInt) + '", ' +
                      ' "bankNumber": "' + ADataSet.FieldByName('CTR_NOSNUM').AsString + '", ' +
                      ' "operation": "BAIXAR" }';

  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := FDadosCarteira.LinkBaixa.Replace('[WORKSPACE]', FDadosCarteira.WorkSpace);

  LParametros := TStringList.Create;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);

      FRestSynalist.StatusSemRaise := [204];

      LStatus := FRestSynalist.ExecuteRestSynalist('PATCH',
                                                   LRequisicaoAlteraBoleto.LLnkApi,
                                                   LParametros,
                                                   LRetorno,
                                                   LDadosRequisicao);

      If Not MatchStr(LStatus.ToString, ['204', '200', '201']) Then
        Raise Exception.Create(LRetorno);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetorno;

      If DeveLimparOsDadosDoBoletoCancelamento(LStatus, LRetorno) Then
      Begin
        fStartTransaction;
        untFuncAutban.LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                              'CANCELAMENTO DE BOLETO - BANCO SANTANDER [ONLINE]',
                              'untTBancoSantanderAPI');
        fCommit;


        If Not fEmptyStr(ADataSet.FieldByName('CTR_LNKCIT').AsString) Then
          TFuncoesPixBoleto.RemoverLinkCitelPixBoleto(fRetCGCEmpresa(ADataSet.FieldByName('CTR_CODEMP').AsString),
                                                      ADataSet.FieldByName('CTR_CODEMP').AsString,
                                                      ADataSet.FieldByName('CTR_TX_BOL').AsString,
                                                      FDadosCarteira.AutoIncremChavePix,
                                                      True);
      End
      Else
        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, LRetorno));
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');

        Raise Exception.Create(RetornaTextoErro('', E.Message));
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    FListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
    GravarDadosRequisicaoRegistroBoleto;

    FRestSynalist.StatusSemRaise := [];
  End;
end;

function TBancoSantanderAPI.CadastrarNovoBoleto(ADadosDuplicata,
  ADadosCliente: TDataSet; var ANosNum: String): TRetornoBoletoSantander;
  Var
    LTxIdPix,
    LLinkInclusao,
    LRetornoPost,
    LDadosRequisicao: String;

    LRequisicaoRegistroBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;

    LBoletoJaRegistrado: Boolean;
begin
  Self.FTentarNovamente := True;
  Result := TRetornoBoletoSantander.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  FDadosCarteira.CarteiraBanco + '-' +  FDadosCarteira.EmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '033';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.FFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente, ANosNum, LTxIdPix);
  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := FDadosCarteira.LinkInclusao.Replace('[WORKSPACE]', FDadosCarteira.WorkSpace);
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;

  LParametros := TStringList.Create;

  LBoletoJaRegistrado := False;

  Try
    Repeat
      Try
        If Not LBoletoJaRegistrado Then
        Begin
          GerarToken;

          LParametros.Add('Authorization: ' + FTokenUsoAtual);
          LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);

          LLinkInclusao := FDadosCarteira.LinkInclusao.Replace('[WORKSPACE]', FDadosCarteira.WorkSpace);

          LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                       LLinkInclusao,
                                                       LParametros,
                                                       LRetornoPost,
                                                       LDadosRequisicao);

          If Not MatchStr(LStatus.ToString, ['200', '201']) Then
            Raise Exception.Create(LRetornoPost);
        End;

        Self.FTentarNovamente := False;

        LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

        Result := RetornaDadosRetornoInclusaoBoleto(LRetornoPost,
                                                    ADadosDuplicata,
                                                    LTxIdPix,
                                                    False);

        If Result.QrCodeTxId.IsEmpty Then
          Result.QrCodeTxId := LTxIdPix;

        ANosNum := Result.nossoNumero;

        AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                       Result);

        LBoletoJaRegistrado := False;
      Except

        On E: Exception Do
        Begin
          LRequisicaoRegistroBoleto.LExcept := E.Message;

          LStatus := AtualizaStatusRetornoErro(LStatus,
                                               E.Message);

          LBoletoJaRegistrado := DuplicataJaCadastradaNoBancoMasNaoAtualizadaPorAlgumErro(LStatus, LRetornoPost, ADadosDuplicata, ADadosCliente, ANosNum);
          If Not LBoletoJaRegistrado Then
            Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
        End;

      End;
    Until(Not LBoletoJaRegistrado);
  Finally
    FListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
    FreeAndNil(LParametros);
  End;
end;

procedure TBancoSantanderAPI.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes: String;

    LErroAPI: Boolean;

    LContadorTentativas: Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;


    While (LContadorTentativas <= 2) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          BaixaBoletoRegistrado(ADataSet);

          ADataSet.Next;

          pStep(frmGravandoGenericProcedure.pgbStatus);
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin
          LErroAPI := True;


          If (LContadorTentativas >= 2) Then
          Begin
            LDocumentosRestantes := '';

            While Not ADataSet.Eof Do
            Begin
              LDocumentosRestantes := LDocumentosRestantes + ADataSet.FieldByName('CTR_NUMDUP').AsString +
                                                             ADataSet.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                             ADataSet.FieldByName('CTR_CODEMP').AsString + ', ';
              ADataSet.Next;
            End;

            LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

            ExibeFormMensagemErro('Ocorreram erros ao cancelar o(s) boleto(s) no Banco Santander [Online].' + #13#10 + E.Message + #13#10 +
                                  'Documento(s) ficaram sem cancelar o boleto: ' + LDocumentosRestantes);

          End;

          Inc(LContadorTentativas);
        End;
      End;


      If Not LErroAPI Then
      Begin
        pMensagemOk('Cancelamento realizado com sucesso!');
        Break;
      End;
    End;

    frmGravandoGenericProcedure.pgbStatus.Visible := False;
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End
end;

procedure TBancoSantanderAPI.CarregaDadosCarteira(ACarteira: String);
var
  LConsiderarLiquidacaoPelaDataCredito: String;
begin
  FDadosCarteira.CarteiraBanco := LeftStr(ACarteira,14);
  FDadosCarteira.EmpresaCarteira := RightStr(ACarteira, 3);
  FDadosCarteira.CarteiraCompleta := ACarteira;

  FDadosCarteira.CNPJEmpresa := fTiraCaracEspeciais(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [FDadosCarteira.EmpresaCarteira]));

  FDadosCarteira.CodCarteira         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODCART','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.IdentificacaoBanco  := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'IDENTBC','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CodAgencia          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODAGEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CodCedente          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCTAC','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ContaCorrente       := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCTAB','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Instrucao1          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'INSTRU1','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Instrucao2          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'INSTRU2','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao1         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV1','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao2         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV2','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao3         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV3','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao4         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV4','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao5         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV5','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Aceite              := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PROACEI','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.MostraSacadorAvalista:= fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'MSACAVA','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EnviarSAcadorAvalista:= fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ENVSACA','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.QtdDiasProtesto     := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIAPROT','0', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasCredito      := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIACRED','0', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.PercentualMulta     := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PERMULT','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.TipoDiasProtesto    := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'TIPDIA','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.AutoIncremChavePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CHAPIX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.GerarQRCodePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'GERAPIX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ClientId := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_ID','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ClientSecret := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_SECRET','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Homologacao := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'HOMOLOGACAO','', FDadosCarteira.EmpresaCarteira) = 'S';

  FDadosCarteira.NomeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EnderecoBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.BairroBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ComplementoBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CidadeBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EstadoBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CepBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CNPJBeneficiario := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NOMEBEN','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.WorkSpace := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'WORKSPACE','', FDadosCarteira.EmpresaCarteira);

  If Not fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'EMPCONV','', FDadosCarteira.EmpresaCarteira).IsEmpty Then
    FDadosCarteira.CNPJEmpresa := fTiraCaracEspeciaisPonto(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'EMPCONV','', FDadosCarteira.EmpresaCarteira)]));

  LConsiderarLiquidacaoPelaDataCredito := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DTACRED','', FDadosCarteira.EmpresaCarteira);
  If Not fEmptyStr(LConsiderarLiquidacaoPelaDataCredito) Then
    FDadosCarteira.ConsiderarLiquidacaoPelaDataCredito := LConsiderarLiquidacaoPelaDataCredito = 'S'
  Else
    FDadosCarteira.ConsiderarLiquidacaoPelaDataCredito := True;

  CarregaLinksTabela;

  CarregaDadosCertificado;

  CarregaDadosChavePixDaCarteira;

  FRestSynalist.CarregaCertificados(FDadosCarteira.CarteiraCompleta,
                                    FDadosCarteira.CertificadoPfx,
                                    EmptyStr,
                                    EmptyStr,
                                    FDadosCarteira.SenhaCertificado);
end;

procedure TBancoSantanderAPI.CarregaDadosChavePixBoleto(
  var AJsonBoleto: TJsonObject; var ATxIdPix: String);
  Var
    LJsonKey: TJsonObject;
begin
  ATxIdPix := EmptyStr;

  If Not FDadosCarteira.GerarQRCodePix.Equals('S') Then
    Exit;

  If FDadosCarteira.DadosChavePix.IsEmpty Then
    Exit;

  LJsonKey := TJsonObject.Create;

  If FDadosCarteira.DadosChavePix.FieldByName('PIX_TIPCHV').AsString.Equals('CNPJ-CPF') Then
  Begin
    If FDadosCarteira.DadosChavePix.FieldByName('PIX_CHAVE_').AsString.Length < 14 Then
      LJsonKey.AddPair('type', 'CPF')
    Else
      LJsonKey.AddPair('type', 'CNPJ');
  End
  Else If FDadosCarteira.DadosChavePix.FieldByName('PIX_TIPCHV').AsString.Equals('EMAIL') Then
    LJsonKey.AddPair('type', 'EMAIL')
  Else If FDadosCarteira.DadosChavePix.FieldByName('PIX_TIPCHV').AsString.Equals('CELULAR') Then
    LJsonKey.AddPair('type', 'CELULAR')
  Else
    LJsonKey.AddPair('type', 'EVP');

  LJsonKey.AddPair('dictKey', FDadosCarteira.DadosChavePix.FieldByName('PIX_CHAVE_').AsString);

  AJsonBoleto.AddPair('key', LJsonKey);

  ATxIdPix := GerarTxIdBoleto;
  AJsonBoleto.AddPair('txId', ATxIdPix);
end;

procedure TBancoSantanderAPI.CarregaDadosChavePixDaCarteira;
  Var
    LConsulta: TUniQuery;
begin
  If Not FDadosCarteira.GerarQRCodePix.Equals('S') Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM CCAPIX ' +
                          'WHERE AUTOINCREM="' + FDadosCarteira.AutoIncremChavePix + '" ' +
                          '  AND PIX_ATIVA_<>"N" ';

    LConsulta.Open;

    FDadosCarteira.DadosChavePix := fCriaClientDatset(LConsulta);
    FDadosCarteira.DadosChavePix.Open;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TBancoSantanderAPI.CarregaDadosProtestoBoleto(
  var AJsonBoleto: TJsonObject);
begin
  If FDadosCarteira.Instrucao1.Equals('00') Then
    Exit;

  If FDadosCarteira.Instrucao1.Equals('07') Then
  Begin
    AJsonBoleto.AddPair('protestType', 'SEM_PROTESTO');
    Exit;
  End;

  If FDadosCarteira.TipoDiasProtesto.Equals('1') Then
    AJsonBoleto.AddPair('protestType', 'DIAS_UTEIS')
  Else
    AJsonBoleto.AddPair('protestType', 'DIAS_CORRIDOS');

  AJsonBoleto.AddPair('protestQuantityDays', FDadosCarteira.QtdDiasProtesto);
end;

procedure TBancoSantanderAPI.CarregaDadosCertificado;
  Var
    LConsulta: TUniQuery;

    LTentarNovamente: Boolean;

    LContadorTentativas: Integer;
begin
  LContadorTentativas := 1;

  LConsulta := Nil;

  Try
    Repeat
      LTentarNovamente := False;

      FreeAndNilDatasets(LConsulta);

      LConsulta := fCriaQuery;
      LConsulta.SQL.Text := 'SELECT CER_ARQPFX, ' +
                            '       CER_SENCER  ' +
                            'FROM ATBCER ' +
                            'WHERE CER_CODBCO="033" ' +
                            'ORDER BY CER_VALCER DESC';

      LConsulta.Open;

      If LConsulta.isEmpty Then
      Begin
        TfrmGravando.fExecutarModal(ImportarCertificadoCitel, 'Aguarde... Importando dados.', '');

        LTentarNovamente := True;
        Inc(LContadorTentativas);
        Continue;
      End
    Until((Not LTentarNovamente) Or (LContadorTentativas >= 3));

    FDadosCarteira.CertificadoPfx := LConsulta.FieldByName('CER_ARQPFX').AsString;
    FDadosCarteira.SenhaCertificado := fDecrypt(LConsulta.FieldByName('CER_SENCER').AsString);
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TBancoSantanderAPI.CarregaDescontosBoleto(var AJsonBoleto: TJsonObject;
  ADadosDuplicata: TDataset);
  Var
    LDescontoSugerido,
    LDescontoPontualidade: Double;

    LDataDesconto: TDateTime;

    LUtilizaDescontos: Boolean;

    LJsonDescontos,
    LJsonDesconto1,
    LJsonDesconto2: TJsonObject;

    LCampoCriar: String;
begin
  LDescontoSugerido := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat;

  If fCfgSis('DESBOL', varBoolean, FDadosCarteira.EmpresaCarteira) Then
    LDescontoSugerido := 0.00;

  LUtilizaDescontos := LDescontoSugerido > 0;

  LDataDesconto := 0;
  LDescontoPontualidade := 0;

  If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) Then
  Begin
    LDescontoPontualidade := ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat;

    If LDescontoPontualidade > 0 Then
    Begin
      LDataDesconto := IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                              -ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

      LUtilizaDescontos := True;
    End;
  End;

  If Not LUtilizaDescontos Then
    Exit;

  LJsonDescontos := TJsonObject.Create;
  LJsonDescontos.AddPair('type', 'VALOR_DATA_FIXA');

  LCampoCriar := 'discountOne';

  If LDescontoSugerido > 0 Then
  Begin
    LJsonDesconto1 := TJsonObject.Create;

    LJsonDesconto1.AddPair('value', FormatFloat('0.00', LDescontoSugerido).Replace(',', '.'));
    LJsonDesconto1.AddPair('limitDate', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

    LJsonDescontos.AddPair(LCampoCriar, LJsonDesconto1);

    LCampoCriar := 'discountTwo';
  End;

  If LDescontoPontualidade > 0 Then
  Begin
    LJsonDesconto2 := TJsonObject.Create;

    LDescontoPontualidade := fFormataFloat(RetornaValorDuplicata(ADadosDuplicata) *
                                           (LDescontoPontualidade / 100), 2);

    LJsonDesconto2.AddPair('value', FormatFloat('0.00', LDescontoPontualidade).Replace(',', '.'));
    LJsonDesconto2.AddPair('limitDate', FormatDateTime('yyyy-mm-dd', LDataDesconto));

    LJsonDescontos.AddPair(LCampoCriar, LJsonDesconto2);
  End;

  AJsonBoleto.AddPair('discount', LJsonDescontos);
end;

procedure TBancoSantanderAPI.CarregaJurosMoraBoleto(
  var AJsonBoleto: TJsonObject);
begin
  If fFormataFloat(Self.FPercentualMora, 3) = 0 Then
    Exit;

  AJsonBoleto.AddPair('interestPercentage', FormatFloat('0.00', fFormataFloat(Self.FPercentualMora, 2)).Replace(',', '.'));
end;

procedure TBancoSantanderAPI.CarregaMultaBoleto(var AJsonBoleto: TJsonObject);
begin
  If Self.FPercentualMulta = 0 Then
    Self.FPercentualMulta := fStrToFloat(FDadosCarteira.PercentualMulta);

  If Self.FPercentualMulta = 0 Then
    Exit;

  AJsonBoleto.AddPair('finePercentage', FormatFloat('0.00', Self.FPercentualMulta).Replace(',', '.'));
  AJsonBoleto.AddPair('fineQuantityDays', TJSONNumber.Create(0));
end;

procedure TBancoSantanderAPI.CarregaOcorrenciaBaixa(
  var ABoleto: TRetornoPesquisaBancoSantanderAPI);
begin
  ABoleto.Ocorrencia := '99';

  If ABoleto.functionField.Equals('PAGAMENTO') Then
    ABoleto.Ocorrencia := '06'
  Else If ABoleto.functionField.Equals('ENTRADA') Then
    ABoleto.Ocorrencia := '02'
  Else If Not ABoleto.paymentKind.IsEmpty Then
    ABoleto.Ocorrencia := '06';
end;

function TBancoSantanderAPI.ConsultaBoletosAPISantander(ADataInicial,
  ADataFinal: TDateTime; var AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSantanderAPI>;
  Var
    LStatus,
    LPaginaAtual,
    LTotalPaginas: Integer;

    LParametros: TStringList;

    LRetornoGet,
    LLinkConsulta: String;

    LJsonRetorno,
    LJsonObject: TJsonObject;

    LJsonBoletos: TJsonArray;

    LBoleto: TJsonValue;

    LRegistro: TRetornoPesquisaBancoSantanderAPI;

    LDatasetEntradas: TUniClientDataset;

    LValorDuplicata: Double;
    LTotalElements: Integer;
    LTotalRecuperado: Integer;
    LLimitConsulta : Integer;
begin
  Result := TList<TRetornoPesquisaBancoSantanderAPI>.Create;

  LParametros := TStringList.Create;

  Try
    Try
      AProgresso.lblGravando.Caption := 'Aguarde... Filtrando registros.';
      AProgresso.pgbStatus.Visible := False;
      Application.ProcessMessages;

      LPaginaAtual := 0;
      LTotalPaginas := 0;
      LTotalElements := 0;
      LTotalRecuperado := 0;
      LLimitConsulta := 50;

      Repeat
        LParametros.Clear;

        GerarToken;

        LParametros.Add('Authorization: ' + FTokenUsoAtual);
        LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);

        LLinkConsulta := FDadosCarteira.LinkConsulta.Replace('[WORKSPACE]', FDadosCarteira.WorkSpace)
                                                    .Replace('[STATUS]', 'LIQUIDADO');
        LLinkConsulta := LLinkConsulta + '&paymentDateInitial=' + FormatDateTime('yyyy-mm-dd', ADataInicial) +
                                         '&paymentDateFinal=' + FormatDateTime('yyyy-mm-dd', ADataFinal) +
                                         '&_offset=' + IntToStr(LTotalRecuperado);

        LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                     LLinkConsulta,
                                                     LParametros,
                                                     LRetornoGet);

        If Not MatchStr(LStatus.ToString, ['200']) Then
          Raise Exception.Create(LRetornoGet);

        If Pos('_pageable',LRetornoGet) <= 0 Then
          Exit;

        LJSonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJsonObject;

        LJsonObject := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('_pageable').ToJson) as TJsonObject;

        If Not TryStrToInt(LJsonObject.GetValue<String>('_totalElements'), LTotalElements) Then
          LTotalElements := 0;

        If Not TryStrToInt(LJsonObject.GetValue<String>('_totalPages'), LTotalPaginas) Then
        begin
          LTotalPaginas := 1;

          if LTotalElements > 0 then
            LTotalPaginas := Ceil(LTotalElements / LLimitConsulta);
        end;

        LJsonBoletos := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('_content').ToJson) as TJsonArray;

        If LJsonBoletos <> Nil Then
        Begin
          For LBoleto In LJsonBoletos Do
          Begin
            LRegistro := RetornaDadosPesquisaBoletoAPISantander(LBoleto);

            If LiquidacaoEhFutura(LRegistro.creditDate) Then
            Begin
              FreeAndNil(LRegistro);
              Continue;
            End;

            Result.Add(LRegistro);
          End;
        End;

        FreeAndNil(LJSonRetorno);

        Inc(LPaginaAtual);
        LTotalRecuperado := LTotalRecuperado + LLimitConsulta;

      Until(LPaginaAtual >= LTotalPaginas);

      LDatasetEntradas := RetornaDuplicatasEntradaConfirmada(ADataInicial, ADataFinal);
      While Not LDatasetEntradas.Eof Do
      Begin
        LValorDuplicata := LDatasetEntradas.FieldByName('CTR_VALDUP').AsFloat;
        If fFormataFloat(LValorDuplicata, 2) = 0.00 Then
          LValorDuplicata := LDatasetEntradas.FieldByName('CTR_VALANT').AsFloat;

        LRegistro := TRetornoPesquisaBancoSantanderAPI.Create;
        LRegistro.bankNumber := LDatasetEntradas.FieldByName('CTR_NOSNUM').AsString;
        LRegistro.issueDate := FormatDateTime('yyyy-mm-dd', LDatasetEntradas.FieldByName('CTR_DTAENV').AsDateTime);
        LRegistro.dueDate := FormatDateTime('yyyy-mm-dd', LDatasetEntradas.FieldByName('CTR_DTAVEN').AsDateTime);
        LRegistro.participantCode := LDatasetEntradas.FieldByName('CTR_NUMDUP').AsString +
                                     fPadR(LDatasetEntradas.FieldByName('CTR_PARCEL').AsString, 3) +
                                     LDatasetEntradas.FieldByName('CTR_ESPDOC').AsString +
                                     LDatasetEntradas.FieldByName('CTR_CODEMP').AsString;
        LRegistro.nominalValue := FormatFloat(',0.00', LValorDuplicata)
                                         .Replace('.', EmptyStr)
                                         .Replace(',', '.');
        LRegistro.Ocorrencia := '02';

        CorrigeDatas(LRegistro.issueDate);
        CorrigeDatas(LRegistro.dueDate);

        Result.Add(LRegistro);

        LDatasetEntradas.Next;
      End;

      LDatasetEntradas.Close;

      FreeAndNil(LDatasetEntradas);
    Except
      On E: Exception Do
      Begin
         Raise Exception.Create(RetornaTextoErro('', E.Message));
      End;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoSantanderAPI.ConsultaBoletosAPISantanderDuplicata(
  ADadosDuplicata: TDataset; ANossoNumero: String): String;
  Var
    LStatus,
    LTesteCedente: Integer;

    LParametros: TStringList;

    LRetornoGet,
    LLinkConsulta: String;

    LJsonRetorno: TJsonObject;
begin
  Result := EmptyStr;

  LParametros := TStringList.Create;

  LJSonRetorno := Nil;

  Try
    Try
      LParametros.Clear;

      If Not TryStrToInt(FDadosCarteira.CodCedente, LTesteCedente) Then
        Raise Exception.Create('Código do Cedente configurado de forma incorreta na carteira.' + #13 +
                               'Ajuste a configuração da carteira e tente novamente.');

      GerarToken;

      LParametros.Add('Authorization: ' + FTokenUsoAtual);
      LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);

      LLinkConsulta := FDadosCarteira.LinkConsultaEspecifico.Replace('[CONVENIO]', StrToInt(FDadosCarteira.CodCedente).ToString)
                                                            .Replace('[NOSSO_NUMERO]', ANossoNumero);

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkConsulta,
                                                   LParametros,
                                                   LRetornoGet);

      If Not MatchStr(LStatus.ToString, ['200']) Then
        Raise Exception.Create(LRetornoGet);

      LJSonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJsonObject;

      If LJSonRetorno <> Nil Then
      Begin
        If RetornaValorJson(LJSonRetorno, 'status').Equals('ATIVO') Then
          Exit(TransformaJsonBankSplitEmCadastro(LRetornoGet));
      End;
    Except
      On E: Exception Do
        Raise Exception.Create(RetornaTextoErro('', E.Message));
    End;
  Finally
    FreeAndNil(LParametros);

    If Assigned(LJSonRetorno) Then
      FreeAndNil(LJSonRetorno);
  End;
end;

function TBancoSantanderAPI.ConsultaBoletosPorPeriodo(ADataInicial,
  ADataFinal: TDateTime; AProgresso: TfrmGravando;
  AAPICitel: Boolean = False): TList<TRetornoPesquisaBancoSantanderAPI>;
  Var
    LStatus,
    LPagina,
    LTotalPaginas: Integer;

    LValorDuplicata: Double;

    LParametros: TStringList;

    LRetornoGet: String;

    LJsonRetorno: TJsonObject;

    LJsonBoletos: TJsonArray;

    LBoleto: TJsonValue;

    LRegistro: TRetornoPesquisaBancoSantanderAPI;

    LDatasetEntradas: TUniClientDataset;
begin
  //Separado pois o Santander informou que futuramente terá pesquisa por período direto na API do Banco.
  If Not AAPICitel Then
    Exit(ConsultaBoletosAPISantander(ADataInicial, ADataFinal, AProgresso));

  Result := TList<TRetornoPesquisaBancoSantanderAPI>.Create;

  LParametros := TStringList.Create;

  Try
    Try
      AProgresso.lblGravando.Caption := 'Aguarde... Filtrando registros.';
      AProgresso.pgbStatus.Visible := False;
      Application.ProcessMessages;

      LPagina := 0;

      Repeat
        LParametros.Add('WebHookSantanderAuthorizationCitel: ' + RetornaTokenWebhookCitel(FDadosCarteira.Workspace));
        LParametros.Add('WebHookSantanderWorkspace: ' + FDadosCarteira.Workspace);

        LParametros.Add('cnpjCliente: ' + FDadosCarteira.CNPJEmpresa);
        LParametros.Add('convenio: ' + FDadosCarteira.CodCedente);
        LParametros.Add('dataInicial: ' + FormatDateTime('yyyy-mm-dd', ADataInicial));
        LParametros.Add('dataFinal: ' + FormatDateTime('yyyy-mm-dd', ADataFinal));

        LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                     FDadosCarteira.LinkWebhookSantanderCitelGetBoletos.Replace('[PAGINA]', LPagina.ToString),
                                                     LParametros,
                                                     LRetornoGet,
                                                     EmptyStr,
                                                     EmptyStr,
                                                     False);

        If Not MatchStr(LStatus.ToString, ['200']) Then
          Raise Exception.Create(LRetornoGet);

        LJSonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJsonObject;

        LTotalPaginas := LJSonRetorno.GetValue<Integer>('totalPages');

        LJsonBoletos := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('content').ToJson) as TJsonArray;

        For LBoleto In LJsonBoletos Do
        Begin
          LRegistro := RetornaDadosPesquisaBoletoWebhookCitel(LBoleto);

          Result.Add(LRegistro);
        End;

        FreeAndNil(LJSonRetorno);

        Inc(LPagina);
      Until(LPagina >= LTotalPaginas);

      LDatasetEntradas := RetornaDuplicatasEntradaConfirmada(ADataInicial, ADataFinal);
      While Not LDatasetEntradas.Eof Do
      Begin
        LValorDuplicata := LDatasetEntradas.FieldByName('CTR_VALDUP').AsFloat;
        If fFormataFloat(LValorDuplicata, 2) = 0.00 Then
          LValorDuplicata := LDatasetEntradas.FieldByName('CTR_VALANT').AsFloat;

        LRegistro := TRetornoPesquisaBancoSantanderAPI.Create;
        LRegistro.bankNumber := LDatasetEntradas.FieldByName('CTR_NOSNUM').AsString;
        LRegistro.issueDate := FormatDateTime('yyyy-mm-dd', LDatasetEntradas.FieldByName('CTR_DTAENV').AsDateTime);
        LRegistro.dueDate := FormatDateTime('yyyy-mm-dd', LDatasetEntradas.FieldByName('CTR_DTAVEN').AsDateTime);
        LRegistro.participantCode := LDatasetEntradas.FieldByName('CTR_NUMDUP').AsString +
                                     fPadR(LDatasetEntradas.FieldByName('CTR_PARCEL').AsString, 3) +
                                     LDatasetEntradas.FieldByName('CTR_ESPDOC').AsString +
                                     LDatasetEntradas.FieldByName('CTR_CODEMP').AsString;
        LRegistro.nominalValue := FormatFloat(',0.00', LValorDuplicata)
                                         .Replace('.', EmptyStr)
                                         .Replace(',', '.');
        LRegistro.Ocorrencia := '02';

        CorrigeDatas(LRegistro.issueDate);
        CorrigeDatas(LRegistro.dueDate);

        Result.Add(LRegistro);

        LDatasetEntradas.Next;
      End;

      LDatasetEntradas.Close;

      FreeAndNil(LDatasetEntradas);
    Except
      Raise;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TBancoSantanderAPI.CorrigeDatas(var AValorCampo: String;
                           AProximoDia: Boolean = False;
                           ADiasParaSoma : Integer = 1);
  Var
    LValorData: TDateTime;
begin
  If AValorCampo.IsEmpty Then
    Exit;

  If TryStrToDateTime(Concat(AValorCampo.Substring(8, 2), '/',
                             AValorCampo.Substring(5, 2), '/',
                             AValorCampo.Substring(0, 4)),
                      LValorData) Then
  Begin
    If AProximoDia Then
      LValorData := IncDay(LValorData, ADiasParaSoma);

    AValorCampo := DateToStr(LValorData);
  End;
end;

constructor TBancoSantanderAPI.Create(ACarteira: String);
begin
  FRestSynalist := TRestSynalistAutban.Create;

  CarregaDadosCarteira(ACarteira);
  FListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  FRetornoBancoSantanderAPI := TRetornoBoletoSantander.Create;

  FNossoNumeroDuplicado := False;
end;

function TBancoSantanderAPI.DadosdoBoletoSaoDessaDuplicata(
  var ARetornoPost: String; ANossoNumero: String; ADadosDuplicata,
  ADadosCliente: TDataset): Boolean;
  Var
    LJsonRetorno: String;

    LBoleto,
    LPayer: TJsonObject;
begin
  Result := False;

  LJsonRetorno := ConsultaBoletosAPISantanderDuplicata(ADadosDuplicata,
                                                       ANossoNumero);

  LBoleto := TJSONObject.ParseJSONValue(LJsonRetorno) AS TJsonObject;
  LPayer := Nil;

  If LBoleto <> Nil Then
  Begin
    Try
      If Not RetornaValorJson(LBoleto, 'participantCode').Equals('CIT51225' +
                                                                 ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                                 fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3) +
                                                                 ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString) Then
        Exit;

      If LBoleto.GetValue('payer') = Nil Then
        Exit;

      LPayer := TJSONObject.ParseJSONValue(LBoleto.GetValue('payer').ToJson) As TJsonObject;
      If Not RetornaValorJson(LPayer, 'payerDocumentNumber').Contains(ADadosCliente.FieldByName('CLI_C_G_C_').AsString) Then
        Exit;

      If Not RetornaValorJson(LBoleto, 'nominalValue').Equals(FormatFloat('0.00', RetornaValorDuplicata(ADadosDuplicata)).Replace(',', '.')) Then
        Exit;

      ARetornoPost := LJsonRetorno;

      Result := True;
    Finally
      If Assigned(LPayer) Then
        FreeAndNil(LPayer);

      FreeAndNil(LBoleto);
    End;
  End;
end;

procedure TBancoSantanderAPI.CarregaLinksTabela;
  Var
    LConsulta: TUniQuery;

    LChaveAmbiente: String;
begin
  //A PEDIDO DO RONALDO, SERÃO CARREGADOS OS LINKS APENAS PELA TABELA
  If Not fTabelaExiste('LNKBCO') Then
    Raise ExceptionAutcom.Create('Tabela dos links de boletos não existe. Entre em contato com a Citel.');

  LChaveAmbiente := 'PROD';
  If FDadosCarteira.Homologacao Then
    LChaveAmbiente := 'HOM';

  LConsulta := Nil;
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM LNKBCO ' +
                          'WHERE LNK_CODBCO="033" ' +
                          '  AND LNK_ROTINA="BOLETO" ' +
                          '  AND LNK_TIPAMB=:CHAVE ' +
                          '  AND TRIM(COALESCE(LNK_URLLNK, "")) <> "" ';

    LConsulta.ParamByName('CHAVE').AsString := LeftStr(LChaveAmbiente, 1);

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Raise ExceptionAutcom.Create('Links de boletos do banco Santander não mapeados. Entre em contato com a Citel.');

    If LConsulta.Locate('LNK_CHAVE_', 'TOKEN_BOLETO_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkTokenApi := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CRIAR_BOLETO_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkInclusao := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'BAIXAR_BOLETO_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkBaixa := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_LISTA_BOLETO_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkConsulta := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_BOLETO_NN_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkConsultaEspecifico := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CRIAR_WORKSPACE_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkInclusaoWorkSpace := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'ALTERAR_WORKSPACE_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkAlteracaoWorkSpace := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'CONSULTAR_WORKSPACE_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkConsultaWorkSpace := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'WEBHOOK_CITEL_GET_CERT_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkWebhookSantanderCitelGetCertificado := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'WEBHOOK_CITEL_GET_WORKSPACE_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkWebhookSantanderCitelGetWorkSpaces := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'WEBHOOK_CITEL_PATCH_WORKSPACE_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkWebhookSantanderCitelPatchWorkSpace := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'WEBHOOK_CITEL_POST_WORKSPACE_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkWebhookSantanderCitelPostWorkSpace := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'WEBHOOK_CITEL_GET_BOLETOS_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkWebhookSantanderCitelGetBoletos := LConsulta.FieldByName('LNK_URLLNK').AsString;

    If LConsulta.Locate('LNK_CHAVE_', 'WEBHOOK_CITEL_LINK_' + LChaveAmbiente, []) Then
      FDadosCarteira.LinkWebhookSantanderCitelEmpresa := LConsulta.FieldByName('LNK_URLLNK').AsString;

    ValidaSeTodosOsLinksEstaoMapeados;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TBancoSantanderAPI.ValidaSeTodosOsLinksEstaoMapeados;
  Var
    LMensagem: String;
begin
  LMensagem := 'Links de boletos do banco Santander não devidamente mapeados. Entre em contato com a Citel.';

  If FDadosCarteira.LinkTokenAPI.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkInclusao.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkConsultaEspecifico.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkConsulta.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkBaixa.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkInclusaoWorkSpace.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkAlteracaoWorkSpace.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkConsultaWorkSpace.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkWebhookSantanderCitelGetCertificado.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkWebhookSantanderCitelGetWorkSpaces.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkWebhookSantanderCitelPatchWorkSpace.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkWebhookSantanderCitelPostWorkSpace.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkWebhookSantanderCitelGetBoletos.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);

  If FDadosCarteira.LinkWebhookSantanderCitelEmpresa.Trim.IsEmpty Then
    Raise ExceptionAutcom.Create(LMensagem);
End;

destructor TBancoSantanderAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;

  FreeAndNil(FRestSynalist);
  FreeAndNil(FListaRequisicaoRegistroBoleto);
  inherited;
end;

function TBancoSantanderAPI.DeveLimparOsDadosDoBoletoCancelamento(
  AStatus: Integer; ARetorno: String): Boolean;
  Var
    LJsonObject: TJsonObject;
begin
  If Not MatchStr(AStatus.ToString, ['200', '201', '204']) Then
    Exit(False);

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;

    Result := LJsonObject <> Nil;
    If Result Then
    Begin
      If FDadosCarteira.Homologacao Then
        Exit(True);    //Não retorna os cados conforme a documentação da API no banco

      Result := RetornaValorJson(LJsonObject, 'message').ToUpperInvariant.Contains('REALIZADA COM SUCESSO');

      FreeAndNil(LJsonObject);
    End;
  Except
    Result := False;
  End;
end;

function TBancoSantanderAPI.DuplicataJaCadastradaNoBancoMasNaoAtualizadaPorAlgumErro(
  ACodigoRetorno: Integer; var ARetornoPost: String;
  ADadosDuplicata, ADadosCliente: TDataset; ANossoNumero: String): Boolean;
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJSONValue;
begin
  Result := False;

  FNossoNumeroDuplicado := False;

  LJsonArray := Nil;

  LJsonObject := TJsonObject.ParseJSONValue(ARetornoPost) As TJsonObject;

  If LJsonObject = Nil Then
    Exit;

  Try
    If Not RetornaValorJson(LJsonObject, '_errorCode').Equals('400') Then
      Exit;

    If LJsonObject.GetValue('_errors') = Nil Then
      Exit;

    LJsonArray := TJsonObject.ParseJSONValue(LJsonObject.GetValue('_errors').ToJson) As TJsonArray;

    For LJsonValue In LJsonArray Do
    Begin
      Result := (RetornaValorJson(LJsonValue As TJsonObject, '_message').Contains('Nsu ja existente') Or
                 RetornaValorJson(LJsonValue As TJsonObject, '_message').Contains('Nosso numero ja existente'));

      If Result Then
        Break;
    End;

    If Not Result Then
      Exit;

    Result := DadosdoBoletoSaoDessaDuplicata(ARetornoPost, ANossoNumero, ADadosDuplicata, ADadosCliente);
    FNossoNumeroDuplicado := True;
  Finally
    If Assigned(LJsonArray) Then
      FreeAndNil(LJsonArray);

    FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoSantanderAPI.GerarToken;
  Var
    LDadosEnvio: String;

    LParametros: TStringList;
begin
  LParametros := TStringList.Create;

  LDadosEnvio := 'grant_type=client_credentials&' +
                 'client_id=' + FDadosCarteira.ClientId + '&' +
                 'client_secret=' + FDadosCarteira.ClientSecret;

  Try
    Try
      FTokenUsoAtual := 'Bearer ' + FRestSynalist.GetToken('POST',
                                                           FDadosCarteira.LinkTokenAPI,
                                                           LParametros,
                                                           FDadosCarteira.CarteiraCompleta,
                                                           LDadosEnvio,
                                                           'application/x-www-form-urlencoded');
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoSantanderAPI.GerarTxIdBoleto: String;
  Var
    LOperador,
    LAutoIncremTxId: String;
begin
  Result := EmptyStr;

  LAutoIncremTxId := fRetAutoIncrem('GERACAOTXIDPIX', VS_strCodEmp);

  If LAutoIncremTxId.IsEmpty Then
    Exit;

  LOperador := strLoginUsuarioLogado;
  If LOperador.IsEmpty Then
    LOperador := 'AUT';

  Result := Concat(VS_strCodEmp,
                   LAutoIncremTxId,
                   FormatDateTime('yyyy/mm/dd dd:mm:ss', fRetDtaHraServidor),
                   LOperador);

  Result := untFuncoesSimples.GetMD5(Result);
  Result := 'CIT51225' + RightStr(Result, Result.Length - 5);
end;

procedure TBancoSantanderAPI.GerarWorkspaceSantander;
  Var
    LRetornoPost,
    LIdWorkSpace: String;

    LStatus: Integer;

    LJsonArrayWork: TJsonArray;

    LJsonValueWork: TJsonValue;

    LParametros: TStringList;

    LJsonRequisicao: TJsonObject;
begin
  LParametros := Nil;
  LJsonArrayWork := Nil;
  LJsonRequisicao := Nil;
  Try
    Try
      LParametros := TStringList.Create;

      fGetBancoConfig(1, FDadosCarteira.CarteiraBanco, 'WORKSPACE', '');

      LJsonArrayWork := RetornaWorkspacesAtivasCitel(FDadosCarteira.CNPJEmpresa);

      If Assigned(LJsonArrayWork) And (LJsonArrayWork.Count > 0) Then
      Begin
        For LJsonValueWork In LJsonArrayWork Do
        Begin
          LIdWorkSpace := RetornaValorJsonValue(LJsonValueWork, 'id');
          if (RetornaValorJsonValue(LJsonValueWork, 'convenios').Contains(FDadosCarteira.CodCedente)) Then
          Begin
            fGetBancoConfig(1, FDadosCarteira.CarteiraBanco, 'WORKSPACE', LIdWorkSpace);

            fMensagem('ATENÇÃO', 'Workspace vinculada com sucesso.', ['&Ok']);

            Exit;
          End;

          If Not WorkspacePertenceAoClientIdDaCarteiraEEstaAtivo(LIdWorkSpace) Then
            Continue;

          If AtualizarWorkspaceAdicionandoConvenio(LJsonValueWork, FDadosCarteira.CNPJEmpresa) Then
          Begin
            fGetBancoConfig(1, FDadosCarteira.CarteiraBanco, 'WORKSPACE', LIdWorkSpace);

            fMensagem('ATENÇÃO', 'Workspace atualizada e vinculada com sucesso.', ['&Ok']);

            Exit;
          End;
        End;
      End;

      GerarToken;

      LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);
      LParametros.Add('Authorization: ' + FTokenUsoAtual);

      LJsonRequisicao := RetornaDadosInclusaoWorkspaceSantander(FDadosCarteira.CNPJEmpresa);

      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   FDadosCarteira.LinkInclusaoWorkSpace,
                                                   LParametros,
                                                   LRetornoPost,
                                                   LJsonRequisicao.ToJSON,
                                                   'application/json');

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      RegistrarWorkspaceWebhookSantander(LRetornoPost, FDadosCarteira.CNPJEmpresa);

      if fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'WORKSPACE', '') <> EmptyStr Then
        fMensagem('ATENÇÃO', 'Workspace gerada com sucesso.', ['&Ok']);
    Except
      On E: ExceptionAutcom Do
        fMensagem('ATENÇÃO', 'Não foi possível gerar/vincular a Workspace.' + #13 +
                             'Erro: ' + E.Message, ['&Ok']);

      On E: Exception Do
        pMensagensErro('Ocorreu um erro ao gerar a Workspace.' + #13 +
                       'Erro gerado: ' + E.Message, '[TBancoSantanderAPI.GerarWorkspaceSantander]');
    End;

  Finally
    if Assigned(LParametros) then
      FreeAndNil(LParametros);

    if Assigned(LJsonArrayWork) then
      FreeAndNil(LJsonArrayWork);

    If Assigned(LJsonRequisicao) Then
      FreeAndNil(LJsonRequisicao);
  End;

end;

procedure TBancoSantanderAPI.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(FListaRequisicaoRegistroBoleto) Then
  Begin
    If FListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      // GRAVA DADOS DAS REQUISIÇÕES
      For LRequisicaoRegistroBoleto In FListaRequisicaoRegistroBoleto Do
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
    End;

    FListaRequisicaoRegistroBoleto.Clear;
  End;
end;

procedure TBancoSantanderAPI.ImportarCertificadoCitel;
  Var
    LLinkCertificado,
    LRetornoPost,
    LValidade: String;

    LStatus: Integer;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LDatasetCertificado: TUniQuery;
begin
  If Not FDadosCarteira.CertificadoPfx.IsEmpty Then
    Exit;

  LDatasetCertificado := fCriarQuery('SELECT * FROM ATBCER WHERE CER_CODBCO="033"');

  LParametros := TStringList.Create;

  Try
    LDatasetCertificado.Open;
    If Not LDatasetCertificado.IsEmpty Then
      Exit;

    Try
      FDadosCarteira.WorkSpace := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'WORKSPACE','', FDadosCarteira.EmpresaCarteira);

      If FDadosCarteira.WorkSpace.IsEmpty Then
        FDadosCarteira.WorkSpace := 'ZDU1ZjE5YjQ4ZmZiY2FhMDY0NGY5YzczODRmNzMzNTY=';

      LParametros.Add('WebHookSantanderAuthorizationCitel: ' + RetornaTokenWebhookCitel(FDadosCarteira.WorkSpace));
      LParametros.Add('WebHookSantanderWorkspace: ' +  FDadosCarteira.WorkSpace);
      LParametros.Add('workspaceCliente: ' +  FDadosCarteira.WorkSpace);

      LLinkCertificado := FDadosCarteira.LinkWebhookSantanderCitelGetCertificado;

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkCertificado,
                                                   LParametros,
                                                   LRetornoPost,
                                                   EmptyStr,
                                                   EmptyStr,
                                                   False);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      LJsonObject := TJsonObject.ParseJSONValue(LRetornoPost) AS TJsonObject;

      fStartTransaction;
      LDatasetCertificado.Insert;
      LDatasetCertificado.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ATBCER', VS_strCodEmp);
      LDatasetCertificado.FieldByName('CER_CODBCO').AsString := '033';
      LDatasetCertificado.FieldByName('CER_ARQPFX').AsString := RetornaValorJson(LJsonObject, 'arquivoPfx');
      LDatasetCertificado.FieldByName('CER_SENCER').AsString := RetornaValorJson(LJsonObject, 'senhaCertificado');

      LValidade := RetornaValorJson(LJsonObject, 'validadeCertificado');
      If Not LValidade.IsEmpty Then
        LDatasetCertificado.FieldByName('CER_VALCER').AsDateTime := EncodeDate(StrToInt(LValidade.Split(['-'])[0]),
                                                                               StrToInt(LValidade.Split(['-'])[1]),
                                                                               StrToInt(LValidade.Split(['-'])[2]));

      LDatasetCertificado.Post;

      fCommit;
    Except
      On E: Exception Do
      Begin
        If fInTransaction Then
          fRollback;

        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    LDatasetCertificado.Close;

    FreeAndNil(LDatasetCertificado);

    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

function TBancoSantanderAPI.LiquidacaoEhFutura(ACreditDate: String): Boolean;
begin
  Result := False;

  If fEmptyStr(ACreditDate) Then
    Exit;

  If Not FDadosCarteira.ConsiderarLiquidacaoPelaDataCredito Then
    Exit;

  If VS_Date >= StrToDateDef(ACreditDate, 0) Then
    Exit;

  Result := True;
end;

function TBancoSantanderAPI.PossuiTodosOsDadosParaRealizarAutorizacaoAPI: Boolean;
begin
  Result := True;

  If FDadosCarteira.ClientId.Trim.IsEmpty Then
    Result := False;

  If FDadosCarteira.ClientSecret.Trim.IsEmpty Then
    Result := False;

  If FDadosCarteira.CertificadoPfx.Trim.IsEmpty Then
    Result := False;

  If FDadosCarteira.SenhaCertificado.Trim.IsEmpty Then
    Result := False;

  If Not Result Then
    fMensagem('ATENÇÃO', 'A carteira não possui os dados de autorização cadastrados.' + #13 +
                         'Verifique os dados de Autenticação da Carteira.',
                         ['&Ok']);
end;

procedure TBancoSantanderAPI.RegistrarWorkspaceWebhookSantander(ARetornoWorkspace,
  ACNPJEmpresa: String);
  Var
    LLinkInclusao,
    LRetornoPost: String;

    LStatus: Integer;

    LParametros: TStringList;

    LJsonRetornoWorkspace,
    LJsonRequisicao: TJsonObject;
begin
  LParametros := TStringList.Create;

  LJsonRetornoWorkspace := TJsonObject.ParseJSONValue(ARetornoWorkspace) As TJsonObject;

  Try
    LJsonRequisicao := TJSONObject.Create;
    LJsonRequisicao.AddPair('id', RetornaValorJson(LJsonRetornoWorkspace, 'id'));
    LJsonRequisicao.AddPair('status', IIF(RetornaValorJson(LJsonRetornoWorkspace, 'status').IsEmpty, 'ACTIVE', RetornaValorJson(LJsonRetornoWorkspace, 'status')));
    LJsonRequisicao.AddPair('tipo', RetornaValorJson(LJsonRetornoWorkspace, 'type'));
    LJsonRequisicao.AddPair('descricao', RetornaValorJson(LJsonRetornoWorkspace, 'description'));
    LJsonRequisicao.AddPair('webhookLink', RetornaValorJson(LJsonRetornoWorkspace, 'webhookURL'));
    LJsonRequisicao.AddPair('dataInclusao', FormatDateTime('yyyy-mm-dd', VS_Date));
    LJsonRequisicao.AddPair('horaInclusao', FormatDateTime('hh:mm:ss', fRetDtaHraServidor));
    LJsonRequisicao.AddPair('cnpjCliente', ACNPJEmpresa);
    LJsonRequisicao.AddPair('jsonRecebido', ARetornoWorkspace);
    LJsonRequisicao.AddPair('operadorInclusao', strLoginUsuarioLogado);
    LJsonRequisicao.AddPair('empresaFisica', fRetEmpresaFisica);
    LJsonRequisicao.AddPair('empresaLogada', VS_strCodEmp);
    LJsonRequisicao.AddPair('convenios', FDadosCarteira.CodCedente);

    Try
      LParametros.Add('WebHookSantanderAuthorizationCitel: ' + RetornaTokenWebhookCitel(RetornaValorJson(LJsonRetornoWorkspace, 'id')));
      LParametros.Add('WebHookSantanderWorkspace: ' + RetornaValorJson(LJsonRetornoWorkspace, 'id'));

      LLinkInclusao := FDadosCarteira.LinkWebhookSantanderCitelPostWorkSpace;

      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   LLinkInclusao,
                                                   LParametros,
                                                   LRetornoPost,
                                                   LJsonRequisicao.ToJSON,
                                                   '',
                                                   False);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      fGetBancoConfig(1, FDadosCarteira.CarteiraBanco, 'WORKSPACE', RetornaValorJson(LJsonRetornoWorkspace, 'id'));
    Except
      On E: Exception Do
        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TBancoSantanderAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRegistro: String;

    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  FRetornoBancoSantanderAPI := TRetornoBoletoSantander.Create;

  Try
    Try
      LJsonRegistro := TFuncoesPixBoleto.RetornaJsonRegistroBoleto(AAutoIncrem, '033');

      LConsulta.SQL.Text := 'SELECT CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE, CTR_LINDIG ' +
                            'FROM CADREC WHERE AUTOINCREM = :AUTOINC';

      LConsulta.ParamByName('AUTOINC').AsString := AAutoIncrem;
      LConsulta.Open;

      If fEmptyStr(LJsonRegistro) Then
      Begin
        FRetornoBancoSantanderAPI.nossoNumero := LConsulta.FieldByName('CTR_NOSNUM').AsString;
        FRetornoBancoSantanderAPI.QrCodeTxId := LConsulta.FieldByName('CTR_TX_BOL').AsString;
        FRetornoBancoSantanderAPI.QrCodeEmv := LConsulta.FieldByName('CTR_QRCODE').AsString;
        FRetornoBancoSantanderAPI.linhaDigitavel := LConsulta.FieldByName('CTR_LINDIG').AsString;
        FRetornoBancoSantanderAPI.codigoBarras := Copy(FRetornoBancoSantanderAPI.linhaDigitavel, 01, 04) +
                                                  Copy(FRetornoBancoSantanderAPI.linhaDigitavel, 33, 15) +
                                                  Copy(FRetornoBancoSantanderAPI.linhaDigitavel, 05, 05) +
                                                  Copy(FRetornoBancoSantanderAPI.linhaDigitavel, 11, 08) +
                                                  Copy(FRetornoBancoSantanderAPI.linhaDigitavel, 19, 02) +
                                                  Copy(FRetornoBancoSantanderAPI.linhaDigitavel, 22, 10);

        Exit;
      End;

      FRetornoBancoSantanderAPI := RetornaDadosRetornoInclusaoBoleto(LJsonRegistro,
                                                                     Nil,
                                                                     LConsulta.FieldByName('CTR_TX_BOL').AsString,
                                                                     True);

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TBancoSantanderAPI.RetornaDadosBeneficiarioBoleto: TJsonObject;
begin
  Result := TJsonObject.Create;

  Result.AddPair('documentType', 'CNPJ');
  Result.AddPair('documentNumber', fTiraCaracEspeciaisPonto(FDadosCarteira.CNPJBeneficiario));
  Result.AddPair('name', RetornaValorString(FDadosCarteira.NomeBeneficiario, 40));
end;

function TBancoSantanderAPI.RetornaDadosDaRequisicao(ADadosDuplicata,
  ADadosCliente: TDataset; ANossoNumero: String; var ATxIdPix: String): String;
  Var
    LJSONBoleto: TJSONObject;
    LCodConvInt : Integer;
Begin
  LJSONBoleto := TJSONObject.Create;

  If Not TryStrToInt(FDadosCarteira.CodCedente, LCodConvInt) Then
    Raise ExceptionAutcom.Create('O Convênio do Cedente deve possuir apenas números.');

  Try
    If FDadosCarteira.Homologacao Then
      LJSONBoleto.AddPair('nsuCode', 'TST' + FDadosCarteira.ContaCorrente + RightStr(ANossoNumero, 8))
    Else
      LJSONBoleto.AddPair('nsuCode', RightStr(FDadosCarteira.ContaCorrente, 9) + RightStr(ANossoNumero, 11));

    LJSONBoleto.AddPair('nsuDate', FormatDateTime('yyyy-mm-dd', VS_Date));
    LJSONBoleto.AddPair('environment', IIF(FDadosCarteira.Homologacao, 'TESTE', 'PRODUCAO'));
    LJSONBoleto.AddPair('covenantCode', IntToStr(LCodConvInt));

    LJSONBoleto.AddPair('payer', RetornaDadosPagadorBoleto(ADadosCliente));

    If FDadosCarteira.EnviarSAcadorAvalista.Equals('S') Then
      LJSONBoleto.AddPair('beneficiary', RetornaDadosBeneficiarioBoleto);

    LJSONBoleto.AddPair('bankNumber', ANossoNumero);
    LJSONBoleto.AddPair('clientNumber', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                        fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3));

    LJSONBoleto.AddPair('dueDate', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));
    LJSONBoleto.AddPair('issueDate', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));

    LJSONBoleto.AddPair('participantCode', 'CIT51225' +
                                           ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                           fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3) +
                                           ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString);

    LJSONBoleto.AddPair('nominalValue', FormatFloat('0.00', RetornaValorDuplicata(ADadosDuplicata)).Replace(',', '.'));

    LJSONBoleto.AddPair('documentKind', 'DUPLICATA_MERCANTIL');

    CarregaDescontosBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaMultaBoleto(LJSONBoleto);

    CarregaJurosMoraBoleto(LJSONBoleto);

    CarregaDadosProtestoBoleto(LJSONBoleto);

    If FDadosCarteira.Instrucao2.Equals('02') Then
      LJSONBoleto.AddPair('writeOffQuantityDays', '15')
    Else If FDadosCarteira.Instrucao2.Equals('03') Then
      LJSONBoleto.AddPair('writeOffQuantityDays', '30');

    LJSONBoleto.AddPair('paymentType', 'REGISTRO');

    CarregaDadosChavePixBoleto(LJSONBoleto, ATxIdPix);

    LJSONBoleto.AddPair('messages', RetornaMensagensBoleto);

    Result := TJson.Format(LJSONBoleto);

    Result := TratarCamposValoresRequisicao(Result);
  Finally
    FreeAndNil(LJSONBoleto);
  End;
end;

function TBancoSantanderAPI.RetornaDadosInclusaoWorkspaceSantander(
  ACNPJEmpresa: String): TJsonObject;
  Var
    LJsonArray: TJsonArray;

    LJsonObject: TJsonObject;

    LLinkWebhook: String;

    LWorkspaceInt: Integer;
begin
  Result := TJsonObject.Create;

  Result.AddPair('type', 'BILLING');
  Result.AddPair('description', 'Workspace Cobranca Santander');

  If Not TryStrToInt(FDadosCarteira.CodCedente, LWorkspaceInt) Then
    Raise ExceptionAutcom.Create('O Convênio do Cedente deve possuir apenas números.');

  LJsonArray := TJsonArray.Create;

  LJsonObject := TJsonObject.Create;
  LJsonObject.AddPair('code', TJsonNumber.Create(LWorkspaceInt));

  LJsonArray.AddElement(LJsonObject);

  Result.AddPair('covenants', LJsonArray);

  LLinkWebhook := FDadosCarteira.LinkWebhookSantanderCitelEmpresa.Replace('[CNPJ_EMPRESA]', ACNPJEmpresa);

  Result.AddPair('webhookURL', LLinkWebhook);
  Result.AddPair('bankSlipBillingWebhookActive', TJSONBool.Create(True));
  Result.AddPair('pixBillingWebhookActive', TJSONBool.Create(True));
end;

function TBancoSantanderAPI.RetornaDadosPagadorBoleto(
  ADadosCliente: TDataset): TJsonObject;
begin
  Result := TJsonObject.Create;

  Result.AddPair('documentType', IIF(fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString).Length < 14, 'CPF', 'CNPJ'));
  Result.AddPair('documentNumber', fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString));
  Result.AddPair('name', RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 40));
  Result.AddPair('address', RetornaValorString(Concat(ADadosCliente.FieldByName('CLI_ENDERE').AsString, ' ',
                                                      ADadosCliente.FieldByName('CLI_ENDNUM').AsString), 40));
  Result.AddPair('neighborhood', RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 30));
  Result.AddPair('city', RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 20));
  Result.AddPair('zipCode', fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString).Insert(5, '-'));
  Result.AddPair('state', RetornaValorString(ADadosCliente.FieldByName('CID_ESTADO').AsString, 2));
end;

function TBancoSantanderAPI.RetornaDadosPesquisaBoletoWebhookCitel(
  ADadosBoleto: TJsonValue): TRetornoPesquisaBancoSantanderAPI;
begin
  Result := TRetornoPesquisaBancoSantanderAPI.Create;

  Try
    Result.id := RetornaValorJsonValue(ADadosBoleto, 'id');
    Result.messageField := RetornaValorJsonValue(ADadosBoleto, 'message');
    Result.paymentType := RetornaValorJsonValue(ADadosBoleto, 'paymentType');
    Result.functionField := RetornaValorJsonValue(ADadosBoleto, 'function');
    Result.issueDate := RetornaValorJsonValue(ADadosBoleto, 'issueDate');
    Result.paymentDate := RetornaValorJsonValue(ADadosBoleto, 'paymentDate');
    Result.creditDate := RetornaValorJsonValue(ADadosBoleto, 'paymentDate');
    Result.bankCode := RetornaValorJsonValue(ADadosBoleto, 'bankCode');
    Result.paymentChannel := RetornaValorJsonValue(ADadosBoleto, 'paymentChannel');
    Result.paymentKind := RetornaValorJsonValue(ADadosBoleto, 'paymentKind');
    Result.covenant := RetornaValorJsonValue(ADadosBoleto, 'covenant');
    Result.typeOfPersonAgreement := RetornaValorJsonValue(ADadosBoleto, 'typeOfPersonAgreement');
    Result.agreementDocument := RetornaValorJsonValue(ADadosBoleto, 'agreementDocument');
    Result.bankNumber := RetornaValorJsonValue(ADadosBoleto, 'bankNumber');
    Result.clientNumber := RetornaValorJsonValue(ADadosBoleto, 'clientNumber');
    Result.participantCode := RetornaValorJsonValue(ADadosBoleto, 'participantCode');
    Result.txId := RetornaValorJsonValue(ADadosBoleto, 'txId');
    Result.payerDocumentType := RetornaValorJsonValue(ADadosBoleto, 'payerDocumentType');
    Result.payerDocumentNumber := RetornaValorJsonValue(ADadosBoleto, 'payerDocumentNumber');
    Result.payerName := RetornaValorJsonValue(ADadosBoleto, 'payerName');
    Result.dueDate := RetornaValorJsonValue(ADadosBoleto, 'dueDate');
    Result.nominalValue := RetornaValorJsonValue(ADadosBoleto, 'nominalValue');
    Result.payedValue := RetornaValorJsonValue(ADadosBoleto, 'payedValue');
    Result.interestValue := RetornaValorJsonValue(ADadosBoleto, 'interestValue');
    Result.fine := RetornaValorJsonValue(ADadosBoleto, 'fine');
    Result.deductionValue := RetornaValorJsonValue(ADadosBoleto, 'deductionValue');
    Result.rebateValue := RetornaValorJsonValue(ADadosBoleto, 'rebateValue');
    Result.iofValue := RetornaValorJsonValue(ADadosBoleto, 'iofValue');
    Result.cnpjCliente := RetornaValorJsonValue(ADadosBoleto, 'cnpjCliente');

    CorrigeDatas(Result.issueDate);
    CorrigeDatas(Result.paymentDate);
    CorrigeDatas(Result.creditDate, Not Result.paymentType.Equals('PIX'));
    CorrigeDatas(Result.dueDate);

    CarregaOcorrenciaBaixa(Result);
  Except
    Raise;
  End;
end;

function TBancoSantanderAPI.RetornaDadosPesquisaBoletoAPISantander(
  ADadosBoleto: TJsonValue): TRetornoPesquisaBancoSantanderAPI;
  Var
    LJsonObject: TJsonObject;
begin
  Result := TRetornoPesquisaBancoSantanderAPI.Create;

  Try
    Result.id := RetornaValorJsonValue(ADadosBoleto, 'nsuCode');

    LJsonObject := TJsonObject.ParseJSONValue((ADadosBoleto as TJsonObject).GetValue('payment').ToJson) As TJsonObject;

    Result.paymentType := RetornaValorJson(LJsonObject, 'type');
    Result.payedValue := RetornaValorJson(LJsonObject, 'paidValue');
    Result.interestValue := RetornaValorJson(LJsonObject, 'interestValue');
    Result.fine := RetornaValorJson(LJsonObject, 'fineValue');
    Result.deductionValue := RetornaValorJson(LJsonObject, 'deductionValue');
    Result.rebateValue := RetornaValorJson(LJsonObject, 'rebateValue');
    Result.iofValue := RetornaValorJson(LJsonObject, 'iofValue');
    Result.paymentDate := RetornaValorJson(LJsonObject, 'date');
    Result.paymentChannel := RetornaValorJson(LJsonObject, 'channel');
    Result.paymentKind := RetornaValorJson(LJsonObject, 'kind');
    Result.txId := RetornaValorJson(LJsonObject, 'txId');
    Result.bankCode := RetornaValorJson(LJsonObject, 'bankCode');

    Result.issueDate := RetornaValorJsonValue(ADadosBoleto, 'issueDate');
    Result.dueDate := RetornaValorJsonValue(ADadosBoleto, 'dueDate');

    Result.status := RetornaValorJsonValue(ADadosBoleto, 'status');
    Result.statusComplement := RetornaValorJsonValue(ADadosBoleto, 'statusComplement');
    Result.bankNumber := RetornaValorJsonValue(ADadosBoleto, 'bankNumber');
    Result.clientNumber := RetornaValorJsonValue(ADadosBoleto, 'clientNumber');

    Result.nominalValue := RetornaValorJsonValue(ADadosBoleto, 'nominalValue');

    Result.barCode := RetornaValorJsonValue(ADadosBoleto, 'barCode');
    Result.digitableLine := RetornaValorJsonValue(ADadosBoleto, 'digitableLine');

    Result.creditDate := RetornaValorJsonValue(LJsonObject, 'creditDate');
    If Result.creditDate.IsEmpty Then
    Begin
      Result.creditDate := RetornaValorJsonValue(LJsonObject, 'date');
      CorrigeDatas(Result.creditDate, Not Result.paymentType.ToUpperInvariant.Equals('PIX'), StrToIntDef(FDadosCarteira.QtdDiasCredito, 1));
    End;

    Result.JsonBoleto := ADadosBoleto.ToJSON;

    CorrigeDatas(Result.issueDate);
    CorrigeDatas(Result.paymentDate);
    CorrigeDatas(Result.creditDate);
    CorrigeDatas(Result.dueDate);

    CarregaOcorrenciaBaixa(Result);

    FreeAndNil(LJsonObject);
  Except
    Raise;
  End;
end;

function TBancoSantanderAPI.RetornaDadosRetornoInclusaoBoleto(ADadosRetorno: String;
  ADadosDuplicata: TDataset; ATxIdPix: String; AReimpressao: Boolean): TRetornoBoletoSantander;
  Var
    LJsonRetorno: TJSONObject;
begin
  Result := TRetornoBoletoSantander.Create;

  LJsonRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;

  Result.idBoleto := RetornaValorJson(LJsonRetorno, 'nsuCode');
  Result.nossoNumero := RetornaValorJson(LJsonRetorno, 'bankNumber');
  Result.linhaDigitavel := RetornaValorJson(LJsonRetorno, 'digitableLine');

  //Documentação está como barCode, mas o retorno no SandBox está barcode. Por isso esse tratamento
  Result.codigoBarras := RetornaValorJson(LJsonRetorno, 'barCode');
  If Result.codigoBarras.IsEmpty Then
    Result.codigoBarras := RetornaValorJson(LJsonRetorno, 'barcode');

  Result.dataEmissao := RetornaValorJson(LJsonRetorno, 'entryDate');
  Result.chaveDuplicata := RetornaValorJson(LJsonRetorno, 'participantCode');
  Result.seuNumero := RetornaValorJson(LJsonRetorno, 'clientNumber');

  If FDadosCarteira.GerarQRCodePix.Equals('N') Then
    Exit;

  Result.QrCodeEmv := RetornaValorJson(LJsonRetorno, 'qrCodePix');
  Result.QrCodeUrl := RetornaValorJson(LJsonRetorno, 'qrCodeUrl');
  Result.QrCodeTxId := RetornaValorJson(LJsonRetorno, 'txId');

  If Result.QrCodeEmv.IsEmpty Then
    Exit;

  If Result.QrCodeTxId.IsEmpty Then
    Result.QrCodeTxId := ATxIdPix;

  If Not AReimpressao Then
    Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('033',
                                                                          Result.QrCodeTxId,
                                                                          Result.QrCodeEmv,
                                                                          FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                          FDadosCarteira.AutoIncremChavePix,
                                                                          IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 60) + StrToTime('23:59:59'));
end;

function TBancoSantanderAPI.RetornaDuplicatasEntradaConfirmada(ADataInicial,
  ADataFinal: TDateTime): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CTR_NUMDUP, ' +
                          '       CTR_PARCEL, ' +
                          '       CTR_ESPDOC, ' +
                          '       CTR_CODEMP, ' +
                          '       CTR_CODCLI, ' +
                          '       CTR_VALDUP, ' +
                          '       CTR_VALANT, ' +
                          '       CTR_DTAVEN, ' +
                          '       CTR_DTAENV, ' +
                          '       CTR_NOSNUM  ' +
                          'FROM CADREC ' +
                          'WHERE CTR_BCOENV="033" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_DTAENV BETWEEN :DTAINI AND :DTAFIN ';

    LConsulta.ParamByName('CARTEI').AsString := FDadosCarteira.CarteiraCompleta;
    LConsulta.ParamByName('DTAINI').AsDateTime := ADataInicial;
    LConsulta.ParamByName('DTAFIN').AsDateTime := ADataFinal;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);

    Result.Open;
    Result.First;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TBancoSantanderAPI.RetornaMensagensBoleto: TJsonArray;
begin
  Result := TJsonArray.Create;

  If Not FDadosCarteira.Observacao1.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao1, 40, False));

  If Not FDadosCarteira.Observacao2.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao2, 40, False));

  If Not FDadosCarteira.Observacao3.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao3, 40, False));

  If Not FDadosCarteira.Observacao4.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao4, 40, False));

  If Not FDadosCarteira.Observacao5.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao5, 40, False));
end;

function TBancoSantanderAPI.RetornaTextoErro(ACodigoRetorno,
  ADadosRetorno: String): String;
  Var
    LJsonObject: TJsonObject;

    LErro: String;
    LMessage : String;

    LErroInstabilidade,
    LErroAutenticacao,
    LErroLido : String;
begin
  Result := 'Status: ' + ACodigoRetorno + ' - Erro: ' + ADadosRetorno;

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  Try

    Try
      LJsonObject := TJSONObject.ParseJSONValue(ADadosRetorno) As TJsonObject;

      If LJsonObject = Nil Then
      Begin
         Result := LErroInstabilidade;

         // Verifica se é erro de authenticação - gerar token
         If (Pos(LErroAutenticacao, ADadosRetorno) > 0) Then
            Result := LErroAutenticacao;

         Exit;
      End;

      If ACodigoRetorno = '0' Then
      Begin
         Result := LErroInstabilidade;
         exit;
      End;

      If ACodigoRetorno = '' Then
      Begin
         LErroLido := RetornaValorJson(LJsonObject, 'errorCode');
         ACodigoRetorno := LErroLido;
      End;

      LErro := 'Status: ' + ACodigoRetorno + ' - ';

      LMessage := RetornaValorJson(LJsonObject, '_errorCode') + ' - ' +
                  RetornaValorJson(LJsonObject, '_message') + '. ';

      If LMessage = ' - . ' Then
         LMessage := LErroInstabilidade;

      LErro := LErro + 'Erro: ' + LMessage;

      If fEmptystr(ADadosRetorno) Then
         Result := LErroInstabilidade
      Else
         Result := LErro;

    Except
      Result := LErroInstabilidade;
    End;
    FreeAndNil(LJsonObject);
  Except

  End;
end;

function TBancoSantanderAPI.RetornaTokenWebhookCitel(AWorkspace: String): String;
  Var
    LDataRequisicao: Int64;
begin
  LDataRequisicao := untFuncAutban.RetornaTimeStampEmMilisegundos;

  Result := TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                                          untFuncoesSimples.GetMD5(LDataRequisicao.ToString +
                                                                   VS_ChaveAutorizacaoCitel +
                                                                   AWorkspace));
end;

function TBancoSantanderAPI.RetornaValorDuplicata(
  ADadosDuplicata: TDataSet): Double;
begin
  Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat;

  If fCfgSis('VALIMP', varBoolean, FDadosCarteira.EmpresaCarteira) then
    Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat +
              ADadosDuplicata.FieldByName('CTR_JURSUJ').AsFloat +
              ADadosDuplicata.FieldByName('CTR_DESCOB').AsFloat;

  If fCfgSis('DESBOL', varBoolean, FDadosCarteira.EmpresaCarteira) Then
    Result := Result -
              ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat;
end;

function TBancoSantanderAPI.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := EmptyStr;
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function TBancoSantanderAPI.RetornaValorJsonValue(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  If Not AObjeto.TryGetValue<String>(ANomeCampo, Result) Then
    Result := EmptyStr;
end;

function TBancoSantanderAPI.RetornaValorString(AValor: String;
  ATamanho: Integer; ATiraPonto: Boolean = True): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);

  If ATiraPonto Then
    Result := fTiraCaracEspeciaisPonto(Result);
end;

function TBancoSantanderAPI.RetornaWorkspacesAtivasCitel(
  ACNPJCliente: String): TJsonArray;
  Var
    LLinkInclusao,
    LRetornoPost: String;

    LStatus: Integer;

    LParametros: TStringList;
begin
  Result := Nil;

  LParametros := TStringList.Create;

  Try
    Try
      LParametros.Add('WebHookSantanderAuthorizationCitel: ' + RetornaTokenWebhookCitel(ACNPJCliente));
      LParametros.Add('cnpjCliente: ' + ACNPJCliente);

      LLinkInclusao := FDadosCarteira.LinkWebhookSantanderCitelGetWorkSpaces;

      LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                   LLinkInclusao,
                                                   LParametros,
                                                   LRetornoPost,
                                                   '',
                                                   '',
                                                   False);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      Result := TJsonObject.ParseJSONValue(LRetornoPost) AS TJsonArray;
    Except
      On E: Exception Do
        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TBancoSantanderAPI.TransformaJsonBankSplitEmCadastro(
  ARetornoGet: String): String;
  Var
    LJsonObject,
    LJsonNovo,
    LJsonSplit,
    LJsonAuxiliar,
    LJsonKey: TJsonObject;
begin
  If ARetornoGet.IsEmpty Then
    Exit(EmptyStr);

  LJsonObject := TJSONObject.ParseJSONValue(ARetornoGet) As TJSONObject;

  LJsonSplit := Nil;
  LJsonNovo := Nil;
  LJsonAuxiliar := Nil;
  LJsonKey := Nil;

  If LJsonObject = Nil Then
    Exit(EmptyStr);

  Try
    If LJsonObject.GetValue('bankSlipData') = Nil Then
      Exit(EmptyStr);

    LJsonSplit := TJSONObject.ParseJSONValue(LJsonObject.GetValue('bankSlipData').ToJson) As TJSONObject;

    If LJsonSplit = Nil Then
      Exit(EmptyStr);

    LJsonNovo := TJSONObject.Create;
    LJsonNovo.AddPair('nsuCode', RightStr(RetornaValorJson(LJsonSplit, 'accountNumber'), 9) + RightStr(fStrZero(RetornaValorJson(LJsonObject, 'bankNumber'), 11), 11));
    LJsonNovo.AddPair('nsuDate', RetornaValorJson(LJsonSplit, 'processingDate'));
    LJsonNovo.AddPair('covenantCode', RetornaValorJson(LJsonObject, 'beneficiaryCode'));
    LJsonNovo.AddPair('environment', IIF(FDadosCarteira.Homologacao, 'HOMOLOGAÇÃO', 'PRODUÇÃO'));
    LJsonNovo.AddPair('bankNumber', RetornaValorJson(LJsonObject, 'bankNumber'));
    LJsonNovo.AddPair('clientNumber', RetornaValorJson(LJsonObject, 'clientNumber'));
    LJsonNovo.AddPair('dueDate', RetornaValorJson(LJsonObject, 'dueDate'));
    LJsonNovo.AddPair('issueDate', RetornaValorJson(LJsonObject, 'issueDate'));
    LJsonNovo.AddPair('documentKind', 'DUPLICATA_MERCANTIL');
    LJsonNovo.AddPair('nominalValue', RetornaValorJson(LJsonObject, 'nominalValue'));
    LJsonNovo.AddPair('finePercentage', FormatFloat('0.00', Self.FPercentualMulta).Replace(',', '.'));
    LJsonNovo.AddPair('interestPercentage', RetornaValorJson(LJsonSplit, 'interestPercentage'));
    LJsonNovo.AddPair('protestType', IIF(RetornaValorJson(LJsonSplit, 'protestDescription').Contains('CORRIDOS'), 'DIAS_CORRIDOS', 'DIAS_UTEIS'));
    LJsonNovo.AddPair('protestQuantityDays', RetornaValorJson(LJsonSplit, 'protestQuantityDays'));
    LJsonNovo.AddPair('writeOffQuantityDays', RetornaValorJson(LJsonSplit, 'writeOffQuantityDays'));
    LJsonNovo.AddPair('paymentType', 'REGISTRO');
    LJsonNovo.AddPair('parcelsQuantity', '0');
    LJsonNovo.AddPair('minValueOrPercentage', '0.00');
    LJsonNovo.AddPair('maxValueOrPercentage', '0.00');
    LJsonNovo.AddPair('iofPercentage', '0.00');
    LJsonNovo.AddPair('participantCode', RetornaValorJson(LJsonObject, 'participantCode'));
    LJsonNovo.AddPair('fineQuantityDays', '0');

    LJsonNovo.AddPair('barCode', RetornaValorJson(LJsonSplit, 'barCode'));
    LJsonNovo.AddPair('digitableLine', RetornaValorJson(LJsonSplit, 'digitableLine'));
    LJsonNovo.AddPair('entryDate', RetornaValorJson(LJsonSplit, 'entryDate'));

    If LJsonObject.GetValue('qrCodeData') <> Nil Then
    Begin
      LJsonNovo.AddPair('txId', 'CIT51225');
      LJsonAuxiliar := TJSONObject.ParseJSONValue(LJsonObject.GetValue('qrCodeData').ToJSON) AS TJSONObject;

      LJsonNovo.AddPair('qrCodeUrl', RetornaValorJson(LJsonAuxiliar, 'qrCodeUrl'));
      LJsonNovo.AddPair('qrCodePix', RetornaValorJson(LJsonAuxiliar, 'qrCode'));

      LJsonKey := TJsonObject.Create;
      LJsonKey.AddPair('type', RetornaValorJson(LJsonAuxiliar, 'dictKeyType'));
      LJsonKey.AddPair('dictKey', RetornaValorJson(LJsonAuxiliar, 'dictKey'));
      LJsonNovo.AddPair('key', LJsonKey);
      LJsonKey := Nil;

      FreeAndNil(LJsonAuxiliar);
    End
    Else
      LJsonNovo.AddPair('txId', '');;

    If LJsonObject.GetValue('payerData') <> Nil Then
    Begin
      LJsonAuxiliar := TJSONObject.ParseJSONValue(LJsonObject.GetValue('payerData').ToJSON) AS TJSONObject;
      LJsonNovo.AddPair('payer', LJsonAuxiliar);
      LJsonAuxiliar := Nil;
    End;

    Result := LJsonNovo.ToJSON;
  Finally
    If LJsonAuxiliar <> Nil Then
      FreeAndNil(LJsonAuxiliar);

    If LJsonKey <> Nil Then
      FreeAndNil(LJsonKey);

    If Assigned(LJsonSplit) Then
      FreeAndNil(LJsonSplit);

    FreeAndNil(LJsonObject);

    If Assigned(LJsonNovo) Then
      FreeAndNil(LJsonNovo);
  End;
end;

function TBancoSantanderAPI.TratarCamposValoresRequisicao(
  ARequisicao: String): String;
  Const
    CAMPOS: Array Of String = ['"nominalValue":"',
                               '"value":"',
                               '"interestPercentage":"',
                               '"finePercentage":"'];

  Var
    LCampo: String;

    LPosicaoInicial,
    LPosicaoFinal: Integer;

    LValores: TStringList;
begin
  Result := ARequisicao;

  LValores := TStringList.Create;
  LValores.Delimiter := ':';
  LValores.StrictDelimiter := True;

  Try
    For LCampo In CAMPOS Do
    Begin
      LPosicaoInicial := Pos(LCampo, Result);

      If LPosicaoInicial = 0 Then
        Continue;

      LPosicaoFinal := Pos('"', Result, LPosicaoInicial + LCampo.Length);

      LValores.Clear;
      LValores.DelimitedText := Copy(Result, LPosicaoInicial, LPosicaoFinal - LPosicaoInicial + 1);

      Result := Result.Replace(Copy(Result, LPosicaoInicial, LPosicaoFinal - LPosicaoInicial + 1),
                               '"' + LValores[0] + '":' + LValores[1].Replace('"', EmptyStr));
    End;
  Finally
    FreeAndNil(LValores);
  End;
end;

function TBancoSantanderAPI.UtilizaDescontoDePontualidade(
  AValDes: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, FDadosCarteira.EmpresaCarteira) Then
  Begin
    If (AValDes > 0) Then
      Result := True;
  End;
end;

procedure TBancoSantanderAPI.ValidarDadosAutorizacao;
  Var
    LGeradoToken: Boolean;
Begin
  If Not PossuiTodosOsDadosParaRealizarAutorizacaoAPI Then
    Exit;

  FTokenUsoAtual := EmptyStr;

  Try
    FRestSynalist.StatusSemRaise := [404, 401, 403];

    Try
      FRestSynalist.RemoveTokenAtivo(FDadosCarteira.CarteiraCompleta);
      GerarToken;

      LGeradoToken := Not FTokenUsoAtual.Replace('Bearer ', EmptyStr).IsEMpty;
    Except
      On E: Exception Do
      Begin
        fMensagem('ERRO', E.Message, ['&Ok']);

        Exit;
      End;
    End;

    If Not LGeradoToken Then
    Begin
      fMensagem('ATENÇÃO', 'Não foi possível atenticar a API. Verifique os dados de autorização.', ['&Ok']);

      Exit;
    End;

  Finally
    FRestSynalist.StatusSemRaise := [];
  End;

  fMensagem('ATENÇÃO', 'Dados de autorização validados com sucesso.', ['&Ok']);
end;

function TBancoSantanderAPI.VerificaSeADuplicataExisteCadrec(
  ABoleto: TRetornoPesquisaBancoSantanderAPI;
  out ADuplicata: TDuplicataCtr): Boolean;
  Var
    LPesquisa: TUniQuery;
begin
  ADuplicata.strAutoIn := EmptyStr;
  ADuplicata.strNumDup := EmptyStr;
  ADuplicata.strParcel := EmptyStr;
  ADuplicata.strEspdoc := EmptyStr;
  ADuplicata.strCodEmp := EmptyStr;
  ADuplicata.strCodCli := EmptyStr;

  LPesquisa := fCriaQuery;
  Try
    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,      ' +
                          'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI, ' +
                          'CTR_DTAENV                                      ' +
                          'FROM CADREC                                     ' +
                          'WHERE CTR_BCOBOL=:BCOENV                        ' +
                          '  AND CTR_BCOENV=:BCOENV                        ' +
                          '  AND CTR_NOSNUM IN (:NOSNUM, RIGHT(:NOSNUM, 8))' +
                          '  AND CTR_SEQBAI=0                              ';

    LPesquisa.ParamByName('NOSNUM').AsString   := RightStr(ABoleto.bankNumber, 12);
    LPesquisa.ParamByName('BCOENV').AsString   := '033';

    LPesquisa.Open;

    Result := Not LPesquisa.IsEmpty;
    If Not Result Then
      Exit;

    ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
    ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
    ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
    ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
    ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
    ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + FDadosCarteira.CarteiraCompleta.QuotedString;
      LPesquisa.Filtered := True;

      If Not LPesquisa.IsEmpty Then
      Begin
        ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
        ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
        ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
        ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
        ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
        ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
      End;
    End;
  Finally
    LPesquisa.Close;

    FreeAndNil(LPesquisa);
  End;
end;

function TBancoSantanderAPI.WorkspacePertenceAoClientIdDaCarteiraEEstaAtivo(
  AWorkSpaceId: String): Boolean;
  Var
    LRetornoPost: String;

    LStatus: Integer;

    LParametros: TStringList;

    LJsonRetorno: TJsonObject;
begin
  LParametros := Nil;
  LJsonRetorno := Nil;

  Result := False;

  FRestSynalist.StatusSemRaise := [400];
  Try
    LParametros := TStringList.Create;

    GerarToken;

    LParametros.Add('X-Application-Key: ' + FDadosCarteira.ClientId);
    LParametros.Add('Authorization: ' + FTokenUsoAtual);

    LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                 FDadosCarteira.LinkConsultaWorkSpace.Replace('[WORKSPACE]', AWorkSpaceId),
                                                 LParametros,
                                                 LRetornoPost,
                                                 EmptyStr,
                                                 'application/json');

    If Not MatchStr(LStatus.ToString, ['200', '201']) Then
      Exit;

    LJsonRetorno := TJsonObject.ParseJSONValue(LRetornoPost) As TJSONObject;
    If LJsonRetorno = Nil Then
      Exit;

    Result := RetornaValorJsonValue(LJsonRetorno, 'status').Equals('ACTIVE');
  Finally
    FRestSynalist.StatusSemRaise := [];

    if Assigned(LParametros) then
      FreeAndNil(LParametros);

    if Assigned(LJsonRetorno) then
      FreeAndNil(LJsonRetorno);
  End;
end;

procedure TBancoSantanderAPI.ExibeFormMensagemErro(AMensagem: String);
  Var
    LArqNaoGravados: TfrmArqNaoGravados;
begin
  Try
    pCriarFormularios(TfrmArqNaoGravados,LArqNaoGravados);
    LArqNaoGravados.Caption := 'AVISO';
    LArqNaoGravados.memResumo.WantReturns := True;
    LArqNaoGravados.memResumo.Lines.Add(AMensagem);
    LArqNaoGravados.ShowModal;
  Finally
    FreeAndNil(LArqNaoGravados);
  End;
end;

end.
