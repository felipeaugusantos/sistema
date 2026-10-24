unit untDigEmailPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untSalvaDadosInterface, untTEditFocusWithTConsultasArray, Uni, untOpcoesExcelPedCompra, untTLayoutPedidoCompra,
  untOpcPdfPedidoCompra, untTypesSistema, TypesLayoutPedidoCompra;

type
  TTipoExportacao = (teEmail,teExcel, tePDF, teLayout);


  TfrmDigEmailPedidoCompra = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlInfos: TPanel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
     blnGeracaoApenasXLS: Boolean;
     objSalvaFiltros: TSalvaInterface;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    optCodigo: String;
    fraOpcPdfPedidoCompra: TfraOpcPdfPedidoCompra;
    class procedure pChamaConfiguracaoEnvioAutoticoEmail(optCodigo: String);
  end;

var
  frmDigEmailPedidoCompra: TfrmDigEmailPedidoCompra;

implementation

uses  untfuncoesSimples, untConstantes;

{$R *.dfm}

function TfrmDigEmailPedidoCompra.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Sender.Parent = fraOpcPdfPedidoCompra then
    Result := fraOpcPdfPedidoCompra.fValidaCamposFrame(Sender, blnBuscaPorChave);
end;


procedure TfrmDigEmailPedidoCompra.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If blnGeracaoApenasXLS Or (optCodigo <> '') then
  begin
    Close;
    ModalResult := mrOk;
    Exit;
  End;

  If fraOpcPdfPedidoCompra.edtTipExp.Text = 'P' Then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := 'PDF'
  Else
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := 'XLS';



  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre := Not (fraOpcPdfPedidoCompra.chkPreco.Checked);
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnOrdDig := True;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp := (fraOpcPdfPedidoCompra.chkMltCmp.Checked);
//  fraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdVias := StrToInt(edtQtVias.Text);
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := '';
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmail := fraOpcPdfPedidoCompra.edtEmail.Text;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strContato := fraOpcPdfPedidoCompra.edtContato.Text;

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre := Not fraOpcPdfPedidoCompra.chkPreco.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpObs := fraOpcPdfPedidoCompra.chkImpObs.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp := fraOpcPdfPedidoCompra.chkMltCmp.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar := fraOpcPdfPedidoCompra.chkMarca.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab := fraOpcPdfPedidoCompra.chkCodFab.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.chrOrdDig := fraOpcPdfPedidoCompra.fGetCharOrdem;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOrient := fraOpcPdfPedidoCompra.rdgOrientacao.ItemIndex;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnLocFis := fraOpcPdfPedidoCompra.chkLocFis.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodbar := fraOpcPdfPedidoCompra.chkcodBarras.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpRef := fraOpcPdfPedidoCompra.chkImpReferencia.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpDtaVen := fraOpcPdfPedidoCompra.chkImpVen.Checked;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnGerPDF := fraOpcPdfPedidoCompra.RecOpcaoImpressao.OperacaoTela in [totEmail];
  Case fraOpcPdfPedidoCompra.rdgQuantidade.ItemIndex Of
    0: TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpCompleto;
    1: TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpPendente;
    2: TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpNaoExibir;
  End;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel :=  fraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel;
  If fraOpcPdfPedidoCompra.edtTipExp.Visible And fraOpcPdfPedidoCompra.edtTipExp.Enabled Then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := IIf(fraOpcPdfPedidoCompra.edtTipExp.Text = 'P', 'PDF','XLS');
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := '';
  If (fraOpcPdfPedidoCompra.cbxModeloPedido.Text <> cPedidoCompraPadraoSemEditor) And
     (fraOpcPdfPedidoCompra.edtTipExp.Text = 'P') Then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay := TLayoutPedidoCompra(fraOpcPdfPedidoCompra.cbxModeloPedido.Items.Objects[fraOpcPdfPedidoCompra.cbxModeloPedido.ItemIndex]).fCodLay;



  If (fVerificaCampos) Then
//     (blnSomentePDF Or ((TfraOpcPdfPedidoCompra.RecOpcaoImpressao.OperacaoTela = totEmail) And (fMensagem('', 'Enviar e-mail?', ['&Sim', '&Não']) = 1))) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigEmailPedidoCompra.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  arrCampos: TArrString;
  strChave, strOperador: String;
begin
  inherited;

  arrCampos := ['chkMarca',
                'chkLocFis', 'chkCodFab', 'chkImpObs', 'chkCodbarras', 'ChkImpReferencia',
                'rdgQuantidade', 'chkMltCmp', 'rdgOrientacao', 'edtPreco', 'edtOrdem',
                'edtTipExp','edtCodLay', 'chkImpVen'];

  strChave := '';
  strOperador := strLoginUsuarioLogado;
  If optCodigo <> '' Then
  Begin
    strChave := fMontaChaveEnvioAutomaticoEmail(optCodigo, VS_strCodEmp);
    arrCampos := [];
    strOperador := '';
  End;

  objSalvaFiltros.fAtualizaDados;
  objSalvaFiltros.fSalvaDados(strChave, 'frmDigEmailPedidoCompra', strOperador, True, arrCampos);

  FreeAndNil(objSalvaFiltros);
end;

procedure TfrmDigEmailPedidoCompra.FormCreate(Sender: TObject);
begin
  fraOpcPdfPedidoCompra := TfraOpcPdfPedidoCompra.Create(Self);
  fraOpcPdfPedidoCompra.pAncoraPainel(Self, pnlInfos, ttoConsulta);
  fraOpcPdfPedidoCompra.Left     := 7;
  fraOpcPdfPedidoCompra.TabOrder := 2;
  inherited;
  optCodigo := '';
  blnGeracaoApenasXLS := False;
  fraOpcPdfPedidoCompra.blnSomentePDF := False;


  fraOpcPdfPedidoCompra.chkMltCmp.Enabled := (fCfgSis('CNVEMB') <> 'N');

  objSalvaFiltros := TSalvaInterface.Create(Self);
  objSalvaFiltros.pSetFrame(fraOpcPdfPedidoCompra);
end;

procedure TfrmDigEmailPedidoCompra.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fraOpcPdfPedidoCompra);
  inherited;

end;

procedure TfrmDigEmailPedidoCompra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 SelectNext(ActiveControl,true,true);
  End;
end;

procedure TfrmDigEmailPedidoCompra.FormShow(Sender: TObject);
  var
    strChave, strOperador: String;
begin
  inherited;
  strChave := '';
  strOperador := strLoginUsuarioLogado;
  If optCodigo <> '' Then
  Begin
    strChave := fMontaChaveEnvioAutomaticoEmail(optCodigo, VS_strCodEmp);
    frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pSetAjustaTela(totEmail);
    strOperador := '';
    If objSalvaFiltros.fCarregaDados(strChave,  Self, 'frmDigEmailPedidoCompra', strOperador, True, False) Then
      objSalvaFiltros.fAtualizaDados;
  End
  Else
  Begin
    If objSalvaFiltros.fCarregaDados(strChave,  Self, 'frmDigEmailPedidoCompra', strOperador, True, False) Then
    Begin
      If frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem = opioXls Then
      Begin
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.edtTipExp.Text := 'E';
      End
      Else if frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem = opioPdf Then
      Begin
        frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.edtTipExp.Text := 'P';
      End;

      frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pAjustacbxModeloPedido;
      objSalvaFiltros.fAtualizaDados;
    End;
  End;
end;

class procedure TfrmDigEmailPedidoCompra.pChamaConfiguracaoEnvioAutoticoEmail(
  optCodigo: String);
begin
  pCriarFormularios(TfrmDigEmailPedidoCompra, frmDigEmailPedidoCompra);
  Try
    frmDigEmailPedidoCompra.optCodigo := optCodigo;
    frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.pnlEmail.Visible := False;
    frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.gbExporta.Visible := True;
    frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem := opioEmail;
    frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.RecOpcaoImpressao.OperacaoTela := totEmail;
    frmDigEmailPedidoCompra.fraOpcPdfPedidoCompra.blnSomentePDF          := False;
    frmDigEmailPedidoCompra.ShowModal;

  Finally
    FreeAndNil(frmDigEmailPedidoCompra)
  End;
end;

end.

