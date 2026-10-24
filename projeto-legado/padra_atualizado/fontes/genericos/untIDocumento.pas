unit untIDocumento;

interface

Type

  IDocumento = interface
  ['{72F260CC-BB99-46F6-B055-49962ACFBB01}']
    procedure pImprimeNotaFiscal(strAutInc: String; blnValidarDireitoAcesso: Boolean = True);
    function fImprimeBoleto(strAutInc: String): Boolean;
    function fTemBoleto: Boolean;
    function fGetVencimentoAlterado: Boolean;
    function fGetJurosSugerido: Double;
    function fGetVencimento: TDateTime;
    function fGetValorCorrigido: Double;
    procedure pChamaAnexos(strAutInc, strCodCli, strCodEmp : String);
  end;

implementation

end.
