unit untAlpeCreateReceivablesCessions;

interface

uses
  Generics.Collections, Rest.Json, sysUtils,
  System.JSON, strUtils, REST.Types,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  untGravaMovCar,
  untTypesSistema,
  Data.DB, MemDS, DBAccess, Uni;

type

  {***********************************BEGIN******************************************
  ******************************OBJETOS DE ENVIO*************************************
  ********************************************************************************BL*}
  TTransactionsClass = class
  private
    FReferenceNumber: String;
  public
    property referenceNumber: String read FReferenceNumber write FReferenceNumber;
  end;

  TPartyClass = class
  private
    FUrn: String;
  public
    property urn: String read FUrn write FUrn;
  end;

  TRoleClass = class
  private
    FCode: String;
  public
    property code: String read FCode write FCode;
  end;

  TBuyerClass = class
  private
    FParty: TPartyClass;
    FRole: TRoleClass;
  public
    property party: TPartyClass read FParty write FParty;
    property role: TRoleClass read FRole write FRole;
    constructor Create;
    destructor Destroy; override;
  end;

  TOrderClass = class
  private
    FBuyer: TBuyerClass;
    FNumber: String;
  public
    property buyer: TBuyerClass read FBuyer write FBuyer;
    property number: String read FNumber write FNumber;
    constructor Create;
    destructor Destroy; override;
  end;

  TItemClass = class
  private
    FAmount: Extended;
    FApprovalDueDate: String;
    FComment: String;
    FEstimatedBillingDate: String;
    FOrder: TOrderClass;
  public
    property amount: Extended read FAmount write FAmount;
    property approvalDueDate: String read FApprovalDueDate write FApprovalDueDate;
    property comment: String read FComment write FComment;
    property estimatedBillingDate: String read FEstimatedBillingDate write FEstimatedBillingDate;
    property order: TOrderClass read FOrder write FOrder;
    constructor Create;
    destructor Destroy; override;
    class function ToJsonString(Item: TItemClass): string;
  end;

  TAlpeCreateReceivablesCessions = class
  private
    FItems: TArray<TItemClass>;
  public
    property Items: TArray<TItemClass> read FItems write FItems;
    constructor Create(length: Integer); reintroduce;
    destructor Destroy; override;
  end;
  {***********************************END********************************************
  ******************************OBJETOS DE ENVIO*************************************
  ********************************************************************************BL*}



  {***********************************BEGIN******************************************
  ******************************OBJETOS DE RETORNO***********************************
  ********************************************************************************BL*}
  TReceivablesClass = class
  private
    FAmount: Extended;
    FCardScheme: String;
    FDate: String;
    FStatus: String;
  public
    property amount: Extended read FAmount write FAmount;
    property cardScheme: String read FCardScheme write FCardScheme;
    property date: String read FDate write FDate;
    property status: String read FStatus write FStatus;
  end;

  TContentClass = class
  private
    FAmount: Extended;
    FApprovalDueDate: String;
    FComment: String;
    FEstimatedBillingDate: String;
    FId: Extended;
    FOrder: TOrderClass;
    FReceivables: TArray<TReceivablesClass>;
    FStatus: String;
  public
    property amount: Extended read FAmount write FAmount;
    property approvalDueDate: String read FApprovalDueDate write FApprovalDueDate;
    property comment: String read FComment write FComment;
    property estimatedBillingDate: String read FEstimatedBillingDate write FEstimatedBillingDate;
    property id: Extended read FId write FId;
    property order: TOrderClass read FOrder write FOrder;
    property receivables: TArray<TReceivablesClass> read FReceivables write FReceivables;
    property status: String read FStatus write FStatus;
    constructor Create;
    destructor Destroy; override;
  end;

  TAlpeRetornoCreateReceivablesCessions = class
  private
    FContent: TArray<TContentClass>;
    FDuration: Extended;
    FId: String;
    FInstant: String;
    FResource: String;
    FStatus: Extended;
  public
    property content: TArray<TContentClass> read FContent write FContent;
    property duration: Extended read FDuration write FDuration;
    property id: String read FId write FId;
    property instant: String read FInstant write FInstant;
    property resource: String read FResource write FResource;
    property status: Extended read FStatus write FStatus;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TAlpeRetornoCreateReceivablesCessions;
  end;
  {***********************************END********************************************
  ******************************OBJETOS DE RETORNO***********************************
  ********************************************************************************BL*}



  {**********************************BEGIN*******************************************
  *********************************CONTROLLER****************************************
  ********************************************************************************BL*}
  TControllerCreateReceivablesCessions = class
  private
    function fGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNumPok: String; fltValCar: Double; intSeqConRcx: Integer): Boolean;

    function fCreateReceivablesCessions(CreateReceivablesCessions: TItemClass; strSeqFgo: String): TAlpeRetornoCreateReceivablesCessions;
  public
    procedure pProcessarCreateReceivablesCessions;
  end;
  {************************************END*******************************************
  *********************************CONTROLLER****************************************
  ********************************************************************************BL*}

implementation

uses
  untRestApi, untAlpeRestApi, untAdiantamentoClienteGenerico;

{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE ENVIO*********************************
********************************************************************************BL*}
{TBuyerClass}

constructor TBuyerClass.Create;
begin
  inherited;
  FRole := TRoleClass.Create();
  FParty := TPartyClass.Create();
end;

destructor TBuyerClass.Destroy;
begin
  FRole.free;
  FParty.free;
  inherited;
end;

{TOrderClass}

constructor TOrderClass.Create;
begin
  inherited;
  FBuyer := TBuyerClass.Create();
end;

destructor TOrderClass.Destroy;
begin
  FBuyer.free;
  inherited;
end;

{TItemClass}

constructor TItemClass.Create;
begin
  inherited;
  FOrder := TOrderClass.Create();
end;

destructor TItemClass.Destroy;
begin
  FOrder.free;
  inherited;
end;

class function TItemClass.ToJsonString(Item: TItemClass): string;
begin
  result := '['+TJson.ObjectToJsonString(Item)+']';
end;

{TAlpeCreateReceivablesCessions}

constructor TAlpeCreateReceivablesCessions.Create(length: Integer);
var
  i: Integer;
begin
  SetLength(FItems, length);

  for i := 0 to length -1 do
    Items[i] := TItemClass.Create();
end;

destructor TAlpeCreateReceivablesCessions.Destroy;
var
  LItemsItem: TItemClass;
begin

 for LItemsItem in FItems do
   LItemsItem.free;

  inherited;
end;
{***********************************END********************************************
**************************MÉTODOS OBJETOS DE ENVIO*********************************
********************************************************************************BL*}



{***********************************BEGIN******************************************
**************************MÉTODOS OBJETOS DE RETORNO*******************************
********************************************************************************BL*}
{TContentClass}

constructor TContentClass.Create;
begin
  inherited;
  FOrder := TOrderClass.Create();
end;

destructor TContentClass.Destroy;
var
  LreceivablesItem: TReceivablesClass;
begin

 for LreceivablesItem in FReceivables do
   LreceivablesItem.free;

  FOrder.free;
  inherited;
end;

{TAlpeRetornoCreateReceivablesCessions}

destructor TAlpeRetornoCreateReceivablesCessions.Destroy;
var
  LcontentItem: TContentClass;
begin

 for LcontentItem in FContent do
   LcontentItem.free;

  inherited;
end;

class function TAlpeRetornoCreateReceivablesCessions.FromJsonString(AJsonString: string): TAlpeRetornoCreateReceivablesCessions;
begin
  Result := TJson.JsonToObject<TAlpeRetornoCreateReceivablesCessions>(AJsonString)
end;
{************************************END*******************************************
**************************MÉTODOS OBJETOS DE RETORNO*******************************
********************************************************************************BL*}



{***********************************BEGIN******************************************
******************************MÉTODOS CONTROLLER***********************************
********************************************************************************BL*}
{ TControllerReceivablesCessions }

procedure TControllerCreateReceivablesCessions.pProcessarCreateReceivablesCessions;
var
  qryCreate,
  qryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  CreateReceivablesCessions: TAlpeCreateReceivablesCessions;
  RetornoCreateReceivablesCessions: TAlpeRetornoCreateReceivablesCessions;

  i: Integer;
begin

  try
    qryCreate                 := fCriaQuery;
    qryUpdate                 := fCriaQuery;
    CreateReceivablesCessions := nil;
    RetornoCreateReceivablesCessions := nil;
    try
      qryCreate.Close;
      qryCreate.SQL.Clear;
      qryCreate.SQL.Text :=
      ' SELECT '+
      '   F.AUTOINCREM,  '+
      '   F.FGO_VLRCON,  '+
      '   C.CLI_C_G_C_,  '+
      '   F.FGO_NUMDOC,  '+
      '   F.FGO_CODEMP,  '+
      '   F.FGO_CODCLI,  '+
      '   L.EMP_C_G_C_   '+
      ' FROM '+
      '   FATGOR F '+
      ' INNER JOIN EXTGOR E  '+
      '   ON F.AUTOINCREM = E.FGO_SEQFGO '+
      ' INNER JOIN CADCLI C '+
      '   ON F.FGO_CODCLI = C.CLI_CODCLI' +
      ' INNER JOIN CADEMP L '+
      '   ON L.EMP_CODEMP = :CODEMP '+
      ' WHERE '+
      '   F.FGO_ESPDOC = "PD"   AND '+
      '   F.FGO_LIBERA = 0      AND '+
      '   E.FGO_TIPREC = "ALPE" AND '+
      '   F.FGO_MOTBAI IS NULL  AND '+
      '   F.FGO_CODEMP = :CODEMP    ';

      qryCreate.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCreate.Open;

      if not qryCreate.IsEmpty then
      begin
        CreateReceivablesCessions := TAlpeCreateReceivablesCessions.Create(qryCreate.RecordCount);

        for i := 0 to Length(CreateReceivablesCessions.Items)-1 do
        begin

          CreateReceivablesCessions.Items[i].amount                := qryCreate.FieldByName('FGO_VLRCON').AsFloat;
          CreateReceivablesCessions.Items[i].approvalDueDate       := FormatDateTime('yyyy-mm-dd', Date);
          CreateReceivablesCessions.Items[i].comment               := 'Created by Gateway Client';
          CreateReceivablesCessions.Items[i].estimatedBillingDate  := FormatDateTime('yyyy-mm-dd', Date+2);
          CreateReceivablesCessions.Items[i].order.buyer.party.urn := 'urn:party:cnpj:'+qryCreate.FieldByName('CLI_C_G_C_').AsString;
          CreateReceivablesCessions.Items[i].order.buyer.role.code := 'BUYER';
          CreateReceivablesCessions.Items[i].order.number          := qryCreate.FieldByName('EMP_C_G_C_').AsString+':'+
                                                                      qryCreate.FieldByName('FGO_NUMDOC').AsString+
                                                                      qryCreate.FieldByName('FGO_CODEMP').AsString;

          RetornoCreateReceivablesCessions := fCreateReceivablesCessions(
                                                CreateReceivablesCessions.Items[i],
                                                qryCreate.FieldByName('AUTOINCREM').AsString
                                              );

          if RetornoCreateReceivablesCessions <> nil then
          begin
            fStartTransaction;
            Try
              qryUpdate.Close;
              qryUpdate.SQL.Clear;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   FATGOR '+
              ' SET '+
              '   FGO_LIBERA = 1 '+
              '  ,FGO_OPELIB = "999" '+
              '  ,FGO_DIGLIB = "999" '+
              '  ,FGO_DTALIB = :DTALIB '+
              '  ,FGO_HORLIB = :HORLIB '+
              '  ,FGO_OBSL01 = :OBSL01 '+
              '  ,FGO_NUMPOK = :NUMPOK '+
              ' WHERE '+
              '   AUTOINCREM = :AUTOIN';

              qryUpdate.ParamByName('DTALIB').AsDate   := Date;
              qryUpdate.ParamByName('HORLIB').AsTime   := Time;
              qryUpdate.ParamByName('OBSL01').AsString := 'LIBERAÇÃO AUTOMÁTICA ALPE';
              qryUpdate.ParamByName('NUMPOK').AsString := IIF(RetornoCreateReceivablesCessions.content[0].id <> 0,
                                                              FloatToStr(RetornoCreateReceivablesCessions.content[0].id),
                                                              RetornoCreateReceivablesCessions.FId);
              qryUpdate.ParamByName('AUTOIN').AsString := qryCreate.FieldByName('AUTOINCREM').AsString;
              qryUpdate.ExecSQL;

              if fGravarAdtCliCartao(qryCreate.FieldByName('FGO_NUMDOC').AsString,
                                     'PD',
                                     qryCreate.FieldByName('FGO_CODEMP').AsString,
                                     qryCreate.FieldByName('FGO_CODCLI').AsString,
                                     IIF(RetornoCreateReceivablesCessions.content[0].id <> 0,
                                         FloatToStr(RetornoCreateReceivablesCessions.content[0].id),
                                         RetornoCreateReceivablesCessions.FId),
                                     qryCreate.FieldByName('FGO_VLRCON').AsFloat,
                                     StrToInt(fRetRcxCon(qryCreate.FieldByName('FGO_CODEMP').AsString))) then
                fCommit
              else
                fRollback;
            Except
              On E: Exception Do
              Begin
                fRollback;
              End;
            End;
          end;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(spIdRecebiveisAlpe, [VS_strCodEmp]));
          {$ENDIF LINUX}

          qryCreate.Next;
          Sleep(1000);
        end;
      end;
    finally
    {$IFNDEF LINUX}
      qryCreate.Free;
      qryUpdate.Free;
    {$ENDIF LINUX}
      if Assigned(CreateReceivablesCessions) then
        CreateReceivablesCessions.Free;
      if Assigned(RetornoCreateReceivablesCessions) then
        RetornoCreateReceivablesCessions.Free;
    end;
  except
    on E: Exception do
      pGravarErro(True, E.Message);
  end;

end;

function TControllerCreateReceivablesCessions.fGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNumPok: String; fltValCar: Double; intSeqConRcx: Integer): Boolean;
  Var
    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;
    totModalidades: TTotaisAdiantamento;
begin
  FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);
  FillChar(totModalidades, SizeOf(totModalidades), #0);

  documento.strNumDoc := strNumDoc;
  documento.strEspDoc := strEspDoc;
  documento.strCodEmp := strCodEmp;
  documento.strCodCli := strCodCli;
  documento.fltValLan := fltValCar;

  dadosAdiantamento.AddDocumento(documento);

  dadosAdiantamento.strTipLan := 'C';
  dadosAdiantamento.dtaDtaLan := VS_Date;
  dadosAdiantamento.horHorLan := Time;
  dadosAdiantamento.strOpeLan := '999';
  dadosAdiantamento.strEmpLan := strCodEmp;
  dadosAdiantamento.intSeqCon := intSeqConRcx;
  dadosAdiantamento.strDescri := 'RECEBÍVEIS ALPE ADIANTAMENTO PEDIDO: ' + strNumDoc + '-' + strEspDoc + ' - NUMPOK: ' + strNumPok;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := fltValCar;
  dadosAdiantamento.fltValLan := fltValCar;

  Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);
end;

function TControllerCreateReceivablesCessions.fCreateReceivablesCessions(
  CreateReceivablesCessions: TItemClass; strSeqFgo: String): TAlpeRetornoCreateReceivablesCessions;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ALPE', TControllerAlpe.fConfigurarAlpe);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'accounting/api/v1/receivables-cessions';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               TItemClass.ToJsonString(CreateReceivablesCessions),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200','201', '409'], strSeqFgo) then
    begin
      if RestRequest.Response.StatusCode.ToString = '409' then
        JSONRetorno := StringReplace(JSONRetorno,
                                     Copy(JSONRetorno, Pos('*', JSONRetorno), Pos('{', JSONRetorno)-1),
                                     '',
                                     [rfReplaceAll]);

      Result := TAlpeRetornoCreateReceivablesCessions.FromJsonString(JSONRetorno);
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;
{************************************END*******************************************
******************************MÉTODOS CONTROLLER***********************************
********************************************************************************BL*}


end.

