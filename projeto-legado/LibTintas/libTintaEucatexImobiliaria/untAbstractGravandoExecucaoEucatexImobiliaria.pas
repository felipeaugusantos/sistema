{***********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Eucatex Imobiliaria *}
{********************************************************************************************PH*}
unit untAbstractGravandoExecucaoEucatexImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoEucatexImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    Conf: IConfTinta;
    stlArquivos: TStringList;

    function fValidarPath(intContador: Integer): Boolean;
    procedure ListarArquivo(strDiretorio: String); {Verifica Quantidade de Arquivos *.CSV}
    function TemAtributo(Attr, Val: Integer): Boolean;

    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer); virtual; abstract;
    function GetSqlDestino(): string; virtual; abstract;
    procedure IsDeletarRegistros(); virtual; abstract;
    function GetDataSetDestino(): IDataSet; virtual;
    function fContaLinhas(strNomArq: String): Integer; Virtual;
    function fGetPath(intContador: Integer): String; virtual;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fTiraCaracEspeciais(strTexto: String): String;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoEucatexImobiliariaCores }



constructor TAbstractGravandoExecucaoEucatexImobiliaria.Create;
begin
  inherited Create;
  Conf := TAutcomTintaFactory.Get.fGetConfTinta('EUC');
  stlArquivos := TStringList.Create();
  ListarArquivo(Conf.fGet('EUCPAT'));
end;

destructor TAbstractGravandoExecucaoEucatexImobiliaria.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoEucatexImobiliaria.fTiraCaracEspeciais(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';

  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];
  End;

end;

function TAbstractGravandoExecucaoEucatexImobiliaria.fValidarPath(
  intContador: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intContador)) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoEucatexImobiliaria.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

procedure TAbstractGravandoExecucaoEucatexImobiliaria.ListarArquivo(
  strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlArquivos.Clear;
  intContador := FindFirst(strDiretorio + '\*.CSV', faAnyFile, Pesquisa);

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
        stlArquivos.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally
    SysUtils.FindClose(Pesquisa);
  End;
end;

function TAbstractGravandoExecucaoEucatexImobiliaria.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := False;

  If Attr = Val Then
  Begin
    If Val = Val Then
      Result := True;
  End;
end;

function TAbstractGravandoExecucaoEucatexImobiliaria.fContaLinhas(
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


function TAbstractGravandoExecucaoEucatexImobiliaria.fGetPath(
  intContador: Integer): String;
begin
  Result := Conf.fGet('EUCPAT') + '\' + stlArquivos[intContador];
end;

function TAbstractGravandoExecucaoEucatexImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
