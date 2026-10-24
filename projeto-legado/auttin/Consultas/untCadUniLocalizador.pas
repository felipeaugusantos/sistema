unit untCadUniLocalizador;

interface

uses
  untILocalizador, Classes;

type
  TCadUniLocalizador = class(TInterfacedObject, ILocalizador)
  public
    procedure ConstruirDescricaoIndices(stlDesInd: TStrings);
    procedure ConstruirIndices(stlIndices: TStrings);
    function GetNomeTabela: string;
    function GetSql: string;
  end;

implementation

{ TCadUniLocalizador }

procedure TCadUniLocalizador.ConstruirDescricaoIndices(stlDesInd: TStrings);
begin
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Unidade');
end;

procedure TCadUniLocalizador.ConstruirIndices(stlIndices: TStrings);
begin
  stlIndices.Add('UNI_CODUNI');
  stlIndices.Add('UNI_DESUNI');
  stlIndices.Add('UNI_SIGUNI');
end;

function TCadUniLocalizador.GetNomeTabela: string;
begin
  Result := 'CADUNI';
end;

function TCadUniLocalizador.GetSql: string;
begin
  Result :=
    ' SELECT DISTINCT                 ' +
    '   UNI_CODUNI AS "Código"        ' +
    '   , UNI_DESUNI AS "Descrição"   ' +
    '   , UNI_SIGUNI AS "Unidade"     ' +
    '   , UNI_PESLIT AS "Peso Litro"  ' +
    '   , AUTOINCREM                  ' +
    ' FROM                            ' +
    '   CADUNI                        ' +
    ' WHERE TRUE                      ';
end;

end.
