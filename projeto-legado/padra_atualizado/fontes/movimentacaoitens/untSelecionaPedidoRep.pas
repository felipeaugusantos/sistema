unit untSelecionaPedidoRep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxDBLookupComboBox, untPreNota;

type
  TfrmSelecionaPedidoRep = class(TfrmPaiConfirma)
    cxvItensPed: TcxGridDBTableView;
    cxgItensPedLevel1: TcxGridLevel;
    cxgItensPed: TcxGrid;
    cxvItensPedNUMPED: TcxGridDBColumn;
    cxvItensPedCODEMP: TcxGridDBColumn;
    dtsEmpresas: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objPreNota: TPreNota;
  end;

implementation

{$R *.dfm}

procedure TfrmSelecionaPedidoRep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If modalResult = mrOk Then
  Begin

    If Not objPreNota.fValidaEmpresas Then
      Action := caNone;

  End;

end;

procedure TfrmSelecionaPedidoRep.FormShow(Sender: TObject);
begin
  inherited;

  cxvItensPed.NavigatorButtons.First.Click;
end;

end.
