unit untEntDadosVendor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untFramePlanoDeContasMaskEdit;

type
  TfrmEntDadosVendor = class(TfrmPaiConfirma)
    pnlVendor: TPanel;
    lblCliFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label7: TLabel;
    mskCndPag: TMaskEditFocus;
    pnlValVendor: TPanel;
    Label16: TLabel;
    edtValVen: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pAjustaPanel;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untCadCta, untPcmger, untTypesSistema;

{$R *.dfm}

  
procedure TfrmEntDadosVendor.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntDadosVendor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

 { If ModalResult = mrOk Then
  Begin

    If Not fVerificaCampos Then
      Action := caNone;

  End; EXECUTANDO 2X}

end;

procedure TfrmEntDadosVendor.FormShow(Sender: TObject);
begin
  inherited;

  pAjustaPanel;
  pSetFocus(edtValVen);

end;

procedure TfrmEntDadosVendor.pAjustaPanel;
Begin
  pnlVendor.Enabled := fStrToFloat(edtValVen.Text) > 0;

  If Not pnlVendor.Enabled Then
  Begin
    mskCndPag.Clear;
  End;
End;

procedure TfrmEntDadosVendor.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaKeyPress(Sender, Key);

end;

function  TfrmEntDadosVendor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtValVen) Then
    Begin

      If fStrToFloat(edtValVen.Text) < 0 Then
      Begin
        pMensagemOk('O Valor do Vendor deve ser maior ou igual a zero!');
        Result := False;
      End;

      edtValVen.Text := FormatFloat('#0.00', fStrToFloat(edtValVen.Text));

      pAjustaPanel;
    End

    Else If Sender = edtCodFor Then
    Begin

      If pnlVendor.Enabled Then
      Begin
        If fEmptyStr(edtCodFor.Text) Then
        Begin
          pMensagemOk('Informe o códido do Fornecedor!');
          Result := False;
        End Else
        Begin
          edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

          If fEmptyStr(edtNomFor.Text) Then
          Begin
            pMensagemOk('Fornecedor não encontrado!');
            Result := False;
          End

          Else If Not fFornecedorGravaCtp(edtCodFor.Text) Then
          Begin
            pMensagemOk('Esse Fornecedor está configurado para não gravar contas a pagar!');
            Result := False;
          End;

        End;
      End;

    End

    Else If (Sender = fraPlanoDeContas.mskCodCta) Then
    Begin

      If pnlVendor.Enabled And (Not fraPlanoDeContas.mskCodCta.ReadOnly) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.mskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(fraPlanoDeContas.mskCodCta.Text);

          If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.mskCodCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
            Result := False;
          End
          Else
            Result := PlanoDeContasAtivo(fraPlanoDeContas.mskCodCta.Text,True);
        End;
      End;

    End

    Else If (Sender = mskCndPag) Then
    Begin


      If pnlVendor.Enabled Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
        Begin
          fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaCndPag(mskCndPag.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
          Result := False;
        End
        
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

