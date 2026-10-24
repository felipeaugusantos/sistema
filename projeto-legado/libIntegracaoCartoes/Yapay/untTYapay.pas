unit untTYapay;

interface

uses System.Generics.Collections, SysUtils;

Type
  TYapayRegistro = class
    private
    public
      CodigoEstabelecimento,
      TipoRegistro,
      CodigoExtrato,
      CodigoTransacao,
      NumeroPedido,
      DescricaoLancamento,
      DataPagamento,
      NumeroParcela,
      NomeArquivo,
      DataArquivo,
      Status,
      CodigoConciliacao,
      FormaPagamento : String;

      ValorPago,
      Saldo    : Double;
  end;

implementation

end.
