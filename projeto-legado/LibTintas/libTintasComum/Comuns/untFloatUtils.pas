{**********************************************************************}
{* Classes responsável por funções genrais com variavels Double/Float *}
{*******************************************************************PH*}
unit untFloatUtils;

interface

uses
  SysUtils, StrUtils, untAutcomTintaFactory;

type
  TFloatUtils = class(TInterfacedObject)
  public
    class function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    class function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
    class function fFormataFloatLaz(fltValor: Double): Double;
    class function fTruncaFloat(fltNumero: Double; intDecimais: Integer): Double;

  end;

implementation

{ TFloatUtils }

class function TFloatUtils.fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fRoundFiveUp(fltNumero, intDecimais);
end;

class function TFloatUtils.fFormataFloatLaz(fltValor: Double): Double;
var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);

  If Pos(',',strValor) > 0 Then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  Else
    strValor2 := '0';

  if strValor2 >= '5' then
  begin
    strValor2 := Copy(strValor,1,Pos(',',strValor) + 2);
    strValor2 := FormatFloat('###,#0.0',TAutcomTintaFactory.Get.fStrToFloat(strValor2));
    Result := TAutcomTintaFactory.Get.fStrToFloat(strValor2);
  end
  else if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := TAutcomTintaFactory.Get.fStrToFloat(strValor2);
  end;
end;

class function TFloatUtils.fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
var
  intDig: Integer;
  strVal: String;
begin
  strVal := FloatToStr(fltValue);
  intDig := Pos(FormatSettings.DecimalSeparator, strVal);

  If intDig > 0 Then
    intDig := Length(MidStr(strVal, intDig + 1, Length(strVal) - intDig));

  If (intDig > 0) And (intDig > intDigits) And (strVal[Length(strVal)] = '5') Then
  Begin
    strVal[Length(strVal)] := '6';
  End;

  Result := strToFloatDef(FloatToStrF(strToFloatDef(strVal, 0), ffFixed, 12, intDigits), 0);
end;

class function TFloatUtils.fTruncaFloat(fltNumero: Double;
  intDecimais: Integer): Double;
  Var
    strValor: String;
    intPos: Integer;
begin
  strValor := FloatToStrF(fltNumero, ffNumber, 15, intDecimais+2);

  intPos := Pos(',', strValor);
  If intPos > 0 Then
  Begin
    strValor := Copy(strValor, 1, intPos+intDecimais);
  End;
  Result := TAutcomTintaFactory.Get.fStrToFloat(strValor);
end;


end.

