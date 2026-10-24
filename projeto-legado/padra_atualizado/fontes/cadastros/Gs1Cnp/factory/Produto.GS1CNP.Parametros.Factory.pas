unit Produto.GS1CNP.Parametros.Factory;

interface

uses Uni, System.SysUtils, Data.DB, Produto.GS1CNP.Interfaces.Parametros,
  Produto.GS1CNP.Interfaces.Cadastro, Produto.GS1CNP.Interfaces.Atualiza,
  Produto.GS1CNP.Shared.Types, untFuncoesSimples, Produto.GS1CNP.Tipos.Cadastro,
  Produto.GS1CNP.Tipos.Atualiza;

type
  TProdutoGS1CNPParametrosFactory = class(TInterfacedObject, IProdutoGS1CNPParametrosFactory)
  private
    FTabIte: TDataSet;
    FGTIN: String;
    FEanTrb: Boolean;
    FStatusGTIN: String;

    function GetCompany: TCompany;
    function GetTradeItemDescriptionInformation: TTradeItemDescriptionInformation;
    function GetGs1TradeItemIdentificationKey: TGs1TradeItemIdentificationKey;
    function GetTradeItemClassification: TTradeItemClassification;
    function GetAdditionalTradeItemClassifications: TArrayAdditionalTradeItemClassifications;
    function GetBrandNameInformation: TBrandNameInformation;
    function GetWithoutCest: Boolean;
    function GetChildTradeItems: TArrayChildTradeItems;
    function GetVariableTradeItemInformation: TVariableTradeItemInformation;
    function GetPlaceOfProductActivity: TPlaceOfProductActivity;
    function GetAdditionalTradeItemIdentifications: TArrayAdditionalTradeItemIdentifications;
    function GetReferencedFileInformations: TArrayReferencedFileInformations;
    function GetTradeItem: TTradeItem;
    function GetPackaging: TPackaging;
    function GetTradeItemWeight: TTradeItemWeight;
    function GetTradeItemMeasurements: TTradeItemMeasurements;
    function GetTradeItemLifespan: TTradeItemLifespan;
    function GetTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
    function GetDangerousSubstanceProperties: TDangerousSubstanceProperties;
    function GetTradeItemStacking: TTradeItemStacking;
    function GetTradeItemHierarchy: TTradeItemHierarchy;
    function GetDutyFeeTax: TDutyFeeTax;
    function GetNutrientHeader: TNutrientHeader;
    function GetAllergens: TArrayAllergens;
    function GetDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
    function RetornaUnidadeMedidaGS1(const ACodUni: String): String;
    function GetGtinStatusCode: String;

    function FormataNcm(const ANcm: String): String;
    function FormataCest(const ACest: String): String;
  public

    function RetornaParametrosCadastro(): IParametrosGS1CNPCadastro;
    function RetornaParametrosAtualiza(): IParametrosGS1CNPAtualiza;

    constructor Create(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean; const AStatusGTIN: String); overload;
    class function New(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean; const AStatusGTIN: String): IProdutoGS1CNPParametrosFactory;
  end;

implementation

{ TProdutoGS1CNPParametrosFactory }

constructor TProdutoGS1CNPParametrosFactory.Create(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean; const AStatusGTIN: String);
begin
  FTabIte := AQryCadIte;
  FGTIN   := AGTIN;
  FEanTrb := AEanTrb;
  FStatusGTIN := AStatusGTIN;
end;

function TProdutoGS1CNPParametrosFactory.GetGs1TradeItemIdentificationKey: TGs1TradeItemIdentificationKey;
begin
  Result.gtin := FGTIN;
  Result.gs1TradeItemIdentificationKeyCode := 'GTIN_13';

  If Not FEanTrb Then
    Exit;

  Result.gs1TradeItemIdentificationKeyCode := 'GTIN_14';
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemClassification: TTradeItemClassification;
begin
  Result.gpcCategoryCode := FTabIte.FieldByName('ITE_CODGPC').AsString;
  Result.additionalTradeItemClassifications := GetAdditionalTradeItemClassifications;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemDescriptionInformation: TTradeItemDescriptionInformation;
begin
  Result.tradeItemDescription := FTabIte.FieldByName('ITE_DESITE').AsString;
end;

function TProdutoGS1CNPParametrosFactory.FormataCest(
  const ACest: String): String;
begin
  Result := '';

  If fEmptyStr(ACest) Then
    Exit;

  Result := Copy(ACest, 1, 2) + '.' + Copy(ACest, 3, 3) + '.' + Copy(ACest, 6, 2);
end;

function TProdutoGS1CNPParametrosFactory.FormataNcm(const ANcm: String): String;
begin
  Result := '';

  If fEmptyStr(ANcm) Then
    Exit;

  Result := Copy(ANcm, 1, 4) + '.' + Copy(ANcm, 5, 2) + '.' + Copy(ANcm, 7, 2);
end;

function TProdutoGS1CNPParametrosFactory.GetAdditionalTradeItemClassifications: TArrayAdditionalTradeItemClassifications;
var
  Arr: TArrayAdditionalTradeItemClassifications;
begin
  SetLength(Arr, 1);

  Arr[Length(Arr) - 1].systemCode := 'NCM';
  Arr[Length(Arr) - 1].codeValue  := FormataNcm(FTabIte.FieldByName('ITE_CLAIPI').AsString);

  If fEmptyStr(FTabIte.FieldByName('ITE_CDCEST').AsString) Then
  Begin
    Result := Arr;
    Exit;
  End;

  SetLength(Arr, 2);
  Arr[Length(Arr) - 1].systemCode := 'CEST';
  Arr[Length(Arr) - 1].codeValue  := FormataCest(FTabIte.FieldByName('ITE_CDCEST').AsString);

  Result := Arr;
end;

function TProdutoGS1CNPParametrosFactory.GetAdditionalTradeItemIdentifications: TArrayAdditionalTradeItemIdentifications;
var
  Arr: TArrayAdditionalTradeItemIdentifications;
begin
  SetLength(Arr, 0);

  Result := Arr;
end;

function TProdutoGS1CNPParametrosFactory.GetAllergens: TArrayAllergens;
var
  Arr: TArrayAllergens;
begin
  SetLength(Arr, 0);
  Result := Arr;
end;

function TProdutoGS1CNPParametrosFactory.GetBrandNameInformation: TBrandNameInformation;
begin
  Result.brandName := fRetNomMarca(FTabIte.FieldByName('ITE_CODMAR').AsString);
end;

function TProdutoGS1CNPParametrosFactory.GetChildTradeItems: TArrayChildTradeItems;
var
  LQryBar: TUniQuery;
  Arr: TArrayChildTradeItems;
begin
  SetLength(Arr, 0);

  LQryBar := fCriaQuery(Nil);
  Try
    LQryBar.Close;
    LQryBar.SQL.Clear;
    LQryBar.SQL.Add('SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = :CODITE AND BAR_CODBAR <> :CODBAR');
    LQryBar.ParamByName('CODITE').AsString := FTabIte.FieldByName('ITE_CODITE').AsString;
    LQryBar.ParamByName('CODBAR').AsString := FGTIN;
    LQryBar.Open;

    SetLength(Arr, LQryBar.RecordCount);

    LQryBar.First;
    while not LQryBar.Eof do
    begin
      Arr[LQryBar.RecNo - 1].gtin := LQryBar.FieldByName('BAR_CODBAR').AsString;
      Arr[LQryBar.RecNo - 1].quantityOfNextLowerLevelTradeItem := LQryBar.RecNo;

      LQryBar.Next;
    end;

    Result := Arr;
  Finally
   FreeAndNil(LQryBar);
  End;
end;

function TProdutoGS1CNPParametrosFactory.GetCompany: TCompany;
begin
  Result.cad := fCfgSis('GCCEMP');
end;

function TProdutoGS1CNPParametrosFactory.GetDangerousSubstanceProperties: TDangerousSubstanceProperties;
begin
  Result.isDangerousSubstance := True;
end;

function TProdutoGS1CNPParametrosFactory.GetDeliveryPurchasingInformation: TDeliveryPurchasingInformation;
begin
  Result.startAvailabilityDateTime := 0;
  If FTabIte.FieldByName('ITE_DTALAN').AsDateTime > 0 Then
    Result.startAvailabilityDateTime := FTabIte.FieldByName('ITE_DTALAN').AsDateTime;

  Result.orderQuantityMinimum := 0;
  Result.orderSizingFactor := '';
  Result.orderQuantityMultiple := 0;
end;

function TProdutoGS1CNPParametrosFactory.GetDutyFeeTax: TDutyFeeTax;
begin
  Result.dutyFeeTaxRate := 0; //FTabIte.FieldByName('ITE_IPISAI').AsString;
end;

function TProdutoGS1CNPParametrosFactory.GetNutrientHeader: TNutrientHeader;
var
  LNutrientDetails: TArrayNutrientDetails;
  Arr: TArrayNutrientDetails;
begin
  SetLength(Arr, 0);

  LNutrientDetails := Arr;

  Result.dailyValueIntakeReference := '';
  Result.servingSizeDescription := '';
  Result.nutrientDetails := LNutrientDetails;
end;

function TProdutoGS1CNPParametrosFactory.GetPackaging: TPackaging;
begin
  Result.packagingTypeCode := '';
  Result.platformTypeCode := '';
end;

function TProdutoGS1CNPParametrosFactory.GetPlaceOfProductActivity: TPlaceOfProductActivity;
var
  LCountryOfOrigin: TCountryOfOrigin;
begin
  LCountryOfOrigin.countryCode := '076';  //brasil
  LCountryOfOrigin.countrySubdivisionCodes := [];

  Result.countryOfOrigin := LCountryOfOrigin;
end;

function TProdutoGS1CNPParametrosFactory.GetReferencedFileInformations: TArrayReferencedFileInformations;
var
  LQryImg: TUniQuery;
  LArr: TArrayReferencedFileInformations;
begin
  LQryImg := fCriaQuery(Nil);
  Try
    LQryImg.Close;
    LQryImg.SQL.Clear;
    LQryImg.SQL.Add('SELECT ITE_IMGURL, ITE_PRINCI FROM ITEIMG WHERE ITE_CODITE = :CODITE ');
    LQryImg.ParamByName('CODITE').AsString := FTabIte.FieldByName('ITE_CODITE').AsString;
    LQryImg.Open;

    SetLength(LArr, 0);

    LQryImg.First;
    While Not LQryImg.Eof Do
    Begin
      If fEmptyStr(LQryImg.FieldByName('ITE_IMGURL').AsString) Then
      Begin
        LQryImg.Next;
        Continue;
      End;

      SetLength(LArr, Length(LArr) + 1);

      LArr[Length(LArr) - 1].contentDescription := 'EMBALAGEM';
      LArr[Length(LArr) - 1].fileName := 'imagem_' + intToStr(LQryImg.RecNo) + '.jpg';
      LArr[Length(LArr) - 1].uniformResourceIdentifier := LQryImg.FieldByName('ITE_IMGURL').AsString;
      LArr[Length(LArr) - 1].featuredFile := IIF(LQryImg.FieldByName('ITE_PRINCI').AsString = 'S', True, False);
      LArr[Length(LArr) - 1].referencedFileTypeCode := 'PRODUCT_IMAGE';

      LQryImg.Next;
    End;

    Result := LArr;
  Finally
    FreeAndNil(LQryImg);
  End;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItem: TTradeItem;
var
  LTargetMarket: TTargetMarket;
  LArr: TArrayTargetMarketCountryCodes;
begin
  SetLength(LArr, 1);
  LArr[Length(LArr) - 1].code := '076'; //Brasil

  LTargetMarket.targetMarketCountryCodes := LArr;

  Result.tradeItemUnitDescriptorCode := '';
  Result.targetMarket := LTargetMarket;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemHierarchy: TTradeItemHierarchy;
begin
  Result.quantityOfTradeItemsPerPalletLayer := 0;
  Result.quantityOfCompleteLayersContainedInATradeItem := 0;
  Result.quantityOfLayersPerPallet := 0;
  Result.quantityOfTradeItemsContainedInACompleteLayer := 0;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemLifespan: TTradeItemLifespan;
begin
  Result.minimumTradeItemLifespanFromTimeOfProduction := FTabIte.FieldByName('ITE_TEMPRO').AsInteger;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemMeasurements: TTradeItemMeasurements;
var
  LNetContent: TNetContent;
begin
  LNetContent.measurementUnitCode := RetornaUnidadeMedidaGS1(FTabIte.FieldByName('ITE_CODUNI').AsString);//'KGM'; //olhar tabela 2
  LNetContent.value := FTabIte.FieldByName('ITE_PESLIQ').AsFloat;

  Result.netContent := LNetContent;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemStacking: TTradeItemStacking;
begin
  Result.stackingFactor := 0;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemTemperatureInformation: TTradeItemTemperatureInformation;
var
  LMaximumTemperature: TMaximumTemperature;
  LMinimumTemperature: TMinimumTemperature;
begin
  LMaximumTemperature.measurementUnitCode := '';
  LMaximumTemperature.value := 0;

  LMinimumTemperature.measurementUnitCode := '';
  LMinimumTemperature.value := 0;

  Result.maximumTemperature := LMaximumTemperature;
  Result.minimumTemperature := LMinimumTemperature;
end;

function TProdutoGS1CNPParametrosFactory.GetTradeItemWeight: TTradeItemWeight;
var
  LGrossWeight: TGrossWeight;
  LNetWeight: TNetWeight;
begin
  LGrossWeight.measurementUnitCode := RetornaUnidadeMedidaGS1(FTabIte.FieldByName('ITE_CODUNI').AsString); //olhar tabela 2
  LGrossWeight.value := FTabIte.FieldByName('ITE_PESOIT').AsFloat;

  LNetWeight.measurementUnitCode := RetornaUnidadeMedidaGS1(FTabIte.FieldByName('ITE_CODUNI').AsString); //olhar tabela 2
  LNetWeight.value := FTabIte.FieldByName('ITE_PESLIQ').AsFloat;;

  Result.grossWeight := LGrossWeight;
  Result.netWeight := LNetWeight;
end;

function TProdutoGS1CNPParametrosFactory.GetVariableTradeItemInformation: TVariableTradeItemInformation;
begin
  Result.isTradeItemAVariableUnit := False;
  Result.estimatedWeight := 0;
  Result.variableWeightRangeMinimum := 0;
  Result.variableWeightRangeMaximum := 0;
  Result.measurementUnitCode := '';
end;

function TProdutoGS1CNPParametrosFactory.GetWithoutCest: Boolean;
begin
  Result := True;

  If fEmptyStr(FTabIte.FieldByName('ITE_CDCEST').AsString) Then
    Exit;

  Result := False;
end;

class function TProdutoGS1CNPParametrosFactory.New(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean; const AStatusGTIN: String): IProdutoGS1CNPParametrosFactory;
begin
  Result := Self.Create(AQryCadIte, AGTIN, AEanTrb, AStatusGTIN);
end;

function TProdutoGS1CNPParametrosFactory.GetGtinStatusCode: String;
begin
  Result := FStatusGTIN; //'ACTIVE';
end;

function TProdutoGS1CNPParametrosFactory.RetornaParametrosAtualiza: IParametrosGS1CNPAtualiza;
begin
  Result :=
    TParametrosGS1CNPAtualiza.New
      .SetGtin(FGtin)
      .SetGtinStatusCode(GetGtinStatusCode)
      .SetTradeItemClassification(GetTradeItemClassification)
      .SetBrandNameInformation(GetBrandNameInformation)
      .SetAcceptResponsibility(True)
      .SetShareDataIndicator(True)
      .SetInDevelopmentWithoutFeaturedImage(False)
      .SetInDevelopmentWithoutGrossWeight(False)
      .SetWithoutCest(GetWithoutCest)
      .SetVariableTradeItemInformation(GetVariableTradeItemInformation)
      .SetPlaceOfProductActivity(GetPlaceOfProductActivity)
      .SetReferencedFileInformations(GetReferencedFileInformations)
      .SetTradeItem(GetTradeItem)
      .SetPackaging(GetPackaging)
      .SetTradeItemWeight(GetTradeItemWeight)
      .SetTradeItemMeasurements(GetTradeItemMeasurements)
      .SetTradeItemLifespan(GetTradeItemLifespan)
      .SetTradeItemTemperatureInformation(GetTradeItemTemperatureInformation)
      .SetDangerousSubstanceProperties(GetDangerousSubstanceProperties)
      .SetTradeItemStacking(GetTradeItemStacking)
      .SetDutyFeeTax(GetDutyFeeTax)
      .SetNutrientHeader(GetNutrientHeader)
      .SetAllergens(GetAllergens)
      .SetDeliveryPurchasingInformation(GetDeliveryPurchasingInformation)
      .SetComments('');
end;

function TProdutoGS1CNPParametrosFactory.RetornaParametrosCadastro: IParametrosGS1CNPCadastro;
begin
  Result :=
    TParametrosGS1CNPCadastro.New
      .SetCompany(GetCompany)
      .SetGtinStatusCode(GetGtinStatusCode)
      .SetTradeItemDescriptionInformation(GetTradeItemDescriptionInformation)
      .SetGs1TradeItemIdentificationKey(GetGs1TradeItemIdentificationKey)
      .SetTradeItemClassification(GetTradeItemClassification)
      .SetBrandNameInformation(GetBrandNameInformation)
      .SetAcceptResponsibility(True)
      .SetShareDataIndicator(True)
      .SetInDevelopmentWithoutFeaturedImage(False)
      .SetInDevelopmentWithoutGrossWeight(False)
      .SetWithoutCest(GetWithoutCest)
      .SetChildTradeItems(GetChildTradeItems)
      .SetIsNonRetailHealthcareTradeItem(False)
      .SetVariableTradeItemInformation(GetVariableTradeItemInformation)
      .SetPlaceOfProductActivity(GetPlaceOfProductActivity)
      .SetLanguageCode('por')
      .SetAdditionalTradeItemIdentifications(GetAdditionalTradeItemIdentifications)
      .SetReferencedFileInformations(GetReferencedFileInformations)
      .SetTradeItem(GetTradeItem)
      .SetPackaging(GetPackaging)
      .SetTradeItemWeight(GetTradeItemWeight)
      .SetTradeItemMeasurements(GetTradeItemMeasurements)
      .SetTradeItemLifespan(GetTradeItemLifespan)
      .SetTradeItemTemperatureInformation(GetTradeItemTemperatureInformation)
      .SetDangerousSubstanceProperties(GetDangerousSubstanceProperties)
      .SetTradeItemStacking(GetTradeItemStacking)
      .SetTradeItemHierarchy(GetTradeItemHierarchy)
      .SetDutyFeeTax(GetDutyFeeTax)
      .SetNutrientHeader(GetNutrientHeader)
      .SetAllergens(GetAllergens)
      .SetDeliveryPurchasingInformation(GetDeliveryPurchasingInformation)
      .SetComments('');
end;

function TProdutoGS1CNPParametrosFactory.RetornaUnidadeMedidaGS1(
  const ACodUni: String): String;
begin
//  Result := fCampoTabela('UNI_CODUNG', 'CADUNI', ['UNI_CODUNI'], [ACodUni], false);
  Result := fRetCodigoUnidadeGS1(ACodUni);
end;

end.
