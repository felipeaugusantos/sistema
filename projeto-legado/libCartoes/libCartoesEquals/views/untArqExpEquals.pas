unit untArqExpEquals;

interface

uses
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.AppEvnts, System.Variants,
  Vcl.Menus, Vcl.Controls, Vcl.Buttons, System.Classes, System.ImageList,
  System.Generics.Collections, Vcl.Forms,
  Vcl.ImgList, System.DateUtils, System.StrUtils, Winapi.Windows, System.SysUtils,

  Uni, UniClientDataSet, cxControls, cxLookAndFeels, cxProgressBar,
  cxImageComboBox, cxCheckBox, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxGraphics, cxGridCitel, cxGridDBTableView, cxGrid,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, frxClass, frxExportCSVTestabilidade, BitBtnLockedIncrem,
  EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGridDBDataDefinitions, UniDataSetProvider,

  untLibCartoesPaiSimples, untTEqualsFuncoes, untEqualsTipos, untLibCartoesLogMca,
  untLibCartoesInterfacesTipos,untILibCartoesFactory,untTLibCartoesMovCar;

type
  TfrmArqExpEquals =  class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodBan: TEditFocus;
    edtDesBan: TEditFocus;
    btnCarrCartoes: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    BtnMarcarTodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label23: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    edtQtdDup: TEditFocus;
    edtTotDup: TEditFocus;
    edtQtdSel: TEditFocus;
    edtTotSel: TEditFocus;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn;
    grdDuplicDadosMCA_CODEMP: TcxGridDBColumn;
    grdDuplicDadosMCA_DTACAD: TcxGridDBColumn;
    grdDuplicDadosMCA_VALTOT: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn;
    grdDuplicDadosTOTPAR: TcxGridDBColumn;
    grdDuplicDadosMCA_MARDES: TcxGridDBColumn;
    grdDuplicDadosMCA_RESCAI: TcxGridDBColumn;
    grdDuplicDadosMCA_DTATRA: TcxGridDBColumn;
    grdDuplicNivel: TcxGridLevel;
    Panel1: TPanel;
    grdDuplicDadosVALVEN: TcxGridDBColumn;
    Label4: TLabel;
    edtArqGer: TEditFocus;
    grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn;
    chkExportados: TCheckBox;
    grdDuplicDadosMCA_EXPEQU: TcxGridDBColumn;
    Label2: TLabel;
    mskDtaIni: TcxDateEdit;
    Label3: TLabel;
    mskDtaFin: TcxDateEdit;
    Label8: TLabel;
    mskDtaIniVenc: TcxDateEdit;
    Label19: TLabel;
    mskDtaFinVenc: TcxDateEdit;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label21: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Shape3: TShape;
    Label22: TLabel;
    Label27: TLabel;
    Shape4: TShape;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnCarrCartoesClick(Sender: TObject);
    procedure edtCodBanKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodBanExit(Sender: TObject);
    procedure edtCodCarExit(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);

    procedure grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdDuplicDadosDblClick(Sender: TObject);
    procedure grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    dtsBaiCar: TDataSource;

    cdsBaiCar: TUniClientDataSet;

    arrCartao: TConsultasArray;
    arrBandeira: TConsultasArray;
    arrEmpresa: TConsultasArray;

    strCartao: String;
    strBandeira: String;
    strEmp: String;

    strPatArq,
    strSeqArq,
    strEstabe: String;

    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pAtualizaTemporaria;
    procedure pCriaAgrFields;
    procedure pNomeiaArquivo;
    procedure pCalculaValoresInformativos;
    procedure pCalculaTotalDuplicatas;
    procedure pLimpaDados;
    procedure pManipulaPanels(Habilita: Boolean);

    function fMarcarTodas(AProgressBar: TcxProgressBar): Boolean;
    function fDesmarcarTodas(AProgressBar: TcxProgressBar): Boolean;
    function fTemRegistrosFiltrados: Boolean;
    function fVerificaPermissaoDiretorio(const AName: string): Boolean;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pSelecionaExportado(strValor, strMenorAutoIncrem: String; lstFiltros: TStringList; var intContadorAutoInc: Int64);

    function RetornaAutorizacao:String;
    function RetornaTransactionID:String;

    procedure pSelecionaDuplicata;

    function fExportarCartoes(AProgressBar: TcxProgressBar): Boolean;

    function RetornaMeioCapturaTratadoTEFPOS: String;
  protected
    strRcxTcc: String;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

  function fRetNomeEmpresaSelec(const strCodigo: String): String;
  function fRetNomeCartao(strCodCar: String): String;
  function fRetNomBandeira(ACodBan: String): String;

implementation

{$R *.dfm}

function fRetNomeEmpresaSelec(const strCodigo: String): String;
begin
  Result := '';
  if TEqualsFuncoes.fEmptyStr(strCodigo) then
    Exit;

  Result := TEqualsFuncoes.RetornaNomeEmpresa(strCodigo);
end;

function fRetNomeCartao(strCodCar: String): String;
begin
  If strCodCar.IsEmpty Then
    Exit(EmptyStr);

  Result := VS_FuncoesExternas.fICampoTabela('CAR_DESCAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);
end;

function fRetNomBandeira(ACodBan: String): String;
Begin
  If ACodBan.IsEmpty Then
    Exit(EmptyStr);

  Result := VS_FuncoesExternas.fICampoTabela('BAN_NOMBAN', 'CADBAN', ['BAN_CODBAN'], [ACodBan]);
end;

function TfrmArqExpEquals.RetornaAutorizacao: String;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString;

  If Not TEqualsFuncoes.fEmptyStr(cdsBaiCar.FieldByName('MCA_NUMPOK').AsString) Then
    Result := ''
  Else If cdsBaiCar.FieldByName('CAR_MKTPLA').AsString.Equals('S') Then
    Result := EmptyStr;
end;

function TfrmArqExpEquals.RetornaMeioCapturaTratadoTEFPOS: String;
begin
  Result := cdsBaiCar.FieldByName('CAR_EQUCAP').AsString;

  If Not Result.Equals('3') Then
    Exit;

  If cdsBaiCar.FieldByName('MCA_TIPCAR').AsString.Equals('POS') Then
    Result := '6';
end;

function TfrmArqExpEquals.RetornaTransactionID: String;
begin
  Result := '';

  If Not TEqualsFuncoes.fEmptyStr(cdsBaiCar.FieldByName('MCA_NUMPOK').AsString) Then
    Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString
  Else If cdsBaiCar.FieldByName('CAR_MKTPLA').AsString.Equals('S') Then
    Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString;
end;

function TfrmArqExpEquals.fDesmarcarTodas(AProgressBar: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin

  Try
    TEqualsFuncoes.pDisableControls(cdsBaiCar, prcScroll);
    cdsBaiCar.AggregatesActive := False;

    cdsBaiCar.Filtered := False;
    cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
    cdsBaiCar.Filtered := True;
    cdsBaiCar.First;

    AProgressBar.Position := 0;
    AProgressBar.Properties.Max :=  cdsBaiCar.RecordCount;

    While Not cdsBaiCar.IsEmpty Do
    Begin
      Try
        TEqualsFuncoes.pStepStatusGravacao(AProgressBar);
        pMarcaDuplicata(False);

        cdsBaiCar.Next;
      Except
        On E: Exception Do
        Begin
          TEqualsFuncoes.fMensagem('','Ocorreu um erro ao Desmarcar o Registro para Baixa !' + #13 + E.Message,['&OK']);
          Break;
        End;
      End;
    End;
  Finally
    cdsBaiCar.Filter   := '';
    cdsBaiCar.Filtered := False;
    cdsBaiCar.First;

    TEqualsFuncoes.pEnableControls(cdsBaiCar, prcScroll);
  End;

  cdsBaiCar.AggregatesActive := True;
  TEqualsFuncoes.AguardeExecutarModalA(pAtualizaTemporaria, 'Aguarde... Atualizando Cartões.', '');
  Result := True;
end;

procedure TfrmArqExpEquals.pSelecionaExportado(strValor, strMenorAutoIncrem: String; lstFiltros: TStringList; var intContadorAutoInc: Int64);
Var
  intCont: Integer;
  stlDados: TStringList;
  strSQL: string;
  qrySelExp: TUniQuery;
Begin
  qrySelExp := Nil;
  stlDados := Nil;
  try
    qrySelExp := VS_FuncoesExternas.fICriaQuery;

    // Preparando a consulta SQL para atualizar a tabela MOVCAR
    strSQL := 'UPDATE MOVCAR SET MCA_EXPEQU=:EXPEQU WHERE (MCA_CODEMP, MCA_NUMCCD, MCA_DTACAD, MCA_CODCLI, MCA_NUMDUP) IN (';
    For intCont := 0 to lstFiltros.Count - 1 do
      strSQL := strSQL + '(' + lstFiltros[intCont] + '), ';
    strSQL := Copy(strSQL, 1, Length(strSQL) - 2) + ')';

    // Executando a atualização no banco
    qrySelExp.Close;
    qrySelExp.SQL.Clear;
    qrySelExp.SQL.Add(strSQL);
    qrySelExp.ParamByName('EXPEQU').AsString := strValor;
    qrySelExp.ExecSql;
    qrySelExp.Close;

    // Grava o Log dos cartões Exportados
    stlDados := TStringList.Create;
    stlDados.Delimiter := ',';

    // 2) Seleciona os AUTOINCREM para gravar log
    strSQL := 'SELECT AUTOINCREM FROM MOVCAR WHERE (MCA_CODEMP, MCA_NUMCCD, MCA_DTACAD, MCA_CODCLI, MCA_NUMDUP) IN (';

    // Adicionando os filtros na consulta SELECT
    for intCont := 0 to lstFiltros.Count - 1 do
      strSQL := strSQL + '(' + lstFiltros[intCont] + '), ';
      strSQL := Copy(strSQL, 1, Length(strSQL) - 2) + ')';

    qrySelExp.Close;
    qrySelExp.SQL.Text := strSQL;
    qrySelExp.Open;

    // 3) Preenche a lista de TMovCar (similar a fFiltrar<TMovCar>)
    // 3) Iteração diretamente para gravar o log
    while not qrySelExp.Eof do
    begin
      // Grava o log diretamente, sem necessidade de TMovCar
      untLibCartoesLogMca.GravaLogMca(
        qrySelExp.FieldByName('AUTOINCREM').AsString,
        'EXPORTAÇÃO CARTÕES',
        'frmArqExpEquals',
        LeftStr(strMenorAutoIncrem, 3) + TEqualsFuncoes.fStrZero(intContadorAutoInc.ToString, 14) + RightStr(strMenorAutoIncrem, 3)
      );

      Inc(intContadorAutoInc);  // Incrementa o contador
      qrySelExp.Next;
    end;

  finally
    If Assigned(stlDados) Then
      FreeAndNil(stlDados);

    If Assigned(qrySelExp) Then
      FreeAndNil(qrySelExp);
  end;
end;

function TfrmArqExpEquals.fExportarCartoes(AProgressBar: TcxProgressBar): Boolean;
Var
  prcScroll  : TprcScroll;
  txtTexto   : TextFile;
  strLinhAtu : string;
  intSeqLin  : Integer;
  lstFiltros : TStringList;
  strMenorAutoIncrem: String;
  intContadorAutoInc: Int64;
begin
  Result := False;

  If TEqualsFuncoes.fMensagem('ATENÇÃO', 'Confirmar a exportação dos registros selecionados?', ['&SIM', '&NÃO']) = 2 Then
    Exit;

  Try
    Try
      intContadorAutoInc := TEqualsFuncoes.fIntAggregate(cdsBaiCar, 'TOT_SELPAR');

      TEqualsFuncoes.pDisableControls(cdsBaiCar, prcScroll);
      cdsBaiCar.AggregatesActive := False;

      //VERIFICA SE POSSUI REGISTROS JÁ EXPORTADOS ANTERIORMENTE
      If (chkExportados.Checked) Then
      Begin
        cdsBaiCar.Filtered := False;
        cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_EXPEQU IS NOT NULL';
        cdsBaiCar.Filtered := True;

        If (cdsBaiCar.RecordCount > 0) Then
        Begin
          If TEqualsFuncoes.fMensagem('ATENÇÃO', 'Foram marcados cartões já exportados anteriormente. Deseja realmente continuar?', ['&SIM', '&NÃO']) = 2 Then
          Begin
            cdsBaiCar.Filtered := False;
            Exit;
          End;
        End;
      End;

      pNomeiaArquivo;
      AssignFile(txtTexto, edtArqGer.Text);
      Rewrite(txtTexto);

      cdsBaiCar.Filtered := False;
      cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND TOTPAR > 0';
      cdsBaiCar.Filtered := True;

      cdsBaiCar.First;

      AProgressBar.Position := 0;
      AProgressBar.Properties.Max :=  cdsBaiCar.RecordCount;

      {********************************
      * RETORNA AUTOINCREM DA LOGMCA *
      *****************************AJ* }
      strMenorAutoIncrem := VS_FuncoesExternas.fiRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada, intContadorAutoInc);
      intContadorAutoInc := Copy(strMenorAutoIncrem, 4, 14).ToInteger;

      cdsBaiCar.First;
      intSeqLin := 0;
      lstFiltros := TStringList.Create;
      VS_FuncoesExternas.fIStartTransaction;
      While Not cdsBaiCar.Eof do
      Begin
        Inc(intSeqLin);
        strLinhAtu := TEqualsFuncoes.fStrZero(inttostr(intSeqLin), 5) + ';' +
                      cdsBaiCar.FieldByName('SIS_VALCFG').AsString + ';' +
                      FormatDateTime('yyyymmdd', cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime) + ';' +
                      Concat(cdsBaiCar.FieldByName('MCA_NUMDUP').AsString, '-',
                             cdsBaiCar.FieldByName('MCA_CODEMP').AsString, '-',
                             cdsBaiCar.FieldByName('MCA_CODCLI').AsString) + ';' +
                      Concat(cdsBaiCar.FieldByName('MCA_NUMDUP').AsString, '-',
                             cdsBaiCar.FieldByName('MCA_CODEMP').AsString, '-',
                             cdsBaiCar.FieldByName('MCA_CODCLI').AsString) + ';' +
                      TEqualsFuncoes.fRemoveAcento(cdsBaiCar.FieldByName('CLI_NOMCLI').AsString) + ';' +
                      cdsBaiCar.FieldByName('CLI_C_G_C_').AsString + ';;;;;;' +
                      RetornaAutorizacao + ';' +
                      cdsBaiCar.FieldByName('MCA_NUMNSU').AsString + ';' +
                      RetornaTransactionID+  ';;' +
                      cdsBaiCar.FieldByName('TOTPAR').AsString + ';' +
                      cdsBaiCar.FieldByName('CAR_EQUADQ').AsString + ';' +
                      ';;' +
                      RetornaMeioCapturaTratadoTEFPOS + ';' +
                      ';;;' +
                      StringReplace(FormatFloat('#,##0.00', cdsBaiCar.FieldByName('VALVEN').AsFloat), '.', EmptyStr, [rfReplaceAll]);

        Writeln(txtTexto,strLinhAtu);

        lstFiltros.Add('"' + cdsBaiCar.FieldByName('MCA_CODEMP').AsString + '", ' +
                       '"' + cdsBaiCar.FieldByName('MCA_NUMCCD').AsString + '", ' +
                       '"' + FormatDateTime('yyyy-mm-dd', cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime) + '",' +
                       '"' + cdsBaiCar.FieldByName('MCA_CODCLI').AsString + '",' +
                       '"' + cdsBaiCar.FieldByName('MCA_NUMDUP').AsString + '"');

        TEqualsFuncoes.pStepStatusGravacao(AProgressBar);
        cdsBaiCar.Next;

        //Atualizando cartões por bloco de cada 500 ou quando chegar ao final
        If (lstFiltros.Count >= 500) Or (cdsBaiCar.Eof) Then
        Begin
          pSelecionaExportado(cdsBaiCar.FieldByName('MCA_CODEMP').AsString + '_' +TEqualsFuncoes.fStrZero(strSeqArq, 9),strMenorAutoIncrem, lstFiltros,intContadorAutoInc);
          lstFiltros.Clear;
        End;
      End;

      CloseFile(txtTexto);
      VS_FuncoesExternas.fICommit;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fiRollBack;
        CloseFile(txtTexto);
        VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao exportar arquivos!' + #13 + E.Message, '[TfrmArqExpEquals.fExportarCartoes]');
        If FileExists(edtArqGer.Text) Then
          DeleteFile(edtArqGer.Text);
        cdsBaiCar.Filter   := 'TOTPAR > 0';
        cdsBaiCar.Filtered := True;
        TEqualsFuncoes.pEnableControls(cdsBaiCar, prcScroll);
        cdsBaiCar.AggregatesActive := True;
        Exit;
      End;
    End;
  Finally
    cdsBaiCar.Filter   := 'TOTPAR > 0';
    cdsBaiCar.Filtered := True;
    cdsBaiCar.First;

    TEqualsFuncoes.pEnableControls(cdsBaiCar, prcScroll);
    cdsBaiCar.AggregatesActive := True;
  End;


  TEqualsFuncoes.AguardeExecutarModalA(pAtualizaTemporaria,'Aguarde... Atualizando Cartões.','');
  TEqualsFuncoes.fMensagem('AVISO', 'Arquivo gerado com sucesso!', ['&Ok']);
  strSeqArq :=VS_FuncoesExternas.fiRetSequencial('EQUSEQ', VS_FuncoesExternas.fIRetEmpresaLogada);
  pNomeiaArquivo;
  Result := True;
end;

procedure TfrmArqExpEquals.pSelecionaDuplicata;
  Var
    intRecNo: Integer;
begin
  intRecNo := cdsBaiCar.RecNo;

  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    Exit;
  End;

  cdsBaiCar.DisableControls;

  If cdsBaiCar.FieldByName('MCA_MARDES').AsString <> 'M' Then
    pMarcaDuplicata(True)
  Else
    pMarcaDuplicata(False);

  pAtualizaTemporaria;
  cdsBaiCar.RecNo := intRecNo;

  cdsBaiCar.EnableControls;

end;

procedure TfrmArqExpEquals.pCriaTemporaria;
Var
  strSQL   : String;
  qryBaiCar: TUniQuery;
  prcScroll: TprcScroll;
  dspBaiCar:  TUniDataSetProvider;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MCA_NUMDUP, ';
  strSQL := strSQL + '  MCA_CODEMP, ';
  strSQL := strSQL + '  MCA_NUMPOK, ';
  strSQL := strSQL + '  (SELECT ROUND(SUM(COALESCE(MCA_VALSTA, 0)) / COUNT(COALESCE(MCA_VALSTA, 0)), 2) ';
  strSQL := strSQL + '  FROM MOVCAR M WHERE M.MCA_NUMDUP = C.MCA_NUMDUP AND M.MCA_DTACAD = C.MCA_DTACAD ';
  strSQL := strSQL + '  AND M.MCA_CODCLI = C.MCA_CODCLI AND M.MCA_NUMCCD = C.MCA_NUMCCD) AS MCA_VALTOT, ';
  strSQL := strSQL + '  MCA_PERCAR, ';
  strSQL := strSQL + '  MCA_CODCLI, ';
  strSQL := strSQL + TEqualsFuncoes.fSQLIFClienteConsumidor('CLI_NOMCLI', '""', 'CLI_NOMCLI') + ' AS CLI_NOMCLI,   ';
  strSQL := strSQL + '  CAR_DESCAR, ';
  strSQL := strSQL + '  MCA_DTACAD, ';
  strSQL := strSQL + '  MCA_NUMCCD, ';
  strSQL := strSQL + '  MCA_CODCAR, ';
  strSQL := strSQL + '  MCA_NUMNSU, ';
  strSQL := strSQL + '  MCA_TIPCAR, ';
  strSQL := strSQL + '  CAR_TIPCAR, ';
  strSQL := strSQL + '  CAR_MKTPLA, ';
  strSQL := strSQL + '  CAR_EQUADQ, ';
  strSQL := strSQL + '  CAR_EQUCAP, ';
  strSQL := strSQL + '  MCA_DTATRA, ';
  strSQL := strSQL + '  MCA_RESCAI, ';
  strSQL := strSQL + TEqualsFuncoes.fSQLIFClienteConsumidor('CLI_NOMCLI', '""', 'CLI_C_G_C_') + ' AS CLI_C_G_C_,   ';
  strSQL := strSQL + '  MCA_EXPEQU, ';
  strSQL := strSQL + '  BAN_NOMBAN, ';
  strSQL := strSQL + '  (SELECT COUNT(M.MCA_PARCEL) FROM MOVCAR M WHERE ';
  strSQL := strSQL + '  M.MCA_NUMDUP = C.MCA_NUMDUP AND M.MCA_DTACAD = C.MCA_DTACAD AND M.MCA_CODCLI = C.MCA_CODCLI AND ';
  strSQL := strSQL + '  M.MCA_NUMCCD = C.MCA_NUMCCD) AS TOTPAR, ';
  strSQL := strSQL + '  (SELECT SUM(COALESCE(MCA_VALSTA, 0)) FROM MOVCAR M WHERE ';
  strSQL := strSQL + '  M.MCA_NUMDUP = C.MCA_NUMDUP AND M.MCA_DTACAD = C.MCA_DTACAD AND M.MCA_CODCLI = C.MCA_CODCLI AND ';
  strSQL := strSQL + '  M.MCA_NUMCCD = C.MCA_NUMCCD) AS VALVEN, ';
  strSQL := strSQL + '  SUBSTRING(MCA_DOCUME,1,15) AS MCA_NUMNOT, ';
  strSQL := strSQL + '  IF(COALESCE(SIS_VALCFG, "") <> "", SIS_VALCFG, EMP_C_G_C_) AS SIS_VALCFG, ';
  strSQL := strSQL + '  "D"  AS MCA_MARDES, ';
  strSQL := strSQL + '  0.00 AS MCA_SELSTA, ';
  strSQL := strSQL + '  0.00 AS MCA_SELTOT, ';
  strSQL := strSQL + '  0.00 AS MCA_SELQTD, ';
  strSQL := strSQL + '  0    AS MCA_SELPAR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVCAR C ';
  strSQL := strSQL + '  JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ';
  strSQL := strSQL + '  JOIN CADBAN ON BAN_CODBAN = CAR_CODBAN ';
  strSQL := strSQL + '  JOIN CADEMP ON EMP_CODEMP = MCA_EMPRCX ';
  strSQL := strSQL + '  LEFT JOIN CFGSIS ON SIS_CODEMP = MCA_CODEMP AND SIS_CODCFG = "CFG_EQUEST" ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MCA_DTAREC IS NULL ';

  If Not chkExportados.Checked Then
    strSQL := strSQL + ' AND MCA_EXPEQU IS NULL ';

  If Not TEqualsFuncoes.fEmptyStr(edtCodCar.Text) Then
    strSQL := strSQL + TEqualsFuncoes.fStrLocate(edtCodCar, arrCartao,  'CAR_CODCAR', 'CODCAR');

  strSQL := strSQL + TEqualsFuncoes.fStrLocate(edtCodBan, arrBandeira,  'CAR_CODBAN', 'CODBAN');

  If Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '  AND MCA_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniVenc.Text)) Then
    strSQL := strSQL + '  AND MCA_DTAVEN BETWEEN :DTAINIVEN AND :DTAFINVEN ';

  If (Not TEqualsFuncoes.fEmptyStr(edtCodEmp.Text)) Then
    strSQL := strSQL + TEqualsFuncoes.fStrLocate(edtCodEmp, arrEmpresa, 'MCA_CODEMP', 'CODEMP');

  strSQL := strSQL + ' GROUP BY MCA_NUMDUP, MCA_CODEMP, MCA_PERCAR, ';
  strSQL := strSQL + ' MCA_CODCLI, CLI_NOMCLI, CAR_DESCAR, MCA_DTACAD, MCA_NUMCCD, MCA_CODCAR, ';
  strSQL := strSQL + ' MCA_NUMNSU, CAR_TIPCAR, CLI_C_G_C_, MCA_EXPEQU, MCA_NUMNOT, MCA_MARDES, ';
  strSQL := strSQL + ' MCA_VALREC, MCA_DTAREC, MCA_SELSTA, MCA_SELTOT, MCA_SELQTD, BAN_NOMBAN, SIS_VALCFG ';

  strSQL := strSQL + ' ORDER BY MCA_DTACAD, MCA_NUMDUP, MCA_CODEMP, MCA_NUMCCD, MCA_NUMNSU ';

  TEqualsFuncoes.pDisableControls(cdsBaiCar, prcScroll);
  cdsBaiCar.Close;
  cdsBaiCar.Filter   := 'TOTPAR > 0';
  cdsBaiCar.Filtered := True;

  qryBaiCar := Nil;
  dspBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    dspBaiCar := TUniDataSetProvider.Create(Self);
    dspBaiCar.DataSet := qryBaiCar;
    cdsBaiCar.SetProvider(dspBaiCar);

    qryBaiCar.Close;

    qryBaiCar.SQL.Clear;
    qryBaiCar.SQL.Add(strSQL);

    If Not TEqualsFuncoes.fEmptyStr(edtCodCar.Text) Then
      TEqualsFuncoes.pSetaParam(edtCodCar.Text, arrCartao, strCartao, 'CODCAR', qryBaiCar);

    TEqualsFuncoes.pSetaParam(edtCodBan.Text, arrBandeira, strBandeira, 'CODBAN', qryBaiCar);

    If Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      qryBaiCar.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      qryBaiCar.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    If Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniVenc.Text)) Then
    Begin
      qryBaiCar.ParamByName('DTAINIVEN').AsDateTime := StrToDateTime(mskDtaIniVenc.Text);
      qryBaiCar.ParamByName('DTAFINVEN').AsDateTime := StrToDateTime(mskDtaFinVenc.Text);
    End;


    If Not TEqualsFuncoes.fEmptyStr(edtDesEmp.Text) Then
      TEqualsFuncoes.pSetaParam(edtCodEmp.Text, arrEmpresa, strEmp, 'CODEMP', qryBaiCar);

    qryBaiCar.Open;
    Application.ProcessMessages;
    cdsBaiCar.FieldByName('TOT_SELSTA').value;

    If Not qryBaiCar.IsEmpty Then
    Begin
      TEqualsFuncoes.pSetaClient(qryBaiCar);

      cdsBaiCar.Open;
      cdsBaiCar.FieldByName('TOT_SELSTA').value;
      cdsBaiCar.IndexFieldNames := 'MCA_DTACAD;MCA_NUMDUP;MCA_CODEMP';
      cdsBaiCar.First;

      cdsBaiCar.FieldByName('TOT_SELSTA').value;
    End
    Else
    Begin
      TEqualsFuncoes.fMensagem('ATENÇÃO!', 'Não há cartões para serem exportados!', ['&O k']);
      pSetFocus(edtCodBan);
    End;

    qryBaiCar.Close;

    cdsBaiCar.SetProvider(nil);
  Finally
    If Assigned(dspBaiCar) Then
      FreeAndNil(dspBaiCar);

    TEqualsFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;

  cdsBaiCar.FieldByName('TOT_SELSTA').value;
  pAtualizaTemporaria;
  TEqualsFuncoes.pEnableControls(cdsBaiCar, prcScroll);
end;

procedure TfrmArqExpEquals.btnCarrCartoesClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  pManipulaPanels(False);
  TEqualsFuncoes.AguardeExecutarModalA(pCriaTemporaria,'Aguarde... Carregando Cartões.','');
  pManipulaPanels(True);

 If cdsBaiCar.IsEmpty Then
    pSetFocus(edtCodBan)
  Else
    pSetFocus(grdDuplic);
end;

procedure TfrmArqExpEquals.pAtualizaTemporaria;
begin
  If Not cdsBaiCar.IsEmpty Then
  Begin

    (cdsBaiCar.FieldByName('MCA_VALTOT') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsBaiCar.FieldByName('MCA_VALTOT') As TFloatField).EditFormat    := '#,##0.00';

    (cdsBaiCar.FieldByName('VALVEN') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsBaiCar.FieldByName('VALVEN') As TFloatField).EditFormat    := '#,##0.00';

    pCalculaValoresInformativos;
    pCalculaTotalDuplicatas;
    cdsBaiCar.First;
  End
  Else
  Begin
    pLimpaDados;
  End;
end;

procedure TfrmArqExpEquals.pCalculaTotalDuplicatas;
begin
  edtTotDup.Text    := FormatFloat('#,##0.00',TEqualsFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_VALSTA'));
  edtQtdDup.Text    := '( ' + IntToStr(cdsBaiCar.RecordCount) + ' )';
end;

procedure TfrmArqExpEquals.pCalculaValoresInformativos;
begin
  edtTotSel.Text    := FormatFloat('#,##0.00',TEqualsFuncoes.fDoubleAggregate(cdsBaiCar, 'TOT_SELSTA'));
  edtQtdSel.Text    := '( ' + IntToStr(TEqualsFuncoes.fIntAggregate(cdsBaiCar, 'TOT_SELQTD')) + ' )';
end;

procedure TfrmArqExpEquals.pLimpaDados;
begin
  edtTotDup.Clear;
  edtQtdDup.Clear;
  edtTotSel.Clear;
  edtQtdSel.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
end;

procedure TfrmArqExpEquals.pManipulaPanels(Habilita: Boolean);
begin
  pnlBotoes.Enabled := Habilita;
  pnlAux2.Enabled := Habilita;
  pnlCabecalho.Enabled := Habilita;
end;

procedure TfrmArqExpEquals.pMarcaDuplicata(blnMarcar: Boolean);
begin
  If (strRcxTcc = '2') And
     (TEqualsFuncoes.fEmptyStr(cdsBaiCar.FieldByName('MCA_DTATRA').AsString)) And
     (cdsBaiCar.FieldByName('MCA_RESCAI').AsInteger = 1) Then
  Begin
    TEqualsFuncoes.fMensagem('ATENÇÃO','Cartões recebidos pelo Caixa que ainda não foram transferidos não podem ser exportados!',['&Ok']);
    Exit;
  End;

  cdsBaiCar.Edit;

  If blnMarcar Then
  Begin
    cdsBaiCar.FieldByName('MCA_MARDES').AsString  := 'M';
    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat   := cdsBaiCar.FieldByName('VALVEN').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat   := cdsBaiCar.FieldByName('VALVEN').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat   := 1;
    cdsBaiCar.FieldByName('MCA_SELPAR').AsInteger := cdsBaiCar.FieldByName('TOTPAR').AsInteger;
  End
  Else
  Begin
    cdsBaiCar.FieldByName('MCA_MARDES').AsString  := 'D';
    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat   := 0;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat   := 0;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat   := 0;
    cdsBaiCar.FieldByName('MCA_SELPAR').AsInteger := 0;
  End;

  cdsBaiCar.Post;
end;

procedure TfrmArqExpEquals.pNomeiaArquivo;
Var
  strDtaArq: String;
begin
  If (TEqualsFuncoes.fEmptyStr(strSeqArq)) Or (TEqualsFuncoes.fEmptyStr(strPatArq)) Then
  Begin
    TEqualsFuncoes.fMensagem('Atenção', 'É necessário configurar o número de sequência e a pasta em que o arquivo será gerado.', ['&OK']);
    btnConfirma.Enabled := False;
    Exit;
  End;

  If Not DirectoryExists(strPatArq) Then
  Begin
    TEqualsFuncoes.fMensagem('Atenção','A pasta selecionada para exportação não existe! Verifique as configurações do sistema.', ['&OK']);
    btnConfirma.Enabled := False;
    Exit;
  End;

  If Not fVerificaPermissaoDiretorio(strPatArq) Then
  Begin
    TEqualsFuncoes.fMensagem('Atenção','Sem permissão de gravação na pasta selecionada! Verifique as configurações do sistema.', ['&OK']);
    btnConfirma.Enabled := False;
    Exit;
  End;

  strSeqArq := VS_FuncoesExternas.fICfgSis('EQUSEQ');
  strDtaArq := FormatDateTime('yyyy',VS_FuncoesExternas.fIGetVS_Date) + FormatDateTime('mm', VS_FuncoesExternas.fIGetVS_Date) + FormatDateTime('dd', VS_FuncoesExternas.fIGetVS_Date);

  edtArqGer.Text := IfThen(Copy(strPatArq, Length(strPatArq), 1) = '\',
                           strPatArq + strDtaArq + '-' + TEqualsFuncoes.fStrZero(strSeqArq, 9) + '.csv',
                           strPatArq + '\' + strDtaArq + '-' + TEqualsFuncoes.fStrZero(strSeqArq, 9) + '.csv');
end;

procedure TfrmArqExpEquals.btnConfirmaClick(Sender: TObject);
Var
  cdsAux: TUniClientDataSet;
begin
  inherited;
  If (Not btnConfirma.Enabled) Then
    Exit;

  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    TEqualsFuncoes.fMensagem('', 'É necessário ter registros para exportar!', ['&Ok']);
    Exit;
  End;

  cdsAux := Nil;
  Try
    If Not cdsBaiCar.IsEmpty  Then
    Begin
      cdsAux := TUniClientDataSet.Create(Nil);
      cdsAux.Data := cdsBaiCar.Data;
      cdsAux.DisableControls;

      //verifica se todos possuem Estabelecimento cadastrado na empresa do cartão
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND SIS_VALCFG=' + QuotedStr('');
      cdsAux.Filtered := True;
      If cdsAux.RecordCount > 0 Then
      Begin
        TEqualsFuncoes.fMensagem('','Foram selecionados cartões de empresas sem Código de Estabelecimento EQUALS configurado. Verifique!',['&O K']);
        Exit;
      End;

      cdsAux.Filtered := False;
      cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
      cdsAux.Filtered := True;

      If cdsAux.FieldByName('MCA_MARDES').AsString <> 'M' Then
      Begin
        TEqualsFuncoes.fMensagem('','É necessário selecionar ao menos um registro para exportar!',['&O K']);
        Exit;
      End;
    End;

    TEqualsFuncoes.ExecutaAguarde(fExportarCartoes, 'Aguarde... Exportando Cartões.');
  Finally
    TEqualsFuncoes.FreeAndNilDatasets(cdsAux);
  End;
  btnCarrCartoes.Click;
end;

procedure TfrmArqExpEquals.btnDesmarcarTodasClick(Sender: TObject);
Var
  cdsAux: TUniClientDataSet;
begin
  inherited;

  If (Not btnDesmarcarTodas.Enabled) Then
    Exit;

  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    TEqualsFuncoes.fMensagem('', 'É necessário ter registros para desmarcar!', ['&Ok']);
    Exit;
  End;

  cdsAux := Nil;
  Try
    If Not cdsBaiCar.IsEmpty  Then
    Begin
      cdsAux := TUniClientDataSet.Create(Nil);
      cdsAux.Data := cdsBaiCar.Data;
      cdsAux.DisableControls;

      //verifica se todos possuem Estabelecimento cadastrado na empresa do cartão
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND SIS_VALCFG=' + QuotedStr('');
      cdsAux.Filtered := True;
      If cdsAux.RecordCount > 0 Then
      Begin
        TEqualsFuncoes.fMensagem('','Foram selecionados cartões de empresas sem Código de Estabelecimento EQUALS configurados. Verifique!',['&O K']);
        Exit;
      End;

      cdsAux.Filtered := False;
      cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
      cdsAux.Filtered := True;

      If cdsAux.FieldByName('MCA_MARDES').AsString <> 'M' Then
      Begin
        TEqualsFuncoes.fMensagem('','É necessário selecionar ao menos um registro para desmarcar!',['&O K']);
        Exit;
      End;
    End;

    If (TEqualsFuncoes.fMensagem('', 'Confirma desmarcar todos os cartões?', ['&Sim', '&Não']) = 2) Then
      Exit;

    pManipulaPanels(False);
    TEqualsFuncoes.ExecutaAguarde(fDesmarcarTodas, 'Aguarde... Desmarcando Cartões.');
    pManipulaPanels(True);
  Finally
    TEqualsFuncoes.FreeAndNilDatasets(cdsAux);
  End;
end;

function TfrmArqExpEquals.fTemRegistrosFiltrados: Boolean;
begin
  Result := False;

  If Not Assigned(cdsBaiCar) Then
    Exit;

  if (not cdsBaiCar.Active) then
    Exit;

  Result := Not cdsBaiCar.IsEmpty;
end;

procedure TfrmArqExpEquals.BtnMarcarTodasClick(Sender: TObject);
begin
 inherited;
  If (Not btnMarcarTodas.Enabled) Then
    Exit;

  if (not fTemRegistrosFiltrados) then
  begin
    TEqualsFuncoes.fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  end;

  If (TEqualsFuncoes.fMensagem('', 'Confirma selecionar todos os cartões?', ['&Sim', '&Não']) = 2) Then
    Exit;

  TEqualsFuncoes.ExecutaAguarde(fMarcarTodas, 'Aguarde... Marcando arquivos.');
end;

function TfrmArqExpEquals.fMarcarTodas(AProgressBar: TcxProgressBar): Boolean;
Var
  LScroll: TprcScroll;
  blnNaoMar: Boolean;
begin
  Result := True;
  blnNaoMar := False;

  Try
    TEqualsFuncoes.pDisableControls(cdsBaiCar, LScroll);
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := cdsBaiCar.RecordCount;

    cdsBaiCar.First;
    While Not cdsBaiCar.Eof Do
    Begin
      TEqualsFuncoes.pStepStatusGravacao(AProgressBar);
      Try
        If (strRcxTcc = '2') And (TEqualsFuncoes.fEmptyStr(cdsBaiCar.FieldByName('MCA_DTATRA').AsString)) And (cdsBaiCar.FieldByName('MCA_RESCAI').AsInteger = 1) Then
        Begin
          blnNaoMar := True;
        End
        Else
        begin
          pMarcaDuplicata(True);
        end;

        cdsBaiCar.Next;
      Except
        On E: Exception Do
        Begin
          TEqualsFuncoes.fMensagem('','Ocorreu um erro ao marcar o registro para exportação !' + #13 + E.Message,['&OK']);
          Break;
        End;
      End;

    End;

  Finally
    cdsBaiCar.First;
    TEqualsFuncoes.pEnableControls(cdsBaiCar, LScroll);

    If blnNaoMar Then
      TEqualsFuncoes.fMensagem('ATENÇÃO','Alguns cartões não foram marcados pois não foram transferidos do caixa. Verifique!', ['&Ok']);
  End;

  TEqualsFuncoes.AguardeExecutarModalA(pAtualizaTemporaria, 'Aguarde... Atualizando Cartões.', '');
end;

procedure TfrmArqExpEquals.edtCodBanExit(Sender: TObject);
begin
  inherited;
  If Not edtCodBan.ReadOnly Then
    TEqualsFuncoes.pEdtCodSelectExit(edtCodBan, edtDesBan, arrBandeira,fRetNomBandeira, Nil, 'da bandeira');
  If (edtDesBan.Text = 'TODOS') Then
    edtDesBan.Text := 'TODAS';
end;

procedure TfrmArqExpEquals.edtCodBanKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If TLibCartoesFactory.Get.fIPesqCartaoBandeira(Self, edtCodBan, edtDesBan, Nil, Key, arrBandeira, False) Then
  Begin
    fValidaCampos(edtCodBan,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmArqExpEquals.edtCodCarExit(Sender: TObject);
begin
  inherited;
  If Not edtCodCar.ReadOnly Then
    TEqualsFuncoes.pEdtCodSelectExit(edtCodCar, edtDesCar, arrCartao, fRetNomeCartao, Nil, 'do cartão');
  If (edtDesCar.Text = 'TODOS') Then
    edtDesCar.Text := 'TODAS';
end;

procedure TfrmArqExpEquals.edtCodCarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If TLibCartoesFactory.Get.fIPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, False, False, False,
                 True, True) Then
  Begin
    fValidaCampos(edtCodCar,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmArqExpEquals.edtCodEmpExit(Sender: TObject);
var
teste : string;
begin
  inherited;
  teste :=  TEqualsFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada);

  TEqualsFuncoes.pEdtCodSelectExit( edtCodEmp, edtDesEmp, arrEmpresa, nil, fRetNomeEmpresaSelec,
                                    'da empresa', 3, False, '', False, False,nil, nil, '', '' );

  If (edtDesEmp.Text = 'TODOS') Then
    edtDesEmp.Text := 'TODAS';
end;

procedure TfrmArqExpEquals.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmArqExpEquals.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pDeletaTemporaria;

  If Assigned(dtsBaiCar) Then
    FreeAndNil(dtsBaiCar);

  TEqualsFuncoes.FreeAndNilDatasets(cdsBaiCar);
  inherited;
end;

procedure TfrmArqExpEquals.FormCreate(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text :=  VS_FuncoesExternas.fIRetEmpresaLogada;

  TEqualsFuncoes.pEdtCodSelectExit( edtCodEmp, edtDesEmp, arrEmpresa, nil, fRetNomeEmpresaSelec,
                                    'da empresa', 3, False, '', False, False,nil, nil, '', '' );

  cdsBaiCar := TUniClientDataSet.Create(Nil);
  dtsBaiCar := TEqualsFuncoes.fCriaDataSource(cdsBaiCar);

  cdsBaiCar.AggregatesActive := True;
  pCriaAgrFields;

  grdDuplicDados.DataController.DataSource := dtsBaiCar;
end;

procedure TfrmArqExpEquals.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F7) Then
  Begin
    BtnMarcarTodas.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarcarTodas.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmArqExpEquals.FormShow(Sender: TObject);
begin
  inherited;
  strSeqArq := VS_FuncoesExternas.fICfgSis('EQUSEQ');
  strPatArq := VS_FuncoesExternas.fICfgSis('EQUPAT');
  strEstabe := TEqualsFuncoes.IIF(Not TEqualsFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis('EQUEST')),
                   VS_FuncoesExternas.fICfgSis('EQUEST'),
                   TEqualsFuncoes.RetornaCGCEmpresa( VS_FuncoesExternas.fIRetEmpresaLogada));
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');
  pNomeiaArquivo;

  pSetFocus(edtCodBan);
end;

procedure TfrmArqExpEquals.pCriaAgrFields;
begin
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALSTA';
    FieldName     := 'TOT_VALSTA';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(VALVEN)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTOT';
    FieldName     := 'TOT_VALTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(VALVEN)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELSTA';
    FieldName     := 'TOT_SELSTA';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELSTA)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELTOT';
    FieldName     := 'TOT_SELTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELQTD';
    FieldName     := 'TOT_SELQTD';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELQTD)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELPAR';
    FieldName     := 'TOT_SELPAR';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELPAR)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
end;

function TfrmArqExpEquals.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaFin) Then
    Begin
      If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        TEqualsFuncoes.fMensagem('', 'A Data Final do período informada é inválida!', ['&O k']);
        Result := False;
      End
      Else
      If TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFin.Text)) And (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        TEqualsFuncoes.fMensagem('', 'O campo Data Final do período deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFin.Text))) And TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          TEqualsFuncoes.fMensagem('', 'O campo Data Inicial do período deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFin.Text))) And (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              TEqualsFuncoes.fMensagem('','A Data Inicial do período deve ser menor que a Data Final do período!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
      End;
    End
    Else If (Sender = mskDtaIni) Then
    Begin
      If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        TEqualsFuncoes.fMensagem('', 'A Data Inicial do período informada é inválida!', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End
    Else
    If (Sender = mskDtaFinVenc) Then
    Begin
      If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinVenc.Text))) And (StrToDateDef(mskDtaFinVEnc.Text, 0) <= 0) Then
      Begin
        TEqualsFuncoes.fMensagem('', 'A Data Final de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinVenc.Text)) And (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniVenc.Text))) Then
      Begin
        TEqualsFuncoes.fMensagem('', 'O campo Data Final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinVenc.Text))) And TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniVenc.Text)) Then
        Begin
          TEqualsFuncoes.fMensagem('', 'O campo Data Inicial de vencimento deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIniVenc;
        End
        Else
        Begin
          If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaFinVenc.Text))) And (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniVenc.Text))) Then
          Begin
            If StrToDate(mskDtaIniVenc.Text) > StrToDate(mskDtaFinVenc.Text) Then
            Begin
              TEqualsFuncoes.fMensagem('','A data Inicial de vencimento deve ser menor que a data final de vencimento!',['&O K']);
              Result := False;
              Sender := mskDtaIniVenc;
            End;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskDtaIniVenc) Then
    Begin
      If (Not TEqualsFuncoes.fEmptyStr(TEqualsFuncoes.fTiraCaracEspeciais(mskDtaIniVenc.Text))) and (StrToDateDef(mskDtaIniVenc.Text, 0) <= 0) Then
      Begin
        TEqualsFuncoes.fMensagem('', 'A Data Inicial de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIniVenc;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      TEqualsFuncoes.pDesmarcaLista(edtCodEmp, arrEmpresa);

      If (Not TEqualsFuncoes.fEmptyStr(edtCodEmp.Text)) Or (High(arrEmpresa) >= 0) Then
      Begin
        If (High(arrEmpresa) >= 0 ) Then
        Begin
          For intIndex := 0 To High(arrEmpresa) Do
          Begin
            If Pos(arrEmpresa[intIndex].strCodigo, VS_FuncoesExternas.fIRetEmpAcessoOperador ) <= 0 Then
            Begin
              TEqualsFuncoes.fMensagem('', 'Usuário sem permissão de acesso a empresa + ' + arrEmpresa[intIndex].strCodigo + '!', ['&Ok']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodEmp.Text, VS_FuncoesExternas.fIRetEmpAcessoOperador) <= 0 Then
        Begin
          TEqualsFuncoes.fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmArqExpEquals.grdDuplicDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var strMarDes,
    strExpEqu,
    strDtaTra,
    strResCai : String;
begin
  inherited;

  If Not Active Then
    Exit;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_MARDES.Index]);
  strExpEqu := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_EXPEQU.Index]);
  strDtaTra := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_DTATRA.Index]);
  strResCai := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_RESCAI.Index]);

  If strMarDes = 'M' Then
    ACanvas.Font.Color := clBlue
  Else
  If (strExpEqu <> '') Then
    ACanvas.Font.Color := clGreen;
  If (strRcxTcc = '2') And (TEqualsFuncoes.fEmptyStr(strDtaTra)) And (strResCai = '1') Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmArqExpEquals.grdDuplicDadosDblClick(Sender: TObject);
begin
  inherited;
  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    TEqualsFuncoes.fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End
  Else
    pSelecionaDuplicata;
end;

procedure TfrmArqExpEquals.grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Not cdsBaiCar.Active) Then
    Exit;

  If (Key = VK_Return) Then
  Begin
    grdDuplic.Enabled := False;
    TEqualsFuncoes.AguardeExecutarModalA(pSelecionaDuplicata,'Aguarde... Selecionando cartão.','');
    If (cdsBaiCar.RecordCount > 0) Then
      Key := VK_DOWN;
    grdDuplic.Enabled := True;
    pSetFocus(grdDuplic);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodBan);
    pDeletaTemporaria;
  End;
end;

procedure TfrmArqExpEquals.pDeletaTemporaria;
begin
  If cdsBaiCar.Active Then
    cdsBaiCar.EmptyDataSet;
end;

function TfrmArqExpEquals.fVerificaPermissaoDiretorio(const AName: string): Boolean;
Var
  FileName: String;
  H: THandle; // Handle é para que o Windows saiba quem é que você está querendo manipular.
begin
  //Recebe o caminho
  FileName := IncludeTrailingPathDelimiter(AName) + 'arqv.tmp';
  //Aqui ele verifica se o diretorio tem permissão de escrita
  //(criando um arquivo temporario)
  H := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result := H <> INVALID_HANDLE_VALUE; // SE FOI DIFERENTE DE UM HANDLE INVALIDO.

  If Result Then
    CloseHandle(H);
end;

end.

