unit untConfirmaAlteracaoRepVen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxGridCitel,
  Vcl.StdCtrls, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, System.UITypes,
  UniClientDataSet;

type
  TfrmConfirmaAlteracaoRepVen = class(TfrmPaiSimples)
    dtsGrid: TDataSource;
    Panel1: TPanel;
    FlowPanel1: TFlowPanel;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    pnlRodape: TPanel;
    shpLegendaSelecionados: TShape;
    lblSelecionados: TLabel;
    lblLegendaQtdSel: TLabel;
    lblQtdSel: TLabel;
    pnlBottom: TPanel;
    cxGrid: TcxGridCitel;
    cxGridTBV: TcxGridDBTableView;
    cxGridTBVCODCLI: TcxGridDBColumn;
    cxGridTBVNOMCLI: TcxGridDBColumn;
    cxGridTBVVENREPANT: TcxGridDBColumn;
    cxGridTBVVENREPNOV: TcxGridDBColumn;
    cxGridTBVMARDES: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridTBVULTCOM: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure cxGridTBVCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTBVCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FintQtdSel: Integer;
    procedure pQuantidadeSelecionados;
    procedure pMarcaDesmarca;
    procedure pMarcaDesmarcaTodos(aValor: Integer);
    procedure pAjustaTamanhoColunaNome;
  public
    { Public declarations }
    intVenRep: Integer;
    blnConfirma: Boolean;
    cdsGrid: TUniClientDataSet;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfirmaAlteracaoRepVen.btnConfirmaClick(Sender: TObject);
begin
  if (FintQtdSel = 0) then
  begin
    fMensagem('Atenção', 'Nenhum cliente selecionado para alteração.', ['&Ok']);
    ModalResult := mrNone;
    Exit;
  end;

  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmConfirmaAlteracaoRepVen.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(0);
end;

procedure TfrmConfirmaAlteracaoRepVen.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(1);
end;

procedure TfrmConfirmaAlteracaoRepVen.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfirmaAlteracaoRepVen.cxGridTBVCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMarcaDesmarca;
end;

procedure TfrmConfirmaAlteracaoRepVen.cxGridTBVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridTBVMARDES.Index] = '1') then
  begin
    if ACanvas.Brush.Color = clHighLight then
      ACanvas.Font.Color := clHighLightText
    else
      ACanvas.Brush.Color := clAqua;
  end;
end;

procedure TfrmConfirmaAlteracaoRepVen.cxGridTBVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
    pMarcaDesmarca;
end;

procedure TfrmConfirmaAlteracaoRepVen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (not blnConfirma) then
  begin
    if fMensagem('', 'Deseja realmente cancelar a operação?', ['&Sim', '&Não']) = 2 then
    begin
      ModalResult := mrNone;
      Exit;
    end;
  end;

  inherited;
end;

procedure TfrmConfirmaAlteracaoRepVen.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmConfirmaAlteracaoRepVen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F10: btnConfirma.Click;
    VK_F5 : btnMarcarTodos.Click;
    VK_F6 : btnDesmarcarTodos.Click;
  end;
end;

procedure TfrmConfirmaAlteracaoRepVen.FormResize(Sender: TObject);
begin
  inherited;
  pAjustaTamanhoColunaNome;
end;

procedure TfrmConfirmaAlteracaoRepVen.FormShow(Sender: TObject);
var
  strCaption: String;
begin
  inherited;
  Self.WindowState := wsMaximized;
  dtsGrid.DataSet := cdsGrid;
  pQuantidadeSelecionados;
  strCaption := IIF((intVenRep = 1), 'Vendedor', 'Representante');

  Self.Caption := 'Confimação - Troca de ' + strCaption;
  cxGridTBVVENREPANT.Caption := strCaption + ' Anterior';
  cxGridTBVVENREPNOV.Caption := strCaption + ' Novo';
end;

procedure TfrmConfirmaAlteracaoRepVen.pAjustaTamanhoColunaNome;
var
  intColumn: Integer;
  intTamUti: Integer;
const
  intValMin: Integer = 375;
begin
  intTamUti := 0;

  for intColumn := 0 to cxGridTBV.ColumnCount -1 do
    if cxGridTBV.Columns[intColumn].Visible And (cxGridTBV.Columns[intColumn].DataBinding.FieldName <> 'NOMCLI') Then
      Inc(intTamUti, cxGridTBV.Columns[intColumn].Width);

  if (cxGrid.Width - intTamUti - 60) >= intValMin then
    cxGridTBVNOMCLI.Width := (cxGrid.Width - intTamUti - 60)
  else
    cxGridTBVNOMCLI.Width := intValMin;
end;

procedure TfrmConfirmaAlteracaoRepVen.pMarcaDesmarca;
begin
  cdsGrid.Edit;

  if (cdsGrid.FieldByName('MARDES').AsInteger = 0) then
    cdsGrid.FieldByName('MARDES').AsInteger := 1
  else
    cdsGrid.FieldByName('MARDES').AsInteger := 0;

  cdsGrid.Post;
  pQuantidadeSelecionados;
end;

procedure TfrmConfirmaAlteracaoRepVen.pMarcaDesmarcaTodos(aValor: Integer);
begin
  cdsGrid.DisableControls;

  try
    cdsGrid.First;

    while not cdsGrid.Eof do
    begin
      if (cdsGrid.FieldByName('MARDES').AsInteger = aValor) then
      begin
        cdsGrid.Next;
        Continue;
      end;

      cdsGrid.Edit;
      cdsGrid.FieldByName('MARDES').AsInteger := aValor;
      cdsGrid.Post;

      cdsGrid.Next;
    end;
  finally
    cdsGrid.EnableControls;
    pQuantidadeSelecionados;
    cdsGrid.First;
  end;
end;

procedure TfrmConfirmaAlteracaoRepVen.pQuantidadeSelecionados;
begin
  FintQtdSel := StrToIntDef(cdsGrid.FieldByName('TOTSEL').AsString, 0);
  lblQtdSel.Caption := FintQtdSel.ToString;
end;

end.
