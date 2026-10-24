unit untIExecutaSQLReplicacaoTinta;

interface

type
  IExecutaSQLReplicacaoTinta = Interface

    procedure pExecutaSQL(const strSQL: String; const arrParametros: array of string;
      const arrValores: array of Variant);

  End;

implementation

end.
