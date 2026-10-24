unit untLiberaPrepTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untPreparaGeracaoTE, untFuncoesSimples, cxCurrencyEdit, untRelEstPedCompraGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncoesRel;

type
  TfrmLiberaPrepTE = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    cxvItens: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensREFERE: TcxGridDBColumn;
    cxvItensSIGUNI: TcxGridDBColumn;
    cxvItensQTDITE: TcxGridDBColumn;
    cxvItensEMPORI: TcxGridDBColumn;
    cxvItensEMPDES: TcxGridDBColumn;
    cxvItensCODOPE: TcxGridDBColumn;
    cxvItensDTACAD: TcxGridDBColumn;
    cxvItensHORCAD: TcxGridDBColumn;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    cxvItensLIBERA: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnExcluir: TBitBtnLocked;
    btnGiroEstoqueVenda: TBitBtnLocked;
    btnPedCompGrid: TBitBtnLocked;
    pnlLegenda: TPanel;
    shpSelec: TShape;
    lblSelec: TLabel;
    cxvItensNOMFOR: TcxGridDBColumn;
    cxvItensSALORI: TcxGridDBColumn;
    cxvItensSALDES: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGiroEstoqueVendaClick(Sender: TObject);
    procedure btnPedCompGridClick(Sender: TObject);
  private
  public
    { Public declarations }
    oblPrepTe: TPreparaGeracaoTE;
  end;

var
  frmLiberaPrepTE: TfrmLiberaPrepTE;

implementation

{$R *.dfm}

procedure TfrmLiberaPrepTE.btnExcluirClick(Sender: TObject);
Var strMsg :String;
begin

  If Not Assigned(oblPrepTe.cdsIteLib) Then
    Exit;

  If oblPrepTe.cdsIteLib.IsEmpty Then
      Exit;

  If Not oblPrepTe.fTemRegistrosMarcados Then
  Begin
    strMsg := 'Confirma a exclusão do Produto: '+ oblPrepTe.cdsIteLib.FieldByName('CODITE').AsString +'-'+
                                                  oblPrepTe.cdsIteLib.FieldByName('DESITE').AsString + ' ?';
  End
  Else
    strMsg := 'Confirma a exclusão de TODOS registros selecionados?';

  If oblPrepTe.blnAculumarDigitacao Then
  Begin

    If fPergunta(strMsg) Then
      oblPrepTe.cdsIteLib.Delete;
  End

  Else If fPergunta(strMsg) And oblPrepTe.fExcluiItens Then
  Begin
    pMensagemOk('Registros excluídos com sucesso!');

    oblPrepTe.fSelecionaItensLiberacao;

    If oblPrepTe.cdsIteLib.IsEmpty Then
      Close;
  End;

end;

procedure TfrmLiberaPrepTE.btnGiroEstoqueVendaClick(Sender: TObject);
var strCodigo : string;
begin
  oblPrepTe.cdsIteLib.first;

  while not oblPrepTe.cdsIteLib.eof do
  begin
    if sameText(oblPrepTe.cdsIteLib.fieldbyname('LIBERA').AsString, 'S') then
    Begin
      strCodigo := strCodigo + IIf(strCodigo <> '', ',','') +  QuotedStr(oblPrepTe.cdsIteLib.fieldbyname('CODITE').AsString);
    End;

    oblPrepTe.cdsIteLib.next;
  end;

  if strCodigo <> ''  Then
     prcExecutaRelatorio(409, 503685, [503685],
     ['CODITE',
      'FILGIR',
      'TABPRE'],
     ['(IN)'+strCodigo,
      'Todos',
      '1'], Sender,
     ['CODITE'])
end;


procedure TfrmLiberaPrepTE.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnDesmarcaTodos.Visible Then
    Exit;

  oblPrepTe.fMarcaTodos(False);
end;

procedure TfrmLiberaPrepTE.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Visible Then
    Exit;

  If Not oblPrepTe.fTemRegistrosMarcados Then
  Begin
    pMensagemOk('Selecione os registros para a liberação!');
    Exit;
  End;

  If fPergunta('Confirma a liberação dos registros selecionados?') And
     oblPrepTe.fLiberaItens Then
  Begin
    pMensagemOk('Registros liberados com sucesso!');

    oblPrepTe.fSelecionaItensLiberacao;

    If oblPrepTe.cdsIteLib.IsEmpty Then
      Close;
  End;
end;

procedure TfrmLiberaPrepTE.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnMarcaTodos.Visible Then
    Exit;

  oblPrepTe.fMarcaTodos(True);
end;

procedure TfrmLiberaPrepTE.btnMarDesClick(Sender: TObject);
begin
  inherited;

  If Not btnMarDes.Visible Then
    Exit;

  If Not Assigned(oblPrepTe.cdsIteLib) Then
    Exit;

  If oblPrepTe.blnAculumarDigitacao Then
    oblPrepTe.pInformaPreparacao('', True)
  Else
    oblPrepTe.pMarcaDesmarca;
end;

procedure TfrmLiberaPrepTE.btnPedCompGridClick(Sender: TObject);
begin
  inherited;


  If Not Assigned(oblPrepTe.cdsIteLib) Then
    Exit;

  If oblPrepTe.cdsIteLib.IsEmpty Then
      Exit;

  try
    pCriarFormularios(TfrmRelEstPedCompraGrid, frmRelEstPedCompraGrid);
    frmRelEstPedCompraGrid.strCodIte := oblPrepTe.cdsIteLib.FieldByName('CODITE').AsString;
    frmRelEstPedCompraGrid.strDesIte := oblPrepTe.cdsIteLib.FieldByName('DESITE').AsString;
    frmRelEstPedCompraGrid.ShowModal;
  finally
    FreeAndNil(frmRelEstPedCompraGrid);
  end;
end;

procedure TfrmLiberaPrepTE.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

 If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxvItensLIBERA.Index])) = 'S' Then
  Begin

    ACanvas.Brush.Color := clMoneyGreen;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;

  End
end;

procedure TfrmLiberaPrepTE.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), maximiza tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

  oblPrepTe := Nil;
end;

procedure TfrmLiberaPrepTE.FormDestroy(Sender: TObject);
begin
  inherited;

  If Not oblPrepTe.blnAculumarDigitacao Then
    FreeAndNil(oblPrepTe);
end;

procedure TfrmLiberaPrepTE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : btnGravar.Click;
    VK_F12   : btnPedCompGrid.Click;
    VK_RETURN: btnMarDes.Click;
    VK_F6    : btnMarcaTodos.Click;
    VK_F7    : btnDesmarcaTodos.Click;
    VK_DELETE: btnExcluir.Click;
  End;
end;

procedure TfrmLiberaPrepTE.FormShow(Sender: TObject);
begin
  inherited;

  If Assigned(oblPrepTe) And oblPrepTe.blnAculumarDigitacao Then
  Begin
    Self.Caption := 'Preparação de Transferência de Estoque do Pedido de Compra';

    cxvItensREFERE.Visible := False;
    cxvItensSIGUNI.Visible := False;
    cxvItensCODOPE.Visible := False;
    cxvItensDTACAD.Visible := False;
    cxvItensHORCAD.Visible := False;

    Self.ClientWidth := cxvItensCODITE.Width + cxvItensDESITE.Width +
                        cxvItensQTDITE.Width + cxvItensEMPORI.Width +
                        cxvItensEMPDES.Width + 20;

    btnMarDes.Caption        := '[ Enter ] Alterar';

    btnGravar.Visible        := False;
    btnMarcaTodos.Visible    := False;
    btnDesmarcaTodos.Visible := False;
    shpSelec.Visible         := False;
    lblSelec.Visible         := False;

    If Assigned(oblPrepTe.cdsIteLib) Then
    Begin
      cxvItens.DataController.DataSource := oblPrepTe.cdsIteLib.dtsSource;
      oblPrepTe.pCarregaSaldos;
    End;

  End Else
  Begin

    oblPrepTe := TPreparaGeracaoTE.Create;

    If oblPrepTe.fSelecionaItensLiberacao Then
      cxvItens.DataController.DataSource := oblPrepTe.cdsIteLib.dtsSource;
  End;

  pSetFocus(cxgItens);
end;

end.
