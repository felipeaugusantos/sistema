{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Sinteplast *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoSinteplast;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoSinteplast = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    stlPaths: TStringList;
    procedure ListarArquivo(strDiretorio: String);
    function TemAtributo(Attr, Val: Integer): Boolean;
    function GetPath: String;
    function fGetTipoFormula(strCodigo: String; strCodBas: String): String;
    function fGetQtdUnidade(strTipoFormula: String): Integer;
    function fGetQtdProdutos(strTipoFormula: String): Integer;
    function fRetCodBase(strBase: String): String;
    function fRetProduto(intProduto: Integer; strTipoFormula: String): String;
    function fRetProdutoEsmalte(intProduto: Integer): String;
    function fRetProdutoImpermeabilizante(intProduto: Integer): String;
    function fRetProdutoTinta(intProduto: Integer): String;
    function fRetProdutosOutros(strTipoFormula: String; intProduto: Integer): String;


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

    function fRetCodUnidade(intContador: Integer): String;
    function fRetValorEmbalagemGramas(strEmbalagem: String): Double;

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
{ TGravandoExecucaoSinteplastCores }


procedure TAbstractGravandoExecucaoSinteplast.Animar(const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoSinteplast.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
Var
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

constructor TAbstractGravandoExecucaoSinteplast.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SIN');
  ListarArquivo(Conf.fGet('PATSIN'));
end;

destructor TAbstractGravandoExecucaoSinteplast.Destroy;
begin
  inherited;

  If Assigned(stlPaths) Then
    FreeAndNil(stlPaths);
end;

function TAbstractGravandoExecucaoSinteplast.fFormataAutInc(
  const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoSinteplast.fGetNomeArquivo: String;
begin
  Result := conf.fGet('PATSIN');
end;

function TAbstractGravandoExecucaoSinteplast.fGetQtdProdutos(
  strTipoFormula: String): Integer;
begin
  If strTipoFormula = 'E' Then
    Result := 3
  Else If strTipoFormula = 'I' Then
    Result := 2
  Else If strTipoFormula = 'T' Then
    Result := 5
  Else If Pos(strTipoFormula, 'AG_BG_CG_') > 0 Then
    Result := 2
  Else
    Result := 1;
end;

function TAbstractGravandoExecucaoSinteplast.fGetQtdUnidade(
  strTipoFormula: String): Integer;
begin
  If strTipoFormula = 'E' Then
    Result := 2
  Else
    Result := 3;
end;

function TAbstractGravandoExecucaoSinteplast.fGetTipoFormula(
  strCodigo: String; strCodBas: String): String;
begin
  Result := strCodBas;

  If Pos(strCodBas, 'AE_BE_CE_' ) > 0 Then
    Result := 'E'
  Else If Pos(strCodBas, 'AI_BI_CI_' ) > 0 Then
    Result := 'I'
  Else If Pos(strCodBas, 'AT_BT_CT_') > 0 Then
    Result := 'T'
end;

function TAbstractGravandoExecucaoSinteplast.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoSinteplast.fRetCodBase(
  strBase: String): String;
Var
  strBaseCodigo: String;
begin
  strBaseCodigo := Copy(strBase, 1, 1);

  If strBaseCodigo = 'A' Then
    Result := 'BASE A'
  Else If strBaseCodigo = 'B' Then
    Result := 'BASE B'
  Else If strBaseCodigo = 'C' Then
    Result := 'BASE C';
end;

function TAbstractGravandoExecucaoSinteplast.fRetCodUnidade(intContador: Integer): String;
begin
  Result := 'LT';

  If intContador = 2 Then
    Result := 'GL'
  Else If intContador = 3 Then
    Result := 'LA';
end;

function TAbstractGravandoExecucaoSinteplast.fRetProduto(intProduto: Integer;
  strTipoFormula: String): String;
begin
  If strTipoFormula = 'E' Then
    Result := fRetProdutoEsmalte(intProduto)
  Else If strTipoFormula = 'I' Then
    Result := fRetProdutoImpermeabilizante(intProduto)
  Else If strTipoFormula = 'T' Then
    Result := fRetProdutoTinta(intProduto)
  Else
    Result := fRetProdutosOutros(strTipoFormula, intProduto);
end;

function TAbstractGravandoExecucaoSinteplast.fRetProdutoEsmalte(
  intProduto: Integer): String;
begin
  If intProduto = 1 Then
    Result := 'ESMALTE AGUA PINTAR + RAPIDO BRILHANTE'
  Else If intProduto = 2 Then
    Result := 'ESMALTE DUPLA ACAO BRILHANTE'
  Else
    Result := 'ESMALTE SULAN BRILHANTE';
end;

function TAbstractGravandoExecucaoSinteplast.fRetProdutoImpermeabilizante(
  intProduto: Integer): String;
begin
  If intProduto = 1 Then
    Result := 'RECUBRIPLAST PAREDES E MUROS'
  Else
    Result := 'RECUBRIPLAST FLEXIVEL';
end;

function TAbstractGravandoExecucaoSinteplast.fRetProdutosOutros(
  strTipoFormula: String; intProduto: Integer): String;
begin
  If Pos(strTipoFormula, 'AF_BF_CF_') > 0 Then
    Result := 'PINTAR + PERFEITO FOSCO'
  Else
  Begin
    If intProduto = 1 Then
      Result := 'PINTAR + PERFEITO ACETINADO'
    Else
      Result := 'PINTAR + PERFEITO SEMI BRILHO';
  End;
end;

function TAbstractGravandoExecucaoSinteplast.fRetProdutoTinta(
  intProduto: Integer): String;
begin
  If intProduto = 1 Then
    Result := 'PINTAR + PERFEITO FOSCO'
  Else If intProduto = 2 Then
    Result := 'PINTAR + PERFEITO ACETINADO'
  Else If intProduto = 3 Then
    Result := 'PINTAR + PERFEITO SEMI BRILHO'
  Else If intProduto = 4 Then
    Result := 'SULANMAX FOSCO'
  Else
    Result := 'ACRILPLAST FOSCO';
end;

function TAbstractGravandoExecucaoSinteplast.fRetValorEmbalagemGramas(strEmbalagem: String): Double;
begin
  Result := 800;

  If strEmbalagem = 'GL' Then
    Result := 3200
  Else If strEmbalagem = 'LA' Then
    Result := 16000
end;

function TAbstractGravandoExecucaoSinteplast.GetAdoQuery(
  var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetExcelQuery12NoHeader(strNomeArquivo);
end;

function TAbstractGravandoExecucaoSinteplast.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoSinteplast.GetDataSetOrigem(
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

function TAbstractGravandoExecucaoSinteplast.GetPath: String;
begin
  Result := conf.fGet('PATSIN');
end;

procedure TAbstractGravandoExecucaoSinteplast.GetTabelas(
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

class function TAbstractGravandoExecucaoSinteplast.LimpaTexto(
  const strTexto: string): string;
begin
  Result := Trim(AnsiUpperCase(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoSinteplast.ListarArquivo(strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  stlPaths := TStringList.Create;
  stlPaths.Clear;
  intContador := FindFirst(strDiretorio + '\*.txt', faAnyFile, Pesquisa);

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
        stlPaths.Add(Pesquisa.Name);
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally

  End;
end;

function TAbstractGravandoExecucaoSinteplast.TemAtributo(Attr,
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
