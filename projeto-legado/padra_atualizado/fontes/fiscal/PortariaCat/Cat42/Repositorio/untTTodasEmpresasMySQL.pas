unit untTTodasEmpresasMySQL;

interface

uses untTEmpresa;

Type
  TTodasEmpresasMySQL = class(TObject)
    public
      function fRetTodasEmpresaDeCodigo(strEmpresa: String): TEmpresa;
  end;

implementation

{ TTodasEmpresasMySQL }

function TTodasEmpresasMySQL.fRetTodasEmpresaDeCodigo(strEmpresa: String): TEmpresa;
begin
  Result := TEmpresa.Create(strEmpresa);
end;

end.
