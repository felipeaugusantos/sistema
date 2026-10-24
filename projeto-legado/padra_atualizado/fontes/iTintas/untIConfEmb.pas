unit untIConfEmb;

interface

Type
  IConfEmb = Interface
    function fGet(strCodCfg: String): String;
    procedure pSet(strCodCfg: String; strValCfg: string);
    procedure pInsereCodigo(strCodCfg, strEmbala, strLinha_, strCodIte: String);

  End;

implementation

end.
