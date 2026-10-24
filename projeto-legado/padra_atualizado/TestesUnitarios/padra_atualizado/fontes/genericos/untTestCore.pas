unit untTestCore;

interface

uses Shared.Functions.Core, Shared.Functions.DataSet, untTestObjMyCampoTabela,
  Shared.Functions.Types, System.SysUtils, System.StrUtils, Core.Funcoes, Math;

type
  TTestCore = class(TInterfacedObject, IFunctionsCore)
  public
    function fCampoTabela(arrCampos: Array Of String;
                          strNomTab: String;
                          arrCampoChave: Array Of String;
                          arrValorChave: Array Of Variant;
                          blnSempreLerBanco: Boolean = True;
                          strOrderBy: String = '';
                          blnUsarMax: Boolean = False): IMyCampoTabela;

//    function fCampoTabelaDados(ASQL, ACodigoDoItem, ACodigoDaAbreviacaoFiscal, AEstado: String): IMyCampoTabela;
    function fCampoTabelaDados(ASQL: String; AParametros: ArrOfString; AValores: ArrOfVariant): IMyCampoTabela; overload;
    function fCampoTabelaDados(ASQL: String): IMyCampoTabela; overload;
    function fCampoExiste(const strTabela, strCampo: String): Boolean;
    function fTemAliqEcf(fltAliquota: Double; const strPatIni: String): Boolean;
    function RetornarTamanhoDoCampoNumeroDoDocumento: Integer;
    function fTabelaExiste(Const ANomeTabela : String) : Boolean;

    function fMskDigitos(intDigitos: Integer): String;
    function fStrToFloat(strValor: String): Double; overload;
    function fStrToFloat(strValorUnico: String; fltDefault: real): Double; overload;
    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fCriarQuery(): IMyQuery;

    function fArqIni(ReadWrite: Integer; NomChave, NomSecao, Conteudo,
      strNomArq: String): String;
    function fCodigoDaEmpresa: String;
    function fEmptyStr(strString: String;
      blnTiraCaracEspecial: Boolean): Boolean;
    function fFloatToSQL(fltValor: Double): String;
    function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
    function fRetPrecisaoMargemItem: Integer;
    function IfFloatZero(fltValor, fltDefault: Double): Double;
    function IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
    function IIF(lTest: Boolean; vExpr1, vExpr2: Variant): Variant;

    class function New(): IFunctionsCore;
  end;

implementation

{ TTestCore }

function TTestCore.fCampoExiste(const strTabela, strCampo: String): Boolean;
begin
  Result := False;
end;

function TTestCore.fCampoTabela(arrCampos: array of String; strNomTab: String;
  arrCampoChave: array of String; arrValorChave: array of Variant;
  blnSempreLerBanco: Boolean; strOrderBy: String;
  blnUsarMax: Boolean): IMyCampoTabela;
begin
  Result := objMyCampoTabela;
end;

function TTestCore.fCampoTabelaDados(ASQL: String): IMyCampoTabela;
begin
  Result := objMyCampoTabela;
end;

function TTestCore.fCriarQuery: IMyQuery;
begin
  Result := objDataSet.CreateQuery;
end;

function TTestCore.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

function TTestCore.fMskDigitos(intDigitos: Integer): String;
Var
  intContador: Integer;
  strMsk1    : String;
  strMsk2    : String;
begin
  strMsk1 := '#,';
  strMsk2 := '0.';

  For intContador := 1 To intDigitos Do
  Begin
    strMsk1 := strMsk1 + '#';
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;
end;

function TTestCore.fStrToFloat(strValor: String): Double;
begin
  Result := strToFloat(AnsiReplaceStr(strValor,'.',''));
end;

function TTestCore.fCampoTabelaDados(ASQL: String; AParametros: ArrOfString;
  AValores: ArrOfVariant): IMyCampoTabela;
begin
  Result := objMyCampoTabela;
end;

//function TTestCore.fCampoTabelaDados(ASQL, ACodigoDoItem, ACodigoDaAbreviacaoFiscal, AEstado: String): IMyCampoTabela;
//begin
//  Result := objMyCampoTabela;
//end;

function TTestCore.fTabelaExiste(const ANomeTabela: String): Boolean;
begin
  Result := false;
end;

function TTestCore.fTemAliqEcf(fltAliquota: Double;
  const strPatIni: String): Boolean;
begin
  Result := fltAliquota > 0;
end;

class function TTestCore.New: IFunctionsCore;
begin
  Result := Self.Create;
end;

function TTestCore.RetornarTamanhoDoCampoNumeroDoDocumento: Integer;
begin
  Result := 6;
end;

function TTestCore.IfFloatZero(fltValor, fltDefault: Double): Double;
begin
  Result := fltValor;
  If (fFormataFloat(Result, 4) = 0) Then
    Result := fltDefault;
end;

function TTestCore.fArqIni(ReadWrite: Integer; NomChave, NomSecao,
  Conteudo, strNomArq: String): String;
begin
  Result := '';
end;

function TTestCore.fCodigoDaEmpresa: String;
begin
  Result := '001';
end;

function TTestCore.fEmptyStr(strString: String;
  blnTiraCaracEspecial: Boolean): Boolean;
begin
  result := TCoreFuncoes.fEmptyStr(strString, blnTiraCaracEspecial);
end;

function TTestCore.fFloatToSQL(fltValor: Double): String;
begin
  Result := '';
end;

function TTestCore.fRetAutoIncrem(strNomeTabela,
  strCodEmp: String): String;
begin
  Result := '00000000000000010001';
end;

function TTestCore.fRetPrecisaoMargemItem: Integer;
begin
  Result := 2;
end;

function TTestCore.fStrToFloat(strValorUnico: String; fltDefault: real): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
end;

function TTestCore.IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
begin
  Result := System.Math.IfThen(lTest, vExpr1, vExpr2);
end;

function TTestCore.IIF(lTest: Boolean; vExpr1, vExpr2: Variant): Variant;
begin
  Result := vExpr2;

  if not lTest then
    Exit;

  Result := vExpr1
end;

initialization

SetObjCore(TTestCore.New());

end.
