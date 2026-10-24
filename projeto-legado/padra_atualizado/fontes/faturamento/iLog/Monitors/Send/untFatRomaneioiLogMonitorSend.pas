unit untFatRomaneioiLogMonitorSend;

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
  untFatRomaneioiLogMonitorSend.Interfaces,
  untModelCarga;

const
  spIdMonitoriLogSend            = 'MONITOR_ILOG_SEND_%s';
  spIdInactivityMonitoriLogSend  = 'TEST_INACTIVITY_ILOGSEND_%s';
  spiLogMonitorSendExeName       = 'iLogMonitorSend.exe';
  spTimeLimitMonitoriLogSend     = 30;
  spAttemptsLimitMonitoriLogSend = 100;
  spAttemptsLockMonitoriLogSend  = 30;

  URL_CARGA = 'http://api.taentregue.com.br/v1/carga';
  URL_CLIENTE = 'http://api.taentregue.com.br/v1/cliente';

  sqlRomaneioiLog =
    ' SELECT' +
    '   AUTOINCREM,' +
    '   ILO_NUMROM,' +
    '   ILO_EMPROM,' +
    '   ILO_STATUS' +
    ' FROM ROMILOG' +
    ' WHERE ILO_STATUS = "A"' +
    '   AND ILO_EMPROM = :EMPROM';

  sqlLimit = ' LIMIT 250';

type
  TMonitoriLogSend = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  protected
    FParams: IParamiLog;

    constructor Create(AParams: IParamiLog);

    function BuildJson(const ADataSet: TDataSet): string;

    function SendCliente(const AJson: string): Boolean;
    function SendCarga(const AJson: string): Boolean;
    function SendPOST(const AUrl, AJson: String): Boolean;

    procedure UpdateSendSuccessfully(const ADataSet: TDataSet);
    procedure SaveError(AError: string);
  public
    destructor Destroy; Override;

    procedure pExecute;
    procedure pExecuteAll;

    class function New(AParams: IParamiLog = nil):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
  end;

  TParamiLogSend = class sealed(TInterfacedObject, IParamiLog)
  private
    FAutoincrem: String;
    FCodRom: String;
  protected
    constructor Create;
  public
    function Autoincrem(const AValue: String): IParamiLog; overload;
    function CodRom(const AValue: String): IParamiLog; overload;

    function Autoincrem: String; overload;
    function CodRom: String; overload;

    class function New: IParamiLog;
  end;

function sqlCarregarRomaneioiLog: string;
function fEnderecoPelaEntCli(strTabela: String=''; strAlias: String=''): String;

var
  Token: string;
  OpcRom: string;

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
  System.DateUtils, untRest, Rest.Json, System.Json;

{ TMonitoriLogSend }

function TMonitoriLogSend.SendPOST(const AUrl, AJson: String): Boolean;
var
  Response: String;
  JsonResponse: TJsonObject;
  Status: String;
  Erro: String;
begin
  Result := False;

  Response := fCommunicate(AUrl, 'POST', AJson, Token);
  if Response[1] <> '*' then
  begin
    JsonResponse := TJsonObject(TJSONObject.ParseJSONValue(Response));
    try
      if JsonResponse.TryGetValue<string>('status', Status) then
      begin
        if Status = 'SUCESSO' then
          Result := True
        else
        begin
          if JsonResponse.TryGetValue<string>('erro', Erro) then
            SaveError(Erro)
          else
            SaveError(Response);
        end

      end;
    finally
      JsonResponse.Free;
    end;
  end
  else
    SaveError(Response);
end;

procedure TMonitoriLogSend.UpdateSendSuccessfully(const ADataSet: TDataSet);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Try
    LQry := fCriaQuery();

    Try
      LQry.SQL.Clear();
      LQry.SQL.Add('UPDATE ROMILOG SET');
      LQry.SQL.Add('  ILO_STATUS = "I",');
      LQry.SQL.Add('  ILO_DTAENV = :DTAENV,');
      LQry.SQL.Add('  ILO_HORENV = :HORENV');
      LQry.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');
      LQry.ParamByName('AUTOINCREM').AsString := FParams.Autoincrem;

      Try
        LQry.ParamByName('DTAENV').AsDateTime := fNow;
        LQry.ParamByName('HORENV').AsDateTime := fNow;
        LQry.ExecSQL;


        LQry.SQL.Clear();
        LQry.SQL.Add('SELECT * FROM ILOGDET WHERE FALSE');

        LQry.Open();
        ADataSet.First;
        while not ADataSet.Eof do
        begin
          LQry.Append;

          LQry.FieldByName('DET_NUMROM').AsString   := FParams.CodRom;
          LQry.FieldByName('DET_EMPROM').AsString   := VS_strCodEmp;
          LQry.FieldByName('DET_STATUS').AsString   := 'I';
          LQry.FieldByName('DET_NUMDOC').AsString   := ADataSet.FieldByName('GER_NUMDOC').AsString;
          LQry.FieldByName('DET_CODEMP').AsString   := ADataSet.FieldByName('GER_CODEMP').AsString;
          LQry.FieldByName('DET_ESPDOC').AsString   := ADataSet.FieldByName('GER_ESPDOC').AsString;
          LQry.FieldByName('DET_CODCLI').AsString   := ADataSet.FieldByName('GER_CODCLI').AsString;
          LQry.FieldByName('DET_DTAENV').AsDateTime := fNow;
          LQry.FieldByName('DET_HORENV').AsDateTime := fNow;
          LQry.FieldByName('DET_DTAOCO').AsDateTime := fNow;
          LQry.FieldByName('DET_HOROCO').AsDateTime := fNow;
          LQry.Post;

          ADataSet.Next;
        end;
      Except
        On E: Exception Do
        {$IFDEF LINUX}
          Raise Exception.Create('[TMonitoriLogSend.UpdateSendSuccessfully] - ' + E.Message);
        {$ELSE }
          pMensagensErro(E.Message, '[TMonitoriLogSend.UpdateSendSuccessfully]');
        {$ENDIF LINUX}
      End;
    Finally
      LQry.Close();
      LQry.SQL.Clear();
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

constructor TMonitoriLogSend.Create(AParams: IParamiLog);
begin
  FParams := AParams;
end;

destructor TMonitoriLogSend.Destroy;
begin

  inherited;
end;

function TMonitoriLogSend.BuildJson(const ADataSet: TDataSet): string;
var
  ModelCarga: TModelCarga;
  ModelItens: TModelItens;
begin
  ModelCarga := TModelCarga.Create();
  try
    ModelCarga.cpfMotorista := ADataSet.FieldByName('MOT_CPFMOT').AsString;
    ModelCarga.data         := fNow();
    ModelCarga.id           := FParams.Autoincrem;
    ModelCarga.placa        := ADataSet.FieldByName('GER_PLAVEI').AsString;
    ModelCarga.numero       := FParams.CodRom;
//    ModelCarga.tipo         := 'tipo';

    ADataSet.First;
    while not ADataSet.Eof do
    begin
      ModelItens := TModelItens.Create;

      ModelItens.id := ADataSet.FieldByName('AUTOINCREM').AsString;
      ModelItens.idCliente := ADataSet.FieldByName('CLI_CODCLI').AsString;
      ModelItens.idEmpresa := VS_strCodEmp;
      ModelItens.nomeTransportadora := ADataSet.FieldByName('GER_TRANSP').AsString;
      ModelItens.cnpjTransportadora := ADataSet.FieldByName('GER_TRACGC').AsString;
//      ModelItens.contato :=
//      ModelItens.dataPrevisaoEntrega :=
//      ModelItens.ordemEntrega
//      ModelItens.status

      ModelItens.cliente.email               := ADataSet.FieldByName('CLI_EMAIL_').AsString;
      ModelItens.cliente.cliente.contato     := ADataSet.FieldByName('CLI_CONTAT').AsString;
      ModelItens.cliente.cliente.cpfCnpj     := ADataSet.FieldByName('GER_CGCCON').AsString;
      ModelItens.cliente.cliente.email       := ADataSet.FieldByName('CLI_EMAIL_').AsString;
      ModelItens.cliente.cliente.id          := ADataSet.FieldByName('CLI_CODCLI').AsString;
//      ModelItens.cliente.cliente.idEmpresa   := VS_strCodEmp;
      ModelItens.cliente.cliente.razaoSocial := ADataSet.FieldByName('GER_NOMCLI').AsString;
      ModelItens.cliente.cliente.telefone    := ADataSet.FieldByName('GER_TELCON').AsString;
      ModelItens.cliente.cliente.tipoPessoa  := ifthen(ADataSet.FieldByName('GER_CGCCPF').AsInteger = 1, 'J', 'F');

      ModelItens.endereco.bairro      := ADataSet.FieldByName('GER_BAIRRO').AsString;
      ModelItens.endereco.cep         := ADataSet.FieldByName('GER_CEPCON').AsString;
      ModelItens.endereco.cidade      := ADataSet.FieldByName('GER_NOMCID').AsString;
//      ModelItens.endereco.complemento := ADataSet.FieldByName('').AsString;
      ModelItens.endereco.estado      := ADataSet.FieldByName('GER_ESTADO').AsString;
      ModelItens.endereco.logradouro  := ADataSet.FieldByName('GER_ENDCON').AsString;
      ModelItens.endereco.numero      := ADataSet.FieldByName('CLI_ENDNUM').AsString;
//      ModelItens.endereco.referencia  :=

//      ModelItens.fatura.data
//      ModelItens.fatura.vencimento

      ModelItens.nota.chaveAcesso := ADataSet.FieldByName('FIS_ACESSO').AsString;
      ModelItens.nota.numero      := ADataSet.FieldByName('GER_NUMDOC').AsString;
      ModelItens.nota.serie       := ADataSet.FieldByName('FIS_SERIE_').AsString;

      if fEmptyStr(ModelItens.nota.chaveAcesso) then
        ModelItens.nota.chaveAcesso := ModelItens.nota.numero;

      if fEmptyStr(ModelItens.nota.serie) then
        ModelItens.nota.serie := '*';

      ModelCarga.AddItem(ModelItens);

      SendCliente(TJson.ObjectToJsonString(ModelItens.cliente.cliente));

      ADataSet.Next;
    end;

    Result := TJson.ObjectToJsonString(ModelCarga);
  finally
    FreeAndNil(ModelCarga);
  end;
end;

class function TMonitoriLogSend.New(AParams: IParamiLog): IMonitorProcedure;
begin
  Result := TMonitoriLogSend.Create(AParams);
end;

procedure TMonitoriLogSend.pExecute;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  JsonRequest: String;
begin
  LQry := fCriaQuery();
  Try
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlCarregarRomaneioiLog);

    Try
      LQry.ParamByName('NUMROM').AsString := FParams.CodRom();
      LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
      LQry.Open();

      if not LQry.IsEmpty then
      begin
        JsonRequest := BuildJson(LQry);
        if SendCarga(JsonRequest) then
          UpdateSendSuccessfully(LQry);
      end;
    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[TMonitoriLogSend.pExecute] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '[TMonitoriLogSend.pExecute]');
      {$ENDIF LINUX}
    End;
  Finally
    LQry.Close();
    LQry.SQL.Clear();
    {$IFNDEF LINUX}
      FreeAndNil(LQry);
    {$ENDIF LINUX}
  End;
end;

procedure TMonitoriLogSend.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlRomaneioiLog);
    LQry.SQL.Add(sqlLimit);
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

      TMonitoriLogSend.New(
        TParamiLogSend.New()
          .Autoincrem(LQry.FieldByName('AUTOINCREM').AsString)
          .CodRom(LQry.FieldByName('ILO_NUMROM').AsString)
        ).pExecute();

      If (LQry.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitoriLogSend, [VS_strCodEmp]));
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
end;

procedure TMonitoriLogSend.SaveError(AError: string);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Try
    LQry := fCriaQuery();

    Try
      Try
        LQry.SQL.Add('UPDATE ROMILOG SET');
        LQry.SQL.Add('  ILO_STATUS = "E"');
        LQry.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');
        LQry.ParamByName('AUTOINCREM').AsString := FParams.Autoincrem;
        LQry.ExecSQL;

        LQry.SQL.Clear();
        LQry.SQL.Add('SELECT * FROM ILOGERR WHERE FALSE');

        LQry.Open();
        LQry.Append;
        //LQry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ILOGERR', VS_strCodEmp);
        LQry.FieldByName('ERR_NUMROM').AsString := FParams.CodRom;
        LQry.FieldByName('ERR_EMPROM').AsString := VS_strCodEmp;
        LQry.FieldByName('ERR_DTAENT').AsDateTime := fNow;
        LQry.FieldByName('ERR_HORENT').AsDateTime := fNow;
        LQry.FieldByName('ERR_MENSAG').AsString := AError;
        LQry.Post;
      Except
        On E: Exception Do
        {$IFDEF LINUX}
          Raise Exception.Create('[TMonitoriLogSend.SaveError] - ' + E.Message);
        {$ELSE }
          pMensagensErro(E.Message, '[TMonitoriLogSend.SaveError]');
        {$ENDIF LINUX}
      End;
    Finally
      LQry.Close();
      LQry.SQL.Clear();
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

function TMonitoriLogSend.SendCarga(const AJson: string): Boolean;
begin
  Result := SendPOST(URL_CARGA, AJson);
end;

function TMonitoriLogSend.SendCliente(const AJson: string): Boolean;
begin
  Result := SendPOST(URL_CLIENTE, AJson);
end;

{ TParamiLogSend }

function TParamiLogSend.Autoincrem(const AValue: String): IParamiLog;
begin
  Result := Self;
  FAutoincrem := AValue;
end;

function TParamiLogSend.Autoincrem: String;
begin
  Result := FAutoincrem;
end;

function TParamiLogSend.CodRom: String;
begin
  Result := FCodRom;
end;

function TParamiLogSend.CodRom(const AValue: String): IParamiLog;
begin
  Result := Self;
  FCodRom := AValue;
end;

constructor TParamiLogSend.Create;
begin
  FCodRom := '';
end;

class function TParamiLogSend.New: IParamiLog;
begin
  Result := TParamiLogSend.Create();
end;

function sqlCarregarRomaneioiLog: string;
var
  LSql: String;
begin
  LSql := '';
  LSql := LSql + ' SELECT ';
  LSql := LSql + '   R.AUTOINCREM, R.GER_PLAVEI, MOT_CPFMOT, G.GER_NUMDOC, G.GER_CODEMP, G.GER_ESPDOC, G.GER_CODCLI, ';
  LSql := LSql + '   IF(R.GER_ESPDOC = "OX", R.GER_MEN001, IF( R.GER_NOMCON IS NULL, CLI_NOMCLI, R.GER_NOMCON)) AS GER_NOMCLI, ';
  LSql := LSql + '   CLI_CODCLI, CLI_EMAIL_, CLI_CONTAT, R.GER_CGCCON, R.GER_TELCON, R.GER_CGCCPF, CLI_ENDNUM,';

  LSql := LSql + '  IF('+fEnderecoPelaEntCli('','R')+',';
  LSql := LSql + '     COALESCE(CIDCLI.CID_NOMCID, ';
  LSql := LSql + '                     CIDCLIN.CID_NOMCID, ';
  LSql := LSql + '                     CIDCLIG.CID_NOMCID), ';
  LSql := LSql + '     COALESCE(CIDGER.CID_NOMCID, ';
  LSql := LSql + '                     CIDNOT.CID_NOMCID, ';
  LSql := LSql + '                     CIDGOR.CID_NOMCID)) AS GER_NOMCID, ';

  LSql := LSql + '  IF('+fEnderecoPelaEntCli('','R')+',';
  LSql := LSql + '            COALESCE(CIDCLI.CID_ESTADO, ';
  LSql := LSql + '                     CIDCLIN.CID_ESTADO, ';
  LSql := LSql + '                     CIDCLIG.CID_ESTADO), ';
  LSql := LSql + '            COALESCE(CIDGER.CID_ESTADO, ';
  LSql := LSql + '                     CIDNOT.CID_ESTADO, ';
  LSql := LSql + '                     CIDGOR.CID_ESTADO)) AS GER_ESTADO, ';

  LSql := LSql + '  IF('+fEnderecoPelaEntCli('','R')+',';
  LSql := LSql + '     COALESCE(ECMOV.ETC_BAIENT, ';
  LSql := LSql + '              ECNOT.ETC_BAIENT, ';
  LSql := LSql + '              ECGOR.ETC_BAIENT), ';
  LSql := LSql + '     COALESCE(G.GER_BAICON, ';
  LSql := LSql + '              N.GER_BAICON, ';
  LSql := LSql + '              PD.FGO_BAICON)) AS GER_BAIRRO, ';

  LSql := LSql + '  IF('+fEnderecoPelaEntCli('','R')+',';
  LSql := LSql + '     COALESCE(ECMOV.ETC_ENDENT, ';
  LSql := LSql + '              ECNOT.ETC_ENDENT, ';
  LSql := LSql + '              ECGOR.ETC_ENDENT), ';
  LSql := LSql + '     COALESCE(G.GER_ENDCON, ';
  LSql := LSql + '              N.GER_ENDCON, ';
  LSql := LSql + '              PD.FGO_ENDCON)) AS GER_ENDCON, ';

  LSql := LSql + '  IF('+fEnderecoPelaEntCli('','R')+',';
  LSql := LSql + '     COALESCE(ECMOV.ETC_CEPENT, ';
  LSql := LSql + '              ECNOT.ETC_CEPENT, ';
  LSql := LSql + '              ECGOR.ETC_CEPENT), ';
  LSql := LSql + '     COALESCE(G.GER_CEPCON, ';
  LSql := LSql + '              N.GER_CEPCON, ';
  LSql := LSql + '              PD.FGO_CEPCON)) AS GER_CEPCON, ';

  LSql := LSql + '  IF((AUXMOV.AUX_ENTGER  IS NOT NULL OR ';
  LSql := LSql + '      AUXNOT.AUX_ENTGER  IS NOT NULL OR ';
  LSql := LSql + '      AUXGOR.AUX_ENTGER  IS NOT NULL OR ';
  LSql := LSql + '      PD.FGO_CODTRA      IS NOT NULL ), ';
  LSql := LSql + '     COALESCE( ';
  LSql := LSql + '      TRAMOV.TRA_NOMTRA, ';
  LSql := LSql + '      TRANOT.TRA_NOMTRA, ';
  LSql := LSql + '      CADTRA.TRA_NOMTRA,  ';
  LSql := LSql + '      TRAGOR.TRA_NOMTRA), ';
  LSql := LSql + '      TRAROM.TRA_NOMTRA) AS GER_TRANSP, ';

  LSql := LSql + '  IF((AUXMOV.AUX_ENTGER  IS NOT NULL OR ';
  LSql := LSql + '      AUXNOT.AUX_ENTGER  IS NOT NULL OR ';
  LSql := LSql + '      AUXGOR.AUX_ENTGER  IS NOT NULL OR ';
  LSql := LSql + '      PD.FGO_CODTRA      IS NOT NULL ), ';
  LSql := LSql + '     COALESCE( ';
  LSql := LSql + '      TRAMOV.TRA_C_G_C_, ';
  LSql := LSql + '      TRANOT.TRA_C_G_C_, ';
  LSql := LSql + '      CADTRA.TRA_C_G_C_,  ';
  LSql := LSql + '      TRAGOR.TRA_C_G_C_), ';
  LSql := LSql + '      TRAROM.TRA_C_G_C_) AS GER_TRACGC, ';
  LSql := LSql + '  FIS_ACESSO, FIS_SERIE_ ';
  LSql := LSql + ' FROM ROMGERX R';
  LSql := LSql + '  LEFT JOIN CADMOT ON GER_CODMOT = MOT_CODMOT';
  LSql := LSql + '  LEFT JOIN CADVEI ON GER_PLAVEI = VEI_PLAVEI';
  LSql := LSql + '  LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI';
  LSql := LSql + '  LEFT JOIN CADCID CIDCON ON IF(GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CIDCON.CID_CODCID';
  LSql := LSql + '  LEFT JOIN CADTRA TRAROM ON R.GER_CODTRA = TRAROM.TRA_CODTRA  ';

  LSql := LSql + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = R.GER_NUMDOC AND ';
  LSql := LSql + '                        G.GER_ESPDOC = R.GER_ESPDOC AND ';
  LSql := LSql + '                        G.GER_CODEMP = R.GER_CODEMP AND ';
  LSql := LSql + '                        G.GER_CODCLI = R.GER_CODCLI ';

  LSql := LSql + '  LEFT JOIN MOVOBS   ON (MOVOBS.MOV_SEQGER = G.AUTOINCREM) ';

  LSql := LSql + '  LEFT JOIN CADFIS ON FIS_NUMDOC = G.GER_NUMDOC ';
  LSql := LSql + '                  AND FIS_ESPDOC = G.GER_ESPDOC ';
  LSql := LSql + '                  AND FIS_CODEMP = G.GER_CODEMP ';
  LSql := LSql + '                  AND FIS_FORCLI = G.GER_CODCLI ';
  LSql := LSql + '                  AND FIS_TIP_FC = G.GER_TIP_FC ';

  LSql := LSql + '  LEFT JOIN NOTGER N ON N.GER_NUMDOC = R.GER_NUMDOC AND ';
  LSql := LSql + '                        N.GER_ESPDOC = R.GER_ESPDOC AND ';
  LSql := LSql + '                        N.GER_CODEMP = R.GER_CODEMP AND ';
  LSql := LSql + '                        N.GER_CODCLI = R.GER_CODCLI ';

  LSql := LSql + '  LEFT JOIN FATGOR PD ON PD.FGO_NUMDOC = R.GER_NUMDOC AND ';
  LSql := LSql + '                         PD.FGO_ESPDOC = R.GER_ESPDOC AND   ';
  LSql := LSql + '                         PD.FGO_CODEMP = R.GER_CODEMP AND   ';
  LSql := LSql + '                         PD.FGO_CODCLI = R.GER_CODCLI       ';

  If (OpcRom <> '1') Then Begin
    LSql := LSql + '  LEFT JOIN MOVDET    ON MOVDET.DET_SEQGER = G.AUTOINCREM ';
    LSql := LSql + '  LEFT JOIN MOVTRI    ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  End
  Else
  Begin
    LSql := LSql + '  LEFT JOIN FATDOR   ON FDO_SEQGER = PD.AUTOINCREM ';
    LSql := LSql + '  LEFT JOIN EXTDOR   ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  End;

  {* OBTEM O ENDEREÇO DE ENTREGA MOVGER *}
  LSql := LSql + 'LEFT JOIN AUXMOV        ON (AUXMOV.AUX_SEQGER = G.AUTOINCREM) ';
  LSql := LSql + 'LEFT JOIN ENTCLI ECMOV  ON (ECMOV.AUTOINCREM  = AUXMOV.AUX_ENTGER) ';
  LSql := LSql + 'LEFT JOIN CADCID CIDCLI ON (CIDCLI.CID_CODCID = ECMOV.ETC_CIDENT) ';
  LSql := LSql + 'LEFT JOIN CADCID CIDGER ON (CIDGER.CID_CODCID = G.GER_CIDCON) ';
  LSql := LSql + 'LEFT JOIN CADTRA TRAMOV ON (ECMOV.ETC_CODTRA  = TRAMOV.TRA_CODTRA) ';

  {* OBTEM O ENDEREÇO DE ENTREGA NOTGER *}
  LSql := LSql + 'LEFT JOIN AUXNOT         ON (AUXNOT.AUX_SEQGER  = N.AUTOINCREM) ';
  LSql := LSql + 'LEFT JOIN ENTCLI ECNOT   ON (ECNOT.AUTOINCREM   = AUXNOT.AUX_ENTGER) ';
  LSql := LSql + 'LEFT JOIN CADCID CIDCLIN ON (CIDCLIN.CID_CODCID = ECNOT.ETC_CIDENT) ';
  LSql := LSql + 'LEFT JOIN CADCID CIDNOT  ON (CIDNOT.CID_CODCID  = N.GER_CIDCON) ';
  LSql := LSql + 'LEFT JOIN CADTRA TRANOT  ON (ECNOT.ETC_CODTRA   = TRANOT.TRA_CODTRA) ';

  {* OBTEM O ENDEREÇO DE ENTREGA FATGOR *}
  LSql := LSql + 'LEFT JOIN AUXGOR         ON (AUXGOR.AUX_SEQGER  = PD.AUTOINCREM) ';
  LSql := LSql + 'LEFT JOIN ENTCLI ECGOR   ON (ECGOR.AUTOINCREM   = AUXGOR.AUX_ENTGER) ';
  LSql := LSql + 'LEFT JOIN CADCID CIDCLIG ON (CIDCLIG.CID_CODCID = ECGOR.ETC_CIDENT) ';
  LSql := LSql + 'LEFT JOIN CADCID CIDGOR  ON (CIDGOR.CID_CODCID  = PD.FGO_CIDCON) ';
  LSql := LSql + 'LEFT JOIN CADTRA         ON (PD.FGO_CODTRA      = CADTRA.TRA_CODTRA) ';
  LSql := LSql + 'LEFT JOIN CADTRA TRAGOR  ON (ECGOR.ETC_CODTRA   = TRAGOR.TRA_CODTRA) ';
  LSql := LSql + 'LEFT JOIN EXTGOR         ON (PD.AUTOINCREM = EXTGOR.FGO_SEQFGO) ';

  LSql := LSql + 'WHERE R.GER_NUMROM = :NUMROM';
  LSql := LSql + '  AND R.GER_EMPROM = :EMPROM';

  Result := LSql;
end;

Function fAuxSeqGerEhdeClienteNormal(strTab: String): String;
begin
  Result := ' (SELECT IF(COUNT(*)>0, TRUE, FALSE) '+
            '    FROM CADCLI CE INNER JOIN ENTCLI EE ON CE.CLI_CODCLI = EE.ETC_CODCLI '+
            '   WHERE (EE.AUTOINCREM = '+strTab+'.AUX_ENTGER) AND '+
            '         (IFNULL(CE.CLI_NOMCLI, "") NOT LIKE "%CONSUMIDOR%") AND '+
            '         (IFNULL(CE.CLI_NOMCLI, "") NOT LIKE "%SEGURADORA%")     '+
            ' ) ';
end;

function fEnderecoPelaEntCli(strTabela,
  strAlias: String): String;
Var
  strPrx: String;
  strCampoNome: String;
begin
  strPrx := IIF(fEmptyStr(strAlias),'',strAlias+'.') + IIF(strTabela='AUXGOR','FGO','GER');
  strCampoNome := ' IF('+strPrx+'_NOMCON IS NULL, CLI_NOMCLI, '+strPrx+'_NOMCON) ';

  If Not fEmptyStr(strTabela) Then
  Begin
    Result := fAuxSeqGerEhdeClienteNormal(strTabela) +'AND'+
        ' (('+strCampoNome+' NOT LIKE "%CONSUMIDOR%") AND ('+strCampoNome+' NOT LIKE "%SEGURADORA%")) ';
  End
  Else
  Begin
    Result := ' ('+fAuxSeqGerEhdeClienteNormal('AUXMOV')+' OR '+
              '  '+fAuxSeqGerEhdeClienteNormal('AUXNOT')+' OR '+
              '  '+fAuxSeqGerEhdeClienteNormal('AUXGOR')+') AND '+
              ' (('+strCampoNome+' NOT LIKE "%CONSUMIDOR%") AND ('+strCampoNome+' NOT LIKE "%SEGURADORA%")) ';
  End;
end;

end.
