unit untFatMostraMargemNovoController;

interface

uses untIFatMostraMargemNovo, untFatMostraMargemNovoFactory;

type
  TFatMostraMargemNovoController = class(TInterfacedObject, IFatMostraMargemNovoController)
  private
  public
    function ValidaUnitario: IFatMostraMargemNovoValidaUnitario;
    function AdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
    function BeforePost: IFatMostraMargemNovoBeforePost;

    class function New(): IFatMostraMargemNovoController;
  end;

implementation

{ TFatMostraMargemNovoController }

function TFatMostraMargemNovoController.AdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
begin
  Result := TFatMostraMargemNovoFactory.New.AdicionarTinta;
end;

function TFatMostraMargemNovoController.BeforePost: IFatMostraMargemNovoBeforePost;
begin
  Result := TFatMostraMargemNovoFactory.New.BeforePost;
end;

class function TFatMostraMargemNovoController.New: IFatMostraMargemNovoController;
begin
  Result := Self.Create;
end;

function TFatMostraMargemNovoController.ValidaUnitario: IFatMostraMargemNovoValidaUnitario;
begin
  Result := TFatMostraMargemNovoFactory.New.ValidaUnitario;
end;

end.
