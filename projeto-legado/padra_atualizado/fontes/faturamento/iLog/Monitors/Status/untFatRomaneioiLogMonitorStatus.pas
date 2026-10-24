unit untFatRomaneioiLogMonitorStatus;

interface

uses
{$IFDEF LINUX}
  Services.Core.Connection.Interfaces,
  Services.Core.Connection.Manager,
  Services.Core.Task.Monitor,
{$ELSE }
  Uni,
  Forms,
  CRAccess,
  untUtilMonitor,
{$ENDIF LINUX}
  TypInfo,
  Data.DB,
  System.Classes,
  untFatRomaneioiLogMonitorStatus.Interfaces,
  untModelEntrega;

const
  spIdMonitoriLogStatus            = 'MONITOR_ILOG_STATUS_%s';
  spIdInactivityMonitoriLogStatus  = 'TEST_INACTIVITY_ILOGSTATUS_%s';
  spiLogMonitorStatusExeName       = 'iLogMonitorStatus.exe';
  spTimeLimitMonitoriLogStatus     = 30;
  spAttemptsLimitMonitoriLogStatus = 100;
  spAttemptsLockMonitoriLogStatus  = 30;

  URL_CARGA_ITEM = 'http://api.taentregue.com.br/v2/entrega/carga-item/';
  STATUS_ENTREGUE = 'ENTREGUE';
  STATUS_DEVOLUCAO_TOTAL = 'DEVOLUCAO_TOTAL';

  sqlRomaneioiLog =
    ' SELECT' +
    '   R.AUTOINCREM,' +
    '   D.DET_NUMROM,' +
    '   D.DET_EMPROM,' +
    '   D.DET_NUMDOC,' +
    '   D.DET_STATUS,'  +
    '   R.GER_NUMROM,'  +
    '   R.GER_EMPROM,'  +
    '   R.GER_NUMDOC,'  +
    '   R.GER_CODEMP,'  +
    '   R.GER_ESPDOC,'  +
    '   R.GER_CODCLI,'  +
    '   R.GER_CODVEN,'  +
    '   R.GER_CODMOT,'  +
    '   R.GER_DTAROM,'  +
    '   R.GER_HORROM'  +
    ' FROM ILOGDET D ' +
    ' LEFT JOIN ROMGERX R ON D.DET_NUMROM = R.GER_NUMROM AND ' +
    '                        D.DET_EMPROM = R.GER_EMPROM AND ' +
    '                        D.DET_NUMDOC = R.GER_NUMDOC AND ' +
    '                        D.DET_CODEMP = R.GER_CODEMP AND ' +
    '                        D.DET_ESPDOC = R.GER_ESPDOC AND ' +
    '                        D.DET_CODCLI = R.GER_CODCLI ' +
    ' WHERE DET_STATUS = "I"' +
    '   AND DET_EMPROM = :EMPROM';

type
  TMonitoriLogStatus = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    function SendGet(const AUrl: String; out AJsonResponse: String): Boolean;
    procedure UpdateStatus(const Status: String; const DataHoraOcorrencia: TDateTime);
  protected
    FParams: IParamiLog;

    constructor Create(AParams: IParamiLog);

    procedure AtualizaRomaneio(const AEntregasCargaItem: TModelEntregaCargaItem);

  public
    destructor Destroy; Override;

    procedure pExecute;
    procedure pExecuteAll;

    class function New(AParams: IParamiLog = nil):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
  end;

  TParamiLogStatus = class sealed(TInterfacedObject, IParamiLog)
  private
    FIdCarga: String;
    FNumRom: String;
    FEmpRom: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCLi: String;
    FCodVen: String;
    FCodMot: String;
    FDtaRom: TDateTime;
    FHorRom: TDateTime;
    FObserv: String;
  protected
    constructor Create;
  public
    function IdCarga(const AValue: String): IParamiLog; overload;
    function NumRom(const AValue: String): IParamiLog; overload;
    function EmpRom(const AValue: String): IParamiLog; overload;
    function NumDoc(const AValue: String): IParamiLog; overload;
    function EspDoc(const AValue: String): IParamiLog; overload;
    function CodEmp(const AValue: String): IParamiLog; overload;
    function CodCli(const AValue: String): IParamiLog; overload;
    function CodVen(const AValue: String): IParamiLog; overload;
    function CodMot(const AValue: String): IParamiLog; overload;
    function DtaRom(const AValue: TDateTime): IParamiLog; overload;
    function HorRom(const AValue: TDateTime): IParamiLog; overload;
    function Observ(const AValue: String): IParamiLog; overload;

    function IdCarga: String; overload;
    function NumRom: String; overload;
    function EmpRom: String; overload;
    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function CodCli: String; overload;
    function CodVen: String; overload;
    function CodMot: String; overload;
    function DtaRom: TDateTime; overload;
    function HorRom: TDateTime; overload;
    function Observ: String; overload;

    class function New: IParamiLog;
  end;

var
  Token: string;
  Tempo: Integer;

implementation

uses
{$IFDEF LINUX}
  Services.Core.Utils,
  Services.Core.Settings,
  Services.Core.Task.Lock,
{$ELSE }
  untFuncoesSimples,
  untSeqTmp,
{$ENDIF LINUX}
  System.SysUtils,
  System.StrUtils,
  System.DateUtils, untRest, Rest.Json, System.Json, Variants, untRomGer;

{ TMonitoriLogStatus }

procedure TMonitoriLogStatus.AtualizaRomaneio(const AEntregasCargaItem: TModelEntregaCargaItem);
begin
  if AEntregasCargaItem.entrega.status = STATUS_ENTREGUE then
  begin
    if fBaixarDocumento(
      FParams.NumDoc,
      FParams.EspDoc,
      FParams.CodEmp,
      FParams.CodCli,
      FParams.NumRom,
      '',
      AEntregasCargaItem.entrega.dataUltimaOcorrencia,
      AEntregasCargaItem.entrega.dataUltimaOcorrencia,
      'S') then
      UpdateStatus(
        AEntregasCargaItem.entrega.status,
        AEntregasCargaItem.entrega.dataUltimaOcorrencia);
  end
  else
  if AEntregasCargaItem.entrega.status = STATUS_DEVOLUCAO_TOTAL then
  begin
    if fRemoverDocumento(
      FParams.NumDoc,
      FParams.EspDoc,
      FParams.CodEmp,
      FParams.CodCli,
      FParams.NumRom,
      FParams.CodVen,
      FParams.CodMot,
      FParams.DtaRom,
      FParams.HorRom,
      FParams.Observ) then
      UpdateStatus(
        AEntregasCargaItem.entrega.status,
        AEntregasCargaItem.entrega.dataUltimaOcorrencia);
  end;
end;

constructor TMonitoriLogStatus.Create(AParams: IParamiLog);
begin
  FParams := AParams;
end;

destructor TMonitoriLogStatus.Destroy;
begin

  inherited;
end;

class function TMonitoriLogStatus.New(AParams: IParamiLog): IMonitorProcedure;
begin
  Result := TMonitoriLogStatus.Create(AParams);
end;

function TMonitoriLogStatus.SendGet(const AUrl: String; out AJsonResponse: String): Boolean;
begin
  Result := False;

  AJsonResponse := fCommunicate(AUrl, 'GET', '', Token);
  if AJsonResponse[1] <> '*' then
    Result := True;
//  else
//    SaveError(Response);
end;

procedure TMonitoriLogStatus.UpdateStatus(const Status: String; const DataHoraOcorrencia: TDateTime);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();
  Try
    LQry.SQL.Add('UPDATE ILOGDET SET');
    LQry.SQL.Add('DET_STATUS = :STATUS,');
    LQry.SQL.Add('DET_DTAOCO = :DTAOCO,');
    LQry.SQL.Add('DET_HOROCO = :HOROCO');
    LQry.SQL.Add('WHERE');
    LQry.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
    LQry.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
    LQry.SQL.Add('  DET_CODEMP = :CODEMP AND ');
    LQry.SQL.Add('  DET_CODCLI = :CODCLI AND ');
    LQry.SQL.Add('  DET_NUMROM = :NUMROM AND ');
    LQry.SQL.Add('  DET_EMPROM = :EMPROM ');

    if Status = STATUS_ENTREGUE then
      LQry.ParamByName('STATUS').AsString := 'E'
    else
    if Status = STATUS_DEVOLUCAO_TOTAL then
      LQry.ParamByName('STATUS').AsString := 'D';

    LQry.ParamByName('DTAOCO').AsDateTime := DataHoraOcorrencia;
    LQry.ParamByName('HOROCO').AsDateTime := DataHoraOcorrencia;

    LQry.ParamByName('NUMDOC').AsString := FParams.NumDoc;
    LQry.ParamByName('ESPDOC').AsString := FParams.EspDoc;
    LQry.ParamByName('CODEMP').AsString := FParams.CodEmp;
    LQry.ParamByName('CODCLI').AsString := FParams.CodCli;
    LQry.ParamByName('NUMROM').AsString := FParams.NumRom;
    LQry.ParamByName('EMPROM').AsString := FParams.EmpRom;

    LQry.ExecSQL;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

procedure TMonitoriLogStatus.pExecute;
var
  LJsonResponse: String;
  LJsonArray: TJsonArray;
  LEntregasCargaItem: TModelEntregaCargaItem;
begin
  Try
    if SendGet(URL_CARGA_ITEM + FParams.IdCarga, LJsonResponse) then
    begin
      LJsonArray := TJsonArray(TJSONObject.ParseJSONValue(LJsonResponse));
      try
        if LJsonArray.Count > 0 then
        begin
          LEntregasCargaItem := TJson.JsonToObject<TModelEntregaCargaItem>(TJsonObject(LJsonArray.Items[0]), []);
          try
            AtualizaRomaneio(LEntregasCargaItem);
          finally
            FreeAndNil(LEntregasCargaItem);
          end;
        end;
      finally
        FreeAndNil(LJsonArray);
      end;
    end;
  Except
    On E: Exception Do
    {$IFDEF LINUX}
      Raise Exception.Create('[TMonitoriLogStatus.pExecute] - ' + E.Message);
    {$ELSE }
      pMensagensErro(E.Message, '[TMonitoriLogStatus.pExecute]');
    {$ENDIF LINUX}
  End;
end;

procedure TMonitoriLogStatus.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlRomaneioiLog);
    LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
    LQry.Open();

    While (Not LQry.Eof) Do
    Begin
      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      TMonitoriLogStatus.New(
        TParamiLogStatus.New()
          .IdCarga(LQry.FieldByName('AUTOINCREM').AsString)
          .NumRom(LQry.FieldByName('DET_NUMROM').AsString)
          .EmpRom(LQry.FieldByName('DET_EMPROM').AsString)
          .NumDoc(LQry.FieldByName('GER_NUMDOC').AsString)
          .EspDoc(LQry.FieldByName('GER_ESPDOC').AsString)
          .CodEmp(LQry.FieldByName('GER_CODEMP').AsString)
          .CodCli(LQry.FieldByName('GER_CODCLI').AsString)
          .CodVen(LQry.FieldByName('GER_CODVEN').AsString)
          .CodMot(LQry.FieldByName('GER_CODMOT').AsString)
          .DtaRom(LQry.FieldByName('GER_DTAROM').AsDateTime)
          .HorRom(LQry.FieldByName('GER_HORROM').AsDateTime)
          .Observ('')
        ).pExecute();

      If (LQry.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitoriLogStatus, [VS_strCodEmp]));
        Sleep(2000);
        {$IFNDEF LINUX}
        pTrimAppMemorySize();
        {$ENDIF LINUX}
      End;

      LQry.Next();
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;

  Sleep(Tempo * 60 * 1000);
end;

{ TParamiLogStatus }

function TParamiLogStatus.IdCarga(const AValue: String): IParamiLog;
begin
  Result := Self;
  FIdCarga := AValue;
end;

function TParamiLogStatus.EmpRom: String;
begin
  Result := FEmpRom;
end;

function TParamiLogStatus.EmpRom(const AValue: String): IParamiLog;
begin
  Result := Self;
  FEmpRom := AValue;
end;

function TParamiLogStatus.EspDoc: String;
begin
  Result := FEspDoc;
end;

function TParamiLogStatus.HorRom: TDateTime;
begin
  Result := FHorRom;
end;

function TParamiLogStatus.HorRom(const AValue: TDateTime): IParamiLog;
begin
  Result := Self;
  FHorRom := AValue;
end;

function TParamiLogStatus.EspDoc(const AValue: String): IParamiLog;
begin
  Result := Self;
  FEspDoc := AValue;
end;

function TParamiLogStatus.IdCarga: String;
begin
  Result := FIdCarga;
end;

function TParamiLogStatus.CodCli(const AValue: String): IParamiLog;
begin
  Result := Self;
  FCodCli := AValue;
end;

function TParamiLogStatus.CodCli: String;
begin
  Result := FCodCli;
end;

function TParamiLogStatus.CodEmp: String;
begin
  Result := FCodEmp;
end;

function TParamiLogStatus.CodMot(const AValue: String): IParamiLog;
begin
  Result := Self;
  FCodMot := AValue;
end;

function TParamiLogStatus.CodMot: String;
begin
  Result := FCodMot;
end;

function TParamiLogStatus.CodVen: String;
begin
  Result := FCodVen;
end;

function TParamiLogStatus.CodVen(const AValue: String): IParamiLog;
begin
  Result := Self;
  FCodVen := AValue;
end;

function TParamiLogStatus.CodEmp(const AValue: String): IParamiLog;
begin
  Result := Self;
  FCodEmp := AValue;
end;

constructor TParamiLogStatus.Create;
begin
  FIdCarga := '';
  FNumRom := '';
  FEmpRom := '';
  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FCodCLi := '';
  FCodVen := '';
  FCodMot := '';
  FDtaRom := 0;
  FHorRom := 0;
  FObserv := '';
end;

function TParamiLogStatus.DtaRom: TDateTime;
begin
  Result := FDtaRom;
end;

function TParamiLogStatus.DtaRom(const AValue: TDateTime): IParamiLog;
begin
  Result := Self;
  FDtaRom := AValue;
end;

class function TParamiLogStatus.New: IParamiLog;
begin
  Result := TParamiLogStatus.Create();
end;

function TParamiLogStatus.NumDoc(const AValue: String): IParamiLog;
begin
  Result := Self;
  FNumDoc := AValue;
end;

function TParamiLogStatus.NumDoc: String;
begin
  Result := FNumDoc;
end;

function TParamiLogStatus.NumRom: String;
begin
  Result := FNumRom;
end;

function TParamiLogStatus.Observ: String;
begin
  Result := FObserv;
end;

function TParamiLogStatus.Observ(const AValue: String): IParamiLog;
begin
  Result := Self;
  FObserv := AValue;
end;

function TParamiLogStatus.NumRom(const AValue: String): IParamiLog;
begin
  Result := Self;
  FNumRom := AValue;
end;

end.
