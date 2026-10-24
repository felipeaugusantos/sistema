unit untFatImportarItensRemessa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, UniClientDataSet, cxProgressBar, untTypesSistema;

type
  TfrmFatImportarItensRemessa = class(TfrmPaiConfirma)
    pnlTop: TPanel;
    lblNumEspDoc: TLabel;
    lblEmpresa: TLabel;
    lblCliFor: TLabel;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodigoCliente: TEditFocus;
    edtNomeCliente: TEditFocus;
    btnPesquisa: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnSelecionarTodos: TBitBtnLocked;
    pnlGrid: TPanel;
    cxGridCitel1: TcxGridCitel;
    grdDocumentos: TcxGridDBTableViewCitel;
    grdDocumentosColumn1: TcxGridDBColumn;
    grdDocumentosColumn2: TcxGridDBColumn;
    grdDocumentosColumn3: TcxGridDBColumn;
    grdDocumentosColumn4: TcxGridDBColumn;
    grdDocumentosColumn5: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    pnlButtom: TPanel;
    chkDesconsiderarQtdFat: TCheckBox;
    grdDocumentosColumn6: TcxGridDBColumn;
    dtsDocumentos: TDataSource;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelecionarTodosClick(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    cdsRemessa: TUniClientDataSet;
    function fCarregarDocumentos(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fSQLRemessa: String;
    function fSQLItens: String;
    function fRetornaPrecoRemessaCfg: String;
    function fImportaItens(pgbStatus: TcxProgressBar): Boolean;
    function fRetornaWhereSQLRemessa: String;
    procedure pAdicionarDocumento(strAutInc, strNumDoc, strEspcDoc, strEmpDoc, strCliente, strCodCli: String; strDtaEnt: TDateTime);
    procedure pCriaCdsRemessa;
  public
    { Public declarations }
    fIncluirItem: TfIncluiItem;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fCarregaItensRemessa: Boolean;
  end;

var
  frmFatImportarItensRemessa: TfrmFatImportarItensRemessa;

implementation

uses untGravando, untFuncoesSimples, untConsultas, Uni;

{$R *.dfm}

procedure TfrmFatImportarItensRemessa.btnPesquisaClick(Sender: TObject);
  Var
    frmGravando: TfrmGravando;
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fCarregarDocumentos;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmFatImportarItensRemessa.btnSelecionarTodosClick(Sender: TObject);
  Var
    Posicao: TBookmark;
  Const
    CAMPO_SELECAO = 'DOC_CHECKD';
begin
  inherited;

  If cdsRemessa.IsEmpty Then
    Exit;

  cdsRemessa.DisableControls;
  Posicao := cdsRemessa.GetBookmark;
  Try

    cdsRemessa.First;
    While Not cdsRemessa.Eof Do
    Begin
      cdsRemessa.Edit;
      cdsRemessa.FieldByName(CAMPO_SELECAO).AsBoolean := True;
      cdsRemessa.Post;

      cdsRemessa.Next;
    End;
  Finally
    cdsRemessa.EnableControls;
    If cdsRemessa.BookmarkValid(Posicao) Then
      cdsRemessa.GotoBookmark(Posicao);
  End;
end;

procedure TfrmFatImportarItensRemessa.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatImportarItensRemessa.edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodigoCliente, edtNomeCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodigoCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatImportarItensRemessa.fCarregaItensRemessa: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fImportaItens;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmFatImportarItensRemessa.fCarregarDocumentos(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryRemessa: TUniQuery;
begin
  Result := True;

  cdsRemessa.EmptyDataSet;

  pInfoStatusGravacao(pgbStatus, 'Carregando Documentos, Aguarde....');

  qryRemessa := fCriaQuery;
  Try
    With qryRemessa Do
    Begin
      SQL.Text := fSQLRemessa;
      Open;

      If IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foram encontrados documentos com esses filtros!', ['&O k']);
        Exit;
      End;

      First;
      While Not Eof Do
      Begin
        pAdicionarDocumento(FieldByName('AUTOINCREM').AsString,
                            FieldByName('NUMDOC').AsString,
                            FieldByName('ESPDOC').AsString,
                            FieldByName('EMPDOC').AsString,
                            FieldByName('CLIENTE').AsString,
                            FieldByName('CODCLI').AsString,
                            FieldByName('DTAENT').AsDateTime);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryRemessa);
  End;
end;

function TfrmFatImportarItensRemessa.fImportaItens(pgbStatus: TcxProgressBar): Boolean;
  Var
    qryItensRemessa: TUniQuery;
begin
  Result := False;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsRemessa.RecordCount;

  cdsRemessa.First;
  While Not cdsRemessa.Eof Do
  Begin
    pgbStatus.Position := cdsRemessa.RecNo;
    Application.ProcessMessages;

    If cdsRemessa.FieldByName('DOC_CHECKD').AsBoolean Then
    Begin
      qryItensRemessa := fCriaQuery;
      Try
        qryItensRemessa.SQL.Clear;
        qryItensRemessa.SQL.Text := fSQLItens;

        qryItensRemessa.ParamByName('CODEMP').AsString := cdsRemessa.FieldByName('DOC_EMPDOC').AsString;
        qryItensRemessa.ParamByName('NUMDOC').AsString := cdsRemessa.FieldByName('DOC_NUMDOC').AsString;
        qryItensRemessa.ParamByName('ESPDOC').AsString := cdsRemessa.FieldByName('DOC_ESPDOC').AsString;
        qryItensRemessa.ParamByName('CODCLI').AsString := cdsRemessa.FieldByName('DOC_CODCLI').AsString;

        qryItensRemessa.Open;

        qryItensRemessa.First;
        While Not qryItensRemessa.Eof Do
        Begin
          If qryItensRemessa.FieldByName('SALDO').AsFloat > 0 Then
          Begin
            Result := fIncluirItem(qryItensRemessa.FieldByName('CODITE').AsString,
                                   qryItensRemessa.FieldByName('NUMLOT').AsString,
                                   qryItensRemessa.FieldByName('SALDO').AsFloat,
                                   qryItensRemessa.FieldByName('PRECO').AsFloat,
                                   '',
                                   '',
                                   '',
                                   0,
                                   qryItensRemessa.FieldByName('DESITE').AsString);

            If Not Result Then
              Break;
          End;

         qryItensRemessa.Next;
        End;
      Finally
        FreeAndNil(qryItensRemessa);
      End;
    End;

    cdsRemessa.Next;
  End;
end;

procedure TfrmFatImportarItensRemessa.FormCreate(Sender: TObject);
begin
  inherited;

  pCriaCdsRemessa;

  dtsDocumentos.DataSet := cdsRemessa;
end;

procedure TfrmFatImportarItensRemessa.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(cdsRemessa) Then
    FreeAndNil(cdsRemessa);
end;

procedure TfrmFatImportarItensRemessa.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
end;

function TfrmFatImportarItensRemessa.fRetornaPrecoRemessaCfg: String;
begin
  Result := 'G.ITE_PREVE1';

  case StrToIntDef(fCfgSis('PREREM'),-1) of
    0: Result := 'G.ITE_PRECUS';
    1: Result := 'G.ITE_PREMED';
    2: Result := 'G.ITE_PREULT';
    3: Result := 'G.ITE_IMPULT';
    4: Result := 'G.ITE_PREVE1';
    5: Result := 'G.ITE_PREVE2';
    6: Result := 'G.ITE_PREVE3';
    7: Result := 'G.ITE_PREVE4';
    8: Result := 'G.ITE_PREVE5';
    9: Result := 'G.ITE_PREVE6';
    10: Result := 'G.ITE_PREVE7';
  end;
end;

function TfrmFatImportarItensRemessa.fRetornaWhereSQLRemessa: String;
  Var
    strSQLWhere: String;
begin
  strSQLWhere := '';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQLWhere := strSQLWhere + ' AND D.DET_NUMDOC = ' + QuotedStr(edtNumDoc.Text);

  If Not fEmptyStr(edtEspDoc.Text) Then
    strSQLWhere := strSQLWhere + ' AND D.DET_ESPDOC = ' + QuotedStr(edtEspDoc.Text);

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQLWhere := strSQLWhere + ' AND D.DET_CODEMP = ' + QuotedStr(edtCodEmp.Text);

  If Not fEmptyStr(edtCodigoCliente.Text) Then
    strSQLWhere := strSQLWhere + ' AND C.CLI_CODCLI = ' + QuotedStr(edtCodigoCliente.Text);

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
     Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
  Begin
    strSQLWhere := strSQLWhere + ' AND ((D.DET_DTAENT >= '+QuotedStr(FormatDateTime('yyyy-MM-dd', StrToDate(mskDtaIni.Text)))+')';
    strSQLWhere := strSQLWhere + ' AND (D.DET_DTAENT <= '+QuotedStr(FormatDateTime('yyyy-MM-dd', StrToDate(mskDtaFin.Text)))+'))';
  End;

  Result := strSQLWhere;
end;

function TfrmFatImportarItensRemessa.fSQLItens: String;
  Var
    strSQL: String;
    strQtdItem: String;
    strPrecoItem: String;

  Const
    SQL_MOVCON = '(SELECT IFNULL(SUM(IFNULL(CON_QTDITE, 0)), 0) '+
                 'FROM '+
                 '  MOVCON M '+
                 'WHERE M.CON_CODITE = D.DET_CODITE '+
                 '  AND M.CON_NUMDOC = D.DET_NUMDOC '+
                 '  AND M.CON_CODEMP = D.DET_CODEMP '+
                 '  AND M.CON_ESPDOC = D.DET_ESPDOC '+
                 '  AND M.CON_ESPDOC = D.DET_ESPDOC '+
                 '  AND M.CON_TIPMOV = "F" '+
                 '  AND (SELECT X.DET_CODCLI FROM MOVDET X WHERE X.AUTOINCREM = M.CON_SEQGER) <> D.DET_CODCLI)';

begin
  If chkDesconsiderarQtdFat.Checked Then
    strQtdItem := '(D.DET_QTDITE - '+SQL_MOVCON+')'
  Else
    strQtdItem := 'D.DET_QTDITE';

  strPrecoItem := fRetornaPrecoRemessaCfg;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  '+strQtdItem+' AS SALDO, ';
  strSQL := strSQL + '  '+strPrecoItem+' AS PRECO, ';
  strSQL := strSQL + '  D.DET_NUMLOT AS NUMLOT, ';
  strSQL := strSQL + '  D.DET_DESCRI AS DESITE ';
  strSQL := strSQL + 'FROM MOVDET D ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '                      AND G.ITE_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + 'WHERE D.DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND D.DET_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND D.DET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND D.DET_CODCLI = :CODCLI ';

  Result := strSQL;
end;

function TfrmFatImportarItensRemessa.fSQLRemessa: String;
  Var
    strClaEnv: String;
    strSQL: String;
begin
  strClaEnv := '5' + fCfgSis('CFRSAI') + '_' + '6' + fCfgSis('CFRSAI') + '_' + '5' + fCfgSis('CFRSAS') + '_' + '6' + fCfgSis('CFRSAS') + '_';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  D.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  D.DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  D.DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  D.DET_CODEMP AS EMPDOC, ';
  strSQL := strSQL + '  C.CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN CADITE I ';
  strSQL := strSQL + '    ON D.DET_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER P ';
  strSQL := strSQL + '    ON P.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '  INNER JOIN CADCLI C ';
  strSQL := strSQL + '    ON D.DET_CODCLI = C.CLI_CODCLI ';
  strSQL := strSQL + '  INNER JOIN MOVGER G ';
  strSQL := strSQL + '    ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADUNI U ';
  strSQL := strSQL + '    ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  LEFT JOIN ';
  strSQL := strSQL + '    (SELECT ';
  strSQL := strSQL + '      CON_NUMDOC, ';
  strSQL := strSQL + '      CON_ESPDOC, ';
  strSQL := strSQL + '      CON_CODEMP, ';
  strSQL := strSQL + '      CON_CODITE, ';
  strSQL := strSQL + '      SUM(CON_QTDITE) AS CON_QTDITE, ';
  strSQL := strSQL + '      SUM(CON_DESESP) AS CON_DESESP ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' , DET_CODCLI ';

  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      (SELECT ';
  strSQL := strSQL + '        CON_NUMDOC, ';
  strSQL := strSQL + '        CON_ESPDOC, ';
  strSQL := strSQL + '        CON_CODEMP, ';
  strSQL := strSQL + '        CON_CODITE, ';
  strSQL := strSQL + '        CON_QTDITE, ';
  strSQL := strSQL + '        CON_DESESP ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' , DET_CODCLI ';

  strSQL := strSQL + '      FROM ';
  strSQL := strSQL + '        MOVCON ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' INNER JOIN MOVDET ON MOVDET.AUTOINCREM = MOVCON.CON_SEQGER ';

  strSQL := strSQL + '      UNION ';
  strSQL := strSQL + '      ALL ';
  strSQL := strSQL + '      SELECT ';
  strSQL := strSQL + '        CON_NUMDOC, ';
  strSQL := strSQL + '        CON_ESPDOC, ';
  strSQL := strSQL + '        CON_CODEMP, ';
  strSQL := strSQL + '        CON_CODITE, ';
  strSQL := strSQL + '        CON_QTDITE, ';
  strSQL := strSQL + '        CON_DESESP ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' , DET_CODCLI ';

  strSQL := strSQL + '      FROM ';
  strSQL := strSQL + '        NOTCON ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ' INNER JOIN NOTDET ON NOTDET.AUTOINCREM = NOTCON.CON_SEQGER ';

  strSQL := strSQL + ') AS A ';
  strSQL := strSQL + '    GROUP BY CON_NUMDOC, ';
  strSQL := strSQL + '      CON_ESPDOC, ';
  strSQL := strSQL + '      CON_CODEMP, ';
  strSQL := strSQL + '      CON_CODITE ';

  If (fCfgSis('MDLVFE', varString) = '2') Then
    strSQL := strSQL + ', DET_CODCLI ';

  strSQL := strSQL + ') AS R ';

  strSQL := strSQL + '    ON R.CON_NUMDOC = D.DET_NUMDOC  ';
  strSQL := strSQL + '    AND R.CON_ESPDOC = D.DET_ESPDOC ';
  strSQL := strSQL + '    AND R.CON_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + '    AND R.CON_CODITE = D.DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN MOVTRI T ';
  strSQL := strSQL + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + ' WHERE ((D.DET_ESPDOC = "NF" ';
  strSQL := strSQL + '      AND LOCATE(D.DET_CLAFIS, ' + QuotedStr(strClaEnv)+') > 0) ';
  strSQL := strSQL + '       OR (D.DET_ESPDOC = "ER")) ';
  strSQL := strSQL + ' AND C.CLI_REMOUT = "S" ';

  strSQL := strSQL + fRetornaWhereSQLRemessa;

  strSQL := strSQL + ' GROUP BY D.DET_CODCLI, D.DET_NUMDOC ';

  If chkDesconsiderarQtdFat.Checked Then
  Begin
    strSQL := strSQL + ' HAVING ';
    strSQL := strSQL + '  SUM(IFNULL(D.DET_UNITAR, 0.0) * ( ';
    strSQL := strSQL + '    IFNULL(D.DET_QTDITE, 0.0) - IFNULL(R.CON_QTDITE, 0.0) ';
    strSQL := strSQL + '  )) > 0 ';
  End;

  Result := strSQL;
end;

function TfrmFatImportarItensRemessa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
              fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Or
         (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
              fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('','Informe a data inicial e final dos documentos!',['&OK']);
        Result := False;
      End
      Else If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
              Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);

      If Not fEmptyStr(edtNomEmp.Text) Then
      Begin
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Empresa não encontrada!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodigoCliente) Then
    Begin
      edtNomeCliente.Text := fRetNomCliente(edtCodigoCliente.Text);

      If (Not fEmptyStr(edtCodigoCliente.Text)) Then
      Begin
        If fEmptyStr(edtNomeCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatImportarItensRemessa.pAdicionarDocumento(strAutInc, strNumDoc, strEspcDoc, strEmpDoc, strCliente, strCodCli: String; strDtaEnt: TDateTime);
begin
  cdsRemessa.Append;
  cdsRemessa.FieldByName('DOC_CHECKD').AsBoolean  := False;
  cdsRemessa.FieldByName('DOC_AUTINC').AsString   := strAutInc;
  cdsRemessa.FieldByName('DOC_NUMDOC').AsString   := strNumDoc;
  cdsRemessa.FieldByName('DOC_ESPDOC').AsString   := strEspcDoc;
  cdsRemessa.FieldByName('DOC_EMPDOC').AsString   := strEmpDoc;
  cdsRemessa.FieldByName('DOC_CLIENT').AsString   := strCliente;
  cdsRemessa.FieldByName('DOC_CODCLI').AsString   := strCodCli;
  cdsRemessa.FieldByName('DOC_DTAENT').AsDateTime := strDtaEnt;
  cdsRemessa.Post;
end;

procedure TfrmFatImportarItensRemessa.pCriaCdsRemessa;
begin
  cdsRemessa := TUniClientDataSet.Create(nil);

  cdsRemessa.FieldDefs.Add('DOC_CHECKD', ftBoolean,  0, False);
  cdsRemessa.FieldDefs.Add('DOC_NUMDOC', ftString,  12, False);
  cdsRemessa.FieldDefs.Add('DOC_ESPDOC', ftString,   2, False);
  cdsRemessa.FieldDefs.Add('DOC_EMPDOC', ftString,   3, False);
  cdsRemessa.FieldDefs.Add('DOC_AUTINC', ftString,  20, False);
  cdsRemessa.FieldDefs.Add('DOC_CLIENT', ftString,  80, False);
  cdsRemessa.FieldDefs.Add('DOC_CODCLI', ftString,  20, False);
  cdsRemessa.FieldDefs.Add('DOC_DTAENT', ftDateTime, 0, False);

  cdsRemessa.CreateDataSet;
  cdsRemessa.Open;
end;

end.
