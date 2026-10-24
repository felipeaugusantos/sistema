unit untIRelacionamentoClienteProdutoGarantia;

interface

type
  IRelacionamentoClienteProdutoGarantia = interface
    ['{98D8819A-90CD-406B-8A7D-C76364E7F6CF}']

    function GetSQL: String;
    procedure Excluir(const AAutInc: String);
    procedure Atualizar(const AAutInc, ACodIte: String);
  end;

implementation

end.
