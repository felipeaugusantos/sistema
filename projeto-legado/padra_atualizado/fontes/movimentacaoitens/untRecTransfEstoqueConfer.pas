unit untRecTransfEstoqueConfer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCurrencyEdit, untRecConferEntrada, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.DBCtrls,
  DBMemoFocus;

type
  TfrmRecTransfEstoqueConfer = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    pnlContagem: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    rdbCodBar: TRadioButton;
    rdbCodFab: TRadioButton;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensSIGUNI: TcxGridDBColumn;
    cxgItensQTDCON: TcxGridDBColumn;
    pnlNotas: TPanel;
    mmoNotas: TMemo;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    btnExcluir: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    cxgItensQTDITE: TcxGridDBColumn;
    lblConPar: TLabel;
    shpConPar: TShape;
    shpConTot: TShape;
    lblConTot: TLabel;
    pnlAplicacao: TPanel;
    pnlAplica: TPanel;
    mmoAplica: TDBMemoFocus;
    cxgItensLOCFIS: TcxGridDBColumn;
    cxgItensLOCSUP: TcxGridDBColumn;
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdbCodBarClick(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function fRegistraItemConf: Boolean;
    Function fVerificaTamanhoTela: Boolean;
  public
    { Public declarations }
    objConEnt: TRecConferEntrada;
    blnExiApl: Boolean;
    intDeqTem: Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRecTransfEstoqueConfer: TfrmRecTransfEstoqueConfer;

implementation

{$R *.dfm}

procedure TfrmRecTransfEstoqueConfer.btnExcluirClick(Sender: TObject);
begin
  inherited;
  objConEnt.pExcluiItem;
  pSetFocus(edtCodIte);
end;

procedure TfrmRecTransfEstoqueConfer.btnGravarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
end;

procedure TfrmRecTransfEstoqueConfer.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

procedure TfrmRecTransfEstoqueConfer.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTDCON.Index] > 0 ) Then
  Begin
    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTDCON.Index] =
        Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTDITE.Index] ) Then
    Begin
      ACanvas.Brush.Color := clMoneyGreen;
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clBlue;
    End
    Else If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTDCON.Index] <
             Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensQTDITE.Index] ) Then
    Begin
      ACanvas.Brush.Color := clYellow;
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clBlue;
    End;
  End;
End;

procedure TfrmRecTransfEstoqueConfer.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE:  btnExcluir.Click;
  End;

end;

procedure TfrmRecTransfEstoqueConfer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not objConEnt.fFinalizaEntrada Then
      Action := caNone;
  End

  Else If Not fPergunta('Deseja abandonar a Conferência?') Then
         Action := caNone;
end;

procedure TfrmRecTransfEstoqueConfer.FormCreate(Sender: TObject);
begin
  inherited;
  If fVerificaTamanhoTela Then
    Self.Position := poScreenCenter;
end;

procedure TfrmRecTransfEstoqueConfer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If edtCodIte.Focused Then
                 fRegistraItemConf;
    VK_F6: btnQuantidade.Click;
    VK_F10: Begin
              Key := 0;
              btnGravar.Click;
            End;
  End;

end;

procedure TfrmRecTransfEstoqueConfer.FormShow(Sender: TObject);
begin
  inherited;

  If blnExiApl Then
  Begin
    pnlAplicacao.Visible := True;
    mmoAplica.DataSource := cxgItensView.DataController.DataSource;
  End;

  intDeqTem := fCfgSis('DEQTEM', varInteger);
  edtQtdIte.EditFormat := fMskDigitos(intDeqTem);
  edtQtdIte.Text := FormatFloat(fMskDigitos(intDeqTem), 1);
  TcxCurrencyEditProperties(cxgItensQTDITE.Properties).DecimalPlaces := intDeqTem;
  TcxCurrencyEditProperties(cxgItensQTDITE.Properties).DisplayFormat := fMskDigitos(intDeqTem);
  TcxCurrencyEditProperties(cxgItensQTDCON.Properties).DecimalPlaces := intDeqTem;
  TcxCurrencyEditProperties(cxgItensQTDCON.Properties).DisplayFormat := fMskDigitos(intDeqTem);
  rdbCodFab.Visible := fCfgSis('UTICFS', varBoolean);
  pSetFocus(edtCodIte);
  objConEnt.pExcluirExcedentes;
end;

function TfrmRecTransfEstoqueConfer.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If Not objConEnt.fValidaQuantidade(edtQtdIte) Then
        Result := False

      Else If edtQtdIte.Focused Then
      Begin
        edtQtdIte.Enabled := False;
        pSetFocus(edtCodIte);
        blnMudarFoco := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRecTransfEstoqueConfer.fVerificaTamanhoTela: Boolean;
begin
  Result := False;
  If ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Screen.Width <= 1366) Then
    Result := True
end;

procedure TfrmRecTransfEstoqueConfer.rdbCodBarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
  edtCodIte.MaxLength := IIF(rdbCodBar.CheCked, 15, 25);
end;

Function TfrmRecTransfEstoqueConfer.fRegistraItemConf: Boolean;
  Var
    blnCodBarNaoEcontrado,
    blnBarPrin,
    blnBarEmb: Boolean;
Begin
  Result := FALSE;

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  If Not fValidaCampos(edtQtdIte) Then
    Exit;

  blnBarPrin:= Not(fEmptyStr(fCampoTabela('ITE_CODBAR', 'CADITE', ['ITE_CODBAR'], [edtCodIte.Text], False)));
  blnBarEmb := Not(fEmptyStr(fCampoTabela('ITE_BAREMB', 'CADITE', ['ITE_BAREMB','ITE_CODEMP'], [edtCodIte.Text, VS_strCodEmp], False)));

  If Not(fEmptyStr(fCfgSis('PRBPUN', varString))) And blnBarPrin Then
    pMensagemSonora('', 'PRBPUN')
  Else
  If Not(fEmptyStr(fCfgSis('PRBPEM', varString)))And blnBarEmb Then
    pMensagemSonora('', 'PRBPEM');

  Result := objConEnt.fRegistraItem(rdbCodBar.Checked, rdbCodFab.Checked,
              edtCodIte, edtQtdIte, Nil, True, blnCodBarNaoEcontrado);

  rdbCodBar.Checked := True;
End;

end.
