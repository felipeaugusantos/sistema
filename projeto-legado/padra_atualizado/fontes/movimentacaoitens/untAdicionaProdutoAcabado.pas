unit untAdicionaProdutoAcabado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxTextEdit;

type
  TfrmAdicionaProdutoAcabado = class(TfrmPai)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensViewColumn2: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    cxgItensViewColumn3: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdicionaProdutoAcabado: TfrmAdicionaProdutoAcabado;

implementation

{$R *.dfm}

procedure TfrmAdicionaProdutoAcabado.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult:= mrOk;
end;

procedure TfrmAdicionaProdutoAcabado.btnSairClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
  inherited;

end;

end.
