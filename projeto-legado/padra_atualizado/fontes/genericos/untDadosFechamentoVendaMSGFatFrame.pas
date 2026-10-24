unit untDadosFechamentoVendaMSGFatFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaMSGFatFrame = class(TFrame)
    pnlDados: TPanel;
    lblMensagem: TLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    edtMens03: TEditFocus;
    edtMens04: TEditFocus;
    edtMens05: TEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
