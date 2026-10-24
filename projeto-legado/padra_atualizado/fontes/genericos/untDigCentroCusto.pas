unit untDigCentroCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untFramePlanoDeContasMaskEdit;

type
  TfrmDigCentroCusto = class(TfrmPaiEdit)
    btnConfirmaDados: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDigCentroCusto: TfrmDigCentroCusto;

implementation

uses untPai, untFuncoesSimples, untCadCta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmDigCentroCusto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) And (Not fVerificaCampos) Then
    Action := caNone;

end;

procedure TfrmDigCentroCusto.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(fraPlanoDeContas.mskCodCta);
end;

procedure TfrmDigCentroCusto.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaKeyPress(Sender, Key);
end;

function TfrmDigCentroCusto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = fraPlanoDeContas.mskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.mskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Plano de Contas', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.mskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.mskCodCta.Text);

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.mskCodCta.Text,True);
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
