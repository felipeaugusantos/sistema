unit untTypesGenericosImpostos;

interface

type
  TFaturamentoImpostosClienteConsumidor = record
    ClienteEstado: String;
    ClienteFisicoOuJuridico: String;
    ClienteInscricaoEstadual: String;
    ClienteAtividade: String;
    CalcularDescontoIcmsOrgaoPublico : Boolean;
    CodigoDaEmpresaTransferencia: String;
  End;

implementation

end.
