unit untCasosTestesLogImpl;

interface

uses untICasosTestesLog, untTypes;

type
  TParametrosCasosTestesLog = class(TInterfacedObject, IParametrosCasosTestesLog)
  private
    FResultadoComparacao   : TResultadoComparacao;
    FLog                   : String;
    FRetornarNomeOperacao  : String;
    FNumeroDoDocumento     : String;
    FEspecieDoDocumento    : String;
    FCodigoDaEmpresa       : String;
    FCodigoDoItem          : String;
    FCodigoDoCliente       : String;
    FOpcaoDocumento        : String;
    FClassificacaoFiscal   : String;
    FCodigoFiscal          : String;
    FEstadoDoDocumento     : String;
    FTipoDaAbreviacaoFiscal: String;
    FIdentificacaoDoProduto: String;
    FDataEntrada           : TDate;
  public
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

    function Log: String; overload;
    function Log(AValue: String): IParametrosCasosTestesLog; overload;

    function CodigoFiscal: String; overload;
    function CodigoFiscal(AValue: String) : IParametrosCasosTestesLog; overload;

    function EstadoDoDocumento: String; overload;
    function EstadoDoDocumento(AValue: String) : IParametrosCasosTestesLog; overload;

    function TipoDaAbreviacaoFiscal : String; Overload;
    function TipoDaAbreviacaoFiscal(AValue : String) : IParametrosCasosTestesLog; Overload;

    function IdentificacaoDoProduto: String; Overload;
    function IdentificacaoDoProduto(AValue : String) : IParametrosCasosTestesLog; Overload;

    class function New(): IParametrosCasosTestesLog;
  end;

implementation

{ TParametrosCasosTestesLog }

function TParametrosCasosTestesLog.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosCasosTestesLog.ClassificacaoFiscal: String;
begin
  result := FClassificacaoFiscal;
end;

function TParametrosCasosTestesLog.ClassificacaoFiscal(
  AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FClassificacaoFiscal := AValue;
end;

function TParametrosCasosTestesLog.CodigoDaEmpresa(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;


function TParametrosCasosTestesLog.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosCasosTestesLog.CodigoDoCliente(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosCasosTestesLog.CodigoDoItem: String;
begin
  Result := FCodigoDoItem;
end;

function TParametrosCasosTestesLog.CodigoDoItem(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FCodigoDoItem := AValue;
end;

function TParametrosCasosTestesLog.CodigoFiscal: String;
begin
  result := FCodigoFiscal;
end;

function TParametrosCasosTestesLog.CodigoFiscal(
  AValue: String): IParametrosCasosTestesLog;
begin
  result := Self;
  FCodigoFiscal := AValue;
end;

function TParametrosCasosTestesLog.DataEntrada(
  AValue: TDate): IParametrosCasosTestesLog;
begin
  Result := Self;
  FDataEntrada := AValue;
end;

function TParametrosCasosTestesLog.DataEntrada: TDate;
begin
  result := FDataEntrada;
end;

function TParametrosCasosTestesLog.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

function TParametrosCasosTestesLog.EspecieDoDocumento(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TParametrosCasosTestesLog.EstadoDoDocumento: String;
begin
  result := FEstadoDoDocumento;
end;

function TParametrosCasosTestesLog.EstadoDoDocumento(
  AValue: String): IParametrosCasosTestesLog;
begin
  result := Self;
  FEstadoDoDocumento := AValue;
end;

function TParametrosCasosTestesLog.IdentificacaoDoProduto: String;
begin
  result := FIdentificacaoDoProduto;
end;

function TParametrosCasosTestesLog.IdentificacaoDoProduto(
  AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FIdentificacaoDoProduto := AValue;
end;

function TParametrosCasosTestesLog.Log: String;
begin
  Result := FLog;
end;

function TParametrosCasosTestesLog.Log(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FLog := AValue;
end;

function TParametrosCasosTestesLog.NumeroDoDocumento: String;
begin
  Result := FNumeroDoDocumento;
end;

function TParametrosCasosTestesLog.NumeroDoDocumento(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FNumeroDoDocumento := AValue;
end;


function TParametrosCasosTestesLog.OpcaoDocumento(
  AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FOpcaoDocumento := AValue;
end;

function TParametrosCasosTestesLog.OpcaoDocumento: String;
begin
  Result := FOpcaoDocumento;
end;

function TParametrosCasosTestesLog.RetornarNomeOperacao: String;
begin
  Result := FRetornarNomeOperacao;
end;

function TParametrosCasosTestesLog.ResultadoComparacao(
  AValue: TResultadoComparacao): IParametrosCasosTestesLog;
begin
  Result := Self;
  FResultadoComparacao := AValue;
end;


function TParametrosCasosTestesLog.ResultadoComparacao: TResultadoComparacao;
begin
  Result := FResultadoComparacao;
end;

function TParametrosCasosTestesLog.RetornarNomeOperacao(AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FRetornarNomeOperacao := AValue;
end;


function TParametrosCasosTestesLog.TipoDaAbreviacaoFiscal: String;
begin
  Result := FTipoDaAbreviacaoFiscal;
end;

function TParametrosCasosTestesLog.TipoDaAbreviacaoFiscal(
  AValue: String): IParametrosCasosTestesLog;
begin
  Result := Self;
  FTipoDaAbreviacaoFiscal := AValue;
end;

class function TParametrosCasosTestesLog.New: IParametrosCasosTestesLog;
begin
  Result := Self.Create;
end;

end.
