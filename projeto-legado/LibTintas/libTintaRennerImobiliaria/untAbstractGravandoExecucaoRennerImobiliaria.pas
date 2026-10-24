{*********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta RennerImobiliaria *}
{******************************************************************************************AC*}
unit untAbstractGravandoExecucaoRennerImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet;

Type
  TRegistroRennerImobiliaria = Record
    IdSeq:         Array [1..9]  Of Char;
    CorId:         Array [1..30] Of Char;
    NomeCor:       Array [1..50] Of Char;
    IdBase:        Array [1..20] Of Char;
    Base:          Array [1..30] Of Char;
    Embalagem:     Array [1..10] Of Char;
    idProduto:     Array [1..50] Of Char;
    Produto:       Array [1..50] Of Char;
    Corante:       Array [1..6]  Of Array [1..9] Of Char;
    Qtd:           Array [1..6]  Of Array [1..12] Of Char;
    VolumeFinal:   Array [1..12] Of Char;
    Preco:         Array [1..12] Of Char;
    Data:          Array [1..10] Of Char;
    Tabela:        Array [1..15] Of Char;
    NomeCorPT:     Array [1..50] Of Char;
    NomeCorES:     Array [1..50] Of Char;
    Identificador: Array [1..20] Of Char;
  End;

  PRegistroRennerImobiliaria = ^TRegistroRennerImobiliaria;

Type
  TArqIdent = Record
    Id: String;
    Nome: String;
  End;

Type
  TArrArqIdent = Array Of TArqIdent;

type
  TAbstractGravandoExecucaoRennerImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    stlArquivos: TStringList;
    arqRenner: TextFile;

    registroRenner: TRegistroRennerImobiliaria;

    arrArqIdent: TArrArqIdent;

    qryCadBas,
    qryCadEmb,
    qryCadCol,
    qryCadUni: IDataSet;

    function fValidaPath : Boolean;
    function GetPath : String;

    function fContaLinhas(strNomArq: String): Integer;

    function fGetRegistro(strLinha: String): TRegistroRennerImobiliaria;
    function fGetString(Chars: String): String;
    function fGetUnidade(strEmbala: String): String;
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

{ TGravandoExecucaoRennerImobiliariaCores }

constructor TAbstractGravandoExecucaoRennerImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REI');

  stlArquivos := TStringList.Create;
end;

destructor TAbstractGravandoExecucaoRennerImobiliaria.Destroy;
begin
  if Assigned(stlArquivos) then FreeAndNil(stlArquivos);
  inherited;
end;

function TAbstractGravandoExecucaoRennerImobiliaria.fContaLinhas(
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

function TAbstractGravandoExecucaoRennerImobiliaria.fGetRegistro(
  strLinha: String): TRegistroRennerImobiliaria;
begin
  Result := PRegistroRennerImobiliaria(strLinha)^;
end;

function TAbstractGravandoExecucaoRennerImobiliaria.fGetString(
  Chars: String): String;
begin
  Result := Trim(Chars);
end;

function TAbstractGravandoExecucaoRennerImobiliaria.fGetUnidade(
  strEmbala: String): String;
begin
 Result := 'QT';

 If StrToFloat(strEmbala) <= 1200 Then
  Result := 'QT'
 Else If StrToFloat(strEmbala) <= 6000 Then
  Result := 'GL'
 Else If strToFloat(strEmbala) <= 25000 Then
  Result := 'LA';
end;

function TAbstractGravandoExecucaoRennerImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoRennerImobiliaria.fValidaPath : Boolean;
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

function TAbstractGravandoExecucaoRennerImobiliaria.GetPath: String;
begin
  Result := conf.fGet('TXTREI');
end;

end.
