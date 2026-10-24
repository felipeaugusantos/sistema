unit untAltPrecoFornecedorTabPrd;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, Menus, StrUtils, DB, AppEvnts,
  QColorLabel, UniDataSetProvider, UniClientDataSet, untFuncoesSimples, ComboBoxFocus,
  BitBtnLockedIncrem, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, Vcl.CheckLst, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxVGrid,
  cxInplaceContainer, cxDBVGrid, cxClasses, cxTextEdit, cxCurrencyEdit, untSalvaDadosInterface;

type
  TfrmAltPrecoFornecedorTabPrd = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlDadosAlt: TPanel;
    lblCamAlt: TLabel;
    edtCamAlt: TEditFocus;
    pnlBotoesEnt: TPanel;
    pgbProgresso: TProgressBar;
    cdsAltGlo: TUniClientDataSet;
    cdsAltGloITE_DESCAM: TStringField;
    cdsAltGloITE_VALCAM: TStringField;
    cdsAltGloITE_MASCAM: TStringField;
    cdsAltGloITE_NOMCAM: TStringField;
    cdsAltGloITE_DESABR: TStringField;
    cdsAltGloITE_LIMCAM: TIntegerField;
    cdsAltGloITE_TIPCAM: TStringField;
    cdsAltGloITE_ALTERA: TStringField;
    dtsAltGlo: TDataSource;
    dspIteGlo: TUniDataSetProvider;
    cdsIteGlo: TUniClientDataSet;
    btnConfirma: TBitBtnLocked;
    btnConfirmaAlt: TBitBtnLocked;
    btnCancelaAlt: TBitBtnLocked;
    btnSairAlt: TBitBtnLocked;
    pnlEmpresas: TPanel;
    lbl2: TLabel;
    cklEmpresas: TCheckListBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ColorLabel1: TColorLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesGru: TEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    edtClaIPI: TEditFocus;
    edtStatus: TEditFocus;
    cmbCampos: TComboBoxFocus;
    cmbOperad: TComboBoxFocus;
    edtValDig: TEditFocus;
    grpDadosNE: TGroupBox;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    lblForNot: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkNotEnt: TCheckBox;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    edtTabPre: TEditFocus;
    edtNomTab: TEditFocus;
    pnlTipoAlteracao: TPanel;
    grbGirGer: TGroupBox;
    chkGerA: TCheckBox;
    chkGerB: TCheckBox;
    chkGerC: TCheckBox;
    grbGirFor: TGroupBox;
    chkForA: TCheckBox;
    chkForB: TCheckBox;
    chkForC: TCheckBox;
    cdsAltGloPOR_TABELA: TStringField;
    cdsAltGloITE_TABELA: TStringField;
    cxvAlteracao: TcxVerticalGrid;
    cxvgPrecoCompra: TcxCategoryRow;
    cxerPRECOM: TcxEditorRow;
    cxerDESF01: TcxEditorRow;
    cxerDESF02: TcxEditorRow;
    cxerDESF03: TcxEditorRow;
    cxerDESF04: TcxEditorRow;
    cxerDESF05: TcxEditorRow;
    cxerDESF06: TcxEditorRow;
    cxvgPrecoDeCusto: TcxCategoryRow;
    cxerSUBFED: TcxEditorRow;
    cxerIPIENT: TcxEditorRow;
    cxerFREENT: TcxEditorRow;
    cxerVALFRE: TcxEditorRow;
    cxerACRFIN: TcxEditorRow;
    cxerDESADB: TcxEditorRow;
    cxvCustoReal: TcxCategoryRow;
    cxerIMPFED: TcxEditorRow;
    cxvCustoRealTab1: TcxCategoryRow;
    cxerOUTVAL5: TcxEditorRow;
    cxerICMSAI7: TcxEditorRow;
    cxerDESOPE1: TcxEditorRow;
    cxvAlteracaoPRDGRU: TcxEditorRow;
    cxvAlteracaoABFPIS: TcxEditorRow;
    cxvAlteracaoABFCOF: TcxEditorRow;
    cxvAlteracaoCategoryRow1: TcxCategoryRow;
    cxvCustoRealTab2: TcxCategoryRow;
    cxerDESOPE2: TcxEditorRow;
    cxerICMSAI2: TcxEditorRow;
    cxerOUTVAL6: TcxEditorRow;
    cxvCustoRealTab3: TcxCategoryRow;
    cxerDESOPE4: TcxEditorRow;
    cxerICMSAI3: TcxEditorRow;
    cxerOUTVAL1: TcxEditorRow;
    cxvCustoRealTab4: TcxCategoryRow;
    cxerDESOPE5: TcxEditorRow;
    cxerICMSAI6: TcxEditorRow;
    cxerOUTVAL2: TcxEditorRow;
    cxvCustoRealTab5: TcxCategoryRow;
    cxerDESOPE7: TcxEditorRow;
    cxerICMSAI1: TcxEditorRow;
    cxerOUTVAL7: TcxEditorRow;
    cxvCustoRealTab6: TcxCategoryRow;
    cxerDESOPE3: TcxEditorRow;
    cxerICMSAI4: TcxEditorRow;
    cxerOUTVAL4: TcxEditorRow;
    cxvCustoRealTab7: TcxCategoryRow;
    cxerDESOPE6: TcxEditorRow;
    cxerICMSAI5: TcxEditorRow;
    cxerOUTVAL3: TcxEditorRow;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxerPREVE1: TcxEditorRow;
    cxerPREVE2: TcxEditorRow;
    cxerPREVE3: TcxEditorRow;
    cxerPREVE4: TcxEditorRow;
    cxerPREVE5: TcxEditorRow;
    cxerPREVE6: TcxEditorRow;
    cxerPREVE7: TcxEditorRow;
    cxerMARBR1: TcxEditorRow;
    cxerMARBR2: TcxEditorRow;
    cxerMARBR3: TcxEditorRow;
    cxerMARBR4: TcxEditorRow;
    cxerMARBR5: TcxEditorRow;
    cxerMARBR6: TcxEditorRow;
    cxerMARBR7: TcxEditorRow;
    rdgAtiCom: TRadioGroup;
    rdgCusAtivo: TRadioGroup;
    rdgTipAltFor: TRadioGroup;
    lblContadorLocal: TLabel;
    procedure btnSairAltClick(Sender: TObject);
    procedure dbgTiposAltKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaAltClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCamAltKeyPress(Sender: TObject; var Key: Char);
    procedure dbgTiposAltDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtClaIPIKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

    procedure cmbCamposChange(Sender: TObject);
    procedure chkNotEntClick(Sender: TObject);
    procedure edtForNotExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure edtTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure cxvAlteracaoKeyPress(Sender: TObject; var Key: Char);
    procedure cxvAlteracaoABFCOFEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvAlteracaoABFPISEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvAlteracaoPRDGRUEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxerDESF01EditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxerPRECOMEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure rdgTipAltForClick(Sender: TObject);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    qryConAbf: TUniQuery;
    qryAbfIcm: TUniQuery;

    intDecUni: Integer;

    qryConMar: TUniQuery;
    qryConGru: TUniQuery;
    CampoErro: TCampoGlobal;
    arrCamposGlobal: Array Of TCampoGlobal;
    arrCamposTabela: Array Of TCampoGlobal;
    arrCamposGrid: Array Of TCampoGlobal;
    arrCamposExp: Array Of TCampoExp;
//    objSalInt: TSalvaInterface;

    strUsaPreMat: String;

    blnTabPrd,
    blnValPer: Boolean;
//    blnPreMat: Boolean;

    qryGenIte: TUniQuery;

    procedure pCarregaEmpresasAtivacao;
    Function fRetEmpresasAtivaco: String;
    procedure pAtualizaCdsIteGlo;

    Function fUsaPrecoMatriz(strCodEmp: String): Boolean;
    procedure plimpValuesCdsAltGlo(ApenasCampoVendaEMargem: Boolean = False);


    procedure pLimparTela;

    procedure pHabilitaNotaEntrada(blnHabilitar: Boolean = False);
    procedure pCodForKeyPress;
    procedure pCodGprKeyPress;
    procedure pCodAbfKeyPress;
    procedure pCodAbfPisPress;
    procedure pCodAbfCofPress;
    procedure pCodAbfIPIPress;
    procedure pCodMarcaKeyPress;
    procedure pCodSituacaoKeyPress;
    procedure pCodMontadoraKeyPress;
    procedure pCodUnidadeKeyPress;
    procedure pPrdGruKeyPress;
    procedure pCodGrupoKeyPress(var Key: Char);
//    procedure pCodDepKeyPress;

    procedure pGeraClient;

    Function fSQLCampos: String;
    Function fSQLCamposTabDet: String;

    function fGeraVetorCampos: Boolean;
    Function fCriaTabelaItens: Boolean;
    function fGeraTabelaItens: Boolean;

    procedure pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);

    procedure pAlteraValorTabelaItens(strCodIte: String; Var arrCampos: Array Of TCampoGlobal);

    function fTemCustoItem(strCodIte, strCodEmp, strCodTab: String; intTabPre: Integer;
                           Var fltPreVen, fltMarBru: Double; strAutIncDetCus: String): Boolean;

    procedure pCarregaLinGru;
    procedure pCarregaMarca;
    procedure pCarregaFornecedor;
    procedure pCarregaAbreviacao;

    procedure pAtribuiTabelas;

    procedure pDesmarcaCampo;
    procedure pCarregaInfoAlteracao;
    procedure pGravaValor(blnDesmarcar: Boolean = False);

    procedure pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String; varValor: Variant);

    function fRetornaNumeric(strMascara: String): String;
    function fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String; blRaisedError: Boolean = True): TCampoGlobal;
    function fCampoAlterado(strNomeCampo: String): Boolean;

    function fTamanhoCampo(strCampo: String):Boolean;
    procedure pMontaGrid;
    procedure pCarregaComboExpressao;

    function fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
    function fRetornaNomeCampoExpressao(strDesCam: String): String;
    Procedure pAjustaVisibilidadeMargemBrutaEVenda;


  protected
    procedure pEscapePressed; override;
  public
    { Public declarations }
    strTabFix: String;

    blnRecalculoGeral: Boolean;
    pgbProBar: TProgressBar;
    lblContador: TLabel;

    blnAltPorFator: Boolean;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmAltPrecoFornecedorTabPrd: TfrmAltPrecoFornecedorTabPrd;

implementation

uses
  untConstantes,
  untPesqAux, untAltPrecoFornecedorItensTabPrd, untConsultas, Math,
  untParCalculaPrecoCusto,  untTConfiguracao, untTypesSistema,
  untCalculaComposicaoCusto, untAltPrecoFornecedor;

{$R *.dfm}

function TfrmAltPrecoFornecedorTabPrd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomCam: String;
    strMasCam: String;
    blnNumerico: Boolean;
begin
  strNomCam := '';
  strMasCam := '';
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskLinGru) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
      Begin
        edtDesGru.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaLinGru;
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Linha / Grupo não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodAbr) Then
    Begin
      If fEmptyStr(edtCodAbr.Text) Then
      Begin
        edtDesAbr.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaAbreviacao;

        If qryConAbf.FieldByName('ABF_CODABF').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Abreviação ICMS não está cadastrada!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtRefere) Then
    Begin
    End

    Else If (Sender = edtCodUni) Then
    Begin
      If (Not fEmptyStr(edtCodUni.Text)) And fEmptyStr(fRetNomUnidade(edtCodUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Unidade não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        edtDesMar.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaMarca;
        If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtTabPre) Then
    Begin
      If fEmptyStr(edtTabPre.Text) Then
      Begin
        edtNomTab.Text := 'TODAS';
        edtCodFor.Enabled := True;
      End
      Else
      Begin
        edtNomTab.Text    := fRetNomeTabelaPreco(edtTabPre.Text);
        edtCodFor.Text    := fRetCodFornecedorTabelaPreco(edtTabPre.Text);
        edtNomFor.Text    := fRetNomFornecedor(edtCodFor.Text);
        edtCodFor.Enabled := False;
        If fEmptyStr(edtNomTab.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Tabela de Preço não econtrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDocumento) Then
    Begin

      If chkNotEnt.Checked Then
      Begin
        If fEmptyStr(edtDocumento.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O número do documento deve ser informado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    {***********************************}
    {* VALIDA O OPERADOR DA EXPRESSÃO  *}
    {********************************PZ*}
    Else If (Sender = cmbOperad) Then
    Begin
      If (Not fEmptyStr(cmbCampos.Text)) And (fEmptyStr(cmbOperad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O operador da expressão deve ser informado!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtForNot) Then
    Begin
      If Not fEmptyStr(edtForNot.Text) Then
      Begin

        edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

        If fEmptyStr(edtDesForNot.Text) Then
        Begin
          fMensagem('','Fornecedor não encontrado!', ['&O K']);
          Result := False;
        End;

      End

      Else edtDesForNot.Clear;

    End

    {******************************************}
    {* VALIDAÇÕES DO CAMPO ONDE SÃO DIGITADOS *}
    {* OS VALORES                             *}
    {***************************************MV*}
    Else If (Sender = edtCamAlt) And blnBuscaPorChave Then
    Begin
      {**********************************}
      {* CASO O TIPO FOR PERCETUAL  E O *}
      {* VALOR FOR NEGATIVO ZERA        *}
      {*******************************JB*}
      If (fStrToFloat(edtCamAlt.Text) < 0) And (blnValPer) Then
        edtCamAlt.Text := '0';

      strNomCam   := cdsAltGlo.FieldByName('ITE_NOMCAM').AsString;
      strMasCam   := cdsAltGlo.FieldByName('ITE_MASCAM').AsString;
      blnNumerico := Pos('NUMERIC', cdsAltGlo.FieldByName('ITE_TIPCAM').AsString) > 0;

      If (strNomCam = 'TFO_PRDGRU') Then
      begin
        If edtCamAlt.text <> '' Then
        begin
          If fRetNomeGrupoProduto(edtCamAlt.text) = '' then
          Begin
            fMensagem('','Grupo de Produto Inválido!',['&OK']);
            Result := False;
            edtCamAlt.text := '';
          End;

        End;
      End

      Else If (strNomCam = 'ITE_ABFPIS') Then
      begin
        If edtCamAlt.text <> '' Then
        begin
          edtCamAlt.Text := fStrZero(edtCamAlt.Text, 3);
          If fRetDesAbfPis(edtCamAlt.text) = '' then
          Begin
            fMensagem('','Abreviação de PIS Inválida!',['&OK']);
            Result := False;
            edtCamAlt.text := '';
          End;

        End;
      End

      Else If (strNomCam = 'ITE_ABFCOF') Then
      begin
        If edtCamAlt.text <> '' Then
        begin
          edtCamAlt.Text := fStrZero(edtCamAlt.Text, 3);
          If fRetDesAbfCof(edtCamAlt.text) = '' then
          Begin
            fMensagem('','Abreviação de COFINS inválida!',['&OK']);
            Result := False;
            edtCamAlt.text := '';
          End;

        End;
      End


      Else


      If (strNomCam = 'ITE_PRECOM') Then
      Begin

        If (Not fEmptyStr(edtCamAlt.Text)) Then
        Begin
          edtCamAlt.Text := FormatFloat(strMasCam, fStrToFloat(edtCamAlt.Text));

          If blnAltPorFator Then
          Begin
            If (Int(fStrToFloat(edtCamAlt.Text)) > 1) Then
            Begin
              Result := False;
            End;
          End;

        End;

      End

      Else If (Not fEmptyStr(edtCamAlt.Text)) And
              (Not fEmptyStr(strMasCam))      Then
      Begin

        edtCamAlt.Text := FormatFloat(strMasCam, fStrToFloat(edtCamAlt.Text));

      End;

      If Result Then
      Begin

        If Not fEmptyStr(edtCamAlt.Text) Then
        Begin

          If (Not fEmptyStr(strMasCam)) And blnNumerico Then
             edtCamAlt.Text := FormatFloat(strMasCam, fStrToFloat(edtCamAlt.Text));

          If blnNumerico And (fStrToFloat(edtCamAlt.Text) < 0) Then
          Begin
            fMensagem('','Informe um valor maior ou igual à zero !',['&OK']);
            Result := False;
          End;

        End
        Else
        Begin
          Result := False;
        End;

      End

    End

    Else If Sender = edtStatus Then
    Begin

      If Pos(edtStatus.Text, 'S_N_T_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Ativo deve ser S, N ou T!', ['&O k']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaAbreviacao;
begin
  pPesquisaAbfIcm(qryAbfIcm, qryConAbf, edtCodAbr.Text);
  With qryConAbf Do
  Begin
    edtDesAbr.Text := FieldByName('ABF_DESABF').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlBotoesEnt) Or
     (ActiveControl.Parent = pnlDadosAlt)  Then
  Begin
    btnCancelaAlt.Click;
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pGeraClient;
  Var
    intContador: Integer;
begin
  If cdsAltGlo.Active Then
    cdsAltGlo.EmptyDataSet;

  cdsAltGlo.Open;
  pSetaClient(cdsAltGlo);

  With cdsAltGlo Do
  For intContador := 0 To Length(arrCamposGlobal) -1 Do
  Begin
    Append;
    FieldByName('ITE_DESCAM').AsString  := arrCamposGlobal[intContador].strDesCam;
    FieldByName('ITE_VALCAM').Value     := arrCamposGlobal[intContador].varValCam;
    FieldByName('ITE_MASCAM').AsString  := arrCamposGlobal[intContador].strMasCam;
    FieldByName('ITE_NOMCAM').AsString  := arrCamposGlobal[intContador].strNomCam;
    FieldByName('ITE_DESABR').AsString  := arrCamposGlobal[intContador].strDesAbr;
    FieldByName('ITE_LIMCAM').AsInteger := arrCamposGlobal[intContador].intLimCam;
    FieldByName('ITE_TIPCAM').AsString  := arrCamposGlobal[intContador].strTipCam;
    If arrCamposGlobal[intContador].strPorTabela <> 'S' Then
      arrCamposGlobal[intContador].strPorTabela := 'N';
    FieldByName('POR_TABELA').AsString  := arrCamposGlobal[intContador].strPorTabela;
    FieldByName('ITE_ALTERA').AsString  := 'N';
    FieldByName('ITE_TABELA').AsString := arrCamposGlobal[intContador].strTabela;
    Post;
  End;

  cdsAltGlo.First;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaLinGru;
begin
  pPesquisaLinGru(qryConGru, qryConGru, mskLinGru.Text);
  With qryConGru Do
  Begin
    edtDesGru.Text := FieldByName('GRU_DESGRU').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaMarca;
begin
  pPesquisaCadMar(qryConMar, qryConMar, edtCodMar.Text);
  With qryConMar Do
  Begin
    edtDesMar.Text := FieldByName('MAR_DESMAR').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pAtribuiTabelas;
begin
  qryAbfIcm := fCriaQuery(Self);

  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConAbf := qryAbfIcm;
end;

procedure TfrmAltPrecoFornecedorTabPrd.btnSairAltClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoFornecedorTabPrd.dbgTiposAltKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    pSetFocus(mskLinGru);
  End
  Else If (Key = VK_Return) Then
  Begin
    If cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'S' Then
      pDesmarcaCampo
    Else
      pCarregaInfoAlteracao;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pGravaValor(blnDesmarcar: Boolean = False);
begin
  With cdsAltGlo Do
  Begin
    Edit;
    FieldByName('ITE_VALCAM').AsString := edtCamAlt.Text;

    If fEmptyStr(edtCamAlt.Text) And
       ((Pos('CHAR', FieldByName('ITE_TIPCAM').AsString) <= 0) Or blnDesmarcar) Then
      FieldByName('ITE_ALTERA').AsString := 'N'
    Else
      FieldByName('ITE_ALTERA').AsString := 'S';

    Post;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.btnConfirmaAltClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtCamAlt, True) Then
  Begin
    {*******************************************}
    {* VERIFICA O TAMANHO DO CAMPO PARA PODER  *}
    {* GRAVAR CORRETAMENTO.                    *}
    {****************************************AC*}
    If (Not fTamanhoCampo(edtCamAlt.Text)) Then
    Begin
      pSetFocus(edtCamAlt);
      Exit;
    End;

    pGravaValor;
    lblCamAlt.Caption := '';
    edtCamAlt.Clear;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaInfoAlteracao;
begin
  With cdsAltGlo Do
  Begin

    lblCamAlt.Caption := FieldByName('ITE_DESCAM').AsString;
    edtCamAlt.Clear;

    {**********************************************}
    {* VERIFICAR SE O TIPO DE VALOR EH PERCENTUAL *}
    {*******************************************JB*}
    blnValPer := LeftStr(FieldByName('ITE_DESCAM').AsString, 1) = '%';

    If (Not fEmptyStr(FieldByName('ITE_MASCAM').AsString)) Or (FieldByName('ITE_TIPCAM').AsString = 'INTEGER') Then
      edtCamAlt.TipoTexto := ttNumerico
    Else
      edtCamAlt.TipoTexto := ttAlfanumerico;

    edtCamAlt.MaxLength := FieldByName('ITE_LIMCAM').AsInteger;
    pSetFocus(edtCamAlt);

  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  objSalInt.fSalvaDados('', Self.Name, strLoginUsuarioLogado, True);
  FreeAndNil(qryGenIte);
  FreeAndNil(qryAbfIcm);

  FreeAndNil(cdsAltGlo);
  FreeAndNil(cdsIteGlo);
end;

procedure TfrmAltPrecoFornecedorTabPrd.pDesmarcaCampo;
begin
  pGravaValor(True); //Grava em branco.
end;

procedure TfrmAltPrecoFornecedorTabPrd.btnCancelaAltClick(Sender: TObject);
begin
  inherited;
  lblCamAlt.Caption := '';
  edtCamAlt.Clear;
  pSetFocus(cxvAlteracao);
end;

procedure TfrmAltPrecoFornecedorTabPrd.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  Try
    blnConfirma := False;

    Screen.Cursor := crHourGlass;

    btnConfirmaAlt.Enabled := False;
    btnConfirma.Enabled    := False;
    btnCancelaAlt.Enabled  := False;
    btnSairAlt.Enabled     := False;

    If cdsIteGlo.Active Then
      cdsIteGlo.EmptyDataSet;
    pAtualizaCdsIteGlo;

    If (Not fGeraVetorCampos) Then
    Begin
      fMensagem('', 'É necessário marcar pelo menos um campo para alteração!', ['&O k']);
      btnConfirmaAlt.Enabled := True;
      btnConfirma.Enabled    := True;
      btnCancelaAlt.Enabled  := True;
      btnSairAlt.Enabled     := True;
      Screen.Cursor          := crDefault;
      Exit;
    End;

    If Not fCriaTabelaItens Then
      Exit;

    If fGeraTabelaItens Then
    Begin

      Try

        pCriarFormularios(TfrmAltPrecoFornecedorItensTabPrd, frmAltPrecoFornecedorItensTabPrd);
        frmAltPrecoFornecedorItensTabPrd.intOpcAlt := rdgTipAltFor.ItemIndex;
        frmAltPrecoFornecedorItensTabPrd.dtsItens.DataSet := cdsIteGlo;
        frmAltPrecoFornecedorItensTabPrd.pCopiaCamposGrid(arrCamposGrid);
        frmAltPrecoFornecedorItensTabPrd.blnTabPrD := blnTabPrD;

        If blnRecalculoGeral Then
        Begin
          frmAltPrecoFornecedorItensTabPrd.pgbProBar   := pgbProBar;
          frmAltPrecoFornecedorItensTabPrd.lblContador := lblContador;
          frmAltPrecoFornecedorItensTabPrd.pAtualizaTabela;

          blnConfirma := frmAltPrecoFornecedorItensTabPrd.fConfirma;
        End Else
        Begin
          frmAltPrecoFornecedorItensTabPrd.showModal;
          blnConfirma := frmAltPrecoFornecedorItensTabPrd.blnConfirma;
        End;

      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmAltPrecoGlobal.btnConfirmaClick]');
        End;
      End;

      pFreeAndNil(frmAltPrecoFornecedorItensTabPrd);

    End;

    btnConfirmaAlt.Enabled := True;
    btnConfirma.Enabled    := True;
    btnCancelaAlt.Enabled  := True;
    btnSairAlt.Enabled     := True;
    Screen.Cursor          := crDefault;

    If blnConfirma Then
      pLimparTela;
  Except
    on e:Exception do
    Begin
      pMensagensErro(e.message, '[TfrmAltPrecoFornecedorTabPrd.btnConfirmaClick]');
      btnConfirmaAlt.Enabled := True;
      btnConfirma.Enabled    := True;
      btnCancelaAlt.Enabled  := True;
      btnSairAlt.Enabled     := True;
      Screen.Cursor          := crDefault;
    End;
  End;
end;

function TfrmAltPrecoFornecedorTabPrd.fTemCustoItem(strCodIte, strCodEmp, strCodTab: String; intTabPre: Integer;
                                              Var fltPreVen, fltMarBru: Double; strAutIncDetCus: String): Boolean;
  Var
    qryIteger: TUniquery;
Begin
  fltPreVen := 0;
  fltMarBru := 0;
  qryIteger := fCriaQuery(Self);

  With qryIteger, SQL Do
  Begin
    Add('SELECT');
    Add('  IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) ITE_CNVCUS, ');
    Add('  ITE_PREVE' + IntToStr(intTabPre) + ',');
    Add('  ITE_MARBR' + IntToStr(intTabPre));

    Add('FROM');
    Add('  ITEGER');
    Add('  INNER JOIN ITEFOR F ON F.ITE_CODITE = ITEGER.ITE_CODITE AND F.ITE_CODTAB =  ITE_TABPR' + IntToStr(intTabPre) );
    Add('WHERE');
    Add('  ITEGER.ITE_CODITE = :CODITE AND ');
    Add('  ITEGER.ITE_CODEMP = :CODEMP AND ');
    Add('  ITEGER.ITE_TABPR' + IntToStr(intTabPre) + ' = :CODTAB ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODTAB').AsString := strCodTab;

    Open;

    Result := Not IsEmpty;

    If Not IsEmpty Then
    Begin
      fltPreVen := qryIteger.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat;
      fltMarBru := FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat;
    End
    Else
    Begin
      qryIteger.SQl.Clear;
      qryIteger.SQL.Add('SELECT DETCUS.*, ');
      qryIteger.SQL.Add('       IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) ITE_CNVCUS ');
      qryIteger.SQL.Add('       FROM DETCUS ');
      qryIteger.SQL.Add(' INNER JOIN TABDET ON TABDET.AUTOINCREM = DET_SEQDET');
      qryIteger.SQL.Add('       INNER JOIN ITEFOR F ON F.AUTOINCREM = TABDET.ITE_SEQGER');
      qryIteger.SQL.Add(' WHERE DET_SEQDET = "'+strAutIncDetCus+'" AND DET_TABELA = ' + intTabPre.ToString);
      qryIteger.Open;

      If Not IsEmpty Then
      Begin
        fltPreVen := FieldByName('DET_PREVEN').AsFloat / FieldByName('ITE_CNVCUS').AsFloat;
        fltMarBru := FieldByName('DET_MARBRU').AsFloat;
      End;
    End;
    Close;
  End;

  FreeAndNil(qryIteger)
End;

Function TfrmAltPrecoFornecedorTabPrd.fSQLCamposTabDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + ' A.ITE_CODEMP, ';

  strSQL := strSQL + ' A.ITE_CODABF, ';

  If fCfgSis('TPABPC') = '2' Then
  Begin
    strSQL := strSQL + ' A.ITE_ABFIPI, ';
    strSQL := strSQL + ' A.ITE_ABFCOF, ';
    strSQL := strSQL + ' A.ITE_ABFPIS, ';
  End;

  strSQL := strSQL + ' A.ITE_DESF01, ';
  strSQL := strSQL + ' A.ITE_DESF02, ';
  strSQL := strSQL + ' A.ITE_DESF03, ';
  strSQL := strSQL + ' A.ITE_DESF04, ';
  strSQL := strSQL + ' A.ITE_DESF05, ';
  strSQL := strSQL + ' A.ITE_DESF06, ';
  strSQL := strSQL + ' A.ITE_PRECOM, ';
  strSQL := strSQL + ' A.ITE_ICMENT, ';
  strSQL := strSQL + ' A.ITE_SUBFED, ';
  strSQL := strSQL + ' A.ITE_IPIENT, ';
  strSQL := strSQL + ' A.ITE_FREENT, ';
  strSQL := strSQL + ' A.ITE_VALFRE, ';
  strSQL := strSQL + ' A.ITE_ACRFIN, ';
  strSQL := strSQL + ' A.ITE_SUBSTI, ';
  strSQL := strSQL + ' A.ITE_DESADB, ';
  strSQL := strSQL + ' A.ITE_PRECUS, ';
  strSQL := strSQL + ' A.ITE_OUTVAL, ';
  strSQL := strSQL + ' A.ITE_ICMSAI, ';
  strSQL := strSQL + ' A.ITE_IMPFED, ';
  strSQL := strSQL + ' A.ITE_DESOPE, ';

  strSQL := strSQL + ' A.ITE_MARBRU, ';
  strSQL := strSQL + ' A.ITE_COMTBL, ';
  strSQL := strSQL + ' A.ITE_PREVEN, ';
  strSQL := strSQL + ' A.ITE_PREREV, ';
  strSQL := strSQL + ' A.ITE_MARFEC, ';
  strSQL := strSQL + ' A.ITE_TCIFCU, ';
  strSQL := strSQL + ' A.ITE_TSCUST, ';
  strSQL := strSQL + ' A.ITE_DEPICO, ';
  strSQL := strSQL + ' A.ITE_DEICMS, ';
  strSQL := strSQL + ' A.ITE_FATREG, ';
  strSQL := strSQL + ' A.ITE_EXCIPI, ';
  strSQL := strSQL + ' A.ITE_PREDOL  ';

  strSQL := strSQL + ' FROM TABDET A WHERE FALSE ';

  Result := strSQL;
End;

Function TfrmAltPrecoFornecedorTabPrd.fSQLCampos: String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intIndice: Integer;

    procedure pMontaCampoDetCus(ACampo: String; ATabela: String; AAlias: String = '');
    Begin
      If AAlias = '' Then
        AAlias :=  ACampo;
      If blnTabPrd Then
      Begin
         If ACampo = 'OUTVAL' Then
         Begin

           strSQL := strSQL + ' IFNULL(DC'+ATabela+'.DET_'+ACampo+', A.ITE_'+ACampo+')/IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) AS ITE_' + AAlias + ATabela + ',';
           strSQL := strSQL + ' IFNULL(DC'+ATabela+'.DET_'+ACampo+', A.ITE_'+ACampo+')/IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) AS ITE_' + AAlias + ATabela + '_NOV,';
         End
         Else
         begin
           strSQL := strSQL + ' IFNULL(DC'+ATabela+'.DET_'+ACampo+', A.ITE_'+ACampo+') AS ITE_' + AAlias + ATabela + ',';
           strSQL := strSQL + ' IFNULL(DC'+ATabela+'.DET_'+ACampo+', A.ITE_'+ACampo+') AS ITE_' + AAlias + ATabela + '_NOV,';
         End;
      End
    End;

Begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + '  IF(A.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)  + ', 0, 1) AS ORDEMP, ';
  strSQL := strSQL + '  A.ITE_CODEMP, ';
  strSQL := strSQL + '  A.AUTOINCREM AS INCDET, ';


  strSQL := strSQL + '  A.ITE_CODABF, ';
  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) ITE_CNVCUS, ';


  strSQL := strSQL + '  0.0000 AS ITE_COMLIQ, ';
  strSQL := strSQL + '  0.0000 AS ITE_COMLIQ_NOV, ';
  strSQL := strSQL + '  0.0000 AS ITE_CUSREA, ';
  strSQL := strSQL + '  0.0000 AS ITE_CUSREA_NOV, ';


  strSQL := strSQL + '   F.TFO_PRDGRU, ';
  strSQL := strSQL + '   F.TFO_PRDGRU AS TFO_PRDGRU_NOV, ';

  strSQL := strSQL + '  A.ITE_ABFPIS AS ITE_ABFPIS, ';
  strSQL := strSQL + '  A.ITE_ABFPIS AS ITE_ABFPIS_NOV, ';

  strSQL := strSQL + '  A.ITE_ABFCOF AS ITE_ABFCOF, ';
  strSQL := strSQL + '  A.ITE_ABFCOF AS ITE_ABFCOF_NOV, ';

  For intIndice := 1 To 7 Do
  Begin

    strSQL := strSQL + '  A.ITE_SUBSTI AS ITE_SUBSTI' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_SUBSTI AS ITE_SUBSTI' + IntToStr(intIndice) + '_NOV, ';


    pMontaCampoDetCus('ICMSAI', IntToStr(intIndice));

    strSQL := strSQL + '  A.ITE_ICMENT AS ITE_ICMENT' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_ICMENT AS ITE_ICMENT' + IntToStr(intIndice) + '_NOV, ';

    strSQL := strSQL + '  A.ITE_IMPFED AS ITE_IMPFED' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_IMPFED AS ITE_IMPFED' + IntToStr(intIndice) + '_NOV, ';

    strSQL := strSQL + '  A.ITE_SUBFED AS ITE_SUBFED' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_SUBFED AS ITE_SUBFED' + IntToStr(intIndice) + '_NOV, ';

    pMontaCampoDetCus('DESOPE', IntToStr(intIndice));

    pMontaCampoDetCus('OUTVAL', IntToStr(intIndice));

    strSQL := strSQL + '  A.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) AS ITE_PRECUS' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) AS ITE_PRECUS' + IntToStr(intIndice) + '_NOV, ';

    strSQL := strSQL + '  A.ITE_IPIENT AS ITE_IPIENT' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_IPIENT AS ITE_IPIENT' + IntToStr(intIndice) + '_NOV, ';

    strSQL := strSQL + '  0.0000 AS ITE_CUSREA' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  0.0000 AS ITE_CUSREA' + IntToStr(intIndice) + '_NOV, ';

    pMontaCampoDetCus('PREVEN',  IntToStr(intIndice), 'PREVE');
    pMontaCampoDetCus('MARBRU',  IntToStr(intIndice), 'MARBR');

    strSQL := strSQL + '  "N" AS UPDATE_ITEGER' + IntToStr(intIndice) + ', ';
  End;

 (*
  For intIndice := 0 To qryGen.Fields.Count - 1 Do
    If Pos(qryGen.Fields[intIndice].FieldName, 'ITE_CODFOR-ITE_CODITE-AUTOINCREM-ITE_CODEMP-ITE_CODITF') <= 0 Then
    Begin
      strSQL := strSQL + '  F.' + qryGen.Fields[intIndice].FieldName + ', ';
      strSQL := strSQL + '  F.' + qryGen.Fields[intIndice].FieldName + ' AS "' + qryGen.Fields[intIndice].FieldName + '_NOV", ';
    End; *)

  qryGen.Close;
  qryGen.SQL.Text := fSQLCamposTabDet;
  qryGen.Open;

  For intIndice := 0 To qryGen.Fields.Count - 1 Do
    If Pos(qryGen.Fields[intIndice].FieldName, 'ITE_CODFOR-ITE_CODITE-AUTOINCREM-ITE_CODEMP-ITE_CODITF') <= 0 Then
    Begin
      If Pos(qryGen.Fields[intIndice].FieldName, 'ITE_PRECOM_ITE_VALFRE_ITE_OUTVAL') > 0 Then
      Begin
        strSQL := strSQL + '  A.' + qryGen.Fields[intIndice].FieldName + ' / IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) AS "' + qryGen.Fields[intIndice].FieldName + '", ';
        strSQL := strSQL + '  A.' + qryGen.Fields[intIndice].FieldName + ' / IF(IFNULL(F.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F.ITE_CNVCUS, 1)) AS "' + qryGen.Fields[intIndice].FieldName + '_NOV", ';
      End
      Else
      Begin
        strSQL := strSQL + '  A.' + qryGen.Fields[intIndice].FieldName + ', ';
        strSQL := strSQL + '  A.' + qryGen.Fields[intIndice].FieldName + ' AS "' + qryGen.Fields[intIndice].FieldName + '_NOV", ';
      End;
    End;


  strSQL := strSQL + '  F.ITE_CODFOR, ';
  strSQL := strSQL + '  F.ITE_CODTAB ';

  Result := strSQL;

  FreeAndNil(qryGen);
End;

Function TfrmAltPrecoFornecedorTabPrd.fCriaTabelaItens: Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    strSQL := strSQL + fSQLCampos;

    strSQL := strSQL + ' ,"M" AS ITE_MARDES                 ';

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADITE I ';

    strSQL := strSQL + ' INNER JOIN ITEFOR F ON I.ITE_CODITE = F.ITE_CODITE ';

    strSQL := strSQL + ' INNER JOIN TABDET A ON A.ITE_CODTAB = F.ITE_CODTAB ';
    strSQL := strSQL + '                    AND A.ITE_CODITE = F.ITE_CODITE ';
    strSQL := strSQL + '                    AND A.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + ' LEFT  JOIN DETCUS DC1 ON DC1.DET_SEQDET = A.AUTOINCREM  AND DC1.DET_TABELA = 1';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC2 ON DC2.DET_SEQDET = A.AUTOINCREM  AND DC2.DET_TABELA = 2';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC3 ON DC3.DET_SEQDET = A.AUTOINCREM  AND DC3.DET_TABELA = 3';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC4 ON DC4.DET_SEQDET = A.AUTOINCREM  AND DC4.DET_TABELA = 4';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC5 ON DC5.DET_SEQDET = A.AUTOINCREM  AND DC5.DET_TABELA = 5';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC6 ON DC6.DET_SEQDET = A.AUTOINCREM  AND DC6.DET_TABELA = 6';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC7 ON DC7.DET_SEQDET = A.AUTOINCREM  AND DC7.DET_TABELA = 7';



    strSQL := strSQL + ' WHERE FALSE ';

    qryGen := fCriarQuery(strSQL, Self);
    qryGen.SQL.Text := strSQL;
    qryGen.Open;
    pSetaClient(qryGen);
    dspIteGlo.DataSet := qryGen;

    cdsIteGlo.Close;
    cdsIteGlo.Open;

    cdsIteGlo.IndexFieldNames := 'ITE_CODEMP;ITE_CODITE';

    FreeAndNil(qryGen);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[]');
    End;
  End;
end;

function TfrmAltPrecoFornecedorTabPrd.fRetornaNumeric(strMascara: String): String;
  Var
    intPrecisao: Integer;
begin
  strMascara := AnsiReplaceStr(strMascara, '#', '');
  strMascara := AnsiReplaceStr(strMascara, ',', '');

  intPrecisao := Length(Copy(strMascara, Pos('.', strMascara)+1, Length(strMascara)));

  Result := 'NUMERIC(12, ' + IntToStr(intPrecisao) + ')';
end;

function TfrmAltPrecoFornecedorTabPrd.fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; blRaisedError: Boolean = True): TCampoGlobal;
  Var
    intContador: Integer;
    intTamMat: Integer;
    blnAchou: Boolean;
begin
  blnAchou := False;
  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      blnAchou := True;
      Result := arrCampos[intContador];
      Break;
    End;
    Inc(intContador);
  End;

  If (Not blnAchou)  Then
    If blRaisedError Then
      Raise Exception.Create('Campo ' + strNomeCampo + ' não encontrado!')
    Else
    Begin
      CampoErro.varValCam := 0;
      CampoErro.strNomCam := 'FALHA';

      CampoErro.strDesCam := 'Campo ' + strNomeCampo + ' não encontrado!';
      Result := CampoErro;
    End;
end;


function TfrmAltPrecoFornecedorTabPrd.fCampoAlterado(strNomeCampo: String): Boolean;
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intContador := 0;
  intTamMat := Length(arrCamposTabela);
  Result := false;
  While intContador < intTamMat Do
  Begin
    If arrCamposTabela[intContador].strNomCam = strNomeCampo Then
    Begin
      Result := True;
      Break;
    End;
    Inc(intContador);
  End;

end;


{******************************************}
{* GERA A TABELA TEMPORARIA COM OS CAMPOS *}
{* ALTERADOS E SEUS NOVOS VALORES         *}
{***************************************MV*}
function TfrmAltPrecoFornecedorTabPrd.fGeraTabelaItens: Boolean;
  Var
    strSQL   : String;
    intTamMat: Integer;
    fltFatIpi: Double;
    fltPreVenNov,
    fltPreVen,
    fltMarBru,
    fltMarBruNov: Double;

    fltPrecus,
    fltPrecusNov: Double;
    intContReg,
    intIndice,
    intContador     : Integer;
    strCamAtu       : String;
    varValAtu       : Variant;
    varValorRegAtual: Variant;

    arrRegistroAtual: Array Of TCampoGlobal;

    cpcParams : TParCalculaPrecoCusto;

    blnUtilizarConversorDeMoedas : Boolean;

    procedure pAdicionaCampoGrid(strNomeCampo: String);
      Var
        intTamMatCampos: Integer;
        intContador: Integer;
    begin
      intTamMatCampos := Length(arrCamposGrid);

      For intContador := 0 To intTamMatCampos -1 Do
        If arrCamposGrid[intContador].strNomCam = strNomeCampo Then
          Exit;

      SetLength(arrCamposGrid, intTamMatCampos+1);
      arrCamposGrid[intTamMatCampos] := fCampoPorNome(arrCamposGlobal, strNomeCampo);
    end;

    function fPrecoCompraLiquido(blnNovCam: Boolean): Double;
       Var
         strNovCam: String;
    Begin
      If blnNovCam Then
        strNovCam := '_NOV'
      Else
        strNovCam := '';

      Result := fCalculaPrecoCompraLiq(fCampoPorNome(arrRegistroAtual, 'ITE_PRECOM' + strNovCam).varValCam,
                                       fCampoPorNome(arrRegistroAtual, 'ITE_DESF01' + strNovCam).varValCam,
                                       fCampoPorNome(arrRegistroAtual, 'ITE_DESF02' + strNovCam).varValCam,
                                       fCampoPorNome(arrRegistroAtual, 'ITE_DESF03' + strNovCam).varValCam,
                                       fCampoPorNome(arrRegistroAtual, 'ITE_DESF04' + strNovCam).varValCam,
                                       fCampoPorNome(arrRegistroAtual, 'ITE_DESF05' + strNovCam).varValCam,
                                       fCampoPorNome(arrRegistroAtual, 'ITE_DESF06' + strNovCam).varValCam);
    End;

    function fPrecoCusto(blnNovCam: Boolean;
                         strTabela: String;
                         fltSubst: Double = -1;
                         fltSubFed: Double = -1;
                         fltIcmEnt: Double = -1;
                         fltIpiEnt: Double = -1): Double;
       Var
         strNovCam: String;
    Begin
      If blnNovCam Then
        strNovCam := '_NOV'
      Else
        strNovCam := '';
      If fltSubst = -1 Then
        fltSubst := fCampoPorNome(arrRegistroAtual, 'ITE_SUBSTI' +strTabela+ strNovCam).varValCam;
      If fltSubFed = -1 Then
        fltSubFed := fCampoPorNome(arrRegistroAtual, 'ITE_SUBFED' +strTabela+ strNovCam).varValCam;
      If fltIcmEnt = -1 Then
        fltIcmEnt := fCampoPorNome(arrRegistroAtual, 'ITE_ICMENT' +strTabela+ strNovCam).varValCam;
      If fltIpiEnt = -1 Then
        fltIpiEnt := fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT' +strTabela+ strNovCam).varValCam;

      With cpcParams Do
      Begin
        cpcParams.curPreCom := RoundTo(fCampoPorNome(arrRegistroAtual, 'ITE_PRECOM' + strNovCam).varValCam, -intDecUni);
        curDesF01 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF01' + strNovCam).varValCam;
        curDesF02 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF02' + strNovCam).varValCam;
        curDesF03 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF03' + strNovCam).varValCam;
        curDesF04 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF04' + strNovCam).varValCam;
        curDesF05 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF05' + strNovCam).varValCam;
        curDesF06 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF06' + strNovCam).varValCam;
        curICMSEnt:= fltIcmEnt;
        curIPIEnt := fltIpiEnt;
        curFrete  := fCampoPorNome(arrRegistroAtual, 'ITE_FREENT' + strNovCam).varValCam;
        curAcrFin := fCampoPorNome(arrRegistroAtual, 'ITE_ACRFIN' + strNovCam).varValCam;
        curSubsti := fltSubst;
        curValFre := fCampoPorNome(arrRegistroAtual, 'ITE_VALFRE' + strNovCam).varValCam;
        curDesAdb := fCampoPorNome(arrRegistroAtual, 'ITE_DESADB' + strNovCam).varValCam;
        curSubFed := fltSubFed;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := fCampoPorNome(arrRegistroAtual, 'ITE_TCIFCU' + strNovCam).varValCam;
          curTSCust := fCampoPorNome(arrRegistroAtual, 'ITE_TSCUST' + strNovCam).varValCam;
          curDePiCo := fCampoPorNome(arrRegistroAtual, 'ITE_DEPICO' + strNovCam).varValCam;
          curDeICMS := fCampoPorNome(arrRegistroAtual, 'ITE_DEICMS' + strNovCam).varValCam;
          curFatReg := fCampoPorNome(arrRegistroAtual, 'ITE_FATREG' + strNovCam).varValCam;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;

      blnUtilizarConversorDeMoedas := (fCampoPorNome(arrRegistroAtual, 'ITE_PREDOL').varValCam = 'S');

      Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);
    End;

    function fPrecoCustoReal(blnNovCam: Boolean;
                             AStrTabela: String = '';
                             fltIcmSai: Double = -1;
                             fltImpFed: Double = -1;
                             fltDesOpe: Double = -1;
                             fltOutVal: Double = -1;
                             fltSubst : Double = -1;
                             fltSubFed: Double = -1;
                             fltIcmEnt: Double = -1;
                             fltIpiEnt: Double = -1): Double;
       Var
         strNovCam: String;
    Begin
      If blnNovCam Then
        strNovCam := '_NOV'
      Else
        strNovCam := '';

      If fltIcmSai = -1 then
        fltIcmSai := fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI' +AStrTabela+ strNovCam).varValCam;
      If fltImpFed = -1 then
        fltImpFed := fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED' +AStrTabela+ strNovCam).varValCam;
      If fltDesOpe = -1 then
        fltDesOpe := fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE' +AStrTabela+ strNovCam).varValCam;
      If fltOutVal = -1 then
        fltOutVal := fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL' +AStrTabela+ strNovCam).varValCam;
      If fltSubst = -1 Then
        fltSubst  := fCampoPorNome(arrRegistroAtual, 'ITE_SUBSTI' +AStrTabela+ strNovCam).varValCam;
      If fltSubFed = -1 Then
        fltSubFed := fCampoPorNome(arrRegistroAtual, 'ITE_SUBFED' +AStrTabela+ strNovCam).varValCam;
      If fltIcmEnt = -1 Then
        fltIcmEnt := fCampoPorNome(arrRegistroAtual, 'ITE_ICMENT' +AStrTabela+ strNovCam).varValCam;
      If fltIpiEnt = -1 Then
        fltIpiEnt := fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT' +AStrTabela+ strNovCam).varValCam;


      Result :=  fCalculaCustoReal(fPrecoCusto(blnNovCam, AStrTabela, fltSubst, fltSubFed, fltIcmEnt, fltIpiEnt),
                                   fltIcmSai,
                                   fltImpFed,
                                   fltDesOpe,
                                   fltOutVal);
    End;

    function fPrecoVenda(intOpc, intTabPrc: Integer; fltMarBruIn, fltPreVenIn: Double): Double;
    begin
      Result := fCalculaPrecoVenda(intOpc, fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS'+IntToStr(intTabPrc)+'_NOV').varValCam +
                                           fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                           fltPreVenIn,
                                           fltMarBruIn,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_COMTBL_NOV').varValCam);
    end;


    procedure pNormatizaCustos(intTabPrc: integer; var fltPreVenIn: Double; var fltMarBruIn: Double);
      var
        fltImpFed,
        fltSubFed,
        fltDesOpe,
        fltOutVal,
        fltIcmEnt,
        fltIcmSai,
        fltIpiEnt,

        fltFatIcmSai,
        fltFatOutVal,
        fltFatDesOpe,
        fltFatImpFed,
        fltFatSubFed: Double;
        fltSubsti: Double;
        strTabela: string;
        blnIncidePis: Boolean;
    begin
      strTabela := IntToStr(intTabPrc);


      If blnAltPorFator then
      begin
        fltIpiEnt := fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT'+strTabela+'_NOV').varValCam;
        fltIpiEnt := fltIpiEnt * fltFatIpi;
      End
      Else
        fltIpiEnt := fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT_NOV').varValCam;

      fltFatIcmSai := fCampoPorNome(arrCamposTabela, 'ITE_ICMSAI' + strTabela, False).varValCam;
      If fltFatIcmSai = 0 Then
        fltFatIcmSai := 1;

      fltFatOutVal := fCampoPorNome(arrCamposTabela, 'ITE_OUTVAL' + strTabela, False).varValCam;
      If fltFatOutVal = 0 Then
        fltFatOutVal := 1;

      fltFatDesOpe := fCampoPorNome(arrCamposTabela, 'ITE_DESOPE' + strTabela, False).varValCam;
      If fltFatDesOpe = 0 Then
        fltFatDesOpe := 1;

      fltFatImpFed := fCampoPorNome(arrCamposTabela, 'ITE_IMPFED' + strTabela, False).varValCam;
      If fltFatImpFed = 0 Then
        fltFatImpFed := 1;

      fltFatSubFed := fCampoPorNome(arrCamposTabela, 'ITE_SUBFED' + strTabela, False).varValCam;
      If fltFatSubFed = 0 Then
        fltFatSubFed := 1;

      blnIncidePis := fIncidePis(qryGenIte.FieldByName('ITE_CODITE').AsString);
      CalculaComposicaoCusto := TCalculaComposicaoCusto.fRetCustoTabDet(fltIpiEnt,
                                                                        blnIncidePis,
                                                                        qryGenIte.FieldByName('ITE_CODFOR').AsString,
                                                                        qryGenIte.FieldByName('ITE_CODABF').AsString,
                                                                        qryGenIte.FieldByName('INCDET').AsString,
                                                                        strTabela,
                                                                        qryGenIte.FieldByName('ITE_CODEMP').AsString) ;

      Try
        fltOutVal := CalculaComposicaoCusto.OutVal/qryGenIte.FieldByName('ITE_CNVCUS').AsFloat;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_OUTVAL' + strTabela, fltOutVal);

        If fCampoAlterado('ITE_OUTVAL' + strTabela) Then
        Begin
          If blnAltPorFator then
            fltOutVal := fltOutVal * fltFatOutVal
          Else
            fltOutVal := fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL' + strTabela +'_NOV').varValCam;
        End;


        If fCampoAlterado('ITE_PREVE' + strTabela) Then
        Begin
          If blnAltPorFator then
            fltPreVenIn :=  fltPreVenIn * fCampoPorNome(arrCamposTabela, 'ITE_PREVE' + strTabela, False).varValCam
          Else
            fltPreVenIn :=  fCampoPorNome(arrCamposTabela, 'ITE_PREVE' + strTabela, False).varValCam;

        End;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + strTabela, fltPreVenIn);


        If fCampoAlterado('ITE_MARBR' + strTabela) Then
        Begin
          If blnAltPorFator then
            fltMarBruIn :=  fltMarBruIn * fCampoPorNome(arrCamposTabela, 'ITE_MARBR' + strTabela, False).varValCam
          Else
            fltMarBruIn :=  fCampoPorNome(arrCamposTabela, 'ITE_MARBR' + strTabela, False).varValCam;
        End;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + strTabela, fltMarBruIn);

        fltDesOpe := CalculaComposicaoCusto.DesOpe;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_DESOPE' + strTabela, fltDesOpe);
        If fCampoAlterado('ITE_DESOPE' + strTabela) Then
        Begin
          If blnAltPorFator then
            fltDesOpe := fltDesOpe * fltFatDesOpe
          Else
            fltDesOpe := fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE' + strTabela + '_NOV').varValCam;

        End;

        fltIcmSai := CalculaComposicaoCusto.AliquotaICMSSai;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMSAI' + strTabela, fltIcmSai);
        If fCampoAlterado('ITE_ICMSAI' + strTabela) Then
        Begin
          If blnAltPorFator then
            fltIcmSai := fltIcmSai * fltFatIcmSai
          Else
            fltIcmSai := fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI' + strTabela + '_NOV').varValCam;
        End;

        If CalculaComposicaoCusto.BlnSemST Then
        Begin
          fltIcmEnt := CalculaComposicaoCusto.AliquotaICMSEnt;
          fltSubsti := 0;

        End
        Else
        Begin
          fltIcmSai :=  0;
          fltIcmEnt :=  0;
          fltSubsti := CalculaComposicaoCusto.AliquotaST;
        End;

        fltImpFed := CalculaComposicaoCusto.ImpFed;
        If fCampoAlterado('ITE_IMPFED') Then
        Begin
          If blnAltPorFator then
            fltImpFed := fltImpFed * fltFatImpFed
          Else
            fltImpFed := fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED_NOV').varValCam;

        End;

        fltSubFed := CalculaComposicaoCusto.SubFed;
        If fCampoAlterado('ITE_SUBFED') Then
        Begin
          If blnAltPorFator then
            fltSubFed := fltSubFed * fltFatSubFed
          Else
            fltSubFed := fCampoPorNome(arrRegistroAtual, 'ITE_SUBFED_NOV').varValCam;
        End;

        pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMENT'+strTabela+'_NOV', fltIcmEnt);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMSAI'+strTabela+'_NOV', fltIcmSai);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_SUBSTI'+strTabela+'_NOV', fltSubsti);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_DESOPE'+strTabela+'_NOV', fltDesOpe);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_OUTVAL'+strTabela+'_NOV', fltOutVal);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_SUBFED'+strTabela+'_NOV', fltSubFed);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_IMPFED'+strTabela+'_NOV', fltImpFed);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMENT_NOV', fltIcmEnt);

        pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMSAI' + strTabela + '_NOV', fltIcmSai);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_SUBSTI_NOV', fltSubsti);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_DESOPE' + strTabela + '_NOV', fltDesOpe);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_OUTVAL' + strTabela + '_NOV', fltOutVal);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_SUBFED_NOV', fltSubFed);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_IMPFED_NOV', fltImpFed);


//        pAdicionaCampoGrid('ITE_PRECUS');
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS', fPrecoCusto(False, strTabela));
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS_NOV', fPrecoCusto(True, strTabela, fltSubsti, fltSubFed, fltIcmEnt, fltIpiEnt));

        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS'+strTabela, fPrecoCusto(False, strTabela)/qryGenIte.FieldByName('ITE_CNVCUS').AsFloat);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS'+strTabela+'_NOV', fPrecoCusto(True, strTabela, fltSubsti, fltSubFed, fltIcmEnt, fltIpiEnt));
//        pAdicionaCampoGrid('ITE_CUSREA'+strTabela);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA'+strTabela, fPrecoCustoReal(False, strTabela));
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA'+strTabela+'_NOV', fPrecoCustoReal(True, strTabela, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal, fltSubsti, fltSubFed, fltIcmEnt, fltIpiEnt));
      Finally
        FreeAndNil(CalculaComposicaoCusto);
      End;
    End;

    procedure pOrdenaCorretamenteOGrid;
    var arrCamposGridFinal: Array Of TCampoGlobal;
        CampoGlobal: TCampoGlobal;
        intIndexField: Integer;
        PosAtu: integer;
    begin
      SetLength(arrCamposGridFinal, Length(arrCamposGrid));
      PosAtu := 0;
      For intIndexField := 0 To High(arrCamposGlobal) do
      Begin
        CampoGlobal := fCampoPorNome(arrCamposGrid, arrCamposGlobal[intIndexField].strNomCam, False);
        If CampoGlobal.strNomCam <> 'FALHA' Then
        Begin
          arrCamposGridFinal[PosAtu] := CampoGlobal;
          Inc(PosAtu);
        End
      End;

      SetLength(arrCamposGrid, Length(arrCamposGrid));
      For intIndexField := 0 To High(arrCamposGridFinal) Do
        arrCamposGrid[intIndexField] := arrCamposGridFinal[intIndexField];

    end;


    procedure pNormatizaCampoCamposDoGrid();
    var intTabPre:integer;
    begin
      cdsAltGlo.First;

      while not cdsAltGlo.Eof do
      Begin
        If cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'S' Then
        Begin
          If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, STR_CAMPOS_COMPRA_LIQ) > 0 Then
            pAdicionaCampoGrid('ITE_COMLIQ');

          If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, STR_CAMPOS_CUSTO_GERAL) > 0 Then
          Begin
            pAdicionaCampoGrid('ITE_PRECUS');
            For intTabPre := 1 To 7 do
            Begin
              If (VS_strTabPrc[intTabPre] = 'S') Then
              begin
                If rdgTipAltFor.ItemIndex = 0 Then
                  pAdicionaCampoGrid('ITE_PREVE'+ intTabPre.ToString)
                Else
                  pAdicionaCampoGrid('ITE_MARBR'+ intTabPre.ToString);
              End;
            End;
          End;


          If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, STR_CAMPOS_APENAS_CUSREA) > 0 Then
          Begin
            If rdgTipAltFor.ItemIndex = 0 Then
              pAdicionaCampoGrid('ITE_PREVE'+ cdsAltGlo.FieldByName('ITE_TABELA').AsString)
            Else
              pAdicionaCampoGrid('ITE_MARBR'+ cdsAltGlo.FieldByName('ITE_TABELA').AsString);
             pAdicionaCampoGrid('ITE_CUSREA'+ cdsAltGlo.FieldByName('ITE_TABELA').AsString);
          End;


          If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, STR_CAMPOS_VENDA + STR_CAMPOS_MARGEM) > 0 Then
          Begin
            If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, STR_CAMPOS_VENDA) > 0 Then
              pAdicionaCampoGrid('ITE_MARBR'+ cdsAltGlo.FieldByName('ITE_TABELA').AsString)
            Else
              pAdicionaCampoGrid('ITE_PREVE'+ cdsAltGlo.FieldByName('ITE_TABELA').AsString);
          End;

          pAdicionaCampoGrid(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString);
        End;
        cdsAltGlo.Next
      End;
      pOrdenaCorretamenteOGrid;
    end;
begin
  Try

    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    Result := True;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';

    strSQL := strSQL +   fSQLCampos;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';

    If (Not fEmptyStr(edtDocumento.Text)) Then
      strSQL := strSQL + '  JOIN MOVDET D ON I.ITE_CODITE = D.DET_CODITE ';

    strSQL := strSQL + ' INNER JOIN ITEFOR F ON I.ITE_CODITE = F.ITE_CODITE ';

    strSQL := strSQL + ' INNER JOIN TABDET A ON A.ITE_CODTAB = F.ITE_CODTAB ';
    strSQL := strSQL + '                    AND A.ITE_CODITE = F.ITE_CODITE ';
    strSQL := strSQL + '                    AND A.ITE_CODEMP = G.ITE_CODEMP ';

    strSQL := strSQL + ' AND A.ITE_CODEMP IN (' + fRetEmpresasAtivaco + ')  ';

    strSQL := strSQL + ' INNER JOIN TABPRE   ON TAB_CODTAB = F.ITE_CODTAB ';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC1 ON DC1.DET_SEQDET = A.AUTOINCREM  AND DC1.DET_TABELA = 1';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC2 ON DC2.DET_SEQDET = A.AUTOINCREM  AND DC2.DET_TABELA = 2';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC3 ON DC3.DET_SEQDET = A.AUTOINCREM  AND DC3.DET_TABELA = 3';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC4 ON DC4.DET_SEQDET = A.AUTOINCREM  AND DC4.DET_TABELA = 4';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC5 ON DC5.DET_SEQDET = A.AUTOINCREM  AND DC5.DET_TABELA = 5';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC6 ON DC6.DET_SEQDET = A.AUTOINCREM  AND DC6.DET_TABELA = 6';
    strSQL := strSQL + ' LEFT  JOIN DETCUS DC7 ON DC7.DET_SEQDET = A.AUTOINCREM  AND DC7.DET_TABELA = 7';
    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + '  TRUE ';

    If Not fEmptyStr(mskLinGru.Text) Then
    Begin
      If Copy(mskLinGru.Text,3,3) = '000' then
        strSQL := strSQL + '  AND I.ITE_CODGRU LIKE :CODGRU '
      Else
        strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';
    End;

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      strSQL := strSQL + '  AND I.ITE_DESITE LIKE :DESITE ';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
    End;

    If Not fEmptyStr(edtCodUni.Text) Then
    Begin
      strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';
    End;

    If Not fEmptyStr(edtCodMar.Text) Then
    Begin
      strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      strSQL := strSQL + '  AND F.ITE_CODFOR = :CODFOR ';
    End;

    If Not fEmptyStr(edtTabPre.Text) Then
      strSQL := strSQL + '  AND TAB_CODTAB = :CODTAB ';

    If Not fEmptyStr(edtCodAbr.Text) Then
    Begin
      If fCfgSIs('TIPABF') = '1' Then
        strSQL := strSQL + '  AND I.ITE_CODABF = :CODABF  '
      Else
        strSQL := strSQL + '  AND G.ITE_CODABF = :CODABF  '
    End;

    If Not fEmptyStr(edtClaIPI.Text) Then
    Begin
      strSQL := strSQL + '  AND LEFT(I.ITE_CLAIPI,'+IntToStr(Length(edtClaIPI.Text))+') = :CLAIPI ';
    End;

    If Not fEmptyStr(cmbCampos.Text) Then
      strSQL := strSQL + 'AND ' + fRetornaNomeCampoExpressao(cmbCampos.Text) + ' ' + cmbOperad.Text + ' :VALDIG ';

    If (Pos(edtStatus.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_ITEATI = :ITEATI ';

    If (Not fEmptyStr(edtDocumento.Text)) Then
    Begin
      strSQL := strSQL + ' AND G.ITE_CODEMP = D.DET_CODEMP ';
      strSQL := strSQL + ' AND D.DET_NUMDOC = :NUMDOC      ';
      strSQL := strSQL + ' AND D.DET_ESPDOC = :ESPDOC      ';
      strSQL := strSQL + ' AND IFNULL(D.DET_SERIE_, "") = :SERDOC      ';
      strSQL := strSQL + ' AND IFNULL(DET_ORIDOC, "") = "" ';

      If Not fEmptyStr(edtForNot.Text) Then
        strSQL := strSQL + ' AND D.DET_CODFOR = :FORNOT      ';
    End;

    If Not chkGerA.Checked Then
      strSQL := strSQL + '  AND ITE_NVLGIR <> "A" ';

    If Not chkGerB.Checked Then
      strSQL := strSQL + '  AND ITE_NVLGIR <> "B" ';

    If Not chkGerB.Checked Then
      strSQL := strSQL + '  AND ITE_NVLGIR <> "C" ';

    If Not chkForA.Checked Then
      strSQL := strSQL + '  AND LEFT(ITE_NVLFOR, 1) <> "A" ';

    If Not chkForB.Checked Then
      strSQL := strSQL + '  AND LEFT(ITE_NVLFOR, 1) <> "B" ';

    If Not chkForC.Checked Then
      strSQL := strSQL + '  AND LEFT(ITE_NVLFOR, 1) <> "C" ';

    Case rdgAtiCom.ItemIndex of
      0: strSQL := strSQL + '  AND TAB_ATICMP = "S" ';
      1: strSQL := strSQL + '  AND TAB_ATICMP = "N" ';
    End;

    Case rdgCusAtivo.ItemIndex of
      0: Begin
           strSQL := strSQL + '  AND ((G.ITE_TABPR1 = A.ITE_CODTAB) OR ';
           strSQL := strSQL + '       (G.ITE_TABPR2 = A.ITE_CODTAB) OR ';
           strSQL := strSQL + '       (G.ITE_TABPR3 = A.ITE_CODTAB) OR ';
           strSQL := strSQL + '       (G.ITE_TABPR4 = A.ITE_CODTAB) OR ';
           strSQL := strSQL + '       (G.ITE_TABPR5 = A.ITE_CODTAB) OR ';
           strSQL := strSQL + '       (G.ITE_TABPR6 = A.ITE_CODTAB) OR ';
           strSQL := strSQL + '       (G.ITE_TABPR1 = A.ITE_CODTAB)) ';
         End;
      1: Begin
           strSQL := strSQL + '  AND ((G.ITE_TABPR1 <> A.ITE_CODTAB) AND ';
           strSQL := strSQL + '       (G.ITE_TABPR2 <> A.ITE_CODTAB) AND ';
           strSQL := strSQL + '       (G.ITE_TABPR3 <> A.ITE_CODTAB) AND ';
           strSQL := strSQL + '       (G.ITE_TABPR4 <> A.ITE_CODTAB) AND ';
           strSQL := strSQL + '       (G.ITE_TABPR5 <> A.ITE_CODTAB) AND ';
           strSQL := strSQL + '       (G.ITE_TABPR6 <> A.ITE_CODTAB) AND ';
           strSQL := strSQL + '       (G.ITE_TABPR1 <> A.ITE_CODTAB)) ';
         End;
    End;

    strSQL := strSQL + '  ORDER BY G.ITE_CODITE, ORDEMP, G.ITE_CODEMP ';

    With qryGenIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(mskLinGru.Text) Then
      Begin
        If Copy(mskLinGru.Text,3,3) = '000' then
          ParamByName('CODGRU').AsString := Copy(mskLinGru.Text,1,3)+'%'
        Else
          ParamByName('CODGRU').AsString := mskLinGru.Text;
      End;

      If Not fEmptyStr(edtDesIte.Text) Then
      Begin
        ParamByName('DESITE').AsString := edtDesIte.Text + '%';
      End;

      If Not fEmptyStr(edtRefere.Text) Then
      Begin
        ParamByName('REFERE').AsString := edtRefere.Text;
      End;

      If Not fEmptyStr(edtCodUni.Text) Then
      Begin
        ParamByName('CODUNI').AsString := edtCodUni.Text;
      End;

      If Not fEmptyStr(edtCodMar.Text) Then
      Begin
        ParamByName('CODMAR').AsString := edtCodMar.Text;
      End;

      If Not fEmptyStr(edtCodFor.Text) Then
        ParamByName('CODFOR').AsString := edtCodFor.Text;

      If Not fEmptyStr(edtTabPre.Text) Then
        ParamByName('CODTAB').AsString := edtTabPre.Text;

      If Not fEmptyStr(edtCodAbr.Text) Then
      Begin
        ParamByName('CODABF').AsString := edtCodAbr.Text;
      End;

      If Not fEmptyStr(edtClaIPI.Text) Then
      Begin
        ParamByName('CLAIPI').AsString := edtClaIPI.Text;
      End;

      If Not fEmptyStr(cmbCampos.Text) Then
        ParamByName('VALDIG').AsFloat := fStrToFloat(edtValDig.Text);

      If Not fEmptyStr(edtDocumento.Text) Then
      Begin
        ParamByName('NUMDOC').AsString := edtDocumento.Text;
        ParamByName('ESPDOC').AsString := edtEspecie.Text;
        ParamByName('SERDOC').AsString := edtSerie.Text;

        If Not fEmptyStr(edtForNot.Text) Then
          ParamByName('FORNOT').AsString := edtForNot.Text;
      End;

//      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Pos(edtStatus.Text, 'SN') > 0) Then
        ParamByName('ITEATI').AsString := edtStatus.Text;

      Open;
      pSetaClient(qryGenIte);

      {*****************************************}
      {* CASO NÃO HAJA ITENS COM O FILTRO      *}
      {**************************************MV*}
      If IsEmpty Then
      Begin
        Result := False;
        fMensagem('', 'Não há dados itens para serem alterados!', ['&O k']);
        Exit;
      End;

      pgbProBar.Visible := True;
      pgbProBar.Max     := (RecordCount * Length(arrCamposTabela));

      intContReg := 0;

      If Assigned(lblContador) Then
      Begin
        lblContador.Caption := IntToStr(intContReg) + ' / ' + IntToStr(pgbProBar.Max);
        lblContador.Visible := True;
        Application.ProcessMessages;
      End;

      While Not Eof Do
      Begin

        SetLength(arrRegistroAtual, 0);

        For intContador := 0 To FieldCount -1 Do
        Begin

          intTamMat := Length(arrRegistroAtual);
          SetLength(arrRegistroAtual, intTamMat+1);
          arrRegistroAtual[intTamMat].strNomCam := qryGenIte.Fields[intContador].FieldName;
          arrRegistroAtual[intTamMat].varValCam := qryGenIte.Fields[intContador].Value;

          If (Fields[intContador].DataType = ftString) Then
            arrRegistroAtual[intTamMat].strTipCam := 'VARCHAR'
          Else
            arrRegistroAtual[intTamMat].strTipCam := 'NUMERIC';

          If arrRegistroAtual[intTamMat].varValCam = Null Then
          Begin
            If (Fields[intContador].DataType = ftString) Then
              arrRegistroAtual[intTamMat].varValCam := ''
            Else
              arrRegistroAtual[intTamMat].varValCam := 0.0;
          End;

        End;

        intTamMat := Length(arrCamposTabela);

        intContador := 0;
        fltFatIpi := 1;

        pNormatizaCampoCamposDoGrid;


        While intContador < intTamMat Do
        Begin

          strCamAtu := arrCamposTabela[intContador].strNomCam;

          If blnRecalculoGeral And (strCamAtu = 'ITE_PRECOM') Then
            varValAtu := 1
          Else
            varValAtu := arrCamposTabela[intContador].varValCam;

          If blnAltPorFator And (strCamAtu = 'ITE_IPIENT') Then
            fltFatIpi := arrCamposTabela[intContador].varValCam;

          If blnAltPorFator Then
            If (varValAtu = '') Or (varValAtu = '0') Then
               varValAtu := 1;

          varValorRegAtual := fCampoPorNome(arrRegistroAtual, strCamAtu + '_NOV').varValCam;

          {*****************************************}
          {* RECALCULA PREÇO DE COMPRA             *}
          {**************************************MV*}
          If blnAltPorFator And (strCamAtu = 'ITE_PRECOM') Then
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECOM_NOV', varValorRegAtual * varValAtu)
          Else
          Begin
            If blnAltPorFator And (Pos(strCamAtu, 'ITE_VALFRE_TFO_PRDGRU_ITE_ABFCOF_ITE_ABFPIS') = 0)  Then
               pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValorRegAtual * varValAtu)
            Else
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);
          End;

          pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMLIQ_NOV', fPrecoCompraLiquido(True));
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMLIQ', fPrecoCompraLiquido(False));

          If (Pos(strCamAtu, STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR_ALT_GLO_FOR + STR_CAMPOS_VENDA + STR_CAMPOS_MARGEM) > 0) Then
          Begin

            For intIndice := 1 To Length(VS_strTabPrc) Do
              If (VS_strTabPrc[intIndice] = 'S') Then
              Begin

                If fTemCustoItem(FieldByName('ITE_CODITE').AsString,
                               FieldByName('ITE_CODEMP').AsString,
                               FieldByName('ITE_CODTAB').AsString,
                               intIndice,
                               fltPreVen,
                               fltMarBru,
                               qryGenIte.FieldByName('INCDET').AsString) Then
                  pAtualizaValorCampo(arrRegistroAtual,
                                      'UPDATE_ITEGER' + IntToStr(intIndice),
                                      'S');

                fltPreVenNov := fltPreVen;
                fltMarBruNov := fltMarBru;
                pNormatizaCustos(intIndice, fltPreVenNov, fltMarBruNov);

                // CALCULA PREÇO DE VENDA
                If rdgTipAltFor.ItemIndex = 0 Then
                Begin

                  If (VS_strCodEmp = FieldByName('ITE_CODEMP').AsString) Or (Not fUsaPrecoMatriz(FieldByName('ITE_CODEMP').AsString)) Then
                  Begin // CALCULA PREÇO DE VENDA
                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice), fltMarBru);

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice) + '_NOV', fltMarBruNov);

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice) + '_NOV',
                                        fPrecoVenda(1, intIndice, fltMarBruNov, fltPreVenNov));

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice), fltPreVen);
                  End;
                End
                Else
                Begin
                  pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice) + '_NOV',
                                      fPrecoVenda(2, intIndice, fltMarBruNov, fltPreVenNov));

                  pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice) + '_NOV',  fltPreVenNov);
                  pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice),  fltPreVen);

                  pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice),
                                      fltMarBru);
                End;

              End;

          End;

          pgbProBar.StepBy(1);
          Inc(intContador);
          inc(intContReg);

          If Assigned(lblContador) Then
          Begin
            lblContador.Caption :=  IntToStr(intContReg) + ' / ' + IntToStr(pgbProBar.Max);
          End
          Else
            lblContadorLocal.Caption :=  IntToStr(intContReg) + ' / ' + IntToStr(pgbProBar.Max);
          If (intContReg mod 100 = 0) Then
          Application.ProcessMessages;

        End;

        pAlteraValorTabelaItens(FieldByName('ITE_CODITE').AsString, arrRegistroAtual);

        Next;

      End;
      Close;

    End;

    pgbProBar.Position := 0;
    pgbProBar.Visible  := False;

  Finally
    FreeAndNil(cpcParams);
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pAtualizaCdsIteGlo;
var i: integer;
    strValor : String;
begin
  plimpValuesCdsAltGlo;
  For i := 0 To cxvAlteracao.Rows.Count -1 do
  Begin
    If cxvAlteracao.Rows[i] is TcxEditorRow Then
    Begin

      If cdsAltGlo.Locate('ITE_NOMCAM', arrCamposGlobal[cxvAlteracao.Rows[i].Tag].strNomCam, []) Then
      Begin
        If cxvAlteracao.Rows[i] is TcxEditorRow Then
        Begin
          If VarIsNull(TcxEditorRow(cxvAlteracao.Rows[i]).Properties.Value) Then
            strValor := ''
          Else
            strValor := TcxEditorRow(cxvAlteracao.Rows[i]).Properties.Value;

          arrCamposGlobal[cxvAlteracao.Rows[i].Tag].varValCam := TcxEditorRow(cxvAlteracao.Rows[i]).Properties.Value;
          cdsAltGlo.Edit;
          cdsAltGlo.FieldByName('ITE_VALCAM').AsString := strValor;
          If strValor <> '' Then
            cdsAltGlo.FieldByName('ITE_ALTERA').AsString := 'S'
          Else
            cdsAltGlo.FieldByName('ITE_ALTERA').AsString := 'N';
          cdsAltGlo.Post;
        End;
      End;
    End;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; varValor: Variant);
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intContador := 0;

  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      arrCampos[intContador].varValCam := varValor;
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAltPrecoFornecedorTabPrd.fGeraVetorCampos: Boolean;
  Var
    intTamMat: Integer;
begin
  SetLength(arrCamposTabela, 0);
  SetLength(arrCamposGrid,   0);

  With cdsAltGlo Do
  Begin
    DisableControls;

    First;

    While Not Eof Do
    Begin

      If blnRecalculoGeral And (FieldByName('ITE_NOMCAM').AsString = 'ITE_PRECOM') Then
      Begin
        Edit;
        cdsAltGlo.FieldByName('ITE_ALTERA').AsString :=  'S';
        Post;
      End;

      If (cdsAltGlo.FieldByName('ITE_ALTERA').AsString <> 'S') Then
      Begin
        Next;
        Continue;
      End;

      pAtualizaValorCampo(arrCamposGlobal, FieldByName('ITE_NOMCAM').AsString, FieldByName('ITE_VALCAM').Value);

      intTamMat := Length(arrCamposTabela);
      SetLength(arrCamposTabela, intTamMat+1);

      arrCamposTabela[intTamMat].strDesCam := FieldByName('ITE_DESCAM').AsString;
      arrCamposTabela[intTamMat].varValCam := FieldByName('ITE_VALCAM').Value;
      arrCamposTabela[intTamMat].strMasCam := FieldByName('ITE_MASCAM').AsString;
      arrCamposTabela[intTamMat].strNomCam := FieldByName('ITE_NOMCAM').AsString;
      arrCamposTabela[intTamMat].strDesAbr := FieldByName('ITE_DESABR').AsString;
      arrCamposTabela[intTamMat].intLimCam := FieldByName('ITE_LIMCAM').AsInteger;
      arrCamposTabela[intTamMat].strTipCam := FieldByName('ITE_TIPCAM').AsString;

      Next;

    End;

    EnableControls;
  End;

  Result := (Length(arrCamposTabela) > 0);
end;

procedure TfrmAltPrecoFornecedorTabPrd.pAlteraValorTabelaItens(strCodIte: String;
  Var arrCampos: Array Of TCampoGlobal);
  Var
    intContador: Integer;
    intTamMat  : Integer;
begin
  intTamMat := Length(arrCampos);
  intContador := 0;

  With cdsIteGlo Do
  Begin
    Append;
    FieldByName('ITE_MARDES').AsString := 'M';

    While intContador < intTamMat Do
    Begin
      If Pos('CHAR', arrCampos[intContador].strTipCam) > 0 Then
        FieldByName(arrCampos[intContador].strNomCam).AsString := arrCampos[intContador].varValCam

      Else If FieldByName(arrCampos[intContador].strNomCam).DataType = ftFloat Then
      Begin
        FieldByName(arrCampos[intContador].strNomCam).AsFloat := fStrToFloat(arrCampos[intContador].varValCam);


      End

      Else If FieldByName(arrCampos[intContador].strNomCam).DataType In [ftInteger, ftSmallint, ftWord] Then
        FieldByName(arrCampos[intContador].strNomCam).AsInteger := Trunc(fStrToFloat(arrCampos[intContador].varValCam));

      Inc(intContador);
    End;

    Post;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrSel) Then
  Begin
    if fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrSel) Then
  Begin
    if fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel) Then
  Begin
    If (not blnNomFor) Or fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If edtCodFor.Enabled Then
    pedtCodForKeyPre(edtCodFor,key,TRUE);
end;

procedure TfrmAltPrecoFornecedorTabPrd.edtCamAltKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not fEntraCons(Key) Then
  Begin
    Exit;
  End;

  With cdsAltGlo Do
  If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODFOR' Then
    pCodForKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODGPR' Then
    pCodGprKeyPress
  Else  If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODABF' Then
    pCodAbfKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_ABFPIS' Then
    pCodAbfPisPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_ABFCOF' Then
    pCodAbfCofPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_ABFIPI' Then
    pCodAbfIPIPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODMAR' Then
    pCodMarcaKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_SITPRO' Then
    pCodSituacaoKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODMON' Then
    pCodMontadoraKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODUNI' Then
    pCodUnidadeKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_UNICOM' Then
    pCodUnidadeKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_UNICOM' Then
    pCodUnidadeKeyPress
  Else If FieldByName('ITE_NOMCAM').AsString = 'ITE_CODGRU' Then
    pCodGrupoKeyPress(Key)
  Else If FieldByName('ITE_NOMCAM').AsString = 'TFO_PRDGRU' Then
    pPrdGruKeyPress;

  Key := #0;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodForKeyPress;
  Var
    chrKey: Char;
Begin
  chrKey := '?';
  pedtCodForKeyPre(edtCamAlt,chrKey,FALSE);
End;

procedure TfrmAltPrecoFornecedorTabPrd.pCodGprKeyPress;
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoPrecos(Self, edtCamAlt, Nil, Nil, chrKey, arrGrupo) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{procedure TfrmAltPrecoFornecedor.pCodDepKeyPress;
  Var
    chrKey: Char;
    arrDep: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDepartamento(Self, edtCamAlt, Nil, Nil, chrKey, arrDep) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
}

procedure TfrmAltPrecoFornecedorTabPrd.pCodAbfKeyPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;

begin
  inherited;

  chrKey := '/';

  If fPesqAbrevFiscal(Self, edtCamAlt, nil, qryConAbf, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodAbfPisPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqPISSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    TcxEditorRow(cxvAlteracao.FocusedRow).Properties.Value := edtCamAlt.Text;
    cxvAlteracao.NextVisibleRow(cxvAlteracao.FocusedRow);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodAbfCofPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqCOFSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    TcxEditorRow(cxvAlteracao.FocusedRow).Properties.Value := edtCamAlt.Text;
    cxvAlteracao.NextVisibleRow(cxvAlteracao.FocusedRow);
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodAbfIPIPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqIPISAI(Self, edtCamAlt, Nil, chrKey, arrSel) Then
  Begin
    TcxEditorRow(cxvAlteracao.FocusedRow).Properties.Value := edtCamAlt.Text;
    cxvAlteracao.NextVisibleRow(cxvAlteracao.FocusedRow);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodMarcaKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;

begin
  inherited;
  chrKey := '/';

  If fPesqMarcas(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodSituacaoKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If fPesqSituacaoProduto(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodMontadoraKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If fPesqMontadora(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodUnidadeKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;

begin
  inherited;
  chrKey := '/';

  If fPesqUnidade(Self, edtCamAlt, nil, nil, nil, chrKey, arrSel) Then
  Begin
    if fvalidaCampos(edtCamAlt,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCodGrupoKeyPress(var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, edtCamAlt, nil, nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.dbgTiposAltDblClick(Sender: TObject);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgTiposAltKeyDown(Sender, Key, State);
end;

procedure TfrmAltPrecoFornecedorTabPrd.FormShow(Sender: TObject);
begin
  inherited;
  lblCamAlt.Caption := '';

  pAtribuiTabelas;

  pMontaGrid;

  qryGenIte := fCriaQuery(Self);

  pCarregaComboExpressao;
  cmbOperad.Enabled  := False;
  edtValDig.Enabled  := False;
  edtValDig.Text     := '0.00';
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  pCarregaEmpresasAtivacao;

  plimpValuesCdsAltGlo;
  pAjustaVisibilidadeMargemBrutaEVenda;
//    objSalInt.fCarregaDados('', Self, Self.Name, strLoginUsuarioLogado);

end;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaEmpresasAtivacao;
  Var
    qryCadEmp: TUniQuery;
    intContador: Integer;
Begin
  qryCadEmp := fCriaQuery;
  With qryCadEmp, SQL Do
  Begin
    Add('SELECT GROUP_CONCAT(EMP_CODEMP) AS CODEMP FROM CADEMP');
    Add('INNER JOIN CFGSIS ON SIS_CODEMP = EMP_CODEMP AND SIS_CODCFG = "CFG_COLTAB" AND SIS_VALCFG = "S"');
    Add('ORDER BY EMP_CODEMP');
    Open;
    cklEmpresas.Items.CommaText := FieldByName('CODEMP').AsString;
  End;

  FreeAndNil(qryCadEmp);

  For intContador := 0 To cklEmpresas.Count - 1 Do
    cklEmpresas.Checked[intContador] := True;
End;

Function TfrmAltPrecoFornecedorTabPrd.fRetEmpresasAtivaco: String;
  Var
    intContador: Integer;
    sltSelecionadas: TStringList;
Begin
  sltSelecionadas := TStringList.Create;

  For intContador := 0 To cklEmpresas.Count - 1 Do
    If cklEmpresas.Checked[intContador] Then
      sltSelecionadas.Add(cklEmpresas.Items[intContador]);

  Result := fCommaText(sltSelecionadas, True);
  FreeAndNil(sltSelecionadas);
End;

procedure TfrmAltPrecoFornecedorTabPrd.edtDesIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

    If fPesqItem(conIteSimples, Self, nil, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    Begin
      pSetFocus(edtRefere);
    End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.edtForNotExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtForNot.Text) Then
    edtDesForNot.Clear
  Else
  Begin
    edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
      edtForNot.Clear;
      pSetFocus(edtForNot);
    End;
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.edtForNotKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.edtTabPreKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqTabelaPreco(Self, edtTabPre, edtNomTab, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtTabPre, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmAltPrecoFornecedorTabPrd.fTamanhoCampo(strCampo: String): Boolean;
  Var
    intTamanho: Integer;
begin
  intTamanho := cdsAltGlo.FieldByName('ITE_LIMCAM').AsInteger;

  If Length(strCampo) > intTamanho Then
  Begin
    fMensagem('ATENÇÃO!', 'Número Máximo de Caracteres tem que ser igual á : '+ IntToStr(intTamanho), ['&O k']);
    Result := False;
  End
  Else
    Result := True;
end;

procedure TfrmAltPrecoFornecedorTabPrd.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin

    If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, qryAbfIcm, Key, arrSel) Then
    Begin
      If fValidaCampos(edtCodAbr, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pMontaGrid;
  Var
    intPosMat: Integer;
    strMasVal: String;
    strMasFat: String;
    strMasPer: String;
    strMasInt: String;
    strMasMar: String;
    intTabPre: Integer;
    blnSUFRAM: Boolean;
    strFrmCus: String;

  function fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;

begin

  blnSUFRAM := fCfgSis('SUFRAM', varBoolean);
  strFrmCus := fCfgSis('FRMCUS', varString);

  strMasVal := '#,####0.0000';
  strMasFat := '#,####0.0000';
  strMasMar := '#,###0.000';
  strMasPer := '#,##0.00';
  strMasInt := '#,##0';
  pnlDadosAlt.Visible := False;
  cxvAlteracao.Visible := True;


  {******************************************}
  {* CARREGA MATRIZ COM OS CAMPOS QUE PODEM *}
  {* SER ALTERADOS                          *}
  {***************************************JB*}
  intPosMat := -1;
  SetLength(arrCamposGlobal, 0);

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Grupo de Produto';
  arrCamposGlobal[intPosMat].varValCam := '';
  arrCamposGlobal[intPosMat].strMasCam := '';
  arrCamposGlobal[intPosMat].strNomCam := 'TFO_PRDGRU';
  arrCamposGlobal[intPosMat].strDesAbr := 'Grupo de Produto';
  arrCamposGlobal[intPosMat].intLimCam := 5;
  arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(05)';
  arrCamposGlobal[intPosMat].strNomArq := 'ITEFOR';
  cxvAlteracaoPRDGRU.Tag := intPosMat;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Abreviação PIS';
  arrCamposGlobal[intPosMat].varValCam := '';
  arrCamposGlobal[intPosMat].strMasCam := '';
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABFPIS';
  arrCamposGlobal[intPosMat].strDesAbr := 'Abreviação PIS';
  arrCamposGlobal[intPosMat].intLimCam := 5;
  arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
  arrCamposGlobal[intPosMat].strNomArq :=    'TABDET';
  arrCamposGlobal[intPosMat].strNomArqSec := IIf(fCfgSis('TPABPC') = '2', 'ITEGER', 'CADITE');
  cxvAlteracaoABFPIS.Tag := intPosMat;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Abreviação COFINS';
  arrCamposGlobal[intPosMat].varValCam := '';
  arrCamposGlobal[intPosMat].strMasCam := '';
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABFCOF';
  arrCamposGlobal[intPosMat].strDesAbr := 'Abreviação COFINS';
  arrCamposGlobal[intPosMat].intLimCam := 5;
  arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  arrCamposGlobal[intPosMat].strNomArqSec := IIf(fCfgSis('TPABPC') = '2', 'ITEGER', 'CADITE');
  cxvAlteracaoABFCOF.Tag := intPosMat;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Preço de Compra';
  arrCamposGlobal[intPosMat].varValCam := 0.0;

  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := strMasFat;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;

  arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECOM';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Compra';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerPRECOM.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerPRECOM.Properties.EditProperties).DisplayFormat := AnsiReplaceStr(arrCamposGlobal[intPosMat].strMasCam, '#', '');
  
  {*******************************************}
  {* DESCONTOS / OUTRAS COLUNAS              *}
  {****************************************MV*}
  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 01';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF01';
  arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 01';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESF01.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESF01.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 02';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF02';
  arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 02';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESF02.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESF02.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 03';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF03';
  arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 03';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESF03.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESF03.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 04';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF04';
  arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 04';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESF04.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESF04.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;


  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 05';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF05';
  arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 05';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESF05.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESF05.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;


  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 06';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF06';
  arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 06';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESF06.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESF06.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Preço Compra Líquido';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasFat;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMLIQ';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço Compra Líq.';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := '';

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais (-)';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBFED';
  arrCamposGlobal[intPosMat].strDesAbr := '% Imp. Federais (-)';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerSUBFED.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerSUBFED.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;



  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% IPI de Entrada';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPIENT';
  arrCamposGlobal[intPosMat].strDesAbr := '% IPI Entrada';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerIPIENT.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerIPIENT.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;



  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Frete de Entrada';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_FREENT';
  arrCamposGlobal[intPosMat].strDesAbr := '% Frete Entrada';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerFREENT.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerFREENT.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;


  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DESVFR');
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_VALFRE';
  arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DESVFR');
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerVALFRE.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerVALFRE.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;


  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Acréscimo Financeiro';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_ACRFIN';
  arrCamposGlobal[intPosMat].strDesAbr := '% Acresc.Financ.';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerACRFIN.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerACRFIN.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESADB';
  arrCamposGlobal[intPosMat].strDesAbr := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerDESADB.Properties.Caption := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')   ';
  cxerDESADB.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerDESADB.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Preço de Custo';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  If blnAltPorFator Then
  Begin
    arrCamposGlobal[intPosMat].strMasCam := strMasFat;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
  End
  Else
  Begin
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
  End;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECUS';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço Custo';
  arrCamposGlobal[intPosMat].intLimCam := -1;
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPFED';
  arrCamposGlobal[intPosMat].strDesAbr := '% Impostos Fed.';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  cxerIMPFED.Tag := intPosMat;
  TcxCurrencyEditProperties(cxerIMPFED.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;


  If blnSufram and (strFrmCus = '4') then
  begin
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% TCIF (+)';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_TCIFCU';
    arrCamposGlobal[intPosMat].strDesAbr := '% TCIF (+)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';


    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% TS (+)';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_TSCUST';
    arrCamposGlobal[intPosMat].strDesAbr := '% TS (+)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desconto PIS/COFINS (-)';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DEPICO';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desconto PIS/COFINS (-)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desconto ICMS (-)';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DEICMS';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desconto ICMS (-)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Fator Regional (+)';;
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_FATREG';
    arrCamposGlobal[intPosMat].strDesAbr := '% Fator Regional (+)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  End;

  {*************************************************************}
  {* OUTROS VALORES                                            *}
  {**********************************************************JC*}
  cxerOUTVAL1.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxerOUTVAL2.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxerOUTVAL3.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxerOUTVAL4.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxerOUTVAL5.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxerOUTVAL6.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  cxerOUTVAL7.properties.Caption := fCfgSis('DOVCPP') + ' (+)   ';
  For intTabPre := 1 To 7 do
  Begin

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DOVCPP') + ' (+) ' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_OUTVAL' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DOVCPP') + ' (+) ' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';
    arrCamposGlobal[intPosMat].strTabela := intTabPre.ToString;

    case intTabPre of
      1: Begin
           cxerOUTVAL1.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL1.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      2: Begin
           cxerOUTVAL2.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL2.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      3: Begin
           cxerOUTVAL3.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL3.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      4: Begin
           cxerOUTVAL4.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL4.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      5: Begin
           cxerOUTVAL5.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL5.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      6: Begin
           cxerOUTVAL6.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL6.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      7: Begin
           cxerOUTVAL7.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerOUTVAL7.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
    end;




    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% ICMS de Saída ' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMSAI' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Saída ' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';
    arrCamposGlobal[intPosMat].StrTabela := intTabPre.ToString;
    case intTabPre of
      1: Begin
           cxerICMSAI1.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI1.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      2: Begin
           cxerICMSAI2.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI2.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      3: Begin
           cxerICMSAI3.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI3.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      4: Begin
           cxerICMSAI4.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI4.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      5: Begin
           cxerICMSAI5.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI5.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      6: Begin
           cxerICMSAI6.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI6.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      7: Begin
           cxerICMSAI7.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerICMSAI7.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
    end;
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Despesas Operacionais ' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].strDesAbr := '% Despesas Oper. ' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESOPE' + intTabPre.ToString;
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';
    arrCamposGlobal[intPosMat].strTabela := intTabPre.ToString;

    case intTabPre of
      1: Begin
           cxerDESOPE1.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE1.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      2: Begin
           cxerDESOPE2.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE2.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      3: Begin
           cxerDESOPE3.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE3.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      4: Begin
           cxerDESOPE4.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE4.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      5: Begin
           cxerDESOPE5.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE5.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      6: Begin
           cxerDESOPE6.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE6.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      7: Begin
           cxerDESOPE7.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerDESOPE7.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         end;
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Custo Real' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasFat;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CUSREA' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].strDesAbr := 'Custo Real' + IntToStr(intTabPre);;
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := '';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda ' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda ' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';
    arrCamposGlobal[intPosMat].strTabela := intTabPre.ToString;
    case intTabPre of
      1: Begin
           cxerPREVE1.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE1.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      2: Begin
           cxerPREVE2.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE2.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      3: Begin
           cxerPREVE3.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE3.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      4: Begin
           cxerPREVE4.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE4.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      5: Begin
           cxerPREVE5.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE5.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      6: Begin
           cxerPREVE6.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE6.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      7: Begin
           cxerPREVE7.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerPREVE7.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         end;
    End;
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta ' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].varValCam := 0.0;

    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasMar;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
    End;

    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta ' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';
    arrCamposGlobal[intPosMat].strTabela := intTabPre.ToString;
    case intTabPre of
      1: Begin
           cxerMARBR1.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR1.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      2: Begin
           cxerMARBR2.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR2.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      3: Begin
           cxerMARBR3.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR3.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      4: Begin
           cxerMARBR4.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR4.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      5: Begin
           cxerMARBR5.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR5.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      6: Begin
           cxerMARBR6.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR6.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         End;
      7: Begin
           cxerMARBR7.Tag := intPosMat;
           TcxCurrencyEditProperties(cxerMARBR7.Properties.EditProperties).DisplayFormat := arrCamposGlobal[intPosMat].strMasCam;
         end;
    End;
    SetLength(arrCamposGlobal, fSoma(intPosMat));
  End;

  For intTabPre := 1 To  7 Do
  Begin
    If (VS_strTabPrc[intTabPre] = 'N') Then
    Begin

      case intTabPre of
        1: Begin
             cxerOUTVAL1.Visible := False;
             cxerDESOPE1.Visible := False;
             cxerICMSAI1.Visible := False;
             cxvCustoRealTab1.Visible := False;
             cxerPREVE1.Visible := False;
             cxerMARBR1.Visible := False;

           End;
        2: Begin
             cxerOUTVAL2.Visible := False;
             cxerDESOPE2.Visible := False;
             cxerICMSAI2.Visible := False;
             cxvCustoRealTab2.Visible := False;
             cxerPREVE2.Visible := False;
             cxerMARBR2.Visible := False;

           End;
        3: Begin
             cxerOUTVAL3.Visible := False;
             cxerDESOPE3.Visible := False;
             cxerICMSAI3.Visible := False;
             cxvCustoRealTab3.Visible := False;
             cxerPREVE3.Visible := False;
             cxerMARBR3.Visible := False;

           End;
        4: Begin
             cxerOUTVAL4.Visible := False;
             cxerDESOPE4.Visible := False;
             cxerICMSAI4.Visible := False;
             cxvCustoRealTab4.Visible := False;
             cxerPREVE4.Visible := False;
             cxerMARBR4.Visible := False;

           End;
        5: Begin
             cxerOUTVAL5.Visible := False;
             cxerDESOPE5.Visible := False;
             cxerICMSAI5.Visible := False;
             cxvCustoRealTab5.Visible := False;
             cxerPREVE5.Visible := False;
             cxerMARBR5.Visible := False;
           End;
        6: Begin
             cxerOUTVAL6.Visible := False;
             cxerDESOPE6.Visible := False;
             cxerICMSAI6.Visible := False;
             cxvCustoRealTab6.Visible := False;
             cxerPREVE6.Visible := False;
             cxerMARBR6.Visible := False;
           End;
        7: Begin
             cxerOUTVAL7.Visible := False;
             cxerDESOPE7.Visible := False;
             cxerICMSAI7.Visible := False;
             cxvCustoRealTab7.Visible := False;
             cxerPREVE7.Visible := False;
             cxerMARBR7.Visible := False;
           End;
      end;
    End;
  End;





  pGeraClient;

  {***********************************************************************************}
  {* PREÇO DE CUSTO                                                                  *}
  {* ESTE CAMPO DEVE SER CRIADO APÓS AS ATUALIZAÇÕES ACIMA PARA NÃO APARECER NO GRID *}
  {********************************************************************************LU*}

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% Substituição Tributária';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBSTI';
  arrCamposGlobal[intPosMat].strDesAbr := '% Subst. Tributária';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := '% ICMS Entrada';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasPer;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMENT';
  arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Entrada';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% IPI Entrada ' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPIENT' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].strDesAbr := '% IPI Entrada ' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := '';



    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Custo' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECUS' + IntToStr(intTabPre);
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço Custo' + IntToStr(intTabPre);;
    arrCamposGlobal[intPosMat].intLimCam := -1;
    arrCamposGlobal[intPosMat].strNomArq := '';
  End;

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Código do Fornecedor';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := '';
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODFOR';
  arrCamposGlobal[intPosMat].strDesAbr := 'Fornecedor';
  arrCamposGlobal[intPosMat].intLimCam := 8;
  arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(08)';
  arrCamposGlobal[intPosMat].strNomArq := 'ITEFOR';

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Custo Real';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasFat;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_CUSREA';
  arrCamposGlobal[intPosMat].strDesAbr := 'Custo Real';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := '';

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Preço em Dólar';
  arrCamposGlobal[intPosMat].varValCam := '';
  arrCamposGlobal[intPosMat].strMasCam := '';
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREDOL';
  arrCamposGlobal[intPosMat].strDesAbr := 'Em Dólar';
  arrCamposGlobal[intPosMat].intLimCam := 1;
  arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
  arrCamposGlobal[intPosMat].strNomArq := 'TABDET';


end;

procedure TfrmAltPrecoFornecedorTabPrd.pPrdGruKeyPress;
  var
    arrSel : TConsultasArray;
    chrKey: Char;
begin
  chrKey := '/';
  If fPesqGrupoProduto(Self, edtCamAlt, nil, nil, chrKey, arrSel, True,edtCodFor.Text) Then
  Begin
    if fvalidaCampos(edtCamAlt,False) then
    Begin
      TcxEditorRow(cxvAlteracao.FocusedRow).Properties.Value := edtCamAlt.Text;
      cxvAlteracao.NextVisibleRow(cxvAlteracao.FocusedRow);
    End;
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.rdgTipAltForClick(Sender: TObject);
begin
  pAjustaVisibilidadeMargemBrutaEVenda;
end;

Procedure TfrmAltPrecoFornecedorTabPrd.pAjustaVisibilidadeMargemBrutaEVenda;
var intIndice: Integer;
begin
  cxerMARBR1.Visible := False;
  cxerMARBR2.Visible := False;
  cxerMARBR3.Visible := False;
  cxerMARBR4.Visible := False;
  cxerMARBR5.Visible := False;
  cxerMARBR6.Visible := False;
  cxerMARBR7.Visible := False;
  cxerPREVE1.Visible := False;
  cxerPREVE2.Visible := False;
  cxerPREVE3.Visible := False;
  cxerPREVE4.Visible := False;
  cxerPREVE5.Visible := False;
  cxerPREVE6.Visible := False;
  cxerPREVE7.Visible := False;
  plimpValuesCdsAltGlo(True);
  case rdgTipAltFor.ItemIndex of
   0   : Begin
           For intIndice := 1 To Length(VS_strTabPrc) Do
           Begin
             If (VS_strTabPrc[intIndice] = 'S') Then
             case intIndice of
               1: cxerMARBR1.Visible := true;
               2: cxerMARBR2.Visible := true;
               3: cxerMARBR3.Visible := true;
               4: cxerMARBR4.Visible := true;
               5: cxerMARBR5.Visible := true;
               6: cxerMARBR6.Visible := true;
               7: cxerMARBR7.Visible := true;
             End;
           End;

         End;

   1, 2: Begin
           For intIndice := 1 To Length(VS_strTabPrc) Do
           Begin
             If (VS_strTabPrc[intIndice] = 'S') Then
             case intIndice of
               1: cxerPREVE1.Visible := true;
               2: cxerPREVE2.Visible := true;
               3: cxerPREVE3.Visible := true;
               4: cxerPREVE4.Visible := true;
               5: cxerPREVE5.Visible := true;
               6: cxerPREVE6.Visible := true;
               7: cxerPREVE7.Visible := true;
             End;
           End;
         End;
  End;
End;



procedure TfrmAltPrecoFornecedorTabPrd.plimpValuesCdsAltGlo(ApenasCampoVendaEMargem: Boolean = False);
begin
  cdsAltGlo.First;
  cdsAltGlo.First;
  while not cdsAltGlo.Eof Do
  Begin
    If (Not ApenasCampoVendaEMargem) Or (ApenasCampoVendaEMargem And ((Pos(cdsAltGloITE_NOMCAM.AsString, 'ITE_PREVE_ITE_MARBR') > 0))) Then
    Begin
      cdsAltGlo.Edit;
      cdsAltGloITE_VALCAM.Clear;
      cdsAltGlo.Post;
    End;
    cdsAltGlo.Next;
  End;

end;


procedure TfrmAltPrecoFornecedorTabPrd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

 Case Key Of
    VK_ESCAPE : Close;
    VK_RETURN : If (ActiveControl Is TRadioButton) Or
                   (ActiveControl Is TComboBox) Then
                  Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.edtClaIPIKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqClaIPI(Self, edtClaIPI, nil, Key, arrSel) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.pHabilitaNotaEntrada(blnHabilitar: Boolean);
Begin
  If blnHabilitar Then
  Begin
    lblDocumento.Enabled := True;
    lblEspecie.Enabled   := True;
    lblSerie.Enabled     := True;
    lblForNot.Enabled    := True;

    edtDocumento.Enabled := True;
    edtEspecie.Enabled   := True;
    edtSerie.Enabled     := True;
    edtForNot.Enabled    := True;

  End
  Else
  Begin
    edtDocumento.Clear;
    edtEspecie.Text := 'NF';
    edtSerie.Clear;
    edtForNot.Clear;
    edtDesForNot.Clear;

    lblDocumento.Enabled := False;
    lblEspecie.Enabled   := False;
    lblSerie.Enabled     := False;
    lblForNot.Enabled    := False;

    edtDocumento.Enabled := False;
    edtEspecie.Enabled   := False;
    edtSerie.Enabled     := False;
    edtForNot.Enabled    := False;

  End;

End;

procedure TfrmAltPrecoFornecedorTabPrd.pLimparTela;
  Var
    IntCont: Integer;
begin
  For IntCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[IntCont] Is TEditFocus Then
      (Self.Components[IntCont] As TEditFocus).Clear;
  End;

  If Not fEmptyStr(strTabFix) Then
  Begin
    edtTabPre.Text     := strTabFix;
    fValidaCampos(frmAltPrecoFornecedorTabPrd.edtTabPre, True);
  End;

  mskLinGru.Clear;
  chkNotEnt.Checked := False;
  edtStatus.Text    := 'T';
  pHabilitaNotaEntrada(False);
  pGeraClient;

  pMontaGrid;

  Self.SelectFirst;
end;

procedure TfrmAltPrecoFornecedorTabPrd.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAltGlo.CreateDataSet;
//  objSalInt := TSalvaInterface.Create(Self);
//  objSalInt.blnDeleteNaoEncontrados := False;
  edtCodAbr.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  strTabFix := '';
  blnRecalculoGeral := False;
  intDecUni := fCfgSis('DECUNI', varInteger);
  pgbProBar := pgbProgresso;

  edtDocumento.MaxLength := fTamDocCadRec();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  blnTabPrD := True;

  strUsaPreMat := fRetEmpresasUsamPrecoMatriz;
end;

Function TfrmAltPrecoFornecedorTabPrd.fUsaPrecoMatriz(strCodEmp: String): Boolean;
Begin
  Result := Pos(strCodEmp, strUsaPreMat) > 0;
End;

procedure TfrmAltPrecoFornecedorTabPrd.pCarregaComboExpressao;
Var
  intPosGlo: Integer;
  intPosExp: Integer;
begin

  intPosExp := 0;

  For intPosGlo := 0 To Length(arrCamposGlobal) - 1 Do
  Begin
    If (Pos('NUMERIC', arrCamposGlobal[intPosGlo].strTipCam) > 0) Then
    Begin
      SetLength(arrCamposExp, fSoma(intPosExp));
      arrCamposExp[(intPosExp - 1)].strNomCam := arrCamposGlobal[intPosGlo].strNomCam;
      arrCamposExp[(intPosExp - 1)].strDesCam := arrCamposGlobal[intPosGlo].strDesCam;
    End;
  End;

  cmbCampos.Clear;

  For intPosExp := 0 To Length(arrCamposExp) - 1 Do
  Begin
    cmbCampos.Items.Add(arrCamposExp[intPosExp].strDesCam);
  End;

  cmbCampos.ItemIndex := -1;

end;

function TfrmAltPrecoFornecedorTabPrd.fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
Begin
  intVal := intVal + intSoma;
  Result := intVal + 1;
End;


function TfrmAltPrecoFornecedorTabPrd.fRetornaNomeCampoExpressao(
  strDesCam: String): String;
Var
  intPosArr: Integer;
begin

  For intPosArr := 0 To Length(arrCamposExp) - 1 Do
  Begin
    If (arrCamposExp[intPosArr].strDesCam = strDesCam) Then
    Begin
      Result := arrCamposExp[intPosArr].strNomCam;
      Break;
    End;
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.chkNotEntClick(Sender: TObject);
begin
  inherited;

   If chkNotEnt.Checked Then
     pHabilitaNotaEntrada(True)
   Else
     pHabilitaNotaEntrada(False);

end;

procedure TfrmAltPrecoFornecedorTabPrd.cmbCamposChange(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(cmbCampos.Text)) Then
  Begin
    cmbOperad.ItemIndex := -1;
    edtValDig.Text      := '0.00';
    cmbOperad.Enabled   := False;
    edtValDig.Enabled   := False;
  End
  Else
  Begin
    cmbOperad.Enabled := True;
    edtValDig.Enabled := True;
  End;

end;

procedure TfrmAltPrecoFornecedorTabPrd.cxerDESF01EditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If DisplayValue <> '' Then
  Begin
    If Not blnAltPorFator Then
    Begin
      If (DisplayValue < 0) Or (DisplayValue > 100) Then
      Begin
        pMensagemOk('O valor deve estar entre 0 e 100!');
        DisplayValue := '';
      End;
    End
    Else If DisplayValue <= 0 Then
      DisplayValue := '';
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.cxerPRECOMEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
    If DisplayValue <> '' Then
      If blnAltPorFator Then
      Begin
        If (DisplayValue <= 0) Then
        Begin
          pMensagemOk('O valor deve ser maior que "0"!');
          DisplayValue := '';
        End;
      End
      Else If DisplayValue <= 0 Then
        DisplayValue := '';
end;

procedure TfrmAltPrecoFornecedorTabPrd.cxvAlteracaoABFCOFEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If DisplayValue <> '' Then
  begin
    edtCamAlt.Text := DisplayValue;
    edtCamAlt.Text := fStrZero(edtCamAlt.Text, 3);
    DisplayValue := edtCamAlt.Text;
    If fRetDesAbfCof(edtCamAlt.text) = '' then
    Begin
      fMensagem('','Abreviação de COFINS inválida!',['&OK']);
      DisplayValue := '';
    End;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.cxvAlteracaoABFPISEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If DisplayValue <> '' Then
  begin
    edtCamAlt.Text := DisplayValue;
    edtCamAlt.Text := fStrZero(edtCamAlt.Text, 3);
    DisplayValue := edtCamAlt.Text;
    If fRetDesAbfPis(edtCamAlt.text) = '' then
    Begin
      fMensagem('','Abreviação de PIS Inválida!',['&OK']);
      DisplayValue := '';
    End;
  End;
end;

procedure TfrmAltPrecoFornecedorTabPrd.cxvAlteracaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
    If cdsAltGlo.Locate('ITE_NOMCAM', arrCamposGlobal[cxvAlteracao.FocusedRow.Tag].strNomCam, []) Then
      edtCamAltKeyPress(Sender, Key);
  If Key = #13 Then
    cxvAlteracao.FocusRow(cxvAlteracao.NextVisibleRow(cxvAlteracao.FocusedRow));

end;

procedure TfrmAltPrecoFornecedorTabPrd.cxvAlteracaoPRDGRUEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If (DisplayValue <> '') Then
  begin
    edtCamAlt.Text := DisplayValue;
    edtCamAlt.Text := fStrZero(edtCamAlt.Text, 5);
    DisplayValue := edtCamAlt.Text;
    If fRetNomeGrupoProduto(edtCamAlt.text) = '' then
    Begin
      fMensagem('','Grupo de Produto Inválido!',['&OK']);
      DisplayValue := '';
    End;

  End

end;

End.
