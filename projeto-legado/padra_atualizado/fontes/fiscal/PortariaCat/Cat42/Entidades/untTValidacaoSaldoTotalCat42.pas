unit untTValidacaoSaldoTotalCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTEstoqueCat42,
     untTRegistroCat,
     SysUtils;

type
  TValidacaoSaldoTotalCat42 = class
  private
    FListaSaldoEstoque: TObjectList<TEstoqueCat42>;
    FAbertura: TDadosAberturaExportacaoCat42;
    FSaldoFinal: double;
    FQtdFinal: double;
    FCampo23: double;
  public
    function fRetCampo15(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo16(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo17(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo18(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo19(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;

    procedure pCalculaSaldoDevolucaoEntrada(estoque: TEstoqueCat42; registroCat: TRegistroCat);
    procedure pCalculaSaldoDevolucaoSaida(estoque: TEstoqueCat42; registroCat: TRegistroCat);
    procedure pCalculaSaldoEntradas(estoque: TEstoqueCat42; registroCat: TRegistroCat);
    procedure pCalculaSaldoSaidas(estoque: TEstoqueCat42; registroCat: TRegistroCat);

    //valida e altera para false a propriedade FEnviaMovimentacao dos estoques cujo o saldo final totaliza negativo/positivo/sem validação
    procedure pValidarSaldoTotal; virtual; abstract;

    constructor create(listaSaldoEstoque: TObjectList<TEstoqueCat42>; abertura: TDadosAberturaExportacaoCat42);

    property listaSaldoEstoque: TObjectList<TEstoqueCat42> read FListaSaldoEstoque;
    property abertura: TDadosAberturaExportacaoCat42 read FAbertura;
    property fltSaldoFinal: double read FSaldoFinal write FSaldoFinal;
    property fltQtdFinal: double read FQtdFinal write FQtdFinal;
    property fltCampo23: double read FCampo23 write FCampo23;
  end;

implementation

uses untFuncoes, Forms;

{ TValidacaoSaldoTotalNegativoCat42 }

constructor TValidacaoSaldoTotalCat42.create(listaSaldoEstoque: TObjectList<TEstoqueCat42>;
  abertura: TDadosAberturaExportacaoCat42);
begin
  inherited create;

  FListaSaldoEstoque := listaSaldoEstoque;
  FAbertura := abertura;
end;

function TValidacaoSaldoTotalCat42.fRetCampo15(strEnquadramento: string;
  fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "1", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '1' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TValidacaoSaldoTotalCat42.fRetCampo16(strEnquadramento: string;
  fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "2", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '2' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TValidacaoSaldoTotalCat42.fRetCampo17(strEnquadramento: string;
  fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "3", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '3' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TValidacaoSaldoTotalCat42.fRetCampo18(strEnquadramento: string;
  fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "4", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '4' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TValidacaoSaldoTotalCat42.fRetCampo19(strEnquadramento: string;
  fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "1", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '0' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

procedure TValidacaoSaldoTotalCat42.pCalculaSaldoDevolucaoEntrada(estoque: TEstoqueCat42; registroCat: TRegistroCat);
begin
  //caso não tenha sido feito compras no nês, o mesmo deve capturar a aliquota pelo estoque
  if FCampo23 = 0 then
    if estoque.fltQtdFinal <> 0 then
      FCampo23 := estoque.fltSaldoFinal / estoque.fltQtdFinal
    else
      FCampo23 := 0;

  FQtdFinal := FQtdFinal + registroCat.itemNota.fltQuantidade;
  FSaldoFinal := FSaldoFinal - (registroCat.itemNota.fltQuantidade * FCampo23);
end;

procedure TValidacaoSaldoTotalCat42.pCalculaSaldoDevolucaoSaida(estoque: TEstoqueCat42; registroCat: TRegistroCat);
begin
  if FCampo23 = 0 then
    if estoque.fltQtdFinal <> 0 then
      FCampo23 := estoque.fltSaldoFinal / estoque.fltQtdFinal
    else
      FCampo23 := 0;

  FQtdFinal := FQtdFinal + registroCat.itemNota.fltQuantidade;
  FSaldoFinal := FSaldoFinal + (registroCat.itemNota.fltQuantidade * FCampo23);
end;

procedure TValidacaoSaldoTotalCat42.pCalculaSaldoEntradas(estoque: TEstoqueCat42; registroCat: TRegistroCat);
begin
  FQtdFinal := FQtdFinal + registroCat.itemNota.fltQuantidade;
  FSaldoFinal := FSaldoFinal + registroCat.itemNota.fltValorRetidoNaoCreditado;

  if FQtdFinal <> 0 then
    FCampo23 := FSaldoFinal / FQtdFinal
  else
    FCampo23 := 0;
end;

procedure TValidacaoSaldoTotalCat42.pCalculaSaldoSaidas(estoque: TEstoqueCat42; registroCat: TRegistroCat);
  var
    fltCampo15, fltCampo16, fltCampo17, fltCampo18, fltCampo19: double;
begin
  if FCampo23 = 0 then
    if estoque.fltQtdFinal <> 0 then
      FCampo23 := estoque.fltSaldoFinal / estoque.fltQtdFinal
    else
      FCampo23 := 0;

  fltCampo15 := fRetCampo15(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo16 := fRetCampo16(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo17 := fRetCampo17(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo18 := fRetCampo18(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo19 := fRetCampo19(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);

  FQtdFinal := FQtdFinal - registroCat.itemNota.fltQuantidade;
  FSaldoFinal := fTrunca(FSaldoFinal - fltCampo15 - fltCampo16 - fltCampo17 - fltCampo18 - fltCampo19, 8);
end;



end.
