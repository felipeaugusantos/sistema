unit untFloatUtils;


interface

uses Shared.Functions.FloatUtils, untFuncoes, System.Math;

type
  TFloatUtils = class(TInterfacedObject, IFloatUtils)
  public
    class function New: IFloatUtils;

    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
    function IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
    function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
    function fRetAutoIncrem(strNomeTabela, strCodEmp : String) : String;
    function fCodigoDaEmpresa : String;


  end;

implementation

{ TFloatUtils}


function TFloatUtils.fCodigoDaEmpresa: String;
begin
  Result := fArqIni(0,'GERAL','CODEMP','');;
end;

function TFloatUtils.fEmptyStr(strString: String;
  blnTiraCaracEspecial: Boolean): Boolean;
begin
  Result := untFuncoes.fEmptyStr(strString, blnTiraCaracEspecial);
end;

function TFloatUtils.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
  Result := untFuncoes.fFormataFloat(fltNumero, intDecimais);
end;

function TFloatUtils.fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
begin
  Result := '';
end;

function TFloatUtils.fStrToFloat(strValorUnico: String;
  fltDefault: real): Double;
begin
  Result := untFuncoes.fStrToFloat(strValorUnico, fltDefault);
end;

function TFloatUtils.IfThen(lTest: Boolean; vExpr1, vExpr2: Double): Double;
begin
  Result := System.Math.IfThen(lTest, vExpr1, vExpr2);

end;

function TFloatUtils.IIF(lTest: Boolean; vExpr1, vExpr2: Variant): Variant;
begin
  result := untFuncoes.IIF(lTest, vExpr1, vExpr2);
end;

class function TFloatUtils.New: IFloatUtils;
begin
  Result := Self.Create;
end;

initialization
  SetObjFloatUtils(TFloatUtils.New());
end.
