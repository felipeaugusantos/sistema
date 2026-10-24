unit untIConsulta;

interface

Type
  IConsulta = Interface
  ['{E625C50B-0FB7-477C-8E65-222051C5D395}']
    function fRetornarSQLIpi : String;
    function fRetornarSQLStCustoAquisicao : String;
    function fRetornarSQLIcms : String;
    function fRetornarSQLIcmsEfetivo : String;
    function fRetornarSQLSt : String;
    function fRetornarSQLDifal : String;
    function fRetornarSQLFcp : String;
    function fRetornarSQLFcpDifal : String;
    function fRetornarSQLIcmsOrgaoPublico : String;
    function fRetornarSQLCfop : String;
    function fRetornarSQLPrecoCusto : String;
    function fRetornarSQLMargemVenda: String;
End;


implementation

end.
