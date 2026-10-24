unit untCadTabelaPrecos;

interface

uses
  Windows, Classes, Controls, Uni,
  untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  DBCtrls, DBEditFocus, untTabelaPreco,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Mask, frxClass,
  frxExportCSVTestabilidade, Vcl.Dialogs,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTypesSistema, cxTextEdit, winapi.messages,
  untTypesTabelaPreco;

type
  TfrmCadTabelaPrecos = class(TfrmPaiCad)
    pnlDados: TPanel;
    pnlCabecalho: TPanel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    Label1: TLabel;
    dbeCodTab: TDBEditFocus;
    lbl3: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label4: TLabel;
    dbeNomTab: TDBEditFocus;
    Label7: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    dbcAtiCmp: TDBCheckBox;
    dtsTabela: TDataSource;
    cxgItensViewCodIte: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensViewPreCus: TcxGridDBColumn;
    SpeedButton1: TSpeedButton;
    btnIncluirItem: TSpeedButton;
    btnAlterarItem: TSpeedButton;
    btnExcluirItem: TSpeedButton;
    Panel2: TPanel;
    btnSelItens: TSpeedButton;
    pnlBotoesItens: TPanel;
    btnHeranca: TBitBtnLocked;
    btnExpExcel: TBitBtnLocked;
    btnPesPro: TBitBtnLocked;
    opdTextFile: TOpenDialog;
    btnImpArq: TSpeedButton;
    cxgItensViewColumn2: TcxGridDBColumn;
    pnlDtaEfe: TPanel;
    Label2: TLabel;
    dbeDtaEfe: TDBEditFocus;
    cxgItensViewPreDol: TcxGridDBColumn;
    btnInfLay: TSpeedButton;
    frxHelp: TfrxReport;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnAltGlobalCadastro: TSpeedButton;
    btnAltGlobalPrecos: TSpeedButton;
    cxgItensViewPRINC: TcxGridDBColumn;
    btnTabRel: TBitBtnLocked;
    btnAltGloFor: TBitBtnLocked;
    Label3: TLabel;
    bdeDesTab: TDBEditFocus;
    cxgItensViewREFERE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure btnAlterarItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSelItensClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure btnExpExcelClick(Sender: TObject);
    procedure btnPesProClick(Sender: TObject);
    procedure btnImpArqClick(Sender: TObject);
    procedure btnInfLayClick(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAltGlobalPrecosClick(Sender: TObject);
    procedure btnAltGlobalCadastroClick(Sender: TObject);
    procedure btnTabRelClick(Sender: TObject);
    procedure btnAltGloForClick(Sender: TObject);
  private
    { Private declarations }
    FCodIte,
    strTAB_ATICMP_Original: String;
    objTabPre: TTabelaPreco;
    blnAtiAnt: Boolean;
    blnAtivouTabela: Boolean;

    procedure pHabilitaItens(blnHabilita: Boolean = True);
    procedure pCarregaDadosAdicionais;
    procedure qryTabelaAfterOpen(DataSet : TDataSet);
    function fLiberaAtivaCompra: Boolean;

    Procedure pTelaItem(opcAlteracao: TopcAltPre);
    Procedure pAlteraItem;
    Procedure pSelecionaItens(strNomArq : String = ''; strCodFor : String = '');

  public
    class procedure pAbreTela(strCodIte : String);
    procedure msgCancelouAtivacaoTabela(var Msg: TMessage); message WM_CANCELOU_OPE_DLL;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untConsultas,  untMsgLiberacao, untLiberacao,
  untCadTabelaPrecosItem, untFuncoesRel, untFuncoesRel2, untComparaTabPre, untDllOpeProd, untDllOpeProdFuncoes,
  untPesqTabPreProduto;

{$R *.dfm}

procedure TfrmCadTabelaPrecos.btnAlterarClick(Sender: TObject);
begin
  inherited;

  blnAtiAnt := dbcAtiCmp.Checked;

  dbeCodFor.Enabled := False;

  pHabilitaCodigo(dbeCodTab, dbeNomTab, False);
  pHabilitaItens;

end;

procedure TfrmCadTabelaPrecos.btnAlterarItemClick(Sender: TObject);
begin
  inherited;

  pAlteraItem;
end;

procedure TfrmCadTabelaPrecos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objTabPre.blnIncluindoTabela := False;
  objTabPre.pCancela;
  objTabPre.fCarregaItens(dbeCodTab.Text, dbeCodFor.Text);
  objTabPre.strCodForDef := dbeCodFor.Text;
  pCarregaDadosAdicionais;
  pHabilitaItens(False);
  btnHeranca.Enabled := False;
end;

procedure TfrmCadTabelaPrecos.btnGravarClick(Sender: TObject);
var
  blnForcarDesmarcacao,
  blnDesTravado: Boolean;
  strCfgPERDFA: String;
  blnAtivandoTabela, blnChackAtivoInicial, blnResult: Boolean;
  blnAlterouAtivoCompra: Boolean;
begin
  blnDesTravado := False;
  cxgItensView.DataController.Filter.Clear;

  If objTabPre.IsEmpty Then
  Begin
    pMensagemOk('Informe os itens para da Tabela de Preço!');
    Exit;
  End;

  If Not objTabPre.fComparaPrecos Then
  Begin
    Exit;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  blnChackAtivoInicial := dbcAtiCmp.Checked;
  blnAlterouAtivoCompra := blnChackAtivoInicial <> blnAtiAnt;
  Try
    blnAtivandoTabela := (blnAtiAnt <> blnChackAtivoInicial) And blnChackAtivoInicial;
    strCfgPERDFA := fCfgSis('PERDFA');
    If blnAlterouAtivoCompra and (Not blnChackAtivoInicial)  Then
    Begin
      If (strCfgPERDFA = 'L') And  (Not objTabPre.blnIncluindoTabela) Then
        blnDesTravado := fLiberaAtivaCompra
      Else
      If strCfgPERDFA = 'S' Then
        blnDesTravado := True
      Else
      If strCfgPERDFA = 'N' Then
        blnDesTravado := False;

      If blnAtivandoTabela And (not blnDesTravado) and blnChackAtivoInicial then
      begin
         dbcAtiCmp.Field.AsString := 'N';
         dbcAtiCmp.Checked := False;
      End;
    End;

    inherited;

    If (Not blnChackAtivoInicial) And (blnDesTravado) And (strTAB_ATICMP_Original = 'S') Then
      blnForcarDesmarcacao := (strTAB_ATICMP_Original <> qryTabela.FieldByName('TAB_ATICMP').AsString)
    Else
      blnForcarDesmarcacao := blnDesTravado;
    blnResult := blnGravou;

    If Not objTabPre.blnTabPrd Then
       If (not blnAlterouAtivoCompra) Then
        If (not blnDesTravado)  Then
          blnForcarDesmarcacao := True;

    blnResult := blnResult and objTabPre.fAjustaAtivaCompras(qryTabela, blnForcarDesmarcacao);

    If blnResult And
       objTabPre.fSalvaItens(dbeCodTab.Text, dbeCodFor.Text) then
    Begin
      fCommit;
      objTabPre.fCarregaItens(qryTabela.FieldByName('TAB_CODTAB').AsString,
                              qryTabela.FieldByName('TAB_CODFOR').AsString);

      pHabilitaItens(False);
      btnHeranca.Enabled := False;


      If objTabPre.blnTabPrD And (blnAtiAnt <> dbcAtiCmp.Checked) And dbcAtiCmp.Checked Then
        pOpeProd(AtivacaoTabelaPreco, dbeCodTab.Text);

      objTabPre.blnIncluindoTabela := False;
      objTabPre.fCarregaItens(qryTabela.FieldByName('TAB_CODTAB').AsString,
                              qryTabela.FieldByName('TAB_CODFOR').AsString);

      pHabilitaItens(False);
      btnHeranca.Enabled := False;

    End Else
    Begin
      fRollBack;
    End;


  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTabelaPrecos.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadTabelaPrecos.btnAltGlobalCadastroClick(Sender: TObject);
begin
  inherited;

  pTelaItem(opcGlobalComuns);
end;

procedure TfrmCadTabelaPrecos.btnAltGlobalPrecosClick(Sender: TObject);
begin
  inherited;

  pTelaItem(opcGlobalPreco);
end;

procedure TfrmCadTabelaPrecos.btnAltGloForClick(Sender: TObject);
begin
  inherited;

  If btnCancela.Enabled Then
  Begin
    btnCancela.Click;

    If (qryTabela.State In [dsInsert, dsEdit]) Or qryTabela.IsEmpty Then
      Exit;

  End;

  If qryTabela.IsEmpty Then
  Begin
    pMensagemOk('Selecione uma Tabela de Preço para alteração!');
    Exit;
  End;

  pOpeProd(AltPrecoGlobalFornecedor, qryTabela.FieldByName('TAB_CODTAB').AsString);

  objTabPre.fCarregaItens(dbeCodTab.Text, dbeCodFor.Text);
  pCarregaDadosAdicionais;

end;

procedure TfrmCadTabelaPrecos.btnHerancaClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeCodFor.Text) Then
  Begin
    pMensagemOk('Informe o fornecedor!');
    pSetFocus(dbeCodFor);
    Exit;
  End;

  If fEmptyStr(dbeNomTab.Text) Then
  Begin
    pMensagemOk('Informe a Descrição!');
    pSetFocus(dbeNomTab);
    Exit;
  End;

  If objTabPre.fHerancaTabela(qryTabela,dbeCodFor.Text, dbeNomTab.Text) Then
  Begin
    btnGravar.Click;

    pMensagemOk('Tabela ' + dbeCodTab.Text + ' incluída com sucesso!');
  End;
end;

procedure TfrmCadTabelaPrecos.pHabilitaItens(blnHabilita: Boolean = True);
Begin
  pnlBotoesItens.Enabled := blnHabilita;
  cxgItens.Enabled       := blnHabilita;
  If blnhabilita Then
    dbcAtiCmp.Enabled      := Not (fCfgSis('PERDFA', varString) = 'N');
End;

procedure TfrmCadTabelaPrecos.btnImpArqClick(Sender: TObject);
begin
  inherited;
  If not btnImpArq.Enabled Then Exit;
  If not pnlBotoesItens.Enabled Then Exit;

  If dbeCodFor.Text = '' Then
  Begin
    pMensagemOk('O Fornecedor precisa ser definida!');
    Exit;
  End;

  objTabPre.strCodForDef := dbeCodFor.Text;
  if opdTextFile.Execute then
    pSelecionaItens(opdTextFile.FileName, dbeCodFor.Text);
end;

procedure TfrmCadTabelaPrecos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  blnAtiAnt := False;
  objTabPre.blnIncluindoTabela := True;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTab, dbeNomTab, False)
  Else
    pHabilitaCodigo(dbeCodTab, dbeNomTab, True);

  strTAB_ATICMP_Original := '';
  qryTabela.FieldByName('TAB_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('TAB_ATICMP').AsString   := 'N';
  qryTabela.FieldByName('TAB_DTAEFE').AsDateTime := VS_Date;

  pCarregaDadosAdicionais;
  objTabPre.fCarregaItens('', '');

  pHabilitaItens;

  btnHeranca.Enabled := True;
  If fCfgSis('PERDFA') = 'N' then
  Begin
    dbcAtiCmp.Field.AsString := 'S';
    dbcAtiCmp.Checked := True;
  End;
end;

procedure TfrmCadTabelaPrecos.btnIncluirItemClick(Sender: TObject);
begin
  inherited;
  pTelaItem(opcIncluiItem);
  If objTabPre.blnIncluindoTabela Then
    dbeCodFor.Enabled := cxgItensView.DataController.DataSource.DataSet.IsEmpty
end;

procedure TfrmCadTabelaPrecos.btnInfLayClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmCadTabelaPrecos.btnPesProClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(134, 6187, [],
                        ['CODITE'],
                        [FCodite],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmCadTabelaPrecos.btnPesquisaClick(Sender: TObject);
  Var
    arrTabela : TConsultasArray;
    chrKey   : Char;
begin
  inherited;
  chrKey := '/';
  If fPesqTabelaPreco(Self, Nil, Nil, qryTabela, chrKey, arrTabela) Then
  Begin
    objTabPre.fCarregaItens(qryTabela.FieldByName('TAB_CODTAB').AsString,
                            qryTabela.FieldByName('TAB_CODFOR').AsString);
    pCarregaDadosAdicionais;

    pSetFocus(btnAlterar);

    strTAB_ATICMP_Original := qryTabela.FieldByName('TAB_ATICMP').AsString;
  End;
end;

procedure TfrmCadTabelaPrecos.btnSelItensClick(Sender: TObject);
begin
  inherited;

  pSelecionaItens;
end;

procedure TfrmCadTabelaPrecos.btnTabRelClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmComparaTabPre, frmComparaTabPre);

  If objTabPre.Active Then
    frmComparaTabPre.edtCodIte.Text := objTabPre.FieldByName('ITE_CODITE').Text;

  frmComparaTabPre.ShowModal;
  FreeAndNil(frmComparaTabPre);

end;

procedure TfrmCadTabelaPrecos.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  CASE Key Of
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmCadTabelaPrecos.dbeCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If (Not dbeCodFor.ReadOnly) And fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadTabelaPrecos.fLiberaAtivaCompra: Boolean;
var
  objLiberacao: TLiberacao;
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
begin

  Try
    objLiberacao            := TLiberacao.Create;
    objLiberacao.objMsgLibera.Clear;

    objLiberacao.strDirAce  := 'LIBDESATICMP';
    objLiberacao.strMsgSen  := 'Senha para ativação de tabela de preço';
    objLiberacao.strCodOpe  := strLoginUsuarioLogado;
    objLiberacao.blnTraTel  := True;

    objLiberacao.objMsgLibera.pAddTexto('ATIVAÇÃO DE TABELA DE PREÇO DE FORNECEDOR PARA COMPRAS', alCentro);
    objLiberacao.objMsgLibera.pAddTexto('Foi desmarcado o campo '+QuotedStr('Ativo para compra'), alEsquerda);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'DESCRIÇÃO'   , 50 , alEsquerda, teAutcom);
    objLinha.pAddColuna('', 'FORNECEDOR'  , 70  , alEsquerda, teAutcom);
    objLinha.pAddColuna('', 'DT.CADASTRO' , 12 , alCentro  , teAutcom);

    objTabela.lstLinhas.Add(objLinha);

    objLinha              := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DESCRIÇÃO', qryTabela.FieldByName('TAB_NOMTAB').AsString , 50 , alEsquerda , teAmbos);
    objLinha.pAddColuna('FORNECEDOR', qryTabela.FieldByName('TAB_CODFOR').AsString + ' - ' + fRetNomFornecedor(qryTabela.FieldByName('TAB_CODFOR').AsString), 70 , alEsquerda , teAmbos);
    objLinha.pAddColuna('DT.CADASTRO', qryTabela.FieldByName('TAB_DTACAD').AsString , 12 , alEsquerda , teAmbos);


    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    Result := objLiberacao.fLibera;

  Finally
    FreeAndNil(objLiberacao);
  End;

end;

procedure TfrmCadTabelaPrecos.FormCreate(Sender: TObject);
begin
  inherited;
  strTAB_ATICMP_Original := '';
  strNomeTabela     := 'TABPRE';
  strNomeCampo      := 'TAB_CODTAB';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;
  qryTabela.AfterOpen := qryTabelaAfterOpen;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodTab;

  objTabPre := TTabelaPreco.Create(Self);
  cxgItensView.DataController.DataSource := objTabPre.dtsSource;
  pHabilitaItens(False);
  FCodIte := '';

  If Not objTabPre.blnTabPrD Then
  Begin
    btnAltGlobalCadastro.Visible := False;
    btnAltGlobalPrecos.Visible := False;
    pnlBotoesItens.Height := 25;
  End;
end;

procedure TfrmCadTabelaPrecos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of

    VK_INSERT: If Shift = [ssAlt] Then
                 btnSelItens.Click
               Else
               If Shift = [ssCtrl] Then
                 btnImpArq.Click
               Else
                 btnIncluirItem.Click;

    VK_DELETE: If fCheckParent(ActiveControl, cxgItens) Then
                 btnExcluirItem.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) then
                 btnAlterarItem.Click;

    VK_F4: btnAltGlobalPrecos.Click;
    VK_F3: btnAltGlobalCadastro.Click;
  End;

end;

procedure TfrmCadTabelaPrecos.FormShow(Sender: TObject);
Var
  strCodTab: string;
begin
  inherited;

  pnlDtaEfe.Visible := fCfgSis('PRFEFE', varBoolean);

  cxgItensViewPreDol.Visible := fCfgSis('COTDOR', varBoolean);

  If Not pnlDtaEfe.Visible Then
  Begin
    pnlCabecalho.Height := pnlCabecalho.Height - pnlDtaEfe.Height;
  End;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If Not fEmptyStr(FCodIte) Then
  Begin
    strCodTab := TfrmPesqTabPreProduto.fSelecionaTabela(FCodIte);

    qryTabela.SQL.Text := 'SELECT * FROM TABPRE WHERE TAB_CODTAB = :CODTAB';
    qryTabela.Close;
    qryTabela.ParamByName('CODTAB').AsString := strCodTab;
    qryTabela.Open;

    strCodTab := qryTabela.FieldByName('TAB_CODTAB').AsString;

    If Not fEmptyStr(strCodTab) Then
    begin
      objTabPre.fCarregaItens(strCodTab, qryTabela.FieldByName('TAB_CODFOR').AsString);
      pCarregaDadosAdicionais;
      pSetFocus(btnAlterar);
    end;
  End;

  btnAltGloFor.Visible := objTabPre.blnTabPrD;
end;

function TfrmCadTabelaPrecos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodTab) Then
    Begin

      If (fEmptyStr(dbeCodTab.Text)) And (dbeCodTab.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Tabela deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************LA*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos
        Else
        Begin
          objTabPre.fCarregaItens(qryTabela.FieldByName('TAB_CODTAB').AsString,
                                  qryTabela.FieldByName('TAB_CODFOR').AsString);
          pCarregaDadosAdicionais;
        End;
      End;

    End
    {*****************************************}
    {* VALIDA DESCRICAO DA MARCA             *}
    {**************************************LA*}
    Else If (Sender = dbeNomTab) Then
    Begin
      If fEmptyStr(dbeNomTab.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Nome da Tabela deve ser preenchido!', ['&Ok']);
      End;
    End

    Else If Sender = dbeCodFor Then
    Begin

      If fEmptyStr(dbeCodFor.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Informe o fornecedor da tabela!', ['&Ok']);
      End Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Fornecedor não econtrado!', ['&Ok']);
        End;
      End;


    End

    Else
    If ( Sender = dbeDtaEfe ) Then
    Begin

      If pnlDtaEfe.Visible Then
      Begin

        If fEmptyDate(dbeDtaEfe.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'A data de Efetivação deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else
        If ( StrToDate(dbeDtaEfe.Text) < VS_Date ) Then
        Begin
          fMensagem('ATENÇÃO', 'A data de Efetivação deve ser maior ou igual a data atual!', ['&OK']);
          Result := False;
        End;

      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadTabelaPrecos.msgCancelouAtivacaoTabela(var Msg: TMessage);
begin
  blnAtivouTabela := False;
end;

procedure TfrmCadTabelaPrecos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
end;

procedure TfrmCadTabelaPrecos.qryTabelaAfterOpen(DataSet: TDataSet);
begin
  TDateField(qryTabela.FieldByName('TAB_DTAEFE')).EditMask := '99/99/9999;1;_';
end;

procedure TfrmCadTabelaPrecos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTabelaPrecos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  If qryTabela.Active Then
    qryTabela.Close;

  objTabPre.fCarregaItens('', '');
  pCarregaDadosAdicionais;
  pHabilitaItens(False);
end;

procedure TfrmCadTabelaPrecos.btnExcluirItemClick(Sender: TObject);
begin
  inherited;

  objTabPre.pExcluiItem;
   If objTabPre.blnIncluindoTabela Then
     dbeCodFor.Enabled := cxgItensView.DataController.DataSource.DataSet.IsEmpty;

end;

procedure TfrmCadTabelaPrecos.btnExpExcelClick(Sender: TObject);
begin
  inherited;

  if (Not qryTabela.Active) or (qryTabela.RecordCount <= 0) Or fEmptyStr(dbeCodTab.Text) Then
  Begin
    fMensagem('','Selecione uma tabela para exportar!', ['&OK']);
    Exit;
  End;

  If objTabPre.fExportaTabela(dbeCodTab.Text,
                              dbeNomTab.Text,
                              dbeCodFor.Text,
                              edtNomFor.Text) Then
    fMensagem('', 'Arquivo gerado com sucesso!', ['OK']);
end;

class procedure TfrmCadTabelaPrecos.pAbreTela(strCodIte: String);
  Var
    frmCadTabelaPrecos: TfrmCadTabelaPrecos;
begin
  pCriarFormularios(TfrmCadTabelaPrecos, frmCadTabelaPrecos);
  Try
    With frmCadTabelaPrecos Do
    Begin
      FCodIte := strCodIte;
      ShowModal;
    End;

  Finally
    FreeAndNil(frmCadTabelaPrecos);
  End;
end;

procedure TfrmCadTabelaPrecos.pCarregaDadosAdicionais;
Begin
  edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
  cxgItensView.DataController.Filter.Clear;

  cxgItensView.NavigatorButtons.First.Click;

  btnAltGloFor.Enabled := Not qryTabela.IsEmpty;
End;

Procedure TfrmCadTabelaPrecos.pAlteraItem;
Begin
  pTelaItem(opcAlteraItem);
End;

Procedure TfrmCadTabelaPrecos.pTelaItem(opcAlteracao: TopcAltPre);
  Var
    frmCadTabelaPrecosItem: TfrmCadTabelaPrecosItem;
    Data: OleVariant;
Begin
  Data := objTabPre.cdsTabDet.Data;
  objTabPre.opcAlteraPreco := opcAlteracao;
  objTabPre.strCodForDef := dbeCodFor.Text;

  If (opcAlteracao = opcAlteraItem) And objTabPre.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmCadTabelaPrecosItem, frmCadTabelaPrecosItem);
  frmCadTabelaPrecosItem.pnlCaption.Caption := 'Tabela: ' + dbeCodtab.Text + '   Fornecedor: ' + dbeCodFor.Text + ' - ' + edtNomFor.Text;
  If Not Assigned(frmCadTabelaPrecosItem) Then
    Exit;

  Try

    frmCadTabelaPrecosItem.objTabPre := objTabPre;

    With frmCadTabelaPrecosItem Do
    Begin
      pgcItens.activePage   := tbsDados;
      tbsFiltros.TabVisible := False;
      ClientHeight          := pnlItem.Height + pnlDados1.Height + pnlDados2.Height +
                               pnlBotoes.Height + pnlStatus.Height + 30;
      pnlDados2.Align       := alClient;
      objTabPre.pSetaMasterTabDet(objTabPre.cdsTabDet, objTabPre.dtsSource);
      objTabPre.pFiltraEmpresaCorrenteTabDet(True);

      objTabPre.cdsTabDet.AfterCancel:= objTabPre.pAfterCancelTabDet;
      objTabPre.cdsTabDet.AfterPost  := objTabPre.pAfterPostTabDet;
      objTabPre.cdsTabDet.BeforePost := objTabPre.pBeforePostTabDet;

      If opcAlteracao In [opcAlteraItem, opcGlobalComuns, opcGlobalPreco] Then
      Begin
        pnlItem.Enabled    := False;

        dtsItens.DataSet  := objTabPre;

        frmCadTabelaPrecosItem.dtsTabDet.DataSet := objTabPre.cdsTabDet;

        If opcAlteracao = opcAlteraItem Then
        Begin
          objTabPre.Edit;
          objTabPre.cdsTabDet.Edit;
        End;

      End Else
      Begin
        objTabPre.RecreateCdsInsert;
        dtsItens.DataSet  := objTabPre.FIncIte;
        dtsTabDet.DataSet := objTabPre.FIncDet;

        If objTabPre.FIncIte.State = dsInsert Then
          objTabPre.FIncIte.Cancel;

        If objTabPre.FIncDet.State = dsInsert Then
          objTabPre.FIncDet.Cancel;
        objTabPre.blnInclusaoItem := True;

        While not objTabPre.FIncIte.IsEmpty do
          objTabPre.FIncIte.Delete;

        While not objTabPre.FIncDet.IsEmpty do
          objTabPre.FIncDet.Delete;

        objTabPre.FIncIte.Insert;
        objTabPre.FIncDet.Insert;


        objTabPre.pIniciaValores(objTabPre.FIncIte, objTabPre.FIncDet);
        objTabPre.blnInclusaoItem := False;
      End;

      If ShowModal = mrOk Then
      Begin
        opcAlteracao := objTabPre.opcAlteraPreco;
        If opcAlteracao In [opcAlteraItem, opcGlobalComuns, opcGlobalPreco] Then
        Begin
          If objTabPre.cdsTabDet.State In dsEditModes Then
            objTabPre.cdsTabDet.Post;

          If objTabPre.State In dsEditModes Then
            objTabPre.Post;
        End Else
        Begin
          objTabPre.pCopiaDadosInsert(objTabPre.FIncIte, False);
          objTabPre.pCopiaDadosInsertTabDet(objTabPre.FIncDet, False);
        End;

      End Else
      Begin
        If objTabPre.cdsTabDet.State In [dsInsert, dsEdit] Then
          objTabPre.cdsTabDet.Cancel;

        If objTabPre.State In [dsInsert, dsEdit] Then
          objTabPre.Cancel;

        If objTabPre.blnTabPrD Then
          objTabPre.cdsTabDet.Data := Data;

      End;

      If objTabPre.FIncDet.State = dsInsert Then
        objTabPre.FIncDet.Cancel;

      If objTabPre.FIncIte.State = dsInsert Then
        objTabPre.FIncIte.Cancel;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TTabelaPreco.pIncluiItem]');
    End;
  End;

  FreeAndNil(frmCadTabelaPrecosItem);
End;

Procedure TfrmCadTabelaPrecos.pSelecionaItens(strNomArq : String = ''; strCodFor : String = '');
  Var
    frmCadTabelaPrecosItem: TfrmCadTabelaPrecosItem;
Begin
  pCriarFormularios(TfrmCadTabelaPrecosItem, frmCadTabelaPrecosItem);
  frmCadTabelaPrecosItem.pnlCaption.Caption := 'Tabela: ' + dbeCodtab.Text + '   Fornecedor: ' + dbeCodFor.Text + ' - ' + edtNomFor.Text;

  If Not Assigned(frmCadTabelaPrecosItem) Then
    Exit;

  Try

    frmCadTabelaPrecosItem.objTabPre := objTabPre;
    objTabPre.strCodForDef := strCodFor;
    With frmCadTabelaPrecosItem Do
    Begin
      BorderStyle              := bsSizeable;
      Height                   := 600;
      pnlDados2.Align          := alClient;
      pgcItens.ActivePageIndex := 0;
      btnExcluiItem.Visible    := True;

      pnlItem.Visible    := False;

      objTabPre.pSetaMasterTabDet(objTabPre.cdsTabDet, objTabPre.dtsSource);
      objTabPre.pFiltraEmpresaCorrenteTabDet(True);

      objTabPre.cdsTabDet.AfterPost  := objTabPre.pAfterPostTabDet;
      objTabPre.cdsTabDet.BeforePost := objTabPre.pBeforePostTabDet;

      frmCadTabelaPrecosItem.dtsItens.DataSet := objTabPre.FIncIte;
      If objTabPre.FIncIte.State = dsInsert Then
        objTabPre.FIncIte.Cancel;

      dtsTabDet.DataSet := objTabPre.FIncDet;
      If objTabPre.FIncDet.State = dsInsert Then
        objTabPre.FIncDet.Cancel;

      objTabPre.pLimpaMasterTabDet(objTabPre.FIncDet);

      objTabPre.cdsIteSel.AfterScroll  := Nil;
      objTabPre.cdsIteSel.BeforeDelete := Nil;

      if (not fEmptyStr(strNomArq)) And (FileExists(strNomArq)) Then
      Begin
        frmCadTabelaPrecosItem.blnOrigemImportacao := True;

        if objTabPre.fImportaTXT(strNomArq, strCodFor) Then
        Begin
          dtsIteSel.DataSet := objTabPre.cdsIteSel;
        End;

        objTabPre.cdsIteSel.AfterScroll  := objTabPre.cdsIteSelAfterScroll;
        objTabPre.cdsIteSel.BeforeDelete := objTabPre.cdsIteSelBeforeDelete;

        objTabPre.pSetaMasterTabDet(objTabPre.FIncDet, objTabPre.FIncIte.dtsSource);
      End
      Else
      Begin
        objTabPre.FIncIte.Insert;
        objTabPre.FIncDet.Insert;
        objTabPre.pIniciaValores(objTabPre.FIncIte, objTabPre.FIncDet);
      End;

      If ShowModal = mrOk Then
      Begin
        objTabPre.pCopiaDadosSelecao;

        If frmCadTabelaPrecosItem.blnOrigemImportacao Then
          objTabPre.pLimpaMasterTabDet(objTabPre.FIncDet);
      End;

      If objTabPre.FIncIte.State = dsInsert Then
        objTabPre.FIncIte.Cancel;

      If objTabPre.FIncDet.State = dsInsert Then
        objTabPre.FIncDet.Cancel;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TTabelaPreco.pTelaItem]');
    End;
  End;

  FreeAndNil(frmCadTabelaPrecosItem);
End;

end.

