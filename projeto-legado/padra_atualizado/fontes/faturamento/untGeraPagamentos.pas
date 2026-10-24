unit untGeraPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, Uni, untPaiConfirma,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit;

type

  TfrmGeraPagamentos = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label4: TLabel;
    mskCndPag: TMaskEditFocus;
    Label30: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label11: TLabel;
    edtHistorico: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
    procedure pCarregaCentroCusto;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);


  private
    qryConCta: TUniQuery;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeraPagamentos: TfrmGeraPagamentos;

implementation

{$R *.dfm}

uses untTypesSistema, untConsultas, untFuncoesSimples, untFuncoesConsulta,
  untConstantes, untPesqAux, untCadPag, untCadCta;

procedure TfrmGeraPagamentos.btnConfirmaClick(Sender: TObject);
begin
  ModalResult := mrNone;
  If fVerificaCampos Then
  Begin
    inherited;
  End;

end;

procedure TfrmGeraPagamentos.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  inherited;
end;

procedure TfrmGeraPagamentos.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  If fPesqFornecedor(conForCompleta, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraPagamentos.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmGeraPagamentos.FormCreate(Sender: TObject);
begin
  inherited;
  qryConCta := fCriaQuery;
end;

procedure TfrmGeraPagamentos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConCta);
end;

procedure TfrmGeraPagamentos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodFor);
end;

procedure TfrmGeraPagamentos.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  If Key = '/' Then
  Begin
    If Not fCfgSis('USACTF', varBoolean) Then
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End;
  End;
end;

function TfrmGeraPagamentos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var arrLinFor: TConsultasArray;
Begin
  Result := True;
  If (Sender = edtCodFor) Then
  Begin
    If fEmptyStr(edtCodFor.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Fornecedor deve ser informado.', ['&O k']);
      Result := False
    End
    Else
    Begin
      pEdtCodSelectExit(edtCodFor, edtNomFor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor');
      If fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código do fornecedor inválido', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskCndPag) Then
    Result := fValidaCondPagamento(blnBuscaPorChave)

  Else If (Sender = edtCodPor) Then
  Begin
    If Not fEmptyStr(edtCodPor.Text) Then
    Begin
      edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
      If fEmptyStr(edtNomPor.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Código do portador inválido', ['&O k']);
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
          edtNomPor.Text := '';
          Result := False;
        End;
      End;
    End
    Else
    begin
      edtNomPor.Clear;

      If (fCfgSis('CTPOBP', varBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStatusCndPag(mskCndPag.Text) = A_VISTA) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do portador deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    end;
  End

  Else If (Sender = fraCentroCusto.edtCodEve) Then
  Begin
    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    Begin
      fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
      If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
        Result := False;
      End
      Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
      Begin
        fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
        Result := False;
      End;
    End
    Else If (fCfgSis('CTPOBE', varBoolean)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = fraPlanoDeContas.MskCodCta)  And fraPlanoDeContas.MskCodCta.Enabled Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      pCarregaCentroCusto;
      If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        If fCfgSis('USACTF', varBoolean) Then
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
        Else
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

        Result := False;
      End
      Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas não permitido!', ['&O k']);

        If Not fraPlanoDeContas.MskCodCta.Enabled Then
          fraPlanoDeContas.MskCodCta.Enabled := True;
         Result := False;
      End
      Else
        Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
End;

function TfrmGeraPagamentos.fValidaCondPagamento(
  blnBuscaPorChave: Boolean): Boolean;
  Var
   strConPag: String;
begin
  Result := True;
  If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
    Result := False;
  End
  Else If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
    Result := False;
  End
  Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
  Begin
    fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(mskCndPag.Text, strConPag, VS_Date) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
    Result := False;
  End Else
  Begin
    mskCndPag.Text := strConPag;

    If fEmptyStr(strConPag) Then
      Result := False;
  End;

  If fStatusCndPag(fTiraCaracEspeciais(mskCndPag.Text)) = A_VISTA Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é permitida!', ['&O k']);
    Result := False;
  End;
end;

procedure TfrmGeraPagamentos.pCarregaCentroCusto;
begin
  If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
    Exit;

  If (Not fCfgSis('USACTF', varBoolean)) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, edtCodFor.Text);

  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    fraPlanoDeContas.MskCodCta.Text := FieldByName('CTA_CODCTA').AsString;
  End;

End;





end.
