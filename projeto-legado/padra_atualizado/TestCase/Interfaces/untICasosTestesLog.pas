unit untICasosTestesLog;

interface

uses untTypes;

type
  IParametrosCasosTestesLog = interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']
    function ResultadoComparacao: TResultadoComparacao; overload;
    function ResultadoComparacao(AValue: TResultadoComparacao): IParametrosCasosTestesLog; overload;

    function RetornarNomeOperacao : String; overload;
    function RetornarNomeOperacao(AValue: String) : IParametrosCasosTestesLog; overload;

    function NumeroDoDocumento : String; overload;
    function NumeroDoDocumento(AValue: String) : IParametrosCasosTestesLog; overload;

    function EspecieDoDocumento : String; overload;
    function EspecieDoDocumento(AValue: String) : IParametrosCasosTestesLog; overload;

    function CodigoDaEmpresa : String; overload;
    function CodigoDaEmpresa(AValue: String) : IParametrosCasosTestesLog; overload;

    function CodigoDoItem : String; overload;
    function CodigoDoItem(AValue: String) : IParametrosCasosTestesLog; overload;

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String) : IParametrosCasosTestesLog; overload;

    function OpcaoDocumento: String; overload;
    function OpcaoDocumento(AValue: String) : IParametrosCasosTestesLog; overload;

    function DataEntrada: TDate; overload;
    function DataEntrada(AValue: TDate) : IParametrosCasosTestesLog; overload;

    function ClassificacaoFiscal: String; overload;
    function ClassificacaoFiscal(AValue: String) : IParametrosCasosTestesLog; overload;

    function CodigoFiscal: String; overload;
    function CodigoFiscal(AValue: String) : IParametrosCasosTestesLog; overload;

    function EstadoDoDocumento: String; overload;
    function EstadoDoDocumento(AValue: String) : IParametrosCasosTestesLog; overload;

    function TipoDaAbreviacaoFiscal : String; Overload;
    function TipoDaAbreviacaoFiscal(AValue : String) : IParametrosCasosTestesLog; Overload;

    function IdentificacaoDoProduto: String; Overload;
    function IdentificacaoDoProduto(AValue : String) : IParametrosCasosTestesLog; Overload;

    function Log: String; overload;
    function Log(AValue: String): IParametrosCasosTestesLog; overload;

  end;

  ICasosTestesLog = interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']

    function Add(AParametros: IParametrosCasosTestesLog): ICasosTestesLog; overload;
    function GerarLog(AFolder: String): ICasosTestesLog; overload;
  end;

implementation

end.
