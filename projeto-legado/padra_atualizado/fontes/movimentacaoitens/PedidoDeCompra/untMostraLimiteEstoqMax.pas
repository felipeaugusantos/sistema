unit untMostraLimiteEstoqMax;

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
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit;

type
  TfrmMostraLimiteEstoqMax = class(TfrmPaiEdit)
    cxvItens: TcxGridDBTableViewCitel;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxvItensCODITE: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensSIGUNI: TcxGridDBColumn;
    cxvItensCODEMP: TcxGridDBColumn;
    cxvItensQTDCOM: TcxGridDBColumn;
    cxvItensQTDREQ: TcxGridDBColumn;
    cxvItensSALDIS: TcxGridDBColumn;
    cxvItensESTMAX: TcxGridDBColumn;
    cxvItensQTDEXC: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMostraLimiteEstoqMax: TfrmMostraLimiteEstoqMax;

implementation

{$R *.dfm}

end.
