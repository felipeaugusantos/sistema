unit untDigDespesasFaturamento;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Windows,
  ExtCtrls, EditFocus, QColorLabel, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  Grids, DBGridCitel, DBGrids, DB, DBClient, untDespesasFaturamento, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigDespesasFaturamento = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    dtsDespesas: TDataSource;
    btnCancelaDados: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    lbl1: TLabel;
    edtCodigo: TEditFocus;
    edtDescricao: TEditFocus;
    dbgDespesas: TDBGridCitel;
    edtQuantidade: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtValorUnitario: TEditFocus;
    Label3: TLabel;
    edtValorTotal: TEditFocus;
    Panel1: TPanel;
    Label7: TLabel;
    edtTotalDespesas: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgDespesasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoChange(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    objDespesa: TDespesaFaturamento;
    procedure plimpaDadosDespesa(blnClearCodigo: Boolean = True);
    procedure pAtualizaTotal;
  public
    objDespesasFaturamento: TDespesasFaturamento;
    blnConfirma: Boolean;
  end;

var
  frmDigDespesasFaturamento: TfrmDigDespesasFaturamento;

implementation

uses untConsultas, untfuncoesSimples, untFuncoesAutocenter, untConstantes,
  untTypesSistema;

{$R *.dfm}

procedure TfrmDigDespesasFaturamento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDigDespesasFaturamento.pAtualizaTotal;
begin
  edtTotalDespesas.Text := FormatFloat(fMskDigitos(2), objDespesasFaturamento.fltValorTotal);
end;

procedure TfrmDigDespesasFaturamento.plimpaDadosDespesa(blnClearCodigo: Boolean = True);
begin
  If blnClearCodigo Then
    edtCodigo.Clear;

  objDespesa.pLimpar;
  edtDescricao.Clear;
  edtQuantidade.Text    := '0,00';
  edtValorUnitario.Text := '0,00';
  edtValorTotal.Text    := '0,00';
end;

procedure TfrmDigDespesasFaturamento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
end;

procedure TfrmDigDespesasFaturamento.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fValidaPanel(pnlFundo, True) And Not fEmptyStr(edtCodigo.Text) Then
    objDespesasFaturamento.pAdicionarDespesa(objDespesa);
  plimpaDadosDespesa;
  pAtualizaTotal;
  pSetFocus(edtCodigo);
end;

procedure TfrmDigDespesasFaturamento.dbgDespesasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    objDespesasFaturamento.pDeletarDespesa;
    pAtualizaTotal;
  End;

  If Key = VK_RETURN Then
    SelectNext(ActiveControl, True, True);

  If Key = VK_ESCAPE Then
    pSetFocus(edtCodigo);
end;

procedure TfrmDigDespesasFaturamento.edtCodigoChange(Sender: TObject);
begin
  inherited;
  plimpaDadosDespesa(False);
end;

procedure TfrmDigDespesasFaturamento.edtCodigoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDespesas: TConsultasArray;
begin
  inherited;
  If fPesqDespesasFaturamento(Self, edtCodigo, edtDescricao, nil, Key, arrDespesas) Then
  Begin
    If fValidaCampos(edtCodigo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigDespesasFaturamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(objDespesa);
  inherited;
end;

procedure TfrmDigDespesasFaturamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  objDespesa  := TDespesaFaturamento.Create;
end;

procedure TfrmDigDespesasFaturamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And ((ActiveControl) <> edtCodigo) Then
    pSetFocus(edtCodigo)
  Else
    inherited;
end;

procedure TfrmDigDespesasFaturamento.FormShow(Sender: TObject);
begin
  inherited;
  dtsDespesas.DataSet := objDespesasFaturamento.cdsDespesas;
  plimpaDadosDespesa;
  pAtualizaTotal;
  SelectFirst;
end;

function TfrmDigDespesasFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    Try
      If Sender = edtCodigo Then
      Begin
        If Not fEmptyStr(edtCodigo.Text) Then
        Begin
          objDespesa.strCodigo := edtCodigo.Text;
          If blnBuscaPorChave And (fStrToFloat(edtValorUnitario.Text) = 0) Then
            edtValorUnitario.Text := FormatFloat(fMskDigitos(2), objDespesa.fltValorUnitarioSugestao);
        End
        Else
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgDespesas);
        End;
      End
      Else If Sender = edtQuantidade Then
      Begin
        objDespesa.fltQuantidade := fStrToFloat(edtQuantidade.Text);
      End
      Else If Sender = edtValorUnitario Then
      Begin
        objDespesa.fltValorUnitario := fStrToFloat(edtValorUnitario.Text);
      End;
    Except
      On E: ExceptionAutCom Do
      Begin
        Result := False;
        pMensagemOk(E.Message);
      End;

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

    If Not fEmptyStr(edtCodigo.Text) Then
    Begin
      edtDescricao.Text := objDespesa.strDescricao;
      edtValorTotal.Text := FormatFloat(fMskDigitos(2), objDespesa.fltValorTotal);
    End
    Else
      plimpaDadosDespesa;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

