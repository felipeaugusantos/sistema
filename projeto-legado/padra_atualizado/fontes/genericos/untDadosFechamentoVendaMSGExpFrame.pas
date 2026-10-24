unit untDadosFechamentoVendaMSGExpFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaMSGExpFrame = class(TFrame)
    pnlDados: TPanel;
    lblObsExpedicao: TLabel;
    edtMenExp: TEditFocus;
    edtMenEx2: TEditFocus;
    edtMenEx3: TEditFocus;
    edtMenEx4: TEditFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
