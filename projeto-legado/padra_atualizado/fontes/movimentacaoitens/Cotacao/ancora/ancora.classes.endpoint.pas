unit Ancora.Classes.EndPoint;

interface


uses classes, REST.Types, REST.Json, System.JSON,  System.IOUtils, System.StrUtils, System.SysUtils,
Cotacao.ApiPrecos.BaseParam, Generics.Collections, untFuncoesSimples;

type



  TWareHouse = Record
    cgc: string;
    empresa: integer;
  End;

  TWareHouses = array of TWareHouse;

  TRetApiProfile = record
    Warehouses: TWareHouses;
    WareHousePreferencial: integer;
    function TemWarehouses: Boolean;
    function LocateWarehouse(ACgc: String): integer;
    function fLocateWareHousePreferencia: TWareHouse;
  End;

  TParamProfile = class(TBaseParamApi)
    RetApiProfile: TRetApiProfile;
    function fProcessaRetono: String; override;
  end;


  TRetApiFullSearch = record
    fltPreco: Double;
    fltST   : Double;
    fltEstoque: Double;
    fltPrecoComSt: Double;
    nome: String;
    codFabrica: String;
    Retorno: String;
    marca: string;
  End;

  TFieldsFullSearch = set of (prices,stocks,details);

  TParamnsFullSearch = class(TBaseParamApi)
   protected
     procedure pIniciaValores; override;
     function fMontaFileds: String;
   public
     page: integer;
     page_size: integer;
     brand: string;
     code: string;
     cna: string;
     gtin: string;
     cest: integer;
     origem: String;
     name: string;
     line: integer;
     family: integer;
     empresa: integer;
     fields: TFieldsFullSearch;
     RetApiFullSearch: TRetApiFullSearch;
     constructor create;
     function fProcessaRetono: String; override;
     function fMontaParam: string;
     procedure pReinciaCampos;
  End;


  TTipoCodigoConsulta = (tccEan, tccCNA);

  TProdutoCNAouEan = Record
    TipoCodigoConsulta: TTipoCodigoConsulta;
    CodigoItem: String;
    CodigoFabrica: String;
    CodigoBarras: String;
    CodigoCNA: String;
  end;

  TParamPrices_stocks = class(TBaseParamApi)
  private
    ProdutosDictionary: TDictionary<String, TProdutoCNAouEan>;
    RetornosDictionary: TDictionary<String, TRetApiFullSearch>;
    procedure ProcessaListaRetorno;

  protected
    function getJsonEnvion: String; override;
    procedure pIniciaValores; override;
  public
    empresa: integer;
    function fProcessaRetono: String; override;
    property JsonEnvioBody: String read getJsonEnvion;
    procedure pAddItemConsulta(ATipoCodigoConsulta: TTipoCodigoConsulta; ACodigoItem, ACodigoBusca, ACodFabrica, ACodigoBarras, ACodigoCNA: String);
  End;

implementation


{ TParamnsFullSearch }

constructor TParamnsFullSearch.create;
begin
  inherited
end;

function TParamnsFullSearch.fMontaFileds: String;
begin
  Result := '';
  If fields = [] Then
    Exit;
  if prices in fields Then
    Result := 'prices,';
  if stocks in fields Then
    Result := Result + 'stocks,';
  if details in fields Then
    Result := Result + 'details';

  If Result[Length(Result) -1] = ',' then
    Result.Remove(Length(Result));
end;

function TParamnsFullSearch.fMontaParam: string;
begin
  Result := '';

  If page > -1 Then
    Result :=  Result + IIf(Result = '', '', '&') + 'page_size=' + page_size.ToString;

  If brand <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'brand=' + brand;

  If code <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'code=' + code;

  If cna <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'cna=' + cna;

  If gtin <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'gtin=' + gtin;

  If cest > -1 Then
    Result :=  Result + IIf(Result = '', '', '&') + 'cest=' + cest.ToString;

  If origem <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'origem=' + origem;

  If name <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'name=' + name;

  If line > -1 Then
    Result :=  Result + IIf(Result = '', '', '&') + 'line=' + line.ToString;

  If family > -1 Then
    Result :=  Result + IIf(Result = '', '', '&') + 'family=' + family.ToString;

  If empresa > -1 Then
    Result :=  Result + IIf(Result = '', '', '&') + 'empresa=' + empresa.ToString;

  If fMontaFileds <> '' Then
    Result :=  Result + IIf(Result = '', '', '&') + 'fields=' + fMontaFileds;

end;

function TParamnsFullSearch.fProcessaRetono: String;
var JsonRetKeyValue :TJsonRetKeyValue;
begin
  inherited;
  RetApiFullSearch.fltPreco := 0;
  RetApiFullSearch.fltST := 0;
  RetApiFullSearch.fltEstoque := 0;
  RetApiFullSearch.nome := '';
  RetApiFullSearch.codFabrica := '';
  RetApiFullSearch.marca := '';

  RetornoApi.Sucess := True;
  RetornoApi.Falha := '';
  If High(FArrJsonRetKeyValue)> 0 Then
  begin
    If FArrJsonRetKeyValue[0].Key = 'message' Then
    begin
      RetornoApi.Falha := FArrJsonRetKeyValue[0].Value;
      RetornoApi.Sucess := False;
    End;
  End;

  If not RetornoApi.Sucess Then
    Exit;

  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Key = 'success' Then
      RetornoApi.Sucess := JsonRetKeyValue.Value = 'true';
    If Not RetornoApi.Sucess then
      If JsonRetKeyValue.Key = 'message' Then
        RetornoApi.Falha := JsonRetKeyValue.Value;

    If RetornoApi.Falha <> '' then
      break;
  End;

  If Not RetornoApi.Sucess Then
    Exit;

  For JsonRetKeyValue in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Key = 'data.prices.preco_vigente' Then
      RetApiFullSearch.fltPreco := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);
    If JsonRetKeyValue.Key = 'data.prices.st_vigente' Then
      RetApiFullSearch.fltST := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);
    If JsonRetKeyValue.Key = 'data.stocks.qtd_disponivel' Then
      RetApiFullSearch.fltEstoque := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);
    If JsonRetKeyValue.Key = 'data.prices.preco_normal_valido_com_st' Then
      RetApiFullSearch.fltPrecoComSt := StrToFloatDef(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','), 0);


    If JsonRetKeyValue.Key = 'data.nomeProduto' Then
      RetApiFullSearch.nome := JsonRetKeyValue.Value;
    If JsonRetKeyValue.Key = 'data.codigoReferencia' Then
      RetApiFullSearch.codFabrica := JsonRetKeyValue.Value;
    If JsonRetKeyValue.Key = 'data.marca' Then
      RetApiFullSearch.marca := JsonRetKeyValue.Value;
  End;
end;

procedure TParamnsFullSearch.pIniciaValores;
begin
  page := -1;
  page_size := -1;
  brand := '';
  code := '';
  cna := '';
  gtin := '';
  cest := -1;
  origem := '';
  name := '';
  line := -1;
  family := -1;
  empresa := -1;
  fields := [];
end;

procedure TParamnsFullSearch.pReinciaCampos;
begin
  page := -1;
  brand := '';
  code := '';
  cna := '';
  gtin := '';
  cest := -1;
  origem := '';
  name := '';
  line := -1;
  family := -1;

end;

{ TParamProfile }

function TParamProfile.fProcessaRetono: String;
var JsonRetKeyValue :TJsonRetKeyValue;
    PosArray: integer;
begin
  inherited;
  PosArray := -1;

  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  begin
    If rETornoApi.STATUSCODE <> 200 Then
    begin
      If JsonRetKeyValue.Key = 'message' Then
        RetornoApi.Falha := JsonRetKeyValue.Value;
    End

    Else
    Begin

      If JsonRetKeyValue.Key = 'company.warehouse_preferencial' Then
        RetApiProfile.WareHousePreferencial := JsonRetKeyValue.Value.ToInteger;

      If JsonRetKeyValue.Index > -1 Then
      begin
        If JsonRetKeyValue.Key = 'warehouses.cgc' Then
        Begin
          SetLength(RetApiProfile.Warehouses, succ(Length(RetApiProfile.Warehouses)));
          PosArray := High(RetApiProfile.Warehouses);
        end;
      end;

      If PosArray > -1 Then
      begin
        If JsonRetKeyValue.Key = 'warehouses.cgc' Then
          RetApiProfile.Warehouses[JsonRetKeyValue.Index].cgc := JsonRetKeyValue.Value;
        If JsonRetKeyValue.Key = 'warehouses.empresa' Then
          RetApiProfile.Warehouses[JsonRetKeyValue.Index].empresa := JsonRetKeyValue.Value.ToInteger;
      End;
    End;

  End;
end;


{ Prices-stocks }

function TParamPrices_stocks.fProcessaRetono: String;
var JsonRetKeyValue :TJsonRetKeyValue;
begin
  inherited;
  RetornoApi.Sucess := True;
  RetornoApi.Falha := '';
  For JsonRetKeyValue  in FArrJsonRetKeyValue do
  begin
    If JsonRetKeyValue.Key = 'success' Then
      RetornoApi.Sucess := JsonRetKeyValue.Value = 'true';
    If Not RetornoApi.Sucess then
      If JsonRetKeyValue.Key = 'message' Then
        RetornoApi.Falha := JsonRetKeyValue.Value;

    If RetornoApi.Falha <> '' then
      break;
  End;

  If RetornoApi.Sucess Then
  Begin
    ProcessaListaRetorno;
  End;

end;

procedure TParamPrices_stocks.ProcessaListaRetorno;
var Key : string;
    Index : integer;
    JsonRetKeyValue : TJsonRetKeyValue;
    RetFullSearch: TRetApiFullSearch;
begin
  for Key in ProdutosDictionary.Keys do
  begin
    Index := fLocate('data.cna', ProdutosDictionary.Items[Key].CodigoCNA);

    If Index > -1 Then
    begin
      For JsonRetKeyValue  in FArrJsonRetKeyValue do
      begin
        if JsonRetKeyValue.Index = index Then
        Begin
          If JsonRetKeyValue.Key =  'data.prices.preco_vigente' Then
            RetFullSearch.fltPreco := strToFloat(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','));
          If JsonRetKeyValue.Key =  'data.prices.st_vigente' Then
            RetFullSearch.fltST := strToFloat(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','));
          If JsonRetKeyValue.Key =  'data.stocks.qtd_disponivel' Then
            RetFullSearch.fltEstoque := strToFloat(AnsiReplaceStr(JsonRetKeyValue.Value, '.', ','));

        End
      End;
      RetornosDictionary.Add(ProdutosDictionary.Items[Key].CodigoItem, RetFullSearch);
    End;
  End
end;


function TParamPrices_stocks.getJsonEnvion: String;
var Key : string;
    ListaEan: String;
    ListaCNA: String;
    ListaCodFab: String;
    JSON: String;
    jsonEan: String;
    jsonCna: String;
    jsonCodFab: String;

begin

  ListaEan := '';
  ListaCNA := '';
  ListaCodFab := '';
  jsonEan := '';
  jsonCna := '';
  jsonCodFab := '';

  for Key in ProdutosDictionary.Keys do
  Begin
     case ProdutosDictionary.Items[Key].TipoCodigoConsulta of
       tccEan : begin
                  ListaEan := ListaEan + IIf(ListaEan.IsEmpty, '' , ',') + '"' + ProdutosDictionary.Items[Key].CodigoBarras + '"';
//                  ListaCodFab := ListaCodFab + IIf(ListaCodFab.IsEmpty, '' , ',') + '"' + ProdutosDictionary.Items[Key].CodigoFabrica + '"';
                end;
       tccCNA: ListaCNA := ListaCNA + IIf(ListaCNA.IsEmpty, '' , ',') + '"' + ProdutosDictionary.Items[Key].CodigoCNA + '"';
     End;
  End;

  JSON := '{"empresa": ' + empresa.ToString + ',';
  If Not ListaCNA.IsEmpty then
    jsonCna := '"cnas": ['+jsonCna+']';
  If not ListaCodFab.IsEmpty Then
    jsonCodFab := IIf(Not jsonCna.IsEmpty, ',', '') + '"codes": ['+ListaCodFab+']';
  If Not ListaEan.IsEmpty then
    jsonEan := IIf((Not jsonCna.IsEmpty) or (Not jsonCodFab.IsEmpty), ',', '') + '"gtins": ['+ListaEan+']';
  JSON := Json + jsonCna + jsonCodFab + jsonEan + '}';
  Result := Json
end;

procedure TParamPrices_stocks.pAddItemConsulta(
  ATipoCodigoConsulta: TTipoCodigoConsulta; ACodigoItem, ACodigoBusca, ACodFabrica, ACodigoBarras, ACodigoCNA: String);
var ProdutoCNAouEan: TProdutoCNAouEan;
begin
  ProdutoCNAouEan.TipoCodigoConsulta :=  ATipoCodigoConsulta;
  ProdutoCNAouEan.CodigoItem := ACodigoItem;
  ProdutoCNAouEan.CodigoFabrica := ACodFabrica;
  ProdutoCNAouEan.CodigoBarras := ACodigoBarras;
  ProdutoCNAouEan.CodigoCNA := ACodigoCNA;

  ProdutosDictionary.Add(ACodigoBusca, ProdutoCNAouEan);
end;

procedure TParamPrices_stocks.pIniciaValores;
begin
  inherited;
  ProdutosDictionary := TDictionary<string,TProdutoCNAouEan>.Create;
  RetornosDictionary := TDictionary<string,TRetApiFullSearch>.Create;
end;

{ TRetApiProfile }

function TRetApiProfile.fLocateWareHousePreferencia: TWareHouse;
var WareHouse: TWareHouse;
begin
  For WareHouse in  Warehouses do
    If WareHouse.Empresa = WareHousePreferencial then
      Exit(WareHouse)
end;

function TRetApiProfile.LocateWarehouse(ACgc: String): integer;
var WareHouse: TWareHouse;
begin
  Result := -1;
  If ACgc.IsEmpty Then
    Exit;

  for WareHouse in WareHouses do
    If WareHouse.cgc = ACgc Then
      Exit(WareHouse.Empresa);
end;

function TRetApiProfile.TemWarehouses: Boolean;
begin
  Result := Length(Warehouses) > 0;
end;


end.
