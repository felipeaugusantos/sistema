unit Contabilidade.Classes.TGerLanCon;

interface

uses Uni, Classes, SysUtils, cxProgressBar, Data.DB, Contabilidade.Interfaces,
     UniClientDataSet, System.Generics.Collections,
     Contabilidade.Model.TDadosImportacaoContabil,
     Contabilidade.Classes.TGravacaoEmLote, Contabilidade.Classes.TAbreviacaoContabilRep,
     Contabilidade.Classes.TParametroContabil, Contabilidade.Model.Contabilizaveis, Contabilidade.Funcoes;

type
  TLanConControleDebitoCredito = class
  private
    FfltDebito: Double ;
    FfltCredito: Double ;
    (* Os campos abaixo trabalham em conjunto para controlar as contas de partida simples que possem
       a mesma conta nos lançamentos de crédito e débito. Não podem ser alterados de forma isolada, devem ser alterados em conjunto *)
    FlstCntDebito: TStringList ;
    FlstValCntDebito: TStringList ;
    FlstCntCredito: TStringList ;
    FlstValCntCredito: TStringList ;
    (* Fim do controle de campos em conjuno *)
    FobjDados: TDadosImportacaoContabil ;
  public
    constructor Create ;
    destructor Destroy ; override ;

    property Debito: Double read FfltDebito write FfltDebito ;
    property Credito: Double read FfltCredito write FfltCredito ;
    property CntDebito: TStringList read FlstCntDebito ;
    property ValCntDebito: TStringList read FlstValCntDebito ;
    property CntCredito: TStringList read FlstCntCredito ;
    property ValCntCredito: TStringList read FlstValCntCredito ;
    property Dados: TDadosImportacaoContabil read FobjDados write FobjDados ;
  end ;

  TLanConGenerico = Class(TComponent)
  private
    cdsParCon: TUniClientDataSet;
    cdsPlancoVigencia: TUniClientDataSet;
    FcdsPlancoInfo: TUniClientDataSet;
    qryParCon: TUniQuery;
    qryDados: TUniQuery;
    strTipLan : String;
    recParCon: TParametrosConsulta;
    // strTipLan e normalizado no meio da geracao (ENTADT vira ENT); a pendencia precisa da sigla gerada.
    FstrSiglaGeracao: String;
    FPreValidar: Boolean;
    FValida: IValidaContaContabil;
    FAbriuCds: Boolean;
    dicContaParametro : TDictionary<String,String>;
    FListaLanCon : TObjectList<TDadosImportacaoContabil>;
    FListaLanConDuplo : TObjectList<TDadosImportacaoContabil>;
    FListaSeqLot : TObjectList<TDadosSequencialDoLote>;
    FGravacaoEmLote: TGravacaoEmLote;
    FParametrizouCreditoNaFormaDePagto: boolean;
    FUsaCheckListComplemento : boolean;
    FConSeqParExiste : boolean;
    FLanConCCusCrExiste : boolean ;
    FAbrevConRep: TAbreviacaoContabilRep;
    FTamanhoDoLote : Integer;
    FContadorDeLancamentos : Integer;
    recParametrosGravaLanCon: TParametrosGravaLanCon;
    FParametrizouAdiantamentoCTR: boolean;
    FContaCtrLanctoDuplo : string;
    FDescCfgContaCtrLanctoDuplo: string;
    FContaCtrAdtLanctoDuplo : string;
    FstrContaEmprestimoAtivo : string;
    FDescCfgContaEmprestimoAtivo : string;
    FstrContaEmprestimoPassivo : string;
    FDescCfgContaEmprestimoPassivo : string;
    FValidarVigenciaCta : boolean;
    FlstIncDoc : TStringList ;
    cdsParConWarning: TUniClientDataSet;
    FcdsParConRef: TUniClientDataSet;
    FLstControleLancAgrupado : TStringList ;
    FLstControleImpAgr: TStringList;
    FLstDesvalCadastrado: TStringList ;
    FdictParcon: TObjectDictionary<string, TUniClientDataSet>;
    FdictDiferencaDebitoCredito: TObjectDictionary<string, TLanConControleDebitoCredito>;
    FblnLancarEmPreValidar: boolean ;
    FlstControleDiferencaDebitoCredito: TStringList ;
    FlstControlePesquisaContaContabil: TStringList ;
    FlstControleVigenciaContaContabil: TStringList ;
    FblnTemCentroCusto: Boolean ;
    FblnLigaPDD: Boolean ;
    FdictControlePortadores: TDictionary<String,String> ;
    FblnAgrupaSaiEnt: Boolean ;
    FblnTRDCZEExiste: Boolean ;
    FblnTRDCZE: Boolean ;
    FblnMktPla: Boolean ;
    FblnConGru: Boolean ;
    FblnNatDsc: Boolean ;
    FblnConEmp: Boolean ;
    FblnAdmCont: Boolean ;
    FblnCtrAgr: Boolean ;
    FblnFiltradoPelaEmpresaBaixa: Boolean ;
    FblnImpAGr: Boolean;
    FblnHisTpl: Boolean;
    FstrTplacoEmpLog: string;
    FdictPadDescri: TDictionary<string, string>;
    function fDescriHisPad(const AstrDescriFallback: string; const inHisCod: Integer; const AstrEmpLan: string): string;
    procedure pAddLstIncDoc(const strIncDoc: String) ;
    function fSetarConta(strPlaCta: String; strCodEmp: String; strDesVal, strClaFis: string; const AblnRefazerConsultaPorEmpresa: Boolean): TParametroContabil;
    procedure pRetornaDadosOrigem(const AOrigem: TOrigemPlanoContabil;
      const ADebitoCredito: TTipoPlanoContas; const ABaixaCadastro: String;
      out AtipoOrigem, ACodigoOrigem: string);
    function fRetSQLParametros: string;
    function GetErros: TUniClientDataSet;
    function GetWarnings: TUniClientDataSet;
    function fLocalizaParCon(dtaDataLan: TDate; strDesVal, strFormPagto, strPagame, strTipLan: string; var strMotivoWarning: string): boolean;
    function fExibirNoComplementoODocumentoOriginalDoAgrupamento(strTipoComplemento: string; FieldDocOri, FieldEspOri: TField): boolean;
    procedure pEfetuarGravacaoDoLote;
    procedure pFinalizacaoDoLote(DataSet: TDataSet);
    procedure pAdicionarErro(AMotivo, AOrigem, AHistorico, ATipLan, ADesVal, ANatOpe, AChave, ATabela: string; const AContabilizaveis: TContabilizaveis; const AWarning: Boolean = False; const AdtaLan: TDateTime = 0; const AstrCodEmpDoc: String = '');
    function fGetContaCtrLanctoDuplo: string;
    function fEfetuarLancamentoDuploEmpresasDiferentes: boolean;
    function fPopularListaDeLancamentos: boolean;
    function fTrataParametroPDD(const dtaDataLan: TDate; const strDesVal,strFormPagto,strPagame,strTipLan:string; var strMensagemValidacao:string):boolean ;
    function fLoopParametroPDD(const dtaDataLan: TDate; const strDesVal,strFormPagto,strPagame, strPDD:string):boolean ;
    function fGetContaCtrAdtLanctoDuplo: string;
    function fEfetuarLancamentoDuploEmpresasDiferentesAdt: boolean;
    procedure pLiberaPlancoVigencia;
    function fAjustaTipoLancamento(const ATipLan: string): string ;
    procedure pAtualizaContadorLancamentos(const AItem: TDadosImportacaoContabil) ;
    function fTrataCodigoEmpresa(const AqryDados: TUniQuery):string ;
    function fTrataNomeEmpresa(const AqryDados: TUniQuery):string ;
    function fDeletaLacamentosGeradosParaOutraEmpresa(const AstrTipo: string; const AblnTemControle: Boolean): boolean;
    procedure pConfiguraEmpresaLancamentoDuploEmpresasDiferentes(var AstrEmpCad, AstrEmpBai: string; const AstrFormPagto, AstrCodigoEmpDesmem: string) ;
    function fValidarHistorico(const AintHisPad: Integer; AstrComple: String): Boolean;
    function fFiltradoPelaEmpresaBaixa: Boolean ;
    function fAjustarFormaPagamentoCRC(const ACdsParcon: TUniClientDataSet): Boolean ;
    procedure pGeraDicionarioDebitoCredito(AobjDados: TDadosImportacaoContabil) ;
    procedure pValidaDiferencaDebitoCredito ;
    procedure pRetornaDadosIniciais(var AstrCodEmp: String; var AdtaIni, AdtaFin: TDateTime) ;
    function fGerarAgrupadoEmpresaOrigemCTR: Boolean ;
    function fTemErroModoRobo(AcdsErrors : TUniClientDataSet; const AstrAutoIncrem: String): Boolean ;
    function fDocumentoExcluido(const AstrIncDoc, AstrTabela: String): Boolean;
    procedure pAplicaFiltroDocumentoLanCon(AqryDel: TUniQuery);
    function fEhAdtTransformadoCC(const AstrFormPagto, AstrAdtTransformadoCC: String): Boolean ;
    function fEhCreditodeAdt(const AstrFormPagto, AstrAdtTransformadoCC: String): Boolean ;
    procedure pInverterPlanoContasCreditoDeAdt(const AstrPlanoContasCredito, AstrPlanoContasDebito: String; const AblnInverter: Boolean; var AstrPlanoContasCreditoInv, AstrPlanoContasDebitoInv: String) ;
    function fTrataPlanoContabilCadCtaPorEmpresa(const AstrPlanoContabil, AstrCodEmp: String; const AblnRefazerConsultaPorEmpresa: Boolean): String ;
    function fTrataPlanoContabilPortadorPorEmpresa(const AstrPlanoContabil, AstrCodEmp: String; const AblnRefazerConsultaPorEmpresa: Boolean): String ;
    function fTrataPlanoContabilClientePorEmpresa(const AstrPlanoContabil, AstrCodEmp: String; const AblnRefazerConsultaPorEmpresa: Boolean): String ;
    function fTrataPlanoContabilBandeiraPorEmpresa(const AstrPlanoContabil, AstrCodEmp: String; const AblnRefazerConsultaPorEmpresa: Boolean): String ;
    function fUsarDescricaoNatCfo(const AstrTipLan, AstrNatCfo: String): Boolean ;
    function fVerificaVigencia(const ACdsParcon: TUniClientDataSet; const ADataLancamento: TDate): Boolean;
    function fChaveParcon(const ACdsParcon: TUniClientDataSet): string;
    procedure pFiltraPelaNaturezaParcon(const AstrNatureza, AstrTipLan, AFiltroVigencia: String) ;
    procedure pAjustaPlanoContasPortadorRepasseCheque(const AparametroContabil : TParametroContabil; const ATipLan, ADesVal: String; var APlancoCredito, APlancoDebito: String) ;
  public
    FblnMostraWarningGeracaoMovimento: Boolean ;
    function fDeletaLotInc: boolean;
    procedure pAdicionarWarning(const AMotivo: String;
                                dstDados: TDataSet;
                                const AOrigem: String = '';
                                const AHistorico: String = '';
                                const ATipLan: String = '';
                                const ADesVal: String = '';
                                const ANatOpe: String = '';
                                const ATabela: String = '';
                                const AWarning: Boolean = True);
    procedure pBeforeScroll(DataSet: TDataSet);
    procedure pSetaComplemento(var strComplemento: String; strField: String; AcdsParCon: TUniClientDataSet);
    procedure pGravaLancto(strField, strDesVal: String; strPlaCta: String = ''; strFormPagto: String = ''; strCodEve: String = ''; strPagame: String = ''; strOrigem: String = ''; strNatCfo: String = ''; strNatOpe: String = ''; strCst: string = ''; strCodCta: string = '');
    procedure pInsertLanCon(dtaDtaLan: TDateTime;
                            strClaFis: String;
                            strNatOpe: String;
                            strDesVal: String;
                            strConCre: String;
                            strConDeb: String;
                            intHisPad: Integer;
                            strHistor: String;
                            fltValLan: Double;
                            strEmpLan: String;
                            strCodEveCre: String;
                            strCodEveDeb: String;
                            strIncDoc: string;
                            strTabela: string;
                            strFormPagto: string;
                            strPagamento: string;
                            const AblnParametrizouCredito: Boolean;
                            const AblnParametrizouDebito: Boolean;
                            const AstrOrigemCredito: String;
                            const AstrOrigemDebito: String;
                            const AblnIsCtpDet: Boolean;
                            const AstrCliFor: String;
                            const AstrTip_Fc: String;
                            const strEmpDesmem: string;
                            const AstrIncDocAg: String;
                            const AstrEspDoc: String;
                            const AstrParconFpg: string;
                            const AstrSeqPar: string;
                            const AstrInvNco: string;
                            const AstrTpOriD: string;
                            const AstrCdOriD: string;
                            const AstrOpBcDb: string;
                            const AstrTpOriC: string;
                            const AstrCdOriC: string;
                            const AstrOpBcCr: string;
                            const AstrNumDoc: string);
    function fCarregaParCon(dtaDataLan: TDate; strDesVal, strClaFis: String; strFormPagto: String = ''; strPagame: String = ''; strOrigem: String = ''; strNatCfo: string = ''; strNatOpe: String = ''; strCst: String = ''): Boolean;
    function fDeletaLanCon: Boolean;
    function fGeraDelLanconCRC(const AstrTipo: string): Boolean;
    function fEfetuaDelecaoLanCon: boolean;
    function fTemParametrosConfigurados: Boolean;
    function fGetCodCta(strNumDup, strCodEmp, strCodFor, strSerie: String; var strCodEve: String): String;
    function fContaParametro(strValor: String; strCreDeb: String; strCodEmp: String): String;
    procedure pVerificaSeLancouLanCon ;
    procedure pSetaParametrosGravacao(recParametrosGravaLanCon : TParametrosGravaLanCon);
    function fParametrizouAdiantamentoNoCtr: boolean;
    function fEfetuaLancamentosPreValidacao(const AobjLancon:ITipLanCon): boolean;
    procedure pGravarCheckList(const AstrTipLan: string);
    function fTemControleDelLanconOutrasEmpresas(const AstrTipo: string): Boolean ;
    constructor Create(qryDados: TUniQuery; strTipLan: String; recParCon: TParametrosConsulta); reintroduce;
    destructor Destroy; override;
    property listaErros: TUniClientDataSet read GetErros;
    property listaWarnings: TUniClientDataSet read GetWarnings;
    property blnPreValidar: Boolean read FPreValidar write FPreValidar;
    property LancarEmPreValidar: Boolean read FblnLancarEmPreValidar write FblnLancarEmPreValidar;
    property objValida : IValidaContaContabil read FValida write FValida;
    property blnParametrizouCreditoNaFormaDePagto : boolean read FParametrizouCreditoNaFormaDePagto;
    property blnParametrizouAdiantamentoCTR : boolean read FParametrizouAdiantamentoCTR;
    property strContaCtrLanctoDuplo: string read FContaCtrLanctoDuplo;
    property strContaCtrAdtLanctoDuplo: string read FContaCtrAdtLanctoDuplo;
    property strTipoLancamento: string read strTipLan ;
  End;

type
  TGerLanCon = Class(TComponent)
  private
    strTipLan: String;
    objTipLanCon : ITipLanCon;
    recParCon: TParametrosConsulta;
    blnPreValidar: Boolean;
    FblnLancarEmPreValidar: Boolean;
    procedure pValidaPeriodo;
  public
    constructor Create(AOwner: TComponent; strTipLan: String; recParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar; blnPreValidar: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); reintroduce;
    destructor Destroy; override;
    function fGerarLancamentos(): boolean;
    procedure pMensagemConclusao;
    function GetlistaErros: TUniClientDataSet;
  End;

implementation

{ TLanConGenerico }

uses Variants, Contabilidade.Classes.TLanConFactory, untFuncoesSimples,
     Contabilidade.Classes.TChaveDocInterprete,
     untFuncoesHash, StrUtils, Contabilidade.Classes.THistoricoLanCon,
     System.Hash, Contabilidade.Classes.CheckListImportacao,
     Contabilidade.Classes.TTrataIncDoc, Contabilidade.Classes.THashParCon;

{ TLanConControleDebitoCredito }

constructor TLanConControleDebitoCredito.Create;
begin
  inherited Create ;
  FlstCntDebito     := TStringList.Create ;
  FlstValCntDebito  := TStringList.Create ;
  FlstCntCredito    := TStringList.Create ;
  FlstValCntCredito := TStringList.Create ;
end;

destructor TLanConControleDebitoCredito.Destroy;
begin
  FreeAndNil(FlstCntDebito) ;
  FreeAndNil(FlstValCntDebito) ;
  FreeAndNil(FlstCntCredito) ;
  FreeAndNil(FlstValCntCredito) ;
  inherited Destroy ;
end;

constructor TLanConGenerico.Create(qryDados: TUniQuery; strTipLan: String;
  recParCon: TParametrosConsulta);
begin
  inherited Create(Nil);
  FdictPadDescri := TDictionary<string, string>.Create;
  FcdsParConRef := Nil ;
  FContadorDeLancamentos := 0;
  FLstControleLancAgrupado := TStringList.Create ;
  FLstControleLancAgrupado.Sorted := True ;
  FLstControleImpAgr := TStringList.Create;
  FLstControleImpAgr.Sorted := True;
  FAbriuCds := False;
  FlstIncDoc := TStringList.Create ;
  FlstIncDoc.Sorted := True ;
  Self.qryDados := qryDados;
  Self.qryDados.AfterScroll := pFinalizacaoDoLote;
  Self.qryDados.BeforeScroll := pBeforeScroll;
  Self.strTipLan := strTipLan;
  FstrSiglaGeracao := strTipLan;
  Self.recParCon := recParCon;
  qryParCon := fCriaQuery(Self);
  Self.FPreValidar := False;
  dicContaParametro := TDictionary<String,String>.Create;
  FListaLanCon := TObjectList<TDadosImportacaoContabil>.Create;
  FListaLanConDuplo := TObjectList<TDadosImportacaoContabil>.Create;
  FListaSeqLot := TObjectList<TDadosSequencialDoLote>.Create;
  FGravacaoEmLote := TGravacaoEmLote.Create(Nil, qryParCon.Connection.Database,
    qryParCon.Connection.Username, qryParCon.Connection.Password,
    IntToStr(qryParCon.Connection.Port), qryParCon.Connection.Server);
  FAbrevConRep := TAbreviacaoContabilRep.Create(Self.strTipLan);
  FParametrizouCreditoNaFormaDePagto := fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_FORPGO'], [strTipLan, FPG_CREDITO]) > 0;
  FParametrizouAdiantamentoCTR := fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_FORPGO'], [strTipLan, FPG_ADIANTAMENTO]) > 0;
  FUsaCheckListComplemento := fTabelaExiste('CMPPAR');
  FConSeqParExiste := fCampoExiste('PARCON', 'CON_SEQPAR');
  FTamanhoDoLote := fCfgSis('LOTCON', varInteger);
  FillChar(recParametrosGravaLanCon, SizeOf(recParametrosGravaLanCon), #0);
  FContaCtrLanctoDuplo := fGetContaCtrLanctoDuplo;
  FDescCfgContaCtrLanctoDuplo := fDescricaoCfgCCECTR;
  FLanConCCusCrExiste := fCampoExiste('LANCON', 'CON_CCUSCR');
  FContaCtrAdtLanctoDuplo := fGetContaCtrAdtLanctoDuplo;
  FstrContaEmprestimoAtivo := fPlanoContasEmprestimoEntreEmpresasAtivo ;
  FDescCfgContaEmprestimoAtivo := fDescricaoCfgPlanoContasEmprestimoEntreEmpresasAtivo;
  FstrContaEmprestimoPassivo := fPlanoContasEmprestimoEntreEmpresasPassivo ;
  FDescCfgContaEmprestimoPassivo := fDescricaoCfgPlanoContasEmprestimoEntreEmpresasPassivo;
  FValidarVigenciaCta := fTemVigencia;
  /////carrega as contas em uma tabela de memoria para verificação
  cdsPlancoVigencia := fCarregaPlancoVigencia ;
  FcdsPlancoInfo := recParCon.cdsPlancoInfo ;
  cdsParConWarning := fCarregaParconHistorico(strTipLan, FUsaCheckListComplemento, FConSeqParExiste) ;
  FLstDesvalCadastrado := TStringList.Create ;
  FLstDesvalCadastrado.Sorted := True ;
  FdictParcon := TObjectDictionary<string, TUniClientDataSet>.Create([doOwnsValues]);
  FdictDiferencaDebitoCredito := TObjectDictionary<string, TLanConControleDebitoCredito>.Create([doOwnsValues]);
  FlstControleDiferencaDebitoCredito := TStringList.Create ;
  FlstControleDiferencaDebitoCredito.Sorted := True ;
  FlstControlePesquisaContaContabil := TStringList.Create ;
  FlstControlePesquisaContaContabil.Sorted := True ;
  FlstControleVigenciaContaContabil := TStringList.Create ;
  FlstControleVigenciaContaContabil.Sorted := True ;
  FblnTemCentroCusto := fConfiguracaoExiste('OBRCCU') and fCfgSis('OBRCCU', varBoolean) ;
  FblnLigaPDD := fCfgLigPdd = 'S' ;
  FdictControlePortadores := TDictionary<String,String>.Create ;
  FblnAgrupaSaiEnt := fCfgAgrLan = 'S' ;
  FblnTRDCZEExiste := fConfiguracaoExiste('TRDCZE') ;
  FblnTRDCZE := fCfgSis('TRDCZE', varBoolean) ;
  FblnMktPla := fCfgMktPla = 'S' ;
  FblnConGru := fCfgConGru = 'S' ;
  FblnNatDsc := fCfgNatDsc = 'S' ;
  FblnConEmp := fCfgConEmp = 'S' ;
  FblnAdmCont := fEhAdmContabilidade ;
  FblnCtrAgr  := fCfgCtrAgr = 'S' ;
  FblnFiltradoPelaEmpresaBaixa := fFiltradoPelaEmpresaBaixa ;
  FblnImpAGr := fCfgImpAgr;
  FblnHisTpl := fCfgHisTpl;
  FstrTplacoEmpLog := fRetTplacoEmpresaLogada;
end;

destructor TLanConGenerico.Destroy;
begin
  FreeAndNil(FdictPadDescri);
  FreeAndNil(FlstControleDiferencaDebitoCredito);
  FreeAndNil(FLstControleLancAgrupado);
  FreeAndNil(FLstControleImpAgr);
  FreeAndNil(FlstIncDoc);
  FreeAndNil(qryParCon);
  FreeAndNil(FGravacaoEmLote);
  FreeAndNil(dicContaParametro);
  FreeAndNil(FListaLanCon);
  FreeAndNil(FListaLanConDuplo);
  FreeAndNil(FListaSeqLot);
  FreeAndNil(FAbrevConRep);
  FreeAndNil(FLstDesvalCadastrado) ;
  FreeAndNil(FdictParcon) ;
  FreeAndNil(FdictDiferencaDebitoCredito) ;
  if assigned(FcdsParConRef) then
    FreeAndNil(FcdsParConRef);
  if assigned(cdsParConWarning) then
    FreeAndNil(cdsParConWarning);
  pLiberaPlancoVigencia;
  FreeAndNil(FlstControlePesquisaContaContabil) ;
  FreeAndNil(FlstControleVigenciaContaContabil) ;
  FreeAndNil(FdictControlePortadores) ;
  inherited;
end;

function TLanConGenerico.fTrataCodigoEmpresa(
  const AqryDados: TUniQuery): string;
begin
  result := '' ;

  if assigned(AqryDados.FindField('CDE_CODEMP')) then
  begin
    if not fEmptyStr(AqryDados.FieldByName('CDE_CODEMP').AsString) then
    begin
      result := AqryDados.FieldByName('CDE_CODEMP').AsString ;
      exit ;
    end;
  end;

  if assigned(AqryDados.FindField('CODEMP')) then
  begin
    result := AqryDados.FieldByName('CODEMP').AsString ;
  end;

end;

function TLanConGenerico.fTrataNomeEmpresa(const AqryDados: TUniQuery): string;
begin
  result := '' ;

  if assigned(AqryDados.FindField('CDE_NOMEMP')) then
  begin
    if not fEmptyStr(AqryDados.FieldByName('CDE_NOMEMP').AsString) then
    begin
      result := AqryDados.FieldByName('CDE_NOMEMP').AsString ;
      exit ;
    end;
  end;

  if assigned(AqryDados.FindField('NOMEMP')) then
  begin
    result := AqryDados.FieldByName('NOMEMP').AsString ;
  end;

end;

function TLanConGenerico.fTrataParametroPDD(const dtaDataLan: TDate; const strDesVal, strFormPagto,
  strPagame, strTipLan: string; var strMensagemValidacao: string): boolean;
begin
  strMensagemValidacao := '' ;
  result := true ;
  if strTipLan = 'CTR' then
  begin
    if not Assigned(cdsParCon.FindField('CON_TITPDD')) then
    begin
      exit ;
    end;

    if not FblnLigaPDD then
      exit ;

    if trim(recParametrosGravaLanCon.strTituloPDD) = 'S' then
    begin
      result := fLoopParametroPDD(dtaDataLan, strDesVal, strFormPagto, strPagame, 'S') ;
      if not result then
      begin
        strMensagemValidacao := 'Parâmetro não configurado para título CTR/PDD!';
        exit ;
      end ;
    end
    else
    begin
      result := fLoopParametroPDD(dtaDataLan, strDesVal, strFormPagto, strPagame, 'N') ;
      if not result then
      begin
        strMensagemValidacao := 'Parâmetro não configurado para título CTR!';
        exit ;
      end ;
    end;
  end;
end;

function TLanConGenerico.fTrataPlanoContabilBandeiraPorEmpresa(
  const AstrPlanoContabil, AstrCodEmp: String;
  const AblnRefazerConsultaPorEmpresa: Boolean): String;
var
  LstrCodigo: String ;
begin
  Result := AstrPlanoContabil ;

  if not AblnRefazerConsultaPorEmpresa then
    Exit ;

  if not Assigned(qryDados.FindField('CODIGO_BANDEIRA')) then
    Exit ;

  LstrCodigo := qryDados.FieldByName('CODIGO_BANDEIRA').AsString ;

  Result := fPlanoContabilBandeiraPorEmpresa(LstrCodigo, AstrCodEmp) ;

end;

function TLanConGenerico.fTrataPlanoContabilCadCtaPorEmpresa(
  const AstrPlanoContabil, AstrCodEmp: String;
  const AblnRefazerConsultaPorEmpresa: Boolean): String;
var
  LstrCodigo: String ;
begin
  Result := AstrPlanoContabil ;

  if not AblnRefazerConsultaPorEmpresa then
    Exit ;

  if not Assigned(qryDados.FindField('CODIGO_PLANO_CONTA')) then
    Exit ;

  LstrCodigo := qryDados.FieldByName('CODIGO_PLANO_CONTA').AsString ;

  Result := fPlanoContabilCadCtaPorEmpresa(LstrCodigo, AstrCodEmp) ;

end;

function TLanConGenerico.fTrataPlanoContabilClientePorEmpresa(
  const AstrPlanoContabil, AstrCodEmp: String;
  const AblnRefazerConsultaPorEmpresa: Boolean): String;
var
  LstrCodigo: String ;
begin
  Result := AstrPlanoContabil ;

  if not AblnRefazerConsultaPorEmpresa then
    Exit ;

  if not Assigned(qryDados.FindField('CODIGO_CLIENTE_FORNECEDOR')) then
    Exit ;

  LstrCodigo := qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString ;

  Result := fPlanoContabilClientePorEmpresa(LstrCodigo, AstrCodEmp) ;

end;

function TLanConGenerico.fTrataPlanoContabilPortadorPorEmpresa(
  const AstrPlanoContabil, AstrCodEmp: String;
  const AblnRefazerConsultaPorEmpresa: Boolean): String;
var
  LstrCodigo: String ;
begin
  Result := AstrPlanoContabil ;

  if not AblnRefazerConsultaPorEmpresa then
    Exit ;

  if not Assigned(qryDados.FindField('CODIGO_PORTADOR')) then
    Exit ;

  LstrCodigo := qryDados.FieldByName('CODIGO_PORTADOR').AsString ;

  Result := fPlanoContabilPortadorPorEmpresa(LstrCodigo, AstrCodEmp) ;

end;

function TLanConGenerico.fUsarDescricaoNatCfo(const AstrTipLan,
  AstrNatCfo: String): Boolean;
begin
  Result := True ;

  if FblnNatDsc then
    Exit ;

  if MatchStr(AstrTipLan, ['COE', 'COS']) then
    Exit ;

  if not fTemApenasNumeros(AstrNatCfo) then
    Exit ;

  Result := False ;
end;

function TLanConGenerico.fAjustarFormaPagamentoCRC(
  const ACdsParcon: TUniClientDataSet): Boolean;
begin
  Result := False ;
  if fAtivaFormasPagamentoCaixaCRC = 'N' then
    Exit ;

  if ACdsParcon.FieldByName('CON_TIPLAN').AsString <> DES_CONTABIL_SIGLA[tcCRC] then
    Exit ;

  if not fEmptyStr(AcdsParCon.FieldByName('CON_FORPGO').AsString) then
    Exit ;

  Result := True ;
end;

function TLanConGenerico.fAjustaTipoLancamento(const ATipLan: string): string;
begin
  Result := ATipLan ;
  If (ATipLan = 'SEE') Or (ATipLan = 'OUE') Or (ATipLan = 'CEN') Or (ATipLan = 'ENTADT') Or (ATipLan = 'SEEADT') Then
    Result := 'ENT'
  Else If (ATipLan = 'SES') Or (ATipLan = 'CSA') Then
    Result := 'SAI'
  Else if ATipLan = 'CTR_ADT_CC' then
    Result := 'CTR' ;
end;

function TLanConGenerico.fCarregaParCon(dtaDataLan: TDate; strDesVal, strClaFis: String; strFormPagto: String = ''; strPagame: String = ''; strOrigem: String = ''; strNatCfo: string = ''; strNatOpe: String = ''; strCst: String = ''): Boolean;
var
  strMotivoWarning : string ;
  LstrHash : string ;
  LstrSql  : string ;
  LFiltroVigencia: string;
begin
  strMotivoWarning := '' ;
  strTipLan := fAjustaTipoLancamento(strTipLan) ;

  If (strTipLan <> 'CTR') And (strTipLan <> 'CRC') And (strTipLan <> 'AJE') And (strTipLan <> 'AJS') And (strTipLan <> 'PDD') Then
  Begin
    qryParCon.Filtered := False;
    qryParCon.Filter := '';

    qryParCon.Close;
    qryParCon.SQL.Clear;
    qryParCon.SQL.Add(' SELECT PARCON.*, PAD_DESCRI, TRIM(NATCFO.NAT_DESCRI) AS NAT_DESCRI, ');
    qryParCon.SQL.Add(' CAST(COALESCE(CON_VIGINI, "2000-01-01") AS DATE) AS VIGINI, CAST(COALESCE(CON_VIGFIN, "3000-01-01") AS DATE) AS VIGFIN, ');

    if strTipLan = 'CPC' then
      qryParCon.SQL.Add(' IF(IFNULL(PARCON.CON_ORICPC, "") = "99", 1, 0) AS SEQ ' )
    else
      qryParCon.SQL.Add(' IF(IFNULL(PARCON.CON_FORPGO, "Todas") = "Todas", 1, 0) AS SEQ ');

    if (FUsaCheckListComplemento) and (FConSeqParExiste) then
      qryParCon.SQL.Add(' , CAST((SELECT GROUP_CONCAT(PAR_COMPLE SEPARATOR "_") FROM CMPPAR WHERE PAR_SEQPAR = CON_SEQPAR) AS CHAR(255)) AS COMPLEMENTOS ');

    qryParCon.SQL.Add('   FROM PARCON ');
    qryParCon.SQL.Add('   LEFT JOIN HISPAD ON PAD_CODIGO = CON_HISCRE ');
    if FblnHisTpl then
      qryParCon.SQL.Add(' AND PAD_TPLACO = ' + FstrTplacoEmpLog.QuotedString)
    else
      qryParCon.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = "" ');
    qryParCon.SQL.Add('   LEFT JOIN NATCFO ON NATCFO.AUTOINCREM = PARCON.CON_NATCFO ');
    qryParCon.SQL.Add('  WHERE CON_TIPLAN = "' + strTipLan + '" ');

    if FblnConEmp then
    begin
      qryParCon.SQL.Add(' AND PARCON.CON_CODEMP = :CODEMP ') ;
      qryParCon.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    end
    else
    begin
      qryParCon.SQL.Add(' AND PARCON.CON_CODEMP IS NULL ') ;
    end ;

    if (strTipLan <> 'CMV') and (strTipLan <> 'AGP')  then
    begin
      qryParCon.SQL.Add('  AND CON_DESVAL = "' + strDesVal + '" ');
      strMotivoWarning := strMotivoWarning + strDesVal + ' | ' ;
    end;

    if (strTipLan = 'BAN') or (strTipLan = 'TCC') then
    begin
      If Not fEmptyStr(strPagame) Then
      begin
        qryParCon.SQL.Add('  AND CON_PAGAME IN ("Todos", "' + strPagame + '")');
        strMotivoWarning := strMotivoWarning + strPagame + ' | ' ;
      end;
    end;

    If (Not fEmptyStr(strClaFis)) Then
    begin
      qryParCon.SQL.Add('  AND LOCATE("' + strClaFis + '", CON_CLAFIS) ') ;
      strMotivoWarning := strMotivoWarning + strClaFis  + ' | ' ;
    end
    Else
    begin
      qryParCon.SQL.Add('  AND IFNULL(CON_CLAFIS,"") = "" ');
    end;

    if FblnMktPla then
    begin
      If (Not fEmptyStr(recParametrosGravaLanCon.strCodigoMarketPlace)) Then
      begin
        qryParCon.SQL.Add('  AND LOCATE("' + recParametrosGravaLanCon.strCodigoMarketPlace + '", CON_CODORI) ') ;
        strMotivoWarning := strMotivoWarning + recParametrosGravaLanCon.strCodigoMarketPlace  + ' | ' ;
      end
      Else
      begin
        qryParCon.SQL.Add('  AND IFNULL(CON_CODORI,"") = "" ');
      end;
    end ;

    if FblnConGru then
    begin
      If (Not fEmptyStr(recParametrosGravaLanCon.strCodGru)) Then
      begin
        qryParCon.SQL.Add('  AND LOCATE("' + recParametrosGravaLanCon.strCodGru + '", CON_CODGRU) ') ;
        strMotivoWarning := strMotivoWarning + recParametrosGravaLanCon.strCodGru  + ' | ' ;
      end
      Else
      begin
        qryParCon.SQL.Add('  AND IFNULL(CON_CODGRU,"") = "" ');
      end;
    end ;

    If Not fEmptyStr(strFormPagto) Then
    begin
      if (strTipLan = 'BAN') or (strTipLan = 'ADT') or (strTipLan = 'CHQ') or (strTipLan = 'ANT') then
      begin
        qryParCon.SQL.Add('  AND COALESCE(CON_FORPGO,"' + FPG_TODAS + '") in ("", "' + FPG_TODAS + '", "' + strFormPagto + '") ');
      end
      else
      begin
        qryParCon.SQL.Add('  AND CON_FORPGO = "' + strFormPagto + '" ');
      end;
      strMotivoWarning := strMotivoWarning + strFormPagto  + ' | ' ;
    end;

    if strTipLan = 'CPC' then
    begin
      qryParCon.SQL.Add('  AND (CON_ORICPC = "99" '+ IfThen(not fEmptyStr(strOrigem),'OR LOCATE("' + strOrigem + '", CON_ORICPC)') + ') ');
      strMotivoWarning := strMotivoWarning + strOrigem  + ' | ' ;
    end
    else
    if not fEmptyStr(strOrigem) then
    begin
      qryParCon.SQL.Add('  AND CON_ORIGEM = "' + strOrigem + '" ') ;
      strMotivoWarning := strMotivoWarning + strOrigem  + ' | ' ;
    end
    else
    begin
      qryParCon.SQL.Add('  AND IFNULL(CON_ORIGEM,"") = "" ');
    end;

    if fUtilizaNaturezaDeOperacao(strTipLan) then
    begin
      if (fEmptyStr(strNatCfo)) and (strTipLan <> 'CMV') then
      begin
        if (not ((not strClaFis.IsEmpty) and (CFOP_ENTRADAS_APENAS_CADFIS.Contains(RightStr(strClaFis, 3))))) then
        begin
          qryParCon.SQL.Add(' AND IFNULL(CON_NATCFO,"") = "" ');
        end;
      end;
    end;

    if (not fEmptyStr(strNatOpe)) and ((strTipLan = 'SAI') or (strTipLan = 'ENT')) then
    begin
      qryParCon.SQL.Add(' AND CON_NATOPE IN ("Todos", "' + strNatOpe + '") ');
      strMotivoWarning := strMotivoWarning + strNatOpe + ' | ' ;
    end;

    qryParCon.SQL.Add(' ORDER BY SEQ ');

    LstrSql := qryParCon.SQL.Text ;
    LstrHash := THashMD5.GetHashString(LstrSql) ;
    if not FdictParcon.ContainsKey(LstrHash) then
    begin
      qryParCon.Open;

      cdsParCon := fCriaClientDatset(qryParCon, False, Self, False);
      FdictParcon.Add(LstrHash, cdsParCon);
    end
    else
    begin
      cdsParCon := FdictParcon.Items[LstrHash] ;
    end ;

    LFiltroVigencia := ' (VIGINI <= ''' + FormatDateTime('yyyy-mm-dd', dtaDataLan) + ''' AND VIGFIN >= ''' + FormatDateTime('yyyy-mm-dd', dtaDataLan) + ''') ';
    cdsParCon.Filtered := False;
    cdsParcon.Filter := LFiltroVigencia;
    cdsParCon.Filtered := True;

    if (cdsParCon.RecordCount > 1) And (fUtilizaNaturezaDeOperacao(strTipLan)) and (not fEmptyStr(strNatCfo)) then
      pFiltraPelaNaturezaParcon(strNatCfo, strTipLan, LFiltroVigencia)
    else if (cdsParCon.RecordCount = 1)
            And (fUtilizaNaturezaDeOperacao(strTipLan))
            and (not fEmptyStr(strNatCfo))
            and (not fEmptyStr(cdsParCon.FieldByName('CON_NATCFO').AsString)) then
      pFiltraPelaNaturezaParcon(strNatCfo, strTipLan, LFiltroVigencia) ;

    if (strTipLan = 'SAI') and (cdsParCon.RecordCount > 1) and (not fEmptyStr(strCst)) and (not fEmptyStr(strClaFis)) then
    begin
      cdsParCon.Filtered := False;
      cdsParCon.Filter := LFiltroVigencia + ' AND CON_CLAFIS LIKE ' + QuotedStr('%'+strClaFis+'%') + ' AND CON_CODTRI = ' + QuotedStr(strCst);
      cdsParCon.Filtered := True;
    end;

    Result := Not cdsParCon.IsEmpty;
  End
  Else
  Begin
    Result := fLocalizaParCon(dtaDataLan, strDesVal, strFormPagto, strPagame, strTipLan, strMotivoWarning);

    if (fParametrizouAdiantamentoNoCtr) then
    begin
      if (recParametrosGravaLanCon.blnAdiantamento) and (strFormPagto <> FPG_ADIANTAMENTO) then
      begin
        strMotivoWarning := '' ;
        Result := False;
      end;

      if (not recParametrosGravaLanCon.blnAdiantamento) and (strFormPagto = FPG_ADIANTAMENTO) then
      begin
        strMotivoWarning := '' ;
        Result := False;
      end;
    end;

  End;

  if (not Result) and (not fEmptyStr(strMotivoWarning)) then
  begin
    /////se não encontrar a configuração da PARCON gera um warning
    strMotivoWarning := '[' + strTipLan + ' | ' + copy(strMotivoWarning, 1, Length(strMotivoWarning) - 3) + ']' ;
    pAdicionarWarning(strMotivoWarning, qryDados, '', '', strTipLan, strDesVal, strNatCfo) ;
  end;

end;

function TLanConGenerico.fChaveParcon(
  const ACdsParcon: TUniClientDataSet): string;
begin
  Result := cdsParcon.FieldByName('CON_DESVAL').AsString + '|' + cdsParcon.FieldByName('CON_FORPGO').AsString + '|' + cdsParcon.FieldByName('CON_PAGAME').AsString;
end;

function TLanConGenerico.fContaParametro(strValor: String; strCreDeb: String; strCodEmp: String): String;
var
  LstrKey : string;
begin
  if not fEmptyStr(strValor) then
    result := strValor
  else
  begin
    LstrKey := cdsParCon.FieldByName('CON_SEQPAR').AsString + strCodEmp + strCreDeb;

    if not dicContaParametro.TryGetValue(LstrKey, Result) then
    begin
      Result := fParNco(cdsParCon.FieldByName('CON_SEQPAR').AsString, strCodEmp, strCreDeb);
      dicContaParametro.Add(LstrKey, Result);
    end;
  end;
end;

function TLanConGenerico.fDeletaLacamentosGeradosParaOutraEmpresa(const AstrTipo: string; const AblnTemControle: Boolean): boolean;
Var
  qryDel : TUniQuery;
  LintControle1, LintControle2: Largeint ;
  LqryExec: TUniQuery;
begin
  if not AblnTemControle then
    Exit(True) ;

  qryDel := fCriaQuery(nil);
  LqryExec := fCriaQuery(nil);
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' SELECT LANCNT.CNT_ORIGEM, LANCNT.CNT_CONTRO ');
    qryDel.SQL.Add('   FROM LANCNT INNER JOIN LANCON ON LANCON.AUTOINCREM = LANCNT.CNT_ORIGEM ');
    qryDel.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
    qryDel.ParamByName('TIPLAN').AsString := AstrTipo ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      qryDel.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      qryDel.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      qryDel.SQL.Add('  AND CASE WHEN LANCNT.CNT_ORIGEM <> LANCNT.CNT_CONTRO THEN LANCON.CON_EMPLAN = :CODEMP ELSE LANCNT.CNT_EMPORI = :CODEMP END ');
      qryDel.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end;

    pAplicaFiltroDocumentoLanCon(qryDel);

    qryDel.Open ;
    qryDel.First;
    While Not qryDel.Eof Do
    Begin

      LintControle1 := qryDel.FieldByName('CNT_ORIGEM').AsLargeInt ;
      LintControle2 := qryDel.FieldByName('CNT_CONTRO').AsLargeInt ;
      ///apaga o controle
      //qryDel.Delete ;
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCNT WHERE CNT_ORIGEM = :ORIGEM AND CNT_CONTRO = :CONTRO ; ');
      LqryExec.ParamByName('ORIGEM').AsLargeInt := LintControle1 ;
      LqryExec.ParamByName('CONTRO').AsLargeInt := LintControle2 ;
      LqryExec.ExecSQL ;
      //apaga os lançamentos na lancon
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCON WHERE AUTOINCREM = :INC2 ; ');
      LqryExec.ParamByName('INC2').AsLargeInt := LintControle2 ;
      LqryExec.ExecSQL ;

      qryDel.Next ;
    end;

    Result := True;
  Finally
    FreeAndNil(qryDel);
    FreeAndNil(LqryExec) ;
  End;


end;

function TLanConGenerico.fDeletaLanCon: Boolean;
  Var
    qryDel : TUniQuery;
    LTipLan : string ;
    LblnTemControle: Boolean ;
begin
  if not fEfetuaDelecaoLanCon then
    Exit(True);

  LTipLan := fAjustaTipoLancamento(strTipLan) ;

  // No reprocesso so de documentos o check list do periodo fica; a tela marca o reprocesso no fim.
  if (not recParCon.blnModoRobo) and (not recParCon.blnReprocessaErros) then
    pGravarCheckList(LTipLan) ;

  if fGeraDelLanconCRC(LTipLan) then
    Exit(True) ;

  if not recParCon.blnModoRobo then
    LblnTemControle := fTemControleDelLanconOutrasEmpresas(LTipLan)
  else
    LblnTemControle := True ;

  fDeletaLacamentosGeradosParaOutraEmpresa(LTipLan, LblnTemControle) ;

  qryDel := fCriaQuery(Self);
  Try
    qryDel.Close;
    qryDel.SQL.Clear;

    if LblnTemControle then
    begin
      qryDel.SQL.Add(' DELETE LANCON ');
      qryDel.SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
      qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
      qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
      qryDel.SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ')
    end
    else
    begin
      qryDel.SQL.Add(' DELETE ');
      qryDel.SQL.Add('   FROM LANCON ');
      qryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + LTipLan + '" ');
      qryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
    end ;

    if (recParCon.dtaDtaIni > 0) then
      qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    If Not fEmptyStr(recParCon.strCodEmp) Then
      qryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

    If (Not fEmptyStr(recParCon.strTabela)) and (LTipLan <> 'CTR') Then
      qryDel.SQL.Add('  AND LANCON.CON_TABELA = :TABELA ');

    pAplicaFiltroDocumentoLanCon(qryDel);

    pSetaParametrosGerLanCon(recParCon, qryDel);

    If (Not fEmptyStr(recParCon.strTabela)) and (LTipLan <> 'CTR') Then
      qryDel.ParamByName('TABELA').AsString := recParCon.strTabela;

    qryDel.ExecSQL;

    // LOTINC nao tem filtro por documento: no reprocesso apagaria os lotes do periodo inteiro.
    if (not recParCon.blnModoRobo) and (not recParCon.blnReprocessaErros) then
      Result := fDeletaLotInc
    else
      Result := True;
  Finally
    FreeAndNil(qryDel);
  End;
end;

function TLanConGenerico.fEfetuaDelecaoLanCon: boolean;
begin
  Result := True;

  if LancarEmPreValidar then
    exit ;

  if (blnPreValidar) then
    Exit(False);

  if (recParCon.blnModoRobo) and (recParCon.intModoLancto = MODO_ROBO_2_ESTORNO) then
    Exit(False);
end;

function TLanConGenerico.fEfetuaLancamentosPreValidacao(const AobjLancon:ITipLanCon): boolean;
var
  LdsErrors : TUniClientDataSet ;
  LListaLanCon : TObjectList<TDadosImportacaoContabil>;
  LobjItem : TDadosImportacaoContabil;
  LintCnt: Integer ;
  LTipLan: String ;
  LstrCodEmp: String ;
  LdtaIni, LdtaFin: TDateTime ;
begin
  Result := True ;

  LdsErrors := GetErros ;
  if (LdsErrors.IsEmpty or recParCon.blnModoRobo) and (Self.blnPreValidar) and (Self.FblnLancarEmPreValidar) then
  begin
    AobjLancon.pSetaPreValidacao(False);
    if AobjLancon.fDeletaLanCon then
    begin
      LListaLanCon := TObjectList<TDadosImportacaoContabil>.Create(False);
      try
        LintCnt := 0 ;
        LdsErrors.DisableControls ;
        try
          for LobjItem in FListaLanCon do
          begin

            if fTemErroModoRobo(LdsErrors, LobjItem.strCtpInc) then
            begin
              LListaLanCon.Add(LobjItem) ;
              inc(LintCnt);
              if LintCnt >= FTamanhoDoLote then
              begin
                FGravacaoEmLote.pGravar(LListaLanCon);
                LListaLanCon.Clear ;
                LintCnt := 0 ;
              end ;
            end ;

          end ;

        finally
          LdsErrors.EnableControls ;
        end ;

        if LListaLanCon.Count > 0 then
        begin
          FGravacaoEmLote.pGravar(LListaLanCon);
          LListaLanCon.Clear ;
        end ;

        if FListaLanConDuplo.Count > 0 then
        begin
          FGravacaoEmLote.pGravarDuplo(FListaLanConDuplo);
          FListaLanConDuplo.Clear;
        end;

      finally
        FreeAndNil(LListaLanCon) ;
      end ;
    end ;
  end
  else
  begin
    if (not LdsErrors.IsEmpty) and (Self.FblnLancarEmPreValidar) then
    begin
      if (not recParCon.blnModoRobo) and (not recParCon.blnReprocessaErros) then
      begin
        LTipLan := fAjustaTipoLancamento(strTipLan) ;
        pRetornaDadosIniciais(LstrCodEmp, LdtaIni, LdtaFin);
        TProcessaCheckList.fEstornar(LTipLan, LstrCodEmp, LdtaIni, LdtaFin) ;
      end ;
    end ;
  end ;

end;

function TLanConGenerico.fEfetuarLancamentoDuploEmpresasDiferentes: boolean;
begin
  Result := False;

  if FContaCtrLanctoDuplo.IsEmpty then
    Exit;

  if (strTipLan <> 'CTR') then
    Exit;

  if not recParametrosGravaLanCon.blnCFG_EXCREP then
    Exit ;

  if recParametrosGravaLanCon.strEmpresaCadastro.IsEmpty then
    Exit;

  if recParametrosGravaLanCon.strEmpresaBaixa.IsEmpty then
    Exit;

  Result := recParametrosGravaLanCon.blnEmpresaDoCadastroDiferenteDaBaixa;
end;

function TLanConGenerico.fEfetuarLancamentoDuploEmpresasDiferentesAdt: boolean;
begin
  Result := False;

  if FContaCtrAdtLanctoDuplo.IsEmpty then
    Exit;

  if (strTipLan <> 'CTR') then
    Exit;

  if not recParametrosGravaLanCon.blnCFG_EXCREP then
    Exit ;

  if recParametrosGravaLanCon.strEmpresaAdt.IsEmpty then
    Exit;

  if recParametrosGravaLanCon.strEmpresaBaixa.IsEmpty then
    Exit;

  Result := recParametrosGravaLanCon.blnEmpresaDoCadastroAdtDiferenteDaBaixa;
end;

function TLanConGenerico.fEhAdtTransformadoCC(const AstrFormPagto,
  AstrAdtTransformadoCC: String): Boolean;
begin
  Result := False ;
  if AstrAdtTransformadoCC <> 'S' then
    Exit ;

  if AstrFormPagto = FPG_CREDITO then
    Exit;

  Result := True ;
end;

function TLanConGenerico.fEhCreditodeAdt(const AstrFormPagto,
  AstrAdtTransformadoCC: String): Boolean;
begin
  Result := False ;
  if AstrAdtTransformadoCC <> 'S' then
    Exit ;

  if AstrFormPagto <> FPG_CREDITO then
    Exit;

  Result := True ;
end;

function TLanConGenerico.fExibirNoComplementoODocumentoOriginalDoAgrupamento(strTipoComplemento: string; FieldDocOri, FieldEspOri: TField): boolean;
begin
  result := (strTipoComplemento.Contains('Docto')) and
            (Assigned(FieldDocOri)) and
            (Assigned(FieldEspOri)) and
            (Not fEmptyStr(FieldDocOri.AsString));
end;

function TLanConGenerico.fFiltradoPelaEmpresaBaixa: Boolean;
var
  LblnCFG_EXCREP_Existe: boolean ;
begin
  LblnCFG_EXCREP_Existe := fCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_EXCREP', VS_strCodEmp], False) > 0;
  if LblnCFG_EXCREP_Existe then
  begin
    if fCfgSis('EXCREP', varBoolean) then
      Result := True
    else
      Result := False ;
  end
  else
    Result := True;
end;

function TLanConGenerico.fGeraDelLanconCRC(const AstrTipo: string): Boolean;
var
  LqryDel: TUniQuery ;
begin
  Result := False ;
  if AstrTipo <> 'CRC' then
    Exit ;

  LqryDel := fCriaQuery(Self);
  Try
    LqryDel.Close;
    LqryDel.SQL.Clear;
    LqryDel.SQL.Add(' SELECT * ');
    LqryDel.SQL.Add('   FROM LANCON ');
    LqryDel.SQL.Add('  WHERE LANCON.CON_TIPLAN = "' + AstrTipo + '" ');
    LqryDel.SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');

    if (recParCon.dtaDtaIni > 0) then
      LqryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    If Not fEmptyStr(recParCon.strCodEmp) Then
      LqryDel.SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryDel)
      .fExecute ;

    pSetaParametrosGerLanCon(recParCon, LqryDel);
    LqryDel.Open;
    LqryDel.First ;
    while not LqryDel.Eof do
    begin
      fVerificaIntegridade(self.Name, 'LANCON', LqryDel) ;
      LqryDel.Delete ;
    end ;

    Result := True ;
  Finally
    FreeAndNil(LqryDel);
  End;

end;

function TLanConGenerico.fGerarAgrupadoEmpresaOrigemCTR: Boolean;
begin
  Result := False ;

  if strTipLan <> 'CTR' then
    Exit ;

  if not FblnCtrAgr then
    Exit ;

  Result := True ;
end;

function TLanConGenerico.fGetCodCta(strNumDup, strCodEmp, strCodFor,
  strSerie: String; var strCodEve: String): String;
  Var
    qryCadPag : TUniQuery;
begin
  strCodEve := '';
  Result := '';

  If fEmptyStr(strCodFor) Then
    Exit;

  qryCadPag := fCriaQuery(Self);
  Try
    qryCadPag.Close;
    qryCadPag.SQL.Clear;
    qryCadPag.SQL.Add(' SELECT IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, ');
    qryCadPag.SQL.Add('        IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CTP_CODEVE ');
    qryCadPag.SQL.Add('   FROM CADPAG P ');
    qryCadPag.SQL.Add('   LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ');
    qryCadPag.SQL.Add('                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ');
    qryCadPag.SQL.Add('                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ');
    qryCadPag.SQL.Add('                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ');
    qryCadPag.SQL.Add('   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ');
    qryCadPag.SQL.Add('                   AND CTANCO.NCO_CODEMP = :CODEMP ');
    qryCadPag.SQL.Add('   JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) ');
    qryCadPag.SQL.Add('  WHERE P.CTP_NUMDUP = :NUMDUP ');
    qryCadPag.SQL.Add('    AND P.CTP_CODEMP = :CODEMP ');
    qryCadPag.SQL.Add('    AND P.CTP_CODFOR = :CODFOR ');
    qryCadPag.SQL.Add('    AND P.CTP_SEQBAI = 0 ');
    //qryCadPag.SQL.Add('    AND CTA_PLANCO IS NOT NULL ');

    If fEmptyStr(strSerie) Then
      qryCadPag.SQL.Add('  AND ((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) ')
    Else
      qryCadPag.SQL.Add('  AND P.CTP_SERIE_ = :SERIE_ ');

    qryCadPag.SQL.Add('  LIMIT 1 ');
    qryCadPag.ParamByName('NUMDUP').AsString := strNumDup;
    qryCadPag.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadPag.ParamByName('CODFOR').AsString := strCodFor;

    If Not fEmptyStr(strSerie) Then
      qryCadPag.ParamByName('SERIE_').AsString := strSerie;

    qryCadPag.Open;
    Result := qryCadPag.FieldByName('CTA_PLANCO').AsString;
    strCodEve := qryCadPag.FieldByName('CTP_CODEVE').AsString;
    qryCadPag.Close;
  Finally
    FreeAndNil(qryCadPag);
  End;
end;

function TLanConGenerico.fGetContaCtrLanctoDuplo: string;
var
  LCfg: string;
begin
  Result := '';
  LCfg := fDescricaoCfgCCECTR;

  if (strTipLan <> 'CTR') then
    exit;

  if (not fConfiguracaoExiste(LCfg)) then
    Exit;

  Result := fCfgSis(LCfg, varString);
end;

function TLanConGenerico.fGetContaCtrAdtLanctoDuplo: string;
begin
  Result := '';

  if (strTipLan <> 'CTR') then
    exit;

  if (not fConfiguracaoExiste('CCEADT')) then
    Exit;

  Result := fCfgSis('CCEADT', varString);
end;

function TLanConGenerico.fLocalizaParCon(dtaDataLan: TDate; strDesVal, strFormPagto, strPagame, strTipLan: string; var strMotivoWarning: string): boolean;
begin
  strMotivoWarning := strMotivoWarning + strDesVal  + ' | ' ;
  strMotivoWarning := strMotivoWarning + strFormPagto  + ' | ' ;
  strMotivoWarning := strMotivoWarning + strPagame  + ' | ' ;

  Result := cdsParCon.FindKey([strDesVal, strFormPagto, strPagame]) and fVerificaVigencia(cdsParcon, dtaDataLan);

  if (strFormPagto = FPG_ADIANTAMENTO) and (not fParametrizouAdiantamentoNoCtr) then
  begin
    strMotivoWarning := '' ;
    exit;
  end;

  if (strTipLan = 'CTR') and (strFormPagto = FPG_CREDITO) then
    exit;

  if (not Result) then
    Result := cdsParCon.FindKey([strDesVal, 'Todas', strPagame]) and fVerificaVigencia(cdsParcon, dtaDataLan);
end;

function TLanConGenerico.fLoopParametroPDD(const dtaDataLan: TDate; const strDesVal, strFormPagto,
  strPagame, strPDD: string): boolean;
begin
  result := false ;
  while not cdsParCon.Eof do
  begin
    if cdsParCon.FieldByName('CON_TITPDD').asString <> strPDD then
    begin
      cdsParCon.Next ;
      continue ;
    end;
    if (cdsParCon.FieldByName('VIGINI').AsDateTime > dtaDataLan) or (cdsParCon.FieldByName('VIGFIN').AsDateTime < dtaDataLan) then
    begin
      cdsParCon.Next ;
      continue ;
    end;
    if cdsParCon.FieldByName('CON_DESVAL').asString <> strDesVal then
    begin
      cdsParCon.Next ;
      continue ;
    end;
    if cdsParCon.FieldByName('CON_FORPGO').asString <> 'Todas' then
    begin
      if cdsParCon.FieldByName('CON_FORPGO').asString <> strFormPagto then
      begin
        cdsParCon.Next ;
        continue ;
      end;
    end;
    if cdsParCon.FieldByName('CON_PAGAME').asString <> strPagame then
    begin
      cdsParCon.Next ;
      continue ;
    end;

    result := True ;
    break ;
  end;
end;

function TLanConGenerico.fParametrizouAdiantamentoNoCtr: boolean;
begin
  Result := (strTipLan = 'CTR') and (FParametrizouAdiantamentoCTR);
end;

function TLanConGenerico.fPopularListaDeLancamentos: boolean;
begin
  Result := (Not blnPreValidar);

  if FblnLancarEmPreValidar then
  begin
    Result := True ;
    Exit ;
  end ;

  if (Not Result) then
  begin
    if (FblnTRDCZEExiste) then
      Result := (blnPreValidar) And (FblnTRDCZE);
  end;
end;

function TLanConGenerico.fRetSQLParametros: string;
var
  LstrTipLan : string ;
begin
  LstrTipLan := fAjustaTipoLancamento(strTipLan) ;

  Result := '';
  Result := Result + ' SELECT PARCON.*, PAD_DESCRI, ';
  Result := Result + ' CAST(COALESCE(CON_VIGINI, "2000-01-01") AS DATE) AS VIGINI, CAST(COALESCE(CON_VIGFIN, "3000-01-01") AS DATE) AS VIGFIN ';

  if (FUsaCheckListComplemento) and (FConSeqParExiste) then
    Result := Result + ' , CAST((SELECT GROUP_CONCAT(PAR_COMPLE SEPARATOR "_") FROM CMPPAR WHERE PAR_SEQPAR = CON_SEQPAR) AS CHAR(255)) AS COMPLEMENTOS ';

  Result := Result + '   FROM PARCON ';
  Result := Result + '   LEFT JOIN HISPAD ON PAD_CODIGO = CON_HISCRE ';
  if FblnHisTpl then
    Result := Result + ' AND PAD_TPLACO = ' + FstrTplacoEmpLog.QuotedString
  else
    Result := Result + ' AND IFNULL(PAD_TPLACO, "") = "" ';
  Result := Result + '  WHERE CON_TIPLAN = ' + LstrTipLan.QuotedString;
  if fCfgConEmp = 'S' then
  begin
    Result := Result + '  AND PARCON.CON_CODEMP = ' + VS_strCodEmp.QuotedString ;
  end
  else
  begin
    Result := Result + '  AND PARCON.CON_CODEMP IS NULL ' ;
  end ;
end;

function TLanConGenerico.fTemControleDelLanconOutrasEmpresas(
  const AstrTipo: string): Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery(Nil);
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT LANCNT.CNT_CONTRO  AS CONTROLE ');
    LqryConsulta.SQL.Add(' FROM LANCNT INNER JOIN LANCON AS L ON L.AUTOINCREM = LANCNT.CNT_CONTRO ');
    LqryConsulta.SQL.Add(' WHERE L.CON_TIPLAN = "' + AstrTipo + '" ');
    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryConsulta.SQL.Add('  AND L.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('L.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.SQL.Add(' UNION ');

    LqryConsulta.SQL.Add(' SELECT LANCNT.CNT_CONTRO  AS CONTROLE ');
    LqryConsulta.SQL.Add(' FROM LANCNT INNER JOIN LANCON AS L ON L.AUTOINCREM = LANCNT.CNT_ORIGEM ');
    LqryConsulta.SQL.Add(' WHERE L.CON_TIPLAN = "' + AstrTipo + '" ');
    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryConsulta.SQL.Add('  AND L.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('L.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.Open ;

    Result := not LqryConsulta.IsEmpty ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

function TLanConGenerico.fTemErroModoRobo(AcdsErrors: TUniClientDataSet;
  const AstrAutoIncrem: String): Boolean;
begin
  Result := True ;

  if AcdsErrors.IsEmpty then
    Exit ;

  if not AcdsErrors.Locate('ERR_CHVDOC', AstrAutoIncrem, [] ) then
    Exit ;

  Result := False ;
end;

function TLanConGenerico.fDocumentoExcluido(const AstrIncDoc, AstrTabela: String): Boolean;
begin
  Result := Assigned(recParCon.lstDocExcluir) and
            (recParCon.lstDocExcluir.IndexOf(AstrIncDoc + '|' + AstrTabela) >= 0);
end;

procedure TLanConGenerico.pAplicaFiltroDocumentoLanCon(AqryDel: TUniQuery);
var
  LintCnt: Integer;
  LstrParams: String;
begin
  if not recParCon.blnReprocessaErros then
  begin
    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(AqryDel)
      .fExecute ;
    Exit;
  end;

  // Reprocesso da tela: chave + tabela, porque a chave sozinha se repete entre os tipos irmaos
  // (MOVGER x CADFIS). Lista vazia nunca pode virar "apaga o periodo".
  if (not Assigned(recParCon.lstDocReprocesso)) or (recParCon.lstDocReprocesso.Count = 0) then
  begin
    AqryDel.SQL.Add('  AND 1 = 0 ');
    Exit;
  end;

  LstrParams := '';
  for LintCnt := 0 to recParCon.lstDocReprocesso.Count - 1 do
  begin
    if LstrParams <> '' then
      LstrParams := LstrParams + ', ';
    LstrParams := LstrParams + ':DOCREP' + IntToStr(LintCnt);
  end;

  // Tabela nula vira vazia: e assim que o erro chega quando o gerador nao informa a tabela (ADT).
  AqryDel.SQL.Add('  AND CONCAT(LANCON.CON_INCDOC, ''|'', IFNULL(LANCON.CON_TABELA, '''')) IN (' + LstrParams + ') ');

  for LintCnt := 0 to recParCon.lstDocReprocesso.Count - 1 do
    AqryDel.ParamByName('DOCREP' + IntToStr(LintCnt)).AsString := recParCon.lstDocReprocesso[LintCnt];
end;

function TLanConGenerico.fTemParametrosConfigurados: Boolean;
begin
  Result := True;
  qryParCon.Close;
  qryParCon.SQL.Clear;
  qryParCon.SQL.Add( fRetSQLParametros );
  qryParCon.Open;

  If (qryParCon.RecordCount = 0) Then
  Begin
    Result := False;
    if not recParCon.blnModoRobo then
      fMensagem('ATENÇÃO!', 'Não há parâmetros configurados (e/ou válidos) para o tipo "' + strTipLan + '"!', ['&OK']);
  End
  else
  begin
    cdsParCon := fCriaClientDatset(qryParCon, False, Self, False);
    FcdsParConRef := cdsParCon ;
    cdsParCon.IndexFieldNames := 'CON_DESVAL;CON_FORPGO;CON_PAGAME';
    cdsParCon.First ;
    while not cdsParCon.Eof do
    begin
      if FLstDesvalCadastrado.IndexOf(cdsParCon.FieldByName('CON_DESVAL').AsString) = -1 then
      begin
        FLstDesvalCadastrado.Add(cdsParCon.FieldByName('CON_DESVAL').AsString) ;
      end;

      if fAjustarFormaPagamentoCRC(cdsParCon) then
      begin
        cdsParCon.Edit ;
        cdsParCon.FieldByName('CON_FORPGO').AsString := FPG_TODAS ;
        cdsParCon.Post ;
      end ;

      cdsParCon.Next ;
    end ;
  end;

  qryParCon.Close;
end;

function TLanConGenerico.GetErros: TUniClientDataSet;
begin
  Result := objValida.DataSet;
end;

function TLanConGenerico.GetWarnings: TUniClientDataSet;
begin
  Result := objValida.DataSetWarnings;
end;


procedure TLanConGenerico.pAddLstIncDoc(const strIncDoc: String);
begin
  if FlstIncDoc.IndexOf(strIncDoc) = -1 then
    FlstIncDoc.Add(strIncDoc) ;
end;


procedure TLanConGenerico.pAdicionarErro(AMotivo, AOrigem, AHistorico, ATipLan, ADesVal, ANatOpe, AChave, ATabela: string; const AContabilizaveis: TContabilizaveis; const AWarning: Boolean = False; const AdtaLan: TDateTime = 0; const AstrCodEmpDoc: String = '');
  var
    recContaErro : TContaErro;
begin
  FillChar(recContaErro, SizeOf(recContaErro), #0);
  recContaErro.strMotivo := AMotivo;
  recContaErro.strOriPla := AOrigem;
  recContaErro.strHistor := AHistorico;
  recContaErro.strTipLan := ATipLan;
  recContaErro.strDesVal := ADesVal;
  recContaErro.strNatOpe := ANatOpe;
  recContaErro.strChaveDocumento := AChave;
  recContaErro.strTabela := ATabela;
  recContaErro.strWarning := iif(AWarning, 'S', 'N') ;
  // Geracao sem empresa informada (todas): a pendencia leva a empresa do documento, que e por onde
  // os fechamentos procuram.
  recContaErro.strCodEmp := recParCon.strCodEmp;
  if fEmptyStr(recContaErro.strCodEmp) then
    recContaErro.strCodEmp := AstrCodEmpDoc;
  recContaErro.strSigla := FstrSiglaGeracao;
  objValida.pAddErro(recContaErro, AContabilizaveis, AdtaLan);
end;

procedure TLanConGenerico.pAdicionarWarning(const AMotivo: String;
                                            dstDados: TDataSet;
                                            const AOrigem: String = '';
                                            const AHistorico: String = '';
                                            const ATipLan: String = '';
                                            const ADesVal: String = '';
                                            const ANatOpe: String = '';
                                            const ATabela: String = '';
                                            const AWarning: Boolean = True);
var
  strCmpCre : string ;
  strHistorico : string ;
  LdtaLan: TDateTime;
  LstrCodEmpDoc: String;
begin

  if (not recParCon.blnModoRobo) and (not FblnAdmCont) and (not FblnMostraWarningGeracaoMovimento) then
    Exit ;

  if not blnPreValidar then
    exit ;

  if fEmptyStr(AHistorico) then
  begin
    pSetaComplemento(strCmpCre, 'CON_CMPDEB', cdsParConWarning);
    If (strTipLan = 'BAN') Then
    Begin
      strCmpCre := strCmpCre + ' CODPOR: ' + qryDados.FieldByName('CODPOR').AsString +
                               ' CODCTA: ' + qryDados.FieldByName('CODCTA').AsString;
    End;

    If (strTipLan = 'CMV') Then
      strCmpCre := strCmpCre + ' CFOP: ' + qryDados.FieldByName('CLAFIS').AsString;

    strHistorico := strCmpCre ;
  end
  else
  begin
    strHistorico := AHistorico ;
  end;

  // Com AWarning = False o registro e erro bloqueante e vira pendencia: precisa da data e da empresa
  // do documento, como o pAdicionarErroInt (geracao sem empresa informada).
  LdtaLan := 0;
  if Assigned(dstDados.FindField('DTAENT')) then
    LdtaLan := dstDados.FieldByName('DTAENT').AsDateTime;
  LstrCodEmpDoc := '';
  if Assigned(dstDados.FindField('CODEMP')) then
    LstrCodEmpDoc := dstDados.FieldByName('CODEMP').AsString;

  pAdicionarErro(AMotivo,
                 AOrigem,
                 strHistorico,
                 ATipLan,
                 ADesVal,
                 ANatOpe,
                 TChaveDocInterprete.New(dstDados).getChave,
                 ATabela,
                 fgetContabilizaveis(dstDados),
                 AWarning,
                 LdtaLan,
                 LstrCodEmpDoc);
end;

procedure TLanConGenerico.pAjustaPlanoContasPortadorRepasseCheque(
  const AparametroContabil: TParametroContabil; const ATipLan,
  ADesVal: String; var APlancoCredito, APlancoDebito: String);
var
  LplancoPortadorChqRepasseCredito: String ;
  LplancoPortadorChqRepasseDebito : String ;
begin
  APlancoCredito := AparametroContabil.strContaCredito;
  APlancoDebito  := AparametroContabil.strContaDebito;
  if (ATipLan = 'CHQ') and (ADesVal = DES_VALOR_CHEQUE_VALOR_REPASSE) then
  begin
    LplancoPortadorChqRepasseCredito := '' ;
    LplancoPortadorChqRepasseDebito  := '' ;

    if Assigned(qryDados.FindField('PLAPOR_REPASSE_CREDITO')) then
      LplancoPortadorChqRepasseCredito := qryDados.FieldByName('PLAPOR_REPASSE_CREDITO').AsString ;
    if Assigned(qryDados.FindField('PLAPOR_REPASSE_DEBITO')) then
      LplancoPortadorChqRepasseDebito := qryDados.FieldByName('PLAPOR_REPASSE_DEBITO').AsString ;

    if AparametroContabil.blnCreditoPortador then
      APlancoCredito := LPlancoPortadorChqRepasseDebito ;
    if AparametroContabil.blnDebitoPortador then
      APlancoDebito := LPlancoPortadorChqRepasseCredito ;
  end ;
end;

procedure TLanConGenerico.pAtualizaContadorLancamentos(const AItem: TDadosImportacaoContabil);
var
  strChave : string ;
begin
  if fPodeAgruparLancamentoImpAgr(AItem, FblnImpAGr) then
  begin
    strChave := fRetornaChaveImpAgr(AItem);

    if FLstControleImpAgr.IndexOf(strChave) = -1 then
      FLstControleImpAgr.Add(strChave)
    else
      Exit;
  end;

  if fPodeAgruparLancamentos(AItem.strTipoLancamento, FblnAgrupaSaiEnt) then
  begin
    strChave := fRetornaChaveAgrupaLancamentos(AItem) ;
    if FLstControleLancAgrupado.IndexOf(strChave) = -1 then
    begin
      FLstControleLancAgrupado.Add(strChave) ;
      Inc(FContadorDeLancamentos);
    end;
  end
  else
  begin
    Inc(FContadorDeLancamentos);
  end;
end;

procedure TLanConGenerico.pBeforeScroll(DataSet: TDataSet);
begin
  //
end;

procedure TLanConGenerico.pConfiguraEmpresaLancamentoDuploEmpresasDiferentes(var AstrEmpCad,
  AstrEmpBai: string; const AstrFormPagto, AstrCodigoEmpDesmem: string);
begin
  if AstrFormPagto = FPG_CREDITO then
  begin
    AstrEmpBai := IfThen((not fEmptyStr(AstrCodigoEmpDesmem)) and (fGerarAgrupadoEmpresaOrigemCTR), AstrCodigoEmpDesmem, recParametrosGravaLanCon.strEmpresaCadastro) ;
    AstrEmpCad := recParametrosGravaLanCon.strEmpresaBaixa ;
  end
  else
  begin
    AstrEmpCad := IfThen((not fEmptyStr(AstrCodigoEmpDesmem)) and (fGerarAgrupadoEmpresaOrigemCTR), AstrCodigoEmpDesmem, recParametrosGravaLanCon.strEmpresaCadastro) ;
    AstrEmpBai := recParametrosGravaLanCon.strEmpresaBaixa ;
  end ;
end;

procedure TLanConGenerico.pGeraDicionarioDebitoCredito(AobjDados: TDadosImportacaoContabil);
var
  LstrChave: String ;
  LobjControle: TLanConControleDebitoCredito ;
  LstrContaCredito, LstrContaDebito: String ;
  LfltValor: Double ;
begin
  if not blnPreValidar then
    Exit ;

  if not FblnTRDCZEExiste then
    exit;

  if not FblnTRDCZE then
    exit;

  LstrChave := AobjDados.strCtpInc ;
  LfltValor := AobjDados.fltValorLancamento ;
  LstrContaCredito := Trim(AobjDados.strContaCredito) ;
  LstrContaDebito := Trim(AobjDados.strContaDebito) ;

  if not FdictDiferencaDebitoCredito.ContainsKey(LstrChave) then
  begin
    LobjControle := TLanConControleDebitoCredito.Create ;
    LobjControle.Debito := 0.00 ;
    LobjControle.Credito := 0.00 ;
    LobjControle.Dados := AobjDados ;
    FdictDiferencaDebitoCredito.Add(LstrChave, LobjControle);
  end
  else
    LobjControle := FdictDiferencaDebitoCredito.Items[LstrChave] ;

  if not fEmptyStr(LstrContaCredito) and (not AobjDados.blnIsAgrup) then
  begin
    if (fEmptyStr(LstrContaDebito)) AND (LobjControle.CntCredito.IndexOf(LstrContaCredito) < 0) then
    begin
      LobjControle.CntCredito.Add(LstrContaCredito) ;
      LobjControle.ValCntCredito.Add(AobjDados.strDescricaoValor) ;
    end;
    LobjControle.Credito := LobjControle.Credito + LfltValor ;
  end;

  if not fEmptyStr(LstrContaDebito) and (not AobjDados.blnIsAgrup) then
  begin
    if (fEmptyStr(LstrContaCredito)) AND (LobjControle.CntDebito.IndexOf(LstrContaDebito) < 0) then
    begin
      LobjControle.CntDebito.Add(LstrContaDebito) ;
      LobjControle.ValCntDebito.Add(AobjDados.strDescricaoValor) ;
    end;
    LobjControle.Debito := LobjControle.Debito + LfltValor ;
  end;

end;

procedure TLanConGenerico.pGravaLancto(strField, strDesVal: String; strPlaCta: String = ''; strFormPagto: String = ''; strCodEve: String = ''; strPagame: String = ''; strOrigem: String = ''; strNatCfo: String = ''; strNatOpe: String = ''; strCst: string = ''; strCodCta: string = '');
  Var
    intHisPad : Integer;
    strCmpCre : String;
    strConCre : String;
    strTpOriC : String;
    strCdOriC : String;
    strOpBcCr : String;
    strConDeb : String;
    strTpOriD : String;
    strCdOriD : String;
    strOpBcDb : String;
    blnParCre : Boolean;
    blnParDeb : Boolean;
    blnGerLan : Boolean;
    strConTmp : String;
    strTpOriTmp : String;
    strCdOriTmp : String;
    strOpBcTmp : String;
    strIncNatCfo : String;
    strOrigemCredito : String;
    strOrigemDebito : String;
    fltValorLancamento : double;
    strDescricaoHistoricoPadrao : string;
    strDescricaoHistoricoPadraoInversao : string;
    parametroContabil : TParametroContabil;
    parametroContabilAdt : TParametroContabil;
    parametroContabilEmpresasDiferentes : TParametroContabil;
    strMotivo : string;
    strTabela : string;
    strMensagemValidacao : string;
    strMensagemValidacaoCta : string;
    LstrCodigoEmpDesmem : string;
    LstrCodEveDeb       : string;
    LstrCodEveCre       : string;
    LstrCodEveEmpDif    : string;
    LstrCodEveEmpDifAdt : string;
    LstrEmpCad : String ;
    LstrEmpBai : String ;
    LblnIsCtpDet : Boolean ;
    LstrIncDocAg : String ;
    LstrOrigemTmp : String ;
    LstrCliFor: String ;
    LstrTip_Fc: String ;
    LstrCodEmp: String ;
    LblnAdtTransformadoCC: Boolean ;
    LblnCreditoDeAdt: Boolean ;
    LstrPlanoContasCredito: String ;
    LstrPlanoContasDebito: String ;
    LstrParconFpg: String;
    LstrEmpLan: string;
    LblnHisInversao: Boolean;
    LSeqPar: string;
    LInvNco: string;
    LstrNumDoc: string;

  procedure pAdicionarErroInt(AMotivo: string; AOrigem: string = ''; Const AWarning:Boolean=False);
  var
    LdtaLan: TDateTime;
    LstrCodEmpDoc: String;
  begin
    LdtaLan := 0;
    if Assigned(qryDados.FindField('DTAENT')) then
      LdtaLan := qryDados.FieldByName('DTAENT').AsDateTime;
    LstrCodEmpDoc := '';
    if Assigned(qryDados.FindField('CODEMP')) then
      LstrCodEmpDoc := qryDados.FieldByName('CODEMP').AsString;
    pAdicionarErro(AMotivo, AOrigem, strCmpCre, strTipLan, strDesVal,
                   strIncNatCfo, TChaveDocInterprete.New(qryDados).getChave, strTabela, fgetContabilizaveis(qryDados), AWarning, LdtaLan,
                   LstrCodEmpDoc);
  end;

begin
  LstrParconFpg := '';

  if FLstDesvalCadastrado.IndexOf(strDesVal) = -1 then
    exit ;

  recParametrosGravaLanCon.strCodigoMarketPlace := '' ;
  if Assigned(qryDados.Fields.FindField('CODIGO_MARKETPLACE')) then
  begin
    recParametrosGravaLanCon.strCodigoMarketPlace := qryDados.FieldByName('CODIGO_MARKETPLACE').AsString ;
  end ;

  recParametrosGravaLanCon.strCodGru := '' ;
  if Assigned(qryDados.Fields.FindField('ITE_CODGRU')) then
  begin
    recParametrosGravaLanCon.strCodGru := qryDados.FieldByName('ITE_CODGRU').AsString ;
  end ;

  If (fFormataFloat(qryDados.FieldByName(strField).AsFloat, 2) <> 0) And
     (fCarregaParCon(qryDados.FieldByName('DTAENT').AsDateTime, strDesVal, qryDados.FieldByName('CLAFIS').AsString, strFormPagto, strPagame, strOrigem, strNatCfo, strNatOpe, strCst)) Then
  Begin
    if strTipLan = 'IMO' then
      LstrNumDoc := qryDados.FieldByName('AMO_CODIMO').AsString
    else
      LstrNumDoc := qryDados.FieldByName('NUMDOC').AsString;

    LstrParconFpg := cdsParCon.FieldByName('CON_FORPGO').AsString;
    LSeqPar := cdsParCon.FieldByName('CON_SEQPAR').AsString;
    LInvNco := 'N';

    LstrCodEmp := fTrataCodigoEmpresa(qryDados) ;
    if not fTrataParametroPDD(qryDados.FieldByName('DTAENT').AsDateTime, strDesVal, strFormPagto, strPagame, strTipLan, strMensagemValidacao) then
      exit ;

    strTabela := '';
    if (Assigned(qryDados.FindField('TABELA'))) then
      strTabela := qryDados.FieldByName('TABELA').AsString;

    LstrCodigoEmpDesmem := '';
    if (Assigned(qryDados.FindField('CDE_CODEMP'))) then
      LstrCodigoEmpDesmem := qryDados.FieldByName('CDE_CODEMP').AsString;

    LstrCliFor := '' ;
    LstrTip_Fc := '' ;
    if Assigned(qryDados.FindField('CODIGO_CLIENTE_FORNECEDOR')) then
      LstrCliFor := qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString ;
    if Assigned(qryDados.FindField('TIPO_CLIENTE_FORNECEDOR')) then
      LstrTip_Fc := qryDados.FieldByName('TIPO_CLIENTE_FORNECEDOR').AsString ;

    // necessário para o AGR/AGP
    LstrIncDocAg := '' ;
    if (Assigned(qryDados.FindField('AG_INC'))) then
      LstrIncDocAg := qryDados.FieldByName('AG_INC').AsString;

    LblnIsCtpDet := False ;

    intHisPad := fCarregaCodigoHistoricoCadCta(strCodCta, strTipLan);
    if intHisPad <= 0 then
    begin
      intHisPad := cdsParCon.FieldByName('CON_HISCRE').AsInteger;
      strDescricaoHistoricoPadrao := cdsParCon.FieldByName('PAD_DESCRI').AsString; //fallback
    end;

    pSetaComplemento(strCmpCre, 'CON_CMPDEB', cdsParCon);

    if not fValidarHistorico(intHisPad, strCmpCre) then
    begin
      pAdicionarErroInt(MSG_VALIDA_HISTORICO);
      Exit ;
    end ;

    LblnAdtTransformadoCC := False ;
    if fEfetuarLancamentoDuploEmpresasDiferentes then
      LblnAdtTransformadoCC := fEhAdtTransformadoCC(strFormPagto, recParametrosGravaLanCon.strAdtTransformadoCC) ;

    LstrCodEmp := ifThen(not LblnAdtTransformadoCC, LstrCodEmp, recParametrosGravaLanCon.strEmpresaCadastro) ;

    parametroContabil := fSetarConta(strPlaCta, LstrCodEmp, strDesVal, qryDados.FieldByName('CLAFIS').AsString, LblnAdtTransformadoCC);
    try
      pAjustaPlanoContasPortadorRepasseCheque(parametroContabil, strTipLan, strDesVal, strConCre, strConDeb) ;
      strTpOriC := parametroContabil.strTipoOrigemCredito;
      strCdOriC := parametroContabil.strCodigoOrigemCredito;
      strOpBcCr := parametroContabil.strBaixaCadastroCredito;
      strTpOriD := parametroContabil.strTipoOrigemDebito;
      strCdOriD := parametroContabil.strCodigoOrigemDebito;
      strOpBcDb := parametroContabil.strBaixaCadastroDebito;

      strMensagemValidacaoCta := fVericaContaNoPlanoContas(strConCre, LstrCodEmp, 'crédito', FlstControlePesquisaContaContabil) ;
      if not fEmptyStr(strMensagemValidacaoCta) then
      begin
        pAdicionarErroInt(strMensagemValidacaoCta);
        exit ;
      end ;
      strMensagemValidacaoCta := fVericaContaNoPlanoContas(strConDeb, LstrCodEmp, 'débito', FlstControlePesquisaContaContabil) ;
      if not fEmptyStr(strMensagemValidacaoCta) then
      begin
        pAdicionarErroInt(strMensagemValidacaoCta);
        exit ;
      end ;
      ///
      blnParCre := parametroContabil.fParametrizouCredito;
      blnParDeb := parametroContabil.fParametrizouDebito;
      strOrigemCredito := parametroContabil.fOrigemCredito;
      strOrigemDebito := parametroContabil.fOrigemDebito;
    finally
      FreeAndNil(parametroContabil);
    end;

    if fEfetuarLancamentoDuploEmpresasDiferentes then
    begin
      parametroContabilEmpresasDiferentes := fSetarConta(strPlaCta, ifThen(not LblnAdtTransformadoCC, recParametrosGravaLanCon.strEmpresaBaixa, recParametrosGravaLanCon.strEmpresaCadastro), strDesVal, qryDados.FieldByName('CLAFIS').AsString, LblnAdtTransformadoCC);
      try
        strConDeb := parametroContabilEmpresasDiferentes.strContaDebito;
        strTpOriD := parametroContabilEmpresasDiferentes.strTipoOrigemDebito;
        strCdOriD := parametroContabilEmpresasDiferentes.strCodigoOrigemDebito;
        strOpBcDb := parametroContabilEmpresasDiferentes.strBaixaCadastroDebito;
        strMensagemValidacaoCta := fVericaContaNoPlanoContas(strConCre, recParametrosGravaLanCon.strEmpresaBaixa, 'crédito', FlstControlePesquisaContaContabil) ;
        if not fEmptyStr(strMensagemValidacaoCta) then
        begin
          pAdicionarErroInt(strMensagemValidacaoCta);
          exit ;
        end ;
        strMensagemValidacaoCta := fVericaContaNoPlanoContas(strConDeb, recParametrosGravaLanCon.strEmpresaBaixa, 'débito', FlstControlePesquisaContaContabil) ;
        if not fEmptyStr(strMensagemValidacaoCta) then
        begin
          pAdicionarErroInt(strMensagemValidacaoCta);
          exit ;
        end ;

        if (copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) <> copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8)) and (fEmptyStr(FstrContaEmprestimoAtivo)) then
        begin
          pAdicionarErroInt('Divergência do CNPJ da emp. de baixa e cadastro, configure a [CFG_EMPATI]');
          exit ;
        end ;

        if (copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) <> copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8)) and (fEmptyStr(FstrContaEmprestimoPassivo)) then
        begin
          pAdicionarErroInt('Divergência do CNPJ da emp. de baixa e cadastro, configure a [CFG_EMPPAS]');
          exit ;
        end ;

        ///
        blnParDeb := parametroContabilEmpresasDiferentes.fParametrizouDebito;
        strOrigemDebito := parametroContabilEmpresasDiferentes.fOrigemDebito;
      finally
        FreeAndNil(parametroContabilEmpresasDiferentes);
      end;
    end ;

    if fEfetuarLancamentoDuploEmpresasDiferentesAdt then
    begin
      parametroContabilAdt := fSetarConta(strPlaCta, qryDados.FieldByName('EMPADT').AsString, strDesVal, qryDados.FieldByName('CLAFIS').AsString, LblnAdtTransformadoCC);
      try
        strConDeb := parametroContabilAdt.strContaDebito;
        strTpOriD := parametroContabilAdt.strTipoOrigemDebito;
        strCdOriD := parametroContabilAdt.strCodigoOrigemDebito;
        strOpBcDb := parametroContabilAdt.strBaixaCadastroDebito;
        strMensagemValidacaoCta := fVericaContaNoPlanoContas(strConCre, qryDados.FieldByName('EMPADT').AsString, 'crédito', FlstControlePesquisaContaContabil) ;
        if not fEmptyStr(strMensagemValidacaoCta) then
        begin
          pAdicionarErroInt(strMensagemValidacaoCta);
          exit ;
        end ;
        strMensagemValidacaoCta := fVericaContaNoPlanoContas(strConDeb, qryDados.FieldByName('EMPADT').AsString, 'débito', FlstControlePesquisaContaContabil) ;
        if not fEmptyStr(strMensagemValidacaoCta) then
        begin
          pAdicionarErroInt(strMensagemValidacaoCta);
          exit ;
        end ;

        if (copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) <> copy(qryDados.FieldByName('EMP_CGCADT').AsString,1,8)) and (fEmptyStr(FstrContaEmprestimoAtivo)) then
        begin
          pAdicionarErroInt('Divergência do CNPJ da emp. de baixa e adiantamento, configure a [CFG_EMPATI]');
          exit ;
        end ;

        if (copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) <> copy(qryDados.FieldByName('EMP_CGCADT').AsString,1,8)) and (fEmptyStr(FstrContaEmprestimoPassivo)) then
        begin
          pAdicionarErroInt('Divergência do CNPJ da emp. de baixa e adiantamento, configure a [CFG_EMPPAS]');
          exit ;
        end ;

        ///
        blnParDeb := parametroContabilAdt.fParametrizouDebito;
        strOrigemDebito := parametroContabilAdt.fOrigemDebito;
      finally
        FreeAndNil(parametroContabilAdt);
      end;
    end ;

    If (strTipLan = 'BAN') Then
    Begin
      strCmpCre := strCmpCre + ' CODPOR: ' + qryDados.FieldByName('CODPOR').AsString +
                               ' CODCTA: ' + qryDados.FieldByName('CODCTA').AsString;

      If (qryDados.FieldByName('CREDEB').AsString = 'D') Then
      Begin
        strConTmp := strConCre;
        strTpOriTmp := strTpOriC;
        strCdOriTmp := strCdOriC;
        strOpBcTmp := strOpBcCr;

        strConCre := strConDeb;
        strTpOriC := strTpOriD;
        strCdOriC := strCdOriD;
        strOpBcCr := strOpBcDb;

        strConDeb := strConTmp;
        strTpOriD := strTpOriTmp;
        strCdOriD := strCdOriTmp;
        strOpBcDb := strOpBcTmp;

        LstrOrigemTmp := strOrigemCredito ;
        strOrigemCredito := strOrigemDebito ;
        strOrigemDebito := LstrOrigemTmp ;
        LInvNco := 'S';
      End;
    End;

    If (strTipLan = 'CMV') Then
      strCmpCre := strCmpCre + ' CFOP: ' + qryDados.FieldByName('CLAFIS').AsString;

    blnGerLan := True;

    if (strTipLan = 'ENT') then
    begin
      if assigned(qryDados.FindField('MENSAGEM_VALIDACAO')) then
      begin
        strMensagemValidacao := qryDados.FieldByName('MENSAGEM_VALIDACAO').AsString ;
        if not fEmptyStr(strMensagemValidacao) then
        begin
          pAdicionarErroInt(strMensagemValidacao);
          exit ;
        end ;
      end ;
    end ;

    If fEmptyStr(strConCre) Or
       fEmptyStr(strConDeb) Then
    Begin
      blnGerLan := False;

      strIncNatCfo := '';
      If (Assigned(cdsParCon.FindField('CON_NATCFO'))) And (Not fEmptyStr(cdsParCon.FieldByName('CON_NATCFO').AsString)) Then
        strIncNatCfo := fCampoTabela('NAT_DESCRI', 'NATCFO', ['AUTOINCREM'], [cdsParCon.FieldByName('CON_NATCFO').AsString], True);

      If fEmptyStr(strConCre) And blnParCre Then
        pAdicionarErroInt('Conta de crédito não informada', strOrigemCredito)
      Else
        blnGerLan := True;

      If fEmptyStr(strConDeb) And blnParDeb Then
        pAdicionarErroInt('Conta de débito não informada', strOrigemDebito)
      Else
        blnGerLan := True;

      If (fEmptyStr(trim(strConCre + strConDeb))) And (blnGerLan) Then
      begin
        pAdicionarErroInt(CONTABIL_MSG_NAO_DEFINIU_DEBITO_NEM_CREDITO);
        blnGerLan := False;
      end;
    End;

    if (not fEmptyStr(strConCre)) and (not fEmptyStr(strConDeb)) and (strConCre = strConDeb) then
    begin
      pAdicionarErroInt(format(CONTABIL_MSG_CONTA_CREDITO_DEBITO_IGUAIS, [strConCre, strConDeb]));
      blnGerLan := False;
    end ;

    ///Verifica a se o lançamento está na vigência da conta contábil.
    if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                   qryDados.FieldByName('DTAENT').AsDateTime,
                                   strConCre,
                                   strMensagemValidacao,
                                   LstrCodEmp,
                                   FlstControleVigenciaContaContabil) then
    begin
      pAdicionarErroInt(strMensagemValidacao);
      blnGerLan := False;
    end ;
    if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                   qryDados.FieldByName('DTAENT').AsDateTime,
                                   strConDeb,
                                   strMensagemValidacao,
                                   LstrCodEmp,
                                   FlstControleVigenciaContaContabil) then
    begin
      pAdicionarErroInt(strMensagemValidacao);
      blnGerLan := False;
    end ;

    LstrCodEveDeb := fRetornaCentroCusto(FcdsPlancoInfo, strConDeb, strCodEve, LstrCodEmp) ;
    LstrCodEveCre := fRetornaCentroCusto(FcdsPlancoInfo, strConCre, strCodEve, LstrCodEmp) ;

    if fLancamentoUtilizaCentroDeCusto(strTipLan) then
    begin
      if not fValidouCentroDeCusto(tpcDebito, strConDeb, LstrCodEveDeb, strMotivo, FcdsPlancoInfo, LstrCodEmp, FblnTemCentroCusto) then
      begin
        pAdicionarErroInt(strMotivo);
        blnGerLan := False;
      end;

      if not fValidouCentroDeCusto(tpcCredito, strConCre, LstrCodEveCre, strMotivo, FcdsPlancoInfo, LstrCodEmp, FblnTemCentroCusto) then
      begin
        pAdicionarErroInt(strMotivo);
        blnGerLan := False;
      end;
    end;

    if blnGerLan then
    begin
      pAddLstIncDoc(TChaveDocInterprete.New(qryDados).getChave) ;
    end ;

    If (blnGerLan) And (fPopularListaDeLancamentos) Then
    begin
      fltValorLancamento := fFormataFloat(qryDados.FieldByName(strField).AsFloat, 2);

      if (fEfetuarLancamentoDuploEmpresasDiferentes) then
      begin
        LstrCodEveEmpDif := fRetornaCentroCusto(FcdsPlancoInfo, FContaCtrLanctoDuplo, strCodEve, LstrCodEmp) ;
        pConfiguraEmpresaLancamentoDuploEmpresasDiferentes(LstrEmpCad, LstrEmpBai, strFormPagto, LstrCodigoEmpDesmem) ;
        LblnCreditoDeAdt := fEhCreditodeAdt(strFormPagto, recParametrosGravaLanCon.strAdtTransformadoCC) ;
        LstrPlanoContasCredito := strConCre ;
        LstrPlanoContasDebito := ifThen(not LblnAdtTransformadoCC, ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), FContaCtrLanctoDuplo, FstrContaEmprestimoAtivo), strConDeb);
        strTpOriD := ifThen(not LblnAdtTransformadoCC, ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg], CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg]), strTpOriD);
        strCdOriD := ifThen(not LblnAdtTransformadoCC, ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), FDescCfgContaCtrLanctoDuplo, FDescCfgContaEmprestimoAtivo), strCdOriD);
        strOpBcDb := ifThen(not LblnAdtTransformadoCC, ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), EmptyStr, EmptyStr), strOpBcDb);
        pInverterPlanoContasCreditoDeAdt(LstrPlanoContasCredito, LstrPlanoContasDebito, LblnCreditoDeAdt, LstrPlanoContasCredito, LstrPlanoContasDebito) ;
        LInvNco := IfThen(LblnCreditoDeAdt, 'S', 'N');
        if LblnCreditoDeAdt then
        begin
          strTpOriTmp := strTpOriC;
          strCdOriTmp := strCdOriC;
          strOpBcTmp := strOpBcCr;

          strTpOriC := strTpOriD;
          strCdOriC := strCdOriD;
          strOpBcCr := strOpBcDb;

          strTpOriD := strTpOriTmp;
          strCdOriD := strCdOriTmp;
          strOpBcDb := strOpBcTmp;
        end;
        LstrEmpLan := ifthen(FblnFiltradoPelaEmpresaBaixa, recParametrosGravaLanCon.strEmpresaBaixa, IfThen((not fEmptyStr(LstrCodigoEmpDesmem)) and (fGerarAgrupadoEmpresaOrigemCTR), LstrCodigoEmpDesmem, recParametrosGravaLanCon.strEmpresaCadastro));
        pInsertLanCon(qryDados.FieldByName('DTAENT').AsDateTime,
                      qryDados.FieldByName('CLAFIS').AsString,
                      '',        // strNatOpe
                      strDesVal,
                      LstrPlanoContasCredito,
                      LstrPlanoContasDebito,
                      intHisPad,
                      fDescriHisPad(strDescricaoHistoricoPadrao, intHisPad, LstrEmpLan) + ' ' + strCmpCre,
                      fltValorLancamento,
                      LstrEmpLan,
                      LstrCodEveCre,
                      LstrCodEveEmpDif,
                      TChaveDocInterprete.New(qryDados).getChave,
                      strTabela,
                      strFormPagto,
                      strPagame,
                      blnParCre,
                      blnParDeb,
                      strOrigemCredito,
                      strOrigemDebito,
                      LblnIsCtpDet,
                      LstrCliFor,
                      LstrTip_Fc,
                      LstrEmpCad,
                      '',
                      recParametrosGravaLanCon.strEspDoc,
                      LStrParconFpg,
                      LSeqPar,
                      LInvNco,
                      strTpOriD,
                      strCdOriD,
                      strOpBcDb,
                      strTpOriC,
                      strCdOriC,
                      strOpBcCr,
                      LstrNumDoc ); ///FALSE

        if not LblnAdtTransformadoCC then
        begin
          LstrPlanoContasCredito := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), FContaCtrLanctoDuplo, FstrContaEmprestimoPassivo) ;
          strTpOriC := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg], CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg]);
          strCdOriC := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), FDescCfgContaCtrLanctoDuplo, FDescCfgContaEmprestimoPassivo);
          strOpBcCr := EmptyStr;
          LstrPlanoContasDebito := strConDeb ;
          pInverterPlanoContasCreditoDeAdt(LstrPlanoContasCredito, LstrPlanoContasDebito, LblnCreditoDeAdt, LstrPlanoContasCredito, LstrPlanoContasDebito) ;
          LInvNco := IfThen(LblnCreditoDeAdt, 'S', 'N');
          if LblnCreditoDeAdt then
          begin
            strTpOriTmp := strTpOriC;
            strCdOriTmp := strCdOriC;
            strOpBcTmp := strOpBcCr;

            strTpOriC := strTpOriD;
            strCdOriC := strCdOriD;
            strOpBcCr := strOpBcDb;

            strTpOriD := strTpOriTmp;
            strCdOriD := strCdOriTmp;
            strOpBcDb := strOpBcTmp;
          end;

          LstrEmpLan := LstrEmpBai;
          pInsertLanCon(qryDados.FieldByName('DTAENT').AsDateTime,
                        qryDados.FieldByName('CLAFIS').AsString,
                        '',        // strNatOpe
                        strDesVal,
                        LstrPlanoContasCredito,
                        LstrPlanoContasDebito,
                        intHisPad,
                        fDescriHisPad(strDescricaoHistoricoPadrao, intHisPad, LstrEmpLan) + ' ' + strCmpCre,
                        fltValorLancamento,
                        LstrEmpLan,
                        LstrCodEveEmpDif,
                        LstrCodEveDeb,
                        TChaveDocInterprete.New(qryDados).getChave,
                        strTabela,
                        strFormPagto,
                        strPagame,
                        blnParCre,
                        blnParDeb,
                        strOrigemCredito,
                        strOrigemDebito,
                        LblnIsCtpDet,
                        LstrCliFor,
                        LstrTip_Fc,
                        LstrEmpBai,
                        '',
                        recParametrosGravaLanCon.strEspDoc,
                        LStrParconFpg,
                        LSeqPar,
                        LInvNco,
                        strTpOriD,
                        strCdOriD,
                        strOpBcDb,
                        strTpOriC,
                        strCdOriC,
                        strOpBcCr,
                        LstrNumDoc); //TRUE
        end ;
        Exit;
      end;

      if (fEfetuarLancamentoDuploEmpresasDiferentesAdt) then
      begin
        LstrCodEveEmpDifAdt := fRetornaCentroCusto(FcdsPlancoInfo, FContaCtrAdtLanctoDuplo, strCodEve, LstrCodEmp) ;
        strTpOriC := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg], CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg]);
        strCdOriC := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), FDescCfgContaCtrLanctoDuplo, FDescCfgContaEmprestimoPassivo);
        strOpBcCr := EmptyStr;
        LstrEmpLan := recParametrosGravaLanCon.strEmpresaBaixa;
        pInsertLanCon(qryDados.FieldByName('DTAENT').AsDateTime,
                      qryDados.FieldByName('CLAFIS').AsString,
                      '',        // strNatOpe
                      strDesVal,
                      ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCADT').AsString,1,8), FContaCtrAdtLanctoDuplo, FstrContaEmprestimoPassivo), // credito
                      strConDeb ,               // debito
                      intHisPad,
                      fDescriHisPad(strDescricaoHistoricoPadrao, intHisPad, LstrEmpLan) + ' ' + strCmpCre,
                      fltValorLancamento,
                      LstrEmpLan,
                      LstrCodEveEmpDifAdt,
                      LstrCodEveDeb,
                      TChaveDocInterprete.New(qryDados).getChave,
                      strTabela,
                      strFormPagto,
                      strPagame,
                      blnParCre,
                      blnParDeb,
                      strOrigemCredito,
                      strOrigemDebito,
                      LblnIsCtpDet,
                      LstrCliFor,
                      LstrTip_Fc,
                      recParametrosGravaLanCon.strEmpresaAdt,
                      '',
                      recParametrosGravaLanCon.strEspDoc,
                      LStrParconFpg,
                      LSeqPar,
                      LInvNco,
                      strTpOriD,
                      strCdOriD,
                      strOpBcDb,
                      strTpOriC,
                      strCdOriC,
                      strOpBcCr,
                      LstrNumDoc);

        strTpOriD := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg], CODIGO_ORIGEM_PLANO_CONTABIL[opcCfg]);
        strCdOriD := ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCCAD').AsString,1,8), FDescCfgContaCtrLanctoDuplo, FDescCfgContaEmprestimoAtivo);
        strOpBcDb := EmptyStr;
        pInsertLanCon(qryDados.FieldByName('DTAENT').AsDateTime,
                      qryDados.FieldByName('CLAFIS').AsString,
                      '',        // strNatOpe
                      strDesVal,
                      strConCre,               // credito
                      ifThen(copy(qryDados.FieldByName('EMP_CGCBAI').AsString,1,8) = copy(qryDados.FieldByName('EMP_CGCADT').AsString,1,8), FContaCtrAdtLanctoDuplo, FstrContaEmprestimoAtivo), // debito
                      intHisPad,
                      fDescriHisPad(strDescricaoHistoricoPadrao, intHisPad, LstrEmpLan) + ' ' + strCmpCre,
                      fltValorLancamento,
                      LstrEmpLan,
                      LstrCodEveCre,
                      LstrCodEveEmpDifAdt,
                      TChaveDocInterprete.New(qryDados).getChave,
                      strTabela,
                      strFormPagto,
                      strPagame,
                      blnParCre,
                      blnParDeb,
                      strOrigemCredito,
                      strOrigemDebito,
                      LblnIsCtpDet,
                      LstrCliFor,
                      LstrTip_Fc,
                      recParametrosGravaLanCon.strEmpresaBaixa,
                      '',
                      recParametrosGravaLanCon.strEspDoc,
                      LStrParconFpg,
                      LSeqPar,
                      LInvNco,
                      strTpOriD,
                      strCdOriD,
                      strOpBcDb,
                      strTpOriC,
                      strCdOriC,
                      strOpBcCr,
                      LstrNumDoc);
        Exit;
      end;

      if (Assigned(qryDados.FindField('IS_CTPDET'))) then
        LblnIsCtpDet := qryDados.FieldByName('IS_CTPDET').AsInteger = 1 ;

      LblnHisInversao := False;
      if fInverterContas(strTipLan, fltValorLancamento, (recParCon.intModoLancto = MODO_ROBO_2_ESTORNO) or (recParametrosGravaLanCon.blnEstorno), strFormPagto, recParametrosGravaLanCon.strEspDoc) then
      begin
        if (not fEmptyStr(fCfgSis('INVHIS'))) then
        begin
          strDescricaoHistoricoPadraoInversao := fRetDescHistoricoPadrao(fCfgSis('INVHIS', varString), VS_strCodEmp);
          if not fEmptyStr(strDescricaoHistoricoPadraoInversao) then
          begin
            intHisPad := fCfgSis('INVHIS', varInteger);
            strDescricaoHistoricoPadrao := strDescricaoHistoricoPadraoInversao;
            LblnHisInversao := True;
          end;
        end;
      end;

      LstrEmpLan := qryDados.FieldByName('CODEMP').AsString;
      pInsertLanCon(qryDados.FieldByName('DTAENT').AsDateTime,
                    qryDados.FieldByName('CLAFIS').AsString,
                    '',        // strNatOpe
                    strDesVal,
                    strConCre,
                    strConDeb,
                    intHisPad,
                    IfThen(LblnHisInversao, strDescricaoHistoricoPadrao, fDescriHisPad(strDescricaoHistoricoPadrao, intHisPad, LstrEmpLan)) + ' ' + strCmpCre,
                    fltValorLancamento,
                    LstrEmpLan,
                    LstrCodEveCre,
                    LstrCodEveDeb,
                    TChaveDocInterprete.New(qryDados).getChave,
                    strTabela,
                    strFormPagto,
                    strPagame,
                    blnParCre,
                    blnParDeb,
                    strOrigemCredito,
                    strOrigemDebito,
                    LblnIsCtpDet,
                    LstrCliFor,
                    LstrTip_Fc,
                    LstrCodigoEmpDesmem,
                    LstrIncDocAg,
                    recParametrosGravaLanCon.strEspDoc,
                    LStrParconFpg,
                    LSeqPar,
                    LInvNco,
                    strTpOriD,
                    strCdOriD,
                    strOpBcDb,
                    strTpOriC,
                    strCdOriC,
                    strOpBcCr,
                    LstrNumDoc);
    end;
  End;
end;

procedure TLanConGenerico.pGravarCheckList(const AstrTipLan: string);
var
  LdtaIni : TDateTime ;
  LdtaFin : TDateTime ;
  LstrCodEmp: String ;
begin

  pRetornaDadosIniciais(LstrCodEmp, LdtaIni, LdtaFin);

  TProcessaCheckList.fEstornar(AstrTipLan, LstrCodEmp, LdtaIni, LdtaFin) ;
  TProcessaCheckList.fLancar(AstrTipLan, LstrCodEmp, LdtaIni, LdtaFin) ;
end;

procedure TLanConGenerico.pInsertLanCon(
  dtaDtaLan: TDateTime; strClaFis, strNatOpe, strDesVal, strConCre,
  strConDeb: String; intHisPad: Integer; strHistor: String; fltValLan: Double;
  strEmpLan, strCodEveCre, strCodEveDeb, strIncDoc, strTabela: String; strFormPagto: String;
  strPagamento: string; const AblnParametrizouCredito: Boolean; const AblnParametrizouDebito: Boolean;
  const AstrOrigemCredito: String; const AstrOrigemDebito: String; const AblnIsCtpDet: Boolean;
  const AstrCliFor: String; const AstrTip_Fc: String;
  const strEmpDesmem: string; const AstrIncDocAg: String; const AstrEspDoc: String; const AstrParconFpg: string;
  const AstrSeqPar: string; const AstrInvNco: string; const AstrTpOriD: string;
  const AstrCdOriD: string; const AstrOpBcDb: string; const AstrTpOriC: string;
  const AstrCdOriC: string; const AstrOpBcCr: string; const AstrNumDoc: string);
  Var
    blnInverteContas : Boolean;
    dados : TDadosImportacaoContabil;
begin
  // Req. 470760: documento com erro na pre-validacao fica inteiro fora da gravacao.
  if fDocumentoExcluido(strIncDoc, strTabela) then
    Exit;

  blnInverteContas := fInverterContas(strTipLan, fltValLan, (recParCon.intModoLancto = MODO_ROBO_2_ESTORNO) or (recParametrosGravaLanCon.blnEstorno), strFormPagto, AstrEspDoc);

  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
  dados.strCliFor := AstrCliFor ;
  dados.strTip_fc := AstrTip_Fc ;
  dados.strCodigoEmpresa := strEmpLan;
  dados.strCodigoEmpDesmem := strEmpDesmem;
  dados.dtaLancamento := dtaDtaLan;
  dados.strTipoLancamento := strTipLan;
  dados.strCfopConfig := strClaFis;
  dados.strNaturezaOperacao := strNatOpe;
  dados.strDescricaoValor := strDesVal;
  dados.strSeqPar := AstrSeqPar;
  dados.strTpOriD := AstrTpOriD;
  dados.strCdOriD := AstrCdOriD;
  dados.strOpBcDb := AstrOpBcDb;
  dados.strNumDoc := AstrNumDoc;
  dados.strTpOriC := AstrTpOriC;
  dados.strCdOriC := AstrCdOriC;
  dados.strOpBcCr := AstrOpBcCr;
  If (blnInverteContas) Then
  begin
    dados.strContaCredito := strConDeb;
    dados.strContaDebito := strConCre;
    dados.strTpOriD := AstrTpOriC;
    dados.strCdOriD := AstrCdOriC;
    dados.strOpBcDb := AstrOpBcCr;
    dados.strTpOriC := AstrTpOriD;
    dados.strCdOriC := AstrCdOriD;
    dados.strOpBcCr := AstrOpBcDb;
    dados.strCCusto := strCodEveCre;
    if FLanConCCusCrExiste then
    begin
      dados.strCCustoCredito := strCodEveDeb ;
    end;
    dados.blnParametrizouCredito := AblnParametrizouDebito ;
    dados.blnParametrizouDebito := AblnParametrizouCredito ;
    dados.strOrigemCredito := AstrOrigemDebito ;
    dados.strOrigemDebito := AstrOrigemCredito ;
    dados.strInvNco := 'S';
    if AstrInvNco = 'S' then
    begin
      dados.strInvNco := 'N';
    end;
  end
  else
  begin
    dados.strContaCredito := strConCre;
    dados.strContaDebito := strConDeb;
    dados.strCCusto := strCodEveDeb;
    if FLanConCCusCrExiste then
    begin
      dados.strCCustoCredito := strCodEveCre ;
    end;
    dados.blnParametrizouCredito := AblnParametrizouCredito ;
    dados.blnParametrizouDebito := AblnParametrizouDebito ;
    dados.strOrigemCredito := AstrOrigemCredito ;
    dados.strOrigemDebito := AstrOrigemDebito ;
    dados.strInvNco := 'N';
    if AstrInvNco = 'S' then
    begin
      dados.strInvNco := 'S';
    end;
  end;
  dados.strHistorico := strHistor;
  dados.intCodigoHistoricoPadrao := intHisPad;
  dados.fltValorLancamento := Abs(fltValLan);
  dados.strPagamento := strPagamento ;
  dados.intAutomatico := 1;
  dados.strCodigoOperador := strLoginUsuarioLogado;
  dados.strCtpInc := strIncDoc;
  dados.strIncDocAg := AstrIncDocAg;
  dados.strTabela := strTabela;
  dados.blnIsCtpDet := AblnIsCtpDet ;
  dados.blnIsAgrup := (strTipLan = 'CTR') and (AstrEspDoc = 'AG') ;
  dados.strForPgo := AstrParconFpg;
  if fEmptyStr(dados.strCodigoEmpDesmem) then
  begin
    pAtualizaContadorLancamentos(dados);
    FListaLanCon.Add(dados);
  end
  else
  begin
    FListaLanConDuplo.Add(dados);
  end;

  pGeraDicionarioDebitoCredito(dados) ;

end;

procedure TLanConGenerico.pInverterPlanoContasCreditoDeAdt(
  const AstrPlanoContasCredito, AstrPlanoContasDebito: String;
  const AblnInverter: Boolean;
  var AstrPlanoContasCreditoInv, AstrPlanoContasDebitoInv: String);
begin
  AstrPlanoContasCreditoInv := AstrPlanoContasCredito ;
  AstrPlanoContasDebitoInv := AstrPlanoContasDebito ;
  if AblnInverter then
  begin
    AstrPlanoContasDebitoInv := AstrPlanoContasCredito ;
    AstrPlanoContasCreditoInv := AstrPlanoContasDebito ;
  end;
end;

procedure TLanConGenerico.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

procedure TLanConGenerico.pRetornaDadosIniciais(var AstrCodEmp: String;
  var AdtaIni, AdtaFin: TDateTime);
begin
  AdtaIni := VS_Date ;
  AdtaFin := VS_Date ;
  if recParCon.blnModoRobo then
  begin
    AdtaIni := recParCon.dtaLanRobo;
    AdtaFin := recParCon.dtaLanRobo;
    AstrCodEmp := trim(recParCon.strEmpRobo) ;
  end
  else
  begin
    if (recParCon.dtaDtaIni > 0) then
    begin
      AdtaIni := recParCon.dtaDtaIni;
      AdtaFin := recParCon.dtaDtaFin;
    end ;
    AstrCodEmp := trim(recParCon.strCodEmp) ;
  end ;
end;

procedure TLanConGenerico.pRetornaDadosOrigem(
  const AOrigem: TOrigemPlanoContabil; const ADebitoCredito: TTipoPlanoContas;
  const ABaixaCadastro: String; out AtipoOrigem, ACodigoOrigem: string);
var
  LTipLan: string;
  LDesVal: string;
begin
  AtipoOrigem := CODIGO_ORIGEM_PLANO_CONTABIL[AOrigem];
  ACodigoOrigem := EmptyStr;
  LTipLan := cdsParCon.FieldByName('CON_TIPLAN').AsString;
  LDesVal := cdsParCon.FieldByName('CON_DESVAL').AsString;

  case AOrigem of
    opcCliFor:
      begin
        if Assigned(qryDados.FindField('CODIGO_CLIENTE_FORNECEDOR')) then
        begin
          ACodigoOrigem := qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString;
        end;
      end;
    opcPortador:
      begin
        if Assigned(qryDados.FindField('CODIGO_PORTADOR')) then
        begin
          ACodigoOrigem := qryDados.FieldByName('CODIGO_PORTADOR').AsString;
        end;
        if (LTipLan = 'CHC') and
          (LDesVal = DES_VALOR_CHEQUE_VALOR_REPASSE) then
        begin
          if (ADebitoCredito = tpcCredito) and (Assigned(qryDados.FindField('CODIGO_PORTADOR_REPASSE_CREDITO'))) then
            ACodigoOrigem := qryDados.FieldByName('CODIGO_PORTADOR_REPASSE_CREDITO').AsString
          else if (ADebitoCredito = tpcDebito) and (Assigned(qryDados.FindField('CODIGO_PORTADOR_REPASSE_DEBITO'))) then
            ACodigoOrigem := qryDados.FieldByName('CODIGO_PORTADOR_REPASSE_DEBITO').AsString;
        end;
      end;
    opcBandeira:
      begin
        if Assigned(qryDados.FindField('CODIGO_BANDEIRA')) then
        begin
          ACodigoOrigem := qryDados.FieldByName('CODIGO_BANDEIRA').AsString;
        end;
      end;
    opcPlanoContas:
      begin
        if Assigned(qryDados.FindField('CODIGO_PLANO_CONTA')) then
        begin
          ACodigoOrigem := qryDados.FieldByName('CODIGO_PLANO_CONTA').AsString;
          if (LTipLan = 'CAR') or
             (LTipLan = 'CRC') or
             (LTipLan = 'CTR') or
             (LTipLan = 'CTP') then
          begin
            if (ABaixaCadastro = CONTA_DA_BAIXA) and (Assigned(qryDados.FindField('CODIGO_PLANO_CONTA_BAIXA'))) then
              ACodigoOrigem := qryDados.FieldByName('CODIGO_PLANO_CONTA_BAIXA').AsString;

            if LTipLan = 'CAR' then
            begin
              if LDesVal = 'Vr.Taxa' then
              begin
                if Assigned(qryDados.FindField('CODIGO_PLANO_CONTA_TAXA')) then
                  ACodigoOrigem := qryDados.FieldByName('CODIGO_PLANO_CONTA_TAXA').AsString;
              end
              else
              begin
                if Assigned(qryDados.FindField('CODIGO_PLANO_CONTA_BAIXA')) then
                  ACodigoOrigem := qryDados.FieldByName('CODIGO_PLANO_CONTA_BAIXA').AsString;
              end;
            end;
          end;
        end;
      end;
  end;
end;

procedure TLanConGenerico.pSetaComplemento(var strComplemento: String;
  strField: String; AcdsParCon: TUniClientDataSet);
  var
    strMD5Key : string;
    objHistLanCon : THistoricoLanCon;
    LstrCodEmp: string ;
    LstrNomEmp: string ;
begin
  strComplemento := '';

  if (Assigned(AcdsParCon.FindField('COMPLEMENTOS'))) and (not fEmptyStr(AcdsParCon.FieldByName('COMPLEMENTOS').AsString)) then
  begin
    objHistLanCon := THistoricoLanCon.Create(AcdsParCon.FieldByName('COMPLEMENTOS').AsString, qryDados,
                                             fPodeAgruparLancamentos(fAjustaTipoLancamento(strTipLan), FblnAgrupaSaiEnt));
    try
      strComplemento := objHistLanCon.getHistorico(FdictControlePortadores);
    finally
      FreeAndNil(objHistLanCon);
    end;
  end
  else
  begin
    if (FUsaCheckListComplemento) and ((not FConSeqParExiste) or (AcdsParCon.FindField('CON_SEQPAR') = nil) or (fEmptyStr(AcdsParCon.FieldByName('CON_SEQPAR').AsString))) then
    begin
      strMD5Key := AcdsParCon.FieldByName('CON_MD5CLA').AsString ;

      objHistLanCon := THistoricoLanCon.Create(fCampoTabela('CAST((GROUP_CONCAT(PAR_COMPLE SEPARATOR "_")) AS CHAR(255))', 'CMPPAR', ['PAR_MD5KEY'], [strMD5Key], False), qryDados,
                                               fPodeAgruparLancamentos(fAjustaTipoLancamento(strTipLan), FblnAgrupaSaiEnt) );
      try
        strComplemento := objHistLanCon.getHistorico(FdictControlePortadores);
      finally
        FreeAndNil(objHistLanCon);
      end;
    end;

    LstrCodEmp := fTrataCodigoEmpresa(qryDados) ;
    LstrNomEmp := fTrataNomeEmpresa(qryDados) ;

    if (fEmptyStr(strComplemento)) then
    Begin
      If SameText(AcdsParCon.FieldByName(strField).AsString, 'N. Docto') Then
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString
      Else If SameText(AcdsParCon.FieldByName(strField).AsString, 'Codigo Bem') Then
        strComplemento := qryDados.FieldByName('CODBEM').AsString
      Else If SameText(AcdsParCon.FieldByName(strField).AsString, 'N. Patrimonio') Then
        strComplemento := qryDados.FieldByName('NUMPAT').AsString
      Else If SameText(AcdsParCon.FieldByName(strField).AsString, 'N. Docto. Nome fornecedor/cliente') Then
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString
      else if SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto/Nome fornec./cliente/Parcela') then
      begin
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString;

        if assigned(qryDados.FindField('PARCEL')) then
          strComplemento := strComplemento + ' / ' + qryDados.FieldByName('PARCEL').AsString;
      end
      else if SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Pgo') then
      begin
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString;

        if not fEmptyStr(LstrNomEmp) then
          strComplemento := strComplemento + ' / ' + LstrNomEmp;

        if not fEmptyStr(LstrCodEmp) then
          strComplemento := strComplemento + ' / ' + LstrCodEmp;

        if assigned(qryDados.FindField('DTAPAG')) then
          strComplemento := strComplemento + ' / ' + FormatDateTime('dd/mm/yyyy', qryDados.FieldByName('DTAPAG').AsDateTime);
      end
      Else If SameText(AcdsParCon.FieldByName(strField).AsString, 'Nome fornecedor/cliente') Then
        strComplemento := qryDados.FieldByName('NOME').AsString
      Else If SameText(AcdsParCon.FieldByName(strField).AsString, 'N. Conhecimento. Nome transportadora') Then
        strComplemento := ''
      Else If (SameText(AcdsParCon.FieldByName(strField).AsString, 'N. Docto. / CNPJ / Nome fornecedor/clien')) Or
              (SameText(AcdsParCon.FieldByName(strField).AsString, 'N. Docto. / CNPJ / Nome fornecedor/cliente')) Then
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('CNPJ').AsString + ' / ' + qryDados.FieldByName('NOME').AsString
      Else If (SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto / Nome fornecedor/cliente / N.Cheque')) Then
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString + ' / ' + 'CHEQUE(S) NÚMERO(S):'+ qryDados.FieldByName('CHQ_NUMCHQ').AsString
      Else If (SameText(AcdsParCon.FieldByName(strField).AsString, 'Histórico da Movimentação')) Then
      Begin
        strComplemento := (qryDados.FieldByName('CTB_HIST01').AsString);
        If Not fEmptyStr(qryDados.FieldByName('CTB_HIST02').AsString) Then
          strComplemento := strComplemento + IIF(Not fEmptyStr(strComplemento), ' - ', '') + qryDados.FieldByName('CTB_HIST02').AsString;
      End
      else if SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Ori') then
      begin
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString;

        if not fEmptyStr(LstrNomEmp) then
          strComplemento := strComplemento + ' / ' + LstrNomEmp;

        if not fEmptyStr(LstrCodEmp) then
          strComplemento := strComplemento + ' / ' + LstrCodEmp;

        if assigned(qryDados.FindField('DTACAD')) and (not qryDados.FieldByName('DTACAD').IsNull) then
          strComplemento := strComplemento + ' / ' + FormatDateTime('dd/mm/yyyy', qryDados.FieldByName('DTACAD').AsDateTime);
      end
      else if SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Rec') then
      begin
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' + qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString;

        if not fEmptyStr(LstrNomEmp) then
          strComplemento := strComplemento + ' / ' + LstrNomEmp;

        if not fEmptyStr(LstrCodEmp) then
          strComplemento := strComplemento + ' / ' + LstrCodEmp;

        if assigned(qryDados.FindField('DTAREC')) and (not qryDados.FieldByName('DTAREC').IsNull) then
          strComplemento := strComplemento + ' / ' + FormatDateTime('dd/mm/yyyy', qryDados.FieldByName('DTAREC').AsDateTime);
      end
      else if SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto / Nome fornecedor/cliente / Hist.Padrão') then
      begin
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' +
                          qryDados.FieldByName('ESPDOC').AsString + ' / ' + qryDados.FieldByName('NOME').AsString;

        if assigned(qryDados.FindField('HIST01')) then
          strComplemento := strComplemento + ' / ' + qryDados.FieldByName('HIST01').AsString;
      end
      else if SameText(AcdsParCon.FieldByName(strField).AsString, 'N.Docto/Histórico da baixa') then
      begin
        strComplemento := fRemoveZerosEsquerda(qryDados.FieldByName('NUMDOC').AsString) + '-' +
                          qryDados.FieldByName('ESPDOC').AsString;
        if Assigned(qryDados.FindField('HISBAI')) then
          strComplemento := strComplemento + ' / ' + qryDados.FieldByName('HISBAI').AsString;
      end;

      if fExibirNoComplementoODocumentoOriginalDoAgrupamento(AcdsParCon.FieldByName(strField).AsString, qryDados.FindField('DOCORI'), qryDados.FindField('ESPORI')) then
      begin
        strComplemento := strComplemento + ' / Doc.Ori: ' + qryDados.FieldByName('DOCORI').AsString;
        if not fEmptyStr(qryDados.FieldByName('ESPORI').AsString) then
          strComplemento := strComplemento + '-' + qryDados.FieldByName('ESPORI').AsString;
      end;
    End;
  end;
end;

procedure TLanConGenerico.pSetaParametrosGravacao(
  recParametrosGravaLanCon: TParametrosGravaLanCon);
begin
  Self.recParametrosGravaLanCon := recParametrosGravaLanCon;
end;

function TLanConGenerico.fValidarHistorico(const AintHisPad: Integer; AstrComple: String): Boolean;
begin
  Result := False ;
  if (AintHisPad = 0) and fEmptyStr(AstrComple) then
    Exit ;
  Result := True ;
end;

function TLanConGenerico.fVerificaVigencia(const ACdsParcon: TUniClientDataSet;
  const ADataLancamento: TDate): Boolean;
var
  LChave: string;
begin
  repeat
    Result := (ACdsParcon.FieldByName('VIGINI').AsDateTime <= ADataLancamento) and (ACdsParcon.FieldByName('VIGFIN').AsDateTime >= ADataLancamento);

    if Result then
      break;

    LChave := fChaveParcon(ACdsParcon);

    ACdsParcon.Next;

  until ACdsParcon.Eof or (LChave <> fChaveParcon(ACdsParcon));
end;

procedure TLanConGenerico.pValidaDiferencaDebitoCredito;
var
  LparDebCred: TPair<string, TLanConControleDebitoCredito> ;
  LobjDados: TDadosImportacaoContabil ;
  LstrOrigem: String ;
  LobjContabilizavel: TContabilizaveis ;
  LlstContasDebCredDuplicadas, LlstDescValorContaDebDup, LlstDescValorContaCreDup : TStringList;
  Lindice, LindiceDeb: Integer;
  LblnTotalDivergente: Boolean;
  LobjControle: TLanConControleDebitoCredito;

begin

  if FdictDiferencaDebitoCredito.Count = 0 then
    Exit ;

  LlstContasDebCredDuplicadas := nil;
  LlstDescValorContaDebDup    := nil;
  LlstDescValorContaCreDup    := nil;
  try
    LlstContasDebCredDuplicadas := TStringList.Create;
    LlstDescValorContaDebDup    := TStringList.Create;
    LlstDescValorContaCreDup    := TStringList.Create;

    for LparDebCred in FdictDiferencaDebitoCredito do
    begin
      LobjControle := LparDebCred.Value ;

      LlstContasDebCredDuplicadas.Clear;
      LlstDescValorContaCreDup.Clear;
      LlstDescValorContaDebDup.Clear;

      for Lindice := 0 to LobjControle.CntCredito.Count - 1 do
      begin
        LindiceDeb := LobjControle.CntDebito.IndexOf(LobjControle.CntCredito[Lindice]) ;
        if LindiceDeb <> -1 then
        begin
          LlstContasDebCredDuplicadas.Add(LobjControle.CntCredito[Lindice]) ;
          LlstDescValorContaCreDup.Add(LobjControle.ValCntCredito[Lindice]) ;
          LlstDescValorContaDebDup.Add(LobjControle.ValCntDebito[LindiceDeb]) ;
        end;
      end;

      LblnTotalDivergente := (fFormataFloat(LparDebCred.Value.Debito, 2) <> fFormataFloat(LparDebCred.Value.Credito, 2));

      if (LblnTotalDivergente) Or (LlstContasDebCredDuplicadas.Count > 0) then
      begin
        LobjDados := LparDebCred.Value.Dados ;
        LstrOrigem := fRetornaOrigemImpMovimento(LobjDados) ;

        LobjContabilizavel := TContabilizaveis.Create;
        LobjContabilizavel.IncDoc := LobjDados.strCtpInc ;

        if LlstContasDebCredDuplicadas.Count > 0 then
        begin
          for Lindice := 0 to LlstContasDebCredDuplicadas.Count - 1 do
          begin
            if LlstDescValorContaCreDup[Lindice] = LlstDescValorContaDebDup[Lindice] then
            begin
              pAdicionarErro(format(CONTABIL_MSG_CONTA_CREDITO_DEBITO_IGUAIS,[LlstContasDebCredDuplicadas[Lindice], LlstContasDebCredDuplicadas[Lindice]]),
                             LstrOrigem,
                             LobjDados.strHistorico,
                             LobjDados.strTipoLancamento,
                             LlstDescValorContaCreDup[Lindice],
                             '',
                             LobjDados.strCtpInc,
                             LobjDados.strTabela,
                             LobjContabilizavel,
                             False,
                             LobjDados.dtaLancamento,
                             LobjDados.strCodigoEmpresa);
            end
            else
            begin
              pAdicionarErro(format(CONTABIL_MSG_CONTA_CREDITO_TEM_REFERENCIA_DEBITO,[LlstContasDebCredDuplicadas[Lindice]]),
                             LstrOrigem,
                             LobjDados.strHistorico,
                             LobjDados.strTipoLancamento,
                             LlstDescValorContaCreDup[Lindice],
                             '',
                             LobjDados.strCtpInc,
                             LobjDados.strTabela,
                             LobjContabilizavel,
                             False,
                             LobjDados.dtaLancamento,
                             LobjDados.strCodigoEmpresa);
              pAdicionarErro(format(CONTABIL_MSG_CONTA_DEBITO_TEM_REFERENCIA_CREDITO,[LlstContasDebCredDuplicadas[Lindice]]),
                             LstrOrigem,
                             LobjDados.strHistorico,
                             LobjDados.strTipoLancamento,
                             LlstDescValorContaDebDup[Lindice],
                             '',
                             LobjDados.strCtpInc,
                             LobjDados.strTabela,
                             LobjContabilizavel,
                             False,
                             LobjDados.dtaLancamento,
                             LobjDados.strCodigoEmpresa);

            end;
          end;
        end;

        if (LblnTotalDivergente) then
        begin
          pAdicionarErro(format(CONTABIL_MSG_TOTDEB_MENOS_TOTCRE_DIFERENTE_ZERO,[FormatCurr('#,##0.00', fFormataFloat(LparDebCred.Value.Debito, 2)), FormatCurr('#,##0.00', fFormataFloat(LparDebCred.Value.Credito, 2))]),
                         LstrOrigem,
                         LobjDados.strHistorico,
                         LobjDados.strTipoLancamento,
                         LobjDados.strDescricaoValor,
                         '',
                         LobjDados.strCtpInc,
                         LobjDados.strTabela,
                         LobjContabilizavel,
                         False,
                         LobjDados.dtaLancamento,
                         LobjDados.strCodigoEmpresa);
        end;

      end ;
    end ;

  finally
    FreeAndNil(LlstContasDebCredDuplicadas);
    FreeAndNil(LlstDescValorContaDebDup);
    FreeAndNil(LlstDescValorContaCreDup);
  end;
end;

procedure TLanConGenerico.pVerificaSeLancouLanCon;
var
  dsWarning : TUniClientDataSet ;
  LstrIndex: string ;
begin

  pValidaDiferencaDebitoCredito ;

  if not blnPreValidar then
  begin

    pEfetuarGravacaoDoLote ;

    if FListaLanConDuplo.Count > 0 then
    begin
      FGravacaoEmLote.pGravarDuplo(FListaLanConDuplo);
      FListaLanConDuplo.Clear;
    end;

    exit ;
  end;

  dsWarning := GetWarnings ;
  LstrIndex := dsWarning.IndexFieldNames ;
  dsWarning.IndexFieldNames := 'ERR_CHVDOC' ;

  qryDados.DisableControls ;
  dsWarning.DisableControls ;
  qryDados.BeforeScroll := nil ;
  try
    qryDados.First ;
    while not qryDados.Eof do
    begin
      if not dsWarning.FindKey([TChaveDocInterprete.New(qryDados).getChave]) then
      begin
        if FlstIncDoc.IndexOf(TChaveDocInterprete.New(qryDados).getChave) = -1 then
        begin
          pAdicionarWarning('Nenhum valor atende aos parâmetros da PARCON!', qryDados);
        end;
      end;
      qryDados.Next ;
    end;
  finally
    qryDados.BeforeScroll := pBeforeScroll ;
    dsWarning.IndexFieldNames := LstrIndex ;
    qryDados.EnableControls ;
    dsWarning.EnableControls ;
  end;

end;

function TLanConGenerico.fSetarConta(strPlaCta: String; strCodEmp: String; strDesVal, strClaFis: string; const AblnRefazerConsultaPorEmpresa: Boolean): TParametroContabil;
var
  LTipoOrigem, LCodigoOrigem: string;
begin
  Result := TParametroContabil.Create;
  Result.strContaCredito := '';
  Result.strContaDebito := '';
  Result.blnDebitoBandeira := False;
  Result.blnCreditoBandeira := False;
  Result.blnDebitoAbreviacao := False;
  Result.blnCreditoAbreviacao := False;

  Result.strTipoLancamento := cdsParCon.FieldByName('CON_TIPLAN').AsString;
  Result.strFormaPagamento := cdsParCon.FieldByName('CON_FORPGO').AsString;
  Result.strNaturezaOperacao := cdsParCon.FieldByName('CON_NATOPE').AsString;
  Result.strDescricaoValor := cdsParCon.FieldByName('CON_DESVAL').AsString;
  Result.strCfop := cdsParCon.FieldByName('CON_CLAFIS').AsString;
  Result.strComplementoDebito := cdsParCon.FieldByName('CON_CMPDEB').AsString;
  //Result.strCodigoHistoricoPadrao := cdsParCon.FieldByName('PAD_CODIGO').AsString;
  //Result.strDescricaoHistoricoPadrao := cdsParCon.FieldByName('PAD_DESCRI').AsString;
  Result.strDescricaoPagamento := cdsParCon.FieldByName('CON_PAGAME').AsString;

  // crédito
  Result.blnCreditoClienteFornecedor := (cdsParCon.FieldByName('CON_CFCRED').AsInteger = 1);
  Result.blnCreditoPlanoContas := (cdsParCon.FieldByName('CON_PCCRED').AsInteger = 1);
  Result.blnCreditoPortador := (cdsParCon.FieldByName('CON_PORCRE').AsInteger = 1);
  Result.strBaixaCadastroCredito := cdsParCon.FieldByName('CON_TIPPCC').AsString;
  if (Assigned(cdsParCon.FindField('CON_BANCRE'))) then
    Result.blnCreditoBandeira := (cdsParCon.FieldByName('CON_BANCRE').AsInteger = 1);
  if (Assigned(cdsParCon.FindField('CON_ABFCRE'))) then
    Result.blnCreditoAbreviacao := (cdsParCon.FieldByName('CON_ABFCRE').AsInteger = 1);

  // débito
  Result.blnDebitoClienteFornecedor := (cdsParCon.FieldByName('CON_CFDEBI').AsInteger = 1);
  Result.blnDebitoPlanoContas := (cdsParCon.FieldByName('CON_PCDEBI').AsInteger = 1);
  Result.blnDebitoPortador := (cdsParCon.FieldByName('CON_PORDEB').AsInteger = 1);
  Result.strBaixaCadastroDebito := cdsParCon.FieldByName('CON_TIPPCD').AsString;
  if (Assigned(cdsParCon.FindField('CON_BANDEB'))) then
    Result.blnDebitoBandeira := (cdsParCon.FieldByName('CON_BANDEB').AsInteger = 1);
  if (Assigned(cdsParCon.FindField('CON_ABFDEB'))) then
    Result.blnDebitoAbreviacao := (cdsParCon.FieldByName('CON_ABFDEB').AsInteger = 1);

  // Conta de Crédito
  LTipoOrigem := EmptyStr;
  LCodigoOrigem := EmptyStr;
  If (Result.blnCreditoClienteFornecedor) Then
  begin
    pRetornaDadosOrigem(opcCliFor, tpcCredito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaCredito := fTrataPlanoContabilClientePorEmpresa(qryDados.FieldByName('PLANCO').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
  end
  Else If (Result.blnCreditoPlanoContas) Then
  Begin
    pRetornaDadosOrigem(opcPlanoContas, tpcCredito, Result.strBaixaCadastroCredito, LTipoOrigem, LCodigoOrigem);
    If (Result.strTipoLancamento = 'CTP') Or
       (Result.strTipoLancamento = 'CTR') Or
       (Result.strTipoLancamento = 'CRC') Then
    Begin
      If (Result.strBaixaCadastroCredito = CONTA_DA_BAIXA) Then
        Result.strContaCredito := strPlaCta
      Else If (Result.strBaixaCadastroCredito = CONTA_DO_CADASTRO) Then
        Result.strContaCredito := fTrataPlanoContabilCadCtaPorEmpresa(qryDados.FieldByName('CODCTA').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
    End
    Else
      Result.strContaCredito := strPlaCta;
  End
  Else If (Result.blnCreditoPortador) Then
  begin
    pRetornaDadosOrigem(opcPortador, tpcCredito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaCredito := fTrataPlanoContabilPortadorPorEmpresa(qryDados.FieldByName('PLAPOR').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
  end
  else if (Result.blnCreditoBandeira) and (Assigned(qryDados.FindField('CONTA_BANDEIRA'))) then
  begin
    pRetornaDadosOrigem(opcBandeira, tpcCredito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaCredito := fTrataPlanoContabilBandeiraPorEmpresa(qryDados.FieldByName('CONTA_BANDEIRA').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
  end
  else if (Result.blnCreditoAbreviacao) and (Assigned(qryDados.FindField('ITE_ABFCON'))) then
  begin
    pRetornaDadosOrigem(opcAbrevProd, tpcCredito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaCredito := FAbrevConRep.getContaCredito(strDesVal, strClaFis, qryDados.FieldByName('ITE_ABFCON').AsString);
  end
  else If (Not fEmptyStr(fContaParametro(cdsParCon.FieldByName('CON_CONCRE').AsString, 'C', strCodEmp))) Then
  begin
    pRetornaDadosOrigem(opcParcon, tpcCredito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaCredito := fContaParametro(cdsParCon.FieldByName('CON_CONCRE').AsString, 'C', strCodEmp) ;
  end;
  Result.strTipoOrigemCredito := LTipoOrigem;
  Result.strCodigoOrigemCredito := LCodigoOrigem;

  // Conta de Débito
  LTipoOrigem := EmptyStr;
  LCodigoOrigem := EmptyStr;
  If (Result.blnDebitoClienteFornecedor) Then
  begin
    pRetornaDadosOrigem(opcCliFor, tpcDebito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaDebito := fTrataPlanoContabilClientePorEmpresa(qryDados.FieldByName('PLANCO').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
  end
  Else If (Result.blnDebitoPlanoContas) Then
  Begin
    pRetornaDadosOrigem(opcPlanoContas, tpcDebito, Result.strBaixaCadastroDebito, LTipoOrigem, LCodigoOrigem);
    If (Result.strTipoLancamento = 'CTP') Or
       (Result.strTipoLancamento = 'CTR') Or
       (Result.strTipoLancamento = 'CRC') Then
    Begin
      If (Result.strBaixaCadastroDebito = CONTA_DA_BAIXA) Then
        Result.strContaDebito := strPlaCta
      Else If (Result.strBaixaCadastroDebito = CONTA_DO_CADASTRO) Then
        Result.strContaDebito := fTrataPlanoContabilCadCtaPorEmpresa(qryDados.FieldByName('CODCTA').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
    End
    Else
      Result.strContaDebito := strPlaCta;
  End
  Else If (Result.blnDebitoPortador) Then
  begin
    pRetornaDadosOrigem(opcPortador, tpcDebito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaDebito := fTrataPlanoContabilPortadorPorEmpresa(qryDados.FieldByName('PLAPOR').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
  end
  else if (Result.blnDebitoBandeira) and (Assigned(qryDados.FindField('CONTA_BANDEIRA'))) then
  begin
    pRetornaDadosOrigem(opcBandeira, tpcDebito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaDebito := fTrataPlanoContabilBandeiraPorEmpresa(qryDados.FieldByName('CONTA_BANDEIRA').AsString, strCodEmp, AblnRefazerConsultaPorEmpresa);
  end
  else if (Result.blnDebitoAbreviacao) and (Assigned(qryDados.FindField('ITE_ABFCON'))) then
  begin
    pRetornaDadosOrigem(opcAbrevProd, tpcDebito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaDebito := FAbrevConRep.getContaDebito(strDesVal, strClaFis, qryDados.FieldByName('ITE_ABFCON').AsString);
  end
  else If Not fEmptyStr(fContaParametro(cdsParCon.FieldByName('CON_CONDEB').AsString, 'D', strCodEmp)) Then
  begin
    pRetornaDadosOrigem(opcParcon, tpcDebito, EmptyStr, LTipoOrigem, LCodigoOrigem);
    Result.strContaDebito := fContaParametro(cdsParCon.FieldByName('CON_CONDEB').AsString, 'D', strCodEmp) ;
  end;
  Result.strTipoOrigemDebito := LTipoOrigem;
  Result.strCodigoOrigemDebito := LCodigoOrigem;
end;

function TLanConGenerico.fDeletaLotInc: boolean;
  Var
    qryDel : TUniQuery;
begin
  If (blnPreValidar) Then
    Exit(True);

  if (not fConfiguracaoExiste('LTCONT')) then
    Exit(True);

  if (not fCfgSis('LTCONT', varBoolean)) then
    Exit(True);

  qryDel := fCriaQuery(Self);
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' DELETE ');
    qryDel.SQL.Add('   FROM LOTINC ');
    qryDel.SQL.Add('  WHERE INC_TIPLAN = :TIPLAN ');
    qryDel.SQL.Add('    AND INC_AUTOMA = 1 ');
    qryDel.SQL.Add('    AND INC_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    If Not fEmptyStr(recParCon.strCodEmp) Then
      qryDel.SQL.Add('  AND INC_EMPLAN = :CODEMP ');

    qryDel.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
    qryDel.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    qryDel.ParamByName('TIPLAN').AsString := strTipLan;

    If Not fEmptyStr(recParCon.strCodEmp) Then
      qryDel.ParamByName('CODEMP').AsString := recParCon.strCodEmp;

    qryDel.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(qryDel);
  End;
end;

function TLanConGenerico.fDescriHisPad(const AstrDescriFallback: string; const inHisCod: Integer; const AstrEmpLan: string): string;
var
  LstrChave, LstrDescri: string;
begin
  if not FblnHisTpl then
  begin
    Result := AstrDescriFallback;
    Exit;
  end;

  LstrChave := inHisCod.ToString + '|' + AstrEmpLan;
  if not FdictPadDescri.TryGetValue(LstrChave, LstrDescri) then
  begin
    LstrDescri := fRetDescHistoricoPadrao(inHisCod.ToString, AstrEmpLan);
    FdictPadDescri.AddOrSetValue(LstrChave, LstrDescri);
  end;

  Result := LstrDescri;
end;

procedure TLanConGenerico.pEfetuarGravacaoDoLote;
begin
  try
    if (FListaLanCon.Count > 0) then
      FGravacaoEmLote.pGravar(FListaLanCon);

    if (FListaSeqLot.Count > 0) then
      FGravacaoEmLote.pGravarSequencialLote(FListaSeqLot);

  finally
    FListaLanCon.Clear;
    FListaSeqLot.Clear;
  end;
end;

procedure TLanConGenerico.pFiltraPelaNaturezaParcon(const AstrNatureza, AstrTipLan, AFiltroVigencia: String);
var
  LstrNatureza: String;
begin
  LstrNatureza := Trim(AstrNatureza);
  cdsParCon.Filtered := False;
  if fUsarDescricaoNatCfo(AstrTipLan, LstrNatureza) then
  begin
    cdsParCon.Filter := AFiltroVigencia + ' AND NAT_DESCRI = ' + QuotedStr(LstrNatureza);
  end
  else
  begin
    cdsParCon.Filter := AFiltroVigencia + ' AND CON_NATCFO = ' + QuotedStr(LstrNatureza);
  end;
  cdsParCon.Filtered := True;
end;

procedure TLanConGenerico.pFinalizacaoDoLote(DataSet: TDataSet);
begin
  if blnPreValidar then
    exit;

  if not DataSet.Active then
    exit;

  if DataSet.IsEmpty then
    exit;

  if FContadorDeLancamentos >= FTamanhoDoLote then
  begin
    FContadorDeLancamentos := 0;
    try
      pEfetuarGravacaoDoLote;
    except
      On E: Exception Do
        pMensagensErro(E.Message + sLineBreak + strTipLan, '[TLanConGenerico.pFinalizacaoDoLote]');
    end;
  end;
end;

{ TGerLanCon }

constructor TGerLanCon.Create(AOwner: TComponent; strTipLan: String;
  recParCon: TParametrosConsulta; pgbProgresso: TcxProgressBar;
  blnPreValidar: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  inherited Create(AOwner);
  Self.strTipLan := strTipLan;
  Self.recParCon := recParCon;
  Self.blnPreValidar := blnPreValidar;
  FblnLancarEmPreValidar := AblnLancarEmPreValidar ;
  objTipLanCon := TLanConFactory.New.fLanCon(strTipLan, recParCon, pgbProgresso);
  objTipLanCon.pSetaPreValidacao(blnPreValidar, objValida, FblnLancarEmPreValidar);
end;

destructor TGerLanCon.Destroy;
begin

  inherited;
end;

function TGerLanCon.GetlistaErros: TUniClientDataSet;
begin
  Result := objTipLanCon.GetListaErros;
end;

function TGerLanCon.fGerarLancamentos(): boolean;

  function fModoRoboCancelamento: boolean;
  begin
    Result := ((recParCon.blnModoRobo) and (recParCon.intModoLancto = MODO_ROBO_3_CANCELAMENTO));
  end;

begin
  pValidaPeriodo;
  result := false;
  If objTipLanCon.fTemParametrosConfigurados Then
  Begin
    result := true;
    If (objTipLanCon.fCarregaDados) Then
    Begin
      If (objTipLanCon.fDeletaLanCon) and (not fModoRoboCancelamento) Then
      begin
        objTipLanCon.fEfetuaLancamentos ;
        objTipLanCon.pVerificaSeLancouLanCon ;

        result := objTipLanCon.fEfetuaLancamentosPreValidacao ;

      end
      Else
      begin
        result := false;
        if not recParCon.blnModoRobo then
          fMensagem('ATENÇÃO!', 'Não foi possível deletar os lançamentos!', ['&OK']);
      end;
    End
    else
      objTipLanCon.fDeletaLanCon;
  End;
end;

procedure TGerLanCon.pMensagemConclusao;
begin
  objTipLanCon.pMensagemConclusao;
end;

procedure TGerLanCon.pValidaPeriodo;
begin
  if Self.recParCon.dtaDtaIni < 0 then
    raise Exception.Create('Data inicial muito antiga!');

  if Self.recParCon.dtaDtaFin < 0 then
    raise Exception.Create('Data final muito antiga!');
end;

end.
