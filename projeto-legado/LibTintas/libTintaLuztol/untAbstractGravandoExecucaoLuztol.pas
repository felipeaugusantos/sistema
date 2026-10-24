{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Luztol *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoLuztol;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoLuztol = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    function fValidarPath(): Boolean;
    function fContaLinhas(strNomArq: String): Integer;


    class function LimpaTexto(const strTexto: string): string;
    function LimpaCaracteres(const strTexto: string): string;
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

  TThreaLUZrregar = class(TThread)
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
{ TGravandoExecucaoLuztolCores }


procedure TAbstractGravandoExecucaoLuztol.Animar(const gravando: IGravando);
begin
  Gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoLuztol.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
Var
  ThreaLUZrregar: TThreaLUZrregar;
begin
  ThreaLUZrregar := Nil;
  Try
    Try
      ThreaLUZrregar := TThreaLUZrregar.Create(GetDataSetOrigem,
        GetDataSetDestino, strNomeArquivo);

      While Not ThreaLUZrregar.Terminated Do
      Begin
        If Gravando.Status in [sgCancelado, sgFinalizado] Then
        Begin
          ThreaLUZrregar.Terminate;
          TerminateThread(ThreaLUZrregar.Handle, 0);
        End
        Else
          Animar(Gravando);

        ThreaLUZrregar.WaitFor;
        qryOrigem  := ThreaLUZrregar.Origem;
        qryDestino := ThreaLUZrregar.Destino;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(ThreaLUZrregar) Then FreeAndNil(ThreaLUZrregar);
  End;
end;

constructor TAbstractGravandoExecucaoLuztol.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LUZ');
end;

destructor TAbstractGravandoExecucaoLuztol.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoLuztol.fContaLinhas(
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

function TAbstractGravandoExecucaoLuztol.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoLuztol.fValidarPath(): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoLuztol.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoLuztol.GetDataSetOrigem(
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

procedure TAbstractGravandoExecucaoLuztol.GetTabelas(
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

function TAbstractGravandoExecucaoLuztol.LimpaCaracteres(
  const strTexto: string): string;
begin
  Result := TAutcomTintaFactory.Get.fTiraCaracEspeciaisPonto(strTexto);
end;

class function TAbstractGravandoExecucaoLuztol.LimpaTexto(
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

{ TThreaLUZrregar }

constructor TThreaLUZrregar.Create(const GetDataSetOrigem: TGetDataSetOrigem;
  const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string);
begin
  inherited Create(False);

  Self.GetDataSetOrigem  := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo    := strNomeArquivo;
end;

destructor TThreaLUZrregar.Destroy;
begin
  inherited;
end;

procedure TThreaLUZrregar.Execute;
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
