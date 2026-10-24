unit untDocGarantias;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient;

Type

  TLeDocumentoGA = Class(TLeDocumento)
  Private
    cdsMovGag,
    cdsMovGad: TZClient;

    Function fSQLMovGag: String;
    function fSqlMovGagGR: String;

    Function fSQLMovGad: String;
    function fSQLMovGadGR: String;
    Function fSQLMovGadCliente: String;

    Function fInsereClientMovgad: Boolean;
    Function fInsereClientMovgag: Boolean;
    Function fMarcarSeparacaoComoImpresso: Boolean;
    procedure pImportarMovGadCDSExterno(cdsExterno: TZClient);
    procedure pImportarMovGaGCDSExterno(cdsExterno: TZClient);
    function  fValidaPermissaoImportacao(cdsExterno: TZClient): boolean;

  Public
    blnReimpressaoGR: Boolean;
    constructor Create(Owner: TComponent); Override;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;

  protected
    procedure pSetaParametrosCadcli; override;
  End;

implementation

uses DB, untTypesSistema, untEtiquetaGarantias;

Function TLeDocumentoGA.fSQLMovGag: String;
  Var
    strAbrev, strSQL: String;
Begin
  If recDocume.blnReimpressaoGR then
  begin
    Result := fSqlMovGagGR;
    Exit;
  end;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';
  strSQL := strSQL + '    GAD_CODFOR AS CODFOR, ';
  If FtpeTipEtq = tpeContGR  then
     strSQL := strSQL + ' R.GER_ESPDOC AS ESPDOC,';

  strSQL := strSQL + '    GAG_NUMENT AS NUMGAR,   ';

  If tpeTipEtq = tpeContGr Then
     strSQL := strSQL + ' R.GER_NUMDOC AS NUMRET, '
  Else
     strSQL := strSQL + '    D.GAD_NUMRET AS NUMRET, ';

  strSQL := strSQL + '    D.GAD_NUMENV AS NUMENV, ';
  strSQL := strSQL + '    D.GAD_NUMDEV AS NUMDEV, ';
  strSQL := strSQL + '    D.GAD_DTARET AS DTARET, ';
  strSQL := strSQL + '    D.GAD_DTADEV AS DTADEV, ';
  strSQL := strSQL + '    NULL         AS DTAENV, ';
  strSQL := strSQL + '    G.GAG_OBSER1 AS GAGOB1, ';
  strSQL := strSQL + '    G.GAG_OBSER2 AS GAGOB2, ';
  strSQL := strSQL + '    D.GAD_OBSP_1 AS GADOB1, ';
  strSQL := strSQL + '    D.GAD_OBSP_2 AS GADOB2, ';

  strSQL := strSQL + '    D.GAD_OBSF_1 AS OBSRF1,';
  strSQL := strSQL + '    D.GAD_OBSF_2 AS OBSRF2,';
  strSQL := strSQL + '    D.GAD_OBSF_3 AS OBSRF3,';
  strSQL := strSQL + '    D.GAD_OBSF_4 AS OBSRF4,';
  strSQL := strSQL + '    D.GAD_OBSF_5 AS OBSRF5, ';
  strSQL := strSQL + '    D.GAD_VALITE AS VALITE, ';


  strSQL := strSQL + '    R.GER_MEN001 AS MEN001, ';
  strSQL := strSQL + '    R.GER_MEN002 AS MEN002, ';
  strSQL := strSQL + '    R.GER_MENEXP AS MENEXP, ';
  strSQL := strSQL + '    R.GER_MENEX2 AS MENEX2, ';
  strSQL := strSQL + '    R.GER_MENEX3 AS MENEX3, ';
  strSQL := strSQL + '    R.GER_MENEX4 AS MENEX4, ';

  If pos(recDocume.strEspDoc, '_GA_GC_') > 0 Then
  begin
    strSQL := strSQL + '    R.GER_CONPAG  AS CONPAG, ';
    strSQL := strSQL + '    R.GER_CODCND  AS CODCND, ';
    strSQL := strSQL + '    CC.CND_DESCRI AS DESCND, ';
    strSQL := strSQL + '    R.GER_CODFPG  AS CODFPG, ';
    strSQL := strSQL + '    FP.FPG_DESCRI AS DESFPG, ';
    strSQL := strSQL + '    R.GER_CODDIG  AS CODDIG, ';
    strSQL := strSQL + '    OD.OPE_NOMOPE AS NOMDIG, ';
    strSQL := strSQL + '    IFNULL(ICD_VALORI, 0) AS TDPORI, ';
    strSQL := strSQL + '    IFNULL(ICD_VALFCP, 0) AS FCPDOR, ';
  end
  else
  begin
    strSQL := strSQL + '    ""   AS CONPAG, ';
    strSQL := strSQL + '    ""   AS CODCND, ';
    strSQL := strSQL + '    ""   AS DESCND, ';
    strSQL := strSQL + '    ""   AS CODFPG, ';
    strSQL := strSQL + '    ""   AS DESFPG, ';
    strSQL := strSQL + '    ""   AS CODDIG, ';
    strSQL := strSQL + '    ""   AS NOMDIG, ';
    strSQL := strSQL + '    0.00 AS TDPORI, ';
    strSQL := strSQL + '    0.00 AS FCPDOR, ';
  end;

  If pos(recDocume.strEspDoc, '_GR_GC_NF') > 0 Then
  Begin
    if recDocume.strEspDoc = 'GC' then
      strAbrev := 'DEV'
    else if pos(recDocume.strEspDoc, '_GR_NF') > 0 then
      strAbrev := 'RET';
    strSQL := strSQL + ' (SELECT COUNT(DISTINCT D2.GAD_CODITE) ';
    strSQL := strSQL + '    FROM MOVGAD D2                        ';
    strSQL := strSQL + '   WHERE D2.GAD_NUM' + strAbrev + ' = D.GAD_NUM' + strAbrev;
    strSQL := strSQL + '     AND D2.GAD_CODEMP = D.GAD_CODEMP      ';
    strSQL := strSQL + '     AND COALESCE(D2.GAD_QTD' + strAbrev + ', 0) > 0 ) AS QTDEGR, ';
  End;

  If recDocume.blnDocSep Then
  Begin
    strSQL := strSQL + ' S.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + ' I.ITE_CNV_ML,      ';
    strSQL := strSQL + ' S.ITE_SAL_ML,      ';
    strSQL := strSQL + ' 0.000 AS SALDIS, ';
  End;

  strSQL := strSQL + '  If((SELECT COUNT(0) FROM MOVGAD ';
  strSQL := strSQL + '  WHERE GAD_SEQGAG = G.AUTOINCREM ';
  strSQL := strSQL + '    AND GAD_SCREDI = 2) > 0, "S", "N" ) AS GERCRE, ';

  strSQL := strSQL + '    DET_DTAENT AS DTAENT, ';
  strSQL := strSQL + '    DET_HORENT AS HORENT, ';
  strSQL := strSQL + '    DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '    DET_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '    DET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '    DET_CODVEN AS CODVEN, ';
  strSQL := strSQL + '    C.CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '    GAG_NOMCON AS NOMCON, ';
  strSQL := strSQL + '    GAG_ENDCON AS ENDCON, ';
  strSQL := strSQL + '    GAG_BAICON AS BAICON, ';
  strSQL := strSQL + '    GAG_CEPCON AS CEPCON, ';
  strSQL := strSQL + '    GAG_CIDCON AS CIDCON, ';
  strSQL := strSQL + '    GAG_TELCON AS TELCON, ';
  strSQL := strSQL + '    GAG_CGCCPF AS CGCCPF, ';
  strSQL := strSQL + '    GAG_CGCCON AS CGCCON, ';
  strSQL := strSQL + '    GAG_IESCON AS IESCON, ';
  strSQL := strSQL + '    GAG_R_GCON AS R_GCON, ';
  strSQL := strSQL + '    GAG_CODFAV AS CODFAV, ';
  strSQL := strSQL + '    F.CLI_NOMCLI AS NOMFAV, ';

  If recDocume.blnPenExp Then
    strSQL := strSQL + ' "S" AS IMPDPN, '
  Else
    strSQL := strSQL + ' "N" AS IMPDPN, ';

  strSQL := strSQL + ' VN.OPE_NOMOPE AS NOMVEN, ';
//  GER_TOTPRO, GER_VLRCON

  If pos(recDocume.strEspDoc, '_GR_') > 0 Then
  begin
    strSQL := strSQL + ' R.GER_TOTPRO AS VLRPRO, ';
    strSQL := strSQL + ' R.GER_VLRCON AS VLRCON, ';
  end
  else begin
    strSQL := strSQL + '    (SELECT SUM(GAD_VALITE) FROM MOVGAD WHERE G.AUTOINCREM = GAD_SEQGAG) AS VLRPRO, ';
    strSQL := strSQL + '    (SELECT SUM(GAD_VALITE) FROM MOVGAD WHERE G.AUTOINCREM = GAD_SEQGAG) AS VLRCON, ';
  end;
  strSQL := strSQL + '   G.AUTOINCREM AS AUTINC  ';
  strSQL := strSQL + ' , D.GAD_NUMDOC AS NUMORI ';
  strSQL := strSQL + ' , D.GAD_ESPDOC AS ESPORI ';

  strSQL := strSQL + ' ,       0.00 AS TOTUNI ';
  strSQL := strSQL + ' ,       0.00 AS TOTORI ';
  strSQL := strSQL + ' ,       0.00 AS VALBRU ';
  strSQL := strSQL + ' , DET_QTDITE AS QTDITE ';
  strSQL := strSQL + ' , DET_UNITAR AS VALUNI ';
  strSQL := strSQL + ' , DET_UNIORI AS UNIORI ';
  strSQL := strSQL + ' , DET_VALIPI AS VALIPI ';
  strSQL := strSQL + ' , DET_VALRET AS VALRET ';
  strSQL := strSQL + ' , GER_TOTIPI AS TOTIPI ';
  strSQL := strSQL + ' , GER_TOTRET AS TOTRET ';
  strSQL := strSQL + ' , GER_TOTFRE AS TOTFRE ';
  strSQL := strSQL + ' , ' + fSQLTipoFrete('R.GER_TIPFRE') + ' AS DESFRE ';
  strSQL := strSQL + ' , GER_DESESP AS DESESP ';
  strSQL := strSQL + ' , D.GAD_UNICRD AS UNICRD ';

  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + '  MOVGAG G ';

  strSQL := strSQL + '    INNER JOIN CADCLI  C ON G.GAG_CODCLI = C.CLI_CODCLI ';
  strSQL := strSQL + '    LEFT JOIN CADCLI  F ON G.GAG_CODFAV = F.CLI_CODCLI ';
  strSQL := strSQL + '    INNER JOIN MOVGAD  D ON G.AUTOINCREM = D.GAD_SEQGAG ';

  If  pos(recDocume.strEspDoc, '_GA_GC_') > 0 then
  begin
    strSQL := strSQL + '    INNER JOIN MOVGRC GRC ON GRC.GRC_SEQGAD = D.AUTOINCREM ';
    strSQL := strSQL + '    LEFT JOIN MOVDET M    ON M.AUTOINCREM  = GRC.GRC_SEQDET ';
    strSQL := strSQL + '    LEFT JOIN MOVGER R    ON R.AUTOINCREM  = M.DET_SEQGER ';
    strSQL := strSQL + '    LEFT JOIN MOVTRI T    ON T.DET_SEQGER  = M.AUTOINCREM ';
    strSQL := strSQL + '    LEFT JOIN CADCND CC   ON CC.CND_CODIGO = R.GER_CODCND ';
    strSQL := strSQL + '    LEFT JOIN CADFPG FP   ON FP.FPG_CODIGO = R.GER_CODFPG ';
    strSQL := strSQL + '    LEFT JOIN CADOPE OD   ON OD.OPE_CODOPE = R.GER_CODDIG ';
    strSQL := strSQL + '    LEFT JOIN MOVICD ID   ON ID.ICD_SEQGER = M.AUTOINCREM ';
  end
  else
  begin
    strSQL := strSQL + '    LEFT  JOIN MOVTRI T ON T.DET_SEQGAD = D.AUTOINCREM     ';
    strSQL := strSQL + '    LEFT  JOIN MOVDET M ON T.DET_SEQGER = M.AUTOINCREM AND ';
    strSQL := strSQL + '                           M.DET_CODCLI = G.GAG_CODCLI     ';

    strSQL := strSQL + '    LEFT  JOIN MOVGER R ON R.AUTOINCREM = M.DET_SEQGER     ';
    strSQL := strSQL + '    AND R.GER_NUMDOC = G.GAG_NUMENT                        ';
  end;

  If recDocume.blnDocSep Then
  Begin
    strSQL := strSQL + '  LEFT JOIN CADITE I ON I.ITE_CODITE = M.DET_CODITE ';
    strSQL := strSQL + '  LEFT JOIN ITEGER S ON S.ITE_CODITE = M.DET_CODITE ';
    strSQL := strSQL + '                    AND S.ITE_CODEMP = M.DET_CODEMP ';
  End;

  strSQL := strSQL + '    LEFT JOIN CADOPE VN ON VN.OPE_CODOPE = DET_CODVEN ';

  strSQL := strSQL + ' WHERE ';

  With recDocume Do
  Begin
    if strEspDoc = 'GC' then
    Begin
      strSQL := strSQL + '   M.DET_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '   M.DET_ESPDOC = "GC"    AND ';
      strSQL := strSQL + '   M.DET_CODEMP = :CODEMP     ';
    End
    Else If pos(recDocume.strEspDoc, '_GR_NF') > 0 Then
    Begin
      strSQL := strSQL + '  D.GAD_NUMRET = :NUMDOC AND ';
      strSQL := strSQL + '  D.GAD_CODEMP = :CODEMP     ';
    End
    Else If pos(recDocume.strEspDoc, '_GA') > 0 Then
    Begin
      strSQL := strSQL + '  GRC.GRC_OPCDOC IN ("GA","NE","DV","OE") AND ';

      strSQL := strSQL + '     ( ((M.DET_NUMDOC = :NUMDOC) ';
      strSQL := strSQL + '         AND (M.DET_ESPDOC = "GA") ';
      strSQL := strSQL + '         AND (M.DET_CODEMP = :CODEMP) ';
      strSQL := strSQL + '         AND (R.GER_NUMDOC = G.GAG_NUMENT) ) OR ';

      strSQL := strSQL + '       ((G.GAG_NUMENT = :NUMDOC) ';
      strSQL := strSQL + '         AND (G.GAG_CODEMP = :CODEMP) ';
      strSQL := strSQL + '         AND (GRC.GRC_OPCDOC IN ("DV","OE","NE")) ';
      strSQL := strSQL + '         AND (R.GER_ESPDOC = "NF"))) ';
    End
    Else
    Begin
      strSQL := strSQL + '  GAG_NUMENT = :NUMDOC  AND ';
      strSQL := strSQL + '  GAG_CODEMP = :CODEMP      ';
    End;
  End;

  If recDocume.blnDocCan Then
    strSQL := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGAG','DEL_MOVGAG'), 'MOVGAD', 'DEL_MOVGAD'), 'MOVTRI', 'DEL_MOVTRI'),'MOVDET','DEL_MOVDET'), 'MOVGRC', 'DEL_MOVGRC'), 'MOVGER', 'DEL_MOVGER');

  Result := strSQL;
End;

function TLeDocumentoGA.fSqlMovGagGR: String;
begin
  Result := ' SELECT DISTINCT                      ';
  Result := Result + '     GAD_CODFOR AS CODFOR,   ';
  Result := Result + '     R.GER_ESPDOC AS ESPDOC, ';
  Result := Result + '     GAG_NUMENT AS NUMGAR,   ';
  Result := Result + '     R.GER_NUMDOC AS NUMRET, ';
  Result := Result + '     D.GAD_NUMENV AS NUMENV, ';
  Result := Result + '     D.GAD_NUMDEV AS NUMDEV, ';
  Result := Result + '     D.GAD_DTARET AS DTARET, ';
  Result := Result + '     D.GAD_DTADEV AS DTADEV, ';
  Result := Result + '     NULL AS DTAENV,         ';
  Result := Result + '     G.GAG_OBSER1 AS GAGOB1, ';
  Result := Result + '     G.GAG_OBSER2 AS GAGOB2, ';
  Result := Result + '     D.GAD_OBSP_1 AS GADOB1, ';
  Result := Result + '     D.GAD_OBSP_2 AS GADOB2, ';
  Result := Result + '     D.GAD_OBSF_1 AS OBSRF1, ';
  Result := Result + '     D.GAD_OBSF_2 AS OBSRF2, ';
  Result := Result + '     D.GAD_OBSF_3 AS OBSRF3, ';
  Result := Result + '     D.GAD_OBSF_4 AS OBSRF4, ';
  Result := Result + '     D.GAD_OBSF_5 AS OBSRF5, ';
  Result := Result + '     R.GER_MEN001 AS MEN001, ';
  Result := Result + '     R.GER_MEN002 AS MEN002, ';
  Result := Result + '     R.GER_MENEXP AS MENEXP, ';
  Result := Result + '     R.GER_MENEX2 AS MENEX2, ';
  Result := Result + '     R.GER_MENEX3 AS MENEX3, ';
  Result := Result + '     R.GER_MENEX4 AS MENEX4, ';
  Result := Result + '     0 AS QTDEGR,            ';

  Result := Result + '     "" AS GERCRE, ';
  Result := Result + '     DET_DTAENT AS DTAENT,   ';
  Result := Result + '     DET_HORENT AS HORENT,   ';
  Result := Result + '     DET_NUMDOC AS NUMDOC,   ';
  Result := Result + '     DET_ESPDOC AS ESPDOC,   ';
  Result := Result + '     DET_CODEMP AS CODEMP,   ';
  Result := Result + '     DET_CODVEN AS CODVEN,   ';
  Result := Result + '     C.CLI_CODCLI AS CODCLI, ';
  Result := Result + '     GAG_NOMCON AS NOMCON,   ';
  Result := Result + '     GAG_ENDCON AS ENDCON,   ';
  Result := Result + '     GAG_BAICON AS BAICON,   ';
  Result := Result + '     GAG_CEPCON AS CEPCON,   ';
  Result := Result + '     GAG_CIDCON AS CIDCON,   ';
  Result := Result + '     GAG_TELCON AS TELCON,   ';
  Result := Result + '     GAG_CGCCPF AS CGCCPF,   ';
  Result := Result + '     GAG_CGCCON AS CGCCON,   ';
  Result := Result + '     GAG_IESCON AS IESCON,   ';
  Result := Result + '     GAG_R_GCON AS R_GCON,   ';
  Result := Result + '     GAG_CODFAV AS CODFAV,   ';
  Result := Result + '     F.CLI_NOMCLI AS NOMFAV, ';
  Result := Result + '     "N" AS IMPDPN,          ';
  Result := Result + '     "" AS NOMVEN,           ';
  Result := Result + '     R.GER_TOTPRO AS VLRPRO, ';
  Result := Result + '     R.GER_VLRCON AS VLRCON, ';
  Result := Result + '     G.AUTOINCREM AS AUTINC, ';
  Result := Result + '     D.GAD_UNICRD AS UNICRD  ';
  Result := Result + ' FROM                        ';
  Result := Result + ' MOVGER R                    ';
  Result := Result + ' JOIN MOVDET M ON M.DET_SEQGER = R.AUTOINCREM ';
  Result := Result + ' LEFT JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';
  Result := Result + ' JOIN MOVGAU U ON U.GAU_SEQDET = M.AUTOINCREM ';
  Result := Result + ' JOIN MOVGAD D ON D.AUTOINCREM = U.GAU_SEQGAD ';
  Result := Result + ' JOIN MOVGAG G ON G.AUTOINCREM = D.GAD_SEQGAG ';
  Result := Result + ' JOIN CADCLI C ON C.CLI_CODCLI = G.GAG_CODCLI ';
  Result := Result + ' LEFT JOIN CADCLI F ON F.CLI_CODCLI = G.GAG_CODFAV ';

  Result := Result + ' WHERE R.GER_NUMDOC = :NUMDOC ';
  Result := Result + ' AND R.GER_CODEMP = :CODEMP ';
  Result := Result + ' AND R.GER_ESPDOC IN ("NF","GR") ';

  Result := Result + ' UNION ';

  Result := Result + ' SELECT DISTINCT             ';
  Result := Result + '     GAD_CODFOR AS CODFOR,   ';
  Result := Result + '     GR.RFG_ESPDOC AS ESPDOC, ';
  Result := Result + '     GAG_NUMENT AS NUMGAR,   ';
  Result := Result + '     GR.RFG_NUMDOC AS NUMRET, ';
  Result := Result + '     D.GAD_NUMENV AS NUMENV, ';
  Result := Result + '     D.GAD_NUMDEV AS NUMDEV, ';
  Result := Result + '     GR.RFG_DTAENT AS DTARET, ';
  Result := Result + '     D.GAD_DTADEV AS DTADEV, ';
  Result := Result + '     NULL AS DTAENV,         ';
  Result := Result + '     G.GAG_OBSER1 AS GAGOB1, ';
  Result := Result + '     G.GAG_OBSER2 AS GAGOB2, ';
  Result := Result + '     D.GAD_OBSP_1 AS GADOB1, ';
  Result := Result + '     D.GAD_OBSP_2 AS GADOB2, ';
  Result := Result + '     D.GAD_OBSF_1 AS OBSRF1, ';
  Result := Result + '     D.GAD_OBSF_2 AS OBSRF2, ';
  Result := Result + '     D.GAD_OBSF_3 AS OBSRF3, ';
  Result := Result + '     D.GAD_OBSF_4 AS OBSRF4, ';
  Result := Result + '     D.GAD_OBSF_5 AS OBSRF5, ';
  Result := Result + '     "" AS MEN001, ';
  Result := Result + '     "" AS MEN002, ';
  Result := Result + '     "" AS MENEXP, ';
  Result := Result + '     "" AS MENEX2, ';
  Result := Result + '     "" AS MENEX3, ';
  Result := Result + '     "" AS MENEX4, ';
  Result := Result + '     GR.QTDEGR AS QTDEGR,            ';

  Result := Result + '     "" AS GERCRE, ';

  Result := Result + '     RFG_DTAENT AS DTAENT,   ';
  Result := Result + '     0 AS HORENT,   ';
  Result := Result + '     RFG_NUMDOC AS NUMDOC,   ';
  Result := Result + '     RFG_ESPDOC AS ESPDOC,   ';
  Result := Result + '     RFG_CODEMP AS CODEMP,   ';
  Result := Result + '     "" AS CODVEN,   ';
  Result := Result + '     C.CLI_CODCLI AS CODCLI, ';
  Result := Result + '     GAG_NOMCON AS NOMCON,   ';
  Result := Result + '     GAG_ENDCON AS ENDCON,   ';
  Result := Result + '     GAG_BAICON AS BAICON,   ';
  Result := Result + '     GAG_CEPCON AS CEPCON,   ';
  Result := Result + '     GAG_CIDCON AS CIDCON,   ';
  Result := Result + '     GAG_TELCON AS TELCON,   ';
  Result := Result + '     GAG_CGCCPF AS CGCCPF,   ';
  Result := Result + '     GAG_CGCCON AS CGCCON,   ';
  Result := Result + '     GAG_IESCON AS IESCON,   ';
  Result := Result + '     GAG_R_GCON AS R_GCON,   ';
  Result := Result + '     GAG_CODFAV AS CODFAV,   ';
  Result := Result + '     F.CLI_NOMCLI AS NOMFAV, ';
  Result := Result + '     "N" AS IMPDPN,          ';
  Result := Result + '     "" AS NOMVEN,           ';
  Result := Result + '     GR.TOTPRO AS VLRPRO, ';
  Result := Result + '     GR.VLRCON AS VLRCON, ';
  Result := Result + '     GR.AUTOINCREM AS AUTINC, ';
  Result := Result + '     D.GAD_UNICRD AS UNICRD  ';

  Result := Result + ' FROM (SELECT A.AUTOINCREM, A.RFG_CODFOR, A.RFG_DTAENT, A.RFG_NUMDOC, A.RFG_ESPDOC, A.RFG_CODEMP, ';
  Result := Result + '              A2.QTDEGR, A2.VLRCON, A2.TOTPRO';
  Result := Result + '       FROM GAGRFG A ';

  Result := Result + '       JOIN (SELECT  AUTOINCREM, ';
  Result := Result + '                     SUM(@QTDITE := IFNULL(RFD_QTDRET,0)+ IFNULL(RFD_QTDREF,0)+ IFNULL(RFD_QTDBAI,0)) AS QTDEGR, ';
  Result := Result + '                     SUM(@QTDITE * RFD_UNICON) AS VLRCON, ';
  Result := Result + '                     SUM(@QTDITE * RFD_VALITE) AS TOTPRO ';
  Result := Result + '             FROM GAGRFD ';
  Result := Result + '             GROUP BY AUTOINCREM) A2 ON A2.AUTOINCREM = A.AUTOINCREM ) GR ';

  Result := Result + ' INNER JOIN GAGRFD GR2 ON GR2.AUTOINCREM = GR.AUTOINCREM ';
  Result := Result + ' INNER JOIN MOVGAU U ON U.AUTOINCREM = GR2.RFD_SEQGAU ';
  Result := Result + ' INNER JOIN MOVGAE E ON U.GAU_SEQGAE = E.AUTOINCREM   ';
  Result := Result + ' LEFT JOIN MOVDET M ON E.GAE_INCENV = M.AUTOINCREM  ';
  Result := Result + ' LEFT JOIN MOVGER R ON M.DET_SEQGER = R.AUTOINCREM ';
  Result := Result + ' LEFT JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';
  Result := Result + ' LEFT JOIN MOVDET M2 ON M2.AUTOINCREM = U.GAU_SEQDET ';


  Result := Result + ' JOIN MOVGAD D ON D.AUTOINCREM = U.GAU_SEQGAD ';
  Result := Result + ' JOIN MOVGAG G ON G.AUTOINCREM = D.GAD_SEQGAG ';
  Result := Result + ' JOIN CADCLI C ON C.CLI_CODCLI = G.GAG_CODCLI ';
  Result := Result + ' LEFT JOIN CADCLI F ON F.CLI_CODCLI = G.GAG_CODFAV ';

  Result := Result + ' WHERE     GR.RFG_NUMDOC = :NUMDOC ';
  Result := Result + '       AND GR.RFG_CODEMP = :CODEMP ';
  Result := Result + '       AND GR.RFG_ESPDOC IN ("GR") ';
  Result := Result + '       AND M2.AUTOINCREM IS NULL ';


end;

function TLeDocumentoGA.fValidaPermissaoImportacao(cdsExterno: TZClient): boolean;
begin
  {Verifica se o registro teve quantidades de Retorno ou refugo para poder mostrar ele no relatorio}
  If FtpeTipEtq = tpeContGC Then
    Result := ((cdsExterno.FieldByName('QTDDEV_1').Value > 0)
                Or (cdsExterno.FieldByName('QTDPRE_1').Value > 0)
               And (tpeTipEtq = tpeContGC))
  else
    Result := ((cdsExterno.FieldByName('QTDRET_1').Value > 0)
                Or (cdsExterno.FieldByName('QTDREF_1').Value > 0)
               And (tpeTipEtq in [tpeContGr, tpeContGrBaixa]));
end;

Function TLeDocumentoGA.fSQLMovGad: String;
  Var
    strSQL: String;
    objEtiquetaGarantias: TObjEtiquetaGarantias;
    strFiltro: String;
Begin

  if recDocume.blnReimpressaoGR then
  begin
    Result := fSQLMovGadGR;
    Exit;
  end;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   (@ROW := @ROW + 1) AS SEQDET, ';
  strSQL := strSQL + '   FOR_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '     GAD_CODITE AS CODITE, ';
  strSQL := strSQL + '   I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   I.ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '   G.ITE_LOCSUP AS LOCSUP, ';
  strSQL := strSQL + '     ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '     ITE_DESSIM AS DESSIM, ';
  strSQL := strSQL + '   I.ITE_APLICA AS APLICA, ';
  strSQL := strSQL + fRetSTRCampoBlobToCast255('I.ITE_APLICA', 'APLICA');
  strSQL := strSQL + '     GAD_QTDREQ AS QTDITE, ';
  strSQL := strSQL + '     IF(I.ITE_MLTVEN > 1, GAD_QTDREQ/I.ITE_MLTVEN, 0) AS QTDEMB, ';
  strSQL := strSQL + '     UNI_CODUNI AS CODUNI, ';
  strSQL := strSQL + '     UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '     UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '     UNI_DESUNI AS DESUNI, ';
  strSQL := strSQL + '   I.ITE_MLTVEN AS MLTVEN, ';

  If recDocume.blnDocSep Then
  Begin
    strSQL := strSQL + '   G.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '   I.ITE_CNV_ML,           ';
    strSQL := strSQL + '   G.ITE_SAL_ML,           ';
    strSQL := strSQL + '   0.000        AS SALDIS, ';
  End;

  If pos(recDocume.strEspDoc, '_GR_') > 0 then
  begin
    strSql := strSql + ' DT.DET_UNITAR AS VALUNI, ';
    strSql := strSql + ' DT.DET_VLRCON AS TOTITE, ';
  end
  else begin
    strSQL := strSQL + ' (GAD_VALITE/GAD_QTDREQ) AS VALUNI, ';
    strSQL := strSQL + ' (GAD_VALITE/GAD_QTDREQ) AS TOTITE, ';
  end;


  strSQL := strSQL + '     GAD_VALITE AS VALITE, ';
  strSQL := strSQL + '     GAD_ESPDOC AS ESPGAD, ';
  strSQL := strSQL + '     GAG_CODVEN AS VENGAG, ';
  strSQL := strSQL + '     OPE_NOMOPE AS NOMVEG, ';
  strSQL := strSQL + '     GAG_DTAENT AS DTAGAD, ';
  strSQL := strSQL + '     GAD_CODEMP AS EMPGAD, ';
  strSQL := strSQL + '     GA.GAG_OBSER1 AS GAGOB1, ';
  strSQL := strSQL + '     GA.GAG_OBSER2 AS GAGOB2, ';

  strSQL := strSQL + '     CONCAT(D.GAD_OBSF_1, " ",';
  strSQL := strSQL + '     D.GAD_OBSF_2, " ",';
  strSQL := strSQL + '     D.GAD_OBSF_3, " ",';
  strSQL := strSQL + '     D.GAD_OBSF_4, " ",';
  strSQL := strSQL + '     D.GAD_OBSF_5) AS OBSREF, ';

  strSQL := strSQL + '     D.GAD_OBSF_1 AS OBSRF1,';
  strSQL := strSQL + '     D.GAD_OBSF_2 AS OBSRF2,';
  strSQL := strSQL + '     D.GAD_OBSF_3 AS OBSRF3,';
  strSQL := strSQL + '     D.GAD_OBSF_4 AS OBSRF4,';
  strSQL := strSQL + '     D.GAD_OBSF_5 AS OBSRF5, ';


  strSQL := strSQL + '     D.GAD_OBSP_1 AS GADOB1, ';
  strSQL := strSQL + '     D.GAD_OBSP_2 AS GADOB2, ';
  If pos(recDocume.strEspDoc, '_GR_NF') > 0 then
  Begin
    strSQL := strSQL + '   SUM(D.GAD_QTDREQ) AS QTDENV, ';
    strSQL := strSQL + '   SUM(D.GAD_QTDRET) AS QTDRET, ';
    strSQL := strSQL + '   SUM(D.GAD_QTDREF) AS QTDREF, ';
    strSQL := strSQL + '   SUM(D.GAD_QTDRET+ D.GAD_QTDREF) AS QTDBAI, ';
  end;
  strSQL := strSQL + '     D.GAD_MOTBAI AS MOTBAI, ';
  strSQL := strSQL + '     MAR_DESMAR AS MARDES,        ';
  strSQL := strSQL + '     D.AUTOINCREM,                ';
  strSQL := strSQL + '     CONCAT(I.ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';

  strSQL := strSQL + '     G.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '     G.ITE_LOCSUP AS LOCSUP, ';

  If (recDocume.strEspDoc = 'GA') Then
    strSQL := strSQL + '       DET_REFERE AS REFERE,  '
  Else
    strSQL := strSQL + '       ""         AS REFERE,  ';

  strSQL := strSQL + '  D.GAD_NUMDOC AS GNUDOC, ';
  strSQL := strSQL + '  D.GAD_ESPDOC AS GESDOC, ';
  strSQL := strSQL + '  D.GAD_VALITE AS GVALIT, ';

  If (recDocume.strEspDoc = 'GA') Then
  begin
    strSQL := strSQL + '  E.DET_DTAENT AS GDTENT, ';
    strSQL := strSQL + ' ( SELECT G2.GER_NUMDOC ';
    strSQL := strSQL + '   FROM MOVGRC R ';
    strSQL := strSQL + '     INNER JOIN MOVDET D1 ON D1.AUTOINCREM = R.GRC_SEQDET ';
    strSQL := strSQL + '     INNER JOIN MOVGER G2 ON G2.AUTOINCREM = D1.DET_SEQGER ';
    strSQL := strSQL + '   WHERE R.GRC_SEQGAD = D.AUTOINCREM ';
    strSQL := strSQL + '     AND R.GRC_OPCDOC IN ("GC","OU") ';
    strSQL := strSQL + '   ORDER BY R.AUTOINCREM DESC LIMIT 1 ) AS NUMEGC ';
  end
  Else
  begin
    strSQL := strSQL + '  ""           AS GDTENT, ';
    strSQL := strSQL + '  ""           AS NUMEGC  ';
  end;

  strSQL := strSQL + ' ,D.GAD_UNICRD AS UNICRD ';

  strSQL := strSQL + ' FROM        ';

  strSQL := strSQL + '   MOVGAD D  ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = GAD_CODITE ';

  strSQL := strSQL + ' INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = D.GAD_CODFOR ';

  strSQL := strSQL + ' INNER JOIN MOVGAG GA ON              ';
  strSQL := strSQL + '   GA.AUTOINCREM = GAD_SEQGAG         ';

  strSQL := strSQL + ' INNER JOIN ITEGER G ON  ';
  strSQL := strSQL + '   G.ITE_CODITE = I.ITE_CODITE    AND ';
  strSQL := strSQL + '   G.ITE_CODEMP = GAG_CODEMP          ';

  strSQL := strSQL + ' LEFT JOIN CADOPE ON OPE_CODOPE = GAG_CODVEN ';

  If (recDocume.strEspDoc = 'GA') Then
  Begin
    strSQL := strSQL + ' INNER JOIN MOVGRC T ON T.GRC_SEQGAD = D.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN MOVDET E ON E.AUTOINCREM = T.GRC_SEQDET ';
  End;

  If pos(recDocume.strEspDoc, '_GR_NF') > 0 Then
  Begin
    strSQL := strSQL + 'INNER JOIN MOVGAU GU ON GU.GAU_SEQGAD = D.AUTOINCREM ';
    strSQL := strSQL + 'INNER JOIN MOVDET DT ON DT.AUTOINCREM = GU.GAU_SEQDET ';
  End;

  strSQL := strSQL + ' WHERE ';

  objEtiquetaGarantias:= TObjEtiquetaGarantias.Create;
  Try
    objEtiquetaGarantias.strEspecieDocumento := recDocume.strEspDoc;
    strFiltro := objEtiquetaGarantias.fGetSQLMovGadFiltro;
    If (recDocume.strEspDoc = 'GA') Then
    Begin
      strFiltro := ReverseString(strFiltro);
      strFiltro := ReverseString(StringReplace(strFiltro, 'DNA', '', []));
      strFiltro := ' ((' + strFiltro +' ) OR ((E.DET_ESPDOC = "NF") AND (T.GRC_OPCDOC IN ("DV","OE","NE")))) AND ';
    End;
    strSql := strSQL + strFiltro;
  Finally
    FreeAndNil(objEtiquetaGarantias);
  End;

  If pos(recDocume.strEspDoc, '_GR_NF') > 0 Then
    strSQL := strSQL + '   DT.DET_NUMDOC = :NUMDOC  AND '
  Else
    strSQL := strSQL + '   GA.GAG_NUMENT = :NUMDOC  AND ';
  strSQL := strSQL + '   GA.GAG_CODEMP = :CODEMP    ';

  If recDocume.blnDocCan Then
    strSQL := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGAG','DEL_MOVGAG'), 'MOVGAD', 'DEL_MOVGAD'), 'MOVTRI', 'DEL_MOVTRI'),'MOVDET','DEL_MOVDET');

  If pos(recDocume.strEspDoc, '_GR_NF') > 0 Then
    strSQL := strSQL + ' GROUP BY GAD_CODITE';
  strSQL := strSQL + ' ORDER BY       ';
  strSQL := strSQL + '  D.AUTOINCREM ';

  Result := strSQL;
End;

function TLeDocumentoGA.fSQLMovGadGR: String;
begin

  Result := ' SELECT SQL_NO_CACHE        ';
  Result := Result + '   (@ROW := @ROW + 1) AS SEQDET, ';
  Result := Result + '   FOR_CODFOR AS CODFOR, ';
  Result := Result + '   FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '     GAD_CODITE AS CODITE, ';
  Result := Result + '   I.ITE_CODFAB AS CODFAB, ';
  Result := Result + '   I.ITE_CODBAR AS CODBAR, ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP, ';
  Result := Result + '     ITE_DESITE AS DESITE, ';
  Result := Result + '     ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_APLICA AS APLICA, ';
  Result := Result + fRetSTRCampoBlobToCast255('I.ITE_APLICA', 'APLICA');
  Result := Result + '     GAD_QTDREQ AS QTDITE, ';
  Result := Result + '     IF(I.ITE_MLTVEN > 1, GAD_QTDREQ/I.ITE_MLTVEN, 0) AS QTDEMB, ';
  Result := Result + '     UNI_CODUNI AS CODUNI, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '     UNI_SIGUNI AS UNIDAD, ';
  Result := Result + '     UNI_DESUNI AS DESUNI, ';
  Result := Result + '   I.ITE_MLTVEN AS MLTVEN, ';

  If recDocume.blnDocSep Then
  Begin
    Result := Result + '   G.ITE_SALDOS AS SALDOS, ';
    Result := Result + '   I.ITE_CNV_ML,           ';
    Result := Result + '   G.ITE_SAL_ML,           ';
    Result := Result + '   0.000        AS SALDIS, ';
  End;

  Result := Result + ' DT.DET_UNITAR AS VALUNI, ';
  Result := Result + ' DT.DET_VLRCON AS TOTITE, ';

  Result := Result + '     GAD_VALITE AS VALITE, ';
  Result := Result + '     GAD_ESPDOC AS ESPGAD, ';
  Result := Result + '     GAG_CODVEN AS VENGAG, ';
  Result := Result + '     OPE_NOMOPE AS NOMVEG, ';
  Result := Result + '     GAG_DTAENT AS DTAGAD, ';
  Result := Result + '     GAD_CODEMP AS EMPGAD, ';
  Result := Result + '     GA.GAG_OBSER1 AS GAGOB1, ';
  Result := Result + '     GA.GAG_OBSER2 AS GAGOB2, ';

  Result := Result + '     CONCAT(D.GAD_OBSF_1, " ",';
  Result := Result + '     D.GAD_OBSF_2, " ",';
  Result := Result + '     D.GAD_OBSF_3, " ",';
  Result := Result + '     D.GAD_OBSF_4, " ",';
  Result := Result + '     D.GAD_OBSF_5) AS OBSREF, ';

  Result := Result + '     D.GAD_OBSF_1 AS OBSRF1,';
  Result := Result + '     D.GAD_OBSF_2 AS OBSRF2,';
  Result := Result + '     D.GAD_OBSF_3 AS OBSRF3,';
  Result := Result + '     D.GAD_OBSF_4 AS OBSRF4,';
  Result := Result + '     D.GAD_OBSF_5 AS OBSRF5, ';


  Result := Result + '     D.GAD_OBSP_1 AS GADOB1, ';
  Result := Result + '     D.GAD_OBSP_2 AS GADOB2, ';
  If pos(recDocume.strEspDoc, '_GR_NF') > 0 then
  Begin
    Result := Result + '   SUM(D.GAD_QTDREQ) AS QTDENV, ';
    Result := Result + '   SUM(D.GAD_QTDRET) AS QTDRET, ';
    Result := Result + '   0 AS QTDBAI, ';
    Result := Result + '   SUM(D.GAD_QTDREF) AS QTDREF, ';
  end;

  Result := Result + '     D.GAD_MOTBAI AS MOTBAI, ';
  Result := Result + '     MAR_DESMAR AS MARDES,        ';
  Result := Result + '     D.AUTOINCREM,                ';
  Result := Result + '     CONCAT(I.ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';

  Result := Result + '     G.ITE_LOCFIS AS LOCFIS, ';
  Result := Result + '     G.ITE_LOCSUP AS LOCSUP, ';

  If (recDocume.strEspDoc = 'GA') Then
    Result := Result + '       DET_REFERE AS REFERE,  '
  Else
    Result := Result + '       ""         AS REFERE,  ';

  Result := Result + '  D.GAD_NUMDOC AS GNUDOC, ';
  Result := Result + '  D.GAD_ESPDOC AS GESDOC, ';
  Result := Result + '  D.GAD_VALITE AS GVALIT, ';

  If (recDocume.strEspDoc = 'GA') Then
  begin
    Result := Result + '  DT.DET_DTAENT AS GDTENT, ';
    Result := Result + '  DT.DET_NUMDOC AS NUMEGC  ';
  end
  Else
  begin
    Result := Result + '  ""           AS GDTENT, ';
    Result := Result + '  ""           AS NUMEGC  ';
  end;

  Result := Result + ' ,D.GAD_UNICRD AS UNICRD ';

  Result := Result + ' FROM MOVDET DT  ';
  Result := Result + ' INNER JOIN MOVGAU GU ON GU.GAU_SEQDET = DT.AUTOINCREM ';

  Result := Result + ' INNER JOIN MOVGAD D ON D.AUTOINCREM = GU.GAU_SEQGAD  ';

  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = GAD_CODITE ';

  Result := Result + ' INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  Result := Result + ' LEFT JOIN CADFOR ON FOR_CODFOR = D.GAD_CODFOR ';

  Result := Result + ' INNER JOIN MOVGAG GA ON              ';
  Result := Result + '   GA.AUTOINCREM = GAD_SEQGAG         ';

  Result := Result + ' INNER JOIN ITEGER G ON  ';
  Result := Result + '   G.ITE_CODITE = I.ITE_CODITE    AND ';
  Result := Result + '   G.ITE_CODEMP = GAG_CODEMP          ';

  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = GAG_CODVEN ';

  Result := Result + ' WHERE ';

  Result := Result + '       DT.DET_NUMDOC = :NUMDOC ';

  Result := Result + '   AND DT.DET_CODEMP = :CODEMP ';

  Result := Result + '   AND DT.DET_ESPDOC IN ("NF","GR") ';

  If recDocume.blnDocCan Then
    Result := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGAG','DEL_MOVGAG'), 'MOVGAD', 'DEL_MOVGAD'), 'MOVTRI', 'DEL_MOVTRI'),'MOVDET','DEL_MOVDET');

  If pos(recDocume.strEspDoc, '_GR_NF') > 0 Then
    Result := Result + ' GROUP BY GAD_CODITE';

  Result := Result + ' UNION ';

  Result := Result +  ' SELECT SQL_NO_CACHE        ';
  Result := Result + '   (@ROW := @ROW + 1) AS SEQDET, ';
  Result := Result + '   FOR_CODFOR AS CODFOR, ';
  Result := Result + '   FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '     GAD_CODITE AS CODITE, ';
  Result := Result + '   I.ITE_CODFAB AS CODFAB, ';
  Result := Result + '   I.ITE_CODBAR AS CODBAR, ';
  Result := Result + '   G.ITE_LOCSUP AS LOCSUP, ';
  Result := Result + '     ITE_DESITE AS DESITE, ';
  Result := Result + '     ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_APLICA AS APLICA, ';
  Result := Result + fRetSTRCampoBlobToCast255('I.ITE_APLICA', 'APLICA');
  Result := Result + '     GAD_QTDREQ AS QTDITE, ';
  Result := Result + '     IF(I.ITE_MLTVEN > 1, GAD_QTDREQ/I.ITE_MLTVEN, 0) AS QTDEMB, ';
  Result := Result + '     UNI_CODUNI AS CODUNI, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '     UNI_SIGUNI AS UNIDAD, ';
  Result := Result + '     UNI_DESUNI AS DESUNI, ';
  Result := Result + '   I.ITE_MLTVEN AS MLTVEN, ';

  If recDocume.blnDocSep Then
  Begin
    Result := Result + '   G.ITE_SALDOS AS SALDOS, ';
    Result := Result + '   I.ITE_CNV_ML,           ';
    Result := Result + '   G.ITE_SAL_ML,           ';
    Result := Result + '   0.000        AS SALDIS, ';
  End;

  Result := Result + '  SUM(GR2.RFD_UNICON) AS VALUNI, ';
  Result := Result + '  SUM((GR2.RFD_QTDRET + GR2.RFD_QTDREF + GR2.RFD_QTDBAI) * GR2.RFD_UNICON) AS TOTITE, ';

  Result := Result + '    GAD_VALITE AS VALITE, ';
  Result := Result + '     GAD_ESPDOC AS ESPGAD, ';
  Result := Result + '     GAG_CODVEN AS VENGAG, ';
  Result := Result + '     OPE_NOMOPE AS NOMVEG, ';
  Result := Result + '     GAG_DTAENT AS DTAGAD, ';
  Result := Result + '     GAD_CODEMP AS EMPGAD, ';
  Result := Result + '     GA.GAG_OBSER1 AS GAGOB1, ';
  Result := Result + '     GA.GAG_OBSER2 AS GAGOB2, ';

  Result := Result + '     CONCAT(D.GAD_OBSF_1, " ",';
  Result := Result + '     D.GAD_OBSF_2, " ",';
  Result := Result + '     D.GAD_OBSF_3, " ",';
  Result := Result + '     D.GAD_OBSF_4, " ",';
  Result := Result + '     D.GAD_OBSF_5) AS OBSREF, ';

  Result := Result + '     D.GAD_OBSF_1 AS OBSRF1,';
  Result := Result + '     D.GAD_OBSF_2 AS OBSRF2,';
  Result := Result + '     D.GAD_OBSF_3 AS OBSRF3,';
  Result := Result + '     D.GAD_OBSF_4 AS OBSRF4,';
  Result := Result + '     D.GAD_OBSF_5 AS OBSRF5, ';


  Result := Result + '     D.GAD_OBSP_1 AS GADOB1, ';
  Result := Result + '     D.GAD_OBSP_2 AS GADOB2, ';
  If pos(recDocume.strEspDoc, '_GR_NF') > 0 then
  Begin
    Result := Result + '   SUM(E.GAE_QTDENV) AS ENV, ';
    Result := Result + '   SUM(GR2.RFD_QTDRET) AS QTDRET, ';
    Result := Result + '   SUM(GR2.RFD_QTDBAI) AS QTDBAI, ';
    Result := Result + '   SUM(GR2.RFD_QTDREF) AS QTDREF, ';
  end;

  Result := Result + '     D.GAD_MOTBAI AS MOTBAI, ';
  Result := Result + '     MAR_DESMAR AS MARDES,        ';
  Result := Result + '     D.AUTOINCREM,                ';
  Result := Result + '     CONCAT(I.ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';

  Result := Result + '     G.ITE_LOCFIS AS LOCFIS, ';
  Result := Result + '     G.ITE_LOCSUP AS LOCSUP, ';

  If (recDocume.strEspDoc = 'GA') Then
    Result := Result + '       DET_REFERE AS REFERE, '
  Else
    Result := Result + '       ""         AS REFERE, ';

  Result := Result + '  D.GAD_NUMDOC AS GNUDOC, ';
  Result := Result + '  D.GAD_ESPDOC AS GESDOC, ';
  Result := Result + '  D.GAD_VALITE AS GVALIT, ';

  If (recDocume.strEspDoc = 'GA') Then
  begin
    Result := Result + '  DT.DET_DTAENT AS GDTENT, ';
    Result := Result + '  DT.DET_NUMDOC AS NUMEGC  ';
  end
  Else
  begin
    Result := Result + '  ""         AS GDTENT, ';
    Result := Result + '  ""         AS NUMEGC  ';
  end;

  Result := Result + ' ,D.GAD_UNICRD AS UNICRD ';

  Result := Result + ' FROM GAGRFG GR  ';
  Result := Result + ' INNER JOIN GAGRFD GR2 ON GR2.AUTOINCREM = GR.AUTOINCREM ';
  Result := Result + ' INNER JOIN MOVGAU GU ON GU.AUTOINCREM = GR2.RFD_SEQGAU ';
  Result := Result + ' INNER JOIN MOVGAE E ON GU.GAU_SEQGAE = E.AUTOINCREM   ';
  Result := Result + ' LEFT JOIN MOVDET DT ON E.GAE_INCENV = DT.AUTOINCREM   ';

  Result := Result + ' INNER JOIN MOVGAD D ON D.AUTOINCREM = GU.GAU_SEQGAD  ';

  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = GAD_CODITE ';

  Result := Result + ' INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';

  Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  Result := Result + ' LEFT JOIN CADFOR ON FOR_CODFOR = D.GAD_CODFOR ';

  Result := Result + ' INNER JOIN MOVGAG GA ON GA.AUTOINCREM = GAD_SEQGAG   ';

  Result := Result + ' INNER JOIN ITEGER G ON  ';
  Result := Result + '   G.ITE_CODITE = I.ITE_CODITE    AND ';
  Result := Result + '   G.ITE_CODEMP = GAG_CODEMP          ';

  Result := Result + ' LEFT JOIN CADOPE ON OPE_CODOPE = GAG_CODVEN ';

  Result := Result + ' LEFT JOIN MOVDET M2 ON M2.AUTOINCREM = GU.GAU_SEQDET ';

  Result := Result + ' WHERE TRUE ';

  Result := Result + '    AND GR.RFG_NUMDOC = :NUMDOC AND GR.RFG_CODEMP = :CODEMP ';
  Result := Result + '    AND M2.AUTOINCREM IS NULL ';

  If pos(recDocume.strEspDoc, '_GR_NF') > 0 Then
    Result := Result + ' GROUP BY GAD_CODITE';
end;

Function TLeDocumentoGA.fSQLMovGadCliente: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
  strSQL := strSQL + '   FOR_CODFOR AS CDFRGC, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOFRGC, ';

  strSQL := strSQL + '       (SELECT CADCLI.`CLI_NOMCLI` FROM CADCLI';
  strSQL := strSQL + '          WHERE CADCLI.CLI_CODCLI = GAG_CODCLI) AS NOMCLI, ';

  strSQL := strSQL + '    DET_CODITE AS CODITE, ';
  strSQL := strSQL + '    DET_NUMDOC AS NUMEGC, ';
  strSQL := strSQL + '    ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '    ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '    ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '    ITE_DESSIM AS DESSIM, ';
  strSQL := strSQL + '    ITE_APLICA AS APLICA, ';
  strSQL := strSQL + fRetSTRCampoBlobToCast255('ITE_APLICA', 'APLICA');
  strSQL := strSQL + '    DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '    IF(ITE_MLTVEN > 1, DET_QTDITE/ITE_MLTVEN, 0) AS QTDEMB, ';
  strSQL := strSQL + '    UNI_CODUNI AS CODUNI, ';
  strSQL := strSQL + '    UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '    UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '    UNI_DESUNI AS DESUNI, ';
  strSQL := strSQL + '    ITE_MLTVEN AS MLTVEN, ';

  If recDocume.blnDocSep Then
  Begin
    strSQL := strSQL + '  S.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '  I.ITE_CNV_ML,           ';
    strSQL := strSQL + '  S.ITE_SAL_ML,           ';
    strSQL := strSQL + '  0.000        AS SALDIS, ';
  End;

  strSQL := strSQL + '    MAR_DESMAR AS MARDES, ';

  strSQL := strSQL + '    CONCAT(ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';

  strSQL := strSQL + '    G.GAG_OBSER1 AS GAGOB1, ';
  strSQL := strSQL + '    G.GAG_OBSER2 AS GAGOB2, ';
  strSQL := strSQL + '    D.GAD_OBSP_1 AS GADOB1, ';
  strSQL := strSQL + '    D.GAD_OBSP_2 AS GADOB2, ';

  strSQL := strSQL + '    D.GAD_QTDREQ AS QTDREQ, ';
  strSQL := strSQL + '    D.GAD_QTDDEV AS QTDDEV, ';
  strSQL := strSQL + '    D.GAD_QTDPRE AS QTDPRE, ';

  strSQL := strSQL + '    CONCAT(D.GAD_OBSF_1, " ",';
  strSQL := strSQL + '    D.GAD_OBSF_2, " ",';
  strSQL := strSQL + '    D.GAD_OBSF_3, " ",';
  strSQL := strSQL + '    D.GAD_OBSF_4, " ",';
  strSQL := strSQL + '    D.GAD_OBSF_5) AS OBSREF, ';
  strSQL := strSQL + '     D.GAD_OBSF_1 AS OBSRF1,';
  strSQL := strSQL + '     D.GAD_OBSF_2 AS OBSRF2,';
  strSQL := strSQL + '     D.GAD_OBSF_3 AS OBSRF3,';
  strSQL := strSQL + '     D.GAD_OBSF_4 AS OBSRF4,';
  strSQL := strSQL + '     D.GAD_OBSF_5 AS OBSRF5, ';

  strSQL := strSQL + '    DET_REFERE AS REFERE, ';
  strSQL := strSQL + '    DET_UNIORI AS UNIORI, ';
  strSQL := strSQL + '    OPE_NOMOPE AS NOMVEG, ';
  strSQL := strSQL + '    D.AUTOINCREM,         ';
  strSQL := strSQL + '    S.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '    S.ITE_LOCSUP AS LOCSUP  ';

  If pos(recDocume.strEspDoc, '_GC') > 0 then
  Begin
   strSQL := strSQL + '  ,  E.DET_NUMDOC AS NUMDOC,  ';
   strSQL := strSQL + '    D.GAD_NUMDOC AS NUMORI  ';
  end;

  strSQL := strSQL + ' ,D.GAD_UNICRD AS UNICRD ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    MOVGAD D INNER JOIN MOVGAG G ON D.GAD_SEQGAG = G.AUTOINCREM ';
  strSQL := strSQL + '             INNER JOIN MOVTRI T ON T.DET_SEQGAD = D.AUTOINCREM ';
  strSQL := strSQL + '             INNER JOIN MOVDET E ON T.DET_SEQGER = E.AUTOINCREM ';
  strSQL := strSQL + '             INNER JOIN CADITE I ON I.ITE_CODITE = D.GAD_CODITE ';
  strSQL := strSQL + '             LEFT  JOIN ITEGER S ON S.ITE_CODITE = D.GAD_CODITE AND S.ITE_CODEMP = D.GAD_CODEMP ';
  strSQL := strSQL + '             INNER JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
  strSQL := strSQL + '             INNER JOIN CADUNI   ON   UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + '             LEFT JOIN CADOPE    ON   OPE_CODOPE = GAG_CODVEN ';
  strSQL := strSQL + '             LEFT JOIN CADFOR    ON   FOR_CODFOR = D.GAD_CODFOR ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   E.DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   DET_ESPDOC = "GC"    AND ';
  strSQL := strSQL + '   DET_CODEMP = :CODEMP     ';
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   D.AUTOINCREM ';
  Result := strSQL;
End;



Function TLeDocumentoGA.fInsereClientMovGag: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLMovGag);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    ParamByName('CODEMP').AsString := recDocume.strCodEmp;

    If pos(recDocume.strEspDoc, '_GA_GC_') > 0 Then
    begin
      pCriaSoma('', 'TOTUNI', 'SUM(QTDITE * VALUNI)');
      pCriaSoma('', 'TOTORI', 'SUM(QTDITE * UNIORI)');
    end;

    Result := fAbreClient(True, 'fInsereClientMovGag');

    If (pos(recDocume.strEspDoc, '_GA_GC_') > 0) and (not cdsDados.IsEmpty) then
    Begin
      cdsDados.Edit;
      If cdsDados.FieldByName('TOTUNI').asFloat > cdsDados.FieldByName('TOTORI').asFloat Then
        cdsDados.FieldByName('VALBRU').AsFloat := cdsDados.FieldByName('TOTUNI').asFloat
      Else
        cdsDados.FieldByName('VALBRU').AsFloat := cdsDados.FieldByName('TOTORI').asFloat;
      cdsDados.Post;
    End;

  End;

End;

constructor TLeDocumentoGA.Create(Owner: TComponent);
begin
  blnReimpressaoGR := False;
  inherited;

end;

Function TLeDocumentoGA.fInsereClientMovgad: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin

    If strEspDoc = 'GC' Then
      cdsDados := TZClient.Create(Nil, fSQLMovGadCliente)
    Else
      cdsDados := TZClient.Create(Nil, fSQLMovGad);

    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    ParamByName('CODEMP').AsString := recDocume.strCodEmp;

    Result := fAbreClient(True, 'fInsereClientMovgad');

    If Assigned(cdsDados.FindField('CODFOR')) And (recDocume.strEspDoc = 'GR') Then
      strCodCli := arrClients[High(arrClients)].CdsDados.FieldByName('CODFOR').ASString;
  End;
end;

function TLeDocumentoGA.fMarcarSeparacaoComoImpresso: Boolean;
begin
  Result := True;

  With recDocume Do
  Begin
    If blnDocSep Then
      Result := fMarcaSeparacaoComoImpresso(strNumDoc, strEspDoc, strCodEmp);
  End;
end;

Function TLeDocumentoGA.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
Begin
  Try
    Result := True;

    Result    := Result And fInsereClientMovGad;
    cdsMovGad := arrClients[0].cdsDados;

    Result    := Result And fInsereClientMovGag;
    cdsMovGag := arrClients[1].cdsDados;

    If Not Result Then
      Exit;

    If (FtpeTipEtq in [tpeContGR, tpeContGRBaixa, tpeContGC]) and (Assigned(cdsDadosExternosMovDet)) then
    Begin
      pImportarMovGadCDSExterno(cdsDadosExternosMovDet);
      pImportarMovGaGCDSExterno(cdsDadosExternosMovDet);
    End;

    If recDocume.blnDocSep Then
      pCalculaSaldoDisponivelItens(cdsMovGad);

    Result := Result And fInsereClientEmpresa;

    Result := Result And fInsereClientEnderecoEntrega('', '', '');

    Result := Result And fInsereClientCliente;

    Result := Result And fInsereClientFornecedor;

    Result := Result And fPreparaImpressaoDocumentos;

    Result := Result And fMarcarSeparacaoComoImpresso;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

procedure TLeDocumentoGA.pImportarMovGadCDSExterno(cdsExterno: TZClient);
  var
    Operador: string;



begin
  cdsExterno.First;
  if FtpeTipEtq = tpeContGR then
  Begin
    with cdsMovGad do
    begin
      Operador := cdsMovGad.FieldByName('NOMVEG').AsString;
      cdsMovGad.First;
      While not cdsMovGad.IsEmpty do
      Begin
        cdsMovGad.Delete;
      End;

      cdsExterno.First;
      while not(cdsExterno.Eof) do
      Begin
        If fValidaPermissaoImportacao(cdsExterno) Then
        begin
          Insert;
          FieldByName('NOMVEG').Value := Operador;
          FieldByName('CODITE').Value := cdsExterno.FieldByName('CODITE').Value;
          FieldByName('QTDENV').Value := cdsExterno.FieldByName('QTDREQ').Value;
          FieldByName('QTDRET').Value := cdsExterno.FieldByName('QTDRET_1').Value;
          FieldByName('QTDREF').Value := cdsExterno.FieldByName('QTDREF_1').Value;
          FieldByName('DESITE').Value := cdsExterno.FieldByName('DESITE').Value;
          FieldByName('OBSREF').AsString := cdsExterno.FieldByName('OBSF_1').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_2').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_3').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_4').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_5').AsString;
          cdsMovGad.FieldByName('TOTITE').Value :=  cdsExterno.FieldByName('VALUNT').Value *
                                                    (cdsExterno.FieldByName('QTDRET_1').Value +
                                                    cdsExterno.FieldByName('QTDREF_1').Value);
          Post;
          cdsExterno.Next;
        End;
      End;
    End;
  End
  Else
  { Atuliza os dados quando o Retorno do fornecedor for baixa }
  if FtpeTipEtq = tpeContGRbaixa then
  Begin
    while not(cdsExterno.Eof) do
    Begin
      If fValidaPermissaoImportacao(cdsExterno) then
      begin
        With cdsMovGad do
        Begin

          If Locate('AUTOINCREM', cdsExterno.FieldByName('AUTINC').AsString, []) Then
            Edit
          else
            Insert;

          FieldByName('NOMVEG').Value := fRetNomeOperador(cdsExterno.FieldByName('CODVEN').Value);
          FieldByName('CODITE').Value := cdsExterno.FieldByName('CODITE').Value;
          FieldByName('QTDENV').Value := cdsExterno.FieldByName('QTDREQ').Value;
          FieldByName('QTDRET').Value := cdsExterno.FieldByName('QTDRET_1').Value;
          FieldByName('QTDREF').Value := cdsExterno.FieldByName('QTDREF_1').Value;
          FieldByName('DESITE').Value := cdsExterno.FieldByName('DESITE').Value;
          FieldByName('MOTBAI').Value := cdsExterno.FieldByName('MOTIVO').Value;
          Post;
        End;

      end;

      cdsExterno.Next;
    End;
  End
  Else if FtpeTipEtq = tpeContGC then
  Begin
    cdsMovGad.First;
    while not(cdsExterno.Eof) do
    Begin
      If cdsMovGad.Locate('AUTOINCREM', cdsExterno.FieldByName('AUTINC').AsString, [])
         And fValidaPermissaoImportacao(cdsExterno) Then
      Begin
        With cdsMovGad do
        begin
          Edit;
          FieldByName('QTDDEV').Value := cdsExterno.FieldByName('QTDDEV_1').AsString;
          FieldByName('QTDREQ').Value := cdsExterno.FieldByName('QTDREQ').Value;
          FieldByName('QTDPRE').Value := cdsExterno.FieldByName('QTDPRE_1').Value;
          FieldByName('OBSREF').AsString := cdsExterno.FieldByName('OBSF_1').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_2').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_3').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_4').AsString + ' ' +
                                            cdsExterno.FieldByName('OBSF_5').AsString;

          Post;
        End;
      End;
      cdsExterno.Next;
    End;
  End
end;

procedure TLeDocumentoGA.pImportarMovGaGCDSExterno(cdsExterno: TZClient);
  var
    Numret: string;
    espDoc: string;
    dtaEnt: string;
    fltTotal: Double;
begin
  cdsExterno.First;

  fltTotal := 0;


  if FtpeTipEtq = tpeContGR then
  Begin
    with cdsMovGag do
    begin
      if Not cdsMovGag.IsEmpty Then
      Begin
        NumRet := cdsMovGag.FieldByName('NUMRET').Value;
        espDoc := cdsMovGag.FieldByName('ESPDOC').Value;
        If cdsMovGag.FieldByName('DTAENT').isNull Then
          dtaEnt := fCurrentDate
        Else
          dtaEnt := cdsMovGag.FieldByName('DTAENT').Value;
        While not cdsMovGag.IsEmpty do
        Begin
          cdsMovGag.Delete;
        End;
      End;

      cdsExterno.First;
      If Assigned(cdsExterno) Then
      If (Assigned(cdsExterno.FindField('VALUNT'))) And
         (Assigned(cdsExterno.FindField('QTDRET_1'))) And
         (Assigned(cdsExterno.FindField('QTDREF_1'))) Then
      begin

        while not cdsExterno.Eof do
        Begin

          fltTotal :=  fltTotal + cdsExterno.FieldByName('VALUNT').Value *
                                 (cdsExterno.FieldByName('QTDRET_1').Value +
                                  cdsExterno.FieldByName('QTDREF_1').Value);

          cdsExterno.Next;
         End;
      End;

      iF NumRet = '' Then
        NumRet := recDocume.strNumDoc;

      Insert;
      FieldByName('CODFOR').Value := cdsExterno.FieldByName('CODFOR').Value;
      FieldByName('CODVEN').Value := cdsExterno.FieldByName('CODVEN').Value;
      FieldByName('NUMRET').Value := NumRet;
      FieldByName('ESPDOC').Value := espDoc;
      FieldByName('DTAENT').Value := VS_date;
      FieldByName('HORENT').Value := fTime();
      FieldByName('QTDEGR').Value := cdsExterno.RecordCount;
      FieldByName('DTARET').Value := VS_date;
      FieldByName('VLRCON').Value := fltTotal;

      Post;
    end;
  End;
  if FtpeTipEtq in [tpeContGRBaixa] Then
  Begin
    While not cdsMovGag.IsEmpty do
    Begin
      cdsMovGag.Delete;
    End;
    with cdsMovGag do
    begin
      Begin
        Insert;
        FieldByName('CODFOR').Value := cdsExterno.FieldByName('CODFOR').Value;
        FieldByName('DTAENT').Value := VS_date;
        FieldByName('HORENT').Value := fNow();
        FieldByName('CODVEN').Value := cdsExterno.FieldByName('CODVEN').Value;
        FieldByName('QTDEGR').Value := cdsExterno.RecordCount;
        FieldByName('DTARET').Value := VS_date;
        Post;
      End;
    End;
  End;
end;

procedure TLeDocumentoGA.pSetaParametrosCadcli;
begin
  inherited;

  With arrClients[High(arrClients)], cdsDados, qryQuery Do
  Begin
    ParamByName('CIDCON').AsString := arrClients[1].cdsDados.FieldByName('CIDCON').AsString;
    ParamByName('ENDCON').AsString := arrClients[1].cdsDados.FieldByName('ENDCON').AsString;
    ParamByName('BAICON').AsString := arrClients[1].cdsDados.FieldByName('BAICON').AsString;
    ParamByName('CEPCON').AsString := arrClients[1].cdsDados.FieldByName('CEPCON').AsString;
    ParamByName('TELCON').AsString := arrClients[1].cdsDados.FieldByName('TELCON').AsString;
    ParamByName('R_GCON').AsString := arrClients[1].cdsDados.FieldByName('R_GCON').AsString;
    ParamByName('CGCCPF').AsString := arrClients[1].cdsDados.FieldByName('CGCCPF').AsString;
    ParamByName('CGCCON').AsString := arrClients[1].cdsDados.FieldByName('CGCCON').AsString;
    ParamByName('IESCON').AsString := arrClients[1].cdsDados.FieldByName('IESCON').AsString;
    ParamByName('NOMCON').AsString := arrClients[1].cdsDados.FieldByName('NOMCON').AsString;
    ParamByName('CODFAZ').AsString := '';

  End;
end;


end.
