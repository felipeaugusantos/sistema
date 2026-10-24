{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta HydronorthImobiliaria *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoHydronorthImobiliaria;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, Variants, System.Win.ComObj;


type
  TAbstractGravandoExecucaoHydronorthImobiliaria = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    Tabelas: TStringList;

    function fValidaPath : Boolean;
    function GetPath : String;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;
    class function LimpaTexto(const strTexto: string): string;
    function  GeraLitroBase(strDescBase: String): Boolean;
    procedure PreencherTabelas();

    //Funções Virtuais
    function GetDataSetDestino(): IDataSet; virtual;
    function GetDataSetOrigem(const strNomeArquivo: string; intTabela: Integer): TDataSet; Virtual;

    //Funções Abstratas
    function GetSqlDestino(): string; virtual; abstract;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings; intTabela: Integer): string; virtual; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmbalagem: Integer); virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; qryDestino: IDataSet; intUnidade: Integer): Boolean; virtual; abstract;

    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet; const strNomeArquivo: string; var qryDestino: IDataSet; intTabela: Integer);
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
  TGetDataSetOrigem =  function (const strNomeArquivo: string; intTabela: Integer): TDataSet of object;
  TGetDataSetDestino = function(): IDataSet of object;

  TThreadCarregar = class(TThread)
  private
    GetDataSetOrigem: TGetDataSetOrigem;
    GetDataSetDestino: TGetDataSetDestino;
    strNomeArquivo: string;
    dataSetOrigem: TDataSet;
    dataSetDestino: IDataSet;
    intTabela: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino;
      const strNomeArquivo: string; intTabela: Integer); reintroduce;
    destructor Destroy; override;

    property Origem: TDataSet read dataSetOrigem;
    property Destino: IDataSet read dataSetDestino;
  end;



implementation

uses
  untAutcomTintaFactory, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory, untADOFactory;

{ TGravandoExecucaoHydronorthImobiliariaCores }


procedure TAbstractGravandoExecucaoHydronorthImobiliaria.Animar(
  const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoHydronorthImobiliaria.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet; intTabela: Integer);
var
  threadCarregar: TThreadCarregar;
begin
  threadCarregar := nil;
  Try
    Try
      threadCarregar := TThreadCarregar.Create(GetDataSetOrigem,
        GetDataSetDestino, strNomeArquivo, intTabela);

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

constructor TAbstractGravandoExecucaoHydronorthImobiliaria.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('HYD');
  If fValidaPath Then
    PreencherTabelas();
end;

destructor TAbstractGravandoExecucaoHydronorthImobiliaria.Destroy;
begin
  inherited;
  If Assigned(Tabelas) Then
    FreeAndNil(Tabelas);
end;

function TAbstractGravandoExecucaoHydronorthImobiliaria.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoHydronorthImobiliaria.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

function TAbstractGravandoExecucaoHydronorthImobiliaria.GeraLitroBase(
  strDescBase: String): Boolean;
begin
  Result := True;

  If strDescBase = 'GRAFIATO LISO' Then
    Result := False;

  If strDescBase = 'GRAFIATO ARTE' Then
    Result := False;

  If strDescBase = 'GRAFIATO RISCADO' Then
    Result := False;
end;

function TAbstractGravandoExecucaoHydronorthImobiliaria.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery8(strNomeArquivo);
end;

function TAbstractGravandoExecucaoHydronorthImobiliaria.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoHydronorthImobiliaria.GetDataSetOrigem(
  const strNomeArquivo: string; intTabela: Integer): TDataSet;
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
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlTabelas, intTabela);
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

function TAbstractGravandoExecucaoHydronorthImobiliaria.GetPath: String;
begin
  Result := conf.fGet('HYDPAT');
end;



procedure TAbstractGravandoExecucaoHydronorthImobiliaria.GetTabelas(
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

class function TAbstractGravandoExecucaoHydronorthImobiliaria.LimpaTexto(
  const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoHydronorthImobiliaria.PreencherTabelas;
Var
  Excel, Sheet: OleVariant;
  intContador: Integer;
begin
  Tabelas := TStringList.Create;
  Tabelas.Clear;

  {*************************}
  {* CRIANDO ARQUIVO EXCEL *}
  {**********************RG*}
  Excel := CreateOleObject('Excel.Application');
  Try
    Excel.Visible := False;
    Excel.WorkBooks.Open(GetPath);
    Sheet := Excel.WorkBooks[ExtractFileName(GetPath)].WorkSheets[1];

    {*****************************}
    {* GRAVA DADOS NO STRINGLIST *}
    {**************************RG*}
    For intContador := 1 To Excel.WorkBooks[1].WorkSheets.Count Do
      Tabelas.Add(Excel.WorkBooks[1].WorkSheets[intContador].Name);
  Finally
    If Not VarIsEmpty(Excel) Then
    Begin
      Excel.Quit;
      Excel := Unassigned;
      Sheet := Unassigned;
    End;
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
  const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string; intTabela: Integer);
begin
  inherited Create(False);

  Self.GetDataSetOrigem := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo := strNomeArquivo;
  Self.IntTabela := IntTabela;
end;

destructor TThreadCarregar.Destroy;
begin
  inherited;
end;

procedure TThreadCarregar.Execute;
begin
  Try
    CoInitializeEx(nil, COINIT_MULTITHREADED);
    Self.dataSetOrigem := GetDataSetOrigem(strNomeArquivo, intTabela);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;
end;

end.
