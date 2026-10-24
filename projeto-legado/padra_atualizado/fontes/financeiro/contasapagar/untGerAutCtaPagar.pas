{**********************}
{* qryConPor = CADPOR *}
{* qryConFor = CADFOR *}
{* qryConEmp = CADEMP *}
{* qryConCta = CADCTA *}
{*******************JB*}
unit untGerAutCtaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, Menus, StdCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Mask, DBCtrls, MaskEditFocus, QColorLabel, StrUtils, DB,
  AppEvnts, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem, DBEditFocus, untfuncoesSimples,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, untMetaCentroCustoPedido, dxScreenTip, cxClasses, dxCustomHint,
  cxHint, ComboBoxFocus, untLiberacao, untFuncIns, untFrameCentroCustoEditFocus,
  cxStyles, cxCustomData,cxFilter, cxData, cxDataStorage, cxNavigator, 
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, untFramePlanoDeContasMaskEdit;

type
  TfrmGerAutCtaPagar = class(TfrmPai)
    pnlCampos: TPanel;
    pnlDados: TPanel;
    Label5: TLabel;
    edtNomFor: TEditFocus;
    Label3: TLabel;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    edtNomPor: TEditFocus;
    Label1: TLabel;
    Label4: TLabel;
    edtValParcela: TEditFocus;
    Label6: TLabel;
    edtQtdParcela: TEditFocus;
    edtCodPor: TEditFocus;
    edtCodFor: TEditFocus;
    edtCodEmp: TEditFocus;
    pnlTotal: TPanel;
    Label9: TLabel;
    edtTotPar: TEditFocus;
    pnlCamAlt: TPanel;
    Label20: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label17: TLabel;
    edtUsaChq: TEditFocus;
    edtPrevis: TEditFocus;
    edtVeiobo: TEditFocus;
    edtNumDup: TEditFocus;
    edtHist01: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    Label7: TLabel;
    edtDeposi: TEditFocus;
    lbl1: TLabel;
    edtTipDoc: TEditFocus;
    lblSerie: TLabel;
    edtSerie: TEditFocus;
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
    edtVeioNF: TEditFocus;
    Label12: TLabel;
    btnGravar: TBitBtnLocked;
    btnDesmembr: TBitBtnLocked;
    mskCompet: TMaskEditFocus;
    Label14: TLabel;
    mskDtaParcela: TcxDateEdit;
    Label15: TLabel;
    edtUsoCon: TEditFocus;
    ColorLabel4: TColorLabel;
    ColorLabel2: TColorLabel;
    ColorLabel1: TColorLabel;
    ColorLabel5: TColorLabel;
    lbl2: TColorLabel;
    ColorLabel3: TColorLabel;
    rdgCompetencia: TRadioGroup;
    HintControler: TcxHintStyleController;
    lblGuia: TLabel;
    Label16: TLabel;
    cbxBcoFor: TComboBoxFocus;
    Label18: TLabel;
    Label19: TLabel;
    cxEditStyleController1: TcxEditStyleController;
    edtDesSuj: TEditFocus;
    edtValTotalParc: TEditFocus;
    chkDtCadVenc: TCheckBox;
    Label21: TLabel;
    edtJurSuj: TEditFocus;
    LcbGuiaTributo: TDBLookupComboBox;
    LcbTipoTributo: TDBLookupComboBox;
    dtsGuiaTributo: TDataSource;
    dtsTipoTributo: TDataSource;
    spbDicaTributo: TSpeedButton;
    fraCentroCusto: TfraCentroCustoEditFocus;
    grdDadosDBTableView1: TcxGridDBTableView;
    grdDadosLevel1: TcxGridLevel;
    grdDados: TcxGrid;
    grdDadosDBTableView1TMP_PARCEL: TcxGridDBColumn;
    grdDadosDBTableView1TMP_DTACAD: TcxGridDBColumn;
    grdDadosDBTableView1TMP_DTAPAR: TcxGridDBColumn;
    grdDadosDBTableView1TMP_HISTOR: TcxGridDBColumn;
    grdDadosDBTableView1TMP_VALPAR: TcxGridDBColumn;
    grdDadosDBTableView1CTP_DESSUJ: TcxGridDBColumn;
    grdDadosDBTableView1CTP_JURSUJ: TcxGridDBColumn;
    grdDadosDBTableView1CTP_MULSUJ: TcxGridDBColumn;
    grdDadosDBTableView1VLR_TOTALPARC: TcxGridDBColumn;
    Label22: TLabel;
    edtPagAnt: TEditFocus;
    ColorLabel6: TColorLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtDesPrj: TEditFocus;
    edtCodPrj: TEditFocus;
    edtMulSuj: TEditFocus;
    lblMulta: TLabel;
    grdDadosDBTableView1TMP_COMPET: TcxGridDBColumn;

    procedure FormCreate(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);

    procedure pDesmembraValores;
    procedure pCarregaPortador;
    procedure pCarregaFornecedor;
    procedure pPreencheCentroCusto;
    procedure pCarregaCentroCusto;
    procedure pCarregaEmpresa;
    procedure pCarregaEventos;
    procedure pCarregaCtaFornecedor(strCodFor: String);

    procedure pCriaTemporaria;
    procedure pInsereTemporaria;
    procedure pGeraDuplicatas;

    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pBeforeInsert(DataSet: TDataSet);

    procedure pHabilitaCampos(blnHabDes:Boolean);

    procedure pSomaValorParcela;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodForEnter(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtDiaFixExit(Sender: TObject);
    procedure btnDesmembrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlCamposEnter(Sender: TObject);
    procedure edtQtdParcelaExit(Sender: TObject);
    procedure edtDiaFixCExit(Sender: TObject);
    procedure chkDtCadFixaClick(Sender: TObject);
    procedure edtValParcelaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure edtTipDocEnter(Sender: TObject);
    procedure edtTipDocExit(Sender: TObject);
    procedure edtDeposiChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxBcoForEnter(Sender: TObject);
    procedure cbxBcoForExit(Sender: TObject);
    procedure cbxBcoForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxBcoForChange(Sender: TObject);
    procedure LcbGuiaTributoExit(Sender: TObject);
    procedure spbDicaTributoClick(Sender: TObject);
    procedure grdDadosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDadosDBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure mskDtaParcelaExit(Sender: TObject);
    procedure chkDtCadVencClick(Sender: TObject);
  private
    strNumDup: String;
    strCtaAnt: String;
    strCtaFor: String;
    strCtaAut: String;
    strCodFor: String;
    strCodEmp: String;

    qryGuiaTributo: TUniQuery;
    qryTipoTributo: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCta: TUniQuery;
    qryConFor: TUniQuery;
    qryConPor: TUniQuery;
    qryCtaFor: TUniQuery;
    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;
    FDatasetCtpDet: TUniClientDataSet;

    arrImprimeCP: Array of TImprimeCP;
    lstBcoFor: TStringList;
    intIdxBcoForAnt: Integer;

    objLiberacao : TLiberacao;

    blnUsaLiberacaoDePrevisao,
    blnGravaApenasPrevisao: Boolean;

    function fValidaChqBolDep(Sender: TWinControl): Boolean;
    function fValidaDatasTemporarias: Boolean;
    procedure pImprimeCP;
    procedure pGetText(Sender: TField; var Text: string;
    DisplayText: Boolean);
    procedure pSetText(Sender: TField; const Text: string);

    function fVerificaMeta: Boolean;

    procedure pCarregaDadosBancariosFornecedor(strCodFor: String);
    procedure pTrataBcoFor;
    function fGetBcoFor: String;
    function fGetForPix: String;
    procedure CarregaGuiasETributos;
    procedure pIniciaValoresPadrao;

    function fRetornaCompetencia: String;
    procedure pUtilizaRotinaProjeto;
    function fPodeManterDtaCadEDtaVenIguais: Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property strBcoFor: String read fGetBcoFor;
    property strForPix: String read fGetForPix;
  end;


implementation

uses untPesqAux, untDesmembrValores, untTypesSistema, untCadPag, untConsultas,
     untFuncIns2,   untFuncFat, untGravando, untConstantes,
     untCadFornecedores, untLiberacaoFactory, untCadCta,
     Contabilidade.Funcoes, Contabilidade.Consultas, untCadClientes,
     untCadTransportadoras, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmGerAutCtaPagar.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodFor);
end;

procedure TfrmGerAutCtaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  lstBcoFor.Clear;
  FreeAndNil(FDatasetCtpDet);
end;

procedure TfrmGerAutCtaPagar.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;

  qryConPor := fCriaQuery(Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

  mskDtaParcela.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskCompet.Text := FormatDateTime('mm/YYYY', VS_Date);

  {********************************}
  {* CRIA TEMPORARIA              *}
  {*****************************LB*}
  cdsCtaPag := TUniClientDataSet.Create(Self);
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  grdDadosDBTableView1.DataController.DataSource := dtsCtaPag;

  pLimpaDados;

  pCriaTemporaria;
  pHabilitaCampos(True);

  pCriaClientTemporariaCtpDet(edtNumDup.Text, '', edtSerie.Text, edtCodEmp.Text, edtCodFor.Text, FDatasetCtpDet);

  lstBcoFor := TStringList.Create;
  intIdxBcoForAnt := -1;

  qryGuiaTributo := fCriaQuery(Self);
  qryTipoTributo := fCriaQuery(Self);
  LcbGuiaTributo.DataSource := dtsCtaPag;
  LcbTipoTributo.DataSource := dtsCtaPag;
  dtsGuiaTributo.DataSet := qryGuiaTributo;
  dtsTipoTributo.DataSet := qryTipoTributo;

  blnUsaLiberacaoDePrevisao := fCfgSis('CTPPRE', varBoolean);
  blnGravaApenasPrevisao    := (blnUsaLiberacaoDePrevisao) And
                               (fVerPermissaoOperador('LIBCTPPREV', strLoginUsuarioLogado));
end;

procedure TfrmGerAutCtaPagar.FormDestroy(Sender: TObject);
begin
  if assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
  lstBcoFor.Free;
end;

procedure TfrmGerAutCtaPagar.edtCodForKeyPress(Sender: TObject;
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

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmGerAutCtaPagar.edtCodPorKeyPress(Sender: TObject;
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
                     edtCodEmp.Text)  then
    Begin
      If fValidaCampos(edtCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmGerAutCtaPagar.edtCodPrjKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, nil, Key, arrPrj) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmGerAutCtaPagar.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

function TfrmGerAutCtaPagar.fPodeManterDtaCadEDtaVenIguais: Boolean;
begin
  Result := edtPeriod.Text = edtPeriodC.Text;
end;

procedure TfrmGerAutCtaPagar.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
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
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, False)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End;

end;

function TfrmGerAutCtaPagar.fRetornaCompetencia: String;
begin
  If rdgCompetencia.ItemIndex = 0 Then
    Result := FormatDateTime('mm/YYYY', cdsCtaPag.FieldByName('TMP_DTACAD').AsDateTime)
  Else
    Result := FormatDateTime('mm/YYYY', cdsCtaPag.FieldByName('TMP_DTAPAR').AsDateTime);
end;

function TfrmGerAutCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  blnPedeSenha: Boolean;
  frmDesmembrValores : TfrmDesmembrValores;
  oParametros: TParametrosDesmembraValoresCtaDet;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodFor) Then
    Begin

      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO','Código do Fornecedor deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin

        pCarregaFornecedor;

        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End
        else
        If qryConFor.FieldByName('FOR_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor está inativo!', ['&O k']);
          Result := False;
        End;
      End;

      If Result Then
      Begin
        If edtCodFor.Text <> strCodFor Then
        Begin
          If fraPlanoDeContas.MskCodCta.Enabled Then
            pPreencheCentroCusto;
          strCodFor := edtCodFor.Text;
          pCarregaDadosBancariosFornecedor(strCodFor);
        End;
      End;
    End
    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO','Código do Portador deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
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
        End;

        If Result Then
        Begin
          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End;

    End

    Else If (Sender = edtCodPrj) And edtCodPrj.Visible  Then
    Begin
      If Not fEmptyStr(edtCodPrj.Text) Then
      Begin
        edtDesPrj.Text := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [edtCodPrj.Text], False);

        If fEmptyStr(edtDesPrj.Text) Then
        Begin
          fMensagem('', 'Projeto não encontrado !', ['&Ok']);
          Result := False;
          edtDesPrj.Clear;
        End
        Else
        If fCampoTabela('PRJ_SITUAC', 'CADPRJ', ['PRJ_CODPRJ'], [edtCodPrj.Text], False) = 'I' Then
        Begin
          fMensagem('ATENÇÃO!', 'O projeto informado foi Inativado. Verifique!', ['&Ok']);
          Result :=False;
        End;
      End
      Else
        edtDesPrj.Clear;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) And fraPlanoDeContas.MskCodCta.Enabled Then
    Begin
      If Not fEmptyStr(strCtaAnt) and fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
        fraPlanoDeContas.MskCodCta.Text := strCtaAnt;

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO','Plano de Contas deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End
      {************************************************}
      {* NÃO DEIXA INFORMAR CENTRO DE CUSTO DE RATEIO *}
      {*********************************************RV*}
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
          If Not fCfgSis('USACTF', varBoolean) Then
            fMensagem('ATENÇÃO','Plano de Conta não está cadastrado!',['&O K'])
          Else
            fMensagem('ATENÇÃO','Plano de Contas não está cadastrado ou não vinculado ao fornecedor. Verificar cadastro do Fornecedor/Aba Plano de Contas.!',['&O K']);

          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False;

        If (Result) And (strCtaAnt <> fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          oParametros := TParametrosDesmembraValoresCtaDet.Create;
          try
            oParametros.strNumCta := fraPlanoDeContas.MskCodCta.Text;
            oParametros.strCodEve := fraCentroCusto.edtCodEve.Text;
            oParametros.frmCadPag := Self;
            oParametros.fltValDup := fstrToFloat(edtValParcela.Text);
            oParametros.strCodEmp := edtCodEmp.Text;
            oParametros.blnDireto := False;

            if fDesmembraValoresCtaDet(oParametros) then
            Begin
              edtValParcela.Enabled := False;
              fraPlanoDeContas.MskCodCta.Enabled := False;

              If fEmptyStr(oParametros.strCodCta) Then
                fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTAPRI')
              Else
                fraPlanoDeContas.MskCodCta.Text := oParametros.strCodCta;

              FDatasetCtpDet.Data := oParametros.cdsTemp.Data;

              pCarregaCentroCusto;

              pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);
              frmDesmembrValores.DatasetCtpDet := FDatasetCtpDet;
              frmDesmembrValores.pAtualizaTemporariaCtpDet;
              pFreeAndNil(frmDesmembrValores);

              If fVerificaEvenRat(FDatasetCtpDet) Then
              Begin
                fraCentroCusto.edtCodEve.Text  := fCfgSis('EVEPRI');
                fraCentroCusto.edtCodEve.Enabled := False;
                pCarregaEventos;
              End
              Else
              Begin
                fraCentroCusto.edtCodEve.Enabled := True;
                pCarregaEventos;
              End;

              blnMudarFoco := False;
              If fraCentroCusto.edtCodEve.CanFocus Then
                pSetFocus(fraCentroCusto.edtCodEve)
             Else
                If edtDiaFix.CanFocus Then
                  pSetFocus(edtDiaFix);
            End;
          finally
            oParametros.Free;
          end;
        End;
      End;

      If (Result) Then
      Begin
        blnPedeSenha := Not (fEmptyStr(strCtaFor) And fEmptyStr(strCtaAut));
        If Not fEmptyStr(strCtaFor) Then
          blnPedeSenha := blnPedeSenha And (strCtaFor <> fraPlanoDeContas.MskCodCta.Text);
        If Not fEmptyStr(strCtaAut) Then
          blnPedeSenha := blnPedeSenha And (strCtaAut <> fraPlanoDeContas.MskCodCta.Text);

        If blnPedeSenha And (Not fCfgSis('USACTF', varBoolean)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('ALTERAR PLANO DE CONTAS');
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTextoCaption('Plano de contas anterior', strCtaAut + '-' + fRetNomeConta(strCtaAut), 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Documento'               , IfThen(fEmptyStr(edtNumDup.Text), '',
                                                                                        edtNumDup.Text +
                                                                                        IfThen(fEmptyStr(edtSerie.Text), '',
                                                                                               '-' + edtSerie.Text) +
                                                                                        IfThen(fEmptyStr(edtCodEmp.Text), '',
                                                                                               '-' + edtCodEmp.Text))      , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor:                ', edtCodFor.Text + '-' + edtNomFor.Text  , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Data da primeira parcela:  ', mskDtaParcela.Text                     , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de parcelas:    ', edtQtdParcela.Text                     , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Desconto:    ', edtDesSuj.Text                                       , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Juros:       ', edtJurSuj.Text                                       , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Multa:       ', edtMulSuj.Text                                       , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor da primeira parcela: ', edtValParcela.Text                     , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Total:    ', edtValTotalParc.Text                                    , 26);
          objLiberacao.objMsgLibera.pAddTextoCaption('Alterando para o plano de contas', fraPlanoDeContas.MskCodCta.Text + '-' + fraPlanoDeContas.edtDesCta.Text );

          objLiberacao.strDirAce := 'CTPALTCTA';
          objLiberacao.strMsgSen := 'Senha para alteração do plano de contas da conta a pagar';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;

          If objLiberacao.fLibera Then
          Begin
            strCtaAut := fraPlanoDeContas.MskCodCta.Text;
          End
          Else
          Begin
            fraPlanoDeContas.MskCodCta.Text := strCtaAut;
            pCarregaCentroCusto;
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO','Código da Empresa deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull  Then
        Begin
          fMensagem('ATENÇÃO','Empresa não está cadastrada!',['&O K']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = fraCentroCusto.edtCodEve) And (fraCentroCusto.edtCodEve.Enabled) Then
    Begin

      {*****************************************}
      {* VALIDA O CÓDIGO DO EVENTO             *}
      {**************************************JB*}
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEventos;
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
      Else
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) Or
           (fCfgSis('METPED', varString) = '5') Or
           (fCfgSis('METPED', varString) = '6') Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtCodEve.Clear;
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA COMPETENCIA                    *}
    {**************************************BB*}
    Else if (Sender = mskCompet) then
    Begin
      If not fValidaDataStr('01/'+ mskCompet.Text) Then
      Begin
        pMensagemOk('Data informada na Competência não é válida!');
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) Then
      Begin
        pMensagemOk('A Competência deve ser preenchida!');
        Result := False;
      End
      Else If Length(fTiraCaracEspeciais(Trim(mskCompet.Text))) < 6 Then
      Begin
        pMensagemOk('O ano da Competência deve ser preenchido com 4 dígitos!');
        Result := False;
      End;

    End

    Else If (Sender = mskDtaParcela) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaParcela.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data da 1º Parcela deve ser preenchida!',['&OK']);
        Result := False;
      End;
    End
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
      edtValTotalParc.Text:= FloatToStrF(fStrToFloat(edtValParcela.Text) - fStrToFloat(edtDesSuj.Text) + fStrToFloat(edtJurSuj.Text) + fStrToFloat(edtMulSuj.Text), ffNumber, 12, 2);
    End
    Else If (Sender = edtDesSuj) Then
    Begin
      edtValTotalParc.Text:= FloatToStrF(fStrToFloat(edtValParcela.Text) - fStrToFloat(edtDesSuj.Text) + fStrToFloat(edtJurSuj.Text) + fStrToFloat(edtMulSuj.Text), ffNumber, 12, 2);
    End
    Else If (Sender = edtJurSuj) Then
    Begin
      edtValTotalParc.Text:= FloatToStrF(fStrToFloat(edtValParcela.Text) - fStrToFloat(edtDesSuj.Text) + fStrToFloat(edtJurSuj.Text) + fStrToFloat(edtMulSuj.Text), ffNumber, 12, 2);
    End
    Else If (Sender = edtMulSuj) Then
    Begin
      edtValTotalParc.Text:= FloatToStrF(fStrToFloat(edtValParcela.Text) - fStrToFloat(edtDesSuj.Text) + fStrToFloat(edtJurSuj.Text) + fStrToFloat(edtMulSuj.Text), ffNumber, 12, 2);
    End
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
        If ( StrToIntDef(edtQtdParcela.Text, 0) > 999) Then
        Begin
          fMensagem('ATENÇÃO','A Quantidade de parcelas deve ser menor ou igual a 999!',['&O K']);
          Result := False;
        End;
      End

    End
    Else If Sender =  edtDiaFix Then
    Begin

      If (Pos(edtDiaFix.Text, 'SN') <= 0) or (fEmptyStr(edtDiaFix.Text)) Then
      Begin
        fMensagem('ATENÇÃO','O campo usar dia fixo deve ser "S" ou "N"!',['&O K']);
        Result := False;
      End
      Else If (edtDiaFix.Text = 'S') Then
      Begin
        lblPeriodicidade.Visible := False;
        edtPeriod.Visible := False;
        edtPeriod.Clear;
      End
      Else
      Begin
        lblPeriodicidade.Visible := True;
        edtPeriod.Visible := True;
      End;

    End
    Else If (Sender = edtDiaFixC) And (edtDiaFixC.Enabled) Then
    Begin

      If (Pos(edtDiaFixC.Text, 'SN') <= 0) or (fEmptyStr(edtDiaFixC.Text)) Then
      Begin
        fMensagem('ATENÇÃO','O campo usar dia fixo deve ser "S" ou "N"!',['&O K']);
        Result := False;
      End
      Else If (edtDiaFixC.Text = 'S') Then
      Begin
        lblPeriodicidC.Visible := False;
        edtPeriodC.Visible := False;
        edtPeriodC.Clear;
      End
      Else
      Begin
        lblPeriodicidC.Visible := True;
        edtPeriodC.Visible := True;
      End;

    End
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

    End
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

    End
    {*****************************************}
    {* VALIDA O CAMPO "VEIO BOLETO?" E       *}
    {* "PREVISÃO?"                           *}
    {**************************************MV*}
    {*****************************************}
    {* VALIDA O CAMPO "DEPOSITO"             *}
    {**************************************AA*}
    {************************************}
    {* VALIDA SE UTILIZA CHEQUE SIM/NAO *}
    {*********************************LB*}
    Else If ((Sender = edtVeiobo) And edtVeiobo.Enabled) Or
            ((Sender = edtDeposi) And edtDeposi.Enabled) Or
            ((Sender = edtUsaChq) And edtUsaChq.Enabled) Or
            ((Sender = edtPrevis) And edtPrevis.Enabled) Or
            ((Sender = edtVeioNF) And edtVeioNF.Enabled) Or
            ((Sender = edtUsoCon) And edtUsoCon.Enabled) Or
            ((Sender = edtPagAnt) And edtPagAnt.Enabled) Then
    Begin

      Result := fValidaChqBolDep(Sender);

    End
    Else If (Sender = edtTipDoc ) Then
    Begin

      {************************************}
      {* VALIDA O CAMPO TIPO DE DOCUMENTO *}
      {*********************************RV*}
      If fEmptyStr(edtTipDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Tipo de Documento deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (Pos(edtTipDoc.Text, '1_2_3_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO','O Tipo de Documento deve ser 1, 2 ou 3!',['&O K']);
          Result := False;
        End;

        If (edtTipDoc.Text = '2') Then
        Begin
          LcbGuiaTributo.Visible := True;
          LcbTipoTributo.Visible := True;
          spbDicaTributo.Visible := True;
          lblGuia.Visible := True;
        End
        Else
        Begin
          LcbGuiaTributo.Visible := False;
          spbDicaTributo.Visible := False;
          LcbGuiaTributo.KeyValue := -1;
          LcbTipoTributo.Visible := False;
          LcbTipoTributo.KeyValue := Null;
          lblGuia.Visible := False;
        End;

    End

    End
    Else If (Sender = edtNumDup) Then
    Begin

      If (Not fEmptyStr(edtNumDup.Text)) And
         (fCampoTabela('COUNT(*) AS QTD',
                       'CADPAG',
                       ['CTP_NUMDUP', 'CTP_CODFOR', 'CTP_CODEMP'],
                       [Concat('G', edtNumDup.Text), edtCodFor.Text, edtCodEmp.Text])) > 0 Then
      Begin
        fMensagem('ATENÇÃO','A duplicata (' + Concat('G', edtNumDup.Text) + ') já existe!',['&O K']);
        Result := False;
      End;

    End

    {****************************************************}
    {* VALIDA O CÓDIGO DE RECEITA CASO FOR TRIBUTO      *}
    {*************************************************CH*}
    Else If (Sender = LcbTipoTributo) Then
    Begin
      If ((LcbGuiatributo.KeyValue > 0) And
          (LcbGuiatributo.KeyValue <> 8) And //ISS
          (LcbGuiatributo.KeyValue <> 9) And //IPTU
          (fEmptyStr(LcbTipoTributo.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código de receita do tributo deve ser informado. Verifique!', ['&O k']);
        Result := False;
      End;

      If ((LcbGuiaTributo.KeyValue < 0 ) And (Not fEmptyStr(LcbTipoTributo.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da guia deve ser informada. Verifique!', ['&O k']);
        Result := False;
      End;
    End

    {****************************************************}
    {* VALIDA SE A PERIODICIDADE DE CADASTRO ESTA IGUAL *}
    {* A PERIODICIDADE DE VENCIMENTO. *******************}
    {****************************************************}
    Else If (Sender = chkDtCadVenc) and (chkDtCadVenc.Checked) then
    begin
      if not fPodeManterDtaCadEDtaVenIguais then
      begin
        fMensagem('ATENÇÃO',
                  'Para que a data de cadastro e a data de vencimento permaneçam iguais, ' +
                  'é necessário que a periodicidade de ambas também seja igual.',
                  ['&OK']);

        chkDtCadVenc.Checked := False;
        Result := False;
      end;
    end;

  End;
  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmGerAutCtaPagar.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmGerAutCtaPagar.pCarregaCentroCusto;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, edtCodFor.Text);

  With qryConCta Do
  Begin
    if not fEmptyStr(fraPlanoDeContas.MskCodCta.text) then
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString
    else
      fraPlanoDeContas.edtDesCta.Text := '';
  End;

end;

procedure TfrmGerAutCtaPagar.pCarregaCtaFornecedor(strCodFor: String);
begin
  if Not fEmptyStr(strCodFor) then
  begin
    with qryCtaFor do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CTAFOR WHERE CTF_CODFOR = ' + strCodFor + '' );
      Open;
    end;
  end
end;

procedure TfrmGerAutCtaPagar.pCarregaDadosBancariosFornecedor(
  strCodFor: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    cbxBcoFor.Clear;
    lstBcoFor.Clear;
    With qryGen, SQL Do
    Begin
      Clear;
      Add(getSQLDadosBancariosFornecedor(True));
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      While Not Eof Do
      Begin
        cbxBcoFor.Items.Add(Trim(FieldByName('DESC_CONTA').AsString));
        lstBcoFor.Add(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      Close;
    End;
  Finally
    If Pred(cbxBcoFor.Items.Count) >= intIdxBcoForAnt Then
      cbxBcoFor.ItemIndex := intIdxBcoForAnt;
    pTrataBcoFor;
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmGerAutCtaPagar.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerAutCtaPagar.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmGerAutCtaPagar.pCriaTemporaria;
  Var
    strSQL: String;
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
begin
  Try
    cdsCtaPag.Close;
    qryCtaPag := fCriaQuery(Self);
    dspCtaPag := TUniDataSetProvider.Create(Self);
    dspCtaPag.DataSet := qryCtaPag;
    cdsCtaPag.SetProvider(dspCtaPag);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  "  " AS TMP_PARCEL, ';
    strSQL := strSQL + '  "       " AS TMP_COMPET, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS TMP_DTACAD, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS TMP_DTAPAR, ';
    strSQL := strSQL + '  "' + fReplicatorStr(' ', 400) + '" AS TMP_HISTOR, ';
    strSQL := strSQL + '  0.00 AS TMP_VALPAR, ';
    strSQL := strSQL + '  0.00 AS CTP_DESSUJ, ';
    strSQL := strSQL + '  0.00 AS CTP_JURSUJ, ';
    strSQL := strSQL + '  0.00 AS CTP_MULSUJ, ';
    strSQL := strSQL + '  0.00 AS VLR_TOTALPARC, ';
    strSQL := strSQL + '  0 AS TMP_Q_GUIA, ';
    strSQL := strSQL + '  "      " AS TMP_CODREC, ';
    strSQL := strSQL + '  "' + fReplicatorStr(' ',  3) + '" AS TMP_CODEMP, ';
    strSQL := strSQL + '  "' + fReplicatorStr(' ', 12) + '" AS TMP_NUMDUP, ';
    strSQL := strSQL + '  "' + fReplicatorStr(' ',  8) + '" AS TMP_CODFOR, ';
    strSQL := strSQL + '  "' + fReplicatorStr(' ', 60) + '" AS TMP_NOMFOR ';
    strSQL := strSQL + '  LIMIT 0 ';

    With qryCtaPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      pSetaClient(qryCtaPag);
    End;

    With cdsCtaPag Do
    Begin
      AfterOpen := pAfterOpen;
      Open;
      //BeforePost := pAtualizaDados;
      //AfterPost := pAfterPost;
      //BeforeInsert := pBeforeInsert;
    End;

    qryCtaPag.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmGerAutCtaPagar.pCriaTemporaria]');
  End;

  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

procedure TfrmGerAutCtaPagar.pImprimeCP;
  Var
    intContador: Integer;
begin
  For intContador := 0 To Length(arrImprimeCP) - 1 Do
  Begin
    ImprimeCP(arrImprimeCP[intContador].strNumDup,
              arrImprimeCP[intContador].strParcel,
              strCodEmp,
              arrImprimeCP[intContador].strCodFor,
              arrImprimeCP[intContador].strSerie_,
              'FRMCADCTAPAGAR',
              True);
  End;

  pEfetuaImpressao(True, 'FRMCADCTAPAGAR');
end;

procedure TfrmGerAutCtaPagar.pIniciaValoresPadrao;
begin
  If fCfgSis('VEIONF') <> 'B' Then
    edtVeioNF.Text := fCfgSis('VEIONF');

  If fCfgSis('VEIOBO') <> 'B' Then
    edtVeiobo.Text := fCfgSis('VEIOBO');
end;

procedure TfrmGerAutCtaPagar.pInsereTemporaria;
  Var
    intContador: Integer;
    intQtdPar  : Integer;
    dtaParcela : TDate;
    dtaCadastr : TDate;
    dtaCadastrVenc : TDate;
    dtaDtaBas  : TDate;
    dtaDtaBaC  : TDate;
    intIndice  : Integer;
    intIndCad  : Integer;
    strDiaVenc,
    strDiaCad  : String;
    strCodRec  : String;
    intQ_Guia: Integer;

    LNumDup: String;
begin
  intQtdPar  := (StrToInt(edtQtdParcela.Text)-1);
  dtaParcela := StrToDate(mskDtaParcela.Text);
  dtaCadastr := VS_Date;
  dtaCadastrVenc := IIF(chkDtCadVenc.Checked,dtaParcela,VS_Date);
  intQ_Guia  := 0;
  strCodRec  := '0';

  If (dtaParcela < dtaCadastr) Then
    dtaCadastr := dtaParcela;

  If LcbGuiaTributo.KeyValue > 0 Then
    intQ_Guia  := LcbGuiaTributo.KeyValue;

  If Not VarToStr(LcbTipoTributo.KeyValue).IsEmpty Then
  Begin
    If (VarToStr(LcbTipoTributo.KeyValue) <> '0') Then
      strCodRec := LcbTipoTributo.KeyValue;
  End;

  If (fEmptyStr(edtNumDup.Text)) Then
    LNumDup := fRetSequencialCadPag(1, edtCodEmp.Text)
  Else
    LNumDup := 'G' + edtNumDup.Text;

  With cdsCtaPag Do
  Begin
    cdsCtaPag.DisableControls;
    cdsCtaPag.BeforePost := Nil;
    cdsCtaPag.AfterPost  := Nil;
    cdsCtaPag.EmptyDataSet;

    AggregatesActive := False;
    dtaDtaBas := dtaParcela;
    dtaDtaBaC := dtaCadastr;
    intIndice := 1;
    intIndCad := 1;

    For intContador := 65 To 65+intQtdPar Do
    Begin
      strDiaVenc := formatdatetime('dd',dtaParcela);
      strDiaCad  := formatdatetime('dd',dtaCadastrVenc);

      If(chkDtCadVenc.Checked) Then
      Begin
        If(StrtoInt(strDiaVenc) > StrToInt(strDiaCad)) And (edtDiaFixC.Text <> 'S') Then
        Begin
          dtaCadastr:= ((dtaParcela - StrToInt(strDiaVenc)) + StrToInt(strDiaCad));
        End
        Else
        Begin
          dtaCadastr := dtaParcela;
        End;

      End;
      Append;
      FieldByName('TMP_PARCEL').AsString   := IIF(intQtdPar > 25, 'A', Chr(intContador));
      FieldByName('TMP_DTACAD').AsDateTime := dtaCadastr;
      FieldByName('TMP_DTAPAR').AsDateTime := dtaParcela;

      FieldByName('TMP_COMPET').AsString   := fRetornaCompetencia;

      FieldByName('TMP_HISTOR').AsString   := edtHist01.Text;
      FieldByName('TMP_VALPAR').AsFloat    := fStrToFloat(edtValParcela.Text);
      FieldByName('CTP_DESSUJ').AsFloat    := fStrToFloat(edtDesSuj.Text);
      FieldByName('CTP_JURSUJ').AsFloat    := fStrToFloat(edtJurSuj.Text);
      FieldByName('CTP_MULSUJ').AsFloat    := fStrToFloat(edtMulSuj.Text);

      FieldByName('VLR_TOTALPARC').AsFloat := fStrToFloat(edtValTotalParc.Text);

      FieldByName('TMP_Q_GUIA').AsInteger  := intQ_Guia;
      FieldByName('TMP_CODREC').AsString   := strCodRec;

      FieldByName('TMP_CODEMP').AsString   := edtCodEmp.Text;
      FieldByName('TMP_CODFOR').AsString   := edtCodFor.Text;
      FieldByName('TMP_NOMFOR').AsString   := fRetNomFornecedor(edtCodFor.Text);
      FieldByName('TMP_NUMDUP').AsString   := LNumDup;

      Post;
      If (edtDiaFix.Text = 'S') Then
      Begin
        dtaParcela := IncMonth(dtaDtaBas, intIndice);
        Inc(intIndice);
      End
      Else dtaParcela := dtaParcela + StrToInt(edtPeriod.Text);

      If Not chkDtCadFixa.Checked  Then
      Begin

        If (edtDiaFixC.Text = 'S') Then
        Begin
          dtaCadastr := IncMonth(dtaDtaBaC, intIndCad);
          dtaCadastrVenc := IncMonth(dtaDtaBaC, intIndCad);
          Inc(intIndCad);
        End
        Else
        Begin
          dtaCadastr := dtaCadastr + StrToInt(edtPeriodC.Text);
          dtaCadastrVenc := dtaCadastrVenc + StrToInt(edtPeriodC.Text);
        End;

        If dtaCadastr > dtaParcela Then
          dtaCadastr := dtaParcela;
      End;

      Application.ProcessMessages;
      dtaCadastrVenc := IIF(chkDtCadVenc.Checked,dtaParcela,dtaCadastrVenc);
    End;
  End;
  pSomaValorParcela;
  btnDesmembr.Enabled := not cdsCtaPag.IsEmpty;
  cdsCtaPag.First;
  cdsCtaPag.EnableControls;
  cdsCtaPag.AggregatesActive := True;
  btnDesmembr.Enabled := Not cdsCtaPag.IsEmpty;

  cdsCtaPag.BeforePost := pAtualizaDados;
  cdsCtaPag.AfterPost  := pAfterPost;
end;


procedure TfrmGerAutCtaPagar.pLimpaDados;
begin

  edtDesSuj.Clear;
  edtJurSuj.Clear;
  edtMulSuj.Clear;
  edtValTotalParc.Clear;

  edtCodFor.Clear;
  edtNomFor.Clear;

  edtCodPor.Clear;
  edtNomPor.Clear;

  fraPlanoDeContas.MskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;

  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

  mskDtaParcela.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaParcelaExit(mskDtaParcela);
  chkDtCadFixa.Checked := True;
  mskCompet.Text := FormatDateTime('mm/YYYY', VS_Date);

  edtValParcela.Clear;
  edtQtdParcela.Clear;
  edtPeriod.Clear;
  edtPeriodC.Clear;
  edtNumDup.Clear;
  edtHist01.Clear;
  edtTotPar.Clear;
  edtSerie.Clear;
  edtTipDoc.Clear;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtCodPrj.Clear;
  edtDesPrj.Clear;

  edtValParcela.Enabled := True;
  fraPlanoDeContas.MskCodCta.Enabled := True;

  pCriaClientTemporariaCtpDet('', '', '', '', '', FDatasetCtpDet);

  strCtaAnt := '';
  strCodFor := '';

  edtUsaChq.Text := 'N';
  edtPrevis.Text := 'N';
  edtDeposi.Text := 'N';
  edtUsoCon.Text := 'N';
  edtPagAnt.Text := 'N';

  lblGuia.Visible := False;
  spbDicaTributo.Visible  := False;
  LcbGuiaTributo.Visible  := False;
  LcbGuiaTributo.KeyValue := -1;
  LcbTipoTributo.Visible  := False;
  LcbTipoTributo.KeyValue := Null;

  pIniciaValoresPadrao;

  edtQtdParcelaExit(nil);    
end;

procedure TfrmGerAutCtaPagar.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If (Not Assigned(FDatasetCtpDet)) Or (Not FDatasetCtpDet.Active)  Then
  begin
    FDatasetCtpDet := TUniClientDataSet.Create(Self);
    pCriaClientTemporariaCtpDet(edtNumDup.Text, '', edtSerie.Text, edtCodEmp.Text, edtCodFor.Text, FDatasetCtpDet);
  end;

  If fraPlanoDeContas.MskCodCta.Enabled = True Then
    If Not fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
    Begin
      pSetFocus(fraPlanoDeContas.MskCodCta);
    End;


  strCtaAnt := fraPlanoDeContas.MskCodCta.Text;
  If  fVerificaCampos Then
  Begin
    TfrmGravando.fExecutarModal(pInsereTemporaria, 'Aguarde... Gerando parcelas.','');
    pHabilitaCampos(False);
    grdDados.BorderStyle := cxcbsNone;
    grdDados.BorderStyle := cxcbsDefault;
    //ShowScrollBar(grdDados.Handle, SB_VERT, true);
    grdDadosDBTableView1.DataController.FocusedRowIndex := 0;
    pSetFocus(grdDados);
  End;
end;

procedure TfrmGerAutCtaPagar.btnCancelaClick(Sender: TObject);
begin
  pLimpaDados;
  cdsCtaPag.EnableControls;
  cdsCtaPag.Close;
  cdsCtaPag.Open;
  pSetFocus(edtCodFor);
end;

procedure TfrmGerAutCtaPagar.pAtualizaDados(DataSet: TDataSet);
begin
  If DataSet.FieldByName('TMP_VALPAR').AsFloat = 0.00  Then
  Begin
    fMensagem('ATENÇÃO','O Valor da parcela deve ser diferente de Zero!',['&OK']);
    Abort;
  End;
end;

procedure TfrmGerAutCtaPagar.pHabilitaCampos(blnHabDes:Boolean);
begin
  pnlDados.Enabled   := Not blnHabDes;
  btnGravar.Enabled  := Not blnHabDes;
End;

procedure TfrmGerAutCtaPagar.pSetText(Sender: TField; const Text: string);
begin
  If Trim(Text) = '/  /' Then
    Sender.Clear
  Else
    Sender.AsString := Text;
end;

procedure TfrmGerAutCtaPagar.pSomaValorParcela;
  Var
    cdsGen: TUniClientDataSet;
    fldValTot: TAggregateField;
    fldValDesc: TAggregateField;
    fldValJuro: TAggregateField;
    fldValMulta: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldValTot := TAggregateField.Create(Self);
  fldValDesc := TAggregateField.Create(Self);
  fldValJuro := TAggregateField.Create(Self);
  fldValMulta := TAggregateField.Create(Self);

  With fldValTot Do
  Begin
    FieldName := 'FLDVALTOT';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(TMP_VALPAR)';
    Active := True;
  End;

  With fldValDesc Do
  Begin
    FieldName := 'FLDVALDESC';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_DESSUJ)';
    Active := True;
  End;

  With fldValJuro Do
  Begin
    FieldName := 'FLDVALJURO';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_JURSUJ)';
    Active := True;
  End;

  With fldValMulta Do
  Begin
    FieldName := 'FLDVALMULTA';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTP_MULSUJ)';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;
    AggregatesActive := True;
    edtTotPar.Text := FloatToStrF(fldValTot.Value - fldValDesc.Value + fldValJuro.Value + fldValMulta.Value, ffNumber, 12, 2);
  End;

  FreeAndNil(fldValTot);
  FreeAndNil(fldValDesc);
  FreeAndNil(fldValJuro);
  FreeAndNil(fldValMulta);
  FreeAndNil(cdsGen);
end;

procedure TfrmGerAutCtaPagar.pTrataBcoFor;
begin
  cbxBcoFor.Enabled := (edtDeposi.Text = 'S');
  If (Not cbxBcoFor.Enabled) Then
    cbxBcoFor.ItemIndex := -1;
end;

procedure TfrmGerAutCtaPagar.pUtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
end;

procedure TfrmGerAutCtaPagar.spbDicaTributoClick(Sender: TObject);
begin

  inherited;
  fMensagem('Informação sobre tributos', 'Os tributos ISS, IPTU e FGTS não são tratados no AUTBAN.', ['&Ok']);
end;

procedure TfrmGerAutCtaPagar.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(cdsCtaPag.FieldByName('TMP_VALPAR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaPag.FieldByName('CTP_DESSUJ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaPag.FieldByName('CTP_JURSUJ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaPag.FieldByName('CTP_MULSUJ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCtaPag.FieldByName('VLR_TOTALPARC')).DisplayFormat := '#,##0.00';
  TStringField(cdsCtaPag.FieldByName('TMP_COMPET')).EditMask := '99/9999';
  TDateTimeField(cdsCtaPag.FieldByName('TMP_DTAPAR')).EditMask := '99/99/9999';
  TDateTimeField(cdsCtaPag.FieldByName('TMP_DTAPAR')).OnGetText := pGetText;
  TDateTimeField(cdsCtaPag.FieldByName('TMP_DTAPAR')).OnSetText := pSetText;
  TDateTimeField(cdsCtaPag.FieldByName('TMP_DTACAD')).EditMask := '99/99/9999';
  TDateTimeField(cdsCtaPag.FieldByName('TMP_DTACAD')).OnGetText := pGetText;
  TDateTimeField(cdsCtaPag.FieldByName('TMP_DTACAD')).OnSetText := pSetText;
end;

procedure TfrmGerAutCtaPagar.pAfterPost(DataSet: TDataSet);
begin

  {********************************}
  {* SOMA OS VALORES DAS PARCELAS *}
  {*****************************LB*}
  pSomaValorParcela;

  btnDesmembr.Enabled := not cdsCtaPag.IsEmpty;

end;

function TfrmGerAutCtaPagar.fVerificaMeta: Boolean;
  Var
    objMetaCusto: TMetaCentroCustoPedido;
    blnPedeSenha,
    blnExiste   : Boolean;
    arrMetas    : Array of TCtaMetas;
    intCont     : Integer;
    arrDuplicata: TarrDuplicata;
begin
  Result := True;
  pZeraDigDuplic(arrDuplicata);

  If (fCfgSis('METPED') <> '2') and (fCfgSis('METPED') <> '4') and
    (fCfgSis('METPED') <> '5') and (fCfgSis('METPED') <> '6') Then
    Exit;

  If Pos(edtCodFor.Text, fRetForFilialTodos) > 0 Then
    Exit;

  blnPedeSenha := False;
  cdsCtaPag.First;

  cdsCtaPag.DisableControls;
  cdsCtaPag.AggregatesActive := False;

  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  objMetaCusto := TMetaCentroCustoPedido.Create(Self);
  objMetaCusto.pInicializa;
  objMetaCusto.strCodFor := edtCodFor.Text;
  objMetaCusto.strNomFor := edtNomFor.Text;

  objMetaCusto.strAutIncCTP := fStrZero('0', 20);
  SetLength(arrMetas, 0);

  While Not cdsCtaPag.Eof Do
  Begin
    If FDatasetCtpDet.IsEmpty Then
      blnPedeSenha := Not objMetaCusto.fCarregaMetas(cdsCtaPag.FieldByName('TMP_DTAPAR').AsDateTime,
                                        edtCodEmp.Text,
                                        fraPlanoDeContas.MskCodCta.Text,
                                        '',
                                        '01.001',
                                        cdsCtaPag.FieldByName('TMP_VALPAR').AsFloat,
                                        False,
                                        arrDuplicata,
                                        '',
                                        fraCentroCusto.edtCodEve.Text)
                      Or blnPedeSenha
    Else
    Begin
      FDatasetCtpDet.First;
      While Not FDatasetCtpDet.Eof Do
      Begin
        blnExiste := False;
        For intCont := 0 To Length(arrMetas) - 1 Do
        Begin
          If (arrMetas[intCont].strCodCta = FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString) And
             (arrMetas[intCont].strCodEmp = IIF(fCfgSis('METPED') = '4', 'Todas', FDatasetCtpDet.FieldByName('CTP_CODEMP').AsString)) And
             (arrMetas[intCont].dtaDtaPar = cdsCtaPag.FieldByName('TMP_DTAPAR').AsDateTime) Then
          Begin
            blnExiste := True;
            Break;
          End;
        End;

        If blnExiste Then
          arrMetas[intCont].fltValDup := arrMetas[intCont].fltValDup + (cdsCtaPag.FieldByName('TMP_VALPAR').AsFloat * FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat)
        Else
        Begin
          SetLength(arrMetas, Length(arrMetas) + 1);
          intCont := Length(arrMetas) - 1;
          arrMetas[intCont].strCodCta := FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString;
          arrMetas[intCont].strCodEmp := IIF(fCfgSis('METPED') = '4', 'Todas', FDatasetCtpDet.FieldByName('CTP_CODEMP').AsString);
          arrMetas[intCont].fltValDup := (cdsCtaPag.FieldByName('TMP_VALPAR').AsFloat * FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat);
          arrMetas[intCont].dtaDtaPar := cdsCtaPag.FieldByName('TMP_DTAPAR').AsDateTime;
        End;
        FDatasetCtpDet.Next;
      End;

      For intCont := 0 To Length(arrMetas) - 1 Do
      Begin
        blnPedeSenha := (Not objMetaCusto.fCarregaMetas(arrMetas[intCont].dtaDtaPar,
                                                        IIF(fCfgSis('METPED') = '4', arrMetas[intCont].strCodCta, arrMetas[intCont].strCodEmp),
                                                        arrMetas[intCont].strCodCta,
                                                        '',
                                                        '01.001',
                                                        arrMetas[intCont].fltValDup, fraCentroCusto.edtCodEve.Text))

                        Or (blnPedeSenha);
      End;

    End;
    cdsCtaPag.Next;
  End;
  Result := IIF(blnPedeSenha, objMetaCusto.fPedeSenha, True);

  FreeAndNil(objMetaCusto);
  cdsCtaPag.EnableControls;
  cdsCtaPag.AggregatesActive := True;
end;

procedure TfrmGerAutCtaPagar.grdDadosDBTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    If cdsCtaPag.State In [dsInsert, dsEdit] Then
      cdsCtaPag.Post;
    pSomaValorParcela;
  End;
end;

procedure TfrmGerAutCtaPagar.grdDadosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Var
  blnUltimoRegistro: Boolean;
  blnUltimaColuna: Boolean;
begin
  inherited;

  {********************************************}
  {* REMOVE TECLAS INCLUSÃO E DELEÇÃO NA GRID *}
  {*****************************************FS*}
  blnUltimoRegistro := (grdDadosDBTableView1.DataController.DataSource.DataSet.RecNo = grdDadosDBTableView1.DataController.DataSet.RecordCount);
  blnUltimaColuna   := grdDadosDBTableView1.Controller.FocusedItemIndex = 4;

  If (Key = VK_INSERT) Or
    ((Key = VK_DOWN) And blnUltimoRegistro) Or
    ((Key = VK_TAB) And blnUltimoRegistro And blnUltimaColuna)Or
    (Key = VK_DELETE) Then
    Key := VK_NONAME;

  If (Key = VK_Escape) Then
  Begin

    pSetFocus(fraPlanoDeContas.MskCodCta);

    btnConfirmar.Enabled := True;
    btnCancela.Enabled   := True;
  End;

  If (Key = VK_F10) Then
    btnGravar.Click;

end;

procedure TfrmGerAutCtaPagar.LcbGuiaTributoExit(Sender: TObject);
begin
  inherited;
  If LcbGuiaTributo.KeyValue > 0 then
  Begin
    qryTipoTributo.Close;
    qryTipoTributo.SQL.Clear;
    qryTipoTributo.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
    qryTipoTributo.SQL.Add('FROM TIPTRI ');
    qryTipoTributo.SQL.Add('WHERE TRI_CODGUI = :CODGUI ');
    qryTipoTributo.ParamByName('CODGUI').AsInteger := LcbGuiaTributo.KeyValue;
    qryTipoTributo.Open;
  End;

  LcbTipoTributo.Enabled := qryTipoTributo.RecordCount > 0;
end;

procedure TfrmGerAutCtaPagar.mskDtaParcelaExit(Sender: TObject);
begin
  inherited;

  If (StrToDate(mskDtaParcela.Text) < VS_DATE) Then
  Begin
    chkDtCadFixa.Checked := False;
    chkDtCadFixaClick(chkDtCadFixa);
    chkDtCadFixa.Enabled := False;
  End
  Else
    chkDtCadFixa.Enabled := True;

end;

procedure TfrmGerAutCtaPagar.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not fValidaDatasTemporarias Then
  Begin
    fMensagem('ATENÇÃO', 'Existe(m) duplicata(s) com data de cadastro maior que o vencimento!' +
                          #13#10 + 'Favor verificar antes de continuar...',['&O K']);
    Exit;
  End;

  If (Not fVerificaCampos) Or (cdsCtaPag.IsEmpty) Or
     (fMensagem('', 'Confirma Gravação?', ['&Sim', '&Não']) = 2) Then
  Begin
    Exit;
  End;

  If (fCfgSis('TIDVIC', varBoolean)) Then
  Begin
    If (Not fValidaDtaVenCompetencia(mskDtaParcela.Date, StrToDate('01/'+ mskCompet.Text))) Then
    Begin
      pMensagemOk('Não é permitida a inclusão da duplicata com Data de Vencimento inferior a Data de Competência');
      pSetFocus(mskDtaParcela);
      Exit;
    End;
  End;

  If Not fVerificaMeta Then
    Exit;

  TfrmGravando.fExecutarModal(pGeraDuplicatas, 'Aguarde... Gerando duplicatas.','');
  cdsCtaPag.EnableControls;
  cdsCtaPag.Close;
  cdsCtaPag.Open;
  CarregaGuiasETributos;
  LcbGuiaTributo.DataSource := dtsCtaPag;
  LcbTipoTributo.DataSource := dtsCtaPag;
  dtsGuiaTributo.DataSet := qryGuiaTributo;
  dtsTipoTributo.DataSet := qryTipoTributo;
end;

procedure TfrmGerAutCtaPagar.CarregaGuiasETributos;
begin
  qryGuiaTributo.Close;
  qryGuiaTributo.SQL.Clear;
  qryGuiaTributo.SQL.Add('SELECT GUI_CODGUI, GUI_DESCRI ');
  qryGuiaTributo.SQL.Add('FROM GUITRI ');
  qryGuiaTributo.Open;

  qryTipoTributo.Close;
  qryTipoTributo.SQL.Clear;
  qryTipoTributo.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
  qryTipoTributo.SQL.Add('FROM TIPTRI ');
  qryTipoTributo.SQL.Add('WHERE FALSE ');
  qryTipoTributo.Open;
end;

procedure TfrmGerAutCtaPagar.cbxBcoForChange(Sender: TObject);
begin
  inherited;
  intIdxBcoForAnt := cbxBcoFor.ItemIndex;
end;

procedure TfrmGerAutCtaPagar.cbxBcoForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para incluir/alterar dados bancários do fornecedor';
end;

procedure TfrmGerAutCtaPagar.cbxBcoForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmGerAutCtaPagar.cbxBcoForKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If fIsInsert(Key) And fValidaCampos(edtCodFor, True) Then
  Begin

    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

    try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := edtCodFor.Text;
      frmCadFornecedores.fMskCon := fMskCon;
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
      frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pCarregaDadosBancariosFornecedor(edtCodFor.Text);
      pFreeAndNil(frmCadFornecedores);
    End;

  End;
end;

procedure TfrmGerAutCtaPagar.chkDtCadFixaClick(Sender: TObject);
begin
  inherited;

  If chkDtCadFixa.Checked Then
  Begin
    gpbCadastro.Enabled    := False;
    lblCadastro.Enabled    := False;
    lblPeriodicidC.Enabled := False;
    lblSNCadast.Enabled    := False;
    edtDiaFixC.Enabled     := False;
    chkDtCadVenc.Enabled   := False;
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
    chkDtCadVenc.Enabled   := True;
    edtPeriodC.Enabled     := True;
    edtDiaFixC.Color       := clWindow;
    edtPeriodC.Color       := clWindow;
    edtDiaFixC.Text        := 'N';
  End;

  edtDiaFixCExit(edtDiaFixC);
end;

procedure TfrmGerAutCtaPagar.chkDtCadVencClick(Sender: TObject);
begin
  fValidaCampos(chkDtCadVenc, True);
end;

procedure TfrmGerAutCtaPagar.pBeforeInsert(DataSet: TDataSet);
begin
 // If (pnlDados.Enabled) Then
 //   Abort;
end;

procedure TfrmGerAutCtaPagar.edtCodForKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_INSERT) Then
  Begin
    TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
    edtCodFor.Text := untFuncIns.fChamaCadFor(Key);
    qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
    qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  End;
end;

procedure TfrmGerAutCtaPagar.edtCodForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '(INSERT) para fazer um novo cadastro';
end;

procedure TfrmGerAutCtaPagar.edtCodForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmGerAutCtaPagar.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmGerAutCtaPagar.edtDeposiChange(Sender: TObject);
begin
  inherited;
  pTrataBcoFor;
end;

procedure TfrmGerAutCtaPagar.edtDiaFixCExit(Sender: TObject);
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

procedure TfrmGerAutCtaPagar.edtDiaFixExit(Sender: TObject);
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

procedure TfrmGerAutCtaPagar.edtQtdParcelaExit(Sender: TObject);
begin
  inherited;
  If (StrToIntDef(edtQtdParcela.Text,0)-1) > 25 Then
  Begin
    edtSerie.Clear;
    lblSerie.Visible := False;
    edtSerie.Visible := False;
  End
  Else
  Begin
    lblSerie.Visible := True;
    edtSerie.Visible := True;
  End;
end;


procedure TfrmGerAutCtaPagar.edtTipDocEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + edtTipDoc.Left + edtTipDoc.Width,
                         130 + Self.Top + edtTipDoc.Top + edtTipDoc.Height, 'Tipos de Documento:', edtTipDoc.Hint);
end;

procedure TfrmGerAutCtaPagar.edtTipDocExit(Sender: TObject);
begin
  inherited;

  HintControler.HideHint;
end;

procedure TfrmGerAutCtaPagar.edtValParcelaExit(Sender: TObject);
begin
  inherited;
  {If (fStrToFloat(edtValParcela.Text) = 0) Then
    btnDesmembr.Enabled := False
  Else
    btnDesmembr.Enabled := True;}
end;

procedure TfrmGerAutCtaPagar.btnDesmembrClick(Sender: TObject);
begin
  inherited;
  pDesmembraValores;
end;

procedure TfrmGerAutCtaPagar.pDesmembraValores;
  Var
    frmDesmembrValores : TfrmDesmembrValores;
Begin
  frmDesmembrValores := Nil;
  {*****************************************************************************}
  {* SÓ PERMITI ENTRAR NA TELA DE DESMEMBRAMENTO SE O VALOR FOR MAIOR QUE ZERO *}
  {**************************************************************************LU*}
  {***************************************************************************}
  {* SOLICITAÇÃO DA MACHADO PARA LIBERAR DESMEMBRAMENTO DE VALORES NEGATIVOS *}
  {************************************************************09/01/2012**JU*}
  If (fStrToFloat(edtValParcela.Text) = 0)Then
  Begin
    fMensagem('', 'Digite o Valor da Duplicata antes de realizar o desmembramento!', ['&Ok']);
    Exit;
  End;

  Try
    Try
      {*****************************************}
      {* CHAMA O FORM DE DESMEMBRAMENTO        *}
      {**************************************MV*}
      pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);
      frmDesmembrValores.DatasetCtpDet  := FDatasetCtpDet;
      frmDesmembrValores.strNumDup  := '';
      frmDesmembrValores.strParcel  := '';
      frmDesmembrValores.strSerie   := '';
      frmDesmembrValores.strCodEmp  := edtCodEmp.Text;
      frmDesmembrValores.strCodFor  := edtCodFor.Text;
      frmDesmembrValores.blnBaixada := False;
      frmDesmembrValores.fltValTot  := cdsCtaPag.FieldByName('TMP_VALPAR').AsFloat;

      frmDesmembrValores.showModal;

      If FDatasetCtpDet <> frmDesmembrValores.DatasetCtpDet Then
        FreeAndNil(FDatasetCtpDet);

      FDatasetCtpDet := frmDesmembrValores.DatasetCtpDet;

      If Not FDatasetCtpDet.IsEmpty Then
      Begin
        edtValParcela.Enabled := False;
        fraPlanoDeContas.MskCodCta.Enabled := False;
        fraPlanoDeContas.MskCodCta.Text    := IIF((frmDesmembrValores.strCodCta = ''), fCfgSis('CTAPRI'), frmDesmembrValores.strCodCta);
        pCarregaCentroCusto;
        If fVerificaEvenRat(FDatasetCtpDet) Then
        Begin
          fraCentroCusto.edtCodEve.Text  := fCfgSis('EVEPRI');
          fraCentroCusto.edtCodEve.Enabled := False;
          pCarregaEventos;
        End
        Else
        Begin
          fraCentroCusto.edtCodEve.Enabled := True;
          pCarregaEventos;
        End;
      End
      Else
      Begin
        edtValParcela.Enabled := True;
        fraPlanoDeContas.MskCodCta.Enabled := True;
        fraCentroCusto.edtCodEve.Enabled := True;
        fraPlanoDeContas.MskCodCta.Clear;
        fraPlanoDeContas.edtDesCta.Clear;
        fraCentroCusto.edtCodEve.Clear;
        fraCentroCusto.edtDesEve.Clear;
        pSetFocus(fraPlanoDeContas.MskCodCta);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmGerAutCtaPagar.pDesmembraValores]');
      End;
    End;
  Finally
    FreeAndNil(frmDesmembrValores);
  End;
End;

procedure TfrmGerAutCtaPagar.pGeraDuplicatas;
  Var
    intContador : Integer;
    strSequen   : String;
    blnRetorno  : Boolean;
    intQtdPar   : Integer;

begin
  intQtdPar := StrToIntDef(edtQtdParcela.Text, 0);
  intContador := 0;
  blnRetorno := True;

  With cdsCtaPag Do
  Begin
    cdsCtaPag.DisableControls;
    {**************************************}
    {* ABRE TRANSACAO                     *}
    {***********************************LB*}
    fStartTransaction;

    Try
      {**************************************}
      {* PROCESSA TEMPORARIA                *}
      {***********************************LB*}
      First;
      While (Not Eof) And (blnRetorno) Do
      Begin
        Try
          Inc(intContador);
          strSequen  := IIF(intQtdPar > 26, fStrZero(IntToStr(intContador),3), edtSerie.Text);

          strNumDup := cdsCtaPag.FieldByName('TMP_NUMDUP').AsString;

          blnRetorno := fGravaCadPag('frmGerAutCtaPagar',
                                     'INCLUSAO - GERACAO AUTOMATICA',
                                     edtCodFor.Text,
                                     strNumDup,
                                     FieldByName('TMP_PARCEL').AsString,
                                     edtCodEmp.Text,
                                     fraPlanoDeContas.MskCodCta.Text,
                                     strSequen,
                                     0,
                                     FieldByName('TMP_DTACAD').AsDateTime,
                                     FieldByName('TMP_DTAPAR').AsDateTime,
                                     FieldByName('TMP_VALPAR').AsFloat,
                                     FieldByName('TMP_VALPAR').AsFloat,
                                     edtPrevis.Text,
                                     edtVeiobo.Text,
                                     edtDeposi.Text,                    // Deposito
                                     UpperCase(FieldByName('TMP_HISTOR').AsString) +
                                        '-' + fStrZero(IntToStr(intContador), 2) +
                                        '/' + fStrZero(IntToStr( intQtdPar ), 2),
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     0,
                                     0,
                                     0,
                                     '',
                                     fraCentroCusto.edtCodEve.Text,
                                     edtUsaChq.Text,
                                     edtCodPor.Text,
                                     '',
                                     fStrtoFloat(edtJurSuj.Text),
                                     fStrtoFloat(edtDesSuj.Text),
                                     0,
                                     False,
                                     0,
                                     edtTipDoc.Text,
                                     0,
                                     edtVeioNF.Text,
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     edtUsoCon.Text,
                                     fRetornaCompetencia,
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     0,
                                     0,
                                     0,
                                     '',
                                     0,
                                     0,
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     FieldByName('TMP_Q_GUIA').AsString,
                                     FieldByName('TMP_CODREC').AsString,
                                     strBcoFor,
                                     '',
                                     edtCodPrj.Text,
                                     edtPagAnt.Text,
                                      '',
                                      '',
                                      '',
                                      '',
                                       0,
                                      '',
                                      fStrtoFloat(edtMulSuj.Text),
                                      strForPix);

          // verificar a query das linhas abaixo pois foi adicionada com parametro
          If (Not blnRetorno) Or
             (Not fGravaFatorCalculado(strNumDup,
                                       cdsCtaPag.FieldByName('TMP_PARCEL').AsString,
                                       cdsCtaPag.FieldByName('TMP_CODEMP').AsString,
                                       cdsCtaPag.FieldByName('TMP_CODFOR').AsString,
                                       strSequen,
                                       FDatasetCtpDet,
                                       Self.Name,
                                       True)) Then
          Begin
            fRollBack;
            Break;
          End
          Else
          Begin
            SetLength(arrImprimeCP, intContador);
            arrImprimeCP[intContador - 1].strNumDup := strNumDup;
            arrImprimeCP[intContador - 1].strParcel := FieldByName('TMP_PARCEL').AsString;
            arrImprimeCP[intContador - 1].strCodFor := edtCodFor.Text;
            arrImprimeCP[intContador - 1].strSerie_ := strSequen;
          End;
        Except
          On E: Exception Do
          Begin
            blnRetorno := False;
            fMensagem('','Ocorreu um erro ao realizar a geração automática de duplicatas!' + #13 + E.Message,['&OK']);
            fRollBack;
            Break;
          End;
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

      pHabilitaCampos(True);
      cdsCtaPag.EmptyDataSet;
      strCodEmp := edtCodEmp.Text;
      pLimpaDados;
      btnDesmembr.Enabled := FALSE;
      fMensagem('','Geração concluída.',['&Ok']);

      If Length(arrImprimeCP) > 0 Then
      Begin
        If fMensagem('', 'Deseja imprimir CP?', ['&Sim', '&Não'], 2) = 1 Then
          pImprimeCP;
      End;

      pSetFocus(edtCodFor);
    End Else
    Begin
      fRollBack;
      pHabilitaCampos(True);
    End;
  End;
end;

procedure TfrmGerAutCtaPagar.pGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  If Not Sender.IsNull Then
    Text := FormatDateTime('dd/MM/yyyy', Sender.AsDateTime)
  Else
    Text := '';
end;

procedure TfrmGerAutCtaPagar.FormShow(Sender: TObject);
begin
  inherited;
  pUtilizaRotinaProjeto;
  strCtaAnt := '';
  qryCtaFor := fCriaQuery;
  CarregaGuiasETributos;
  pIniciaValoresPadrao;
end;

procedure TfrmGerAutCtaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F8: If (btnDesmembr.Enabled) Then
             btnDesmembr.Click;
  End;

end;

procedure TfrmGerAutCtaPagar.pnlCamposEnter(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    btnGravar.Enabled := False;
    cdsCtaPag.EmptyDataSet;
    edtTotPar.Clear;
    btnDesmembr.Enabled := FALSE;
  End;
end;

procedure TfrmGerAutCtaPagar.pPreencheCentroCusto;
begin
  If fCfgSis('USACTF', varBoolean) Then
  begin
    pCarregaCtaFornecedor(edtCodFor.Text);
    fraPlanoDeContas.MskCodCta.Text := qryCtaFor.FieldByName('CTF_CODCTA').AsString
  end
  else
  begin
    if Not qryConFor.IsEmpty Then
    begin
      fraPlanoDeContas.MskCodCta.Text := qryConFor.FieldByName('FOR_CODCTA').AsString;
    end;

    strCtaFor := fraPlanoDeContas.MskCodCta.Text;
  end;
  strCtaAut := fraPlanoDeContas.MskCodCta.Text;
  pCarregaCentroCusto;
end;

function TfrmGerAutCtaPagar.fValidaChqBolDep(Sender: TWinControl): Boolean;
begin
  Result := True;

  If Pos(TEditFocus(Sender).Text, 'SN') <= 0 Then
  Begin
    Result := False;
    fMensagem('','O campo deve ser informado com (S)im ou (N)ão!', ['&Ok']);
  End
  Else If TEditFocus(Sender).Text = 'S' Then
  Begin
    If (Sender = edtUsaChq) Then
    Begin
      If (edtVeiobo.Text = 'S') Or (edtDeposi.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('','Para informar cheque como (S)im, os campos deposito e veio boleto devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;

    If (Sender = edtVeiobo) Then
    Begin
      If (edtUsaChq.Text = 'S') Or (edtDeposi.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('','Para informar veio boleto como (S)im, os campos deposito e cheque devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;

    If (Sender = edtDeposi) Then
    Begin
      If (edtUsaChq.Text = 'S') Or (edtVeiobo.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('','Para informar deposito como (S)im, os campos veio boleto e cheque devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;

    If (Sender = edtPrevis) Then
    Begin
      If (edtPrevis.Text = 'S') And (edtPagAnt.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!','Para informar previsão como (S)im, o campo pagamento antecipado deve estar igual à (N)ão!', ['&Ok']);
      End
    End;

    If (Sender = edtPagAnt) Then
    Begin
      If (edtPrevis.Text = 'S') And (edtPagAnt.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!','Para informar pagamento antecipado como (S)im, o campo previsão deve estar igual à (N)ão!', ['&Ok']);
      End
    End;
  End
  Else
  Begin
    If (Sender = edtPrevis) Then
    Begin
      If (blnGravaApenasPrevisao) And (edtPrevis.Text = 'N') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO','Essa conta deve possuir o campo Previsão igual a (S)im!', ['&Ok']);
      End;
    End;
  End;

end;

function TfrmGerAutCtaPagar.fValidaDatasTemporarias: Boolean;
begin
  Result := True;

  If cdsCtaPag.IsEmpty Then
    Exit;

  With cdsCtaPag Do
  Begin
    cdsCtaPag.DisableControls;
    First;
    While Not Eof Do
    Begin
      If FieldByName('TMP_DTACAD').AsDateTime > FieldByName('TMP_DTAPAR').AsDateTime Then
        Result := False;

      Next;
    End;
  End;
  cdsCtaPag.First;
  cdsCtaPag.EnableControls;
end;

function TfrmGerAutCtaPagar.fGetBcoFor: String;
begin
  If cbxBcoFor.ItemIndex > -1 Then
  Begin
    If (Pos('PIX', cbxBcoFor.Text) > 0) Then
      Result := ''
    Else
      Result := lstBcoFor[cbxBcoFor.ItemIndex];
  End
  Else
    Result := '';
end;

function TfrmGerAutCtaPagar.fGetForPix: String;
begin
  If cbxBcoFor.ItemIndex > -1 Then
  Begin
    If (Pos('PIX', cbxBcoFor.Text) <= 0) Then
      Result := ''
    Else
      Result := lstBcoFor[cbxBcoFor.ItemIndex];
  End
  Else
    Result := '';
end;

end.

