unit untInicializaDllPedido;

interface

Uses
  untFuncoesSimples, Uni, UniClientDataSet, DB, SysUtils, Classes,
  untConstantes, Controls, DateUtils, Math, StrUtils,  
  Windows, Variants, untFuncoesRel, untFuncoesRel2, untFuncoesPedidoSimples,
  untIFuncIns, untILiberacao, untLiberacao, untFatGorFactory, untTypesSistema, untFatRequisicaoCompras,
  untFatGorEmail;

  function fRetVersionSVNPedidoCompra: String; stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pPedidoDeCompraAutCom;
  procedure pManutencaoEmpresasDestinoMultiLojasAutcom;

  procedure pGeraSpoolTransferenciaAutCom;

  procedure pPastaCompraAutCom;

  procedure pImprimePedidoCompraAutCom(strNumPed,
                                       strEspDoc,
                                       strCodEmp: String); stdcall;
  procedure pCarregaDLL(frmModuloPar: TUniConnection; Handle: HWND; intDebugH: Byte); stdCall; External 'libPedidoDeCompra.dll' delayed;

  function funcProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
    blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant;

  function fRetornaProdutosGiroCotacaoAutCom(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;
  function fCarregaCotacaoMultiLojasAutCom(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensGiro: OleVariant): OleVariant;
  Function fSalvaInterfaceCotacaoAutCom(strSeqGer, strNomFrm, strCodEmp: String): Boolean;
  Procedure pSetLiberacaoPedidoCompraAutCom(objLibera : ILiberacao);
  Procedure pLiberaInterfacePedidoCompraAutCom;
  procedure pInicializaDllPedidoDeCompra(ObjFuncIns2: IFuncIns);
  procedure pCarregaDLLPedido;
var
  blnCarregando: Boolean;

implementation

Uses
  untFatGor, untFuncoes, untModulo,  untImpressaoDocs, untFuncIns2, untFuncIns,
  untCadTabelaPrecos, Forms,
  untCadProdutos, untIFatGor;

Var
  blnInicializouDllPedido: Boolean;
  ObjFuncIns: IFuncIns;

  procedure pInicializaDllPedidoCompra(frmModuloPar: TUniConnection;
                                       Handle: HWND; intDebugH: Byte;
                                       funcGravaFatGor: TfGravaFatGor;
                                       funcGravaFatDor: TfGravaFatDor;
                                       procExecutaRelatorio: TExecutaRelatorio;
                                       funcExecutaRelatorioCodigo: TfExecutaRelatorioCodigo;
                                       objIFuncIns : IFuncIns;
                                       procImprimeDocumento: TImprimeDocumento;
                                       procCadProdutos: TAbreCadastroProcedure;
                                       procAbreTelaPrecos: TProcedureAbreTelaPrecos;
                                       objFatGor: IFatGor;
                                       prcCallExibeExterno: TExibeRequisicaoCompra;
                                       funCallGerarEmail: TGerarEmail;
                                       procChamaAtualizaProdReqOS: TProcChamaAtualizaProdReqOrdemServico;
                                       fncDisparaSMSWhatsappPedidoCompra: TfunDisparaSMSWhatsappPedidoCompra); stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pSetObjTraceViewerLibPedidoDeCompra(AViewer: ITraceViewer; ASQLTrace: ISQLTrace); stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pAtualizaVarGlobalPedidoCompra(strCodEmp, strUsuLogado,
    strEmpAceUsuLogado, strEmpEstUsuarioLogadoP, strEmpConsVendFaturP : String;
    blnHabilitarCRM: Boolean; blnUtilizaModoClassico: Boolean;AVS_PermitidoEnviarEmail: Boolean); stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pPedidoDeCompra(CallPedidoCompraAlt: TCallPedidoCompraAlt); stdcall; External 'libPedidoDeCompra.dll' delayed;
  procedure pManutencaoEmpresasDestinoMultiLojas; stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pGeraSpool; stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pPastaCompra; stdcall; External 'libPedidoDeCompra.dll' delayed;

  procedure pImprimePedidoCompra(strNumPed,
                                 strEspDoc,
                                 strCodEmp: String); stdcall; External 'libPedidoDeCompra.dll' delayed;

  function fRetornaProdutosGiroCotacao(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;stdcall; External 'libPedidoDeCompra.dll' delayed;
  function fCarregaCotacaoMultiLojas(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensGiro: OleVariant): OleVariant;stdcall; External 'libPedidoDeCompra.dll' delayed;
  Function fSalvaInterfaceCotacao(strSeqGer, strNomFrm, strCodEmp: String): Boolean; stdcall; External 'libPedidoDeCompra.dll' delayed;

  Procedure pSetLiberacaoPedidoCompra(objLibera : ILiberacao); stdcall; External 'libPedidoDeCompra.dll' delayed;

  Procedure pLiberaInterfacePedidoCompra; stdcall; External 'libPedidoDeCompra.dll' delayed;

  function fProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
    blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant; stdcall; External 'libPedidoDeCompra.dll' delayed;

Procedure pCadProdutos(strCodIte: String);
Begin
  Try
    pCriarFormularios(TfrmCadProdutos, frmCadProdutos);

    frmCadProdutos.strCodIteParaCarregar := strCodIte;
    frmCadProdutos.ShowModal;

  Finally

    pFreeAndNil(frmCadProdutos);
  End;
End;

Procedure pInicializaDllPedidoDeCompra(ObjFuncIns2: IFuncIns);
Begin
  while blnCarregando do
  begin
    Sleep(100);
  End;
  blnCarregando  := True;

  Try
    pSetObjTraceViewerLibPedidoDeCompra(VS_objTraceViewer, VS_Trace);

    pAtualizaVarGlobalPedidoCompra(VS_strCodEmp,
                                   strLoginUsuarioLogado,
                                   strEmpAcessoUsuarioLogado,
                                   strEmpEstUsuarioLogado,
                                   strEmpConsVendFatur,
                                   VS_strHabilitarCRM,
                                   blnUsuarioLogadoUtilizaModoClassico,
                                   VS_PermitidoEnviarEmail);

    If Not blnInicializouDllPedido Then
    Begin
      pInicializaDllPedidoCompra(frmModulo.GetCurrentConnection,
                                 VS_APPLICATION_HANDLE,
                                 DebugHook, fGravaFatGor,
                                 fGravaFatDor,
                                 prcExecutaRelatorio,
                                 fncExecutaRelatorioCodigo,
                                 ObjFuncIns2,
                                 pImprimeDocumento,
                                 pCadProdutos,
                                 TfrmCadTabelaPrecos.pAbreTela,
                                 TFatGorFactory.fGetFatGor,
                                 TfrmFatRequisicaoCompras.pExibeRequisicaoCompra,
                                 TfrmFatGorEmail.fGerarEmail,
                                 procChamaAtualizaProdReqOrdemServico,
                                 funDisparaSMSWhatsappPedidoCompra);

      pSetLiberacaoPedidoCompra(TLiberacao.Create);

      blnInicializouDllPedido := True;
    End;

  Finally
    blnCarregando  := False;
  End;
End;

procedure pCarregaDLLPedido();
begin
  Try
    while blnCarregando do
    begin
      Sleep(100);
    End;
    blnCarregando  := True;

    pCarregaDLL(frmModulo.GetCurrentConnection,  VS_APPLICATION_HANDLE, DebugHook);
  Finally
    blnCarregando  := False;
  End;
End;

procedure pPedidoDeCompraAutCom;
  Var CallPedidoCompraAlt: TCallPedidoCompraAlt;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  pSetObjTraceViewerLibPedidoDeCompra(VS_objTraceViewer, VS_Trace);
  funProdutosGiro := funcProdutosGiro;
  CallPedidoCompraAlt.appHandle := Application.Handle;
  pPedidoDeCompra(CallPedidoCompraAlt);
End;

procedure pManutencaoEmpresasDestinoMultiLojasAutcom;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  pManutencaoEmpresasDestinoMultiLojas;
End;


procedure pGeraSpoolTransferenciaAutCom;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  pGeraSpool;
End;

procedure pPastaCompraAutCom;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  pPastaCompra;
End;


procedure pImprimePedidoCompraAutCom(strNumPed,
                                     strEspDoc,
                                     strCodEmp: String); stdcall;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);

  pImprimePedidoCompra(strNumPed,
                       strEspDoc,
                       strCodEmp);
End;

function fRetornaProdutosGiroCotacaoAutCom(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  Result := fRetornaProdutosGiroCotacao(recOpcoesGiro, oleItensMultiLojas);
End;

function funcProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
  blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  Result := fProdutosGiro(recOpcoesGiro, oleItensMultiLojas, blnCarregandoPedido, blnShow, blnConsulta);
End;


function fCarregaCotacaoMultiLojasAutCom(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensGiro: OleVariant): OleVariant;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  Result := fCarregaCotacaoMultiLojas(recOpcoesGiro, oleItensGiro);
End;

Function fSalvaInterfaceCotacaoAutCom(strSeqGer, strNomFrm, strCodEmp: String): Boolean;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  Result := fSalvaInterfaceCotacao(strSeqGer, strNomFrm, strCodEmp);
End;

Procedure pSetLiberacaoPedidoCompraAutCom(objLibera : ILiberacao);
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  pSetLiberacaoPedidoCompra(objLibera);
End;

Procedure pLiberaInterfacePedidoCompraAutCom;
Begin
  pInicializaDllPedidoDeCompra(ObjFuncIns);
  pLiberaInterfacePedidoCompra;
End;

Initialization
  blnInicializouDllPedido := False;
  blnCarregando := False;
  ObjFuncIns := TObjFuncIns.Create;

Finalization

end.
