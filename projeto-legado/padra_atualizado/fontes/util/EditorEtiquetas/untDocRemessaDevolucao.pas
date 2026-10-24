unit untDocRemessaDevolucao;

interface

uses StrUtils, SysUtils, System.Classes,
     untLeDocumento, untZClient, frxClass, frxDBSet, untFuncoesSimples;

Type

  TLeDocumentoRD = Class(TLeDocumento)
  Private

    cdsRemDev: TZClient;

    Function fSQLRemDev: String;
    Function fInsereClientRemDev: Boolean;

  Public

    constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;

  protected

  End;

implementation

{ TLeDocumentoRD }

constructor TLeDocumentoRD.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
end;

destructor TLeDocumentoRD.Destroy;
begin
  inherited;
end;

function TLeDocumentoRD.fInsereClientRemDev: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLRemDev);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMREM').AsString := strNumRem;
    ParamByName('EMPREM').AsString := VS_strCodEmp;
    Result := fAbreClient(True, 'fInsereClientRemDev');
  End;
end;

function TLeDocumentoRD.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin

  Try
    Result := True;
    SetLength(arrClients, 0);

    Result    := Result And fInsereClientRemDev;

    cdsRemDev := arrClients[0].cdsDados;

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

function TLeDocumentoRD.fSQLRemDev: String;
  Var
    strRemDev: String;
begin
  strRemDev := '';
  strRemDev := strRemDev + 'SELECT SQL_NO_CACHE DISTINCT ';
  strRemDev := strRemDev + '  RD.AUTOINCREM AS AUTINC,   ';
  strRemDev := strRemDev + '  RD.RMV_DTACAD AS DTACAD,   ';
  strRemDev := strRemDev + '  RD.RMV_HORCAD AS HORCAD,   ';
  strRemDev := strRemDev + '  CONCAT(RD.RMV_CODDIG, "-", OP.OPE_NOMOPE) AS NOMDIG, ';
  strRemDev := strRemDev + '  CONCAT(RD.RMV_NUMREM, "-", RD.RMV_ESPREM, "-", RD.RMV_EMPREM) AS NUMREM, ';
  strRemDev := strRemDev + '  CASE ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_DEV" THEN "Remessa de Devolução"                                 ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_TRA" THEN "Remessa de Devolução - Transferência"                 ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_OUF" THEN "Remessa de Devolução - Outras Saídas para Fornecedor" ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_COL" THEN "Remessa de Devolução - Guardar Devolução - Coletor"   ';
  strRemDev := strRemDev + '    ELSE CAST("" AS CHAR(1)) ';
  strRemDev := strRemDev + '  END AS TIPOPE,             ';
  strRemDev := strRemDev + '  CASE ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_DEV" THEN CAST("" AS CHAR(1))                                           ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_TRA" THEN CONCAT(MT.DET_NUMDOC, "-", MT.DET_ESPDOC, "-", MT.DET_CODEMP) ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_OUF" THEN CONCAT(MO.DET_NUMDOC, "-", MO.DET_ESPDOC, "-", MO.DET_CODEMP) ';
  strRemDev := strRemDev + '    WHEN RMV_TIPOPE = "REM_COL" THEN CAST("" AS CHAR(1))                                           ';
  strRemDev := strRemDev + '    ELSE CAST("" AS CHAR(1)) ';
  strRemDev := strRemDev + '  END AS DOCVIN,              ';
  strRemDev := strRemDev + '  CONCAT(RD.RMV_NUMDOC, "-", RD.RMV_ESPDOC, "-", RD.RMV_CODEMP) AS NUMDOC, ';
  strRemDev := strRemDev + '  MD.DET_CODCLI AS CODCLI, ';
  strRemDev := strRemDev + '  CC.CLI_NOMCLI AS NOMCLI, ';
  strRemDev := strRemDev + '  RD.RMV_CODITE AS CODITE, ';
  strRemDev := strRemDev + '  CI.ITE_DESITE AS DESITE, ';
  strRemDev := strRemDev + '  RD.RMV_QTDITE AS QTDITE  ';
  strRemDev := strRemDev + 'FROM                       ';
  strRemDev := strRemDev + '  REMDEV RD                ';
  strRemDev := strRemDev + '  LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = RD.RMV_CODDIG ';
  strRemDev := strRemDev + '  LEFT JOIN MOVDET MT ON MT.AUTOINCREM = RD.RMV_AUTTRA ';
  strRemDev := strRemDev + '  LEFT JOIN CADITE CI ON CI.ITE_CODITE = RD.RMV_CODITE ';

  strRemDev := strRemDev + '    LEFT JOIN MOVDET MD ON MD.AUTOINCREM = RD.RMV_AUTDEV ';
  strRemDev := strRemDev + '  LEFT JOIN MOVDET MO ON MO.AUTOINCREM = RD.RMV_AUTOUF ';
  strRemDev := strRemDev + '  LEFT JOIN CADCLI CC ON CC.CLI_CODCLI = MD.DET_CODCLI ';
  strRemDev := strRemDev + 'WHERE RD.RMV_NUMREM = :NUMREM ';
  strRemDev := strRemDev + '  AND RD.RMV_EMPREM = :EMPREM ';
  Result := strRemDev;
end;

end.
