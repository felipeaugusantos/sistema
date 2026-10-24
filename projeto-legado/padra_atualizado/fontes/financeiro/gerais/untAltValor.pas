unit untAltValor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, untFuncoesSimples;

type
  TfrmAltValor = class(TfrmPaiConfirma)
    Label2: TLabel;
    edtNovoValor: TEditFocus;
    Label1: TLabel;
    edtValAtual: TEditFocus;
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

{ TfrmAltValor }

function TfrmAltValor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtNovoValor) Then
    Begin

      If (fStrToFloat(edtNovoValor.Text) = 0) Then
      Begin
        fMensagem('','Informe um valor diferente de zero!', ['&Ok']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.
