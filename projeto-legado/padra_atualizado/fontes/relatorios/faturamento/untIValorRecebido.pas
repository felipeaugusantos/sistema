unit untIValorRecebido;

interface

uses untTypesSistema;

Type
  IValorRecebido = interface
  ['{44766E59-3DBA-47D2-A218-4E5BFA827290}']
    function fGetVenDig(strAlias: String): String;
    function fGetVenDigDet: String;
    function fGetFatCom: String;

    function fGetSqlSemAgrupamentoNemConfirmacao(strTabela: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
    function fGetSqlComConfirmacao(strCadRec, strCtrCnf: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
    function fGetSqlComAgrupamentoDireto(strCadRec, strDupAgr: String; intNotSer : Integer = 2; intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }
    function fGetSqlAgrupamentoConfirmacao(strCadRec, strDupAgr, strCtrCnf: String; intNotSer : Integer = 2;  intRetSubGer : Integer = 0; blnExibeItens: Boolean = False): String; { intRetSubGer -> 0 - NÃO SELECIONA; 1 - SEL. GERENTE; 2 - SEL. SUB-GERENTE }

    function fGetSqlSemAgrupamentoNemConfirmacaoAberto(strTabela: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;
    function fGetSqlComConfirmacaoAberto(strCadRec, strCtrCnf: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;
    function fGetSqlComAgrupamentoDiretoAberto(strCadRec, strDupAgr: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;
    function fGetSqlAgrupamentoConfirmacaoAberto(strCadRec, strDupAgr, strCtrCnf: String; intNotSer : Integer = 2; strAnaSin: String = 'S'): String;

    function getCodVen: String;
    procedure setCodVen(Value: String);

    function getCodEmp: String;
    procedure setCodEmp(Value: String);

    function getRelEmp: TRelacionamentoEmpresa;
    procedure setRelEmp(Value: TRelacionamentoEmpresa);

    function getVenRep: TOpVendedorRepresentante;
    procedure setVenRep(Value: TOpVendedorRepresentante);

    function getDepCod: String;

    procedure setDepCod(const Value: String);

    property strCodVen: String Read getCodVen Write setCodVen;
    property strCodEmp: String Read getCodEmp Write setCodEmp;
    property relRelEmp: TRelacionamentoEmpresa   Read getRelEmp Write setRelEmp;
    property opcVenRep: TOpVendedorRepresentante Read getVenRep Write setVenRep;
    property strDepCod: String Read getDepCod Write setDepCod;
  End;

implementation

end.
