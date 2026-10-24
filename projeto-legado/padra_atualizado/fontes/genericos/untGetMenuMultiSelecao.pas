unit untGetMenuMultiSelecao;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, Datasnap.DBClient, UniClientDataSet, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid {Qt}, untFuncoesSimples, untTypesSistema,
  System.StrUtils;

type
  TfrmGetMenuMultiSelecao = class(TfrmPaiSimples)
    FlowPanel1: TFlowPanel;
    btnConfirma: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    dtsItens: TDataSource;
    dbgItens: TcxGrid;
    dbgItensDBTableView: TcxGridDBTableView;
    dbgItensDBTableViewSELECE: TcxGridDBColumn;
    dbgItensDBTableViewDESCRI: TcxGridDBColumn;
    dbgItensLevel: TcxGridLevel;
    cdsItens: TUniClientDataSet;
    cdsItensSELECE: TIntegerField;
    cdsItensDESCRI: TStringField;
    cdsItensCODIGO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure dbgItensDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgItensDBTableViewDblClick(Sender: TObject);
  private
    FArrLayoutsSelecionados:TArrString;
    procedure pMarcarDesmarcar(ABlnMarcar: Boolean);
    function fGetArrSelecionados: TArrString;
  protected
    procedure pEscapePressed; override;
  public
    blnConfirma: Boolean;
    blnSaiComEsc: Boolean;
    arrOpcoes  : Array Of String;
  published
    property ArrSelecionados: TArrString read FArrLayoutsSelecionados;
  end;

var
  frmGetMenuMultiSelecao: TfrmGetMenuMultiSelecao;

implementation

{$R *.dfm}

procedure TfrmGetMenuMultiSelecao.btnMarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcar(True);
end;

procedure TfrmGetMenuMultiSelecao.dbgItensDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgItensDBTableViewSELECE.Index] = 1 Then
    ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmGetMenuMultiSelecao.dbgItensDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  btnMarDes.Click;
end;

procedure TfrmGetMenuMultiSelecao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_SPACE: btnMarDes.Click;
    VK_F3: btnDesmarTodos.Click;
    VK_F2: btnMarTodos.Click;
    VK_ESCAPE: If blnSaiComEsc Then
                 Close;
  End;
end;

procedure TfrmGetMenuMultiSelecao.FormShow(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;
  blnConfirma      := False;

  cdsItens.EmptyDataSet;
  cdsItens.DisableControls;
  For intContador := 0 To Length(arrOpcoes)-1 Do
  Begin
    cdsItens.Insert;
    cdsItensSELECE.AsInteger := 0;
    cdsItensDESCRI.AsString := arrOpcoes[intContador];
    cdsItensCODIGO.AsString := Trim(SplitString(arrOpcoes[intContador], '-')[0]);
    cdsItens.Post;
  End;
  cdsItens.EnableControls;
end;

procedure TfrmGetMenuMultiSelecao.pEscapePressed;
begin
  If blnSaiComEsc Then
    inherited;

end;

procedure TfrmGetMenuMultiSelecao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmGetMenuMultiSelecao.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcar(False);
end;

procedure TfrmGetMenuMultiSelecao.btnMarDesClick(Sender: TObject);
begin
  inherited;
  cdsItens.Edit;
  cdsItens.FieldByName('SELECE').AsInteger := IIF(cdsItens.FieldByName('SELECE').AsInteger = 0,1,0);
  cdsItens.Post;
end;

procedure TfrmGetMenuMultiSelecao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not blnSaiComEsc And Not blnConfirma Then
    Action := caNone
  Else
    FArrLayoutsSelecionados := fGetArrSelecionados;
end;

function TFrmGetMenuMultiSelecao.fGetArrSelecionados: TArrString;
begin
  Try
    SetLength(Result, 0);
    cdsItens.DisableControls;
    cdsItens.Filter := 'SELECE = 1';
    cdsItens.Filtered := True;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      SetLength(Result, Length(Result)+1);
      Result[High(Result)] := cdsItensCODIGO.AsString;
      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
    cdsItens.Filter := '';
    cdsItens.Filtered := False;
  End;
end;

procedure TfrmGetMenuMultiSelecao.pMarcarDesmarcar(ABlnMarcar: Boolean);
var
  recNo: Integer;
begin
  recNo := cdsItens.RecNo;
  Try
    cdsItens.First;

    cdsItens.DisableControls;
    While not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('SELECE').AsInteger := IIF(ABlnMarcar,1,0);
      cdsItens.Post;
      cdsItens.Next;
    End;

  Finally
    cdsItens.recNo := recNo;
    cdsItens.EnableControls;
  End;
end;

end.

