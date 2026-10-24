unit untTDadosAbertura;

interface

uses
  {$IFDEF MSWINDOWS}
  Vcl.ComCtrls,
  StdCtrls,
  Gauges,
  {$ENDIF}
  untTypesSistema,
  untTEmpresa,
  untTNotaFiscal;

Type
  TIncidenciaTributaria = (itCumulativo, itNaoCumulativo, itAliquotaDiferenciada);

  TDadosAbertura = class(TObject)
    private
      FIncidenciaTributaria: TIncidenciaTributaria;
      FExcluirCFOPUsoConsumo: Boolean;
      FExcluirCFOPServico: Boolean;
      FExcluirNotasFiscaisConsumidor: Boolean;
      FMesAnoSaldoCredorPeriodoAnterior: string;
      FDeducoes: string;
      FOutrosCreditos: string;
      FEstornoDebitos: string;
      FOutrosDebitos: string;
      FOutrosEstornosCreditos: string;
      FCreditosRecolhimentoICMSAntecipadoEspecial: string;
      FIncluirCFOPSaida: Boolean;
      FTabelaInventario: string;
      FDataInicial: TDateTime;
      FDataFinal: TDateTime;
      FEmpresa: TEmpresa;
      {$IFDEF MSWINDOWS}
      FLabelOperacao: TLabel;
      FProgresso: TGauge;
      FProgressoBar: TProgressBar;
      {$ENDIF}
      FDataVencto: TDateTime;
      FCodigoReceita: String;
      FCampoPrecoEstoque: integer;
      FDataInventario: TDateTime;
      FNaoEnviarCte: Boolean;
      FNotaFiscal: TNotaFiscal;
      FInconsistencia: boolean;
  public
      constructor Create(dtaDataInicial, dtaDataFinal: TDateTime; strEmpresaSelecionada: String; intIndicePrecoEstoque: integer = 0);
      destructor Destroy; override;

      property blnNaoEnviarCte: Boolean read FNaoEnviarCte write FNaoEnviarCte;
      property incidenciaTributaria: TIncidenciaTributaria read FIncidenciaTributaria write FIncidenciaTributaria;
      property blnExcluirCFOPUsoConsumo: boolean read FExcluirCFOPUsoConsumo write FExcluirCFOPUsoConsumo;
      property blnExcluirCFOPServico: boolean read FExcluirCFOPServico write FExcluirCFOPServico;
      property blnExcluirNotasFiscaisConsumidor: boolean read FExcluirNotasFiscaisConsumidor write FExcluirNotasFiscaisConsumidor;
      property strMesAnoSaldoCredorPeriodoAnterior: string read FMesAnoSaldoCredorPeriodoAnterior write FMesAnoSaldoCredorPeriodoAnterior;
      property strDeducoes: string read FDeducoes write FDeducoes;
      property strOutrosCreditos: string read FOutrosCreditos write FOutrosCreditos;
      property strEstornoDebitos: string read FEstornoDebitos write FEstornoDebitos;
      property strOutrosDebitos: string read FOutrosDebitos write FOutrosDebitos;
      property strOutrosEstornosCreditos: string read FOutrosEstornosCreditos write FOutrosEstornosCreditos;
      property strCreditosRecolhimentoICMSAntecipadoEspecial: string read FCreditosRecolhimentoICMSAntecipadoEspecial write FCreditosRecolhimentoICMSAntecipadoEspecial;
      property blnIncluirCFOPSaida: boolean read FIncluirCFOPSaida write FIncluirCFOPSaida;
      property strTabelaInventario: string read FTabelaInventario write FTabelaInventario;
      property dtaDataInicial: TDateTime read FDataInicial write FDataInicial;
      property dtaDataFinal: TDateTime read FDataFinal write FDataFinal;
      property empresa: TEmpresa read FEmpresa write FEmpresa;
      {$IFDEF MSWINDOWS}
      property lblOperacao: TLabel read FLabelOperacao write FLabelOperacao;
      property progressoBar: TProgressBar read FProgressoBar write FProgressoBar;
      property progresso: TGauge read FProgresso write FProgresso;
      {$ENDIF}
      property dtaDataVencto: TDateTime read FDataVencto write FDataVencto;
      property strCodigoReceita: string read FCodigoReceita write FCodigoReceita;
      property intCampoPrecoEstoque: integer read FCampoPrecoEstoque write FCampoPrecoEstoque;
      property dtaDataInventario: TDateTime read FDataInventario write FDataInventario;
      property notaFiscal: TNotaFiscal read FNotaFiscal write FNotaFiscal;
      property blnInconsistencia: boolean read FInconsistencia write FInconsistencia;
  end;

implementation

{ TDadosAbertura }

constructor TDadosAbertura.Create(dtaDataInicial, dtaDataFinal: TDateTime; strEmpresaSelecionada: String; intIndicePrecoEstoque: integer = 0);
begin
  FExcluirCFOPServico := False;
  FIncluirCFOPSaida   := False;

  FDataInicial := dtaDataInicial;
  FDataFinal := dtaDataFinal;

  FEmpresa := TEmpresa.Create(strEmpresaSelecionada);
  FEmpresa.pCarregaEmpresa;

  FNotaFiscal := TNotaFiscal.Create();
end;

destructor TDadosAbertura.Destroy;
begin
  FEmpresa.Free;
  FNotaFiscal.Free;

  inherited;
end;

end.
