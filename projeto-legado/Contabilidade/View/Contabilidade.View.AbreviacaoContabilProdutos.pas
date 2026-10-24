unit Contabilidade.View.AbreviacaoContabilProdutos;

interface

uses
  Windows, Classes, Controls, Forms, Contabilidade.View.TfrmPaiCadContabilidade, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBEditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem,
  DBLookupComboBoxFocus, UniClientDataSet, Mask, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, EditFocus, Variants, untZClient,
  ComboBoxFocus, cxDataControllerConditionalFormattingRulesManagerDialog,
  Vcl.CheckLst, System.StrUtils, MaskEditFocus;

type
  TfrmAbreviacaoContabilProdutos = class(TfrmPaiCadContabilidade)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    pnlAddReg: TPanel;
    dtsTabela: TDataSource;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    cxgDadosTableViewCOD_DESVAL: TcxGridDBColumn;
    cxgDadosTableViewCOD_CLAFIS: TcxGridDBColumn;
    cxgDadosTableViewCONTA_DEBITO: TcxGridDBColumn;
    dtsAbfCod: TDataSource;
    pnlDados: TPanel;
    cxgDadosTableViewCOD_CONDEB: TcxGridDBColumn;
    cxgDadosTableViewCOD_CONCRE: TcxGridDBColumn;
    cxgDadosTableViewCONTA_CREDITO: TcxGridDBColumn;
    pnlDadosDigitacao: TPanel;
    mskContaCredito: TMaskEditFocus;
    mskContaDebito: TMaskEditFocus;
    edtValor: TComboBoxFocus;
    Label3: TLabel;
    edtClaFis: TComboBoxFocus;
    Label24: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    btnAddReg: TBitBtnLocked;
    edtDesContaDebito: TEditFocus;
    edtDesContaCredito: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAddRegClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxgDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoExit(Sender: TObject);
    procedure mskContaDebitoExit(Sender: TObject);
    procedure cxgDadosTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure edtClaFisChange(Sender: TObject);
  private
    const CFOP_VENDA : string = 'CFOPs venda';
    const CFOP_COMPRA : string = 'CFOPs compra';
  private
    { Private declarations }
    cdsAbfCod : TZClient;
    blnValidaCampos : Boolean;
    function fExisteRegistro(strValor, strCFOP: String): Boolean;
    procedure pCarregaRegistros(strCodigo: String = '');
    procedure pGravarContas(strCodigo: String);
    procedure pDeletarContas(strCodigo: String);
    procedure pLimparDigitacaoContas;
    procedure pSetaClassificacoesFiscais(Combo: TComboBoxFocus);
    procedure pAdicionaRegistro(strValor,
  strClaFis, strContaDebito, strContaCredito: string; blnIgnorarSeExiste: boolean = false);
    procedure pAdicionaCfopsVenda(strValor, strContaDebito, strContaCredito: string);
    procedure pAdicionaCfopsCompra(strValor, strContaDebito, strContaCredito: string);
    function fValidaConta(strConta: string): boolean;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

implementation

uses SysUtils, Contabilidade.View.TfrmPaiContabilidade, untFuncoesSimples, untTypesSistema,
  Contabilidade.Funcoes, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmAbreviacaoContabilProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'ABFCOG';
  strNomeCampo := 'COG_CODIGO';

  qryTabela := fCriarQuery('SELECT * FROM ABFCOG', Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  mskContaCredito.EditMask := fMskCon;
  mskContaDebito.EditMask := fMskCon;

  cdsAbfCod := TZClient.Create(Self, '');

  blnValidaCampos := True;

  pSetaItensEntradaSaida(edtValor, True, 'ENT');
  pSetaClassificacoesFiscais(edtClaFis);
end;

procedure TfrmAbreviacaoContabilProdutos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsAbfCod);
  inherited;
end;

procedure TfrmAbreviacaoContabilProdutos.FormShow(Sender: TObject);
begin
  inherited;
  dtsAbfCod.DataSet := cdsAbfCod.fGetDataset;
end;

procedure TfrmAbreviacaoContabilProdutos.pAdicionaCfopsCompra(strValor,
  strContaDebito, strContaCredito: string);
  var
    intCnt : Integer;
begin
  for intCnt := 0 To Pred(edtClaFis.Items.Count) Do
  begin
    If VS_strClaCom.Contains(edtClaFis.Items[intCnt]) Then
      pAdicionaRegistro(strValor, edtClaFis.Items[intCnt], strContaDebito, strContaCredito, True);
  end;
end;

procedure TfrmAbreviacaoContabilProdutos.pAdicionaCfopsVenda(strValor, strContaDebito, strContaCredito: string);
  var
    intCnt : Integer;
begin
  for intCnt := 0 To Pred(edtClaFis.Items.Count) Do
  begin
    If VS_strClaVen.Contains(edtClaFis.Items[intCnt]) Then
      pAdicionaRegistro(strValor, edtClaFis.Items[intCnt], strContaDebito, strContaCredito, True);
  end;
end;

procedure TfrmAbreviacaoContabilProdutos.pAdicionaRegistro(strValor,
  strClaFis, strContaDebito, strContaCredito: string; blnIgnorarSeExiste: boolean = false);
begin
  if (blnIgnorarSeExiste) then
    if fExisteRegistro(strValor, strClaFis) then
      exit;

  cdsAbfCod.Insert;
  //cdsAbfCod.FieldByName('COD_SEQGER').AsString := '';
  cdsAbfCod.FieldByName('COD_DESVAL').AsString := strValor;
  cdsAbfCod.FieldByName('COD_CLAFIS').AsString := strClaFis;
  cdsAbfCod.FieldByName('COD_CONDEB').AsString := strContaDebito;
  cdsAbfCod.FieldByName('COD_CONCRE').AsString := strContaCredito;
  cdsAbfCod.FieldByName('CONTA_DEBITO').AsString := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [cdsAbfCod.FieldByName('COD_CONDEB').AsString], False);
  cdsAbfCod.FieldByName('CONTA_CREDITO').AsString := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [cdsAbfCod.FieldByName('COD_CONCRE').AsString], False);
  cdsAbfCod.Post;
end;

procedure TfrmAbreviacaoContabilProdutos.pCarregaRegistros(strCodigo: String = '');
var
  strTplaco : string ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;
  With cdsAbfCod.fGetQuery Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT CD.NCO_DESCRI AS CONTA_DEBITO, ');
    SQL.Add('        CC.NCO_DESCRI AS CONTA_CREDITO, ');
    SQL.Add('        A.* ');
    SQL.Add('   FROM ABFCOD A ');
    SQL.Add('   LEFT JOIN PLANCO CD ON CD.NCO_CODCON = A.COD_CONDEB AND CD.NCO_TPLACO = :TPLACO ');
    SQL.Add('   LEFT JOIN PLANCO CC ON CC.NCO_CODCON = A.COD_CONCRE AND CC.NCO_TPLACO = :TPLACO ');
    SQL.Add('  WHERE ');
    ParamByName('TPLACO').AsString := strTplaco;
    If (Not fEmptyStr(strCodigo)) Then
    Begin
      SQL.Add(' COD_SEQGER = :SEQGER ');
      ParamByName('SEQGER').AsString := strCodigo;
    End
    Else
      SQL.Add(' FALSE ');
    SQL.Add(' ORDER BY COD_DESVAL ');
    cdsAbfCod.fAbreClient(True);
    cdsAbfCod.IndexFieldNames := 'COD_DESVAL';
    cxgDadosTableView.DataController.DataSource := dtsAbfCod;
    cdsAbfCod.FieldByName('COD_CONDEB').EditMask := fMskCon;
    cdsAbfCod.FieldByName('COD_CONCRE').EditMask := fMskCon;
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.pDeletarContas(strCodigo: String);
  Var
    qryDelete : TUniQuery;
begin
  qryDelete := fCriaQuery(Self);
  Try
    qryDelete.SQL.Text := 'DELETE FROM ABFCOD WHERE COD_SEQGER = :CODIGO';
    qryDelete.ParamByName('CODIGO').AsString := strCodigo;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.pGravarContas(strCodigo: String);
  Var
    qryInsert : TUniQuery;
begin
  if cdsAbfCod.IsEmpty then
    exit;

  qryInsert := fCriaQuery(Self);
  Try
    qryInsert.SQL.Text := 'SELECT * FROM ABFCOD WHERE FALSE';
    qryInsert.Open;

    cdsAbfCod.First;
    While Not cdsAbfCod.Eof Do
    Begin
      qryInsert.Insert;
      qryInsert.FieldByName('COD_SEQGER').AsString := strCodigo;
      qryInsert.FieldByName('COD_DESVAL').AsString := cdsAbfCod.FieldByName('COD_DESVAL').AsString;
      qryInsert.FieldByName('COD_CLAFIS').AsString := cdsAbfCod.FieldByName('COD_CLAFIS').AsString;
      qryInsert.FieldByName('COD_CONDEB').AsString := cdsAbfCod.FieldByName('COD_CONDEB').AsString;
      qryInsert.FieldByName('COD_CONCRE').AsString := cdsAbfCod.FieldByName('COD_CONCRE').AsString;
      qryInsert.Post;
      cdsAbfCod.Next;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COG_CODIGO');
  stlCampos.Add('COG_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COG_DESCRI');
  stlCamInd.Add('COG_CODIGO');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmAbreviacaoContabilProdutos.pLimparDigitacaoContas;
begin
  edtValor.ItemIndex := -1;
  edtClaFis.ItemIndex := -1;
  mskContaCredito.Clear;
  mskContaDebito.Clear;
  edtDesContaDebito.Clear;
  edtDesContaCredito.Clear;
  pSetFocus(edtValor);
end;

procedure TfrmAbreviacaoContabilProdutos.pSetaClassificacoesFiscais(
  Combo: TComboBoxFocus);
  var
    qryClaFis : TUniQuery;
begin
  qryClaFis := fCriaQuery(Self);
  try
    Combo.Items.Clear;
    Combo.Items.Add(CFOP_VENDA);
    Combo.Items.Add(CFOP_COMPRA);
    qryClaFis.SQL.Text := 'SELECT DISTINCT CFO_CODCFO FROM CADCFO ORDER BY 1';
    qryClaFis.Open;
    qryClaFis.First;
    while not qryClaFis.Eof do
    begin
      Combo.Items.Add(qryClaFis.FieldByName('CFO_CODCFO').AsString);
      qryClaFis.Next;
    end;
  finally
    FreeAndNil(qryClaFis);
  end;
end;

procedure TfrmAbreviacaoContabilProdutos.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If (blnExcluiu) Then
    pCarregaRegistros(qryTabela.FieldByName('COG_CODIGO').AsString);
end;

procedure TfrmAbreviacaoContabilProdutos.btnGravarClick(Sender: TObject);
begin
  blnValidaCampos := False;
  Try
    fStartTransaction;
    inherited;
    If (blnGravou) Then
    Begin
      Try
        Try
          pDeletarContas(qryTabela.FieldByName('COG_CODIGO').AsString);
          pGravarContas(qryTabela.FieldByName('COG_CODIGO').AsString);
          fCommit;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pMensagensErro('Não foi possível inserir o registro!' + sLineBreak + E.Message,
                           '[TfrmAbreviacaoContabilProdutos.btnGravarClick]');
          End;
        End;
      Finally
        pCarregaRegistros(qryTabela.FieldByName('COG_CODIGO').AsString);
      End;
    End
    Else
      fRollBack;
  Finally
    blnValidaCampos := True;
    cxgDadosTableView.OptionsData.Editing := False;
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pCarregaRegistros;

  cxgDadosTableView.OptionsData.Editing := True;
end;

procedure TfrmAbreviacaoContabilProdutos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrRegistros: TConsultasArray;
begin
  chrKey := '/';
  If fPesqAbreviacaoContabilProdutos(Self, Nil, Nil, qryTabela, chrKey, arrRegistros) Then
  Begin
    pCarregaRegistros(qryTabela.FieldByName('COG_CODIGO').AsString);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.cxgDadosTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (qryTabela.State in dsEditModes) Then
    pnlInfo.Caption := '[Pressione delete para remover um registro]';
end;

procedure TfrmAbreviacaoContabilProdutos.cxgDadosTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  var
    strValor : string;
begin
  inherited;
  if Key = VK_RETURN then
  Begin
    If not Assigned(AItem) then
      Exit;

    If not (AItem is TcxGridDBColumn) then
      Exit;

    if not (cdsAbfCod.State in [dsInsert, dsEdit]) then
      exit;

    strValor := fSemMascaraPlaNco(AEdit.EditingValue);

    if (cxgDadosTableViewCOD_CONDEB.Focused) then
    begin
      if not fValidaConta(strValor) then
      begin
        fMensagem('ATENÇÃO!', 'Conta Débito inválida!', ['&OK']);
        cdsAbfCod.Cancel;
      end
      else
      begin
        cdsAbfCod.FieldByName('COD_CONDEB').AsString := strValor;
        cdsAbfCod.FieldByName('CONTA_DEBITO').AsString := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(strValor)], False);
        cdsAbfCod.Post;
      end;
    end
    else if (cxgDadosTableViewCOD_CONCRE.Focused) then
    begin
      if not fValidaConta(strValor) then
      begin
        fMensagem('ATENÇÃO!', 'Conta Crédito inválida!', ['&OK']);
        cdsAbfCod.Cancel;
      end
      else
      begin
        cdsAbfCod.FieldByName('COD_CONCRE').AsString := strValor;
        cdsAbfCod.FieldByName('CONTA_CREDITO').AsString := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(strValor)], False);
        cdsAbfCod.Post;
      end;
    end;
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.cxgDadosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_DELETE) Then
  Begin
    If (cdsAbfCod.Active) And
       (cdsAbfCod.RecordCount > 0) And
       (qryTabela.State in dsEditModes) And
       (fMensagem('', 'Deseja remover o registro selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    begin
      cdsAbfCod.Delete;
    end;
  End;
end;

procedure TfrmAbreviacaoContabilProdutos.edtClaFisChange(Sender: TObject);
begin
  inherited;
  edtValor.Items.Clear;
  if edtClaFis.ItemIndex < 0 then Exit;

  pSetaItensEntradaSaida(edtValor, True, 'ENT', edtClaFis.Items[edtClaFis.ItemIndex].Contains('933'));

  if (edtClaFis.ItemIndex >= 0) and (edtClaFis.Items[edtClaFis.ItemIndex].Contains('933')) and
     (edtValor.ItemIndex  >= 0) and (edtValor.Items[edtValor.ItemIndex].Contains('Vr.Ret.IRRF')) then
    edtValor.ItemIndex := -1;
end;

procedure TfrmAbreviacaoContabilProdutos.btnAddRegClick(Sender: TObject);
begin
  If (Not fVerificaCampos) Then
    Exit;

  If (fEmptyStr(edtValor.Text)) Or (edtValor.Items.Count < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor deve ser preenchido!', ['&OK']);
    pSetFocus(edtValor);
    Exit;
  End;

  if fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text) + fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'Ao menos uma conta deve ser preenchida!', ['&OK']);
    pSetFocus(mskContaDebito);
    Exit;
  end;

  if not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
  begin
    if not fValidaConta(mskContaDebito.Text) then
    begin
      fMensagem('ATENÇÃO!', 'Conta Débito inválida!', ['&OK']);
      pSetFocus(mskContaDebito);
      exit;
    end;
  end;

  if not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    if not fValidaConta(mskContaCredito.Text)then
    begin
      fMensagem('ATENÇÃO!', 'Conta Crédito inválida!', ['&OK']);
      pSetFocus(mskContaCredito);
      Exit;
    end;
  end;

  If (fExisteRegistro(edtValor.Text, edtClaFis.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foi informado um registro com essas informações!', ['&OK']);
    Exit;
  End;

  if (edtClaFis.Text = CFOP_VENDA) then
    pAdicionaCfopsVenda(edtValor.Text, fSemMascaraPlaNco(mskContaDebito.Text), fSemMascaraPlaNco(mskContaCredito.Text))
  else if (edtClaFis.Text = CFOP_COMPRA) then
    pAdicionaCfopsCompra(edtValor.Text, fSemMascaraPlaNco(mskContaDebito.Text), fSemMascaraPlaNco(mskContaCredito.Text))
  else
    pAdicionaRegistro(edtValor.Text,
                      edtClaFis.Text,
                      fSemMascaraPlaNco(mskContaDebito.Text),
                      fSemMascaraPlaNco(mskContaCredito.Text));

  pLimparDigitacaoContas();
end;

procedure TfrmAbreviacaoContabilProdutos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  cxgDadosTableView.OptionsData.Editing := True;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmAbreviacaoContabilProdutos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cxgDadosTableView.OptionsData.Editing := False;
  pCarregaRegistros(qryTabela.FieldByName('COG_CODIGO').AsString);
end;

function TfrmAbreviacaoContabilProdutos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (Not fEmptyStr(dbeCodigo.Text)) And (qryTabela.State In dsEditModes) Then
        dbeCodigo.Text := fStrZero(dbeCodigo.Text, 12);
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAbreviacaoContabilProdutos.mskContaCreditoExit(Sender: TObject);
begin
  inherited;
  edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)], False);
end;

procedure TfrmAbreviacaoContabilProdutos.mskContaCreditoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaCredito, Nil, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmAbreviacaoContabilProdutos.mskContaDebitoExit(Sender: TObject);
begin
  inherited;
  edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)], False);
end;

procedure TfrmAbreviacaoContabilProdutos.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaDebito, Nil, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmAbreviacaoContabilProdutos.fExisteRegistro(strValor, strCFOP: String): Boolean;
  Var
    intRecNo : Integer;
Begin
  intRecNo := cdsAbfCod.RecNo;
  cdsAbfCod.DisableControls;
  Try
    Result := (cdsAbfCod.Locate('COD_DESVAL;COD_CLAFIS', VarArrayOf([strValor, strCFOP]), []));
  Finally
    cdsAbfCod.RecNo := intRecNo;
    cdsAbfCod.EnableControls;
  End;
End;

function TfrmAbreviacaoContabilProdutos.fValidaConta(strConta: string): boolean;
begin
  result := true; 
  if fEmptyStr(fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(strConta)], False)) then
    Result := False;
end;

end.

