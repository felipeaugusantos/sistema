unit Yapay.Api.Consulta.Cobranca.V3;

interface

uses
  System.Variants,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  Yapay.Api.Helpers,
  Yapay.Api.Resources,
  Yapay.Api.Core,
  Yapay.Api.Cobranca.Base,
  Yapay.Api.Ambiente,
  Yapay.Api.Tabela.Tabela3.FormasDePagamento,
  Yapay.Api.Tabela.Tabela4.StatusDaTransacao;

type
{$M+}
  TYapayApiTabelaParametrosConsultaCobrancaV3 = class(TYapayApiTabelaParametrosBase)
  strict private
    Fid: int64;
  published
    property Id: int64 read Fid write Fid;
  end;

  TYapayApiRespostaConsultaCobrancaV3ComSucesso = class(TYapayApiRespostaBaseComSucesso)
  public
    type
      TCobrancaTransacao = class
      private
        FResource: string;
        Fid: int64;
        FCustomer_name: string;
        FCustomer_email: string;
        FPrice: Double;
        FStatus_tag: string;
        FStatus_name: string;
        FCreated_at: TDateTime;
        function GetStatus: TStatusTransacao;
      published
        property Resource: string read FResource;
        property Id: int64 read Fid;
        property Customer_name: string read FCustomer_name;
        property Customer_email: string read FCustomer_email;
        property Price: Double read FPrice;
        property Status_tag: string read FStatus_tag;
        property Status_name: string read FStatus_name;
        property Created_at: TDateTime read FCreated_at;
        property Status: TStatusTransacao read GetStatus;
      end;

      TListCobrancaTransacao = TObjectList<TCobrancaTransacao>;

  private
    var
      FEmail_customer: string;
      FTransactions: TListCobrancaTransacao;
  published
    property Email_customer: string read FEmail_customer;
    property Transactions: TListCobrancaTransacao read FTransactions;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TYapayApiRespostaConsultaCobrancaV3ComSucessoList = class(TYapayApiRespostaBase)
  private
    type
      TData = TObjectList<TYapayApiRespostaBaseComSucesso>;
      TPagination = class
      protected
        FCurrent_page: int64;
        FPer_page: int64;
        FPage_amount: int64;
        FCount: int64;
      published
        property Current_page: int64 read FCurrent_page;
        property Per_page: int64 read FPer_page;
        property Page_amount: int64 read FPage_amount;
        property Count: int64 read FCount;
      end;
    var
      FResource: string;
      FPagination: TPagination;
      FData: TData;
  published
    property Resource: string read FResource;
    property Pagination: TPagination read FPagination;
    property Data: TData read FData;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  TYapayApiConsultaCobrancaV3 = class(TYapayApiCobrancaBase<TYapayApiTabelaParametrosConsultaCobrancaV3,TYapayApiRespostaConsultaCobrancaV3ComSucesso>)
  strict protected
    function GetEndereco: string; override;
    procedure ProcessaSucesso; override;
  public
    constructor Create; override;
  end;
{$M-}

implementation

{ TYapayApiEnvioCobrancaV3 }

constructor TYapayApiConsultaCobrancaV3.Create;
begin
  inherited;
  FMetodo := TYapayApiCoreMetodo.Get;
end;

function TYapayApiConsultaCobrancaV3.GetEndereco: string;
begin
  case Conexao.Ambiente of
    Sandbox: result := rsYAPAY_API_CONSULTA_COBRANCA_V3_ENDERECO_SANDBOX;
    Producao: result := rsYAPAY_API_CONSULTA_COBRANCA_V3_ENDERECO_PRODUCAO;
    else
    begin
      result := NullAsStringValue;
    end;
  end;

  if TabelaParametros.Id <> 0 then
    result := result + '/' + TabelaParametros.Id.ToString;
end;

procedure TYapayApiConsultaCobrancaV3.ProcessaSucesso;
var
  oJSONObj, oJSONSubObj: TJSONObject;
  oJSONArray: TJSONArray;
  oJSONValue: TJSONValue;
  i: integer;
  oDataItem: TYapayApiRespostaBaseComSucesso;
  oListTransactions: TYapayApiRespostaConsultaCobrancaV3ComSucesso.TListCobrancaTransacao;
  oTransaction: TYapayApiRespostaConsultaCobrancaV3ComSucesso.TCobrancaTransacao;
  sDecimalSeparator: char;
begin
  inherited;
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    if CompareText(TYapayApiRespostaBaseComSucesso(FResposta).Resource, 'charge') = 0 then
    begin
      oJSONValue := oJSONObj.Get('email_customer').JsonValue;
      TYapayApiRespostaConsultaCobrancaV3ComSucesso(FResposta).FEmail_customer := oJSONValue.Value;

      oListTransactions := TYapayApiRespostaConsultaCobrancaV3ComSucesso(FResposta).Transactions;

      oJSONValue := oJSONObj.Get('transactions').JsonValue;
      oJSONArray := oJSONValue as TJSONArray;

      for I := 0 to oJSONArray.Count - 1 do
      begin
        oTransaction := TYapayApiRespostaConsultaCobrancaV3ComSucesso.TCobrancaTransacao.Create;

        oJSONValue := oJSONArray.Items[i];
        oJSONSubObj := oJSONValue as TJSONObject;

        oJSONValue := oJSONSubObj.Get('resource').JsonValue;
        oTransaction.FResource := oJSONValue.Value;

        oJSONValue := oJSONSubObj.Get('id').JsonValue;
        oTransaction.Fid := oJSONValue.Value.ToInt64;

        oJSONValue := oJSONSubObj.Get('customer_name').JsonValue;
        oTransaction.FCustomer_name := oJSONValue.Value;

        oJSONValue := oJSONSubObj.Get('customer_email').JsonValue;
        oTransaction.FCustomer_email := oJSONValue.Value;

        oJSONValue := oJSONSubObj.Get('price').JsonValue;
        sDecimalSeparator := FormatSettings.DecimalSeparator;
        FormatSettings.DecimalSeparator := '.';
        oTransaction.FPrice := StrToFloat(oJSONValue.Value);
        FormatSettings.DecimalSeparator := sDecimalSeparator;

        oJSONValue := oJSONSubObj.Get('status_tag').JsonValue;
        oTransaction.FStatus_tag := oJSONValue.Value;

        oJSONValue := oJSONSubObj.Get('status_name').JsonValue;
        oTransaction.FStatus_name := oJSONValue.Value;

        oJSONValue := oJSONSubObj.Get('created_at').JsonValue;
        oTransaction.FCreated_at := oJSONValue.ToDatetime;

        oListTransactions.Add(oTransaction);
      end;
    end
    else if CompareText(TYapayApiRespostaConsultaCobrancaV3ComSucesso(FResposta).Resource, 'list') = 0 then
    begin
      if Assigned(FResposta) then
        FreeAndNil(FResposta);
      
      FResposta := TYapayApiRespostaConsultaCobrancaV3ComSucessoList.Create;
      TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).FTipoResposta := Sucesso;
      TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).FResource := 'list';

      oJSONValue := oJSONObj.Get('pagination').JsonValue;
      oJSONSubObj := oJSONValue as TJSONObject;

      oJSONValue := oJSONSubObj.Get('current_page').JsonValue;
      TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).Pagination.FCurrent_page := oJSONValue.Value.ToInt64;

      oJSONValue := oJSONSubObj.Get('per_page').JsonValue;
      TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).Pagination.FPer_page := oJSONValue.Value.ToInt64;

      oJSONValue := oJSONSubObj.Get('page_amount').JsonValue;
      TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).Pagination.FPage_amount := oJSONValue.Value.ToInt64;

      oJSONValue := oJSONSubObj.Get('count').JsonValue;
      TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).Pagination.FCount := oJSONValue.Value.ToInt64;

      oJSONValue := oJSONObj.Get('data').JsonValue;
      oJSONArray := oJSONValue as TJSONArray;

      for I := 0 to oJSONArray.Count - 1 do
      begin
        oDataItem := TYapayApiRespostaBaseComSucesso.Create;
        oJSONValue := oJSONArray.Items[i];
        ProcessaJSONSucesso(oJSONValue.ToJSON, oDataItem);
        TYapayApiRespostaConsultaCobrancaV3ComSucessoList(FResposta).Data.Add(oDataItem);
      end;
    end;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;

end;

{ TYapayApiRespostaConsultaCobrancaV3ComSucessoList }

constructor TYapayApiRespostaConsultaCobrancaV3ComSucessoList.Create;
begin
  inherited;
  FPagination := TPagination.Create;
  FData := TData.Create;
end;

destructor TYapayApiRespostaConsultaCobrancaV3ComSucessoList.Destroy;
begin
  if Assigned(FPagination) then
    FreeAndNil(FPagination);
  if Assigned(FData) then
    FreeAndNil(FData);
  inherited;
end;

{ TYapayApiRespostaConsultaCobrancaV3ComSucesso }

constructor TYapayApiRespostaConsultaCobrancaV3ComSucesso.Create;
begin
  inherited;
  FTransactions := TListCobrancaTransacao.Create;
end;

destructor TYapayApiRespostaConsultaCobrancaV3ComSucesso.Destroy;
begin
  if Assigned(FTransactions) then
    FreeAndNil(FTransactions);
  inherited;
end;

{ TYapayApiRespostaConsultaCobrancaV3ComSucesso.TCobrancaTransacao }

function TYapayApiRespostaConsultaCobrancaV3ComSucesso.TCobrancaTransacao.GetStatus: TStatusTransacao;
begin
  result := TStatusTransacao.FindByStatusTag(Self.FStatus_tag);
end;

end.
