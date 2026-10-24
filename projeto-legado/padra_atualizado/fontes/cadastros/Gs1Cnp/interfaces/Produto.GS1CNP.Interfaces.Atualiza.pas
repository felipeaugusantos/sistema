unit Produto.GS1CNP.Interfaces.Atualiza;

interface

uses Data.DB, Produto.GS1CNP.Shared.Types;

type
  IParametrosGS1CNPAtualiza = interface
    ['{FA40A651-B01F-4AB9-8628-9C1D4564E50F}']

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
  end;

  IRetornoGS1CNPAtualiza = interface
    ['{3A159A5A-3030-4033-B79E-0ED07EBF6335}']

    function GetResponseCode: string;
    function SetResponseCode(const AValue: string): IRetornoGS1CNPAtualiza;

    function GetResponseSuccess: TResponseSuccess;
    function SetResponseSuccess(const AValue: TResponseSuccess): IRetornoGS1CNPAtualiza;

    function GetResponseError: TResponseError;
    function SetResponseError(const AValue: TResponseError): IRetornoGS1CNPAtualiza;

    function GetJsonResponse: string;
    function SetJsonResponse(const AValue: string): IRetornoGS1CNPAtualiza;
  end;

  IProdutoGS1CNPAtualizaFactory = interface
    ['{427CCAC5-8761-4CCA-8488-2F3173DF9A01}']

    function Atualizar(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean;
      const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPAtualiza;
  end;

implementation

end.
