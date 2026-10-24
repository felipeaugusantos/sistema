unit untPedidoCompraImpr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, QColorLabel,
  EditFocus, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Uni, Data.DB, ComboBoxFocus, untSalvaDadosInterface, untTEditFocusWithTConsultasArray,
  untConfiguraImpressaoPedidoCompra, untOpcoesExcelPedCompra,
  untTypesSistema, untTLayoutPedidoCompra, untOpcPdfPedidoCompra, TypesLayoutPedidoCompra;

type
   TfrmPedidoCompraImpr = class(TfrmPai)
    pnlHeader: TPanel;
    btnConfirmar: TBitBtnLocked;
    pnlInfos: TPanel;
    Panel1: TPanel;
    gbImprimir: TGroupBox;
    ColorLabel1: TColorLabel;
    lblQtVias: TLabel;
    edtImprimir: TEditFocus;
    edtQtVias: TEditFocus;
    gpbOrdCar: TGroupBox;
    ColorLabel12: TColorLabel;
    Label1: TLabel;
    edtImpOrd: TEditFocus;
    edtQtdViaOrd: TEditFocus;
    gpbOpcao: TGroupBox;
    cmbOpcao: TComboBoxFocus;
    btnOpcoesExcel: TBitBtnLocked;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbOpcaoChange(Sender: TObject);
    procedure pEnabledDisableCampos;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbOpcaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOpcoesExcelClick(Sender: TObject);
    procedure cbxLayoutChange(Sender: TObject);
  private
    { Private declarations }

    objSalvaFiltros: TSalvaInterface;


    procedure pMontaOpcoesImpressao;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    objImpressaoRel: TConfiguraImpressaoPedidoCompra;
    fraOpcPdfPedidoCompra: TfraOpcPdfPedidoCompra;



  end;

var
  frmPedidoCompraImpr: TfrmPedidoCompraImpr;


implementation

uses untfuncoesSimples,untCfgRel,  untConsultas, untConstantes;

{$R *.dfm}

function TfrmPedidoCompraImpr.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    strNomImp, strTipImp: String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {****************************}
    {* VERIFICA CAMPO IMPRIMIR  *}
    {*************************LU*}
    If (Sender = edtImprimir) Then
    Begin
      If (edtImprimir.Text <> 'S') And (edtImprimir.Text <> 'N') Then
      Begin
        fMensagem('ATENÇÃO!','O campo Imprimir deve ser S ou N.',['&O K']);
        Result := False;
      End;
      pEnabledDisableCampos;
      edtQtVias.Enabled            := (edtImprimir.Text = 'S');
      //edtMltCmp.Enabled            := (edtImprimir.Text = 'S');
      //edtPreco.Enabled             := (edtImprimir.Text = 'S');
      cmbOpcao.Enabled             := (edtImprimir.Text = 'S');
    End

    {****************************}
    {* VERIFICA CAMPO PREÇO     *}
    {*************************LU*}
{    Else If (Sender = edtPreco) Then
    Begin
      If (edtPreco.Text <> 'C') And (edtPreco.Text <> 'S') Then
      Begin
        fMensagem('','O campo Preço deve ser C ou S.',['&O K']);
        Result := False;
      End;
    End
}

    {****************************}
    {* VERIFICA QTDE. DE VIAS   *}
    {*************************IV*}
    Else If (Sender = edtQtVias) Then
    Begin
      If (StrToInt(edtQtVias.Text) <= 0) And (edtQtVias.Enabled) Then
      Begin
        fMensagem('','A Quantidade de Vias deve ser maior que 0 (zero)!.',['&O K']);
        Result := False;
      End;
    End

    {***************************************************}
    {* VERIFICA QTDE. DE VIAS DE ORDEM DE CARREGAMENTO *}
    {************************************************PZ*}
    Else If (Sender = edtQtdViaOrd) Then
    Begin
      If (StrToIntDef(edtQtdViaOrd.Text, 0) <= 0) Then
      Begin
        fMensagem('','A Quantidade de Vias de Ordem de Carregamento deve ser maior que 0 (zero)!.',['&O K']);
        Result := False;
      End;
    End

    {****************************}
    {* VERIFICA CAMPO OPÇÃO     *}
    {*************************LU*}
    Else
    If (Sender = cmbOpcao) Then
    Begin
      If (gpbOpcao.Visible) Then
      Begin

        If (cmbOpcao.Text = 'Impressora Paisagem') Then
        Begin
          pCarregaConfImprRel('frmPedidoDeCompra', strNomImp, strTipImp);

          If strTipImp = 'M' Then
          Begin
            Result := False;
            pMensagemOk('Para utilizar a impressão como paisagem configure a fila do relatório (frmPedidoDeCompra) como Jato de Tinta!');
          End;

        End;

      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmPedidoCompraImpr.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao := 1;

  If edtImprimir.Text = 'S' Then
  Begin
    If Not fVerificaCampos Then
      Exit;

    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImprime := True;

    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre := Not (fraOpcPdfPedidoCompra.chkPreco.Checked);
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnOrdDig := True;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp := (fraOpcPdfPedidoCompra.chkMltCmp.Checked);
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdVias := StrToInt(edtQtVias.Text);
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := '';
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail := fraOpcPdfPedidoCompra.edtEmail.Text;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.strContato := fraOpcPdfPedidoCompra.edtContato.Text;

    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre := Not fraOpcPdfPedidoCompra.chkPreco.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpObs := fraOpcPdfPedidoCompra.chkImpObs.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp := fraOpcPdfPedidoCompra.chkMltCmp.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar := fraOpcPdfPedidoCompra.chkMarca.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab := fraOpcPdfPedidoCompra.chkCodFab.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.chrOrdDig := fraOpcPdfPedidoCompra.fGetCharOrdem;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOrient := fraOpcPdfPedidoCompra.rdgOrientacao.ItemIndex;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpDtaVen  := fraOpcPdfPedidoCompra.chkImpVen.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnLocFis := fraOpcPdfPedidoCompra.chkLocFis.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodbar := fraOpcPdfPedidoCompra.chkcodBarras.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpRef := fraOpcPdfPedidoCompra.chkImpReferencia.Checked;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnGerPDF := fraOpcPdfPedidoCompra.RecOpcaoImpressao.OperacaoTela in [totEmail];
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoMarca := False;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoReferencia := False;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoGrupo := False;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoUnidade := False;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoAcordoObjetivo := False;
    If fraOpcPdfPedidoCompra.pnlResumo.Visible Then
    Begin
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoMarca := fraOpcPdfPedidoCompra.chkResumoMarca.Checked;
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoReferencia := fraOpcPdfPedidoCompra.chkResumoReferencia.Checked;
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoGrupo := fraOpcPdfPedidoCompra.chkResumoGrupo.Checked;
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoUnidade := fraOpcPdfPedidoCompra.chkResumoUnidade.Checked;
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnResumoAcordoObjetivo := fraOpcPdfPedidoCompra.chkResumoAcordoObjetivo.Checked;
    End;


    Case fraOpcPdfPedidoCompra.rdgQuantidade.ItemIndex Of
      0: fraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpCompleto;
      1: fraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpPendente;
      2: fraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpNaoExibir;
    End;
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel :=  fraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel;
    If fraOpcPdfPedidoCompra.edtTipExp.Visible And fraOpcPdfPedidoCompra.edtTipExp.Enabled Then
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := IIf(fraOpcPdfPedidoCompra.edtTipExp.Text = 'P', 'PDF','XLS');
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := '';
    If (cmbOpcao.Text = cPedidoCompraEditor) Or (cmbOpcao.Text = cEmail)  Then
      If (fraOpcPdfPedidoCompra.cbxModeloPedido.Text <> cPedidoCompraPadraoSemEditor) Then
        If fraOpcPdfPedidoCompra.cbxModeloPedido.Enabled Then
          fraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := TLayoutPedidoCompra(fraOpcPdfPedidoCompra.cbxModeloPedido.Items.Objects[fraOpcPdfPedidoCompra.cbxModeloPedido.ItemIndex]).fCodLay;
    If cmbOpcao.Text = cPedidoCompraEditor Then
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao  := 1
    Else If cmbOpcao.Text = cBoletimRecebimento Then
    Begin
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao  := 4;

      If (fraOpcPdfPedidoCompra.cbxModeloBoletim.ItemIndex = 0) Then
         fraOpcPdfPedidoCompra.RecOpcaoImpressao.TipoBoletim := tobrPadrao
      Else
      Begin
        If (fraOpcPdfPedidoCompra.rdgOrientacao.ItemIndex = 0) Then
          fraOpcPdfPedidoCompra.RecOpcaoImpressao.TipoBoletim := tobrRetrato
        Else
          fraOpcPdfPedidoCompra.RecOpcaoImpressao.TipoBoletim := tobrPaisagem;
      End;
    End
    Else If cmbOpcao.Text = cEmail Then
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao  := 13
    Else If cmbOpcao.Text = cExcel Then
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao  := 17 //A opção 17 se refere a geração do arquivo Excel
    Else If cmbOpcao.Text = cTigreExcel Then
      fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao  := 19
    Else If cmbOpcao.Text = cPDF Then
    begin

      If (fraOpcPdfPedidoCompra.cbxModeloPedido.Text <> cPedidoCompraPadraoSemEditor) Then
        If fraOpcPdfPedidoCompra.cbxModeloPedido.Enabled Then
          fraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := TLayoutPedidoCompra(fraOpcPdfPedidoCompra.cbxModeloPedido.Items.Objects[fraOpcPdfPedidoCompra.cbxModeloPedido.ItemIndex]).fCodLay;

      fraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao := 20;
    end;

  End
  Else
    fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImprime := False;

  fraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpOrd := (edtImpOrd.Text = 'S');
  fraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdOrd := StrToInt(edtQtdViaOrd.Text);


  objImpressaoRel.intIndice := cmbOpcao.ItemIndex;

  Close;
end;

procedure TfrmPedidoCompraImpr.btnOpcoesExcelClick(Sender: TObject);
begin
  inherited;
  fraOpcPdfPedidoCompra.pCarregaSelecaoExcel(True);
end;

procedure TfrmPedidoCompraImpr.cbxLayoutChange(Sender: TObject);
begin


//  Position := poMainFormCenter;
end;

procedure TfrmPedidoCompraImpr.cmbOpcaoChange(Sender: TObject);
var OperacaoTela: TOperacaoTela;
begin
  inherited;
  btnOpcoesExcel.Visible := False;

  fraOpcPdfPedidoCompra.cbxModeloPedido.Enabled := True;

  If cmbOpcao.Text = cExcel Then
  Begin
    btnOpcoesExcel.Visible := True;
    fraOpcPdfPedidoCompra.pCarregaSelecaoExcel(False);
  End;
  OperacaoTela := totIndefinido;
  If cmbOpcao.Text = cEmail then
    OperacaoTela := totEmail;
  If cmbOpcao.Text = cPedidoCompraEditor then
    OperacaoTela := totPdLayout;
  If cmbOpcao.Text =  cExcel then
    OperacaoTela := totExcel;
  If cmbOpcao.Text =  cPDF then
    OperacaoTela := totPDF;
  If cmbOpcao.Text =  cBoletimRecebimento then
    OperacaoTela := totBoletimRecebimento;

  fraOpcPdfPedidoCompra.pSetAjustaTela(OperacaoTela);




{
  fraOpcPdfPedidoCompra.btnOpcoesExcel.Visible := (cmbOpcao.Text = 'Excel');

  fraOpcPdfPedidoCompra.btnOpcoesExcel.Visible := (cmbOpcao.Text = 'Excel');
  fraOpcPdfPedidoCompra.cbxLayout.OnChange(Nil);

  pEnabledDisableCampos;
}

end;

procedure TfrmPedidoCompraImpr.pEnabledDisableCampos;
  procedure pEnabledDisableFilhos(cntControl : TWinControl);
    Var
      intCorre : Integer;
  Begin
    For intCorre := 0 to cntControl.ControlCount - 1 do
      cntControl.Controls[intCorre].Enabled := cntControl.Enabled;
  end;

begin
  gpbOpcao.Enabled       := (edtImprimir.Text = 'S');
  edtQtVias.Enabled      := (edtImprimir.Text = 'S');
  //grbMltCmp.Enabled      := (edtImprimir.Text = 'S');
  gpbOrdCar.Enabled      := (cmbOpcao.Text = cPedidoCompraEditor) Or
                            (cmbOpcao.Text = 'Boletim de Recebimento');

  {
  If (SameText(cmbOpcao.Text, cPedidoCompraEditor)) Then
  Begin
    gpbOpcao.Width := 555;
    fraOpcPdfPedidoCompra.cbxLayout.Visible := True;
    //lblLayout.Visible := True;
    grbMltCmp.Enabled := True;
  End
  Else
  Begin
    gpbOpcao.Width := 272;
    fraOpcPdfPedidoCompra.cbxLayout.Visible := False;
//    lblLayout.Visible := False;
    grbMltCmp.Enabled := False;

  End;       }
  //gbPreco.Enabled       := (cmbOpcao.Text = 'Excel') OR  (SameText(cmbOpcao.Text, cPedidoCompraEditor));

  pEnabledDisableFilhos(gpbOpcao);
//  pEnabledDisableFilhos(grbMltCmp);
//  pEnabledDisableFilhos(gbPreco);
  pEnabledDisableFilhos(gpbOrdCar);


end;


procedure TfrmPedidoCompraImpr.cmbOpcaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) And
     (Pos(cmbOpcao.Text, '_Impressora Retrato_Coral-TXT_') < 1) Then
     pSetFocus(btnConfirmar)

end;


procedure TfrmPedidoCompraImpr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  objSalvaFiltros.fAtualizaDados;
  objSalvaFiltros.fSalvaDados('', 'frmPedidoCompraImpr_Novo', strLoginUsuarioLogado, True, nil);

  FreeAndNil(objSalvaFiltros);

end;

procedure TfrmPedidoCompraImpr.FormCreate(Sender: TObject);
begin
  fraOpcPdfPedidoCompra := TfraOpcPdfPedidoCompra.Create(Self);
  fraOpcPdfPedidoCompra.pAncoraPainel(Self, pnlInfos, ttoImpPedido);
  fraOpcPdfPedidoCompra.Left     := 7;
  fraOpcPdfPedidoCompra.TabOrder := 2;
  fraOpcPdfPedidoCompra.gbExporta.Visible := False;

  inherited;


  objSalvaFiltros := TSalvaInterface.Create(Self);
  objSalvaFiltros.pSetFrame(fraOpcPdfPedidoCompra);

  objImpressaoRel := Nil;
end;

procedure TfrmPedidoCompraImpr.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: If (ActiveControl Is TRadioButton) Or
                  (ActiveControl Is TComboBox) Then
                 pEscapePressed;

  End;

end;

procedure TfrmPedidoCompraImpr.FormShow(Sender: TObject);
begin
  inherited;


  pMontaOpcoesImpressao;

  If objSalvaFiltros.fCarregaDados('', Self, 'frmPedidoCompraImpr_Novo', strLoginUsuarioLogado, True, False) Then
  Begin
    objSalvaFiltros.fAtualizaDados;
    cmbOpcao.OnChange(Nil);
  End;
  fraOpcPdfPedidoCompra.cbxModeloPedido.OnChange(Nil);
  pSetFocus(edtImprimir);
end;

procedure TfrmPedidoCompraImpr.pMontaOpcoesImpressao;
  Var
    strOpcoes: TStringList;
    intContador: Integer;
Begin
  cmbOpcao.Items.Clear;
  cmbOpcao.Items.Add(cPedidoCompraEditor);
  cmbOpcao.Items.Add(cBoletimRecebimento);
  cmbOpcao.Items.Add(cEMail);
  cmbOpcao.Items.Add(cExcel);
  cmbOpcao.Items.Add(cPDF);

  If fCfgSis('USATMQ') = 'S' Then
    cmbOpcao.Items.Add(cTigreExcel);

  strOpcoes := TStringList.Create;
  strOpcoes.Sorted := True;

  objImpressaoRel.fCarregaOpcoesImpressao(cmbOpcao.Items.Count, strOpcoes);

  For intContador := 0 To strOpcoes.Count - 1 Do
    cmbOpcao.Items.Add(strOpcoes[intContador]);

  cmbOpcao.ItemIndex := 0;

  FreeAndNil(strOpcoes);
End;


end.

