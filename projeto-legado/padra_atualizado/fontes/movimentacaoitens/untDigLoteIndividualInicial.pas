unit untDigLoteIndividualInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmDigLoteIndividualInicial = class(TfrmPaiConfirma)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtPrefixo: TEditFocus;
    edtSequencial: TEditFocus;
    edtSufixo: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigLoteIndividualInicial: TfrmDigLoteIndividualInicial;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmDigLoteIndividualInicial }

procedure TfrmDigLoteIndividualInicial.btnConfirmaClick(Sender: TObject);
begin
  if fVerificaCampos  then
  begin
    close;
    ModalResult := mrOk;
  end;


end;

function TfrmDigLoteIndividualInicial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtSequencial) Then
  begin
    if fEmptyStr(edtSequencial.Text) then
    begin
      pMensagemOk('O campo Sequencial deve ser preenchido!');
      Result := False;
    end
    else
      edtSequencial.Text := fTiraCaracEspeciaisPonto(edtSequencial.Text);
  end;


  If Not Result Then
    pSetFocus(Sender);
end;

end.
