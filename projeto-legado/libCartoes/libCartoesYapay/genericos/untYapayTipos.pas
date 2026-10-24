unit untYapayTipos;

interface

Const
  NOME_CONCILIACAO = 'YAPAY';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

type
  TYapayRegistro = record
    TipoRegistro: string;
    DataPagamento: string;
    NumeroParcela: string;
    CodigoEstabelecimento: string;
    CodigoExtrato: string;
    CodigoTransacao: string;
    DescricaoLancamento: string;
    NumeroPedido: string;
    NomeArquivo: string;
    DataArquivo: string;
    ValorPago: Currency;
    Saldo: Currency;
    Status: string;
    CodigoConciliacao: string;
    FormaPagamento: string;
  end;

  TArrRegistroYapayPgto = array of TYapayRegistro;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaYapayPgto  = Array Of TEstruturaPgto;
implementation

end.
