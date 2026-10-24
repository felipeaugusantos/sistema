{***********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Alessi  Imobiliaria *}
{********************************************************************************************AC*}
unit untAbstractGravandoExecucaoAlessiImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoAlessiImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;

    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);
    function fFormataAutInc(const intAutInc: Integer): String;
    function fGetNomeArquivo: String;

    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
    function GetDataSetDestino(): IDataSet; virtual;
    function GetSqlDestino(): string; virtual; abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    function GetSqlOrigem(const strNomeArquivo: string;
      const stlTabelas: TStrings): string; virtual; abstract;

    procedure Animar(const gravando: IGravando);
    class function LimpaTexto(const strTexto: string): string;
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
  untAutcomTintaFactory, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory, untADOFactory;

{ TGravandoExecucaoAlessiImobiliariaCores }

procedure TAbstractGravandoExecucaoAlessiImobiliaria.Animar(
  const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoAlessiImobiliaria.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
var
  threadCarregar: TThreadCarregar;
begin
  threadCarregar := nil;
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
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(threadCarregar) then FreeAndNil(threadCarregar);
  End;
end;

constructor TAbstractGravandoExecucaoAlessiImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALE');
end;

destructor TAbstractGravandoExecucaoAlessiImobiliaria.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoAlessiImobiliaria.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoAlessiImobiliaria.fGetNomeArquivo: String;
begin
  Result := conf.fGet('ALEPAT');
end;

function TAbstractGravandoExecucaoAlessiImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAlessiImobiliaria.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoAlessiImobiliaria.GetDataSetOrigem(
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
      Result := GetAdoQuery(strArquivo);
      GetTabelas(TADOQuery(Result), stlTabelas);
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlTabelas);
      TADOQuery(Result).Open;
    Except
      on E: EAbstractError do
      begin
        raise Exception.CreateFmt('[%s] %s', [Self.ClassName, E.Message]);
      end;

      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlTabelas) then FreeAndNil(stlTabelas);
  End;
end;

procedure TAbstractGravandoExecucaoAlessiImobiliaria.GetTabelas(
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
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(conOrigem) then FreeAndNil(conOrigem);
  End;
end;

class function TAbstractGravandoExecucaoAlessiImobiliaria.LimpaTexto(
  const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

function TAbstractGravandoExecucaoAlessiImobiliaria.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery12(strNomeArquivo);
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
