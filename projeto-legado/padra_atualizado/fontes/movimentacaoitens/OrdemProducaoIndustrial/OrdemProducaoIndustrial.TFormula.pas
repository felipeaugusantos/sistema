unit OrdemProducaoIndustrial.TFormula;

interface

uses
  Classes,
  SysUtils,
  Math,
  System.Generics.Collections,
  OrdemProducaoIndustrial.TProdutoGranel,
  OrdemProducaoIndustrial.TMateriaPrima,
  OrdemProducaoIndustrial.TCor;

Type
  TFormula = class
    private
      FProdutoGranel  : TProdutoGranel;
      FCor            : TCor;
      FMateriasPrimas : TObjectList<TMateriaPrima>;
      FPesoReal       : double;
      FEspecial       : boolean;
    public
      property objProdutoGranel: TProdutoGranel              read FProdutoGranel  write FProdutoGranel;
      property objCor: TCor                                  read FCor            write FCor;
      property lstMateriasPrimas: TObjectList<TMateriaPrima> read FMateriasPrimas write FMateriasPrimas;
      property fltPesoReal: double                           read FPesoReal       write FPesoReal;
      property blnEspecial : boolean                         read FEspecial       write FEspecial;

      constructor Create;
      destructor Destroy; override;

      function fRetornaCustoProducaoTotalKilo(fltPesoTotalProduzido: double): double;
      function fRetornaPrecoMedioProducaoTotalKilo(fltPesoTotalProduzido : double): double;
      procedure clear;
  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;

{ TFormula }

procedure TFormula.clear;
begin
  FPesoReal := 0;
  FEspecial := False;
  FProdutoGranel.Clear;
  FCor.Clear;
  FMateriasPrimas.Clear;
end;

constructor TFormula.Create;
begin
  FProdutoGranel  := TProdutoGranel.Create;
  FCor            := TCor.Create;
  FMateriasPrimas := TObjectList<TMateriaPrima>.Create;
  Clear;
end;

destructor TFormula.Destroy;
begin
  FreeAndNil(FProdutoGranel);
  FreeAndNil(FCor);
  FreeAndNil(FMateriasPrimas);
end;

function TFormula.fRetornaCustoProducaoTotalKilo(fltPesoTotalProduzido : double): double;
var
  objMateriaPrima : TMateriaPrima;
begin
  Result := 0;

  for objMateriaPrima in FMateriasPrimas do
    Result := Result + objMateriaPrima.fRetornaCustoProduzidoKilo(fltPesoTotalProduzido);

  Result := fRetornaValorArredondado(Result);

end;

function TFormula.fRetornaPrecoMedioProducaoTotalKilo(fltPesoTotalProduzido : double): double;
var
  objMateriaPrima : TMateriaPrima;
begin
  Result := 0;

  for objMateriaPrima in FMateriasPrimas do
    Result := Result + objMateriaPrima.fRetornaPrecoMedioProduzidoKilo(fltPesoTotalProduzido);

  Result := fRetornaValorArredondado(Result);

end;

end.

