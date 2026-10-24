unit OrdemProducaoIndustrial.TMateriaPrima;

interface

uses
  Classes;

Type
  TMateriaPrima = class
    private
      FCodigo            : String;
      FDescricao         : String;
      FCusto             : double;
      FPercentualFormula : double;
      FArredondarValor   : Boolean;
      FPrcMedio          : double;
    public
      property strCodigo: String            read FCodigo            write FCodigo;
      property strDescricao: String         read FDescricao         write FDescricao;
      property fltCusto: double             read FCusto             write FCusto;
      property fltPercentualFormula: double read FPercentualFormula write FPercentualFormula;
      property blnArredondarValor: Boolean  read FArredondarValor   write FArredondarValor;
      property fltPrcMedio: double          read FPrcMedio          write FPrcMedio;

      constructor Create;

      function fRetornaQuantidadeUtilizadaKilo(fltPesoTotalProduzido: double): double;
      function fRetornaCustoProduzidoKilo(fltPesoTotalProduzido: double) : double;
      function fRetornaPrecoMedioProduzidoKilo(fltPesoTotalProduzido: double): double;
  End;

implementation

uses
  OrdemProducaoIndustrial.Funcoes;

{ TMateriaPrima }

constructor TMateriaPrima.Create;
begin
  FCodigo            := '';
  FDescricao         := '';
  FCusto             := 0;
  FPercentualFormula := 0;
  FArredondarValor   := True;
  FPrcMedio          := 0;
end;


function TMateriaPrima.fRetornaQuantidadeUtilizadaKilo(fltPesoTotalProduzido: double): double;
begin

  {FArredondarValor => Criado para não arredondar na chamada do relatorio frmRelCadCustosIndustrial
   pois quando ha uma baixa da OPI o sistema ao gravar na movdet campo DET_QTDITE realiza o cakculo sem arredondamento
   para evitar diferença de estoque. O Campo DET_QTDITE é mostrado na aba formula da frmManOrdProIndustrial O Calculo
   precisa ser realizado para o relatorio da mesma forma sem o arredondamento}

  Result := (fltPesoTotalProduzido * FPercentualFormula) / 100;
  If FArredondarValor Then
    Result := fRetornaValorArredondado(Result);

end;

function TMateriaPrima.fRetornaCustoProduzidoKilo(fltPesoTotalProduzido: double): double;
begin
  Result := fRetornaQuantidadeUtilizadaKilo(fltPesoTotalProduzido * FCusto);
  If FArredondarValor Then
    Result := fRetornaValorArredondado(Result);
end;

function TMateriaPrima.fRetornaPrecoMedioProduzidoKilo(fltPesoTotalProduzido: double): double;
begin
  Result := fRetornaQuantidadeUtilizadaKilo(fltPesoTotalProduzido * FPrcMedio);
  If FArredondarValor Then
    Result := fRetornaValorArredondado(Result);
end;

end.

