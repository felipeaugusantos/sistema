unit untGeocode;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  IEnderecoGeocode = interface
  ['{1363AA2C-48FC-400F-86F8-F1FD7D354134}']
    function fSetEndereco(const AValue: String): IEnderecoGeocode;
    function fSetLatitude(const AValue: Extended): IEnderecoGeocode;
    function fSetLongitude(const AValue: Extended): IEnderecoGeocode;
    function fSetId(const AValue: String): IEnderecoGeocode;

    function fGetEndereco: String;
    function fGetLatitude: Extended;
    function fGetLongitude: Extended;
    function fGetId: String;
  end;

  IEnderecosGeocode = interface
  ['{8CBE0546-3A0B-47ED-9B72-4DF909F5EAF8}']
    function fRetEnderecosGeocode: TArray<IEnderecoGeocode>;
    procedure pAddEnderecoGeocode(const AstrLatitude, AstrLongitude: Extended; AstrEndereco, AstrId: String);
  end;

type
  TEnderecoGeocode = class(TInterfacedObject, IEnderecoGeocode)
  private
    FEndereco: String;
    FLatitude: Extended;
    FLongitude: Extended;
    FId: String;
  public
    class function fNew: IEnderecoGeocode;

    function fSetEndereco(const AValue: String): IEnderecoGeocode;
    function fSetLatitude(const AValue: Extended): IEnderecoGeocode;
    function fSetLongitude(const AValue: Extended): IEnderecoGeocode;
    function fSetId(const AValue: String): IEnderecoGeocode;

    function fGetEndereco: String;
    function fGetLatitude: Extended;
    function fGetLongitude: Extended;
    function fGetId: String;
  end;

  TEnderecosGeocode = class(TInterfacedObject, IEnderecosGeocode)
  private
    FEnderecosGeocode: TArray<IEnderecoGeocode>;
  public
    procedure pAddEnderecoGeocode(const AstrLatitude, AstrLongitude: Extended; AstrEndereco, AstrId: String);
    function fRetEnderecosGeocode: TArray<IEnderecoGeocode>;
  end;

implementation

{ TEnderecoGeocode }

function TEnderecoGeocode.fGetEndereco: String;
begin
  Result := FEndereco;
end;

function TEnderecoGeocode.fGetId: String;
begin
  Result := FId;
end;

function TEnderecoGeocode.fGetLatitude: Extended;
begin
  Result := FLatitude;
end;

function TEnderecoGeocode.fGetLongitude: Extended;
begin
  Result := FLongitude;
end;

class function TEnderecoGeocode.fNew: IEnderecoGeocode;
begin
  Result := TEnderecoGeocode.Create;
end;

function TEnderecoGeocode.fSetEndereco(const AValue: String): IEnderecoGeocode;
begin
  FEndereco := AValue;
  Result := Self
end;

function TEnderecoGeocode.fSetId(const AValue: String): IEnderecoGeocode;
begin
  FId := AValue;
  Result := Self;
end;

function TEnderecoGeocode.fSetLatitude(const AValue: Extended): IEnderecoGeocode;
begin
  FLatitude := AValue;
  Result := Self;
end;

function TEnderecoGeocode.fSetLongitude(const AValue: Extended): IEnderecoGeocode;
begin
  FLongitude := AValue;
  Result := Self;
end;

{ TEnderecosGeocode }

procedure TEnderecosGeocode.pAddEnderecoGeocode(const AstrLatitude, AstrLongitude: Extended;
  AstrEndereco, AstrId: String);
begin
  SetLength(FEnderecosGeocode, Length(FEnderecosGeocode)+1);
  FEnderecosGeocode[Length(FEnderecosGeocode)-1] := TEnderecoGeocode.fNew
                                                      .fSetId(AstrId)
                                                      .fSetEndereco(AstrEndereco)
                                                      .fSetLatitude(AstrLatitude)
                                                      .fSetLongitude(AstrLongitude);
end;

function TEnderecosGeocode.fRetEnderecosGeocode: TArray<IEnderecoGeocode>;
begin
  Result := FEnderecosGeocode;
end;

end.
