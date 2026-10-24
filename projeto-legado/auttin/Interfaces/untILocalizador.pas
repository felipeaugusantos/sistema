unit untILocalizador;

interface

uses
  Classes;

type
  ILocalizador = interface
    function GetNomeTabela: string;
    function GetSql: string;

    procedure ConstruirIndices(stlIndices: TStrings);
    procedure ConstruirDescricaoIndices(stlDesInd: TStrings);
    
    property Sql: string read GetSql;
    property NomeTabela: string read GetNomeTabela; 
  end;

implementation

end.
