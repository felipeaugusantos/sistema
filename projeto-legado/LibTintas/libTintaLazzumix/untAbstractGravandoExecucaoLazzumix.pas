{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoLazzumix;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoLazzumix = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    cdsProd: TUniClientDataSet;
    cdsForm: TUniClientDataSet;

    qryUpdFor: IDataSet;

    stlBases: TStringList;
    intContador: Integer;
    strCodBas: String;
    strEmbala: String;
    strDesBas: String;
    strPrimeiroCaracter: String;
    intPos: Integer;
    intQtdLin: Integer;

    strCodigo: String;
    strDilCon: String;
    strAnterior: String;
    strLazQua: String;
    strNumBas: String;
    strQtdGra: String;

    fltQtdPro: Double;
    intPosSpc: Integer;

    intIndiceCorrecao: Integer;
    blnGraReg: Boolean;
    fltQtdGra: Double;
    fltValAcu: Double;

    intVolumeProC     : Integer;
    intVolumeProD     : Integer;

    fltValorMinAuxC   : Double;
    fltValorMinAuxD   : Double;

    fltValorAtualAuxC : Double;
    fltValorAtualAuxD : Double;

    fltVolumeC        : Double;
    fltVolumeD        : Double;

    strCampoTabelaC   : String;
    strCampoTabelaD   : String;

    cds210: TUniClientDataSet;
    cds211: TUniClientDataSet;

    dts210: TDataSource;
    dts211: TDataSource;

    arqTxt: TextFile;
    intLinha: Integer;
    strPat210: String;
    strPat211: String;

    conf: IConfTinta;

    function GetUniClient(): TUniClientDataSet;
    function GetDataSource(const qryGen: TDataSet): TDataSource;

    procedure CarregarDadosProdutos;
    procedure CarregarDadosPersonalizadas;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath(Tipo: TTipoCadastro; intPath: Integer = 0): Boolean;
    function GetPath(Tipo: TTipoCadastro; intPath: Integer = 0): String;
    function GetEmbalagem(strEmbala: String): Double;
    function fRetCampoProduto(intCont: Integer): String;
    function fFormataCampoProduto(strValor: String; intCont: Integer): String;
    function fCfgTin(strNome: String): String;
    function fUnidadeBase(fltValor: Double): Boolean;
    function fUnidadeExcluida(fltValor: Double): Boolean;

    function fGetReferencia(strCodBas: String): string;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

Const
  arrUnidadesBase: Array[1..5] Of Double = (1, 660, 675, 800, 4);
  arrUnidadesExcluidas: Array[1..15] Of Double = (0.5, 2, 3, 4, 300,
                                                  1320, 1980, 2640,
                                                  1600, 2400, 3200,
                                                  2700, 337, 1350, 2025);

implementation

uses
  untStrUtils;

{ TGravandoExecucaoLazzumixCores }

procedure TAbstractGravandoExecucaoLazzumix.CarregarDadosPersonalizadas;
begin
  cds210 := GetUniClient;

  cds210.FieldDefs.Add('CODIGO', ftString, 50, False);
  cds210.FieldDefs.Add('DESCRICAO', ftString, 50, False);
  cds210.FieldDefs.Add('ANO', ftString, 4, False);
  cds210.FieldDefs.Add('MONTADORA', ftString, 50, False);
  cds210.FieldDefs.Add('CODIGO UNIVERSAL', ftString, 50, False);
  cds210.FieldDefs.Add('MODELO', ftString, 50, False);
  cds210.FieldDefs.Add('TOTAL_GRAMAS', ftFloat, 0, False);
  cds210.FieldDefs.Add('TOTAL_ML', ftFloat, 0, False);
  cds210.CreateDataSet;
  dts210 := GetDataSource(cds210);

  cds211 := GetUniClient;

  cds211.FieldDefs.Add('CODIGO', ftString, 50, False);
  cds211.FieldDefs.Add('CODIGO_BASE', ftString, 50, False);
  if conf.fGetInteger('LINPER') = 4 then
    cds211.FieldDefs.Add('CODIGO_NOVO', ftString, 50, False);
  cds211.FieldDefs.Add('QUANTIDADE', ftFloat, 0, False);

  cds211.FieldDefs.Add('PESO_ESPECIFICO', ftFloat, 0, False);
  cds211.FieldDefs.Add('PORCENTAGEM', ftFloat, 0, False);
  cds211.FieldDefs.Add('QUANTIDADE_ML', ftFloat, 0, False);
  cds211.FieldDefs.Add('QUANTIDADE_ML_900', ftFloat, 0, False);
  cds211.FieldDefs.Add('QUANTIDADE_900', ftFloat, 0, False);
  cds211.CreateDataSet;
end;

procedure TAbstractGravandoExecucaoLazzumix.CarregarDadosProdutos;
begin
  cdsProd := GetUniClient;
  With cdsProd.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOME';
    DataType := ftString;
    Size     := 255;
  End;
  cdsProd.CreateDataSet;

  cdsForm := GetUniClient;
  With cdsForm.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOME';
    DataType := ftString;
    Size     := 255;
  End;
  cdsForm.CreateDataSet;
end;

constructor TAbstractGravandoExecucaoLazzumix.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('LAZ');

  cdsProd := nil;
  cdsForm := nil;
  cds210  := nil;
  cds211  := nil;

  qryUpdFor := Nil;

  stlBases    := TStringList.Create;
  intContador := 0;
  strCodBas   := '';
  strEmbala   := '';
  strDesBas   := '';
  strPrimeiroCaracter := '';
  intPos      := 0;
  intQtdLin   := 13;

  strCodigo   := '';
  strDilCon   := '';
  strAnterior := '';
  strLazQua   := '';
  strNumBas   := '';
  strQtdGra   := '';
  intIndiceCorrecao := 0;
  blnGraReg   := False;

  fltQtdPro   := 0;
  intPosSpc   := 0;
  fltQtdGra   := 0;
  fltValAcu   := 0;

  intVolumeProC     := 0;
  intVolumeProD     := 0;
  fltValorMinAuxC   := 0;
  fltValorMinAuxD   := 0;
  fltValorAtualAuxC := 0;
  fltValorAtualAuxD := 0;
  fltVolumeC        := 0;
  fltVolumeD        := 0;
  strCampoTabelaC   := '';
  strCampoTabelaD   := '';

  intLinha  := 0;
  strPat210 := conf.fGet('PERSO210');
  strPat211 := conf.fGet('PERSO211');
end;

destructor TAbstractGravandoExecucaoLazzumix.Destroy;
begin
  if Assigned(cdsProd)  then FreeAndNil(cdsProd);
  if Assigned(cdsForm)  then FreeAndNil(cdsForm);
  if Assigned(stlBases) then FreeAndNil(stlBases);
  if Assigned(cds210)   then FreeAndNil(cds210);
  if Assigned(cds211)   then FreeAndNil(cds211);
  inherited;
end;

function TAbstractGravandoExecucaoLazzumix.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoLazzumix.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoLazzumix.fFormataCampoProduto(
  strValor: String; intCont: Integer): String;
begin
  Result := strValor;
  case intCont of
    1 : Result := AnsiReplaceStr(strValor, '.', '');
    4 : Result := RightStr(strValor, 4);
  end;
end;

function TAbstractGravandoExecucaoLazzumix.fRetCampoProduto(
  intCont: Integer): String;
begin
  Result := '';
  case intCont of
    1 : Result := 'MIX_CODIGO';
    2 : Result := 'MIX_DESCRI';
    3 : Result := 'MIX_REFERE';
    4 : Result := 'MIX_A_N_O_';
    6 : Result := 'MIX_UNIVER';
    7 : Result := 'MIX_MONTAD';
  end;
end;

function TAbstractGravandoExecucaoLazzumix.fUnidadeBase(
  fltValor: Double): Boolean;
    Var
      intContador: Integer;
  begin
    Result := False;
    For intContador := Low(arrUnidadesBase) To High(arrUnidadesBase) Do
    Begin
      If TFloatUtils.fFormataFloat(fltValor, 1) = TFloatUtils.fFormataFloat(arrUnidadesBase[intContador], 1) Then
      Begin
        Result := True;
        Break;
      End;
    End;
end;

function TAbstractGravandoExecucaoLazzumix.fUnidadeExcluida(
  fltValor: Double): Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  For intContador := Low(arrUnidadesExcluidas) To High(arrUnidadesExcluidas) Do
  Begin
    If TFloatUtils.fFormataFloat(fltValor, 1) = TFloatUtils.fFormataFloat(arrUnidadesExcluidas[intContador], 1) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TAbstractGravandoExecucaoLazzumix.fGetReferencia(
  strCodBas: String): string;
begin
  Result := '';

  If (LeftStr(strCodBas, 3) = '092') Then
    Result := 'EPOXI IND SHERTRUCK'
  Else If (LeftStr(strCodBas, 3) = '014') Then
    Result := 'FLEET COLOR'
  Else If (LeftStr(strCodBas, 3) = '003') Then
    Result := 'LAZZUCRIL'
  Else If (LeftStr(strCodBas, 3) = '004') Then
    Result := 'LAZZUDUR'
  Else If (LeftStr(strCodBas, 3) = '055') Then
    Result := 'LAZZUDUR PU MS'
  Else If (LeftStr(strCodBas, 3) = '001') Then
    Result := 'LAZZULAC'
  Else If (LeftStr(strCodBas, 3) = '002') Then
    Result := 'LAZZURIL'
  Else If (LeftStr(strCodBas, 3) = '094') Then
    Result := 'LEGACY POLIESTER'
  Else If (LeftStr(strCodBas, 3) = '096') Then
    Result := 'LEGACY PU'
  Else If (LeftStr(strCodBas, 3) = '015') Then
    Result := 'POLIURETANO'
  Else If (LeftStr(strCodBas, 3) = '090') Then
    Result := 'PU P/FROTAS SHERTRUCK'
  Else If (LeftStr(strCodBas, 3) = '083') Then
    Result := 'SHERTRUCKMIX EPOXI'
  Else If (LeftStr(strCodBas, 3) = '089') Then
    Result := 'SHERTRUCKMIX POLIURETANO'
  Else If (LeftStr(strCodBas, 3) = '084') Then
    Result := 'SHERTRUCKMIX PU ACRILICO'
  Else If (LeftStr(strCodBas, 3) = '082') Then
    Result := 'SHERTRUCKMIX SINTETICO'
  Else If (LeftStr(strCodBas, 3) = '091') Then
    Result := 'SINTETICO IND SHERTRUCK'
  Else If (LeftStr(strCodBas, 3) = '041') Then
    Result := 'ULTRA 9K'
  Else If (LeftStr(strCodBas, 3) = '044') Then
    Result := 'ULTRABASE';
end;

function TAbstractGravandoExecucaoLazzumix.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoLazzumix.fValidaPath(
  Tipo: TTipoCadastro; intPath: Integer = 0): Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath(Tipo, intPath))) Then
    Result := False;
end;

function TAbstractGravandoExecucaoLazzumix.GetDataSource(
  const qryGen: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(qryGen);
  Result.DataSet := qryGen;
end;

function TAbstractGravandoExecucaoLazzumix.GetEmbalagem(
  strEmbala: String): Double;
begin
  Result := 0.0;
  strPrimeiroCaracter := LeftStr(strEmbala, 1);

  If  TAutcomTintaFactory.Get.fIsNumber(strPrimeiroCaracter) Then
  Begin
    intPos := Pos(' ', strEmbala)-1;
    If intPos <= 0 Then
      intPos := Length(strEmbala);

    strEmbala := Trim(LeftStr(strEmbala, intPos));
    Result := TAutcomTintaFactory.Get.fStrToFloat(strEmbala) * 1000;
  End
  Else if (strEmbala = 'LITRO') Then
    Result := 1000
  Else if (strEmbala = 'QUARTO') Then
    Result := 900
  Else If (strEmbala = 'FRASCO') Then
  Begin
    Result := 240;
  End
  Else If (strEmbala = 'GALAO') Then
    Result := 3600
  Else If (strEmbala = 'TAMBOR') Then
    Result := 198000;
end;

function TAbstractGravandoExecucaoLazzumix.GetPath(Tipo: TTipoCadastro; intPath: Integer = 0): String;
begin
  Result := '';

  If Tipo = ttBases Then
    Result := conf.fGet('LAZPBA')
  Else  If Tipo = ttGeral Then
  Begin
    If intPath = 1 Then
      Result := conf.fGet('LAZPPR')
    Else If intPath = 2 Then
      Result := conf.fGet('LAZPFO');
  End
  Else If Tipo = ttPersonalizadas Then
  Begin
    If intPath = 1 Then
      Result := conf.fGet('PERSO210')
    Else If intPath = 2 Then
      Result := conf.fGet('PERSO211');
  End;
end;

function TAbstractGravandoExecucaoLazzumix.GetUniClient: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
end;

end.
