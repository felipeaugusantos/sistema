unit untPedeUnificacaoPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, cxCurrencyEdit, EditFocus, untFuncoesSimples, untFuncoesConsulta,
  untTypesSistema, untConsultas, untUnificacaoPedidos, dxScreenTip,
  dxCustomHint, cxHint, cxMaskEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPedeUnificacaoPedidos = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    pnlFiltros: TPanel;
    cxggItensLevel1: TcxGridLevel;
    cxgItens: TcxGridDBTableViewCitel;
    cxggItens: TcxGridCitel;
    cxgItensNUMPED: TcxGridDBColumn;
    cxgItensEMPORI: TcxGridDBColumn;
    cxgItensEMPDES: TcxGridDBColumn;
    cxgItensDTAPED: TcxGridDBColumn;
    cxgItensDTAENT: TcxGridDBColumn;
    cxgItensCONPAG: TcxGridDBColumn;
    cxgItensTOTITE: TcxGridDBColumn;
    cxgItensTOTIPI: TcxGridDBColumn;
    cxgItensTOTCBS: TcxGridDBColumn;
    cxgItensTOTIBS: TcxGridDBColumn;
    cxgItensTOT_IS: TcxGridDBColumn;
    cxgItensTOTSUB: TcxGridDBColumn;
    cxgItensTOTGER: TcxGridDBColumn;
    Label3: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lbl1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnAlterar: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgItensAUTINC: TcxGridDBColumn;
    Panel1: TPanel;
    Panel2: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    cxgItensNOTAS: TcxGridDBColumn;
    Shape3: TShape;
    Label8: TLabel;
    cxgItensQTD_BAIPED: TcxGridDBColumn;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpEnter(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    arrFornec: TConsultasArray;
    arrEmpresa: TConsultasArray;
  public
    { Public declarations }
    objUnificacao: TUnificacaoPedidos;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

{$R *.dfm}

procedure TfrmPedeUnificacaoPedidos.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    If objUnificacao.fCarregaPedidos(edtCodFor.Text, edtCodEmp.Text) Then
    Begin
      pSetFocus(cxggItens);
    End;
end;

procedure TfrmPedeUnificacaoPedidos.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  cxgItensTOTGER.Width := cxgItensTOTGER.Width + 1;
  objUnificacao.pMarcaTodos(False);
  cxgItensTOTGER.Width := cxgItensTOTGER.Width - 1;
end;

procedure TfrmPedeUnificacaoPedidos.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not objUnificacao.fPedidosSelecionados Then
  Begin
    pMensagemOk('Selecione 2 ou mais pedidos para a unificação!');
    Exit;
  End;

  If objUnificacao.fUnificaPedidos Then
  Begin
    btnAlterar.Click;
  End;
end;

procedure TfrmPedeUnificacaoPedidos.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  cxgItensTOTGER.Width := cxgItensTOTGER.Width + 1;
  objUnificacao.pMarcaTodos(True);
  cxgItensTOTGER.Width := cxgItensTOTGER.Width - 1;
end;

procedure TfrmPedeUnificacaoPedidos.btnMarDesClick(Sender: TObject);
begin
  inherited;

  cxgItensTOTGER.Width := cxgItensTOTGER.Width + 1;
  objUnificacao.pMarcaDesmarca;
  cxgItensTOTGER.Width := cxgItensTOTGER.Width - 1;
end;

procedure TfrmPedeUnificacaoPedidos.cxgItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If objUnificacao.fInList(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensAUTINC.Index])) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End

  Else If (Not fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensNOTAS.Index]))) Or
          (StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTD_BAIPED.Index]), 0) > 0) Then
  Begin
    ACanvas.Brush.Color := clSilver;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;

  End;
end;

procedure TfrmPedeUnificacaoPedidos.cxgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnMarDes.Click;
  End;
end;

procedure TfrmPedeUnificacaoPedidos.edtCodEmpEnter(Sender: TObject);
begin
  inherited;

  HintControler.ShowHint(Self.Left + edtCodEmp.Left,
                         Self.Top + edtCodEmp.Top + 30, '',
     'Informe a empresa destino dos pedidos multi-loja já desmembrados ou em branco para carregar todos os pedidos não multi-loja.');
end;

procedure TfrmPedeUnificacaoPedidos.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');

  If fEmptyStr(edtCodEmp.Text) Then
    edtNomEmp.Clear;

  HintControler.HideHint;
end;

procedure TfrmPedeUnificacaoPedidos.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPedeUnificacaoPedidos.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmPedeUnificacaoPedidos.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPedeUnificacaoPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarcaTodos.Click;
    VK_F10: btnGravar.Click;
  End;

end;

procedure TfrmPedeUnificacaoPedidos.FormShow(Sender: TObject);
begin
  inherited;

  cxgItensTOTCBS.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
  cxgItensTOTIBS.Visible := cxgItensTOTCBS.Visible;
  cxgItensTOT_IS.Visible := cxgItensTOTCBS.Visible;

  pSetFocus(edtCodFor);
end;

function TfrmPedeUnificacaoPedidos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin


    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
