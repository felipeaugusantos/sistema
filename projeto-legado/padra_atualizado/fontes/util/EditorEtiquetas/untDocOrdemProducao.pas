unit untDocOrdemProducao;

interface

uses Classes, StrUtils, SysUtils, frxClass, frxDBSet, UniClientDataSet, Controls,
  untTypesSistema, untLeDocumento, untFuncoesSimples, untZClient, Uni,
  System.Variants;

Type

  TLeDocumentoOrdemProducao = Class(TLeDocumento)
  private
    //cdsMovPro,
    //cdsMovDet: TZClient;

    function fGetSQLPro: String;
    function fGetSQLDet: String;
    Function fInsereClientPro: Boolean;
    Function fInsereClientDet: Boolean;
  Public

    constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;
  Protected
  End;

implementation

uses untConstantes, Data.DB, Math;

{ TLeDocumentoOrdemProducao }

function TLeDocumentoOrdemProducao.fGetSQLDet: String;
  function fRetSQLDetMat(strCampo: String): String;
  begin
    Result := ' SELECT '+ strCampo +' FROM GERMAT '+
              '   INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM '+
              '   WHERE GMT_CODITE = PRO_CODITE '+
              '     AND DMT_ITESUB = DOP_ITESUB LIMIT 1';
    Result := '('+Result+')';
  end;

begin
  Result := '';
  Result := Result + 'SET @QTDACU := 0.00;                                                                                     ';
  Result := Result + 'SELECT                                                                                                   ';
  Result := Result + '  DMT_ITESUB                                                       AS CODITE,                            ';
  Result := Result + '  (CASE WHEN DMT_DESCRI IS NOT NULL THEN NULL ELSE ITE_REFERE END) AS REFITE,                            ';
  Result := Result + '  IFNULL(DMT_DESCRI, ITE_DESITE)                                   AS DESITE,                            ';
  Result := Result + '  (IFNULL(DOP_QTDITE, 0) * IFNULL(PRO_QTDAPR, 0))                  AS QTDTOT,                            ';
  Result := Result + '  DMT_DESCRI                                                       AS COMENT,                            ';
  Result := Result + '  IFNULL(DMT_ACUMOP, "N")                                          AS ACUMOP,                            ';
  Result := Result + '  IFNULL(DMT_REFERE, ITE_REFERE)                                   AS REFERE,                            ';
  Result := Result + '  IFNULL(LOT_LOCFIS, ITE_LOCFIS)                                   AS LOCFIS,                            ';
  Result := Result + '  IFNULL(DOP_NUMLOT,LOT_NUMLOT)                                    AS NUMLOT,                            ';
  Result := Result + '  IF(IFNULL(ITE_DENSID, 1) <= 0, 1, IFNULL(ITE_DENSID, 1))         AS DENSID,                            ';
  Result := Result + '  DOP_QTDITE                                                       AS QTDFOR,                            ';
  Result := Result + '  UNI_SIGUNI                                                       AS SIGUNI,                            ';
  Result := Result + '  ITE_CODFAB                                                       AS CODFAB,                            ';
  Result := Result + '  MAR_DESMAR                                                       AS DSMARC,                            ';
  Result := Result + '  (CASE WHEN DMT_DESCRI IS NOT NULL THEN NULL ELSE (DOP_QTDITE * PRO_QTDAPR) END) AS QTDITE,             ';
//  Result := Result + '  IFNULL(IFNULL(DMT_DESCRI, NULL), (DOP_QTDITE * PRO_QTDAPR) )           AS QTDITE,                                    ';
  Result := Result + '  IFNULL('+fRetSQLDetMat('DMT_DESPCA')+', "")                      AS DESPCA,                            ';
  Result := Result + '  DOP_METRAG                                                       AS METRAG,                            ';
  Result := Result + '  @QTDACU := @QTDACU + (CASE WHEN DMT_DESCRI IS NOT NULL THEN NULL ELSE (DOP_QTDITE * PRO_QTDAPR) END) AS QTDACU ';
  Result := Result + 'FROM                                                                                                     ';
  Result := Result + '  MOVPRO                                                                                                 ';
  Result := Result + '   INNER JOIN DETPRO ON DOP_SEQGER         = MOVPRO.AUTOINCREM                                           ';
  Result := Result + '   LEFT  JOIN ITEGER ON ITEGER.ITE_CODITE  = DOP_ITESUB AND ITEGER.ITE_CODEMP = :CODEMP                  ';
  Result := Result + '   LEFT  JOIN CADITE ON CADITE.ITE_CODITE  = DOP_ITESUB                                                  ';
  Result := Result + '   LEFT  JOIN CADUNI ON UNI_CODUNI         = ITE_CODUNI                                                  ';
  Result := Result + '   LEFT  JOIN CADLOT ON LOT_CODITE         = DOP_ITESUB AND LOT_CODEMP = :CODEMP AND LOT_PRIPRO = "S"    ';
  Result := Result + '   LEFT  JOIN GERMAT ON GMT_CODITE         = MOVPRO.PRO_CODITE                                           ';
  Result := Result + '   LEFT  JOIN DETMAT ON DMT_SEQGER         = GERMAT.AUTOINCREM AND (( DMT_ITESUB = DOP_ITESUB AND DMT_QTDITE = DOP_QTDITE ) OR (DMT_ITESUB IS NULL )) ';
  Result := Result + '   LEFT  JOIN CADMAR ON MAR_CODMAR         = CADITE.ITE_CODMAR                                           ';

  Result := Result + 'WHERE                                                                                                    ';
  Result := Result + '  PRO_CODPRO = :CODPRO AND                                                                               ';
  Result := Result + '  PRO_CODEMP = :CODEMP                                                                                   ';
  Result := Result + 'GROUP BY DMT_SEQUEN                                                                                      ';
  Result := Result + 'ORDER BY DMT_SEQUEN                                                                                      ';
end;

function TLeDocumentoOrdemProducao.fGetSQLPro: String;
  Const
                 // SE POSSUIR UM PEDIDO VINCULADO NA FATDOR ENTÃO UTILIZA ELE, SENÃO
                 // VERIFICA SE POSSUI UM PEDIDO VINCULAOD DIRETO NA MANUTENÇÃO DA ORDEM
                 // DE PRODUÇÃO E TRAZ ELE
    SQL_ENDENT = ' IF( PRO_ENDENT IS NOT NULL                                          '+
                 '     , CONCAT(  "End. Entrega: "                                     '+
                 '              , E1.ETC_ENDENT                                        '+
                 '              , E1.ETC_BAIENT                                        '+
                 '              , D1.CID_NOMCID                                        '+
                 '              , D1.CID_ESTADO                                        '+
                 '              , IF(  TRIM(E1.ETC_REFENT) = ""                        '+
                 '                   , ""                                              '+
                 '                   , CONCAT(" - Referência: ", E1.ETC_REFENT)))      '+
                 '     , IF(  E2.AUTOINCREM IS NOT NULL                                '+
                 '          , CONCAT(  "End. Entrega: "                                '+
                 '                   , E2.ETC_ENDENT                                   '+
                 '                   , E2.ETC_BAIENT                                   '+
                 '                   , D2.CID_NOMCID                                   '+
                 '                   , D2.CID_ESTADO                                   '+
                 '                   , IF(  TRIM(E2.ETC_REFENT) = ""                   '+
                 '                        , ""                                         '+
                 '                        , CONCAT(" - Referência: ", E2.ETC_REFENT))) '+
                 '          , ""))                                                     ';

    SQL_PEDIDO = ' IF(  F1.AUTOINCREM IS NOT NULL                               '+
                 '    , CONCAT( "PEDIDO Nº "                                    '+
                 '             , F1.FGO_NUMDOC                                  '+
                 '             , "     PREVISAO "                               '+
                 '             , F1.FGO_PREVIS                                  '+
                 '             , IF(  fCfgSis("CFG_PROPRO", :CODEMP) = "S"      '+
                 '                  , CONCAT(" ", F1.FGO_HPREVI)                '+
                 '                  , ""))                                      '+
                 '    , IF(  F2.AUTOINCREM IS NOT NULL                          '+
                 '         , CONCAT( "PEDIDO Nº "                               '+
                 '                  , F2.FGO_NUMDOC                             '+
                 '                  , "     PREVISAO "                          '+
                 '                  , F2.FGO_PREVIS                             '+
                 '                  , IF(  fCfgSis("CFG_PROPRO", :CODEMP) = "S" '+
                 '                       , CONCAT(" ", F2.FGO_HPREVI)           '+
                 '                       , ""))                                 '+
                 '         , ""))                                               ';


    SQL_COMGMT = ' SELECT                                                  '+
                 '   GROUP_CONCAT(DMT_DESCRI SEPARATOR "\n")               '+
                 ' FROM                                                    '+
                 '   GERMAT                                                '+
                 '    INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM  '+
                 ' WHERE                                                   '+
                 '       GMT_CODITE = PRO_CODITE                           '+
                 '   AND DMT_ITESUB IS NULL                                '+
                 ' ORDER BY                                                '+
                 '   DMT_SEQUEN                                            ';


    function fRetSQLObs(blnObsMat : boolean) : String;
      function fRetConcat(strCampo : String) : String;
      begin
        Result := Result + 'IF(  IFNULL(TRIM('+strCampo+'), "") = ""       ';
        Result := Result + '   , ""                                        ';
        Result := Result + '   , IF(  @OBS = ""                            ';
        Result := Result + '        , @OBS := TRIM('+strCampo+')           ';
        Result := Result + '        , CONCAT("\n", TRIM('+strCampo+')))) ';
      end;
    begin
      Result := '';
      Result := Result + 'CONCAT(  @OBS := TRIM(IFNULL(PRO_OBS001,"")) ';
      Result := Result + '       , ' + fRetConcat('PRO_OBS002');
      Result := Result + '       , ' + fRetConcat('IFNULL(F1.FGO_MEN001, F2.FGO_MEN001)');
      Result := Result + '       , ' + fRetConcat('IFNULL(F1.FGO_MEN002, F2.FGO_MEN002)');

      if blnObsMat then
      begin
        Result := Result + '       , ' + fRetConcat('GMT_OBS001');
        Result := Result + '       , ' + fRetConcat('GMT_OBS002');
        Result := Result + '       , ' + fRetConcat('GMT_OBS003');
        Result := Result + '       , ' + fRetConcat('GMT_OBS004');
        Result := Result + '       , ' + fRetConcat('GMT_OBS005');
        Result := Result + '       , ' + fRetConcat('GMT_OBS006');
        Result := Result + '       , ' + fRetConcat('GMT_OBS007');

      end;

      Result := Result + '       , ' + fRetConcat('@DESEND');
      Result := Result + '      )' ;

    end;
begin
  Result := '';
  Result := Result + 'SELECT                                                                                ';
  Result := Result + '  @MP_AUTOINCREM := MOVPRO.AUTOINCREM,                                                ';
  Result := Result + '  @MP_CODEMP := MOVPRO.PRO_CODEMP,                                                    ';
  Result := Result + '  PRO_CODCLI                                            AS CODCLI,                    ';
  Result := Result + '  IFNULL(C1.CLI_NOMCLI, C2.CLI_NOMCLI)                  AS NOMCLI,                    ';
  Result := Result + '  MAR_CODMAR                                            AS CODMAR,                    ';
  Result := Result + '  MAR_DESMAR                                            AS DESMAR,                    ';
  Result := Result + '  PRO_ENDENT                                            AS ENDENT,                    ';
  Result := Result + '  PRO_CODPRO                                            AS CODPRO,                    ';
  Result := Result + '  PRO_CODITE                                            AS CODBAS,                    ';
  Result := Result + '  ITE_DESITE                                            AS DESBAS,                    ';
  Result := Result + '  CAST(ITE_APLICA AS CHAR(200))                         AS APLICA,                    ';

  Result := Result + '  IF(  LOCATE("ITEM ESPECIAL", ITE_DESITE)                                            ';
  Result := Result + '     , FDO_DESCRI                                                                     ';
  Result := Result + '     , ITE_DESITE)                                         AS DESESP,                 ';

  Result := Result + '  CAST(PRO_QTDAPR AS DECIMAL(14,'+fCfgSis('DECQTD')+'))    AS QTDAPR,                 ';
  Result := Result + '  GMT_OBS001                                               AS GMTOB1,                 ';
  Result := Result + '  GMT_OBS002                                               AS GMTOB2,                 ';
  Result := Result + '  GMT_OBS003                                               AS GMTOB3,                 ';
  Result := Result + '  GMT_OBS004                                               AS GMTOB4,                 ';
  Result := Result + '  GMT_OBS005                                               AS GMTOB5,                 ';
  Result := Result + '  GMT_OBS006                                               AS GMTOB6,                 ';
  Result := Result + '  GMT_OBS007                                               AS GMTOB7,                 ';


  Result := Result + '  GRU_DESGRU                                               AS DESGRU,                 ';
  Result := Result + '  PRO_OBS001                                               AS OBS001,                 ';
  Result := Result + '  PRO_OBS002                                               AS OBS002,                 ';
  Result := Result + '  I.ITE_CODFAB                                             AS CODFA2,                 ';
  Result := Result + '  PRO_OBS_PD                                               AS OBS_PD,                 ';
  Result := Result + '  IFNULL(F1.FGO_NUMDOC, F2.FGO_NUMDOC)                     AS NUMDOC,                 ';
  Result := Result + '  IFNULL(PRO_DTAPRO, "")                                   AS PREVIS,                 ';
  Result := Result + '  IFNULL(F1.FGO_HPREVI, F2.FGO_HPREVI)                     AS HPREVI,                 ';
  Result := Result + '  IFNULL(F1.FGO_MEN001, F2.FGO_MEN001)                     AS MEN001,                 ';
  Result := Result + '  IFNULL(F1.FGO_MEN002, F2.FGO_MEN002)                     AS MEN002,                 ';
  Result := Result + '  IFNULL(E1.ETC_ENDENT, E2.ETC_ENDENT)                     AS ENDENT,                 ';
  Result := Result + '  IFNULL(E1.ETC_BAIENT, E2.ETC_BAIENT)                     AS BAIENT,                 ';
  Result := Result + '  IFNULL(D1.CID_NOMCID, D2.CID_NOMCID)                     AS CIDENT,                 ';
  Result := Result + '  IFNULL(D1.CID_ESTADO, D2.CID_ESTADO)                     AS ESTENT,                 ';
  Result := Result + '  IFNULL(   LOT_LOCFIS,    ITE_LOCFIS)                     AS LOCBAS,                 ';
  Result := Result + '  IFNULL(T1.TRA_NOMTRA, T2.TRA_NOMTRA)                     AS NOMTRA,                 ';

  Result := Result + '  IF(FATDOR.FDO_ENTFUT = "S", "F", EXTDOR.FDO_ENTRET)      AS ENTRET,                 ';
  Result := Result + '  IFNULL(F1.FGO_CODEMP, F2.FGO_CODEMP)                     AS EMPORI,                 ';
  Result := Result + '  IFNULL(F1.FGO_CODVEN, F2.FGO_CODVEN)                     AS CODVEN,                 ';
  Result := Result + '  FDO_CODREP                                               AS CODREP,                 ';
  Result := Result + '  IFNULL(PRO_DTACAD, "")                                   AS DTAENT,                 ';
  Result := Result + '  V.OPE_NOMOPE                                             AS NOMVEN,                 ';
  Result := Result + '  R.OPE_NOMOPE                                             AS NOMREP,                 ';

  Result := Result + '  GMT_REFERE                                            AS REFACA,                    ';

  //manter antes das observações, pois a variável @DESEND é utilizada para montar as OBSs
  Result := Result + '  @DESEND := ('+SQL_ENDENT+')                           AS DESEND,                    ';

  Result := Result + '  ('+SQL_PEDIDO+')                                      AS PEDIDO,                    ';
  Result := Result + '  ('+fRetSQLObs(True)+')                                AS OBSMD1,                    ';
  Result := Result + '  ('+fRetSQLObs(False)+')                               AS OBSMD2,                    ';
  Result := Result + '  ('+SQL_COMGMT+')                                      AS COMGMT,                    ';

	Result := Result + '   (SELECT                                                ';
	Result := Result + '      GROUP_CONCAT( DISTINCT                              ';
	Result := Result + '        RPAD(FAS_DESFAS,40," "),                          ';
	Result := Result + '        RPAD(MNT_OPEINI,05," "),                          ';
	Result := Result + '        RPAD(DATE_FORMAT(MNT_DTAINI,"%d/%m/%Y"),12," "),  ';
	Result := Result + '        RPAD(MNT_HRAINI,12," "),                          ';
	Result := Result + '        RPAD(MNT_OPEFIN,05," "),                          ';
	Result := Result + '        RPAD(DATE_FORMAT(MNT_DTAFIN,"%d/%m/%Y"),12," "),  ';
	Result := Result + '        RPAD(MNT_HRAFIN,12," "),                          ';
	Result := Result + '        RPAD(fFormataSecToTime (                          ';
	Result := Result + '          TIMESTAMPDIFF(                                  ';
	Result := Result + '            SECOND,                                       ';
	Result := Result + '            CONCAT(MNT_DTAINI, " ", MNT_HRAINI),          ';
	Result := Result + '            CONCAT(MNT_DTAFIN, " ", MNT_HRAFIN)           ';
	Result := Result + '          )                                               ';
	Result := Result + '      ),12," ") SEPARATOR "\n" )                          ';
	Result := Result + '    FROM                                                  ';
	Result := Result + '      FASMAT                                              ';
	Result := Result + '      INNER JOIN FASGER ON MAT_SEQFAS = FASGER.AUTOINCREM ';
	Result := Result + '       LEFT JOIN MNTORD ON MNT_SEQFAS = FASGER.AUTOINCREM ';
	Result := Result + '                       AND MNT_SEQORD = @MP_AUTOINCREM    ';
	Result := Result + '      INNER JOIN FASORD ON ORD_SEQORD = @MP_AUTOINCREM    ';
	Result := Result + '    WHERE TRUE                                            ';
	Result := Result + '      AND MAT_CODEMP = @MP_CODEMP                         ';
	Result := Result + '    ORDER BY FAS_SEQUEN) AS LSTFAS                        ';

  Result := Result + 'FROM                                                                                  ';
  Result := Result + '  MOVPRO                                                                              ';
  Result := Result + '   LEFT JOIN GERMAT    ON GMT_CODITE = PRO_CODITE                                     ';
  Result := Result + '   LEFT JOIN CADITE I  ON I.ITE_CODITE = PRO_CODITE                                   ';
  Result := Result + '   LEFT JOIN CADGRU    ON GRU_CODGRU = ITE_CODGRU                                     ';
  Result := Result + '   LEFT JOIN FATDOR    ON FDO_ORDPRO = PRO_CODPRO AND FDO_EMPITE = PRO_CODEMP         ';
  Result := Result + '   LEFT JOIN EXTDOR    ON FDO_SEQFDO = FATDOR.AUTOINCREM                              ';
  Result := Result + '   LEFT JOIN FATGOR F1 ON F1.AUTOINCREM = FDO_SEQGER                                  ';
  Result := Result + '   LEFT JOIN CADTRA T1 ON T1.TRA_CODTRA = F1.FGO_CODTRA                               ';
  Result := Result + '   LEFT JOIN ENTCLI E1 ON E1.AUTOINCREM = PRO_ENDENT                                  ';
  Result := Result + '   LEFT JOIN CADCID D1 ON D1.CID_CODCID = E1.ETC_CIDENT                               ';
  Result := Result + '   LEFT JOIN CADCLI C1 ON C1.CLI_CODCLI = PRO_CODCLI                                  ';
  Result := Result + '   LEFT JOIN FATGOR F2 ON (F2.FGO_NUMDOC = PRO_NUMPED AND F2.FGO_ESPDOC = PRO_ESPPED AND F2.FGO_CODEMP = PRO_EMPPED) ';
  Result := Result + '   LEFT JOIN CADTRA T2 ON T2.TRA_CODTRA = F2.FGO_CODTRA                               ';
  Result := Result + '   LEFT JOIN CADCLI C2 ON C2.CLI_CODCLI = F2.FGO_CODCLI                               ';
  Result := Result + '   LEFT JOIN AUXGOR    ON AUX_SEQGER    = F2.AUTOINCREM                               ';
  Result := Result + '   LEFT JOIN ENTCLI E2 ON E2.AUTOINCREM = AUX_ENTGER                                  ';
  Result := Result + '   LEFT JOIN CADCID D2 ON D2.CID_CODCID = E2.ETC_CIDENT                               ';
  Result := Result + '   LEFT JOIN ITEGER G  ON G.ITE_CODITE  = PRO_CODITE AND G.ITE_CODEMP = PRO_CODEMP    ';
  Result := Result + '   LEFT JOIN CADLOT    ON LOT_NUMLOT = PRO_NUMLOT AND LOT_CODEMP = PRO_CODEMP         ';

  Result := Result + '   LEFT JOIN CADOPE V ON V.OPE_CODOPE = IFNULL(F1.FGO_CODVEN, F2.FGO_CODVEN)          ';
  Result := Result + '   LEFT JOIN CADOPE R ON R.OPE_CODOPE = FDO_CODREP                                    ';
  Result := Result + '   LEFT JOIN CADMAR MA ON MA.MAR_CODMAR = I.ITE_CODMAR                                ';

  Result := Result + 'WHERE                                                                                 ';
  Result := Result + '  PRO_CODPRO = :CODPRO AND                                                            ';
  Result := Result + '  PRO_CODEMP = :CODEMP                                                                ';
end;

function TLeDocumentoOrdemProducao.fInsereClientDet: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLDet);

    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODPRO').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Result := fAbreClient(True, 'fInsereClientDet');
  End;

end;

function TLeDocumentoOrdemProducao.fInsereClientPro: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLPro);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CODPRO').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Result := fAbreClient(True, 'fInsereClientPro');
  End;
end;

function TLeDocumentoOrdemProducao.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  inherited;
  Result := True;
  Try
    Result := Result And fInsereClientDet;
    //cdsMovDet := arrClients[0].cdsDados;

    Result := Result And fInsereClientPro;
    //cdsMovPro := arrClients[1].cdsDados;

    Result := Result And fInsereClientEmpresa;

    {Result := Result And fInsereClientEnderecoEntrega(cdsMovPro.FieldByName('ENTGER').AsString,
                                                      cdsMovPro.FieldByName('TABELA').AsString,
                                                      ''); }

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

constructor TLeDocumentoOrdemProducao.Create(Owner: TComponent);
begin
  inherited;
end;

destructor TLeDocumentoOrdemProducao.Destroy;
begin
  {}
  inherited;
end;

end.

