unit untTMateriaPrima;

interface

type
  TMateriaPrima = class(TObject)
    private
      FItem: String;
      FQuantidade: Double;
    public
      property strItem: String read FItem;
      property fltQuantidade: Double read FQuantidade;

      Constructor Create(strItem: String; fltQuantidade: Double);
  end;

implementation

{ TMateriaPrima }

constructor TMateriaPrima.Create(strItem: String; fltQuantidade: Double);
begin
  FItem := strItem;
  FQuantidade := fltQuantidade;
end;

end.
