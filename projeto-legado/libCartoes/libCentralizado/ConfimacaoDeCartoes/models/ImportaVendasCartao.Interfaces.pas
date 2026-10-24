unit ImportaVendasCartao.Interfaces;

interface

uses System.Generics.Collections,

    cxProgressBar,

    untTExtratoConfirmaCartoes;

type
  IImportacaoVendasCartao = interface
  ['{2ED50269-2D58-4E54-A0AA-1F70A88C5A95}']
    function  DataInicial(AValue: TDateTime): IImportacaoVendasCartao; overload;
    function  DataInicial: TDateTime; overload;
    function  DataFinal(AValue: TDateTime): IImportacaoVendasCartao; overload;
    function  DataFinal: TDateTime; overload;
    function  ExtratoVendas: TList<TDadosVendas>;
    procedure ImportarVendasCartao;
    function  GerarExtratoVendasImportadas(pgbProgresso: TcxProgressBar): Boolean;
    function  Importou: Boolean;
  end;

implementation

end.
