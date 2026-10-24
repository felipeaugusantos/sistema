unit untImpressaoRG;

interface

uses
{$IF Defined(LINUX)}
  Uni,
  FMX.frxClass, FMX.frxDBSet, FMX.frxDesgn, FMX.frxExportPDF,
  FMX.frxBarcode, FMX.frxDelphiZXingQRCode, FMX.Graphics,
  FMX.Objects, FMX.Forms,
{$ELSE}
  Windows, Messages, Graphics,
  Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  {$IFDEF VER300}
    System.UITypes,
  {$ENDIF}
  DBCtrls, MemDS, Dialogs,
  frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn,
{$IFEND}
  StrUtils, DB, untConexaoBD, untUtil, SysUtils, Variants, Classes;

type
  TImpressaoRG = class
  private
    ConexaoBD : TConexaoBD;
    frxDanfe: TfrxReport;
    frxDbDanfe: TfrxDBDataset;
    frxDesigner: TfrxDesigner;

    procedure pDanfeRG(strCodigoEmpresa, strChaveAcesso, strImpressora : string; blnDesignReport: Boolean=False);
    function frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;

  public
    dtsConf: TDataSource;
    constructor Create();
    destructor Destroy; override;
    procedure Imprimir(strCodEmp, strNumDoc, strEspDoc, strCodCli: string; blnDesignReport: boolean=False);
  end;

Var
  qryTmpCab: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpPar: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpVlC: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

implementation

uses
{$IF Defined(LINUX)}
  NFe.Modulo, untModuloReplicacao;
{$ELSE}
  untModulo, {$IF Defined(UNIDAC)} untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND},
  untConfImpressora;
{$IFEND}

{ TImpressaoRG }

constructor TImpressaoRG.Create();
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);
end;

destructor TImpressaoRG.Destroy();
begin
  ConexaoBD.Free();
end;

function TImpressaoRG.frxDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
var
  lstArquivo: TStringList;
  strFile: String;
begin
  strFile := ExtractFilePath(ParamStr(0)) + 'TempImprNFeFr3.fr3';
  lstArquivo := TStringList.Create;

  Try
    if FileExists(strFile) then
      DeleteFile(strFile);

    Report.SaveToFile(strFile);

    {$IF Defined(UNIDAC)}
    try
      lstArquivo.LoadFromFile(strFile, TEncoding.UTF8);
    except
      lstArquivo.LoadFromFile(UTF8Encode(strFile));
    end;
    {$ELSE}
    lstArquivo.LoadFromFile(UTF8Encode(strFile));
    {$IFEND}

    If Assigned(dtsConf) Then
    Begin
      dtsConf.DataSet.Edit;
      dtsConf.DataSet.FieldByName('NFE_LAYRET').Text := lstArquivo.Text;
      dtsConf.DataSet.Post;

      If SaveAs Then
        Report.SaveToFile('DANFE.FR3');
    End;
  Finally
    Result := True;

    FreeAndNil(lstArquivo);

    if FileExists(strFile) then
      DeleteFile(strFile);
  End;
end;

procedure TImpressaoRG.pDanfeRG(strCodigoEmpresa, strChaveAcesso, strImpressora: string; blnDesignReport: Boolean=False);
  Var
    i,
    intQtdVias: Integer;
    strNomImp: String;
    LStreamDanfe: TStringStream;
Begin
  Try
    frxDbDanfe := TfrxDBDataset.Create(nil);
    frxDbDanfe.UserName := 'frxNFce';
    frxDbDanfe.DataSet := qryTmpPar;

    frxDanfe := TfrxReport.Create(nil);

    ConexaoBD.CarregarConfiguracao(strChaveAcesso, strCodigoEmpresa, 'RG', 1.00);

    LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
    frxDanfe.LoadFromStream(LStreamDanfe);
    LStreamDanfe.Free;

    frxDanfe.Script.Variables['NOMEMP'] := qryTmpCab.FieldByName('NOMEMP').AsString;
    frxDanfe.Script.Variables['CNPJ'] := fFormataCpfCgc(qryTmpCab.FieldByName('C_G_C_').AsString);
    frxDanfe.Script.Variables['IE'] := qryTmpCab.FieldByName('I_E_S_').AsString;
    frxDanfe.Script.Variables['IM'] := qryTmpCab.FieldByName('INSMUN').AsString;
    frxDanfe.Script.Variables['ENDEMP'] := qryTmpCab.FieldByName('ENDEMP').AsString;
    frxDanfe.Script.Variables['CEPEMP'] := fFormataCEP(AnsiReplaceStr(qryTmpCab.FieldByName('CEPEMP').AsString, '-', ''));
    frxDanfe.Script.Variables['TELEMP'] := fFormataFone(qryTmpCab.FieldByName('TELEMP').AsString);
    frxDanfe.Script.Variables['NUMDOC'] := qryTmpCab.FieldByName('NUMDOC').AsString+'-'+qryTmpCab.FieldByName('ESPDOC').AsString;
    frxDanfe.Script.Variables['CLIENTE'] := qryTmpPar.FieldByName('CODCLI').AsString+'-'+qryTmpPar.FieldByName('NOMCLI').AsString;
    frxDanfe.Script.Variables['VENDEDOR'] := qryTmpCab.FieldByName('CODVEN').AsString+'-'+qryTmpCab.FieldByName('NOMVEN').AsString;
    frxDanfe.Script.Variables['VLR_COMPRA'] := FormatFloat('###,###,##0.00', qryTmpCab.FieldByName('VLRCON').AsFloat);
    frxDanfe.Script.Variables['VLR_PAGO'] := FormatFloat('###,###,##0.00', qryTmpVlC.FieldByName('TOTPGO').AsFloat);

    If not blnDesignReport Then
    Begin

      If fEmptyStr(strImpressora) Then
      Begin
        strNomImp := fArqIniLocal(0, 'NFCE', 'IMPRESSORA', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
        If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
          If ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' then
            strNomImp := fArqIniLocal(0, 'NFCE', 'PONTO_IMPRESSAO', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
      End
      Else
        strNomImp := strImpressora;

      intQtdVias := StrToIntDef(ConexaoBD.CarregarCFGSIS('VIASRG'),1);

      If (intQtdVias <= 0) Then intQtdVias := 1;

      For i := 1 To intQtdVias Do
      Begin
        frxDanfe.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
        frxDanfe.PrintOptions.ShowDialog := False;
       {$IF Defined(LINUX)}
       {$ELSE}
        If (frxDanfe.PrepareReport) Then
          pPrintReport('NFeImpressao', 'Relatório Gerencial ' + strChaveAcesso, strNomImp, frxDanfe);

        If (intQtdVias > 1) Then
          Sleep(1000);
       {$IFEND}
      End;
    End
    Else
      frxDanfe.DesignReport;

  Finally
    FreeAndNil(frxDanfe);
    FreeAndNil(frxDbDanfe);
  End;

End;

procedure TImpressaoRG.Imprimir(strCodEmp, strNumDoc, strEspDoc, strCodCli: string; blnDesignReport: boolean=False);
Begin

  Try

    Try

      qryTmpCab := fCriaQuery(nil);

      qryTmpCab.SQL.Clear;
      qryTmpCab.SQL.Add('SELECT ');
      qryTmpCab.SQL.Add('  FG.FGO_NUMDOC AS NUMDOC, ');
      qryTmpCab.SQL.Add('  FG.FGO_ESPDOC AS ESPDOC, ');
      qryTmpCab.SQL.Add('  FG.FGO_VLRCON AS VLRCON, ');
      If (ConexaoBD.CarregarCFGSIS('RSNFNC') = 'F') Then
        qryTmpCab.SQL.Add('  EP.EMP_NOMFAN AS NOMEMP, ')
      Else
        qryTmpCab.SQL.Add('  EP.EMP_NOMEMP AS NOMEMP, ');
      qryTmpCab.SQL.Add('  EP.EMP_C_G_C_ AS C_G_C_, ');
      qryTmpCab.SQL.Add('  EP.EMP_I_E_S_ AS I_E_S_, ');
      qryTmpCab.SQL.Add('  EP.EMP_INSMUN AS INSMUN, ');
      qryTmpCab.SQL.Add('  CONCAT( ');
      qryTmpCab.SQL.Add('    EP.EMP_ENDERE, ');
      qryTmpCab.SQL.Add('    ", ", ');
      qryTmpCab.SQL.Add('    EP.EMP_ENDNUM, ');
      qryTmpCab.SQL.Add('    ", ", ');
      qryTmpCab.SQL.Add('    EP.EMP_BAIRRO, ');
      qryTmpCab.SQL.Add('    " - ", ');
      qryTmpCab.SQL.Add('    CE.CID_NOMCID, ');
      qryTmpCab.SQL.Add('    "/", ');
      qryTmpCab.SQL.Add('    CE.CID_ESTADO ');
      qryTmpCab.SQL.Add('  ) AS ENDEMP, ');
      qryTmpCab.SQL.Add('  EP.EMP_C_E_P_ AS CEPEMP, ');
      qryTmpCab.SQL.Add('  EP.EMP_FONE01 AS TELEMP, ');
      qryTmpCab.SQL.Add('  VE.OPE_NOMOPE AS NOMVEN, ');
      qryTmpCab.SQL.Add('  FG.FGO_CODVEN AS CODVEN  ');
      qryTmpCab.SQL.Add('FROM ');
      qryTmpCab.SQL.Add('  FATGOR FG ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADEMP EP ');
      qryTmpCab.SQL.Add('    ON EP.EMP_CODEMP = FG.FGO_CODEMP ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADCID CE ');
      qryTmpCab.SQL.Add('    ON CE.CID_CODCID = EP.EMP_CODCID ');
      qryTmpCab.SQL.Add('  LEFT JOIN CADOPE VE ');
      qryTmpCab.SQL.Add('    ON VE.OPE_CODOPE = FG.FGO_CODVEN ');
      qryTmpCab.SQL.Add('WHERE FG.FGO_NUMDOC = :NUMDOC ');
      qryTmpCab.SQL.Add('  AND FG.FGO_ESPDOC = :ESPDOC ');
      qryTmpCab.SQL.Add('  AND FG.FGO_CODEMP = :CODEMP ');

      qryTmpCab.ParamByName('NUMDOC').AsString := strNumDoc;
      qryTmpCab.ParamByName('ESPDOC').AsString := strEspDoc;
      qryTmpCab.ParamByName('CODEMP').AsString := strCodEmp;

      qryTmpCab.Open;

      qryTmpPar := fCriaQuery(nil);

      qryTmpPar.SQL.Clear;
      qryTmpPar.SQL.Add(' SELECT ');
      qryTmpPar.SQL.Add('   CTR_PARCEL AS NUMPAR, ');
      qryTmpPar.SQL.Add('   CTR_DTAVEN AS DTAVEN, ');
      qryTmpPar.SQL.Add('   IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI) AS VLRPAR, ');
      qryTmpPar.SQL.Add('   CTR_DTAREC AS DTAPGO, ');
      qryTmpPar.SQL.Add('   CTR_VALREC AS VLRPGO, ');
      qryTmpPar.SQL.Add('   CLI_CODCLI AS CODCLI, ');
      qryTmpPar.SQL.Add('   CLI_NOMCLI AS NOMCLI ');
      qryTmpPar.SQL.Add(' FROM ');
      qryTmpPar.SQL.Add('   CADREC ');
      qryTmpPar.SQL.Add('   INNER JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ');
      qryTmpPar.SQL.Add(' WHERE ');
      If blnDesignReport Then
      Begin
        qryTmpPar.SQL.Add('  CTR_ESPDOC = "NF" AND ');
        qryTmpPar.SQL.Add('  CTR_CODEMP = ' + QuotedStr(strCodEmp));
      End
      Else
      Begin
        qryTmpPar.SQL.Add('   CTR_NUMDUP = ' + QuotedStr(strNumDoc) + ' AND ');
        qryTmpPar.SQL.Add('   CTR_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ');
        qryTmpPar.SQL.Add('   CTR_CODCLI = ' + QuotedStr(strCodCli) + ' AND ');
        qryTmpPar.SQL.Add('   CTR_CODEMP = ' + QuotedStr(strCodEmp));
      End;

      If ConexaoBD.fTabelaExiste('CADRECX') Then
      Begin
        qryTmpPar.SQL.Add(' UNION ALL ');

        qryTmpPar.SQL.Add(' SELECT ');
        qryTmpPar.SQL.Add('   CTR_PARCEL AS NUMPAR, ');
        qryTmpPar.SQL.Add('   CTR_DTAVEN AS DTAVEN, ');
        qryTmpPar.SQL.Add('   IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI) AS VLRPAR, ');
        qryTmpPar.SQL.Add('   CTR_DTAREC AS DTAPGO, ');
        qryTmpPar.SQL.Add('   CTR_VALREC AS VLRPGO, ');
        qryTmpPar.SQL.Add('   CLI_CODCLI AS CODCLI, ');
        qryTmpPar.SQL.Add('   CLI_NOMCLI AS NOMCLI ');
        qryTmpPar.SQL.Add(' FROM ');
        qryTmpPar.SQL.Add('   CADRECX ');
        qryTmpPar.SQL.Add('   INNER JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ');
        qryTmpPar.SQL.Add(' WHERE ');
        If blnDesignReport Then
        Begin
          qryTmpPar.SQL.Add('  CTR_ESPDOC = "NF" AND ');
          qryTmpPar.SQL.Add('  CTR_CODEMP = ' + QuotedStr(strCodEmp));
        End
        Else
        Begin
          qryTmpPar.SQL.Add('   CTR_NUMDUP = ' + QuotedStr(strNumDoc) + ' AND ');
          qryTmpPar.SQL.Add('   CTR_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ');
          qryTmpPar.SQL.Add('   CTR_CODCLI = ' + QuotedStr(strCodCli) + ' AND ');
          qryTmpPar.SQL.Add('   CTR_CODEMP = ' + QuotedStr(strCodEmp));
        End;
      End;

      If ConexaoBD.fTabelaExiste('ADTCLI') Then
      Begin
        qryTmpPar.SQL.Add(' UNION ALL ');

        qryTmpPar.SQL.Add(' SELECT ');
        qryTmpPar.SQL.Add('   "A"        AS NUMPAR, ');
        qryTmpPar.SQL.Add('   ADT_DTALAN AS DTAVEN, ');
        qryTmpPar.SQL.Add('   ADT_VALLAN AS VLRPAR, ');
        qryTmpPar.SQL.Add('   ADT_DTALAN AS DTAPGO, ');
        qryTmpPar.SQL.Add('   ADT_VALLAN AS VLRPGO, ');
        qryTmpPar.SQL.Add('   CLI_CODCLI AS CODCLI, ');
        qryTmpPar.SQL.Add('   CLI_NOMCLI AS NOMCLI ');
        qryTmpPar.SQL.Add(' FROM ');
        qryTmpPar.SQL.Add('   ADTCLI ');
        qryTmpPar.SQL.Add('   INNER JOIN CADCLI ON ADT_CODCLI = CLI_CODCLI ');
        qryTmpPar.SQL.Add(' WHERE ');

        If blnDesignReport Then
        Begin
          qryTmpPar.SQL.Add('  ADT_ESPDOC = "NF" AND ');
          qryTmpPar.SQL.Add('  ADT_CODEMP = ' + QuotedStr(strCodEmp));
        End
        Else
        Begin
          qryTmpPar.SQL.Add('   ADT_NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ');
          qryTmpPar.SQL.Add('   ADT_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ');
          qryTmpPar.SQL.Add('   ADT_CODCLI = ' + QuotedStr(strCodCli) + ' AND ');
          qryTmpPar.SQL.Add('   ADT_CODEMP = ' + QuotedStr(strCodEmp));
        End;
      End;

      If blnDesignReport Then
        qryTmpPar.SQL.Add('LIMIT 1 ')
      Else
      Begin
        qryTmpPar.SQL.Add(' ORDER BY ');
        qryTmpPar.SQL.Add('   DTAVEN ');
      End;

      qryTmpPar.Open;

      qryTmpVlC := fCriaQuery(nil);

      qryTmpVlC.SQL.Add('SELECT SUM(X.VALPGO) AS TOTPGO FROM ');
      qryTmpVlC.SQL.Add('(SELECT ');
      qryTmpVlC.SQL.Add('  CTR_VALREC AS VALPGO ');
      qryTmpVlC.SQL.Add('FROM ');
      qryTmpVlC.SQL.Add('  CADREC ');

      If blnDesignReport Then
      Begin
        qryTmpVlC.SQL.Add('WHERE CTR_ESPDOC = "NF" ');
        qryTmpVlC.SQL.Add('  AND CTR_CODEMP = ' + QuotedStr(strCodEmp));
      End
      Else
      Begin
        qryTmpVlC.SQL.Add('WHERE CTR_NUMDUP = ' + QuotedStr(strNumDoc));
        qryTmpVlC.SQL.Add('  AND CTR_ESPDOC = ' + QuotedStr(strEspDoc));
        qryTmpVlC.SQL.Add('  AND CTR_CODCLI = ' + QuotedStr(strCodCli));
        qryTmpVlC.SQL.Add('  AND CTR_CODEMP = ' + QuotedStr(strCodEmp));
      End;

      If ConexaoBD.fTabelaExiste('CADRECX') Then
      Begin

        qryTmpVlC.SQL.Add('UNION ');
        qryTmpVlC.SQL.Add('ALL ');
        qryTmpVlC.SQL.Add('SELECT ');
        qryTmpVlC.SQL.Add('  CTR_VALREC AS VALPGO ');
        qryTmpVlC.SQL.Add('FROM ');
        qryTmpVlC.SQL.Add('  CADRECX ');

        If blnDesignReport Then
        Begin
          qryTmpVlC.SQL.Add('WHERE CTR_ESPDOC = "NF" ');
          qryTmpVlC.SQL.Add('  AND CTR_CODEMP = ' + QuotedStr(strCodEmp));
        End
        Else
        Begin
          qryTmpVlC.SQL.Add('WHERE CTR_NUMDUP = ' + QuotedStr(strNumDoc));
          qryTmpVlC.SQL.Add('  AND CTR_ESPDOC = ' + QuotedStr(strEspDoc));
          qryTmpVlC.SQL.Add('  AND CTR_CODCLI = ' + QuotedStr(strCodCli));
          qryTmpVlC.SQL.Add('  AND CTR_CODEMP = ' + QuotedStr(strCodEmp));
        End;

      End;

      If ConexaoBD.fTabelaExiste('ADTCLI') Then
      Begin

        qryTmpVlC.SQL.Add('UNION ');
        qryTmpVlC.SQL.Add('ALL ');
        qryTmpVlC.SQL.Add('SELECT ');
        qryTmpVlC.SQL.Add('  ADT_VALLAN AS VALPGO ');
        qryTmpVlC.SQL.Add('FROM ');
        qryTmpVlC.SQL.Add('  ADTCLI ');

        If blnDesignReport Then
        Begin
          qryTmpVlC.SQL.Add('WHERE ADT_ESPDOC = "NF" ');
          qryTmpVlC.SQL.Add('  AND ADT_CODEMP = ' + QuotedStr(strCodEmp));
        End
        Else
        Begin
          qryTmpVlC.SQL.Add('WHERE ADT_NUMDOC = ' + QuotedStr(strNumDoc));
          qryTmpVlC.SQL.Add('  AND ADT_ESPDOC = ' + QuotedStr(strEspDoc));
          qryTmpVlC.SQL.Add('  AND ADT_CODCLI = ' + QuotedStr(strCodCli));
          qryTmpVlC.SQL.Add('  AND ADT_CODEMP = ' + QuotedStr(strCodEmp));
        End;

      End;

      qryTmpVlC.SQL.Add(' ) AS X ');

      qryTmpVlC.Open;

      If not qryTmpPar.IsEmpty Then
      Begin
        If blnDesignReport Then
        Begin
          frxDesigner := TfrxDesigner.Create(nil);
          frxDesigner.Restrictions := [drDontDeletePage,
                                       drDontCreatePage,
                                       drDontChangePageOptions,
                                       drDontCreateReport,
                                       drDontEditVariables,
                                       drDontEditReportData,
                                       drDontShowRecentFiles,
                                       drDontEditReportScript,
                                       drDontEditInternalDatasets];
          frxDesigner.Standalone := True;
          frxDesigner.OnSaveReport := frxDesignerSaveReport;
        End;
        pDanfeRG(strCodEmp, '', '', blnDesignReport);

      End;

    Finally
      FreeAndNil(qryTmpPar);
      FreeAndNil(qryTmpCab);
      FreeAndNil(qryTmpVlC);
      FreeAndNil(frxDesigner);
    End;

  Except
    On E : Exception do
    Begin
    {$IF Defined(LINUX)}
      Writeln('Erro [ImpressaoRG.Imprimir]: ' + E.Message);
    {$ELSE}
      ShowErrorMsgTimeout(E.ClassName, 'Erro [ImpressaoRG.Imprimir]: ' + E.Message, 10000);
    {$IFEND}
    End;
  End;

End;

end.
