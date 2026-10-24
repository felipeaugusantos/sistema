unit untDocRomaneios;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untIFuncoes, untTypesSistema, untFuncoesSimples,
  untZClient;

Type

  TLeDocumentoRO = Class(TLeDocumento)
  Private

    cdsRomGer,
    cdsRomDet: TZClient;

    Const SQL_QTDITE = 'IF(IFNULL(FDO_QTDROM,0) <> 0, FDO_QTDROM, FDO_QTDITE)';

    Function fSQLRomGer: String;
    Function fSQLRomDet: String;
    Function fSQLTabPre: String;

    function fGetSqlQtdItePedOrc: String;
    function fGetSqlQtdEmbPedOrc: String;
    function fGetSqlGroupByPedOrc: String;

    function fSqlCampoSetor: String;

    Function fInsereClientRomDet: Boolean;
    Function fInsereClientRomGer: Boolean;
    function fRetOrdenacaoCFG_ORSPRO : String;
  Public

    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;

  protected
  End;

implementation

uses DB;

Function TLeDocumentoRO.fSQLRomGer: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_NUMROM    AS NUMDOC, ';
  strSQL := strSQL + '  "RO"          AS ESPDOC, ';
  strSQL := strSQL + '  GER_NUMDOC    AS NUMPED, ';
  strSQL := strSQL + '  GER_CODEMP    AS PEDEMP, ';
  strSQL := strSQL + '  GER_SERIE_    AS SERDOC, ';
  if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
  begin
    strSQL := strSQL + '  GER_PESBRU    AS PESBRU, ';
    strSQL := strSQL + '  GER_PESLIQ    AS PESLIQ, ';
  end
  else
  begin
    strSQL := strSQL + '  FGO_PESBRU    AS PESBRU, ';
    strSQL := strSQL + '  FGO_PESLIQ    AS PESLIQ, ';
  end;
  strSQL := strSQL + '  GER_DTAROM    AS DTAENT, ';
  strSQL := strSQL + '  GER_HORROM    AS HORENT, ';
  strSQL := strSQL + '  GER_OPEROM    AS CODVEN, ';
  strSQL := strSQL + '  O.OPE_NOMOPE  AS NOMVEN, ';
  strSQL := strSQL + '  GER_CODREG    AS CODREG, ';
  strSQL := strSQL + '  GER_EMPROM    AS CODEMP, ';
  strSQL := strSQL + '  GER_FRETE_    AS TOTFRE, ';
  strSQL := strSQL + '  GER_ADIFRE    AS ADIFRE, ';
  strSQL := strSQL + '  GER_PERFRE    AS PERFRE, ';
  //Mensagens do Romaneio
  strSQL := strSQL + '  GER_MEN001    AS MENR01, ';
  strSQL := strSQL + '  GER_MEN002    AS MENR02, ';
  //Mensagens do Pedido.
  strSQL := strSQL + '  PD.FGO_MEN001 AS MEN001, ';
  strSQL := strSQL + '  PD.FGO_MEN002 AS MEN002, ';
  strSQL := strSQL + '  PD.FGO_MENEXP AS MENEXP, ';
  strSQL := strSQL + '  PD.FGO_MENEX2 AS MENEX2, ';
  strSQL := strSQL + '  PD.FGO_MENEX3 AS MENEX3, ';
  strSQL := strSQL + '  PD.FGO_MENEX4 AS MENEX4, ';

  strSQL := strSQL + '  GER_CODDIG    AS CODDIG, ';
  strSQL := strSQL + '  OD.OPE_NOMOPE AS NOMDIG, ';

  strSQL := strSQL + '  TA.TRA_CODTRA AS CODTRA, ';
  strSQL := strSQL + '  TA.TRA_NOMTRA AS NOMTRA, ';
  strSQL := strSQL + '  TA.TRA_ENDERE AS ENDTRA, ';
  strSQL := strSQL + '  TA.TRA_BAIRRO AS BAITRA, ';
  strSQL := strSQL + '  TA.TRA_C_E_P_ AS CEPTRA, ';
  strSQL := strSQL + '  TA.TRA_FONE01 AS FONTRA, ';
  strSQL := strSQL + '  CT.CID_NOMCID AS CIDTRA, ';
  strSQL := strSQL + '  CT.CID_ESTADO AS ESTTRA, ';

  strSQL := strSQL + '  0             AS NROITE, ';
  strSQL := strSQL + '  GER_TIPFRE    AS TIPFRE, ';

  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, ';
  strSQL := strSQL +    fSQLTipoFrete('GER_TIPFRE') + ' AS DESFRE, ';

  If recDocume.blnPenExp Then
    strSQL := strSQL + ' "S" AS IMPDPN, '
  Else
    strSQL := strSQL + ' "N" AS IMPDPN, ';

  if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
    strSQL := strSQL + '  (SELECT SUM(DET_VOLUME) FROM ROMDETX WHERE DET_NUMROM = R.GER_NUMROM AND DET_EMPROM = R.GER_EMPROM) AS VOLUME, '
  else
    strSQL := strSQL + '  GER_VOLUME    AS VOLUME, ';
  strSQL := strSQL + '  GER_NUMBOX    AS NUMBOX, ';
  strSQL := strSQL + '  GER_VLRORI    AS TOTPED, ';

  strSQL := strSQL + '  GER_CODCND    AS CODCND, ';
  strSQL := strSQL + '  CND_DESCRI    AS DESCND, ';
  strSQL := strSQL + '  FGO_CONPAG    AS CONPAG, ';

  strSQL := strSQL + '  GER_CODFPG    AS CODFPG, ';
  strSQL := strSQL + '  FPG_DESCRI    AS DESFPG, ';

  strSQL := strSQL + '  IF(PD.FGO_NOMCON IS NULL OR PD.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "",  C.CLI_ENDERE, EC.ETC_ENDENT), PD.FGO_ENDCON) AS ENDENT, ';
  strSQL := strSQL + '  IF(PD.FGO_NOMCON IS NULL OR PD.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "",  C.CLI_C_E_P_, EC.ETC_CEPENT), PD.FGO_CEPCON) AS CEPENT, ';
  strSQL := strSQL + '  IF(PD.FGO_NOMCON IS NULL OR PD.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), CC.CID_NOMCID) AS CIDENT, ';
  strSQL := strSQL + '  IF(PD.FGO_NOMCON IS NULL OR PD.FGO_NOMCON = "", IF(EC.ETC_ENDENT IS NULL OR EC.ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), CC.CID_ESTADO) AS ESTENT, ';
  strSQL := strSQL + '  IF(FGO_TIPPED = "A", "NF", IF(FGO_TIPPED = "B", "FF", IF(FGO_TIPPED = "C", "IF", ""))) AS ESPFAT, ';
  strSQL := strSQL + '  (SELECT ';
  strSQL := strSQL + '    GROUP_CONCAT( ';
  strSQL := strSQL + '      CONCAT(UNIDAD, "-", QTDUNI) SEPARATOR " | " ';
  strSQL := strSQL + '    ) ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    (SELECT ';
  strSQL := strSQL + '      CONCAT(U.UNI_CODUNI, "-", U.UNI_DESUNI) AS UNIDAD, ';
  strSQL := strSQL + '      ROUND(SUM(D.DET_QTDITE)) AS QTDUNI ';
  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      ROMGERX G ';
  strSQL := strSQL + '      INNER JOIN ROMDETX D ';
  strSQL := strSQL + '        ON G.AUTOINCREM = D.DET_SEQGER ';
  strSQL := strSQL + '      INNER JOIN CADUNI U ';
  strSQL := strSQL + '        ON D.DET_UNIDAD = U.UNI_CODUNI ';

  If (recDocume.opcAgrupaPor = opcPedido) Then Begin
    strSQL := strSQL + '  WHERE G.GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '        G.GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '        G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '        G.GER_CODCLI = :CODCLI     ';
  End Else Begin
    strSQL := strSQL + '  WHERE G.GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '        G.GER_EMPROM = :CODEMP     ';

    If (recDocume.opcAgrupaPor = opcCliente) Then
      strSQL := strSQL + '  AND G.GER_CODCLI = :CODCLI ';
  End;

  strSQL := strSQL + '    GROUP BY U.UNI_CODUNI ';
  strSQL := strSQL + '    ORDER BY U.UNI_DESUNI) AS TAB) AS DSUNRO, ';
  strSQL := strSQL + '  (CONCAT(R.GER_ORDIMP, "/", (SELECT COUNT(G.AUTOINCREM) FROM ROMGERX G WHERE G.GER_NUMROM = R.GER_NUMROM AND G.GER_CODEMP = R.GER_CODEMP))) AS ORDIMP, ';
  strSQL := strSQL + '  FGO_PESBRU AS PESBRU, ';

  strSQL := strSQL + '  (SELECT ';
  strSQL := strSQL + '    SUM(D.DET_QTDITE) AS TOTQTD ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    ROMGERX G ';
  strSQL := strSQL + '    INNER JOIN ROMDETX D ';
  strSQL := strSQL + '      ON G.AUTOINCREM = D.DET_SEQGER ';
  If (recDocume.opcAgrupaPor = opcPedido) Then
  Begin
    strSQL := strSQL + '  WHERE G.GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '        G.GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '        G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '        G.GER_CODCLI = :CODCLI     ';
  End
  Else
  Begin
    strSQL := strSQL + '  WHERE G.GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '        G.GER_EMPROM = :CODEMP     ';
      If (recDocume.opcAgrupaPor = opcCliente) Then
      strSQL := strSQL + '  AND G.GER_CODCLI = :CODCLI ';
  End;
  strSQL := strSQL + '  ) AS TOTQTD, ';

  strSQL := strSQL + '  (SELECT ';
  strSQL := strSQL + '    SUM(G.GER_PESBRU) AS TOTPES ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    ROMGERX G ';
  If (recDocume.opcAgrupaPor = opcPedido) Then
  Begin
    strSQL := strSQL + '  WHERE G.GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '        G.GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '        G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '        G.GER_CODCLI = :CODCLI     ';
  End
  Else
  Begin
    strSQL := strSQL + '  WHERE G.GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '        G.GER_EMPROM = :CODEMP     ';
      If (recDocume.opcAgrupaPor = opcCliente) Then
      strSQL := strSQL + '  AND G.GER_CODCLI = :CODCLI ';
  End;
  strSQL := strSQL + '  ) AS TOTPES ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX R ';
  strSQL := strSQL + '  LEFT JOIN CADCLI C  ON R.GER_OPEROM  =  C.CLI_CODCLI     ';
  strSQL := strSQL + '  LEFT JOIN CADOPE O  ON R.GER_OPEROM  =  O.OPE_CODOPE     ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OD ON R.GER_CODDIG  = OD.OPE_CODOPE     ';
  strSQL := strSQL + '  LEFT JOIN CADCND CN ON CN.CND_CODIGO =  R.GER_CODCND     ';
  strSQL := strSQL + '  LEFT JOIN CADFPG FP ON FP.FPG_CODIGO =  R.GER_CODFPG     ';
  strSQL := strSQL + '  LEFT JOIN FATGOR PD ON PD.FGO_NUMDOC =  R.GER_NUMDOC AND ';
  strSQL := strSQL + '                         PD.FGO_ESPDOC =  R.GER_ESPDOC AND ';
  strSQL := strSQL + '                         PD.FGO_CODEMP =  R.GER_CODEMP AND ';
  strSQL := strSQL + '                         PD.FGO_CODCLI =  R.GER_CODCLI     ';
  strSQL := strSQL + '  LEFT JOIN AUXGOR AG ON PD.AUTOINCREM = AG.AUX_SEQGER     ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI EC ON EC.ETC_CODCLI = PD.FGO_CODCLI AND ';
  strSQL := strSQL + '                      IF(IFNULL(AG.AUX_ENTGER,"") <> "", EC.AUTOINCREM = AG.AUX_ENTGER, EC.ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = PD.FGO_CODCLI)) ';
  strSQL := strSQL + '  LEFT JOIN CADTRA TA ON IFNULL(PD.FGO_CODTRA, R.GER_CODTRA) = TA.TRA_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCID CT ON CT.CID_CODCID = TA.TRA_CODCID ';

  strSQL := strSQL + '  LEFT JOIN CADCID CE ON CE.CID_CODCID = EC.ETC_CIDENT     ';
  strSQL := strSQL + '  LEFT JOIN CADCID CC ON CC.CID_CODCID = PD.FGO_CIDCON     ';
  strSQL := strSQL + '  LEFT JOIN CADCID CF ON CF.CID_CODCID =  C.CLI_CODCID     ';

  strSQL := strSQL + 'WHERE ';

  If (recDocume.opcAgrupaPor = opcPedido) Then
  Begin
    strSQL := strSQL + '  R.GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  R.GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  R.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  R.GER_CODCLI = :CODCLI     ';

    if fCfgSis('RMPDPA', varBoolean) then
    begin
      strSQL := strSQL + '  AND R.GER_NUMROM = :NUMROM  ';
      strSQL := strSQL + '  AND R.GER_EMPROM = :EMPROM';
    end;
  End
  Else
  Begin
    strSQL := strSQL + '  R.GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  R.GER_EMPROM = :CODEMP     ';

    If (recDocume.opcAgrupaPor = opcCliente) Then
      strSQL := strSQL + '  AND R.GER_CODCLI = :CODCLI ';
  End;

  If (recDocume.opcAgrupaPor = opcPedido) Then
    strSQL := strSQL + ' ORDER BY C.CLI_NOMCLI, R.GER_ESPDOC, R.GER_CODEMP, R.GER_NUMDOC, R.GER_NUMROM ';

  Result := strSQL;
End;

function TLeDocumentoRO.fSQLTabPre: String;
begin
  With recDocume Do
  If (fCfgSis('TABITE', varBoolean)) And (fCfgSis('IPTPFT', varBoolean)) And (Pos(strEspDoc, fCfgSis('ESPITP')) > 0) Then
    Result := 'IF(FDO_PROMOC = "S", "PR", FDO_TABPRE), "-", '
  Else
    Result := '';
end;

function TLeDocumentoRO.fSqlCampoSetor: String;
begin
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    Result := 'IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) '
  else
  If (fCfgSis('GRUSEP', VarString) = 'S') then
    Result := 'LSE_DESCRI'
  Else
    Result := 'LEFT(ITE_LOCFIS, 1)';
end;

Function TLeDocumentoRO.fSQLRomDet: String;
  Var
    strSQL, strSUM, strEntRet, strSQLEntRet, strOrderByCfg: String;
Begin
  If recDocume.blnAgruparItensSeparacao Then
    strSUM := 'SUM'
  Else
    strSUM := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   (@ROW := @ROW + 1) AS SEQDET, ';
  strSQL := strSQL + fSQLBarDoc('', fPadL(recDocume.strNumDoc, fTamNumDoc, '0') , 'RO', recDocume.strCodEmp) + ' AS BARDOC, ';
  strSQL := strSQL + '  GER_NUMROM   AS NUMDOC, ';
  strSQL := strSQL + '  "RO"         AS ESPDOC, ';
  strSQL := strSQL + '  GER_EMPROM   AS CODEMP, ';
  strSQL := strSQL + '  I.ITE_DESSIM AS DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESCAD, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '  I.ITE_CLAIPI AS CLAIPI, ';
  strSQL := strSQL + '  I.ITE_APLICA AS APLICA, ';
  strSQL := strSQL + fRetSTRCampoBlobToCast255('I.ITE_APLICA', 'APLICA');
  strSQL := strSQL + '    ITE_EMBALA AS EMBALA, ';
  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    strSQL := strSQL + '    IF(IFNULL(FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LOCSEP, '
  else
    strSQL := strSQL + '    LSE_DESCRI AS LOCSEP, ';
  strSQL := strSQL + '  I.ITE_MLTVEN AS MLTVEN, ';
  strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '  G.ITE_LOCSUP AS LOCSUP, ';
  strSQL := strSQL + '    DEP_DESCRI AS NOMDEP, ';

  With recDocume Do
  Begin
    If blnEnt_CD Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpCD('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP');
      strSQL := strSQL + fRetDesFisicaEmpCD('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP');
    End
    Else If blnLocFisEmpEmi Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpEmissora('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP');
      strSQL := strSQL + fRetDesFisicaEmpEmissora('FDO_NUMLOT', 'I.ITE_CODITE', 'FDO_CODEMP');
    End
    Else
    Begin
      strSQL := strSQL + '   IF(IFNULL(FDO_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS)       AS LOCFIS, ';
      strSQL := strSQL + '   IF(IFNULL(FDO_NUMLOT, "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI) AS DESFIS, ';
    End;
  End;

  strSQL := strSQL + '    UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '    UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '    UNI_DESUNI AS DESUNI, ';

  strSQL := strSQL + '    FDO_CODITE AS CODITE, ';
  strSQL := strSQL + '    FDO_TABPRE AS TABPRE, ';
  strSQL := strSQL + '    FDO_PROMOC AS PROMOC, ';
  strSQL := strSQL + '    IFNULL(FDO_EMPITE, FDO_CODEMP) AS EMPITE, ';
  if fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
  begin
    strSQL := strSQL + '    LOT_NUMLOT AS NUMLOT, ';
  end
  else
  begin
    strSQL := strSQL + '    FDO_NUMLOT AS NUMLOT, ';
  end;
  strSQL := strSQL + '    FDO_CODACA AS CODACA, ';
  strSQL := strSQL + '    FDO_EMPACA AS EMPACA, ';
  strSQL := strSQL + '    FDO_IDEPRO AS IDEPRO, ';
  strSQL := strSQL + '    FDO_DESCRI AS DESITE, ';
  strSQL := strSQL + '    FDO_SEQIND AS SEQIND, ';
  strSQL := strSQL + '    FDO_COMPLE AS COMPLE, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), IF(FDO_IDEPRO <> "NOR" OR LOCATE("ITEM ESPECIAL", FDO_DESCRI) > 0, CONCAT(FDO_DESCRI, " ", IFNULL(FDO_COMPLE, "")), CONCAT(ITE_DESITE, " ", ITE_REFERE)), ' ;
  strSQL := strSQL + '      IF(IFNULL(ITE_CODFAB, "") <> "", CONCAT(" - ", TRIM(LEADING 0 FROM ITE_CODFAB)), "")) AS DESIT1, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), IF(FDO_IDEPRO <> "NOR" OR LOCATE("ITEM ESPECIAL", FDO_DESCRI) > 0, CONCAT(FDO_DESCRI, " ", IFNULL(FDO_COMPLE, "")), CONCAT(ITE_DESITE, " ", ITE_REFERE))) AS DESIT2, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), FDO_DESCRI, " ", IFNULL(FDO_COMPLE, ""), IF(IFNULL(ITE_CODFAB, "") <> "", CONCAT(" - ", TRIM(LEADING 0 FROM ITE_CODFAB)), "")) AS DESIT3, ';

  strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(FDO_IDEPRO <> "NOR", CONCAT(FDO_IDEPRO, " - "), ""), FDO_DESCRI, " ", IFNULL(FDO_COMPLE, "")) AS DESIT4, ';

  strSQL := strSQL + '    CONCAT(FDO_DESCRI, " - ", TRIM( LEADING 0 FROM IFNULL(ITE_CODFAB, ""))) AS DESFAB, '; //LEADING 0 - retira os zeros a esquerda
  strSQL := strSQL + '    FDO_REFERE AS REFERE, ';
  strSQL := strSQL + '    FDO_UNITAR AS VALUNI, ';
  strSQL := strSQL + '    FDO_UNIORI AS UNIORI, ';
  strSQL := strSQL + '    FDO_CODFIS AS CODFIS, ';
  strSQL := strSQL + '    FDO_ENTRET AS ENTRET, ';
  strSQL := strSQL + '    FDO_ENTFUT AS ENTFUT, ';
  strSQL := strSQL + '    FDO_MOTFUT AS MOTFUT, ';
  strSQL := strSQL + '    FDO_COMPLE AS COMPLE, ';
  strSQL := strSQL + '    FDO_QTDPEC AS QTDPEC, ';
  strSQL := strSQL + '    FDO_COMPEC AS COMPEC, ';
  strSQL := strSQL + '    FDO_LARPEC AS LARPEC, ';
  strSQL := strSQL + '    FDO_ESPPEC AS ESPPEC, ';
  strSQL := strSQL + '    FDO_APAREL AS APAREL, ';
  strSQL := strSQL + '    FDO_BENEFI AS BENEFI, ';
  strSQL := strSQL + '    IF(FDO_DESCON < 0, 0.00, FDO_DESCON)       AS DESCON, ';
  strSQL := strSQL + '    IF(FDO_DESCON < 0, FDO_UNITAR, FDO_UNIDIG) AS UNIDIG, ';

  strSQL := strSQL + '    FDO_CODVEN AS VENITE, ';
  strSQL := strSQL + ' V1.OPE_NOMOPE AS NVENIT, ';

  strSQL := strSQL + '    FDO_CODVE2 AS CODVE2, ';
  strSQL := strSQL + ' V2.OPE_NOMOPE AS NOMVE2, ';

  strSQL := strSQL + '    FDO_CODDIV AS CODDIV, ';
  strSQL := strSQL + ' DI.DIV_NOMDIV AS NOMDIV, ';

  strSQL := strSQL + '    FDO_CODREP AS CODREP, ';
  strSQL := strSQL + ' OP.OPE_NOMOPE AS NOMREP, ';

  strSQL := strSQL + '    MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '    FDO_CODMAR AS CODMAR, ';

  If (recDocume.opcAgrupaPor = opcCliente) Then
  Begin
    strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '    FDO_CODCLI AS CODCLI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  " " AS NOMCLI, ';
    strSQL := strSQL + '  " " AS CODCLI, ';
  End;

  strSQL := strSQL + strSUM + '(' + fGetSqlQtdItePedOrc + ') AS QTDITE, ';
  strSQL := strSQL + strSUM + '(' + fGetSqlQtdEmbPedOrc + ') AS QTDEMB, ';

  With recDocume Do
  Begin
    strSQL := strSQL + strSUM + '( FDO_UNITAR               * (' + fGetSqlQtdItePedOrc + ')) AS VALITE, ';
    strSQL := strSQL + strSUM + '((FDO_VALIPI / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS VALIPI, ';
    strSQL := strSQL + strSUM + '((FDO_VALRET / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS VALRET, ';
    strSQL := strSQL + strSUM + '((FDO_TOTFRE / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS VALFRE, ';
    strSQL := strSQL + strSUM + '((FDO_DESESP / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS DESESI, ';
    strSQL := strSQL + strSUM + '((FDO_BASIPI / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS IBASIP, ';
    strSQL := strSQL + strSUM + '((FDO_BASRET / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS IBASRE, ';
    strSQL := strSQL + strSUM + '((FDO_BASICM / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS IBASIC, ';
    strSQL := strSQL + strSUM + '((FDO_VALICM / FDO_QTDITE) * (' + fGetSqlQtdItePedOrc + ')) AS IVALIC, ';
    strSQL := strSQL + ' FDO_ALQIPI AS IALQIP, ';
    strSQL := strSQL + ' FDO_ALQRET AS IALQRE, ';
    strSQL := strSQL + ' FDO_ALQICM AS IALQIC, ';
  End;

  strSQL := strSQL + '   ' + fSqlCampoSetor + ' AS SETOR_, ';

  strSQL := strSQL + '  CAST("" AS CHAR(100)) AS LEGEND, ';
  strSQL := strSQL + '  0.00                  AS ITETOT, ';

  strSQL := strSQL + '  FDO_INSALT   AS INSALT, ';
  strSQL := strSQL + '  R.GER_CODBAR AS CDBARO, ';

  strSQL := strSQL + '  FD.AUTOINCREM AS AUTDET, ';

  strSQL := strSQL + '  CADLOT.LOT_LOCFIS AS LOCLOT, ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    strSQL := strSQL + ' (SELECT                                 ';
    strSQL := strSQL + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    strSQL := strSQL + '  FROM                                   ';
    strSQL := strSQL + '    LOCFIS                               ';
    strSQL := strSQL + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    strSQL := strSQL + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    strSQL := strSQL + '  WHERE                                  ';
    strSQL := strSQL + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '    LOCFIS.LOC_CODEMP = EG.FGO_EMPEXP AND ';
    strSQL := strSQL + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI,  ';
  End
  Else
  Begin
    strSQL := strSQL + ' (SELECT                                 ';
    strSQL := strSQL + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    strSQL := strSQL + '  FROM                                   ';
    strSQL := strSQL + '    LOCFIS                               ';
    strSQL := strSQL + '  WHERE                                  ';
    strSQL := strSQL + '    LOC_CODITE = I.ITE_CODITE AND        ';
    strSQL := strSQL + '    LOC_CODEMP = EG.FGO_EMPEXP) AS LOCADI,   ';
  End;

  strSQL := strSQL + '      (                                        ';
  strSQL := strSQL + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
  strSQL := strSQL + '      FROM ITEBAR                              ';
  strSQL := strSQL + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
  strSQL := strSQL + '      ) AS CDBARS                              ';
  strSQL := strSQL + '  , FD.FDO_NUMDOC AS DOCITE                       ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + ' FATDOR FD ';

  strSQL := strSQL + ' INNER JOIN CADMAR   ON FDO_CODMAR =   MAR_CODMAR ';
  strSQL := strSQL + ' INNER JOIN CADUNI   ON FDO_UNIDAD =   UNI_CODUNI ';
  strSQL := strSQL + ' INNER JOIN CADITE I ON FDO_CODITE = I.ITE_CODITE ';

  if fCfgSis('RMPDPA', varBoolean) then
  begin
    strSQL := strSQL + ' INNER JOIN ROMDETX D ON D.DET_AUTINC = FD.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN ROMGERX R ON D.DET_SEQGER = R.AUTOINCREM ';
  end
  else
  begin
    strSQL := strSQL + ' INNER JOIN ROMGERX R ON R.GER_CODEMP = FD.FDO_CODEMP ';
    strSQL := strSQL + '                     AND R.GER_NUMDOC = FD.FDO_NUMDOC ';
    strSQL := strSQL + '                     AND R.GER_ESPDOC = FD.FDO_ESPDOC ';
    strSQL := strSQL + '                     AND R.GER_CODCLI = FD.FDO_CODCLI ';
  end;

  strSQL := strSQL + ' LEFT JOIN CADDIV DI ON DI.DIV_CODDIV = FDO_CODDIV ';
  strSQL := strSQL + ' LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = FDO_CODREP ';
  strSQL := strSQL + ' LEFT JOIN CADOPE V1 ON V1.OPE_CODOPE = FDO_CODVEN ';
  strSQL := strSQL + ' LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = FDO_CODVE2 ';

  strSQL := strSQL + ' LEFT JOIN ITEGER G ON ';
  strSQL := strSQL + '   G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '   G.ITE_CODEMP = FDO_CODEMP       ';

  strSQL := strSQL + ' LEFT JOIN ORCMAD M ON M.FDO_SEQGER = FD.AUTOINCREM  ';

  strSQL := strSQL + ' LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FD.AUTOINCREM  ';

  strSQL := strSQL + ' LEFT JOIN CADCLI C ON C.CLI_CODCLI = FD.FDO_CODCLI  ';

  if fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
  begin
    strSQL := strSQL + ' LEFT JOIN LOTDOR LOT ON LOT.LDO_SEQFDO = FD.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADLOT ON CADLOT.LOT_NUMLOT = LOT.LDO_NUMLOT AND FD.FDO_CODEMP = CADLOT.LOT_CODEMP AND FD.FDO_CODITE = CADLOT.LOT_CODITE AND LOT.LDO_NUMLOT = CADLOT.LOT_NUMLOT ';
  end
  else
  begin
    strSQL := strSQL + ' LEFT JOIN CADLOT ON FDO_NUMLOT = LOT_NUMLOT AND ';
    strSQL := strSQL + '                     FDO_CODITE = LOT_CODITE AND ';
    strSQL := strSQL + '                     IF(IFNULL(FDO_EMPITE, "") = "", FDO_CODEMP, FDO_EMPITE) = LOT_CODEMP ';
  end;

  strSQL := strSQL + ' LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP ';

  strSQL := strSQL + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CADLOT.LOT_LOCFIS AND L1.LOC_CODEMP = CADLOT.LOT_CODEMP  ';
  strSQL := strSQL + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = G.ITE_LOCFIS AND L2.LOC_CODEMP = G.ITE_CODEMP ';

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    strSQL := strSQL + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = L1.LOC_CODLSE ';
    strSQL := strSQL + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = L2.LOC_CODLSE ';
  end
  else
    strSQL := strSQL + ' LEFT JOIN CADLSE LS ON LS.LSE_CODIGO = G.ITE_CODLSE  ';

  strSQL := strSQL + ' LEFT JOIN EXTGOR EG ON EG.FGO_SEQFGO = FD.FDO_SEQGER  ';

  strSQL := strSQL + ' LEFT JOIN LOTDOR LD ON LD.LDO_SEQFDO = FD.AUTOINCREM AND FD.FDO_CODEMP = CADLOT.LOT_CODEMP AND FD.FDO_CODITE = CADLOT.LOT_CODITE AND LD.LDO_NUMLOT = CADLOT.LOT_NUMLOT ';

  strSQL := strSQL + ' WHERE ';

  if (Not fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean)) then
  begin
    With recDocume Do
      If Not blnQtdOri Then
        strSQL := strSQL + ' (ROUND(' + SQL_QTDITE + ',2) - ROUND(FDO_QTDBAI,2)) > 0 AND ';
  end;

  If (recDocume.opcAgrupaPor = opcPedido) Then
  Begin
    if fCfgSis('RMPDPA', varBoolean) then
    begin
      strSQL := strSQL + '  FD.FDO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  FD.FDO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  FD.FDO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  FD.FDO_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  D.DET_NUMROM  = :NUMROM AND ';
      strSQL := strSQL + '  D.DET_EMPROM  = :EMPROM AND ';
    end
    else
    begin
      strSQL := strSQL + '  R.GER_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  R.GER_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  R.GER_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  R.GER_CODCLI = :CODCLI AND ';
    end;

    If (Not fEmptyStr(recDocume.strCodLse)) Then
      strSQL := strSQL + '  G.ITE_CODLSE = :CODLSE AND ';
  End
  Else
  Begin
    strSQL := strSQL + '   R.GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '   R.GER_EMPROM = :CODEMP AND ';

    If (recDocume.opcAgrupaPor = opcCliente) Then
      strSQL := strSQL + '  R.GER_CODCLI = :CODCLI AND ';
  End;

  strSQL := strSQL + '   IFNULL(FDO_PROEMB, "N") <> "S"    AND ';
  strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
  strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';

  With recDocume Do
  Begin
    If (strEspDoc = 'PD') And blnDocSep Then
    Begin
      strEntRet := fCfgSis('TPSPPV',varString);

      If (Pos(strSepPedEntregaOuRetira, 'R_E_') > 0) Then
      Begin
        strSQL := strSQL + ' AND IFNULL(FDO_ENTRET, "") = ' + QuotedStr(strSepPedEntregaOuRetira) + ' '
      End
      Else
      Begin
        strSQLEntRet := '';

        {**********}
        {* RETIRA *}
        {**********}
        If (Copy(strEntRet,1,1) = 'R') Then
          strSQLEntRet := strSQLEntRet + ' (FDO_ENTRET = "R") OR ';

        {*****************}
        {* ENT. IMEDIATA *}
        {*****************}
        If (Copy(strEntRet,2,1) = 'E') Then
          strSQLEntRet := strSQLEntRet + ' (FDO_ENTRET = "E" AND FDO_ENTFUT = "N") OR ';

        {***************}
        {* ENT. FUTURA *}
        {***************}
        If (Copy(strEntRet,3,1) = 'F') Then
          strSQLEntRet := strSQLEntRet + ' (FDO_ENTFUT = "S") OR ';

        {* Remove o último OR *}
        strSQLEntRet := Copy(strSQLEntRet, 1, Length(strSQLEntRet)-3);

        If Not fEmptyStr(strSQLEntRet) Then
          strSQL := strSQL + ' AND (' + strSQLEntRet + ') ';
      End;
      {End
      Else
      Begin
        If (Pos(strEntRet, 'R_E_') > 0) Then
          strSQL := strSQL + ' AND IFNULL(FDO_ENTRET, "")  = ' + QuotedStr(strEntRet) + ' ';
      End;

      If (strEntRet <> 'T') Then
      Begin
        Case strEntRet[1] Of
          'E',
          'R':strSQL := strSQL + ' AND IFNULL(FDO_ENTFUT, "N") = "N" ';
          'F':strSQL := strSQL + ' AND IFNULL(FDO_ENTFUT, "N") = "S" ';
        end;
      End;}
    End;
  End;

  If recDocume.blnDocSep Then
  Begin
    Case recDocume.opcAbastecimento Of
      opcSolicitado:
        Begin
          If recDocume.blnSomenteEmpDifSep Then
            strSQL := strSQL + ' AND IFNULL(NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP)), "") <> "" '
          Else
            strSQL := strSQL + ' AND IFNULL(FDO_EMPFOR, "") <> "" ';
        End;
      opcNaoSolicitado:
        Begin
          If recDocume.blnSomenteEmpDifSep Then
            strSQL := strSQL + ' AND IFNULL(NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP)), "") = "" '
          Else
            strSQL := strSQL + ' AND IFNULL(FDO_EMPFOR, "") = "" ';
        End;
    End;
  End;

  If recDocume.blnSomenteNaoImp Then
  Begin
    If (recDocume.opcAgrupaPor = opcPedido) Then

      strSQL := strSQL + ' AND E.FDO_SEPEXP = "N" '

    Else
    Begin
      strSQL := strSQL + ' AND (IFNULL((SELECT DET_SEPIMP ' +
                                      ' FROM ROMDETX RD   ' +
                                      ' WHERE RD.DET_NUMROM = R.GER_NUMROM AND ' +
                                            ' RD.DET_EMPROM = R.GER_EMPROM AND ' +
                                            ' RD.DET_AUTINC = FD.AUTOINCREM), "N") <> "S") ';
    End;
  End;

  if fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
  begin
    strSQL := strSQL + ' AND FDO_JAFATU = 0 ';
  end;

  strSQL := strSQL + fGetSqlGroupByPedOrc;

  With recDocume Do
    If blnDocSep And (Not fEmptyStr(Trim(strSetor))) Then
      strSQL := strSQL + ' HAVING SETOR_ = ' + QuotedStr(strSetor);

  strOrderByCfg := fRetOrdenacaoCFG_ORSPRO;
  If (Not fEmptyStr(strOrderByCfg)) Then
    strSQL := strSQL + strOrderByCfg
  Else
  If (recDocume.opcAgrupaPor = opcPedido) Then
    strSQL := strSQL + ' ORDER BY LOCFIS '
  Else
    strSQL := strSQL + ' ORDER BY FD.AUTOINCREM ';

  Result := strSQL;
End;

Function TLeDocumentoRO.fInsereClientRomGer: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLRomGer);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados.fGetDataset;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    If (opcAgrupaPor = opcPedido) Then
    Begin
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If fCfgSis('RMPDPA', varBoolean) Then
      begin
        ParamByName('NUMROM').AsString := recDocume.strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
      end;
    End
    Else
    Begin
      If fCfgSis('RMPDPA', varBoolean) Then
        ParamByName('NUMROM').AsString := recDocume.strNumRom
      else
        ParamByName('NUMROM').AsString := strNumDoc;

      ParamByName('CODEMP').AsString := strCodEmp;

      If (opcAgrupaPor = opcCliente) Then
        ParamByName('CODCLI').AsString := strCodCli;
    End;

    Result := fAbreClient(True, 'fInsereClientRomGer');
  End;

End;

function TLeDocumentoRO.fGetSqlGroupByPedOrc: String;
begin
  Result := '';

  With recDocume Do
  If blnAgruparItensSeparacao Then
  Begin
    Result := Result + ' GROUP BY ';
    Result := Result + '   FDO_CODITE, FDO_IDEPRO, FDO_DESCRI, FDO_NUMLOT, ';

    if fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
      Result := Result + '   LOCFIS, ';

    Result := Result + '   UNI_SIGUNI, FDO_CODACA, FDO_EMPACA ';

    if Pos('1', fCfgSis('ORSPRO', varString)) > 0 then
       Result := Result + ', FDO_NUMDOC ';
  End;

end;

function TLeDocumentoRO.fGetSqlQtdEmbPedOrc: String;
begin
  Result := 'IF(ITE_MLTVEN > 1, ' + fGetSqlQtdItePedOrc + ' / ITE_MLTVEN, 0)';
end;

function TLeDocumentoRO.fGetSqlQtdItePedOrc: String;
begin
  With recDocume Do
  Begin
    if fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
      Result := 'LD.LDO_QTDITE'
    else
    if fCfgSis('RMPDPA', varBoolean) then
      Result := 'DET_QTDITE'
    else
    If blnQtdOri Then
      Result := SQL_QTDITE
    Else
      Result := '(' + SQL_QTDITE + ' - FDO_QTDBAI)';
  End;
end;

Function TLeDocumentoRO.fInsereClientRomDet: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLRomDet);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados.fGetDataset;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    If (opcAgrupaPor = opcPedido) Then
    Begin
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If (Params.FindParam('CODLSE') <> Nil) Then
        ParamByName('CODLSE').AsString := strCodLse;

      If fCfgSis('RMPDPA', varBoolean) Then
      begin
        ParamByName('NUMROM').AsString := recDocume.strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
      end;
    End
    Else
    Begin
      If fCfgSis('RMPDPA', varBoolean) Then
        ParamByName('NUMROM').AsString := recDocume.strNumRom
      else
        ParamByName('NUMROM').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      If (opcAgrupaPor = opcCliente) Then
        ParamByName('CODCLI').AsString := strCodCli;
    End;

     Result := fAbreClient(True, 'fInsereClientRomDet') And (Not IsEmpty);
  End;

End;


Function TLeDocumentoRO.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
Begin
  Try
    Result := True;

    Result    := Result And fInsereClientRomDet;
    cdsRomGer := arrClients[0].cdsDados;

    Result    := Result And fInsereClientRomGer;
    cdsRomDet := arrClients[1].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fInsereClientEmpresa;

    If (recDocume.opcAgrupaPor = opcNaoAgrupa) Then
      recDocume.strCodCli := EmptyStr;

    Result := Result And fInsereClientCliente;

    Result := Result and fInsereClientEnderecoEntrega('AUTOINCREM', 'ROMGERX', '');

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

function TLeDocumentoRO.fRetOrdenacaoCFG_ORSPRO: String;
var
  intContador: Integer;
  strValorCfg,
  strCamposConcat,
  strDesc: String;
begin
  Result := 'ORDER BY ';
  strValorCfg := fCfgSis('ORSPRO', varString);

  If fEmptyStr(strValorCfg) Then
  begin
    Result := '';
    Exit;
  end;

  For intContador := 0 To Length(strValorCfg) DO
  Begin
    case StrToIntDef(strValorCfg[intContador], -1) of
      0: strDesc     := ' DESC';
      1: strCamposConcat := strCamposConcat + 'FD.FDO_NUMDOC';
    end;
  End;

  Result := Result + strCamposConcat + strDesc;
end;

end.
