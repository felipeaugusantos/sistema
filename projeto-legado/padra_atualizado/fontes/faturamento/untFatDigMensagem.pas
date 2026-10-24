{***************************}
{* qryConTra -> CADTRA     *}
{************************JB*}

unit untFatDigMensagem;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls,  untFuncFat, Uni, AppEvnts, Mask, untFuncFatTypes,
  BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade,
  untDadosFechamentoPedidoFrame, untDadosFechamentoPedidoObservacoesFrame,
  untDadosFechamentoPedidoTransportadoraFrame,
  untDescontoFinanceiroBoletoAdiantamentoFrame, untFatorParaFaturamentoFrame,
  untLiberacaoPedidoFrame, untDadosFechamentoPedidoInvoiceFrame,
  untNumeroDrawbackFrame, EditFocus, untClienteContaOrdemFrame;

type
  TfrmFatDigMensagem = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    fraDadosPedido: TfraDadosFechamentoPedidoFrame;
    fraObservacoes: TfraDadosFechamentoPedidoObservacoesFrame;
    fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame;
    fraDescFinanBoletoAdto: TfraDescontoFinanceiroBoletoAdiantamentoFrame;
    fraFatorParaFaturamento: TfraFatorParaFaturamentoFrame;
    fraLiberacaoPedido: TfraLiberacaoPedidoFrame;
    fraInvoice: TfraDadosFechamentoPedidoInvoiceFrame;
    fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame;
    fraClienteContaOrdemFrame: TfraClienteContaOrdemFrame;
    btnConfirmaDados: TBitBtnLocked;
    btnMostraMargem: TBitBtnLocked;
    btnSimularVenda: TBitBtnLocked;
    btnEspRascNF: TBitBtnLocked;
    btnTotalizadorEmp: TBitBtnLocked;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSimularVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fraDescFinanBoletoAdtochkBolVenClick(Sender: TObject);
    procedure fraTransportadorabtnCalcularFreteClick(Sender: TObject);
    procedure fraTransportadoraedtCodRotKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraDadosPedidoedtTipOpeExit(Sender: TObject);
    procedure btnEspRascNFClick(Sender: TObject);
    procedure btnTotalizadorEmpClick(Sender: TObject);
  private
    { Private declarations }
    intSemaforo: Integer;
    FInfUltimoCalculoTotal: TRecInfUltimoCalculoTotal;

    FblnUltimaEscolhaFretePelaFrenet : Boolean;
    FstrCodTraFreFat                 : String;
    FfltValorFretePelaFrenet         : Double;
    FstrTipoFreteSelecionado         : String;
    FblnEspRascDANFE                 : Boolean;

    procedure pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);
    function fPermitirAlterarFreteFrenet : Boolean;
    procedure pConfirmDados;
    function fValidaFrenet():Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fatVenda: TFatVenda;
    qryFatGor: TUniQuery;
    blnConfirma: Boolean;
    blnJaChamouOnShow : Boolean;
  end;


implementation

uses untPesqAux, Data.DB, untTypesSistema,
     untfuncoesSimples, untConstantes, untGerarEspelhoRascunhoDANFE,
     untFatMostraItensFechamento, untFuncoes, untFrenetConsulta, untLiberacao,
     untFatTotalizadorEmpresa, untEndPartidaConsFrete, LalaMove.View.Consulta;

{$R *.dfm}

procedure TfrmFatDigMensagem.FormCreate(Sender: TObject);
begin
  inherited;
  intSemaforo := -1;
  blnConfirma := False;
  fraObservacoes.OnFormCreate;
  fraTransportadora.OnFormCreate;
  fraDadosPedido.OnFormCreate;
  fraDescFinanBoletoAdto.OnFormCreate;
  fraFatorParaFaturamento.OnFormCreate;
  fraLiberacaoPedido.OnFormCreate;
  fraNumeroDrawbackFrame.OnFormCreate;
  fraClienteContaOrdemFrame.OnFormCreate;
  blnJaChamouOnShow := False;
end;

procedure TfrmFatDigMensagem.FormDestroy(Sender: TObject);
begin
  inherited;
  fraObservacoes.OnFormDestroy;
  fraTransportadora.OnFormDestroy;
  fraDadosPedido.OnFormDestroy;
  fraDescFinanBoletoAdto.OnFormDestroy;
  fraFatorParaFaturamento.OnFormDestroy;
  fraLiberacaoPedido.OnFormDestroy;
  fraNumeroDrawbackFrame.OnFormDestroy;
  fraClienteContaOrdemFrame.OnFormDestroy;
end;

procedure TfrmFatDigMensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F4: btnMostraMargem.Click;
    VK_F5: btnSimularVenda.Click;
    VK_F6: btnTotalizadorEmp.Click;
    VK_F10: btnConfirmaDados.Click;
  End;
end;

function TfrmFatDigMensagem.fPermitirAlterarFreteFrenet: Boolean;
  var
    objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.create;

  Try
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'PERALTFRETEFRENET';
    objLiberacao.strMsgSen    := 'Alterar Frete da Frenet/QualP/DataFrete/Intelipost';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Permitir alterar o frete para um valor menor que o escolhido pela Frenet/QualP/DataFrete (frete pela Frenet/QualpP/DataFrete/Intelipost R$ '+
    FloatToStr(fFormataFloat(FfltValorFretePelaFrenet,2))+').');

    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + fatVenda.strCodCli + ' - ' + fRetNomCliente(fatVenda.strCodCli));
    objLiberacao.objMsgLibera.pAddTexto('Documento: ' + fatVenda.strNumOrc + ' - ' + fatVenda.strEspDoc);

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmFatDigMensagem.fraDadosPedidoedtTipOpeExit(Sender: TObject);
begin
  inherited;
  fraDadosPedido.edtTipOpeExit(Sender);

  If (fraDadosPedido.edtTipOpe.Text = 'C') And
     (fCfgSis('EXICOR', varBoolean)) And
     (fCfgSis('PCOORD', varBoolean)) Then
  Begin
    fraClienteContaOrdemFrame.Visible := True;
    Self.ClientHeight := Self.ClientHeight +
                         fRetornaSomaAlturaDosPaineisVisiveisEm(fraClienteContaOrdemFrame.pnlFundo);
  End
  Else
  Begin

    fatVenda.strCliCEO := '';
    If (fraClienteContaOrdemFrame.Visible) Then
    Begin
      Self.ClientHeight := Self.ClientHeight -
                           fRetornaSomaAlturaDosPaineisVisiveisEm(fraClienteContaOrdemFrame.pnlFundo);

      fraClienteContaOrdemFrame.Visible := False;
    End;

  End;
end;

procedure TfrmFatDigMensagem.fraDescFinanBoletoAdtochkBolVenClick(
  Sender: TObject);
begin
  inherited;
  fraDescFinanBoletoAdto.chkBolVenClick(Sender);
  fraDadosPedido.blnEmitirBoletosAdiantamento := fraDescFinanBoletoAdto.chkBolVen.Checked;
end;

procedure TfrmFatDigMensagem.fraTransportadorabtnCalcularFreteClick(
  Sender: TObject);
  var
    frmFrenetConsulta : TfrmFrenetConsulta;
    frmLalaMoveConsulta : TfrmLalaMoveConsulta;
    LintIdx           : Integer;
    LEndPartida       : TRecEnderecoPartida;
begin
  If (fCfgSis('USALAL', varString) = 'S') Then
  Begin
    pCriarFormularios(TfrmLalaMoveConsulta, frmLalaMoveConsulta);
    Try
      frmLalaMoveConsulta.FatVenda := fatVenda;
      frmLalaMoveConsulta.ShowModal;
      If (frmLalaMoveConsulta.blnConfirmou) Then
      Begin
        FstrCodTraFreFat := fraTransportadora.edtCodTra.Text;
        fValidaCampos(fraTransportadora.edtCodTra);
        FblnUltimaEscolhaFretePelaFrenet := True;
        FfltValorFretePelaFrenet := frmLalaMoveConsulta.fltValorDoFrete;
        fraTransportadora.edtValFre.Text := FloatToStr(frmLalaMoveConsulta.fltValorDoFrete);
        fraTransportadora.cmbTipFre.ItemIndex := 0;
        SelectNext(ActiveControl, True, True);
      End
      Else
        FblnUltimaEscolhaFretePelaFrenet := (Not fEmptyStr(fatVenda.strQuotationIDLalaMove));
      FstrTipoFreteSelecionado := fatVenda.strFreTipApi;
    Finally
      pFreeAndNil(frmLalaMoveConsulta);
    End;
    Exit;
  End;

  Try
    FillChar(LEndPartida, SizeOf(LEndPartida), #0);

    pCriarFormularios(TfrmFrenetConsulta, frmFrenetConsulta);
    frmFrenetConsulta.fatVenda  := fatVenda;
    frmFrenetConsulta.strCodRot := fraTransportadora.edtCodRot.Text;

    If fCfgSis('ENPAFR', varBoolean) Then
    Begin
      If Not fSelecionaEnderecoPartida(LEndPartida) Then
        Exit;

      frmFrenetConsulta.recEndPartida := LEndPartida;
    End;

    frmFrenetConsulta.ShowModal;

    if frmFrenetConsulta.ModalResult = mrOK then
    Begin
      fraTransportadora.edtCodTra.Text := frmFrenetConsulta.strCodigoTransportadora;
      FstrCodTraFreFat := frmFrenetConsulta.strCodigoTransportadora;
      fValidaCampos(fraTransportadora.edtCodTra);

      FblnUltimaEscolhaFretePelaFrenet := True;
      FfltValorFretePelaFrenet         := frmFrenetConsulta.fltValorDoFrete;
      fraTransportadora.edtValFre.Text := FloatToStr(frmFrenetConsulta.fltValorDoFrete);

      for LintIdx := 1 to 5 do
      Begin
        if Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx)) <> Nil Then
          if (fEmptyStr(TEditFocus(Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx))).Text)) or
             (POS('DIAS APÓS A LIBERAÇÃO DO PEDIDO', TEditFocus(Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx))).Text) > 0) then
          Begin
            TEditFocus(Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx))).Text := frmFrenetConsulta.strMensagemDoFrete;
            Break;
          End;
      End;

      fatVenda.strAutIncEndPartida := LEndPartida.strAutoincrem;

      fraTransportadora.cmbTipFre.ItemIndex := 0;
      SelectNext(ActiveControl, True, True);
    End;

    FstrTipoFreteSelecionado := fatvenda.strFreTipApi;
  Finally
    pFreeAndNil(frmFrenetConsulta);
  End;
end;

procedure TfrmFatDigMensagem.fraTransportadoraedtCodRotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraTransportadora.edtCodRotKeyPress(Sender, Key);

end;

function TfrmFatDigMensagem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Result := fraObservacoes.fValidaCampos(Sender, blnBuscaPorChave) And
              fraTransportadora.fValidaCampos(Sender, blnBuscaPorChave) And
              fraDadosPedido.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And fraDescFinanBoletoAdto.Visible Then
    Result := fraDescFinanBoletoAdto.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And fraFatorParaFaturamento.Visible Then
    Result := fraFatorParaFaturamento.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And fraLiberacaoPedido.Visible Then
    Result := fraLiberacaoPedido.fValidaCampos(Sender, blnBuscaPorChave);

  If fraInvoice.Visible Then
    Result := Result And fraInvoice.fValidaCampos(Sender, blnBuscaPorChave);

  If fraClienteContaOrdemFrame.Visible Then
    Result := Result And fraClienteContaOrdemFrame.fValidaCampos(Sender, blnBuscaPorChave);

  If (Sender = fraTransportadora.edtValFre) Then
    Result := Result And fValidaFrenet();

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatDigMensagem.fValidaFrenet: Boolean;
begin
  Result := True;

  If (FblnUltimaEscolhaFretePelaFrenet) Then
  Begin
    If fFormataFloat(fStrToFloat(fraTransportadora.edtValFre.Text),2) < fFormataFloat(FfltValorFretePelaFrenet,2) Then
    Begin
      If Not fPermitirAlterarFreteFrenet Then
      Begin
        fraTransportadora.edtValFre.Text := FloatToStr(FfltValorFretePelaFrenet);
        fatvenda.strFreTipApi            := FstrTipoFreteSelecionado;
        Result := False;
      End;
    End;

    If fFormataFloat(fStrToFloat(fraTransportadora.edtValFre.Text),2) <> fFormataFloat(FfltValorFretePelaFrenet,2) Then
    Begin
      fatVenda.strQlpPlaVei := EmptyStr;
      fatVenda.fltQlpDist   := 0;
      fatVenda.fltQlpVlrCmb := 0;
      fatVenda.fltQlpVlrPed := 0;
      fatVenda.intCodtab    := 0;
      fatVenda.strCotid_    := EmptyStr;
      fatvenda.strFreTipApi := 'MANUAL';
    End;
  End;
end;

procedure TfrmFatDigMensagem.FormShow(Sender: TObject);
  Const
    intGordurinha = 10;

  function fRetornaAlturaElementosRodape: Integer;
  begin
    Result := intGordurinha + pnlConfirma.Height+ pnlInfo.Height;
  end;

begin

  If (blnJaChamouOnShow) Then
    Exit;

  fraObservacoes.objVenda := fatVenda;
  fraObservacoes.OnFormShow;

  fraTransportadora.objVenda := fatVenda;
  fraTransportadora.qryDadosPedido := qryFatGor;
  fraTransportadora.OnFormShow;

  If (cdsVenda <> nil) And cdsVenda.Active Then
    fraDadosPedido.bolNotifAgr := (cdsVenda.RecordCount > 1)
  Else
    fraDadosPedido.bolNotifAgr := True;

  fraDadosPedido.objVenda := fatVenda;
  fraDadosPedido.qryDadosPedido := qryFatGor;
  fraDadosPedido.pCalcularTotalPedido := Self.pCalcularTotalPedido;
  fraDadosPedido.pCarregarDespesasAcessorias := fraTransportadora.pCarregarDespesasAcessorias;
  fraDadosPedido.pHabilitarFatorParaFaturamento := fraFatorParaFaturamento.pHabilitarFatorParaFaturamento;
  fraDadosPedido.pHabilitarLiberacaoPedido := fraLiberacaoPedido.pHabilitarLiberacaoPedido;
  fraDadosPedido.OnFormShow;

  fraDescFinanBoletoAdto.objVenda := fatVenda;
  fraDescFinanBoletoAdto.pCalcularTotalPedido := Self.pCalcularTotalPedido;
  fraDescFinanBoletoAdto.OnFormShow;

  fraFatorParaFaturamento.objVenda := fatVenda;
  fraFatorParaFaturamento.OnFormShow;

  fraLiberacaoPedido.objVenda := fatVenda;
  fraLiberacaoPedido.OnFormShow;

  fraNumeroDrawbackFrame.objVenda := fatVenda;
  fraNumeroDrawbackFrame.onConfirm := pConfirmDados;
  fraNumeroDrawbackFrame.OnFormShow;

  btnEspRascNF.Visible := fVerificaAcessoSistema('VESPPD', strLoginUsuarioLogado);

  btnSimularVenda.Visible := fCfgSis('SOLFNE', varBoolean);

  btnMostraMargem.Visible := (Pos(fatVenda.strOpcDoc, 'VN_OR_PD_') > 0) And
                              fVerificaAcessoSistema('VIMLF4');

  btnTotalizadorEmp.Visible := fCfgSis('EMPFAT', varBoolean);

  If (btnSimularVenda.Visible) And (Not btnMostraMargem.Visible) Then
    btnSimularVenda.Left := btnMostraMargem.Left;

  If (btnTotalizadorEmp.Visible) And (Not btnEspRascNF.Visible) Then
    btnTotalizadorEmp.Left := btnEspRascNF.Left;

  If (btnEspRascNF.Visible Or btnTotalizadorEmp.Visible) Then
    pnlConfirma.Height := (btnConfirmaDados.Height + btnEspRascNF.Height) + 5
  Else
    pnlConfirma.Height := (btnConfirmaDados.Height) + 5;

  {************************************************************************************}
  { SEMPRE DEIXE ESSSA CHAMADA POR ÚLTIMO E COLOQUE NOVOS ELEMENTOS DENTRO DE pnlFundo }
  { COMO OS DEMAIS                                                                     }
  {*********************************************************************************VA*}
  Self.ClientHeight := 0;

  Self.ClientHeight := Self.ClientHeight +
    fRetornaSomaAlturaDosPaineisVisiveisEm(fraObservacoes.pnlFundo);

  Self.ClientHeight := Self.ClientHeight +
    fRetornaSomaAlturaDosPaineisVisiveisEm(fraTransportadora.pnlFundo);

  If fraDescFinanBoletoAdto.Visible Then
    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraDescFinanBoletoAdto.pnlFundo);

  If fraFatorParaFaturamento.Visible Then
    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraFatorParaFaturamento.pnlFundo);

  If fraLiberacaoPedido.Visible Then
    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraLiberacaoPedido.pnlFundo);

  If fraNumeroDrawbackFrame.Visible Then
    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraNumeroDrawbackFrame.pnlDrawBackFrame);

  fraDadosPedido.Height := fRetornaSomaAlturaDosPaineisVisiveisEm(fraDadosPedido.pnlFundo);

  fraInvoice.Visible := fCfgSis('USAVOI', varBoolean) And ((fatVenda.strCliEst = 'EX') Or (fatVenda.fTrocaUFEndEntrega = 'EX'));

  If fraInvoice.Visible Then
  Begin
    fraInvoice.objVenda := fatVenda;
    fraInvoice.OnFormShow;

    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraInvoice.pnlFundo);
  End;

  Self.ClientHeight := Self.ClientHeight +
    fraDadosPedido.Height;

  Self.ClientHeight := Self.ClientHeight +
    fRetornaAlturaElementosRodape;

  fraTransportadora.btnCalcularFrete.Visible := (fCfgSis('FREUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('QLPUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('DTFUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('ITPUTI', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('USALAL', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0));

  FblnUltimaEscolhaFretePelaFrenet := False;
  FfltValorFretePelaFrenet         := 0.00;
  FstrCodTraFreFat := EmptyStr;
  FstrTipoFreteSelecionado         := EmptyStr;
  FblnEspRascDANFE                 := False;

  if (fEmptyStr(fatvenda.strFreTipApi)) or
     (fatvenda.strFreTipApi = 'MANUAL') then
    fatvenda.strFreTipApi := 'MANUAL'
  else
  begin
    FstrCodTraFreFat := fatvenda.strCodTra;
    FblnUltimaEscolhaFretePelaFrenet := True;
    FfltValorFretePelaFrenet         := fatvenda.fltVlrFreFat;
    FstrTipoFreteSelecionado         := fatvenda.strFreTipApi;
  end;

  fraClienteContaOrdemFrame.objVenda := fatVenda;
  fraClienteContaOrdemFrame.OnFormShow;

  fraDadosPedidoedtTipOpeExit(Sender);
end;

procedure TfrmFatDigMensagem.btnSimularVendaClick(Sender: TObject);
begin
  inherited;

  If Not btnSimularVenda.Visible Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  TfrmFatMostraItensFechamento.pSimularFechamentoVenda(fatVenda,
    fStrToFloat(fraTransportadora.edtValFre.Text),
    fStrToFloat(fraTransportadora.edtDesAce.Text),
    fraDadosPedido.edtTipFat.Text, fraDadosPedido.edtTipOpe.Text,
    fStrToFloat(fraFatorParaFaturamento.edtFatCal.Text),
    fraFatorParaFaturamento.edtTipoFator.Text);
end;

procedure TfrmFatDigMensagem.btnTotalizadorEmpClick(Sender: TObject);
  Var
    frmFatTotalizadorEmpresa: TfrmFatTotalizadorEmpresa;
begin
  inherited;

  If Not btnTotalizadorEmp.Visible Then
    Exit;

  pCriarFormularios(TfrmFatTotalizadorEmpresa, frmFatTotalizadorEmpresa);
  Try
    frmFatTotalizadorEmpresa.cdsDados.Data := cdsVenda.Data;
    frmFatTotalizadorEmpresa.ShowModal;
  Finally
    pFreeAndNil(frmFatTotalizadorEmpresa);
  End;
end;

procedure TfrmFatDigMensagem.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigMensagem.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  if FstrCodTraFreFat <> fraTransportadora.edtCodTra.Text then
  begin
    fatVenda.strQlpPlaVei := EmptyStr;
    fatVenda.fltQlpDist   := 0;
    fatVenda.fltQlpVlrCmb := 0;
    fatVenda.fltQlpVlrPed := 0;
    fatVenda.intCodtab    := 0;
    fatVenda.strCotid_    := EmptyStr;
    fatVenda.strFreTipApi := 'MANUAL';
    FblnUltimaEscolhaFretePelaFrenet := False;
  end;

  If Not fVerificaCampos Then
    Exit;

  If Not fraObservacoes.fConfirmaDados Then
    Exit;

  If fraTransportadora.Visible Then
  begin
    If Not fraTransportadora.fConfirmaDados Then
      Exit;
  end;

  If Not fraDadosPedido.fConfirmaDados Then
    Exit;

  If fraDescFinanBoletoAdto.Visible Then
    If Not fraDescFinanBoletoAdto.fConfirmaDados Then
      Exit;

  If fraFatorParaFaturamento.Visible Then
    If Not fraFatorParaFaturamento.fConfirmaDados Then
      Exit;

  If fraLiberacaoPedido.Visible Then
    If Not fraLiberacaoPedido.fConfirmaDados Then
      Exit;

  If fraInvoice.Visible Then
    If Not fraInvoice.fConfirmaDados Then
      Exit;

  If fraClienteContaOrdemFrame.Visible Then
    If Not fraClienteContaOrdemFrame.fConfirmaDados Then
      Exit;

  blnConfirma := True;

  If not FblnEspRascDANFE Then
    Close;
end;

procedure TfrmFatDigMensagem.btnMostraMargemClick(Sender: TObject);
begin
  inherited;
  If (Not btnMostraMargem.Enabled) Then
    Exit;

  If (Not btnMostraMargem.Visible) Then
    Exit;

  Try
    If InterlockedIncrement(intSemaforo) = 0 Then
    Begin
      fatVenda.strCodTra := fraTransportadora.edtCodTra.Text;
      fatVenda.fltValFre := fStrToFloat(fraTransportadora.edtValFre.Text);
      fraTransportadora.pCalculaFreteSugestao;
      fatVenda.pMostraMargemComFrete;
      pSetFocus(ActiveControl);
    End;
  Finally
    InterlockedDecrement(intSemaforo);
  End;
end;

procedure TfrmFatDigMensagem.pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);
begin
  fatVenda.fltValFre    := fStrToFloat(fraTransportadora.edtValFre.Text);
  fatVenda.fltDesAce    := fStrToFloat(fraTransportadora.edtDesAce.Text);
  fatvenda.fltVlrFreFat := fFormataFloat(fStrToFloat(fraTransportadora.edtValFre.Text),2);

  {Valores já calculados na frmFatDigDadosConcreto,
   quando opção J_A_MASSA_CONCRETO}
  If (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
    fatVenda.fltTotBom := fStrToFloat(fraDadosPedido.edtTotBom.Text);

  fatVenda.strTipOpe := fraDadosPedido.edtTipOpe.Text;
  fatVenda.strTipPed := fraDadosPedido.edtTipFat.Text;

  If Not AForcarCalculo Then
  Begin
    If (FInfUltimoCalculoTotal.fltValFre = fatVenda.fltValFre) And
       (FInfUltimoCalculoTotal.fltDesAce = fatVenda.fltDesAce) And
       (FInfUltimoCalculoTotal.strTipOpe = fatVenda.strTipOpe) And
       (FInfUltimoCalculoTotal.strTipPed = fatVenda.strTipPed) And
       (FInfUltimoCalculoTotal.fltTotBom = fatVenda.fltTotBom) Then
    Begin
      Exit;
    End;
  End;

  FInfUltimoCalculoTotal.fltValFre := fatVenda.fltValFre;
  FInfUltimoCalculoTotal.fltDesAce := fatVenda.fltDesAce;
  FInfUltimoCalculoTotal.fltTotBom := fatVenda.fltTotBom;
  FInfUltimoCalculoTotal.strTipOpe := fatVenda.strTipOpe;
  FInfUltimoCalculoTotal.strTipPed := fatVenda.strTipPed;

  fatVenda.pCalculaTotGer;
end;

procedure TfrmFatDigMensagem.pConfirmDados;
begin
  pSetFocus(btnConfirmaDados);
end;

procedure TfrmFatDigMensagem.btnEspRascNFClick(Sender: TObject);
var
  objGerarEspelho: TGerarEspelhoRascunhoDANFE;
begin
  inherited;

  try
    objGerarEspelho := TGerarEspelhoRascunhoDANFE.Create(VS_strCodEmp, fatVenda);
    blnConfirma       := False;
    FblnEspRascDANFE  := True;
    btnConfirmaDados.Click ;

    if (not blnConfirma) then
      Exit;

    objGerarEspelho.fGerarEspelho(fatVenda.fOpcDocClaSub);
  finally
    blnConfirma        := False;
    FblnEspRascDANFE   := False;
    FreeAndNil(objGerarEspelho);
  end;
end;

end.
