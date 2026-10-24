unit untDigDescComplemento;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons, untFuncFatTypes,
  ExtCtrls, Menus, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigDescComplemento = class(TfrmPaiSimples)
    edtDesIte: TEditFocus;
    lblDesIte: TLabel;
    pnlFundo: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strDesIte  : String;
    blnConfirma: Boolean;
  end;

var
  frmDigDescComplemento: TfrmDigDescComplemento;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmDigDescComplemento }

function TfrmDigDescComplemento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesIte) Then
    Begin

      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Item de Complemento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        strDesIte   := edtDesIte.Text;
        blnConfirma := True;
        Close;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigDescComplemento.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.
