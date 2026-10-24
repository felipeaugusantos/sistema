{****************************}
{* qryConEmp -> CADEMP     *}
{* qryConCli -> CADCLI     *}
{* qryConPor -> CADPOR     *}
{* qryConOpe -> CADOPE     *}
{* qryConCta -> CADCTA     *}
{************************FS*}
unit untGerAutCtaReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untfuncoesSimples,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Mask, MaskEditFocus,
  QColorLabel, EditFocus,  UniClientDataSet, UniDataSetProvider, Data.DB,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, untFrameCentroCustoEditFocus,
  cxStyles, cxCustomData, cxFilter, cxData,cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untFramePlanoDeContasMaskEdit,
  untTypesSistema;

type
  TfrmGerAutCtaReceber = class(TfrmPai)
    pnlCampos: TPanel;
    Label5: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNomPor: TEditFocus;
    edtValParcela: TEditFocus;
    edtQtdParcela: TEditFocus;
    edtCodPor: TEditFocus;
    edtCodCli: TEditFocus;
    edtCodEmp: TEditFocus;
    chkDtCadFixa: TCheckBox;
    gpbVencimento: TGroupBox;
    lblPeriodicidade: TLabel;
    lbl4: TLabel;
    lbl5: TColorLabel;
    edtPeriod: TEditFocus;
    edtDiaFix: TEditFocus;
    gpbCadastro: TGroupBox;
    lblSNCadast: TColorLabel;
    lblCadastro: TLabel;
    lblPeriodicidC: TLabel;
    edtPeriodC: TEditFocus;
    edtDiaFixC: TEditFocus;
    mskDtaParcela: TcxDateEdit;
    Label34: TLabel;
    Label35: TLabel;
    Label10: TLabel;
    edtDesSuj: TEditFocus;
    edtJurSuj: TEditFocus;
    edtDesCob: TEditFocus;
    pnlCamAlt: TPanel;
    Label17: TLabel;
    edtHist01: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    pnlDados: TPanel;
    Panel1: TPanel;
    Label7: TLabel;
    edtTotPar: TEditFocus;
    Label11: TLabel;
    edtDescon: TEditFocus;
    ColorLabel1: TColorLabel;
    Label8: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    grdDadosDBTableView1: TcxGridDBTableView;
    grdDadosLevel1: TcxGridLevel;
    grdDados: TcxGrid;
    grdDadosDBTableView1TMP_PARCEL: TcxGridDBColumn;
    grdDadosDBTableView1TMP_DTACAD: TcxGridDBColumn;
    grdDadosDBTableView1TMP_DTAPAR: TcxGridDBColumn;
    grdDadosDBTableView1TMP_VALPAR: TcxGridDBColumn;
    grdDadosDBTableView1TMP_DESSUJ: TcxGridDBColumn;
    grdDadosDBTableView1TMP_JURSUJ: TcxGridDBColumn;
    grdDadosDBTableView1TMP_DESCOB: TcxGridDBColumn;
    grdDadosDBTableView1TMP_HISTOR: TcxGridDBColumn;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtCodPrj: TEditFocus;
    edtDesPrj: TEditFocus;
    procedure edtCodCliEnter(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure chkDtCadFixaClick(Sender: TObject);
    procedure edtDiaFixCExit(Sender: TObject);
    procedure edtDiaFixExit(Sender: TObject);
    procedure pnlCamposEnter(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure grdDadosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDadosDBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdParcelaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
  const
    intQtdMaxParcelas = 26;
  private
    qryConPor: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    qryConCta: TUniQuery;
    qryConOpe: TUniQuery;

    cdsCtaRec: TUniClientDataSet;
    dtsCtaRec: TDataSource;

    arrDupBol: TArrDupCtr;

    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pCarregaPortador;
    procedure pCarregaCentroCusto;
    procedure pCarregaEventos;
    procedure pCarregaVendedor;

    procedure pCriaTemporaria;
    procedure pInsereTemporaria;
    procedure pGeraDuplicatas;


    procedure pGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pSetText(Sender: TField; const Text: string);

    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pHabilitaCampos(blnHabDes:Boolean);
    procedure pSomaValorParcela;

    function fValidaDatasTemporarias: Boolean;
    function ValidaDataCadastroParcela: Boolean;
    procedure pImprimeBoletos;
    procedure pCarregaDuplicatasArray(strNumDup, strEspDoc, strCodEmp,
      strCodCli: string);
    procedure UtilizaRotinaProjeto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
  end;


implementation

uses untPesqAux, untCadRec, untConsultas, untFuncIns,
    untFuncFat, untCadCta, untModulo,
  untGravando, untLiberacao, untLiberacaoFactory, untBoleto;

{$R *.dfm}

procedure TfrmGerAutCtaReceber.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cdsCtaRec.EmptyDataSet;
  pLimpaDados;
  pSetFocus(edtCodCli);
end;

procedure TfrmGerAutCtaReceber.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If  fVerificaCampos Then
  Begin
    cdsCtaRec.EmptyDataSet;
    TfrmGravando.fExecutarModal(pInsereTemporaria, 'Aguarde... Gerando parcelas.','');
    pHabilitaCampos(False);
    grdDadosDBTableView1.DataController.FocusedRowIndex := 0;
    pSetFocus(grdDados);
  End;
end;

procedure TfrmGerAutCtaReceber.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fValidaDatasTemporarias Then
  Begin
    fMensagem('ATENÇÃO', 'Existe(m) duplicata(s) com data de cadastro maior que o vencimento!' +
                          #13#10 + 'Favor verificar antes de continuar...',['&O K']);
    Exit;
  End;

  If Not ValidaDataCadastroParcela Then
  begin
    fMensagem('ATENÇÃO', 'Data de Cadastro e/ou Parcela devem ser preenchidas!',['&OK']);
    Exit;
  end;

  If (Not fVerificaCampos) Or (cdsCtaRec.IsEmpty) Or
     (fMensagem('', 'Confirma Gravação?', ['&Sim', '&Não']) = 2) Then
  Begin
    Exit;
  End;

  TfrmGravando.fExecutarModal(pGeraDuplicatas, 'Aguarde... Gerando duplicatas.','');
end;

procedure TfrmGerAutCtaReceber.chkDtCadFixaClick(Sender: TObject);
begin
  inherited;
  If chkDtCadFixa.Checked Then
  Begin
    gpbCadastro.Enabled    := False;
    lblCadastro.Enabled    := False;
    lblPeriodicidC.Enabled := False;
    lblSNCadast.Enabled    := False;
    edtDiaFixC.Enabled     := False;
    edtPeriodC.Enabled     := False;
    edtDiaFixC.Color       := $00FFDFB8;
    edtPeriodC.Color       := $00FFDFB8;
    edtDiaFixC.Text        := '';
    edtPeriodC.Text        := '';
  End
  Else
  Begin
    gpbCadastro.Enabled    := True;
    lblCadastro.Enabled    := True;
    lblPeriodicidC.Enabled := True;
    lblSNCadast.Enabled    := True;
    edtDiaFixC.Enabled     := True;
    edtPeriodC.Enabled     := True;
    edtDiaFixC.Color       := clWindow;
    edtPeriodC.Color       := clWindow;
    edtDiaFixC.Text        := 'N';
  End;

  edtDiaFixCExit(edtDiaFixC);
end;

procedure TfrmGerAutCtaReceber.edtCodCliEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '(INSERT) para fazer um novo cadastro';
end;

procedure TfrmGerAutCtaReceber.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmGerAutCtaReceber.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAutCtaReceber.edtCodCliKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_INSERT) Then
  Begin
    TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
    edtCodCli.Text := fChamaCadCli(Key);
  End;
end;

procedure TfrmGerAutCtaReceber.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAutCtaReceber.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     edtNomPor,
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtCodEmp.Text) Then
    Begin
      If fValidaCampos(edtCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmGerAutCtaReceber.edtCodPrjKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, nil, Key, arrPrj) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAutCtaReceber.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtNomVen, qryConOpe, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAutCtaReceber.edtDiaFixCExit(Sender: TObject);
begin
  inherited;
  If (edtDiaFixC.Text = 'S') Then
  Begin
    lblPeriodicidC.Visible := False;
    edtPeriodC.Visible     := False;
  End
  Else
  Begin
    lblPeriodicidC.Visible := True;
    edtPeriodC.Visible     := True;
  End;
end;

procedure TfrmGerAutCtaReceber.edtDiaFixExit(Sender: TObject);
begin
  inherited;
  If (edtDiaFix.Text = 'S') Then
  Begin
    lblPeriodicidade.Visible := False;
    edtPeriod.Visible := False;
  End
  Else
  Begin
    lblPeriodicidade.Visible := True;
    edtPeriod.Visible := True;
  End;
end;

procedure TfrmGerAutCtaReceber.edtQtdParcelaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (not (CharInSet(Key, ['0'..'9']))) and (Word(Key) <> VK_BACK) Then
    Key := #0;
end;

procedure TfrmGerAutCtaReceber.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmGerAutCtaReceber.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

  mskDtaParcela.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  {********************************}
  {* CRIA TEMPORARIA              *}
  {*****************************LB*}
  cdsCtaRec := TUniClientDataSet.Create(Self);
  dtsCtaRec := fCriaDataSource(cdsCtaRec);
  grdDadosDBTableView1.DataController.DataSource := dtsCtaRec;

  pCriaTemporaria;
  pHabilitaCampos(True);

  edtDesSuj.ReadOnly := not fVerificaAcessoSistema('ALTDES');
  edtJurSuj.ReadOnly := not fVerificaAcessoSistema('ALTJUR');

  edtJurSuj.TabStop  := not edtJurSuj.ReadOnly;
  edtJurSuj.Enabled  := edtJurSuj.TabStop;

  edtDesSuj.TabStop  := not edtDesSuj.ReadOnly;
  edtDesSuj.Enabled  := edtDesSuj.TabStop;
end;

procedure TfrmGerAutCtaReceber.FormShow(Sender: TObject);
begin
  inherited;
  If (Not fCfgSis('CTAFAT', varBoolean)) Then
    fraPlanoDeContas.Visible := False;

  UtilizaRotinaProjeto;
end;

procedure TfrmGerAutCtaReceber.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
      Self.SelectNext(ActiveControl, True, True);
    pCarregaCentroCusto;
  End;
end;

function TfrmGerAutCtaReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strCfg_PORPGR: String;
  strCfg_CTAGCP: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************FS*}
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO','Código do Cliente deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;

        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        else
        If qryConCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente está inativo!', ['&O k']);
          Result := False;
        End;
      End;

      If Not Result Then
        pSetFocus(edtCodCli);
    End
    {*****************************************}
    {* VALIDA O CÓDIGO DO PORTADOR           *}
    {**************************************FS*}
    Else If (Sender = edtCodPor) Then
    Begin
      strCfg_PORPGR := fCfgSis('PORPGR');

      If (fCfgSis('OBRPOR', varBoolean)) Then
      Begin
        If fEmptyStr(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO','Código do Portador deve ser preenchido!',['&O K']);
          Result := False;
        End;
      End;

      If Result And (Not fEmptyStr(edtCodPor.Text)) Then
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
            Result := False;
          End;
        End
        Else If (Not fEmptyStr(strCfg_PORPGR)) Then
        Begin
          If ((Not fEmptyStr(edtCodPor.Text)) And (edtCodPor.Text = strCfg_PORPGR)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.', ['&O k']);
            Result := False;
          End;
        End;
      End;

      If Not Result Then
        pSetFocus(edtCodPor);
    End
    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************FS*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaEmpresa;
          If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End;

      If Not Result Then
        pSetFocus(edtCodEmp);
    End
    {*****************************************}
    {* VALIDA O CÓDIGO DO VENDEDOR           *}
    {**************************************FS*}
    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Vendedor ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

      If not Result Then
        pSetFocus(edtCodVen);
    End
    {*****************************************}
    {* VALIDA A DATA DA 1ª PARCELA           *}
    {**************************************FS*}
    Else If (Sender = mskDtaParcela) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaParcela.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data da 1º Parcela deve ser preenchida!',['&OK']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaParcela.Text) < StrToDate(FormatDateTime('dd/mm/yyyy',VS_Date))  Then
      Begin
        fMensagem('ATENÇÃO','A Data da 1º Parcela deve ser Maior ou igual a data atual!',['&O K']);
        Result := False;
      End;

      If Not Result Then
        pSetFocus(mskDtaParcela);
    End
    {*****************************************}
    {* VALIDA O VALOR DA PARCELA             *}
    {**************************************FS*}
    Else If (Sender = edtValParcela) Then
    Begin
      If fEmptyStr(edtValParcela.Text) Then
      Begin
        fMensagem('ATENÇÃO','O valor da parcela deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (fStrToFloat(edtValParcela.Text) = 0.00) Then
        Begin
          fMensagem('ATENÇÃO','O valor da parcela deve ser diferente de Zero!',['&O K']);
          Result := False;
        End;
      End;

      If Not Result Then
        pSetFocus(edtValParcela);
    End
    {*****************************************}
    {* VALIDA A QUANTIDADE DE PARCELAS       *}
    {**************************************FS*}
    Else If (Sender = edtQtdParcela) Then
    Begin
      If fEmptyStr(edtQtdParcela.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Quantidade de parcelas deve ser preenchidas!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (edtQtdParcela.Text <= '0') Then
        Begin
          fMensagem('ATENÇÃO','A Quantidade de parcelas deve ser maior que Zero!',['&O K']);
          Result := False;
        End
        Else
        If ( StrToIntDef(edtQtdParcela.Text, 0) > intQtdMaxParcelas) Then
        Begin
          fMensagem('ATENÇÃO','A Quantidade de parcelas deve ser menor ou igual a ' + IntToStr(intQtdMaxParcelas) + '!',['&O K']);
          Result := False;
        End;
      End;

      If Not Result Then
        pSetFocus(edtQtdParcela);
    End
    {*****************************************}
    {* VALIDA DIA FIXO VENCIMENTO            *}
    {**************************************FS*}
    Else If (Sender =  edtDiaFix) Then
    Begin
      If (Pos(edtDiaFix.Text, 'SN') <= 0) or (fEmptyStr(edtDiaFix.Text)) Then
      Begin
        fMensagem('ATENÇÃO','O campo usar dia fixo deve ser preenchido com "S" ou "N"!',['&O K']);
        Result := False;
      End
      Else If (edtDiaFix.Text = 'S') Then
      Begin
        lblPeriodicidade.Visible := False;
        edtPeriod.Visible := False;
      End
      Else
      Begin
        lblPeriodicidade.Visible := True;
        edtPeriod.Visible := True;
      End;

      if not Result then
        pSetFocus(edtDiaFix);
    End
    {*****************************************}
    {* VALIDA DIA FIXO CADASTRO              *}
    {**************************************FS*}
    Else If (Sender = edtDiaFixC) And (edtDiaFixC.Enabled) Then
    Begin
      If (Pos(edtDiaFixC.Text, 'SN') <= 0) or (fEmptyStr(edtDiaFixC.Text)) Then
      Begin
        fMensagem('ATENÇÃO','O campo usar dia fixo deve ser preenchido com "S" ou "N"!',['&O K']);
        Result := False;
      End
      Else If (edtDiaFixC.Text = 'S') Then
      Begin
        lblPeriodicidC.Visible := False;
        edtPeriodC.Visible := False;
      End
      Else
      Begin
        lblPeriodicidC.Visible := True;
        edtPeriodC.Visible := True;
      End;

      if not Result then
        pSetFocus(edtDiaFixC);
    End
    {*****************************************}
    {* VALIDA A PERIODICIDADE VENCIMENTO     *}
    {**************************************FS*}
    Else If (Sender = edtPeriod) And (edtPeriod.Visible) Then
    Begin
      If fEmptyStr(edtPeriod.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Vencimento deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else If (edtPeriod.Text <= '0') Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Vencimento deve ser maior que Zero!',['&O K']);
        Result := False;
      End
      Else If (gpbCadastro.Enabled) And (Not fEmptyStr(edtPeriodC.Text)) And
              (StrToInt(edtPeriod.Text) < StrToInt(edtPeriodC.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Vencimento não pode ser menor que a de Cadastro!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(edtPeriodC.Text) And (gpbCadastro.Enabled) Then
          edtPeriodC.Text := edtPeriod.Text;
      End;

      If Not Result Then
        pSetFocus(edtPeriod);
    End
    {*****************************************}
    {* VALIDA A PERIODICIDADE CADASTRO       *}
    {**************************************FS*}
    Else If (Sender = edtPeriodC) And (edtPeriodC.Visible) And (edtPeriodC.Enabled) Then
    Begin
      If fEmptyStr(edtPeriodC.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Cadastro deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else If (edtPeriodC.Text <= '0') Then
      Begin
        fMensagem('ATENÇÃO','A Periodicidade Cadastro deve ser maior que Zero!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (edtPeriod.Visible) And (StrToInt(edtPeriodC.Text) > StrToInt(edtPeriod.Text)) Then
        Begin
          fMensagem('ATENÇÃO','A Periodicidade Cadastro não pode ser maior que a de Vencimento!',['&O K']);
          Result := False;
        End;
      End;

      If Not Result Then
        pSetFocus(edtPeriodC);
    End
    {*****************************************}
    {* VALIDA VALIDA O CENTRO DE CUSTO       *}
    {**************************************MV*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      strCfg_CTAGCP := fCfgSis('CTAGCP');

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fraPlanoDeContas.MskCodCta.Clear;
        fraPlanoDeContas.edtDesCta.Clear;
      End
      Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End
      Else If (fraPlanoDeContas.MskCodCta.Text = fCfgSis('CTAPRI')) And fraPlanoDeContas.MskCodCta.Enabled Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas de Rateio não é permitido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False
        Else If (Not fEmptyStr(strCfg_CTAGCP)) Then
        Begin
          If (Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) And (fraPlanoDeContas.MskCodCta.Text = strCfg_CTAGCP) Then
          Begin
            fMensagem('ATENÇÃO!', 'Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.', ['&O k']);
            Result := False;
          End;
        End;
      End;

      if not Result then
      begin
        pSetFocus(fraPlanoDeContas.MskCodCta);
        fraPlanoDeContas.MskCodCta.Clear;
        fraPlanoDeContas.edtDesCta.Clear;
      end;
    End
    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************FS*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEventos;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='P') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        fraCentroCusto.edtCodEve.Clear;
        fraCentroCusto.edtDesEve.Clear;
      End;

      If Not Result Then
        pSetFocus(fraCentroCusto.edtCodEve);
    End
    {*****************************************}
    {* VALIDA O CAMPO 'DUPLICATA DESCONTADA' *}
    {**************************************FS*}
    Else If (Sender = edtDescon) Then
    Begin
      Result := fValidoSimNao(edtDescon.Text);
      if not Result then
      begin
        fMensagem('ATENÇÃO','O campo descontada deve ser preenchido com "S" ou "N"!',['&O K']);
        pSetFocus(edtDescon);
      end;
    End;
  End;
end;

function TfrmGerAutCtaReceber.fValidaDatasTemporarias: Boolean;
begin
  Result := True;

  If cdsCtaRec.IsEmpty Then
    Exit;

  With cdsCtaRec Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If FieldByName('TMP_DTACAD').AsDateTime > FieldByName('TMP_DTAPAR').AsDateTime Then
        Result := False;

      Next;
    End;
    First;
    EnableControls;
  End;
end;

procedure TfrmGerAutCtaReceber.grdDadosDBTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    if cdsCtaRec.State In [dsInsert, dsEdit] Then
      cdsCtaRec.Post;

    pSomaValorParcela;
  End;
end;

procedure TfrmGerAutCtaReceber.grdDadosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var
  blnUltimoRegistro: Boolean;
  blnUltimaColuna: Boolean;
begin
  inherited;

  blnUltimoRegistro := (grdDadosDBTableView1.DataController.DataSource.DataSet.RecNo = grdDadosDBTableView1.DataController.DataSet.RecordCount);
  blnUltimaColuna   := grdDadosDBTableView1.Controller.FocusedItemIndex = 7;

  If (Key = VK_INSERT) Or
    ((Key = VK_DOWN) And blnUltimoRegistro) Or
    ((Key = VK_TAB) And blnUltimoRegistro And blnUltimaColuna)Or
    (Key = VK_DELETE) Then
    Key := VK_NONAME
  Else If (Key = VK_Escape) Then
  Begin
    pSetFocus(fraCentroCusto.edtCodEve);

    btnConfirmar.Enabled := True;
    btnCancela.Enabled   := True;
  End
  Else If (Key = VK_F10) Then
    btnGravar.Click;
end;

procedure TfrmGerAutCtaReceber.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(cdsCtaRec.FieldByName('TMP_VALPAR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaRec.FieldByName('TMP_DESSUJ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaRec.FieldByName('TMP_JURSUJ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaRec.FieldByName('TMP_DESCOB')).DisplayFormat := '#,##0.00';
  TDateTimeField(cdsCtaRec.FieldByName('TMP_DTAPAR')).EditMask := '99/99/9999';
  TDateTimeField(cdsCtaRec.FieldByName('TMP_DTAPAR')).OnGetText := pGetText;
  TDateTimeField(cdsCtaRec.FieldByName('TMP_DTAPAR')).OnSetText := pSetText;
  TDateTimeField(cdsCtaRec.FieldByName('TMP_DTACAD')).EditMask := '99/99/9999';
  TDateTimeField(cdsCtaRec.FieldByName('TMP_DTACAD')).OnGetText := pGetText;
  TDateTimeField(cdsCtaRec.FieldByName('TMP_DTACAD')).OnSetText := pSetText;
end;

procedure TfrmGerAutCtaReceber.pAtualizaDados(DataSet: TDataSet);
begin
  If DataSet.FieldByName('TMP_VALPAR').AsFloat = 0.00  Then
  Begin
    fMensagem('ATENÇÃO','O Valor da parcela deve ser diferente de Zero!',['&OK']);
    Abort;
  End;
end;

procedure TfrmGerAutCtaReceber.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  With qryConCta Do
  Begin
    if not fEmptyStr(fraPlanoDeContas.MskCodCta.text) then
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString
    else
      fraPlanoDeContas.edtDesCta.Text := '';
  End;
end;

procedure TfrmGerAutCtaReceber.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmGerAutCtaReceber.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmGerAutCtaReceber.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmGerAutCtaReceber.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmGerAutCtaReceber.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodVen.Text);
  With qryConOpe Do
  Begin
    edtNomVen.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmGerAutCtaReceber.pCriaTemporaria;
Var
  strSQL: String;
  qryCtaRec: TUniQuery;
  dspCtaRec: TUniDataSetProvider;
begin
  Try
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Self);
    dspCtaRec := TUniDataSetProvider.Create(Self);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "  " AS TMP_PARCEL, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS TMP_DTACAD, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS TMP_DTAPAR, ';
    strSQL := strSQL + '  "' + fReplicatorStr(' ', 400) + '" AS TMP_HISTOR, ';
    strSQL := strSQL + '  0.00 AS TMP_VALPAR, ';
    strSQL := strSQL + '  0.00 AS TMP_DESSUJ, ';
    strSQL := strSQL + '  0.00 AS TMP_JURSUJ, ';
    strSQL := strSQL + '  0.00 AS TMP_DESCOB ';
    strSQL := strSQL + '  LIMIT 0 ';

    With qryCtaRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      pSetaClient(qryCtaRec);
    End;

    With cdsCtaRec Do
    Begin
      AfterOpen := pAfterOpen;
      Open;
      BeforePost := pAtualizaDados;
    End;

    qryCtaRec.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmGerAutCtaReceber.pCriaTemporaria]');
  End;

  cdsCtaRec.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
end;

procedure TfrmGerAutCtaReceber.pGeraDuplicatas;
Var
  intContador : Integer;
  strNumDup   : String;
  blnRetorno  : Boolean;
  intQtdPar   : Integer;
begin
  intQtdPar := StrToIntDef(edtQtdParcela.Text, 0);
  intContador := 0;
  blnRetorno := True;

  Try
    cdsCtaRec.DisableControls;

    With cdsCtaRec Do
    Begin
      fStartTransaction;

      Try
        strNumDup := fRetSequencialCadRec;

        {**************************************}
        {* PROCESSA TEMPORARIA                *}
        {***********************************FS*}
        First;
        While (Not Eof) And (blnRetorno) Do
        Begin
          Try
            Inc(intContador);
            blnRetorno := fGravaCadRec(Self.Name,                                             //Nome Formulário LogCtr
                                       'INCLUSAO - GERACAO AUTOMATICA',                       //Descrição LogCtr
                                       strNumDup,                                             //Número Duplicata
                                       FieldByName('TMP_PARCEL').AsString,                    //Parcela
                                       0,                                                     //SeqBaixa
                                       'PA',                                                  //Espécie
                                       edtCodCli.Text,                                        //Cód. Cliente
                                       edtCodEmp.Text,                                        //Cód. Empresa
                                       edtCodVen.Text,                                        //Cód. Vendedor
                                       '',                                                    //Cód. Digitador
                                       edtCodPor.Text,                                        //Cód. Portador
                                       FieldByName('TMP_DTACAD').AsDateTime,                  //Data Cadastro
                                       FieldByName('TMP_DTAPAR').AsDateTime,                  //Data Vencimento
                                       FieldByName('TMP_VALPAR').AsFloat,                     //Valor Duplicata
                                       FieldByName('TMP_VALPAR').AsFloat,                     //Valor Original
                                       FieldByName('TMP_DESCOB').AsFloat,                     //Desp. Cobrança
                                       edtDescon.Text,                                        //DUPLICATA DESCONTADA
                                       UpperCase(FieldByName('TMP_HISTOR').AsString) +
                                          '-' + fStrZero(IntToStr(intContador), 2) +
                                          '/' + fStrZero(IntToStr(intQtdPar), 2),             //Histórico 01
                                       '',                                                    //Histórico 02
                                       '',                                                    //Portador Baixa
                                       '',                                                    //Conta Baixa
                                       '',                                                    //Operador Baixa
                                       '',                                                    //Doc. Baixa
                                       0,                                                     //Valor Recebido
                                       0,                                                     //Data Recebimento
                                       '',                                                    //CTR_ADTCLI
                                       fraCentroCusto.edtCodEve.Text,                         //Cód. Evento
                                       '',                                                    //CTR_CODVEL
                                       '',                                                    //CTR_TIPFOR
                                       '',                                                    //CTR_CODCND
                                       False,                                                 //CTR_CONAPR
                                       fraPlanoDeContas.MskCodCta.Text,                       //Cód. Conta
                                       0, 0, '', '', '', '', 0, 0, 0, 0, '', '', '', '', '', '', 0, 0, '', 0, 0,
                                       'N',
                                       FieldByName('TMP_DESSUJ').AsFloat,
                                       FieldByName('TMP_JURSUJ').AsFloat,
                                       0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, 0, 0, 0, '', 0,
                                       'INCLUSÃO',
                                       '', '', '',
                                       'N',
                                       'N',
                                       '', '', '', '', 0, 0,
                                       edtCodPrj.Text);
          Except
            On E: Exception Do
              Raise Exception.Create(E.Message);
          End;

          Next;
        End;
      Except
        On E: Exception Do
        Begin
          blnRetorno := False;
          fMensagem('','Ocorreu um erro ao realizar a geração automática de duplicatas!' + #13 + E.Message,['&OK']);
          fRollBack;
        End;
      End;

      If blnRetorno Then
      Begin
        fCommit;

        pCarregaDuplicatasArray( strNumDup, 'PA', edtCodEmp.Text, edtCodCli.Text );

        pImprimeBoletos();

        pHabilitaCampos(True);
        cdsCtaRec.EmptyDataSet;
        pLimpaDados;

        fMensagem('','Geração concluída.',['&Ok']);

        pSetFocus(edtCodCli);
      End Else
      Begin
        fRollBack;
        pHabilitaCampos(True);
      End;
    End;
  Finally
    cdsCtaRec.EnableControls;
  End;
end;

procedure TfrmGerAutCtaReceber.pCarregaDuplicatasArray( strNumDup, strEspDoc, strCodEmp, strCodCli : string );
  Var
    strSQL : String;
    qryAux : TUniQuery;
begin
  Try

    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  AUTOINCREM, CTR_PARCEL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString   := strNumDup;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;
      Open;

      SetLength(arrDupBol,0);

      If Not IsEmpty Then
      Begin

         First;
         While Not Eof Do
         Begin
           SetLength(arrDupBol,Length(arrDupBol)+1);
           arrDupBol[Length(arrDupBol)-1].strNumDup := strNumDup;
           arrDupBol[Length(arrDupBol)-1].strEspDoc := strEspDoc;
           arrDupBol[Length(arrDupBol)-1].strCodEmp := strCodEmp;
           arrDupBol[Length(arrDupBol)-1].strCodCli := strCodCli;
           arrDupBol[Length(arrDupBol)-1].strParcel := qryAux.FieldByName('CTR_PARCEL').AsString;
           arrDupBol[Length(arrDupBol)-1].strAutoIn := qryAux.FieldByName('AUTOINCREM').AsString;
           Next;
         End;

      End;

    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

Procedure TfrmGerAutCtaReceber.pImprimeBoletos();
Begin

    If not fVerificaAcessoSistema('frmImpBoletosIndiv') Then
    Begin
      fMensagem('Aviso', 'Usuário sem permissão!', ['&O k']);
      Exit;
    End;

    If Length(arrDupBol) > 0 Then
    Begin
        TBoleto.fImprimirBoletos(arrDupBol,
                                 False,
                                 True,
                                 'Deseja gerar o boleto?',
                                 self.Name,
                                 '',
                                 '',
                                 True,
                                 False);
    End;

    SetLength(arrDupBol,0);

End;

procedure TfrmGerAutCtaReceber.pGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  If Not Sender.IsNull Then
    Text := FormatDateTime('dd/MM/yyyy', Sender.AsDateTime)
  Else
    Text := '';
end;

procedure TfrmGerAutCtaReceber.pHabilitaCampos(blnHabDes: Boolean);
begin
  pnlDados.Enabled   := Not blnHabDes;
  btnGravar.Enabled  := Not blnHabDes;
end;

procedure TfrmGerAutCtaReceber.pInsereTemporaria;
Var
  intContador: Integer;
  intQtdPar  : Integer;
  dtaParcela : TDate;
  dtaCadastr : TDate;
  dtaDtaBas  : TDate;
  dtaDtaBaC  : TDate;
  intIndice  : Integer;
  intIndCad  : Integer;
begin
  intQtdPar  := (StrToInt(edtQtdParcela.Text)-1);
  dtaParcela := StrToDate(mskDtaParcela.Text);
  dtaCadastr := VS_Date;

  With cdsCtaRec Do
  Begin
    cdsCtaRec.DisableControls;
    dtaDtaBas := dtaParcela;
    dtaDtaBaC := dtaCadastr;
    intIndice := 1;
    intIndCad := 1;

    For intContador := 65 To 65 + intQtdPar Do
    Begin
      Append;
      FieldByName('TMP_PARCEL').AsString   := IIF(intQtdPar > intQtdMaxParcelas, 'A', Chr(intContador));
      FieldByName('TMP_DTACAD').AsDateTime := dtaCadastr;
      FieldByName('TMP_DTAPAR').AsDateTime := dtaParcela;
      FieldByName('TMP_HISTOR').AsString   := edtHist01.Text;
      FieldByName('TMP_DESSUJ').AsFloat    := fStrToFloat(edtDesSuj.Text);
      FieldByName('TMP_JURSUJ').AsFloat    := fStrToFloat(edtJurSuj.Text);
      FieldByName('TMP_DESCOB').AsFloat    := fStrToFloat(edtDesCob.Text);
      FieldByName('TMP_VALPAR').AsFloat    := fStrToFloat(edtValParcela.Text);
      Post;

      If (edtDiaFix.Text = 'S') Then
      Begin
        dtaParcela := IncMonth(dtaDtaBas, intIndice);
        Inc(intIndice);
      End
      Else dtaParcela := dtaParcela + StrToInt(edtPeriod.Text);

      If Not chkDtCadFixa.Checked Then
      Begin
        If (edtDiaFixC.Text = 'S') Then
        Begin
          dtaCadastr := IncMonth(dtaDtaBaC, intIndCad);
          Inc(intIndCad);
        End
        Else dtaCadastr := dtaCadastr + StrToInt(edtPeriodC.Text);
      End;

      Application.ProcessMessages;
    End;
    cdsCtaRec.First;
    cdsCtaRec.EnableControls;
    pSomaValorParcela;
  End;
end;

procedure TfrmGerAutCtaReceber.pLimpaDados;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodPor.Clear;
  edtNomPor.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
  edtCodVen.Clear;
  edtNomVen.Clear;

  mskDtaParcela.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtValParcela.Clear;
  edtQtdParcela.Clear;
  edtPeriod.Clear;
  edtPeriodC.Clear;
  edtHist01.Clear;
  edtTotPar.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtDesSuj.Clear;
  edtJurSuj.Clear;
  edtDesCob.Clear;
  edtCodPrj.Clear;
  edtDesPrj.Clear;

  edtValParcela.Enabled := True;
  fraPlanoDeContas.MskCodCta.Enabled := True;
end;

procedure TfrmGerAutCtaReceber.pnlCamposEnter(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    btnGravar.Enabled := False;
    cdsCtaRec.EmptyDataSet;
    edtTotPar.Clear;
  End;
end;

procedure TfrmGerAutCtaReceber.pSetText(Sender: TField; const Text: string);
begin
  If Trim(Text) = '/  /' Then
    Sender.Clear
  Else
    Sender.AsString := Text;
end;

procedure TfrmGerAutCtaReceber.pSomaValorParcela;
Var
  cdsGen: TUniClientDataSet;
  fldTotPar: TAggregateField;
  fldTotDes: TAggregateField;
  fldTotCob: TAggregateField;
  fldTotJur: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldTotPar := TAggregateField.Create(Self);
  fldTotDes := TAggregateField.Create(Self);
  fldTotCob := TAggregateField.Create(Self);
  fldTotJur := TAggregateField.Create(Self);

  With fldTotPar Do
  Begin
    FieldName := 'FLDTOTPAR';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(TMP_VALPAR)';
    Active := True;
  End;

  With fldTotDes Do
  Begin
    FieldName := 'FLDTOTDES';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(TMP_DESSUJ)';
    Active := True;
  End;

  With fldTotCob Do
  Begin
    FieldName := 'FLDTOTCOB';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(TMP_DESCOB)';
    Active := True;
  End;

  With fldTotJur Do
  Begin
    FieldName := 'FLDTOTJUR';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(TMP_JURSUJ)';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;
    AggregatesActive := True;
    edtTotPar.Text := FloatToStrF(fldTotPar.Value +
                                  fldTotJur.Value -
                                  fldTotDes.Value +
                                  fldTotCob.Value, ffNumber, 12, 2);
  End;

  FreeAndNil(fldTotPar);
  FreeAndNil(fldTotDes);
  FreeAndNil(fldTotCob);
  FreeAndNil(fldTotJur);
  FreeAndNil(cdsGen);
end;

procedure TfrmGerAutCtaReceber.UtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
end;

function TfrmGerAutCtaReceber.ValidaDataCadastroParcela: Boolean;
begin
  Result := True;

  If cdsCtaRec.IsEmpty Then
    Exit;

  With cdsCtaRec Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If (FieldByName('TMP_DTACAD').AsDateTime = 0) Or
         (FieldByName('TMP_DTAPAR').AsDateTime = 0) Then
        Result := False;

      Next;
    End;
    First;
    EnableControls;
  End;
end;

end.
