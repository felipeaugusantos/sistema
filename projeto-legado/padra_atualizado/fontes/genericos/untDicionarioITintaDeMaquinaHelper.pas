unit untDicionarioITintaDeMaquinaHelper;

interface

uses
    untITintaDeMaquina, untFuncoesSimples, SysUtils;

type
  TDicionarioITintaDeMaquinaHelper = class helper for TDicionario
  public
    procedure AdicionarTintaDeMaquina(const strChave: string; const tintaDeMaquina: ITintaDeMaquina);
    function RetornarTintaDeMaquina(const strChave: string): ITintaDeMaquina;
  end;

implementation

uses  untInterfaceObjectWrapper;

{ TDicionarioITintaDeMaquinaHelper }

procedure TDicionarioITintaDeMaquinaHelper.AdicionarTintaDeMaquina(const strChave: string; const tintaDeMaquina: ITintaDeMaquina);
begin
  Self.AdicionarObjeto(strChave, TInterfaceObjectWrapper.Create(tintaDeMaquina));
end;

function TDicionarioITintaDeMaquinaHelper.RetornarTintaDeMaquina(const strChave: string): ITintaDeMaquina;
var
  objTinta: TObject;
begin
  Result := nil;
  Try
    objTinta := Self.RetornaObjeto(strChave);
    if objTinta is TInterfaceObjectWrapper then
    begin
      Result := ITintaDeMaquina(TInterfaceObjectWrapper(objTinta).referencia);
    end; 
    
  Except
    on E: Exception do
    begin
      Result := nil;
    end;
  End;            
end;

end.
