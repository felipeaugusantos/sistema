unit Produto.GS1CNP.Tipos.Cadastro;

interface

uses Produto.GS1CNP.Interfaces.Cadastro, Produto.GS1CNP.Shared.Types;

type
  TParametrosGS1CNPCadastro = class(TInterfacedObject, IParametrosGS1CNPCadastro)
  strict private
    FCompany: TCompany;
    FGtinStatusCode: string;
    FTradeItemDescriptionInformation: TTradeItemDescriptionInformation;
    FGs1TradeItemIdentificationKey: TGs1TradeItemIdentificationKey;
    FTradeItemClassification: TTradeItemClassification;
    FBrandNameInformation: TBrandNameInformation;
    FAcceptResponsibility: Boolean;
    FShareDataIndicator: Boolean;
    FInDevelopmentWithoutFeaturedImage: Boolean;
    FInDevelopmentWithoutGrossWeight: Boolean;
    FWithoutCest: Boolean;
    FChildTradeItems: TArrayChildTradeItems;
    FIsNonRetailHealthcareTradeItem: Boolean;
    FVariableTradeItemInformation: TVariableTradeItemInformation;
    FPlaceOfProductActivity: TPlaceOfProductActivity;
    FLanguageCode: string;
    FAdditionalTradeItemIdentifications: TArrayAdditionalTradeItemIdentifications;
    FReferencedFileInformations: TArrayReferencedFileInformations;
    FTradeItem: TTradeItem;
    FPackaging: TPackaging;
    FTradeItemWeight: TTradeItemWeight;
    FTradeItemMeasurements: TTradeItemMeasurements;
    FTradeItemLifespan: TTradeItemLifespan;
    FTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
    FDangerousSubstanceProperties: TDangerousSubstanceProperties;
    FTradeItemStacking: TTradeItemStacking;
    FTradeItemHierarchy: TTradeItemHierarchy;
    FDutyFeeTax: TDutyFeeTax;
    FNutrientHeader: TNutrientHeader;
    FAllergens: TArrayAllergens;
    FDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
    FComments: string;
  public
    function GetCompany: TCompany;
    function SetCompany(const AValue: TCompany): IParametrosGS1CNPCadastro;

    function GetGtinStatusCode: string;
    function SetGtinStatusCode(const AValue: string): IParametrosGS1CNPCadastro;

    function GetTradeItemDescriptionInformation: TTradeItemDescriptionInformation;
    function SetTradeItemDescriptionInformation(const AValue: TTradeItemDescriptionInformation): IParametrosGS1CNPCadastro;

    function GetGs1TradeItemIdentificationKey: TGs1TradeItemIdentificationKey;
    function SetGs1TradeItemIdentificationKey(const AValue: TGs1TradeItemIdentificationKey): IParametrosGS1CNPCadastro;

    function GetTradeItemClassification: TTradeItemClassification;
    function SetTradeItemClassification(const AValue: TTradeItemClassification): IParametrosGS1CNPCadastro;

    function GetBrandNameInformation: TBrandNameInformation;
    function SetBrandNameInformation(const AValue: TBrandNameInformation): IParametrosGS1CNPCadastro;

    function GetAcceptResponsibility: Boolean;
    function SetAcceptResponsibility(const AValue: Boolean): IParametrosGS1CNPCadastro;

    function GetShareDataIndicator: Boolean;
    function SetShareDataIndicator(const AValue: Boolean): IParametrosGS1CNPCadastro;

    function GetInDevelopmentWithoutFeaturedImage: Boolean;
    function SetInDevelopmentWithoutFeaturedImage(const AValue: Boolean): IParametrosGS1CNPCadastro;

    function GetInDevelopmentWithoutGrossWeight: Boolean;
    function SetInDevelopmentWithoutGrossWeight(const AValue: Boolean): IParametrosGS1CNPCadastro;

    function GetWithoutCest: Boolean;
    function SetWithoutCest(const AValue: Boolean): IParametrosGS1CNPCadastro;

    function GetChildTradeItems: TArrayChildTradeItems;
    function SetChildTradeItems(const AValue: TArrayChildTradeItems): IParametrosGS1CNPCadastro;

    function GetIsNonRetailHealthcareTradeItem: Boolean;
    function SetIsNonRetailHealthcareTradeItem(const AValue: Boolean): IParametrosGS1CNPCadastro;

    function GetVariableTradeItemInformation: TVariableTradeItemInformation;
    function SetVariableTradeItemInformation(const AValue: TVariableTradeItemInformation): IParametrosGS1CNPCadastro;

    function GetPlaceOfProductActivity: TPlaceOfProductActivity;
    function SetPlaceOfProductActivity(AValue: TPlaceOfProductActivity): IParametrosGS1CNPCadastro;

    function GetLanguageCode: string;
    function SetLanguageCode(const AValue: string): IParametrosGS1CNPCadastro;

    function GetAdditionalTradeItemIdentifications: TArrayAdditionalTradeItemIdentifications;
    function SetAdditionalTradeItemIdentifications(const AValue: TArrayAdditionalTradeItemIdentifications): IParametrosGS1CNPCadastro;

    function GetReferencedFileInformations: TArrayReferencedFileInformations;
    function SetReferencedFileInformations(const AValue: TArrayReferencedFileInformations): IParametrosGS1CNPCadastro;

    function GetTradeItem: TTradeItem;
    function SetTradeItem(AValue: TTradeItem): IParametrosGS1CNPCadastro;

    function GetPackaging: TPackaging;
    function SetPackaging(AValue: TPackaging): IParametrosGS1CNPCadastro;

    function GetTradeItemWeight: TTradeItemWeight;
    function SetTradeItemWeight(const AValue: TTradeItemWeight): IParametrosGS1CNPCadastro;

    function GetTradeItemMeasurements: TTradeItemMeasurements;
    function SetTradeItemMeasurements(const AValue: TTradeItemMeasurements): IParametrosGS1CNPCadastro;

    function GetTradeItemLifespan: TTradeItemLifespan;
    function SetTradeItemLifespan(const AValue: TTradeItemLifespan): IParametrosGS1CNPCadastro;

    function GetTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
    function SetTradeItemTemperatureInformation(const AValue: TTradeItemTemperatureInformation): IParametrosGS1CNPCadastro;

    function GetDangerousSubstanceProperties: TDangerousSubstanceProperties;
    function SetDangerousSubstanceProperties(const AValue: TDangerousSubstanceProperties): IParametrosGS1CNPCadastro;

    function GetTradeItemStacking: TTradeItemStacking;
    function SetTradeItemStacking(const AValue: TTradeItemStacking): IParametrosGS1CNPCadastro;

    function GetTradeItemHierarchy: TTradeItemHierarchy;
    function SetTradeItemHierarchy(const AValue: TTradeItemHierarchy): IParametrosGS1CNPCadastro;

    function GetDutyFeeTax: TDutyFeeTax;
    function SetDutyFeeTax(const AValue: TDutyFeeTax): IParametrosGS1CNPCadastro;

    function GetNutrientHeader: TNutrientHeader;
    function SetNutrientHeader(const AValue: TNutrientHeader): IParametrosGS1CNPCadastro;

    function GetAllergens: TArrayAllergens;
    function SetAllergens(const AValue: TArrayAllergens): IParametrosGS1CNPCadastro;

    function GetDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
    function SetDeliveryPurchasingInformation(const AValue: TDeliveryPurchasingInformation): IParametrosGS1CNPCadastro;

    function GetComments: string;
    function SetComments(const AValue: string): IParametrosGS1CNPCadastro;

    class function New(): IParametrosGS1CNPCadastro;
  end;

type
  TRetornoGS1CNPCadastro = class(TInterfacedObject, IRetornoGS1CNPCadastro)
  strict private
    FResponseCode: string;
    FResponseSuccess: TResponseSuccess;
    FResponseError: TResponseError;
    FJsonResponse: string;
  public
    function GetResponseCode: string;
    function SetResponseCode(const AValue: string): IRetornoGS1CNPCadastro;

    function GetResponseSuccess: TResponseSuccess;
    function SetResponseSuccess(const AValue: TResponseSuccess): IRetornoGS1CNPCadastro;

    function GetResponseError: TResponseError;
    function SetResponseError(const AValue: TResponseError): IRetornoGS1CNPCadastro;

    function GetJsonResponse: string;
    function SetJsonResponse(const AValue: string): IRetornoGS1CNPCadastro;

    destructor Destroy; override;

    class function New(): IRetornoGS1CNPCadastro;
  end;

implementation

{ TParametrosGS1CNPCadastro }

function TParametrosGS1CNPCadastro.GetAcceptResponsibility: Boolean;
begin
  Result := FAcceptResponsibility;
end;

function TParametrosGS1CNPCadastro.GetAdditionalTradeItemIdentifications: TArrayAdditionalTradeItemIdentifications;
begin
  Result := FAdditionalTradeItemIdentifications;
end;

function TParametrosGS1CNPCadastro.GetAllergens: TArrayAllergens;
begin
  Result := FAllergens;
end;

function TParametrosGS1CNPCadastro.GetBrandNameInformation: TBrandNameInformation;
begin
  Result := FBrandNameInformation;
end;

function TParametrosGS1CNPCadastro.GetChildTradeItems: TArrayChildTradeItems;
begin
  Result := FChildTradeItems;
end;

function TParametrosGS1CNPCadastro.GetComments: string;
begin
  Result := FComments;
end;

function TParametrosGS1CNPCadastro.GetCompany: TCompany;
begin
  Result := FCompany;
end;

function TParametrosGS1CNPCadastro.GetDangerousSubstanceProperties: TDangerousSubstanceProperties;
begin
  Result := FDangerousSubstanceProperties;
end;

function TParametrosGS1CNPCadastro.GetDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
begin
  Result := FDeliveryPurchasingInformation;
end;

function TParametrosGS1CNPCadastro.GetDutyFeeTax: TDutyFeeTax;
begin
  Result := FDutyFeeTax;
end;

function TParametrosGS1CNPCadastro.GetGs1TradeItemIdentificationKey: TGs1TradeItemIdentificationKey;
begin
  Result := FGs1TradeItemIdentificationKey;
end;

function TParametrosGS1CNPCadastro.GetGtinStatusCode: string;
begin
  Result := FGtinStatusCode;
end;

function TParametrosGS1CNPCadastro.GetInDevelopmentWithoutFeaturedImage: Boolean;
begin
  Result := FInDevelopmentWithoutFeaturedImage;
end;

function TParametrosGS1CNPCadastro.GetInDevelopmentWithoutGrossWeight: Boolean;
begin
  Result := FInDevelopmentWithoutGrossWeight;
end;

function TParametrosGS1CNPCadastro.GetIsNonRetailHealthcareTradeItem: Boolean;
begin
  Result := FIsNonRetailHealthcareTradeItem;
end;

function TParametrosGS1CNPCadastro.GetLanguageCode: string;
begin
  Result := FLanguageCode;
end;

function TParametrosGS1CNPCadastro.GetNutrientHeader: TNutrientHeader;
begin
  Result := FNutrientHeader;
end;

function TParametrosGS1CNPCadastro.GetPackaging: TPackaging;
begin
  Result := FPackaging;
end;

function TParametrosGS1CNPCadastro.GetPlaceOfProductActivity: TPlaceOfProductActivity;
begin
  Result := FPlaceOfProductActivity;
end;

function TParametrosGS1CNPCadastro.GetReferencedFileInformations: TArrayReferencedFileInformations;
begin
  Result := FReferencedFileInformations;
end;

function TParametrosGS1CNPCadastro.GetShareDataIndicator: Boolean;
begin
  Result := FShareDataIndicator;
end;

function TParametrosGS1CNPCadastro.GetTradeItem: TTradeItem;
begin
  Result := FTradeItem;
end;

function TParametrosGS1CNPCadastro.GetTradeItemClassification: TTradeItemClassification;
begin
  Result := FTradeItemClassification;
end;

function TParametrosGS1CNPCadastro.GetTradeItemDescriptionInformation: TTradeItemDescriptionInformation;
begin
  Result := FTradeItemDescriptionInformation;
end;

function TParametrosGS1CNPCadastro.GetTradeItemHierarchy: TTradeItemHierarchy;
begin
  Result := FTradeItemHierarchy;
end;

function TParametrosGS1CNPCadastro.GetTradeItemLifespan: TTradeItemLifespan;
begin
  Result := FTradeItemLifespan;
end;

function TParametrosGS1CNPCadastro.GetTradeItemMeasurements: TTradeItemMeasurements;
begin
  Result := FTradeItemMeasurements;
end;

function TParametrosGS1CNPCadastro.GetTradeItemStacking: TTradeItemStacking;
begin
  Result := FTradeItemStacking;
end;

function TParametrosGS1CNPCadastro.GetTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
begin
  Result := FTradeItemTemperatureInformation;
end;

function TParametrosGS1CNPCadastro.GetTradeItemWeight: TTradeItemWeight;
begin
  Result := FTradeItemWeight;
end;

function TParametrosGS1CNPCadastro.GetVariableTradeItemInformation: TVariableTradeItemInformation;
begin
  Result := FVariableTradeItemInformation;
end;

function TParametrosGS1CNPCadastro.GetWithoutCest: Boolean;
begin
  Result := FWithoutCest;
end;

class function TParametrosGS1CNPCadastro.New: IParametrosGS1CNPCadastro;
begin
  Result := Self.Create;
end;

function TParametrosGS1CNPCadastro.SetAcceptResponsibility(
  const AValue: Boolean): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FAcceptResponsibility := AValue;
end;

function TParametrosGS1CNPCadastro.SetAdditionalTradeItemIdentifications(
  const AValue: TArrayAdditionalTradeItemIdentifications): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FAdditionalTradeItemIdentifications := AValue;
end;

function TParametrosGS1CNPCadastro.SetAllergens(
  const AValue: TArrayAllergens): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FAllergens := AValue;
end;

function TParametrosGS1CNPCadastro.SetBrandNameInformation(
  const AValue: TBrandNameInformation): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FBrandNameInformation := AValue;
end;

function TParametrosGS1CNPCadastro.SetChildTradeItems(
  const AValue: TArrayChildTradeItems): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FChildTradeItems := AValue;
end;

function TParametrosGS1CNPCadastro.SetComments(
  const AValue: string): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FComments := AValue;
end;

function TParametrosGS1CNPCadastro.SetCompany(
  const AValue: TCompany): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FCompany := AValue;
end;

function TParametrosGS1CNPCadastro.SetDangerousSubstanceProperties(
  const AValue: TDangerousSubstanceProperties): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FDangerousSubstanceProperties := AValue;
end;

function TParametrosGS1CNPCadastro.SetDeliveryPurchasingInformation(
  const AValue: TDeliveryPurchasingInformation): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FDeliveryPurchasingInformation := AValue;
end;

function TParametrosGS1CNPCadastro.SetDutyFeeTax(
  const AValue: TDutyFeeTax): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FDutyFeeTax := AValue;
end;

function TParametrosGS1CNPCadastro.SetGs1TradeItemIdentificationKey(
  const AValue: TGs1TradeItemIdentificationKey): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FGs1TradeItemIdentificationKey := AValue;
end;

function TParametrosGS1CNPCadastro.SetGtinStatusCode(
  const AValue: string): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FGtinStatusCode := AValue;
end;

function TParametrosGS1CNPCadastro.SetInDevelopmentWithoutFeaturedImage(
  const AValue: Boolean): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FInDevelopmentWithoutFeaturedImage := AValue;
end;

function TParametrosGS1CNPCadastro.SetInDevelopmentWithoutGrossWeight(
  const AValue: Boolean): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FInDevelopmentWithoutGrossWeight := AValue;
end;

function TParametrosGS1CNPCadastro.SetIsNonRetailHealthcareTradeItem(
  const AValue: Boolean): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FIsNonRetailHealthcareTradeItem := AValue;
end;

function TParametrosGS1CNPCadastro.SetLanguageCode(
  const AValue: string): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FLanguageCode := AValue;
end;

function TParametrosGS1CNPCadastro.SetNutrientHeader(
  const AValue: TNutrientHeader): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FNutrientHeader := AValue;
end;

function TParametrosGS1CNPCadastro.SetPackaging(
  AValue: TPackaging): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FPackaging := AValue;
end;

function TParametrosGS1CNPCadastro.SetPlaceOfProductActivity(
  AValue: TPlaceOfProductActivity): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FPlaceOfProductActivity := AValue;
end;

function TParametrosGS1CNPCadastro.SetReferencedFileInformations(
  const AValue: TArrayReferencedFileInformations): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FReferencedFileInformations := AValue;
end;

function TParametrosGS1CNPCadastro.SetShareDataIndicator(
  const AValue: Boolean): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FShareDataIndicator := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItem(
  AValue: TTradeItem): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItem := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemClassification(
  const AValue: TTradeItemClassification): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemClassification := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemDescriptionInformation(
  const AValue: TTradeItemDescriptionInformation): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemDescriptionInformation := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemHierarchy(
  const AValue: TTradeItemHierarchy): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemHierarchy := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemLifespan(
  const AValue: TTradeItemLifespan): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemLifespan := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemMeasurements(
  const AValue: TTradeItemMeasurements): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemMeasurements := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemStacking(
  const AValue: TTradeItemStacking): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemStacking := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemTemperatureInformation(
  const AValue: TTradeItemTemperatureInformation): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemTemperatureInformation := AValue;
end;

function TParametrosGS1CNPCadastro.SetTradeItemWeight(
  const AValue: TTradeItemWeight): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FTradeItemWeight := AValue;
end;

function TParametrosGS1CNPCadastro.SetVariableTradeItemInformation(
  const AValue: TVariableTradeItemInformation): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FVariableTradeItemInformation := AValue;
end;

function TParametrosGS1CNPCadastro.SetWithoutCest(
  const AValue: Boolean): IParametrosGS1CNPCadastro;
begin
  Result := Self;
  FWithoutCest := AValue;
end;

{ TRetornoGS1CNPCadastro }

destructor TRetornoGS1CNPCadastro.Destroy;
begin

  inherited;
end;

function TRetornoGS1CNPCadastro.GetJsonResponse: string;
begin
  Result := FJsonResponse;
end;

function TRetornoGS1CNPCadastro.GetResponseCode: string;
begin
  Result := FResponseCode;
end;

function TRetornoGS1CNPCadastro.GetResponseError: TResponseError;
begin
  Result := FResponseError;
end;

function TRetornoGS1CNPCadastro.GetResponseSuccess: TResponseSuccess;
begin
  Result := FResponseSuccess;
end;

class function TRetornoGS1CNPCadastro.New: IRetornoGS1CNPCadastro;
begin
  Result := Self.Create;
end;

function TRetornoGS1CNPCadastro.SetJsonResponse(
  const AValue: string): IRetornoGS1CNPCadastro;
begin
  Result := Self;
  FJsonResponse := AValue;
end;

function TRetornoGS1CNPCadastro.SetResponseCode(
  const AValue: string): IRetornoGS1CNPCadastro;
begin
  Result := Self;
  FResponseCode := AValue;
end;

function TRetornoGS1CNPCadastro.SetResponseError(
  const AValue: TResponseError): IRetornoGS1CNPCadastro;
begin
  Result := Self;
  FResponseError := AValue;
end;

function TRetornoGS1CNPCadastro.SetResponseSuccess(const AValue: TResponseSuccess): IRetornoGS1CNPCadastro;
begin
  Result := Self;
  FResponseSuccess := AValue;
end;

end.
