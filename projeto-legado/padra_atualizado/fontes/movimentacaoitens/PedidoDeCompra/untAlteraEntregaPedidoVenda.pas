unit untAlteraEntregaPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit;

type
  TfrmAlteraEntregaPedidoVenda = class(TfrmPaiConfirma)
    Label9: TLabel;
    dbeENTVEN: TcxDBDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;override;
  end;

var
  frmAlteraEntregaPedidoVenda: TfrmAlteraEntregaPedidoVenda;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

function TfrmAlteraEntregaPedidoVenda.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If Sender = dbeENTVEN Then
    Begin

     (* If fEmptyDate(dbeENTVEN.Text) Then
      Begin
        Result := False;
        pMensagemOk('Infome a data de entrega do pedido de venda!');
      End;
       *)
    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.
