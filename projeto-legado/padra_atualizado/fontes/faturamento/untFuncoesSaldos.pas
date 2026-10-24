unit untFuncoesSaldos;

interface

uses
  untIFuncoesSaldos;

type
  TFuncoesSaldos = class(TInterfacedObject, IFuncoesSaldos)
  public

    function fRetornaSaldoDisponivel(strCodIte: String;
      blnCnvMl: Boolean = False; blnFaturamento: Boolean = True;
      strNumLot: String = ''; blnConsiderarPedidos: Boolean = True;
      strCodEmp: String = ''; strNumPedAlt: String = '';
      blnConsiderarPedidoCompraPendente: Boolean = False;
      blnConsiderarCfgCalSal: Boolean = True): Double;

  end;

implementation

uses
  untFuncoesGenerica;

{ TFuncoesSaldos }

function TFuncoesSaldos.fRetornaSaldoDisponivel(strCodIte: String;
  blnCnvMl: Boolean = False; blnFaturamento: Boolean = True;
  strNumLot: String = ''; blnConsiderarPedidos: Boolean = True;
  strCodEmp: String = ''; strNumPedAlt: String = '';
  blnConsiderarPedidoCompraPendente: Boolean = False;
  blnConsiderarCfgCalSal: Boolean = True): Double;
begin
  Result := untFuncoesGenerica.fRetornaSaldoDisponivel(strCodIte, blnCnvMl,
    blnFaturamento, strNumLot, blnConsiderarPedidos, strCodEmp, strNumPedAlt,
    blnConsiderarPedidoCompraPendente, blnConsiderarCfgCalSal);
end;

end.
