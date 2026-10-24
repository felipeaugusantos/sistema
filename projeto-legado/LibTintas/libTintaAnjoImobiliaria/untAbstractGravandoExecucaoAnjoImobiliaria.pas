{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta AnjoImobiliaria *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoAnjoImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoAnjoImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
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
  untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAnjoImobiliariaCores }

procedure TAbstractGravandoExecucaoAnjoImobiliaria.Animar(
  const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoAnjoImobiliaria.CarregarDados(
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

constructor TAbstractGravandoExecucaoAnjoImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ANJ');
end;

destructor TAbstractGravandoExecucaoAnjoImobiliaria.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoAnjoImobiliaria.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoAnjoImobiliaria.fGetNomeArquivo: String;
begin
  Result := conf.fGet('TXTBRI');
end;

function TAbstractGravandoExecucaoAnjoImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAnjoImobiliaria.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoAnjoImobiliaria.GetDataSetOrigem(
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

procedure TAbstractGravandoExecucaoAnjoImobiliaria.GetTabelas(
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

function TAbstractGravandoExecucaoAnjoImobiliaria.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, False, dtcsAnsi, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IDREGISTRO', dtctText, 13),
      TGenericDefinicaoTxtCampo.Create('SEP', dtctText, 1),
      TGenericDefinicaoTxtCampo.Create('CATALOGO', dtctText, 36),
      TGenericDefinicaoTxtCampo.Create('LINHA', dtctText, 5),
      TGenericDefinicaoTxtCampo.Create('SEP', dtctText, 1),
      TGenericDefinicaoTxtCampo.Create('DESBAS', dtctText, 44),
      TGenericDefinicaoTxtCampo.Create('REFERE', dtctText, 15),
      TGenericDefinicaoTxtCampo.Create('BASE', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('FORM01', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD01', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM02', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD02', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM03', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD03', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM04', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD04', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM05', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD05', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM06', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD06', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM07', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD07', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM08', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD08', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM09', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD09', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM10', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD10', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM11', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD11', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM12', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD12', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM13', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD13', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM14', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD14', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM15', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD15', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM16', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD16', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM17', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD17', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM18', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD18', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM19', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD19', dtctFloat, 10),
      TGenericDefinicaoTxtCampo.Create('FORM20', dtctText, 10),
      TGenericDefinicaoTxtCampo.Create('QTD20', dtctFloat, 10)
  ]));
  strNomeArquivo := definicao.NomeArquivo;
  TADOTxtFactory.Registrar(definicao);
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
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
