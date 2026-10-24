unit untAtuCadProdutosIteFor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, cxDropDownEdit, cxCurrencyEdit,
  cxCheckBox, untTabelaPreco,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAtuCadProdutosIteFor = class(TfrmPaiConfirma)
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxvItens: TcxGridDBBandedTableView;
    cxvItensCODITE: TcxGridDBBandedColumn;
    cxvItensDESITE: TcxGridDBBandedColumn;
    cxvItensPRECUS: TcxGridDBBandedColumn;
    cxvItensNOVCUS: TcxGridDBBandedColumn;
    btnMarDes: TBitBtnLocked;
    cxvItensMARBR1: TcxGridDBBandedColumn;
    cxvItensMARNV1: TcxGridDBBandedColumn;
    cxvItensPREVE1: TcxGridDBBandedColumn;
    cxvItensMARBR2: TcxGridDBBandedColumn;
    cxvItensMARNV2: TcxGridDBBandedColumn;
    cxvItensMARBR3: TcxGridDBBandedColumn;
    cxvItensMARNV3: TcxGridDBBandedColumn;
    cxvItensMARBR4: TcxGridDBBandedColumn;
    cxvItensMARNV4: TcxGridDBBandedColumn;
    cxvItensMARBR5: TcxGridDBBandedColumn;
    cxvItensMARNV5: TcxGridDBBandedColumn;
    cxvItensMARBR6: TcxGridDBBandedColumn;
    cxvItensMARNV6: TcxGridDBBandedColumn;
    cxvItensMARBR7: TcxGridDBBandedColumn;
    cxvItensMARNV7: TcxGridDBBandedColumn;
    cxvItensPREVE7: TcxGridDBBandedColumn;
    cxvItensPRENV1: TcxGridDBBandedColumn;
    cxvItensPREVE2: TcxGridDBBandedColumn;
    cxvItensPRENV2: TcxGridDBBandedColumn;
    cxvItensPREVE3: TcxGridDBBandedColumn;
    cxvItensPRENV3: TcxGridDBBandedColumn;
    cxvItensPREVE4: TcxGridDBBandedColumn;
    cxvItensPRENV4: TcxGridDBBandedColumn;
    cxvItensPREVE5: TcxGridDBBandedColumn;
    cxvItensPRENV5: TcxGridDBBandedColumn;
    cxvItensPREVE6: TcxGridDBBandedColumn;
    cxvItensPRENV6: TcxGridDBBandedColumn;
    cxvItensPRENV7: TcxGridDBBandedColumn;
    cxvItensATUALI: TcxGridDBBandedColumn;
    btnProsseguir: TBitBtnLocked;
    cxvItensCODFOR: TcxGridDBBandedColumn;
    cxvItensNOMFOR: TcxGridDBBandedColumn;
    cxvItensMARDES: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlTail: TPanel;
    Label2: TLabel;
    Shape2: TShape;
    Label1: TLabel;
    Shape1: TShape;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxvItensMARDESCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cxvItensATUALIPropertiesCloseUp(Sender: TObject);
    procedure btnProsseguirClick(Sender: TObject);
    procedure cxvItensNOVCUSCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
     blnAtuPre: Boolean;
     objTabPre: TTabelaPreco;
  end;


implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmAtuCadProdutosIteFor.btnMarDesClick(Sender: TObject);
begin
  inherited;

  objTabPre.pMarcaNovosPrecos;
end;

procedure TfrmAtuCadProdutosIteFor.btnProsseguirClick(Sender: TObject);
begin
  modalResult := mrOk;
end;

procedure TfrmAtuCadProdutosIteFor.btnConfirmaClick(Sender: TObject);
begin

  If objTabPre.fTemProdutoMarcado And fPergunta('Confirma a atualização de preços/margens dos produtos?') Then
  Begin
    blnAtuPre := True;
    inherited;
  End;


end;

procedure TfrmAtuCadProdutosIteFor.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objTabPre.pMarcaTodos(False);
end;

procedure TfrmAtuCadProdutosIteFor.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objTabPre.pMarcaTodos(True);

end;

procedure TfrmAtuCadProdutosIteFor.cxvItensATUALIPropertiesCloseUp(
  Sender: TObject);
begin
  inherited;

  objTabPre.pPostNovoPreco;
end;

procedure TfrmAtuCadProdutosIteFor.cxvItensMARDESCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensMARDES.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := clRed;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End

end;

procedure TfrmAtuCadProdutosIteFor.cxvItensNOVCUSCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensNOVCUS.Index])) >
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensPRECUS.Index])) Then
  Begin
    ACanvas.Font.Color := clBlue;
  End Else
  If fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensNOVCUS.Index])) <
     fStrToFloat(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvItensPRECUS.Index])) Then
  Begin
    ACanvas.Font.Color := clRed;
  End
end;

procedure TfrmAtuCadProdutosIteFor.FormCreate(Sender: TObject);
begin
  inherited;

  blnAtuPre := False;
end;

procedure TfrmAtuCadProdutosIteFor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5  : btnMarDes.Click;
    VK_F6  : btnMarcaTodos.Click;
    VK_F7  : btnDesmarcaTodos.Click;
    VK_F10 : btnConfirma.Click;
  End;
end;

procedure TfrmAtuCadProdutosIteFor.FormShow(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  For intContador := 1 To Length(VS_strTabPrc) Do
    cxvItens.Bands[succ(intContador)].Visible := VS_strTabPrc[intContador] = 'S';
end;

end.
