unit untCadDefeitos;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  EditFocus, UniClientDataSet, DBComboBoxFocus, ComboBoxFocus, Variants,
  Datasnap.DBClient;

type
  TfrmCadDefeitos = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    tbsRelFab: TTabSheet;
    pnlRelFab: TPanel;
    lblAcessorio: TLabel;
    btnCancelaRel: TBitBtnLocked;
    btnAdicionarRel: TBitBtnLocked;
    dbgGridDfeRel: TDBGridCitel;
    dtsDfeRel: TDataSource;
    lblDefeitos: TLabel;
    cmbRelFab: TComboBoxFocus;
    edtCodDfe: TEditFocus;
    edtDesDfe: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaRelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgGridDfeRelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAdicionarRelClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodDfeKeyPress(Sender: TObject; var Key: Char);
    procedure cmbRelFabChange(Sender: TObject);
  private
    qryCadDfe: TUniQuery;
    qryRelFab: TUniQuery;
    qryTabDin: TUniQuery;
    dtsDados: TDataSource;
    cdsDfeRel: TUniClientDataSet;
    procedure pInicializaRelFab;
    procedure pCriaClientDfeFab;
    procedure pCarregaComboRelFab;
    procedure pCarregComboDfeFab;
    procedure pCarregaDefeitosRelacionados;
    procedure pExcluirDfeRel;
    function fVerificaTabela: Boolean;
    function fGetPagAtivas: Integer;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    procedure pProximaPagina; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema, SysUtils;

{$R *.dfm}

procedure TfrmCadDefeitos.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADDFE';
  strNomeCampo  := 'DFE_CODIGO';
  qryCadDfe     := fCriarQuery('SELECT * FROM CADDFE', Self);

  qryCadDfe.FieldByName('DFE_CODIGO').DisplayLabel := 'Código';
  qryCadDfe.FieldbyName('DFE_DESCRI').DisplayLabel := 'Descrição';

  qryCadDfe.FieldByName('DFE_CODEMP').Visible := False;
  qryCadDfe.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryCadDfe);
  qryTabela := qryCadDfe;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


procedure TfrmCadDefeitos.FormDestroy(Sender: TObject);
begin
  inherited;

  dbgGridDfeRel.DataSource := Nil;
  dtsDfeRel.DataSet := Nil;

  if (Assigned(cdsDfeRel)) then
    FreeAndNil(cdsDfeRel);

  if (Assigned(qryRelFab)) then
    FreeAndNil(qryRelFab);

  if (Assigned(qryTabDin)) then
    FreeAndNil(qryTabDin);
end;

function TfrmCadDefeitos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Defeito deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Defeito deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      else
        pProximaPagina;
    End
    Else If Sender = edtCodDfe Then
    Begin
      If (pgcDados.ActivePage = tbsRelFab) Then
      Begin
        If Not fEmptyStr(edtCodDfe.Text) Then
        Begin
          edtDesDfe.Text := fRetDescriDfeFab(qryRelFab.FieldByName('TABREL').AsString, edtCodDfe.Text);
          If fEmptyStr(edtDesDfe.Text) Then
          Begin
            edtCodDfe.Clear;
            fMensagem('AVISO', 'Defeito não encontrado!', ['&Ok']);
            Result := False;
          End
          Else
            qryTabDin.Locate('REL_DESDEF', edtDesDfe.Text, []);
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadDefeitos.fVerificaTabela: Boolean;
var
  qryTabela: TUniQuery;
begin
  qryTabela := fCriaQuery;

  try
    qryTabela.SQL.Text := 'SHOW TABLES LIKE "' + qryRelFab.FieldByName('TABREL').AsString + '"';
    qryTabela.Open;

    Result := not qryTabela.IsEmpty;

    if (qryTabela.IsEmpty) then
      fMensagem('', 'Tabela ' + qryRelFab.FieldByName('TABREL').AsString + ' não encontrada.', ['&O k']);
  finally
    FreeAndNil(qryTabela);
  end;
end;

procedure TfrmCadDefeitos.pCarregaComboRelFab;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT RELFAB.AUTOINCREM, FAB_DESCRI DESMAR, FAB_TABREL TABREL ';
  strSQL := strSQL + 'FROM RELFAB ';
  strSQL := strSQL + 'ORDER BY FAB_DESCRI ';

  qryRelFab.SQL.Text := strSQL;
  qryRelFab.Open;

  if not qryRelFab.IsEmpty then
  begin
    cmbRelFab.Items.Clear;
    qryRelFab.IndexFieldNames := 'DESMAR';
    cmbRelFab.Items.Add('');

    qryRelFab.First;

    while not qryRelFab.Eof do
    begin
      cmbRelFab.Items.Add(qryRelFab.FieldByName('DESMAR').AsString);

      qryRelFab.Next;
    end;
  end;
end;

procedure TfrmCadDefeitos.pCarregaDefeitosRelacionados;
var
  qryRelDfe: TUniQuery;
  strSQL,
  strDesDfe: String;
begin
  qryRelDfe := fCriaQuery;

  cdsDfeRel.EmptyDataSet;

  strSQL := '';
  strSQL := strSQL + 'SELECT RELDFE.AUTOINCREM, REL_CODDFE CODDFE, REL_DFEFAB DFEFAB, ';
  strSQL := strSQL + 'REL_SEQREL SEQREL, FAB_DESCRI DESMAR, FAB_TABREL TABREL ';
  strSQL := strSQL + 'FROM RELDFE ';
  strSQL := strSQL + 'INNER JOIN RELFAB ON RELDFE.REL_SEQREL = RELFAB.AUTOINCREM ';
  strSQL := strSQL + 'WHERE REL_CODDFE = :CODDFE ';

  try
    qryRelDfe.SQL.Text := strSQL;
    qryRelDfe.ParamByName('CODDFE').AsString := qryTabela.FieldByName('DFE_CODIGO').AsString;
    qryRelDfe.Open;

    while not qryRelDfe.Eof do
    begin
      strDesDfe := '';
      strDesDfe := fCampoTabela('REL_DESDEF', qryRelDfe.FieldByName('TABREL').AsString, ['REL_CODDEF'], [qryRelDfe.FieldByName('DFEFAB').AsString]);

      cdsDfeRel.Append;
      cdsDfeRel.FieldByName('AUTOINCREM').AsString := qryRelDfe.FieldByName('AUTOINCREM').AsString;
      cdsDfeRel.FieldByName('DESMAR').AsString := qryRelDfe.FieldByName('DESMAR').AsString;
      cdsDfeRel.FieldByName('DFEFAB').AsString := qryRelDfe.FieldByName('DFEFAB').AsString;
      cdsDfeRel.FieldByName('DESDFE').AsString := strDesDfe;
      cdsDfeRel.FieldByName('SEQREL').AsString := qryRelDfe.FieldByName('SEQREL').AsString;
      cdsDfeRel.FieldByName('OPERAC').AsString := '';
      cdsDfeRel.Post;

      qryRelDfe.Next;
    end;

    cdsDfeRel.First;

  finally
    FreeAndNil(qryRelDfe);
  end;
end;

procedure TfrmCadDefeitos.pCarregComboDfeFab;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT REL_CODDEF, REL_DESDEF FROM ' + qryRelFab.FieldByName('TABREL').AsString;
  strSQL := strSQL + ' ORDER BY REL_DESDEF ';

  qryTabDin.Close;
  qryTabDin.SQL.Clear;
  qryTabDin.SQL.Text := strSQL;
  qryTabDin.Open;
end;

procedure TfrmCadDefeitos.pCriaClientDfeFab;
begin
  cdsDfeRel.FieldDefs.Add('AUTOINCREM', ftString, 20);
  cdsDfeRel.FieldDefs.Add('DFEFAB',     ftString,  8);
  cdsDfeRel.FieldDefs.Add('SEQREL',     ftString, 20);
  cdsDfeRel.FieldDefs.Add('DESMAR',     ftString, 30);
  cdsDfeRel.FieldDefs.Add('DESDFE',     ftString, 60);
  cdsDfeRel.FieldDefs.Add('OPERAC',     ftString,  6);
  cdsDfeRel.CreateDataSet;

  cdsDfeRel.Filtered := False;
  cdsDfeRel.Filter := 'OPERAC <> ''D''';
  cdsDfeRel.Filtered := True;
end;

procedure TfrmCadDefeitos.pExcluirDfeRel;
begin
  if not (fMensagem('AVISO', 'Confirma a exclusão do defeito relacionado?', ['&Sim', '&Não']) = 1) then
    Exit;

  if cdsDfeRel.FieldByName('OPERAC').AsString = 'I' then
    cdsDfeRel.Delete
  else
  begin
    cdsDfeRel.Edit;
    cdsDfeRel.FieldByName('OPERAC').AsString := 'D';
    cdsDfeRel.Post;
  end;

  btnCancelaRel.Click;
end;

procedure TfrmCadDefeitos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('DFE_CODIGO');
  stlCampos.Add('DFE_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('DFE_DESCRI');
  stlCamInd.Add('DFE_CODIGO');

  stlDesInd.Add('Defeito');
  stlDesInd.Add('Código');
end;

procedure TfrmCadDefeitos.pInicializaRelFab;
begin
  cdsDfeRel := TUniClientDataSet.Create(Self);
  qryRelFab := fCriaQuery;
  qryTabDin := fCriaQuery;
  pCriaClientDfeFab;
  pCarregaComboRelFab;
  dtsDfeRel.DataSet := cdsDfeRel;
  dbgGridDfeRel.DataSource := dtsDfeRel;
end;

procedure TfrmCadDefeitos.pProximaPagina;
begin
  If pgcDados.ActivePage.Tag < intPaginasAtivas Then
    inherited

  Else If btnGravar.Enabled And btnGravar.CanFocus Then
  Begin
    blnMudarFoco := False;
    pSetFocus(btnGravar);
  End;
end;

procedure TfrmCadDefeitos.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  if not fCfgSis('DFEFAB', varBoolean) then
  begin
    Self.Height := 150;
    tbsRelFab.TabVisible := False;
    tbsGeral.TabVisible  := False;
    tbsGeral.Visible     := True;
  end
  else
    pInicializaRelFab;

  intPaginasAtivas := fGetPagAtivas;
end;

procedure TfrmCadDefeitos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if tbsRelFab.TabVisible then
  begin
    tbsRelFab.Enabled := False;
    btnCancelaRel.Click;
    pCarregaDefeitosRelacionados;
  end;
end;

procedure TfrmCadDefeitos.btnCancelaRelClick(Sender: TObject);
begin
  inherited;
  cmbRelFab.ItemIndex := 0;
  edtCodDfe.Clear;
  edtDesDfe.Clear;
  pSetFocus(cmbRelFab);
end;

procedure TfrmCadDefeitos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadDefeitos.btnExcluirClick]');
    End;
  End;

  if (blnExcluiu) and (tbsRelFab.TabVisible) then
  begin
    fCommit;
    cdsDfeRel.EmptyDataSet
  end
  else if (blnExcluiu) then
    fCommit
  else
    fRollBack;
end;

procedure TfrmCadDefeitos.btnGravarClick(Sender: TObject);
var
  strSQL: String;
  qryGravar: TUniQuery;
  cdsDados: TUniClientDataSet;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;

  if (blnGravou) and (tbsRelFab.TabVisible) then
  begin
    qryGravar := fCriaQuery;
    cdsDados  := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsDados, cdsDfeRel);

    cdsDados.Filtered := False;
    cdsDados.Filter   := 'OPERAC <> ''''';
    cdsDados.Filtered := True;

    try
      try
        cdsDados.First;
        while not cdsDados.Eof do
        begin
          if cdsDados.FieldByName('OPERAC').AsString = 'I' then
          begin
            strSQL := '';
            strSQL := strSQL + 'INSERT INTO RELDFE (AUTOINCREM, REL_CODDFE, REL_DFEFAB, REL_SEQREL) ';
            strSQL := strSQL + 'VALUES (:AUTOINCREM, :CODDFE, :DFEFAB, :SEQREL)';
            qryGravar.Close;
            qryGravar.SQL.Clear;
            qryGravar.SQL.Text := strSQL;
            qryGravar.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('RELDFE', VS_strCodEmp);
            qryGravar.ParamByName('CODDFE').AsString := qryTabela.FieldByName('DFE_CODIGO').AsString;
            qryGravar.ParamByName('DFEFAB').AsString := cdsDados.FieldByName('DFEFAB').AsString;
            qryGravar.ParamByName('SEQREL').AsString := cdsDados.FieldByName('SEQREL').AsString;
            qryGravar.ExecSQL;
          end
          else if cdsDados.FieldByName('OPERAC').AsString = 'D' then
          begin
            strSQL := '';
            strSQL := strSQL + 'DELETE FROM RELDFE WHERE AUTOINCREM = :AUTOINCREM ';
            qryGravar.Close;
            qryGravar.SQL.Clear;
            qryGravar.SQL.Text := strSQL;
            qryGravar.ParamByName('AUTOINCREM').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;
            qryGravar.ExecSQL;
          end;

          cdsDados.Next;
        end;

        fCommit;
        cdsDfeRel.EnableControls;
        pCarregaDefeitosRelacionados;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message,'[TfrmCadDefeitos.btnGravarClick]');
        End;
      end;
    finally
      FreeAndNil(qryGravar);
      FreeAndNil(cdsDados);
    end;

    btnCancelaRel.Click;
  end
  Else If (blnGravou) Then
    fCommit
  Else
    fRollBack;

  tbsRelFab.Enabled := False;
end;

procedure TfrmCadDefeitos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  if tbsRelFab.TabVisible then
  begin
    tbsRelFab.Enabled := True;
    cdsDfeRel.EmptyDataSet;
  end;
end;

procedure TfrmCadDefeitos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrMotivo: TConsultasArray;
begin
  {*****************************}
  {* NOVA CONSULTA DE DEFEITOS *}
  {*****************************}
  chrKey := '/';
  If fPesqDefeito(Self, Nil, Nil, qryTabela, chrKey, arrMotivo) Then
    pSetFocus(btnAlterar);

  if tbsRelFab.TabVisible then
    pCarregaDefeitosRelacionados;
end;

procedure TfrmCadDefeitos.cmbRelFabChange(Sender: TObject);
begin
  inherited;

  if cmbRelFab.Text <> '' then
  begin
    qryRelFab.Locate('DESMAR', cmbRelFab.Text, []);

    if fVerificaTabela then
      pCarregComboDfeFab;
  end;
end;

function TfrmCadDefeitos.fGetPagAtivas: Integer;
var
  intCnt : Integer;
begin
  Result := 0;
  For intCnt := 0 to pgcDados.PageCount - 1 Do
  Begin
    If pgcDados.Pages[intCnt].TabVisible Then
      Result := Result + 1;
  End;
end;

procedure TfrmCadDefeitos.btnAdicionarRelClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(cmbRelFab.Text) then
  begin
    fMensagem('ATENÇÃO', 'Favor escolher um fabricante!', ['&Ok']);
    Exit;
  end;

  if fEmptyStr(edtDesDfe.Text) then
  begin
    fMensagem('ATENÇÃO', 'Favor escolher um defeito!', ['&Ok']);
    Exit;
  end;

  if not Assigned(cdsDfeRel) then
    Exit;

  if (not fVerificaTabela) then
    Exit;

  if cdsDfeRel.Locate('SEQREL;DFEFAB', VarArrayOf([qryRelFab.FieldByName('AUTOINCREM').AsString, qryTabDin.FieldByName('REL_CODDEF').AsString]), []) then
  begin
    btnCancelaRel.Click;
    Exit;
  end;

  cdsDfeRel.Append;
  cdsDfeRel.FieldByName('DESMAR').AsString := qryRelFab.FieldByName('DESMAR').AsString;
  cdsDfeRel.FieldByName('DFEFAB').AsString := qryTabDin.FieldByName('REL_CODDEF').AsString;
  cdsDfeRel.FieldByName('DESDFE').AsString := qryTabDin.FieldByName('REL_DESDEF').AsString;
  cdsDfeRel.FieldByName('SEQREL').AsString := qryRelFab.FieldByName('AUTOINCREM').AsString;
  cdsDfeRel.FieldByName('OPERAC').AsString := 'I';
  cdsDfeRel.Post;

  btnCancelaRel.Click;
end;

procedure TfrmCadDefeitos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  tbsRelFab.Enabled := True;
end;

procedure TfrmCadDefeitos.dbgGridDfeRelKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
    pExcluirDfeRel();
end;

procedure TfrmCadDefeitos.edtCodDfeKeyPress(Sender: TObject; var Key: Char);
var
  arrDefeitos: TConsultasArray;
begin
  inherited;

  if (cmbRelFab.Text = '') then
  begin
    fMensagem('', 'Selecione um fabricante.', ['&O k']);
    pSetFocus(cmbRelFab);
    Exit;
  end;

  if (not fVerificaTabela) then
    Exit;

  If fPesqDefeitosFab(Self, qryRelFab.FieldByName('TABREL').AsString, edtCodDfe, edtDesDfe, Nil, Key, arrDefeitos) Then
  Begin
    if not fEmptyStr(edtDesDfe.Text) then
      qryTabDin.Locate('REL_DESDEF', edtDesDfe.Text, []);

    SelectNext(ActiveControl, True, True);
  End;
end;

end.
