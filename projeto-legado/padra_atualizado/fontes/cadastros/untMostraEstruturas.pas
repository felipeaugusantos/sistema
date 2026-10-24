unit untMostraEstruturas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass, Uni, strUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, cxGridCitel, UniClientDataSet,
  cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxTLData, cxDBTL, cxMaskEdit,
  EditFocus, untTypesSistema, Math, untFuncoesRel, untFuncoesRel2,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  Faturamento.Connections.Functions;

Type
  TfrmMostraEstruturas = class(TfrmPaiSimples)
    Panel1: TPanel;
    btnSimilares: TBitBtnLocked;
    dtsItens: TDataSource;
    cxDBTreeEstru: TcxDBTreeList;
    CODITE: TcxDBTreeListColumn;
    DESITE: TcxDBTreeListColumn;
    CODFAB: TcxDBTreeListColumn;
    QTDITE: TcxDBTreeListColumn;
    SIMILI: TcxDBTreeListColumn;
    PRECUS: TcxDBTreeListColumn;
    TOTCUS: TcxDBTreeListColumn;
    CUSREA: TcxDBTreeListColumn;
    TOTCUR: TcxDBTreeListColumn;
    StyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    TreeListStyleSheetDevExpress: TcxTreeListStyleSheet;
    edtCodIte: TEditFocus;
    lblCodIte: TLabel;
    SALITE: TcxDBTreeListColumn;
    SALDIS: TcxDBTreeListColumn;
    lblQtdEstrutura: TLabel;
    lblTotEstrutura: TLabel;
    CODMAR: TcxDBTreeListColumn;
    CUSUTI: TcxDBTreeListColumn;
    pnlLegendaCustoUti: TPanel;
    DESMAR: TcxDBTreeListColumn;
    procedure btnSimilaresClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dtsItensDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    strMskQtd : String;
    qryGerMat : TUniQuery;
    qryDetMat : TUniQuery;
    cdsItens  : TUniClientDataSet;
    function fGetDetMat(strCodEmp: String): String;
    function fCriaEstruturaCds: TUniClientDataSet;
    procedure pProcessaTreeView(strCodIte : String);
    procedure pProcessaTreeViewInterno;
    function fGetPrecoCusto: String;
    procedure pSetLegendaCusUti;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    FblnExiSal,
    FblnExiCus,
    FblnVisCod,
    FblnPedCor: Boolean;
    FstrCodEmp,
    FstrCodIte,
    FstrCodIteProcessaTreeView: String;
  end;

procedure pMostraEstrutura(strCodIte: String;
                           strCodEmp: String='';
                           blnExiSal: Boolean=False;
                           blnPedCor: Boolean=False;
                           blnExiCus: Boolean=True;
                           blnVisCod: Boolean=True);

var
  frmMostraEstruturas: TfrmMostraEstruturas;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesAuxiliares,
  untGravando, untIFatReservaSaldo, untTFatReservaSaldo, untIFatEntregaFutura,
  untTFatEntregaFutura;

{ TfrmMostraEstruturas }

procedure pMostraEstrutura(strCodIte: String; strCodEmp: String=''; blnExiSal: Boolean=False;
    blnPedCor: Boolean=False; blnExiCus: Boolean=True; blnVisCod: Boolean=True);
begin
  pCriarFormularios(TfrmMostraEstruturas, frmMostraEstruturas);
  Try
    frmMostraEstruturas.FstrCodIte := strCodIte;
    frmMostraEstruturas.FstrCodEmp := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
    frmMostraEstruturas.FblnExiSal := blnExiSal;
    frmMostraEstruturas.FblnExiCus := blnExiCus;
    frmMostraEstruturas.FblnPedCor := blnPedCor;
    frmMostraEstruturas.FblnVisCod := blnVisCod;
    frmMostraEstruturas.ShowModal;
  Finally
    pFreeAndNil(frmMostraEstruturas);
  End;
end;

procedure TfrmMostraEstruturas.btnSimilaresClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(63, 5036, [],
                        ['CODSIM','CODEMP'],
                        [dtsItens.DataSet.FieldByName('CODSIN').AsString,''],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmMostraEstruturas.dtsItensDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  btnSimilares.Enabled := Assigned(dtsItens.DataSet) And (Not fEmptyStr(dtsItens.DataSet.FieldByName('CODSIN').AsString));
end;

function TfrmMostraEstruturas.fCriaEstruturaCds: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODPAI';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODSIN';
    DataType := ftString;
    Size := fRetornaTamanhoCampoTabela('CADITE', 'ITE_CODSIM');
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFAB';
    DataType := ftString;
    Size := 13;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SIMILI';
    DataType := ftString;
    Size := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PRECUS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTCUS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CUSUTI';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CUSREA';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTCUR';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALITE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALDIS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODMAR';
    DataType := ftString;
    Size := 6;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESMAR';
    DataType := ftString;
    Size := 15;
  End;

  Result.CreateDataSet;

  TFloatField(Result.FieldByName('QTDITE')).DisplayFormat := '#,##'+strMskQtd;
  TFloatField(Result.FieldByName('PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('TOTCUS')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('CUSUTI')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('CUSREA')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('TOTCUR')).DisplayFormat := '#,##0.00';
  TFloatField(Result.FieldByName('SALITE')).DisplayFormat := '#,##'+strMskQtd;
  TFloatField(Result.FieldByName('SALDIS')).DisplayFormat := '#,##'+strMskQtd;

  Result.Open;

  pSetaClient(Result);
end;

function TfrmMostraEstruturas.fGetDetMat(strCodEmp: String): String;
var
  blnCusRea: Boolean;
  strPrecoCusto: String;
begin
  blnCusRea:= fCfgSis('PBCUES', varString) = 'REA';
  strPrecoCusto := fGetPrecoCusto;

  Result := '';
  Result := Result + ' SELECT C.ITE_CODITE,                               ';
  Result := Result + '        ITE_DESITE,                                 ';
  Result := Result + '        ITE_CODFAB,                                 ';
  Result := Result + '        DMT_QTDITE,                                 ';
  Result := Result + '        ITE_CODSIM,                                 ';
  Result := Result + '        ITE_PRECUS,                                 ';
  Result := Result + '        ITE_ICMSAI,                                 ';
  Result := Result + '        ITE_IMPFED,                                 ';
  Result := Result + '        ITE_IMPULT,                                 ';
  Result := Result + '        ITE_PREVE1,                                 ';
  Result := Result + '        ITE_PREVE2,                                 ';
  Result := Result + '        ITE_PREVE3,                                 ';
  Result := Result + '        ITE_PREVE4,                                 ';
  Result := Result + '        ITE_PREVE5,                                 ';
  Result := Result + '        ITE_PREVE6,                                 ';
  Result := Result + '        ITE_PREVE7,                                 ';
  Result := Result + '        ITE_PREMED,                                 ';
  Result := Result + '        GMT_TIPQTD,                                 ';

  If blnCusRea Then
  Begin
    Result := Result + '@IMPFED := IF(PDISIF.SIS_VALCFG = "S" AND ICMDEB.SIS_VALCFG = "S", ';
    Result := Result + ' (ITE_IMPFED * (1 - (ITE_ICMSAI/100))), ITE_IMPFED) AS IMPFED, ';
    Result := Result + '@VAL1:= (1-(ITE_ICMSAI + @IMPFED  + ITE_DESOPE) /100) AS TEMP_1, ';
    Result := Result + '@VAL2:= (ITE_PRECUS + ITE_OUTVAL) AS TEMP_2, ';
    Result := Result + '@CUSREA:= ROUND(CAST((@VAL2/@VAL1) AS DECIMAL(12,4)), 3) AS ITE_CUSREA_TEMP, ';
  End;

  If fCfgSis('DENMAS', varBoolean) Then
    Result := Result +
      ' (IF(IFNULL(ITE_DENSID, 1) <= 0, 1, IFNULL(ITE_DENSID, 1)) * IF(GMT_TIPQTD = "P", DMT_QTDITE/100, DMT_QTDITE)) * IFNULL('
      + IIF(blnCusRea, '@CUSREA', strPrecoCusto) + ',0) AS CUSUTI,'
  Else
    Result := Result + ' IF(GMT_TIPQTD = "P", DMT_QTDITE/100, DMT_QTDITE) * IFNULL(' + IIF(blnCusRea, '@CUSREA', strPrecoCusto)
      + ',0) AS CUSUTI,';

  Result := Result + '        ITE_DESOPE,                                 ';
  Result := Result + '        ITE_OUTVAL,                                 ';
  Result := Result + '        ITE_CODMAR,                                 ';
  Result := Result + '        M.MAR_DESMAR,                               ';
  Result := Result + '        G.ITE_CODEMP,                               ';
  Result := Result + '        ITE_SALDOS + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0) + ' +  IIf(fUsaQtdPendenteEntregaFutura, fGetSQLSomaCamposEntregaFutura('G'), '0') + ' AS SALITE, ';

  Result := Result + '      ' + fSQLSaldoDisponivel('G', True, False, True) + ' AS  SALDIS, ';

  Result := Result + '        IF(IFNULL(C.ITE_CNV_ML, 0) <= 0, 1, C.ITE_CNV_ML) AS CNV_ML,';
  Result := Result + '        IFNULL(G.ITE_SAL_ML, 0) AS SAL_ML           ';
  Result := Result + ' FROM DETMAT                                        ';
  Result := Result + '   INNER JOIN CADITE C ON C.ITE_CODITE = DMT_ITESUB ';
  Result := Result + '   INNER JOIN GERMAT GM ON GM.AUTOINCREM = DMT_SEQGER ';
  Result := Result + '   INNER JOIN ITEGER G ON G.ITE_CODITE = DMT_ITESUB ';
  Result := Result + '                      AND G.ITE_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + '   INNER JOIN CADMAR M ON C.ITE_CODMAR = M.MAR_CODMAR ';
  Result := Result + '  INNER JOIN CFGSIS PDISIF ON PDISIF.SIS_CODCFG = "CFG_PDISIF" AND PDISIF.SIS_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  INNER JOIN CFGSIS ICMDEB ON ICMDEB.SIS_CODCFG = "CFG_ICMDEB" AND ICMDEB.SIS_CODEMP = G.ITE_CODEMP ';

  Result := Result + ' WHERE DMT_SEQGER = :SEQGER                         ';
end;

procedure TfrmMostraEstruturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);
  If Assigned(qryGerMat) Then
    FreeAndNil(qryGerMat);
  If Assigned(qryDetMat) Then
    FreeAndNil(qryDetMat);

  inherited;
end;

procedure TfrmMostraEstruturas.FormCreate(Sender: TObject);
begin
  inherited;
  strMskQtd := '0.'+ StringOfChar('0', fCfgSis('DECQTD'));
  pSetaCodIte(edtCodIte);
end;

procedure TfrmMostraEstruturas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F11) And btnSimilares.Enabled Then
    btnSimilares.Click;

  If Key = VK_Escape Then
    Self.Close;
end;

procedure TfrmMostraEstruturas.FormShow(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(FStrCodIte)) And (fEhOuCompoeEstrutura(FstrCodIte, FstrCodEmp).blnEstrutura) Then
  Begin
    pProcessaTreeView(FstrCodIte);
    edtCodIte.Text := FStrCodIte;

    edtCodIte.Visible:=FblnVisCod;
    lblCodIte.Visible:=FblnVisCod;

    pSetFocus(cxDBTreeEstru);
  End
  Else
    pSetFocus(edtCodIte);

  lblQtdEstrutura.Visible := FblnExiSal;
  lblTotEstrutura.Visible := FblnExiSal;

  pSetLegendaCusUti;
end;

function TfrmMostraEstruturas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      If (fEmptyStr(edtCodIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Preencha o código do item!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (fEmptyStr(fRetNomProduto(edtCodIte.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If Not fEhOuCompoeEstrutura(edtCodIte.Text, FstrCodEmp).blnEstrutura Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não pertence a nenhuma estrutura!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            pProcessaTreeView(edtCodIte.Text);
          End;
        End
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmMostraEstruturas.pProcessaTreeView(strCodIte : String);
Begin
  FstrCodIteProcessaTreeView := strCodIte;
  TfrmGravando.fExecutarModal(pProcessaTreeViewInterno, 'Aguarde...', '');
End;

procedure TfrmMostraEstruturas.pProcessaTreeViewInterno;
  Var
    fltTotPro,
    fltAuxilia: Double;
begin
  fltTotPro  := 0.00;

  If Not Assigned(cdsItens) Then
  Begin
    cdsItens := fCriaEstruturaCds;
    dtsItens.DataSet := cdsItens;
  End
  Else
  Begin
    cdsItens.EmptyDataSet;
    cxDBTreeEstru.FullCollapse;
  End;
  dtsItens.DataSet.DisableControls;
  Try

    If Not Assigned(qryGerMat) Then
      qryGerMat := fCriaQuery;
    If Not Assigned(qryDetMat) Then
      qryDetMat := fCriaQuery;

    qryGerMat.Close;
    qryGerMat.Sql.Clear;
    qryGerMat.Sql.Add(fGetSQLEstruturaPai(FstrCodEmp));
    qryGerMat.ParamByName('CODITE').AsString := FstrCodIteProcessaTreeView;
    qryGerMat.Open;

    qryDetMat.Close;
    qryDetMat.Sql.Clear;
    qryDetMat.Sql.Add(fGetDetMat(FstrCodEmp));
    qryDetMat.Open;

    QTDITE.Summary.FooterSummaryItems[0].Format := strMskQtd;
    QTDITE.Summary.GroupFooterSummaryItems[0].Format := strMskQtd;
    SALITE.Summary.FooterSummaryItems[0].Format := strMskQtd;
    SALITE.Summary.GroupFooterSummaryItems[0].Format := strMskQtd;
    SALDIS.Summary.FooterSummaryItems[0].Format := strMskQtd;
    SALDIS.Summary.GroupFooterSummaryItems[0].Format := strMskQtd;

    If (Not FblnExiCus) or (not fVerificaAcessoSistema('CUSSPR')) Then
    Begin
      With cxDBTreeEstru Do
      Begin
        PRECUS.Visible := False;
        TOTCUS.Visible := False;
        CUSUTI.Visible := False;
        CUSREA.Visible := False;
        TOTCUR.Visible := False;
      End;
    End;

    If Not FblnExiSal Then
    Begin
      With cxDBTreeEstru Do
      Begin
        SALITE.Visible := False;
        SALDIS.Visible := False;
      End;
    End;

    While Not qryGerMat.Eof Do
    Begin
      cdsItens.Append;
      cdsItens.FieldByName('CODITE').AsString := qryGerMat.FieldByName('ITE_CODITE').AsString;
      cdsItens.FieldByName('DESITE').AsString := qryGerMat.FieldByName('ITE_DESITE').AsString;
      cdsItens.FieldByName('CODSIN').AsString := qryGerMat.FieldByName('ITE_CODSIM').AsString;
      cdsItens.FieldByName('SIMILI').AsString := IIF(fEmptyStr(qryGerMat.FieldByName('ITE_CODSIM').AsString),'NÃO','SIM');
      cdsItens.FieldByName('CODFAB').AsString := qryGerMat.FieldByName('ITE_CODFAB').AsString;
      cdsItens.FieldByName('CODMAR').AsString := qryGerMat.FieldByName('ITE_CODMAR').AsString;
      cdsItens.FieldByName('DESMAR').AsString := qryGerMat.FieldByName('MAR_DESMAR').AsString;
      cdsItens.Post;

      qryDetMat.Close;
      qryDetMat.ParamByName('SEQGER').AsString := qryGerMat.FieldByName('AUTOINCREM').AsString;
      qryDetMat.Open;

      While Not qryDetMat.Eof Do
      Begin
        cdsItens.Append;
        cdsItens.FieldByName('CODPAI').AsString := qryGerMat.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('CODITE').AsString := qryDetMat.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('DESITE').AsString := qryDetMat.FieldByName('ITE_DESITE').AsString;
        cdsItens.FieldByName('CODSIN').AsString := qryDetMat.FieldByName('ITE_CODSIM').AsString;
        cdsItens.FieldByName('SIMILI').AsString := IIF(fEmptyStr(cdsItens.FieldByName('CODSIN').AsString),'NÃO','SIM');
        cdsItens.FieldByName('CODFAB').AsString := qryDetMat.FieldByName('ITE_CODFAB').AsString;
        cdsItens.FieldByName('CODMAR').AsString := qryDetMat.FieldByName('ITE_CODMAR').AsString;

        cdsItens.FieldByName('QTDITE').Value := qryDetMat.FieldByName('DMT_QTDITE').AsFloat;
        cdsItens.FieldByName('DESITE').Value := qryDetMat.FieldByName('ITE_DESITE').AsString;
        cdsItens.FieldByName('DESMAR').AsString := qryDetMat.FieldByName('MAR_DESMAR').AsString;

        If FblnExiCus Then
        Begin
          cdsItens.FieldByName('PRECUS').Value := qryDetMat.FieldByName('ITE_PRECUS').AsFloat;
          cdsItens.FieldByName('TOTCUS').Value := cdsItens.FieldByName('PRECUS').AsFloat * qryDetMat.FieldByName('DMT_QTDITE').AsFloat;
          cdsItens.FieldByName('CUSUTI').Value := qryDetMat.FieldByName('CUSUTI').AsFloat;
          cdsItens.FieldByName('CUSREA').Value := fCalculaCustoReal(qryDetMat.FieldByName('ITE_PRECUS').AsFloat,
                                                                    qryDetMat.FieldByName('ITE_ICMSAI').AsFloat,
                                                                    qryDetMat.FieldByName('ITE_IMPFED').AsFloat,
                                                                    qryDetMat.FieldByName('ITE_DESOPE').AsFloat,
                                                                    qryDetMat.FieldByName('ITE_OUTVAL').AsFloat);
          cdsItens.FieldByName('TOTCUR').Value := cdsItens.FieldByName('CUSREA').Value * qryDetMat.FieldByName('DMT_QTDITE').AsFloat;
        End;

        If FblnExiSal Then
        Begin
          cdsItens.FieldByName('SALITE').AsFloat := qryDetMat.FieldByName('SALITE').AsFloat;
          cdsItens.FieldByName('SALDIS').AsFloat := qryDetMat.FieldByName('SALDIS').AsFloat;
        End;


        //Calcula qual a menor quantidade disponivel, para saber o numero maximo de estrutura que se consegue montar com o estoque atual. req. 110127
        fltAuxilia := (cdsItens.FieldByName('SALDIS').AsFloat / cdsItens.FieldByName('QTDITE').AsFloat);

        If ((qryDetMat.RecNo = 1) or (fltAuxilia < fltTotPro)) Then
          fltTotPro  := Math.Max(fltAuxilia, 0);

        cdsItens.Post;

        qryDetMat.Next;
      End;

      qryGerMat.Next;
    End;

    lblTotEstrutura.Caption := FormatFloat('#,##0.00', fltTotPro);
  Finally
    dtsItens.DataSet.EnableControls;

  End;

    cxDBTreeEstru.FullExpand;
    cxDBTreeEstru.ApplyBestFit;
    cxDBTreeEstru.AdjustColumnsWidth;
end;

function TfrmMostraEstruturas.fGetPrecoCusto: String;
begin
  Result := fCfgSis('PBCUES', varString);
  If Result = 'IMP' Then
    Result := 'ITE_IMPULT'
  Else
  If Result = 'SIC' Then
    Result := 'ITE_MEDSIC'
  Else
  If Result = 'REA' Then
    Result := 'ITE_CUSREA'
  Else
    Result := 'ITE_PRE' + Result;
end;

procedure TfrmMostraEstruturas.pSetLegendaCusUti;
begin
  pnlLegendaCustoUti.Caption := '  Custo utilizado:';
  Case AnsiIndexStr(fCfgSis('PBCUES', varString), ['CUS','VE1','VE2','VE3','VE4','VE5','VE6','VE7','ULT','IMP','MED','REA','SIC']) Of
    0: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de custo';
    1: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 1';
    2: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 2';
    3: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 3';
    4: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 4';
    5: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 5';
    6: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 6';
    7: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de venda 7';
    8: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço da última compra';
    9: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço da última compra + impostos';
   10: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço médio';
   11: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço de custo real';
   12: pnlLegendaCustoUti.Caption := pnlLegendaCustoUti.Caption + 'Preço médio sem ICMS';
  End;
end;

end.

