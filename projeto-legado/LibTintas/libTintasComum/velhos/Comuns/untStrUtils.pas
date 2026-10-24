{*********************************************}
{* Classe contendo funções comuns com string *}
{******************************************PH*}
unit untStrUtils;

interface

uses
  StrUtils, SysUtils;

type
  TStrUtils = class(TInterfacedObject)
  public
    class function fEmptyStr(strTexto: String) : Boolean;
    class function fStrZero(Zeros:String; Quant:Integer):String; overload;
    class function fStrZero(Zeros:Integer; Quant:Integer):String; overload;
    class function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    class function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    class function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;

  end;

implementation

{ TStrUtils }

class function TStrUtils.fEmptyStr(strTexto: String): Boolean;
begin
  Result := False;
  strTexto := AnsiReplaceStr(strTexto, #10, '');
  strTexto := AnsiReplaceStr(strTexto, #13, '');
  If AnsiReplaceText(strTexto, ' ', '') = '' Then
    Result := True;
end;

class function TStrUtils.fStrZero(Zeros: String; Quant: Integer): String;
Var
	I: Integer;
  Tamanho: Integer;
begin
  Tamanho := Length(Zeros);
  Result := Zeros;
  Zeros:='';
  
  For I := 1 To Tamanho Do
    If Result[i] <> ',' Then
      Zeros := Zeros + Result[i];

  Tamanho := Length(Zeros);
  Result := Zeros;
  Zeros := '';

  for I := 1 to Quant - Tamanho do
    Zeros := Zeros + '0';

  Result := Zeros + Result;
  fStrZero := Result;
end;


class function TStrUtils.fPadC(strTexto: String; intTamanho: Integer; strCaracter: String): String;
var
  intDir, intEsq: Integer;
  intContador: Integer;
begin
  intTamanho := intTamanho - Length(strTexto);
  intDir := (intTamanho Div 2);
  intEsq := (intTamanho Div 2) + intTamanho Mod 2;

  Result := strTexto;
  For intContador := 1 To intDir Do
    Result := Result + strCaracter;
  For intContador := 1 To intEsq Do
    Result := strCaracter + Result;
end;

class function TStrUtils.fPadL(strTexto: String; intTamanho: Integer; strCaracter: String): String;
var
  intContador: Integer;
begin
  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;

class function TStrUtils.fPadR(strTexto: String; intTamanho: Integer; strCaracter: String): String;
var
  intContador: Integer;
begin
  Result := strTexto;
  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

class function TStrUtils.fStrZero(Zeros, Quant: Integer): String;
begin
  Result := fStrZero(IntToStr(Zeros),Quant);
end;

end.
