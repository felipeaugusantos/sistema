unit untAltPrecoFornecedor;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, Menus, StrUtils, DB, AppEvnts,
  QColorLabel, UniDataSetProvider, UniClientDataSet, untFuncoesSimples, ComboBoxFocus,
  BitBtnLockedIncrem, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, Vcl.CheckLst;

type
  TfrmAltPrecoFornecedor = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    dbgTiposAlt: TDBGridCitel;
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
    rdgTipAltFor: TRadioGroup;
    grbGirGer: TGroupBox;
    chkGerA: TCheckBox;
    chkGerB: TCheckBox;
    chkGerC: TCheckBox;
    grbGirFor: TGroupBox;
    chkForA: TCheckBox;
    chkForB: TCheckBox;
    chkForC: TCheckBox;
    grpOpc: TGroupBox;
    rdgCamposVariaveisPorTabelaPreco: TRadioButton;
    rdbIguais: TRadioButton;
    Label13: TLabel;
    cmbTabPre: TComboBox;
    cdsAltGloPOR_TABELA: TStringField;
    procedure btnSairAltClick(Sender: TObject);
    procedure dbgTiposAltKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure dbgTiposAltDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
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
    procedure rdgCamposVariaveisPorTabelaPrecoClick(Sender: TObject);
    procedure rdbIguaisClick(Sender: TObject);
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

    strUsaPreMat: String;

    blnTabPrd,
    blnValPer: Boolean;
//    blnPreMat: Boolean;

    qryGenIte: TUniQuery;

    procedure pCarregaEmpresasAtivacao;
    Function fRetEmpresasAtivaco: String;

    Function fUsaPrecoMatriz(strCodEmp: String): Boolean;
    procedure plimpValuesCdsAltGlo;


    procedure pLimparTela;
    procedure pPrencheTabelaDePrecos;

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
    Function fBuscaPrecoVenda(strPreVen, strCodIte, strCodEmp: String): Double;

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
  frmAltPrecoFornecedor: TfrmAltPrecoFornecedor;

implementation

uses
  untConstantes,
  untPesqAux, untAltPrecoFornecedorItens, untConsultas, Math,
  untParCalculaPrecoCusto,  untTConfiguracao, untTypesSistema,
  untCalculaComposicaoCusto;

{$R *.dfm}

function TfrmAltPrecoFornecedor.fValidaCampos(Sender: TWinControl;
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

procedure TfrmAltPrecoFornecedor.pCarregaAbreviacao;
begin
  pPesquisaAbfIcm(qryAbfIcm, qryConAbf, edtCodAbr.Text);
  With qryConAbf Do
  Begin
    edtDesAbr.Text := FieldByName('ABF_DESABF').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedor.pEscapePressed;
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

procedure TfrmAltPrecoFornecedor.pGeraClient;
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
    Post;
  End;

  cdsAltGlo.First;
end;

procedure TfrmAltPrecoFornecedor.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedor.pCarregaLinGru;
begin
  pPesquisaLinGru(qryConGru, qryConGru, mskLinGru.Text);
  With qryConGru Do
  Begin
    edtDesGru.Text := FieldByName('GRU_DESGRU').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedor.pCarregaMarca;
begin
  pPesquisaCadMar(qryConMar, qryConMar, edtCodMar.Text);
  With qryConMar Do
  Begin
    edtDesMar.Text := FieldByName('MAR_DESMAR').AsString;
  End;
end;

procedure TfrmAltPrecoFornecedor.pAtribuiTabelas;
begin
  qryAbfIcm := fCriaQuery(Self);

  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConAbf := qryAbfIcm;
end;

procedure TfrmAltPrecoFornecedor.btnSairAltClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoFornecedor.dbgTiposAltKeyDown(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.pGravaValor(blnDesmarcar: Boolean = False);
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

procedure TfrmAltPrecoFornecedor.btnConfirmaAltClick(Sender: TObject);
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
    pSetFocus(dbgTiposAlt);
    lblCamAlt.Caption := '';
    edtCamAlt.Clear;
  End;
end;

procedure TfrmAltPrecoFornecedor.pCarregaInfoAlteracao;
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

procedure TfrmAltPrecoFornecedor.dbgTiposAltDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Not cdsAltGlo.Active Then
    Exit;

  With cdsAltGlo Do
  Begin

    If FieldByName('ITE_ALTERA').AsString = 'S' Then
      dbgTiposAlt.Canvas.Font.Color := clBlue;

  End;

  dbgTiposAlt.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmAltPrecoFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryGenIte);
  FreeAndNil(qryAbfIcm);

  FreeAndNil(cdsAltGlo);
  FreeAndNil(cdsIteGlo);
end;

procedure TfrmAltPrecoFornecedor.pDesmarcaCampo;
begin
  pGravaValor(True); //Grava em branco.
end;

procedure TfrmAltPrecoFornecedor.btnCancelaAltClick(Sender: TObject);
begin
  inherited;
  lblCamAlt.Caption := '';
  edtCamAlt.Clear;
  pSetFocus(dbgTiposAlt);
end;

procedure TfrmAltPrecoFornecedor.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If rdgCamposVariaveisPorTabelaPreco.Checked Then
    If cmbTabPre.Text = '' Then
    Begin
      fMensagem('', 'É necessário selecionar a tabela de preço que será alterada!', ['&O k']);
      pSetFocus(cmbTabPre);
      Exit;
    End;



  blnConfirma := False;

  Screen.Cursor := crHourGlass;

  btnConfirmaAlt.Enabled := False;
  btnConfirma.Enabled    := False;
  btnCancelaAlt.Enabled  := False;
  btnSairAlt.Enabled     := False;

  If cdsIteGlo.Active Then
    cdsIteGlo.EmptyDataSet;

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

      pCriarFormularios(TfrmAltPrecoFornecedorItens, frmAltPrecoFornecedorItens);
      frmAltPrecoFornecedorItens.intOpcAlt := rdgTipAltFor.ItemIndex;
      frmAltPrecoFornecedorItens.dtsItens.DataSet := cdsIteGlo;
      frmAltPrecoFornecedorItens.pCopiaCamposGrid(arrCamposGrid);
      frmAltPrecoFornecedorItens.blnTabPrD := blnTabPrD;

      If blnRecalculoGeral Then
      Begin
        frmAltPrecoFornecedorItens.pgbProBar   := pgbProBar;
        frmAltPrecoFornecedorItens.lblContador := lblContador;
        frmAltPrecoFornecedorItens.pAtualizaTabela;

        blnConfirma := frmAltPrecoFornecedorItens.fConfirma;
      End Else
      Begin
        frmAltPrecoFornecedorItens.showModal;
        blnConfirma := frmAltPrecoFornecedorItens.blnConfirma;
      End;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmAltPrecoGlobal.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmAltPrecoFornecedorItens);

  End;

  btnConfirmaAlt.Enabled := True;
  btnConfirma.Enabled    := True;
  btnCancelaAlt.Enabled  := True;
  btnSairAlt.Enabled     := True;
  Screen.Cursor          := crDefault;

  If blnConfirma Then
  Begin
    pLimparTela;
  End;
end;

function TfrmAltPrecoFornecedor.fTemCustoItem(strCodIte, strCodEmp, strCodTab: String; intTabPre: Integer;
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
      fltPreVen := qryIteger.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat * FieldByName('ITE_CNVCUS').AsFloat;
      fltMarBru := FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat;
    End
    Else If blnTabPrd Then
    Begin
      qryIteger.SQl.Clear;
      qryIteger.SQL.Text := 'SELECT * FROM DETCUS WHERE DET_SEQDET = "'+strAutIncDetCus+'" AND DET_TABELA = ' + intTabPre.ToString;
      qryIteger.Open;

      If Not IsEmpty Then
      Begin
        fltPreVen := FieldByName('DET_PREVEN').AsFloat;
        fltMarBru := FieldByName('DET_MARBRU').AsFloat;
      End;
    End;
    Close;
  End;

  FreeAndNil(qryIteger)
End;

Function TfrmAltPrecoFornecedor.fSQLCamposTabDet: String;
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

Function TfrmAltPrecoFornecedor.fSQLCampos: String;
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
         strSQL := strSQL + ' IFNULL((SELECT DET_'+ACampo+' FROM DETCUS WHERE DET_SEQDET = A.AUTOINCREM AND DET_TABELA = '+ATabela+'), A.ITE_'+ACampo+') AS ITE_' + AAlias + ATabela + ',';
         strSQL := strSQL + ' IFNULL((SELECT DET_'+ACampo+' FROM DETCUS WHERE DET_SEQDET = A.AUTOINCREM AND DET_TABELA = '+ATabela+'), A.ITE_'+ACampo+') AS ITE_' + AAlias + ATabela + '_NOV,';
      End
      Else
      Begin
        strSQL := strSQL + '  A.ITE_'+ACampo+' AS ITE_' + AAlias + ATabela + ', ';
        strSQL := strSQL + '  A.ITE_'+ACampo+' AS ITE_' + AAlias + ATabela + '_NOV, ';
      End
    End;

Begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + '  IF(A.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)  + ', 0, 1) AS ORDEMP, ';
  strSQL := strSQL + '  A.ITE_CODEMP, ';
  strSQL := strSQL + '  A.AUTOINCREM AS INCDET, ';
//  strSQL := strSQL + '  DC.DET_TABELA AS TABELA, ';

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

    strSQL := strSQL + '  A.ITE_PRECUS AS ITE_PRECUS' + IntToStr(intIndice) + ', ';
    strSQL := strSQL + '  A.ITE_PRECUS AS ITE_PRECUS' + IntToStr(intIndice) + '_NOV, ';

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
      strSQL := strSQL + '  A.' + qryGen.Fields[intIndice].FieldName + ', ';
      strSQL := strSQL + '  A.' + qryGen.Fields[intIndice].FieldName + ' AS "' + qryGen.Fields[intIndice].FieldName + '_NOV", ';
    End;


  strSQL := strSQL + '  F.ITE_CODFOR, ';
  strSQL := strSQL + '  F.ITE_CODTAB ';

  Result := strSQL;

  FreeAndNil(qryGen);
End;

Function TfrmAltPrecoFornecedor.fCriaTabelaItens: Boolean;
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
//    If blntabPrd Then
//      strSQL := strSQL + ' INNER JOIN DETCUS DC ON DET_SEQDET = A.AUTOINCREM ';




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

function TfrmAltPrecoFornecedor.fRetornaNumeric(strMascara: String): String;
  Var
    intPrecisao: Integer;
begin
  strMascara := AnsiReplaceStr(strMascara, '#', '');
  strMascara := AnsiReplaceStr(strMascara, ',', '');

  intPrecisao := Length(Copy(strMascara, Pos('.', strMascara)+1, Length(strMascara)));

  Result := 'NUMERIC(12, ' + IntToStr(intPrecisao) + ')';
end;

function TfrmAltPrecoFornecedor.fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
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
      CampoErro.strDesCam := 'Campo ' + strNomeCampo + ' não encontrado!';
      Result := CampoErro;
    End;
end;


function TfrmAltPrecoFornecedor.fCampoAlterado(strNomeCampo: String): Boolean;
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


Function TfrmAltPrecoFornecedor.fBuscaPrecoVenda(strPreVen, strCodIte, strCodEmp: String): Double;
Begin
  With cdsIteGlo Do
  Begin
    Result := 0;
    If Locate('ITE_CODEMP;ITE_CODITE', VarArrayOf([strCodEmp, strCodIte]), []) Then
    Begin
      Result := FieldByName(strPreVen).AsFloat;
    End

    Else Exception.Create('Não foi possível localizar o Item ' + strCodIte + '!');
  End;
End;

{******************************************}
{* GERA A TABELA TEMPORARIA COM OS CAMPOS *}
{* ALTERADOS E SEUS NOVOS VALORES         *}
{***************************************MV*}
function TfrmAltPrecoFornecedor.fGeraTabelaItens: Boolean;
  Var
    strSQL   : String;
    intTamMat: Integer;
    fltFatIpi: Double;
    fltPreVenNov,
    fltPreVen,
    fltMarBru: Double;

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

    function fPrecoVenda(intOpc, intTabPrc: Integer; fltMarBru, fltPreVen: Double): Double;
    begin

      If blnTabPrd Then
      Begin



        Result := fCalculaPrecoVenda(intOpc, fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS'+IntToStr(intTabPrc)+'_NOV').varValCam +
                                             fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                             fltPreVen,
                                             fltMarBru,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE'+IntToStr(intTabPrc)+'_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_COMTBL_NOV').varValCam);
      End
      Else
      Begin
        Result := fCalculaPrecoVenda(intOpc, fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS_NOV').varValCam,
                                             fltPreVen,
                                             fltMarBru,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_COMTBL_NOV').varValCam);

      End;
    end;


    procedure pNormatizaCustos(intTabPrc: integer);
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

      fltFatIcmSai := fCampoPorNome(arrCamposTabela, 'ITE_ICMSAI', False).varValCam;
      If fltFatIcmSai = 0 Then
        fltFatIcmSai := 1;

      fltFatOutVal := fCampoPorNome(arrCamposTabela, 'ITE_OUTVAL', False).varValCam;
      If fltFatOutVal = 0 Then
        fltFatOutVal := 1;

      fltFatDesOpe := fCampoPorNome(arrCamposTabela, 'ITE_DESOPE', False).varValCam;
      If fltFatDesOpe = 0 Then
        fltFatDesOpe := 1;

      fltFatImpFed := fCampoPorNome(arrCamposTabela, 'ITE_IMPFED', False).varValCam;
      If fltFatImpFed = 0 Then
        fltFatImpFed := 1;

      fltFatSubFed := fCampoPorNome(arrCamposTabela, 'ITE_SUBFED', False).varValCam;
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
        fltOutVal := CalculaComposicaoCusto.OutVal;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_OUTVAL', fltOutVal);

        If fCampoAlterado('ITE_OUTVAL') Then
        Begin
          If blnAltPorFator then
            fltOutVal := fltOutVal * fltFatOutVal
          Else
            fltOutVal := fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL_NOV').varValCam;
        End;

        fltDesOpe := CalculaComposicaoCusto.DesOpe;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_DESOPE', fltDesOpe);
        If fCampoAlterado('ITE_DESOPE') Then
        Begin
          If blnAltPorFator then
            fltDesOpe := fltDesOpe * fltFatDesOpe
          Else
            fltDesOpe := fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE_NOV').varValCam;

        End;

        fltIcmSai := CalculaComposicaoCusto.AliquotaICMSSai;
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMSAI', fltIcmSai);
        If fCampoAlterado('ITE_ICMSAI') Then
        Begin
          If blnAltPorFator then
            fltIcmSai := fltIcmSai * fltFatIcmSai
          Else
            fltIcmSai := fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI_NOV').varValCam;
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
        If rdgCamposVariaveisPorTabelaPreco.Checked Then
        Begin
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMENT_NOV', fltIcmEnt);
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_ICMSAI_NOV', fltIcmSai);
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_SUBSTI_NOV', fltSubsti);
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_DESOPE_NOV', fltDesOpe);
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_OUTVAL_NOV', fltOutVal);
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_SUBFED_NOV', fltSubFed);
          pAtualizaValorCampo(arrRegistroAtual, 'ITE_IMPFED_NOV', fltImpFed);
        End;


        pAdicionaCampoGrid('ITE_PRECUS'+strTabela);

        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS'+strTabela, fPrecoCusto(False, strTabela));
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS'+strTabela+'_NOV', fPrecoCusto(True, strTabela, fltSubsti, fltSubFed, fltIcmEnt, fltIpiEnt));
        pAdicionaCampoGrid('ITE_CUSREA'+strTabela);
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA'+strTabela, fPrecoCustoReal(False, strTabela));
        pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA'+strTabela+'_NOV', fPrecoCustoReal(True, strTabela, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal, fltSubsti, fltSubFed, fltIcmEnt, fltIpiEnt));
      Finally
        FreeAndNil(CalculaComposicaoCusto);
      End;
    End;

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

    If blnTabPrd Then
      strSQL := strSQL + ' AND A.ITE_CODEMP IN (' + fRetEmpresasAtivaco + ')  '
    Else
      strSQL := strSQL + ' AND A.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + ' INNER JOIN TABPRE   ON TAB_CODTAB = F.ITE_CODTAB ';
    If blntabPrd Then
    Begin
      strSQL := strSQL + ' INNER JOIN DETCUS DC ON DET_SEQDET = A.AUTOINCREM ';
      If cmbTabPre.Text <> '' Then
        strSQL := strSQL + '  AND DET_TABELA = ' + cmbTabPre.Text;
    End;



    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + '  TRUE ';


//    If cmbTabPre.Text <> '' Then
//      strSQL := strSQL + '  AND DC.DET_TABELA = '+ cmbTabPre.Text + ' ';
//      strSQL := strSQL + '  AND G.ITE_TABPR'+ cmbTabPre.Text + ' = A.ITE_CODTAB ';



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
        strSQL := strSQL + '  AND I.ITE_CODABF = :CODABF '
      Else
        strSQL := strSQL + '  AND G.ITE_CODABF = :CODABF '
    End;

    If Not fEmptyStr(edtClaIPI.Text) Then
    Begin
      strSQL := strSQL + '  AND LEFT(I.ITE_CLAIPI,'+IntToStr(Length(edtClaIPI.Text))+') = :CLAIPI ';
    End;

    If Not fEmptyStr(cmbCampos.Text) Then
      strSQL := strSQL + 'AND ' + fRetornaNomeCampoExpressao(cmbCampos.Text) + ' ' + cmbOperad.Text + ' :VALDIG ';

  //  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP ';

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

    If blnTabPrd Then
    Begin
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
          arrRegistroAtual[intTamMat].strNomCam := Fields[intContador].FieldName;
          arrRegistroAtual[intTamMat].varValCam := qryGenIte.Fields[intContador].Value;

          If (Fields[intContador].DataType = ftString) Then
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'VARCHAR';
          End
          Else
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'NUMERIC';
          End;

          If arrRegistroAtual[intTamMat].varValCam = Null Then
          Begin
            If (Fields[intContador].DataType = ftString) Then
            Begin
              arrRegistroAtual[intTamMat].varValCam := ''
            End
            Else
            Begin
              arrRegistroAtual[intTamMat].varValCam := 0.0;
            End;
          End;

        End;

        intTamMat := Length(arrCamposTabela);

        intContador := 0;
        fltFatIpi := 1;
        While intContador < intTamMat Do
        Begin

          strCamAtu := arrCamposTabela[intContador].strNomCam;

          If blnRecalculoGeral And (strCamAtu = 'ITE_PRECOM') Then
            varValAtu := 1
          Else
            varValAtu := arrCamposTabela[intContador].varValCam;

          pAdicionaCampoGrid(strCamAtu);

          If blnAltPorFator And (strCamAtu = 'ITE_IPIENT') Then
            fltFatIpi := arrCamposTabela[intContador].varValCam;

          varValorRegAtual := fCampoPorNome(arrRegistroAtual, strCamAtu + '_NOV').varValCam;

          {*****************************************}
          {* RECALCULA PREÇO DE COMPRA             *}
          {**************************************MV*}
          If blnAltPorFator And (strCamAtu = 'ITE_PRECOM') Then
          Begin
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECOM_NOV', varValorRegAtual * varValAtu);
          End Else
          Begin
           If blnAltPorFator And (Pos(strCamAtu, 'ITE_VALFRE_TFO_PRDGRU_ITE_ABFCOF_ITE_ABFPIS') = 0)  Then
             pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValorRegAtual * varValAtu)
           Else
             pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);
          End;

          If Pos(strCamAtu, 'ITE_PRECOM_ITE_DESF01_ITE_DESF02_ITE_DESF03_ITE_DESF04_' +
                            'ITE_DESF05_ITE_DESF06_') > 0 Then
          Begin
            pAdicionaCampoGrid('ITE_COMLIQ');
            pAdicionaCampoGrid('ITE_PRECUS');
            If not blnTabPrd Then
              pAdicionaCampoGrid('ITE_CUSREA');

            pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS_NOV', fPrecoCusto(True, ''));
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMLIQ_NOV', fPrecoCompraLiquido(True));
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA_NOV', fPrecoCustoReal(True, ''));

            pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMLIQ', fPrecoCompraLiquido(False));
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA', fPrecoCustoReal(False, ''));
          End

          Else If Pos(strCamAtu, 'ITE_ICMENT_ITE_SUBFED_ITE_IPIENT_' +
                                 'ITE_FREENT_ITE_VALFRE_ITE_ACRFIN_ITE_SUBSTI_ITE_DESADB_' +
                                 'ITE_TCIFCU_ITE_TSCUST_ITE_DEPICO_ITE_DEICMS_ITE_FATREG_') > 0 Then
          Begin
            pAdicionaCampoGrid('ITE_PRECUS');
            If not blnTabPrd Then
              pAdicionaCampoGrid('ITE_CUSREA');


            pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS_NOV', fPrecoCusto(True, ''));
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA_NOV', fPrecoCustoReal(True));

            pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA', fPrecoCustoReal(False));
          End

          Else If Pos(strCamAtu, 'ITE_OUTVAL_ITE_ICMSAI_ITE_IMPFED_ITE_DESOPE') > 0 Then
          Begin
            If not blnTabPrd Then
              pAdicionaCampoGrid('ITE_CUSREA');
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA_NOV', fPrecoCustoReal(True));

            pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA', fPrecoCustoReal(False));
          End;

          If blnTabPrd And (Pos(strCamAtu, STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR) > 0) Then
          Begin

            For intIndice := 1 To Length(VS_strTabPrc) Do
              If (VS_strTabPrc[intIndice] = 'S') And
                 (IIf(cmbTabPre.Text <> '', intIndice.ToString = cmbTabPre.Text, True)) Then
              Begin

                If fTemCustoItem(FieldByName('ITE_CODITE').AsString,
                               FieldByName('ITE_CODEMP').AsString,
                               FieldByName('ITE_CODTAB').AsString,
                               intIndice,
                               fltPreVen, fltMarBru,
                               qryGenIte.FieldByName('INCDET').AsString) Then
                  pAtualizaValorCampo(arrRegistroAtual,
                                      'UPDATE_ITEGER' + IntToStr(intIndice),
                                      'S');


                pNormatizaCustos(intIndice);

                // CALCULA PREÇO DE VENDA
                If rdgTipAltFor.ItemIndex = 0 Then
                Begin

                  If (VS_strCodEmp = FieldByName('ITE_CODEMP').AsString) Or (Not fUsaPrecoMatriz(FieldByName('ITE_CODEMP').AsString)) Then
                  Begin // CALCULA PREÇO DE VENDA




                    pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice));
                    pAtualizaValorCampo(arrRegistroAtual,
                                        'ITE_MARBR' + IntToStr(intIndice),
                                        fltMarBru);

                    pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice) + '_NOV');

                    pAtualizaValorCampo(arrRegistroAtual,
                                        'ITE_MARBR' + IntToStr(intIndice) + '_NOV',
                                        fltMarBru);

                    pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intIndice));

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice) + '_NOV',
                                        fPrecoVenda(1, intIndice, fltMarBru, fltPreVen));

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice),
                                        fltPreVen);

                  End Else
                  Begin // COPIA PREÇO DE VENDA DA MATRIZ E CALCULA A MARGEM
                    pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice));
                    pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice) + '_NOV');

                    pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intIndice));

                    fltPreVenNov := fBuscaPrecoVenda('ITE_PREVE' + IntToStr(intIndice) + '_NOV',
                                                     FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice) + '_NOV',
                                        fltPreVenNov);

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice),
                                        fltPreVen);

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice) + '_NOV',
                                        fPrecoVenda(2, intIndice, fltMarBru, fltPreVenNov));
                  End;

                End Else
                // CALCULA MARGEM
                Begin
                  pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice));

                  pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice) + '_NOV',
                                      fPrecoVenda(2, intIndice, fltMarBru, fltPreVen));

                  pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice),
                                      fltMarBru);


                  If blnTabPrd Then
                  Begin
                    fltPrecus:= fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS' + IntToStr(intIndice)).varValCam/qryGenIte.FieldByName('ITE_CNVCUS').AsFloat;
                    fltPrecusNov:= fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS' + IntToStr(intIndice) + '_NOV').varValCam/qryGenIte.FieldByName('ITE_CNVCUS').AsFloat;

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS' + IntToStr(intIndice),fltPrecus);
                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS' + IntToStr(intIndice) + '_NOV',fltPrecusNov);

                    fltPrecus:= fCampoPorNome(arrRegistroAtual, 'ITE_CUSREA' + IntToStr(intIndice)).varValCam/qryGenIte.FieldByName('ITE_CNVCUS').AsFloat;
                    fltPrecusNov:= fCampoPorNome(arrRegistroAtual, 'ITE_CUSREA' + IntToStr(intIndice) + '_NOV').varValCam/qryGenIte.FieldByName('ITE_CNVCUS').AsFloat;

                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA' + IntToStr(intIndice),fltPrecus);
                    pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSREA' + IntToStr(intIndice) + '_NOV',fltPrecusNov);
                  End;

                End;

              End;

          End;

          pgbProBar.StepBy(1);
          Inc(intContador);

          If Assigned(lblContador) Then
          Begin
            inc(intContReg);
            lblContador.Caption :=  IntToStr(intContReg) + ' / ' + IntToStr(pgbProBar.Max);
          End;

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

procedure TfrmAltPrecoFornecedor.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
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

function TfrmAltPrecoFornecedor.fGeraVetorCampos: Boolean;
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

      If ((Pos('ITE_PREVE', cdsAltGlo.FieldByName('ITE_NOMCAM').AsString) > 0) And (rdgTipAltFor.ItemIndex = 0)) Or
         ((Pos('ITE_MARBR', cdsAltGlo.FieldByName('ITE_NOMCAM').AsString) > 0) And (rdgTipAltFor.ItemIndex = 1)) Then
      Begin
        Edit;
        FieldByName('ITE_ALTERA').AsString :=  'S';
        Post;
      End;

      If blnRecalculoGeral And (FieldByName('ITE_NOMCAM').AsString = 'ITE_PRECOM') Then
      Begin
        Edit;
        FieldByName('ITE_ALTERA').AsString :=  'S';
        Post;
      End;

      If (FieldByName('ITE_ALTERA').AsString <> 'S') Then
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

procedure TfrmAltPrecoFornecedor.pAlteraValorTabelaItens(strCodIte: String;
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

        If ((Pos('ITE_PREVE', arrCampos[intContador].strNomCam) > 0) Or
            (Pos('ITE_MARBR', arrCampos[intContador].strNomCam) > 0)) And
           (FieldByName(arrCampos[intContador].strNomCam).AsFloat = 0) Then
          FieldByName(arrCampos[intContador].strNomCam).Clear;
      End

      Else If FieldByName(arrCampos[intContador].strNomCam).DataType In [ftInteger, ftSmallint, ftWord] Then
        FieldByName(arrCampos[intContador].strNomCam).AsInteger := Trunc(fStrToFloat(arrCampos[intContador].varValCam));

      Inc(intContador);
    End;

    Post;
  End;
end;

procedure TfrmAltPrecoFornecedor.mskLinGruKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.edtCodUniKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.edtCodMarKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrSel) Then
  Begin
    If (not blnNomFor) Or fValidaCampos(edtCodFor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoFornecedor.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If edtCodFor.Enabled Then
    pedtCodForKeyPre(edtCodFor,key,TRUE);
end;

procedure TfrmAltPrecoFornecedor.edtCamAltKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.pCodForKeyPress;
  Var
    chrKey: Char;
Begin
  chrKey := '?';
  pedtCodForKeyPre(edtCamAlt,chrKey,FALSE);
End;

procedure TfrmAltPrecoFornecedor.pCodGprKeyPress;
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

procedure TfrmAltPrecoFornecedor.pCodAbfKeyPress;
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

procedure TfrmAltPrecoFornecedor.pCodAbfPisPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqPISSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedor.pCodAbfCofPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqCOFSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedor.pCodAbfIPIPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqIPISAI(Self, edtCamAlt, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedor.pCodMarcaKeyPress;
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

procedure TfrmAltPrecoFornecedor.pCodSituacaoKeyPress;
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

procedure TfrmAltPrecoFornecedor.pCodMontadoraKeyPress;
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

procedure TfrmAltPrecoFornecedor.pCodUnidadeKeyPress;
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

procedure TfrmAltPrecoFornecedor.pCodGrupoKeyPress(var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, edtCamAlt, nil, nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmAltPrecoFornecedor.dbgTiposAltDblClick(Sender: TObject);
  Var
    Key: Word;
    State: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgTiposAltKeyDown(Sender, Key, State);
end;

procedure TfrmAltPrecoFornecedor.FormShow(Sender: TObject);
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

  If blnTabPrd Then
  Begin
    pCarregaEmpresasAtivacao;
    rdbIguais.Checked := True;
  End
  Else
  Begin
    pnlCabecalho.Height := pnlCabecalho.Height - grpOpc.Height;
    grpOpc.Visible := False;
  End;
end;

procedure TfrmAltPrecoFornecedor.pCarregaEmpresasAtivacao;
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

Function TfrmAltPrecoFornecedor.fRetEmpresasAtivaco: String;
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

procedure TfrmAltPrecoFornecedor.edtDesIteKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.edtForNotExit(Sender: TObject);
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

procedure TfrmAltPrecoFornecedor.edtForNotKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmAltPrecoFornecedor.edtTabPreKeyPress(Sender: TObject;
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

function TfrmAltPrecoFornecedor.fTamanhoCampo(strCampo: String): Boolean;
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

procedure TfrmAltPrecoFornecedor.edtCodAbrKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.pMontaGrid;
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

  {******************************************}
  {* CARREGA MATRIZ COM OS CAMPOS QUE PODEM *}
  {* SER ALTERADOS                          *}
  {***************************************JB*}
  intPosMat := -1;
  SetLength(arrCamposGlobal, 0);

//  If Not blnPreMat Then
  Begin
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

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 02';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF02';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 02';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 03';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF03';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 03';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 04';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF04';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 04';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 05';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF05';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 05';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 06';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF06';
    arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 06';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    If not blnTabPrd Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := '% ICMS Entrada';
      arrCamposGlobal[intPosMat].varValCam := 0.0;
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMENT';
      arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Entrada';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais (-)';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBFED';
    arrCamposGlobal[intPosMat].strDesAbr := '% Imp. Federais (-)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% IPI de Entrada';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPIENT';
    arrCamposGlobal[intPosMat].strDesAbr := '% IPI Entrada';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';


    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Frete de Entrada';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_FREENT';
    arrCamposGlobal[intPosMat].strDesAbr := '% Frete Entrada';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DESVFR');
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_VALFRE';
    arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DESVFR');
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Acréscimo Financeiro';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ACRFIN';
    arrCamposGlobal[intPosMat].strDesAbr := '% Acresc.Financ.';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';

    If not blnTabPrd Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := '% Substituição Tributária';
      arrCamposGlobal[intPosMat].varValCam := 0.0;
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBSTI';
      arrCamposGlobal[intPosMat].strDesAbr := '% Subst. Tributária';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';;
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESADB';
    arrCamposGlobal[intPosMat].strDesAbr := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';;
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
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


    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% Despesas Operacionais';
    arrCamposGlobal[intPosMat].strDesAbr := '% Despesas Oper.';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESOPE';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% ICMS de Saída';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMSAI';
    arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Saída';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';


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

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DOVCPP') + ' (+)';
    arrCamposGlobal[intPosMat].varValCam := 0.0;
    arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_OUTVAL';
    arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DOVCPP') + ' (+)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'TABDET';
    arrCamposGlobal[intPosMat].strPorTabela := 'S';


    If blnTabPrd Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Grupo de Produto';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'TFO_PRDGRU';
      arrCamposGlobal[intPosMat].strDesAbr := 'Grupo de Produto';
      arrCamposGlobal[intPosMat].intLimCam := 5;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(05)';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEFOR';

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
    End;
  End;

  pGeraClient;

  {***********************************************************************************}
  {* PREÇO DE CUSTO                                                                  *}
  {* ESTE CAMPO DEVE SER CRIADO APÓS AS ATUALIZAÇÕES ACIMA PARA NÃO APARECER NO GRID *}
  {********************************************************************************LU*}

  If blnTabPrd Then
  Begin
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
      arrCamposGlobal[intPosMat].strDesCam := 'Custo Real' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].varValCam := 0.0;
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CUSREA' + IntToStr(intTabPre);
      arrCamposGlobal[intPosMat].strDesAbr := 'Custo Real' + IntToStr(intTabPre);;
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
  arrCamposGlobal[intPosMat].strDesCam := 'Preço Compra Líquido';
  arrCamposGlobal[intPosMat].varValCam := 0.0;
  arrCamposGlobal[intPosMat].strMasCam := strMasFat;
  arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMLIQ';
  arrCamposGlobal[intPosMat].strDesAbr := 'Preço Compra Líq.';
  arrCamposGlobal[intPosMat].intLimCam := 12;
  arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
  arrCamposGlobal[intPosMat].strNomArq := '';

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

  If blnTabPrd Then
  Begin
    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
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
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      Begin
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
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;
    End;

  End;

end;

procedure TfrmAltPrecoFornecedor.pPrdGruKeyPress;
  var
    arrSel : TConsultasArray;
    chrKey: Char;
begin
  chrKey := '/';
  If fPesqGrupoProduto(Self, edtCamAlt, nil, nil, chrKey, arrSel, True,edtCodFor.Text) Then
  Begin
    if fvalidaCampos(edtCamAlt,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoFornecedor.rdgCamposVariaveisPorTabelaPrecoClick(
  Sender: TObject);
begin
  inherited;
  If rdgCamposVariaveisPorTabelaPreco.Checked then
  Begin
    cmbTabPre.Enabled := True;
    cmbTabPre.Text := '';

    cdsAltGlo.Filtered := False;
    cdsAltGlo.Filter := 'POR_TABELA = ' + QuotedStr('S');
    cdsAltGlo.Filtered := True;

    plimpValuesCdsAltGlo;

  End;
end;

procedure TfrmAltPrecoFornecedor.plimpValuesCdsAltGlo;
begin
  cdsAltGlo.First;
  cdsAltGlo.First;
  while not cdsAltGlo.Eof Do
  Begin
    cdsAltGlo.Edit;
    cdsAltGloITE_VALCAM.Clear;
    cdsAltGlo.Post;
    cdsAltGlo.Next;
  End;

end;


procedure TfrmAltPrecoFornecedor.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmAltPrecoFornecedor.edtClaIPIKeyPress(Sender: TObject;
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

procedure TfrmAltPrecoFornecedor.pHabilitaNotaEntrada(blnHabilitar: Boolean);
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

procedure TfrmAltPrecoFornecedor.pLimparTela;
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
    fValidaCampos(frmAltPrecoFornecedor.edtTabPre, True);
  End;

  mskLinGru.Clear;
  chkNotEnt.Checked := False;
  edtStatus.Text    := 'T';
  pHabilitaNotaEntrada(False);
  pGeraClient;

  pMontaGrid;

  Self.SelectFirst;
end;

procedure TfrmAltPrecoFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAltGlo.CreateDataSet;
  edtCodAbr.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  strTabFix := '';
  blnRecalculoGeral := False;
  intDecUni := fCfgSis('DECUNI', varInteger);
  pgbProBar := pgbProgresso;

  edtDocumento.MaxLength := fTamDocCadRec();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  blnTabPrD := fCfgSis('TABPRD', varBoolean);

  strUsaPreMat := fRetEmpresasUsamPrecoMatriz;

  If Not blnTabPrD Then
  Begin
    pnlTipoAlteracao.Visible := False;
    pnlEmpresas.Visible := False;
    pnlCabecalho.Height := pnlCabecalho.Height - pnlEmpresas.Height;
  End;


  pPrencheTabelaDePrecos;
end;

procedure TfrmAltPrecoFornecedor.pPrencheTabelaDePrecos;
var i : integer;
Begin
  cmbTabPre.Items.Clear;
  cmbTabPre.Items.Add('');
  For i := 1 To 7 Do
  Begin
    If VS_strTabPrc[i] = 'S' Then
      cmbTabPre.Items.Add(i.ToString);
  End;
End;

procedure TfrmAltPrecoFornecedor.rdbIguaisClick(Sender: TObject);
begin
  inherited;
  If Not grpOpc.Visible Then
    Exit;

  cmbTabPre.Enabled := False;
  cmbTabPre.ItemIndex := 0;
  cdsAltGlo.Filtered := False;
  cdsAltGlo.Filter := 'POR_TABELA = ' + QuotedStr('N');
  cdsAltGlo.Filtered := True;
  plimpValuesCdsAltGlo;
end;

Function TfrmAltPrecoFornecedor.fUsaPrecoMatriz(strCodEmp: String): Boolean;
Begin
  Result := Pos(strCodEmp, strUsaPreMat) > 0;
End;

procedure TfrmAltPrecoFornecedor.pCarregaComboExpressao;
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

function TfrmAltPrecoFornecedor.fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
Begin
  intVal := intVal + intSoma;
  Result := intVal + 1;
End;


function TfrmAltPrecoFornecedor.fRetornaNomeCampoExpressao(
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

procedure TfrmAltPrecoFornecedor.chkNotEntClick(Sender: TObject);
begin
  inherited;

   If chkNotEnt.Checked Then
     pHabilitaNotaEntrada(True)
   Else
     pHabilitaNotaEntrada(False);

end;

procedure TfrmAltPrecoFornecedor.cmbCamposChange(Sender: TObject);
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

end.



