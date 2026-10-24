unit untDocOrdemServicoImagem;

interface

uses Classes, StrUtils, SysUtils, frxClass, frxDBSet, UniClientDataSet, Controls,
  untTypesSistema, untLeDocumento, untFuncoesSimples, untZClient, Uni,
  System.Variants;

Type

  TLeDocumentoOrdemServicoImagem = Class(TLeDocumento)
  Private
    cdsMovGag,
    cdsSqlImg: TZClient;

    function fGetSQLGer: String;
    function fGetSQLImg: String;

    Function fInsereClientGer: Boolean;
    Function fInsereClientImg: Boolean;

    procedure pMontaAcessorios;

  Public
    Const
      SELECT_STATUS = '  IF(EQUGER.EQU_STATUS = "E", CONCAT("EM ABERTO", IF(EQUGER.EQU_SUBSTA = "P"," (AGUARD.PEÇAS)","") ) , ' +
                      '  IF(EQUGER.EQU_STATUS = "F", "ORCAMENTO REALIZADO", '   +
                      '  IF(EQUGER.EQU_STATUS = "N", "REPROVADA", ' +
                      '  IF(EQUGER.EQU_STATUS = "A", "APROVADA", '  +
                      '  IF(EQUGER.EQU_STATUS = "M", "EM MANUTENÇÃO", '  +
                      '  IF(EQUGER.EQU_STATUS = "R", CONCAT("REALIZADA", IF(EQUGER.EQU_SUBSTA = "A"," (ARMAZENADA)", " (DEVOLVIDA AO CLIENTE)")), "")))))) ';

      SELECT_SUBSTA = '  CASE '  +
                      '    WHEN (EQUGER.EQU_STATUS = "E") AND (EQUGER.EQU_SUBSTA = "O") THEN "ORÇAMENTO" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "E") AND (EQUGER.EQU_SUBSTA = "P") THEN "AGUARDANDO PEÇAS" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "E") AND (EQUGER.EQU_SUBSTA = "C") THEN "AGUARDANDO CLIENTE" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "N") AND (EQUGER.EQU_SUBSTA = "C") THEN "DEVOLVIDA AO CLIENTE" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "N") AND (EQUGER.EQU_SUBSTA = "A") THEN "ARMAZENADA" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "M") AND (EQUGER.EQU_SUBSTA = "C") THEN "COMPLETA" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "M") AND (EQUGER.EQU_SUBSTA = "A") THEN "AGUARDANDO ITENS" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "A") AND (EQUGER.EQU_SUBSTA = "C") THEN "APROVADA CLIENTE" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "A") AND (EQUGER.EQU_SUBSTA = "G") THEN "APROVADA GARANTIA" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "A") AND (EQUGER.EQU_SUBSTA = "B") THEN "APROVADA CORTESIA" '  +
                      '    WHEN (EQUGER.EQU_STATUS = "A") AND (EQUGER.EQU_SUBSTA = "N") THEN (SELECT MRE_DESCRI FROM CADMRE WHERE MRE_CODIGO = EQUGER.EQU_CODMRE) '  +

                      '    WHEN (EQUGER.EQU_STATUS = "R") AND ' +
                      '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
                      '           FROM FATDOR F ' +
                      '           WHERE (FDO_JAFATU = 1) '+
                      '             AND (FDO_NUMDOC = EQUGER.EQU_NUMPED) ' +
                      '             AND (FDO_ESPDOC = EQUGER.EQU_TIPPED) ' +
                      '             AND (FDO_CODEMP = EQUGER.EQU_EMPPED)) = 0) THEN "NÃO FATURADAS" ' +

                      '    WHEN (EQUGER.EQU_STATUS = "R") AND '  +
                      '         ((SELECT DISTINCT FGO_JAFATU '  +
                      '           FROM FATGOR F ' +
                      '           WHERE (FGO_NUMDOC = EQUGER.EQU_NUMPED) '  +
                      '             AND (FGO_ESPDOC = EQUGER.EQU_TIPPED) '  +
                      '             AND (FGO_CODEMP = EQUGER.EQU_EMPPED)) = 1) THEN "FATURADAS" '  +

                      '    WHEN (EQUGER.EQU_STATUS = "R") AND ' +
                      '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
                      '           FROM FATDOR F ' +
                      '           WHERE (FDO_NUMDOC = EQUGER.EQU_NUMPED) ' +
                      '             AND (FDO_ESPDOC = EQUGER.EQU_TIPPED) ' +
                      '             AND (FDO_CODEMP = EQUGER.EQU_EMPPED)) = 2) THEN "PARCIALMENTE FATURADAS" ' +

                      '    ELSE "" '  +
                      '  END ';

      SELECT_SITEQU = '  CASE ' +
                      '    WHEN (EQU_SITEQU = "SA") THEN "OS REALIZADA - ARMAZENADO"            ' +
                      '    WHEN (EQU_SITEQU = "SR") THEN "OS REALIZADA - RETIRADO PELO CLIENTE" ' +
                      '    WHEN (EQU_SITEQU = "NA") THEN "OS REPROVADA - ARMAZENADO"            ' +
                      '    WHEN (EQU_SITEQU = "NR") THEN "OS REPROVADA - RETIRADO PELO CLIENTE" ' +
                      '    ELSE "" ' +
                      '  END ';
    Constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;

  Protected
    Procedure pSetaParametrosCadcli; Override;
  End;

implementation

uses untConstantes, Data.DB, Math;

function TLeDocumentoOrdemServicoImagem.fGetSQLGer: String;
begin
Result := '';
  Result := Result + ' SELECT CADEQU.EQU_DESCRI AS EQUIPA,';
  Result := Result + '        EQUGER.EQU_NUMOSE AS NUMEQU,';
  Result := Result + '        EQUGER.EQU_CODCLI AS CODCLI,';
  Result := Result + '        EQUGER.EQU_CODEMP AS CODEMP,';
  Result := Result + '        EQUGER.EQU_CODVEN AS CODVEN,';
  Result := Result + '        EQUGER.EQU_DESCRI AS OBSERV,';
  Result := Result + '        EQUGER.EQU_DTAENT AS DTAENT,';
  Result := Result + '        EQUGER.EQU_DTAPED AS DTAAPR,';
  Result := Result + '        EQUGER.EQU_HORENT AS HORENT,';
  Result := Result + '        CADMAR.MAR_DESMAR AS MAREQU,';
  Result := Result + '        CADEQU.EQU_VOLTAG AS VOLTAG,';
  Result := Result + '        EQUGER.EQU_NSERIE AS NSERIE,';
  Result := Result + '       (SELECT GROUP_CONCAT(DISTINCT EQU_DESACE SEPARATOR ", ") ';
  Result := Result + '        FROM EQUACE WHERE EQU_SEQGER = EQUGER.AUTOINCREM) AS ACESSO, ';
  Result := Result + '        EQUGER.EQU_NFCOMP AS NFCOMP,';
  Result := Result + '        EQUGER.EQU_DTNFCO AS DTNFCO,';
  Result := Result + '        EQUGER.EQU_REVEND AS REVEND,';
  Result := Result + '        EQUGER.EQU_CONRET AS CONRET,';
  Result := Result + '        EQUGER.EQU_DEIPOR AS DEIPOR,';
  Result := Result + '        EQUGER.EQU_ENTREG AS ENTREG,';
  Result := Result + '        DATE_FORMAT(IFNULL(LOGSTA.LOG_DTALOG, ""), "%d/%m/%Y") AS DTAREA,';
  Result := Result + '        EQUGER.EQU_VLRPRO AS VLRPRO,';
  Result := Result + '        EQUGER.EQU_VLRSER AS VLRSER,';
  Result := Result + '        EQUGER.EQU_VLRCON AS VLRCON,';
  Result := Result + '        EQUGER.EQU_DESESP + IFNULL((SELECT SUM(EQUSER.EQU_DESESP) ';
  Result := Result + '                                    FROM EQUSER ';
  Result := Result + '  					                        WHERE EQUSER.EQU_SEQGER = EQUGER.AUTOINCREM),0) AS DESESP,';
  Result := Result + '        EQUGER.EQU_VALISS AS VALISS,';
  Result := Result + '        "' + fRetornarDefeitosOrdemServico(recDocume.strNumDoc, recDocume.strCodEmp) + '" AS DEFEIT,';
  Result := Result + '        IF(EQUGER.EQU_GARANT = "N", "Não",' +
                              ' IF(EQUGER.EQU_GARANT = "L", "Garantia Loja",' +
                                ' IF(EQUGER.EQU_GARANT = "F", "Garantia Fábrica",' +
                                  ' IF(EQUGER.EQU_GARANT = "R", "Retorno de Garantia", "")))) AS GARANT,';
  Result := Result + '        "' + fCfgSis('MSGORD')  + '" AS MSGORD,';
  Result := Result + '        (SELECT CADOPE.OPE_NOMOPE';
  Result := Result + '           FROM CADOPE';
  Result := Result + '          WHERE CADOPE.OPE_CODOPE = EQUGER.EQU_CODVEN) AS NOMVEN,';
  Result := Result + '        EQU_CODTEC AS CODTEC,';
  Result := Result + '        (SELECT CADOPE.OPE_NOMOPE';
  Result := Result + '           FROM CADOPE';
  Result := Result + '          WHERE CADOPE.OPE_CODOPE = EQUGER.EQU_CODTEC) AS NOMTEC,';
  Result := Result + '        (IFNULL((SELECT SUM(EQUDET.EQU_TOTITE - EQUDET.EQU_DESESP) ';
  Result := Result + '                   FROM EQUDET ';
  Result := Result + '                  WHERE EQUDET.EQU_SEQGER = EQUGER.AUTOINCREM), 0) + IFNULL((SELECT SUM(EQUSER.EQU_VALSER) ';
  Result := Result + '                                                                    		         FROM EQUSER ';
  Result := Result + '  					                                                                       WHERE EQUSER.EQU_SEQGER = EQUGER.AUTOINCREM),0)) AS TOTPRO, ';
  Result := Result + '        EQU_CODCND AS CODCND, ';
  Result := Result + '        CND_DESCRI AS DESCND, ';
  Result := Result + '        EQU_CONPAG AS CONPAG, ';
  Result := Result + '        EQU_CODFPG AS CODFPG, ';
  Result := Result + '        FPG_DESCRI AS DESFPG, ';
  Result := Result + '        IF(IFNULL(EQU_CONPAG, "") = "01000", "S", "N") AS AVISTA, ';
  Result := Result + '        EQU_ENTGER AS ENTGER, ';

  Result := Result + '        EQU_TOTICM AS TOTICM, ';
  Result := Result + '        EQU_TOTIPI AS TOTIPI, ';
  Result := Result + '        EQU_TOTRET AS TOTRET, ';
  Result := Result + '        EQU_ALQRET AS ALQRET, ';
  Result := Result + '        EQU_BASRET AS BASRET, ';

  Result := Result + '        EQU_CIDCON, ';
  Result := Result + '        EQU_ENDCON, ';
  Result := Result + '        EQU_BAICON, ';
  Result := Result + '        EQU_CEPCON, ';
  Result := Result + '        EQU_TELCON, ';
  Result := Result + '        EQU_R_GCON, ';
  Result := Result + '        EQU_CGCCPF, ';
  Result := Result + '        EQU_CGCCON, ';
  Result := Result + '        EQU_IESCON, ';
  Result := Result + '        EQU_NOMCON, ';

  if fCfgSis('ULCFCE', varBoolean) then
    Result := Result + '        (SELECT LEQ_DESCRI FROM CADLEQ WHERE LEQ_CODLOC = EQU_LOCFIS AND LEQ_CODEMP = EQU_CODEMP) AS LCFSOS, '
  else
    Result := Result + '        EQU_LOCFIS AS LCFSOS, ';

  Result := Result + '    ' + SELECT_STATUS + ' AS STATUS, ';
  Result := Result + '    ' + SELECT_SUBSTA + ' AS SUBSTA, ';
  Result := Result + '       (CASE WHEN EQUGER.EQU_AUTDES = "S" THEN "Sim" ELSE "Não" END) AS AUT_OS, ';

  Result := Result + '        EQUGER.EQU_DISSER AS DISSER, ';
  Result := Result + '        EQUGER.EQU_OBSERV AS OBSOSE, ';
  Result := Result + '        GROUP_CONCAT(DATE_FORMAT(EQUOBS.EQU_DTAENT, "%d/%m/%Y"), " ", ';
  Result := Result + '          TIME_FORMAT(EQUOBS.EQU_HORENT, "%T"), " ", ';
  Result := Result + '          EQUOBS.EQU_OBSERV SEPARATOR " | ") AS OBSTEC, ';

  Result := Result + '        "EQUGER"   AS TABELA, ';
  Result := Result + '        EQUGER.EQU_PROTOC AS PROTOC, ';

  {Req.: 102162 - ATENÇÃO, Infelizmente os campos EQU_REAPOR - EQU_RETPOR estão com as informações invertidas!
   Ou seja, o campo EQU_REAPOR = "Quem Retirou", isso devido ao requisito: 62662, Ronaldo ciente!}
  Result := Result + '        EQU_REAPOR AS REAPOR,  ';
  Result := Result + '        CAST("" AS CHAR(1000)) AS ACEDES, ';
  Result := Result + '        EQUGER.EQU_NUMPAT AS NUMPAT,  ';
  Result := Result + '        IF(IFNULL(MER_NUMDOC,"") <> "", CONCAT(MER_NUMDOC, "-", MER_ESPDOC, "-", MER_EMPGER), "") NOTENT, ';
  Result := Result + '    ' + SELECT_SITEQU + ' AS SITEQU, ';
  Result := Result + '        EQUGER.EQU_SITDTR AS DTRETI, ';
  Result := Result + '        EQUGER.EQU_NFREME AS NFREME, ';
  Result := Result + '        EQUGER.EQU_DTNFRE AS DTNFRE, ';
  Result := Result + '        EQUGER.EQU_EMPAPR AS EMPAPR, ';
  Result := Result + '        (SELECT IFNULL(CADEMP.EMP_NOMEMP, "") ';
  Result := Result + '         FROM CADEMP ';
  Result := Result + '         WHERE CADEMP.EMP_CODEMP = EQUGER.EQU_EMPAPR) AS NEMPAP, ';
  Result := Result + '        EQUGER.EQU_DTFIMA AS DTFIMA, ';
  Result := Result + '        CAST(EQUGER.EQU_DIAENT AS CHAR(5)) AS DIAPRE, ';
  Result := Result + '        EQUGER.EQU_DIGRET AS CODDRE, ';
  Result := Result + '        (SELECT CADOPE.OPE_NOMOPE';
  Result := Result + '         FROM CADOPE';
  Result := Result + '         WHERE CADOPE.OPE_CODOPE = EQUGER.EQU_DIGRET) AS NOMDRE, ';
  Result := Result + '        EQUGER.EQU_OBSGER AS OBSGER, ';
  Result := Result + '        EQUGER.EQU_OBSNFS AS OBSNFS, ';
  Result := Result + '        EQUGER.EQU_CODEQU AS CODEQU, ';
  Result := Result + '        EQUGER.EQU_DADFAB AS DADFAB, ';
  Result := Result + '        EQUGER.EQU_CODDIG AS CODDIG, ';
  Result := Result + '        (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = EQUGER.EQU_CODDIG) AS NOMDIG, ';
  Result := Result + '        0.00              AS TOTQTD, ';
  Result := Result + '        0.00              AS TQTDSE, ';
  Result := Result + '        EQUGER.EQU_NOSFAB AS NOSFAB  ';
  Result := Result + ' FROM EQUGER';
  Result := Result + '    LEFT JOIN CADEQU ON CADEQU.EQU_CODIGO = EQUGER.EQU_CODEQU';
  Result := Result + '    LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADEQU.EQU_CODMAR';
  Result := Result + '    LEFT JOIN LOGSTA ON LOGSTA.LOG_NUMOSE = EQUGER.EQU_NUMOSE AND ';
  Result := Result + '        LOGSTA.LOG_CODEMP = EQUGER.EQU_CODEMP AND ';
  Result := Result + '        LOGSTA.LOG_STAATU IN ("FC", "FO") AND ';
  Result := Result + '        LOGSTA.LOG_DTALOG = (SELECT MAX(LS.LOG_DTALOG) FROM LOGSTA LS ';
  Result := Result + '                             WHERE LS.LOG_NUMOSE = EQUGER.EQU_NUMOSE AND ';
  Result := Result + '                                   LS.LOG_CODEMP = EQUGER.EQU_CODEMP AND ';
  Result := Result + '                                   LS.LOG_STAATU IN ("FC", "FO")) ';
  Result := Result + '    LEFT JOIN CADCND ON EQU_CODCND = CND_CODIGO ';
  Result := Result + '    LEFT JOIN CADFPG ON EQU_CODFPG = FPG_CODIGO ';
  Result := Result + '    LEFT JOIN EQUOBS ON EQUGER.AUTOINCREM = EQUOBS.EQU_SEQGER ';
  Result := Result + '    LEFT JOIN MEQMER ON EQUGER.AUTOINCREM = MEQMER.MER_AUTEQU AND MEQMER.MER_TIPOPE = "E" ';
  Result := Result + ' WHERE EQUGER.EQU_NUMOSE = :NUMOSE AND EQUGER.EQU_CODEMP = :CODEMP';
end;

function TLeDocumentoOrdemServicoImagem.fGetSQLImg: String;
begin
  Result := Result + '  SELECT  ';
  Result := Result + '      FROM_BASE64(EQUIMG.EQU_IMGB64) AS IMGEQU ';
  Result := Result + '  FROM EQUIMG ';
  Result := Result + '     LEFT JOIN EQUGER ON EQUGER.AUTOINCREM = EQUIMG.EQU_SEQEQU   ';
  Result := Result + '  WHERE ';
  Result := Result + '     EQUGER.EQU_NUMOSE = :NUMOSE AND EQUGER.EQU_CODEMP = :CODEMP ';
  Result := Result + '  ORDER BY EQUIMG.AUTOINCREM ';
end;

function TLeDocumentoOrdemServicoImagem.fInsereClientGer: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLGer);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMOSE').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Result := fAbreClient(True, 'fInsereClientGer');
  End;
end;

function TLeDocumentoOrdemServicoImagem.fInsereClientImg: Boolean;
begin
  setLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLImg);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.Dataset  := cdsDados;
    frxDados.Name     := 'frxImagem';
    frxDados.UserName := 'frxImagem';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMOSE').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Result := fAbreClient(True, 'fInsereClientImg');
  End;
end;

function TLeDocumentoOrdemServicoImagem.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  inherited;

  Result := True;

  Try
    Result := Result And fInsereClientImg;
    cdsSqlImg := arrClients[0].cdsDados;

    Result := Result And fInsereClientGer;
    cdsMovGag := arrClients[1].cdsDados;

    Result := Result And fInsereClientCliente;

    Result := Result And fInsereClientEmpresa;

    pMontaAcessorios;

    Result := Result And fInsereClientEnderecoEntrega(cdsMovGag.FieldByName('ENTGER').AsString,
                                                  cdsMovGag.FieldByName('TABELA').AsString,
                                                  '');

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then
      pSetaOrdenacao;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

procedure TLeDocumentoOrdemServicoImagem.pMontaAcessorios;
var
  qryAces: TUniQuery;
  strAces: String;
begin
  If cdsMovGag.IsEmpty Then
    Exit;

  Try
    strAces := '';
    qryAces := fCriaQuery(Nil);

    qryAces.SQL.Clear;
    qryAces.SQL.Add(' SELECT DISTINCT     ');
    qryAces.SQL.Add('   EQUACE.EQU_DESACE ');
    qryAces.SQL.Add(' FROM     ');
    qryAces.SQL.Add('   EQUACE ');
    qryAces.SQL.Add(' LEFT JOIN EQUGER ON EQUACE.EQU_SEQGER = EQUGER.AUTOINCREM ');
    qryAces.SQL.Add(' WHERE ');
    qryAces.SQL.Add('   EQUGER.EQU_NUMOSE = :NUMOSE AND ');
    qryAces.SQL.Add('   EQUGER.EQU_CODEMP = :CODEMP ');

    qryAces.ParamByName('NUMOSE').AsString := cdsMovGag.FieldByName('NUMEQU').AsString;
    qryAces.ParamByName('CODEMP').AsString := cdsMovGag.FieldByName('CODEMP').AsString;

    qryAces.Open;

    qryAces.First;
    While Not qryAces.Eof Do
    Begin
      strAces := strAces + ', ' + qryAces.FieldByName('EQU_DESACE').AsString;

      qryAces.Next;
    End;

    if not fEmptyStr(strAces) then
      Delete(strAces, 1, 2);

    cdsMovGag.Edit;
    cdsMovGag.FieldByName('ACEDES').AsString := strAces;
    cdsMovGag.Post;

  Finally
    FreeAndNil(qryAces);
  End;
end;

procedure TLeDocumentoOrdemServicoImagem.pSetaParametrosCadcli;
begin
  inherited;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CIDCON').AsString := cdsMovGag.FieldByName('EQU_CIDCON').AsString;
    ParamByName('ENDCON').AsString := cdsMovGag.FieldByName('EQU_ENDCON').AsString;
    ParamByName('BAICON').AsString := cdsMovGag.FieldByName('EQU_BAICON').AsString;
    ParamByName('CEPCON').AsString := cdsMovGag.FieldByName('EQU_CEPCON').AsString;
    ParamByName('TELCON').AsString := cdsMovGag.FieldByName('EQU_TELCON').AsString;
    ParamByName('R_GCON').AsString := cdsMovGag.FieldByName('EQU_R_GCON').AsString;
    ParamByName('CGCCPF').AsString := cdsMovGag.FieldByName('EQU_CGCCPF').AsString;
    ParamByName('CGCCON').AsString := cdsMovGag.FieldByName('EQU_CGCCON').AsString;
    ParamByName('IESCON').AsString := cdsMovGag.FieldByName('EQU_IESCON').AsString;
    ParamByName('NOMCON').AsString := cdsMovGag.FieldByName('EQU_NOMCON').AsString;
    ParamByName('CODFAZ').AsString := '';
  End;
end;

constructor TLeDocumentoOrdemServicoImagem.Create(Owner: TComponent);
begin
  inherited;
end;

destructor TLeDocumentoOrdemServicoImagem.Destroy;
begin
  {}
  inherited;
end;

end.
