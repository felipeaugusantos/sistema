unit untBoschFun;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.Classes,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, untUtilMonitor, untFuncFatTypes;
  {$ENDIF LINUX}

type

//esse é um result da bosch, verificar como são quando é sucesso e erro para tratar o objeto abaixo
//[
    {
        "fileName": "NF_000000646384_001.xml",
        "size": 20860,
        "status": "INVALID"
    }
//]

  TResultBoschFun = class
  private
    FFileName: String;
    FSize: Extended;
    FStatus: String;
  public
    property fileName: String read FFileName write FFileName;
    property size: Extended read FSize write FSize;
    property status: String read FStatus write FStatus;
    class function FromJsonString(AJsonString: string): TResultBoschFun;
  end;

  TServiceBoschFun = class
  private
    FCnpj: String;
    FFile: String;
    FResultBoschFun: TResultBoschFun;

    procedure pEnviarXMLNotaFiscalBosch;
    procedure pBaixaBchFun(const AstrAutInc, AstrStatus: String);
  public
    destructor Destroy; override;

    procedure pProcessar;

    {$IFNDEF LINUX}
    class procedure pGravarBCHFUN(const AarrMatItens: TMatrizFechamento; const AAutIncCadFis: String);
    class function fTemItemComMarcaBosch(const AarrMatItens: TMatrizFechamento): Boolean;
    {$ENDIF LINUX}

    function fSetCnpj(const ACnpj: String): TServiceBoschFun;
    function fSetFilePath(const AFilePath: String): TServiceBoschFun;

    property cnpj: String read FCnpj write FCnpj;
    property &file: String read FFile write FFile;
    property ResultBoschFun: TResultBoschFun read FResultBoschFun write FResultBoschFun;
  end;

  TBoschFun = class sealed(TInterfacedObject, {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX})
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

const
  CAMINHO_ARQUIVO_XML = '/dados/BoschFun';
  STATUS_ACCEPTED = 'ACCEPTED';
  INVOICE_ALREADY_EXISTS = 'INVOICE_ALREADY_EXISTS';

implementation

uses untRestApi, untBoschFunRestApi;

{ TResultBoschFun }

class function TResultBoschFun.FromJsonString(
  AJsonString: string): TResultBoschFun;
begin
  Result := TJson.JsonToObject<TResultBoschFun>(AJsonString.Replace('[', '').Replace(']', ''));
end;

{ TServiceBoschFun }

destructor TServiceBoschFun.Destroy;
begin
  if Assigned(FResultBoschFun) then
    FreeAndNil(FResultBoschFun);

  inherited;
end;

function TServiceBoschFun.fSetCnpj(const ACnpj: String): TServiceBoschFun;
begin
  Self.cnpj := ACnpj;
  Result := Self;
end;

function TServiceBoschFun.fSetFilePath(const AFilePath: String): TServiceBoschFun;
begin
  Self.&file := AFilePath;
  Result := Self;
end;

procedure TServiceBoschFun.pProcessar;
var
  qryXmlNfe: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF LINUX};

  LstrPathFile: String;
  LDocXML: TStringList;
begin
  if (not DirectoryExists(CAMINHO_ARQUIVO_XML)) and
     (not CreateDir(CAMINHO_ARQUIVO_XML)) then
    Exit;

  qryXmlNfe := fCriaQuery;
  try
    qryXmlNfe.Close;
    qryXmlNfe.SQL.Text :=
    ' SELECT '+
    '   BCHFUN.AUTOINCREM, '+
    '   NFE_ACESSO, '+
    '   NFE_ARQXML, '+
    '   EMP_C_G_C_  '+
    ' FROM '+
    '   BCHFUN '+
    ' INNER JOIN CADFIS '+
    '   ON BCH_SEQFIS = CADFIS.AUTOINCREM '+
    ' INNER JOIN XMLNFE '+
    '   ON FIS_ACESSO = NFE_ACESSO '+
    ' INNER JOIN CADEMP '+
    '   ON EMP_CODEMP = BCH_CODEMP '+
    ' WHERE '+
    '   BCH_CODEMP = :CODEMP AND '+
    '   BCH_ENVXML = "N"     AND '+
    '   IFNULL(FIS_ACESSO, "") <> "" ';

    qryXmlNfe.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryXmlNfe.Open;

    while not qryXmlNfe.Eof do
    begin
      LstrPathFile := IncludeTrailingPathDelimiter(CAMINHO_ARQUIVO_XML)+qryXmlNfe.FieldByName('NFE_ACESSO').AsString+'.xml';

      LDocXML := TStringList.Create;
      try
        LDocXML.Add(qryXmlNfe.FieldByName('NFE_ARQXML').AsString);
        LDocXML.SaveToFile(LstrPathFile);
      finally
        FreeAndNil(LDocXML);
      end;

      Self
        .fSetCnpj(qryXmlNfe.FieldByName('EMP_C_G_C_').AsString)
        .fSetFilePath(LstrPathFile)
        .pEnviarXMLNotaFiscalBosch;

      if Assigned(Self.ResultBoschFun) and (Pos(Self.ResultBoschFun.status, STATUS_ACCEPTED+'_'+INVOICE_ALREADY_EXISTS+'_') > 0)  then
        pBaixaBchFun(qryXmlNfe.FieldByName('AUTOINCREM').AsString, 'S');

      if FileExists(LstrPathFile) then
        DeleteFile(LstrPathFile);

      qryXmlNfe.Next;
    end;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryXmlNfe)
    {$ENDIF LINUX};
  end;
end;

procedure TServiceBoschFun.pBaixaBchFun(const AstrAutInc, AstrStatus: String);
var
  qryAux: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF LINUX};
begin
  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' UPDATE '+
    '   BCHFUN '+
    ' SET '+
    '   BCH_ENVXML = "'+AstrStatus+'" '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryAux.ParamByName('AUTINC').AsString := AstrAutInc;;
    qryAux.ExecSQL;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryAux)
    {$ENDIF LINUX};
  end;
end;

procedure TServiceBoschFun.pEnviarXMLNotaFiscalBosch;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  ControllerRest := TControllerRest.Create('BOSCHFUN', TConfigurarBoschFun.fConfigurarBoschFun);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'invoice?cnpj=54374525000116';//+Self.cnpj;// homologação
    //RestRequest.Resource := 'invoice?cnpj='+Self.cnpj;// produção
    RestRequest.Method := rmPOST;

    RestRequest.Params.AddItem('keyId', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_KEYBCH', VS_strCodEmp], True, EmptyStr), pkHTTPHEADER);
    {$IFDEF LINUX}
    RestRequest.AddFile(&file);
    {$ENDIF LINUX};

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Self.ResultBoschFun := TResultBoschFun.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

{$IFNDEF LINUX}
class procedure TServiceBoschFun.pGravarBCHFUN(
  const AarrMatItens: TMatrizFechamento; const AAutIncCadFis: String);
var
  qryBchFun: TUniQuery;
begin
  if not fCfgSis('UTIBCH', varBoolean) then
    Exit;

  if not fTemItemComMarcaBosch(AarrMatItens) then
    Exit;

  qryBchFun := fCriaQuery;
  try
    qryBchFun.Close;
    qryBchFun.SQL.Text :=
    ' INSERT INTO BCHFUN '+
    '   (AUTOINCREM, '+
    '    BCH_CODEMP, '+
    '    BCH_SEQFIS) '+
    ' VALUES '+
    '   (:AUTINC, '+
    '    :CODEMP, '+
    '    :SEQFIS) ';

    qryBchFun.ParamByName('AUTINC').AsString := fRetAutoIncrem('BCHFUN', VS_strCodEmp);
    qryBchFun.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBchFun.ParamByName('SEQFIS').AsString := AAutIncCadFis;
    qryBchFun.ExecSQL;
  finally
    FreeAndNil(qryBchFun);
  end;
end;

class function TServiceBoschFun.fTemItemComMarcaBosch(const AarrMatItens: TMatrizFechamento): Boolean;
var
  intCount: Integer;
  strCodMar: String;

  qryBosMar: TUniQuery;
begin
  strCodMar := EmptyStr;

  for intCount := Low(AarrMatItens) to High(AarrMatItens) do
    strCodMar := strCodMar + IIF(fEmptyStr(strCodMar), EmptyStr, ',') + QuotedStr(AarrMatItens[intCount].strCodMar);

  if fEmptyStr(strCodMar) then
    Exit(False);

  qryBosMar := fCriaQuery;
  try
    qryBosMar.Close;
    qryBosMar.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM '+
    ' FROM '+
    '   BOSMAR '+
    ' WHERE '+
    '   BOS_CODMAR IN ('+strCodMar+') AND '+
    '   BOS_CODEMP = :CODEMP ';

    qryBosMar.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBosMar.Open;

    Result := (not qryBosMar.IsEmpty);
  finally
    FreeAndNil(qryBosMar);
  end;
end;

{$ENDIF LINUX}

{ TBoschFun }

function TBoschFun.fExecute: TResultExecute;
begin

end;

procedure TBoschFun.pExecute;
var
  ServiceBoschFun: TServiceBoschFun;
begin
  ServiceBoschFun := TServiceBoschFun.Create;
  try
    ServiceBoschFun.ResultBoschFun := nil;
    ServiceBoschFun.pProcessar;
  finally
    FreeAndNil(ServiceBoschFun);
  end;
end;

procedure TBoschFun.pExecuteAll;
begin
  if not fCfgSis('UTIBCH', varBoolean) then
    Exit;

  pExecute;
end;


end.
