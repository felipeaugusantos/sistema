unit untLeDocumentoReqMaterialConsumo;

interface

Uses Classes, StrUtils, SysUtils, frxClass, frxDBSet, UniClientDataSet, Controls,
  untTypesSistema, untLeDocumento, untFuncoesSimples, untZClient, Uni,
  System.Variants;


Type
  TLeDocumentoReqMaterialConsumo = Class(TLeDocumento)
  Private
    cdsMovRqG,
    cdsMovRqD: TZClient;

    function fGetSQLGer: String;
    function fGetSQLDet: String;
    Function fInsereClientGer: Boolean;
    Function fInsereClientDet: Boolean;
  Public
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;
  End;

implementation

{ TLeDocumentoReqMaterialConsumo }

function TLeDocumentoReqMaterialConsumo.fGetSQLDet: String;
begin
  Result := Result + ' SELECT REQ_CODMCO AS CODMCO,                       ';
  Result := Result + '        MCO_DESCRI AS DESCRI,                       ';
  Result := Result + '        REQ_QTDMCO AS QTDMCO,                       ';
  Result := Result + '        REQ_UNITAR AS UNITAR,                       ';
  Result := Result + '        REQ_TOTMCO AS TOTMCO,                       ';
  Result := Result + '        REQ_NUMREQ AS NUMREQ,                       ';
  Result := Result + '      D.REQ_CODEMP AS CODEMP,                       ';

  With recDocume Do
    Result := Result + fSQLBarDoc('', strNumDoc, strEspDoc, strCodEMp) + ' AS BARDOC ';

  Result := Result + ' FROM MOVRQD D                                      ';
  Result := Result + '   INNER JOIN MOVRQG G ON G.AUTOINCREM = REQ_SEQGER ';
  Result := Result + '   LEFT JOIN CADMCO ON MCO_CODMCO = REQ_CODMCO      ';
  Result := Result + ' WHERE G.REQ_NUMREQ = :NUMREQ                       ';
  Result := Result + '   AND G.REQ_CODEMP = :CODEMP                       ';
end;

function TLeDocumentoReqMaterialConsumo.fGetSQLGer: String;
begin
  Result := Result + ' SELECT REQ_NUMREQ AS NUMREQ,                  ';
  Result := Result + '        REQ_CODEMP AS CODEMP,                  ';
  Result := Result + '        REQ_DTAENT AS DTAENT,                  ';
  Result := Result + '        REQ_CODDIG AS CODDIG,                  ';
  Result := Result + '        OPE_NOMOPE AS NOMDIG,                  ';
  Result := Result + '        REQ_CODENT AS CODENT,                  ';
  Result := Result + '        MOT_NOMMOT AS NOMENT,                  ';
  Result := Result + '        REQ_MEN001 AS MEN001,                  ';
  Result := Result + '        REQ_MEN002 AS MEN002,                  ';
  Result := Result + '        (SELECT SUM(REQ_TOTMCO)                ';
  Result := Result + '         FROM MOVRQD                           ';
  Result := Result + '         WHERE REQ_SEQGER = MOVRQG.AUTOINCREM) AS TOTGER ';
  Result := Result + ' FROM MOVRQG                                   ';
  Result := Result + '   LEFT JOIN CADOPE ON OPE_CODOPE = REQ_CODDIG ';
  Result := Result + '   LEFT JOIN CADMOT ON MOT_CODMOT = REQ_CODENT ';
  Result := Result + ' WHERE REQ_NUMREQ = :NUMREQ                    ';
  Result := Result + '   AND REQ_CODEMP = :CODEMP                    ';
end;

function TLeDocumentoReqMaterialConsumo.fInsereClientDet: Boolean;
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
    ParamByName('NUMREQ').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Result := fAbreClient(True, 'fInsereClientDet');
  End;

end;

function TLeDocumentoReqMaterialConsumo.fInsereClientGer: Boolean;
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
    ParamByName('NUMREQ').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Result := fAbreClient(True, 'fInsereClientGer');
  End;

end;

function TLeDocumentoReqMaterialConsumo.fMontaClients(cdsDadosExternosMovGer, cdsDadosExternosMovDet: TZClient): Boolean;
begin
 Result := True;
  Try
    Result := Result And fInsereClientDet;
    cdsMovRqD:= arrClients[0].cdsDados;

    Result := Result And fInsereClientGer;
    cdsMovRqG := arrClients[1].cdsDados;

    Result := Result And fInsereClientFornecedor;
    Result := Result And fInsereClientEmpresa;
    Result := Result And fPreparaImpressaoDocumentos;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

end.
