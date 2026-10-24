unit untPedOrdenacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmPedOrdenacao = class(TfrmPaiConfirma)
    rdgOrdenacao: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedOrdenacao: TfrmPedOrdenacao;

implementation

{$R *.dfm}

end.
