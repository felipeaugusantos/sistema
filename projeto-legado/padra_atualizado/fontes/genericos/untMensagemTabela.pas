unit untMensagemTabela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untMensagem, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, untTypesSistema;

type
  TfrmMensagemTabela = class(TfrmMensagem)
    pnlTabela: TPanel;
    lsvTabela: TListView;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    arrMensag: TStringArray;
    strDesCol: String;

  end;

var
  frmMensagemTabela: TfrmMensagemTabela;

implementation

{$R *.dfm}

procedure TfrmMensagemTabela.FormShow(Sender: TObject);
var
  j: Integer;
begin
  inherited;

  lsvTabela.Columns[0].Caption := strDesCol;

  For j := 0 To Length(arrMensag) -1 Do
  Begin
    lsvTabela.Items.Add;
    lsvTabela.Items[j].Caption := arrMensag[j];
  End;
end;

end.
