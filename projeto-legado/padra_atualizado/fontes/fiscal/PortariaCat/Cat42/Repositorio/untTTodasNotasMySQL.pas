unit untTTodasNotasMySQL;

interface

uses System.Generics.Collections,
     untTRepositorioNotasFiscais,
     untTDadosAbertura,
     untTNotaFiscal;

type
  TTodasNotasMySQL = class
  private
    FRepositorioFiscal: TRepositorioNotasFiscais;
  public
    function fRetTodasNotasFiscaisServicoSintetizadas(abertura: TDadosAbertura; strTipoSintetizacao: String): TObjectList<TNotaFiscalSintetizada>;
    function fRetTodasNotasFiscaisServicoPeriodo(abertura: TDadosAbertura): TObjectList<TNotaFiscal>;
    function fRetTodasNotasFiscaisTransporte(abertura: TDadosAbertura): TObjectList<TNotaFiscal>;
    function fRetTodasNotasFiscaisPeriodos(abertura: TDadosAbertura): TObjectList<TNotaFiscal>;

    constructor create;
    destructor Destroy; override;
  end;

implementation

{ TTodasNotasMySQL }

constructor TTodasNotasMySQL.create;
begin
  FRepositorioFiscal := TRepositorioNotasFiscais.Create;
end;

destructor TTodasNotasMySQL.Destroy;
begin
  FRepositorioFiscal.Free;
  inherited;
end;

function TTodasNotasMySQL.fRetTodasNotasFiscaisPeriodos(abertura: TDadosAbertura): TObjectList<TNotaFiscal>;
begin
  FRepositorioFiscal.blnNaoEnviarCte := abertura.blnNaoEnviarCte;
  Result := FRepositorioFiscal.fRetNotasPorPeriodoDief(abertura.dtaDataInicial,
                                                       abertura.dtaDataFinal,
                                                       abertura.empresa.strCodigo,
                                                       abertura.blnExcluirCFOPUsoConsumo,
                                                       abertura.blnExcluirCFOPServico,
                                                       abertura.blnExcluirNotasFiscaisConsumidor);
end;

function TTodasNotasMySQL.fRetTodasNotasFiscaisServicoPeriodo(abertura: TDadosAbertura): TObjectList<TNotaFiscal>;
begin
  Result := FRepositorioFiscal.fRetNotasServicoTomadoPorPeriodo(abertura.dtaDataInicial,
                                                                abertura.dtaDataFinal,
                                                                abertura.empresa.strCodigo,
                                                                abertura.blnIncluirCFOPSaida);
end;

function TTodasNotasMySQL.fRetTodasNotasFiscaisServicoSintetizadas(abertura: TDadosAbertura; strTipoSintetizacao: String): TObjectList<TNotaFiscalSintetizada>;
begin
  Result := FRepositorioFiscal.fRetNotasServicoSintetizadas(abertura.dtaDataInicial, abertura.dtaDataFinal, abertura.empresa.strCodigo, strTipoSintetizacao);
end;

function TTodasNotasMySQL.fRetTodasNotasFiscaisTransporte(abertura: TDadosAbertura): TObjectList<TNotaFiscal>;
begin
  Result := FRepositorioFiscal.fRetNotasTransportePorPeriodo(abertura.dtaDataInicial, abertura.dtaDataFinal, abertura.empresa.strCodigo);
end;

end.