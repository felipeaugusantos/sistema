unit untCoordenadorStatusNFe;

interface

uses
 {$IFDEF LINUX}
  NFe.Utils,
 {$ELSE}
  untUtil, Windows, Dialogs, Forms,
 {$ENDIF}
  SysUtils, Classes,
 {$IF Defined(UNIDAC)}
  Uni, System.Generics.Collections,
 {$ELSE}
  ZConnection, ZDataset,
 {$IFEND}
  Contnrs,
  Math,
  DateUtils,
  StrUtils,
  untRegistrarTarefa;

type
  TStatusDocumentoFiscal = (sdfEmProcessamento, sdfProcessandoTransmitindo, sdfNotasServicoParadas, sdReenvioAutomatico);

  TStatusConexao = (scAtiva, scInativa);

  TNFeProcess = class
  public
    PID: Cardinal;
    ExeName: String;
    ExeParams: String;
    Started: TDateTime;
    Finished: TDateTime;
  end;

  TTentativasAutorizacao = record
    NumeroTentativas: Integer;
    UltimaTentativa: TDateTime;
    UltimoRetorno: string;
  end;

  TCoordenadorStatusNFe = class
  private
    FTamLote: Integer;
    FPonImp: String;
    FTarefa: TRegistrarTarefa;
   {$IF Defined(UNIDAC)}
    FTentativas: TDictionary<string,TTentativasAutorizacao>;
   {$IFEND}
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    function fSQLMsgsErroLibNfe(const aAliasLogNfe: String=''): String;
    function fAguardarParaNovaTentativa(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
    function fVerificarConexaoIntegrador(var AError: string): Boolean;
    function fSQLStatusEmProcessamento: String;
    function fSQLStatusProcessandoTransmitindo: String;
    function fSQLStatusNotasServicoParadas: String;
    function fSQLStatusReenvioAutomatico: String;
    function fSQLDocumentosPendentes(const Status: TStatusDocumentoFiscal): String;
    function fPodeCriarNovoProcesso(const qryNotas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
    procedure pVerificarStatusNotas(const Status: TStatusDocumentoFiscal);
    function fRetTamanhoNumeroDocumento(const strDtaIni, strEspDoc: String): Integer;
    function fEstaEmModoEmissaoNotaServicoCitel: Boolean;
    procedure pRemoverLogPrtSemXmlNfe(const qryNotas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; const Status: TStatusDocumentoFiscal);
    procedure pExecuteInterna;
  public
    constructor Create(ATarefa: TRegistrarTarefa; intTamLote: Integer);
    destructor Destroy; override;
    procedure Executar;
  end;

implementation

uses
 {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}
  Data.DB,
 {$ELSE}
  DB,
 {$IFEND}
  untLibNfe, untInterfaces, untModulo, untVerificarStatus, untLogDanfe, untDicSis;

var
  FProcessList: TObjectList;
  FReduzirTamLoteHoraInicio: TDateTime;
  FReduzirTamLoteLimiteMinutos: Integer;
  FReduzirVelocidadeProcessamento: Boolean;
  FReduzirMotivo: String;
  FEmissaoNotaServicoCitel: String;

procedure pRestabelecerVelocidade(const ATamLoteDef: Integer);
begin
  if FReduzirVelocidadeProcessamento then
  begin
    objLogDanfe.AddLog('Restabelecida quantidade de NFeStatus.exe ['+IntToStr(ATamLoteDef)+']');

    FReduzirTamLoteHoraInicio := Date;
    FReduzirVelocidadeProcessamento := False;
    FReduzirTamLoteLimiteMinutos := 10;
  end;
end;

procedure pSleep(AValue: Integer);
begin
  objLogDanfe.AddLog('Sleep(' + IntToStr(AValue) + ')');
  Sleep(AValue);
end;

procedure SetLogDanfe(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
  Var
    strObs: String;
begin
  objLogDanfe.objConexao := frmModulo.Database;
  If Assigned(qrNFe) Then
  Begin
    strObs := Trim(qrNFe.FieldByName('NFE_OBSERV').AsString);

    objLogDanfe.strNumDoc := qrNFe.FieldByName('NFE_NUMDOC').AsString;
    objLogDanfe.strEspDoc := qrNFe.FieldByName('NFE_ESPDOC').AsString;
    objLogDanfe.strCodEmp := qrNFe.FieldByName('NFE_CODEMP').AsString;
    objLogDanfe.strSerie_ := qrNFe.FieldByName('NFE_SERIE_').AsString;
    objLogDanfe.strCodCli := qrNFe.FieldByName('NFE_CODCLI').AsString;
    objLogDanfe.AddLog('Preparando para processar status do documento. Status atual: ' + qrNFe.FieldByName('NFE_STATUS').AsString +
                       IIF(strObs='', '', ' - ' + strObs));
  End
  Else
  Begin
    objLogDanfe.strNumDoc := '...';
    objLogDanfe.strEspDoc := '...';
    objLogDanfe.strCodEmp := VS_strCodEmp;
    objLogDanfe.strSerie_ := '...';
    objLogDanfe.strCodCli := '...';
  End;
end;

function ProcessRunningCount(out intProcessCount: Integer): Integer;
Var
  LIndex: Integer;
  LProcess: TNFeProcess;
begin
  Result := 0;
  Try
    For LIndex := 0 To FProcessList.Count -1 Do
    Begin
      LProcess := TNFeProcess(FProcessList[LIndex]);

      If (LProcess.Finished > 0) Then
        Continue;

      If FindProcess(LProcess.PID) Then
        Result := Result + 1
      Else
        LProcess.Finished := Date + Time;
    End;
  Finally
    intProcessCount := Result;
  End;
end;

function ProcessAlreadyExists(AExeName, AExeParams: string; var APID: Cardinal): Boolean;
Var
  LIndex: Integer;
  LProcess: TNFeProcess;
begin
  Result := False;
  For LIndex := 0 To FProcessList.Count -1 Do
  Begin
    LProcess := TNFeProcess(FProcessList[LIndex]);
    If (LProcess.Finished = 0) And
       (LProcess.ExeName = AExeName) And
       (LProcess.ExeParams = AExeParams) Then
    Begin
      APID := LProcess.PID;
      Result := True;
      Break;
    End;
  End;
end;

procedure WaitProcessQueue(ABatchSize: Integer);
  Var
    LProcessCount : Integer;
begin
  If FReduzirVelocidadeProcessamento Then
    Sleep(fSegundosToInterval(RandomRange(2, 5)));

  While ProcessRunningCount(LProcessCount) > ABatchSize Do
  Begin
    objLogDanfe.AddLog('WaitProcessQueue');
    objLogDanfe.AddLog('ABatchSize = ' + IntToStr(ABatchSize));
    objLogDanfe.AddLog('ProcessRunningCount = ' + IntToStr(LProcessCount));
    pSleep(500);
  End;
end;

function fGetStrCodCli(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): String;
begin
  If (Pos(qrNFe.FieldByName('NFE_STATUS').AsString, fProcessosSemCliFor) > 0) Then
    Result := IfEmptyStr(qrNFe.FieldByName('NFE_CODCLI').AsString, '0')
  Else
    Result := qrNFe.FieldByName('NFE_CODCLI').AsString
end;

function fGetStrTipFC_(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): String;
begin
  If (Pos(qrNFe.FieldByName('NFE_STATUS').AsString, fProcessosSemCliFor) > 0) Then
    Result := IfEmptyStr(qrNFe.FieldByName('NFE_TIP_FC').AsString, '0')
  Else
    Result := qrNFe.FieldByName('NFE_TIP_FC').AsString
end;

function fGetIdentificaoTarefa(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): String;
begin
  Result := Trim('NFE_PROCESSAR_STATUS'                   + ' ' + //Tarefa
                 qrNFe.FieldByName('NFE_NUMDOC').AsString + ' ' + //strNumDoc
                 qrNFe.FieldByName('NFE_ESPDOC').AsString + ' ' + //strEspDoc
                 qrNFe.FieldByName('NFE_CODEMP').AsString + ' ' + //strCodEmp
                 qrNFe.FieldByName('NFE_SERIE_').AsString + ' ' + //strSerie
                 fGetStrCodCli(qrNFe)                     + ' ' + //strCodCli
                 fGetStrTipFC_(qrNFe)                     + ' ' + //strTipFc
                 qrNFe.FieldByName('NFE_STATUS').AsString + ' ' + //strStatusNFe
                 VS_PidMD5DicSis);                                //PID do dicionário
end;

function fJaExisteTarefaStatus(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
var
  objRegistrarTarefa: TRegistrarTarefa;
begin
  Result := False;
  objRegistrarTarefa := TRegistrarTarefa.Create(fGetIdentificaoTarefa(qrNFe));
  Try
    objRegistrarTarefa.pRegistrarTarefa;
    If objRegistrarTarefa.blnJaExecutando Then
    Begin
      objLogDanfe.AddLog('Processamento do status já está sendo executado.');
      Result := True;
    End
    Else
      objRegistrarTarefa.pRemoverTarefa;
  Finally
    FreeAndNil(objRegistrarTarefa);
  End;
end;

function fDefinirTamanhoLote(const ATamLoteDef: Integer): Integer;
const
  MAX_CPU_USAGE = 5;
  MAX_PROC_STATUS_COUNT = 15;
var
  LSL: TStringList;
  LMinutosRestanteParaRestabelecer: Integer;
  LSegundosRestanteParaRestabelecer: Integer;
begin
  Result := ATamLoteDef;

  if Result = 1 then
    Exit;

  if not FileExists(ExtractFilePath(Application.ExeName) + 'NFE_STATUS_INFO.txt') then
  begin
    pRestabelecerVelocidade(ATamLoteDef);
    Exit;
  end;

  LSegundosRestanteParaRestabelecer := ((FReduzirTamLoteLimiteMinutos * 60) - SecondsBetween(Date+Time, FReduzirTamLoteHoraInicio));
  if (LSegundosRestanteParaRestabelecer > 0) then
  begin
    LMinutosRestanteParaRestabelecer  := ((FReduzirTamLoteLimiteMinutos) - MinutesBetween(Date+Time, FReduzirTamLoteHoraInicio));

    objLogDanfe.AddLog('Aguardando '+IntToStr(LMinutosRestanteParaRestabelecer)+' minutos ('+
                                     IntToStr(LSegundosRestanteParaRestabelecer)+' segundos) ou ciclo completo das tarefas para aumentar quantidade de NFeStatus.exe '+
                       'Motivo pelo qual foi reduzido: ' + FReduzirMotivo);

    Result := 1;
    Exit;
  end;

  pRestabelecerVelocidade(ATamLoteDef);

  LSL := TStringList.Create;
  try
    try
      LSL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'NFE_STATUS_INFO.txt');

      if MinutesBetween(Date+Time, StrToDateTimeDef(LSL.Values['UPDATED'], Date)) > FReduzirTamLoteLimiteMinutos then
        Exit;

      FReduzirMotivo := '';

      if StrToFloatDef(LSL.Values['CPU_USAGE'], 0) > MAX_CPU_USAGE then
      begin
        FReduzirMotivo := '[CPU_USAGE = '+LSL.Values['CPU_USAGE']+']';

        FReduzirTamLoteHoraInicio := Date+Time;
        FReduzirVelocidadeProcessamento := True;
        Result := 1;
      end
      else if StrToFloatDef(LSL.Values['PROC_STATUS_COUNT'], 0) > MAX_PROC_STATUS_COUNT then
      begin
        FReduzirMotivo := '[EXEC_COUNT = '+LSL.Values['PROC_STATUS_COUNT']+']';

        FReduzirTamLoteHoraInicio := Date+Time;
        FReduzirVelocidadeProcessamento := True;
        Result := 1;
      end;

      if FReduzirVelocidadeProcessamento then
      begin
        objLogDanfe.AddLog('Reduzindo quantidade de NFeStatus.exe Motivo: '+FReduzirMotivo);
        FReduzirTamLoteLimiteMinutos := RandomRange(10, 5);
      end;
    except
      on e: Exception do
      begin
        objLogDanfe.AddLog(e.Message + ' - ' + ExtractFilePath(Application.ExeName) + 'NFE_STATUS_INFO.txt');
      end;
    end;
  finally
    FreeAndNil(LSL);
  end;
end;

function ExecNFeStatus(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): TNFeProcess;
var
  LParams: String;
  LPID: Cardinal;
begin
  Result := nil;

  LParams := fTagComValorToParam('NFE_PROCESSAR_STATUS',                   consTagParamsTrf) +
             fTagComValorToParam(qrNFe.FieldByName('NFE_NUMDOC').AsString, consTagParamsDoc) +
             fTagComValorToParam(qrNFe.FieldByName('NFE_ESPDOC').AsString, consTagParamsEsp) +
             fTagComValorToParam(qrNFe.FieldByName('NFE_CODEMP').AsString, consTagParamsEmp) +
             fTagComValorToParam(qrNFe.FieldByName('NFE_SERIE_').AsString, consTagParamsSer) +
             fTagComValorToParam(fGetStrCodCli(qrNFe),                     consTagParamsCli) +
             fTagComValorToParam(fGetStrTipFC_(qrNFe),                     consTagParamsTfc) +
             fTagComValorToParam(qrNFe.FieldByName('NFE_STATUS').AsString, consTagParamsSta) +
             fTagComValorToParam(VS_PidMD5DicSis,                          consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

  If ProcessAlreadyExists(Application.ExeName, LParams, LPID) Then
  Begin
    objLogDanfe.AddLog('Já existe um processo executando [pid ' + FloatToStr(LPID) + '] ' + Application.ExeName + ' ' + LParams);
    Exit;
  End;

  Result           := TNFeProcess.Create;
  Result.ExeName   := Application.ExeName;
  Result.ExeParams := LParams;
  Result.PID       := StartProcess(Application.ExeName, LParams, False, False);
  Result.Started   := Date + Time;
  Result.Finished  := 0;
end;

{ TCoordenadorStatusNFe }

constructor TCoordenadorStatusNFe.Create(ATarefa: TRegistrarTarefa; intTamLote: Integer);
begin
  inherited Create;
  FPonImp := fArqIni(0, 'GERAL', 'PONIMP', '', 'opcoespainel.ini');
  FTamLote := intTamLote;
  FTarefa := ATarefa;
  Banco := frmModulo.Database;
 {$IF Defined(UNIDAC)}
  FTentativas := TDictionary<string,TTentativasAutorizacao>.Create;
 {$IFEND}
end;

destructor TCoordenadorStatusNFe.Destroy;
begin
 {$IF Defined(UNIDAC)}
  FTentativas.Free;
 {$IFEND}
  inherited;
end;

procedure TCoordenadorStatusNFe.Executar;
var
  LBegin: TDateTime;
begin
  LBegin := Date + Time;

  while MinutesBetween(Date + Time, LBegin) <= 30 do
  begin
    SetLogDanfe(nil);

    pExecuteInterna;

    if (FTarefa.blnBloquear Or FTarefa.blnTerminar) then
      Break;

    pSleep(1000);
  end;
end;

function TCoordenadorStatusNFe.fSQLStatusProcessandoTransmitindo: String;
begin
  Result := '';
  Result := Result + ' SELECT NFE_NUMDOC, ';
  Result := Result + '        NFE_ESPDOC, ';
  Result := Result + '        NFE_CODEMP, ';
  Result := Result + '        NFE_SERIE_, ';
  Result := Result + '        NFE_CODCLI, ';
  Result := Result + '        NFE_TIP_FC, ';
  Result := Result + '        "GE" AS NFE_STATUS, ';
  Result := Result + '        NFE_HORINI, ';
  Result := Result + '        NFE_OBSERV  ';
  Result := Result + '   FROM LOGNFE ';
  Result := Result + '  WHERE NFE_STATUS = "EE" ';
  Result := Result + '    AND NFE_CODEMP = :CODEMP ';
  Result := Result + '    AND ( ';
  Result := Result + '         (LOCATE("processando/transmitindo", NFE_OBSERV) > 0) ';
  Result := Result + '      OR (LOCATE("digitando status", NFE_OBSERV) > 0) ';
  Result := Result + '      OR (LOCATE("recusada/reenviar status", NFE_OBSERV) > 0) ';
  Result := Result + '      OR (LOCATE("xml validado com sucesso status", NFE_OBSERV) > 0) ';
  If fEstaEmModoEmissaoNotaServicoCitel Then
    Result := Result + '    OR (LOCATE("transmitida/aguardando retorno", NFE_OBSERV) > 0) ';
  Result := Result + '        ) ';
  Result := Result + '    AND LOCATE("reenvios atingido", NFE_OBSERV) = 0 ';

  If FPonImp <> '' Then
    Result := Result + '  AND ((NFE_PONIMP = "") OR (NFE_PONIMP = "' + FPonImp + '")) ';

  //NFE pendentes que nao estejam sendo processadas
  Result := Result + '    AND (SELECT COUNT(0) ';
  Result := Result + '           FROM NFE_TAREFAS ';
  Result := Result + '          WHERE LOCATE(CONCAT(NFE_NUMDOC, " ", NFE_ESPDOC, " ", NFE_CODEMP), NFE_TAREFA)) = 0 ';

  //Prioridades: NF -> IF, AE -> GE, 000001 -> 000002
  Result := Result + 'ORDER BY NFE_ESPDOC DESC, NFE_STATUS ASC, NFE_NUMDOC ASC ';

  Result := Result + 'LIMIT 500 ';
end;

function TCoordenadorStatusNFe.fSQLDocumentosPendentes(const Status: TStatusDocumentoFiscal): String;
begin
  Result := fSQLStatusEmProcessamento;
  Case Status Of
    sdfProcessandoTransmitindo: Result := fSQLStatusProcessandoTransmitindo;
    sdfEmProcessamento:         Result := fSQLStatusEmProcessamento;
    sdfNotasServicoParadas:     Result := fSQLStatusNotasServicoParadas;
    sdReenvioAutomatico:        Result := fSQLStatusReenvioAutomatico;
  End;
end;

function TCoordenadorStatusNFe.fSQLMsgsErroLibNfe(const aAliasLogNfe: String=''): String;
begin
  Result := '';
  Result := Result + '  (      ';
  Result := Result + '   LOCATE("falha na", NFE_OBSERV) > 0 ';
  Result := Result + '   AND ( ';
  If fEstaEmModoEmissaoNotaServicoCitel Then
    Result := Result + '      (LOCATE("host not found", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("libeay32.dll", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("ssl library", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("error creating ssl context", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("http/1.1 502 bad gateway", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("http/1.1 504 gateway time-out", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("http/1.1 503 service temporarily", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("http/1.1 403 forbidden", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("read timed out", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("connect timed out", NFE_OBSERV) > 0) OR ';
  Result := Result + '        (LOCATE("connection timed out", NFE_OBSERV) > 0) ';
  Result := Result + '       ) ';
  Result := Result + '  )      ';

  If (aAliasLogNfe <> '') Then
    Result := AnsiReplaceStr(Result, 'NFE_OBSERV', aAliasLogNfe+'.NFE_OBSERV');
end;

function TCoordenadorStatusNFe.fSQLStatusNotasServicoParadas: String;
  Var
    strDtaIni: String;
    strTamDoc: String;
    strTmpEnv: String;
begin
  strDtaIni := fCurrentDateTime(IncDay(Date, -30) + StrToTime('00:00:00'));

  strTamDoc := IntToStr(fRetTamanhoNumeroDocumento(strDtaIni, 'NS'));

  strTmpEnv := '00:01:00';
  If fEstaEmModoEmissaoNotaServicoCitel Then
    strTmpEnv := '00:00:30';

  Result := '';
  Result := Result + ' SELECT NFE_NUMDOC, ';
  Result := Result + '        NFE_ESPDOC, ';
  Result := Result + '        NFE_CODEMP, ';
  Result := Result + '        NFE_SERIE_, ';
  Result := Result + '        NFE_CODCLI, ';
  Result := Result + '        NFE_TIP_FC, ';
  Result := Result + '        "AE" AS NFE_STATUS, ';
  Result := Result + '        NFE_HORINI, ';
  Result := Result + '        NFE_OBSERV  ';
  Result := Result + '   FROM LOGNFE ';
  Result := Result + '  WHERE NFE_STATUS = "EE" ';
  Result := Result + '    AND NFE_CODEMP = :CODEMP ';
  Result := Result + '    AND NFE_ESPDOC = "NS" ';
  Result := Result + '    AND NFE_NUMDOC = (SELECT LPAD(CAST((CAST(MAX(NFE_NUMDOC) AS SIGNED)+1) AS CHAR('+strTamDoc+')), '+strTamDoc+', "0") FROM LOGNFE ';
  Result := Result + '                       WHERE NFE_STATUS = "AT" ';
  Result := Result + '                         AND NFE_CODEMP = :CODEMP ';
  Result := Result + '                         AND NFE_ESPDOC = "NS" ';
  Result := Result + '                         AND IFNULL(NFE_ACESSO, "") <> "" ';
  Result := Result + '                         AND NFE_HORINI >= '+strDtaIni;
  Result := Result + '                         AND LENGTH(NFE_NUMDOC) = '+strTamDoc+')';
  Result := Result + '    AND LENGTH(NFE_NUMDOC) = '+strTamDoc;
  Result := Result + '    AND NFE_HORINI >= '+strDtaIni;
  Result := Result + '    AND (     ';
  Result := Result + '              (LOCATE("Utilize F1", NFE_OBSERV) > 0) ';
  Result := Result + '          OR  ( ';
  Result := Result + '                TIMEDIFF(nOw(), NFE_HORINI) >= "'+strTmpEnv+'" ';
  Result := Result + '                AND ( ';
  Result := Result + '                        (LOCATE("999 - Server returned HTTP response code", NFE_OBSERV) > 0) ';
  Result := Result + '                     OR (LOCATE("999 - Connect timed out", NFE_OBSERV) > 0) ';
  Result := Result + '                     OR (LOCATE("999 - Read timed out", NFE_OBSERV) > 0) ';
  If fEstaEmModoEmissaoNotaServicoCitel Then
    Result := Result + '                   OR (LOCATE("HASH do Arquivo TXT", NFE_OBSERV) > 0) ';
  Result := Result + '                    ) ';
  Result := Result + '              )       ';
  If fUsaNotaServicoEletronicaEnotas Then
  Begin
    Result := Result + '        OR  (NFE_OBSERV LIKE "%400%Uma NFe com o status % não pode ser atualizada%") ';
    Result := Result + '        OR  (NFE_OBSERV LIKE "%500%O servidor encontrou uma condição inesperada%") ';
    Result := Result + '        OR  (NFE_OBSERV LIKE "%Negada - Nota sem validade fiscal. Necessário reprocessar%") ';
  End;
  Result := Result + '          OR ' + fSQLMsgsErroLibNfe;
  Result := Result + '        )    ';
  Result := Result + '    AND LOCATE("reenvios atingido", NFE_OBSERV) = 0 ';

  If FPonImp <> '' Then
    Result := Result + '  AND ((NFE_PONIMP = "") OR (NFE_PONIMP = "' + FPonImp + '")) ';

  //NFE pendentes que nao estejam sendo processadas
  Result := Result + '    AND (SELECT COUNT(0) ';
  Result := Result + '           FROM NFE_TAREFAS ';
  Result := Result + '          WHERE LOCATE(CONCAT(NFE_NUMDOC, " ", NFE_ESPDOC, " ", NFE_CODEMP), NFE_TAREFA)) = 0 ';

  Result := Result + 'LIMIT 1';
end;

function TCoordenadorStatusNFe.fSQLStatusReenvioAutomatico: String;
  Var
    strDtaIni: String;
begin
  strDtaIni := fCurrentDateTime(IncDay(Date, -7) + StrToTime('00:00:00'));

  Result := '';
  Result := Result + ' SELECT NFE_NUMDOC, ';
  Result := Result + '        NFE_ESPDOC, ';
  Result := Result + '        NFE_CODEMP, ';
  Result := Result + '        NFE_SERIE_, ';
  Result := Result + '        NFE_CODCLI, ';
  Result := Result + '        NFE_TIP_FC, ';
  Result := Result + '        "AE" AS NFE_STATUS, ';
  Result := Result + '        NFE_HORINI, ';
  Result := Result + '        NFE_OBSERV  ';
  Result := Result + '   FROM LOGNFE ';
  Result := Result + '  WHERE NFE_STATUS = "EE" ';
  Result := Result + '    AND NFE_ESPDOC IN ' + IIF(fUsaSat, '("NF")', '("NF", "IF")');
  Result := Result + '    AND NFE_CODEMP = :CODEMP ';
  Result := Result + '    AND NFE_HORINI >= '+strDtaIni;
  Result := Result + '    AND ( ';
  Result := Result +           fSQLMsgsErroLibNfe;
  Result := Result + '         OR (LOCATE("enviado direto para o painel", NFE_OBSERV) > 0) ';
  Result := Result + '        ) ';
  Result := Result + '    AND LOCATE("reenvios atingido", NFE_OBSERV) = 0 ';

  If FPonImp <> '' Then
    Result := Result + '  AND ((NFE_PONIMP = "") OR (NFE_PONIMP = "' + FPonImp + '")) ';

  //NFE pendentes que nao estejam sendo processadas
  Result := Result + '    AND (SELECT COUNT(0) ';
  Result := Result + '           FROM NFE_TAREFAS ';
  Result := Result + '          WHERE LOCATE(CONCAT(NFE_NUMDOC, " ", NFE_ESPDOC, " ", NFE_CODEMP), NFE_TAREFA)) = 0 ';

  //Prioridades: NF -> IF, AE -> GE, 000001 -> 000002
  Result := Result + 'ORDER BY NFE_ESPDOC DESC, NFE_STATUS ASC, NFE_NUMDOC ASC ';

  Result := Result + 'LIMIT 500 ';
end;

function TCoordenadorStatusNFe.fVerificarConexaoIntegrador(var AError: string): Boolean;
var
  strCnpj:String;
  strIes: String;
  strUF:  String;
  retorno: TRetornoStatusNFE;
begin
  Result := True;
  objLogDanfe.AddLog('Verificando a conexão com o integrador');
  Try
    If fDadosEmitenteStatusServico(strCnpj, strIes, strUF, nil) Then
    Begin
      If (strUF <> '') Then
        retorno := fVerificarStatusServicoPelaUF(strUF)
      Else
        retorno := fVerificarStatusServico(strCnpj, strIes);

      Case retorno Of
        rsTimeoutIntegrador: Result := False;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pLogImp('fVerificarConexaoIntegrador > E.Message = ' + E.Message + ' AError = ' + AError);
    End;
  End;
end;

function TCoordenadorStatusNFe.fAguardarParaNovaTentativa(const qrNFe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
{$IF Defined(UNIDAC)}
var
  LTentativas: TTentativasAutorizacao;
  LTempoDesdeUltimaTentativa: Integer;
begin
  Result := False;

  If (qrNFe.FieldByName('NFE_ESPDOC').AsString = 'NS') Then
    Exit;

  If FTentativas.TryGetValue(fGetIdentificaoTarefa(qrNFe), LTentativas) Then
  Begin
    LTentativas.NumeroTentativas := LTentativas.NumeroTentativas + 1;
    LTempoDesdeUltimaTentativa := SecondsBetween(Time, LTentativas.UltimaTentativa);
    If (LTentativas.NumeroTentativas > 5) And
       (LTempoDesdeUltimaTentativa < 120) And
       (LTentativas.UltimoRetorno = qrNFe.FieldByName('NFE_OBSERV').AsString) Then
    Begin
      Sleep(2000);
      objLogDanfe.AddLog('Aguardando para nova tentativa de processar status. Nova tentativa em: '+IntToStr(120-LTempoDesdeUltimaTentativa)+' segundos');
      Result := True;
      Exit;
    End
    else
      objLogDanfe.AddLog('Realizando nova tentativa de processar status.');
  End
  Else
    LTentativas.NumeroTentativas := 1;

  LTentativas.UltimaTentativa := Time;
  LTentativas.UltimoRetorno := qrNFe.FieldByName('NFE_OBSERV').AsString;
  FTentativas.AddOrSetValue(fGetIdentificaoTarefa(qrNFe), LTentativas);
end;
{$ELSE}
begin
  Result := False;
end;
{$IFEND}

function TCoordenadorStatusNFe.fSQLStatusEmProcessamento: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  NFE_NUMDOC, ';
  Result := Result + '  NFE_ESPDOC, ';
  Result := Result + '  NFE_CODEMP, ';
  Result := Result + '  NFE_SERIE_, ';
  Result := Result + '  NFE_CODCLI, ';
  Result := Result + '  NFE_TIP_FC, ';
  Result := Result + '  NFE_STATUS, ';
  Result := Result + '  NFE_HORINI, ';
  Result := Result + '  NFE_OBSERV  ';
  Result := Result + 'FROM ';
  Result := Result + '  LOGNFE ';
  Result := Result + 'WHERE ';
  Result := Result + '  NFE_STATUS IN ("AE", "GE", "GC", "GM", "CG") AND ';
  Result := Result + '  NFE_CODEMP = :CODEMP AND ';

  If FPonImp <> '' Then
    Result := Result + '  ((NFE_PONIMP = "") OR (NFE_PONIMP = "' + FPonImp + '")) AND ';

  //NFE pendentes que nao estejam sendo processadas
  Result := Result + '  (SELECT COUNT(0) FROM NFE_TAREFAS WHERE ';
  Result := Result + '   LOCATE(CONCAT(NFE_NUMDOC, " ", NFE_ESPDOC, " ", NFE_CODEMP), NFE_TAREFA)) = 0 ';

  //Prioridades: NF -> IF, AE -> GE, 000001 -> 000002
  Result := Result + 'ORDER BY NFE_ESPDOC DESC, NFE_STATUS ASC, NFE_NUMDOC ASC ';

  Result := Result + 'LIMIT 500 ';
end;

function TCoordenadorStatusNFe.fEstaEmModoEmissaoNotaServicoCitel: Boolean;
begin
  If (FEmissaoNotaServicoCitel = '') Then
  Begin
    Try
      FEmissaoNotaServicoCitel := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_AXCFNS', VS_strCodEmp], Banco);
    Finally
      If (FEmissaoNotaServicoCitel <> 'S') Then
        FEmissaoNotaServicoCitel := 'N';
    End;
  End;

  Result := (FEmissaoNotaServicoCitel = 'S');
end;

procedure TCoordenadorStatusNFe.pExecuteInterna;
begin
  objLogDanfe.AddLog('pExecuteInterna');

  FTarefa.pSinalizarExecutando;

  if FTarefa.blnBloquear then
    Exit;

  FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

  objLogDanfe.AddLog('pVerificarStatusNotas(sdfEmProcessamento)');
  pVerificarStatusNotas(sdfEmProcessamento);

  objLogDanfe.AddLog('pVerificarStatusNotas(sdfProcessandoTransmitindo)');
  pVerificarStatusNotas(sdfProcessandoTransmitindo);

  objLogDanfe.AddLog('pVerificarStatusNotas(sdfNotasServicoParadas)');
  pVerificarStatusNotas(sdfNotasServicoParadas);

  objLogDanfe.AddLog('pVerificarStatusNotas(sdReenvioAutomatico)');
  pVerificarStatusNotas(sdReenvioAutomatico);

  pRestabelecerVelocidade(FTamLote);
end;

procedure TCoordenadorStatusNFe.pRemoverLogPrtSemXmlNfe(const qryNotas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}; const Status: TStatusDocumentoFiscal);
Var
  qryaAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnDelLogPrt: Boolean;
  strCmpNfeObs: String;
begin
  blnDelLogPrt := Status In [sdfNotasServicoParadas, sdReenvioAutomatico, sdfEmProcessamento];

  If (Not blnDelLogPrt) Then
    Exit;

  If (Not fTabelaExiste('LOGPRT', Banco)) Then
    Exit;

  If (Not fTabelaExiste('XMLNFE', Banco)) Then
    Exit;

  qryaAux := Nil;
  Try
    blnDelLogPrt := False;

    If (Assigned(qryNotas.FindField('NFE_STATUS'))) And
       (Assigned(qryNotas.FindField('NFE_ESPDOC'))) And
       (Assigned(qryNotas.FindField('NFE_OBSERV'))) Then
    Begin
      blnDelLogPrt := (qryNotas.FindField('NFE_STATUS').AsString = 'AE') And
                      (Pos(qryNotas.FindField('NFE_ESPDOC').AsString, 'NF_IF_NS_') > 0);

      If blnDelLogPrt Then
      Begin
        strCmpNfeObs := AnsiLowerCase(qryNotas.FindField('NFE_OBSERV').AsString);
        blnDelLogPrt := ((Pos('falha na', strCmpNfeObs) > 0) Or ((Pos('o painel', strCmpNfeObs) > 0)));
      End;
    End;

    If (Not blnDelLogPrt) Then
      Exit;

    qryaAux := fCriaQuery(Nil, Banco);
    Try
      qryaAux.SQL.Clear;
      qryaAux.SQL.Text :=
          'DELETE FROM LOGPRT '+
          ' WHERE PRT_NUMDOC = :NUMDOC '+
          '   AND PRT_ESPDOC = :ESPDOC '+
          '   AND PRT_CODEMP = :CODEMP '+
          '   AND PRT_FORCLI = :FORCLI '+
          '   AND PRT_SERIE_ = :SERIE_ '+
          '   AND PRT_TIP_FC = :TIP_FC '+
          '   AND EXISTS (SELECT TRUE  '+
          '                 FROM LOGNFE L LEFT JOIN XMLNFE X ON L.NFE_ACESSO = X.NFE_ACESSO '+
          '                WHERE L.NFE_NUMDOC = LOGPRT.PRT_NUMDOC '+
          '                  AND L.NFE_ESPDOC = LOGPRT.PRT_ESPDOC '+
          '                  AND L.NFE_CODEMP = LOGPRT.PRT_CODEMP '+
          '                  AND L.NFE_CODCLI = LOGPRT.PRT_FORCLI '+
          '                  AND L.NFE_SERIE_ = LOGPRT.PRT_SERIE_ '+
          '                  AND L.NFE_TIP_FC = LOGPRT.PRT_TIP_FC '+
          '                  AND X.NFE_ACESSO IS NULL '+
          '                  AND ( '+
                                  fSQLMsgsErroLibNfe('L') +
          '                       OR (LOCATE("enviado direto para o painel", L.NFE_OBSERV) > 0) '+
          '                      ) '+
          '              ) ';

      qryaAux.ParamByName('NUMDOC').AsString := qryNotas.FieldByName('NFE_NUMDOC').AsString;
      qryaAux.ParamByName('ESPDOC').AsString := qryNotas.FieldByName('NFE_ESPDOC').AsString;
      qryaAux.ParamByName('CODEMP').AsString := qryNotas.FieldByName('NFE_CODEMP').AsString;
      qryaAux.ParamByName('FORCLI').AsString := qryNotas.FieldByName('NFE_CODCLI').AsString;
      qryaAux.ParamByName('SERIE_').AsString := qryNotas.FieldByName('NFE_SERIE_').AsString;
      qryaAux.ParamByName('TIP_FC').AsString := qryNotas.FieldByName('NFE_TIP_FC').AsString;
      qryaAux.ExecSQL;

      If (qryaAux.RowsAffected > 0) Then
        pLogImp('LOGPRT removida (sem XMLNFE correspondente): '+qryNotas.FieldByName('NFE_NUMDOC').AsString+'-'+
                                                                qryNotas.FieldByName('NFE_ESPDOC').AsString+'-'+
                                                                qryNotas.FieldByName('NFE_CODEMP').AsString);
    Except
      On E: Exception Do
        pLogImp(E.Message + ' [TCoordenadorStatusNFe.pRemoverLogPrtSemXmlNfe]');
    End;
  Finally
    If Assigned(qryaAux) Then
      FreeAndNil(qryaAux);
  End;
end;

function TCoordenadorStatusNFe.fPodeCriarNovoProcesso(const qryNotas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
  Var
    LProcessCount: Integer;
begin
  Result := False;

  //SEMPRE EM PRIMEIRO...
  If (Not FReduzirVelocidadeProcessamento) Then
    If (ProcessRunningCount(LProcessCount) >= FTamLote) Then
      Exit;
  //...SEMPRE EM PRIMEIRO

  //SEMPRE EM SEGUNDO...
  If (fJaExisteTarefaStatus(qryNotas)) Then
    Exit;
  //...SEMPRE EM SEGUNDO

  If (fAguardarParaNovaTentativa(qryNotas)) Then
    Exit;

  Result := True;
end;

procedure TCoordenadorStatusNFe.pVerificarStatusNotas(const Status: TStatusDocumentoFiscal);
Var
  qryNotas: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LMsg: string;
  LProcess: TNFeProcess;
  LVerificaSefaz: Boolean;
begin
  If FTarefa.blnBloquear Then
    Exit;

  If (Status = sdfNotasServicoParadas) Then
    If (fCfgSisPainel('USASER', Banco) <> 'S') Then
      Exit;

  If (Status = sdReenvioAutomatico) Then
    If (fEstaEmModoEmissaoNotaServicoCitel) Then
      Exit;

  qryNotas := fCriaQuery(Nil, Banco);
  Try
    qryNotas.SQL.Add(fSQLDocumentosPendentes(Status));
    qryNotas.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNotas.Open;

    if (Status <> sdfNotasServicoParadas) and (not qryNotas.IsEmpty) then
    begin
      LVerificaSefaz := False;
      qryNotas.First;
      While (Not qryNotas.Eof) Do
      Begin
        If (qryNotas.FieldByName('NFE_ESPDOC').AsString <> 'NS') Then
        Begin
          LVerificaSefaz := True;
          Break;
        End;
        qryNotas.Next;
      End;

      If LVerificaSefaz Then
      Begin
        If (Not fVerificarConexaoIntegrador(LMsg)) Then
        Begin
          FTarefa.pAtualizarInformacao(LMsg);
          objLogDanfe.AddLog(LMsg);
          pSleep(10000);
          Exit;
        End;
      End;
    end;

    qryNotas.First;
    While (Not qryNotas.Eof) Do
    Begin
      Try
        SetLogDanfe(qryNotas);

        If (fPodeCriarNovoProcesso(qryNotas)) Then
        Begin
          FTarefa.pSinalizarExecutando;

          If FTarefa.blnBloquear Then
            Break;

          pRemoverLogPrtSemXmlNfe(qryNotas, Status);

          LProcess := ExecNFeStatus(qryNotas);
          If Assigned(LProcess) Then
            FProcessList.Add(LProcess);
        End;
      Finally
        SetLogDanfe(nil);
      End;

      WaitProcessQueue(fDefinirTamanhoLote(FTamLote));

      qryNotas.Next;
    End;
  Finally
    FreeAndNil(qryNotas);
  End;
end;

function TCoordenadorStatusNFe.fRetTamanhoNumeroDocumento(const strDtaIni, strEspDoc: String): Integer;
Var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := 0;
  qryGen := fCriaQuery(Nil, Banco);
  Try
    qryGen.SQL.Text := ' SELECT LENGTH(NFE_NUMDOC)   ' +
                       '   FROM LOGNFE               ' +
                       '  WHERE NFE_CODEMP = :CODEMP ' +
                       '    AND NFE_ESPDOC = :ESPDOC ' +
                       '    AND NFE_STATUS = "AT"    ' +
                       '    AND NFE_HORINI >= ' + strDtaIni +
                       '    AND IFNULL(NFE_ACESSO, "") <> "" ' +
                       '  ORDER BY NFE_NUMDOC DESC ' +
                       '  LIMIT 1';

    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
      Result := qryGen.Fields[0].AsInteger;

    qryGen.Close;
  Finally
    FreeAndNil(qryGen);

    If (Not (Result In [6, 12])) Then
    Begin
      {$IF RTLVersion >= 28}
      Result := 12
      {$ELSE}
      Result := 6
      {$IFEND}
    End;
  End;
end;

initialization
  FProcessList := TObjectList.Create;
  FReduzirTamLoteHoraInicio := Date;
  FReduzirTamLoteLimiteMinutos := 10;
  FReduzirVelocidadeProcessamento := False;
  FEmissaoNotaServicoCitel := '';

finalization
  FreeAndNil(FProcessList);
end.
