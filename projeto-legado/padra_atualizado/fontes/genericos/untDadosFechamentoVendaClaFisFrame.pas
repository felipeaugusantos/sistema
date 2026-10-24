unit untDadosFechamentoVendaClaFisFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ComboBoxFocus, EditFocus, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfraDadosFechamentoVendaClaFisFrame = class(TFrame)
    pnlDados: TPanel;
    lblClaFis: TLabel;
    btnNotExp: TSpeedButton;
    edtClaFis: TEditFocus;
    edtClaFi2: TEditFocus;
    edtClaFi3: TEditFocus;
    cmbNatOpe: TComboBoxFocus;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
