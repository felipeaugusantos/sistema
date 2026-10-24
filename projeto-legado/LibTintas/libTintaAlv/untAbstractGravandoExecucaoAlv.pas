{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Alv *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAlv;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoAlv = class(TInterfacedObject, IGravandoExecucaoNome)
  private
  protected
    conf: IConfTinta;
    stlPastas: TStringList;
    stlArquivos: TStringList;

    function fValidarPath(): Boolean;
    function fContaLinhas(strNomArq: String): Integer;


    class function LimpaTexto(const strTexto: string): string;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    procedure Animar(const gravando: IGravando);
    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);
    //Abstract
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; virtual; abstract;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; virtual; abstract;
    function GetSqlDestino(): string; virtual; abstract;
    function fGetPath(): String; virtual; abstract;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); virtual; abstract;
    //Virtuais
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual;
    function GetDataSetDestino(): IDataSet; virtual;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

  TDataSetHelper = Class Helper For TDataSet
  public
    procedure Filtrar(const strFiltro: string);
  end;

  TProcedureGravandoExecucao = procedure (const gravando: IGravando) Of Object;
  TGetDataSetOrigem =  function (const strNomeArquivo: string): TDataSet Of Object;
  TGetDataSetDestino = function(): IDataSet Of Object;

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
  untAutcomTintaFactory, untStrUtils, untADOFactory,
   untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAlvCores }

procedure TAbstractGravandoExecucaoAlv.Animar(const gravando: IGravando);
begin
  Gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoAlv.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
Var
  ThreadCarregar: TThreadCarregar;
begin
  ThreadCarregar := Nil;
  Try
    Try
      ThreadCarregar := TThreadCarregar.Create(GetDataSetOrigem,
        GetDataSetDestino, strNomeArquivo);

      While Not ThreadCarregar.Terminated Do
      Begin
        If Gravando.Status in [sgCancelado, sgFinalizado] Then
        Begin
          ThreadCarregar.Terminate;
          TerminateThread(ThreadCarregar.Handle, 0);
        End
        Else
          Animar(Gravando);

        ThreadCarregar.WaitFor;
        qryOrigem  := ThreadCarregar.Origem;
        qryDestino := ThreadCarregar.Destino;
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

constructor TAbstractGravandoExecucaoAlv.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALV');
  stlPastas := TStringList.Create();
  stlArquivos := TStringList.Create();
end;

destructor TAbstractGravandoExecucaoAlv.Destroy;
begin
  inherited;
  FreeAndNil(stlPastas);
  FreeAndNil(stlArquivos);
end;

function TAbstractGravandoExecucaoAlv.fContaLinhas(
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

function TAbstractGravandoExecucaoAlv.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAlv.fValidarPath(): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoAlv.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoAlv.GetDataSetOrigem(
  const strNomeArquivo: string): TDataSet;
Var
  strArquivo: String;
  stlTabelas: TStringList;
begin
  stlTabelas := Nil;
  Result := Nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      strArquivo := strNomeArquivo;
      Result     := GetAdoQuery(strArquivo);
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlTabelas);
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
    If Assigned(stlTabelas) Then FreeAndNil(stlTabelas);
  End;
end;

procedure TAbstractGravandoExecucaoAlv.GetTabelas(
  const qryOrigem: TADOQuery; const stlTabelas: TStrings);
Var
  conOrigem: TADOConnection;
begin
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
    If Assigned(conOrigem) Then FreeAndNil(conOrigem);
  End;
end;

class function TAbstractGravandoExecucaoAlv.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TDataSetHelper.Filtrar(const strFiltro: string);
begin
  If strFiltro <> Self.Filter Then
  Begin
    Self.Filtered := False;
    Self.Filter   := strFiltro;
    Self.Filtered := True;
  End;
end;

{ TThreadCarregar }

constructor TThreadCarregar.Create(const GetDataSetOrigem: TGetDataSetOrigem;
  const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string);
begin
  inherited Create(False);

  Self.GetDataSetOrigem  := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo    := strNomeArquivo;
end;

destructor TThreadCarregar.Destroy;
begin
  inherited;
end;

procedure TThreadCarregar.Execute;
begin
  Try
    CoInitializeEx(Nil, COINIT_MULTITHREADED);
    Self.DataSetOrigem  := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;
end;

end.
