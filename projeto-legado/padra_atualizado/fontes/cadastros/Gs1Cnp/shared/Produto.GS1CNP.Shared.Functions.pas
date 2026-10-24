unit Produto.GS1CNP.Shared.Functions;

interface

uses System.SysUtils, untFuncoesSimples;

type
  TProdutoGS1CNPFunctions = class
  public
    class function SerializerStr(const AValue: string): String;
    class function SerializerDouble(const AValue: Double): String;
  end;

implementation

{ TProdutoGS1CNPFunctions }

class function TProdutoGS1CNPFunctions.SerializerDouble(
  const AValue: Double): String;
begin
  Result := FloatToStr(AValue);

  If Result <> '0' Then
    Exit;

  Result := 'null';
end;

class function TProdutoGS1CNPFunctions.SerializerStr(
  const AValue: string): String;
begin
  Result := '"'+AValue+'"';

  If Not fEmptyStr(AValue) Then
    Exit;

  Result := 'null';
end;

end.
