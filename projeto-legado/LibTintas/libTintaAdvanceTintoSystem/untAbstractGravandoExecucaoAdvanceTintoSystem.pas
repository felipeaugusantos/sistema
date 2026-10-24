{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta AdvanceTintoSystem *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAdvanceTintoSystem;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoAdvanceTintoSystem = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    qryCatalisadores: TADOQuery;
    strCatalisadores:String;


    class function LimpaTexto(const strTexto: string): string;
    function fValidaPath : Boolean;
    function GetPath : String; virtual;
    function fGetCatalisadores(): TADOQuery;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    procedure Animar(const gravando: IGravando);
    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);

    //Abstracts
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; virtual; abstract;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; virtual; abstract;
    function GetSqlDestino(): string; virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); virtual; abstract;
    //Virtuais
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
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
  untAutcomTintaFactory, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoAdvanceTintoSystemCores }


procedure TAbstractGravandoExecucaoAdvanceTintoSystem.Animar(
  const gravando: IGravando);
begin
  Gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoAdvanceTintoSystem.CarregarDados(
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

constructor TAbstractGravandoExecucaoAdvanceTintoSystem.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ADT');

  qryCatalisadores := Nil;

  strCatalisadores := Conf.fGet('PATADT');

end;

destructor TAbstractGravandoExecucaoAdvanceTintoSystem.Destroy;
begin
  inherited;
  If Assigned(qryCatalisadores) Then
    FreeAndNil(qryCatalisadores);
end;

function TAbstractGravandoExecucaoAdvanceTintoSystem.fGetCatalisadores: TADOQuery;
begin
  If Not Assigned(qryCatalisadores) Then
  Begin
    qryCatalisadores := TADOTxtFactory.GetTxt12Query(strCatalisadores);
    qryCatalisadores.SQL.Text :=
      '   SELECT DISTINCT                 ' +
      '     I.CODCATALIS                  ' +
      '   FROM                            ' +
      '     INTEGRACAO#CSV AS I,          ' +
      '     BASES#CSV AS B                ' +
      '   WHERE                           ' +
      '     I.CODCATALIS = B.[COD BASE]   ' ;
  End;

  qryCatalisadores.Open;
  Result := qryCatalisadores;
end;

function TAbstractGravandoExecucaoAdvanceTintoSystem.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAdvanceTintoSystem.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;


function TAbstractGravandoExecucaoAdvanceTintoSystem.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoAdvanceTintoSystem.GetDataSetOrigem(
  const strNomeArquivo: string): TDataSet;
Var
  strArquivo:String;
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

function TAbstractGravandoExecucaoAdvanceTintoSystem.GetPath: String;
begin
  Result := conf.fGet('PATADT') + '\Bases.csv';
end;

procedure TAbstractGravandoExecucaoAdvanceTintoSystem.GetTabelas(
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

class function TAbstractGravandoExecucaoAdvanceTintoSystem.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

{ TDataSetHelper }

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
    CoInitializeEx(nil, COINIT_MULTITHREADED);
    Self.dataSetOrigem := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;

end;

end.
