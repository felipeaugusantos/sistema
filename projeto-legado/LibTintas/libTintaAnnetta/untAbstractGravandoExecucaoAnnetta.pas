{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Annetta *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAnnetta;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, Uni;

type
  TAbstractGravandoExecucaoAnnetta = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoAnnettaCores }


procedure TAbstractGravandoExecucaoAnnetta.CarregarDados;
begin
  stlTables := TStringList.Create;
  stlTables.Add('AFFACOR TD COLEÇÕES');
  stlTables.Add('Affacor TD III');
end;

constructor TAbstractGravandoExecucaoAnnetta.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ANN');
  CarregarDados;
end;

procedure TAbstractGravandoExecucaoAnnetta.CreateConnection(intCont: Integer);
begin
  Conexao := TADOConnection.Create(Nil);
  Conexao.LoginPrompt := False;
  Conexao.ConnectionString := fConnection(intCont);
  Conexao.Open();

  tblArquivo := TADODataSet.Create(Nil);
  tblArquivo.Connection := Conexao;
end;

destructor TAbstractGravandoExecucaoAnnetta.Destroy;
begin
  inherited;
  If Assigned(stlTables) Then FreeAndNil(stlTables);
  If Assigned(Conexao) Then FreeAndNil(Conexao);
  If Assigned(tblArquivo) Then FreeAndNil(tblArquivo);
end;


procedure TAbstractGravandoExecucaoAnnetta.DestroyConnection;
begin
  If Assigned(Conexao) Then FreeAndNil(Conexao);
  If Assigned(tblArquivo) Then FreeAndNil(tblArquivo);
end;

function TAbstractGravandoExecucaoAnnetta.fConnection(intCont: Integer): String;
begin
  Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + fGetPath(intCont) + ';Persist Security Info=False';
end;

function TAbstractGravandoExecucaoAnnetta.fGetPath(intCont: Integer): String;
begin
  If intCont = 0 Then
    Result := Conf.fGet('PATANN')
  Else If intCont = 1 Then
    Result := Conf.fGet('PATTD3');
end;

function TAbstractGravandoExecucaoAnnetta.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAnnetta.fValidaPath(
  intCont: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intCont)) Then
    Result := False;
end;

end.
