unit untRelEstDigitacaoNotaEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxClass, frxDesgn, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, UniClientDataSet, Uni, Mask, MaskEditFocus,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelEstDigitacaoNotaEntrada = class(TfrmPaiRelatorio)
    frxPagina_J: TfrxReport;
    frxPagina_M: TfrxReport;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    Label2: TLabel;
    lblCliFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    frxIteNao: TfrxDBDataset;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblDesDtaIni: TLabel;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDesDtaFin: TLabel;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    function frxPagina_JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryCadFor: TUniQuery;
    qryIteNao: TUniQuery;
    
    procedure pCarregaFornecedor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    Function fAbreItensNaoRelacionados(strNumDoc, strEspDoc,
                                       strCodEmp, strSerie_,
                                       strCodFor, strIteHis: String): Boolean;
  public
    { Public declarations }
    procedure pImprimeRelatorio(oleItens: OleVariant);
  end;

implementation

uses untFuncoesSimples, untPesqAux, untPai, Data.DB, untConstantes, untConsultas,
  untModuloSPR, StrUtils, untTypesSistema;

{$R *.dfm}

{ TfrmRelEstDigitacaoNotaEntrada }

procedure TfrmRelEstDigitacaoNotaEntrada.pImprimeRelatorio(
  oleItens: OleVariant);
  Var
    cdsRelatorio: TUniClientDataSet;
begin
  cdsRelatorio := TUniClientDataSet.Create(Self);
  cdsRelatorio.Data := oleItens;
  cdsRelatorio.IndexFieldNames := 'CODITE;NUMPED';

  If (Not cdsRelatorio.IsEmpty) Then
  Begin

    frxRelatorio.DataSet := cdsRelatorio;

    frxPagina_J.Script.Variables['NOMREL'] := 'frmRelEstDigitacaoNotaEntrada';
    frxPagina_J.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
    frxPagina_J.Script.Variables['TITREL'] := 'CONFERENCIA DA DIGITACAO DA ENTRADA DE MERCADORIAS ';

    frxIteNao.DataSet := cdsRelatorio;

    TfrxGroupFooter(frxPagina_J.FindObject('GroupFooterNota')).Visible := False;

    pPreviewReport(Self.Name, Self.Caption, frxPagina_J);

  End
  Else
  Begin
    pTabelaVazia;
  End;
  FreeAndNil(cdsRelatorio);
end;

procedure TfrmRelEstDigitacaoNotaEntrada.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelEstDigitacaoNotaEntrada.frxPagina_JUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName, 'fAbreItensNaoRelacionados') Then
    fAbreItensNaoRelacionados(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5]);

end;

function TfrmRelEstDigitacaoNotaEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumDoc) Then
  Begin
    mskDtaIni.Enabled := fEmptyStr(edtNumDoc.Text);
    mskDtaFin.Enabled := fEmptyStr(edtNumDoc.Text);

    If Not mskDtaIni.Enabled Then
    Begin
      mskDtaIni.Clear;
      mskDtaFin.Clear;
    End;
  End

  Else If (Sender = edtSerie) Then
  Begin

  End

  Else If (Sender = edtCodFor) Then
  Begin

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      pCarregaFornecedor;
      If (qryCadFor.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End Else
    Begin

      If Not fEmptyStr(edtNumDoc.Text) Then
      Begin

        If fEmptyStr(edtCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End;

      End;

    End;

  End

  Else If (Sender = mskDtaIni) Then
  Begin

    If mskDtaIni.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = mskDtaFin) Then
  Begin

    If mskDtaFin.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End;

  End

end;

procedure TfrmRelEstDigitacaoNotaEntrada.pCarregaFornecedor;
begin
  pPesquisaCadFor(Nil, qryCadFor, edtCodFor.Text);
  edtNomFor.Text := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmRelEstDigitacaoNotaEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadFor := fCriaQuery(Self);
  qryIteNao := fCriaQuery(Self);

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  frxPagina_J.AddFunction('function fAbreItensNaoRelacionados(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor, strIteHis: String): Boolean');
  frxPagina_M.AddFunction('function fAbreItensNaoRelacionados(strNumDoc, strEspDoc, strCodEmp, strSerie_, strCodFor, strIteHis: String): Boolean');
end;

procedure TfrmRelEstDigitacaoNotaEntrada.FormShow(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamNumDoc;
  edtNumDoc.MaxLength := fTamNumDoc;
end;

procedure TfrmRelEstDigitacaoNotaEntrada.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumDoc);
end;

procedure TfrmRelEstDigitacaoNotaEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadFor);
end;

procedure TfrmRelEstDigitacaoNotaEntrada.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    frxPagina: TfrxReport;
begin
  inherited;

  If (Not fVerificaCampos) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
	strSQL := strSQL + '  CONCAT(HIS_NUMDOC, HIS_ESPDOC, HIS_CODFOR, IFNULL(HIS_SERIE_, "")) AS KEYDOC, ';
	strSQL := strSQL + '  HIS_SERIE_ AS SERIE_, ';
	strSQL := strSQL + '  HIS_NUMDOC AS NUMDOC, ';
	strSQL := strSQL + '  HIS_ESPDOC AS ESPDOC, ';
	strSQL := strSQL + '  HIS_CODEMP AS CODEMP, ';
	strSQL := strSQL + '  HIS_CODFOR AS CODFOR, ';
	strSQL := strSQL + '  HIS_NUMPED AS NUMPED, ';
	strSQL := strSQL + '  HIS_EMPPED AS EMPPED, ';
	strSQL := strSQL + '  HIS_CODITE AS CODITE, ';
	strSQL := strSQL + '  HIS_DESITE AS DESITE, ';
	strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
	strSQL := strSQL + '  HIS_QTDITE AS QTDITE, ';
  strSQL := strSQL + '  HIS_UNITAR AS UNITAR, ';
  strSQL := strSQL + '  HIS_TOTITE AS TOTITE, ';
	strSQL := strSQL + '  HIS_QTDBAI AS QTDBAI, ';
  strSQL := strSQL + '  HIS_UNIBAI AS UNIBAI, ';
  strSQL := strSQL + '  HIS_TOTBAI AS TOTBAI, ';
	strSQL := strSQL + '  HIS_EXCESS AS EXCESS, ';
  strSQL := strSQL + '  HIS_DIFQTD AS DIFQTD, ';
  strSQL := strSQL + '  HIS_DIFUNI AS DIFUNI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  HISENT ';
  strSQL := strSQL + '  JOIN CADITE ON (HIS_CODITE=ITE_CODITE) ';
  strSQL := strSQL + '  JOIN CADUNI ON (ITE_CODUNI=UNI_CODUNI) ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    strSQL := strSQL + ' INNER JOIN MOVGER ON ';
    strSQL := strSQL + '    GER_NUMDOC = HIS_NUMDOC AND ';
    strSQL := strSQL + '    GER_ESPDOC = HIS_ESPDOC AND ';
    strSQL := strSQL + '    GER_CODEMP = HIS_CODEMP AND ';
    strSQL := strSQL + '    GER_CODFOR = HIS_CODFOR AND ';
    strSQL := strSQL + '    IFNULL(GER_SERIE_, "") = IFNULL(HIS_SERIE_, "") AND ';
    strSQL := strSQL + '    GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  End;

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  (HIS_ESPDOC = "NF" OR HIS_ESPDOC = "EL" OR HIS_ESPDOC = "PD")  ';

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    strSQL := strSQL + '  AND HIS_NUMDOC = :NUMDOC ';

    If fEmptyStr(edtSerie.Text) Then
      strSQL := strSQL + '  AND HIS_SERIE_ IS NULL '
    Else
      strSQL := strSQL + '  AND HIS_SERIE_ = :SERIE_ ';
  End;

  If Not fEmptyStr(edtCodFor.Text) Then
    strSQL := strSQL + '  AND HIS_CODFOR = :CODFOR ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  KEYDOC, HIS_CODITE, HIS_NUMPED, HIS_CODEMP ';

  frmModuloSPR.qryRelatorio.SQL.Clear;
  frmModuloSPR.qryRelatorio.SQL.Add(strSQL);

  If Not fEmptyStr(edtCodFor.Text) Then
    frmModuloSPR.qryRelatorio.ParamByName('CODFOR').AsString := edtCodFor.Text;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    frmModuloSPR.qryRelatorio.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    frmModuloSPR.qryRelatorio.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
  End Else
  Begin
    If Not fEmptyStr(edtSerie.Text) Then
      frmModuloSPR.qryRelatorio.ParamByName('SERIE_').AsString := edtSerie.Text;
    frmModuloSPR.qryRelatorio.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
  End;

  frmModuloSPR.qryRelatorio.Open;

  If (Not frmModuloSPR.qryRelatorio.IsEmpty) Then
  Begin

    frxRelatorio.DataSet := frmModuloSPR.qryRelatorio;
    frmModuloSPR.qryRelatorio.First;

    If (strTipImp = 'J') Then
      frxPagina := frxPagina_J
    Else
      frxPagina := frxPagina_M;

    frxIteNao.DataSet := qryIteNao;

    frxPagina.PrintOptions.ShowDialog := False;
    frxPagina.Script.Variables['NOMREL'] := 'frmRelEstDigitacaoNotaEntrada';
    frxPagina.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

    frxPagina.Script.Variables['TITREL'] := 'CONFERENCIA DA DIGITACAO DA ENTRADA DE MERCADORIAS ';

    If (frxPagina.PrepareReport) Then
    Begin
      If (edtDestino.Text = 'V') Then
        pPreviewReport(Self.Name, Self.Caption, frxPagina)
      Else
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxPagina);
    End;

    pSetFocus(edtNumDoc);

  End
  Else
  Begin
    pTabelaVazia;
    pSetFocus(edtNumDoc);
  End;

end;

Function TfrmRelEstDigitacaoNotaEntrada.fAbreItensNaoRelacionados(strNumDoc, strEspDoc,
  strCodEmp, strSerie_, strCodFor, strIteHis: String): Boolean;
   Var
     strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   DET_CODITE AS CODITE, ';
    strSQL := strSQL + '   DET_DESCRI AS DESITE, ';
    strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '   DET_QTDITE AS QTDITE, ';
    strSQL := strSQL + '   DET_UNITAR AS UNITAR, ';
    strSQL := strSQL + '   DET_TOTITE AS TOTITE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + '   JOIN CADUNI ON (DET_UNIDAD=UNI_CODUNI) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   (DET_ESPDOC = "NF" OR DET_ESPDOC = "EL" OR DET_ESPDOC = "PD") AND ';
    strSQL := strSQL + '   DET_CODFOR = :CODFOR ';

    If Not fEmptyStr(strIteHis) Then
      strSQL := strSQL + '   AND DET_CODITE NOT IN ( ' + strIteHis + ' ) ';

    qryIteNao.Close;
    qryIteNao.SQL.Clear;
    qryIteNao.SQL.Add(strSQL);

    qryIteNao.ParamByName('NUMDOC').AsString := strNumDoc;
    qryIteNao.ParamByName('CODFOR').AsString := strCodFor;

    qryIteNao.Open;

    Result := True;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRelEstDigitacaoNotaEntrada.fAbreItensNaoRelacionados]');
    End;

  End;

End;

end.
