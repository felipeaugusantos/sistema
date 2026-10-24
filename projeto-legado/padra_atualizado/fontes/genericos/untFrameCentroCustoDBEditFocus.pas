unit untFrameCentroCustoDBEditFocus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DBEditFocus, untPai,
  EditFocus, Vcl.Mask, Vcl.DBCtrls,untFuncIns;

type
  {********************************************************************}
  {* apenas para acessar o método fValidaCampos do frmPai (protected) *}
  {*****************************************************************RP*}
  THackfrmPai = class(TfrmPai)
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

  TfraCentroCustoDBEditFocus = class(TFrame)
    edtDesEve: TEditFocus;
    lblEventos: TLabel;
    dbeCodEve: TDBEditFocus;
    procedure dbeCodEveKeyPress(Sender: TObject; var Key: Char);
    function dbeCodEveChamaCadastro(Key: Word): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

function TfraCentroCustoDBEditFocus.dbeCodEveChamaCadastro(Key: Word): string;
begin
  Result := fChamaCadEve(Key);
end;

procedure TfraCentroCustoDBEditFocus.dbeCodEveKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  If fPesqEventos(TForm(Self.Owner), dbeCodEve, edtDesEve, Nil, Key, arrEvento, True, True) Then
  Begin
    If THackfrmPai(Self.Owner).fValidaCampos(dbeCodEve, True) Then
      Keybd_Event(VK_TAB, 0, 0, 0);
  End;
end;

{ THackfrmPai }

function THackfrmPai.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited;
end;

end.
