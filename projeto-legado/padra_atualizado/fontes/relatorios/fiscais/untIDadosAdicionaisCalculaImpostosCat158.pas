unit untIDadosAdicionaisCalculaImpostosCat158;

interface

type
  IDadosAdicionaisCalculaImpostosCat158 = interface
    //ENTRADA - IF(RIGHT(D.DET_CODFIS, 2) = "60" AND LEFT(D.DET_CLAFIS, 1) = "1", 1, 0) AS REGRA_CST_CFOP
    procedure pSetRegraCstCfop(strRegraCstCfop: string);
    function fGetRegraCstCfop: string;

    procedure pSetValorProduto(fltValorProduto: double);
    function fGetValorProduto: double;

    procedure pSetAlqInterna(fltAlqInterna: double);
    function fGetAlqInterna: double;

    procedure pSetValorIVA(fltValorIVA: double);
    function fGetValorIVA: double;

    procedure pSetValorIpi(fltValorIpi: double);
    function fGetValorIpi: double;

    procedure pSetValorIcms(fltValorIcms: double);
    function fGetValorIcms: double;

    procedure pSetValorIcmsUntCompra(fltValorIcmsUntCompra: double);
    function fGetValorIcmsUntCompra: double;

    //retorna o valor do produto + ipi
    function fGetTotalProdutoIpi: double;
  end;

implementation

end.
