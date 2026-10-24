unit untEmpresaFaturamentoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, EditFocus;

type
  TfraEmpresaFaturamentoFrame = class(TFrame)
    pnlEmpFatFrame: TPanel;
    edtCodEmpFat: TEditFocus;
    edtDesEmpFat: TEditFocus;
    lblEmpFat: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
