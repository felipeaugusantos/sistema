unit Shared.Functions.Core;

interface

uses Shared.Functions.DataSet, Shared.Functions.Types;

type
  IFunctionsCore = interface
    ['{AEAF33B7-299D-4BDD-9FD4-BEF524E1035A}']

    function fCampoTabela(arrCampos: Array Of String;
                          strNomTab: String;
                          arrCampoChave: Array Of String;
                          arrValorChave: Array Of Variant;
                          blnSempreLerBanco: Boolean = True;
                          strOrderBy: String = '';
                          blnUsarMax: Boolean = False): IMyCampoTabela;

    function fCampoTabelaDados(ASQL: String; AParametros: ArrOfString; AValores: ArrOfVariant): IMyCampoTabela; overload;
    function fCampoTabelaDados(ASQL: String): IMyCampoTabela; overload;
    function fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;
    function fTabelaExiste(Const ANomeTabela : String; const blnUsarCache : Boolean = False) : Boolean;
    function fTemAliqEcf(fltAliquota: Double; const strPatIni: String): Boolean;
    function RetornarTamanhoDoCampoNumeroDoDocumento: Integer;
    function fMskDigitos(intDigitos: Integer): String;
    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fCriarQuery(): IMyQuery;
    function fStrToFloat(strValor: String): Double; overload;
    function fStrToFloat(strValorUnico: String; fltDefault: Real): Double; overload;
    function IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
    function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
    function fRetAutoIncrem(strNomeTabela, strCodEmp : string): String;
    function fCodigoDaEmpresa : String;
    function fRetPrecisaoMargemItem: Integer;
    function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
    function fFloatToSQL(fltValor: Double): String;
    function IfFloatZero(fltValor, fltDefault: Double): Double;
  end;

  procedure SetObjCore(AValue: IFunctionsCore);

var
  objCore: IFunctionsCore;

implementation

procedure SetObjCore(AValue: IFunctionsCore);
begin
  objCore := AValue;
end;

end.
