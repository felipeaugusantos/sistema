unit untValorPorExtenso;

interface

  function fRetExtensoNumero(Value : String):String;
  function fRetMesExtenso(intMes: Integer): String;  
  function fRetDataExtenso(dtaData: TDateTime; blnComCidade : Boolean = False) : String;
  function fRetDataExtEsp(dtaData: TDateTime; blnComCidade : Boolean = False) : String;
  function fDataExtenso(Data:TDateTime; blnImpCid : Boolean = False; blnImpDiaSemana : Boolean = False): String;
  function fValorPorExtenso(Valor: String): String;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils, StrUtils, DateUtils;

{***********************************}
{* RETORNA MES POR EXTENCO         *}
{********************************DV*}
function fRetMesExtenso(intMes: Integer): String;
begin
	Case intMes Of
  	1:  Result := 'Janeiro';
  	2:  Result := 'Fevereiro';
  	3:  Result := 'Março';
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


function fValorPorExtenso(Valor: String): String;
  Const
    unidade: array[1..19] of string = ('um', 'dois', 'três', 'quatro', 'cinco',
               'seis', 'sete', 'oito', 'nove', 'dez', 'onze',
               'doze', 'treze', 'quatorze', 'quinze', 'dezesseis',
               'dezessete', 'dezoito', 'dezenove');

    centena: array[1..9] of string = ('cento', 'duzentos', 'trezentos',
               'quatrocentos', 'quinhentos', 'seiscentos',
               'setecentos', 'oitocentos', 'novecentos');

    dezena: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta',
               'sessenta', 'setenta', 'oitenta', 'noventa');
    qualificaS: array[0..4] of string = ('', 'mil', 'milhão', 'bilhão', 'trilhão');
    qualificaP: array[0..4] of string = ('', 'mil', 'milhões', 'bilhões', 'trilhões');
  var
    inteiro: Int64;
    resto: real;
    vlrS, s, saux, vlrP, centavos: string;
    n, unid, dez, cent, tam, i: integer;
    umReal, tem: boolean;
    vlr: real;
begin
  vlr := fStrToFloat(Valor);
  if (vlr = 0)then
  begin
    Result := 'zero';
    exit;
  end else if (vlr < 0) then
    vlr := vlr * -1;

  inteiro := trunc(vlr); // parte inteira do valor
  resto := vlr - inteiro; // parte fracionária do valor
  vlrS := inttostr(inteiro);

  if (length(vlrS) > 15) then
  begin
    Result := 'Erro: valor superior a 999 trilhões.';
    exit;
  end;

  s := '';
  centavos := inttostr(round(resto * 100));

  // definindo o extenso da parte inteira do valor
  i := 0;
  umReal := false; tem := false;
  while (vlrS <> '0') do
  begin
    tam := length(vlrS);
    // retira do valor a 1a. parte, 2a. parte, por exemplo, para 123456789:
    // 1a. parte = 789 (centena)
    // 2a. parte = 456 (mil)
    // 3a. parte = 123 (milhões)
    if (tam > 3) then
    begin
      vlrP := copy(vlrS, tam-2, tam);
      vlrS := copy(vlrS, 1, tam-3);
    end
    else
    begin
    // última parte do valor
      vlrP := vlrS;
      vlrS := '0';
    end;
    if (vlrP <> '000')then
    begin
      saux := '';
      if (vlrP = '100') then
      saux := 'cem'
      else
      begin
        n := strtoint(vlrP);        // para n = 371, tem-se:
        cent := n div 100;          // cent = 3 (centena trezentos)
        dez := (n mod 100) div 10;  // dez  = 7 (dezena setenta)
        unid := (n mod 100) mod 10; // unid = 1 (unidade um)
        if (cent <> 0) then
          saux := centena[cent];
        if ((dez <> 0) or (unid <> 0)) then
        begin
          if ((n mod 100) <= 19) then
          begin
            if (length(saux) <> 0) then
              saux := saux + ' e ' + unidade[n mod 100]
            else
              saux := unidade[n mod 100];
          end
          else
          begin
            if (length(saux) <> 0) then
              saux := saux + ' e ' + dezena[dez]
            else
              saux := dezena[dez];
            if (unid <> 0) then
              if (length(saux) <> 0) then
                saux := saux + ' e ' + unidade[unid]
              else
                saux := unidade[unid];
          end;
        end;
      end;
      if ((vlrP = '1') or (vlrP = '001'))then
      begin
        if (i = 0) then // 1a. parte do valor (um real)
          umReal := true
        else
          saux := saux + ' ' + qualificaS[i];
      end
      else if (i <> 0) then
        saux := saux + ' ' + qualificaP[i];
      if (length(s) <> 0) then
        s := saux + ', ' + s
      else
        s := saux;
    end;
    if (((i = 0) or (i = 1)) and (length(s) <> 0)) Then
       tem := true; // tem centena ou mil no valor
    i := i + 1; // próximo qualificador: 1- mil, 2- milhão, 3- bilhão, ...
  end;

  if (length(s) <> 0) then
  begin
    if (umReal)
       then s := s + ' real'
    else if (tem) then
      s := s + ' reais'
    else
      s := s + ' de reais';
  end;
// definindo o extenso dos centavos do valor
  if (centavos <> '0') then // valor com centavos
   begin
    if (length(s) <> 0) then // se não é valor somente com centavos
      s := s + ' e ';
    if (centavos = '1') then
      s := s + 'um centavo'
    else
    begin
      n := strtoint(centavos);
      if (n <= 19) then
       s := s + unidade[n]
      else
      begin                 // para n = 37, tem-se:
        unid := n mod 10;   // unid = 37 % 10 = 7 (unidade sete)
        dez := n div 10;    // dez  = 37 / 10 = 3 (dezena trinta)
        s := s + dezena[dez];
        if (unid <> 0) then
          s := s + ' e ' + unidade[unid];
      end;
      s := s + ' centavos';
    end;
  end;
  Result := AnsiUpperCase(s);
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
function fRetDataExtenso(dtaData: TDateTime; blnComCidade : Boolean = False) : String;
  Var
    intCodCid: Integer;
begin
  Result := '';
  If blnComCidade Then
  Begin
    intCodCid := StrToInt(fRetNomGeral('EMP_CODCID','EMP_CODEMP','CADEMP',fStrToFloat(VS_strCodEmp)));
    Result := Result + fRetNomGeral('CID_NOMCID','CID_CODCID','CADCID',intCodCid) + ', ' ;
  End;
  Result := Result + IntToStr(DayOf(dtaData)) + ' de ';
  Result := Result + fRetMesExtenso(MonthOf(dtaData)) + ' de ';
  Result := Result + IntToStr(YearOf(dtaData));
end;

function fRetDataExtEsp(dtaData: TDateTime; blnComCidade : Boolean = False) : String;
  Var
    intDia : Integer;
    intAno : Integer;
Begin
  intDia := DayOf(dtaData);
  intAno := YearOf(dtaData);

  If blnComCidade Then
    Result := fRetCidEmpresa(VS_strCodEmp) + ', ' + IntToStr(intDia) + ' de ' + FMes_Espano(VS_Date, 0) + ' de ' + IntToStr(intAno)
  Else
    Result := IntToStr(intDia) + ' de ' + FMes_Espano(VS_Date, 0) + ' de ' + IntToStr(intAno);

End;


end.
