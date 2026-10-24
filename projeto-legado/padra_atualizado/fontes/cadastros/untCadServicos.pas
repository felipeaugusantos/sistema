unit untCadServicos;

interface

uses
  Windows, Classes, Controls, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBEditFocus, Uni, AppEvnts, DB, BitBtnLockedIncrem, EditFocus,
  QColorLabel, MaskEditFocus, DBCtrls, untTriSer, frxClass,
  frxExportCSVTestabilidade, DBMemoFocus, ComboBoxFocus, Vcl.Forms,
  untFramePlanoDeContasDBEditFocus;

type
  TfrmCadServicos = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesSer: TDBEditFocus;
    dbeCodSer: TDBEditFocus;
    dtsCadSer: TDataSource;
    lbl1: TLabel;
    dbeValSer: TDBEditFocus;
    lblTmpMed: TLabel;
    dbeTmpMed: TDBEditFocus;
    pnlSerTer: TPanel;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    ColorLabel8: TColorLabel;
    dbeTercer: TDBEditFocus;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    dbeCndPag: TDBEditFocus;
    edtDesPag: TEditFocus;
    mskConPag: TMaskEditFocus;
    lblTitDesMax: TLabel;
    dbeDesMax: TDBEditFocus;
    lblPerDesMax: TLabel;
    pnlTriMunicipio: TPanel;
    Label3: TLabel;
    lbl6: TLabel;
    dbeCdLsSe: TDBEditFocus;
    dbeTriMun: TDBEditFocus;
    btnTribMunicipio: TBitBtnLocked;
    pnlTipSer: TPanel;
    lblTipSer: TLabel;
    dbeTipSer: TDBEditFocus;
    edtTipSer: TEditFocus;
    pnlEmpresa: TPanel;
    Label11: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    pnlComMec: TPanel;
    lblPerValMc: TLabel;
    lblValComMecTec: TLabel;
    Label162: TLabel;
    ColorLabel31: TColorLabel;
    lblTipComMecTec: TLabel;
    dbeComMec: TDBEditFocus;
    dbeTpCoMc: TDBEditFocus;
    dbmAplicacao: TDBMemoFocus;
    Label12: TLabel;
    lblCodGru: TLabel;
    dbeCodGru: TDBEditFocus;
    lblCusSer: TLabel;
    dbeCusSer: TDBEditFocus;
    pnlComVen: TPanel;
    lblComVen: TLabel;
    lblPerValVn: TLabel;
    lblComVenValor: TLabel;
    lblComissao: TLabel;
    cllComVen: TColorLabel;
    dbeComVen: TDBEditFocus;
    dbeTpCoVn: TDBEditFocus;
    edtDesGru: TEditFocus;
    lblSimplesNacional: TLabel;
    cmbSimplesNacional: TComboBoxFocus;
    pnlAliqISS: TPanel;
    lblPerAliqIss: TLabel;
    lblAliqIss: TLabel;
    dbeAliqISS: TDBEditFocus;
    lblRedIss: TLabel;
    dbeRedIss: TDBEditFocus;
    lblPerRedIss: TLabel;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    pnlRetIRPJ: TPanel;
    lblVLIRPJ: TLabel;
    lblRetIRPJ: TLabel;
    clReIRPJ: TColorLabel;
    dbeReIRPJ: TDBEditFocus;
    dbeVlIRPJ: TDBEditFocus;
    dbeStatus: TDBEditFocus;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    pnlCnaeFiscal: TPanel;
    Label47: TLabel;
    dbeCNAE: TDBEditFocus;
    edtNomCna: TEditFocus;
    pnlServicoTributavel: TPanel;
    Label6: TLabel;
    ColorLabel2: TColorLabel;
    dbeTribut: TDBEditFocus;
    lblPerBrd: TLabel;
    dbePerBrd: TDBEditFocus;
    clbPerBrd: TColorLabel;
    pnlRetPCC: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    ColorLabel3: TColorLabel;
    dbeRetPCC: TDBEditFocus;
    dbeValPCC: TDBEditFocus;
    pnlReformaTributaria: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label10: TLabel;
    dbeIndOpe: TDBEditFocus;
    dbeClaTri: TDBEditFocus;
    dbtClaTri: TEditFocus;
    dbtIndOpe: TEditFocus;
    dbeCodNBS: TDBEditFocus;
    dbtCodNBS: TEditFocus;
    lblIBPT_F: TLabel;
    dbeIBPT_F: TDBEditFocus;
    lblIBPT_FP: TLabel;
    lblIBPT_M: TLabel;
    dbeIBPT_M: TDBEditFocus;
    lblIBPT_MP: TLabel;
    lblNatOpe: TLabel;
    dbeNatOpe: TDBEditFocus;
    lblIBPT_E: TLabel;
    dbeIBPT_E: TDBEditFocus;
    lblIBPT_EP: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeTipSerKeyPress(Sender: TObject; var Key: Char);
    function dbeTipSerChamaCadastro(Key: Word): string;
    function dbeCodForChamaCadastro(Key: Word): string;
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    function dbeCodCtaChamaCadastro(Key: Word): string;
    function dbeCndPagChamaCadastro(Key: Word): string;
    procedure dbeCndPagKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnTribMunicipioClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dtsCadSerStateChange(Sender: TObject);
    procedure dbeTpCoMcExit(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    function dbeCodEmpChamaCadastro(Key: Word): string;
    procedure btnExcluirClick(Sender: TObject);
    procedure dbmAplicacaoKeyPress(Sender: TObject; var Key: Char);
    function dbeCodGruChamaCadastro(Key: Word): string;
    procedure dbeCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTpCoVnExit(Sender: TObject);
    procedure cmbSimplesNacionalChange(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCNAEKeyPress(Sender: TObject; var Key: Char);
    procedure dbeClaTriKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodNBSKeyPress(Sender: TObject; var Key: Char);
    procedure dbeIndOpeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    blnTrSeCi : Boolean;
    objTriSer : TTriSer;
    blnSerEmp : Boolean;
    strPlanoContasOri: String;
    function fServicoVazioCadastrado: Boolean;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pBeforePostTriSer(DataSet: TDataSet);
    procedure pAtualizaCampos(DataSet: TDataSet);
    procedure pCarregaDescricoes;
    procedure pLimpaCamposReformaTributaria;
  protected
    qryCadSer: TUniQuery;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Variants, StrUtils, untConsultas, untFuncoes, untFuncoesSimples,
     untPai, untFuncIns, untConstantes,
     untTypesSistema, untPanelCxServico, untPnlDadosServico, untLiberacao, untLiberacaoFactory;

{$R *.dfm}

{ TfrmCadServicos }

function TfrmCadServicos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    strCndTmp : String;
begin
  Result := True;

  If (Sender = dbeCodSer) Then
  Begin
    If (fEmptyStr(dbeCodSer.Text)) And (dbeCodSer.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Serviço deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;
  End

  Else If (Sender = dbeDesSer) Then
  Begin
    If (fEmptyStr(dbeDesSer.Text)) Then
    Begin
      If (fServicoVazioCadastrado) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do serviço deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeValSer) Then
  Begin
    If fStrToFloat(dbeValSer.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do serviço não pode ser negativo!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeDesMax) And dbeDesMax.Visible Then
  Begin
    If (fStrToFloat(dbeDesMax.Text) < 0) Or (fStrToFloat(dbeDesMax.Text) > 100) Then
    Begin
      fMensagem('ATENÇÃO!', 'O desconto máximo deve estar entre 0 e 100%!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbePerBrd) and (dbePerBrd.Visible) Then
  Begin

    If fEmptyStr(dbePerBrd.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Permite Brindes deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Not MatchStr(dbePerBrd.Text, ['S','N'])) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe (S)im ou (N)ão no campo Permite Brindes', ['&Ok']);
      Result := False;
    End
  End

  Else If (Sender = dbeCusSer) And dbeCusSer.Visible Then
  Begin
    If (dbeTercer.Text = 'S') and (fStrToFloat(dbeCusSer.Text) = 0) Then
    Begin
      fMensagem('ATENÇÃO', 'Informe o custo do serviço!', ['&O k']);
      Result := False;
    End
    Else If fStrToFloat(dbeCusSer.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do custo do serviço não pode ser negativo!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeTercer) Then
  Begin
    If Pos(dbeTercer.Text,'S_N_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe (S)im ou (N)ão no campo Serviço Terceirizado!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If (dbeTercer.Text = 'N') Then
      Begin
        edtNomFor.Text    := '';
        dbeCodFor.Text    := '';
        dbeCodFor.Enabled := False;
        fraPlanoDeContas.edtDesCta.Text    := '';
        fraPlanoDeContas.dbeCodCta.Text    := '';
        fraPlanoDeContas.dbeCodCta.Enabled := False;
        edtDesPag.Text    := '';
        dbeCndPag.Text    := '';
        dbeCndPag.Enabled := False;
        mskConPag.Text    := '';
        mskConPag.Enabled := False;
      End
      Else
      Begin
        dbeCodFor.Enabled := True;
        fraPlanoDeContas.dbeCodCta.Enabled := True;
        dbeCndPag.Enabled := True;
        mskConPag.Enabled := True;
      End;
    End;
  End

  Else If (Sender = dbeTmpMed) And dbeTmpMed.Visible Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(dbeTmpMed.Text, True, True, True, True)) Then
    Begin
      dbeTmpMed.Field.Value := Null;
    End
    Else If StrToTimeDef(dbeTmpMed.Text, -1) = -1 Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o tempo médio corretamente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeCNAE) And (pnlCnaeFiscal.Visible) Then
  Begin
    If Not fEmptyStr(dbeCNAE.Text) Then
    Begin
      edtNomCna.Text := fRetNomeCnaeSelec(dbeCNAE.Text);
      If fEmptyStr(edtNomCna.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'CNAE não cadastrado!', ['&OK']);
        Result := False;
      End
    End
    Else
      edtNomCna.Clear;
  End

  Else If (Sender = dbeCodNBS) And (pnlReformaTributaria.Visible) Then
  Begin
    If Not fEmptyStr(dbeCodNBS.Text) Then
    Begin
      dbtCodNBS.Text := fRetDescricaoNBS(dbeCodNBS.Text);
      If fEmptyStr(dbtCodNBS.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'NBS não cadastrado!', ['&OK']);
        Result := False;
      End
    End
    Else
      dbtCodNBS.Clear;
  End

  Else If (Sender = dbeClaTri) And (pnlReformaTributaria.Visible) Then
  Begin
    If Not fEmptyStr(dbeClaTri.Text) Then
    Begin
      dbtClaTri.Text := fRetDescricaoClaFisReformaTributaria(dbeClaTri.Text);
      If fEmptyStr(dbtClaTri.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Classificação Tributária não cadastrada!', ['&OK']);
        Result := False;
      End
    End
    Else
      dbtClaTri.Clear;
  End

  Else If (Sender = dbeIndOpe) And (pnlReformaTributaria.Visible) Then
  Begin
    If Not fEmptyStr(dbeIndOpe.Text) Then
    Begin
      dbtIndOpe.Text := fRetDescricaoIndicadorOperacaoServico(dbeIndOpe.Text);
      If fEmptyStr(dbtIndOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Indicador de Operação não cadastrado!', ['&OK']);
        Result := False;
      End
    End
    Else
      dbtIndOpe.Clear;
  End

  Else If (Sender = dbeTipSer) And pnlTipSer.Visible Then
  Begin
    If Not fEmptyStr(dbeTipSer.Text) Then
    Begin
      edtTipSer.Text := fRetDesTipoServico(dbeTipSer.Text);
      If fEmptyStr(edtTipSer.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Tipo de serviço não cadastrado!', ['&O k']);
        Result := False;
      End
    End
    Else
      edtTipSer.Clear;
  End

  Else If (Sender = dbeCodEmp) And (pnlEmpresa.Visible) Then
  Begin
    If Not fEmptyStr(dbeCodEmp.Text) Then
    Begin
      edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Empresa não cadastrada!', ['&OK']);
        Result := False;
      End
    End
    Else
      edtNomEmp.Clear;
  End

  Else If (Sender = dbeCodGru) Then
  Begin
    If (Not fEmptyStr(dbeCodGru.Text)) Then Begin
      edtDesGru.Text := fRetNomeGrupoServico(dbeCodGru.Text);

      If (fEmptyStr(edtDesGru.Text)) Then Begin
        fMensagem('ATENÇÃO', 'Grupo de Serviço não cadastrada!', ['&OK']);
        Result := False;
      End;
    End Else Begin
      fMensagem('ATENÇÃO', 'Informe um Grupo de Serviço!', ['&OK']);
      edtDesGru.Clear();
      Result := False;
    End;
  End

  Else If (Sender = dbeCodFor) Then
  Begin
    If Not fEmptyStr(dbeCodFor.Text) Then
    Begin
      edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
      If fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Fornecedor não encontrado!', ['&O k']);
        Result := False;
      End
    End
    Else
    Begin
      If (dbeTercer.Text = 'S') Then
      Begin
        If fEmptyStr(dbeCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Informe o fornecedor!', ['&O k']);
          Result := False;
        End;
      End;
      edtNomFor.Clear;
    End;
  End

  Else If (Sender = fraPlanoDeContas.dbeCodCta) Then
  Begin
    If Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
    Begin
      If (qryTabela.State = dsInsert) Then
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.dbeCodCta.Text);

        If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
          Result := False;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.dbeCodCta.Text);
        If strPlanoContasOri <> fraPlanoDeContas.dbeCodCta.Text Then
        Begin
          If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
            Result := False;
        End;
      End;

      If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Plano de Contas não encontrado!', ['&O k']);
        Result := False;
      End
    End
    Else
    Begin
      If (dbeTercer.Text = 'S') Then
      Begin
        If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Informe o Plano de Contas!', ['&O k']);
          Result := False;
        End;
      End;
      fraPlanoDeContas.edtDesCta.Clear;
    End;
  End

  Else If (Sender = dbeCndPag) Or (Sender = mskConPag) Then
  Begin

    If (fCfgSis('USACND', varBoolean)) Then
    Begin

      If Not fEmptyStr(dbeCndPag.Text) Then
      Begin
        edtDesPag.Text := fRetDesConPag(dbeCndPag.Text);
        If fEmptyStr(edtDesPag.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Condição de Pagamento não encontrada!', ['&O k']);
          Result := False;
        End;

        If Result Then
        Begin
          strCndTmp := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [dbeCndPag.Text]);

          If StrToIntDef( LeftStr(strCndTmp, 2), 0 ) > 24 Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido utilizar mais do que 24 parcelas!', ['&O k']);
            Result := False;
          End;
        End;

      End
      Else
      Begin
        If (dbeTercer.Text = 'S') Then
        Begin
          If fEmptyStr(dbeCndPag.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Informe a condição de pagamento!', ['&O k']);
            Result := False;
          End;
        End;
        edtDesPag.Clear;
      End;

    End
    Else
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskConPag.Text)) Then
      Begin
        strCndTmp := LeftStr(mskConPag.Text, 2);

        If (Pos(' ', strCndTmp) > 0) Or (Not fValidaCndPag(mskConPag.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&Ok']);
          Result := False;
        End;

      End Else If (dbeTercer.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO', 'Informe a condição de pagamento!', ['&O k']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = dbeTpCoMc) Then
  Begin
    If pnlComMec.Visible Then
    Begin
      If (Pos(dbeTpCoMc.Text, 'P_V_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de comissão do mecânico deve ser (P)ercentual ou (V)alor!', ['&OK']);
        Result := False;
      End;

      lblPerValMc.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
    End;
  End

  Else If (Sender = dbeStatus) Then
  Begin

    If fEmptyStr(dbeStatus.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Situação do Serviço deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Pos(dbeStatus.Text, 'S_N_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe (S)im ou (N)ão no campo Ativo!', ['&Ok']);
      Result := False;
    End
  End


  Else If (Sender = dbeTpCoVn) Then
  Begin
    If pnlComVen.Visible Then
    Begin
      If (Pos(dbeTpCoVn.Text, 'P_V_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de comissão do vendedor deve ser (P)ercentual ou (V)alor!', ['&OK']);
        Result := False;
      End;

      lblPerValVn.Caption := IIF(dbeTpCoVn.Text = 'V', '$', '%');
    End;
  End

  Else If (Sender = dbeComMec) Then
  Begin

    If pnlComMec.Visible Then
    Begin
      If Not fEmptyStr(dbeComMec.Text) Then
      Begin
        If (dbeTpCoMc.Text = 'V') Then
        Begin
          If fStrToFloat(dbeComMec.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A comissão do mecânico deve ser maior ou igual a zero!', ['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          If Not fValidaEscala(dbeComMec.Text, 0, 100) Then
          Begin
            fMensagem('ATENÇÃO!', 'A comissão do mecânico deve estar entre 0 e 100!', ['&OK']);
            Result := False;
          End;
        End;
      End
      Else
        dbeComMec.Text := '0,00';
    End;
  End

  Else If (Sender = dbeComVen) Then
  Begin

    If pnlComVen.Visible Then
    Begin
      If Not fEmptyStr(dbeComVen.Text) Then
      Begin
        If (dbeTpCoVn.Text = 'V') Then
        Begin
          If fStrToFloat(dbeComVen.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A comissão do vendedor deve ser maior ou igual a zero!', ['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          If Not fValidaEscala(dbeComVen.Text, 0, 100) Then
          Begin
            fMensagem('ATENÇÃO!', 'A comissão do vendedor deve estar entre 0 e 100!', ['&OK']);
            Result := False;
          End;
        End;
      End
      Else
        dbeComVen.Text := '0,00';
    End;
  End

  Else If (sender = dbeAliqISS) Then
  Begin

    If pnlAliqISS.Visible Then
    Begin
      If Not fEmptyStr(dbeAliqISS.Text) Then
      Begin
        If fStrToFloat(dbeAliqISS.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A alíquota de ISS deve ser maior ou igual a zero!', ['&OK']);
          Result := False;
        End;
      End
      Else
        dbeAliqISS.Text := '0,00';
    End;

  End

  Else If (sender = dbeRedISS) Then
  Begin

    If pnlAliqISS.Visible Then
    Begin
      If Not fEmptyStr(dbeRedISS.Text) Then
      Begin
        If fStrToFloat(dbeRedISS.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A redução de ISS deve ser maior ou igual a zero!', ['&OK']);
          Result := False;
        End;
      End
      Else
        dbeRedISS.Text := '0,00';
    End;

  End

  Else If (sender = dbeIBPT_F) Then
  Begin
    If Not fEmptyStr(dbeIBPT_F.Text) Then
    Begin
      If fStrToFloat(dbeIBPT_F.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de IBPT Federal deve ser maior ou igual a zero!', ['&OK']);
        Result := False;
      End;
    End
    Else
      dbeIBPT_F.Text := '0,00';
  End

  Else If (sender = dbeIBPT_E) Then
  Begin
    If Not fEmptyStr(dbeIBPT_E.Text) Then
    Begin
      If fStrToFloat(dbeIBPT_E.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de IBPT Estadual deve ser maior ou igual a zero!', ['&OK']);
        Result := False;
      End;
    End
    Else
      dbeIBPT_E.Text := '0,00';
  End

  Else If (sender = dbeIBPT_M) Then
  Begin
    If Not fEmptyStr(dbeIBPT_M.Text) Then
    Begin
      If fStrToFloat(dbeIBPT_M.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de IBPT Municipal deve ser maior ou igual a zero!', ['&OK']);
        Result := False;
      End;
    End
    Else
      dbeIBPT_M.Text := '0,00';
  End

  else if (Sender = dbeRetPCC) and (pnlRetPCC.Visible) then
  begin
    if fEmptyStr(dbeRetPCC.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O Campo "Retém PIS/COFINS/CSLL" deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else If Pos(dbeRetPCC.Text,'SN') <= 0 Then
    begin
      fMensagem('ATENÇÃO!', 'O Campo "Retém PIS/COFINS/CSLL", deve ser "S" ou "N"!', ['&Ok']);
      Result := False;
    end;
  end

  Else If (sender = dbeValPCC) Then
  Begin

    If pnlRetPCC.Visible Then
    Begin
      If Not fEmptyStr(dbeValPCC.Text) Then
      Begin
        If fStrToFloat(dbeValPCC.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor mínimo de faturamento para retenção - PIS/COFINS/CSLL deve ser maior ou igual a zero!', ['&OK']);
          Result := False;
        End;
      End
      Else
        dbeValPCC.Text := '0,00';
    End;

  End

  else if (Sender = dbeReIRPJ) and (pnlRetIRPJ.Visible) then
  begin
    if fEmptyStr(dbeReIRPJ.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O Campo "RetémIRPJ" deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else If Pos(dbeReIRPJ.Text,'SN') <= 0 Then
    begin
      fMensagem('ATENÇÃO!', 'O Campo "Retém IRPJ", deve ser "S" ou "N"!', ['&Ok']);
      Result := False;
    end;
  end

  Else If (Sender = dbeTribut ) And pnlServicoTributavel.visible Then
  Begin
    If Pos(dbeTribut.Text,'S_N_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe (S)im ou (N)ão no campo Serviço Tributável!', ['&Ok']);
      Result := False;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadServicos.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('SER_VALSER')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_VALSER')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_COMMEC')).DisplayFormat := '#,##0.0000';
  TFloatField(DataSet.FieldByName('SER_COMVEN')).DisplayFormat := '#,##0.0000';
  TFloatField(DataSet.FieldByName('SER_VALCUS')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_VALCUS')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_DESMAX')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_DESMAX')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_ALQISS')).DisplayFormat := fDisplayFormatUsandoCampo('CADSER','SER_ALQISS');
  TFloatField(DataSet.FieldByName('SER_VLIRPJ')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_VLIRPJ')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_VALPCC')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_VALPCC')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_IBPT_F')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_IBPT_F')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_IBPT_E')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_IBPT_E')).EditFormat    := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_IBPT_M')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('SER_IBPT_M')).EditFormat    := '#,##0.00';

  TTimeField(DataSet.FieldByName('SER_TMPMED')).EditMask      := '99:99';
  TTimeField(DataSet.FieldByName('SER_TMPMED')).DisplayFormat := 'hh:mm';

  TStringField(DataSet.FieldByName('SER_CODNBS')).EditMask    := '9.9999.99.99;0;';
end;

procedure TfrmCadServicos.pAfterScroll(DataSet: TDataSet);
begin
  pAtualizaCampos(DataSet);
end;

procedure TfrmCadServicos.pAtualizaCampos(DataSet: TDataSet);
begin
  edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
  fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.dbeCodCta.Text);
  edtDesPag.Text := fRetDesConPag(dbeCndPag.Text);
  mskConPag.Text := DataSet.FieldByName('SER_CNDPAG').AsString;
  If pnlTipSer.Visible Then
    edtTipSer.Text := fRetDesTipoServico(dbeTipSer.Text);
  If (pnlEmpresa.Visible) Then
    edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  If (pnlComMec.Visible) Then
    lblPerValMc.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
  If (pnlComVen.Visible) Then
    lblPerValVn.Caption := IIF(dbeTpCoVn.Text = 'V', '$', '%');
end;

procedure TfrmCadServicos.pBeforePost(DataSet: TDataSet);
begin
  If fEmptyStr(DataSet.FieldByName('SER_CODEMP').AsString) Then
    DataSet.FieldByName('SER_CODEMP').Value := Null;

  If fEmptyStr(DataSet.FieldByName('SER_CODCND').AsString) Then
    DataSet.FieldByName('SER_CODCND').Value := Null;

  If fEmptyStr(DataSet.FieldByName('SER_CODCTA').AsString) Then
    DataSet.FieldByName('SER_CODCTA').Value := Null;

  If fEmptyStr(DataSet.FieldByName('SER_CODFOR').AsString) Then
    DataSet.FieldByName('SER_CODFOR').Value := Null;

  If fEmptyStr(DataSet.FieldByName('SER_TIPSER').AsString) Then
    DataSet.FieldByName('SER_TIPSER').Value := Null;

  If fEmptyStr(DataSet.FieldByName('SER_CODGRU').AsString) Then
    DataSet.FieldByName('SER_CODGRU').Value := Null;
end;

procedure TfrmCadServicos.pBeforePostTriSer(DataSet: TDataSet);
begin
  If fEmptyStr(DataSet.FieldByName('TSE_CODSER').AsString) Then
    DataSet.FieldByName('TSE_CODSER').Value := Null;

  If fEmptyStr(DataSet.FieldByName('TSE_CODCID').AsString) Then
    DataSet.FieldByName('TSE_CODCID').Value := Null;
end;

procedure TfrmCadServicos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SER_CODSER');
  stlCampos.Add('SER_DESSER');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SER_DESSER');
  stlCamInd.Add('SER_CODSER');
  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');

end;

procedure TfrmCadServicos.pLimpaCamposReformaTributaria;
begin
  dbtCodNBS.Clear;
  dbtClaTri.Clear;
  dbtIndOpe.Clear;
  edtDesGru.Clear;
end;

procedure TfrmCadServicos.FormCreate(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;
  blnSerEmp := fCfgSis('SEREMP', varBoolean);

  blnIgnorarCodEmp := blnSerEmp;

  strNomeTabela := 'CADSER';
  strNomeCampo  := 'SER_CODSER';

  strSQL        := 'SELECT * FROM CADSER';
  qryCadSer     := fCriarQuery(strSQL, Self);
  qryTabela     := qryCadSer;
  dtsCadSer.DataSet := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.AfterScroll := pAfterScroll;
  qryTabela.BeforePost := pBeforePost;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodSer;

  If Not fCfgSis('AUTCEN', varBoolean) Then
  Begin
    lblCusSer.Visible := False;
    dbeCusSer.Visible := False;

    if Not fCfgSis('CONEQU', varBoolean) Then
    begin
      lblTmpMed.Visible := False;
      dbeTmpMed.Visible := False;
    end;

    pnlTipSer.Visible := False;
    pnlSerTer.Visible := False;
    Self.Height := Self.Height - pnlTipSer.Height;
    Self.Height := Self.Height - pnlSerTer.Height;
  End;

  blnTrSeCi := fCfgSis('TRSECI', varBoolean);
  if blnTrSeCi then
  Begin
    objTriSer := TTriSer.Create(Self);
    objTriSer.BeforePost := pBeforePostTriSer;
    pnlTriMunicipio.Visible := False;
    Self.Height := Self.Height - pnlTriMunicipio.Height;
  End;
  btnTribMunicipio.Visible := blnTrSeCi;


  pnlComMec.Visible := ( (fCfgSis('AUTCEN', VarBoolean)) And (fCfgSis('OPCMEC', VarString ) = 'CPS') ) //Opcao de Comissao Mecanico: (C)adastro de (P)rodutos/(S)ervicos
                             Or (fCfgSis('TPCOSE', varString) = '2');

  If (pnlComMec.Visible) Then Begin
    If (fCfgSis('AUTCEN', VarBoolean)) Then Begin
      lblTipComMecTec.Caption := 'Mecânico:';
      lblValComMecTec.Caption := 'Comissão do Mecânico:';
    End Else Begin
      lblTipComMecTec.Caption := 'Técnico:';
      lblValComMecTec.Caption := 'Comissão do Técnico:';
    End;
  End;

  pnlComVen.Visible := (fCfgSis('OPCVEN', VarString ) = 'CPS');//Opcao de Comissao Vendedor: (C)adastro de (P)rodutos/(S)ervicos

  pnlAliqISS.Visible := fCfgSis('ISSSER', VarBoolean);

  lblIBPT_F.Visible  := False;
  dbeIBPT_F.Visible  := False;
  lblIBPT_FP.Visible := False;

  lblIBPT_E.Visible  := False;
  dbeIBPT_E.Visible  := False;
  lblIBPT_EP.Visible := False;

  lblIBPT_M.Visible  := False;
  dbeIBPT_M.Visible  := False;
  lblIBPT_MP.Visible := False;

  If fCfgSis('IBPTNS', VarBoolean) Then
  Begin
    lblIBPT_F.Visible  := True;
    dbeIBPT_F.Visible  := True;
    lblIBPT_FP.Visible := True;

    lblIBPT_E.Visible  := True;
    dbeIBPT_E.Visible  := True;
    lblIBPT_EP.Visible := True;

    lblIBPT_M.Visible  := True;
    dbeIBPT_M.Visible  := True;
    lblIBPT_MP.Visible := True;
  End;

  pnlEmpresa.Visible := blnSerEmp;
  pnlRetIRPJ.Visible := fCfgSis('IRCSER', VarBoolean);
  pnlRetPCC.Visible  := fCfgSis('PCCSER', VarBoolean);

  pnlServicoTributavel.Visible := fCfgSis('ENOMET', VarBoolean);

  dbePerBrd.Visible := fCfgSis('USABRI', VarBoolean);
  lblPerBrd.Visible := dbePerBrd.Visible;
  clbPerBrd.Visible := dbePerBrd.Visible;

  dbeNatOpe.Visible := fCfgSis('NSNATP', VarBoolean);
  lblNatOpe.Visible := dbeNatOpe.Visible;

  If Not pnlComMec.Visible Then
    Self.Height := Self.Height - pnlComMec.Height;

  If Not pnlComVen.Visible Then
    Self.Height := Self.Height - pnlComVen.Height;

  If Not pnlAliqISS.Visible Then
    Self.Height := Self.Height - pnlAliqISS.Height;

  If Not pnlEmpresa.Visible Then
    Self.Height := Self.Height - pnlEmpresa.Height;

  If Not pnlRetIRPJ.Visible Then
    Self.Height := Self.Height - pnlRetIRPJ.Height;

  If Not pnlRetPCC.Visible Then
    Self.Height := Self.Height - pnlRetPCC.Height;
end;

procedure TfrmCadServicos.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* VERIFICA SE USA CADASTRO DE CONDICAO  *}
  {* DE PAGAMENTO                          *}
  {**************************************MM*}
  If (fCfgSis('USACND', varBoolean)) Then
  Begin
    dbeCndPag.Visible := True;
    edtDesPag.Visible := True;
    mskConPag.Visible := False;
  End
  Else
  Begin
    dbeCndPag.Visible := False;
    edtDesPag.Visible := False;
    mskConPag.Visible := True;
  End;

  lblSimplesNacional.Visible := fCfgSis('SIMPAU', varBoolean);
  cmbSimplesNacional.Visible := lblSimplesNacional.Visible;

  pnlCnaeFiscal.Visible      := fCfgSis('CNAESV', varBoolean);

  pSetFocus(btnIncluir);
end;

procedure TfrmCadServicos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if Assigned(objTriSer) And objTriSer.Active then
    objTriSer.EmptyDataSet;

  If (Not fEmptyStr(qryTabela.FieldByName('SER_TIPTAB').AsString)) Then
    cmbSimplesNacional.ItemIndex := qryTabela.FieldByName('SER_TIPTAB').AsInteger - 2
  Else
    cmbSimplesNacional.ItemIndex := -1;

  pCarregaDescricoes;
end;

procedure TfrmCadServicos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadServicos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pAtualizaCampos(qryTabela);
end;

procedure TfrmCadServicos.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If (qryTabela.State In [dsInsert, dsEdit]) Then
    Begin
      If Not (fCfgSis('USACND', varBoolean)) Then
      Begin
        qryTabela.FieldByName('SER_CNDPAG').AsString := fTiraCaracEspeciais(mskConPag.Text);
        qryTabela.FieldByName('SER_CODCND').Clear;
      End
      Else
        qryTabela.FieldByName('SER_CNDPAG').Clear;
    End;

    inherited;

    If blnGravou Then
    Begin
      if Assigned(objTriSer) then
      Begin
        objTriSer.fPreparaParaSalvar(qryTabela.FieldByName('SER_CODSER').AsString );
        objTriSer.fSalva;
      End;

      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadServicos.btnGravarClick]');
    End;
  End;

  pAtualizaCampos(qryTabela);
end;

procedure TfrmCadServicos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodSer, dbeDesSer, False)
  Else
    pHabilitaCodigo(dbeCodSer, dbeCodSer, True);

  If qryTabela.State In [dsInsert] Then
  Begin
    dbeComMec.Field.AsFloat   := 0.000;
    dbeComVen.Field.AsFloat   := 0.000;
    dbeAliqISS.Field.AsFloat  := 0.000;
    dbeRedISS.Field.AsFloat   := 0.000;
    dbeCusSer.Field.AsFloat   := 0.000;
    dbeDesMax.Field.AsFloat   := 0.000;
    dbeVlIRPJ.Field.AsFloat   := 0.000;
    dbeValPCC.Field.AsFloat   := 0.000;
    dbeIBPT_F.Field.AsFloat   := 0.000;
    dbeIBPT_E.Field.AsFloat   := 0.000;
    dbeIBPT_M.Field.AsFloat   := 0.000;
    dbeTercer.Field.AsString  := 'N';
    dbeReIRPJ.Field.AsString  := 'N';
    dbeRetPCC.Field.AsString  := 'N';
    dbeStatus.Field.AsString  := 'S';
    dbeTribut.Field.AsString  := 'N';
    dbePerBrd.Field.AsString  := 'S';

    If (blnSerEmp) And (pnlEmpresa.Visible) Then
    Begin
      dbeCodEmp.Field.AsString := VS_strCodEmp;
      edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
    End;

    qryTabela.FieldByName('SER_TIPTAB').AsString := '';
    cmbSimplesNacional.ItemIndex := -1;
    pLimpaCamposReformaTributaria;
  end;
end;

procedure TfrmCadServicos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrServ: TConsultasArray;
    objfrmPnl : TPanelCxServico;
begin
  {*******************************}
  {* NOVA CONSULTA DE SERVIÇOS   *}
  {****************************RV*}
  chrKey := '/';
  objfrmPnl := TPanelCxServico.Create(TfrmPnlDadosServico);
  If fPesqServicos(Self, Nil, Nil, qryTabela, chrKey, arrServ, True,
                   fCfgSis('AUTCEN', varBoolean), objfrmPnl, True) Then Begin
    pSetFocus(btnAlterar);
    pLimpaCamposReformaTributaria;
    pCarregaDescricoes;

    If (Not fEmptyStr(qryTabela.FieldByName('SER_TIPTAB').AsString)) Then
      cmbSimplesNacional.ItemIndex := qryTabela.FieldByName('SER_TIPTAB').AsInteger - 2
    Else
      cmbSimplesNacional.ItemIndex := -1;

    fraPlanoDeContas.dbeCodCta.Field.EditMask := '99.99.999;0;_';
    strPlanoContasOri := '';
  End;
end;

procedure TfrmCadServicos.pCarregaDescricoes;
begin
  edtDesGru.Text := fRetNomeGrupoServico(dbeCodGru.Text);
  edtNomCna.Text := fRetNomeCnaeSelec(dbeCNAE.Text);
  dbtCodNBS.Text := fRetDescricaoNBS(dbeCodNBS.Text);
  dbtClaTri.Text := fRetDescricaoClaFisReformaTributaria(dbeClaTri.Text);
  dbtIndOpe.Text := fRetDescricaoIndicadorOperacaoServico(dbeIndOpe.Text);
end;

procedure TfrmCadServicos.btnTribMunicipioClick(Sender: TObject);
begin
  inherited;
  objTriSer.pAbreCadastro(dbeCodSer.Text);
end;

procedure TfrmCadServicos.cmbSimplesNacionalChange(Sender: TObject);
begin
  inherited;

  If (cmbSimplesNacional.Visible) And (qryTabela.Active) And (Not qryTabela.IsEmpty) Then
    qryTabela.FieldByName('SER_TIPTAB').AsString := IntToStr(cmbSimplesNacional.ItemIndex + 2);
end;

procedure TfrmCadServicos.dbeCNAEKeyPress(Sender: TObject; var Key: Char);
Var
  arrCadCnae : TConsultasArray;
begin
  inherited;
  If fPesqCNAE(conSimples, Self, dbeCNAE, Nil, Nil, Key, arrCadCnae) Then
    If fValidaCampos(dbeCNAE) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadServicos.dbeClaTriKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  If dbeClaTri.ReadOnly then
    Exit;

  If fPesqReformaTributariaClassificacaoTributaria(Self, dbeClaTri, dbtClaTri, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadServicos.dbeCodNBSKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  If dbeCodNBS.ReadOnly then
    Exit;

  If fPesqNomenclaturaDeServicos(Self, dbeCodNBS, dbtCodNBS, nil, Key, arrSel) Then
  Begin
    dbeCodNBS.Text := arrSel[0].strCodigo;
    If fValidaCampos(dbeCodNBS) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadServicos.dbeIndOpeKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;

  If dbeIndOpe.ReadOnly then
    Exit;

  If fPesqIndicadorOperacaoServicos(Self, dbeIndOpe, dbtIndOpe, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadServicos.dbeCndPagChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCnd(Key);
end;

procedure TfrmCadServicos.dbeCndPagKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCndPag: TConsultasArray;
begin
  If fPesqCondicoesPgto(Self, dbeCndPag, edtDesPag, Nil, Key, arrCndPag) Then
    If fValidaCampos(dbeCndPag) Then
      SelectNext(dbeCndPag, True, True);
end;

function TfrmCadServicos.dbeCodCtaChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

function TfrmCadServicos.dbeCodEmpChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadEmp(Key);
end;

procedure TfrmCadServicos.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCodEmp : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrCodEmp) Then
    Begin
      If fValidaCampos(dbeCodEmp, False) Then
        SelectNext(dbeCodEmp, True, True);
    End;
  End;
end;

function TfrmCadServicos.dbeCodForChamaCadastro(Key: Word): string;
begin
  inherited;
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  Result := untFuncIns.fChamaCadFor(Key);
end;

procedure TfrmCadServicos.dbeCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
    If fValidaCampos(dbeCodFor) Then
      SelectNext(dbeCodFor, True, True);
end;

function TfrmCadServicos.dbeCodGruChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadGruSer(Key);
end;

procedure TfrmCadServicos.dbeCodGruKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGruSer: TConsultasArray;
begin
  If fPesqGrupoServicos(Self, dbeCodGru, edtDesGru, nil, Key, arrGruSer) Then
    If fValidaCampos(dbeCodGru) Then
      SelectNext(dbeCodGru, True, True);
end;

function TfrmCadServicos.dbeTipSerChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaTipSer(Key);
end;

procedure TfrmCadServicos.dbeTipSerKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTipSer: TConsultasArray;
begin
  If fPesqTipoServico(Self, dbeTipSer, edtTipSer, nil, Key, arrTipSer) Then
    If fValidaCampos(dbeTipSer) Then
      SelectNext(dbeTipSer, True, True);
end;

procedure TfrmCadServicos.dbeTpCoMcExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in [dsInsert, dsEdit]) And
     (dbeTpCoMc.Text = 'V') Then
    fMensagem('', 'A comissão será calculada multiplicando o valor informado pela quantidade dos produtos/serviços', ['&OK']);
end;

procedure TfrmCadServicos.dbeTpCoVnExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in [dsInsert, dsEdit]) And
     (dbeTpCoVn.Text = 'V') Then
    fMensagem('', 'A comissão será calculada multiplicando o valor informado pela quantidade dos produtos/serviços', ['&OK']);
end;

procedure TfrmCadServicos.dbmAplicacaoKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key := strKey[1];

  If (Key = #13) And fEmptyStr(dbmAplicacao.Text) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadServicos.dtsCadSerStateChange(Sender: TObject);
begin
  inherited;

  btnTribMunicipio.Enabled   := qryTabela.State in dsEditModes;
  cmbSimplesNacional.Enabled := qryTabela.State in dsEditModes;
end;

procedure TfrmCadServicos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodSer, dbeDesSer, False);
  strPlanoContasOri := fraPlanoDeContas.dbeCodCta.Text;
end;

procedure TfrmCadServicos.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCenCus: TConsultasArray;
begin
  If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCenCus) Then
    If fValidaCampos(fraPlanoDeContas.dbeCodCta) Then
      SelectNext(fraPlanoDeContas.dbeCodCta, True, True);
end;

function TfrmCadServicos.fServicoVazioCadastrado: Boolean;
  Var
    strSQL   : String;
    qryGenSer: TUniQuery;

begin
  Try

    qryGenSer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADSER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  SER_DESSER = "" OR SER_DESSER IS NULL ';

    With qryGenSer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenSer);
  End;

end;

end.

