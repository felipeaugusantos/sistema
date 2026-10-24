unit untJustificaNegativa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCtrls, DBMemoFocus, MemoFocus;

type
  TfrmJustificaNegativa = class(TfrmPaiConfirma)
    pnlJustif: TPanel;
    mmoJUSTIF: TMemoFocus;
    Panel1: TPanel;
    rdgMotNeg: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgMotNegClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmJustificaNegativa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mmoJUSTIF);
end;

procedure TfrmJustificaNegativa.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    stlLista: TStringList;
    intContador: Integer;
begin
  inherited;

  If modalResult = mrOk Then
  Begin

    If fVerificaCampos Then
    Begin
      stlLista := TStringList.Create;

      For intContador := 0 To mmoJUSTIF.Lines.Count - 1 Do
        stlLista.Add(mmoJUSTIF.Lines[intContador]);

      mmoJUSTIF.Text := stlLista.Text;


      FreeAndNil(stlLista);
    End

    Else
      Action := caNone;

  End;

end;

function TfrmJustificaNegativa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = mmoJUSTIF) Then
    Begin

      If (fEmptyStr(mmoJUSTIF.Text)) Then
      Begin
        pMensagemOk('Justifique a negativa da requisição de compra!');
        Result := False;
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmJustificaNegativa.rdgMotNegClick(Sender: TObject);
begin
  inherited;
  If rdgMotNeg.ItemIndex = 1 Then
    mmoJUSTIF.Texto := rdgMotNeg.Items[1]
  Else
    mmoJUSTIF.Clear;
  pSetFocus(mmoJUSTIF);
end;

end.
