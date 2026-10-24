unit untSelecionaItemDuplicadoCodFabrica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TfrmSelecionaItemDuplicadoCodFabrica = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    cxItensDB: TcxGridDBTableView;
    cxItensL: TcxGridLevel;
    cxItens: TcxGrid;
    dtsItens: TDataSource;
    cxItensCODITE: TcxGridDBColumn;
    cxItensDESITE: TcxGridDBColumn;
    cxItensCODFOR: TcxGridDBColumn;
    cxItensDESFOR: TcxGridDBColumn;
    cxItensCODFAB: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxItensDBDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    blnConfirmou: Boolean;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmSelecionaItemDuplicadoCodFabrica.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirmou := True;
end;

procedure TfrmSelecionaItemDuplicadoCodFabrica.cxItensDBDblClick(
  Sender: TObject);
begin
  inherited;
  btnConfirma.Click;
end;

procedure TfrmSelecionaItemDuplicadoCodFabrica.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmou := False;

end;

end.
