unit untRelEstKardexAcabado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus,untClassPanelCx,
  Uni, StrUtils, BitBtnLockedIncrem, untTypesSistema, frxExportCSVTestabilidade,
  untIFuncoes, Data.DB, cxStyles, cxClasses, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelEstKardexAcabado = class(TfrmPaiRelatorio)
    Label1: TLabel;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtProAca: TEditFocus;
    edtDesProAca: TEditFocus;
    Label3: TLabel;
    edtEmpAca: TEditFocus;
    edtDesEmpAca: TEditFocus;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    frxUserDS: TfrxUserDataSet;
    dtsCadAca: TDataSource;
    cxsStyle: TcxStyleRepository;
    cxsZebra: TcxStyle;
    Panel1: TPanel;
    Panel2: TPanel;
    cxgItens: TcxGrid;
    cxvItens: TcxGridDBTableView;
    cxvItensColumn1: TcxGridDBColumn;
    cxvItensColumn2: TcxGridDBColumn;
    cxvItensColumn3: TcxGridDBColumn;
    cxvItensColumn4: TcxGridDBColumn;
    cxvItensColumn5: TcxGridDBColumn;
    cxvItensColumn6: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    chkDocCan: TCheckBox;
    btnSaldos: TBitBtnLocked;
    procedure edtProAcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxUserDSGetValue(const VarName: String; var Value: Variant);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpAcaEnter(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSaldosClick(Sender: TObject);
  private
    { Private declarations }
    fltSalFin: Double;

    strEmpAcaAnt: String;

    qryAcabados,
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    procedure pAbreAcabados;
    procedure pAfterScroll(dataSet: TDataSet);

    Function fRetSaldoInicial: Double;
    Function fRetSaldoReal: Double;
  public
    { Public declarations }
    Function fSqlRelatorio: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes, untCfgRel, untConsultaCadAcaLojas;

{$R *.dfm}

procedure TfrmRelEstKardexAcabado.btnSaldosClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtEmpAca, False) Then
    Exit;

  If Not fValidaCampos(edtProAca, False) Then
    Exit;

  pCriarFormularios(TfrmConsultaCadAcaLojas, frmConsultaCadAcaLojas);
  With frmConsultaCadAcaLojas Do
  Begin
    strCodAca := edtProAca.Text;
    strCodEmp := edtEmpAca.Text;
    ShowModal;
  End;
  pFreeAndNil(frmConsultaCadAcaLojas);

  If (Not qryAcabados.IsEmpty) Then
    pSetFocus(cxgItens)
end;

procedure TfrmRelEstKardexAcabado.edtEmpAcaEnter(Sender: TObject);
begin
  inherited;

  strEmpAcaAnt := edtEmpAca.Text;
end;

procedure TfrmRelEstKardexAcabado.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, TEditFocus(Sender), Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstKardexAcabado.edtProAcaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqProdAcabado(Self, edtProAca, edtDesProAca, Nil, Key, arrSel, edtEmpAca.Text,edtEmpresa.Text, True, 'Consulta de Produtos Acabados') Then
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmRelEstKardexAcabado.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtEmpresa) Then
    Begin

      If fEmptyStr(edtEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtEmpresa.Text);
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Empresa de Movimentação não encontrada!',['&O K']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtEmpAca) Then
    Begin

      If fEmptyStr(edtEmpAca.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa do Produto Acabado deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmpAca.Text := fRetNomeEmpresa(edtEmpAca.Text);
        If fEmptyStr(edtDesEmpAca.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Empresa do Produto Acabado não encontrada!',['&O K']);
          Result := False;
        End
      End;

      If Result And blnValidaIndividual Then
      Begin
        If strEmpAcaAnt <> edtEmpAca.Text Then
          qryAcabados.Close;

        edtProAca.Clear;
        edtDesProAca.Clear;
      End;

    End

    Else If (Sender = edtProAca) Then
    Begin
      If fEmptyStr(edtEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa deve ser preenchido!',['&O K']);
        Result := False;
      End;

      If fEmptyStr(edtEmpAca.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Empresa do Produto Acabado deve ser preenchido!',['&O K']);
        Result := False;
      End;

      If Not fEmptyStr(edtProAca.Text) And Not fEmptyStr(edtEmpresa.Text) Then
      Begin

        edtDesProAca.Text := fRetNomProdutoAcabado(edtProAca.Text, edtEmpresa.Text, edtEmpAca.text );
        If fEmptyStr(edtDesProAca.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Produto Acabado não encontrado!',['&O K']);
          Result := False;
        End

      End Else
      Begin
        edtDesProAca.Clear;
        edtProAca.Clear;

        If Result And blnValidaIndividual Then
          pAbreAcabados;
      End;

    End

    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelEstKardexAcabado.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

Function TfrmRelEstKardexAcabado.fSqlRelatorio: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  " " AS DOCCAN, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "ML" AND DET_CLAFIS >= 5000 AND DET_DTAFAT IS NOT NULL, DET_NUMFAT, DET_NUMDOC) AS NUMDOC, ';
  strSQL := strSQL + '  DET_CODITE AS CODITE, ';
  strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  IF(DET_ESPDOC = "ML" AND DET_CLAFIS >= 5000 AND DET_DTAFAT IS NOT NULL, DET_TIPFAT, DET_ESPDOC) AS ESPDOC, ';
  strSQL := strSQL + '  DET_ESPDOC AS ESPORI, ';
  strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  LEFT(DET_HORENT,5) AS HORENT, ';

  strSQL := strSQL + '  IF(DET_CODCLI IS NULL, CONCAT(DET_CODFOR, "-", FOR_NOMFOR), CONCAT(DET_CODCLI, "-", CLI_NOMCLI)) AS CODCLI, ';

  strSQL := strSQL + '  DET_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '  LEFT(DET_CLAFIS,1) AS CLAFIS, ';

  strSQL := strSQL + '  IF(DET_CLAFIS >= 5000, DET_QTDITE, 0)                AS QTDSAI, ';
  strSQL := strSQL + '  IF(DET_CLAFIS >= 5000, DET_UNITAR, 0)                AS UNISAI, ';
  strSQL := strSQL + '  IF(DET_CLAFIS >= 5000, (DET_TOTCUS / DET_QTDITE), 0) AS CUSSAI, ';

  strSQL := strSQL + '  IF(DET_CLAFIS >= 5000, 0, DET_QTDITE)                AS QTDENT, ';
  strSQL := strSQL + '  IF(DET_CLAFIS >= 5000, 0, DET_UNITAR)                AS UNIENT, ';
  strSQL := strSQL + '  IF(DET_CLAFIS >= 5000, 0, (DET_TOTCUS / DET_QTDITE)) AS CUSENT, ';

  strSQL := strSQL + '  DET_CODVEN AS CODOPE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON DET_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADFOR ON DET_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';

  strSQL := strSQL + '  DET_ESPDOC <> "ML" AND ';

  {Req: 149320}
  strSQL := strSQL + '  DET_ESPDOC <> "RO" AND ';

  strSQL := strSQL + '  DET_ESPDOC <> "PA" AND ';  //ordem de producao avulsa de produtos tintométricos  

  strSQL := strSQL + '  DET_CODEMP = ' + QuotedStr(edtEmpresa.Text) + ' AND ';

  strSQL := strSQL + '  DET_DTAENT BETWEEN ' +  QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(mskDtaIni.Text))) + ' AND ' +
                                                QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(mskDtaFin.Text))) + ' AND ';
  strSQL := strSQL + '  DET_CODACA = ' + QuotedStr(edtProAca.Text) + ' AND ';
  strSQL := strSQL + '  DET_EMPACA = ' + QuotedStr(edtEmpAca.Text) + '    ';

  strSQL := strSQL + '  AND IF(DET_CLAFIS IN ("1202", "2202", "1411", "2411"), DET_PROACA = "S", TRUE) ';
  strSQL := strSQL + '  AND IFNULL(DET_DOCFUT, "") = "" '; //não mostrar documentos de baixa de entrega futura

  If chkDocCan.Checked Then
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, '" " AS DOCCAN', '"*" AS DOCCAN'), 'MOVDET', 'DEL_MOVDET');

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   DTAENT, HORENT, ESPORI, NUMDOC ';

  Result := strSQL;
End;

Function TfrmRelEstKardexAcabado.fRetSaldoInicial: Double;
  Var
    qryGer: TUniQuery;
    strSQL: String;
Begin
  qryGer := fCriaQuery;
  With qryGer, SQL Do
  Begin
    Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT SUM(IF(DET_CLAFIS >= 5000, -DET_QTDITE, DET_QTDITE)) AS SALDOS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  DET_DTAENT < :DTAINI AND ';
    strSQL := strSQL + '  DET_CODACA = :CODACA AND ';
    strSQL := strSQL + '  DET_EMPACA = :EMPACA     ';

    Add('SELECT SUM(SALDOS) AS SALDOS');
    Add('FROM (');
    Add(strSQL);
    Add(' ) AS TAB');

    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('CODEMP').AsString := edtEmpresa.Text;
    ParamByName('EMPACA').AsString := edtEmpAca.Text;
    ParamByName('CODACA').AsString := edtProAca.Text;

    Open;

    Result := FieldByName('SALDOS').AsFloat;

    Close;
  End;
  FreeAndNil(qryGer);
End;

Function TfrmRelEstKardexAcabado.fRetSaldoReal: Double;
var
  qryAcaGer: TUniQuery;
Begin
  qryAcaGer := nil;
  Result := 0; 
  Try
    Try
      qryAcaGer := fCriaQuery;
      With qryAcaGer, SQL Do
      Begin
        Clear;
        Add('SELECT ACA_SALDOS FROM ACAGER');
        Add('WHERE ACA_CODACA = :CODACA AND ACA_CODEMP = :EMPACA');
        Add('AND ACA_EMPEST = :EMPEST');

        ParamByName('CODACA').AsString := edtProAca.Text;
        ParamByName('EMPACA').AsString := edtEmpAca.Text;
        ParamByName('EMPEST').AsString := edtEmpresa.Text;
        Open;

        Result := FieldByName('ACA_SALDOS').AsFloat;

        Close;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryAcaGer) then FreeAndNil(qryAcaGer);
  End;

End;

procedure TfrmRelEstKardexAcabado.btnImprimirClick(Sender: TObject);
  Var
    frxRelatorio: TfrxReport;
    strNomImp: String;
    fltSalIni: Double;
begin
  edtDesProAca.Text := fRetNomProdutoAcabado(edtProAca.Text, edtEmpAca.Text, edtEmpAca.text );
  If fEmptyStr(edtDesProAca.Text) Then
  Begin
    edtProAca.Clear;
    fMensagem('ATENÇÃO!','Informe um produto acabado !',['&O K']);
    Exit;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    fltSalIni := fRetSaldoInicial;
    fltSalFin := fltSalIni;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      ParamCheck := False;
      SQL.Add(fSqlRelatorio);
      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCarregaConfImpr(qryCfgRel, Self.Name);
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
        strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

        If strTipImp = 'M' Then
          frxRelatorio := frxReportM
        Else
        Begin
          frxRelatorio := frxReportJ;
          TfrxMemoView(frxRelatorio.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');
        End;

        frxRelatorio.Script.Variables['NOMREL']  := 'RELATORIO DE FICHA KARDEX DE PRODUTO ACABADO';
        frxRelatorio.Script.Variables['PERIODO'] := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
        frxRelatorio.Script.Variables['EMPRESA'] := 'EMPRESA DE MOVIMENTACAO: ' + edtEmpresa.Text + ' - ' + edtDesEmpresa.Text;
        frxRelatorio.Script.Variables['EMPACA']  := 'EMPRESA DO PRODUTO ACABADO: ' + edtEmpAca.Text + ' - ' + edtDesEmpAca.Text;
        frxRelatorio.Script.Variables['PROACA']  := 'PRODUTO ACABADO: ' + edtProAca.Text + ' - ' + edtDesProAca.Text;
        frxRelatorio.Script.Variables['SALINI']  := 'SALDO INICIAL DO ITEM: ' + FormatFloat('#,##0.00', fltSalIni);
        frxRelatorio.Script.Variables['SALREA']  := fRetSaldoReal;
        frxRelatorio.Script.Variables['DOCCAN']  := IfThen(chkDocCan.Checked, '(*) DOCUMENTOS CANCELADOS', '');

        frxRelatorio.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

        If edtDestino.Text = 'V' Then
        Begin
          pPreviewReport(Self.Name, Self.Caption, frxRelatorio)
        End
        Else
          If frxRelatorio.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxRelatorio);
      Except
        On E: Exception Do
        Begin
          qryRelatorio.SQL.Clear;
          qryRelatorio.ParamCheck := True;
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;

  qryRelatorio.Close;
  qryRelatorio.SQL.Clear;
  qryRelatorio.ParamCheck := True;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

  If (Not qryAcabados.IsEmpty) Then
    pSetFocus(cxgItens)
  Else
    pSetFocus(edtEmpresa);

end;

procedure TfrmRelEstKardexAcabado.FormCreate(Sender: TObject);
begin
  inherited;

  strEmpAcaAnt := '';

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtEmpresa.Text    := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtEmpresa.Text);
  edtEmpAca.Text     := VS_strCodEmp;
  edtDesEmpAca.Text  := fRetNomeEmpresa(edtEmpAca.Text);

  qryAcabados := fCriaQuery(Self);
end;

procedure TfrmRelEstKardexAcabado.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstKardexAcabado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F4: btnSaldos.Click;
  End;
end;

procedure TfrmRelEstKardexAcabado.FormResize(Sender: TObject);
begin
  inherited;

  btnImprimir.Left   := 3;
  btnConfigurar.Left := 80;
  btnSaldos.Left     := 195;
end;

procedure TfrmRelEstKardexAcabado.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
end;

procedure TfrmRelEstKardexAcabado.frxUserDSGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If SameText('fltSaldos', VarName) Then
  Begin
    fltSalFin := fltSalFin - qryRelatorio.FieldByName('QTDSAI').AsFloat +
                             qryRelatorio.FieldByName('QTDENT').AsFloat;
    Value     := fltSalFin;
  End

  Else   If SameText('fltSalFin', VarName) Then
  Begin
    Value     := fltSalFin;
  End;

end;

procedure TfrmRelEstKardexAcabado.pAfterScroll(dataSet: TDataSet);
Begin
   With dataSet Do
   Begin
     If IsEmpty Then
       Exit;

     edtProAca.Text    := FieldByName('CODACA').Text;
     edtDesProAca.Text := FieldByName('DESCRI').Text;
   End;
End;

procedure TfrmRelEstKardexAcabado.pAbreAcabados;
  Var
    strSQL: String;
Begin
  If (Not fEmptyStr(edtEmpAca.Text)) And
     (Not fEmptyStr(edtEmpresa.Text)) Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   A.ACA_IDEPRO AS IDEPRO, ';
    strSQL := strSQL + ' 	 A.ACA_CODACA AS CODACA, ';
    strSQL := strSQL + '   A.ACA_DESCRI AS DESCRI, ';
    strSQL := strSQL + '   A.ACA_CODBAR AS CODBAR, ';
    strSQL := strSQL + '   ACA_SALDOS   AS SALDOS, ';
    strSQL := strSQL + '   G.ACA_PREVEN AS PREVEN  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  	ACAGER G ';
    strSQL := strSQL + ' JOIN	CADACA A ON G.ACA_CODACA = A.ACA_CODACA AND ';
    strSQL := strSQL + '                  G.ACA_CODEMP = A.ACA_CODEMP     ';

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '     	G.ACA_CODEMP = ' + QuotedStr(edtEmpAca.Text);
    strSQL := strSQL + '	AND G.ACA_EMPEST = ' + QuotedStr(edtEmpresa.Text);
    strSQL := strSQL + '	AND G.ACA_SALDOS <> 0 ';

    dtsCadAca.DataSet := qryAcabados;

    With qryAcabados Do
    Begin
      AfterScroll := pAfterScroll;

      Close;
      SQL.Text := strSQL;
      Open;

      FieldByName('CODACA').Alignment := taCenter;
      FieldByName('IDEPRO').Alignment := taCenter;
      FieldByName('CODBAR').Alignment := taCenter;

      If Not IsEmpty Then
        Self.WindowState := wsMaximized;

    End;
  End;
End;

end.
