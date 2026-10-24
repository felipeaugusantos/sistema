unit untAbstractProcessadorGravandoExecucaoHydronorth;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants;

type
  TAbstractProcessadorGravandoExecucaoHydronorth = class abstract(TAbstractAdoProcessadorGravandoExecucaoArquivos)
  protected
    conf: IConfTinta;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override; abstract;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override; abstract;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override; abstract;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override; abstract;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override; abstract;
    function fGetNomeGravacao(): string; override; abstract;
    constructor Create(); virtual;
  end;

implementation

uses
  untFuncTinta;

{ TAbstractProcessadorGravandoExecucaoHydronorth }

constructor TAbstractProcessadorGravandoExecucaoHydronorth.Create;
begin
  inherited Create();
  conf := fGetConfTinta('HYD');
end;

procedure TAbstractProcessadorGravandoExecucaoHydronorth.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('HYDPAT');
end;

end.
