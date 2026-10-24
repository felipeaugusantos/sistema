unit untAltGlobalServico;

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  untPai,
  AppEvnts,
  Menus,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ComCtrls,
  EditFocus,
  Grids,
  DBGridCitel,
  DBGrids,
  DB,
  Uni,
  BitBtnLockedIncrem,
  frxClass,
  frxExportCSVTestabilidade,
  untFuncoesConsulta,
  untConsultas,
  SysUtils,
  untFuncoesSimples,
  untTypesSistema;

type
  TfrmAltGlobalServico = class(TfrmPai)
    pnlFundo: TPanel;
    dbgGrid: TDBGridCitel;
    btnConfirma: TBitBtnLocked;
    btnLimparBusca: TBitBtnLocked;
    pgbStatus: TProgressBar;
    pnlSuperior: TPanel;
    lbl2: TLabel;
    lblValEnt: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodSer: TEditFocus;
    edtDesSer: TEditFocus;
    edtValNov: TEditFocus;
    edtValPesq: TEditFocus;
    edtDesGru: TEditFocus;
    edtCodGru: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lblValCus: TLabel;
    edtValCus: TEditFocus;
    procedure edtCodSerKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimparBuscaClick(Sender: TObject);
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtValNovEnter(Sender: TObject);
    procedure edtValCusEnter(Sender: TObject);
  private
    { Private declarations }
    qryGrid: TUniQuery;
    dtsGrid: TDataSource;
    blnAltPorFator: boolean;
    arrEmpres, arrGruSer, arrServ: TConsultasArray;
    procedure pCarregaGrid;
    procedure pLimpaTela;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pExibeEditFatorCusto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmAltGlobalServico.btnConfirmaClick(Sender: TObject);
  Var
    strSQL : String;
begin
  inherited;
  If (fMensagem('', 'Confirma alteração?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    btnConfirma.Enabled := False;

    Try

      fStartTransaction;

      qryGrid.DisableControls;
      qryGrid.First;

      If Not qryGrid.IsEmpty Then
      Begin
        pgbStatus.Visible := True;
        pgbStatus.Max := qryGrid.RecordCount;

        While Not qryGrid.Eof Do
        Begin
          strSQl := 'UPDATE CADSER ' + ' SET    SER_VALSER = ' + fReplaceStr(qryGrid.FieldByName('SER_VALNOV').AsString, ',', '.');

          If (edtValCus.Visible) Then
            strSQl := strSQl +', SER_VALCUS = ' + fReplaceStr(qryGrid.FieldByName('SER_CUSNOV').AsString, ',', '.');

          strSQl := strSQl +' WHERE  AUTOINCREM = ' + QuotedStr(qryGrid.FieldByName('AUTOINCREM').AsString);

          fExecutaSQL(strSQL);

          qryGrid.Next;
          pnlInfo.Caption := 'Registro: ' + IntToStr(qryGrid.RecNo) + '/' + IntToStr(qryGrid.RecordCount);
          pgbStatus.Position := qryGrid.RecNo;
          Application.ProcessMessages;
        End;

      End;

      fCommit;
      fMensagem('', 'Alteração efetuada com sucesso em ' + IntToStr(qryGrid.RecordCount) + ' Serviços!', ['&OK']);

      qryGrid.Close;
      qryGrid.EnableControls;

      pgbStatus.Visible := False;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        fRollBack;
        pgbStatus.Visible := False;
        qryGrid.EnableControls;
        pLimpaTela;
      End;

    End;

    btnConfirma.Enabled := True;
  End;
  pnlInfo.Caption := '';
  pLimpaTela;
  SelectFirst;
end;

procedure TfrmAltGlobalServico.btnLimparBuscaClick(Sender: TObject);
begin
  inherited;
  pLimpaTela;
  pSetFocus(edtCodSer);
end;

procedure TfrmAltGlobalServico.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);

end;

procedure TfrmAltGlobalServico.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalServico.edtCodGruKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqGrupoServicos(Self, edtCodGru, edtDesGru, nil, Key, arrGruSer) Then
    If fValidaCampos(edtCodGru) Then
      SelectNext(edtCodGru, True, True);
end;

procedure TfrmAltGlobalServico.edtCodSerKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqServicos(Self, edtCodSer, edtDesSer, Nil, Key, arrServ) Then
  Begin
    If fValidaCampos(edtCodSer, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltGlobalServico.edtValCusEnter(Sender: TObject);
begin
  inherited;
  edtValCus.SelectAll;
end;

procedure TfrmAltGlobalServico.edtValNovEnter(Sender: TObject);
begin
  inherited;
  edtValNov.SelectAll;
end;

procedure TfrmAltGlobalServico.pExibeEditFatorCusto;
Begin
  edtValCus.Visible := fCfgSis('AUTCEN', varBoolean);
  lblValCus.Visible := edtValCus.Visible;
  If (Not edtValCus.Visible) Then
  Begin
    pnlSuperior.Height :=  pnlSuperior.Height - edtValCus.Height;
    fFindColumnByName(dbgGrid, 'SER_VALCUS').Visible := edtValCus.Visible;
    fFindColumnByName(dbgGrid, 'SER_CUSNOV').Visible := edtValCus.Visible;
    Self.Width := 523;
  End;

End;

procedure TfrmAltGlobalServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryGrid);
  FreeAndNil(dtsGrid);
end;

procedure TfrmAltGlobalServico.FormCreate(Sender: TObject);
begin
  inherited;
  blnAltPorFator := fMensagem('', 'Alteração Por:', ['&Fator', '&Valor'])=1;

  If (Not blnAltPorFator) Then
  Begin
    lblValEnt.Caption := 'Novo Valor(R$) do Serviço:';
    lblValCus.Caption := 'Novo Valor(R$) do Custo:';
    edtValNov.text := '0';
    edtValCus.text := '0';
  End
  Else
  Begin
    lblValEnt.Caption := 'Fator para aplicar no Valor do Serviço:';
    lblValCus.Caption := 'Fator para aplicar no Valor do Custo:';
    edtValNov.text := '1';
    edtValCus.text := '1';
  End;

  qryGrid := fCriaQuery;
  dtsGrid := TDataSource.Create(Self);
  pExibeEditFatorCusto;
  dtsGrid.DataSet := qryGrid;
  dbgGrid.DataSource := dtsGrid;
  qryGrid.AfterOpen := pAfterOpen;
  edtValNov.text := '0';
  edtValCus.text := '0';
end;

function TfrmAltGlobalServico.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodSer) Then
  begin
    If fEmptyStr(edtCodSer.Text) then
      edtDesSer.Text := 'TODOS'
    else
      edtDesSer.Text := fRetNomeServico(edtCodSer.Text);
  end;

  If (Sender = edtCodGru) Then
  begin
    If fEmptyStr(edtCodGru.Text) then
      edtDesGru.Text := 'TODOS'
    else
      edtDesGru.Text := fRetNomeGrupoServico(edtCodGru.Text);
  end;

  If (Sender = edtValNov) Then
  Begin

    If Not fEmptyStr(edtValNov.Text) Then
    Begin
      If (Not blnAltPorFator) and (fStrToFloat(edtValNov.Text) < 0) Then
      Begin
        fMensagem('AVISO', 'Valor do serviço  não pode ser negativo!', ['&Ok']);
        Result := False;
      End
      Else
        pCarregaGrid;
    End
    Else
    Begin
      fMensagem('AVISO', 'Informe o Valor do serviço!', ['&OK']);
      Result := False;
    End;

  End;

  If (Sender = edtValCus) Then
  Begin

    If Not fEmptyStr(edtValCus.Text) Then
    Begin
      If (Not blnAltPorFator) and (fStrToFloat(edtValCus.Text) < 0) Then
      Begin
        fMensagem('AVISO', 'Valor do Custo  não pode ser negativo!', ['&Ok']);
        Result := False;
      End
      Else
        pCarregaGrid;
    End
    Else
    Begin
      fMensagem('AVISO', 'Informe o Valor do Custo!', ['&OK']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltGlobalServico.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('SER_VALSER')).DisplayFormat := '#,#0.00';
  TFloatField(DataSet.FieldByName('SER_VALNOV')).DisplayFormat := '#,#0.00';
  If (edtValCus.Visible) Then
  Begin
    TFloatField(DataSet.FieldByName('SER_VALCUS')).DisplayFormat := '#,#0.00';
    TFloatField(DataSet.FieldByName('SER_CUSNOV')).DisplayFormat := '#,#0.00';
  End;
end;

procedure TfrmAltGlobalServico.pCarregaGrid;
Var
  strSQL, strCodEmp: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM,       ';
    strSQL := strSQL + '  CONCAT(SER_CODSER," - ",SER_DESSER) AS SER_DESSER, ';
    strSQL := strSQL + '  IFNULL(SER_VALSER,0)                AS SER_VALSER, ';
    strSQL := strSQL + '  IFNULL(SER_VALCUS,0)                AS SER_VALCUS, ';

    If (Not blnAltPorFator) Then
    Begin
      strSQL := strSQL + ' ' + fReplaceStr(edtValNov.Text, ',', '.') + ' AS SER_VALNOV ';

      If (edtValCus.Visible) Then
        strSQL := strSQL + ', ' + fReplaceStr(edtValCus.Text, ',', '.') + ' AS SER_CUSNOV '
    End
    Else
    Begin
      strSQL := strSQL + ' IFNULL(' + fReplaceStr(edtValNov.Text,',','.') + ' * SER_VALSER, 0) AS SER_VALNOV ';

      If (edtValCus.Visible) Then
        strSQL := strSQL + ', IFNULL(' + fReplaceStr(edtValCus.Text,',','.') + ' * SER_VALCUS, 0) AS SER_CUSNOV ';
    End;

    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADSER ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  TRUE   ';

    If Not fEmptyStr(edtCodSer.Text) Then
      strSQL := strSQL + '  AND SER_CODSER = :SER_CODSER ';

    If Not fEmptyStr(edtCodGru.Text) Then
      strSQL := strSQL + '  AND SER_CODGRU = :SER_CODGRU ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmp , arrEmpres  , 'SER_CODEMP', 'SER_CODEMP');

    If Not fEmptyStr(edtValPesq.Text) Then
      strSQL := strSQL + '  AND SER_VALSER = :SER_VALSER ';

    strSQL := strSQL + ' ORDER BY SER_DESSER ';

    qryGrid.Close;
    qryGrid.SQL.Clear;
    qryGrid.SQL.Add(strSQL);

    If Not fEmptyStr(edtCodSer.Text) Then
      qryGrid.ParamByName('SER_CODSER').AsString := edtCodSer.Text;

    If Not fEmptyStr(edtCodGru.Text) Then
      qryGrid.ParamByName('SER_CODGRU').AsString := edtCodGru.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text, arrEmpres, strCodEmp, 'SER_CODEMP', qryGrid);

    If Not fEmptyStr(edtValPesq.Text) Then
      qryGrid.ParamByName('SER_VALSER').AsString := fReplaceStr(edtValPesq.Text, ',', '.');

    qryGrid.Open;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      pgbStatus.Visible := False;
    End;
  End;
end;

procedure TfrmAltGlobalServico.pLimpaTela;
begin
  edtCodSer.Clear;
  edtCodGru.Clear;
  edtCodGru.Clear;
  edtValPesq.Clear;
  edtValNov.Text := '0';
  edtValCus.Text := '0';
  qryGrid.Close;
end;

end.
