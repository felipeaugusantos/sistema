{********************************************************************************************}
{* Classe abstrata que implementa o b·sico / comum para a geraÁ„o da tinta Standox *}
{********************************************************************************************}
unit untAbstractGravandoExecucaoStandox;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory, Uni,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoStandox = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    conf: IConfTinta;

    function GetPath : String;
    function GetPathEur: String;
    function fValidaPath():Boolean;
    function fValidaPathEurope():Boolean;
    function fRetCampoBas(strCampo: String; intPos: Integer; strLinha: String): Variant;

  public
    qryDestino : IDataSet;

    function fConnectionFdb : TUniConnection;

    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;

    function fRemoveAcento(Str: String): String;
    function fCriaClienteDataSet: TUniClientDataSet;
  end;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoStandoxCores }


constructor TAbstractGravandoExecucaoStandox.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DOX');

end;

destructor TAbstractGravandoExecucaoStandox.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoStandox.GetPath : String;
begin
  Result := conf.fGet('DOXBRA')
end;

function TAbstractGravandoExecucaoStandox.GetPathEur: String;
begin
  Result := conf.fGet('DOXEUR');
end;

function TAbstractGravandoExecucaoStandox.fCriaClienteDataSet: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODPRO';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODBAS';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FATOR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDBAS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDCON';
    DataType := ftFloat;
  End;
  Result.CreateDataSet;
end;

function TAbstractGravandoExecucaoStandox.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoStandox.fConnectionFdb: TUniConnection;
Var
  conf   : IConfTinta;
  Con    : TUniConnection;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('DOX');

  Con := TUniConnection.Create(nil);

  try
    Con.Database     := conf.fGet('DOXPAT');
    Con.Username     := conf.fGet('DOXUSU');
    Con.Password     := conf.fGet('DOXSEN');

    if (conf.fGet('DOXSER') <> 'LOCALHOST' ) then
    begin
      Con.Server       := conf.fGet('DOXSER');
      Con.Port         := conf.fGetInteger('DOXPOR');
    end;

    Con.ProviderName := 'Interbase';
    Con.Connect;

    Result := Con;

  except on e : Exception do
    begin
      Result := Nil;
    end;
  end;

end;

function TAbstractGravandoExecucaoStandox.fRemoveAcento(Str: String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function TAbstractGravandoExecucaoStandox.fRetCampoBas(strCampo: String;
  intPos: Integer; strLinha: String): Variant;
  function fPosIniBas: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:  Result := 449;
      2:  Result := 539;
      3:  Result := 629;
      4:  Result := 719;
      5:  Result := 809;
      6:  Result := 899;
      7:  Result := 989;
      8:  Result := 1079;
      9:  Result := 1169;
      10: Result := 1259;
      11: Result := 1349;
      12: Result := 1439;
      13: Result := 1529;
      14: Result := 1619;
      15: Result := 1709;
      16: Result := 1799;
      17: Result := 1889;
      18: Result := 1979;
      19: Result := 2069;
      20: Result := 2159;
    End;
  End;

  function fPosDesIni: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:  Result := 459;
      2:  Result := 549;
      3:  Result := 639;
      4:  Result := 729;
      5:  Result := 819;
      6:  Result := 909;
      7:  Result := 999;
      8:  Result := 1089;
      9:  Result := 1179;
      10:  Result := 1269;
      11:  Result := 1359;
      12:  Result := 1449;
      13:  Result := 1539;
      14:  Result := 1629;
      15:  Result := 1719;
      16:  Result := 1809;
      17:  Result := 1899;
      18:  Result := 1989;
      19:  Result := 2079;
      20:  Result := 2169;
    End;
  End;

  function fPosLinIni: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:  Result := 524;
      2:  Result := 614;
      3:  Result := 704;
      4:  Result := 794;
      5:  Result := 884;
      6:  Result := 974;
      7:  Result := 1064;
      8:  Result := 1154;
      9:  Result := 1244;
      10: Result := 1334;
      11: Result := 1424;
      12: Result := 1514;
      13: Result := 1604;
      14: Result := 1694;
      15: Result := 1784;
      16: Result := 1874;
      17: Result := 1964;
      18: Result := 2054;
      19: Result := 2144;
      20: Result := 2234;
    End;
  End;

  function fPosPesIni: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:   Result := 499;
      2:   Result := 589;
      3:   Result := 679;
      4:   Result := 769;
      5:   Result := 859;
      6:   Result := 949;
      7:   Result := 1039;
      8:   Result := 1129;
      9:   Result := 1219;
      10:  Result := 1309;
      11:  Result := 1399;
      12:  Result := 1489;
      13:  Result := 1579;
      14:  Result := 1669;
      15:  Result := 1759;
      16:  Result := 1849;
      17:  Result := 1939;
      18:  Result := 2029;
      19:  Result := 2119;
      20:  Result := 2209;
    End;
  End;

  function fPosTipIni: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:  Result := 459;
      2:  Result := 549;
      3:  Result := 639;
      4:  Result := 729;
      5:  Result := 819;
      6:  Result := 909;
      7:  Result := 999;
      8:  Result := 1089;
      9:  Result := 1179;
      10: Result := 1269;
      11: Result := 1359;
      12: Result := 1449;
      13: Result := 1539;
      14: Result := 1629;
      15: Result := 1719;
      16: Result := 1809;
      17: Result := 1899;
      18: Result := 1989;
      19: Result := 2079;
      20: Result := 2169;
    End;
  End;

  function fPosEmbIni: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:  Result := 489;
      2:  Result := 579;
      3:  Result := 669;
      4:  Result := 759;
      5:  Result := 849;
      6:  Result := 939;
      7:  Result := 1029;
      8:  Result := 1119;
      9:  Result := 1209;
      10: Result := 1299;
      11: Result := 1389;
      12: Result := 1479;
      13: Result := 1569;
      14: Result := 1659;
      15: Result := 1749;
      16: Result := 1839;
      17: Result := 1929;
      18: Result := 2019;
      19: Result := 2109;
      20: Result := 2199;
    End;
  End;

  function fPosQtdBas: Integer;
  Begin
    Result := 0;
    Case intPos Of
      1:  Result := 479;
      2:  Result := 569;
      3:  Result := 659;
      4:  Result := 749;
      5:  Result := 839;
      6:  Result := 929;
      7:  Result := 1019;
      8:  Result := 1109;
      9:  Result := 1199;
      10: Result := 1289;
      11: Result := 1379;
      12: Result := 1469;
      13: Result := 1559;
      14: Result := 1649;
      15: Result := 1739;
      16: Result := 1829;
      17: Result := 1919;
      18: Result := 2009;
      19: Result := 2099;
      20: Result := 2189;
    End;
  End;
begin
  //Informacoes Bases
  If strCampo = 'CODBAS' Then
    Result := Trim(Copy(strLinha,fPosIniBas,10))
  Else If strCampo = 'TIPO__' Then
    Result := Trim(Copy(strLinha,fPosTipIni,15))
  Else If strCampo = 'LINHA_' Then
    Result := Trim(Copy(strLinha,fPosLinIni,15))
  Else If strCampo = 'PESESP' Then
    Result := Trim(Copy(strLinha,fPosPesIni,10))
  Else If strCampo = 'DESBAS' Then
    Result := Trim(Copy(strLinha,fPosDesIni,20))
  Else If strCampo = 'EMBALA' Then
    Result := Trim(Copy(strLinha,fPosEmbIni,10))
  Else If strCampo = 'QTDBAS' Then
    Result := Trim(Copy(strLinha,fPosQtdBas,10))

  //Informacoes Cor
  Else If strCampo = 'MONTAD' Then
    Result := Trim(Copy(strLinha,1,50))
  Else If strCampo = 'CODIGO' Then
    Result := Trim(Copy(strLinha,51,10))
  Else If strCampo = 'DESCRI' Then
    Result := Trim(Copy(strLinha,111,100))
  Else If strCampo = 'VERSAO' Then
    Result := Trim(Copy(strLinha,211,10))
  Else If strCampo = 'ANOINI' Then
    Result := Trim(Copy(strLinha,221,4))
  Else If strCampo = 'ANOFIN' Then
    Result := Trim(Copy(strLinha,225,4))
  Else If strCampo = 'PAINEL' Then
    Result := Trim(Copy(strLinha,229,10))
  Else If strCampo = 'CATEGO' Then
    Result := Trim(Copy(strLinha,259,20))
  Else If strCampo = 'PAIS' Then
    Result := Trim(Copy(strLinha,279,30))
  Else If strCampo = 'VARIAN' Then
    Result := Trim(Copy(strLinha,309,10))
  Else If strCampo = 'QUALID' Then
    Result := Trim(Copy(strLinha,319,100))
  Else If strCampo = 'INFCOR' Then
    Result := Trim(Copy(strLinha,419,30));
end;

function TAbstractGravandoExecucaoStandox.fValidaPath: Boolean;
begin
  Result := False;

  If FileExists(GetPath) Then
    Result := True;
end;

function TAbstractGravandoExecucaoStandox.fValidaPathEurope: Boolean;
begin
  Result := False;

  If FileExists(GetPathEur) Then
    Result := True;
end;

end.
