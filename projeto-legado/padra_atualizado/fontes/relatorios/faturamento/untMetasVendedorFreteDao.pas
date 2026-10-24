unit untMetasVendedorFreteDao;

interface

uses untRelFatMetasVendedorFreteIntf, SysUtils, Variants, StdCtrls,
  DateUtils, StrUtils, Uni, DB, UniClientDataSet;

type
  TMetasVendedorFreteDao = class(TObject)
  private
    qryMetaVendedor: TUniQuery;
    qryRelatorio: TUniQuery;
    procedure pGetMetaPeriodo(objMetasVendedorFrete: IMetasVendedorFrete);

    procedure pCriaDataSetSintetico(objMetasVendedorFrete: IMetasVendedorFrete);
    procedure pCriaDataSetAnalitico(objMetasVendedorFrete: IMetasVendedorFrete);
  public
    function fGetTotalMeta(strCodVen, strDtaIni, strDtaFim: String): Double;
    function fGetDataSetRelatorio(objMetasVendedorFrete: IMetasVendedorFrete): Boolean;
  end;
  MetasVendedorFreteDao = TMetasVendedorFreteDao;

implementation

uses untRelFatMetasVendedorFreteTypes, untConstantes, untFuncoesFactory,
  untIFuncoes, untTypesSistema;

{ TMetasVendedorFreteDao }

function TMetasVendedorFreteDao.fGetDataSetRelatorio(
  objMetasVendedorFrete: IMetasVendedorFrete): Boolean;
  Var
    strSQL,
    strSQLTmp: String;
    strSelecao: String;
    ADay      : Word;
begin
  strSQL := '';

  qryMetaVendedor := fCriaQuery;
  qryRelatorio := fCriaQuery;
  Try
    If objMetasVendedorFrete.torOpcao = orAnalitico then
    Begin
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CONCAT(DET_CODVEN, "-", OPE_NOMOPE) AS NOMOPE, ';
      strSQL := strSQL + '   DET_CODVEN AS CODOPE, ';
      strSQL := strSQL + '   OPE_NOMOPE, ';
      strSQL := strSQL + '   DET_DTAENT, ';
      strSQL := strSQL + '   DET_CODEMP, ';
      strSQL := strSQL + '   DET_ESPDOC, ';
      strSQL := strSQL + '   DET_NUMDOC, ';
      strSQL := strSQL + '   SUM(DET_TOTFRE) AS VALFRE, ';
      strSQL := strSQL + '   DET_DTAENT AS MESANO, ';
      strSQL := strSQL + '   CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMDOC, ';
      strSQL := strSQL + '   IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", CONCAT(GER_CODCLI, "-", GER_NOMCON), CONCAT(GER_CODCLI, "-", CLI_NOMCLI)) AS NOMCLI, ';
      strSQL := strSQL + '   GER_TIPFRE AS TIPFRE, ';
      strSQL := strSQL + '   GER_VLRCON AS VLRCON, ';
      strSQL := strSQL + '   GER_VOLUME AS VOLUME, ';
      strSQL := strSQL + '   GER_PESBRU AS PESBRU ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   MOVDET ';
      strSQL := strSQL + ' INNER JOIN MOVGER ON (DET_SEQGER = MOVGER.AUTOINCREM) ';
      strSQL := strSQL + ' INNER JOIN CADOPE ON (OPE_CODOPE = DET_CODVEN) ';
      strSQL := strSQL + ' INNER JOIN CADCLI ON (CLI_CODCLI = GER_CODCLI) ';
      strSQL := strSQL + ' INNER JOIN CADMET ON (MET_MESANO = DATE_FORMAT(DET_DTAENT, "%m%Y") AND ';
      strSQL := strSQL + '                       MET_CODVEN = DET_CODVEN) ';
    End
    Else
    Begin
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   DATE_FORMAT(DET_DTAENT, "%m/%Y") AS MESANO, ';
      strSQL := strSQL + '   CONCAT(DET_CODVEN, "-", OPE_NOMOPE) AS NOMOPE, ';
      strSQL := strSQL + '   DET_CODVEN AS CODOPE, ';
      strSQL := strSQL + '   SUM(DET_TOTFRE) AS VALFRE ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   MOVDET ';
      strSQL := strSQL + ' INNER JOIN CADOPE ON (OPE_CODOPE = DET_CODVEN) ';
      strSQL := strSQL + ' INNER JOIN CADMET ON (MET_MESANO = DATE_FORMAT(DET_DTAENT, "%m%Y") AND ';
      strSQL := strSQL + '                       MET_CODVEN = DET_CODVEN) ';
    End;

    strSQL := strSQL + ' WHERE ';

    strSQL := strSQL + '  RIGHT(DET_CLAFIS, 3) <> "922" AND '; // Não deve apresentar entrega futura pois quando for entregue vai ser emitida outra nota e então ficaria duplicado

    strSQL := strSQL + '   DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '   DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '   DET_CODCLI NOT IN (' + fRetClientesFilial + ') AND ';
    strSQL := strSQL + '   ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ' ) ';

    strSQL := strSQL + fStrLocate(objMetasVendedorFrete.cmsCodVen.edtCodigo, objMetasVendedorFrete.cmsCodVen.arrSelecao, 'DET_CODVEN', 'CODVEN');

    If objMetasVendedorFrete.teoEmpOri = eoFaturamento Then
      strSQL := strSQL + fStrLocateEmpresa(objMetasVendedorFrete.cmsCodEmp.edtCodigo, objMetasVendedorFrete.cmsCodEmp.arrSelecao, 'DET_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + fStrLocateEmpresa(objMetasVendedorFrete.cmsCodEmp.edtCodigo, objMetasVendedorFrete.cmsCodEmp.arrSelecao, 'IF(DET_EMP_PD <> "", DET_EMP_PD, DET_CODEMP)', 'CODEMP');

    If Not fEmptyStr(TEdit(objMetasVendedorFrete.cmsCodDep.edtCodigo).Text) Then
      strSQL := strSQL + fStrLocate(objMetasVendedorFrete.cmsCodDep.edtCodigo, objMetasVendedorFrete.cmsCodDep.arrSelecao, 'OPE_CODDEP', 'CODDEP');

    strSQL := strSQL + ' AND ';
    strSQL := strSQL + cnsFiltroFFDVTR;

    If objMetasVendedorFrete.intDiaFat > 0 Then
    Begin
      strSQL := strSQL + ' DET_DTAENT > STR_TO_DATE(CONCAT(:DIAFAT, "/", :MESANOINI), "%d/%m/%Y") - INTERVAL 1 MONTH  AND ';
      strSQL := strSQL + ' DET_DTAENT <= STR_TO_DATE(CONCAT(:DIAFAT, "/", :MESANOFIN), "%d/%m/%Y") ';
    End
    Else
      strSQL := strSQL + ' DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    If objMetasVendedorFrete.ttvTipVen <> tvTodos Then
      strSQL := strSQL + ' AND OPE_INTEXT = :TIPVEN ';

    If objMetasVendedorFrete.torOpcao = orAnalitico then
    Begin
      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   DET_DTAENT, ';
      strSQL := strSQL + '   DET_CODEMP, ';
      strSQL := strSQL + '   DET_ESPDOC, ';
      strSQL := strSQL + '   DET_NUMDOC, ';
      strSQL := strSQL + '   DET_CODVEN  ';
    End
    Else
    Begin
      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '   DATE_FORMAT(DET_DTAENT, "%m%Y"), ';
      strSQL := strSQL + '   DET_CODVEN ';
    End;
    strSQL := strSQL + '   HAVING ';
    strSQL := strSQL + '     SUM(DET_TOTFRE) > 0 ';

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

    If objMetasVendedorFrete.torOpcao = orAnalitico Then
    Begin
      strSQLTmp := strSQL;

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   NOMOPE, ';
      strSQL := strSQL + '   CODOPE, ';
      strSQL := strSQL + '   MESANO, ';
      strSQL := strSQL + '   NUMDOC, ';
      strSQL := strSQL + '   NOMCLI, ';
      strSQL := strSQL + '   TIPFRE, ';
      strSQL := strSQL + '   VALFRE, ';
      strSQL := strSQL + '   VLRCON, ';
      strSQL := strSQL + '   VOLUME, ';
      strSQL := strSQL + '   PESBRU  ';
      strSQL := strSQL + ' FROM          ';
      strSQL := strSQL + '   (' + strSQLTmp + ') AS TAB ';
      strSQL := strSQL + ' GROUP BY      ';
      strSQL := strSQL + '   CODOPE,     ';
      strSQL := strSQL + '   DET_DTAENT, ';
      strSQL := strSQL + '   DET_CODEMP, ';
      strSQL := strSQL + '   DET_ESPDOC, ';
      strSQL := strSQL + '   DET_NUMDOC  ';
      strSQL := strSQL + ' ORDER BY      ';
      strSQL := strSQL + '   OPE_NOMOPE, ';
      strSQL := strSQL + '   DET_DTAENT, ';
      strSQL := strSQL + '   DET_CODEMP, ';
      strSQL := strSQL + '   DET_ESPDOC, ';
      strSQL := strSQL + '   DET_NUMDOC  ';
    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ADay := DaysInMonth(StrToDate('01/' + objMetasVendedorFrete.strMesFin));

      If objMetasVendedorFrete.intDiaFat > 0 Then
      Begin
        ParamByName('DIAFAT').AsInteger   := objMetasVendedorFrete.intDiaFat;
        ParamByName('MESANOINI').AsString := objMetasVendedorFrete.strMesIni;
        ParamByName('MESANOFIN').AsString := objMetasVendedorFrete.strMesFin;
      End
      Else
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDate('01/' + objMetasVendedorFrete.strMesIni);
        ParamByName('DTAFIN').AsDateTime := StrToDate(IntToStr(ADay) + '/' + objMetasVendedorFrete.strMesFin);
      End;

      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      strSelecao := '';
      pSetaParam(TEdit(objMetasVendedorFrete.cmsCodVen.edtCodigo).Text,
                 objMetasVendedorFrete.cmsCodVen.arrSelecao,
                 strSelecao,
                 'CODVEN',
                 qryRelatorio);
      objMetasVendedorFrete.cmsCodVen.strSelecao := strSelecao;

      strSelecao := '';
      pSetaParam(TEdit(objMetasVendedorFrete.cmsCodEmp.edtCodigo).Text,
                 objMetasVendedorFrete.cmsCodEmp.arrSelecao,
                 strSelecao,
                 'CODEMP',
                 qryRelatorio);
      objMetasVendedorFrete.cmsCodEmp.strSelecao := strSelecao;

      strSelecao := '';
      pSetaParam(TEdit(objMetasVendedorFrete.cmsCodDep.edtCodigo).Text,
                 objMetasVendedorFrete.cmsCodDep.arrSelecao,
                 strSelecao,
                 'CODDEP',
                 qryRelatorio);
      objMetasVendedorFrete.cmsCodDep.strSelecao := strSelecao;

      If objMetasVendedorFrete.ttvTipVen = tvInterno Then
        ParamByName('TIPVEN').AsString := 'I'
      Else If objMetasVendedorFrete.ttvTipVen = tvExterno Then
        ParamByName('TIPVEN').AsString := 'E';

      Open;

      Result := Not IsEmpty;

      If Result Then
      Begin
        If (objMetasVendedorFrete.torOpcao = orSintetico) Then
          pCriaDataSetSintetico(objMetasVendedorFrete)
        Else
          pCriaDataSetAnalitico(objMetasVendedorFrete);
      End;
    End;
  Finally
    FreeAndNil(qryMetaVendedor);
    FreeAndNil(qryRelatorio);
  End;
end;

function TMetasVendedorFreteDao.fGetTotalMeta(strCodVen, strDtaIni,
  strDtaFim: String): Double;
  Var
    strSQL : String;
    qryTmp : TUniQuery;
begin
  Result := 0;

  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   SUM(MET_TOTFRE) AS TOTAL ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADMET ';
  strSQL := strSQL + '  WHERE MET_CODVEN = :CODVEN AND ';
  strSQL := strSQL + '        MET_MESANO BETWEEN :PERINI AND :PERFIN ';

  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODVEN').AsString := strCodVen;
      ParamByName('PERINI').AsString := strDtaIni;
      ParamByName('PERFIN').AsString := strDtaFim;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('TOTAL').AsFloat;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fGetTotalMeta]');
  End;

  FreeAndNil(qryTmp);
end;

procedure TMetasVendedorFreteDao.pCriaDataSetAnalitico(
  objMetasVendedorFrete: IMetasVendedorFrete);
  procedure pCamposDataSet;
  Begin
    objMetasVendedorFrete.cdsRelatorio := TUniClientDataSet.Create(Nil);

    With objMetasVendedorFrete.cdsRelatorio, FieldDefs Do
    Begin
      With AddFieldDef Do
      Begin
        Name     := 'CODOPE';
        DataType := ftString;
        Size     := 3;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'NOMOPE';
        DataType := ftString;
        Size     := 100;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'MESANO';
        DataType := ftDateTime;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'NUMDOC';
        DataType := ftString;
        Size     := 19;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'NOMCLI';
        DataType := ftString;
        Size     := 100;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'TIPFRE';
        DataType := ftString;
        Size     := 6;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'VLRCON';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'VALFRE';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'VOLUME';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'PESBRU';
        DataType := ftFloat;
        Required := False;
      End;

      IndexFieldNames := 'NOMOPE;MESANO;NUMDOC';
      CreateDataSet;
      EmptyDataSet;
      Open;
    End;
  End;
begin
  pCamposDataSet;
  pGetMetaPeriodo(objMetasVendedorFrete);

  {****************************************}
  {* PREENCHE TODOS OS REGISTRO DE VENDAS *}
  {*************************************FC*}
  With objMetasVendedorFrete.cdsRelatorio Do
  Begin
    qryRelatorio.First;

    While Not qryRelatorio.Eof Do
    Begin
      Append;
      FieldByName('CODOPE').AsString   := qryRelatorio.FieldByName('CODOPE').AsString;
      FieldByName('NOMOPE').AsString   := qryRelatorio.FieldByName('NOMOPE').AsString;
      FieldByName('MESANO').AsDateTime := qryRelatorio.FieldByName('MESANO').AsDateTime;
      FieldByName('NUMDOC').AsString   := qryRelatorio.FieldByName('NUMDOC').AsString;
      FieldByName('NOMCLI').AsString   := qryRelatorio.FieldByName('NOMCLI').AsString;
      FieldByName('TIPFRE').AsString   := qryRelatorio.FieldByName('TIPFRE').AsString;
      FieldByName('VLRCON').AsFloat    := qryRelatorio.FieldByName('VLRCON').AsFloat;
      FieldByName('VALFRE').AsFloat    := qryRelatorio.FieldByName('VALFRE').AsFloat;
      FieldByName('VOLUME').AsFloat    := qryRelatorio.FieldByName('VOLUME').AsFloat;
      FieldByName('PESBRU').AsFloat    := qryRelatorio.FieldByName('PESBRU').AsFloat;
      Post;

      qryRelatorio.Next;
    End;

    qryRelatorio.Close;

    If Not qryMetaVendedor.IsEmpty Then
    Begin
      qryMetaVendedor.First;

      While Not qryMetaVendedor.Eof Do
      Begin
        If Not Locate('CODOPE', qryMetaVendedor.FieldByName('CODOPE').AsString, []) Then
        Begin
          Append;
          FieldByName('CODOPE').AsString   := qryMetaVendedor.FieldByName('CODOPE').AsString;
          FieldByName('NOMOPE').AsString   := qryMetaVendedor.FieldByName('NOMOPE').AsString;
          FieldByName('MESANO').AsDateTime := 0;
          FieldByName('NUMDOC').AsString   := '';
          FieldByName('NOMCLI').AsString   := 'NENHUMA VENDA ENCONTRADA';
          FieldByName('TIPFRE').AsString   := '';
          FieldByName('VLRCON').AsFloat    := 0;
          FieldByName('VALFRE').AsFloat    := 0;
          FieldByName('VOLUME').AsFloat    := 0;
          FieldByName('PESBRU').AsFloat    := 0;
          Post;
        End;

        qryMetaVendedor.Next;
      End;
    End;
  End;
end;

procedure TMetasVendedorFreteDao.pGetMetaPeriodo(objMetasVendedorFrete: IMetasVendedorFrete);
Var
  strSQL : String;
  strCodVen,
  strCodDep,
  strDtaIni,
  strDtaFin: String;
Begin
  strCodVen := '';
  strCodDep := '';

  If Not fEmptyStr(objMetasVendedorFrete.cmsCodVen.strSelecao) Then
    strCodVen := objMetasVendedorFrete.cmsCodVen.strSelecao
  Else If Not fEmptyStr(TEdit(objMetasVendedorFrete.cmsCodVen.edtCodigo).Text) Then
    strCodVen := TEdit(objMetasVendedorFrete.cmsCodVen.edtCodigo).Text;

  If Not fEmptyStr(objMetasVendedorFrete.cmsCodDep.strSelecao) Then
    strCodDep := objMetasVendedorFrete.cmsCodDep.strSelecao
  Else If Not fEmptyStr(TEdit(objMetasVendedorFrete.cmsCodDep.edtCodigo).Text) Then
    strCodDep := TEdit(objMetasVendedorFrete.cmsCodDep.edtCodigo).Text;

  strDtaIni := fRetSomenteNumeros(objMetasVendedorFrete.strMesIni);
  strDtaFin := fRetSomenteNumeros(objMetasVendedorFrete.strMesFin);

  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   MET_CODVEN AS CODOPE,  ';
  strSQL := strSQL + '   CONCAT(MET_CODVEN, "-", OPE_NOMOPE) AS NOMOPE,  ';
  strSQL := strSQL + '   MET_MESANO AS MESANO,  ';
  strSQL := strSQL + '   SUM(MET_TOTFRE) AS TOTMET ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADMET ';
  strSQL := strSQL + ' JOIN CADOPE ON (OPE_CODOPE = MET_CODVEN) ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CONCAT(RIGHT(MET_MESANO,4),LEFT(MET_MESANO,2),"01") BETWEEN  ';
  strSQL := strSQL + '   CONCAT(RIGHT(:PERINI,4),LEFT(:PERINI,2),"01") AND ';
  strSQL := strSQL + '   LAST_DAY(CONCAT(RIGHT(:PERFIN ,4),LEFT(:PERFIN ,2),"01")) ';

  If Not fEmptyStr(strCodVen) Then
    strSQL := strSQL + '  AND (LOCATE(MET_CODVEN, :CODVEN) > 0) ';

  If Not fEmptyStr(strCodDep) Then
    strSQL := strSQL + '  AND (LOCATE(OPE_CODDEP, :CODDEP) > 0) ';

  strSQL := strSQL + ' GROUP BY ';

  If objMetasVendedorFrete.torOpcao = orSintetico Then
    strSQL := strSQL + '   MET_MESANO, ';

  strSQL := strSQL + '   MET_CODVEN  ';

  strSQL := strSQL + ' HAVING ';
  strSQL := strSQL + '   SUM(MET_TOTFRE) > 0 ';

  Try
    With qryMetaVendedor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

     If Not fEmptyStr(strCodVen) Then
        ParamByName('CODVEN').AsString := strCodVen;

     If Not fEmptyStr(strCodDep) Then
        ParamByName('CODDEP').AsString := strCodDep;

      ParamByName('PERINI').AsString := strDtaIni;
      ParamByName('PERFIN').AsString := strDtaFin;

      Open;
    End;
  Except
   On E: Exception Do
      pMensagensErro(E.Message, '[pGetMetaPeriodo]');
  End;
End;

procedure TMetasVendedorFreteDao.pCriaDataSetSintetico(objMetasVendedorFrete: IMetasVendedorFrete);
  procedure pCamposDataSet;
  Begin
    objMetasVendedorFrete.cdsRelatorio := TUniClientDataSet.Create(Nil);

    With objMetasVendedorFrete.cdsRelatorio, FieldDefs Do
    Begin
      With AddFieldDef Do
      Begin
        Name     := 'CODOPE';
        DataType := ftString;
        Size     := 3;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'NOMOPE';
        DataType := ftString;
        Size     := 100;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'MESANO';
        DataType := ftString;
        Size     := 7;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'TOTMET';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'VALFRE';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'PERATI';
        DataType := ftFloat;
        Required := False;
      End;

      With AddFieldDef Do
      Begin
        Name     := 'ACONCL';
        DataType := ftFloat;
        Required := False;
      End;

      IndexFieldNames := 'NOMOPE;MESANO';
      CreateDataSet;
      EmptyDataSet;
      Open;
    End;
  End;
begin
  pCamposDataSet;
  pGetMetaPeriodo(objMetasVendedorFrete);

  {*****************************************}
  {* PREENCHENDO TODAS AS METAS CADASTADAS *}
  {**************************************FC*}
  With objMetasVendedorFrete.cdsRelatorio Do
  Begin
    If Not qryMetaVendedor.IsEmpty Then
    Begin
      qryMetaVendedor.First;

      While Not qryMetaVendedor.Eof Do
      Begin
        Append;
        FieldByName('CODOPE').AsString := qryMetaVendedor.FieldByName('CODOPE').AsString;
        FieldByName('NOMOPE').AsString := qryMetaVendedor.FieldByName('NOMOPE').AsString;
        FieldByName('MESANO').AsString := Copy(qryMetaVendedor.FieldByName('MESANO').AsString, 1, 2) + '/' + Copy(qryMetaVendedor.FieldByName('MESANO').AsString, 3, 4);
        FieldByName('VALFRE').AsFloat  := 0;
        FieldByName('TOTMET').AsFloat  := qryMetaVendedor.FieldByName('TOTMET').AsFloat;
        FieldByName('PERATI').AsFloat  := 0;
        FieldByName('ACONCL').AsFloat  := qryMetaVendedor.FieldByName('TOTMET').AsFloat;
        Post;

        qryMetaVendedor.Next;
      End;
    End;

    {*******************************************************************}
    {* PREENCHENDO OS FRETES E CALCULANDO OS VALORES DE % E A CONCLUIR *}
    {****************************************************************FC*}
    qryRelatorio.First;

    While Not qryRelatorio.Eof Do
    Begin
      If Not Locate('CODOPE;MESANO',
                    VarArrayOf([qryRelatorio.FieldByName('CODOPE').AsString, qryRelatorio.FieldByName('MESANO').AsString]),
                    []) Then
      Begin
        Append;
        FieldByName('CODOPE').AsString := qryRelatorio.FieldByName('CODOPE').AsString;
        FieldByName('NOMOPE').AsString := qryRelatorio.FieldByName('NOMOPE').AsString;
        FieldByName('MESANO').AsString := qryRelatorio.FieldByName('MESANO').AsString;
        FieldByName('VALFRE').AsFloat  := qryRelatorio.FieldByName('VALFRE').AsFloat;
        FieldByName('TOTMET').AsFloat  := 0;
        FieldByName('PERATI').AsFloat  := 0;
        FieldByName('ACONCL').AsFloat  := - FieldByName('VALFRE').AsFloat;
        Post;
      End
      Else
      Begin
        Edit;
        FieldByName('VALFRE').AsFloat := qryRelatorio.FieldByName('VALFRE').AsFloat;
        FieldByName('PERATI').AsFloat := (FieldByName('VALFRE').AsFloat / FieldByName('TOTMET').AsFloat) * 100;

        FieldByName('ACONCL').AsFloat := FieldByName('TOTMET').AsFloat - FieldByName('VALFRE').AsFloat;
      End;

      qryRelatorio.Next;
    End;

    qryRelatorio.Close;
  End;
end;

end.
