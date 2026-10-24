unit ancora.comunicacao;

interface

uses
  System.SysUtils, Dialogs,
  Ancora.Classes.EndPoint,
  Ancora.Classes.Base,
  Cotacao.ApiPrecos.BaseParam;

Type
  TRedeAncora = class(TRedeAncoraBase)
  private
    ParamProfile: TParamProfile;
    ParamnsFullSearch: TParamnsFullSearch;
    procedure pTrataRetornoProfile(AbstractParamApi: TBaseParamApi);
    procedure pTrataRetornoFullSearch(AbstractParamApi: TBaseParamApi);
    procedure pTrataRetornoPrices_stocks(AbstractParamApi: TBaseParamApi);
    function GetApiProfile: TRetApiProfile;
    function GetFullSearch: TRetApiFullSearch;
  public
    constructor Create; override;
    function fGetProfile: Boolean;
    function fRetFullSearch(AParamns: TParamnsFullSearch): Boolean;
    function fRetPrices_stocks(AParamns: TParamPrices_stocks): string;
    property RetApiProfile: TRetApiProfile read GetApiProfile;
    property RetApiFullSearch: TRetApiFullSearch read GetFullSearch;
    property retParamProfile: TParamProfile read   ParamProfile;

End;

implementation

{ TRedeAncora }


constructor TRedeAncora.Create;
begin
  inherited;
  ParamProfile := TParamProfile.Create;
end;

function TRedeAncora.fGetProfile: Boolean;
begin
  fExecute(tracaProfile, ParamProfile, pTrataRetornoProfile);
  Result := ParamProfile.RetornoApi.Sucess;
end;

function TRedeAncora.fRetPrices_stocks(AParamns: TParamPrices_stocks): string;
begin
  fExecute(tracaPricesStocks, AParamns, pTrataRetornoPrices_stocks);

end;

function TRedeAncora.GetApiProfile: TRetApiProfile;
begin
  Result := ParamProfile.RetApiProfile;
end;

function TRedeAncora.GetFullSearch: TRetApiFullSearch;
begin
  Result := ParamnsFullSearch.RetApiFullSearch;
  {}
end;

function TRedeAncora.fRetFullSearch(AParamns: TParamnsFullSearch): Boolean;
begin
  ParamnsFullSearch := AParamns;
  fExecute(tracaFullSearch, ParamnsFullSearch, pTrataRetornoFullSearch);
  Result := ParamnsFullSearch.RetornoApi.StatusCode = 200;
end;

procedure TRedeAncora.pTrataRetornoFullSearch(AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamnsFullSearch(AbstractParamApi).fProcessaRetono;
  End;
end;

procedure TRedeAncora.pTrataRetornoProfile(AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamProfile(AbstractParamApi).fProcessaRetono;
  end;
end;

procedure TRedeAncora.pTrataRetornoPrices_stocks(AbstractParamApi: TBaseParamApi);
begin
  If Assigned(AbstractParamApi) Then
  begin
    AbstractParamApi.RetornoApi.Retorno :=  raRESTResponse.Content;
    TParamPrices_stocks(AbstractParamApi).fProcessaRetono;
  end;

end;




end.

