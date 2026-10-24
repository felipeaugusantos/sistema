unit untIFatDefineLotesPedidoWMS;

interface

type
  IFatDefineLotesPedidoWMS = interface
    ['{E128EC06-D017-494C-822B-F89A64363DAF}']
    function fDigitaLotesPedidoWMS(strNumDoc,
      strEmpPed, strCodCli, strCodSep, strAutInc, strSepImp,
      strAutIncTinta: String): Boolean;
  end;


implementation

end.
