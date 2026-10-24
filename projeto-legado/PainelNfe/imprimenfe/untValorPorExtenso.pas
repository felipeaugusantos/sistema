unit untValorPorExtenso;

interface

  function fRetExtensoNumero(Value : String):String;
  function fRetMesExtenso(intMes: Integer): String;  
  function fRetDataExtenso(dtaData: TDateTime) : String;
  function fRetDataExtEsp(dtaData: TDateTime) : String;
  function fDataExtenso(Data:TDateTime; blnImpCid : Boolean = False; blnImpDiaSemana : Boolean = False): String;

implementation

uses SysUtils, StrUtils, DateUtils, untUtil;

Const
  UnidadePor  : Array[0..9] Of String[7] = ('','UM ','DOIS ','TRES ','QUATRO ','CINCO ','SEIS ','SETE ','OITO ','NOVE ');
  DezenaPor   : Array[0..9] Of String[10]= ('','DEZ ','VINTE ','TRINTA ','QUARENTA ','CINQUENTA ','SESSENTA ','SETENTA ','OITENTA ','NOVENTA ');
  CentenaPor  : Array[0..9] Of String[13] = ('','CEM ','DUZENTOS ','TREZENTOS ','QUATROCENTOS ','QUINHENTOS ','SEISCENTOS ','SETECENTOS ','OITOCENTOS ','NOVECENTOS ');

  UnidadeEsp  : Array[0..9] Of String[7] = ('','UN ','DOS ','TRES ','CUATRO ','CINCO ','SEIS ','SIETE ','OCHO ','NUEVE ');
  DezenaEsp   : Array[0..9] Of String[10]= ('','DIEZ ','VEINTE ','TRIENTA ','CUARENTA ','CINCUENTA ','SESSENTA ','SETENTA ','OCHENTA ','NOVENTA ');
  CentenaEsp  : Array[0..9] Of String[13] = ('','CIEN ','DOCIENTOS ','TRESCIENTOS ','CUATROCIENTOS','QUINIENTOS ','SEISCIENTOS ','SETECIENTOS ','OCHOCIENTOS ','NOVECIENTOS ');

  UnidadeIng  : Array[0..9] Of String[7] = ('','ONE ','TWO ','THREE ','FOUR ','FIVE ','SIX ','SEVEN ','EIGHT ','NINE ');
  DezenaIng   : Array[0..9] Of String[10]= ('','TEN ','TWENTY ','THIRTY ','FORTY ','FIFTY ','SIXTY ','SEVENTY ','EIGHTY ','NINETY ');
  CentenaIng  : Array[0..9] Of String[13] = ('','ONE HUNDRED ','TWO HUNDRED ','THREE HUNDRED','FOUR HUNDRED ','FIVE HUNDRED ','SIX HUNDRED ','SEVEN HUNDRED','EIGHT HUNDRED','NINE HUNDRED ');


{********************************************************}
{* ADAPTACAO DA FUNCAO MES() P/ ESPANHOL                *}
{* CASO INTTAM = 1 FORMATA O MES COM 3 DIGITOS EX.: JAN *}
{*****************************************************LU*}
function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
Var
  intMes : Integer;
Const
  arrMes : Array[0..12] Of String[10] = ('','ENERO',
                                            'FEBRERO',
                                            'MARZO',
                                            'ABRIL',
                                            'MAYO',
                                            'JUNIO',
                                            'JULIO',
                                            'AGOSTO',
                                            'SEPTIEMBRE',
                                            'OCTUBRE',
                                            'NOVIEMBRE',
                                            'DICIEMBRE');
Begin
  intMes := MonthOf(dtaData);

  Result := String(arrMes[intMes]);

  If intTam = 1 Then
    Result := copy(Result,1,3);
End;

function fExtUnidade(strS : String; strIdioma: String = 'P') : String;
begin
  If strIdioma = 'P' Then
  	Result := String(UnidadePor[StrToInt(strS[1])]);
  If strIdioma = 'E' Then
  	Result := String(UnidadeEsp[StrToInt(strS[1])]);
  If strIdioma = 'I' Then
  	Result := String(UnidadeIng[StrToInt(strS[1])]);
end;

function fExtDezena(strS : String; strIdioma: String = 'P') : String;
begin
  If strS[1] <> '1' Then
  	If strS[2] <> '0' Then
			If strS[1] <> '0' Then
      Begin
        If strIdioma = 'P' Then
       		Result := String(DezenaPor[StrToInt(strS[1])] + 'E ' + UnidadePor[StrToInt(strS[2])]);
        If strIdioma = 'E' Then
       		Result := String(DezenaEsp[StrToInt(strS[1])] + 'Y ' + UnidadeEsp[StrToInt(strS[2])]);
        If strIdioma = 'I' Then
       		Result := String(DezenaIng[StrToInt(strS[1])] + 'AND ' + UnidadeIng[StrToInt(strS[2])]);
      End
     	Else
      Begin
        If strIdioma = 'P' Then
        	Result := String(UnidadePor[StrToInt(strS[2])]);
        If strIdioma = 'E' Then
        	Result := String(UnidadeEsp[StrToInt(strS[2])]);
        If strIdioma = 'I' Then
        	Result := String(UnidadeIng[StrToInt(strS[2])]);
      End
  	Else
    Begin
      If strIdioma = 'P' Then
        Result := String(DezenaPor[StrToInt(strS[1])]);
      If strIdioma = 'E' Then
        Result := String(DezenaEsp[StrToInt(strS[1])]);
      If strIdioma = 'I' Then
        Result := String(DezenaIng[StrToInt(strS[1])]);
    End
  Else
  {Dezena = 1}
  Begin
    If strIdioma = 'P' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'DEZ ';
        '1' : Result := 'ONZE ';
        '2' : Result := 'DOZE ';
        '3' : Result := 'TREZE ';
        '4' : Result := 'QUATORZE ';
        '5' : Result := 'QUINZE ';
        '6' : Result := 'DEZESSEIS ';
        '7' : Result := 'DEZESSETE ';
        '8' : Result := 'DEZOITO ';
        '9' : Result := 'DEZENOVE ';
      End;
    End;
    If strIdioma = 'E' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'DEIZ ';
        '1' : Result := 'ONCE ';
        '2' : Result := 'DOCE ';
        '3' : Result := 'TRECE ';
        '4' : Result := 'CATORCE ';
        '5' : Result := 'QUINCE ';
        '6' : Result := 'DIECISEIS ';
        '7' : Result := 'DIECISIETE ';
        '8' : Result := 'DIECIOCHO ';
        '9' : Result := 'DIECINUEVE ';
      End;
    End;
    If strIdioma = 'I' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'TEN ';
        '1' : Result := 'ELEVEN ';
        '2' : Result := 'TWELVE ';
        '3' : Result := 'THIRTEEN ';
        '4' : Result := 'FOURTEEN ';
        '5' : Result := 'FIFTEEN ';
        '6' : Result := 'SIXTEEN ';
        '7' : Result := 'SEVENTEEN ';
        '8' : Result := 'EIGHTEEN ';
        '9' : Result := 'NINETEEN ';
      End;
    End;
  End;
end;

function fExt1(strS : String; strIdioma: String = 'P') : String;
Begin

  Case Length(strS) Of
    1 : Result := fExtUnidade(strS[1], strIdioma);
    2 : Result := fExtDezena(strS[1] + strS[2], strIdioma);
    3 : If strS[2] + strS[3] = '00'  Then
        Begin
          If strIdioma = 'P' Then
      			Result := String(CentenaPor[StrToInt(strS[1])]);
          If strIdioma = 'E' Then
      			Result := String(CentenaEsp[StrToInt(strS[1])]);
          If strIdioma = 'I' Then
      			Result := String(CentenaIng[StrToInt(strS[1])]);
        End
  			Else
        Begin
          If strIdioma = 'P' Then
          Begin
            If strS[1] = '1' Then
              Result := 'CENTO E ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaPor[StrToInt(strS[1])]) + 'E ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
          If strIdioma = 'E' Then
          Begin
            If strS[1] = '1' Then
              Result := 'CIENTO Y ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaEsp[StrToInt(strS[1])]) + 'Y ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
          If strIdioma = 'I' Then
          Begin
            If strS[1] = '1' Then
              Result := 'ONE HUNDRED AND ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaIng[StrToInt(strS[1])]) + 'AND ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
        End;
  End;

End;

function fExt2(strS : string; strIdioma: String = 'P') : string;
begin

  If (strIdioma = 'P') Or ((strIdioma = 'E')) Then
  Begin
    Case Length(strS) of
      4 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MIL ' + fExt1(Copy(strS,2,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      5 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MIL ' + fExt1(Copy(strS,3,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      6 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MIL ' + fExt1(Copy(strS,4,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If strIdioma = 'I' Then
  Begin
    Case Length(strS) of
      4 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,2,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      5 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,3,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      6 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,4,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

end;

function fExt3(strS : string; strIdioma: String = 'P') : string;
begin

  If (strIdioma = 'P') Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILHÃO '
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILHÕES '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILHÕES '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If (strIdioma = 'E') Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILLON '
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILLONES '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILLONES '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If strIdioma = 'I' Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILLION '
          Else
            Result := fExt2(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILLIONS '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILLIONS '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

end;

{***********************************}
{* RETORNA MES POR EXTENCO         *}
{********************************DV*}
function fRetMesExtenso(intMes: Integer): String;
begin
	Case intMes Of
  	1:  Result := 'Janeiro';
  	2:  Result := 'Fevereiro';
  	3:  Result := 'Marco';
  	4:  Result := 'Abril';
  	5:  Result := 'Maio';
  	6:  Result := 'Junho';
  	7:  Result := 'Julho';
  	8:  Result := 'Agosto';
  	9:  Result := 'Setembro';
  	10: Result := 'Outubro';
  	11: Result := 'Novembro';
  	12: Result := 'Dezembro';
  End;
end;

{*********************************************************}
{* RETORNA A ESCRITA POR EXTENSO DE UMA VALOR MONETARIO  *}
{******************************************************DV*}
function fRetExtensoNumero(Value : String):String;
  Var
    strInteiro,
    strCentavo : string;
    Len,
    n : Integer;  {Nº de Digitos }
begin

  Value := FloatToStrF(Abs(fStrToFloat(Value)), ffFixed, 12, 2);

	Value := AnsiReplaceStr(Value, '.','');
  Len := Length(Value);
  n := Pos(',', Value);
  {Formatando a Vírgula e os Centavos}
  If n = 0 Then
		Value := Value + ',00'
	Else
		If Len > n + 2 Then
			Delete(Value, n+3, Len-n+2)
		Else
		If Len < n + 2 Then
			Insert(Copy('00', 1, n + 2 - Len) , Value, n + 1);
		If Value = '0,00' Then
		Begin
      Result := '';
      Exit;
    End;
		n := Pos(',', Value);
		strInteiro := Copy(Value, 1, n - 1);
		strCentavo := Copy(Value, n + 1, 2);
		Len := Length(strInteiro);
		Case Len Of
			1 : Result := fExt1(strInteiro);
			2 : Result := fExt1(strInteiro);
			3 : Result := fExt1(strInteiro);
			4 : Result := fExt2(strInteiro);
			5 : Result := fExt2(strInteiro);
			6 : Result := fExt2(strInteiro);
      7 : Result := fExt3(strInteiro);
      8 : Result := fExt3(strInteiro);
      9 : Result := fExt3(strInteiro);
		Else
			Result := Value;
		End;
		If (StrToInt(strInteiro) <> 1) And (StrToInt(strInteiro) <> 0) Then
    	Result := Result + 'REAIS' + ' '
		Else
    	Result := Result + 'REAL' + ' ';
		If strCentavo <> '00' Then
			If StrToInt(strInteiro) <> 0 Then
			Begin
				If strCentavo <> '01' Then
        	Result := Result + 'E ' + fExt1(strCentavo) + 'CENTAVOS'
				Else
        	Result := Result + 'E UM ' + 'CENTAVO'
			End
			Else
			Begin
				If strCentavo <> '01' Then
        	Result := fExt1(strCentavo) + 'CENTAVOS'
				Else
        	Result := 'UM ' + 'CENTAVO';
			End;
end;

{***********************************}
{* RETORNA DIA DA SEMANA           *}
{********************************DV*}
function fDiadaSemana(Data : String) : String;
	Const
  	Semana : Array[1..7] Of String = ('DOM','SEG','TER','QUA','QUI','SEX', 'SAB');
begin
  Result := Semana[DayOfWeek(StrToDate(Data))]
end;

{***********************************}
{* RETORNA UMA DATA POR EXTENSO    *}
{********************************DV*}
function fDataExtenso(Data:TDateTime; blnImpCid : Boolean = False; blnImpDiaSemana : Boolean = False): String;
	Var
	  NoDia : Integer;
  	DiaDaSemana : array [1..7] of String;
  	Dia, Mes, Ano : Word;
begin
  DiaDasemana [1]:= 'Domingo';
  DiaDasemana [2]:= 'Segunda-Feira';
  DiaDasemana [3]:= 'Terça-Feira';
  DiaDasemana [4]:= 'Quarta-Feira';
  DiaDasemana [5]:= 'Quinta-Feira';
  DiaDasemana [6]:= 'Sexta-Feira';
  DiaDasemana [7]:= 'Sábado';
  DecodeDate (Data, Ano, Mes, Dia);
  NoDia := DayOfWeek (Data);
  Result := fExtDezena(fStrZero(IntToStr(Dia), 2)) + ' de ' + fRetMesExtenso(Mes) + ' de ' + fExt2(IntToStr(Ano));
  If blnImpDiaSemana Then
  Begin
    Result := DiaDaSemana[NoDia] + ', ' + Result;
  End;

  If blnImpCid then
  Begin
    Result := '' + Result;
  End;

end;

{********************************}
{* RETORNA DATA POR EXTENSO     *}
{*****************************DV*}
function fRetDataExtenso(dtaData: TDateTime) : String;
begin
  Result := '';
  Result := Result + IntToStr(DayOf(dtaData)) + ' de ';
  Result := Result + fRetMesExtenso(MonthOf(dtaData)) + ' de ';
  Result := Result + IntToStr(YearOf(dtaData));
end;

function fRetDataExtEsp(dtaData: TDateTime) : String;
  Var
    intDia : Integer;
    intAno : Integer;
Begin
  intDia := DayOf(dtaData);
  intAno := YearOf(dtaData);
  Result := IntToStr(intDia) + ' de ' + FMes_Espano(dtaData, 0) + ' de ' + IntToStr(intAno);
End;


end.
