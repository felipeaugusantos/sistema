{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoAutoluks;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoAutoluks = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    cdsProd: TUniClientDataSet;
    cdsForm: TUniClientDataSet;
    stlPaths: TStringList;

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
    function fValidaPath: Boolean;
    function GetPath: String;
    function GetEmbalagem(strEmbala: String): Double;
    function fRetCampoProduto(intCont: Integer): String;
    function fFormataCampoProduto(strValor: String; intCont: Integer): String;
    function fCfgTin(strNome: String): String;
    function fUnidadeBase(fltValor: Double): Boolean;
    function fUnidadeExcluida(fltValor: Double): Boolean;
    procedure ListarArquivo(strDiretorio: String);
    function TemAtributo(Attr, Val: Integer): Boolean;
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

{ TGravandoExecucaoAutoluksCores }

procedure TAbstractGravandoExecucaoAutoluks.CarregarDadosPersonalizadas;
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

procedure TAbstractGravandoExecucaoAutoluks.CarregarDadosProdutos;
begin
  //
end;

constructor TAbstractGravandoExecucaoAutoluks.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALK');

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
  strPat210 := '';
  strPat211 := '';

  ListarArquivo(Conf.fGet('ALKPAT'));
end;

destructor TAbstractGravandoExecucaoAutoluks.Destroy;
begin
  if Assigned(cdsProd)  then FreeAndNil(cdsProd);
  if Assigned(cdsForm)  then FreeAndNil(cdsForm);
  if Assigned(stlBases) then FreeAndNil(stlBases);
  if Assigned(cds210)   then FreeAndNil(cds210);
  if Assigned(cds211)   then FreeAndNil(cds211);
  inherited;
end;

function TAbstractGravandoExecucaoAutoluks.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoAutoluks.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoAutoluks.fFormataCampoProduto(
  strValor: String; intCont: Integer): String;
begin
  Result := strValor;
  case intCont of
    1 : Result := AnsiReplaceStr(strValor, '.', '');
    4 : Result := RightStr(strValor, 4);
  end;
end;

function TAbstractGravandoExecucaoAutoluks.fRetCampoProduto(
  intCont: Integer): String;
begin
  Result := '';
  case intCont of
    1 : Result := 'ALK_CODIGO';
    2 : Result := 'ALK_DESCRI';
    3 : Result := 'ALK_REFERE';
    4 : Result := 'ALK_A_N_O_';
    6 : Result := 'ALK_UNIVER';
    7 : Result := 'ALK_MONTAD';
  end;
end;

function TAbstractGravandoExecucaoAutoluks.fUnidadeBase(
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

function TAbstractGravandoExecucaoAutoluks.fUnidadeExcluida(
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

function TAbstractGravandoExecucaoAutoluks.fGetReferencia(strCodBas: String): string;
begin
  Result := '';
end;

function TAbstractGravandoExecucaoAutoluks.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAutoluks.fValidaPath: Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoAutoluks.GetDataSource(
  const qryGen: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(qryGen);
  Result.DataSet := qryGen;
end;

function TAbstractGravandoExecucaoAutoluks.GetEmbalagem(
  strEmbala: String): Double;
begin
  Result := 0.0;
End;

function TAbstractGravandoExecucaoAutoluks.GetPath : String;
begin
  Result := conf.fGet('ALKPAT');
end;

function TAbstractGravandoExecucaoAutoluks.GetUniClient: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
end;

procedure TAbstractGravandoExecucaoAutoluks.ListarArquivo(strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlPaths := TStringList.Create;
  stlPaths.Clear;
  intContador := FindFirst(strDiretorio + '\*.txt', faAnyFile, Pesquisa);

  Try
    While intContador = 0 Do
    Begin
      If TemAtributo(Pesquisa.Attr, faDirectory) Then
      Begin
        If (Pesquisa.Name <> '.') Then
        Begin
          If (Pesquisa.Name <> '..') Then
          Begin
            TempNome := strDiretorio + '\' + Pesquisa.Name;
            ListarArquivo(TempNome);
          End;
        End;
      End
      Else
      Begin
        stlPaths.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally

  End;
end;

function TAbstractGravandoExecucaoAutoluks.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := False;

  If Attr = Val Then
  Begin
    If Val = Val Then
      Result := True;
  End;
end;

end.
