{***************************}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untFatDigMensagemOrc;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, EditFocus, untFuncFat, Mask, MaskEditFocus, QColorLabel,
  AppEvnts,  cxHint, strUtils, untFuncFatTypes,
  BitBtnLockedIncrem, ComboBoxFocus, dxScreenTip, cxClasses, dxCustomHint,
  frxClass, frxExportCSVTestabilidade, untLiberacao,
  untDadosFechamentoPedidoObservacoesFrame,
  untDadosFechamentoPedidoTransportadoraFrame, untDadosFechamentoPedidoFrame,
  untDadosFechamentoPedidoInvoiceFrame;

type
  TfrmFatDigMensagemOrc = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    btnMostraMargem: TBitBtnLocked;
    fraObservacoes: TfraDadosFechamentoPedidoObservacoesFrame;
    fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame;
    fraDadosPedido: TfraDadosFechamentoPedidoFrame;
    fraInvoice: TfraDadosFechamentoPedidoInvoiceFrame;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure fraTransportadoraedtValFreExit(Sender: TObject);
    procedure fraTransportadorabtnCalcularFreteClick(Sender: TObject);
  private
    intSemaforo: Integer;
    FInfUltimoCalculoTotal: TRecInfUltimoCalculoTotal;

    FblnUltimaEscolhaFretePelaFrenet : Boolean;
    FstrCodTraFreFat                 : String;
    FfltValorFretePelaFrenet         : Double;
    FstrTipoFreteSelecionado         : String;

    procedure pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);
    function fPermitirAlterarFreteFrenet : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fatVenda        : TFatVenda;
    qryFatGor       : TUniQuery;
    blnConfirma     : Boolean;
    blnPodeCancelar : Boolean;
    procedure pOnShow;
  end;


implementation

uses  untPai, untPesqAux, untfuncoesSimples, Data.DB, untTypesSistema,
      untConsultas, untTipoFreteAtc, untConstantes, untCadClientes, untFuncoes,
      untMsgLiberacao, untProjetos, untFrenetConsulta, untEndPartidaConsFrete,
      LalaMove.View.Consulta;

{$R *.dfm}

procedure TfrmFatDigMensagemOrc.btnConfirmaDadosClick(Sender: TObject);
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
      Exit
  end;

  If Not fraDadosPedido.fConfirmaDados Then
    Exit;

  If fraInvoice.Visible Then
    If Not fraInvoice.fConfirmaDados Then
      Exit;

  blnConfirma := True;
  Close;
end;

procedure TfrmFatDigMensagemOrc.btnMostraMargemClick(Sender: TObject);
begin
  inherited;
  If (Not btnMostraMargem.Enabled) Then
    Exit;

  If (Not btnMostraMargem.Visible) Then
    Exit;

  Try
    If InterlockedIncrement(intSemaforo) = 0 Then
    Begin
      If fraTransportadora.Visible Then
      Begin
        fatVenda.strCodTra := fraTransportadora.edtCodTra.Text;
        fatVenda.fltValFre := fStrToFloat(fraTransportadora.edtValFre.Text);
        fraTransportadora.pCalculaFreteSugestao;
      End;
      fatVenda.pMostraMargemComFrete;
      pSetFocus(ActiveControl);
    End;
  Finally
    InterlockedDecrement(intSemaforo);
  End;
end;

procedure TfrmFatDigMensagemOrc.FormShow(Sender: TObject);
begin
  pOnShow;
end;

procedure TfrmFatDigMensagemOrc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (Not blnPodeCancelar) And (Not blnConfirma) Then
    Action := caNone;
end;

procedure TfrmFatDigMensagemOrc.FormCreate(Sender: TObject);
begin
  inherited;
  fraTransportadora.Visible := fCfgSis('INFFRE', varBoolean);

  intSemaforo := -1;
  blnConfirma := False;
  blnPodeCancelar := True;

  fraObservacoes.OnFormCreate;

  If fraTransportadora.Visible Then
    fraTransportadora.OnFormCreate;

  fraDadosPedido.OnFormCreate;
end;

procedure TfrmFatDigMensagemOrc.FormDestroy(Sender: TObject);
begin
  inherited;
  fraObservacoes.OnFormDestroy;
  If fraTransportadora.Visible Then
    fraTransportadora.OnFormDestroy;
  fraDadosPedido.OnFormDestroy;
end;

procedure TfrmFatDigMensagemOrc.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F4: btnMostraMargem.Click;
    VK_F10: btnConfirmaDados.Click;
  End;
end;

function TfrmFatDigMensagemOrc.fPermitirAlterarFreteFrenet: Boolean;
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

procedure TfrmFatDigMensagemOrc.fraTransportadorabtnCalcularFreteClick(
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
    frmFrenetConsulta.fatVenda := fatVenda;
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

procedure TfrmFatDigMensagemOrc.fraTransportadoraedtValFreExit(Sender: TObject);
begin
  inherited;

  If (FblnUltimaEscolhaFretePelaFrenet) Then
  Begin
    If fFormataFloat(fStrToFloat(fraTransportadora.edtValFre.Text),2) < fFormataFloat(FfltValorFretePelaFrenet,2) Then
     Begin
      If Not fPermitirAlterarFreteFrenet Then
      Begin
        fraTransportadora.edtValFre.Text := FloatToStr(FfltValorFretePelaFrenet);
        fatvenda.strFreTipApi            := FstrTipoFreteSelecionado;
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
      FblnUltimaEscolhaFretePelaFrenet := False;
    End;
  End;
end;

function TfrmFatDigMensagemOrc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := (inherited fValidaCampos(Sender, blnBuscaPorChave));

  Result := Result And fraObservacoes.fValidaCampos(Sender, blnBuscaPorChave);

  If fraTransportadora.Visible Then
    Result := Result And fraTransportadora.fValidaCampos(Sender, blnBuscaPorChave);

  Result := Result And fraDadosPedido.fValidaCampos(Sender, blnBuscaPorChave);

  If fraInvoice.Visible Then
    Result := Result And fraInvoice.fValidaCampos(Sender, blnBuscaPorChave);

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigMensagemOrc.pOnShow;

  function fRetornaAlturaElementosRodape: Integer;
    Const
      intGordurinha = 15;
  begin
    Result := intGordurinha + pnlConfirma.Height+ pnlInfo.Height;
  end;

begin
  inherited;
  fraInvoice.Visible  := fCfgSis('USAVOI', varBoolean) And ((fatVenda.strCliEst = 'EX') Or (fatVenda.fTrocaUFEndEntrega = 'EX'));

  If (fatVenda.strOpcDoc = 'OR') And (fatVenda.strEspDoc = 'OR') Then
    fatVenda.strCodRot := '';

  fraObservacoes.objVenda := fatVenda;
  fraObservacoes.OnFormShow;

  If fraTransportadora.Visible Then
  Begin
    fraTransportadora.objVenda := fatVenda;
    fraTransportadora.qryDadosPedido := qryFatGor;
    fraTransportadora.OnFormShow;
  End;

  fraDadosPedido.objVenda := fatVenda;
  fraDadosPedido.qryDadosPedido := qryFatGor;
  fraDadosPedido.pCalcularTotalPedido := Self.pCalcularTotalPedido;

  If fraTransportadora.Visible Then
    fraDadosPedido.pCarregarDespesasAcessorias := fraTransportadora.pCarregarDespesasAcessorias;

  fraDadosPedido.OnFormShow;

  btnMostraMargem.Visible := (Pos(fatVenda.strOpcDoc, 'VN_OR_PD_') > 0) And
                             (fraTransportadora.Visible)                And
                             (fraTransportadora.blnCalcFreteSugestaoTranp Or
                              fraTransportadora.blnCalcFreteSugestaoRegia Or
                              fraTransportadora.blnCalcFreteSugestaoItens Or
                              fraTransportadora.blnCalcFreteSugestaoFaixa);

  {************************************************************************************}
  { SEMPRE DEIXE ESSSA CHAMADA POR ÚLTIMO E COLOQUE NOVOS ELEMENTOS DENTRO DE pnlFundo }
  { COMO OS DEMAIS                                                                     }
  {*********************************************************************************VA*}
  Self.ClientHeight := fRetornaSomaAlturaDosPaineisVisiveisEm(fraObservacoes.pnlFundo);

  If fraTransportadora.Visible Then
    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraTransportadora.pnlFundo);

  fraDadosPedido.Height := fRetornaSomaAlturaDosPaineisVisiveisEm(fraDadosPedido.pnlFundo);

  If fraInvoice.Visible Then
  Begin
    fraInvoice.objVenda := fatVenda;
    fraInvoice.OnFormShow;

    Self.ClientHeight := Self.ClientHeight +
      fRetornaSomaAlturaDosPaineisVisiveisEm(fraInvoice.pnlFundo);
  End;

  Self.ClientHeight := Self.ClientHeight + fraDadosPedido.Height;

  Self.ClientHeight := Self.ClientHeight +
    fRetornaAlturaElementosRodape;

  fraTransportadora.btnCalcularFrete.Visible := (fCfgSis('FREUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('QLPUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('DTFUSA', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('ITPUTI', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0)) or
                                                (fCfgSis('USALAL', varBoolean) and (Pos(fatVenda.strOpcDoc, 'VN_') <= 0));

  FblnUltimaEscolhaFretePelaFrenet := False;
  FstrCodTraFreFat := EmptyStr;
  FfltValorFretePelaFrenet         := 0.00;
  FstrTipoFreteSelecionado         := EmptyStr;

  if (fEmptyStr(fatvenda.strFreTipApi)) or
     (fatvenda.strFreTipApi = 'MANUAL') then
    fatvenda.strFreTipApi := 'MANUAL'
  else
  begin
    FstrCodTraFreFat := fatVenda.strCodTra;
    FblnUltimaEscolhaFretePelaFrenet := True;
    FfltValorFretePelaFrenet         := fatvenda.fltVlrFreFat;
    FstrTipoFreteSelecionado         := fatvenda.strFreTipApi;
  end;

  If fraTransportadora.Visible Then
    fraTransportadora.pCarregarDespesasAcessoriasImpostoDeImportacao;
end;

procedure TfrmFatDigMensagemOrc.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigMensagemOrc.pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);
begin
  If fraTransportadora.Visible Then
  Begin
    fatVenda.fltValFre    := fStrToFloat(fraTransportadora.edtValFre.Text);
    fatVenda.fltDesAce    := fStrToFloat(fraTransportadora.edtDesAce.Text);
    fatvenda.fltVlrFreFat := fFormataFloat(fStrToFloat(fraTransportadora.edtValFre.Text),2);
  End;

  fatVenda.fltTotBom := fStrToFloat(fraDadosPedido.edtTotBom.Text);

  If (Not AForcarCalculo) Then
  Begin
    If (FInfUltimoCalculoTotal.fltValFre = fatVenda.fltValFre) And
       (FInfUltimoCalculoTotal.fltDesAce = fatVenda.fltDesAce) And
       (FInfUltimoCalculoTotal.fltTotBom = fatVenda.fltTotBom) Then
    Begin
      Exit;
    End;
  End;

  FInfUltimoCalculoTotal.fltValFre := fatVenda.fltValFre;
  FInfUltimoCalculoTotal.fltDesAce := fatVenda.fltDesAce;
  FInfUltimoCalculoTotal.fltTotBom := fatVenda.fltTotBom;

  fatVenda.pCalculaTotGer;
end;


end.

