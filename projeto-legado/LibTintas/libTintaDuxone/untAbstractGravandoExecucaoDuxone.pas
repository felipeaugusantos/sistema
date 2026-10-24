{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Duxone  *}
{********************************************************************************AC*}
unit untAbstractGravandoExecucaoDuxone;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet,
  Variants;

type
  TAbstractGravandoExecucaoDuxone = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    conf: IConfTinta;

    function fFormataAutInc(const intAutInc: Integer): String;
    function GetPath: String;

    function fCfgTin(strNome: String): String;

    function fFormataFloatDuxone(strValor: Variant): Double;

    function fRetCampoBas(strCampo: String; intPos: Integer; strLinha: String): Variant;
    function fPosIniBas(intPos: Integer): Integer;
    function fPosDesIni(intPos: Integer): Integer;
    function fPosLinIni(intPos: Integer): Integer;
    function fPosPesIni(intPos: Integer): Integer;
    function fPosTipIni(intPos: Integer): Integer;
    function fPosEmbIni(intPos: Integer): Integer;
    function fPosQtdBas(intPos: Integer): Integer;
    function fRetEmbalagem(strEmbalagem: String): Double;
    function fIgnorarBase(strBase : String) : Boolean;


    function fRetornarStringPosition(strValor : String) : Integer;

    function fRetDataCadastro(strValor : String) : String;



  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoDuxoneCores }

constructor TAbstractGravandoExecucaoDuxone.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DUX');
end;

destructor TAbstractGravandoExecucaoDuxone.Destroy;
begin

  inherited;
end;

function TAbstractGravandoExecucaoDuxone.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoDuxone.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoDuxone.fFormataFloatDuxone(strValor: Variant): Double;
begin
  If strValor = Null Then
    strValor := '0';

  strValor := AnsiReplaceStr(strValor, '.', ',');
  strValor := '0' + strValor;
  strValor := FloatToStr(TAutcomTintaFactory.Get.fStrToFloat(strValor));
  strValor := AnsiReplaceStr(strValor, '-', '');
  Result   := TAutcomTintaFactory.Get.fStrToFloat(strValor);
end;

function TAbstractGravandoExecucaoDuxone.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoDuxone.fIgnorarBase(strBase: String): Boolean;
begin
  Result := Pos(strBase, 'PP901_PP203_PP202_DX5131_PP204_PP701_PP201_PP402_PP503_PP504_PP601_PP501_PP502_PP301_PP302_AXT100_AXT101_AXT102_AXT103_AXT104_AXT105_AXT107') > 0;
end;

function TAbstractGravandoExecucaoDuxone.GetPath: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('PATDUX') + '\brazil_duxone.lst';
end;

function TAbstractGravandoExecucaoDuxone.fPosDesIni(intPos: Integer): Integer;
begin
  Result := 0;

  Case intPos Of
    1  : Result := 559;
    2  : Result := 649;
    3  : Result := 739;
    4  : Result := 829;
    5  : Result := 919;
    6  : Result := 1009;
    7  : Result := 1099;
    8  : Result := 1189;
    9  : Result := 1279;
    10 : Result := 1369;
    11 : Result := 1459;
    12 : Result := 1549;
    13 : Result := 1639;
    14 : Result := 1729;
    15 : Result := 1819;
    16 : Result := 1909;
    17 : Result := 1999;
    18 : Result := 2089;
    19 : Result := 2179;
    20 : Result := 2269;
  End;

end;

function TAbstractGravandoExecucaoDuxone.fPosQtdBas(intPos: Integer): Integer;
  Begin
  	Result := 0;
    Case intPos Of
      1  : Result := 459;
      2  : Result := 549;
      3  : Result := 639;
      4  : Result := 729;
      5  : Result := 819;
      6  : Result := 909;
      7  : Result := 999;
      8  : Result := 1089;
      9  : Result := 1179;
      10 : Result := 1269;
      11 : Result := 1359;
      12 : Result := 1449;
      13 : Result := 1539;
      14 : Result := 1629;
      15 : Result := 1719;
      16 : Result := 1809;
      17 : Result := 1899;
      18 : Result := 1989;
      19 : Result := 2079;
      20 : Result := 2169;
    End;
  End;

function TAbstractGravandoExecucaoDuxone.fPosEmbIni(intPos: Integer): Integer;
begin
  Result := 0;

  Case intPos Of
    1  : Result := 589;
    2  : Result := 679;
    3  : Result := 769;
    4  : Result := 859;
    5  : Result := 949;
    6  : Result := 1039;
    7  : Result := 1129;
    8  : Result := 1219;
    9  : Result := 1309;
    10 : Result := 1499;
    11 : Result := 1589;
    12 : Result := 1579;
    13 : Result := 1669;
    14 : Result := 1759;
    15 : Result := 1849;
    16 : Result := 1939;
    17 : Result := 2029;
    18 : Result := 2119;
    19 : Result := 2209;
    20 : Result := 2399;
  End;

end;

function TAbstractGravandoExecucaoDuxone.fPosIniBas(intPos: Integer): Integer;
begin
  Result := 0;

  Case intPos Of
    1  : Result := 549;
    2  : Result := 639;
    3  : Result := 729;
    4  : Result := 819;
    5  : Result := 909;
    6  : Result := 999;
    7  : Result := 1089;
    8  : Result := 1179;
    9  : Result := 1269;
    10 : Result := 1359;
    11 : Result := 1449;
    12 : Result := 1539;
    13 : Result := 1629;
    14 : Result := 1719;
    15 : Result := 1809;
    16 : Result := 1899;
    17 : Result := 1989;
    18 : Result := 2079;
    19 : Result := 2169;
    20 : Result := 2259;
  End;
end;

function TAbstractGravandoExecucaoDuxone.fPosLinIni(intPos: Integer): Integer;
begin
  Result := 0;

  Case intPos Of
    1  : Result := 624;
    2  : Result := 714;
    3  : Result := 804;
    4  : Result := 894;
    5  : Result := 984;
    6  : Result := 1074;
    7  : Result := 1164;
    8  : Result := 1254;
    9  : Result := 1344;
    10 : Result := 1434;
    11 : Result := 1524;
    12 : Result := 1614;
    13 : Result := 1704;
    14 : Result := 1794;
    15 : Result := 1884;
    16 : Result := 1974;
    17 : Result := 2064;
    18 : Result := 2154;
    19 : Result := 2244;
    20 : Result := 2334;
  End;
end;

function TAbstractGravandoExecucaoDuxone.fPosPesIni(intPos: Integer): Integer;
begin
  Result := 0;

  Case intPos Of
    1  : Result := 599;
    2  : Result := 689;
    3  : Result := 779;
    4  : Result := 869;
    5  : Result := 959;
    6  : Result := 1049;
    7  : Result := 1139;
    8  : Result := 1229;
    9  : Result := 1319;
    10 : Result := 1409;
    11 : Result := 1499;
    12 : Result := 1589;
    13 : Result := 1679;
    14 : Result := 1769;
    15 : Result := 1859;
    16 : Result := 1949;
    17 : Result := 2039;
    18 : Result := 2129;
    19 : Result := 2219;
    20 : Result := 2309;
  End;

end;

function TAbstractGravandoExecucaoDuxone.fPosTipIni(intPos: Integer): Integer;
begin

  Result := 0;

  Case intPos Of
    1  : Result := 559;
    2  : Result := 649;
    3  : Result := 739;
    4  : Result := 829;
    5  : Result := 919;
    6  : Result := 1009;
    7  : Result := 1099;
    8  : Result := 1189;
    9  : Result := 1279;
    10 : Result := 1369;
    11 : Result := 1459;
    12 : Result := 1549;
    13 : Result := 1639;
    14 : Result := 1729;
    15 : Result := 1819;
    16 : Result := 1909;
    17 : Result := 1999;
    18 : Result := 2089;
    19 : Result := 2179;
    20 : Result := 2269;
  End;

end;

function TAbstractGravandoExecucaoDuxone.fRetCampoBas(strCampo: String;
  intPos: Integer; strLinha: String): Variant;
begin
  If strCampo = 'CODBAS' Then
    Result := Trim(Copy(strLinha, fPosIniBas(intPos),10))
  Else If strCampo = 'TIPO__' Then
    Result := Trim(Copy(strLinha, fPosTipIni(intPos),15))
  Else If strCampo = 'LINHA_' Then
    Result := Trim(Copy(strLinha, fPosLinIni(intPos),15))
  Else If strCampo = 'PESESP' Then
    Result := Trim(Copy(strLinha, fPosPesIni(intPos),10))
  Else If strCampo = 'DESBAS' Then
    Result := Trim(Copy(strLinha, fPosDesIni(intPos),30))
  Else If strCampo = 'EMBALA' Then
    Result := Trim(Copy(strLinha, fPosEmbIni(intPos),10))
  Else If strCampo = 'MONTAD' Then
    Result := Trim(Copy(strLinha, 1, 50))
  Else If strCampo = 'CODOEM' Then
    Result := Trim(Copy(strLinha, 51, 40))
  Else If strCampo = 'CODIGO' Then
    Result := Trim(Copy(strLinha, 329 , 6))
  Else If strCampo = 'DESCRI' Then
    Result := Trim(Copy(strLinha, 111, 100))
  Else If strCampo = 'VERSAO' Then
    Result := Trim(Copy(strLinha, 211, 10))
  Else If strCampo = 'ANOINI' Then
    Result := Trim(Copy(strLinha, 321, 4))
  Else If strCampo = 'ANOFIN' Then
    Result := Trim(Copy(strLinha, 225, 4))
  Else If strCampo = 'PAINEL' Then
    Result := Trim(Copy(strLinha, 229, 10))
  Else If strCampo = 'CATEGO' Then
    Result := Trim(Copy(strLinha, 259, 20))
  Else If strCampo = 'ALTERN' Then
    Result := Trim(Copy(strLinha, 349, 2))
  Else If strCampo = 'PAIS' Then
    Result := Trim(Copy(strLinha, 379, 30))
  Else If strCampo = 'VARIAN' Then
    Result := Trim(Copy(strLinha, 309, 10))
  Else If strCampo = 'QUALID' Then
    Result := Trim(Copy(strLinha, 519, 100))
  Else If strCampo = 'INFCOR' Then
    Result := Trim(Copy(strLinha, 419, 30));
end;

function TAbstractGravandoExecucaoDuxone.fRetDataCadastro(strValor: String): String;
Var
  strDia : String;
  strMes : String;
  strAno : String;
begin
  Result := '';

  strDia := Copy(strValor, 1,2);
  strMes := Copy(strValor, 4,3);

  If strToInt(Copy(strValor, 8,2)) > 18 Then
    strAno := '19' + Copy(strValor, 8,2)
  else
    strAno := '20' + Copy(strValor, 8,2);

  If (strMes = 'JAN') Then strMes := '01';
  If (strMes = 'FEB') Then strMes := '02';
  If (strMes = 'MAR') Then strMes := '03';
  If (strMes = 'APR') Then strMes := '04';
  If (strMes = 'MAY') Then strMes := '05';
  If (strMes = 'JUN') Then strMes := '06';
  If (strMes = 'JUL') Then strMes := '07';
  If (strMes = 'AUG') Then strMes := '08';
  If (strMes = 'SEP') Then strMes := '09';
  If (strMes = 'OCT') Then strMes := '10';
  If (strMes = 'NOV') Then strMes := '11';
  If (strMes = 'DEC') Then strMes := '12';

  Result :=(strDia +'/'+ strMes +'/'+ strAno);


end;

function TAbstractGravandoExecucaoDuxone.fRetEmbalagem(
  strEmbalagem: String): Double;
begin
  Result := 0;

  If strEmbalagem = '1 LITRE' Then
    Result := 1000;
end;

function TAbstractGravandoExecucaoDuxone.fRetornarStringPosition(strValor: String): Integer;
Var
  intCont: integer;
begin
  Result := 0;

  For intCont := 1 to Length(strValor) Do
  begin

    If CharInSet(strValor[intCont], ['0'..'9']) Then
    begin
      Result := intCont;
      Exit;
    end;

  end;

end;


end.
