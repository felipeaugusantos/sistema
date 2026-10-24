unit Fulfillment.Classes.Empresa;

interface

Uses
  Classes, untEntNfeXml, Uni, System.SysUtils, untFuncoesSimples,

  Fulfillment.Classes.NotaFiscal;

Type
  TEmpresa = class(TObject)
  public
    strCnpj: String;
    arrNotas: Array Of TNotaFiscal;

    constructor Create(strCnpj: String);
    destructor Destroy; override;
    function fAdicionaNota(nota: TNFeXml; strCnpjEmpresa: String): TNotaFiscal;
  end;

implementation

{ TEmpresa }

constructor TEmpresa.Create(strCnpj: String);
begin
  Self.strCnpj := strCnpj;

  SetLength(arrNotas, 0);
end;

destructor TEmpresa.Destroy;
  Var
    intContador: Integer;
begin
  For intContador := Low(arrNotas) To High(arrNotas) Do
  Begin
    FreeAndNil(arrNotas[intContador]);
  End;
  SetLength(arrNotas, 0);

  inherited;
end;

function TEmpresa.fAdicionaNota(nota: TNFeXml; strCnpjEmpresa: String): TNotaFiscal;
  Var
    intTamMat: Integer;
begin
  Result := TNotaFiscal.Create(nota, strCnpjEmpresa);

  intTamMat := Length(arrNotas);
  SetLength(arrNotas, intTamMat+1);
  arrNotas[intTamMat] := Result;
end;

end.
