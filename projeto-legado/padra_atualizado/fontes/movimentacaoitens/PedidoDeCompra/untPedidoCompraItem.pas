unit untPedidoCompraItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls, Data.DB;

type
  TValidaCampos = Function(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean Of Object;

  TfrmPedidoCompraItem = class(TfrmPaiEdit)
    pnlTotPed: TPanel;
    Label13: TLabel;
    lblTotIpi: TLabel;
    Label16: TLabel;
    lblTotGer: TLabel;
    lblLitragem: TLabel;
    lblTotSubRod: TLabel;
    Label26: TLabel;
    dbeTotIte: TDBEdit;
    dbeTotSub: TDBEdit;
    dbeTotIpi: TDBEdit;
    dbeTotGer: TDBEdit;
    dbeTotLit: TDBEdit;
    dbeTotPes: TDBEdit;
    dtsItensPedido: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fValidaCamposPedido: TValidaCampos;

    winControl: TWinControl;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPedidoCompraItem: TfrmPedidoCompraItem;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmPedidoCompraItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: Begin
                 If fValidaCamposPedido(ActiveControl, True) Then
                   SelectNext(ActiveControl, True, True);

                 Key := 0;
               End;

    VK_Escape: Key := 0;
  End;

end;

procedure TfrmPedidoCompraItem.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(winControl);
end;

function TfrmPedidoCompraItem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin
  Result := fValidaCamposPedido(Sender, blnBuscaPorChave);
End;


end.
