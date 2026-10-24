unit untMensagemValidacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmMensagemValidacao = class(TfrmPaiEdit)
    btnContinuar: TBitBtnLocked;
    mmoMensagem: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMensagemValidacao: TfrmMensagemValidacao;

implementation

{$R *.dfm}

end.
