unit untIFatOrdProTintaMaquina;

interface

type
  IFatOrdProTintaMaquina = Interface

    procedure pSetaDocumento(strNumDoc, strEspDoc, strCodEmp, strCodCli, strEmpPrd, strCodAca, strEmpAca: String);
    procedure pImprimeOrdProdTmp(blnVideo: Boolean = False; strEmpPrd: String = ''; strCodAca: String = '');
    function fGetTemFormula: Boolean;
    
  end;

implementation

end.
