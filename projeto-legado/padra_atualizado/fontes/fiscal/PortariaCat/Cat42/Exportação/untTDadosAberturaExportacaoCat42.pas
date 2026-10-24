unit untTDadosAberturaExportacaoCat42;

interface

uses untTDadosAbertura,
     ComCtrls,
     StdCtrls,
     untTipo;

type
  TDadosAberturaExportacaoCat42 = class(TDadosAbertura)
  private
    FUtilizarConfigCfopCstEnquadramentos: boolean;
    FTipoConferencia: TTipoConferenciaCat;
    FEnviaNfCredSemSubsti: boolean;
    FProgressoTela: TProgressBar;
    FSomarIcmsRetido: boolean;
    FVersaoLayout: string;
    FGerarComSaldoZero: boolean;
    FCalculaST: boolean;
    FFinalidade: string;
    FValorIVA: double;
    FMesAno: string;
    FPath: string;

    FSldFinalQtFinalNegQtVendaMaiorCompra: Boolean;
    FInvSemSaldoSemSubstTributSemMovtoMes: Boolean;
    FInvSemSaldoComSubstTributSemMovtoMes: Boolean;
    FInvComSaldoSemSubstTributSemMovtoMes: Boolean;
    {FInvComSaldoComSubstTributSemMovtoMes: Boolean;}
    FInvComSaldoSemSubstTributComMovtoMes: Boolean;
    FSaldoInicialQuantidadInicialNegativa: Boolean;
    FNotasEntradaSemSubstituicaTributaria: Boolean;
    FConsiderarInconsistenciaQuatro: Boolean;
    FConsiderarInconsistenciaCincoTransfSemSt: Boolean;
    FConsiderarInconsistenciaCincoEntradaSemSt: Boolean;
    FEnviarIsentoParaInsEst: Boolean;
    FVersaoExecutada: string;
    FConsiderarDataEmissaoEntradasTransferencia: Boolean;
    FSaldoMovimentacao: Boolean;
    FUtilizarPrecoCompraCalcICMSSuportado: Boolean;
    FSaidaOutroEstado: Boolean;
    FSaidaConsumidor: Boolean;

  public
    constructor Create(dtaDataInicial, dtaDataFinal: TDateTime; strEmpresaSelecionada: string);

    property blnUtilizarConfigCfopCstEnquadramentos: boolean read FUtilizarConfigCfopCstEnquadramentos write FUtilizarConfigCfopCstEnquadramentos;
    property tipoConferencia: TTipoConferenciaCat read FTipoConferencia write FTipoConferencia;
    property blnEnviaNfCredSemSubsti: boolean read FEnviaNfCredSemSubsti write FEnviaNfCredSemSubsti;
    property blnSomarIcmsRetido: boolean read FSomarIcmsRetido write FSomarIcmsRetido;
    property blnGerarComSaldoZero: boolean read FGerarComSaldoZero write FGerarComSaldoZero;
    property progressoTela: TProgressBar read FProgressoTela write FProgressoTela;
    property strVersaoLayout: string read FVersaoLayout write FVersaoLayout;
    property blnCalculaST: boolean read FCalculaST write FCalculaST;
    property fltValorIVA: double read FValorIVA write FValorIVA;
    property strFinalidade: string read FFinalidade write FFinalidade;
    property strMesAno: string read FMesAno write FMesAno;
    property strPath: string read FPath write FPath;

    property blnSldFinalQtFinalNegQtVendaMaiorCompra: boolean read FSldFinalQtFinalNegQtVendaMaiorCompra write FSldFinalQtFinalNegQtVendaMaiorCompra;
    property blnInvSemSaldoSemSubstTributSemMovtoMes: boolean read FInvSemSaldoSemSubstTributSemMovtoMes write FInvSemSaldoSemSubstTributSemMovtoMes;
    property blnInvSemSaldoComSubstTributSemMovtoMes: boolean read FInvSemSaldoComSubstTributSemMovtoMes write FInvSemSaldoComSubstTributSemMovtoMes;
    property blnInvComSaldoSemSubstTributSemMovtoMes: boolean read FInvComSaldoSemSubstTributSemMovtoMes write FInvComSaldoSemSubstTributSemMovtoMes;
    {property blnInvComSaldoComSubstTributSemMovtoMes: boolean read FInvComSaldoComSubstTributSemMovtoMes write FInvComSaldoComSubstTributSemMovtoMes;}
    property blnInvComSaldoSemSubstTributComMovtoMes: boolean read FInvComSaldoSemSubstTributComMovtoMes write FInvComSaldoSemSubstTributComMovtoMes;
    property blnSaldoInicialQuantidadInicialNegativa: boolean read FSaldoInicialQuantidadInicialNegativa write FSaldoInicialQuantidadInicialNegativa;
    property blnNotasEntradaSemSubstituicaTributaria: boolean read FNotasEntradaSemSubstituicaTributaria write FNotasEntradaSemSubstituicaTributaria;
    property blnConsiderarInconsistenciaQuatro: boolean read FConsiderarInconsistenciaQuatro write FConsiderarInconsistenciaQuatro;
    property blnConsiderarInconsistenciaCincoTransfSemSt: boolean read FConsiderarInconsistenciaCincoTransfSemSt write FConsiderarInconsistenciaCincoTransfSemSt;
    property blnConsiderarInconsistenciaCincoEntradaSemSt: boolean read FConsiderarInconsistenciaCincoEntradaSemSt write FConsiderarInconsistenciaCincoEntradaSemSt;
    property blnEnviarIsentoParaInsEst: Boolean read FEnviarIsentoParaInsEst write FEnviarIsentoParaInsEst;
    property strVersaoExecutada: string read FVersaoExecutada write FVersaoExecutada;
    property blnConsiderarDataEmissaoEntradasTransferencia: boolean read FConsiderarDataEmissaoEntradasTransferencia write FConsiderarDataEmissaoEntradasTransferencia;
    property blnSaldoMovimentacao: boolean read FSaldoMovimentacao write FSaldoMovimentacao;
    property blnUtilizarPrecoCompraCalcICMSSuportado: Boolean read FUtilizarPrecoCompraCalcICMSSuportado write FUtilizarPrecoCompraCalcICMSSuportado;
    property blnSaidaOutroEstado: Boolean read FSaidaOutroEstado write FSaidaOutroEstado;
    property blnSaidaConsumidor: Boolean read FSaidaConsumidor write FSaidaConsumidor;

  end;

implementation

{ TDadosAberturaExportacaoCat42 }

constructor TDadosAberturaExportacaoCat42.Create(dtaDataInicial, dtaDataFinal: TDateTime; strEmpresaSelecionada: string);
begin
  inherited create(dtaDataInicial, dtaDataFinal, strEmpresaSelecionada)
end;

end.
