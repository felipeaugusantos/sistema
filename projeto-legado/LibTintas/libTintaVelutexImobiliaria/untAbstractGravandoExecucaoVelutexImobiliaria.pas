{***********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Velutex Imobiliaria *}
{********************************************************************************************PH*}
unit untAbstractGravandoExecucaoVelutexImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoVelutexImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    stlPastas: TStringList;
    stlArquivos: TStringList;

    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);
    function fGetPath(intContador: Integer; intDiretorio: Integer): String;
    function fValidarPath(intContador: Integer; intDiretorio: Integer): Boolean;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
    function GetDataSetDestino(): IDataSet; virtual;
    function GetSqlDestino(): string; virtual; abstract;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; virtual; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet); Virtual; Abstract;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet): Boolean; Virtual; Abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    procedure Animar(const gravando: IGravando);
    class function LimpaTexto(const strTexto: string): string;

    procedure ListarArquivo(strDiretorio: String); {Verifica Quantidade de Arquivos *.XLT}
    function TemAtributo(Attr, Val: Integer): Boolean;
    procedure AtribuirDiretorios(Diretorio: String);
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
  untAutcomTintaFactory, untStrUtils, untADOFactory;

{ TGravandoExecucaoVelutexImobiliariaCores }

procedure TAbstractGravandoExecucaoVelutexImobiliaria.Animar(
  const gravando: IGravando);
begin
  Gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoVelutexImobiliaria.AtribuirDiretorios(
  Diretorio: String);
Var
  F: TSearchRec;
  Retorno: Integer;
begin
  //Inicia a Busca
  Retorno := FindFirst(Diretorio + '\*.*', faAnyFile, F);

  stlPastas.Clear;
  Try
    While Retorno = 0 Do
    Begin
      If (F.Name <> '.') Then
      Begin
        If F.Name <> '..' Then
        Begin
          If TemAtributo(F.Attr, faDirectory) Then
            stlPastas.Add(F.Name);
        End;
      End;
      Retorno := FindNext(F);
    End;
  Finally
  End;
end;

procedure TAbstractGravandoExecucaoVelutexImobiliaria.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
Var
  ThreadCarregar: TThreadCarregar;
begin
  Try
    Try
      threadCarregar := TThreadCarregar.Create(GetDataSetOrigem,
        GetDataSetDestino, strNomeArquivo);

      while not threadCarregar.Terminated do
      begin
        if gravando.Status in [sgCancelado, sgFinalizado] then
        begin
          threadCarregar.Terminate;
          TerminateThread(threadCarregar.Handle, 0);
        end
        else
          Animar(gravando);
      end;

      threadCarregar.WaitFor;
      qryOrigem := threadCarregar.Origem;
      qryDestino := threadCarregar.Destino;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(ThreadCarregar) Then
      FreeAndNil(ThreadCarregar);
  End;
end;

constructor TAbstractGravandoExecucaoVelutexImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('VEL');
  stlPastas := TStringList.Create();
  stlArquivos := TStringList.Create();
  AtribuirDiretorios(Conf.fGet('VELPAT'));
end;

destructor TAbstractGravandoExecucaoVelutexImobiliaria.Destroy;
begin
  inherited;
  FreeAndNil(stlPastas);
  FreeAndNil(stlArquivos);
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('VELPAT') + '\' + stlPastas[intDiretorio] + '\' + stlArquivos[intContador];
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.fValidarPath(intContador,
  intDiretorio: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intContador, intDiretorio)) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery8(strNomeArquivo);
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.GetDataSetOrigem(
  const strNomeArquivo: string): TDataSet;
var
  strArquivo: string;
  stlTabelas: TStringList;
begin
  stlTabelas := nil;
  Result     := nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      strArquivo := strNomeArquivo;
      Result :=  GetAdoQuery(strArquivo);
      GetTabelas(TADOQuery(Result), stlTabelas);
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
    If Assigned(stlTabelas) Then
      FreeAndNil(stlTabelas);
  End;
end;

procedure TAbstractGravandoExecucaoVelutexImobiliaria.GetTabelas(
  const qryOrigem: TADOQuery; const stlTabelas: TStrings);
var
  conOrigem: TADOConnection;
begin
  conOrigem := nil;
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

class function TAbstractGravandoExecucaoVelutexImobiliaria.LimpaTexto(
  const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoVelutexImobiliaria.ListarArquivo(
  strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlArquivos.Clear;
  intContador := FindFirst(strDiretorio + '\*.XLS', faAnyFile, Pesquisa);

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

  End;
end;

function TAbstractGravandoExecucaoVelutexImobiliaria.TemAtributo(Attr,
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
    Self.Filter := strFiltro;
    Self.Filtered := True;
  end;
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
    CoInitializeEx(nil, COINIT_MULTITHREADED);
    Self.dataSetOrigem := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;
end;

end.
