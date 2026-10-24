unit untDadosFechamentoVendaObraFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaObraFrame = class(TFrame)
    pnlDados: TPanel;
    lblCodigoObra: TLabel;
    lblCodigoART: TLabel;
    edtCodObr: TEditFocus;
    edtCodART: TEditFocus;
    edtCodCno: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtInsImo: TEditFocus;
    Label3: TLabel;
    edtCodCib: TEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
