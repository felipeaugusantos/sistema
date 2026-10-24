unit untTPreparaPedidosCotacao;

interface

uses Forms,SysUtils, strUtils, Classes, untZClient, UniClientDataSet, untGravando,
     cxProgressBar, untDuplicatasPedidoCompra, untTypesSistema, uni, Math,
     untFuncoesPedidoSimples, Cotacao.ProcessaApi,
     PitStop.Comunicacao, Cotacao.ApiPrecos.ConstAndTypes, PitStop.Classes.EndPoint;

type

  TGetCodForToIndex = function (strCodFor: String): Integer of object;


  TSetDadosCompraEmbalagem =  function(Const strCodIte: String; Var strCodUni: String; Var strSigUni: String; Var fltEmbala: Double): Boolean of object;
  TInsertPCMIRQ = procedure (strAutIncPcd, strCodIte: String) of object;
  TCopiaCadInt = procedure (strCodGirOriginal, strSeqGerNovo: String; strNomFrm: string) of object;





  TGetCodCta = function (strCodFor: String): String of object;

  TReCotGer = Record
    strDesCri: String;
    strCompra: String;
    strMesAtu: String;
    intMesGir: Integer;
    strMesSel: String;
    intMesMos: Integer;
    strNovIpi: String;
  End;

  TRecTotGerFornecedor = record
    index: integer;
    Fornecedor: string;
    fltValTot: Double;
  End;

  TarrTotGerFornecedor =  array of TRecTotGerFornecedor;

  TRecObserv = Record
    blnEndLoj,
    blnDesmen: Boolean;
    strNomEmp,
    strEndere,
    strCidade,
    strCodTra,
    strCodTraRedespacho,
    strObs001,
    strObs002,
    strObs003,
    strTipFre,
    strTipFreRedespacho,
    strObsPd1,
    strObsPd2,
    strObsPd3,
    strPedVen,
    strAtenca,
    strCodEve,
    strCodCta: String;
    fltValFre,
    fltDesAce: Double;
    blnAltFrete: Boolean;
  End;

  TPcddet = record
    strEmpDes: String;
    fltQtdIte: Double;
  end;

  TArrPcddet = array of TPcddet;


  TPcmDet = record
    index: integer;
    item: String;
    strCodUni: String;
    strSigUni: String;
    strDesIte: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    fltPerIPI: Double;
    fltPerFre: Double;
    fltPerSub: Double;
    fltPerFCP: Double;
    fltValIPI: Double;
    fltValSub: Double;
    fltValFre: Double;
    fltValFCP: Double;
    fltTotIte: Double;
    fltIpiEnt: Double;
    fltTotIPI: Double;
    fltSubsti: Double;
    fltTotSub: Double;
    fltFreEnt: Double;
    fltTotFre: Double;

    fltSubFCP: Double;
    fltDesAce: Double;

    fltBasSub: Double;
    fltBasIPI: Double;
    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;
    fltDesPis: Double;
    fltAlqCbs: Double;
    fltAlqIbs: Double;
    fltAlq_Is: Double;
    fltValCbs: Double;
    fltValIbs: Double;
    fltVal_Is: Double;
    blnIncidePis: Boolean;
    Pcddet: TArrPcddet;
    procedure iniciaDet;
  End;

  TArrPcmDet = array of TPcmDet;

  TPcmDetItems = record
    Itens: TArrPcmDet;
    procedure AddItem(PcmDet: TPcmDet);
  End;


  TPcmGer = record
    index: integer;
    indexFornecedor: integer;
    Fornecedor: String;
    Empresa: String;
    strConPag: String;
    strNumPed: String;
    PcmDetItems: TPcmDetItems;
    fltTotIPI: Double;
    fltTotSub: Double;
    fltTotFCP: Double;
    fltSubFCP: Double;
    fltIcmDes: Double;
    fltTotIte: Double;
    fltTotGer: Double;
    fltTotFre: Double;
    fltBasCof: Double;
    fltValCof: Double;
    fltBasPis: Double;
    fltValPis: Double;
    fltBasIcm: Double;
    fltValIcm: Double;
    fltDesPis: Double;
    fltBasIpi: Double;
    fltBasSub: Double;
    fltTotAce: Double;
    fltValCbs: Double;
    fltValIbs: Double;
    fltVal_Is: Double;
    dtaDtaEnt: TDate;
    dtaDtaPed: TDate;
    horHorPed: TDateTime;
    recObserv: TRecObserv;
    blnUsaColeta: Boolean;
    StatusPitStopCotacao: TStatusPitStopCotacao;
  End;

  TArrPcmGer = array of TPcmGer;

  TPreparaPedidosCotacao = class
  private
    FcdsFornecedores: TZClient;
    FcdsItens: TZClient;
    FcdsItensMultiLojas: TUniClientDataSet;
    frmPraparaPedido: TFrmGravando;
    Pedidos : TArrPcmGer;
    FGetCodForToIndex: TGetCodForToIndex;
    blnControlaColetaCompra: Boolean;
    FFilter: String;
    fltAlqPis: Double;
    fltAlqCof: Double;
    FblnConverterEmbalagens: Boolean;
    FSetDadosCompraEmbalagem: TSetDadosCompraEmbalagem;
    FobjDuplicatasPedido: TDuplicatasPedidoCompra;
    FRecObserv: TRecObserv;
    FGetCodCta: TGetCodCta;
    FArrCodCta: TarrCodCtaFornec;
    qryEmpresa: TUniQuery;
    FstrMulLoj: String;
    FNumCot: String;
    FEmpCot: String;
    FrecDadGiro: TRecOpcoesGiro;
    FfltValFreRes: Double;
    FfltDesAceRes: Double;
    fltALPISP: Double;
    fltALCOFP: Double;
    FProcIncluiPcmIrq: TInsertPCMIRQ;
    blnLibPcm: Boolean;
    strForFil: String;
    intDeqTpc: Integer;
    qryInsert: TUniQuery;
    blnRefPed: Boolean;

    blnCdsMltLojaFilteredInicial: Boolean;
    strCdsMltLojaFilterInicial: string;
    blnCdsItensFilteredInicial: Boolean;
    strCdsItensFilterInicial: string;

    blnCdsMltLojaDisabled: Boolean;
    blnCdsItensDisabled: Boolean;
    FPedidosGerados: String;
    FComprador: String;
    arrTotGerFornecedor: TarrTotGerFornecedor;
    FItensGerados: TStringList;
    FEmpDes: String;
    FCopiaCadInt: TCopiaCadInt;
    FCodGirOriginal: String;
    FRedePitStop: TRedePitStop;
    FFuncFaturaRedePitStop: TFuncFaturaRedePitStop;
    function fLocalizaPedido(AFornecedor, AEmpresa: String): integer;
    function fLocalizaTotFornec(AFornecedor: String): integer;

    function fPreparaPedidos(pgbProgresso: TcxProgressBar): Boolean;
    Procedure pProcessaValoresComum(AblnConverterEmbalagem: Boolean; AfltEmbala: Double; AIndexPedido: Integer; var APcmDet: TPcmdet);
    Procedure pProcessaValoresTotais(AblnIncPis: Boolean; AIndexTotFornec: Integer;AIndexPedido: Integer;APcmDet: TPcmdet);
    procedure pCalculaImpostosReformaPcmDet(var APcmDet: TPcmDet);


    procedure pRecalculaFrete_e_despesas(pgbProgresso: TcxProgressBar);

    function fGetTotIteFornecedor(AFornecedor: String): Double;
    function fGeraPedidosDeCompra(pgbProgresso: TcxProgressBar): Boolean;

    function fAddTotFornecPedido(AFornecedor: String): integer;
    function fAddPedido(AFornecedor, AEmpresa: String): integer;
    Function fIndice(AContador: Integer): String;
    procedure pAjustaFilterEOrdem;
    procedure pRetornaAjustaFilterEOrdem;
    procedure pPosicionaCdsMultiLojas(AItem: String);
    procedure pProcessaDesmembramento(AItemAtual: string; AIndexTotFornec: Integer; AForEsc: String; AConverterEmbalagem,AIncPis: Boolean; AEmbala: Double;  var APcmDet: TPcmDet);
    procedure pProcessaSemDesmebrar(AItemAtual: string; AIndexTotFornec: Integer; AForEsc: String; AConverterEmbalagem,AIncPis: Boolean; AEmbala: Double;  var APcmDet: TPcmDet);
    procedure pProcessaCotacaoSimples(AItemAtual: string; AIndexTotFornec: Integer; AForEsc: String; AConverterEmbalagem,AIncPis: Boolean; AEmbala: Double;  var APcmDet: TPcmDet);





  public
    Constructor Create(ANumCot:String;
                       AEmpCot:String;
                       AEmpDes: String;
                       AComprador: String;
                       ACodGirOriginal: String;
                       ArecDadGiro: TRecOpcoesGiro;
                       AcdsFornecedores, AcdsItens: TZClient; AcdsItensMultiLojas: TUniClientDataSet;
                       AFilter: string;
                       AfuncGetCodForToIndex: TGetCodForToIndex;
                       AprocSetDadosCompraEmbalagem: TSetDadosCompraEmbalagem;
                       AProcIncluiPcmIrq: TInsertPCMIRQ;
                       AblnConverterEmbalagens: Boolean;
                       ARecObserv: TRecObserv;
                       AArrCodCta: TarrCodCtaFornec;
                       AProcGetCodCta: TGetCodCta;
                       AobjDuplicatasPedido:TDuplicatasPedidoCompra;
                       AstrMulLoj: String;
                       AfltValFreRes: Double;
                       AfltDesAceRes: Double;
                       AItensGerados: TStringList;
                       ACopiaCadInt: TCopiaCadInt;
                       ARedePitStop: TRedePitStop = nil;
                       AFuncFaturaRedePitStop: TFuncFaturaRedePitStop = nil);
    destructor Destroy; Override;
    function fProcessa_e_insere: Boolean;
    property PedidosGerados: String read FPedidosGerados;
  End;


implementation

uses untFuncoesSimples, untGravacaoPedido, untConstantes, untSaldoPedidoCompra, untImpostosReformaCompra,
     untTMontaSQLPedidoCompra, untInicializaDllPedido;

{ TPreparaPedidosCotacao }

constructor TPreparaPedidosCotacao.Create(ANumCot:String;
                                          AEmpCot:String;
                                          AEmpDes: String;
                                          AComprador: String;
                                          ACodGirOriginal: String;
                                          ArecDadGiro: TRecOpcoesGiro;
                                          AcdsFornecedores, AcdsItens: TZClient; AcdsItensMultiLojas: TUniClientDataSet;
                                          AFilter: string;
                                          AfuncGetCodForToIndex: TGetCodForToIndex;
                                          AprocSetDadosCompraEmbalagem: TSetDadosCompraEmbalagem;
                                          AProcIncluiPcmIrq: TInsertPCMIRQ;
                                          AblnConverterEmbalagens: Boolean;
                                          ARecObserv: TRecObserv;
                                          AArrCodCta: TarrCodCtaFornec;
                                          AProcGetCodCta: TGetCodCta;
                                          AobjDuplicatasPedido:TDuplicatasPedidoCompra;
                                          AstrMulLoj: String;
                                          AfltValFreRes: Double;
                                          AfltDesAceRes: Double;
                                          AItensGerados: TStringList;
                                          ACopiaCadInt: TCopiaCadInt;
                                          ARedePitStop: TRedePitStop = nil;
                                          AFuncFaturaRedePitStop: TFuncFaturaRedePitStop = nil);
begin
  Try
    FRedePitStop := ARedePitStop;
    FFuncFaturaRedePitStop := AFuncFaturaRedePitStop;

    FcdsFornecedores :=  AcdsFornecedores;
    FEmpDes := AEmpDes;
    FcdsItens        :=  AcdsItens;
    FcdsItensMultiLojas := AcdsItensMultiLojas;
    FGetCodForToIndex := AfuncGetCodForToIndex;
    FSetDadosCompraEmbalagem := AprocSetDadosCompraEmbalagem;
    qryInsert := fCriaQuery;
    FFilter := AFilter;
    blnControlaColetaCompra := fCfgSis('CONCOL', varBoolean);
    blnRefPed := fCfgSis('REFPED', varBoolean);
    fltAlqPis := fCfgSis('ALPISP');
    fltAlqCof := fCfgSis('ALCOFP');
    blnLibPcm := fCfgSis('LIBPCM', varBoolean);
    intDeqTpc := fCfgSis('DEQTPC', varInteger);
    fltALPISP := fCfgSis('ALPISP', varDouble);
    fltALCOFP := fCfgSis('ALCOFP', varDouble);
    FCopiaCadInt := ACopiaCadInt;
    FCodGirOriginal := ACodGirOriginal;


    FblnConverterEmbalagens := AblnConverterEmbalagens;
    FobjDuplicatasPedido := AobjDuplicatasPedido;
    FRecObserv := ARecObserv;
    FArrCodCta := AArrCodCta;
    FGetCodCta := AProcGetCodCta;
    qryEmpresa := fCriaQuery;
    pAbreEmpresas(qryEmpresa);
    FstrMulLoj := AstrMulLoj;
    FNumCot := ANumCot;
    FEmpCot := AEmpCot;
    FrecDadGiro := ArecDadGiro;
    FfltValFreRes := AfltValFreRes;
    FfltDesAceRes := AfltDesAceRes;
    FProcIncluiPcmIrq := AProcIncluiPcmIrq;
    strForFil := fRetForFilialTodos;
    FComprador := AComprador;
    FItensGerados := AItensGerados;

  Except
    on e: Exception do
      pMensagensErro(E.Message, '[TPreparaPedidosCotacao.Create]');
  End;
end;

destructor TPreparaPedidosCotacao.Destroy;
begin
  FreeAndNil(qryEmpresa);
  FreeAndNil(qryInsert);
  inherited;
end;

function TPreparaPedidosCotacao.fAddTotFornecPedido(AFornecedor: String): integer;
begin
  SetLength(arrTotGerFornecedor, succ(Length(arrTotGerFornecedor)));
  Result := High(arrTotGerFornecedor);
  arrTotGerFornecedor[Result].Fornecedor := AFornecedor;
  arrTotGerFornecedor[Result].fltValTot := 0;
End;


function TPreparaPedidosCotacao.fAddPedido(AFornecedor,
  AEmpresa: String): integer;
begin
  SetLength(Pedidos, succ(Length(Pedidos)));
  Result := High(Pedidos);
  Pedidos[Result].Fornecedor := AFornecedor;
  Pedidos[Result].Empresa := AEmpresa;
  Pedidos[Result].index := Result;
  Pedidos[Result].indexFornecedor := FGetCodForToIndex(Pedidos[Result].Fornecedor);
  Pedidos[Result].blnUsaColeta := False;
  Pedidos[Result].fltTotFre:= 0;
  Pedidos[Result].fltTotAce := 0;
  Pedidos[Result].fltTotSub := 0;
  Pedidos[Result].fltSubFCP := 0;
  Pedidos[Result].fltTotIpi := 0;
  Pedidos[Result].fltTotIPI    := 0;
  Pedidos[Result].fltTotSub    := 0;
  Pedidos[Result].fltSubFCP    := 0;
  Pedidos[Result].fltIcmDes    := 0;
  Pedidos[Result].fltTotIte    := 0;
  Pedidos[Result].fltTotGer    := 0;
  Pedidos[Result].fltTotFre    := 0;
  Pedidos[Result].fltBasCof    := 0;
  Pedidos[Result].fltValCof    := 0;
  Pedidos[Result].fltBasPis    := 0;
  Pedidos[Result].fltValPis    := 0;
  Pedidos[Result].fltBasIcm    := 0;
  Pedidos[Result].fltValIcm    := 0;
  Pedidos[Result].fltDesPis    := 0;
  Pedidos[Result].fltBasIpi    := 0;
  Pedidos[Result].fltBasSub    := 0;
  Pedidos[Result].fltValCbs    := 0;
  Pedidos[Result].fltValIbs    := 0;
  Pedidos[Result].fltVal_Is    := 0;

  If blnControlaColetaCompra Then
    Pedidos[Result].blnUsaColeta := (fCampoTabela('FOR_CONCOL', 'CADFOR', ['FOR_CODFOR'], [AFornecedor]) = 'S');
  FcdsFornecedores.First;
  If FcdsFornecedores.Locate('COT_CODFOR', AFornecedor, []) Then
  Begin
    Pedidos[Result].strConPag := fTiraCaracEspeciais(FcdsFornecedores.FieldByName('COT_CONPAG').AsString);
    Pedidos[Result].dtaDtaEnt := FcdsFornecedores.FieldByName('COT_DTAENT').AsDateTime;
    Pedidos[Result].StatusPitStopCotacao := TStatusCotacaoPitStop.IntToStatusPitStopCotacao(FcdsFornecedores.FieldByName('COT_PITSTO').AsInteger);
  End;

  Pedidos[Result].strNumPed := fSeqPedidoCompra;
  Pedidos[Result].dtaDtaPed := VS_Date;
  Pedidos[Result].horHorPed := fTime();

  Pedidos[Result].recObserv.strCodTraRedespacho := FrecObserv.strCodTraRedespacho;
  Pedidos[Result].recObserv.strTipFreRedespacho := FrecObserv.strTipFreRedespacho;
  Pedidos[Result].recObserv.blnEndLoj := FrecObserv.blnEndLoj;
  Pedidos[Result].recObserv.blnDesmen := FrecObserv.blnDesmen;
  Pedidos[Result].recObserv.strNomEmp := FrecObserv.strNomEmp;
  Pedidos[Result].recObserv.strEndere := FrecObserv.strEndere;
  Pedidos[Result].recObserv.strCidade := FrecObserv.strCidade;
  Pedidos[Result].recObserv.strCodTra := FrecObserv.strCodTra;
  Pedidos[Result].recObserv.strObs001 := FrecObserv.strObs001;
  Pedidos[Result].recObserv.strObs002 := FrecObserv.strObs002;
  Pedidos[Result].recObserv.strObs003 := FrecObserv.strObs003;
  Pedidos[Result].recObserv.strTipFre := FrecObserv.strTipFre;
  Pedidos[Result].recObserv.strObsPd1 := FrecObserv.strObsPd1;
  Pedidos[Result].recObserv.strObsPd2 := FrecObserv.strObsPd2;
  Pedidos[Result].recObserv.strObsPd3 := FrecObserv.strObsPd3;
  Pedidos[Result].recObserv.strPedVen := FrecObserv.strPedVen;
  Pedidos[Result].recObserv.strAtenca := FrecObserv.strAtenca;
  Pedidos[Result].recObserv.strCodEve := FrecObserv.strCodEve;
  Pedidos[Result].recObserv.strCodCta := FrecObserv.strCodCta;
  Pedidos[Result].recObserv.fltValFre := FrecObserv.fltValFre;
  Pedidos[Result].recObserv.fltDesAce := FrecObserv.fltDesAce;
  Pedidos[Result].recObserv.blnAltFrete := FrecObserv.blnAltFrete;

  If Pedidos[Result].recObserv.blnEndLoj Then
  begin
    qryEmpresa.First;
    If qryEmpresa.Locate('EMP_CODEMP', AEmpresa, []) Then
    Begin
      Pedidos[Result].recObserv.strNomEmp := qryEmpresa.FieldByName('NOMENT').AsString;  // Nome p/ Entrega
      Pedidos[Result].recObserv.strEndere := qryEmpresa.FieldByName('ENDENT').AsString;  // Endereço p/ Entrega
      Pedidos[Result].recObserv.strCidade := qryEmpresa.FieldByName('NOMCID').AsString;  // Cidade p/ Entrega
    End;
  End;

  If Length(FArrCodCta) > 1 Then
     Pedidos[Result].recObserv.strCodCta := FGetCodCta(AFornecedor);


end;

function TPreparaPedidosCotacao.fLocalizaPedido(AFornecedor, AEmpresa: String): integer;
var PcmGer: TPcmGer;
begin
  Result := -1;
  For PcmGer in Pedidos do
  begin
    If (PcmGer.Fornecedor = AFornecedor) and (PcmGer.Empresa = AEmpresa) then
     Result := PcmGer.index;
  End;
end;

function TPreparaPedidosCotacao.fLocalizaTotFornec(AFornecedor: String): integer;
var RecTotGerFornecedor: TRecTotGerFornecedor;
begin
  Result := -1;
  For RecTotGerFornecedor in arrTotGerFornecedor do
  begin
    If (RecTotGerFornecedor.Fornecedor = AFornecedor) then
     Result := RecTotGerFornecedor.index;
  End;
end;


procedure TPreparaPedidosCotacao.pRetornaAjustaFilterEOrdem;
begin
  If Assigned(FcdsItensMultiLojas) Then
  Begin
    FcdsItensMultiLojas.Filtered := False;
    If blnCdsMltLojaFilteredInicial Then
    Begin
      FcdsItensMultiLojas.Filter := strCdsMltLojaFilterInicial;
      FcdsItensMultiLojas.Filtered := true;
    End;
    If Not blnCdsMltLojaDisabled then
      FcdsItensMultiLojas.EnableControls;
  End;
  FcdsItens.Filtered := False;
  If blnCdsItensFilteredInicial Then
  Begin
    FcdsItens.Filter := strCdsItensFilterInicial;
    FcdsItens.Filtered := true;
  End;
  If Not blnCdsItensDisabled then
    FcdsItens.EnableControls;
End;

procedure TPreparaPedidosCotacao.pAjustaFilterEOrdem;
begin
  If Assigned(FcdsItensMultiLojas) Then
  Begin
    blnCdsMltLojaDisabled := FcdsItensMultiLojas.ControlsDisabled;
    FcdsItensMultiLojas.DisableControls;
    blnCdsMltLojaFilteredInicial := FcdsItensMultiLojas.Filtered;
    strCdsMltLojaFilterInicial   := FcdsItensMultiLojas.Filter;
    FcdsItensMultiLojas.Filtered := False;
    FcdsItensMultiLojas.Filter := 'ITE_QTDITE > 0';
    FcdsItensMultiLojas.Filtered := False;
    FcdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';
  End;
  blnCdsItensDisabled   := FcdsItens.ControlsDisabled;
  FcdsItens.DisableControls;
  blnCdsItensFilteredInicial := FcdsItens.Filtered;
  strCdsItensFilterInicial   := FcdsItens.Filter;
  FcdsItens.Filtered := False;
  FcdsItens.Filter := '(QTDITE > 0) AND (PREESC > 0) AND GERPED = ' + QuotedStr('N') + FFilter;
  FcdsItens.Filtered := True;
  FcdsItens.IndexFieldNames := 'CODITE';
end;

procedure TPreparaPedidosCotacao.pPosicionaCdsMultiLojas(AItem: String);
begin
 while (AItem <> FcdsItensMultiLojas.FieldByName('ITE_CODITE').AsString) and (Not FcdsItensMultiLojas.Eof) do
   FcdsItensMultiLojas.Next;
End;


procedure TPreparaPedidosCotacao.pProcessaDesmembramento(AItemAtual: string; AIndexTotFornec: Integer; AForEsc: String; AConverterEmbalagem,AIncPis: Boolean; AEmbala: Double;  var APcmDet: TPcmDet);
var index: integer;
Begin
  pPosicionaCdsMultiLojas(AItemAtual);
  while (AItemAtual = FcdsItensMultiLojas.FieldByName('ITE_CODITE').AsString) and (Not FcdsItensMultiLojas.Eof) do
  begin
    If FcdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat > 0 Then
    Begin
      Index := fLocalizaPedido(AForEsc, FcdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString);
      If Index = -1 then
        Index := fAddPedido(AForEsc, FcdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString);
      APcmDet.fltUnitar := FcdsItens.FieldByName('VALUNI' + fIndice(pedidos[Index].indexFornecedor)).AsFloat;
      SetLength(APcmDet.Pcddet, 0);
      SetLength(APcmDet.Pcddet, succ(Length(APcmDet.Pcddet)));
      APcmDet.fltQtdIte := FcdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
      If AConverterEmbalagem then
        APcmDet.fltQtdIte := APcmDet.fltQtdIte / AEmbala;
      pProcessaValoresComum(AConverterEmbalagem, AEmbala, Index, APcmDet);
      pProcessaValoresTotais(AIncPis,AIndexTotFornec, Index, APcmDet);
      Pedidos[Index].PcmDetItems.AddItem(APcmDet);
    End;
    FcdsItensMultiLojas.Next;
  End;
End;

procedure TPreparaPedidosCotacao.pProcessaSemDesmebrar(AItemAtual: string; AIndexTotFornec: Integer; AForEsc: String; AConverterEmbalagem,AIncPis: Boolean; AEmbala: Double;  var APcmDet: TPcmDet);
var index: integer;
    indexPcdDet: Integer;
begin
  pPosicionaCdsMultiLojas(AItemAtual);

  If FcdsITENS.FieldByName('QTDITE').AsFloat > 0 Then
  Begin
    index := fLocalizaPedido(AForEsc, VS_StrCodEmp);
    If index = -1 then
      index := fAddPedido(AForEsc, VS_StrCodEmp);
    APcmDet.fltUnitar := FcdsItens.FieldByName('VALUNI' + fIndice(pedidos[index].indexFornecedor)).AsFloat;


    SetLength(APcmDet.Pcddet, 0);
    while (AItemAtual = FcdsItensMultiLojas.FieldByName('ITE_CODITE').AsString) and (Not FcdsItensMultiLojas.Eof) do
    begin
      SetLength(APcmDet.Pcddet, succ(Length(APcmDet.Pcddet)));
      indexPcdDet :=  High(APcmDet.Pcddet);
      APcmDet.Pcddet[indexPcdDet].strEmpDes := FcdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;
      APcmDet.Pcddet[indexPcdDet].fltQtdIte := FcdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
      If AConverterEmbalagem then
        APcmDet.PcdDet[indexPcdDet].fltQtdIte := APcmDet.PcdDet[indexPcdDet].fltQtdIte / AEmbala;
      APcmDet.fltQtdIte := APcmDet.fltQtdIte + APcmDet.PcdDet[indexPcdDet].fltQtdIte;
      FcdsItensMultiLojas.Next;
    End;

    pProcessaValoresComum(AConverterEmbalagem, AEmbala, Index, APcmDet);
    pProcessaValoresTotais(AIncPis,AIndexTotFornec, Index, APcmDet);
    Pedidos[Index].PcmDetItems.AddItem(APcmDet);
  End;
End;

procedure TPreparaPedidosCotacao.pProcessaCotacaoSimples(AItemAtual: string; AIndexTotFornec: Integer; AForEsc: String; AConverterEmbalagem,AIncPis: Boolean; AEmbala: Double;  var APcmDet: TPcmDet);
var index: integer;
begin
  index := fLocalizaPedido(AForEsc, VS_StrCodEmp);
  If index = -1 then
    index := fAddPedido(AForEsc, IIf(FEmpDes = '', VS_StrCodEmp, FEmpDes));
  APcmDet.fltUnitar := FcdsItens.FieldByName('VALUNI' + fIndice(pedidos[index].indexFornecedor)).AsFloat;
  APcmDet.fltQtdIte := FcdsItens.FieldByName('QTDITE').AsFloat;
  pProcessaValoresComum(AConverterEmbalagem, AEmbala, Index, APcmDet);
  pProcessaValoresTotais(AIncPis,AIndexTotFornec, Index, APcmDet);
  Pedidos[Index].PcmDetItems.AddItem(APcmDet);
End;



function TPreparaPedidosCotacao.fPreparaPedidos(
  pgbProgresso: TcxProgressBar): Boolean;
  var indexTotFornec: integer;
      strForEsc: string;
      strItemAtual: String;
      PcmDet: TPcmDet;
      fltEmbala: Double;
      blnIncPis: Boolean;
      blnConverterEmbalagem: Boolean;
begin
  Try
    pgbProgresso.Properties.Max := FcdsItens.RecordCount -1;

    while not FcdsItens.Eof Do
    Begin
      strForEsc := FcdsItens.FieldByName('FORESC').AsString;
      if FGetCodForToIndex(strForEsc) = - 1 Then
      begin
        FcdsItens.Next;
        Continue;
      End;

      strItemAtual := FcdsItens.FieldByName('CODITE').AsString;
      blnIncPis := fCampoTabela('ITE_INCPIS', 'CADITE', ['ITE_CODITE'], [strItemAtual]) = 'S';
      indexTotFornec:= fLocalizaTotFornec(strForEsc);
      If indexTotFornec = -1 Then
        indexTotFornec := fAddTotFornecPedido(strForEsc);

      PcmDet.iniciaDet;
      PcmDet.item := strItemAtual;
      PcmDet.strDesIte := Trim(FcdsItens.FieldByName('DESITE').AsString + IIF(blnRefPed, ' ' + FcdsItens.FieldByName('REFERE').AsString, ''));
      PcmDet.blnIncidePis := blnIncPis;
      PcmDet.strCodUni := FcdsItens.FieldByName('CODUNI').AsString;
      PcmDet.strSigUni := FcdsItens.FieldByName('SIGUNI').AsString;

      blnConverterEmbalagem :=  FblnConverterEmbalagens And  FSetDadosCompraEmbalagem(strItemAtual, PcmDet.strCodUni, PcmDet.strSigUni, fltEmbala);

      If Assigned(FcdsItensMultiLojas) and (FRecObserv.blnDesmen) Then
        pProcessaDesmembramento(strItemAtual,
                                indexTotFornec,
                                strForEsc,
                                blnConverterEmbalagem,
                                blnIncPis,
                                fltEmbala,
                                PcmDet)
      Else If Assigned(FcdsItensMultiLojas) and (not FRecObserv.blnDesmen) Then
         pProcessaSemDesmebrar(strItemAtual,
                               indexTotFornec,
                               strForEsc,
                               blnConverterEmbalagem,
                               blnIncPis,
                               fltEmbala,
                               PcmDet)

      Else
        pProcessaCotacaoSimples(strItemAtual,
                                indexTotFornec,
                                strForEsc,
                                blnConverterEmbalagem,
                                blnIncPis,
                                fltEmbala,
                                PcmDet);
      FcdsItens.Edit;
      FcdsItens.FieldByName('ALTERADO').AsString := 'S';
      FcdsItens.Post;
      FcdsItens.Next;
      pgbProgresso.Position := FcdsItens.RecNo;
      Application.ProcessMessages;

    End;

    pRecalculaFrete_e_despesas(pgbProgresso);

    Result := True;
    frmPraparaPedido.blnConfirma := Result;
  Except
    on E:Exception do
    Begin
      pMensagensErro(e.message, 'TPreparaPedidosCotacao.fPreparaPedidos');
      Result := False;

    End;
  End;
end;


Procedure TPreparaPedidosCotacao.pProcessaValoresComum(AblnConverterEmbalagem: Boolean; AfltEmbala: Double; AIndexPedido: Integer; var APcmDet: TPcmdet);
begin
  If AblnConverterEmbalagem Then
     APcmDet.fltUnitar := APcmDet.fltUnitar * AfltEmbala;

    APcmDet.fltTotIte := APcmDet.fltQtdIte * APcmDet.fltUnitar;
    APcmDet.fltIpiEnt :=  FcdsItens.FieldByName('IPIENT' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat ;
    APcmDet.fltTotIPI := APcmDet.fltTotIte * (APcmDet.fltIpiEnt/100);
    APcmDet.fltSubsti := FcdsItens.FieldByName('SUBSTI' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltTotSub := APcmDet.fltTotIte * (APcmDet.fltSubsti/100);
    APcmDet.fltFreEnt := FcdsItens.FieldByName('FREENT' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltTotFre := APcmDet.fltTotIte * (APcmDet.fltFreEnt/100);
    APcmDet.fltPerFCP := 0;
    APcmDet.fltSubFCP := APcmDet.fltTotSub * (APcmDet.fltPerFCP/100);

    APcmDet.fltBasSub := APcmDet.fltTotIte;
    APcmDet.fltBasIPI := APcmDet.fltTotIte;
    APcmDet.fltBasIcm := 0;
    APcmDet.fltAlqIcm := 0;
    APcmDet.fltValIcm := 0;
    APcmDet.fltDesPis := 0;

    APcmDet.fltPerIPI := FcdsItens.FieldByName('IPIENT' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltPerFre := FcdsItens.FieldByName('FREENT' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltPerSub := FcdsItens.FieldByName('SUBSTI' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltAlqCbs := FcdsItens.FieldByName('ALQCBS' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltAlqIbs := FcdsItens.FieldByName('ALQIBS' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltAlq_Is := FcdsItens.FieldByName('ALQ_IS' + fIndice(Pedidos[AIndexPedido].indexFornecedor)).AsFloat;
    APcmDet.fltPerFCP := 0;
    APcmDet.fltTotIte := APcmDet.fltQtdIte * APcmDet.fltUnitar;

    APcmDet.fltValIPI := APcmDet.fltTotIte * (APcmDet.fltPerIPI/100);
    APcmDet.fltValSub := APcmDet.fltTotIte * (APcmDet.fltPerSub/100);
    APcmDet.fltValFre := APcmDet.fltTotIte * (APcmDet.fltPerFre/100);

    APcmDet.fltValFCP := APcmDet.fltValSub * (APcmDet.fltPerFCP/100);

    pCalculaImpostosReformaPcmDet(APcmDet);
End;

procedure TPreparaPedidosCotacao.pCalculaImpostosReformaPcmDet(var APcmDet: TPcmDet);
var
  recBase: TBaseReforma;
  recValores: TValoresReforma;
begin
  recBase := TBaseReforma.fCriar(APcmDet.fltTotIte, APcmDet.fltValFre, APcmDet.fltDesAce);
  recBase.fltValIcm := APcmDet.fltValIcm;

  recValores := TCalculoReformaCompra.fCalcular(recBase,
                                                TAliquotasReforma.fCriar(APcmDet.fltAlqCbs, APcmDet.fltAlqIbs, APcmDet.fltAlq_Is),
                                                True);

  APcmDet.fltValCbs := recValores.fltCbs;
  APcmDet.fltValIbs := recValores.fltIbs;
  APcmDet.fltVal_Is := recValores.fltIs;
end;

Procedure TPreparaPedidosCotacao.pProcessaValoresTotais(AblnIncPis: Boolean; AIndexTotFornec: Integer;AIndexPedido: Integer;APcmDet: TPcmdet);
begin
  Pedidos[AIndexPedido].fltTotIte := Pedidos[AIndexPedido].fltTotIte + APcmDet.fltTotIte;
  Pedidos[AIndexPedido].fltTotIPI := Pedidos[AIndexPedido].fltTotIPI + APcmDet.fltValIPI;
  Pedidos[AIndexPedido].fltTotSub := Pedidos[AIndexPedido].fltTotSub + APcmDet.fltValSub;
  Pedidos[AIndexPedido].fltSubFCP := Pedidos[AIndexPedido].fltSubFCP + APcmDet.fltValFCP;
  Pedidos[AIndexPedido].fltTotFre := Pedidos[AIndexPedido].fltTotFre + APcmDet.fltValFRe;

  Pedidos[AIndexPedido].fltTotGer := Pedidos[AIndexPedido].fltTotGer + APcmDet.fltTotIte + APcmDet.fltValIPI + APcmDet.fltValSub + APcmDet.fltValFre;
  arrTotGerFornecedor[AindexTotFornec].fltValTot := arrTotGerFornecedor[AindexTotFornec].fltValTot +
                                                   APcmDet.fltTotIte + APcmDet.fltValIPI + APcmDet.fltValSub + APcmDet.fltValFre;

  Pedidos[AIndexPedido].fltValCbs := Pedidos[AIndexPedido].fltValCbs + APcmDet.fltValCbs;
  Pedidos[AIndexPedido].fltValIbs := Pedidos[AIndexPedido].fltValIbs + APcmDet.fltValIbs;
  Pedidos[AIndexPedido].fltVal_Is := Pedidos[AIndexPedido].fltVal_Is + APcmDet.fltVal_Is;

  If fSomarNovosImpostosDaReformaAoValorContabil Then
  Begin
    Pedidos[AIndexPedido].fltTotGer := Pedidos[AIndexPedido].fltTotGer + APcmDet.fltValCbs + APcmDet.fltValIbs + APcmDet.fltVal_Is;
    arrTotGerFornecedor[AindexTotFornec].fltValTot := arrTotGerFornecedor[AindexTotFornec].fltValTot +
                                                     APcmDet.fltValCbs + APcmDet.fltValIbs + APcmDet.fltVal_Is;
  End;


  If AblnIncPis Then
  Begin
    Pedidos[AIndexPedido].fltBasCof := Pedidos[AIndexPedido].fltBasCof + APcmDet.fltTotIte;
    Pedidos[AIndexPedido].fltValCof := Pedidos[AIndexPedido].fltValCof + RoundTo(APcmDet.fltTotIte * fltAlqCof/100, -2);
    Pedidos[AIndexPedido].fltBasPis := Pedidos[AIndexPedido].fltBasPis + APcmDet.fltTotIte;
    Pedidos[AIndexPedido].fltValPis := Pedidos[AIndexPedido].fltValPis + RoundTo(APcmDet.fltTotIte * fltAlqPis/100, -2);
  End;

  Pedidos[AIndexPedido].fltBasIcm := 0;
  Pedidos[AIndexPedido].fltValIcm := 0;
  Pedidos[AIndexPedido].fltDesPis := 0;
  Pedidos[AIndexPedido].fltBasIpi := 0;
  Pedidos[AIndexPedido].fltBasSub := 0;
End;


procedure TPreparaPedidosCotacao.pRecalculaFrete_e_despesas(pgbProgresso: TcxProgressBar);
var Pedido: TPcmGer;
    PcmDet: TPcmDet;
    fltTotIteGer: Double;
begin
  frmPraparaPedido.Caption := 'Recalculando valor do frete e despesas acessórias';
  pgbProgresso.Properties.Max := high(Pedidos);
  Application.ProcessMessages;

  For Pedido in  Pedidos do
  begin
    pedidos[pedido.index].fltTotIte := 0;
    pedidos[pedido.index].fltTotIPI := 0;
    pedidos[pedido.index].fltTotFre := 0;
    pedidos[pedido.index].fltTotAce := 0;
    pedidos[pedido.index].fltTotSub := 0;
    pedidos[pedido.index].fltTotFCP := 0;
    pedidos[pedido.index].fltValCbs := 0;
    pedidos[pedido.index].fltValIbs := 0;
    pedidos[pedido.index].fltVal_Is := 0;

    fltTotIteGer := fGetTotIteFornecedor(Pedido.Fornecedor);
    For PcmDet in Pedido.PcmDetItems.Itens do
    begin
      If (Pedido.recObserv.blnAltFrete) Then
      Begin
        If (FfltValFreRes > 0) And (Pedido.fltTotGer > 0) Then
        Begin
          If RoundTo(PcmDet.fltTotIte * (Pedido.recObserv.fltValFre /fltTotIteGer), -2) > FfltValFreRes Then
            Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValFre := FfltValFreRes
          Else
            Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValFre := RoundTo(PcmDet.fltTotIte * (Pedido.recObserv.fltValFre / fltTotIteGer), -2);
        End
        Else
          Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValFre := 0;
      End;

      If (FfltDesAceRes > 0) And (Pedido.fltTotIte > 0) Then
      Begin

        If RoundTo(PcmDet.fltTotIte * (Pedido.recObserv.fltDesAce / fltTotIteGer), -2) > FfltDesAceRes Then
          Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltDesAce := FfltDesAceRes
        Else
          Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltDesAce := RoundTo(PcmDet.fltTotIte * (Pedido.recObserv.fltDesAce / fltTotIteGer), -2);

      End
      Else
        Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltDesAce := 0;

      FfltValFreRes := RoundTo(FfltValFreRes - Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValFre, -2);
      FfltDesAceRes := RoundTo(FfltDesAceRes - Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltDesAce , -2);

      pCalculaImpostosReformaPcmDet(Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index]);
      pedidos[pedido.index].fltValCbs := pedidos[pedido.index].fltValCbs + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValCbs;
      pedidos[pedido.index].fltValIbs := pedidos[pedido.index].fltValIbs + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValIbs;
      pedidos[pedido.index].fltVal_Is := pedidos[pedido.index].fltVal_Is + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltVal_Is;

      pedidos[pedido.index].fltTotIte := pedidos[pedido.index].fltTotIte + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltTotIte;
      pedidos[pedido.index].fltTotIPI := pedidos[pedido.index].fltTotIPI + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltTotIPI;
      pedidos[pedido.index].fltTotFre := pedidos[pedido.index].fltTotFre + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltValFre;
      pedidos[pedido.index].fltTotAce := pedidos[pedido.index].fltTotAce + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltDesAce;
      pedidos[pedido.index].fltTotSub := pedidos[pedido.index].fltTotSub + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltTotSub;
      pedidos[pedido.index].fltTotFCP := pedidos[pedido.index].fltTotFCP + Pedidos[pedido.index].PcmDetItems.Itens[pcmdet.index].fltSubFCP;
      If pcmdet.blnIncidePis Then
      Begin
        pedidos[pedido.index].fltBasCof :=  pedidos[pedido.index].fltTotIte ;
        pedidos[pedido.index].fltValCof :=  RoundTo(pedidos[pedido.index].fltTotIte * fltAlqCof/100, -2);
        pedidos[pedido.index].fltBasPis :=  pedidos[pedido.index].fltTotIte;
        pedidos[pedido.index].fltValPis :=  RoundTo(pedidos[pedido.index].fltTotIte * fltAlqPis/100, -2);
      End;
    End;
    pedidos[pedido.index].fltTotGer := pedidos[pedido.index].fltTotFre +
                                       pedidos[pedido.index].fltTotAce +
                                       pedidos[pedido.index].fltTotIte +
                                       pedidos[pedido.index].fltTotIPI +
                                       pedidos[pedido.index].fltTotSub;

    If fSomarNovosImpostosDaReformaAoValorContabil Then
      pedidos[pedido.index].fltTotGer := pedidos[pedido.index].fltTotGer +
                                         pedidos[pedido.index].fltValCbs +
                                         pedidos[pedido.index].fltValIbs +
                                         pedidos[pedido.index].fltVal_Is;

    pgbProgresso.Position := Pedido.index;
    Application.ProcessMessages;

  End;
End;

function TPreparaPedidosCotacao.fGeraPedidosDeCompra(pgbProgresso: TcxProgressBar): Boolean;
var PcmGer: TPcmGer;
    pcmDet: TPcmdet;
    intQtdConCol: integer;
    FAutGer: String;
    strAutIncPcmDet: String;
    strCampoSaldoAdd: String;
    strAutIncPcdDet: String;
    Pcddet: TPcddet;
    intIndexGerados: Integer;

Begin
  Result := True;
  Try
    FPedidosGerados := '';
    pgbProgresso.Properties.Max := High(Pedidos);

    For PcmGer in Pedidos do
    Begin
      FobjDuplicatasPedido.pCarregaParcelas('');
      pGravaPcmGer(False,
                   Nil,
                   FobjDuplicatasPedido,
                   PcmGer.strNumPed,                        // Número do Pedido
                   VS_strCodEmp,                     // Empresa
                   'PD',                             // Espécie (PD / OR)
                   PcmGer.Fornecedor,                        // Fornecedor
                   PcmGer.recObserv.strCodTra,                        // Transportadora
                   PcmGer.recObserv.strCodTraRedespacho,              // Transportadora
                   PcmGer.strConPag,                        // Cond. Pagamento
                   PcmGer.dtaDtaPed,                        // Data do Pedido
                   PcmGer.horHorPed,                        // Hora do Pedido
                   PcmGer.dtaDtaEnt,                        // Data de Entrega
                   FComprador,                        // Comprador
                   PcmGer.fltTotIpi,                        // Total de IPI
                   PcmGer.fltTotSub,                        // Total de SUB
                   0,                                // Total de DARE
                   PcmGer.fltSubFCP,                        // Total de SUB FCP
                   PcmGer.fltTotIte,                        // Total de Itens

                   PcmGer.fltTotGer,

                   PcmGer.recObserv.strObs001,                        // Observação 1
                   PcmGer.recObserv.strObs002,                        // Observação 2
                   PcmGer.recObserv.strObs003,                        // Observação 3
                   '',                               // Observação 4
                   '',                               // Observação 5
                   PcmGer.recObserv.strObsPd1,                        // Observ PD 1
                   PcmGer.recObserv.strObsPd2,                        // Observ PD 2
                   PcmGer.recObserv.strObsPd3,                        // Observ PD 3
                   PcmGer.recObserv.strPedVen,                        // Pedido de venda
                   PcmGer.recObserv.strAtenca,                        // Atenção de
                   PcmGer.recObserv.strTipFre,                        // Tipo de Frete
                   PcmGer.recObserv.strTipFreRedespacho,                        // Tipo de Frete
                   '',                               // Origem do Documento (Faturamento)
                   0,                                // Número do Container
                   'N',                              // Pedido de Importação?
                   'N',                              // Pedido Intrepostado
                   PcmGer.Empresa,                        // Codigo da empresa destino
                   0,                                // Desconto Adicionsl
                   FstrMulLoj,                        // Pedido Multi Lojas?
                   PcmGer.fltTotFre,                        // fltValFre
                   PcmGer.fltTotAce,                        // fltDesAce
                   PcmGer.dtaDtaPed,                        // Data do Faturamento
                   PcmGer.recObserv.strCodEve,                        // Código do Evento
                   PcmGer.recObserv.strCodCta,                        // Centro de Custo
                   PcmGer.recObserv.strNomEmp,
                   PcmGer.recObserv.strEndere,
                   PcmGer.recObserv.strCidade,
                   '',
                   nivNenhum,
                   0,
                   0,
                   0,
                   0,
                   PcmGer.fltBasCof,
                   PcmGer.fltValCof,
                   PcmGer.fltBasPis,
                   PcmGer.fltValPis,
                   PcmGer.fltBasIcm,
                   PcmGer.fltValIcm,
                   PcmGer.fltBasIpi,
                   PcmGer.fltBasSub,
                   IIF(fStatusCndPag(PcmGer.strConPag) = A_VISTA, 'S', 'N'),
                   FNumCot,
                   FEmpCot,
                   'N',
                   'N',
                   'P',
                   FrecDadGiro.intMesGir,
                   IIF(FrecDadGiro.blnConsMesAtu, 'S', 'N'),
                   '',
                   0,
                   0,
                   PcmGer.fltDesPis,
                   FAutGer,
                   'N',
                   False,   // blnTabRestaura
                   '',      // strCodDig
                   '',      // strNumPok
                   moeReal, // moeMoeda
                   'N',     // strPreOrc
                   'S',     // strBStFre
                   'S',     // strBStAce
                   '',      // strOrdCon
                   '',      // strTipCodFabProd
                   '',      // strObsPd4
                   '',      // strObsPd5
                   '',      // strObsPd6
                   'N',     // strIpiFre
                   False,   // blnPagamentoCartaoCredito
                   '',      // strObs006
                   PcmGer.fltValCbs,
                   PcmGer.fltValIbs,
                   PcmGer.fltVal_Is);
      strCampoSaldoAdd := fRetCampoAtualizaSaldoPedidoCompra(FAutGer,
                                                             '',
                                                             '',
                                                             blnLibPcm,
                                                             strForFil);
      FCopiaCadInt(FCodGirOriginal,  FAutGer, 'frmDigGiroEstoque');
      FPedidosGerados := FPedidosGerados + IIf(fEmptyStr(FPedidosGerados), '', ', ') + PcmGer.strNumPed;
      For pcmdet in PcmGer.PcmDetItems.Itens do
      Begin
        intQtdConCol := 0;
        qryInsert.SQL.Clear;
        strAutIncPcmDet := '';
        qryInsert.SQL.Add(fGravaPcmDet(intQtdConCol,
                     Nil,
                     pcmger.blnUsaColeta And (Not (FstrMulLoj ='S')),
                     '', // strEmpDes
                     '', // strCampoSaldoSub
                     strCampoSaldoAdd,
                     intDeqTpc,
                     pcmger.strNumPed,                                // Número do Pedido
                     VS_strCodEmp,                             // Empresa
                     'PD',                                     // Espécie (PD / OR)
                     pcmger.Fornecedor,                                // Fornecedor
                     pcmdet.item,                                // Código Item
                     pcmdet.strCodUni,                                // Código Unidade
                     pcmger.dtaDtaEnt,                                // Data Entrega
                     pcmger.horHorPed,                                // Hora do Pedido
                     pcmger.dtaDtaPed,                                // Data do Pedido
                     pcmger.strConPag,                                // Cond. Pagamento
                     pcmdet.strDesIte,                                // Descrição Item
                     pcmdet.fltQtdIte,                                // Quantidade
                     pcmdet.fltUnitar,                                // Preço Unitario
                     0,                                        // % desconto 1 unitário
                     0,                                        // % desconto 2 unitário
                     0,                                        // % desconto 3 unitário
                     0,                                        // % desconto 4 unitário
                     0,                                        // % desconto 5 unitário
                     0,                                        // % desconto 6 unitário
                     pcmdet.fltTotIte,                                // Total Itens S
                     pcmdet.fltIPIEnt,                                // Percentual IPI
                     pcmdet.fltTotIPI,                                // Total IPI
                     pcmdet.fltSubsti,                                // Percentual SUB
                     pcmdet.fltTotSub,                                // Total SUB
                     0,                                        // Total DARE
                     pcmdet.fltPerFCP,                                // Percentual SUB FCP
                     pcmdet.fltSubFCP,                                // Total SUB
                     0,                                        // Quantidade Baixa
                     0,                                        // Total Baixado
                     0,                                        // IPI Baixado
                     0,                                        // SUB Baixado
                     0,                                        // DARE Baixado
                     0,                                        // SUB FCP Baixado
                     0,
                     0,
                     pcmdet.fltValFre,
                     pcmdet.fltDesAce,
                     0,                                        // Baixado?
                     '' ,                                       // Origem do Documento (Faturamento)
                     0,                                        // Número do Container
                     'N',                                      // Pedido de Importação?
                     'N',                                      // Pedido Intrepostado
                     'N',                                      // Proveninete de Importação?
                     0,
                     0,
                     strAutIncPcmDet,                             // Auto Incremento
                     '',                                       // Código do produto acabado
                     '',                                       // Empresa do produto acabado
                     '',                                       // Produto acabado? (S/N)
                     0,                                        // Conferencia de entrada
                     pcmdet.fltBasSub,
                     pcmdet.fltBasIPI,
                     pcmdet.fltBasIcm,
                     100,
                     pcmdet.fltAlqIcm,
                     pcmdet.fltValIcm,
                     pcmdet.blnIncidePis,
                     '',
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     '',    //  strFatDor: string);
                     1,
                     fltALPISP,
                     fltALCOFP,
                     'S',
                     pcmdet.fltDesPis,
                     False{blnTabRestaura},
                     ''{strSeqGer},
                     True{blnInsere},
                     ''{strAutoin},
                     False{blnVeioAutIncPcdInclusao},
                     -1{fltQtdOrc},
                     0{dtaDatEdt},
                     0{fltUniLiq},
                     pcmdet.fltAlqCbs,
                     pcmdet.fltAlqIbs,
                     pcmdet.fltAlq_Is,
                     pcmdet.fltValCbs,
                     pcmdet.fltValIbs,
                     pcmdet.fltVal_Is));

          If Not FItensGerados.Find(pcmdet.Item, intIndexGerados) Then
          Begin
            FItensGerados.Add(pcmdet.Item);
          End;

          qryInsert.SQL.Text := TMontaSQLPedidoCompra.fAjustaAutoIncControleDeColeta(intQtdConCol, qryInsert.SQL.Text);

          qryInsert.ExecSQL;

          // Insere relação PCMDET -> MOVRCD (Item do pedido com item da requisição de compra)
          FProcIncluiPcmIrq(strAutIncPcmDet, pcmdet.item);

          qryInsert.SQL.Clear;
          If (FstrMulLoj = 'S') And (Not FRecObserv.blnDesmen) Then
          begin
            For Pcddet in pcmDet.Pcddet do
            begin
              strAutIncPcdDet := fRetAutoIncrem('PCDDET', VS_strCodEmp);
              qryInsert.SQL.Add(fGravarPcdDet(strAutIncPcdDet,
                                              VS_strCodEmp,
                                              pcmdet.item,
                                              pcddet.strEmpDes,
                                              'PD',
                                              pcmger.strNumPed,
                                              Pcddet.fltQtdIte,
                                              strAutIncPcmDet));

            End;
          End;
          If Trim(qryInsert.SQL.Text) <> '' Then
            qryInsert.ExecSQL;

      End;
      pgbProgresso.Position := PcmGer.index;
      If Result Then
        If Assigned(FRedePitStop) Then
          If PcmGer.StatusPitStopCotacao in [spscPendenteRecotarPreco, spscConcluido] Then
            result := FFuncFaturaRedePitStop(PcmGer.Fornecedor, FAutGer, FNumCot, PcmGer.StatusPitStopCotacao);



      Application.ProcessMessages;

    end;
  Except
    on E:exception do
    Begin
      pMensagensErro(e.message , 'TPreparaPedidosCotacao.fGeraPedidosDeCompra');
      Result := False;
    End;
  End;
  frmPraparaPedido.blnConfirma := Result;

End;

function TPreparaPedidosCotacao.fGetTotIteFornecedor(
  AFornecedor: String): Double;
var index: integer;
begin
  Result := 0;
  index:= fLocalizaTotFornec(AFornecedor);
  If index > -1 Then
    Result := arrTotGerFornecedor[index].fltValTot;
end;

function  TPreparaPedidosCotacao.fProcessa_e_insere: Boolean;
begin
  pAjustaFilterEOrdem;
  Try
    Result := false;
    pCriarFormularios(TfrmGravando, frmPraparaPedido);
    Try
      frmPraparaPedido.lblGravando.Caption := 'Montando pedidos de compra';
      frmPraparaPedido.fExecutarAcao := fPreparaPedidos;
      frmPraparaPedido.ShowModal;
      Result := frmPraparaPedido.blnConfirma;
    Finally
      FreeAndNil(frmPraparaPedido);
    End;

    If Result Then
    Begin
      pCriarFormularios(TfrmGravando, frmPraparaPedido);
      Try
        frmPraparaPedido.lblGravando.Caption := 'Gravando os Pedidos de compra';
        frmPraparaPedido.fExecutarAcao := fGeraPedidosDeCompra;
        frmPraparaPedido.ShowModal;
        Result := frmPraparaPedido.blnConfirma;
      Finally
        FreeAndNil(frmPraparaPedido);
      End;
    End;
  Finally
    pRetornaAjustaFilterEOrdem;
  End;
end;

Function TPreparaPedidosCotacao.fIndice(AContador: Integer): String;
Begin
  Result := RightStr('0' + IntToStr(AContador), 2);
End;

{ TPcmDetItems }

procedure TPcmDetItems.AddItem(PcmDet: TPcmDet);
begin
  SetLength(Itens, succ(Length(Itens)));
  Itens[High(Itens)] := PcmDet;
  Itens[High(Itens)].index := High(Itens);

  {}
end;

{ TPcmDet }

procedure TPcmDet.iniciaDet;
begin
  index :=  1;
  item  := '';
  strCodUni := '';
  strSigUni := '';
  strDesIte := '';
  fltQtdIte := 0;
  fltUnitar := 0;
  fltPerIPI := 0;
  fltPerFre := 0;
  fltPerSub := 0;
  fltPerFCP := 0;
  fltValIPI := 0;
  fltValSub := 0;
  fltValFre := 0;
  fltValFCP := 0;
  fltTotIte := 0;
  fltIpiEnt := 0;
  fltTotIPI := 0;
  fltSubsti := 0;
  fltTotSub := 0;
  fltFreEnt := 0;
  fltTotFre := 0;
  fltSubFCP := 0;
  fltDesAce := 0;
  fltBasSub := 0;
  fltBasIPI := 0;
  fltBasIcm := 0;
  fltAlqIcm := 0;
  fltValIcm := 0;
  fltDesPis := 0;
  fltAlqCbs := 0;
  fltAlqIbs := 0;
  fltAlq_Is := 0;
  fltValCbs := 0;
  fltValIbs := 0;
  fltVal_Is := 0;
  blnIncidePis := False;
  SetLength(Pcddet, 0);
end;

end.
