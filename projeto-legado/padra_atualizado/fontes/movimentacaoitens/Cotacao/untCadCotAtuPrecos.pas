unit untCadCotAtuPrecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  cxCurrencyEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  untAtualizaPreco, untFuncoesSimples, cxDropDownEdit;

type
  TfrmCadCotAtuPrecos = class(TfrmPai)
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGrid;
    pnlComparativo: TPanel;
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    shp6: TShape;
    lbl7: TLabel;
    cxgItensBandedFixa: TcxGridDBBandedTableView;
    cxgItensDBBandedView: TcxGridDBBandedTableView;
    CODITE: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn2: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn3: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn4: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn5: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn6: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn7: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn8: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn9: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn10: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn11: TcxGridDBBandedColumn;
    NOVVE1: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn13: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn14: TcxGridDBBandedColumn;
    cxgItensATUPRE: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn16: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn17: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn18: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn19: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn20: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn21: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn22: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn23: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn24: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn25: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn26: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn27: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn28: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn29: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn30: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn31: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn32: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn33: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn34: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn35: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn36: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn37: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn38: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn39: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn40: TcxGridDBBandedColumn;
    cxStyle1: TcxStyle;
    cxgItensDBBandedViewColumn15: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn41: TcxGridDBBandedColumn;
    NOVBR1: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn46: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn49: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn52: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn55: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn59: TcxGridDBBandedColumn;
    cxgItensDBBandedViewColumn61: TcxGridDBBandedColumn;
    TIPALT: TcxGridDBBandedColumn;
    GroupBox1: TGroupBox;
    btnMarca: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    GroupBox2: TGroupBox;
    btnAtuPre: TBitBtnLocked;
    btnRecalcPreco: TBitBtnLocked;
    btnRecalcMargem: TBitBtnLocked;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    Panel1: TPanel;
    chkAtuIpi: TCheckBox;
    cxgItensDBBandedViewColumn1: TcxGridDBBandedColumn;
    btnDesPreAtu: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure cxgItensATUPREPropertiesChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure rdgTipAtuClick(Sender: TObject);
    procedure btnAtuPreClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnRecalcPrecoClick(Sender: TObject);
    procedure btnRecalcMargemClick(Sender: TObject);
    procedure NOVBR1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure NOVVE1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure TIPALTCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure CODITECustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure chkAtuIpiClick(Sender: TObject);
    procedure btnDesPreAtuClick(Sender: TObject);
  private
    { Private declarations }
    procedure pEscondePreços;
  public
    { Public declarations }
    blnNaoAbrir : Boolean;
    cdsItensAtuPre: TAtualizaPreco;
  end;

var
  frmCadCotAtuPrecos: TfrmCadCotAtuPrecos;

implementation

{$R *.dfm}

Uses
  untCadCotComparativo;

procedure TfrmCadCotAtuPrecos.btnRecalcMargemClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.pRecalculaItens(False);
end;

procedure TfrmCadCotAtuPrecos.btnRecalcPrecoClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.pRecalculaItens(True);
end;

procedure TfrmCadCotAtuPrecos.chkAtuIpiClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.blnAtuIPISub := chkAtuIpi.Checked;

  frmCadCotComparativo.pGeraComparativo(True, True);
end;

procedure TfrmCadCotAtuPrecos.CODITECustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgItensATUPRE.Index]) = 'S' Then
  Begin
    ACanvas.Font.Color := clGreen;

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clYellow;
  End

end;

procedure TfrmCadCotAtuPrecos.btnAtuPreClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.pAtualizaPrecos;
end;

procedure TfrmCadCotAtuPrecos.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.pMarcaTodos(marDesmarca);
end;

procedure TfrmCadCotAtuPrecos.btnDesPreAtuClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma a desmarcação do itens já atualizados?') Then
    cdsItensAtuPre.pDesmarcaAtualizados;
end;

procedure TfrmCadCotAtuPrecos.btnMarcaClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.pMarcaItem;
end;

procedure TfrmCadCotAtuPrecos.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre.pMarcaTodos(marMarca);
end;

procedure TfrmCadCotAtuPrecos.cxgItensATUPREPropertiesChange(Sender: TObject);
begin
  inherited;

  If cdsItensAtuPre.State = dsEdit then
    cdsItensAtuPre.Post;
end;

procedure TfrmCadCotAtuPrecos.NOVBR1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If SameText(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           TIPALT.Index]), STR_TIPALT_MARGEM) Then
  Begin
    ACanvas.Font.Color := clWhite;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Brush.Color := clRed;
  End

end;

procedure TfrmCadCotAtuPrecos.NOVVE1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If SameText(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           TIPALT.Index]), STR_TIPALT_PRECO) Then
  Begin
    ACanvas.Font.Color := clWhite;
    ACanvas.Font.Style := [fsBold];
    ACanvas.Brush.Color := clBlue;
  End

end;

procedure TfrmCadCotAtuPrecos.FormCreate(Sender: TObject);
begin
  inherited;

  cdsItensAtuPre := TAtualizaPreco.Create(Self);
  blnNaoAbrir := cdsItensAtuPre.blnDeuErr;

  pEscondePreços;

  blnFecharComEscape := False;
  cxgItensDBBandedView.DataController.DataSource := cdsItensAtuPre.dtsSource;
end;

procedure TfrmCadCotAtuPrecos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case Key of
    VK_RETURN: If cdsItensAtuPre.State = dsEdit then
                 cdsItensAtuPre.Post;

    VK_F3 : Begin
              btnDesPreAtu.Click;
              Key := 0;
            End;
    VK_F5 : btnMarca.Click;
    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarcaTodos.Click;
    VK_F8 : btnAtuPre.Click;
  end;

 // inherited;
end;

procedure TfrmCadCotAtuPrecos.FormPaint(Sender: TObject);
begin
  inherited;
  if blnNaoAbrir then
    Close;
end;

procedure TfrmCadCotAtuPrecos.pEscondePreços;
  Var
    intContador: Integer;
Begin
  for intContador := 1 to Length(VS_strTabPrc) do
  Begin
    If VS_strTabPrc[intContador] <> 'S' then
    Begin
      cxgItensDBBandedView.Bands[03 + intContador].Visible := False;
    End;
  End;
End;


procedure TfrmCadCotAtuPrecos.rdgTipAtuClick(Sender: TObject);
begin
  inherited;

  pEscondePreços;
end;

procedure TfrmCadCotAtuPrecos.TIPALTCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If SameText(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           TIPALT.Index]), STR_TIPALT_PRECO) Then
  Begin
    ACanvas.Font.Color := clBlue;
  End Else
  Begin
    ACanvas.Font.Color := clRed;
  End;

end;

end.

