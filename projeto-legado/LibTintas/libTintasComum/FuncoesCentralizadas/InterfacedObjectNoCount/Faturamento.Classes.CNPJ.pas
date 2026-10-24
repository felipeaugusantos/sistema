unit Faturamento.Classes.CNPJ;

interface

uses
  Uni,
  SysUtils,
  StrUtils,
  Classes;

type

  TCNPJ = class
  private
    class function fTestaCNPJNumerico(ACNPJ: String): Boolean;
    class function fTestaCNPJAlfaNumerico(ACNPJ: String): Boolean;
  public
    class function fTestaCNPJ(ACNPJ: String; ACfgNWCNPJ : Boolean): Boolean;
  end;

implementation


{ TCNPJ }

class function TCNPJ.fTestaCNPJ(ACNPJ: String; ACfgNWCNPJ : Boolean): Boolean;
begin
  If ACfgNWCNPJ  Then
    Result := fTestaCNPJAlfaNumerico(ACNPJ)
  Else
    Result := fTestaCNPJNumerico(ACNPJ);
end;

class function TCNPJ.fTestaCNPJAlfaNumerico(ACNPJ: String): Boolean;
const
  ALFABET_MAI = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ';
  ALFABET_MIN = 'abcdefghijklmnopqrstuvwyxz';
  NUMERAIS    = '0123456789';

var
  Limpo, Base12, DVInformado: string;
  DV1, DV2: Integer;
  I: Integer;

  function ContemCaracter(ACaracter : String; ALista : String) : Boolean;
  begin
    Result := Pos(ACaracter, ALista) > 0;
  end;

  function IsLetterOrDigitChar(C: Char): Boolean;
  begin
    Result := ContemCaracter(C, ALFABET_MAI) Or
              ContemCaracter(C, ALFABET_MIN) Or
              ContemCaracter(C, NUMERAIS);
  end;

  function CharToCNPJValue(C: Char): Integer;
  begin
    C := UpCase(C);

    If ContemCaracter(C, NUMERAIS) Then
      Result := Ord(C) - Ord('0')
    Else If ContemCaracter(C, ALFABET_MAI) Then
      Result := Ord(C) - 48
    Else
      raise Exception.CreateFmt('Caractere inválido no CNPJ: %s', [C]);
  end;

  function CalcularDV(const Base: string): Integer;
  var
    I, Soma, Valor, Peso: Integer;
  begin
    Soma := 0;
    Peso := 2;

    for I := Length(Base) downto 1 do
    begin
      Valor := CharToCNPJValue(Base[I]);
      Soma := Soma + Valor * Peso;
      Inc(Peso);

      if Peso > 9 then
        Peso := 2;
    end;

    Soma := Soma mod 11;

    if (Soma = 0) or (Soma = 1) then
      Result := 0
    else
      Result := 11 - Soma;
  end;

begin
  Limpo := '';
  for I := 1 to Length(ACNPJ) do
    if IsLetterOrDigitChar(ACNPJ[I]) then
      Limpo := Limpo + ACNPJ[I];

  Limpo := UpperCase(Limpo);

  if Length(Limpo) <> 14 then
  begin
    Result := False;
    Exit;
  end;

  Base12 := Copy(Limpo, 1, 12);
  DVInformado := Copy(Limpo, 13, 2);

  DV1 := CalcularDV(Base12);
  DV2 := CalcularDV(Base12 + IntToStr(DV1));

  Result := DVInformado = IntToStr(DV1) + IntToStr(DV2);
end;

class function TCNPJ.fTestaCNPJNumerico(ACNPJ: String): Boolean;
Var
  d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
  Check : String;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  For nCount := 1 To Length( ACNPJ )-2 Do
  Begin
    If Pos( Copy( ACNPJ, nCount, 1 ), '/-.' ) = 0 Then
    Begin
      If xx < 5 Then
      Begin
        fator := 6 - xx;
      End
      Else
      Begin
        fator := 14 - xx;
      End;
      d1 := d1 + StrToIntDef( Copy( ACNPJ, nCount, 1 ), 0) * fator;
      If xx < 6 Then
      Begin
        fator := 7 - xx;
      End
      Else
      Begin
        fator := 15 - xx;
      End;
      d4 := d4 + StrToIntDef( Copy( ACNPJ, nCount, 1 ), 0) * fator;
      xx := xx+1;
    End;
  End;

  resto := (d1 mod 11);
  If resto < 2 then
  Begin
    digito1 := 0;
  End
  Else
  Begin
    digito1 := 11 - resto;
  End;

  d4 := d4 + 2 * digito1;
  resto := (d4 mod 11);

  If resto < 2 then
  Begin
    digito2 := 0;
  End
  Else
  Begin
    digito2 := 11 - resto;
  End;

  Check := IntToStr(Digito1) + IntToStr(Digito2);
  If Check <> copy(ACNPJ,succ(length(ACNPJ)-2),2) Then
  Begin
    Result := False;
  End
  Else
  Begin
    Result := True;
  End;
end;

end.

