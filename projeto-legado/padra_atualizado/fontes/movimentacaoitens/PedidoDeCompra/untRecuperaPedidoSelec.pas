unit untRecuperaPedidoSelec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untRecuperaPedido, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRecuperaPedidoSelec = class(TfrmPaiConfirma)
    btnDescarta: TBitBtnLocked;
    cxgPedidosLevel1: TcxGridLevel;
    cxvPedidos: TcxGridDBTableViewCitel;
    cxgPedidos: TcxGridCitel;
    cxvPedidosColumn1: TcxGridDBColumn;
    cxvPedidosColumn2: TcxGridDBColumn;
    cxvPedidosColumn3: TcxGridDBColumn;
    cxvPedidosNUMPED: TcxGridDBColumn;
    cxvPedidosColumn5: TcxGridDBColumn;
    cxvPedidosColumn6: TcxGridDBColumn;
    cxvPedidosColumn7: TcxGridDBColumn;
    procedure btnDescartaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
     objRecupera: TRecuperaPedido;
  end;

var
  frmRecuperaPedidoSelec: TfrmRecuperaPedidoSelec;

implementation

{$R *.dfm}

procedure TfrmRecuperaPedidoSelec.btnDescartaClick(Sender: TObject);
begin
  inherited;

    If objRecupera.cdsPedidos.IsEmpty Then
      Exit;

    If fPergunta('Confirma o descarte da cópia de segurança do pedido selecionado?') Then
    Begin
      objRecupera.pApagaPedido(objRecupera.cdsPedidos.FieldByName('AUTINC').AsString);
      objRecupera.cdsPedidos.Delete;
    End;

End;

procedure TfrmRecuperaPedidoSelec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrok Then
  Begin

    If Not objRecupera.fMarcaPedido Then
      Action := caNone;

  End;

end;

end.
