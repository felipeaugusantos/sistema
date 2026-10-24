unit untGarantiaPedidoReposicao;

interface
uses
  System.Generics.Collections, untTypesSistema, UniClientDataSet, cxProgressBar, DAta.DB, Faturamento.Classes.TEmitirPedido, untGarantiaPropriaEmpresaTypes;

type
  TEnviarAutIncPedido = procedure(strAutInc, strNumDoc, strEspDoc: String) Of Object;

Type
  TGarantiaPedidoItem = class;

  TGarantiaPedidoListaItens = TObjectList<TGarantiaPedidoItem>;

  TGarantiaPedido = class
  Private
    FstrTipPed: String;
    FstrEntRet: String;
    FOrigemPedido: TOrigemPedido;
    FLItens: TGarantiaPedidoListaItens;
    FEnviarAutIncPedido: TEnviarAutIncPedido;
    function fGravar(var objEmitirPedido: TEmitirPedido): boolean;

    function fGravarItens(var objEmitirPedido: TEmitirPedido): Boolean;
    procedure pInicializar;
    function fObterTipoEntrega: String;
    function fGravarItem(var objEmitirPedido: TEmitirPedido; aGarantiaPedidoItem: TGarantiaPedidoItem): boolean;
    function fSqlInsertMovGPV(blnIncOri: Boolean): String;
    function fGravarMovGPV(aGarantiaPedidoItem: TGarantiaPedidoItem): Boolean;overload;
    procedure pSetstrTipPed(Value: String);
    procedure pSetstrEntRet(Value: String);
    function SQLDocReferenciados: String;
    function fObterDocReferenciados: String;
    function fMarcarItemPedidoComoReposicaoGarantia(const strIncDor, strTipo: String): Boolean;
    procedure pCalculaTotGerProdutoSelecionado(var objEmitirPedido: TEmitirPedido; strFiltro: String);


  public
  {$Region 'Variáveis'}
    strClaFis: String;
    strCodFis: String;
    pgbStatus: TcxProgressBar;
    strSeqGag: String;
    strAutInc: String;                                                       //Var strAutInc: String;
    strCodEmp: String;                                                       // strCodEmp,
    strNumDoc: String;                                                       // strNumDoc,
    strEspDoc: String;                                                       // strEspDoc,
    strCodCli: String;                                                       // strCodCli,
    strCodVen: String;                                                       // strCodVen,
    strCodTra: String;                                                       // strCodTra,
    strSerie: String;                                                        // strSerie: String;
    dtaDtaEnt: TDateTime;                                                    // dtaDtaEnt,
    dtaHorEnt: TDateTime;                                                    // dtaHorEnt: TDateTime;
    strConPag: String;                                                       // strConPag,
    strEstado: String;                                                       // strEstado,
    strNomCom: String;                                                       // strNomCom,
    strEndCon: String;                                                       // strEndCon,
    strBaiCon: String;                                                       // strBaiCon,
    strCepCon: String;                                                       // strCepCon,
    strCidCon: String;                                                       // strCidCon,
    strEstCon: String;                                                       // strEstCon,
    strCodAti: String;                                                       // strCodAti,
    strTelCon: String;                                                       // strTelCon: String;
    dtaNasCon: TDate;                                                        // dtaNasCon: TDate;
    strCgcCpf: String;                                                       // strCgcCpf,
    strCgcCon: String;                                                       // strCgcCon,
    strIesCon: String;                                                       // strIesCon,
    strCli_Rg: String;                                                       // strCli_Rg: String;
    fltBasSim: Double;                                                       // fltBasSim,
    fltBasIpi: Double;                                                       // fltBasIpi,
    fltAlqIpi: Double;                                                       // fltAlqIpi,
    fltTotIpi: Double;                                                       // fltTotIpi,
    fltBasIcm: Double;                                                       // fltBasIcm,
    fltAlqIcm: Double;                                                       // fltAlqIcm,
    fltTotIcm: Double;                                                       // fltTotIcm,
    fltTotRet: Double;                                                       // fltTotRet,
    fltAlqRet: Double;                                                       // fltAlqRet,
    fltBasRet: Double;                                                       // fltBasRet,
    fltDesEsp: Double;                                                       // fltDesEsp,
    fltVlrCon: Double;                                                       // fltVlrCon,
//    fltTotPro: Double;                                                       // fltTotPro,
    fltTotCus: Double;                                                       // fltTotCus,
    fltTotMed: Double;                                                       // fltTotMed: Double;
    strTipFre: String;                                                       // strTipFre: String;
    fltTotFre: Double;                                                       // fltTotFre,
    fltVPar01: Double;                                                       // fltVPar01,
    fltVPar02: Double;                                                       // fltVPar02,
    fltVPar03: Double;                                                       // fltVPar03,
    fltVPar04: Double;                                                       // fltVPar04,
    fltVPar05: Double;                                                       // fltVPar05,
    fltVPar06: Double;                                                       // fltVPar06,
    fltVPar07: Double;                                                       // fltVPar07,
    fltVPar08: Double;                                                       // fltVPar08,
    fltVPar09: Double;                                                       // fltVPar09,
    fltVPar10: Double;                                                       // fltVPar10,
    fltVPar11: Double;                                                       // fltVPar11,
    fltVPar12: Double;                                                       // fltVPar12,
    fltDesAce: Double;                                                       // fltDesAce,
    fltPesBru: Double;                                                       // fltPesBru,
    fltPesLiq: Double;                                                       // fltPesLiq,
    fltVolume: Double;                                                       // fltVolume: Double;
    arrDuplic: TarrDuplicata;                                                // arrDuplic: TarrDuplicata;
    strEspeci: String;                                                       // strEspeci,
    strMarca: String;                                                        // strMarca,
    strMen001: String;                                                       // strMen001,
    strMen002: String;                                                       // strMen002: String;
    blnJaFatu: Boolean;                                                      // blnJaFatu: Boolean;
    strTipFat: String;                                                       // strTipFat,
    strNumFat: String;                                                       // strNumFat,
    strEmpFat: String;                                                       // strEmpFat: String;
    dtaDtaFat: TDateTime;                                                    // dtaDtaFat: TDateTime;
    strVenFat: String;                                                       // strVenFat,
    strCndFat: String;                                                       // strCndFat: String;
    fltValFat: Double;                                                       // fltValFat,
    fltPorDes: Double;                                                       // fltPorDes: Double;
    strCodDig: String;                                                       // strCodDig,
    strCodCnd: String;                                                       // strCodCnd,
    strCodFpg: String;                                                       // strCodFpg: String;
    recServicos: TDadosServicos;                                             // recServicos: TDadosServicos;
    strConEnt: String;                                                       // strConEnt: String;
    dtaPreVis: TDateTime;                                                    // dtaPreVis: TDateTime;
    fltVPgAnt: Double;                                                       // fltVPgAnt: Double;
    dtaUltAlt: TDateTime;                                                    // dtaUltAlt: TDateTime;
    strNTrava: String;                                                       // strNTrava,
//    strTipPed: String;                                                       // strTipPed: String;
    strCliCtt: String;                                                       // strCliCtt: String;
    intLibera: Integer;                                                      // intLibera: Integer;
    strEntFat: String;                                                       // strEntFat: String;
    fltDesCon: Double;                                                       // fltDesCon: Double;
    strTabPre: String;                                                       // strTabPre,
    strEntFut: String;                                                       // strEntFut: String;
    fltMargem: Double;                                                       // fltMargem: Double;
    strNumPok: String;                                                       // strNumPok: String;
    strEmp_CD: String;                                                       // strEmp_CD: String;
    blnEnt_CD: Boolean;                                                      // blnEnt_CD: Boolean;
    strOprFlj: String;                                                       // strOprFlj,
    strMenExp: String;                                                       // strMenExp,
    strMenEx2: String;                                                       // strMenEx2,
    strMenEx3: String;                                                       // strMenEx3,
    strMenEx4: String;                                                       // strMenEx4: String;
    strNumReg: String;                                                       // strNumReg,
    strPedSit: String;                                                       // strPedSit: String;
    blnPedLib: Boolean;                                                      // blnPedLib: Boolean;
    dtaDtEntr: TDateTime;                                                    // dtaDtEntr: TDateTime;
    strZerTax: String;                                                       // strZerTax,
    strTipOpe: String;                                                       // strTipOpe: String;
    dtaDtaOri: TDateTime;                                                    // dtaDtaOri: TDateTime;
    strTipFin: String;                                                       // strTipFin: String;
    fltDesFin: Double;                                                       // fltDesFin: Double;
    strAutEnt: String;                                                       // strAutEnt,
    strPerEnt: String;                                                       // strPerEnt: String;
    strEmlCon: String;                                                       // strEmlCon: String;
    blnLibCom: Boolean;                                                      // blnLibCom: Boolean;
    strMotLib: String;                                                       // strMotLib: String;
    objFinanc: Pointer;                                                      // objFinanc: Pointer;
    strEmpFor: String;                                                       // strEmpFor,
    strEmp_TE: String;                                                       // strEmp_TE: String;
    dtaHorImp: TDateTime;                                                    // dtaHorImp,
    dtaDtaTra: TDateTime;                                                    // dtaDtaTra,
    dtaHorTra: TDateTime;                                                    // dtaHorTra: TDateTime;
    strIndCom: string;                                                       // strIndCom: string;
    objOcoCrm: Pointer;                                                      // objOcoCrm: Pointer;
    strGerPen: String;                                                       // strGerPen: String;
    fltFatNot: Double;                                                       // fltFatNot,
    fltFreSug: Double;                                                       // fltFreSug: Double;
    strPtNfMn: String;                                                       // strPtNfMn,
    strTFTNes: String;                                                       // strTFTNes: String;
    dtaHPrevi: TDateTime;                                                    // dtaHPrevi: TDateTime;
    strCodCar: String;                                                       // strCodCar: String;
    intQtdPaC: Integer;                                                      // intQtdPaC: Integer;
    strFasObr: String;                                                       // strFasObr: String;
    strEntUrg: String;                                                       // strEntUrg: String;
    strSepImp: String;                                                       // strSepImp: String;
    strCorte_: String;                                                       // strCorte_: String;
    strNumGui: String;                                                       // strNumGui: String = '';
    strOrcOri: String;                                                       // strOrcOri: String = '';
    strCodTpA: String;                                                       // strCodTpA: String = '';
    strPlaVei: String;                                                       // strPlaVei: String = '';
    strKm_Vei: String;                                                       // strKm_Vei: String = '';
    strCodPor: String;                                                       // strCodPor: String = '';
    strRelAba: String;                                                       // strRelAba: String = '';
    blnGravarDavPv: Boolean;                                                 // blnGravarDavPv: Boolean=False;
    blnAlterado: Boolean;                                                    // blnAlterado: Boolean=False;
    dtaImpSep: TDateTime;                                                    // dtaImpSep: TDateTime = 0;
    horImpSep: TDateTime;                                                    // horImpSep: TDateTime = 0;
    strNumPedRefOR: String;                                                  // strNumPedRefOR: String = '';
    strEmpPedRefOR: String;                                                  // strEmpPedRefOR: String = '';
    strLatitu: String;                                                       // strLatitu: String = '';
    strLongit: String;                                                       // strLongit: String = '';
    strRaio__: String;                                                       // strRaio__: String = '';
    objFazenda: Pointer;                                                     // objFazenda: Pointer = nil;
    strEnvLib: String;                                                       // strEnvLib: String = 'S';
    fltFreRat: Double;                                                       // fltFreRat: Double = 0;
    strNumPedAba: String;                                                    // strNumPedAba: String = '';
    strEspPedAba: String;                                                    // strEspPedAba: String = '';
    strEmpPedAba: String;                                                    // strEmpPedAba: String = '';
    strObsL01: String;                                                       // strObsL01: String = '';
    strObsL02: String;                                                       // strObsL02: String = '';
    strVenPre: String;                                                       // strVenPre: String = 'N';
    strTemBri: String;                                                       // strTemBri: String = 'N';
    strEdiPes: String;                                                       // strEdiPes: String = 'N';
    fltTaxEnt: Double;                                                       // fltTaxEnt: Double = 0;
    strCodSup: String;                                                       // strCodSup: String = '';
    strOrcEsp: String;                                                       // strOrcEsp: String = 'N';
    strProspe: String;                                                       // strProspe: String = '';
    strCodOco: String;                                                       // strCodOco: String = '';
    blnImpSfaPag: Boolean;                                                   // blnImpSfaPag: Boolean = False;
    strCodEmbarcacao: String;                                                // strCodEmbarcacao: String = '';
    fltDesOpeGor: Double;                                                    // fltDesOpeGor: Double =0;
    strCliCon: String;                                                       // strCliCon: String = '';
    strInRqCp: String;                                                       // strInRqCp: String = '';
    strOriGor: String;                                                       // strOriGor: String = '';
    strBarCom: String;                                                       // strBarCom: String = '';
    strPD_Exp: String;                                                       // strPD_Exp: String = 'S';
    dtaValOrc: TDateTime;                                                    // dtaValOrc: TDateTime = 0;
    strCodRot: String;                                                       // strCodRot: String = '';
    fltTotBri: Double;                                                       // fltTotBri: Double = 0;
    fltBolAdt: Double;                                                       // fltBolAdt: Double = 0;
    blnBolVen: Boolean;                                                      // blnBolVen: Boolean = False;
    fltTaxJur: Double;                                                       // fltTaxJur: Double = 0;
    strFatTot: String;                                                       // strFatTot: String = 'N';
    strTraRdp: String;                                                       // strTraRdp: String = '';
    strCliLoj: String;                                                       // strCliLoj: String = '';
    strSeqDmp: String;                                                       // strSeqDmp: String = '';
    dtaDtFiCo : TDateTime;                                                   // dtaDtFiCo : TDateTime = 0;
    dtaDtInCo : TDateTime;                                                   // dtaDtInCo : TDateTime = 0;
    dtaDtInSe : TDateTime;                                                   // dtaDtInSe : TDateTime = 0;
    dtaDtBxSe : TDateTime;                                                   // dtaDtBxSe : TDateTime = 0;
    hraHrFiCo : TDateTime;                                                   // hraHrFiCo : TDateTime = 0;
    hraHrInCo : TDateTime;                                                   // hraHrInCo : TDateTime = 0;
    hraHrInSe : TDateTime;                                                   // hraHrInSe : TDateTime = 0;
    hraHrBxSe : TDateTime;                                                   // hraHrBxSe : TDateTime = 0;
    cdsExpRet: TUniClientDataSet;                                            // cdsExpRet: TUniClientDataSet=nil;
    strUsaQue: string;                                                       // strUsaQue: string = 'N';
    strDocQue: string;                                                       // strDocQue: string = '';
    strCodPrj: String;                                                       // strCodPrj: String = '';
    strTpOper: String;                                                       // strTpOper: String = '';
    strNLeads: String;                                                       // strNLeads: String = '';
    strCupDes: String;                                                       // strCupDes: String = '';
    strNotPau: String;                                                       // strNotPau: String = 'S';
    dtaDtCtVn: TDatetime;                                                    // dtaDtCtVn: TDatetime = 0;
    fltVlCtVn: Double;                                                       // fltVlCtVn: Double    = 0;
    strCodCat: String;                                                       // strCodCat: String    = '';
    strMen003: String;                                                       // strMen003: String = '';
    strMen004: String;                                                       // strMen004: String = '';
    strMen005: String;                                                       // strMen005: String = '';
    fltFreMkp: Double;                                                       // fltFreMkp: Double = 0;
    fltComMkp: Double;                                                       // fltComMkp: Double = 0;
    blnDevWms: Boolean;                                                      // blnDevWms: Boolean = False;
    strHisCom: String;                                                       // strHisCom: String = '';
    strCodEve: string;                                                       // strCodEve: string = '';
    dtaDH_Imp: TDateTime;                                                    // dtaDH_Imp: TDateTime = 0;
    strOpBxSe: String;                                                       // strOpBxSe: String = '';
    strOpeLib: String;                                                       // strOpeLib: String = '';
    strDigLib: String;                                                       // strDigLib: String = '';
    dtaHorLib: TDateTime;                                                    // dtaHorLib: TDateTime = 0;
    dtaDtaLib: TDateTime;                                                    // dtaDtaLib: TDateTime = 0;
    blnCortPD: Boolean;                                                      // blnCortPD: Boolean = False;
    blnAbaDep: Boolean;                                                      // blnAbaDep: Boolean = False;
    strNumOrigem: String;                                                    // strNumOrigem: String = '';
    strEspOrigem: String;                                                    // strEspOrigem: String = '';
    strEmpOrigem: String;                                                    // strEmpOrigem: String = '';
    blnLOC_PD: Boolean;                                                      // blnLOC_PD: Boolean = False;
    blnUPSEML: Boolean;                                                      // blnUPSEML: Boolean = False;
    strComplementoFrmLogGor: String;                                         // strComplementoFrmLogGor: String = '';
    ATxIdPix   : String;                                                     // ATxIdPix   : String = '';
    AEmpresaPix: String;                                                     // AEmpresaPix: String = ''): Boolean;

  {$EndRegion}
    constructor Create(Origem: TOrigemPedido);
    Destructor Destroy;override;
    property LItens:TGarantiaPedidoListaItens Read FLItens Write FLItens;
    function fAdicionarItem: TGarantiaPedidoItem;
    function fRemoverItem(aGarantiaPedidoItem: TGarantiaPedidoItem): Integer;
    function fTotalProdutos: Double;
    function fGravarPedido: Boolean;
    function fMarcarItensPedidoComoReposicaoGarantia: Boolean;
    procedure pCarregarCFGs;
    function fGravarMovGPV: Boolean;overload;
    procedure pAtualizaDocReferenciado;
    procedure AtualizaAutIncDor(var objEmitirPedido: TEmitirPedido);
    procedure pSetEnviarAutIncPedido(Metodo: TEnviarAutIncPedido);
    property strTipPed: String Read FstrTipPed Write pSetstrTipPed;
    property strEntRet: String Read FstrEntRet Write pSetstrEntRet;
    property OrigemPedido: TOrigemPedido Read FOrigemPedido;
  public const
    TAG_IDENTIFICACAO: String = ' GARANTIA PEDIDO REPOSICAO CLIENTE ' ;
  end;


  TGarantiaPedidoItem = class
  private
    FPedido: TGarantiaPedido;
    procedure pInicializar;
  public
  {$Region 'Variáveis'}
    strAutInc: String;
    strSeqGad: String;
    strIncOri: String;
    strIdePro: String;
    strCodIte: String;
    strCodMar: String;
    strCodRep: String;
    strCodDiv: String;
    strNumLot: String;
    strDescri: String;
    strRefere: String;
    strUnidad: String;
    strForIte: String;
    strTabPre: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    fltUniDig: Double;
    fltUniVis: Double;
    fltUniOri: Double;
    fltQtdDev: Double;
    fltQtdPre: Double;
    fltQtdDevolvida: Double;
    fltQtdPrejuizo: Double;
    fltQtdApr: Double;
    fltQtdRef: Double;
    fltTotIte: Double;
    strTipRep : String;

  {$EndRegion}
    Constructor Create(aPedido: TGarantiaPedido);
    function fTotalItemAprovado: Double;
    function fTotalItemRefugado: Double;
    property Pedido: TGarantiaPedido Read FPedido;
  end;


implementation
uses
  untFatGor, untGarantiaLibDiversos, untTipoEntregaRetiraExpedicao, untFuncoesSimples, System.SysUtils, Uni, System.strUtils, untGarant;

{ TGarantiaPedidoItem }

constructor TGarantiaPedidoItem.Create(aPedido: TGarantiaPedido);
begin
  FPedido := aPedido;
  pInicializar;
end;

function TGarantiaPedidoItem.fTotalItemAprovado: Double;
begin
  Result := Self.fltUnitar * Self.fltQtdApr;
end;

function TGarantiaPedidoItem.fTotalItemRefugado: Double;
begin
  Result := Self.fltUnitar * Self.fltQtdRef;
end;

procedure TGarantiaPedidoItem.pInicializar;
begin
  strAutInc  := EmptyStr;
  strSeqGad  := EmptyStr;
  strIncOri  := EmptyStr;
  strIdePro  := EmptyStr;
  strCodIte  := EmptyStr;
  strCodMar  := EmptyStr;
  strCodDiv  := EmptyStr;
  strNumLot  := EmptyStr;
  strDescri  := EmptyStr;
  strRefere  := EmptyStr;
  strUnidad  := EmptyStr;
  strForIte  := EmptyStr;
  strTabPre  := EmptyStr;
  fltQtdIte  := 0;
  fltUnitar  := 0;
  fltUniOri  := 0;
  fltQtdDev  := 0;
  fltQtdPre  := 0;
  fltQtdDevolvida := 0;
  fltQtdPrejuizo := 0;
  strTipRep := '0';

end;

{ TGarantiaPedido }

constructor TGarantiaPedido.Create(Origem: TOrigemPedido);
begin
  FLItens := TObjectList<TGarantiaPedidoItem>.Create;
  FOrigemPedido := Origem;
  strMen001 := TAG_IDENTIFICACAO;
  FEnviarAutIncPedido := Nil;
  pInicializar;
end;

destructor TGarantiaPedido.Destroy;
begin
  FreeAndNil(FLItens);
  inherited;
end;

function TGarantiaPedido.fAdicionarItem: TGarantiaPedidoItem;
begin
  Result := FLItens.Items[FLItens.Add(TGarantiaPedidoItem.Create(Self))];
  Result.strAutInc := IntToStr(FLItens.Count);
end;
function TGarantiaPedido.fGravarItem(var objEmitirPedido: TEmitirPedido; aGarantiaPedidoItem: TGarantiaPedidoItem): boolean;
Var
  dadosItem: TDadosProduto;
begin
  dadosItem.dtaDtaPed := aGarantiaPedidoItem.Pedido.dtaDtaEnt;
  dadosItem.strNumLot := aGarantiaPedidoItem.strNumLot;
  dadosItem.strCodIte := aGarantiaPedidoItem.strCodIte;
  dadosItem.strIdePro := aGarantiaPedidoItem.strIdePro;
  dadosItem.strDesIte := aGarantiaPedidoItem.strDescri;
  dadosItem.fltQtdIte := aGarantiaPedidoItem.fltQtdIte;
  dadosItem.strEntRet := aGarantiaPedidoItem.Pedido.strEntRet;
  dadosItem.strMd5Key := '';
  dadosItem.strPromoc := 'N';
  dadosItem.blnBxSbIt := False;
  dadosItem.strCodDiv := '';
  dadosItem.strTabIte := aGarantiaPedidoItem.Pedido.strTabPre;
  dadosItem.strEmpIte := aGarantiaPedidoItem.Pedido.strCodEmp;

  dadosItem.fltUnitar := aGarantiaPedidoItem.fltUnitar;
  dadosItem.fltUniOri := aGarantiaPedidoItem.fltUniOri;
  dadosItem.strClaFis := aGarantiaPedidoItem.Pedido.strClafis;
  Result := objEmitirPedido.fInserirProduto(dadosItem) ;
  If Not Result Then
    Exit;

  Try
    pCalculaTotGerProdutoSelecionado(objEmitirPedido, aGarantiaPedidoItem.strAutInc);
  Except
    On E: Exception Do
    Begin
      Result := False;
    End;
  End;
end;

function TGarantiaPedido.fGravar(var objEmitirPedido: TEmitirPedido) : boolean;
  Var
    dadosPedido: TDadosPedido;

begin

  objEmitirPedido.blnModoRobo := False;

  objEmitirPedido.mmoInformacao := nil;
  objEmitirPedido.lblInformacao := nil;
  objEmitirPedido.pgbProgresso  := nil;

  FillChar(dadosPedido, SizeOf(dadosPedido), #0);

  dadosPedido.blnSfaPag := False;
  dadosPedido.strEmpLogSfa := VS_strCodEmp;
  dadosPedido.strCodCli := Self.strCodCli;
  dadosPedido.strCodVen := Self.strCodVen;
  dadosPedido.strCodDig := Self.strCodVen;
  dadosPedido.strConPag := Self.strConPag;
  dadosPedido.strCodCnd := Self.strCodCnd;
  dadosPedido.strCodFpg := Self.strCodFpg;
  dadosPedido.fltDesEsp := Self.fltDesEsp;
  dadosPedido.strMen001 := Self.strMen001;
  dadosPedido.strMen002 := Self.strMen002;
  dadosPedido.strMenExp := Self.strMenExp;
  dadosPedido.strTipPed := Self.strTipPed;
  dadosPedido.strCodDiv := '';
  dadosPedido.strTipOpe := Self.strTipOpe;
  dadosPedido.strTipFre := Self.strTipFre;
  dadosPedido.strTabPre := Self.strTabPre;
  dadosPedido.strTipFin := Self.strTipFin;
  dadosPedido.strEntFat := Self.strEntFat;
  dadosPedido.strNumPok := Self.strNumPok;
  dadosPedido.fltValFre := Self.fltTotFre;
  dadosPedido.strCodTra := Self.strCodTra;
  dadosPedido.dtaHorImp := 0;
  dadosPedido.dtaDtaTra := 0;
  dadosPedido.dtaHorTra := 0;
  dadosPedido.strCodRot := '';
  dadosPedido.dtaPreVis := VS_Date;
  dadosPedido.dtaGraPed := VS_Date;
  dadosPedido.dtaDtaOri := VS_Date;
  dadosPedido.dtaHorPed := Self.dtaHorEnt;
  dadosPedido.strEspDoc := Self.strEspDoc;
  dadosPedido.strAutEnt := '';
  dadosPedido.strCodTpA := '';
  dadosPedido.strEnvLib := 'S';
  dadosPedido.strEmp_CD := '';
  dadosPedido.blnEnt_CD := False;
  dadosPedido.blnGravarDavPv := False;
  dadosPedido.strClaFis := Self.strClaFis;

  Result := objEmitirPedido.fIniciarPedido(dadosPedido);

  If Result Then
  Begin
    objEmitirPedido.objFatVenda.strEmp_TE      := VS_strCodEmp;
    objEmitirPedido.objFatVenda.blnImprimeDocs := False;
    objEmitirPedido.objFatVenda.blnImprimeSep  := False;
  End;
end;

function TGarantiaPedido.fGravarItens(var objEmitirPedido: TEmitirPedido): Boolean;
Var
  aItem: TGarantiaPedidoItem;
begin
  Result := False;
  for aItem in Self.FLItens do
  begin
    Result := Self.fGravarItem(objEmitirPedido,aItem);
    if Not Result then
      Break;
  end;
end;

function TGarantiaPedido.fGravarMovGPV: Boolean;
Var
  Item: TGarantiaPedidoItem;
begin
  Result := False;
  for Item in Self.FLItens do
  begin
    Result := fGravarMovGPV(Item);
    if Not Result then
      Break;
  end;
end;

function TGarantiaPedido.fGravarPedido: Boolean;
VAr
 objEmitirPedido : TEmitirPedido;
begin
  Try
    objEmitirPedido := TEmitirPedido.Create(Nil);

    Result := fGravar(objEmitirPedido);
    if Result then
      Result := fGravarItens(objEmitirPedido);

    objEmitirPedido.objFatVenda.strEspDoc := Self.strEspDoc;
    Result := objEmitirPedido.fCalcularTotais And objEmitirPedido.fGravarPedido;

    if Result then
    begin
      Self.strAutInc := objEmitirPedido.objFatVenda.strAutIncFatGor;
      Self.strNumDoc := objEmitirPedido.objFatvenda.strNumDoc;
      Self.AtualizaAutIncDor(objEmitirPedido);
      if Assigned(FEnviarAutIncPedido) then
        FEnviarAutIncPedido(Self.strAutInc, self.strNumDoc, self.strEspDoc);
    end;
  Finally
    if Assigned(objEmitirPedido) then
      FreeAndNil(objEmitirPedido);
  End;

end;

function TGarantiaPedido.fMarcarItemPedidoComoReposicaoGarantia(const strIncDor, strTipo: String): Boolean;
  CONST
    SQL_UPDATE: String = ' UPDATE EXTDOR SET FDO_REPGAR = :TIPREP WHERE FDO_SEQFDO = :AUTINC ';
  Var
    Qry: TUniQuery;
begin
  Qry := Nil;
  Result := True;
  Try
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(SQL_UPDATE);
      Qry.ParamByName('AUTINC').AsString := strIncDor;
      Qry.ParamByName('TIPREP').AsString := strTipo;
      Qry.Execute;
    Except
      On E: Exception do
      Begin
        Result := False;
      End;
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TGarantiaPedido.fMarcarItensPedidoComoReposicaoGarantia: Boolean;
Var
  Item: TGarantiaPedidoItem;
begin
  Result := False;
  for Item in Self.FLItens do
  begin
    Result := fMarcarItemPedidoComoReposicaoGarantia(Item.strAutInc, Item.strTipRep);
    if Not Result then
      Break;
  end;
end;

function TGarantiaPedido.fGravarMovGPV(aGarantiaPedidoItem: TGarantiaPedidoItem): Boolean;
Var
  Qry: TUniQuery;
  blnIncOri: Boolean;
begin
  Result := True;
  blnIncOri := Not fEmptyStr(aGarantiaPedidoItem.strIncOri);
  Try
    Qry := fCriaQuery;
    Try
      Qry.Close;
      Qry.Sql.Clear;
      Qry.Sql.Add(fSqlInsertMovGPV(blnIncOri));
      Qry.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVGPV',aGarantiaPedidoItem.Pedido.strCodEmp);
      Qry.ParamByName('GPV_SEQGAD').AsString := aGarantiaPedidoItem.strSeqGad;
      Qry.ParamByName('GPV_SEQFDO').AsString := aGarantiaPedidoItem.strAutInc;
      Qry.ParamByName('GPV_QTDDEV').AsFloat  := aGarantiaPedidoItem.fltQtdDev;
      Qry.ParamByName('GPV_QTDPRE').AsFloat  := aGarantiaPedidoItem.fltQtdpre;
      Qry.ParamByName('GPV_TIPENT').AsString := aGarantiaPedidoItem.Pedido.OrigemPedido.GetAsString;
      if blnIncOri then
        Qry.ParamByName('GPV_INCORI').AsString  := aGarantiaPedidoItem.strIncOri;
      Qry.ExecSql;
    Finally
      FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;


function TGarantiaPedido.fObterDocReferenciados: String;
Var
  Item: TGarantiaPedidoItem;
  strAutInc: String;
  i: Integer;
  strSql : String;
  Qry: TUniQuery;
  fldCHVNFE: TField;
begin
  Result := EmptyStr;
  strAutInc := emptyStr;
  i := 0;

  for item in FLItens do
  begin
    if Not fEmptyStr(Item.strAutInc) then
    begin
      if i = 0 then
      begin
        strAutInc :=  strAutInc + Format('%s',[QuotedStr(Item.strAutInc)]);
        inc(i);
      end
      else
        strAutInc :=  strAutInc + Format(', %s',[QuotedStr(Item.strAutInc)]);
    end;
  end;

  if fEmptyStr(strAutInc) then
    Exit;

  strSql := SQLDocReferenciados;
  strSql := Format(strSql,[strAutInc]);

  Qry := fCriaQuery;
  Try
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSql);
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      fldCHVNFE := qry.FieldByName('FIS_ACESSO');
      Qry.First;
      while Not Qry.Eof do
      begin
        if Not fEmptystr(fldCHVNFE.AsString) then
        begin
          Result := Result + fldCHVNFE.AsString + ',';
        end;
        Qry.Next;
      end;
      Result := ReverseString(Result);
      Result := Copy(Result,2, length(Result));
      Result := ReverseString(Result);
    end;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TGarantiaPedido.fObterTipoEntrega: String;
Var
  objTipoEntregaRetiraExpedicao : TTipoEntregaRetiraExpedicao;
begin
  objTipoEntregaRetiraExpedicao := Nil;
  Result := EmptyStr;
  Try
    objTipoEntregaRetiraExpedicao := TTipoEntregaRetiraExpedicao.Create;
    if objTipoEntregaRetiraExpedicao.fGetTipo <> objTipoEntregaRetiraExpedicao.TODOS then
      Result := objTipoEntregaRetiraExpedicao.fGetTipo
    else
      Result := objTipoEntregaRetiraExpedicao.TODOS;
  Finally
    FreeAndNil(objTipoEntregaRetiraExpedicao);
  End;
end;

function TGarantiaPedido.fRemoverItem(aGarantiaPedidoItem: TGarantiaPedidoItem): Integer;
begin
  Result := FLItens.Remove(aGarantiaPedidoItem);
end;

function TGarantiaPedido.fSqlInsertMovGPV(blnIncOri: Boolean): String;
begin
  Result := ' INSERT INTO MOVGPV (AUTOINCREM, GPV_SEQGAD, GPV_SEQFDO, GPV_QTDDEV, GPV_QTDPRE, GPV_TIPENT, GPV_INCORI) ';
  Result := Result + ' VALUES (:AUTINC, :GPV_SEQGAD, :GPV_SEQFDO, :GPV_QTDDEV, :GPV_QTDPRE, :GPV_TIPENT';

  if blnIncOri then
    Result := Result + ', :GPV_INCORI) '
  else
    Result := Result + ', NULL) ';
end;

function TGarantiaPedido.fTotalProdutos: Double;
Var
  aItem: TGarantiaPedidoItem;
begin
  Result := 0;
  for aItem in FLItens do
    Result := Result + aItem.fltTotIte;
end;

procedure TGarantiaPedido.pAtualizaDocReferenciado;
CONST
  SQL_UPDATE: String = 'UPDATE FATGOR SET FGO_MEN002 = :MSG WHERE AUTOINCREM = :AUTINC ';
Var
  Qry: TUniQuery;
  strMsg: String;
begin
  strMsg := fObterDocReferenciados;
  if fEmptyStr(strMsg) then
    Exit;
  strMsg := Format('Ref. Doc. Envio [%s]',[strMsg]);
  Qry := fCriaQuery;
  Try
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(SQL_UPDATE);
    Qry.ParamByName('MSG').AsString := strMsg;
    Qry.ParamByName('AUTINC').AsString := Self.strAutInc;
    Qry.ExecSql;
  Finally
    FreeAndNil(Qry);
  End;
end;

procedure TGarantiaPedido.pCalculaTotGerProdutoSelecionado(var objEmitirPedido: TEmitirPedido; strFiltro: String);
begin
  objEmitirPedido.objFatVenda.pPreencheMatrizFechamento('AUTOINCREM = ' + strFiltro);
  objEmitirPedido.objFatVenda.pCalculaTotGer(True);
end;

procedure TGarantiaPedido.pCarregarCFGs;
begin
  Self.strTipPed := 'A';
  Self.strEntRet := fObterTipoEntrega;
  Self.strCodCnd  := fRetCodCndAVista;
  Self.strCodFpg  :=  IIF(fEmptyStr(fCfgSis('TMAFPG')), IIF(Not fEmptyStr(fRetConPag('039')),'008','001'), fCfgSis('TMAFPG'));
  Self.strConPag  := '01000';
end;


procedure TGarantiaPedido.pInicializar;
begin
  FLItens.Clear;
  strSeqGag := EmptyStr;
  strAutInc := EmptyStr;                                                   //Var strAutInc: String;
  strCodEmp := EmptyStr;                                                   // strCodEmp,
  strNumDoc := EmptyStr;                                                   // strNumDoc,
  strEspDoc := 'PD';                                                 // strEspDoc,
  strCodCli := EmptyStr;                                                   // strCodCli,
  strCodVen := EmptyStr;                                                   // strCodVen,
  strCodTra := EmptyStr;                                                   // strCodTra,
  strSerie  := EmptyStr;                                                   // strSerie: String;
  dtaDtaEnt := 0;                                                    // dtaDtaEnt,
  dtaHorEnt := 0;                                                    // dtaHorEnt: TDateTime;
  strConPag := EmptyStr;                                                   // strConPag,
  strEstado := EmptyStr;                                                   // strEstado,
  strNomCom := EmptyStr;                                                   // strNomCom,
  strEndCon := EmptyStr;                                                   // strEndCon,
  strBaiCon := EmptyStr;                                                   // strBaiCon,
  strCepCon := EmptyStr;                                                   // strCepCon,
  strCidCon := EmptyStr;                                                   // strCidCon,
  strEstCon := EmptyStr;                                                   // strEstCon,
  strCodAti := EmptyStr;                                                   // strCodAti,
  strTelCon := EmptyStr;                                                   // strTelCon: String;
  dtaNasCon := 0;                                                    // dtaNasCon: TDate;
  strCgcCpf := EmptyStr;                                                   // strCgcCpf,
  strCgcCon := EmptyStr;                                                   // strCgcCon,
  strIesCon := EmptyStr;                                                   // strIesCon,
  strCli_Rg := EmptyStr;                                                   // strCli_Rg: String;
  fltBasSim := 0;                                                    // fltBasSim,
  fltBasIpi := 0;                                                    // fltBasIpi,
  fltAlqIpi := 0;                                                    // fltAlqIpi,
  fltTotIpi := 0;                                                    // fltTotIpi,
  fltBasIcm := 0;                                                    // fltBasIcm,
  fltAlqIcm := 0;                                                    // fltAlqIcm,
  fltTotIcm := 0;                                                    // fltTotIcm,
  fltTotRet := 0;                                                    // fltTotRet,
  fltAlqRet := 0;                                                    // fltAlqRet,
  fltBasRet := 0;                                                    // fltBasRet,
  fltDesEsp := 0;                                                    // fltDesEsp,
  fltVlrCon := 0;                                                    // fltVlrCon,
//  fltTotPro := 0;                                                    // fltTotPro,
  fltTotCus := 0;                                                    // fltTotCus,
  fltTotMed := 0;                                                    // fltTotMed: Double;
  strTipFre := EmptyStr;                                             // strTipFre: String;
  fltTotFre := 0;                                                    // fltTotFre,
  fltVPar01 := 0;                                                    // fltVPar01,
  fltVPar02 := 0;                                                    // fltVPar02,
  fltVPar03 := 0;                                                    // fltVPar03,
  fltVPar04 := 0;                                                    // fltVPar04,
  fltVPar05 := 0;                                                    // fltVPar05,
  fltVPar06 := 0;                                                    // fltVPar06,
  fltVPar07 := 0;                                                    // fltVPar07,
  fltVPar08 := 0;                                                    // fltVPar08,
  fltVPar09 := 0;                                                    // fltVPar09,
  fltVPar10 := 0;                                                    // fltVPar10,
  fltVPar11 := 0;                                                    // fltVPar11,
  fltVPar12 := 0;                                                    // fltVPar12,
  fltDesAce := 0;                                                    // fltDesAce,
  fltPesBru := 0;                                                    // fltPesBru,
  fltPesLiq := 0;                                                    // fltPesLiq,
  fltVolume := 0;                                                    // fltVolume: Double;
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);                       // arrDuplic: TarrDuplicata;
  strEspeci := EmptyStr;                                             // strEspeci,
  strMarca  := EmptyStr;                                             // strMarca,
  strMen001 := EmptyStr;                                             // strMen001,
  strMen002 := EmptyStr;                                             // strMen002: String;
  blnJaFatu := False;                                                // blnJaFatu: Boolean;
  strTipFat := EmptyStr;                                             // strTipFat,
  strNumFat := EmptyStr;                                             // strNumFat,
  strEmpFat := EmptyStr;                                             // strEmpFat: String;
  dtaDtaFat := 0;                                                    // dtaDtaFat: TDateTime;
  strVenFat := EmptyStr;                                             // strVenFat,
  strCndFat := EmptyStr;                                             // strCndFat: String;
  fltValFat := 0;                                                    // fltValFat,
  fltPorDes := 0;                                                    // fltPorDes: Double;
  strCodDig := EmptyStr;                                             // strCodDig,
  strCodCnd := EmptyStr;                                             // strCodCnd,
  strCodFpg := EmptyStr;                                             // strCodFpg: String;
//  recServicos: TDadosServicos;                                     // recServicos: TDadosServicos;
  strConEnt := EmptyStr;                                             // strConEnt: String;
  dtaPreVis := 0;                                                    // dtaPreVis: TDateTime;
  fltVPgAnt := 0;                                                    // fltVPgAnt: Double;
  dtaUltAlt := 0;                                                    // dtaUltAlt: TDateTime;
  strNTrava := EmptyStr;                                             // strNTrava,
  strTipPed := EmptyStr;                                             // strTipPed: String;
  strCliCtt := EmptyStr;                                             // strCliCtt: String;
  intLibera := 0;                                                    // intLibera: Integer;
  strEntFat := 'S';                                                  // strEntFat: String;
  fltDesCon := 0;                                                    // fltDesCon: Double;
  strTabPre := '1';                                                  // strTabPre,
  strEntFut := EmptyStr;                                             // strEntFut: String;
  fltMargem := 0;                                                    // fltMargem: Double;
  strNumPok := EmptyStr;                                             // strNumPok: String;
  strEmp_CD := EmptyStr;                                             // strEmp_CD: String;
  blnEnt_CD := False;                                                  // blnEnt_CD: Boolean;
  strOprFlj := EmptyStr;                                             // strOprFlj,
  strMenExp := EmptyStr;                                             // strMenExp,
  strMenEx2 := EmptyStr;                                             // strMenEx2,
  strMenEx3 := EmptyStr;                                             // strMenEx3,
  strMenEx4 := EmptyStr;                                             // strMenEx4: String;
  strNumReg := EmptyStr;                                             // strNumReg,
  strPedSit := EmptyStr;                                             // strPedSit: String;
  blnPedLib := False;                                                // blnPedLib: Boolean;
  dtaDtEntr := 0;                                                    // dtaDtEntr: TDateTime;
  strZerTax := 'N';                                                  // strZerTax,
  strTipOpe := 'V';                                                  // strTipOpe: String;
  dtaDtaOri := 0;                                                    // dtaDtaOri: TDateTime;
  strTipFin := EmptyStr;                                             // strTipFin: String;
  fltDesFin := 0;                                                    // fltDesFin: Double;
  strAutEnt := EmptyStr;                                             // strAutEnt,
  strPerEnt := EmptyStr;                                             // strPerEnt: String;
  strEmlCon := EmptyStr;                                             // strEmlCon: String;
  blnLibCom := False;                                                // blnLibCom: Boolean;
  strMotLib := EmptyStr;                                             // strMotLib: String;
  objFinanc := Nil;                                                  // objFinanc: Pointer;
  strEmpFor := EmptyStr;                                             // strEmpFor,
  strEmp_TE := EmptyStr;                                             // strEmp_TE: String;
  dtaHorImp := 0;                                                    // dtaHorImp,
  dtaDtaTra := 0;                                                    // dtaDtaTra,
  dtaHorTra := 0;                                                    // dtaHorTra: TDateTime;
  strIndCom := EmptyStr;                                             // strIndCom: string;
  objOcoCrm := Nil;                                                  // objOcoCrm: Pointer;
  strGerPen := EmptyStr;                                             // strGerPen: String;
  fltFatNot := 0;                                                    // fltFatNot,
  fltFreSug := 0;                                                    // fltFreSug: Double;
  strPtNfMn := EmptyStr;                                             // strPtNfMn,
  strTFTNes := EmptyStr;                                             // strTFTNes: String;
  dtaHPrevi := 0;                                                    // dtaHPrevi: TDateTime;
  strCodCar := EmptyStr;                                             // strCodCar: String;
  intQtdPaC := 0;                                                    // intQtdPaC: Integer;
  strFasObr := EmptyStr;                                             // strFasObr: String;
  strEntUrg := '0';                                                  // strEntUrg: String;
  strSepImp := 'N';                                                  // strSepImp: String;
  strCorte_ := 'N';                                                  // strCorte_: String;
  strNumGui := EmptyStr;     //VALORES DEFAULT FUNCAO                      // strNumGui: String = '';
  strOrcOri := EmptyStr;                                                   // strOrcOri: String = '';
  strCodTpA := EmptyStr;                                                   // strCodTpA: String = '';
  strPlaVei := EmptyStr;                                                   // strPlaVei: String = '';
  strKm_Vei := EmptyStr;                                                   // strKm_Vei: String = '';
  strCodPor := EmptyStr;                                                   // strCodPor: String = '';
  strRelAba := EmptyStr;                                                   // strRelAba: String = '';
  blnGravarDavPv := False;                                           // blnGravarDavPv: Boolean=False;
  blnAlterado := False;                                              // blnAlterado: Boolean=False;
  dtaImpSep := 0;                                                    // dtaImpSep: TDateTime = 0;
  horImpSep := 0;                                                    // horImpSep: TDateTime = 0;
  strNumPedRefOR := EmptyStr;                                              // strNumPedRefOR: String = '';
  strEmpPedRefOR := EmptyStr;                                              // strEmpPedRefOR: String = '';
  strLatitu := EmptyStr;                                                   // strLatitu: String = '';
  strLongit := EmptyStr;                                                   // strLongit: String = '';
  strRaio__ := EmptyStr;                                                   // strRaio__: String = '';
  objFazenda := nil;                                                 // objFazenda: Pointer = nil;
  strEnvLib := 'S';                                                  // strEnvLib: String = 'S';
  fltFreRat := 0;                                                    // fltFreRat: Double = 0;
  strNumPedAba := EmptyStr;                                                // strNumPedAba: String = '';
  strEspPedAba := EmptyStr;                                                // strEspPedAba: String = '';
  strEmpPedAba := EmptyStr;                                                // strEmpPedAba: String = '';
  strObsL01 := EmptyStr;                                                   // strObsL01: String = '';
  strObsL02 := EmptyStr;                                                   // strObsL02: String = '';
  strVenPre := 'N';                                                  // strVenPre: String = 'N';
  strTemBri := 'N';                                                  // strTemBri: String = 'N';
  strEdiPes := 'N';                                                  // strEdiPes: String = 'N';
  fltTaxEnt := 0;                                                    // fltTaxEnt: Double = 0;
  strCodSup := EmptyStr;                                                   // strCodSup: String = '';
  strOrcEsp := 'N';                                                  // strOrcEsp: String = 'N';
  strProspe := EmptyStr;                                                   // strProspe: String = '';
  strCodOco := EmptyStr;                                                   // strCodOco: String = '';
  blnImpSfaPag := False;                                             // blnImpSfaPag: Boolean = False;
  strCodEmbarcacao := EmptyStr;                                            // strCodEmbarcacao: String = '';
  fltDesOpeGor := 0;                                                 // fltDesOpeGor: Double =0;
  strCliCon := EmptyStr;                                                   // strCliCon: String = '';
  strInRqCp := EmptyStr;                                                   // strInRqCp: String = '';
  strOriGor := EmptyStr;                                                   // strOriGor: String = '';
  strBarCom := EmptyStr;                                                   // strBarCom: String = '';
  strPD_Exp := 'S';                                                  // strPD_Exp: String = 'S';
  dtaValOrc := 0;                                                    // dtaValOrc: TDateTime = 0;
  strCodRot := EmptyStr;                                                   // strCodRot: String = '';
  fltTotBri := 0;                                                    // fltTotBri: Double = 0;
  fltBolAdt := 0;                                                    // fltBolAdt: Double = 0;
  blnBolVen := False;                                                // blnBolVen: Boolean = False;
  fltTaxJur := 0;                                                    // fltTaxJur: Double = 0;
  strFatTot := 'N';                                                  // strFatTot: String = 'N';
  strTraRdp := EmptyStr;                                                   // strTraRdp: String = '';
  strCliLoj := EmptyStr;                                                   // strCliLoj: String = '';
  strSeqDmp := EmptyStr;                                                   // strSeqDmp: String = '';
  dtaDtFiCo := 0;                                                    // dtaDtFiCo : TDateTime = 0;
  dtaDtInCo := 0;                                                    // dtaDtInCo : TDateTime = 0;
  dtaDtInSe := 0;                                                    // dtaDtInSe : TDateTime = 0;
  dtaDtBxSe := 0;                                                    // dtaDtBxSe : TDateTime = 0;
  hraHrFiCo := 0;                                                    // hraHrFiCo : TDateTime = 0;
  hraHrInCo := 0;                                                    // hraHrInCo : TDateTime = 0;
  hraHrInSe := 0;                                                    // hraHrInSe : TDateTime = 0;
  hraHrBxSe := 0;                                                    // hraHrBxSe : TDateTime = 0;
  cdsExpRet := nil;                                                  // cdsExpRet: TUniClientDataSet=nil;
  strUsaQue := 'N';                                                  // strUsaQue: string = 'N';
  strDocQue := EmptyStr;                                                   // strDocQue: string = '';
  strCodPrj := EmptyStr;                                                   // strCodPrj: String = '';
  strTpOper := EmptyStr;                                                   // strTpOper: String = '';
  strNLeads := EmptyStr;                                                   // strNLeads: String = '';
  strCupDes := EmptyStr;                                                   // strCupDes: String = '';
  strNotPau := 'S';                                                  // strNotPau: String = 'S';
  dtaDtCtVn := 0;                                                    // dtaDtCtVn: TDatetime = 0;
  fltVlCtVn := 0;                                                    // fltVlCtVn: Double    = 0;
  strCodCat := EmptyStr;                                                   // strCodCat: String    = '';
  strMen003 := EmptyStr;                                                   // strMen003: String = '';
  strMen004 := EmptyStr;                                                   // strMen004: String = '';
  strMen005 := EmptyStr;                                                   // strMen005: String = '';
  fltFreMkp := 0;                                                    // fltFreMkp: Double = 0;
  fltComMkp := 0;                                                    // fltComMkp: Double = 0;
  blnDevWms := False;                                                // blnDevWms: Boolean = False;
  strHisCom := EmptyStr;                                                   // strHisCom: String = '';
  strCodEve := EmptyStr;                                                   // strCodEve: string = '';
  dtaDH_Imp := 0;                                                    // dtaDH_Imp: TDateTime = 0;
  strOpBxSe := EmptyStr;                                                   // strOpBxSe: String = '';
  strOpeLib := EmptyStr;                                                   // strOpeLib: String = '';
  strDigLib := EmptyStr;                                                   // strDigLib: String = '';
  dtaHorLib := 0;                                                    // dtaHorLib: TDateTime = 0;
  dtaDtaLib := 0;                                                    // dtaDtaLib: TDateTime = 0;
  blnCortPD := False;                                                // blnCortPD: Boolean = False;
  blnAbaDep := False;                                                // blnAbaDep: Boolean = False;
  strNumOrigem := EmptyStr;                                                // strNumOrigem: String = '';
  strEspOrigem := EmptyStr;                                                // strEspOrigem: String = '';
  strEmpOrigem := EmptyStr;                                                // strEmpOrigem: String = '';
  blnLOC_PD := False;                                                // blnLOC_PD: Boolean = False;
  blnUPSEML := False;                                                // blnUPSEML: Boolean = False;
  strComplementoFrmLogGor := EmptyStr;                                     // strComplementoFrmLogGor: String = '';
  ATxIdPix := EmptyStr;                                                    // ATxIdPix   : String = '';
  AEmpresaPix := EmptyStr;                                                 // AEmpresaPix: String = ''): Boolean;
  strEntRet := EmptyStr;
  strClaFis := EmptyStr;
  strCodFis := EmptyStr;

end;

procedure TGarantiaPedido.pSetEnviarAutIncPedido(Metodo: TEnviarAutIncPedido);
begin
  FEnviarAutIncPedido := Metodo;
end;

procedure TGarantiaPedido.pSetstrEntRet(Value: String);
begin
  if fEmptyStr(Value) then
    FstrEntRet := 'S'
  else
    FstrEntRet := Value;
end;

procedure TGarantiaPedido.pSetstrTipPed(Value: String);
begin
  if fEmptyStr(Value) then
    FstrTipPed := 'B'
  else
    FstrTipPed := Value;
end;



procedure TGarantiaPedido.AtualizaAutIncDor(var objEmitirPedido: TEmitirPedido);
Var
  Item : TGarantiaPedidoItem;
  i: Integer;
begin
  for i := Low(objEmitirPedido.objFatVenda.arrMatItens) to High(objEmitirPedido.objFatVenda.arrMatItens) do
  begin
    for Item in FLItens do
    begin
      if (item.strAutInc = objEmitirPedido.objFatVenda.arrMatItens[i].strAutIncAnt) then
      begin
        item.strAutInc := objEmitirPedido.objFatVenda.arrMatItens[i].strAutoincrementoGravacao;
        Break;
      end;
    end;
  end;
end;

function TGarantiaPedido.SQLDocReferenciados: String;
begin
  Result := Result + ' SELECT DISTINCT F.FIS_ACESSO ';
  Result := Result + ' FROM MOVGPV P ';
  Result := Result + ' JOIN MOVGAD D ON D.AUTOINCREM = P.GPV_SEQGAD ';
  Result := Result + ' JOIN MOVGRC C ON C.GRC_SEQGAD = D.AUTOINCREM ';
  Result := Result + ' JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_SEQDET ';
  Result := Result + ' JOIN CADFIS F ON F.FIS_NUMDOC = D2.DET_NUMDOC AND F.FIS_SERIE_ = D2.DET_SERIE_ AND FIS_FORCLI = D2.DET_CODCLI ';
  Result := Result + ' WHERE P.GPV_SEQFDO IN (%s) ';
end;


end.
































































































































































































