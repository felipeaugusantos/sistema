{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Inkor *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoInkor;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni;

type
  TAbstractGravandoExecucaoInkor = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Conexao: TADOConnection;
    tblArquivo: TADODataSet;
    stlTables: TStringList;

    function fConnection(intCont: Integer): String;
    procedure CreateConnection(intCont: Integer);
    procedure DestroyConnection();
    function fGetPath(intCont: Integer): String;
    function fValidaPath(intCont: Integer): Boolean;
    procedure CarregarDados;

    procedure ListarArquivo(strDiretorio: String); // Verifica Quantidade de Arquivos {*.MDB}
    function TemAtributo(Attr, Val: Integer): Boolean;

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

{ TGravandoExecucaoInkorCores }


procedure TAbstractGravandoExecucaoInkor.CarregarDados;
begin
end;

constructor TAbstractGravandoExecucaoInkor.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('INK');
  ListarArquivo(Conf.fGet('PATINK'));
end;

procedure TAbstractGravandoExecucaoInkor.CreateConnection(intCont: Integer);
begin
  Conexao := TADOConnection.Create(Nil);
  Conexao.LoginPrompt := False;
  Conexao.ConnectionString := fConnection(intCont);
  Conexao.Open();

  tblArquivo := TADODataSet.Create(Nil);
  tblArquivo.Connection := Conexao;
end;

destructor TAbstractGravandoExecucaoInkor.Destroy;
begin
  inherited;
  If Assigned(stlTables) Then FreeAndNil(stlTables);
  If Assigned(Conexao) Then FreeAndNil(Conexao);
  If Assigned(tblArquivo) Then FreeAndNil(tblArquivo);
end;


procedure TAbstractGravandoExecucaoInkor.DestroyConnection;
begin
  If Assigned(Conexao) Then FreeAndNil(Conexao);
  If Assigned(tblArquivo) Then FreeAndNil(tblArquivo);
end;

function TAbstractGravandoExecucaoInkor.fConnection(intCont: Integer): String;
begin
  Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + fGetPath(intCont) + ';Persist Security Info=False';
end;

function TAbstractGravandoExecucaoInkor.fGetPath(intCont: Integer): String;
begin
  Result := Conf.fGet('PATINK') + '\' + stlTables[intCont];
end;

function TAbstractGravandoExecucaoInkor.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoInkor.fValidaPath(
  intCont: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intCont)) Then
    Result := False;
end;

procedure TAbstractGravandoExecucaoInkor.ListarArquivo(strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlTables := TStringList.Create;
  stlTables.Clear;
  intContador := FindFirst(strDiretorio + '\*.MDB', faAnyFile, Pesquisa);

  Try
    While intContador = 0 Do
    Begin
      If TemAtributo(Pesquisa.Attr, faDirectory) Then
      Begin
        If (Pesquisa.Name <> '.') And (Pesquisa.Name <> '..') Then
        Begin
          TempNome := strDiretorio + '\' + Pesquisa.Name;
          ListarArquivo(TempNome);
        End;
      End
      Else
      Begin
        stlTables.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally

  End;
end;

function TAbstractGravandoExecucaoInkor.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := Attr And Val = Val;
end;

end.
