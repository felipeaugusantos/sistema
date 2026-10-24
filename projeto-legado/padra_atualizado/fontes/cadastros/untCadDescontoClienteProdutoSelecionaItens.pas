unit untCadDescontoClienteProdutoSelecionaItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, DBClient, Provider, Uni, AppEvnts, Menus, StdCtrls,
  EditFocus, Mask, MaskEditFocus, Grids, DBGrids, Buttons, ExtCtrls, untFuncoesSimples,
  BitBtnLockedIncrem, QColorLabel, strUtils, Gauges, UniClientDataSet,
  UniDataSetProvider, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade,
  DBGridCitel, untTypesSistema;

type
  TfrmCadDescontoClienteProdutoSelecionaItens = class(TfrmPaiOrdena)
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    mskLinGru: TMaskEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtDesGru: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    lbl4: TLabel;
    clb1: TColorLabel;
    edtNvlGir: TEditFocus;
    btnCarregarItens: TBitBtnLocked;
    dbgAnalitico: TDBGridCitel;
    dtsAnalitico: TDataSource;
    pbProgresso: TGauge;
    pnl1: TPanel;
    edtQtdVen: TEditFocus;
    edtTotVen: TEditFocus;
    edtPerRep: TEditFocus;
    edtTotCus: TEditFocus;
    edtSalEst: TEditFocus;
    edtValEst: TEditFocus;
    lbl5: TLabel;
    pnl2: TPanel;
    lbl6: TLabel;
    edtTotVenGer: TEditFocus;
    edt3: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregarItensClick(Sender: TObject);
    procedure dbgConsultaTitleClick(Column: TColumn);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    intGlobal: Integer;
    cdsItensAnalitico: TUniClientDataSet;
    procedure pSintetizarCdsConsulta;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pFormataValores(DataSet: TDataSet);
  public
    { Public declarations }
    arrItensSelecionados: TStringArray;
    fltPercentualDesconto: Double;    
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; Override;
  end;


implementation

uses untConsultas, untFuncoes, untConstantesNFe, untConstantes;

{$R *.dfm}

procedure TfrmCadDescontoClienteProdutoSelecionaItens.btnCarregarItensClick(
  Sender: TObject);
begin
  inherited;
  If fValidaPanel(pnlHeader, True) And fAbreConsulta(True) Then
  Begin
    pSetFocus(dbgConsulta);
  End;  
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  If stlListSelecao.Count = 0 Then
  Begin
    pMensagemOk('Não há produtos selecionados!');
  End
  Else If Not fDigitaValor(fltPercentualDesconto, 'Percentual de Desconto') Or
              (fltPercentualDesconto <= 0) Or (fltPercentualDesconto > 100) Then
  Begin
    pMensagemOk('Informe o percentual de desconto corretamente!');
  End
  Else
  Begin
    SetLength(arrItensSelecionados, 0);

    With cdsConsulta Do
    Begin
      AfterScroll := nil;

      pbProgresso.Visible := True;
      pbProgresso.MaxValue := RecordCount;

      First;
      While Not Eof Do
      Begin
        pbProgresso.Progress := RecNo;
        Application.ProcessMessages;

        If stlListSelecao.IndexOf(FieldByName('AUTOINCREM').AsString) > -1 Then
          pAddDados(arrItensSelecionados, FieldByName('CODITE').AsString);

        Next;
      End;
    End;

    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;                
  pDesmarcaTodos;
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  Try
    cdsConsulta.AfterScroll := Nil;
    pMarcaTodos;
  Finally
    cdsConsulta.AfterScroll := pAfterScroll;
    cdsConsulta.First;    
  End;    
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.dbgConsultaTitleClick(
  Column: TColumn);
begin
//  inherited;
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.edtCodCliKeyPress(Sender: TObject;
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

procedure TfrmCadDescontoClienteProdutoSelecionaItens.edtCodForKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.edtCodMarKeyPress(
  Sender: TObject; var Key: Char);
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

procedure TfrmCadDescontoClienteProdutoSelecionaItens.FormActivate(
  Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.FormCreate(Sender: TObject);
begin
  inherited;
  intGlobal := 2;
  blnTemPesquisa := False;  
  blnSempreRelerBanco := False;
  blnSelecionaComEnter := True;
  blnQuoteLista := False;
  cdsItensAnalitico := TUniClientDataSet.Create(Self);
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.pAfterScroll(
  DataSet: TDataSet);
  Var
    fltQtdIte: Double;
    fltTotIte: Double;
    fltTotCus: Double;
    fltSalEst: Double;
    fltValEst: Double;
begin
  If Not Assigned(cdsItensAnalitico) Or Not cdsItensAnalitico.Active Then
  Begin
    Exit;
  End;

  cdsItensAnalitico.Filtered := False;
  cdsItensAnalitico.Filter   := 'CODITE = ' + QuotedStr(DataSet.FieldByName('CODITE').AsString);
  cdsItensAnalitico.Filtered := True;

  fltQtdIte := 0.00;
  fltTotIte := 0.00;
  fltTotCus := 0.00;
  fltSalEst := 0.00;
  fltValEst := 0.00;

  With cdsItensAnalitico Do
  Begin
    First;
    While Not Eof Do
    Begin
      fltQtdIte := fltQtdIte + FieldByName('QTDITE').AsFloat;
      fltTotIte := fltTotIte + FieldByName('TOTITE').AsFloat;
      fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
      fltSalEst := fltSalEst + FieldByName('SALEST').AsFloat;
      fltValEst := fltValEst + FieldByName('VALEST').AsFloat;
      Next;
    End;
    First;
  End;

  edtQtdVen.Text := FormatFloat('#,##0.00', fltQtdIte);
  edtTotVen.Text := FormatFloat('#,##0.00', fltTotIte);
  edtTotCus.Text := FormatFloat('#,##0.00', fltTotCus);
  edtSalEst.Text := FormatFloat('#,##0.000', fltSalEst);
  edtValEst.Text := FormatFloat('#,##0.00', fltValEst);
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.pSintetizarCdsConsulta;
  Var
    fltTotVenGer: Double;
begin
  Try
    cdsConsulta.DisableControls;
    cdsItensAnalitico.DisableControls;

    dtsAnalitico.DataSet := nil;

    cdsConsulta.IndexFieldNames := '';

    cdsConsulta.AfterScroll := nil;
    cdsItensAnalitico.Filtered := False;
    cdsItensAnalitico.Data := cdsConsulta.Data;

    qryConsulta.Close;
    cdsConsulta.EmptyDataSet;

    blnPodeIncluir := True;
    fltTotVenGer := 0.00;

    pbProgresso.Visible := True;

    With cdsItensAnalitico Do
    Begin
      pbProgresso.MaxValue := RecordCount;
      IndexFieldNames := 'CODITE;CODEMP';      

      First;
      While Not Eof Do
      Begin
        pbProgresso.Progress := RecNo;
        Application.ProcessMessages;
        fltTotVenGer := fltTotVenGer + FieldByName('TOTITE').AsFloat;
        Next;
      End;

      First;
      While Not Eof Do
      Begin
        pbProgresso.Progress := RecNo;
        Application.ProcessMessages;
        If Not cdsConsulta.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
        Begin
          cdsConsulta.Append;
          cdsConsulta.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
          cdsConsulta.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
          cdsConsulta.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
          cdsConsulta.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
          cdsConsulta.FieldByName('SIGUNI').AsString := FieldByName('SIGUNI').AsString;
          cdsConsulta.FieldByName('ESTMIN').AsFloat  := FieldByName('ESTMIN').AsFloat;
        End
        Else
          cdsConsulta.Edit;

        cdsConsulta.FieldByName('QTDITE').AsFloat := cdsConsulta.FieldByName('QTDITE').AsFloat + FieldByName('QTDITE').AsFloat;
        cdsConsulta.FieldByName('TOTCUS').AsFloat := cdsConsulta.FieldByName('TOTCUS').AsFloat + FieldByName('TOTCUS').AsFloat;
        cdsConsulta.FieldByName('TOTITE').AsFloat := cdsConsulta.FieldByName('TOTITE').AsFloat + FieldByName('TOTITE').AsFloat;

        If fltTotVenGer <> 0.00 Then
          cdsConsulta.FieldByName('PERREP').AsFloat := cdsConsulta.FieldByName('TOTITE').AsFloat / fltTotVenGer * 100;

        cdsConsulta.FieldByName('ORDABC').AsFloat := (-1) * cdsConsulta.FieldByName('TOTITE').AsFloat;          

        cdsConsulta.Post;

        Edit;
        If cdsConsulta.FieldByName('TOTITE').AsFloat <> 0.00 Then
          FieldByName('PERREP').AsFloat := FieldByName('TOTITE').AsFloat / cdsConsulta.FieldByName('TOTITE').AsFloat * 100;
        Post;

        Next;
      End;
      First;
    End;

    cdsConsulta.AfterScroll := pAfterScroll;

    blnPodeIncluir := False;

    pFormataValores(cdsConsulta);
    pFormataValores(cdsItensAnalitico);

    cdsConsulta.IndexFieldNames := 'ORDABC';    

    edtTotVenGer.Text := FormatFloat('#,##0.00', fltTotVenGer);
        
  Finally
    pbProgresso.Visible := False;  
    cdsConsulta.EnableControls;
    cdsItensAnalitico.EnableControls;
    dtsAnalitico.DataSet := cdsItensAnalitico;
    cdsConsulta.First;
  End;
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.pFormataValores(DataSet: TDataSet);
  Var
    intIndex: integer;
Begin
  If DataSet.Active Then
    With DataSet.Fields Do
    For intIndex := 1 To Count - 1 Do
      Case Fields[intIndex].DataType Of
        ftFloat: TFloatField(Fields[intIndex]).DisplayFormat := '#,##0.00';
      End;
End;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: If ((ActiveControl) <> mskDtaIni) Then
               Begin
                 If mskDtaIni.CanFocus Then
                   pSetFocus(mskDtaIni);
               End

               Else inherited;

    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarcaTodos.Click;
    VK_F10: btnConfirma.Click;

    Else inherited;
  End;
end;

function TfrmCadDescontoClienteProdutoSelecionaItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := 'TODOS'
      End
      Else If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!','Nenhum cliente encontrado com este código!',['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
        edtDesFor.Text := 'TODOS'
      Else
      Begin
        edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If Not fEmptyStr(edtCodFor.Text) And fEmptyStr(edtDesFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Nenhum fornecedor encontrado com este código!',['&Ok']);
          Result := False;
        End;
      eND;
    End
    Else If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
        edtDesMar.Text := 'TODAS'
      Else
      Begin
        edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
        If Not fEmptyStr(edtCodMar.Text) And fEmptyStr(edtDesMar.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Nenhuma marca encontrada com este código!',['&Ok']);
          Result := False;
        End;
      End;  
    End
    Else If (Sender = mskLinGru) Then
    Begin
      If fEmptyStr(mskLinGru.Text) Then
        edtDesGru.Text := 'TODOS'
      Else
      Begin
        edtDesGru.Text := fRetNomeLinhaGrupo(mskLinGru.Text);
        If fEmptyStr(edtDesGru.Text) And (Not fEmptyStr(mskLinGru.Text))  Then
        Begin
          fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser preenchida!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          StrToDate(mskDtaIni.Text);
        Except
          fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    {***********************}
    {* VALIDA DATA FINAL   *}
    {********************RL*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data final deve ser preenchida!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          If StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text) Then
          Begin
            fMensagem('ATENÇÃO!','A data final deve ser maior que a data incial!',['&Ok']);
            Result := False;
          End;
        Except
          fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtNvlGir) Then
    Begin
      If fEmptyStr(edtNvlGir.Text) Or (Pos(edtNvlGir.Text, 'A_B_C_T_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Nível de Giro do Produto corretamente!!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadDescontoClienteProdutoSelecionaItens.mskLinGruKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadDescontoClienteProdutoSelecionaItens.fGetSql(blnLike: Boolean): String;
  Var
    strSQL : String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   C.AUTOINCREM, ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   C.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   I.ITE_ESTMIN AS ESTMIN, ';
  strSQL := strSQL + '   I.ITE_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   E.EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_QTDITE), D.DET_QTDITE)) AS QTDITE, ';
  strSQL := strSQL + '   SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTCUS), D.DET_TOTCUS)) AS TOTCUS, ';
  strSQL := strSQL + '   SUM(IF(D.DET_ESPDOC = "BR", 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))) AS TOTITE, ';
  strSQL := strSQL + '   I.ITE_SALDOS AS SALEST, ';
  strSQL := strSQL + '   I.ITE_PRECUS AS PRECUS  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET D ';
  strSQL := strSQL + '   INNER JOIN CADITE C ON D.DET_CODITE = C.ITE_CODITE ';
  strSQL := strSQL + '   INNER JOIN ITEGER I ON D.DET_CODITE = I.ITE_CODITE AND D.DET_CODEMP = I.ITE_CODEMP ';
  strSQL := strSQL + '   INNER JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '   INNER JOIN CADEMP E ON I.ITE_CODEMP = E.EMP_CODEMP ';  
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + cnsFiltroFFDVTR;
  strSQL := strSQL + '       DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '   AND ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

  If fCfgSis('ENTBRF', varBoolean) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR")) '
  Else
    strSQL := strSQL + ') ';

  strSQL := strSQL + ' AND DET_PROEMB <> "S" ';
  strSQL := strSQL + ' AND DET_TIP_FC = "C" ';
  strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + '  AND DET_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodMar.Text) Then
    strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

  If Not fEmptyStr(edtCodFor.Text) Then
    strSQL := strSQL + '  AND ITE_CODFOR = :CODFOR ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskLinGru.Text)) Then
  Begin
    If RightStr(mskLinGru.Text,3) = '000' Then
      strSQL := strSQL + '  AND LEFT(ITE_CODGRU, 3) = LEFT(:CODGRU, 3) '
    Else
      strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
  End;

  If edtNvlGir.Text <> 'T' Then
    strSQL := strSQL + '  AND ITE_NVLGIR = :NVLGIR ';

  strSQL := strSQL + '  GROUP BY ';
  strSQL := strSQL + '    D.DET_CODITE, D.DET_CODEMP ';      

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '   AUTOINCREM, ';
  Result := Result + '   CODITE, ';
  Result := Result + '   DESITE, ';
  Result := Result + '   REFERE, ';
  Result := Result + '   SIGUNI, ';
  Result := Result + '   ESTMIN, ';
  Result := Result + '   CODEMP, ';
  Result := Result + '   NOMEMP, ';
  Result := Result + '   SUM(QTDITE)  AS QTDITE, ';
  Result := Result + '   SUM(TOTCUS)  AS TOTCUS, ';
  Result := Result + '   SUM(TOTITE)  AS TOTITE, ';
  Result := Result + '   0.00         AS PERREP, ';
  Result := Result + '   0.00         AS ORDABC, ';  
  Result := Result + '   SALEST, ';
  Result := Result + '   SALEST * PRECUS AS VALEST ';
  Result := Result + ' FROM ';
  Result := Result + '   (' + strSQL + ') AS VENDAS ';
  Result := Result + ' GROUP BY ';
  Result := Result + '    CODITE, CODEMP ';
  Result := Result + ' ORDER BY ';
  Result := Result + '    CODITE, CODEMP ';
End;

function TfrmCadDescontoClienteProdutoSelecionaItens.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Try
    stlListSelecao.Clear;
    Screen.Cursor := crHourGlass;    
    Result := inherited fAbreConsulta(blnLike);
    pSintetizarCdsConsulta;
  Finally
    Screen.Cursor := crDefault;  
  End;
End;

function TfrmCadDescontoClienteProdutoSelecionaItens.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    ParamByName('CLAVEN').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Not fEmptyStr(edtCodFor.Text) Then
      ParamByName('CODFOR').AsString := edtCodFor.Text;

    If Not fEmptyStr(edtCodMar.Text) Then
      ParamByName('CODMAR').AsString := edtCodMar.Text;

    If Not fEmptyStr(mskLinGru.Text) Then
      ParamByName('CODGRU').AsString := mskLinGru.Text;

    If edtNvlGir.Text <> 'T' Then
      ParamByName('NVLGIR').AsString := edtNvlGir.Text;
  End;

  Result := True;
End;

end.
