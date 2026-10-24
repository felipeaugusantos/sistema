unit untDocInspEntSai;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient, untFuncoesEditorFast;

Type

  TLeDocumentoINSES = Class(TLeDocumento)
  Private

    cdsInspEnt,
    cdsInspSai: TZClient;

    Function fSQLInspEnt: String;
    Function fSQLInspSai: String;

    Function fInsereClientEnt: Boolean;
    Function fInsereClientSai: Boolean;

  Public
    Function fMontaClients(cdsDadosExternosEnt: TZClient = nil; cdsDadosExternosSai: TZClient = nil): Boolean; override;

  protected

  End;

implementation

uses DB, untTypesSistema;

Function TLeDocumentoINSES.fSQLInspEnt: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT INS.AUTOINCREM, ';
  strSQL := strSQL + '     INS.EQL_NROCON AS NROCON,  ';
  strSQL := strSQL + '     INS.EQL_CODCLI AS CODCLI,  ';
  strSQL := strSQL + '     CC.CLI_NOMCLI  AS NOMCLI,  ';
  strSQL := strSQL + '     ED.EQD_OPEIPE  AS CODCONF, ';
  strSQL := strSQL + '     COC.OPE_NOMOPE AS CONF,    ';
  strSQL := strSQL + '     ED.EQD_SUPIPE  AS CODSUP,  ';
  strSQL := strSQL + '     COSU.OPE_NOMOPE AS SUP,    ';
  strSQL := strSQL + '     INS.EQL_CODEMP  AS CODEMP,';
  strSQL := strSQL + '     CE.EMP_NOMEMP   AS NOMEMP,';
  strSQL := strSQL + '     ED.EQD_DTAIPE   AS DTAIPE,';
  strSQL := strSQL + '     ED.EQD_HORIPE   AS HORIPE,';
  strSQL := strSQL + '     ED.EQD_SEQEQL   AS SEQEQL,';
  strSQL := strSQL + '     CD.EQL_DESCRI   AS DESCRI,';
  strSQL := strSQL + '     CD.EQL_NSERIE   AS NSERIE,';
  strSQL := strSQL + '     CASE WHEN ED.EQD_HIGIPE = "S" THEN "SIM" ELSE "NÃO" END HIGIPE,';
  strSQL := strSQL + '     CASE WHEN ED.EQD_AVAIPE = "S" THEN "SIM" ELSE "NÃO" END AVAIPE,';
  strSQL := strSQL + '     ED.EQD_OBSIPE   AS OBSIPE,';
  strSQL := strSQL + '     CASE WHEN ED.EQD_COBIPE = "S" THEN "SIM" ELSE "NÃO" END COBIPE,';
  strSQL := strSQL + '     ED.EQD_VALIPE   AS VALIPE,';

  strSQL := strSQL + '     CE.EMP_NOMFAN  AS FAN_EMP,  ';
  strSQL := strSQL + '     CE.EMP_CODCID  AS CCI_EMP,  ';
  strSQL := strSQL + '     CID.CID_NOMCID AS NCI_EMP,  ';
  strSQL := strSQL + '     CID.CID_ESTADO AS SUF_EMP,  ';
  strSQL := strSQL + '     CE.EMP_ENDERE  AS END_EMP,  ';
  strSQL := strSQL + '     CE.EMP_ENDNUM  AS NUM_EMP,  ';
  strSQL := strSQL + '     CE.EMP_BAIRRO  AS BAI_EMP,  ';
  strSQL := strSQL + '     CE.EMP_C_E_P_  AS CEP_EMP,  ';
  strSQL := strSQL + '     CE.EMP_FONE01  AS FO1_EMP,  ';
  strSQL := strSQL + '     CE.EMP_ENDCMP  AS CMP_EMP,  ';
  strSQL := strSQL + '     CE.EMP_F_A_X_  AS FAX_EMP,  ';
  strSQL := strSQL + '     CE.EMP_EMAIL_  AS EMA_EMP,  ';
  strSQL := strSQL + '     CE.EMP_C_G_C_  AS CGC_EMP,  ';
  strSQL := strSQL + '     CE.EMP_I_E_S_  AS IES_EMP,  ';
  strSQL := strSQL + '     (SELECT GROUP_CONCAT(CONCAT(ACE.EQA_CODACL, " - ", CAC.ACL_DESCRI, " - QTDE:. ", ACE.EQA_QTDACL,  CHAR(13)) SEPARATOR "")';
  strSQL := strSQL + '       FROM EQUACL ACE';
  strSQL := strSQL + '       INNER JOIN CADACL CAC  ON CAC.ACL_CODIGO = ACE.EQA_CODACL';
  strSQL := strSQL + '       WHERE ACE.EQA_SEQEQU  = CD.AUTOINCREM) INFACE';
  strSQL := strSQL + '   FROM';
  strSQL := strSQL + '     CONEQL INS';
  strSQL := strSQL + '   INNER JOIN CADCLI CC';
  strSQL := strSQL + '     ON CC.CLI_CODCLI = INS.EQL_CODCLI';
  strSQL := strSQL + '   INNER JOIN CADEMP CE';
  strSQL := strSQL + '     ON CE.EMP_CODEMP = INS.EQL_CODEMP';
  strSQL := strSQL + '   LEFT JOIN EQLDET ED';
  strSQL := strSQL + '     ON ED.EQD_SEQCON = INS.AUTOINCREM';
  strSQL := strSQL + '   LEFT JOIN CADOPE COC';
  strSQL := strSQL + '     ON COC.OPE_CODOPE = ED.EQD_OPEIPE';
  strSQL := strSQL + '   LEFT JOIN CADOPE COSU';
  strSQL := strSQL + '     ON COSU.OPE_CODOPE = ED.EQD_SUPIPE';
  strSQL := strSQL + '   INNER JOIN CADEQL CD';
  strSQL := strSQL + '     ON CD.EQL_CODIGO = ED.EQD_SEQEQL';
  strSQL := strSQL + '   LEFT JOIN CADCID CID';
  strSQL := strSQL + '     ON CID.CID_CODCID = CE.EMP_CODCID ';
  strSQL := strSQL + '   WHERE INS.EQL_NROCON = :NROCON';
  strSQL := strSQL + '     AND INS.EQL_CODEMP = :CODEMP';
  strSQL := strSQL + '     AND ED.EQD_DTAIPE  IS NOT NULL';
  if recDocume.strEquipamentos <> '' then
    strSQL := strSQL + '     AND ED.AUTOINCREM IN (' + recDocume.strEquipamentos + ')';
  strSQL := strSQL + '     ORDER BY ED.EQD_SEQEQL';


  Result := strSQL;
End;



Function TLeDocumentoINSES.fSQLInspSai: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT INS.AUTOINCREM, ';
  strSQL := strSQL + '     INS.EQL_NROCON AS NROCON,  ';
  strSQL := strSQL + '     INS.EQL_CODCLI AS CODCLI,  ';
  strSQL := strSQL + '     CC.CLI_NOMCLI  AS NOMCLI,  ';
  strSQL := strSQL + '     ED.EQD_OPEIPS  AS CODCONF, ';
  strSQL := strSQL + '     COC.OPE_NOMOPE AS CONF,    ';
  strSQL := strSQL + '     ED.EQD_SUPIPS  AS CODSUP,  ';
  strSQL := strSQL + '     COSU.OPE_NOMOPE AS SUP,    ';
  strSQL := strSQL + '     INS.EQL_CODEMP  AS CODEMP, ';
  strSQL := strSQL + '     CE.EMP_NOMEMP   AS NOMEMP, ';
  strSQL := strSQL + '     ED.EQD_DTAIPS   AS DTAIPS ,';
  strSQL := strSQL + '     ED.EQD_HORIPS   AS HORIPS, ';
  strSQL := strSQL + '     ED.EQD_SEQEQL   AS SEQEQL, ';
  strSQL := strSQL + '     CD.EQL_DESCRI   AS DESCRI, ';
  strSQL := strSQL + '     CD.EQL_NSERIE   AS NSERIE, ';
  strSQL := strSQL + '     CASE WHEN ED.EQD_CNDIPS = "S" THEN "SIM" ELSE "NÃO" END CNDIPS,';
  strSQL := strSQL + '     ED.EQD_OBSIPS AS OBSIPS,  ';

  strSQL := strSQL + '     CE.EMP_NOMFAN AS FAN_EMP,  ';
  strSQL := strSQL + '     CE.EMP_CODCID AS CCI_EMP,  ';
  strSQL := strSQL + '     CID.CID_NOMCID AS NCI_EMP, ';
  strSQL := strSQL + '     CID.CID_ESTADO AS SUF_EMP, ';
  strSQL := strSQL + '     CE.EMP_ENDERE AS END_EMP,  ';
  strSQL := strSQL + '     CE.EMP_ENDNUM AS NUM_EMP,  ';
  strSQL := strSQL + '     CE.EMP_BAIRRO AS BAI_EMP,  ';
  strSQL := strSQL + '     CE.EMP_C_E_P_ AS CEP_EMP,  ';
  strSQL := strSQL + '     CE.EMP_FONE01 AS FO1_EMP,  ';
  strSQL := strSQL + '     CE.EMP_ENDCMP AS CMP_EMP,  ';
  strSQL := strSQL + '     CE.EMP_F_A_X_ AS FAX_EMP,  ';
  strSQL := strSQL + '     CE.EMP_EMAIL_ AS EMA_EMP,  ';
  strSQL := strSQL + '     CE.EMP_C_G_C_ AS CGC_EMP,  ';
  strSQL := strSQL + '     CE.EMP_I_E_S_ AS IES_EMP,  ';
  strSQL := strSQL + '     (SELECT GROUP_CONCAT(CONCAT(ACE.EQA_CODACL, " - ", CAC.ACL_DESCRI, " - QTDE:. ", ACE.EQA_QTDACL,  CHAR(13)) SEPARATOR "" )';
  strSQL := strSQL + '       FROM EQUACL ACE';
  strSQL := strSQL + '       INNER JOIN CADACL CAC  ON CAC.ACL_CODIGO = ACE.EQA_CODACL';
  strSQL := strSQL + '       WHERE ACE.EQA_SEQEQU  = CD.AUTOINCREM) INFACE';


  strSQL := strSQL + '   FROM';
  strSQL := strSQL + '     CONEQL INS';
  strSQL := strSQL + '   INNER JOIN CADCLI CC';
  strSQL := strSQL + '     ON CC.CLI_CODCLI = INS.EQL_CODCLI';
  strSQL := strSQL + '   INNER JOIN CADEMP CE';
  strSQL := strSQL + '     ON CE.EMP_CODEMP = INS.EQL_CODEMP';
  strSQL := strSQL + '   LEFT JOIN EQLDET ED';
  strSQL := strSQL + '     ON ED.EQD_SEQCON = INS.AUTOINCREM';
  strSQL := strSQL + '   LEFT JOIN CADOPE COC';
  strSQL := strSQL + '     ON COC.OPE_CODOPE = ED.EQD_OPEIPS';
  strSQL := strSQL + '   LEFT JOIN CADOPE COSU';
  strSQL := strSQL + '     ON COSU.OPE_CODOPE = ED.EQD_SUPIPS';
  strSQL := strSQL + '   LEFT JOIN CADEQL CD';
  strSQL := strSQL + '     ON CD.EQL_CODIGO = ED.EQD_SEQEQL';
  strSQL := strSQL + '   LEFT JOIN CADCID CID';
  strSQL := strSQL + '     ON CID.CID_CODCID = CE.EMP_CODCID ';
  strSQL := strSQL + '   WHERE INS.EQL_NROCON = :NROCON';
  strSQL := strSQL + '     AND INS.EQL_CODEMP = :CODEMP';
  strSQL := strSQL + '     AND ED.EQD_DTAIPS  IS NOT NULL';
  if recDocume.strEquipamentos <> '' then
    strSQL := strSQL + '     AND ED.AUTOINCREM IN (' + recDocume.strEquipamentos + ')';
  strSQL := strSQL + '     ORDER BY ED.EQD_SEQEQL';

  Result := strSQL;
End;

Function TLeDocumentoINSES.fInsereClientEnt: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLInspEnt);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxInspEnt';
  arrClients[High(arrClients)].frxDados.UserName := 'frxInspEnt';


  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NROCON').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientEnt');

 (arrClients[High(arrClients)].cdsDados.FieldByName('VALIPE') As TFloatField).DisplayFormat := '#,##0.000';


End;

Function TLeDocumentoINSES.fInsereClientSai: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLInspSai);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxInspSai';
  arrClients[High(arrClients)].frxDados.UserName := 'frxInspSai';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NROCON').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientSai');
end;



Function TLeDocumentoINSES.fMontaClients(cdsDadosExternosEnt: TZClient = nil; cdsDadosExternosSai: TZClient = nil): Boolean;
Begin
  Try
    Result := True;

    if (recDocume.strEspDoc = 'IPE') or (recDocume.blnInspecaoEnt) then
    Begin
      Result    := Result And fInsereClientEnt;
      cdsInspEnt  := arrClients[0].cdsDados;
    End;

    if (recDocume.strEspDoc = 'IPS') or (recDocume.blnInspecaoSai) then
    Begin
      Result    := Result And fInsereClientSai;
      cdsInspSai := arrClients[0].cdsDados;
    End;


    If Not Result Then
      Exit;


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


end.
