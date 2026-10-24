unit untParametrosComparacaoCfop;


interface

type
  IParametrosComparacaoCfop= interface
    ['{7FDDC900-E936-4748-8177-33656D77E91C}']
    function TipoOperacao: String; overload;
    function TipoOperacao(AValue: String) : IParametrosComparacaoCfop; overload;


    function ClassificacaoDoItem: String; overload;
    function ClassificacaoDoItem(AValue: String) : IParametrosComparacaoCfop; overload;

    function ClassificacaoDeServico: String; overload;
    function ClassificacaoDeServico(AValue: String) : IParametrosComparacaoCfop; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String) : IParametrosComparacaoCfop; overload;

  end;

Type
  TParametrosComparacaoCfop = Class(TInterfacedObject, IParametrosComparacaoCfop)
  Private
    FTipoOperacao: String;
    FClassificacaoDoItem: String;
    FClassificacaoDeServico: String;
    FCodigoDaSubstituicaoTributariaDoItem: String;
  Public
    function TipoOperacao: String; overload;
    function TipoOperacao(AValue: String) : IParametrosComparacaoCfop; overload;

    function ClassificacaoDoItem: String; overload;
    function ClassificacaoDoItem(AValue: String) : IParametrosComparacaoCfop; overload;

    function ClassificacaoDeServico: String; overload;
    function ClassificacaoDeServico(AValue: String) : IParametrosComparacaoCfop; overload;

    function CodigoDaSubstituicaoTributariaDoItem: String; overload;
    function CodigoDaSubstituicaoTributariaDoItem(AValue: String) : IParametrosComparacaoCfop; overload;

    Class Function New() : IParametrosComparacaoCfop;
  End;

implementation

{ TParametrosComparacaoCfop }

function TParametrosComparacaoCfop.ClassificacaoDeServico: String;
begin
  Result := FClassificacaoDeServico;
end;

function TParametrosComparacaoCfop.ClassificacaoDeServico(
  AValue: String): IParametrosComparacaoCfop;
begin
  Result := Self;
  FClassificacaoDeServico := AValue;
end;

function TParametrosComparacaoCfop.ClassificacaoDoItem(
  AValue: String): IParametrosComparacaoCfop;
begin
  Result := Self;
  FClassificacaoDoItem := AValue;
end;

function TParametrosComparacaoCfop.ClassificacaoDoItem: String;
begin
  Result := FClassificacaoDoItem;
end;

function TParametrosComparacaoCfop.CodigoDaSubstituicaoTributariaDoItem: String;
begin
  Result := FCodigoDaSubstituicaoTributariaDoItem;
end;

function TParametrosComparacaoCfop.CodigoDaSubstituicaoTributariaDoItem(
  AValue: String): IParametrosComparacaoCfop;
begin
  Result := Self;
  FCodigoDaSubstituicaoTributariaDoItem := AValue;

end;

class function TParametrosComparacaoCfop.New: IParametrosComparacaoCfop;
begin
  Result := Self.Create;
end;

function TParametrosComparacaoCfop.TipoOperacao: String;
begin
  Result := FTipoOperacao;
end;

function TParametrosComparacaoCfop.TipoOperacao(
  AValue: String): IParametrosComparacaoCfop;
begin
  Result := Self;
  FTipoOperacao := AValue;
end;

end.

