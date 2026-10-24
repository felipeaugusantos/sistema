{***********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Universo Imobiliaria *}
{********************************************************************************************PH*}
unit untAbstractGravandoExecucaoUniverso;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;

type
  TAbstractGravandoExecucaoUniverso = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    arrUnidades: array[0..3] of string;

    intCodSeq: Integer;

   procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);

    function fFormataAutInc(const intAutInc: Integer): String;

    function GetPath: String;
    function fValidarPath: Boolean;
    function fRetQuantidadeRegSheet(OleSheet: OleVariant): Integer;
    procedure Animar(const gravando: IGravando);

    procedure GetArquivosProcessar(stlArquivos: TStringList);
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
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoUniversoCores }

procedure TAbstractGravandoExecucaoUniverso.Animar(
  const gravando: IGravando);
begin
  gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoUniverso.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
begin
end;

constructor TAbstractGravandoExecucaoUniverso.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('UNI');

  arrUnidades[0] := 'LT';
  arrUnidades[1] := 'GL';
  arrUnidades[2] := 'LA';
  arrUnidades[3] := 'QT';
  intCodSeq := 1;
end;

destructor TAbstractGravandoExecucaoUniverso.Destroy;
begin
  inherited;
end;




function TAbstractGravandoExecucaoUniverso.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoUniverso.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoUniverso.fRetQuantidadeRegSheet(
  OleSheet: OleVariant): Integer;
var
  blnFimPlan: Boolean;
begin
  Result := 1;
  blnFimPlan := False;
  While not blnFimPlan Do
  Begin
    Inc(Result);
    If oleSheet.Cells[Result, 1].Text = '' Then
    Begin
      blnFimPlan := True;
      Dec(Result);
    End;
  End;
end;

function TAbstractGravandoExecucaoUniverso.GetPath: String;
begin
  Result := conf.fGet('UNIPAT');
end;


function TAbstractGravandoExecucaoUniverso.fValidarPath: Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;


procedure TAbstractGravandoExecucaoUniverso.GetArquivosProcessar(
  stlArquivos: TStringList);
begin
  stlArquivos.Text := conf.fGet('UNIPAT');
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
