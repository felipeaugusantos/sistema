unit untRelFiscCreIcmVendInterest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport, StrUtils,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, DB,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, BitBtnLockedIncrem, Buttons, Mask, MaskEditFocus, untExcel, Uni,
  untGeraExcel, untIZClient, untConstantes, ComCtrls, frxExportCSVTestabilidade,
  untTypesSistema, UniClientDataSet, UniDataSetProvider,
  System.Generics.Collections;

type
  TfrmRelFiscCreIcmVendInterest = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl3: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblCodEmp: TLabel;              
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    pgbProgresso: TProgressBar;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    rdgOrdem: TRadioGroup;
    Shape1: TShape;
    frxReportJMod2: TfrxReport;
    chkEnviaConsumidorFinal: TCheckBox;
    frxReportJMod3: TfrxReport;
    chkNaoExibirCreditos: TCheckBox;
    frxReportJMod4: TfrxReport;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    strCodEmp,
    strAutoIncremCat17: String;
    fltQtdProdComprado: Double;
    stlAutIncSai,
    stlQtdItensUsada,
    stlQtdItensTotal,
    stlSeqGer,
    stlNumDoc,
    stlQtdTotal  : TStringList;
    arrCodEmp    : TConsultasArray;
    intModelo    : Integer;
    qryRelatorio : IZClient;
    cdsRelatorio : TUniClientDataSet;
    dtsRelatorio : TUniDataSetProvider;
    dicQtdUsadaProcesso : TDictionary<String, Double>;

    Function fSQLRelatorio: String;
    function fCarregaAutoIncrem: String;
    function fValidaSaldoProduto: Boolean;

    Procedure pAbreConsulta;
    Procedure pAbreRelatorio;
    Procedure pGeraExcel(qryDados: TDataset);

    procedure pMontaTitGru(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);

    procedure pLimpaDadosCreditoICM;
    procedure pRetQtdProdutoComprado(var qryAux: TUniQuery);
    procedure pRetQtdProdutoVendido(var qryAux: TUniQuery);

    procedure pCarregaValoresCreditoICM(qryAux: TUniQuery; var fltVlrUni, fltVlrTot, fltIva, fltAlq, fltVlrICM, fltVlcICM: Double; var strDocent, strFor: String);
    procedure pRegistraCreditoICM;
    procedure pAtualizaQtdTotalCat17;

  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmRelFiscCreIcmVendInterest: TfrmRelFiscCreIcmVendInterest;

implementation

uses untFuncoes, untFuncoesSimples, untFuncoesConsulta, untConsultas, untFuncoesRelatorios,
     untZClient;


const
  TODAS_AS_VENDAS = '1';
  SOMENTE_VENDAS_TRIBUTADAS = '2';

  COMPRA_LIQUIDA_X_ALQ_INTERNA_ST = '1';
  ICMS_CALCULADO_VENDA = '2';

{$R *.dfm}

Procedure TfrmRelFiscCreIcmVendInterest.pAbreConsulta;
  Var
    qryDadEnt: TUniQuery;
    strDocent, strFor: String;
    fltVlrUni, fltVlrTot, fltIva, fltAlq, fltVlrICM, fltVlcICM: Double;
Begin
  cdsRelatorio.Close;
  cdsRelatorio.Filter := '';
  cdsRelatorio.Filtered := False;

  Try
    With qryRelatorio.qryQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSQLRelatorio);

      pSetaParam(edtCodEmp.Text, arrCodEmp, strCodEmp, 'CODEMP', qryRelatorio.qryQuery);
      pSetaParamPeriodo(mskDtaIni, mskDtaFin, qryRelatorio.qryQuery);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
    End;

    qryRelatorio.fAbreClient(True, 'pAbreConsulta');

    pSetaClient(qryRelatorio.qryQuery);

    dtsRelatorio.DataSet := qryRelatorio.qryQuery;
    cdsRelatorio.SetProvider(dtsRelatorio);
    cdsRelatorio.Open;

    If intModelo = 2 Then
    Begin
      {*************************************}
      {* PREENCHE DADOS DA ULTIMA ENTRADA  *}
      {**********************************GB*}
      Try
        qryDadEnt := fCriaQuery(Self);
        With qryDadEnt, Sql Do
        Begin
          Add(' SELECT DET_CODITE AS CODITE_E, ');
          Add('        DET_CODEMP AS CODEMP_E, ');
          Add('        DET_NUMDOC AS NUMDOC_E, ');
          Add('        DET_QTDITE AS QTDITE_E, ');
          Add('        CAT_QITEUS AS QITEUS_E, ');
          Add('        MOVDET.AUTOINCREM AS AUTOINCREM_E, ');
          Add('        DET_DTAENT AS DTAENT_E, ');
          Add('        DET_HORENT AS HORENT_E, ');
          Add('        ROUND( ( DET_TOTITE - DET_DESESP ) / DET_QTDITE, 2 ) AS VLRUNI_E, ');
          Add('        (DET_TOTITE - DET_DESESP) AS VLRTOT_E, ');
          Add('        IFNULL(ABF_IVAV_E,0) AS IVA_E, ');
          Add('        IFNULL(ABF_ALQ__E,0) AS ALQ_E, ');
          Add('        ((((DET_TOTITE - DET_DESESP) * IFNULL(ABF_IVAV_E,0) ) * IFNULL(ABF_ALQ__E,0) ) / 100) AS VLRICM_E, ');
          Add('        CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",IFNULL(DET_SERIE_, ""), "-", DET_CODEMP) AS DOCENT_E, ');
          Add('        CONCAT(FOR_CODFOR," - ", FOR_NOMFOR ) AS FORNEC_E ');
          Add(' FROM MOVDET ');
          Add('   INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ');
          Add('   LEFT  JOIN CADFOR ON FOR_CODFOR = DET_CODFOR ');
          Add('   LEFT  JOIN CADCID ON CID_CODCID = FOR_CODCID ');
          Add('   LEFT  JOIN CADABF ON ABF_CODABF = ITE_CODABF AND ABF_ESTADO = CID_ESTADO ');
          Add('   LEFT  JOIN CAT_17 CAT ON CAT.AUTOINCREM = MOVDET.AUTOINCREM ');
          Add(' WHERE (LEFT(DET_CLAFIS,1) < 5) ');
          Add('   AND (LEFT(DET_CLAFIS,1) <> 3) ');
          Add('   AND IF(MOVDET.AUTOINCREM = CAT.AUTOINCREM AND CAT_QTDTOT = "S", FALSE, TRUE) ');
          Add('   AND DET_TIP_FC = "F" ');
          Add('   AND IFNULL(FOR_SIMPAU,"N") <> "S" ');
          Add('   AND ADDTIME(DET_DTAENT, DET_HORENT) < ADDTIME(CAST(:DTAENT AS DATETIME), :HORENT) ');
          Add('   AND DET_CODITE = :CODITE ');
          Add('   AND DET_CODEMP = :CODEMP ');
          Add(' ORDER BY DTAENT_E DESC ');

          cdsRelatorio.First;

          pgbProgresso.Max      := cdsRelatorio.RecordCount;
          pgbProgresso.Position := 0;
          pgbProgresso.Visible  := True;

          strAutoIncremCat17 := fCarregaAutoIncrem;

          While Not cdsRelatorio.Eof Do
          Begin
            strFor := '';
            strDocent := '';
            fltIva := 0;
            fltAlq := 0;
            fltVlcICM := 0;
            fltVlrUni := 0;
            fltVlrTot := 0;
            fltVlrICM := 0;

            Close;
            ParamByName('CODITE').AsString := cdsRelatorio.FieldByName('CODITE').AsString;
            ParamByName('CODEMP').AsString := cdsRelatorio.FieldByName('CODEMP').AsString;
            ParamByName('DTAENT').AsDate   := cdsRelatorio.FieldByName('DTAENT').AsDateTime;
            ParamByName('HORENT').AsTime   := cdsRelatorio.FieldByName('HORENT').AsDateTime;
            Open;

            stlAutIncSai.Add(cdsRelatorio.FieldByName('AUTOINCREM').AsString);

            If fValidaSaldoProduto Then
              pCarregaValoresCreditoICM(qryDadEnt, fltVlrUni, fltVlrTot, fltIva, fltAlq, fltVlrICM, fltVlcICM, strDocent, strFor);

            cdsRelatorio.Edit;
            cdsRelatorio.FieldByName('VLRUNI_E').AsFloat  := fltVlrUni;
            cdsRelatorio.FieldByName('VLRTOT_E').AsFloat  := fltVlrTot;
            cdsRelatorio.FieldByName('IVA_E').AsFloat     := fltIva;
            cdsRelatorio.FieldByName('ALQ_E').AsFloat     := fltAlq;
            cdsRelatorio.FieldByName('VLRICM_E').AsFloat  := fltVlrICM;
            cdsRelatorio.FieldByName('DOCENT_E').AsString := strDocent;
            cdsRelatorio.FieldByName('FORNEC_E').AsString := strFor;
            cdsRelatorio.FieldByName('VLCREC').AsFloat    := (fltVlrUni * cdsRelatorio.FieldByName('QTDITE').AsFloat) *
                                                             (cdsRelatorio.FieldByName('ALQ_R').AsFloat / 100);
            cdsRelatorio.FieldByName('VLR_CRED_ICMS').AsFloat := fFormataFloat(fltVlcICM, 2);
            cdsRelatorio.Post;

            cdsRelatorio.Next;
            pgbProgresso.StepBy(1);

            Application.ProcessMessages;
          End;
        End;

        cdsRelatorio.Filter := 'VLRUNI_E > 0';
        cdsRelatorio.Filtered := True;

      Finally
        FreeAndNil(qryDadEnt);
        pgbProgresso.Visible := False;
      End;
    End;

    frxRelatorio.DataSet := cdsRelatorio;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

End;

Function TfrmRelFiscCreIcmVendInterest.fSQLRelatorio: String;
 Const
   STR_TOTVEN = 'IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF), D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))';
 Var
    strSQL: String;

Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   D.AUTOINCREM,     ';
  strSQL := strSQL + '   DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   G.ITE_DTABAL AS DTABAL, ';
  strSQL := strSQL + '   DET_HORENT AS HORENT, ';
  strSQL := strSQL + '   DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '   DET_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '   DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '   CONCAT(DET_NUMDOC,"-", DET_ESPDOC,"-", IFNULL(DET_SERIE_,"") ,"-", DET_CODEMP) AS DOCUME, ';
  strSQL := strSQL + '   DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   DET_CODCLI AS CODCLI, ';
  strSQL := strSQL + '   CONCAT(DET_CODCLI,"-", CLI_NOMCLI) AS CLIENTE, ';
  strSQL := strSQL + '   DET_ESTADO AS ESTADO, ';
  strSQL := strSQL + '   DET_CODITE AS CODITE, ';
  strSQL := strSQL + '   DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '   DET_CLAFIS AS CLAFIS, ';
  strSQL := strSQL + '   DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '   DET_BASICM AS BASE_ICMS, ';
  strSQL := strSQL + '   DET_ALQICM AS ALIQUOTA_ICMS, ';
  strSQL := strSQL + '   DET_VALICM AS VALOR_ICMS, ';
  strSQL := strSQL + '   ITE_CLAIPI AS NCM, ';

  strSQL := strSQL + STR_TOTVEN + ' / DET_QTDITE AS UNITAR, ';

  strSQL := strSQL + STR_TOTVEN + ' AS TOTVEN, ';

  If fCfgSis('CAT17C') = COMPRA_LIQUIDA_X_ALQ_INTERNA_ST Then
  Begin
    strSQL := strSQL + '   IF(DET_QTDITE = 0, 0, ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(MOVTRI.DET_COMLIQ), MOVTRI.DET_COMLIQ)) / DET_QTDITE)) AS UNI_CRED_ICMS, ';
    strSQL := strSQL + '   IF(LEFT(D.DET_CLAFIS,1) < 5, -(MOVTRI.DET_COMLIQ), MOVTRI.DET_COMLIQ)  AS BAS_CRED_ICMS, ';

    strSQL := strSQL + '   A.ABF_ALQRET_ENT_PEJ AS ALQ_CRED_ICMS, ';
    strSQL := strSQL + '   ROUND((IF(DET_QTDITE = 0, 0, ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(MOVTRI.DET_COMLIQ), MOVTRI.DET_COMLIQ)) * A.ABF_ALQRET_ENT_PEJ))) / 100, 2) AS VLR_CRED_ICMS, ';
    strSQL := strSQL + '   ROUND(((((IF(LEFT(D.DET_CLAFIS,1) < 5, -(MOVTRI.DET_COMLIQ), MOVTRI.DET_COMLIQ) * A.ABF_IVA_ST_ENT_PEJ) ';
    strSQL := strSQL + '   ) * A.ABF_ALQRET_ENT_PEJ) / 100) - ROUND((IF(DET_QTDITE = 0, 0, ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(MOVTRI.DET_COMLIQ), MOVTRI.DET_COMLIQ)) * A.ABF_ALQRET_ENT_PEJ))) / 100, 2), 2) AS VLR_CRED_ICMS_ST, ';
  End
  Else//ICMS_CALCULADO_VENDA
  Begin
    strSQL := strSQL + '   0.00 AS UNI_CRED_ICMS, ';
    strSQL := strSQL + '   IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_BASICM), D.DET_BASICM)  AS BAS_CRED_ICMS, ';

    strSQL := strSQL + '   D.DET_ALQICM AS ALQ_CRED_ICMS, ';
    strSQL := strSQL + '   ROUND(IF(DET_QTDITE = 0, 0, ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_VALICM), D.DET_VALICM)))), 2) AS VLR_CRED_ICMS, ';
    strSQL := strSQL + '   ROUND(IF(DET_QTDITE = 0, 0, ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_VALRET), D.DET_VALRET)))), 2) AS VLR_CRED_ICMS_ST, ';
  End;

  strSQL := strSQL + '   0.00 AS VLRUNI_E, ';
  strSQL := strSQL + '   0.00 AS VLRTOT_E, ';
  strSQL := strSQL + '   0.00 AS IVA_E, ';
  strSQL := strSQL + '   0.00 AS ALQ_E, ';
  strSQL := strSQL + '   0.00 AS VLRICM_E, ';
  strSQL := strSQL + '   "                               " AS DOCENT_E, ';
  strSQL := strSQL + '   "                                                                                 " AS FORNEC_E, ';

  strSQL := strSQL + '  G.ITE_SUBSTI AS ALQ_R, ';
  strSQL := strSQL + '  0.00 VLCREC ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET D ';
  strSQL := strSQL + ' JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + ' JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                  G.ITE_CODEMP = I.ITE_CODEMP     ';
  strSQL := strSQL + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL + ' INNER JOIN CADEMP E ON E.EMP_CODEMP = DET_CODEMP ';
  strSQL := strSQL + ' INNER JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
  strSQL := strSQL + ' INNER JOIN ABFICM A ON A.ABF_CODABF = I.ITE_CODABF AND ';
  strSQL := strSQL + '                        A.ABF_ESTADO = C.CID_ESTADO ';
  strSQL := strSQL + ' WHERE              ';
  strSQL := strSQL + '  (LOCATE(A.ABF_CODSIT_ENT_PEJ,"' + CST_SUBSTITUICAO + '") > 0)  AND';
  strSQL := strSQL + '  (DET_ESPDOC = "NF" OR DET_ESPDOC = "IF" OR DET_ESPDOC = "IV" OR DET_ESPDOC = "D1") AND ';
  strSQL := strSQL + '  (D.DET_ESTADO <> C.CID_ESTADO) AND ';

  If fCfgSis('CAT17F') = SOMENTE_VENDAS_TRIBUTADAS Then
    strSQL := strSQL + '  (LOCATE(D.DET_CODFIS,"' + CST_SUBSTITUICAO + '") <= 0)  AND';

  strSQL := strSQL + '   D.DET_PROEMB <> "S" AND ';

  If Not chkEnviaConsumidorFinal.Checked Then
    strSQL := strSQL + '   IFNULL(CLI_CONSUM, "N") = "N" AND ';

  strSQL := strSQL + '   D.DET_TIP_FC = "C"  AND ';
  strSQL := strSQL + '   D.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '   D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND ';
  strSQL := strSQL + '   ((LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0)';
  strSQL := strSQL + ' OR LOCATE(D.DET_CLAFIS,' + CLAFIS_BR + ')) ';
  strSQL := strSQL + fStrLocateEmpresa(edtCodEmp, arrCodEmp, 'D.DET_CODEMP', 'CODEMP');

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,
                                     ' - D.DET_DESCFF', ''), 'MOVTRI', 'NOTTRI'), 'MOVDET', 'NOTDET');
  strSQL := strSQL + ' ORDER BY ';
  Case rdgOrdem.ItemIndex Of
    0: strSQL := strSQL + ' CLAFIS, DTAENT, NUMDOC, DESCRI ';
    1: strSQL := strSQL + ' CLAFIS, NUMDOC, DTAENT, DESCRI ';
  End;

  Result := strSQL;

End;

Procedure TfrmRelFiscCreIcmVendInterest.pAbreRelatorio;
  Var
    strNomImp: String;
    frxReport: TfrxReport;
Begin
  Try
    pCarregaConfImprRel(Self.Name, strNomImp, strTipImp);

    If edtDestino.Text = 'E' Then
      pGeraExcel(cdsRelatorio)
    Else
    Begin
      If intModelo = 2 Then
      Begin
        If strTipImp = 'M' Then
        Begin
          {**********************************}
          {* DEVIDO A INSERÇÃO DE MUITAS    *}
          {* COLUNAS E REL. LASER EM RETRATO*}
          {* RONALDO PEDIU PARA DESABILITAR *}
          {* O MATRICIAL, NGM ESTA USANDO   *}
          {*******************************MM*}
          pMensagemOk('Relatório não disponível para impressão matricial, utilize o Laser!');
          Exit;
        End Else
        Begin
          frxReport := frxReportJMod2;
          TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            frxReport.Script.Variables['PERIODO'] := 'REFERENTE AO PERÍODO DE ' + DateToStr(StrToDate(mskDtaIni.Text)) + ' A ' +DateToStr(StrToDate( mskDtaFin.Text))
          Else
            frxReport.Script.Variables['PERIODO'] := 'PERÍODO: TODOS';
        End;
      End
      Else
      Begin
        If strTipImp = 'M' Then
        Begin
          frxReport := frxReportM;
          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            frxReport.Script.Variables['PERIODO'] := 'REFERENTE AO PERIODO DE ' + DateToStr(StrToDate(mskDtaIni.Text)) + ' A ' +DateToStr(StrToDate( mskDtaFin.Text))
          Else
            frxReport.Script.Variables['PERIODO'] := 'PERIODO: TODOS';
        End
        Else
        Begin
          If intModelo = 3 Then
            frxReport := frxReportJMod3
          Else
          begin
            if chkNaoExibirCreditos.Checked then
              frxReport := frxReportJMod4
            else
              frxReport := frxReportJ;
          end;

          TfrxMemoView(frxReport.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          frxReport.Script.Variables['PERIODO'] := 'REFERENTE AO PERÍODO DE ' + DateToStr(StrToDate(mskDtaIni.Text)) + ' A ' +DateToStr(StrToDate( mskDtaFin.Text))
        Else
          frxReport.Script.Variables['PERIODO'] := 'PERÍODO: TODOS';
        End;
      End;

      With frxReport, Script Do
      Begin
        PrintOptions.PrintMode := pmScale;

        PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

        If strTipImp = 'M' Then
          Variables['NOMREL']  := 'CREDITO DE ICMS SOBRE VENDAS INTERESTADUAIS - CAT 17'
        Else
          Variables['NOMREL']  := 'CRÉDITO DE ICMS SOBRE VENDAS INTERESTADUAIS - CAT 17';

        Variables['EMPRES']  := fStrTitulo(edtCodEmp.Text,   edtNomEmp, arrCodEmp, strCodEmp, 'EMPRESA');

        If fCfgSis('CAT17C') = ICMS_CALCULADO_VENDA Then
        Begin
          TfrxMemoView(frxReport.FindObject('rllTit_UNI_CRED_ICM')).Visible := False;
          TfrxMemoView(frxReport.FindObject('rllCam_UNI_CRED_ICM')).Visible := False;
          TfrxMemoView(frxReport.FindObject('rllTit_BAS_CRED_ICM')).Text    := 'BASE ICMS';
          TfrxMemoView(frxReport.FindObject('rllTit_ALQ_CRED_ICM')).Text    := 'ALQ. ICMS';
        End;

        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxReport)
        Else
          If PrepareReport Then
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);

        If intModelo = 2 Then
        Begin
          If fMensagem('ATENÇÃO', 'Confirma a utilização dos créditos do relatório anterior? Esta operação é irreversível.',
            ['&Sim', '&Não'], 2) = 1 Then
          Begin
            pnlInfo.Caption := 'Aguarde, gravando utilização de créditos...';
            Application.ProcessMessages;
            pRegistraCreditoICM;
          End;
          pLimpaDadosCreditoICM;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

End;

procedure TfrmRelFiscCreIcmVendInterest.pAtualizaQtdTotalCat17;
  Var
    qrySelect, qryUpdate: TUniQuery;
begin
  qrySelect := fCriaQuery(Nil);
  qryUpdate := fCriaQuery(Nil);
  Try
    qrySelect.SQL.Add('SELECT ');
    qrySelect.SQL.Add('  AUTOINCREM ');
    qrySelect.SQL.Add('FROM ');
    qrySelect.SQL.Add('  CAT_17 ');
    qrySelect.SQL.Add('WHERE CAT_QITEUS = CAT_QITETO ');
    qrySelect.SQL.Add('  AND CAT_QTDTOT = "N" ');
    qrySelect.Open;

    If Not (qrySelect.IsEmpty) Then
    Begin
      qrySelect.First;

      qryUpdate.SQL.Add('UPDATE ');
      qryUpdate.SQL.Add('  CAT_17');
      qryUpdate.SQL.Add('SET CAT_QTDTOT = "S" ');
      qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');

      While Not (qrySelect.Eof) Do
      Begin
        qryUpdate.ParamByName('AUTOINCREM').AsString := qrySelect.FieldByName('AUTOINCREM').AsString;
        qryUpdate.ExecSQL;
        qrySelect.Next;
      End;
    End;
  Finally
    qrySelect.Free;
    qryUpdate.Free;
  End;
end;

procedure TfrmRelFiscCreIcmVendInterest.pCarregaValoresCreditoICM(
  qryAux: TUniQuery; var fltVlrUni, fltVlrTot, fltIva, fltAlq, fltVlrICM,
  fltVlcICM: Double; var strDocent, strFor: String);
  Var
    fltQtdTot,
    fltQtdUsa,
    fltQuantidadeVenda: Double;
    blnUsaNota: Boolean;
    fltQuantidadeDisponivelCompra: Double;
begin
  fltQuantidadeVenda := cdsRelatorio.FieldByName('QTDITE').AsFloat;

  While Not qryAux.Eof Do
  Begin
    blnUsaNota := False;

    If dicQtdUsadaProcesso.ContainsKey(qryAux.FieldByName('AUTOINCREM_E').AsString) Then
      fltQtdUsa := dicQtdUsadaProcesso[qryAux.FieldByName('AUTOINCREM_E').AsString]
    Else
      fltQtdUsa := 0.00;

    fltQuantidadeDisponivelCompra := qryAux.FieldByName('QTDITE_E').AsFloat -
                                     qryAux.FieldByName('QITEUS_E').AsFloat - fltQtdUsa;

    If fltQuantidadeDisponivelCompra > 0 Then
    Begin
      If fltQuantidadeVenda <= fltQuantidadeDisponivelCompra Then
      Begin
        blnUsaNota := True;
        fltQtdTot  := fltQtdUsa + fltQuantidadeVenda;
        dicQtdUsadaProcesso.AddOrSetValue(qryAux.FieldByName('AUTOINCREM_E').AsString, fltQtdTot);

        stlQtdItensUsada.Add(FloatToStr(fltQuantidadeVenda));
        stlQtdItensTotal.Add(qryAux.FieldByName('QTDITE_E').AsString);
        stlSeqGer.Add(qryAux.FieldByName('AUTOINCREM_E').AsString);
        stlNumDoc.Add(qryAux.FieldByName('NUMDOC_E').AsString);
        stlQtdTotal.Add(IfThen(fltQuantidadeVenda < fltQuantidadeDisponivelCompra, 'N', 'S'));
      End
      Else
      Begin
        fltQtdTot  := fltQtdUsa + fltQuantidadeDisponivelCompra;
        dicQtdUsadaProcesso.AddOrSetValue(qryAux.FieldByName('AUTOINCREM_E').AsString, fltQtdTot);
        fltQuantidadeVenda := fltQuantidadeVenda - fltQuantidadeDisponivelCompra;

        stlQtdItensUsada.Add(FloatToStr(fltQuantidadeDisponivelCompra));
        stlQtdItensTotal.Add(qryAux.FieldByName('QTDITE_E').AsString);
        stlSeqGer.Add(qryAux.FieldByName('AUTOINCREM_E').AsString);
        stlNumDoc.Add(qryAux.FieldByName('NUMDOC_E').AsString);
        stlQtdTotal.Add('S');
      End;
    End;

    If blnUsaNota Then
    Begin
      fltVlrUni := qryAux.FieldByName('VLRUNI_E').AsFloat;
      fltVlrTot := qryAux.FieldByName('VLRTOT_E').AsFloat;
      fltIva    := qryAux.FieldByName('IVA_E').AsFloat;
      fltAlq    := qryAux.FieldByName('ALQ_E').AsFloat;
      fltVlrICM := qryAux.FieldByName('VLRICM_E').AsFloat;
      strDocent := qryAux.FieldByName('DOCENT_E').AsString;
      strFor    := qryAux.FieldByName('FORNEC_E').AsString;
      fltVlcICM := (cdsRelatorio.FieldByName('QTDITE').AsFloat * qryAux.FieldByName('VLRUNI_E').AsFloat) *
                   (qryAux.FieldByName('ALQ_E').AsFloat / 100);
      Break;
    End;

    qryAux.Next;
  End;

end;

function TfrmRelFiscCreIcmVendInterest.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************CI*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
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
        mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));
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
            End
            Else mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
          End;
        End
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      pDesmarcaLista(edtCodEmp,arrCodEmp);
    End

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E!', ['&Ok']);
        Result := False;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelFiscCreIcmVendInterest.fValidaSaldoProduto: Boolean;
  Var
    qryCompra, qryVenda: TUniQuery;
begin
  Result := False;

  qryCompra := fCriaQuery(Nil);
  qryVenda := fCriaQuery(Nil);
  Try
    pRetQtdProdutoComprado(qryCompra);
    pRetQtdProdutoVendido(qryVenda);

    Try
      qryCompra.Open;
      qryVenda.Open;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Erro ao abrir tabela ' + E.Message, '', '');
      End;
    End;

    If qryCompra.FieldByName('QTDE_COMPRADA').AsFloat > qryVenda.FieldByName('QTDE_VENDIDA').AsFloat Then
    Begin
      fltQtdProdComprado := qryCompra.FieldByName('QTDE_COMPRADA').AsFloat;
      Result := True;
    End;
  Finally
    FreeAndNil(qryCompra);
    FreeAndNil(qryVenda);
  End;

end;

procedure TfrmRelFiscCreIcmVendInterest.pGeraExcel(qryDados: TDataset);
  Var
    objGeraExcel: TGeraExcel;
begin

  Try

    objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);

    With objGeraExcel Do
    Begin

      strNomRel := 'CRÉDITO DE ICMS SOBRE VENDAS INTERESTADUAIS - CAT 17';   
      AddFiltro(fStrTituloPeriodo(mskDtaIni, mskDtaFin));
      AddFiltro(fStrTitulo(edtCodEmp.Text, edtNomEmp, arrCodEmp, strCodEmp, 'EMPRESA'));

      If intModelo = 1 Then
      Begin
        AddCampo('CODITE', 'COD.ITEM');
        AddCampo('DESCRI', 'DESCRIÇÃO');
        AddCampo('QTDITE', 'QUANT.');
        AddCampo('UNITAR', 'VR.UNIT.VENDA');
        AddCampo('TOTVEN', 'VR.TOT.VENDA');
        AddCampo('CLAFIS', 'CFOP');

        If fCfgSis('CAT17C') = COMPRA_LIQUIDA_X_ALQ_INTERNA_ST Then
        Begin
          AddCampo('UNI_CRED_ICMS', 'VR.UNIT.CUSTO');
          AddCampo('BAS_CRED_ICMS', 'VR.TOTAL CUSTO');
          AddCampo('ALQ_CRED_ICMS', 'ALQ.INTERNA');
          AddCampo('VLR_CRED_ICMS', 'VR.CRÉDITO ICMS');
        End
        Else
        Begin
          AddCampo('BAS_CRED_ICMS', 'BASE ICMS');
          AddCampo('ALQ_CRED_ICMS', 'ALQ. ICMS');
          AddCampo('VLR_CRED_ICMS', 'VR.CRÉDITO ICMS');
        End;
      End
      Else If intModelo = 2 Then
      Begin
        AddFiltro('');
        AddFiltro('VR.CRÉDITO = VR.UNIT.ENTRADA * QUANT.SAÍDA * ALÍQ.ENTRADA');
        AddFiltro('RESSARCIMENTO ST = VR.UNIT.ENTRADA * QTD.SAÍDA * ALQ.ST');

        AddCampo('CODITE', 'COD.ITEM');
        AddCampo('DESCRI', 'DESCRIÇÃO');
        AddCampo('QTDITE', 'QUANT.');
        AddCampo('UNITAR', 'VR.UNIT.VENDA');
        AddCampo('TOTVEN', 'VR.TOT.VENDA');

        If fCfgSis('CAT17C') = COMPRA_LIQUIDA_X_ALQ_INTERNA_ST Then
        Begin
          AddCampo('UNI_CRED_ICMS', 'VR.UNIT.CUSTO');
          AddCampo('BAS_CRED_ICMS', 'VR.TOTAL CUSTO');
          AddCampo('CLAFIS', 'CFOP');
          AddCampo('ALQ_CRED_ICMS', 'ALQ.INTERNA');
        End
        Else
        Begin
          AddCampo('BAS_CRED_ICMS', 'BASE ICMS');
          AddCampo('CLAFIS', 'CFOP');
          AddCampo('ALQ_CRED_ICMS', 'ALQ. ICMS');
        End;

        AddCampo('VLRUNI_E', 'VR. UNIT. ENTRADA');
        AddCampo('VLRTOT_E', 'VR. TOTAL ENTRADA');
        AddCampo('IVA_E', 'IVA ENTRADA');
        AddCampo('ALQ_E', 'ALÍQUOTA ENTRADA');
        AddCampo('VLRICM_E', 'VR. ICMS ENTRADA');
        AddCampo('VLR_CRED_ICMS', 'VR.CRÉDITO ICMS');
        AddCampo('DOCENT_E', 'DOCUMENTO DE ENTRADA');
        AddCampo('FORNEC_E', 'FORNECEDOR ENTRADA');

        AddCampo('ALQ_R' , 'ALQ.RESSARC.');
        AddCampo('VLCREC', 'VLR.RESSARC.');
      End
      Else If intModelo = 3 Then
      Begin
        AddCampo('CODITE', 'COD.ITEM');
        AddCampo('DESCRI', 'DESCRIÇÃO');
        AddCampo('QTDITE', 'QUANT.');
        AddCampo('UNITAR', 'VR.UNIT.VENDA');
        AddCampo('TOTVEN', 'VR.TOT.VENDA');
        AddCampo('CLAFIS', 'CFOP');

        If fCfgSis('CAT17C') = COMPRA_LIQUIDA_X_ALQ_INTERNA_ST Then
        Begin
          AddCampo('UNI_CRED_ICMS', 'VR.UNIT.CUSTO');
          AddCampo('BAS_CRED_ICMS', 'VR.TOTAL CUSTO');
          AddCampo('ALQ_CRED_ICMS', 'ALQ.INTERNA');
          AddCampo('VLR_CRED_ICMS', 'VR.CRÉDITO ICMS');
          AddCampo('VLR_CRED_ICMS_ST', 'VR.CRÉDITO ST');
        End
        Else
        Begin
          AddCampo('BAS_CRED_ICMS', 'BASE ICMS');
          AddCampo('ALQ_CRED_ICMS', 'ALQ. ICMS');
          AddCampo('VLR_CRED_ICMS', 'VR.CRÉDITO ICMS');
          AddCampo('VLR_CRED_ICMS_ST', 'VR.CRÉDITO ST');
        End;
      End;

      AddQuebra('NUMDOC', 'DOCUMENTO: ', False);
      OnImpTitGrupo := pMontaTitGru;

      AddTotais('TOTVEN');
      AddTotais('BAS_CRED_ICMS');
      AddTotais('VLR_CRED_ICMS');

      If intModelo = 3 Then
        AddTotais('VLR_CRED_ICMS_ST');

      If intModelo = 2 Then
      Begin
        AddTotais('VLCREC');
        AddTotais('VLRTOT_E');
        AddTotais('VLRICM_E');
      End;

      OnMontaResumo := pMontaResumo;
      OnSomaResumo  := pSomaTotais;

      If fGerarRelatorio Then
        fMensagem('','Arquivo gerado com sucesso!',['&OK']);

    End;
    FreeAndNil(objGeraExcel);

  Except
    On E: Exception Do
    Begin
      FreeAndNil(objGeraExcel);
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TfrmRelFiscCreIcmVendInterest.pLimpaDadosCreditoICM;
begin
  stlNumDoc.Clear;
  stlSeqGer.Clear;
  stlAutIncSai.Clear;
  stlQtdItensUsada.Clear;
  stlQtdItensTotal.Clear;
  stlQtdTotal.Clear;
  dicQtdUsadaProcesso.Clear;
end;

procedure TfrmRelFiscCreIcmVendInterest.btnImprimirClick(Sender: TObject);
begin
  inherited;

  Try
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;

    If blnImprime Then
    Begin
      Try

        pAbreConsulta;

        If Not cdsRelatorio.IsEmpty Then
          pAbreRelatorio
        Else
          pTabelaVazia;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'[TRelFiscCreIcmVendInterest.btnImprimirClick]');
        End;
      End;

    End;

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
    pSetFocus(mskDtaIni);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
    
end;

procedure TfrmRelFiscCreIcmVendInterest.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp,edtNomEmp,arrCodEmp,fRetNomeEmpresa,nil,'da Empresa');
end;

procedure TfrmRelFiscCreIcmVendInterest.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************CI*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp,True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelFiscCreIcmVendInterest.fCarregaAutoIncrem: String;
  Var
    qryAux: TUniQuery;
    strAutoIncrem: String;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  AUTOINCREM ');
    qryAux.SQL.Add('FROM');
    qryAux.SQL.Add('  CAT_17');
    qryAux.Open;

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      strAutoIncrem := strAutoIncrem + qryAux.FieldByName('AUTOINCREM').AsString + '_';
      qryAux.Next;
    End;

    Result := strAutoIncrem;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmRelFiscCreIcmVendInterest.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFiscCreIcmVendInterest.FormCreate(Sender: TObject);
begin
  inherited;
  blnExcel := True;
  qryRelatorio := untZClient.TZClient.Create(Self);
  frxRelatorio.DataSet := QryRelatorio.qryQuery;
  intModelo := fCfgSis('C17MOD', varInteger);

  dicQtdUsadaProcesso := TDictionary<String, Double>.Create;

  cdsRelatorio := TUniClientDataSet.Create(Self);
  cdsRelatorio.AggregatesActive := True;
  dtsRelatorio := TUniDataSetProvider.Create(Self);

  stlAutIncSai     := TStringList.Create;
  stlQtdItensUsada := TStringList.Create;
  stlQtdItensTotal := TStringList.Create;
  stlSeqGer        := TStringList.Create;
  stlNumDoc        := TStringList.Create;
  stlQtdTotal      := TStringList.Create;
end;

procedure TfrmRelFiscCreIcmVendInterest.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsRelatorio);
  FreeAndNil(dtsRelatorio);
  FreeAndNil(stlAutIncSai);
  FreeAndNil(stlQtdItensUsada);
  FreeAndNil(stlQtdItensTotal);
  FreeAndNil(stlSeqGer);
  FreeAndNil(stlNumDoc);
  FreeAndNil(stlQtdTotal);
  FreeAndNil(dicQtdUsadaProcesso);
end;

procedure TfrmRelFiscCreIcmVendInterest.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN : If (ActiveControl Is TRadioButton) Then
                  SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFiscCreIcmVendInterest.pMontaTitGru(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
Begin
  Try
    With Excel, Dados Do
    Begin
      If Quebra.NomeCampo = 'NUMDOC' Then
      Begin
        Escrever(ProximaLinha, 01, 'DATA SAÍDA: '+ FieldByName('DTAENT').AsString  + '     ' +
                                   'DOCUMENTO: ' + FieldByName('DOCUME').AsString  + '     ' +
                                   'CLIENTE: '   + FieldByName('CLIENTE').AsString + '     ' +
                                   'UF: '        + FieldByName('ESTADO').AsString);

        Negrito (LinhaAtual   , 01, True);
        Mesclar ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual   ));
        CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
        CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
        Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True, True, False, False);

      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

End;

procedure TfrmRelFiscCreIcmVendInterest.pRegistraCreditoICM;
  Var
    qryAux: TUniQuery;
    intContador: Integer;
    strSeqGer: String;

    stlSeqGerAtualizado: TStringList;
begin
  qryAux := fCriaQuery(Nil);
  stlSeqGerAtualizado := TStringList.Create;
  Try
    For intContador := 0 to stlSeqGer.Count -1 do
    Begin
      strSeqGer := stlSeqGer[intContador];

      If stlSeqGerAtualizado.IndexOf(strSeqGer) < 0 Then
      Begin
        stlSeqGerAtualizado.Add(strSeqGer);

        qryAux.SQL.Clear;
        qryAux.Close;
        qryAux.SQL.Add('SELECT * FROM CAT_17 WHERE AUTOINCREM = :AUTOINCREM');
        qryAux.ParamByName('AUTOINCREM').AsString := strSeqGer;
        qryAux.Open;

        If qryAux.IsEmpty Then
        Begin
          qryAux.Append;
          qryAux.FieldByName('CAT_QITEUS').AsFloat := dicQtdUsadaProcesso[strSeqGer];
          qryAux.FieldByName('CAT_QITETO').AsString := stlQtdItensTotal[intContador];
          qryAux.FieldByName('CAT_NUMDOC').AsString := stlNumDoc[intContador];
          qryAux.FieldByName('CAT_QTDTOT').AsString := stlQtdTotal[intContador];
        End
        Else
        Begin
          qryAux.Edit;
          qryAux.FieldByName('CAT_QITEUS').AsFloat := qryAux.FieldByName('CAT_QITEUS').AsFloat + dicQtdUsadaProcesso[strSeqGer];
        End;
        qryAux.FieldByName('AUTOINCREM').AsString := strSeqGer;
        qryAux.FieldByName('CAT_ULTDTA').AsDateTime := StrToDate(mskDtaFin.Text);
        qryAux.Post;
      End;
    End;

    For intContador := 0 to stlAutIncSai.Count -1 do
    Begin
      qryAux.SQL.Clear;
      qryAux.Close;

      qryAux.SQL.Add('REPLACE INTO CAT_17( ');
      qryAux.SQL.Add('  AUTOINCREM, CAT_ULTDTA) ');
      qryAux.SQL.Add('VALUES ( ');
      qryAux.SQL.Add('  :AUTOINCREM, :DTAFIN) ');

      qryAux.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      qryAux.ParamByName('AUTOINCREM').AsString := stlAutIncSai[intContador];
      qryAux.ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
    pLimpaDadosCreditoICM;
  End;

   pAtualizaQtdTotalCat17;
end;

procedure TfrmRelFiscCreIcmVendInterest.pRetQtdProdutoComprado(
  var qryAux: TUniQuery);
  Var
    strSQL: String;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  (TAB.QTDADE_COMPRADA + TAB.SALDO_BALANCO) AS QTDE_COMPRADA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  (SELECT ';
  strSQL := strSQL + '    SUM(DET_QTDITE) AS QTDADE_COMPRADA, ';
  strSQL := strSQL + '    (SELECT ';
  strSQL := strSQL + '      ITE_SALBAL ';
  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      ITEGER ';
  strSQL := strSQL + '    WHERE ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '      AND ITE_CODEMP = DET_CODEMP) AS SALDO_BALANCO ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     MOVDET ';
  strSQL := strSQL + '     LEFT JOIN CADFOR ';
  strSQL := strSQL + '       ON FOR_CODFOR = DET_CODFOR ';
  strSQL := strSQL + '   WHERE DET_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '     AND :DTAFIM ';
  strSQL := strSQL + '     AND DET_TIP_FC = "F" ';
  strSQL := strSQL + '     AND DET_CODITE = :CODITE ';
  strSQL := strSQL + '     AND DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '     AND IFNULL(FOR_SIMPAU, "N") <> "S" ';
  strSQL := strSQL + '     AND (LEFT(DET_CLAFIS, 1) < 5) ';
  strSQL := strSQL + '     AND (LEFT(DET_CLAFIS, 1) <> 3) ';
  strSQL := strSQL + 'GROUP BY DET_CODITE) TAB ';

  qryAux.SQL.Text := strSQL;

  qryAux.ParamByName('DTAINI').AsDateTime := cdsRelatorio.FieldByName('DTABAL').AsDateTime;
  qryAux.ParamByName('DTAFIM').AsDateTime := (StrToDate(mskDtaIni.Text) - 1);
  qryAux.ParamByName('CODITE').AsString := cdsRelatorio.FieldByName('CODITE').AsString;
  qryAux.ParamByName('CODEMP').AsString := cdsRelatorio.FieldByName('CODEMP').AsString;
end;

procedure TfrmRelFiscCreIcmVendInterest.pRetQtdProdutoVendido(
  var qryAux: TUniQuery);
  Var
    strSQL: String;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(DET_QTDITE) AS QTDE_VENDIDA ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  LEFT JOIN CADFOR ';
  strSQL := strSQL + '    ON FOR_CODFOR = DET_CODFOR ';
  strSQL := strSQL + 'WHERE DET_DTAENT BETWEEN :DTAINI ';
  strSQL := strSQL + '  AND :DTAFIM ';
  strSQL := strSQL + '  AND DET_TIP_FC = "C" ';
  strSQL := strSQL + '  AND DET_CODITE = :CODITE ';
  strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND (LEFT(DET_CLAFIS, 1) >= 5) ';
  strSQL := strSQL + '  AND (LEFT(DET_CLAFIS, 1) <> 3) ';
  strSQL := strSQL + 'GROUP BY DET_CODITE ';

  qryAux.SQL.Text := strSQL;

  qryAux.ParamByName('DTAINI').AsDateTime := cdsRelatorio.FieldByName('DTABAL').AsDateTime;
  qryAux.ParamByName('DTAFIM').AsDateTime := (StrToDate(mskDtaIni.Text) - 1);
  qryAux.ParamByName('CODITE').AsString := cdsRelatorio.FieldByName('CODITE').AsString;
  qryAux.ParamByName('CODEMP').AsString := cdsRelatorio.FieldByName('CODEMP').AsString;
end;

procedure TfrmRelFiscCreIcmVendInterest.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strTotal: String;
begin
  Try
    With Excel Do
    Begin

      If (Quebra.NomeCampo = 'NUMDOC') Then
        strTotal := 'TOTAL DOCUMENTO:    '
      Else
        strTotal := 'TOTAL:    ';

      ProximaLinha;
      Escrever(LinhaAtual, 01, strTotal);
      Escrever(LinhaAtual, Campos.ColunaPorNome['TOTVEN'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['TOTVEN']), 14));
      Escrever(LinhaAtual, Campos.ColunaPorNome['BAS_CRED_ICMS'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['BAS_CRED_ICMS']), 14));
      Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_CRED_ICMS'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VLR_CRED_ICMS']), 14));

      If intModelo = 3 Then
        Escrever(LinhaAtual, Campos.ColunaPorNome['VLR_CRED_ICMS_ST'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VLR_CRED_ICMS_ST']), 14));

      If intModelo = 2 Then
      Begin
        Escrever(LinhaAtual, Campos.ColunaPorNome['VLRTOT_E'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VLRTOT_E']), 14));
        Escrever(LinhaAtual, Campos.ColunaPorNome['VLRICM_E'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VLRICM_E']), 14));
        Escrever(LinhaAtual, Campos.ColunaPorNome['VLCREC'].Coluna, fPadL(FormatFloat('##,#0.00', Quebra.Totais['VLCREC']), 14));
      End;

      Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['TOTVEN'].Coluna -1) + IntToStr(LinhaAtual));
      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
    
end;

procedure TfrmRelFiscCreIcmVendInterest.pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
begin
  Totais['TOTVEN'] := Totais['TOTVEN'] + Dados.FieldByName('TOTVEN').AsCurrency;
  Totais['BAS_CRED_ICMS'] := Totais['BAS_CRED_ICMS'] + Dados.FieldByName('BAS_CRED_ICMS').AsCurrency;
  Totais['VLR_CRED_ICMS'] := Totais['VLR_CRED_ICMS'] + Dados.FieldByName('VLR_CRED_ICMS').AsCurrency;

  If intModelo = 3 Then
    Totais['VLR_CRED_ICMS_ST'] := Totais['VLR_CRED_ICMS_ST'] + Dados.FieldByName('VLR_CRED_ICMS_ST').AsCurrency;

  If intModelo = 2 Then
  Begin
    Totais['VLRTOT_E'] := Totais['VLRTOT_E'] + Dados.FieldByName('VLRTOT_E').AsCurrency;
    Totais['VLRICM_E'] := Totais['VLRICM_E'] + Dados.FieldByName('VLRICM_E').AsCurrency;
    Totais['VLCREC'] := Totais['VLCREC'] + Dados.FieldByName('VLCREC').AsCurrency;
  End;
End;

end.
