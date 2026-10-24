unit untFuncoes;

interface

uses
  Math,
  System.Types, System.SysUtils, System.AnsiStrings, Shared.Functions.Core;

  function fComparaValoresDecimais(fltValor1, fltValor2 : double) : boolean;
  function fRoundFiveUp(const AValue: Double; const ADigits: Integer): Double;
  function fMskDigitos(intDigitos: Integer): String;
  function CompararValores(const AValor1, AValor2: double; const ADigitos: integer = 2): boolean;

implementation

function fComparaValoresDecimais(fltValor1, fltValor2 : double) : boolean;
begin
  Result := Math.CompareValue(fltValor1, fltValor2) = EqualsValue;
end;

function fRoundFiveUp(const AValue: Double; const ADigits: Integer): Double;
var
  LDig: Integer;
  LVal: String;
  i : Integer;
begin

  LVal := FloatToStr(AValue);
  LDig := Pos({$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)} FormatSettings.DecimalSeparator {$ELSE} DecimalSeparator {$IFEND}, LVal);

  If LDig > 0 Then
    LDig := Length(MidStr(AnsiString(LVal), LDig + 1, Length(LVal) - LDig));

  for i := 1 to (LDig - ADigits) do
  begin

    If (LDig > 0) And (LDig > ADigits) And (LVal[Length(LVal)] = '5') Then
    Begin
      LVal[Length(LVal)] := '6';
    End;

    LVal := FloatToStr(objCore.fStrToFloat(FloatToStrF(objCore.fStrToFloat(LVal), ffFixed, 12, LDig - i)));
  End;

  Result := objCore.fStrToFloat(LVal);
end;

{*****************************************}
{* RETORNA MASCARA PARA A FUNÇÃO         *}
{* 'FormatFloat'                         *}
{**************************************MV*}
function fMskDigitos(intDigitos: Integer): String;
  Var
    intContador: Integer;
    strMsk1, strMsk2: String;
begin
  strMsk1 := '#,##';
  strMsk2 := '0.';

  If (intDigitos = 0) Then
    intDigitos := 2;

  For intContador := 1 To intDigitos Do
  Begin
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;

end;

function CompararValores(const AValor1, AValor2: double; const ADigitos: integer = 2): boolean;
var
  LValor1Formatado: Double;
  LValor2Formatado: Double;
  LValor1: string;
  LValor2: string;
  LDiferenca: Double;
begin
  LValor1Formatado := fRoundFiveUp(AValor1, ADigitos);
  LValor2Formatado := fRoundFiveUp(AValor2, ADigitos);

  LValor1 := FormatFloat(fMskDigitos(ADigitos), LValor1Formatado);
  LValor2 := FormatFloat(fMskDigitos(ADigitos), LValor2Formatado);

  LValor1Formatado := objCore.fStrToFloat(LValor1);
  LValor2Formatado := objCore.fStrToFloat(LValor2);

  LDiferenca := fRoundFiveUp(Abs(fRoundFiveUp(LValor1Formatado, ADigitos) - fRoundFiveUp(LValor2Formatado, ADigitos)), ADigitos);
  result := LDiferenca <= objCore.fStrToFloat('0,01');
end;

end.
