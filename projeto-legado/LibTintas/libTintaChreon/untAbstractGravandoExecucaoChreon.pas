{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Chreon *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoChreon;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

Type
TRegistroChreon = Record
    RecordId: Array [1..9] Of Char;
    ColorId: Array [1..30] Of Char;
    Notation: Array [1..50] Of Char;
    Base: Array [1..10] Of Char;
    Can: Array [1..10] Of Char;
    Product: Array [1..50] Of Char;
    Tinter: Array [1..5] Of Array [1..9] Of Char;
    shot: Array [1..5] Of Array [1..12] Of Char;
    SourceFile: Array [1..20] Of Char;
    Palette: Array [1..150] Of Char;
    FinalVolume: Array [1..12] Of Char;
    Price: Array [1..12] Of Char;
    GenerDate: Array [1..10] Of Char;
    Cost: Array [1..12] Of Char;
    G: Char;
    ColorName: Array [1..50] Of Char;
    IdProdBase: Array [1..10] Of Char;
    IdBase: Array [1..10] Of Char;
    TColor: Array [1..10] Of Char;
    Notes: Array [1..255] Of Char;
  End;

  PRegistroChreon = ^TRegistroChreon;

type
  TAbstractGravandoExecucaoChreon = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    stlArquivos: TStringList;
    arqChreon: TextFile;
    registroChreon: TRegistroChreon;

    procedure CarregarDados;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath : Boolean;
    function GetPath : String;

    function fGetRegistro(strLinha: String): TRegistroChreon;
    function fContaLinhas(strNomArq: String): Integer;
    function fGetString(Chars: String): String;

    function fGetCountUnidades(strProduto: String): Integer;
    function fGetUnidadeEmbalagem(intCont: Integer; strProduto: String): Double;
    function fGetUnidade(intCont: Integer): String;


  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoChreonCores }


procedure TAbstractGravandoExecucaoChreon.CarregarDados;
begin
end;

constructor TAbstractGravandoExecucaoChreon.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CHR');

  stlArquivos := TStringList.Create;
end;

destructor TAbstractGravandoExecucaoChreon.Destroy;
begin
  if Assigned(stlArquivos) then FreeAndNil(stlArquivos);
  inherited;
end;



function TAbstractGravandoExecucaoChreon.fContaLinhas(
  strNomArq: String): Integer;
Var
  Arquivo: TextFile;
begin
  Result := 0;
  AssignFile(Arquivo, strNomArq);
  Reset(Arquivo);

  While Not Eof(Arquivo) Do
  Begin
    Readln(Arquivo);
    Result := Result + 1;
  End;

  CloseFile(Arquivo);
end;

function TAbstractGravandoExecucaoChreon.fFormataAutInc(
  const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoChreon.fGetCountUnidades(
  strProduto: String): Integer;
begin
  Result := 3;

  If strProduto = 'MANTOPLAST HYDRO ONEDAY LUCIDO' Then
    Result := 2
  Else If strProduto = 'MANTOPLAST HYDROONEDAYSATINATO' Then
    Result := 2;
end;

function TAbstractGravandoExecucaoChreon.fGetRegistro(
  strLinha: String): TRegistroChreon;
begin
  Result := PRegistroChreon(strLinha)^;
end;

function TAbstractGravandoExecucaoChreon.fGetString(Chars: String): String;
begin
  Result := Trim(Chars);
end;

function TAbstractGravandoExecucaoChreon.fGetUnidade(intCont: Integer): String;
begin
  If intCont = 1 Then
    Result := 'LT'
  Else If intCont = 2 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

function TAbstractGravandoExecucaoChreon.fGetUnidadeEmbalagem(intCont: Integer;
  strProduto: String): Double;
begin
  Result := 1000;

  If intCont = 1 Then
  Begin
    If Pos('MANTOPLAST', strProduto) > 0 Then
      Result := 750;
  End
  Else If intCont = 2 Then
  Begin
    Result := 5000;

     If Pos('MANTOPLAST', strProduto) > 0 Then
      Result := 3000;
  End
  Else If intCont = 3 Then
  Begin
    Result := 10000;

    If strProduto = 'BR FRAMATON SETA COMFORTLINE' Then
      Result := 14000;
  End;
end;

function TAbstractGravandoExecucaoChreon.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoChreon.fValidaPath: Boolean;
var
  arquivos:  TSearchRec;
  strPath: String;
begin
  Result := True;

  If (Not DirectoryExists(GetPath)) Then
    Result := False;

  If Result And (stlArquivos.Count <= 0) Then
  Begin
    strPath := GetPath;

    If (FindFirst(strPath + '\*.txt', faAnyFile, arquivos) = 0) Then
    Begin
      Repeat
        stlArquivos.Add(strPath  + '\' + arquivos.Name);
      Until (FindNext(arquivos) <> 0);
    End;
    FindClose(arquivos);
  End;
end;

function TAbstractGravandoExecucaoChreon.GetPath: String;
begin
  Result := conf.fGet('PATCHR');
end;

end.
