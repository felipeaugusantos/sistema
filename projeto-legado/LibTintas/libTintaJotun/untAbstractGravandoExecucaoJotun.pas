{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta JOTcolor *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoJotun;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta, Classes;

type
  TAbstractGravandoExecucaoJotun = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    slArquivos: TStringList;
    function GetUnidade(const fltVolume: Double): string;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath : Boolean;
    function GetPath : String;
    procedure ListarArquivo(strDiretorio: String);
    function TemAtributo(Attr, Val: Integer): Boolean;
    function fRetIntArquivo(strPosArq: String): Integer;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

  TDataSetHelper = class helper for TDataSet
  public
    procedure Filtar(const strFiltro: string);
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoJotunCores }

constructor TAbstractGravandoExecucaoJotun.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('JOT');
  ListarArquivo(GetPath);
end;

destructor TAbstractGravandoExecucaoJotun.Destroy;
begin
  If Assigned(slArquivos) Then
    FreeAndNil(slArquivos);
end;

function TAbstractGravandoExecucaoJotun.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoJotun.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoJotun.fRetIntArquivo(
  strPosArq: String): Integer;
Var
  intContador: Integer;
  intResult: Integer;
begin
  intResult := 0;

  For intContador := 0 To slArquivos.Count - 1 Do
  Begin
    If Pos(strPosArq, slArquivos[intContador]) > 0 Then
      Break
    Else
      Inc(intResult);
  End;

  Result := intResult;
end;

function TAbstractGravandoExecucaoJotun.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;


function TAbstractGravandoExecucaoJotun.GetPath: String;
begin
  Result := conf.fGet('PATJOT');
end;

function TAbstractGravandoExecucaoJotun.GetUnidade(const fltVolume: Double): string;
begin
  if RoundTo(fltVolume, -3) <= 0.9 then
    Result := 'LT'
  else if RoundTo(fltVolume, -3) <= 3.6 then
    Result := 'GL'
  else
    Result := 'LA';
end;

procedure TAbstractGravandoExecucaoJotun.ListarArquivo(strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  slArquivos := TStringList.Create;
  slArquivos.Clear;
  intContador := FindFirst(strDiretorio + '\*.xlsx', faAnyFile, Pesquisa);

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
        slArquivos.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally

  End;
end;

function TAbstractGravandoExecucaoJotun.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := False;

  If Attr = Val Then
  Begin
    If Val = Val Then
      Result := True;
  End;
end;

{ TDataSetHelper }

procedure TDataSetHelper.Filtar(const strFiltro: string);
begin
  if strFiltro <> Self.Filter then
  begin
    Self.Filtered := False;
    Self.Filter   := strFiltro;
    Self.Filtered := True;
  end;
end;

end.
