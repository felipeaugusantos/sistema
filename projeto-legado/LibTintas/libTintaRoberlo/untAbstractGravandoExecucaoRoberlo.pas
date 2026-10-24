{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Roberlo *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoRoberlo;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, strUtils, System.Win.ComObj, Variants;


type
  TAbstractGravandoExecucaoRoberlo = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    function GetPath(): String;
    function VerificaPath(): Boolean;

    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet; const strNomeArquivo: string;
      var qryDestino: IDataSet);
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
    function GetDataSetDestino(): IDataSet; virtual;
    function GetSqlDestino(): String; virtual; abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; Virtual;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): String; virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean; Virtual; Abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet); Virtual; Abstract;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    procedure Animar(const gravando: IGravando);
    class function LimpaTexto(const strTexto: string): String;

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

  TProcedureGravandoExecucao = procedure (const gravando: IGravando) of object;
  TGetDataSetOrigem =  function (const strNomeArquivo: string): TDataSet of object;
  TGetDataSetDestino = function(): IDataSet of object;

  TThreadCarregar = class(TThread)
  private
    GetDataSetOrigem: TGetDataSetOrigem;
    GetDataSetDestino: TGetDataSetDestino;
    strNomeArquivo: string;
    dataSetOrigem: TDataSet;
    dataSetDestino: IDataSet;
  protected
    procedure Execute; override;
  public
    constructor Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino;
      const strNomeArquivo: string); reintroduce;
    destructor Destroy; override;

    property Origem: TDataSet read dataSetOrigem;
    property Destino: IDataSet read dataSetDestino;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils,
  untADOFactory;

{ TGravandoExecucaoRoberloCores }


procedure TAbstractGravandoExecucaoRoberlo.Animar(const gravando: IGravando);
begin
  Gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoRoberlo.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
var
  threadCarregar: TThreadCarregar;
begin
  threadCarregar := Nil;
  Try
    Try
      threadCarregar := TThreadCarregar.Create(GetDataSetOrigem,
        GetDataSetDestino, strNomeArquivo);

      While Not ThreadCarregar.Terminated Do
      Begin
        If Gravando.Status In [sgCancelado, sgFinalizado] Then
        Begin
          threadCarregar.Terminate;
          TerminateThread(threadCarregar.Handle, 0);
        End
        Else
          Animar(Gravando);

        threadCarregar.WaitFor;
        qryOrigem := threadCarregar.Origem;
        qryDestino := threadCarregar.Destino;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(ThreadCarregar) Then FreeAndNil(ThreadCarregar);
  End;
end;

constructor TAbstractGravandoExecucaoRoberlo.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ROB');

end;

destructor TAbstractGravandoExecucaoRoberlo.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoRoberlo.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoRoberlo.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery8(strNomeArquivo);
end;

function TAbstractGravandoExecucaoRoberlo.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.Close;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoRoberlo.GetDataSetOrigem(
  const strNomeArquivo: string): TDataSet;
var
  strArquivo: string;
  stlArquivo: TStringList;
begin
  stlArquivo := Nil;
  Result := Nil;
  Try
    Try
      stlArquivo := TStringList.Create;
      strArquivo := strNomeArquivo;
      Result := GetAdoQuery(strArquivo);
      GetTabelas(TADOQuery(Result), stlArquivo);
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlArquivo);
      TADOQuery(Result).Open;
    Except
      On E: EAbstractError Do
      Begin
        Raise Exception.CreateFmt('[%s] %s', [Self.ClassName, E.Message]);
      End;

      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(stlArquivo) Then
      FreeAndNil(stlArquivo);
  End;
end;

function TAbstractGravandoExecucaoRoberlo.GetPath: String;
begin
  Result := Conf.fGet('ROBPAT');
end;

procedure TAbstractGravandoExecucaoRoberlo.GetTabelas(
  const qryOrigem: TADOQuery; const stlTabelas: TStrings);
var
  conOrigem: TADOConnection;
begin
  conOrigem := Nil;
  Try
    Try
      conOrigem := TADOConnection.Create(qryOrigem);
      conOrigem.ConnectionString := qryOrigem.ConnectionString;
      conOrigem.LoginPrompt := False;
      conOrigem.Open();
      conOrigem.GetTableNames(stlTabelas);
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(conOrigem) Then
      FreeAndNil(conOrigem);
  End;
end;

class function TAbstractGravandoExecucaoRoberlo.LimpaTexto(
  const strTexto: string): String;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

function TAbstractGravandoExecucaoRoberlo.VerificaPath: Boolean;
begin
  Result := True;

  If Not FileExists(GetPath) Then
    Result := False;
end;

{ TDataSetHelper }

procedure TDataSetHelper.Filtar(const strFiltro: string);
begin
  If strFiltro <> Self.Filter Then
  Begin
    Self.Filtered := False;
    Self.Filter := strFiltro;
    Self.Filtered := True;
  End;
end;

{ TThreadCarregar }

constructor TThreadCarregar.Create(const GetDataSetOrigem: TGetDataSetOrigem;
  const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string);
begin
  inherited Create(False);

  Self.GetDataSetOrigem := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo := strNomeArquivo;
end;

destructor TThreadCarregar.Destroy;
begin
  inherited;
end;

procedure TThreadCarregar.Execute;
begin
  Try
    CoInitializeEx(Nil, COINIT_MULTITHREADED);
    Self.dataSetOrigem := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;

end;

end.
