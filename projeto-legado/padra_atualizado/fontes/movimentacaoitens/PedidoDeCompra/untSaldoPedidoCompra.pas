unit untSaldoPedidoCompra;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  cxProgressBar,
{$ENDIF}
  DB, Uni, System.SysUtils, System.DateUtils;

Type
  TSaldoPedido = Class

  Public
     strCodIte: String;

     Class Function fAtualizaSaldoPedidoCompraGeralPrg(prgProgresso: TCxProgressBar): Boolean;

     Function fGeraGirIte(prgProgresso: TcxProgressBar): Boolean;

  End;

  procedure pAjustaPCG_PEDLIB(AQry: TUniQuery; strForFil: String);

  procedure pGeraGirIte(strCodIte: String); Overload;

  Procedure pGeraGirIte(strCodIte, strCodEmp: String); Overload;

  Procedure pIncluiRegistroSaldoPedidoCompra(strCodIte, strCodEmp: String);

  Function fAtualizaSaldoPedidoCompraGeral: Boolean;

  function fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): String;

  function fRetQuantPendentePedidoCompra(strCodIte, strCodSim, strEmpresas: String; blnFiltraTE: Boolean): Double;

  function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean; strSQLCodSim: String = ''): String;

  function fSQLQuantidadeReqPendente(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean; strSQLCodSim: String = ''): String;

  function fSQLQuantidadePendenteCompraGarantia(strSQLCodIte, strSQLCodEmp: String; strSQLCodSim: String = ''): String;

  function fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String;

  function fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC: String;
                                              strEmpSubtraiPedTransf: String = ''): String;

  Function fRetCampoAtualizaSaldoPedidoCompra(strAutPcg,
                                              strNumPed,
                                              strCodEmp: String;
                                              blnLibPcm: Boolean;
                                              strForFil: String): String; OverLoad;

  Function fRetCampoAtualizaSaldoPedidoCompra(blnLiberado: Boolean;
                                              strCodFor,
                                              strForFil: String): String; OverLoad;

  Function fSQLEstornaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer): String;
  Procedure pEstornaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer);

  Procedure pAtualizaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer);
  Function fSQLAtualizaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer): String;

  Procedure pEstornaSaldoPedidoCompra(strNumPed, strEspPed, strEmpPed: String; strCodIte: String = '');
  Procedure pAtualizaSaldoPedidoCompra(strNumPed, strEspPed, strEmpPed: String; strCodIte: String = '');

implementation

uses
{$IFNDEF LINUX}
  Forms, untGravando, untFuncoesSimples,
{$ELSE}
{$ENDIF}
  untFuncoesGenerica;

Function fRetCampoAtualizaSaldoPedidoCompra(strAutPcg,
                                            strNumPed,
                                            strCodEmp: String;
                                            blnLibPcm: Boolean;
                                            strForFil: String): String; OverLoad;
  Var
    qryIteger: TUniQuery;
    strSQL: String;
Begin
  qryIteger := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT        ';
  strSQL := strSQL + '   PCG_PEDLIB, ';
  strSQL := strSQL + '   PCG_CODFOR, ';
  strSQL := strSQL + '   AUTOINCREM  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   PCMGER      ';

  strSQL := strSQL + ' WHERE      ';

  If fEmptyStr(strAutPcg) Then
  Begin
    strSQL := strSQL + '      PCG_ESPDOC = "PD"    ';
    strSQL := strSQL + '  AND PCG_NUMPED = :NUMPED ';
    strSQL := strSQL + '  AND PCG_CODEMP = :CODEMP ';

    qryIteger.SQL.Text := strSQL;

    qryIteger.ParamByName('NUMPED').AsString := strNumPed;
    qryIteger.ParamByName('CODEMP').AsString := strCodEmp;

  End Else
  Begin
    strSQL := strSQL + '   AUTOINCREM = :AUTPCG ';

    qryIteger.SQL.Text := strSQL;

    qryIteger.ParamByName('AUTPCG').AsString := strAutPcg;
  End;

  qryIteger.Open;

  pAjustaPCG_PEDLIB(qryIteger, strForFil);

  qryIteger.Close;
  qryIteger.Open;

  Result := fRetCampoAtualizaSaldoPedidoCompra(Not (blnLibPcm And qryIteger.FieldByName('PCG_PEDLIB').IsNull),
                                               qryIteger.FieldByName('PCG_CODFOR').AsString,
                                               strForFil);
  FreeAndNil(qryIteger);
End;

procedure pAjustaPCG_PEDLIB(AQry: TUniQuery; strForFil: String);
var QryCommand: TUniQuery;
begin
  QryCommand := fCriaQuery;
  Try
    If Pos(AQry.FieldByName('PCG_CODFOR').AsString, strForFil) > 0 Then
      If AQry.FieldByName('PCG_PEDLIB').IsNull Then
        If fCfgSis('LIBPCM') = 'S'  Then
          If (fCfgSis('LBTRAU') = 'S') Then
          begin
            QryCommand.SQL.Text := 'UPDATE PCMGER SET PCG_PEDLIB = "' + strLoginUsuarioLogado + FormatDateTime('ddmmyyyy', VS_Date) + FormatDateTime('hhmmss', fTime()) + '"' +
                                    ' WHERE AUTOINCREM = "'+AQry.FieldByName('AUTOINCREM').AsString+'"';

            QryCommand.ExecSQL;
          End;
  Finally
    FreeAndNil(QryCommand);
  End;
End;

Function fRetCampoAtualizaSaldoPedidoCompra(blnLiberado: Boolean;
                                            strCodFor,
                                            strForFil: String): String; OverLoad;
  Var
    blnTE: Boolean;
Begin
  blnTE := Pos(strCodFor, strForFil) > 0;

  If blnLiberado Then
  Begin

    If blnTE Then
      Result := 'SAL_FILLIB'
    Else
      Result := 'SAL_NFILIB';

  End Else
  Begin

    If blnTE Then
      Result := 'SAL_FILNLI'
    Else
      Result := 'SAL_NFINLI';

  End;
End;

function fSQLQuantidadePendenteCompraTE(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean): String;
Begin
  Result := '';
  Result := Result + ' IFNULL((SELECT ';

  Result := Result + '   SUM( ';

  Result := Result + '  SAL_FILLIB ';


  If Not (blnCheckLibPcm And fCfgSis('LIBPCM', varBoolean)) Then
    Result := Result + ' + SAL_FILNLI ';

  Result := Result + '   ) ';

  Result := Result + '   FROM ';
  Result := Result + '     SALPDC ';
  Result := Result + '   WHERE ';
  Result := Result + '     SAL_CODITE = ' + strSQLCodIte;

  If Not fEmptyStr(strSQLCodEmp) Then
  Begin
    Result := Result + '  AND SAL_CODEMP IN (' + strSQLCodEmp + ')';
  End;

  Result := Result + ' ), 0) ';
End;

function fSQLQuantidadePendenteCompra(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean; strSQLCodSim: String = ''): String;
Begin
  Result := '';
  Result := Result + ' IFNULL((SELECT ';

  Result := Result + '   SUM( ';

  Result := Result + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, blnFiltraTE, blnCheckLibPcm, 'SP');

  Result := Result + '   ) ';

  Result := Result + '   FROM ';
  Result := Result + '     SALPDC SP ';

  If Not fEmptyStr(strSQLCodSim) Then
    Result := Result + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = SP.SAL_CODITE ';

  Result := Result + '   WHERE ';

  If fEmptyStr(strSQLCodSim) Then
    Result := Result + '     SP.SAL_CODITE = ' + strSQLCodIte
  Else
    Result := Result + '     CS.ITE_CODSIM = ' + strSQLCodSim;

  If Not fEmptyStr(strSQLCodEmp) Then
  Begin
    Result := Result + '  AND SP.SAL_CODEMP IN (' + strSQLCodEmp + ')';
  End;

  Result := Result + ' ), 0) ';
End;

function fSQLQuantidadeReqPendente(strSQLCodIte, strSQLCodEmp: String; blnCheckLibPcm: Boolean; blnFiltraTE: Boolean; strSQLCodSim: String = ''): String;
Begin
  Result := '';
  Result := Result + ' IFNULL((SELECT ';

  Result := Result + '   SUM(RCD_QTDITE) ';

  Result := Result + '   FROM ';
  Result := Result + '     MOVRCD RC ';

  If Not fEmptyStr(strSQLCodSim) Then
    Result := Result + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = RC.RCD_CODITE ';

  Result := Result + '   WHERE ';

  If fEmptyStr(strSQLCodSim) Then
    Result := Result + '     RC.RCD_CODITE = ' + strSQLCodIte
  Else
    Result := Result + '     CS.ITE_CODSIM = ' + strSQLCodSim;

  Result := Result + '  AND RC.RCD_SEQPCD IS NULL ';
  Result := Result + '  AND RC.RCD_REQNEG = "N" ';

  If Not fEmptyStr(strSQLCodEmp) Then
  Begin
    Result := Result + '  AND RC.RCD_CODEMP IN (' + strSQLCodEmp + ')';
  End;

  Result := Result + ' ), 0) ';
End;

function fSQLQuantidadePendenteCompraGarantia(strSQLCodIte, strSQLCodEmp: String; strSQLCodSim: String = ''): String;
Begin
  Result := '';
  Result := Result + ' IFNULL((SELECT ';

  Result := Result + '   SUM(PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) ';

  Result := Result + '   FROM ';
  Result := Result + '     PCMDET ';

  Result := Result + ' INNER JOIN PCMGER ON            ';
  Result := Result + '   PCG_NUMCTN = PCD_NUMCTN AND PCG_NUMCTN = 0 AND  ';
  Result := Result + '   PCG_NUMPED = PCD_NUMPED AND   ';
  Result := Result + '   PCG_CODEMP = PCD_CODEMP AND   ';
  Result := Result + '   PCG_ESPDOC = PCD_ESPDOC       ';

  If fCfgSis('CPDORI', varBoolean) Then
  Begin
    Result := Result + ' LEFT JOIN MOVGAE ON MOVGAE.AUTOINCREM = (SELECT  MAX(GAE.AUTOINCREM)';
    Result := Result + '                                            FROM  MOVGAE GAE';
    Result := Result + '                                           WHERE GAE_NUMENV = PCG_ORIGND';
    Result := Result + '                                             AND GAE_ESPENV = PCG_ORIGES';
    Result := Result + '                                             AND GAE_EMPENV = PCG_ORIGEP)';
  End
  Else
  Begin
    Result := Result + ' LEFT JOIN MOVGAE ON MOVGAE.AUTOINCREM = (SELECT  MAX(GAE.AUTOINCREM)';
    Result := Result + '                                            FROM  MOVGAE GAE';
    Result := Result + '                                           WHERE GAE_NUMENV = SUBSTRING(PCG_DOCORI, 1, 12)';
    Result := Result + '                                             AND GAE_ESPENV = SUBSTRING(PCG_DOCORI, 13, 2)';
    Result := Result + '                                             AND GAE_EMPENV = SUBSTRING( PCG_DOCORI, LENGTH(PCG_DOCORI) - 2, LENGTH(PCG_DOCORI) ))';
  End;

  Result := Result + ' LEFT JOIN MOVGAD M ON M.AUTOINCREM = GAE_SEQGAD AND GAD_CODITE = PCD_CODITE ';

  If Not fEmptyStr(strSQLCodSim) Then
    Result := Result + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = PCD_CODITE ';

  Result := Result + '   WHERE ';
  Result := Result + '     IFNULL(PCG_DOCORI, "") <> ""  ';
  Result := Result + '     AND PCD_BAIXAD = 0 ';
  Result := Result + '     AND PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) > 0 ';

  If fEmptyStr(strSQLCodSim) Then
    Result := Result + '  AND PCD_CODITE = ' + strSQLCodIte
  Else
    Result := Result + '  AND CS.ITE_CODSIM = ' + strSQLCodSim;

  Result := Result + '    AND MOVGAE.AUTOINCREM IS NOT NULL ';

  If Not fEmptyStr(strSQLCodEmp) Then
  Begin
    Result := Result + '  AND IFNULL(PCG_EMPDES, PCG_CODEMP) IN (' + strSQLCodEmp + ')';
  End;

  Result := Result + ' ), 0) ';

  Result := Result + '  + IFNULL((SELECT ';

  Result := Result + '   SUM(PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) ';

  Result := Result + '   FROM ';
  Result := Result + '     PCMDET ';

  Result := Result + ' INNER JOIN PCMGER ON            ';
  Result := Result + '   PCG_NUMCTN = PCD_NUMCTN AND PCG_NUMCTN = 0 AND  ';
  Result := Result + '   PCG_NUMPED = PCD_NUMPED AND   ';
  Result := Result + '   PCG_CODEMP = PCD_CODEMP AND   ';
  Result := Result + '   PCG_ESPDOC = PCD_ESPDOC       ';

  Result := Result + ' INNER JOIN SEQGAR ON SEQ_PCMDET = PCMDET.AUTOINCREM ';

  Result := Result + ' INNER JOIN MOVGAD M ON M.AUTOINCREM = SEQGAR.SEQ_MOVGAD AND GAD_CODITE = PCD_CODITE ';

  If Not fEmptyStr(strSQLCodSim) Then
    Result := Result + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = PCD_CODITE ';

  Result := Result + '   WHERE ';
  Result := Result + '     IFNULL(PCG_DOCORI, "") <> ""  ';
  Result := Result + '     AND PCD_BAIXAD = 0 ';
  Result := Result + '     AND PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) > 0 ';

  If fEmptyStr(strSQLCodSim) Then
    Result := Result + '  AND PCD_CODITE = ' + strSQLCodIte
  Else
    Result := Result + '  AND CS.ITE_CODSIM = ' + strSQLCodSim;

  If Not fEmptyStr(strSQLCodEmp) Then
  Begin
    Result := Result + '  AND IFNULL(PCG_EMPDES, PCG_CODEMP) IN (' + strSQLCodEmp + ')';
  End;

  Result := Result + ' ), 0) ';

End;

function fSQLCamposQuantidadePendenteCompra(blnSoma, blnFiltraTE, blnLibPcm: Boolean; strAliasSALPDC: String;
                                            strEmpSubtraiPedTransf: String = ''): String;
Begin
  Result := '';
  Result := Result + IIF(blnSoma, ' SUM(', ' (');

  Result := Result + 'IFNULL(';

  Result := Result + 'IFNULL(' + strAliasSALPDC + '.SAL_NFILIB, 0) ';

  If Not blnFiltraTE Then
    Result := Result + ' + IFNULL(' + strAliasSALPDC + '.SAL_FILLIB, 0) '

  Else iF blnFiltraTE And (not fEmptyStr(strEmpSubtraiPedTransf)) Then
    Result := Result + ' + IF(LOCATE(' + strAliasSALPDC + '.SAL_CODEMP, "' + strEmpSubtraiPedTransf + '") > 0, 0, IFNULL('  + strAliasSALPDC + '.SAL_FILLIB, 0)) ';

  If Not (blnLibPcm And fCfgSis('LIBPCM', varBoolean)) Then
  Begin
    Result := Result + ' + IFNULL(' + strAliasSALPDC + '.SAL_NFINLI, 0) ';

    If Not blnFiltraTE Then
      Result := Result + ' + IFNULL(' + strAliasSALPDC + '.SAL_FILNLI, 0) ';
  End;

  Result := Result + ', 0)';

  Result := Result +  ') ';
End;

function fGetSQLPendentePedidoCompra(strEmpresas, strCodSim: String; blnFiltraTE: Boolean; strOpcao: String = '1'): String;
  Var
    strSelect : String;
begin
  {********************************************}
  {* OPÇÕES DESSA FUNÇÃO:                 *}
  {*     1 - QUANTIDADE PENDENTE              *}
  {*     2 - PRÓXIMA DATA DE ENTREGA PENDENTE *}
  {*****************************************RN*}

  If (strOpcao = '1') Then
  Begin
    Result := fSQLQuantidadePendenteCompra(':CODITE', strEmpresas, False, blnFiltraTE, strCodSim);
  End

  Else If (strOpcao = '2') Then
  Begin
    strSelect := '';
    strSelect := strSelect + ' SELECT ';
    strSelect := strSelect + '   PM.PCD_DTAENT AS DTAENT ';

    strSelect := strSelect + ' FROM PCMDET PM ';

    If Not fEmptyStr(strEmpresas) Then
    Begin
      strSelect := strSelect + '  INNER JOIN PCMGER ON ';
      strSelect := strSelect + '               PCG_NUMCTN = 0             ';
      strSelect := strSelect + '           AND PCG_NUMPED = PM.PCD_NUMPED ';
      strSelect := strSelect + '           AND PCG_CODEMP = PM.PCD_CODEMP ';
      strSelect := strSelect + '           AND PCG_ESPDOC = PM.PCD_ESPDOC ';
      strSelect := strSelect + '           AND IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) IN (' + strEmpresas + ') ';
    End;

    strSelect := strSelect + ' WHERE PM.PCD_CODITE = :CODITE ';

    strSelect := strSelect + '   AND ROUND(PM.PCD_QTDITE - PM.PCD_QTDBAI,' + fCfgSis('DEQTPC') + ') > 0 ';
    strSelect := strSelect + '   AND PM.PCD_NUMCTN = 0 ';
    strSelect := strSelect + '   AND PM.PCD_BAIXAD = 0 ';
    strSelect := strSelect + '   AND PM.PCD_ESPDOC = "PD" ';

    If blnFiltraTE Then
      strSelect := strSelect + '   AND (NOT LOCATE(PM.PCD_CODFOR, ' + QuotedStr(fRetForFilialTodos) + ') > 0) ';

    strSelect := strSelect + ' ORDER BY PM.PCD_DTAENT ';
    strSelect := strSelect + ' LIMIT 1 ';

    Result := strSelect;
  End;

end;

function fRetProximaDtaEntrPedidoCompra(strCodIte, strEmpresas: String; blnFiltraTE: Boolean): String;
  Var
    qryData : TUniQuery;
begin
  qryData := fCriaQuery(Nil);

  With qryData, SQL Do
  Begin
    Add(fGetSQLPendentePedidoCompra(strEmpresas, '', blnFiltraTE, '2'));
    ParamByName('CODITE').AsString := strCodIte;
    Open;
    If Not FieldByName('DTAENT').IsNull Then
      Result := FormatDateTime('dd/mm/yyyy', FieldByName('DTAENT').AsDateTime)
    Else
      Result := '';
    Close;
  End;

  FreeAndNil(qryData);
end;

Function fRetQuantPendentePedidoCompra(strCodIte, strCodSim, strEmpresas: String; blnFiltraTE: Boolean): Double;
  Var
    qrySoma: TUniQuery;
Begin
  qrySoma := fCriaQuery(Nil);

  With qrySoma, SQL Do
  Begin
    Add('SELECT ' + fGetSQLPendentePedidoCompra(strEmpresas, strCodSim, blnFiltraTE, '1') + ' AS QTDPEN');

    If fEmptyStr(strCodSim)Then
      ParamByName('CODITE').AsString := strCodIte;

    Open;
    Result := FieldByName('QTDPEN').AsFloat;
    Close;
  End;

  FreeAndNil(qrySoma);
End;

Function fSQLEstornaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strCampoSaldo) Then
  Begin
    strSQL := strSQL + ' UPDATE SALPDC ';

    strSQL := strSQL + ' INNER JOIN PCMDET D ON PCD_CODITE = SAL_CODITE AND D.AUTOINCREM = ' +  QuotedStr(strAutPcd) + ' ';

    strSQL := strSQL + ' INNER JOIN PCMGER   ON     PCG_NUMPED = PCD_NUMPED ';
    strSQL := strSQL + '                        AND PCG_CODEMP = PCD_CODEMP ';
    strSQL := strSQL + '                        AND PCG_ESPDOC = PCD_ESPDOC ';
    strSQL := strSQL + '                        AND PCG_NUMCTN = 0          ';

    strSQL := strSQL + '   SET ' + strCampoSaldo + ' = IF(' + strCampoSaldo + ' - ROUND((PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA, ' + IntToStr(intDecTpc) + ') > 0, ' + strCampoSaldo + ' - ROUND((PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA, ' + IntToStr(intDecTpc) + '), 0) ';

    strSQL := strSQL + ' WHERE PCD_NUMCTN = 0 AND SAL_CODITE = PCD_CODITE AND SAL_CODEMP = IFNULL(PCG_EMPDES, PCD_CODEMP) AND PCD_QTDITE - PCD_QTDBAI > 0 AND PCD_BAIXAD = 0 AND PCD_ESPDOC = "PD"; ';
  End;

  Result := strSQL;
End;

Procedure pEstornaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer);
  Var
    qryIteger: TUniQuery;
Begin
  If Not fEmptyStr(strCampoSaldo) Then
  Begin
    qryIteger := fCriaQuery;
    qryIteger.SQL.Text := fSQLEstornaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo, intDecTpc);
    qryIteger.ExecSQL;
    FreeAndNil(qryIteger);
  End;
End;

Function fSQLAtualizaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strCampoSaldo) Then
  Begin
    strSQL := strSQL + ' UPDATE SALPDC ';

    strSQL := strSQL + ' INNER JOIN PCMDET D ON PCD_CODITE = SAL_CODITE AND D.AUTOINCREM = ' +  QuotedStr(strAutPcd) + ' ';

    strSQL := strSQL + ' INNER JOIN PCMGER   ON     PCG_NUMPED = PCD_NUMPED ';
    strSQL := strSQL + '                        AND PCG_CODEMP = PCD_CODEMP ';
    strSQL := strSQL + '                        AND PCG_ESPDOC = PCD_ESPDOC ';
    strSQL := strSQL + '                        AND PCG_NUMCTN = 0          ';

    strSQL := strSQL + '   SET ' + strCampoSaldo + ' = ' + strCampoSaldo + ' + ROUND((PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA, ' + IntToStr(intDecTpc) + ') ';

    strSQL := strSQL + ' WHERE PCD_NUMCTN = 0 AND SAL_CODITE = PCD_CODITE AND SAL_CODEMP = IFNULL(PCG_EMPDES, PCD_CODEMP) AND PCD_QTDITE - PCD_QTDBAI > 0 AND PCD_BAIXAD = 0 AND PCD_ESPDOC = "PD"; ';
  End;

  Result := strSQL;
End;

Procedure pAtualizaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo: String; intDecTpc: Integer);
  Var
    qryIteger: TUniQuery;
Begin
  If Not fEmptyStr(strCampoSaldo) Then
  Begin
    qryIteger := fCriaQuery;
    qryIteger.SQL.Text := fSQLAtualizaSaldoItemPedidoCompra(strAutPcd, strCampoSaldo, intDecTpc);
    qryIteger.ExecSQL;
    FreeAndNil(qryIteger);
  End;
End;

Procedure pEstornaSaldoPedidoCompra(strNumPed, strEspPed, strEmpPed: String; strCodIte: String = '');
  Var
    strForFil,
    strSQL,
    strCampoSaldo: String;
    qryGenDet: TUniQuery;
    blnLibPcm: Boolean;
    intDecTpc: Integer;
Begin
  If strEspPed = 'PD' Then
  Begin
    strForFil := fRetForFilialTodos;
    blnLibPcm := fCfgSis('LIBPCM', varBoolean);
    intDecTpc := fCfgSis('DEQTPC', varInteger);

    strCampoSaldo := fRetCampoAtualizaSaldoPedidoCompra('',
                                                        strNumPed,
                                                        strEmpPed,
                                                        blnLibPcm,
                                                        strForFil);
    If fEmptyStr(strCampoSaldo) Then
      Exit;

    qryGenDet := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0       AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD" ';

    If Not fEmptyStr(strCodIte) Then
      strSQL := strSQL + ' AND PCD_CODITE = :CODITE ';

    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('CODEMP').AsString := strEmpPed;

      If Not fEmptyStr(strCodIte) Then
        ParamByName('CODITE').AsString := strCodIte;

      Open;
      While Not Eof Do
      Begin
        pEstornaSaldoItemPedidoCompra(FieldByName('AUTOINCREM').AsString, strCampoSaldo, intDecTpc);

        Next;
      End;

      Close;
    End;

    FreeAndNil(qryGenDet);
  End;

End;

Procedure pAtualizaSaldoPedidoCompra(strNumPed, strEspPed, strEmpPed: String; strCodIte: String = '');
  Var
    strForFil,
    strCampoSaldo,
    strSQL   : String;
    qryGenDet: TUniQuery;
    blnLibPcm: Boolean;
    intDecTpc: Integer;
Begin
  If strEspPed = 'PD' Then
  Begin
    strForFil := fRetForFilialTodos;
    blnLibPcm := fCfgSis('LIBPCM', varBoolean);
    intDecTpc := fCfgSis('DEQTPC', varInteger);

    strCampoSaldo := fRetCampoAtualizaSaldoPedidoCompra('',
                                                        strNumPed,
                                                        strEmpPed,
                                                        blnLibPcm,
                                                        strForFil);

    If fEmptyStr(strCampoSaldo) Then
      Exit;

    qryGenDet := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0       AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD" ';

    If Not fEmptyStr(strCodIte) Then
      strSQL := strSQL + ' AND PCD_CODITE = :CODITE ';

    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('CODEMP').AsString := strEmpPed;

      If Not fEmptyStr(strCodIte) Then
        ParamByName('CODITE').AsString := strCodIte;

      Open;
      While Not Eof Do
      Begin
        pAtualizaSaldoItemPedidoCompra(FieldByName('AUTOINCREM').AsString, strCampoSaldo, intDecTpc);

        Next;
      End;

      Close;
    End;

    FreeAndNil(qryGenDet);
  End;

End;

Class Function TSaldoPedido.fAtualizaSaldoPedidoCompraGeralPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  Try
    qryUpdate := fCriaQuery;
    qryUpdate.SQL.Text := 'CALL pAtualizaSaldoPedidoCompra';
    qryUpdate.ExecSQL;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'fAtualizaSaldoPedidoCompraGeralPrg');
    End;
  End;

  FreeAndNil(qryUpdate);
End;

Function fAtualizaSaldoPedidoCompraGeral: Boolean;
{$IFDEF LINUX}
begin
  Result := TSaldoPedido.fAtualizaSaldoPedidoCompraGeralPrg(nil);
{$ELSE}
Var
  frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(TSaldoPedido.fAtualizaSaldoPedidoCompraGeralPrg, frmGravando, 'Atualizando saldo de pedidos de compra, aguarde...', False);
{$ENDIF}
end;

Procedure pIncluiRegistroSaldoPedidoCompra(strCodIte, strCodEmp: String);
  Var
    qrySaldos: TUniQuery;
Begin
  qrySaldos := fCriaQuery;

  qrySaldos.SQL.Text := ' INSERT INTO SALPDC (SAL_CODITE, SAL_CODEMP, SAL_FILLIB, SAL_FILNLI, SAL_NFILIB, SAL_NFINLI, AUTOINCREM) VALUES ' +
                        '                    (:CODITE, :CODEMP, 0, 0, 0, 0, :AUTINC) ';

  qrySaldos.ParamByName('CODITE').AsString := strCodIte;
  qrySaldos.ParamByName('CODEMP').AsString := strCodEmp;
  qrySaldos.ParamByName('AUTINC').AsString := fRetAutoIncrem('SALPDC', VS_strCodEmp);;
  qrySaldos.ExecSQL;

  FreeAndNil(qrySaldos);
End;

Function fRetPrimeiroAnoGiro: Integer;
  Var
    qryGirIte: TUniQuery;
Begin
  qryGirIte := fCriaQuery;
  With qryGirIte Do
  Begin
    SQL.Text := 'SELECT MIN(GIR_A_N_O_) AS ANO FROM GIRITE';
    Open;

    Result := StrToIntDef(FieldByName('ANO').AsString, YearOf(VS_Date));
    If Result = YearOf(VS_Date) then
      Result := (YearOf(VS_Date))-1;
  End;
  FreeAndNil(qryGirIte);
End;

Function TSaldoPedido.fGeraGirIte(prgProgresso: TcxProgressBar): Boolean;
  Var
    qryCadEmp: TUniQuery;
Begin
  qryCadEmp := fCriaQuery;
  qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
  qryCadEmp.Open;

  prgProgresso.Properties.Max := qryCadEmp.RecordCount;

  With qryCadEmp Do
  While Not Eof Do
  Begin
    pIncluiRegistroSaldoPedidoCompra(strCodIte, FieldByName('EMP_CODEMP').AsString);

    pGeraGirIte(strCodIte, FieldByName('EMP_CODEMP').AsString);

    Next;

    prgProgresso.Position := prgProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  FreeAndNil(qryCadEmp);
  Result := True;
End;

Procedure pGeraGirIte(strCodIte, strCodEmp: String); Overload;
  Var
    qryGirIte: TUniQuery;
    intCampos,
    intAno,
    intPrimeiroAno: Integer;
    strAutInc,
    strAutIncBkp: String;
Begin
  intPrimeiroAno := fRetPrimeiroAnoGiro;

  qryGirIte := fCriaQuery;
  qryGirIte.SQL.Text := 'SELECT * FROM GIRITE WHERE FALSE';
  qryGirIte.Open;
  strAutInc:=  fRetAutoIncrem('GIRITE', VS_strCodEmp,  (YearOf(VS_Date) - intPrimeiroAno) + 1);
  strAutIncBkp := strAutInc;


  For intAno := intPrimeiroAno To YearOf(VS_Date) Do
  Begin
    qryGirIte.Insert;

    For intCampos := 0 To qryGirIte.FieldCount -1 Do
      If qryGirIte.Fields[intCampos].DataType In [ftWord, ftFloat, ftInteger] Then
        qryGirIte.Fields[intCampos].Value := 0;

    qryGirIte.FieldByName('AUTOINCREM').AsString := strAutInc;
    qryGirIte.FieldByName('GIR_CODITE').AsString := strCodIte;
    qryGirIte.FieldByName('GIR_CODEMP').AsString := strCodEmp;
    qryGirIte.FieldByName('GIR_A_N_O_').AsString := IntToStr(intAno);

    qryGirIte.Post;
    pIncrementaAutoIncrem(strAutIncBkp);
    strAutInc := strAutIncBkp;
  End;

  FreeAndNil(qryGirIte);
End;

procedure pGeraGirIte(strCodIte: String); Overload;
var
{$IFNDEF LINUX}
  frmGravandoGirIte: TfrmGravando;
{$ENDIF}
  objSaldo: TSaldoPedido;
Begin
  objSaldo := TSaldoPedido.Create;
  objSaldo.strCodIte := strCodIte;
{$IFDEF LINUX}
  objSaldo.fGeraGirIte(nil);
{$ELSE}
  pCriarFormularios(TfrmGravando, frmGravandoGirIte);
  With frmGravandoGirIte Do
  Begin
    lblGravando.Caption := 'Gerando informações para o giro de estoque...';
    fExecutarAcao := objSaldo.fGeraGirIte;
    ShowModal;
  End;
  pFreeAndNil(frmGravandoGirIte);
{$ENDIF}
End;

end.
