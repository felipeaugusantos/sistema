unit untIFdoIte;

interface

uses untFuncFatTypes;

type
  IFdoIte = interface
    ['{2E8F5021-60B2-4A4F-AA22-2F8F7C1A5B86}']

    procedure pGravaFdoIte(strAutInc: String; item: TDadosFechamento; objVenda: TObject);
    procedure pPreencherDataSetFdoIte(strAutIncFatGor: String);
    function fRetornarPercentualDescontoEmbalagemFechada(const strAutIncFatDor: String): Double;
    function fRetornarPrecoVendaItemPedido(const strAutIncFatDor, strCodIte: String): Double;
  end;

implementation

end.
