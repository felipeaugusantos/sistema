unit untFuncFatImp;

interface

uses
  Classes,
  Forms,
  StdCtrls,
  SysUtils,
  strUtils,
  Uni,
  TypInfo,
  Variants,
  UniClientDataSet,
  cxProgressBar,
  untFatImpressao,
  untFuncoesSimples,
  untFuncFatTypes,
  untTypesSistema,
  Winapi.Windows;

Type
  TFatVendaImp = class(TComponent)
    private
      arrImpressaoVenda: TArrDadosImpressoesVenda;
      qryCfgRel: TUniQuery;

      {************************************************************}
      {* PROPRIEDADES QUE SERÃO USADAS PARA A IMPRESSÃO DO BOLETO *}
      {*********************************************************MV*}
      FValMor  : Double;
      FValExt  : String;
      FValExt2 : String;
      FCodBco  : String;
      FCodPor  : String;
      FNosNum  : String;
      FCodCar  : Integer;
      FBcoIni  : String;
      FMens01  : String;
      FMens02  : String;
      FCGCCLI  : String;
      FCEPCLI  : String;
      FDesCtr  : Double;
      FDtaAtu  : String;
      FPerMul  : String;
      FMulta_  : Double;
      FImpBol  : Boolean;
      FImpSfa  : Boolean;
      FVeriPgto : Boolean;
      FSfaPag: Boolean;
      FStsPagto: TSfaStatusPagamento;
      FSepFin  : Boolean;

      FRecCliGar    : Boolean;
      FPDORMultiLoja: Boolean;
      FPreRomaneio  : Boolean;
      FAgrupaPor    : TOpcAgrupaSepRomaneio;
      FSomenteNaoImp: Boolean;
      FFiltraPorPedido: Boolean;
      FblnPerguntaImpBol: Boolean;
      FblnBoletoImpresso: Boolean;

      function GetCount: Integer;
      function GetDadosImpVenda(index: integer): TDadosImpressaoVenda;

      function fGetSetores(documento: TDadosImpressaoVenda; strItens: String): TStringArray;

      procedure pAtualizaSeparadorRetira(documento: TDadosImpressaoVenda);

      procedure pImprimeAmostraVeiculo(documento: TDadosImpressaoVenda);

      procedure pImprimeTicketNFD(documento: TDadosImpressaoVenda);
      procedure pImprimeTicketDVD(documento: TDadosImpressaoVenda);
      procedure pImprimeRequisicao(documento: TDadosImpressaoVenda);
      procedure pImprimeDocumentoFolhaBranca(documento: TDadosImpressaoVenda);

      procedure pImprimeEtiquetasUnidadesRestante(documento: TDadosImpressaoVenda);
      procedure pImprimeComprovanteIndependente(strFila: String; documento: TDadosImpressaoVenda);

      procedure pImprimirRequisicoesDePedido(strRequisocoesPD: String);
      procedure pImprimeRequisicaoPorPedido(strNomeFila, strTipImp, strNumPed, strEspPed, strEmpPed: String);

      procedure pImprimeComprovantePontosProfissional(documento: TDadosImpressaoVenda);
      procedure pImprimeOrdProItensEstrutura(arrMatItens: TMatrizFechamento);

      function fImprimeContratoCarnePagamento(documento: TDadosImpressaoVenda): Boolean;

      function fItensComSetorNaoCadastrado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOpcDocTrue: String): String;

      function fValidarAbastecimentoEstoquePedido(documento: TDadosImpressaoVenda; blnVerificaSeImprimeSeparacao: Boolean = False): Boolean;

      function fImprimirBoletos(documento: TDadosImpressaoVenda; blnPergunta: Boolean = False;
                                strTextoPergunta: String = ''; strNomeForm: String = 'frmFatVendas';
                                strNomImpBol: String = ''; strWhereBol: String = ''): Boolean;

      procedure pImprimeComprovanteValorComissaoProfissional(documento: TDadosImpressaoVenda);
      function fVerificaSeImprimeComprovanteValorComissaoProfissional(documento: TDadosImpressaoVenda): Boolean;

      procedure pImprimeComplementoFF(intQtdImp: integer; documento: TDadosImpressaoVenda);
    public

      blnJaConfImpr : Boolean;
      intRespConfImpr : Integer;

      class procedure pImprimirSeparacaoFina(strNumRom: String; ArrDocsImp: TDocumentos);

      class function fItensDocumento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;

      class function fGetSQLDuplicatasBoletos(strWhereBol: String = ''): String;

      class procedure pImprimeReciboAdiantamentoPedido(strNumDoc, strEspDoc, strEmpDoc, strCodCli: String);

      class procedure pImprimeRelatorioGerencialParaSATeNFCe(strNumDoc, strEspDoc, strEmpDoc, strCodCli: String);

      class function fTemLayoutEmailBoletoAtivo(documento: TDadosImpressaoVenda): Boolean;

      procedure pImprimeBoletos(documento: TDadosImpressaoVenda;
                                blnPergunta: Boolean = False;
                                strTextoPergunta: String = '';
                                strNomeForm: String = 'frmFatVendas');

      procedure pImprimeNotaFiscal(documento: TDadosImpressaoVenda);

      function fVerificaSeImprimeSeparacao(documento: TDadosImpressaoVenda; blnSEPOPI : Boolean = False): Boolean;

      function fImpressaoDaSeparacaoEhDePickingCheckOut(documento: TDadosImpressaoVenda) : Boolean;

      class function fGetOPs_PD(strNumDoc, strEspDoc, strEmpDoc : String) : String;

      class function fVerificaSeImprimeBoleto(documento: TDadosImpressaoVenda): Boolean;
      function fQtdeDocsEmitidosImprimemBoleto: Integer;
      function fUtilizaFilaImpressaoSepCd(const documento: TDadosImpressaoVenda): Boolean;
      function fUtilizaFilasImpressaoConfiguradas(const documento: TDadosImpressaoVenda): Boolean;

      function fImprimeSeparacao(documento : TDadosImpressaoVenda;
                                 strNomeFila,
                                 strTipImp : String;
                                 blnFilEnt : Boolean = False;
                                 intQtdVias: Integer = -1;
                                 strCodIte : String = ''): Boolean;

      procedure pImprimeDocumento(documento: TDadosImpressaoVenda;
                                  AImpPdOr : TDadosImprimePdOrSep = Nil;
                                  AImpSep  : TDadosImprimePdOrSep = Nil;
                                  AImpTermo: TDadosImprimePdOrSep = Nil); overload;

      procedure pImprimeDocumento( intQtdImp: Integer;
                                   strOpcDoc: String;
                                   strNumImp: String;
                                   strEspImp: String;
                                   strEmpImp: String;
                                   strCliImp: String;
                                   fltTotDeb: Double;
                                   opcComSemPreco: TImpressaoComSemPrecoOrPd;
                                   blnPreTot: Boolean;
                                   blnFilEmp: Boolean;
                                   blnConfOr: Boolean;
                                   blnQtdPen: Boolean;
                                   blnEnt_CD: Boolean;
                                   blnExpedi: Boolean;
                                   strNomeForm: String = 'frmFatVendas';
                                   blnPerTot: Boolean = False;
                                   strCodIct: String = ''); overload;

      procedure pImprimirDocumentos(pgbStatus: TcxProgressBar; lblInformacao: TLabel; objPerguntasImpressaoPedOrc: TDadosImprimePdOrSep; objPerguntasImpressaoSepPed: TDadosImprimePdOrSep);
      procedure pLimparDocumentos;
      constructor Create; reintroduce;
      destructor Destroy; override;

      procedure Add(documento: TDadosImpressaoVenda);
      function IndexOf(documento: TDadosImpressaoVenda): Integer;

      function fTemFilaSepSetorEntRet(strSetor: String; strEntRet: String): Boolean;
      function fTemItensEntRetSetor(documento: TDadosImpressaoVenda; strSetor, strEntRet: String): Boolean;

      property ItemsCount: Integer Read GetCount;
      property Items[index: integer]: TDadosImpressaoVenda Read GetDadosImpVenda; Default;
      function fValidarPEIMSE_ATIMSE(cdsLogSep: TUniClientDataSet): TImprimePdOrSep;

      procedure pSetCdsLogSep(index: Integer; cdsLogSep: TUniClientDataSet);
      procedure pImprimeTicketIF(documento: TDadosImpressaoVenda);
    published
      {*****************************************}
      {* PROPRIEDADES QUE SERÃO USADAS PARA A  *}
      {* IMPRESSÃO DO BOLETO                   *}
      {**************************************MV*}
      property blnImpBol  : Boolean Read FImpBol  Write FImpBol;
      property strCodBco  : String  Read FCodBco  Write FCodBco;
      property fltValMor  : Double  Read FValMor  Write FValMor;
      property strCodPor  : String  Read FCodPor  Write FCodPor;
      property strNosNum  : String  Read FNosNum  Write FNosNum;
      property strValExt  : String  Read FValExt  Write FValExt;
      property strValExt2 : String  Read FValExt2 Write FValExt2;
      property intCodCar  : Integer Read FCodCar  Write FCodCar;
      property strBcoIni  : String  Read FBcoIni  Write FBcoIni;
      property strMens01  : String  Read FMens01  Write FMens01;
      property strMens02  : String  Read FMens02  Write FMens02;
      property strCLICGC  : String  Read FCGCCLI  Write FCGCCLI;
      property strCLICEP  : String  Read FCEPCLI  Write FCEPCLI;
      property fltDesCtr  : Double  Read FDesCtr  Write FDesCtr;
      property strDtaAtu  : String  Read FDtaAtu  Write FDtaAtu;
      property strPerMul  : String  Read FPerMul  Write FPerMul;
      property fltMulta_  : Double  Read FMulta_  Write FMulta_;
      property blnRecCliGar     : Boolean Read FRecCliGar     Write FRecCliGar;
      property blnPDORMultiLoja : Boolean Read FPDORMultiLoja Write FPDORMultiLoja;
      property blnPreRomaneio   : Boolean Read FPreRomaneio   Write FPreRomaneio;
      property blnSomenteNaoImp : Boolean Read FSomenteNaoImp Write FSomenteNaoImp;
      property opcAgrupaPor     : TOpcAgrupaSepRomaneio Read FAgrupaPor Write FAgrupaPor;
      property blnFiltraPorPedido : Boolean Read FFiltraPorPedido Write FFiltraPorPedido;
      property blnImpSfa : Boolean read FImpSfa write FImpSfa;
      property blnSepFin : Boolean read FSepFin write FSepFin;
      property sfaStsPagto : TSfaStatusPagamento read FStsPagto write FStsPagto;
      property blnVeriPgto : Boolean read FVeriPgto write FVeriPgto;
      property blnSfaPag: Boolean read FSfaPag write FSfaPag;
      property blnPerguntaImpBol: Boolean read FblnPerguntaImpBol write FblnPerguntaImpBol;
      property blnBoletoImpresso: Boolean read FblnBoletoImpresso write FblnBoletoImpresso;
  end;

type
  TImprimirSeparacao = class
  private
    strOpcDoc: string;
    strNumDoc: string;
    strEspDoc: string;
    strEmpDoc: string;
    strCodCli: string;
    strNumRom: string;
    strNomTbl: string;
    strNomeFila: String;
    strTipImp: String;
    intQtdVias: Integer;
    blnFilEnt: Boolean;
    opcAgrupaPor: TOpcAgrupaSepRomaneio;
    FFiltraPorPedido: Boolean;
    blnPDORMultiLoja: Boolean;
    strSepEntRet: string;
    strSetorPar: string;
    blnRecCliGar: Boolean;
    blnPreRomaneio: Boolean;
    blnSomenteNaoImp: Boolean;
    strWhereSep: string;
    strCodLayFilSep: string;
    strCodLse: string;
    blnConfOrcamento: Boolean;
    blnQtdOri: Boolean;
    blnExpedi: Boolean;
    blnEnt_CD: Boolean;
    blnSepFut: Boolean;
    cdsLogSep: TUniClientDataSet;
    strMensNovo: string;
    strMensExcluido: string;
    dtaSepFut: TDate;
    hraSepFut: TTime;
    blnPicOut: Boolean;
    blnExpFatAut: Boolean;
  public
    constructor Create(strOpcDocP: string;
                       strNumDocP: string;
                       strEspDocP: string;
                       strEmpDocP: string;
                       strCodCliP: string;
                       strNumRomP: string;
                       strNomTblP: string;
                       opcAgrupaPorP: TOpcAgrupaSepRomaneio;
                       blnFiltraPorPedidoP: Boolean;
                       intQtdViasP: Integer;
                       strNomeFilaP: string;
                       strTipImpP: String;
                       blnFilEntP: Boolean;
                       blnPDORMultiLojaP: Boolean;
                       strSepEntRetP: string;
                       strSetorParP: string;
                       blnRecCliGarP: Boolean;
                       blnPreRomaneioP: Boolean;
                       blnSomenteNaoImpP: Boolean;
                       strWhereSepP: string;
                       strCodLayFilSepP: string;
                       strCodLseP: string;
                       blnConfOrcamentoP: Boolean;
                       blnQtdOriP: Boolean;
                       blnExpediP: Boolean;
                       blnEnt_CDP: Boolean;
                       blnSepFutP: Boolean;
                       cdsLogSepP: TUniClientDataSet;
                       strMensNovoP: string;
                       strMensExcluidoP: string;
                       dtaSepFutP: TDate;
                       hraSepFutP: TTime;
                       blnPicOutP: Boolean;
                       blnExpFatAutP: Boolean);

    procedure pImprimeDocs(strSetor: String = '');
    procedure pImprimirSep;
  end;

type
  TImprimirSeparacaoFilasConfiguradas = class
  private
    intQtdVias: Integer;
    strNomTbl: string;
    strSepTipDoc: string;
    strNomeFila: string;
    strWhereSep: string;
    strCodLayFilSep: String;
    strTipImp: string;
    blnFilEnt: Boolean;
    opcAgrupaPor: TOpcAgrupaSepRomaneio;
    documento: TDadosImpressaoVenda;
    blnFiltraPorPedido: Boolean;
    blnPDORMultiLoja: Boolean;
    strSepEntRet: string;
    strSetorPar: string;
    blnRecCliGar: Boolean;
    blnPreRomaneio: Boolean;
    blnSomenteNaoImp: Boolean;
    function fTemParametroNull(const qryQuery : TUniQuery) : Boolean;
    function fVaiTerDadosParaImprimir(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strWhere : String; tpeTipEtq : TTipoEtiqueta): Boolean;
  protected
    procedure Execute;
  public
    constructor Create(strNomTblP, strSepTipDocP: string;
                       opcAgrupaPorP: TOpcAgrupaSepRomaneio;
                       documentoP: TDadosImpressaoVenda;
                       blnFiltraPorPedidoP: Boolean;
                       intQtdViasP: Integer;
                       strTipImpP: string;
                       blnFilEntP: Boolean;
                       blnPDORMultiLojaP: Boolean;
                       strSepEntRetP: string;
                       strSetorParP: string;
                       blnRecCliGarP: Boolean;
                       blnPreRomaneioP: Boolean;
                       blnSomenteNaoImpP: Boolean);
    destructor Destroy; override;
  end;

implementation

uses  untConstantes, untCarnePagto, untFatOrdProTintaMaquina, untMovGer,
      untRelFatEtiqProdAcabados, untReimpressao, untCfgRel, untFuncoes,
      untFatDigBancoBoleto, untImpEtiDespacho, untIteBar,
      untComprovantePontosProfissional, untFastPrintEditor, untOrdPro,
      untReciboImpFiscal, untBoleto, Data.DB, untImpAutenticacao,
      untImpRecCtrPersonalizado, untQckFatImp40Col2Comprov, untDisparaEmailAut,
      untMsgLiberacao, untLiberacao, untEditorFastImpressao, untTermoAceiteCompraVenda ,untTMultiplosBancos,
      untTPickingCheckOut, untFuncFat, untNotificacoes, untThreadUtils, untImpressaoSeparacao;

{ TFatVendaImp }

constructor TFatVendaImp.Create;
begin
  pLimparDocumentos;
  FImpBol            := True;
  qryCfgRel          := fCriaQuery;
  FRecCliGar         := False;
  FPDORMultiLoja     := False;
  blnPreRomaneio     := False;
  opcAgrupaPor       := opcNaoAgrupa;
  blnSomenteNaoImp   := False;
  blnFiltraPorPedido := False;
  FImpSfa            := False;
  FSepFin            := False;
  FVeriPgto := False;
  FStsPagto := sspBranco;
  FSfaPag := False;
end;

destructor TFatVendaImp.Destroy;
begin
  pLimparDocumentos;
  FreeAndNil(qryCfgRel);
end;

function TFatVendaImp.GetCount: Integer;
begin
  Result := Length(arrImpressaoVenda);
end;

function TFatVendaImp.GetDadosImpVenda(index: integer): TDadosImpressaoVenda;
begin
  Result := arrImpressaoVenda[index];
end;

function TFatVendaImp.IndexOf(documento: TDadosImpressaoVenda): Integer;
  Var
    intIndex: Integer;
begin
  Result := -1;
  For intIndex := 0 To GetCount -1 Do
    If (Items[intIndex].strNumDoc = documento.strNumDoc) And
       (Items[intIndex].strEspDoc = documento.strEspDoc) And
       (Items[intIndex].strEmpDoc = documento.strEmpDoc) And
       (Items[intIndex].strCodCli = documento.strCodCli) Then
    Begin
      Result := intIndex;
      Break;
    End;
end;

procedure TFatVendaImp.Add(documento: TDadosImpressaoVenda);
Begin
  SetLength(arrImpressaoVenda, Length(arrImpressaoVenda) + 1);
  arrImpressaoVenda[Length(arrImpressaoVenda) - 1] := documento;
end;

procedure TFatVendaImp.pImprimeDocumento( intQtdImp: Integer;
                                          strOpcDoc: String;
                                          strNumImp: String;
                                          strEspImp: String;
                                          strEmpImp: String;
                                          strCliImp: String;
                                          fltTotDeb: Double;
                                          opcComSemPreco: TImpressaoComSemPrecoOrPd;
                                          blnPreTot: Boolean;
                                          blnFilEmp: Boolean;
                                          blnConfOr: Boolean;
                                          blnQtdPen: Boolean;
                                          blnEnt_CD: Boolean;
                                          blnExpedi: Boolean;
                                          strNomeForm: String = 'frmFatVendas';
                                          blnPerTot: Boolean = False;
                                          strCodIct: String = '');
  Var
    strNomeTabela: String;
    strNomFil: String;
    strOriDoc: String;
    strNomeArquivo: String;
begin
  Try
    strNomeTabela := '';

    If (Pos(strEspImp, 'MI_FF_BR_TE_TR_DV_PI_EP_UC_CS_CR_GF_PA_RL_') > 0) Then
    Begin

      If ((strOpcDoc = 'CF') And (strEspImp = 'FF')) Or
         ((strOpcDoc = 'FC') And (strEspImp = 'FF')) Then
        strNomeTabela := 'NOTDET'
      Else
        strNomeTabela := 'MOVDET';

    End
    Else If (Pos(strEspImp, 'PD_OR_PR_') > 0) Then
      strNomeTabela := 'FATDOR';

    If (fEmptyStr(strNomeTabela)) Then
      Exit;

    If (strEspImp = 'CR') Then
      strOriDoc := 'C'
    Else
      strOriDoc := 'V';

    {*******************************************}
    {* IMPRESSÃO DO FATURAMENTO                *}
    {****************************************AF*}

    If (intQtdImp > 0) Then
    Begin
      pImprimeFatImp(strNomeTabela,
                     strNumImp,
                     strEspImp,
                     strEmpImp,
                     strCliImp,
                     IIF(strEspImp='GF','F','C'),
                     strOriDoc,
                     False,
                     strNomeArquivo,
                     blnConfOr,
                     'I',
                     intQtdImp,
                     opcComSemPreco {blnComPre},
                     fltTotDeb,
                     False,
                     False,
                     blnPreTot {blnValTot},
                     (Not blnQtdPen),
                     '', //strFila
                     '', //strTipImpressao
                     False, //blnDocCancelado
                     blnExpedi, //blnImpExpedicao
                     False, //blnComprovInd
                     False, //blnSempreEntr
                     False, //blnRequisicao
                     blnFilEmp,
                     False,
                     opcTodos,
                     False,
                     blnEnt_CD,
                     False,
                     False,
                     False,
                     '',
                     '',
                     Nil,
                     False,
                     '',
                     '',
                     '',
                     False,
                     opcNaoAgrupa,
                     False,
                     '',
                     '',
                     False,
                     blnPerTot,
                     False,
                     '',
                     False,
                     False,
                     False,
                     False,
                     False,
                     False,
                     False,
                     '',
                     '',
                     '',
                     False,
                     '',
                     0,
                     0,
                     False,
                     strCodIct);

      {**********************************************}
      {* SE FOR ORÇAMENTO PARA A PROPRIA EMPRESA    *}
      {* E ESTIVER CONFIGURADA A FILA DE IMPRESSÃO  *}
      {* PARA IMPRIMIR NA EMPRESA FILIAL, IMPRIME O *}
      {* ORÇAMENTO NA FILA DA FILIAL.               *}
      {*******************************************PZ*}
      If (strEspImp = 'OR') And
         (fRetornaClienteFilial(strEmpImp) = strCliImp) Then
      Begin
        pCarregaConfImpr(qryCfgRel, strNomeForm + '_OR_FILIAL');
        strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

        If (Not fEmptyStr(strNomFil)) Then
          pImprimeFatImp(strNomeTabela,
                         strNumImp,
                         strEspImp,
                         strEmpImp,
                         strCliImp,
                         'C',
                         'V',
                         False,
                         strNomeArquivo,
                         blnConfOr,
                         'I',
                         1,
                         opcComSemPreco {blnComPre},
                         fltTotDeb,
                         False,
                         False,
                         blnPreTot {blnValTot},
                         (Not blnQtdPen),
                         '', //strFila
                         '', //strTipImpressao
                         False, //blnDocCancelado
                         blnExpedi, //blnImpExpedicao
                         False, //blnComprovInd
                         False, //blnSempreEntr
                         False, //blnRequisicao
                         blnFilEmp,
                         False,
                         opcTodos,
                         True,
                         False,
                         False,
                         False,
                         False,
                         '',
                         '',
                         Nil,
                         False,
                         '',
                         '',
                         '',
                         blnPerTot);
      End;

    End;

  Except

    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;

  End;
end;

procedure TFatVendaImp.pImprimeNotaFiscal(documento: TDadosImpressaoVenda);
  Var
    reiReimpressao: TReimpressao;
begin
  With documento Do
  Begin
    reiReimpressao := TReimpressao.Create(strNumDoc, strEspDoc, 0, 0, strCodCli, strEmpDoc,
                                          strCodVen, True, strTip_FC, False, True,
                                          False, '', '', True, 0, False, 'V', blnRecCliGar);

    {*******************************************}
    { RECARREGA OS CAMPOS Q NAO ESTAO PRESENTES }
    { NO BD PARA IMPRESSAO                      }
    {****************************************JB*}
    reiReimpressao.strDocsConf   := strDocsConf;
    reiReimpressao.strDocsConfTE := strDocsConfTE;
    reiReimpressao.strDocsConfIF := strDocsConfIF;
    reiReimpressao.strCupCon     := strCupCon;
    reiReimpressao.strCupCha     := strCupCha;
    reiReimpressao.strCupConDev  := strCupConDev;
    reiReimpressao.strCliNFV     := strCliNFV;
    reiReimpressao.strCGCNFV     := strCGCNFV;
    reiReimpressao.strIE_NFV     := strIE_NFV;
    reiReimpressao.strNroNFV     := strNroNFV;
    reiReimpressao.strDtaNFV     := strDtaNFV;
    reiReimpressao.fltValNFV     := fltValNFV;
    reiReimpressao.strCodPor     := strCodPor;

    If strOpcDoc = 'NC' Then
    Begin
      reiReimpressao.fatVenda := objFatVenda;
      reiReimpressao.pImprimeNotaComp;
    End
    Else
      reiReimpressao.pReimprimeDocumento(True);

    FreeAndNil(reiReimpressao);
  End;
end;

procedure TFatVendaImp.pImprimirDocumentos(pgbStatus: TcxProgressBar; lblInformacao: TLabel; objPerguntasImpressaoPedOrc: TDadosImprimePdOrSep; objPerguntasImpressaoSepPed: TDadosImprimePdOrSep);
  Var
    intIndex: Integer;
begin
  For intIndex := 0 To GetCount -1 Do
  Begin
    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Position := intIndex + 1;
      pgbStatus.Properties.Max := GetCount;
    End;

    If Assigned(lblInformacao) Then
    Begin
      lblInformacao.Caption := 'Aguarde... Imprimindo - ' +
        Self[intIndex].strNumDoc + '-' + Self[intIndex].strEspDoc;
    End;

    Application.ProcessMessages;

    pImprimeDocumento(Self[intIndex], objPerguntasImpressaoPedOrc, objPerguntasImpressaoSepPed);
  End;

end;

procedure TFatVendaImp.pImprimeDocumento(documento: TDadosImpressaoVenda;
                                         AImpPdOr : TDadosImprimePdOrSep = Nil;
                                         AImpSep  : TDadosImprimePdOrSep = Nil;
                                         AImpTermo: TDadosImprimePdOrSep = Nil);
  Var
    frmQckFatImp40Col2Comprov: TfrmQckFatImp40Col2Comprov;
    frmRelFatEtiqProdAcabados: TfrmRelFatEtiqProdAcabados;
    blnDocAVista : Boolean;
    blnImpPedido : Boolean;
    blnImpOrcame : Boolean;
    blnImpBoleto : Boolean;
    intQtdImp    : Integer;
    strMsgOpr    : String;
    strEspOpr    : String;
    strFilaSepCD : String;
    strTipImpCD  : String;
    oprOrdProdTin: TFatOrdProTintaMaquina;
    LImpPdOr     : TDadosImprimePdOrSep;
    LImpSep      : TDadosImprimePdOrSep;
    blnPerTot    : Boolean;
    strNomeFila  : String;
    strTipImp    : String;
    ImpAutenticacao: TImpAutenticacao;
    blnImpSep      : Boolean;
    blnImpTermo    : Boolean;
    LstrPrgPor     : String;
    objPickingCheckOutDefinicaoDeLotes : TPickingCheckOutDefinicaoDeLotes;

  procedure pSetaNaoImprimeNoDocumentoSeNecessario(strMomentoDaImpressao: String);
  begin
    If (LImpPdOr.imImpDoc <> imNaoImprime) And (fCfgSis('PIMPED') = strMomentoDaImpressao) Then
    Begin
      LImpPdOr.imImpDoc := imNaoImprime;

      If (documento.strEspDoc = 'OR') Then
        blnImpOrcame := False;
    End;

    If (LImpSep.imImpDoc <> imNaoImprime) And (fCfgSis('PIMSEP') = strMomentoDaImpressao) Then
    Begin
      LImpSep.imImpDoc := imNaoImprime;

      documento.blnImprimeSep := False;
    End;


  end;

  function fExisteItemImpQtdRestante(documento: TDadosImpressaoVenda) : Boolean;
  var
    qryAux  : TUniQuery;
    i       : Integer;
    stlItens: TStringList;
  begin

    Result := False;

    If (Length(documento.arrMatItens) > 0) Then
    Begin

      qryAux   := fCriaQuery;
      stlItens := TStringList.Create;

      Try

        stlItens.Clear;
        for i := 0 to Length(documento.arrMatItens) -1 do
          stlItens.Add(QuotedStr(documento.arrMatItens[i].strCodIte));

        If (stlItens.Count > 0) Then
        Begin

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add('SELECT');
          qryAux.SQL.Add('  COUNT(*) AS TOTAL');
          qryAux.SQL.Add('FROM');
          qryAux.SQL.Add('  CADITE');
          qryAux.SQL.Add('WHERE');
          qryAux.SQL.Add('  ITE_ETIQRE = "S" AND ITE_CODITE IN (' + stlItens.CommaText + ')');
          qryAux.Open;

          If (Not qryAux.IsEmpty) And (qryAux.FieldByName('TOTAL').AsInteger > 0) Then
            Result := True;

        End;

      Finally
        FreeAndNil(qryAux);
        stlItens.Destroy;
      End;

    End;

  end;

  function fMSG_SenhaImprimirComPreco(): Boolean;
  var
    objTabela    : TRegistroMsgLiberaTabela;
    objLinha     : TLinhaMsgLibera;
    objLiberacao : TLiberacao;
    iItens       : Integer;
    strCodEmi,
    strDesEmi,
    strMarEmi,
    strUndEmi,
    strQtdEmi,
    strUniTar,
    strTotIte,
    strUniOri    : String;
  Begin
    objLiberacao := TLiberacao.Create;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Senha para imprimir documento com preço');
    objLiberacao.objMsgLibera.pAddSeparador(75);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                   , documento.strCliNom                                                , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Número Dcumento'           , documento.strNumDoc                                                , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor Total do Documento   ', FormatFloat('#,##0.00', documento.fltTotGer)                       , 24);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Código/Descrição' , 24 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Marca'            , 7  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Und.'             , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Quantidade'       , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Pr. Unitário'     , 13 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Valor Total'      , 14 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'Pr. Tabela'       , 13 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    For iItens := 0 to length(documento.arrMatItens) - 1 Do
    Begin

      strCodEmi := documento.arrMatItens[iItens].strCodIte;
      strDesEmi := documento.arrMatItens[iItens].strDesIte;
      strMarEmi := fCampoTabela('MAR_DESMAR', 'CADMAR', ['MAR_CODMAR'], [documento.arrMatItens[iItens].strCodMar], False);
      strUndEmi := documento.arrMatItens[iItens].strUnidad;
      strQtdEmi := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), documento.arrMatItens[iItens].fltQtdIte);
      strUniTar := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), documento.arrMatItens[iItens].fltUniTar);
      strTotIte := FormatFloat(fMskDigitos(2), documento.arrMatItens[iItens].fltTotIte);
      strUniOri := FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), documento.arrMatItens[iItens].fltUniOri);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Código/Descrição' , strCodEmi + '-' + strDesEmi  , 24 , alEsquerda );
      objLinha.pAddColuna('Marca'            , strMarEmi                    , 7  , alEsquerda );
      objLinha.pAddColuna('Und.'             , strUndEmi                    , 4  , alCentro   );
      objLinha.pAddColuna('Quantidade'       , strQtdEmi                    , 12 , alDireita  );
      objLinha.pAddColuna('Pr. Unitário'     , strUniTar                    , 13 , alDireita  );
      objLinha.pAddColuna('Valor Total'      , strTotIte                    , 14 , alDireita  );
      objLinha.pAddColuna('Pr. Tabela'       , strUniOri                    , 13 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    objLiberacao.strDirAce := 'IMPDCP';
    objLiberacao.strMsgSen := 'Senha para imprimir documento com preço';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCliente := documento.strCodCli + '-' + documento.strCliNom;
    objLiberacao.strCpfCnpj := documento.strCliCgc;

    Result := objLiberacao.fLibera;

    freeAndNil(objLiberacao);

  End;

  function fDesejaImprimirSeparacao : Boolean;
    const
      MSG_PADRAO = 'Deseja imprimir separação [NUMDOC] - [ESPDOC]?';
      MSG_PICOUT = 'Deseja imprimir separação dos itens retira caixa do documento [NUMDOC] - [ESPDOC]?';
    var
      LMSG : String;
  begin
    LMSG := IIF(documento.blnPicOut, MSG_PICOUT, MSG_PADRAO);
    LMSG := LMSG.Replace('[NUMDOC]', documento.strNumDoc)
                .Replace('[ESPDOC]', documento.strEspDoc);
    Result := fMensagem('Atenção', LMSG, ['&Sim', '&Não']) = 1;
  end;

  procedure pImprimeContrato(strCodigoBarrasContrato: String);
    Const
      INT_CONTRATO = 1;
      INT_CARNEPAG = 2;
      INT_AMBOSDOC = 3;

    var
      intOpcaoSel: Integer;
      objCarnePagto: TCarnePagamento;
  begin
    try
      intOpcaoSel := fMensagem('', 'Selecione a Impressão: ', ['&Contrato', 'C&arnê', 'A&mbos', 'Ca&ncelar']);

      objCarnePagto := TCarnePagamento.Create(Self, strCodigoBarrasContrato);

      case intOpcaoSel Of

        INT_CONTRATO: objCarnePagto.fImprimirContrato;

        INT_CARNEPAG: objCarnePagto.fImprimirCarneRecibo;

        INT_AMBOSDOC: Begin
                        objCarnePagto.fImprimirContrato;
                        objCarnePagto.fImprimirCarneRecibo;
                      End;
      End;

    finally
      FreeAndNil(objCarnePagto);
    end;

  end;

begin
  Try
    intQtdImp := 1;
    blnImpPedido := False;
    blnImpOrcame := True;
    blnPerTot := False;
    blnJaConfImpr := False;
    intRespConfImpr := 0;
    LstrPrgPor := fCfgSis('PRGPOR');

    LImpPdOr := AImpPdOr;
    If Not Assigned(AImpPdOr) Then
    Begin
      LImpPdOr := TDadosImprimePdOrSep.Create;
      LImpPdOr.imImpDoc := imPerguntaSeImprime
    End;

    LImpSep := AImpSep;
    If Not Assigned(AImpSep) Then
    Begin
      LImpSep := TDadosImprimePdOrSep.Create;
      LImpSep.imImpDoc := imPerguntaSeImprime;
      LImpSep.intQtdVia := -1;
    End;

    If (Not ((fCfgSis('NVORPD', varString) = 'S') And (LImpSep.imImpDoc <> imPerguntaSeImprime))) Then
      LImpSep.imImpDoc := fValidarPEIMSE_ATIMSE(documento.cdsLogSep);

    If (blnImpSfa) Then
    Begin
      If (fCfgSis('IMSEPI', varBoolean)) Then
      Begin
        LImpPdOr.imImpDoc := imImprimeSemPergutar;
        LImpPdOr.intQtdVia := fCfgSis('VIA_PD', varInteger);

        If LImpPdOr.intQtdVia <= 0 Then
          LImpPdOr.intQtdVia := 1;
      End;

      If (fCfgSis('IMSESI', varBoolean)) Then
      Begin
        LImpSep.imImpDoc := imImprimeSemPergutar;
        LImpSep.intQtdVia := fCfgSis('QTDVSE', varInteger);

        If LImpSep.intQtdVia <= 0 Then
          LImpSep.intQtdVia := 1;
      End;

      If (SameText(ParamStr(1), PARAM_EXEC_SFAMOB)) Then
      Begin
        If (Not (fCfgSis('IMSEPI', varBoolean))) Then
          LImpPdOr.imImpDoc := imNaoImprime;

        If (Not (fCfgSis('IMSESI', varBoolean))) Then
          LImpSep.imImpDoc := imNaoImprime;
      End;

      If (blnSfaPag) Then
      Begin
        If (sfaStsPagto <> sspPagamentoAprovado) And (Not blnVeriPgto) Then
        Begin
          pSetaNaoImprimeNoDocumentoSeNecessario('L'); // No momento da Liberação de Pagamento
        End
        Else If (sfaStsPagto = sspPagamentoAprovado) And (blnVeriPgto) Then
        Begin
          pSetaNaoImprimeNoDocumentoSeNecessario('I'); // No momento da Importação
        End;
      End;
    End;

    If ((documento.strImportacaoGeoSales='S') and (Not fCfgSis('IPDGEO', varBoolean))) Or
       ((documento.strEspDoc = 'PD') And (documento.strOriF11 = 'S') And (Not fCfgSis('IPDF11', varBoolean))) Then
    Begin
      LImpPdOr.imImpDoc := imNaoImprime;
      LImpSep.imImpDoc  := imNaoImprime;
    End;

    With documento Do
    Begin
      {*****************************************}
      {* FF - Faturamento Futuro               *}
      {**************************************MV*}
      If (strEspDoc = 'FF') Then
      Begin
        intQtdImp := 1;

        blnDocAVista := fRetornaCondicaoPagamentoDocumento(strNumDoc,strEspDoc,strEmpDoc,strCodCli) = A_VISTA;

        If (fCfgSis('IMPAUT') <> '2') Or (Not blnConfOrcamento) Then
        Begin
          If (fCfgSis(IIF(blnDocAVista,'VIA_FV','VIA_FF'), varBoolean)) Then
          Begin
            intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['Não Imprimir', '1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

            If intQtdImp = 1 Then
              intQtdImp := -1
            Else
              intQtdImp := intQtdImp - 1;
          End
          Else
          Begin
            intQtdImp := fCfgSis(IIF(blnDocAVista,'QTDVFV','QTDVFF'), varInteger);
            If intQtdImp = 0 Then
              intQtdImp := -1;
          End;
        End;

      End

      {*****************************************}
      {* OR - Orçamento                        *}
      {**************************************MV*}
      Else If (strEspDoc = 'OR') And (LImpPdOr.imImpDoc = imPerguntaSeImprime) Then
      Begin

        If (fCfgSis('IMPORC', varBoolean)) Then
        Begin

          If (fMensagem('', 'Orçamento Nº: ' + strNumDoc + ' - Peso: ' + FloatToStrF(fltPesBru, ffFixed, 12, 3) + #13#10 +
                            'Imprime?', ['&Sim', '&Não']) = 2) Then
            intQtdImp := -1;
        End
        Else
          intQtdImp := -1;

        If (fPerguntaComSemPrecoEmissaoOrcamento) And (intQtdImp > -1) Then
        Begin
          If (Not fCfgSis('UTIDEF', varBoolean)) Then
          Begin
            If (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
            Begin
              Case fGetMenu('Opção:',['Com Preço e Com Marca', 'Com Preço e Sem Marca', 'Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
                1:opcComSemPreco := impComPrecoComMarca;
                2:opcComSemPreco := impComPrecoSemMarca;
                3:opcComSemPreco := impSemPrecoComMarca;
                4:opcComSemPreco := impSemPrecoSemMarca;
              End;
            End
            Else
            Begin
              case fGetMenu('Opção:',['Com Preço', 'Sem Preço', 'Sem Preço Simplificado'], 1) of
                1: opcComSemPreco := impComPrecoGeral;
                2: opcComSemPreco := impSemPrecoGeral;
                3: opcComSemPreco := impSemPrecoSimplificado;
              end;
            End;
          End
          Else
          Begin
            opcComSemPreco := impComPrecoGeral;
          End;
        End
        Else
        Begin
          opcComSemPreco := impComPrecoGeral;
        End;

        If (fCfgSis('VIA_OR', varBoolean)) And (intQtdImp > -1) Then
        Begin
          intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
        End;

        If (fEscolheuOrcamentoComPreco(opcComSemPreco)) And (intQtdImp > -1) Then
        Begin
          If (intQtdImp > -1) Then
          Begin
            If (fCfgSis('ORCSPR', varBoolean, VS_strCodEmp)) And (Not fEmptyStr(fCfgSis('SENPRE'))) Then
            Begin
              opcComSemPreco := IIF(fMSG_SenhaImprimirComPreco, opcComSemPreco, impSemPrecoGeral);

              If (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
              Begin
                If (opcComSemPreco = impSemPrecoGeral) Then
                Begin
                  Case fGetMenu('Opção ("Sem Preço" pois não houve liberação!)',['Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
                    1:opcComSemPreco := impSemPrecoComMarca;
                    2:opcComSemPreco := impSemPrecoSemMarca;
                  End;
                End;
              End;
            End;
          End;
        End;

        If (Not fCfgSis('UTIDEF', varBoolean)) and (Not (opcComSemPreco in [impComPrecoGeral, impComPrecoSemMarca])) Then
        Begin
          { Para que essa opção funcione deve-se configurar um layout pelo editor de layouts
          e nos campos de totais que deseja ocultar/exibir configurar da seguinte forma:
          IIF (PERTOT= 'S', TOTPRO, '')
          Substituindo o "TOTPRO" acima pelo campo desejado }
          blnPerTot := fMensagem('', 'Exibir Valor Total do Documento?', ['&Sim', '&Não']) = 1;
          blnValTot := blnPerTot;
        End;
      End
      {**********************************************************^***}
      {* SE CASO VEIO DO DESMEMBRAMENTO DE MULTILOJA PD/OR VERIFICA *}
      {* SE IMPRIME OU NÃO SEM REALIZAR A PEGUNTA                   *}
      {***********************************************************FC*}
      Else If (strEspDoc = 'OR') And (LImpPdOr.imImpDoc = imImprimeSemPergutar) Then
      Begin
        intQtdImp := LImpPdOr.intQtdVia;
      End
      Else If (strEspDoc = 'OR') And (LImpPdOr.imImpDoc = imNaoImprime) Then
      Begin
        intQtdImp := 0;
      End
      {*****************************************}
      {* PD - Pedido                           *}
      {**************************************MV*}
      Else If ((strEspDoc = 'PD') And (LImpPdOr.imImpDoc = imPerguntaSeImprime) And ((fltTotGer > 0) Or (blnPedOrcBrinde))) Then
      Begin

        intQtdImp := fCfgSis('VIA_PD', varInteger);

        {**************************************************}
        {* SE ESTIVER CONFIGURADO "0" PARA 'QTDE DE VIAS' *}
        {* E NÃO ESTIVER MARCADO PARA PERGUNTAR QTDE DE   *}
        {* VIAS ENTÃO NÃO PERGUNTA SE DESEJA IMPRIMIR     *}
        {***********************************************AL*}
        If blnImprimeAmostraVeiculo Then
          intQtdImp := -1
        Else If (intQtdImp = 0) and (not fCfgSis('QTVIPE', varBoolean)) Then
          intQtdImp := -1
        Else If ((fCfgSis('TIPEXP') = '3') And (fCfgSis('LIBPED', varBoolean)) And (fCfgSis('IPPDLF') = 'L') And (Not fPedLiberado(documento.strNumDoc, documento.strEmpDoc))) Then
          intQtdImp := -1
        Else If (fCfgSis('PRGIPD') = 'S') and (fMensagem('', 'Pedido Nº: ' + strNumDoc + ' Imprime?', ['&Sim', '&Não']) = 2) Then
          intQtdImp := -1
        Else
          blnImpPedido := True;

        If (blnImpPedido) And (fCfgSis('QTVIPE', varBoolean)) Then
          intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

      End
      {**********************************************************^***}
      {* SE CASO VEIO DO DESMEMBRAMENTO DE MULTILOJA PD/OR VERIFICA *}
      {* SE IMPRIME OU NÃO SEM REALIZAR A PEGUNTA                   *}
      {***********************************************************FC*}
      Else If (strEspDoc = 'PD') And (LImpPdOr.imImpDoc = imImprimeSemPergutar) Then
      Begin
        If blnImprimeAmostraVeiculo Then
          intQtdImp := -1
        Else
          intQtdImp := LImpPdOr.intQtdVia;
        blnImpPedido := True;
      End
      Else If (strEspDoc = 'PD') And (LImpPdOr.imImpDoc = imNaoImprime) Then
      Begin
        intQtdImp := 0;
      End
      {*****************************************}
      {* BR - Brinde                           *}
      {**************************************MV*}
      Else If (strEspDoc = 'BR') Then
      Begin
        intQtdImp := IIF(fCfgSis('QTDVBR', varInteger) = 0,
                        -1,
                         fCfgSis('QTDVBR', varInteger));

        If (fCfgSis('VIA_BR', varBoolean)) Then
          intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

      End

      {*****************************************}
      {* TE - Transferência de Estoque         *}
      {**************************************MV*}
      Else If (strEspDoc = 'TE') Then
      Begin
        intQtdImp := 1;

        if (fMensagem('', 'Transf. Estoque Nº: ' + strNumDoc + ' Imprime?', ['&Sim', '&Não']) = 2) Then
          intQtdImp := -1
        else
          If (fCfgSis('VIA_TE', varBoolean)) Then
            intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

      End

      {*****************************************}
      {* TR - Troca de Mercadorias             *}
      {**************************************MV*}
      Else If (strEspDoc = 'TR') Then
      Begin

        If (fMensagem('', 'Troca Nº: ' + strNumDoc + ' Imprime?', ['&Sim', '&Não']) = 2) Then
          intQtdImp := -1
        Else
          intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

      End

      Else If (strOpcDoc = 'PR') Then
      Begin
        intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir', '1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

        If intQtdImp = 1 Then
          intQtdImp := -1
        Else
          intQtdImp := intQtdImp - 1;
      End

      {*****************************************}
      {* DV - Devolução de Mercadorias         *}
      {**************************************MV*}
      Else If (strOpcDoc = 'DV') And (documento.strEspDoc <> 'NF') Then
      Begin
        If (fCfgSis('VIA_DV', varBoolean)) Then
        Begin
          intQtdImp := fGetMenu('Qtd. Vias', ['Não Imprimir', '1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

          If intQtdImp = 1 Then
            intQtdImp := -1
          Else
            intQtdImp := intQtdImp - 1;
        End
        Else
        Begin
          If fCfgSis('QTDVDV', varInteger) > 1 Then
            intQtdImp := fCfgSis('QTDVDV', varInteger);
        End;
      End

      {*****************************************}
      {* CR - Retorno de Consignação           *}
      {**************************************MM*}
      Else If (strOpcDoc = 'CR') And Not (Pos(strEspDoc, 'NF_NV_') > 0) Then
        intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1)

      {*******************************************************}
      {* GF - Envio de Mercadoria para Fornecedor (Garantia) *}
      {****************************************************MM*}
      Else If (strOpcDoc = 'GF') And Not (Pos(strEspDoc, 'NF_NV_') > 0) Then
        intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1)

      {*****************************************}
      {* EP - EMPRESTIMO                       *}
      {**************************************JB*}
      Else If (strEspDoc = 'EP') Then
      Begin
        intQtdImp := 1;

        If (fCfgSis('VIA_EP', varBoolean)) Then
        Begin

          intQtdImp := Pred(fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['Não imprimir', '1 Via', '2 Vias', '3 Vias', '4 Vias'], 2));

        End
        Else
        Begin

          If fCfgSis('QTDVEP', varInteger) > 1 Then
            intQtdImp := fCfgSis('QTDVEP', varInteger);

        End;

      End

      {****************************}
      {* CS - Consignação         *}
      {*************************MV*}
      Else If (strEspDoc = 'CS') Then
      Begin
        intQtdImp := 1;

        if (fMensagem('', 'Consignação Nº: ' + strNumDoc + ' Imprime?', ['&Sim', '&Não']) = 2) Then
          intQtdImp := -1
        else
          If (fCfgSis('VIA_CS', varBoolean)) Then
            intQtdImp := fGetMenu('Qtd. Vias ' + strNumDoc + '-' + strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
      End;

      If (strEspDoc = 'OR') And (LImpPdOr.imImpDoc = imImprimeSemPergutar) Then
      Begin
        opcComSemPreco := LImpPdOr.opcComSemPreco;
        blnPerTot := LImpPdOr.blnExibirTotalOrcamento;
        blnValTot := LImpPdOr.blnExibirTotalOrcamento;
      End;

      strCliCgc := AnsiReplaceStr(strCliCgc,'.','');
      strCliCgc := AnsiReplaceStr(strCliCgc,'-','');
      strCliCgc := AnsiReplaceStr(strCliCgc,'/','');

      If (fCfgSis('NFESER', varBoolean)) And (strEspDoc = 'NS') Then
      Begin
        //UTILIZA NOTA FISCAL ELETRONICA DE SERVICOS
      End

      {***************************************************}
      {* NAO IMPRIMIR NOTA SE FOR NOTA FISCAL ELETRONICA *}
      {************************************************PH*}
      Else If (Not fCfgSis('NFEUSA', varBoolean) Or (Not blnGerNFE)) And (Pos(strEspDoc,'NF_NV_EL_NS_') > 0) Then
      Begin
        If (Not blnImportacaoSpedPisCofins) Then
          pImprimeNotaFiscal(documento);
      End
      Else
      Begin

        If strEspDoc = 'PD' Then
        Begin
          If blnImpPedido Then
          Begin
            pImprimeDocumento(intQtdImp, strOpcDoc, strNumDoc, strEspDoc, strEmpDoc, strCodCli, fltTotDeb,
              impComPrecoGeral, True, blnPDORMultiLoja, blnConfOrcamento, blnPedPen, blnEnt_CD, blnExpedi,
              'frmFatVendas', False, documento.strCodIct);

          End;
          If fCfgSis('ETIDIF', varBoolean) And fExisteItemImpQtdRestante(documento) Then
          Begin
            If (fMensagem('', 'Imprime Etiquetas Restantes?', ['&Sim', '&Não']) = 1) Then
              pImprimeEtiquetasUnidadesRestante(documento);
          End;


        End
        Else If (Pos(strEspDoc,'MI_FF_') > 0) And (fCfgSis('IMPAUT') = '3') And blnConfOrcamento Then
        Begin
          pImprimeDocumento(intQtdImp, strOpcDoc, strNumDoc, strEspDoc, strEmpDoc, strCodCli, fltTotDeb,
            impComPrecoGeral, True, False, False, blnPedPen, blnEnt_CD, blnExpedi);

          pImprimeDocumento(1, strOpcDoc, strNumDoc, strEspDoc, strEmpDoc, strCodCli, fltTotDeb, impComPrecoGeral,
            True, False, blnConfOrcamento, blnPedPen, blnEnt_CD, blnExpedi);
        End
        Else If (strEspDoc = 'OR') Then
        Begin
          If (blnImpOrcame) Then
          Begin
            pImprimeDocumento(intQtdImp, strOpcDoc, strNumDoc, strEspDoc, strEmpDoc, strCodCli, fltTotDeb,
              opcComSemPreco, blnValTot, blnPDORMultiLoja, blnConfOrcamento, blnPedPen, blnEnt_CD, blnExpedi, 'frmFatVendas', blnPerTot);
          End;
        End
        Else
          pImprimeDocumento(intQtdImp, strOpcDoc, strNumDoc, strEspDoc, strEmpDoc, strCodCli, fltTotDeb,
            impComPrecoGeral, True, ((strEspDoc = 'FF') and blnPDORMultiLoja), blnConfOrcamento, blnPedPen, blnEnt_CD, blnExpedi);

        If (Pos(strEspDoc, 'OR_PD_') > 0) Then
        Begin
          pImprimeComprovanteIndependente('', documento);

          {**** IMPRESSÃO DO TERMO DE ACEITE  KM(REQ.190889) ***}
          If (LstrPrgPor <> '0') Then
          Begin
            If ((strEspDoc = 'PD') and ((LstrPrgPor = '1') or (LstrPrgPor = '3'))) or
               ((strEspDoc = 'OR') and ((LstrPrgPor = '2') or (LstrPrgPor = '3'))) Then
            Begin
              If Assigned(AImpTermo) Then
                blnImpTermo := (AImpTermo.imImpDoc <> imNaoImprime)
              Else
                blnImpTermo := fPergunta('Deseja Imprimir o Termo de Aceite de Compra e Venda ?');

              If blnImpTermo Then
                TTermoAceiteCompraVenda.pImprimeTermoDoc(dtaGraPed, strNumDoc, strEspDoc, strEmpDoc, fCadEmp('NOMFAN'),fCadEmp('EMAIL_'),fCadEmp('FONE01'), strNomVen, strCliNom);
            End;
          End;
        End;

        If fVaiImprirComplementoFF(strEspDoc, strCodCli) Then
        Begin
          pImprimeComplementoFF(intQtdImp, documento);
        End;

        {******************************************************}
        {* IMPRIMIR AUTENTICAÇÃO                              *}
        {***************************************************NC*}
        If ((Pos(strEspDoc,'MI_FF_') > 0) And (fCfgSis('IMPAUT') <> '1') And blnConfOrcamento) Then
        Begin
          pCarregaConfImpr(qryCfgRel, 'frmFatVendas_AUT');
          strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

          fPreImpressao(qryCfgRel, strNomeFila,strTipImp,False);

          ImpAutenticacao := TImpAutenticacao.Create(strNomeFila);
          ImpAutenticacao.pImprimeAutenticacaoF11(strNumOrc, strEspOrc, strEmpOrc, DateToStr(dtaDtaEnt),
          strHorEnt, strCodVen, FloatToStrF(fltTotGer,ffFixed,12,2), strConPag, strNumDoc, strEspDoc);

          FreeAndNil(ImpAutenticacao);
        End;

      End;

      If (Pos(strEspDoc, 'OR_PD_') > 0) And (fCfgSis('IMPCPV', varBoolean)) Then
      Begin
        pCriarFormularios(TfrmQckFatImp40Col2Comprov, frmQckFatImp40Col2Comprov);
        Try
          frmQckFatImp40Col2Comprov.pImprimeComprovante(strNumDoc, strEspDoc, strEmpDoc);
        Finally
          pFreeAndNil(frmQckFatImp40Col2Comprov);
        End;
      End;

      strEspOpr := '';
      If (fCfgSis('ORPRTM', varBoolean)) Then
        strEspOpr := strEspOpr + 'NF_NV_EL_IF_IV_D1_MI_FF_TR_DV_PR_TE_DD_CR_EP_';

      If fCfgSis('ORD_OR') = 'S' then
        strEspOpr := strEspOpr + 'OR_';

      If fCfgSis('ORD_PD') = 'S' then
        strEspOpr := strEspOpr + 'PD_';

      If (Pos(strEspDoc, strEspOpr) > 0) And (Not (SameText(ParamStr(1), PARAM_EXEC_SFAMOB))) Then
      Begin
        If (Pos(strEspDoc, '_OR_PD_') > 0) Then
          strMsgOpr := 'Imprimir ordem de produção preliminar do documento ' + strNumDoc + '-' + strEspDoc + ' ?'
        Else
          strMsgOpr := 'Imprimir ordem de produção do documento ' + strNumDoc + '-' + strEspDoc + ' ?';

        {**********************************}
        {* VERIFICA SE TEM PERMISSÃO PARA *}
        {* IMPRESSAO DE ORDEM DE PRODUÇÃO *}
        {* PARA TINTA DE MAQUINA          *}
        {*******************************AF*}
        If fVerificaAcessoSistema('IMPORD') And (IIF(Pos(strEspDoc, 'PD_OR_') > 0, blnMenFor, True)) Then
        Begin
          oprOrdProdTin := TFatOrdProTintaMaquina.Create;
          oprOrdProdTin.pSetaDocumento(strNumDoc, strEspDoc, strEmpDoc, strCodCli, strEmpDoc, '', '');

          If (oprOrdProdTin.blnTemFormula) Then
          Begin
            {*****************************************}
            {* SE O PROCEDIMENTO FOR IMPRIMIR.       *}
            {**************************************MV*}
            If fCfgSis('POPTIN') = 'I' Then
            Begin

              If Not(blnJaConfImpr) Then
              begin
                intRespConfImpr := fMensagem('ATENÇÃO!', strMsgOpr, ['&Sim', '&Não']);
                If (intRespConfImpr = 1) Then
                begin
                  blnJaConfImpr := True;
                end;
              end;

              if (blnJaConfImpr) and (intRespConfImpr=1) then
              begin
                oprOrdProdTin.pImprimeOrdProdTmp;
              end;

            End;
          End;

          FreeAndNil(oprOrdProdTin);
        End;

      End;

      blnImpBoleto := Self.blnImpBol And
                      Self.fVerificaSeImprimeBoleto(documento) And
                     (fCfgSis('IMPBOL',varString) <> 'N');

      {*****************************************}
      {* PROCESSA E IMPRIME BOLETOS            *}
      {**************************************MV*}

      If Not (documento.strOpcDoc = 'LE') Then
        FblnPerguntaImpBol := (fCfgSis('IMPBOL') = 'S')  And (not documento.blnExpediMult);

      If blnImpBoleto Then
      Begin
        pImprimeBoletos(documento,
                        FblnPerguntaImpBol,
                       ('Processar boletos do documento ' + strNumDoc + '-' + strEspDoc + ' ?'));
      End;

      If (Not blnLibCnf)    And
         (Not blnNotEsp)    And
         (strEspDoc = 'FF') And
         (fCfgSis('NOTPFF', varBoolean)) And
         (Not blnBaixaEmprestimos) And
         (Self.fVerificaSeImprimeBoleto(documento)) Then
      Begin
        blnImpBoleto := (fMensagem('', 'Processar Nota Promissoria / Boleto do documento ' + strNumDoc + '-' + strEspDoc + ' ?', ['&Sim', '&Não']) = 1);
        If blnImpBoleto Then documento.blnNotaPro := True;
        If blnImpBoleto Then pImprimeBoletos(documento);
      End;

      If (strOpcDoc <> 'PD') And (Not ((strOpcDoc = 'OR') And (strEspDoc = 'PD'))) Then
        pImprimirRequisicoesDePedido(strRequisocoesPD);

      If (fImprimeContratoCarnePagamento(documento)) Then
        pImprimeContrato(strCodigoBarrasContrato);

      If (strEspDoc = 'PD') And
         (fCfgSis('IMRCPD', varBoolean)) And
         (blnEntregaImediataEmNovoPedido Or
          blnRetiraOutraLojaEmNovoPedido Or
          blnRetiraExpedicaoEmNovoPedido Or
          blnEmitirNovoPedidoEntregaCD) Then
      Begin
        pImprimeReciboAdiantamentoPedido(strNumDoc, strEspDoc, strEmpDoc, strCodCli);
      End;

      pImprimeComprovantePontosProfissional(documento);
      pImprimeOrdProItensEstrutura(documento.arrMatItens);
      pImprimeComprovanteValorComissaoProfissional(documento);

      {*****************************}
      {* IMPRESSAO DA SEPARACAO    *}
      {**************************AF*}
      If blnImprimeSep Or (blnImpSepGarantia And (StrToInt(LeftStr(strClaFis, 1)) >= 5)) Then
      Begin

        documento.blnPicOut := fImpressaoDaSeparacaoEhDePickingCheckOut(documento);

        If fVerificaSeImprimeSeparacao(documento, True) Then
        Begin
          {*****************************}
          {* SEPARAÇÃO CASO FOR PEDIDO *}
          {**************************AF*}
          If (strEspDoc = 'PD') Then
          Begin
            blnImpSep := False;

            {****************************}
            {* CASO FOR ENTREGA PELO CD *}
            {*************************AF*}
            If (fUtilizaFilaImpressaoSepCd(documento)) Then
            Begin
              pCarregaConfImpr(qryCfgRel, 'frmFatVendas_sepcd');
              strFilaSepCD := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
              strTipImpCD  := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

              If Not fEmptyStr(strFilaSepCD) Then
              Begin
                blnImpSep := fImprimeSeparacao(documento, strFilaSepCD, strTipImpCD, False, IIF(LImpSep.imImpDoc = imImprimeSemPergutar, LImpSep.intQtdVia, -1));
              End;
            End
            Else If (LImpSep.imImpDoc  = imImprimeSemPergutar) Or
                    ((LImpSep.imImpDoc = imPerguntaSeImprime) And (fDesejaImprimirSeparacao)) Then
            Begin

              If (documento.blnPicOut) Then
              Begin
                objPickingCheckOutDefinicaoDeLotes := TPickingCheckOutDefinicaoDeLotes.Create(documento.strNumDoc,
                                                                                              documento.strEspDoc,
                                                                                              documento.strEmpDoc);
                Try
                  objPickingCheckOutDefinicaoDeLotes.pDefinirLotes;
                  If Not objPickingCheckOutDefinicaoDeLotes.blnDefiniu Then
                    fMensagem('Atenção', 'Não foi possível definir os lotes do documento de Picking Check-out!', ['&Ok']);
                Finally
                  FreeAndNil(objPickingCheckOutDefinicaoDeLotes);
                End;
              End;

              If (blnItensDiferentes) And
                 (fMensagem('', 'Imprimir Separação dos produtos da Ordem de Serviço:', ['Somente modificados',
                                           'Todos os produtos']
                                           ,1,False,1,180,False,0,False,False,True) = 2) Then
              Begin
                documento.cdsLogSep       := nil;
                documento.strMensNovo     := '';
                documento.strMensExcluido := '';
              End;

              If fImprimeSeparacao(documento, '', '', False, IIF(LImpSep.imImpDoc = imImprimeSemPergutar, LImpSep.intQtdVia, -1)) Then
              Begin

                If fCfgSis('ETIACA') = 'S' Then
                Begin
                  Try
                    pCriarFormularios(TfrmRelFatEtiqProdAcabados,frmRelFatEtiqProdAcabados);
                    frmRelFatEtiqProdAcabados.pImprimirEtiqProdAcabados(strCodAca);
                  Except
                    On E: Exception Do
                      pMensagensErro(E.Message, '[TFatVenda.fGravaArquivos_1]');
                  End;

                  pFreeAndNil(frmRelFatEtiqProdAcabados);
                End;

                blnImpSep := True;

              End;
            End
            Else
              pAtualizaSeparadorRetira(documento);

            If (blnImpSep) Then
            Begin
              fDisparaWhatsappAutomatico(documento.strNumDoc, documento.strEspDoc,documento.strEspDoc, '', 'SE', '',  documento.strCodCli, '', True, '', Nil, '', '', '', Self.UnitName);
              fDisparaEmailAutomatico(documento.strNumDoc, documento.strEspDoc,documento.strEspDoc, '', 'SE', '',  documento.strCodCli);
              fDisparaSMSAutomatico(documento.strNumDoc, documento.strEspDoc,documento.strEspDoc, '', 'SE', '',  documento.strCodCli);
            End;

          End
          {********************************}
          {* SEPARAÇÃO CASO FOR ORCAMENTO *}
          {*****************************AF*}
          Else If (strEspDoc = 'OR') Then
          Begin
            If (LImpSep.imImpDoc  = imImprimeSemPergutar) Or
               ((LImpSep.imImpDoc = imPerguntaSeImprime) And (fMensagem('', 'Deseja imprimir separação ' + strNumDoc + '-' + strEspDoc + ' ?', ['&Sim', '&Não']) = 1)) Then
            Begin
              fImprimeSeparacao(documento, '', '', False, IIF(LImpSep.imImpDoc = imImprimeSemPergutar, LImpSep.intQtdVia, 1));
            End;
          End

          {********************************}
          {* SEPARAÇÃO - OUTRAS ESPECIES  *}
          {*****************************AF*}
          Else
          Begin
            If (fValidarPEIMSE_ATIMSE(documento.cdsLogSep) = imImprimeSemPergutar) Or
               (  (fValidarPEIMSE_ATIMSE(documento.cdsLogSep) = imPerguntaSeImprime) And
                  (fMensagem('', 'Deseja imprimir separação ' + strNumDoc + '-' + strEspDoc + ' ?', ['&Sim', '&Não']) = 1)
               ) Then Begin
              fImprimeSeparacao(documento, '', '');

              If (strEspDoc = 'PD') Then
              Begin
                fDisparaWhatsappAutomatico(documento.strNumDoc, documento.strEspDoc,documento.strEspDoc, '', 'SE', '', documento.strCodCli, '', True, '', Nil, '', '', '', Self.UnitName);
                fDisparaEmailAutomatico(documento.strNumDoc, documento.strEspDoc,documento.strEspDoc, '', 'SE', '', documento.strCodCli);
                fDisparaSMSAutomatico(documento.strNumDoc, documento.strEspDoc,documento.strEspDoc, '', 'SE', '', documento.strCodCli);
              End;
            End
          End;
        End;
      End;

      //*************************************************//
      // VERIFICA SE DEVE IMPRIMIR O TICKET - CUP. FISCAL//
      //**********************************************ED*//
      If (fCfgSis('IMPTCK', varBoolean)) And
         (blnImprimeTicketIF)            And
         (Pos(strEspDoc, 'IF') > 0)      Then
      Begin
        pImprimeTicketIF(documento);
      End;

      If blnImprimeAmostraVeiculo Then
        pImprimeAmostraVeiculo(documento);

      //**************************************************//
      // VERIFICA SE DEVE IMPRIMIR O TICKET - NF DEVOLUÇÃO//
      //***********************************************FS*//
      If (fCfgSis('TCKNFD', varBoolean)) And
         (documento.strOpcDoc = 'DV') And
         (Pos(documento.strEspDoc, 'NF') > 0)      Then
      Begin
        pImprimeTicketNFD(documento);
      End;

      If (fCfgSis('TCKDVD', varBoolean)) And
         (documento.strOpcDoc = 'DV') And
         (Pos(documento.strEspDoc, 'DV') > 0)      Then
      Begin
        pImprimeTicketDVD(documento);
      End;

      {*****************************************************}
      {* VERIFICA SE DEVE IMPRIMIR A REQUISIÇÃO DE ESTOQUE *}
      {**************************************************RV*}
      If fCfgSis('IMPRAB', varBoolean) And (fCfgSis('CEATMN') = '1') Then
      Begin
        If (blnImpReq) And
          ((Pos(strEspDoc, 'OR_PD_') <= 0) Or (strOpcDoc = 'PD') Or ((strOpcDoc = 'OR') And (strEspDoc = 'PD'))) And
           (fMensagem('', 'Deseja imprimir requisição ' + strNumDoc + '-' + strEspDoc + ' ?', ['&Sim', '&Não']) = 1) Then
        Begin
          pImprimeRequisicao(documento);
        End;
      End;

      {****************************************************}
      {* VERIFICA SE DEVE IMPRIMIR A ETIQUETA DE DESPACHO *}
      {*************************************************MM*}
      If (
           (
             (fCfgSis('IMETDE', varBoolean)) And (Pos(strOpcDoc, 'VN_') > 0)
           )
             Or
           (
             (fCfgSis('IMEDCN', varBoolean)) And (Pos(strOpcDoc, 'CF_') > 0)
           )
             Or
           (
             (fCfgSis('IMEDCP', varBoolean)) And (Pos(strOpcDoc, 'CP_') > 0)
           )
         ) And
         (blnImprimeEtiqDespacho)        And
         (not fEmptyStr(strEspDoc))      Then
      Begin
        If (fMensagem('', 'Deseja imprimir etiqueta de despacho do documento ' +
              strNumDoc + '-' + strEspDoc + ' ?', ['&Sim', '&Não']) = 1) Then
        begin
          Try
            pCriarFormularios(TfrmImpEtiDespacho, frmImpEtiDespacho);
            frmImpEtiDespacho.edtNumDoc.Text := strNumDoc;
            frmImpEtiDespacho.edtEspDoc.Text := strEspDoc;
            frmImpEtiDespacho.edtCodEmp.Text := strEmpDoc;
            frmImpEtiDespacho.edtQtdVol.Text := '0';
            frmImpEtiDespacho.strCodCli      := strCodCli;
            frmImpEtiDespacho.blnImpEti      := True;
            frmImpEtiDespacho.fCarregaVolume; //Caso use Sigep precisa chamar essa funçao para carregar os dados do correio.
            frmImpEtiDespacho.ShowModal;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '[frmFatVendas -> frmImpEtiDespacho]');
          End;
          pFreeAndNil(frmImpEtiDespacho);
        End;
      End;

    End;

    If documento.strOriF11 = 'S' Then
      pImprimeDocumentoFolhaBranca(documento);

    If Not Assigned(AImpPdOr) Then
      FreeAndNil(LImpPdOr);

    If Not Assigned(AImpSep) Then
      FreeAndNil(LImpSep);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimirDocumento]');
    End;
  End;

end;

procedure TFatVendaImp.pImprimeEtiquetasUnidadesRestante(documento: TDadosImpressaoVenda);
  Var
    intIndex : Integer;
    objIteBar: TIteBar;
    arrIteEti: TArrItensEtiqUnRestante;
begin
  objIteBar := TIteBar.Create(opcOperacoes);

  SetLength(arrIteEti, Length(documento.arrMatItens));

  For intIndex := Low(documento.arrMatItens) To High(documento.arrMatItens) Do
  Begin
    With objIteBar, documento.arrMatItens[intIndex] Do
    Begin
      pCarregaDados(strCodIte);
      if cdsIteBar.fieldbyname('ITE_ETIQRE').AsString = 'S' then
      begin
        arrIteEti[intIndex].intAutInc  := intAutInc;
        arrIteEti[intIndex].intOrdIte  := intOrdIte;
        arrIteEti[intIndex].strCodItem := strCodIte;
        arrIteEti[intIndex].fltQtdItem := fCalculaUnidadesRestante(fltQtdIte);
      end;
    End;
  End;

  objIteBar.pImprimeEtiquetaUnidadesRestante(arrIteEti, opcFaturamento,
    documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc);

  FreeAndNil(objIteBar);
end;

procedure TFatVendaImp.pImprimeComplementoFF(intQtdImp: integer; documento: TDadosImpressaoVenda);
var
  strCodLay: String;
  objImpressao: TEditorFastImpressao;
begin
  objImpressao := TEditorFastImpressao.Create(Nil);

  try
    strCodLay := fCfgSis('CLACFF', varString);

    objImpressao.recDocume.strNumDoc := documento.strNumDoc;
    objImpressao.recDocume.strEspDoc := documento.strEspDoc;
    objImpressao.recDocume.strCodEmp := documento.strEmpDoc;
    objImpressao.recDocume.strCodCli := documento.strCodCli;
    objImpressao.recDocume.strTipFc := documento.strTip_FC;
    objImpressao.recDocume.intQtdImp := intQtdImp;
    objImpressao.recDocume.blnTemLay := True;
    objImpressao.recDocume.strCodLay := strCodLay;
    objImpressao.fImprimeDocumento(tpaNormal);
  finally
    FreeAndNil(objImpressao);
  end;
end;

procedure TFatVendaImp.pImprimeComprovanteIndependente(strFila: String; documento: TDadosImpressaoVenda);
  Var
    strNomeArquivo: String;
begin

  If (Not fCfgSis('CPVIND', varBoolean)) Then
    Exit;

  pImprimeFatImp('FATDOR',
                 documento.strNumDoc,
                 documento.strEspDoc,
                 documento.strEmpDoc,
                 documento.strCodCli,
                 'C',
                 'V',
                 False,
                 strNomeArquivo,
                 False,
                 'I',
                 1,
                 impComPrecoGeral,
                 0,
                 False,
                 False,
                 True,
                 True,
                 strFila,
                 '',
                 False,
                 documento.blnExpedi,
                 True);
end;

class procedure TFatVendaImp.pImprimirSeparacaoFina(strNumRom: String; ArrDocsImp: TDocumentos);
  Var
    intCount : Integer;
    recSepara : TDadosImpressaoVenda;
    impPreRomaneio : TFatVendaImp;

  procedure pMarcaSeparacaoImpressaRomaneio(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
  begin
    fExecutaSQL('UPDATE ROMDETX R ' +
                '       INNER JOIN ITEGER I ON (R.DET_CODITE = I.ITE_CODITE) ' +
                '                          AND (R.DET_CODEMP = I.ITE_CODEMP) ' +
                '       INNER JOIN FATDOR F ON (R.DET_CODEMP = F.FDO_CODEMP) ' +
                '                          AND (R.DET_NUMDOC = F.FDO_NUMDOC) ' +
                '                          AND (R.DET_ESPDOC = F.FDO_ESPDOC) ' +
                '                          AND (R.DET_CODCLI = F.FDO_CODCLI) ' +
                '                          AND (I.ITE_CODITE = F.FDO_CODITE) ' +
                '                          AND (I.ITE_CODEMP = F.FDO_CODEMP) ' +
                '       INNER JOIN EXTDOR E ON (F.AUTOINCREM = E.FDO_SEQFDO) ' +
                'SET    R.DET_SEPIMP = "S", ' +
                '       E.FDO_SEPEXP = "S" ' +
                'WHERE  R.DET_NUMROM = "' + strNumRom + '" ' +
                '  AND  R.DET_EMPROM = "' + VS_strCodEmp + '"' +
                '  AND  F.FDO_NUMDOC = "' + strNumDoc + '"' +
                '  AND  F.FDO_ESPDOC = "' + strEspDoc + '"' +
                '  AND  F.FDO_CODEMP = "' + strCodEmp + '"' +
                '  AND  F.FDO_CODCLI = "' + strCodCli + '"');
  end;

begin
  For intCount := Low(ArrDocsImp) To High(ArrDocsImp) Do
  Begin
    FillChar(recSepara, Sizeof(recSepara), #0);
    recSepara.strNumDoc := ArrDocsImp[intCount].strNumDoc;
    recSepara.strEspDoc := ArrDocsImp[intCount].strEspDoc;
    recSepara.strCodCli := ArrDocsImp[intCount].strCodCli;
    recSepara.strEmpDoc := ArrDocsImp[intCount].strCodEmp;
    recSepara.strNumRom := strNumRom;

    impPreRomaneio := TFatVendaImp.Create;
    Try
      impPreRomaneio.blnSepFin := True;
      impPreRomaneio.blnPreRomaneio   := True;
      impPreRomaneio.blnSomenteNaoImp := True;
      impPreRomaneio.opcAgrupaPor     := opcPedido;
      impPreRomaneio.Add(recSepara);

      If impPreRomaneio.fImprimeSeparacao(recSepara, '', '', False) Then
        pMarcaSeparacaoImpressaRomaneio(ArrDocsImp[intCount].strNumDoc,
                                        ArrDocsImp[intCount].strEspDoc,
                                        ArrDocsImp[intCount].strCodEmp,
                                        ArrDocsImp[intCount].strCodCli);
    Finally
      FreeAndNil(impPreRomaneio);
    End;
  End;
end;

function TFatVendaImp.fValidarAbastecimentoEstoquePedido(documento: TDadosImpressaoVenda; blnVerificaSeImprimeSeparacao: Boolean = False): Boolean;
Var
  objValidarAbastecimento: TValidarAbastecimentoEstoqueDoPedido;
begin
  Result := True;
  If (documento.strEspDoc = 'PD') And (fCfgSis('OPSOAB') = '1') And fCfgSis('SLTFRC', varBoolean) Then
  Begin
    Try
      objValidarAbastecimento := TValidarAbastecimentoEstoqueDoPedido.Create
        (documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, blnVerificaSeImprimeSeparacao);

      Result := objValidarAbastecimento.fValidarTransferenciasDeEstoque And
        objValidarAbastecimento.fValidarRequisicoesDeCompra;
    Finally
      FreeAndNil(objValidarAbastecimento);
    End;
  End;
end;

function TFatVendaImp.fValidarPEIMSE_ATIMSE(cdsLogSep: TUniClientDataSet): TImprimePdOrSep;
begin
  //imImprimeSemPergutar, imPerguntaSeImprime, imNaoImprime

  If (fCfgSis('PEIMSE', varBoolean)) Then
    Result := imPerguntaSeImprime
  Else
    Result := imImprimeSemPergutar;

  Try
    If (fCfgSis('AUTCEN', varBoolean)) And (Assigned(cdsLogSep)) Then Begin
      If (cdsLogSep.Locate('ITE_STALOG', 'A', [loCaseInSensitive])) Or (cdsLogSep.Locate('ITE_STALOG', 'E', [loCaseInSensitive])) Then Begin
        //'ATIMSE' => '1' = utiliza a configuração 'PEIMSE'
        If (fCfgSis('ATIMSE', varString) = '2') Then
          Result := imImprimeSemPergutar
        Else If (fCfgSis('ATIMSE', varString) = '3') Then
          Result := imNaoImprime;
      End;
    End;
  Except
    On E: Exception Do Begin
      pMensagensErro(E.Message, '[TFatVendaImp.fValidarPEIMSE_ATIMSE]');
    End;
  End;
end;

procedure TFatVendaImp.pImprimeAmostraVeiculo(documento: TDadosImpressaoVenda);
  Var
    objImpressao: TEditorFastImpressao;
    strEsp: string;
    blnOk: Boolean;
    strPDF: string;
    strTpLayout: string;
    strNomeFila: String;

  procedure pImprimir(tpArquivo: TTipoArquivo; strEspecie: string; var StrPDFRet: string);
  Begin
    objImpressao := TEditorFastImpressao.Create(Nil);
    try
      With objImpressao Do
      Begin
        recDocume.strNumDoc := documento.strNumDoc;

        recDocume.strCodEmp := documento.strEmpDoc;

        recDocume.strEspDoc := documento.strEspDoc;

        tpeTipoEtiqueta := tpeAmostraProdutoAuto;

        recDocume.intQtdImp := 2;
        recDocume.blnReimpr := False;
        recDocume.blnDocCan := False;
        recDocume.blnQtdOri := False;
        recDocume.blnConfir := False;
        recDocume.blnDocSep := False;
        recDocume.blnImpExpedicao := False;
        recDocume.blnFilEmp := False;
        recDocume.blnImpFil := False;
        recDocume.blnSepFut := False;
        recDocume.blnEnt_CD := False;
        recDocume.blnSimples               := False;
        recDocume.blnSempreEntr            := False;
        recDocume.blnNaoSelImp             := False;
        recDocume.blnVisPDF                := False;
        recDocume.blnRequisicao            := False;
        recDocume.blnLocFisEmpEmi          := False;
        recDocume.blnAgruparItensSeparacao := False;
        recDocume.strCodCli := documento.strCodCli;

        recDocume.strNomImp   := strNomeFila;

        recDocume.strCodLay :=  fCampoTabela('LAY_CODLAY', 'LAYETI',['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],[140, VS_strCodEmp, 'S']);
        blnOk := fImprimeDocumento(tpArquivo, '', '');
        if tpArquivo = tpaPDF Then
          StrPDFRet := strArqPDF;
      End;

    Finally
      FreeAndNil(objImpressao);
    End;
  End;

begin
  strEsp := 'PD';

  pCarregaConfImpr(qryCfgRel, 'frmProdutoAmostra');
  strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;


  pImprimir(tpaNormal, strEsp, strPDF);

  If Not blnOk Then
    pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
end;

{*****************************************}
{* FAZ A IMPRESSÃO DOS BOLETOS           *}
{**************************************MV*}
procedure TFatVendaImp.pImprimeBoletos(documento: TDadosImpressaoVenda;
  blnPergunta: Boolean = False; strTextoPergunta: String = '';
  strNomeForm: String = 'frmFatVendas');
  Var
    strFiltroSQL: String;

  function fUtilizaFilasImpressaoConfiguradas: Boolean;
  begin
    if VS_SpoolImpressaoCitel then
      Result := fCampoTabela('COUNT(0)','FILBOL',['FIL_CODEMP','FIL_SPOIMP'],[Vs_strCodEmp,'S']) > 0
    else
      Result := fCampoTabela('COUNT(0)','FILBOL',['FIL_CODEMP','FIL_SPOIMP'],[Vs_strCodEmp,'N']) > 0;
  end;

  procedure pImprimirFilasConfiguradas;
    Var
      qryFilas: TUniQuery;
  begin
    qryFilas := fCriaQuery;

    qryFilas.SQL.Add('SELECT * FROM FILBOL WHERE FIL_CODEMP = ' + QuotedStr(VS_strCodEmp));

    If VS_SpoolImpressaoCitel Then
      qryFilas.SQL.Add(' AND FIL_SPOIMP = "S" ')
    Else
      qryFilas.SQL.Add(' AND FIL_SPOIMP = "N" ');

    qryFilas.Open;

    qryFilas.First;

    While Not qryFilas.Eof Do
    Begin
      If fImprimirBoletos(documento, blnPergunta, strTextoPergunta, strNomeForm,
                          fIdentificarNomeDaImpressora(qryFilas.FieldByName('FIL_NOMIMP').AsString),
                          qryFilas.FieldByName('FIL_WHERE_').AsString + strFiltroSQL) Then
      Begin
        Break;
      End;

      qryFilas.Next;
    End;

    FreeAndNil(qryFilas);
  end;

begin
  strFiltroSQL := '';

  If (documento.fltBolAdt > 0) And
     (documento.strEspDoc = 'PD') And
     (fPedidoTemBoletoAdiantamento(documento.strNumDoc,documento.strEspDoc,documento.strEmpDoc)) Then
  Begin
    //Duplicatas já enviadas para o banco não devem mais imprimir o boleto
    strFiltroSQL := ' AND CTR_BCOENV IS NULL ';
  End;

  If (fUtilizaFilasImpressaoConfiguradas) Then
    pImprimirFilasConfiguradas
  Else
    fImprimirBoletos(documento, blnPergunta, strTextoPergunta, strNomeForm, '', strFiltroSQL);
end;

function TFatVendaImp.fImprimirBoletos(documento: TDadosImpressaoVenda;
  blnPergunta: Boolean = False; strTextoPergunta: String = ''; strNomeForm: String = 'frmFatVendas';
  strNomImpBol: String = ''; strWhereBol: String = ''): Boolean;

  Var
    strCepAnt: String;
    arrDupCtr: TArrDupCtr;
    objBoleto: TBoleto;
    qryGenCtr: TUniQuery;
    cdsBoleto: TUniClientDataSet;
    blnImpBoleto: Boolean;
    blnEmaAut   : Boolean;
begin
  Result := False;
  strCepAnt := documento.strCliCep;
  blnImpBoleto := Not blnPergunta;
  blnBoletoImpresso := False;
  Try
    Try
      qryGenCtr := fCriaQuery;

      {*****************************************}
      {* PROCESSA AS DUPLICATAS GERADAS        *}
      {**************************************AF*}
      With qryGenCtr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSQLDuplicatasBoletos(strWhereBol));
        ParamByName('NUMDUP').AsString := documento.strNumDoc;
        ParamByName('ESPDOC').AsString := documento.strEspDoc;
        ParamByName('CODEMP').AsString := documento.strEmpDoc;
        ParamByName('CODCLI').AsString := documento.strCodCli;
        Open;

        SetLength(arrDupCtr,0);
        While Not Eof Do
        Begin
          SetLength(arrDupCtr,Length(arrDupCtr)+1);
          arrDupCtr[Length(arrDupCtr)-1].strNumDup := documento.strNumDoc;
          arrDupCtr[Length(arrDupCtr)-1].strEspDoc := documento.strEspDoc;
          arrDupCtr[Length(arrDupCtr)-1].strCodEmp := documento.strEmpDoc;
          arrDupCtr[Length(arrDupCtr)-1].strCodCli := documento.strCodCli;
          arrDupCtr[Length(arrDupCtr)-1].strParcel := FieldByName('PARDUP').AsString;
          arrDupCtr[Length(arrDupCtr)-1].strAutoIn := FieldByName('AUTOINCREM').AsString;
          Next;
        End;

        If Length(arrDupCtr) > 0 Then
        Begin
          If Not blnImpBoleto Then
            blnImpBoleto := fPergunta(IIF(fEmptyStr(strTextoPergunta), 'Deseja imprimir boletos?', strTextoPergunta));

          If blnImpBoleto Then
          Begin
            objBoleto := TBoleto.Create(Self,'CADREC',True,documento.blnExpedi);
            objBoleto.strCodPor := documento.strCodPor;
            objBoleto.FCodCnd := documento.strCodCnd;
            objBoleto.FCodFpg := documento.strCodFpg;
            objBoleto.FNotaPromissoria := documento.blnNotaPro;
            cdsBoleto := fCriaClientDatset(qryGenCtr);

            blnEmaAut := fTemLayoutEmailBoletoAtivo(documento);

            if documento.strOpcDoc = 'CF' then
              objBoleto.objStatusEmailAutomatico := TStatusDisparaEmail.staConfirmandoDocumento;

            objBoleto.pImprimir(cdsBoleto, arrDupCtr, '', documento.blnBolPdf, documento.blnEnvMai, blnEmaAut, False, False, '', '', '',
                                strNomImpBol,'','',False,False,False,False,False,False,documento.blnExpediMult, documento.blnFaturadorAutomatico);

            blnBoletoImpresso := objBoleto.blnImprim;

            Result := True;
          End;
        End;

        If Assigned(cdsBoleto) Then
          FreeAndNil(cdsBoleto);

        If Assigned(objBoleto) Then
          FreeAndNil(objBoleto);
      End;



    Except
      On E: ExceptionAutCom Do
        fMensagem('ATENÇÃO', E.Message, ['&Ok']);

      On E: Exception Do
        pMensagensErro(E.Message, '[TFatVenda.pImprimeBoletos]');
    End;

  Finally
    FblnBoletoImpresso := Result;

    If Assigned(qryGenCtr) Then
      FreeAndNil(qryGenCtr);
    SetLength(arrDupCtr,0);

    strCliCep := strCepAnt;
  End;
end;

procedure TFatVendaImp.pImprimirRequisicoesDePedido(strRequisocoesPD: String);
  Var
    intContador: Integer;
    stlRequisocoesPD: TStringList;
begin
  stlRequisocoesPD := TStringList.Create;
  stlRequisocoesPD.Text := strRequisocoesPD;

  For intContador := 0 To stlRequisocoesPD.Count -1 Do
  Begin
    pImprimeRequisicaoPorPedido('', '', stlRequisocoesPD[intContador], 'PD', Vs_strCodEmp);
  End;

  stlRequisocoesPD.Destroy;
end;

procedure TFatVendaImp.pImprimeRequisicaoPorPedido(strNomeFila, strTipImp, strNumPed,
  strEspPed, strEmpPed: String);
  Var
    strNomeArquivo: String;
begin
  Try
    pImprimeFatImp('FATDOR',
                   strNumPed,
                   strEspPed,
                   strEmpPed,
                   fCadEmp('CLIFIL'),
                   'C',
                   'V',
                   False,
                   strNomeArquivo,
                   False,
                   'I',
                   1,
                   impSemPrecoGeral,
                   0,
                   False,
                   False,
                   True,
                   False,
                   strNomeFila,
                   strTipImp,
                   False,
                   False,
                   False,
                   False,
                   True,
                   False);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TFatVendaImp.pImprimeComprovantePontosProfissional(documento: TDadosImpressaoVenda);
  Var
    comprovantePontos: TComprovantePontosProfissional;
    editorFast: TFastPrintFileEditor;
    intProfiss: Integer;

    procedure pImprimirComprovante(strProfiss: String);
    begin
      If Not fEmptyStr(strProfiss) Then
      Begin
        comprovantePontos := TComprovantePontosProfissional.CreateInstance(strProfiss,
          documento.strNumDoc, documento.strEspDoc);

        editorFast.pSetFastPrintFile(comprovantePontos);

        If Not comprovantePontos.IsEmpty Then
        Begin

          If editorFast.fLoadReport Then
          Begin
            editorFast.pPrint;
          End;

        End;

      End;
    end;

begin

  If (Pos(documento.strEspDoc, 'OR_PD_') <= 0) And    { Não seja orcamento nem pedido }
     (Pos(documento.strOpcDoc, 'VN_CS_CP_') > 0) And  { Venda normal ou confirmacao de pedidos (expedicao/f11) }
     (fCfgSis('TCOPRO') = '3') And                    { Comissão do profissional por quantidade de pontos do cadastro de produtos }
     (fCfgSis('CPVPPF', varBoolean)) Then             { imprime comprovante de pontos do profissional }
  Begin
    editorFast := TFastPrintFileEditor.Create(nil);

    For intProfiss := 0 To Length(documento.Profissionais) -1 Do
      If documento.Profissionais[intProfiss].fltQtdPon > 0 Then
        pImprimirComprovante(documento.Profissionais[intProfiss].strCodDiv);

    FreeAndNil(editorFast);
  End;

end;

procedure TFatVendaImp.pImprimeOrdProItensEstrutura(arrMatItens: TMatrizFechamento);
  Var
    objOrdPro: TOrdPro;
    intIndex, intUltimaLinha, intUltIndex: Integer;
begin
  If Not fCfgSis('IMPORD', varBoolean) Then
    Exit;

  objOrdPro := TOrdPro.Create(Nil, True);

  intUltIndex := 0;
  For intIndex := Low(arrMatItens) To High(arrMatItens) Do
    If arrMatItens[intIndex].blnGerOrd Then
      intUltIndex := intIndex;

  intUltimaLinha := 0;
  For intIndex := Low(arrMatItens) To High(arrMatItens) Do
    If arrMatItens[intIndex].blnGerOrd Then
      objOrdPro.pImprimeOrdPro(arrMatItens[intIndex].strOrdPro,
                               intUltimaLinha,
                               False,
                               '',
                               True,
                               (intIndex = intUltIndex));

  FreeAndNil(objOrdPro);
end;

class function TFatVendaImp.fVerificaSeImprimeBoleto(documento: TDadosImpressaoVenda): Boolean;

  Var
    strFpgNaoImprimeBoleto : String;

  function fRetTotalDeTodasFormasNegociadasAReceberDosPedidos: Double;
    Var
      item: TDadosFechamento;
      strLisAutIncFgo: String;
      qryGen: TUniQuery;
  begin
    Result := 0;
    If (documento.strCodFpg = '009') Then
    Begin
      For item In documento.arrMatItens Do
      Begin
        pIncrementaListaStr(fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                            [item.strNumOrc, item.strEspOrc, item.strEmpOrc]), 
                           strLisAutIncFgo, 
                           True);
                          
        qryGen := fCriaQuery;
        Try
          qryGen.Close;
          qryGen.SQL.Text := 'SELECT IFNULL(SUM(FPN_VALFPG),0) FROM FPGNEG WHERE FPN_CODFPG = "015" AND FPN_SEQFGO IN ('+strLisAutIncFgo+')';                    
          qryGen.Open;

          If Not qryGen.IsEmpty Then
            Result := qryGen.Fields[0].AsFloat;
        Finally
          FreeAndNil(qryGen);
        End;
      End;
    End;
  end;

  function GetEspDocImpressaoBoleto: String;
    Var
      LMultiplosBancos : TMultiplosBancos;
  Begin
    Result := 'NF_NV_EL_NS_RL_'+ IIF(fCfgSis('BOL_IF', varBoolean), 'IF_IV_D1_', '');

    If ((fStatusCndPag(documento.strConPag) = A_PRAZO) And fCfgSis('NOTPFF', VarBoolean)) Or
       ((fStatusCndPag(documento.strConPag) = A_VISTA) And fCfgSis('BLAVFT', VarBoolean)) Then
    Begin
      Result := Result + 'FF_';
    End;

    Try
      LMultiplosBancos := TMultiplosBancos.Create(documento.strCodCnd,
                                                  documento.strCodFpg,
                                                  documento.strCodCli,
                                                  documento.strEspDoc);
      If (LMultiplosBancos.FCarregarDadosMultiplosBancos) Or ((documento.blnNotaFatFF) And (fCfgSis('DUPREC', varString) = 'N')) Then
        Result := Result + 'FF_';
    Finally
      FreeAndNil(LMultiplosBancos);
    End
  End;

begin
  With documento Do
  Begin
    {*****************************************}
    {* PROCESSA BOLETOS PARA IMPRESSÃO       *}
    {**************************************MV*}
    Result := False;

    If (Not blnLibCnf)                  And
       (Not blnNotEsp)                  And
       (Pos(strEspDoc,GetEspDocImpressaoBoleto) > 0) And
       (Pos(strOpcDoc,'DV_NC_BR_GF_') <= 0) Then
    Begin

      strFpgNaoImprimeBoleto := '010_';
      If (fCfgSis('IMBO14', varString) = 'N') Then
        strFpgNaoImprimeBoleto := strFpgNaoImprimeBoleto + '014_';

      If (fCfgSis('PFLCLI', varBoolean)                 And
          fRetCampoCndPagto(strCodCnd, 'CND_IMPBOL')    And
          fClienteImprimeBoletoPelaEmpresa(strCodCli)   And
          (Pos(strCodFpg,strFpgNaoImprimeBoleto) <= 0)  And
          (strConPag <> '01999'))                       Or

         (((Not fCfgSis('PFLCLI', varBoolean))          Or
          fRetCampoCndPagto(strCodCnd, 'CND_IMPBOL'))   And
          (fCfgSis('IMPBOL') <> 'N')                    And
          (fClienteImprimeBoletoPelaEmpresa(strCodCli)) And
          (Pos(strCodFpg,strFpgNaoImprimeBoleto) <= 0)  And
          (strConPag <> '01999'))                       Then
      Begin

        {*******************************************}
        {* IMPRIME BOLETO CASO FOR A PRAZO OU SE   *}
        {* ESTIVER CONFIGURADO PARA IMPRIMIR BOLETO*}
        {* A VISTA NO FATURAMENTO                  *}
        {***23/04/2008***************************MV*}
        If ((fStatusCndPag(strConPag) = A_PRAZO) Or (IIF(Pos(strEspDoc, 'IF_IV_D1_') > 0, False, fCfgSis('BLAVFT', varBoolean) And (Not fCfgSis(IIF(strOriF11 = 'S', 'BAVF11', 'BAIAVI'), varBoolean))) )) And
           (fFormataFloat(fltTotGer - fltDupRec - fltValAdt - fRetTotalDeTodasFormasNegociadasAReceberDosPedidos, 2) > 0.0)  And
           (Not blnMeiaNota)                                              And
           (Not blnBaiEntFut)                                             And
           (Not blnBaixaEmprestimos)                                      Then
        Begin
          Result := True;
        End;

      End;

    End;

    //Deve emitir boleto de adiantamento para pedidos de venda
    If (documento.fltBolAdt - documento.fltBolEnv > 0) And
       (documento.strEspDoc = 'PD') And
       (fPedidoTemBoletoAdiantamento(documento.strNumDoc,documento.strEspDoc,documento.strEmpDoc)) Then
    Begin
      If ((Not fCfgSis('LIBPED', varBoolean)) Or
          (fCfgSis('LPPDBL', varBoolean) And (Not documento.blnPedBlo))) Then
      Begin
        Result := True;
      End;
    End;

  End;

end;

function TFatVendaImp.fVerificaSeImprimeSeparacao(documento: TDadosImpressaoVenda; blnSEPOPI : Boolean = False): Boolean;
  Var
    strSepEntRet, strOps: String;
    objFilterMat: TFilterMatrizItens;
    objFiltersItem: TFiltersItem;
    filtro: array of TFilterItem;

  function fTemItensNaoExpedidos: Boolean;
    Var
      item: TDadosFechamento;
  begin
    Result := False;
    For item In documento.arrMatItens Do
      If item.fltQtdIte - item.fltQtdExp > 0 Then
      Begin
        Result := True;
        Break;
      End;
  end;

  function fDocumentoVendaImprimeSeparacao(): Boolean;
  var
    strMESPVN: String;
  begin
    If (Not fCfgSis('VNDSEP', varBoolean)) Then
      Result := False
    Else If documento.strEntFut = 'S' Then
      Result := String(fCfgSis('TPSPVN')).Contains('F')
    Else If documento.strEntFat = 'S' Then
      Result := String(fCfgSis('TPSPVN')).Contains('E')
    Else
      Result := String(fCfgSis('TPSPVN')).Contains('R');

    If Result and (documento.strEntFut = 'S') Then
    Begin
      strMESPVN := fCfgSis('MESPVN', varString);

      If (strMESPVN <> 'FPA') Then
      Begin
        objFilterMat := TFilterMatrizItens.Create(documento.arrMatItens);
        objFiltersItem := TFiltersItem.Create;

        With objFilterMat, objFiltersItem Do
        Begin
          pDesfazerFiltros;

          If Copy(strMESPVN,1,1) = 'F' Then
          Begin
            SetLength(filtro, Length(filtro) + 1 );
            filtro[ High(filtro) ] := fFiltraEntregaFuturaFaltaProduto;
          End;

          If Copy(strMESPVN,2,1) = 'P' Then
          Begin
            SetLength(filtro, Length(filtro) + 1 );
            filtro[ High(filtro) ] := fFiltraEntregaFuturaPrevisaoEntrega;
          End;

          If Copy(strMESPVN,3,1) = 'A' Then
          Begin
            SetLength(filtro, Length(filtro) + 1 );
            filtro[ High(filtro) ] := fFiltraEntregaFuturaAguardandoCliente;
          End;

          SetLength(filtro, Length(filtro) + 1 );
          filtro[ High(filtro) ] := fFiltraProdutoBrinde;

          fFiltrarMatriz(filtro);

          Result := Length(MatrizItens) > 0;
        End;

        objFilterMat.Destroy;
        objFiltersItem.Destroy;
      End;
    End;

  end;

begin

  Result := False;
  SetLength(filtro,0);

  If documento.blnPicOut Then
  Begin
    Exit(True);
  End

  Else If (documento.strEspDoc = 'PD') Then
  Begin
    If Not fValidarAbastecimentoEstoquePedido(documento, True) Then
      Exit(False);

    If fCfgSis('SEPOPI', varBoolean) Then
    Begin

      strOps := '';
      strOps := fGetOPs_PD(documento.strNumDoc,
                           documento.strEspDoc,
                           documento.strEmpDoc);

      If Not fEmptyStr(strOps) Then
      Begin

        If (blnSEPOPI) Then
        Begin
          fMensagem('Atenção', 'Este pedido de venda possui item estrutura com ordem de produção. ' +
                               'A separação somente poderá ser impressa depois da baixa da ordem de produção. ' +
                               'OP(s): ' + strOps + '.', ['&Ok']);
        End;

        Result := False;
        Exit;

      End;

    End;

    {*************************************************************}
    {* CASO NÃO UTILIZE LIBERACAO DE PEDIDO, IMPRIMI A SEPERAÇÃO *}
    {**********************************************************LU*}
    Result := ((Not fCfgSis('LIBPED', varBoolean)) Or
               (fCfgSis('LPPDBL', varBoolean) And (Not documento.blnPedBlo)) Or
               (fCfgSis('LPSTER', varBoolean) And documento.blnPedInterno)) And
              (documento.strEspDoc = 'PD')    And
              (fCfgSis('PEDSEP') = 'S')       And
              (Not documento.blnEnt_CD)       And
              (documento.strOriF11 <> 'S')    And
              ((documento.fltTotGer > 0) Or
                (documento.blnPedOrcBrinde))  And
              (Not fUsaRotinaWMS);

    Result := Result Or documento.blnEnt_CD Or documento.blnRetiraOutraLojaEmNovoPedido Or documento.blnRetiraExpedicaoEmNovoPedido;

    If documento.blnEmitirNovoPedidoEntregaCD Then
      Result := False;

    If (documento.strOriF11 = 'S') And (Not fCfgSis('ISCF11', varBoolean)) Then
      Result := False;
  End

  Else If (documento.strEspDoc = 'OR') Then
  Begin
    Result := (fCfgSis('SEPORC') = 'S');
  End

  Else If (documento.strEspDoc = 'EP') And (Pos(Copy(documento.strClaFis,1,1),'5_6_')> 0) Then
  Begin
    Result := (fCfgSis('IMPSEP') = 'S');
  End

  Else If fCfgSis('IPBAFT', varBoolean) And (Pos(documento.strOpcDocTrue, 'EF_BF_') > 0) Then
  Begin
    Result := True;
  End

  {**********************************************}
  {* VERIFICA SE IMPRIME SEPARAÇÃO. SOMENTE     *}
  {* SE FOR NF/IF/MI/FF/BR E NÃO FOR CONFIRMAÇÃO*}
  {****************************************MV,JB*}
  Else If (fDocumentoVendaImprimeSeparacao) And
          (Pos(documento.strEspDoc, 'NF_NV_EL_IF_IV_D1_MI_FF_BR_TE_') > 0)       And
          (Pos(documento.strOpcDoc, 'CF_CI_CT_NC_OE_EF_OF_DV_') <= 0)            Then
  Begin
    Result := True;
    //Somente imprime a separacao quando houver itens nao expedidos
    If (fCfgSis('IMSEPE', varBoolean)) Then
      Result := fTemItensNaoExpedidos;
  End

  Else If fCfgSis('SEP_TR', varBoolean) And
          ((Pos(documento.strOpcDoc, 'DV_PR_TR_DD_CR_') > 0) Or
           ((Pos(documento.strEspDoc, 'NF_') > 0) And (Pos(documento.strClaFis, fCfgSis('CLADEV')) > 0 ))
          ) Then
  Begin
    Result := True;
  End

  Else If FRecCliGar Then
  Begin
    Result := True;
  End;

  If Result Then
  Begin
    If (Pos(documento.strEspDoc, 'PD_OR_') > 0) And (Not documento.blnSepFut) Then
    Begin
      strSepEntRet := fCfgSis('TPSPPV');

      If Not fEmptyStr(strSepEntRet) Then
      Begin
        objFilterMat := TFilterMatrizItens.Create(documento.arrMatItens);
        objFiltersItem := TFiltersItem.Create;

        With objFilterMat, objFiltersItem Do
        Begin
          pDesfazerFiltros;

          If Copy(strSepEntRet,1,1) = 'R' Then
          Begin
            SetLength(filtro, Length(filtro) + 1 );
            filtro[ High(filtro) ] := fFiltraRetira;
          End;

          If Copy(strSepEntRet,2,1) = 'E' Then
          Begin
            SetLength(filtro, Length(filtro) + 1 );
            filtro[ High(filtro) ] := fFiltraEntregaImediata;
          End;

          If Copy(strSepEntRet,3,1) = 'F' Then
          Begin
            SetLength(filtro, Length(filtro) + 1 );
            filtro[ High(filtro) ] := fFiltraEntregaFutura;
          End;

          SetLength(filtro, Length(filtro) + 1 );
          filtro[ High(filtro) ] := fFiltraProdutoBrinde;

          fFiltrarMatriz(filtro);

          Result := Length(MatrizItens) > 0;
        End;

        objFilterMat.Destroy;
        objFiltersItem.Destroy;
      End;
    End;
  End;
end;

class function TFatVendaImp.fGetOPs_PD(strNumDoc, strEspDoc, strEmpDoc: String): String;
Var
  qryOps: TUniQuery;
begin

  Result := '';

  qryOps := fCriaQuery;

  try

    qryOps.Close;
    qryOps.SQL.Clear;
    qryOps.SQL.Add('SELECT');
    qryOps.SQL.Add('  GROUP_CONCAT(');
    qryOps.SQL.Add('  (SELECT');
    qryOps.SQL.Add('    PRO_CODPRO');
    qryOps.SQL.Add('  FROM');
    qryOps.SQL.Add('    MOVPRO');
    qryOps.SQL.Add('  WHERE PRO_CODPRO = FDO_ORDPRO');
    qryOps.SQL.Add('    AND PRO_CODEMP = FDO_CODEMP');
    qryOps.SQL.Add('    AND PRO_DTABAI IS NULL) SEPARATOR ", ") AS OPS');
    qryOps.SQL.Add('FROM');
    qryOps.SQL.Add('  FATDOR');
    qryOps.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC');
    qryOps.SQL.Add('  AND FDO_ESPDOC = :ESPDOC');
    qryOps.SQL.Add('  AND FDO_CODEMP = :CODEMP');

    qryOps.ParamByName('NUMDOC').AsString := strNumDoc;
    qryOps.ParamByName('ESPDOC').AsString := strEspDoc;
    qryOps.ParamByName('CODEMP').AsString := strEmpDoc;

    qryOps.Open;

    If Not qryOps.IsEmpty Then
      Result := qryOps.FieldByName('OPS').AsString;

  finally
    FreeAndNil(qryOps);
  end;

end;

function TFatVendaImp.fGetSetores(documento: TDadosImpressaoVenda; strItens: String): TStringArray;
  Var
    strCampoFisico: string;
    strCampo: string;
    qryAux: TUniQuery;
    blnAchouFilaSetor : Boolean;

begin
  qryAux := fCriaQuery();

  With qryAux Do
  Begin

    If (fCfgSis('GRUSEP', VarString) = 'S') Then
    Begin
      strCampo       := 'LSE_DESCRI';
      strCampoFisico := 'LSE_DESCRI';
    End
    Else
    Begin
      strCampo       := 'LEFT(ITE_LOCFIS, 1)';
      strCampoFisico := 'ITE_LOCFIS';
    End;

    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  DISTINCT ' + strCampo + ' AS SETOR_ ');
    SQL.Add('FROM ');
    SQL.Add('  ITEGER ');

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      SQL.Add(' LEFT JOIN CADLOC CL ON CL.LOC_CODLOC = ITEGER.ITE_LOCFIS AND CL.LOC_CODEMP = ITEGER.ITE_CODEMP ');
      SQL.Add(' LEFT JOIN CADLSE ON CADLSE.LSE_CODIGO = CL.LOC_CODLSE ');
    end
    else
      SQL.Add('  LEFT JOIN CADLSE ON ITEGER.ITE_CODLSE = CADLSE.LSE_CODIGO ');

    SQL.Add('WHERE ');
    SQL.Add('  ('+strCampoFisico+' <> "" AND '+strCampoFisico+' IS NOT NULL) AND ');
    SQL.Add('  LOCATE(ITE_CODITE, ' + QuotedStr( strItens ) + ') > 0 AND ');
    SQL.Add('  ITE_CODEMP = :CODEMP ');

    If (fCfgSis('GRUSEP', VarString) = 'F') Then
      SQL.Add(' AND LOCATE('+strCampo+', "ABCDEFGHIJKLMNOPQRSTUVWXYZ") > 0 ');
      
    If (Not fEmptyStr(documento.strCodLsePorSetor)) Then
      SQL.Add(' AND CADLSE.LSE_CODIGO = '+QuotedStr(documento.strCodLsePorSetor));
    
    SQL.Add('ORDER BY ');
    SQL.Add('  SETOR_ ');

    If fCfgSis('SPLCIT', varBoolean) Then
    Begin
      ParamByName('CODEMP').AsString := documento.strEmpDoc;
    End
    Else
    Begin 
      ParamByName('CODEMP').AsString := VS_strCodEmp;
    End;

    Open;

    SetLength(Result, 0);

    If Not IsEmpty Then
    begin
      First;
      While Not EOF Do
      Begin

        If (fCfgSis('GRUSEP', VarString) = 'S') And (documento.strEspDoc = 'PD') Then
        Begin

          blnAchouFilaSetor := False;

          If (fTemFilaSepSetorEntRet(FieldByName('SETOR_').AsString, NOME_FILA_ENTREGA)) And
             (fTemItensEntRetSetor(documento, FieldByName('SETOR_').AsString, 'E')) Then
          Begin
            blnAchouFilaSetor := True;
            pAddDados(Result, FieldByName('SETOR_').AsString + '_' + NOME_FILA_ENTREGA );
          End;

          If (fTemFilaSepSetorEntRet(FieldByName('SETOR_').AsString, NOME_FILA_RETIRA)) And
             (fTemItensEntRetSetor(documento, FieldByName('SETOR_').AsString, 'R')) Then
          Begin
            blnAchouFilaSetor := True;
            pAddDados(Result, FieldByName('SETOR_').AsString + '_' + NOME_FILA_RETIRA );
          End;

          If (Not blnAchouFilaSetor) Then
            pAddDados(Result, FieldByName('SETOR_').AsString);

        End
        Else
          pAddDados(Result, FieldByName('SETOR_').AsString);

        Next;
      End;
    End;
  End;

  FreeAndnil(qryAux);
end;

class function TFatVendaImp.fGetSQLDuplicatasBoletos(strWhereBol: String = ''): String;
  Var
    strSQL: String;
    blnImpNmPed: Boolean;
begin
  blnImpNmPed := fCfgSis('IPDMER', varBoolean);

  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  CADREC.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
  strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CTR_PARCEL,           ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  IF((CTR_NOSNUM IS NOT NULL) OR (COALESCE(CTR_BCOBOL, "") = "999" AND CTR_DTABOL IS NOT NULL), "Sim", "Não") AS CTR_BOLETO, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_EMAIL_, ';
  strSQL := strSQL + '  CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_OBSAG1, ';
  strSQL := strSQL + '  CTR_OBSAG2, ';
  strSQL := strSQL + '  CTR_OBSAG3, ';
  strSQL := strSQL + '  CTR_PERDPO, ';
  strSQL := strSQL + '  CTR_QTDDAV, ';
  strSQL := strSQL + '  IFNULL(CTR_BCOBOL, "") AS CTR_BCOBOL, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  "M" AS CTR_MARDES ';

  If blnImpNmPed Then
    strSQL := strSQL + ', M.DET_NUM_PD AS NUMPED '
  Else
    strSQL := strSQL + ', "" AS NUMPED ';

  strSQL := strSQL + '  , CTR_OBSV01 AS CTR_OBSV01  ';
  strSQL := strSQL + '  , CTR_OBSV02 AS CTR_OBSV02  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC ';

  strSQL := strSQL + '  INNER JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ON CTR_NUMDUP = MOVGER.GER_NUMDOC ';
  strSQL := strSQL + '                  AND CTR_ESPDOC = MOVGER.GER_ESPDOC ';
  strSQL := strSQL + '                  AND CTR_CODEMP = MOVGER.GER_CODEMP ';
  strSQL := strSQL + '                  AND CTR_CODCLI = MOVGER.GER_CODCLI ';
  strSQL := strSQL + '                  AND MOVGER.GER_ORIDOC = "V" ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ON CTR_NUMDUP = NOTGER.GER_NUMDOC ';
  strSQL := strSQL + '                  AND CTR_ESPDOC = NOTGER.GER_ESPDOC ';
  strSQL := strSQL + '                  AND CTR_CODEMP = NOTGER.GER_CODEMP ';
  strSQL := strSQL + '                  AND CTR_CODCLI = NOTGER.GER_CODCLI ';
  strSQL := strSQL + '                  AND NOTGER.GER_ORIDOC = "V" ';

  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = COALESCE(MOVGER.GER_CODVEN, NOTGER.GER_CODVEN) ';

  If blnImpNmPed Then
  Begin
    strSQL := strSQL + '  LEFT JOIN MOVDET M ON CTR_CODEMP = M.DET_CODEMP AND ';
    strSQL := strSQL + '                        CTR_NUMDUP = M.DET_NUMDOC AND ';
    strSQL := strSQL + '                        CTR_ESPDOC = M.DET_ESPDOC AND ';
    strSQL := strSQL + '                        CTR_CODCLI = M.DET_CODCLI ';
  End;

  strSQL := strSQL + 'WHERE ';

  If Not fCfgSisL('BLAVFT', varBoolean) Then
    strSQL := strSQL + '  ((CTR_DTACAD <> CTR_DTAVEN) OR (CTR_ADTCLI = "S")) AND ';

  strSQL := strSQL + '  CTR_DTAREC IS NULL   AND ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(strWhereBol) Then
    strSQL := strSQL + IIF(LeftStr(Trim(strWhereBol), 3) = 'AND', '', ' AND ') + strWhereBol;

  Result := strSQL;
end;

function TFatVendaImp.fImpressaoDaSeparacaoEhDePickingCheckOut(documento: TDadosImpressaoVenda): Boolean;
begin

  Result := False;

  If Not (documento.blnImprimeSep) Then
    Exit;

  If Not (Pos(documento.strEspDoc, 'PD_OR_') > 0) Then
    Exit;

  If Not (TPickingCheckOut.fWMSUtilizaPickingCheckOut) Then
    Exit;

  If Not (TPickingCheckOut.fDocumentoTemAlgumItemRetiraCaixa(documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc)) Then
    Exit;

  Result := True;

end;

function TFatVendaImp.fImprimeContratoCarnePagamento(
  documento: TDadosImpressaoVenda): Boolean;
Const
  ESP_CUPOM = 'IF_IV_';
  ESP_NOTA  = 'NF_NV_EL_NS_';
  ESP_FF    = 'FF_';
Var
  intEspCar : Integer;
  blnOrdPgto: Boolean;
begin
  blnOrdPgto := documento.strCodFpg = '012';

  {*********************************************************************}
  {* VERIFICA A ESPÉCIE QUE IRÁ IMPRIMIR O CONTRATO/CARNE DE PAGAMENTO *}
  {******************************************************************PZ*}
  intEspCar := fCfgSis('ESPCAR', VarInteger);
  Result    := fCfgSis('IMPCAR', VarBoolean) And
              (Not fEmptyStr(documento.strCodigoBarrasContrato)) And
              (Not blnOrdPgto);

  {**********************************************************************}
  {* CASO ESTEJA CONFIGURADO PARA IMPRIMIR CONTRATO/CARNE DE PAGAMENTO, *}
  {* VALIDA AS ESPÉCIES                                                 *}
  {*******************************************************************PZ*}
  If (Result) Then
  Begin
    Case  intEspCar of
      1 : Result := (Pos(documento.strEspDoc, ESP_CUPOM) > 0);
      2 : Result := (Pos(documento.strEspDoc, ESP_NOTA) > 0);
      3 : Result := (Pos(documento.strEspDoc, ESP_CUPOM + ESP_NOTA) > 0);
      4 : Result := (Pos(documento.strEspDoc, ESP_FF) > 0);
      5 : Result := (Pos(documento.strEspDoc, ESP_CUPOM + ESP_NOTA + ESP_FF) > 0);
    Else
      Result := False;
    End;

    If Result And fCfgSis('IMPCAF', varBoolean) Then
      Result := True;
  End;
end;

function TFatVendaImp.fUtilizaFilaImpressaoSepCd(const documento: TDadosImpressaoVenda): Boolean;
begin
  Result := documento.blnEnt_CD;

  If Result Then
    If (Self.blnPDORMultiLoja Or fCfgSis('IGLGSP', varBoolean)) And
       (fUtilizaFilasImpressaoConfiguradas(documento)) And
       (Not fFilaExiste('frmFatVendas_sepcd')) Then
      Result := False;
end;

function TFatVendaImp.fUtilizaFilasImpressaoConfiguradas(const documento: TDadosImpressaoVenda): Boolean;
  Var
    strSepTipDoc: String;
begin
  If (Pos(documento.strEspDoc, 'PD_PR_OR_') > 0) Then
    strSepTipDoc := 'P'
  Else
    strSepTipDoc := 'V';

  Result := (fCampoTabela('COUNT(0)','FILSEP',['FIL_CODEMP', 'FIL_TIPDOC', 'FIL_SPOIMP', 'FIL_NOMMAQ'], [Vs_strCodEmp, strSepTipDoc, IIF(VS_SpoolImpressaoCitel,'S','N'), VS_WorkstationID]) > 0);
  If (Not Result) Then
    Result := (fCampoTabela('COUNT(0)','FILSEP',['FIL_CODEMP', 'FIL_TIPDOC', 'FIL_SPOIMP', 'IFNULL(FIL_NOMMAQ, "")'],[Vs_strCodEmp, strSepTipDoc, IIF(VS_SpoolImpressaoCitel,'S','N'), '']) > 0);
end;

function TFatVendaImp.fImprimeSeparacao(documento : TDadosImpressaoVenda;
                                        strNomeFila,
                                        strTipImp : String;
                                        blnFilEnt : Boolean = False;
                                        intQtdVias: Integer = -1;
                                        strCodIte : String = ''): Boolean;
  Var
    strSetor,
    strNomTbl,
    strSepEntRet,
    strSepEntRetAnt,
    strWhereSep,
    strSetorPar,
    strItensSemSetor,
    strSepTipDoc: String;
    intCont     : Integer;
    Setores     : TStringArray;
    strWhereTmp: String;
    strCodLayFilSep: String;
    objImpSep: TImprimirSeparacao;

  Const
    FILA_PARA_DOCUMENTOS_URGENTES = 'FRMFATVENDAS_SEP_URGENTE';

  procedure pDefineNroVias;
  begin
    If intQtdVias = -1 Then
    Begin
      intQtdVias := 1;
      If (fCfgSis('VIA_SE') = 'S') Then
      Begin
        If (documento.strEspDoc = 'PD') And (fStatusCndPag(documento.strConPag) = A_PRAZO) Then
        Begin
          intQtdVias := fGetMenu('Qtd. Vias ' + documento.strNumDoc + '-' + documento.strEspDoc, ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
        End
        Else
        Begin
          intQtdVias := fGetMenu('Qtd. Vias Separação ' + documento.strNumDoc + '-' + documento.strEspDoc,
                                ['Não Imprimir','1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
          If intQtdVias = 1 Then
            intQtdVias := -1
          Else
            intQtdVias := intQtdVias - 1;
        End;
      End
      Else
      Begin
        If fCfgSis('QTDVSE') > 1 Then
          intQtdVias := fCfgSis('QTDVSE');
      End;
    End;
  end;

  function fImprimeSeparacaoPorSetor: Boolean;
  begin
    Result := (fCfgSis('SEPSET', VarBoolean)) And
              (Not (documento.blnEnt_CD And fFilaExiste('frmFatVendas_sepcd'))) And
              (Not documento.blnBaiEntFut)    And
              (Not documento.blnSepFut)       And
              (Not (opcAgrupaPor = opcPedido));
  end;

  function fImprimeSeparacaoGeral: Boolean;
  begin
    Result := Not fImprimeSeparacaoPorSetor Or fCfgSis('SEPGER', VarBoolean);
  end;

  Function fSeparaPorCliente(strSetor: String): Boolean;
    Var
      qryAux: TUniQuery;
  Begin
    Result := False;
    qryAux := fCriaQuery();

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  LSE_FORMAT ');
      SQL.Add('FROM ');
      SQL.Add('  CADLSE ');
      SQL.Add('WHERE ');
      SQL.Add('  LSE_DESCRI = :SETOR_ ');
      ParamByName('SETOR_').AsString := strSetor;
      Open;

      If Not IsEmpty Then
        Result := (FieldByName('LSE_FORMAT').AsString = 'C');
    End;

    FreeAndNil(qryAux);
  End;

begin

  Try

    If (Pos(documento.strEspDoc, 'PD_PR_OR_') > 0) Then
    begin
      strNomTbl := 'FATDOR';
      strSepTipDoc := 'P';
    end
    Else
    begin
      strNomTbl := 'MOVDET';
      strSepTipDoc := 'V';
    end;

    pDefineNroVias;

    Result := (intQtdVias > 0);

    strWhereSep := '';
    strCodLayFilSep := EmptyStr;

    If (Result) And fEmptyStr(strNomeFila) And
       (Self.blnPDORMultiLoja Or fCfgSis('IGLGSP', varBoolean)) And
       (fUtilizaFilasImpressaoConfiguradas(documento)) Then
      documento.cdsLogSep := nil;

    If (Result) And fEmptyStr(strNomeFila)  And
       (Not Assigned(documento.cdsLogSep))  And
       (fUtilizaFilasImpressaoConfiguradas(documento)) Then
    Begin
      With TImprimirSeparacaoFilasConfiguradas.Create(strNomTbl, strSepTipDoc, opcAgrupaPor,
        documento, FFiltraPorPedido, intQtdVias, strTipImp, blnFilEnt, blnPDORMultiLoja,
        strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp) Do
      Begin
        Execute;
        Free;
      End;
      Exit;
    End;

    If (Pos(documento.strOpcDoc, 'PD_OR_VN') > 0) And (Not documento.blnSepFut) Then
    Begin
      If (Copy(fCfgSis('TPSPPV',varString),1,1) = 'R') And (Copy(fCfgSis('TPSPPV',varString),2,1) = 'E') Then
        strSepEntRet := ''
      Else
      If (Copy(fCfgSis('TPSPPV',varString),1,1) = 'R') Then
        strSepEntRet := 'R'
      Else
        strSepEntRet := 'E';
    End;

    If (documento.strOpcDoc = 'VN') And (documento.strEntFut = 'S') And (fCfgSis('MESPVN', varString) <> 'FPA') Then
    Begin
      strWhereTmp := '';
      If Copy(fCfgSis('MESPVN', varString),1,1) = 'F' Then
        strWhereTmp := IIF(fEmptyStr(strWhereTmp), '', strWhereTmp + ',') + QuotedStr('F');

      If Copy(fCfgSis('MESPVN', varString),2,1) = 'P' Then
        strWhereTmp := IIF(fEmptyStr(strWhereTmp), '', strWhereTmp + ',') + QuotedStr('P');

      If Copy(fCfgSis('MESPVN', varString),3,1) = 'A' Then
        strWhereTmp := IIF(fEmptyStr(strWhereTmp), '', strWhereTmp + ',') + QuotedStr('A');

      strWhereSep := ' AND ((DET_ENTFUT = "S" AND DET_MOTFUT IN (' + strWhereTmp + ')) OR DET_ENTFUT <> "S") '
    End;

    {***************************************************************}
    {* SE TIVER ALGUM ITEM SEM SETOR, DEVE INTERROMPER A IMPRESSÃO *}
    {************************************************************MM*}
    strItensSemSetor := Trim(fItensComSetorNaoCadastrado(documento.strNumDoc,
                                                         documento.strEspDoc,
                                                         documento.strEmpDoc,
                                                         documento.strCodCli,
                                                         documento.strOpcDocTrue));
    If (Result) And
       (Not blnSepFin) And
       (fImprimeSeparacaoPorSetor) And
       (Not fEmptyStr(strItensSemSetor)) Then
    Begin
      fMensagem('', 'Há produto(s) com '+IfThen(fCfgSis('GRUSEP', VarString) = 'S',
                    'o Local da Separação não preenchido. ','a Localização Física não preenchida. ') + #13#10 +
                    'Atualize o(s) item(s) ' + strItensSemSetor + ' antes de imprimir!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If Result Then
    Begin
      strSetor := ' ';

      strSetorPar := strSetor;

      // Separação Fina, imprime por pedido, independente de setor!
      If (blnSepFin) Then
      Begin
        opcAgrupaPor := opcPedido;
        objImpSep := TImprimirSeparacao.Create(documento.strOpcDoc,
          documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, documento.strNumRom,
          strNomTbl, opcAgrupaPor, blnFiltraPorPedido, intQtdVias, strNomeFila, strTipImp, blnFilEnt, blnPDORMultiLoja,
          strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp, strWhereSep, strCodLayFilSep,
          documento.strCodLse, documento.blnConfOrcamento, documento.blnQtdOri, documento.blnExpedi, documento.blnEnt_CD,
          documento.blnSepFut, documento.cdsLogSep, documento.strMensNovo, documento.strMensExcluido,
          documento.dtaSepFut, documento.hraSepFut, documento.blnPicOut, documento.blnExpFatAut);
        try
          objImpSep.pImprimirSep;
        finally
          FreeAndNil(objImpSep);
        end;
      End
      Else
      Begin

        If fImprimeSeparacaoGeral Then
        Begin
          objImpSep := TImprimirSeparacao.Create(documento.strOpcDoc,
            documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, documento.strNumRom,
            strNomTbl, opcAgrupaPor, blnFiltraPorPedido, intQtdVias, strNomeFila, strTipImp, blnFilEnt, blnPDORMultiLoja,
            strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp, strWhereSep, strCodLayFilSep,
            documento.strCodLse, documento.blnConfOrcamento, documento.blnQtdOri, documento.blnExpedi, documento.blnEnt_CD,
            documento.blnSepFut, documento.cdsLogSep, documento.strMensNovo, documento.strMensExcluido,
            documento.dtaSepFut, documento.hraSepFut, documento.blnPicOut, documento.blnExpFatAut);
          try
            If opcAgrupaPor = opcPedido Then
              objImpSep.pImprimeDocs()
            Else
              objImpSep.pImprimirSep;
          finally
            FreeAndNil(objImpSep);
          end;
        End;

        If fDocumentoComEntregaUrgente(documento.strNumDoc,
                                       documento.strEspDoc,
                                       documento.strEmpDoc,
                                       documento.strCodCli) And fFilaExiste(FILA_PARA_DOCUMENTOS_URGENTES) Then
        Begin

          pCarregaConfImpr(qryCfgRel, FILA_PARA_DOCUMENTOS_URGENTES);
          strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

          objImpSep := TImprimirSeparacao.Create(documento.strOpcDoc,
            documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, documento.strNumRom,
            strNomTbl, opcAgrupaPor, blnFiltraPorPedido, intQtdVias, strNomeFila, strTipImp, blnFilEnt, blnPDORMultiLoja,
            strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp, strWhereSep, strCodLayFilSep,
            documento.strCodLse, documento.blnConfOrcamento, documento.blnQtdOri, documento.blnExpedi, documento.blnEnt_CD,
            documento.blnSepFut, documento.cdsLogSep, documento.strMensNovo, documento.strMensExcluido,
            documento.dtaSepFut, documento.hraSepFut, documento.blnPicOut, documento.blnExpFatAut);
          try
            If opcAgrupaPor = opcPedido Then
              objImpSep.pImprimeDocs()
            Else
              objImpSep.pImprimirSep;
          finally
            FreeAndNil(objImpSep);
          end;
        End

        Else

        If fImprimeSeparacaoPorSetor Then
        Begin

          If fEmptyStr(strCodIte) Then
          Begin
            With documento Do
              For intCont := Low(arrMatItens) To High(arrMatItens) Do
              Begin
                If ( (arrMatItens[intCont].strEntRet = 'R') And (Copy(fCfgSis('TPSPPV',varString),1,1) = 'R') ) Or
                   ( (arrMatItens[intCont].strEntRet = 'E') And (arrMatItens[intCont].strEntFut = 'N') And (Copy(fCfgSis('TPSPPV',varString),2,1) = 'E')) Or
                   ( (arrMatItens[intCont].strEntRet = 'E') And (arrMatItens[intCont].strEntFut = 'S') And (Copy(fCfgSis('TPSPPV',varString),3,1) = 'F')) Then
                  strCodIte := strCodIte + '"' + arrMatItens[intCont].strCodIte + '",';
              End;
          End;

          If Not fEmptyStr(strCodIte) Then
          Begin
            If strCodIte[Length(strCodIte)] = ',' Then
            Begin
              strCodIte[Length(strCodIte)] := ' ';
              strCodIte := Trim(strCodIte);
            End;
          End;

          Setores := fGetSetores(documento, strCodIte);

          strSepEntRetAnt := strSepEntRet;

          For strSetor In Setores Do
          Begin
            strSetorPar := strSetor;

            If (fCfgSis('GRUSEP', VarString) = 'S') And (documento.strEspDoc = 'PD') Then
            Begin
              If (Pos(NOME_FILA_RETIRA, strSetor) > 0) Then
              Begin
                strSepEntRet := 'R';
                Delete(strSetorPar, (Pos(NOME_FILA_RETIRA, strSetor)) - 1, Length(NOME_FILA_RETIRA) + 1);
              End
              Else If (Pos(NOME_FILA_ENTREGA, strSetor) > 0) Then
              Begin
                strSepEntRet := 'E';
                Delete(strSetorPar, (Pos(NOME_FILA_ENTREGA, strSetor)) - 1, Length(NOME_FILA_ENTREGA) + 1);
              End
              Else
                strSepEntRet := strSepEntRetAnt;
            End;

            If blnPreRomaneio And fSeparaPorCliente(strSetorPar) Then
            Begin
              If opcAgrupaPor = opcNaoAgrupa Then
                opcAgrupaPor := opcCliente;
              objImpSep := TImprimirSeparacao.Create(documento.strOpcDoc,
                documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, documento.strNumRom,
                strNomTbl, opcAgrupaPor, blnFiltraPorPedido, intQtdVias, strNomeFila, strTipImp, blnFilEnt, blnPDORMultiLoja,
                strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp, strWhereSep, strCodLayFilSep,
                documento.strCodLse, documento.blnConfOrcamento, documento.blnQtdOri, documento.blnExpedi, documento.blnEnt_CD,
                documento.blnSepFut, documento.cdsLogSep, documento.strMensNovo, documento.strMensExcluido,
                documento.dtaSepFut, documento.hraSepFut, documento.blnPicOut, documento.blnExpFatAut);
              try
                objImpSep.pImprimeDocs(fRetCodLse(strSetorPar));
              finally
                FreeAndNil(objImpSep);
              end;
            End
            Else
            Begin
              opcAgrupaPor := opcNaoAgrupa;
              objImpSep := TImprimirSeparacao.Create(documento.strOpcDoc,
                documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, documento.strNumRom,
                strNomTbl, opcAgrupaPor, blnFiltraPorPedido, intQtdVias, strNomeFila, strTipImp, blnFilEnt, blnPDORMultiLoja,
                strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp, strWhereSep, strCodLayFilSep,
                documento.strCodLse, documento.blnConfOrcamento, documento.blnQtdOri, documento.blnExpedi, documento.blnEnt_CD,
                documento.blnSepFut, documento.cdsLogSep, documento.strMensNovo, documento.strMensExcluido,
                documento.dtaSepFut, documento.hraSepFut, documento.blnPicOut, documento.blnExpFatAut);
              try
                objImpSep.pImprimirSep;
              finally
                FreeAndNil(objImpSep);
              end;
            End;

          End;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fImprimeSeparacao]');
    End;
  End;
end;

function TFatVendaImp.fItensComSetorNaoCadastrado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOpcDocTrue: String): String;
  Var
    qryAux  : TUniQuery;
    strCampo: String;
    strCodEmpInn: String;
Begin
  Result := EmptyStr;
  qryAux := fCriaQuery();

  If fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    strCampo := 'IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI)'
  Else
  If (fCfgSis('GRUSEP', VarString) = 'S') Then
    strCampo := 'LSE_DESCRI'
  Else
    strCampo := 'ITE_LOCFIS';

  strCodEmpInn := ' FDO_CODEMP ';
  If (Pos(strOpcDocTrue, 'EI_') > 0) Then
    strCodEmpInn := ' IF(TRIM(IFNULL(EXTGOR.FGO_EMPEXP, "")) <> "", EXTGOR.FGO_EMPEXP, FATDOR.FDO_CODEMP) ';

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  GROUP_CONCAT(DISTINCT  " ", ITE_CODITE) AS CODITE ');
    SQL.Add('FROM ');
    SQL.Add('  FATDOR ');
    SQL.Add('     LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATDOR.FDO_SEQGER ');
    SQL.Add('    INNER JOIN ITEGER ON ITEGER.ITE_CODITE = FATDOR.FDO_CODITE ');
    SQL.Add('                     AND ITEGER.ITE_CODEMP = ' + strCodEmpInn);

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      SQL.Add(' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FATDOR.FDO_CODITE AND LT.LOT_CODEMP = FATDOR.FDO_CODEMP AND LT.LOT_NUMLOT = FATDOR.FDO_NUMLOT ');
      SQL.Add(' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
      SQL.Add(' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = ITEGER.ITE_LOCFIS AND CL2.LOC_CODEMP = ITEGER.ITE_CODEMP ');
      SQL.Add(' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ');
      SQL.Add(' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ');
    end
    else
      SQL.Add('  LEFT  JOIN CADLSE ON ITEGER.ITE_CODLSE = CADLSE.LSE_CODIGO ');

    SQL.Add('WHERE IFNULL(' + strCampo + ',"") = "" ');
    SQL.Add('  AND FATDOR.FDO_NUMDOC = :NUMDOC ');
    SQL.Add('  AND FATDOR.FDO_ESPDOC = :ESPDOC ');
    SQL.Add('  AND FATDOR.FDO_CODEMP = :CODEMP ');
    SQL.Add('  AND FATDOR.FDO_CODCLI = :CODCLI ');

    If (fCfgSis('USASER', varBoolean)) Then Begin
      SQL.Add('  AND FATDOR.FDO_CODITE <> :ITESER ');

      If (fCfgSis('AUTCEN', varBoolean)) Then
        SQL.Add('  AND FATDOR.FDO_CODITE <> :SERTER ');
    End;

    SQL.Add('ORDER BY ITEGER.ITE_CODITE ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    If (fCfgSis('USASER', varBoolean)) Then Begin
      ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);

      If (fCfgSis('AUTCEN', varBoolean)) Then
        ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);
    End;

    Open;

    Result := FieldByName('CODITE').AsString;
  End;

  FreeAndNil(qryAux);
end;

class function TFatVendaImp.fItensDocumento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String): String;
  Var
    qryGen   : TUniQuery;
    strQtdPen: String;
begin
  qryGen    := fCriaQuery(nil);
  try
    If Pos(strEspDoc, 'PD_OR') <= 0 Then
      strQtdPen := ' 0 '
    Else If (fCfgSis('TIPEXP', varInteger) = 4) And fCfgSis('EXPETG', varBoolean) Then
      strQtdPen := '(FDO_QTDBAI + FDO_QTDEXP)'
    Else
      strQtdPen := IIF(fCfgSis('IMSEPO', varString) = 'F', 'FDO_QTDBAI', '(FDO_QTDBAI + FDO_QTDEXP)');

    With qryGen Do
    Begin
      SQL.Add(' SELECT  DISTINCT FDO_CODITE  ');
      If Pos(strEspDoc, 'PD_OR') <= 0 Then
        SQL.Add('   FROM  MOVDET INNER JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ')
      Else
        SQL.Add('   FROM  FATDOR INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');

      SQL.Add('  WHERE  FDO_NUMDOC = :NUMDOC ');
      SQL.Add('    AND  FDO_ESPDOC = :ESPDOC ');
      SQL.Add('    AND  FDO_CODEMP = :CODEMP ');
      SQL.Add('    AND  FDO_CODCLI = :CODCLI ');
      SQL.Add('    AND (FDO_QTDITE - ' + strQtdPen + ') > 0 ');
      SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')));
      SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')));
      SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')));
      SQL.Add('    AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')));

      If Pos(strEspDoc, 'PD_OR') <= 0 Then
      Begin
        qryGen.SQL.Add(' AND DET_TIP_FC = "C"  ');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text,'FDO', 'DET');
      End;

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      Result := '';

      First;
      While Not Eof Do
      Begin

        If Not fEmptyStr(qryGen.Fields[0].AsString) Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ',';
          Result := Result + '"' + qryGen.Fields[0].AsString + '"';
        End;

        Next;
      End;

      Close;
    End;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TFatVendaImp.pAtualizaSeparadorRetira(documento: TDadosImpressaoVenda);
begin
  fExecutaSQL(' UPDATE ' +
              '   EXTGOR, ' +
              '   FATGOR  ' +
              ' SET EXTGOR.FGO_LIBSPR = "S", EXTGOR.FGO_SEPRET = ' + QuotedStr(documento.strCodVen) +
              ' WHERE EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
              '     AND FATGOR.FGO_NUMDOC = ' + QuotedStr(documento.strNumDoc) +
              '     AND FATGOR.FGO_ESPDOC = ' + QuotedStr(documento.strEspDoc) +
              '     AND FATGOR.FGO_CODEMP = ' + QuotedStr(documento.strEmpDoc) );
end;

procedure TFatVendaImp.pImprimeTicketIF(documento: TDadosImpressaoVenda);
  Var
    strNomTbl: String;
    strNomeArquivo: String;
    intQtdImp: Integer;
begin

  If SameText(documento.strOpcDoc, 'CE') Then
    Exit;

  Try
    intQtdImp := 1;

    If (fCfgSis('IMPTCK', varBoolean)) Then
    Begin
      If (fCfgSis('VIATCK', varBoolean)) Then
      Begin
        intQtdImp := fGetMenu('Qtd. Vias do Ticket', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);
      End
      Else
      Begin
        If (fCfgSis('QTDTCK', varInteger) > 1) Then
          intQtdImp := fCfgSis('QTDTCK', varInteger);
      End;
    End;

    {**************************************************}
    { DEFINE A TABELA ONDE ESTAO CONTIDOS OS REGISTROS }
    {***********************************************JB*}
    If SameText(documento.strOpcDoc, 'CF') Then
      strNomTbl := 'NOTDET'
    Else
      strNomTbl := 'MOVDET';

    pImprimeFatImp(strNomTbl, documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, 'C',
                   'V', False, strNomeArquivo, IIF(SameText(documento.strOpcDoc, 'CF'), True, False), 'I', intQtdImp, impSemPrecoGeral, 0, False, True);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeTicketIF]');
    End;
  End;

end;

procedure TFatVendaImp.pImprimeTicketNFD(documento: TDadosImpressaoVenda);
  Var
    strNomeArquivo: String;
begin
  Try
    pImprimeFatImp('MOVDET', documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, 'C',
                   'D', False, strNomeArquivo, False, 'I', 1, impComPrecoGeral, 0, False, False, True, True, '', '', False, False,
                   False, False, False, False, False, opcTodos, False, False, False, False, False,'', ' ', Nil, False,
                   '', '', '', False, opcNaoAgrupa, False, '', '', False, False, False, '', False, False, False, True);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeTicketNFD]');
    End;
  End;
end;


procedure TFatVendaImp.pImprimeTicketDVD(documento: TDadosImpressaoVenda);
  Var
    strNomeArquivo: String;
begin
  Try
    pImprimeFatImp('MOVDET', documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, 'C',
                   'D', False, strNomeArquivo, False, 'I', 1, impComPrecoGeral, 0, False, False, True, True, '', '', False, False,
                   False, False, False, False, False, opcTodos, False, False, False, False, False,'', ' ', Nil, False,
                   '', '', '', False, opcNaoAgrupa, False, '', '', False, False, False, '', False, False, False, False,
                   False, False, False, '', '', '', False, '', 0, 0, True);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeTicketDVD]');
    End;
  End;
end;

class procedure TFatVendaImp.pImprimeReciboAdiantamentoPedido(strNumDoc, strEspDoc, strEmpDoc, strCodCli: String);
  Var
    objReciboPD  : TReciboImpFiscal;
    objRecCtrPersPD: TImpRecCtrPersonalizado;
begin

  Try
    objRecCtrPersPD := TImpRecCtrPersonalizado.Create(Nil, strNumDoc,
                                                           strEspDoc,
                                                           strEmpDoc,
                                                           strCodCli,
                                                           'frmRcxResumoCaixa');
    If (Not objRecCtrPersPD.fImprimirRecibo) Then
    Begin
      Try
        objReciboPD := TReciboImpFiscal.Create(nil, strNumDoc,
                                                    strEspDoc,
                                                    strEmpDoc,
                                                    strCodCli);
        If objReciboPD.fltTotRec > 0.00 Then
          objReciboPD.fImprimirRecibo;
      Finally
        FreeAndNil(objReciboPD);
      End;
    End;

    If (objRecCtrPersPD.blnTemDup) And
       (fCfgSis('USASAT', varBoolean) Or fCfgSis('USNFCE', varBoolean)) Then
      pImprimeRelatorioGerencialParaSATeNFCe(strNumDoc, strEspDoc, strEmpDoc, strCodCli)

  Finally
    FreeAndNil(objRecCtrPersPD);
  End;

end;

class procedure TFatVendaImp.pImprimeRelatorioGerencialParaSATeNFCe(strNumDoc, strEspDoc, strEmpDoc, strCodCli: String);
  Var
    strNfeImprimirExe : String;
    i : Integer;

  function fExisteModeloRG : Boolean;
  var
    qryAux  : TUniQuery;

  begin

    Result := False;
    qryAux := fCriaQuery;

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT');
      qryAux.SQL.Add('  COUNT(*) AS TOTAL');
      qryAux.SQL.Add('FROM');
      qryAux.SQL.Add('  IMPNFE');
      qryAux.SQL.Add('WHERE NFE_MODELO = "RG"    ');
      qryAux.SQL.Add('  AND NFE_VERSAO = "1.00"  ');
      qryAux.SQL.Add('  AND NFE_CODEMP = '+ QuotedStr(VS_strCodEmp));
      qryAux.Open;

      If (Not qryAux.IsEmpty) And (qryAux.FieldByName('TOTAL').AsInteger > 0) Then
        Result := True;

    Finally
      FreeAndNil(qryAux);
    End;

  end;

begin

  If (fExisteModeloRG) Then
  Begin

    strNfeImprimirExe := ExtractFilePath(ParamStr(0)) + 'NFeImpressao.exe';

    If FileExists(strNfeImprimirExe) Then
      For i := 1 to fCfgSis('VIASRG', varInteger) do
        WinExec(PAnsiChar(AnsiString(strNfeImprimirExe+' '+'RG_IMPRIMIR '+'"'+strEmpDoc+'" "'+strNumDoc+'" "'+strEspDoc+'" "'+strCodCli+'"'+' FALSE')), SW_HIDE)
    Else
      pMensagemOk('Não foi encontrato o arquivo NFeImpressao.exe para a impressão do Relatório Gerencial.');

  End;

end;

procedure TFatVendaImp.pImprimeRequisicao(documento: TDadosImpressaoVenda);
  Var
    strNomeArquivo: String;
begin

  Try
    pImprimeFatImp('ENTDET',
                   documento.strNumDoc,
                   documento.strEspDoc,
                   documento.strEmpDoc,
                   documento.strCodCli,
                   'C',
                   'V',
                   False,
                   strNomeArquivo,
                   False,
                   'I',
                   1,
                   impSemPrecoGeral,
                   0,
                   False,
                   False,
                   True,
                   False,
                   '',
                   '',
                   False,
                   documento.blnExpedi,
                   False,
                   False,
                   True);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TFatVendaImp.pImprimeDocumentoFolhaBranca(documento: TDadosImpressaoVenda);
  Var
    strNomeArquivo: String;
begin
  Try
    If (fCfgSis('IMPF11', varBoolean) And (Pos(documento.strEspDoc, 'IF_IV_') > 0)) Or
       ((fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean)) And
        (Pos(documento.strEspDoc, 'NF_NV_IF_IV_') > 0) And fCfgSis('IMPF11', varBoolean)) Then
    Begin
      pImprimeFatImp('MOVDET', documento.strNumDoc, documento.strEspDoc,
        documento.strEmpDoc, documento.strCodCli, 'C', 'V', False, strNomeArquivo, False, 'I', 1, impComPrecoGeral, 0, False, True);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

function TFatVendaImp.fQtdeDocsEmitidosImprimemBoleto: Integer;
  Var
    intContador: Integer;
begin
  Result := 0;
  For intContador := 0 To ItemsCount -1 Do
    If Self.fVerificaSeImprimeBoleto(Self[intContador]) Then
      Inc(Result);
end;

function TFatVendaImp.fTemFilaSepSetorEntRet(strSetor: String; strEntRet: String): Boolean;
  Var
    qryCfgRel : TUniQuery;
begin
  qryCfgRel := fCriaQuery(Self);

  With qryCfgRel Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT REL_NOMPRO ');
    SQL.Add('   FROM CFGREL ');
    SQL.Add('  WHERE REL_NOMPRO = :ENTRET ');
    SQL.Add('    AND REL_CODEMP = :CODEMP ');
    ParamByName('ENTRET').AsString := 'frmFatVendas_SEP_' + strSetor + '_' + strEntRet;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := (RecordCount > 0);
    Close;
  End;

  FreeAndNil(qryCfgRel);
end;

function TFatVendaImp.fTemItensEntRetSetor(documento: TDadosImpressaoVenda; strSetor, strEntRet: String): Boolean;

  Function fGetSQLPedido: String;
  Begin
    Result := '';
    Result := Result + ' SELECT COUNT(*) CNT ';
    Result := Result + '   FROM FATDOR ';
    Result := Result + '  INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
    Result := Result + '  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = FATDOR.FDO_CODITE ';
    Result := Result + '                   AND ITEGER.ITE_CODEMP = FATDOR.FDO_CODEMP ';
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      Result := Result + ' LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FATDOR.FDO_CODITE AND LT.LOT_CODEMP = FATDOR.FDO_CODEMP AND LT.LOT_NUMLOT = FATDOR.FDO_NUMLOT ';
      Result := Result + ' LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ';
      Result := Result + ' LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = ITEGER.ITE_LOCFIS AND CL2.LOC_CODEMP = ITEGER.ITE_CODEMP ';
      Result := Result + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = CL1.LOC_CODLSE ';
      Result := Result + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = CL2.LOC_CODLSE ';
    end
    else
      Result := Result + '  LEFT  JOIN CADLSE ON ITEGER.ITE_CODLSE = CADLSE.LSE_CODIGO ';
    Result := Result + 'WHERE FDO_NUMDOC = :NUMDOC ';
    Result := Result + '  AND FDO_ESPDOC = :ESPDOC ';
    Result := Result + '  AND FDO_CODEMP = :CODEMP ';
    Result := Result + '  AND FDO_ENTRET = :ENTRET ';
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      Result := Result + '  AND IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) = :SETOR_ '
    else
      Result := Result + '  AND LSE_DESCRI = :SETOR_ ';
  End;

  Var
    qryDocume : TUniQuery;
begin
  qryDocume := fCriaQuery(Self);

  With qryDocume Do
  Begin
    Close;
    SQL.Clear;

    If Pos(documento.strEspDoc, 'PD_OR_PR_') > 0 Then
      SQL.Add( fGetSQLPedido );

    ParamByName('NUMDOC').AsString := documento.strNumDoc;
    ParamByName('ESPDOC').AsString := documento.strEspDoc;
    ParamByName('CODEMP').AsString := documento.strEmpDoc;
    ParamByName('ENTRET').AsString := strEntRet;
    ParamByName('SETOR_').AsString := strSetor;

    Open;
    Result := (FieldByName('CNT').AsInteger > 0);
    Close;
  End;

  FreeAndNil(qryDocume);
end;

class function TFatVendaImp.fTemLayoutEmailBoletoAtivo(documento: TDadosImpressaoVenda): Boolean;
var
  objEmaAut: TEmaAut;
begin
  Try
    objEmaAut := TEmaAut.Create(nil);
    objEmaAut.FOpcDoc := 'BO';

    if documento.strOpcDoc = 'CF' then
      objEmaAut.staStatus := TStatusDisparaEmail.staConfirmandoDocumento;

    Result := objEmaAut.fTemEmailAtivo;
  Finally
    FreeAndNil(objEmaAut);
  End;
end;

procedure TFatVendaImp.pLimparDocumentos;
begin
  SetLength(arrImpressaoVenda, 0);
end;

procedure TFatVendaImp.pSetCdsLogSep(index: Integer; cdsLogSep: TUniClientDataSet);
begin
  arrImpressaoVenda[index].cdsLogSep := cdsLogSep;
  arrImpressaoVenda[index].cdsLogSep.Open;
end;

procedure TFatVendaImp.pImprimeComprovanteValorComissaoProfissional(documento: TDadosImpressaoVenda);
  Var
    comprovantePontos: TComprovantePontosProfissional;
    editorFast: TFastPrintFileEditor;
    intProfiss: Integer;
begin
  If (not fVerificaSeImprimeComprovanteValorComissaoProfissional(documento)) Then
    Exit;

  editorFast := TFastPrintFileEditor.Create(nil);

  try
    For intProfiss := 0 To Length(documento.Profissionais) -1 Do
    Begin
      If (fEmptyStr(documento.Profissionais[intProfiss].strCodDiv)) then
        Continue;

      comprovantePontos := TComprovantePontosProfissional.CreateInstance(documento.Profissionais[intProfiss].strCodDiv,
                           documento.strNumDoc, documento.strEspDoc, 'CPVVPF');

      editorFast.pSetFastPrintFile(comprovantePontos);

      If (Not comprovantePontos.IsEmpty) and (editorFast.fLoadReport) Then
        editorFast.pPrint;
    End;
  Finally
    FreeAndNil(editorFast);
  End;
end;

function TFatVendaImp.fVerificaSeImprimeComprovanteValorComissaoProfissional(documento: TDadosImpressaoVenda): Boolean;
begin
  Result := (Pos(documento.strEspDoc, 'OR_PD_') <= 0) And
            (Pos(documento.strOpcDoc, 'VN_CS_CP_') > 0) And
            (fCfgSis('TCOPRO') = '1') And
            (fCfgSis('CPVPPF', varBoolean));
end;

{ TImprimirSeparacaoFilasConfiguradas }

constructor TImprimirSeparacaoFilasConfiguradas.Create(strNomTblP, strSepTipDocP: string;
                       opcAgrupaPorP: TOpcAgrupaSepRomaneio;
                       documentoP: TDadosImpressaoVenda;
                       blnFiltraPorPedidoP: Boolean;
                       intQtdViasP: Integer;
                       strTipImpP: string;
                       blnFilEntP: Boolean;
                       blnPDORMultiLojaP: Boolean;
                       strSepEntRetP: string;
                       strSetorParP: string;
                       blnRecCliGarP: Boolean;
                       blnPreRomaneioP: Boolean;
                       blnSomenteNaoImpP: Boolean);
begin
  inherited Create;
  intQtdVias := intQtdViasP;
  strSepTipDoc := strSepTipDocP;
  opcAgrupaPor := opcAgrupaPorP;
  documento := documentoP;
  strNomTbl := strNomTblP;
  strTipImp := strTipImpP;
  blnFilEnt := blnFilEntP;
  strSepEntRet := strSepEntRetP;
  strSetorPar := strSetorParP;
  blnRecCliGar := blnRecCliGarP;
  blnPreRomaneio := blnPreRomaneioP;
  blnSomenteNaoImp := blnSomenteNaoImpP;
  blnPDORMultiLoja := blnPDORMultiLojaP;
  blnFiltraPorPedido := blnFiltraPorPedidoP;
end;

destructor TImprimirSeparacaoFilasConfiguradas.Destroy;
begin
  inherited;
end;

procedure TImprimirSeparacaoFilasConfiguradas.Execute;
  Var
    qryFilas: TUniQuery;
    objImpSep: TImprimirSeparacao;
    blnVaiTerDadosParaImprimir : Boolean;
    tpeTipEtq : TTipoEtiqueta;
begin
  inherited;
  try
    qryFilas := fCriaQuery;
    try
      qryFilas.SQL.Add('SELECT * FROM FILSEP WHERE FIL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND FIL_TIPDOC = ' + QuotedStr(strSepTipDoc)+ ' AND FIL_NOMMAQ = '+ QuotedStr(VS_WorkstationID));

      If VS_SpoolImpressaoCitel Then
        qryFilas.SQL.Add(' AND FIL_SPOIMP = "S" ')
      Else
        qryFilas.SQL.Add(' AND FIL_SPOIMP = "N" ');

      qryFilas.Open;

      If (qryFilas.IsEmpty) Then
      Begin
        qryFilas.Close;
        qryFilas.SQL.Clear;
        qryFilas.SQL.Add('SELECT * FROM FILSEP WHERE FIL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND FIL_TIPDOC = ' + QuotedStr(strSepTipDoc) +' AND IFNULL(FIL_NOMMAQ, "") = ""');

        If VS_SpoolImpressaoCitel Then
          qryFilas.SQL.Add(' AND FIL_SPOIMP = "S" ')
        Else
          qryFilas.SQL.Add(' AND FIL_SPOIMP = "N" ');

        qryFilas.Open;
      End;

      qryFilas.First;

      While Not qryFilas.Eof Do
      Begin
        strNomeFila := fIdentificarNomeDaImpressora(qryFilas.FieldByName('FIL_NOMIMP').AsString);
        strWhereSep := qryFilas.FieldByName('FIL_WHERE_').AsString;
        strCodLayFilSep := qryFilas.FieldByName('FIL_CODLAY').AsString;
        If (qryFilas.FieldByName('FIL_SOLIMP').AsInteger = 1) Then
        Begin
          blnVaiTerDadosParaImprimir := True;
          If (Not fEmptyStr(strWhereSep)) Then
          Begin
            If (strSepTipDoc = 'P') Or (strSepTipDoc = 'O') Then
              tpeTipEtq := tpeSepPedido
            Else
              tpeTipEtq := tpeSepNota;
            blnVaiTerDadosParaImprimir := fVaiTerDadosParaImprimir(documento.strNumDoc,
                                                                   documento.strEspDoc,
                                                                   documento.strEmpDoc,
                                                                   documento.strCodCli,
                                                                   strWhereSep,
                                                                   tpeTipEtq);
          End;
          If (Not blnVaiTerDadosParaImprimir) Then
          Begin
            qryFilas.Next;
            Continue;
          End;
          If (Not TCfgRel.fExecutePrintDialog(strNomeFila)) Then
          Begin
            qryFilas.Next;
            Continue;
          End;
        End;
        objImpSep := TImprimirSeparacao.Create(documento.strOpcDoc,
          documento.strNumDoc, documento.strEspDoc, documento.strEmpDoc, documento.strCodCli, documento.strNumRom,
          strNomTbl, opcAgrupaPor, blnFiltraPorPedido, intQtdVias, strNomeFila, strTipImp, blnFilEnt, blnPDORMultiLoja,
          strSepEntRet, strSetorPar, blnRecCliGar, blnPreRomaneio, blnSomenteNaoImp, strWhereSep, strCodLayFilSep,
          documento.strCodLse, documento.blnConfOrcamento, documento.blnQtdOri, documento.blnExpedi, documento.blnEnt_CD,
          documento.blnSepFut, documento.cdsLogSep, documento.strMensNovo, documento.strMensExcluido,
          documento.dtaSepFut, documento.hraSepFut, documento.blnPicOut, documento.blnExpFatAut);
        try
          If opcAgrupaPor = opcPedido Then
            objImpSep.pImprimeDocs
          Else
            objImpSep.pImprimirSep;
        finally
          FreeAndNil(objImpSep);
        end;
        qryFilas.Next;
      End;

    finally
      FreeAndNil(qryFilas);
    end;
  finally

  end;
end;

function TImprimirSeparacaoFilasConfiguradas.fTemParametroNull(
  const qryQuery: TUniQuery): Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;
  For intCnt := 0 To Pred(qryQuery.ParamCount) Do
  Begin
    If qryQuery.Params[intCnt].IsNull Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TImprimirSeparacaoFilasConfiguradas.fVaiTerDadosParaImprimir(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strWhere : String; tpeTipEtq : TTipoEtiqueta): Boolean;
  Var
    strSQL : String;
    qrySeparacao : TUniQuery;
begin
  qrySeparacao := fCriaQuery(Nil);
  Try
    strSQL := fGetSQLSeparacao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strWhere, tpeTipEtq);
    qrySeparacao.SQL.Text := strSQL;
    Try
      qrySeparacao.ParamByName('NUMDOC').AsString := strNumDoc;
      qrySeparacao.ParamByName('ESPDOC').AsString := strEspDoc;
      qrySeparacao.ParamByName('CODEMP').AsString := strCodEmp;
      qrySeparacao.ParamByName('CODCLI').AsString := strCodCli;
      qrySeparacao.Open;
      Result := (Not qrySeparacao.IsEmpty);
      If (Not Result) Then
      Begin
        If fTemParametroNull(qrySeparacao) Then
          Result := True;
      End;
    Except
      Result := True;
    End;
  Finally
    FreeAndNil(qrySeparacao);
  End;
end;

{ TImprimirSeparacao }

constructor TImprimirSeparacao.Create(strOpcDocP: string;
                                      strNumDocP: string;
                                      strEspDocP: string;
                                      strEmpDocP: string;
                                      strCodCliP: string;
                                      strNumRomP: string;
                                      strNomTblP: string;
                                      opcAgrupaPorP: TOpcAgrupaSepRomaneio;
                                      blnFiltraPorPedidoP: Boolean;
                                      intQtdViasP: Integer;
                                      strNomeFilaP: string;
                                      strTipImpP: String;
                                      blnFilEntP: Boolean;
                                      blnPDORMultiLojaP: Boolean;
                                      strSepEntRetP: string;
                                      strSetorParP: string;
                                      blnRecCliGarP: Boolean;
                                      blnPreRomaneioP: Boolean;
                                      blnSomenteNaoImpP: Boolean;
                                      strWhereSepP: string;
                                      strCodLayFilSepP: string;
                                      strCodLseP: string;
                                      blnConfOrcamentoP: Boolean;
                                      blnQtdOriP: Boolean;
                                      blnExpediP: Boolean;
                                      blnEnt_CDP: Boolean;
                                      blnSepFutP: Boolean;
                                      cdsLogSepP: TUniClientDataSet;
                                      strMensNovoP: string;
                                      strMensExcluidoP: string;
                                      dtaSepFutP: TDate;
                                      hraSepFutP: TTime;
                                      blnPicOutP: Boolean;
                                      blnExpFatAutP: Boolean);


begin
  opcAgrupaPor := opcAgrupaPorP;
  strOpcDoc := strOpcDocP;
  strNumDoc := strNumDocP;
  strEspDoc := strEspDocP;
  strEmpDoc := strEmpDocP;
  strCodCli := strCodCliP;
  strNumRom := strNumRomP;
  strNomTbl := strNomTblP;
  intQtdVias := intQtdViasP;
  strNomeFila := strNomeFilaP;
  strTipImp := strTipImpP;
  blnFilEnt := blnFilEntP;
  strSepEntRet := strSepEntRetP;
  strSetorPar := strSetorParP;
  blnRecCliGar := blnRecCliGarP;
  blnPreRomaneio := blnPreRomaneioP;
  blnSomenteNaoImp := blnSomenteNaoImpP;
  strWhereSep := strWhereSepP;
  strCodLayFilSep := strCodLayFilSepP;
  strCodLse := strCodLseP;
  blnConfOrcamento := blnConfOrcamentoP;
  blnQtdOri := blnQtdOriP;
  blnExpedi := blnExpediP;
  blnEnt_CD := blnEnt_CDP;
  blnSepFut := blnSepFutP;
  cdsLogSep := cdsLogSepP;
  strMensNovo := strMensNovoP;
  strMensExcluido := strMensExcluidoP;
  dtaSepFut := dtaSepFutP;
  hraSepFut := hraSepFutP;
  blnPicOut := blnPicOutP;
  blnExpFatAut := blnExpFatAutP;
  FFiltraPorPedido := blnFiltraPorPedidoP;
  blnPDORMultiLoja := blnPDORMultiLojaP;
end;

procedure TImprimirSeparacao.pImprimeDocs(strSetor: String);
Var
  qryAux : TUniQuery;
Begin
  qryAux := fCriaQuery();

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  DISTINCT GER_CODCLI,      ');
    SQL.Add('           GER_NUMDOC,      ');
    SQL.Add('           GER_ESPDOC,      ');
    SQL.Add('           GER_CODEMP       ');
    SQL.Add('FROM   ROMGERX R            ');
    SQL.Add('       INNER JOIN ROMDETX D ON R.AUTOINCREM = D.DET_SEQGER ');
    SQL.Add('       LEFT  JOIN ITEGER  I ON D.DET_CODITE = I.ITE_CODITE AND D.DET_EMPROM = I.ITE_CODEMP ');
    SQL.Add('       LEFT  JOIN CADCLI  C ON R.GER_CODCLI = C.CLI_CODCLI ');
    SQL.Add('WHERE  GER_NUMROM = :NUMROM ');
    SQL.Add('AND    GER_EMPROM = :CODEMP ');

    If opcAgrupaPor = opcPedido Then
    Begin
      If Not fEmptyStr(strCodLse) Then
        SQL.Add('AND    ITE_CODLSE = :CODLSE ');

      If FFiltraPorPedido Then
      Begin
        SQL.Add('AND    GER_NUMDOC = '+ QuotedStr(strNumDoc));
        SQL.Add('AND    GER_ESPDOC = '+ QuotedStr(strEspDoc));
        SQL.Add('AND    GER_CODEMP = '+ QuotedStr(strEmpDoc));
        SQL.Add('AND    GER_CODCLI = '+ QuotedStr(strCodCli));
      End;

      SQL.Add('ORDER BY C.CLI_NOMCLI, R.GER_ESPDOC, R.GER_CODEMP, R.GER_NUMDOC ');
    End
    Else
    Begin
      If Not fEmptyStr(strSetor) Then
        SQL.Add('AND    ITE_CODLSE = :CODLSE ');

      SQL.Add('GROUP BY GER_CODCLI ');
      SQL.Add('ORDER BY GER_CODCLI ');
    End;

    if not fEmptyStr(strNumRom) then
      ParamByName('NUMROM').AsString := strNumRom
    else
      ParamByName('NUMROM').AsString := fRetNumRom(strEmpDoc,
                                                   False,
                                                   strNumDoc,
                                                   strEspDoc,
                                                   strCodCli);
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (opcAgrupaPor = opcPedido) And (Not fEmptyStr(strCodLse)) Then
      ParamByName('CODLSE').AsString := strCodLse
    Else If (Not fEmptyStr(strSetor)) Then
      ParamByName('CODLSE').AsString := strSetor;

    Open;

    First;
    While Not EOF Do
    Begin
      strCodCli := FieldByName('GER_CODCLI').AsString;
      strNumDoc := FieldByName('GER_NUMDOC').AsString;
      strEspDoc := FieldByName('GER_ESPDOC').AsString;
      strEmpDoc := FieldByName('GER_CODEMP').AsString;

      pImprimirSep;

      Next;
    End;
  End;

  FreeAndNil(qryAux);

end;

procedure TImprimirSeparacao.pImprimirSep;
Var
  strNomeArquivo: String;
begin
  pImprimeFatImp(strNomTbl,
                 strNumDoc,
                 strEspDoc,
                 strEmpDoc,
                 strCodCli,
                 'C',
                 'V',
                 False,
                 strNomeArquivo,
                 IIF(blnConfOrcamento,True,False),
                 'I',
                 intQtdVias,
                 impSemPrecoGeral,
                 0,
                 True,
                 False,
                 True,
                 blnQtdOri,
                 strNomeFila,
                 strTipImp,
                 False,
                 blnExpedi,
                 False,
                 blnFilEnt,
                 False,
                 blnPDORMultiLoja,
                 strEspDoc = 'PD',
                 opcTodos,
                 False,
                 blnEnt_CD,
                 False,
                 False,
                 blnSepFut,
                 strSepEntRet,
                 strSetorPar,
                 cdsLogSep,
                 blnRecCliGar,
                 strOpcDoc,
                 '',
                 '',
                 blnPreRomaneio,
                 opcAgrupaPor,
                 blnSomenteNaoImp,
                 strCodLse,
                 strWhereSep,
                 False,
                 False,
                 False,
                 '',
                 False,
                 False,
                 False,
                 False,
                 False,
                 False,
                 False,
                 strMensNovo,
                 strMensExcluido,
                 '',
                 False,
                 strNumRom,
                 dtaSepFut,
                 hraSepFut,
                 False,
                 '',
                 True,
                 False,
                 blnPicOut,
                 strCodLayFilSep,
                 blnExpFatAut,
                 False,
                 False,
                 False);
end;

end.
