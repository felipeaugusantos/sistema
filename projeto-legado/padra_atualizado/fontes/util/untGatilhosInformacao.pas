unit untGatilhosInformacao;

interface

uses
  REST.Client, REST.Types, REST.Authenticator.Basic,

  idHTTP, IdBaseComponent, System.NetEncoding, IdHashMessageDigest,
  IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Json, idAntiFreeze, WinAPI.Windows, IdCoder, IdCoder3to4, IdCoderMIME, untFuncoesGenerica,

  SysUtils, Uni, System.Generics.Collections, Math, DateUtils, untUtilMonitor, StrUtils,
  System.IOUtils, untGatilhosInformacaoImagemAnexo, untGatilhosInformacaoImagemAnexoDashboard, Classes,
  untDadosEnviaWhatsapp, untDadosEnviaGatilhoEmail, untDllGatIme;

type
  TGatilhoPeriodo = record
    strCodigo: string;
    strDescricao: string;
    strSQLDataInicial: string;
    strSQLDataFinal: string;
    function GetDataInicial: TDateTime;
    function GetDataFinal: TDateTime;
  end;

  TGatilhoInformacao = record
    strAutInc: string;
    strCodigo: string;
    strDescricao: string;
    strCodigoRelatorio: string;
    strCodigoPeriodo: string;
    strCodigoOperador: string;
    strCodigoEmpresa: string;
    strQuandoEnviar: string;
    strDiasSemana: string;
    strDiasMes: string;
    blnWhatsApp: Boolean;
    blnEmail: Boolean;
    blnEnviarFeriados: Boolean;
    blnAtivo: Boolean;
    dtaHoraEnvio: TDateTime;
    strTabelaFiltros: String;
    strArquivoSaidaPDF: string;
    strRelatorioStatus: string;
    strRelatorioTipo: string;
    blnEditouFiltrosRelatorio: Boolean;
    recImagemCorpoEmail: TGatilhoInformacaoImagem;
    recImagemCorpoEmailDashboard: TGatilhoInformacaoImagemDashboard;
    recImagemCorpoWhatsApp: TGatilhoInformacaoImagem;
    recImagemCorpoWhatsAppDashboard: TGatilhoInformacaoImagemDashboard;
    blnCopiar: Boolean;
    strDirAce: string;
    strUrlGrafico: string;
    strJsonDadosEnviaWhatsapp: String;
  private
    procedure GetDataRelatorio(strDataInicial, strDataFinal: string; var strDataRelatorio: string);
    procedure AtualizarFiltrosPeriodo(var strDtaIni, strDtaFin: string);
    procedure AtualizarFiltrosDestino;
    procedure pAtualizarFiltro(AFiltro: string; AValor: string);
    procedure SalvarFiltros;
    procedure EnviarRelatorioPorEmail;
    procedure EnviarRelatorioPorWhatsApp;
    function fValidarDireitoAcessoOperadorRelatorio: Boolean;
    procedure pAbrirDireitoDeAcessoRelatorio;
  public
    procedure CarregarFiltros;
    procedure LiberarFiltros;
    procedure TestarEnviarRelatorioPorEmail;
    procedure TestarEnviarRelatorioPorWhatsApp;
  public
    function ValidarFiltrosRelatorio: Boolean;
    function EditarFiltrosRelatorio: Boolean;
    function fTemFiltroDataInicial: Boolean;
    function fTemFiltroDataFinal: Boolean;
    function ExecutarRelatorioParaEmail(blnTesteEmail: boolean = False): Boolean;
    function ExecutarRelatorioParaWhatsApp(blnTesteWhatsApp: boolean = False): Boolean;
    function fTemGatPerPreenchida: Boolean;
  end;

  TGatilhosInformacao = class sealed
  public
    class function Carregar(ACodigo: String; var AGatilho: TGatilhoInformacao): Boolean;
    class function Copiar(ACodigo: String; var AGatilho: TGatilhoInformacao): Boolean;
    class function Salvar(var AGatilho: TGatilhoInformacao): Boolean;
    class function Excluir(const ACodigo: String): Boolean;
    class function ValidarRelatorio(const ACodigo: string): Boolean;
    class function JaFoiEnviado(const ACodigo: string): Boolean;
    class procedure AtualizarDataEnvio(const ACodigo: string);
    class procedure AtualizarUltimaMsg(const ACodigo: string);
    class procedure AtualizarDataProximoEnvio(const ACodigo: string; ADtaRef: TDateTime = 0); overload;
    class procedure AtualizarDataProximoEnvio; overload;
 end;

  TGatilhoPeriodos = class sealed
  private
    FList: TList<TGatilhoPeriodo>;
    procedure CarregarPeriodos;
  public
    constructor Create;
    destructor Destroy; override;
    function FindByCodigo(ACodigo: string): TGatilhoPeriodo;
    property Items: TList<TGatilhoPeriodo> read FList;
  end;

  TGatilhosInformacaoMonitor = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    class var Mensagens: TStringList;
    FCodigo: string;
    FLastWS: TDateTime;
  protected
    class function fPodeExecutar: Boolean;
    constructor Create(ACodigo: string);
  public
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute: TResultExecute;
    procedure ClearLog;
    class procedure AddLog(AText: String); static;
    class procedure ExecutarRobo();
    class function New(ACodigo: string = ''): IMonitorProcedure;
  end;

  TAtualizarGatilhosWebService = class sealed
  private
    class function GetBody: string;
    class function GetMD5(const strTexto: string): string;
    class function GetUTC(dt: TDateTime): TDateTime;
    class function GetEnviar(dt: TDateTime): string;
    class function RetornaTimeStampEmMilisegundos: Int64;
    class function GetBasicAuthenticator: THTTPBasicAuthenticator;
    class procedure Post(ARaiseError: Boolean = False);
  public
    class procedure Execute(ARaiseError: Boolean = False);
  end;

Const
  IdMonitorGatilhosInformacao = 'MONITOR_GATILHOS_INFORMACAO_%s';
  IdInactivityMonitorGatilhosInformacao = 'TESTE_INATIVIDADE_%s';
  GatilhosInformacaoMonitorExeName = 'autcom.exe';
  GatilhosInformacaoMonitorExeParam = 'GATILHOS_INFORMACAO';
  TimeLimitMonitorGatilhosInformacao = 30;
  AttemptsLockMonitorGatilhosInformacao = 30;
  MinutosNovaTentativaGatilhosInformacao = 10;

Var
  VS_strLockMonitorGatilhosInformacao: String;
  VS_dtaUltimaExecucaoMonitorGatilhosInformacao: TDateTime;
  VS_objProcessoMonitorGatilhosInformacao: TProcessInformation;

implementation

uses
  untFuncoesSimples, untSeqTmp, untRelatorio, untTypesSistema, untTEnvioEmail,
  untQualiZapEnqueueMessageToSend, untQualiZapUploadFile, untConstantes,
  untFuncoesImagem, untDirAcesso, untPermissaoAcesso, untAtuVarGlobais;

const
  SQL_GATILHOS_PENDENTES =
    ' SELECT                                             '+
    '   GAT_CODIGO, GAT_PROENV, AUTOINCREM               '+
    ' FROM                                               '+
    '   GATINF                                           '+
    ' WHERE TRUE                                         '+
    '   AND GAT_STATUS = "A"                             '+
    '   AND GAT_PROENV <= CURRENT_TIMESTAMP              '+
    '   AND GAT_CODEMP IN                                '+
    '  (SELECT                                           '+
    '     SRV_CODEMP                                     '+
    '   FROM                                             '+
    '     EMPRESAS_NESTE_SERVIDOR)                       '+
    ' ORDER BY GAT_PROENV ASC;                           ';

{ TGatilhosInformacao }

class procedure TGatilhosInformacao.AtualizarDataProximoEnvio(const ACodigo: string; ADtaRef: TDateTime = 0);
var
  LStatus: string;
  LQuandoEnviar: string;
  LDiasSemana: string;
  LDiasMes: string;
  LDataAtual: TDateTime;
begin
  if ADtaRef > 0 then
    LDataAtual := ADtaRef + fCampoTabela('GAT_HORENV', 'GATINF', ['GAT_CODIGO'], [ACodigo])
  else
    LDataAtual := VS_Date + fCampoTabela('GAT_HORENV', 'GATINF', ['GAT_CODIGO'], [ACodigo]);

  LStatus := fCampoTabela('GAT_STATUS', 'GATINF', ['GAT_CODIGO'], [ACodigo]);
  LDiasSemana := fCampoTabela('GAT_DIASEM', 'GATINF', ['GAT_CODIGO'], [ACodigo]);
  LDiasMes := fCampoTabela('GAT_DIAMES', 'GATINF', ['GAT_CODIGO'], [ACodigo]);
  LQuandoEnviar := fCampoTabela('GAT_ENVIAR', 'GATINF', ['GAT_CODIGO'], [ACodigo]);

  if (LStatus <> 'A') then
  begin
    fExecutaSQL('UPDATE GATINF SET GAT_PROENV = NULL WHERE GAT_CODIGO = "'+ACodigo+'"', True);
    Exit;
  end;

  if (LQuandoEnviar <> 'DIAS FIXOS') and (not LDiasSemana.Contains('S')) then
  begin
    fExecutaSQL('UPDATE GATINF SET GAT_PROENV = NULL WHERE GAT_CODIGO = "'+ACodigo+'"', True);
    Exit;
  end;

  if (LQuandoEnviar = 'DIAS FIXOS') and (not LDiasMes.Contains('S')) then
  begin
    fExecutaSQL('UPDATE GATINF SET GAT_PROENV = NULL WHERE GAT_CODIGO = "'+ACodigo+'"', True);
    Exit;
  end;

  while True do
  begin
    if LQuandoEnviar <> 'DIAS FIXOS' then
    begin
      if Copy(LDiasSemana, DayOfWeek(LDataAtual), 1) <> 'S' then
      begin
        LDataAtual := IncDay(LDataAtual, 1);
        Continue;
      end;
    end
    else
    begin
      if DayOfTheMonth(LDataAtual) = DayOfTheMonth(EndOfTheMonth(LDataAtual)) then
      begin
        if Pos('S', Copy(LDiasMes, DayOfTheMonth(LDataAtual), 5)) = 0 then
        begin
          LDataAtual := IncDay(LDataAtual, 1);
          Continue;
        end;
      end
      else if Copy(LDiasMes, DayOfTheMonth(LDataAtual), 1) <> 'S' then
      begin
        LDataAtual := IncDay(LDataAtual, 1);
        Continue;
      end;
    end;
    fExecutaSQL('UPDATE GATINF SET GAT_PROENV = '+fCurrentDateTime(LDataAtual)
      +' WHERE GAT_CODIGO = "'+ACodigo+'"', True);
    Break;
  end;
end;

class procedure TGatilhosInformacao.AtualizarDataEnvio(const ACodigo: string);
begin
  fExecutaSQL('UPDATE GATINF SET GAT_ULTENV = '+fCurrentDateTime(fRetDtaHraServidor)
    + ' WHERE GAT_CODIGO = "'+ACodigo+'"', True);
  TGatilhosInformacao.AtualizarDataProximoEnvio(ACodigo, IncDay(fRetDataServidor, 1));
end;

class procedure TGatilhosInformacao.AtualizarDataProximoEnvio;
var
  qryGen: TUniQuery;
begin
  fExecutaSQL('UPDATE GATINF SET GAT_PROENV = NULL WHERE GAT_STATUS <> "A"', True);
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT GAT_CODIGO FROM GATINF WHERE GAT_STATUS = "A"';
    qryGen.Open;
    while not qryGen.Eof do
    begin
      AtualizarDataProximoEnvio(qryGen.FieldByName('GAT_CODIGO').AsString);
      qryGen.Next;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

class function TAtualizarGatilhosWebService.GetUTC(dt: TDateTime): TDateTime;
begin
  Result := TTimeZone.Local.ToUniversalTime(dt);
end;

class function TAtualizarGatilhosWebService.RetornaTimeStampEmMilisegundos: Int64;
var
  LDateTime: TDateTime;
  LDataServidor: TDateTime;
  LHoraServidor: TDateTime;
  LConsulta: TUniQuery;
begin
  try
    LConsulta := fCriaQuery;
    try
      LConsulta.SQL.Add('SELECT CURRENT_DATE AS DATA, FROM_UNIXTIME(CURRENT_TIME * 0.001) AS HORA FROM DUAL');
      LConsulta.Open;

      LDataServidor := FloatToDateTime(LConsulta.FieldByName('DATA').AsFloat);
      LHoraServidor := FloatToDateTime(LConsulta.FieldByName('HORA').AsFloat);

      LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                   EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));

      Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
    finally
      FreeAndNil(LConsulta);
    end;
  except
    Result := MilliSecondsBetween(GetUTC(System.SysUtils.nOw), UnixDateDelta);
  end;
End;

class function TAtualizarGatilhosWebService.GetMD5(const strTexto: string): string;
var
  idHash128: TIdHashMessageDigest5;
begin
  Try
    idHash128 := TIdHashMessageDigest5.Create;
    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

class procedure TAtualizarGatilhosWebService.Execute(ARaiseError: Boolean = False);
begin
  pDestravaLockForcado('TAtualizarGatilhosWebService.Execute');
  if not fLock_Unlock('TAtualizarGatilhosWebService.Execute', True, False, False, '', False) then
    Exit;
  try
    TAtualizarGatilhosWebService.Post(ARaiseError);
  finally
    fLock_Unlock('TAtualizarGatilhosWebService.Execute', False, False, False, '', False);
  end;
end;

class procedure TAtualizarGatilhosWebService.Post(ARaiseError: Boolean = False);
var
  LClient: TRESTClient;
  LRequest: TRestRequest;
  LResponse: TRESTResponse;
  LAuthenticator: THTTPBasicAuthenticator;
begin
  LClient := TRESTClient.Create(fCfgSis('GATURL'));
  try
    LRequest := TRESTRequest.Create(LClient);
    LResponse := TRESTResponse.Create(LClient);
    LAuthenticator := GetBasicAuthenticator;
    try
      LRequest.Client := LClient;
      LRequest.Response := LResponse;
      LClient.Authenticator := LAuthenticator;
      LRequest.Resource := 'api/gatilhos/'+ fRetNomeDesteServidor.Replace(' ', '_').Trim;
      LRequest.Method := rmPOST;
      LRequest.Body.Add(GetBody, ctAPPLICATION_JSON);
      LRequest.Execute;
      if LResponse.StatusCode <> 200 then
        if ARaiseError then
          raise Exception.Create('Erro ao se comunicar com a api de gatilhos de informação: ' +
            LResponse.StatusCode.ToString + ' - ' + LResponse.StatusText + ' - ' + LResponse.Content);
    finally
      FreeAndNil(LAuthenticator);
    end;
  finally
    FreeAndNil(LClient);
  end;
end;

class function TAtualizarGatilhosWebService.GetBasicAuthenticator: THTTPBasicAuthenticator;
const
  ChaveAutorizacaoCitel = 'uLtr@-F!n&320147';
var
  LTimeStampRequisicao: string;
begin
  LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;
  Result := THTTPBasicAuthenticator.Create(LTimeStampRequisicao, GetMD5(LTimeStampRequisicao + ChaveAutorizacaoCitel));
end;

class function TAtualizarGatilhosWebService.GetBody: string;
var
  LQuery: TUniQuery;
  LEmpresa: string;
  LGatilho: string;
  LRelatorio: string;
  LEnviar: string;
begin
  LQuery := fCriaQuery();
  try
    LQuery.SQL.Add('SELECT ');
    LQuery.SQL.Add('  * ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  GATINF ');
    LQuery.SQL.Add('WHERE GAT_CODEMP IN ');
    LQuery.SQL.Add('  (SELECT ');
    LQuery.SQL.Add('    SRV_CODEMP ');
    LQuery.SQL.Add('  FROM ');
    LQuery.SQL.Add('    EMPRESAS_NESTE_SERVIDOR) ');
    LQuery.SQL.Add('  AND GAT_CODEMP IN ');
    LQuery.SQL.Add('  (SELECT ');
    LQuery.SQL.Add('    SIS_CODEMP ');
    LQuery.SQL.Add('  FROM ');
    LQuery.SQL.Add('    CFGSIS ');
    LQuery.SQL.Add('  WHERE SIS_CODCFG = "CFG_GATINF" ');
    LQuery.SQL.Add('    AND SIS_VALCFG = "S"); ');
    LQuery.Open;
    LQuery.First;
    Result := '';
    while not LQuery.Eof do
    begin
      LEmpresa   := LQuery.FieldByName('GAT_CODEMP').AsString;
      LGatilho   := LQuery.FieldByName('GAT_CODIGO').AsString;
      LRelatorio := LQuery.FieldByName('GAT_CODREL').AsString;
      LEnviar    := GetEnviar(LQuery.FieldByName('GAT_PROENV').AsDateTime);

      Result := Result + '  { ';
      Result := Result + '    "empresa": "'   + LEmpresa   + '", ';
      Result := Result + '    "gatilho": "'   + LGatilho   + '", ';
      Result := Result + '    "relatorio": "' + LRelatorio + '", ';
      Result := Result + '    "enviar": "'    + LEnviar    + '", ';
      Result := Result + '    "numIp": "'     + fRetNumIpDesteServidor + '", ';
      Result := Result + '    "porta": "'     + fRetPortaDesteServidor + '", ';
      Result := Result + '    "banco": "'     + fRetBancoDesteServidor + '" ';
      Result := Result + '  } ';

      if LQuery.RecNo < LQuery.RecordCount then
        Result := Result + ', ';

      LQuery.Next;
    end;
    Result := '[' + Result + ']';
  finally
    FreeAndNil(LQuery);
  end;
end;

class function TAtualizarGatilhosWebService.GetEnviar(dt: TDateTime): string;
var
  LTimeZone: string;
begin
  if fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_USATMZ']) = 'S' then
  begin
    LTimeZone := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TMZONE']);
    LTimeZone := LeftStr(LTimeZone, 1) + fStrZero(MidStr(LTimeZone, 2, 2), 2) + ':00';
  end
  else
  begin
    LTimeZone := fCampoTabela('SUBSTRING_INDEX(TIMEDIFF(nOw(), UTC_TIMESTAMP()), ":", 1)', '', [], []);
    if not LTimeZone.StartsWith('-') then
      LTimeZone := '+' + LTimeZone;
    LTimeZone := LeftStr(LTimeZone, 1) + fStrZero(MidStr(LTimeZone, 2, 2), 2) + ':00';
  end;
  Result := FormatDateTime('YYYY-MM-DD', dt) + 'T' + FormatDateTime('hh:mm:ss.zzz', dt) + LTimeZone;
end;

class procedure TGatilhosInformacao.AtualizarUltimaMsg(const ACodigo: string);
begin
  fExecutaSQL('UPDATE GATINF SET GAT_ULTMSG = "'+ TGatilhosInformacaoMonitor.Mensagens.Text.Replace('"','')
    + '" WHERE GAT_CODIGO = "'+ACodigo+'"', True);
end;

class function TGatilhosInformacao.Carregar(ACodigo: String;
  var AGatilho: TGatilhoInformacao): Boolean;
var
  qryGen: TUniQuery;
begin
  FillChar(AGatilho, SizeOf(AGatilho), #0);
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT * FROM GATINF WHERE GAT_CODIGO = "' + ACodigo + '"';
    qryGen.Open;
    if qryGen.IsEmpty then
      Exit(False);
    AGatilho.strAutInc := qryGen.FieldByName('AUTOINCREM').AsString;
    AGatilho.strCodigo := qryGen.FieldByName('GAT_CODIGO').AsString;
    AGatilho.strDescricao := qryGen.FieldByName('GAT_DESCRI').AsString;
    AGatilho.strCodigoRelatorio := qryGen.FieldByName('GAT_CODREL').AsString;
    AGatilho.strCodigoPeriodo := qryGen.FieldByName('GAT_CODPER').AsString;
    AGatilho.strCodigoOperador := qryGen.FieldByName('GAT_CODOPE').AsString;
    AGatilho.strCodigoEmpresa := qryGen.FieldByName('GAT_CODEMP').AsString;
    AGatilho.strQuandoEnviar := qryGen.FieldByName('GAT_ENVIAR').AsString;
    AGatilho.strDiasSemana := qryGen.FieldByName('GAT_DIASEM').AsString;
    AGatilho.strDiasMes := qryGen.FieldByName('GAT_DIAMES').AsString;
    AGatilho.blnWhatsApp := qryGen.FieldByName('GAT_WPPENV').AsString.Equals('S');
    AGatilho.blnEmail := qryGen.FieldByName('GAT_EMAENV').AsString.Equals('S');
    AGatilho.blnEnviarFeriados := qryGen.FieldByName('GAT_FERENV').AsString.Equals('S');
    AGatilho.blnAtivo := qryGen.FieldByName('GAT_STATUS').AsString.Equals('A');
    AGatilho.dtaHoraEnvio := qryGen.FieldByName('GAT_HORENV').AsDateTime;
    AGatilho.strRelatorioStatus := qryGen.FieldByName('GAT_RELSTA').AsString;
    AGatilho.strRelatorioTipo := qryGen.FieldByName('GAT_RELTIP').AsString;
    AGatilho.blnEditouFiltrosRelatorio := True;
    Result := True;
  finally
    FreeAndNil(qryGen);
  end;
end;

class function TGatilhosInformacao.Copiar(ACodigo: String;
  var AGatilho: TGatilhoInformacao): Boolean;
var
  qryGen: TUniQuery;
begin
  FillChar(AGatilho, SizeOf(AGatilho), #0);
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT * FROM GATINF WHERE GAT_CODIGO = "' + ACodigo + '"';
    qryGen.Open;
    if qryGen.IsEmpty then
      Exit(False);
    AGatilho.strDescricao := qryGen.FieldByName('GAT_DESCRI').AsString;
    AGatilho.strCodigoRelatorio := qryGen.FieldByName('GAT_CODREL').AsString;
    AGatilho.strCodigoPeriodo := qryGen.FieldByName('GAT_CODPER').AsString;
    AGatilho.strCodigoEmpresa := qryGen.FieldByName('GAT_CODEMP').AsString;
    AGatilho.strQuandoEnviar := qryGen.FieldByName('GAT_ENVIAR').AsString;
    AGatilho.strDiasSemana := qryGen.FieldByName('GAT_DIASEM').AsString;
    AGatilho.strDiasMes := qryGen.FieldByName('GAT_DIAMES').AsString;
    AGatilho.blnWhatsApp := qryGen.FieldByName('GAT_WPPENV').AsString.Equals('S');
    AGatilho.blnEmail := qryGen.FieldByName('GAT_EMAENV').AsString.Equals('S');
    AGatilho.blnEnviarFeriados := qryGen.FieldByName('GAT_FERENV').AsString.Equals('S');
    AGatilho.blnAtivo := qryGen.FieldByName('GAT_STATUS').AsString.Equals('A');
    AGatilho.dtaHoraEnvio := qryGen.FieldByName('GAT_HORENV').AsDateTime;
    AGatilho.strRelatorioStatus := qryGen.FieldByName('GAT_RELSTA').AsString;
    AGatilho.strRelatorioTipo := qryGen.FieldByName('GAT_RELTIP').AsString;
    AGatilho.blnCopiar := True;
    Result := True;
  finally
    FreeAndNil(qryGen);
  end;
end;

class function TGatilhosInformacao.Excluir(const ACodigo: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT * FROM GATINF WHERE GAT_CODIGO = "' + ACodigo + '"';
    qryGen.Open;
    if qryGen.IsEmpty then
      Exit(False);
    qryGen.Delete;
    Result := True;
  finally
    FreeAndNil(qryGen);
  end;
end;

class function TGatilhosInformacao.JaFoiEnviado(const ACodigo: string): Boolean;
var
  LUltimoEnvio: TDateTime;
begin
  try
    LUltimoEnvio := fCampoTabela('GAT_ULTENV', 'GATINF', ['GAT_CODIGO'], [ACodigo]);
    Result := Floor(LUltimoEnvio) = Floor(fRetDtaHraServidor);
  except
    Result := False;
  end;
end;

function TGatilhoInformacao.EditarFiltrosRelatorio: Boolean;
var
  strUsuarioLogado: string;
  strEmpresaLogada: string;
  strDataInicial: string;
  strDataFinal: string;
begin
  Result := False;
  Self.blnEditouFiltrosRelatorio := False;

  if not fValidarDireitoAcessoOperadorRelatorio then
  begin
    if not fVerificaAcessoSistema('frmDirAcesso', strLoginUsuarioLogado) then
      Exit;

    if not fExecutarModal(pAbrirDireitoDeAcessoRelatorio, 'Carregando Direitos de Acesso (AUTCOM), Aguarde ...', '') then
      Exit;

    if not fValidarDireitoAcessoOperadorRelatorio then
      Exit;
  end;

  strUsuarioLogado := strLoginUsuarioLogado;
  strEmpresaLogada := VS_strCodEmp;
  try
    if VS_strCodEmp <> Self.strCodigoEmpresa then
    begin
      pSetaEmpresaLogada(Self.strCodigoEmpresa);
      fAjustaDataSistema;
      pAtuVarGlobais;
    end;

    strLoginUsuarioLogado := Self.strCodigoOperador;
    pCarregarVariaveisUsuarioLogado;

    Self.AtualizarFiltrosPeriodo(strDataInicial, strDataFinal);
    Self.AtualizarFiltrosDestino;

    Result := TRelatorio.fEditarFiltrosRelatorio(Self.strCodigoRelatorio,
                                                ['DTAINI', 'DTAFIN'],
                                                 strDirAce,
                                                 Self.strTabelaFiltros);
    Self.blnEditouFiltrosRelatorio := Result;
  finally
    if VS_strCodEmp <> strEmpresaLogada then
    begin
      pSetaEmpresaLogada(strEmpresaLogada);
      fAjustaDataSistema;
      pAtuVarGlobais;
    end;
    strLoginUsuarioLogado := strUsuarioLogado;
    pCarregarVariaveisUsuarioLogado;
  end;
end;

procedure TGatilhoInformacao.EnviarRelatorioPorEmail;
const
  IMG_CORPO_EMAIL = '<P><IMG border=0 hspace=0 alt="" src="%s" align=baseline></P>';
var
  strEmailDestino, strMensagem: string;

  LArquivos: TArray<TRecArquivosGatilhos>;
  LDadosEnviaGatilhoEmail: TDadosEnviaGatilhoEmail;

  strArquivoBase64: String;
begin
  strEmailDestino := fRetEmailOperador(strCodigoOperador);

  if fEmptyStr(strEmailDestino) then
    Exit;

  if (not FileExists(strArquivoSaidaPDF)) and (fEmptyStr(strUrlGrafico)) then
    Exit;

  if FileExists(strArquivoSaidaPDF) then
  begin
    SetLength(LArquivos, Length(LArquivos)+1);
    LArquivos[High(LArquivos)] := TRecArquivosGatilhos.Create(fTiraCaracEspeciais(strDescricao, True, False, False, True, False, True),
                                                              strArquivoSaidaPDF,
                                                              EmptyStr);
  end;

  LDadosEnviaGatilhoEmail := TDadosEnviaGatilhoEmail.Create;
  try
    strMensagem := IIF(FileExists(strArquivoSaidaPDF),
                       Format(IMG_CORPO_EMAIL, [recImagemCorpoEmail.strArquivo]),
                       Format(IMG_CORPO_EMAIL, [recImagemCorpoEmailDashboard.strArquivo]) + '<a href="'+ strUrlGrafico + '">Veja aqui</a>');

    LDadosEnviaGatilhoEmail.operador.codigoOperador := fCfgSis('GATOPE');
    LDadosEnviaGatilhoEmail.operador.nomeOperador := fRetNomeOperador(LDadosEnviaGatilhoEmail.operador.codigoOperador);

    if FileExists(strArquivoSaidaPDF) then
      strArquivoBase64 := fRetornarArquivoBase64(recImagemCorpoEmail.strArquivo)
    else
      strArquivoBase64 := fRetornarArquivoBase64(recImagemCorpoEmailDashboard.strArquivo);

    LDadosEnviaGatilhoEmail.email.pAddImagemCorpo(TDadosImagemCorpo
                                                    .fNew
                                                    .fPath(IIF(FileExists(strArquivoSaidaPDF), recImagemCorpoEmail.strArquivo, recImagemCorpoEmailDashboard.strArquivo))
                                                    .fBase64(strArquivoBase64)
                                                  );

    TDllGatime
      .fNew
      .fGravarGatilhoImediato(TRecGatilhoImediato
                                .Create(strDescricao,
                                        strMensagem,
                                        LArquivos,
                                        LDadosEnviaGatilhoEmail.ToJsonString,
                                        fCfgSis('GATOPE'),
                                        EmptyStr,
                                        strEmailDestino)
                              );
  finally
    FreeAndNil(LDadosEnviaGatilhoEmail);
  end;
end;

procedure TGatilhoInformacao.EnviarRelatorioPorWhatsApp;
var
  LArquivos: TArray<TRecArquivosGatilhos>;
  LWppDest: string;
  strDataInicial: string;
  strDataFinal: string;
  strDataRelatorio: string;
begin
  LWppDest := fCampoTabela('OPE_NUMWPP', 'CADOPE', ['OPE_CODOPE'], [strCodigoOperador]);

  if fEmptyStr(LWppDest) then
    Exit;

  if (not FileExists(strArquivoSaidaPDF)) and (fEmptyStr(strUrlGrafico)) then
    Exit;

  if (not FileExists(strArquivoSaidaPDF)) and (not fEmptyStr(strUrlGrafico)) then
  Begin
    GetDataRelatorio(strDataInicial, strDataFinal, strDataRelatorio);

    recImagemCorpoWhatsAppDashboard := TfrmGatilhosInformacaoImagemAnexoDashboard.GetImagemResizeJPEG(strDescricao,
      strRelatorioStatus, strRelatorioTipo, fRetFantasiaEmpresa, strDataRelatorio,
      fGetUniqueTempPath('.jpeg'));
  end;

  SetLength(LArquivos, Length(LArquivos)+1);
  LArquivos[High(LArquivos)] := TRecArquivosGatilhos.Create(fTiraCaracEspeciais(strDescricao, True, False, False, True, False, True),
                                                            IIF(FileExists(strArquivoSaidaPDF), strArquivoSaidaPDF, recImagemCorpoWhatsAppDashboard.strArquivo),
                                                            EmptyStr,
                                                            IIF(FileExists(strArquivoSaidaPDF), tpaPDF, tpaImagemJpeg));

  TDllGatime
    .fNew
    .fGravarGatilhoImediato(TRecGatilhoImediato
                              .Create(strDescricao,
                                      IIF(FileExists(strArquivoSaidaPDF), EmptyStr, strUrlGrafico),
                                      LArquivos,
                                      strJsonDadosEnviaWhatsapp,
                                      fCfgSis('GATOPE'),
                                      LWppDest,
                                      EmptyStr)
                            );
end;

function TGatilhoInformacao.ExecutarRelatorioParaEmail(blnTesteEmail: boolean = False): Boolean;
var
  strUsuarioLogado: string;
  strEmpresaLogada: string;
  strDataInicial: string;
  strDataFinal: string;
  strDataRelatorio: string;
begin
  if not blnEmail then
    if not blnTesteEmail then
      Exit(True);

  if not fOperadorAtivo(fCfgSis('GATOPE')) then
  begin
    pMensagemOk('Operador configurado para envio dos gatilhos de ' +
      'informação está inativo. Favor verificar o operador "' +
      fCfgSis('GATOPE')+'" configurado em CFG_GATOPE!');
    Exit(False);
  end;

  Result := False;

  strUsuarioLogado := strLoginUsuarioLogado;
  strEmpresaLogada := VS_strCodEmp;

  try
    if VS_strCodEmp <> Self.strCodigoEmpresa then
    begin
      pSetaEmpresaLogada(Self.strCodigoEmpresa);
      fAjustaDataSistema;
      pAtuVarGlobais;
    end;

    strLoginUsuarioLogado := Self.strCodigoOperador;
    pCarregarVariaveisUsuarioLogado;

    if not fValidarDireitoAcessoOperadorRelatorio then
      Exit;

    Self.AtualizarFiltrosPeriodo(strDataInicial, strDataFinal);
    If (Pos('PDF', fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio])) > 0) Then
    Begin
      Self.AtualizarFiltrosDestino;

      Self.strArquivoSaidaPDF := TPath.GetTempPath + '\Rel' +
        strCodigoRelatorio + strCodigoOperador + Random(99999).ToString() + '.pdf';

      if FileExists(Self.strArquivoSaidaPDF) then
        TFile.Delete(Self.strArquivoSaidaPDF);

      GetDataRelatorio(strDataInicial, strDataFinal, strDataRelatorio);

      recImagemCorpoEmail := TfrmGatilhosInformacaoImagemAnexo.GetImagem(strDescricao,
        strRelatorioStatus, strRelatorioTipo, fRetFantasiaEmpresa, strDataRelatorio,
        TPath.GetTempFileName + '.jpeg');

      TRelatorio.pExecutaRelatorio(strCodigoRelatorio,
                                  ['DTAINI', 'DTAFIN'],
                                   True,
                                   True,
                                   strDirAce,
                                   False,
                                   True,
                                   Self.strTabelaFiltros,
                                   Self.strArquivoSaidaPDF);

      Result := FileExists(Self.strArquivoSaidaPDF);

      If Not Result Then
        Exit;
    End
    Else if (Pos('Dashboard', fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio])) > 0) then
    Begin
      GetDataRelatorio(strDataInicial, strDataFinal, strDataRelatorio);

      recImagemCorpoEmailDashboard := TfrmGatilhosInformacaoImagemAnexoDashboard.GetImagem(strDescricao,
        strRelatorioStatus, strRelatorioTipo, fRetFantasiaEmpresa, strDataRelatorio,
        TPath.GetTempFileName + '.jpeg');

      strUrlGrafico := TRelatorio.fRetornaUrlDashBoardGatilho(strCodigoRelatorio,
                                                              ['DTAINI', 'DTAFIN'],
                                                              True,
                                                              strDirAce,
                                                              False,
                                                              True,
                                                              Self.strTabelaFiltros,
                                                              Self.strArquivoSaidaPDF,
                                                              recImagemCorpoWhatsApp.strArquivo);

      Result := Not fEmptyStr(strUrlGrafico);

      If fEmptyStr(strUrlGrafico) Then
        Exit;
    End;

    strLoginUsuarioLogado := fCfgSis('GATOPE');

    pCarregarVariaveisUsuarioLogado;

    try
      EnviarRelatorioPorEmail;
    finally
      if FileExists(Self.strArquivoSaidaPDF) then
        TFile.Delete(Self.strArquivoSaidaPDF);
    end;

  finally
    if VS_strCodEmp <> strEmpresaLogada then
    begin
      pSetaEmpresaLogada(strEmpresaLogada);
      fAjustaDataSistema;
      pAtuVarGlobais;
    end;
    strLoginUsuarioLogado := strUsuarioLogado;
    pCarregarVariaveisUsuarioLogado;
  end;
end;

function TGatilhoInformacao.ExecutarRelatorioParaWhatsApp(blnTesteWhatsApp: boolean = False): Boolean;
var
  strUsuarioLogado: string;
  strEmpresaLogada: string;
  strDataInicial: string;
  strDataFinal: string;
  strDataRelatorio: string;
begin
  if not blnWhatsApp then
    if not blnTesteWhatsApp then
      Exit(True);

  Result := False;

  strUsuarioLogado := strLoginUsuarioLogado;
  strEmpresaLogada := VS_strCodEmp;

  try
    if VS_strCodEmp <> Self.strCodigoEmpresa then
    begin
      pSetaEmpresaLogada(Self.strCodigoEmpresa);
      fAjustaDataSistema;
      pAtuVarGlobais;
    end;

    strLoginUsuarioLogado := Self.strCodigoOperador;
    pCarregarVariaveisUsuarioLogado;

    if not fValidarDireitoAcessoOperadorRelatorio then
      Exit;

    Self.AtualizarFiltrosPeriodo(strDataInicial, strDataFinal);
    If (Pos('PDF', fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio])) > 0) Then
    Begin
      Self.AtualizarFiltrosDestino;

      Self.strArquivoSaidaPDF := TPath.GetTempPath + '\Rel' +
        strCodigoRelatorio + strCodigoOperador + Random(99999).ToString() + '.pdf';

      if FileExists(Self.strArquivoSaidaPDF) then
        TFile.Delete(Self.strArquivoSaidaPDF);

      GetDataRelatorio(strDataInicial, strDataFinal, strDataRelatorio);

      recImagemCorpoWhatsApp := TfrmGatilhosInformacaoImagemAnexo.GetImagem(strDescricao,
        strRelatorioStatus, strRelatorioTipo, fRetFantasiaEmpresa, strDataRelatorio,
        TPath.GetTempFileName + '.jpeg');

      TRelatorio.pExecutaRelatorio(strJsonDadosEnviaWhatsapp,
                                   strCodigoRelatorio,
                                  ['DTAINI', 'DTAFIN'],
                                   True,
                                   False,
                                   strDirAce,
                                   False,
                                   True,
                                   Self.strTabelaFiltros,
                                   Self.strArquivoSaidaPDF,
                                   recImagemCorpoWhatsApp.strArquivo);

      Result := FileExists(Self.strArquivoSaidaPDF);

      If Result And (fTamanhoArquivo(Self.strArquivoSaidaPDF, ttKByte) > 2560) Then
      Begin
        If (blnTesteWhatsApp) Then
          pMensagemOk('Arquivo com tamanho superior a 2.5 MB. Verifique os Filtros');

        TGatilhosInformacaoMonitor.Mensagens.Text := 'Arquivo com tamanho superior a 2.5 MB. Verifique os Filtros';
        Result := True;
        Exit;
      End;

      If Not Result Then
        Exit;
    End
    Else if (Pos('Dashboard', fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio])) > 0) then
    Begin
       strUrlGrafico := TRelatorio.fRetornaUrlDashBoardGatilho(strJsonDadosEnviaWhatsapp,
                                                               strCodigoRelatorio,
                                                               ['DTAINI', 'DTAFIN'],
                                                               True,
                                                               strDirAce,
                                                               False,
                                                               True,
                                                               Self.strTabelaFiltros,
                                                               Self.strArquivoSaidaPDF,
                                                               recImagemCorpoWhatsApp.strArquivo);
       Result := Not fEmptyStr(strUrlGrafico);

       If fEmptyStr(strUrlGrafico) Then
        Exit;
    End;

    strLoginUsuarioLogado := fCfgSis('GATOPE');

    pCarregarVariaveisUsuarioLogado;

    try
      EnviarRelatorioPorWhatsApp;
    finally
      if FileExists(Self.strArquivoSaidaPDF) then
        TFile.Delete(Self.strArquivoSaidaPDF);
    end;

  finally
    if VS_strCodEmp <> strEmpresaLogada then
    begin
      pSetaEmpresaLogada(strEmpresaLogada);
      fAjustaDataSistema;
      pAtuVarGlobais;
    end;
    strLoginUsuarioLogado := strUsuarioLogado;
    pCarregarVariaveisUsuarioLogado;
  end;
end;

function TGatilhoInformacao.fTemFiltroDataFinal: Boolean;
var
  strAutInc: String;
begin
  strAutInc := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio]);
  Result := fCampoTabela('AUTOINCREM', 'CADPRR', ['PAR_SEQGER', 'PAR_NOMPAR'], [strAutInc, 'DTAFIN']) <> '';
end;

function TGatilhoInformacao.fTemFiltroDataInicial: Boolean;
var
  strAutInc: String;
begin
  strAutInc := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio]);
  Result := fCampoTabela('AUTOINCREM', 'CADPRR', ['PAR_SEQGER', 'PAR_NOMPAR'], [strAutInc, 'DTAINI']) <> '';
end;

function TGatilhoInformacao.fTemGatPerPreenchida: Boolean;
var
  LPeriodos: TGatilhoPeriodos;
begin
  Try
    Result := True;

    LPeriodos := TGatilhoPeriodos.Create;

    If LPeriodos.FList.Count = 0 then
     Result := False
  Except
    Result := False
  End;
end;

function TGatilhoInformacao.fValidarDireitoAcessoOperadorRelatorio: Boolean;
begin
  //Se existir no menu entao entao deve verificar o direito de acesso do operador
  Self.strDirAce := fCampoTabela('"frm' + Self.strCodigoRelatorio + 'Rel"', 'RELMEN', ['MEN_CODREL'], [Self.strCodigoRelatorio]);

  if fEmptyStr(Self.strDirAce) then
    Self.strDirAce := fCampoTabela('REL_DIRANT', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio]);

  if not strDirAce.IsEmpty then
    if not fVerificaAcessoSistema(Self.strDirAce, Self.strCodigoOperador) then
    begin
      pMensagemOk('Operador não tem direito de acesso ao relatório!');
      Exit(False);
    end;

  Result := True;
end;

procedure TGatilhoInformacao.LiberarFiltros;
begin
  if fTabelaExiste(strTabelaFiltros) then fDropTable(strTabelaFiltros);
end;

class function TGatilhosInformacao.Salvar(var AGatilho: TGatilhoInformacao): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := False;
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT * FROM GATINF WHERE GAT_CODIGO = "' + AGatilho.strCodigo + '"';
    qryGen.Open;
    if not AGatilho.strCodigo.IsEmpty and qryGen.IsEmpty then
      Raise Exception.Create('Não existe um gatilho com o código  "' + AGatilho.strCodigo + '"');
    if qryGen.IsEmpty then
    begin
      qryGen.Append;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoincrem('GATINF', VS_strCodEmp);
      qryGen.FieldByName('GAT_CODIGO').AsString := fAtualizaProCod('GATINF', 'GAT_CODIGO', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := fPadL(AValue, 6, '0');
        end
      );
      AGatilho.strAutInc := qryGen.FieldByName('AUTOINCREM').AsString;
      AGatilho.strCodigo := qryGen.FieldByName('GAT_CODIGO').AsString;
    end
    else
      qryGen.Edit;

    qryGen.FieldByName('GAT_DESCRI').AsString := AGatilho.strDescricao;
    qryGen.FieldByName('GAT_CODREL').AsString := AGatilho.strCodigoRelatorio;

    if fEmptyStr(AGatilho.strCodigoPeriodo) then
      qryGen.FieldByName('GAT_CODPER').Clear
    else
      qryGen.FieldByName('GAT_CODPER').AsString := AGatilho.strCodigoPeriodo;

    qryGen.FieldByName('GAT_CODOPE').AsString := AGatilho.strCodigoOperador;
    qryGen.FieldByName('GAT_CODEMP').AsString := AGatilho.strCodigoEmpresa;
    qryGen.FieldByName('GAT_ENVIAR').AsString := AGatilho.strQuandoEnviar;
    qryGen.FieldByName('GAT_DIASEM').AsString := AGatilho.strDiasSemana;
    qryGen.FieldByName('GAT_DIAMES').AsString := AGatilho.strDiasMes;
    qryGen.FieldByName('GAT_RELSTA').AsString := AGatilho.strRelatorioStatus;
    qryGen.FieldByName('GAT_RELTIP').AsString := AGatilho.strRelatorioTipo;
    qryGen.FieldByName('GAT_WPPENV').AsString := IIF(AGatilho.blnWhatsApp, 'S', 'N');
    qryGen.FieldByName('GAT_EMAENV').AsString := IIF(AGatilho.blnEmail, 'S', 'N');
    qryGen.FieldByName('GAT_FERENV').AsString := IIF(AGatilho.blnEnviarFeriados, 'S', 'N');
    qryGen.FieldByName('GAT_STATUS').AsString := IIF(AGatilho.blnAtivo, 'A', 'I');
    qryGen.FieldByName('GAT_HORENV').AsDateTime := AGatilho.dtaHoraEnvio;
    qryGen.Post;
    AGatilho.SalvarFiltros;
    AtualizarDataProximoEnvio(AGatilho.strCodigo);
    Result := True;
  finally
    FreeAndNil(qryGen);
  end;
end;

class function TGatilhosInformacao.ValidarRelatorio(const ACodigo: string): Boolean;
var
  strAutInc: String;
begin
  strAutInc := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [ACodigo]);
  if fEmptyStr(strAutInc) then
  begin
    pMensagemOk('Relatório não encontrado com este código!');
    Result := False;
  end
  else if (fCampoTabela('REL_GATINF', 'CADREL', ['REL_CODREL'], [ACodigo]) <> 'S') Then
  begin
    pMensagemOk('Este relatório não foi configurado para ser utilizado nos Gatilhos de Informação!');
    Result := False;
  end
  else if ((Pos('PDF', fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [ACodigo])) = 0) and
    (Pos('Dashboard', fCampoTabela('REL_DESTIN', 'CADREL', ['REL_CODREL'], [ACodigo])) = 0)) Then
  begin
    pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
      'quando possuir como um dos destinos a opção "PDF"!');
    Result := False;
  end
{  else if (fCampoTabela('AUTOINCREM', 'CADPRR', ['PAR_SEQGER', 'PAR_NOMPAR'], [strAutInc, 'DTAINI']) = '') Then
  begin
    pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
      'quando possuir o filtro de "Data Inicial - DTAINI"!');
    Result := False;
  end
  else if (fCampoTabela('AUTOINCREM', 'CADPRR', ['PAR_SEQGER', 'PAR_NOMPAR'], [strAutInc, 'DTAFIN']) = '') Then
  begin
    pMensagemOk('Um relatório somente pode ser utilizado nos "Gatilhos de Informação" '+
      'quando possuir o filtro de "Data Final - DTAFIN"!');
    Result := False;
  end}
  else
    Result := True;
end;

{ TGatilhoPeriodos }

procedure TGatilhoPeriodos.CarregarPeriodos;
var
  qryGen: TUniQuery;
  LPeriodo: TGatilhoPeriodo;
begin
  FList := TList<TGatilhoPeriodo>.Create;
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT * FROM GATPER ORDER BY GPE_CODIGO';
    qryGen.Open;
    qryGen.First;
    while not qryGen.Eof do
    begin
      LPeriodo.strCodigo := qryGen.FieldByName('GPE_CODIGO').AsString;
      LPeriodo.strDescricao := qryGen.FieldByName('GPE_DESCRI').AsString;
      LPeriodo.strSQLDataInicial := qryGen.FieldByName('GPE_DTAINI').AsString;
      LPeriodo.strSQLDataFinal := qryGen.FieldByName('GPE_DTAFIN').AsString;
      FList.Add(LPeriodo);
      qryGen.Next;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

constructor TGatilhoPeriodos.Create;
begin
  CarregarPeriodos;
end;

destructor TGatilhoPeriodos.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TGatilhoPeriodos.FindByCodigo(ACodigo: string): TGatilhoPeriodo;
var
  LPeriodo: TGatilhoPeriodo;
begin
  for LPeriodo in Self.FList do
    if LPeriodo.strCodigo.Equals(ACodigo) then
      Exit(LPeriodo);
end;

{ TGatilhoInformacao }

procedure TGatilhoInformacao.pAbrirDireitoDeAcessoRelatorio;
begin
  If fInTransaction() Then
    Exit;

  If Not fVerificaAcessoSistema('frmDirAcesso', strLoginUsuarioLogado) Then
    Exit;

  TfrmPermissaoAcesso.EditarPermissoes(strDirAce);

  TPermissoesAcesso.GetInstance.pLimpar;
end;

procedure TGatilhoInformacao.GetDataRelatorio(strDataInicial, strDataFinal: string; var strDataRelatorio: string);
begin
  if strDataInicial = strDataFinal then
    strDataFinal := '';
  if (strDataInicial <> '') and (strDataFinal <> '') then
  begin
    strDataRelatorio := strDataInicial + ' até ' + strDataFinal;
  end
  else if (strDataInicial <> '') then
  begin
    strDataRelatorio := strDataInicial;
  end
  else if (strDataFinal <> '') then
  begin
    strDataRelatorio := strDataFinal;
  end
  else
  begin
    strDataRelatorio := DateTimeToStr(VS_Date);
  end;
  if StrToDateDef(strDataRelatorio, 0) = VS_Date then
    strDataRelatorio := strDataRelatorio + ' até ' + FormatDateTime('hh', fNow) + 'h' + FormatDateTime('mm', fNow);
end;

procedure TGatilhoInformacao.pAtualizarFiltro(AFiltro: string; AValor: string);
var
  qryGen: TUniQuery;
  strSeqGer: string;
begin
  strSeqGer := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [Self.strCodigoRelatorio]);
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := 'SELECT * FROM ' + Self.strTabelaFiltros;
    qryGen.Open;
    if qryGen.Locate('VAL_NOMPAR', AFiltro, []) then
      qryGen.Edit
    else
      qryGen.Append;
    qryGen.FieldByName('VAL_NOMPAR').AsString := AFiltro;
    qryGen.FieldByName('VAL_MULSEL').AsString := 'N';
    qryGen.FieldByName('VAL_SEQGER').AsString := strSeqGer;
    qryGen.FieldByName('VAL_SEQGAT').AsString := Self.strAutInc;
    qryGen.FieldByName('VAL_CODOPE').AsString := Self.strCodigoOperador;
    qryGen.FieldByName('VAL_ULTVAL').AsString := AValor;
    qryGen.Post;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TGatilhoInformacao.AtualizarFiltrosDestino;
begin
  pAtualizarFiltro('DESTINO_REL', 'PDF');
end;

procedure TGatilhoInformacao.AtualizarFiltrosPeriodo(var strDtaIni, strDtaFin: string);
var
  LPeriodos: TGatilhoPeriodos;
begin
  strDtaIni := '';
  strDtaFin := '';
  if not fTabelaExiste(Self.strTabelaFiltros) then Exit;
  LPeriodos := TGatilhoPeriodos.Create;
  try
    if fTemFiltroDataInicial then
      if LPeriodos.FindByCodigo(Self.strCodigoPeriodo).strSQLDataInicial <> EmptyStr then
      begin
        strDtaIni := DateTimeToStr(LPeriodos.FindByCodigo(Self.strCodigoPeriodo).GetDataInicial);
        pAtualizarFiltro('DTAINI', DateTimeToStr(LPeriodos.FindByCodigo(Self.strCodigoPeriodo).GetDataInicial));
      end;

    if fTemFiltroDataFinal then
      if LPeriodos.FindByCodigo(Self.strCodigoPeriodo).strSQLDataFinal <> EmptyStr then
      begin
        strDtaFin := DateTimeToStr(LPeriodos.FindByCodigo(Self.strCodigoPeriodo).GetDataFinal);
        pAtualizarFiltro('DTAFIN', DateTimeToStr(LPeriodos.FindByCodigo(Self.strCodigoPeriodo).GetDataFinal));
      end;
  finally
    FreeAndNil(LPeriodos);
  end;
end;

procedure TGatilhoInformacao.CarregarFiltros;
begin
  LiberarFiltros;
  repeat
    strTabelaFiltros := 'TMP_CADVAL' + fRetSeqTmp;
  until (Not fTabelaExiste(strTabelaFiltros));
  fExecutaSQL('CREATE TABLE ' + strTabelaFiltros +
    ' SELECT * FROM GATVAL WHERE VAL_SEQGAT = "' + strAutInc + '"', True);
  fExecutaSQL('ALTER TABLE ' + strTabelaFiltros + ' ADD UNIQUE KEY IDX_' +
    strTabelaFiltros +'_01 (VAL_SEQGER, VAL_CODOPE, VAL_NOMPAR)', True);
end;

procedure TGatilhoInformacao.SalvarFiltros;
begin
  if not fTabelaExiste(strTabelaFiltros) then Exit;
  fExecutaSQL('UPDATE ' + strTabelaFiltros + ' SET VAL_SEQGAT = "' + strAutInc + '"', True);
  fExecutaSQL('REPLACE INTO GATVAL SELECT * FROM ' + strTabelaFiltros, True);
  LiberarFiltros;
end;

procedure TGatilhoInformacao.TestarEnviarRelatorioPorEmail;
begin
  Self.ExecutarRelatorioParaEmail(True);
end;

procedure TGatilhoInformacao.TestarEnviarRelatorioPorWhatsApp;
begin
  Self.ExecutarRelatorioParaWhatsApp(True);
end;

function TGatilhoInformacao.ValidarFiltrosRelatorio: Boolean;
begin
  Result := False;

  if not fTabelaExiste(Self.strTabelaFiltros) then
    Exit;

  if fTabelaVazia(Self.strTabelaFiltros) then
    Exit;

  Result := Self.blnEditouFiltrosRelatorio;
end;

{ TGatilhoPeriodo }

function TGatilhoPeriodo.GetDataFinal: TDateTime;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := strSQLDataFinal;
    qryGen.Open;
    Result := qryGen.Fields[0].AsDateTime;
  finally
    FreeAndNil(qryGen);
  end;
end;

function TGatilhoPeriodo.GetDataInicial: TDateTime;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Text := strSQLDataInicial;
    qryGen.Open;
    Result := qryGen.Fields[0].AsDateTime;
  finally
    FreeAndNil(qryGen);
  end;
end;

{ TGatilhosInformacaoMonitor }

constructor TGatilhosInformacaoMonitor.Create(ACodigo: string);
begin
  FCodigo := ACodigo;
end;

class procedure TGatilhosInformacaoMonitor.ExecutarRobo;
Var
  LId: String;
begin
  If Not fPodeExecutar Then
    Exit;

  If RunningInTSPlus Then
    Exit;

  LId := Format(IdMonitorGatilhosInformacao, [VS_strCodEmp]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorGatilhosInformacao,
    TimeLimitMonitorGatilhosInformacao, VS_objProcessoMonitorGatilhosInformacao,
    VS_dtaUltimaExecucaoMonitorGatilhosInformacao);

  If fQuantidadeRobosDeMonitaramentoExecutando(Format(IdMonitorGatilhosInformacao, ['%'])) = 0 Then
    TUtilMonitor.pRunMonitor(LId, VS_objProcessoMonitorGatilhosInformacao,
      VS_dtaUltimaExecucaoMonitorGatilhosInformacao, ExtractFileName(ParamStr(0)),
        Concat(GatilhosInformacaoMonitorExeParam, ' ', VS_strCodEmp));

  TUtilMonitor.pClearAttemptsLock(LId, AttemptsLockMonitorGatilhosInformacao);
end;

function TGatilhosInformacaoMonitor.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

class function TGatilhosInformacaoMonitor.fPodeExecutar: Boolean;
begin
  If Not fCfgSis('GATINF', varBoolean) Then
    Exit(False);

  If fEmptyStr(fRetNomeOperador(fCfgSis('GATOPE'))) Then
    Exit(False);

  If fEmptyStr(fCfgSis('GATURL')) Then
    Exit(False);

  If fTabelaVazia('GATINF') then
    Exit(False);

  Result := True;
end;

class function TGatilhosInformacaoMonitor.New(ACodigo: string): IMonitorProcedure;
begin
  Result := TGatilhosInformacaoMonitor.Create(ACodigo);
end;

procedure TGatilhosInformacaoMonitor.pExecute;
var
  LLckKey: string;
  LGatilho: TGatilhoInformacao;
begin
  If Not fPodeExecutar Then
    Exit;
  Self.ClearLog;
  LLckKey := 'GATINF_' + FCodigo;
  pDestravaLockForcado(LLckKey, AttemptsLockMonitorGatilhosInformacao);
  If fLock_Unlock(LLckKey, True, False, False, '', False) Then
  Begin
    Try
      If TGatilhosInformacao.Carregar(FCodigo, LGatilho) then
      Begin
        LGatilho.CarregarFiltros;
        Try
          If not LGatilho.fTemGatPerPreenchida then
          Begin
            TGatilhosInformacaoMonitor.Mensagens.Text := 'Não existem Períodos de envio de gatilho cadastrados.';
            TGatilhosInformacao.AtualizarDataEnvio(FCodigo);
          End
          Else If fEhFeriado(fRetDataServidor) And Not LGatilho.blnEnviarFeriados Then
          Begin
            TGatilhosInformacaoMonitor.Mensagens.Text := 'Gatilho não executa em Feriados';
            TGatilhosInformacao.AtualizarDataEnvio(FCodigo);
          End
          Else If TGatilhosInformacao.JaFoiEnviado(FCodigo) Then
          Begin
            TGatilhosInformacaoMonitor.Mensagens.Text := 'Gatilho já foi enviado';
            TGatilhosInformacao.AtualizarDataProximoEnvio(FCodigo, IncDay(fRetDataServidor, 1));
          End
          Else If LGatilho.ExecutarRelatorioParaEmail And LGatilho.ExecutarRelatorioParaWhatsApp Then
          Begin
            If TGatilhosInformacaoMonitor.Mensagens.Text.Trim.IsEmpty Then
              TGatilhosInformacaoMonitor.Mensagens.Text := 'Mensagem enviada com sucesso!';
            TGatilhosInformacao.AtualizarDataEnvio(FCodigo);
          End
          Else If Self.Mensagens.Text.Contains(MSG_SEM_DADOS_PARA_GERAR_RELATORIO) Then
          Begin
            TGatilhosInformacaoMonitor.Mensagens.Text := MSG_SEM_DADOS_PARA_GERAR_RELATORIO;
            TGatilhosInformacao.AtualizarDataEnvio(FCodigo);
          End
          Else
            Sleep(5000);
          TGatilhosInformacao.AtualizarUltimaMsg(FCodigo);
        Finally
          LGatilho.LiberarFiltros;
        End;
        pZerarTentativasLock(LLckKey);
        pTrimAppMemorySize();
      End;
      Sleep(3000);
    Finally
      fLock_Unlock(LLckKey, False, False, False, '', False);
    End;
  End;
end;

procedure TGatilhosInformacaoMonitor.pExecuteAll;
var
  LQuery: TUniQuery;
begin
  If Not fPodeExecutar Then
    Exit;
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Add(SQL_GATILHOS_PENDENTES);
    LQuery.Open();
    While (Not LQuery.Eof) Do
    Begin
      If LQuery.FieldByName('GAT_PROENV').AsDateTime < fRetDataServidor Then
      Begin
        TGatilhosInformacao.AtualizarDataEnvio(LQuery.FieldByName('GAT_CODIGO').AsString);
        Sleep(1000);
      End
      Else If LQuery.FieldByName('GAT_PROENV').AsDateTime < fRetDtaHraServidor Then
      Begin
        TGatilhosInformacaoMonitor.New(LQuery.FieldByName('GAT_CODIGO').AsString).pExecute();
        Sleep(1000);
      End;
      LQuery.Next();
    End;
    If MinutesBetween(fNow(), FLastWS) >= 3 Then
    Begin
      TAtualizarGatilhosWebService.Execute;
      FLastWS := fNow();
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TGatilhosInformacaoMonitor.AddLog(AText: String);
begin
  TGatilhosInformacaoMonitor.Mensagens.Add(DateTimeToStr(fNow) + ' - ' + AText);
end;

procedure TGatilhosInformacaoMonitor.ClearLog;
begin
  Self.Mensagens.Clear;
end;

initialization
  TGatilhosInformacaoMonitor.Mensagens := TStringList.Create;

finalization
  FreeAndNil(TGatilhosInformacaoMonitor.Mensagens);

end.

