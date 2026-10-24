unit Produto.GS1CNP.Service.Atualiza;

interface

uses System.Classes, System.SysUtils, System.Variants, System.JSON, Winapi.ActiveX,
  idHTTP, IdSSLOpenSSL, IdAuthentication, IdURI, Produto.GS1CNP.Interfaces.Service,
  untFuncoesSimples, Produto.GS1CNP.Interfaces.Atualiza, Produto.GS1CNP.Auth,
  Produto.GS1CNP.Tipos.Atualiza, Produto.GS1CNP.Shared.Types, Produto.GS1CNP.Interfaces.JSONParse,
  Produto.GS1CNP.Shared.JSONParse, Produto.GS1CNP.Shared.Functions, Produto.GS1CNP.Interfaces.Http,
  Produto.GS1CNP.Http;

type
  TProdutoGS1CNPServiceAtualiza = class(TInterfacedObject, IProdutoGS1CNPServiceAtualiza)
  private
    FHTTP: IProdutoGS1CNPHttp;
    FAccessToken: String;

    function RetornaJSONEnvio(const AParametros: IParametrosGS1CNPAtualiza): String;

    function RetornaGPC(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaMarca(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaAceiteDeResponsabilidade(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaCompartilharDados(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaEmDesenvolvimentoSemImagemDestaque(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaEmDesenvolvimentoSemPesoBruto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaProdutoNaoPossuiCEST(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaPaisDeOrigem(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaStatusDoGTIN(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaImagensDoProduto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaTipoDeProduto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaTipoDaEmbalagem(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaPesoDoProduto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaMedidasDoProduto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaVidaUtilDoProduto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaTemperaturaDoProduto(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaSubstanciaPerigosa(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaFatorEmpilhamento(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaAliquotaDeImpostosIPI(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaInformacoesNutricionais(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaAlergenos(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaInformacoesDeEntrega(const AParametros: IParametrosGS1CNPAtualiza): String;
    function RetornaObservacoes(const AParametros: IParametrosGS1CNPAtualiza): String;

    function ParseResponse(const AJson: string): IRetornoGS1CNPAtualiza;
    function ParseResponse200(const AJson: string): IRetornoGS1CNPAtualiza;
    function ParseResponse400(const AJson: string): IRetornoGS1CNPAtualiza;

    function ResponseSuccess(const AJson: string): TResponseSuccess;
    function ResponseError(const AJson: string): TResponseError;

  public
    function Atualizar(const AParametros: IParametrosGS1CNPAtualiza): IRetornoGS1CNPAtualiza;

    constructor Create(const AAccessToken: String); overload;

    class function New(const AAccessToken: String): IProdutoGS1CNPServiceAtualiza;
  end;

implementation

{ TProdutoGS1CNPServiceAtualiza }

function TProdutoGS1CNPServiceAtualiza.Atualizar(
  const AParametros: IParametrosGS1CNPAtualiza): IRetornoGS1CNPAtualiza;
Var
  LEnvio,
  LResponse: TStringStream;
  LURL: String;
begin
  Result := Nil;

  Try
    LURL := 'https://' + fCfgSis('GCURLA') + '/gs1/v0/products/' + AParametros.GetGtin;

    FHTTP.SetCustomHeaders(FAccessToken);

    Try
      LEnvio    := TStringStream.Create(RetornaJSONEnvio(AParametros), TEncoding.UTF8);
      LResponse := TStringStream.Create('', TEncoding.UTF8);
      LURL      := TIdURI.URLEncode(LURL);

      FHTTP.GetHttp.Patch(LURL, LEnvio, LResponse);

      If FHTTP.GetHttp.ResponseCode = 200 Then //sucesso
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

constructor TProdutoGS1CNPServiceAtualiza.Create(const AAccessToken: String);
begin
  inherited Create;
  FHTTP := TProdutoGS1CNPHttp.New();
  FAccessToken := AAccessToken;
end;

class function TProdutoGS1CNPServiceAtualiza.New(const AAccessToken: String): IProdutoGS1CNPServiceAtualiza;
begin
  Result := Self.Create(AAccessToken);
end;

function TProdutoGS1CNPServiceAtualiza.ParseResponse(
  const AJson: string): IRetornoGS1CNPAtualiza;
begin
  Case FHTTP.GetHttp.ResponseCode Of
    200,201: Result := ParseResponse200(AJson);
  Else
    Result := ParseResponse400(AJson); //400,404,422,502
  End;
end;

function TProdutoGS1CNPServiceAtualiza.ParseResponse200(
  const AJson: string): IRetornoGS1CNPAtualiza;
begin
  Result :=
    TRetornoGS1CNPAtualiza.New
      .SetResponseCode('200')
      .SetResponseSuccess(ResponseSuccess(AJson))
      .SetJsonResponse(AJson);
end;

function TProdutoGS1CNPServiceAtualiza.ParseResponse400(
  const AJson: string): IRetornoGS1CNPAtualiza;
begin
  Result :=
    TRetornoGS1CNPAtualiza.New
      .SetResponseCode('400')
      .SetResponseError(ResponseError(AJson))
      .SetJsonResponse(AJson);
end;

function TProdutoGS1CNPServiceAtualiza.ResponseError(
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
      pMensagensErro(e.Message, '[TProdutoGS1CNPServiceAtualiza.ResponseError]');
  End;
end;

function TProdutoGS1CNPServiceAtualiza.ResponseSuccess(
  const AJson: string): TResponseSuccess;
Var
  LJSONParse: IProdutoGS1CNPJSONParse;
begin
  Try
    LJSONParse := TProdutoGS1CNPJSONParse.New(AJson);

    Result.result := LJSONParse.GetEntryValue('result');
    Result.product.gtinStatusCode := LJSONParse.GetEntryValueChild('product', 'gtinStatusCode', '');
    Result.product.gs1TradeItemIdentificationKey.gs1TradeItemIdentificationKeyCode := LJSONParse.GetEntryValueChild('product', 'gs1TradeItemIdentificationKey', 'gs1TradeItemIdentificationKeyCode', '');
    Result.product.gs1TradeItemIdentificationKey.gtin := LJSONParse.GetEntryValueChild('product', 'gs1TradeItemIdentificationKey', 'gtin', '');
    Result.validations := LJSONParse.GetEntryArrayValidations('validations');
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TProdutoGS1CNPServiceAtualiza.ResponseSuccess]');
  End;
end;

function TProdutoGS1CNPServiceAtualiza.RetornaAceiteDeResponsabilidade(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '"acceptResponsibility": true,';

  If AParametros.GetAcceptResponsibility Then
    Exit;

  Result := '"acceptResponsibility": false,';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaAlergenos(
  const AParametros: IParametrosGS1CNPAtualiza): String;
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

function TProdutoGS1CNPServiceAtualiza.RetornaAliquotaDeImpostosIPI(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';

  If AParametros.GetDutyFeeTax.dutyFeeTaxRate <= 0 Then
    Exit;

  Result := Result + '"dutyFeeTax": {';
  Result := Result + '  "dutyFeeTaxRate": ' + FloatToStr(AParametros.GetDutyFeeTax.dutyFeeTaxRate);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaCompartilharDados(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '"shareDataIndicator": true,';

  If AParametros.GetShareDataIndicator Then
    Exit;

  Result := '"shareDataIndicator": false,';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaEmDesenvolvimentoSemImagemDestaque(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '"inDevelopmentWithoutFeaturedImage": true,';

  If AParametros.GetInDevelopmentWithoutFeaturedImage Then
    Exit;

  Result := '"inDevelopmentWithoutFeaturedImage": false,';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaEmDesenvolvimentoSemPesoBruto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '"inDevelopmentWithoutGrossWeight": true,';

  If AParametros.GetInDevelopmentWithoutGrossWeight Then
    Exit;

  Result := '"inDevelopmentWithoutGrossWeight": false,';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaFatorEmpilhamento(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';

  If (AParametros.GetTradeItem.tradeItemUnitDescriptorCode <> 'PALLET') Then
    Exit;

  Result := Result + '"tradeItemStacking": {';
  Result := Result + '  "stackingFactor": ' + IntToStr(AParametros.GetTradeItemStacking.stackingFactor);
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaGPC(
  const AParametros: IParametrosGS1CNPAtualiza): String;
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

function TProdutoGS1CNPServiceAtualiza.RetornaImagensDoProduto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
var
  LContador: Integer;
begin
  Result := '';

  If Length(AParametros.GetReferencedFileInformations) <= 0 Then
    Exit;

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

function TProdutoGS1CNPServiceAtualiza.RetornaInformacoesDeEntrega(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';

  If (AParametros.GetDeliveryPurchasingInformation.orderQuantityMinimum <= 0) And
     (AParametros.GetDeliveryPurchasingInformation.orderQuantityMultiple <= 0) And
     (fEmptyStr(AParametros.GetDeliveryPurchasingInformation.orderSizingFactor)) And
     (AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime <= 0) Then
    Exit;

  Result := Result + '"deliveryPurchasingInformation": {';
  Result := Result + '  "orderQuantityMinimum": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetDeliveryPurchasingInformation.orderQuantityMinimum), ',', '.') + ',';
  Result := Result + '  "orderQuantityMultiple": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetDeliveryPurchasingInformation.orderQuantityMultiple), ',', '.') + ',';
  Result := Result + '  "orderSizingFactor": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetDeliveryPurchasingInformation.orderSizingFactor) + ',';

  If (AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime > 0) Then
    Result := Result + '  "startAvailabilityDateTime": "' + FormatDateTime('yyyy-mm-dd', AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime) + '"';
  If (AParametros.GetDeliveryPurchasingInformation.startAvailabilityDateTime <= 0) Then
    Result := Result + '  "startAvailabilityDateTime": null';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaInformacoesNutricionais(
  const AParametros: IParametrosGS1CNPAtualiza): String;
var
  LContador: Integer;
begin
  Result := '';

  If Length(AParametros.GetNutrientHeader.nutrientDetails) <= 0 Then
    Exit;

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


function TProdutoGS1CNPServiceAtualiza.RetornaJSONEnvio(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  // Somente os campos que permitem alteracao de acordo com o manual

  Result := '{';

  Result := Result + RetornaStatusDoGTIN(AParametros); //Status do GTIN

  Result := Result + RetornaGPC(AParametros); //GPC - Classificação Global do Produto

  Result := Result + RetornaMarca(AParametros); //Marca
  Result := Result + RetornaAceiteDeResponsabilidade(AParametros); // Aceite de responsabilidade
  Result := Result + RetornaCompartilharDados(AParametros); // Compartilhar dados

  Result := Result + RetornaEmDesenvolvimentoSemImagemDestaque(AParametros); // Em desenvolvimento sem imagem destaque

  Result := Result + RetornaEmDesenvolvimentoSemPesoBruto(AParametros); // Em desenvolvimento sem peso bruto

  Result := Result + RetornaProdutoNaoPossuiCEST(AParametros); //Produto não possui CEST

  Result := Result + RetornaPaisDeOrigem(AParametros); //Pais de Origem

  Result := Result + RetornaImagensDoProduto(AParametros); //Imagens do produto

  Result := Result + RetornaTipoDeProduto(AParametros); //Tipo de produto

  Result := Result + RetornaTipoDaEmbalagem(AParametros); //Tipo da embalagem

  Result := Result + RetornaPesoDoProduto(AParametros); //Peso do produto

  Result := Result + RetornaMedidasDoProduto(AParametros); //Medidas do produto

  Result := Result + RetornaVidaUtilDoProduto(AParametros); //Vida util do produto

  Result := Result + RetornaTemperaturaDoProduto(AParametros); //Temperatura do produto

  Result := Result + RetornaSubstanciaPerigosa(AParametros); //Substancias Perigas

  Result := Result + RetornaFatorEmpilhamento(AParametros); //Fator Empilhamento

  Result := Result + RetornaAliquotaDeImpostosIPI(AParametros); //Aliquota de impostos IPI

  Result := Result + RetornaInformacoesNutricionais(AParametros); //Nutrientes

  Result := Result + RetornaAlergenos(AParametros); //Alergeno

  Result := Result + RetornaInformacoesDeEntrega(AParametros); //Informações de entrega

  Result := Result + RetornaObservacoes(AParametros); //Observações
  Result := Result + '}';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaMarca(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';
  Result := Result + '"brandNameInformation": {';
  Result := Result + '  "brandName": "' + AParametros.GetBrandNameInformation.brandName + '"';
  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaMedidasDoProduto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';
  Result := Result + '"tradeItemMeasurements": {';

  Result := Result + '"netContent": {';
  Result := Result + '  "measurementUnitCode": "' + AParametros.GetTradeItemMeasurements.netContent.measurementUnitCode + '",';
  Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.netContent.value), ',', '.');

  If Not fEmptyStr(AParametros.GetTradeItemMeasurements.height.measurementUnitCode) Then
  Begin
    Result := Result + '},';

    Result := Result + '"height": {';
    Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemMeasurements.height.measurementUnitCode) + ',';
    Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.height.value), ',', '.');
  End;

  If Not fEmptyStr(AParametros.GetTradeItemMeasurements.width.measurementUnitCode) Then
  Begin
    Result := Result + '},';

    Result := Result + '"width": {';
    Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemMeasurements.width.measurementUnitCode) + ',';
    Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.width.value), ',', '.');
  End;

  If Not fEmptyStr(AParametros.GetTradeItemMeasurements.depth.measurementUnitCode) Then
  Begin
    Result := Result + '},';

    Result := Result + '"depth": {';
    Result := Result + '  "measurementUnitCode": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetTradeItemMeasurements.depth.measurementUnitCode) + ',';
    Result := Result + '  "value": ' + fReplaceStr(TProdutoGS1CNPFunctions.SerializerDouble(AParametros.GetTradeItemMeasurements.depth.value), ',', '.');
  End;
  Result := Result + '}';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaObservacoes(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '"comments": ' + TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetComments);
end;

function TProdutoGS1CNPServiceAtualiza.RetornaPaisDeOrigem(
  const AParametros: IParametrosGS1CNPAtualiza): String;
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

function TProdutoGS1CNPServiceAtualiza.RetornaPesoDoProduto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
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

function TProdutoGS1CNPServiceAtualiza.RetornaProdutoNaoPossuiCEST(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '"withoutCest": true,';

  If AParametros.GetWithoutCest Then
    Exit;

  Result := '"withoutCest": false,';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaStatusDoGTIN(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';
  Result := Result + '"gtinStatusCode": "' + AParametros.GetGtinStatusCode + '",';
//  Result := Result + '"gtinStatusCode": "ACTIVE",';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaSubstanciaPerigosa(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';

  Result := Result + '"dangerousSubstanceProperties": {';

  if AParametros.GetDangerousSubstanceProperties.isDangerousSubstance Then
    Result := Result + '  "isDangerousSubstance": true';

  if not AParametros.GetDangerousSubstanceProperties.isDangerousSubstance Then
    Result := Result + '  "isDangerousSubstance": false';

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaTemperaturaDoProduto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';

  If fEmptyStr(AParametros.GetTradeItemTemperatureInformation.maximumTemperature.measurementUnitCode) And
     fEmptyStr(AParametros.GetTradeItemTemperatureInformation.minimumTemperature.measurementUnitCode) Then
     Exit;

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

function TProdutoGS1CNPServiceAtualiza.RetornaTipoDaEmbalagem(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';

  If fEmptyStr(AParametros.GetPackaging.packagingTypeCode) Then
    Exit;

  Result := Result + '"packaging": {';

  Result := Result + '  "packagingTypeCode": '+ TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetPackaging.packagingTypeCode) +',';
  Result := Result + '  "platformTypeCode": '+ TProdutoGS1CNPFunctions.SerializerStr(AParametros.GetPackaging.platformTypeCode);

  Result := Result + '},';
end;

function TProdutoGS1CNPServiceAtualiza.RetornaTipoDeProduto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
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

function TProdutoGS1CNPServiceAtualiza.RetornaVidaUtilDoProduto(
  const AParametros: IParametrosGS1CNPAtualiza): String;
begin
  Result := '';
  Result := Result + '"tradeItemLifespan": {';
  Result := Result + '  "minimumTradeItemLifespanFromTimeOfProduction": ' + IntToStr(AParametros.GetTradeItemLifespan.minimumTradeItemLifespanFromTimeOfProduction);
  Result := Result + '},';
end;


end.
