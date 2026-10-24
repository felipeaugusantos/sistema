unit untGeoSale_Base;

interface

Uses untRTTILayout;

Type
  TGeoSale_Base = Class(TLayout)
  Protected
    FNomDir: String;
    FEmpresas : String;

  Public
    constructor Create(strNomDir : String; strEmpresas : String); virtual;
  End;

Type
   TGeoSale_BaseClass = class of TGeoSale_Base;

implementation

{ TGeoSale_Base }

constructor TGeoSale_Base.Create(strNomDir: String; strEmpresas : String);
begin
  inherited Create;
  FNomDir := strNomDir;
  FEmpresas := strEmpresas;
end;

end.


