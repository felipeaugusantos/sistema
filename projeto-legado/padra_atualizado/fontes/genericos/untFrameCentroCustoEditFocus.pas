unit untFrameCentroCustoEditFocus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus, untPai;

type
  {********************************************************************}
  {* apenas para acessar o método fValidaCampos do frmPai (protected) *}
  {*****************************************************************RP*}
  THackfrmPai = class(TfrmPai)
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

  TfraCentroCustoEditFocus = class(TFrame)
    edtDesEve: TEditFocus;
    edtCodEve: TEditFocus;
    lblEventos: TLabel;
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfraCentroCustoEditFocus.edtCodEveKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  If fPesqEventos(TForm(Self.Owner), edtCodEve, edtDesEve, Nil, Key, arrEvento, True, True) Then
  Begin
    If THackfrmPai(Self.Owner).fValidaCampos(edtCodEve, True) Then
      Keybd_Event(VK_TAB, 0, 0, 0);
  End;
end;

{ THackfrmPai }

function THackfrmPai.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited;
end;

end.
