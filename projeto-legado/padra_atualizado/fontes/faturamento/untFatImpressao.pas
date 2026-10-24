unit untFatImpressao;

interface

uses
  SysUtils, untFuncoesSimples, UniClientDataSet, untFuncFatTypes, untTypesSistema,
  Winapi.Windows, Classes, strUtils, Uni, DB, Variants, SyncObjs, untZClient,
  Forms, IOUtils;

{$IFNDEF LINUX}
type
  TImprimeFatImpParams = record
    strTabela,
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strTip_Fc,
    strOriDoc: String;
    blnReimpressao: Boolean;
    strNomeArquivo: String;
    blnConfirmacao: Boolean;
    strSaida: String;
    intQtdImp: Integer;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    fltDebCli: Double;
    blnDocSep: Boolean;
    blnTickIF: Boolean;
    blnValTot: Boolean;
    blnQtdOri: Boolean;
    strFila: String;
    strTipImpressao: String;
    blnDocCancelado: Boolean;
    blnImpExpedicao: Boolean;
    blnComprovInd: Boolean;
    blnSempreEntr: Boolean;
    blnRequisicao: Boolean;
    blnFilaEmpDoc: Boolean;
    blnImprPedido: Boolean;
    opcAbastecimento: TOpcAbastecimento;
    blnImpFil: Boolean;
    blnEnt_CD: Boolean;
    blnPenden: Boolean;
    blnLocFisEmpEmi: Boolean;
    blnSepFut: Boolean;
    strSepPedEntregaOuRetira: String;
    strSetor: String;
    cdsLogSeparacao: TUniClientDataSet;
    blnRecCliGar: Boolean;
    strOpcDoc: String;
    strTipNomEmp: String;
    strOrdem: String;
    blnPreRomaneio: Boolean;
    opcAgrupaPor: TOpcAgrupaSepRomaneio;
    blnSomenteNaoImp: Boolean;
    strCodLse: String;
    strWhereSep: String;
    blnF9OrF10: Boolean;
    blnPerTot: Boolean;
    blnGerPdf: Boolean;
    strPasPdf: String;
    blnVisPdf: Boolean;
    blnSoEditor: Boolean;
    blnPenExp: Boolean;
    blnTicketNF: Boolean;
    blnSintetizaItensExped: Boolean;
    blnEmail: Boolean;
    blnVidro: Boolean;
    strMensNovo: String;
    strMensExcluido: String;
    strEmpCabecalho_CD: String;
    blnCabecalhoCD: Boolean;
    strNumRom: String;
    dtaSepFut: TDate;
    hraSepFut: TTime;
    blnTicketDV: Boolean;
    strCodIct: String;
    blnSomenteEmpDifSep: Boolean;
    blnImpBaixaSeparacao: Boolean;
    blnImpSepPickingCheckOut: Boolean;
    strCodLayFilSep: String;
    blnFatAut: Boolean;
    blnImpressaoColetor: Boolean;
    blnSepPendRomaneio: Boolean;
    blnReimpressaoGR: Boolean;
    intSeqSepPar: Integer;

    function ToTempFile: string;
    procedure FromTempFile(AFile: string);
  end;

  procedure pImprimeFatImp(var Params: TImprimeFatImpParams); overload;

  procedure pImprimeFatImp(strTabela,
                           strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strTip_Fc,
                           strOriDoc: String;
                           blnReimpressao: Boolean;
                           Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                           blnConfirmacao: Boolean;
                           strSaida: String = 'I';
                           intQtdImp: Integer = 1;
                           opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                           fltDebCli: Double = 0.0;
                           blnDocSep: Boolean = False;
                           blnTickIF: Boolean = False;
                           blnValTot: Boolean = True;
                           blnQtdOri: Boolean = True;
                           strFila: String = '';
                           strTipImpressao: String = '';
                           blnDocCancelado: Boolean = False;
                           blnImpExpedicao: Boolean = False;
                           blnComprovInd: Boolean = False;
                           blnSempreEntr: Boolean = False;
                           blnRequisicao: Boolean = False;
                           blnFilaEmpDoc: Boolean = False;
                           blnImprPedido: Boolean = False;
                           opcAbastecimento: TOpcAbastecimento = opcTodos;
                           blnImpFil: Boolean = False;
                           blnEnt_CD: Boolean = False;
                           blnPenden: Boolean = False;
                           blnLocFisEmpEmi: Boolean = False;
                           blnSepFut: Boolean = False;
                           strSepPedEntregaOuRetira: String = '';
                           strSetor: String = ' ';
                           cdsLogSeparacao: TUniClientDataSet = Nil;
                           blnRecCliGar: Boolean = False;
                           strOpcDoc: String = '';
                           strTipNomEmp: String = ''; // Razao Social ou Fantasia
                           strOrdem: String = '';  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                           blnPreRomaneio: Boolean = False;
                           opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                           blnSomenteNaoImp: Boolean = False;
                           strCodLse: String = '';
                           strWhereSep: String = '';
                           blnF9OrF10: Boolean = False;
                           blnPerTot: Boolean = False;
                           blnGerPdf: Boolean = False;
                           strPasPdf: String = '';
                           blnVisPdf: Boolean = False;
                           blnSoEditor: Boolean = False;
                           blnPenExp: Boolean = False;
                           blnTicketNF: Boolean = False;
                           blnSintetizaItensExped: Boolean = False;
                           blnEmail: Boolean = False;
                           blnVidro: Boolean = False;
                           strMensNovo: String = '';
                           strMensExcluido: String = '';
                           strEmpCabecalho_CD: String = '';
                           blnCabecalhoCD: Boolean = False;
                           strNumRom: String = '';
                           dtaSepFut: TDate = 0;
                           hraSepFut: TTime = 0;
                           blnTicketDV: Boolean = False;
                           strCodIct: String = '';
                           blnSomenteEmpDifSep: Boolean = False;
                           blnImpBaixaSeparacao: Boolean = False;
                           blnImpSepPickingCheckOut: Boolean = False;
                           strCodLayFilSep: String = '';
                           blnFatAut: Boolean = False;
                           blnImpressaoColetor: Boolean = False;
                           blnSepPendRomaneio: Boolean = False;
                           blnReimpressaoGR: Boolean = False;
                           intSeqSepPar: Integer = 0); overload;
{$ENDIF}

{$IFNDEF LINUX}
  procedure pImprimeFatImpAux(strTabela,
                           strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strTip_Fc,
                           strOriDoc: String;
                           blnReimpressao: Boolean;
                           Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                           blnConfirmacao: Boolean;
                           blnSoEditor: Boolean;
                           Var blnImprimiuEditor: Boolean;
                           Var blnImprimiuAmbien: Boolean;
                           Var strArqPDFEditor: String;
                           Var blnAchouLayout: Boolean;
                           strSaida: String = 'I';
                           intQtdImp: Integer = 1;
                           opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                           fltDebCli: Double = 0.0;
                           blnDocSep: Boolean = False;
                           blnTickIF: Boolean = False;
                           blnValTot: Boolean = True;
                           blnQtdOri: Boolean = True;
                           strFila: String = '';
                           strTipImpressao: String = '';
                           blnDocCancelado: Boolean = False;
                           blnImpExpedicao: Boolean = False;
                           blnComprovInd: Boolean = False;
                           blnSempreEntr: Boolean = False;
                           blnRequisicao: Boolean = False;
                           blnFilaEmpDoc: Boolean = False;
                           blnImprPedido: Boolean = False;
                           opcAbastecimento: TOpcAbastecimento = opcTodos;
                           blnImpFil: Boolean = False;
                           blnEnt_CD: Boolean = False;
                           blnPenden: Boolean = False;
                           blnLocFisEmpEmi: Boolean = False;
                           blnSepFut: Boolean = False;
                           strSepPedEntregaOuRetira: String = '';
                           strSetor: String = ' ';
                           cdsLogSeparacao: TUniClientDataSet = Nil;
                           blnRecCliGar: Boolean = False;
                           strOpcDoc: String = '';
                           strTipNomEmp: String = ''; // Razao Social ou Fantasia
                           strOrdem: String = '';
                           blnPreRomaneio: Boolean = False;
                           opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                           blnSomenteNaoImp: Boolean = False;
                           strCodLse: String = '';
                           strWhereSep: String = '';
                           blnF9OrF10: Boolean = False;
                           blnPerTot: Boolean = False;
                           blnGerPdf: Boolean = False;
                           strPasPdf: String = '';
                           blnVisPdf: Boolean = False;
                           blnPenExp: Boolean = False;
                           blnTicketNF: Boolean = False;
                           blnSintetizaItensExped: Boolean = False;
                           blnEmail: Boolean = False;
                           blnVidro: Boolean = False;
                           strMensNovo: String = '';
                           strMensExcluido: String = '';
                           strEmpCabecalho_CD: String = '';
                           blnCabecalhoCD: Boolean = False;
                           blnAjMl : Boolean = False;
                           strNumRom: String = '';
                           dtaSepFut: TDate = 0;
                           hraSepFut: TTime = 0;
                           blnTicketDV: Boolean = False;
                           strCodIct: String = '';
                           blnSomenteEmpDifSep: Boolean = False;
                           blnImpBaixaSeparacao: Boolean = False;
                           blnImpSepPickingCheckOut: Boolean = False;
                           strCodLayFilSep: String = '';
                           blnFatAut: Boolean = False;
                           blnImpressaoColetor: Boolean = False;
                           blnSepPendRomaneio: Boolean = False;
                           blnReimpressaoGR: Boolean = False;
                           blnOpcFat: Boolean = False;
                           intSeqSepPar: Integer = 0);
{$ENDIF}

  {***************************************************}
  {** FEITO PARA IMPRIMIR AJUSTE ESTOQUE FORMULAÇÃO **}
  {**    DAS TINTAS IMOBILIARIAS/AUTOMOTIVAS        **}
  {************************************************RG*}
{$IFNDEF LINUX}
  procedure pImprimeFatImpTin(strTabela,
                           strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strTip_Fc,
                           strOriDoc: String;
                           blnReimpressao: Boolean;
                           Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                           blnConfirmacao: Boolean;
                           strSaida: String = 'I';
                           intQtdImp: Integer = 1;
                           opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                           fltDebCli: Double = 0.0;
                           blnDocSep: Boolean = False;
                           blnTickIF: Boolean = False;
                           blnValTot: Boolean = True;
                           blnQtdOri: Boolean = True;
                           strFila: String = '';
                           strTipImpressao: String = '';
                           blnDocCancelado: Boolean = False;
                           blnImpExpedicao: Boolean = False;
                           blnComprovInd: Boolean = False;
                           blnSempreEntr: Boolean = False;
                           blnRequisicao: Boolean = False;
                           blnFilaEmpDoc: Boolean = False;
                           blnImprPedido: Boolean = False;
                           opcAbastecimento: TOpcAbastecimento = opcTodos;
                           blnImpFil: Boolean = False;
                           blnEnt_CD: Boolean = False;
                           blnPenden: Boolean = False;
                           blnLocFisEmpEmi: Boolean = False;
                           blnSepFut: Boolean = False;
                           strSepPedEntregaOuRetira: String = '';
                           strSetor: String = ' ';
                           cdsLogSeparacao: TUniClientDataSet = Nil;
                           blnRecCliGar: Boolean = False;
                           strOpcDoc: String = '';
                           strTipNomEmp: String = ''; // Razao Social ou Fantasia
                           strOrdem: String = '';  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                           blnPreRomaneio: Boolean = False;
                           opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                           blnSomenteNaoImp: Boolean = False;
                           strCodLse: String = '';
                           strWhereSep: String = '';
                           blnF9OrF10: Boolean = False;
                           blnPerTot: Boolean = False;
                           blnGerPdf: Boolean = False;
                           strPasPdf: String = '';
                           blnVisPdf: Boolean = False;
                           blnSoEditor: Boolean = False;
                           blnPenExp: Boolean = False;
                           blnTicketNF: Boolean = False;
                           blnSintetizaItensExped: Boolean = False;
                           blnEmail: Boolean = False;
                           blnVidro: Boolean = False;
                           strMensNovo: String = '';
                           strMensExcluido: String = '';
                           strEmpCabecalho_CD: String = '';
                           blnCabecalhoCD: Boolean = False;
                           blnTicketDV: Boolean = False);
{$ENDIF}

{$IFNDEF LINUX}
  procedure pImprimeFatImpAuxTin(strTabela,
                           strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodCli,
                           strTip_Fc,
                           strOriDoc: String;
                           blnReimpressao: Boolean;
                           Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                           blnConfirmacao: Boolean;
                           blnSoEditor: Boolean;
                           Var blnImprimiuEditor: Boolean;
                           Var blnImprimiuAmbien: Boolean;
                           Var strArqPDFEditor: String;
                           Var blnAchouLayout: Boolean;
                           strSaida: String = 'I';
                           intQtdImp: Integer = 1;
                           opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                           fltDebCli: Double = 0.0;
                           blnDocSep: Boolean = False;
                           blnTickIF: Boolean = False;
                           blnValTot: Boolean = True;
                           blnQtdOri: Boolean = True;
                           strFila: String = '';
                           strTipImpressao: String = '';
                           blnDocCancelado: Boolean = False;
                           blnImpExpedicao: Boolean = False;
                           blnComprovInd: Boolean = False;
                           blnSempreEntr: Boolean = False;
                           blnRequisicao: Boolean = False;
                           blnFilaEmpDoc: Boolean = False;
                           blnImprPedido: Boolean = False;
                           opcAbastecimento: TOpcAbastecimento = opcTodos;
                           blnImpFil: Boolean = False;
                           blnEnt_CD: Boolean = False;
                           blnPenden: Boolean = False;
                           blnLocFisEmpEmi: Boolean = False;
                           blnSepFut: Boolean = False;
                           strSepPedEntregaOuRetira: String = '';
                           strSetor: String = ' ';
                           cdsLogSeparacao: TUniClientDataSet = Nil;
                           blnRecCliGar: Boolean = False;
                           strOpcDoc: String = '';
                           strTipNomEmp: String = ''; // Razao Social ou Fantasia
                           strOrdem: String = '';
                           blnPreRomaneio: Boolean = False;
                           opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                           blnSomenteNaoImp: Boolean = False;
                           strCodLse: String = '';
                           strWhereSep: String = '';
                           blnF9OrF10: Boolean = False;
                           blnPerTot: Boolean = False;
                           blnGerPdf: Boolean = False;
                           strPasPdf: String = '';
                           blnVisPdf: Boolean = False;
                           blnPenExp: Boolean = False;
                           blnTicketNF: Boolean = False;
                           blnSintetizaItensExped: Boolean = False;
                           blnEmail: Boolean = False;
                           blnVidro: Boolean = False;
                           strMensNovo: String = '';
                           strMensExcluido: String = '';
                           strEmpCabecalho_CD: String = '';
                           blnCabecalhoCD: Boolean = False;
                           blnAjMl : Boolean = False;
                           blnTicketDV: Boolean = False);
{$ENDIF}

  procedure pValidaImpressao(intQtdIte: Integer; strEspDoc: String);

  function fExisteInvoice(strNumDoc, strEspDoc, strCodEmp: String): boolean;

 {$IFNDEF LINUX}
  function fRetornaLayotImpressao(strNumDoc, strEspDoc, strCodEmp, strCodLay: string): string;
 {$ENDIF}

  procedure pMarcarDocumentoParaImpressaoNoECF(strNumDoc, strEspDoc: String);

 {$IFNDEF LINUX}
  function fImprimirControleGarantia(strNumDoc, strEspDoc, strCodCli : String; cdsMovGer: TZClient = nil; cdsMovDet: TZClient = nil; blnRetBaixa: boolean = false; tpeTipEti: TTipoEtiqueta = tpeNenhum): boolean;
 {$ENDIF}

 {$IFNDEF LINUX}
  function fGeraArquivoAnexoEmailConfirmacaoDocumento(strNumDoc, strEspDoc, strCodEmp: String): String;
 {$ENDIF}


Var
  blnSimples: Boolean;

implementation

uses
  untImpNaoFiscal, untEditorFastImpressao, untQckDAV,
  untAtualizaOcorrenciasCRM, untFuncoesCRM, untTypesCRM,
  untImpressaoSeparacaoEspecif,
  untTEnvioEmail,
  untImagemBase64,
  untImpEspDefAmbiente, untModuloSPR, untFuncoesEditorFast, untDocPDOR_Excel,
  untSeparacaoPedidoEstrutura, untImpEspCalub, untThreadUtils,
  untTSituacaoPedidoVenda;

type
  TStartFatImpressao = class(TSafeThread)
  private
    class var FSemaphore: TCriticalSection;
  private
    FPathExe: string;
    FParams: string;
  protected
    procedure Execute; override;
  public
    constructor Create(const AParams: string);
  end;

{ TStartFatImpressao }
procedure TStartFatImpressao.Execute;
begin
  Self.FSemaphore.Enter;
  try
    StartProcess(FPathExe, FParams);
    Sleep(300);
  finally
    Self.FSemaphore.Leave;
  end;
end;

constructor TStartFatImpressao.Create(const AParams: string);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FPathExe := ExtractFilePath(ParamStr(0)) + 'FatImpressao.exe';
  FParams := AParams;
end;

{****************************}
{* IMPRESSÃO DO FATURAMENTO *}
{*************************AF*}
{$IFNDEF LINUX}
procedure pImprimeFatImpAux(strTabela,
                         strNumDoc,
                         strEspDoc,
                         strCodEmp,
                         strCodCli,
                         strTip_Fc,
                         strOriDoc: String;
                         blnReimpressao: Boolean;
                         Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                         blnConfirmacao: Boolean;
                         blnSoEditor: Boolean;
                         Var blnImprimiuEditor: Boolean;
                         Var blnImprimiuAmbien: Boolean;
                         Var strArqPDFEditor: String;
                         Var blnAchouLayout: Boolean;
                         strSaida: String = 'I';
                         intQtdImp: Integer = 1;
                         opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                         fltDebCli: Double = 0.0;
                         blnDocSep: Boolean = False;
                         blnTickIF: Boolean = False;
                         blnValTot: Boolean = True;
                         blnQtdOri: Boolean = True;
                         strFila: String = '';
                         strTipImpressao: String = '';
                         blnDocCancelado: Boolean = False;
                         blnImpExpedicao: Boolean = False;
                         blnComprovInd: Boolean = False;
                         blnSempreEntr: Boolean = False;
                         blnRequisicao: Boolean = False;
                         blnFilaEmpDoc: Boolean = False;
                         blnImprPedido: Boolean = False;
                         opcAbastecimento: TOpcAbastecimento = opcTodos;
                         blnImpFil: Boolean = False;
                         blnEnt_CD: Boolean = False;
                         blnPenden: Boolean = False;
                         blnLocFisEmpEmi: Boolean = False;
                         blnSepFut: Boolean = False;
                         strSepPedEntregaOuRetira: String = '';
                         strSetor: string = ' ';
                         cdsLogSeparacao: TUniClientDataSet = Nil;
                         blnRecCliGar: Boolean = False;
                         strOpcDoc: String = '';
                         strTipNomEmp: String = ''; // Razao Social ou Fantasia
                         strOrdem: String = '';     //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                         blnPreRomaneio: Boolean = False;
                         opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                         blnSomenteNaoImp: Boolean = False;
                         strCodLse: String = '';
                         strWhereSep: String = '';
                         blnF9OrF10: Boolean = False;
                         blnPerTot: Boolean = False;
                         blnGerPdf: Boolean = False;
                         strPasPdf: String = '';
                         blnVisPdf: Boolean = False;
                         blnPenExp: Boolean = False;
                         blnTicketNF: Boolean = False;
                         blnSintetizaItensExped: Boolean = False;
                         blnEmail: Boolean = False;
                         blnVidro: Boolean = False;
                         strMensNovo: String = '';
                         strMensExcluido: String = '';
                         strEmpCabecalho_CD: String = '';
                         blnCabecalhoCD: Boolean = False;
                         blnAjMl : Boolean = False;
                         strNumRom: String = '';
                         dtaSepFut: TDate = 0;
                         hraSepFut: TTime = 0;
                         blnTicketDV: Boolean = False;
                         strCodIct: String = '';
                         blnSomenteEmpDifSep: Boolean = False;
                         blnImpBaixaSeparacao: Boolean = False;
                         blnImpSepPickingCheckOut: Boolean = False;
                         strCodLayFilSep: String = '';
                         blnFatAut: Boolean = False;
                         blnImpressaoColetor: Boolean = False;
                         blnSepPendRomaneio: Boolean = False;
                         blnReimpressaoGR: Boolean = False;
                         blnOpcFat: Boolean = False;
                         intSeqSepPar: Integer = 0);
  Var
    strSQL       : String;
    strNomeFila  : String;
    strTipImp    : String;
    strMeiaFolha : String;
    intContador  : Integer;
    fltPerIss    : Double;
    fltValIss    : Double;
    fltTotSer    : Double;
    blnTemServico: Boolean;
    impNaoFiscal : TImpNaoFiscal;
    strEspTeste  : String;
    strColRel    : String;
    strNumPed    : String;
    strTransp    : String;
    str40ColS    : String;
    strSQLItens  : String;
    strTabelaGer : String;
    strAbrTabGer : String;
    qryGenGer    : TUniQuery;
    strGeraRom   : String;
    qryCfgRel    : TUniQuery;
    strSQLTabPre : String;
    strOrdPdv    : String;
    strOrdSep    : String;
    strOrdDoc    : String;
    strSetorSep  : String;
    strJoinMovTri: String;
    strMsgCof    : String;

    qryEntGer    : TUniQuery;
    arrEntGer    : TStringArray;
    arrEmpFor    : TStringArray;
    i, x         : Integer;

    strImpAju    : String;
    strEntFut    : String;
    strNomForm   : String;
    strModDav: String;
    frxQckDav: TfrmQckDAV;

    blnAgruparItensSeparacao: Boolean;
    blnUtilizaVendaMadOuVid: Boolean;
    cdsImpressaoMadeira,
    cdsImpressaoLogSep,
    cdsItensPendSeparacao : TUniClientDataSet;
    blnImprimeDescricaoSimplificada : Boolean;
    blnAjuste : Boolean;
    strCodLay : String;
    objOcoCrm : TAtuOcoCrm;
    objImpSepEspecif: TImpSepEspecif;
    strNomTra: String;
    intOpcao: Integer;
    TipoEspDefAmbiente: TTipoEspDefAmbiente;

    function fDataSetImpressao: TDataSet;
    begin
      If Assigned(cdsImpressaoLogSep) Then
        Result := cdsImpressaoLogSep

      Else If blnUtilizaVendaMadOuVid And (Pos(strEspDoc,'GA_GC_') <= 0) And Assigned(cdsImpressaoMadeira) Then
        Result := cdsImpressaoMadeira

      Else
        Result := frmModuloSPR.qryRelatorio;
    end;

    Function fRetLocFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String): String;
    Begin
      Result :=          '  (CASE ';
      Result := Result + '    WHEN (IFNULL('+strFieldNumLot+', "")  = "") THEN (SELECT SI.ITE_LOCFIS FROM ITEGER SI WHERE SI.ITE_CODITE = '+strFieldCodIte+' AND SI.ITE_CODEMP = ' + QuotedStr(fCfgSis('EMP_CD')) + ')';
      Result := Result + '    WHEN (IFNULL('+strFieldNumLot+', "") <> "") THEN (SELECT SL.LOT_LOCFIS FROM CADLOT SL WHERE SL.LOT_NUMLOT = '+strFieldNumLot+' AND SL.LOT_CODITE = ' + strFieldCodIte + ' AND SL.LOT_CODEMP = ' + QuotedStr(fCfgSis('EMP_CD')) + ')';
      Result := Result + '  END) AS LOCFIS,  ';
    End;

    function fGetSqlQtdItePedOrc: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
        Result := Result + ' SUM( ';

      If blnQtdOri Then
        Result := Result + ' FDO_QTDITE '
      Else
        Result := Result + ' (FDO_QTDITE - FDO_QTDBAI) ';

      If blnAgruparItensSeparacao Then
        Result := Result + ' ) ';
    end;

    function fGetSqlQtdEmbPedOrc: String;
    begin
      Result := ' IF(ITE_MLTVEN > 1, ' + fGetSqlQtdItePedOrc + ' / ITE_MLTVEN, 0) ';
    end;

    function fGetSqlGroupByPedOrc: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
      Begin
        Result := Result + ' GROUP BY ';
        Result := Result + '   FDO_CODITE, FDO_IDEPRO, FDO_DESCRI, FDO_NUMLOT, ';
        Result := Result + '   FDO_UNIDAD, FDO_PROACA, FDO_CODACA, FDO_EMPACA  ';
      End;

    end;

    function fGetSqlQtdIteVenda: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
        Result := Result + ' SUM( ';

      If blnSepFut Then
        Result := Result + '   SEP_QTDITE '
      Else
        Result := Result + '   DET_QTDITE ';

      If blnAgruparItensSeparacao Then
        Result := Result + ' ) ';
    end;

    function fGetSqlQtdEmbVenda: String;
    begin
      Result := ' IF(ITE_MLTVEN > 1, ' + fGetSqlQtdIteVenda + ' / ITE_MLTVEN, 0) ';
    end;

    function fGetSqlGroupByVenda: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
      Begin
        Result := Result + ' GROUP BY ';
        Result := Result + '   DET_CODITE, DET_DESCRI, DET_IDEPRO, DET_NUMLOT ';
      End;

    end;

    function fRetLayoutImpSeparacaoEspecifico: String;
    begin
      Result := fCfgSis('LYBSEP');

      If (Not fEmptyStr(Result)) Then
      Begin
        If (Not fExisteLayoutLAYETI(Result, fTipoEtiquetaToTipoLayout(tpeSepPedido))) Then
          Result := '';
      End;
    end;

    function fRetLayout_PD_OR_SemPreco: String;
    Begin
      If (opcComSemPreco = impComPrecoGeral) Or (blnDocSep) Then
        Exit;

      If fEmptyStr(strPasPdf) Then
      Begin
        If (strEspDoc = 'OR') Then
          Result := fCfgSis('PDFOSP', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''))
        Else If (strEspDoc = 'PD') Then
          Result := fCfgSis('PDFPSP', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''))
        Else
          Result := '';
      End
      Else
      Begin
        If (strEspDoc = 'OR') Then
          Result := fCfgSis('PDFSPO', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''))
        Else If (strEspDoc = 'PD') Then
          Result := fCfgSis('PDFSPP', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''))
        Else
          Result := '';
      End;

      If fCfgSis('ORSPSM', varBoolean) Then
      Begin
        Result := '';

        If (strEspDoc = 'OR') Then
        Begin
          Case opcComSemPreco Of
            impComPrecoComMarca: Result := fCfgSis('CPCMOR', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
            impComPrecoSemMarca: Result := fCfgSis('CPSMOR', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
            impSemPrecoComMarca: Result := fCfgSis('SPCMOR', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
            impSemPrecoSemMarca: Result := fCfgSis('SPSMOR', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
          End;
        End
        Else If (strEspDoc = 'PD') Then
        Begin
          Case opcComSemPreco Of
            impComPrecoComMarca: Result := fCfgSis('CPCMPD', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
            impComPrecoSemMarca: Result := fCfgSis('CPSMPD', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
            impSemPrecoComMarca: Result := fCfgSis('SPCMPD', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
            impSemPrecoSemMarca: Result := fCfgSis('SPSMPD', VarString, IIF(fUsaLayOrigReimpDocs(), strCodEmp, ''));
          End;
        End
        Else
          Result := '';
      End;

      If (Not fEmptyStr(Result)) Then
      Begin
        If (Not fExisteLayoutLAYETI(Result)) Then
          Result := '';
      End;

      If (Pos(strEspDoc, 'OR_PD_') > 0) And (fEmptyStr(Result)) And (strSaida = 'P') Then
      begin
        If fCfgSis('ORSPSM', varBoolean) Then
        Begin
          Case opcComSemPreco Of
            impComPrecoComMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Com Preço Com Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_CPCM'+strEspDoc);
            impComPrecoSemMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Com Preço Sem Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_CPSM'+strEspDoc);
            impSemPrecoComMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Sem Preço Com Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_SPCM'+strEspDoc);
            impSemPrecoSemMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Sem Preço Sem Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_SPSM'+strEspDoc);
          End;
        End
        Else
        Begin
          If fEmptyStr(strPasPdf) Then
            strMsgCof := IfThen(strEspDoc = 'OR', 'CFG_PDFOSP', 'CFG_PDFPSP')
          else
            strMsgCof := IfThen(strEspDoc = 'OR', 'CFG_PDFSPO', 'CFG_PDFSPP');

          pMensagemOk('Não foi encontrado o Layout para PDF sem preço!' + #13#10 +
                      'Será impresso no formulário padrão de PDF.' + #13#10 +
                      'Verifique a configuração: ' + strMsgCof );
        End;
      end;
    End;

    Function fRetOrdem : String;
    begin

      Result := strOrdem;

      {*** Separação ***}
      If (blnDocSep) Then
      Begin

        If (strEspDoc.Equals('PD')) And
           (fEmptyStr(fCampoTabela('LAY_ORDENA', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'], ['55','S', strCodEmp]))) Then
        Begin
          Exit(fCfgSis('ORDSEP', VarString));
        End;

      End
      Else
      Begin

        If (strEspDoc.Equals('OR')) then
        begin
          if fEmptyStr(VarToStrDef(fCampoTabela('LAY_ORDENA', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'], ['53','S', strCodEmp]), '')) then
          begin
            if fEmptyStr(VarToStrDef(fCampoTabela('LAY_ORDENA', 'LAYETI', ['LAY_TIPLAY', 'LAY_GERPDF', 'LAY_CODEMP'], ['53','S', strCodEmp]), '')) then
            begin
              Exit(fCfgSis('ORDORC', VarString));
            end;
          end;
        end;

        If (strEspDoc.Equals('PD')) then
        begin
          if fEmptyStr(VarToStrDef(fCampoTabela('LAY_ORDENA', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'], ['52','S', strCodEmp]), '')) then
          begin
            if fEmptyStr(VarToStrDef(fCampoTabela('LAY_ORDENA', 'LAYETI', ['LAY_TIPLAY', 'LAY_GERPDF', 'LAY_CODEMP'], ['52','S', strCodEmp]), '')) then
            begin
              Exit(fCfgSis('ORDPDV', VarString));
            end;
          end;
        end;

        If (Pos(strEspDoc, 'IF_NF_FF_') > 0) And
           (fEmptyStr(VarToStrDef(fCampoTabela('LAY_ORDENA', 'LAYETI', ['LAY_TIPLAY', 'LAY_PADRAO', 'LAY_CODEMP'], ['51','S', strCodEmp]), ''))) then
        begin
          Exit(fCfgSis('ORDDOC', VarString));
        end;

      End;

    end;

    function fGetDadosImpressao: TRecDocumento;
      Var
        strCodLayIncoTerms: String;
    begin
      If blnPreRomaneio Then
      Begin
        If opcAgrupaPor = opcPedido Then
        Begin
          Result.strNumDoc        := strNumDoc;
          Result.strCodEmp        := strCodEmp;
          Result.strEspDoc        := strEspDoc;
          Result.opcAgrupaPor     := opcAgrupaPor;
          Result.blnSomenteNaoImp := False;
          Result.strCodLse        := strCodLse;
        End
        Else
        Begin
          Result.strNumDoc        := fRetNumRom(strCodemp, False, strNumDoc, strEspDoc, strCodCli);
          Result.strCodEmp        := strCodEmp;
          Result.strEspDoc        := 'RO';
          Result.opcAgrupaPor     := opcAgrupaPor;
          Result.blnSomenteNaoImp := blnSomenteNaoImp;
        End;
      End
      Else
      Begin
        Result.strNumDoc := strNumDoc;
        Result.strEspDoc := strEspDoc;
        Result.strCodEmp := strCodEmp;
        Result.strOrdem  := fRetOrdem;
      End;

      Result.strNumRom   := strNumRom;
      Result.strNomImp   := strFila;
      Result.strTipImp   := strTipImpressao;

      Result.blnDocSep   := blnDocSep;
      Result.strWhereSep := strWhereSep;
      Result.blnSepPendRomaneio := blnSepPendRomaneio;

      Result.strCodCli := strCodCli;

      Result.strSetor  := strSetor;
      Result.strSaida  := strSaida;
      Result.strTipFC  := strTip_FC;

      Result.intQtdImp := intQtdImp;

      Result.blnReimpr := blnReimpressao;
      Result.blnDocCan := blnDocCancelado;
      Result.blnQtdOri := blnQtdOri;
      Result.blnOpcFat := blnOpcFat;
      Result.blnConfir := blnConfirmacao;
      Result.blnImpExpedicao := blnImpExpedicao;
      Result.blnFilEmp := blnFilaEmpDoc;
      Result.blnImpFil := blnImpFil;
      Result.blnSepFut := blnSepFut;
      Result.dtaSepFut := dtaSepFut;
      Result.hraSepFut := hraSepFut;
      Result.blnEnt_CD := blnEnt_CD;
      Result.blnPerTot := blnPerTot;
      Result.blnPenExp := blnPenExp;
      Result.blnAjMl  := blnAjMl;

      Result.blnSimples               := blnSimples;
      Result.blnSempreEntr            := blnSempreEntr;
      Result.blnRequisicao            := blnRequisicao;
      Result.blnLocFisEmpEmi          := blnLocFisEmpEmi;
      Result.blnAgruparItensSeparacao := blnAgruparItensSeparacao;
      Result.strSepPedEntregaOuRetira := strSepPedEntregaOuRetira;

      Result.opcAbastecimento         := opcAbastecimento;
      Result.cdsLogSeparacao          := cdsLogSeparacao;
      Result.blnSomenteEmpDifSep      := blnSomenteEmpDifSep;

      Result.strMensNovo              := strMensNovo;
      Result.strMensExcluido          := strMensExcluido;

      Result.strCodLay := '';

      If (opcComSemPreco <> impComPrecoGeral) Then
        Result.strCodLay := fRetLayout_PD_OR_SemPreco
      Else If blnDocSep And blnImpBaixaSeparacao Then
        Result.strCodLay := fRetLayoutImpSeparacaoEspecifico;

      Result.blnGerPdf := blnGerPdf;
      Result.strPasPdf := strPasPdf;
      Result.blnVisPdf := blnVisPdf;
      Result.blnTicketNF := blnTicketNF;
      Result.blnTicketDV := blnTicketDV;

      Result.blnVidro := blnVidro;
      Result.strEmpCabecalho_CD := strEmpCabecalho_CD;
      Result.blnCabecalhoCD     := blnCabecalhoCD;

      If fCfgSis('USAVOI', VarBoolean) and
         fExisteInvoice(Result.strNumDoc, Result.strEspDoc, Result.strCodEmp) then
      begin
        strCodLayIncoTerms := fCampoTabela('ICT_LAYETI', 'CADICT', ['ICT_CODICT'], [strCodIct]);

        if fEmptyStr(strCodLayIncoTerms) then
        begin
          If (fUsaLayOrigReimpDocs()) Then
          Begin
            Result.blnPDExterior := not fEmptyStr(VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['213', strCodEmp]), '')) and (strEspDoc='PD');
            Result.blnORExterior := not fEmptyStr(VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['212', strCodEmp]), '')) and (strEspDoc='OR');
          End
          Else
          Begin
            Result.blnPDExterior := not fEmptyStr(VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['213', Vs_strCodEmp]), '')) and (strEspDoc='PD');
            Result.blnORExterior := not fEmptyStr(VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYETI', ['LAY_TIPLAY','LAY_CODEMP'], ['212', Vs_strCodEmp]), '')) and (strEspDoc='OR');
          End;
        end
        else
        begin
          Result.strCodLay     := strCodLayIncoTerms;
          Result.blnPDExterior := (strEspDoc='PD');
          Result.blnORExterior := (strEspDoc='OR');
        end;
      end;

      if (Pos(strEspDoc, 'OR_PD_') > 0) and ((not blnDocSep) or (not Result.blnPDExterior) or (not Result.blnORExterior)) then
        Result.strCodLay := fRetornaLayotImpressao(Result.strNumDoc, Result.strEspDoc, Result.strCodEmp, Result.strCodLay);

      if (not fEmptyStr(strCodLayFilSep)) and (Pos(strEspDoc, 'OR_PD_') > 0) Then
        Result.strCodLay := strCodLayFilSep;

      Result.blnImpSepPickingCheckOut := blnImpSepPickingCheckOut;

      Result.blnFatAut := blnFatAut;
      Result.blnImpressaoColetor := blnImpressaoColetor;
      Result.blnReimpressaoGR := blnReimpressaoGR;
      Result.intSeqSepPar := intSeqSepPar;
    end;

    Function fImprimeLayoutEditor(): Boolean;
    var
      objImpressao: TEditorFastImpressao;
    begin
      objImpressao := TEditorFastImpressao.Create(Nil);

      With objImpressao Do
      Begin
        recDocume := fGetDadosImpressao;
        If strSaida = 'P' Then
        Begin
          fImprimeDocumento(tpaPDF)
        End
        Else
        Begin
          If (strSaida = 'E') And (TDocPDOR_Excel.fUtilizaLayOutExcel) And (Pos(strEspDoc, 'OR_PD_') > 0) Then
          Begin

            fImprimeDocumento(tpaExcel);

            If Not fEmptyStr(strArqExcel) Then
              strNomeArquivo := strArqExcel;

          End
          Else
          Begin
            fImprimeDocumento;
          End;
        End;

        If (Not objImpressao.recDocume.blnImprimiu) And (blnDocSep) Then
          pValidaImpressao(objImpressao.recDocume.intQtdIte, strEspDoc);

        If (strSaida = 'P') Or (blnGerPdf) Then
        Begin
          If recDocume.blnTemLay Then
          Begin
            strArqPDFEditor := strArqPDF;
            strNomeArquivo  := strArqPDF;
          End;
        End;

        blnAchouLayout := recDocume.blnTemLay;
        Result := recDocume.blnTemLay and recDocume.blnImprimiu;

        If Result And recDocume.blnDocSep Then
        Begin
          tpeTipoEtiqueta := tpeSepNotaObs;
          fImprimeDocumento;
        End
      End;
      FreeAndNil(objImpressao);
    End;

    Function fImpDAV: Boolean;
    Begin
      Result := False;

      strModDav := fCfgSis('MOVDAV');
      If (Pos(strEspDoc, 'OR_PD_') > 0) And (Not blnDocSep) And (Not blnRequisicao) And
         ( (strModDav = '2') Or (strModDav = '3') ) And (fCfgSis('PAFECF', varBoolean)) Then
      Begin
        If strModDav = '2' Then
        Begin
          frxQckDav := TfrmQckDAV.Create(Nil);
          frxQckDav.pImprimirDAV(strNumDoc, strEspDoc, strNomeFila, strSaida);
          FreeAndNil(frxQckDav);
          Result := True;
        End
        Else
        Begin
          pMensagemOk('O Documento foi disponibilizado no Resumo de Caixa [ALT+V] para Impressão do DAV na ECF!');
          pMarcarDocumentoParaImpressaoNoECF(strNumDoc, strEspDoc);
          Result := True;
        End;
      End;
    End;

Begin
  cdsItensPendSeparacao := TUniClientDataSet.Create(Nil);
  cdsItensPendSeparacao.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  cdsItensPendSeparacao.FieldDefs.Add('QTDITE', ftFloat);
  cdsItensPendSeparacao.CreateDataSet;

  Try
    blnImprimiuAmbien := False;

    blnUtilizaVendaMadOuVid := fCfgSis('VENMAD', varBoolean) Or
                               fCfgSis('VENVID', varBoolean);

    blnAgruparItensSeparacao := blnDocSep And
                                Not blnUtilizaVendaMadOuVid And
                                fCfgSis('SINSEP', varBoolean);

    {***************************************************************}
    {* SE FOR IMPRESSÃO DE SEPARAÇÃO DO PRÉ-ROMANEIO E NÃO ESTIVER *}
    {* CONFIGURADO PARA AGRUPAR, DEVE AGRUPAR MESMO ASSIM          *}
    {************************************************************MM*}
    If ((blnPreRomaneio) And (Not blnAgruparItensSeparacao))or (blnSintetizaItensExped){ Or fUsaRotinaWMS *} Then {(*) CONDIÇÃO COLOCADA REVISÃO 128053 REQ.: 46947 E QUE COMENTEI NO REQ.: 80712 POIS ESTAVA SINTETIZANDO TODAS AS ESPÉCIES}
      blnAgruparItensSeparacao := True;


    {******************************************************}
    {* NÃO IMPRIMIR SE IMPAUT = 2 - SÓ AUTENTICAÇÃO       *}
    {***************************************************NC*}
    If Not ((Pos(strEspDoc,'MI_FF_') > 0) And (fCfgSis('IMPAUT') = '2') And blnConfirmacao And (Not blnDocSep)) Then
    Begin

      If (Not blnEmail) And fImpDAV Then
      Begin
        blnImprimiuEditor := True;
        Exit;
      End;

      If blnDocSep And blnImpBaixaSeparacao And (Not fEmptyStr(fRetLayoutImpSeparacaoEspecifico)) Then
      Begin
        blnImprimiuEditor := fImprimeLayoutEditor;
      End
      Else If blnDocSep And (strEspDoc = 'PD') And TfrmSeparacaoPedidoEstrutura.fTemFR3 Then
      Begin
        TfrmSeparacaoPedidoEstrutura.pImprime(strTabela, strNumDoc, strEspDoc, strCodCli, strCodEmp);
        Exit;
      End
      Else If (strSaida = 'I') And (Not blnDocSep) And (Pos(strEspDoc, 'PD_OR_FF_BR_TR_DV_') > 0) And TfrmImpEspCalub.fTemFR3 And (Not blnF9OrF10) Then
      Begin
        TfrmImpEspCalub.pImprime(strNumDoc, strEspDoc, strCodCli, strCodEmp, intQtdImp);
        Exit;
      End
      Else If ((Not blnDocSep) And (fCfgSis('UTIDEF', varBoolean) And (fGetUtilizaLayoutFR3EspecificoImpDefAmbiente(strEspDoc))))
              Or
              (blnDocSep And TfrmImpEspDefAmbiente.fTemFR3(tedaSeparacao)) Then
      Begin
        TipoEspDefAmbiente := tedaComPreco;
        If (Pos(strEspDoc, 'OR_') > 0) Then
        Begin
          If (VS_AutcomIniciadoModoRobo) Then
          Begin
            TipoEspDefAmbiente := tedaComPreco;
          End
          Else If (fCfgSis('ORSPSM', varBoolean, VS_strCodEmp)) Then
          Begin
            // válido para impressão e reimpressão quando ORSPSM = 'S'
            Case fGetMenu('Opção:',['Com Preço e Com Marca', 'Com Preço e Sem Marca', 'Sem Preço e Com Marca', 'Sem Preço e Sem Marca'], 1) Of
              1: TipoEspDefAmbiente := tedaComPrecoComMarca;
              2: TipoEspDefAmbiente := tedaComPrecoSemMarca;
              3: TipoEspDefAmbiente := tedaSemPrecoComMarca;
              4: TipoEspDefAmbiente := tedaSemPrecoSemMarca;
            End;
          End
          Else If (((blnReimpressao) or (strSaida = 'P')) And (fCfgSis('UTIPDF', varBoolean))) Then
          Begin
            // quando for reimpressão e UTIPDF = 'S'
            if TfrmImpEspDefAmbiente.fTemFR3(tedaReferenciaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferencia) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabricaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabrica) Then
            Begin
              intOpcao := fGetMenu('Opção para geração do PDF',['Com Preço', 'Sem Preço', 'Sem Preço Simplificado', 'Referência e Marca', 'Referência', 'Código de Fábrica e Marca', 'Código de Fábrica'], 1);
              case intOpcao of
                1: TipoEspDefAmbiente := tedaComPreco;
                2: TipoEspDefAmbiente := tedaSemPreco;
                3: TipoEspDefAmbiente := tedaSemPrecoSimplificado;
                4: TipoEspDefAmbiente := tedaReferenciaMarca;
                5: TipoEspDefAmbiente := tedaReferencia;
                6: TipoEspDefAmbiente := tedaCodigoFabricaMarca;
                7: TipoEspDefAmbiente := tedaCodigoFabrica;
              end;
            End
            Else if TfrmImpEspDefAmbiente.fTemFR3(tedaComPrecoSemMarca) Then
            Begin
              intOpcao := fGetMenu('Opção para geração do PDF',['Com Preço', 'Sem Preço', 'Sem Preço Simplificado', 'Com Preço Sem Código de Fábrica e Marca'], 1);
              case intOpcao of
                1: TipoEspDefAmbiente := tedaComPreco;
                2: TipoEspDefAmbiente := tedaSemPreco;
                3: TipoEspDefAmbiente := tedaSemPrecoSimplificado;
                4: TipoEspDefAmbiente := tedaComPrecoSemMarca;
              end;
            End
            Else
            Begin
              intOpcao := fGetMenu('Opção para geração do PDF',['Com Preço', 'Sem Preço', 'Sem Preço Simplificado'], 1);
              case intOpcao of
                1: TipoEspDefAmbiente := tedaComPreco;
                2: TipoEspDefAmbiente := tedaSemPreco;
                3: TipoEspDefAmbiente := tedaSemPrecoSimplificado;
              end;
            End;
          End;
        End
        Else
        Begin
          if (Pos(strEspDoc, 'FF_') <= 0) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferenciaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferencia) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabricaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabrica) Then
          Begin
            intOpcao := fGetMenu('Opção para geração do PDF',['Referência e Marca', 'Referência', 'Código de Fábrica e Marca', 'Código de Fábrica'], 1);
            case intOpcao of
              1: TipoEspDefAmbiente := tedaReferenciaMarca;
              2: TipoEspDefAmbiente := tedaReferencia;
              3: TipoEspDefAmbiente := tedaCodigoFabricaMarca;
              4: TipoEspDefAmbiente := tedaCodigoFabrica;
            end;

          End
          Else If ((Pos(strEspDoc, 'PD_') >= 0)) And (TfrmImpEspDefAmbiente.fTemFR3(tedaPedidoCortado)) Then
          Begin
            TipoEspDefAmbiente := tedaPedidoCortado;
          End
          Else
          Begin

            case opcComSemPreco of
              impComPrecoGeral, impComPrecoSemMarca: TipoEspDefAmbiente := tedaComPreco;
              impSemPrecoSimplificado: TipoEspDefAmbiente := tedaSemPrecoSimplificado;
            else
              TipoEspDefAmbiente := tedaSemPreco;
            end;
          End;
        End;
        if blnDocSep then
          TipoEspDefAmbiente := tedaSeparacao;

        If (fCfgSis('LAYDEA') = '1') And (Pos(strEspDoc, 'FF_') > 0) And (not blnDocSep) Then
        Begin
           if TfrmImpEspDefAmbiente.fTemFR3(tedaReferenciaMarcaFF) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferenciaFF) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabricaMarcaFF) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabricaFF) Then
           Begin
            intOpcao := fGetMenu('Opção para geração do PDF',['Referência e Marca', 'Referência', 'Código de Fábrica e Marca', 'Código de Fábrica'], 1);
            case intOpcao of
              1: TipoEspDefAmbiente := tedaReferenciaMarcaFF;
              2: TipoEspDefAmbiente := tedaReferenciaFF;
              3: TipoEspDefAmbiente := tedaCodigoFabricaMarcaFF;
              4: TipoEspDefAmbiente := tedaCodigoFabricaFF;
            end;

           End
           Else
            TipoEspDefAmbiente := tedaFaturamentoFuturo;
        End;

        if opcComSemPreco = impSemPrecoGeral then
          TipoEspDefAmbiente := tedaSemPreco;

        TfrmImpEspDefAmbiente.pImprime(strNumDoc, strEspDoc, strCodCli, strCodEmp, intQtdImp, strSaida, blnVisPdf, strNomeArquivo, TipoEspDefAmbiente, blnReimpressao, blnDocSep);

        if (blnDocSep And TfrmImpEspDefAmbiente.fTemFR3(tedaSeparacao)) then
        begin
          if strEspDoc = 'PD' then
            fMarcarPedidoComoImpresso(strNumDoc, strEspDoc, strCodEmp, blnDocSep, blnImpExpedicao)
          else
            fMarcaSeparacaoComoImpresso(strNumDoc, strEspDoc, strCodEmp);
        end;

        blnImprimiuAmbien := True;

        Exit;

      End
      Else If (blnDocSep) And (strEspDoc = 'PD') And (fCfgSis('SEPESP', varBoolean)) Then Begin
        Try
          objImpSepEspecif := TImpSepEspecif.Create(strFila, blnConfirmacao);

          strNomTra := fCampoTabela('TRA_NOMTRA', 'CADTRA', ['TRA_CODTRA'],
            [
              fCampoTabela('FGO_CODTRA', 'FATGOR',
                                        ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP', 'FGO_CODCLI'],
                                        [strNumDoc, strEspDoc, strCodEmp, strCodCli])
            ]);

          blnTemServico := (Not fEmptyStr(
                                            fCampoTabela('FGO_CODS01', 'FATGOR',
                                                         ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP', 'FGO_CODCLI'],
                                                         [strNumDoc, strEspDoc, strCodEmp, strCodCli])
                                         )
                           );

          objImpSepEspecif.pImprime(blnTemServico,
                                    strTabela,
                                    strNumDoc,
                                    strEspDoc,
                                    strCodEmp,
                                    strCodCli,
                                    strOriDoc,
                                    strNomTra,
                                    fltDebCli,
                                    blnReimpressao,
                                    blnDocSep,
                                    (opcComSemPreco In [impComPrecoGeral, impComPrecoSemMarca]),
                                    False,  //blnImpTck
                                    '',     //str40ColS
                                    strTip_Fc,
                                    strOriDoc,
                                    '',     //strSQLItens,
                                    blnValTot,
                                    blnDocCancelado,
                                    'V',  //strSaida
                                    intQtdImp,
                                    blnImprPedido,
                                    blnEnt_CD,
                                    blnSepFut,
                                    strSepPedEntregaOuRetira);
        Finally
          FreeAndNil(objImpSepEspecif);
          FreeAndNil(qryCfgRel);
        End;

        Exit;
      End
      Else
      Begin
        blnImprimiuEditor := fImprimeLayoutEditor;
      End;

      If blnImprimiuEditor Or blnSoEditor Then
        FreeAndNil(cdsItensPendSeparacao)
      Else If (Not blnAchouLayout) Then
        pNotificacaoSistemaProblema('','Não há layout disponível para impressão!', strEspDoc);
    End;

    If blnDocSep And VS_strHabilitarCRM Then
    Begin
      objOcoCrm := TAtuOcoCrm.Create(nil);
      Try
        objOcoCrm.strCodOco := fRetornaCodigoOcorrencia(strNumDoc,strEspDoc,strCodCli,strCodEmp,'');
        If Not fEmptyStr(objOcoCrm.strCodOco) Then
        Begin
          objOcoCrm.strNomFrm := '[pImprimeFatImpAux]';
          objOcoCrm.pCarregaOcorrencia('C', objOcoCrm.strCodOco, strCodEmp);
          objOcoCrm.strNumDoc := strNumDoc;
          objOcoCrm.strEspDoc := strEspDoc;
          objOcoCrm.afcAcaFat := afcSeparacaoImpressa;
          objOcoCrm.strCodOpe := afcSeparacaoImpressa.fGetOperador(strNumDoc, strEspDoc, strCodEmp);
          objOcoCrm.pProcessaFatOcorrenciasCRM;
        End;
      Finally
        FreeAndNil(objOcoCrm);
      End;
    End;

  Finally
    If (strEspDoc = 'PD') And (blnDocSep) Then
      TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(strNumDoc)
                          .EspDoc(strEspDoc)
                          .CodEmp(strCodEmp)).pExecute();

    FreeAndNil(cdsItensPendSeparacao);
    FreeAndNil(qryGenGer);

    If Assigned(cdsImpressaoMadeira) Then
      FreeAndNil(cdsImpressaoMadeira);

    If Assigned(cdsImpressaoLogSep) Then
      FreeAndNil(cdsImpressaoLogSep);

    If (frmModuloSPR.dtsRelatorio.DataSet <> frmModuloSPR.qryRelatorio) Then
    Begin
      If frmModuloSPR.qryRelatorio.Active Then
        frmModuloSPR.qryRelatorio.Close;
      frmModuloSPR.dtsRelatorio.DataSet := frmModuloSPR.qryRelatorio;
    End;
  End;

End;
{$ENDIF}

{$IFNDEF LINUX}
procedure pImprimeFatImp(strTabela,
                         strNumDoc,
                         strEspDoc,
                         strCodEmp,
                         strCodCli,
                         strTip_Fc,
                         strOriDoc: String;
                         blnReimpressao: Boolean;
                         Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                         blnConfirmacao: Boolean;
                         strSaida: String = 'I';
                         intQtdImp: Integer = 1;
                         opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                         fltDebCli: Double = 0.0;
                         blnDocSep: Boolean = False;
                         blnTickIF: Boolean = False;
                         blnValTot: Boolean = True;
                         blnQtdOri: Boolean = True;
                         strFila: String = '';
                         strTipImpressao: String = '';
                         blnDocCancelado: Boolean = False;
                         blnImpExpedicao: Boolean = False;
                         blnComprovInd: Boolean = False;
                         blnSempreEntr: Boolean = False;
                         blnRequisicao: Boolean = False;
                         blnFilaEmpDoc: Boolean = False;
                         blnImprPedido: Boolean = False;
                         opcAbastecimento: TOpcAbastecimento = opcTodos;
                         blnImpFil: Boolean = False;
                         blnEnt_CD: Boolean = False;
                         blnPenden: Boolean = False;
                         blnLocFisEmpEmi: Boolean = False;
                         blnSepFut: Boolean = False;
                         strSepPedEntregaOuRetira: String = '';
                         strSetor: String = ' ';
                         cdsLogSeparacao: TUniClientDataSet = Nil;
                         blnRecCliGar: Boolean = False;
                         strOpcDoc: String = '';
                         strTipNomEmp: String = ''; // Razao Social ou Fantasia
                         strOrdem: String = '';  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                         blnPreRomaneio: Boolean = False;
                         opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                         blnSomenteNaoImp: Boolean = False;
                         strCodLse: String = '';
                         strWhereSep: String = '';
                         blnF9OrF10: Boolean = False;
                         blnPerTot: Boolean = False;
                         blnGerPdf: Boolean = False;
                         strPasPdf: String = '';
                         blnVisPdf: Boolean = False;
                         blnSoEditor: Boolean = False;
                         blnPenExp: Boolean = False;
                         blnTicketNF: Boolean = False;
                         blnSintetizaItensExped: Boolean = False;
                         blnEmail: Boolean = False;
                         blnVidro: Boolean = False;
                         strMensNovo: String = '';
                         strMensExcluido: String = '';
                         strEmpCabecalho_CD: String = '';
                         blnCabecalhoCD: Boolean = False;
                         strNumRom: String = '';
                         dtaSepFut: TDate = 0;
                         hraSepFut: TTime = 0;
                         blnTicketDV: Boolean = False;
                         strCodIct: String = '';
                         blnSomenteEmpDifSep: Boolean = False;
                         blnImpBaixaSeparacao: Boolean = False;
                         blnImpSepPickingCheckOut: Boolean = False;
                         strCodLayFilSep: String = '';
                         blnFatAut: Boolean = False;
                         blnImpressaoColetor: Boolean = False;
                         blnSepPendRomaneio: Boolean = False;
                         blnReimpressaoGR: Boolean = False;
                         intSeqSepPar: Integer = 0);
var
  LParams: TImprimeFatImpParams;

  function fUtilizarFatImpressaoExe: Boolean;
  begin
    if Assigned(cdsLogSeparacao) then
      Exit(False);

    if strSaida <> 'I' then
      Exit(False);

    if fEmptyStr(strFila) then
      Exit(False);

    if not fCfgSis('FATIMP', varBoolean) then
      Exit(False);

    if not FileExists(ExtractFilePath(ParamStr(0)) + 'FatImpressao.exe') then
      Exit(False);

    Result := True;
  end;

begin
  LParams.strTabela                := strTabela;
  LParams.strNumDoc                := strNumDoc;
  LParams.strEspDoc                := strEspDoc;
  LParams.strCodEmp                := strCodEmp;
  LParams.strCodCli                := strCodCli;
  LParams.strTip_Fc                := strTip_Fc;
  LParams.strOriDoc                := strOriDoc;
  LParams.blnReimpressao           := blnReimpressao;
  LParams.strNomeArquivo           := strNomeArquivo;
  LParams.blnConfirmacao           := blnConfirmacao;
  LParams.strSaida                 := strSaida;
  LParams.intQtdImp                := intQtdImp;
  LParams.opcComSemPreco           := opcComSemPreco;
  LParams.fltDebCli                := fltDebCli;
  LParams.blnDocSep                := blnDocSep;
  LParams.blnTickIF                := blnTickIF;
  LParams.blnValTot                := blnValTot;
  LParams.blnQtdOri                := blnQtdOri;
  LParams.strFila                  := strFila;
  LParams.strTipImpressao          := strTipImpressao;
  LParams.blnDocCancelado          := blnDocCancelado;
  LParams.blnImpExpedicao          := blnImpExpedicao;
  LParams.blnComprovInd            := blnComprovInd;
  LParams.blnSempreEntr            := blnSempreEntr;
  LParams.blnRequisicao            := blnRequisicao;
  LParams.blnFilaEmpDoc            := blnFilaEmpDoc;
  LParams.blnImprPedido            := blnImprPedido;
  LParams.opcAbastecimento         := opcAbastecimento;
  LParams.blnImpFil                := blnImpFil;
  LParams.blnEnt_CD                := blnEnt_CD;
  LParams.blnPenden                := blnPenden;
  LParams.blnLocFisEmpEmi          := blnLocFisEmpEmi;
  LParams.blnSepFut                := blnSepFut;
  LParams.strSepPedEntregaOuRetira := strSepPedEntregaOuRetira;
  LParams.strSetor                 := strSetor;
  LParams.cdsLogSeparacao          := cdsLogSeparacao;
  LParams.blnRecCliGar             := blnRecCliGar;
  LParams.strOpcDoc                := strOpcDoc;
  LParams.strTipNomEmp             := strTipNomEmp;
  LParams.strOrdem                 := strOrdem;
  LParams.blnPreRomaneio           := blnPreRomaneio;
  LParams.opcAgrupaPor             := opcAgrupaPor;
  LParams.blnSomenteNaoImp         := blnSomenteNaoImp;
  LParams.strCodLse                := strCodLse;
  LParams.strWhereSep              := strWhereSep;
  LParams.blnF9OrF10               := blnF9OrF10;
  LParams.blnPerTot                := blnPerTot;
  LParams.blnGerPdf                := blnGerPdf;
  LParams.strPasPdf                := strPasPdf;
  LParams.blnVisPdf                := blnVisPdf;
  LParams.blnSoEditor              := blnSoEditor;
  LParams.blnPenExp                := blnPenExp;
  LParams.blnTicketNF              := blnTicketNF;
  LParams.blnSintetizaItensExped   := blnSintetizaItensExped;
  LParams.blnEmail                 := blnEmail;
  LParams.blnVidro                 := blnVidro;
  LParams.strMensNovo              := strMensNovo;
  LParams.strMensExcluido          := strMensExcluido;
  LParams.strEmpCabecalho_CD       := strEmpCabecalho_CD;
  LParams.blnCabecalhoCD           := blnCabecalhoCD;
  LParams.strNumRom                := strNumRom;
  LParams.dtaSepFut                := dtaSepFut;
  LParams.hraSepFut                := hraSepFut;
  LParams.blnTicketDV              := blnTicketDV;
  LParams.strCodIct                := strCodIct;
  LParams.blnSomenteEmpDifSep      := blnSomenteEmpDifSep;
  LParams.blnImpBaixaSeparacao     := blnImpBaixaSeparacao;
  LParams.blnImpSepPickingCheckOut := blnImpSepPickingCheckOut;
  LParams.strCodLayFilSep          := strCodLayFilSep;
  LParams.blnFatAut                := blnFatAut;
  LParams.blnImpressaoColetor      := blnImpressaoColetor;
  LParams.blnSepPendRomaneio       := blnSepPendRomaneio;
  LParams.blnReimpressaoGR         := blnReimpressaoGR;
  LParams.intSeqSepPar             := intSeqSepPar;

  if not fUtilizarFatImpressaoExe then
  begin
    pImprimeFatImp(LParams);
    strNomeArquivo := LParams.strNomeArquivo;
  end
  else
  begin
    TStartFatImpressao.Create(VS_strCodEmp + ' ' + strLoginUsuarioLogado +
                         ' pImprimeFatImp "' + LParams.ToTempFile + '"');
  end;
end;

procedure pImprimeFatImp(var Params: TImprimeFatImpParams); overload;
  Var
    blnImprimiuEditor, blnImprimiuAmbien, blnAchouLayout: Boolean;
    strArqPDF: String;
Begin
  pImprimeFatImpAux(Params.strTabela,
                    Params.strNumDoc,
                    Params.strEspDoc,
                    Params.strCodEmp,
                    Params.strCodCli,
                    Params.strTip_Fc,
                    Params.strOriDoc,
                    Params.blnReimpressao,
                    Params.strNomeArquivo,
                    Params.blnConfirmacao,
                    Params.blnSoEditor,
                    blnImprimiuEditor,
                    blnImprimiuAmbien,
                    strArqPDF,
                    blnAchouLayout,
                    Params.strSaida,
                    Params.intQtdImp,
                    Params.opcComSemPreco,
                    Params.fltDebCli,
                    Params.blnDocSep,
                    Params.blnTickIF,
                    Params.blnValTot,
                    Params.blnQtdOri,
                    Params.strFila,
                    Params.strTipImpressao,
                    Params.blnDocCancelado,
                    Params.blnImpExpedicao,
                    Params.blnComprovInd,
                    Params.blnSempreEntr,
                    Params.blnRequisicao,
                    Params.blnFilaEmpDoc,
                    Params.blnImprPedido,
                    Params.opcAbastecimento,
                    Params.blnImpFil,
                    Params.blnEnt_CD,
                    Params.blnPenden,
                    Params.blnLocFisEmpEmi,
                    Params.blnSepFut,
                    Params.strSepPedEntregaOuRetira,
                    Params.strSetor,
                    Params.cdsLogSeparacao,
                    Params.blnRecCliGar,
                    Params.strOpcDoc,
                    Params.strTipNomEmp,
                    Params.strOrdem,
                    Params.blnPreRomaneio,
                    Params.opcAgrupaPor,
                    Params.blnSomenteNaoImp,
                    Params.strCodLse,
                    Params.strWhereSep,
                    Params.blnF9OrF10,
                    Params.blnPerTot,
                    Params.blnGerPdf,
                    Params.strPasPdf,
                    Params.blnVisPdf,
                    Params.blnPenExp,
                    Params.blnTicketNF,
                    Params.blnSintetizaItensExped,
                    Params.blnEmail,
                    Params.blnVidro,
                    Params.strMensNovo,
                    Params.strMensExcluido,
                    Params.strEmpCabecalho_CD,
                    Params.blnCabecalhoCD,
                    False,
                    Params.strNumRom,
                    Params.dtaSepFut,
                    Params.hraSepFut,
                    Params.blnTicketDV,
                    Params.strCodIct,
                    Params.blnSomenteEmpDifSep,
                    Params.blnImpBaixaSeparacao,
                    Params.blnImpSepPickingCheckOut,
                    Params.strCodLayFilSep,
                    Params.blnFatAut,
                    Params.blnImpressaoColetor,
                    Params.blnSepPendRomaneio,
                    Params.blnReimpressaoGR,
                    False,
                    Params.intSeqSepPar);
 End;
 {$ENDIF}

{$IFNDEF LINUX}
procedure pImprimeFatImpAuxTin(strTabela,
                         strNumDoc,
                         strEspDoc,
                         strCodEmp,
                         strCodCli,
                         strTip_Fc,
                         strOriDoc: String;
                         blnReimpressao: Boolean;
                         Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                         blnConfirmacao: Boolean;
                         blnSoEditor: Boolean;
                         Var blnImprimiuEditor: Boolean;
                         Var blnImprimiuAmbien: Boolean;
                         Var strArqPDFEditor: String;
                         Var blnAchouLayout: Boolean;
                         strSaida: String = 'I';
                         intQtdImp: Integer = 1;
                         opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                         fltDebCli: Double = 0.0;
                         blnDocSep: Boolean = False;
                         blnTickIF: Boolean = False;
                         blnValTot: Boolean = True;
                         blnQtdOri: Boolean = True;
                         strFila: String = '';
                         strTipImpressao: String = '';
                         blnDocCancelado: Boolean = False;
                         blnImpExpedicao: Boolean = False;
                         blnComprovInd: Boolean = False;
                         blnSempreEntr: Boolean = False;
                         blnRequisicao: Boolean = False;
                         blnFilaEmpDoc: Boolean = False;
                         blnImprPedido: Boolean = False;
                         opcAbastecimento: TOpcAbastecimento = opcTodos;
                         blnImpFil: Boolean = False;
                         blnEnt_CD: Boolean = False;
                         blnPenden: Boolean = False;
                         blnLocFisEmpEmi: Boolean = False;
                         blnSepFut: Boolean = False;
                         strSepPedEntregaOuRetira: String = '';
                         strSetor: string = ' ';
                         cdsLogSeparacao: TUniClientDataSet = Nil;
                         blnRecCliGar: Boolean = False;
                         strOpcDoc: String = '';
                         strTipNomEmp: String = ''; // Razao Social ou Fantasia
                         strOrdem: String = '';     //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                         blnPreRomaneio: Boolean = False;
                         opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                         blnSomenteNaoImp: Boolean = False;
                         strCodLse: String = '';
                         strWhereSep: String = '';
                         blnF9OrF10: Boolean = False;
                         blnPerTot: Boolean = False;
                         blnGerPdf: Boolean = False;
                         strPasPdf: String = '';
                         blnVisPdf: Boolean = False;
                         blnPenExp: Boolean = False;
                         blnTicketNF: Boolean = False;
                         blnSintetizaItensExped: Boolean = False;
                         blnEmail: Boolean = False;
                         blnVidro: Boolean = False;
                         strMensNovo: String = '';
                         strMensExcluido: String = '';
                         strEmpCabecalho_CD: String = '';
                         blnCabecalhoCD: Boolean = False;
                         blnAjMl : Boolean = False;
                         blnTicketDV: Boolean = False);
  Var
    strSQL       : String;
    strNomeFila  : String;
    strTipImp    : String;
    strMeiaFolha : String;
    intContador  : Integer;
    fltPerIss    : Double;
    fltValIss    : Double;
    fltTotSer    : Double;
    blnTemServico: Boolean;
    impNaoFiscal : TImpNaoFiscal;
    strEspTeste  : String;
    strColRel    : String;
    strNumPed    : String;
    strTransp    : String;
    str40ColS    : String;
    strSQLItens  : String;
    strTabelaGer : String;
    strAbrTabGer : String;
    qryGenGer    : TUniQuery;
    strGeraRom   : String;
    qryCfgRel    : TUniQuery;
    strSQLTabPre : String;
    strOrdPdv    : String;
    strOrdSep    : String;
    strOrdDoc    : String;
    strSetorSep  : String;
    strJoinMovTri: String;
    strMsgCof    : String;

    qryEntGer    : TUniQuery;
    arrEntGer    : TStringArray;
    arrEmpFor    : TStringArray;
    i, x         : Integer;

    strImpAju    : String;
    strEntFut    : String;
    strNomForm   : String;
    strModDav: String;
    frxQckDav: TfrmQckDAV;

    blnAgruparItensSeparacao: Boolean;
    blnUtilizaVendaMadOuVid: Boolean;
    cdsImpressaoMadeira,
    cdsImpressaoLogSep,
    cdsItensPendSeparacao : TUniClientDataSet;
    blnImprimeDescricaoSimplificada : Boolean;
    blnAjuste : Boolean;
    strCodLay : String;
    objOcoCrm : TAtuOcoCrm;
    objImpSepEspecif: TImpSepEspecif;
    strNomTra: String;

    intOpcao: Integer;
    TipoEspDefAmbiente: TTipoEspDefAmbiente;

    function fDataSetImpressao: TDataSet;
    begin
      If Assigned(cdsImpressaoLogSep) Then
        Result := cdsImpressaoLogSep

      Else If blnUtilizaVendaMadOuVid And (Pos(strEspDoc,'GA_GC_') <= 0) And Assigned(cdsImpressaoMadeira) Then
        Result := cdsImpressaoMadeira

      Else
        Result := frmModuloSPR.qryRelatorio;
    end;

    Function fRetLocFisicaEmpCD(strFieldNumLot, strFieldCodIte, strFieldCodEmp: String): String;
    Begin
      Result :=          '  (CASE ';
      Result := Result + '    WHEN (IFNULL('+strFieldNumLot+', "")  = "") THEN (SELECT SI.ITE_LOCFIS FROM ITEGER SI WHERE SI.ITE_CODITE = '+strFieldCodIte+' AND SI.ITE_CODEMP = ' + QuotedStr(fCfgSis('EMP_CD')) + ')';
      Result := Result + '    WHEN (IFNULL('+strFieldNumLot+', "") <> "") THEN (SELECT SL.LOT_LOCFIS FROM CADLOT SL WHERE SL.LOT_NUMLOT = '+strFieldNumLot+' AND SL.LOT_CODITE = ' + strFieldCodIte + ' AND SL.LOT_CODEMP = ' + QuotedStr(fCfgSis('EMP_CD')) + ')';
      Result := Result + '  END) AS LOCFIS,  ';
    End;

    function fGetSqlQtdItePedOrc: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
        Result := Result + ' SUM( ';

      If blnQtdOri Then
        Result := Result + ' FDO_QTDITE '
      Else
        Result := Result + ' (FDO_QTDITE - FDO_QTDBAI) ';

      If blnAgruparItensSeparacao Then
        Result := Result + ' ) ';
    end;

    function fGetSqlQtdEmbPedOrc: String;
    begin
      Result := ' IF(ITE_MLTVEN > 1, ' + fGetSqlQtdItePedOrc + ' / ITE_MLTVEN, 0) ';
    end;

    function fGetSqlGroupByPedOrc: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
      Begin
        Result := Result + ' GROUP BY ';
        Result := Result + '   FDO_CODITE, FDO_IDEPRO, FDO_DESCRI, FDO_NUMLOT, ';
        Result := Result + '   FDO_UNIDAD, FDO_PROACA, FDO_CODACA, FDO_EMPACA  ';
      End;

    end;

    function fGetSqlQtdIteVenda: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
        Result := Result + ' SUM( ';

      If blnSepFut Then
        Result := Result + '   SEP_QTDITE '
      Else
        Result := Result + '   DET_QTDITE ';

      If blnAgruparItensSeparacao Then
        Result := Result + ' ) ';
    end;

    function fGetSqlQtdEmbVenda: String;
    begin
      Result := ' IF(ITE_MLTVEN > 1, ' + fGetSqlQtdIteVenda + ' / ITE_MLTVEN, 0) ';
    end;

    function fGetSqlGroupByVenda: String;
    begin
      Result := '';

      If blnAgruparItensSeparacao Then
      Begin
        Result := Result + ' GROUP BY ';
        Result := Result + '   DET_CODITE, DET_DESCRI, DET_IDEPRO, DET_NUMLOT ';
      End;

    end;

    function fRetLayout_PD_OR_SemPreco: String;
    Begin
      If (opcComSemPreco = impComPrecoGeral) Or (blnDocSep) Then
        Exit;

      If fEmptyStr(strPasPdf) Then
      Begin
        If (strEspDoc = 'OR') Then
          Result := fCfgSis('PDFOSP', VarString)
        Else If (strEspDoc = 'PD') Then
          Result := fCfgSis('PDFPSP', VarString)
        Else
          Result := '';
      End
      Else
      Begin
        If (strEspDoc = 'OR') Then
          Result := fCfgSis('PDFSPO', VarString)
        Else If (strEspDoc = 'PD') Then
          Result := fCfgSis('PDFSPP', VarString)
        Else
          Result := '';
      End;

      If fCfgSis('ORSPSM', varBoolean) Then
      Begin
        Result := '';

        If (strEspDoc = 'OR') Then
        Begin
          Case opcComSemPreco Of
            impComPrecoComMarca: Result := fCfgSis('CPCMOR', VarString);
            impComPrecoSemMarca: Result := fCfgSis('CPSMOR', VarString);
            impSemPrecoComMarca: Result := fCfgSis('SPCMOR', VarString);
            impSemPrecoSemMarca: Result := fCfgSis('SPSMOR', VarString);
          End;
        End
        Else If (strEspDoc = 'PD') Then
        Begin
          Case opcComSemPreco Of
            impComPrecoComMarca: Result := fCfgSis('CPCMPD', VarString);
            impComPrecoSemMarca: Result := fCfgSis('CPSMPD', VarString);
            impSemPrecoComMarca: Result := fCfgSis('SPCMPD', VarString);
            impSemPrecoSemMarca: Result := fCfgSis('SPSMPD', VarString);
          End;
        End
        Else
          Result := '';
      End;

      If (Not fEmptyStr(Result)) Then
      Begin
        If (Not fExisteLayoutLAYETI(Result)) Then
          Result := '';
      End;

      If (Pos(strEspDoc, 'OR_PD_') > 0) And (fEmptyStr(Result)) And (strSaida = 'P') Then
      begin
        If fCfgSis('ORSPSM', varBoolean) Then
        Begin
          Case opcComSemPreco Of
            impComPrecoComMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Com Preço Com Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_CPCM'+strEspDoc);
            impComPrecoSemMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Com Preço Sem Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_CPSM'+strEspDoc);
            impSemPrecoComMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Sem Preço Com Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_SPCM'+strEspDoc);
            impSemPrecoSemMarca: pMensagemOk('Não foi encontrado o Layout para PDF "Sem Preço Sem Marca"!' + #13#10 +
                                             'Será impresso no formulário padrão de PDF.' + #13#10 +
                                             'Verifique a configuração: CFG_SPSM'+strEspDoc);
          End;
        End
        Else
        Begin
          If fEmptyStr(strPasPdf) Then
            strMsgCof := IfThen(strEspDoc = 'OR', 'CFG_PDFOSP', 'CFG_PDFPSP')
          else
            strMsgCof := IfThen(strEspDoc = 'OR', 'CFG_PDFSPO', 'CFG_PDFSPP');

          pMensagemOk('Não foi encontrado o Layout para PDF sem preço!' + #13#10 +
                      'Será impresso no formulário padrão de PDF.' + #13#10 +
                      'Verifique a configuração: ' + strMsgCof );
        End;
      end;
    End;

    Function fImprimeLayoutEditor: Boolean;
      Var
        objImpressao: TEditorFastImpressao;
    begin
      objImpressao := TEditorFastImpressao.Create(Nil);

      With objImpressao Do
      Begin
        If blnPreRomaneio Then
        Begin
          If opcAgrupaPor = opcPedido Then
          Begin
            recDocume.strNumDoc        := strNumDoc;
            recDocume.strCodEmp        := strCodEmp;
            recDocume.strEspDoc        := strEspDoc;
            recDocume.opcAgrupaPor     := opcAgrupaPor;
            recDocume.blnSomenteNaoImp := False;
            recDocume.strCodLse        := strCodLse;
          End
          Else
          Begin
            recDocume.strNumDoc        := fRetNumRom(strCodemp, False, strNumDoc, strEspDoc, strCodCli);
            recDocume.strCodEmp        := strCodEmp;
            recDocume.strEspDoc        := 'RO';
            recDocume.opcAgrupaPor     := opcAgrupaPor;
            recDocume.blnSomenteNaoImp := blnSomenteNaoImp;
          End;
        End
        Else
        Begin
          recDocume.strNumDoc        := strNumDoc;
          recDocume.strEspDoc        := strEspDoc;
          recDocume.strCodEmp        := strCodEmp;
          recDocume.strOrdem         := strOrdem;
        End;

        recDocume.strNomImp   := strFila;
        recDocume.strTipImp   := strTipImpressao;

        recDocume.blnDocSep   := blnDocSep;
        recDocume.strWhereSep := strWhereSep;

        recDocume.strCodCli := strCodCli;

        recDocume.strSetor  := strSetor;
        recDocume.strSaida  := strSaida;
        recDocume.strTipFC  := strTip_FC;

        recDocume.intQtdImp := intQtdImp;

        recDocume.blnReimpr := blnReimpressao;
        recDocume.blnDocCan := blnDocCancelado;
        recDocume.blnQtdOri := blnQtdOri;
        recDocume.blnConfir := blnConfirmacao;
        recDocume.blnImpExpedicao := blnImpExpedicao;
        recDocume.blnFilEmp := blnFilaEmpDoc;
        recDocume.blnImpFil := blnImpFil;
        recDocume.blnSepFut := blnSepFut;
        recDocume.blnEnt_CD := blnEnt_CD;
        recDocume.blnPerTot := blnPerTot;
        recDocume.blnPenExp := blnPenExp;
        recDocume.blnAjMl  := blnAjMl;

        recDocume.blnSimples               := blnSimples;
        recDocume.blnSempreEntr            := blnSempreEntr;
        recDocume.blnRequisicao            := blnRequisicao;
        recDocume.blnLocFisEmpEmi          := blnLocFisEmpEmi;
        recDocume.blnAgruparItensSeparacao := blnAgruparItensSeparacao;
        recDocume.strSepPedEntregaOuRetira := strSepPedEntregaOuRetira;

        recDocume.opcAbastecimento         := opcAbastecimento;
        recDocume.cdsLogSeparacao          := cdsLogSeparacao;
        recDocume.blnSomenteEmpDifSep      := False;

        recDocume.strMensNovo              := strMensNovo;
        recDocume.strMensExcluido          := strMensExcluido;

        recDocume.strCodLay := '';

        If (opcComSemPreco <> impComPrecoGeral) Then
          recDocume.strCodLay := fRetLayout_PD_OR_SemPreco;

        recDocume.blnGerPdf := blnGerPdf;
        recDocume.strPasPdf := strPasPdf;
        recDocume.blnVisPdf := blnVisPdf;
        recDocume.blnTicketNF := blnTicketNF;
        recDocume.blnTicketDV := blnTicketDV;
        objImpressao.recDocume.blnVidro  := blnVidro;
        recDocume.strEmpCabecalho_CD := strEmpCabecalho_CD;
        recDocume.blnCabecalhoCD     := blnCabecalhoCD;

        If strSaida = 'P' Then
        Begin
          fImprimeDocumento(tpaPDF)
        End
        Else
        Begin
          If (strSaida = 'E') And (TDocPDOR_Excel.fUtilizaLayOutExcel) And (Pos(strEspDoc, 'OR_PD_') > 0) Then
          Begin

            fImprimeDocumento(tpaExcel);

            If Not fEmptyStr(strArqExcel) Then
              strNomeArquivo := strArqExcel;

          End
          Else
            fImprimeDocumento;
        End;

        If (strSaida = 'P') Or (blnGerPdf) Then
        Begin
          If recDocume.blnTemLay Then
          Begin
            strArqPDFEditor := strArqPDF;
            strNomeArquivo  := strArqPDF;
          End;
        End;

        blnAchouLayout := recDocume.blnTemLay;
        Result := recDocume.blnTemLay and recDocume.blnImprimiu;
      End;

      If Assigned(objImpressao) Then
        FreeAndNil(objImpressao);

    End;

    Function fImpDAV: Boolean;
    Begin
      Result := False;

      strModDav := fCfgSis('MOVDAV');
      If (Pos(strEspDoc, 'OR_PD_') > 0) And (Not blnDocSep) And (Not blnRequisicao) And
         ( (strModDav = '2') Or (strModDav = '3') ) And (fCfgSis('PAFECF', varBoolean)) Then
      Begin
        If strModDav = '2' Then
        Begin
          frxQckDav := TfrmQckDAV.Create(Nil);
          frxQckDav.pImprimirDAV(strNumDoc, strEspDoc, strNomeFila, strSaida);
          FreeAndNil(frxQckDav);
          Result := True;
        End
        Else
        Begin
          pMensagemOk('O Documento foi disponibilizado no Resumo de Caixa [ALT+V] para Impressão do DAV na ECF!');
          pMarcarDocumentoParaImpressaoNoECF(strNumDoc, strEspDoc);
          Result := True;
        End;
      End;
    End;

Begin
  cdsItensPendSeparacao := TUniClientDataSet.Create(Nil);
  cdsItensPendSeparacao.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  cdsItensPendSeparacao.FieldDefs.Add('QTDITE', ftFloat);
  cdsItensPendSeparacao.CreateDataSet;

  Try
    blnImprimiuAmbien := False;

    blnUtilizaVendaMadOuVid := fCfgSis('VENMAD', varBoolean) Or
                               fCfgSis('VENVID', varBoolean);

    blnAgruparItensSeparacao := blnDocSep And
                                Not blnUtilizaVendaMadOuVid And
                                fCfgSis('SINSEP', varBoolean);

    {***************************************************************}
    {* SE FOR IMPRESSÃO DE SEPARAÇÃO DO PRÉ-ROMANEIO E NÃO ESTIVER *}
    {* CONFIGURADO PARA AGRUPAR, DEVE AGRUPAR MESMO ASSIM          *}
    {************************************************************MM*}
    If ((blnPreRomaneio) And (Not blnAgruparItensSeparacao))or (blnSintetizaItensExped){ Or fUsaRotinaWMS *} Then {(*) CONDIÇÃO COLOCADA REVISÃO 128053 REQ.: 46947 E QUE COMENTEI NO REQ.: 80712 POIS ESTAVA SINTETIZANDO TODAS AS ESPÉCIES}
      blnAgruparItensSeparacao := True;


    {******************************************************}
    {* NÃO IMPRIMIR SE IMPAUT = 2 - SÓ AUTENTICAÇÃO       *}
    {***************************************************NC*}
    If Not ((Pos(strEspDoc,'MI_FF_') > 0) And (fCfgSis('IMPAUT') = '2') And blnConfirmacao And (Not blnDocSep)) Then
    Begin

      If (Not blnEmail) And fImpDAV Then
      Begin
        blnImprimiuEditor := True;
        Exit;
      End;

      If blnDocSep And (strEspDoc = 'PD') And TfrmSeparacaoPedidoEstrutura.fTemFR3 Then
      Begin
        TfrmSeparacaoPedidoEstrutura.pImprime(strTabela, strNumDoc, strEspDoc, strCodCli, strCodEmp);
        Exit;
      End
      Else If (strSaida = 'I') And (Not blnDocSep) And (Pos(strEspDoc, 'PD_OR_FF_BR_TR_DV_') > 0) And TfrmImpEspCalub.fTemFR3 And (Not blnF9OrF10) Then
      Begin
        TfrmImpEspCalub.pImprime(strNumDoc, strEspDoc, strCodCli, strCodEmp, intQtdImp);
        Exit;
      End
      Else If (Not blnDocSep) And
              (fCfgSis('UTIDEF', varBoolean) And (fGetUtilizaLayoutFR3EspecificoImpDefAmbiente(strEspDoc))) Then
      Begin

        TipoEspDefAmbiente := tedaComPreco;
        If (Pos(strEspDoc, 'OR_') > 0) And (blnReimpressao) And (fCfgSis('UTIPDF', varBoolean)) Then
        Begin
          if TfrmImpEspDefAmbiente.fTemFR3(tedaReferenciaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferencia) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabricaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabrica) Then
           Begin
            intOpcao := fGetMenu('Opção para geração do PDF',['Com Preço', 'Sem Preço', 'Sem Preço Simplificado', 'Referência e Marca', 'Referência', 'Código de Fábrica e Marca', 'Código de Fábrica'], 1);
            case intOpcao of
              1: TipoEspDefAmbiente := tedaComPreco;
              2: TipoEspDefAmbiente := tedaSemPreco;
              3: TipoEspDefAmbiente := tedaSemPrecoSimplificado;
              4: TipoEspDefAmbiente := tedaReferenciaMarca;
              5: TipoEspDefAmbiente := tedaReferencia;
              6: TipoEspDefAmbiente := tedaCodigoFabricaMarca;
              7: TipoEspDefAmbiente := tedaCodigoFabrica;
            end;

           End
           Else
           Begin
            intOpcao := fGetMenu('Opção para geração do PDF',['Com Preço', 'Sem Preço', 'Sem Preço Simplificado'], 1);
            case intOpcao of
              1: TipoEspDefAmbiente := tedaComPreco;
              2: TipoEspDefAmbiente := tedaSemPreco;
              3: TipoEspDefAmbiente := tedaSemPrecoSimplificado;
            end;
           END
        End
        Else
        Begin
          if (Pos(strEspDoc, 'FF_') <= 0) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferenciaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaReferencia) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabricaMarca) and TfrmImpEspDefAmbiente.fTemFR3(tedaCodigoFabrica) Then
          Begin
            intOpcao := fGetMenu('Opção para geração do PDF',['Referência e Marca', 'Referência', 'Código de Fábrica e Marca', 'Código de Fábrica'], 1);
            case intOpcao of
              1: TipoEspDefAmbiente := tedaReferenciaMarca;
              2: TipoEspDefAmbiente := tedaReferencia;
              3: TipoEspDefAmbiente := tedaCodigoFabricaMarca;
              4: TipoEspDefAmbiente := tedaCodigoFabrica;
            end;

          End
          Else
          Begin
            if (opcComSemPreco In [impComPrecoGeral, impComPrecoSemMarca]) then
              TipoEspDefAmbiente := tedaComPreco
            else
              TipoEspDefAmbiente := tedaSemPreco;
          End
        End;

        TfrmImpEspDefAmbiente.pImprime(strNumDoc, strEspDoc, strCodCli, strCodEmp, intQtdImp, strSaida, blnVisPdf, strNomeArquivo, TipoEspDefAmbiente, blnReimpressao, blnDocSep);

        blnImprimiuAmbien := True;

        Exit;

      End
      Else If (blnDocSep) And (strEspDoc = 'PD') And (fCfgSis('SEPESP', varBoolean)) Then Begin
        Try
          objImpSepEspecif := TImpSepEspecif.Create(strFila, blnConfirmacao);

          strNomTra := fCampoTabela('TRA_NOMTRA', 'CADTRA', ['TRA_CODTRA'],
            [
              fCampoTabela('FGO_CODTRA', 'FATGOR',
                                        ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP', 'FGO_CODCLI'],
                                        [strNumDoc, strEspDoc, strCodEmp, strCodCli])
            ]);

          blnTemServico := (Not fEmptyStr(
                                            fCampoTabela('FGO_CODS01', 'FATGOR',
                                                         ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP', 'FGO_CODCLI'],
                                                         [strNumDoc, strEspDoc, strCodEmp, strCodCli])
                                         )
                           );

          objImpSepEspecif.pImprime(blnTemServico,
                                    strTabela,
                                    strNumDoc,
                                    strEspDoc,
                                    strCodEmp,
                                    strCodCli,
                                    strOriDoc,
                                    strNomTra,
                                    fltDebCli,
                                    blnReimpressao,
                                    blnDocSep,
                                    (opcComSemPreco In [impComPrecoGeral, impComPrecoSemMarca]),
                                    False,  //blnImpTck
                                    '',     //str40ColS
                                    strTip_Fc,
                                    strOriDoc,
                                    '',     //strSQLItens,
                                    blnValTot,
                                    blnDocCancelado,
                                    'V',  //strSaida
                                    intQtdImp,
                                    blnImprPedido,
                                    blnEnt_CD,
                                    blnSepFut,
                                    strSepPedEntregaOuRetira);
        Finally
          FreeAndNil(objImpSepEspecif);
          FreeAndNil(qryCfgRel);
        End;

        Exit;
      End
      Else
        {******************************************************}
        {* CASO NÃO CONSEGUIR IMPRIMIR NO PADRÃO NOVO,        *}
        {* FINALIZA A ROTINA  (verificar se vai ficar assim)  *}
        {***************************************************RB*}
        blnImprimiuEditor := fImprimeLayoutEditor;

      If blnImprimiuEditor Or blnSoEditor Then
        FreeAndNil(cdsItensPendSeparacao)
      Else If (Not blnAchouLayout) Then
        pNotificacaoSistemaProblema('','Não há layout disponível para impressão!', strEspDoc);
    End;

    If blnDocSep And VS_strHabilitarCRM Then
    Begin
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodCli,
                                           strNumDoc,
                                           strEspDoc,
                                           afcSeparacaoImpressa.fGetOperador(strNumDoc, strEspDoc, strCodEmp),
                                           afcNenhum);

      objOcoCrm.strCodOco := fRetornaCodigoOcorrencia(objOcoCrm.strNumOrc,objOcoCrm.strEspOrc,objOcoCrm.strCodCli,objOcoCrm.strCodEmp,'');
      objOcoCrm.strNomFrm := '[pImprimeFatImpAuxTin]';

      If Not fEmptyStr(objOcoCrm.strCodOco) Then
      Begin
        objOcoCrm.strDtaInc := VS_Date;
        objOcoCrm.strHorInc := fRetHoraServidor();
        objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
        objOcoCrm.strHorAge := objOcoCrm.strHorInc;
        objOcoCrm.strOpeHis := strLoginUsuarioLogado;
        objOcoCrm.strDtaCon := 0;
        objOcoCrm.strHorCon := 0;
        objOcoCrm.strCodSit := afcSeparacaoImpressa.fGetSituacao();
        objOcoCrm.strDescri := afcSeparacaoImpressa.fGetDescricao() + '.' + '<<csq>><<csq>>' +
                               'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);
        objOcoCrm.pInsereHistoricoOcorrencia;
        objOcoCrm.pAtualizaOcorrencia;
      End;

      FreeAndNil(objOcoCrm);
    End;

  Finally
    If (strEspDoc = 'PD') And (blnDocSep) Then
      TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(strNumDoc)
                          .EspDoc(strEspDoc)
                          .CodEmp(strCodEmp)).pExecute();

    FreeAndNil(cdsItensPendSeparacao);
    FreeAndNil(qryGenGer);

    If Assigned(cdsImpressaoMadeira) Then
      FreeAndNil(cdsImpressaoMadeira);

    If Assigned(cdsImpressaoLogSep) Then
      FreeAndNil(cdsImpressaoLogSep);

    If (frmModuloSPR.dtsRelatorio.DataSet <> frmModuloSPR.qryRelatorio) Then
    Begin
      If frmModuloSPR.qryRelatorio.Active Then
        frmModuloSPR.qryRelatorio.Close;
      frmModuloSPR.dtsRelatorio.DataSet := frmModuloSPR.qryRelatorio;
    End;
  End;

End;
{$ENDIF}

{$IFNDEF LINUX}
procedure pImprimeFatImpTin(strTabela,
                         strNumDoc,
                         strEspDoc,
                         strCodEmp,
                         strCodCli,
                         strTip_Fc,
                         strOriDoc: String;
                         blnReimpressao: Boolean;
                         Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                         blnConfirmacao: Boolean;
                         strSaida: String = 'I';
                         intQtdImp: Integer = 1;
                         opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                         fltDebCli: Double = 0.0;
                         blnDocSep: Boolean = False;
                         blnTickIF: Boolean = False;
                         blnValTot: Boolean = True;
                         blnQtdOri: Boolean = True;
                         strFila: String = '';
                         strTipImpressao: String = '';
                         blnDocCancelado: Boolean = False;
                         blnImpExpedicao: Boolean = False;
                         blnComprovInd: Boolean = False;
                         blnSempreEntr: Boolean = False;
                         blnRequisicao: Boolean = False;
                         blnFilaEmpDoc: Boolean = False;
                         blnImprPedido: Boolean = False;
                         opcAbastecimento: TOpcAbastecimento = opcTodos;
                         blnImpFil: Boolean = False;
                         blnEnt_CD: Boolean = False;
                         blnPenden: Boolean = False;
                         blnLocFisEmpEmi: Boolean = False;
                         blnSepFut: Boolean = False;
                         strSepPedEntregaOuRetira: String = '';
                         strSetor: String = ' ';
                         cdsLogSeparacao: TUniClientDataSet = Nil;
                         blnRecCliGar: Boolean = False;
                         strOpcDoc: String = '';
                         strTipNomEmp: String = ''; // Razao Social ou Fantasia
                         strOrdem: String = '';  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                         blnPreRomaneio: Boolean = False;
                         opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                         blnSomenteNaoImp: Boolean = False;
                         strCodLse: String = '';
                         strWhereSep: String = '';
                         blnF9OrF10: Boolean = False;
                         blnPerTot: Boolean = False;
                         blnGerPdf: Boolean = False;
                         strPasPdf: String = '';
                         blnVisPdf: Boolean = False;
                         blnSoEditor: Boolean = False;
                         blnPenExp: Boolean = False;
                         blnTicketNF: Boolean = False;
                         blnSintetizaItensExped: Boolean = False;
                         blnEmail: Boolean = False;
                         blnVidro: Boolean = False;
                         strMensNovo: String = '';
                         strMensExcluido: String = '';
                         strEmpCabecalho_CD: String = '';
                         blnCabecalhoCD: Boolean = False;
                         blnTicketDV: Boolean = False);
  Var
    blnImprimiuEditor, blnImprimiuAmbien, blnAchouLayout: Boolean;
    strArqPDF: String;
Begin
  pImprimeFatImpAuxTin(strTabela,
                    strNumDoc,
                    strEspDoc,
                    strCodEmp,
                    strCodCli,
                    strTip_Fc,
                    strOriDoc,
                    blnReimpressao,
                    strNomeArquivo,
                    blnConfirmacao,
                    blnSoEditor,
                    blnImprimiuEditor,
                    blnImprimiuAmbien,
                    strArqPDF,
                    blnAchouLayout,
                    strSaida,
                    intQtdImp,
                    opcComSemPreco,
                    fltDebCli,
                    blnDocSep,
                    blnTickIF,
                    blnValTot,
                    blnQtdOri,
                    strFila,
                    strTipImpressao,
                    blnDocCancelado,
                    blnImpExpedicao,
                    blnComprovInd,
                    blnSempreEntr,
                    blnRequisicao,
                    blnFilaEmpDoc,
                    blnImprPedido,
                    opcAbastecimento,
                    blnImpFil,
                    blnEnt_CD,
                    blnPenden,
                    blnLocFisEmpEmi,
                    blnSepFut,
                    strSepPedEntregaOuRetira,
                    strSetor,
                    cdsLogSeparacao,
                    blnRecCliGar,
                    strOpcDoc,
                    strTipNomEmp,
                    strOrdem,
                    blnPreRomaneio,
                    opcAgrupaPor,
                    blnSomenteNaoImp,
                    strCodLse,
                    strWhereSep,
                    blnF9OrF10,
                    blnPerTot,
                    blnGerPdf,
                    strPasPdf,
                    blnVisPdf,
                    blnPenExp,
                    blnTicketNF,
                    blnSintetizaItensExped,
                    blnEmail,
                    blnVidro,
                    strMensNovo,
                    strMensExcluido,
                    strEmpCabecalho_CD,
                    blnCabecalhoCD,
                    False,
                    blnTicketDV);
End;
{$ENDIF}

function fExisteInvoice(strNumDoc, strEspDoc, strCodEmp: String): boolean;
Var
  LQuery: TUniQuery;
Begin

  result := false;

  LQuery := fCriaQuery;

  try
    LQuery.Close;
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT                              ');
    LQuery.SQL.Add('  COUNT(*) AS QTDINV                ');
    LQuery.SQL.Add('FROM                                ');
    LQuery.SQL.Add('  FATGOR F                          ');
    LQuery.SQL.Add('  INNER JOIN INVOIC IV              ');
    LQuery.SQL.Add('    ON IV.INV_SEQFGO = F.AUTOINCREM ');
    LQuery.SQL.Add('WHERE F.FGO_NUMDOC = :NUMDOC        ');
    LQuery.SQL.Add('  AND F.FGO_ESPDOC = :ESPDOC        ');
    LQuery.SQL.Add('  AND F.FGO_CODEMP = :CODEMP ;      ');

    LQuery.ParamByName('NUMDOC').asString := strNumDoc;
    LQuery.ParamByName('ESPDOC').asString := strEspDoc;
    LQuery.ParamByName('CODEMP').asString := strCodEmp;

    LQuery.Open;

    if LQuery.FieldByName('QTDINV').asInteger > 0 then
      result := true;

  finally
    FreeAndNil(LQuery);
  end;

end;

procedure pValidaImpressao(intQtdIte: Integer; strEspDoc: String);
  Var
    strConfig,
    LEntRet,
    LOpcoesItens : String;

begin
  If (Pos(strEspDoc, 'PD_OR_') > 0) And fCfgSis('AUTCEN', VarBoolean) Then
    Exit;

  If fCfgSis('PEGPED', varBoolean) Then
    Exit;

  If (fUtilizaFilasImpressaoSeparacaoConfiguradas(strEspDoc)) Then
    Exit;

  If fUsaOndaSeparacaoAgrupamento Then
    Exit;

  If (intQtdIte <= 0) Then
  Begin
    LEntRet := fCfgSis('TPSPPV',varString);
    If (Pos('N', LEntRet) > 0) Then
    Begin
      LOpcoesItens := '[';
      If LEntRet[1] = 'N' then
        LOpcoesItens := 'Retira';
      If LEntRet[2] = 'N' then
        LOpcoesItens := LOpcoesItens + IIF(LOpcoesItens = '[', 'Entrega Imediata', ', Entrega Imediata');
      If LEntRet[3] = 'N' then
        LOpcoesItens := LOpcoesItens + IIF(LOpcoesItens = '[', 'Entrega Futura', ', Entrega Futura');
      LOpcoesItens := LOpcoesItens + ']';

      pMensagemOk('A variável TPSPPV está configurada para não mostrar os itens ' + LOpcoesItens +
                  '. Altere a configuração da variável citada, para mostrar os itens do documento na separação!');
    End
    Else
    Begin
      strConfig := IIF(strEspDoc = 'PD', 'CFG_IMSEPO', 'CFG_IMSEPE');

      pMensagemOk('Não foram informados itens do documento para a impressão de sua separação. '+
                  'Verifique se existe layout de separação formatado e a configuração '+ strConfig);
    End;
  End;
end;

{$IFNDEF LINUX}
function fRetornaLayotImpressao(strNumDoc, strEspDoc, strCodEmp, strCodLay: string): string;
var
  qryLayout,
  qryDocumento: TUniQuery;
  strMsg: String;
begin
  Result := strCodLay;

  qryLayout := fCriaQuery;
  qryDocumento := fCriaQuery;

  try
    qryLayout.Close;
    qryLayout.SQL.Clear;

    qryLayout.SQL.Add('SELECT * FROM IMPDOR');
    qryLayout.SQL.Add('WHERE DOR_CODEMP = :CODEMP');
    If (fUsaLayOrigReimpDocs()) Then
      qryLayout.ParamByName('CODEMP').AsString := strCodEmp
    Else
      qryLayout.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryLayout.Open;

    while not qryLayout.Eof do
    begin
      qryDocumento.Close;
      qryDocumento.SQL.Clear;
      qryDocumento.SQL.Add('SELECT FGO_NUMDOC FROM FATGOR');
      qryDocumento.SQL.Add(qryLayout.FieldByName('DOR_WHERE_').AsString);
      qryDocumento.SQL.Add('AND FGO_NUMDOC = :NUMDOC');
      qryDocumento.SQL.Add('AND FGO_ESPDOC = :ESPDOC');
      qryDocumento.SQL.Add('AND FGO_CODEMP = :CODEMP');

      qryDocumento.ParamByName('NUMDOC').AsString := strNumDoc;
      qryDocumento.ParamByName('ESPDOC').AsString := strEspDoc;
      qryDocumento.ParamByName('CODEMP').AsString := strCodEmp;

      try
        qryDocumento.Open;

        if not qryDocumento.IsEmpty then
        begin
          Result := qryLayout.FieldByName('DOR_CODLAY').AsString;
          Exit;
        end;
      except
        on E: Exception do
        begin
          strMsg := '';
          if Pos(AnsiLowerCase('You have an error in your SQL syntax'), AnsiLowerCase(E.Message)) > 0 then
          begin
            strMsg := 'Condição: ' + Copy(qryLayout.FieldByName('DOR_WHERE_').AsString, 1, 50) + '... ' +
                      'definida em CFG_LAYIMP, está mal formada. Ao usar esse recurso, o campo "Condição Where (SQL)" '+
                      'deve sempre começar com "WHERE" e NUNCA incluir "AND" no final EX: '+
                      'WHERE FGO_ESPDOC="PD" AND (FGO_CONPAG="01000" OR FGO_CODFPG="'+VS_strCodEmp+'")' + sLineBreak +
                      'Corrija as sentenças definidas na configuração CFG_LAYIMP!';
          end;

          {$IFDEF LINUX}
          if (strMsg <> '') then
          begin
            WriteError(strMsg);
            Break;
          end
          else
          begin
            WriteError(E.Message);
          end;
          {$ELSE}
          if (strMsg <> '') then
          begin
            pMensagemOk(strMsg);
            Break;
          end
          else
            raise;
          {$ENDIF}
        end;
      end;

      qryLayout.Next;
    end;
  finally
    FreeAndNil(qryLayout);
    FreeAndNil(qryDocumento);
  end;
end;
{$ENDIF}

procedure pMarcarDocumentoParaImpressaoNoECF(strNumDoc, strEspDoc: String);
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery(Nil);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  FATGOR ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  FGO_IMPDAV = FALSE ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
  qryUpd.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
  qryUpd.SQL.Add('  FGO_CODEMP = :CODEMP ');

  qryUpd.ParamByName('NUMDOC').AsString := strNumDoc;
  qryUpd.ParamByName('ESPDOC').AsString := strEspDoc;
  qryUpd.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

{$IFNDEF LINUX}
function fImprimirControleGarantia(strNumDoc, strEspDoc, strCodCli : String;  cdsMovGer: TZClient = nil; cdsMovDet: TZClient = nil; blnRetBaixa: boolean = false; tpeTipEti: TTipoEtiqueta = tpeNenhum): boolean;
  Var
    objImpressao: TEditorFastImpressao;
begin
  {    Obs: A baixa só funciona passando o cds montado}
  { quando passar o CDS ele tem que ser desenvolvido a estrutura que carrega os registros }
  Result := False;
  try
    try
      objImpressao := TEditorFastImpressao.Create(Nil);

      With objImpressao Do
      Begin
        Begin
          recDocume.strNumDoc        := strNumDoc;
          recDocume.strEspDoc        := strEspDoc;
          recDocume.strCodEmp        := VS_strCodEmp;
        End;

        recDocume.intQtdImp := 1;
        If tpeTipEti = tpeNenhum then
        Begin
          if strEspDoc = 'GF' then
             tpeTipoEtiqueta := tpeContGF
          else if strEspDoc = 'GR' then
          Begin
            if blnRetBaixa then
              tpeTipoEtiqueta := tpeContGRBaixa
            else
              tpeTipoEtiqueta := tpeContGR;
          end
          else if strEspDoc = 'GC' then
             tpeTipoEtiqueta := tpeContGC;
        End
        Else
          tpeTipoEtiqueta := tpeTipEti;


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
        recDocume.blnRequisicao            := False;
        recDocume.blnLocFisEmpEmi          := False;
        recDocume.blnAgruparItensSeparacao := False;
        If tpeTipoEtiqueta = tpeContGC then
          recDocume.strTipFc := 'C'
        Else
          recDocume.strTipFc := 'F';

        recDocume.strNumDoc := strNumDoc;
        recDocume.strEspDoc := strEspDoc;
        recDocume.strCodCli := strCodCli;
        FCdsMovGer  := cdsMovGer;
        FCdsMovDet  := cdsMovDet;

        Result := fImprimeDocumento(tpaNormal, '', '');
      End;
    Except
      on E: Exception do
         pErro(e.message);
    End;
  Finally
    FreeAndNil(objImpressao);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
function fGeraArquivoAnexoEmailConfirmacaoDocumento(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  strPath: String;
  arrArquivos: TStringArray;
  qryConsulta: TUniQuery;
  strSQL: String;
  tmpImg: TBytesStream;
  strNomArq: String;
  intSeqArq: Integer;
  LstrArquivosCompactados: String;
  LstrMensagemExcecao: String;
begin
  Result := '';

  strPath := ExtractFilePath(Application.ExeName);
  strPath := strPath +  '\' +strNumDoc+strEspDoc+strCodEmp+ '_' +FormatDateTime('yyyymmdd_hhnnsszzz', fNow) + '\';

  if not CreateDir(strPath) then
    raise Exception.CreateFmt('Não foi possível criar o diretório %s', [strPath]);

  setLength(arrArquivos, 0);

  qryConsulta := fCriaQuery;
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DIG_NUMDOC, ';
    strSQL := strSQL + '  DIG_ESPDOC, ';
    strSQL := strSQL + '  DIG_EMPDOC, ';
    strSQL := strSQL + '  DIG_NOMARQ, ';
    strSQL := strSQL + '  DIG_IMGB64 ';
    strSQL := strSQL + 'FROM MOVGER ';
    strSQL := strSQL + 'INNER JOIN MOVDIG ON DIG_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'WHERE GER_NUMFAT = :NUMDOC ';
    strSQL := strSQL + '  AND GER_TIPFAT = :ESPDOC ';
    strSQL := strSQL + '  AND GER_EMPFAT = :CODEMP ';

    qryConsulta.SQL.Text := strSQL;
    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.Open;

    while not qryConsulta.Eof do
    begin
      strNomArq :=
        qryConsulta.FieldByName('DIG_NUMDOC').AsString +
        '-' +
        qryConsulta.FieldByName('DIG_ESPDOC').AsString +
        '-' +
        qryConsulta.FieldByName('DIG_EMPDOC').AsString +
        ExtractFileExt(qryConsulta.FieldByName('DIG_NOMARQ').AsString);

      intSeqArq := 0;
      while FileExists(strPath + strNomArq) do
      begin
        inc(intSeqArq);

        strNomArq :=
          qryConsulta.FieldByName('DIG_NUMDOC').AsString +
          '-' +
          qryConsulta.FieldByName('DIG_ESPDOC').AsString +
          '-' +
          qryConsulta.FieldByName('DIG_EMPDOC').AsString +
          '-' +
          IntToStr(intSeqArq) +
          ExtractFileExt(qryConsulta.FieldByName('DIG_NOMARQ').AsString);
      end;

      setLength(arrArquivos, Length(arrArquivos) + 1);
      arrArquivos[High(arrArquivos)] := strNomArq;

      tmpImg := TBytesStream.Create(nil);
      Try
        fStreamFromBase64(qryConsulta.FieldByName('DIG_IMGB64').AsString, tmpImg);
        If (tmpImg.Size > 0) Then
          tmpImg.SaveToFile(strPath + strNomArq);
      Finally
        tmpImg.Free;
      End;

      qryConsulta.Next;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;

  if Length(arrArquivos) > 0 then
  begin
    LstrArquivosCompactados := EmptyStr;
    LstrMensagemExcecao     := EmptyStr;

    If (fDocumentoOrigemFF_DV_TR(strNumDoc, strEspDoc, strCodEmp)) And
       (fCfgSis('TAMANX', varInteger) > 0) Then
    Begin
      If (untTEnvioEmail.CompactarArquivos(strPath, 'Documentos Digitalizados.zip', arrArquivos, LstrArquivosCompactados, LstrMensagemExcecao, True, fCfgSis('TAMANX', varInteger))) Then
        Result := LstrArquivosCompactados;

      If Not fEmptyStr(LstrMensagemExcecao) Then
        raise Exception.Create(LstrMensagemExcecao)
    End
    Else If untTEnvioEmail.CompactarArquivos(strPath, 'Documentos Digitalizados.zip', arrArquivos) Then
      Result := strPath + 'Documentos Digitalizados.zip'
    Else
      raise Exception.Create('Não foi possível criar o arquivo compactado!');
  end;
end;
{$ENDIF}

{ TImprimeFatImpParams }

procedure TImprimeFatImpParams.FromTempFile(AFile: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(AFile);
    strTabela := SL.Values['strTabela'];
    strNumDoc := SL.Values['strNumDoc'];
    strEspDoc := SL.Values['strEspDoc'];
    strCodEmp := SL.Values['strCodEmp'];
    strCodCli := SL.Values['strCodCli'];
    strTip_Fc := SL.Values['strTip_Fc'];
    strOriDoc := SL.Values['strOriDoc'];
    blnReimpressao := StrToBool(SL.Values['blnReimpressao']);
    strNomeArquivo := SL.Values['strNomeArquivo'];
    blnConfirmacao := StrToBool(SL.Values['blnConfirmacao']);
    strSaida := SL.Values['strSaida'];
    intQtdImp := strToInt(SL.Values['intQtdImp']);
    opcComSemPreco := opcComSemPreco.FromString(SL.Values['opcComSemPreco']);
    fltDebCli := StrToFloat(SL.Values['fltDebCli']);
    blnDocSep := StrToBool(SL.Values['blnDocSep']);
    blnTickIF := StrToBool(SL.Values['blnTickIF']);
    blnValTot := StrToBool(SL.Values['blnValTot']);
    blnQtdOri := StrToBool(SL.Values['blnQtdOri']);
    strFila := SL.Values['strFila'];
    strTipImpressao := SL.Values['strTipImpressao'];
    blnDocCancelado := StrToBool(SL.Values['blnDocCancelado']);
    blnImpExpedicao := StrToBool(SL.Values['blnImpExpedicao']);
    blnComprovInd := StrToBool(SL.Values['blnComprovInd']);
    blnSempreEntr := StrToBool(SL.Values['blnSempreEntr']);
    blnRequisicao := StrToBool(SL.Values['blnRequisicao']);
    blnFilaEmpDoc := StrToBool(SL.Values['blnFilaEmpDoc']);
    blnImprPedido := StrToBool(SL.Values['blnImprPedido']);
    opcAbastecimento := opcAbastecimento.FromString(SL.Values['opcAbastecimento']);
    blnImpFil := StrToBool(SL.Values['blnImpFil']);
    blnEnt_CD := StrToBool(SL.Values['blnEnt_CD']);
    blnPenden := StrToBool(SL.Values['blnPenden']);
    blnLocFisEmpEmi := StrToBool(SL.Values['blnLocFisEmpEmi']);
    blnSepFut := StrToBool(SL.Values['blnSepFut']);
    strSepPedEntregaOuRetira := SL.Values['strSepPedEntregaOuRetira'];
    strSetor := SL.Values['strSetor'];
    cdsLogSeparacao := fClientDataSetFromTempFile(SL.Values['cdsLogSeparacao']);
    blnRecCliGar := StrToBool(SL.Values['blnRecCliGar']);
    strOpcDoc := SL.Values['strOpcDoc'];
    strTipNomEmp := SL.Values['strTipNomEmp'];
    strOrdem := SL.Values['strOrdem'];
    blnPreRomaneio := StrToBool(SL.Values['blnPreRomaneio']);
    opcAgrupaPor := opcAgrupaPor.FromString(SL.Values['opcAgrupaPor']);
    blnSomenteNaoImp := StrToBool(SL.Values['blnSomenteNaoImp']);
    strCodLse := SL.Values['strCodLse'];
    strWhereSep := SL.Values['strWhereSep'];
    blnF9OrF10 := StrToBool(SL.Values['blnF9OrF10']);
    blnPerTot := StrToBool(SL.Values['blnPerTot']);
    blnGerPdf := StrToBool(SL.Values['blnGerPdf']);
    strPasPdf := SL.Values['strPasPdf'];
    blnVisPdf := StrToBool(SL.Values['blnVisPdf']);
    blnSoEditor := StrToBool(SL.Values['blnSoEditor']);
    blnPenExp := StrToBool(SL.Values['blnPenExp']);
    blnTicketNF := StrToBool(SL.Values['blnTicketNF']);
    blnSintetizaItensExped := StrToBool(SL.Values['blnSintetizaItensExped']);
    blnEmail := StrToBool(SL.Values['blnEmail']);
    blnVidro := StrToBool(SL.Values['blnVidro']);
    strMensNovo := SL.Values['strMensNovo'];
    strMensExcluido := SL.Values['strMensExcluido'];
    strEmpCabecalho_CD := SL.Values['strEmpCabecalho_CD'];
    blnCabecalhoCD := StrToBool(SL.Values['blnCabecalhoCD']);
    strNumRom := SL.Values['strNumRom'];
    dtaSepFut := StrToDate(SL.Values['dtaSepFut']);
    hraSepFut := StrToTime(SL.Values['hraSepFut']);
    blnTicketDV := StrToBool(SL.Values['blnTicketDV']);
    strCodIct := SL.Values['strCodIct'];
    blnSomenteEmpDifSep := StrToBool(SL.Values['blnSomenteEmpDifSep']);
    blnImpBaixaSeparacao := StrToBool(SL.Values['blnImpBaixaSeparacao']);
    blnImpSepPickingCheckOut := StrToBool(SL.Values['blnImpSepPickingCheckOut']);
    strCodLayFilSep := SL.Values['strCodLayFilSep'];
    blnFatAut := StrToBool(SL.Values['blnFatAut']);
    blnImpressaoColetor := StrToBool(SL.Values['blnImpressaoColetor']);
    blnSepPendRomaneio := StrToBool(SL.Values['blnSepPendRomaneio']);
    blnReimpressaoGR := StrToBool(SL.Values['blnReimpressaoGR']);
    intSeqSepPar := StrToIntDef(SL.Values['intSeqSepPar'], 0);
  finally
    SL.Free;
  end;
end;

function TImprimeFatImpParams.ToTempFile: string;
var
  SL: TStringList;
begin
  Result := TPath.GetTempFileName;
  SL := TStringList.Create;
  try
    SL.Values['strTabela']               := strTabela;
    SL.Values['strNumDoc']               := strNumDoc;
    SL.Values['strEspDoc']               := strEspDoc;
    SL.Values['strCodEmp']               := strCodEmp;
    SL.Values['strCodCli']               := strCodCli;
    SL.Values['strTip_Fc']               := strTip_Fc;
    SL.Values['strOriDoc']               := strOriDoc;
    SL.Values['blnReimpressao']          := VarToString(blnReimpressao);
    SL.Values['strNomeArquivo']          := strNomeArquivo;
    SL.Values['blnConfirmacao']          := VarToString(blnConfirmacao);
    SL.Values['strSaida']                := strSaida;
    SL.Values['intQtdImp']               := IntToStr(intQtdImp);
    SL.Values['opcComSemPreco']          := opcComSemPreco.ToString;
    SL.Values['fltDebCli']               := FloatToStr(fltDebCli);
    SL.Values['blnDocSep']               := VarToString(blnDocSep);
    SL.Values['blnTickIF']               := VarToString(blnTickIF);
    SL.Values['blnValTot']               := VarToString(blnValTot);
    SL.Values['blnQtdOri']               := VarToString(blnQtdOri);
    SL.Values['strFila']                 := strFila;
    SL.Values['strTipImpressao']         := strTipImpressao;
    SL.Values['blnDocCancelado']         := VarToString(blnDocCancelado);
    SL.Values['blnImpExpedicao']         := VarToString(blnImpExpedicao);
    SL.Values['blnComprovInd']           := VarToString(blnComprovInd);
    SL.Values['blnSempreEntr']           := VarToString(blnSempreEntr);
    SL.Values['blnRequisicao']           := VarToString(blnRequisicao);
    SL.Values['blnFilaEmpDoc']           := VarToString(blnFilaEmpDoc);
    SL.Values['blnImprPedido']           := VarToString(blnImprPedido);
    SL.Values['opcAbastecimento']        := opcAbastecimento.ToString;
    SL.Values['blnImpFil']               := VarToString(blnImpFil);
    SL.Values['blnEnt_CD']               := VarToString(blnEnt_CD);
    SL.Values['blnPenden']               := VarToString(blnPenden);
    SL.Values['blnLocFisEmpEmi']         := VarToString(blnLocFisEmpEmi);
    SL.Values['blnSepFut']               := VarToString(blnSepFut);
    SL.Values['strSepPedEntregaOuRetira']:= strSepPedEntregaOuRetira;
    SL.Values['strSetor']                := strSetor;
    SL.Values['cdsLogSeparacao']         := fClientDataSetToTempFile(cdsLogSeparacao);
    SL.Values['blnRecCliGar']            := VarToString(blnRecCliGar);
    SL.Values['strOpcDoc']               := strOpcDoc;
    SL.Values['strTipNomEmp']            := strTipNomEmp;
    SL.Values['strOrdem']                := strOrdem;
    SL.Values['blnPreRomaneio']          := VarToString(blnPreRomaneio);
    SL.Values['opcAgrupaPor']            := opcAgrupaPor.ToString;
    SL.Values['blnSomenteNaoImp']        := VarToString(blnSomenteNaoImp);
    SL.Values['strCodLse']               := strCodLse;
    SL.Values['strWhereSep']             := strWhereSep;
    SL.Values['blnF9OrF10']              := VarToString(blnF9OrF10);
    SL.Values['blnPerTot']               := VarToString(blnPerTot);
    SL.Values['blnGerPdf']               := VarToString(blnGerPdf);
    SL.Values['strPasPdf']               := strPasPdf;
    SL.Values['blnVisPdf']               := VarToString(blnVisPdf);
    SL.Values['blnSoEditor']             := VarToString(blnSoEditor);
    SL.Values['blnPenExp']               := VarToString(blnPenExp);
    SL.Values['blnTicketNF']             := VarToString(blnTicketNF);
    SL.Values['blnSintetizaItensExped']  := VarToString(blnSintetizaItensExped);
    SL.Values['blnEmail']                := VarToString(blnEmail);
    SL.Values['blnVidro']                := VarToString(blnVidro);
    SL.Values['strMensNovo']             := strMensNovo;
    SL.Values['strMensExcluido']         := strMensExcluido;
    SL.Values['strEmpCabecalho_CD']      := strEmpCabecalho_CD;
    SL.Values['blnCabecalhoCD']          := VarToString(blnCabecalhoCD);
    SL.Values['strNumRom']               := strNumRom;
    SL.Values['dtaSepFut']               := DateToStr(dtaSepFut);
    SL.Values['hraSepFut']               := TimeToStr(hraSepFut);
    SL.Values['blnTicketDV']             := VarToString(blnTicketDV);
    SL.Values['strCodIct']               := strCodIct;
    SL.Values['blnSomenteEmpDifSep']     := VarToString(blnSomenteEmpDifSep);
    SL.Values['blnImpBaixaSeparacao']    := VarToString(blnImpBaixaSeparacao);
    SL.Values['blnImpSepPickingCheckOut']:= VarToString(blnImpSepPickingCheckOut);
    SL.Values['strCodLayFilSep']         := strCodLayFilSep;
    SL.Values['blnFatAut']               := VarToString(blnFatAut);
    SL.Values['blnImpressaoColetor']     := VarToString(blnImpressaoColetor);
    SL.Values['blnSepPendRomaneio']      := VarToString(blnSepPendRomaneio);
    SL.Values['blnReimpressaoGR']        := VarToString(blnReimpressaoGR);
    SL.Values['intSeqSepPar']            := VarToString(intSeqSepPar);
    SL.SaveToFile(Result);
  finally
    SL.Free;
  end;
end;

initialization
  TStartFatImpressao.FSemaphore := TCriticalSection.Create;

finalization
  If Assigned(TStartFatImpressao.FSemaphore) Then
    FreeAndNil(TStartFatImpressao.FSemaphore);

end.
