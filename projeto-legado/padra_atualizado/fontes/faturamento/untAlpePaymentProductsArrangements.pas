unit untAlpePaymentProductsArrangements;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, System.Classes, untModulo, untMinioStorageAPICitel,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, untThreadUtils, Winapi.Windows,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type

  TAlpePositionsClass = class
  private
    FAmount: Extended;
    FCurrency: String;
    FType: String;
  public
    property amount: Extended read FAmount write FAmount;
    property currency: String read FCurrency write FCurrency;
    property &type: String read FType write FType;
  end;

  TInstallmentsClass = class
  private
    FDate: TDate;
    FPeriod: String;
  public
    property date: TDate read FDate write FDate;
    property period: String read FPeriod write FPeriod;
  end;

  TPlansClass = class
  private
    FInstallments: TArray<TInstallmentsClass>;
  public
    property installments: TArray<TInstallmentsClass> read FInstallments write FInstallments;
    destructor Destroy; override;
  end;

  TProductClass = class
  private
    FObjectType: String;
  public
    property objectType: String read FObjectType write FObjectType;
  end;

  TIdentificationsClass = class
  private
    FCreatedBy: String;
    FCreatedDate: String;
    FId: Extended;
    FType: String;
    FValue: String;
  public
    property createdBy: String read FCreatedBy write FCreatedBy;
    property createdDate: String read FCreatedDate write FCreatedDate;
    property id: Extended read FId write FId;
    property &type: String read FType write FType;
    property value: String read FValue write FValue;
  end;

  TPartyClass = class
  private
    FCreatedBy: String;
    FCreatedDate: String;
    FId: Extended;
    FIdentifications: TArray<TIdentificationsClass>;
    FName: String;
  public
    property createdBy: String read FCreatedBy write FCreatedBy;
    property createdDate: String read FCreatedDate write FCreatedDate;
    property id: Extended read FId write FId;
    property identifications: TArray<TIdentificationsClass> read FIdentifications write FIdentifications;
    property name: String read FName write FName;
    destructor Destroy; override;
  end;

  TInvolvedClass = class
  private
    FParty: TPartyClass;
    FType: String;
  public
    property party: TPartyClass read FParty write FParty;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
  end;

  TAlpeItemClass = class
  private
    FInvolved: TArray<TInvolvedClass>;
    FPlans: TArray<TPlansClass>;
    FPositions: TArray<TAlpePositionsClass>;
    FProduct: TProductClass;
    FStatus: String;
    FStopSupply: Boolean;
    FReason: String;
  public
    property involved: TArray<TInvolvedClass> read FInvolved write FInvolved;
    property plans: TArray<TPlansClass> read FPlans write FPlans;
    property positions: TArray<TAlpePositionsClass> read FPositions write FPositions;
    property product: TProductClass read FProduct write FProduct;
    property status: String read FStatus write FStatus;
    property stopSupply: Boolean read FStopSupply write FStopSupply;
    property reason: String read FReason write FReason;
    constructor Create;
    destructor Destroy; override;
  end;

  TPaymentProductsArrangements = class
  private
    FItems: TArray<TAlpeItemClass>;
  public
    property Items: TArray<TAlpeItemClass> read FItems write FItems;
    destructor Destroy; override;
    function ToJsonString(PaymentProductsArrangements: TPaymentProductsArrangements): string;
    class function FromJsonString(AJsonString: string): TPaymentProductsArrangements;
  end;

  TThreadProcessaAlpeBoleto = class(TSafeThread)
  private
    MinioConection: TAmazonConnectionInfo;
    StorageMinio: TAmazonStorageService;

    FBucket: String;

    procedure pEnviaXmlNotaFiscal;
  protected
    procedure Execute; override;
  public
    constructor create(strAccountKey, strAccountName, strStorageEndPoint, strBucket: String);
    destructor Destroy; Override;
  end;

  TControllerPaymentProductsArrangements = class
  private
    class function fGet(strBeneficiario, strPagador: String): TPaymentProductsArrangements;
    class procedure pGravaLimitesAlpe(strCliCgc: String; fltLimiteDisponivel, fltLimiteTotal, fltLimiteUtilizado: Double);
    class procedure pMarcaClienteUtilizaAlpe(strCliCgc: String);
  public
    class function fConsultaAlpeLimiteBoleto(const strCliCgc: String; var fltLimiteTotal, fltLimiteUtilizado, fltLimiteDisponivel: Double;
     var blnStopSupply: Boolean; var strMsg: String; blnExibirMensagem: Boolean = True): Boolean;
  end;

implementation

{TPlansClass}

uses untRestApi, untAlpeRestApi, untXMLNotaFiscal, untConstantes;

destructor TPlansClass.Destroy;
var
  LinstallmentsItem: TInstallmentsClass;
begin

 for LinstallmentsItem in FInstallments do
   LinstallmentsItem.free;

  inherited;
end;

{TPartyClass}

destructor TPartyClass.Destroy;
var
  LidentificationsItem: TIdentificationsClass;
begin

 for LidentificationsItem in FIdentifications do
   LidentificationsItem.free;

  inherited;
end;

{TInvolvedClass}

constructor TInvolvedClass.Create;
begin
  inherited;
  FParty := TPartyClass.Create();
end;

destructor TInvolvedClass.Destroy;
begin
  FParty.free;
  inherited;
end;

{TAlpeItemClass}

constructor TAlpeItemClass.Create;
begin
  inherited;
  FProduct := TProductClass.Create();
end;

destructor TAlpeItemClass.Destroy;
var
  LinvolvedItem: TInvolvedClass;
  LplansItem: TPlansClass;
  LpositionsItem: TAlpePositionsClass;
begin

 for LinvolvedItem in FInvolved do
   LinvolvedItem.free;
 for LplansItem in FPlans do
   LplansItem.free;
 for LpositionsItem in FPositions do
   LpositionsItem.free;

  FProduct.free;
  inherited;
end;

{TPaymentProductsArrangements}

destructor TPaymentProductsArrangements.Destroy;
var
  LItemsItem: TAlpeItemClass;
begin

 for LItemsItem in FItems do
   LItemsItem.free;

  inherited;
end;

function TPaymentProductsArrangements.ToJsonString(PaymentProductsArrangements: TPaymentProductsArrangements): string;
begin
  Result := TJson.ObjectToJsonString(PaymentProductsArrangements);
end;

class function TPaymentProductsArrangements.FromJsonString(AJsonString: string): TPaymentProductsArrangements;
begin
  Result := TJson.JsonToObject<TPaymentProductsArrangements>(AJsonString);
end;

{ TControllerPaymentProductsArrangements }

class function TControllerPaymentProductsArrangements.fConsultaAlpeLimiteBoleto(const strCliCgc: String; var fltLimiteTotal, fltLimiteUtilizado, fltLimiteDisponivel: Double;
var blnStopSupply: Boolean; var strMsg: String; blnExibirMensagem: Boolean = True): Boolean;
const
  PRODUTO_BOLETO = 'NEGOTIABLE_INSTRUMENTS_CESSION_PAYMENT_PRODUCT';
  LIMITE_DISPONIVEL = 'DEFAULT_LIMIT';
  LIMITE_TOTAL = 'TOTAL_LIMIT';
  LIMITE_UTILIZADO = 'USED_LIMIT';
var
  objAlpeLimiteBoleto: TPaymentProductsArrangements;
  AlpeItem: TAlpeItemClass;
  AlpePositons: TAlpePositionsClass;
begin
  Result := False;

  objAlpeLimiteBoleto := TControllerPaymentProductsArrangements.fGet(fRetCGCEmpresa(VS_strCodEmp),
                                                                     strCliCgc);

  try
    if not Assigned(objAlpeLimiteBoleto) then
    begin
      if blnExibirMensagem then
       fMensagem('','Não foi possível estabelecer uma comunicação com a ALPE!',['&OK']);

      Exit;
    end;

    if Length(objAlpeLimiteBoleto.Items) = 0 then
      Exit;

    for AlpeItem in objAlpeLimiteBoleto.Items do
    begin
      if AlpeItem.product.objectType <> PRODUTO_BOLETO then
        Continue;

      if AlpeItem.stopSupply then
      begin
        blnStopSupply := True;
        strMsg := AlpeItem.reason;
        Break;
        Exit;
      end;

      for AlpePositons in AlpeItem.positions do
      begin
        if AlpePositons.&type = LIMITE_DISPONIVEL then
          fltLimiteDisponivel := AlpePositons.amount
        else if AlpePositons.&type = LIMITE_TOTAL then
          fltLimiteTotal := AlpePositons.amount
        else if AlpePositons.&type = LIMITE_UTILIZADO then
          fltLimiteUtilizado := AlpePositons.amount;
      end;
    end;

    pMarcaClienteUtilizaAlpe(strCliCgc);
    pGravaLimitesAlpe(strCliCgc, fltLimiteDisponivel, fltLimiteTotal, fltLimiteUtilizado);

    Result := True;
  finally
    FreeAndNil(objAlpeLimiteBoleto);
  end;
end;

class function TControllerPaymentProductsArrangements.fGet(strBeneficiario,
  strPagador: String): TPaymentProductsArrangements;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ALPE', TControllerAlpe.fConfigurarAlpeKonekt);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'konekt-foundation/api/v1/payment-products-arrangements';// recurso producao
    if fCfgSis('URLKNK', varString) = 'https://apps.alpe-dev.com.br' then
      RestRequest.Resource := 'uat/next/konekt-foundation/api/v1/payment-products-arrangements';// recurso homologação
    RestRequest.Method   := rmGET;
    RestRequest.Params.AddItem('payeeUri', 'urn:party:cnpj:'+strBeneficiario, pkGETorPOST);
    RestRequest.Params.AddItem('payerUri', 'urn:party:cnpj:'+strPagador, pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TPaymentProductsArrangements.FromJsonString('{ "items" :'+JSONRetorno+'}');

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

class procedure TControllerPaymentProductsArrangements.pGravaLimitesAlpe(
  strCliCgc: String; fltLimiteDisponivel, fltLimiteTotal, fltLimiteUtilizado: Double);
var
  qryLimAlp: TUniQuery;
begin
  qryLimAlp := fCriaQuery(nil);
  try
    qryLimAlp.Close;
    qryLimAlp.SQL.Text :=
      ' INSERT INTO LIMALP '+
      '   (AUTOINCREM, '+
      '    LIM_DTAENT, '+
      '    LIM_HORENT, '+
      '    LIM_CGCCLI, '+
      '    LIM_LIMTOT, '+
      '    LIM_LIMUTI, '+
      '    LIM_LIMDIS) '+
      ' VALUES '+
      '   (:AUTINC, '+
      '    :DTAENT, '+
      '    :HORENT, '+
      '    :CGCCLI, '+
      '    :LIMTOT, '+
      '    :LIMUTI, '+
      '    :LIMDIS) ';

    qryLimAlp.ParamByName('AUTINC').AsString := fRetAutoIncrem('LIMALP', VS_strCodEmp);
    qryLimAlp.ParamByName('DTAENT').AsDate   := fNow;
    qryLimAlp.ParamByName('HORENT').AsTime   := fTime();
    qryLimAlp.ParamByName('CGCCLI').AsString := strCliCgc;
    qryLimAlp.ParamByName('LIMTOT').AsFloat  := fltLimiteTotal;
    qryLimAlp.ParamByName('LIMUTI').AsFloat  := fltLimiteUtilizado;
    qryLimAlp.ParamByName('LIMDIS').AsFloat  := fltLimiteDisponivel;
    qryLimAlp.ExecSQL;
  finally
    FreeAndNil(qryLimAlp);
  end;
end;

class procedure TControllerPaymentProductsArrangements.pMarcaClienteUtilizaAlpe(
  strCliCgc: String);
var
  qryCadCli: TUniQuery;
begin
  qryCadCli := fCriaQuery;
  try
    qryCadCli.Close;
    qryCadCli.SQL.Text :=
      ' UPDATE '+
      '   CADCLI '+
      ' SET '+
      '   CLI_UTIALP = :UTIALP '+
      ' WHERE '+
      '   CLI_C_G_C_ = :C_G_C_ ';

    qryCadCli.ParamByName('UTIALP').AsString := 'S';
    qryCadCli.ParamByName('C_G_C_').AsString := strCliCgc;
    qryCadCli.ExecSQL;
  finally
    FreeAndNil(qryCadCli);
  end;
end;

{ TThreadProcessaAlpeBoleto }

constructor TThreadProcessaAlpeBoleto.create(strAccountKey, strAccountName, strStorageEndPoint, strBucket: String);
begin
  inherited create(True);

  FBucket := strBucket;

  MinioConection := TAmazonConnectionInfo.Create(nil);
  MinioConection.UseDefaultEndpoints := False;
  MinioConection.AccountKey := strAccountKey;
  MinioConection.AccountName := strAccountName;
  MinioConection.StorageEndpoint := strStorageEndPoint;
  MinioConection.Protocol := 'https';

  StorageMinio := TAmazonStorageService.Create(MinioConection);
end;

destructor TThreadProcessaAlpeBoleto.Destroy;
begin
  if Assigned(MinioConection) then
    FreeAndNil(MinioConection);

  if Assigned(StorageMinio) then
    FreeAndNil(StorageMinio);

  inherited;
end;

procedure TThreadProcessaAlpeBoleto.Execute;
begin
  inherited;
  pEnviaXmlNotaFiscal;
end;

procedure TThreadProcessaAlpeBoleto.pEnviaXmlNotaFiscal;
var
  qryXml: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strPathXML,
  strNomeArquivo: String;

  Reader: TBinaryReader;
  FileContent: TBytes;
begin
  qryXml := fCriaQuery(Nil);
  qryAux := fCriaQuery(Nil);
  try
    qryXml.Close;
    qryXml.SQL.Text := STR_SQL_NAO_REPLICAR +
    ' SELECT '+
    '   F.AUTOINCREM AS AUTINC_FATGOR, '+
    '   D.DET_NUMDOC, '+
    '   D.DET_ESPDOC, '+
    '   D.DET_CODEMP, '+
    '   D.DET_CODCLI, '+
    '   D.DET_SERIE_, '+
    '   D.DET_TIP_FC '+
    ' FROM '+
    '   FATGOR F '+
    '   INNER JOIN EXTGOR E '+
    '     ON F.AUTOINCREM = E.FGO_SEQFGO '+
    '   INNER JOIN MOVDET D '+
    '     ON F.FGO_NUMDOC = D.DET_NUM_PD  AND '+
    '        F.FGO_ESPDOC = D.DET_ESP_PD  AND '+
    '        F.FGO_CODEMP = D.DET_EMP_PD  AND '+
    '        F.FGO_CODCLI = D.DET_CODCLI '+
    ' WHERE '+
    '   F.FGO_CODEMP = :CODEMP       AND '+
    '   E.FGO_TIPREC = "ALPE_BOLETO" AND '+
    '   NOT EXISTS (SELECT '+
    '                 1 '+
    '               FROM '+
    '                 FATDOR '+
    '               WHERE '+
    '                 FATDOR.FDO_SEQGER = F.AUTOINCREM AND '+
    '                 FATDOR.FDO_JAFATU = 0) '+
    ' GROUP BY '+
    '   AUTINC_FATGOR, '+
    '   D.DET_NUMDOC, '+
    '   D.DET_ESPDOC, '+
    '   D.DET_CODEMP, '+
    '   D.DET_CODCLI, '+
    '   D.DET_SERIE_, '+
    '   D.DET_TIP_FC ';

    qryXml.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryXml.Open;

    if qryXml.IsEmpty then
      Exit;

    while not qryXml.Eof do
    begin
      strPathXML := fMontaArquivosXML(qryXml.FieldByName('DET_NUMDOC').AsString,
                                      qryXml.FieldByName('DET_ESPDOC').AsString,
                                      qryXml.FieldByName('DET_CODEMP').AsString,
                                      qryXml.FieldByName('DET_CODCLI').AsString,
                                      qryXml.FieldByName('DET_SERIE_').AsString,
                                      qryXml.FieldByName('DET_TIP_FC').AsString,
                                      '');

      if not fEmptyStr(strPathXML) then
      begin
        Reader := TBinaryReader.Create(strPathXML);
        try
          FileContent := Reader.ReadBytes(Reader.BaseStream.Size);
        finally
          FreeAndNil(Reader);
        end;

        strNomeArquivo := ExtractFileName(strPathXML);

        if StorageMinio.UploadObject(FBucket+'/notas-fiscais-eletronicas/in', strNomeArquivo, FileContent, False, nil) then
        begin
          qryAux.Close;
          qryAux.SQL.Text := STR_SQL_NAO_REPLICAR+
          ' UPDATE '+
          '   EXTGOR '+
          ' SET '+
          '   FGO_TIPREC = "ALPE_BOLETO_F" '+
          ' WHERE '+
          '   FGO_SEQFGO = :AUTINC ';

          qryAux.ParamByName('AUTINC').AsString := qryXml.FieldByName('AUTINC_FATGOR').AsString;
          qryAux.ExecSQL;
        end;
      end;
      qryXml.Next;
    end;

  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryXml);
    FreeAndNil(qryAux);
    {$ENDIF LINUX}
  end;

end;

end.

