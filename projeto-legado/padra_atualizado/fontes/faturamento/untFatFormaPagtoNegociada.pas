unit untFatFormaPagtoNegociada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, Menus, AppEvnts, Uni, strUtils, Math,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.DBCtrls,
  DBEditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView,
  cxGrid, CurrencyEditFocus, ComboBoxFocus,
  UniClientDataSet, untFormaPagtoNegociada, Vcl.ImgList, cxEditRepositoryItems, cxContainer, System.ImageList, cxTextEdit,
  cxCurrencyEdit, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxImageList, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmFatFormaPagtoNegociada = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    btnConfirma: TBitBtnLocked;
    cxgFormasNegociadas: TcxGrid;
    cxgFormasNegociadasView: TcxGridDBBandedTableView;
    cxgFormasNegociadasViewCODFPG: TcxGridDBBandedColumn;
    cxgFormasNegociadasViewDESFPG: TcxGridDBBandedColumn;
    cxgFormasNegociadasViewVALFPG: TcxGridDBBandedColumn;
    cxgFormasNegociadasLevel: TcxGridLevel;
    Panel1: TPanel;
    lblValVen: TLabel;
    Label13: TLabel;
    edtValVen: TCurrencyEditFocus;
    edtValDig: TCurrencyEditFocus;
    dtsFormasNegociadas: TDataSource;
    Label6: TLabel;
    lblValDig: TLabel;
    edtValRes: TCurrencyEditFocus;
    lblInfGrid: TLabel;
    pnlDadosCondicao: TPanel;
    Label5: TLabel;
    edtCodCndPed: TEditFocus;
    edtDesCndPed: TEditFocus;
    edtConPagPed: TEditFocus;
    lblTotalCreditos: TLabel;
    edtTotalCreditos: TCurrencyEditFocus;
    cxgFormasNegociadasViewVALREC: TcxGridDBBandedColumn;
    cxgFormasNegociadasViewFPGREC: TcxGridDBBandedColumn;
    cxRepositorio: TcxEditRepository;
    cxrImgFpgRec: TcxEditRepositoryImageComboBoxItem;
    cxImageList: TcxImageList;
    pnlFormasPagamento: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    lblConPag: TLabel;
    cbxModalidades: TComboBoxFocus;
    edtValor: TCurrencyEditFocus;
    mskConPag: TMaskEditFocus;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    btnInserirFormaPagto: TBitBtnLocked;
    edtQtdPar: TEditFocus;
    btnSelCre: TBitBtnLocked;
    btnUnificarCartoes: TBitBtnLocked;
    pnlTroco: TPanel;
    lblQtdParcelMax: TLabel;
    dtaDtaChq: TcxDateEdit;
    lblDtaChq: TLabel;
    cxgFormasNegociadasViewVALANT: TcxGridDBBandedColumn;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnInserirFormaPagtoClick(Sender: TObject);
    procedure cbxModalidadesChange(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure cxgFormasNegociadasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxModalidadesEnter(Sender: TObject);
    procedure btnSelCreClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnUnificarCartoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    formaPagtoSel: TFormaPagto;
    intSemaforoRecebimento: Integer;
    function fRetConPagCalculado(strCodCli, strConPag, strCodCnd: String): String;
    procedure pAtualizaCampos;
    procedure pCarregaDescricaoFormasPagto;
    procedure pExibirBotaoUnificarCartoes;
    procedure pAtualizaTotais;
    procedure pReceberFormaPagto;
    procedure pMostraDataCheque(blnMostrar: Boolean; blnDiaFix: Boolean=False);
    function fTravarMaximoParcelas(blnShowMsg: Boolean = False):Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objFormasPagto: TFormaPagtoNegociada;
    blnConfirma: Boolean;
    blnUtilizaCreditoOutrasFormasPagamento: Boolean;
    blnUsaEmpOri : Boolean;
    procedure pOnShowForm;
    function fSelecionarCreditos(blnDescontaCreditoAutomatico: Boolean = False; blnUsaEmpOri: Boolean = False): Boolean;
    function fInserirFormaPagto: Boolean;
  end;

var
  frmFatFormaPagtoNegociada: TfrmFatFormaPagtoNegociada;

implementation

uses untFuncoesSimples, untPesqAux, untPai, untTypesSistema,
  untConsultas, untConstantes, untFuncoes, untGravando, untFatUnificarCartoes;

{$R *.dfm}

procedure TfrmFatFormaPagtoNegociada.btnInserirFormaPagtoClick(Sender: TObject);
begin
  If (cbxModalidades.ItemIndex = - 1) Then
  Begin
    fMensagem('', 'Selecione uma forma de pagamento.', ['&Ok']);
    pSetFocus(cbxModalidades);
    Exit;
  End;
  fInserirFormaPagto;
end;

function TfrmFatFormaPagtoNegociada.fInserirFormaPagto: Boolean;
begin
  inherited;
  Result := False;

  If fVerificaCampos Then
  Begin
    objFormasPagto.pSelecionarFormaPagto(formaPagtoSel);
    cbxModalidades.ItemIndex := -1;
    pAtualizaCampos;
    pAtualizaTotais;
    pReceberFormaPagto;
    SelectFirst;
    Result := True;
  End;

  If Result And objFormasPagto.fConfirmarFormasPagamento(False) Then
    pSetFocus(btnConfirma);
end;

function TfrmFatFormaPagtoNegociada.fRetConPagCalculado(strCodCli, strConPag, strCodCnd: String): String;
  Var
    strConAux,
    strTipFor: String;
begin
  strTipFor := fRetTipoForaConPag(strCodCnd);

  strConAux := '';

  If (fConPagFora(strTipFor)) And fCfgSis('USACND', VarBoolean) And (Not fEmptyStr(strCodCnd)) Then
  Begin
    strConAux := fRetConPagCodCnd(strCodCnd);
    strConPag := fRetCondicao('', 0, strCodCnd, strTipFor, strConAux);
  End;

  If (fEmptyStr(strConAux)) And (Pos(strTipFor, 'OUTROS_DIA FIXO_') <= 0) And fCfgSis('USACND', VarBoolean) And (Not fEmptyStr(strCodCnd)) Then
    strConAux := fRetConPagCodCnd(strCodCnd)
  Else
    strConAux := strConPag;

  If (fStatusCndPag(strConAux) = A_VISTA) Then
    strConAux := '01001';

  Result := fRetCondicaoDiaFixoCliente('', 0, strCodCli, strConAux);
end;

procedure TfrmFatFormaPagtoNegociada.pAtualizaCampos;
  Var
    strConPagPrz: String;
    blnCliDiaFix: Boolean;
begin
  If (cbxModalidades.ItemIndex > -1) And (blnUtilizaCreditoOutrasFormasPagamento) Then
  Begin
    formaPagtoSel := objFormasPagto.arrFormasPagamento[cbxModalidades.ItemIndex];

    If (formaPagtoSel.strCodigo <> '013') Then
      cbxModalidades.ItemIndex := -1;
  End;

  If cbxModalidades.ItemIndex = -1 Then
  Begin
    FillChar(formaPagtoSel, SizeOf(formaPagtoSel), #0);

    edtValor.Value := 0.00;
    edtCodCar.Text := '';
    edtDesCar.Text := '';
    edtQtdPar.Text := '';
    mskConPag.Text := '01000';
    pMostraDataCheque(False);

    edtValor.Enabled  := False;
    edtCodCar.Enabled := False;
    edtQtdPar.Enabled := False;
    mskConPag.Enabled := False;
    btnSelCre.Visible := False;

    lblConPag.Caption := 'Condição de Pagamento:';
  End
  Else
  Begin
    formaPagtoSel   := objFormasPagto.arrFormasPagamento[cbxModalidades.ItemIndex];
    pMostraDataCheque(False);
    
    With formaPagtoSel Do
    Begin
      edtCodCar.Text := dadosCartao.strCodigo;
      edtDesCar.Text := dadosCartao.strDescricao;
      edtQtdPar.Text := intToStr(dadosCartao.intQtdParcelas);
      mskConPag.Text := strCondPagamento;

      edtValor.Enabled  := True;
      edtCodCar.Enabled := (strCodigo = '007');
      edtQtdPar.Enabled := (strCodigo = '007');
      mskConPag.Enabled := False;
      mskConPag.TabStop := False;
      btnSelCre.Visible := False;

      If fCfgSis('PFLCLI',varBoolean) Then
      Begin
        lblQtdParcelMax.Visible :=  (strCodigo = '007');
        If (lblQtdParcelMax.Visible) Then
          lblQtdParcelMax.Caption    := 'Qtd. Máxima de Parcelas (Cartão) da Condição de Pagamento: ' + IntToStr(objFormasPagto.fMaxParcCartaoCondicaoPagto);
      End;
      edtValor.Value    := objFormasPagto.fltValorRestante;
      edtValor.Properties.ReadOnly := False;
      edtValor.TabStop  := True;

      If (strCodigo = '013') Then
      Begin
        edtValor.Value    := 0.00;
        btnSelCre.Visible := True;
      End;

      If (strCodigo = '015') And
         (Not objFormasPagto.cdsFormasNegociadas.IsEmpty) Then
      Begin
        edtValor.Properties.ReadOnly := True;
        edtValor.TabStop := False;
      End;

      lblConPag.Caption := 'Condição de Pagamento:';

      If MatchStr(strCodigo, ['002', '008', '010']) Then
      Begin
        blnCliDiaFix := fClienteTemDiaFixo(objFormasPagto.strCodCliente) And (strCodigo = '008');
        strConPagPrz := fGetCondicaoPrazo(objFormasPagto.strCondicaoPagto);
        If blnCliDiaFix Then
          strConPagPrz := fRetConPagCalculado(objFormasPagto.strCodCliente, strConPagPrz, objFormasPagto.strCodCondPagto);

        mskConPag.Enabled  := True;
        mskConPag.ReadOnly := True;
        mskConPag.TabStop  := Not mskConPag.ReadOnly;
        mskConPag.Text     := strConPagPrz;
        strCondPagamento   := strConPagPrz;
        lblConPag.Caption  := 'Condição de Pagamento (' + strDescricaoCompleta + ')' + IIF(blnCliDiaFix,' cliente tem dia fixo', '') + ':';

        pMostraDataCheque((objFormasPagto.strCodFormaPagto = '009') And (strCodigo = '002') And (objFormasPagto.strCondicaoPagto = '01000'), blnCliDiaFix);
      End;
    End;
  End;
end;

procedure TfrmFatFormaPagtoNegociada.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormaPagtoNegociada.btnSelCreClick(Sender: TObject);
begin
  inherited;
  fSelecionarCreditos;
end;

procedure TfrmFatFormaPagtoNegociada.btnUnificarCartoesClick(Sender: TObject);
  Var
    objUnificarCartoes: TUnificarCartoesNegociados;
begin
  inherited;
  If Not btnUnificarCartoes.Visible Then
    Exit;

  objUnificarCartoes := TUnificarCartoesNegociados.Create(objFormasPagto);

  //Quando possuir apenas dois cartoes nem exibe a tela de cartoes
  If objFormasPagto.fGetQuantidadeCartoesNegociados = 2 Then
    objUnificarCartoes.fUnificarCartoesNegociados
  Else
  Begin
    Try
      pCriarFormularios(TfrmFatUnificarCartoes, frmFatUnificarCartoes);
      frmFatUnificarCartoes.objUnificarCartoes := objUnificarCartoes;
      frmFatUnificarCartoes.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmFatUnificarCartoes);
  End;

  FreeAndNil(objUnificarCartoes);

  pExibirBotaoUnificarCartoes;
end;

function TfrmFatFormaPagtoNegociada.fSelecionarCreditos(blnDescontaCreditoAutomatico: Boolean = False; blnUsaEmpOri: Boolean = False): Boolean;
begin
  inherited;
  Result := False;

  If (Not btnSelCre.Visible) And (Not blnDescontaCreditoAutomatico) Then
    Exit;

  If Not fValidaCampos(cbxModalidades) Then
    Exit;

  edtValor.Value := 0.00;

  If objFormasPagto.fSelecionarCreditos(blnDescontaCreditoAutomatico, blnUsaEmpOri) Then
  Begin
    edtValor.Value := Min(objFormasPagto.fltTotCreditos, objFormasPagto.fltValorRestante);

    If fValidaCampos(edtValor, True) Then
    Begin
      Result := True;
      pSetFocus(edtValor);
    End
    Else
      pSetFocus(cbxModalidades);
  End
  Else
    pSetFocus(cbxModalidades);
end;

procedure TfrmFatFormaPagtoNegociada.cbxModalidadesChange(Sender: TObject);
begin
  inherited;
  pAtualizaCampos;
end;

procedure TfrmFatFormaPagtoNegociada.cbxModalidadesEnter(Sender: TObject);
begin
  inherited;
  If cbxModalidades.ItemIndex = -1 Then
    pAtualizaCampos;
end;

procedure TfrmFatFormaPagtoNegociada.cxgFormasNegociadasViewKeyDown
  (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key Of
    VK_ESCAPE:
      Begin
        If pnlFormasPagamento.Visible Then
        Begin
          cbxModalidades.ItemIndex := -1;
          SelectFirst;
        End
        Else
          btnSair.Click;
      End;

    VK_DELETE:
      Begin
        If pnlFormasPagamento.Visible Then
        Begin
          objFormasPagto.pRemoverFormaPagto;
          pAtualizaTotais;
          If objFormasPagto.cdsFormasNegociadas.IsEmpty Then
          Begin
            cbxModalidades.ItemIndex := -1;
            SelectFirst;
          End;
        End;
      End;

    VK_RETURN:
      Begin
        pReceberFormaPagto;
        If objFormasPagto.fConfirmarFormasPagamento(False) Then
          pSetFocus(btnConfirma);
      End;

    Else
      FormKeyDown(Sender, Key, Shift);
  End;
end;

procedure TfrmFatFormaPagtoNegociada.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  With formaPagtoSel, objFormasPagto Do
  Begin
    If (strCodigo = '007') And dadosCartao.fPesquisaCartao(Self, Key, fMaxParcCartaoCondicaoPagto) Then
    Begin
      edtCodCar.Text := dadosCartao.strCodigo;
      edtDesCar.Text := dadosCartao.strDescricao;
      edtQtdPar.Text := intToStr(dadosCartao.intQtdParcelas);
      If fValidaCampos(edtCodCar, True) Then
        SelectNext(edtCodCar, True, True);
    End;
  End;
end;

function TfrmFatFormaPagtoNegociada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = cbxModalidades) Then
  Begin
    If cbxModalidades.ItemIndex = -1 Then
    Begin
      If objFormasPagto.cdsFormasNegociadas.IsEmpty Then
      Begin
        Result := objFormasPagto.fValidaFormaPagto(formaPagtoSel);
      End
      Else
      Begin
        blnMudarFoco := False;
        pSetFocus(cxgFormasNegociadas);
      End;
    End
    Else
      Result := objFormasPagto.fValidaFormaPagto(formaPagtoSel);

    If Not Result Then
      cbxModalidades.ItemIndex := -1;
  End

  Else If (Sender = edtValor) Then
  Begin
    If fValidaCampos(cbxModalidades) Then
    Begin
      formaPagtoSel.fltValor := edtValor.Value;
      Result := objFormasPagto.fValidaValorFormaPagto(formaPagtoSel, blnUtilizaCreditoOutrasFormasPagamento);
    End;
  End

  Else If (Sender = edtCodCar) And edtCodCar.Enabled Then
  Begin
    If fValidaCampos(cbxModalidades) Then
    Begin
      formaPagtoSel.dadosCartao.strCodigo := edtCodCar.Text;
      Result := objFormasPagto.fValidaCodigoCartao(formaPagtoSel);
      edtDesCar.Text := formaPagtoSel.dadosCartao.strDescricao;
    End;
  End

  Else If (Sender = edtQtdPar) And (edtQtdPar.Enabled) Then
  Begin
    If fValidaCampos(cbxModalidades) Then
    Begin
      formaPagtoSel.dadosCartao.intQtdParcelas := strToIntDef(edtQtdPar.Text, 0);
      Result := objFormasPagto.fValidaQuantidadeParcelasCartao(formaPagtoSel);
    End;
  End

  Else If (Sender = mskConPag) And (mskConPag.Enabled) Then
  Begin
    If fValidaCampos(cbxModalidades) And fValidaCampos(edtQtdPar) Then
    Begin
      formaPagtoSel.strCondPagamento := mskConPag.Text;
      Result := objFormasPagto.fValidaCondicaoPagamento(formaPagtoSel);
      If Result Then
        mskConPag.Text := formaPagtoSel.strCondPagamento;
    End;
  End

  Else If (Sender = dtaDtaChq) And (dtaDtaChq.Visible) Then
  Begin
    If fValidaCampos(cbxModalidades) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(dtaDtaChq.Text))) And (StrToDateDef(dtaDtaChq.Text, 0) <= VS_Date) Then
      Begin
        fMensagem('', 'A data do vencimento do "Cheque Pré" deve ser maior que a data de hoje caso contrário, use a opção "Cheque À Vista"!', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(dtaDtaChq.Text))  Then
      Begin
        fMensagem('', 'A data do vencimento do "Cheque Pré" deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        formaPagtoSel.dtaDataChqPre := dtaDtaChq.Date;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatFormaPagtoNegociada.pCarregaDescricaoFormasPagto;
  Var
    formaPagto: TFormaPagto;
    strCodCli: String;
begin
  cbxModalidades.Items.Clear;
  strCodCli := objFormasPagto.strCodCliente;
  For formaPagto In objFormasPagto.arrFormasPagamento Do
  Begin
    If (formaPagto.strDescricao = 'UTILIZACAO DE CREDITOS') And (Not fMostraCreditoComPortador(strCodCli)) Then
      Continue;

    cbxModalidades.Items.Add(formaPagto.strDescricao);

    If Not pnlFormasPagamento.Visible Then
      Continue;

    If (objFormasPagto.StatusNegociacao In [snNegociandoFormas, snRealizandoAdiantamento]) Or (blnUtilizaCreditoOutrasFormasPagamento) Then
      If (formaPagto.strCodigo = '013') And (edtTotalCreditos.Value > 0) Then
        cbxModalidades.ItemIndex := cbxModalidades.Items.IndexOf(formaPagto.strDescricao);
  End;
end;

procedure TfrmFatFormaPagtoNegociada.pExibirBotaoUnificarCartoes;
begin
  btnUnificarCartoes.Visible :=
    (objFormasPagto.fGetQuantidadeCartoesNegociados > 1) And
    (objFormasPagto.StatusNegociacao In [snRealizandoRecebimentoF11, snRealizandoAdiantamento]) And
    (fVerificaAcessoSistema('F11UNICAR', objFormasPagto.strCodOperador));
end;

procedure TfrmFatFormaPagtoNegociada.pMostraDataCheque(blnMostrar: Boolean; blnDiaFix: Boolean=False);
begin
  dtaDtaChq.Visible := False;
  lblDtaChq.Visible := False;
  mskConPag.Width   := 330;
  lblConPag.Width   := IIF(blnDiaFix, 570, 460);
  If blnMostrar Then
  Begin
    dtaDtaChq.Visible := True;
    lblDtaChq.Visible := True;
    mskConPag.Width   := 240;
    lblConPag.Width   := 245;
  End;
end;

procedure TfrmFatFormaPagtoNegociada.FormShow(Sender: TObject);
begin
  inherited;
  pOnShowForm;
end;

procedure TfrmFatFormaPagtoNegociada.pOnShowForm;
var
  key: Word;
begin
  inherited;
  intSemaforoRecebimento := -1;
  pnlDadosCondicao.Visible := fCfgSis('USACND', varBoolean);

  edtTotalCreditos.Value := objFormasPagto.fltCreditosCliente;

  If Not fCfgSis('EXICRE', varBoolean) Then
  Begin
    edtDesCndPed.Width       := 497;
    edtTotalCreditos.Visible := False;
    lblTotalCreditos.Visible := False;
  End;

  edtCodCndPed.Text := objFormasPagto.strCodCondPagto;
  edtDesCndPed.Text := fRetDesConPag(objFormasPagto.strCodCondPagto);
  edtConPagPed.Text := fFormataCondPag(objFormasPagto.strCondicaoPagto);

  dtsFormasNegociadas.DataSet := objFormasPagto.cdsFormasNegociadas;
  pCarregaDescricaoFormasPagto;
  pExibirBotaoUnificarCartoes;
  pAtualizaCampos;
  pAtualizaTotais;
  blnConfirma := False;

  cxgFormasNegociadasViewFPGREC.Visible := objFormasPagto.fTemFormaPagtoComRecebimento;
  cxgFormasNegociadasViewVALREC.Visible := objFormasPagto.fTemFormaPagtoComRecebimento;
  cxgFormasNegociadasViewVALANT.Visible := objFormasPagto.fTemFormaPagtoJaRecebidaParc;
  cxgFormasNegociadasViewVALFPG.Caption := 'Valor';

  If objFormasPagto.StatusNegociacao In [snRealizandoRecebimentoF11] Then
  Begin
    pnlDadosCondicao.Visible   := False;
    pnlFormasPagamento.Visible := False;
  End;

  If objFormasPagto.StatusNegociacao In [snRealizandoAdiantamento] Then
  Begin
    pnlDadosCondicao.Visible   := Not fCfgSis('SFPGPD', VarBoolean);
    pnlFormasPagamento.Visible := Not fCfgSis('SFPGPD', VarBoolean);
  End;

  If Not pnlDadosCondicao.Visible Then
    Self.Height := Self.Height - pnlDadosCondicao.Height;

  If Not pnlFormasPagamento.Visible Then
    Self.Height := Self.Height - pnlFormasPagamento.Height;

  If objFormasPagto.StatusNegociacao In [snRealizandoRecebimentoF11, snRealizandoAdiantamento] Then
  Begin
    cxgFormasNegociadasViewFPGREC.Visible := True;
    cxgFormasNegociadasViewVALREC.Visible := True;
    cxgFormasNegociadasViewVALFPG.Caption := 'Valor Negociado';

    lblValDig.Caption  := ' Valor Recebido: ';

    If objFormasPagto.StatusNegociacao In [snRealizandoRecebimentoF11] Then
      lblInfGrid.Caption := ''
    Else If Not pnlFormasPagamento.Visible Then
      lblInfGrid.Caption := ''
    Else
      lblInfGrid.Caption := lblInfGrid.Caption + #13#10;

    lblInfGrid.Caption := lblInfGrid.Caption +
      'Pressione [Enter] sobre a forma de pagamento para realizar o recebimento';

    cxgFormasNegociadasView.Bands[0].Caption := 'RECEBIMENTO DAS FORMAS DE PAGAMENTO NEGOCIADAS';
  End;

  If Not objFormasPagto.cdsFormasNegociadas.IsEmpty Then
  Begin
    cbxModalidades.ItemIndex := -1;
    If (objFormasPagto.blnAdiantamentoPedido) And
       (objFormasPagto.StatusNegociacao = snNegociandoFormas) Then
      pSetFocus(btnConfirma)
    Else
      pSetFocus(cxgFormasNegociadas);


    key := VK_RETURN;
    objFormasPagto.cdsFormasNegociadas.First;
    while not objFormasPagto.cdsFormasNegociadas.Eof do
    begin
      if (fCfgSis('USAGRY') = 'S') and
         (objFormasPagto.cdsFormasNegociadas.FieldByName('CODCAR').AsString = fCfgSis('CARGRY')) then
        cxgFormasNegociadasViewKeyDown(Self, key, [ssShift]);

      objFormasPagto.cdsFormasNegociadas.Next;
    end;
  End;
end;

procedure TfrmFatFormaPagtoNegociada.pReceberFormaPagto;
begin
  With objFormasPagto Do
  Begin
    If StatusNegociacao In [snRealizandoRecebimentoF11, snRealizandoAdiantamento] Then
    Begin
      If InterlockedIncrement(intSemaforoRecebimento) = 0 Then
      Begin
        Try
          TfrmGravando.fExecutarModal(pRealizarRecebimento,
            'Aguarde, Realizando Recebimento (' +
              cdsFormasNegociadas.FieldByName('DESFPG').AsString + ')...', '');
          pAtualizaTotais;
        Finally
          InterlockedDecrement(intSemaforoRecebimento);
          SetForegroundWindow(Self.Handle);
        End;
      End
      Else
        InterlockedDecrement(intSemaforoRecebimento);
    End;
  End;
end;

function TfrmFatFormaPagtoNegociada.fTravarMaximoParcelas(blnShowMsg: Boolean = False):Boolean;
var
  intRecNo: Integer;
  intSoma: Integer;
  strConPag: String;
  stlConPag: TStringList;
begin
  Result := False;

  If (Not Assigned(objFormasPagto.cdsFormasNegociadas)) Or
     (Not objFormasPagto.cdsFormasNegociadas.Active) Or
     (objFormasPagto.cdsFormasNegociadas.RecordCount = 0) Then
    Exit;

  intSoma := 0;
  intRecNo := objFormasPagto.cdsFormasNegociadas.RecNo;
  objFormasPagto.cdsFormasNegociadas.DisableControls;

  stlConPag := TStringList.Create;

  Try
    objFormasPagto.cdsFormasNegociadas.First;
    While (Not objFormasPagto.cdsFormasNegociadas.Eof) Do
    Begin
      strConPag := objFormasPagto.cdsFormasNegociadas.FieldByName('CONPAG').AsString;

      If (Not fEmptyStr(strConPag)) Then
      Begin
        If (stlConPag.IndexOf(strConPag) = -1) Then
        Begin
          stlConPag.Add(strConPag);

          strConPag := Copy(strConPag, 1, 2);
          intSoma := intSoma + StrToIntDef(strConPag, 0);
        End;
      End;

      objFormasPagto.cdsFormasNegociadas.Next;
    End;

    If (intSoma > 24) Then
    Begin
      Result := True;
      If blnShowMsg Then
        fMensagem('', 'As formas de pagamento selecionadas somam ' + FormatFloat('00', intSoma) + ' parcelas.'+ #10+#13 +
                      ' O máximo de parcelas permitidas é 24.', ['&Ok']);

    End;
  Finally
    objFormasPagto.cdsFormasNegociadas.RecNo := intRecNo;
    objFormasPagto.cdsFormasNegociadas.EnableControls;

    FreeAndNil(stlConPag);
  End;
end;

procedure TfrmFatFormaPagtoNegociada.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (fTravarMaximoParcelas(True)) Then
    Exit;

  If blnUtilizaCreditoOutrasFormasPagamento Then
  Begin
    blnConfirma := True;
    Self.Close;
    Exit;
  End;

  If Not objFormasPagto.fConfirmarFormasPagamento Then
  Begin
    If pnlFormasPagamento.Visible Then
      pSetFocus(cbxModalidades)
    Else
      pSetFocus(cxgFormasNegociadas);
  End
  Else
  Begin
    blnConfirma := True;
    Self.Close;
  End;
end;

procedure TfrmFatFormaPagtoNegociada.pAtualizaTotais;
begin
  edtValVen.Value  := objFormasPagto.fltTotalVenda;

  If (objFormasPagto.StatusNegociacao In [snRealizandoRecebimentoF11, snRealizandoAdiantamento]) Then
  Begin
    edtValDig.Value  := objFormasPagto.fltValorRecebido;
    edtValRes.Value  := objFormasPagto.fltValorRestanteReceber;
  End
  Else
  Begin
    edtValDig.Value  := objFormasPagto.fltTotalFormasPagto;
    edtValRes.Value  := objFormasPagto.fltValorRestante;
  End;

  pnlTroco.Height  := 0;

  If (objFormasPagto.fltValorTroco > 0) And
     (objFormasPagto.StatusNegociacao In [snRealizandoRecebimentoF11, snRealizandoAdiantamento]) Then
  Begin
    pnlTroco.Caption := 'VALOR DO TROCO: ' + FormatFloat('#,##0.00', objFormasPagto.fltValorTroco);
    pnlTroco.Height  := 30;
  End;

end;

procedure TfrmFatFormaPagtoNegociada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma And objFormasPagto.blnAdiantamentoPedido Then
  Begin
    If Not fPergunta('Deseja realmente cancelar?', False) Then
      Action := caNone;
  End;
end;

procedure TfrmFatFormaPagtoNegociada.FormCreate(Sender: TObject);
begin
  inherited;
  mskConPag.EditMask := MASK_CONPAG;
  blnUtilizaCreditoOutrasFormasPagamento := False;
end;

procedure TfrmFatFormaPagtoNegociada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key Of
    VK_F3:
      Begin
        Key := 0;
        btnUnificarCartoes.Click;
      End;
    VK_F10:
      Begin
        Key := 0;
        btnConfirma.Click;
      End;
  end;
end;

end.
