unit untDigAtencao;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons,
  ExtCtrls, Menus, AppEvnts;

type
  TfrmDigAtencao = class(TfrmPaiSimples)
    edtAtenca: TEditFocus;
    Label1: TLabel;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strAtenca: String;
    blnConfirma: Boolean;
  end;

var
  frmDigAtencao: TfrmDigAtencao;

implementation

{$R *.dfm}

{ TfrmDigAtencao }

function TfrmDigAtencao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtAtenca) Then
    Begin
      strAtenca   := edtAtenca.Text;
      blnConfirma := True;
      Close;
    End;

  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmDigAtencao.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.
