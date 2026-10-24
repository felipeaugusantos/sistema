unit untBaixaProfiss;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, Uni, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untLiberacao, SysUtils, untFuncoesConsulta,
  untTypesSistema, untFramePlanoDeContasMaskEdit;

type
  TfrmBaixaProfiss = class(TfrmPai)
    cbxLanCTP: TCheckBox;
    Label2: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label3: TLabel;
    edtHisBai: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    Label4: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    Label28: TLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure cbxLanCTPClick(Sender: TObject);
    procedure mskCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConCta, qryCadFor: TUniQuery;
    qryCadPor: TUniQuery;
    qryCadEve: TUniQuery;

    objLiberacao: TLiberacao;

    blnLiberadaTrocaFornecedor: Boolean;

    arrEvento: TConsultasArray;

    procedure pCarregaCentroCusto;
    procedure pCarregaFornecedor;
    procedure pCarregaPortador;
    procedure pCarregaEventos;
  public
    { Public declarations }

    strCodFor: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untCadCta, untPesqAux, untFuncoesSimples, untConsultas, Data.DB;

{$R *.dfm}

procedure TfrmBaixaProfiss.cbxLanCTPClick(Sender: TObject);
begin
  inherited;

  fraPlanoDeContas.MskCodCta.Enabled := cbxLanCTP.Checked;
  edtCodFor.Enabled := cbxLanCTP.Checked;
  edtCodEve.Enabled := cbxLanCTP.Checked;
  edtHisBai.Enabled := cbxLanCTP.Checked;

end;

procedure TfrmBaixaProfiss.pCarregaCentroCusto;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, edtCodFor.Text);
    
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaProfiss.mskCtaBaiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text ) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
      pCarregaCentroCusto;
    End;
  End;
end;


function TfrmBaixaProfiss.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not cbxLanCTP.Checked Then
    Exit;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchida!', ['&O k']);
        Result := False;

      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not fCfgSis('USACTF', varBoolean) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);
            
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;
    End

    Else If (Sender = edtCodFor) And (edtCodFor.Visible) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin
        pCarregaFornecedor;
        If (qryCadFor.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If (Not fEmptyStr(strCodFor)) And
                (strCodFor <> edtCodFor.Text) And
                (Not blnLiberadaTrocaFornecedor) Then
        Begin
          objLiberacao := TLiberacao.Create;
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Alterar o fornecedor na Baixa da Comissão de Profissionais.');
          objLiberacao.objMsgLibera.pAddTexto('Fornecedor anterior: ' + strCodFor + '-' + fRetNomFornecedor(strCodFor));
          objLiberacao.objMsgLibera.pAddTexto('Fornecedor atual   : ' + edtCodFor.Text + '-' + edtNomFor.Text);

          objLiberacao.strDirAce := 'ALTFORBAICOMPROF';
          objLiberacao.strMsgSen := 'Alterar o fornecedor na Baixa da Comissão de Profissionais';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;

          blnLiberadaTrocaFornecedor := objLiberacao.fLibera;
          FreeAndNil(objLiberacao);
          Result := blnLiberadaTrocaFornecedor;

        End;

      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O Fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin
      If (Not fEmptyStr(edtCodPor.Text)) Then
      Begin
        pCarregaPortador;
        If (qryCadPor.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEve) Then
    Begin
      If Not fEmptyStr(edtCodEve.Text) Then
      Begin

        If edtCodEve.Text <> '00000' Then
           pCarregaEventos;

        If fEmptyStr(edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse evento pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesEve.Clear;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmBaixaProfiss.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryCadFor, qryCadFor, edtCodFor.Text);
  With qryCadFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmBaixaProfiss.pCarregaPortador;
begin
  pPesquisaCadPor(qryCadPor, qryCadPor, edtCodPor.Text);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaProfiss.pCarregaEventos;
begin
  pPesquisaCadEve(qryCadEve, qryCadEve, edtCodEve.Text);
  With qryCadEve Do
  Begin
    edtDesEve.Text := FieldByName('EVE_DESEVE').AsString;
  End;
end;

procedure TfrmBaixaProfiss.edtCodEveKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaProfiss.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaProfiss.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPortador: TConsultasArray;

begin
  inherited;
  
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
      If fValidaCampos(edtCodPor, True) Then
        SelectNext(ActiveControl, True, True);
      
  End;

end;

procedure TfrmBaixaProfiss.FormShow(Sender: TObject);
begin
  inherited;

  fraPlanoDeContas.MskCodCta.Enabled := cbxLanCTP.Checked;
  edtCodFor.Enabled := cbxLanCTP.Checked;
  edtHisBai.Enabled := cbxLanCTP.Checked;
  edtCodEve.Enabled := cbxLanCTP.Checked;

end;

procedure TfrmBaixaProfiss.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(cbxLanCTP);
end;

procedure TfrmBaixaProfiss.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not fVerificaCampos Then
      Action := caNone;
  End;

end;

procedure TfrmBaixaProfiss.FormCreate(Sender: TObject);
begin
  inherited;
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryCadEve := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);

  blnLiberadaTrocaFornecedor := False;
end;

end.
