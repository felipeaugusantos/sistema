{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Kresil *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoKresil;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoKresil = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    stlPath: TStringList;

    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);
    function fGetPath(intContador: Integer): String;
    function fValidarPath(intContador: Integer): Boolean;

    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
    function GetDataSetDestino(): IDataSet; virtual;
    function GetSqlDestino(): string; virtual; abstract;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; virtual; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer); Virtual; Abstract;
    function IsRegistroExiste(const qryOrigem: TDataSet; qryDestino: IDataSet; intEmb, intTotEmb: Integer): Boolean; Virtual; Abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);

    procedure Animar(const gravando: IGravando);
    class function LimpaTexto(const strTexto: string): string;

    procedure ListarArquivo(strDiretorio: String); {Verifica Quantidade de Arquivos *.XLT}
    function TemAtributo(Attr, Val: Integer): Boolean;

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

{ TGravandoExecucaoKresilCores }

procedure TAbstractGravandoExecucaoKresil.Animar(const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoKresil.CarregarDados(
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
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    if Assigned(threadCarregar) then FreeAndNil(threadCarregar);
  End;
end;

constructor TAbstractGravandoExecucaoKresil.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('KRE');
  ListarArquivo(Conf.fGet('PATKRE'));
end;

destructor TAbstractGravandoExecucaoKresil.Destroy;
begin
  inherited;
  FreeAndNil(stlPath);
end;

function TAbstractGravandoExecucaoKresil.fGetPath(intContador: Integer): String;
begin
  Result := Conf.fGet('PATKRE') + '\' + stlPath[intContador]
end;

function TAbstractGravandoExecucaoKresil.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoKresil.fValidarPath(
  intContador: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intContador)) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoKresil.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery8(strNomeArquivo);
end;

function TAbstractGravandoExecucaoKresil.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoKresil.GetDataSetOrigem(
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

procedure TAbstractGravandoExecucaoKresil.GetTabelas(const qryOrigem: TADOQuery;
  const stlTabelas: TStrings);
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

class function TAbstractGravandoExecucaoKresil.LimpaTexto(
  const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoKresil.ListarArquivo(strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlPath := TStringList.Create;
  stlPath.Clear;
  intContador := FindFirst(strDiretorio + '\*.XLS', faAnyFile, Pesquisa);

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
        stlPath.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally

  End;
end;

function TAbstractGravandoExecucaoKresil.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := Attr And Val = Val;
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

end.
