unit Produto.GS1CNP.Tipos.Atualiza;

interface

uses Produto.GS1CNP.Interfaces.Atualiza, Produto.GS1CNP.Shared.Types;

type
  TParametrosGS1CNPAtualiza = class(TInterfacedObject, IParametrosGS1CNPAtualiza)
  strict private
    FGtin: String;
    FGtinStatusCode: string;
    FTradeItemClassification: TTradeItemClassification;
    FBrandNameInformation: TBrandNameInformation;
    FAcceptResponsibility: Boolean;
    FShareDataIndicator: Boolean;
    FInDevelopmentWithoutFeaturedImage: Boolean;
    FInDevelopmentWithoutGrossWeight: Boolean;
    FWithoutCest: Boolean;
    FVariableTradeItemInformation: TVariableTradeItemInformation;
    FPlaceOfProductActivity: TPlaceOfProductActivity;
    FReferencedFileInformations: TArrayReferencedFileInformations;
    FTradeItem: TTradeItem;
    FPackaging: TPackaging;
    FTradeItemWeight: TTradeItemWeight;
    FTradeItemMeasurements: TTradeItemMeasurements;
    FTradeItemLifespan: TTradeItemLifespan;
    FTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
    FDangerousSubstanceProperties: TDangerousSubstanceProperties;
    FTradeItemStacking: TTradeItemStacking;
    FDutyFeeTax: TDutyFeeTax;
    FNutrientHeader: TNutrientHeader;
    FAllergens: TArrayAllergens;
    FDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
    FComments: string;
  public
    function GetGtin: string;
    function SetGtin(const AValue: string): IParametrosGS1CNPAtualiza;

    function GetGtinStatusCode: string;
    function SetGtinStatusCode(const AValue: string): IParametrosGS1CNPAtualiza;

    function GetTradeItemClassification: TTradeItemClassification;
    function SetTradeItemClassification(const AValue: TTradeItemClassification): IParametrosGS1CNPAtualiza;

    function GetBrandNameInformation: TBrandNameInformation;
    function SetBrandNameInformation(const AValue: TBrandNameInformation): IParametrosGS1CNPAtualiza;

    function GetAcceptResponsibility: Boolean;
    function SetAcceptResponsibility(const AValue: Boolean): IParametrosGS1CNPAtualiza;

    function GetShareDataIndicator: Boolean;
    function SetShareDataIndicator(const AValue: Boolean): IParametrosGS1CNPAtualiza;

    function GetInDevelopmentWithoutFeaturedImage: Boolean;
    function SetInDevelopmentWithoutFeaturedImage(const AValue: Boolean): IParametrosGS1CNPAtualiza;

    function GetInDevelopmentWithoutGrossWeight: Boolean;
    function SetInDevelopmentWithoutGrossWeight(const AValue: Boolean): IParametrosGS1CNPAtualiza;

    function GetWithoutCest: Boolean;
    function SetWithoutCest(const AValue: Boolean): IParametrosGS1CNPAtualiza;

    function GetVariableTradeItemInformation: TVariableTradeItemInformation;
    function SetVariableTradeItemInformation(const AValue: TVariableTradeItemInformation): IParametrosGS1CNPAtualiza;

    function GetPlaceOfProductActivity: TPlaceOfProductActivity;
    function SetPlaceOfProductActivity(AValue: TPlaceOfProductActivity): IParametrosGS1CNPAtualiza;

    function GetReferencedFileInformations: TArrayReferencedFileInformations;
    function SetReferencedFileInformations(const AValue: TArrayReferencedFileInformations): IParametrosGS1CNPAtualiza;

    function GetTradeItem: TTradeItem;
    function SetTradeItem(AValue: TTradeItem): IParametrosGS1CNPAtualiza;

    function GetPackaging: TPackaging;
    function SetPackaging(AValue: TPackaging): IParametrosGS1CNPAtualiza;

    function GetTradeItemWeight: TTradeItemWeight;
    function SetTradeItemWeight(const AValue: TTradeItemWeight): IParametrosGS1CNPAtualiza;

    function GetTradeItemMeasurements: TTradeItemMeasurements;
    function SetTradeItemMeasurements(const AValue: TTradeItemMeasurements): IParametrosGS1CNPAtualiza;

    function GetTradeItemLifespan: TTradeItemLifespan;
    function SetTradeItemLifespan(const AValue: TTradeItemLifespan): IParametrosGS1CNPAtualiza;

    function GetTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
    function SetTradeItemTemperatureInformation(const AValue: TTradeItemTemperatureInformation): IParametrosGS1CNPAtualiza;

    function GetDangerousSubstanceProperties: TDangerousSubstanceProperties;
    function SetDangerousSubstanceProperties(const AValue: TDangerousSubstanceProperties): IParametrosGS1CNPAtualiza;

    function GetTradeItemStacking: TTradeItemStacking;
    function SetTradeItemStacking(const AValue: TTradeItemStacking): IParametrosGS1CNPAtualiza;

    function GetDutyFeeTax: TDutyFeeTax;
    function SetDutyFeeTax(const AValue: TDutyFeeTax): IParametrosGS1CNPAtualiza;

    function GetNutrientHeader: TNutrientHeader;
    function SetNutrientHeader(const AValue: TNutrientHeader): IParametrosGS1CNPAtualiza;

    function GetAllergens: TArrayAllergens;
    function SetAllergens(const AValue: TArrayAllergens): IParametrosGS1CNPAtualiza;

    function GetDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
    function SetDeliveryPurchasingInformation(const AValue: TDeliveryPurchasingInformation): IParametrosGS1CNPAtualiza;

    function GetComments: string;
    function SetComments(const AValue: string): IParametrosGS1CNPAtualiza;

    class function New(): IParametrosGS1CNPAtualiza;
  end;

type
  TRetornoGS1CNPAtualiza = class(TInterfacedObject, IRetornoGS1CNPAtualiza)
  private
    FResponseCode: string;
    FResponseSuccess: TResponseSuccess;
    FResponseError: TResponseError;
    FJsonResponse: String;
  public
    function GetResponseCode: string;
    function SetResponseCode(const AValue: string): IRetornoGS1CNPAtualiza;

    function GetResponseSuccess: TResponseSuccess;
    function SetResponseSuccess(const AValue: TResponseSuccess): IRetornoGS1CNPAtualiza;

    function GetResponseError: TResponseError;
    function SetResponseError(const AValue: TResponseError): IRetornoGS1CNPAtualiza;

    function GetJsonResponse: string;
    function SetJsonResponse(const AValue: string): IRetornoGS1CNPAtualiza;

    class function New(): IRetornoGS1CNPAtualiza;
  end;

implementation

function TParametrosGS1CNPAtualiza.GetAcceptResponsibility: Boolean;
begin
  Result := FAcceptResponsibility;
end;

function TParametrosGS1CNPAtualiza.GetAllergens: TArrayAllergens;
begin
  Result := FAllergens;
end;

function TParametrosGS1CNPAtualiza.GetBrandNameInformation: TBrandNameInformation;
begin
  Result := FBrandNameInformation;
end;

function TParametrosGS1CNPAtualiza.GetComments: string;
begin
  Result := FComments;
end;

function TParametrosGS1CNPAtualiza.GetDangerousSubstanceProperties: TDangerousSubstanceProperties;
begin
  Result := FDangerousSubstanceProperties;
end;

function TParametrosGS1CNPAtualiza.GetDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
begin
  Result := FDeliveryPurchasingInformation;
end;

function TParametrosGS1CNPAtualiza.GetDutyFeeTax: TDutyFeeTax;
begin
  Result := FDutyFeeTax;
end;

function TParametrosGS1CNPAtualiza.GetGtin: string;
begin
  Result := FGtin;
end;

function TParametrosGS1CNPAtualiza.GetGtinStatusCode: string;
begin
  Result := FGtinStatusCode;
end;

function TParametrosGS1CNPAtualiza.GetInDevelopmentWithoutFeaturedImage: Boolean;
begin
  Result := FInDevelopmentWithoutFeaturedImage;
end;

function TParametrosGS1CNPAtualiza.GetInDevelopmentWithoutGrossWeight: Boolean;
begin
  Result := FInDevelopmentWithoutGrossWeight;
end;

function TParametrosGS1CNPAtualiza.GetNutrientHeader: TNutrientHeader;
begin
  Result := FNutrientHeader;
end;

function TParametrosGS1CNPAtualiza.GetPackaging: TPackaging;
begin
  Result := FPackaging;
end;

function TParametrosGS1CNPAtualiza.GetPlaceOfProductActivity: TPlaceOfProductActivity;
begin
  Result := FPlaceOfProductActivity;
end;

function TParametrosGS1CNPAtualiza.GetReferencedFileInformations: TArrayReferencedFileInformations;
begin
  Result := FReferencedFileInformations;
end;

function TParametrosGS1CNPAtualiza.GetShareDataIndicator: Boolean;
begin
  Result := FShareDataIndicator;
end;

function TParametrosGS1CNPAtualiza.GetTradeItem: TTradeItem;
begin
  Result := FTradeItem;
end;

function TParametrosGS1CNPAtualiza.GetTradeItemClassification: TTradeItemClassification;
begin
  Result := FTradeItemClassification;
end;

function TParametrosGS1CNPAtualiza.GetTradeItemLifespan: TTradeItemLifespan;
begin
  Result := FTradeItemLifespan;
end;

function TParametrosGS1CNPAtualiza.GetTradeItemMeasurements: TTradeItemMeasurements;
begin
  Result := FTradeItemMeasurements;
end;

function TParametrosGS1CNPAtualiza.GetTradeItemStacking: TTradeItemStacking;
begin
  Result := FTradeItemStacking;
end;

function TParametrosGS1CNPAtualiza.GetTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
begin
  Result := FTradeItemTemperatureInformation;
end;

function TParametrosGS1CNPAtualiza.GetTradeItemWeight: TTradeItemWeight;
begin
  Result := FTradeItemWeight;
end;

function TParametrosGS1CNPAtualiza.GetVariableTradeItemInformation: TVariableTradeItemInformation;
begin
  Result := FVariableTradeItemInformation;
end;

function TParametrosGS1CNPAtualiza.GetWithoutCest: Boolean;
begin
  Result := FWithoutCest;
end;

class function TParametrosGS1CNPAtualiza.New: IParametrosGS1CNPAtualiza;
begin
  Result := Self.Create;
end;

function TParametrosGS1CNPAtualiza.SetAcceptResponsibility(
  const AValue: Boolean): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FAcceptResponsibility := AValue;
end;

function TParametrosGS1CNPAtualiza.SetAllergens(
  const AValue: TArrayAllergens): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FAllergens := AValue;
end;

function TParametrosGS1CNPAtualiza.SetBrandNameInformation(
  const AValue: TBrandNameInformation): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FBrandNameInformation := AValue;
end;

function TParametrosGS1CNPAtualiza.SetComments(
  const AValue: string): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FComments := AValue;
end;

function TParametrosGS1CNPAtualiza.SetDangerousSubstanceProperties(
  const AValue: TDangerousSubstanceProperties): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FDangerousSubstanceProperties := AValue;
end;

function TParametrosGS1CNPAtualiza.SetDeliveryPurchasingInformation(
  const AValue: TDeliveryPurchasingInformation): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FDeliveryPurchasingInformation := AValue;
end;

function TParametrosGS1CNPAtualiza.SetDutyFeeTax(
  const AValue: TDutyFeeTax): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FDutyFeeTax := AValue;
end;

function TParametrosGS1CNPAtualiza.SetGtin(
  const AValue: string): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FGtin := AValue;
end;

function TParametrosGS1CNPAtualiza.SetGtinStatusCode(
  const AValue: string): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FGtinStatusCode := AValue;
end;

function TParametrosGS1CNPAtualiza.SetInDevelopmentWithoutFeaturedImage(
  const AValue: Boolean): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FInDevelopmentWithoutFeaturedImage := AValue;
end;

function TParametrosGS1CNPAtualiza.SetInDevelopmentWithoutGrossWeight(
  const AValue: Boolean): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FInDevelopmentWithoutGrossWeight := AValue;
end;

function TParametrosGS1CNPAtualiza.SetNutrientHeader(
  const AValue: TNutrientHeader): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FNutrientHeader := AValue;
end;

function TParametrosGS1CNPAtualiza.SetPackaging(
  AValue: TPackaging): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FPackaging := AValue;
end;

function TParametrosGS1CNPAtualiza.SetPlaceOfProductActivity(
  AValue: TPlaceOfProductActivity): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FPlaceOfProductActivity := AValue;
end;

function TParametrosGS1CNPAtualiza.SetReferencedFileInformations(
  const AValue: TArrayReferencedFileInformations): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FReferencedFileInformations := AValue;
end;

function TParametrosGS1CNPAtualiza.SetShareDataIndicator(
  const AValue: Boolean): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FShareDataIndicator := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItem(
  AValue: TTradeItem): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItem := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItemClassification(
  const AValue: TTradeItemClassification): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItemClassification := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItemLifespan(
  const AValue: TTradeItemLifespan): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItemLifespan := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItemMeasurements(
  const AValue: TTradeItemMeasurements): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItemMeasurements := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItemStacking(
  const AValue: TTradeItemStacking): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItemStacking := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItemTemperatureInformation(
  const AValue: TTradeItemTemperatureInformation): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItemTemperatureInformation := AValue;
end;

function TParametrosGS1CNPAtualiza.SetTradeItemWeight(
  const AValue: TTradeItemWeight): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FTradeItemWeight := AValue;
end;

function TParametrosGS1CNPAtualiza.SetVariableTradeItemInformation(
  const AValue: TVariableTradeItemInformation): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FVariableTradeItemInformation := AValue;
end;

function TParametrosGS1CNPAtualiza.SetWithoutCest(
  const AValue: Boolean): IParametrosGS1CNPAtualiza;
begin
  Result := Self;
  FWithoutCest := AValue;
end;

{ TRetornoGS1CNPAtualiza }

function TRetornoGS1CNPAtualiza.GetJsonResponse: string;
begin
  Result := FJsonResponse;
end;

function TRetornoGS1CNPAtualiza.GetResponseCode: string;
begin
  Result := FResponseCode;
end;

function TRetornoGS1CNPAtualiza.GetResponseError: TResponseError;
begin
  Result := FResponseError;
end;

function TRetornoGS1CNPAtualiza.GetResponseSuccess: TResponseSuccess;
begin
  Result := FResponseSuccess;
end;

class function TRetornoGS1CNPAtualiza.New: IRetornoGS1CNPAtualiza;
begin
  Result := Self.Create;
end;

function TRetornoGS1CNPAtualiza.SetJsonResponse(
  const AValue: string): IRetornoGS1CNPAtualiza;
begin
  Result := Self;
  FJsonResponse := AValue;
end;

function TRetornoGS1CNPAtualiza.SetResponseCode(
  const AValue: string): IRetornoGS1CNPAtualiza;
begin
  Result := Self;
  FResponseCode := AValue;
end;

function TRetornoGS1CNPAtualiza.SetResponseError(
  const AValue: TResponseError): IRetornoGS1CNPAtualiza;
begin
  Result := Self;
  FResponseError := AValue;
end;

function TRetornoGS1CNPAtualiza.SetResponseSuccess(
  const AValue: TResponseSuccess): IRetornoGS1CNPAtualiza;
begin
  Result := Self;
  FResponseSuccess := AValue;
end;

end.
