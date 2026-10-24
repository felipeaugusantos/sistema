unit untTFuncoesPixAutcom;

interface

Uses untTiposPix, System.SysUtils, untIIntegracaoPixCitel, untTIntegracaoPixCitel,
     UniClientDataset, untTPixDao, untFuncFat, Vcl.Forms, untTFuncoesAuxiliaresPix,
     Uni, System.Generics.Collections, System.Classes, untTypesSistema;

Type
  TFuncoesPixAutcom = class
    class var FHandlePixCitel: THandle;
    class var FPixCitel: TIntegracaoPixCitel;
  private
    class var FBridgeJaRegistrado: Boolean;

    class procedure pRegistrarBridgeTefSeNecessario(AHandle: THandle); static;

    class function VerificaPermissaoParaUtilizarPix(ACondicaoPixJaLiberada: Boolean): Boolean;

    class procedure RealizarAdiantamentoPixPeloAutcom;

    class procedure InserirRegistroTFPixNoCaixa(ARegistroPix: TDadosRetornoPixConsulta;
                                                AOperadorCaixa: String;
                                                AEmpresaCaixa: String = '');

    class procedure InserirRegistroTFPixNaMOVBAN(ARegistroPix: TDadosRetornoPixConsulta;
                                                 AOperadorCaixa: String;
                                                 AEmpresaCaixa: String = '');

    class procedure InserirRegistroTFPixNoCaixaCancelamento(ASeqTrf: Integer;
                                                            ACodigoEmpresa: String;
                                                            ADataLancamento: TDateTime;
                                                            ASeqConTransferencia: Integer);

    class procedure InserirRegistroTFPixNaMOVBANCancelamento(ASeqTrf: Integer;
                                                             ACodigoEmpresa: String;
                                                             ADataLancamento: TDateTime;
                                                             ASeqConTransferencia: Integer);
  public
    class var FRegistroAdiantamento: TDadosRetornoPixConsulta;
    class var FNomeFormulario: String;
    class var FIntervaloExecucaoRobo: Integer;

    class var MonitorPix: TMonitorRecebimentosPix;

    class procedure CarregaLibIntegracaoPixCitel(AOrigemChamada: String = '');

    class function InicializaBancosPixAtivos: String;

    class procedure MonitorRecebimentosPix;

    class function RetornaDadosRequisicaoPedido(AObjetoVenda: TFatVenda;
                                                AValorPix: Double = 0): TDadosRequisicaoPixAVista;

    class function RetornaDadosRequisicaoCaixa(ADataset: TUniClientDataSet;
                                               AValorPix: Double;
                                               ACodigoCLiente: String;
                                               AUtilizaShipay: Boolean = False): TDadosRequisicaoPixAVista; overload;

    class function RetornaDadosRequisicaoCaixa(ADadosPagador: String;
                                               AValorPix: Double;
                                               ACodigoCLiente: String;
                                               AUtilizaShipay: Boolean = False): TDadosRequisicaoPixAVista; overload;

    class function RetornaDadosRequisicaoReceber(ADataset: TUniClientDataSet;
                                                 AValorPix: Double;
                                                 ACodigoCLiente: String): TDadosRequisicaoPixAVista;

    class function RetornaDadosRequisicaoCreditoCliente(AValorPix: Double;
                                                        ACodigoCLiente: String): TDadosRequisicaoPixAVista;

    class function RetornaContasBancariasComCertificadosAVencerVencidos: String;

    class function RetornaChaveDaVenda(AOjetoFatVenda: TFatVenda; ACaptionTela: String): String;
    class function RetornaChaveDaDuplicata(ADataset: TUniClientDataset; ACaptionTela: String): String;

    class function ValidacoesCondicaoDePagamentoPix(AObjetoFatVenda: TFatVenda;
                                                    var ACondicaoPixJaLiberada: Boolean): Boolean;

    class function ValidaCondicaoPagamentoConfirmacaoDocumentos(AObjetoFatVenda: TFatVenda): Boolean;

    class function ValidarDadosAutenticacao(AAutoIncremChavePix: String): Boolean;

    class function ImportarDadosAutenticacao(AAutoIncremChavePix,
                                             AChavePix,
                                             ACodigoEmpresaConta: String): TDadosWebhook;

    class procedure ImportarCertificadoCitelSantander(AWorkspace: String);

    class function PixPagoComValorOMesmoValorDaCobranca(ADadosRetorno: TDadosRetornoPixConsulta): Boolean;

    class function RealizaValidacoesUsoDoPixNoCaixa(AOperadorCaixa,
                                                    AChavePixCaixa: String;
                                                    ARotinaRecebimentoCaixaF2F1: Boolean = False): Boolean;

    class function RealizaValidacoesUsoDoPixNoReceber(AOperador,
                                                      APortadorBaixa: String;
                                                      AValidaPortador: Boolean = True): Boolean;

    class function DeveReceberOrdemDePagamentoComQRCodePix(AValorOrdemPagamento: Double;
                                                           ADadosPix: TDadosRetornoPixConsulta): Boolean;

    class function RecebimentoPossuiPixGerado(ASeqcon: Integer;
                                              AEmpresaBaixa: String;
                                              ADataRecebimento: TDateTime): Boolean;

    class function PagarPixViaPorQRCode(ARegistroPix: TUniCLientDataset;
                                        ANomeFormulario: String;
                                        ACancelaGeracaoAdt: Boolean = False;
                                        AOrigemAdiantamento: String = 'CTR';
                                        AChavePedido: String = '';
                                        ACodigoDoCaixa: String = '';
                                        ATravaRegistroPix: Boolean = False;
                                        APagueFacil: Boolean = False): String;

    class function PagarPixViaQRCodeGerandoNovoPix(AAutoIncremChavePix,
                                                   ADadosDoPix,
                                                   ADadosPixAlteracao,
                                                   ACodigoCliente: String;
                                                   APagueFacil: Boolean = False;
                                                   AChaveDocumento: String = '';
                                                   AValorDocumento: Double = 0;
                                                   AOrigemChamada: String = ''): String;

    class function SolicitarDevolucao(AIDPagamento,
                                      AIDDevolucao: String;
                                      AValorDevolucao: Double;
                                      AAutoIncremChavePix: String = '';
                                      AUtilizaShipay: Boolean = False): String;

    class function ConsultarDevolucao(AIDPagamento,
                                      AIDDevolucao: String;
                                      AAutoIncremChavePix: String = ''): String;

    class procedure LiberaObjetosIntegracaoPix(Var ARequisicoesPix: IRequisicoesPix);

    class function ConsultarCobrancaPorTxId(ATxIdPix,
                                            AAutoIncremChavePix: String;
                                            ADadosRequisicao: String = '';
                                            blnIgnorarErro: Boolean = False): String;

    class function GravarRegistroPixBaixado(ADadosPix: TDadosRetornoPixConsulta;
                                            ARegistroCaixa,
                                            AGravaTFCaixa: Boolean;
                                            AOperadorCaixa,
                                            ANomeFormulario: String): Boolean;

    class function GravarRegistroPixBaixadoFaturamento(ADadosPix: TDadosRetornoPixConsulta;
                                                       AGravarNovoPix,
                                                       ARegistroCaixa,
                                                       AGravaTFCaixa: Boolean;
                                                       AOperadorCaixa,
                                                       ANomeFormulario,
                                                       AEmpresaCaixa: String): Boolean;

    class procedure ExcluirPixDoCaixa(ASeqCon: Integer;
                                      ACodigoEmpresa: String;
                                      ADataRecebimento: TDateTime;
                                      ANomeFormulario: String;
                                      ASeqConTransferencia: Integer);

    class procedure RealizaLiberacaoDePedidosComPixPago(AEmpresaDoPix,
                                                        ATxIdPix,
                                                        ACodigoOperador: String);

    class function MudarStatusDoPixParaRemovido(ATxIdPix,
                                                AAutoIncremChave: String): String; overload;

    class function ErroGeradoPelaDevolucaoDoPix(AMensagemErro,
                                                ARetornoStack,
                                                AAutoIncremMovPix,
                                                ANomeFormulario,
                                                AOperador: String;
                                                ADadosPix: TDadosRetornoPixConsulta = Nil): Boolean;

    class procedure GravarLogErr_Pix(ADescricao,
                                     ARelatorio: String);

    class procedure CarregaListaPixCriadoEmTela(var AListaDadosPix: TStringList);

    {* GERAR CC PIX PAGO SEM CONFIRMACAO *}
    class function RetornaDatasetPixPagosSemConfirmacao(AOperador: String): TUniClientDataset;

    class procedure GeraMensagemAoOperadorFaltaPix(ANomeArquivo: String);

    class procedure pResetarRegistro; static;
    class procedure DesregistrarBridgeTef;
  end;

const
  DLL_PIX = 'libIntegracaoPixCitel.dll';

var
  RetornaDadosChavePixTela: function: String; StdCall;
  EnviaDadosDocumentoPixTela: procedure(ACodigoCliente, AChaveDocumento: String; AValorDocumento: Double); StdCall;
  EnviaDadosDocumentoPixTelaV2: procedure(ACodigoCliente, AChaveDocumento: String; AValorDocumento: Double; AOrigemChamada: String = ''); StdCall;

implementation
Uses untUtilMonitor, untFuncoesSimples, untAdiantamentoCliente,
     System.Variants, untMsgInterna, System.StrUtils, untLiberacao,
     Winapi.Windows, untGravando, untModulo,
     untTBanTrf, untMovBan, untCadRcxx, Data.DB, untTLogMpx,
     untLogCba, untInterfacePixTefBridge, untTPixTefBridgeAutcom,
     untTefCitelUtil;

{ TFuncoesPixAutcom }

class procedure TFuncoesPixAutcom.CarregaLibIntegracaoPixCitel(AOrigemChamada: String = '');
  Var
    InicializaIntegracaoPixCitel: procedure(AIntegracaoPixCitel: IIntegracaoPixCitel); StdCall;
    InicializaIntegracaoPixCitelV2: procedure(AIntegracaoPixCitel: IIntegracaoPixCitel;
                                              ADisparaSMSAut: TfunDisparaWhatsAppAutomatico = Nil;
                                              ADisparaEmailAut: TfunDisparaEmailAutomatico = Nil); StdCall;

    LCaminhoDll: String;
begin
  If FHandlePixCitel <> 0 Then
    Exit;

  Try
    LCaminhoDll := ExtractFilePath(Application.ExeName) + DLL_PIX;

    If Not FileExists(LCaminhoDll) Then
      Raise Exception.Create('O arquivo ' + DLL_PIX + ' não foi encontrado na pasta do AUTCOM. ' +
                             'A configuração Usa Pix Citel dessa empresa está igual a "Sim", então é necessário que esse arquivo esteja na pasta.' + #13 +
                             'Operação cancelada! ' + #13 +
                             'Entre em contato com a Citel.');

    FHandlePixCitel := SafeLoadLibrary(PChar(LCaminhoDll));

    If FHandlePixCitel = 0 Then
      Raise Exception.CreateFmt('Ocorreu uma falha ao carregar %s (erro %d)', [DLL_PIX, GetLastError]);

    FPixCitel := TIntegracaoPixCitel.Create;

    {$IFNDEF LINUX}
    InicializaIntegracaoPixCitelV2 := GetProcAddress(FHandlePixCitel, pChar('InicializaIntegracaoPixCitelV2'));
    If Assigned(InicializaIntegracaoPixCitelV2) Then
    Begin
      InicializaIntegracaoPixCitelV2(FPixCitel,
                                     funDisparaWhatsappAutomatico,
                                     funDisparaEmailAutomatico);
    End
    Else
    {$ENDIF}
    Begin
      InicializaIntegracaoPixCitel := GetProcAddress(FHandlePixCitel, pChar('InicializaIntegracaoPixCitel'));

      If Not Assigned(InicializaIntegracaoPixCitel) Then
        Raise Exception.CreateFmt('Ponto de entrada "InicializaIntegracaoPixCitel" não encontrado em %s. ' +
          'Verifique se a versão da DLL é compatível.', [DLL_PIX]);

      InicializaIntegracaoPixCitel(FPixCitel);
    End;
  Except
    FHandlePixCitel := 0;
    If FPixCitel <> Nil Then
      FreeAndNil(FPixCitel);
    Raise;
  End;
end;

class procedure TFuncoesPixAutcom.CarregaListaPixCriadoEmTela(
  var AListaDadosPix: TStringList);
  Var
    LDadosPix: String;
begin
  If Not Assigned(RetornaDadosChavePixTela) Then
    Exit;

  If Not Assigned(AListaDadosPix) Then
    AListaDadosPix := TStringList.Create;

  LDadosPix := RetornaDadosChavePixTela;

  If LDadosPix.IsEmpty Then
    Exit;

  If AListaDadosPix.IndexOf(LDadosPix + '-' + VS_strCodEmp) = -1 Then
    AListaDadosPix.Add(LDadosPix + '-' + VS_strCodEmp);
end;

class function TFuncoesPixAutcom.ConsultarCobrancaPorTxId(ATxIdPix,
                                                          AAutoIncremChavePix: String;
                                                          ADadosRequisicao: String = '';
                                                          blnIgnorarErro: Boolean = False): String;
  Var
    LRespostaRequisicao,
    LErro: String;

    LRequisicoesPix: IRequisicoesPix;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicoesPix := CriaObjetoRequisicoesPix(AAutoIncremChavePix);

    LRespostaRequisicao := LRequisicoesPix.ConsultarPixPorTxId(ATxIdPix, True, ADadosRequisicao);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRespostaRequisicao);

    If (Not LErro.IsEmpty)  And (Not blnIgnorarErro) Then
      Raise Exception.Create(LErro);

    If (Not LErro.IsEmpty) And (blnIgnorarErro) Then
      Result := 'ErroConsultaPix'
    Else
      Result := LRespostaRequisicao;
  Finally
    TFuncoesPixAutcom.LiberaObjetosIntegracaoPix(LRequisicoesPix);
  End;
end;

class function TFuncoesPixAutcom.ConsultarDevolucao(AIDPagamento,
  AIDDevolucao: String; AAutoIncremChavePix: String = ''): String;
  Var
    LRespostaRequisicao,
    LErro: String;

    LRequisicoesPix: IRequisicoesPix;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicoesPix := CriaObjetoRequisicoesPix(AAutoIncremChavePix);

    LRespostaRequisicao := LRequisicoesPix.ConsultarDevolucao(AIDPagamento,
                                                              AIDDevolucao);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRespostaRequisicao);
    If Not LErro.IsEmpty Then
      Raise Exception.Create('DEVPIX-' + LErro);

    Result := LRespostaRequisicao;
  Finally
    LiberaObjetosIntegracaoPix(LRequisicoesPix);
  End;
end;

class procedure TFuncoesPixAutcom.DesregistrarBridgeTef;
var
  LpRegistraNil: procedure(ABridge: IPixTefBridge); stdcall;
begin
  if FHandlePixCitel = 0 then
    Exit;

  LpRegistraNil := GetProcAddress(FHandlePixCitel, 'RegistraBridgeTefPix');
  if not Assigned(LpRegistraNil) then
    Exit;

  try
    LpRegistraNil(nil);
  except
    // shutdown: nao propaga
  end;
end;

class function TFuncoesPixAutcom.DeveReceberOrdemDePagamentoComQRCodePix(
  AValorOrdemPagamento: Double; ADadosPix: TDadosRetornoPixConsulta): Boolean;
begin
  Result := False;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If fCfgSis('RCXORD', varString) <> 'P' Then
    Exit;

  If AValorOrdemPagamento = 0 Then
    Exit;

  If Not Assigned(ADadosPix) Then
    Exit(True);

  If Not TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(ADadosPix) Then
    Exit(True);
end;

class function TFuncoesPixAutcom.ErroGeradoPelaDevolucaoDoPix(AMensagemErro,
                                                              ARetornoStack,
                                                              AAutoIncremMovPix,
                                                              ANomeFormulario,
                                                              AOperador: String;
                                                              ADadosPix: TDadosRetornoPixConsulta = Nil): Boolean;
  Var
    LQuantidadeDev: Integer;

    LMensagem: String;
begin
  If LeftStr(AMensagemErro, 7) <> 'DEVPIX-' Then
    Exit(False);

  AMensagemErro := AMensagemErro.Replace('DEVPIX-', EmptyStr);

  Result := True;

  fStartTransaction;

  GravarLogErr_Pix(AMensagemErro,
                   ARetornoStack);

  If Not AAutoIncremMovPix.IsEmpty Then
  Begin
    fExecutaSQL('UPDATE MOVPIX SET MPX_QTDDEV=MPX_QTDDEV+1 WHERE AUTOINCREM="' + AAutoIncremMovPix + '"');

    TLogMpx.GravaLogMpx(AAutoIncremMovPix,
                        'ERRO DEVOLUÇÃO PIX',
                        ANomeFormulario);

    LQuantidadeDev := fCampoTabela('MPX_QTDDEV', 'MOVPIX', ['AUTOINCREM'], [AAutoIncremMovPix]);
  End;

  fCommit;

  LMensagem := AMensagemErro;
  If LQuantidadeDev > 1 Then
    LMensagem := LMensagem + #13 + 'Já foram realizadas ' + LQuantidadeDev.ToString + ' tentativas sem sucesso.';

  fMensagem('ERRO', LMensagem, ['&Ok']);
end;

class procedure TFuncoesPixAutcom.ExcluirPixDoCaixa(ASeqCon: Integer;
  ACodigoEmpresa: String; ADataRecebimento: TDateTime; ANomeFormulario: String;
  ASeqConTransferencia: Integer);
  Var
    LConsulta: TUniQuery;

    LDescricaoLog: String;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT MPX_TX_ID_, MPX_CODEMP, MPX_SEQTRF, MPX_DTAREC ' +
                          'FROM MOVPIX ' +
                          'WHERE MPX_SEQCON=' + ASeqCon.ToString +
                          '  AND MPX_CODEMP="' + ACodigoEmpresa + '" ' +
                          '  AND MPX_DTAREC="' + FormatDateTime('yyyy-mm-dd', ADataRecebimento) + '"';
    LConsulta.Open;

    LDescricaoLog := 'ESTORNO - RECEBER RESCAI';
    If MatchStr(ANomeFormulario, ['frmRcxCancelaCC']) Then
      LDescricaoLog := 'ESTORNO - CANCELAMENTO CC'
    Else If MatchStr(ANomeFormulario, ['frmRcxFormasPagamento']) Then
      LDescricaoLog := 'EXCLUSÃO - ALTERAÇÃO FORMAS DE PAGAMENTO';

    Try
      TPixDao.ExcluirRegistroDoPix(LConsulta.FieldByName('MPX_CODEMP').AsString,
                                   LConsulta.FieldByName('MPX_TX_ID_').AsString,
                                   ANomeFormulario,
                                   LDescricaoLog);

      InserirRegistroTFPixNoCaixaCancelamento(LConsulta.FieldByName('MPX_SEQTRF').AsInteger,
                                              LConsulta.FieldByName('MPX_CODEMP').AsString,
                                              LConsulta.FieldByName('MPX_DTAREC').AsDateTime,
                                              ASeqConTransferencia);

      InserirRegistroTFPixNaMOVBANCancelamento(LConsulta.FieldByName('MPX_SEQTRF').AsInteger,
                                               LConsulta.FieldByName('MPX_CODEMP').AsString,
                                               LConsulta.FieldByName('MPX_DTAREC').AsDateTime,
                                               ASeqConTransferencia);
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao excluir o registro do Pix do caixa.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class procedure TFuncoesPixAutcom.GeraMensagemAoOperadorFaltaPix(
  ANomeArquivo: String);
  Var
    LForcarEnvioMensagem: String;

    LMensagemInterna: TMsgInterna;
begin
  LForcarEnvioMensagem := fArqIni(0, 'GERAL', 'FORCAR_TESTE_MENSAGEM_CONSULTA_PIX', '');

  If Not fArqIni(0, 'BANCO', 'NOMBAN', '').Equals('AUTCOM') Then
  Begin
    If Not LForcarEnvioMensagem.Equals('S') Then
      Exit;
  End;

  If Not TPixDao.ExistemCobrancasPixAtivas Then
    Exit;

  If fInTransaction Then
    Exit;

  LMensagemInterna := TMsgInterna.Create(Nil);

  Try
    fStartTransaction;
    LMensagemInterna.fEnviaMensagem('Consulta de pagamentos por Pix de Pedidos/Contas a Receber não está em funcionamento.',
                                    'Existem cobranças Pix ativas, mas a consulta de pagamentos por Pix não está em funcionamento.' + #13 +
                                        'Motivo: O arquivo ' + ANomeArquivo + ' não está na pasta do Autcom.' + #13 + #13 +
                                        'Entre em contato com a Citel.',
                                    strLoginUsuarioLogado,
                                    strLoginUsuarioLogado,
                                    'N',
                                    NullAsStringValue);
    fCommit;
  Finally
    FreeAndNil(LMensagemInterna);
  End;
end;

class procedure TFuncoesPixAutcom.GravarLogErr_Pix(ADescricao,
  ARelatorio: String);
  Var
    LLogErr_Pix: TUniQuery;
begin
  LLogErr_Pix := fCriaQuery(Nil);
  LLogErr_Pix.SQL.Text := 'SELECT * FROM LOGERR_PIX WHERE FALSE';

  Try
    LLogErr_Pix.Open;
    LLogErr_Pix.Insert;
    LLogErr_Pix.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
    LLogErr_Pix.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    LLogErr_Pix.FieldByName('LOG_DTAERR').AsDateTime := fRetDataServidor;
    LLogErr_Pix.FieldByName('LOG_HORERR').AsDateTime := fRetHoraServidor;
    LLogErr_Pix.FieldByName('LOG_DESCRI').AsString   := ADescricao;

    If Not ARelatorio.IsEmpty Then
      LLogErr_Pix.FieldByName('LOG_RELERR').AsString := ARelatorio;

    LLogErr_Pix.Post;
    LLogErr_Pix.Close;
  Finally
    FreeAndNil(LLogErr_Pix);
  End;
end;

class function TFuncoesPixAutcom.GravarRegistroPixBaixado(
  ADadosPix: TDadosRetornoPixConsulta; ARegistroCaixa, AGravaTFCaixa: Boolean;
  AOperadorCaixa, ANomeFormulario: String): Boolean;
  Var
    LPixDao: TPixDao;
begin
  Result := False;

  Try
    LPixDao := TPixDao.Create;

    If ADadosPix.CriadoPelo.IsEmpty Then
      ADadosPix.CriadoPelo := 'CAIXA';

    LPixDao.InserirCobrancaPixRecebida(ADadosPix,
                                       ANomeFormulario,
                                       ARegistroCaixa,
                                       AOperadorCaixa);

    If AGravaTFCaixa Then
    Begin
      InserirRegistroTFPixNoCaixa(ADadosPix,
                                  AOperadorCaixa);

      InserirRegistroTFPixNaMOVBAN(ADadosPix,
                                   AOperadorCaixa);
    End;

    FreeAndNil(LPixDao);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o registro do Pix.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class function TFuncoesPixAutcom.GravarRegistroPixBaixadoFaturamento(
  ADadosPix: TDadosRetornoPixConsulta; AGravarNovoPix, ARegistroCaixa,
  AGravaTFCaixa: Boolean; AOperadorCaixa, ANomeFormulario,
  AEmpresaCaixa: String): Boolean;
  Var
    LPixDao: TPixDao;
begin
  Result := False;

  Try
    LPixDao := TPixDao.Create;

    If AGravarNovoPix Then
    Begin
      If ADadosPix.CriadoPelo.IsEmpty Then
        ADadosPix.CriadoPelo := 'FATURAMENTO';

      LPixDao.InserirCobrancaPixRecebida(ADadosPix,
                                         ANomeFormulario,
                                         ARegistroCaixa,
                                         AOperadorCaixa,
                                         AEmpresaCaixa);
    End
    Else
      LPixDao.AtualizaDadosRetornoConcluidoPix(ADadosPix,
                                               ADadosPix.SeqConRecebimento,
                                               ANomeFormulario,
                                               True);

    If AGravaTFCaixa Then
    Begin
      InserirRegistroTFPixNoCaixa(ADadosPix,
                                  AOperadorCaixa,
                                  AEmpresaCaixa);

      InserirRegistroTFPixNaMOVBAN(ADadosPix,
                                   AOperadorCaixa,
                                   AEmpresaCaixa);
    End;

    FreeAndNil(LPixDao);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar/atualizar o registro do Pix.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class procedure TFuncoesPixAutcom.ImportarCertificadoCitelSantander(
  AWorkspace: String);
  Var
    LRespostaRequisicao: String;

    ImportarCertificadoCitelWebhookSantander: function(AWorkspace: String): String; stdcall;
begin
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    ImportarCertificadoCitelWebhookSantander  := GetProcAddress(FHandlePixCitel, 'ImportarCertificadoCitelWebhookSantander');

    LRespostaRequisicao := ImportarCertificadoCitelWebhookSantander(AWorkspace);

    If Not MatchStr(LRespostaRequisicao, ['sucesso', EmptyStr]) Then
      Raise Exception.Create('Ocorreu um erro ao retornar importar o certificado.' + #13 + #13 +
                             'Erro gerado: ' + LRespostaRequisicao);
  Except
    Raise;
  End;
end;

class function TFuncoesPixAutcom.ImportarDadosAutenticacao(AAutoIncremChavePix,
  AChavePix, ACodigoEmpresaConta: String): TDadosWebhook;
  Var
    LRespostaRequisicaoCertificados,
    LRespostaRequisicao: String;

    RetornaDadosAutorizacaoWebhookItau: function(ACNPJCliente, AChavePix,AAutoIncremChavePix: String): String; stdcall;
    RetornaCertificadosWebhookItau: function(): String; stdcall;
begin
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    RetornaDadosAutorizacaoWebhookItau  := GetProcAddress(FHandlePixCitel, 'RetornaDadosAutorizacaoWebhookItau');

    LRespostaRequisicao := RetornaDadosAutorizacaoWebhookItau(untFuncoesSimples.fRetCGCEmpresa(ACodigoEmpresaConta),
                                                              AChavePix,
                                                              AAutoIncremChavePix);

    RetornaCertificadosWebhookItau := GetProcAddress(FHandlePixCitel, 'RetornaCertificadosWebhookItau');
    LRespostaRequisicaoCertificados := RetornaCertificadosWebhookItau;

    If Not MatchStr(TFuncoesPix.RetornaValorCampoJson('codigo', LRespostaRequisicaoCertificados), ['200', '201']) Then
      Raise Exception.Create('Ocorreu um erro ao retornar os certificados.' + #13 + #13 +
                             'Código do Erro: ' + TFuncoesPix.RetornaValorCampoJson('codigo', LRespostaRequisicaoCertificados));

    Result := TFuncoesPix.RetornaDadosDoRetornoWebhook(LRespostaRequisicao,
                                                       LRespostaRequisicaoCertificados);
  Except
    Raise;
  End;
end;

class function TFuncoesPixAutcom.InicializaBancosPixAtivos: String;
begin
  //RETIRADA A FUNÇÃO CENTRALIZADA DA LIB POIS O BANCO CENTRAL GERA UM PADRÃO DE AUTENTICAÇÃO,
  //MAS OS PSPs NÃO SEGUEM O PADRÃO DEFINIDO
  Result := '001_341_237_756_033_748_422_';
end;

class procedure TFuncoesPixAutcom.MonitorRecebimentosPix;
  Var
    LOperador,
    LEmpresaFisica: String;
begin
  If untFuncoesSimples.RunningInTSPlus Then
    Exit;

  If Not TPixDao.ExistemChavesPixCadastradas Then
    Exit;

  If Not TPixDao.ExistemCobrancasPixAtivas Then
  Begin
    If Not TPixDao.ExistemDuplicatasComChavePixSemRegistro Then
      Exit;
  End;

  If Not Assigned(MonitorPix) Then
    MonitorPix := TMonitorRecebimentosPix.Create;

  LEmpresaFisica := fRetEmpresaFisica;

  If fGetTempoDuracaoLock(Format(MonitorPix.ID_MONITOR, [LEmpresaFisica]), True) > StrToTime('00:05:00') Then
  Begin
    fLock_Unlock(Format(MonitorPix.ID_MONITOR, [LEmpresaFisica]),
                 False,
                 False,
                 False,
                 '',
                 False,
                 Format(MonitorPix.ID_MONITOR, [LEmpresaFisica]));
  End
  Else If Not fRetOrigemLock(frmModulo.GetCurrentConnection.Database + '.' + Format(MonitorPix.ID_MONITOR, [LEmpresaFisica])).IsEmpty Then
    Exit;

  Try
    If TPixDao.EquipamentoJaExecutouOMonitorDeRecebimentosPix(Concat(VS_ComputerNetName, '|', VS_WorkstationID),
                                                              VS_UserFromWindows,
                                                              LEmpresaFisica,
                                                              FIntervaloExecucaoRobo) Then
      Exit;
  Except
    //Não deve parar a execução, caso ocorra erros na validação
  End;

  LOperador := fCfgSis('OPEAUT', varString);
  If LOperador.IsEmpty Then
    LOperador := strLoginUsuarioLogado;

  TUtilMonitor.pTestInactivity(Format(MonitorPix.ID_INATIVIDADE_MONITOR, [LEmpresaFisica]),
                               MonitorPix.TEMPO_LIMITE_MONITOR,
                               MonitorPix.ProcessoMonitor,
                               MonitorPix.DataUltimaExecucaoMonitor);

  TUtilMonitor.pRunMonitor(MonitorPix.ID_MONITOR,
                           MonitorPix.ProcessoMonitor,
                           MonitorPix.DataUltimaExecucaoMonitor,
                           MonitorPix.ExeName,
                           Format(MonitorPix.PARAMETROS, [LEmpresaFisica, LOperador]));

  If MonitorPix.ProcessoMonitor.dwProcessId > 0 Then
    fLock_Unlock(Format(MonitorPix.ID_MONITOR, [LEmpresaFisica]),
                 True,
                 False,
                 False,
                 '',
                 False,
                 Format(MonitorPix.ID_MONITOR, [LEmpresaFisica]),
                 False,
                 False,
                 True,
                 True,
                 False,
                 True,
                 True);
end;

class function TFuncoesPixAutcom.MudarStatusDoPixParaRemovido(
  ATxIdPix, AAutoIncremChave: String): String;
  Var
    LRequisicaoPix: IRequisicoesPix;

    LErro,
    LRequsicaoJson,
    LRetornoJson: String;

    LUtilizaShipay: Boolean;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Result := '';

  If ATxIdPix.IsEmpty Then
    Exit;

  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicaoPix := CriaObjetoRequisicoesPix(AAutoIncremChave);

    LUtilizaShipay := TPixDao.ChavePixUtilizaShipay(AAutoIncremChave) = 'S';

    Try
      If Not LUtilizaShipay Then
      Begin
        LRequsicaoJson := '{"status": "REMOVIDA_PELO_USUARIO_RECEBEDOR", ' +
                          ' "valor": {' +
                          '  "original": "0.00"} ' +
                          '}';

        LRetornoJson := LRequisicaoPix.AlterarCobranca(LRequsicaoJson, ATxIdPix);
      End
      Else
        LRetornoJson := LRequisicaoPix.CancelarCobrancaShipay(ATxIdPix);

      LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoJson);
      If Not LErro.IsEmpty Then
        Raise Exception.Create(LErro);

      Result := LRetornoJson;
    Except
      //Erro está sendo gravado pela lib
    End;
  Finally
    LiberaObjetosIntegracaoPix(LRequisicaoPix);
  End;
end;

class function TFuncoesPixAutcom.PagarPixViaPorQRCode(ARegistroPix: TUniCLientDataset;
  ANomeFormulario: String; ACancelaGeracaoAdt: Boolean = False; AOrigemAdiantamento: String = 'CTR';
  AChavePedido: String = ''; ACodigoDoCaixa: String = ''; ATravaRegistroPix: Boolean = False;
  APagueFacil: Boolean = False): String;
  Var
    LRespostaTelaRequisicao,
    LErro: String;

    LObjetoResposta: TDadosRetornoPixConsulta;

    CriaTelaLeituraQRCode: function(AAutoIncremChavePix, ATxIdPix, ATextoQRCode, AAutoIncremMovPix: String): String; StdCall;

    CriaTelaLeituraQRCodePagueFacil: function(AAutoIncremChavePix, ATxIdPix, ATextoQRCode, AAutoIncremMovPix: String): String; StdCall;
begin
  TPixDao.AdicionarRegistroNaTabelaPixTel(ARegistroPix.FieldByName('AUTOINCREM').AsString);
  Try
    CarregaLibIntegracaoPixCitel;

    If ATravaRegistroPix Then
      fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + ARegistroPix.FieldByName('MPX_TX_ID_').AsString, True);

    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    RetornaDadosChavePixTela := GetProcAddress(FHandlePixCitel, pChar('RetornaDadosChavePixTela'));
    EnviaDadosDocumentoPixTela := GetProcAddress(FHandlePixCitel, pChar('EnviaDadosPedidoPixTela'));

    If Not APagueFacil Then
    Begin
      CriaTelaLeituraQRCode  := GetProcAddress(FHandlePixCitel, 'CriaTelaLeituraQRCode');
      LRespostaTelaRequisicao := CriaTelaLeituraQRCode(ARegistroPix.FieldByName('MPX_SEQPIX').AsString,
                                                       ARegistroPix.FieldByName('MPX_TX_ID_').AsString,
                                                       ARegistroPix.FieldByName('MPX_QRCODE').AsString,
                                                       ARegistroPix.FieldByName('AUTOINCREM').AsString);
    End
    Else
    Begin
      CriaTelaLeituraQRCodePagueFacil  := GetProcAddress(FHandlePixCitel, 'CriaTelaLeituraQRCodePagueFacil');
      LRespostaTelaRequisicao := CriaTelaLeituraQRCodePagueFacil(ARegistroPix.FieldByName('MPX_SEQPIX').AsString,
                                                                 ARegistroPix.FieldByName('MPX_TX_ID_').AsString,
                                                                 ARegistroPix.FieldByName('MPX_QRCODE').AsString,
                                                                 ARegistroPix.FieldByName('AUTOINCREM').AsString);
    End;

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRespostaTelaRequisicao);
    If Not LErro.IsEmpty Then
      Exit;

    LObjetoResposta := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRespostaTelaRequisicao,
                                                                    ARegistroPix.FieldByName('MPX_JSOENV').AsString);

    If Not ACancelaGeracaoAdt Then
      fLock_Unlock(AChavePedido, False, False);

    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(LObjetoResposta) Then
    Begin
      LObjetoResposta.CodigoEmpresa := ARegistroPix.FieldByName('MPX_CODEMP').AsString;
      LObjetoResposta.CodigoPortador := ARegistroPix.FieldByName('POR_CODPOR').AsString;
      LObjetoResposta.AutoIncremMovPix := ARegistroPix.FieldByName('AUTOINCREM').AsString;
      LObjetoResposta.AutoIncremChavePix := ARegistroPix.FieldByName('MPX_SEQPIX').AsString;
      LObjetoResposta.CodigoDoCaixa := ACodigoDoCaixa;

      LObjetoResposta.PlanoDeContas := fCfgSis('CTAPIX', varString, LObjetoResposta.CodigoEmpresa);
      If LObjetoResposta.PlanoDeContas.IsEmpty Then
        LObjetoResposta.PlanoDeContas := fCfgSis('CTAAVI', varString, LObjetoResposta.CodigoEmpresa);

      LObjetoResposta.OrigemAdiantamento := AOrigemAdiantamento;

      FRegistroAdiantamento := LObjetoResposta;
      FNomeFormulario := ANomeFormulario;

      If Not ACancelaGeracaoAdt Then
        TfrmGravando.fExecutarModal(RealizarAdiantamentoPixPeloAutcom, 'Aguarde... Realizando adiantamento.', '');
    End;
  Finally
    Result := LRespostaTelaRequisicao;

    TPixDao.ApagarRegistroNaTabelaPixTel(ARegistroPix.FieldByName('AUTOINCREM').AsString,
                                         True);

    If ATravaRegistroPix Then
      fLock_Unlock('CONSULTA_RECEBIMENTO_PIX_' + ARegistroPix.FieldByName('MPX_TX_ID_').AsString, False);
  End;
end;

class function TFuncoesPixAutcom.PagarPixViaQRCodeGerandoNovoPix(
  AAutoIncremChavePix, ADadosDoPix, ADadosPixAlteracao,
  ACodigoCliente: String; APagueFacil: Boolean = False;
  AChaveDocumento: String = ''; AValorDocumento: Double = 0; AOrigemChamada: String = ''): String;
  Var
    LRespostaTelaRequisicao,
    LErro: String;

    CriaTelaLeituraQRCodeNovoPixCliente: function(AAutoIncremChavePix, ADadosNovoPix, ADadosPixAlteracao, ACodigoCliente: String): String; StdCall;
    CriaTelaLeituraQRCodeNovoPixPagueFacil: function(AAutoIncremChavePix, ADadosNovoPix, ACodigoCliente: String): String; StdCall;
begin
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    RetornaDadosChavePixTela := GetProcAddress(FHandlePixCitel, pChar('RetornaDadosChavePixTela'));
    EnviaDadosDocumentoPixTela := GetProcAddress(FHandlePixCitel, pChar('EnviaDadosDocumentoPixTela'));
    EnviaDadosDocumentoPixTelaV2 := GetProcAddress(FHandlePixCitel, pChar('EnviaDadosDocumentoPixTelaV2'));

    If MatchStr(TPixDao.RetornaBancoDaChavePix(AAutoIncremChavePix), ['033']) Then
      ADadosPixAlteracao := '';

    If Assigned(EnviaDadosDocumentoPixTelaV2) Then
      EnviaDadosDocumentoPixTelaV2(ACodigoCliente, AChaveDocumento, AValorDocumento, AOrigemChamada)
    Else If Assigned(EnviaDadosDocumentoPixTela) Then
      EnviaDadosDocumentoPixTela(ACodigoCliente, AChaveDocumento, AValorDocumento);

    If Not APagueFacil Then
    Begin
      CriaTelaLeituraQRCodeNovoPixCliente  := GetProcAddress(FHandlePixCitel, 'CriaTelaLeituraQRCodeNovoPixCliente');
      LRespostaTelaRequisicao := CriaTelaLeituraQRCodeNovoPixCliente(AAutoIncremChavePix,
                                                                     ADadosDoPix,
                                                                     ADadosPixAlteracao,
                                                                     ACodigoCliente);
    End
    Else
    Begin
      CriaTelaLeituraQRCodeNovoPixPagueFacil  := GetProcAddress(FHandlePixCitel, 'CriaTelaLeituraQRCodeNovoPixPagueFacil');
      LRespostaTelaRequisicao := CriaTelaLeituraQRCodeNovoPixPagueFacil(AAutoIncremChavePix,
                                                                        ADadosDoPix,
                                                                        ACodigoCliente);
    End;

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRespostaTelaRequisicao);
    If Not LErro.IsEmpty Then
      Exit;
  Finally
    Result := LRespostaTelaRequisicao;
  End;
end;

class procedure TFuncoesPixAutcom.RealizarAdiantamentoPixPeloAutcom;
begin
  Try
    TAdiantamento.RealizarAdiantamentoClientePix(FNomeFormulario,
                                                 FRegistroAdiantamento);
  Except
    On E: Exception Do
    Begin
      fRollBack;

      Raise;
    End;
  End;
end;

class function TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoCaixa(AOperadorCaixa, AChavePixCaixa: String;
  ARotinaRecebimentoCaixaF2F1: Boolean = False): Boolean;
begin
  Result := False;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If ARotinaRecebimentoCaixaF2F1 Then
  Begin
    If fCfgSis('RCXORD', varString) = 'O' Then
      Exit;
  End
  Else
  Begin
    If fCfgSis('F11ORD', varString) = 'O' Then
      Exit;
  End;

  If Not FileExists(ExtractFilePath(Application.ExeName) + DLL_PIX) Then
    Exit;

  If fEmptyStr(AChavePixCaixa) Then
    Exit;

  If Not TPixDao.ChavePixPossuiChavesDeAutorizacao(AChavePixCaixa) Then
    Exit;

  If Not fVerificaAcessoSistema('PERMRECRCXPIX', AOperadorCaixa) Then
    Exit;

  Result := True;
end;

class function TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoReceber(AOperador,
  APortadorBaixa: String; AValidaPortador: Boolean = True): Boolean;
begin
  Result := False;

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If Not FileExists(ExtractFilePath(Application.ExeName) + DLL_PIX) Then
    Exit;

  If AValidaPortador Then
  Begin
    If Not TPixDao.PortadorPossuiChavesPixVinculadas(APortadorBaixa) Then
      Exit;
  End
  Else
  Begin
    If Not TPixDao.VerificaSePossuiChavePixSelecionada Then
      Exit;
  End;

  If Not fVerificaAcessoSistema('PERMRECCTRPIX', AOperador) Then
    Exit;

  Result := True;
end;

class function TFuncoesPixAutcom.RecebimentoPossuiPixGerado(ASeqcon: Integer;
  AEmpresaBaixa: String; ADataRecebimento: TDateTime): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVPIX ' +
                          'WHERE MPX_SEQCON=' + ASeqCon.ToString +
                          '  AND MPX_CODEMP="' + AEmpresaBaixa + '" ' +
                          '  AND MPX_DTAREC="' + FormatDateTime('yyyy/mm/dd', ADataRecebimento) + '"';
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixAutcom.RetornaDadosRequisicaoCaixa(
  ADataset: TUniClientDataSet;
  AValorPix: Double;
  ACodigoCliente: String;
  AUtilizaShipay: Boolean = False): TDadosRequisicaoPixAVista;
  Var
    LDadosCliente: TUniQuery;

    LContador: Integer;

    LValorTexto: String;
begin
  Result := TDadosRequisicaoPixAVista.Create;
  Result.Expiracao := 86400;

  Result.TipoDevedor := '2';
  Result.NomeDevedor := '';
  Result.CPFCNPJDevedor := '';
  If Not ACodigoCLiente.IsEmpty Then
  Begin
    LDadosCliente := fCriaQuery;
    LDadosCliente.SQL.Text := 'SELECT CLI_CGCCPF, CLI_C_G_C_, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI="' + ACodigoCliente + '"';
    LDadosCliente.Open;

    If Not fClienteConsumidor(fRetNomCliente(ACodigoCliente) ,True, True, True) Then
    Begin
      Result.TipoDevedor := LDadosCliente.FieldByname('CLI_CGCCPF').AsString;
      Result.CPFCNPJDevedor := LDadosCliente.FieldByname('CLI_C_G_C_').AsString;
      Result.NomeDevedor := LDadosCliente.FieldByname('CLI_NOMCLI').AsString;
    End;

    FreeAndNil(LDadosCliente);
  End;

  If Result.CPFCNPJDevedor.IsEmpty Then
    Result.NomeDevedor := '';

  Result.Valor := ReplaceStr(FormatFloat(',0.00', AValorPix), '.', EmptyStr);
  Result.Valor := ReplaceStr(Result.Valor, ',', '.');

  Result.SolicitacaoPagador := 'Pix gerado referente ao pagamento de duplicatas';

  Result.UtilizaShipay := 'N';
  If AUtilizaShipay Then
    Result.UtilizaShipay := 'S';

  If ADataset.FindField('CTR_MARDES') = Nil Then
    Exit;

  ADataset.Filter := 'CTR_MARDES=''M'' ';
  ADataset.Filtered := True;
  ADataset.First;
  For LContador := 0 To 49 Do
  Begin
    If ADataSet.Eof Then
      Break;

    Result.InformacoesAdicionais[LContador][0] := ADataset.FieldByName('CTR_DUPPAR').AsString + '-' +
                                                  ADataset.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                  ADataset.FieldByName('CTR_CODEMP').AsString;

    LValorTexto := ReplaceStr(FormatFloat(',0.00', ADataset.FieldByName('CTR_VALREC').AsFloat), '.', EmptyStr);
    LValorTexto := ReplaceStr(LValorTexto, ',', '.');

    Result.InformacoesAdicionais[LContador][1] := 'Valor da duplicata: ' + LValorTexto;

    ADataSet.Next;
  End;

end;

class function TFuncoesPixAutcom.RetornaChaveDaDuplicata(ADataset: TUniClientDataset;
  ACaptionTela: String): String;
  Var
    LRecordNumber: Integer;
begin
  LRecordNumber := ADataset.RecNo;

  Try
    ADataset.First;

    Result := Concat(ADataset.FieldByName('CTR_NUMDUP').AsString, '-',
                     ADataset.FieldByName('CTR_ESPDOC').AsString, '-',
                     ADataset.FieldByName('CTR_PARCEL').AsString, '-',
                     ADataset.FieldByName('CTR_CODEMP').AsString, '|');

    Result := Concat(Result,
                     fStrZero(ADataset.RecordCount.ToString, 3) + ' duplicata(s)|',
                     ACaptionTela);
  Finally
    ADataset.RecNo := LRecordNumber;
  End;
end;

class function TFuncoesPixAutcom.RetornaChaveDaVenda(
  AOjetoFatVenda: TFatVenda; ACaptionTela: String): String;
begin
  If Not Assigned(AOjetoFatVenda) Then
    Exit(EmptyStr);

  Result := Concat(AOjetoFatVenda.strNumOrc, '-', AOjetoFatVenda.strEspOrc, '-A-', AOjetoFatVenda.strEmpOri, '|');

  If AOjetoFatVenda.strNumOrc.IsEmpty Then
    Result := Concat(AOjetoFatVenda.strNumDoc, '-',
                     AOjetoFatVenda.strEspDoc, '-A-',
                     IIF(Not AOjetoFatVenda.strEmpDoc.IsEmpty, AOjetoFatVenda.strEmpDoc, AOjetoFatVenda.strEmpLog), '|');

  Result := Concat(Result,
                   fStrZero(Length(AOjetoFatVenda.arrMatItens).ToString, 3) + ' item(ns)|',
                   ACaptionTela);
end;

class function TFuncoesPixAutcom.RetornaContasBancariasComCertificadosAVencerVencidos: String;
  Var
    LPixDao: TPixDao;

    LDadosContaBancaria: TUniClientDataset;
begin
  Result := '';

  If Not fCfgSis('USAPIX', varBoolean) Then
    Exit;

  If fCampoTabela('OPE_MSGCPX', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]) <> 'S' Then
    Exit;

  LPixDao := TPixDao.Create;
  LDadosContaBancaria := Nil;
  Try
    LDadosContaBancaria := LPixDao.RetornaDatasetContasBancariasComCertificadosAVencerVencidos;

    LDadosContaBancaria.First;
    While Not LDadosContaBancaria.Eof Do
    Begin
      Result := Result +
                'Banco: ' + LDadosContaBancaria.FieldByName('CCA_CODBCO').AsString + ' - ' +
                'Agência: ' + LDadosContaBancaria.FieldByName('CCA_AGENCI').AsString +
                              LDadosContaBancaria.FieldByName('CCA_DIGAGE').AsString + ' - ' +
                'Conta: ' + LDadosContaBancaria.FieldByName('CCA_CODCTA').AsString +
                            LDadosContaBancaria.FieldByName('CCA_DIGCTA').AsString + ' - ' +
                'Empresa: ' + LDadosContaBancaria.FieldByName('CCA_CODEMP').AsString + ' - ' +
                'Validade Certificado: ' + FormatDateTime('dd/mm/yyyy', LDadosContaBancaria.FieldByName('CCA_VALCER').AsDateTime) +
                #13 + #13;

      LDadosContaBancaria.Next;
    End;

    If Not Result.IsEmpty Then
      Result := 'Existe(m) conta(s) bancária(s) com certificado Pix vencido ou próximo a vencer. ' + #13 +
                'Dados da(s) conta(s): ' + #13 + #13 +
                Result +
                'Aperte ESC para sair.';
  Finally
    FreeAndNil(LPixDao);
    FreeAndNilDatasets(LDadosContaBancaria);
  End;
end;

class function TFuncoesPixAutcom.RetornaDadosRequisicaoCaixa(
  ADadosPagador: String; AValorPix: Double;
  ACodigoCLiente: String; AUtilizaShipay: Boolean = False): TDadosRequisicaoPixAVista;
  Var
    LDadosCliente: TUniQuery;
begin
  Result := TDadosRequisicaoPixAVista.Create;
  Result.Expiracao := 86400;

  Result.TipoDevedor := '2';
  Result.NomeDevedor := '';
  Result.CPFCNPJDevedor := '';
  If Not ACodigoCLiente.IsEmpty Then
  Begin
    LDadosCliente := fCriaQuery;
    LDadosCliente.SQL.Text := 'SELECT CLI_CGCCPF, CLI_C_G_C_, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI="' + ACodigoCliente + '"';
    LDadosCliente.Open;

    If Not fClienteConsumidor(fRetNomCliente(ACodigoCliente) ,True, True, True) Then
    Begin
      Result.TipoDevedor := LDadosCliente.FieldByname('CLI_CGCCPF').AsString;
      Result.CPFCNPJDevedor := LDadosCliente.FieldByname('CLI_C_G_C_').AsString;
      Result.NomeDevedor := LDadosCliente.FieldByname('CLI_NOMCLI').AsString;
    End;

    FreeAndNil(LDadosCliente);
  End;

  If Result.CPFCNPJDevedor.IsEmpty Then
    Result.NomeDevedor := '';

  Result.Valor := ReplaceStr(FormatFloat(',0.00', AValorPix), '.', EmptyStr);
  Result.Valor := ReplaceStr(Result.Valor, ',', '.');

  Result.InformacoesAdicionais[0][0] := ADadosPagador;
  Result.InformacoesAdicionais[0][1] := Result.Valor;

  Result.SolicitacaoPagador := ADadosPagador;
end;

class function TFuncoesPixAutcom.RetornaDadosRequisicaoCreditoCliente(
  AValorPix: Double; ACodigoCLiente: String): TDadosRequisicaoPixAVista;
  Var
    LDadosCliente: TUniQuery;

    LValorTexto: String;
begin
  Result := TDadosRequisicaoPixAVista.Create;
  Result.Expiracao := 86400;

  Result.TipoDevedor := '2';
  Result.NomeDevedor := '';
  Result.CPFCNPJDevedor := '';

  If Not ACodigoCLiente.IsEmpty Then
  Begin
    LDadosCliente := fCriaQuery;
    LDadosCliente.SQL.Text := 'SELECT CLI_CGCCPF, CLI_C_G_C_, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI="' + ACodigoCliente + '"';
    LDadosCliente.Open;

    If Not fClienteConsumidor(fRetNomCliente(ACodigoCliente) ,True, True, True) Then
    Begin
      If fValidaCnpjCpf(LDadosCliente.FieldByname('CLI_C_G_C_').AsString) Then
      Begin
        Result.TipoDevedor := LDadosCliente.FieldByname('CLI_CGCCPF').AsString;
        Result.CPFCNPJDevedor := LDadosCliente.FieldByname('CLI_C_G_C_').AsString;
        Result.NomeDevedor := LDadosCliente.FieldByname('CLI_NOMCLI').AsString;
      End;
    End;

    FreeAndNil(LDadosCliente);
  End;

  If Result.CPFCNPJDevedor.IsEmpty Then
    Result.NomeDevedor := '';

  Result.Valor := ReplaceStr(FormatFloat(',0.00', AValorPix), '.', EmptyStr);
  Result.Valor := ReplaceStr(Result.Valor, ',', '.');

  Result.SolicitacaoPagador := 'Pix gerado referente a geração de crédito de cliente';

  Result.InformacoesAdicionais[0][0] := 'Geração de crédito de cliente';

  LValorTexto := ReplaceStr(FormatFloat(',0.00', AValorPix), '.', EmptyStr);
  LValorTexto := ReplaceStr(LValorTexto, ',', '.');

  Result.InformacoesAdicionais[0][1] := 'Valor do crédito: ' + LValorTexto;
end;

class function TFuncoesPixAutcom.RetornaDadosRequisicaoPedido(
  AObjetoVenda: TFatVenda; AValorPix: Double = 0): TDadosRequisicaoPixAVista;
  Var
    LDadosCliente: TUniQuery;

    LExpiracao,
    LContador: Integer;
begin
  Result := TDadosRequisicaoPixAVista.Create;
  Result.Expiracao := 86400;

  LExpiracao := fCfgSis('EXPPIX', varInteger);
  If LExpiracao > 0 Then
    Result.Expiracao := LExpiracao * 3600;

  Result.TipoDevedor := '2';
  Result.NomeDevedor := '';
  Result.CPFCNPJDevedor := '';
  If Not AObjetoVenda.FGraCon Then
  Begin
    LDadosCliente := fCriarQuery('SELECT CLI_CGCCPF, CLI_C_G_C_, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI="' + AObjetoVenda.strCodCli + '"');
    LDadosCliente.Open;

    If Not fClienteConsumidor(fRetNomCliente(AObjetoVenda.strCodCli) ,True, True, True) Then
    Begin
      Result.TipoDevedor := LDadosCliente.FieldByname('CLI_CGCCPF').AsString;
      Result.CPFCNPJDevedor := LDadosCliente.FieldByname('CLI_C_G_C_').AsString;
      Result.NomeDevedor := LDadosCliente.FieldByname('CLI_NOMCLI').AsString;
    End;

    FreeAndNil(LDadosCliente);
  End;

  If Result.CPFCNPJDevedor.IsEmpty Then
    Result.NomeDevedor := '';

  Result.Valor := ReplaceStr(FormatFloat(',0.00', AValorPix), '.', EmptyStr);
  If AValorPix = 0 Then
    Result.Valor := ReplaceStr(FormatFloat(',0.00', AObjetoVenda.DadosPixDaVenda.ValorDoPix), '.', EmptyStr);

  Result.Valor := ReplaceStr(Result.Valor, ',', '.');

  Result.SolicitacaoPagador := 'Pix gerado referente ao pedido ' + AObjetoVenda.strNumDoc;
  If AObjetoVenda.strNumDoc.IsEmpty Then
    Result.SolicitacaoPagador := 'Pix gerado referente ao pedido ' + AObjetoVenda.strNumOrc;

  If AObjetoVenda.strOpcDoc = 'VN' Then
    Result.SolicitacaoPagador := 'Pix gerado referente a venda';

  If Not AObjetoVenda.DadosPixDaVenda.InformacoesAdicionais[0][0].IsEmpty Then
  Begin
    Result.SolicitacaoPagador := 'Pix gerado referentes aos pedidos';

    For LContador := 0 To 49 Do
    Begin
      Result.InformacoesAdicionais[LContador][0] := AObjetoVenda.DadosPixDaVenda.InformacoesAdicionais[LContador][0];
      Result.InformacoesAdicionais[LContador][1] := AObjetoVenda.DadosPixDaVenda.InformacoesAdicionais[LContador][1];
    End;
  End;
end;

class function TFuncoesPixAutcom.RetornaDadosRequisicaoReceber(
  ADataset: TUniClientDataSet; AValorPix: Double;
  ACodigoCLiente: String): TDadosRequisicaoPixAVista;
  Var
    LDadosCliente: TUniQuery;

    LContador: Integer;

    LValorTexto: String;
begin
  Result := TDadosRequisicaoPixAVista.Create;
  Result.Expiracao := 86400;

  Result.TipoDevedor := '2';
  Result.NomeDevedor := '';
  Result.CPFCNPJDevedor := '';
  If Not ACodigoCLiente.IsEmpty Then
  Begin
    LDadosCliente := fCriaQuery;
    LDadosCliente.SQL.Text := 'SELECT CLI_CGCCPF, CLI_C_G_C_, CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI="' + ACodigoCliente + '"';
    LDadosCliente.Open;

    If Not fClienteConsumidor(fRetNomCliente(ACodigoCliente) ,True, True, True) Then
    Begin
      Result.TipoDevedor := LDadosCliente.FieldByname('CLI_CGCCPF').AsString;
      Result.CPFCNPJDevedor := LDadosCliente.FieldByname('CLI_C_G_C_').AsString;
      Result.NomeDevedor := LDadosCliente.FieldByname('CLI_NOMCLI').AsString;
    End;

    FreeAndNil(LDadosCliente);
  End;

  If Result.CPFCNPJDevedor.IsEmpty Then
    Result.NomeDevedor := '';

  Result.Valor := ReplaceStr(FormatFloat(',0.00', AValorPix), '.', EmptyStr);
  Result.Valor := ReplaceStr(Result.Valor, ',', '.');

  Result.SolicitacaoPagador := 'Pix gerado referente ao pagamento de duplicatas';

  If ADataset.FindField('CTR_MARDES') = Nil Then
    Exit;

  ADataset.Filter := 'CTR_MARDES=''M'' ';
  ADataset.Filtered := True;
  ADataset.First;
  For LContador := 0 To 49 Do
  Begin
    If ADataSet.Eof Then
      Break;

    Result.InformacoesAdicionais[LContador][0] := ADataset.FieldByName('CTR_NUMDUP').AsString + '-' +
                                                  ADataset.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                  ADataset.FieldByName('CTR_CODEMP').AsString;

    LValorTexto := ReplaceStr(FormatFloat(',0.00', ADataset.FieldByName('CTR_VALREC').AsFloat), '.', EmptyStr);
    LValorTexto := ReplaceStr(LValorTexto, ',', '.');

    Result.InformacoesAdicionais[LContador][1] := 'Valor da duplicata: ' + LValorTexto;

    ADataSet.Next;
  End;
end;

class function TFuncoesPixAutcom.RetornaDatasetPixPagosSemConfirmacao(
  AOperador: String): TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT M.*, ' +
                          '       C.CCA_CODBCO AS BANCO,  ' +
                          '       CONCAT(P.POR_CODPOR, "-", P.POR_NOMPOR) AS PORTADOR, ' +
                          '       CONVERT(CONCAT(M.MPX_DTAREC, " ", M.MPX_HORREC), DATETIME) AS DATARECEBIMENTO, ' +
                          '       CONCAT(O.OPE_CODOPE, "-", O.OPE_NOMOPE) AS VENDEDOR, ' +
                          '       L.LOG_CODCLI, ' +
                          '       L.LOG_CHADOC, ' +
                          '       L.LOG_VALDOC, ' +
                          '       L.LOG_QTDITE, ' +
                          '       L.LOG_NOMTEL  ' +
                          'FROM MOVPIX M ' +
                          'JOIN CCAPIX PX ON PX.AUTOINCREM=M.MPX_SEQPIX ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=PX.PIX_SEQCCA ' +
                          'JOIN CADPOR P ON P.POR_CCAAUT=C.AUTOINCREM ' +
                          'JOIN CADOPE O ON O.OPE_CODOPE=M.MPX_CODOPE ' +
                          'LEFT JOIN DEL_MONPIX_LOG L ON L.LOG_CODEMP=M.MPX_CODEMP ' +
                          '                          AND L.LOG_TX_ID_=M.MPX_TX_ID_ ' +

                          'WHERE M.MPX_STATUS IN ("CONCLUIDACC", "approvedCC") ';

    If Not AOperador.IsEmpty Then
      LConsulta.SQL.Add('  AND M.MPX_CODOPE="' + AOperador + '"');

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.Open;
    Result.First;

    While Not Result.Eof Do
    Begin
      If Result.FieldByName('LOG_CHADOC').AsString.IsEmpty Then
      Begin
        Result.Next;
        Continue;
      End;

      If Length(Result.FieldByName('LOG_CHADOC').AsString.Split(['-'])) < 4 Then
      Begin
        Result.Next;
        Continue;
      End;

      If Result.FieldByName('LOG_CHADOC').AsString.Split(['-'])[0].IsEmpty Then
      Begin
        Result.Edit;
        Result.FieldByName('LOG_CHADOC').AsString := 'Não Confirmado-' +
                                                     Result.FieldByName('LOG_CHADOC').AsString.Split(['-'])[1] + '-' +
                                                     Result.FieldByName('LOG_CHADOC').AsString.Split(['-'])[2] + '-' +
                                                     Result.FieldByName('LOG_CHADOC').AsString.Split(['-'])[3];
        Result.Post;
      End;

      Result.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixAutcom.SolicitarDevolucao(AIDPagamento,
  AIDDevolucao: String; AValorDevolucao: Double; AAutoIncremChavePix: String = '';
  AUtilizaShipay: Boolean = False): String;
  Var
    LRespostaRequisicao,
    LDadosDevolucao,
    LErro: String;

    LRequisicoesPix: IRequisicoesPix;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicoesPix := CriaObjetoRequisicoesPix(AAutoIncremChavePix);

    LDadosDevolucao := '{' +
                       '  "valor": "' + FormatFloat(',0.00', AValorDevolucao).Replace('.', EmptyStr).Replace(',', '.') + '" ' +
                       '}';

    If AUtilizaShipay Then
      LDadosDevolucao := '{' +
                         '  "amount": ' + FormatFloat(',0.00', AValorDevolucao).Replace('.', EmptyStr).Replace(',', '.') +
                         '}';

    LRespostaRequisicao := LRequisicoesPix.SolicitarDevolucao(AIDPagamento,
                                                              AIDDevolucao,
                                                              LDadosDevolucao);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRespostaRequisicao);
    If Not LErro.IsEmpty Then
      Raise Exception.Create('DEVPIX-' + LErro);

    Result := LRespostaRequisicao;
  Finally
    LiberaObjetosIntegracaoPix(LRequisicoesPix);
  End;
end;

class function TFuncoesPixAutcom.ValidacoesCondicaoDePagamentoPix(
  AObjetoFatVenda: TFatVenda; var ACondicaoPixJaLiberada: Boolean): Boolean;
begin
  Result := Not Assigned(AObjetoFatVenda);

  If Result Then
    Exit;

  if AObjetoFatVenda.fPedidoComPixPagoLiberadoParaAlteracao Then
  begin
    ACondicaoPixJaLiberada := True;
    Exit(True) ;
  end ;

  Result := Not AObjetoFatVenda.DadosPixDaVenda.GerarPixDaVenda;

  If Result Then
    Exit;
  
  If AObjetoFatVenda.strOpcDoc = 'VN' Then
  Begin
    If (Not fCfgSis('BAIAVI', varBoolean)) Then
    Begin
      If AObjetoFatVenda.strOriF11 = 'N' Then
      Begin
        Result := Not AObjetoFatVenda.DadosPixDaVenda.TxIdPix.IsEmpty;
        If Not Result Then
        Begin
          fMensagem('ATENÇÃO', 'Não é possível gerar um novo Pix para o pedido através da opção Venda Normal quando a configuração CFG_BAIAVI estiver como "Não".', ['&Ok']);

          Exit;
        End;
      End;
    End;
  End;

  If AObjetoFatVenda.DadosPixDaVenda.AlterarCondicaoDePagamento Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário alterar a condição que pagamento que não seja recebimento por Pix.', ['&Ok']);

    Exit(False);
  End;

  If Not TPixDao.VerificaSePossuiChavePixSelecionada Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe nenhuma chave pix configurada. Verificar a configuração CFG_CHAPIX.', ['&Ok']);

    Exit(False);
  End;

  Result := VerificaPermissaoParaUtilizarPix(ACondicaoPixJaLiberada);

  ACondicaoPixJaLiberada := Result;
end;

class function TFuncoesPixAutcom.ValidaCondicaoPagamentoConfirmacaoDocumentos(
  AObjetoFatVenda: TFatVenda): Boolean;
begin
  Result := True;

  If Not Assigned(AObjetoFatVenda) Then
    Exit;

  If AObjetoFatVenda.strOpcDoc <> 'CP' Then
    Exit;

  If Not AObjetoFatVenda.DadosPixDaVenda.GerarPixDaVenda Then
    Exit;

  If AObjetoFatVenda.DadosPixDaVenda.TxIdPix.IsEmpty Then
  Begin
    Result := False;

    fMensagem('ATENÇÃO', 'Não pode ser utilizado condição de pagamento que realiza recebimento por Pix.', ['&Ok']);
  End;
end;

class function TFuncoesPixAutcom.ValidarDadosAutenticacao(
  AAutoIncremChavePix: String): Boolean;
  Var
    LRespostaRequisicao,
    LErro: String;

    LRequisicoesPix: IRequisicoesPix;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Result := False;
  Try
    CarregaLibIntegracaoPixCitel;
    TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(FHandlePixCitel);

    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicoesPix := CriaObjetoRequisicoesPix(AAutoIncremChavePix);

    LRespostaRequisicao := LRequisicoesPix.ValidarDadosAutenticacao;

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRespostaRequisicao);
    If Not LErro.IsEmpty Then
      Raise Exception.Create(LErro);

    Result := Not LRespostaRequisicao.IsEmpty;

    If Not Result Then
      Raise Exception.Create('Os dados de autentição não foram validados pelo banco.' + #13 +
                             'Verifique os dados digitados na aba "Dados de Autorização Pix".');
  Finally
    LiberaObjetosIntegracaoPix(LRequisicoesPix);
  End;
end;

class function TFuncoesPixAutcom.VerificaPermissaoParaUtilizarPix(
  ACondicaoPixJaLiberada: Boolean): Boolean;
  Var
    LObjetoLock: TLiberacao;
begin
  If ACondicaoPixJaLiberada Then
    Exit(True);

  Result := fVerificaAcessoSistema('PERMRECPIX', strLoginUsuarioLogado);

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Sem permissão para utilizar a condição de pagamento para recebimento por Pix.', ['&Ok']);

    LObjetoLock := TLiberacao.Create;

    LObjetoLock.Clear;
    LObjetoLock.objMsgLibera.pAddTexto('Permitir realizar o pedido utilizando condição de pagamento que utilize o Pix');

    LObjetoLock.strDirAce := 'PERMRECPIX';
    LObjetoLock.strMsgSen := 'Permitir realizar o pedido utilizando condição de pagamento que utilize o Pix';
    LObjetoLock.strCodOpe := strLoginUsuarioLogado;
    LObjetoLock.strCodDig := strLoginUsuarioLogado;

    Result := LObjetoLock.fLibera;
  End;
end;

class procedure TFuncoesPixAutcom.InserirRegistroTFPixNoCaixa(
  ARegistroPix: TDadosRetornoPixConsulta; AOperadorCaixa: String;
  AEmpresaCaixa: String = '');
  Var
    LEmpresaCaixa,
    LAutoIncrem: String;
begin
  Try
    LAutoIncrem := '';

    LEmpresaCaixa := VS_strCodEmp;
    If Not AEmpresaCaixa.IsEmpty Then
      LEmpresaCaixa := AEmpresaCaixa;

    If Not fGravaCadRcx(LAutoIncrem,                                                  //autoincrem
                        '',                                                           //Código do Cliente
                        AOperadorCaixa,                                               //Operador
                        '',                                                           //Documento
                        'TF',                                                         //Espécie
                        LEmpresaCaixa,                                                //Empresa
                        ARegistroPix.DataCaixa,                                       //Data de Cadastro
                        fTime(),                                                      //Hora de Cadastro
                        '',                                                           //Duplicata {**Req. 97805**20/04/2018**WS**}
                        '',                                                           //Parcela   {**Req. 97805**20/04/2018**WS**}
                        'REF. TRANSF. CX./PORT: ' + ARegistroPix.CodigoPortador +'/', //Descrição
                        '',                                                           //Juros / Dessconto
                        '',                                                           //Identificação de Fechamento
                        '',                                                           //Forma de Pagamento
                        ARegistroPix.ValorPago * (-1),                                //Valor do Documento
                        0.00,                                                         //Desconto Recebido
                        0.00,                                                         //Juros Recebido
                        0.00,                                                         //Valor em dinheiro
                        0.00,                                                         //Valor em Cheque à Vista
                        0.00,                                                         //Valor em Cheque Pré
                        0.00,                                                         //Valor em Cartão
                        ARegistroPix.ValorPago * (-1),                                //Valor em Ordem de Pagamento
                        0.00,                                                         //Valor de Crédito de Cliente
                        0.00,                                                         //Valor em Financiamento
                        0.0,                                                          //Valor em outras modalidades
                        0.0,                                                          //Valor de venda a prazo
                        '',                                                           //Num. do Romaneio
                        ARegistroPix.SeqConTransferencia,                             //Sequencial de Controle
                        0,                                                            //Sequencial de Baixa (Duplicata)
                        fCfgSisL('SQFCRX'),                                           //Sequencial de Fechamento parcial de caixa
                        LEmpresaCaixa,                                                 //Empresa da duplicata
                        '',                                                           //Motivo do desconto
                        2,                                                            //Identificação do Caixa
                        0.00,
                        0.00,
                        0.00,
                        0.00,
                        0.00,
                        'N',
                        '',
                        ARegistroPix.CodigoDoCaixa,
                        '',
                        0.00,
                        False,
                        0.00,
                        '',
                        0,
                        'S') Then                                                     //Recebido por Pix
      Raise Exception.Create('Não foi possível gravar a transferência do Pix no caixa.');
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

class procedure TFuncoesPixAutcom.InserirRegistroTFPixNoCaixaCancelamento(
  ASeqTrf: Integer; ACodigoEmpresa: String; ADataLancamento: TDateTime;
  ASeqConTransferencia: Integer);
  Var
    LConsulta: TUniQuery;

    LAutoIncrem: String;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM CADRCXX ' +
                          'WHERE RCX_DTACAD=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP ' +
                          '  AND RCX_ESPDOC="TF"    ' +
                          '  AND RCX_SEQCON=:SEQCON ';

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataLancamento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqTrf;

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Raise Exception.Create('Não foi possível cancelar o registro do Pix no resumo de caixa.' + #13 +
                             'Lançamento de inclusão do registro não encontrado.');

    LConsulta.Edit;
    LConsulta.FieldByName('RCX_TFCANC').AsString := 'S';
    LConsulta.Post;

    LAutoIncrem := '';

    If Not fGravaCadRcx(LAutoIncrem,                                                  //autoincrem
                        '',                                                           //Código do Cliente
                        LConsulta.FieldByName('RCX_CODOPE').AsString,                 //Operador
                        '',                                                           //Documento
                        'TF',                                                         //Espécie
                        LConsulta.FieldByName('RCX_CODEMP').AsString,                 //Empresa
                        LConsulta.FieldByName('RCX_DTACAD').AsDateTime,               //Data de Cadastro
                        fTime(),                                                      //Hora de Cadastro
                        '',                                                           //Duplicata {**Req. 97805**20/04/2018**WS**}
                        '',                                                           //Parcela   {**Req. 97805**20/04/2018**WS**}
                        'REF. CANC. TRANSF. CAIXA PIX No. ' + LConsulta.FieldByName('RCX_SEQCON').AsString + ' EMP ' + LConsulta.FieldByName('RCX_CODEMP').AsString, //Descrição
                        '',                                                           //Juros / Dessconto
                        '',                                                           //Identificação de Fechamento
                        '',                                                           //Forma de Pagamento
                        LConsulta.FieldByName('RCX_VALDOC').AsFloat * (-1),           //Valor do Documento
                        0.00,                                                         //Desconto Recebido
                        0.00,                                                         //Juros Recebido
                        0.00,                                                         //Valor em dinheiro
                        0.00,                                                         //Valor em Cheque à Vista
                        0.00,                                                         //Valor em Cheque Pré
                        0.00,                                                         //Valor em Cartão
                        LConsulta.FieldByName('RCX_ORDREC').AsFloat * (-1),           //Valor em Ordem de Pagamento
                        0.00,                                                         //Valor de Crédito de Cliente
                        0.00,                                                         //Valor em Financiamento
                        0.0,                                                          //Valor em outras modalidades
                        0.0,                                                          //Valor de venda a prazo
                        '',                                                           //Num. do Romaneio
                        ASeqConTransferencia,                                         //Sequencial de Controle
                        0,                                                            //Sequencial de Baixa (Duplicata)
                        fCfgSisL('SQFCRX'),                                           //Sequencial de Fechamento parcial de caixa
                        LConsulta.FieldByName('RCX_CODEMP').AsString,                 //Empresa da duplicata
                        '',                                                           //Motivo do desconto
                        2,                                                            //Identificação do Caixa
                        0.00,
                        0.00,
                        0.00,
                        0.00,
                        0.00,
                        LConsulta.FieldByName('RCX_TFCANC').AsString,
                        '',
                        LConsulta.FieldByName('RCX_CODCAX').AsString,
                        '',
                        0.00,
                        False,
                        0.00,
                        '',
                        0,
                        'S') Then                                                     //Recebido por Pix
      Raise Exception.Create('Não foi possível gravar a transferência do Pix no caixa.');
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class procedure TFuncoesPixAutcom.InserirRegistroTFPixNaMOVBAN(
  ARegistroPix: TDadosRetornoPixConsulta; AOperadorCaixa: String;
  AEmpresaCaixa: String = '');
  Var
    LBanTrf: TBanTrfDS;

    LListaBanTrf: TListaBanTrf;

    LSeqLan,
    LEmpresaCaixa,
    LPortadorDescricao: String;

    LDataMovimentacaoBancaria: TDateTime;
begin
  Try
    LEmpresaCaixa := VS_strCodEmp;
    If Not AEmpresaCaixa.IsEmpty Then
      LEmpresaCaixa := AEmpresaCaixa;

    LPortadorDescricao := ARegistroPix.CodigoPortador + '-' + fRetNomPortador(ARegistroPix.CodigoPortador);

    LDataMovimentacaoBancaria := VS_Date;
    If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [ARegistroPix.CodigoPortador]) = 'S' Then
      LDataMovimentacaoBancaria := fAcertaDataParaDiaUtil(VS_Date);

    LBanTrf := TBanTrfDS.Create;
    LBanTrf.strCodOpe := AOperadorCaixa;
    LBanTrf.strCodEmp := LEmpresaCaixa;
    LBanTrf.strDescri := 'TF CAIXA (ORD) PIX - ' + LPortadorDescricao;
    LBanTrf.fltValDoc := ARegistroPix.ValorPago;
    LBanTrf.fltDinRec := 0.00;
    LBanTrf.fltChqAvi := 0.00;
    LBanTrf.fltChqPre := 0.00;
    LBanTrf.fltCarRec := 0.00;
    LBanTrf.fltOrdRec := ARegistroPix.ValorPago;
    LBanTrf.fltValFin := 0.00;

    LListaBanTrf := TListaBanTrf.Create;
    LListaBanTrf.Add(LBanTrf);

    {*******************************************}
    {* REALIZA GRAVAÇÃO DO MOVBAN              *}
    {****************************************AF*}
    LSeqLan := fGravaMovBan(ARegistroPix.PlanoDeContas,                        // Centro de Custo
                            ARegistroPix.CodigoPortador,                       // Portador da Baixa
                            AOperadorCaixa,                                    // Operador da Baixa
                            LDataMovimentacaoBancaria,                         // Data do Lançamento
                            fTime(),                                           // Hora do Lançamento
                            '',                                                // Numero do Documento
                            'C',                                               // Credito / Debito
                            LEmpresaCaixa,                                      // Empresa da Baixa
                            ARegistroPix.ValorPago,                            // Valor Do Lançamento
                            'TF CAIXA (ORD) PIX - ' + LPortadorDescricao,      // Histórico 1
                            '',                                                // Histórico 2
                            '',                                                // Cliente da Duplicata
                            '',                                                // Fornecedor da Duplicata
                            '',                                                // Número da Duplicata
                            0,                                                 // Sequencial de Baixa
                            'A',                                               // Parcela da Duplicata
                            LEmpresaCaixa,                                     // Empresa da Duplicata
                            '',                                                // Série
                            '',                                                // Codigo do Evento
                            '',                                                // Documento da Baixa
                            Nil,                                               // Log Bancário
                            ARegistroPix.SeqConTransferencia,                  // Sequencial de Transf.
                            0,
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            1,
                            True,
                            LListaBanTrf);

    FreeAndNil(LBanTrf);
    FreeAndNil(LListaBanTrf);

    ARegistroPix.SeqLanTransferencia := LSeqLan;
    ARegistroPix.DataGravacaoMovBan := LDataMovimentacaoBancaria;

    If LSeqLan.IsEmpty Then
      Raise Exception.Create('Ocorreu um erro na gravação do MOVBAN da transferência do Pix!');

    untLogCba.GravaLogCba(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'], [LSeqLan]),
                          'INCLUSÃO - TRANSFERÊNCIA',
                          'TFuncoesPixAutcom.InserirRegistroTFPixNaMOVBAN',
                          '',
                          Nil,
                          AOperadorCaixa);

    ARegistroPix.DataGravacaoMovBan := LDataMovimentacaoBancaria;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

class procedure TFuncoesPixAutcom.InserirRegistroTFPixNaMOVBANCancelamento(
  ASeqTrf: Integer; ACodigoEmpresa: String; ADataLancamento: TDateTime;
  ASeqConTransferencia: Integer);
  Var
    LBanTrf: TBanTrfDS;

    LListaBanTrf: TListaBanTrf;

    LSeqLan,
    LOperador: String;

    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM MOVBAN ' +
                          'WHERE CTB_DTALAN>=:DTALAN ' +
                          '  AND CTB_CODEMP=:CODEMP ' +
                          '  AND CTB_SEQTRF=:SEQCON ' +
                          'ORDER BY CTB_DTALAN ';

    LConsulta.ParamByName('DTALAN').AsDateTime := ADataLancamento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqTrf;

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Raise Exception.Create('Não foi possível cancelar o registro do Pix no resumo de caixa.' + #13 +
                             'Lançamento de inclusão do registro da movimentação bancária não encontrado.');

    LOperador := LConsulta.FieldByName('CTB_CODOPE').AsString;

    LBanTrf := TBanTrfDS.Create;
    LBanTrf.strCodOpe := LOperador;
    LBanTrf.strCodEmp := LConsulta.FieldByName('CTB_CODEMP').AsString;
    LBanTrf.strDescri := LConsulta.FieldByName('CTB_HIST01').AsString;
    LBanTrf.fltValDoc := LConsulta.FieldByName('CTB_VALLAN').AsFloat;
    LBanTrf.fltDinRec := 0.00;
    LBanTrf.fltChqAvi := 0.00;
    LBanTrf.fltChqPre := 0.00;
    LBanTrf.fltCarRec := 0.00;
    LBanTrf.fltOrdRec := LConsulta.FieldByName('CTB_VALLAN').AsFloat;
    LBanTrf.fltValFin := 0.00;

    LListaBanTrf := TListaBanTrf.Create;
    LListaBanTrf.Add(LBanTrf);

    {*******************************************}
    {* REALIZA GRAVAÇÃO DO MOVBAN              *}
    {****************************************AF*}
    LSeqLan := fGravaMovBan(LConsulta.FieldByName('CTB_CODCTA').AsString,      // Centro de Custo
                            LConsulta.FieldByName('CTB_CODPOR').AsString,      // Portador da Baixa
                            LOperador,                                         // Operador da Baixa
                            LConsulta.FieldByName('CTB_DTALAN').AsDateTime,    // Data do Lançamento
                            fTime(),                                           // Hora do Lançamento
                            '',                                                // Numero do Documento
                            'D',                                               // Credito / Debito
                            LConsulta.FieldByName('CTB_CODEMP').AsString,      // Empresa da Baixa
                            LConsulta.FieldByName('CTB_VALLAN').AsFloat,       // Valor Do Lançamento
                            LConsulta.FieldByName('CTB_HIST01').AsString,      // Histórico 1
                            '',                                                // Histórico 2
                            '',                                                // Cliente da Duplicata
                            '',                                                // Fornecedor da Duplicata
                            '',                                                // Número da Duplicata
                            0,                                                 // Sequencial de Baixa
                            'A',                                               // Parcela da Duplicata
                            LConsulta.FieldByName('CTB_EMPDUP').AsString,      // Empresa da Duplicata
                            '',                                                // Série
                            '',                                                // Codigo do Evento
                            '',                                                // Documento da Baixa
                            Nil,                                               // Log Bancário
                            ASeqConTransferencia,                              // Sequencial de Transf.
                            0,
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            1,
                            True,
                            LListaBanTrf);

    FreeAndNil(LConsulta);
    FreeAndNil(LBanTrf);
    FreeAndNil(LListaBanTrf);

    If LSeqLan.IsEmpty Then
      Raise Exception.Create('Ocorreu um erro na gravação do MOVBAN da transferência do Pix!');

    untLogCba.GravaLogCba(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'], [LSeqLan]),
                          'INCLUSÃO - TRANSFERÊNCIA CANCELAMENTO',
                          'TFuncoesPixAutcom.InserirRegistroTFPixNaMOVBANCancelamento',
                          '',
                          Nil,
                          VS_strCodigoOperadorLogadoCaixa);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

class procedure TFuncoesPixAutcom.RealizaLiberacaoDePedidosComPixPago(AEmpresaDoPix,
  ATxIdPix, ACodigoOperador: String);
  Var
    LConsulta,
    LAtualizar: TUniQuery;

    LDataLiberacao: TDateTime;

    LHoraLiberacao: TTime;

    LOperadorRobo,
    LLiberarFinanceiro,
    LLiberarComercial: String;
begin
  //Liberação Financeira e/ou comercial
  LLiberarFinanceiro := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [AEmpresaDoPix, 'CFG_LIBPIX']);
  LLiberarComercial := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [AEmpresaDoPix, 'CFG_LIBCPX']);

  If Pos('S', Concat(LLiberarFinanceiro, LLiberarComercial)) = 0 Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LAtualizar := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT E.FGO_SEQFGO ' +
                          'FROM EXTGOR E ' +
                          'JOIN FATGOR G ON G.AUTOINCREM=E.FGO_SEQFGO ' +
                          'WHERE E.FGO_EMPPIX=:EMPPIX ' +
                          '  AND E.FGO_TX_PIX=:TX_PIX ' +
                          '  AND ((G.FGO_LIBERA IS NULL OR ' +
                          '        G.FGO_LIBERA=0) OR ' +
                          '       (G.FGO_LIBCOM IS NULL OR ' +
                          '        G.FGO_LIBCOM=0)) ';

    LConsulta.ParamByName('EMPPIX').AsString := AEmpresaDoPix;
    LConsulta.ParamByName('TX_PIX').AsString := ATxIdPix;

    LConsulta.Open;

    LAtualizar.SQL.Text := 'SELECT G.AUTOINCREM, ' +
                           '       G.FGO_OPELIB, ' +
                           '       G.FGO_DIGLIB, ' +
                           '       G.FGO_DTALIB, ' +
                           '       G.FGO_HORLIB, ' +
                           '       G.FGO_OBSL01, ' +
                           '       G.FGO_OBSL02, ' +
                           '       G.FGO_LIBERA, ' +
                           '       G.FGO_LIBCOM  ' +
                           ' FROM FATGOR G ' +
                           ' WHERE ' +
                           '       G.AUTOINCREM=:AUTINC ';

    LDataLiberacao := fRetDataServidor;
    LHoraLiberacao := fRetHoraServidor;

    LOperadorRobo := fCfgSis('OPEAUT');
    If LOperadorRobo.IsEmpty Then
      LOperadorRobo := 'AUT';

    While Not LConsulta.Eof Do
    Begin
      LAtualizar.Close;
      LAtualizar.ParamByName('AUTINC').AsString := LConsulta.FieldByName('FGO_SEQFGO').AsString;
      LAtualizar.Open;

      LAtualizar.Edit;

      If LLiberarFinanceiro = 'S' Then
        LAtualizar.FieldByName('FGO_LIBERA').AsInteger := 1;

      If LLiberarComercial = 'S' Then
        LAtualizar.FieldByName('FGO_LIBCOM').AsInteger := 1;

      LAtualizar.FieldByName('FGO_OPELIB').AsString := ACodigoOperador;
      LAtualizar.FieldByName('FGO_DIGLIB').AsString := ACodigoOperador;
      LAtualizar.FieldByName('FGO_DTALIB').AsDateTime := LDataLiberacao;
      LAtualizar.FieldByName('FGO_HORLIB').AsDateTime := LHoraLiberacao;
      LAtualizar.FieldByName('FGO_OBSL01').AsString := 'LIBERADO PELO RECEBIMENTO FEITO POR PIX';

      If ACodigoOperador = LOperadorRobo Then
        LAtualizar.FieldByName('FGO_OBSL02').AsString := 'LIBERAÇÃO FEITA ATRAVÉS DA TAREFA AUTOMÁTICA';

      LAtualizar.Post;

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LAtualizar);
  End;
end;

class procedure TFuncoesPixAutcom.LiberaObjetosIntegracaoPix(
  var ARequisicoesPix: IRequisicoesPix);
begin
  ARequisicoesPix := Nil;
end;

class function TFuncoesPixAutcom.PixPagoComValorOMesmoValorDaCobranca(
  ADadosRetorno: TDadosRetornoPixConsulta): Boolean;
begin
  Result := MatchStr(ADadosRetorno.Status, STATUS_PIX_PAGO);

  If Not Result Then
    Exit;

  Result := FormatFloat(',0.00', ADadosRetorno.Valor) =
            FormatFloat(',0.00', ADadosRetorno.ValorPago);

  If Not Result Then
    fMensagem('ERRO', 'O valor pago do Pix de ' + FormatFloat(',0.00', ADadosRetorno.ValorPago) +
                      ' não corresponde ao valor da cobrança.' + #13 +
                      'Não é possível gravar uma cobrança inconistente.', ['&Ok']);
end;

class procedure TFuncoesPixAutcom.pRegistrarBridgeTefSeNecessario(AHandle: THandle);
var
  pSuporta : function: LongBool; stdcall;
  pRegistra: procedure(ABridge: IPixTefBridge); stdcall;
begin
  if FBridgeJaRegistrado then
    Exit;

  if VS_TefPixLigado <> 'S' then
    Exit;

  if AHandle = 0 then
    Exit;

  pSuporta  := GetProcAddress(AHandle, 'LibSuportaPixViaTef');
  pRegistra := GetProcAddress(AHandle, 'RegistraBridgeTefPix');

  if Assigned(pSuporta) and Assigned(pRegistra) and pSuporta() then
  begin
    pRegistra(TPixTefBridgeAutcom.GetInstance(objTefCitel));
    FBridgeJaRegistrado := True;
  end;
end;

class procedure TFuncoesPixAutcom.pResetarRegistro;
begin
  FBridgeJaRegistrado := False;
end;

Initialization
  EnviaDadosDocumentoPixTela := Nil;
  EnviaDadosDocumentoPixTelaV2 := Nil;
  RetornaDadosChavePixTela := Nil;
  TFuncoesPixAutcom.FHandlePixCitel := 0;
  TFuncoesPixAutcom.FPixCitel := Nil;

Finalization
  EnviaDadosDocumentoPixTela := Nil;
  EnviaDadosDocumentoPixTelaV2 := Nil;
  RetornaDadosChavePixTela := Nil;

  If TFuncoesPixAutcom.FPixCitel <> Nil Then
    FreeAndNil(TFuncoesPixAutcom.FPixCitel);

  TFuncoesPix.LiberaLibIntegracaoPix(TFuncoesPixAutcom.FHandlePixCitel);

end.
