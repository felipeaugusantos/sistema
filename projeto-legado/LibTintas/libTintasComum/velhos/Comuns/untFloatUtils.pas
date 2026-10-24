{**********************************************************************}
{* Classes responsável por funções genrais com variavels Double/Float *}
{*******************************************************************PH*}
unit untFloatUtils;

interface

uses
  SysUtils, StrUtils;

type
  TFloatUtils = class(TInterfacedObject)
  public
    class function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    class function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
  end;

implementation

{ TFloatUtils }

class function TFloatUtils.fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fRoundFiveUp(fltNumero, intDecimais);
end;

class function TFloatUtils.fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
var
  intDig: Integer;
  strVal: String;
begin
  strVal := FloatToStr(fltValue);
  intDig := Pos(DecimalSeparator, strVal);

  If intDig > 0 Then
    intDig := Length(MidStr(strVal, intDig + 1, Length(strVal) - intDig));

  If (intDig > 0) And (intDig > intDigits) And (strVal[Length(strVal)] = '5') Then
  Begin
    strVal[Length(strVal)] := '6';
  End;

  Result := StrToFloatDef(FloatToStrF(StrToFloatDef(strVal, 0), ffFixed, 12, intDigits), 0);
end;

end.
