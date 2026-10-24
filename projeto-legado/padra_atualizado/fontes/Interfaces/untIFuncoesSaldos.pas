unit untIFuncoesSaldos;

interface

Type
  IFuncoesSaldos = interface
  ['{C59DC083-3839-47EA-9F9A-8A607A811F81}']

    function fRetornaSaldoDisponivel(strCodIte            : String;
                                     blnCnvMl             : Boolean = False;
                                     blnFaturamento       : Boolean = True;
                                     strNumLot            : String  = '';
                                     blnConsiderarPedidos : Boolean = True;
                                     strCodEmp            : String  = '';
                                     strNumPedAlt         : String  = '';
                                     blnConsiderarPedidoCompraPendente : Boolean = False;
                                     blnConsiderarCfgCalSal            : Boolean = True) : Double;
  end;

implementation

end.
