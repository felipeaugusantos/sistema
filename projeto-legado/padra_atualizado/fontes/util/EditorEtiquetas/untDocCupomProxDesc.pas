unit untDocCupomProxDesc;

interface

uses StrUtils, SysUtils, System.Classes, untLeDocumento, untZClient, frxClass,
  frxDBSet, untFuncoesSimples, untFuncoesEditorFast, DB;

type
  TLeDocCupomProxDesc = class(TLeDocumento)
    private
      regClient: TRegClient;
      function fSQlMovCup : String;
      function fInsereClientCabecalho: Boolean;
    public
      function fMontaClients(cdsDadosExternosMovGer,
        cdsDadosExternosMovDet: TZClient): Boolean; override;
  end;
implementation

{ TLeDocCupomProxDesc }

function TLeDocCupomProxDesc.fInsereClientCabecalho: Boolean;
begin

  regClient.cdsDados          := TZClient.Create(Nil, fSQlMovCup);
  regClient.frxDados          := TfrxDBDataset.Create(Nil);
  regClient.frxDados.DataSet  := regClient.cdsDados;
  regClient.frxDados.Name     := 'frxMovger';
  regClient.frxDados.UserName := 'frxMovger';

  regClient.cdsDados.qryQuery.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
  regClient.cdsDados.qryQuery.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
  regClient.cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
  regClient.cdsDados.qryQuery.ParamByName('CODCLI').AsString := recDocume.strCodCli;

  If Not recDocume.blnReimpr Then
    regClient.cdsDados.qryQuery.ParamByName('CODCUP').AsString := recDocume.strNumCup;

  Result := regClient.cdsDados.fAbreClient(True, 'fInsereClientCabecalho');

end;

function TLeDocCupomProxDesc.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Try
    Result := True;
    SetLength(arrClients, Succ(Length(arrClients)));

    Result := Result And fInsereClientCabecalho;

    If Not Result Then
      Exit;

    arrClients[High(arrClients)] := regClient;

    Result := Result And fPreparaImpressaoDocumentos;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocCupomProxDesc.fSQlMovCup: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + ' CONCAT(MCU_NUMDOC, "-", MCU_ESPDOC) AS DOCUME,                ';
  Result := Result + ' CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,                ';
  Result := Result + ' MCU_NUMCUP AS NUMCUP,                                         ';
  Result := Result + ' MCU_CODEMP AS CODEMP,                                         ';
  Result := Result + ' MCU_TOTCUP AS TOTCUP,                                         ';
  Result := Result + ' MCU_DTAVAL AS DTAVAL,                                         ';
  Result := Result + ' MCU_RESCAL AS RESCAL,                                         ';
  Result := Result + ' CONCAT(CADCID.CID_NOMCID,"-",CADCID.CID_ESTADO) AS CIDCLI     ';
  Result := Result + ' FROM                                                          ';
  Result := Result + ' MOVCUP                                                        ';
  Result := Result + ' JOIN CADCLI ON CADCLI.CLI_CODCLI = MOVCUP.MCU_CODCLI          ';
  Result := Result + ' LEFT JOIN CADCID ON CADCID.CID_CODCID = CADCLI.CLI_CODCID     ';
  Result := Result + ' WHERE MCU_NUMDOC = :NUMDOC                                    ';
  Result := Result + '   AND MCU_ESPDOC = :ESPDOC                                    ';
  Result := Result + '   AND MCU_CODCLI = :CODCLI                                    ';
  Result := Result + '   AND MCU_CODEMP = :CODEMP                                    ';

  If Not recDocume.blnReimpr Then
    Result := Result + '   AND MCU_CODCUP = :CODCUP                                   ';
end;

end.
