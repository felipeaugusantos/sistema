unit Contabilidade.View.DefinicoesDRE;

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
  TfrmCadDefDemonsResultExerc = class(TfrmPaiCadContabilidade)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    pnlAddConta: TPanel;
    Label1: TLabel;
    dtsTabela: TDataSource;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    Label24: TLabel;
    btnAddConta: TBitBtnLocked;
    cxgDadosTableViewNCO_SINAL_: TcxGridDBColumn;
    cxgDadosTableViewNCO_CODCON: TcxGridDBColumn;
    cxgDadosTableViewNCO_SEQUEN: TcxGridDBColumn;
    dtsDreNco: TDataSource;
    edtSinal: TComboBoxFocus;
    pnlDados: TPanel;
    cxgDadosTableViewNCO_DESCRI: TcxGridDBColumn;
    mskConta: TMaskEditFocus;
    dbcTitulo: TDBCheckBox;
    lblVinculo: TLabel;
    dbeDreTip: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAddContaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxgDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDadosTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure mskContaKeyPress(Sender: TObject; var Key: Char);
    procedure dbcTituloClick(Sender: TObject);
    procedure dbeDreTipKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsDreNco : TZClient;
    blnValidaCampos : Boolean;
    function fExisteConta(strConta: string; strSinal: String): Boolean;
    procedure pCarregaContas(strCodDre: String = '');
    procedure pGravarContas(strCodDre: String);
    procedure pDeletarContas(strCodDre: String);
    procedure pLimparDigitacaoContas;
    procedure pHabilitaAdicaoDeConta;
    function fProximaSequencia: integer;
    procedure pReordenarSequencia;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmCadDefDemonsResultExerc: TfrmCadDefDemonsResultExerc;

implementation

uses SysUtils, Contabilidade.View.TfrmPaiContabilidade, untFuncoesSimples, untTypesSistema,
  Contabilidade.Funcoes, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmCadDefDemonsResultExerc.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADDRE';
  strNomeCampo := 'DRE_CODDRE';

  qryTabela := fCriarQuery('SELECT * FROM CADDRE', Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  mskConta.EditMask := fMskCon;

  cdsDreNco := TZClient.Create(Self, '');

  blnValidaCampos := True;

  if (Assigned(qryTabela.FindField('DRE_DRETIP'))) then
  begin
    dbeDreTip.DataField := 'DRE_DRETIP';
    dbeDreTip.DataSource := dtsTabela;
    dbeDreTip.Visible := True;
    lblVinculo.Visible := True;
  end;
end;

procedure TfrmCadDefDemonsResultExerc.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDreNco);
  inherited;
end;

procedure TfrmCadDefDemonsResultExerc.FormShow(Sender: TObject);
begin
  inherited;
  dtsDreNco.DataSet := cdsDreNco.fGetDataset;
end;

procedure TfrmCadDefDemonsResultExerc.pCarregaContas(strCodDre: String = '');
var
  strTplaco: String ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;
  With cdsDreNco.fGetQuery Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT PN.NCO_DESCRI, ');
    SQL.Add('        DN.* ');
    SQL.Add('   FROM DRENCO DN ');
    SQL.Add('   JOIN PLANCO PN ON PN.NCO_CODCON = DN.NCO_CODCON AND PN.NCO_TPLACO = '+strTplaco.QuotedString);
    SQL.Add('  WHERE ');
    If (Not fEmptyStr(strCodDre)) Then
    Begin
      SQL.Add(' NCO_CODDRE = :CODDRE ');
      ParamByName('CODDRE').AsString := strCodDre;
    End
    Else
      SQL.Add(' FALSE ');
    SQL.Add(' ORDER BY DN.NCO_SEQUEN ');
    cdsDreNco.fAbreClient(True);
    cdsDreNco.IndexFieldNames := 'NCO_SEQUEN';
    cxgDadosTableView.DataController.DataSource := dtsDreNco;
    cdsDreNco.FieldByName('NCO_CODCON').EditMask := fMskCon;
  End;
end;

procedure TfrmCadDefDemonsResultExerc.pDeletarContas(strCodDre: String);
  Var
    qryDelete : TUniQuery;
begin
  qryDelete := fCriaQuery(Self);
  Try
    qryDelete.SQL.Text := 'DELETE FROM DRENCO WHERE NCO_CODDRE = :CODDRE';
    qryDelete.ParamByName('CODDRE').AsString := strCodDre;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmCadDefDemonsResultExerc.pGravarContas(strCodDre: String);
  Var
    qryInsert : TUniQuery;
begin
  if cdsDreNco.IsEmpty then
    exit;

  qryInsert := fCriaQuery(Self);
  Try
    qryInsert.SQL.Text := 'SELECT * FROM DRENCO WHERE FALSE';
    qryInsert.Open;

    cdsDreNco.First;
    While Not cdsDreNco.Eof Do
    Begin
      qryInsert.Insert;
      qryInsert.FieldByName('NCO_CODDRE').AsString := strCodDre;
      qryInsert.FieldByName('NCO_CODCON').AsString := cdsDreNco.FieldByName('NCO_CODCON').AsString;
      qryInsert.FieldByName('NCO_SINAL_').AsString := cdsDreNco.FieldByName('NCO_SINAL_').AsString;
      qryInsert.FieldByName('NCO_SEQUEN').AsInteger := cdsDreNco.FieldByName('NCO_SEQUEN').AsInteger;
      qryInsert.Post;
      cdsDreNco.Next;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TfrmCadDefDemonsResultExerc.pHabilitaAdicaoDeConta;
begin
  pnlAddConta.Enabled := (qryTabela.Active) And
                         (qryTabela.State in [dsInsert, dsEdit]) And
                         ((fEmptyStr(qryTabela.FieldByName('DRE_TITULO').AsString)) Or
                          (qryTabela.FieldByName('DRE_TITULO').AsString = 'N'));
end;

procedure TfrmCadDefDemonsResultExerc.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DRE_CODDRE');
  stlCampos.Add('DRE_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DRE_DESCRI');
  stlCamInd.Add('DRE_CODDRE');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadDefDemonsResultExerc.pLimparDigitacaoContas;
begin
  edtSinal.ItemIndex := -1;
  mskConta.Clear;
  pSetFocus(edtSinal);
end;

procedure TfrmCadDefDemonsResultExerc.pReordenarSequencia;
  var
    intRecNo : Integer;
    intSequencia : integer;
begin
  if cdsDreNco.IsEmpty then
    exit;

  intRecNo := cdsDreNco.RecNo;
  try
    intSequencia := 0;
    cdsDreNco.First;
    while not cdsDreNco.Eof do
    begin
      intSequencia := intSequencia + 1;
      cdsDreNco.Edit;
      cdsDreNco.FieldByName('NCO_SEQUEN').AsInteger := intSequencia;
      cdsDreNco.Post;
      cdsDreNco.Next;
    end;
  finally
    cdsDreNco.RecNo := intRecNo;
  end;
end;

procedure TfrmCadDefDemonsResultExerc.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If (blnExcluiu) Then
    pCarregaContas(qryTabela.FieldByName('DRE_CODDRE').AsString);
end;

procedure TfrmCadDefDemonsResultExerc.btnGravarClick(Sender: TObject);
begin
  if (not fEmptyStr(dbeDreTip.DataField)) then
  begin
    if (not fEmptyStr(dbeDreTip.Text)) then
    begin
      if fEmptyStr(fCampoTabela('DRE_DESCRI', 'CADDRE', ['DRE_CODDRE', 'DRE_TITULO'], [dbeDreTip.Text, IIF(dbcTitulo.Field.AsString = 'S', 'N', 'S')], False)) then
      begin
        fMensagem('ATENÇÃO!', 'Conta informada no vínculo é inválida!', ['&OK']);
        exit;
      end;
    end;
  end;

  blnValidaCampos := False;
  Try
    fStartTransaction;

    if (not fEmptyStr(dbeDreTip.DataField)) then
    begin
      if (fEmptyStr(dbeDreTip.Text)) then
        dbeDreTip.Field.Value := Null;
    end;

    inherited;
    If (blnGravou) Then
    Begin
      dbcTitulo.Enabled := False;
      Try
        Try
          pDeletarContas(qryTabela.FieldByName('DRE_CODDRE').AsString);
          pGravarContas(qryTabela.FieldByName('DRE_CODDRE').AsString);
          fCommit;
          pHabilitaAdicaoDeConta;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pMensagensErro('Não foi possível inserir as contas!' + sLineBreak + E.Message,
                           '[TfrmCadDefDemonsResultExerc.btnGravarClick]');
          End;
        End;
      Finally
        pCarregaContas(qryTabela.FieldByName('DRE_CODDRE').AsString);
        pHabilitaAdicaoDeConta;
      End;
    End
    Else
      fRollBack;
  Finally
    blnValidaCampos := True;
  End;
end;

procedure TfrmCadDefDemonsResultExerc.btnIncluirClick(Sender: TObject);
begin
  inherited;

  dbcTitulo.Enabled := True;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTabela.FieldByName('DRE_TITULO').AsString := 'N';

  pCarregaContas();

  pHabilitaAdicaoDeConta;
end;

procedure TfrmCadDefDemonsResultExerc.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrContas: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCadDefDRE(Self, Nil, Nil, qryTabela, chrKey, arrContas) Then
  Begin
    pCarregaContas(qryTabela.FieldByName('DRE_CODDRE').AsString);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadDefDemonsResultExerc.cxgDadosTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (qryTabela.State in dsEditModes) Then
    pnlInfo.Caption := '[Pressione delete para remover uma conta]';
end;

procedure TfrmCadDefDemonsResultExerc.cxgDadosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_DELETE) Then
  Begin
    If (cdsDreNco.Active) And
       (cdsDreNco.RecordCount > 0) And
       (qryTabela.State in dsEditModes) And
       (fMensagem('', 'Deseja remover a conta selecionada?', ['&Sim', '&Não'], 2) = 1) Then
    begin
      cdsDreNco.Delete;
      pReordenarSequencia;
    end;
  End;
end;

procedure TfrmCadDefDemonsResultExerc.dbcTituloClick(Sender: TObject);
begin
  inherited;
  pHabilitaAdicaoDeConta;
end;

procedure TfrmCadDefDemonsResultExerc.dbeDreTipKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrContas: TConsultasArray;
begin
  if fEmptyStr(dbeDreTip.DataField) then
    exit;

  if not (qryTabela.State in [dsInsert, dsEdit]) then
    exit;

  If fPesqCadDefDRE(Self, dbeDreTip, Nil, Nil, Key, arrContas, True, IIF(dbcTitulo.Field.AsString = 'S', 'N', 'S')) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadDefDemonsResultExerc.btnAddContaClick(Sender: TObject);
  var
    strSinal : string;
    intProxSequencia : integer;
    strTplaco : string ;
begin
  If (Not fVerificaCampos) Then
    Exit;

  if (qryTabela.FieldByName('DRE_TITULO').AsString = 'S') then
  begin
    fMensagem('ATENÇÃO!', 'Contas título não podem ter contas filhas.', ['&OK']);
    Exit;
  end;

  If (fEmptyStr(edtSinal.Text)) Or (edtSinal.Items.Count < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O sinal deve ser preenchido!', ['&OK']);
    pSetFocus(edtSinal);
    Exit;
  End;

  if fEmptyStr(fSemMascaraPlaNco(mskConta.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'A conta deve ser preenchida!', ['&OK']);
    pSetFocus(mskConta);
    Exit;
  end;

  if fEmptyStr(fSemMascaraPlaNco(mskConta.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'A conta deve ser preenchida!', ['&OK']);
    pSetFocus(mskConta);
    Exit;
  end;

  strTplaco := fRetTplacoEmpresaLogada ;
  if fEmptyStr(fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskConta.Text), strTplaco], False)) then
  begin
    fMensagem('ATENÇÃO!', 'Conta inválida!', ['&OK']);
    pSetFocus(mskConta);
    Exit;
  end;

  strSinal := edtSinal.Items.Strings[edtSinal.ItemIndex];

  If (fExisteConta(fSemMascaraPlaNco(mskConta.Text), strSinal)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foi informada uma conta com essas informações!', ['&OK']);
    Exit;
  End;

  intProxSequencia := fProximaSequencia;

  cdsDreNco.Insert;
  cdsDreNco.FieldByName('NCO_CODCON').AsString := fSemMascaraPlaNco(mskConta.Text);
  cdsDreNco.FieldByName('NCO_SINAL_').AsString := strSinal;
  cdsDreNco.FieldByName('NCO_SEQUEN').AsInteger := intProxSequencia;
  cdsDreNco.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [cdsDreNco.FieldByName('NCO_CODCON').AsString, strTplaco], False);
  cdsDreNco.Post;

  pLimparDigitacaoContas();
end;

procedure TfrmCadDefDemonsResultExerc.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  dbcTitulo.Enabled := False;
  pHabilitaAdicaoDeConta;
end;

procedure TfrmCadDefDemonsResultExerc.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbcTitulo.Enabled := True;
  pCarregaContas(qryTabela.FieldByName('DRE_CODDRE').AsString);
  pHabilitaAdicaoDeConta;
end;

function TfrmCadDefDemonsResultExerc.fProximaSequencia: integer;
  var
    cdsAux : TUniClientDataSet;
begin
  if cdsDreNco.IsEmpty then
  begin
    Result := 1;
    exit;
  end;

  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsAux, cdsDreNco);
    cdsAux.IndexFieldNames := 'NCO_SEQUEN';
    cdsAux.Last;
    Result := cdsAux.FieldByName('NCO_SEQUEN').AsInteger + 1;
  finally
    FreeAndNil(cdsAux);
  end;
end;

function TfrmCadDefDemonsResultExerc.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = mskConta) And (blnValidaCampos) Then
    Begin
      If (fEmptyStr(fSemMascaraPlaNco(mskConta.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A conta deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadDefDemonsResultExerc.mskContaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskConta, Nil, Nil, Key, arrPlan) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadDefDemonsResultExerc.fExisteConta(strConta: string; strSinal: String): Boolean;
  Var
    intRecNo : Integer;
Begin
  intRecNo := cdsDreNco.RecNo;
  cdsDreNco.DisableControls;
  Try
    Result := (cdsDreNco.Locate('NCO_CODCON;NCO_SINAL_', VarArrayOf([strConta, strSinal]), []));
  Finally
    cdsDreNco.RecNo := intRecNo;
    cdsDreNco.EnableControls;
  End;
End;

end.

