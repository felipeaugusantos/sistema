unit untFatMostraMargemNovoFactory;

interface

uses untIFatMostraMargemNovo, untFatMostraMargemNovoValidaUnitario,
  untFatMostraMargemNovoAdicionarTinta, untFatMostraMargemNovoBeforePost;

type
  TFatMostraMargemNovoFactory = class(TInterfacedObject, IFatMostraMargemNovoFactory)
  private
  public
    function ValidaUnitario: IFatMostraMargemNovoValidaUnitario;
    function AdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
    function BeforePost: IFatMostraMargemNovoBeforePost;

    class function New(): IFatMostraMargemNovoFactory;
  end;

implementation

{ TFatMostraMargemNovoFactory }

function TFatMostraMargemNovoFactory.AdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
begin
  Result := TFatMostraMargemNovoAdicionarTinta.New;
end;

function TFatMostraMargemNovoFactory.BeforePost: IFatMostraMargemNovoBeforePost;
begin
  Result := TFatMostraMargemNovoBeforePost.New;
end;

class function TFatMostraMargemNovoFactory.New: IFatMostraMargemNovoFactory;
begin
  Result := Self.Create;
end;

function TFatMostraMargemNovoFactory.ValidaUnitario: IFatMostraMargemNovoValidaUnitario;
begin
  Result := TFatMostraMargemNovoValidaUnitario.New;
end;

end.
