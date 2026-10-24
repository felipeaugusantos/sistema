{***********************}
{* qryConPor -> CADPOR *}
{********************JB*}

unit untCadFormaPagamento;

interface

uses
  Windows, Classes, Controls,
  untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus, Menus, Uni,
  ComCtrls, Buttons, ExtCtrls, EditFocus, AppEvnts, QColorLabel, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, Vcl.Forms,
  untFramePlanoDeContasDBEditFocus;

type
  TfrmCadFormaPagamento = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    Label13: TLabel;
    dbeCodPor: TDBEditFocus;
    edtNomPor: TEditFocus;
    Label37: TLabel;
    dbeStatus: TDBEditFocus;
    ColorLabel2: TColorLabel;
    dtsCadFpg: TDataSource;
    dbeConCon: TDBEditFocus;
    Label3: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    chkPorPed: TDBCheckBox;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodPorExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConCta: TUniQuery;
    strPlanoContasOri: String;

    procedure pCarregaPortador(Sender: TWinControl);
    procedure pDesabilitaBotoes;
    procedure pCarregaCentroCusto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Variants, untfuncoesSimples, untConsultas, untPesqAux,
  untTypesSistema;

{$R *.dfm}

procedure TfrmCadFormaPagamento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadFormaPagamento.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'CADFPG';
  strNomeCampo      := 'FPG_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CADFPG');
  dtsCadFpg.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  qryConPor := fCriaQuery(Self);
  qryConCta := fCriaQuery(Self);
  
end;

procedure TfrmCadFormaPagamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabela);
end;

procedure TfrmCadFormaPagamento.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FPG_CODIGO');
  stlCampos.Add('FPG_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FPG_DESCRI');
  stlCamInd.Add('FPG_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadFormaPagamento.fraPlanoDeContasdbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
    strMask        : String;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    strMask := dtsCadFpg.DataSet.FieldByName('FPG_CODCTA').EditMask;
    dtsCadFpg.DataSet.FieldByName('FPG_CODCTA').EditMask := '';
    If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, qryConCta, Key, arrCentroCusto) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.dbeCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
    dtsCadFpg.DataSet.FieldByName('FPG_CODCTA').EditMask := strMask;
  End;

end;

function TfrmCadFormaPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA  O CÓDIGO                      *}
    {**************************************MA*}
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&O k']);
        Result := False;
      End
    End

    {*****************************************}
    {* VALIDA  A DESCRICAO                   *}
    {**************************************MA*}
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A SITUAÇÃO DA FORMA PAGTO      *}
    {**************************************IV*}
    Else If (Sender = dbeStatus) Then
    Begin

      If fEmptyStr(dbeStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação da Forma de Pagamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (dbeStatus.Text <> 'A') And (dbeStatus.Text <> 'I') Then
      Begin
        fMensagem('ATENÇÃO!', 'A Situação da Forma de Pagamento deve ser A ou I!', ['&Ok']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O PORTADOR                     *}
    {**************************************MA*}
    Else If (Sender = dbeCodPor) Then
    Begin

      If Not fEmptyStr(dbeCodPor.Text) Then
      Begin
        pCarregaPortador(Sender);
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = fraPlanoDeContas.dbeCodCta) Then
    Begin
      If Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
      Begin

        If (qryTabela.State = dsInsert) Then
        Begin
          pCarregaCentroCusto;

          If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
            Result := False;
        End
        Else
        Begin
          pCarregaCentroCusto;
          If strPlanoContasOri <> fraPlanoDeContas.dbeCodCta.Text Then
          Begin
            If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
            Begin
              Result := False;
              fraPlanoDeContas.dbeCodCta.Field.Text := '';
            End;
          End;
        End;

        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
        fraPlanoDeContas.edtDesCta.Clear;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadFormaPagamento.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  edtNomPor.Clear;

end;

procedure TfrmCadFormaPagamento.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If Not fEhAdministrador(strLoginUsuarioLogado) Then
  Begin
    dbeDescri.Enabled := False;
    pHabilitaCodigo(dbeCodigo, dbeCodPor, False);
  End
  Else
  Begin
    pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  End;
  strPlanoContasOri := fraPlanoDeContas.dbeCodCta.Text;

end;

procedure TfrmCadFormaPagamento.FormShow(Sender: TObject);
begin
  inherited;
  pDesabilitaBotoes;
  chkPorPed.Visible := fCfgSis('PORPED', VarBoolean);
end;

procedure TfrmCadFormaPagamento.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, dbeCodPor, edtNomPor, qryConPor, Key, arrSel) Then    
  Begin
    If fValidaCampos(dbeCodPor) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadFormaPagamento.pCarregaCentroCusto;
begin
  If Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
  Begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.dbeCodCta.Text);
    With qryConCta Do
    Begin
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    End;
  End;
end;

procedure TfrmCadFormaPagamento.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, dbeCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmCadFormaPagamento.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFormaPagamento.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pDesabilitaBotoes;
  pCarregaPortador(dbeCodPor);
end;

procedure TfrmCadFormaPagamento.dbeCodPorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(dbeCodPor.Text) Then
  Begin
    edtNomPor.Clear;
    qryTabela.FieldByName('FPG_CODPOR').Value := Null;
  End
  Else
    pCarregaPortador(dbeCodPor);
end;

procedure TfrmCadFormaPagamento.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrForma: TConsultasArray;
begin
  fraPlanoDeContas.edtDesCta.Text := '';
  {***********************************}
  {* NOVA CONSULTA DE FORMA DE PAGTO *}
  {********************************RV*}
  chrKey := '/';
  If fPesqFormaPgto(conFpgSimples, Self, Nil, Nil, qryTabela, chrKey, arrForma) Then
    pSetFocus(btnAlterar);
  pCarregaPortador(dbeCodPor);
  pCarregaCentroCusto;

  fraPlanoDeContas.dbeCodCta.Field.EditMask := '99.99.999;0;_';
  strPlanoContasOri := '';
end;

procedure TfrmCadFormaPagamento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pDesabilitaBotoes;
  pCarregaPortador(dbeCodPor);
end;

procedure TfrmCadFormaPagamento.pDesabilitaBotoes;
begin
  btnIncluir.Enabled := False;
  btnExcluir.Enabled := False;
end;

procedure TfrmCadFormaPagamento.btnGravarClick(Sender: TObject);
begin

  If fEmptyStr(dbeCodPor.Text) Then
    qryTabela.FieldByName('FPG_CODPOR').Value := Null;

  If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
    qryTabela.FieldByName('FPG_CODCTA').Value := Null;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFormaPagamento.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pDesabilitaBotoes;
end;

end.

