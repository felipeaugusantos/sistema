unit Produto.GS1CNP.Service.Cadastro;

interface

uses System.Classes, System.SysUtils, System.Variants, System.JSON, Winapi.ActiveX,
  Produto.GS1CNP.Interfaces.Service, Produto.GS1CNP.Interfaces.Cadastro,
  untFuncoesSimples, idHTTP, IdSSLOpenSSL, IdAuthentication, IdURI,
  Produto.GS1CNP.Tipos.Cadastro, Produto.GS1CNP.Shared.Types,
  Produto.GS1CNP.Interfaces.JSONParse, Produto.GS1CNP.Shared.JSONParse,
  Produto.GS1CNP.Shared.Functions, Produto.GS1CNP.Interfaces.Http, Produto.GS1CNP.Http;

type
  TProdutoGS1CNPServiceCadastro = class(TInterfacedObject, IProdutoGS1CNPServiceCadastro)
  private
    FHTTP: IProdutoGS1CNPHttp;
    FAccessToken: String;

    function RetornaJSONEnvio(const AParametros: IParametrosGS1CNPCadastro): String;

    function RetornaNumeroDeCadastro(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaDescricaoProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaGTIN(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaGPC(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaMarca(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaAceiteDeResponsabilidade(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaCompartilharDados(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaEmDesenvolvimentoSemImagemDestaque(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaEmDesenvolvimentoSemPesoBruto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaProdutoNaoPossuiCEST(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaGTINContidoFilhos(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaMedicamento(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaProdutoComMedidaVariavel(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaPaisDeOrigem(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaIdioma(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaStatusDoGTIN(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaIdentificacaoAdicional(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaImagensDoProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaTipoDeProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaTipoDaEmbalagem(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaPesoDoProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaMedidasDoProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaVidaUtilDoProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaTemperaturaDoProduto(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaSubstanciaPerigosa(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaFatorEmpilhamento(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaHierarquiaCamadas(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaAliquotaDeImpostosIPI(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaInformacoesNutricionais(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaAlergenos(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaInformacoesDeEntrega(const AParametros: IParametrosGS1CNPCadastro): String;
    function RetornaObservacoes(const AParametros: IParametrosGS1CNPCadastro): String;

    function ParseResponse(const AJson: string): IRetornoGS1CNPCadastro;
    function ParseResponse200(const AJson: string): IRetornoGS1CNPCadastro;
    function ParseResponse400(const AJson: string): IRetornoGS1CNPCadastro;

    function ResponseSuccess(const AJson: string): TResponseSuccess;
    function ResponseError(const AJson: string): TResponseError;

  public
    constructor Create(const AAccessToken: String); overload;
    destructor Destroy; override;

    function Cadastrar(const AParametros: IParametrosGS1CNPCadastro): IRetornoGS1CNPCadastro;

    class function New(const AAccessToken: String): IProdutoGS1CNPServiceCadastro;
  end;


implementation

uses Produto.GS1CNP.Auth;

{ TProdutoGS1CNPServiceCadastro }

function TProdutoGS1CNPServiceCadastro.Cadastrar(
  const AParametros: IParametrosGS1CNPCadastro): IRetornoGS1CNPCadastro;
Var
  LEnvio,
  LResponse: TStringStream;
  LURL: String;
begin
  Result := Nil;

  Try
    LURL := 'https://' + fCfgSis('GCURLA') + '/gs1/v0/products';

    FHTTP.SetCustomHeaders(FAccessToken);

    Try
      LEnvio    := TStringStream.Create(RetornaJSONEnvio(AParametros), TEncoding.UTF8);
      LResponse := TStringStream.Create('', TEncoding.UTF8);
      LURL      := TIdURI.URLEncode(LURL);

      FHTTP.GetHttp.Post(LURL, LEnvio, LResponse);

      If (Pos(IntToStr(FHTTP.GetHttp.ResponseCode), '200_201_') > 0) Then //requisicao post
      Begin
        LResponse.Seek(0, soFromBeginning);
        Result := ParseResponse(LResponse.DataString);
        Exit;
      End;

      Raise Exception.Create('Ocorreu um erro imprevisto na consulta!' + #13#10 +
                                      'Código do erro: ' + IntToStr(FHTTP.GetHttp.ResponseCode) + #13#10 +
                                      'Descrição do erro: ' + FHTTP.GetHttp.ResponseText);

    Except
      On E:EIdHTTPProtocolException Do
      Begin
        Result := ParseResponse(E.ErrorMessage);
      End;
      On E: Exception Do
      Begin
        If FHTTP.GetHttp.ResponseCode = 400 Then
          Raise Exception.Create('Não foi possível validar o usuário e senha!' + #13 +
                                 'Erro código 400.')
        Else
          Raise Exception.Create('Ocorreu um erro ao conectar-se ao serviço da GS1/CNP: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LResponse);
    CoFreeUnusedLibrariesEx(0,0);
  End;
end;

constructor TProdutoGS1CNPServiceCadastro.Create(const AAccessToken: String);
begin
  inherited Create;
  FHTTP := TProdutoGS1CNPHttp.New();
  FAccessToken := AAccessToken;
end;

destructor TProdutoGS1CNPServiceCadastro.Destroy;
begin
  inherited;
end;

class function TProdutoGS1CNPServiceCadastro.New(const AAccessToken: String): IProdutoGS1CNPServiceCadastro;
begin
  Result := Self.Create(AAccessToken);
end;

function TProdutoGS1CNPServiceCadastro.ParseResponse(
  const AJson: string): IRetornoGS1CNPCadastro;
begin
  Case FHTTP.GetHttp.ResponseCode Of
    200,201: Result := ParseResponse200(AJson);
  Else
    Result := ParseResponse400(AJson); //400,404,422,502:
  End;
end;

function TProdutoGS1CNPServiceCadastro.ParseResponse200(
  const AJson: string): IRetornoGS1CNPCadastro;
begin
  Result :=
    TRetornoGS1CNPCadastro.New
      .SetResponseCode('200')
      .SetResponseSuccess(ResponseSuccess(AJson))
      .SetJsonResponse(AJson);
end;

function TProdutoGS1CNPServiceCadastro.ParseResponse400(
  const AJson: string): IRetornoGS1CNPCadastro;
begin
  Result :=
    TRetornoGS1CNPCadastro.New
      .SetResponseCode('400')
      .SetResponseError(ResponseError(AJson))
      .SetJsonResponse(AJson);
end;

function TProdutoGS1CNPServiceCadastro.ResponseError(
  const AJson: string): TResponseError;
Var
  LJSONParse: IProdutoGS1CNPJSONParse;
begin
  Try
    LJSONParse := TProdutoGS1CNPJSONParse.New(AJson);

    Result.statusCode   := LJSONParse.GetEntryValue('statusCode');
    Result.error        := LJSONParse.GetEntryValue('error');
    Result.messageError := LJSONParse.GetEntryValue('message');
    Result.data.result  := LJSONParse.GetEntryValueChild('data', 'result', '');
    Result.data.validations := LJSONParse.GetEntryArrayValidations('data', 'validations');
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TProdutoGS1CNPServiceCadastro.ResponseError]');
  End;
end;

function TProdutoGS1CNPServiceCadastro.ResponseSuccess(
  const AJson: string): TResponseSuccess;
Var
  LJSONParse: IProdutoGS1CNPJSONParse;
begin
  Try
    LJSONParse := TProdutoGS1CNPJSONParse.New(AJson);

    Result.result := LJSONParse.GetEntryValue('result');

    If Result.result = 'SUCCESS' Then
    Begin
      Result.product.gtinStatusCode := LJSONParse.GetEntryValueChild('product', 'gtinStatusCode', '');
      Result.product.gs1TradeItemIdentificationKey.gs1TradeItemIdentificationKeyCode := LJSONParse.GetEntryValueChild('product', 'gs1TradeItemIdentificationKey', 'gs1TradeItemIdentificationKeyCode', '');
      Result.product.gs1TradeItemIdentificationKey.gtin := LJSONParse.GetEntryValueChild('product', 'gs1TradeItemIdentificationKey', 'gtin', '');
      Result.validations := LJSONParse.GetEntryArrayValidations('validations');
    End;

    If Result.result = 'ERROR' Then
    Begin
      Result.validations := LJSONParse.GetEntryArrayValidationsSampleField('validations');
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TProdutoGS1CNPServiceCadastro.ResponseSuccess]');
  End;
end;

function TProdutoGS1CNPServiceCadastro.RetornaAceiteDeResponsabilidade(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"acceptResponsibility": true,';

  If AParametros.GetAcceptResponsibility Then
    Exit;

  Result := '"acceptResponsibility": false,';
end;

function TProdutoGS1CNPServiceCadastro.RetornaAlergenos(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';

  If Length(AParametros.GetAllergens) <= 0 Then
    Exit;

  Result := Result + '"allergens": [';

  for LContador := 0 To Length(AParametros.GetAllergens) - 1 do
  begin
    if LContador > 0 then
      Result := Result + ',';

    Result := Result + '{';
    Result := Result + '  "allergenTypeCode": "' + AParametros.GetAllergens[LContador].allergenTypeCode + '",';
    Result := Result + '  "levelOfContainmentCode": "' + AParametros.GetAllergens[LContador].levelOfContainmentCode + '"';
    Result := Result + '}';
  end;

  Result := Result + '],';
end;

function TProdutoGS1CNPServiceCadastro.RetornaAliquotaDeImpostosIPI(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"dutyFeeTax": {';
  Result := Result + '  "dutyFeeTaxRate": ' + FloatToStr(AParametros.GetDutyFeeTax.dutyFeeTaxRate);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaCompartilharDados(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"shareDataIndicator": true,';

  If AParametros.GetShareDataIndicator Then
    Exit;

  Result := '"shareDataIndicator": false,';
end;

function TProdutoGS1CNPServiceCadastro.RetornaDescricaoProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"tradeItemDescriptionInformation": {';
  Result := Result + '  "tradeItemDescription": "' + AParametros.GetTradeItemDescriptionInformation.tradeItemDescription + '"';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaEmDesenvolvimentoSemImagemDestaque(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"inDevelopmentWithoutFeaturedImage": true,';

  If AParametros.GetInDevelopmentWithoutFeaturedImage Then
    Exit;

  Result := '"inDevelopmentWithoutFeaturedImage": false,';
end;

function TProdutoGS1CNPServiceCadastro.RetornaEmDesenvolvimentoSemPesoBruto(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"inDevelopmentWithoutGrossWeight": true,';

  If AParametros.GetInDevelopmentWithoutGrossWeight Then
    Exit;

  Result := '"inDevelopmentWithoutGrossWeight": false,';
end;

function TProdutoGS1CNPServiceCadastro.RetornaFatorEmpilhamento(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  If (AParametros.GetTradeItem.tradeItemUnitDescriptorCode <> 'PALLET') Then
    Exit;

  Result := Result + '"tradeItemStacking": {';
  Result := Result + '  "stackingFactor": ' + IntToStr(AParametros.GetTradeItemStacking.stackingFactor);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaGPC(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';
  Result := Result + '"tradeItemClassification": {';
  Result := Result + '  "gpcCategoryCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemClassification.gpcCategoryCode) + ',';
  Result := Result + '  "additionalTradeItemClassifications": [';

  for LContador := 0 To Length(AParametros.GetTradeItemClassification.additionalTradeItemClassifications) - 1 do
  begin
    if AParametros.GetWithoutCest And (AParametros.GetTradeItemClassification.additionalTradeItemClassifications[LContador].systemCode = 'CEST') then
      Continue;

    if LContador > 0 then
      Result := Result + ',';

    Result := Result + '{';
    Result := Result + ' "additionalTradeItemClassificationSystemCode": "' + AParametros.GetTradeItemClassification.additionalTradeItemClassifications[LContador].systemCode  + '",';
    Result := Result + ' "additionalTradeItemClassificationCodeValue": "' + AParametros.GetTradeItemClassification.additionalTradeItemClassifications[LContador].codeValue  + '"';
    Result := Result + '}';
  end;

  Result := Result + ']';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaGTIN(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"gs1TradeItemIdentificationKey": {';
  Result := Result + '  "gs1TradeItemIdentificationKeyCode": "' + AParametros.GetGs1TradeItemIdentificationKey.gs1TradeItemIdentificationKeyCode + '"';

  if not fEmptyStr(AParametros.GetGs1TradeItemIdentificationKey.gtin) then
    Result := Result + ',"gtin": "' + AParametros.GetGs1TradeItemIdentificationKey.gtin + '"';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaGTINContidoFilhos(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
 LContador: Integer;
begin
  Result := '';
  Result := Result + '"childTradeItems": [';

  for LContador := 0 to Length(AParametros.GetChildTradeItems) - 1 do
  begin
    if LContador > 0 Then
      Result := Result + ',';

    Result := Result + '{';
    Result := Result + '    "gtin": "' + AParametros.GetChildTradeItems[LContador].gtin + '",';
    Result := Result + '    "quantityOfNextLowerLevelTradeItem": ' + intToStr(AParametros.GetChildTradeItems[LContador].quantityOfNextLowerLevelTradeItem);
    Result := Result + '}';
  end;

  Result := Result + '],';
end;

function TProdutoGS1CNPServiceCadastro.RetornaHierarquiaCamadas(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  If (AParametros.GetTradeItem.tradeItemUnitDescriptorCode <> 'PALLET') Then
    Exit;

  Result := Result + '"tradeItemHierarchy": {';
  Result := Result + '  "quantityOfCompleteLayersContainedInATradeItem": ' + IntToStr(AParametros.GetTradeItemHierarchy.quantityOfCompleteLayersContainedInATradeItem) + ',';
  Result := Result + '  "quantityOfLayersPerPallet": ' + IntToStr(AParametros.GetTradeItemHierarchy.quantityOfLayersPerPallet) + ',';
  Result := Result + '  "quantityOfTradeItemsContainedInACompleteLayer": ' + IntToStr(AParametros.GetTradeItemHierarchy.quantityOfTradeItemsContainedInACompleteLayer) + ',';
  Result := Result + '  "quantityOfTradeItemsPerPalletLayer": ' + IntToStr(AParametros.GetTradeItemHierarchy.quantityOfTradeItemsPerPalletLayer);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaIdentificacaoAdicional(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';
  Result := Result + '"additionalTradeItemIdentifications": [';

  for LContador := 0 to Length(AParametros.GetAdditionalTradeItemIdentifications) - 1 do
  begin
    if LContador > 0 Then
      Result := Result + ',';

    Result := Result + '{';
    Result := Result + '  "additionalTradeItemIdentificationTypeCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetAdditionalTradeItemIdentifications[LContador].typeCode) + ',';
    Result := Result + '  "additionalTradeItemIdentificationValue": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetAdditionalTradeItemIdentifications[LContador].value);
    Result := Result + '}';
  end;

  Result := Result + '],';
end;

function TProdutoGS1CNPServiceCadastro.RetornaIdioma(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"languageCode": "' + AParametros.GetLanguageCode + '",';
end;

function TProdutoGS1CNPServiceCadastro.RetornaImagensDoProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';
  Result := Result + '"referencedFileInformations": [';

  for LContador := 0 to Length(AParametros.GetReferencedFileInformations) - 1 do
  begin
    if LContador > 0 then
      Result := Result + ',';

    Result := Result + '{';
    Result := Result + '    "contentDescription": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetReferencedFileInformations[LContador].contentDescription) + ',';
    Result := Result + '    "fileName": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetReferencedFileInformations[LContador].fileName) + ',';
    Result := Result + '    "uniformResourceIdentifier": "' + AParametros.GetReferencedFileInformations[LContador].uniformResourceIdentifier + '",';

    If AParametros.GetReferencedFileInformations[LContador].featuredFile Then
      Result := Result + '    "featuredFile": true,';

    If Not AParametros.GetReferencedFileInformations[LContador].featuredFile Then
      Result := Result + '    "featuredFile": false,';

    Result := Result + '    "referencedFileTypeCode": "' + AParametros.GetReferencedFileInformations[LContador].referencedFileTypeCode + '"';
    Result := Result + '}';
  end;

  Result := Result + '],';
end;

function TProdutoGS1CNPServiceCadastro.RetornaInformacoesDeEntrega(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

//  if AParametros.GetGtinStatusCode <> 'INACTIVE' then
//    Exit;

  Result := Result + '"deliveryPurchasingInformation": {';
  Result := Result + '  "orderQuantityMinimum": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetDeliveryPurchasingInformation.orderQuantityMinimum), ',', '.') + ',';
  Result := Result + '  "orderQuantityMultiple": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetDeliveryPurchasingInformation.orderQuantityMultiple), ',', '.') + ',';
  Result := Result + '  "orderSizingFactor": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetDeliveryPurchasingInformation.orderSizingFactor) + ',';
  If (AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime > 0) Then
    Result := Result + '  "startAvailabilityDateTime": "' + FormatDateTime('yyyy-mm-dd', AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime) + '"';
  If (AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime <= 0) Then
    Result := Result + '  "startAvailabilityDateTime": null';
//  Result := Result + '  "startAvailabilityDateTime": ' + DateTimeToStr(VS_Date);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaInformacoesNutricionais(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';

  Result := Result + '"nutrientHeader": {';
  Result := Result + '  "dailyValueIntakeReference": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetNutrientHeader.dailyValueIntakeReference) + ',';
  Result := Result + '  "servingSizeDescription": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetNutrientHeader.servingSizeDescription) + ',';
  Result := Result + '  "nutrientDetails": [';

  for LContador := 0 to Length(AParametros.GetNutrientHeader.nutrientDetails) - 1 do
  begin
    if LContador > 0 then
      Result := Result + ',';

    Result := Result + '{';
    Result := Result + '  "nutrientTypeCode": "' + AParametros.GetNutrientHeader.nutrientDetails[LContador].nutrientTypeCode + '",';
    Result := Result + '  "dailyValueIntakePercent": ' + IntToStr(AParametros.GetNutrientHeader.nutrientDetails[LContador].dailyValueIntakePercent) + ',';
    Result := Result + '  "quantityContained": {';
    Result := Result + '    "measurementUnitCode": "' + AParametros.GetNutrientHeader.nutrientDetails[LContador].quantityContained.measurementUnitCode + '",';
    Result := Result + '    "value": ' + IntToStr(AParametros.GetNutrientHeader.nutrientDetails[LContador].quantityContained.value);
    Result := Result + '}';
    Result := Result + '}';
  end;

  Result := Result + ']';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaJSONEnvio(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '{';

  Result := Result + RetornaNumeroDeCadastro(AParametros); //Número de cadastro

  Result := Result + RetornaStatusDoGTIN(AParametros); //Status do GTIN

  Result := Result + RetornaDescricaoProduto(AParametros); //Descrição

  Result := Result + RetornaGTIN(AParametros); //GTIN - Número Global do Item Comercial

  Result := Result + RetornaGPC(AParametros); //GPC - Classificação Global do Produto

  Result := Result + RetornaMarca(AParametros); //Marca
  Result := Result + RetornaAceiteDeResponsabilidade(AParametros); // Aceite de responsabilidade
  Result := Result + RetornaCompartilharDados(AParametros); // Compartilhar dados

  Result := Result + RetornaEmDesenvolvimentoSemImagemDestaque(AParametros); // Em desenvolvimento sem imagem destaque

  Result := Result + RetornaEmDesenvolvimentoSemPesoBruto(AParametros); // Em desenvolvimento sem peso bruto

  Result := Result + RetornaProdutoNaoPossuiCEST(AParametros); //Produto não possui CEST

  Result := Result + RetornaGTINContidoFilhos(AParametros); //GTIN Contido - GTIN Filhos

  Result := Result + RetornaMedicamento(AParametros);  // Medicamento

  Result := Result + RetornaProdutoComMedidaVariavel(AParametros);  // Produto com medida variavel

  Result := Result + RetornaPaisDeOrigem(AParametros); //Pais de Origem

  Result := Result + RetornaIdioma(AParametros); //Idioma

  Result := Result + RetornaIdentificacaoAdicional(AParametros); //Identificação Adicional

  Result := Result + RetornaImagensDoProduto(AParametros); //Imagens do produto

  Result := Result + RetornaTipoDeProduto(AParametros); //Tipo de produto

  Result := Result + RetornaTipoDaEmbalagem(AParametros); //Tipo da embalagem

  Result := Result + RetornaPesoDoProduto(AParametros); //Peso do produto

  Result := Result + RetornaMedidasDoProduto(AParametros); //Medidas do produto

  Result := Result + RetornaVidaUtilDoProduto(AParametros); //Vida util do produto

  Result := Result + RetornaTemperaturaDoProduto(AParametros); //Temperatura do produto

  Result := Result + RetornaSubstanciaPerigosa(AParametros); //Substancias Perigas

  Result := Result + RetornaFatorEmpilhamento(AParametros); //Fator Empilhamento

  Result := Result + RetornaHierarquiaCamadas(AParametros); //Hierarquia

  Result := Result + RetornaAliquotaDeImpostosIPI(AParametros); //Aliquota de impostos IPI

  Result := Result + RetornaInformacoesNutricionais(AParametros); //Nutrientes

  Result := Result + RetornaAlergenos(AParametros); //Alergeno

  Result := Result + RetornaInformacoesDeEntrega(AParametros); //Informações de entrega

  Result := Result + RetornaObservacoes(AParametros); //Observações
  Result := Result + '}';
end;

function TProdutoGS1CNPServiceCadastro.RetornaMarca(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"brandNameInformation": {';
  Result := Result + '  "brandName": "' + AParametros.GetBrandNameInformation.brandName + '"';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaMedicamento(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"isNonRetailHealthcareTradeItem": true,';

  if AParametros.GetIsNonRetailHealthcareTradeItem Then
    Exit;

  Result := '"isNonRetailHealthcareTradeItem": false,';
end;

function TProdutoGS1CNPServiceCadastro.RetornaMedidasDoProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"tradeItemMeasurements": {';

  Result := Result + '"netContent": {';
  Result := Result + '  "measurementUnitCode": "' + AParametros.GetTradeItemMeasurements.netContent.measurementUnitCode + '",';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.netContent.value), ',', '.');
  Result := Result + '},';

  Result := Result + '"height": {';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemMeasurements.height.measurementUnitCode) + ',';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.height.value), ',', '.');
  Result := Result + '},';

  Result := Result + '"width": {';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemMeasurements.width.measurementUnitCode) + ',';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.width.value), ',', '.');
  Result := Result + '},';

  Result := Result + '"depth": {';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemMeasurements.depth.measurementUnitCode) + ',';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.depth.value), ',', '.');
  Result := Result + '}';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaNumeroDeCadastro(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  Result := Result + '"company": {';
  Result := Result + '  "cad": "'+AParametros.GetCompany.cad + '"';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaObservacoes(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"comments": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetComments);
end;

function TProdutoGS1CNPServiceCadastro.RetornaPaisDeOrigem(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';
  Result := Result + '"placeOfProductActivity": {';
  Result := Result + '  "countryOfOrigin": {';
  Result := Result + '    "countryCode": "' + AParametros.GetPlaceOfProductActivity.countryOfOrigin.countryCode + '",';
  Result := Result + '    "countrySubdivisionCodes": [';

  for LContador := 0 to Length(AParametros.GetPlaceOfProductActivity.countryOfOrigin.countrySubdivisionCodes) - 1 do
  begin
    If LContador > 0 Then
      Result := Result + ',';

    Result := Result + '"' + AParametros.GetPlaceOfProductActivity.countryOfOrigin.countrySubdivisionCodes[LContador].origemCode + '"';
  end;

  Result := Result + ']';
  Result := Result + '}';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaPesoDoProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"tradeItemWeight": {';
  Result := Result + '  "grossWeight": {';
  Result := Result + '    "measurementUnitCode": "' + AParametros.GetTradeItemWeight.grossWeight.measurementUnitCode + '",';
  Result := Result + '    "value": ' + fReplaceStr(FloatToStr(AParametros.GetTradeItemWeight.grossWeight.value), ',', '.');
  Result := Result + '},';
  Result := Result + '"netWeight": {';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemWeight.netWeight.measurementUnitCode) + ',';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemWeight.netWeight.value), ',', '.');
  Result := Result + '}';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaProdutoComMedidaVariavel(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  Result := Result + '"variableTradeItemInformation": {';

  if AParametros.GetVariableTradeItemInformation.isTradeItemAVariableUnit then
    Result := Result + '  "isTradeItemAVariableUnit": true,';

  If Not AParametros.GetVariableTradeItemInformation.isTradeItemAVariableUnit Then
    Result := Result + '  "isTradeItemAVariableUnit": false,';

  Result := Result + '  "estimatedWeight":' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetVariableTradeItemInformation.estimatedWeight), ',', '.') + ',';
  Result := Result + '  "variableWeightRangeMinimum": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetVariableTradeItemInformation.variableWeightRangeMinimum), ',', '.') + ',';
  Result := Result + '  "variableWeightRangeMaximum": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetVariableTradeItemInformation.variableWeightRangeMaximum), ',', '.') + ',';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetVariableTradeItemInformation.measurementUnitCode);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaProdutoNaoPossuiCEST(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '"withoutCest": true,';

  If AParametros.GetWithoutCest Then
    Exit;

  Result := '"withoutCest": false,';
end;

function TProdutoGS1CNPServiceCadastro.RetornaStatusDoGTIN(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"gtinStatusCode": "' + AParametros.GetGtinStatusCode + '",';
end;

function TProdutoGS1CNPServiceCadastro.RetornaSubstanciaPerigosa(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  Result := Result + '"dangerousSubstanceProperties": {';

  if AParametros.GetDangerousSubstanceProperties.isDangerousSubstance Then
    Result := Result + '  "isDangerousSubstance": true';

  if not AParametros.GetDangerousSubstanceProperties.isDangerousSubstance Then
    Result := Result + '  "isDangerousSubstance": false';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaTemperaturaDoProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';
  Result := Result + '"tradeItemTemperatureInformation": {';

  Result := Result + '"maximumTemperature": {';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemTemperatureInformation.maximumTemperature.measurementUnitCode) + ',';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemTemperatureInformation.maximumTemperature.value), ',', '.');
  Result := Result + '},';

  Result := Result + '"minimumTemperature": {';
  Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemTemperatureInformation.minimumTemperature.measurementUnitCode) + ',';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemTemperatureInformation.minimumTemperature.value), ',', '.');
  Result := Result + '}';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaTipoDaEmbalagem(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  Result := Result + '"packaging": {';

  Result := Result + '  "packagingTypeCode": '+ TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetPackaging.packagingTypeCode) +',';
  Result := Result + '  "platformTypeCode": '+ TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetPackaging.platformTypeCode);

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaTipoDeProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
var
  LContador: Integer;
begin
  Result := '';
  Result := Result + '"tradeItem": {';

  Result := Result + '  "tradeItemUnitDescriptorCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItem.tradeItemUnitDescriptorCode) + ',';
  Result := Result + '  "targetMarket": {';
  Result := Result + '    "targetMarketCountryCodes": [';

  for LContador := 0 to Length(AParametros.GetTradeItem.targetMarket.targetMarketCountryCodes) - 1 do
  begin
    If LContador > 0 Then
      Result := Result + ',';

    Result := Result + ' "' + AParametros.GetTradeItem.targetMarket.targetMarketCountryCodes[LContador].code + '"';
  end;

  Result := Result + ']';
  Result := Result + '}';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceCadastro.RetornaVidaUtilDoProduto(
  const AParametros: IParametrosGS1CNPCadastro): String;
begin
  Result := '';

  if (AParametros.GetTradeItemLifespan.minimumTradeItemLifespanFromTimeOfProduction <= 0) Then
    Exit;

  Result := Result + '"tradeItemLifespan": {';
  Result := Result + '  "minimumTradeItemLifespanFromTimeOfProduction": ' + IntToStr(AParametros.GetTradeItemLifespan.minimumTradeItemLifespanFromTimeOfProduction);
  Result := Result + '},';
end;

end.
