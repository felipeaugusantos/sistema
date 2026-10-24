unit untInterSistemaEstacionamento;

interface

type
  ISistemaEstacionamento = interface
    function fSolicitaLiberacaoDeTicket(strNumTicket: String; Var strMsgRetorno: String): Boolean;
  end;

implementation

end.
