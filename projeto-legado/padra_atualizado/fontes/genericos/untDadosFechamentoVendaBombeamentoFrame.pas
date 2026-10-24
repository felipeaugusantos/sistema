unit untDadosFechamentoVendaBombeamentoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaBombeamentoFrame = class(TFrame)
    pnlDados: TPanel;
    lblTotalBombeamento: TLabel;
    lblQtdBombeamento: TLabel;
    lblPrecoBombeamento: TLabel;
    edtTotBom: TEditFocus;
    edtQtdBom: TEditFocus;
    edtPrcBom: TEditFocus;
    chkTaxMin: TCheckBox;
    lblRedISS: TLabel;
    edtRedISS: TEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
