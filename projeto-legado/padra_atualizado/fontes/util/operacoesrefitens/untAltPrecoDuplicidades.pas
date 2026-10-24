unit untAltPrecoDuplicidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxLabel,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxTextEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, untIteBar,
  Uni, untFuncoesSimples, UniClientDataSet;

type
  TfrmAltPrecoDuplicidades = class(TfrmPaiSimples)
    pnlHeader: TPanel;
    dtsConsulta: TDataSource;
    btnConfirmaAlt: TBitBtnLocked;
    cxItens: TcxGrid;
    cxItensTblv: TcxGridDBTableView;
    cxItensCodIte: TcxGridDBColumn;
    cxItensDescri: TcxGridDBColumn;
    cxItensCodBar: TcxGridDBColumn;
    cxItensCodBarEmb: TcxGridDBColumn;
    cxItenslvl: TcxGridLevel;
    cxItensITEAGR: TcxGridDBColumn;
    cxItensORIGEM: TcxGridDBColumn;
    cxItensCodFab: TcxGridDBColumn;
    Panel1: TPanel;
    shpInfo: TShape;
    Label1: TLabel;    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cxItensTblvCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);

    procedure btnConfirmaAltClick(Sender: TObject);
  private
    { Private declarations }

    FobjIteBar: TIteBar;
    FcdsDuplic: TUniClientDataSet;

    function fCodigoBarraValido: Boolean;

  public
    property _objIteBar: TIteBar Read FobjIteBar Write FobjIteBar;
    property _cdsDuplic: TUniClientDataSet Read FcdsDuplic Write FcdsDuplic;

    { Public declarations }
  end;

var
  frmAltPrecoDuplicidades: TfrmAltPrecoDuplicidades;

implementation

{$R *.dfm}

procedure TfrmAltPrecoDuplicidades.btnConfirmaAltClick(Sender: TObject);
begin
  inherited;
  If Not(fCodigoBarraValido) then
    ModalResult := mrCancel;
end;

procedure TfrmAltPrecoDuplicidades.cxItensTblvCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxItensORIGEM.Index])= 'S' Then
  begin
    ACanvas.Brush.Color := clLtGray;
    ACanvas.Font.Color  := clBlack;
  End;
end;

function TfrmAltPrecoDuplicidades.fCodigoBarraValido: Boolean;
  Var
    qryBusca: TUniQuery;
begin
  Result := True;

  qryBusca := fCriaQuery(Self);

  FcdsDuplic.Filtered := False;
  FcdsDuplic.Filter := 'ORIGEM = ' + QuotedStr('N');
  FcdsDuplic.Filtered := True;
  FcdsDuplic.First;

  While Not FcdsDuplic.Eof Do
  Begin

    Result:= FobjIteBar.fValidaCodBar(FcdsDuplic.FieldByName('CODBAR').AsString);

    If Result Then
      FcdsDuplic.Next
    Else
    Begin
      Break;
    End;

  End;

  FcdsDuplic.Filtered := False;

  FreeAndNil(qryBusca);
end;

procedure TfrmAltPrecoDuplicidades.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirmaAlt.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmAltPrecoDuplicidades.FormShow(Sender: TObject);
begin
  inherited;
  shpInfo.Brush.Color := clLtGray;

  cxItensTblv.DataController.DataSource := dtsConsulta;
  cxItensTblv.GetColumnByFieldName('ITEAGR').GroupIndex := cxItensTblv.GetColumnByFieldName('ITEAGR').Index;
  cxItensTblv.ViewData.Expand(True);
end;

end.
