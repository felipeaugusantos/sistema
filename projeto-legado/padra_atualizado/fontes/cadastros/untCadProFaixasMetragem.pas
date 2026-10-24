unit untCadProFaixasMetragem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel, cxGrid, EditFocus,
  Datasnap.DBClient, UniClientDataSet, Uni, untTProFaixasMetragem,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadProFaixasMetragem = class(TfrmPaiSimples)
    grpCadFaixas: TGroupBox;
    grpFaixasCadastradas: TGroupBox;
    Panel1: TPanel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    grdFaixasLevel1: TcxGridLevel;
    grdFaixasTableView: TcxGridDBTableViewCitel;
    grdFaixas: TcxGridCitel;
    edtFaiFin: TEditFocus;
    edtFaiIni: TEditFocus;
    lblFaiIni: TLabel;
    lblFaiFin: TLabel;
    Label1: TLabel;
    edtIteFat: TEditFocus;
    grdFaixasITE_FAIINI: TcxGridDBColumn;
    grdFaixasITE_FAIFIN: TcxGridDBColumn;
    grdFaixasITE_ITEFAT: TcxGridDBColumn;
    btnFechar: TBitBtnLocked;
    dtsFaixas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdFaixasTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdFaixasTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    strOperac: String;

    function  fValidarAlteracaoExclusao: Boolean;
    procedure pHabilitarBotoes(Sender: TObject);
    procedure pLimparCampos;
  public
    { Public declarations }
    objFaixasMet: TFaixasMetragem;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmCadProFaixasMetragem.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (fValidarAlteracaoExclusao()) Then
    Exit;

  Try
    grdFaixas.Enabled := False;

    If (fMensagem('CONFIRMAÇÃO!', 'Deseja alterar esse registro?', ['&Sim', '&Não'], 2) = 1) Then Begin
      edtFaiIni.Text := FormatFloat('#,####0.0000', dtsFaixas.DataSet.FieldByName('ITE_FAIINI').AsFloat);
      edtFaiFin.Text := FormatFloat('#,####0.0000', dtsFaixas.DataSet.FieldByName('ITE_FAIFIN').AsFloat);
      edtIteFat.Text := FormatFloat('#,####0.0000', dtsFaixas.DataSet.FieldByName('ITE_ITEFAT').AsFloat);

      strOperac := 'A';
      pHabilitarBotoes(Sender);
    End;
  Finally
    grdFaixas.Enabled := True;
  End;
end;

procedure TfrmCadProFaixasMetragem.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pLimparCampos();

  strOperac := '';
  pHabilitarBotoes(Sender);
end;

procedure TfrmCadProFaixasMetragem.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If (fValidarAlteracaoExclusao()) Then
    Exit;

  If (fMensagem('CONFIRMAÇÃO!', 'Deseja excluir esse registro?', ['&Sim', '&Não'], 2) = 1) Then Begin
    objFaixasMet.fRemoverFaixa();
    strOperac := '';
  End;

  pHabilitarBotoes(Sender);
end;

procedure TfrmCadProFaixasMetragem.btnGravarClick(Sender: TObject);
  Var
    cvValidacao: TCampoValidacao;
begin
  inherited;

  If (strOperac = 'A') Then
    objFaixasMet.blnAlterando := True;

  cvValidacao := objFaixasMet.fValidarFaixa(fStrToFloat(edtFaiIni.Text), fStrToFloat(edtFaiFin.Text), fStrToFloat(edtIteFat.Text));

  If (cvValidacao = cvNone) Then Begin
    If (strOperac = 'I') Then
      objFaixasMet.fInserirFaixa(fStrToFloat(edtFaiIni.Text), fStrToFloat(edtFaiFin.Text), fStrToFloat(edtIteFat.Text))
    Else If (strOperac = 'A') Then
      objFaixasMet.fAlterarFaixa(fStrToFloat(edtFaiIni.Text), fStrToFloat(edtFaiFin.Text), fStrToFloat(edtIteFat.Text));

    pLimparCampos();

    strOperac := '';
    pHabilitarBotoes(Sender);
  End Else Begin
    Case (cvValidacao) Of
      cvFaiIni,
      cvIniInterv,
      cvIntervalo: pSetFocus(edtFaiIni);
      cvFaiFin,
      cvFinInterv: pSetFocus(edtFaiFin);
      cvIteFat: pSetFocus(edtIteFat);
    End;
  End;

  objFaixasMet.blnAlterando := False;
end;

procedure TfrmCadProFaixasMetragem.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If (Not objFaixasMet.cdsFaixas.IsEmpty) Then Begin
    dtsFaixas.DataSet.Last();
    edtFaiIni.Text := FormatFloat('#,####0.0000', dtsFaixas.DataSet.FieldByName('ITE_FAIFIN').AsFloat + 0.0001);
    pSetFocus(edtFaiIni);
  End;

  strOperac := 'I';
  pHabilitarBotoes(Sender);
end;

procedure TfrmCadProFaixasMetragem.btnSairClick(Sender: TObject);
begin
  inherited;

  Close();
end;

procedure TfrmCadProFaixasMetragem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Not fEmptyStr(strOperac)) Then Begin
    If (fMensagem('CONFIRMAÇÃO!', 'Deseja realmente sair da tela?' + #13#10 + 'Existem informações sendo editadas e as mesas serão descartadas.', ['&Sim', '&Não'], 2) = 2) Then Begin
      Action := CaNone;
      pSetFocus(edtFaiIni);
    End;
  End;
end;

procedure TfrmCadProFaixasMetragem.FormCreate(Sender: TObject);
begin
  inherited;

  strOperac    := '';
  objFaixasMet := nil;
end;

procedure TfrmCadProFaixasMetragem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
    btnSair.Click();
end;

procedure TfrmCadProFaixasMetragem.FormShow(Sender: TObject);
begin
  inherited;

  If (Not Assigned(objFaixasMet)) Then Begin
    Self.Caption := 'Faixas de Metragem';

    fMensagem('ATENÇÃO!', 'Ocorreu um erro ao criar a tela. Verifique!', ['&OK']);

    pHabilitarBotoes(Self);
  End Else Begin
    Self.Caption := 'Faixas de Metragem Produto: ' + objFaixasMet.strCodIte + ' - ' + fRetNomProduto(objFaixasMet.strCodIte);

    If (objFaixasMet.cdsFaixas.IsEmpty) Then
      dtsFaixas.DataSet := objFaixasMet.fCarregarFaixasItem()
    Else
      dtsFaixas.DataSet := objFaixasMet.cdsFaixas;

    grdFaixasTableView.DataController.DataSource := dtsFaixas;

    pHabilitarBotoes(btnGravar);
  End;
end;

function TfrmCadProFaixasMetragem.fValidarAlteracaoExclusao: Boolean;
begin
  Result := (objFaixasMet.cdsFaixas.IsEmpty);

  If (Result) Then
    fMensagem('ATENÇÃO!', 'Selecione um registro para prosseguir com a operação!', ['&OK']);
end;

procedure TfrmCadProFaixasMetragem.grdFaixasTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  btnAlterar.Click();
end;

procedure TfrmCadProFaixasMetragem.grdFaixasTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (KEY = VK_RETURN) Then
    btnAlterar.Click();
end;

procedure TfrmCadProFaixasMetragem.pHabilitarBotoes(Sender: TObject);
begin
  If (Sender = btnIncluir) Or (Sender = btnAlterar) Then Begin
    btnIncluir.Enabled := False;
    btnGravar.Enabled  := True;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnCancela.Enabled := True;

    grpCadFaixas.Enabled := True;
    grpFaixasCadastradas.Enabled := False;

    pSetFocus(edtFaiIni);
  End Else If (Sender = btnGravar) Or (Sender = btnExcluir) Or (Sender = btnCancela) Then Begin
    btnIncluir.Enabled := True;
    btnGravar.Enabled  := False;
    btnAlterar.Enabled := True;
    btnExcluir.Enabled := True;
    btnCancela.Enabled := False;

    grpCadFaixas.Enabled := False;
    grpFaixasCadastradas.Enabled := True;

    pSetFocus(btnIncluir);
  End Else If (Sender = Self) Then Begin
    btnIncluir.Enabled := False;
    btnGravar.Enabled  := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnCancela.Enabled := False;

    grpCadFaixas.Enabled := False;
  End;
end;

procedure TfrmCadProFaixasMetragem.pLimparCampos;
begin
  edtFaiIni.Text := '0,0000';
  edtFaiFin.Text := '0,0000';
  edtIteFat.Text := '0,0000';
end;

end.
