unit untPesqCliVend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, Uni, DB, UniClientDataSet, UniDataSetProvider, 
   Mask, DBCtrls, DBEditFocus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmPesqCliVend = class(TfrmPai)
    dtsConsCliVen: TDataSource;
    dbgCliVen: TcxGridCitel;
    dbgCliVenDBTableViewCitel1: TcxGridDBTableViewCitel;
    dbgCliVenLevel1: TcxGridLevel;
    dbgCliVenDBTableViewCitel1CVE_CODVEN: TcxGridDBColumn;
    dbgCliVenDBTableViewCitel1OPE_NOMOPE: TcxGridDBColumn;
    dbgCliVenDBTableViewCitel1MAR_DESMAR: TcxGridDBColumn;
    dbgCliVenDBTableViewCitel1CVE_DTVGIN: TcxGridDBColumn;
    dbgCliVenDBTableViewCitel1CVE_DTVGFN: TcxGridDBColumn;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgCliVenDBTableViewCitel1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dbgCliVenDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    procedure pInicializaClienteVendedor ;
  public
    blnOk: Boolean;
  end;

var
  frmPesqCliVend: TfrmPesqCliVend;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConstantes, untTypesSistema;

procedure TfrmPesqCliVend.dbgCliVenDBTableViewCitel1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  blnOk := True;
  Close;
end;

procedure TfrmPesqCliVend.dbgCliVenDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    blnOk := False;
    Close;
  End
  Else If (Key = VK_Return) Then
  Begin
    blnOk := True;
    Close;
  End;
end;

procedure TfrmPesqCliVend.FormCreate(Sender: TObject);
begin
  inherited;
  pInicializaClienteVendedor ;
end;

procedure TfrmPesqCliVend.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgCliVen);
end;

procedure TfrmPesqCliVend.pInicializaClienteVendedor;
var
  LstrOp: string ;
  LrecInfo: TrecInfoMarcaFornecedor ;
begin
  pInfoMarcaFornecedor(LrecInfo) ;
  LstrOp := fCfgSis('MLTOP2', varString) ;
  if LstrOp = CODIGO_CLIENTE_VENDEDOR_FORNECEDOR then
  begin
    dbgCliVenDBTableViewCitel1MAR_DESMAR.Caption := 'Fornecedor' ;
    dbgCliVenDBTableViewCitel1MAR_DESMAR.DataBinding.FieldName := LrecInfo.strFieldNome ;
  end;
end;

procedure TfrmPesqCliVend.btnSairClick(Sender: TObject);
begin
  inherited;

  blnOk := False;
  Close;
end;

end.
