unit Produto.GS1CNP.Interfaces.Cadastro;

interface

uses Data.DB, UniClientDataSet, Produto.GS1CNP.Shared.Types;

type

  IParametrosGS1CNPCadastro = interface
    ['{F41C090A-18BA-4A7E-A14E-8AF710D7B43D}']

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
  end;

  IRetornoGS1CNPCadastro = interface
    ['{752DDA90-063F-422A-A70C-E9FAB314E6C4}']

    function GetResponseCode: string;
    function SetResponseCode(const AValue: string): IRetornoGS1CNPCadastro;

    function GetResponseSuccess: TResponseSuccess;
    function SetResponseSuccess(const AValue: TResponseSuccess): IRetornoGS1CNPCadastro;

    function GetResponseError: TResponseError;
    function SetResponseError(const AValue: TResponseError): IRetornoGS1CNPCadastro;

    function GetJsonResponse: string;
    function SetJsonResponse(const AValue: string): IRetornoGS1CNPCadastro;
  end;

  IProdutoGS1CNPCadastroFactory = interface
    ['{427CCAC5-8761-4CCA-8488-2F3173DF9A01}']

    function Cadastrar(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean;
      const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPCadastro;
  end;


implementation

end.
