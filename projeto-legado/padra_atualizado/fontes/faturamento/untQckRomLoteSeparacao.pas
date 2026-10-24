unit untQckRomLoteSeparacao;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, Data.DB, Uni,
  Forms;

Type
  TModeloImpressao = (modSeparacao, modConferencia);

type
  TfrmQckRomLoteSeparacao = class(TForm)
    frxReportConferencia: TfrxReport;
    frxDBSeparacao: TfrxDBDataset;
    frxDBConferencia: TfrxDBDataset;
    dtsSeparacao: TDataSource;
    dtsConferencia: TDataSource;
    frxReportSeparacao: TfrxReport;
    frxDBSeparacaoVolumes: TfrxDBDataset;
    dtsSeparacaoVolumes: TDataSource;
    frxDBConferenciaVolumes: TfrxDBDataset;
    dtsConferenciaVolumes: TDataSource;
    dtsSeparacaoResumo: TDataSource;
    frxDBSeparacaoResumo: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure pImprimeRomaneioLoteSeparacao(typModelo: TModeloImpressao; strNumRom, strCodEmp: String; blnPedFat: Boolean = False);


implementation


uses untFuncoesGenerica, untModuloSPR, untFuncoesSimples, Controls, untConstantes, untCfgRel;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure pImprimeRomaneioLoteSeparacao(typModelo: TModeloImpressao; strNumRom, strCodEmp : String; blnPedFat: Boolean = False);
Var
 qryConferencia,
 qryConferenciaVolumes,
 qrySeparacaoResumo,
 qrySeparacao,
 qrySeparacaoVolumes : TUniQuery;
 strSQLResumo,
 strSQL: String;
 strRelatorio: string;
 frmQckRomLoteSeparacao: TfrmQckRomLoteSeparacao;

 function fSQLQtdPedido: String;
 begin
   If fCfgSis('ROMLPA', VarBoolean) Then
     Result := 'RLI_QTDSEP'
   Else
     Result := ' IF(((FDO_QTDBAI>0) AND (FDO_QTDBAI<FDO_QTDITE)), (FDO_QTDITE-FDO_QTDBAI), FDO_QTDITE) ';
 end;

 function fSQLPesoPedido(strCampoPeso: String): String;
 begin
   Result := ' (ROUND(('+strCampoPeso+' / FDO_QTDITE) * (' + fSQLQtdPedido + '), 2)) ';
 end;

 function fSQLQtdVenda: String;
 begin
   If fCfgSis('ROMLPA', VarBoolean) Then
     Result := ' RLI_QTDSEP '
   Else
     Result := ' DET_QTDITE ';
 end;

 function fSQLPesoVenda(strCampoPeso: String): String;
 begin
   Result := ' (ROUND(('+strCampoPeso+' / DET_QTDITE) * (' + fSQLQtdVenda + '), 2)) ';
 end;

Begin
  try
    pCriarFormularios(TfrmQckRomLoteSeparacao, frmQckRomLoteSeparacao);
    With frmQckRomLoteSeparacao Do
    Begin
      If typModelo = modSeparacao Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT                                                                          ';
        strSQL := strSQL + ' NUMLOT,                                                                        ';
        strSQL := strSQL + ' DTACAD,                                                                        ';
        strSQL := strSQL + ' DESLOT,                                                                        ';
        strSQL := strSQL + ' SEQUEN,                                                                        ';
        strSQL := strSQL + ' NUMDOC,                                                                        ';
        strSQL := strSQL + ' ESPDOC,                                                                        ';
        strSQL := strSQL + ' NUMFAT,                                                                        ';
        strSQL := strSQL + ' NOMMOT,                                                                        ';
        strSQL := strSQL + ' NOMTRA,                                                                        ';
        strSQL := strSQL + ' NOMCLI,                                                                        ';
        strSQL := strSQL + ' NOMCID,                                                                        ';

        strSQL := strSQL + ' CIDENT,                                                                        ';
        strSQL := strSQL + ' REGENT,                                                                        ';
        strSQL := strSQL + ' ENDENT,                                                                        ';
        strSQL := strSQL + ' BAIENT,                                                                        ';
        strSQL := strSQL + ' CEPENT,                                                                        ';

        strSQL := strSQL + ' NOMVEN,                                                                        ';
        strSQL := strSQL + ' CODITE,                                                                        ';
        strSQL := strSQL + ' DESCRI,                                                                        ';
        strSQL := strSQL + ' LOTITE,                                                                        ';
        strSQL := strSQL + ' PESBRU,                                                                        ';
        strSQL := strSQL + ' PESLIQ,                                                                        ';
        strSQL := strSQL + ' EMBALA,                                                                        ';
        strSQL := strSQL + ' UNDCOP,                                                                        ';
        strSQL := strSQL + ' VOLUME,                                                                        ';
        strSQL := strSQL + ' QTDEMB,                                                                        ';
        strSQL := strSQL + ' UNDVEN,                                                                        ';
        strSQL := strSQL + ' QTDUNI,                                                                        ';
        strSQL := strSQL + ' OBSER1,                                                                        ';
        strSQL := strSQL + ' OBSER2,                                                                        ';
        strSQL := strSQL + ' ROUND(IF(QTDUNI > 0, IF(MLTVEN > 0, QTDUNI/MLTVEN, 0), 0),2) AS CALCVO,        ';
        strSQL := strSQL + ' CODEMP,                                                                        ';
        strSQL := strSQL + ' BARDOC,                                                                        ';
        strSQL := strSQL + ' LOCFIS,                                                                        ';
        strSQL := strSQL + ' CODBAR,                                                                        ';
        strSQL := strSQL + ' DESMAR,                                                                        ';
        strSQL := strSQL + ' LSEDES,                                                                        ';
        strSQL := strSQL + ' PLAVEI,                                                                        ';
        strSQL := strSQL + ' DESVEI,                                                                        ';
        strSQL := strSQL + ' BOXLOT,                                                                        ';
        strSQL := strSQL + ' OBSERV,                                                                        ';
        strSQL := strSQL + ' MENEXP,                                                                        ';
        strSQL := strSQL + ' IDEPRO,                                                                        ';
        strSQL := strSQL + ' DTENTI                                                                         ';
        strSQL := strSQL + 'FROM (                                                                          ';
        strSQL := strSQL + ' SELECT                                                                         ';
        strSQL := strSQL + '  RLG_NUMLOT AS NUMLOT,                                                         ';
        strSQL := strSQL + '  RLG_DTACAD AS DTACAD,                                                         ';
        strSQL := strSQL + '  RLG_DESLOT AS DESLOT,                                                         ';
        strSQL := strSQL + '  RLD_SEQUEN AS SEQUEN,                                                         ';
        strSQL := strSQL + '  FDO_NUMDOC AS NUMDOC,                                                         ';
        strSQL := strSQL + '  FDO_ESPDOC AS ESPDOC,                                                         ';
        strSQL := strSQL + '  RLG_PLAVEI AS PLAVEI,                                                         ';
        strSQL := strSQL + '  RLG_DESVEI AS DESVEI,                                                         ';
        strSQL := strSQL + '  RLG_BOXLOT AS BOXLOT,                                                         ';
        strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CONCAT(X.DET_NUMDOC, "-", X.DET_ESPDOC)) FROM MOVDET X WHERE X.DET_NUM_PD = FGO_NUMDOC AND X.DET_ESP_PD = FGO_ESPDOC AND X.DET_EMP_PD = FGO_CODEMP) AS NUMFAT, ';
        strSQL := strSQL + '  CONCAT(RLG_CODMOT, "-", MOT_NOMMOT) AS NOMMOT,                                ';
        strSQL := strSQL + '  CONCAT(RLG_CODTRA, "-", TRA_NOMTRA) AS NOMTRA,                                ';
        strSQL := strSQL + '  CONCAT(FDO_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,                                ';
        strSQL := strSQL + '  CONCAT(CIDENT.CID_NOMCID, "-", CIDENT.CID_ESTADO) AS NOMCID,                  ';
        strSQL := strSQL + '  IF(FDO_ENTRET = "E",                                                          ';
        strSQL := strSQL + '    CONCAT(CIDENT.CID_NOMCID, "-", CIDENT.CID_ESTADO),                          ';
        strSQL := strSQL + '    CONCAT(CIDCLI.CID_NOMCID, "-", CIDCLI.CID_ESTADO)                           ';
        strSQL := strSQL + '  ) AS CIDENT,                                                                  ';
        strSQL := strSQL + '  IF(FDO_ENTRET = "E", REGENT.REG_DESREG, REGCLI.REG_DESREG) AS REGENT,         ';
        strSQL := strSQL + '  IF(FDO_ENTRET = "E", EC.ETC_ENDENT, FGO_ENDCON) AS ENDENT,                    ';
        strSQL := strSQL + '  IF(FDO_ENTRET = "E", EC.ETC_BAIENT, FGO_BAICON) AS BAIENT,                    ';
        strSQL := strSQL + '  IF(FDO_ENTRET = "E", EC.ETC_CEPENT, FGO_CEPCON) AS CEPENT,                    ';
        strSQL := strSQL + '  CONCAT(FDO_CODVEN, "-", H.OPE_NOMOPE) AS NOMVEN,                              ';
        strSQL := strSQL + '  FDO_CODITE AS CODITE,                                                         ';
        strSQL := strSQL + '  FDO_DESCRI AS DESCRI,                                                         ';
        strSQL := strSQL + '  D.FDO_NUMLOT AS LOTITE,                                                       ';
        strSQL := strSQL + fSQLPesoPedido('FDO_TOTPES')+' AS PESBRU, ';
        strSQL := strSQL + fSQLPesoPedido('FDO_PESLIQ')+' AS PESLIQ, ';
        strSQL := strSQL + '  ITE_EMBALA AS EMBALA,                                                         ';
        strSQL := strSQL + '  O.UNI_SIGUNI AS UNDCOP,                                                       ';
        strSQL := strSQL + '  TRUNCATE(( '+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ),0) AS VOLUME,     ';

        strSQL := strSQL + '  CONCAT( TRUNCATE( '+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) , 0), "/",   ';
        strSQL := strSQL + '          TRUNCATE(( MOD( '+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) , 1) * ';
        strSQL := strSQL + '                     IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ) ,0)) AS QTDEMB,        ';

        strSQL := strSQL + '  F.UNI_SIGUNI AS UNDVEN,                                                       ';
        strSQL := strSQL + '  '+fSQLQtdPedido+' AS QTDUNI,                                                         ';
        strSQL := strSQL + '  LROOBS.OBS_OBSER1 AS OBSER1,                                                  ';
        strSQL := strSQL + '  LROOBS.OBS_OBSER2 AS OBSER2,                                                  ';
        strSQL := strSQL + '  N.ITE_MLTVEN AS MLTVEN,                                                       ';
        strSQL := strSQL + '  FDO_CODEMP AS CODEMP,                                                         ';
        strSQL := strSQL + fSQLBarDoc('FGO') + ' AS BARDOC, ';
        strSQL := strSQL + '  R.ITE_LOCFIS AS LOCFIS,                                                       ';
        strSQL := strSQL + '  N.ITE_CODBAR AS CODBAR,                                                       ';
        strSQL := strSQL + '  MA.MAR_DESMAR AS DESMAR,                                                      ';
        strSQL := strSQL + '  LSE.LSE_DESCRI AS LSEDES,                                                     ';
        strSQL := strSQL + '  E.CLI_OBSERV AS OBSERV,                                                       ';
        strSQL := strSQL + '  C.FGO_MENEXP AS MENEXP,                                                       ';
        strSQL := strSQL + '  FDO_IDEPRO AS IDEPRO,                                                         ';
        strSQL := strSQL + '  FDO_DTENTR AS DTENTI                                                          ';

        strSQL := strSQL + ' FROM ROMLGE A                                                                  ';
        strSQL := strSQL + '  INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM                            ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM                        ';

        strSQL := strSQL + '  LEFT  JOIN FATGOR C ON C.FGO_NUMDOC = B.RLD_NUMDOC AND                        ';
        strSQL := strSQL + '                         C.FGO_ESPDOC = B.RLD_ESPDOC AND                        ';
        strSQL := strSQL + '                         C.FGO_CODEMP = B.RLD_CODEMP                            ';

        strSQL := strSQL + '  INNER JOIN FATDOR D ON D.FDO_SEQGER = C.AUTOINCREM                            ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  AND D.AUTOINCREM = RI.RLI_SEQFDO                                            ';

        strSQL := strSQL + '  INNER JOIN EXTDOR W ON W.FDO_SEQFDO = D.AUTOINCREM                            ';
        strSQL := strSQL + '  INNER JOIN CADCLI E ON E.CLI_CODCLI = C.FGO_CODCLI                            ';
        strSQL := strSQL + '  LEFT  JOIN CADUNI F ON F.UNI_CODUNI = D.FDO_UNIDAD                            ';
        strSQL := strSQL + '  LEFT  JOIN CADOPE G ON G.OPE_CODOPE = D.FDO_CODREP                            ';
        strSQL := strSQL + '  LEFT  JOIN CADOPE H ON H.OPE_CODOPE = D.FDO_CODVEN                            ';
        strSQL := strSQL + '  LEFT  JOIN CADOPE I ON I.OPE_CODOPE = D.FDO_CODVE2                            ';
        strSQL := strSQL + '  LEFT  JOIN CADMOT J ON J.MOT_CODMOT = A.RLG_CODMOT                            ';
        strSQL := strSQL + '  LEFT  JOIN CADTRA L ON L.TRA_CODTRA = A.RLG_CODTRA                            ';
        strSQL := strSQL + '  LEFT  JOIN AUXGOR AX ON AX.AUX_SEQGER = C.AUTOINCREM                          ';
        strSQL := strSQL + '  LEFT  JOIN ENTCLI EC ON EC.ETC_CODCLI = C.FGO_CODCLI                          ';
        strSQL := strSQL + '    AND IF(IFNULL(AX.AUX_ENTGER, "") <> "", EC.AUTOINCREM = AX.AUX_ENTGER,      ';
        strSQL := strSQL + '      EC.ETC_SEQIND = (SELECT MIN(EC2.ETC_SEQIND) FROM ENTCLI EC2                ';
        strSQL := strSQL + '      WHERE EC2.ETC_CODCLI = FGO_CODCLI))                                       ';
        strSQL := strSQL + '  LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = EC.ETC_CIDENT                  ';
        strSQL := strSQL + '  LEFT JOIN CADREG REGENT ON REGENT.REG_CODREG = EC.ETC_CODREG                  ';
        strSQL := strSQL + '  LEFT JOIN CADCID CIDCLI ON CIDCLI.CID_CODCID = C.FGO_CIDCON                   ';
        strSQL := strSQL + '  LEFT JOIN CADREG REGCLI ON REGCLI.REG_CODREG = E.CLI_CODREG                   ';
        strSQL := strSQL + '  INNER JOIN CADITE N ON N.ITE_CODITE = D.FDO_CODITE                            ';
        strSQL := strSQL + '  LEFT  JOIN CADUNI O ON O.UNI_CODUNI = N.ITE_UNICOM                            ';
        strSQL := strSQL + '  LEFT  JOIN CADMAR MA ON N.ITE_CODMAR = MA.MAR_CODMAR                          ';
        strSQL := strSQL + '  LEFT  JOIN LROOBS ON LROOBS.OBS_NUMDOC = D.FDO_NUMDOC                         ';
        strSQL := strSQL + '                   AND LROOBS.OBS_ESPDOC = D.FDO_ESPDOC                         ';
        strSQL := strSQL + '                   AND LROOBS.OBS_CODEMP = D.FDO_CODEMP                         ';
        strSQL := strSQL + '                   AND LROOBS.OBS_CODCLI = D.FDO_CODCLI                         ';
        strSQL := strSQL + '                   AND IFNULL(LROOBS.OBS_SERIE_,"") = IFNULL(D.FDO_SERIE_,"")   ';

        strSQL := strSQL + ' LEFT JOIN ITEGER R ON R.ITE_CODITE = D.FDO_CODITE                              ';
        strSQL := strSQL + '                   AND R.ITE_CODEMP = D.FDO_CODEMP                              ';

        strSQL := strSQL + ' LEFT JOIN CADLOC LOC ON LOC.LOC_CODLOC = R.ITE_LOCFIS AND LOC.LOC_CODEMP = D.FDO_CODEMP ';
        strSQL := strSQL + ' LEFT JOIN CADLSE LSE ON LSE.LSE_CODIGO = LOC.LOC_CODLSE                        ';

        strSQL := strSQL + '  WHERE RLG_NUMLOT = :NUMLOT                                                    ';
        strSQL := strSQL + '    AND RLG_CODEMP = :CODEMP                                                    ';

        If blnPedFat Then
          strSQL := strSQL + '    AND FDO_JAFATU = 1                                                        '
        Else
          strSQL := strSQL + '    AND FDO_JAFATU = 0                                                        ';

        strSQL := strSQL + ' UNION ALL                                                                      ';

        strSQL := strSQL + ' SELECT                                                                         ';
        strSQL := strSQL + '  RLG_NUMLOT AS NUMLOT,                                                         ';
        strSQL := strSQL + '  RLG_DTACAD AS DTACAD,                                                         ';
        strSQL := strSQL + '  RLG_DESLOT AS DESLOT,                                                         ';
        strSQL := strSQL + '  RLD_SEQUEN AS SEQUEN,                                                         ';
        strSQL := strSQL + '  GER_NUMDOC AS NUMDOC,                                                         ';
        strSQL := strSQL + '  GER_ESPDOC AS ESPDOC,                                                         ';
        strSQL := strSQL + '  RLG_PLAVEI AS PLAVEI,                                                         ';
        strSQL := strSQL + '  RLG_DESVEI AS DESVEI,                                                         ';
        strSQL := strSQL + '  RLG_BOXLOT AS BOXLOT,                                                         ';
        strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CONCAT(X.DET_NUMDOC, "-", X.DET_ESPDOC)) FROM MOVDET X WHERE X.DET_NUM_PD = GER_NUMDOC AND X.DET_ESP_PD = GER_ESPDOC AND X.DET_EMP_PD = GER_CODEMP) AS NUMFAT, ';
        strSQL := strSQL + '  CONCAT(RLG_CODMOT, "-", MOT_NOMMOT) AS NOMMOT,                                ';
        strSQL := strSQL + '  CONCAT(RLG_CODTRA, "-", TRA_NOMTRA) AS NOMTRA,                                ';
        strSQL := strSQL + '  CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,                                ';
        strSQL := strSQL + '  CONCAT(CIDCLI.CID_NOMCID, "-", CIDCLI.CID_ESTADO) AS NOMCID ,                 ';
        strSQL := strSQL + '  IF(GER_ENTFAT = "S",                                                          ';
        strSQL := strSQL + '    CONCAT(CIDENT.CID_NOMCID, "-", CIDENT.CID_ESTADO),                          ';
        strSQL := strSQL + '    CONCAT(CIDCLI.CID_NOMCID, "-", CIDCLI.CID_ESTADO)                           ';
        strSQL := strSQL + '  ) AS CIDENT,                                                                  ';
        strSQL := strSQL + '  IF(GER_ENTFAT = "S", REGENT.REG_DESREG, REGCLI.REG_DESREG) AS REGENT,         ';
        strSQL := strSQL + '  IF(GER_ENTFAT = "S", EC.ETC_ENDENT, GER_ENDCON) AS ENDENT,                    ';
        strSQL := strSQL + '  IF(GER_ENTFAT = "S", EC.ETC_BAIENT, GER_BAICON) AS BAIENT,                    ';
        strSQL := strSQL + '  IF(GER_ENTFAT = "S", EC.ETC_CEPENT, GER_CEPCON) AS CEPENT,                    ';
        strSQL := strSQL + '  CONCAT(DET_CODVEN, "-", H.OPE_NOMOPE) AS NOMVEN,                              ';
        strSQL := strSQL + '  DET_CODITE AS CODITE,                                                         ';
        strSQL := strSQL + '  DET_DESCRI AS DESCRI,                                                         ';
        strSQL := strSQL + '  D.DET_NUMLOT AS LOTITE,                                                       ';
        strSQL := strSQL + fSQLPesoVenda('DET_TOTPES') + ' AS PESBRU,                                       ';
        strSQL := strSQL + fSQLPesoVenda('DET_PESLIQ') + ' AS PESLIQ,                                       ';
        strSQL := strSQL + '  ITE_EMBALA AS EMBALA,                                                         ';
        strSQL := strSQL + '  O.UNI_SIGUNI AS UNDCOP,                                                       ';
        strSQL := strSQL + '  TRUNCATE((' + fSQLQtdVenda + ' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1)),0) AS VOLUME,       ';

        strSQL := strSQL + '  CONCAT( TRUNCATE( ' + fSQLQtdVenda + ' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) , 0), "/",   ';
        strSQL := strSQL + '          TRUNCATE(( MOD( ' + fSQLQtdVenda + ' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) , 1) * ';
        strSQL := strSQL + '                     IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ) ,0)) AS QTDEMB,        ';

        strSQL := strSQL + '  F.UNI_SIGUNI AS UNDVEN,                                                       ';
        strSQL := strSQL + '  ' + fSQLQtdVenda + ' AS QTDUNI,                                                         ';
        strSQL := strSQL + '  LROOBS.OBS_OBSER1 AS OBSER1,                                                  ';
        strSQL := strSQL + '  LROOBS.OBS_OBSER2 AS OBSER2,                                                  ';
        strSQL := strSQL + '  N.ITE_MLTVEN AS MLTVEN,                                                       ';
        strSQL := strSQL + '  GER_CODEMP AS CODEMP,                                                         ';
        strSQL := strSQL + fSQLBarDoc('GER') + ' AS BARDOC, ';
        strSQL := strSQL + '  R.ITE_LOCFIS AS LOCFIS,                                                       ';
        strSQL := strSQL + '  N.ITE_CODBAR AS CODBAR,                                                       ';
        strSQL := strSQL + '  MA.MAR_DESMAR AS DESMAR,                                                      ';
        strSQL := strSQL + '  LSE.LSE_DESCRI AS LSEDES,                                                     ';
        strSQL := strSQL + '  E.CLI_OBSERV AS OBSERV,                                                       ';
        strSQL := strSQL + '  GER_MENEXP AS MENEXP,                                                         ';
        strSQL := strSQL + '  DET_IDEPRO AS IDEPRO,                                                         ';
        strSQL := strSQL + '  NULL AS DTENTI                                                                ';

        strSQL := strSQL + ' FROM ROMLGE A                                                                  ';
        strSQL := strSQL + ' INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM                             ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM                        ';

        strSQL := strSQL + ' LEFT  JOIN MOVGER C ON C.GER_NUMDOC = B.RLD_NUMDOC AND                         ';
        strSQL := strSQL + '                        C.GER_ESPDOC = B.RLD_ESPDOC AND                         ';
        strSQL := strSQL + '                        C.GER_CODEMP = B.RLD_CODEMP AND                         ';
        strSQL := strSQL + '                        C.GER_SERIE_ = B.RLD_SERIE_                             ';
        strSQL := strSQL + ' INNER JOIN MOVDET D ON D.DET_SEQGER = C.AUTOINCREM                             ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  AND D.AUTOINCREM = RI.RLI_SEQDET                                            ';

        strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM                             ';
        strSQL := strSQL + ' LEFT  JOIN AUXMOV   ON   AUX_SEQGER = C.AUTOINCREM                             ';
        strSQL := strSQL + ' INNER JOIN CADCLI E ON E.CLI_CODCLI = C.GER_CODCLI                             ';
        strSQL := strSQL + ' LEFT  JOIN CADUNI F ON F.UNI_CODUNI = D.DET_UNIDAD                             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE G ON G.OPE_CODOPE = D.DET_CODREP                             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE H ON H.OPE_CODOPE = D.DET_CODVEN                             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE I ON I.OPE_CODOPE = D.DET_CODVE2                             ';
        strSQL := strSQL + ' LEFT  JOIN CADMOT J ON J.MOT_CODMOT = A.RLG_CODMOT                             ';
        strSQL := strSQL + ' LEFT  JOIN CADTRA L ON L.TRA_CODTRA = A.RLG_CODTRA                             ';
        strSQL := strSQL + ' LEFT  JOIN ENTCLI EC ON EC.ETC_CODCLI = C.GER_CODCLI                           ';
        strSQL := strSQL + '   AND EC.AUTOINCREM = AUX_ENTGER                                               ';
        strSQL := strSQL + ' LEFT  JOIN CADCID CIDENT ON CIDENT.CID_CODCID = EC.ETC_CIDENT                  ';
        strSQL := strSQL + ' LEFT  JOIN CADREG REGENT ON REGENT.REG_CODREG = EC.ETC_CODREG                  ';
        strSQL := strSQL + ' LEFT  JOIN CADCID CIDCLI ON CIDCLI.CID_CODCID = C.GER_CIDCON                   ';
        strSQL := strSQL + ' LEFT  JOIN CADREG REGCLI ON REGENT.REG_CODREG = E.CLI_CODREG                   ';
        strSQL := strSQL + ' INNER JOIN CADITE N ON N.ITE_CODITE = D.DET_CODITE                             ';
        strSQL := strSQL + ' LEFT  JOIN CADUNI O ON O.UNI_CODUNI = N.ITE_UNICOM                             ';
        strSQL := strSQL + ' LEFT  JOIN CADMAR MA ON N.ITE_CODMAR = MA.MAR_CODMAR                           ';
        strSQL := strSQL + ' LEFT  JOIN LROOBS ON LROOBS.OBS_NUMDOC = D.DET_NUMDOC                          ';
        strSQL := strSQL + '                  AND LROOBS.OBS_ESPDOC = D.DET_ESPDOC                          ';
        strSQL := strSQL + '                  AND LROOBS.OBS_CODEMP = D.DET_CODEMP                          ';
        strSQL := strSQL + '                  AND LROOBS.OBS_CODCLI = D.DET_CODCLI                          ';
        strSQL := strSQL + '                  AND IFNULL(LROOBS.OBS_SERIE_,"") = IFNULL(D.DET_SERIE_,"")    ';

        strSQL := strSQL + ' LEFT JOIN ITEGER R ON R.ITE_CODITE = D.DET_CODITE                              ';
        strSQL := strSQL + '                   AND R.ITE_CODEMP = D.DET_CODEMP                              ';

        strSQL := strSQL + ' LEFT JOIN CADLOC LOC ON LOC.LOC_CODLOC = R.ITE_LOCFIS AND LOC.LOC_CODEMP = D.DET_CODEMP ';
        strSQL := strSQL + ' LEFT JOIN CADLSE LSE ON LSE.LSE_CODIGO = LOC.LOC_CODLSE                        ';

        strSQL := strSQL + ' WHERE RLG_NUMLOT = :NUMLOT                                                     ';
        strSQL := strSQL + '   AND RLG_CODEMP = :CODEMP ) TMP                                               ';

        strSQLResumo := strSQL;

        strSQL := strSQL + 'ORDER BY SEQUEN DESC, DESCRI                                                    ';

        strSQLResumo := strSQLResumo + 'ORDER BY LSEDES, DESCRI                                             ';

        Try
          qrySeparacao        := fCriaQuery;
          qrySeparacaoVolumes := fCriaQuery;
          qrySeparacaoResumo  := fCriaQuery;

          With qrySeparacao Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NUMLOT').AsString := strNumRom;
            ParamByName('CODEMP').AsString := strCodEmp;
            Open;
          End;

          If qrySeparacao.IsEmpty Then
          Begin
            pMensagemOk('Lote de Separação para Romaneios com pedidos já faturados.'+ sLineBreak +
                        'Favor acessar a rotina de Lote de Separação para Romaneio - Manutenção');
          End
          Else
          Begin
            strSQL := '';
            strSQL := strSQL + 'SELECT                                                                   ';
            strSQL := strSQL + '  EMBALAGEM,                                                             ';
            strSQL := strSQL + '  SUM(VOLUMES) AS VOLUMES,                                               ';
            strSQL := strSQL + '  SUM(PESO) AS PESO                                                      ';
            strSQL := strSQL + 'FROM (                                                                   ';
            strSQL := strSQL + 'SELECT                                                                   ';
            strSQL := strSQL + '  UNI_DESUNI AS EMBALAGEM,                                               ';
            strSQL := strSQL + '  TRUNCATE('+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1),0) AS VOLUMES, ';
            strSQL := strSQL + fSQLPesoPedido('FDO_TOTPES')+' AS PESO ';
            strSQL := strSQL + 'FROM ROMLGE A                                                            ';
            strSQL := strSQL + 'INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM                       ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + 'INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM                   ';

            strSQL := strSQL + 'INNER JOIN FATDOR C ON C.FDO_NUMDOC = B.RLD_NUMDOC AND                   ';
            strSQL := strSQL + '                       C.FDO_ESPDOC = B.RLD_ESPDOC AND                   ';
            strSQL := strSQL + '                       C.FDO_CODEMP = B.RLD_CODEMP                       ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + '  AND C.AUTOINCREM = RI.RLI_SEQFDO                                     ';

            strSQL := strSQL + 'INNER JOIN CADITE D ON D.ITE_CODITE = C.FDO_CODITE                       ';
            strSQL := strSQL + 'LEFT  JOIN CADUNI E ON E.UNI_CODUNI = D.ITE_UNICOM                       ';
            strSQL := strSQL + 'WHERE RLG_NUMLOT = :NUMLOT                                               ';
            strSQL := strSQL + '  AND RLG_CODEMP = :CODEMP                                               ';
            strSQL := strSQL + '  AND FDO_JAFATU = 0                                                     ';

            strSQL := strSQL + 'UNION ALL                                                                ';

            strSQL := strSQL + 'SELECT                                                                   ';
            strSQL := strSQL + '  UNI_DESUNI AS EMBALAGEM,                                               ';
            strSQL := strSQL + '  TRUNCATE(' + fSQLQtdVenda + ' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1),0) AS VOLUMES, ';
            strSQL := strSQL + fSQLPesoVenda('DET_TOTPES')  + ' AS PESO                                            ';
            strSQL := strSQL + 'FROM ROMLGE A                                                            ';
            strSQL := strSQL + 'INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM                       ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + 'INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM                   ';

            strSQL := strSQL + 'INNER JOIN MOVDET C ON C.DET_NUMDOC = B.RLD_NUMDOC AND                   ';
            strSQL := strSQL + '                       C.DET_ESPDOC = B.RLD_ESPDOC AND                   ';
            strSQL := strSQL + '                       C.DET_CODEMP = B.RLD_CODEMP                       ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + '  AND C.AUTOINCREM = RI.RLI_SEQDET                                     ';

            strSQL := strSQL + 'INNER JOIN CADITE D ON D.ITE_CODITE = C.DET_CODITE                       ';
            strSQL := strSQL + 'LEFT  JOIN CADUNI E ON E.UNI_CODUNI = D.ITE_UNICOM                       ';
            strSQL := strSQL + 'WHERE RLG_NUMLOT = :NUMLOT                                               ';
            strSQL := strSQL + '  AND RLG_CODEMP = :CODEMP ) TMP                                         ';
            strSQL := strSQL + 'GROUP BY EMBALAGEM                                                       ';

            With qrySeparacaoVolumes Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('NUMLOT').AsString := strNumRom;
              ParamByName('CODEMP').AsString := strCodEmp;
              Open;
            End;

            With qrySeparacaoResumo Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQLResumo);
              ParamByName('NUMLOT').AsString := strNumRom;
              ParamByName('CODEMP').AsString := strCodEmp;
              Open;
            End;

            dtsSeparacao.DataSet        := qrySeparacao;
            dtsSeparacaoVolumes.DataSet := qrySeparacaoVolumes;
            dtsSeparacaoResumo.DataSet  := qrySeparacaoResumo;

            frxDBSeparacao.Initialize;
            frxDBSeparacaoVolumes.Initialize;
            frxDBSeparacaoResumo.Initialize;

            strRelatorio := fCfgSis('PATETI') + '\Romaneio_Lote_Separacao_Sep.fr3';

            if FileExists(strRelatorio) then
            begin
              frxReportSeparacao.LoadFromFile(strRelatorio);
            end;

            pPreviewReport('frmQckRomLoteSeparacao', 'Romaneio Lote Separação', frxReportSeparacao);

            fExecutaSQL('UPDATE ROMLDE SET RLD_SEPIMP = "S" '+
                        'WHERE RLD_SEQRLG = (SELECT AUTOINCREM '+
                        '                    FROM ROMLGE '+
                        '                    WHERE RLG_NUMLOT = "' + strNumRom    + '"   ' +
                        '                      AND RLG_CODEMP = "' + VS_strCodEmp + '" ) ');
          End;

        Finally
          FreeAndNil(qrySeparacao);
          FreeAndNil(qrySeparacaoVolumes);
          FreeAndNil(qrySeparacaoResumo);
        End;
      End
      Else If typModelo = modConferencia Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT                                                          ';
        strSQL := strSQL + ' NUMLOT,                                                        ';
        strSQL := strSQL + ' DTACAD,                                                        ';
        strSQL := strSQL + ' DESLOT,                                                        ';
        strSQL := strSQL + ' NOMMOT,                                                        ';
        strSQL := strSQL + ' NOMTRA,                                                        ';
        strSQL := strSQL + ' CODITE,                                                        ';
        strSQL := strSQL + ' DESCRI,                                                        ';
        strSQL := strSQL + ' EMBALA,                                                        ';
        strSQL := strSQL + ' UNDCOP,                                                        ';
        strSQL := strSQL + ' UNDVEN,                                                        ';
        strSQL := strSQL + ' ITELOT,                                                        ';
        strSQL := strSQL + ' REFERE,                                                        ';
        strSQL := strSQL + ' CODBAR,                                                        ';
        strSQL := strSQL + ' PLAVEI,                                                        ';
        strSQL := strSQL + ' DESVEI,                                                        ';
        strSQL := strSQL + ' BOXLOT,                                                        ';
        strSQL := strSQL + ' SUM(TOTPES) AS TOTPES,                                         ';
        strSQL := strSQL + ' SUM(QTDUNI) AS QTDUNI,                                         ';
        strSQL := strSQL + ' CONCAT( TRUNCATE( SUM(QTDEMB), 0), "/",                        ';
        strSQL := strSQL + '         TRUNCATE( MOD( SUM(QTDEMB) , 1) * EMBALA,0)) AS QTDEMB, ';
        strSQL := strSQL + ' LOCFIS,                                                        ';
        strSQL := strSQL + ' LOCSUP,                                                        ';
        strSQL := strSQL + ' DESMAR,                                                        ';
        strSQL := strSQL + ' SUM(CALCVO) AS CALCVO                                          ';

        strSQL := strSQL + 'FROM (                                                          ';
        strSQL := strSQL + ' SELECT                                                         ';
        strSQL := strSQL + '  RLG_NUMLOT AS NUMLOT,                                         ';
        strSQL := strSQL + '  RLG_DTACAD AS DTACAD,                                         ';
        strSQL := strSQL + '  RLG_DESLOT AS DESLOT,                                         ';
        strSQL := strSQL + '  CONCAT(RLG_CODMOT, "-", MOT_NOMMOT) AS NOMMOT,                ';
        strSQL := strSQL + '  CONCAT(RLG_CODTRA, "-", TRA_NOMTRA) AS NOMTRA,                ';
        strSQL := strSQL + '  FDO_CODITE AS CODITE,                                         ';
        strSQL := strSQL + '  FDO_DESCRI AS DESCRI,                                         ';
        strSQL := strSQL + '  TRUNCATE(( '+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ),0) AS VOLUME, ';
        strSQL := strSQL + '  ITE_EMBALA AS EMBALA,                                         ';
        strSQL := strSQL + '  O.UNI_SIGUNI AS UNDCOP,                                       ';
        strSQL := strSQL + '  ( '+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ) AS QTDEMB, ';
        strSQL := strSQL + '  F.UNI_SIGUNI AS UNDVEN,                                       ';
        strSQL := strSQL + '  '+fSQLQtdPedido+' AS QTDUNI,                                  ';
        strSQL := strSQL + ' D.FDO_NUMLOT AS ITELOT,                                        ';
        strSQL := strSQL + ' N.ITE_REFERE AS REFERE,                                        ';
        strSQL := strSQL + ' N.ITE_CODBAR AS CODBAR,                                        ';
        strSQL := strSQL + ' RLG_PLAVEI AS PLAVEI,                                          ';
        strSQL := strSQL + ' RLG_DESVEI AS DESVEI,                                          ';
        strSQL := strSQL + ' RLG_BOXLOT AS BOXLOT,                                          ';
        strSQL := strSQL + fSQLPesoPedido('FDO_TOTPES')+' AS TOTPES,                        ';
        strSQL := strSQL + ' R.ITE_LOCFIS AS LOCFIS,                                        ';
        strSQL := strSQL + ' R.ITE_LOCSUP AS LOCSUP,                                        ';
        strSQL := strSQL + ' MA.MAR_DESMAR AS DESMAR,                                       ';
        strSQL := strSQL + ' ROUND(IF('+fSQLQtdPedido+' > 0, IF(N.ITE_MLTVEN > 0, '+fSQLQtdPedido+'/N.ITE_MLTVEN, 0), 0),2) AS CALCVO ';

        strSQL := strSQL + ' FROM ROMLGE A                                                  ';
        strSQL := strSQL + ' INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM             ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + ' INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM         ';

        strSQL := strSQL + ' LEFT  JOIN FATGOR C ON C.FGO_NUMDOC = B.RLD_NUMDOC AND         ';
        strSQL := strSQL + '                        C.FGO_ESPDOC = B.RLD_ESPDOC AND         ';
        strSQL := strSQL + '                        C.FGO_CODEMP = B.RLD_CODEMP             ';
        strSQL := strSQL + ' INNER JOIN FATDOR D ON D.FDO_SEQGER = C.AUTOINCREM             ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  AND D.AUTOINCREM = RI.RLI_SEQFDO                            ';

        strSQL := strSQL + ' LEFT  JOIN CADUNI F ON F.UNI_CODUNI = D.FDO_UNIDAD             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE G ON G.OPE_CODOPE = D.FDO_CODREP             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE H ON H.OPE_CODOPE = D.FDO_CODVEN             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE I ON I.OPE_CODOPE = D.FDO_CODVE2             ';
        strSQL := strSQL + ' LEFT  JOIN CADMOT J ON J.MOT_CODMOT = A.RLG_CODMOT             ';
        strSQL := strSQL + ' LEFT  JOIN CADTRA L ON L.TRA_CODTRA = A.RLG_CODTRA             ';
        strSQL := strSQL + ' INNER JOIN CADITE N ON N.ITE_CODITE = D.FDO_CODITE             ';
        strSQL := strSQL + ' LEFT  JOIN CADUNI O ON O.UNI_CODUNI = N.ITE_UNICOM             ';
        strSQL := strSQL + ' LEFT  JOIN CADMAR MA ON N.ITE_CODMAR = MA.MAR_CODMAR           ';

        strSQL := strSQL + ' LEFT JOIN ITEGER R ON R.ITE_CODITE = D.FDO_CODITE              ';
        strSQL := strSQL + '                   AND R.ITE_CODEMP = D.FDO_CODEMP              ';

        strSQL := strSQL + ' WHERE RLG_NUMLOT = :NUMLOT                                     ';
        strSQL := strSQL + '   AND RLG_CODEMP = :CODEMP                                     ';

        If blnPedFat Then
          strSQL := strSQL + '    AND FDO_JAFATU = 1                                        '
        Else
          strSQL := strSQL + '    AND FDO_JAFATU = 0                                        ';

        strSQL := strSQL + 'UNION ALL                                                       ';

        strSQL := strSQL + ' SELECT                                                         ';
        strSQL := strSQL + '  RLG_NUMLOT AS NUMLOT,                                         ';
        strSQL := strSQL + '  RLG_DTACAD AS DTACAD,                                         ';
        strSQL := strSQL + '  RLG_DESLOT AS DESLOT,                                         ';
        strSQL := strSQL + '  CONCAT(RLG_CODMOT, "-", MOT_NOMMOT) AS NOMMOT,                ';
        strSQL := strSQL + '  CONCAT(RLG_CODTRA, "-", TRA_NOMTRA) AS NOMTRA,                ';
        strSQL := strSQL + '  DET_CODITE AS CODITE,                                         ';
        strSQL := strSQL + '  DET_DESCRI AS DESCRI,                                         ';
        strSQL := strSQL + '  GER_VOLUME AS VOLUME,                                         ';
        strSQL := strSQL + '  ITE_EMBALA AS EMBALA,                                         ';
        strSQL := strSQL + '  O.UNI_SIGUNI AS UNDCOP,                                       ';
        strSQL := strSQL + '  ( ' + fSQLQtdVenda + ' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ) AS QTDEMB, ';
        strSQL := strSQL + '  F.UNI_SIGUNI AS UNDVEN,                                       ';
        strSQL := strSQL + '  ' + fSQLQtdVenda + ' AS QTDUNI,                                         ';
        strSQL := strSQL + '  D.DET_NUMLOT AS ITELOT,                                       ';
        strSQL := strSQL + '  N.ITE_REFERE AS REFERE,                                       ';
        strSQL := strSQL + '  N.ITE_CODBAR AS CODBAR,                                       ';
        strSQL := strSQL + ' RLG_PLAVEI AS PLAVEI,                                          ';
        strSQL := strSQL + ' RLG_DESVEI AS DESVEI,                                          ';
        strSQL := strSQL + ' RLG_BOXLOT AS BOXLOT,                                          ';
        strSQL := strSQL + fSQLPesoVenda('D.DET_TOTPES') + ' AS TOTPES,                     ';
        strSQL := strSQL + ' R.ITE_LOCFIS AS LOCFIS,                                        ';
        strSQL := strSQL + ' R.ITE_LOCSUP AS LOCSUP,                                        ';
        strSQL := strSQL + ' MA.MAR_DESMAR AS DESMAR,                                       ';
        strSQL := strSQL + ' ROUND(IF('+fSQLQtdVenda+' > 0, IF(N.ITE_MLTVEN > 0, '+fSQLQtdVenda+'/N.ITE_MLTVEN, 0), 0),2) AS CALCVO ';

        strSQL := strSQL + ' FROM ROMLGE A                                                  ';
        strSQL := strSQL + ' INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM             ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM        ';

        strSQL := strSQL + ' LEFT  JOIN MOVGER C ON C.GER_NUMDOC = B.RLD_NUMDOC AND         ';
        strSQL := strSQL + '                        C.GER_ESPDOC = B.RLD_ESPDOC AND         ';
        strSQL := strSQL + '                        C.GER_CODEMP = B.RLD_CODEMP AND         ';
        strSQL := strSQL + '                        C.GER_SERIE_ = B.RLD_SERIE_             ';
        strSQL := strSQL + ' INNER JOIN MOVDET D ON D.DET_SEQGER = C.AUTOINCREM             ';

        If fCfgSis('ROMLPA', VarBoolean) Then
          strSQL := strSQL + '  AND D.AUTOINCREM = RI.RLI_SEQDET                            ';

        strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM             ';
        strSQL := strSQL + ' LEFT  JOIN CADUNI F ON F.UNI_CODUNI = D.DET_UNIDAD             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE G ON G.OPE_CODOPE = D.DET_CODREP             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE H ON H.OPE_CODOPE = D.DET_CODVEN             ';
        strSQL := strSQL + ' LEFT  JOIN CADOPE I ON I.OPE_CODOPE = D.DET_CODVE2             ';
        strSQL := strSQL + ' LEFT  JOIN CADMOT J ON J.MOT_CODMOT = A.RLG_CODMOT             ';
        strSQL := strSQL + ' LEFT  JOIN CADTRA L ON L.TRA_CODTRA = A.RLG_CODTRA             ';
        strSQL := strSQL + ' LEFT  JOIN CADCID M ON M.CID_CODCID = C.GER_CIDCON             ';
        strSQL := strSQL + ' INNER JOIN CADITE N ON N.ITE_CODITE = D.DET_CODITE             ';
        strSQL := strSQL + ' LEFT  JOIN CADUNI O ON O.UNI_CODUNI = N.ITE_UNICOM             ';
        strSQL := strSQL + ' LEFT  JOIN CADMAR MA ON N.ITE_CODMAR = MA.MAR_CODMAR           ';

        strSQL := strSQL + ' LEFT JOIN ITEGER R ON R.ITE_CODITE = D.DET_CODITE              ';
        strSQL := strSQL + '                   AND R.ITE_CODEMP = D.DET_CODEMP              ';

        strSQL := strSQL + ' WHERE RLG_NUMLOT = :NUMLOT                                     ';
        strSQL := strSQL + '   AND RLG_CODEMP = :CODEMP ) TMP                               ';
        strSQL := strSQL + 'GROUP BY                                                        ';
        strSQL := strSQL + '  NUMLOT,                                                       ';
        strSQL := strSQL + '  DTACAD,                                                       ';
        strSQL := strSQL + '  DESLOT,                                                       ';
        strSQL := strSQL + '  NOMMOT,                                                       ';
        strSQL := strSQL + '  NOMTRA,                                                       ';
        strSQL := strSQL + '  CODITE,                                                       ';
        strSQL := strSQL + '  DESCRI,                                                       ';
        strSQL := strSQL + '  EMBALA,                                                       ';
        strSQL := strSQL + '  UNDCOP,                                                       ';
        strSQL := strSQL + '  UNDVEN                                                        ';
        strSQL := strSQL + 'ORDER BY DESCRI                                                 ';

        Try
          qryConferencia := fCriaQuery;
          qryConferenciaVolumes := fCriaQuery;

          With qryConferencia Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NUMLOT').AsString := strNumRom;
            ParamByName('CODEMP').AsString := strCodEmp;
            Open;
          End;

          If qryConferencia.IsEmpty Then
          Begin
            pMensagemOk('Lote de Separação para Romaneios com pedidos já faturados.'+ sLineBreak +
                        'Favor acessar a rotina de Lote de Separação para Romaneio - Manutenção');
          End
          Else
          Begin
            strSQL := '';
            strSQL := strSQL + 'SELECT                                                           ';
            strSQL := strSQL + ' UNDCOP,                                                         ';
            strSQL := strSQL + ' SUM(QTDEMB) AS QTDEMB,                                          ';
            strSQL := strSQL + ' SUM(TOTPES) AS TOTPES,                                          ';
            strSQL := strSQL + ' CONCAT( TRUNCATE( SUM(QTDEMB), 0), "/",                         ';
            strSQL := strSQL + '         TRUNCATE( MOD( SUM(QTDEMB) , 1) * EMBALA,0)) AS QTDEMB  ';
            strSQL := strSQL + 'FROM (                                                           ';
            strSQL := strSQL + ' SELECT                                                          ';
            strSQL := strSQL + '  ITE_EMBALA AS EMBALA,                                          ';
            strSQL := strSQL + '  O.UNI_SIGUNI AS UNDCOP,                                        ';
            strSQL := strSQL + fSQLPesoPedido('FDO_TOTPES')+' AS TOTPES, ';
            strSQL := strSQL + '  ( '+fSQLQtdPedido+' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ) AS QTDEMB   ';
            strSQL := strSQL + ' FROM ROMLGE A                                                   ';
            strSQL := strSQL + ' INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM              ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + '  INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM         ';

            strSQL := strSQL + ' LEFT  JOIN FATGOR C ON C.FGO_NUMDOC = B.RLD_NUMDOC AND          ';
            strSQL := strSQL + '                        C.FGO_ESPDOC = B.RLD_ESPDOC AND          ';
            strSQL := strSQL + '                        C.FGO_CODEMP = B.RLD_CODEMP              ';
            strSQL := strSQL + ' INNER JOIN FATDOR D ON D.FDO_SEQGER = C.AUTOINCREM              ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + '  AND D.AUTOINCREM = RI.RLI_SEQFDO                             ';

            strSQL := strSQL + ' LEFT  JOIN CADUNI F ON F.UNI_CODUNI = D.FDO_UNIDAD              ';
            strSQL := strSQL + ' INNER JOIN CADITE N ON N.ITE_CODITE = D.FDO_CODITE              ';
            strSQL := strSQL + ' LEFT  JOIN CADUNI O ON O.UNI_CODUNI = N.ITE_UNICOM              ';
            strSQL := strSQL + ' WHERE RLG_NUMLOT = :NUMLOT                                      ';
            strSQL := strSQL + '   AND RLG_CODEMP = :CODEMP                                      ';
            strSQL := strSQL + '   AND FDO_JAFATU = 0                                            ';

            strSQL := strSQL + 'UNION ALL                                                        ';

            strSQL := strSQL + ' SELECT                                                          ';
            strSQL := strSQL + '  ITE_EMBALA AS EMBALA,                                          ';
            strSQL := strSQL + '  O.UNI_SIGUNI AS UNDCOP,                                        ';
            strSQL := strSQL + fSQLPesoVenda('DET_TOTPES') + ' AS TOTPES,                        ';
            strSQL := strSQL + '  ( ' + fSQLQtdVenda + ' / IF(ITE_EMBALA > 0, ITE_EMBALA, 1) ) AS QTDEMB   ';
            strSQL := strSQL + ' FROM ROMLGE A                                                   ';
            strSQL := strSQL + ' INNER JOIN ROMLDE B ON B.RLD_SEQRLG = A.AUTOINCREM              ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + '  INNER JOIN ROMLIT RI ON RI.RLI_SEQRLD = B.AUTOINCREM         ';

            strSQL := strSQL + ' LEFT  JOIN MOVGER C ON C.GER_NUMDOC = B.RLD_NUMDOC AND          ';
            strSQL := strSQL + '                        C.GER_ESPDOC = B.RLD_ESPDOC AND          ';
            strSQL := strSQL + '                        C.GER_CODEMP = B.RLD_CODEMP AND          ';
            strSQL := strSQL + '                        C.GER_SERIE_ = B.RLD_SERIE_              ';
            strSQL := strSQL + ' INNER JOIN MOVDET D ON D.DET_SEQGER = C.AUTOINCREM              ';

            If fCfgSis('ROMLPA', VarBoolean) Then
              strSQL := strSQL + '  AND D.AUTOINCREM = RI.RLI_SEQDET                             ';

            strSQL := strSQL + ' LEFT  JOIN CADUNI F ON F.UNI_CODUNI = D.DET_UNIDAD              ';
            strSQL := strSQL + ' INNER JOIN CADITE N ON N.ITE_CODITE = D.DET_CODITE              ';
            strSQL := strSQL + ' LEFT  JOIN CADUNI O ON O.UNI_CODUNI = N.ITE_UNICOM              ';
            strSQL := strSQL + ' WHERE RLG_NUMLOT = :NUMLOT                                      ';
            strSQL := strSQL + '   AND RLG_CODEMP = :CODEMP ) TMP                                ';
            strSQL := strSQL + 'GROUP BY                                                         ';
            strSQL := strSQL + '  UNDCOP                                                         ';
            strSQL := strSQL + 'ORDER BY UNDCOP                                                  ';

            With qryConferenciaVolumes Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('NUMLOT').AsString := strNumRom;
              ParamByName('CODEMP').AsString := strCodEmp;
              Open;
            End;

            dtsConferencia.DataSet := qryConferencia;
            dtsConferenciaVolumes.DataSet := qryConferenciaVolumes;
            frxDBConferencia.Initialize;
            frxDBConferenciaVolumes.Initialize;

            strRelatorio := fCfgSis('PATETI') + '\Romaneio_Lote_Separacao.fr3';

            if FileExists(strRelatorio) then
            begin
              frxReportConferencia.LoadFromFile(strRelatorio);
            end;

            pPreviewReport('frmQckRomLoteSeparacao', 'Romaneio Lote Separação (Conferência)', frxReportConferencia);
          End;
        Finally
          FreeAndNil(qryConferencia);
          FreeAndNil(qryConferenciaVolumes);
        End;
      End;
    End;

  Finally
    FreeAndNil(frmQckRomLoteSeparacao);
  End;

end;

end.
