unit Produto.GS1CNP.Shared.Types;

interface

type
  //Types from parameter
  TCompany = record
    cad: string;
  end;

  TTradeItemDescriptionInformation = record
    tradeItemDescription: string;
  end;

  TGs1TradeItemIdentificationKey = record
    gs1TradeItemIdentificationKeyCode: string;
    gtin: string;
  end;

  TAdditionalTradeItemClassifications = record
    systemCode: string;
    codeValue: string;
  End;

  TArrayAdditionalTradeItemClassifications = array of TAdditionalTradeItemClassifications;

  TTradeItemClassification = record
    gpcCategoryCode: string;
    additionalTradeItemClassifications: TArrayAdditionalTradeItemClassifications;
  end;

  TBrandNameInformation = record
    brandName: string;
  end;

  TChildTradeItems = record
    gtin: string;
    quantityOfNextLowerLevelTradeItem: integer;
  End;

  TArrayChildTradeItems = array of TChildTradeItems;

  TVariableTradeItemInformation = record
    isTradeItemAVariableUnit: Boolean;
    estimatedWeight: double;
    variableWeightRangeMinimum: double;
    variableWeightRangeMaximum: double;
    measurementUnitCode: string;
  end;

  TCountrySubdivisionCodes = record
    origemCode: string;
  end;

  TArrayCountrySubdivisionCodes = array of TCountrySubdivisionCodes;

  TCountryOfOrigin = record
    countryCode: string;
    countrySubdivisionCodes: TArrayCountrySubdivisionCodes;
  end;

  TPlaceOfProductActivity = record
    countryOfOrigin: TCountryOfOrigin;
  end;

  TAdditionalTradeItemIdentifications = record
    typeCode: string;
    value: string;
  end;

  TArrayAdditionalTradeItemIdentifications = array of TAdditionalTradeItemIdentifications;

  TReferencedFileInformations = record
    contentDescription: string;
    fileName: string;
    uniformResourceIdentifier: string;
    featuredFile: boolean;
    referencedFileTypeCode: string;
  end;

  TArrayReferencedFileInformations = array of TReferencedFileInformations;

  TTargetMarketCountryCodes = record
    code: string;
  end;

  TArrayTargetMarketCountryCodes = array of TTargetMarketCountryCodes;

  TTargetMarket = record
    targetMarketCountryCodes: TArrayTargetMarketCountryCodes;
  end;

  TTradeItem = record
    tradeItemUnitDescriptorCode: string;
    targetMarket: TTargetMarket;
  end;

  TPackaging = record
    packagingTypeCode: string;
    platformTypeCode: string;
  end;

  TGrossWeight = record
    measurementUnitCode: string;
    value: double;
  end;

  TNetWeight = record
    measurementUnitCode: string;
    value: double;
  end;

  TTradeItemWeight = record
    grossWeight: TGrossWeight;
    netWeight: TNetWeight;
  end;

  TNetContent = record
    measurementUnitCode: string;
    value: double;
  end;

  THeight = record
    measurementUnitCode: string;
    value: double;
  end;

  TWidth = record
    measurementUnitCode: string;
    value: double;
  end;

  TDepth = record
    measurementUnitCode: string;
    value: double;
  end;

  TTradeItemMeasurements = record
    netContent: TNetContent;
    height: THeight;
    width: TWidth;
    depth: TDepth;
  end;

  TTradeItemLifespan = record
    minimumTradeItemLifespanFromTimeOfProduction: integer;
  end;

  TMaximumTemperature = record
    measurementUnitCode: string;
    value: integer;
  end;

  TMinimumTemperature = record
    measurementUnitCode: string;
    value: integer;
  end;

  TTradeItemTemperatureInformation = record
    maximumTemperature: TMaximumTemperature;
    minimumTemperature: TMinimumTemperature;
  end;

  TDangerousSubstanceProperties = record
    isDangerousSubstance: Boolean;
  end;

  TTradeItemStacking = record
    stackingFactor: integer;
  end;

  TTradeItemHierarchy = record
    quantityOfTradeItemsPerPalletLayer: integer;
    quantityOfCompleteLayersContainedInATradeItem: integer;
    quantityOfLayersPerPallet: integer;
    quantityOfTradeItemsContainedInACompleteLayer: integer;
  end;

  TDutyFeeTax = record
    dutyFeeTaxRate: double;
  end;


  TQuantityContained = record
    measurementUnitCode: string;
    value: integer;
  end;

  TNutrientDetails = record
    nutrientTypeCode: string;
    dailyValueIntakePercent: integer;
    quantityContained: TQuantityContained;
  end;

  TArrayNutrientDetails = array of TNutrientDetails;

  TNutrientHeader = record
    dailyValueIntakeReference: string;
    servingSizeDescription: string;
    nutrientDetails: TArrayNutrientDetails;
  end;

  TAllergens = record
    allergenTypeCode: string;
    levelOfContainmentCode: string;
  end;

  TArrayAllergens = array of TAllergens;

  TDeliveryPurchasingInformation = record
    startAvailabilityDateTime: TDatetime;
    orderQuantityMinimum: double;
    orderSizingFactor: string;
    orderQuantityMultiple: double;
  end;

  //Types from return
  TResponseSuccessProduct = record
    gtinStatusCode: string;
    gs1TradeItemIdentificationKey: TGs1TradeItemIdentificationKey;
  end;

  TField = record
    field: string;
  end;

  TFields = record
    field: TField;
  end;

  TArrayFields = array of TFields;

  TResponseSuccessValidations = record
    code: string;
    messageValidations: string;
    fields: TArrayFields;
  end;

  TValidations = record
    code: string;
    messageValidations: string;
    fields: TArrayFields;
  end;

  TArrayValidations = array of TValidations;

  TResponseSuccess = record
    result: string;
    product: TResponseSuccessProduct;
    validations: TArrayValidations;
  end;

  TResponseErrorData = record
    result: string;
    validations: TArrayValidations;
  end;

  TResponseError = record
    statusCode: string;
    error: string;
    messageError: string;
    data: TResponseErrorData;
  end;

// Types from replace produts

  TProduto = record
    campo: string;
    valor: variant;
  end;

  TArrayProduto = array of TProduto;

implementation

end.
