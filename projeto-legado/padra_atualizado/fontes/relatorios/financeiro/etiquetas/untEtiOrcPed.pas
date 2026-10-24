unit untEtiOrcPed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Uni, frxClass, frxDBSet, UniClientDataSet, untFuncoesSimples, Grids, DBGridCitel, DBGrids,
  untTypesSistema, TypesRel, untFuncoesEtiquetas, DB, Math, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxEditRepositoryItems, dxCore, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, untDigQuantidade;

type
  TfrmEtiOrcPed = class(TfrmPai)
    pnlFundo: TPanel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    frxEtiOrcPed: TfrxReport;
    frxDBImpEti: TfrxDBDataset;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    pnlDetalhes: TPanel;
    cdsEtiquetas: TUniClientDataSet;
    cdsEtiquetasORDITE: TIntegerField;
    cdsEtiquetasNOMEMP: TStringField;
    cdsEtiquetasDESITE: TStringField;
    cdsEtiquetasVALITE: TFloatField;
    cdsEtiquetasCODBAR: TStringField;
    cdsEtiquetasREFERE: TStringField;
    cdsEtiquetasSIGUNI: TStringField;
    cdsEtiquetasCODFAB: TStringField;
    cdsEtiquetasCODITE: TStringField;
    cdsEtiquetasLOCFIS: TStringField;
    cdsEtiquetasCODEMP: TStringField;
    cdsEtiquetasVALVIS: TFloatField;
    cdsEtiquetasDESMAR: TStringField;
    cdsEtiquetasNUMDOC: TStringField;
    strngfldEtiquetasESPDOC: TStringField;
    dtsEtiquetas: TDataSource;
    frxPagina: TfrxReport;
    btnConfirma: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    cdsEtiquetasQTDETI: TFloatField;
    btnMarDes: TBitBtnLocked;
    cxgFatDor: TcxGrid;
    cxgFatDorView: TcxGridDBTableView;
	cxgFatDorOrdIte: TcxGridDBColumn;
    cxgFatDorCodigo: TcxGridDBColumn;
    cxgFatDorDescricao: TcxGridDBColumn;
    cxgFatDorRefere: TcxGridDBColumn;
    cxgFatDorSigUni: TcxGridDBColumn;
    cxgFatDorImprimir: TcxGridDBColumn;
    cxgFatDorLevel1: TcxGridLevel;
    cxgFatDorQtdEti: TcxGridDBColumn;
    cxgFatDorQtdImp: TcxGridDBColumn;
    cdsEtiquetasQTDIMP: TIntegerField;
    cdsEtiquetasIMPRME: TStringField;
    cxRepository: TcxEditRepository;
    chkImprimir: TcxEditRepositoryCheckBoxItem;
    spnQtdImp: TcxEditRepositorySpinItem;
    cdsQtdEti: TUniClientDataSet;
    cdsQtdEtiAUTOINCREM: TStringField;
    cdsQtdEtiQTDIMP: TIntegerField;
    cdsEtiquetasAUTOINCREM: TStringField;
    cdsQtdEtiIMPRME: TStringField;
    btnLimFil: TBitBtnLocked;
    cxgFatDorViewAutoincrem: TcxGridDBColumn;
    cxgFatDorViewLocFis: TcxGridDBColumn;
    cxgFatDorViewDesDep: TcxGridDBColumn;
    cxgFatDorViewEntRet: TcxGridDBColumn;
    cxgFatDorCODFAB: TcxGridDBColumn;
    cxgFatDorCODBAR: TcxGridDBColumn;
    cdsEtiquetasFABITE: TStringField;
    cdsEtiquetasFABCLI: TStringField;
    cdsEtiquetasAPLICA: TStringField;
    cxgFatDorLOCSEP: TcxGridDBColumn;
    cdsEtiquetasLOCSEP: TStringField;
    cdsEtiquetasNUMCMP: TStringField;
    btnAlterarTodasQtd: TBitBtnLocked;
    btnRestaurarTodasQtd: TBitBtnLocked;
    cxgFatDorLOCFIS: TcxGridDBColumn;
    procedure btnConfigurarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure spnQtdImpPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgFatDorViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLimFilClick(Sender: TObject);
    procedure btnAlterarTodasQtdClick(Sender: TObject);
    procedure btnRestaurarTodasQtdClick(Sender: TObject);
  private
    { Private declarations }
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;
    strCfgTipEti: String;
    strOrdPdv, strOrdOrc, strOrdenacaoDocumento: String;

    function fVerificaDocExiste(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

    procedure pAbreDocumento;
    procedure pImpEtiquetasLaserArgox(strTipImp : String);
    procedure pImpEtiquetasMatricial;
    Function fImpRegistro: Boolean;
    procedure pImpArrLinhasEti;
    procedure pMarcaDesmarcar(strMarcar: String);
    function GetOrderBy: String;
    procedure pAjustaQtdAImprimir(blnRestaurar:Boolean = False; intQtd: Integer = 1);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cpuCampos: TCamposUso;
    intColAtu: Integer;
    blnImpEti: Boolean;
    strCodCli: String;
    blnTablOk: Boolean;

    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;

  end;


implementation

uses StrUtils, untCadConfRelatorios, untConsultas, untFuncMacro, untCfgRel,
  untFuncoesRel, untMenuMarcarEti, untConstantes;

{$R *.dfm}

function TfrmEtiOrcPed.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o Número do Documento!', ['&Ok']);
        Result := False;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o Número do Documento!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o código da Empresa!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pAbreDocumento;

        If (Not cdsEtiquetas.Active) Or (cdsEtiquetas.IsEmpty) Then
          Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEtiOrcPed.pAbreDocumento;
Var
  strSQL : String;
  qryGen : TUniQuery;
  intIndex : Integer;
begin

  {************************************************}
  {* VERIFICA SE O DOCUMENTO EXISTE, CASO EXISTA  *}
  {* LOCALIZA OS DADOS PARA IMPRESSAO DA ETIQUETA *}
  {*********************************************IV*}
  If fVerificaDocExiste(edtNumDoc.Text, edtEspDoc.Text, edtCodEmpresa.Text) Then
  Begin

    Try
      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  D.AUTOINCREM AS AUTOINCREM, ';
      strSQL := strSQL + '  E.FDO_ORDITE AS ORDITE, ';
      strSQL := strSQL + '  D.FDO_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '  D.FDO_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '  D.FDO_REFERE AS REFERE, ';
      strSQL := strSQL + '  D.FDO_CODITE AS CODITE, ';
      strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '  CEIL(FDO_QTDITE) AS QTDETI, ';

      If (Not fCfgSis('VENMTL', varBoolean)) Then
        strSQL := strSQL + '  CEIL(FDO_QTDITE) AS QTDIMP, '
      Else
        strSQL := strSQL + '  CEIL(IF(IFNULL(MD.FDO_QTDPEC, 0) = 0, FDO_QTDITE, MD.FDO_QTDPEC)) AS QTDIMP, ';

      strSQL := strSQL + ' ' + QuotedStr('S') + ' AS IMPRME, ';
      strSQL := strSQL + '  D.FDO_UNITAR AS VALITE, ';
      strSQL := strSQL + '  T.ITE_LOCFIS AS LOCFIS, ';
      strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';
      strSQL := strSQL + '  I.ITE_APLICA AS APLICA, ';
      if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
        strSQL := strSQL + '  IF(IFNULL(D.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LSE_DESCRI, '
      else
        strSQL := strSQL + '  LSE_DESCRI,             ';

      If fCfgSis('CLIPRO', varBoolean) And (opcEtiqueta in fRetUtilizaCliPro) Then
      Begin
        strSQL := strSQL + ' IFNULL(CLI_COD_NF, I.ITE_CODFAB) AS CODFAB, ';
        strSQL := strSQL + ' IFNULL(CLI_DES_NF, D.FDO_DESCRI) AS DESITE, ';
        If fCfgSis('APRBAR', varBoolean) Then
          strSQL := strSQL + ' IFNULL(CLI_CODBAR, I.ITE_CODBAR) AS CODBAR, '
        Else
          strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
        strSQL := strSQL + ' I.ITE_CODFAB AS FABITE, ';
        strSQL := strSQL + ' C.CLI_COD_NF AS FABCLI, ';
      End
      Else
      Begin
        strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
        strSQL := strSQL + '  D.FDO_DESCRI AS DESITE, ';
        strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
        strSQL := strSQL + '  "" AS FABITE,           ';
        strSQL := strSQL + '  "" AS FABCLI,           ';
      End;

      strSQL := strSQL + '  COALESCE(X.DEP_DESCRI, "") AS DESDEP, ';
      strSQL := strSQL + '  IF(IFNULL(FDO_ENTRET, "R") = "R",0, IF(IFNULL(FDO_ENTFUT, "N") = "N", 1, 2)) AS ENTRET, ';

      strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ", ") ';
      strSQL := strSQL + '     FROM NUMCMP ';
      strSQL := strSQL + '    WHERE CMP_SEQGER = D.FDO_SEQGER ) AS NUMCMP ';

      strSQL := strSQL + ' FROM FATDOR D ';
      strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = D.FDO_CODITE ';
      strSQL := strSQL + ' INNER JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
      strSQL := strSQL + ' INNER JOIN ITEGER T ON T.ITE_CODITE = D.FDO_CODITE ';

      strSQL := strSQL + '                    AND T.ITE_CODEMP = D.FDO_CODEMP ';
      strSQL := strSQL + ' LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM ';
      strSQL := strSQL + ' LEFT JOIN CADDEP X ON X.DEP_CODIGO = I.ITE_CODDEP ';

      If (fCfgSis('VENMTL', varBoolean)) Then
        strSQL := strSQL + ' LEFT JOIN ORCMAD MD ON MD.FDO_SEQGER = D.AUTOINCREM ';

      If fCfgSis('CLIPRO', varBoolean) And (opcEtiqueta in fRetUtilizaCliPro) Then
      Begin
        strSQL := strSQL + ' LEFT JOIN CLIPRO C ON C.CLI_CODCLI = FDO_CODCLI ';
        strSQL := strSQL + '                   AND C.CLI_CODITE = FDO_CODITE ';
        strSQL := strSQL + ' INNER JOIN CADUNI U ON U.UNI_CODUNI = COALESCE(C.CLI_CODUNI, D.FDO_UNIDAD) ';
      End
      Else
        strSQL := strSQL + ' INNER JOIN CADUNI U ON U.UNI_CODUNI = D.FDO_UNIDAD ';

      if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      begin
        strSQL := strSQL + ' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = D.FDO_CODITE AND LT.LOT_CODEMP = D.FDO_CODEMP AND LT.LOT_NUMLOT = D.FDO_NUMLOT ';
        strSQL := strSQL + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ';
        strSQL := strSQL + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = T.ITE_LOCFIS AND CL2.LOC_CODEMP = T.ITE_CODEMP ';
        strSQL := strSQL + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
        strSQL := strSQL + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
      end
      else
        strSQL := strSQL + ' LEFT JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE ';

      strSQL := strSQL + ' WHERE D.FDO_CODEMP = :CODEMP                       ';
      strSQL := strSQL + '   AND D.FDO_NUMDOC = :NUMDOC                       ';
      strSQL := strSQL + '   AND D.FDO_ESPDOC = :ESPDOC                       ';
      strSQL := strSQL + '   AND D.FDO_IDEPRO = "NOR"                         ';

      strSQL := strSQL + 'ORDER BY ';

      For intIndex := 0 To cxgFatDorView.ColumnCount -1 Do
      Begin
        cxgFatDorView.Columns[intIndex].SortOrder := soNone;
        cxgFatDorView.Columns[intIndex].SortIndex := -1;
      End;

      If (edtEspDoc.Text = 'OR') Then
        strOrdenacaoDocumento := strOrdOrc
      Else
        strOrdenacaoDocumento := strOrdPdv;

      If SameText(strOrdenacaoDocumento, '1') Then
      Begin
        strSQL := strSQL + '  D.FDO_DESCRI ';
        cxgFatDorView.GetColumnByFieldName('DESITE').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('DESITE').SortIndex := 0;
      End
      Else If SameText(strOrdenacaoDocumento, '2') Then
      Begin
        strSQL := strSQL + '  SIGUNI,  DESITE ';
        cxgFatDorView.GetColumnByFieldName('SIGUNI').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('SIGUNI').SortIndex := 0;

        cxgFatDorView.GetColumnByFieldName('DESITE').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('DESITE').SortIndex := 1;
      End
      Else If SameText(strOrdenacaoDocumento, '3') Then
      Begin
        strSQL := strSQL + '  ORDITE, D.AUTOINCREM ';
        cxgFatDorView.GetColumnByFieldName('ORDITE').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('ORDITE').SortIndex := 0;

        cxgFatDorView.GetColumnByFieldName('AUTOINCREM').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('AUTOINCREM').SortIndex := 1;
      End
      Else If SameText(strOrdenacaoDocumento, '4') Then
      Begin
        strSQL := strSQL + '  LOCFIS, DESITE  ';
        cxgFatDorView.GetColumnByFieldName('LOCFIS').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('LOCFIS').SortIndex := 0;

        cxgFatDorView.GetColumnByFieldName('DESITE').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('DESITE').SortIndex := 1;
      End
      Else If SameText(strOrdenacaoDocumento, '5') Then
      Begin
        strSQL := strSQL + '  DESDEP, DESITE ';
        cxgFatDorView.GetColumnByFieldName('DESDEP').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('DESDEP').SortIndex := 0;

        cxgFatDorView.GetColumnByFieldName('DESITE').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('DESITE').SortIndex := 1;
      End
      Else If SameText(strOrdenacaoDocumento, '6') Then
      Begin
        strSQL := strSQL + 'ENTRET, DESITE ';
        cxgFatDorView.GetColumnByFieldName('ENTRET').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('ENTRET').SortIndex := 0;

        cxgFatDorView.GetColumnByFieldName('DESITE').SortOrder := soAscending;
        cxgFatDorView.GetColumnByFieldName('DESITE').SortIndex := 1;
      End;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
        Open;

        cdsEtiquetas.Open;
        cdsEtiquetas.EmptyDataSet;
        cdsEtiquetas.DisableControls;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          cdsEtiquetas.Append;
          cdsEtiquetas.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
          cdsEtiquetas.FieldByName('ORDITE').AsString := FieldByName('ORDITE').AsString;
          cdsEtiquetas.FieldByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
          cdsEtiquetas.FieldByName('ESPDOC').AsString := FieldByName('ESPDOC').AsString;
          cdsEtiquetas.FieldByName('CODEMP').AsString := edtCodEmpresa.Text;
          cdsEtiquetas.FieldByName('NOMEMP').AsString := fRetNomeEmpresa(edtCodEmpresa.Text);
          cdsEtiquetas.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
          cdsEtiquetas.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
          cdsEtiquetas.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
          cdsEtiquetas.FieldByName('SIGUNI').AsString := FieldByName('SIGUNI').AsString;
          cdsEtiquetas.FieldByName('DESMAR').AsString := FieldByName('DESMAR').AsString;
          cdsEtiquetas.FieldByName('QTDETI').AsString := FieldByName('QTDETI').AsString;
          cdsEtiquetas.FieldByName('QTDIMP').AsString := FieldByName('QTDIMP').AsString;
          cdsEtiquetas.FieldByName('IMPRME').AsString := FieldByName('IMPRME').AsString;
          cdsEtiquetas.FieldByName('VALITE').AsString := FieldByName('VALITE').AsString;
          cdsEtiquetas.FieldByName('VALVIS').AsString := FieldByName('VALITE').AsString;
          cdsEtiquetas.FieldByName('CODFAB').AsString := FieldByName('CODFAB').AsString;
          cdsEtiquetas.FieldByName('CODBAR').AsString := FieldByName('CODBAR').AsString;
          cdsEtiquetas.FieldByName('LOCFIS').AsString := FieldByName('LOCFIS').AsString;

          cdsEtiquetas.FieldByName('FABITE').AsString := FieldByName('FABITE').AsString;
          cdsEtiquetas.FieldByName('FABCLI').AsString := FieldByName('FABCLI').AsString;
          cdsEtiquetas.FieldByName('APLICA').AsString := FieldByName('APLICA').AsString;
          cdsEtiquetas.FieldByName('LOCSEP').AsString := FieldByName('LSE_DESCRI').AsString;
          cdsEtiquetas.FieldByName('NUMCMP').AsString := FieldByName('NUMCMP').AsString;

          cdsEtiquetas.Post;

          Next;
        End;

      End;

    Finally
      cdsEtiquetas.EnableControls;
      cdsEtiquetas.First;
      FreeAndNil(qryGen);
    End;

    pnlInfo.Font.Color := clRed;
    pnlInfo.Caption    := 'Atenção! Não estão listados os produtos Tintométricos...';

  End
  Else
  Begin
    If cdsEtiquetas.Active Then
    Begin
      cdsEtiquetas.EmptyDataSet;
      cdsEtiquetas.Close;
    End;

    fMensagem('ATENÇÃO!', 'Documento não encontrado!', ['&Ok']);
    cdsEtiquetas.Open;

    pnlInfo.Font.Color := clBlack;
    pnlInfo.Caption    := '';

    If (Self.Visible) Then
      pSetFocus(edtNumDoc);
  End;

end;

procedure TfrmEtiOrcPed.btnAlterarTodasQtdClick(Sender: TObject);
var
  intQtdEti: integer;
begin
  inherited;
  intQtdEti := 1;
  If TfrmDigQuantidade.fDigQuantidade('Digite a Qtd de Etiquetas Desejada', 'Qtd Etiquetas', intQtdEti, 1) Then
    pAjustaQtdAImprimir(False, intQtdEti);
end;

procedure TfrmEtiOrcPed.pAjustaQtdAImprimir(blnRestaurar:Boolean = False; intQtd: Integer = 1);
  Var
    intIndex : Integer;
Begin
  Try
    pnlInfo.Caption := 'Aguarde...';
    Screen.Cursor := crHourGlass;

    If (Assigned(cxgFatDorView.DataController.DataSet)) And
       (cxgFatDorView.DataController.Active) Then
    Begin
      With cxgFatDorView.DataController Do
      Begin
        For intIndex := 0 To DataRowCount-1 Do
        Begin
          FocusedRowIndex := intIndex;
          DataSet.Edit;
          DataSet.FieldByName('QTDIMP').AsInteger := IIF(blnRestaurar, DataSet.FieldByName('QTDETI').AsInteger, intQtd);
          DataSet.Post;
        End;
      End;
    End;

  Finally
    cdsEtiquetas.First;
    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;
  End;

end;

procedure TfrmEtiOrcPed.btnConfigurarClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := 'frmImpEtiquetas';
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpEtiDespacho.btnConfigurarClick]');
    End;
  End;
  pFreeAndNil(frmCadConfRelatorios);

end;

function TfrmEtiOrcPed.GetOrderBy : String;
  Var
    stlOrder : TStringList;
    intIndex : Integer;
Begin
  inherited;
  stlOrder := TStringList.Create;
  Try
    For intIndex := 0 to cxgFatDorView.ColumnCount - 1 Do
    Begin
      if cxgFatDorView.Columns[intIndex].SortIndex >= 0 Then
      Begin
        If (cxgFatDorView.Columns[intIndex].DataBinding.FieldName <> 'IMPRME') Then
          stlOrder.Add('');
      End;
    End;

    For intIndex := 0 to cxgFatDorView.ColumnCount - 1 Do
    Begin
      if cxgFatDorView.Columns[intIndex].SortIndex >= 0 Then
      Begin
        If (cxgFatDorView.Columns[intIndex].DataBinding.FieldName <> 'IMPRME') Then
        Begin
          If cxgFatDorView.Columns[intIndex].SortOrder = soAscending Then
            stlOrder.Strings[cxgFatDorView.Columns[intIndex].SortIndex] := cxgFatDorView.Columns[intIndex].DataBinding.FieldName
          Else
          If cxgFatDorView.Columns[intIndex].SortOrder = soDescending Then
            stlOrder.Strings[cxgFatDorView.Columns[intIndex].SortIndex] := cxgFatDorView.Columns[intIndex].DataBinding.FieldName +' DESC';
        End;
      End;
    End;

    stlOrder.Delimiter := ',';

    Result := ReplaceStr( stlOrder.CommaText, '"', '');

  Finally
    FreeAndNil(stlOrder);
  End;

End;

procedure TfrmEtiOrcPed.btnConfirmaClick(Sender: TObject);
Var
   blnTemIte: Boolean;
   strTipImp: String;
Begin

  If cdsEtiquetas.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um Documento!', ['&Ok']);

    If (Self.Visible) Then
      pSetFocus(edtNumDoc);

    Exit;
  End;

  cdsQtdEti.Open;
  cdsQtdEti.EmptyDataSet;
  cdsQtdEti.Filter   := '';
  cdsQtdEti.Filtered := False;
  blnTemIte := False;

  Try
    With cdsEtiquetas Do
    Begin
      First;
      While Not Eof do
      Begin
        {*******************************************************}
        {* ARMAZENA A QUANTIDADE DE ETIQUETAS DEFINIDA PELO    *}
        {* USUÁRIO QUE SERÁ IMPRESSA PARA CADA UM DOS ITENS.   *}
        {****************************************************MA*}
        cdsQtdEti.Insert;
        cdsQtdEti.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
        cdsQtdEti.FieldByName('QTDIMP').AsInteger    := FieldByName('QTDIMP').AsInteger;
        cdsQtdEti.FieldByName('IMPRME').AsString     := FieldByName('IMPRME').AsString;
        If (FieldByName('IMPRME').AsString = 'S') then
          blnTemIte := True;

        cdsQtdEti.Post;
        Next;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmEtiOrcPed.btnConfirmaClick]');
  End;

  If Not blnTemIte Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há produtos selecionados para impressão!', ['&Ok']);

    If (Self.Visible) Then
      pSetFocus(edtNumDoc);

    Exit;
  End;

  if (fEmptyStr(strCfgTipEti) Or (SameText(strCfgTipEti, 'S'))) then
  begin
    case fGetMenu('Escolha o Formato:', ['Laser', 'Zebra', 'Argox', 'Matricial'], 1) of
      1 : strTipImp := 'L';
      2 : strTipImp := 'Z';
      3 : strTipImp := 'A';
      4 : strTipImp := 'M';
    end;
  end
  else
    strTipImp := strCfgTipEti;

  If (Pos(strTipImp, 'LZA') > 0) Then
  Begin
    pImpEtiquetasLaserArgox(strTipImp);
  End
  Else
  Begin
    pImpEtiquetasMatricial;
  End;

 // cdsEtiquetas.EmptyDataSet;
 // cdsEtiquetas.Close;
//  edtNumDoc.Clear;
//  pSetFocus(edtNumDoc);

end;

procedure TfrmEtiOrcPed.btnLimFilClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  If cdsEtiquetas.Active Then
  Begin
    cdsEtiquetas.EmptyDataSet;
    cdsEtiquetas.Close;
  End;
  edtNumDoc.Clear;

  Screen.Cursor := crDefault;
  pSetFocus(edtNumDoc);
end;

procedure TfrmEtiOrcPed.btnMarDesClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
    intRetorno: Integer;

begin
  inherited;
  If Not cdsEtiquetas.Active Then
    Exit;

  intRetorno := 0;

  Try
    pCriarFormularios(TfrmMenuMarcarEti, frmMenuMarcarEti);
    frmMenuMarcarEti.blnEtiIte := False;
    frmMenuMarcarEti.showModal;

    intRetorno  := frmMenuMarcarEti.intLinha;
    blnConfirma := frmMenuMarcarEti.blnConfirma;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmEtiOrcPed.btnMarDesClick]');
    End;
  End;

  pFreeAndNil(frmMenuMarcarEti);

  If blnConfirma Then
  Begin

    If (intRetorno = ETI_MARCAR) Then
      pMarcaDesmarcar('S')
    Else If intRetorno = ETI_DESMARCAR Then
      pMarcaDesmarcar('N');

  End;

  pSetFocus(cxgFatDor);

end;

procedure TfrmEtiOrcPed.btnRestaurarTodasQtdClick(Sender: TObject);
begin
  If fMensagem('ATENÇÃO!', 'Confirma restauração das Qtd. a imprimir?', ['&Sim','&Não']) = 1 Then
    pAjustaQtdAImprimir(True);
end;

procedure TfrmEtiOrcPed.cxgFatDorViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If cxgFatDorQTDIMP.Focused Then
      cxgFatDorImprimir.Focused := True
    Else If cxgFatDorImprimir.Focused Then
    Begin
      cdsEtiquetas.Next;
      cxgFatDorQTDIMP.Focused := True
    End;
  End;
end;

function TfrmEtiOrcPed.fVerificaDocExiste(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT   ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   FATGOR ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   FGO_CODEMP = :CODEMP     ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger = 0 Then
        Result := False
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmEtiOrcPed.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    btnLimFil.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    btnConfigurar.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    btnMarDes.Click;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    Begin
      If Not (cdsEtiquetas.IsEmpty) Then
        cdsEtiquetas.EmptyDataSet;
      cdsEtiquetas.Close;
      cdsEtiquetas.Open;

      edtNumDoc.Clear;
      pSetFocus(edtNumDoc);

      pnlInfo.Font.Color := clBlack;
      pnlInfo.Caption    := '';
    End;
  End;

end;

procedure TfrmEtiOrcPed.pImpEtiquetasLaserArgox(strTipImp : String);
  Var
    prmDllEtq: TParamDllEtiquetas;
begin
  prmDllEtq := TParamDllEtiquetas.Create;
  prmDllEtq.tpeTipEtq := tpeItensOrcPedLaser;
  prmDllEtq.strTipImp := strTipImp;
  prmDllEtq.strCodEmp := ShortString(edtCodEmpresa.Text);
  prmDllEtq.strNumDoc := ShortString(edtNumDoc.Text);
  prmDllEtq.strEspDoc := ShortString(edtEspDoc.Text);
  prmDllEtq.cdsPromoc := cdsQtdEti;
  prmDllEtq.blnImpEti := blnImpEti;
  prmDllEtq.strIdxFld := GetOrderBy;

  fImprimeEtiqueta(prmDllEtq);
  FreeAndNil(prmDllEtq);
end;

procedure TfrmEtiOrcPed.pImpEtiquetasMatricial;
begin
  intColAtu := 1;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Exit;
  End;

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(cdsEtiquetas, 'FATDOR');

  With cdsEtiquetas Do
  Begin
    First;
    While Not Eof Do
    Begin
      Application.ProcessMessages;
      If Not fImpRegistro Then
        break;
      Application.ProcessMessages;
      Next;
    End;
    {**********************************************************************************}
    {* É NECESSARIO CHAMAR ESSA PROCEDURE NESSE PONTO PARA QUE SAIA A ÚLTIMA ETIQUETA *}
    {*******************************************************************************MV*}
    pImpArrLinhasEti;

    cdsEtiquetas.Close;
    cdsEtiquetas.Open;
  End;
end;

Function TfrmEtiOrcPed.fImpRegistro: Boolean;
  Var
    intQtdCol   : Integer;
    intQtdColOri: Integer;
    intContador : Integer;
    intLinhaAtu : Integer;
    intLinha    : Integer;
    intTamLinAnt: Integer;
    intNumCol   : Integer;
    intQtdEti   : Integer;
    intLinhaEti : Integer;
    strNumCol   : String;
    strLinha    : String;
    strSQL      : String;
    qryCnfEti   : TUniQuery;
begin
  Result := True;

  intLinhaAtu := 1;
  intLinha    := 0;
  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfEti := fCriaQuery(Self);
  With qryCnfEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := 'DES';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    intQtdEti := 1;

    If RecordCount = 0 Then
    Begin
      Result := False;
      pMensagemOk('O layout de etiqueta matricial não está configurado!');
    End;

    While (intQtdEti > 0) And (RecordCount > 0) Do
    Begin
      First;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
        intQtdCol := intQtdEti;

      {*****************************************}
      {* LÊ E INTERPRETA O ID = '00'           *}
      {**************************************MV*}
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
        {*****************************************}
        {* ESCREVE COM WRITE, MAS NÃO IMPRIME    *}
        {**************************************MV*}
        pEscreveLinha(strArqTxt, AnsiString(strLinha), not VS_SpoolImpressaoCitel, strNomImp, strNomPro, strDesPro);
      End;
      Next;

      If (Length(arrLinhasEti) = 0) And (RecordCount > 0) Then
      Begin
        SetLength(arrLinhasEti, RecordCount-1);
      End;

      While (Not Eof) Do
      Begin

        If cpuCampos <> Nil Then
          FreeAndNil(cpuCampos);

        cpuCampos := TCamposUso.Create;
        cpuCampos.AdicionaCampos(cdsEtiquetas, 'FATGOR');

        strLinha := '';
        For intContador := intColAtu To intQtdCol Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha, strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfEti);

          arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
          strLinha := ''; //Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        {*****************************************}
        {* NEXT NO ARQUIVO DE CNF                *}
        {**************************************MV*}
        Next;

      End;

      intLinhaEti := 0;
      Dec(intQtdEti, (intQtdColOri+1) - intColAtu);

      Inc(intColAtu, intQtdCol);
      If intColAtu >= intQtdColOri+1 Then
      Begin
        pImpArrLinhasEti;
        intColAtu := 1;
      End;

    End;

  End;
  FreeAndNil(qryCnfEti);
end;

procedure TfrmEtiOrcPed.spnQtdImpPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if strToIntDef(DisplayValue, 0) <= 0 Then
  Begin
    DisplayValue := '1';
    Error := False;
  End;
end;

procedure TfrmEtiOrcPed.pImpArrLinhasEti;
  Var
    intContador1: Integer;
    intLength1: Integer;
    blnUltimoReg: Boolean;
    strLinhaAtu: String;
    blnImprime: Boolean;
begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
    Exit;

  For intContador1 := 0 To intLength1-1 Do
  Begin
    If (intContador1 = intLength1-1) Then
      blnUltimoReg := True;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]), blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
end;

procedure TfrmEtiOrcPed.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), posiciona a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  pSetaCodIte(cdsEtiquetasCODITE);
  cxgFatDorCODFAB.Visible := fCfgSis('CLIPRO', varBoolean) And (opcEtiqueta in fRetUtilizaCliPro);
  cxgFatDorCODBAR.Visible := fCfgSis('CLIPRO', varBoolean) And (opcEtiqueta in fRetUtilizaCliPro);

  blnImpEti := False;
  strCfgTipEti := fCfgSis('TIPETI');
  strOrdPdv    := fCfgSis('ORDPDV');
  strOrdOrc    := fCfgSis('ORDORC');

  If (fCfgSis('ESPCFO') = 'OR') Then
    Self.Caption := 'Etiquetas - Produtos do Orçamento'
  Else
    Self.Caption := 'Etiquetas - Produtos do Pedido';

  Self.Repaint;
    
end;

procedure TfrmEtiOrcPed.FormShow(Sender: TObject);
begin
  inherited;

  edtEspDoc.Text := fCfgSis('ESPCFO');
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  cdsEtiquetas.CreateDataSet;
  cdsEtiquetas.Open;
  cdsEtiquetas.EmptyDataSet;
  cdsEtiquetas.Filter   := '';
  cdsEtiquetas.Filtered := FALSE;

  cdsQtdEti.CreateDataSet;

  WindowState := wsMaximized;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;
end;

procedure TfrmEtiOrcPed.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmEtiOrcPed.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pnlInfo.Font.Color := clBlack;
  pnlInfo.Caption    := '';

end;

procedure TfrmEtiOrcPed.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    fValidaCampos(edtCodEmpresa, True);
  End;
end;

procedure TfrmEtiOrcPed.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmEtiOrcPed.pMarcaDesmarcar(strMarcar: String);
  Var
    intIndex : Integer;
Begin
  Try
    pnlInfo.Caption := 'Aguarde...';
    Screen.Cursor := crHourGlass;

    If (Assigned(cxgFatDorView.DataController.DataSet)) And
       (cxgFatDorView.DataController.Active) Then
    Begin
      With cxgFatDorView.DataController Do
      Begin
        For intIndex := 0 To DataRowCount-1 Do
        Begin
          FocusedRowIndex := intIndex;
          DataSet.Edit;
          DataSet.FieldByName('IMPRME').AsString := strMarcar;
          DataSet.Post;
        End;
      End;
    End;

  Finally
    cdsEtiquetas.First;
    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;
  End;

End;

end.
