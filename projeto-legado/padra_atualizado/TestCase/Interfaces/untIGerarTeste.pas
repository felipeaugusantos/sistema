unit untIGerarTeste;


interface

Uses Uni;

Type
  IGerarTeste = Interface
  ['{E625C50B-0FB7-477C-8E65-222051C5D395}']
    function fGerarTesteIpi(const ADados: OleVariant) : Boolean;
    function fGerarTesteStCustoAquisicao(const ADados: OleVariant) : Boolean;
    function fGerarTesteIcmsSt(const ADados: OleVariant; Const AOpcao : String) : Boolean;
    function fGerarTesteIcmsEfetivo(const ADados: OleVariant) : Boolean;
    function fGerarTesteDifal(const ADados: OleVariant) : Boolean;
    function fGerarTesteFcp(const ADados: OleVariant) : Boolean;
    function fGerarTesteFcpDifal(const ADados: OleVariant) : Boolean;
    function fGerarTesteIcmsOrgaoPublico(const ADados: OleVariant): Boolean;
    function fGerarTesteCfop(const ADados: OleVariant): Boolean;
    function fGerarTestePrecoCusto(const ADados: OleVariant): Boolean;
    function fGerarTesteMargemVenda(const ADados: OleVariant): Boolean;
End;


implementation

end.
