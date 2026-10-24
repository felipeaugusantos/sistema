unit untDocCupomPromo;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untIFuncoes, untTypesSistema, untFuncoesSimples,
  untZClient;

type

  TLeDocumentoCupomPromo = Class(TLeDocumento)
    private
      cdsCupPro: TZClient;
      Function fSQLCupPro: String;
      Function fInsereClientCupPro: Boolean;
    public
      Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
  End;

implementation

uses DB;

{ TLeDocumentoCupomPromo }


function TLeDocumentoCupomPromo.fInsereClientCupPro: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLCupPro);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet  := arrClients[High(arrClients)].cdsDados.fGetDataset;
  arrClients[High(arrClients)].frxDados.Name     := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;

  if (not fEmptyStr(recDocume.strCodPro)) then
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODPRO').AsString := recDocume.strCodPro;

  if (not fEmptyStr(recDocume.strNumCup)) then
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('SEQUEN').AsString := recDocume.strNumCup;

  if (not fEmptyStr(recDocume.strAutInc)) then
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('AUTINC').AsString := recDocume.strAutInc;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientCupPro');
end;

function TLeDocumentoCupomPromo.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Try
    Result := True;

    Result    := Result And fInsereClientCupPro;
    cdsCupPro := arrClients[0].cdsDados;

    If Not Result Then
      Exit;

    pInsereVendedorCupomPromocao(cdsCupPro, recDocume.strCodEmp, recDocume.strNumDoc, recDocume.strEspDoc);

    Result := Result And fPreparaImpressaoDocumentos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocumentoCupomPromo.fSQLCupPro: String;
var
  strSQL: String;
begin
  strSQL := '';

  strSQL := strSQL + 'SET @CONTADOR := 0; ';
  strSQL := strSQL + 'SELECT                                                                    ';
  strSQL := strSQL + '  G.CPG_DTAENT AS DTAENT,                                                 ';
  strSQL := strSQL + '  G.CPG_HORENT AS HORENT,                                                 ';
  strSQL := strSQL + '  G.CPG_SEQUEN AS SEQCUP,                                                 ';
  strSQL := strSQL + '  G.CPG_NUMDOC AS NUMDOC,                                                 ';
  strSQL := strSQL + '  G.CPG_ESPDOC AS ESPDOC,                                                 ';
  strSQL := strSQL + '  G.CPG_CODEMP AS CODEMP,                                                 ';
  strSQL := strSQL + '  G.CPG_VALDOC AS VALDOC,                                                 ';
  strSQL := strSQL + '  G.CPG_CODCLI AS CODCLI,                                                 ';
  strSQL := strSQL + '  G.CPG_CLICPF AS CLICPF,                                                 ';
  strSQL := strSQL + '                                                                          ';
  strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI,                                                 ';
  strSQL := strSQL + '  C.CLI_ENDERE AS ENDERE,                                                 ';
  strSQL := strSQL + '  C.CLI_ENDNUM AS ENDNUM,                                                 ';
  strSQL := strSQL + '  C.CLI_BAIRRO AS BAIRRO,                                                 ';
  strSQL := strSQL + '  C.CLI_C_E_P_ AS C_E_P_,                                                 ';
  strSQL := strSQL + '  C.CLI_FONE01 AS FONE01,                                                 ';
  strSQL := strSQL + '  C.CLI_CELULA AS CELULA,                                                 ';
  strSQL := strSQL + '  C.CLI_C_G_C_ AS C_G_C_,                                                 ';
  strSQL := strSQL + '  C.CLI_I_E_S_ AS I_E_S_,                                                 ';
  strSQL := strSQL + '                                                                          ';
  strSQL := strSQL + '  G.CPG_CODCPP AS CODCPP,                                                 ';
  strSQL := strSQL + '  G.CPG_EMPCPP AS EMPCPP,                                                 ';
  strSQL := strSQL + '  G.CPG_VALUTI AS VALUTI,                                                 ';
  strSQL := strSQL + '  G.CPG_VALACM AS VALACM,                                                 ';
  strSQL := strSQL + '  G.CPG_CODLAY AS CODLAY,                                                 ';
  strSQL := strSQL + '  G.CPG_SEQPRO AS SEQPRO,                                                 ';
  strSQL := strSQL + '                                                                          ';
  strSQL := strSQL + '  CURRENT_DATE AS DTAIMP,                                                 ';
  strSQL := strSQL + '  CURRENT_TIME AS HRAIMP,                                                 ';
  strSQL := strSQL + '  CP.CPP_DESCPP AS NOMPRO,                                                ';
  strSQL := strSQL + '  M.GER_CODVEN AS CODVEN,                                                 ';
  strSQL := strSQL + '  V.OPE_NOMOPE AS NOMVEN,                                                 ';
  strSQL := strSQL + '  CD.CID_NOMCID AS NOMCID,                                                ';
  strSQL := strSQL + '  CD.CID_ESTADO AS ESTCLI,                                                ';
  strSQL := strSQL + '  @CONTADOR := @CONTADOR + 1 AS NROCUP,                                   ';
  strSQL := strSQL + '  0 AS TOTCUP                                                             ';
  strSQL := strSQL + '                                                                          ';
  strSQL := strSQL + 'FROM                                                                      ';
  strSQL := strSQL + '  CPPGER G                                                                ';
  strSQL := strSQL + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = IFNULL(G.CPG_CLICPF, G.CPG_CODCLI) ';
  strSQL := strSQL + '  LEFT JOIN CADCPP CP  ON CP.CPP_CODCPP = G.CPG_CODCPP                    ';
  strSQL := strSQL + '  LEFT JOIN CADCID CD  ON CD.CID_CODCID = C.CLI_CODCID                    ';
  strSQL := strSQL + '  LEFT JOIN MOVGER M   ON G.CPG_NUMDOC = M.GER_NUMDOC                     ';
  strSQL := strSQL + '                      AND G.CPG_ESPDOC = M.GER_ESPDOC                     ';
  strSQL := strSQL + '                      AND G.CPG_CODEMP = M.GER_CODEMP                     ';
  strSQL := strSQL + '  LEFT JOIN CADOPE V   ON M.GER_CODVEN = V.OPE_CODOPE                     ';
  strSQL := strSQL + 'WHERE CPG_NUMDOC = :NUMDOC                                                ';
  strSQL := strSQL + '  AND CPG_ESPDOC = :ESPDOC                                                ';
  strSQL := strSQL + '  AND CPG_CODEMP = :CODEMP                                                ';

  if (not fEmptyStr(recDocume.strCodPro)) then
    strSQL := strSQL + '  AND CPG_CODCPP = :CODPRO                                              ';

  if (not fEmptyStr(recDocume.strNumCup)) then
    strSQL := strSQL + '  AND CPG_SEQUEN = :SEQUEN                                              ';

  if (not fEmptyStr(recDocume.strAutInc)) then
    strSQL := strSQL + '  AND G.AUTOINCREM = :AUTINC                                            ';

  strSQL := strSQL + '  AND EXISTS                                                              ';
  strSQL := strSQL + '  (SELECT                                                                 ';
  strSQL := strSQL + '    CPP_CODCPP                                                            ';
  strSQL := strSQL + '  FROM                                                                    ';
  strSQL := strSQL + '    CADCPP                                                                ';
  strSQL := strSQL + '    INNER JOIN CPPEMP                                                     ';
  strSQL := strSQL + '      ON CPP_SEQCPP = CADCPP.AUTOINCREM                                   ';
  strSQL := strSQL + '  WHERE CPP_CODCPP = CPG_CODCPP                                           ';
  strSQL := strSQL + '    AND (                                                                 ';
  strSQL := strSQL + '      CURRENT_DATE() BETWEEN CPP_DTAINI                                   ';
  strSQL := strSQL + '      AND CPP_DTAFIN                                                      ';
  strSQL := strSQL + '    )                                                                     ';
  strSQL := strSQL + '    AND CPP_STATUS = "A")                                                 ';

  if (recDocume.intQtdIte > 0) then
    strSQL := strSQL + ' LIMIT ' + recDocume.intQtdIte.ToString();

  Result := strSQL;

end;

end.
