unit untTracksale.Campaign.Dispatch;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client;
  {$ENDIF LINUX}

type
  TTagsClass = class
  private
    FName: String;
    FValue: String;

    class function fNew: TTagsClass;

    function f_name(AValue: String): TTagsClass;
    function f_value(AValue: String): TTagsClass;
  public
    property name: String read FName write FName;
    property value: String read FValue write FValue;
  end;

  TCustomersClass = class
  private
    FEmail: String;
    FIdentification: String;
    FName: String;
    FPhone: String;
    FTags: TArray<TTagsClass>;

    procedure pAddTag(tag: TTagsClass);
    procedure pLimpaTags;
  public
    property email: String read FEmail write FEmail;
    property identification: String read FIdentification write FIdentification;
    property name: String read FName write FName;
    property phone: String read FPhone write FPhone;
    property tags: TArray<TTagsClass> read FTags write FTags;
    destructor Destroy; override;
  end;

  TCampaignDispatch = class
  private
    FCustomers: TArray<TCustomersClass>;
    FSchedule_time: Extended;
  public
    property customers: TArray<TCustomersClass> read FCustomers write FCustomers;
    property schedule_time: Extended read FSchedule_time write FSchedule_time;
    destructor Destroy; override;
    class function ToJsonString(CampaignDispatch: TCampaignDispatch): string;
  end;

  TCampaignClass = class
  private
    FCod: Extended;
    FName: String;
  public
    property cod: Extended read FCod write FCod;
    property name: String read FName write FName;
  end;

  TStatusClass = class
  private
    FDuplicated: Extended;
    FInserted: Extended;
    FInvalid: Extended;
  public
    property duplicated: Extended read FDuplicated write FDuplicated;
    property inserted: Extended read FInserted write FInserted;
    property invalid: Extended read FInvalid write FInvalid;
  end;

  TRetornoCampaignDispatch = class
  private
    FCampaign: TCampaignClass;
    FDispatch_code: String;
    FMsg: String;
    FStatus: TStatusClass;
  public
    property campaign: TCampaignClass read FCampaign write FCampaign;
    property dispatch_code: String read FDispatch_code write FDispatch_code;
    property msg: String read FMsg write FMsg;
    property status: TStatusClass read FStatus write FStatus;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoCampaignDispatch;
  end;

  TControllerTracksaleCampaignDispatch = class
  private
    function fGetToken: String;
    function fGetCodigoDaCampanha: String;

    function fGetUnixTimesTamp: Int64;
    function fRetEmailValidado(strEmail: String): String;

    function fCampaignDispatch(CampaignDispatch: TCampaignDispatch;
      strSeqAut, strCampaign_code, strToken: String): TRetornoCampaignDispatch;
  public
    procedure pDisparaPesquisaSatisfacao;
  end;

implementation

uses
  untRestApi, untTracksaleApi;

{ TTagsClass }

class function TTagsClass.fNew: TTagsClass;
begin
  Result := TTagsClass.Create;
end;

function TTagsClass.f_name(AValue: String): TTagsClass;
begin
  FName := AValue;
  Result := Self;
end;

function TTagsClass.f_value(AValue: String): TTagsClass;
begin
  FValue := AValue;
  Result := Self;
end;

{TCustomersClass}

destructor TCustomersClass.Destroy;
var
  LtagsItem: TTagsClass;
begin

  for LtagsItem in FTags do
    LtagsItem.free;

  inherited;
end;

procedure TCustomersClass.pAddTag(tag: TTagsClass);
begin
  SetLength(FTags, Length(FTags)+1);
  FTags[Length(FTags)-1] := tag;
end;

procedure TCustomersClass.pLimpaTags;
begin
  SetLength(FTags, 0);
end;

{TCampaignDispatch}

destructor TCampaignDispatch.Destroy;
var
  LcustomersItem: TCustomersClass;
begin

  for LcustomersItem in FCustomers do
    LcustomersItem.free;

  inherited;
end;

class function TCampaignDispatch.ToJsonString(CampaignDispatch: TCampaignDispatch): string;
begin
  Result := TJson.ObjectToJsonString(CampaignDispatch);
end;

{TRetornoCampaignDispatch}

constructor TRetornoCampaignDispatch.Create;
begin
  inherited;
  FStatus := TStatusClass.Create();
  FCampaign := TCampaignClass.Create();
end;

destructor TRetornoCampaignDispatch.Destroy;
begin
  FStatus.free;
  FCampaign.free;
  inherited;
end;


class function TRetornoCampaignDispatch.FromJsonString(AJsonString: string): TRetornoCampaignDispatch;
begin
  result := TJson.JsonToObject<TRetornoCampaignDispatch>(AJsonString)
end;

{ TControllerTracksaleCampaignDispatch }

function TControllerTracksaleCampaignDispatch.fGetToken: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TOKNPS']);
end;

function TControllerTracksaleCampaignDispatch.fGetCodigoDaCampanha: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CAMNPS']);
end;

function TControllerTracksaleCampaignDispatch.fGetUnixTimesTamp: Int64;
var
  qryAux: IQuery;
begin
  qryAux := fCriaQuery;
  qryAux.Close;
  qryAux.SQL.Text := 'SELECT UNIX_TIMESTAMP('+QuotedStr(FormatDateTime('yyyy-MM-dd hh:mm:ss', IncMinute(fNow, 1)))+') AS NPS_DTAHOR ';
  qryAux.Open;

  Result := qryAux.FieldByName('NPS_DTAHOR').AsLargeInt;
end;

function TControllerTracksaleCampaignDispatch.fRetEmailValidado(strEmail: String): String;
var
  intPos: Integer;
begin
  Result := Trim(strEmail);
  Result := AnsiReplaceStr(Result, ';', ' ');
  intPos := IIF(Pos(' ', Result) > 0, Pos(' ', Result), Length(Result));
  Result := Trim(Copy(Result, 0, intPos));
end;

procedure TControllerTracksaleCampaignDispatch.pDisparaPesquisaSatisfacao;
var
  CampaignDispatch: TCampaignDispatch;
  RetornoCampaignDispatch: TRetornoCampaignDispatch;

  strToken,
  strCampaign_code: String;
  
  qryNpsEnv,
  qryRetNps: IQuery;
  Customer: TCustomersClass;

  blnClienteConsumidor: Boolean;
begin
  strToken := fGetToken;
  strCampaign_code := fGetCodigoDaCampanha;

  CampaignDispatch := TCampaignDispatch.Create;
  Customer := TCustomersClass.Create;
  qryRetNps := fCriaQuery;
  qryNpsEnv := fCriaQuery;

  try
    qryNpsEnv.Close;
    qryNpsEnv.SQL.Text :=
    ' SELECT '+
    {DOCUMENTO}
    '   NPSENV.AUTOINCREM, '+
    '   NPS_NUMDOC, '+
    '   NPS_ESPDOC, '+
    '   NPS_CODEMP, '+
    '   NPS_CODCLI, '+
    '   GER_DTAENT, '+

    {DADOS CLIENTE CONSUMIDOR}
    '   GER_NOMCON, '+
    '   GER_TELCON, '+
    '   GER_EMLCON, '+
    '   GER_CGCCON, '+
    '   CO.CID_NOMCID AS CID_CIDCON, '+

    {DADOS CLIENTE}
    '   CLI_NOMCLI, '+
    '   CLI_CELULA, '+
    '   CLI_EMAIL_, '+
    '   CLI_EMAIL2, '+
    '   CLI_EMAIL3, '+
    '   CLI_CODCLI, '+
    '   CLI_C_G_C_, '+
    '   CL.CID_NOMCID AS CID_CIDCLI, '+

    {DADOS VENDEDOR}
    '   OPE_NOMOPE  '+

    ' FROM '+
    '   NPSENV '+

    ' INNER JOIN MOVGER ON '+
    '   NPS_NUMDOC = GER_NUMDOC AND '+
    '   NPS_ESPDOC = GER_ESPDOC AND '+
    '   NPS_CODEMP = GER_CODEMP AND '+
    '   NPS_CODCLI = GER_CODCLI '+

    ' INNER JOIN CADCLI ON '+
    '   NPS_CODCLI = CLI_CODCLI '+

    ' LEFT JOIN CADCID CL ON '+
    '   CLI_CODCID = CL.CID_CODCID '+

    ' LEFT JOIN CADCID CO ON '+
    '   GER_CIDCON = CO.CID_CODCID '+

    ' LEFT JOIN CADOPE ON '+
    '   GER_CODVEN = OPE_CODOPE '+
    ' WHERE '+
    '   GER_TIP_FC = "C"     AND '+
    '   GER_ORIDOC = "V"     AND '+
    '   NPS_CODEMP = :CODEMP AND '+
    '   NPS_DTAENV IS NULL '+
    ' ORDER BY '+
    '   NPS_DTAINC, '+
    '   NPS_HORINC ';

    qryNpsEnv.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryNpsEnv.Open;
    while not qryNpsEnv.Eof do
    begin
      if Length(CampaignDispatch.FCustomers) = 0 then
        SetLength(CampaignDispatch.FCustomers, 1);

      blnClienteConsumidor := fClienteConsumidor(qryNpsEnv.FieldByName('CLI_NOMCLI').AsString, True, False);

      Customer.identification := qryNpsEnv.FieldByName('NPS_CODCLI').AsString;

      if blnClienteConsumidor then
      begin
        Customer.name  := fFormataNome(qryNpsEnv.FieldByName('GER_NOMCON').AsString);
        Customer.phone := qryNpsEnv.FieldByName('GER_TELCON').AsString;
        Customer.email := fRetEmailValidado(qryNpsEnv.FieldByName('GER_EMLCON').AsString);
      end
      else
      begin
        Customer.name  := fFormataNome(qryNpsEnv.FieldByName('CLI_NOMCLI').AsString);
        Customer.phone := qryNpsEnv.FieldByName('CLI_CELULA').AsString;

        if not fEmptyStr(qryNpsEnv.FieldByName('CLI_EMAIL_').AsString) then
          Customer.email := fRetEmailValidado(qryNpsEnv.FieldByName('CLI_EMAIL_').AsString)
        else if not fEmptyStr(qryNpsEnv.FieldByName('CLI_EMAIL2').AsString) then
          Customer.email := fRetEmailValidado(qryNpsEnv.FieldByName('CLI_EMAIL2').AsString)
        else
          Customer.email := fRetEmailValidado(qryNpsEnv.FieldByName('CLI_EMAIL3').AsString);
      end;

      Customer.pLimpaTags;

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Cpf/Cnpj')
                                 .f_value(qryNpsEnv.FieldByName(IIF(blnClienteConsumidor, 'GER_CGCCON', 'CLI_C_G_C_')).AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Cidade')
                                 .f_value(qryNpsEnv.FieldByName(IIF(blnClienteConsumidor, 'CID_CIDCON', 'CID_CIDCLI')).AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Telefone')
                                 .f_value(qryNpsEnv.FieldByName(IIF(blnClienteConsumidor, 'GER_TELCON', 'CLI_CELULA')).AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Vendedor')
                                 .f_value(qryNpsEnv.FieldByName('OPE_NOMOPE').AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Data Venda')
                                 .f_value(qryNpsEnv.FieldByName('GER_DTAENT').AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Cód. Cliente')
                                 .f_value(qryNpsEnv.FieldByName('NPS_CODCLI').AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Venda Origem')
                                 .f_value(qryNpsEnv.FieldByName('NPS_ESPDOC').AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Empresa Venda')
                                 .f_value(qryNpsEnv.FieldByName('NPS_CODEMP').AsString));

      Customer.pAddTag(TTagsClass.fNew
                                 .f_name('Documento Venda')
                                 .f_value(qryNpsEnv.FieldByName('NPS_NUMDOC').AsString));
            
      CampaignDispatch.FCustomers[0] := Customer;
      CampaignDispatch.schedule_time := fGetUnixTimesTamp;

      RetornoCampaignDispatch := fCampaignDispatch(CampaignDispatch,
                                                   qryNpsEnv.FieldByName('AUTOINCREM').AsString,
                                                   strCampaign_code,
                                                   strToken);
      if Assigned(RetornoCampaignDispatch) then
      begin
        qryRetNps.Close;
        qryRetNps.SQL.Text := 
        ' UPDATE '+
        '   NPSENV '+
        ' SET '+
        '   NPS_DTAENV = :DTAENV, '+
        '   NPS_HORENV = :HORENV, '+
        '   NPS_ULTMSG = :ULTMSG '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

        qryRetNps.ParamByName('DTAENV').AsDate   := fNow;
        qryRetNps.ParamByName('HORENV').AsTime   := Time;
        qryRetNps.ParamByName('ULTMSG').AsString := RetornoCampaignDispatch.msg;
        qryRetNps.ParamByName('AUTINC').AsString := qryNpsEnv.FieldByName('AUTOINCREM').AsString;
        qryRetNps.ExecSQL;
      end;

      Sleep(500);

      qryNpsEnv.Next;
    end;

  finally
    if Assigned(CampaignDispatch) then
      FreeAndNil(CampaignDispatch);
  end;
end;

function TControllerTracksaleCampaignDispatch.fCampaignDispatch(
  CampaignDispatch: TCampaignDispatch; strSeqAut, strCampaign_code, strToken: String): TRetornoCampaignDispatch;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('TRACKSALE', TControllerTracksale.fConfigurarTracksale);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'campaign/'+strCampaign_code+'/dispatch';
    RestRequest.Method := rmPOST;

    RESTRequest.Params.AddItem('Authorization', 'Bearer '+strToken, TREstRequestParameterKind.pkHTTPHEADER);

    RESTRequest.Params.AddItem('',
                                 TCampaignDispatch.ToJsonString(CampaignDispatch),
                                 TREstRequestParameterKind.pkREQUESTBODY,
                                 [],
                                 TRESTContentType.ctAPPLICATION_JSON
                               );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqAut) then
      Result := TRetornoCampaignDispatch.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

end.
