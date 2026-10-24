unit untAbstractProcessadorGravandoExecucaoCalamar;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants, ADODB;

type
  TAbstractProcessadorGravandoExecucaoCalamar = class abstract(TAbstractAdoProcessadorGravandoExecucaoArquivos)
  protected
    conf: IConfTinta;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override; abstract;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override;
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
  untFuncTinta, untADOFactory;

{ TAbstractProcessadorGravandoExecucaoHydronorth }

constructor TAbstractProcessadorGravandoExecucaoCalamar.Create;
begin
  inherited Create();
  conf := fGetConfTinta('CAL');
end;

function TAbstractProcessadorGravandoExecucaoCalamar.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetAccessQuery12(strNomeArquivo);
end;

procedure TAbstractProcessadorGravandoExecucaoCalamar.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('CALPAT');
end;

end.

