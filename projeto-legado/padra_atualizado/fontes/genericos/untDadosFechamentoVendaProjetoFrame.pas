unit untDadosFechamentoVendaProjetoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaProjetoFrame = class(TFrame)
    pnlDados: TPanel;
    lblProjetoCliente: TLabel;
    edtCodPrj: TEditFocus;
    edtDesPrj: TEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
