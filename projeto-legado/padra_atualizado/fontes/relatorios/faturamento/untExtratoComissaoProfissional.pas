unit untExtratoComissaoProfissional;

interface

uses Forms, Classes, SysUtils, StrUtils, frxClass, frxDBSet, frxRich, Uni,
  untFastPrintEditor, untFuncoesSimples, untIFastPrint, untTypesSistema,
  System.Generics.Collections, EditFocus;

Type
  TExtratoComissaoProfissional = class(TInterfacedObject, IFastPrintFile)
    private
      FCodPro: String;
      FCodAti: String;
      FCodCli: String;
      FCodRed: String;
      FCodEmp: String;
      FNomImp: String;
      FTipImp: String;
      FTipFil: String;
      FObjCodPro: TObject;
      FObjCodAti: TObject;
      FObjCodCli: TObject;
      FObjCodRed: TObject;
      FObjCodEmp: TObject;
      FArrCodPro: TConsultasArray;
      FArrCodAti: TConsultasArray;
      FArrCodCli: TConsultasArray;
      FArrCodRed: TConsultasArray;
      FArrCodEmp: TConsultasArray;
      FCalcul: Integer;
      FOrdena: Integer;
      FModDes: Boolean;
      FVlrCom: Double;
      FExtrat: TUniQuery;
      FEmpres: TUniQuery;
      FDtaIni: TDateTime;
      FDtaFin: TDateTime;
      FDtaBai: TDateTime;
      FDtaBaf: TDateTime;
      FDicVar: TDictionary<String,Variant>;

      FListaFuncoes : TStringList;
      FDataSetCadEmp: TfrxDBDataset;
      FDataSetExtrat: TfrxDBDataset;
      FArrDBDataSet : TArrFrxDBDataSet;
      FObjectWord   : TfrxRichObject;

      VS_strTCoProInterna: String;

      procedure pDefineFilaImpressao(blnConfig: Boolean);
      procedure pCarregaListaFuncoes;
      function  fGetIsEmpty: Boolean;
      function  fOnUserFunctionEvent(const MethodName: String; var Params: Variant): Variant;
      function  fAjustaSQLParaDataFaturamento(strSQL: String): String;
      procedure pIniciaObjetos;
    protected
      function  fGetKey: String;
      function  fGetName: String;
      function  fGetDBDataSets: TArrFrxDBDataSet;
      function  fGetUserDataSets: TArrFrxUserDataSet;
      function  fGetFunctionsList: TStringList;
      function  fGetVariables: TDictionary<String,Variant>;
      function  fGetUserFunction: TfrxUserFunctionEvent;
      function  fPrepareDataSetsAndVariables: Boolean;
      function  fGetPrinterName: String;
      function  fGetFastType: TFastFileType;
      function  fRetornaSaldoInicial(strCodPro: String): Double;
      procedure pConfigTypeAndPrinterName;
    public
      constructor Create;
      constructor CreateInstance(dtaEntIni,
                                 dtaEntFin,
                                 dtaBaiIni,
                                 dtaBaiFin: TDateTime;
                                 objCodPro,
                                 objCodAti,
                                 objCodCli,
                                 objCodRed,
                                 objCodEmp: TObject;
                                 arrCodPro,
                                 arrCodAti,
                                 arrCodCli,
                                 arrCodRed,
                                 arrCodEmp: TConsultasArray;
                                 fltVlrCom: Double;
                                 intCalcul: Integer;
                                 strTipFil: String;
                                 strTCoPro: String;
                                 intOrdena: Integer);
      destructor  Destroy; override;
      property    IsEmpty: Boolean read fGetIsEmpty;
  end;

Const
  FILA_IMPRESSAO_EXTRATO = 'frmRelFatExtratoProfissional';

implementation

uses untCfgRel, untFuncoesConsulta, Data.DB;

{ TExtratoComissaoProfissional }

constructor TExtratoComissaoProfissional.Create;
begin
  FModDes := True;
  pIniciaObjetos;
  VS_strTCoProInterna := fCfgSis('TCOPRO');
end;

constructor TExtratoComissaoProfissional.CreateInstance(dtaEntIni,
                                                        dtaEntFin,
                                                        dtaBaiIni,
                                                        dtaBaiFin: TDateTime;
                                                        objCodPro,
                                                        objCodAti,
                                                        objCodCli,
                                                        objCodRed,
                                                        objCodEmp: TObject;
                                                        arrCodPro,
                                                        arrCodAti,
                                                        arrCodCli,
                                                        arrCodRed,
                                                        arrCodEmp: TConsultasArray;
                                                        fltVlrCom: Double;
                                                        intCalcul: Integer;
                                                        strTipFil: String;
                                                        strTCoPro: String;
                                                        intOrdena: Integer);
begin
  If fEmptyStr(strTCoPro) Then
    strTCoPro := fCfgSis('TCOPRO');

  VS_strTCoProInterna := strTCoPro;

  FModDes := False;
  FDtaIni := dtaEntIni;
  FDtaFin := dtaEntFin;
  FDtaBai := dtaBaiIni;
  FDtaBaf := dtaBaiFin;
  FObjCodPro := objCodPro;
  FObjCodAti := objCodAti;
  FObjCodCli := objCodCli;
  FObjCodRed := objCodRed;
  FObjCodEmp := objCodEmp;
  FArrCodPro := arrCodPro;
  FArrCodAti := arrCodAti;
  FArrCodCli := arrCodCli;
  FArrCodRed := arrCodRed;
  FArrCodEmp := arrCodEmp;
  FCalcul := intCalcul;
  FOrdena := intOrdena;
  FVlrCom := fltVlrCom;
  FTipFil := strTipFil;
  pIniciaObjetos;
end;

destructor TExtratoComissaoProfissional.Destroy;
begin
  FreeAndNil(FExtrat);
  FreeAndNil(FDataSetExtrat);
  FreeAndNil(FEmpres);
  FreeAndNil(FDataSetCadEmp);
  FreeAndNil(FDicVar);
  FreeAndNil(FListaFuncoes);
  FreeAndNil(FObjectWord);  
  inherited;
end;

function TExtratoComissaoProfissional.fAjustaSQLParaDataFaturamento(
  strSQL: String): String;
begin
  Result := AnsiReplaceStr(strSQL, 'JOINMOVGER', 'JOIN MOVGER ON GER_NUMDOC = COM_NUMDOC AND ' +
                                                 '               GER_ESPDOC = COM_ESPDOC AND ' +
                                                 '               GER_CODEMP = COM_CODEMP AND ' +
                                                 '               GER_CODCLI = COM_CODCLI ');
  Result := AnsiReplaceStr(Result, 'CS.COM_DTACAD < :DTAINI', 'GER_DTAFAT < :DTAINI');
  Result := AnsiReplaceStr(Result, 'COM_DTACAD BETWEEN', 'GER_DTAFAT BETWEEN');
end;

function TExtratoComissaoProfissional.fGetDBDataSets: TArrFrxDBDataSet;
begin
  Result := FArrDBDataSet;
end;

function TExtratoComissaoProfissional.fGetFastType: TFastFileType;
begin
  If (FTipImp <> 'M') Then
    Result := ffLaser
  Else
    Result := ffMatrix;
end;

function TExtratoComissaoProfissional.fGetFunctionsList: TStringList;
begin
   Result := FListaFuncoes;
end;

function TExtratoComissaoProfissional.fGetIsEmpty: Boolean;
begin
  Result := FExtrat.IsEmpty;
end;

function TExtratoComissaoProfissional.fGetKey: String;
begin
  Result := 'EXTPRO';
end;

function TExtratoComissaoProfissional.fGetName: String;
begin
  Result := 'EXTRATO DE COMISSAO DO PROFISSIONAL';
end;

function TExtratoComissaoProfissional.fGetPrinterName: String;
begin
  Result := FNomImp;
end;

function TExtratoComissaoProfissional.fGetUserDataSets: TArrFrxUserDataSet;
begin
  
end;

function TExtratoComissaoProfissional.fGetUserFunction: TfrxUserFunctionEvent;
begin
  Result := fOnUserFunctionEvent;
end;

function TExtratoComissaoProfissional.fGetVariables: TDictionary<String,Variant>;
begin
  Result := FDicVar;
end;

function TExtratoComissaoProfissional.fOnUserFunctionEvent(
  const MethodName: String; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fRetornaSaldoInicial') Then
    Result := fRetornaSaldoInicial(Params[0]);
end;

function TExtratoComissaoProfissional.fPrepareDataSetsAndVariables: Boolean;
  Var
    strSQL       : String;
    strSQLFF     : String;
    strSQLTRDV   : String;
    strSQLPrin   : String;
    blnComProFF  : Boolean;
    blnComProTRDV: Boolean;

  procedure pCarregaVariaveis;
    Var
      strArqRtf: String;
  begin

    strArqRtf := ExtractFilePath(Application.ExeName) + 'EXTRATO_PROFISSIONAL.rtf';
    If FileExists(strArqRtf) Then
      FDicVar.AddOrSetValue('ARQRTF', strArqRtf)
    Else
      FDicVar.AddOrSetValue('ARQRTF', '');

    If (VS_strTCoProInterna = '3') Then
    Begin
      FDicVar.AddOrSetValue('EXIPON', 'S');
      FDicVar.AddOrSetValue('SALINI', 'SALDO INICIAL PONTOS');
      FDicVar.AddOrSetValue('TOTAL', 'TOTAL DE PONTOS CONQUISTADOS');
    End
    Else
    Begin
      FDicVar.AddOrSetValue('EXIPON', 'N');
      FDicVar.AddOrSetValue('SALINI', 'SALDO INICIAL VENDA');
      FDicVar.AddOrSetValue('TOTAL', 'TOTAL');
    End;

      If Not(FormatDateTime('dd/mm/yyyy', FDtaIni) = '30/12/1899') Then
        FDicVar.AddOrSetValue('PERIOD', FormatDateTime('dd/mm/yyyy', FDtaIni) + ' A ' + FormatDateTime('dd/mm/yyyy', FDtaFin));

      If Not(FormatDateTime('dd/mm/yyyy', FDtaBai) = '30/12/1899') Then
        FDicVar.AddOrSetValue('PERIOD', FormatDateTime('dd/mm/yyyy', FDtaBai) + ' A ' + FormatDateTime('dd/mm/yyyy', FDtaBaf));

      If (FormatDateTime('dd/mm/yyyy', FDtaBai) = '30/12/1899') and (FormatDateTime('dd/mm/yyyy', FDtaIni) = '30/12/1899') Then
        FDicVar.AddOrSetValue('PERIOD',' TODO PERÍODO ');
  end;

  procedure pCarregaDadosEmpresa;
  begin
    fCadEmp('NOMEMP', FEmpres);
  end;

begin
  pCarregaVariaveis;
  pCarregaDadosEmpresa;
  pCarregaListaFuncoes;

  blnComProFF   := False;
  blnComProTRDV := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COM_DTACAD, ';
  strSQL := strSQL + '  COM_NUMDOC, ';
  strSQL := strSQL + '  COM_ESPDOC, ';
  strSQL := strSQL + '  COM_CODEMP, ';
  strSQL := strSQL + '  COM_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CONCAT(COM_CODCLI,"-", CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '  COM_CODPRO, ';
  strSQL := strSQL + '  DIV_NOMDIV, ';
  strSQL := strSQL + '  DIV_PERCOM, ';
  strSQL := strSQL + '  (SELECT ATI_DESATI FROM CADATI WHERE ATI_CODATI = DIV_CODATI LIMIT 1) AS ATI_DESATI, ';
  strSQL := strSQL + '  IF(COM_CREDEB = "C", COM_VRVEND, -COM_VRVEND) AS COM_VRVEND, ';

  If (FCalcul = 1) Then
    strSQL := strSQL + '  IF(COM_CREDEB = "C", COM_VRCOMI, -COM_VRCOMI) AS COM_VRCOMI, '
  Else
    strSQL := strSQL + '  IF(COM_CREDEB = "C", (IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)), -(IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI))) AS COM_VRCOMI, ';

  strSQL := strSQL + '  COM_DTABAI, ';
  strSQL := strSQL + '  COM_CREDEB, ';
  strSQL := strSQL + '  COM_OBSERV  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  COMPRO      ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = COM_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADDIV ON DIV_CODDIV = COM_CODPRO ';

  strSQL := strSQL + '  JOINMOVGER ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL  + ' IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(VS_strTCoProInterna) +
                                       ', COM_TCOPRO) = ' + QuotedStr(VS_strTCoProInterna) + ' AND ';

  If (FTipFil = 'P') Then
    strSQL    := strSQL    + '  COM_DTABAI IS NULL AND '
  Else If (FTipFil = 'B') Then
    strSQL    := strSQL    + '  COM_DTABAI IS NOT NULL AND ';

  strSQL := strSQL + '  TRUE ';

  If (FDtaIni > 0) Then
    strSQL := strSQL + '  AND COM_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If (FDtaBai > 0) Then
    strSQL := strSQL + '  AND COM_DTABAI BETWEEN :DTABAI AND :DTABAF ';

  strSQL := strSQL + fStrLocate(FObjCodCli, FArrCodCli, 'COM_CODCLI', 'CODCLI');

  strSQL := strSQL + fStrLocate(FObjCodPro, FArrCodPro, 'COM_CODPRO', 'CODPRO');

  strSQL := strSQL + fStrLocate(FObjCodAti, FArrCodAti, 'DIV_CODATI', 'CODATI');

  strSQL := strSQL + fStrLocate(FObjCodRed, FArrCodRed, 'CLI_CODRED', 'CODRED');

  If Not fEmptyStr(TEditFocus(FObjCodEmp).Text) Then
    strSQL := strSQL + fStrLocate(FObjCodEmp, FArrCodEmp, 'COM_CODEMP', 'CODEMP')
  Else
    strSQL := strSQL + '  AND LOCATE(COM_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  strSQLFF   := fAjustaSQLParaDataFaturamento(strSQL);

  strSQLTRDV := strSQLFF;
  strSQLFF   := strSQLFF   + ' AND COM_ESPDOC = "FF" ';
  strSQLTRDV := strSQLTRDV + ' AND COM_ESPDOC IN ("TR", "DV") ';

  strSQL   := AnsiReplaceStr(strSQL, 'JOINMOVGER', '');

  If (fCfgSis('CPROFF') = '2') Then
  Begin
    blnComProFF := True;
    strSQL      := strSQL + ' AND IFNULL(COM_ESPDOC, "") <> "FF" ';
  End;

  If (fCfgSis('CPROTR') = '2') Then
  Begin
    blnComProTRDV := True;
    strSQL := strSQL + ' AND IFNULL(COM_ESPDOC, "") NOT IN ("TR", "DV") ';
  End;

  If (blnComProFF) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLFF;

  If (blnComProTRDV) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLTRDV;

  strSQLPrin := strSQL;

  strSQL := 'SELECT '        +
            '  COM_CODPRO, ' +
            '  DIV_NOMDIV, ' +
            '  DIV_PERCOM, ' +
            '  ATI_DESATI, ';

  if (FOrdena <> 1) then
     strSQL := strSQL +
            '  fRetSalIniExtratoProfissional(COM_CODPRO, ' + QuotedStr(FormatDateTime('yyyy-mm-dd', FDtaIni)) + ', ' + IntToStr(FCalcul) + ', ' + QuotedStr(FCodEmp) + ', ' + QuotedStr(VS_strCodEmp) + ', ' + QuotedStr(strEmpAcessoUsuarioLogado) + ', ' + QuotedStr(VS_strTCoProInterna) + ') AS SALINI, ';

  strSQL := strSQL +
            '  SUM(COM_VRVEND) COM_VRVEND, ' +
            '  SUM(COM_VRCOMI) COM_VRCOMI, ' +
            '  CONCAT(COM_CODPRO, " ", DIV_NOMDIV, " - ", ATI_DESATI) AS NOMPRO ' +
            '  FROM (' + strSQLPrin + ') AS TBL ';

  strSQL := strSQL + 'GROUP BY     ';
  strSQL := strSQL + '  COM_CODPRO ';
  strSQL := strSQL + 'HAVING       ';
  strSQL := strSQL + '  SUM(COM_VRCOMI) > :VLRCOM   ';

  strSQL := 'SELECT '        +
            '  COM_CODPRO, ' +
            '  DIV_NOMDIV, ' +
            '  DIV_PERCOM, ' +
            '  ATI_DESATI, ' +
            '  COM_VRVEND, ' +
            '  COM_VRCOMI, ' +
            '  NOMPRO      ' +
            '  FROM (' + strSQL + ') AS TBL ';

  strSQL := strSQL + 'ORDER BY     ';

  If (FOrdena = 1) Then
    strSQL := strSQL + '  DIV_NOMDIV '
  Else If (FOrdena = 2) Then
    strSQL := strSQL + '  (IFNULL(COM_VRCOMI,0) + IFNULL(SALINI,0)) '
  Else
    strSQL := strSQL + '  (IFNULL(COM_VRCOMI,0) + IFNULL(SALINI,0)) DESC ';

  With FExtrat, SQL Do
  Begin
    Close;
    Text := strSQL;

    If (FDtaIni > 0) Then
    Begin
      ParamByName('DTAINI').AsDate := FDtaIni;
      ParamByName('DTAFIN').AsDate := FDtaFin;
    End;
    If (FDtaBai > 0) Then
    Begin
      ParamByName('DTABAI').AsDate := FDtaBai;
      ParamByName('DTABAF').AsDate := FDtaBaf;
    End;

    pSetaParam(TEditFocus(FObjCodCli).Text, FArrCodCli, FCodCli, 'CODCLI', FExtrat);

    pSetaParam(TEditFocus(FObjCodPro).Text, FArrCodPro, FCodPro, 'CODPRO', FExtrat);

    pSetaParam(TEditFocus(FObjCodAti).Text, FArrCodAti, FCodAti, 'CODATI', FExtrat);

    pSetaParam(TEditFocus(FObjCodRed).Text, FArrCodRed, FCodRed, 'CODRED', FExtrat);

    If Not fEmptyStr(TEditFocus(FObjCodEmp).Text) Then
      pSetaParam(TEditFocus(FObjCodEmp).Text, FArrCodEmp, FCodEmp, 'CODEMP', FExtrat);

    ParamByName('VLRCOM').AsFloat := FVlrCom;

    Open;
    Result := Not IsEmpty;
  End;
end;

procedure TExtratoComissaoProfissional.pCarregaListaFuncoes;
begin
  FListaFuncoes.Clear;
  FListaFuncoes.Add('function fRetornaSaldoInicial(strCodPro: String): Double;');
end;

procedure TExtratoComissaoProfissional.pConfigTypeAndPrinterName;
begin
  pDefineFilaImpressao(True);
end;

procedure TExtratoComissaoProfissional.pDefineFilaImpressao(blnConfig: Boolean);
  Var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, FILA_IMPRESSAO_EXTRATO);

  If blnConfig Then
    pConfigurarFilaDeImpressao(qryCfgRel, FILA_IMPRESSAO_EXTRATO);

  FTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(FTipImp) Then
    FTipImp := 'J';

  FreeAndNil(qryCfgRel);
end;

procedure TExtratoComissaoProfissional.pIniciaObjetos;
begin
  FDicVar                := TDictionary<String,Variant>.Create;
  FListaFuncoes          := TStringList.Create;
  FExtrat                := fCriaQuery(nil);
  FDataSetExtrat         := TfrxDBDataset.Create(nil);
  FDataSetExtrat.Name    := 'frxDataSetExtrato';
  FDataSetExtrat.DataSet := FExtrat;

  FEmpres                := fCriaQuery(nil);
  FDataSetCadEmp         := TfrxDBDataset.Create(nil);
  FDataSetCadEmp.Name    := 'frxDataSetEmpresa';
  FDataSetCadEmp.DataSet := FEmpres;

  SetLength(FArrDBDataSet, 2);
  FArrDBDataSet[0]       := FDataSetCadEmp;
  FArrDBDataSet[1]       := FDataSetExtrat;

  FObjectWord            := TfrxRichObject.Create(nil);

  pDefineFilaImpressao(False);
end;

function TExtratoComissaoProfissional.fRetornaSaldoInicial(strCodPro: String): Double;
  Var
    strSQL       : String;
    strSQLFF     : String;
    strSQLTRDV   : String;
    blnComProFF  : Boolean;
    blnComProTRDV: Boolean;
    qryAux: TUniQuery;
begin
  blnComProFF   := False;
  blnComProTRDV := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If (FCalcul = 1) Then
    strSQL := strSQL + '  SUM(IF(COM_CREDEB = "C", COM_VRCOMI, -COM_VRCOMI)) AS SALCOM, '
  Else
    strSQL := strSQL + '  SUM(IF(COM_CREDEB = "C", (IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)), -(IF(COM_VRVEND > 0, (COM_VRVEND/100)*DIV_PERCOM, COM_VRCOMI)))) AS SALCOM, ';

  strSQL := strSQL + '  SUM(IF(CS.COM_CREDEB = "C", CS.COM_VRVEND, -CS.COM_VRVEND)) SALVEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  COMPRO AS CS ';

  If (FCalcul = 1) Then
    strSQL := strSQL + '  LEFT JOIN CADDIV ON DIV_CODDIV = COM_CODPRO '
  Else
    strSQL := strSQL + '  INNER JOIN CADDIV ON DIV_CODDIV = COM_CODPRO '; //PARA PEGAR O DIV_PERCOM

  strSQL := strSQL + '  JOINMOVGER ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL  + ' IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(VS_strTCoProInterna) +
                                       ', COM_TCOPRO) = ' + QuotedStr(VS_strTCoProInterna) + ' AND ';

  strSQL := strSQL + '  COM_DTABAI IS NULL AND ';
  strSQL := strSQL + '  CS.COM_DTACAD < :DTAINI AND ';

  strSQL := strSQL + '  CS.COM_CODPRO = :CODPRO ';

  If Not fEmptyStr(FCodEmp) Then
    strSQL    := strSQL    + '  AND COM_CODEMP = :CODEMP '
  Else
    strSQL    := strSQL    + '  AND LOCATE(COM_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  strSQLFF   := fAjustaSQLParaDataFaturamento(strSQL);

  strSQLTRDV := strSQLFF;

  strSQLFF   := strSQLFF + ' AND COM_ESPDOC = "FF" ';
  strSQLTRDV := strSQLTRDV + ' AND COM_ESPDOC IN ("TR", "DV") ';

  strSQL := AnsiReplaceStr(strSQL, 'JOINMOVGER', '');

  If (fCfgSis('CPROFF') = '2') Then
  Begin
    blnComProFF := True;
    strSQL      := strSQL + ' AND IFNULL(COM_ESPDOC, "") <> "FF" ';
  End;

  If (fCfgSis('CPROTR') = '2') Then
  Begin
    blnComProTRDV := True;
    strSQL := strSQL + ' AND IFNULL(COM_ESPDOC, "") NOT IN ("TR", "DV") ';
  End;

  If (blnComProFF) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLFF + ' GROUP BY COM_NUMDOC, COM_ESPDOC, COM_CODEMP, COM_CODCLI ';

  If (blnComProTRDV) Then
    strSQL := strSQL + ' UNION ALL ' + strSQLTRDV + ' GROUP BY COM_NUMDOC, COM_ESPDOC, COM_CODEMP, COM_CODCLI ';

  strSQL := 'SELECT ' +
            '  SUM(IFNULL(SALCOM, 0)) AS SALCOM, ' +
            '  SUM(IFNULL(SALVEN, 0)) AS SALVEN ' +
            'FROM (' + strSQL + ') AS TBL ';

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add(strSQL);
  qryAux.ParamByName('DTAINI').AsDateTime := FDtaIni;
  qryAux.ParamByName('CODPRO').AsString   := strCodPro;

  If Not fEmptyStr(FCodEmp) Then
    qryAux.ParamByName('CODEMP').AsString := FCodEmp;

  qryAux.Open;

  Result := qryAux.FIeldByName('SALCOM').AsFloat;

  qryAux.Close;
  FreeAndNil(qryAux);
end;

end.
