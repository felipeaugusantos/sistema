unit untAcesso;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmAcesso = class(TForm)
    Label1: TLabel;
    edtSenha: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label2: TLabel;
    edtUsuario: TEdit;
    Label3: TLabel;
    edtBanco: TEdit;
    Label4: TLabel;
    edtServidor: TEdit;
    Label5: TLabel;
    edtPorta: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcesso: TfrmAcesso;

implementation

{$R *.dfm}

end.
 
