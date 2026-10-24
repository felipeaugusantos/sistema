unit untBalancoEstoqueAjuste;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  UniClientDataSet,
  untFuncoesSimples,
{$ENDIF}
  Uni,
  SysUtils,
  Classes,
  untCadLote,
  untConDet,
  untIFatEntregaFutura,
  untTFatEntregaFutura,
  untHistoricoBalanco;

function fSqlContagem(blnContadosAgora: Boolean; stlListItem, stlListLote: TStringList;
                      blnComFrete: Boolean = True; blnOnSubSelect: Boolean = False;
                      blnControlaContagem: Boolean = False;
                      strCodContador: String = '';
                      strLocFisContador: String = ''): String;

Function fSalvaContagem(strCodIte: String;
  fltSalCon, fltSalMl: Double; intOrdCon: Integer; blnSavLog, blnImpLis, blnConAcu: Boolean;
  intConEst: Integer; strCodDig, strIncHis: String; Owner : TComponent; strNumLot: String = ''; strLocFis: String = ''; strCodOpe : String = ''): Boolean;

procedure pZeraContagem(cdsConsulta: TUniClientDataSet; objCadLot: TCadLot;
                        stlListSelecao: TStringList; Owner : TComponent;
                        strLocFis: string = ''; strCodDig: String = '');

Function fAtivarItem(strCodIte: String; Var blnImpLis: Boolean): Boolean;

Function fSQLCamposDigColetivo: String;

implementation

uses
  untControleContagemBalancoEstoque;

Function fAtivarItem(strCodIte: String; Var blnImpLis: Boolean): Boolean;
Begin
  blnImpLis := False;
  Result := (fMensagem('', 'Esse item está inativo, deseja ativá-lo?', ['&Sim', '&Não']) = 1);

  If Result And
    (fCampoTabela('ITE_IMPLIS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]) <> 'S') And
    fPergunta('O produto está cadastrado como [Imprime Lista NÃO], com isso o mesmo não será ' +
               'exibido na consulta de produtos, deseja alterar para [Imprime Lista SIM]?') Then
    blnImpLis := True;
End;

procedure pAtivaItem(strCodIte: String);
  Var
    qryGen : TUniQuery;
Begin
  qryGen := fCriaQuery(Nil);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE CADITE SET ITE_ITEATI = "S" WHERE ITE_CODITE = :CODITE');
    ParamByName('CODITE').AsString := strCodIte;
    ExecSQL;
  End;

  FreeAndNil(qryGen);
End;

Function fSalvaContagem(strCodIte: String;
  fltSalCon, fltSalMl: Double; intOrdCon: Integer; blnSavLog, blnImpLis, blnConAcu: Boolean;
  intConEst: Integer; strCodDig, strIncHis: String; Owner : TComponent; strNumLot: String = ''; strLocFis: String = ''; strCodOpe : String = ''): Boolean;
  Var
    qryGen : TUniQuery;
    strSql : String;
    fltEntFut: Double;
    blnContagemControlada: Boolean;
begin
  Try
    If intConEst = 2 Then
      fltEntFut := TEntregaFutura.New(
                     TParamEF.New()
                       .CodIte(strCodIte)
                       .CodEmp(VS_strCodEmp)
                       .TipoTE(tteTodas)
                     ).Total()
    Else fltEntFut := 0;

    TConDet.fGravaConDet(blnConAcu, Owner, strCodIte, VS_strCodEmp, strNumLot, 'S', '', fltSalCon, fltSalMl, (intConEst = 1), False, strCodOpe );

    fStartTransaction;

    THistoricoBalanco.pIncluiHistorico(VS_strCodEmp, strCodIte, strNumLot, strCodDig, strIncHis, fltSalCon, fltSalMl);

    strSql := '';
    strSql := strSql + ' UPDATE    ';
    strSql := strSql + '   ITEGER  ';
    strSql := strSql + ' SET       ';
    blnContagemControlada := TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco;
    If Not blnContagemControlada Then
    Begin
      If intConEst = 1 Then
      Begin
        If blnConAcu Then
        Begin
          strSql := strSql + '   ITE_SALCON = IFNULL(ITE_SALCON,0) + :SALCON, ';
          strSql := strSql + '   ITE_GMLCON = IFNULL(ITE_GMLCON,0) + :GMLCON, ';
        End
        Else
        Begin
          strSql := strSql + '   ITE_SALCON = :SALCON, ';
          strSql := strSql + '   ITE_GMLCON = :GMLCON, ';
        End;

      End
      Else
      Begin
        strSql := strSql + '   ITE_SALCON = :SALCON,  ';
        strSql := strSql + '   ITE_GMLCON = :GMLCON,  ';

        strSql := strSql + '   ITE_DIFSAL = IFNULL(ITE_SALDOS, 0) - :SALFIS, ';
        strSql := strSql + '   ITE_DIF_ML = IFNULL(ITE_SAL_ML, 0) - :GMLCON, ';
      End;
    End;

    strSql := strSql + '   ITE_DIGCON = "S",        ';
    strSql := strSql + '   ITE_ORDCON = :ORDCON     ';

    If blnImpLis Then
      strSql := strSql + ' , ITE_IMPLIS = "S"  ';

    strSql := strSql + ' WHERE                      ';
    strSql := strSql + '   ITE_CODITE = :CODITE AND ';
    strSql := strSql + '   ITE_CODEMP = :CODEMP     ';

    qryGen := fCriaQuery(Nil);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSql);
      If Not blnContagemControlada Then
      Begin

        ParamByName('SALCON').AsFloat   := fltSalCon;
        ParamByName('GMLCON').AsFloat   := fltSalMl;

        If intConEst = 2 Then
          ParamByName('SALFIS').AsFloat := fltSalCon - fltEntFut;
      End
      Else
        ParamByName('ORDCON').AsInteger := intOrdCon;
      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('CODEMP').AsString  := VS_strCodEmp;

      ExecSQL;

      pAtivaItem(strCodIte);

      If blnSavLog Then
        fGravaLogContEst(strCodDig, strCodIte, '', fltSalCon, fltSalMl);
      
      If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
        TControleContagemBalancoEstoque.pGravaContagem(strCodDig, strCodIte, strLocFis, fltSalCon, fltSalMl);

      fCommit;

    End;

    FreeAndNil(qryGen);

    Result := True;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('', E.Message + ' [fSalvaContagem]');
      Result := False;
    End;

  End;

end;

function fSqlContagem(blnContadosAgora: Boolean; stlListItem, stlListLote: TStringList;
                      blnComFrete: Boolean = True; blnOnSubSelect: Boolean = False;
                      blnControlaContagem: Boolean = False;
                      strCodContador: String = '';
                      strLocFisContador: String = ''): String;
Begin
  Result := '';
  If blnOnSubSelect Then
    Result := Result + ' SELECT  * FROM ( ';

  Result := Result + ' SELECT                              ';
  Result := Result + '   CAST("" AS CHAR(30))     AS ITE_NUMLOT, ';
  Result := Result + '   CONCAT(I.ITE_CODITE, "") AS AUTOINCREM, ';
  Result := Result + '   I.ITE_CODITE,                     ';
  Result := Result + '   I.ITE_DESITE,                     ';
  If blnControlaContagem Then
  Begin
    Result := Result + '   BLD_QTDITE AS ITE_SALCON,       ';
    Result := Result + '   BLD_QTDGML AS ITE_GMLCON,       ';
  End
  Else
  Begin
    Result := Result + '   G.ITE_SALCON,                     ';
    Result := Result + '   G.ITE_GMLCON,                     ';
  End;

  Result := Result + '   G.ITE_DIFSAL,                     ';
  Result := Result + '   G.ITE_DIF_ML,                     ';

  {Result := Result + '   (';
  Result := Result + '    ( SELECT ';
  Result := Result + '      IFNULL(SUM(FDO_QTDITE),0) AS QTD ';
  Result := Result + '      FROM ';
  Result := Result + '      FATGOR ';
  Result := Result + '      INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result + '      INNER JOIN EQUGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result + '      WHERE FGO_JAFATU = 0 ';
  Result := Result + '      AND FDO_CODITE = G.ITE_CODITE ';
  Result := Result + '      AND FDO_CODEMP = G.ITE_CODEMP ' ;
  Result := Result + '     ) ';

  Result := Result + '   + ';

  Result := Result + '    ( SELECT ';
  Result := Result + '      IFNULL(SUM(FDO_QTDITE),0) AS QTD ';
  Result := Result + '      FROM ';
  Result := Result + '      FATGOR ';
  Result := Result + '      INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result + '      INNER JOIN EQUGER ON EQU_NUMPED = FDO_NUMDOC AND EQU_TIPPED = "PD" AND EQU_EMPPED = FGO_CODEMP ';
  Result := Result + '      WHERE FGO_JAFATU = 0 ';
  Result := Result + '      AND FDO_CODITE = G.ITE_CODITE ';
  Result := Result + '      AND FDO_CODEMP = G.ITE_CODEMP ';
  Result := Result + '  )) AS QTDPED, '; }

  Result := Result + '     G.ITE_QTPD_V  AS QTDPED, ';

  If blnComFrete Then
  Begin
    If blnControlaContagem Then
      Result := Result + ' IFNULL(BLG_LOCFIS, IF(L.LOT_NUMLOT IS NULL, G.ITE_LOCFIS, L.LOT_LOCFIS)) AS LOCFIS, '
    Else
      Result := Result + ' IF(L.LOT_NUMLOT IS NULL, G.ITE_LOCFIS, L.LOT_LOCFIS) AS LOCFIS, ';
  End
  Else
    Result := Result + '   "" AS LOT_LOCFIS,                 ';
  Result := Result + '   G.ITE_ORDCON                     ';
  Result := Result + ' FROM                                ';
  Result := Result + '   ITEGER G                          ';
  Result := Result + ' INNER JOIN CADITE I ON              ';
  Result := Result + '   G.ITE_CODITE = I.ITE_CODITE AND   ';
  Result := Result + '   G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  If blnControlaContagem Then
  Begin
    Result := Result + ' INNER JOIN BALDET ON BLD_CODITE = G.ITE_CODITE';
    Result := Result + '                  AND BLD_STATUS = "A"';
    Result := Result + '                  AND BLD_CODOPE = ' + QuotedStr(strCodContador) ;
    Result := Result + ' INNER JOIN BALGER ON BALGER.AUTOINCREM = BLD_SEQGER';
    Result := Result + '                  AND BLG_CODEMP = G.ITE_CODEMP';
    Result := Result + '                  AND BLG_LOCFIS = ' + QuotedStr(strLocFisContador) ;
  End;

  If blnComFrete Then
  Begin
    Result := Result + ' LEFT JOIN CADLOT L ON               ';
    Result := Result + '   L.LOT_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '   L.LOT_CODEMP = ' + QuotedStr(VS_strCodEmp);
  End;

  Result := Result + ' WHERE                               ';
  Result := Result + '   G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  Result := Result + '   G.ITE_DIGCON = "S"                 ';

  If blnComFrete Then
    Result := Result + '   AND (L.LOT_CODITE IS NULL)       ';

  If blnContadosAgora Then
  Begin
    If (stlListItem.Count > 0) Then
      Result := Result + ' AND I.ITE_CODITE IN (' + fCommaText(stlListItem) + ') '
    Else
     Result := Result + ' AND FALSE ';
  End;



  If blnComFrete Then
  Begin
    Result := Result + ' UNION ALL                           ';

    Result := Result + ' SELECT                              ';
    Result := Result + '   L.LOT_NUMLOT AS ITE_NUMLOT,       ';
    Result := Result + '   CONCAT(I.ITE_CODITE, L.AUTOINCREM) AS AUTOINCREM, ';
    Result := Result + '   I.ITE_CODITE,                     ';
    Result := Result + '   I.ITE_DESITE,                     ';
    Result := Result + '   L.LOT_SALCON AS ITE_SALCON,       ';
    Result := Result + '   L.LOT_ML_CON AS ITE_GMLCON,       ';
    Result := Result + '   L.LOT_DIFSAL AS ITE_DIFSAL,       ';
    Result := Result + '   L.LOT_DIF_ML AS ITE_DIF_ML,       ';

    Result := Result + '   0.000 AS QTDPED,                  ';

    If blnComFrete Then
      Result := Result + ' L.LOT_LOCFIS,                        '
    Else
      Result := Result + ' "" AS LOT_LOCFIS,                    ';
    Result := Result + '   L.LOT_ORDCON AS ITE_ORDCON        ';
    Result := Result + ' FROM                                ';
    Result := Result + '   CADLOT L                          ';
    Result := Result + ' INNER JOIN CADITE I ON              ';
    Result := Result + '   L.LOT_CODITE = I.ITE_CODITE       ';
    Result := Result + ' WHERE                               ';
    Result := Result + '   L.LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
    Result := Result + '   L.LOT_DIGCON = "S"                ';

    If blnContadosAgora Then
    Begin
      If Assigned(stlListLote) And (stlListLote.Count > 0) Then
        Result := Result + ' AND L.AUTOINCREM IN ( ' + fCommaText(stlListLote) + ') '
      Else
        Result := Result + ' AND FALSE ';
    End;

  End;

  If blnOnSubSelect Then
  Begin
    Result := Result + ') TMP ';
    Result := Result + ' WHERE TRUE ';
  End;

End;

procedure pZeraContagemItem(strCodIte: String; AOwner : TComponent; strLocFis: string = ''; strCodDig: String = '');
  Var
    qryGen : TUniQuery;
    strSql : String;
begin
  If (strCodDig <> '') And  (strLocFis <> '') Then
  Begin
     TControleContagemBalancoEstoque.pCancelaContagem(strCodDig, strCodIte, strLocFis);


  End
  Else
  Begin
    strSql := '';
    strSql := strSql + ' UPDATE                                         ';
    strSql := strSql + '   ITEGER                                       ';
    strSql := strSql + ' SET                                            ';
    strSql := strSql + '   ITE_ORDCON = 0,                              ';
    strSql := strSql + '   ITE_SALCON = 0,                              ';
    strSql := strSql + '   ITE_GMLCON = 0,                              ';
    strSql := strSql + '   ITE_DIFSAL = 0,                              ';
    strSql := strSql + '   ITE_DIF_ML = 0,                              ';
    strSql := strSql + '   ITE_DIGCON = "N"                             ';
    strSql := strSql + ' WHERE                                          ';
    strSql := strSql + '   ITE_CODITE =:CODITE AND                      ';
    strSql := strSql + '   ITE_CODEMP =:CODEMP                          ';

    qryGen := fCriaQuery(Nil);

    With qryGen Do
    Begin
      TConDet.fGravaConDet(fCfgSis('CONACU', varBoolean), AOwner, strCodIte, VS_strCodEmp, '', 'N', '', 0, 0 );

      THistoricoBalanco.pLimpaHistoricoSaldoProduto('', strCodIte, Nil);

      Close;
      SQL.Clear;
      SQL.Add(strSql);

      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('CODEMP').AsString  := VS_strCodEmp;

      ExecSQL;

    End;

    FreeAndNil(qryGen);
  End;

End;

procedure pZeraContagemLote(strCodIte: String; objCadLot: TCadLot);
begin
  objCadLot.pZeraContagemLote(strCodIte);
End;

procedure pZeraContagem(cdsConsulta: TUniClientDataSet; objCadLot: TCadLot;
                        stlListSelecao: TStringList; Owner : TComponent;
                        strLocFis: string = ''; strCodDig: String = '');
  Var
    intContador: Integer;
begin

  Try
    fStartTransaction;

    pZeraContagemItem(cdsConsulta.FieldByName('ITE_CODITE').AsString, Owner, strLocFis, strCodDig);

    If Not fEmptyStr(Trim(cdsConsulta.FieldByName('ITE_NUMLOT').AsString)) Then
      pZeraContagemLote(cdsConsulta.FieldByName('ITE_CODITE').AsString, objCadLot);

    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pZeraContagem]');
    End;
  End;

  With cdsConsulta Do
  Begin
    For intContador := 0 To stlListSelecao.Count - 1 Do
    Begin

      If FieldByName('ITE_CODITE').AsString = Copy(stlListSelecao[intContador], 2, fTamCodIte) Then
      Begin
        stlListSelecao.Delete(intContador);
        Break;
      End;

    End;

  End;
End;

Function fSQLCamposDigColetivo: String;
  Var
    strSQL: String;
Begin
  strSQL := strSQL + ' SELECT                    ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   ITE_ITEATI AS ITEATI, ';
  strSQL := strSQL + '   IFNULL(ITE_CNV_ML, 0) AS CNV_ML, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   LOT_NUMLOT AS NUMLOT, ';
  strSQL := strSQL + '   LOT_NUMLOT AS NUMLOT, ';
  strSQL := strSQL + '   L.AUTOINCREM AS AUTLOT, ';
  strSQL := strSQL + '   IF(LOT_NUMLOT IS NULL, I.ITE_LOCFIS, L.LOT_LOCFIS) AS LOCFIS, ';
  strSQL := strSQL + '   IFNULL(IF(LOT_NUMLOT IS NULL, ITE_DIGCON, LOT_DIGCON), "N")    AS CONTAD, ';

  strSQL := strSQL + '   IFNULL(IF(LOT_NUMLOT IS NULL, ITE_SALDOS, LOT_SALDOS), 0.0000) AS SALDOS, ';

  strSQL := strSQL + '   IF((IFNULL(ITE_CNV_ML, 0) > 0) AND (LOT_NUMLOT IS NULL), ';
  strSQL := strSQL + '       IFNULL(ITE_SAL_ML, 0.0000), NULL + 0.0000)                 AS SAL_ML, ';

  strSQL := strSQL + '   IF(LOT_NUMLOT IS NULL,                                            ';
  strSQL := strSQL + '        IF(IFNULL(ITE_DIGCON, "") = "S", ITE_SALCON, NULL + 0.0000), ';
  strSQL := strSQL + '        IF(IFNULL(LOT_DIGCON, "") = "S", LOT_SALCON, NULL + 0.0000)) AS SALCON, ';

  strSQL := strSQL + '     IF(LOT_NUMLOT IS NULL,  ';
  strSQL := strSQL + '          IF(IFNULL(ITE_DIGCON, "") = "S", ITE_GMLCON, NULL + 0.0000),  ';
  strSQL := strSQL + '          IF(IFNULL(LOT_DIGCON, "") = "S", LOT_ML_CON, NULL + 0.0000)) AS GMLCON,  ';

  strSQL := strSQL + '   NULL + 0.0000                                  AS DIGCON, ';
  strSQL := strSQL + '   NULL + 0.0000                                  AS DIG_ML, ';

  strSQL := strSQL + '   LOT_MEDL_A, ';
  strSQL := strSQL + '   LOT_MEDL_L, ';

  strSQL := strSQL + '   NULL + 0 AS LOT_QTDCHA , ';
  strSQL := strSQL + '   LOT_CHAPA_, ';

  strSQL := strSQL + '   0.0000                                         AS AUXCON, ';
  strSQL := strSQL + '   0.0000                                         AS AUX_ML, ';
  strSQL := strSQL + '   IFNULL(ITE_QTPD_V, 0) + IFNULL(ITE_QTPD_F, 0)  AS SALRES  ';  // PEDIDO
  strSQL := strSQL + ' FROM  ';

  strSQL := strSQL + '   CADITE C ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI       ';

  strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        I.ITE_CODEMP = :CODEMP          ';

  strSQL := strSQL + ' LEFT JOIN CADLOT  L ON LOT_CODITE = I.ITE_CODITE AND  ';
  strSQL := strSQL + '                        LOT_CODEMP = I.ITE_CODEMP AND  ';
  strSQL := strSQL + '                        LOT_TRANSI = "N"               ';

  strSQL := strSQL + ' LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP ';

  Result := strSQL;
End;

end.
