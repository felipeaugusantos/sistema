unit faturamento.Classes.FaturamentoLocEqu;

interface

uses
  Windows, Classes, Vcl.Controls,  Uni, DateUtils, SysUtils,
  untFuncFat, Faturamento.Classes.TEmitirPedido, System.Generics.Collections, cxProgressBar,
  untFuncFatTypes, UniClientDataSet, untTypesSistema,
  Forms, Messages, UniDataSetProvider, untFuncoesSimples, Data.DB, untFuncoes,
  untModulo,untTLock, cadastro.Model.ContratoLocacaoEquipamentos,
  Faturamento.Classes.TAlterarPedido, cadastro.Controller.ContratoLocacaoEquipamentos,
  untTypesLocEqu, frxClass, frxExportPDF, frxDBSet, untFuncoesImagem,
  untObservacao;

Type

  TDupFaturamentoContrato = Class;
  TItemFaturamentoContrato = Class;
  TFaturamentoContrato = Class
  private
    FContrato: TContratoLocacaoEquipamentos;
    FobjValidaCtr: TValidarContrato;
    FCodCondicaoPgto: String;
    FCondicaoPgto: String;
    FCodFormaPgto: String;
    FObjFatVenda: TFatVenda;
    FDtaRef: TDateTime;
    FHraRef: TDateTime;
    FTipoFaturamento: TTipoFaturamentoLocacao;
    FListaItens: TList<TItemFaturamentoContrato>;
    FVlrTotFat: Double;
    FVlrTotIpe: Double;
    FVlrTotal: Double;
    FVlrTotJFat: Double;
    FVlrTotRes: Double;
    FVlrTotRLq: Double;
    FMensagemRetorno: String;
    FNumDocAdt,
    FEspDocAdt,
    FEmpDocAdt: String;
    FblnAdtVltTot: Boolean;
    FblnEncerrarContrato: Boolean;
    FTotHor: Double;
    FTotDia: Double;
    FblnEmitirBoleto: Boolean;
    FListaDuplicatas: TList<TDupFaturamentoContrato>;
    FNumDoc: String;
    FEmpDoc: String;
    FEspDoc: String;
    FDocumentoGerado: String;
    FblnInformarFormaPgto: Boolean;
    FblnBoletoImpresso: Boolean;
    FblnTransacaoIniciada: Boolean;
    FblnRealizarAdiantamentoAgrup: Boolean;
    FAutInc: String;
    FSerDoc: String;
    FDtaFat: TDateTime;
    FHraFat: TDateTime;
    FEmFaturamentoMensal: Boolean;
    FBlnAdicionarTaxaEntrega: Boolean;
    FVlrTotEqu: Double;
    FTotMes: Double;
    FDtaIniCob: TDateTime;
    FHraIniCob: TDateTime;
    FVlrTotDes: Double;
    FPerTotDes: Double;
    FblnEncerrarItemFat: Boolean;
    FblnFatEmitida: Boolean;
    FDtaFinCob: TDateTime;
    FHraFinCob: TDateTime;
    FstrObs: String;
    FVlrTotAdc: Double;
    FExcluirFaturamentoEncerramento: Boolean;

    function GetContrato: TContratoLocacaoEquipamentos;
    procedure SetContrato(const AValue: TContratoLocacaoEquipamentos);
    function GetCodCnd: String;
    function GetDesCnd: String;
    procedure SetCodCnd(const AValue: String);
    procedure SetDesCnd(const AValue: String);
    function GetCodFpg: String;
    procedure SetCodFpg(const AValue: String);
    function GetDtaRef: TDateTime;
    function GetHorRef: TDateTime;
    procedure SetDtaRef(const AValue: TDateTime);
    procedure SetHorRef(const AValue: TDateTime);
    function GetTipFat: TTipoFaturamentoLocacao;
    procedure SetTipFat(const AValue: TTipoFaturamentoLocacao);
    function GetObjFtV: TFatVenda;
    function GetVlrAFt: Double;
    function GetVlrIpe: Double;
    function GetVlrJFt: Double;
    function GetVlrRFt: Double;
    function GetVlrTot: Double;
    procedure SetVlrAFt(const AValue: Double);
    procedure SetVlrIpe(const AValue: Double);
    procedure SetVlrJFt(const AValue: Double);
    procedure SetVlrRFt(const AValue: Double);
    procedure SetVlrTot(const AValue: Double);
    function GetVlrRFL: Double;
    procedure SetVlrRFL(const AValue: Double);
    function GetMsgRet: String;
    function GetEncCtr: Boolean;
    procedure SetEncCtr(const AValue: Boolean);
    function GetLItens: TList<TItemFaturamentoContrato>;
    function GetTotDia: Double;
    function GetTotHor: Double;
    procedure SetTotDia(const AValue: Double);
    procedure SetTotHor(const AValue: Double);
    procedure SetBlnBol(const AValue: Boolean);
    function GetBlnBol: Boolean;
    function GetNumDoc: String;
    procedure SetNumDoc(const AValue: String);
    function GetLDup: TList<TDupFaturamentoContrato>;
    function GetInfPgt: Boolean;
    procedure SetInfPgt(const AValue: Boolean);
    function GetBltImp: Boolean;
    function GetDocGer: String;
    procedure SetDocGer(const AValue: String);

    function fCarregarObjetoFaturamentoNotaServico: Boolean;
    function fCarregarObjetoFaturamentoContasReceber: Boolean;

    function fValidaCondicaoPagamentoParaAdiantamento(const strConPag: String): Boolean;
    function fInformaPagamento: Boolean;
    function fSenhaAlteracaoFormaPagamento: Boolean;
    function fEmitirFaturaNotaServico: Boolean;
    function fEmitirFaturaContasReceber: Boolean;
    function fCalculaValorDuplicata: Double;
    function fGeraContasReceber: Boolean;
    function fGeraContasReceberComAdiantamento: Boolean;
    function fValidarPodeEmitirFatura: Boolean;
    function fVerificaItensMarcadosEncerrar: Boolean;
    function fProcessarEncerramento(const blnEncerrar: Boolean): Boolean;

    procedure pBaixaItensPedidoAdiantamento;
    procedure pBaixaPedidoAdiantamento;
    procedure pBaixaEquipamentoPedido(const strCodIte, strSeqIte: String);
    procedure pBaixaAcessorioPedido(const strCodAce, strCodEql: String);
    procedure pBaixaPedido;

    procedure pGerarParcelasContasReceber(const fltTotDup: Double);
    procedure pBaixaParcelaAdiantamento(var blnUtilizarValorTotalAdiantamento, blnAlterarSequencialParcelas: Boolean);

    function GetEmpDocAdt: String;
    function GetEspDocAdt: String;
    function GetNumDocAdt: String;
    function GetBlnAdt: Boolean;
    procedure SetBlnAdt(const AValue: Boolean);
    function GetEmpDoc: String;
    function GetEspDoc: String;
    procedure SetEmpDoc(const AValue: String);
    procedure SetEspDoc(const AValue: String);
    function GetAutInc: String;
    procedure SetAutInc(const AValue: String);
    function GetSerDoc: String;
    procedure SetSerDoc(const AValue: String);
    function GetDtaFat: TDateTime;
    procedure SetDtaFat(const AValue: TDateTime);
    function GetHraFat: TDateTime;
    procedure SetHraFat(const AValue: TDateTime);
    function GetFatMen: Boolean;
    procedure SetFatMen(const AValue: Boolean);
    function GetBlnTxEnt: Boolean;
    function GetVlrEqu: Double;
    procedure SetVlrEqu(const Value: Double);
    function GetTotMes: Double;
    procedure SetTotMes(const Value: Double);
    function GetDtaIniCob: TDateTime;
    function GetHraIniCob: TDateTime;
    function GetPerTotDes: Double;
    function GetVlrTotDes: Double;
    function GetDtaFinCob: TDateTime;
    function GetHraFinCob: TDateTime;
    function GetValCtr: TValidarContrato;
    function GetStrObs: String;
    procedure SetStrObs(const Value: String);
    function GetVlrAdc: Double;
    procedure SetVlrAdc(const AValue: Double);
    function CancelarFinanceiroEmAberto: Boolean;
    procedure DeletaCadRec(ANumFat, AEspFat, AEmpFat, ACodCli: String);
    function ValidaLiberacaoEncerramentoContratoComFaturamento: Boolean;
    function ValidaDireitoAcessoExclusaoDuplicatasEmAberto: Boolean;
    function ValidaContratoComAgrupamentoCR: Boolean;
    procedure CarregarDuplicatasFaturadasContratoInterno(ACodEmp, ANumDoc, ACodCli: String);
    function ValidaFaturamentoNoPrazoEstimado: Boolean;
  public
    constructor Create(Owner: TContratoLocacaoEquipamentos; blnCriaTmp: Boolean = True);
    destructor Destroy; override;

    function fAddItemFaturar: TItemFaturamentoContrato;
    function fAddDuplicata: TDupFaturamentoContrato;
    function fRemoveItem(const strCodEql: String): Boolean;
    function fGravaFatura: Boolean;
    function fGravaStatusFaturado(blnEncerrar: Boolean): Boolean;
    function fRetornaItemFatura(const strCodEql: String): TItemFaturamentoContrato;
    function fValidaEncerramentoContrato: Boolean;
    function fEncerrarContrato(blnEncerrar: Boolean): Boolean;
    function fEncerrarItensContrato: Boolean;
    function fVerificaItensNaoEncerrados: Boolean;
    function fCarregarObjetoFaturamento: Boolean;
    function fEmitirFatura: Boolean;
    function fConfirmarFaturamento(blnEncerrar: Boolean): Boolean;
    function fVerificaPodeEncerrarContrato: Boolean;
    function fTaxaEntregaAdicionadaFatura: Boolean;
    function fVerificaTemEquipamentoFaturado: Boolean;
    function fTemEquipamentosSemInspecaoEntrada: Boolean;
    function fTemEquipamentosEncerrados: Boolean;
    function fVerificaTodosItensEncerrados: Boolean;
    function fVerificaPodeEncerrarItensMarcados: Boolean;
    function fAtualizaObservacaoImpressao: Boolean;
    function TodosEquipamentosMarcadosFaturar: Boolean;

    function fIncluiItens: Boolean;
    procedure pCalcularTotais;
    procedure pLimpar;
    procedure pCarregarFaturamento(AEncerrados: Boolean =  True);
    procedure pCarregarDetalhamentoFaturamento(const strEspDoc, strEmpDoc, strNumDoc: String;
      const strCodEql: String = '');
    procedure pRecalcularFaturamentoMensal(Const aDataRef: TDateTime);
    procedure pCarregarItensAFaturar;
    procedure pCarregarDuplicatas;
    procedure pMarcaEncerrarItens(const blnMarcar: Boolean);
    procedure pCarredaDadosAdiantamento(const strAutIncPed: String = '');
    procedure pVerificaDtaHraCobranca;
    function  VerificaDocumentoAgrupado(AEspDoc, ANumDoc, ACliFor: String): Boolean;
    procedure CarregarDuplicatasFaturadasContrato;
    function EncerrarTodosItensContrato: Boolean;

    property AutInc: String read GetAutInc write SetAutInc;
    property Contrato: TContratoLocacaoEquipamentos read GetContrato write SetContrato;
    property CodCondicaoPgto: String read GetCodCnd write SetCodCnd;
    property CondicaoPgto: String read GetDesCnd write SetDesCnd;
    property CodFormaPgto: String read GetCodFpg write SetCodFpg;
    property DataReferencia: TDateTime read GetDtaRef write SetDtaRef;
    property HoraReferencia: TDateTime read GetHorRef write SetHorRef;
    property TipoFaturamento: TTipoFaturamentoLocacao read GetTipFat write SetTipFat;
    property ObjFatVenda: TFatVenda read GetObjFtV;
    property ValorTotalFaturar: Double read GetVlrAFt write SetVlrAFt;
    property ValorTotalCobrancaInspecao: Double read GetVlrIpe write SetVlrIpe;
    property ValorTotal: Double read GetVlrTot write SetVlrTot;
    property ValorTotalJaFaturado: Double read GetVlrJFt write SetVlrJFt;
    property ValorTotalRestante: Double read GetVlrRFt write SetVlrRFt;
    property ValorTotalRestanteLiquido: Double read GetVlrRFl write SetVlrRFl;
    property MensagemRetorno: String read GetMsgRet;
    property blnEncerrarContrato: Boolean read GetEncCtr write SetEncCtr;
    property blnEmitirBoleato: Boolean read GetBlnBol write SetBlnBol;
    property ListaItens: TList<TItemFaturamentoContrato> read GetLItens;
    property TotalDiaCal: Double read GetTotDia write SetTotDia;
    property TotalHorCal: Double read GetTotHor write SetTotHor;
    property strDocumentoGerado: String read GetDocGer write SetDocGer;
    property NumDoc: String read GetNumDoc write SetNumDoc;
    property EspDoc: String read GetEspDoc write SetEspDoc;
    property EmpDoc: String read GetEmpDoc write SetEmpDoc;
    property SerDoc: String read GetSerDoc write SetSerDoc;
    property Duplicatas: TList<TDupFaturamentoContrato> read GetLDup;
    property blnInformarFormaPgto: Boolean read GetInfPgt write SetInfPgt;
    property blnBoletoImpresso: Boolean read GetBltImp;
    property strNumDocAdt: String read GetNumDocAdt;
    property strEspDocAdt: String read GetEspDocAdt;
    property strEmpDocAdt: String read GetEmpDocAdt;
    property blnRealizarAdiantamentoAgrup: Boolean read GetBlnAdt write SetBlnAdt;
    property DataFaturamento: TDateTime read GetDtaFat write SetDtaFat;
    property HoraFaturamento: TDateTime read GetHraFat write SetHraFat;
    property blnEmFaturamentoMensal: Boolean read GetFatMen write SetFatMen;
    property BlnAdicionarTaxaEntrega: Boolean read GetBlnTxEnt;
    property ValorTotalEqlLocacao: Double read GetVlrEqu write SetVlrEqu;
    property TotalMesCal: Double read GetTotMes write SetTotMes;
    property dtaIniCobranca: TDateTime read GetDtaIniCob;
    property hraIniCobranca: TDateTime read GetHraIniCob;
    property ValorTotalDesconto: Double read GetVlrTotDes;
    property ValorTotalPerDesc: Double read GetPerTotDes;
    property blnFatEmitida: Boolean read FblnFatEmitida;
    property dtaFinCobranca: TDateTime read GetDtaFinCob;
    property hraFinCobranca: TDateTime read GetHraFinCob;
    property objValidaCtr: TValidarContrato read GetValCtr;
    property strObservacao: String read GetStrObs write SetStrObs;
    property ValorTotalAdicionalAcessorio: Double read GetVlrAdc write SetVlrAdc;
  End;

  TItemFaturamentoContrato = Class
  [weak]
  private	
    FFatura: TFaturamentoContrato;
    FItem  : TItemContratoLocacaoEquipamentos;
    FVlJFat: Double;
    FVlAFat: Double;
    FVlRFat: Double;
    FVlrDsc: Double;
    FVlrLiq: Double;
    FVlrTot: Double;
    FDtaEnc: TDateTime;
    FDuracaoLocacaoItem: Double;
    FVlrCob: Double;
    FDtaRef: TDateTime;
    FValorLocacaoOriginal: Double;
    FTotHorCalc: Double;
    FTotDiaCalc: Double;
    FblnEncerrarItem: Boolean;
    FblnFaturarItem: Boolean;
    FDataRefFat : TDateTime;
    FTaxEnt: Double;
    FBlnAdicionarTaxEntItem: Boolean;
    FTaxEntFat: Double;
    FTotMesCalc: Double;
    FDtaFat: TDateTime;
    FNumFat: String;
    FValFat: Double;
    FQtdHor: Double;
    FEmpFat: String;
    FEspFat: String;
    FValorLocacaoCalculado: Double;
    FPerDes: Double;
    FTotDes: Double;
    FblnAlterarValorManual: Boolean;
    FdtaIniCobFat: TDateTime;
    FdtaFinCobFat: TDateTime;
    FVlrAdc: Double;
    FVlrAdcFat: Double;

    function GetDscFat: Double;
    function GetDtaEnc: TDateTime;
    function GetVlRFat: Double;
    function GetVlAFat: Double;
    function GetVlJFat: Double;
    function GetVlLiqR: Double;
    procedure SetDscFat(const AValue: Double);
    procedure SetDtaEnc(const AValue: TDateTime);
    procedure SetVlRFat(const AValue: Double);
    procedure SetVlAFat(const AValue: Double);
    procedure SetVlJFat(const AValue: Double);
    procedure SetVlLiqR(const AValue: Double);
    function GetItem: TItemContratoLocacaoEquipamentos;
    procedure SetItem(const AValue: TItemContratoLocacaoEquipamentos);
    function GetVlrTot: Double;
    procedure SetVlrTot(const AValue: Double);
    function GetDurLoc: Double;
    procedure SetDurLoc(const AValue: Double);
    function GetVlrCob: Double;
    procedure SetVlrCob(const AValue: Double);
    function GetDtaRef: TDateTime;
    procedure SetDtaRef(const AValue: TDateTime);
    function GetVlrLoc: Double;
    procedure SetVlrLoc(const AValue: Double);
    function GetTotDia: Double;
    function GetTotHor: Double;
    procedure SetTotDia(const AValue: Double);
    procedure SetTotHor(const AValue: Double);
    function GetBlnEnc: Boolean;
    procedure SetBlnEnc(const AValue: Boolean);

    function  fAlteraValorLiquidoItem(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False; blnReacalcularTotaisLiq: Boolean = False): Boolean;
    procedure pRecalculaContratoDataRef(const aDataReferencia: TDateTime);
    procedure pCalcularEncerramentoItemParcial(aDataReferencia: TDateTime;
      fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False);
    procedure pCalcularEncerramentoItem(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False);
    procedure pCalcularFaturamentoItem(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False);
    function GetBlnFat: Boolean;
    procedure SetBlnFat(const AValue: Boolean);
    procedure pCalcularDuracaoItem(const aDataReferencia: TDateTime);
    function GetBlnTaxEnt: Boolean;
    procedure SetBlnTaxEnt(const AValue: Boolean);
    procedure SetDtaFat(const AValue: TDateTime);
    function GetDtaFat: TDateTime;
    function GetNumFat: String;
    procedure SetNumFat(const AValue: String);
    function GetValFat: Double;
    procedure SetValFat(const AValue: Double);
    procedure pLimparValoresItemFatura;
    function GetPerFat: Double;
    function GetTotDsc: Double;
    procedure SetPerFat(const AValue: Double);
    procedure SetTotDsc(const AValue: Double);
    function GetDtaIniCob: TDateTime;
    procedure SetDtaFinCob(const Value: TDateTime);
    function GetDtaFinCob: TDateTime;
    procedure SetDtaIniCob(const Value: TDateTime);
    function GetVlrAdc: Double;
    procedure SetVlrAdc(const AValue: Double);
    function GetDiaCal: Double;
    function GetHorCal: Double;
    function GetMesCal: Double;
    function PodeFaturarCobrancaInspecao: Boolean;
    function ItemPossuiValorCobrancaTroca: Boolean;
  public
    constructor Create(Owner: TFaturamentoContrato);
    destructor Destroy; override;

    procedure pCarregarDadosFaturamentoPorEquipamento(const strCodEql: String; strNumDoc: String = '');
    procedure pRecalcularFaturamentoTotal(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False; blnReacalcularTotaisLiq: Boolean = False;
      blnEncerrarItem: Boolean = False);
    procedure pRecalcularFaturamentoParcial(const aDataReferencia: TDateTime; fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False; blnEncerrarItem: Boolean = False);
    procedure pLimpar;

    function fGravaFatura(): Boolean;
    function fObterDataReferenciaUltimoFaturamento: TDateTime;

    property itemContrato: TItemContratoLocacaoEquipamentos read GetItem write SetItem;
    property ValorJaFaturado: Double read GetVlJFat write SetVlJFat;
    property ValorAFaturar: Double read GetVlAFat write SetVlAFat;
    property ValorRestanteAFaturar: Double read GetVlRFat write SetVlRFat;
    property ValorDescontoFat: Double read GetDscFat write SetDscFat;
    property ValorLiquidoRestante: Double read GetVlLiqR write SetVlLiqR;
    property DataEncerramento: TDateTime read GetDtaEnc write SetDtaEnc;
    property ValorTotal: Double read GetVlrTot write SetVlrTot;
    property DuracaoLocacao: Double read GetDurLoc write SetDurLoc;
    property ValorCobranca: Double read GetVlrCob write SetVlrCob;
    property DataReferencia: TDateTime read GetDtaRef write SetDtaRef;
    property ValorLocacaoOriginal: Double read GetVlrLoc write SetVlrLoc;
    property TotalDiaCal: Double read GetTotDia write SetTotDia;
    property TotalHorCal: Double read GetTotHor write SetTotHor;
    property blnEncerrarItem: Boolean read GetBlnEnc write SetBlnEnc;
    property blnFaturarItem: Boolean read GetBlnFat write SetBlnFat;
    property BlnAdicionarTaxEntItem: Boolean read GetBlnTaxEnt write SetBlnTaxEnt;
    property DataFaturamento: TDateTime read GetDtaFat write SetDtaFat;
    property NumFat: String read GetNumFat write SetNumFat;
    property ValorFaturamento: Double read GetValFat write SetValFat;
    property QtdHor: Double read FQtdHor write FQtdHor;
    property ValorPerDescontoFat: Double read GetPerFat write SetPerFat;
    property ValorTotalDesconto: Double read GetTotDsc write SetTotDsc;
    property ValorLocacaoCalculado: Double read FValorLocacaoCalculado;
    property blnAlterarValorManual: Boolean read FblnAlterarValorManual write FblnAlterarValorManual;
    property dtaIniCobFat: TDateTime read GetDtaIniCob write SetDtaIniCob;
    property dtaFinCobFat: TDateTime read GetDtaFinCob write SetDtaFinCob;
    property ValorAdicionalAcessorio: Double read GetVlrAdc write SetVlrAdc;
    property DiasCalc: Double read GetDiaCal;
    property HorasCalc: Double read GetHorCal;
    property MesesCalc: Double read GetMesCal;
    property EmpFat: String read FEmpfat;
    property EspFat: String read FEspfat;

  End;

  TDupFaturamentoContrato = Class
  [weak]
  private
    FFatura: TFaturamentoContrato;
    FGerBol: Boolean;
    FEmpDoc: String;
    FEspDoc: String;
    FNumDup: String;
    FParcel: String;
    FVlrDup: Double;
    FCodCli: String;
    FNomCli: String;
    FDocCon: String;
    FblnBoletoImpresso: Boolean;
    FAutInc: String;
    FDupOri: String;
    FVlrRec: Double;
    FDtaVen: TDateTime;
    FDtaEmi: TDateTime;
    FDtaRec: TDateTime;

    function GetGerBol: Boolean;
    function GetNumDup: String;
    function GetParcel: String;
    function GetVlrDup: Double;
    procedure SetGerBol(const AValue: Boolean);
    procedure SetNumDup(const AValue: String);
    procedure SetParcel(const AValue: String);
    procedure SetVlrDup(const AValue: Double);
    function GetEspDoc: String;
    procedure SetEspDoc(const AValue: String);
    function GetEmpDoc: String;
    procedure SetEmpDoc(const AValue: String);
    function GetCodCli: String;
    function GetDocCon: String;
    function GetNomCli: String;
    procedure SetCodCli(const AValue: String);
    procedure SetDocCon(const AValue: String);
    procedure SetNomCli(const AValue: String);
    function GetBlnBol: Boolean;
    procedure SetBlnBol(const AValue: Boolean);
    function GetAutInc: String;
    procedure SetAutInc(const AValue: String);
    function GetDupOri: String;
    procedure SetDupOri(const AValue: String);
    function GerVlrRec: Double;
    procedure SetVlrRec(const AValue: Double);
    function GetDtaEmi: TDateTime;
    function GetDtaVen: TDateTime;
    procedure SetDtaEmi(const AValue: TDateTime);
    procedure SetDtaVen(const AValue: TDateTime);
    function GetDtaRec: TDateTime;
    procedure SetDtaRec(const AValue: TDateTime);
  public
    constructor Create(Owner: TFaturamentoContrato);
    destructor Destroy; override;

    property AutInc: String read GetAutInc write SetAutInc;
    property NumDup: String read GetNumDup write SetNumDup;
    property EspDoc: String read GetEspDoc write SetEspDoc;
    property EmpDoc: String read GetEmpDoc write SetEmpDoc;
    property Parcela: String read GetParcel write SetParcel;
    property ValorDuplicata: Double read GetVlrDup write SetVlrDup;
    property BoletoGerado: Boolean read GetGerBol write SetGerBol;
    property CodCliente: String read GetCodCli write SetCodCli;
    property NomCliente: String read GetNomCli write SetNomCli;
    property DocContrato: String read GetDocCon write SetDocCon;
    property blnBoletoImpresso: Boolean read GetBlnBol write SetBlnBol;
    property strListaDuplicatasOrig: String read GetDupOri write SetDupOri;
    property ValorReceber: Double read GerVlrRec write SetVlrRec;
    property DataEmissao: TDateTime read GetDtaEmi write SetDtaEmi;
    property DataVencimento: TDateTime read GetDtaVen write SetDtaVen;
    property DataRecebimento: TDateTime read GetDtaRec write SetDtaRec;
  End;

  TFaturamentoMensalContrato = Class
  private
    FListaFaturaContrato: TList<TFaturamentoContrato>;
    FDataReferencia: TDateTime;
    FObjContratoTmp: TContratoLocacaoEquipamentos;
    FblnImpBoletoFinalizacao: Boolean;
    FblnAgruparDuplicatas: Boolean;
    FMensagemRetorno: String;
    FVlrTotRec: Double;
    FObjFatVenda: TFatVenda;
    FCodCnd: String;
    FCndPag: String;
    FForPag: String;
    FCodVen: String;
    FCodPor: String;
    FListaDuplicatasAgrup: TList<TDupFaturamentoContrato>;
    FblnBoletoImpresso: Boolean;
    arrDupDocs: TArrDigDuplicArray;
    arrDuplicAgr: TArrDigDuplicArray;
    arrDuplicIPI: TArrDigDuplicArray;
    arrDuplicRet: TArrDigDuplicArray;
    arrDuplicAce: TArrDigDuplicArray;
    arrDuplicFre: TArrDigDuplicArray;
    arrDuplicCbs: TArrDigDuplicArray;
    arrDuplicIbs: TArrDigDuplicArray;
    arrDuplicIs : TArrDigDuplicArray;
    arrDupAgr: Array Of TDuplicatasAgrupadas;
    arrDupSel: Array Of TDuplicataCtr;
    FobjLock: TLock;
    FobjValidaCtr: TValidarContrato;

    function GetDtaRef: TDateTime;
    procedure SetDtaRef(const AValue: TDateTime);
    function GetLstFat: TList<TFaturamentoContrato>;
    procedure SetLstFat(const AValue: TList<TFaturamentoContrato>);
    function GetImpBol: Boolean;
    procedure SetImpBol(const AValue: Boolean);
    function GetAgrDup: Boolean;
    procedure SetAgrDup(const AValue: Boolean);
    function GetMsgRet: String;
    function GetVlrRec: Double;
    procedure SetVlrRec(const AValue: Double);
    function GetLDup: TList<TDupFaturamentoContrato>;
    function GetBlnBol: Boolean;

    procedure pCarregarFaturamento;
    procedure pImprimirBoletoAgrupamento;
    procedure pMontaObservacao(dagAgrup: TDadosAgrup; strNumDup: String);
    procedure pAjustarGravacaoPortador(qryCtrRec: TUniQuery; strNumAgr, strEspAgr, strEmpDuplic: String);

    function fVerificaContratoJaFoiAdicionado(const strNroCtr: String): Boolean;
    function fEmitirFaturasIndividuais(const blnImprimirBoleto: Boolean): Boolean;
    function fEmitirFaturasAgrupadas(const blnImprimirBoleto: Boolean): Boolean;
    function fAplicaTaxaJurosAgrupamento(strCodCnd, strConPag: String; fltTotCli, fltValor, fltTotAgr: Double): Double;
    function fGravaAgrupamentos(qryCtrRec: TUniQuery; strCodCli, strCodEmp: String;
      dtaDtaAgr: TDateTime; strConPag: String; fltTotAgr, fldTotCli, fldTotIPI, fldTotRet, fldTotAce, fldTotFre: Double;
      strContratos: String): Boolean;
    function fEmpVen(codVen:String): String;
    function fDeletaDuplicatas: Boolean;
    function fValidaValorAgrupamento(strNumAgr, strCodCli, strEmpAgr: String; blnDescontoAteVencimento: Boolean): Boolean;
    function fCalculaTaxVpr(strConPag: String; fltTxJCnd: Double): Double;
    function fRetAutIncAgrp(const strCodEmp, strNumAgrp,strEspDoc, strCodCli: String): String;
    function fRefotnaQtdDAV(const strCodCnd, strCodCli: String): Integer;
    function fRefotnaPerDpo(const strCodCnd, strCodCli: String): Double;
    function fRetornaQuantidadeParcelas(intQtdParc: Integer): Integer;
    function fInserirAgrupamento(const strNumAgr, strEmpDuplic, strConPag: String; fltTotAgr, fltTotCli: Double; blnDescontoAteVencimento: Boolean; qryCtrRec: TUniQuery): Boolean;
    function fRetornaContratosRecebidos: String; overload;
    function fRetornaContratosRecebidos(const strNumDup: String): String; overload;
    function fCalcularJurRep(const fltTotJur, fltVlrCor, fltTotCli :Double): Double;
    function fCalcularValCor(const fltJurRep, fltTotAgr, fltValCor :Double): Double;
    function fCalcularDifJuros(const fltTotCalc, fltTotJur, fltJurRep :Double): Double;
    function fRetornaSQLDuplicatas(const strNumDup: String; blnDescontoAteVencimento: Boolean): String;
    function fRetornaSQLDuplicatasAgrupadas(const strNumDup: String; blnDescontoAteVencimento: Boolean): String;
    function fRetornaDuplicatasAgrupamento(const strListaAgrp: String): String;
    function GetValCtr: TValidarContrato;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pLimpar;
    procedure pCalculaTotais;
    procedure pDestravar;

    function fCarregarContratos(const aNroContrato: String; const aCodCli: String; const aMesRef: String; const aDataReferencia: TDateTime): Boolean;
    function fAddContrato(objContrato: TContratoLocacaoEquipamentos): TFaturamentoContrato; overload;
    function fAddContrato(const strNroCtr: String): TFaturamentoContrato; overload;
    function fRemoveContrato(const aAutInc: String): Boolean;
    function fEmitirFaturas(const blnImprimirBoleto, blnAgruparDuplicatas: Boolean): Boolean;
    function fEmitirContasReceberAgrupamento: Boolean;
    function fInformarCondicaoPagamento: Boolean;
    function fInformarPortadorParaAgrupamento(const qtdAgrp: Integer; qry: TUniQuery): Boolean;
    function fAddDuplicataAgrup: TDupFaturamentoContrato;
    function fValidaPodeEmitirFaturas: Boolean;

    property DataReferencia: TDateTime read GetDtaRef write SetDtaRef;
    property ListaFatura: TList<TFaturamentoContrato> read GetLstFat write SetLstFat;
    property blnImpBoletoFinalizacao: Boolean read GetImpBol write SetImpBol;
    property blnAgruparDuplicatas: Boolean read GetAgrDup write SetAgrDup;
    property MensagemRetorno: String read GetMsgRet;
    property ValorTotalReceber: Double read GetVlrRec write SetVlrRec;
    property Duplicatas: TList<TDupFaturamentoContrato> read GetLDup;
    property blnBoletoImpresso: Boolean read GetBlnBol;
    property objValidaCtr: TValidarContrato read GetValCtr;
  End;

  TImpressaoFatLocacao = Class
  private
    FListaFaturaContrato: TList<TFaturamentoContrato>;
    FObjContratoTmp: TContratoLocacaoEquipamentos;
    FMensagemRetorno: String;
    FstrLayPadrao: String;
    FstrPathEti: String;
    FstrPathRel: String;
    FstrNomForm: String;
    FfrxContratoLocacao: TfrxReport;
    FstrNomImp: String;
    FstrNomArq: String;
    FstrPathImp: String;
    FfrxPDFContratoLocacao: TfrxPDFExport;
    FblnVisualizar: Boolean;
    FstrLayRL: String;

    function fImprimirReciboPadraoFaturas(const tpaTipArq: TTipoArquivo): Boolean;
    function fImprimirReciboFr3Faturas(const tpaTipArq: TTipoArquivo): Boolean;
    function fVerificaPodeImprimirFatura(): Boolean;

    procedure pLimpar;

    function GetLstFat: TList<TFaturamentoContrato>;
    function GetMsgRet: String;
    function GetNomArq: String;
  public
    constructor Create(const strNomForm: String);
    destructor Destroy; override;

    function fAddFatura(objContrato: TContratoLocacaoEquipamentos;
      strEspDoc, strEmpDoc, strNumDoc: String): Boolean;
    function fRemoverFatura(objContrato: TContratoLocacaoEquipamentos): Boolean;
    function fImprmirReciboFat(tpaTipArq: TTipoArquivo): Boolean;

    property ListaFaturaContrato: TList<TFaturamentoContrato> read GetLstFat;
    property strMensagemRetorno: String read GetMsgRet;
    property strNomArq: String read GetNomArq;
    property blnVisualizar: Boolean read FblnVisualizar write FblnVisualizar;
  End;

  TGeraArquivoAnexoEmail = class(TInterfacedObject, IGeraArquivoAnexoEmailAutomatico)
  private
    FstrNomArq: String;
    FAcesso: String;
    FSerie_: String;
    FStatus: TStatusDisparaEmail;
    FEnviaArquivoXML: Boolean;
    FEnviaArquivoPdf: Boolean;

    function GetAcesso() : String;
    function GetSerie() : String;
    function GetStatus() : TStatusDisparaEmail;

    procedure SetAcesso(const Value : String);
    procedure SetSerie(const Value : String);
    procedure SetStatus(const Value : TStatusDisparaEmail);
    function fGetEnviaArquivoXml: Boolean;
    procedure pSetEnviaArquivoXml(const Value: Boolean);
    function fGetEnviaArquivoPdf: Boolean;
    procedure pSetEnviaArquivoPdf(const Value: Boolean);
  public
    constructor Create(strNomArq: String);

    function fGeraArquivoAnexo(blnGerandoParaDisparoDeGatilho: Boolean) : TList<TRecArquivosGatilhos>;
    class function fNew(strNomArq: String): IGeraArquivoAnexoEmailAutomatico;

    property Acesso: string read GetAcesso write SetAcesso;
    property Serie: string read GetSerie write SetSerie;
    property Status: TStatusDisparaEmail read GetStatus write SetStatus;
    property EnviaArquivoXml: Boolean read fGetEnviaArquivoXml write pSetEnviaArquivoXml;
    property EnviaArquivoPdf: Boolean read fGetEnviaArquivoPdf write pSetEnviaArquivoPdf;
  End;


implementation

uses
  untFatBaixarPedOrcNaoEntregue, untGravando, untCadLote,
  untSelDocEntrada, untDuplicatas, untDigCndPagamento, untDigCndPagamentoFrame, untLiberacao, untMsgLiberacao,
  Math, untAdiantamentoCliente, untValidaSituacaoFinanceiraPedido, untWord, untFuncoesGenerica,
  untEditorFastImpressao, TypesRel, untCarnePagto, untCadRec, untDigPortador, untBoleto, untConstantes, untFuncoesLocEqu,
  untLogCtr, Faturamento.Classes.CalcularFaturaLocEqu;

{ TFaturamentoContrato }

function TFaturamentoContrato.CancelarFinanceiroEmAberto: Boolean;
var
  LCont: Integer;
begin
  If Not FExcluirFaturamentoEncerramento Then
    Exit(True);

  Try
    pCarregarFaturamento(False);
    For LCont:= 0 To FListaItens.Count-1 Do
    Begin

      If VerificaDocumentoAgrupado(FListaItens[LCont].EspFat,
                                   FListaItens[LCont].NumFat,
                                   FContrato.Cliente.Codigo ) Then

      Begin
        FMensagemRetorno := 'O documento ' + FListaItens[LCont].NumFat + '-' + FListaItens[LCont].EspFat +
                            ' possui agrupamentos, portanto não será possível realizar o cancelamento do financeiro';
        Result := False;
        Exit;

      End;

      DeletaCadRec(FListaItens[LCont].NumFat,
                   FListaItens[LCont].EspFat,
                   FListaItens[LCont].EmpFat,
                   FContrato.Cliente.Codigo);
    End;

    Result := True;

  Except
    On e: Exception do
    Begin
      pMensagensErro(e.Message, '[TFaturamentoContrato.CancelarFinanceiroEmAberto]');
      Result := False;
    End;
  End;
end;

procedure TFaturamentoContrato.CarregarDuplicatasFaturadasContrato;
var
  qrySelect: TUniQuery;
begin
  FListaDuplicatas.Clear;

  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT * FROM EQLFAT             ');
    qrySelect.SQL.Add('WHERE                            ');
    qrySelect.SQL.Add('  EQF_SEQCON = :SEQCON           ');
    qrySelect.ParamByName('SEQCON').AsString := FContrato.AutInc;
    qrySelect.Open;
    While Not qrySelect.Eof Do
    Begin
      CarregarDuplicatasFaturadasContratoInterno(qrySelect.FieldByName('EQF_EMPDOC').AsString,
                                                 qrySelect.FieldByName('EQF_NUMDOC').AsString,
                                                 FContrato.CodCliente);
      qrySelect.Next;
    End;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

procedure TFaturamentoContrato.CarregarDuplicatasFaturadasContratoInterno(
  ACodEmp, ANumDoc, ACodCli: String);
var
  qrySelectCadRec: TUniQuery;
  ItemDuplicata: TDupFaturamentoContrato;
Begin
  qrySelectCadRec := fCriaQuery;
  Try
    qrySelectCadRec.SQL.Clear;
    qrySelectCadRec.SQL.Add('SELECT C.AUTOINCREM,             ');
    qrySelectCadRec.SQL.Add('       C.CTR_NUMDUP,             ');
    qrySelectCadRec.SQL.Add('       C.CTR_CODEMP,             ');
    qrySelectCadRec.SQL.Add('       C.CTR_ESPDOC,             ');
    qrySelectCadRec.SQL.Add('       C.CTR_PARCEL,             ');
    qrySelectCadRec.SQL.Add('       (CASE WHEN C.CTR_ESPDOC = "AG" THEN D.CTR_VALDUP  ');
    qrySelectCadRec.SQL.Add('        ELSE C.CTR_VALDUP END) AS CRT_VALDUP,            ');
    qrySelectCadRec.SQL.Add('       C.CTR_VALDUP as CTR_VALREC,');
    qrySelectCadRec.SQL.Add('       C.CTR_DTACAD,             ');
    qrySelectCadRec.SQL.Add('       C.CTR_DTAVEN,             ');
    qrySelectCadRec.SQL.Add('       C.CTR_DTAREC              ');
    qrySelectCadRec.SQL.Add('  FROM CADREC C                  ');
    qrySelectCadRec.SQL.Add('  LEFT JOIN DUPAGR D ON (D.CTR_NUMAGR = C.CTR_NUMDUP AND D.CTR_EMPAGR = C.CTR_CODEMP AND D.CTR_CODCLI = C.CTR_CODCLI)');
    qrySelectCadRec.SQL.Add('WHERE                            ');
    qrySelectCadRec.SQL.Add('  C.CTR_CODEMP = :CODEMP         ');
    qrySelectCadRec.SQL.Add('  AND C.CTR_CODCLI = :CODCLI     ');
    qrySelectCadRec.SQL.Add('  AND ((C.CTR_ESPDOC = "NS"      ');
    qrySelectCadRec.SQL.Add('    OR C.CTR_ESPDOC = "RL")      ');
    qrySelectCadRec.SQL.Add('  AND C.CTR_NUMDUP IN (:NUMDUP)) ');
    qrySelectCadRec.SQL.Add('  OR (C.CTR_ESPDOC ="AG" AND D.CTR_EMPAGR = :CODEMP  AND D.CTR_NUMDUP IN (:NUMDUP)) ');

    qrySelectCadRec.ParamByName('CODEMP').AsString := ACodEmp;
    qrySelectCadRec.ParamByName('NUMDUP').AsString := ANumDoc;
    qrySelectCadRec.ParamByName('CODCLI').AsString := ACodCli;
    qrySelectCadRec.Open;
    If Not qrySelectCadRec.IsEmpty Then
    Begin
      While Not qrySelectCadRec.EOF  Do
      Begin
        ItemDuplicata := fAddDuplicata;
        ItemDuplicata.AutInc :=  qrySelectCadRec.FieldByName('AUTOINCREM').AsString;
        ItemDuplicata.NumDup :=  qrySelectCadRec.FieldByName('CTR_NUMDUP').AsString;
        ItemDuplicata.EmpDoc :=  qrySelectCadRec.FieldByName('CTR_CODEMP').AsString;
        ItemDuplicata.EspDoc :=  qrySelectCadRec.FieldByName('CTR_ESPDOC').AsString;
        ItemDuplicata.Parcela :=  qrySelectCadRec.FieldByName('CTR_PARCEL').AsString;
        ItemDuplicata.ValorDuplicata := qrySelectCadRec.FieldByName('CRT_VALDUP').AsFloat;
        ItemDuplicata.ValorReceber := qrySelectCadRec.FieldByName('CTR_VALREC').AsFloat;
        ItemDuplicata.DataEmissao := qrySelectCadRec.FieldByName('CTR_DTACAD').AsDateTime;
        ItemDuplicata.DataVencimento := qrySelectCadRec.FieldByName('CTR_DTAVEN').AsDateTime;
        ItemDuplicata.DataRecebimento := qrySelectCadRec.FieldByName('CTR_DTAREC').AsDateTime;

        qrySelectCadRec.Next;
      End;
    End;
  Finally
    FreeAndNil(qrySelectCadRec);
  End;
End;

constructor TFaturamentoContrato.Create(Owner: TContratoLocacaoEquipamentos; blnCriaTmp: Boolean = True);
begin

  FContrato := Owner;
  pCriarCdsVenda(nil);

  FObjfatVenda := TFatVenda.CreateInstance('LE', blnCriaTmp);
  FListaItens := TList<TItemFaturamentoContrato>.Create;
  FListaDuplicatas := TList<TDupFaturamentoContrato>.Create;
  FblnInformarFormaPgto := True;
  FblnBoletoImpresso := False;
  FblnTransacaoIniciada := False;
  FEmFaturamentoMensal := False;
  FblnRealizarAdiantamentoAgrup := False;
  FBlnAdicionarTaxaEntrega := False;
  FobjValidaCtr := TValidarContrato.Create(FContrato);
end;

procedure TFaturamentoContrato.DeletaCadRec(ANumFat, AEspFat, AEmpFat,
  ACodCli: String);
Var
  LqryDel: TUniQuery;
begin
  LqryDel := fCriaQuery(Nil);
  Try
    LqryDel.SQL.Clear;
    LqryDel.SQL.Add('SELECT SQL_NO_CACHE * FROM ');
    LqryDel.SQL.Add('  CADREC                   ');
    LqryDel.SQL.Add('WHERE                      ');
    LqryDel.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    LqryDel.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    LqryDel.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    LqryDel.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    LqryDel.SQL.Add('  (CTR_DTAREC IS NULL)     ');

    LqryDel.ParamByName('NUMDUP').AsString := ANumFat;
    LqryDel.ParamByName('ESPDOC').AsString := AEspFat;
    LqryDel.ParamByName('CODEMP').AsString := AEmpFat;
    LqryDel.ParamByName('CODCLI').AsString := ACodCli;

    LqryDel.Close;
    LqryDel.Open;
    While Not LqryDel.Eof Do
    Begin
      pGravaDelCadRec(LqryDel.FieldByName('AUTOINCREM').AsString, 'TFaturamentoContrato');
      untLogCtr.GravaLogCtr(LqryDel.FieldByName('AUTOINCREM').AsString, 'EXCLUSÃO DE DUPLICATA', 'TFaturamentoContrato');

      LqryDel.Next;
    End;

    LqryDel.Close;


    LqryDel.SQL.Clear;
    LqryDel.SQL.Add('DELETE FROM  CADREC        ');
    LqryDel.SQL.Add('                           ');
    LqryDel.SQL.Add('WHERE                      ');
    LqryDel.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    LqryDel.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    LqryDel.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    LqryDel.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    LqryDel.SQL.Add('  (CTR_DTAREC IS NULL)     ');
    LqryDel.ParamByName('NUMDUP').AsString := ANumFat;
    LqryDel.ParamByName('ESPDOC').AsString := AEspFat;
    LqryDel.ParamByName('CODEMP').AsString := AEmpFat;
    LqryDel.ParamByName('CODCLI').AsString := ACodCli;
    LqryDel.ExecSQL;

  Finally
    FreeAndNil(LqryDel);
  End;
end;

destructor TFaturamentoContrato.Destroy;
begin
  inherited;

  FreeAndNil(FListaItens);
  pFreeCdsVenda;
  FreeAndNil(FObjfatVenda);
  FreeAndNil(FListaDuplicatas);
  FreeAndnil(FobjValidaCtr);
end;

function TFaturamentoContrato.EncerrarTodosItensContrato: Boolean;
var
  strUpdateEqlDet: String;
  qryUpd: TUniQuery;
begin
  strUpdateEqlDet := '';
  strUpdateEqlDet := strUpdateEqlDet + 'UPDATE EQLDET SET EQD_DTAENC = :DTAENC ';
  strUpdateEqlDet := strUpdateEqlDet + 'WHERE EQD_SEQCON = :SEQCON             ';
  strUpdateEqlDet := strUpdateEqlDet + '  AND EQD_DTAENC IS NULL               ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Text := strUpdateEqlDet;
    qryUpd.ParamByName('SEQCON').AsString := FContrato.AutInc;
    qryUpd.ParamByName('DTAENC').AsDateTime := fNow();
    qryUpd.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function TFaturamentoContrato.fGravaFatura: Boolean;
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaItens.Count -1 do
  Begin
    If FListaItens[intCnt].blnFaturarItem Then
      FListaItens[intCnt].fGravaFatura;
  End;

  Result := True;
end;

function TFaturamentoContrato.fGravaStatusFaturado(blnEncerrar: Boolean): Boolean;
var
  strSQL: String;
  qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery();
  Try
    Try
      If FTipoFaturamento = tpTotal Then
        pMarcaEncerrarItens(True);

      If Not fEncerrarItensContrato Then
        Exit(True);

      If Not fVerificaItensNaoEncerrados Then
      Begin
        If Not fVerificaTemEquipamentoFaturado Then
        Begin
          If fMensagem('ATENÇÃO', 'O contrato não possui valor de faturamento. ' +
                                  'Depois de faturado não será possível modificá-lo. ' +
                                  'Confirma o encerramento do contrato?', ['&Sim', '&Não']) = 2 Then
          Exit(True);
        End;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE                      ';
      strSQL := strSQL + '  CONEQL                    ';
      strSQL := strSQL + 'SET                         ';
      strSQL := strSQL + '  EQL_STATUS = "F"          ';
      strSQL := strSQL + 'WHERE AUTOINCREM = :AUTOINC ';

      qryUpd.SQL.Text := strSQL;
      qryUpd.ParamByName('AUTOINC').AsString := FContrato.AutInc;

      qryUpd.ExecSQL;
      Result := True;
    Except
      On e: Exception do
      Begin
        pMensagensErro(e.Message, '[TFaturamentoContrato.fGravaStatusFaturado]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function TFaturamentoContrato.fRemoveItem(const strCodEql: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].FItem.Equipamento.Codigo = strCodEql Then
    Begin
      FListaItens.Delete(intCnt);
      Result := True;
      Break;
    End;
  End;
end;

function TFaturamentoContrato.fRetornaItemFatura(
  const strCodEql: String): TItemFaturamentoContrato;
var
  intCont: Integer;
begin
  Result := nil;
  For intCont := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCont].FItem.Equipamento.Codigo = strCodEql Then
    Begin
      Result := FListaItens[intCont];
      Break;
    End;
  End;
end;

function TFaturamentoContrato.fSenhaAlteracaoFormaPagamento: Boolean;
Var
  objLiberacao: TLiberacao;
begin
  If Not fCfgSis('CPGCTR', VarBoolean) Then
  Begin
    Result := True;
    Exit;
  End;

  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTexto('Permitir alterar a condição de pagamento no faturamento da locação quando usa digitação da condição no contrato', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.objMsgLibera.pAddTexto('Nº do Contrato: ' + FContrato.NroContrato , alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + FContrato.CodCliente + ' - ' + FContrato.NomCliente, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Condição anterior: ' + FContrato.CodCondicaoPgto  + ' - ' + FContrato.CondicaoPgto , alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Condição atual: ' + FCodCondicaoPgto + ' - ' + FCondicaoPgto, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Valor do faturamento: ' + FormatFloat('#,##0.00', FVlrTotFat), alEsquerda, teAmbos, '', 99);

    objLiberacao.strDirAce := 'LOCACD';
    objLiberacao.strMsgSen := 'Permitir alterar a condição de pagamento no faturamento da locação quando usa digitação da condição no contrato.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TFaturamentoContrato.fTaxaEntregaAdicionadaFatura: Boolean;
var
  intCnt: Integer;
Begin
  Result := False;
  For intCnt:= 0 To FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].BlnAdicionarTaxEntItem Then
    Begin
      Result := True;
      Break;
    End;
  End;
End;

function TFaturamentoContrato.fTemEquipamentosEncerrados: Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].FItem.DataEncerramento > 0 Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TFaturamentoContrato.fTemEquipamentosSemInspecaoEntrada: Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].FItem.DataInspecaoEntrada <= 0 Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TFaturamentoContrato.fValidaEncerramentoContrato: Boolean;
var
  intCnt: Integer;
  datRefTmp: TDateTime;
begin
  Result := True;
  FMensagemRetorno := EmptyStr;
  datRefTmp := FDtaRef;

  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If FTipoFaturamento = tpTotal then
      FDtaRef := FContrato.fCalculaDataFinalCobranca(FListaItens[intCnt].FItem.DataInicialCobranca, FContrato.TotalHoras)
    Else
      FDtaRef := datRefTmp;

    If FDtaRef < FListaItens[intCnt].FItem.DataInicialCobranca Then
    Begin
      Result := False;
      FMensagemRetorno := 'Verifique a data de referência informada. A data não pode ser inferior à data inicial de cobrança.';
      Exit;
    End;

    If FDtaRef < FListaItens[intCnt].FItem.DataFinalCobranca  Then
    Begin
      If Not fVerificaAcessoSistema('LOCENC') Then
      Begin
        Result := False;
        FMensagemRetorno := 'Operador não possui acesso liberado para encerrar o contrato antes do prazo de término estipulado';
      End
      Else
      Begin
        If FListaItens[intCnt].FItem.TipoCalculoLocacao = tpDiaria Then
        Begin
          If FListaItens[intCnt].FItem.strUtiFaixaNegociacao = 'S' Then
          Begin
            FMensagemRetorno := 'Há equipamentos selecionados no grid que foram contratos utilizando faixa de negociação em dias. '+
                                'Ao continuar, seus valores serão recalculados. Deseja continuar?';
          End;
        End;
      End;
    End;

  End;
end;

function TFaturamentoContrato.fValidarPodeEmitirFatura: Boolean;
begin
  Result := True;
  FblnEncerrarItemFat := fVerificaItensMarcadosEncerrar;
  FMensagemRetorno := EmptyStr;

  If FVlrTotFat <= 0 Then
  Begin

    If (Not ValidaFaturamentoNoPrazoEstimado) And FblnEncerrarItemFat And FEmFaturamentoMensal Then
    Begin
      FMensagemRetorno := 'A data inicial de cobrança está fora do período estimado de locação do contrato '+ FContrato.NroContrato +'. ' +
                          'Realize a prorrogação do contrato ou fature pela rotina "Principal > Faturamento > Locação de Equipamentos > Faturamento"' ;
      Result := False;
      Exit;
    End
    Else If FblnEncerrarItemFat Then
    Begin
      FMensagemRetorno := 'Não existe valor a faturar para o contrato '+ FContrato.NroContrato +'. ' +
                          'Verifique a data de referência informada, data de inspeção de entrada e se há itens selecionados.' ;
      Result := False;
      Exit;
    End
    Else
    Begin
      FMensagemRetorno := 'Não existe valor a faturar para o contrato '+ FContrato.NroContrato +'. ' +
                          'Verifique a data de referência informada e se há itens selecionados.' ;
      Result := False;
      Exit;
    End;
  End;

  If fEmptyStr(fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [FContrato.CodCliente])) Then
  Begin
    FMensagemRetorno := 'A tabela de preço para o cliente "' + FContrato.CodCliente + ' - ' + FContrato.NomCliente + '" '+
                        'não foi informada. Verifique o cadastro do cliente antes de prosseguir.' ;
    Result := False;
    Exit
  End;

  If (FTipoFaturamento = tpTotal) Or ((FTipoFaturamento = tpParcial) And (FEmFaturamentoMensal)) Then
  Begin
    If fTemEquipamentosSemInspecaoEntrada Then
    Begin
      If (FTipoFaturamento = tpTotal) Then
        FMensagemRetorno := 'Existem equipamentos sem a inspeção de entrada, portanto não poderá ser feito o faturamento total!'
      Else
        FMensagemRetorno := 'Existem equipamentos sem a inspeção de entrada, portanto não poderá ser feito o faturamento!';
      Result := False;
      Exit;
    End;
  End;

  If (FTipoFaturamento = tpParcial) Then
  Begin
    If (Not FobjValidaCtr.fVerificaPodeEncerrarItens) Then
    Begin
      FMensagemRetorno := FobjValidaCtr.strMensagemRetorno +
                          ' Portanto, não poderá ser feito o faturamento!';
      Result := False;
      Exit;
    End;
  End;
end;

function TFaturamentoContrato.VerificaDocumentoAgrupado(AEspDoc, ANumDoc,
  ACliFor: String): Boolean;
Var
  LSQL: String;
  LqryGen: TUniQuery;
  LMsg: String;
begin
  Result := False;

  LSQL := '';
  LSQL := LSQL + 'SELECT ';
  LSQL := LSQL + '  CTR_NUMAGR AS NUMAGR, ';
  LSQL := LSQL + '  CONCAT(CTR_NUMDUP,CTR_PARCEL,"-",CTR_ESPDOC) AS NUMDUP, ';
  LSQL := LSQL + '  CTR_DTAVEN AS DTAVEN, ';
  LSQL := LSQL + '  CTR_VALDUP AS VALDUP ';
  LSQL := LSQL + 'FROM ';
  LSQL := LSQL + '  DUPAGR ';
  LSQL := LSQL + 'WHERE ';
  LSQL := LSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  LSQL := LSQL + '  CTR_ESPDOC = :ESPDOC AND ';
  LSQL := LSQL + '  CTR_CODCLI = :CODCLI AND ';
  LSQL := LSQL + '  CTR_CODEMP = :CODEMP     ';
  LSQL := LSQL + 'ORDER BY NUMAGR, NUMDUP, DTAVEN, VALDUP ';

  LqryGen := fCriaQuery;
  Try
    LqryGen.Close;
    LqryGen.SQL.Clear;
    LqryGen.SQL.Add(LSQL);
    LqryGen.ParamByName('NUMDUP').AsString := ANumDoc;
    LqryGen.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryGen.ParamByName('CODCLI').AsString := ACliFor;
    LqryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryGen.Open;
    If (Not LqryGen.IsEmpty) Then
    Begin
      LqryGen.First;
      LMsg := '';
      While Not LqryGen.Eof Do
      Begin
        LMsg := LMsg +
                'Agrup: ' + fPadR(LqryGen.fieldbyname('NUMAGR').AsString,12,' ') +
                ' Duplic: ' + fPadR(LqryGen.fieldbyname('NUMDUP').AsString,12,' ') +
                ' Venc: ' + fPadR(LqryGen.fieldbyname('DTAVEN').AsString,12,' ') +
                ' Valor: ' + FormatFloat('#,##0.00',LqryGen.fieldbyname('VALDUP').AsFloat) + #13#10;
        LqryGen.Next;
      End;

      Try
        pCriarFormularios(TfrmObservacao, frmObservacao);
        Try
          frmObservacao.lblMensagem.caption := 'Duplicata(s) abaixo agrupada(s):';
          frmObservacao.memObs.Texto := LMsg;
          frmObservacao.ShowModal;
        Except
          On E: Exception Do
          Begin
            Result := True;
            pMensagensErro(E.Message, '[TFaturamentoMensalContrato.VerificaDocumentoAgrupado]');
          End;
        End;
      Finally
        pFreeAndNil(frmObservacao);
      End;

    End
    Else
      Result := False;

  Finally
    FreeAndNil(LqryGen);
  End;
end;

function TFaturamentoContrato.fVerificaItensMarcadosEncerrar: Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt:= 0 To FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].blnEncerrarItem Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TFaturamentoContrato.fVerificaPodeEncerrarItensMarcados: Boolean;
var
  intCnt: Integer;
begin
  Result := True;
  For intCnt:= 0 To FListaItens.Count-1 Do
  Begin
    If FListaItens[intCnt].blnEncerrarItem Then
    Begin
      If FListaItens[intCnt].FItem.DataInspecaoEntrada <= 0 Then
      Begin
        FMensagemRetorno := 'O Equipamento "' +
                            FListaItens[intCnt].FItem.Equipamento.Codigo + ' - ' + FListaItens[intCnt].FItem.Equipamento.Descricao + '" não possui inspeção de entrada.';
        Result := False;
        Break;
      End;
    End;
  End;
end;

function TFaturamentoContrato.fVerificaItensNaoEncerrados: Boolean;
var
  qryUpdate: TUniQuery;
  qrySelect: TUniQuery;
begin
  Result := False;
  qrySelect := fCriaQuery;
  qryUpdate := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT (SELECT COUNT(*)    ');
    qrySelect.SQL.Add('  FROM EQLFAT              ');
    qrySelect.SQL.Add(' WHERE EQF_SEQCON = EQD_SEQCON AND  ');
    qrySelect.SQL.Add('       EQF_SEQEQL = EQD_SEQEQL AND  ');
    qrySelect.SQL.Add('       IFNULL(EQF_DTAENC,0) > 0 ) AS QTDNENC FROM EQLDET ');
    qrySelect.SQL.Add('WHERE                      ');
    qrySelect.SQL.Add('  EQD_SEQCON = :EQD_SEQCON ');
    qrySelect.SQL.Add('  GROUP BY EQD_SEQEQL');
    qrySelect.SQL.Add('  ORDER BY EQD_SEQEQL');
    qrySelect.ParamByName('EQD_SEQCON').AsString := FContrato.AutInc;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      While Not qrySelect.EOF Do
      Begin
        Result := (qrySelect.FieldByName('QTDNENC').AsInteger > 0 );

        If Not Result Then
          Break;

        qrySelect.Next;
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
    FreeAndNil(qrySelect);
  End;
end;

function TFaturamentoContrato.fVerificaPodeEncerrarContrato: Boolean;
var
  intCnt: Integer;
  qtdEnc: Integer;
begin
  qtdEnc := 0;
  For intCnt := 0 to FListaItens.Count -1 Do
  Begin
    If FListaItens[intCnt].FItem.DataEncerramento > 0 Then
      inc(qtdEnc)
    Else If FListaItens[intCnt].blnEncerrarItem Then
           inc(qtdEnc);

  End;

  Result := (qtdEnc = FListaItens.Count);
end;

function TFaturamentoContrato.fVerificaTemEquipamentoFaturado: Boolean;
Var
  strSQL     : String;
  qryConsulta  : TUniQuery;
begin
  Result := False;
  qryConsulta := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT COUNT(*) AS QTDFAT FROM EQLFAT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EQF_SEQCON = :SEQCON ';

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(strSQL);
    qryConsulta.ParamByName('SEQCON').AsString := FContrato.AutInc;
    qryConsulta.Open;

    If Not qryConsulta.IsEmpty Then
    Begin
      Result := qryConsulta.FieldByName('QTDFAT').AsFloat > 0;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TFaturamentoContrato.fVerificaTodosItensEncerrados: Boolean;
Var
  strSQL     : String;
  qryConsulta  : TUniQuery;
begin
  Result := False;
  qryConsulta := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT COUNT(*) AS QTDENC FROM EQLDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EQD_SEQCON = :SEQCON ';
    strSQL := strSQL + '  AND IFNULL(EQD_DTAENC,0) > 0 ';

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(strSQL);
    qryConsulta.ParamByName('SEQCON').AsString := FContrato.AutInc;
    qryConsulta.Open;

    If Not qryConsulta.IsEmpty Then
    Begin
      Result := qryConsulta.FieldByName('QTDENC').AsInteger = FContrato.Itens.Count;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TFaturamentoContrato.fAddDuplicata: TDupFaturamentoContrato;
var
  intCont: Integer;
begin
  FListaDuplicatas.add(TDupFaturamentoContrato.Create(Self));
  intCont := FListaDuplicatas.Count -1;
  Result  := FListaDuplicatas[intCont];
end;

function TFaturamentoContrato.fAddItemFaturar: TItemFaturamentoContrato;
var
  intCont: Integer;
begin
  FListaItens.add(TItemFaturamentoContrato.Create(Self));
  intCont := FListaItens.Count -1;
  Result  := FListaItens[intCont];
end;

function TFaturamentoContrato.fAtualizaObservacaoImpressao: Boolean;
var
  strUpdate: String;
  qryUpd: TUniQuery;
begin
  strUpdate := '';
  strUpdate := strUpdate + 'UPDATE EQLFAT SET EQF_FATOBS = :EQF_FATOBS ';
  strUpdate := strUpdate + 'WHERE EQF_SEQCON = :EQF_SEQCON             ';
  strUpdate := strUpdate + '  AND EQF_EMPDOC = :EQF_EMPDOC             ';
  strUpdate := strUpdate + '  AND EQF_ESPDOC = :EQF_ESPDOC             ';
  strUpdate := strUpdate + '  AND EQF_NUMDOC = :EQF_NUMDOC             ';

  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Text := strUpdate;
    qryUpd.ParamByName('EQF_SEQCON').AsString := FContrato.AutInc;
    qryUpd.ParamByName('EQF_EMPDOC').AsString := FEmpDoc;
    qryUpd.ParamByName('EQF_ESPDOC').AsString := FEspDoc;
    qryUpd.ParamByName('EQF_NUMDOC').AsString := FNumDoc;
    qryUpd.ParamByName('EQF_FATOBS').AsString := FstrObs;
    qryUpd.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryUpd);
  End;

end;
procedure TFaturamentoContrato.pBaixaPedidoAdiantamento;
begin
  pBaixaItensPedidoAdiantamento;
  pBaixaPedido;
end;

function TFaturamentoContrato.fCalculaValorDuplicata: Double;
var
  fltTotDup: Double;
Begin
  fltTotDup := ObjfatVenda.fltTotCadRec - FObjfatVenda.fltValAdt;
  FObjfatVenda.fltDupRec := fltTotDup;

  If (ObjfatVenda.fltBolAdt > 0) Then
  Begin
    If (ObjfatVenda.fltTotalBoletosAdiantamentoJaEnviados + FObjfatVenda.fltTotalBoletosAdiantamentoJaImpressos > 0) Then
    Begin
      fltTotDup := fltTotDup - FObjfatVenda.fltBolAdt;

      If FTipoFaturamento = tpParcial Then
      Begin
        fltTotDup := 0;
        ObjfatVenda.fltDupRec := FObjfatVenda.fltTotCadRec;
      End;
    End;
  End;

  If ((fltTotDup < 0) And (FObjfatVenda.fltValAdt <> 0)) Then
    fltTotDup := 0;

  Result := fltTotDup;
End;

function TFaturamentoContrato.fCarregarObjetoFaturamento: Boolean;
begin
  Result := False;
  Try
    If Not fValidarPodeEmitirFatura Then
      Exit;

    FBlnAdicionarTaxaEntrega := (FVlrTotJFat = 0) And (Not FobjValidaCtr.fContratoPossuiValorFaturado);

    If fCfgSis('LECRSN', varBoolean) Then
    Begin
      Result := fCarregarObjetoFaturamentoContasReceber;
    End
    Else
      Result := fCarregarObjetoFaturamentoNotaServico;
  Except
    On E: Exception Do
    Begin
      raise;
    End;
  End;
end;

function TFaturamentoContrato.fCarregarObjetoFaturamentoContasReceber: Boolean;
begin
  Result := False;
  cdsVenda.EmptyDataSet;

  FObjfatVenda.fGravaInfoFora := fGravaFatura;
  FObjfatVenda.strOpcDocTrue := 'RL';
  FObjfatVenda.blnVerEstOrc  := False;
  FObjfatVenda.strNomeForm   := 'frmFatVendas';
  FObjfatVenda.strNumDoc := fRetSequencial('PROCRL', VS_strCodEmp, fTamDocCadRec);
  FObjfatVenda.strEspDoc := 'RL';
  FObjfatVenda.strMen001 := 'CONTRATO DE LOCAÇÃO DE EQUIPAMENTO N. ' + FContrato.NroContrato;
  FObjfatVenda.strMen002 := '';
  FObjfatVenda.strOriDoc := 'V';
  FObjfatVenda.strCodVen := FContrato.Vendedor.Codigo;
  FObjfatVenda.strNomVen := FContrato.Vendedor.Nome;

  FCodCondicaoPgto := FObjfatVenda.strCodCnd;
  FCondicaoPgto := FObjfatVenda.strConPag;
  FCodFormaPgto := FObjfatVenda.strCodFpg;
  FObjfatVenda.pCarregaDadosClienteBaixa(FContrato.CodCliente);
  If FblnInformarFormaPgto Then
  Begin
    FObjfatVenda.strConPag := FContrato.CondicaoPgto;
    FObjfatVenda.strCodCnd := FContrato.CodCondicaoPgto;
    FObjfatVenda.strCodFpg := FContrato.CodFormaPgto;
  End
  Else
  Begin
    FObjfatVenda.strConPag := FCondicaoPgto;
    FObjfatVenda.strCodCnd := FCodCondicaoPgto;
    FObjfatVenda.strCodFpg := FCodFormaPgto;
  End;

  If Not fIncluiItens() Then
    Exit;

  If Not fInformaPagamento() Then
    Exit;

  Result := True;
end;

function TFaturamentoContrato.fCarregarObjetoFaturamentoNotaServico: Boolean;
begin
  Result := False;
  cdsVenda.EmptyDataSet;

  FObjfatVenda.fGravaInfoFora := fGravaFatura;
  FObjfatVenda.strOpcDocTrue := 'LE';
  FObjfatVenda.blnVerEstOrc  := False;
  FObjfatVenda.strNomeForm   := 'frmFatVendas';
  FObjfatVenda.strEspDoc := 'NS';
  FObjfatVenda.strTipFat := 'Nota Fiscal de serviço';
  FObjfatVenda.strMen001 := 'CONTRATO DE LOCAÇÃO DE EQUIPAMENTO N. ' + FContrato.NroContrato;
  FObjfatVenda.strMen002 := '';
  FObjfatVenda.strOriDoc := 'V';
  FObjfatVenda.strCodVen := FContrato.Vendedor.Codigo;
  FObjfatVenda.strNomVen := FContrato.Vendedor.Nome;

  FCondicaoPgto := FObjfatVenda.strConPag;
  FCodCondicaoPgto := FObjfatVenda.strCodCnd;
  FCodFormaPgto := FObjfatVenda.strCodFpg;
  FObjfatVenda.pCarregaDadosClienteBaixa(FContrato.CodCliente);
  If FblnInformarFormaPgto Then
  Begin
    FObjfatVenda.strConPag := FContrato.CondicaoPgto;
    FObjfatVenda.strCodCnd := FContrato.CodCondicaoPgto;
    FObjfatVenda.strCodFpg := FContrato.CodFormaPgto;
  End
  Else
  Begin
    FObjfatVenda.strConPag := FCondicaoPgto;
    FObjfatVenda.strCodCnd := FCodCondicaoPgto;
    FObjfatVenda.strCodFpg := FCodFormaPgto;
  End;

  If FListaItens.Count > 30 Then
  Begin
    raise Exception.Create('Não é possível emitir nota de serviço com mais de 30 itens de serviço!');
    Exit;
  End;

  If Not fIncluiItens() Then
    Exit;

  If Not fInformaPagamento() Then
    Exit;

  Result := True
end;

function TFaturamentoContrato.fConfirmarFaturamento(blnEncerrar: Boolean): Boolean;
var
  blnObjetoFaturamentoCarregado: Boolean;
begin
  FblnTransacaoIniciada := frmModulo.GetCurrentConnection.InTransaction;

  blnObjetoFaturamentoCarregado := fCarregarObjetoFaturamento;

  If Not FblnTransacaoIniciada Then
    fStartTransaction;

  Try
    If blnObjetoFaturamentoCarregado And fEmitirFatura Then
    Begin
      Result := True;

      If FObjfatVenda.fDuplicataAVistaContratoLocacao Then
        FMensagemRetorno := 'Foi utilizada no faturamento da locação uma condição à vista ou cartão/cheque. ' +
                            'Encaminhe o cliente para o caixa para que ele faça o pagamento. O financeiro está pendente de quitação.'
      Else
        FMensagemRetorno := 'Faturamento realizado com sucesso!';


    End
    Else
    Begin
      If FVlrTotFat > 0 Then
        Result := False
      Else
      Begin
        Result := FblnEncerrarItemFat;
        FMensagemRetorno := 'Encerramento realizado com sucesso!';
      End;
    End;

    If Result And (blnEncerrar or FblnEncerrarItemFat) Then
    Begin
      Result := fProcessarEncerramento(blnEncerrar);
    End;

    If (Not FblnTransacaoIniciada) And (Result) Then
      fCommit
    Else
    Begin
      If Not FblnTransacaoIniciada Then
        fRollBack;

      FMensagemRetorno := IIF(fEmptyStr(FMensagemRetorno), 'Processo não finalizado.', FMensagemRetorno);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If Not FblnTransacaoIniciada Then
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TFaturamentoContrato.fConfirmarFaturamento]');
      End;
    End;
  End;
end;

function TFaturamentoContrato.fGeraContasReceberComAdiantamento: Boolean;
Var
  fltTotDup: Double;
  blnManPar: Boolean;
  intContador: Integer;
  blnUtilizarValorTotalAdiantamento: Boolean;
  blnAlterarSequencialParcelas: Boolean;
  fltTotalParcelasGeradas: Double;
  fltTotalParcelasPedido: Double;
begin
  FillChar(FObjfatVenda.arrDuplicataCND, SizeOf(FObjfatVenda.arrDuplicataCND), #0);
  FillChar(FObjfatVenda.arrDuplicata, SizeOf(FObjfatVenda.arrDuplicata), #0);

  blnManPar := True;
  Try
    pCarredaDadosAdiantamento;

    For intContador := Low(FObjfatVenda.arrMatItens) To High(FObjfatVenda.arrMatItens) Do
    Begin
      FObjfatVenda.arrMatItens[intContador].strNumOrc := FNumDocAdt;
      FObjfatVenda.arrMatItens[intContador].strEspOrc := FEspDocAdt;
      FObjfatVenda.arrMatItens[intContador].strEmpOrc := FEmpDocAdt;
    End;

    FObjfatVenda.strCodDig := strLoginUsuarioLogado;
    FObjfatVenda.recValAdt := TAdiantamento.fGetTotaisAdiantamento(FNumDocAdt, FEspDocAdt, FEmpDocAdt);

    fltTotDup := fCalculaValorDuplicata;
    If Not (SameValue(fFormataFloat(fltTotDup, 4), fFormataFloat(FVlrTotFat, 4))) Then
    Begin
      FMensagemRetorno := 'Foi identificada divergência entre o valor calculado a faturar('+ FormatFloat('#,##0.00', FVlrTotFat) +') e o valor '+
                          ' calculado para o contas a receber ('+ FormatFloat('#,##0.00', fltTotDup) +')';
      Result := False;
      Exit;
    End;

    If (fltTotDup < FObjfatVenda.recValAdt.fltValLan) Then
    Begin
      FObjfatVenda.fltValAdt := fltTotDup;
      blnAlterarSequencialParcelas := False;
      blnUtilizarValorTotalAdiantamento := True;
    End
    Else
    Begin
      blnAlterarSequencialParcelas := True;
      blnUtilizarValorTotalAdiantamento := True;
      FObjfatVenda.fltValAdt := FObjfatVenda.recValAdt.fltValLan;
      fltTotDup := fltTotDup - FObjfatVenda.fltValAdt;
    End;

    FObjfatVenda.blnResCaiAdt := TAdiantamento.fGetResCaiAdiantamento(FNumDocAdt, FEspDocAdt, FEmpDocAdt, FContrato.CodCliente);
    FObjfatVenda.strConPag := IIF(Not fEmptyStr(FCondicaoPgto), FCondicaoPgto, FObjfatVenda.strConPag);

    pGerarParcelasContasReceber(fltTotDup);

    pCarregaDuplicatasCND(1,FContrato.AutIncPedAdiantamento, FObjfatVenda.arrDuplicataCND);

    pBaixaParcelaAdiantamento(blnUtilizarValorTotalAdiantamento, blnAlterarSequencialParcelas);

    FObjfatVenda.pRateiaValores;

    fltTotalParcelasGeradas := 0;
    For intContador := 0 To  Length(FObjfatVenda.arrDuplicata)-1 Do
      fltTotalParcelasGeradas := fltTotalParcelasGeradas + FObjfatVenda.arrDuplicata[intContador].curValor;

    fltTotalParcelasPedido := 0;
    For intContador := 0 To 23 Do
      fltTotalParcelasPedido := fltTotalParcelasPedido + FObjfatVenda.arrDuplicataCND[intContador].curValor;


    If ((blnAlterarSequencialParcelas) or (blnManPar And FblnAdtVltTot)) And
       (fltTotalParcelasGeradas <> FVlrTotFat) Then
    Begin
      FMensagemRetorno := 'Foram identificadas divergências entre o valor calculado a faturar('+ FormatFloat('#,##0.00', FVlrTotFat) +') e o valor '+
                          ' calculado para o contas a receber ('+ FormatFloat('#,##0.00', fltTotalParcelasPedido) +')';
      Result := False;
      Exit;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
End;

function TFaturamentoContrato.fGeraContasReceber: Boolean;
var
  recValAdt: TTotaisAdiantamento;
begin
  FObjfatVenda.pCalculaTotalParaCadRec;

  If FObjfatVenda.fltTotCadRec = 0 Then
  Begin
    FMensagemRetorno := 'Não existe valor a faturar.';
    Result := False;
    Exit;
  End;

  If FobjValidaCtr.fContratoPossuiAdiantamento Then
    recValAdt := TAdiantamento.fGetTotaisAdiantamento(FNumDocAdt, FEspDocAdt, FEmpDocAdt)
  Else
    recValAdt.fltValLan := 0;

  If (Not FobjValidaCtr.fContratoPossuiAdiantamento) or
     ((FobjValidaCtr.fContratoPossuiAdiantamento) and (recValAdt.fltValLan = 0))  Then
  Begin
    Result :=  fDigDuplic(FObjfatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(FObjfatVenda.strConPag), 0, FObjfatVenda.fltTotCadRec,
                          False, False, False, VS_Date, False, FObjfatVenda.fltImpFre,
                          'N', fCfgSis('DUPRED', varBoolean), False, 0, False,
                          Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, FObjfatVenda.fFaturandoPedido);
    FObjfatVenda.strConPag := fRetornaCndPag(FObjfatVenda.arrDuplicata, VS_Date);
    FObjfatVenda.pRateiaValores;
  End
  Else
    Result := fGeraContasReceberComAdiantamento;
end;

procedure TFaturamentoContrato.pBaixaAcessorioPedido(const strCodAce, strCodEql: String);
var
  qryExtGor: TUniQuery;
begin
  qryExtGor := fCriaQuery;
  Try
    qryExtGor.SQL.Clear;
    qryExtGor.SQL.Add('UPDATE                     ');
    qryExtGor.SQL.Add('  FATDOR                   ');
    qryExtGor.SQL.Add('INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
    qryExtGor.SQL.Add('SET                        ');
    qryExtGor.SQL.Add('  FATDOR.FDO_JAFATU = 1    ');
    qryExtGor.SQL.Add('WHERE FATDOR.FDO_SEQGER = :AUTINC ');
    qryExtGor.SQL.Add('  AND FATDOR.FDO_CODITE = :CODITE ');
    qryExtGor.SQL.Add('  AND EXTDOR.FDO_ITEEST = :CODEQL ');

    qryExtGor.ParamByName('AUTINC').AsString := FContrato.AutIncPedAdiantamento;
    qryExtGor.ParamByName('CODITE').AsString := strCodAce;
    qryExtGor.ParamByName('CODEQL').AsString := strCodEql;
    qryExtGor.ExecSQL;
  Finally
    FreeAndNil(qryExtGor);
  End;
end;

procedure TFaturamentoContrato.pBaixaEquipamentoPedido(const strCodIte, strSeqIte: String);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE FATDOR                                                ');
    qryUpdate.SQL.Add('  INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryUpdate.SQL.Add('SET                        ');
    qryUpdate.SQL.Add('  FDO_JAFATU = 1           ');
    qryUpdate.SQL.Add('WHERE                      ');
    qryUpdate.SQL.Add('  FDO_SEQGER = :AUTINC AND ');
    qryUpdate.SQL.Add('  FDO_CODITE = :CODITE AND ');
    qryUpdate.SQL.Add('  FDO_SEQEQL = :SEQEQL     ');
    qryUpdate.ParamByName('AUTINC').AsString := FContrato.AutIncPedAdiantamento;
    qryUpdate.ParamByName('CODITE').AsString := strCodIte; // FItem.Equipamento.CodigoItem;
    qryUpdate.ParamByName('SEQEQL').AsString := strSeqIte; // FItem.Equipamento.AutInc;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TFaturamentoContrato.pBaixaItensPedidoAdiantamento;
var
  intCnt,
  intCont: Integer;
begin
  For intCnt := 0 to FContrato.Itens.Count-1 Do
  Begin
    pBaixaEquipamentoPedido(FContrato.Itens[intCnt].Equipamento.CodigoItem,
                            FContrato.Itens[intCnt].Equipamento.AutInc);

    For intCont := 0 To FContrato.Itens[intCnt].Equipamento.Acessorios.Count -1 Do
    Begin
      pBaixaAcessorioPedido(FContrato.Itens[intCnt].Equipamento.Acessorios[intCont].Acessorio.CodigoItem,
                            FContrato.Itens[intCnt].Equipamento.CodigoItem);
    End;
  End;
end;

procedure TFaturamentoContrato.pBaixaParcelaAdiantamento(var blnUtilizarValorTotalAdiantamento, blnAlterarSequencialParcelas: Boolean);
var
  blnManPar: Boolean;
  fltTotalParcelasPedido: Double;
  intContador: Integer;
begin
  blnManPar := True;

  If FObjfatVenda.fltValAdt > 0 Then
  Begin
    FObjfatVenda.fAdicionaAdiantamentoPrimeiraParcela(blnUtilizarValorTotalAdiantamento, blnAlterarSequencialParcelas);
    blnManPar   := False;
  End;

  fltTotalParcelasPedido := 0;
  For intContador := 0 To 23 Do
    fltTotalParcelasPedido := fltTotalParcelasPedido + FObjfatVenda.arrDuplicataCND[intContador].curValor;

  If fFormataFloat(FObjfatVenda.fltTotCadRec, 2) <> fFormataFloat(fltTotalParcelasPedido, 2) Then
    blnManPar := False;

  If blnManPar And FblnAdtVltTot Then
  Begin
    For intContador := 0 To 23 Do
    Begin
      If (fEmptyStr(FObjfatVenda.arrDuplicata[intContador].strSequen)) Then
        Break;
      FObjfatVenda.arrDuplicata[intContador].curValor := FObjfatVenda.arrDuplicataCND[intContador].curValor;
    End;
  End;
end;

procedure TFaturamentoContrato.pBaixaPedido;
var
  qryUpdate: TUniQuery;
begin
  pCarredaDadosAdiantamento;

  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Add('UPDATE                     ');
    qryUpdate.SQL.Add('  FATGOR                   ');
    qryUpdate.SQL.Add('SET                        ');
    qryUpdate.SQL.Add('  FGO_JAFATU = 1,          ');
    qryUpdate.SQL.Add('  FGO_MOTBAI = :MOTBAI     ');
    qryUpdate.SQL.Add('WHERE                      ');
    qryUpdate.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
    qryUpdate.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
    qryUpdate.SQL.Add('  FGO_CODEMP = :CODEMP     ');
    qryUpdate.ParamByName('MOTBAI').AsString := 'FATURAMENTO DE CONTRATO';
    qryUpdate.ParamByName('NUMDOC').AsString := FNumDocAdt;
    qryUpdate.ParamByName('ESPDOC').AsString := FEspDocAdt;
    qryUpdate.ParamByName('CODEMP').AsString := FEmpDocAdt;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TFaturamentoContrato.pCalcularTotais;
var
  intCnt: Integer;
  fltVlrTotCont: Double;
begin
  FVlrTotFat  := 0;
  FVlrTotIpe  := 0;
  FVlrTotal   := 0;
  FVlrTotJFat := 0;
  FVlrTotRes  := 0;
  FVlrTotal   := 0;
  FVlrTotRLq  := 0;
  FTotHor     := 0;
  FTotDia     := 0;
  FVlrTotEqu  := 0;
  FTotMes     := 0;
  FVlrTotDes  := 0;
  FPerTotDes  := 0;
  fltVlrTotCont := 0;
  FVlrTotAdc := 0;

  For intCnt := 0 to FListaItens.Count-1 Do
  Begin
    If Not FListaItens[intCnt].blnFaturarItem Then
      Continue;

    FVlrTotFat  := FVlrTotFat + FListaItens[intCnt].FVlAFat;
    FVlrTotIpe  := FVlrTotIpe + FListaItens[intCnt].FVlrCob;
    FVlrTotal   := FVlrTotal  + FListaItens[intCnt].FVlrTot;

    FVlrTotJFat := FVlrTotJFat+ FListaItens[intCnt].FVlJFat;
    FVlrTotRes  := FVlrTotRes + FListaItens[intCnt].FVlRFat;
    FVlrTotRLq  := FVlrTotRLq + FListaItens[intCnt].FVlrLiq;

    Case FListaItens[intCnt].FItem.TipoCalculoLocacao Of
      tpHoras : FTotHor := FTotHor    + FListaItens[intCnt].FDuracaoLocacaoItem;
      tpDiaria: FTotDia := FTotDia    + FListaItens[intCnt].FDuracaoLocacaoItem;
      tpMensal: FTotMes := FTotMes    + FListaItens[intCnt].FDuracaoLocacaoItem;
    End;
    FVlrTotEqu := FVlrTotEqu + FListaItens[intCnt].FItem.ValorTotalLiquido;
    FVlrTotDes := FVlrTotDes + FListaItens[intCnt].FTotDes;
    fltVlrTotCont := fltVlrTotCont + FListaItens[intCnt].FItem.ValorTotalLocacaoContratado;
    FVlrTotAdc := FVlrTotAdc + FListaItens[intCnt].FVlrAdc;
  End;
  If fltVlrTotCont > 0 Then
    FPerTotDes := (FVlrTotDes * 100) / fltVlrTotCont;
end;

procedure TFaturamentoContrato.pCarredaDadosAdiantamento(const strAutIncPed: String = '');
var
  qrySelect: TUniQuery;
begin
  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  ');
    qrySelect.SQL.Add('  FROM FATGOR              ');
    qrySelect.SQL.Add('WHERE                      ');
    qrySelect.SQL.Add('  AUTOINCREM = :AUTINC     ');
    qrySelect.ParamByName('AUTINC').AsString := IIF(Not fEmptyStr(strAutIncPed), strAutIncPed, FContrato.AutIncPedAdiantamento);
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      FNumDocAdt := qrySelect.FieldByName('FGO_NUMDOC').AsString;
      FEspDocAdt := qrySelect.FieldByName('FGO_ESPDOC').AsString;
      FEmpDocAdt := qrySelect.FieldByName('FGO_CODEMP').AsString;
    End;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

procedure TFaturamentoContrato.pCarregarDuplicatas;
var
  qrySelect: TUniQuery;
  ItemDuplicata: TDupFaturamentoContrato;
begin

  FListaDuplicatas.Clear;
  
  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT C.AUTOINCREM,             ');
    qrySelect.SQL.Add('       C.CTR_NUMDUP,             ');
    qrySelect.SQL.Add('       C.CTR_CODEMP,             ');
    qrySelect.SQL.Add('       C.CTR_ESPDOC,             ');
    qrySelect.SQL.Add('       C.CTR_PARCEL,             ');
    qrySelect.SQL.Add('       (CASE WHEN C.CTR_ESPDOC = "AG" THEN D.CTR_VALDUP  ');
    qrySelect.SQL.Add('        ELSE C.CTR_VALDUP END) AS CRT_VALDUP,            ');
    qrySelect.SQL.Add('       C.CTR_VALDUP as CTR_VALREC,');
    qrySelect.SQL.Add('       C.CTR_DTACAD,             ');
    qrySelect.SQL.Add('       C.CTR_DTAVEN,             ');
    qrySelect.SQL.Add('       C.CTR_DTAREC              ');
    qrySelect.SQL.Add('  FROM CADREC C                  ');
    qrySelect.SQL.Add('  LEFT JOIN DUPAGR D ON (D.CTR_NUMAGR = C.CTR_NUMDUP AND D.CTR_EMPAGR = C.CTR_CODEMP AND D.CTR_CODCLI = C.CTR_CODCLI)');
    qrySelect.SQL.Add('WHERE                            ');
    qrySelect.SQL.Add('  C.CTR_CODEMP = :CODEMP         ');
    qrySelect.SQL.Add('  AND C.CTR_CODCLI = :CODCLI     ');
    qrySelect.SQL.Add('  AND ((C.CTR_ESPDOC = "NS"      ');
    qrySelect.SQL.Add('    OR C.CTR_ESPDOC = "RL")      ');
    qrySelect.SQL.Add('  AND C.CTR_NUMDUP IN (:NUMDUP)) ');
    qrySelect.SQL.Add('  OR (C.CTR_ESPDOC ="AG" AND D.CTR_EMPAGR = :CODEMP  AND D.CTR_NUMDUP IN (:NUMDUP)) ');
    qrySelect.ParamByName('CODEMP').AsString := FEmpDoc;
    qrySelect.ParamByName('NUMDUP').AsString := FNumDoc;
    qrySelect.ParamByName('CODCLI').AsString := FContrato.CodCliente;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      While Not qrySelect.EOF  Do
      Begin
        ItemDuplicata := fAddDuplicata;
        ItemDuplicata.AutInc :=  qrySelect.FieldByName('AUTOINCREM').AsString;
        ItemDuplicata.NumDup :=  qrySelect.FieldByName('CTR_NUMDUP').AsString;
        ItemDuplicata.EmpDoc :=  qrySelect.FieldByName('CTR_CODEMP').AsString;
        ItemDuplicata.EspDoc :=  qrySelect.FieldByName('CTR_ESPDOC').AsString;
        ItemDuplicata.Parcela :=  qrySelect.FieldByName('CTR_PARCEL').AsString;
        ItemDuplicata.ValorDuplicata := qrySelect.FieldByName('CRT_VALDUP').AsFloat;
        ItemDuplicata.ValorReceber := qrySelect.FieldByName('CTR_VALREC').AsFloat;
        ItemDuplicata.DataEmissao := qrySelect.FieldByName('CTR_DTACAD').AsDateTime;
        ItemDuplicata.DataVencimento := qrySelect.FieldByName('CTR_DTAVEN').AsDateTime;
        ItemDuplicata.DataRecebimento := qrySelect.FieldByName('CTR_DTAREC').AsDateTime;

        qrySelect.Next;
      End;
    End;

  Finally
    FreeAndNil(qrySelect);
  End;

end;

procedure TFaturamentoContrato.pCarregarDetalhamentoFaturamento(const strEspDoc, strEmpDoc,
  strNumDoc: String; const strCodEql: String = '');
var
  qrySelect: TUniQuery;
  ItemFatura: TItemFaturamentoContrato;
  blnFiltrarDocumento: Boolean;
begin
  FListaItens.Clear;
  blnFiltrarDocumento :=  Not(fEmptyStr(strNumDoc));

  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT EQF_SEQEQL              ');
    qrySelect.SQL.Add('  FROM EQLFAT                  ');
    qrySelect.SQL.Add('WHERE                          ');
    qrySelect.SQL.Add('  EQF_SEQCON = :EQF_SEQCON     ');
    If blnFiltrarDocumento Then
    Begin
      qrySelect.SQL.Add('  AND EQF_NUMDOC = :EQF_NUMDOC  ');
      qrySelect.SQL.Add('  AND EQF_ESPDOC = :EQF_ESPDOC  ');
      qrySelect.SQL.Add('  AND EQF_EMPDOC = :EQF_EMPDOC  ');
    End;
    If Not(fEmptyStr(strCodEql)) Then
      qrySelect.SQL.Add('  AND EQF_SEQEQL = :EQF_SEQEQL   ');

    If blnFiltrarDocumento Then
    Begin
      qrySelect.ParamByName('EQF_NUMDOC').AsString := strNumDoc;
      qrySelect.ParamByName('EQF_ESPDOC').AsString := strEspDoc;
      qrySelect.ParamByName('EQF_EMPDOC').AsString := strEmpDoc;
    End;
    If Not(fEmptyStr(strCodEql)) Then
      qrySelect.ParamByName('EQF_SEQEQL').AsString := strCodEql;
    qrySelect.ParamByName('EQF_SEQCON').AsString := FContrato.AutInc;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      While Not qrySelect.EOF  Do
      Begin
        FNumDoc := strNumDoc;
        FEspDoc := strEspDoc;
        FEmpDoc := strEmpDoc;

        ItemFatura := fAddItemFaturar;
        ItemFatura.FItem := TItemContratoLocacaoEquipamentos.Create(FContrato);
        ItemFatura.pCarregarDadosFaturamentoPorEquipamento(qrySelect.FieldByName('EQF_SEQEQL').AsString,
                                                           IIF(blnFiltrarDocumento,FNumDoc, ''));
        qrySelect.Next;
      End;
    End;

  Finally
    FreeAndNil(qrySelect);
  End;

  pCalcularTotais;
end;


procedure TFaturamentoContrato.pCarregarFaturamento(AEncerrados: Boolean =  True);
var
  qrySelect: TUniQuery;
  ItemFatura: TItemFaturamentoContrato;
begin
  pLimpar;

  qrySelect := fCriaQuery;
  Try
    qrySelect.SQL.Clear;
    qrySelect.SQL.Add('SELECT EQF_SEQEQL          ');
    qrySelect.SQL.Add('  FROM EQLFAT              ');
    qrySelect.SQL.Add('WHERE                      ');
    qrySelect.SQL.Add('  EQF_SEQCON = :EQF_SEQCON ');
    If AEncerrados Then
      qrySelect.SQL.Add('  AND IFNULL(EQF_DTAENC, 0) > 0 ');
    qrySelect.ParamByName('EQF_SEQCON').AsString := FContrato.AutInc;
    qrySelect.Open;
    If Not qrySelect.IsEmpty Then
    Begin
      While Not qrySelect.EOF  Do
      Begin
        ItemFatura := fAddItemFaturar;
        ItemFatura.FItem := TItemContratoLocacaoEquipamentos.Create(FContrato);
        ItemFatura.pCarregarDadosFaturamentoPorEquipamento(qrySelect.FieldByName('EQF_SEQEQL').AsString);
        qrySelect.Next;
      End;
    End;

  Finally
    FreeAndNil(qrySelect);
  End;

  pCalcularTotais;

end;

procedure TFaturamentoContrato.pCarregarItensAFaturar;
var
  intCnt: Integer;
  ItemFatura: TItemFaturamentoContrato;
begin
  pLimpar;

  For intCnt := 0 to FContrato.Itens.Count-1 do
  Begin
    ItemFatura := fAddItemFaturar;
    ItemFatura.FItem := FContrato.Itens[intCnt];
    ItemFatura.ValorLocacaoOriginal := FContrato.Itens[intCnt].ValorTotalLocacaoContratado;
    ItemFatura.pCarregarDadosFaturamentoPorEquipamento(ItemFatura.FItem.Equipamento.Codigo);

    pCalcularTotais;

    ItemFatura.BlnAdicionarTaxEntItem := (FContrato.ValorTaxaEntrega > 0) and
                                         (Not fTaxaEntregaAdicionadaFatura);
  End;

  FBlnAdicionarTaxaEntrega := (FVlrTotJFat = 0) And (Not FobjValidaCtr.fContratoPossuiValorFaturado);
end;

procedure TFaturamentoContrato.pGerarParcelasContasReceber(const fltTotDup: Double);
begin
  If fltTotDup > 0 Then
  Begin
    fDigDuplic(FObjfatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(FObjfatVenda.strConPag), 0, fltTotDup,
               False, False, False, VS_Date, False, FObjfatVenda.fltImpFre,
               'N', fCfgSis('DUPRED', varBoolean), False, 0, False,
               Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, FObjfatVenda.fFaturandoPedido);
    FObjfatVenda.strConPag := fRetornaCndPag(FObjfatVenda.arrDuplicata, VS_Date);
    FObjfatVenda.pRateiaValores;
  End;
end;

function TFaturamentoContrato.fIncluiItens(): Boolean;
Var
  qryCadIte,
  qryIteGer,
  qryAbfIcm: TUniQuery;
  intIdx: Integer;
  blnTemCobrInsp: Boolean;
  strCodSer,
  strDesSer: String;
  intCnt: Integer;
  strCodSerReparo,
  strDesSerReparo: String;
  fltValorServico,
  fltValorTotalServico: Double;
  fltVlrCobranca: Double;
  ftlTotAFat: Double;
Begin

  qryCadIte := fCriaQuery(Nil);
  qryIteGer := fCriaQuery(Nil);
  qryAbfIcm := fCriaQuery(Nil);
  Try
    qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
    qryCadIte.ParamByName('CODITE').AsString := fCfgSis('ITESER');
    qryCadIte.Open;

    qryIteGer.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryIteGer.ParamByName('CODITE').AsString := fCfgSis('ITESER');
    qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryIteGer.Open;

    qryAbfIcm.SQL.Add('SELECT * FROM ABFICM WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO');

    If fCfgSis('TIPABF') = '1' Then
      qryAbfIcm.ParamByName('CODABF').AsString := qryCadIte.FieldByName('ITE_CODABF').AsString
    Else
      qryAbfIcm.ParamByName('CODABF').AsString := qryIteGer.FieldByName('ITE_CODABF').AsString;

    qryAbfIcm.ParamByName('ESTADO').AsString := FObjFatVenda.strCliEst;
    qryAbfIcm.Open;

    FObjFatVenda.fltTotSer := 0.0;
    intIdx := 0;

    strCodSer := fCfgSis('SRLCEQ', varString);
    strDesSer := fRetDesServico(strCodSer);
    FContrato.pCalculaTotais;
    blnTemCobrInsp := False;

    strCodSerReparo := fCfgSis('SRRPEQ', varString);
    strDesSerReparo := fRetDesServico(strCodSerReparo);

    fltVlrCobranca := 0;
    fltValorTotalServico := 0;
    Inc(intIdx);
    For intCnt := 0 to FListaItens.Count-1 Do
    Begin

      If Not FListaItens[intCnt].blnFaturarItem Then
        Continue;

      If FListaItens[intCnt].FVlAFat <= 0 Then
      Begin
        Continue;
      End;

      strDesSer := strDesSer + ' ' + FListaItens[intCnt].FItem.Equipamento.Descricao + ' No. SÉRIE: ' + FListaItens[intCnt].FItem.Equipamento.NumSerie + '; ';
      fltValorServico := fformatafloat(FListaItens[intCnt].DuracaoLocacao * FListaItens[intCnt].FValorLocacaoCalculado, 2);
      fltValorServico := fltValorServico + FListaItens[intCnt].FTaxEnt;
      fltValorServico := fltValorServico + FListaItens[intCnt].FVlrAdc;

      fltValorTotalServico := fltValorTotalServico + fltValorServico;

      If (FListaItens[intCnt].ValorCobranca > 0) Then
      Begin
        If ((FTipoFaturamento = tpTotal) or (FListaItens[intCnt].blnEncerrarItem)) Then
        Begin
          blnTemCobrInsp := True;
          strDesSerReparo := strDesSerReparo + ' ' + FListaItens[intCnt].FItem.Equipamento.Descricao + ' No. SÉRIE: ' + FListaItens[intCnt].FItem.Equipamento.NumSerie  + '; ';
          fltVlrCobranca :=  fltVlrCobranca + FListaItens[intCnt].ValorCobranca;
        End;
      End;

      ftlTotAFat := fltValorServico + FListaItens[intCnt].ValorCobranca;
      If Not (SameValue(fFormataFloat(ftlTotAFat, 4),
                        fFormataFloat(FListaItens[intCnt].FVlAFat, 4), 0.5)) Then
      Begin
        FMensagemRetorno := 'Encontrada divergência entre o valor a faturar e o valor calculado para o serviço do equipamento ' +
                              '"'+ FListaItens[intCnt].FItem.Equipamento.Codigo + ' - ' + FListaItens[intCnt].FItem.Equipamento.Descricao + '"';
        Exit(False);
      End;
    End;

    FObjFatVenda.pInserirItemServico(Nil, qryCadIte, qryIteGer, qryAbfIcm);
    pSetaValorItemServico(FObjFatVenda.FRecSer, isCodS, intIdx, strCodSer);
    pSetaValorItemServico(FObjFatVenda.FRecSer, isDesS, intIdx, strDesSer);
    pSetaValorItemServico(FObjFatVenda.FRecSer, isVenS, intIdx, FObjFatVenda.strCodVen);
    pSetaValorItemServico(FObjFatVenda.FRecSer, isQtsS, intIdx, 1);
    pSetaValorItemServico(FObjFatVenda.FRecSer, isUniS, intIdx, fltValorTotalServico);
    pSetaValorItemServico(FObjFatVenda.FRecSer, isValS, intIdx, fltValorTotalServico);
    FObjFatVenda.fltTotSer := fValorItemServico(FObjFatVenda.FRecSer, isValS, intIdx);

    If blnTemCobrInsp Then
    Begin
      Inc(intIdx);
      FObjFatVenda.pInserirItemServico(Nil, qryCadIte, qryIteGer, qryAbfIcm);
      pSetaValorItemServico(FObjFatVenda.FRecSer, isCodS, intIdx, strCodSerReparo);
      pSetaValorItemServico(FObjFatVenda.FRecSer, isDesS, intIdx, strDesSerReparo);
      pSetaValorItemServico(FObjFatVenda.FRecSer, isQtsS, intIdx, 1);
      pSetaValorItemServico(FObjFatVenda.FRecSer, isVenS, intIdx, FObjFatVenda.strCodVen);
      pSetaValorItemServico(FObjFatVenda.FRecSer, isUniS, intIdx, fltVlrCobranca);
      pSetaValorItemServico(FObjFatVenda.FRecSer, isValS, intIdx, fltVlrCobranca);

      FObjFatVenda.fltTotSer := FObjFatVenda.fltTotSer + fValorItemServico(FObjFatVenda.FRecSer, isValS, intIdx);
    End;

    FObjFatVenda.pDefineAliquotaIss();
    FObjFatVenda.fltBasIss := fFormataFloat(FObjFatVenda.fltTotSer * (1 - FObjFatVenda.fltRedIss / 100), 2);
    FObjFatVenda.fltValIss := fCalculaValorIss(FObjFatVenda.fltBasIss, FObjFatVenda.fltPerIss);

    Result := True;
  Finally
    FreeAndNil(qryCadIte);
    FreeAndNil(qryIteGer);
    FreeAndNil(qryAbfIcm);
  End;
End;

procedure TFaturamentoContrato.pLimpar;
begin
  FVlrTotFat  := 0;
  FVlrTotIpe  := 0;
  FVlrTotal   := 0;
  FVlrTotJFat := 0;
  FVlrTotRes  := 0;
  FVlrTotRLq  := 0;
  FTotDia     := 0;
  FTotHor     := 0;
  FblnBoletoImpresso := False;
  FVlrTotEqu  := 0;
  FTotMes     := 0;
  FblnEncerrarItemFat := False;
  FExcluirFaturamentoEncerramento := False;

  FListaItens.Clear;
  FListaDuplicatas.Clear;
end;

procedure TFaturamentoContrato.pMarcaEncerrarItens(const blnMarcar: Boolean);
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    FListaItens[intCnt].blnEncerrarItem := blnMarcar;
  End;
end;

procedure TFaturamentoContrato.pRecalcularFaturamentoMensal(
  const aDataRef: TDateTime);
var
  intCnt: Integer;
  blnRecalcularDesconto: Boolean;
  blnRecalcularTotalLiq: Boolean;
  intDia, intMes, intAno, intHora, intMin, intSec, intMils: Word;
begin
  blnRecalcularDesconto := False;
  blnRecalcularTotalLiq := False;
  FTipoFaturamento := tpParcial;

  DecodeDateTime(aDataRef, intAno, intMes, intDia, intHora, intMin, intSec, intMils);
  FDtaRef := EncodeDateTime(intAno, intMes, intDia, 0, 0, 0, 0);
  FHraRef := EncodeTime(intHora, intMin, intSec, intMils);

  pCarregarItensAFaturar;
  For intCnt := 0 to FListaItens.Count-1 do
  Begin
    FListaItens[intCnt].DataReferencia := aDataRef;
    FListaItens[intCnt].blnEncerrarItem := False;
    If FListaItens[intCnt].DataEncerramento > 0 Then
    Begin
      FListaItens[intCnt].blnFaturarItem := False;
      Continue;
    End;

    If aDataRef > FListaItens[intCnt].FItem.DataFinalCobranca Then
    Begin
      FTipoFaturamento := tpParcial;
      FListaItens[intCnt].blnEncerrarItem := True;
    End
    Else
    Begin
      If FListaItens[intCnt].FItem.DataInspecaoEntrada > 0 Then
      Begin
        FTipoFaturamento := tpTotal;
        blnRecalcularDesconto := True;
        FListaItens[intCnt].blnEncerrarItem := True;
      End;
    End;

    Case FTipoFaturamento Of
      tpParcial : FListaItens[intCnt].pRecalcularFaturamentoParcial(aDataRef, FListaItens[intCnt].FItem.PercentualDesconto, FListaItens[intCnt].FItem.ValorDesconto, FListaItens[intCnt].FItem.ValorTotalLiquido, blnRecalcularDesconto, blnRecalcularTotalLiq, FListaItens[intCnt].blnEncerrarItem);
      tpTotal   : FListaItens[intCnt].pRecalcularFaturamentoTotal(FListaItens[intCnt].FItem.PercentualDesconto, FListaItens[intCnt].FItem.ValorDesconto, FListaItens[intCnt].FItem.ValorTotalLiquido, blnRecalcularDesconto, blnRecalcularTotalLiq, FListaItens[intCnt].blnEncerrarItem);
    End;
  End;
  pCalcularTotais;
end;

procedure TFaturamentoContrato.pVerificaDtaHraCobranca;
var
  intCnt: Integer;
  tmpDtaHraIniCob: TDateTime;
begin
  tmpDtaHraIniCob := FContrato.DataInicialEstimada;

  For intCnt := FContrato.Itens.Count-1 DownTo 0 Do
  Begin
    If FContrato.Itens[intCnt].DataInicialCobranca <> tmpDtaHraIniCob Then
    Begin
      tmpDtaHraIniCob := FContrato.Itens[intCnt].DataInicialCobranca;
    End;
  End;

  FDtaIniCob := EncodeDate(YearOf(tmpDtaHraIniCob), MonthOf(tmpDtaHraIniCob), DayOf(tmpDtaHraIniCob));
  FDtaFinCob := FDtaIniCob + FContrato.TotalDiasEstimado;
  FHraIniCob := EncodeTime (HourOf(tmpDtaHraIniCob), MinuteOf(tmpDtaHraIniCob), SecondOf(tmpDtaHraIniCob), MilliSecondOf(tmpDtaHraIniCob));
  FHraFinCob := FHraIniCob;
end;

function TFaturamentoContrato.fValidaCondicaoPagamentoParaAdiantamento(const strConPag: String): Boolean;
Begin
  Result := True;
  If FobjValidaCtr.fContratoPossuiAdiantamento Then
  Begin
    pCarredaDadosAdiantamento;

    If (fStatusCndPag(strConPag) = A_PRAZO) And (StrToInt(Copy(strConPag,1,2)) >= 2) Then
    Begin
      FObjfatVenda.recValAdt := TAdiantamento.fGetTotaisAdiantamento(FNumDocAdt, FEspDocAdt, FEmpDocAdt);
      FObjfatVenda.pCalculaTotalParaCadRec;
      Result := (FObjfatVenda.fltTotCadRec > FObjfatVenda.recValAdt.fltValLan);
    End;
  End;
End;

function TFaturamentoContrato.fInformaPagamento: Boolean;
Var
  frmDigCndPagamento : TfrmDigCndPagamento;
Begin
  Result := True;

  If Not FblnInformarFormaPgto Then
    Exit;

  If fCfgSis('CPGCTR', VarBoolean) and FEmFaturamentoMensal Then
    Exit;

  pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
  Try
    frmDigCndPagamento.fraDigCndPagamento.strCodCli := FObjfatVenda.strCodCli;
    frmDigCndPagamento.fraDigCndPagamento.strNomCli := FObjfatVenda.strCliNom;
    frmDigCndPagamento.fraDigCndPagamento.fatVenda  := FObjfatVenda;

    frmDigCndPagamento.fraDigCndPagamento.fatVenda.strCodPagOri := FContrato.CodCondicaoPgto;
    frmDigCndPagamento.fraDigCndPagamento.fatVenda.strConPagOri := FContrato.CondicaoPgto;
    frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := FContrato.CodCondicaoPgto;
    frmDigCndPagamento.fraDigCndPagamento.pCarregaForPag;

    frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text := FContrato.CodFormaPgto;
    frmDigCndPagamento.fraDigCndPagamento.edtDesForPag.Text := FContrato.DescricaoFormPgto;

    frmDigCndPagamento.ShowModal;

    If frmDigCndPagamento.fraDigCndPagamento.blnConfirma Then
    Begin
      FCodCondicaoPgto := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
      FCondicaoPgto := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
      FCodFormaPgto := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;

      If (FCodCondicaoPgto <> FContrato.CodCondicaoPgto) Then
      Begin
        If fSenhaAlteracaoFormaPagamento Then
        Begin
          FObjfatVenda.strConPag := FCondicaoPgto;
          FObjfatVenda.strCodCnd := FCodCondicaoPgto;
          FObjfatVenda.strCodFpg := FCodFormaPgto;
        End
        Else
        Begin
          Result := False;
          Exit;
        End;
      End;

      FObjfatVenda.strConPag := FCondicaoPgto;
      FObjfatVenda.strCodCnd := FCodCondicaoPgto;
      FObjfatVenda.strCodFpg := FCodFormaPgto;

      If Not fValidaCondicaoPagamentoParaAdiantamento(FCondicaoPgto) Then
      Begin
        FMensagemRetorno := 'O contrato possui contrato com valor de adiantamento maior que o valor faturado. Utilize uma condição à vista para prosseguir.';
        Result := False;
        Exit;
      End;

    End
    Else
    Begin
      Result := False;
    End;
  Finally
    pFreeAndNil(frmDigCndPagamento);
  End;
End;

function TFaturamentoContrato.fProcessarEncerramento(const blnEncerrar: Boolean): Boolean;
begin

  If Not fVerificaPodeEncerrarItensMarcados Then
  Begin
    Result := False;
  End
  Else
  Begin
    Result := fEncerrarItensContrato;
    If Result And (Not blnEncerrar) Then
      FMensagemRetorno := 'Encerramento item realizado com sucesso!';
  End;

  If Result And ((fVerificaTodosItensEncerrados) Or (blnEncerrar)) Then
    fEncerrarContrato(True);
end;

function TFaturamentoContrato.fEmitirFaturaNotaServico: Boolean;
begin
  FObjfatVenda.pPreencheMatrizFechamento;
  FObjfatVenda.pCalculaPesBruLiq;
  FObjfatVenda.pCalculaTotGer();
  FObjfatVenda.strDesCla := fRetDesCla(FObjfatVenda.strClaFis);

  If Not fGeraContasReceber Then
    Exit(False);

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    Try
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjfatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Nota fiscal de envio...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If Result Then
      Begin
        FNumDoc := FObjfatVenda.strNumDoc;
        FEmpDoc := FObjfatVenda.strEmpDoc;
        FDocumentoGerado := FObjfatVenda.strNumDoc + '-'+ FObjfatVenda.strEspDoc + '-'+ FObjfatVenda.strEmpDoc;
        FblnBoletoImpresso := FObjfatVenda.objFatVendaImp.blnBoletoImpresso;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TFaturamentoContrato.fEmiteNotaSimplesRemessa]');
        Result := False;
      End;
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TFaturamentoContrato.fEmitirFatura: Boolean;
begin
  FblnFatEmitida := False;
  Try
    If fCfgSis('LECRSN', varBoolean) Then
    Begin
      Result := fEmitirFaturaContasReceber;
    End
    Else
      Result := fEmitirFaturaNotaServico;

    FblnFatEmitida := Result;

  Except
    On E: Exception Do
    Begin
      raise;
    End;
  End;
end;

function TFaturamentoContrato.fEmitirFaturaContasReceber: Boolean;
begin
  FObjfatVenda.pPreencheMatrizFechamento;
  FObjfatVenda.pCalculaPesBruLiq;
  FObjfatVenda.pCalculaTotGer();
  FObjfatVenda.strDesCla := fRetDesCla(FObjfatVenda.strClaFis);

  If Not fGeraContasReceber Then
    Exit(False);

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := FObjfatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Contas a Receber...';
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;
    Finally
      pFreeAndNil(frmGravando);
    End;

    If Result Then
    Begin
      FNumDoc := FObjfatVenda.strNumDoc;
      FEmpDoc := FObjfatVenda.strEmpDoc;
      FDocumentoGerado := FObjfatVenda.strNumDoc + '-'+ FObjfatVenda.strEspDoc + '-'+  FObjfatVenda.strEmpDoc;
      FblnBoletoImpresso := FObjfatVenda.objFatVendaImp.blnBoletoImpresso;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFaturamentoContrato.fEmitirFaturaContasReceber]');
      Result := False;
    End;
  End;
end;

function TFaturamentoContrato.fEncerrarContrato(blnEncerrar: Boolean): Boolean;
begin
  Result := True;

  If Not FobjValidaCtr.fPodeEncerrarContrato(False) Then
  Begin
    FMensagemRetorno := FobjValidaCtr.strMensagemRetorno;
    Exit(False);
  End;

  If (FobjValidaCtr.fContratoPossuiValorFaturado) Then
    Result := ValidaLiberacaoEncerramentoContratoComFaturamento;

  If Not Result Then
    Exit;

  If Not CancelarFinanceiroEmAberto Then
    Exit;

  pBaixaPedidoAdiantamento;
  Result := fGravaStatusFaturado(blnEncerrar);

  Result := Result And EncerrarTodosItensContrato;

end;

function TFaturamentoContrato.fEncerrarItensContrato: Boolean;
var
  strUpdate,
  strUpdateEqlDet: String;
  qryUpd: TUniQuery;
  intCnt: Integer;
begin
  strUpdate := '';
  strUpdate := strUpdate + 'UPDATE EQLFAT SET EQF_DTAENC = :DTAENC ';
  strUpdate := strUpdate + 'WHERE EQF_SEQCON = :SEQCON             ';
  strUpdate := strUpdate + '  AND EQF_SEQEQL = :SEQEQL             ';

  strUpdateEqlDet := '';
  strUpdateEqlDet := strUpdateEqlDet + 'UPDATE EQLDET SET EQD_DTAENC = :DTAENC ';
  strUpdateEqlDet := strUpdateEqlDet + 'WHERE EQD_SEQCON = :SEQCON             ';
  strUpdateEqlDet := strUpdateEqlDet + '  AND EQD_SEQEQL = :SEQEQL             ';

  qryUpd := fCriaQuery();
  Try
    For intCnt := 0 to FListaItens.Count -1 Do
    Begin
      If Not FListaItens[intCnt].blnEncerrarItem Then
        Continue;

      qryUpd.SQL.Clear;
      qryUpd.SQL.Text := strUpdate;
      qryUpd.ParamByName('SEQCON').AsString := FContrato.AutInc;
      qryUpd.ParamByName('SEQEQL').AsString := FListaItens[intCnt].FItem.Equipamento.Codigo;
      qryUpd.ParamByName('DTAENC').AsDateTime := fNow();
      qryUpd.ExecSQL;

      qryUpd.SQL.Clear;
      qryUpd.SQL.Text := strUpdateEqlDet;
      qryUpd.ParamByName('SEQCON').AsString := FContrato.AutInc;
      qryUpd.ParamByName('SEQEQL').AsString := FListaItens[intCnt].FItem.Equipamento.Codigo;
      qryUpd.ParamByName('DTAENC').AsDateTime := fNow();
      qryUpd.ExecSQL;
    End;

    Result := True;
  Finally
    FreeAndNil(qryUpd);
  End;

end;

function TFaturamentoContrato.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TFaturamentoContrato.GetBlnAdt: Boolean;
begin
  Result := FblnRealizarAdiantamentoAgrup;
end;

function TFaturamentoContrato.GetBlnBol: Boolean;
begin
  Result := FblnEmitirBoleto;
end;

function TFaturamentoContrato.GetBlnTxEnt: Boolean;
begin
  Result := FBlnAdicionarTaxaEntrega;
end;

function TFaturamentoContrato.GetBltImp: Boolean;
begin
  Result := FblnBoletoImpresso;
end;

function TFaturamentoContrato.GetCodCnd: String;
begin
  Result := FCodCondicaoPgto;
end;

function TFaturamentoContrato.GetCodFpg: String;
begin
  Result := FCodFormaPgto;
end;

function TFaturamentoContrato.GetContrato: TContratoLocacaoEquipamentos;
begin
  Result := FContrato;
end;

function TFaturamentoContrato.GetDesCnd: String;
begin
  Result := FCondicaoPgto;
end;

function TFaturamentoContrato.GetDocGer: String;
begin
  Result := FDocumentoGerado;
end;

function TFaturamentoContrato.GetDtaFat: TDateTime;
begin
  Result := FDtaFat;
end;

function TFaturamentoContrato.GetDtaFinCob: TDateTime;
begin
  Result := FDtaFinCob;
end;

function TFaturamentoContrato.GetDtaIniCob: TDateTime;
begin
  Result := FDtaIniCob;
end;

function TFaturamentoContrato.GetDtaRef: TDateTime;
begin
  Result := FDtaRef;
end;

function TFaturamentoContrato.GetEmpDoc: String;
begin
  Result := FEmpDoc;
end;

function TFaturamentoContrato.GetEmpDocAdt: String;
begin
  Result := FEmpDocAdt;
end;

function TFaturamentoContrato.GetEncCtr: Boolean;
begin
  Result := FblnEncerrarContrato;
end;

function TFaturamentoContrato.GetEspDoc: String;
begin
  Result := FEspDoc;
end;

function TFaturamentoContrato.GetEspDocAdt: String;
begin
  Result := FEspDocAdt;
end;

function TFaturamentoContrato.GetFatMen: Boolean;
begin
  Result := FEmFaturamentoMensal;
end;

function TFaturamentoContrato.GetHorRef: TDateTime;
begin
  Result := FHraRef;
end;

function TFaturamentoContrato.GetHraFat: TDateTime;
begin
  Result := FHraFat;
end;

function TFaturamentoContrato.GetHraFinCob: TDateTime;
begin
  Result := FHraFinCob;
end;

function TFaturamentoContrato.GetHraIniCob: TDateTime;
begin
  Result := FHraIniCob;
end;

function TFaturamentoContrato.GetInfPgt: Boolean;
begin
  Result := FblnInformarFormaPgto;
end;

function TFaturamentoContrato.GetLDup: TList<TDupFaturamentoContrato>;
begin
  Result := FListaDuplicatas;
end;

function TFaturamentoContrato.GetLItens: TList<TItemFaturamentoContrato>;
begin
  Result := FListaItens;
end;

function TFaturamentoContrato.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TFaturamentoContrato.GetNumDoc: String;
begin
  Result := FNumDoc;
end;

function TFaturamentoContrato.GetNumDocAdt: String;
begin
  Result := FNumDocAdt;
end;

function TFaturamentoContrato.GetObjFtV: TFatVenda;
begin
   Result :=  FObjFatVenda;
end;

function TFaturamentoContrato.GetPerTotDes: Double;
begin
  Result := FPerTotDes;
end;

function TFaturamentoContrato.GetSerDoc: String;
begin
  Result := FSerDoc;
end;

function TFaturamentoContrato.GetStrObs: String;
begin
  Result := FstrObs;
end;

function TFaturamentoContrato.GetTipFat: TTipoFaturamentoLocacao;
begin
  Result := FTipoFaturamento;
end;

function TFaturamentoContrato.GetTotDia: Double;
begin
  Result := FTotDia;
end;

function TFaturamentoContrato.GetTotHor: Double;
begin
  Result := FTotHor;
end;

function TFaturamentoContrato.GetTotMes: Double;
begin
  Result := FTotMes;
end;

function TFaturamentoContrato.GetValCtr: TValidarContrato;
begin
  Result := FobjValidaCtr;
end;

function TFaturamentoContrato.GetVlrAdc: Double;
begin
  Result := FVlrTotAdc;
end;

function TFaturamentoContrato.GetVlrAFt: Double;
begin
  Result := FVlrTotFat;
end;

function TFaturamentoContrato.GetVlrEqu: Double;
begin
  Result := FVlrTotEqu;
end;

function TFaturamentoContrato.GetVlrIpe: Double;
begin
  Result := FVlrTotIpe;
end;

function TFaturamentoContrato.GetVlrJFt: Double;
begin
  Result := FVlrTotJFat;
end;

function TFaturamentoContrato.GetVlrRFl: Double;
begin
  Result := FVlrTotRLq;
end;

function TFaturamentoContrato.GetVlrRFt: Double;
begin
  Result := FVlrTotRes;
end;

function TFaturamentoContrato.GetVlrTot: Double;
begin
  Result := FVlrTotal;
end;

function TFaturamentoContrato.GetVlrTotDes: Double;
begin
  Result := FVlrTotDes;
end;

procedure TFaturamentoContrato.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TFaturamentoContrato.SetBlnAdt(const AValue: Boolean);
begin
  FblnRealizarAdiantamentoAgrup := AValue;
end;

procedure TFaturamentoContrato.SetBlnBol(const AValue: Boolean);
begin
  FblnEmitirBoleto := AValue;
end;

procedure TFaturamentoContrato.SetCodCnd(const AValue: String);
begin
  FCodCondicaoPgto := AValue;
end;

procedure TFaturamentoContrato.SetCodFpg(const AValue: String);
begin
  FCodFormaPgto := AValue;
end;

procedure TFaturamentoContrato.SetContrato(
  const AValue: TContratoLocacaoEquipamentos);
begin
  FContrato := AValue;
end;

procedure TFaturamentoContrato.SetDesCnd(const AValue: String);
begin
  FCondicaoPgto := AValue;
end;

procedure TFaturamentoContrato.SetDocGer(const AValue: String);
begin
  FDocumentoGerado := AValue;
end;

procedure TFaturamentoContrato.SetDtaFat(const AValue: TDateTime);
begin
  FDtaFat := AValue;
end;

procedure TFaturamentoContrato.SetDtaRef(const AValue: TDateTime);
begin
  FDtaRef := AValue;
end;

procedure TFaturamentoContrato.SetEmpDoc(const AValue: String);
begin
  FEmpDoc := AValue;
end;

procedure TFaturamentoContrato.SetEncCtr(const AValue: Boolean);
begin
  FblnEncerrarContrato := AValue;
end;

procedure TFaturamentoContrato.SetEspDoc(const AValue: String);
begin
  FEspDoc := AValue;
end;

procedure TFaturamentoContrato.SetFatMen(const AValue: Boolean);
begin
  FEmFaturamentoMensal := AValue;
end;

procedure TFaturamentoContrato.SetHorRef(const AValue: TDateTime);
begin
  FHraRef := AValue;
end;

procedure TFaturamentoContrato.SetHraFat(const AValue: TDateTime);
begin
  FHraFat := AValue;
end;

procedure TFaturamentoContrato.SetInfPgt(const AValue: Boolean);
begin
  FblnInformarFormaPgto := AValue;
end;

procedure TFaturamentoContrato.SetNumDoc(const AValue: String);
begin
  FNumDoc := AValue;
end;

procedure TFaturamentoContrato.SetSerDoc(const AValue: String);
begin
  FSerDoc := AValue;
end;

procedure TFaturamentoContrato.SetStrObs(const Value: String);
begin
  FstrObs := Value;
end;

procedure TFaturamentoContrato.SetTipFat(const AValue: TTipoFaturamentoLocacao);
begin
  FTipoFaturamento := AValue;
end;

procedure TFaturamentoContrato.SetTotDia(const AValue: Double);
begin
  FTotDia := AValue;
end;

procedure TFaturamentoContrato.SetTotHor(const AValue: Double);
begin
  FTotHor := AValue;
end;

procedure TFaturamentoContrato.SetTotMes(const Value: Double);
begin
  FTotMes := Value;
end;

procedure TFaturamentoContrato.SetVlrAdc(const AValue: Double);
begin
  FVlrTotAdc := AValue;
end;

procedure TFaturamentoContrato.SetVlrAFt(const AValue: Double);
begin
  FVlrTotFat := AValue;
end;

procedure TFaturamentoContrato.SetVlrEqu(const Value: Double);
begin
  FVlrTotEqu := Value;
end;

procedure TFaturamentoContrato.SetVlrIpe(const AValue: Double);
begin
  FVlrTotIpe := AValue;
end;

procedure TFaturamentoContrato.SetVlrJFt(const AValue: Double);
begin
  FVlrTotJFat := AValue;
end;

procedure TFaturamentoContrato.SetVlrRFL(const AValue: Double);
begin
  FVlrTotRLq := AValue;
end;

procedure TFaturamentoContrato.SetVlrRFt(const AValue: Double);
begin
  FVlrTotRes := AValue;
end;

procedure TFaturamentoContrato.SetVlrTot(const AValue: Double);
begin
  FVlrTotal := AValue;
end;

function TFaturamentoContrato.ValidaContratoComAgrupamentoCR: Boolean;
var
  LCont: Integer;
Begin
  Try
    pCarregarFaturamento(False);
    For LCont:= 0 To FListaItens.Count-1 Do
    Begin
      If VerificaDocumentoAgrupado(FListaItens[LCont].EspFat,
                                   FListaItens[LCont].NumFat,
                                   FContrato.Cliente.Codigo ) Then

      Begin
        FMensagemRetorno := 'O documento ' + FListaItens[LCont].NumFat + '-' + FListaItens[LCont].EspFat +
                            ' possui agrupamentos, portanto não será possível realizar o cancelamento do financeiro';
        Exit(False);
      End;
    End;
    Result := True;
  Except
    Result := False;
  End;
End;

function TFaturamentoContrato.ValidaDireitoAcessoExclusaoDuplicatasEmAberto: Boolean;
var
  objLib: TLiberacao;
  objLinha  : TLinhaMsgLibera;
  objTabela : TRegistroMsgLiberaTabela;
  LCont: Integer;
Begin
  objLib := TLiberacao.Create;
  Try
    objLib.Clear;
    objLib.strDirAce    := 'ENCCTF';
    objLib.strMsgSen    := 'Permitir excluir o financeiro em aberto do faturamento antecipado ao encerrar contrato';
    objLib.strCodOpe    := strLoginUsuarioLogado;
    objLib.objMsgLibera.pAddTexto('Permitir encerrar contrato sem faturamento');
    objLib.objMsgLibera.pAddTexto('');
    objLib.objMsgLibera.pAddTexto('Contrato:' + FobjValidaCtr.ObjContrato.NroContrato);
    objLib.objMsgLibera.pAddTexto('Cliente:'  + FobjValidaCtr.ObjContrato.CodCliente + ' - ' + FobjValidaCtr.ObjContrato.NomCliente);
    objLib.objMsgLibera.pAddTexto('');
    objLib.objMsgLibera.pAddTexto('Duplicatas em aberto que serão excluídas: ');

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Documento', 55  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Parcela', 15 , alCentro , teAutcom);
    objLinha.pAddColuna(''  , 'Empresa', 15 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Dta.Venc.', 20 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Valor da Parcela', 20 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    CarregarDuplicatasFaturadasContrato;

    For LCont:= 0 To FListaDuplicatas.Count-1 Do
    Begin
      If FListaDuplicatas[LCont].DataRecebimento <= 0 Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Documento', FListaDuplicatas[LCont].NumDup + '-' + FListaDuplicatas[LCont].EspDoc , 55  , alEsquerda);
        objLinha.pAddColuna('Parcela', FListaDuplicatas[LCont].Parcela , 15 , alCentro);
        objLinha.pAddColuna('Empresa', FEmpDoc , 15  , alCentro);
        objLinha.pAddColuna('Dta.Venc.', FormatDateTime('dd/mm/yyyy hh:mm', FListaDuplicatas[LCont].DataVencimento) , 20 , alCentro);
        objLinha.pAddColuna('Valor da Parcela', FormatFloat('#,0.00', FListaDuplicatas[LCont].ValorReceber), 20 , alDireita);
        objTabela.lstLinhas.Add(objLinha);
      End;
    End;

    objLib.objMsgLibera.lstRegistros.Add(objTabela);

    Result := objLib.fLibera;

  Finally
    FreeAndNil(objLib);
  End;
End;

function TFaturamentoContrato.ValidaFaturamentoNoPrazoEstimado: Boolean;
var
  LCont: Integer;
  LDtaRefAux: TDateTime;
begin
  Result := True;

  LDtaRefAux := FDtaRef + FHraRef;

  For LCont := 0 To FListaItens.Count-1 Do
  Begin
    If FListaItens[LCont].FItem.DataInicialCobranca > FContrato.DataFinalEstimada Then
    Begin
      Result := False;
      Break;
    End;

    If Not ((LDtaRefAux > FContrato.DataInicialEstimada) And (LDtaRefAux < FContrato.DataFinalEstimada)) Then
    Begin
      Result := False;
      Break;
    End;
  End;
end;

function TFaturamentoContrato.ValidaLiberacaoEncerramentoContratoComFaturamento: Boolean;
begin
  FExcluirFaturamentoEncerramento := False;

  If Not fCfgSis('ENCCTR', varBoolean) Then
  Begin
    Exit(True);
  End;

  If FEmFaturamentoMensal Then
  Begin
    Exit(True);
  End;

  If FVlrTotFat > 0 Then
  Begin
    Exit(True);
  End;

  If Not ValidaContratoComAgrupamentoCR Then
    Exit(False);

  If fMensagem('ATENÇÃO!', 'Existem duplicatas em aberto referente ao faturamento antecipado, deseja excluí-los?',
                            ['&Sim', '&Não']) = 2 Then
  Begin
    Exit(False);
  End;

  Result := ValidaDireitoAcessoExclusaoDuplicatasEmAberto;
  FExcluirFaturamentoEncerramento := Result;

end;

function TFaturamentoContrato.TodosEquipamentosMarcadosFaturar: Boolean;
begin
  Result := (FListaItens.Count = FContrato.Itens.Count);
end;

{ TItemFaturamentoContrato }

constructor TItemFaturamentoContrato.Create(
  Owner: TFaturamentoContrato);
begin
  FFatura := Owner;
  pLimpar;
end;

destructor TItemFaturamentoContrato.Destroy;
begin

  inherited;
end;

function TItemFaturamentoContrato.GetBlnEnc: Boolean;
begin
  Result := FblnEncerrarItem;
end;

function TItemFaturamentoContrato.GetBlnFat: Boolean;
begin
  Result := FblnFaturarItem;
end;

function TItemFaturamentoContrato.GetBlnTaxEnt: Boolean;
begin
  Result := FBlnAdicionarTaxEntItem;
end;

function TItemFaturamentoContrato.GetDiaCal: Double;
begin
  Result := FTotDiaCalc;
end;

function TItemFaturamentoContrato.GetDscFat: Double;
Begin
  Result := FVlrDsc;
End;

function TItemFaturamentoContrato.GetDtaEnc: TDateTime;
begin
  Result := FDtaEnc;
end;

function TItemFaturamentoContrato.GetDtaFat: TDateTime;
begin
  Result := FDtaFat;
end;

function TItemFaturamentoContrato.GetDtaFinCob: TDateTime;
begin
  Result := FdtaFinCobFat;
end;

function TItemFaturamentoContrato.GetDtaIniCob: TDateTime;
begin
  Result := FdtaIniCobFat;
end;

function TItemFaturamentoContrato.GetDtaRef: TDateTime;
begin
  Result := FDtaRef;
end;

function TItemFaturamentoContrato.GetDurLoc: Double;
begin
  Result := FDuracaoLocacaoItem;
end;

function TItemFaturamentoContrato.GetHorCal: Double;
begin
  Result := FTotHorCalc;
end;

function TItemFaturamentoContrato.GetItem: TItemContratoLocacaoEquipamentos;
begin
  Result := FItem;
end;

function TItemFaturamentoContrato.GetMesCal: Double;
begin
  Result := FTotMesCalc;
end;

function TItemFaturamentoContrato.GetNumFat: String;
begin
  Result := FNumFat;
end;

function TItemFaturamentoContrato.GetPerFat: Double;
begin
  Result := FPerDes;
end;

function TItemFaturamentoContrato.GetTotDia: Double;
begin
  Result := FTotDiaCalc;
end;

function TItemFaturamentoContrato.GetTotDsc: Double;
begin
  Result := FTotDes;
end;

function TItemFaturamentoContrato.GetTotHor: Double;
begin
  Result := FTotHorCalc;
end;

function TItemFaturamentoContrato.GetVlRFat: Double;
begin
  Result := FVlRFat;
end;

function TItemFaturamentoContrato.GetVlrLoc: Double;
begin
  Result := FValorLocacaoOriginal;
end;

function TItemFaturamentoContrato.GetVlrTot: Double;
begin
  Result := FVlrTot;
end;

function TItemFaturamentoContrato.ItemPossuiValorCobrancaTroca: Boolean;
var
  LSQLSelect: String;
  LQuery: TUniQuery;
begin
  Result := False;

  LSQLSelect := 'SELECT COUNT(*) AS QTDTROCAS FROM TRCEQL C '+
                'INNER JOIN TRCDET D ON C.AUTOINCREM = D.TRC_SEQTRC  ' +
                'WHERE C.TRC_SEQCON = :TRC_SEQCON ' +
                '  AND D.TRC_CODEQL = :TRC_CODEQL ' +
                '  AND D.TRC_VLRCOB > 0 ' ;
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Clear;
    LQuery.SQL.Add(LSQLSelect);
    LQuery.ParamByName('TRC_SEQCON').AsString := FItem.Contrato.AutInc;
    LQuery.ParamByName('TRC_CODEQL').AsString := FItem.Equipamento.Codigo;
    LQuery.Open;
    If Not(LQuery.IsEmpty) Then
    Begin
      Result := (LQuery.FieldByName('QTDTROCAS').AsInteger > 0);
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TItemFaturamentoContrato.GetValFat: Double;
begin
  Result := FValFat;
end;

function TItemFaturamentoContrato.GetVlAFat: Double;
begin
  Result := FVlAFat;
end;

function TItemFaturamentoContrato.GetVlJFat: Double;
begin
  Result := FVlJFat;
end;

function TItemFaturamentoContrato.GetVlLiqR: Double;
begin
  Result := FVlrLiq;
end;

function TItemFaturamentoContrato.GetVlrAdc: Double;
begin
  Result := FVlrAdc;
end;

function TItemFaturamentoContrato.GetVlrCob: Double;
begin
  Result := FVlrCob;
end;

procedure TItemFaturamentoContrato.pRecalculaContratoDataRef(const aDataReferencia: TDateTime);
Begin
  FItem.Contrato.DataInicial := fObtemData(FItem.DataInicialCobranca);
  FItem.Contrato.HoraInicial := fObtemHora(FItem.DataInicialCobranca);

  If FItem.InspecaoEntradaRealizada Then
  Begin
    FItem.Contrato.DataFinal := fObtemData(FItem.DataFinalCobranca);
    FItem.Contrato.HoraFinal := fObtemHora(FItem.DataFinalCobranca);
  End
  Else
  Begin
    FItem.DataFinalCobranca := aDataReferencia;
    FItem.Contrato.DataFinal := fObtemData(aDataReferencia);
    FItem.Contrato.HoraFinal := fObtemHora(aDataReferencia);
  End;
  FItem.Contrato.pCalculaDuracaoContrato;
End;

function TItemFaturamentoContrato.fAlteraValorLiquidoItem(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False; blnReacalcularTotaisLiq: Boolean = False): Boolean;
Var
  fltVlrLocacaoLiq: Double;
  blnAlterarDesconto: Boolean;
Begin
  If (Not blnReacalcularDesconto) And (Not blnReacalcularTotaisLiq) Then
    Exit(True);

  Result := False;

  If blnReacalcularDesconto Then
  Begin
    If ((fformatafloat(fltPerDsc, 4)) <> fformatafloat(FItem.PercentualDesconto, 4)) or
       ((fformatafloat(fltVlrDsc, 4)) <> fformatafloat(FItem.ValorDesconto, 4)) Then
    Begin
      If ((fltPerDsc = FPerDes) And (fltVlrDsc = FVlrDsc)) Then
        blnAlterarDesconto := FItem.blnDescontoLiberado
      Else
        blnAlterarDesconto := FItem.fValidarDesconto(fltPerDsc, fltVlrDsc);

      If blnAlterarDesconto Then
      Begin
        FItem.PercentualDesconto := fltPerDsc;
        FItem.ValorDesconto := fltVlrDsc;
        FItem.blnValorLocacaoAlteradoManualmente := False;
        FItem.pCalcularValorLocacao;
        Result := True;
      End
      Else
        Result := True;
    End
    Else
     Result := True;
  End;

  If blnReacalcularTotaisLiq Then
  Begin
    fltVlrLocacaoLiq := (fformatafloat(FItem.ValorTotalLocacaoContratado, 2) + FVlrCob) - fltTotLiq;
    FItem.blnValorLocacaoAlteradoManualmente := False;
    FItem.blnRecalcularVlrLocacao := False;
    FItem.pCalculaValorDesconto(0, fltVlrLocacaoLiq);
    Result := FItem.blnDescontoLiberado;
  End;
End;

procedure TItemFaturamentoContrato.pRecalcularFaturamentoTotal(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
  blnReacalcularTotaisLiq: Boolean = False; blnEncerrarItem: Boolean = False);
begin
  pCarregarDadosFaturamentoPorEquipamento(FItem.Equipamento.Codigo);

  If Not blnEncerrarItem Then
    pCalcularFaturamentoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto,blnReacalcularTotaisLiq)
  Else
    pCalcularEncerramentoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto,blnReacalcularTotaisLiq);
end;

procedure TItemFaturamentoContrato.pRecalcularFaturamentoParcial(
  const aDataReferencia: TDateTime; fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
  blnReacalcularTotaisLiq: Boolean = False; blnEncerrarItem: Boolean = False);
begin
  pCarregarDadosFaturamentoPorEquipamento(FItem.Equipamento.Codigo);

  If Not FItem.InspecaoEntradaRealizada Then
    FItem.DataFinalCobranca := aDataReferencia;

  If Not blnEncerrarItem Then
    pCalcularFaturamentoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto, blnReacalcularTotaisLiq)
  Else
    pCalcularEncerramentoItemParcial(aDataReferencia, fltPerDsc, fltVlrDsc, fltTotLiq,blnReacalcularDesconto, blnReacalcularTotaisLiq);
end;

procedure TItemFaturamentoContrato.pCalcularDuracaoItem(const aDataReferencia: TDateTime);
var
  dtaInicialCobrancaAux: TDateTime;
  dtaFinalCobrancaAux: TDateTime;
  fltTotDia,
  fltTotHor,
  fltTotMes: Double;
begin
  FTotDiaCalc := 0;
  FTotHorCalc := 0;
  FTotMesCalc := 0;
  FDataRefFat := fObterDataReferenciaUltimoFaturamento;
  dtaFinalCobrancaAux := 0;

  dtaInicialCobrancaAux:= FDataRefFat;
  If dtaInicialCobrancaAux <= 0 Then
    dtaInicialCobrancaAux := FItem.DataInicialCobranca;

  If FItem.InspecaoEntradaRealizada Then
    dtaFinalCobrancaAux := FItem.DataFinalCobranca
  Else
  Begin
    Case FFatura.FTipoFaturamento  of
      tpTotal   : dtaFinalCobrancaAux := FItem.DataFinalCobranca;
      tpParcial : dtaFinalCobrancaAux := aDataReferencia;
    End;
  End;

  fltTotHor := TCalcularPeriodoFatura.New.CalculaTotalHoras(dtaInicialCobrancaAux, dtaFinalCobrancaAux);
  fltTotDia := TCalcularPeriodoFatura.New.CalculaTotalDias(dtaInicialCobrancaAux, dtaFinalCobrancaAux);
  fltTotMes := TCalcularPeriodoFatura.New.CalculaTotalMeses(dtaInicialCobrancaAux, dtaFinalCobrancaAux, True);

  FdtaIniCobFat := dtaInicialCobrancaAux;
  FdtaFinCobFat := dtaFinalCobrancaAux;

  If FItem.InspecaoEntradaRealizada Then
  Begin
    FTotDiaCalc := TCalcularPeriodoFatura.New.CalculaTotalDias(FItem.DataInicialCobranca, FItem.DataFinalCobranca);
    FTotHorCalc := TCalcularPeriodoFatura.New.CalculaTotalHoras(FItem.DataInicialCobranca, FItem.DataFinalCobranca);
    FTotMesCalc := TCalcularPeriodoFatura.New.CalculaTotalMeses(FItem.DataInicialCobranca, FItem.DataFinalCobranca, True);
  End
  Else
  Begin
    FTotDiaCalc := fltTotDia;
    FTotHorCalc := fltTotHor;
    FTotMesCalc := fltTotMes;
  End;

  case FItem.TipoCalculoLocacao  of
    tpDiaria: Begin
                FDuracaoLocacaoItem := fltTotDia;
              End;
    tpHoras:  Begin
                FDuracaoLocacaoItem := fltTotHor;
              End;
    tpMensal:  Begin
                FDuracaoLocacaoItem := fltTotMes;
              End;
  end;

end;

procedure TItemFaturamentoContrato.pCalcularEncerramentoItem(fltPerDsc, fltVlrDsc,
  fltTotLiq: Double; blnReacalcularDesconto, blnReacalcularTotaisLiq: Boolean);
var
  fltDuracaoContratoAnterior: Double;
  LDuracaoEstimada: Double;
begin
  FblnEncerrarItem := True;
  FItem.Contrato.pCarregarDuracaoContrato;
  fltDuracaoContratoAnterior := FItem.Contrato.TotalHoras;
  FItem.Contrato.DataInicial := FItem.DataInicialCobranca;
  FItem.Contrato.DataFinal   := FItem.DataFinalCobranca;
  FItem.blnEncerrarIte := True;
  FItem.Contrato.pCalculaDuracaoContrato;
  FItem.blnEncerrarIte := True;

  pCalcularDuracaoItem(FFatura.DataReferencia + FFatura.HoraReferencia);

  If FItem.Contrato.TotalHoras < fltDuracaoContratoAnterior Then
  Begin
    FItem.PercentualDesconto := 0;
    FItem.ValorDesconto := 0;
    FItem.blnRecalcularVlrLocacao := True;
    FItem.Contrato.pRecalculaItensContrato;
    fltPerDsc := 0;
    fltVlrDsc := 0;
  End
  Else
    FItem.blnRecalcularVlrLocacao := False;

  FItem.pCalcularValorLocacao;
  If Not fAlteraValorLiquidoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto, blnReacalcularTotaisLiq)Then
  Begin
    Exit;
  End;

  LDuracaoEstimada := TCalcularPeriodoFatura.New.CalculaTotalDias(FItem.DataInicialCobranca,
                                                                  FItem.DataFinalCobranca,
                                                                  True);

  FVlrDsc := FItem.ValorDesconto;
  FPerDes := FItem.PercentualDesconto;
  FVlrCob := FItem.ValorTotalCobranca;
  FTaxEnt := IIF(FBlnAdicionarTaxEntItem, FTaxEnt - FTaxEntFat, 0);
  FVlrAdc := FVlrAdc - FVlrAdcFat;
  FVlAFat := fformatafloat(FItem.ValorLocacaoLiquido * LDuracaoEstimada , 2) + FVlrCob + FTaxEnt - FVlJFat + FVlrAdc;
  If FVlAFat < 0 Then
    FVlAFat := 0;

  If ((FFatura.blnEmFaturamentoMensal) And (FVlJFat > 0)) Then
    FValorLocacaoCalculado := ((FVlAFat - (FVlrCob + FTaxEnt + FVlrAdc)) / FDuracaoLocacaoItem)
  Else
    FValorLocacaoCalculado := FItem.ValorLocacaoLiquido;

  FVlRFat := fformatafloat(FItem.ValorTotalLocacaoContratado,2) - (FVlJFat + FVlAFat);
  If FVlRFat < 0 Then
    FVlRFat := 0;
  If FVlJFat > 0 Then
    FVlrLiq := FVlJFat - (fformatafloat(FItem.ValorTotalLiquido, 2) + FVlrCob + FTaxEnt + FVlrAdc);
  If FVlrLiq < 0 Then
    FVlrLiq := 0;
  FVlrTot :=  FVlJFat + FVlAFat + FVlrLiq;

end;

procedure TItemFaturamentoContrato.pCalcularEncerramentoItemParcial(
  aDataReferencia: TDateTime; fltPerDsc,  fltVlrDsc, fltTotLiq: Double;
  blnReacalcularDesconto, blnReacalcularTotaisLiq: Boolean);
var
  fltDuracaoContratoAnterior: Double;
  LDuracaoEstimada: Double;
begin
  FblnEncerrarItem := True;
  FItem.Contrato.pCarregarDuracaoContrato;
  fltDuracaoContratoAnterior := FItem.Contrato.TotalHoras;
  FItem.Contrato.DataInicial := FItem.DataInicialCobranca;
  FItem.Contrato.DataFinal   := FItem.DataFinalCobranca;
  FItem.blnEncerrarIte := True;
  FItem.Contrato.pCalculaDuracaoContrato;
  FItem.blnEncerrarIte := True;

  pCalcularDuracaoItem(FFatura.DataReferencia + FFatura.HoraReferencia);

  If FItem.Contrato.TotalHoras < fltDuracaoContratoAnterior Then
  Begin
    FItem.PercentualDesconto := 0;
    FItem.ValorDesconto := 0;
    FItem.blnRecalcularVlrLocacao := True;
    FItem.Contrato.pRecalculaItensContrato;
    fltPerDsc := 0;
    fltVlrDsc := 0;
  End
  Else
    FItem.blnRecalcularVlrLocacao := False;

  FItem.pCalcularValorLocacao;
  If Not fAlteraValorLiquidoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto, blnReacalcularTotaisLiq)Then
  Begin
    Exit;
  End;

  LDuracaoEstimada := TCalcularPeriodoFatura.New.CalculaTotalDias(FItem.DataInicialCobranca,
                                                                  FItem.DataFinalCobranca,
                                                                  True);

  FVlrDsc := FItem.ValorDesconto;
  FPerDes := FItem.PercentualDesconto;
  FVlrCob := FItem.ValorTotalCobranca;
  FTaxEnt := IIF(FBlnAdicionarTaxEntItem, FTaxEnt - FTaxEntFat, 0);
  FVlrAdc := FVlrAdc - FVlrAdcFat;
  FVlAFat := fformatafloat(FItem.ValorLocacaoLiquido * LDuracaoEstimada , 2) + FVlrCob + FTaxEnt - FVlJFat + FVlrAdc;
  If FVlAFat < 0 Then
    FVlAFat := 0;

  If ((FFatura.blnEmFaturamentoMensal) And (FVlJFat > 0)) Then
    FValorLocacaoCalculado := ((FVlAFat - (FVlrCob + FTaxEnt + FVlrAdc)) / FDuracaoLocacaoItem)
  Else
    FValorLocacaoCalculado := FItem.ValorLocacaoLiquido;

  FVlRFat := fformatafloat(FItem.ValorTotalLocacaoContratado,2) - (FVlJFat + FVlAFat);
  If FVlRFat < 0 Then
    FVlRFat := 0;
  If FVlJFat > 0 Then
    FVlrLiq := FVlJFat - (fformatafloat(FItem.ValorTotalLiquido, 2) + FVlrCob + FTaxEnt + FVlrAdc);
  If FVlrLiq < 0 Then
    FVlrLiq := 0;
  FVlrTot :=  FVlJFat + FVlAFat + FVlrLiq;

end;

procedure TItemFaturamentoContrato.pCalcularFaturamentoItem(fltPerDsc, fltVlrDsc, fltTotLiq: Double; blnReacalcularDesconto: Boolean = False;
  blnReacalcularTotaisLiq: Boolean = False);
var
  blnRecalcularContrato: Boolean;
  fltTotalDestaFatura: Double;
  fltVlrAdcTotal: Double;
begin
  FTotDiaCalc := 0;
  FTotHorCalc := 0;
  FTotMesCalc := 0;
  fltTotalDestaFatura:= 0;
  blnRecalcularContrato := False;
  FItem.blnEncerrarIte := False;
  FblnEncerrarItem := IIF(FblnEncerrarItem, FblnEncerrarItem, PodeFaturarCobrancaInspecao);

  pCalcularDuracaoItem(FFatura.DataReferencia + FFatura.HoraReferencia);

  fltPerDsc := IIF(FblnAlterarValorManual, FItem.PercentualDesconto, fltPerDsc);
  fltVlrDsc := IIF(FblnAlterarValorManual, FItem.ValorDesconto, fltVlrDsc);

  If Not fAlteraValorLiquidoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto, blnReacalcularTotaisLiq) Then
  Begin
    Exit;
  End;

  If FItem.InspecaoEntradaRealizada Then
  Begin
    Case FItem.TipoCalculoLocacao Of
      tpDiaria: Begin
                  blnRecalcularContrato := FTotDiaCalc < FItem.Contrato.TotalDiasEstimado;
                End;
      tpHoras:  Begin
                  blnRecalcularContrato := FTotHorCalc < FItem.Contrato.TotalHorasEstimadas;
                End;
      tpMensal: Begin
                  blnRecalcularContrato := FTotMesCalc < FItem.Contrato.TotalMesesEstimados;
                End;
    End;
  End;

  If blnRecalcularContrato Then
  Begin
    FItem.Contrato.DataInicial := FItem.DataInicialCobranca;
    FItem.Contrato.DataFinal   := FItem.DataFinalCobranca;
    pRecalculaContratoDataRef(FItem.DataFinalCobranca);
    pCalcularDuracaoItem(FItem.DataFinalCobranca);
    FItem.PercentualDesconto := 0;
    FItem.ValorDesconto := 0;
    fltPerDsc := 0;
    fltVlrDsc := 0;
    FItem.blnRecalcularVlrLocacao := True;
    If Not fAlteraValorLiquidoItem(fltPerDsc, fltVlrDsc, fltTotLiq, blnReacalcularDesconto,blnReacalcularTotaisLiq) Then
    Begin
      Exit;
    End;
    FItem.pCalcularValorLocacao;
  End;

  Case FItem.TipoCalculoLocacao Of
    tpDiaria: Begin
                fltTotalDestaFatura := fformatafloat((FDuracaoLocacaoItem * (FItem.ValorLocacaoLiquido * FItem.Quantidade)), 2);
              End;
    tpHoras:  Begin
                fltTotalDestaFatura := fformatafloat((FDuracaoLocacaoItem * (FItem.ValorLocacaoLiquido * FItem.Quantidade)), 2);
              End;
    tpMensal: Begin
                fltTotalDestaFatura := fformatafloat((FDuracaoLocacaoItem * (FItem.ValorLocacaoLiquido * FItem.Quantidade)), 2);
              End;
  End;

  FValorLocacaoCalculado := IIF((FDuracaoLocacaoItem = 0), 0,  (FItem.ValorLocacaoLiquido * FItem.Quantidade));

  FTaxEnt := IIF(FBlnAdicionarTaxEntItem, FTaxEnt - FTaxEntFat, 0);
  FPerDes := FItem.PercentualDesconto;
  FVlrDsc := FItem.ValorDesconto;
  FVlrCob := IIF(PodeFaturarCobrancaInspecao, FItem.ValorTotalCobranca, 0);

  fltVlrAdcTotal := FVlrAdc;
  FVlrAdc := FVlrAdc - FVlrAdcFat;

  FVlAFat := fltTotalDestaFatura + FTaxEnt + FVlrCob + FVlrAdc;

  If FVlAFat < 0 Then
    FVlAFat := 0;
  FVlRFat := (fformatafloat(FItem.ValorTotalLocacaoContratado , 2) + FVlrCob + FTaxEnt + fltVlrAdcTotal)  -
             (FVlJFat + FVlAFat);
  If FVlRFat < 0 Then
    FVlRFat := 0;
  FVlrLiq := (fformatafloat(FItem.ValorTotalLiquido, 2) + FVlrCob  + FTaxEnt + fltVlrAdcTotal) -
             (FVlJFat + FVlAFat);
  If FVlrLiq < 0 Then
    FVlrLiq := 0;
  FVlrTot :=  FVlJFat + FVlAFat + FVlrLiq;

end;

procedure TItemFaturamentoContrato.pCarregarDadosFaturamentoPorEquipamento(const strCodEql: String; strNumDoc: String = '');
var
  SQLSelect: String;
  qryConsulta: TUniQuery;
  ftlTotItem,
  fltVlrLiqu: Double;
  intcnt: Integer;
begin
  pLimparValoresItemFatura;

  If (Not Assigned(FItem)) Then
    Exit;

  If (Not fEmptyStr(strCodEql)) Then
  Begin
    FItem.Contrato.pCarregarDuracaoContrato;
    FItem.Contrato.pCalculaDuracaoContrato;
    FItem.pCarregar('', strCodEql);
  End;

  If fEmptyStr(FItem.Equipamento.Codigo) Then
  Begin
    Exit;
  End;

  FDataRefFat := fObterDataReferenciaUltimoFaturamento;

  FVlrAdc := 0;
  For intcnt:= 0 To FItem.Acessorios.Count-1 Do
  Begin
    FVlrAdc  := FVlrAdc + (FItem.Acessorios[intCnt].ValorAdicional * FItem.Acessorios[intCnt].Quantidade) * FItem.Quantidade;
  End;

  FTaxEnt := FItem.Contrato.ValorTaxaEntrega;

  SQLSelect := 'SELECT EQLFAT.*                           ' +
               'FROM EQLFAT                               ' +
               'WHERE EQLFAT.EQF_SEQCON = :SEQCON         ' +
               '  AND EQLFAT.EQF_SEQEQL = :SEQEQL         ';
  If Not fEmptyStr(strNumDoc) Then
    SQLSelect := SQLSelect + '  AND EQLFAT.EQF_NUMDOC = :EQF_NUMDOC ';
  SQLSelect := SQLSelect + 'ORDER BY AUTOINCREM               ';
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelect);
    qryConsulta.ParamByName('SEQCON').AsString := FFatura.Contrato.AutInc;
    qryConsulta.ParamByName('SEQEQL').AsString := FItem.Equipamento.Codigo;
    If Not fEmptyStr(strNumDoc) Then
      qryConsulta.ParamByName('EQF_NUMDOC').AsString := strNumDoc;
    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      While Not qryConsulta.EOF Do
      Begin
        fltVlrLiqu := FItem.ValorTotalLiquido + qryConsulta.FieldByName('EQF_TAXENT').AsFloat;
        ftlTotItem := FItem.ValorTotalLocacaoContratado + qryConsulta.FieldByName('EQF_TAXENT').AsFloat;

        FVlJFat := FVlJFat + qryConsulta.FieldByName('EQF_VALFAT').AsFloat;
        FVlAFat := FVlAFat + (fltVlrLiqu - FVlJFat);
        FVlRFat := FVlRFat + (ftlTotItem  - (FVlAFat + FVlJFat));
        FVlrDsc := qryConsulta.FieldByName('EQF_VLRDSC').AsFloat;
        FVlrLiq := FVlrLiq + (fltVlrLiqu - (FVlAFat + FVlJFat));
        If qryConsulta.FieldByName('EQF_DTAENC').AsDateTime > 0 Then
          FDtaEnc := qryConsulta.FieldByName('EQF_DTAENC').AsDateTime;
        FVlrTot := FVlrTot + (FVlAFat + FVlJFat);
        FDtaRef := qryConsulta.FieldByName('EQF_DTAREF').AsDateTime;

        FDtaFat := qryConsulta.FieldByName('EQF_DTAFAT').AsDateTime;
        FEmpFat := qryConsulta.FieldByName('EQF_EMPDOC').AsString;
        FEspFat := qryConsulta.FieldByName('EQF_ESPDOC').AsString;
        FNumFat := qryConsulta.FieldByName('EQF_NUMDOC').AsString;
        FValFat := qryConsulta.FieldByName('EQF_VALFAT').AsFloat;
        FQtdHor := qryConsulta.FieldByName('EQF_QTDHOR').AsFloat;
        FFatura.strObservacao := qryConsulta.FieldByName('EQF_FATOBS').AsString;

        FdtaIniCobFat := qryConsulta.FieldByName('EQF_DTAINI').AsDateTime;
        FdtaFinCobFat := qryConsulta.FieldByName('EQF_DTAFIN').AsDateTime;
        If FdtaIniCobFat <= 0 Then
          FdtaIniCobFat := FItem.DataInicialCobranca;
        If FdtaFinCobFat <= 0 Then
          FdtaFinCobFat := FDtaRef;

        FVlrAdcFat := FVlrAdcFat + qryConsulta.FieldByName('EQF_VLRADC').AsFloat;

        qryConsulta.Next;
      End;
    End;

    FTaxEntFat := fCampoTabela('SUM(EQF_TAXENT)', 'EQLFAT', ['EQF_SEQCON'],
                                                            [FFatura.Contrato.AutInc]);

    FBlnAdicionarTaxEntItem := (FItem.Contrato.ValorTaxaEntrega > 0) and
                               (Not FFatura.fTaxaEntregaAdicionadaFatura) and
                               (FTaxEntFat <= 0) ;

  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

procedure TItemFaturamentoContrato.pLimpar;
begin
  FVlrDsc := 0;
  FDtaEnc := 0;
  FDtaRef := 0;
  FValorLocacaoOriginal := 0;
  FblnFaturarItem := True;
  FblnEncerrarItem := False;
  FBlnAdicionarTaxEntItem := False;
  FEmpFat := EmptyStr;
  FEspFat := EmptyStr;
  FNumFat := EmptyStr;
  FDtaFat := 0;
  FQtdHor := 0;
  pLimparValoresItemFatura;
  FblnAlterarValorManual := False;
end;

procedure TItemFaturamentoContrato.pLimparValoresItemFatura;
begin
  FBlnAdicionarTaxEntItem := False;
  FblnEncerrarItem := False;
  FDuracaoLocacaoItem := 0;
  FValorLocacaoCalculado := 0;
  FVlJFat := 0;
  FVlAFat := 0;
  FVlRFat := 0;
  FVlrLiq := 0;
  FVlrTot := 0;
  FVlrCob := 0;
  FQtdHor := 0;
  FTaxEnt := 0;
  FTaxEntFat := 0;
  FValFat := 0;
  FVlrDsc := 0;
  FPerDes := 0;
  If Assigned(FItem) Then
  Begin
    FVlrDsc := FItem.ValorDesconto;
    FPerDes := FItem.PercentualDesconto;
  End;
  FTotDes := 0;
  FVlrAdc    := 0;
  FVlrAdcFat := 0;
end;

function TItemFaturamentoContrato.PodeFaturarCobrancaInspecao: Boolean;
begin
  Result := False;

  If FFatura.TipoFaturamento = tpTotal Then
  Begin
    Result := (FItem.ValorCobranca > 0) or (ItemPossuiValorCobrancaTroca);
  End

  Else If FFatura.TipoFaturamento = tpParcial Then
  Begin
    Result := ((FItem.ValorCobranca > 0) or (ItemPossuiValorCobrancaTroca)) And FItem.InspecaoEntradaRealizada;
  End;
end;

procedure TItemFaturamentoContrato.SetBlnEnc(const AValue: Boolean);
begin
  FblnEncerrarItem := AValue;
  FItem.blnEncerrarIte  := AValue;
end;

procedure TItemFaturamentoContrato.SetBlnFat(const AValue: Boolean);
begin
  FblnFaturarItem := AValue;
end;

procedure TItemFaturamentoContrato.SetBlnTaxEnt(const AValue: Boolean);
begin
  FBlnAdicionarTaxEntItem := AValue;
end;

procedure TItemFaturamentoContrato.SetDscFat(const AValue: Double);
begin
  FVlrDsc := AValue;
end;

procedure TItemFaturamentoContrato.SetDtaEnc(const AValue: TDateTime);
begin
  FDtaEnc := AValue;
end;

procedure TItemFaturamentoContrato.SetDtaFat(const AValue: TDateTime);
begin
  FDtaFat := AValue;
end;

procedure TItemFaturamentoContrato.SetDtaFinCob(const Value: TDateTime);
begin
  FdtaFinCobFat := Value;
end;

procedure TItemFaturamentoContrato.SetDtaIniCob(const Value: TDateTime);
begin
  FdtaIniCobFat := Value;
end;

procedure TItemFaturamentoContrato.SetDtaRef(const AValue: TDateTime);
begin
  FDtaRef := AValue;
end;

procedure TItemFaturamentoContrato.SetDurLoc(const AValue: Double);
begin
  FDuracaoLocacaoItem := AValue;
end;

procedure TItemFaturamentoContrato.SetItem(
  const AValue: TItemContratoLocacaoEquipamentos);
begin
  FItem := AValue;
end;

procedure TItemFaturamentoContrato.SetNumFat(const AValue: String);
begin
  FNumFat := AValue;
end;

procedure TItemFaturamentoContrato.SetPerFat(const AValue: Double);
begin
  FPerDes := AValue;
end;

procedure TItemFaturamentoContrato.SetTotDia(const AValue: Double);
begin
  FTotDiaCalc := AValue;
end;

procedure TItemFaturamentoContrato.SetTotDsc(const AValue: Double);
begin
  FTotDes := AValue;
end;

procedure TItemFaturamentoContrato.SetTotHor(const AValue: Double);
begin
  FTotHorCalc := AValue;
end;

procedure TItemFaturamentoContrato.SetVlRFat(const AValue: Double);
begin
  FVlRFat := AValue;
end;

procedure TItemFaturamentoContrato.SetVlrLoc(const AValue: Double);
begin
  FValorLocacaoOriginal := AValue;
end;

procedure TItemFaturamentoContrato.SetVlrTot(const AValue: Double);
begin
  FVlrTot := AValue;
end;

procedure TItemFaturamentoContrato.SetValFat(const AValue: Double);
begin
  FValFat := AValue;
end;

procedure TItemFaturamentoContrato.SetVlAFat(const AValue: Double);
begin
  FVlAFat := AValue;
end;

procedure TItemFaturamentoContrato.SetVlJFat(const AValue: Double);
begin
  FVlJFat := AValue;
end;

procedure TItemFaturamentoContrato.SetVlLiqR(const AValue: Double);
begin
  FVlrLiq := AValue;
end;

procedure TItemFaturamentoContrato.SetVlrAdc(const AValue: Double);
begin
  FVlrAdc := AValue;
end;

procedure TItemFaturamentoContrato.SetVlrCob(const AValue: Double);
begin
  FVlrCob := AValue;
end;

function TItemFaturamentoContrato.fGravaFatura: Boolean;
var
  strSQL: String;
  qryIns: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'INSERT INTO EQLFAT ( ';
  strSQL := strSQL + '  AUTOINCREM,        ';
  strSQL := strSQL + '  EQF_SEQCON,        ';
  strSQL := strSQL + '  EQF_NUMDOC,        ';
  strSQL := strSQL + '  EQF_ESPDOC,        ';
  strSQL := strSQL + '  EQF_EMPDOC,        ';
  strSQL := strSQL + '  EQF_SERDOC,        ';
  strSQL := strSQL + '  EQF_DTAFAT,        ';
  strSQL := strSQL + '  EQF_HRAFAT,        ';
  strSQL := strSQL + '  EQF_DTAREF,        ';
  strSQL := strSQL + '  EQF_HORREF,        ';
  strSQL := strSQL + '  EQF_QTDHOR,        ';
  strSQL := strSQL + '  EQF_CONPAG,        ';
  strSQL := strSQL + '  EQF_VALFAT,        ';
  strSQL := strSQL + '  EQF_SEQEQL,        ';
  strSQL := strSQL + '  EQF_VLJFAT,        ';
  strSQL := strSQL + '  EQF_VLAFAT,        ';
  strSQL := strSQL + '  EQF_VLRDSC,        ';
  strSQL := strSQL + '  EQF_VLRFAT,        ';
  strSQL := strSQL + '  EQF_VLRLIQ,        ';
  strSQL := strSQL + '  EQF_TAXENT,        ';
  strSQL := strSQL + '  EQF_VALDES,        ';
  strSQL := strSQL + '  EQF_TOTDES,        ';
  strSQL := strSQL + '  EQF_TIPFAT,        ';
  strSQL := strSQL + '  EQF_DTAINI,        ';
  strSQL := strSQL + '  EQF_DTAFIN,        ';
  strSQL := strSQL + '  EQF_VLRADC         ';

  strSQL := strSQL + ') VALUES (           ';
  strSQL := strSQL + '  :AUTOINC,          ';
  strSQL := strSQL + '  :SEQCON,           ';
  strSQL := strSQL + '  :NUMDOC,           ';
  strSQL := strSQL + '  :ESPDOC,           ';
  strSQL := strSQL + '  :EMPDOC,           ';
  strSQL := strSQL + '  :SERDOC,           ';
  strSQL := strSQL + '  :DTAFAT,           ';
  strSQL := strSQL + '  :HRAFAT,           ';
  strSQL := strSQL + '  :DTAREF,           ';
  strSQL := strSQL + '  :HORREF,           ';
  strSQL := strSQL + '  :QTDHOR,           ';
  strSQL := strSQL + '  :CONPAG,           ';
  strSQL := strSQL + '  :VALFAT,           ';
  strSQL := strSQL + '  :SEQEQL,           ';
  strSQL := strSQL + '  :VLJFAT,           ';
  strSQL := strSQL + '  :VLAFAT,           ';
  strSQL := strSQL + '  :VLRDSC,           ';
  strSQL := strSQL + '  :VLRFAT,           ';
  strSQL := strSQL + '  :VLRLIQ,           ';
  strSQL := strSQL + '  :TAXENT,           ';
  strSQL := strSQL + '  :VALDES,           ';
  strSQL := strSQL + '  :TOTDES,           ';
  strSQL := strSQL + '  :TIPFAT,           ';
  strSQL := strSQL + '  :DTAINI,           ';
  strSQL := strSQL + '  :DTAFIN,           ';
  strSQL := strSQL + '  :VLRADC            ';
  strSQL := strSQL + ')                    ';

  qryIns := fCriaQuery();
  Try
    Try
      qryIns.SQL.Text := strSQL;

      qryIns.ParamByName('AUTOINC').AsString  := fRetAutoIncrem('EQLFAT', VS_strCodEmp);
      qryIns.ParamByName('SEQCON').AsString   := FFatura.Contrato.AutInc;
      qryIns.ParamByName('NUMDOC').AsString   := FFatura.ObjfatVenda.strNumDoc;
      qryIns.ParamByName('ESPDOC').AsString   := FFatura.ObjfatVenda.strEspDoc;
      qryIns.ParamByName('EMPDOC').AsString   := FFatura.ObjfatVenda.strEmpDoc;
      qryIns.ParamByName('SERDOC').AsString   := FFatura.ObjfatVenda.strSerFsc;
      qryIns.ParamByName('SEQEQL').AsString   := FItem.Equipamento.Codigo;
      qryIns.ParamByName('DTAFAT').AsDateTime := VS_Date;
      qryIns.ParamByName('HRAFAT').AsDateTime := fNow();
      qryIns.ParamByName('DTAREF').AsDate     := FItem.DataFinalCobranca;
      qryIns.ParamByName('HORREF').AsDateTime := FItem.DataFinalCobranca;
      qryIns.ParamByName('QTDHOR').AsFloat    := FDuracaoLocacaoItem;
      qryIns.ParamByName('CONPAG').AsString   := FFatura.ObjfatVenda.strConPag;
      Case FFatura.TipoFaturamento Of
        tpTotal  : qryIns.ParamByName('VALFAT').AsFloat := FVlAFat;
        tpParcial: qryIns.ParamByName('VALFAT').AsFloat := FVlAFat;
      End;
      qryIns.ParamByName('VLJFAT').AsFloat    := FVlJFat;
      qryIns.ParamByName('VLAFAT').AsFloat    := FVlAFat;
      qryIns.ParamByName('VLRFAT').AsFloat    := FVlRFat;
      qryIns.ParamByName('VLRLIQ').AsFloat    := FVlrLiq;
      qryIns.ParamByName('TAXENT').AsFloat    := FTaxEnt;
      qryIns.ParamByName('VLRDSC').AsFloat    := FPerDes;
      qryIns.ParamByName('VALDES').AsFloat    := FVlrDsc;
      qryIns.ParamByName('TOTDES').AsFloat    := FTotDes;
      If FFatura.blnEmFaturamentoMensal Then
      Begin
        qryIns.ParamByName('TIPFAT').AsString := 'M';
      End
      Else
      Begin
        Case FFatura.TipoFaturamento Of
          tpTotal  : qryIns.ParamByName('TIPFAT').AsString := 'T';
          tpParcial: Begin
                       If FblnEncerrarItem Then
                         qryIns.ParamByName('TIPFAT').AsString := 'E'
                       Else
                         qryIns.ParamByName('TIPFAT').AsString := 'P';
                     End;
        End;
      End;

      qryIns.ParamByName('DTAINI').AsDateTime := FdtaIniCobFat;
      qryIns.ParamByName('DTAFIN').AsDateTime := FdtaFinCobFat;
      qryIns.ParamByName('VLRADC').AsFloat    := FVlrAdc;

      qryIns.ExecSQL;

      Result := True;

    Except
      On e: Exception do
      Begin
        pMensagensErro(e.Message, '[TfrmFaturaLocEqu.fGravaStatusFaturado]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryIns);
  End;

end;

function TItemFaturamentoContrato.fObterDataReferenciaUltimoFaturamento: TDateTime;
var
  qryConsulta: TUniQuery;
begin
  Result := 0;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add('SELECT * FROM EQLFAT         ');
    qryConsulta.SQL.Add(' WHERE EQF_SEQCON = :SEQCON  ');
    qryConsulta.SQL.Add('   AND EQF_SEQEQL = :SEQEQL  ');
    qryConsulta.SQL.Add('ORDER BY EQF_DTAREF DESC, EQF_HORREF DESC LIMIT 1');
    qryConsulta.ParamByName('SEQCON').AsString := FFatura.Contrato.AutInc;
    qryConsulta.ParamByName('SEQEQL').AsString := FItem.Equipamento.Codigo;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
    Begin
      Result := qryConsulta.FieldByName('EQF_DTAREF').AsDateTime + qryConsulta.FieldByName('EQF_HORREF').AsDateTime;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

{ TFaturamentoMensalContrato }

constructor TFaturamentoMensalContrato.Create;
begin
  FListaFaturaContrato := TList<TFaturamentoContrato>.Create;
  FObjContratoTmp := TContratoLocacaoEquipamentos.Create;
  FblnImpBoletoFinalizacao := False;
  FblnAgruparDuplicatas := False;
  FObjfatVenda := TFatVenda.CreateInstance('LE');
  FListaDuplicatasAgrup := TList<TDupFaturamentoContrato>.Create;
  FobjLock := TLock.Create;
  FobjValidaCtr := TValidarContrato.Create(FObjContratoTmp);
end;

destructor TFaturamentoMensalContrato.Destroy;
begin
  FreeAndNil(FobjLock);
  FreeAndNil(FListaDuplicatasAgrup);
  FreeAndNil(FListaFaturaContrato);
  FreeAndNil(FObjContratoTmp);
  If Assigned(FObjFatVenda) Then
    FreeAndNil(FObjFatVenda);
  If Assigned(FobjValidaCtr) Then
    FreeAndNil(FobjValidaCtr);

  inherited;
end;

function TFaturamentoMensalContrato.fAddContrato(objContrato: TContratoLocacaoEquipamentos): TFaturamentoContrato;
var
  aFatTemp: TFaturamentoContrato;
begin
  If Not fValidaTravasContrato(objContrato.AutInc, False) Then
  Begin
    Result := Nil;
    Exit;
  End;

  FobjValidaCtr.ObjContrato := objContrato;

  If Not FobjValidaCtr.fValidarItensEnviados Then
  Begin
    Result := Nil;
    Exit;
  End;

  If Not FobjValidaCtr.fValidarCondicaoPagamentoInformada Then
  Begin
    Result := Nil;
    Exit;
  End;

  FobjLock.fLock_Unlock(cst_TRAVA_FATMEN_LOCEQU + objContrato.AutInc, True, False);

  aFatTemp := TFaturamentoContrato.Create(objContrato);
  FListaFaturaContrato.Add(aFatTemp);
  aFatTemp.FEmFaturamentoMensal := True;
  Result := aFatTemp;


end;

function TFaturamentoMensalContrato.fAddContrato(
  const strNroCtr: String): TFaturamentoContrato;
var
  intCnt: Integer;
begin
  If fVerificaContratoJaFoiAdicionado(strNroCtr) Then
  Begin
    Result := Nil;
    Exit;
  End;

  FObjContratoTmp := TContratoLocacaoEquipamentos.Create;
  FObjContratoTmp.fCarregarContrato(strNroCtr);

  If (Not fValidaTravasContrato(FObjContratoTmp.AutInc, False)) Then
  Begin
    Result := Nil;
    Exit;
  End;

  fAddContrato(FObjContratoTmp);
  intCnt := IIF(FListaFaturaContrato.Count > 0,  FListaFaturaContrato.Count-1, 0);
  FListaFaturaContrato[intCnt].pRecalcularFaturamentoMensal(FDataReferencia);
  FListaFaturaContrato[intCnt].FEmFaturamentoMensal := True;
  Result := FListaFaturaContrato[intCnt];

  FobjLock.fLock_Unlock(cst_TRAVA_FATMEN_LOCEQU + FObjContratoTmp.AutInc, True, False);
end;

function TFaturamentoMensalContrato.fAddDuplicataAgrup: TDupFaturamentoContrato;
var
  intCont: Integer;
begin
  FListaDuplicatasAgrup.add(TDupFaturamentoContrato.Create(nil));
  intCont := FListaDuplicatasAgrup.Count -1;
  Result  := FListaDuplicatasAgrup[intCont];
end;

function TFaturamentoMensalContrato.fCarregarContratos(const aNroContrato,
  aCodCli, aMesRef: String; const aDataReferencia: TDateTime): Boolean;
var
  qryConsulta : TUniQuery;
  strSQLSelect: String;
begin
  FDataReferencia := aDataReferencia;

  strSQLSelect := 'SELECT CONEQL.AUTOINCREM FROM CONEQL WHERE TRUE';
  strSQLSelect := strSQLSelect + ' AND EQL_CODEMP = :EQL_CODEMP';
  strSQLSelect := strSQLSelect + ' AND EQL_STATUS = "A" ';
  If Not fEmptyStr(aNroContrato) Then
  Begin
    strSQLSelect := strSQLSelect + ' AND EQL_NROCON = :EQL_NROCON ';
  End;
  If Not fEmptyStr(aCodCli) Then
  Begin
    strSQLSelect := strSQLSelect + ' AND EQL_CODCLI = :EQL_CODCLI ';
  End;

  If Not fEmptyDate(aMesRef) Then
  Begin
    strSQLSelect := strSQLSelect + ' AND EQL_DTAFIN >= :EQL_DTAINI AND EQL_DTAINI <= :EQL_DTAFIN ';
  End;

  strSQLSelect := strSQLSelect + ' ORDER BY AUTOINCREM ';

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(strSQLSelect);

    qryConsulta.ParamByName('EQL_CODEMP').AsString := VS_strCodEmp;
    If Not fEmptyStr(aNroContrato) Then
    Begin
      qryConsulta.ParamByName('EQL_NROCON').AsString := aNroContrato;
    End;

    If Not fEmptyStr(aCodCli) Then
    Begin
      qryConsulta.ParamByName('EQL_CODCLI').AsString := aCodCli;
    End;

    If Not fEmptyDate(aMesRef) Then
    Begin
      qryConsulta.ParamByName('EQL_DTAINI').AsDateTime := fRetornaPrimeiroDiaMes(aMesRef);
      qryConsulta.ParamByName('EQL_DTAFIN').AsDateTime := fRetornaUltimoDiaMes(aMesRef);
    End;

    qryConsulta.Open;
    qryConsulta.First;
    While Not qryConsulta.EOF Do
    Begin
      FObjContratoTmp := TContratoLocacaoEquipamentos.Create;
      FObjContratoTmp.fCarregarContrato(qryConsulta.FieldByName('AUTOINCREM').AsString);

      fAddContrato(FObjContratoTmp);
      Application.ProcessMessages;

      qryConsulta.Next;
    End;

    pCarregarFaturamento;
    pCalculaTotais;

  Finally
    Result := qryConsulta.RecordCount > 0;
    FreeAndNil(qryConsulta);
  End;
end;

function TFaturamentoMensalContrato.fDeletaDuplicatas: Boolean;
Var
  strSQL     : String;
  intContador: Integer;
  qryGenRec  : TUniQuery;
begin
  Try
    Result := True;

    qryGenRec := fCriaQuery(Nil);
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM CADREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'AUTOINCREM IN (';
      For intContador := 0 To Length(arrDupSel) -1 Do
        strSQL := strSQL + '"' + arrDupSel[intContador].strAutoIn + '"' +
                           IIF(intContador < Length(arrDupSel) - 1, ',', ')');

      qryGenRec.Close;
      qryGenRec.SQL.Clear;
      qryGenRec.SQL.Add(strSQL);
      qryGenRec.Open;

      While Not qryGenRec.Eof Do
      Begin
        Result := Result And fApagaDuplicataContasReceber(qryGenRec, 'fApagaDuplicataContasReceber','',False);

        qryGenRec.Next;
      End;

      qryGenRec.Close;

      If Not Result Then
        Raise Exception.Create('Erro ao apagar as duplicatas. Operação cancelada!');
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('Erro ao apagar as duplicatas. Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryGenRec);
  End;
end;

function TFaturamentoMensalContrato.fEmitirFaturasIndividuais(const blnImprimirBoleto: Boolean): Boolean;
var
  intCnt: Integer;
  blnEncerrarContrato: Boolean;
  blnSubstituirCondPgto: Boolean;
begin
  Try
    FblnImpBoletoFinalizacao := blnImprimirBoleto;
    FblnAgruparDuplicatas := False;
    blnSubstituirCondPgto := False;

    If Not fCfgSis('CPGCTR', VarBoolean) Then
    Begin
      If Not fInformarCondicaoPagamento Then
      Begin
        Result := False;
        Exit;
      End;

      blnSubstituirCondPgto := True;
    End;

    For intCnt := 0 to FListaFaturaContrato.Count-1 Do
    Begin
      FListaFaturaContrato[intCnt].FObjFatVenda.objFatVendaImp.blnImpBol := blnImprimirBoleto;
      FListaFaturaContrato[intCnt].FObjFatVenda.objFatVendaImp.blnPerguntaImpBol := False;
      blnEncerrarContrato := FListaFaturaContrato[intCnt].fVerificaPodeEncerrarContrato;
      FListaFaturaContrato[intCnt].blnEncerrarContrato := blnEncerrarContrato;
      If FListaFaturaContrato[intCnt].fValidaEncerramentoContrato Then
      Begin
        If blnSubstituirCondPgto Then
        Begin
          FListaFaturaContrato[intCnt].blnInformarFormaPgto  := False;
          FListaFaturaContrato[intCnt].ObjfatVenda.strConPag := FCndPag;
          FListaFaturaContrato[intCnt].ObjfatVenda.strCodCnd := FCodCnd;
          FListaFaturaContrato[intCnt].ObjfatVenda.strCodFpg := FForPag;
        End;

        If FListaFaturaContrato[intCnt].fEmitirFatura Then
        Begin
          FListaFaturaContrato[intCnt].fEncerrarContrato(blnEncerrarContrato);
        End
        Else
        Begin
          FMensagemRetorno := FListaFaturaContrato[intCnt].MensagemRetorno;
          Result := False;
          Exit;
        End;
      End
      Else
      Begin
        FMensagemRetorno := FListaFaturaContrato[intCnt].MensagemRetorno;
        Result := False;
        Exit;
      End;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFaturamentoMensalContrato.fEmitirFaturasIndividuais]');
    End;
  End;
end;

function TFaturamentoMensalContrato.fEmpVen(codVen:String): String;
var
  strSQL : String;
  qryConVen: TUniQuery;
Begin
  qryConVen := fCriaQuery;
  Try
    If (fCfgSis('AGRTPR', varInteger) = 4) Then
    begin
      strSQL := 'SELECT OPE_CODEMP FROM CADOPE WHERE OPE_CODOPE = ' + QuotedStr(codVen);

      qryConVen.Close;
      qryConVen.SQL.Text := strSQL;
      qryConVen.Open;
      Result := qryConVen.FieldByName('OPE_CODEMP').AsString;

    end else
    If (fCfgSis('AGRTPR', varInteger) = 3) Then
      Result := VS_strCodEmp
    Else If fCfgSis('AGRTPR', varInteger) = 1 Then
       Result := VS_strCodEmp;

  Finally
    FreeAndNil(qryConVen);
  End;
End;

procedure TFaturamentoMensalContrato.pMontaObservacao(dagAgrup: TDadosAgrup; strNumDup: String);
Begin
  If fEmptyStr(dagAgrup.strObsAg1) Then
  Begin
    dagAgrup.strObsAg1 := 'REF. DOC. ' + fRetiraZerosEsquerda(strNumDup);
  End
  Else If Length(dagAgrup.strObsAg1) < 98 Then
  Begin
    dagAgrup.strObsAg1 := Copy(dagAgrup.strObsAg1 + ' / ' + fRetiraZerosEsquerda(strNumDup), 1, 120);
  End
  Else If Length(dagAgrup.strObsAg2) < 112 Then
  Begin
    dagAgrup.strObsAg2 := Copy(dagAgrup.strObsAg2 + ' / ' + fRetiraZerosEsquerda(strNumDup), 1, 120);
  End
  Else If Length(dagAgrup.strObsAg3) < 112 Then
  Begin
    dagAgrup.strObsAg3 := Copy(dagAgrup.strObsAg3 + ' / ' + fRetiraZerosEsquerda(strNumDup), 1, 120);
  End;
End;

function TFaturamentoMensalContrato.fRefotnaPerDpo(const strCodCnd, strCodCli: String): Double;
Begin
  Result := 0;
  If fCfgSis('DESPON', varBoolean) Then
  Begin
    If fCfgSis('TDEPON') = '1' Then
    Begin
      Result := fCampoTabela('CND_PERDPO','CADCND',['CND_CODIGO'],[strCodCnd]);
    End
    Else If fCfgSis('TDEPON') = '2' Then
    Begin
      Result := fCampoTabela('CLI_PERDPO','CADCLI',['CLI_CODCLI'],[strCodCli]);
    End;
  End;
End;

function TFaturamentoMensalContrato.fRefotnaQtdDAV(const strCodCnd, strCodCli: String): Integer;
Begin
  Result := 0;
  If fCfgSis('DESPON', varBoolean) Then
  Begin
    If fCfgSis('TDEPON') = '1' Then
    Begin
      Result := fCampoTabela('CND_QTDDAV','CADCND',['CND_CODIGO'],[strCodCnd]);
    End
    Else If fCfgSis('TDEPON') = '2' Then
    Begin
      Result := fCampoTabela('CLI_QTDDAV','CADCLI',['CLI_CODCLI'],[strCodCli]);
    End;
  End;
End;

function TFaturamentoMensalContrato.fRetornaContratosRecebidos: String;
var
  intCnt,
  intCont: Integer;
  strNumDup: String;
begin
  Result := EmptyStr;
  For intCont := 0 To Length(arrDupSel) - 1 Do
  Begin
    strNumDup := arrDupSel[intCont].strNumDup;
    If Not fEmptyStr(strNumDup) Then
    Begin
      For intCnt := 0 to FListaFaturaContrato.Count-1 Do
      Begin
        If FListaFaturaContrato[intCnt].NumDoc = strNumDup Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ',';

          Result := Result + FListaFaturaContrato[intCnt].FContrato.NroContrato;
        End;
      End;
    End;
  End;
end;

function TFaturamentoMensalContrato.fRetornaContratosRecebidos(
  const strNumDup: String): String;
var
  intCnt: Integer;
begin
  Result := EmptyStr;
  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    If FListaFaturaContrato[intCnt].NumDoc = strNumDup Then
    Begin
      If Not fEmptyStr(Result) Then
        Result := Result + ',';

      Result := Result + FListaFaturaContrato[intCnt].FContrato.NroContrato;
    End;
  End;
end;

function TFaturamentoMensalContrato.fRetornaDuplicatasAgrupamento(
  const strListaAgrp: String): String;
var
  strNumDupTmp, strNumDupAgr: String;
begin
  Result := EmptyStr;

  strNumDupAgr := strListaAgrp;
  repeat
    strNumDupTmp := Copy(strNumDupAgr, 0, pos(',', strNumDupAgr)-1);
    strNumDupTmp := IIF( Not fEmptyStr(strNumDupTmp), strNumDupTmp, strNumDupAgr);
    strNumDupAgr := Copy(strNumDupAgr, pos(strNumDupTmp,strNumDupAgr) + Length(strNumDupTmp) + 1, Length(strNumDupAgr)) ;

    Result := IIF(Not fEmptyStr(Result), ',', '') + Result;
    Result := QuotedStr(strNumDupTmp) + Result;
  until (Length(strNumDupAgr) = 0);
end;

function TFaturamentoMensalContrato.fRetornaQuantidadeParcelas(intQtdParc: Integer): Integer;
var
  intCnt: Integer;
Begin
  Result := intQtdParc;
  If intQtdParc <= 0 Then
  Begin
    For intCnt := Low(arrDuplicAgr) To High(arrDuplicAgr) Do
    Begin
       If Not fEmptyStr(arrDuplicAgr[intCnt].strSequen) Then
         Inc(Result);
    End;
  End;
End;

procedure TFaturamentoMensalContrato.pAjustarGravacaoPortador(qryCtrRec: TUniQuery; strNumAgr, strEspAgr, strEmpDuplic: String);
var
  intContador: Integer;
Begin
  If Length(arrDuplicAgr) > 1 Then
  begin
    For intContador := 0 To Length(arrDuplicAgr) -1 Do
    begin
      If fEmptyStr(arrDuplicAgr[intContador].strSequen) Then
        Break;

      TGravaAlteracaoDePortador.SalvarManualmente(qryCtrRec.FieldByName('CTR_CODPOR').AsString,
                                                  FCodPor,
                                                  strNumAgr,
                                                  arrDuplicAgr[intContador].strSequen,
                                                  'AG',
                                                  strEmpDuplic,
                                                  qryCtrRec.FieldByName('CTR_CODCLI').AsString,
                                                  '0');
    end;
  end
  else
  begin

    qryCtrRec.First;
    While Not qryCtrRec.Eof Do
    Begin
      TGravaAlteracaoDePortador.SalvarManualmente(qryCtrRec.FieldByName('CTR_CODPOR').AsString,
                                                  FCodPor,
                                                  qryCtrRec.FieldByName('NRODUP').AsString,
                                                  qryCtrRec.FieldByName('PARDUP').AsString,
                                                  qryCtrRec.FieldByName('CTR_ESPDOC').AsString,
                                                  qryCtrRec.FieldByName('CTR_CODEMP').AsString,
                                                  qryCtrRec.FieldByName('CTR_CODCLI').AsString,
                                                  qryCtrRec.FieldByName('CTR_SEQBAI').AsString);
      qryCtrRec.Next;
    end;
  end;
End;

function TFaturamentoMensalContrato.fCalcularJurRep(const fltTotJur, fltVlrCor, fltTotCli :Double): Double;
Begin
  Result := fFormataFloat((fltVlrCor / fltTotCli) * fltTotJur, 2);
End;

function TFaturamentoMensalContrato.fCalcularValCor(const fltJurRep, fltTotAgr, fltValCor :Double): Double;
Begin
  Result := fltValCor + fltJurRep;
  Result := Result / fltTotAgr;
End;

function TFaturamentoMensalContrato.fCalcularDifJuros(const fltTotCalc, fltTotJur, fltJurRep :Double): Double;
var
  fltVlrDif: Double;
Begin
  Result := fltJurRep;
  fltVlrDif := 0;

  If Not (fltTotCalc > 0) Then
    Exit;

  If fFormataFloat(fltTotCalc, 2) <> fFormataFloat(fltTotJur, 2) Then
  Begin
    If fFormataFloat(fltTotCalc, 2) > fFormataFloat(fltTotJur, 2) Then
    Begin
      fltVlrDif := fltTotCalc - fltTotJur;
      fltVlrDif := fltJurRep - fltVlrDif;
    End
    Else
    Begin
      fltVlrDif := fltTotJur - fltTotCalc;
      fltVlrDif := fltJurRep + fltVlrDif;
    End;
  End;

  Result := fltVlrDif;
End;

function TFaturamentoMensalContrato.fInserirAgrupamento(const strNumAgr, strEmpDuplic, strConPag: String; fltTotAgr, fltTotCli: Double;
  blnDescontoAteVencimento: Boolean; qryCtrRec: TUniQuery): Boolean;
Var
  fltValCom: Double;
  fltValCom2: Double;
  fltValCor: Double;
  fltValDes: Double;
  fltTotJur: Double;
  fltJurRep: Double;
  fltJurTmp: Double;
begin
  fltJurTmp := 0;
  fltTotJur := fltTotAgr - fltTotCli;

  Result := False;
  qryCtrRec.First;
  While Not qryCtrRec.Eof Do
  Begin
    fltValCom  := qryCtrRec.FieldByName('CTR_VALCOM').AsFloat;
    fltValCom2 := fltValCom/fltTotAgr;
    fltJurRep := fCalcularJurRep(fltTotJur, qryCtrRec.FieldByName('CTR_VALCOR').AsFloat, fltTotCli);
    fltValCor := fCalcularValCor(fltJurRep, fltTotAgr, qryCtrRec.FieldByName('CTR_VALCOR').AsFloat);

    fltJurTmp := fltJurTmp + fltJurRep;
    If qryCtrRec.Eof Then
    Begin
      fltJurRep := fCalcularDifJuros(fltJurTmp, fltTotJur, fltJurRep);
    End;

    If blnDescontoAteVencimento Then
    Begin
      fltValDes :=  IIF(qryCtrRec.FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date, qryCtrRec.FieldByName('CTR_DESSUJ').AsFloat, 0);
    End
    Else
      fltValDes := qryCtrRec.FieldByName('CTR_DESSUJ').AsFloat;

    Result :=  fGravaDupAgr(strNumAgr,
                            qryCtrRec.FieldByName('CTR_NUMDUP').AsString,
                            qryCtrRec.FieldbyName('CTR_PARCEL').AsString,
                            qryCtrRec.FieldByName('CTR_SEQBAI').AsInteger,
                            qryCtrRec.FieldByName('CTR_ESPDOC').AsString,
                            qryCtrRec.FieldByName('CTR_CODCLI').AsString,
                            qryCtrRec.FieldByName('CTR_CODEMP').AsString,
                            qryCtrRec.FieldByName('CTR_CODPOR').AsString,
                            qryCtrRec.FieldByName('CTR_CODVEN').AsString,
                            strLoginUsuarioLogado,
                            qryCtrRec.FieldByName('CTR_DTACAD').AsDateTime,
                            qryCtrRec.FieldByName('CTR_DTAVEN').AsDateTime,

                            qryCtrRec.FieldByName('CTR_VALDUP').AsFloat - qryCtrRec.FieldByName('CTR_JURSUJ').AsFloat - qryCtrRec.FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                            qryCtrRec.FieldByName('CTR_VALORI').AsFloat,

                            qryCtrRec.FieldByName('CTR_DESCOB').AsFloat,
                            qryCtrRec.FieldByName('CTR_DESCON').AsString,
                            qryCtrRec.FieldByName('CTR_HIST01').AsString,
                            qryCtrRec.FieldByName('CTR_HIST02').AsString,
                            qryCtrRec.FieldByName('CTR_ADTCLI').AsString,
                            qryCtrRec.FieldByName('CTR_CODEVE').AsString,
                            qryCtrRec.FieldByName('CTR_CODVEL').AsString,
                            qryCtrRec.FieldByName('CTR_TIPFOR').AsString,
                            qryCtrRec.FieldByName('CTR_CODCND').AsString,
                            IIF(qryCtrRec.FieldByName('CTR_CONAPR').AsInteger = 1, True, False),
                            strEmpDuplic,
                            qryCtrRec.FieldByName('CTR_CODCTA').AsString,
                            qryCtrRec.FieldByName('CTR_EMP_PD').AsString,
                            qryCtrRec.FieldByName('CTR_SEQCON').AsInteger,
                            qryCtrRec.FieldByName('CTR_DIFORI').AsFloat,
                            qryCtrRec.FieldByName('CTR_VALANT').AsFloat,
                            qryCtrRec.FieldByName('CTR_GRVORI').AsFloat,
                            qryCtrRec.FieldByName('CTR_CTASER').AsString,
                            qryCtrRec.FieldByName('CTR_SERVAL').AsFloat,
                            fltValCom,
                            fltValCom2,
                            fltValCor,
                            qryCtrRec.FieldByName('CTR_VALDES').AsFloat,
                            qryCtrRec.FieldByName('CTR_JURATR').AsFloat + fltJurRep,
                            strConPag,
                            qryCtrRec.FieldByName('CTR_CODREP').AsString,
                            qryCtrRec.FieldByName('CTR_COMREP').AsFloat,
                            qryCtrRec.FieldByName('CTR_COMREP').AsFloat/fltTotAgr,
                            qryCtrRec.FieldByName('CTR_VALIPI').AsFloat,
                            qryCtrRec.FieldByName('CTR_VALRET').AsFloat,
                            qryCtrRec.FieldByName('CTR_DESSUJ').AsFloat,
                            qryCtrRec.FieldByName('CTR_JURSUJ').AsFloat,
                            qryCtrRec.FieldByName('CTR_BARCON').AsString,
                            qryCtrRec.FieldByName('CTR_PERDPO').AsFloat,
                            qryCtrRec.FieldByName('CTR_QTDDAV').AsInteger,
                            qryCtrRec.FieldByName('CTR_VALACE').AsFloat,
                            qryCtrRec.FieldByName('CTR_VALFRE').AsFloat,
                            0,
                            qryCtrRec.FieldByName('CTR_DOCDIV').AsString,
                            qryCtrRec.FieldByName('CTR_ESPDIV').AsString,
                            qryCtrRec.FieldByName('CTR_EMPDIV').AsString,
                            qryCtrRec.FieldByName('CTR_CLIDIV').AsString,
                            qryCtrRec.FieldByName('CTR_COMDIV').AsFloat,
                            qryCtrRec.FieldByName('CTR_FATDIV').AsFloat,
                            qryCtrRec.FieldByName('CTR_CODDIV').AsString,
                            0,
                            '',
                            '',
                            '',
                            qryCtrRec.FieldByName('CTR_VALCBS').AsFloat,
                            qryCtrRec.FieldByName('CTR_VALIBS').AsFloat,
                            qryCtrRec.FieldByName('CTR_VAL_IS').AsFloat);

    If Not Result Then
    Begin
      Exit;
    End;

    qryCtrRec.Next;
    Application.ProcessMessages;
  End;
end;

function TFaturamentoMensalContrato.fGravaAgrupamentos(qryCtrRec: TUniQuery; strCodCli,
  strCodEmp: String; dtaDtaAgr: TDateTime; strConPag: String; fltTotAgr,
  fldTotCli, fldTotIPI, fldTotRet, fldTotAce, fldTotFre: Double;
  strContratos: String): Boolean;
Var
  intContador: Integer;
  intTamAnt: Integer;
  blnConfirma: Boolean;
  dagAgrup: TDadosAgrup;
  strEmpDuplic: String;
  strCodCliAG: String;
  strDupAgr: String;
  strCodigoBarrasContrato: String;
  fltPerDPo    : Double;
  intQtdDAV    : Integer;
  strHistorico : String;
  intQtdParcel : Integer;
  strNumAgr: String;
  blnUsaTelaCnd: Boolean;
  ItemDuplicata: TDupFaturamentoContrato;
  strEspAgr: String;
  intCont: Integer;
  blnDescontoAteVencimento: Boolean;   
begin
  strEspAgr := 'AG';
  dtaDtaAgr := VS_Date;
  blnUsaTelaCnd := False;
  strNumAgr   := fSeqAgrupamentoCtr;
  intQtdParcel := 0;
  blnDescontoAteVencimento := True;
  Result := False;

  Try
    qryCtrRec.DisableControls;
    qryCtrRec.First;
    While Not qryCtrRec.Eof Do
    Begin
      pMontaObservacao(dagAgrup, qryCtrRec.FieldByName('CTR_NUMDUP').AsString);

      intTamAnt := Length(arrDupSel);
      SetLength(arrDupSel, intTamAnt+1);
      arrDupSel[intTamAnt].strNumDup := qryCtrRec.FieldByName('CTR_NUMDUP').AsString;
      arrDupSel[intTamAnt].strParcel := qryCtrRec.FieldByName('CTR_PARCEL').AsString;
      arrDupSel[intTamAnt].strEspDoc := qryCtrRec.FieldByName('CTR_ESPDOC').AsString;
      arrDupSel[intTamAnt].strCodEmp := qryCtrRec.FieldByName('CTR_CODEMP').AsString;
      arrDupSel[intTamAnt].strCodCli := qryCtrRec.FieldByName('CTR_CODCLI').AsString;
      arrDupSel[intTamAnt].strAutoIn := qryCtrRec.FieldByName('AUTOINCREM').AsString;

      strDupAgr := IIF(qryCtrRec.RecNo = 1, qryCtrRec.FieldByName('CTR_NUMDUP').AsString, strDupAgr + '/' + qryCtrRec.FieldByName('CTR_NUMDUP').AsString);

      Application.ProcessMessages;
      qryCtrRec.Next;
    End;

    blnConfirma := True;

    SetLength(arrDupDocs, 24);
    For intContador := 0 To Length(FObjFatVenda.arrDuplicata) -1 Do
    Begin
      arrDupDocs[intContador].intNumDup := FObjFatVenda.arrDuplicata[intContador].intNumDup;
      arrDupDocs[intContador].strSequen := FObjFatVenda.arrDuplicata[intContador].strSequen;
      arrDupDocs[intContador].curValor  := FObjFatVenda.arrDuplicata[intContador].curValor;
      arrDupDocs[intContador].dtaDtaVen := FObjFatVenda.arrDuplicata[intContador].dtaDtaVen;
      arrDupDocs[intContador].strUsaChq := FObjFatVenda.arrDuplicata[intContador].strUsaChq;
      arrDupDocs[intContador].strHist02 := FObjFatVenda.arrDuplicata[intContador].strHist02;
    End;

    For intContador := 0 To Length(arrDuplicAgr) -1 Do
    Begin
      If fEmptyStr(arrDuplicAgr[intContador].strSequen) Then
        Break;

      intQtdParcel := fRetornaQuantidadeParcelas(intQtdParcel);

      strHistorico := 'REF. AGRUPAMENTO Nro. ' + strNumAgr+ ' - PARC. ' + IntToStr(intContador+1) + ' / ' +
                      IntToStr(intQtdParcel) + ' - DOC(S): ' + strDupAgr;

      strEmpDuplic := fEmpVen(FCodVen);
      strCodCliAG  := qryCtrRec.FieldByName('CTR_CODCLI').AsString;
      intQtdDAV := fRefotnaQtdDAV(FCodCnd,qryCtrRec.FieldByName('CTR_CODCLI').AsString);
      fltPerDPo := fRefotnaPerDpo(FCodCnd,qryCtrRec.FieldByName('CTR_CODCLI').AsString);

      blnConfirma := fGravaCadRec('frmFaturaMensalLocEqu',
                                  'INCLUSÃO',
                                  strNumAgr,
                                  arrDuplicAgr[intContador].strSequen,
                                  0,
                                  strEspAgr,
                                  qryCtrRec.FieldByName('CTR_CODCLI').AsString,
                                  strEmpDuplic,
                                  FCodVen,
                                  qryCtrRec.FieldByName('CTR_CODDIG').AsString,
                                  FCodPor,
                                  dtaDtaAgr,
                                  StrToDate(arrDuplicAgr[intContador].dtaDtaVen),
                                  arrDuplicAgr[intContador].curValor,
                                  arrDuplicAgr[intContador].curValor,
                                  0,
                                  'N',
                                  strHistorico,
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  0.0,
                                  0,
                                  qryCtrRec.FieldByName('CTR_ADTCLI').AsString,
                                  qryCtrRec.FieldByName('CTR_CODEVE').AsString,
                                  qryCtrRec.FieldByName('CTR_CODVEL').AsString,
                                  '',
                                  IIF(blnUsaTelaCnd, FCodCnd, qryCtrRec.FieldByName('CTR_CODCND').AsString),
                                  False,
                                  qryCtrRec.FieldByName('CTR_CODCTA').AsString,
                                  0,
                                  arrDuplicAgr[intContador].curValor,
                                  dagAgrup.strObsAg1,
                                  dagAgrup.strObsAg2,
                                  dagAgrup.strObsAg3,
                                  qryCtrRec.FieldByName('CTR_CTASER').AsString,
                                  qryCtrRec.FieldByName('CTR_SERVAL').AsFloat,
                                  0,  //intResCai
                                  0,  //fltVlrCom
                                  0,  //fltFatCom
                                  '', //strEmpBai
                                  '', // Empresa de Origem
                                  '', //strDocDiv
                                  '', //strEspDiv
                                  '', //strEmpDiv
                                  '', //strCliDiv
                                  0,  //fltVlrRep
                                  0,  //fltFatRep
                                  qryCtrRec.FieldByName('CTR_CODREP').AsString,
                                  iif(Assigned(arrDuplicIPI),arrDuplicIPI[intContador].curValor,0),
                                  arrDuplicRet[intContador].curValor,
                                  'N',
                                  0,
                                  arrDuplicAgr[intContador].curJuros,// CTR_JURSUR
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  strCodigoBarrasContrato,
                                  fltPerDPo, //fltPerDpo
                                  intQtdDAV,
                                  0,
                                  '',
                                  arrDuplicAce[intContador].curValor,
                                  arrDuplicFre[intContador].curValor,
                                  0,
                                  0,
                                  0,
                                  0,
                                  '',
                                  0,
                                  'INCLUSÃO',
                                  '',
                                  '',
                                  '',
                                  'N',
                                  'N',
                                  '',
                                  '',
                                  '',
                                  '',
                                  0,
                                  0,
                                  '',
                                  arrDuplicCbs[intContador].curValor,
                                  arrDuplicIbs[intContador].curValor,
                                  arrDuplicIs[intContador].curValor);

      If Not blnConfirma Then
      Begin
        Result := False;
        Exit;
      End;
    End;

    pAjustarGravacaoPortador(qryCtrRec, FCodPor, strEspAgr, strEmpDuplic);

    If fDeletaDuplicatas Then
    Begin
      If Not fInserirAgrupamento(strNumAgr, strEmpDuplic, strConPag, fltTotAgr, fldTotCli, blnDescontoAteVencimento, qryCtrRec) Then
      Begin
        Result := False;
        Exit;
      End;

      If (not fValidaValorAgrupamento(strNumAgr, strCodCli, strEmpDuplic, blnDescontoAteVencimento)) Then
      Begin
        fMensagem('ATENÇÃO!','Não foi possível gravar o agrupamento: ' +#13+ 'Nº: ' + strNumAgr + ' Cliente: ' + strCodCli +' - '+ Copy(fRetNomCliente(strCodCli), 1, 50) + #13+#13+
                             'O valor agrupado não corresponde ao valor da duplicata, tente novamente, se o problema persistir entre em contato com a Citel!', ['&O k']);
        Result := False;
        Exit
      End;

      SetLength(arrDupAgr, Length(arrDupAgr) + 1);
      arrDupAgr[Length(arrDupAgr)-1].strNumAgr := strNumAgr;
      arrDupAgr[Length(arrDupAgr)-1].strEmpAgr := strEmpDuplic;
      arrDupAgr[Length(arrDupAgr)-1].strCodCli := strCodCliAG;

      strDupAgr := '';
      For intCont := 0 To Length(arrDupAgr) - 1 Do
        strDupAgr := strDupAgr + arrDupAgr[intCont].strNumAgr + ', ';

      strDupAgr := Copy(strDupAgr, 1, Length(strDupAgr)-2);

      pGeraLogLiberacao(strNumAgr, strEspAgr, VS_strCodEmp);

      ItemDuplicata := fAddDuplicataAgrup;
      ItemDuplicata.AutInc := fRetAutIncAgrp(strEmpDuplic, strNumAgr, strNumAgr, strCodCli);
      ItemDuplicata.NumDup := strNumAgr;
      ItemDuplicata.EmpDoc := strEmpDuplic;
      ItemDuplicata.EspDoc := strEspAgr;
      ItemDuplicata.Parcela := 'A';
      ItemDuplicata.CodCliente := strCodCli;
      ItemDuplicata.ValorDuplicata :=  fltTotAgr;
      ItemDuplicata.strListaDuplicatasOrig := strDupAgr;
      ItemDuplicata.DocContrato := fRetornaContratosRecebidos;

      Result := blnConfirma;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFaturamentoMensalContrato - fGravaAgrupamentos]');
    End;
  End;
end;

function TFaturamentoMensalContrato.fValidaPodeEmitirFaturas: Boolean;
var
  intCnt: Integer;
begin
  Result := True;
  For intCnt:= 0 To FListaFaturaContrato.Count -1 Do
  Begin
    If Not FListaFaturaContrato[intCnt].fValidarPodeEmitirFatura Then
    Begin
      Result := False;
      FMensagemRetorno := FListaFaturaContrato[intCnt].MensagemRetorno;
      Break;
    End;
  End;
end;

function TFaturamentoMensalContrato.fValidaValorAgrupamento(strNumAgr, strCodCli,
  strEmpAgr: String; blnDescontoAteVencimento: Boolean): Boolean;
var
  qryValores: TUniQuery;
  fltValDupAgr,
  fltValCadRec: Double;
begin
  fltValDupAgr := 0;
  fltValCadRec := 0;

  qryValores := fCriaQuery();
  Try
    qryValores.sql.Clear;
    qryValores.sql.Text := ' SELECT ' +
                           '   SUM(CTR_VALDUP +             ' +
                           '       IFNULL(CTR_JURSUJ, 0) +  ' +
                           '       IFNULL(CTR_DESCOB, 0) -  ' +
                           IIF(blnDescontoAteVencimento,
                           '       IF(CTR_DTAVEN >= CURRENT_DATE, IFNULL(CTR_DESSUJ, 0), 0) + ',
                           '       IFNULL(CTR_DESSUJ, 0) + ') +
                           '       CTR_VALJUR-CTR_VALDES) AS VALAGR ' +
                           ' FROM ' +
                           '   DUPAGR ' +
                           ' WHERE ' +
                           '   CTR_NUMAGR = :NUMAGR AND ' +
                           '   CTR_CODCLI = :CODCLI AND ' +
                           '   CTR_EMPAGR = :CODEMP '      +
                           ' GROUP BY CTR_NUMAGR, CTR_CODCLI, CTR_EMPAGR ';
    qryValores.ParamByName('NUMAGR').AsString := strNumAgr;
    qryValores.ParamByName('CODCLI').AsString := strCodCli;
    qryValores.ParamByName('CODEMP').AsString := strEmpAgr;
    qryValores.Open;
    If Not qryValores.IsEmpty Then
      fltValDupAgr := qryValores.FieldByName('VALAGR').AsFloat;

    qryValores.Close;
    qryValores.sql.Clear;
    qryValores.sql.Text := ' SELECT ' +
                           '   SUM(CTR_VALDUP) AS VALAGR ' +
                           ' FROM ' +
                           '   CADREC ' +
                           ' WHERE ' +
                           '   CTR_NUMDUP = :NUMAGR AND ' +
                           '   CTR_CODCLI = :CODCLI AND ' +
                           '   CTR_CODEMP = :CODEMP AND ' +
                           '   CTR_ESPDOC = "AG" ' +
                           ' GROUP BY CTR_NUMDUP, CTR_CODCLI, CTR_CODEMP ';
    qryValores.ParamByName('NUMAGR').AsString := strNumAgr;
    qryValores.ParamByName('CODCLI').AsString := strCodCli;
    qryValores.ParamByName('CODEMP').AsString := strEmpAgr;
    qryValores.Open;

    If Not qryValores.IsEmpty Then
      fltValCadRec := qryValores.FieldByName('VALAGR').AsFloat;

    qryValores.Close;
  Finally
    FreeAndNil(qryValores);
  End;

  Result := (fFormataFloat(fltValCadRec, 2) = fFormataFloat(fltValDupAgr, 2));
End;

function TFaturamentoMensalContrato.fInformarCondicaoPagamento: Boolean;
Var
  frmDigCndPagamento : TfrmDigCndPagamento;
Begin
  pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
  Try
    frmDigCndPagamento.fraDigCndPagamento.strCodCli := EmptyStr;
    frmDigCndPagamento.fraDigCndPagamento.strNomCli := EmptyStr;
    frmDigCndPagamento.fraDigCndPagamento.fatVenda  := FObjfatVenda;

    frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := EmptyStr;
    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := EmptyStr;
    frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text := EmptyStr;
    frmDigCndPagamento.fraDigCndPagamento.edtDesForPag.Text := EmptyStr;

    frmDigCndPagamento.ShowModal;
    FCodCnd := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
    FCndPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
    FForPag := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;

    Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;
  Finally
    pFreeAndNil(frmDigCndPagamento);
  End;
End;

function TFaturamentoMensalContrato.fInformarPortadorParaAgrupamento(const qtdAgrp: Integer; qry: TUniQuery): Boolean;
var
  frmDigPortador: TfrmDigPortador;
  blnConfirma: Boolean;
  strEmpSemAcesso: String;
begin
  If qtdAgrp <= 0 Then
  Begin
    Result := False;
    Exit;
  End;

  blnConfirma := False;
  pCriarFormularios(TfrmDigPortador, frmDigPortador);
  Try
    Try
      frmDigPortador.bolMostraVendedor := (fCfgSis('OPAGCR', varInteger) = 2);
      frmDigPortador.blnValidarPDD := False;
      If Not fEmptyStr(FCodPor) Then
      Begin
        frmDigPortador.edtPorBai.Text    := FCodPor;
        frmDigPortador.edtCodPorBai.Text := '';
      End;

      frmDigPortador.ShowModal;
      blnConfirma := frmDigPortador.blnConfirma;

      If blnConfirma Then
      Begin
        If Not fEmpresasTemAcessoPortador(frmDigPortador.strCodPor,
                                          qry,
                                          'CTR_CODEMP',
                                          strEmpSemAcesso,
                                          EmptyStr) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
          Result := False;
          Exit;
        End;

        FCodPor := frmDigPortador.strCodPor;
        FCodVen := frmDigPortador.strCodVen;
      End;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message,'[TFaturamentoMensalContrato.fInformarPortadorParaAgrupamento]');
      End;
    End;
  Finally
    Result := blnConfirma;
    pFreeAndNil(frmDigPortador);
  End;
end;

function TFaturamentoMensalContrato.fEmitirContasReceberAgrupamento: Boolean;
begin
  Result := False;
end;

function TFaturamentoMensalContrato.fEmitirFaturas(const blnImprimirBoleto,
  blnAgruparDuplicatas: Boolean): Boolean;
begin
  fStartTransaction;
  Try
    FListaDuplicatasAgrup.Clear;

    If blnAgruparDuplicatas Then
      Result := fEmitirFaturasAgrupadas(blnImprimirBoleto)
    Else
      Result := fEmitirFaturasIndividuais(blnImprimirBoleto);

    If Result Then
    Begin
      fCommit;
      FobjLock.pDestravarTodos;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message,'[TFaturamentoMensalContrato.fInformarPortadorParaAgrupamento]');
    End;
  End;
end;

function TFaturamentoMensalContrato.fRetornaSQLDuplicatasAgrupadas(const strNumDup: String; blnDescontoAteVencimento: Boolean): String;
Begin
  Result := 'SELECT ';

  If blnDescontoAteVencimento Then
  Begin
    Result := Result + ' SUM( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IF(CADREC.CTR_DTAVEN >= CURRENT_DATE, IFNULL(CADREC.CTR_DESSUJ, 0), 0) ) AS CTR_VALDUP, ';
    Result := Result + ' SUM( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IF(CADREC.CTR_DTAVEN >= CURRENT_DATE, IFNULL(CADREC.CTR_DESSUJ, 0), 0) ) AS CTR_VALCOR, ';
  End
  Else
  Begin
    Result := Result + ' SUM( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IFNULL(CADREC.CTR_DESSUJ, 0) ) AS CTR_VALDUP, ';
    Result := Result + ' SUM( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IFNULL(CADREC.CTR_DESSUJ, 0) ) AS CTR_VALCOR, ';
  End;

  Result := Result + '       SUM(CTR_VALIPI) AS CTR_VALIPI, ' +
                     '       SUM(CTR_VALRET) AS CTR_VALRET, ' +
                     '       SUM(CTR_VALCBS) AS CTR_VALCBS, ' +
                     '       SUM(CTR_VALIBS) AS CTR_VALIBS, ' +
                     '       SUM(CTR_VAL_IS) AS CTR_VAL_IS, ' +
                     '       SUM(CTR_VALACE) AS CTR_VALACE, ' +
                     '       SUM(CTR_VALFRE) AS CTR_VALFRE, ' +
                     '       CTR_CODCLI,                    ' +
                     '       CTR_CODEMP,                    ' +
                     '       CTR_ESPDOC,                    ' +
                     '       CTR_DTAVEN,                    ' +
                     '       CTR_CODCND,                    ' +
                     '       GROUP_CONCAT('''', CTR_NUMDUP, '''') AS LISTA_DUPL, '+
                     '       GROUP_CONCAT('''', CTR_NUMDUP, '''') AS LST_DUP, '+
                     '       COUNT(CTR_NUMDUP)   AS QTDDUP  ' +
                     ' FROM CADREC                          ' +
                     ' WHERE CTR_ESPDOC = :CTR_ESPDOC       ' +
                     '       AND CTR_CODEMP = :CTR_CODEMP   ' +
                     '       AND CTR_NUMDUP IN ('+strNumDup+')' +
                     '       AND CTR_DTACAD = CURRENT_DATE  ' +
                     ' GROUP BY CTR_CODEMP, CTR_ESPDOC, CTR_CODCLI, CTR_CODCND, CTR_DTAVEN ' +
                     ' HAVING COUNT(CTR_NUMDUP) >  0        ' +
                     ' ORDER BY CTR_CODEMP, CTR_ESPDOC, CTR_CODCLI, CTR_CODCND, CTR_DTAVEN ' ;
End;

function TFaturamentoMensalContrato.fRetornaSQLDuplicatas(const strNumDup: String; blnDescontoAteVencimento: Boolean): String;
Begin
  Result := 'SELECT AUTOINCREM, ' +
            '       CTR_CODCLI, ' +
            '       CTR_CODEMP, ' +
            '       CTR_ESPDOC, ' +
            '       CTR_NUMDUP, ' +
            '       CTR_PARCEL, ' +
            '       CTR_SEQBAI, ' +
            '       CTR_ESPDOC, ' +
            '       CTR_CODCLI, ' +
            '       CTR_CODEMP, ' +
            '       CTR_CODPOR, ' +
            '       CTR_CODVEN, ' +
            '       CTR_DTACAD, ' +
            '       CTR_DTAVEN, ' +
            '       CTR_VALORI, ' +
            '       CTR_DESCOB, ' +
            '       CTR_DESCON, ' +
            '       CTR_HIST01, ' +
            '       CTR_HIST02, ' +
            '       CTR_ADTCLI, ' +
            '       CTR_CODEVE, ' +
            '       CTR_CODVEL, ' +
            '       CTR_TIPFOR, ' +
            '       CTR_CODCND, ' +
            '       CTR_CONAPR, ' +
            '       CTR_CODCTA, ' +
            '       CTR_EMP_PD, ' +
            '       CTR_SEQCON, ' +
            '       CTR_DIFORI, ' +
            '       CTR_VALANT, ' +
            '       CTR_GRVORI, ' +
            '       CTR_CTASER, ' +
            '       CTR_SERVAL, ' +
            '       CTR_VALDES, ' +
            '       CTR_CODREP, ' +
            '       CTR_COMREP, ' +
            '       CTR_COMREP, ' +
            '       CTR_VALIPI, ' +
            '       CTR_VALRET, ' +
            '       CTR_VALCBS, ' +
            '       CTR_VALIBS, ' +
            '       CTR_VAL_IS, ' +
            '       CTR_DESSUJ, ' +
            '       CTR_JURSUJ, ' +
            '       CTR_BARCON, ' +
            '       CTR_PERDPO, ' +
            '       CTR_QTDDAV, ' +
            '       CTR_VALACE, ' +
            '       CTR_VALFRE, ' +
            '       CTR_DOCDIV, ' +
            '       CTR_ESPDIV, ' +
            '       CTR_EMPDIV, ' +
            '       CTR_CLIDIV, ' +
            '       CTR_COMDIV, ' +
            '       CTR_FATDIV, ' +
            '       CTR_CODDIV, ' +
            '       CTR_CODDIG, ' +
            '       CTR_VALCOM, ' +
            ' 0 AS  CTR_JURATR, ';

  If blnDescontoAteVencimento Then
  Begin
    Result := Result + ' ( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IF(CADREC.CTR_DTAVEN >= CURRENT_DATE, IFNULL(CADREC.CTR_DESSUJ, 0), 0) ) AS CTR_VALDUP, ';
    Result := Result + ' ( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IF(CADREC.CTR_DTAVEN >= CURRENT_DATE, IFNULL(CADREC.CTR_DESSUJ, 0), 0) ) AS CTR_VALCOR  ';
  End
  Else
  Begin
    Result := Result + '  ( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IFNULL(CADREC.CTR_DESSUJ, 0) ) AS CTR_VALDUP, ';
    Result := Result + ' ( CADREC.CTR_VALDUP + IFNULL(CADREC.CTR_JURSUJ, 0) + IFNULL(CADREC.CTR_DESCOB, 0) - IFNULL(CADREC.CTR_DESSUJ, 0) ) AS CTR_VALCOR  ';
  End;

  Result := Result + '  FROM CADREC           ';
  Result := Result + '  WHERE TRUE            ';

  If (fCfgSis('AGRTPR', varInteger) = 3) Then
    Result := Result + '    AND CTR_CODEMP = :CTR_CODEMP ';

  Result := Result + '    AND CTR_ESPDOC = :CTR_ESPDOC ' +
                     '    AND CTR_CODCLI = :CTR_CODCLI ' +
                     '    AND CTR_CTABAI IS NULL       ' +
                     '    AND CTR_NUMDUP IN ('+strNumDup+')' +
                     '    AND CTR_DTACAD = CURRENT_DATE  ' +
                     '    AND CTR_DTAVEN = :CTR_DTAVEN   ';
End;

function TFaturamentoMensalContrato.fEmitirFaturasAgrupadas(
  const blnImprimirBoleto: Boolean): Boolean;
Var
  qryConsulta : TUniQuery;
  cdsTabCadRec: TUniClientDataSet;
  qryTabCadRec: TUniQuery;
  strEspDoc: String;
  strNumDup: String;
  fltTotCli: Double;
  cdsTmpCtr: TUniClientDataSet;
  intCnt: Integer;
  fltTotIPI: Double;
  fltTotCbs: Double;
  fltTotIbs: Double;
  fltTotIs: Double;
  fltTotRet: Double;
  fltTotAce: Double;
  fltTotFre: Double;
  fltTotCor: Double;
  fltTotalAgrup: Double;
  strCodCid: String;
  strSQLSelect: String;
  strSQLSelectDup: String;
  blnConfirma: Boolean;
  intDup: Integer;
  dtaDtaCad: TDateTime;
  fltTotAdt: Double;
  blnSabDomFeriadosComoDiaUtil: Boolean;
  blnMostrarTela: Boolean;
  blnDescontoAteVencimento: Boolean;
  ItemDuplicata: TDupFaturamentoContrato;
  strNumDupAgr: String;
  blnEmitidoApenasFatInd: Boolean;
begin
  blnConfirma := False;
  Result := False;
  SetLength(arrDupAgr, 0);
  strNumDup := EmptyStr;
  dtaDtaCad := Today;
  fltTotAdt := 0;

  If Not fEmitirFaturasIndividuais(False) Then
  Begin
    Result := False;
    Exit;
  End;

  FblnAgruparDuplicatas := True;
  blnMostrarTela := False;
  blnSabDomFeriadosComoDiaUtil := fCfgSis('FSDUDP', varBoolean);
  FblnImpBoletoFinalizacao := blnImprimirBoleto;
  blnDescontoAteVencimento := fCfgSis('UTDEFN') = '2';
  blnEmitidoApenasFatInd := True;

  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    strNumDup := strNumDup + IIF(Not fEmptyStr(strNumDup), ',', '');

    strNumDup := strNumDup + QuotedStr(FListaFaturaContrato[intCnt].NumDoc);
  End;

  strEspDoc := IIF(fCfgSis('LECRSN', varBoolean), 'RL', 'NS');

  strSQLSelect := fRetornaSQLDuplicatasAgrupadas(strNumDup, blnDescontoAteVencimento);

  qryConsulta := fCriaQuery;
  qryTabCadRec:= fCriaQuery;
  Try
    Try
      qryConsulta.DisableControls;
      qryConsulta.SQL.Add(strSQLSelect);
      qryConsulta.ParamByName('CTR_ESPDOC').AsString := strEspDoc;
      qryConsulta.ParamByName('CTR_CODEMP').AsString := VS_strCodEmp;
      qryConsulta.Open;

      While Not qryConsulta.EOF Do
      Begin
        strNumDupAgr := fRetornaDuplicatasAgrupamento(qryConsulta.FieldByName('LISTA_DUPL').AsString);

        strSQLSelectDup := fRetornaSQLDuplicatas(strNumDupAgr, blnDescontoAteVencimento);
        qryTabCadRec.DisableControls;
        qryTabCadRec.SQL.Clear;
        qryTabCadRec.SQL.Add(strSQLSelectDup);

        qryTabCadRec.ParamByName('CTR_CODCLI').AsString := qryConsulta.FieldByName('CTR_CODCLI').AsString;
        If qryTabCadRec.Params.FindParam('CTR_CODEMP') <> Nil  Then
          qryTabCadRec.ParamByName('CTR_CODEMP').AsString := qryConsulta.FieldByName('CTR_CODEMP').AsString;
        qryTabCadRec.ParamByName('CTR_ESPDOC').AsString := qryConsulta.FieldByName('CTR_ESPDOC').AsString;
        qryTabCadRec.ParamByName('CTR_DTAVEN').AsDateTime := qryConsulta.FieldByName('CTR_DTAVEN').AsDateTime;
        qryTabCadRec.Open;

        If qryConsulta.FieldByName('QTDDUP').AsInteger = 1 Then
        Begin
          ItemDuplicata := fAddDuplicataAgrup;
          ItemDuplicata.AutInc := qryTabCadRec.FieldByName('AUTOINCREM').AsString;
          ItemDuplicata.NumDup := qryTabCadRec.FieldByName('CTR_NUMDUP').AsString;
          ItemDuplicata.EmpDoc := qryTabCadRec.FieldByName('CTR_CODEMP').AsString;
          ItemDuplicata.EspDoc := qryTabCadRec.FieldByName('CTR_ESPDOC').AsString;
          ItemDuplicata.Parcela := qryTabCadRec.FieldByName('CTR_PARCEL').AsString;
          ItemDuplicata.CodCliente := qryTabCadRec.FieldByName('CTR_CODCLI').AsString;
          ItemDuplicata.DocContrato := fRetornaContratosRecebidos(qryTabCadRec.FieldByName('CTR_NUMDUP').AsString);
          ItemDuplicata.ValorDuplicata := qryTabCadRec.FieldByName('CTR_VALDUP').AsFloat;
          ItemDuplicata.strListaDuplicatasOrig := qryTabCadRec.FieldByName('CTR_NUMDUP').AsString;

          qryConsulta.Next;
          Continue;
        End
        Else
          blnEmitidoApenasFatInd := False;

        fltTotCli := qryConsulta.FieldByName('CTR_VALDUP').AsFloat;
        fltTotIPI := qryConsulta.FieldByName('CTR_VALIPI').AsFloat;
        fltTotRet := qryConsulta.FieldByName('CTR_VALRET').AsFloat;
        fltTotAce := qryConsulta.FieldByName('CTR_VALACE').AsFloat;
        fltTotFre := qryConsulta.FieldByName('CTR_VALFRE').AsFloat;
        fltTotCbs := qryConsulta.FieldByName('CTR_VALCBS').AsFloat;
        fltTotIbs := qryConsulta.FieldByName('CTR_VALIBS').AsFloat;
        fltTotIs  := qryConsulta.FieldByName('CTR_VAL_IS').AsFloat;
        fltTotCor := qryConsulta.FieldByName('CTR_VALCOR').AsFloat;

        FCndPag := IIF(fCfgSis('CPGCTR', VarBoolean), fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [qryConsulta.FieldByName('CTR_CODCND').AsString]), FCndPag);

        fltTotalAgrup := fAplicaTaxaJurosAgrupamento(FCodCnd,
                                                     FCndPag,
                                                     fltTotCli,
                                                     fltTotCor,
                                                     fltTotCli);

        strCodCid := fRetCidCliente(qryConsulta.FieldByName('CTR_CODCLI').AsString);

        fDigDuplic(FObjfatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(FCndPag), 0, fltTotalAgrup, blnMostrarTela,
                   True, False, VS_Date, True, 0, 'N', True, False, 0, False,
                   Nil, '', blnSabDomFeriadosComoDiaUtil, True, Nil, '',
                   False, True, '', '', Nil, False, True, Nil, False, False, 0, 'frmFaturaMensalLocEqu',
                   strCodCid);

        blnConfirma := FObjFatVenda.arrDuplicata[0].strSequen <> '';
        SetLength(arrDuplicAgr, Length(FObjFatVenda.arrDuplicata));

        If blnConfirma Then
        Begin

          For intDup := 0 To Length(FObjFatVenda.arrDuplicata) -1 Do
          Begin
            arrDuplicAgr[intDup] := FObjFatVenda.arrDuplicata[intDup];
          End;

          fDigDuplicVar(FCndPag, 0, fltTotIPI, False, False, False, VS_Date, False, arrDuplicIPI, 0, 'N', False);
          fDigDuplicVar(FCndPag, 0, fltTotRet, False, False, False, VS_Date, False, arrDuplicRet, 0, 'N', False);
          fDigDuplicVar(FCndPag, 0, fltTotAce, False, False, False, VS_Date, False, arrDuplicAce, 0, 'N', False);
          fDigDuplicVar(FCndPag, 0, fltTotFre, False, False, False, VS_Date, False, arrDuplicFre, 0, 'N', False);
          fDigDuplicVar(FCndPag, 0, fltTotCbs, False, False, False, VS_Date, False, arrDuplicCbs, 0, 'N', False);
          fDigDuplicVar(FCndPag, 0, fltTotIbs, False, False, False, VS_Date, False, arrDuplicIbs, 0, 'N', False);
          fDigDuplicVar(FCndPag, 0, fltTotIs,  False, False, False, VS_Date, False, arrDuplicIs,  0, 'N', False);

          If Not fInformarPortadorParaAgrupamento(qryConsulta.RecordCount, qryTabCadRec) Then
          Begin
            Result := False;
            Exit;
          End;

          fltTotalAgrup  := fltTotalAgrup - fltTotAdt;
          Result := (fGravaAgrupamentos(qryTabCadRec,
                     qryConsulta.FieldByName('CTR_CODCLI').AsString,
                     qryConsulta.FieldByName('CTR_CODEMP').AsString,
                     dtaDtaCad, FCndPag, fltTotalAgrup, fltTotCli, fltTotIPI,
                     fltTotRet, fltTotAce, fltTotFre, EmptyStr));

          If Not Result Then
            Exit;
        End;            

        qryConsulta.Next;
      End;  

      pImprimirBoletoAgrupamento;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalContratoLocacao.fEmiteNotaSimplesRemessa]');
        blnConfirma := False;
      End;
    End;
  Finally
    Result := IIF(blnEmitidoApenasFatInd, True, ((blnConfirma) and (Result)) );
    FreeAndNil(qryConsulta);
    FreeAndNil(cdsTabCadRec);
    FreeAndNil(cdsTmpCtr);
  End;
end;

function TFaturamentoMensalContrato.fCalculaTaxVpr(strConPag: String; fltTxJCnd: Double): Double;
begin
  Result := 0.0;
  If fltTxJCnd > 0 Then
     Result := fFormataFloat((fltTxJCnd / 30) * fCalcMediaPagto(strConPag), 2)

  Else If fCalcMediaPagto(strConPag) > fCfgSis('DIATAX', varInteger) Then
  Begin
    If fCfgSis('TAXAPL') = 'I' Then
      Result := fFormataFloat((fCfgSis('TAXJUR', varDouble) / 30) * fCalcMediaPagto(strConPag) ,2)
    Else
      Result := fFormataFloat((fCfgSis('TAXJUR', varDouble) / 30) * (fCalcMediaPagto(strConPag) - fCfgSis('DIATAX', varInteger)), 2);
  End;
end;

function TFaturamentoMensalContrato.fAplicaTaxaJurosAgrupamento(strCodCnd, strConPag: String; fltTotCli, fltValor, fltTotAgr: Double): Double;
var
  fltTxJCnd: Double;
  fltTaxVpr: Double;
  fltValJur: Double;
begin
  Result := fltTotCli;

  If (fltTotCli <= 0) Then
    Exit;

  If Not fCfgSis('SISCRE', varBoolean) Then
    Exit;

  fltTxJCnd := fCampoTabela('CND_TXJURO', 'CADCND', ['CND_CODIGO'], [strCodCnd]);

  fltTaxVpr := fCalculaTaxVpr(strConPag, fltTxJCnd);

  fltValJur := fFormataFloat(fltTotAgr * ( fltTaxVpr / 100 ), 2);

  Result := fltTotCli + fltValJur;
end;

function TFaturamentoMensalContrato.fRemoveContrato(
  const aAutInc: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    If FListaFaturaContrato[intCnt].FContrato.AutInc = aAutInc Then
    Begin
      FobjLock.fLock_Unlock(cst_TRAVA_FATMEN_LOCEQU + FListaFaturaContrato[intCnt].FContrato.AutInc, False, False);
      FListaFaturaContrato.Delete(intCnt);
      Result := True;

      Break;
    End;
  End;
end;

function TFaturamentoMensalContrato.fRetAutIncAgrp(const strCodEmp,
  strNumAgrp, strEspDoc, strCodCli: String): String;
Var
  strSQL     : String;
  qryConsulta  : TUniQuery;
begin
  Result := EmptyStr;

  qryConsulta := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM FROM CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_CODEMP = :CTR_CODEMP';
    strSQL := strSQL + '  AND CTR_NUMDUP = :CTR_NUMDUP';
    strSQL := strSQL + '  AND CTR_ESPDOC = :CTR_ESPDOC';
    strSQL := strSQL + '  AND CTR_CODCLI = :CTR_CODCLI';

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(strSQL);
    qryConsulta.ParamByName('CTR_CODEMP').AsString := strCodEmp;
    qryConsulta.ParamByName('CTR_NUMDUP').AsString := strNumAgrp;
    qryConsulta.ParamByName('CTR_CODCLI').AsString := strCodCli;
    qryConsulta.ParamByName('CTR_ESPDOC').AsString := strEspDoc;
    qryConsulta.Open;

    If Not qryConsulta.IsEmpty Then
    Begin
      Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
    End;

  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TFaturamentoMensalContrato.fVerificaContratoJaFoiAdicionado(
  const strNroCtr: String): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    If FListaFaturaContrato[intCnt].FContrato.AutInc = strNroCtr Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TFaturamentoMensalContrato.GetAgrDup: Boolean;
begin
  Result := FblnAgruparDuplicatas;
end;

function TFaturamentoMensalContrato.GetBlnBol: Boolean;
begin
  Result := FblnBoletoImpresso;
end;

function TFaturamentoMensalContrato.GetDtaRef: TDateTime;
begin
  Result := FDataReferencia;
end;

function TFaturamentoMensalContrato.GetImpBol: Boolean;
begin
  Result := FblnImpBoletoFinalizacao;
end;

function TFaturamentoMensalContrato.GetLDup: TList<TDupFaturamentoContrato>;
begin
  Result := FListaDuplicatasAgrup;
end;

function TFaturamentoMensalContrato.GetLstFat: TList<TFaturamentoContrato>;
begin
  Result := FListaFaturaContrato;
end;

function TFaturamentoMensalContrato.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TFaturamentoMensalContrato.GetValCtr: TValidarContrato;
begin
  Result := FobjValidaCtr;
end;

function TFaturamentoMensalContrato.GetVlrRec: Double;
begin
  Result := FVlrTotRec;
end;

procedure TFaturamentoMensalContrato.pCalculaTotais;
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    FListaFaturaContrato[intCnt].pCalcularTotais;
  End;
end;

procedure TFaturamentoMensalContrato.pCarregarFaturamento;
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    FListaFaturaContrato[intCnt].pRecalcularFaturamentoMensal(FDataReferencia);
  End;
end;

procedure TFaturamentoMensalContrato.pDestravar;
begin
  FobjLock.pDestravarTodos;
end;

procedure TFaturamentoMensalContrato.pImprimirBoletoAgrupamento;
var
  arrDupCtr: TArrDupCtr;
  intCnt: Integer;
begin
  If Not FblnImpBoletoFinalizacao Then
    Exit;

  SetLength(arrDupCtr,0);

  For intCnt := 0 To FListaDuplicatasAgrup.Count -1 Do
  Begin
    SetLength(arrDupCtr,Length(arrDupCtr)+1);
    arrDupCtr[Length(arrDupCtr)-1].strNumDup := FListaDuplicatasAgrup[intCnt].NumDup;
    arrDupCtr[Length(arrDupCtr)-1].strEspDoc := FListaDuplicatasAgrup[intCnt].EspDoc;
    arrDupCtr[Length(arrDupCtr)-1].strCodEmp := FListaDuplicatasAgrup[intCnt].EmpDoc;
    arrDupCtr[Length(arrDupCtr)-1].strCodCli := FListaDuplicatasAgrup[intCnt].CodCliente;
    arrDupCtr[Length(arrDupCtr)-1].strParcel := FListaDuplicatasAgrup[intCnt].Parcela;
    arrDupCtr[Length(arrDupCtr)-1].strAutoIn := FListaDuplicatasAgrup[intCnt].AutInc;
  End;

  If Length(arrDupCtr) > 0 Then
    FblnBoletoImpresso := TBoleto.fImprimirBoletos(arrDupCtr, True, False, 'Deseja imprimir boletos?', 'TFaturamentoMensalContrato');

end;

procedure TFaturamentoMensalContrato.pLimpar;
var
  intCnt: Integer;
begin
  For intCnt := 0 to FListaFaturaContrato.Count-1 Do
  Begin
    FobjLock.fLock_Unlock(cst_TRAVA_FATMEN_LOCEQU + FListaFaturaContrato[intCnt].FContrato.AutInc, False, False);
  End;
  FblnImpBoletoFinalizacao := False;
  FblnAgruparDuplicatas := False;
  FListaFaturaContrato.Clear;
  FDataReferencia := 0;
  FObjContratoTmp.pLimpar;
  FListaDuplicatasAgrup.Clear;
end;

procedure TFaturamentoMensalContrato.SetAgrDup(const AValue: Boolean);
begin
  FblnAgruparDuplicatas := AValue;
end;

procedure TFaturamentoMensalContrato.SetDtaRef(const AValue: TDateTime);
begin
  FDataReferencia := AValue;
end;

procedure TFaturamentoMensalContrato.SetImpBol(const AValue: Boolean);
begin
  FblnImpBoletoFinalizacao := AValue;
end;

procedure TFaturamentoMensalContrato.SetLstFat(
  const AValue: TList<TFaturamentoContrato>);
begin
  FListaFaturaContrato := AValue;
end;

procedure TFaturamentoMensalContrato.SetVlrRec(const AValue: Double);
begin
  FVlrTotRec := AValue;
end;

{ TDupFaturamentoContrato }

constructor TDupFaturamentoContrato.Create(Owner: TFaturamentoContrato);
begin
  FFatura := Owner;
  If Assigned(FFatura) Then
  Begin
    FCodCli := FFatura.FContrato.CodCliente;
    FNomCli := FFatura.FContrato.NomCliente;
    FDocCon := FFatura.FContrato.NroContrato;
  End;
end;

destructor TDupFaturamentoContrato.Destroy;
begin

  inherited;
end;

function TDupFaturamentoContrato.GerVlrRec: Double;
begin
  Result := FVlrRec;
end;

function TDupFaturamentoContrato.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TDupFaturamentoContrato.GetBlnBol: Boolean;
begin
  Result := FblnBoletoImpresso;
end;

function TDupFaturamentoContrato.GetCodCli: String;
begin
  Result := FCodCli;
end;

function TDupFaturamentoContrato.GetDocCon: String;
begin
  Result := FDocCon;
end;

function TDupFaturamentoContrato.GetDtaEmi: TDateTime;
begin
  Result := FDtaEmi;
end;

function TDupFaturamentoContrato.GetDtaRec: TDateTime;
begin
  Result := FDtaRec;
end;

function TDupFaturamentoContrato.GetDtaVen: TDateTime;
begin
  Result := FDtaVen;
end;

function TDupFaturamentoContrato.GetDupOri: String;
begin
  Result := FDupOri;
end;

function TDupFaturamentoContrato.GetEmpDoc: String;
begin
  Result := FEmpDoc;
end;

function TDupFaturamentoContrato.GetEspDoc: String;
begin
  Result := FEspDoc;
end;

function TDupFaturamentoContrato.GetGerBol: Boolean;
begin
  Result := FGerBol;
end;

function TDupFaturamentoContrato.GetNomCli: String;
begin
  If fEmptyStr(FNomCli) Then
  Begin
    If Not fEmptyStr(FCodCli) Then
      FNomCli := fRetNomCliente(FCodCli);
  End;

  Result := FNomCli;
end;

function TDupFaturamentoContrato.GetNumDup: String;
begin
  Result := FNumDup;
end;

function TDupFaturamentoContrato.GetParcel: String;
begin
  Result := FParcel;
end;

function TDupFaturamentoContrato.GetVlrDup: Double;
begin
  Result := FVlrDup;
end;

procedure TDupFaturamentoContrato.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TDupFaturamentoContrato.SetBlnBol(const AValue: Boolean);
begin
  FblnBoletoImpresso := AValue;
end;

procedure TDupFaturamentoContrato.SetCodCli(const AValue: String);
begin
  FCodCli := AValue;
end;

procedure TDupFaturamentoContrato.SetDocCon(const AValue: String);
begin
  FDocCon := AValue;
end;

procedure TDupFaturamentoContrato.SetDtaEmi(const AValue: TDateTime);
begin
  FDtaEmi := AValue;
end;

procedure TDupFaturamentoContrato.SetDtaRec(const AValue: TDateTime);
begin
  FDtaRec := AValue;
end;

procedure TDupFaturamentoContrato.SetDtaVen(const AValue: TDateTime);
begin
  FDtaVen := AValue;
end;

procedure TDupFaturamentoContrato.SetDupOri(const AValue: String);
begin
  FDupOri := AValue;
end;

procedure TDupFaturamentoContrato.SetEmpDoc(const AValue: String);
begin
  FEmpDoc := AValue;
end;

procedure TDupFaturamentoContrato.SetEspDoc(const AValue: String);
begin
  FEspDoc := AValue;
end;

procedure TDupFaturamentoContrato.SetGerBol(const AValue: Boolean);
begin
  FGerBol := AValue;
end;

procedure TDupFaturamentoContrato.SetNomCli(const AValue: String);
begin
  FNomCli := AValue;
end;

procedure TDupFaturamentoContrato.SetNumDup(const AValue: String);
begin
  FNumDup := AValue;
end;

procedure TDupFaturamentoContrato.SetParcel(const AValue: String);
begin
  FParcel := AValue;
end;

procedure TDupFaturamentoContrato.SetVlrRec(const AValue: Double);
begin
  FVlrRec := AValue;
end;

procedure TDupFaturamentoContrato.SetVlrDup(const AValue: Double);
begin
  FVlrDup := AValue;
end;

{ TImpressaoFatLocacao }

constructor TImpressaoFatLocacao.Create(const strNomForm: String);
begin
  FListaFaturaContrato := TList<TFaturamentoContrato>.Create;
  FObjContratoTmp := TContratoLocacaoEquipamentos.Create;
  FfrxContratoLocacao := TfrxReport.Create(Nil);
  FfrxPDFContratoLocacao :=  TfrxPDFExport.Create(Nil);

  pLimpar;
  FstrNomForm := strNomForm;
  FstrPathImp := ExtractFilePath(Application.ExeName) + 'Faturas_LocacaoEquipamento\';

  If Not DirectoryExists(FstrPathImp) Then
    fCriaDiretorio(FstrPathImp);
end;

destructor TImpressaoFatLocacao.Destroy;
begin
  FreeAndNil(FListaFaturaContrato);
  FreeAndNil(FObjContratoTmp);
  FreeAndNil(FfrxContratoLocacao);
  FreeAndNil(FfrxPDFContratoLocacao);

  inherited;
end;

function TImpressaoFatLocacao.fAddFatura(
  objContrato: TContratoLocacaoEquipamentos;
  strEspDoc, strEmpDoc, strNumDoc: String): Boolean;
var
  aFatTemp: TFaturamentoContrato;
begin

  If fEmptyStr(strNumDoc) Then
  Begin
    FMensagemRetorno := 'Selecione documento para impressão!';
    Exit(False);
  End;

  aFatTemp := TFaturamentoContrato.Create(objContrato);
  FListaFaturaContrato.Add(aFatTemp);

  aFatTemp.pLimpar;
  aFatTemp.Contrato.pCarregarDadosCliente;
  aFatTemp.Contrato.pCarregarDadosEmitente;
  aFatTemp.Contrato.pCarregarItensContrato;
  aFatTemp.pCarregarDetalhamentoFaturamento(strEspDoc, strEmpDoc, strNumDoc);
  aFatTemp.pCarregarDuplicatas;

  Result := True;
end;

function TImpressaoFatLocacao.fImprmirReciboFat(tpaTipArq: TTipoArquivo): Boolean;
begin
  If Not fVerificaPodeImprimirFatura Then
  Begin
    Exit(False);
  End;

  If (Not fEmptyStr(FstrLayPadrao)) or (Not fEmptyStr(FstrLayRL)) Then
  Begin
    Result := fImprimirReciboPadraoFaturas(tpaTipArq)
  End
  Else
  Begin
    Result := fImprimirReciboFr3Faturas(tpaTipArq);
  End;
end;

function TImpressaoFatLocacao.fImprimirReciboFr3Faturas(const tpaTipArq: TTipoArquivo): Boolean;
var
  intCnt: Integer;
  strDescri: String;
  intCont: Integer;
  strDeclara: String;
  fltVltTotDup: Double;
  strDtaVen: String;
  strVlrDup: String;
  intContador: Integer;
begin
  Result := False;

  Try
    FfrxContratoLocacao.LoadFromFile(FstrPathRel);
    fCarregaImagemEmpresa(VS_strCodEmp, TfrxPictureView(FfrxContratoLocacao.FindObject('imgLogo')).Picture);

    For intContador:=0 To FListaFaturaContrato.Count -1 Do
    Begin
      {Emitente}
      FfrxContratoLocacao.Script.Variables['EMP_NOMEMP'] := FListaFaturaContrato[intContador].Contrato.Emitente.Nome;
      FfrxContratoLocacao.Script.Variables['EMP_ENDERE'] := FListaFaturaContrato[intContador].Contrato.Emitente.Endereco + ', ' +
                                                            FListaFaturaContrato[intContador].Contrato.Emitente.NumEnd + ' - ' +
                                                            FListaFaturaContrato[intContador].Contrato.Emitente.Bairro + #13 +
                                                            FListaFaturaContrato[intContador].Contrato.Emitente.Cep + ' - ' +
                                                            FListaFaturaContrato[intContador].Contrato.Emitente.NomCidade + ' - ' +
                                                            FListaFaturaContrato[intContador].Contrato.Emitente.Estado;
      FfrxContratoLocacao.Script.Variables['EMP_C_G_C_'] := fFormataCpfCgc(FListaFaturaContrato[intContador].Contrato.Emitente.Cnpj, opcBrasil) ;
      FfrxContratoLocacao.Script.Variables['EMP_FONE01'] := fFormataFonePais(FListaFaturaContrato[intContador].Contrato.Emitente.Fone01);
      {Cliente}
      FfrxContratoLocacao.Script.Variables['NOMDES'] := FListaFaturaContrato[intContador].Contrato.Cliente.NomeCliente;
      FfrxContratoLocacao.Script.Variables['ENDDES'] := FListaFaturaContrato[intContador].Contrato.Cliente.Endereco;
      FfrxContratoLocacao.Script.Variables['BAIDES'] := FListaFaturaContrato[intContador].Contrato.Cliente.Bairro;
      FfrxContratoLocacao.Script.Variables['CIDDES'] := FListaFaturaContrato[intContador].Contrato.Cliente.NomCid;
      FfrxContratoLocacao.Script.Variables['CEPDES'] := FListaFaturaContrato[intContador].Contrato.Cliente.Cep;
      FfrxContratoLocacao.Script.Variables['CGCDES'] := fFormataCpfCgc(FListaFaturaContrato[intContador].Contrato.Cliente.CpfCnpj, opcBrasil);
      FfrxContratoLocacao.Script.Variables['IE_DES'] := fCampoTabela('CLI_I_E_S_','CADCLI', ['CLI_CODCLI'], [FListaFaturaContrato[intContador].Contrato.Cliente.Codigo], False);
      {Fatura}
      FfrxContratoLocacao.Script.Variables['NUMFAT'] := FListaFaturaContrato[intContador].NumDoc;

      fltVltTotDup := 0;
      strDtaVen := EmptyStr;
      strVlrDup := EmptyStr;;
      For intCont := 0 To FListaFaturaContrato[intContador].ListaItens.Count -1 Do
      Begin
        strDescri := strDescri + FListaFaturaContrato[intContador].ListaItens[intCont].itemContrato.Equipamento.Codigo     + ' - ' +
                                 FListaFaturaContrato[intContador].ListaItens[intCont].itemContrato.Equipamento.Descricao  + ' - ' +
                                 FListaFaturaContrato[intContador].ListaItens[intCont].itemContrato.Equipamento.NumSerie   + ' - ' +
                                 'Contrato: ' + FListaFaturaContrato[intContador].Contrato.NroContrato  + ' / ' +
                                 'Período: ' + DateTimeTostr(FListaFaturaContrato[intContador].ListaItens[intCont].dtaIniCobFat) + ' à ' +
                                               DateTimeTostr(FListaFaturaContrato[intContador].ListaItens[intCont].dtaFinCobFat) + ' / ' +
                                 'Valor: R$ ' + FormatFloat('#,##0.00', FListaFaturaContrato[intContador].ListaItens[intCont].ValorFaturamento) + #13;
        fltVltTotDup := fltVltTotDup + FListaFaturaContrato[intContador].ListaItens[intCont].ValorFaturamento;

        FfrxContratoLocacao.Script.Variables['DSCSER'] := strDescri;
      End;

      For intCnt := 0 To FListaFaturaContrato[intContador].Duplicatas.Count-1 Do
      Begin
        FfrxContratoLocacao.Script.Variables['DTAEMI'] := FListaFaturaContrato[intContador].Duplicatas[intCnt].DataEmissao;

        strDtaVen := strDtaVen + DateTimeToStr(FListaFaturaContrato[intContador].Duplicatas[intCnt].DataVencimento) + #13;
        strVlrDup := strVlrDup + 'R$ ' + FormatFloat('#,##0.00', FListaFaturaContrato[intContador].Duplicatas[intCnt].ValorDuplicata)+ #13;
      End;

      FfrxContratoLocacao.Script.Variables['DTAVEN'] := strDtaVen;
      FfrxContratoLocacao.Script.Variables['VALOR_'] := strVlrDup;
      FfrxContratoLocacao.Script.Variables['VLRTOT'] := FormatFloat('#,##0.00', fltVltTotDup);
      FfrxContratoLocacao.Script.Variables['VLREXT'] := FGet_Extens(FormatFloat('#,##0.00', fltVltTotDup));

      strDeclara := FListaFaturaContrato[intContador].strObservacao;
      If (tpaTipArq <> tpaPDF) Then
      Begin
        strDeclara := TfrmObservacao.fObservacao('Texto para Declaração', strDeclara, 500, tpiInputQuery, 0, True);
        FListaFaturaContrato[intContador].strObservacao := strDeclara;
      End;
      FfrxContratoLocacao.Script.Variables['OBS'] := strDeclara;

      If (tpaTipArq = tpaPDF) Then
      Begin
        FfrxContratoLocacao.PrepareReport;
        FstrNomArq := IncludeTrailingPathDelimiter(FstrPathImp) + FListaFaturaContrato[intContador].EspDoc + '_' +
                      FListaFaturaContrato[intContador].NumDoc + '_' +
                      FListaFaturaContrato[intContador].EmpDoc + '.pdf';
        FfrxPDFContratoLocacao.FileName := FstrNomArq;
        FfrxPDFContratoLocacao.DefaultPath := FstrPathImp;
        FfrxPDFContratoLocacao.ShowDialog  := False;

        FfrxContratoLocacao.Export(FfrxPDFContratoLocacao);
        If FblnVisualizar Then
          pPreviewReport('', 'Impressão (Fatura Locação)', FfrxContratoLocacao);

        Result := True;
      End
      Else
      Begin

        FfrxContratoLocacao.PrintOptions.Printer    := FstrNomImp;
        FfrxContratoLocacao.PrintOptions.ShowDialog := False;
        FfrxContratoLocacao.PrintOptions.Copies := 1;

        If FfrxContratoLocacao.PrepareReport Then
        Begin
          If FblnVisualizar Then
            pPreviewReport('', 'Impressão (Fatura Locação)', FfrxContratoLocacao)
          Else
            pPrintReport('fImprimirReciboFatura', 'Impressão Recibo de Fatura de Locação', FstrNomImp, FfrxContratoLocacao);

          Result := True;
        End
        Else
        Begin
          FMensagemRetorno := 'Não foi possível realizar a impressão da fatura: ' + FListaFaturaContrato[intContador].NumDoc;
          Result := False;
          Break;
        End;
      End;

      If Result Then
      Begin
        FListaFaturaContrato[intContador].fAtualizaObservacaoImpressao;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      FMensagemRetorno := 'Não foi possível realizar a impressão da fatura: ' + E.Message;
      Result := False;
    End;
  End;
end;

function TImpressaoFatLocacao.fImprimirReciboPadraoFaturas(const tpaTipArq: TTipoArquivo): Boolean;
Var
  objImpressao: TEditorFastImpressao;
  intCnt: Integer;
begin
  Result := False;
  objImpressao := TEditorFastImpressao.Create(Nil);
  Try
    For intCnt := 0 To FListaFaturaContrato.Count-1 Do
    Begin
      If Not fEmptyStr(FstrLayRL) Then
      Begin
        FListaFaturaContrato[intCnt].Contrato.fCarregarContrato(FListaFaturaContrato[intCnt].Contrato.AutInc, '', True);

        objImpressao.recDocume.strCodEmp := FListaFaturaContrato[intCnt].EmpDoc;
        objImpressao.tpeTipoEtiqueta     := tpeRL;
        objImpressao.recDocume.strEspDoc := FListaFaturaContrato[intCnt].EspDoc;
        objImpressao.recDocume.strNumDoc := FListaFaturaContrato[intCnt].NumDoc;
        objImpressao.recDocume.strCodCli := FListaFaturaContrato[intCnt].Contrato.Cliente.Codigo;
        objImpressao.recDocume.strTipFc  := 'C';
        objImpressao.recDocume.blnReimpr := True;
        If  (tpaTipArq  = tpaNormal) Then
          objImpressao.recDocume.strSaida :=  'V';
      End
      Else
      Begin
        objImpressao.recDocume.strEspSel := 'LE';
        objImpressao.recDocume.strNroCon := FListaFaturaContrato[intCnt].Contrato.NroContrato;
        objImpressao.recDocume.strCodEmp := VS_strCodEmp;
        objImpressao.tpeTipoEtiqueta     := tpeLocacaoEquipamento;
        objImpressao.recDocume.strEspDoc := 'LE';
      End;

      If (tpaTipArq  = tpaPDF) Then
      Begin
        objImpressao.recDocume.blnVisPdf := False;
        objImpressao.recDocume.blnGerPdf := True;
        objImpressao.recDocume.blnNaoSelImp := (tpaTipArq  = tpaPDF);
        Result := objImpressao.fImprimeDocumento(tpaTipArq, FstrPathImp, objImpressao.recDocume.strEspDoc + '_' +
                                                                         objImpressao.recDocume.strNumDoc + '_' +
                                                                         objImpressao.recDocume.strCodEmp );
        FstrNomArq := objImpressao.strArqPDF;
      End
      Else
        Result := objImpressao.fImprimeDocumento();
    End;
  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TImpressaoFatLocacao.fRemoverFatura(
  objContrato: TContratoLocacaoEquipamentos): Boolean;
var
  intCnt: Integer;
begin
  Result := False;
  For intCnt:=0 To FListaFaturaContrato.Count -1 Do
  Begin
    If FListaFaturaContrato[intCnt].Contrato.AutInc = objContrato.AutInc Then
    Begin
      FListaFaturaContrato.Delete(intCnt);
      Result := True;

      Break;
    End;
  End;
end;

function TImpressaoFatLocacao.fVerificaPodeImprimirFatura: Boolean;
var
  qryCfgRel: TUniQuery;
begin
  FstrPathEti := fCfgSis('PATETI', varString);
  FstrPathRel := FstrPathEti + '\ContratoLocacao.fr3';
  FstrLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],
                   [ARR_TIPO_LAYOUT[tpeLocacaoEquipamento], VS_strCodEmp, 'S']);

  If fCfgSis('LECRSN', VarBoolean) Then
    FstrLayRL := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],
                     [ARR_TIPO_LAYOUT[tpeRL], VS_strCodEmp, 'S'])
  Else
    FstrLayRL := EmptyStr;

  If Not(FileExists(FstrPathRel)) And (fEmptyStr(FstrLayPadrao)) And (fEmptyStr(FstrLayRL))  Then
  Begin
    FMensagemRetorno := 'Não há layout definido para impressão. Verifique!';
    Exit(False);
  End;

  qryCfgRel := fCriaQuery(Nil);
  Try
    pCarregaConfImpr(qryCfgRel, FstrNomForm, VS_strCodEmp);
    FstrNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  Finally
    FreeAndNil(qryCfgRel);
  End;

  If fEmptyStr(FstrNomImp) Then
  Begin
    FMensagemRetorno := 'Configure a impressora para realizar a impressão!';
    Exit(False);
  End;

  If FListaFaturaContrato.Count <= 0 Then
  Begin
    FMensagemRetorno := 'Não existem faturas carregadas!';
    Exit(False);
  End;

  Result := True;
end;

function TImpressaoFatLocacao.GetLstFat: TList<TFaturamentoContrato>;
begin
  Result := FListaFaturaContrato;
end;

function TImpressaoFatLocacao.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

function TImpressaoFatLocacao.GetNomArq: String;
begin
  Result := FstrNomArq;
end;

procedure TImpressaoFatLocacao.pLimpar;
begin
  FListaFaturaContrato.Clear;
  FMensagemRetorno := EmptyStr;
  FstrLayPadrao := EmptyStr;
  FstrPathEti := EmptyStr;
  FstrPathRel := EmptyStr;
  FstrNomImp  := EmptyStr;
  FblnVisualizar := False;
  FstrLayRL := EmptyStr;
end;

{ TGeraArquivoAnexoEmail }

constructor TGeraArquivoAnexoEmail.Create(strNomArq: String);
begin
  FstrNomArq := strNomArq;
end;

function TGeraArquivoAnexoEmail.fGeraArquivoAnexo(blnGerandoParaDisparoDeGatilho: Boolean): TList<TRecArquivosGatilhos>;
begin
  Result := TList<TRecArquivosGatilhos>.Create;
  Result.Add(TRecArquivosGatilhos.Create('FATURA CONTRATO_' + ExtractFileName(FstrNomArq).Replace(ExtractFileExt(ExtractFileName(FstrNomArq)), EmptyStr).Replace('_', '-'), FstrNomArq, EmptyStr));
end;

function TGeraArquivoAnexoEmail.fGetEnviaArquivoPdf: Boolean;
begin
  Result := FEnviaArquivoPdf;
end;

function TGeraArquivoAnexoEmail.fGetEnviaArquivoXml: Boolean;
begin
  Result := FEnviaArquivoXML;
end;

function TGeraArquivoAnexoEmail.GetAcesso: String;
begin
  Result := FAcesso;
end;

function TGeraArquivoAnexoEmail.GetSerie: String;
begin
  Result := FSerie_;
end;

function TGeraArquivoAnexoEmail.GetStatus: TStatusDisparaEmail;
begin
  Result := FStatus;
end;

procedure TGeraArquivoAnexoEmail.pSetEnviaArquivoPdf(const Value: Boolean);
begin
  FEnviaArquivoPdf := Value;
end;

procedure TGeraArquivoAnexoEmail.pSetEnviaArquivoXml(const Value: Boolean);
begin
  FEnviaArquivoXML := Value;
end;

procedure TGeraArquivoAnexoEmail.SetAcesso(const Value: String);
begin
  FAcesso := Value;
end;

procedure TGeraArquivoAnexoEmail.SetSerie(const Value: String);
begin
  FSerie_ := Value;
end;

procedure TGeraArquivoAnexoEmail.SetStatus(
  const Value: TStatusDisparaEmail);
begin
  FStatus := Value;
end;

class function TGeraArquivoAnexoEmail.fNew(strNomArq: String): IGeraArquivoAnexoEmailAutomatico;
begin
  Result := TGeraArquivoAnexoEmail.Create(strNomArq);
end;

end.
