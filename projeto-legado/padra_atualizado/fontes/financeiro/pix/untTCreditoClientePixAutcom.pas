unit untTCreditoClientePixAutcom;

interface

Uses System.Classes, System.StrUtils, System.SysUtils, Vcl.Forms, WinApi.Windows,
     untTiposPix, cxProgressBar, untTypesSistema, UniClientDataset, Data.DB, Uni,
     System.Variants;

  Type
    TCreditoClientePixAutcom = class
  private
    FAutoIncremMovPix,
    FNomeFormulario,
    FClienteSelecionado,
    FAmbienteHomologacao,
    FSequencialCCPago,
    FSeqLanCCPago: String;

    FValorDoPix: Double;

    FDadosRetornoPix: TDadosRetornoPixAVista;

    FDatasetPix: TDataset;

    function ChamaTelaDeCliente(ADatasetMovPix: TDataset): Boolean;
    function ChamaTelaDeValorDoPix: Boolean;

    function CriarCobrancaPixCC(ACodigoCliente: String;
                                AValorDoPix: Double): TDadosRetornoPixAVista;

    function RealizaGravacaoMovimentacaoBancariaCC(ADatasetCadRec,
                                                   ADatasetMovPix: TDataset): Boolean;

    function PedeDireitoAcessoAlterarClienteCC(ACodigoOperador,
                                               ACodigoCliente: String): Boolean;
  public
    class var FChaveLCKATC: String;

    constructor Create(ANomeFormulario: String); overload;
    destructor Destroy; override;

    function GerarPixParaCredito(prbStatus: TcxProgressBar): Boolean;

    procedure EnviarEmailSMSDeCreditoDeCliente(AReenvio: Boolean = False);

    function GerarCCPixPagoNaoConfirmado(ADatasetMovPix: TDataset): Boolean;

    procedure AtualizaRegistroPixCCGerado(ADatasetMovPix: TDataset);

    class procedure GravarMovimentacaoBancariaExclusaoCC(ADataset: TDataset);

    class function ValidarPixGeradoAtravesCredito(ADataset: TDataset): Boolean;

    property AutoIncremMovPix: String read FAutoIncremMovPix write FAutoIncremMovPix;
    property ClienteSelecionado: String read FClienteSelecionado write FClienteSelecionado;
  end;

implementation
Uses untFuncoesSimples, untTFuncoesAuxiliaresPix, untTIntegracaoPixCitel,
  untIIntegracaoPixCitel, untTPixDao, untRcxDigCliente, untFuncoes,
  untTFuncoesPixAutcom, untTBaixaReceberEmail, untGravando, untCadRec,
  untMovBan, untTBanCtrRepository, untTLogMpx, untLogCtr, untLiberacao;

{ TCreditoClientePixAutcom }

procedure TCreditoClientePixAutcom.AtualizaRegistroPixCCGerado(
  ADatasetMovPix: TDataset);
begin
  Try
    fExecutaSQL('UPDATE MOVPIX SET MPX_CHA_CC="' + FSequencialCCPago + '", ' +
                '      MPX_STATUS="' + LeftStr(ADatasetMovPix.FieldByName('MPX_STATUS').AsString,
                                               ADatasetMovPix.FieldByName('MPX_STATUS').AsString.Length - 2) + '", ' +
                '      MPX_DOCBAI="' + FSeqLanCCPago + '" ' +
                'WHERE AUTOINCREM="' + ADatasetMovPix.FieldByName('AUTOINCREM').AsString + '"',
                True);

    TLogMpx.GravaLogMpx(ADatasetMovPix.FieldByName('AUTOINCREM').AsString,
                        'CONFIRMAÇÃO CC PIX PAGO',
                        'frmRelacaoPixParaGerarCC');
  Except
    Raise;
  End;
end;

function TCreditoClientePixAutcom.ChamaTelaDeCliente(ADatasetMovPix: TDataset): Boolean;
  Var
    LfrmRcxDigCliente: TfrmRcxDigCliente;
begin
  Try
    pCriarFormularios(TfrmRcxDigCliente, LfrmRcxDigCliente);
    LfrmRcxDigCliente.strCodOpe := strLoginUsuarioLogado;
    LfrmRcxDigCliente.ExibeRelatorio := False;

    If ADatasetMovPix <> Nil Then
    Begin
      If ADatasetMovPix.FindField('LOG_CODCLI') <> Nil Then
        LfrmRcxDigCliente.edtCodCli.Text := ADatasetMovPix.FieldByName('LOG_CODCLI').AsString;

      FDatasetPix := ADatasetMovPix;
    End;

    LfrmRcxDigCliente.SetDireitoAcesso(PedeDireitoAcessoAlterarClienteCC);

    LfrmRcxDigCliente.ShowModal;

    Result := LfrmRcxDigCliente.blnConfirma;
    If Not Result Then
      Exit;

    Result := LfrmRcxDigCliente.strStatus = 'A';
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Não pode ser criado o crédito ao cliente selecionado, pois esse está inativo.', ['&Ok']);
      Exit;
    End;

    Result := Not fClienteConsumidor(fRetNomCliente(LfrmRcxDigCliente.edtCodCli.Text), True, True);
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'Não é permitido criar o crédito para cliente consumidor nessa rotina.', ['&Ok']);
      Exit;
    End;

    FClienteSelecionado := LfrmRcxDigCliente.edtCodCli.Text;
  Finally
    FreeAndNil(LfrmRcxDigCliente);
  End;
end;

function TCreditoClientePixAutcom.ChamaTelaDeValorDoPix: Boolean;
begin
  fDigitaValor(FValorDoPix, 'Valor do Pix');

  Result := FValorDoPix > 0;
  If Not Result Then
    fMensagem('ATENÇÃO', 'O valor do Pix deve ser maior que zero.', ['&Ok']);
end;

constructor TCreditoClientePixAutcom.Create(ANomeFormulario: String);
begin
  FClienteSelecionado := '';
  FValorDoPix := 0.00;

  FNomeFormulario := ANomeFormulario;

  FAmbienteHomologacao := fCfgSis('HOMPIX', varString);
end;

function TCreditoClientePixAutcom.CriarCobrancaPixCC(ACodigoCliente: String;
  AValorDoPix: Double): TDadosRetornoPixAVista;
  Var
    LRequisicaoPix: IRequisicoesPix;

    LDadosRequisicao: TDadosRequisicaoPixAVista;

    LDadosResposta: TDadosRetornoPixAVista;

    LPixDao: TPixDao;

    LErro,
    LRequsicaoJson,
    LRetornoJson,
    LAutoIncremChavePix: String;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  LAutoIncremChavePix := fCfgSis('CHAPIX');

  Result := TDadosRetornoPixAVista.Create;

  LDadosRequisicao := Nil;
  LDadosResposta := Nil;
  LPixDao := Nil;
  Try
    TFuncoesPixAutcom.CarregaLibIntegracaoPixCitel;

    CriaObjetoRequisicoesPix  := GetProcAddress(TFuncoesPixAutcom.FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicaoPix := CriaObjetoRequisicoesPix(LAutoIncremChavePix);

    LDadosRequisicao := TFuncoesPixAutcom.RetornaDadosRequisicaoCreditoCliente(AValorDoPix,
                                                                               ACodigoCliente);

    LDadosRequisicao.ChavePix := LRequisicaoPix.GetChavePix;

    Try
      LDadosRequisicao.TextoItemShipay := LDadosRequisicao.SolicitacaoPagador;
      LDadosRequisicao.UtilizaShipay := TPixDao.ChavePixUtilizaShipay(LAutoIncremChavePix);
      LDadosRequisicao.UtilizaTefScope := TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix);
      LDadosRequisicao.TipoCobranca := 'variavel';

      LRequsicaoJson := TFuncoesPix.RetornaJsonDadosRequisicao(LDadosRequisicao);

      LRetornoJson := LRequisicaoPix.CriarCobranca(LRequsicaoJSON);

      LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoJson);
      If Not LErro.IsEmpty Then
        Raise Exception.Create(LErro);

      LDadosResposta := TFuncoesPix.RetornaDadosDoRetornoPixAVista(LRequsicaoJson,
                                                                   LRetornoJson,
                                                                   LAutoIncremChavePix,
                                                                   LDadosRequisicao.UtilizaShipay = 'S',
                                                                   LDadosRequisicao.UtilizaTefScope = 'S');

      LDadosResposta.CriadoPelo := 'FINANCEIRO';
      LDadosResposta.Status := LDadosResposta.Status.Replace('ATIVA', 'ATIVACC')
                                                    .Replace('pendingv', 'pendingvCC');

      If LDadosResposta.UtilizaShipay = 'S' Then
      Begin
        LDadosResposta.JsonRequisicao := LRequisicaoPix.GetRequisicaoPixAtualizadaShipay;
        LDadosResposta.OrderRef := TFuncoesPix.RetornaOrderRefShipay(LDadosResposta.JsonRequisicao);
        LDadosResposta.SolicitacaoPagador := LDadosRequisicao.SolicitacaoPagador;
      End;

      LDadosResposta.ChaveParaCreditoCliente := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec) +
                                                '-CC-' + VS_strCodEmp + '-' + ACodigoCliente + '-' + strLoginUsuarioLogado;

      LPixDao := TPixDao.Create;

      LDadosResposta.AutoIncremMovPix := fRetAutoIncrem('MOVPIX', VS_strCodEmp);
      FAutoIncremMovPix := LDadosResposta.AutoIncremMovPix;

      fStartTransaction;

      If LPixDao.InserirCobrancaPixAVista(LDadosResposta, FNomeFormulario) Then
        Result := LDadosResposta;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If LDadosRequisicao <> Nil Then
      FreeAndNil(LDadosRequisicao);

    If LDadosResposta <> Nil Then
      FreeAndNil(LDadosResposta);

    TFuncoesPixAutcom.LiberaObjetosIntegracaoPix(LRequisicaoPix);

    If Assigned(LPixDao) Then
      FreeAndNil(LPixDao);

    If Not LErro.IsEmpty Then
      Raise Exception.Create('Ocorreu um erro ao gerar o Pix da Venda.' + #13 +
                             LErro);
  End;
end;

destructor TCreditoClientePixAutcom.Destroy;
begin

  inherited;
end;

procedure TCreditoClientePixAutcom.EnviarEmailSMSDeCreditoDeCliente(AReenvio: Boolean = False);
  Var
    LDatasetPix,
    LDataset: TUniClientDataSet;

    LBaixaReceberEmail: TBaixaReceberEmail;

    LDadosEmail: TDadosDisparaEmail;

    LEnviarEmail,
    LEnviarSMS,
    LEnviarWhatsapp: Boolean;

    LEmailCliente,
    LCelularCliente: String;

    LGravando: TfrmGravando;
begin
  Try
    Try
      LDatasetPix := TPixDao.RetornaDadosDoPix(FAutoIncremMovPix);

      LDataset := untCadRec.RetornaDuplicatasDosPixJaGerado(LDatasetPix.FieldByName('MPX_TX_ID_').AsString,
                                                            LDatasetPix.FieldByName('MPX_CODEMP').AsString);

      LEmailCliente := fCampoTabela(untCadRec.RetornaSQLEmailCliente.Replace('C.', EmptyStr),
                                    'CADCLI',
                                    ['CLI_CODCLI'],
                                    [FClienteSelecionado]);

      LCelularCliente := fCampoTabela('CLI_CELULA',
                                      'CADCLI',
                                      ['CLI_CODCLI'],
                                      [FClienteSelecionado]);

      LEnviarEmail := TBaixaReceberEmail.DeveEnviarEmail('PX',
                                                         staPixParaCreditoCliente,
                                                         LEmailCliente);
      LEnviarSMS := TBaixaReceberEmail.DeveEnviarSms('PX',
                                                     staPixParaCreditoCliente,
                                                     LCelularCliente);
      LEnviarWhatsapp := TBaixaReceberEmail.DeveEnviarWhatsapp('PX',
                                                           staPixParaCreditoCliente,
                                                           LCelularCliente);

      If Not TBaixaReceberEmail.PossuiAlgumModeloAEnviarPix(LEnviarEmail, LEnviarSMS, LEnviarWhatsapp) Then
      Begin
         If AReenvio Then
           fMensagem('ATENÇÃO', 'Não existe modelo de e-mail/sms/whatsapp ou dados do cliente faltando para o envio do Pix!', ['&Ok']);

        Exit;
      End;

      LDadosEmail.strCodCli := FClienteSelecionado;
      LDadosEmail.strEmaCob := LEmailCliente;
      LDadosEmail.QRCodePix := LDatasetPix.FieldByName('MPX_QRCODE').AsString;
      LDadosEmail.LinkCitelPix := TFuncoesPix.RetornaLinkCitel(LDatasetPix.FieldByName('MPX_LNKCIT').AsString, FAmbienteHomologacao);
      LDadosEmail.strValDup := FormatFloat(',0.00', LDatasetPix.FieldByName('MPX_VALPIX').AsFloat);

      LBaixaReceberEmail := TBaixaReceberEmail.Create(LDadosEmail,
                                                      LDataset,
                                                      staPixParaCreditoCliente);

      If LEnviarEmail Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LBaixaReceberEmail.EnviarEmailBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Enviando o e-mail do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      If LEnviarSMS Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LBaixaReceberEmail.EnviarSMSBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Enviando o SMS do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      If LEnviarWhatsapp Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        LGravando.fExecutarAcao := LBaixaReceberEmail.EnviarWhatsappBaixaReceberPix;
        LGravando.lblGravando.Caption := 'Aguarde... Enviando o Whatsapp do Pix ao cliente.';
        LGravando.pgbStatus.Visible := False;
        LGravando.ShowModal;
      End;

      If AReenvio Then
        fMensagem('AVISO', 'O reenvio da cobrança Pix ao cliente foi realizado com sucesso!', ['&Ok']);
    Finally
      FreeAndNil(LDataset);
      FreeAndNil(LDatasetPix);

      If Assigned(LBaixaReceberEmail) Then
        FreeAndNil(LBaixaReceberEmail);
    End;
  Except
    On E: Exception Do
      pMensagensErro('Ocorreu um erro ao reenviar e-mail/sms do Pix ao cliente.' + #13 +
                     'Erro gerado: ' + E.Message, '[TCreditoClientePixAutcom.EnviarEmailSMSDeCreditoDeCliente]');
  End;
end;

function TCreditoClientePixAutcom.GerarCCPixPagoNaoConfirmado(
  ADatasetMovPix: TDataset): Boolean;
  Var
    LNovaDuplicata: TUniQuery;

    LPortadorDuplicata,
    LCentroDeCustosDuplicata: String;
begin
  Result := ChamaTelaDeCliente(ADatasetMovPix);

  If Not Result Then
    Exit;

  FSequencialCCPago := fRetSequencial('PROCCO', ADatasetMovPix.FieldByName('MPX_CODEMP').AsString, fTamDocCadRec) +
                                      '-CC-' + ADatasetMovPix.FieldByName('MPX_CODEMP').AsString + '-' +
                                      FClienteSelecionado + '-' +
                                      ADatasetMovPix.FieldByName('MPX_CODOPE').AsString;

  fStartTransaction;

  Try
    LNovaDuplicata := fCriaQuery;

    {*****************************************}
    {* GRAVA NOVA DUPLICATA                  *}
    {**************************************MV*}
    LNovaDuplicata.SQL.Text := 'SELECT * FROM CADREC WHERE FALSE';

    LNovaDuplicata.Open;
    LNovaDuplicata.Append;

    LNovaDuplicata.FieldByName('CTR_CODVEN').AsString := ADatasetMovPix.FieldByName('MPX_CODOPE').AsString;
    LNovaDuplicata.FieldByName('CTR_CODDIG').AsString := ADatasetMovPix.FieldByName('MPX_CODOPE').AsString;

    LNovaDuplicata.FieldByName('CTR_CODCLI').AsString := FClienteSelecionado;
    LNovaDuplicata.FieldByName('CTR_NUMDUP').AsString := Copy(FSequencialCCPago, 01, 12);
    LNovaDuplicata.FieldByName('CTR_CODEMP').AsString := ADatasetMovPix.FieldByName('MPX_CODEMP').AsString;
    LNovaDuplicata.FieldByName('CTR_PARCEL').AsString := 'A';
    LNovaDuplicata.FieldByName('CTR_SEQBAI').AsInteger := 0;
    LNovaDuplicata.FieldByName('CTR_ESPDOC').AsString := 'CC';
    LNovaDuplicata.FieldByName('CTR_DTACAD').AsDateTime := ADatasetMovPix.FieldByName('MPX_DTAREC').AsDateTime;
    LNovaDuplicata.FieldByName('CTR_DTAVEN').AsDateTime := ADatasetMovPix.FieldByName('MPX_DTAREC').AsDateTime;
    LNovaDuplicata.FieldByName('CTR_VALDUP').AsFloat := fFormataFloat(ADatasetMovPix.FieldByName('MPX_VALREC').AsFloat * (-1), 2);
    LNovaDuplicata.FieldByName('CTR_VALORI').AsFloat := fFormataFloat(ADatasetMovPix.FieldByName('MPX_VALREC').AsFloat * (-1), 2);
    LNovaDuplicata.FieldByName('CTR_DESCON').AsString := 'N';
    LNovaDuplicata.FieldByName('CTR_VALCOM').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_FATCOM').AsFloat := 0.00000000;

    LPortadorDuplicata := fCampoTabela('SIS_VALCFG',
                                       'CFGSIS',
                                       ['SIS_CODCFG', 'SIS_CODEMP'],
                                       ['CFG_PORCCP', ADatasetMovPix.FieldByName('MPX_CODEMP').AsString]);

    LCentroDeCustosDuplicata := fCampoTabela('SIS_VALCFG',
                                             'CFGSIS',
                                             ['SIS_CODCFG', 'SIS_CODEMP'],
                                             ['CFG_EVECCP', ADatasetMovPix.FieldByName('MPX_CODEMP').AsString]);

    LNovaDuplicata.FieldByName('CTR_CODPOR').Value := Null;
    If Not LPortadorDuplicata.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_CODPOR').AsString := LPortadorDuplicata;

    LNovaDuplicata.FieldByName('CTR_CODEVE').Value := Null;
    If Not LCentroDeCustosDuplicata.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_CODEVE').AsString := LCentroDeCustosDuplicata;

    LNovaDuplicata.FieldByName('CTR_EMP_PD').AsString := fRetEmpresaOperador(LNovaDuplicata.FieldByName('CTR_CODVEN').AsString);
    If LNovaDuplicata.FieldByName('CTR_EMP_PD').AsString.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_EMP_PD').AsString := LNovaDuplicata.FieldByName('CTR_CODEMP').AsString;

    LNovaDuplicata.FieldByName('CTR_HIST01').AsString := 'REF. LANC. CREDITO CONFIRMADO POR PIX';
    LNovaDuplicata.FieldByName('CTR_HIST02').AsString := '';

    LNovaDuplicata.FieldByName('CTR_RESCAI').AsInteger  := 0;

    LNovaDuplicata.FieldByName('CTR_DIFORI').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALREC').AsFloat := 0.00;

    LNovaDuplicata.FieldByName('CTR_NOSNUM').Value := Null;

    LNovaDuplicata.FieldByName('CTR_DTASER').Value := Null;
    LNovaDuplicata.FieldByName('CTR_DTABOL').Value := Null;
    LNovaDuplicata.FieldByName('CTR_BCOBOL').Value := Null;
    LNovaDuplicata.FieldByName('CTR_BCOENV').Value := Null;
    LNovaDuplicata.FieldByName('CTR_DTAENV').Value := Null;

    LNovaDuplicata.FieldByName('CTR_RECAUT').AsString := 'N';

    LNovaDuplicata.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADREC', LNovaDuplicata.FieldByName('CTR_CODEMP').AsString);

    LNovaDuplicata.FieldByName('CTR_ADTCLI').AsString := 'N';
    LNovaDuplicata.FieldByName('CTR_RECFIN').AsString := 'N';

    LNovaDuplicata.FieldByName('CTR_VALIPI').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALRET').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALCBS').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALIBS').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VAL_IS').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALACE').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALFRE').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALFCP').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALANT').AsFloat := 0.00;

    LNovaDuplicata.FieldByName('CTR_GRVORI').AsFloat := fFormataFloat(ADatasetMovPix.FieldByName('MPX_VALREC').AsFloat * (-1), 2);

    LNovaDuplicata.FieldByName('CTR_JURSUJ').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_JURANT').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_PERMOR').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_PERMUL').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_DESSUJ').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_DESANT').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_DESCOB').AsFloat := 0;

    LNovaDuplicata.FieldByName('CTR_EMPORI').AsString := LNovaDuplicata.FieldByName('CTR_CODEMP').AsString;

    If LNovaDuplicata.FindField('CTR_SEQMPX') <> Nil Then
      LNovaDuplicata.FieldByName('CTR_SEQMPX').AsString := ADatasetMovPix.FieldByName('AUTOINCREM').AsString;

    LNovaDuplicata.Post;

    untLogCtr.GravaLogCtr(LNovaDuplicata.FieldByName('AUTOINCREM').AsString,
                          'INCLUSÃO',
                          'TCreditoClientePixAutcom.GerarCCPixPagoNaoConfirmado',
                          strLoginUsuarioLogado,
                          ADatasetMovPix.FieldByName('MPX_SEQCON').AsInteger,
                          0,
                          '',
                          'S');

    RealizaGravacaoMovimentacaoBancariaCC(LNovaDuplicata,
                                          ADatasetMovPix);

    FreeAndNil(LNovaDuplicata);
  Except
    Raise;
  End;
end;

function TCreditoClientePixAutcom.GerarPixParaCredito(
  prbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    If Not ChamaTelaDeCliente(Nil) Then
      Exit(False);

    If Not ChamaTelaDeValorDoPix Then
      Exit(False);

    If fMensagem('ATENÇÃO', 'Confirma a geração do Pix de ' + FormatFloat(',0.00', FValorDoPix) +
                            ' referente a criação de crédito ao cliente?',
                            ['&Sim', '&Não']) = 2 Then
      Exit(False);


    FDadosRetornoPix := CriarCobrancaPixCC(FClienteSelecionado,
                                           FValorDoPix);
  Except
    On E: Exception Do
    Begin
      Result := False;
      fMensagem('ATENÇÃO', E.Message, ['&Ok']);
    End;
  End;
end;

class procedure TCreditoClientePixAutcom.GravarMovimentacaoBancariaExclusaoCC(
  ADataset: TDataset);
  Var
    LTipoLancamento: String;

    LListaBanCtr: TBanCtrRepository;

    LDataLancamento: TDateTime;

    LDatasetCadRec,
    LDatasetMovPix: TUniQuery;
begin
  Try
    LListaBanCtr := TBanCtrRepository.Create;

    LDataLancamento := VS_Date;
    
    LDatasetCadRec := fCriaQuery;
    LDatasetCadRec.SQL.Text := 'SELECT * ' +
                               'FROM CADREC ' +
                               'WHERE CTR_SEQMPX="' + ADataset.FieldByName('CTR_SEQMPX').AsString + '" ' +
                               '  AND CTR_SEQBAI=0';
    LDatasetCadRec.Open;

    LDatasetMovPix := fCriaQuery;
    LDatasetMovPix.SQL.Text := 'SELECT * ' +
                               'FROM MOVPIX ' +
                               'WHERE MPX_CODEMP="' + ADataset.FieldByName('MPX_CODEMP').AsString + '" ' +
                               '  AND MPX_TX_ID_="' + ADataset.FieldByName('MPX_TX_ID_').AsString + '"';
    LDatasetMovPix.Open;

    LListaBanCtr.fAdd(LDatasetCadRec.FieldByName('CTR_NUMDUP').AsString,
                      LDatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                      LDatasetCadRec.FieldByName('CTR_ESPDOC').AsString,
                      LDatasetCadRec.FieldByName('CTR_CODEMP').AsString,
                      LDatasetCadRec.FieldByName('CTR_CODCLI').AsString,
                      LDatasetCadRec.FieldByName('CTR_HIST01').AsString,
                      LDatasetCadRec.FieldByName('CTR_HIST02').AsString,
                      LDatasetCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                      0.00,
                      0.00,
                      0.00,
                      LDatasetCadRec.FieldByName('CTR_VALDUP').AsFloat);

    LTipoLancamento := 'D';

    fGravaMovBan(LDatasetMovPix.FieldByName('MPX_CTABAI').AsString,
                 LDatasetMovPix.FieldByName('MPX_PORBAI').AsString,
                 strLoginUsuarioLogado,
                 LDataLancamento,
                 fRetHoraServidor,
                 LDatasetCadRec.FieldByName('CTR_NUMDUP').AsString + LDatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                 LTipoLancamento,
                 LDatasetMovPix.FieldByName('MPX_CODEMP').AsString,
                 LDatasetMovPix.FieldByName('MPX_VALREC').AsFloat,
                 'EXCLUSÃO CRÉDITO DE CLIENTE RECEBIDO POR PIX',
                 '',
                 LDatasetCadRec.FieldByName('CTR_CODCLI').AsString,
                 '',
                 LDatasetCadRec.FieldByName('CTR_NUMDUP').AsString,
                 0,
                 LDatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                 LDatasetCadRec.FieldByName('CTR_CODEMP').AsString,
                 '',
                 LDatasetCadRec.FieldByName('CTR_CODEVE').AsString,
                 '',
                 LListaBanCtr.fGetList
                 );

    FreeAndNil(LDatasetCadRec);
    FreeAndNil(LDatasetMovPix);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a movimentação bancária do Pix.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TCreditoClientePixAutcom.PedeDireitoAcessoAlterarClienteCC(
  ACodigoOperador, ACodigoCliente: String): Boolean;
  Var
    LObjetoLiberacao: TLiberacao;
begin
  If FDatasetPix = Nil Then
    Exit(True);

  Result := fVerificaAcessoSistema('PERALTCLICREDPIX', ACodigoOperador);

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui direito de acesso para alterar o cliente do Pix recebido e não confirmado.', ['&Ok']);
    Exit;
  End;

  LObjetoLiberacao := TLiberacao.Create;

  Try
    LObjetoLiberacao.Clear;

    LObjetoLiberacao.strDirAce := 'PERALTCLICREDPIX';
    LObjetoLiberacao.strMsgSen := 'Permitir alterar o cliente ao gerar o crédito do Pix recebido sem confirmação';

    LObjetoLiberacao.objMsgLibera.pAddTexto('Permitir alterar o cliente ao gerar o crédito do Pix recebido sem confirmação');
    LObjetoLiberacao.objMsgLibera.pAddTexto(EmptyStr);
    LObjetoLiberacao.objMsgLibera.pAddTexto('Cliente anterior: ' +  FDatasetPix.FieldByName('LOG_CODCLI').AsString + '-' + fRetNomCliente(FDatasetPix.FieldByName('LOG_CODCLI').AsString));
    LObjetoLiberacao.objMsgLibera.pAddTexto('Novo cliente: ' + ACodigoCliente + '-' + fRetNomCliente(ACodigoCliente));
    LObjetoLiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + FormatFloat(',0.00', FDatasetPix.FieldByName('MPX_VALREC').AsFloat));

    LObjetoLiberacao.strCodOpe := ACodigoOperador;
    LObjetoLiberacao.strCodDig := ACodigoOperador;

    Result := LObjetoLiberacao.fLibera;
  Finally
    FreeAndNil(LObjetoLiberacao);
  End;
end;

function TCreditoClientePixAutcom.RealizaGravacaoMovimentacaoBancariaCC(
  ADatasetCadRec, ADatasetMovPix: TDataset): Boolean;
  Var
    LSeqLan,
    LTipoLancamento: String;

    LListaBanCtr: TBanCtrRepository;

    LDataLancamento: TDateTime;
begin
  Try
    LListaBanCtr := TBanCtrRepository.Create;

    LDataLancamento := ADatasetMovPix.FieldByName('MPX_DTAREC').AsDateTime;
    If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [ADatasetMovPix.FieldByName('MPX_PORBAI').AsString]) = 'S' Then
      LDataLancamento := fAcertaDataParaDiaUtil(ADatasetMovPix.FieldByName('MPX_DTAREC').AsDateTime);

    LListaBanCtr.fAdd(ADatasetCadRec.FieldByName('CTR_NUMDUP').AsString,
                      ADatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                      ADatasetCadRec.FieldByName('CTR_ESPDOC').AsString,
                      ADatasetCadRec.FieldByName('CTR_CODEMP').AsString,
                      ADatasetCadRec.FieldByName('CTR_CODCLI').AsString,
                      ADatasetCadRec.FieldByName('CTR_HIST01').AsString,
                      ADatasetCadRec.FieldByName('CTR_HIST02').AsString,
                      ADatasetCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                      0.00,
                      0.00,
                      0.00,
                      ADatasetCadRec.FieldByName('CTR_VALDUP').AsFloat);

    LTipoLancamento := 'C';

    LSeqLan := fGravaMovBan(ADatasetMovPix.FieldByName('MPX_CTABAI').AsString,
                            ADatasetMovPix.FieldByName('MPX_PORBAI').AsString,
                            strLoginUsuarioLogado,
                            LDataLancamento,
                            fRetHoraServidor,
                            ADatasetCadRec.FieldByName('CTR_NUMDUP').AsString + ADatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                            LTipoLancamento,
                            ADatasetMovPix.FieldByName('MPX_CODEMP').AsString,
                            ADatasetMovPix.FieldByName('MPX_VALREC').AsFloat,
                            'CONFIRMAÇÃO DE CREDITO DE CLIENTE RECEBIDO POR PIX',
                            '',
                            ADatasetCadRec.FieldByName('CTR_CODCLI').AsString,
                            '',
                            ADatasetCadRec.FieldByName('CTR_NUMDUP').AsString,
                            0,
                            ADatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                            ADatasetCadRec.FieldByName('CTR_CODEMP').AsString,
                            '',
                            ADatasetCadRec.FieldByName('CTR_CODEVE').AsString,
                            '',
                            LListaBanCtr.fGetList
                            );

    pAtualizarSequencialMovBanInclusaoCredito(ADatasetCadRec.FieldByName('AUTOINCREM').AsString, LSeqLan);

    Result := Not LSeqLan.IsEmpty;

    FSeqLanCCPago := LSeqLan;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a movimentação bancária do Pix.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class function TCreditoClientePixAutcom.ValidarPixGeradoAtravesCredito(
  ADataset: TDataset): Boolean;
begin
  FChaveLCKATC := EmptyStr;

  If ADataset.FieldByName('MPX_STATUS').AsString = 'ATIVA' Then
    Exit(True);

  Result := Not fEmptyStr(fCampoTabela('AUTOINCREM',
                                       'CADREC',
                                       ['CTR_SEQMPX', 'CTR_SEQBAI'],
                                       [ADataset.FieldByName('AUTOINCREM').AsString, 0]));

  If Not Result Then
  Begin
    Result := fEmptyStr(fCampoTabela('AUTOINCREM',
                                     'DUPAGR',
                                     ['CTR_SEQMPX'],
                                     [ADataset.FieldByName('AUTOINCREM').AsString]));

    If Not Result Then
      fMensagem('ATENÇÃO', 'O Pix não pode ser removido pois o crédito gerado foi agrupado.', ['&Ok'])
    Else
      Result := fMensagem('ATENÇÃO', 'A Duplicata desse Pix não foi encontrada. Deseja remover o Pix mesmo assim?', ['&Sim', '&Não'], 2) = 1;

    Exit;
  End;

  Result := Not untCadRec.fDuplicataCtrBaixada(LeftStr(ADataset.FieldByName('MPX_CHA_CC').AsString, 12),
                                               'A',
                                               'CC',
                                               Copy(ADataset.FieldByName('MPX_CHA_CC').AsString, 17, 3),
                                               Copy(ADataset.FieldByName('MPX_CHA_CC').AsString, 21, 8),
                                               0);

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'O Pix não pode ser removido pois o crédito gerado foi baixado.', ['&Ok']);
    Exit;
  End;

  Result := fRetSeqBaiCadRec(LeftStr(ADataset.FieldByName('MPX_CHA_CC').AsString, 12),
                             'A',
                             Copy(ADataset.FieldByName('MPX_CHA_CC').AsString, 17, 3),
                             'CC',
                             Copy(ADataset.FieldByName('MPX_CHA_CC').AsString, 21, 8)) = 0;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'O Pix não pode ser removido pois o crédito gerado possui baixa parcial.', ['&Ok']);
    Exit;
  End;

  fMensagem('ATENÇÃO', 'Ao remover o Pix, o crédito gerado também será removido.', ['&Ok']);

  FChaveLCKATC := 'CADREC' +
                  LeftStr(ADataset.FieldByName('FGO_NUMDOC').AsString, 12) +
                  ADataset.FieldByName('FGO_ESPDOC').AsString +
                  ADataset.FieldByName('FGO_CODEMP').AsString +
                  ADataset.FieldByName('FGO_CODCLI').AsString + 'A';
end;

end.
