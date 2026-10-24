unit untMcaDetalhesBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus;

type
  TfrmMcaDetalhesBaixa = class(TfrmPai)
    Panel1: TPanel;
    lblValorTaxas: TLabel;
    lblValorFrete: TLabel;
    lblAjustesCancelamentos: TLabel;
    btnSelChEmi: TBitBtnLocked;
    edtValorDeTaxas: TEditFocus;
    edtValorDeFrete: TEditFocus;
    edtValorDeAjustes: TEditFocus;
    pnlGeral: TPanel;
    lblValorBruto: TLabel;
    edtValorBruto: TEditFocus;
    edtValorRecebido: TEditFocus;
    lblValorRecebido: TLabel;
    lblCupomDesconto: TLabel;
    edtValorDeCupomDesconto: TEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
