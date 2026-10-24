unit Produto.TSQLProdutos;

interface

uses classes;

  Type TSQLProdutos = Class

    public

      function fRetornaFiltroSQLComponenteFormulacaoB: String;
      function fRetornaFiltroSQLComponenteFormulacaoDiluente: String;

  End;

implementation

{ TSQLProdutos }

function TSQLProdutos.fRetornaFiltroSQLComponenteFormulacaoB: String;
begin
  Result:='  AND ITE_COMPNB = "S"';
end;

function TSQLProdutos.fRetornaFiltroSQLComponenteFormulacaoDiluente: String;
begin
  Result:='  AND ITE_COMPNA = "S"';
end;

end.
