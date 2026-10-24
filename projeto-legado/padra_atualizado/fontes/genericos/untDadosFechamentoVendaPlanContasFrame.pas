unit untDadosFechamentoVendaPlanContasFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, MaskEditFocus,
  Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaPlanContasFrame = class(TFrame)
    pnlDados: TPanel;
    lblCentroCusto: TLabel;
    edtDesCta: TEditFocus;
    mskCodCta: TMaskEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
