unit untProcessaGatilhosImediatos;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  untUtilMonitor, Winapi.Windows,
  untImagemBase64, Vcl.Graphics,
{$ENDIF}
  Data.DB, System.Classes, Uni, System.SysUtils, IOUtils, untTEnvioEmail, untTEnvioSMS, untMkmServiceSms,
  untTypesSistema, System.NetEncoding, System.StrUtils, untConstantes, System.DateUtils,
  untQualiZapUploadFile, Rest.Json, untDadosEnviaGatilhoEmail, System.JSON,
  untDadosEnviaGatilhoWhatsapp, untDadosEnviaGatilhoSms;

Const
  IdMonitorGatilhosImediatos_OLD = 'MONITOR_GATILHOS_IMEDIATOS_%s';
  IdMonitorGatilhosImediatosOperacional = 'MONITOR_GATILHOS_IMEDIATOS_OPERACIONAL_%s';
  IdMonitorGatilhosImediatosComplementar = 'MONITOR_GATILHOS_IMEDIATOS_COMPLEMENTAR_%s';

type
  TResultEnvio = (tpEnviadoOK, tpEnviadoErro, tpNaoEnviado, tpTentarNovamente, tpDisparoAtrasado24Hrs, tpLayoutMultiplosArquivosPdfNaoDisponivel);

type
  TTipoObjeto = (typeNone, typeTDadosEnviaGatilhoEmail, typeTDadosEnviaWhatsapp, typeTDadosEnviaGatilhoWhatsapp, typeTDadosEnviaGatilhoSms);

type
  TGatilhosImediatosMonitor = class sealed(TInterfacedObject, {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX})
  private
    const
      SQL_ENVIOS_PENDENTES =
        ' SELECT '+
        '   GATIME_ENVIOS.AUTOINCREM, '+
        '   GATIME_ENVIOS.GAT_CODIGO, '+
        '   GATIME_ENVIOS.GAT_DTAOCO, '+
        '   GATIME_ENVIOS.GAT_HOROCO, '+
        '   GATIME_ENVIOS.GAT_CODOPE, '+
        '   CADOPE.OPE_NUMWPP,        '+
        '   GATIME_GERAL.GAT_TITULO,  '+
        '   GATIME_ENVIOS.GAT_MSGENV, '+
        '   GATIME_GERAL.GAT_IDECOR,  '+
        '   GATIME_GERAL.GAT_TIPMEN   '+
        ' FROM '+
        '   GATIME_ENVIOS '+
        ' INNER JOIN CADOPE '+
        '   ON GAT_CODOPE = OPE_CODOPE '+
        ' INNER JOIN GATIME_GERAL '+
        '   ON GATIME_ENVIOS.GAT_CODIGO = GATIME_GERAL.GAT_CODIGO '+
        ' WHERE '+
        '   GAT_LIBENV = "S" '+
        ' ORDER BY '+
        '   GAT_DTAOCO, '+
        '   GAT_HOROCO ';

    const
      SQL_UPDATE_ENVIOS =
        ' UPDATE '+
        '   GATIME_ENVIOS '+
        ' SET '+
        '    GAT_LIBENV = "N" '+
        '   ,GAT_DTAENV = :DTAENV '+
        '   ,GAT_HORENV = :HORENV '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

  private
    FPASTATEMPORARIA: String;
    FstrFluxo: String;
  private
    function fGerarArquivo(intStatus: Integer; strCodGatilho, strCodOpe, strTitulo, strData, strInformacao: String): String;
    procedure pExecuteOperador(const AIDFila: Extended; const AApiKey: String);
    function fEnviarEmail(const AArquivo, ADestinatario, AAssunto: String; ATexto: String; const AGatOpeEnv, AJson: String): Boolean; overload;
    function fRetornaAnexosEmail(AAutInc: String; out AblnResult: Boolean): String;
    function fRetMimeType(ATexto: String): String;
    function fGetWidth(ABase64: String): Extended;
    function fGetHeight(ABase64: String): Extended;
    function fRetErrosWhatsApp(AAutInc: String): String;
    procedure pExecuteCliente(const AIDFila: Extended; const AApiKey: String);
    function fUploadFile(const AIDFila: Extended; const AApiKey: String; const AAutInc: String;
      const AstrNomArq, AstrArquivo, AstrAssunto: String; const AblnBucket: Boolean; out AblnResult: Boolean): TReturnUploadFile;
    function fExecutaClienteWhatsAppNaoOficial(const AAutInc: String; const AIDFila: Extended; const AApiKey: String): TResultEnvio;
    function fExecutaClienteWhatsAppOficial(const AAutInc: String; const AIDFila: Extended; const AApiKey: String; const ATemplateId: String; const AVarsData: TArray<String>): TResultEnvio;
    function fExecutaClienteEmail(const AAutInc: String): TResultEnvio;
    function fExecutaClienteSms(const AAutInc: String): TResultEnvio;
    procedure pMarcaEnvioSms(const AAutInc: String; const AResultSms: TResultEnvio);
    procedure pMarcaEnvioWhats(const AAutInc: String; const AResultWhats: TResultEnvio);
    procedure pMarcaEnvioEmail(const AAutInc: String; const AResultEmail: TResultEnvio);
    procedure pMarcaGatImeEnviado(const AAutInc: String);
    procedure pAjustaFilaGatOpeEnv(const AstrGatOpeEnv: String; var AIDFila: Extended; var AApiKey: String);
    function fGerarMensagemDireta(qryGatIme: TUniQuery): String;
    function fGetArquivoBucket(const AstrArquivo: String; AstrNomeArquivo: String = ''): String;
    function fGetArquivo(AstrArquivo: String; AblnBucket: Boolean; tpGatilho: TTipoGatilho; out AblnResult: Boolean; AstrNomeArquivo: String = ''): String;
    function fApiOficial(const AIdFila: String): Boolean;
    function fRetUrlArquivo(const AextIdFila: Extended; const AstrApiKey: String; const AfileId: Extended): String;
    function fCriarArquivoPdfUnico(const ARecArquivos: TArray<TRecArquivosGatilhos>): TArray<TRecArquivosGatilhos>;
    function fAjustaVariaveisApiOficial(const AVarsData: TArray<String>): TArray<String>;
    procedure pAjustaFilaJson(const AJson: String; var AIDFila: Extended; var AApiKey: String; var ATemplateId: String; var AVarsData: TArray<String>);
    function fCarregaImagemAssinatura(strBase64: String): TMemoryStream;
    procedure pCarregaAnexosPorEmail(const intTamanhoReferenciaEmMB: Integer; const arrArquivos: TStringArray; out stlAnexosPorEmail: TStrings);
    function fTipoObjeto(const AObjJson: String): TTipoObjeto;
    function fRetFiltroGatilhos: String;
    function fExecuteOperador(const AApiKey: String; const AblnFilaApiOficial: Boolean): Boolean;
    function fValidaDisparo(const AstrAutInc: String;
      const AdtaDtaOco: TDateTime; const AblnWppPendente, AblnEmailPendente, AblnSmsPendente: Boolean): Boolean;
  protected
    procedure pExecute;
    function fExecute: TResultExecute;
  public
    constructor Create(AstrFluxo: String = '');
    destructor Destroy; Override;

    procedure pExecuteAll;
  end;

implementation

uses
{$IFDEF LINUX}
  FMX.Objects, FMX.Graphics,
{$ELSE}
  untFuncoesSimples, Vcl.Forms,
{$ENDIF}
  untGatilhosImediatosImagemAnexo,
  untFuncoesGenerica,
  untBucketCitel,
  untQualiZapEnqueueMessageToSend,
  untQualizapGenerateDownloadUrl,
  untGeraPdfLinksWhatsapp,
  untDadosEnviaWhatsapp,
  GatilhosImediatos.Classes;

{ TGatilhosImediatosMonitor }

constructor TGatilhosImediatosMonitor.Create(AstrFluxo: String = '');
begin
  inherited Create;
  FstrFluxo := AstrFluxo;

  FPASTATEMPORARIA := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'temp' + PathDelim;

  ForceDirectories(FPASTATEMPORARIA);
end;

destructor TGatilhosImediatosMonitor.Destroy;
begin
  inherited;
end;

procedure TGatilhosImediatosMonitor.pAjustaFilaGatOpeEnv(const AstrGatOpeEnv: String; var AIDFila: Extended; var AApiKey: String);
var
  LIDFila: Extended;
  LApiKey: String;
begin
  LIDFila := fRetFilaEnvioWhatsAppOperador(AstrGatOpeEnv);

  if LIDFila = 0 then
    Exit;

  LApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [LIDFila]);

  if not fEmptyStr(LApiKey) then
  begin
    AIDFila := LIDFila;
    AApiKey := LApiKey;
  end;
end;

function TGatilhosImediatosMonitor.fExecuteOperador(const AApiKey: String; const AblnFilaApiOficial: Boolean): Boolean;
begin
  Result := False;

  if fEmptyStr(AApiKey) then
    Exit;

  if (AblnFilaApiOficial) and (fEmptyStr(fCfgSis('GATTOP'))) then
    Exit;

  if (FstrFluxo = 'COMPLEMENTAR') or (fEmptyStr(FstrFluxo)) then
    Result := True;
end;

procedure TGatilhosImediatosMonitor.pExecute;
begin
  //do nothing
end;

procedure TGatilhosImediatosMonitor.pExecuteAll;
var
  LIDFila: Extended;
  LApiKey: String;

  LIdMonitor_old: String;
begin
  inherited;

  {##### TEMPORÁRIO - PODE SER REMOVIDO QUANDO AS RELEASES ANTES DESSA NÃO ESTIVEREM EM NENHUM CLIENTE #####}
  {$IFDEF LINUX}
  LIdMonitor_old := Format(IdMonitorGatilhosImediatos_OLD, [fRetEmpresaFisica]);
  {$ELSE}
  LIdMonitor_old := Format(IdMonitorGatilhosImediatos_OLD, [VS_StrCodEmp]);
  {$ENDIF}

  pDestravaLockForcado(LIdMonitor_old, -1);
  fLock_Unlock(LIdMonitor_old, True, False);
  {#########################################################################################################}

  LApiKey := EmptyStr;
  LIDFila := fRetFilaEnvioWhatsAppOperador(fCfgSis('GATOPE'));

  if LIDFila <> 0 then
    LApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [LIDFila]);

  if fExecuteOperador(LApiKey, fApiOficial(LIDFila.ToString)) then
    pExecuteOperador(LIDFila, LApiKey);

  pExecuteCliente(LIDFila, LApiKey);
end;

function TGatilhosImediatosMonitor.fRetFiltroGatilhos: String;
begin
  Result := ' AND COALESCE( '+
            '      JSON_UNQUOTE( '+
            '          JSON_EXTRACT( '+
            '              CAST(IFNULL(NULLIF(GAT_INFJSN, ""), "{}") AS CHAR), '+
            '              "$.dadosGatilho.codigoGrupo" '+
            '          ) '+
            '      ), '+
            '      "" '+
            '    ) /*FILTRO*/ ';

  case AnsiIndexStr(FstrFluxo, ['OPERACIONAL', 'COMPLEMENTAR']) of
    0: Result := Result.Replace('/*FILTRO*/', ' NOT IN ('+GRUPO_GATILHOS_COMPLEMENTARES_GATIME+')');
    1: Result := Result.Replace('/*FILTRO*/', ' IN ('+GRUPO_GATILHOS_COMPLEMENTARES_GATIME+')');
    else
      Result := EmptyStr;
  end;
end;

procedure TGatilhosImediatosMonitor.pExecuteCliente(const AIDFila: Extended;
  const AApiKey: String);
const
  SQL_ENVIO_GATILHOS =
    ' SELECT '+
    '   AUTOINCREM, '+
    '   GAT_DTAOCO, '+
    '   GAT_HOROCO, '+
    '   GAT_OPEENV, '+
    '   GAT_INFJSN, '+
    '   GAT_D_EWPP, '+
    '   GAT_D_EEMA, '+
    '   GAT_D_ESMS  '+
    ' FROM '+
    '   GATIME_WPPEMA '+
    ' WHERE '+
    '   GAT_LIBENV = "S" AND '+
    '   GAT_CODEMP = :CODEMP '+
    '   /*FLUXO*/ ';

var
  LQryEnvArq: TUniQuery;
  LTipoEnvioWhats: TResultEnvio;
  LTipoEnvioEmail: TResultEnvio;
  LTipoEnvioSms: TResultEnvio;
  LIDFila: Extended;
  LApiKey: String;
  LTemplateId: String;
  LVarsData: TArray<String>;
  LIdMonitor: String;
  blnEncerrarAplicacao: Boolean;

  LIdMonitor_old: String;
begin
  {##### TEMPORÁRIO - PODE SER REMOVIDO QUANDO AS RELEASES ANTES DESSA NÃO ESTIVEREM EM NENHUM CLIENTE #####}
  LIdMonitor_old := Format(IdMonitorGatilhosImediatos_OLD, [VS_StrCodEmp]);
  {#########################################################################################################}

  LIdMonitor := Format(IIF(FstrFluxo = 'COMPLEMENTAR', IdMonitorGatilhosImediatosComplementar, IdMonitorGatilhosImediatosOperacional), [VS_StrCodEmp]);
  blnEncerrarAplicacao := False;

  LQryEnvArq := fCriaQuery;
  try
    LQryEnvArq.Close;
    LQryEnvArq.SQL.Clear;
    LQryEnvArq.SQL.Text := SQL_ENVIO_GATILHOS;
    LQryEnvArq.SQL.Text := LQryEnvArq.SQL.Text.Replace('/*FLUXO*/', fRetFiltroGatilhos);
    LQryEnvArq.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    LQryEnvArq.Open;

    if LQryEnvArq.IsEmpty then
      Exit;

    while not LQryEnvArq.Eof do
    begin
      {##### TEMPORÁRIO - PODE SER REMOVIDO QUANDO AS RELEASES ANTES DESSA NÃO ESTIVEREM EM NENHUM CLIENTE #####}
      pDestravaLockForcado(LIdMonitor_old, -1);
      fLock_Unlock(LIdMonitor_old, True, False);
      {#########################################################################################################}

      if not fLckAtcEhDoMesmoPID(LIdMonitor) then
      begin
        blnEncerrarAplicacao := True;
        Exit;
      end;

      pZerarTentativasLock(LIdMonitor);

      LIDFila := AIDFila;
      LApiKey := AApiKey;
      LTemplateId := EmptyStr;
      Setlength(LVarsData, 0);

      if fValidaDisparo(LQryEnvArq.FieldByName('AUTOINCREM').AsString,
                        LQryEnvArq.FieldByName('GAT_DTAOCO').AsDateTime + LQryEnvArq.FieldByName('GAT_HOROCO').AsDateTime,
                        LQryEnvArq.FieldByName('GAT_D_EWPP').IsNull,
                        LQryEnvArq.FieldByName('GAT_D_EEMA').IsNull,
                        LQryEnvArq.FieldByName('GAT_D_ESMS').IsNull) then
      begin
        if LQryEnvArq.FieldByName('GAT_D_EWPP').IsNull then
        begin
          pAjustaFilaGatOpeEnv(LQryEnvArq.FieldByName('GAT_OPEENV').AsString, LIDFila, LApiKey);
          pAjustaFilaJson(LQryEnvArq.FieldByName('GAT_INFJSN').AsString, LIDFila, LApiKey, LTemplateId, LVarsData);

          if fApiOficial(LIDFila.ToString) then
            LTipoEnvioWhats := fExecutaClienteWhatsAppOficial(LQryEnvArq.FieldByName('AUTOINCREM').AsString, LIDFila, LApiKey, LTemplateId, LVarsData)
          else
            LTipoEnvioWhats := fExecutaClienteWhatsAppNaoOficial(LQryEnvArq.FieldByName('AUTOINCREM').AsString, LIDFila, LApiKey);

          pMarcaEnvioWhats(LQryEnvArq.FieldByName('AUTOINCREM').AsString, LTipoEnvioWhats);
        end;

        if LQryEnvArq.FieldByName('GAT_D_EEMA').IsNull then
        begin
          LTipoEnvioEmail := fExecutaClienteEmail(LQryEnvArq.FieldByName('AUTOINCREM').AsString);
          pMarcaEnvioEmail(LQryEnvArq.FieldByName('AUTOINCREM').AsString, LTipoEnvioEmail);
        end;

        if LQryEnvArq.FieldByName('GAT_D_ESMS').IsNull then
        begin
          LTipoEnvioSms := fExecutaClienteSms(LQryEnvArq.FieldByName('AUTOINCREM').AsString);
          pMarcaEnvioSms(LQryEnvArq.FieldByName('AUTOINCREM').AsString, LTipoEnvioSms);
        end;
      end;

      pMarcaGatImeEnviado(LQryEnvArq.FieldByName('AUTOINCREM').AsString);

      Sleep(1000);

      LQryEnvArq.Next;
    end;
  finally
    FreeAndNil(LQryEnvArq);

    if blnEncerrarAplicacao then
      Halt(0);
  end;
end;

function TGatilhosImediatosMonitor.fValidaDisparo(const AstrAutInc: String;
  const AdtaDtaOco: TDateTime; const AblnWppPendente, AblnEmailPendente, AblnSmsPendente: Boolean): Boolean;
begin
  Result := (HoursBetween(fNow, AdtaDtaOco) < 24);

  if not Result then
  begin
    if AblnWppPendente then pMarcaEnvioWhats(AstrAutInc, tpDisparoAtrasado24Hrs);
    if AblnEmailPendente then pMarcaEnvioEmail(AstrAutInc, tpDisparoAtrasado24Hrs);
    if AblnSmsPendente then pMarcaEnvioSms(AstrAutInc, tpDisparoAtrasado24Hrs);
  end;
end;

function TGatilhosImediatosMonitor.fApiOficial(const AIdFila: String): Boolean;
begin
  Result := (fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [AIdFila]) = 'S');
end;

procedure TGatilhosImediatosMonitor.pExecuteOperador(const AIDFila: Extended;
  const AApiKey: String);
var
  LIdMonitor: String;
  blnEncerrarAplicacao: Boolean;

  DadosEnviaWhatsapp: TDadosEnviaWhatsapp;
  arrArquivo: TArray<TRecArquivosGatilhos>;

  qryGatIme: TUniQuery;
  qryEnvios: TUniQuery;

  strMsg: String;

  GatIme: TGatIme;
begin
  blnEncerrarAplicacao := False;
  {$IFDEF LINUX}
  LIdMonitor := Format(IIF(FstrFluxo = 'COMPLEMENTAR', IdMonitorGatilhosImediatosComplementar, IdMonitorGatilhosImediatosOperacional), [fRetEmpresaFisica]);
  {$ELSE}
  LIdMonitor := Format(IIF(FstrFluxo = 'COMPLEMENTAR', IdMonitorGatilhosImediatosComplementar, IdMonitorGatilhosImediatosOperacional), [VS_StrCodEmp]);
  {$ENDIF}

  qryGatIme := fCriaQuery;
  try
    qryGatIme.Close;
    qryGatIme.SQL.Text := SQL_ENVIOS_PENDENTES;
    qryGatIme.Open;

    qryEnvios := fCriaQuery;
    try
      while not qryGatIme.Eof do
      begin
        if not fLckAtcEhDoMesmoPID(LIdMonitor) then
        begin
          blnEncerrarAplicacao := True;
          Exit;
        end;

        pZerarTentativasLock(LIdMonitor {$IFDEF LINUX}, -999{$ENDIF});

        strMsg := fGerarMensagemDireta(qryGatIme);

        SetLength(arrArquivo, 0);

        if (qryGatIme.FieldByName('GAT_TIPMEN').AsString = 'PDF') or (fApiOficial(AIDFila.ToString)) then
        begin
          SetLength(arrArquivo, 1);
          arrArquivo[0] := TRecArquivosGatilhos.Create(qryGatIme.FieldByName('GAT_TITULO').AsString,
                                                       fGerarArquivo(qryGatIme.FieldByName('GAT_IDECOR').AsInteger,
                                                                     qryGatIme.FieldByName('GAT_CODIGO').AsString,
                                                                     qryGatIme.FieldByName('GAT_CODOPE').AsString,
                                                                     qryGatIme.FieldByName('GAT_TITULO').AsString,
                                                                     qryGatIme.FieldByName('GAT_DTAOCO').AsString,
                                                                     CorrigirQuebrasUnixParaWindows(qryGatIme.FieldByName('GAT_MSGENV').AsString)),
                                                        EmptyStr);
          if not fApiOficial(AIDFila.ToString) then
            strMsg := EmptyStr;
        end;

        DadosEnviaWhatsapp := TDadosEnviaWhatsapp.Create;
        try
          DadosEnviaWhatsapp.fila.id := AIDFila.ToString;
          if fApiOficial(AIDFila.ToString) then
            DadosEnviaWhatsapp.template.id := fCfgSis('GATTOP');

          GatIme := TGatIme.Create;
          try
            if GatIme.fGravarGatilhoImediato(TRecGatilhoImediato
                                               .Create(qryGatIme.FieldByName('GAT_TITULO').AsString,
                                                       strMsg,
                                                       arrArquivo,
                                                       DadosEnviaWhatsapp.ToJsonString,
                                                       EmptyStr,
                                                       qryGatIme.FieldByName('OPE_NUMWPP').AsString,
                                                       EmptyStr)) then
            begin
              qryEnvios.Close;
              qryEnvios.SQL.Text := SQL_UPDATE_ENVIOS;
              qryEnvios.ParamByName('DTAENV').AsDate := VS_Date;
              qryEnvios.ParamByName('HORENV').AsTime := fTime;
              qryEnvios.ParamByName('AUTINC').AsString := qryGatIme.FieldByName('AUTOINCREM').AsString;
              qryEnvios.ExecSQL;
            end;
          finally
            FreeAndNil(GatIme);
          end;
        finally
          FreeAndNil(DadosEnviaWhatsapp);
        end;

        qryGatIme.Next;
      end;
    finally
      FreeAndNil(qryEnvios);
    end;
  finally
    FreeAndNil(qryGatIme);

    if blnEncerrarAplicacao then
      Halt(0);
  end;
end;

function TGatilhosImediatosMonitor.fGerarMensagemDireta(qryGatIme: TUniQuery): String;
var
  strCabecalho: String;
  strCorpo: String;
begin
  strCabecalho := qryGatIme.FieldByName('GAT_TITULO').AsString + SlineBreak +
                  qryGatIme.FieldByName('GAT_DTAOCO').AsString + ' ' + qryGatIme.FieldByName('GAT_HOROCO').AsString + SlineBreak + SlineBreak;

  strCorpo := CorrigirQuebrasUnixParaWindows(qryGatIme.FieldByName('GAT_MSGENV').AsString);

  Result := strCabecalho + strCorpo;
end;

procedure TGatilhosImediatosMonitor.pMarcaEnvioWhats(const AAutInc: String;
  const AResultWhats: TResultEnvio);
var
  LQryMarcaEnvio: TUniQuery;

  procedure pWhatsStatus(const AStatus: String);
  begin
    LQryMarcaEnvio.Close;
    LQryMarcaEnvio.SQL.Clear;
    LQryMarcaEnvio.SQL.Add('UPDATE GATIME_WPPEMA');
    LQryMarcaEnvio.SQL.Add('SET GAT_D_EWPP = :D_EWPP, GAT_H_EWPP = :H_EWPP, GAT_OBSWPP = :OBSWPP');
    LQryMarcaEnvio.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    LQryMarcaEnvio.ParamByName('D_EWPP').AsDate := VS_Date;
    LQryMarcaEnvio.ParamByName('H_EWPP').AsTime := Time;
    LQryMarcaEnvio.ParamByName('OBSWPP').AsString := AStatus;
    LQryMarcaEnvio.ParamByName('AUTINC').AsString := AAutInc;
    LQryMarcaEnvio.ExecSQL;
  end;

  procedure pWhatsNaoEnviadoErro;
    var
      LErros: String;
  begin
    LErros := fRetErrosWhatsApp(AAutInc);

    if fEmptyStr(LErros) then
      Exit;

    LQryMarcaEnvio.Close;
    LQryMarcaEnvio.SQL.Clear;
    LQryMarcaEnvio.SQL.Add('UPDATE GATIME_WPPEMA');
    LQryMarcaEnvio.SQL.Add('SET GAT_D_EWPP = :D_EWPP, GAT_H_EWPP = :H_EWPP, GAT_OBSWPP = :OBSWPP');
    LQryMarcaEnvio.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    LQryMarcaEnvio.ParamByName('D_EWPP').AsDate := VS_Date;
    LQryMarcaEnvio.ParamByName('H_EWPP').AsTime := Time;
    LQryMarcaEnvio.ParamByName('OBSWPP').AsString := LErros;
    LQryMarcaEnvio.ParamByName('AUTINC').AsString := AAutInc;
    LQryMarcaEnvio.ExecSQL;
  end;

begin
  LQryMarcaEnvio := fCriaQuery;

  try
    case AResultWhats of
      tpNaoEnviado: pWhatsStatus('Envio não previsto');
      tpEnviadoOK: pWhatsStatus('Enviado');
      tpEnviadoErro: pWhatsNaoEnviadoErro;
      tpDisparoAtrasado24Hrs: pWhatsStatus('Envio cancelado - Atraso(24h)');
      tpLayoutMultiplosArquivosPdfNaoDisponivel: pWhatsStatus('Envio cancelado - Layout frxPdfLinksWhatsapp não cadastrado na tabela LAYFR3');
    end;
  finally
    FreeAndNil(LQryMarcaEnvio);
  end;
end;

procedure TGatilhosImediatosMonitor.pMarcaEnvioEmail(const AAutInc: String;
  const AResultEmail: TResultEnvio);
var
  LQryMarcaEnvio: TUniQuery;

  procedure pEmailStatus(const AStatus: String);
  begin
    LQryMarcaEnvio.Close;
    LQryMarcaEnvio.SQL.Clear;
    LQryMarcaEnvio.SQL.Add('UPDATE GATIME_WPPEMA');
    LQryMarcaEnvio.SQL.Add('SET GAT_D_EEMA = :D_EEMA, GAT_H_EEMA = :H_EEMA, GAT_OBSEMA = :OBSEMA');
    LQryMarcaEnvio.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    LQryMarcaEnvio.ParamByName('D_EEMA').AsDate := VS_Date;
    LQryMarcaEnvio.ParamByName('H_EEMA').AsTime := Time;
    LQryMarcaEnvio.ParamByName('OBSEMA').AsString := AStatus;
    LQryMarcaEnvio.ParamByName('AUTINC').AsString := AAutInc;
    LQryMarcaEnvio.ExecSQL;
  end;
begin
  LQryMarcaEnvio := fCriaQuery;

  try
    case AResultEmail of
      tpNaoEnviado: pEmailStatus('Envio não previsto');
      tpEnviadoOK: pEmailStatus('Enviado');
      tpEnviadoErro: pEmailStatus('Erro ao enviar E-mail');
      tpDisparoAtrasado24Hrs: pEmailStatus('Envio cancelado - Atraso(24h)');
    end;
  finally
    FreeAndNil(LQryMarcaEnvio);
  end;
end;

procedure TGatilhosImediatosMonitor.pMarcaEnvioSms(const AAutInc: String;
  const AResultSms: TResultEnvio);
var
  LQryMarcaEnvio: TUniQuery;

  procedure pSmsStatus(const AStatus: String);
  begin
    LQryMarcaEnvio.Close;
    LQryMarcaEnvio.SQL.Clear;
    LQryMarcaEnvio.SQL.Add('UPDATE GATIME_WPPEMA');
    LQryMarcaEnvio.SQL.Add('SET GAT_D_ESMS = :D_ESMS, GAT_H_ESMS = :H_ESMS, GAT_OBSSMS = :OBSSMS');
    LQryMarcaEnvio.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    LQryMarcaEnvio.ParamByName('D_ESMS').AsDate := VS_Date;
    LQryMarcaEnvio.ParamByName('H_ESMS').AsTime := Time;
    LQryMarcaEnvio.ParamByName('OBSSMS').AsString := AStatus;
    LQryMarcaEnvio.ParamByName('AUTINC').AsString := AAutInc;
    LQryMarcaEnvio.ExecSQL;
  end;
begin
  LQryMarcaEnvio := fCriaQuery;

  try
    case AResultSms of
      tpNaoEnviado: pSmsStatus('Envio não previsto');
      tpEnviadoOK: pSmsStatus('Enviado');
      tpEnviadoErro: pSmsStatus('Erro ao enviar SMS');
      tpDisparoAtrasado24Hrs: pSmsStatus('Envio cancelado - Atraso(24h)');
    end;
  finally
    FreeAndNil(LQryMarcaEnvio);
  end;
end;

procedure TGatilhosImediatosMonitor.pMarcaGatImeEnviado(const AAutInc: String);
var
  LQryMarcaEnvioGatIme: TUniQuery;
begin
  LQryMarcaEnvioGatIme := fCriaQuery;
  try
    LQryMarcaEnvioGatIme.Close;
    LQryMarcaEnvioGatIme.SQL.Text :=
    ' UPDATE '+
    '   GATIME_WPPEMA '+
    ' SET '+
    '   GAT_LIBENV = "N" '+
    ' WHERE '+
    '   GAT_D_EWPP IS NOT NULL AND '+
    '   GAT_D_EEMA IS NOT NULL AND '+
    '   GAT_D_ESMS IS NOT NULL AND '+
    '   AUTOINCREM = :AUTINC ';
    LQryMarcaEnvioGatIme.ParamByName('AUTINC').AsString := AAutInc;
    LQryMarcaEnvioGatIme.ExecSQL;
  finally
    FreeAndNil(LQryMarcaEnvioGatIme);
  end;
end;

function TGatilhosImediatosMonitor.fEnviarEmail(const AArquivo, ADestinatario,
  AAssunto: String; ATexto: String; const AGatOpeEnv, AJson: String): Boolean;
var
  DadosEnviaGatilhoEmail: TDadosEnviaGatilhoEmail;
  DadosLoginEmail: TDadosLoginEmail;
  arrArquivos         : TStringArray;
  arrDestinatarios    : TStringArray;
  strEmailDestinatario: String;

  stlAnexosPorEmail   : TStrings;
  arrAnexosPorEmail   : TStringArray;
  strAnexosEmail      : String;
  strAssunto          : String;
  incQtdeEmail        : Integer;

  stlArquivosPorEmail : TStrings;
  strAnexo            : String;

  mmsImaAss: TMemoryStream;

  imagemCorpo: TDadosImagemCorpo;
  strImagemCorpoNovoPath: String;
  strImagemCorpo: String;
  arrImagemCorpo: TArray<String>;

  function fDadosPreenchidos: Boolean;
  begin
    Result := (not DadosLoginEmail.Email.IsEmpty) and (DadosLoginEmail.PortaSMTP > 0) and (DadosLoginEmail.PortaImap >= 0)
          and (not DadosLoginEmail.ServidorSMTP.IsEmpty) and (DadosLoginEmail.LimiteArquivos > 0) and
          ((not DadosLoginEmail.Senha.IsEmpty) Or (fCampoTabela('PRV_USAOA2', 'CADPRV', ['PRV_CODPRV'], [DadosLoginEmail.Provedor]) = 'S'));
  end;
begin
  Result := False;

  strImagemCorpo := EmptyStr;

  if fTipoObjeto(AJson) = typeTDadosEnviaGatilhoEmail then
    DadosEnviaGatilhoEmail := TDadosEnviaGatilhoEmail.FromJsonString(AJson)
  else
  begin
    DadosEnviaGatilhoEmail := TDadosEnviaGatilhoEmail.Create;
    DadosEnviaGatilhoEmail.operador.codigoOperador := AGatOpeEnv;
    DadosEnviaGatilhoEmail.operador.nomeOperador := fRetNomeOperador(AGatOpeEnv);
  end;

  try
    DadosLoginEmail := DadosEnviaGatilhoEmail.fRetornaDadosLoginEmail;

    if not fDadosPreenchidos then
      Exit;

    strEmailDestinatario := ADestinatario;

    if (DadosEnviaGatilhoEmail.gatilho.opcDocumento = 'BO') and (not (fCfgSis('ANEBOL', varBoolean))) then
      pCriarArrayAnexosEDestinatarios('', strEmailDestinatario, arrDestinatarios, arrArquivos)
    else
      pCriarArrayAnexosEDestinatarios(AArquivo, strEmailDestinatario, arrDestinatarios, arrArquivos);

    incQtdeEmail      := 0;
    strAssunto        := AAssunto;
    stlAnexosPorEmail := TStringList.Create;

    if (fCfgSis('TAMANX', varInteger) > 0) then
      pCarregaAnexosPorEmail(fCfgSis('TAMANX', varInteger), arrArquivos, stlAnexosPorEmail)
    else
      pCarregaAnexosPorEmail(10, arrArquivos, stlAnexosPorEmail);

    if stlAnexosPorEmail.Count = 0 then
      stlAnexosPorEmail.Add(EmptyStr);

    For strAnexosEmail In stlAnexosPorEmail Do
    Begin
      Inc(incQtdeEmail);

      If stlAnexosPorEmail.Count > 1 Then
      Begin
        SetLength(arrAnexosPorEmail, 0);

        strAssunto := AAssunto
                    + ' - Email ' + (incQtdeEmail).ToString
                    + ' de ' + stlAnexosPorEmail.Count.ToString;

        stlArquivosPorEmail := TStringList.Create;
        Try
          stlArquivosPorEmail.Delimiter       := ';';
          stlArquivosPorEmail.StrictDelimiter := True;
          stlArquivosPorEmail.DelimitedText   := strAnexosEmail;

          For strAnexo in stlArquivosPorEmail Do
          Begin
            SetLength(arrAnexosPorEmail, Length(arrAnexosPorEmail)+1);
            arrAnexosPorEmail[Length(arrAnexosPorEmail)-1] := strAnexo;
          End;
        Finally
          FreeAndNil(stlArquivosPorEmail);
        End;
      End
      Else
        arrAnexosPorEmail := arrArquivos;

      TEnvioEmail.FCodigoGrupoModelo := DadosEnviaGatilhoEmail.gatilho.codigoGrupo;
      TEnvioEmail.FCodigoModelo := DadosEnviaGatilhoEmail.gatilho.codigoGatilho;
      mmsImaAss := fCarregaImagemAssinatura(DadosLoginEmail.ImagemAssinaturaBase64);

      for imagemCorpo in DadosEnviaGatilhoEmail.email.imagemCorpo do
      begin
        strImagemCorpoNovoPath := fRetBase64ParaArquivo(imagemCorpo.imagemCorpoBase64, FPASTATEMPORARIA + ExtractFileNameCrossPlatform(imagemCorpo.imagemCorpoPath));
        ATexto := ATexto.Replace(imagemCorpo.imagemCorpoPath, strImagemCorpoNovoPath);
        strImagemCorpo := strImagemCorpo + IIF(not fEmptyStr(strImagemCorpo), ';', '') + strImagemCorpoNovoPath;
      end;

      Result := TEnvioEmail.EnviarEmail(Nil,
                                        DadosEnviaGatilhoEmail.operador.codigoOperador,
                                        strAssunto,
                                        arrDestinatarios,
                                        [],
                                        DadosEnviaGatilhoEmail.email.copiaOculta,
                                        [ATexto],
                                        arrArquivos,
                                        False,
                                        False,
                                        fRetAutoIncrem('EMAENV', VS_strCodEmp),
                                        fRetAutoIncrem('CONOPE', VS_strCodEmp),
                                        StrToInt64(fAtualizaProCod('EMAENV', '')),
                                        True,
                                        DadosLoginEmail.Senha,
                                        DadosLoginEmail.Email,
                                        DadosLoginEmail.Login,
                                        DadosLoginEmail.Remetente,
                                        DadosLoginEmail.Provedor,
                                        DadosLoginEmail.PortaSMTP,
                                        DadosLoginEmail.PortaImap,
                                        DadosLoginEmail.ServidorSMTP,
                                        DadosLoginEmail.ServidorImap,
                                        DadosLoginEmail.LimiteArquivos,
                                        (not fEmptyStr(DadosLoginEmail.ImagemAssinaturaBase64)),
                                        DadosLoginEmail.TextoAssinatura,
                                        mmsImaAss,
                                        DadosEnviaGatilhoEmail.operador.nomeOperador,
                                        strImagemCorpo,
                                        DadosLoginEmail.AutenticacaoSSL,
                                        DadosLoginEmail.AutenticacaoSSLImap,
                                        DadosLoginEmail.GravaPastaEnviados,
                                        IIF(DadosEnviaGatilhoEmail.email.envioAutomaticoCobranca, 'S', 'N'),
                                        DadosEnviaGatilhoEmail.cliente.codigoCliente,
                                        EmptyStr,
                                        True,
                                        True,
                                        True,
                                        DadosEnviaGatilhoEmail.email.duplicatas,
                                        DadosEnviaGatilhoEmail.email.gravarAnexos,
                                        False,
                                        '',
                                        DadosEnviaGatilhoEmail.chavesPrimarias.autIncNotfic);
    end;
  finally
    arrImagemCorpo := strImagemCorpo.Split([';']);
    for strImagemCorpoNovoPath in arrImagemCorpo do
    begin
      if FileExists(strImagemCorpoNovoPath) then
        DeleteFile(strImagemCorpoNovoPath);
    end;

    FreeAndNil(DadosEnviaGatilhoEmail);
    if Assigned(mmsImaAss) then
      FreeAndNil(mmsImaAss);
  end;
end;

function TGatilhosImediatosMonitor.fCarregaImagemAssinatura(strBase64: String): TMemoryStream;
var
  tmpImg: TBytesStream;
begin
  Result := nil;

  if fEmptyStr(strBase64) then
    Exit;

  Result := TMemoryStream.Create;

  tmpImg := TBytesStream.Create(nil);
  fStreamFromBase64(strBase64, tmpImg);
  Try
    If (tmpImg.Size > 0) Then
    Begin
      tmpImg.SaveToStream(Result);
      Result.Seek({$IFNDEF LINUX}0{$ELSE}Int64(0){$ENDIF}, soFromBeginning);
    End;
  Finally
    tmpImg.Free;
  End;
end;

procedure TGatilhosImediatosMonitor.pCarregaAnexosPorEmail(const intTamanhoReferenciaEmMB: Integer;
  const arrArquivos: TStringArray; out stlAnexosPorEmail: TStrings);
var
  intIndice         : Integer;
  intTamanhoTotal   : Integer;
  intTamanhoArquivo : Integer;
  strAnexosEmail    : String;
  intRefTamanhoKB   : Integer;
  strAnexoNomeArq   : String;
  strAnexosLogErr   : String;
begin
  If Not Assigned(stlAnexosPorEmail) Then
    stlAnexosPorEmail := TStringList.Create;

  intTamanhoTotal := 0;
  strAnexosEmail  := EmptyStr;
  strAnexosLogErr := EmptyStr;
  intRefTamanhoKB := intTamanhoReferenciaEmMB * 1024;

  For intIndice := 0 To Pred(Length(arrArquivos)) Do
  Begin
    if not fArquivoExisteNoDiretorio(arrArquivos[intIndice], 40, 2000) then
      Continue;

    intTamanhoArquivo := fTamanhoArquivo(arrArquivos[intIndice], ttKByte);

    strAnexoNomeArq := arrArquivos[intIndice] + ' (' + IntToStr(intTamanhoArquivo) + ' KB)';

    strAnexosLogErr := strAnexosLogErr + strAnexoNomeArq + ';';

    If intTamanhoArquivo > intRefTamanhoKB Then
      raise Exception.Create('O anexo '+strAnexoNomeArq+' tem um tamanho superior ao permitido (' + IntToStr(intRefTamanhoKB) + ' KB) e não poderá ser enviado!'+
                             IIF((intIndice > 0),#13+'Anexos: '+ strAnexosLogErr, ''));

    intTamanhoTotal := intTamanhoTotal
                     + intTamanhoArquivo;

    If intTamanhoTotal > intRefTamanhoKB Then
    Begin
      stlAnexosPorEmail.Add(strAnexosEmail);
      intTamanhoTotal := intTamanhoArquivo;
      strAnexosEmail  := EmptyStr;
    End;

    If Not fEmptyStr(strAnexosEmail) Then
      strAnexosEmail := strAnexosEmail
                      + ';';

    strAnexosEmail := strAnexosEmail
                    + arrArquivos[intIndice];
  End;

  stlAnexosPorEmail.Add(strAnexosEmail);
end;

function TGatilhosImediatosMonitor.fTipoObjeto(const AObjJson: String): TTipoObjeto;
var
  Obj: TJSONObject;
  LType: String;
begin
  Result := typeNone;

  if fEmptyStr(AObjJson) then
    Exit;

  Obj := TJSONObject.ParseJSONValue(AObjJson) as TJSONObject;
  try
    if Assigned(Obj) then
      LType := Obj.GetValue<string>('type', '');
  finally
    Obj.Free;
  end;

  case AnsiIndexStr(LType, ['TDadosEnviaGatilhoEmail', 'TDadosEnviaWhatsapp', 'TDadosEnviaGatilhoWhatsapp', 'TDadosEnviaGatilhoSms']) of
    0: Result := typeTDadosEnviaGatilhoEmail;
    1: Result := typeTDadosEnviaWhatsapp;
    2: Result := typeTDadosEnviaGatilhoWhatsapp;
    3: Result := typeTDadosEnviaGatilhoSms;
  end;
end;

function TGatilhosImediatosMonitor.fExecutaClienteEmail(
  const AAutInc: String): TResultEnvio;
const
  SQL_ENVIO_EMAIL =
    ' SELECT '+
    '   GAT_EMAIL_ '+
    '  ,GAT_ASSUNT '+
    '  ,GAT_TEXINI '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", GAT_ARQBCK, GAT_PATARQ) AS GAT_PATARQ '+
    '  ,GAT_OPEENV '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", "S", "N") AS GAT_BUCKET '+
    '  ,GAT_NOMARQ '+
    '  ,GAT_INFJSN '+
    ' FROM '+
    '   GATIME_WPPEMA '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

var
  LQryEmail: TUniQuery;
  LTodosArquivos: String;
  LEmailDestinatario: String;
  LAssunto: String;
  LTexto: String;
  LAnexos: String;
  LarrAnexos: TArray<String>;
  blnEnviado: Boolean;
  blnResult: Boolean;
begin
  Result := tpNaoEnviado;

  LQryEmail := fCriaQuery;
  try
    LQryEmail.Close;
    LQryEmail.SQL.Clear;
    LQryEmail.SQL.Add(SQL_ENVIO_EMAIL);
    LQryEmail.ParamByName('AUTINC').AsString := AAutInc;
    LQryEmail.Open;

    if LQryEmail.IsEmpty then
      Exit;

    if fTipoObjeto(LQryEmail.FieldByName('GAT_INFJSN').AsString) in [typeTDadosEnviaGatilhoWhatsapp, typeTDadosEnviaGatilhoSms] then
      Exit;

    if not fEmptyStr(LQryEmail.FieldByName('GAT_EMAIL_').AsString) then
    begin
      LTodosArquivos := EmptyStr;

      if (LQryEmail.FieldByName('GAT_BUCKET').AsString = 'N') and
         (not fEmptyStr(LQryEmail.FieldByName('GAT_PATARQ').AsString)) And
         (not FileExists(LQryEmail.FieldByName('GAT_PATARQ').AsString)) then
      begin
        Exit;
      end;

      if (not fEmptyStr(LQryEmail.FieldByName('GAT_PATARQ').AsString)) then
      begin
        LTodosArquivos := fGetArquivo(LQryEmail.FieldByName('GAT_PATARQ').AsString, (LQryEmail.FieldByName('GAT_BUCKET').AsString = 'S'), notEmail, blnResult, LQryEmail.FieldByName('GAT_NOMARQ').AsString);
        if not blnResult then
          Exit(tpTentarNovamente);
      end;

      LEmailDestinatario := LQryEmail.FieldByName('GAT_EMAIL_').AsString;
      LAssunto := LQryEmail.FieldByName('GAT_ASSUNT').AsString;
      LTexto := StringReplace(LQryEmail.FieldByName('GAT_TEXINI').AsString, '<<csq>>', sLineBreak, [rfReplaceAll]);
      LAnexos := fRetornaAnexosEmail(AAutInc, blnResult);

      if not blnResult then
        Exit(tpTentarNovamente);

      if (fEmptyStr(LTodosArquivos)) then
        LTodosArquivos := LAnexos
      else if (not fEmptyStr(LTodosArquivos)) and (not fEmptyStr(LAnexos)) then
        LTodosArquivos := Concat(LTodosArquivos, ';', LAnexos);

      blnEnviado := fEnviarEmail(LTodosArquivos,
                                 LEmailDestinatario,
                                 LAssunto,
                                 LTexto,
                                 LQryEmail.FieldByName('GAT_OPEENV').AsString,
                                 LQryEmail.FieldByName('GAT_INFJSN').AsString);

      Result := IIF(blnEnviado, tpEnviadoOK, tpEnviadoErro);

      LarrAnexos := LTodosArquivos.Split([';']);
      for LAnexos in LarrAnexos do
      begin
        if Pos(FPASTATEMPORARIA, LAnexos) <= 0 then
          Continue;

        if FileExists(LAnexos) then
          DeleteFile(LAnexos);
      end;

      Sleep(1000);
    end;
  finally
    FreeAndNil(LQryEmail);
  end;
end;

function TGatilhosImediatosMonitor.fExecutaClienteSms(
  const AAutInc: String): TResultEnvio;
const
  SQL_ENVIO_SMS =
    ' SELECT '+
    '   GAT_NUMWPP '+
    '  ,GAT_TEXINI '+
    '  ,GAT_INFJSN '+
    '  ,GAT_OPEENV '+
    ' FROM '+
    '   GATIME_WPPEMA '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';
var
  LQrySms: TUniQuery;
  DadosEnviaGatilhoSms: TDadosEnviaGatilhoSms;
  objSms: TEnvioSMS;
  blnEnviado: Boolean;
begin
  Result := tpNaoEnviado;
  DadosEnviaGatilhoSms := nil;
  objSms := nil;

  LQrySms := fCriaQuery;
  try
    LQrySms.Close;
    LQrySms.SQL.Clear;
    LQrySms.SQL.Add(SQL_ENVIO_SMS);
    LQrySms.ParamByName('AUTINC').AsString := AAutInc;
    LQrySms.Open;

    if LQrySms.IsEmpty then
      Exit;

    if fTipoObjeto(LQrySms.FieldByName('GAT_INFJSN').AsString) <> typeTDadosEnviaGatilhoSms then
      Exit;

    if fEmptyStr(LQrySms.FieldByName('GAT_NUMWPP').AsString) then
      Exit;

    DadosEnviaGatilhoSms := TDadosEnviaGatilhoSms.FromJsonString(LQrySms.FieldByName('GAT_INFJSN').AsString);

    if DadosEnviaGatilhoSms.gatilho.utilizaIntegracaoMKON then
      blnEnviado := TControllerMkmServiceSms.fSendSms(fRetAutoIncrem('SMSENV', VS_strCodEmp),
                                                      DadosEnviaGatilhoSms.gatilho.cgcEmp,
                                                      LQrySms.FieldByName('GAT_NUMWPP').AsString,
                                                      LQrySms.FieldByName('GAT_TEXINI').AsString,
                                                      DadosEnviaGatilhoSms.gatilho.nomeGatilho,
                                                      LQrySms.FieldByName('GAT_OPEENV').AsString)
    else
    begin
      objSms := TEnvioSMS.Create(fRetAutoIncrem('SMSENV', VS_strCodEmp), VS_strCodEmp, DadosEnviaGatilhoSms.gatilho.cgcEmp);
      objSms.objMensagem.strTo       := LQrySms.FieldByName('GAT_NUMWPP').AsString;
      objSms.objMensagem.strSchedule := DadosEnviaGatilhoSms.gatilho.schedule;
      objSms.objMensagem.strMsg      := LQrySms.FieldByName('GAT_TEXINI').AsString;
      objSms.fEnviarSMS(LQrySms.FieldByName('GAT_OPEENV').AsString);

      blnEnviado := objSms.objMensagem.objRetorno.strStatusDescription.ToUpper = 'OK';
    end;

    Result := IIF(blnEnviado, tpEnviadoOK, tpEnviadoErro);
  finally
    FreeAndNil(LQrySms);

    if Assigned(DadosEnviaGatilhoSms) then
      FreeAndNil(DadosEnviaGatilhoSms);

    if Assigned(objSms) then
      FreeAndNil(objSms);
  end;
end;

function TGatilhosImediatosMonitor.fUploadFile(const AIDFila: Extended; const AApiKey: String; const AAutInc: String;
  const AstrNomArq, AstrArquivo, AstrAssunto: String; const AblnBucket: Boolean; out AblnResult: Boolean): TReturnUploadFile;
var
  LUploadFile: TUploadFile;
  LstrImagemOtimizadaBase64: String;
begin
  LUploadFile := TUploadFile.Create;
  try
    LUploadFile.queueId  := AIDFila;
    LUploadFile.apiKey   := AApiKey;

    LUploadFile.fileName := ExtractFileNameCrossPlatform(AstrNomArq) + IIF(fEmptyStr(ExtractFileExt(AstrNomArq)), '.pdf', '');
    LUploadFile.mimeType := fRetMimeType(AstrNomArq + IIF(fEmptyStr(ExtractFileExt(AstrNomArq)), '.pdf', ''));
    LUploadFile.data     := fGetArquivo(AstrArquivo, AblnBucket, notWhatsapp, AblnResult, AstrNomArq);

    if not AblnResult then
      Exit(nil);

    if fEmptyStr(LUploadFile.data) then
      Exit(nil);

    LUploadFile.title    := AstrAssunto.Replace(ExtractFileExt(AstrAssunto), '');

    if (Pos('image/', LUploadFile.mimeType) > 0) then
    begin
      try
        if LUploadFile.mimeType = 'image/png' then
          LUploadFile.data := ConverterBase64PngParaJpg(LUploadFile.data)
        else if LUploadFile.mimeType = 'image/bmp' then
          LUploadFile.data := ConverterBase64BmpParaJpg(LUploadFile.data);

        LstrImagemOtimizadaBase64 := LUploadFile.data;
        if fOtimizaImagem(LstrImagemOtimizadaBase64) then
          LUploadFile.thumbnail := LstrImagemOtimizadaBase64;

        LUploadFile.fileName := ChangeFileExt(LUploadFile.fileName, '.jpg');
        LUploadFile.mimeType := 'image/jpeg';

        LUploadFile.width := fGetWidth(LUploadFile.data);
        LUploadFile.height := fGetHeight(LUploadFile.data);
      except
        AblnResult := False;
        Exit(nil);
      end;
    end;

    Result := TControllerUploadFile.fUploadFile(LUploadFile, AAutInc);
  finally
    FreeAndNil(LUploadFile);
  end;
end;

function TGatilhosImediatosMonitor.fExecutaClienteWhatsAppNaoOficial(
  const AAutInc: String; const AIDFila: Extended;
  const AApiKey: String): TResultEnvio;
const
  SQL_ENVIO_WHATSAPP =
    ' SELECT '+
    '   GAT_NUMWPP '+
    '  ,GAT_ASSUNT '+
    '  ,GAT_TEXINI '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", GAT_ARQBCK, GAT_PATARQ) AS GAT_ARQUIV '+
    '  ,GAT_OPEENV '+
    '  ,GAT_NOMARQ '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", "S", "N") AS GAT_BUCKET '+
    '  ,"N" AS GAT_BASE64 '+
    '  ,GAT_INFJSN '+
    ' FROM '+
    '   GATIME_WPPEMA '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC '+

    ' UNION ALL '+

    ' SELECT '+
    '   "" AS GAT_NUMWPP '+
    '  ,"" AS GAT_ASSUNT '+
    '  ,"" AS GAT_TEXINI '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", GAT_ARQBCK, GAT_ARQB64) AS GAT_ARQUIV '+
    '  ,"" AS GAT_OPEENV '+
    '  ,GAT_NOMARQ '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", "S", "N") AS GAT_BUCKET '+
    '  ,IF(IFNULL(GAT_ARQB64, "") <> "", "S", "N") AS GAT_BASE64 '+
    '  ,"" AS GAT_INFJSN '+
    ' FROM '+
    '   GATIME_WPPEMA_ARQUIVO '+
    ' WHERE '+
    '   GAT_SEQGER = :AUTINC ';

var
  LQryWhats: TUniQuery;
  LReturnUploadFile: TReturnUploadFile;
  LEnqueueMessageToSend: TEnqueueMessageToSend;

  DadosEnviaGatilhoWhatsapp: TDadosEnviaGatilhoWhatsapp;
  LNomeGatilho: String;
  LUnitDisparo: String;
  LQrCodePix: String;

  LTexto: String;
  blnEnviado: Boolean;
  LNumeroWpp: String;
  LAssunto: String;
  LCodOpe: String;

  blnResult: Boolean;

  function fVerificaSeArquivoExiste: Boolean;
  begin
    Result := False;

    if LQryWhats.FieldByName('GAT_BASE64').AsString = 'S' then
      Exit;

    if LQryWhats.FieldByName('GAT_BUCKET').AsString = 'S' then
      Exit;

    if fEmptyStr(LQryWhats.FieldByName('GAT_ARQUIV').AsString) then
      Exit;

    Result := True;
  end;

begin
  Result := tpNaoEnviado;
  blnEnviado := False;
  LNomeGatilho := EmptyStr;
  LUnitDisparo := EmptyStr;
  LQrCodePix := EmptyStr;

  LQryWhats := fCriaQuery;
  try
    LQryWhats.Close;
    LQryWhats.SQL.Clear;
    LQryWhats.SQL.Add(SQL_ENVIO_WHATSAPP);
    LQryWhats.ParamByName('AUTINC').AsString := AAutInc;
    LQryWhats.Open;

    if LQryWhats.IsEmpty then
      Exit;

    if fTipoObjeto(LQryWhats.FieldByName('GAT_INFJSN').AsString) in [typeTDadosEnviaGatilhoEmail, typeTDadosEnviaGatilhoSms] then
      Exit;

    if fEmptyStr(LQryWhats.FieldByName('GAT_NUMWPP').AsString) then
      Exit;

    LNumeroWpp := LQryWhats.FieldByName('GAT_NUMWPP').AsString;
    LAssunto   := LQryWhats.FieldByName('GAT_ASSUNT').AsString;
    LCodOpe    := LQryWhats.FieldByName('GAT_OPEENV').AsString;

    if fTipoObjeto(LQryWhats.FieldByName('GAT_INFJSN').AsString) = typeTDadosEnviaGatilhoWhatsapp then
    begin
      DadosEnviaGatilhoWhatsapp := TDadosEnviaGatilhoWhatsapp.FromJsonString(LQryWhats.FieldByName('GAT_INFJSN').AsString);
      try
        LNomeGatilho := DadosEnviaGatilhoWhatsapp.gatilho.nomeGatilho;
        LUnitDisparo := DadosEnviaGatilhoWhatsapp.gatilho.unitDisparo;
        LQrCodePix := DadosEnviaGatilhoWhatsapp.outrasInformacoes.qrCodePix;
      finally
        FreeAndNil(DadosEnviaGatilhoWhatsapp);
      end;
    end;

    while not LQryWhats.Eof do
    begin
      LTexto := StringReplace(LQryWhats.FieldByName('GAT_TEXINI').AsString, '<<csq>>', sLineBreak, [rfReplaceAll]);

      if (fVerificaSeArquivoExiste) and
         (not FileExists(LQryWhats.FieldByName('GAT_ARQUIV').AsString)) then
      begin
        LQryWhats.Next;
        Continue;
      end;

      LEnqueueMessageToSend := TEnqueueMessageToSend.Create(False, False, False, False);
      try
        if not fEmptyStr(StringReplace(LTexto, LQrCodePix, '', [rfReplaceAll])) then
          LTexto := StringReplace(LTexto, LQrCodePix, '', [rfReplaceAll])
        else
          LQrCodePix := EmptyStr;

        LEnqueueMessageToSend.text := LTexto;
        LEnqueueMessageToSend.queueId := AIDFila;
        LEnqueueMessageToSend.apiKey  := AApiKey;
        LEnqueueMessageToSend.number  := LNumeroWpp;

        repeat
          if fEmptyStr(LQryWhats.FieldByName('GAT_ARQUIV').AsString) then
            LQryWhats.Next;
        until ((not fEmptyStr(LQryWhats.FieldByName('GAT_ARQUIV').AsString)) or (LQryWhats.Eof));

        if not fEmptyStr(LQryWhats.FieldByName('GAT_ARQUIV').AsString) then
        begin
          LReturnUploadFile := fUploadFile(AIDFila,
                                           AApiKey,
                                           AAutInc,
                                           LQryWhats.FieldByName('GAT_NOMARQ').AsString,
                                           LQryWhats.FieldByName('GAT_ARQUIV').AsString,
                                           LAssunto,
                                           (LQryWhats.FieldByName('GAT_BUCKET').AsString = 'S'),
                                           blnResult);

          if not blnResult then
            Exit(tpTentarNovamente);

          try
            if Assigned(LReturnUploadFile) then
            begin
              LEnqueueMessageToSend.fileId  := LReturnUploadFile.fileId;
              LEnqueueMessageToSend.file_id := LReturnUploadFile.fileId;
            end;
          finally
            if Assigned(LReturnUploadFile) then
              FreeAndNil(LReturnUploadFile);
          end;
        end;

        blnEnviado := TControllerEnqueueMessageToSend.fSendMessage(LEnqueueMessageToSend,
                                                                 IIF(not fEmptyStr(LNomeGatilho), LNomeGatilho, LAssunto),
                                                                 IIF(not fEmptyStr(LUnitDisparo), LUnitDisparo, 'untProcessaGatilhosImediatos.Execute'),
                                                                 AAutInc,
                                                                 LCodOpe);

        if (blnEnviado) and (not fEmptyStr(LQrCodePix)) then
        begin
          LEnqueueMessageToSend.fileId := 0;
          LEnqueueMessageToSend.file_id := 0;
          LEnqueueMessageToSend.text := LQrCodePix;
          blnEnviado := blnEnviado and TControllerEnqueueMessageToSend.fSendMessage(LEnqueueMessageToSend,
                                                                                IIF(not fEmptyStr(LNomeGatilho), LNomeGatilho, LAssunto),
                                                                                IIF(not fEmptyStr(LUnitDisparo), LUnitDisparo, 'untProcessaGatilhosImediatos.Execute'),
                                                                                AAutInc,
                                                                                LCodOpe);

          LQrCodePix := EmptyStr;
        end;

        if not blnEnviado then
          Break;

        Sleep(1000);
      finally
        FreeAndNil(LEnqueueMessageToSend);
      end;

      LQryWhats.Next;
    end;

    Result := IIF(blnEnviado, tpEnviadoOK, tpEnviadoErro);
  finally
    FreeAndNil(LQryWhats);
  end;
end;

function TGatilhosImediatosMonitor.fExecutaClienteWhatsAppOficial(
  const AAutInc: String; const AIDFila: Extended;
  const AApiKey: String; const ATemplateId: String; const AVarsData: TArray<String>): TResultEnvio;
const
  SQL_ENVIO_WHATSAPP =
    ' SELECT '+
    '   GAT_NUMWPP '+
    '  ,GAT_ASSUNT '+
    '  ,GAT_TEXINI '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", GAT_ARQBCK, GAT_PATARQ) AS GAT_ARQUIV '+
    '  ,GAT_OPEENV '+
    '  ,GAT_NOMARQ '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", "S", "N") AS GAT_BUCKET '+
    '  ,"N" AS GAT_BASE64 '+
    '  ,GAT_INFJSN '+
    ' FROM '+
    '   GATIME_WPPEMA '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC '+

    ' UNION ALL '+

    ' SELECT '+
    '   "" AS GAT_NUMWPP '+
    '  ,"" AS GAT_ASSUNT '+
    '  ,"" AS GAT_TEXINI '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", GAT_ARQBCK, GAT_ARQB64) AS GAT_ARQUIV '+
    '  ,"" AS GAT_OPEENV '+
    '  ,GAT_NOMARQ '+
    '  ,IF(IFNULL(GAT_ARQBCK, "") <> "", "S", "N") AS GAT_BUCKET '+
    '  ,IF(IFNULL(GAT_ARQB64, "") <> "", "S", "N") AS GAT_BASE64 '+
    '  ,"" AS GAT_INFJSN '+
    ' FROM '+
    '   GATIME_WPPEMA_ARQUIVO '+
    ' WHERE '+
    '   GAT_SEQGER = :AUTINC ';

var
  LQryWhats: TUniQuery;
  LReturnUploadFile: TReturnUploadFile;
  LEnqueueMessageToSend: TEnqueueMessageToSend;
  DadosEnviaGatilhoWhatsapp: TDadosEnviaGatilhoWhatsapp;
  LNomeGatilho: String;
  LUnitDisparo: String;
  blnEnviado: Boolean;
  blnArquivosProntos: Boolean;
  LNomeArquivo: String;
  LArquivos: TArray<TRecArquivosGatilhos>;
  intContador: Integer;
  blnResult: Boolean;

  function fVerificaSeArquivoExiste: Boolean;
  begin
    Result := False;

    if LQryWhats.FieldByName('GAT_BASE64').AsString = 'S' then
      Exit;

    if LQryWhats.FieldByName('GAT_BUCKET').AsString = 'S' then
      Exit;

    if fEmptyStr(LQryWhats.FieldByName('GAT_ARQUIV').AsString) then
      Exit;

    Result := True;
  end;

begin
  Result := tpNaoEnviado;
  blnArquivosProntos := False;
  LNomeGatilho := EmptyStr;
  LUnitDisparo := EmptyStr;

  LQryWhats := fCriaQuery;
  try
    LQryWhats.Close;
    LQryWhats.SQL.Clear;
    LQryWhats.SQL.Add(SQL_ENVIO_WHATSAPP);
    LQryWhats.ParamByName('AUTINC').AsString := AAutInc;
    LQryWhats.Open;

    if LQryWhats.IsEmpty then
      Exit;

    if fTipoObjeto(LQryWhats.FieldByName('GAT_INFJSN').AsString) in [typeTDadosEnviaGatilhoEmail, typeTDadosEnviaGatilhoSms] then
      Exit;

    if fEmptyStr(LQryWhats.FieldByName('GAT_NUMWPP').AsString) then
      Exit;

    if fTipoObjeto(LQryWhats.FieldByName('GAT_INFJSN').AsString) = typeTDadosEnviaGatilhoWhatsapp then
    begin
      DadosEnviaGatilhoWhatsapp := TDadosEnviaGatilhoWhatsapp.FromJsonString(LQryWhats.FieldByName('GAT_INFJSN').AsString);
      try
        LNomeGatilho := DadosEnviaGatilhoWhatsapp.gatilho.nomeGatilho;
        LUnitDisparo := DadosEnviaGatilhoWhatsapp.gatilho.unitDisparo;
      finally
        FreeAndNil(DadosEnviaGatilhoWhatsapp);
      end;
    end;

    while not LQryWhats.Eof do
    begin
      if (fVerificaSeArquivoExiste) and
         (not FileExists(LQryWhats.FieldByName('GAT_ARQUIV').AsString)) then
      begin
        LQryWhats.Next;
        Continue;
      end;

      if not fEmptyStr(LQryWhats.FieldByName('GAT_ARQUIV').AsString) then
      begin
        LNomeArquivo := LQryWhats.FieldByName('GAT_NOMARQ').AsString;
        LNomeArquivo := LNomeArquivo.Replace(' ', '_');

        SetLength(LArquivos, Length(LArquivos)+1);
        LArquivos[High(LArquivos)] := TRecArquivosGatilhos.Create(LNomeArquivo,
                                                                  LQryWhats.FieldByName('GAT_ARQUIV').AsString,
                                                                  EmptyStr,
                                                                  tpaNone,
                                                                  (LQryWhats.FieldByName('GAT_BUCKET').AsString = 'S'));
      end;

      LQryWhats.Next;
    end;

    if Length(LArquivos) > 0 then
    begin
      repeat
        for intContador := 0 to Length(LArquivos)-1 do
        begin
          LReturnUploadFile := fUploadFile(AIDFila,
                                           AApiKey,
                                           AAutInc,
                                           LArquivos[intContador].Titulo,
                                           LArquivos[intContador].Arquivo,
                                           LArquivos[intContador].Titulo,
                                           LArquivos[intContador].ArmazenadoNoBucket,
                                           blnResult);

          if not blnResult then
            Exit(tpTentarNovamente);

          try
            if Assigned(LReturnUploadFile) then
              LArquivos[intContador].Url := fRetUrlArquivo(AIDFila, AApiKey, LReturnUploadFile.fileId);
          finally
            if Assigned(LReturnUploadFile) then
              FreeAndNil(LReturnUploadFile);
          end;
        end;

        if Length(LArquivos) = 1 then
          blnArquivosProntos := True
        else
        begin
          LArquivos := fCriarArquivoPdfUnico(LArquivos);
          if (Length(LArquivos) = 1) and (fEmptyStr(LArquivos[0].Arquivo)) then
            Exit(tpLayoutMultiplosArquivosPdfNaoDisponivel);
        end;

      until blnArquivosProntos;
    end;

    LQryWhats.First;

    LEnqueueMessageToSend := TEnqueueMessageToSend.Create(False, False, False, False);
    try
      LEnqueueMessageToSend.text := StringReplace(LQryWhats.FieldByName('GAT_TEXINI').AsString, '<<csq>>', sLineBreak, [rfReplaceAll]);
      LEnqueueMessageToSend.queueId := AIDFila;
      LEnqueueMessageToSend.apiKey  := AApiKey;
      LEnqueueMessageToSend.number  := '55'+fTiraCaracEspeciais(LQryWhats.FieldByName('GAT_NUMWPP').AsString, True, True, True, True, True, True);
      LEnqueueMessageToSend.templateId := StrToIntDef(ATemplateId, 0);

      if LEnqueueMessageToSend.templateId = 0 then
        Exit;

      LEnqueueMessageToSend.varsdata := fAjustaVariaveisApiOficial(AVarsData);

      if Length(LArquivos) > 0 then
      begin
        LEnqueueMessageToSend.headerFile := LArquivos[0].Url;
        LEnqueueMessageToSend.headerFileName := LArquivos[0].Titulo;

        if Length(LArquivos) = 1 then
        begin
          if Pos('image/', fRetMimeType(LArquivos[0].Titulo + IIF(fEmptyStr(ExtractFileExt(LArquivos[0].Titulo)), '.pdf', ''))) > 0 then
            LEnqueueMessageToSend.headerFileName := ChangeFileExt(LArquivos[0].Titulo, '.jpg');
        end;
      end;

      blnEnviado := TControllerEnqueueMessageToSend.fSendMessage(LEnqueueMessageToSend,
                                                               IIF(not fEmptyStr(LNomeGatilho), LNomeGatilho, LQryWhats.FieldByName('GAT_ASSUNT').AsString),
                                                               IIF(not fEmptyStr(LUnitDisparo), LUnitDisparo, 'untProcessaGatilhosImediatos.Execute'),
                                                               AAutInc,
                                                               LQryWhats.FieldByName('GAT_OPEENV').AsString);

      Result := IIF(blnEnviado, tpEnviadoOK, tpEnviadoErro);
    finally
      FreeAndNil(LEnqueueMessageToSend);
    end;
  finally
    FreeAndNil(LQryWhats);
  end;
end;

function TGatilhosImediatosMonitor.fExecute: TResultExecute;
begin
  //do nothing
end;

function TGatilhosImediatosMonitor.fRetUrlArquivo(const AextIdFila: Extended; const AstrApiKey: String; const AfileId: Extended): String;
begin
  Result := TGenerateDownloadUrl.fNew.fGenerateUrl(AstrApiKey, AextIdFila, AfileId);
  Result := Result.Replace('download=true', 'download=false');
end;

function TGatilhosImediatosMonitor.fCriarArquivoPdfUnico(const ARecArquivos: TArray<TRecArquivosGatilhos>): TArray<TRecArquivosGatilhos>;
begin
  SetLength(Result, 1);
  Result[0] := TRecArquivosGatilhos.Create('ARQUIVOS.pdf', fGerarPdfLinksWhatsappBase64(ARecArquivos), EmptyStr);
end;

function TGatilhosImediatosMonitor.fAjustaVariaveisApiOficial(const AVarsData: TArray<String>): TArray<String>;
var
  intContador: Integer;
begin
  Result := AVarsData;

  for intContador := 0 to High(Result) do
  begin
    if fEmptyStr(Result[intContador]) then
      Result[intContador] := 'N/A';
  end;
end;

procedure TGatilhosImediatosMonitor.pAjustaFilaJson(const AJson: String; var AIDFila: Extended; var AApiKey: String; var ATemplateId: String; var AVarsData: TArray<String>);
var
  DadosEnviaWhatsapp: TDadosEnviaWhatsapp;
  DadosEnviaGatilhoWhatsapp: TDadosEnviaGatilhoWhatsapp;

  LIDFila: Extended;
  LApiKey: String;
begin
  if fEmptyStr(AJson) then
    Exit;

  if fTipoObjeto(AJson) = typeTDadosEnviaWhatsapp then
  begin
    DadosEnviaWhatsapp := TDadosEnviaWhatsapp.FromJsonString(AJson);
    try
      LIDFila := StrToFloatDef(DadosEnviaWhatsapp.fila.id, 0);
      LApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [LIDFila]);
      ATemplateId := DadosEnviaWhatsapp.template.id;
      AVarsData := DadosEnviaWhatsapp.template.varsdata;
      if not fEmptyStr(LApiKey) then
      begin
        AIDFila := LIDFila;
        AApiKey := LApiKey;
      end;
    finally
      FreeAndNil(DadosEnviaWhatsapp);
    end;
  end
  else if fTipoObjeto(AJson) = typeTDadosEnviaGatilhoWhatsapp then
  begin
    DadosEnviaGatilhoWhatsapp := TDadosEnviaGatilhoWhatsapp.FromJsonString(AJson);
    try
      LIDFila := StrToFloatDef(DadosEnviaGatilhoWhatsapp.fila.id, 0);
      LApiKey := fCampoTabela('FIL_KEYAPI', 'CADFIL', ['FIL_IDFILA'], [LIDFila]);
      ATemplateId := DadosEnviaGatilhoWhatsapp.template.id;
      AVarsData := DadosEnviaGatilhoWhatsapp.template.varsdata;
      if not fEmptyStr(LApiKey) then
      begin
        AIDFila := LIDFila;
        AApiKey := LApiKey;
      end;
    finally
      FreeAndNil(DadosEnviaGatilhoWhatsapp);
    end;
  end;
end;

function TGatilhosImediatosMonitor.fGerarArquivo(intStatus: Integer; strCodGatilho, strCodOpe, strTitulo, strData, strInformacao: String): String;
var
  frmGatilhosImediatosImagemAnexo: TfrmGatilhosImediatosImagemAnexo;
begin
 {$IFDEF LINUX}
  frmGatilhosImediatosImagemAnexo := TfrmGatilhosImediatosImagemAnexo.Create(nil);
 {$ELSE}
  pCriarFormularios(TfrmGatilhosImediatosImagemAnexo, frmGatilhosImediatosImagemAnexo);
 {$ENDIF}
  try
    Result := frmGatilhosImediatosImagemAnexo.fCriarPdf(intStatus, strCodGatilho, strCodOpe, strTitulo, strData, strInformacao);
  finally
    pFreeAndNil(frmGatilhosImediatosImagemAnexo);
  end;
end;

{$IFDEF LINUX}
procedure pImagemFromBase64(const strBase64: string; var objPicture : FMX.Graphics.TBitmap);
var
  LInput: TStringStream;
  LOutput: TMemoryStream;
begin
  LInput := TStringStream.Create;
  try
    LInput.WriteString(strBase64);
    LOutput := TMemoryStream.Create;
    try
      LInput.Position := 0;
      TNetEncoding.Base64.Decode(LInput, LOutput);
      LOutput.Position := 0;
      objPicture.LoadFromStream(LOutput);
    finally
      LOutput.Free;
    end;
  finally
    LInput.Free;
  end;
end;
{$ENDIF}

function TGatilhosImediatosMonitor.fGetHeight(ABase64: String): Extended;
var
{$IFDEF LINUX}
  LPicture : FMX.Graphics.TBitmap;
{$ELSE}
  LPicture : TPicture;
{$ENDIF}
begin
{$IFDEF LINUX}
  LPicture := FMX.Graphics.TBitmap.Create;
{$ELSE}
  LPicture := TPicture.Create;
{$ENDIF}
  try
    pImagemFromBase64(ABase64, LPicture);
    Result := LPicture.Height;
  finally
    FreeAndNil(LPicture);
  end;
end;

function TGatilhosImediatosMonitor.fGetWidth(ABase64: String): Extended;
var
{$IFDEF LINUX}
  LPicture : FMX.Graphics.TBitmap;
{$ELSE}
  LPicture : TPicture;
{$ENDIF}
begin
{$IFDEF LINUX}
  LPicture := FMX.Graphics.TBitmap.Create;
{$ELSE}
  LPicture := TPicture.Create;
{$ENDIF}
  try
    pImagemFromBase64(ABase64, LPicture);
    Result := LPicture.Width;
  finally
    FreeAndNil(LPicture);
  end;
end;

function TGatilhosImediatosMonitor.fRetErrosWhatsApp(AAutInc: String): String;
var
  LQryErros: TUniQuery;
begin
  LQryErros := fCriaQuery;

  try
    Result := EmptyStr;

    LQryErros.Close;
    LQryErros.SQL.Clear;
    LQryErros.SQL.Add('SELECT LOG_RESULT');
    LQryErros.SQL.Add('FROM LOGAPI');
    LQryErros.SQL.Add('WHERE LOG_SEQFGO = :SEQFGO');
    LQryErros.SQL.Add('AND LOG_LOGAPI = "QUALIZAP"');
    LQryErros.SQL.Add('AND LOG_STATUS <> 200');
    LQryErros.SQL.Add('ORDER BY LOG_DTAENT DESC, LOG_HORENT DESC LIMIT 1');

    LQryErros.ParamByName('SEQFGO').AsString := AAutInc;

    LQryErros.Open;

    if LQryErros.IsEmpty then
      Exit;

    Result := LQryErros.FieldByName('LOG_RESULT').AsString
  finally
    FreeAndNil(LQryErros);
  end;
end;

function TGatilhosImediatosMonitor.fGetArquivoBucket(const AstrArquivo: String; AstrNomeArquivo: String = ''): String;
var
  LBytesStream: TBytesStream;
begin
  Result := FPASTATEMPORARIA + IIF(fEmptyStr(AstrNomeArquivo), ExtractFileNameCrossPlatform(AstrArquivo.Replace(fCfgSis('URLBKT')+'/', '')), AstrNomeArquivo);

  LBytesStream := TBucketCitel.Instance.fGetFile(AstrArquivo);
  if not Assigned(LBytesStream) then
    Exit(EmptyStr);
  try
    LBytesStream.SaveToFile(Result);
  finally
    FreeAndNil(LBytesStream);
  end;
end;

function TGatilhosImediatosMonitor.fGetArquivo(AstrArquivo: String; AblnBucket: Boolean; tpGatilho: TTipoGatilho; out AblnResult: Boolean; AstrNomeArquivo: String = ''): String;
begin
  AblnResult := True;

  if AblnBucket then
    AstrArquivo := fGetArquivoBucket(AstrArquivo, AstrNomeArquivo);

  Result := AstrArquivo;

  if (tpGatilho = notWhatsapp) then
  begin
    if (not fEhArquivoBase64(AstrArquivo)) then
    begin
      AblnResult := FileExists(AstrArquivo);
      if AblnResult then
      begin
        Result := fRetornarArquivoBase64(AstrArquivo);
        DeleteFile(AstrArquivo);
      end;
    end;
  end
  else if (tpGatilho = notEmail) then
  begin
    if (fEhArquivoBase64(AstrArquivo)) then
      Result := fRetBase64ParaArquivo(AstrArquivo, FPASTATEMPORARIA + AstrNomeArquivo);

    AblnResult := FileExists(Result);
  end;
end;

function TGatilhosImediatosMonitor.fRetMimeType(ATexto: String): String;
var
  LExtensao: String;
begin
  Result := EmptyStr;

  if fEmptyStr(ATexto) then
    Exit;

  LExtensao := ExtractFileExt(ATexto);

  Delete(LExtensao, Pos('.', LExtensao), 1);

  Result := fCampoTabela('GAT_SUBTIP', 'GATIME_WPPEMA_MIMETYPE', ['GAT_EXTARQ'], [AnsiUpperCase(LExtensao)], False);

  if fEmptyStr(Result) then
    Result := 'application/pdf';
end;

function TGatilhosImediatosMonitor.fRetornaAnexosEmail(AAutInc: String; out AblnResult: Boolean): String;
var
  LqryAnexos: TUniQuery;
begin
  AblnResult := True;

  LqryAnexos := fCriaQuery;
  try
    Result := EmptyStr;

    LqryAnexos.Close;
    LqryAnexos.SQL.Clear;
    LqryAnexos.SQL.Add('SELECT IF(IFNULL(GAT_ARQBCK, "") <> "", GAT_ARQBCK, GAT_ARQB64) AS GAT_ARQUIV, GAT_NOMARQ, IF(IFNULL(GAT_ARQBCK, "") <> "", "S", "N") AS GAT_BUCKET');
    LqryAnexos.SQL.Add('FROM GATIME_WPPEMA_ARQUIVO');
    LqryAnexos.SQL.Add('WHERE GAT_SEQGER = :SEQGER');
    LqryAnexos.ParamByName('SEQGER').AsString := AAutInc;
    LqryAnexos.Open;

    if LqryAnexos.IsEmpty then
      Exit;

    while not LqryAnexos.Eof do
    begin
      if not fEmptyStr(Result) then
        Result := Result + ';';

      Result := Result + fGetArquivo(LqryAnexos.FieldByName('GAT_ARQUIV').AsString, (LqryAnexos.FieldByName('GAT_BUCKET').AsString = 'S'), notEmail, AblnResult, LqryAnexos.FieldByName('GAT_NOMARQ').AsString);

      if not AblnResult then
        Break;

      LqryAnexos.Next;
    end;
  finally
    FreeAndNil(LqryAnexos);
  end;
end;

end.
