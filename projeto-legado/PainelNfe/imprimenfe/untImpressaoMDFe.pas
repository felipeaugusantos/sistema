unit untImpressaoMDFe;

interface

uses
{$IF Defined(LINUX)}
  Uni,
  FMX.frxClass, FMX.frxDBSet, FMX.frxDesgn, FMX.frxExportPDF,
  FMX.frxBarcode, FMX.frxDelphiZXingQRCode, FMX.Graphics,
  FMX.Objects, FMX.Forms, NFe.Modulo,
{$ELSE}
  Windows, Messages,Graphics,
  Controls, Forms, frxClass, ComCtrls, StdCtrls, ExtCtrls,
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  DBCtrls, MemDS, Dialogs,
  {$IFDEF VER300}
    System.UITypes,
  {$ENDIF}
  untModulo, frxBarcode, frxDBSet, frxDelphiZXingQRCode, frxDesgn,
{$IFEND}
   StrUtils, SysUtils, Variants, Classes, DB, untConexaoBD, untUtil;

type
  TImpressaoMDFe = class
  private
    ConexaoBD : TConexaoBD;
    frxDanfe: TfrxReport;
    frxDbDanfe: TfrxDBDataset;
    frxMdfAcess: TfrxDBDataset;

    procedure pDanfeMDFe(strCodigoEmpresa, strNumeroManifesto, strImpressora : string; blnDesignReport: Boolean=False);
  public
    dtsConf: TDataSource;
    constructor Create();
    destructor Destroy; override;
    procedure Imprimir(strCodEmp, strNumMan, strImpressora: string; blnDesignReport: boolean=False);
  end;

Var
  qryTmpCab: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpPar: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpQtd: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpNfe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  qryTmpMdf: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

implementation

uses
{$IF Defined(LINUX)}
{$ELSE}
  {$IF Defined(UNIDAC)} untModuloReplicacao, Vcl.Printers {$ELSE} untModuloReplicacaoZeos {$IFEND},
{$IFEND}
  untConfImpressora;

{ TImpressaoMDFe }

constructor TImpressaoMDFe.Create;
begin
  ConexaoBD := TConexaoBD.Create(frmModulo.Database);
end;

destructor TImpressaoMDFe.Destroy;
begin
  ConexaoBD.Free();
end;

procedure TImpressaoMDFe.Imprimir(strCodEmp, strNumMan, strImpressora: string; blnDesignReport: boolean=False);

  function fValidaCampoVazioDts(qryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
   arrCamposValidos: Array Of String): Boolean;
  var
    intCont: Integer;
  begin
    Result := False;

    for intCont := 0 to Pred(qryConsulta.Fields.Count) do
    begin
      If AnsiMatchText(qryConsulta.Fields[intCont].FieldName, arrCamposValidos) Then
        Result := fEmptyStr(qryConsulta.Fields[intCont].AsString)
      Else
        Continue;

      If Result Then
        Break;
    end;
  end;

  procedure PreencheQryTmpMdf;
  begin
    qryTmpMdf.Close;
    qryTmpMdf.SQL.Clear;
    qryTmpMdf.SQL.Add('SELECT ');
    qryTmpMdf.SQL.Add('  F.MDF_PROTOC, ');
    qryTmpMdf.SQL.Add('  F.MDF_CODMOD, ');
    qryTmpMdf.SQL.Add('  F.MDF_DTAHOR, ');
    qryTmpMdf.SQL.Add('  P.MDF_RNTRC_  ');
    qryTmpMdf.SQL.Add('FROM MDFFIS F ');
    qryTmpMdf.SQL.Add('LEFT JOIN MDFPRO P ON F.MDF_NUMMAN = P.MDF_NUMMAN AND F.MDF_EMPMAN = P.MDF_EMPMAN ');
    qryTmpMdf.SQL.Add('WHERE F.MDF_NUMMAN = :NUMMAN ');
    qryTmpMdf.SQL.Add('  AND F.MDF_EMPMAN = :CODEMP ');

    qryTmpMdf.ParamByName('CODEMP').AsString := strCodEmp;
    qryTmpMdf.ParamByName('NUMMAN').AsString := strNumMan;

    qryTmpMdf.Open;
  end;
var
  intContRepeatUntil: Integer;
  blnCampoVazioDts: Boolean;
begin
  Try
    qryTmpCab := fCriaQuery(nil);
    qryTmpPar := fCriaQuery(nil);
    qryTmpQtd := fCriaQuery(nil);
    qryTmpNfe := fCriaQuery(nil);
    qryTmpMdf := fCriaQuery(nil);

    Try

      qryTmpCab.SQL.Clear;
      qryTmpCab.SQL.Add('SELECT ');
      qryTmpCab.SQL.Add('  N.FIS_EMPMAN, ');
      qryTmpCab.SQL.Add('  N.FIS_CODEMP, ');
      qryTmpCab.SQL.Add('  E.EMP_NOMEMP, ');
      qryTmpCab.SQL.Add('  E.EMP_NOMFAN, ');
      qryTmpCab.SQL.Add('  E.EMP_ENDERE, ');
      qryTmpCab.SQL.Add('  E.EMP_ENDNUM, ');
      qryTmpCab.SQL.Add('  E.EMP_BAIRRO, ');
      qryTmpCab.SQL.Add('  E.EMP_I_E_S_, ');
      qryTmpCab.SQL.Add('  E.EMP_C_G_C_, ');
      qryTmpCab.SQL.Add('  E.EMP_FONE01, ');
      qryTmpCab.SQL.Add('  F.CID_NOMCID EMP_CIDADE, ');
      qryTmpCab.SQL.Add('  F.CID_ESTADO EMP_ESTADO, ');
      qryTmpCab.SQL.Add('  E.EMP_C_E_P_, ');
      qryTmpCab.SQL.Add('  N.FIS_ACEMAN, ');
      qryTmpCab.SQL.Add('  N.FIS_SERIE_, ');
      qryTmpCab.SQL.Add('  N.FIS_NUMMAN, ');
      qryTmpCab.SQL.Add('  N.FIS_DTAMAN, ');
      qryTmpCab.SQL.Add('  N.FIS_PLAMAN, ');
      If fCampoExiste('CADFIS', 'FIS_PLAMA2') then
        qryTmpCab.SQL.Add('  N.FIS_PLAMA2, ')
      Else
        qryTmpCab.SQL.Add(' CAST("" AS CHAR(7)) AS FIS_PLAMA2, ');

      If fCampoExiste('CADFIS', 'FIS_ESTMAN') then
        qryTmpCab.SQL.Add('  N.FIS_ESTMAN, ')
      Else
        qryTmpCab.SQL.Add(' CAST("" AS CHAR(2)) AS FIS_ESTMAN, ');
      qryTmpCab.SQL.Add('  N.FIS_ACESSO ');
      qryTmpCab.SQL.Add('FROM CADFIS N ');
      qryTmpCab.SQL.Add('  JOIN CADEMP E ON E.EMP_CODEMP = N.FIS_EMPMAN ');
      qryTmpCab.SQL.Add('  JOIN CADCID F ON F.CID_CODCID = E.EMP_CODCID ');
      qryTmpCab.SQL.Add('WHERE FIS_NUMMAN = :NUMMAN ');
      qryTmpCab.SQL.Add('  AND FIS_EMPMAN = :CODEMP ');

      qryTmpCab.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpCab.ParamByName('NUMMAN').AsString := strNumMan;

      qryTmpCab.Open;

      qryTmpPar.SQL.Clear;
      qryTmpPar.SQL.Add('SELECT ');
      qryTmpPar.SQL.Add('  F.FMO_CODMOT, ');
      qryTmpPar.SQL.Add('  M.MOT_CPFMOT, ');
      qryTmpPar.SQL.Add('  M.MOT_NOMMOT ');
      qryTmpPar.SQL.Add('FROM CADFIS C ');
      qryTmpPar.SQL.Add('  JOIN FISMOT F ON F.FMO_SEQGER = C.AUTOINCREM ');
      qryTmpPar.SQL.Add('  JOIN CADMOT M ON M.MOT_CODMOT = F.FMO_CODMOT ');
      qryTmpPar.SQL.Add('WHERE FIS_NUMMAN = :NUMMAN ');
      qryTmpPar.SQL.Add('  AND FIS_EMPMAN = :CODEMP ');
      qryTmpPar.SQL.Add('ORDER BY M.MOT_NOMMOT ');

      qryTmpPar.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpPar.ParamByName('NUMMAN').AsString := strNumMan;

      qryTmpPar.Open;

      qryTmpNfe.SQL.Clear;
      qryTmpNfe.SQL.Add('SELECT GER_PESBRU AS PESBRU, GER_VLRCON AS VLRCON ');
      qryTmpNfe.SQL.Add('FROM CADFIS ');
      qryTmpNfe.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ');
      qryTmpNfe.SQL.Add('  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ');
      qryTmpNfe.SQL.Add('                 GER_ESPDOC = FIS_ESPDOC AND ');
      qryTmpNfe.SQL.Add('                 GER_SERIE_ = FIS_SERIE_ AND ');
      qryTmpNfe.SQL.Add('                 GER_CODEMP = FIS_CODEMP AND ');
      qryTmpNfe.SQL.Add('                 GER_TIP_FC = FIS_TIP_FC AND ');
      qryTmpNfe.SQL.Add('                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI ');
      qryTmpNfe.SQL.Add('WHERE FIS_NUMMAN = :NUMMAN ');
      qryTmpNfe.SQL.Add('  AND FIS_EMPMAN = :CODEMP ');

      qryTmpNfe.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpNfe.ParamByName('NUMMAN').AsString := strNumMan;

      qryTmpNfe.Open;

      qryTmpQtd.SQL.Clear;
      qryTmpQtd.SQL.Add('SELECT COUNT(*) QTDCTE ');
      qryTmpQtd.SQL.Add('FROM ');
      qryTmpQtd.SQL.Add('  CADFIS N ');
      qryTmpQtd.SQL.Add('  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ');
      qryTmpQtd.SQL.Add('             AND FIS_CODEMP = CTE_CODEMP ');
      qryTmpQtd.SQL.Add('WHERE N.FIS_NUMMAN = :NUMMAN ');
      qryTmpQtd.SQL.Add('  AND N.FIS_EMPMAN = :CODEMP ');

      qryTmpQtd.ParamByName('CODEMP').AsString := strCodEmp;
      qryTmpQtd.ParamByName('NUMMAN').AsString := strNumMan;

      qryTmpQtd.Open;

      intContRepeatUntil := 1;
      Repeat
        PreencheQryTmpMdf;
        blnCampoVazioDts := fValidaCampoVazioDts(qryTmpMdf, ['MDF_PROTOC','MDF_CODMOD','MDF_DTAHOR']);
        If blnCampoVazioDts Then
          Sleep(1000);

        If intContRepeatUntil = 5 Then
          Break
        Else
          Inc(intContRepeatUntil);

      Until Not blnCampoVazioDts;

      If not qryTmpCab.IsEmpty Then
      Begin
        pDanfeMDFe(strCodEmp, strNumMan, strImpressora, blnDesignReport);
      End;

    Finally
      FreeAndNil(qryTmpCab);
      FreeAndNil(qryTmpPar);
      FreeAndNil(qryTmpQtd);
      FreeAndNil(qryTmpNfe);
      FreeAndNil(qryTmpMdf);
    End;

  Except
    On E : Exception do
    Begin
    {$IF Defined(LINUX)}
      Writeln('Erro [ImpressaoMDFe.Imprimir]: ' + E.Message);
    {$ELSE}
      ShowErrorMsgTimeout(E.ClassName, 'Erro [ImpressaoMDFe.Imprimir]: ' + E.Message, 10000);
    {$IFEND}
    End;
  End;
end;


procedure TImpressaoMDFe.pDanfeMDFe(strCodigoEmpresa, strNumeroManifesto,
  strImpressora: string; blnDesignReport: Boolean);
  Var
    intContador,
    intQtdVias: Integer;
    strNomImp: String;
    strEmpEndereco: String;
    strNomeCondutor: String;
    strCpfCondutor: String;
    intQtdeNfe: Integer;
    fltPesoBrutoTotal: Double;
    fltValorTotalCarga: Double;
    strTpAmbi : String;
    strLinkQrCode : String;
    frxQrCode : TfrxPictureView;
    intTentativas : Integer;
    bmpQrCode : TBitmap;
    stream: TMemoryStream;
    stlLstCondutor: TStringList;
    LStreamDanfe: TStringStream;
Begin

  frxDbDanfe := TfrxDBDataset.Create(nil);
  frxDanfe := TfrxReport.Create(nil);

  frxMdfAcess := TfrxDBDataset.Create(nil);

  Try

    frxDbDanfe.UserName := 'frxNFce';
    frxDbDanfe.DataSet := qryTmpPar;

    frxMdfAcess.UserName := 'frxMdfAces';
    frxMdfAcess.DataSet := qryTmpCab;

    ConexaoBD.CarregarConfiguracao('', strCodigoEmpresa, 'MDFE', 4.00);

    LStreamDanfe := fStringToStreamDanfe(ConexaoBD.FConfiguracao.LayoutRetrato);
    frxDanfe.LoadFromStream(LStreamDanfe);
    LStreamDanfe.Free;

    frxDanfe.DataSets.Add(frxMdfAcess);

    strEmpEndereco := qryTmpCab.FieldByName('EMP_ENDERE').AsString + ', ' +
      qryTmpCab.FieldByName('EMP_ENDNUM').AsString + #13 +
      qryTmpCab.FieldByName('EMP_BAIRRO').AsString + #13 +
      qryTmpCab.FieldByName('EMP_CIDADE').AsString + '/' +
      qryTmpCab.FieldByName('EMP_ESTADO').AsString + #13 +
      'CEP: ' + fFormataCEP(qryTmpCab.FieldByName('EMP_C_E_P_').AsString) + #13 +
      'Telefone: ' + fFormataFone(qryTmpCab.FieldByName('EMP_FONE01').AsString);

    frxDanfe.Script.Variables['EMP_NOMEMP'] := qryTmpCab.FieldByName('EMP_NOMEMP').AsString;
    frxDanfe.Script.Variables['EMP_ENDERE'] := strEmpEndereco;
    frxDanfe.Script.Variables['EMP_C_G_C_'] := fFormataCpfCgc(qryTmpCab.FieldByName('EMP_C_G_C_').AsString);
    frxDanfe.Script.Variables['EMP_I_E_S_'] := qryTmpCab.FieldByName('EMP_I_E_S_').AsString;
    frxDanfe.Script.Variables['FIS_ACEMAN'] := qryTmpCab.FieldByName('FIS_ACEMAN').AsString;
    frxDanfe.Script.Variables['FIS_ACEBAR'] := qryTmpCab.FieldByName('FIS_ACEMAN').AsString;
    frxDanfe.Script.Variables['FIS_MANPRO'] := qryTmpMdf.FieldByName('MDF_PROTOC').AsString;
    frxDanfe.Script.Variables['FIS_DTHMAN'] := qryTmpMdf.FieldByName('MDF_DTAHOR').AsString;
    frxDanfe.Script.Variables['FIS_MODELO'] := qryTmpMdf.FieldByName('MDF_CODMOD').AsString;
    frxDanfe.Script.Variables['FIS_SERIE_'] := qryTmpCab.FieldByName('FIS_SERIE_').AsString;
    frxDanfe.Script.Variables['FIS_NUMMAN'] := qryTmpCab.FieldByName('FIS_NUMMAN').AsString;
    frxDanfe.Script.Variables['EMP_ESTADO'] := qryTmpCab.FieldByName('EMP_ESTADO').AsString;
    frxDanfe.Script.Variables['FIS_PLAMAN'] := qryTmpCab.FieldByName('FIS_PLAMAN').AsString;
    frxDanfe.Script.Variables['FIS_ACESSO'] := qryTmpCab.FieldByName('FIS_ACESSO').AsString;
    frxDanfe.Script.Variables['FIS_PLAMA2'] := qryTmpCab.FieldByName('FIS_PLAMA2').AsString;
    frxDanfe.Script.Variables['MDF_RNTRC_'] := qryTmpMdf.FieldByName('MDF_RNTRC_').AsString;

    frxDanfe.Script.Variables['ENDERE'] := qryTmpCab.FieldByName('EMP_ENDERE').AsString;
    frxDanfe.Script.Variables['ENDNUM'] := qryTmpCab.FieldByName('EMP_ENDNUM').AsString;
    frxDanfe.Script.Variables['BAIRRO'] := qryTmpCab.FieldByName('EMP_BAIRRO').AsString;
    frxDanfe.Script.Variables['CIDADE'] := qryTmpCab.FieldByName('EMP_CIDADE').AsString;
    frxDanfe.Script.Variables['ESTADO'] := qryTmpCab.FieldByName('EMP_ESTADO').AsString;
    frxDanfe.Script.Variables['EMPCEP'] := qryTmpCab.FieldByName('EMP_C_E_P_').AsString;
    frxDanfe.Script.Variables['UFDESCARR'] := qryTmpCab.FieldByName('FIS_ESTMAN').AsString;

    ConexaoBD.CarregarImagemBase64(qryTmpCab.FieldByName('FIS_CODEMP').AsString, 4.00, (frxDanfe.FindObject('ImgLogo') as TfrxPictureView).Picture, tpLogo, 'MDFE');

    If Assigned(frxDanfe.FindObject('mdsChAcesso')) Then
    Begin
      TfrxMasterData(frxDanfe.FindObject('mdsChAcesso')).DataSet := frxMdfAcess;
      TfrxMasterData(frxDanfe.FindObject('mdsChAcesso')).DataSetName := 'frxMdfAces';
    End;

    If Assigned(frxDanfe.FindObject('imgQrCode')) then
    begin
      If Not fEmptyStr(ConexaoBD.CarregarCFGSIS('URLMDF')) Then
      Begin

        If ConexaoBD.CarregarCFGSIS('HOMOLO')='N' Then
          strTpAmbi := '1'
        Else
          strTpAmbi := '2';

        strLinkQrCode := StringReplace(ConexaoBD.CarregarCFGSIS('URLMDF'), '[CHAVE]', qryTmpCab.FieldByName('FIS_ACEMAN').AsString, [rfReplaceAll]);
        strLinkQrCode := StringReplace(strLinkQrCode, '[AMBIENTE]', strTpAmbi, [rfReplaceAll]);

        frxQrCode := TfrxPictureView(frxDanfe.FindObject('imgQrCode'));
        intTentativas := 0;

        While True Do
        Begin
          bmpQrCode := TBitmap.Create;
          Try
            bmpQrCode := fGerarQRCode(strLinkQrCode);
            Sleep(100);
            Break;
          Except
            On E: Exception Do
            Begin
              Inc(intTentativas);
              If intTentativas > 30 Then
              Begin
                Raise;
              End;
              Sleep(500);
              Application.ProcessMessages;
            End;
          End;
        End;

        stream := TMemoryStream.Create;
        try
          bmpQrCode.SaveToStream(stream);
          frxQrCode.Visible := True;
        {$IF Defined(LINUX)}
          frxQrCode.Picture.LoadFromStream(stream);
        {$ELSE}
          frxQrCode.LoadPictureFromStream(stream);
        {$IFEND}
        finally
          FreeAndNil(stream);
          FreeAndNil(bmpQrCode);
        end;
      End
      Else
        TfrxPictureView(frxDanfe.FindObject('imgQrCode')).Visible := False;
    end;

    strNomeCondutor := '';
    strCpfCondutor := '';

    stlLstCondutor := TStringList.Create;
    try
      stlLstCondutor.Sorted := True;
      While not qryTmpPar.Eof do
      Begin
        if stlLstCondutor.IndexOf(qryTmpPar.FieldByName('MOT_CPFMOT').AsString) = -1 then
        begin
          stlLstCondutor.Add(qryTmpPar.FieldByName('MOT_CPFMOT').AsString);

          strNomeCondutor := strNomeCondutor + qryTmpPar.FieldByName('MOT_NOMMOT').AsString + #13;

          strCpfCondutor := strCpfCondutor + fFormataCpfCgc(qryTmpPar.FieldByName('MOT_CPFMOT').AsString) + #13;
        end;

        qryTmpPar.Next;
      End;
    finally
      FreeAndNil(stlLstCondutor);
    end;


    frxDanfe.Script.Variables['MOT_CPFMOT'] := strCpfCondutor;
    frxDanfe.Script.Variables['MOT_NOMMOT'] := strNomeCondutor;

    intQtdeNfe := 0;
    fltPesoBrutoTotal := 0;
    fltValorTotalCarga := 0;

    While not qryTmpNfe.Eof do
    Begin
      fltPesoBrutoTotal := fltPesoBrutoTotal +
        qryTmpNfe.FieldByName('PESBRU').AsFloat;
      fltValorTotalCarga := fltValorTotalCarga +
        qryTmpNfe.FieldByName('VLRCON').AsFloat;

      inc(intQtdeNfe);

      qryTmpNfe.Next;
    End;

    frxDanfe.Script.Variables['PESBRU'] := fltPesoBrutoTotal;
    frxDanfe.Script.Variables['VLRCON'] := fltValorTotalCarga;
    frxDanfe.Script.Variables['QTDNFE'] := intQtdeNfe;

    frxDanfe.Script.Variables['QTDCTE'] := qryTmpQtd.FieldByName('QTDCTE').AsString;

    If not blnDesignReport Then
    Begin

      If fEmptyStr(strImpressora) Then
      Begin
        strNomImp := fArqIniLocal(0, 'MDFE', 'IMPRESSORA', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
        If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
          If ConexaoBD.CarregarCFGSIS('SPOIMP') = 'S' then
            strNomImp := fArqIniLocal(0, 'MDFE', 'PONTO_IMPRESSAO', '', ConexaoBD.CarregarCFGSIS('PTNFCE') + '\opcoes_nfce.ini');
      End
      Else
        strNomImp := strImpressora;

      intQtdVias := 1;

      For intContador := 1 To intQtdVias Do
      Begin
        frxDanfe.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
        frxDanfe.PrintOptions.ShowDialog := False;

        If (frxDanfe.PrepareReport) Then
          pPrintReport('NFeImpressao', 'MDF-e ' + strNumeroManifesto, strNomImp, frxDanfe);

        If (intQtdVias > 1) Then
          Sleep(1000);
      End;
    End
    Else
      frxDanfe.DesignReport;

  Finally
    FreeAndNil(frxDanfe);
    FreeAndNil(frxDbDanfe);
    FreeAndNil(frxMdfAcess);
  End;

end;

end.
