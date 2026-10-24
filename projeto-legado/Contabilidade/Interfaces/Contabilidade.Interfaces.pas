unit Contabilidade.Interfaces;

interface

uses cxProgressBar, UniClientDataSet, Uni, Classes, Contabilidade.Model.Contabilizaveis,
  System.Generics.Collections;

type
  TOrigemPlanoContabil = (opcParcon, opcCliFor, opcPortador, opcBandeira, opcPlanoContas, opcAbrevProd, opcCfg);
  TTipoFechamentoContabil = (tfcMensal, tfcTrimestral, tfcAnual);
  TTipoComparacao = (tcMaior, tcMenor) ;
  TArrayModalidadesCTR = array[0..5] of String ;
  TTipoLancamentoImportacaoLancon = (tlilIMP, tlilFOL, tlilPAT) ;
  TJoinSaiPlanoContasTipo = (jspcReceber, jspcPagar);
  TJoinSaiPlanoContas = set of TJoinSaiPlanoContasTipo;
  TTipoCheckList = (tclGeracaoLancamentoContabil, tclFechamentoContabil, tclFechamentoContabilMes) ;
  TTipoPlanoContas = (tpcCredito, tpcDebito) ;
  TTipoPlanoContasCtpDetContabil = (pcccJuros, pcccDescontos) ;
  TPesquisaLancamentoContabil = (plcLancon, plcLote, plcLoteLancado);
  TLayoutImportacaoContabil = (tLayFolha, tLayPatrimonial, tLayDimob);
  TFormaTributacao = (ftNada, ftLucroPresumido, ftLucroRealTrimestral, ftLucroRealEstimativaMensal, ftSimplesNacional) ;
  TEncerramentoContabil = (ecNada, ecAnual, ecMensal, ecTrimestral) ;
  TLacsLalur = (llNada, llLacs, llLalur) ;
  TCsllIrpj = (iiIRPJ, iiCSLL) ;
  TPrejuizosFiscais = (pjBcNegativaOuOperacional, pjNaoOperacional) ;
  TTipoDemonstrativoApuracao = (tdaBalancete, tdaReceita) ;
  TFkPlanco = (pLiga, pDesliga) ;

  TTiposQuePermitemApenasPeriodoDentroDeUmUnicoMes = array of string ;

  TTiposContabeis = (tcCTP, tcCTR, tcCHQ, tcCAR, tcBAN, tcENT, tcSAI, tcCOE,
                     tcCOS, tcAJE, tcAJS, tcPCP, tcPCR, tcCRC, tcADT, tcIMO,
                     tcCMV, tcGNR, tcPDD, tcAGR, tcAGP, tcTCC, tcCPC, tcANT,
                     tcAJI);

  TSetTiposContabeis = set of TTiposContabeis ;

  TColunasValorLiquidoContabil = (cvlcReCssl, cvlcReInss, cvlcReIrrf, cvlcRetIss, cvlcVrePis, cvlcVreCof) ;
  TSetColunasValorLiquidoContabil = set of TColunasValorLiquidoContabil;

  TinfoIncDocConLog = record
    IncDoc: String ;
    ConLog: Int64 ;
  end ;

  TDadosSugestaoInsertLancamentoContabil = record
    dtaLan: TDateTime ;
    strCodEmp: String ;
    fltValor: Double ;
    strContaCredito: String ;
    strContaDebito: String ;
    strCentroCustoCredito: String ;
    strCentroCustoDebito: String ;
    strComplemento: String ;
    strHistoricoPadrao: String ;
    strTipoFCDebito: String ;
    strClienteFornecedorDebito: String ;
    strTipoFCCredito: String ;
    strClienteFornecedorCredito: String ;
    strTipoLancamento: String ;
  end;

  TArrIncDoc = array of TinfoIncDocConLog ;

  TInfoResponsavelContador = class
  private
    FCSE_NOMSIG: String ;
    FCSE_DOCSIG: String ;
    FCSE_NUMCRC: String ;
  public
    property CSE_NOMSIG: String read FCSE_NOMSIG write FCSE_NOMSIG ;
    property CSE_DOCSIG: String read FCSE_DOCSIG write FCSE_DOCSIG ;
    property CSE_NUMCRC: String read FCSE_NUMCRC write FCSE_NUMCRC ;
  end;

  TInfoResponsavelEmpresa = class
  private
    FCSE_NOMSIG: String ;
    FCSE_DESQUA: String ;
    FCSE_DOCSIG: String ;
  public
    property CSE_NOMSIG: String read FCSE_NOMSIG write FCSE_NOMSIG ;
    property CSE_DESQUA: String read FCSE_DESQUA write FCSE_DESQUA ;
    property CSE_DOCSIG: String read FCSE_DOCSIG write FCSE_DOCSIG ;
  end;

  TInfoEmpresaSelecionadaRelatorio = record
    EMP_NOMEMP : string ;
    EMP_ENDERE : string ;
    EMP_BAIRRO : string ;
    EMP_ENDNUM : string ;
    EMP_ENDCMP : string ;
    EMP_C_E_P_ : string ;
    EMP_C_G_C_ : string ;
    EMP_I_E_S_ : string ;
    EMP_JUCESP : string ;
    EMP_CIDADE : string ;
    EMP_ESTADO : string ;
  end;

  TParametrosGravaLanCon = record
    blnEstorno: boolean;
    blnAdiantamento: boolean;
    strCodigoImobilizado : string;
    strCodigoTipoImobilizado : string;
    blnEmpresaDoCadastroDiferenteDaBaixa: boolean;
    strEmpresaCadastro: string;
    strEmpresaBaixa : string;
    strTituloPDD : string;
    strEmpresaAdt : string;
    blnEmpresaDoCadastroAdtDiferenteDaBaixa: boolean;
    strCodigoMarketPlace: string ;
    strCodGru: string ;
    strEspDoc: string ;
    strAdtTransformadoCC: string;
    blnCFG_EXCREP: boolean;
  end;

  TParametrosConsulta = record
    strCodEmp: String;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    strIncDoc: string;
    strTabela: string;
    blnModoRobo: boolean;
    intModoLancto : Integer;
    intIncConLog: int64;
    dtaLanRobo : TDateTime ;
    strEmpRobo : String ;
    arrIncDoc : TArrIncDoc ;
    cdsPlancoInfo: TUniClientDataSet ;
    // Req. 470760, preenchidos so pela tela de geracao. Listas de 'CHVDOC|TABELA', sem posse.
    blnReprocessaErros: Boolean;
    lstDocExcluir: TStrings;
    lstDocReprocesso: TStrings;
  End;

  TValidacoesDeBanco = record
    FUsaCampoAbfCon: boolean;
    FUsaCampoNatCfo: boolean;
    FUsaCampoCalMed: boolean;
  End;

  TContaErro = record
    strMotivo: String;
    strHistor: String;
    strTipLan: String;
    strDesVal: String;
    strNatOpe: String;
    strOriPla: String;
    strChaveDocumento: String;
    strTabela: string;
    strWarning: string ;
    strCodEmp: string;
    strSigla: string;
  end;

  ITrataIncDocContabil = interface
    ['{0F8D65C4-060C-43DD-AE2A-AC8ED7D930D9}']
    function fColunaIncDoc(const AstrValue: String): ITrataIncDocContabil; overload ;
    function fColunaIncDoc: String; overload ;
    function fQuerySql(AqryValue: TUniQuery): ITrataIncDocContabil;
    function fIncDoc(const AstrValue: String): ITrataIncDocContabil; overload ;
    function fIncDoc: String; overload ;
    function fArrIncDoc(const AValue: TArrIncDoc): ITrataIncDocContabil; overload ;
    function fArrIncDoc: TArrIncDoc; overload ;
    function fExecute: String ;
  end ;

  ITrataConLog = interface
    ['{E73983E9-D595-4ACC-9B78-C766CB0E5B4E}']
    function fIncDoc(const AstrValue: String): ITrataConLog;
    function fArrIncDoc(const AValue: TArrIncDoc): ITrataConLog;
    function fLstProcessado(var AValue: TStringList): ITrataConLog;
    function fTipLan(const AstrValue: String): ITrataConLog;
    function fQuerySql(AqryValue: TUniQuery): ITrataConLog;
    function fRetornaAutoIncConLog: Int64 ;
  end ;

  IEventoContabil = interface
    ['{34F3458C-CBB4-4C14-9301-EA81CD0C3F9F}']
    function fConsultaEvento(const AstrCentroCustoDefault: String): String ;
  end ;

  IFactoryMethodEventoContabil = interface
    ['{B8FEB249-96E2-4464-9580-373FAA50B531}']
    function fConfiguraEvento(const AstrCodigoEvento: String;
                              const AstrTipoLancamento: string = '';
                              const AstrCfop: string = '';
                              const AstrDescricaoValor: string = ''): IEventoContabil ;
  end ;

  IContabilidadeTelas = interface
    ['{0DEBC602-9B74-48B0-9F5C-E9874A7C4A23}']
    procedure HistoricoPadrao;
    procedure LancamentoSaldos;
    procedure ConferenciaEstoqueContabil;
    procedure GeracaoLancamentoContabil;
    procedure ManutencaoLancamentosContabeis;
    procedure ParametrosContabilizacao;
    procedure PlanoContabil;
  end;

  IValidaContaContabil = interface
    ['{93F1635B-B94F-4908-BEED-EE1F45128EEE}']
    procedure pAddErro(recContaErro: TContaErro; const AContabilizaveis: TContabilizaveis; const AdtaLan: TDateTime = 0);
    function GetDataSet: TUniClientDataSet;
    procedure setContaContabil(const AConta, AIncDoc: string);
    function getContabilizaveis : TObjectList<TContabilizaveis>;
    property DataSet: TUniClientDataSet read GetDataSet;
    function GetDataSetWarnings: TUniClientDataSet;
    property DataSetWarnings: TUniClientDataSet read GetDataSetWarnings;
    function GetFiltrosExcecao: String;
    property FiltrosExcecao: String read GetFiltrosExcecao;
  end;

  IUpdateContaContabil = interface
    ['{F32D33DF-D5BF-4437-98BF-A678385F1BF2}']
    procedure setContaContabil(const AConta, AIncDoc: string);
  end;

  IListaValidacoesContabeis = interface
    ['{609BA212-DBE9-4400-A7A1-FBDD70618682}']
    function AddValidacao(const AValidacao: IValidaContaContabil): Boolean;
    function getDataSet: TUniClientDataSet;
  end;

  ITipLanCon = Interface
    ['{B705B892-BF6C-44B9-860D-E7727E258368}']
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload ;
    procedure pSetaPreValidacao(const Value: Boolean); overload ;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

  ILanConFactory = interface
    ['{A10B19DF-8C8B-42E3-9FBD-7D79727E4BBE}']
    function fLanCon(strTipLan: String; recParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar): ITipLanCon;
  end;

  IParametrosFormContasPorEmpresa = interface
    ['{6B5AFD58-664A-42B6-A2E1-82C3F2DAFE4D}']
    function Tabela: String; overload;
    function Tabela(AValue: String): IParametrosFormContasPorEmpresa; overload;
    function CampoChave: string; overload;
    function CampoChave(AValue: string): IParametrosFormContasPorEmpresa; overload;
    function CriaDataSet: boolean; overload;
    function CriaDataSet(AValue: boolean): IParametrosFormContasPorEmpresa; overload;
    function CdsDados: TUniClientDataSet; overload;
    function CdsDados(AValue: TUniClientDataSet): IParametrosFormContasPorEmpresa; overload;
    function CreditoDebito: string; overload;
    function CreditoDebito(AValue: string): IParametrosFormContasPorEmpresa; overload;
    function ValorChave: string; overload;
    function ValorChave(AValue: string): IParametrosFormContasPorEmpresa; overload;
    function ReadOnly: Boolean; overload;
    function ReadOnly(AValue: Boolean): IParametrosFormContasPorEmpresa; overload;
  end;

  IShowModalFormContasPorEmpresa = interface
    ['{1177778A-6B95-48C5-AB81-9AD923F18F49}']
    procedure ShowModal(AParams: IParametrosFormContasPorEmpresa);
  end;

  ICarregaCdsContasPorEmpresa = interface
    ['{B344CAC9-C42C-4AA2-AB4E-52A9D92E4267}']
    function fCarregar(const AParams: IParametrosFormContasPorEmpresa): TUniClientDataSet;
  end ;

  ISalvarCdsContasPorEmpresa = interface
    ['{D8C8BA4A-5BE8-4B5D-8362-1034FF2FBE46}']
    procedure pSalvar(const AParams: IParametrosFormContasPorEmpresa);
  end ;

  TErroContabilProc = procedure(const AdsErros: TUniClientDataset) of object;
  TDeletaFechamentoFunc = function(const AstrCodEmp: String;  const AdtaFechamento: TDateTime; var AstrMsgErro: String): Boolean of object;
  TListarExerciciosDemonstracao = function(const ACodEmp: String): TStringList of object ;

const
  NOME_FRM_LOTES_CONTABEIS = 'frmLancamentosLotesContabeis' ;
  CAPTION_MENU_LOTES_CONTABEIS = 'Manutenção de Lançamentos/Lotes Contábeis' ;
  MSG_VALIDA_HISTORICO = 'Histórico Padrão ou Complemento devem ser informados!' ;
  COD_LACS_LALUR : Array[TLacsLalur] Of String = ('0', '1', '2') ;
  COD_PREJUIZO_FISCAL : Array[TPrejuizosFiscais] of String = ('1', '2') ;
  COD_IRPJ_CSLL: Array[TCsllIrpj] of String = ('1', '2') ;
  COD_ENCERRAMENTO_CONTABIL: array[TEncerramentoContabil] of string = ('', 'A', 'M', 'T') ;
  COD_DEMONSTRATIVO_APURACAO: array[TTipoDemonstrativoApuracao] of string = ('B', 'R') ;
  COD_TIPO_LANCAMENTO_LANCON: array[TTipoLancamentoImportacaoLancon] of string = ('IMP', 'FOL', 'PAT') ;

  COD_TIPOPLANOCONTASCTPDET : Array[TTipoPlanoContasCtpDetContabil] of String = ('J', 'D') ;
  COD_BASE_CALCULO_NEGATIVA_CSLL = '1.003' ;
  COD_PREJUIZO_FISCAL_OPERACIONAL = '1.000' ;
  COD_PREJUIZO_FISCAL_NAO_OPERACIONAL = '1.001' ;

  CONHECIMENTO_TIPO_COMPRA : string = 'C';
  CONHECIMENTO_TIPO_VENDA : string = 'V';

  CFOP_ENTRADAS_APENAS_CADFIS : string = '_253_303_602_605_';

  CONTABIL_MSG_NAO_DEFINIU_DEBITO_NEM_CREDITO : string = 'Parâmetrização não definiu crédito e/ou débito';
  CONTABIL_MSG_CONTA_CREDITO_DEBITO_IGUAIS : string = 'Conta Crédito [%s] não pode ser igual a Conta Débito [%s]';
  CONTABIL_MSG_CONTA_CREDITO_TEM_REFERENCIA_DEBITO : string = 'Conta Crédito [%s] não pode ter nenhuma referência na Conta Débito.';
  CONTABIL_MSG_CONTA_DEBITO_TEM_REFERENCIA_CREDITO : string = 'Conta Débito [%s] não pode ter nenhuma referência na Conta Crédito.';
  CONTABIL_MSG_TOTDEB_MENOS_TOTCRE_DIFERENTE_ZERO : string = 'Total de débitos [%s] - total de créditos [%s] não é igual a zero.';

  DES_CONTABIL_MANUAL = 'MAN-Lançamento Manual da Contabilidade' ;
  DES_CONTABIL_IMPORTACAO = 'IMP-Importação Lançamentos Contábeis' ;

  CODIGO_ORIGEM_PLANO_CONTABIL: Array[TOrigemPlanoContabil] Of String = ('PR',
                                                                         'CF',
                                                                         'PT',
                                                                         'BN',
                                                                         'PC',
                                                                         'AB',
                                                                         'CN'
                                                                         );

  DES_ORIGEM_PLANO_CONTABIL: Array[TOrigemPlanoContabil] Of String = ('Parcon',
                                                                      'Cliente/Fornecedor',
                                                                      'Portador',
                                                                      'Bandeira',
                                                                      'Plano Contas',
                                                                      'Abrev. Prod.',
                                                                      'Configuração'
                                                                      );

  DES_CONTABIL : Array[TTiposContabeis] Of String = ('CTP-Contas à Pagar',
                                                     'CTR-Contas à receber',
                                                     'CHQ-Cheque',
                                                     'CAR-Cartão',
                                                     'BAN-Movimento Bancário',
                                                     'ENT-Entrada de Mercadorias',
                                                     'SAI-Saída de Mercadorias',
                                                     'COE-Conhecimento de Entrada',
                                                     'COS-Conhecimento de Saída',
                                                     'AJE-Ajuste de Entrada',
                                                     'AJS-Ajuste de Saída',
                                                     'PCP-Provisão Contas à Pagar',
                                                     'PCR-Provisão Contas à Receber',
                                                     'CRC-Crédito de Cliente',
                                                     'ADT-Adiantamento de Cliente',
                                                     'IMO-Imobilizado/Patrimônio',
                                                     'CMV-Custo Mercadoria Vendida',
                                                     'GNR-GNRE',
                                                     'PDD-Provisão de Devedores Duvidosos',
                                                     'AGR-Agrupamento de Contas a Receber',
                                                     'AGP-Agrupamento de Contas a Pagar',
                                                     'TCC-Transitória Cheque/Cartão',
                                                     'CPC-Crédito Pis/Cofins EFD Contribuições',
                                                     'ANT-Pagamento Antecipado Fornecedores',
                                                     'AJI-Ajustes/Estornos ICMS'
                                                    );

  DES_CONTABIL_SIGLA : Array[TTiposContabeis] Of String = ('CTP', // 0
                                                           'CTR', // 1
                                                           'CHQ',
                                                           'CAR',
                                                           'BAN',
                                                           'ENT',
                                                           'SAI',
                                                           'COE',
                                                           'COS',
                                                           'AJE',
                                                           'AJS',
                                                           'PCP', // 11
                                                           'PCR', // 12
                                                           'CRC',
                                                           'ADT',
                                                           'IMO',
                                                           'CMV',
                                                           'GNR',
                                                           'PDD',
                                                           'AGR',
                                                           'AGP',
                                                           'TCC',
                                                           'CPC',
                                                           'ANT',
                                                           'AJI'
                                                          );

  COD_CONTABIL : Array[TTiposContabeis] Of Integer = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24);
  DES_COLUNAS_VALOR_LIQUIDO_CONTABIL : array[TColunasValorLiquidoContabil] of String = ('FIS_RECSSL',
                                                                                        'FIS_REINSS',
                                                                                        'FIS_REIRRF',
                                                                                        'FIS_RETISS',
                                                                                        'FIS_VREPIS',
                                                                                        'FIS_VRECOF') ;
  ORI_AG_TITULOS = 'TITULOS' ;
  ORI_AG_AGRUPAMENTO = 'AGRUPAMENTO' ;
  ORI_AG_DEVOLUCAO_CREDITO = 'DEVOLUÇÕES/CREDITOS' ;
  ORI_AG_CREDITO_AGRUPAMENTO = 'CREDITO - AGRUPAMENTO' ;
  TIPO_CONTAS_RECEBER = 'CTR';
  TIPO_CONTAS_PAGAR = 'CTP';
  TIPO_CONTAS_PAGAR_PROVISAO = 'PCP';
  TIPO_ENTRADA = 'ENT';
  TIPO_SAIDA = 'SAI';

  FPG_DINHEIRO = 'Dinheiro';
  FPG_CHEQUE_VISTA = 'Cheque à vista';
  FPG_CHEQUE_PRE = 'Cheque pré';
  FPG_CARTAO = 'Cartão';
  FPG_ORDPAG = 'Ordem de Pagamento';
  FPG_TODAS = 'Todas';
  FPG_CREDITO = 'Crédito';
  FPG_ADIANTAMENTO = 'Adiantamento';
  FPG_DESCONTO_TOTAL = 'Desconto Total' ;
  FPG_DESCONTO_TOTAL_CREDITO = 'Desconto Total - Crédito' ;
  FPG_FINANCIAMENTO = 'Financiamento' ;
  FPG_GARANTIA = 'Garantia' ;

  PGT_PAGAMENTO_PCP = 'Pagamentos PCP' ;
  PGT_PAGAMENTO_PCR = 'Pagamentos PCR' ;

  TIP_GARANTIA = '002';

  NAT_OPE_VISTA = 'À Vista';
  NAT_OPE_PRAZO = 'À Prazo';
  NAT_OPE_TODOS = 'Todos';

  DES_DEPRECIAR = 'Depreciar';
  DES_VALOR_RECEBIDO = 'Vr.Recebido';
  DES_VALOR_DUPLICATA = 'Vr.Duplicata';
  DES_VALOR_PAGO = 'Vr.Pago';
  DES_VALOR_JUROS = 'Vr.Juros';
  DES_VALOR_DESCONTO = 'Vr.Descontos';
  DES_VALOR_CHEQUE = 'Vr.Cheque Depositado';
  DES_VALOR_CARTAO = 'Vr.Recebido';
  DES_VALOR_CARTAO_TAXA = 'Vr.Taxa';
  DES_VALOR_MOVBAN = 'Vr.Lançamento';
  DES_VALOR_CONT = 'Vr.Contábil';
  DES_VALOR_ICMS = 'Vr.ICMS';
  DES_VALOR_IPI = 'Vr.IPI';
  DES_VALOR_FRETE = 'Vr.Frete';
  DES_VALOR_DESPACE = 'Vr.Desp.Acessórias';
  DES_VALOR_SUBTRIB = 'Vr.Sub.Tributária';
  DES_VALOR_PIS = 'Vr.PIS';
  DES_VALOR_COFINS = 'Vr.COFINS';
  DES_VALOR_GNRE = 'Vr.GNRE/GARE';
  DES_VALOR_ISS = 'Vr.ISS';
  DES_VALOR_CSLL = 'Vr.CSLL';
  DES_VALOR_IRPJ = 'Vr.IRPJ';
  DES_VALOR_INSS = 'Vr.INSS';
  DES_VALOR_CTE_CONT = 'Vr.Contábil';
  DES_VALOR_CTE_ICMS = 'Vr.ICMS';
  DES_VALOR_CTE_PIS = 'Vr.PIS';
  DES_VALOR_CTE_COFINS = 'Vr.COFINS';
  DES_VALOR_ORIGINAL = 'Vr.Original';
  DES_VALOR_CMV = 'Vr.CMV ( Custo Médio )';
  DES_VALOR_FCP = 'Vr.FCP' ;
  DES_VALOR_FCP_ST = 'Vr.FCP ST' ;
  DES_VALOR_RETENCAO_PIS = 'Vr.Ret.PIS' ;
  DES_VALOR_RETENCAO_COFINS = 'Vr.Ret.COFINS' ;
  DES_VALOR_RETENCAO_ISS = 'Vr.Ret.ISS' ;
  DES_VALOR_ICMS_ST = 'Vr.ICMS ST';
  DES_VALOR_RET_IRRF = 'Vr.Ret.IRRF';
  DES_VALOR_FRETE_HUB = 'Vr.Frete HUB';
  DES_VALOR_DESCONTO_HUB = 'Vr.Desconto HUB';
  DES_VALOR_AJUSTE_HUB = 'Vr.Ajuste HUB' ;
  DES_VALOR_DIFAL = 'Vr.Difal';
  DES_VALOR_MULTA = 'Vr.Multa';
  DES_VALOR_VENDOR = 'Vr.Vendor';
  DES_VALOR_CHEQUE_TRANSF_CTR = 'Vr.Cheque Transferido CTR' ;
  DES_VALOR_REVERSAO_PDD = 'Vr.Reversão PDD';
  DES_VALOR_PIS_RF = 'Vr.PIS Receita Financeira';
  DES_VALOR_COF_RF = 'Vr.COFINS Receita Financeira';
  DES_VALOR_INSS_PATRONAL = 'Vr.Inss Patronal' ;
  DES_VALOR_LIQUIDO_SAIDA = 'Vr.Líquido Saída' ;
  DES_VALOR_LIQUIDO_ENTRADA = 'Vr.Líquido Entrada' ;
  DES_VALOR_LIQUIDO_CONTABIL = 'Vr.Líquido Contábil' ;
  DES_VALOR_CHEQUE_VALOR_REPASSE = 'Vr.Repasse' ;
  DES_VALOR_DESPESAS_COBRANCA = 'Vr.Desp Cobranças' ;

  CONTA_DA_BAIXA : String = 'B';
  CONTA_DO_CADASTRO : String = 'C';

  DES_PLANO_DE_CONTAS = 'Plano de Contas' ;

  MODO_ROBO_1_INCLUSAO : integer = 1;
  MODO_ROBO_2_ESTORNO : integer = 2;
  MODO_ROBO_3_CANCELAMENTO : integer = 3;

  ID_Inactivity_Monitor_Contabil = 'TEST_INACTIVITY_CONTABIL_%s';
  Time_Limit_Monitor_Contabil = 30;
  Attempts_Lock_Monitor_Contabil = 30;
  Id_Monitor_Contabil = 'MONITOR_CONTABIL_%s';
  Id_Monitor_Contabil_Sem_Empresa = 'MONITOR_CONTABIL';
  Monitor_Contabil_ExeName = 'MonitorContabil.exe';

implementation

end.
