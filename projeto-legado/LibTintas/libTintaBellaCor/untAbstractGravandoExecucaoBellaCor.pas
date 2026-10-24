{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta BellaCor *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoBellaCor;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoBellaCor = class(TInterfacedObject, IGravandoExecucaoNome)
  protected

    conf: IConfTinta;
    stlArquivos: TStringList;

    class function LimpaTexto(const strTexto: string): string;
    procedure ListarArquivo(strDiretorio: String); Virtual;{Verifica Quantidade de Arquivos *.CSV}
    function TemAtributo(Attr, Val: Integer): Boolean;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath(intContador: Integer) : Boolean; Virtual;
    function GetPath(intContador: Integer) : String; Virtual;
    function fContaLinhas(strNomArq: String): Integer;

    //Virtuais e Abstracts
    function GetDataSetDestino(): IDataSet; virtual;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList; intArquivo: Integer): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList;  intArquivo: Integer); virtual; abstract;
    function GetSqlDestino(): string; virtual; abstract;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils, untADOFactory,
  untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoBellaCorCores }


constructor TAbstractGravandoExecucaoBellaCor.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BEL');
  stlArquivos := TStringList.Create();
  ListarArquivo(Conf.fGet('PATBEL'));
end;

destructor TAbstractGravandoExecucaoBellaCor.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoBellaCor.fContaLinhas(
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

function TAbstractGravandoExecucaoBellaCor.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoBellaCor.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoBellaCor.fValidaPath(intContador: Integer) : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath(intContador))) Then
    Result := False;
end;


function TAbstractGravandoExecucaoBellaCor.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoBellaCor.GetPath(intContador: Integer): String;
begin
  Result := conf.fGet('PATBEL') + '\' + stlArquivos[intContador];
end;

class function TAbstractGravandoExecucaoBellaCor.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoBellaCor.ListarArquivo(strDiretorio: String);
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

function TAbstractGravandoExecucaoBellaCor.TemAtributo(Attr,
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
