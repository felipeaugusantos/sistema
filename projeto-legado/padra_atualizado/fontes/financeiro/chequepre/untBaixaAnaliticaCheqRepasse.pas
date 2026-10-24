{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untBaixaAnaliticaCheqRepasse;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Vcl.Forms, untFramePlanoDeContasMaskEdit;

type
  TfrmBaixaAnaliticaCheqRepasse = class(TfrmPai)
    Panel1: TPanel;
    lblPorDeb: TLabel;
    Label6: TLabel;
    edtCodPorDeb: TEditFocus;
    edtPorDeb: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    Label1: TLabel;
    lblPorCred: TLabel;
    edtPorCred: TEditFocus;
    edtCodPorCred: TEditFocus;
    fraPlanoDeContasDeb: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasCre: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPorDebKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtPorCredKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasDebMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasCreMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConCta: TUniQuery;

    procedure pCarregaPortador(EditPor: TEditFocus);
    procedure pCarregaCentroCusto(EditCta: TMaskEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    strPorDeb, strCtaDeb, strNomPor, strPorCred, strCtaCred, strNomPorCred: String;
    blnConfirma: Boolean;
  end;


implementation

uses SysUtils, untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmBaixaAnaliticaCheqRepasse.fraPlanoDeContasCreMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;

begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, TMaskEditFocus(Sender), fraPlanoDeContasCre.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(TMaskEditFocus(Sender), True)) Then
      SelectNext(ActiveControl, True, True);
    pCarregaCentroCusto(TMaskEditFocus(Sender));
  End;

end;

procedure TfrmBaixaAnaliticaCheqRepasse.fraPlanoDeContasDebMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;

begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, TMaskEditFocus(Sender), fraPlanoDeContasDeb.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(TMaskEditFocus(Sender), True)) Then
      SelectNext(ActiveControl, True, True);
    pCarregaCentroCusto(TMaskEditFocus(Sender));
  End;

end;

function TfrmBaixaAnaliticaCheqRepasse.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O PORTADORES                   *}
    {**************************************MV*}
    If (Sender = edtPorDeb) Then
    Begin
      If (edtPorDeb.Visible) And (edtPorDeb.Enabled) Then
      Begin
        If fEmptyStr(edtPorDeb.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador de débito deve ser preenchido!', ['&O k']);
          Result := False;
        End

        Else
        Begin
          pCarregaPortador(edtPorDeb);
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador de débito não está cadastrado!', ['&O k']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
        End;

      End;

    End;
    If (Sender = edtPorCred) Then
    Begin
      If (edtPorCred.Visible) And (edtPorCred.Enabled) Then
      Begin
        If fEmptyStr(edtPorCred.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador de crédito deve ser preenchido!', ['&O k']);
          Result := False;
        End

        Else
        Begin
          pCarregaPortador(edtPorCred);
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador de crédito não está cadastrado!', ['&O k']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
        End;

      End;

    End;

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    If (Sender = fraPlanoDeContasDeb.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasDeb.MskCodCta.Text)) Then
      Begin
        pCarregaCentroCusto(fraPlanoDeContasDeb.MskCodCta);
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas de débito não está cadastrado!', ['&O k']);
          Result := False;
        End;
        If Not PlanoDeContasAtivo(fraPlanoDeContasDeb.MskCodCta.Text) Then
          Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(edtCodPorDeb.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas de débito não pode ser nulo!', ['&O k']);
          Result := False;
        End;
      End;
    End;
    If (Sender = fraPlanoDeContasCre.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasCre.MskCodCta.Text)) Then
      Begin
        pCarregaCentroCusto(fraPlanoDeContasCre.MskCodCta);
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas de crédito não está cadastrado!', ['&O k']);
          Result := False;
        End;
        If Not PlanoDeContasAtivo(fraPlanoDeContasCre.MskCodCta.Text) Then
          Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(edtCodPorCred.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas de crédito não pode ser nulo!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmBaixaAnaliticaCheqRepasse.pCarregaPortador(EditPor: TEditFocus);
begin
  pPesquisaCadPor(Nil, qryConPor, EditPor.Text);
  With qryConPor Do
  Begin
    If EditPor.Name = 'edtPorDeb' Then
      edtCodPorDeb.Text := FieldByName('POR_NOMPOR').AsString
    else If EditPor.Name = 'edtPorCred' Then
      edtCodPorCred.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaAnaliticaCheqRepasse.pCarregaCentroCusto(EditCta: TMaskEdit);
begin
  pPesquisaCadCta(qryConCta, qryConCta, EditCta.Text);
  With qryConCta Do
  Begin
    If ((EditCta.Name = 'MskCodCta') And (ActiveControl = fraPlanoDeContasDeb.MskCodCta)) Then
      fraPlanoDeContasDeb.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString
    else If ((EditCta.Name = 'MskCodCta') And (ActiveControl = fraPlanoDeContasCre.MskCodCta)) Then
      fraPlanoDeContasCre.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaAnaliticaCheqRepasse.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  blnConfirma := False;
end;

procedure TfrmBaixaAnaliticaCheqRepasse.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPorDeb);
  edtPorDeb.Enabled := true;
  fraPlanoDeContasDeb.MskCodCta.Enabled := true;
end;

procedure TfrmBaixaAnaliticaCheqRepasse.edtPorCredKeyPress(Sender: TObject;
  var Key: Char);
Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, TEditFocus(Sender), edtCodPorCred, nil, Key, arrSel) Then
  Begin

    If (TEditFocus(Sender).Text <> EmptyStr) Then
    Begin
     If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
    End;

  End;
  pCarregaPortador(TEditFocus(Sender));

end;

procedure TfrmBaixaAnaliticaCheqRepasse.edtPorDebKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, TEditFocus(Sender), edtCodPorDeb, nil, Key, arrSel) Then
  Begin

    If (TEditFocus(Sender).Text <> EmptyStr) Then
    Begin
     If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
    End;

  End;
  pCarregaPortador(TEditFocus(Sender));

end;

procedure TfrmBaixaAnaliticaCheqRepasse.btnConfirmaDadosClick(
  Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma   := True;
    strPorDeb     := edtPorDeb.Text;
    strCtaDeb     := fraPlanoDeContasDeb.MskCodCta.Text;
    strNomPor     := edtCodPorDeb.Text;
    strPorCred    := edtPorCred.Text;
    strCtaCred    := fraPlanoDeContasCre.MskCodCta.Text;
    strNomPorCred := edtCodPorCred.Text;
    Close;
  End;
end;

end.

