unit untMetaCentroCustoPedido;

interface

Uses
  Classes, SysUtils, Controls, DB, Math, MaskUtils, DateUtils,
  untFuncoesSimples, untZClient, Uni, Forms, untTypesSistema, StrUtils,
  untiLiberacao;

Type
  TMetas = Array Of Record
    dtaDtaIni,
    dtaDtaFin: TDate;
    fltUsaPag: Double;
    fltUsaPed: Double;
    fltPedAtu: Double;
    fltValMet: Double;
    strAutInc: String;
  End;

  TMetaCentroCustoPedido = Class(TZClient)
  Private
    FOpeRes: String;

    arrMetas: TMetas;

    FPedidos: TUniQuery;

    FAutIncCTP: String;

    objLiberacao : ILiberacao;
    strOperador  : String;

    {***********************************************************************************}
    {*  [CFG_METPED] Tipo de Meta de Pedido de Compra                                  *}
    {*  1) Metas por Pedido de Compra por Comprador por Empresa                        *}
    {*  2) Metas por Pedido de Compra por Despesas por Empresa                         *}
    {*  3) Metas por Pedido de Compra por Comprador Geral para todas as Empresas       *}
    {*  4) Metas por Pedido de Compra por Despesas Geral para todas as Empresas        *}
    {*  Para 1, 2 o valor é falso 3, 4 True                                            *}
    {***********************************************************************************}
    blnTodasEmpresas: boolean;

    Function fSQLMetas: String;
    Function fSQLPedidos(AstrCodFor: string = ''): String;

    Procedure pCarregaPedidos(strNumPed, strCodCta, strCodEmp, strCodCmp, strCodEve: String);

    Function fSQLCadPag: String;
    Function fRetTotalContasAPagar(dtaDtaIni, dtaDtaFin: TDateTime; strCodCta, strCodEmp: String): Double;

    Procedure pMontaMensagem(strCodEmp, strCodCta: String; ACodCmp: String = ''; strCodEve: String = '');

    Function fVerificaMetas(strCodEmp, strCodCta: String; AstrCodCmp: String = ''; strCodEve: String = ''): Boolean;


  Public
    strCodFor: string;
    strNomFor: string;
    strForCGC: string;
    cdsTotalEmpresas: TZClient;
    constructor Create(Owner: TComponent); Reintroduce; Overload;
    Destructor Destroy; override;

    Procedure pInicializa;


    function fExisteMeta(AstrCodOpe, AStrCofFor, AstrDtaVal: String): Boolean;

    Function fCarregaMetas(dtaEntrega: TDateTime; strCodEmp, strCodCta, strNumPed, strConPag: String;
                           fltTotPed: Double; blnRecalcularDuplictas: Boolean;
                           arrParcelas: TarrDuplicata; strCodCmp: String = ''; strCodEve: String = ''): Boolean; OverLoad;

    Function fCarregaMetas(dtaEntrega: TDateTime; strCodEmp, strCodCta, strNumPed, strConPag: String; fltTotPed: Double; strCodEve: String = ''): Boolean; OverLoad;

    Function fPedeSenha: Boolean;

    property strAutIncCTP: String read FAutIncCTP write FAutIncCTP;
  End;

implementation

Uses
  untConstantes,
  untDuplicatasPedidoCompra, untFuncoesGenerica, untLiberacaoFactory,
  untMsgLiberacao;

constructor TMetaCentroCustoPedido.Create(Owner: TComponent);
var intValMetPed: integer;
Begin
  intValMetPed := fCfgSis('METPED', varInteger);
  blnTodasEmpresas := (intValMetPed = 3) or  (intValMetPed = 4);
  Inherited Create(Owner, fSQLMetas);

  FPedidos := fCriaQuery(Self);
  FPedidos.SQL.Text := fSQLPedidos;

  objLiberacao := TLiberacaoFactory.fGetLiberacao;

  SetLength(arrMetas, 0);

  FAutIncCTP := '';
  FOpeRes := '';
End;

Destructor TMetaCentroCustoPedido.Destroy;
Begin
  Inherited;

  SetLength(arrMetas, 0);
End;

Function TMetaCentroCustoPedido.fSQLPedidos(AstrCodFor: string = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  PCD_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  PCD_CONPAG AS CONPAG, ';
  strSQL := strSQL + '  G.AUTOINCREM AS AUTGER, ';

  strSQL := strSQL + '  SUM((( PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0) / 100) ';
  strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN2, 0) / 100) ';
  strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN4, 0) / 100) ';
  strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
  strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN5, 0) / 100) ';
  strSQL := strSQL + '                    * (1 - IFNULL(PCD_DESUN6, 0) / 100) ';
	
  If fCfgSis('CONINC', varInteger) <> 2 Then
    strSQL := strSQL + '   * ( PCD_QTDITE - PCD_QTDBAI )) * (1+((PCD_PERIPI)/100))) + (PCD_TOTSUB - PCD_SUBBAI) + (PCD_SUBFCP - PCD_FCPBAI)) AS TOTPED '
  Else
    strSQL := strSQL + '   * ( PCD_QTDITE)) * (1+((PCD_PERIPI)/100))) + (PCD_TOTSUB) + (PCD_SUBFCP)) AS TOTPED ';	

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET  ';

  strSQL := strSQL + '  JOIN PCMGER G ON PCD_NUMPED = PCG_NUMPED ';
  strSQL := strSQL + '               AND PCD_CODEMP = PCG_CODEMP ';
  strSQL := strSQL + '               AND PCD_ESPDOC = PCG_ESPDOC ';
  strSQL := strSQL + '               AND PCD_NUMCTN = PCG_NUMCTN ';
  strSQL := strSQL + '               AND IFNULL(PCG_PEDBON, "N") <> "S" ';

  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  PCG_BAIXAD = 0 AND ';
  strSQL := strSQL + '  PCD_BAIXAD = 0 AND ';
  strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
  strSQL := strSQL + '  PCD_ESPDOC <> "OR" AND ';
  strSQL := strSQL + '  (NOT LOCATE(PCD_CODFOR, :FORFIL) > 0) AND ';
  if not blnTodasEmpresas then
    strSQL := strSQL + '  IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) = :CODEMP AND ';
  strSQL := strSQL + '  ((PCG_NUMPED <> :NUMPED) OR (PCG_CODEMP <> :CODEMP))               ';

  If fCfgSis('METPED') <> '1' Then
  Begin

    strSQL := strSQL + '  AND ((PCG_CODCTA = :CODCTA) OR                                              ';
    strSQL := strSQL + '   ((LEFT(PCG_CODCTA, 2) = LEFT(:CODCTA, 2)) AND (RIGHT(:CODCTA, 5) = "00000")) OR ';
    strSQL := strSQL + '   ((LEFT(PCG_CODCTA, 4) = LEFT(:CODCTA, 4)) AND (RIGHT(:CODCTA, 3) = "000"))  )   ';

    If (fCfgSis('METPED') = '5') OR (fCfgSis('METPED') = '6') Then
      strSQL := strSQL + '  AND (PCG_CODEVE = :CODEVE)                                              ';

  End;

  If fCfgSis('LIBPCM', varBoolean) Then
    strSQL := strSQL + '  AND PCG_PEDLIB IS NOT NULL ';

  If fCfgSis('METPED') = '1' Then
  Begin
    strSQL := strSQL + '  AND PCG_CODCMP = :CODCMP ';
    If AstrCodFor <> '' Then
      strSQL := strSQL + '  AND PCG_CODFOR = "' + AstrCodFor + '" ';
  End;
  
  if fCfgSis('CONINC', varInteger) <> 1 Then
  Begin
    strSQL := strSQL + '    AND PCG_DTAPED BETWEEN :DTAINI AND :DTAFIN ';
  End;

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  DTAENT, CONPAG ';

  Result := strSQL;
End;

Function TMetaCentroCustoPedido.fSQLCadPag: String;
  Var
    strSQL: String;
Begin
  strSQL := 'SELECT SUM(VALDUP) AS VALDUP FROM (';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '    (IFNULL(SUM(IF(CTP_DTAPAG IS NULL,  (P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_MULSUJ, 0) + IFNULL(P.CTP_VENDOR, 0)) * D.CTP_FATCAL, 0)), 0) +';
  strSQL := strSQL + '     IFNULL(SUM(IF(CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN, IFNULL(CTP_VALPAG, 0) * D.CTP_FATCAL, 0)), 0) +';
  strSQL := strSQL + '     IFNULL(SUM(IF(CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN, IFNULL(CTP_VALDES, 0) * D.CTP_FATCAL, 0)), 0) ';
  strSQL := strSQL + '  ) AS VALDUP  ';
  strSQL := strSQL + '  FROM CADPAG P';
  strSQL := strSQL + '  JOIN CTPDET D ON D.CTP_NUMDUP=P.CTP_NUMDUP AND ';
  strSQL := strSQL + '                   D.CTP_CODFOR=P.CTP_CODFOR AND ';
  strSQL := strSQL + '                   D.CTP_PARCEL=P.CTP_PARCEL AND ';
  strSQL := strSQL + '                   D.CTP_EMPORI=P.CTP_CODEMP AND ';
  strSQL := strSQL + '                   COALESCE(D.CTP_SERIE_, "") = COALESCE(P.CTP_SERIE_, "") ';
  strSQL := strSQL + '  WHERE TRUE';
  strSQL := strSQL + '    AND ((P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN) OR';
  strSQL := strSQL + '         (P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN))';
  strSQL := strSQL +  '   AND (D.CTP_CODCTA = :CODCTA ' + IIF(Not blnTodasEmpresas, ' AND D.CTP_CODEMP=:CODEMP' , '') + ') ';

  If Not fEmptyStr(FAutIncCTP) Then
    strSQL := strSQL + ' AND P.AUTOINCREM <> :AUTOIN    ';

  strSQL := strSQL + ' UNION ALL ';

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '    (IFNULL(SUM(IF(CTP_DTAPAG IS NULL,  P.CTP_VALDUP - IFNULL(P.CTP_DESSUJ, 0) + IFNULL(P.CTP_JURSUJ, 0) + IFNULL(P.CTP_MULSUJ, 0) + IFNULL(P.CTP_VENDOR, 0), 0)), 0) +';
  strSQL := strSQL + '     IFNULL(SUM(IF(CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN, IFNULL(CTP_VALPAG, 0), 0)), 0) +';
  strSQL := strSQL + '     IFNULL(SUM(IF(CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN, IFNULL(CTP_VALDES, 0), 0)), 0) ';
  strSQL := strSQL + '  ) AS VALDUP  ';
  strSQL := strSQL + '  FROM CADPAG P';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' NOT EXISTS(SELECT * FROM CTPDET D WHERE         ';
  strSQL := strSQL + '                   D.CTP_NUMDUP=P.CTP_NUMDUP AND ';
  strSQL := strSQL + '                   D.CTP_CODFOR=P.CTP_CODFOR AND ';
  strSQL := strSQL + '                   D.CTP_PARCEL=P.CTP_PARCEL AND ';
  strSQL := strSQL + '                   D.CTP_EMPORI=P.CTP_CODEMP AND ';
  strSQL := strSQL + '                   COALESCE(D.CTP_SERIE_, "") = COALESCE(P.CTP_SERIE_, "")) ';
  strSQL := strSQL + '    AND ((P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN) OR ';
  strSQL := strSQL + '         (P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN))';
  strSQL := strSQL +  '   AND P.CTP_CODCTA = :CODCTA ';

  If not blnTodasEmpresas Then
    strSQL := strSQL + ' AND P.CTP_CODEMP = :CODEMP    ';

  If Not fEmptyStr(FAutIncCTP) Then
    strSQL := strSQL + ' AND P.AUTOINCREM <> :AUTOIN    ';

  strSQL := strSQL + ') TMP ';

  Result := strSQL;
End;

Function TMetaCentroCustoPedido.fSQLMetas: String;
Begin

  If fCfgSis('METPED') = '1' Then
  Begin
    Result := '';
    Result := Result + ' SELECT CADMPC.AUTOINCREM AS AUTINC, ';
    Result := Result + '       CADMPC.MPC_CODVEN, ';
    Result := Result + '        CADMPC.MPC_MESANO, ';
    Result := Result + '        IFNULL(MPC_CODFOR, "") AS CODFOR, ';
    Result := Result + '        CONCAT("01/", LEFT(CADMPC.MPC_MESANO, 2), "/", RIGHT(CADMPC.MPC_MESANO, 4)) AS DTAINI, ';
    Result := Result + '        MPC_TOTMET, ';
    Result := Result + '        MPC_TOTMET *MPC_PERFOR / 100   AS MCP_VALMET ';
    Result := Result + '   FROM CADMPC ';
    Result := Result + '  INNER JOIN DETMPC on  DETMPC.MPC_CODEMP = CADMPC.MPC_CODEMP AND DETMPC.MPC_CODVEN = CADMPC.MPC_CODVEN AND DETMPC.MPC_MESANO = CADMPC.MPC_MESANO ';
    Result := Result + '  WHERE CADMPC.MPC_CODEMP = :CODEMP ';
    Result := Result + '    AND CADMPC.MPC_CODVEN = :CODOPE ';
    Result := Result + '    AND ((DETMPC.MPC_CODFOR = :CODFOR) OR (DETMPC.MPC_CODFOR IS NULL)) ';
    Result := Result + '    AND CADMPC.MPC_MESANO = :DTAVAL ';
  End
  Else
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   G.AUTOINCREM AS AUTINC, ';
    Result := Result + '   MCP_CODOPE, ';
    Result := Result + '   MCP_CODCTA, ';
    Result := Result + '   MCP_CODEMP, ';
    Result := Result + '   MCP_DTAINI, ';
    Result := Result + '   MCP_DTAFIN, ';
    Result := Result + '   MCP_VALMET ';
    Result := Result + ' FROM MCPGER G ';
    Result := Result + ' INNER JOIN MCPDET D ON G.AUTOINCREM = D.MCP_SEQGER ';
    Result := Result + ' WHERE ';
    Result := Result + '   :DTAPED BETWEEN MCP_DTAINI AND MCP_DTAFIN AND ';
    if blnTodasEmpresas then
      Result := Result + '   COALESCE(MCP_CODEMP, "") = "" AND '
    Else
      Result := Result + '   MCP_CODEMP = :CODEMP AND  ';

    If (fCfgSis('METPED') = '5') OR (fCfgSis('METPED') = '6') Then
      Result := Result + '  (MCP_CODEVE = :CODEVE)  AND ';

    Result := Result + '   ((MCP_CODCTA = :CODCTA) OR ';
    Result := Result + '    ((LEFT(MCP_CODCTA, 2) = LEFT(:CODCTA, 2)) AND (RIGHT(MCP_CODCTA, 5) = "00000")) OR ';
    Result := Result + '    ((LEFT(MCP_CODCTA, 4) = LEFT(:CODCTA, 4)) AND (RIGHT(MCP_CODCTA, 3) = "000"))      ';
    Result := Result + '   ) ';
  End;
End;

Function TMetaCentroCustoPedido.fRetTotalContasAPagar(dtaDtaIni, dtaDtaFin: TDateTime; strCodCta, strCodEmp: String): Double;
  Var
    qryCadPag: TUniQuery;
Begin
  qryCadPag := fCriaQuery;

  With qryCadPag Do
  Begin
    SQL.Text := fSQLCadPag;
    if not blnTodasEmpresas then
      ParamByName('CODEMP').AsString   := strCodEmp;
    If Not fEmptyStr(FAutIncCTP) Then
      ParamByName('AUTOIN').AsString   := FAutIncCTP;
    ParamByName('CODCTA').AsString   := strCodCta;
    ParamByName('DTAINI').AsDateTime := dtaDtaIni;
    ParamByName('DTAFIN').AsDateTime := dtaDtaFin;

    Open;

    Result := FieldByName('VALDUP').AsFloat;
  End;

  FreeAndNil(qryCadPag);
End;

Function TMetaCentroCustoPedido.fCarregaMetas(dtaEntrega: TDateTime; strCodEmp, strCodCta, strNumPed, strConPag: String; fltTotPed: Double; strCodEve: String = ''): Boolean;
  Var
    arrParcelas: TarrDuplicata;
Begin
  Result := fCarregaMetas(dtaEntrega, strCodEmp, strCodCta, strNumPed, strConPag, fltTotPed, True {blnRecalcularDuplictas}, arrParcelas, strCodEve);
End;

function TMetaCentroCustoPedido.fExisteMeta(AstrCodOpe, AStrCofFor, AstrDtaVal: String): Boolean;
var qryConsulta: TUniquery;
begin
  Result := True;
  If AStrCodOpe = '' Then
    Exit;
  If fCfgSis('METPED') = '1' Then
  Begin
    qryConsulta := fCriaQuery;
    Try

      qryConsulta.SQL.Add(' SELECT COUNT(1) AS QTD');
      qryConsulta.SQL.Add('   FROM CADMPC ');
      qryConsulta.SQL.Add('  INNER JOIN DETMPC ON DETMPC.MPC_CODEMP = CADMPC.MPC_CODEMP AND DETMPC.MPC_CODVEN = CADMPC.MPC_CODVEN AND DETMPC.MPC_MESANO = CADMPC.MPC_MESANO ');
      qryConsulta.SQL.Add('  WHERE CADMPC.MPC_CODVEN = :CODOPE ');
      qryConsulta.SQL.Add('    AND ((DETMPC.MPC_CODFOR = :CODFOR) OR (DETMPC.MPC_CODFOR IS NULL)) ');
      qryConsulta.SQL.Add('    AND CADMPC.MPC_MESANO > :DTAVAL ');

      qryConsulta.ParamByName('CODOPE').AsString := AstrCodOpe;
      qryConsulta.ParamByName('CODFOR').AsString := AStrCofFor;
      qryConsulta.ParamByName('DTAVAL').AsString := AstrDtaVal;

      qryConsulta.Open;

      Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
    Finally
      FreeAndNil(qryConsulta)
    End;
  End;

end;

Function TMetaCentroCustoPedido.fCarregaMetas(dtaEntrega: TDateTime; strCodEmp, strCodCta, strNumPed, strConPag: String; fltTotPed: Double;
                                              blnRecalcularDuplictas: Boolean;
                                              arrParcelas: TarrDuplicata; strCodCmp: string = ''; strCodEve: String = ''): Boolean;
  Var
    intValMetPed,

    intQtdDup    : Integer;
    intContador  : Integer;
    intMetas     : Integer;
    intIndiceMeta: Integer;
    curTotalRes  : Currency;
    fltValMetTotGer,
    fltValMetTot: Double;
    arrDuplicata: TarrDuplicata;
Begin
  pZeraDigDuplic(arrDuplicata);
  Try
    Result := True;

    curTotalRes := 0;

    intValMetPed := fCfgSis('METPED', varInteger);

    If Assigned(cdsTotalEmpresas) And (intValMetPed = 1) Then
    Begin
      cdsTotalEmpresas.First;
      fltValMetTotGer := 0;

      while not cdsTotalEmpresas.Eof Do
      Begin
        fltTotPed := cdsTotalEmpresas.FieldByName('TOT_TOTGER').AsFloat;
        strCodEmp := cdsTotalEmpresas.FieldByName('CODEMP').ASString;

        // ATUALIZA OS VENCIMENTOS POR QUE A DATA DE ENTREGA PODE MUDAR
        fDigDuplicSemTela(arrDuplicata,
                          intQtdDup,
                          curTotalRes,
                          strConPag,
                          0,
                          fltTotPed,
                          False,
                          False,
                          IfThen(dtaEntrega < VS_Date, VS_Date, dtaEntrega),
                          False);

        SetLength(arrMetas, 0);


        fltValMetTot := 0;

        For intContador := 0 To intQtdDup -1 Do
        Begin
          arrParcelas[intContador].dtaDtaVen := arrDuplicata[intContador].dtaDtaVen;

          If blnRecalcularDuplictas Or (fStatusCndPag(strConPag) = A_VISTA) Then
            arrParcelas[intContador].curValor := arrDuplicata[intContador].curValor;

          With qryQuery Do
          Begin
            qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
            qryQuery.ParamByName('CODFOR').AsString := strCodFor;
            qryQuery.ParamByName('DTAVAL').AsString := FormatDateTime('MMYYYY', StrToDate(arrParcelas[intContador].dtaDtaVen));

            if fCfgSis('CONINC', varInteger) <> 1 Then
              qryQuery.ParamByName('DTAVAL').AsString := FormatDateTime('MMYYYY', VS_Date);

            qryQuery.ParamByName('CODOPE').AsString := strCodCmp;
            fAbreClient(True, 'TMetaCentroCustoPedido.fCarregaMetas');

            If Not (qryQuery.IsEmpty) Then
            begin
              //FOpeRes := strCodCmp;
              If qryQuery.FieldByName('CODFOR').AsString <> '' Then
                FPedidos.Sql.Text := fSQLPedidos(qryQuery.FieldByName('CODFOR').AsString);

             intIndiceMeta := -1;
             For intMetas := Low(arrMetas) To High(arrMetas) Do
               If SameText(FieldByName('AUTINC').AsString, arrMetas[intMetas].strAutInc) Then
               Begin
                 intIndiceMeta := intMetas;
                 Break;
               End;

              If intIndiceMeta = -1 Then
              Begin
                SetLength(arrMetas, Succ(Length(arrMetas)));
                intIndiceMeta := High(arrMetas);

                With arrMetas[intIndiceMeta] Do
                Begin
                  If IsEmpty Then
                  Begin
                    fltPedAtu := 0;
                    fltUsaPag := 0;
                    strAutInc := '';
                    fltValMet := 0;

                    if fCfgSis('CONINC', varInteger) <> 1 Then
                    Begin
                      dtaDtaIni := VS_Date;
                      dtaDtaFin := VS_Date;

                    End
                    Else
                    Begin
                      dtaDtaIni := StartOfTheMonth(StrToDateDef(arrParcelas[intContador].dtaDtaVen, 0));
                      dtaDtaFin := EndOfTheMonth(StrToDateDef(arrParcelas[intContador].dtaDtaVen, 0));
                    End;
                  End Else
                  Begin
                    If intValMetPed =  1 Then
                    Begin
                      strAutInc := FieldByName('AUTINC').AsString;
                      dtaDtaIni := StrToDate(FieldByName('DTAINI').AsString);
                      dtaDtaFin := EndOfTheMonth(StrToDate(FieldByName('DTAINI').AsString));
                      fltValMet := FieldByName('MCP_VALMET').AsFloat;
                      fltValMetTot := fltValMetTot + FieldByName('MCP_VALMET').AsFloat;
                      fltValMetTotGer := fltValMetTotGer + FieldByName('MCP_VALMET').AsFloat;
                    End
                    Else
                    Begin
                      strAutInc := FieldByName('AUTINC').AsString;
                      dtaDtaIni := FieldByName('MCP_DTAINI').AsDateTime;
                      dtaDtaFin := FieldByName('MCP_DTAFIN').AsDateTime;
                      fltValMet := FieldByName('MCP_VALMET').AsFloat;
                    End;
                  End;
                If (intValMetPed <> 1) And (fCfgSis('CONINC', varInteger) <> 2) Then
                   fltUsaPag := fRetTotalContasAPagar(dtaDtaIni, dtaDtaFin, strCodCta, strCodEmp);
                End;
              End;

              With arrMetas [intIndiceMeta] Do
                fltPedAtu := fltPedAtu + arrParcelas[intContador].curValor;
            End;
          End;
        End;
        pCarregaPedidos(strNumPed, strCodCta, strCodEmp, strCodCmp, strCodEve);
        If fltValMetTot >  0 Then
           If Not fVerificaMetas(strCodEmp, strCodCta, FOpeRes, strCodEve) Then
             Result := False;

        cdsTotalEmpresas.Next;
      End;
      If (intValMetPed = 1) And (fltValMetTotGer = 0) Then
          Exit(True);
    End
    Else
    Begin


      // ATUALIZA OS VENCIMENTOS POR QUE A DATA DE ENTREGA PODE MUDAR
      fDigDuplicSemTela(arrDuplicata,
                        intQtdDup,
                        curTotalRes,
                        strConPag,
                        0,
                        fltTotPed,
                        False,
                        False,
                        IfThen(dtaEntrega < VS_Date, VS_Date, dtaEntrega),
                        False);

      SetLength(arrMetas, 0);


      fltValMetTot := 0;
      intValMetPed := fCfgSis('METPED', varInteger);

      For intContador := 0 To intQtdDup -1 Do
      Begin
        arrParcelas[intContador].dtaDtaVen := arrDuplicata[intContador].dtaDtaVen;

        If blnRecalcularDuplictas Or (fStatusCndPag(strConPag) = A_VISTA) Then
          arrParcelas[intContador].curValor := arrDuplicata[intContador].curValor;

        With qryQuery Do
        Begin
          If intValMetPed = 1 Then
          Begin
            qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
            qryQuery.ParamByName('CODFOR').AsString := strCodFor;
            qryQuery.ParamByName('DTAVAL').AsString := FormatDateTime('MMYYYY', StrToDate(arrParcelas[intContador].dtaDtaVen));

            if fCfgSis('CONINC', varInteger) <> 1 Then
              qryQuery.ParamByName('DTAVAL').AsString := FormatDateTime('MMYYYY', VS_Date);

            qryQuery.ParamByName('CODOPE').AsString := strCodCmp;
          End
          Else
          Begin
            if not blnTodasEmpresas then
              ParamByName('CODEMP').AsString := strCodEmp;

            if (intValMetPed = 5) Or (intValMetPed = 6) Then
              ParamByName('CODEVE').AsString   := strCodEve;

            ParamByName('CODCTA').AsString   := strCodCta;
            ParamByName('DTAPED').AsDateTime := StrToDate(arrParcelas[intContador].dtaDtaVen);

            if fCfgSis('CONINC', varInteger) <> 1 Then
              ParamByName('DTAPED').AsDateTime := VS_Date;

          End;


          Result := fAbreClient(True, 'TMetaCentroCustoPedido.fCarregaMetas');

          If Result And (Not Self.IsEmpty) Then
          Begin
            If intValMetPed = 1 Then
            Begin
              //FOpeRes := strCodCmp;
              If qryQuery.FieldByName('CODFOR').AsString <> '' Then
                FPedidos.Sql.Text := fSQLPedidos(qryQuery.FieldByName('CODFOR').AsString);
            End
            Else
              FOpeRes := Self.FieldByName('MCP_CODOPE').AsString
          End
          Else If intValMetPed <> 1 Then
            FOpeRes := '';

          intIndiceMeta := -1;
          For intMetas := Low(arrMetas) To High(arrMetas) Do
            If SameText(FieldByName('AUTINC').AsString, arrMetas[intMetas].strAutInc) Then
            Begin
              intIndiceMeta := intMetas;
              Break;
            End;

          If intIndiceMeta = -1 Then
          Begin
            SetLength(arrMetas, Succ(Length(arrMetas)));
            intIndiceMeta := High(arrMetas);

            With arrMetas[intIndiceMeta] Do
            Begin
              If IsEmpty Then
              Begin
                fltPedAtu := 0;
                fltUsaPag := 0;
                strAutInc := '';
                fltValMet := 0;

                if fCfgSis('CONINC', varInteger) <> 1 Then
                Begin
                  dtaDtaIni := VS_Date;
                  dtaDtaFin := VS_Date;

                End
                Else
                Begin
                  dtaDtaIni := StartOfTheMonth(StrToDateDef(arrParcelas[intContador].dtaDtaVen, 0));
                  dtaDtaFin := EndOfTheMonth(StrToDateDef(arrParcelas[intContador].dtaDtaVen, 0));
                End;
              End Else
              Begin
                If intValMetPed =  1 Then
                Begin
                  strAutInc := FieldByName('AUTINC').AsString;
                  dtaDtaIni := StrToDate(FieldByName('DTAINI').AsString);
                  dtaDtaFin := EndOfTheMonth(StrToDate(FieldByName('DTAINI').AsString));
                  fltValMet := FieldByName('MCP_VALMET').AsFloat;
                  fltValMetTot := fltValMetTot + FieldByName('MCP_VALMET').AsFloat;
                End
                Else
                Begin
                  strAutInc := FieldByName('AUTINC').AsString;
                  dtaDtaIni := FieldByName('MCP_DTAINI').AsDateTime;
                  dtaDtaFin := FieldByName('MCP_DTAFIN').AsDateTime;
                  fltValMet := FieldByName('MCP_VALMET').AsFloat;
                End;
              End;
			  
              If (intValMetPed <> 1) And (fCfgSis('CONINC', varInteger) <> 2) Then
                fltUsaPag := fRetTotalContasAPagar(dtaDtaIni, dtaDtaFin, strCodCta, strCodEmp);
            End;
          End;

          With arrMetas [intIndiceMeta] Do
          fltPedAtu := fltPedAtu + arrParcelas[intContador].curValor;
        End;

      End;

      pCarregaPedidos(strNumPed, strCodCta, strCodEmp, strCodCmp, strCodEve);

      If (intValMetPed = 1) And (fltValMetTot = 0) Then
        Exit(True);

      Result := Result And fVerificaMetas(strCodEmp, strCodCta, '', strCodEve);
    End

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TMetaCentroCustoPedido.fCarregaMetas]');
    End;
  End;
End;



Procedure TMetaCentroCustoPedido.pCarregaPedidos(strNumPed, strCodCta, strCodEmp, strCodCmp, strCodEve: String);
  Var
    intContador: Integer;
    intMetas   : Integer;
    intQtdDup  : Integer;
    curTotalRes: Currency;
    objDuplicatas: TDuplicatasPedidoCompra;
    blnTemValores: Boolean;
    arrDuplicata: TarrDuplicata;
Begin
  pZeraDigDuplic(arrDuplicata);
  With FPedidos Do
  Begin
    objDuplicatas := TDuplicatasPedidoCompra.Create;

    Close;

    ParamByName('CODEMP').AsString   := strCodEmp;

    If fCfgSis('METPED') <> '1' Then
      ParamByName('CODCTA').AsString   := strCodCta;

    If (fCfgSis('METPED') = '5') OR (fCfgSis('METPED') = '6') Then
      ParamByName('CODEVE').AsString   := strCodEve;

    ParamByName('FORFIL').AsString   := fRetForFilialTodos;
    ParamByName('NUMPED').AsString   := strNumPed;

    If fCfgSis('METPED') = '1' Then
      ParamByName('CODCMP').AsString   := strCodCmp;
	  
    if fCfgSis('CONINC', varInteger) <> 1 Then
    Begin
      ParamByName('DTAINI').AsDateTime   := arrMetas[0].dtaDtaIni;
      ParamByName('DTAFIN').AsDateTime   := arrMetas[0].dtaDtaFin;
    End;

    Open;

    While Not Eof Do
    Begin
	
      if fCfgSis('CONINC', varInteger) <> 1 Then
      Begin
        For intMetas := Low(arrMetas) To High(arrMetas) Do
          arrMetas[intMetas].fltUsaPed := arrMetas[intMetas].fltUsaPed + FieldByName('TOTPED').AsFloat;
      End
      Else
	    Begin
        objDuplicatas.pCarregaParcelas(FieldByName('AUTGER').AsString);

        blnTemValores := objDuplicatas.fTemValores;

        intQtdDup := 0;
        curTotalRes := 0;

        fDigDuplicSemTela(arrDuplicata,
                intQtdDup,
                curTotalRes,
                FieldByName('CONPAG').AsString,
                0,
                FieldByName('TOTPED').AsFloat,
                False,
                False,
                IfThen(FieldByName('DTAENT').AsDateTime < VS_Date,
                     VS_Date,
                     FieldByName('DTAENT').AsDateTime),
                False);


        For intContador := 0 To intQtdDup -1 Do
        Begin
        If blnTemValores Then
          arrDuplicata[intContador].curValor := objDuplicatas.arrParcelas[intContador].curValor;

        For intMetas := Low(arrMetas) To High(arrMetas) Do
          If (StrToDate(arrDuplicata[intContador].dtaDtaVen) >= arrMetas[intMetas].dtaDtaIni) And
           (StrToDate(arrDuplicata[intContador].dtaDtaVen) <= arrMetas[intMetas].dtaDtaFin) Then
           arrMetas[intMetas].fltUsaPed := arrMetas[intMetas].fltUsaPed + arrDuplicata[intContador].curValor;

        End;
	  
	    End;

      Next;
    End;

    FreeAndNil(objDuplicatas);
  End;
End;

Procedure TMetaCentroCustoPedido.pInicializa;
Begin
  objLiberacao.Clear;
End;

Function TMetaCentroCustoPedido.fVerificaMetas(strCodEmp, strCodCta: String; AstrCodCmp: String = ''; strCodEve: String = ''): Boolean;
  Var
    intMetas   : Integer;
Begin

  Result := True;
  For intMetas := Low(arrMetas) To High(arrMetas) Do
    With arrMetas[intMetas] Do
    If (fFormataFloat(fltUsaPag + fltUsaPed + fltPedAtu, 2) > fFormataFloat(fltValMet, 2)) Then
    Begin
      Result := False;
      Break;
    End;

  If Not Result Then
  Begin
    pMontaMensagem(strCodEmp, strCodCta, AstrCodCmp, strCodEve);
  End;
End;


Procedure TMetaCentroCustoPedido.pMontaMensagem(strCodEmp, strCodCta: String; ACodCmp: String = ''; strCodEve: String = '');
  Var
    intMetas   : Integer;


Begin
  If objLiberacao.objMsgLibera.isempty Then
  Begin
    objLiberacao.objMsgLibera.pAddSeparador(108);
    If fCfgSis('METPED', varInteger) = 1 Then
      objLiberacao.objMsgLibera.pAddTexto('META POR PEDIDO DE COMPRA POR COMPRADOR ULTRAPASSADA', alCentro, teAmbos, '', 108)
    Else
      objLiberacao.objMsgLibera.pAddTexto('META DE PEDIDO DE COMPRA POR DESPESAS ULTRAPASSADA', alCentro, teAmbos, '', 108);

    objLiberacao.objMsgLibera.pAddSeparador(108);
  End;

  If blnTodasEmpresas then
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'       , 'Todas'                                                                    , 15)
  Else
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'       , strCodEmp + '-' + fRetNomeEmpresaSelec(strCodEmp)                          , 15);

  If fCfgSis('METPED', varInteger) <> 1 Then
    objLiberacao.objMsgLibera.pAddTextoCaption('Plano de Contas' , FormatMaskText('99.99.999;0;_', strCodCta) + '-' + fRetNomeConta(strCodCta), 15);

  If (fCfgSis('METPED', varString) = '5') Or (fCfgSis('METPED', varString) = '6') Then
    objLiberacao.objMsgLibera.pAddTextoCaption('Evento' , strCodEve + '-' + fRetNomEvento(strCodEve), 15);

  objLiberacao.objMsgLibera.pAddSeparador(108);
  objLiberacao.objMsgLibera.pAddQuebra;

  For intMetas := Low(arrMetas) To High(arrMetas) Do
  Begin
    With arrMetas[intMetas] Do
    Begin
      If fFormataFloat(fltUsaPag + fltUsaPed + fltPedAtu, 2) > fFormataFloat(fltValMet, 2) Then
      Begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor da Meta'                     , FloatToStrF(fltValMet, ffNumber, 12, 2)                                                  , 32);

        objLiberacao.objMsgLibera.pAddTextoCaption('Período'                           , FormatDateTime('DD/MM/YYYY', dtaDtaIni) + ' a ' + FormatDateTime('DD/MM/YYYY', dtaDtaFin), 32);

        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor utilizado até o momento'     , FloatToStrF(fltUsaPag + fltUsaPed, ffNumber, 12, 2)                                       , 32);
        If (fEmptyStr(FAutIncCTP)) Then
        Begin
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor desse Pedido de Compra'    , FloatToStrF(fltPedAtu, ffNumber, 12, 2)                                                   , 32);
          objLiberacao.objMsgLibera.pAddTextoCaption('Total com este Pedido de Compra' , FloatToStrF(fltUsaPag + fltUsaPed + fltPedAtu, ffNumber, 12, 2)                           , 32);
        End
        Else
        Begin
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor dessa Conta'               , FloatToStrF(fltPedAtu, ffNumber, 12, 2)                                                   , 32);
          objLiberacao.objMsgLibera.pAddTextoCaption('Total com esta Conta'            , FloatToStrF(fltUsaPag + fltUsaPed + fltPedAtu, ffNumber, 12, 2)                           , 32);
        End;

        objLiberacao.objMsgLibera.pAddSeparador(108);
        objLiberacao.objMsgLibera.pAddQuebra;
      End;
    End;
    If Not fEmptyStr(strCodFor) Then
    Begin
      If fEmptyStr(strForCGC) Then
        strForCGC := fRetFornecedorCGC(strCodFor);
      If fEmptyStr(strNomFor) Then
        strNomFor := fRetNomFornecedor(strCodFor);

      objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor', strCodFor + '-' + strNomFor        , 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'  , fFormataCpfCgc(strForCGC, fSetaPais), 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Comprador' , IIf(ACodCmp <> '', ACodCmp, FOpeRes) + '-' + fRetNomeOperador(IIf(ACodCmp <> '', ACodCmp, FOpeRes)), 10);

      objLiberacao.objMsgLibera.pAddSeparador(108);
    End;
    objLiberacao.objMsgLibera.pAddQuebra;
  End;
End;

Function TMetaCentroCustoPedido.fPedeSenha: Boolean;
var
  strCodigoLiberacao: String;
Begin
  If not objLiberacao.objMsgLibera.isEmpty Then
  Begin
    objLiberacao.strDirAce := 'METPEDCTA';
    If fCfgSis('METPED', varInteger) = 1 Then
      objLiberacao.strMsgSen := 'META DE PEDIDO DE COMPRA POR COMPRADOR'
    Else
      objLiberacao.strMsgSen := 'META DE PLANO DE CONTAS';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strOperador := strOperador;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;
    objLiberacao.tipCliFor := cfFornecedor;
    objLiberacao.strOpeEnv := FOpeRes;

    Result := objLiberacao.fLibera;

    strOperador := objLiberacao.strOperador;

    If Result Then
    Begin
      strCodigoLiberacao := fCodigoLiberacaoLogLib('METPEDCTA');
      pGeraMatrizLiberacao(strOperador,
                           strLoginUsuarioLogado,
                           objLiberacao.objMsgLibera.fGetMensagem,
                           'METPEDCTA',
                           strCodigoLiberacao,
                           '',
                           0 ,
                           '',
                           '',
                        False,
                           '',
                           0 ,
                           0 ,
                           0 ,
                           objLiberacao.strMsgSen);
    End;
  End

  Else Result := True;

End;


end.
