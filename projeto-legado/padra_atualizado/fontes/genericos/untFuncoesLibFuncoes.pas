unit untFuncoesLibFuncoes;

interface
{$WARN SYMBOL_PLATFORM OFF}

  function fStrToFloat(strValor: String): Double; StdCall; external 'libFuncoes.dll' delayed;
  function fMskDigitos(intDigitos: Integer): String; StdCall; external 'libFuncoes.dll' delayed;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double; StdCall; external 'libFuncoes.dll' delayed;
  function fEmptyStr(strValor: String): Boolean StdCall; external 'libFuncoes.dll' delayed;

implementation

end.
