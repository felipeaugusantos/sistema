unit untAbstractProcessadorGravandoExecucaoArquivosRennerCores;

interface

uses
  untIProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando,
  Variants, ADODB, Uni, Math;

type
  TAbstractProcessadorGravandoExecucaoArquivosRennerCores = class abstract(TInterfacedObject, IProcessadorGravandoExecucaoArquivos)
  protected
    intAuto: Integer;
    function fConverteOncaRenner(const intQtd1, intQtd2, intQtd3: Integer): Double;
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); virtual; abstract;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual; abstract;
    function GetSqlDestino: string; virtual;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); virtual;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; virtual;
    procedure LimparTabelas; virtual;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet); virtual; abstract;
    function fGetNomeGravacao: string; virtual;
    constructor Create(); virtual;
    destructor Destroy; override;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); virtual; abstract;
  end;

implementation

uses
  untFuncTinta, untFuncoesSimples, untDDLFactory;

{ TProcessadorGravandoExecucaoArquivosRennerBases }

constructor TAbstractProcessadorGravandoExecucaoArquivosRennerCores.Create;
begin
  inherited Create;
  Self.intAuto := 0;
end;

destructor TAbstractProcessadorGravandoExecucaoArquivosRennerCores.Destroy;
begin
  pAtualizaProCodAutInc('REI_CADREI', intAuto);
  inherited;
end;

function TAbstractProcessadorGravandoExecucaoArquivosRennerCores.fConverteOncaRenner(const intQtd1, intQtd2, intQtd3: Integer): Double;
begin
  Result := intQtd1 * 30;
  Result := Result + (intQtd2 + IfThen(intQtd3 = 1, 0.5)) * 30 / 48;
end;

function TAbstractProcessadorGravandoExecucaoArquivosRennerCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TAbstractProcessadorGravandoExecucaoArquivosRennerCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsertDelayed('REI_CADREI');
end;

procedure TAbstractProcessadorGravandoExecucaoArquivosRennerCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'REI_CADREI';
end;

function TAbstractProcessadorGravandoExecucaoArquivosRennerCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TAbstractProcessadorGravandoExecucaoArquivosRennerCores.LimparTabelas;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'TRUNCATE TABLE REI_CADREI';
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('Impossivel limpar a tabela %s. [%s: %s]', ['REI_CADREI', E.ClassName, E.Message]);
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.

