unit untTBancoSicoobApi;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
     System.Json, Rest.Json, System.DateUtils, Data.DB, WinApi.Windows, Vcl.Forms,
     untTRestSynalistAutban, Uni, UniClientDataset, untTRegBol, untFuncoesBoleto,
     untGravando, System.Variants, untTypesSistema, System.Zip, System.NetEncoding, untArqNaoGravados;

Type
  TRetornoPesquisaBancoSicoobAPI = class
  public
    siglaMovimento,
    dataInicioMovimento,
    dataFimMovimento,
    numeroCliente,
    numeroContrato,
    modalidade,
    numeroTitulo,
    seuNumero,
    dataVencimentoTitulo,
    valorTitulo,
    codigoBarras,
    dataMovimentoLiquidacao,
    dataLiquidacao,
    dataPrevisaoCredito,
    numeroBancoRecebedor,
    numeroAgenciaRecebedora,
    numeroContaCorrente,
    idTipoOpFinanceira,
    tipoOpFinanceira,
    valorAbatimento,
    valorDesconto,
    valorMora,
    valorLiquido,
    valorTarifaMovimento,

    dataMovimentoEntrada,
    dataEmissaoDocumento,
    dataLimitePagamento,
    
    situacaoBoleto,
    listaHistorico,

    nomeDoArquivo,

    QrCodeEmv,
    QrCodeLinkCitel: String;
  end;

Type
  TDadosCarteira = Record
    CarteiraBanco,
    EmpresaCarteira,
    CarteiraCompleta,

    LinkApi,
    LinkTokenApi,
    LinkConsulta,
    LinkConsultaEspecifico,
    LinkInclusao,
    LinkBaixa,
    LinkConsultaFaixasNossoNumero,
    LinkGeraRelatorio,
    LinkConsultaRelatorio,
    LinkDownloadArquivo,

    CodCarteira,
    EspTitulo,
    CodCooperativa,
    DigCooperativa,
    ContaCorrente,
    DAC,
    CodCedente,
    DigCedente,
    Modalidade,
    Convenio,
    Instrucao1,
    Instrucao2,
    Observacao1,
    Observacao2,
    Observacao3,
    Observacao4,
    Observacao5,
    CodProtesto,
    QtdDiasProtesto,
    QtdDiasLimitePagto,
    QtdDiasLimiteBaixa,
    CodNegativacao,
    QtdDiasNegativacao,
    PercentualMulta,
    TipoMulta,
    QtdDiasCredito,
    TipoDias,
    QtdDiasMora,

    TipoNossoNumero,

    Aceite,
    EnviaSacadorAvalista,

    GerarQRCodePix,
    ClientId,
    AccessToken,
    ChavePix,
    AutoIncremChavePix,
    CertificadoPfx,
    SenhaCertificado,

    VersaoAPI: String;

    Homologacao: Boolean;

    DadosEmpresa: TUniQuery;

    function ExisteAlgumaObservacaoCadastrada: Boolean;
  end;

Type
  TBancoSicoobAPI = class(TObject)
  private
    FDadosCarteira: TDadosCarteira;

    FRestSynalist: TRestSynalistAutban;

    FListaRequisicaoRegistroBoleto: TList<TRequisicaoRegistroBoleto>;

    FRetornoBancoSicoobAPI: TRetornoBoletoSicoob;

    FFaturamento,
    FTentarNovamente: Boolean;

    FPercentualMulta,
    FPercentualMora: Double;

    FListaRelatorios: TList<WideString>;

    procedure CarregaDadosCarteira(ACarteira: String);
    procedure DefinirURL;

    //Auxiliares
    function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    function RetornaValorString(AValor: String;
                                ATamanho: Integer): String;

    function RetornaDadosRetornoInclusaoBoleto(ADadosRetorno: String;
                                               ADadosDuplicata: TDataset;
                                               AReimpressao: Boolean = False): TRetornoBoletoSicoob;

    function RetornaDadosRetornoInclusaoBoletoVersao2(ADadosRetorno: String;
                                                      ADadosDuplicata: TDataset;
                                                      AReimpressao: Boolean = False): TRetornoBoletoSicoob;

    procedure AtualizaDadosExportacaoRemessa(ADadosDuplicata: TDataSet;
                                             ADadosRetorno: TRetornoBoletoSicoob);

    function AtualizaStatusRetornoErro(AStatusAtual: Integer;
                                       AErro: String): Integer;

    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function RetornaValorJsonValue(AObjeto: TJsonValue; ANomeCampo: String): String;
    function RetornaTextoErro(ACodigoRetorno,
                              ADadosRetorno: String): String;

    function ExtrairMensagemErro(const AJson: string): string;

    procedure AguardeCincoSegundos;
    //End Auxiliares


    //Requisição
    function RetornaDadosDaRequisicao(ADadosDuplicata,
                                      ADadosCliente: TDataset): String;

    function RetornaDadosDaRequisicaoVersao2(ADadosDuplicata,
                                             ADadosCliente: TDataset): String;

    procedure CarregaDescontosBoleto(var AJsonBoleto: TJsonObject;
                                     ADadosDuplicata: TDataset);
    procedure CarregaMultaBoleto(var AJsonBoleto: TJsonObject;
                                 ADadosDuplicata: TDataset);
    procedure CarregaJurosMoraBoleto(var AJsonBoleto: TJsonObject;
                                     ADadosDuplicata: TDataset);

    procedure CarregaNegativacaoBoleto(var AJsonBoleto: TJsonObject;
                                       ADadosDuplicata: TDataset);
    procedure CarregaProtestoBoleto(var AJsonBoleto: TJsonObject;
                                    ADadosDuplicata: TDataset);

    function RetornaDadosPagadorBoleto(ADadosCliente: TDataset): TJsonObject;

    function RetornaMensagensBoleto: TJsonArray;
    function RetornaMensagensBoletoVersao2: TJsonObject;

    procedure CarregaBeneficiarioFinalBoleto(var AJsonBoleto: TJsonObject);

    function UtilizaDescontoDePontualidade(AValorDesconto: Double): Boolean;
    //End Requisição

    //Alteração
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);
    procedure BaixaBoletoRegistradoVersao2(ADataSet: TDataSet);

    function DeveLimparOsDadosDoBoletoCancelamento(AStatus: Integer;
                                                   ARetorno,
                                                   ATxIdBoleto: String): Boolean;
    //end alteração

    //Consulta
    function RetornaRegistrosRelatorios(ADataInicial,
                                        ADataFinal: TDateTime): TUniQuery;

    procedure SolicitaNovoRelatorio(var ADataSet: TUniQuery;
                                    ADataAtual: TDateTime;
                                    ATipoMovimento: Integer;
                                    AAtualizarRegistroAtual: Boolean = False);

    procedure ConsultaTerminoDaSolicitacao(var ADataSet: TUniQuery;
                                           var AProgresso: TfrmGravando);

    //function RetornaDadosPesquisaBoleto(ARetornoRequisicao: String): TList<TRetornoPesquisaBancoSicoobAPI>;

    procedure RealizarDownloadDosRelatorios(var ADataSet: TUniQuery;
                                            var AProgresso: TfrmGravando);

    function ProcessaArquivosRelatorios(var AProgresso: TfrmGravando;
                                        ADataArquivo: String): TList<TRetornoPesquisaBancoSicoobAPI>;

    function RetornaStreamArquivoDescompactado(AArquivoBase64: String): TMemoryStream;

    procedure CorrigeDatas(var AValorDuplicata: String);
    procedure ExibeFormMensagemErro(AMensagem: String);
  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    procedure GerarToken;

    function CadastrarNovoBoleto(ADadosDuplicata,
                                 ADadosCliente: TDataSet;
                                 Var ANosNum: String): TRetornoBoletoSicoob;

    procedure ReimpressaoDeBoleto(AAutoIncrem: String);

    procedure CancelarBoletos(ADataSet:TDataSet);

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: TDateTime;
                                       AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicoobAPI>;

    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoSicoobAPI; out ADuplicata: untTypesSistema.TDuplicataCtr): Boolean;

    procedure GravarDadosRequisicaoRegistroBoleto;

    function RetornaCodigoOcorenciaSicoob(ABoleto: TRetornoPesquisaBancoSicoobAPI):String;

    property RetornoBancoSicoobAPI: TRetornoBoletoSicoob read FRetornoBancoSicoobAPI write FRetornoBancoSicoobAPI;

    property PercentualMulta: Double    Read FPercentualMulta  Write FPercentualMulta;
    property PercentualMora: Double    Read FPercentualMora   Write FPercentualMora;

    property Faturamento: Boolean Read FFaturamento Write FFaturamento;
    property TentarNovamente: Boolean Read FTentarNovamente Write FTentarNovamente;
  end;

implementation
Uses untFuncoesSimples, untFuncoes, untFuncAutban, untLogCtr;
{ TBancoSicoobAPI }

procedure TBancoSicoobAPI.AguardeCincoSegundos;
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(5000));
end;

procedure TBancoSicoobAPI.AtualizaDadosExportacaoRemessa(
  ADadosDuplicata: TDataSet; ADadosRetorno: TRetornoBoletoSicoob);
  Var
    LAtualiza: TUniQuery;
begin
  LAtualiza := fCriaQuery;

  Try
    LAtualiza.SQL.Text := 'UPDATE    ' +
                          '  CADREC  ' +
                          'SET ' +
                          '  CTR_BCOENV = :CODBCO, ' +
                          '  CTR_DTAENV = ' + fCurrentDate + ', ' +
                          '  CTR_TX_BOL = :TX_BOL, ' +
                          '  CTR_QRCODE = :QRCODE, ' +
                          '  CTR_LNKCIT = :LNKCIT ' +
                          'WHERE ' +
                          '  AUTOINCREM = :AUTINC ';

    LAtualiza.ParamByName('CODBCO').AsString := '756';

    If Not ADadosRetorno.QrCodeTxId.IsEmpty Then
    Begin
      LAtualiza.ParamByName('TX_BOL').AsString := ADadosRetorno.QrCodeTxId;
      LAtualiza.ParamByName('QRCODE').AsString := ADadosRetorno.QrCodeEmv;
      LAtualiza.ParamByName('LNKCIT').AsString := ADadosRetorno.QrCodeLinkCitel;
    End;

    LAtualiza.ParamByName('AUTINC').AsString := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;

    Try
      LAtualiza.ExecSQL;
    Except
      On E: Exception Do
        Raise E;
    End;

  Finally
    LAtualiza.Close;

    FreeAndNil(LAtualiza);
  End;
end;

function TBancoSicoobAPI.AtualizaStatusRetornoErro(AStatusAtual: Integer;
  AErro: String): Integer;
  Var
    LJSonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;
begin
  Result := AStatusAtual;

  If AErro.IsEmpty Then
    Exit;

  Try
    LJSonObject := TJSONObject.ParseJSONValue(AErro) As TJsonObject;

    If LJSonObject = Nil Then
      Exit;

    If LJSonObject.GetValue('mensagens') = Nil Then
      Exit;

    LJsonArray := TJSONObject.ParseJSONValue(LJSonObject.GetValue('mensagens').ToJSON) As TJsonArray;

    For LJsonValue In LJsonArray Do
    Begin
      If Not RetornaValorJsonValue(LJsonValue, 'codigo').IsEmpty Then
        Exit(StrToInt(RetornaValorJsonValue(LJsonValue, 'codigo')));
    End;
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

procedure TBancoSicoobAPI.BaixaBoletoRegistrado(ADataSet: TDataSet);
  Var
    LRetorno,
    LDadosRequisicao: String;

    LRequisicaoAlteraBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;
begin
  If FDadosCarteira.VersaoAPI.Equals('2') Then
  Begin
    BaixaBoletoRegistradoVersao2(ADataSet);

    Exit;
  End;

  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  FDadosCarteira.CarteiraCompleta;
  LRequisicaoAlteraBoleto.LCodBco := '756';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := '{"numeroCliente": ' + StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente).ToString + ', ' +
                       ' "codigoModalidade": ' + StrToInt(FDadosCarteira.Modalidade).ToString + '}';

  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := FDadosCarteira.LinkBaixa.Replace('[NOSSO_NUMERO]', ADataSet.FieldByName('CTR_NOSNUM').AsString);

  LParametros := TStringList.Create;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FDadosCarteira.AccessToken);
      LParametros.Add('client_id: ' + FDadosCarteira.ClientId);

      FRestSynalist.StatusSemRaise := [204];

      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   LRequisicaoAlteraBoleto.LLnkApi,
                                                   LParametros,
                                                   LRetorno,
                                                   LDadosRequisicao);

      If Not MatchStr(LStatus.ToString, ['204', '201']) Then
        Raise Exception.Create(LRetorno);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetorno;

      If DeveLimparOsDadosDoBoletoCancelamento(LStatus, LRetorno, ADataSet.FieldByName('CTR_TX_BOL').AsString) Then
      Begin
        fStartTransaction;
        untFuncAutban.LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                              'CANCELAMENTO DE BOLETO - BANCO SICOOB [ONLINE]',
                              'TBancoSicoobAPI');
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

    FRestSynalist.StatusSemRaise := [];
  End;
end;

procedure TBancoSicoobAPI.BaixaBoletoRegistradoVersao2(ADataSet: TDataSet);
  Var
    LRetorno,
    LDadosRequisicao: String;

    LRequisicaoAlteraBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;
begin
  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  FDadosCarteira.CarteiraCompleta;
  LRequisicaoAlteraBoleto.LCodBco := '756';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := '[{"numeroContrato": ' + StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente).ToString + ', ' +
                      '"modalidade": ' + StrToInt(FDadosCarteira.Modalidade).ToString + ', ' +
                      '"nossoNumero": ' + ADataset.FieldByName('CTR_NOSNUM').AsInteger.ToString + ', ' +
                      '"seuNumero": "' + ADataset.FieldByName('NRODUP').AsString +
                                         fPadR(ADataset.FieldByName('PARDUP').AsString, 3) +
                                         ADataset.FieldByName('CTR_ESPDOC').AsString + '"}]';

  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := FDadosCarteira.LinkBaixa;

  LParametros := TStringList.Create;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FDadosCarteira.AccessToken);
      LParametros.Add('client_id: ' + FDadosCarteira.ClientId);

      FRestSynalist.StatusSemRaise := [207];

      LStatus := FRestSynalist.ExecuteRestSynalist('PATCH',
                                                   LRequisicaoAlteraBoleto.LLnkApi,
                                                   LParametros,
                                                   LRetorno,
                                                   LDadosRequisicao);

      If Not MatchStr(LStatus.ToString, ['207', '201']) Then
        Raise Exception.Create(LRetorno);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetorno;

      If DeveLimparOsDadosDoBoletoCancelamento(LStatus, LRetorno, ADataSet.FieldByName('CTR_TX_BOL').AsString) Then
      Begin
        fStartTransaction;
        untFuncAutban.LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                              'CANCELAMENTO DE BOLETO - BANCO SICOOB [ONLINE]',
                              'TBancoSicoobAPI');
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

    FRestSynalist.StatusSemRaise := [];
  End;
end;

function TBancoSicoobAPI.CadastrarNovoBoleto(ADadosDuplicata,
  ADadosCliente: TDataSet; var ANosNum: String): TRetornoBoletoSicoob;
  Var
    LRetornoPost,
    LDadosRequisicao: String;

    LRequisicaoRegistroBoleto: TRequisicaoRegistroBoleto;

    LStatus: Integer;

    LParametros: TStringList;
begin
  Self.FTentarNovamente := True;
  Result := TRetornoBoletoSicoob.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  FDadosCarteira.CarteiraBanco + '-' +  FDadosCarteira.EmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '756';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.FFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente);
  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := FDadosCarteira.LinkInclusao;
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;

  LParametros := TStringList.Create;

  Try
    Try
      GerarToken;

      LParametros.Add('Authorization: ' + FDadosCarteira.AccessToken);
      LParametros.Add('Client_id: ' + FDadosCarteira.ClientId);

      FRestSynalist.StatusSemRaise := [207];
      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   FDadosCarteira.LinkInclusao,
                                                   LParametros,
                                                   LRetornoPost,
                                                   LDadosRequisicaO);

      If Not MatchStr(LStatus.ToString, ['200', '201', '207']) Then
        Raise Exception.Create(LRetornoPost);

      Self.FTentarNovamente := False;

      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

      Result := RetornaDadosRetornoInclusaoBoleto(LRetornoPost,
                                                  ADadosDuplicata);

      ANosNum := fStrZero(Result.nossoNumero, 9);

      AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                     Result);
    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

        LStatus := AtualizaStatusRetornoErro(LStatus,
                                             E.Message);

        Raise Exception.Create(RetornaTextoErro(LStatus.ToString, E.Message));
      End;
    End;
  Finally
    FListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);

    FRestSynalist.StatusSemRaise := [];
  End;
end;

procedure TBancoSicoobAPI.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes: String;

    LErroAPI: Boolean;

    LContadorTentativas: Integer;
begin
  fMensagem('ATENÇÃO', 'Os boletos baixados do banco Sicoob pela API tem um prazo máximo de ' +
                       '24 horas para baixa efetiva no banco, a partir do cancelamento ' +
                       'pelo sistema. ' + #13 +
                       'A baixa efetiva no banco pode ocorrer antes do prazo máximo estabelecido.', ['&Ok']);

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

            ExibeFormMensagemErro('Ocorreram erros ao cancelar o(s) boleto(s) no Banco Sicoob [Online].' + #13#10 + E.Message + #13#10 +
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

procedure TBancoSicoobAPI.CarregaBeneficiarioFinalBoleto(
  var AJsonBoleto: TJsonObject);
  Var
    LDadosBeneficiario: TJsonObject;
begin
  If Not FDadosCarteira.EnviaSacadorAvalista.Equals('S') Then
    Exit;

  LDadosBeneficiario := TJsonObject.Create;
  LDadosBeneficiario.AddPair('numeroCpfCnpj', fTiraCaracEspeciaisPonto(fRetCGCEmpresa(VS_strCodEmp)));
  LDadosBeneficiario.AddPair('nome', RetornaValorString(fRetNomeEmpresa, 50));

  AJsonBoleto.AddPair('beneficiarioFinal', LDadosBeneficiario);
end;

procedure TBancoSicoobAPI.CarregaDadosCarteira(ACarteira: String);
begin
  FDadosCarteira.CarteiraBanco := LeftStr(ACarteira,14);
  FDadosCarteira.EmpresaCarteira := RightStr(ACarteira, 3);
  FDadosCarteira.CarteiraCompleta :=ACarteira;

  FDadosCarteira.CodCarteira         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCART','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EspTitulo           := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ESPDOC_','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CodCooperativa      := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODCOPE','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.DigCooperativa      := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGCOPE','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CodCedente          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODCEDE','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.DigCedente          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGCEDE','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Convenio            := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMCONV','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ContaCorrente       := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODCCOR', '',FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.DAC                 := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIGCCOR', '',FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Instrucao1          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'INSTRU1','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Instrucao2          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'INSTRU2','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao1         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV1','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao2         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV2','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao3         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV3','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao4         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV4','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Observacao5         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'OBSERV5','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Aceite              := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PROACEI','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.Modalidade          := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'MODALID','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.EnviaSacadorAvalista:= fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ENVSACA','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.CodProtesto         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODPROT','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CodNegativacao      := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODNEGA','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasProtesto     := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIAPROT','0', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasNegativacao  := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIANEGA','0', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasLimitePagto  := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIALIMR','0', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.PercentualMulta     := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'PERMULT','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.TipoMulta           := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CODIGOMULTA','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasCredito      := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIACRED','0', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.TipoDias            := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'TIPODTACRE','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.QtdDiasMora         := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'DIAMORA', '0', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.TipoNossoNumero     := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'NUMNOSS','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.AutoIncremChavePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CHAPIX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.GerarQRCodePix := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'GERAPIX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.CertificadoPfx := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'AUTHPFX','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.ClientId := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'CLIENT_ID','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.AccessToken := 'Bearer ' + fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'ACCESS_TOKEN','', FDadosCarteira.EmpresaCarteira);
  FDadosCarteira.SenhaCertificado := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'SENCERT','', FDadosCarteira.EmpresaCarteira);

  FDadosCarteira.Homologacao := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'HOMOLOGACAO','', FDadosCarteira.EmpresaCarteira) = 'S';

  FDadosCarteira.VersaoAPI := fGetBancoConfig(0, FDadosCarteira.CarteiraBanco, 'VERSAPI','', FDadosCarteira.EmpresaCarteira);

  FRestSynalist.CarregaCertificados(FDadosCarteira.CarteiraCompleta,
                                    FDadosCarteira.CertificadoPfx,
                                    EmptyStr,
                                    EmptyStr,
                                    FDadosCarteira.SenhaCertificado);
end;

procedure TBancoSicoobAPI.CarregaDescontosBoleto(var AJsonBoleto: TJsonObject;
  ADadosDuplicata: TDataset);
  Var
    LDescontoSugerido,
    LDescontoPontualidade: Double;

    LDataDesconto: TDateTime;

    LUtilizaDescontos: Boolean;

    LCampoData,
    LCampoValor: String;
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
  Begin
    AJsonBoleto.AddPair('tipoDesconto', TJSONNumber.Create(0));

    Exit;
  End;

  AJsonBoleto.AddPair('tipoDesconto', TJSONNumber.Create(1));

  LCampoData := 'dataPrimeiroDesconto';
  LCampoValor := 'valorPrimeiroDesconto';

  If LDescontoSugerido > 0 Then
  Begin
    AJsonBoleto.AddPair(LCampoData, FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));
    AJsonBoleto.AddPair(LCampoValor, TJSONNumber.Create(LDescontoSugerido));

    LCampoData := 'dataSegundoDesconto';
    LCampoValor := 'valorSegundoDesconto';
  End;

  If LDescontoPontualidade > 0 Then
  Begin
    LDescontoPontualidade := fFormataFloat(RetornaValorDuplicata(ADadosDuplicata) *
                                           (LDescontoPontualidade / 100), 2);

    AJsonBoleto.AddPair(LCampoData, FormatDateTime('yyyy-mm-dd', LDataDesconto));
    AJsonBoleto.AddPair(LCampoValor, TJSONNumber.Create(LDescontoPontualidade));
  End;
end;

procedure TBancoSicoobAPI.CarregaJurosMoraBoleto(var AJsonBoleto: TJsonObject;
  ADadosDuplicata: TDataset);
  Var
    LValorMora : Double;

    LDiasParaMora: Integer;
begin
  LValorMora := fFormataFloat(Self.FPercentualMora, 5);

  If LValorMora = 0 Then
  Begin
    AJsonBoleto.AddPair('tipoJurosMora', TJSONNumber.Create(3));
    Exit;
  End;

  LDiasParaMora := 1;
  If Not StrToInt(FDadosCarteira.QtdDiasMora) = 0 Then
    LDiasParaMora := StrToInt(FDadosCarteira.QtdDiasMora);

  AJsonBoleto.AddPair('tipoJurosMora', TJSONNumber.Create(1));
  AJsonBoleto.AddPair('dataJurosMora', FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, LDiasParaMora)));
  AJsonBoleto.AddPair('valorJurosMora',  TJSONNumber.Create(RetornaValorDuplicata(ADadosDuplicata) * (LValorMora / 100)));
end;

procedure TBancoSicoobAPI.CarregaMultaBoleto(var AJsonBoleto: TJsonObject;
  ADadosDuplicata: TDataset);
  Var
    LValorMulta : Double;
begin
  If Self.FPercentualMulta = 0 Then
    Self.FPercentualMulta := fStrToFloat(FDadosCarteira.PercentualMulta);

  If Self.FPercentualMulta = 0 Then
  Begin
    AJsonBoleto.AddPair('tipoMulta', TJSONNumber.Create(0));

    Exit;
  End;

  LValorMulta := fFormataFloat(RetornaValorDuplicata(ADadosDuplicata) * (Self.FPercentualMulta/100), 2);

  AJsonBoleto.AddPair('tipoMulta', TJSONNumber.Create(StrToInt(FDadosCarteira.TipoMulta)));
  AJsonBoleto.AddPair('dataMulta', FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
  If FDadosCarteira.TipoMulta.Equals('1') Then
    AJsonBoleto.AddPair('valorMulta', TJSONNumber.Create(LValorMulta))
  Else
    AJsonBoleto.AddPair('valorMulta', TJSONNumber.Create(Self.FPercentualMulta));
end;

procedure TBancoSicoobAPI.CarregaNegativacaoBoleto(var AJsonBoleto: TJsonObject;
  ADadosDuplicata: TDataset);
begin
  AJsonBoleto.AddPair('codigoNegativacao', TJSONNumber.Create(StrToInt(FDadosCarteira.CodNegativacao)));

  If FDadosCarteira.CodNegativacao.Equals('3') Then
    Exit;

  AJsonBoleto.AddPair('numeroDiasNegativacao', TJSONNumber.Create(StrToInt(FDadosCarteira.QtdDiasNegativacao)));
end;

procedure TBancoSicoobAPI.CarregaProtestoBoleto(var AJsonBoleto: TJsonObject;
  ADadosDuplicata: TDataset);
begin
  AJsonBoleto.AddPair('codigoProtesto', TJSONNumber.Create(StrToInt(FDadosCarteira.CodProtesto)));

  If FDadosCarteira.CodProtesto.Equals('3') Then
    Exit;

  AJsonBoleto.AddPair('numeroDiasProtesto', TJSONNumber.Create(StrToInt(FDadosCarteira.QtdDiasProtesto)));
end;

function TBancoSicoobAPI.ConsultaBoletosPorPeriodo(ADataInicial,
  ADataFinal: TDateTime;
  AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoSicoobAPI>;
  Var
    LContador: Integer;

    LRelatorios: TUniQuery;

    LDataAtual: TDateTime;
begin
  Result := TList<TRetornoPesquisaBancoSicoobAPI>.Create;

  LRelatorios := RetornaRegistrosRelatorios(ADataInicial,
                                            ADataFinal);

  LDataAtual := ADataInicial;

  Try
    AProgresso.lblGravando.Caption := 'Aguarde... Solicitando relatórios.';
    AProgresso.pgbStatus.Position := 0;
    AProgresso.pgbStatus.Properties.Max := DaysBetween(LDataAtual, ADataFinal);
    Application.ProcessMessages;

    While (LDataAtual <= ADataFinal) Do
    Begin
      If Not LRelatorios.Locate('API_DTAINI;API_TIPMOV',
                                VarArrayOf([LDataAtual, 1]), []) Then
        SolicitaNovoRelatorio(LRelatorios, LDataAtual, 1);

      If Not LRelatorios.Locate('API_DTAINI;API_TIPMOV',
                                VarArrayOf([LDataAtual, 5]), []) Then
        SolicitaNovoRelatorio(LRelatorios, LDataAtual, 5);

      If Not LRelatorios.Locate('API_DTAINI;API_TIPMOV',
                                VarArrayOf([LDataAtual, 6]), []) Then
        SolicitaNovoRelatorio(LRelatorios, LDataAtual, 6);

      LDataAtual := IncDay(LDataAtual, 1);

      pStep(AProgresso.pgbStatus);
    End;

    LRelatorios.Filter := 'API_ARQUIV IS NULL';
    LRelatorios.Filtered := True;

    LContador := 0;
    While Not LRelatorios.IsEmpty Do
    Begin
      AProgresso.lblGravando.Caption := 'Aguarde... API do Sicoob está gerando os relatórios.';
      Aguarde(15000);

      ConsultaTerminoDaSolicitacao(LRelatorios, AProgresso);

      If LContador > 5 Then
        Break;

      Inc(LContador);
    End;

    If Not LRelatorios.IsEmpty Then
      Raise Exception.Create('INFOAPI - O Sicoob ainda não terminou de gerar os relatórios do período.' + #13 +
                             'Aguarde alguns minutos e faça a importação novamente.');


    LRelatorios.Filtered := False;

    AProgresso.lblGravando.Caption := 'Aguarde... Baixando os relatórios.';
    Application.ProcessMessages;

    RealizarDownloadDosRelatorios(LRelatorios, AProgresso);

    Result := ProcessaArquivosRelatorios(AProgresso,
                                         Concat(FormatDateTime('dd/mm/yyyy', ADataInicial),
                                                ' - ',
                                                FormatDateTime('dd/mm/yyyy', ADataFinal)));
  Finally
    LRelatorios.Close;

    FreeAndNil(LRelatorios);

    FRestSynalist.StatusSemRaise := [];
  End;
end;

procedure TBancoSicoobAPI.ConsultaTerminoDaSolicitacao(var ADataSet: TUniQuery;
  var AProgresso: TfrmGravando);
  Const
    MINUTOS_PARA_REFAZER_SOLICITACAO = 3;
  Var
    LParametros,
    LSolicitacoesEmProcessamento: TStringList;

    LStatus: Integer;

    LEmProcessamento: Boolean;

    LJSonRetorno: TJsonObject;

    LIdsArquivos,
    LLinkConsulta,
    LResposta: String;
begin
  LParametros := TStringList.Create;
  LSolicitacoesEmProcessamento := TStringList.Create;

  LJSonRetorno := TJsonObject.Create;

  AProgresso.pgbStatus.Position := 0;
  AProgresso.pgbStatus.Properties.Max := ADataset.Recordcount;
  Application.ProcessMessages;

  Try
    FRestSynalist.StatusSemRaise := [404];

    ADataset.First;

    While Not ADataset.Eof Do
    Begin
      If LSolicitacoesEmProcessamento.IndexOf(ADataset.FieldByName('AUTOINCREM').AsString) >= 0 Then
      Begin
        ADataset.Next;

        Continue;
      End;

      LLinkConsulta := FDadosCarteira.LinkConsultaRelatorio.Replace('[NUMERO_CLIENTE]', StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente).ToString)
                                                           .Replace('[NUMERO_CONTRATO]', StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente).ToString)
                                                           .Replace('[CODIGO_SOLICITACAO]', ADataset.FieldByName('API_ID_SOL').AsString);

      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FDadosCarteira.AccessToken);
      LParametros.Add('client_id: ' + FDadosCarteira.ClientId);

      LEmProcessamento := False;
      Try
        LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                     LLinkConsulta,
                                                     LParametros,
                                                     LResposta);
      Except
        On E: Exception Do
        Begin
          LEmProcessamento := E.Message.Contains('ainda em processamento');

          If (Not LEmProcessamento) And
             (Not E.Message.Contains('Solicitação não retornou nenhum registro')) Then
            Raise;

          LStatus := 404;
        End;
      End;

      If LEmProcessamento Then
      Begin
        If MinutesBetween(fRetDtaHraServidor,
                          DateOf(ADataset.FieldByName('API_DTASOL').AsDateTime) +
                          TimeOf(ADataset.FieldByName('API_HORSOL').AsDateTime)) >= MINUTOS_PARA_REFAZER_SOLICITACAO Then
          SolicitaNovoRelatorio(ADataset,
                                ADataset.FieldByName('API_DTAINI').AsDateTime,
                                ADataset.FieldByName('API_TIPMOV').AsInteger,
                                True);

        LSolicitacoesEmProcessamento.Add(ADataset.FieldByName('AUTOINCREM').AsString);
        ADataset.Next;

        Continue;
      End;

      If Not MatchStr(LStatus.ToString, ['200', '404']) Then
        Raise Exception.Create(LResposta);

      If LStatus = 404 Then
      Begin
        fStartTransaction;
        ADataset.Edit;
        ADataset.FieldByName('API_JSOREC').AsString := LResposta;
        ADataset.FieldByName('API_DTACON').AsDateTime := fRetDtaHraServidor;
        ADataset.FieldByName('API_ARQUIV').AsString := 'NA';
        ADataset.Post;
        fCommit;

        ADataset.First;

        Continue;
      End;

      LJSonRetorno := TJSONObject.ParseJSONValue(LResposta) as TJsonObject;
      LJSonRetorno := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('resultado').ToJson) as TJsonObject;

      LIdsArquivos := LJSonRetorno.GetValue('idArquivos').ToJson;

      fStartTransaction;

      ADataset.Edit;
      ADataset.FieldByName('API_JSOREC').AsString := LResposta;
      ADataset.FieldByName('API_DTACON').AsDateTime := fRetDtaHraServidor;
      ADataset.FieldByName('API_ARQUIV').AsString := LIdsArquivos.Replace('[', EmptyStr)
                                                                 .Replace(']', EmptyStr);
      ADataset.Post;

      fCommit;

      ADataset.First;

      pStep(AProgresso.pgbStatus);
    End;
  Finally
    FreeAndNil(LParametros);
    FreeAndNil(LSolicitacoesEmProcessamento);

    FreeAndNil(LJSonRetorno);

    SetLength(LIdsArquivos, 0);
  End;
end;

procedure TBancoSicoobAPI.CorrigeDatas(var AValorDuplicata: String);
  Var
    LValorData: TDateTime;
begin
  If AValorDuplicata.IsEmpty Then
    Exit;

  If TryStrToDateTime(Concat(AValorDuplicata.Substring(8, 2), '/',
                             AValorDuplicata.Substring(5, 2), '/',
                             AValorDuplicata.Substring(0, 4)),
                      LValorData) Then
    AValorDuplicata := DateToStr(LValorData);
end;

constructor TBancoSicoobAPI.Create(ACarteira: String);
begin
  FRestSynalist := TRestSynalistAutban.Create;

  CarregaDadosCarteira(ACarteira);
  DefinirURL;
  FListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  FRetornoBancoSicoobAPI := TRetornoBoletoSicoob.Create;
end;

procedure TBancoSicoobAPI.DefinirURL;
begin
  FDadosCarteira.LinkApi := 'https://api.sicoob.com.br/cobranca-bancaria/v' + FDadosCarteira.VersaoAPI + '/';
  If FDadosCarteira.Homologacao Then
    FDadosCarteira.LinkApi := 'https://sandbox.sicoob.com.br/sicoob/sandbox/cobranca-bancaria/v' + FDadosCarteira.VersaoAPI + '/';

  FDadosCarteira.LinkInclusao := FDadosCarteira.LinkApi + 'boletos';

  FDadosCarteira.LinkGeraRelatorio := FDadosCarteira.LinkApi + 'boletos/movimentacoes';

  FDadosCarteira.LinkConsultaRelatorio := FDadosCarteira.LinkApi + 'boletos/movimentacoes?numeroCliente=[NUMERO_CLIENTE]&' +
                                                                   'codigoSolicitacao=[CODIGO_SOLICITACAO]';

  FDadosCarteira.LinkDownloadArquivo := FDadosCarteira.LinkApi + 'boletos/movimentacoes/download?numeroCliente=[NUMERO_CLIENTE]&' +
                                                                 'codigoSolicitacao=[CODIGO_SOLICITACAO]&' +
                                                                 'idArquivo=[ID_ARQUIVO]';

  FDadosCarteira.LinkBaixa := FDadosCarteira.LinkApi + 'boletos/[NOSSO_NUMERO]/baixar';

  If FDadosCarteira.VersaoAPI.Equals('2') Then
  Begin
     FDadosCarteira.LinkGeraRelatorio := FDadosCarteira.LinkApi + 'boletos/solicitacoes/movimentacao';

    FDadosCarteira.LinkConsultaRelatorio := FDadosCarteira.LinkApi + 'boletos/solicitacoes/movimentacao?' +
                                                                     'numeroContrato=[NUMERO_CONTRATO]&' +
                                                                     'codigoSolicitacao=[CODIGO_SOLICITACAO]';

    FDadosCarteira.LinkDownloadArquivo := FDadosCarteira.LinkApi + 'boletos/movimentacao-download?' +
                                                                   'numeroContrato=[NUMERO_CONTRATO]&' +
                                                                   'codigoSolicitacao=[CODIGO_SOLICITACAO]&' +
                                                                   'idArquivo=[ID_ARQUIVO]';

    FDadosCarteira.LinkBaixa := FDadosCarteira.LinkApi + 'boletos/baixa';
  End;

  FDadosCarteira.LinkConsultaEspecifico := FDadosCarteira.LinkApi + 'boletos';

  FDadosCarteira.LinkConsultaFaixasNossoNumero := FDadosCarteira.LinkApi + 'faixas_nosso_numero';

  FDadosCarteira.LinkTokenApi := 'https://auth.sicoob.com.br/auth/realms/cooperado/protocol/openid-connect/token';
end;

destructor TBancoSicoobAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;
  FreeAndNil(FRestSynalist);
  FreeAndNil(FListaRequisicaoRegistroBoleto);
  inherited;
end;

function TBancoSicoobAPI.DeveLimparOsDadosDoBoletoCancelamento(AStatus: Integer;
  ARetorno, ATxIdBoleto: String): Boolean;
  Var
    LJsonArray: TJsonArray;

    LJsonObject: TJsonObject;
begin
  Result := MatchStr(AStatus.ToString, ['204', '207']);

  If Not Result Then
    Exit;

  Try
    If FDadosCarteira.VersaoAPI.Equals('2') Then
    Begin
      LJsonObject := TJsonObject.ParseJSONValue(AREtorno) As TJsonObject;

      LJsonArray := TJsonObject.ParseJSONValue(LJsonObject.GetValue('resultado').ToJson) As TJsonArray;

      Result := RetornaValorJson(LJsonArray.Items[0].GetValue<TJsonObject>('status'), 'codigo').Equals('200');

      FreeAndNil(LJsonObject);
    End;
  Except
    Raise;
  End;
end;

procedure TBancoSicoobAPI.GerarToken;
  Var
    LDadosEnvio: String;

    LParametros: TStringList;
begin
  If FDadosCarteira.Homologacao Then
    Exit;

  LParametros := TStringList.Create;

  LDadosEnvio := 'grant_type=client_credentials&' +
                 'client_id=' + FDadosCarteira.ClientId + '&' +
                 'scope=boletos_inclusao boletos_consulta boletos_alteracao';

  If FDadosCarteira.VersaoAPI.Equals('2') Then
    LDadosEnvio := 'grant_type=client_credentials&' +
                   'client_id=' + FDadosCarteira.ClientId + '&' +
                   'scope=cobranca_boletos_consultar cobranca_boletos_incluir cobranca_boletos_pagador cobranca_boletos_segunda_via ' +
                   'cobranca_boletos_descontos cobranca_boletos_abatimentos cobranca_boletos_valor_nominal cobranca_boletos_seu_numero ' +
                   'cobranca_boletos_especie_documento cobranca_boletos_baixa cobranca_boletos_rateio_credito cobranca_pagadores ' +
                   'cobranca_boletos_negativacoes_incluir cobranca_boletos_negativacoes_alterar cobranca_boletos_negativacoes_baixar ' +
                   'cobranca_boletos_protestos_incluir cobranca_boletos_protestos_alterar cobranca_boletos_protestos_desistir ' +
                   'cobranca_boletos_solicitacao_movimentacao_incluir cobranca_boletos_solicitacao_movimentacao_consultar ' +
                   'cobranca_boletos_solicitacao_movimentacao_download cobranca_boletos_prorrogacoes_data_vencimento cobranca_boletos_prorrogacoes_data_limite_pagamento ' +
                   'cobranca_boletos_encargos_multas cobranca_boletos_encargos_juros_mora cobranca_boletos_pix';

  Try
    Try
      FDadosCarteira.AccessToken := 'Bearer ' + FRestSynalist.GetToken('POST',
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

procedure TBancoSicoobAPI.GravarDadosRequisicaoRegistroBoleto;
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

function TBancoSicoobAPI.ProcessaArquivosRelatorios(
  var AProgresso: TfrmGravando; ADataArquivo: String): TList<TRetornoPesquisaBancoSicoobAPI>;
  Var
    LArquivo: WideString;

    LFileStreamJson: TMemoryStream;

    LArquivoJson: TStringList;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LMovimento: TRetornoPesquisaBancoSicoobAPI;
begin
  Result := TList<TRetornoPesquisaBancoSicoobAPI>.Create;

  AProgresso.lblGravando.Caption := 'Aguarde... Processando registros.';
  AProgresso.pgbStatus.Position := 0;
  AProgresso.pgbStatus.Properties.Max := FListaRelatorios.Count;
  Application.ProcessMessages;

  Try
    For LArquivo In FListaRelatorios Do
    Begin
      LFileStreamJson := RetornaStreamArquivoDescompactado(LArquivo);

      LArquivoJson := TStringList.Create;
      LArquivoJson.LoadFromStream(LFileStreamJson);

      LFileStreamJson.Free;

      LArquivoJson.Text := LArquivoJson.Text.Replace(''#$D#$A'', EmptyStr);

      LJsonArray := TJsonObject.ParseJSONValue(LArquivoJson.Text.Trim) As TJSONArray;

      If LJsonArray <> Nil Then
      Begin
        For LJsonValue In LJsonArray Do
        Begin
          LMovimento := TRetornoPesquisaBancoSicoobAPI.Create;

          LMovimento.siglaMovimento := RetornaValorJsonValue(LJsonValue, 'siglaMovimento');
          LMovimento.dataInicioMovimento := RetornaValorJsonValue(LJsonValue, 'dataInicioMovimento');
          LMovimento.dataFimMovimento := RetornaValorJsonValue(LJsonValue, 'dataFimMovimento');
          LMovimento.numeroCliente := RetornaValorJsonValue(LJsonValue, 'numeroCliente');
          LMovimento.numeroContrato := RetornaValorJsonValue(LJsonValue, 'numeroContrato');
          LMovimento.modalidade := RetornaValorJsonValue(LJsonValue, 'modalidade');
          LMovimento.numeroTitulo := fStrZero(RetornaValorJsonValue(LJsonValue, 'numeroTitulo'), 8);
          LMovimento.seuNumero := RetornaValorJsonValue(LJsonValue, 'seuNumero');
          LMovimento.dataVencimentoTitulo := RetornaValorJsonValue(LJsonValue, 'dataVencimentoTitulo');
          LMovimento.valorTitulo := RetornaValorJsonValue(LJsonValue, 'valorTitulo');
          LMovimento.codigoBarras := RetornaValorJsonValue(LJsonValue, 'codigoBarras');
          LMovimento.dataMovimentoLiquidacao := RetornaValorJsonValue(LJsonValue, 'dataMovimentoLiquidacao');
          LMovimento.dataLiquidacao := RetornaValorJsonValue(LJsonValue, 'dataLiquidacao');
          LMovimento.dataPrevisaoCredito := RetornaValorJsonValue(LJsonValue, 'dataPrevisaoCredito');
          LMovimento.idTipoOpFinanceira := RetornaValorJsonValue(LJsonValue, 'idTipoOpFinanceira');
          LMovimento.tipoOpFinanceira := RetornaValorJsonValue(LJsonValue, 'tipoOpFinanceira');
          LMovimento.valorAbatimento := RetornaValorJsonValue(LJsonValue, 'valorAbatimento');
          LMovimento.valorDesconto := RetornaValorJsonValue(LJsonValue, 'valorDesconto');
          LMovimento.valorMora := RetornaValorJsonValue(LJsonValue, 'valorMora');
          LMovimento.valorLiquido := RetornaValorJsonValue(LJsonValue, 'valorLiquido');
          LMovimento.valorTarifaMovimento := RetornaValorJsonValue(LJsonValue, 'valorTarifaMovimento');

          LMovimento.dataMovimentoEntrada := RetornaValorJsonValue(LJsonValue, 'dataMovimentoEntrada');
          LMovimento.dataEmissaoDocumento := RetornaValorJsonValue(LJsonValue, 'dataEmissaoDocumento');
          LMovimento.dataLimitePagamento := RetornaValorJsonValue(LJsonValue, 'dataLimitePagamento');
          LMovimento.numeroContaCorrente := RetornaValorJsonValue(LJsonValue, 'numeroContaCorrente');
          LMovimento.QrCodeEmv := RetornaValorJsonValue(LJsonValue, 'qrCode');

          LMovimento.nomeDoArquivo := Concat(ADataArquivo + ' - Movimento: ' + LMovimento.siglaMovimento);

          CorrigeDatas(LMovimento.dataInicioMovimento);
          CorrigeDatas(LMovimento.dataFimMovimento);
          CorrigeDatas(LMovimento.dataVencimentoTitulo);
          CorrigeDatas(LMovimento.dataMovimentoLiquidacao);
          CorrigeDatas(LMovimento.dataLiquidacao);
          CorrigeDatas(LMovimento.dataPrevisaoCredito);

          LMovimento.valorTitulo := FormatFloat(',0.00', RetornaValorImportacaoDouble(LMovimento.valorTitulo, EmptyStr, EmptyStr, '756')).Replace('.', EmptyStr);
          LMovimento.valorAbatimento := FormatFloat(',0.00', RetornaValorImportacaoDouble(LMovimento.valorAbatimento, EmptyStr, EmptyStr, '756')).Replace('.', EmptyStr);
          LMovimento.valorDesconto := FormatFloat(',0.00', RetornaValorImportacaoDouble(LMovimento.valorDesconto, EmptyStr, EmptyStr, '756')).Replace('.', EmptyStr);
          LMovimento.valorMora := FormatFloat(',0.00', RetornaValorImportacaoDouble(LMovimento.valorMora, EmptyStr, EmptyStr, '756')).Replace('.', EmptyStr);
          LMovimento.valorLiquido := FormatFloat(',0.00', RetornaValorImportacaoDouble(LMovimento.valorLiquido, EmptyStr, EmptyStr, '756')).Replace('.', EmptyStr);
          LMovimento.valorTarifaMovimento := FormatFloat(',0.00', RetornaValorImportacaoDouble(LMovimento.valorTarifaMovimento, EmptyStr, EmptyStr, '756')).Replace('.', EmptyStr);

          Result.Add(LMovimento);
        End;

        FreeAndNil(LJsonArray);
      End;

      pStep(AProgresso.pgbStatus);
    End;

    FreeAndNil(LArquivoJson);
  Except
    Raise;
  End;
end;

procedure TBancoSicoobAPI.RealizarDownloadDosRelatorios(var ADataSet: TUniQuery;
  var AProgresso: TfrmGravando);
  Var
    LParametros: TStringList;

    LStatus: Integer;

    LJSonRetorno: TJsonObject;

    LLinkConsulta,
    LResposta,
    LIdArquivo: String;
begin
  LParametros := TStringList.Create;
  LJSonRetorno := TJsonObject.Create;

  FListaRelatorios := TList<WideString>.Create;

  AProgresso.pgbStatus.Position := 0;
  AProgresso.pgbStatus.Properties.Max := ADataset.RecordCount;
  Application.ProcessMessages;

  Try
    ADataset.First;

    While Not ADataset.Eof Do
    Begin
      If ADataset.FieldByName('API_ARQUIV').AsString.IsEmpty Then
      Begin
        ADataset.Next;
        pStep(AProgresso.pgbStatus);

        Continue;
      End;

      If ADataset.FieldByName('API_ARQUIV').AsString.Equals('NA') Then
      Begin
        ADataset.Next;
        pStep(AProgresso.pgbStatus);

        Continue;
      End;

      For LIdArquivo In ADataset.FieldByName('API_ARQUIV').AsString.Split([',']) Do
      Begin
        LLinkConsulta := FDadosCarteira.LinkDownloadArquivo.Replace('[NUMERO_CLIENTE]', StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente).ToString)
                                                           .Replace('[NUMERO_CONTRATO]', StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente).ToString)
                                                           .Replace('[CODIGO_SOLICITACAO]', ADataset.FieldByName('API_ID_SOL').AsString)
                                                           .Replace('[ID_ARQUIVO]', LIdArquivo.Trim);

        GerarToken;

        LParametros.Clear;
        LParametros.Add('Authorization: ' + FDadosCarteira.AccessToken);
        LParametros.Add('client_id: ' + FDadosCarteira.ClientId);

        LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                     LLinkConsulta,
                                                     LParametros,
                                                     LResposta);

        If Not MatchStr(LStatus.ToString, ['200']) Then
          Raise Exception.Create(LResposta);

        LJSonRetorno := TJSONObject.ParseJSONValue(LResposta) as TJsonObject;
        LJSonRetorno := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('resultado').ToJson) as TJsonObject;

        FListaRelatorios.Add(LJSonRetorno.GetValue<WideString>('arquivo'));
      End;

      ADataset.Next;

      pStep(AProgresso.pgbStatus);
    End;
  Finally
    FreeAndNil(LParametros);

    FreeAndNil(LJSonRetorno);
  End;
end;

procedure TBancoSicoobAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRegistro: String;

    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  FRetornoBancoSicoobAPI := TRetornoBoletoSicoob.Create;

  Try
    Try
      LJsonRegistro := TFuncoesPixBoleto.RetornaJsonRegistroBoleto(AAutoIncrem, '756');

      If fEmptyStr(LJsonRegistro) Then
      Begin
        LConsulta.Close;
        LConsulta.SQL.Clear;
        LConsulta.SQL.Add('SELECT CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE, CTR_LINDIG ' +
                          'FROM CADREC WHERE AUTOINCREM = :AUTOINC');

        LConsulta.ParamByName('AUTOINC').AsString := AAutoIncrem;
        LConsulta.Open;

        FRetornoBancoSicoobAPI.nossoNumero := LConsulta.FieldByName('CTR_NOSNUM').AsString;
        FRetornoBancoSicoobAPI.QrCodeTxId := LConsulta.FieldByName('CTR_TX_BOL').AsString;
        FRetornoBancoSicoobAPI.QrCodeEmv := LConsulta.FieldByName('CTR_QRCODE').AsString;
        FRetornoBancoSicoobAPI.linhaDigitavel := LConsulta.FieldByName('CTR_LINDIG').AsString;
        FRetornoBancoSicoobAPI.codigoBarras := Copy(FRetornoBancoSicoobAPI.linhaDigitavel, 01, 04) +
                                               Copy(FRetornoBancoSicoobAPI.linhaDigitavel, 33, 15) +
                                               Copy(FRetornoBancoSicoobAPI.linhaDigitavel, 05, 05) +
                                               Copy(FRetornoBancoSicoobAPI.linhaDigitavel, 11, 08) +
                                               Copy(FRetornoBancoSicoobAPI.linhaDigitavel, 19, 02) +
                                               Copy(FRetornoBancoSicoobAPI.linhaDigitavel, 22, 10);

        Exit;
      End;

      FRetornoBancoSicoobAPI := RetornaDadosRetornoInclusaoBoleto(LJsonRegistro,
                                                                  Nil,
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

function TBancoSicoobAPI.RetornaCodigoOcorenciaSicoob(
  ABoleto: TRetornoPesquisaBancoSicoobAPI): String;
begin
  Result := '06';

  If ABoleto.siglaMovimento.Equals('ENTR') Then
    Exit('02')
  Else If ABoleto.siglaMovimento.Equals('BAIX') Then
    Exit('09');
end;

function TBancoSicoobAPI.RetornaDadosDaRequisicao(ADadosDuplicata,
  ADadosCliente: TDataset): String;
  Var
    LJSONBoleto: TJSONObject;
Begin
  If FDadosCarteira.VersaoAPI.Equals('2') Then
    Exit(RetornaDadosDaRequisicaoVersao2(ADadosDuplicata, ADadosCliente));

  LJSONBoleto := TJSONObject.Create;

  Try
    LJSONBoleto.AddPair('numeroCliente', TJSONNumber.Create(StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente)));
    LJSONBoleto.AddPair('codigoModalidade', TJSONNumber.Create(StrToInt(FDadosCarteira.Modalidade)));
    LJSONBoleto.AddPair('numeroContaCorrente', TJSONNumber.Create(StrToInt64(FDadosCarteira.ContaCorrente + FDadosCarteira.DAC)));
    LJSONBoleto.AddPair('codigoEspecieDocumento', FDadosCarteira.EspTitulo.Substring(4, 3).Trim);

    LJSONBoleto.AddPair('dataEmissao', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));
    LJSONBoleto.AddPair('seuNumero', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                     fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3) +
                                     ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString);
    LJSONBoleto.AddPair('identificacaoBoletoEmpresa', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                      fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3) +
                                                      ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                                                      ADadosDuplicata.FieldByName('CTR_CODEMP').AsString);

    LJSONBoleto.AddPair('identificacaoEmissaoBoleto', TJSONNumber.Create(2));
    LJSONBoleto.AddPair('identificacaoDistribuicaoBoleto', TJSONNumber.Create(2));

    LJSONBoleto.AddPair('valor', TJSONNumber.Create(RetornaValorDuplicata(ADadosDuplicata)));
    LJSONBoleto.AddPair('dataVencimento', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

    If FDadosCarteira.Instrucao1 = '19' Then
      LJSONBoleto.AddPair('dataLimitePagamento', FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                     StrToInt(FDadosCarteira.QtdDiasLimitePagto))));

    LJSONBoleto.AddPair('numeroParcela', TJSONNumber.Create(1));

    CarregaDescontosBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaMultaBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaJurosMoraBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaNegativacaoBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaProtestoBoleto(LJSONBoleto, ADadosDuplicata);

    LJSONBoleto.AddPair('pagador', RetornaDadosPagadorBoleto(ADadosCliente));

    LJSONBoleto.AddPair('mensagensInstrucao', RetornaMensagensBoleto);

    If FDadosCarteira.GerarQRCodePix.Equals('S') Then
      LJSONBoleto.AddPair('codigoCadastrarPIX', TJSONNumber.Create(1))
    Else
      LJSONBoleto.AddPair('codigoCadastrarPIX', TJSONNumber.Create(2));

    CarregaBeneficiarioFinalBoleto(LJSONBoleto);

    Result := TJson.Format(LJSONBoleto);
  Finally
    FreeAndNil(LJSONBoleto);
  End;
end;

function TBancoSicoobAPI.RetornaDadosDaRequisicaoVersao2(ADadosDuplicata,
  ADadosCliente: TDataset): String;
  Var
    LJSONBoleto: TJSONObject;

    LJsonArray: TJsonArray;
Begin
  LJSONBoleto := TJSONObject.Create;

  Try
    LJSONBoleto.AddPair('numeroContrato', TJSONNumber.Create(StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente)));
    LJSONBoleto.AddPair('modalidade', TJSONNumber.Create(StrToInt(FDadosCarteira.Modalidade)));
    LJSONBoleto.AddPair('numeroContaCorrente', TJSONNumber.Create(StrToInt64(FDadosCarteira.ContaCorrente + FDadosCarteira.DAC)));
    LJSONBoleto.AddPair('especieDocumento', FDadosCarteira.EspTitulo.Substring(4, 3).Trim);

    LJSONBoleto.AddPair('dataEmissao', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));
    LJSONBoleto.AddPair('seuNumero', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                     fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3) +
                                     ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString);
    LJSONBoleto.AddPair('identificacaoBoletoEmpresa', ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                      fPadR(ADadosDuplicata.FieldByName('CTR_PARCEL').AsString, 3) +
                                                      ADadosDuplicata.FieldByName('CTR_ESPDOC').AsString +
                                                      ADadosDuplicata.FieldByName('CTR_CODEMP').AsString);

    LJSONBoleto.AddPair('identificacaoEmissaoBoleto', TJSONNumber.Create(2));
    LJSONBoleto.AddPair('identificacaoDistribuicaoBoleto', TJSONNumber.Create(2));

    LJSONBoleto.AddPair('valor', TJSONNumber.Create(RetornaValorDuplicata(ADadosDuplicata)));
    LJSONBoleto.AddPair('dataVencimento', FormatDateTime('yyyy-mm-dd', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

    If FDadosCarteira.Instrucao1 = '19' Then
      LJSONBoleto.AddPair('dataLimitePagamento', FormatDateTime('yyyy-mm-dd', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                     StrToInt(FDadosCarteira.QtdDiasLimitePagto))));

    LJSONBoleto.AddPair('numeroParcela', TJSONNumber.Create(1));

    CarregaDescontosBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaMultaBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaJurosMoraBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaNegativacaoBoleto(LJSONBoleto, ADadosDuplicata);

    CarregaProtestoBoleto(LJSONBoleto, ADadosDuplicata);

    LJSONBoleto.AddPair('pagador', RetornaDadosPagadorBoleto(ADadosCliente));

    If FDadosCarteira.ExisteAlgumaObservacaoCadastrada Then
      LJSONBoleto.AddPair('mensagensInstrucao', RetornaMensagensBoletoVersao2);

    If FDadosCarteira.GerarQRCodePix.Equals('S') Then
      LJSONBoleto.AddPair('codigoCadastrarPIX', TJSONNumber.Create(1))
    Else
      LJSONBoleto.AddPair('codigoCadastrarPIX', TJSONNumber.Create(2));

    CarregaBeneficiarioFinalBoleto(LJSONBoleto);

    LJsonArray := TJsonArray.Create;
    LJsonArray.Add(LJSONBoleto);

    Result := TJson.Format(LJsonArray);
  Finally
    FreeAndNil(LJSONBoleto);
  End;
end;

function TBancoSicoobAPI.RetornaDadosPagadorBoleto(
  ADadosCliente: TDataset): TJsonObject;
  Var
    LEmail: String;
begin
  Result := TJsonObject.Create;

  Result.AddPair('numeroCpfCnpj', fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString));
  Result.AddPair('nome', RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 50));
  Result.AddPair('endereco', RetornaValorString(Concat(ADadosCliente.FieldByName('CLI_ENDERE').AsString,
                                                       ADadosCliente.FieldByName('CLI_ENDNUM').AsString), 40));
  Result.AddPair('bairro', RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 30));
  Result.AddPair('cidade', RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 40));
  Result.AddPair('cep', fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));
  Result.AddPair('uf', RetornaValorString(ADadosCliente.FieldByName('CID_ESTADO').AsString, 2));

  LEmail := ADadosCliente.FieldByName('CLI_EMCOB1').AsString.Replace(';', EmptyStr);
  If LEmail.IsEmpty Then
    LEmail := ADadosCliente.FieldByName('CLI_EMAIL_').AsString.Replace(';', EmptyStr);

  If Not fEmailValido(LEmail,False) Then
    Exit;

  If FDadosCarteira.VersaoAPI.Equals('2') Then
  Begin
    LEmail := '[' + LEmail + ']';
    Result.AddPair('email', TJsonObject.ParseJSONValue(LEmail) As TJsonArray);
  End
  Else
    Result.AddPair('email', LEmail);
end;

 {function TBancoSicoobAPI.RetornaDadosPesquisaBoleto(
  ARetornoRequisicao: String): TList<TRetornoPesquisaBancoSicoobAPI>;
 Var
    LJsonRetorno: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LBoleto: TRetornoPesquisaBancoSicoobAPI;
begin
  Result := TList<TRetornoPesquisaBancoSicoobAPI>.Create;

  If ARetornoRequisicao.IsEmpty Then
    Exit;

  LJsonRetorno := TJSONObject.ParseJSONValue(ARetornoRequisicao) as TJSONObject;

  LJsonArray := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('resultado').ToString) as TJSONArray;

  For LJsonValue In LJsonArray Do
  Begin
    LBoleto := TRetornoPesquisaBancoSicoobAPI.Create;

    LBoleto.numeroCliente := RetornaValorJsonValue(LJsonValue, 'numeroCliente');
    LBoleto.codigoModalidade := RetornaValorJsonValue(LJsonValue, 'codigoModalidade');
    LBoleto.numeroContaCorrente := RetornaValorJsonValue(LJsonValue, 'numeroContaCorrente');
    LBoleto.codigoEspecieDocumento := RetornaValorJsonValue(LJsonValue, 'codigoEspecieDocumento');
    LBoleto.dataEmissao := RetornaValorJsonValue(LJsonValue, 'dataEmissao');
    LBoleto.nossoNumero := RetornaValorJsonValue(LJsonValue, 'nossoNumero');
    LBoleto.seuNumero := RetornaValorJsonValue(LJsonValue, 'seuNumero');
    LBoleto.identificacaoBoletoEmpresa := RetornaValorJsonValue(LJsonValue, 'identificacaoBoletoEmpresa');
    LBoleto.codigoBarras := RetornaValorJsonValue(LJsonValue, 'codigoBarras');
    LBoleto.linhaDigitavel := RetornaValorJsonValue(LJsonValue, 'linhaDigitavel');
    LBoleto.identificacaoEmissaoBoleto := RetornaValorJsonValue(LJsonValue, 'identificacaoEmissaoBoleto');
    LBoleto.identificacaoDistribuicaoBoleto := RetornaValorJsonValue(LJsonValue, 'identificacaoDistribuicaoBoleto');
    LBoleto.valor := RetornaValorJsonValue(LJsonValue, 'valor');
    LBoleto.dataVencimento := RetornaValorJsonValue(LJsonValue, 'dataVencimento');
    LBoleto.dataLimitePagamento := RetornaValorJsonValue(LJsonValue, 'dataLimitePagamento');
    LBoleto.valorAbatimento := RetornaValorJsonValue(LJsonValue, 'valorAbatimento');
    LBoleto.tipoDesconto := RetornaValorJsonValue(LJsonValue, 'tipoDesconto');
    LBoleto.dataPrimeiroDesconto := RetornaValorJsonValue(LJsonValue, 'dataPrimeiroDesconto');
    LBoleto.valorPrimeiroDesconto := RetornaValorJsonValue(LJsonValue, 'valorPrimeiroDesconto');
    LBoleto.dataSegundoDesconto := RetornaValorJsonValue(LJsonValue, 'dataSegundoDesconto');
    LBoleto.valorSegundoDesconto := RetornaValorJsonValue(LJsonValue, 'valorSegundoDesconto');
    LBoleto.tipoMulta := RetornaValorJsonValue(LJsonValue, 'tipoMulta');
    LBoleto.dataMulta := RetornaValorJsonValue(LJsonValue, 'dataMulta');
    LBoleto.valorMulta := RetornaValorJsonValue(LJsonValue, 'valorMulta');
    LBoleto.tipoJurosMora := RetornaValorJsonValue(LJsonValue, 'tipoJurosMora');
    LBoleto.dataJurosMora := RetornaValorJsonValue(LJsonValue, 'dataJurosMora');
    LBoleto.valorJurosMora := RetornaValorJsonValue(LJsonValue, 'valorJurosMora');
    LBoleto.numeroParcela := RetornaValorJsonValue(LJsonValue, 'numeroParcela');
    LBoleto.aceite := RetornaValorJsonValue(LJsonValue, 'aceite');
    LBoleto.codigoNegativacao := RetornaValorJsonValue(LJsonValue, 'codigoNegativacao');
    LBoleto.numeroDiasNegativacao := RetornaValorJsonValue(LJsonValue, 'numeroDiasNegativacao');
    LBoleto.codigoProtesto := RetornaValorJsonValue(LJsonValue, 'codigoProtesto');
    LBoleto.numeroDiasProtesto := RetornaValorJsonValue(LJsonValue, 'numeroDiasProtesto');
    LBoleto.quantidadeDiasFloat := RetornaValorJsonValue(LJsonValue, 'quantidadeDiasFloat');

    LBoleto.situacaoBoleto := RetornaValorJsonValue(LJsonValue, 'situacaoBoleto');

    LBoleto.QrCodeEmv := RetornaValorJsonValue(LJsonValue, 'qrCode');
  End;
end;                      }

function TBancoSicoobAPI.RetornaDadosRetornoInclusaoBoleto(
  ADadosRetorno: String; ADadosDuplicata: TDataset;
  AReimpressao: Boolean = False): TRetornoBoletoSicoob;
  Var
    LJsonRetorno: TJSONObject;
begin
  If FDadosCarteira.VersaoAPI.Equals('2') Then
    Exit(RetornaDadosRetornoInclusaoBoletoVersao2(ADadosRetorno, ADadosDuplicata, AReimpressao));

  Result := TRetornoBoletoSicoob.Create;

  LJsonRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;

  LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('resultado').ToString) as TJSONObject;

  Result.nossoNumero := RetornaValorJson(LJsonRetorno, 'nossoNumero');
  If Not Result.nossoNumero.IsEmpty Then
    Result.nossoNumero := fStrZero(Result.nossoNumero, 8);

  Result.linhaDigitavel := RetornaValorJson(LJsonRetorno, 'linhaDigitavel');
  Result.codigoBarras := RetornaValorJson(LJsonRetorno, 'codigoBarras');

  If FDadosCarteira.Homologacao Then
  Begin
    Result.linhaDigitavel := '75691326030101138408633367800019799350000001100';
    Result.codigoBarras := '75697993500000011001326001011384083336780001';
  End;

  Result.seuNumero := RetornaValorJson(LJsonRetorno, 'seuNumero');
  Result.identificacaoBoletoEmpresa := RetornaValorJson(LJsonRetorno, 'identificacaoBoletoEmpresa');

  If LJsonRetorno.GetValue('qrCode') = Nil Then
    Exit;

  If Not FDadosCarteira.GerarQRCodePix.Equals('S') Then
    Exit;

  Result.QrCodeEmv := RetornaValorJson(LJsonRetorno, 'qrCode');

  If Result.QrCodeEmv.IsEmpty Then
    Exit;

  If AReimpressao Then
    Exit;

  Result.QrCodeTxId := fRetAutoIncrem('GERACAOTXIDPIX', VS_strCodEmp);

  Result.QrCodeTxId := untFuncoesSimples.GetMD5(Concat(fRetCGCEmpresa(VS_strCodEmp),
                                                       Result.QrCodeTxId,
                                                       DateTimeToStr(fRetDtaHraServidor),
                                                       strLoginUsuarioLogado));

  Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('756',
                                                                        Result.QrCodeTxId,
                                                                        Result.QrCodeEmv,
                                                                        FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                        FDadosCarteira.AutoIncremChavePix,
                                                                        IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                               StrToIntDef(FDadosCarteira.QtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));
end;

function TBancoSicoobAPI.RetornaDadosRetornoInclusaoBoletoVersao2(
  ADadosRetorno: String; ADadosDuplicata: TDataset;
  AReimpressao: Boolean): TRetornoBoletoSicoob;
  Var
    LJsonRetorno: TJSONObject;

    LJsonArray: TJSONArray;

    LJsonValue: TJsonValue;
begin
  Result := TRetornoBoletoSicoob.Create;

  LJsonRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;

  LJsonArray := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('resultado').ToString) as TJSONArray;

  For LJsonValue In LJsonArray Do
  Begin
    LJsonRetorno := LJsonValue.GetValue<TJsonObject>('status');

    If RetornaValorJson(LJsonRetorno, 'codigo') <> '200' Then
      Raise Exception.Create('Status: ' + RetornaValorJson(LJsonRetorno, 'codigo') + ' - Mensagem: ' + RetornaValorJson(LJsonRetorno, 'mensagem'));

    LJsonRetorno := LJsonValue.GetValue<TJsonObject>('boleto');

    Result.nossoNumero := fStrZero(RetornaValorJson(LJsonRetorno, 'nossoNumero'), 8);
    If Not Result.nossoNumero.IsEmpty Then
      Result.nossoNumero := fStrZero(Result.nossoNumero, 8);

    Result.linhaDigitavel := RetornaValorJson(LJsonRetorno, 'linhaDigitavel');
    Result.codigoBarras := RetornaValorJson(LJsonRetorno, 'codigoBarras');
    Result.seuNumero := RetornaValorJson(LJsonRetorno, 'seuNumero');
    Result.identificacaoBoletoEmpresa := RetornaValorJson(LJsonRetorno, 'identificacaoBoletoEmpresa');

    If LJsonRetorno.GetValue('qrCode') = Nil Then
      Exit;

    Result.QrCodeEmv := RetornaValorJson(LJsonRetorno, 'qrCode');

    If Result.QrCodeEmv.IsEmpty Then
      Exit;

    If AReimpressao Then
      Exit;

    Result.QrCodeTxId := fRetAutoIncrem('GERACAOTXIDPIX', VS_strCodEmp);

    Result.QrCodeTxId := untFuncoesSimples.GetMD5(Concat(fRetCGCEmpresa(VS_strCodEmp),
                                                         Result.QrCodeTxId,
                                                         DateTimeToStr(fRetDtaHraServidor),
                                                         strLoginUsuarioLogado));

    Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('756',
                                                                          Result.QrCodeTxId,
                                                                          Result.QrCodeEmv,
                                                                          FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                          FDadosCarteira.AutoIncremChavePix,
                                                                          IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                 StrToIntDef(FDadosCarteira.QtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));
    Exit;
  End;
end;

function TBancoSicoobAPI.RetornaMensagensBoleto: TJsonArray;
begin
  Result := TJsonArray.Create;

  If Not FDadosCarteira.Observacao1.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao1, 40));

  If Not FDadosCarteira.Observacao2.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao2, 40));

  If Not FDadosCarteira.Observacao3.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao3, 40));

  If Not FDadosCarteira.Observacao4.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao4, 40));

  If Not FDadosCarteira.Observacao5.Trim.IsEmpty THen
    Result.Add(RetornaValorString(FDadosCarteira.Observacao5, 40));
end;

function TBancoSicoobAPI.RetornaMensagensBoletoVersao2: TJsonObject;
  Var
    LJsonArray: TJsonArray;
begin
  Result := TJsonObject.Create;

  LJsonArray := TJsonArray.Create;

  If Not FDadosCarteira.Observacao1.Trim.IsEmpty THen
    LJsonArray.Add(RetornaValorString(FDadosCarteira.Observacao1, 40));

  If Not FDadosCarteira.Observacao2.Trim.IsEmpty THen
    LJsonArray.Add(RetornaValorString(FDadosCarteira.Observacao2, 40));

  If Not FDadosCarteira.Observacao3.Trim.IsEmpty THen
    LJsonArray.Add(RetornaValorString(FDadosCarteira.Observacao3, 40));

  If Not FDadosCarteira.Observacao4.Trim.IsEmpty THen
    LJsonArray.Add(RetornaValorString(FDadosCarteira.Observacao4, 40));

  If Not FDadosCarteira.Observacao5.Trim.IsEmpty THen
    LJsonArray.Add(RetornaValorString(FDadosCarteira.Observacao5, 40));

  If Not LJsonArray.Count = 0 Then
    Exit;

  Result.AddPair('tipoInstrucao', TJSONNumber.Create(3));
  Result.AddPair('mensagens', LJsonArray);
end;

function TBancoSicoobAPI.RetornaRegistrosRelatorios(ADataInicial,
  ADataFinal: TDateTime): TUniQuery;
begin
  Result := fCriaQuery;

  Try
    Result.SQL.Text := 'SELECT * ' +
                       'FROM SICAPI ' +
                       'WHERE API_CARTEI=:CARTEI ' +
                       '  AND API_DTAINI BETWEEN :DTAINI AND :DTAFIN ';

    Result.ParamByName('DTAINI').AsDateTime := ADataInicial;
    Result.ParamByName('DTAFIN').AsDateTime := ADataFinal;
    Result.ParamByName('CARTEI').AsString := FDadosCarteira.CarteiraCompleta;

    Result.Open;

    fStartTransaction;
    While Not Result.Eof Do
    Begin
      If FormatDateTime('dd/mm/yyyy',Result.FieldByName('API_DTAINI').AsDateTime)
                   .Equals(FormatDateTime('dd/mm/yyyy',Result.FieldByName('API_DTACON').AsDateTime)) Then
      Begin
        Result.Delete;

        Continue;
      End;

      Result.Next;
    End;
    fCommit;

    Result.First;
  Except
    fRollBack;
    Raise;
  End;
end;

function TBancoSicoobAPI.RetornaStreamArquivoDescompactado(
  AArquivoBase64: String): TMemoryStream;
  Var
    LFileStream: TMemoryStream;

    LByteFile: TBytes;

    LZip: TZipFile;
begin
  Try
    LByteFile := TNetEncoding.Base64.DecodeStringToBytes(AArquivoBase64);

    LFileStream := TMemoryStream.Create;
    LFileStream.Clear;
    LFileStream.Write(LByteFile, Length(LByteFile));

    LFileStream.Position := 0;

    LZip := TZipFile.Create();
    LZip.Open(LFileStream, zmRead);

    LZip.Read(LZip.FileName[0], LByteFile);

    Result := TMemoryStream.Create;
    Result.Clear;
    Result.Write(LByteFile, Length(LByteFile));

    Result.Position := 0;

    LFileStream.Free;
    SetLength(LByteFile, 0);
  Except
    Result := TMemoryStream.Create;
  End;
end;

function TBancoSicoobAPI.RetornaTextoErro(ACodigoRetorno,
  ADadosRetorno: String): String;
  Var
    LJsonObject: TJsonObject;

    LJsonValue: TJsonValue;

    LErro,
    LMensagem: String;
    LErroInstabilidade,
    LErroAutenticacao : String;
begin
  Result := 'Status: ' + ACodigoRetorno + ' - Erro: ' + ADadosRetorno;

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

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

    If ((ACodigoRetorno = '0') or fEmptyStr(ACodigoRetorno)) And fEmptyStr(ADadosRetorno) Then
    Begin
       Result := LErroInstabilidade;
       exit;
    End;

    If (Pos('"mensagens":[', ADadosRetorno) > 0) Then
    Begin
      LErro := 'Status: ' + ACodigoRetorno + ' - Erro: ';
      For LJsonValue In LJsonObject.GetValue('mensagens') as TJsonArray Do
        LErro := LErro + LJsonValue.GetValue<String>('codigo') + ' - ' +
                         LJsonValue.GetValue<String>('mensagem') + '. ';
    End;

    If Not fEmptyStr(LErro) Then
       Result := LErro
    Else
    Begin
       // verifica se tem a tag mensagem na exceção
       LMensagem := ExtrairMensagemErro(ADadosRetorno);
       If Not fEmptyStr(LMensagem) Then
          Result := LMensagem;
    End;

    FreeAndNil(LJsonObject);
  Except
    Result := LErroInstabilidade;
  End;
end;

function TBancoSicoobAPI.ExtrairMensagemErro(const AJson: string): string;
var
  LJsonObject, LStatusObj, LErrorObj: TJsonObject;
  LResultadoArray: TJsonArray;
  LItem: TJsonValue;
begin
  Result := '';
  LJsonObject := TJSONObject.ParseJSONValue(AJson) as TJsonObject;
  try
    if not Assigned(LJsonObject) then
      Exit;

    // Caso JSON 1: resultado[0].status.mensagem
    if LJsonObject.TryGetValue<TJsonArray>('resultado', LResultadoArray) then
    begin
      if (LResultadoArray.Count > 0) and (LResultadoArray.Items[0] is TJsonObject) then
      begin
        LItem := LResultadoArray.Items[0];
        if (LItem as TJsonObject).TryGetValue<TJsonObject>('status', LStatusObj) then
          if LStatusObj.TryGetValue<string>('mensagem', Result) then
            Exit;
      end;
    end;

    // Caso JSON 2: error.message
    if LJsonObject.TryGetValue<TJsonObject>('error', LErrorObj) then
      if LErrorObj.TryGetValue<string>('message', Result) then
        Exit;

  finally
    LJsonObject.Free;
  end;
end;

function TBancoSicoobAPI.RetornaValorDuplicata(
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

function TBancoSicoobAPI.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := EmptyStr;
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function TBancoSicoobAPI.RetornaValorJsonValue(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  If Not AObjeto.TryGetValue<String>(ANomeCampo, Result) Then
    Result := EmptyStr;
end;

function TBancoSicoobAPI.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);
end;

procedure TBancoSicoobAPI.SolicitaNovoRelatorio(var ADataSet: TUniQuery;
  ADataAtual: TDateTime; ATipoMovimento: Integer; AAtualizarRegistroAtual: Boolean);
  Var
    LParametros: TStringList;

    LStatus: Integer;

    LJsonObject,
    LJSonRetorno: TJsonObject;

    LResposta: String;
begin
  LParametros := TStringList.Create;

  LJsonObject := TJsonObject.Create;

  LJsonRetorno := TJsonObject.Create;

  Try
    Try
      GerarToken;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + FDadosCarteira.AccessToken);
      LParametros.Add('client_id: ' + FDadosCarteira.ClientId);

      If FDadosCarteira.VersaoAPI.Equals('2') Then
        LJsonObject.AddPair('numeroContrato', TJSONNumber.Create(StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente)))
      Else
        LJsonObject.AddPair('numeroCliente', TJSONNumber.Create(StrToInt(FDadosCarteira.CodCedente + FDadosCarteira.DigCedente)));

      LJsonObject.AddPair('tipoMovimento', TJSONNumber.Create(ATipoMovimento));
      LJsonObject.AddPair('dataInicial', FormatDateTime('yyyy-mm-dd', ADataAtual));
      LJsonObject.AddPair('dataFinal', FormatDateTime('yyyy-mm-dd', ADataAtual));

      LStatus := FRestSynalist.ExecuteRestSynalist('POST',
                                                   FDadosCarteira.LinkGeraRelatorio,
                                                   LParametros,
                                                   LResposta,
                                                   LJsonObject.ToJSON);

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LResposta);

      LJSonRetorno := TJSONObject.ParseJSONValue(LResposta) as TJsonObject;
      LJSonRetorno := TJSONObject.ParseJSONValue(LJSonRetorno.GetValue('resultado').ToJson) as TJsonObject;

      fStartTransaction;

      If AAtualizarRegistroAtual Then
      Begin
        ADataset.Edit;
        ADataset.FieldByName('API_ARQUIV').Clear;
        ADataset.FieldByName('API_JSOREC').Clear;
        ADataset.FieldByName('API_DTACON').Clear;
      End
      Else
      Begin
        ADataset.Append;
        ADataset.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SICAPI', VS_strCodEmp);
        ADataset.FieldByName('API_CARTEI').AsString := FDadosCarteira.CarteiraCompleta;
      End;
      ADataset.FieldByName('API_DTAINI').AsDateTime := ADataAtual;
      ADataset.FieldByName('API_DTAFIN').AsDateTime := ADataAtual;
      ADataset.FieldByName('API_TIPMOV').AsString := ATipoMovimento.ToString;
      ADataset.FieldByName('API_ID_SOL').AsString := RetornaValorJson(LJsonRetorno, 'codigoSolicitacao');
      ADataset.FieldByName('API_DTASOL').AsDateTime := fRetDataServidor;
      ADataset.FieldByName('API_HORSOL').AsDateTime := fRetHoraServidor;
      ADataset.FieldByName('API_OPESOL').AsString := strLoginUsuarioLogado;
      ADataset.Post;

      fCommit;
    Finally
      FreeAndNil(LParametros);

      FreeAndNil(LJsonObject);

      FreeAndNil(LJsonRetorno);
    End;
  Except
    On E: Exception Do
    Begin
       Raise Exception.Create(RetornaTextoErro('',E.Message));
    End;
  End;
end;

function TBancoSicoobAPI.UtilizaDescontoDePontualidade(
  AValorDesconto: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, FDadosCarteira.EmpresaCarteira) Then
    Result := AValorDesconto > 0;
end;

function TBancoSicoobAPI.VerificaSeADuplicataExisteCadrec(
  ABoleto: TRetornoPesquisaBancoSicoobAPI;
  out ADuplicata: untTypesSistema.TDuplicataCtr): Boolean;
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
                          'WHERE CTR_NOSNUM=:NOSNUM                        ' +
                          '  AND CTR_BCOBOL=:BCOENV                        ' +
                          '  AND CTR_BCOENV=:BCOENV                        ' +
                          '  AND CTR_DTAVEN=:DTAVEN                        ' +
                          '  AND CTR_SEQBAI=0                              ';

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.numeroTitulo;
    LPesquisa.ParamByName('BCOENV').AsString   := '756';
    LPesquisa.ParamByName('DTAVEN').AsDateTime := StrToDate(ABoleto.dataVencimentoTitulo);

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

      If LPesquisa.RecordCount > 1 Then
      Begin
        LPesquisa.Filter := 'CTR_CARTEI="' + FDadosCarteira.CarteiraBanco + '" AND ' +
                            'CTR_DTAENV="' + ABoleto.dataEmissaoDocumento + '" ';
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
    End;
  Finally
    LPesquisa.Close;

    FreeAndNil(LPesquisa);
  End;
end;

{ TDadosCarteira }

function TDadosCarteira.ExisteAlgumaObservacaoCadastrada: Boolean;
begin
  Result := Not Concat(Observacao1.Trim, Observacao2.Trim,
                       Observacao3.Trim, Observacao4.Trim,
                       Observacao5.Trim).IsEmpty;
end;

procedure TBancoSicoobAPI.ExibeFormMensagemErro(AMensagem: String);
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
