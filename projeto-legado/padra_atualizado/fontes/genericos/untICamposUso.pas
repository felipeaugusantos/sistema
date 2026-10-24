unit untICamposUso;

interface

uses DB;

Type
  ICamposUso = Interface
  ['{2DED6B20-41DB-48BA-90D8-02B5DE6AACB7}']

    procedure AdicionaCampos(qryTabela: TDataSet; strNomeTabela: String);
    procedure LimparCampos;

    function GetCampo(Index: String): String;

    property Campos[Index: String]: String read GetCampo; default;
  End;

implementation

end.
