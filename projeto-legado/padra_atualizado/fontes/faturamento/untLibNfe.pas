unit untLibNfe;

{
  CÓDIGOS DO STATUS DO LOGNFE:

  CN: NOTA CANCELADA
  GE: GEROU ENVIO. PAINEL IRÁ PROCESSAR O RETORNO
  EE: ERRO NO ENVIO. PAINEL DISPONIBILIZARÁ FUNÇÃO PARA ENVIAR NOTA NOVAMENTE
  GC: GEROU CANCELAMENTO. PAINEL IRÁ PROCESSAR O RETORNO
  EC: ERRO NO CANCELAMENTO. PAINEL DISPONIBILIZARÁ FUNÇÃO PARA ENVIAR CANCELAMENTO
      NOVAMENTE.
  GM: MANIFESTO GERADO
  EM: ERRO NO MANIFESTO
}

interface

uses  Windows, untInterfaces, untConfigNFE, SysUtils, Uni, Controls, Forms,
      Classes, Dialogs, Printers, DateUtils, VirtualUI_SDK, StdCtrls,
      untInterfacesManifestoEletronico, StrUtils, Variants, untInterfacesConhecimentoEletronico;

  procedure pSetaConfiguracoes(objCfgNFE: TConfiguracoesNFE); stdcall; External 'libNfe.dll' delayed;
  function fCriarFonteDadosBD(Database: TUniConnection; strNumDoc, strEspDoc,
           strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall; External 'libNfe.dll' delayed;
  function fCriarFonteDadosEmitenteBD(Database: TUniConnection; strNumDoc, strEspDoc,
           strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall; External 'libNfe.dll' delayed;
  function fCriarNFEService(fonteDados: IFonteDados): INFEService; stdcall; External 'libNfe.dll' delayed;
  function fCriarNFEAdministrativoService(fonteDados: IFonteDados): INFEAdministrativoService; stdcall; External 'libNfe.dll' delayed;
  function fCriarManifestoEletronicoService(fonteDados: IFonteDadosManifesto): IManifestoEletronicoSerivce; stdcall; External 'libNfe.dll' delayed;
  function fCriarFonteDadosManifesto(Database: TUniConnection): IFonteDadosManifesto; stdcall; External 'libNfe.dll' delayed;
  function fCriarConhecimentoEletronicoService(fonteDados: IFonteDadosConhecimento; fonteDadosBD: IFonteDados): IConhecimentoEletronicoService; stdcall; External 'libNfe.dll';
  function fCriarFonteDadosConhecimento(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): IFonteDadosConhecimento; stdcall; External 'libNfe.dll';
  function fSVN_RevisionLibNfe: String; stdcall; External 'libNfe.dll' delayed;
  procedure pSetVirtualUIPrintPDF(AObj: IVirtualUIPrintPDF); stdcall; External 'libNfe.dll' delayed;
  procedure pSetOnNotificarProgresso(AProc: TOnNotificarProgresso); stdcall; External 'libNfe.dll' delayed;
  procedure dxInitializeLibNfe; StdCall; External 'libNfe.dll' delayed;
  procedure dxFinalizeLibNfe; StdCall; External 'libNfe.dll' delayed;
  procedure pSetaPidMD5DicSisLibNfe(const AstrPidMD5DicSis: string); stdcall; external 'libNfe.dll' delayed;
  function fCriarEnviarArquivosServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IEnviarArquivosService; stdcall; External 'libNfe.dll' delayed;

Type
  TImpressaoDiretaCitel = class
  public
    class function fRetNomeNfeImprimirExeCitel: String;
    class function fImpressoraEhParaImprimir(const AstrImpressora: String): Boolean;
    class procedure pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo: String; blnReimpressao: Boolean = False);
    class procedure pImprimirPDF(strCodigoEmpresa,
                                 strImpressora,
                                 strAcesso,
                                 strTipo           : String;
                                 blnReimpressao    : Boolean = False;
                                 strPDF_Diretorio  : String  = '';
                                 blnPDF_Apresentar : Boolean = False;
                                 blnWaitForFinish  : Boolean = False);
  end;

Type
  TImprimirPDFBrowser = class(TInterfacedObject, IVirtualUIPrintPDF)
    public
      procedure PrintPDF(strFileName: String);
  end;

Type
  TProcBeforeSetPontoImpressao = procedure(var APontoImpressao: String) of object;

{***************************************}
{* INTERFACE ENTRE O AUTCOM E A LIBNFE *}
{************************************MV*}
Type
  TLibNfe = class(TObject)
    public
      class var OnBeforeSetPontoImpressao: TProcBeforeSetPontoImpressao;
    private
      FCodEmp: string;
      handle  : Cardinal;
      handleBD: Cardinal;

      FLabelProgresso: TLabel;

      confignfe: TConfiguracoesNFE;

      pSetaConfiguracoesBD: procedure(objCfgNFE: TConfiguracoesNFE); stdcall;
      fCriarFonteDadosBDSet: function(Database: TUniConnection; strNumDoc, strEspDoc,
            strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall;

      function fEnviarNotaInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strPontosImp: String): Boolean;
      function fEnviarCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strMotivo: String; var strErros: String): Boolean;
      function fRetXmlNfeInterna(strCodEmp, strChaveAcesso: string): string;
      function fConfirmacaoOperacaoEntradaMercadoriaInterna(strCodEmp: string; strChaveAcesso: string): string;

      procedure pCarregarDll(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String);

      procedure pCarregaConfigNFE(strCodEmp: String);

      function fEnviarManifestoEletronicoInterna(strNumMan, strNomImp: String): Boolean;
      function fEnviarEncerramentoEletronicoInterna(strNumMan: String): Boolean;
      function fEnviarCancelamentoManifestoEletronicoInterna(strNumMan, strJustificativa: String): Boolean;
      function fEnviarDocsCarregadosInterna(strNumMan, strListaAutoIncrem, strEmpMan: string): Boolean;
      function fEnviarManifestoEventoPagamentoInterna(strNumMan: String): Boolean;
      procedure pImprimirManifestoInterna(manifesto, strImpressora: String);

      function fEnviarCancelamentoConhecimentoEletronicoInterna(strNumCTe, strJustificativa, strNomeUsuario: String): Boolean;
      function fInsucessoNaEntregaConhecimentoEletronicoInterna(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntregaConhecimentoEletronicoInterna(strNumCTe: String): TRetornoNFE;
      function fConfirmacaoDeEntregaConhecimentoEletronicoInterna(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntregaConhecimentoEletronicoInterna(strNumCTe: String): TRetornoNFE;
      //nfe
      function fConfirmacaoDeEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
      function fInsucessoNaEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

      function fProcessarRetornoEnvioInterna(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC, strImpressora: String): Boolean;
      procedure pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strChaveAcessoOffLine: String; retorno: TRetornoNFE);
      procedure pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC, strQRCode, strProtocolo, strObsFisco: String;
        dtaAutorizacao, dtaEmissao: TDateTime; strProtMsg: String = '');
      procedure pAtualizarSubNfs(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String; retorno: TRetornoNFE);

      procedure pGravarLogNfeInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strStsSucesso, strStsFalha: String;
        retorno: TRetornoNFE; strPontoImpressao: String='');
      function fNotaFiscalJaAutorizada(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String): Boolean;

      procedure pAcertaDataHoraEmissao(strNumDoc, strEspDoc, strCodEmp,
        strCodCli, strSerie, strTip_FC: String; dtaEmissao: TDateTime);
      procedure pAtualizarMovObs(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC, strMsgAdicionalCom, strMsgAdicionalFis,
        strStaOffLine, strXmlOffLine: String; dtaDteOffLine: TDateTime);

      procedure pRemovePontoRecuperacaoSAT(strNumDoc, strCodEmp: String);

      procedure pGravarQRCodeCancelamento(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String; retornoNFE: TRetornoNFE);
      procedure pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String; blnEnviar: Boolean; retorno: TRetornoNFe);
      function fCarregarArquivoSAT(blnEnviar: Boolean; strChave, strNSerie: String): String;
      function fRetornaNumeroDocumento(strEspDoc, strCodEmp, strSerie, strAcesso: String): String;

      procedure OnNotificarProgresso(AMsg: String);

    public
      function fEnviarNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String; Var strPontosImp: String): Boolean;
      function fEnviarCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strMotivo: String; var strErros: String): Boolean;
      function fXMLNFE(strCodEmp, strChaveAcesso: string): string;
      function fConfirmacaoOperacaoEntradaMercadoria(strCodEmp: string; strChaveAcesso: string): string;
      function fEnviarCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        intSequencial: Integer): TRetornoCartaCorrecao;
      procedure pReimprimirDanfe(strChaveAcesso, strImpressora, strSerie: String; strImprimirTelaPDF: String = '');
      procedure pReimprimirConhecimentoEletronico(strNumCTe, strImpressora: String);

      procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
        strNumeroFinal, strDescricao, strEspDoc: String);

      class function fRetImpressoraNFCe: String;

      function fEnviarManifestoEletronico(strNumMan, strNomImp: String): Boolean;
      function fEnviarEncerramentoEletronico(strNumMan: String): Boolean;
      function fEnviarCancelamentoManifestoEletronico(strNumMan, strJustificativa: String): Boolean;
      function fEnviarDocsCarregados(strNumMan, strListaAutoIncrem, strEmpMan: string): Boolean;
      function fEnviarManifestoEventoPagamento(strNumMan: String): Boolean;
      procedure pImprimirManifesto(manifesto, strImpressora: String);

      function fEnviarCancelamentoConhecimentoEletronico(strNumCTe, strJustificativa, strNomeUsuario: String): Boolean;

      function fProcessarRetorno(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String; strImpressora: String = ''): Boolean;

      class function fVerificaCancelamentosPendentesPainel(
        strEspecie: String = ''): Boolean;

      class function fDefinirPontoDeImpressao(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli : String) : String;

      function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;

      function fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc,
        strCodEmp, strSerie, strCodCli, strTip_FC: String): String;

      class function fRetPontoImpressao(const strEspDoc: String; const strCodEmp: String): String;

      function fRetornaNomeImpressora(strNomePonto: String): String;

      function fCarregarNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean): String;

      function fConsultaStatusDFe(strChaveAcesso, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
      function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
      function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strCodigoEmpresa, strCodigoCliente, strTipo_FC : String; const strModeloFiscal : String = '55') : String;

      function fEnviaXmlFit(const strArqXML: String): TRetornoNFE;

      function fInsucessoNaEntregaConhecimentoEletronico(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntregaConhecimentoEletronico(strNumCTe: String): TRetornoNFE;
      function fConfirmacaoDeEntregaConhecimentoEletronico(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntregaConhecimentoEletronico(strNumCTe: String): TRetornoNFE;
      //nfe
      function fConfirmacaoDeEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
      function fInsucessoNaEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

      constructor Create(strCodEmp: String; lblProgresso: TLabel = nil);
      destructor Destroy; Override;

  End;

function fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; blnReRaiseException: Boolean; blnEnvio: Boolean=True;
  strImpressora: String = ''; lblProgresso: TLabel = nil): Boolean; overload;

function fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; lblProgresso: TLabel = nil): Boolean; overload;

function fEnviarNFCeLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; strImpressora: String = '';
  lblProgresso: TLabel = nil): Boolean; overload;

function fEnviarCancelamentoLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMotivo: String; var strErros: String): Boolean;

procedure pAtualizaPontoImpressao(const strPonImp, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
procedure pAtualizaNumereroSerieVaziaSatIntegrador(const strNumSer: String);

function fXMLNFELibNfe(strCodEmp, strChaveAcesso: string): string;
function fLibConfirmacaoOperacaoEntradaMercadoria(strCodEmp: string; strChaveAcesso: string): string;

procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strStatus, strObserv: String;
  strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='';
  intViaNfe: Integer = -1);

function fSeErroRetornaStatusEnviarParaPainel(strExcept, strEspDoc: String): String;

procedure pGravarArmFat(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC, strSerie_ : String);

function fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): String;

procedure pInutilizarNumeros(strNumDoc, strSerie, strDescri, strEspDoc: String);
procedure pDeletaLogNfe(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie,
  strTip_FC: String);

function fPainelEstaAberto: Boolean;

function fEnviarManifestoEletronico(strNumMan, strNomImp: String): Boolean;
function fEnviarEncerramentoManifesto(strNumMan, strEmpMan: String): Boolean;
function fEnviarCancelamentoManifesto(strNumMan, strJustificativa: String): Boolean;
function fEnviarDocsCarregados(strNumMan, strListaAutoIncrem, strEmpMan: string): Boolean;
function fEnviarManifestoEventoPagamento(strNumMan: String): Boolean;
procedure pImprimirManifesto(manifesto, strCodEmp, strImpressora: String);

function fEnviarCancelamentoConhecimento(strNumCTe, strJustificativa, strNomeUsuario: String): Boolean;

procedure pCarregaNFCePendente(qryNFCe: TUniQuery; intTempoEmSegundosPendente: Integer = -1; strLisAutInc: String='');
function fNFCePendente(strNumDoc, strCodEmp, strCodCli, strTabela: String): Boolean;
function fReenviarLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strTipInt, strNumSer, strMotCan, strImpres: String): Boolean;
function fGravarLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strTipInt, strNumSer, strMotCan, strImpres: String): Boolean;
function fJaCancelouLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strNumSer: String): Boolean;
function fVoltaStatusAnterior(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strTipInt, strNumSer: String): Boolean;
function fSATCancelado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strNumSer: String): Boolean;

function fConsultaStatusDFe(strChaveAcesso, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strCodigoEmpresa, strCodigoCliente, strTipo_FC : String; const strModeloFiscal : String = '55'): String;
function fTemDocumentosPendentesDeAutorizacao(const strCodEmp : String) : Boolean;
function fDataEmissaoDocumentoFiscal(const strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc : String) : TDate;
function fEnviaXmlFit(const strArqXML: String): TRetornoNFE;
function fInsucessoNaEntregaConhecimento(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
function fCancelamentoInsucessoNaEntregaConhecimento(strNumCTe: String; var strMensagem: String): Boolean;
function fConfirmacaoDeEntregaConhecimento(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
function fCancelamentoConfirmacaoDeEntregaConhecimento(strNumCTe: String; var strMensagem: String): Boolean;
//nfe
function fConfirmacaoDeEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
function fCancelamentoConfirmacaoDeEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie: String; var strMensagem: String): Boolean;
function fInsucessoNaEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
function fCancelamentoInsucessoNaEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie: String; var strMensagem: String): Boolean;

function fCarregarViaNfeGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Integer;

const strMensagem = 'Funcionalidade não suportada para o emissor atual de NFe. Favor realizar a operação no site.';

implementation

uses   untFuncoesSimples, untFuncoesGenerica, untModulo, untImpressaoDiretaCitel,
       untConstantes, untPontosImpressao, Data.DB, untQckFatImpNFCe,
       untTypesSistema, untConstantesNFe, untCfgRel, untDicSis;

{**************************************}
{* FUNÇÃO AUXILIAR PARA ENVIAR A NOTA *}
{***********************************MV*}
function fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; blnReRaiseException: Boolean; blnEnvio: Boolean=True;
  strImpressora: String = ''; lblProgresso: TLabel = nil): Boolean;
  Var
    libnfe: TLibNfe;
    strPontosImp: String;
    strStatusAux: String;
    strMensagem_: String;

    function fTrataSoap(const strMsg: String): String;
      Var
        intPos: Integer;
    begin
      intPOs := Pos(#13, strMsg);
      If intPos <= 0 Then
        intPOs := Length(strMsg);
        
      Result := Copy(strMsg, 1, intPos);
    end;

begin
  Try
    libnfe := TLibNfe.Create(strCodEmp, lblProgresso);
    If blnEnvio Then
    Begin
      Result := libnfe.fEnviarNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC,strPontosImp);
    End
    Else
    Begin
      Result := libnfe.fProcessarRetorno(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strImpressora);
    End;
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      If blnReRaiseException Then
        Raise;

      Result := False;
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, IIF(E.NFCeOffLine, 'OF', 'EE'), E.Message, '', 0, strPontosImp);
      pMensagemOk(fTrataSoap(E.Message));
    End;

    On E: ExceptionAutcom Do
    Begin
      If blnReRaiseException Then
        Raise;

      strStatusAux := fSeErroRetornaStatusEnviarParaPainel(E.Message, strEspDoc);
      strMensagem_ := IIF(IfEmptyStr(strStatusAux, 'EE') = 'EE', E.Message, 'Enviado direto para o Painel');

      Result := False;
      If Pos('Off-Line',E.Message) = 0 Then
        pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, IfEmptyStr(strStatusAux, 'EE'), strMensagem_, '', 0, strPontosImp);

      If fEmptyStr(strStatusAux) Then
        pMensagemSonora(fTrataSoap(E.Message));
    End;

    On E: Exception Do
    Begin
      If blnReRaiseException Then
        Raise;

      Result := False;
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'EE', E.Message, '', 0, strPontosImp);

      {************************************************************************}
      {* TRUQUE PARA PODER MUDAR A MENSAGEM QUE SERÁ MOSTRADA PARA O USUÁRIO. *}
      {*********************************************************************MV*}
      Try
        Raise Exception.Create(fTrataSoap(E.Message));
      Except
        On Ex: Exception Do
        Begin
          pMensagensErro(fTrataSoap(E.Message), '[fEnviarNotaLibNfe]');
        End;
      End;
    End;
  End;

  If Assigned(libnfe) Then
    FreeAndNil(libnfe);
end;

function fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; lblProgresso: TLabel = nil): Boolean;
begin
  Result := fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC, False, True, '', lblProgresso);
end;

function fEnviarNFCeLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; strImpressora: String = '';
  lblProgresso: TLabel = nil): Boolean; overload;
begin
  Result := fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC, False, False, strImpressora, lblProgresso);
end;

function fXMLNFELibNfe(strCodEmp, strChaveAcesso: string): string;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(strCodEmp);
  Try
     Result := libnfe.fXMLNFE(strCodEmp, strChaveAcesso);
  Finally
    FreeAndNil(libnfe);
  End;
End;

function fLibConfirmacaoOperacaoEntradaMercadoria(strCodEmp: string; strChaveAcesso: string): string;
  Var
    libnfe: TLibNfe;
begin
  Result := '';
  libnfe := TLibNfe.Create(strCodEmp);
  Try
     Result := libnfe.fConfirmacaoOperacaoEntradaMercadoria(strCodEmp, strChaveAcesso);
  Finally
    FreeAndNil(libnfe);
  End;
end;

{**************************************}
{* FUNÇÃO AUXILIAR PARA CANCELAR A    *}
{* NOTA.                              *}
{***********************************MV*}
function fEnviarCancelamentoLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMotivo: String; var strErros: String): Boolean;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(strCodEmp);
  Try
    Result := libnfe.fEnviarCancelamento(strNumDoc, strEspDoc, strCodEmp,
      strSerie, strCodCli, strTip_FC, strMotivo, strErros);
  Except
    On E: Exception Do
    Begin
      Result := False;
      strErros := E.Message;

      If not (pos(strEspDoc, 'NF_NS_') > 0) Then
        pMensagensErro(E.Message, '[fEnviarCancelamentoLibNfe]');
    End;
  End;
  FreeAndNil(libnfe);
end;

procedure pAtualizaPontoImpressao(const strPonImp, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
  Var
    qryAux : TUniQuery;
begin
  If Not fCampoExiste('LOGNFE', 'NFE_PONIMP', True) Then
    Exit;

  If fEmptyStr(strPonImp) Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' UPDATE LOGNFE ');
    qryAux.SQL.Add('    SET NFE_PONIMP = :PONIMP ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND IFNULL(NFE_SERIE_,"") = :SERIE_ ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('PONIMP').AsString := strPonImp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pAtualizaNumereroSerieVaziaSatIntegrador(const strNumSer: String);
Var
  LqryAux : TUniQuery;
begin
  If fCfgSis('USNFCE', varBoolean) Then
    Exit;

  If not fUsaSat Then
    Exit;

  If not fUsaIntegradorSatCitel Then
    Exit;

  If fEmptyStr(strNumSer) Then
    Exit;

  LqryAux := fCriaQuery(Nil);
  Try
    LqryAux.SQL.Add(' UPDATE LOGSAT ');
    LqryAux.SQL.Add('     SET NFE_NUMSER = :NUMSER ');
    LqryAux.SQL.Add('   WHERE NFE_STATUS = "GE" ');
    LqryAux.SQL.Add('         AND TRIM(IFNULL(NFE_NUMSER, "")) = "" ');
    LqryAux.ParamByName('NUMSER').AsString := strNumSer;
    LqryAux.ExecSQL;
  Finally
    FreeAndNil(LqryAux);
  End;
end ;


function fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): String;
  Var
    qryAux: TUniQuery;
begin
  Result := '';
  If Not fCampoExiste('LOGNFE', 'NFE_PONIMP', True) Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT NFE_PONIMP FROM LOGNFE WHERE ');
  qryAux.SQL.Add('NFE_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('NFE_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('NFE_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('NFE_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('IFNULL(NFE_SERIE_,"") = :SERIE_ AND ');
  qryAux.SQL.Add('NFE_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.Open;

  Result := qryAux.FieldByName('NFE_PONIMP').AsString;

  FreeAndNil(qryAux);
end;

{**************************************}
{* FUNÇÃO AUXILIAR PARA GRAVAR LOG.   *}
{***********************************MV*}
procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strStatus, strObserv: String;
  strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='';
  intViaNfe: Integer = -1);
  Var
    qryAux: TUniQuery;
    intCont: Integer;
    dtaDtaEmi : TDate;
begin

  intCont := 0;
  While True Do
  Begin

    Try
      qryAux := fCriaQuery(Nil);
      Break;
    Except
      Sleep(200);
      Inc(intCont);
    End;

    If intCont > 5 Then
    Begin
      Raise Exception.Create('Não foi possível gravar a NFE, favor entrar em contato com a Citel imediatamente!!');
    End;

  End;

  qryAux.SQL.Add('REPLACE INTO LOGNFE (');
  qryAux.SQL.Add('  NFE_NUMDOC, ');
  qryAux.SQL.Add('  NFE_ESPDOC, ');
  qryAux.SQL.Add('  NFE_CODEMP, ');
  qryAux.SQL.Add('  NFE_CODCLI, ');
  qryAux.SQL.Add('  NFE_SERIE_, ');
  qryAux.SQL.Add('  NFE_TIP_FC, ');
  qryAux.SQL.Add('  NFE_STATUS, ');
  qryAux.SQL.Add('  NFE_PNDPEC, ');
  qryAux.SQL.Add('  NFE_OBSERV, ');
  qryAux.SQL.Add('  NFE_PONIMP, ');
  qryAux.SQL.Add('  NFE_DTAEMI, ');

  If Not fEmptyStr(strChaAce) Then
    qryAux.SQL.Add('  NFE_ACESSO, ');

  If dtaDtaAut <> 0 Then
    qryAux.SQL.Add('  NFE_DTAAUT, ');

  If intViaNfe >= 0 Then
    qryAux.SQL.Add('  NFE_VIANFE, ');

  qryAux.SQL.Add('  NFE_HORINI) ');
  qryAux.SQL.Add('VALUES ( ');
  qryAux.SQL.Add('  :NUMDOC, ');
  qryAux.SQL.Add('  :ESPDOC, ');
  qryAux.SQL.Add('  :CODEMP, ');
  qryAux.SQL.Add('  :CODCLI, ');
  qryAux.SQL.Add('  :SERIE_, ');
  qryAux.SQL.Add('  :TIP_FC, ');
  qryAux.SQL.Add('  :STATUS, ');
  qryAux.SQL.Add('  :PNDPEC, ');
  qryAux.SQL.Add('  :OBSERV, ');
  qryAux.SQL.Add('  :PONIMP, ');
  qryAux.SQL.Add('  :DTAEMI, ');

  If Not fEmptyStr(strChaAce) Then
    qryAux.SQL.Add('  :ACESSO, ');

  If dtaDtaAut <> 0 Then
    qryAux.SQL.Add('  :DTAAUT, ');

  If intViaNfe >= 0 Then
    qryAux.SQL.Add('  :VIANFE, ');

  qryAux.SQL.Add('  '+fCurrentDateTime+' ) ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ParamByName('STATUS').AsString := strStatus;
  qryAux.ParamByName('PNDPEC').AsString := IIF(strStatus = 'OF', '1', '0');

  If Not fEmptyStr(strPonImp) Then
    qryAux.ParamByName('PONIMP').AsString := strPonImp
  Else
    qryAux.ParamByName('PONIMP').AsString := fCarregarPontoImpressaoGravado(strNumDoc,
      strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  If Not fEmptyStr(strChaAce) Then
    qryAux.ParamByName('ACESSO').AsString := strChaAce;

  If dtaDtaAut <> 0 Then
    qryAux.ParamByName('DTAAUT').AsDateTime := dtaDtaAut;

  If intViaNfe >= 0 Then
    qryAux.ParamByName('VIANFE').AsInteger := intViaNfe;

  qryAux.ParamByName('OBSERV').AsString := strObserv;

  dtaDtaEmi := fDataEmissaoDocumentoFiscal(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC);

  If (dtaDtaEmi = 0) Then
    qryAux.ParamByName('DTAEMI').Value := Null
  Else
    qryAux.ParamByName('DTAEMI').AsDate := dtaDtaEmi;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

function fSeErroRetornaStatusEnviarParaPainel(strExcept, strEspDoc: String): String;

   function fEhErroTratavel: Boolean;
   begin
     Result := False;

     //REPRODUZIR CONDIÇÃO QUE RESULTARÁ TRUE NA FUNÇÃO DE MESMO NOME DENTRO DA LIBNFE.DLL
     If (Pos('falha na', strExcept) > 0) Then
     Begin
       Result := (Pos('libeay32.dll', strExcept) > 0) Or
                 (Pos('ssl library', strExcept) > 0) Or
                 (Pos('http/1.1 502 bad gateway', strExcept) > 0) Or
                 (Pos('http/1.1 504 gateway time-out', strExcept) > 0) Or
                 (Pos('connect timed out', strExcept) > 0) Or
                 (Pos('connection timed out', strExcept) > 0);

       If Result Then
         pLogImp('Erro no primeiro reenvio: ['+strExcept+'] > Não mostrou exceção e mandou direto para o Painel');
     End;
   end;

begin
  Result := '';
  strExcept := AnsiLowerCase(strExcept);
  If fCfgSis('PNLNFE', varBoolean) Then
  Begin
    If (Pos(strEspDoc, 'IF_NF_') > 0) Then
    Begin
      If (fEhErroTratavel) Then
      Begin
        Result := 'AE';
      End;
    End;
  End;
end;

procedure pGravarArmFat(strNumDoc, strEspDoc, strCodEmp, strForCli, strTip_FC, strSerie_ : String);
Var
  qryAux : TUniQuery;
begin

  If Not fCfgSis('UTIFTP', varBoolean, VS_strCodEmp) Then
    Exit;

  If Not fTabelaExiste('ARMFAT', True) Then
    Exit;

  qryAux := fCriaQuery(Nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM ARMFAT WHERE FALSE');
    qryAux.Open;

    qryAux.Insert;
    qryAux.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('ARMFAT', VS_strCodEmp);
    qryAux.FieldByName('ARM_NUMDOC').AsString   := strNumDoc;
    qryAux.FieldByName('ARM_ESPDOC').AsString   := strEspDoc;
    qryAux.FieldByName('ARM_CODEMP').AsString   := strCodEmp;
    qryAux.FieldByName('ARM_FORCLI').AsString   := strForCli;
    qryAux.FieldByName('ARM_TIP_FC').AsString   := strTip_FC;
    qryAux.FieldByName('ARM_SERIE_').AsString   := strSerie_;
    qryAux.FieldByName('ARM_DTAGRA').AsDateTime := fRetDtaHraServidor;
    qryAux.Post;

  Finally
    FreeAndNil(qryAux);
  End;

end;

{ TImpressaoDiretaCitel }

class function TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel: String;
begin
  Result := untImpressaoDiretaCitel.TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel;
end;

class function TImpressaoDiretaCitel.fImpressoraEhParaImprimir(const AstrImpressora: String): Boolean;
begin
  Result := untImpressaoDiretaCitel.TImpressaoDiretaCitel.fImpressoraEhParaImprimir(AstrImpressora);
end;

class procedure TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo: String; blnReimpressao: Boolean = False);
begin
  untImpressaoDiretaCitel.TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa, strImpressora, strAcesso, strTipo, blnReimpressao, VS_PidMD5DicSis);
end;

class procedure TImpressaoDiretaCitel.pImprimirPDF(strCodigoEmpresa,
                                                  strImpressora,
                                                  strAcesso,
                                                  strTipo           : String;
                                                  blnReimpressao    : Boolean = False;
                                                  strPDF_Diretorio  : String  = '';
                                                  blnPDF_Apresentar : Boolean = False;
                                                  blnWaitForFinish  : Boolean = False);
begin
  untImpressaoDiretaCitel.TImpressaoDiretaCitel.pImprimirPDF(strCodigoEmpresa,
                                                             strImpressora,
                                                             strAcesso,
                                                             strTipo,
                                                             blnReimpressao,
                                                             strPDF_Diretorio,
                                                             blnPDF_Apresentar,
                                                             VS_PidMD5DicSis,
                                                             EmptyStr,
                                                             EmptyStr,
                                                             blnWaitForFinish);
end;

{ TImprimirPDFBrowser }

procedure TImprimirPDFBrowser.PrintPDF(strFileName: String);
begin
  inherited;
  If VirtualUI.Active Then
    VirtualUI.PrintPdf(strFileName);
end;

{ TLibNfe }

procedure TLibNfe.OnNotificarProgresso(AMsg: String);
begin
  if assigned(FLabelProgresso) then
  begin
    FLabelProgresso.Caption := AMsg;
    Application.ProcessMessages;
  end;
end;

constructor TLibNfe.Create(strCodEmp: String; lblProgresso: TLabel = nil);
begin
  inherited Create;
  handle   := 0;
  handleBD := 0;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  pCarregaConfigNFE(strCodEmp);

  pSetVirtualUIPrintPDF(TImprimirPDFBrowser.Create);
  pSetOnNotificarProgresso(OnNotificarProgresso);

  FCodEmp := strCodEmp;

  FLabelProgresso := lblProgresso;
end;

destructor TLibNfe.Destroy;
begin
  pSetOnNotificarProgresso(nil);

  If handle <> 0 Then
    FreeLibrary(handle);

  If handleBD <> 0 Then
    FreeLibrary(handleBD);

  FreeAndNil(confignfe);    

  inherited;
end;

function TLibNfe.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
var
  fonte: IFonteDados;
  service: INFEAdministrativoService;
begin
  pSetaConfiguracoes(confignfe);
  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', '', '', '', '');
  service := fCriarNFEAdministrativoService(fonte);
  Result := service.fConsultaCadastro(strUf, strCnpj, strIe);
end;

function TLibNfe.fXmlNfe(strCodEmp, strChaveAcesso: string): string;
Begin
  pCarregarDll('', '', '', '', '', '');
  Result := fRetXmlNfeInterna(strCodEmp, strChaveAcesso);
End;

function TLibNfe.fConfirmacaoOperacaoEntradaMercadoria(strCodEmp: string; strChaveAcesso: string): string;
begin
  Result := '';
  pCarregarDll('', '', '', '', '', '');
  Result := fConfirmacaoOperacaoEntradaMercadoriaInterna(strCodEmp, strChaveAcesso);
end;


{**************************************}
{* ENVIA O CANCELAMENTO               *}
{***********************************MV*}
function TLibNfe.fEnviarCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMotivo: String; var strErros: String): Boolean;
var
  intTentativas: Integer;

  function fTentaNovamente: Boolean;
  begin
    Result := True;

    If (Pos('socket error', LowerCase(strErros)) > 0) Then
      Exit;

    If (Pos('timed out', LowerCase(strErros)) > 0) Then
      Exit;

    Result := False;
  end;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  For intTentativas := 1 To 3 Do
  Begin
    Result := fEnviarCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp,
      strSerie, strCodCli, strTip_FC, strMotivo, strErros);

    If not fTentaNovamente Then
      Break;
  End;

end;

function TLibNfe.fEnviarCancelamentoConhecimentoEletronico(strNumCTe, strJustificativa, strNomeUsuario: String): Boolean;
begin
  Result := fEnviarCancelamentoConhecimentoEletronicoInterna(strNumCTe, strJustificativa, strNomeUsuario);
end;

function TLibNfe.fEnviarCancelamentoConhecimentoEletronicoInterna(strNumCTe, strJustificativa, strNomeUsuario: String): Boolean;
var
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosConhecimento(frmModulo.GetCurrentConnection);

  pCarregarDll('', '', '', '', '', '');
  fonteBD := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumCTe, 'CT', VS_strCodEmp, '', '', '');

  service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

  Result := service.fCancelarConhecimento(strNumCTe, strJustificativa, strNomeUsuario);
end;

function TLibNfe.fInsucessoNaEntregaConhecimentoEletronico(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := fInsucessoNaEntregaConhecimentoEletronicoInterna(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData);
end;

function TLibNfe.fInsucessoNaEntregaConhecimentoEletronicoInterna(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
var
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosConhecimento(frmModulo.GetCurrentConnection);

  pCarregarDll('', '', '', '', '', '');
  fonteBD := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumCTe, 'CT', VS_strCodEmp, '', '', '');

  service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

  Result := service.fInsucessoNaEntrega(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData);
end;

function TLibNfe.fCancelamentoInsucessoNaEntregaConhecimentoEletronico(strNumCTe: String): TRetornoNFE;
begin
  Result := fCancelamentoInsucessoNaEntregaConhecimentoEletronicoInterna(strNumCTe);
end;

function TLibNfe.fCancelamentoInsucessoNaEntregaConhecimentoEletronicoInterna(strNumCTe: String): TRetornoNFE;
var
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosConhecimento(frmModulo.GetCurrentConnection);

  pCarregarDll('', '', '', '', '', '');
  fonteBD := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumCTe, 'CT', VS_strCodEmp, '', '', '');

  service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

  Result := service.fCancelamentoInsucessoNaEntrega(strNumCTe);
end;

function TLibNfe.fConfirmacaoDeEntregaConhecimentoEletronico(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := fConfirmacaoDeEntregaConhecimentoEletronicoInterna(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData);
end;

function TLibNfe.fConfirmacaoDeEntregaConhecimentoEletronicoInterna(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
var
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosConhecimento(frmModulo.GetCurrentConnection);

  pCarregarDll('', '', '', '', '', '');
  fonteBD := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumCTe, 'CT', VS_strCodEmp, '', '', '');

  service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

  Result := service.fConfirmacaoDeEntrega(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData);
end;

function TLibNfe.fCancelamentoConfirmacaoDeEntregaConhecimentoEletronico(strNumCTe: String): TRetornoNFE;
begin
  Result := fCancelamentoConfirmacaoDeEntregaConhecimentoEletronicoInterna(strNumCTe);
end;

function TLibNfe.fCancelamentoConfirmacaoDeEntregaConhecimentoEletronicoInterna(strNumCTe: String): TRetornoNFE;
var
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosConhecimento(frmModulo.GetCurrentConnection);

  pCarregarDll('', '', '', '', '', '');
  fonteBD := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumCTe, 'CT', VS_strCodEmp, '', '', '');

  service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

  Result := service.fCancelamentoConfirmacaoDeEntrega(strNumCTe);
end;

function TLibNfe.fConfirmacaoDeEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := fConfirmacaoDeEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData);
end;

function TLibNfe.fConfirmacaoDeEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
Var
  intContador: Integer;
  strErros: String;
  fonte: IFonteDados;
  NFE: INFEService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', strCodEmp, '', '', '');

  NFE := fCriarNFEService(fonte);

  Try
    Result := NFE.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;
      Raise Exception.Create('Erro confirmação de entrega: ' + strErros);
    End;
  End;
end;

function TLibNfe.fCancelamentoConfirmacaoDeEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := fCancelamentoConfirmacaoDeEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie);
end;

function TLibNfe.fCancelamentoConfirmacaoDeEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
Var
  intContador: Integer;
  strErros: String;
  fonte: IFonteDados;
  NFE: INFEService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', strCodEmp, '', '', '');

  NFE := fCriarNFEService(fonte);

  Try
    Result := NFE.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;
      Raise Exception.Create('Erro cancelamento de confirmação de entrega: ' + strErros);
    End;
  End;
end;

function TLibNfe.fInsucessoNaEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := fInsucessoNaEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData);
end;

function TLibNfe.fInsucessoNaEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
Var
  intContador: Integer;
  strErros: String;
  fonte: IFonteDados;
  NFE: INFEService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', strCodEmp, '', '', '');

  NFE := fCriarNFEService(fonte);

  Try
    Result := NFE.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;
      Raise Exception.Create('Erro insucesso na entrega: ' + strErros);
    End;
  End;
end;

function TLibNfe.fCancelamentoInsucessoNaEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := fCancelamentoInsucessoNaEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie);
end;

function TLibNfe.fCancelamentoInsucessoNaEntregaNFeEletronicoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
Var
  intContador: Integer;
  strErros: String;
  fonte: IFonteDados;
  NFE: INFEService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', strCodEmp, '', '', '');

  NFE := fCriarNFEService(fonte);

  Try
    Result := NFE.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;
      Raise Exception.Create('Erro cancelamento de insucesso na entrega: ' + strErros);
    End;
  End;
end;

function TLibNfe.fEnviarCancelamentoManifestoEletronico(strNumMan, strJustificativa: String): Boolean;
begin
  Result := fEnviarCancelamentoManifestoEletronicoInterna(strNumMan, strJustificativa);
end;

function TLibNfe.fEnviarCancelamentoManifestoEletronicoInterna(
  strNumMan, strJustificativa: String): Boolean;
  Var
    fonte: IFonteDadosManifesto;
    service: IManifestoEletronicoSerivce;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosManifesto(frmModulo.GetCurrentConnection);
  service := fCriarManifestoEletronicoService(fonte);

  Result := service.fCancelarManifesto(strNumMan, strJustificativa);
end;

function TLibNfe.fEnviarDocsCarregados(strNumMan, strListaAutoIncrem, strEmpMan: string): Boolean;
begin
  Result := fEnviarDocsCarregadosInterna(strNumMan, strListaAutoIncrem, strEmpMan);
end;

function TLibNfe.fEnviarDocsCarregadosInterna(strNumMan, strListaAutoIncrem, strEmpMan: string): Boolean;
  Var
    fonte: IFonteDadosManifesto;
    service: IManifestoEletronicoSerivce;
    strErros: String;
    intContador: Integer;
begin
  Try
    If fEmptyStr(strEmpMan) Then
      strEmpMan := VS_strCodEmp;

    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonte := fCriarFonteDadosManifesto(frmModulo.GetCurrentConnection);
    service := fCriarManifestoEletronicoService(fonte);

    Result := service.fEnviarDocsCarregadosManifesto(strNumMan, strListaAutoIncrem);

    pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', 'GM', '', '', 0, '');

  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      If E.ResultadoValidacao <> Nil Then
      Begin
        For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
        Begin
          strErros := strErros + E.ResultadoValidacao.strErros[intContador];
          If intContador < E.ResultadoValidacao.intCount -1 Then
            strErros := strErros + #13#10;
        End;
      End
      Else
      Begin
        strErros := E.Message;
      End;
      pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', 'EM', strErros);
      Raise ExceptionAutCom.Create('Erro ao enviar documento: ' + strErros);
    End;

    On E: Exception Do
    Begin
      pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', 'EM', E.Message);
    	Raise Exception.Create('Erro ao enviar documento: ' + E.MEssage);
    End;
  End;
end;

function TLibNfe.fRetXmlNfeInterna(strCodEmp, strChaveAcesso: string): string;
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    NFE: INFEService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', strCodEmp, '', '', '');

  NFE := fCriarNFEService(fonte);

  Try
    Result := NFE.fRetXmlNfe(strChaveAcesso);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;
      Raise Exception.Create('Erro ao solictar Xml da Nota: ' + strErros);
    End;
  End;
End;


function TLibNfe.fConfirmacaoOperacaoEntradaMercadoriaInterna(strCodEmp: string; strChaveAcesso: string): string;
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    NFE: INFEService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', strCodEmp, '', '', '');

  NFE := fCriarNFEService(fonte);

  Try
    Result := NFE.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;
      Raise Exception.Create('Erro ao solictar Confirmação de Operação: ' + strErros);
    End;
  End;
End;


{**************************************}
{* CANCELAMENTO (FUNÇÃO INTERNA).     *}
{***********************************MV*}
function TLibNfe.fEnviarCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strMotivo: String; var strErros: String): Boolean;
  Var
    intContador: Integer;
    fonte: IFonteDados;
    service: INFEService;
    retornoNFE: TRetornoNFE;
    dtaHoraInicio: TDateTime;
begin
  strErros := '';

  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  If strEspDoc = 'IF' Then
  Begin
    fonte := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc,
      strCodEmp, strCodCli, strSerie, strTip_FC);
  End
  Else
  Begin
    fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc,
      strCodEmp, strCodCli, strSerie, strTip_FC);
  End;
  
  service := fCriarNFEService(fonte);

  {**************************************}
  {* ENVIA SOLICITAÇÃO DE CANCELAMENTO. *}
  {***********************************MV*}
  Try
    Result := service.fCancelarNota(strNumDoc, strSerie, strMotivo);

    If Result Then
    Begin
      dtaHoraInicio := fNow();
      Sleep(1500);
      Repeat
        retornoNFE := service.fProcessarCancelamento;
        Application.ProcessMessages;

        If SecondsBetween(fNow, dtaHoraInicio) > 120 Then
        Begin
          Raise Exception.Create('Time-out no cancelamento. Por favor, tente novamente em alguns instantes.' + #13#10 +
            'Verifique no site, no status desta nota, se a mesma está em DPEC. Caso estiver, aguarde a autorização definitiva ' +
            'para enviar o cancelamento.');
        End;
      Until (Not retornoNFE.Aguardando);

      Result := retornoNFE.Sucesso;

      If retornoNFE.Sucesso Then
      Begin
        pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'CN',
          retornoNFE.Mensagem, retornoNFE.ChaveAcesso, retornoNFE.DataAutorizacao);

        pGravarQRCodeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC,
          retornoNFE);

        pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC,
          False, retornoNFE);
      End
      Else
      Begin
        If (strEspDoc = 'NS') And (Pos('cancelamentonegado', LowerCase(retornoNFE.Mensagem)) > 0) Then
        Begin
          Result := False;
          strErros := retornoNFE.Mensagem;
          Exit;
        End;

        If (strEspDoc = 'NF') Then
        Begin
          Result := False;
          strErros := retornoNFE.Mensagem;

          If (Pos('nf-e com ct-e ou mdf-e', LowerCase(retornoNFE.Mensagem)) > 0) Then
            strErros := 'NFe com CTe ou MDFe vinculado !' + #13 + 'Cancele o CTe ou MDFe antes de cancelar a NFe.';

          Exit;
        End;

        Raise ExceptionAutCom.Create('Não foi possível cancelar a nota: ' + retornoNFE.Mensagem);
      End;
    End
    Else
      Raise Exception.Create('Não foi possível cancelar a nota.');
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;

      If (strEspDoc = 'NS') And (Pos('cancelamentonegado', LowerCase(strErros)) > 0) Then
      Begin
        Result := False;
        Exit;
      End;

      If (strEspDoc = 'NF') Then
      Begin
        If (Pos('nf-e com ct-e ou mdf-e', LowerCase(strErros)) > 0) Then
          strErros := 'NFe com CTe ou MDFe vinculado !' + #13 + 'Cancele o CTe ou MDFe antes de cancelar a NFe.';

        Result := False;
        Exit;
      End;

      Raise ExceptionAutCom.Create('Erro ao enviar cancelamento: ' + strErros);
    End;
  End;

end;

function TLibNfe.fEnviarEncerramentoEletronico(strNumMan: String): Boolean;
begin
  Result := fEnviarEncerramentoEletronicoInterna(strNumMan);
end;

function TLibNfe.fEnviarEncerramentoEletronicoInterna(
  strNumMan: String): Boolean;
  Var
    fonte: IFonteDadosManifesto;
    service: IManifestoEletronicoSerivce;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosManifesto(frmModulo.GetCurrentConnection);
  service := fCriarManifestoEletronicoService(fonte);

  Result := service.fEncerrarManifesto(strNumMan);
end;

function TLibNfe.fEnviarCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; intSequencial: Integer): TRetornoCartaCorrecao;
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    service: INFEAdministrativoService;
    strImpressora: String;
begin
  strImpressora := '';

  If TCfgRel.fExecutePrintDialog(strImpressora) Then
  Begin
    If fEmptyStr(strImpressora) Then
      strImpressora := TCfgRel.fGetImpressoraSelecionada;
  End;

  If fEmptyStr(strImpressora) Then
    Raise ExceptionAutCom.Create('É necessário selecionar uma impressora.');

  Try
    pSetaConfiguracoes(confignfe);
    fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', '', '', '', '');
    service := fCriarNFEAdministrativoService(fonte);

    fonte.pCarregarDados;

    If service.fSuportaFuncoesAdministrativas Then
      Result := service.fEnviaCartaCorrecao(strChaveAcesso, stlCorrecoes, strImpressora, intSequencial)
    Else
      Raise Exception.Create(strMensagem);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;

      Raise Exception.Create('Erro ao enviar carta de correção: ' + strErros);
    End;

    On E: ExceptionNFePrinter Do
    Begin
      Raise ExceptionNFePrinter.Create('Erro ao imprimir a carta de correção: ' + E.Message);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao enviar carta de correção: ' + E.MEssage);
    End;
  End;

end;

{**************************************}
{* ENVIA NOTA ELETRONICA.             *}
{***********************************MV*}
function TLibNfe.fEnviarNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; Var strPontosImp: String): Boolean;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  strPontosImp := fDefinirPontoDeImpressao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli);

  Result := fEnviarNotaInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC, strPontosImp);
end;

{**************************************}
{* ENVIA NOTA ELETRONICA (FUNÇÃO IN-  *}
{* TERNA).                            *}
{***********************************MV*}
function TLibNfe.fEnviarNotaInterna(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strPontosImp: String): Boolean;
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    service: INFEService;
    strStatusAux: String;
    strMensagem_: String;

begin
  Result := False;
  Try
    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonte := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc,
      strCodEmp, strCodCli, strSerie, strTip_FC);
    service := fCriarNFEService(fonte);

    fonte.pCarregarDados;

    If Assigned(OnBeforeSetPontoImpressao) Then
      OnBeforeSetPontoImpressao(strPontosImp);

    fonte.fDadosGerais.strPontoImpressao := strPontosImp;

    If strEspDoc <> 'IF' Then
    Begin
      Result := service.fEnviarNota;

      pAtualizarMovObs(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
                       strTip_FC, fonte.fDadosGerais.strMsgAdicionalCom,
                       fonte.fDadosGerais.strMsgAdicionalFis,'', '', 0);
    End;

    pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'GE', '', '', 0, strPontosImp);    
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      If E.ResultadoValidacao <> Nil Then
      Begin
        For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
        Begin
          strErros := strErros + E.ResultadoValidacao.strErros[intContador];
          If intContador < E.ResultadoValidacao.intCount -1 Then
            strErros := strErros + #13#10;
        End;
      End
      Else
      Begin
        strErros := E.Message;
      End;

      strStatusAux := fSeErroRetornaStatusEnviarParaPainel(strErros, strEspDoc);
      strMensagem_ := IIF(IfEmptyStr(strStatusAux, 'EE') = 'EE', strErros, 'Enviado direto para o Painel');

      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
        strTip_FC, 'EE', strMensagem_, '', 0, strPontosImp);
      Raise ExceptionAutCom.Create('Erro ao enviar documento: ' + strErros);
    End;

    On E: Exception Do
    Begin
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
        strTip_FC, 'EE', E.Message, '', 0, strPontosImp);

      If (Pos('dhcpcsvc', E.Message) > 0) Then
      Begin
        Result := True;
        pMensagemOk('O Windows® não está respondendo. Clique em continuar usando o Autcom.');
      End
      Else
      Raise Exception.Create('Erro ao enviar documento: ' + E.MEssage);
    End;
  End;

end;

function TLibNfe.fEnviaXmlFit(const strArqXML: String): TRetornoNFE;
  Var
    service: IEnviarArquivosService;
    objConfigSovos: TConfiguracoesNFE;
begin
  pSetaConfiguracoes(confignfe);
  objConfigSovos := TConfiguracoesNFE.Create;
  objConfigSovos.strFitLicenca       := fCfgSis('CITLIC');
  objConfigSovos.strFitUsuario       := fCfgSis('CITUSU');
  objConfigSovos.strFitSenha         := fCfgSis('CITSEN');
  objConfigSovos.strFitUrlWebService := fCfgSis('CITURL');

  service := fCriarEnviarArquivosServiceConfigurado(objConfigSovos);

  Result := service.fEnviarXMLSat(strArqXML);
end;

function TLibNfe.fProcessarRetorno(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; strImpressora: String = ''): Boolean;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  If strImpressora.IsEmpty Then
    strImpressora := fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
      strSerie, strCodCli, strTip_FC);

  Result := fProcessarRetornoEnvioInterna(strNumDoc, strEspDoc, strCodEmp,
    strSerie, strCodCli, strTip_FC, strImpressora);
end;

function TLibNfe.fProcessarRetornoEnvioInterna(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strImpressora: String): Boolean;
  Var
    fonte: IFonteDados;
    service: INFEService;

    intContador: Integer;
    strErros: String;

    retorno: TRetornoNFE;
    strStsFalha: String;
    blnAutorizado: Boolean;

    procedure fAutorizaLogNfeOffLine(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strStatus, strObserv: String);
    Var
      qryAux: TUniQuery;
    begin
      Try
        qryAux := fCriaQuery;
        qryAux.SQL.Add('UPDATE LOGNFE SET ');
        qryAux.SQL.Add('  NFE_STATUS = :STATUS, ');
        qryAux.SQL.Add('  NFE_OBSERV = :OBSERV, ');
        qryAux.SQL.Add('  NFE_PNDPEC = 1        ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
        qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
        qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
        qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_     ');

        qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
        qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
        qryAux.ParamByName('CODEMP').AsString := strCodEmp;
        qryAux.ParamByName('CODCLI').AsString := strCodCli;
        qryAux.ParamByName('SERIE_').AsString := strSerie;
        qryAux.ParamByName('STATUS').AsString := strStatus;
        qryAux.ParamByName('OBSERV').AsString := strObserv;
        qryAux.ExecSQL;
      Finally
        FreeAndNil(qryAux);
      End;
    End;

begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosBDSet(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc, strCodEmp,
    strCodCli, strSerie, strTip_FC);

  {**************************************}
  {* PROCESSA O RETORNO DO ENVIO.       *}
  {***********************************MV*}
  fonte.pCarregarDados;

  If Assigned(OnBeforeSetPontoImpressao) Then
    OnBeforeSetPontoImpressao(strImpressora);

  fonte.fDadosGerais.strPontoImpressao := strImpressora;

  Try
    service := fCriarNFEService(fonte);

    //NFCE É SINCRONO...
    If strEspDoc = 'IF' Then
    Begin // Indica que foi gerado o xml offline
      If fonte.fDadosGerais.blnNFCeOffLine Then
      Begin // tenta enviar o xml offline
        If fonte.fDadosGerais.strStaOffLine = 'OF' Then
        Begin
          Result := service.fEnviaNFCeXmlOffLine;

          fAutorizaLogNfeOffLine(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, IIF( Result, 'AE', 'EE'), fonte.fDadosGerais.strMsgOffLine);
        End
        Else
        Begin // envia a correção do xml offline - erro de aplicação
          service.fEnviarNota;

          retorno := service.fProcessarEnvio;

          Result := retorno.Sucesso;

          fAutorizaLogNfeOffLine(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, IIF( Result, 'AT', 'EE'), retorno.mensagem);

          If Result Then
            pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp, strSerie,
                                          strCodCli, strTip_FC, retorno.QRCode,
                                          retorno.NumeroProtocolo,
                                          retorno.ObsFisco,
                                          retorno.DataAutorizacao,
                                          retorno.DataEmissao);

          pAtualizarMovObs(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
                           strTip_FC, fonte.fDadosGerais.strMsgAdicionalCom,
                           fonte.fDadosGerais.strMsgAdicionalFis, IIF(Result,'AT','EE'),
                           fonte.fDadosGerais.strXmlOffLine, fonte.fDadosGerais.dtaDteOffLine);

        End;

        Exit;
      End

      Else If fUsaIntegradorSatCitel Then
      Begin
        Result := True;
        Exit;
      End

      Else
      Begin // aqui envia online e offline
        service.fEnviarNota;

        retorno := service.fProcessarEnvio;

        pAtualizarMovObs(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
                         strTip_FC, fonte.fDadosGerais.strMsgAdicionalCom,
                         fonte.fDadosGerais.strMsgAdicionalFis,
                         IIF(retorno.OffLine, IIF(retorno.Sucesso,'OF','EE'), ''),
                         fonte.fDadosGerais.strXmlOffLine, fonte.fDadosGerais.dtaDteOffLine);
      End;
    End
    Else
      retorno := service.fProcessarEnvio;

    blnAutorizado := False;
    If (retorno.Sucesso) Or
       ( (retorno.Denegada) And (Not fEmptyStr(retorno.ChaveAcesso)) ) Then
    Begin
      pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, fonte.fDadosGerais.strChaveAcessoOffLine, retorno);

      pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp, strSerie,
                                    strCodCli, strTip_FC, retorno.QRCode,
                                    retorno.NumeroProtocolo,
                                    retorno.ObsFisco,
                                    retorno.DataAutorizacao,
                                    retorno.DataEmissao,
                                    retorno.ProtMsg);

      pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC,
        True, retorno);

      pAtualizarSubNfs(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, retorno);

      blnAutorizado := True;
    End;

    If (retorno.Aguardando) Then
      strStsFalha := 'GE'
    Else
    Begin
      If retorno.Denegada Then
        strStsFalha := 'DN'
      Else
        strStsFalha := 'EE';
    End;

    pGravarLogNfeInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
      strTip_FC, IIF( retorno.OffLine, 'OF', 'AT'), strStsFalha, retorno, strImpressora);

    If strEspDOc = 'IF' Then
      Result := blnAutorizado
    Else
      Result := True;

    pRemovePontoRecuperacaoSAT(strNumDoc, strCodEmp);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      If E.ResultadoValidacao <> Nil Then
      Begin
        For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
        Begin
          strErros := strErros + E.ResultadoValidacao.strErros[intContador];
          If intContador < E.ResultadoValidacao.intCount -1 Then
            strErros := strErros + #13#10;
        End;
      End
      Else
      Begin
        strErros := E.Message;
      End;

      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
          strTip_FC, IIF(E.NFCeOffLine, 'OF', 'EE'), strErros, '', 0, strImpressora);
      Raise ExceptionAutCom.Create(IIF(E.NFCeOffLine, 'Erro ao enviar NFCe Off-Line:', 'Erro ao enviar documento:') + strErros);
    End;

    On E: Exception Do
    Begin
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
          strTip_FC, 'EE', 'Erro de programa: ' + E.Message, '', 0, strImpressora);
      Raise;
    End;
  End;
end;

procedure TLibNfe.pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String;
  blnEnviar: Boolean; retorno: TRetornoNFe);
  Var
    qryAux: TUniQuery;
    strAutoInc: String;
begin
  If (Not fUsaSat) Then
    Exit;

  If (strEspDoc <> 'IF') Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT AUTOINCREM FROM CADFIS WHERE ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
    qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
    qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = IFNULL(:SERIE_, "") ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.Open;

    strAutoInc := qryAux.FieldByName('AUTOINCREM').AsString;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT * ');
    qryAux.SQL.Add('   FROM XMLSAT ');
    qryAux.SQL.Add('  WHERE XML_SEQFIS = :SEQFIS ');
    qryAux.SQL.Add('    AND XML_TIPARQ = :TIPARQ ');
    qryAux.ParamByName('SEQFIS').AsString := strAutoInc;
    qryAux.ParamByName('TIPARQ').AsInteger := IIF(blnEnviar, 1, 2);
    qryAux.Open;

    If (qryAux.IsEmpty) Then
    Begin
      qryAux.Insert;
      qryAux.FieldByName('XML_SEQFIS').AsString := strAutoInc;
      qryAux.FieldByName('XML_TIPARQ').AsInteger := IIF(blnEnviar, 1, 2);
    End
    Else
      qryAux.Edit;

    qryAux.FieldByName('XML_ARQXML').AsString := fCarregarArquivoSAT(blnEnviar, retorno.ChaveAcesso, retorno.NumeroSerieSAT);
    qryAux.Post;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLibNFe.fCarregarArquivoSAT(blnEnviar: Boolean; strChave, strNSerie: String): String;
  Var
    strArquivo: String;
    stlArq: TStringList;
begin
  strArquivo := ExtractFilePath(Application.ExeName) + 'XMLSAT\' +
    FormatDateTime('yyyymmdd', VS_Date) + '\' + strNSerie + '\' + IIF(blnEnviar, '', 'CANC_') + strChave + '.XML';

  stlArq := TStringList.Create;
  stlArq.LoadFromFile(strArquivo);
  Result := stlArq.Text;
  Result := AnsiReplaceStr(Result, #13#10, '<<csq>>');
  Result := AnsiReplaceStr(Result, #10#13, '<<csq>>');
  FreeAndNil(stlArq);
end;

{**************************************}
{* CARREGA CONFIGURAÇÕES.             *}
{***********************************MV*}
procedure TLibNfe.pCarregaConfigNFE(strCodEmp: String);
begin
  confignfe := TConfiguracoesNFE.Create;
  confignfe.strCodEmp := strCodEmp;
  confignfe.strEmpLog := VS_strCodEmp;
  confignfe.blnSimPau := fCfgSis('SIMPAU', varBoolean, strCodEmp);
  confignfe.strClaSub := fRegimeSubstituicaoTributaria(strCodEmp, '');
  confignfe.blnNFEFab := fCfgSis('NFEFAB', varBoolean, strCodEmp);
  confignfe.blnNFEMar := fCfgSis('NFEMAR', varBoolean, strCodEmp);
  confignfe.blnNFELoc := fCfgSis('NFELOC', varBoolean, strCodEmp);
  confignfe.blnNfeMFi := fCfgSis('NFEMFI', varBoolean, strCodEmp);
  confignfe.blnVendad := fCfgSis('VENDAD', varBoolean, strCodEmp);
  confignfe.strNfeEmp := fCfgSis('NFEEMP', varString,  strCodEmp);
  confignfe.blnNfeDse := fCfgSis('NFEDSE', varBoolean, strCodEmp);
  confignfe.blnHomolo := fCfgSis('HOMOLO', varBoolean, strCodEmp);
  confignfe.blnCclNfe := fCfgSis('CCLNFE', varBoolean, strCodEmp);
  confignfe.strNfeIte := fCfgSis('NFEITE', varString,  strCodEmp);
  confignfe.strPatOph := fCfgSis('NFEPAT', varString,  strCodEmp);
  confignfe.strIteSer := fCfgSis('ITESER', varString,  strCodEmp);
  confignfe.blnUsaSer := fCfgSis('USASER', varBoolean, strCodEmp);
  confignfe.blnCdpNfe := fCfgSis('CDPNFE', varBoolean, strCodEmp);
  confignfe.blnOrgDfi := fCfgSis('ORGDFI', varBoolean, strCodEmp);
  confignfe.strEndPrc := fCfgSis('ENDPRC', varString,  strCodEmp);
  confignfe.strTelPrc := fCfgSis('TELPRC', varString, strCodEmp);
  confignfe.strEndAle := fCfgSis('ENDALE', varString,  strCodEmp);
  confignfe.strTelAle := fCfgSis('TELALE', varString, strCodEmp);
  If (fCfgSis('CLIPRO', varString,  strCodEmp) = 'S') And (opcPdOrNf in fRetUtilizaCliPro) Then
    confignfe.strCliPro := 'S'
  Else
    confignfe.strCliPro := 'N';
  confignfe.blnConIpi := fCfgSis('CONIPI', varBoolean, strCodEmp);
  confignfe.blnRIcmPr := fCfgSis('RICMPR', varBoolean, strCodEmp);
  confignfe.strClaVen := fTransform(fCfgSis('CLAVEN', varString, strCodEmp), 4);
  confignfe.strClaDev := fTransform(fCfgSis('CLADEV', varString, strCodEmp), 4);

  If (fExisteConfiguracao('EMATRA', strCodEmp)) Then
    confignfe.strEmaTra := fCfgSis('EMATRA', varString, strCodEmp)
  Else
    confignfe.strEmaTra := 'N';

  confignfe.strImpPag := fCfgSis('IMPPAG', varString,  strCodEmp);
  confignfe.blnInfGar := fCfgSis('IMPGAR', varBoolean, strCodEmp);
  confignfe.strClaCif := fTransform(fCfgSis('CLACIF', varString, strCodEmp), 3);
  confignfe.blnImpCif := fCfgSis('IMPCIF', varBoolean, strCodEmp);
end;

{**************************************}
{* CARREGA DLL LIBNFE.DLL             *}
{***********************************MV*}
procedure TLibNfe.pCarregarDll(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String);
begin

  If handleBD <> 0 Then
    Exit;

  handleBD := LoadLibrary(PChar('libNfeBD.dll'));

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD := GetProcAddress(handleBD, PAnsiChar('pSetaConfiguracoesBD'));

  If (handleBD = 0) Then
    fCriarFonteDadosBDSet := fCriarFonteDadosBD
  Else
    fCriarFonteDadosBDSet := GetProcAddress(handleBD, PAnsiChar('fCriarFonteDadosBD'));
end;

procedure TLibNfe.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao, strEspDoc: String);
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    service: INFEAdministrativoService;
begin
  Try
    pSetaConfiguracoes(confignfe);
    fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', strEspDoc, confignfe.strCodEmp, '', '', '');
    service := fCriarNFEAdministrativoService(fonte);

    fonte.pCarregarDados;

    If service.fSuportaFuncoesAdministrativas Then
    Begin
      service.pInutilizarNumeros(strAno, strSerie, strNumeroInicial, strNumeroFinal, strDescricao);
    End
    Else
    Begin
      Raise Exception.Create(strMensagem);
    End;
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;

      Raise Exception.Create('Erro ao inutilizar: ' + strErros);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao inutilizar: ' + E.MEssage);
    End;
  End;
end;

procedure TLibNfe.pReimprimirDanfe(strChaveAcesso, strImpressora, strSerie: String; strImprimirTelaPDF: String = '');
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    service: INFEAdministrativoService;

    strEspDoc: String;
    strCodEmp: String;
    strNumDoc: String;
begin

  strEspDoc := '';
  strCodEmp := '';
  strNumDoc := '';

  If Length(strChaveAcesso) < 44 Then
  Begin
    strEspDoc := 'NS';
    strCodEmp := FCodEmp;
    strNumDoc := fRetornaNumeroDocumento(strEspDoc, strCodEmp, strSerie, strChaveAcesso);
  End;

  Try
    pSetaConfiguracoes(confignfe);
    fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc, strCodEmp, '', strSerie, '');
    service := fCriarNFEAdministrativoService(fonte);

    fonte.pCarregarDados;

    If service.fSuportaFuncoesAdministrativas Then
    Begin
      service.pReimprimirDanfe(strChaveAcesso, strImpressora, strImprimirTelaPDF);
    End
    Else
    Begin
      Raise Exception.Create(strMensagem);
    End;
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;

      Raise Exception.Create('Erro ao reimprimir: ' + strErros);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao reimprimir: ' + E.MEssage);
    End;
  End;
end;

procedure TLibNfe.pReimprimirConhecimentoEletronico(strNumCTe, strImpressora: String);
var
  fonte: IFonteDadosConhecimento;
  service: IConhecimentoEletronicoService;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosConhecimento(frmModulo.GetCurrentConnection);
  service := fCriarConhecimentoEletronicoService(fonte, nil);

  confignfe.strFitImpressoraPadrao := strImpressora;

  service.pImprimirConhecimento(strNumCTe, 'S');
end;

procedure TLibNfe.pRemovePontoRecuperacaoSAT(strNumDoc, strCodEmp: String);

  {****************************************************************************}
  {* DEIXAR ALINHADO ESSA FUNÇÃO COM A FUNÇÃO DA LIBNFE.DLL >> fNumDocEnvio   *}
  {*************************************************************************RN*}
  function fNumDocEnvio(Value: String): String;
  begin
    Result := RightStr(Value, 9);
  end;

  Var
    strPath: String;
    intContador: Integer;
    strArq: String;
begin
  strPath := ExtractFilePath(Application.ExeName) + 'XMLSAT\';
  If Not DirectoryExists(strPath) Then
  Begin
    Exit;
  End;

  strArq := strPath + fNumDocEnvio(strNumDoc) + '_' + strCodEmp + '.TXT';

  For intContador := 1 To 5 Do
  Begin
    If Not FileExists(strArq) Then
    Begin
      Break;
    End;

    DeleteFile(strArq);
  End;
end;

class function TLibNfe.fRetPontoImpressao(const strEspDoc: String; const strCodEmp: String): String;
Var
  strSQL: String;
  qryPon: TUniQuery;
begin

  Result := '';

  If strEspDoc = 'IF' Then
  Begin
    Result := fRetImpressoraNFCe;
    Exit;
  End;

  qryPon := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  PONIMP ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PON_CODEMP = :CODEMP ';

    If VS_SpoolImpressaoCitel Then
      strSQL := strSQL + ' AND PON_SPOIMP = "S" '
    Else
      strSQL := strSQL + ' AND PON_SPOIMP <> "S" ';

    strSQL := strSQL + ' AND IFNULL(PON_NOMMAQ, "") = :NOMMAQ ';

    With qryPon Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NOMMAQ').AsString := VS_WorkstationID;
      Open;

      If IsEmpty Then
      Begin
        Close;
        ParamByName('NOMMAQ').AsString := EmptyStr;
        Open;
      End;

      {************************************************}
      {* SE EXISTIR SOMENTE UM PONTO DE IMPRESSÃO     *}
      {* CADASTRADO, APENAS RETORNA O NOME DO PONTO,  *}
      {* SE EXISTIR MAIS DE UM PONTO CADASTRADO, ABRE *}
      {* A TELA PARA QUE O USUARIO ESCOLHA O PONTO DE *}
      {* IMPRESSÃO QUE DESEJA.                        *}
      {*********************************************PZ*}
      If (RecordCount = 1) Then
        Result := FieldByName('PON_NOMPON').AsString
      Else If (RecordCount > 1) And VS_ExibirMensagemAoUsuario Then
      Begin
        pCriarFormularios(TfrmPontosImpressao, frmPontosImpressao);
        Try
          frmPontosImpressao.qryPon := qryPon;
          frmPontosImpressao.ShowModal;

          If (frmPontosImpressao.ModalResult = mrOk) Then
            Result := frmPontosImpressao.strPonImp;
        Finally
          pFreeAndNil(frmPontosImpressao);
        End;
      End;
    End;
  Finally
    FreeAndNil(qryPon);
  End;
end;

class function TLibNfe.fRetImpressoraNFCe: String;
  Var
    strDirIni: String;
    strChave: String;
begin
  Result := fRetornaFilaImpressaoNFCe;

  if Not Result.IsEmpty then
    Exit;

  strDirIni := fCfgSis('PTNFCE');
  If fEmptyStr(strDirIni) Then
  Begin
    Exit;
  End;

  If VS_SpoolImpressaoCitel Then
    strChave := 'PONTO_IMPRESSAO'
  Else
    strChave := 'IMPRESSORA';

  Result := fArqIniLocal(0, 'NFCE', strChave, '', strDirIni + '\opcoes_nfce.ini');
end;

function TLibNfe.fEnviarManifestoEletronico(strNumMan, strNomImp: String): Boolean;
begin
  Result := fEnviarManifestoEletronicoInterna(strNumMan, strNomImp);
end;

function TLibNfe.fEnviarManifestoEletronicoInterna(strNumMan, strNomImp: String): Boolean;
  Var
    fonte: IFonteDadosManifesto;
    service: IManifestoEletronicoSerivce;
    strErros: String;
    intContador: Integer;
begin
  Try
    pSetaConfiguracoes(confignfe);

    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(confignfe);

    fonte := fCriarFonteDadosManifesto(frmModulo.GetCurrentConnection);
    service := fCriarManifestoEletronicoService(fonte);

    If fEmptyStr(strNomImp) Then
      strNomImp := fRetPontoImpressao('ME', VS_strCodEmp);

    Result := service.fEnviarManifesto(strNumMan);

    pGravarLogNfe(strNumMan, 'ME', VS_strCodEmp, fSerieManifesto(VS_strCodEmp), '', '', 'GM', '', '', 0, strNomImp);

  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      If E.ResultadoValidacao <> Nil Then
      Begin
        For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
        Begin
          strErros := strErros + E.ResultadoValidacao.strErros[intContador];
          If intContador < E.ResultadoValidacao.intCount -1 Then
            strErros := strErros + #13#10;
        End;
      End
      Else
      Begin
        strErros := E.Message;
      End;
      pGravarLogNfe(strNumMan, 'ME', VS_strCodEmp, fSerieManifesto(VS_strCodEmp), '', '', 'EM', strErros);
      Raise ExceptionAutCom.Create('Erro ao enviar documento: ' + strErros);
    End;

    On E: Exception Do
    Begin
      pGravarLogNfe(strNumMan, 'ME', VS_strCodEmp, fSerieManifesto(VS_strCodEmp), '', '', 'EM', E.Message);
    	Raise Exception.Create('Erro ao enviar documento: ' + E.MEssage);
    End;
  End;
end;

function TLibNfe.fEnviarManifestoEventoPagamento(strNumMan: String): Boolean;
begin
  Result := fEnviarManifestoEventoPagamentoInterna(strNumMan);
end;

function TLibNfe.fEnviarManifestoEventoPagamentoInterna(strNumMan: String): Boolean;
Var
  fonte   : IFonteDadosManifesto;
  service : IManifestoEletronicoSerivce;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosManifesto(frmModulo.GetCurrentConnection);
  service := fCriarManifestoEletronicoService(fonte);

  Result := service.fEnviarManifestoEventoPagamento(strNumMan);
end;

procedure TLibNfe.pImprimirManifesto(manifesto, strImpressora: String);
begin
  pImprimirManifestoInterna(manifesto, strImpressora);
end;

procedure TLibNfe.pImprimirManifestoInterna(manifesto, strImpressora: String);
Var
  fonte   : IFonteDadosManifesto;
  service : IManifestoEletronicoSerivce;
begin
  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosManifesto(frmModulo.GetCurrentConnection);
  service := fCriarManifestoEletronicoService(fonte);

  service.pImprimirManifesto(manifesto, strImpressora);
end;

class function TLibNfe.fVerificaCancelamentosPendentesPainel(strEspecie: String = ''): Boolean;
Var
  strSQL: String;
  qryGenNFE: TUniQuery;
begin
  Try

    qryGenNFE := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT    ';
    strSQL := strSQL + '  NFE_NUMDOC  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  LOGNFE  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  NFE_ESPDOC <> "IF" AND ';
    strSQL := strSQL + '  NFE_ESPDOC <> "IV" AND ';
    strSQL := strSQL + '  NFE_ESPDOC <> "ME" AND ';
    strSQL := strSQL + '  NFE_STATUS NOT IN("AT","CN","OK","DC","IN") AND  ';
    strSQL := strSQL + '  NFE_CODEMP = :CODEMP  ';

    If Not fEmptyStr(strEspecie) Then
      strSQL := strSQL + '  AND NFE_ESPDOC = :ESPDOC ';

    With qryGenNFE Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(strEspecie) Then
        ParamByName('ESPDOC').AsString := strEspecie;

      Open;

      Result := (IsEmpty);
    End;

  Finally
    FreeAndNil(qryGenNFE);
  End;

end;

function fPainelEstaAberto: Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := True;

  If FileExists('nfe.citel') Or FileExists('nfe.310') Or (fCfgSis('VERNFE') = '4.00') Then
  Begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT IS_USED_LOCK("PAINEL_NFE_' + VS_strCodEmp + '")');
    qryAux.Open;

    Result := (Not fEmptyStr(qryAux.Fields[0].AsString));

    FreeAndNil(qryAux);
  End;
end;

procedure pInutilizarNumeros(strNumDoc, strSerie, strDescri, strEspDoc: String);
  Var
    libNfe: TLibNfe;
    strAno: String;
begin
  strAno := IntToStr(YearOf(VS_Date));

  libNfe := TLibNfe.Create(VS_strCodEmp);
  libNfe.pInutilizarNumeros(strAno, strSerie, strNumDoc, strNumDoc, strDescri, strEspDoc);
  FreeAndNil(libNfe);
end;

procedure pDeletaLogNfe(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie,
  strTip_FC: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM LOGNFE WHERE ');
  qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ AND ');
  qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

function fEnviarManifestoEletronico(strNumMan, strNomImp: String): Boolean;
  Var
    libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    Result := libnfe.fEnviarManifestoEletronico(strNumMan, strNomImp);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fEnviarDocsCarregados(strNumMan, strListaAutoIncrem, strEmpMan: string): Boolean;
  Var
    libNfe: TLibNfe;
begin
  If fEmptyStr(strEmpMan) Then
    strEmpMan := VS_strCodEmp;

  libnfe := TLibNfe.Create(strEmpMan);
  Try
    Result := libnfe.fEnviarDocsCarregados(strNumMan, strListaAutoIncrem, strEmpMan);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fEnviarManifestoEventoPagamento(strNumMan : string): Boolean;
Var
  libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    Result := libnfe.fEnviarManifestoEventoPagamento(strNumMan);
  Finally
    FreeAndNil(libNfe);
  End;
end;

procedure pImprimirManifesto(manifesto, strCodEmp, strImpressora: String);
Var
  libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(strCodEmp);
  Try
    libnfe.pImprimirManifesto(manifesto, strImpressora);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fEnviarCancelamentoConhecimento(strNumCTe, strJustificativa, strNomeUsuario: String): Boolean;
var
  libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    Result := libnfe.fEnviarCancelamentoConhecimentoEletronico(strNumCTe, strJustificativa, strNomeUsuario);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fEnviarEncerramentoManifesto(strNumMan, strEmpMan: String): Boolean;
  Var
    libNfe: TLibNfe;
begin
  If fEmptyStr(strEmpMan) Then
    strEmpMan := VS_strCodEmp;

  libnfe := TLibNfe.Create(strEmpMan);
  Try
    Result := libnfe.fEnviarEncerramentoEletronico(strNumMan);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fEnviarCancelamentoManifesto(strNumMan, strJustificativa: String): Boolean;
  Var
    libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    Result := libnfe.fEnviarCancelamentoManifestoEletronico(strNumMan, strJustificativa);
  Finally
    FreeAndNil(libNfe);
  End;
end;

procedure TLibNfe.pAcertaDataHoraEmissao(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie, strTip_FC: String; dtaEmissao: TDateTime);
  Var
    qryAux: TUniQuery;
    strTabGer: String;
    strTabDet: String;
begin
  If strEspDoc <> 'IF' Then
    Exit;

  If dtaEmissao <= 0 Then
    Exit;

  qryAux := fCriaQuery;
  qryAux.SQL.Add('UPDATE CADFIS SET ');
  qryAux.SQL.Add('  FIS_DTAENT = :DTAENT ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
  qryAux.SQL.Add('  FIS_SERIE_ = :SERIE_ AND ');
  qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('DTAENT').AsDateTime := Int(dtaEmissao);
  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('FORCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM MOVGER WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :FORCLI AND ');
  qryAux.SQL.Add('  GER_SERIE_ = :SERIE_ AND ');
  qryAux.SQL.Add('  GER_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('FORCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.Open;

  If qryAux.FieldByName('QTD').AsInteger > 0 Then
  Begin
    strTabGer := 'MOVGER';
    strTabDet := 'MOVDET';
  End
  Else
  Begin
    strTabGer := 'NOTGER';
    strTabDet := 'NOTDET';
  End;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE ' + strTabGer + ' SET ');
  qryAux.SQL.Add('  GER_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  GER_HORENT = :HORENT ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :FORCLI AND ');
  qryAux.SQL.Add('  GER_SERIE_ = :SERIE_ AND ');
  qryAux.SQL.Add('  GER_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('DTAENT').AsDateTime := Int(dtaEmissao);
  qryAux.ParamByName('HORENT').AsDateTime := Frac(dtaEmissao);

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('FORCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE ' + strTabDet + ' SET ');
  qryAux.SQL.Add('  DET_DTAENT = :DTAENT, ');
  qryAux.SQL.Add('  DET_HORENT = :HORENT ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  DET_CODCLI = :FORCLI AND ');
  qryAux.SQL.Add('  DET_SERIE_ = :SERIE_ AND ');
  qryAux.SQL.Add('  DET_TIP_FC = :TIP_FC ');

  qryAux.ParamByName('DTAENT').AsDateTime := Int(dtaEmissao);
  qryAux.ParamByName('HORENT').AsDateTime := Frac(dtaEmissao);

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('FORCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ExecSQL;


  FreeAndNil(qryAux);
end;

procedure TLibNfe.pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strChaveAcessoOffLine: String; retorno: TRetornoNFE);
  Var
    qryAux: TUniQuery;
    strFisCodMod: String;
begin
  strFisCodMod := Copy(retorno.ChaveAcesso, 21, 2);

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  FIS_ACESSO = :ACESSO, ');
    qryAux.SQL.Add('  FIS_CODMOD = :CODMOD  ');

    If not fEmptyStr(strChaveAcessoOffLine) Then
    Begin
      If fCampoExiste('CADFIS','FIS_DOCOFF', True) Then
        qryAux.SQL.Add('  , FIS_DOCOFF = :DOCOFF ');

      If fCampoExiste('CADFIS','FIS_ACEOFF', True) Then
        qryAux.SQL.Add('  , FIS_ACEOFF = :ACEOFF ');

      If fCampoExiste('CADFIS','FIS_DTAOFF', True) Then
        qryAux.SQL.Add('  , FIS_DTAOFF = :DTAOFF ');
    End;

    If Not fEmptyStr(retorno.NumeroSerieSAT) Then
    Begin
      qryAux.SQL.Add('  , FIS_NUMSER = :NUMSER ');
      qryAux.SQL.Add('  , FIS_NUMCOO = :NUMCOO ');
    End;

    If (Not fEmptyStr(retorno.NumeroProtocolo)) Then
      qryAux.SQL.Add('  , FIS_PROTOC = :PROTOC ');

    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
    qryAux.SQL.Add('  FIS_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;
    If (fModeloFiscalValido(strFisCodMod)) Then
      qryAux.ParamByName('CODMOD').AsString := strFisCodMod
    Else
      qryAux.ParamByName('CODMOD').Value := Null;

    If not fEmptyStr(strChaveAcessoOffLine) Then
    Begin
      If fCampoExiste('CADFIS','FIS_DOCOFF', True) Then
        qryAux.ParamByName('DOCOFF').AsString := 'S';

      If fCampoExiste('CADFIS','FIS_ACEOFF', True) Then
        qryAux.ParamByName('ACEOFF').AsString := strChaveAcessoOffLine;

      If fCampoExiste('CADFIS','FIS_DTAOFF', True) Then
        qryAux.ParamByName('DTAOFF').AsDateTime := fNow;
    End;

    If Not fEmptyStr(retorno.NumeroSerieSAT) Then
    Begin
      qryAux.ParamByName('NUMSER').AsString := retorno.NumeroSerieSAT;
      qryAux.ParamByName('NUMCOO').AsString := retorno.NumeroCFe;
    End;

    If (Not fEmptyStr(retorno.NumeroProtocolo)) Then
      qryAux.ParamByName('PROTOC').AsString := retorno.NumeroProtocolo;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TLibNfe.pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strQRCode, strProtocolo, strObsFisco: String;
  dtaAutorizacao, dtaEmissao: TDateTime; strProtMsg: String = '');
  Var
    qryMovObs: TUniQuery;
    qryMovGer: TUniQuery;

    strAutInc: String;
    strTabela: String;
    strSQL: String;

    procedure pAbreQuery;
    begin
      qryMovGer.ParamByName('NUMDOC').AsString := strNumDoc;
      qryMovGer.ParamByName('ESPDOC').AsString := strEspDoc;
      qryMovGer.ParamByName('CODEMP').AsString := strCodEmp;
      qryMovGer.ParamByName('SERIE_').AsString := strSerie;
      qryMovGer.ParamByName('CODCLI').AsString := strCodCli;
      qryMovGer.ParamByName('TIP_FC').AsString := strTip_FC;
      qryMovGer.Open;
    end;
begin
  strTabela := '';
  strAutInc := '';

  pAcertaDataHoraEmissao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC, dtaEmissao);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
  strSQL := strSQL + '  IF(:TIP_FC = "C", GER_CODCLI, GER_CODCLI) = :CODCLI AND ';
  strSQL := strSQL + '  GER_TIP_FC = :TIP_FC ';

  qryMovGer := fCriaQuery(Nil);
  qryMovGer.SQL.Add(strSQL);
  pAbreQuery;

  If Not qryMovGer.IsEmpty Then
  Begin
    strTabela := 'MOVOBS';
    strAutInc := qryMovGer.FieldByName('AUTOINCREM').AsString;
  End
  Else
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
    qryMovGer.Close;
    qryMovGer.SQL.Clear;
    qryMovGer.SQL.Add(strSQL);
    pAbreQuery;

    If Not qryMovGer.IsEmpty Then
    Begin
      strTabela := 'NOTOBS';
      strAutInc := qryMovGer.FieldByName('AUTOINCREM').AsString;
    End;
  End;

  FreeAndNil(qryMovGer);

  If Not fEmptyStr(strTabela) Then
  Begin
    qryMovObs := fCriaQuery(Nil);
    qryMovObs.SQL.Add('UPDATE ' + strTabela + ' SET ');
    qryMovObs.SQL.Add('  MOV_QRCODE = :QRCODE, ');
    qryMovObs.SQL.Add('  MOV_PROTOC = :PROTOC, ');
    qryMovObs.SQL.Add('  MOV_DPROTO = :DPROTO, ');
    qryMovObs.SQL.Add('  MOV_OBSFIS = CONCAT(COALESCE(MOV_OBSFIS, ""), IF(COALESCE(MOV_OBSFIS, "") <> "", "\n", ""), :OBSFIS) ');

    If Not fEmptyStr(strProtMsg) Then
      qryMovObs.SQL.Add(' ,MOV_PRTMSG = :PRTMSG ');

    qryMovObs.SQL.Add('WHERE ');
    qryMovObs.SQL.Add('  MOV_SEQGER = :SEQGER');

    qryMovObs.ParamByName('QRCODE').AsString := strQRCode;
    qryMovObs.ParamByName('PROTOC').AsString := strProtocolo;
    qryMovObs.ParamByName('DPROTO').AsDateTime := dtaAutorizacao;
    qryMovObs.ParamByName('OBSFIS').AsString := strObsFisco;
    qryMovObs.ParamByName('SEQGER').AsString := strAutInc;

    If Not fEmptyStr(strProtMsg) Then
      qryMovObs.ParamByName('PRTMSG').AsString := strProtMsg;

    qryMovObs.ExecSQL;
    FreeAndNil(qryMovObs);
  End;
end;

procedure TLibNfe.pAtualizarMovObs(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMsgAdicionalCom, strMsgAdicionalFis,
  strStaOffLine, strXmlOffLine: String; dtaDteOffLine: TDateTime);
var blnOffLine: Boolean;

  function fSQLMovGer(strTab: String): String;
  begin
    Result := '';
    Result := Result + 'SELECT AUTOINCREM ';
    Result := Result + '  FROM ' + strTab;
    Result := Result + ' WHERE GER_NUMDOC = :NUMDOC ';
    Result := Result + '   AND GER_ESPDOC = :ESPDOC ';
    Result := Result + '   AND GER_CODEMP = :CODEMP ';
    Result := Result + '   AND IFNULL(GER_SERIE_, "") = :SERIE_ ';
    Result := Result + '   AND IF(:TIP_FC = "C", GER_CODCLI, GER_CODFOR) = :CODCLI ';
    Result := Result + '   AND GER_TIP_FC = :TIP_FC ';
  end;

  Var
    qryMovGer: TUniQuery;
    strAutInc: String;
    strTabela: String;
    intCnt : Integer;

  Const
    arrTabGer : Array[1..2] Of String = ('MOVGER', 'NOTGER');
    arrTabObs : Array[1..2] Of String = ('MOVOBS', 'NOTOBS');

begin
  strTabela := '';
  strAutInc := '';

  blnOffLine := not fEmptyStr(strXmlOffLine);

  qryMovGer := fCriaQuery(Nil);

  With qryMovGer Do
  Begin
    For intCnt := 1 To 2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add( fSQLMovGer( arrTabGer[intCnt]) );
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('SERIE_').AsString := strSerie;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('TIP_FC').AsString := strTip_FC;
      Open;

      If (Not IsEmpty) Then
      Begin
        strTabela := arrTabObs[intCnt];
        strAutInc := FieldByName('AUTOINCREM').AsString;
        Break;
      End;
    End;
    Close;
  End;

  If (Not fEmptyStr(strTabela)) Then
  Begin
    With qryMovGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ' + strTabela);
      SQL.Add('    SET MOV_OBSERV = :OBSERV ');

      If fCampoExiste('MOVOBS', 'MOV_OBSFIS', True) Then
        SQL.Add('  , MOV_OBSFIS = :OBSFIS ');

      If blnOffLine Then
      Begin
        If fCampoExiste('MOVOBS', 'MOV_STAOFF', True) Then
          SQL.Add('  , MOV_STAOFF = :STAOFF ');

        If fCampoExiste('MOVOBS', 'MOV_DTEOFF', True) Then
          SQL.Add('  , MOV_DTEOFF = :DTEOFF ');

        If fCampoExiste('MOVOBS', 'MOV_XMLOFF', True) Then
          SQL.Add('  , MOV_XMLOFF = :XMLOFF ');
      End;

      SQL.Add('  WHERE MOV_SEQGER = :SEQGER ');
      ParamByName('OBSERV').AsString := strMsgAdicionalCom;

      If fCampoExiste('MOVOBS', 'MOV_OBSFIS', True) Then
        ParamByName('OBSFIS').AsString := strMsgAdicionalFis;

      If blnOffLine Then
      Begin
        If fCampoExiste('MOVOBS', 'MOV_STAOFF', True) Then
          ParamByName('STAOFF').AsString := strStaOffLine;

        If fCampoExiste('MOVOBS', 'MOV_DTEOFF', True) Then
          ParamByName('DTEOFF').AsDateTime := IIF(dtaDteOffLine = 0, fNow, dtaDteOffLine);

        If fCampoExiste('MOVOBS', 'MOV_XMLOFF', True) Then
          ParamByName('XMLOFF').AsString := strXmlOffLine;
      End;

      ParamByName('SEQGER').AsString := strAutInc;
      ExecSQL;
    End;
  End;

  FreeAndNil(qryMovGer);
end;

function TLibNfe.fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): String;
begin
  Result := fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
    strSerie, strCodCli, strTip_FC);

  If not (((strEspDoc = 'IF') And (fCfgSis('PRNFCE', varBoolean))) Or
          ((strEspDoc = 'NF') And (fCfgSis('CITINF', varBoolean)))) Then
  Begin
    Result := fRetornaNomeImpressora(Result);
  End;
end;

function TLibNfe.fCarregarNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean): String;
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    service: INFEAdministrativoService;
begin

  Try
    pSetaConfiguracoes(confignfe);
    fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, '', '', '', '', '', '');
    service := fCriarNFEAdministrativoService(fonte);

    fonte.pCarregarDados;

    If service.fSuportaFuncoesAdministrativas Then
    Begin
      Result := service.fCarregarNfePdf(AChaveAcesso, ANomeArquivo, AExtensao);
    End
    Else
    Begin
      Raise Exception.Create(strMensagem);
    End;
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strErros := '';
      For intContador := 0 To E.ResultadoValidacao.intCount -1 Do
      Begin
        strErros := strErros + E.ResultadoValidacao.strErros[intContador];
        If intContador < E.ResultadoValidacao.intCount -1 Then
          strErros := strErros + #13#10;
      End;

      Raise Exception.Create('Erro ao gerar pdf: ' + strErros);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao gerar pdf: ' + E.MEssage);
    End;
  End;
end;

procedure TLibNfe.pAtualizarSubNfs(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; retorno: TRetornoNFE);
  Var
    qryAux: TUniQuery;
    qryFis: TUniQuery;
begin
  If (strEspDoc = 'NS') And (Not fEmptyStr(retorno.NumeroProtocolo)) And (fTabelaExiste('SUBNFS', True)) Then
  Begin

    qryFis := fCriaQuery(Nil);
    qryAux := fCriaQuery(Nil);

    Try

      qryFis.SQL.Add('SELECT AUTOINCREM FROM ');
      qryFis.SQL.Add('CADFIS WHERE ');
      qryFis.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      qryFis.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
      qryFis.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
      qryFis.SQL.Add('  FIS_FORCLI = :FORCLI AND ');
      qryFis.SQL.Add('  FIS_TIP_FC = :TIP_FC AND ');
      qryFis.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

      qryFis.ParamByName('NUMDOC').AsString := strNumDoc;
      qryFis.ParamByName('ESPDOC').AsString := strEspDoc;
      qryFis.ParamByName('CODEMP').AsString := strCodEmp;
      qryFis.ParamByName('FORCLI').AsString := strCodCli;
      qryFis.ParamByName('TIP_FC').AsString := strTip_FC;
      qryFis.ParamByName('SERIE_').AsString := strSerie;
      qryFis.Open;

      qryAux.SQL.Add('REPLACE INTO SUBNFS (SUB_SEQGER, SUB_NUMRPS, SUB_SERRPS, SUB_ENVIAD) VALUES ');
      qryAux.SQL.Add('(:SEQGER, :NUMRPS, :SERRPS, 0) ');
      qryAux.ParamByName('SEQGER').AsString := qryFis.FieldByName('AUTOINCREM').AsString;
      qryAux.ParamByName('NUMRPS').AsString := retorno.NumeroProtocolo;
      qryAux.ParamByName('SERRPS').AsString := strSerie;
      qryAux.ExecSQL;
    Finally
      FreeAndNil(qryAux);
      FreeAndNil(qryFis);
    End;
  End;
end;

procedure TLibNfe.pGravarLogNfeInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strStsSucesso, strStsFalha: String; retorno: TRetornoNFE;
  strPontoImpressao: String='');
  Var
    qryAux: TUniQuery;
    dtaDtaEmi : TDate;
    intViaNfe: Integer;
begin

  If (strStsFalha = 'GE')  And
     (fNotaFiscalJaAutorizada(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC)) Then
  Begin
    Exit;
  End;

  intViaNfe := fCarregarViaNfeGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('REPLACE INTO LOGNFE (');
  qryAux.SQL.Add('  NFE_NUMDOC, ');
  qryAux.SQL.Add('  NFE_ESPDOC, ');
  qryAux.SQL.Add('  NFE_CODEMP, ');
  qryAux.SQL.Add('  NFE_CODCLI, ');
  qryAux.SQL.Add('  NFE_SERIE_, ');
  qryAux.SQL.Add('  NFE_TIP_FC, ');
  qryAux.SQL.Add('  NFE_STATUS, ');
  qryAux.SQL.Add('  NFE_OBSERV, ');
  qryAux.SQL.Add('  NFE_ACESSO, ');
  qryAux.SQL.Add('  NFE_PONIMP, ');
  qryAux.SQL.Add('  NFE_DTAEMI, ');
  qryAux.SQL.Add('  NFE_PNDPEC, ');

  If fCampoExiste('LOGNFE', 'NFE_PDSTDP', True) Then
    qryAux.SQL.Add('  NFE_PDSTDP, ');

  If (intViaNfe > -1) Then
    qryAux.SQL.Add('  NFE_VIANFE, ');

  qryAux.SQL.Add('  NFE_DTAAUT, ');
  qryAux.SQL.Add('  NFE_HORINI) ');
  qryAux.SQL.Add('VALUES ( ');
  qryAux.SQL.Add('  :NUMDOC, ');
  qryAux.SQL.Add('  :ESPDOC, ');
  qryAux.SQL.Add('  :CODEMP, ');
  qryAux.SQL.Add('  :CODCLI, ');
  qryAux.SQL.Add('  :SERIE_, ');
  qryAux.SQL.Add('  :TIP_FC, ');
  qryAux.SQL.Add('  :STATUS, ');
  qryAux.SQL.Add('  :OBSERV, ');
  qryAux.SQL.Add('  :ACESSO, ');
  qryAux.SQL.Add('  :PONIMP, ');
  qryAux.SQL.Add('  :DTAEMI, ');
  qryAux.SQL.Add('  :PNDPEC, ');

  If fCampoExiste('LOGNFE', 'NFE_PDSTDP', True) Then
    qryAux.SQL.Add('  :PDSTDP, ');

  If (intViaNfe > -1) Then
    qryAux.SQL.Add('  :VIANFE, ');

  qryAux.SQL.Add('  :DTAAUT, ');
  qryAux.SQL.Add('  '+fCurrentDateTime+' ) ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := IIF(strEspDoc = 'ME', fSerieManifesto(strCodEmp), strSerie);
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ParamByName('OBSERV').AsString := retorno.Mensagem;

  If Not fEmptyStr(strPontoImpressao) Then
    qryAux.ParamByName('PONIMP').AsString := strPontoImpressao
  Else
    qryAux.ParamByName('PONIMP').AsString := fCarregarPontoImpressaoGravado(strNumDoc,
      strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  dtaDtaEmi := fDataEmissaoDocumentoFiscal(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC);

  If (dtaDtaEmi = 0) Then
    qryAux.ParamByName('DTAEMI').Value := Null
  Else
    qryAux.ParamByName('DTAEMI').AsDate := dtaDtaEmi;

  If retorno.Sucesso Then
  Begin
    qryAux.ParamByName('STATUS').AsString   := strStsSucesso;
    qryAux.ParamByName('ACESSO').AsString   := retorno.ChaveAcesso;

    If (retorno.DataAutorizacao <> 0) Then
      qryAux.ParamByName('DTAAUT').AsDateTime := retorno.DataAutorizacao
    Else
      qryAux.ParamByName('DTAAUT').Value := Null;

    qryAux.ParamByName('PNDPEC').AsInteger  := 0 ;

    If (strEspDoc = 'ME') Then //tpEmis - Forma de emissão do MDF-e: 1- Normal, 2-Contingência;
      qryAux.ParamByName('PNDPEC').AsInteger := IIF(( Copy(retorno.ChaveAcesso, 35, 1) = '2' ) Or (retorno.Contingencia),1,0)
    Else If (strEspDoc = 'NF') Then
    Begin
      If retorno.Contingencia Then
      Begin
        qryAux.ParamByName('PNDPEC').AsInteger := IIF( retorno.ContingenciaAutorizada = 'S', 0, 1 );
      End
    End
    Else
    Begin
      If retorno.OffLine Then
      Begin //NFCe Offline gera número de protocolo com valor zero enquanto não esta autorizado.
        qryAux.ParamByName('PNDPEC').AsInteger := IIF( StrToInt64Def(retorno.NumeroProtocolo, 0) > 0 , 0, 1 );
      End
      Else If retorno.Contingencia Then
      Begin
        qryAux.ParamByName('PNDPEC').AsInteger := IIF( fEmptyStr(retorno.NumeroProtocolo), 1, 0);
      End
    End;
  End
  Else
  Begin
    qryAux.ParamByName('STATUS').AsString  := strStsFalha;
    qryAux.ParamByName('ACESSO').Value     := Null;
    qryAux.ParamByName('DTAAUT').Value     := Null;
    qryAux.ParamByName('PNDPEC').AsInteger := fGetCampoDPECNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
  End;

  If (intViaNfe > -1) Then
    qryAux.ParamByName('VIANFE').AsInteger := intViaNfe;

  If Assigned(qryAux.Params.FindParam('PDSTDP')) Then
  Begin
    qryAux.ParamByName('PDSTDP').AsInteger := qryAux.ParamByName('PNDPEC').AsInteger;
  End;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TLibNfe.pGravarQRCodeCancelamento(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String; retornoNFE: TRetornoNFE);
  Var
    qryMovObs: TUniQuery;
    qryMovGer: TUniQuery;

    strAutInc: String;
    strTabela: String;
    strSQL: String;

    strImpressora: String;

    procedure pAbreQuery;
    begin
      qryMovGer.ParamByName('NUMDOC').AsString := strNumDoc;
      qryMovGer.ParamByName('ESPDOC').AsString := strEspDoc;
      qryMovGer.ParamByName('CODEMP').AsString := strCodEmp;
      qryMovGer.ParamByName('SERIE_').AsString := strSerie;
      qryMovGer.ParamByName('CODCLI').AsString := strCodCli;
      qryMovGer.ParamByName('TIP_FC').AsString := strTip_FC;
      qryMovGer.Open;
    end;
begin
  If fEmptyStr(retornoNFE.QRCode) Then
  Begin
    Exit;
  End;

  strTabela := '';
  strAutInc := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
  strSQL := strSQL + '  IF(:TIP_FC = "C", GER_CODCLI, GER_CODCLI) = :CODCLI AND ';
  strSQL := strSQL + '  GER_TIP_FC = :TIP_FC ';

  qryMovGer := fCriaQuery(Nil);
  qryMovGer.SQL.Add(strSQL);
  pAbreQuery;

  If Not qryMovGer.IsEmpty Then
  Begin
    strTabela := 'MOVOBS';
    strAutInc := qryMovGer.FieldByName('AUTOINCREM').AsString;
  End
  Else
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
    qryMovGer.Close;
    qryMovGer.SQL.Clear;
    qryMovGer.SQL.Add(strSQL);
    pAbreQuery;

    If Not qryMovGer.IsEmpty Then
    Begin
      strTabela := 'NOTOBS';
      strAutInc := qryMovGer.FieldByName('AUTOINCREM').AsString;
    End;
  End;

  FreeAndNil(qryMovGer);

  If Not fEmptyStr(strTabela) Then
  Begin
    qryMovObs := fCriaQuery(Nil);
    qryMovObs.SQL.Add('UPDATE ' + strTabela + ' SET ');
    qryMovObs.SQL.Add('  MOV_QRCCAN = :QRCODE, ');
    qryMovObs.SQL.Add('  MOV_PRTCAN = :PROTOC, ');
    qryMovObs.SQL.Add('  MOV_DPRCAN = :DPROTO, ');
    qryMovObs.SQL.Add('  MOV_ACECAN = :ACECAN, ');
    qryMovObs.SQL.Add('  MOV_CFECAN = :CFECAN ');
    qryMovObs.SQL.Add('WHERE ');
    qryMovObs.SQL.Add('  MOV_SEQGER = :SEQGER');

    qryMovObs.ParamByName('QRCODE').AsString := retornoNFE.QRCode;
    qryMovObs.ParamByName('PROTOC').AsString := retornoNFE.NumeroProtocolo;
    qryMovObs.ParamByName('DPROTO').AsDateTime := retornoNFE.DataAutorizacao;
    qryMovObs.ParamByName('ACECAN').AsString := retornoNFE.ChaveAcesso;
    qryMovObs.ParamByName('CFECAN').AsString := retornoNFE.NumeroCFe;
    qryMovObs.ParamByName('SEQGER').AsString := strAutInc;
    qryMovObs.ExecSQL;
    FreeAndNil(qryMovObs);
  End;

  strImpressora := fArqIniLocal(0, 'SATCFE', 'PATHDLL', '', fCfgSis('PATSAT') + '\opcoes_sat.ini');
  pImprimirCancelamentoSAT(strNumDoc, strEspDoc, strCodEmp, strCodCli,
    strSerie, strTip_FC, strImpressora);
end;

function TLibNfe.fRetornaNomeImpressora(strNomePonto: String): String;
  Var
    qryAux: TUniQuery;
begin
  Result := strNomePonto;
  qryAux := fCriaQuery(Nil);
  
  If fCampoExiste('PONIMP', 'PON_NOMIMP', True) Then
  Begin
    If VS_SpoolImpressaoCitel Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT PON_NOMIMP ');
      qryAux.SQL.Add('FROM PONIMP       ');
      qryAux.SQL.Add('WHERE PON_NOMPON = :NOMPON ');
      qryAux.SQL.Add('  AND PON_CODEMP = :CODEMP ');
      qryAux.SQL.Add('  AND PON_SPOIMP = "S"     ');

      qryAux.ParamByName('NOMPON').AsString := Result;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryAux.Open;
    End;

    If (Not qryAux.Active) Or qryAux.IsEmpty Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT PON_NOMIMP ');
      qryAux.SQL.Add('FROM PONIMP       ');
      qryAux.SQL.Add('WHERE PON_NOMPON = :NOMPON ');
      qryAux.SQL.Add('  AND PON_CODEMP = :CODEMP ');

      qryAux.ParamByName('NOMPON').AsString := Result;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryAux.Open;
    End;

    If Not fEmptyStr(qryAux.FieldByName('PON_NOMIMP').AsString) Then
    Begin
      Result := qryAux.FieldByName('PON_NOMIMP').AsString;
    End;
  End;

  FreeAndNil(qryAux);
end;

function TLibNfe.fRetornaNumeroDocumento(strEspDoc, strCodEmp, strSerie,
  strAcesso: String): String;
var
  qryNumDoc: TUniQuery;
begin
  Result := EmptyStr;
  qryNumDoc := fCriaQuery;

  try
    qryNumDoc.Close;
    qryNumDoc.SQL.Clear;
    qryNumDoc.SQL.Add('SELECT NFE_NUMDOC');
    qryNumDoc.SQL.Add('FROM LOGNFE');
    qryNumDoc.SQL.Add('WHERE NFE_ESPDOC = :ESPDOC');
    qryNumDoc.SQL.Add('AND NFE_CODEMP = :CODEMP');
    qryNumDoc.SQL.Add('AND NFE_SERIE_ = :SERIE');
    qryNumDoc.SQL.Add('AND NFE_ACESSO = :ACESSO');

    qryNumDoc.ParamByName('ESPDOC').AsString := strEspDoc;
    qryNumDoc.ParamByName('CODEMP').AsString := strCodEmp;
    qryNumDoc.ParamByName('SERIE').AsString  := strSerie;
    qryNumDoc.ParamByName('ACESSO').AsString := strAcesso;

    qryNumDoc.Open;

    if not qryNumDoc.IsEmpty then
    begin
      Result := qryNumDoc.FieldByName('NFE_NUMDOC').AsString;
    end;
  finally
    FreeAndNil(qryNumDoc);
  end;
end;

function TLibNfe.fNotaFiscalJaAutorizada(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  With qryAux, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT ');
    Add('  COUNT(*) ');
    Add('FROM ');
    Add('  LOGNFE ');
    Add('  INNER JOIN CADFIS ON FIS_NUMDOC = NFE_NUMDOC AND ');
    Add('                       FIS_ESPDOC = NFE_ESPDOC AND ');
    Add('                       FIS_CODEMP = NFE_CODEMP AND ');
    Add('                       FIS_FORCLI = NFE_CODCLI AND ');
    Add('                       FIS_TIP_FC = NFE_TIP_FC AND ');
    Add('                       IFNULL(FIS_SERIE_,"") = IFNULL(NFE_SERIE_, "") ');    
    Add('WHERE ');
    Add('  NFE_STATUS = "AT"    AND ');
    Add('  NFE_NUMDOC = :NUMDOC AND ');
    Add('  NFE_ESPDOC = :ESPDOC AND ');
    Add('  NFE_CODEMP = :CODEMP AND ');
    Add('  NFE_TIP_FC = :TIP_FC AND ');
    Add('  NFE_CODCLI = :CODCLI AND ');
    Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ AND ');
    Add('  IFNULL(FIS_ACESSO, "") <> "" ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('SERIE_').AsString := strSerie;
    ParamByName('TIP_FC').AsString := strTip_FC;

    Open;

    Result := (Fields[0].AsInteger > 0);
  End;

  FreeAndNil(qryAux);
end;

procedure pCarregaNFCePendente(qryNFCe: TUniQuery; intTempoEmSegundosPendente: Integer = -1; strLisAutInc: String='');

 procedure pIncluiSentencaTempoPendente(strTabela: String);
 begin
   qryNFCe.SQL.Add(' AND (/*AUTINC*/(TIMESTAMPDIFF(SECOND, LOGNFE.NFE_HORINI, CONCAT(DATE_FORMAT(CURRENT_DATE, "%Y-%m-%d")," ",DATE_FORMAT(CURRENT_TIME, "%H:%i:%s"))) > '+IntToStr(intTempoEmSegundosPendente)+') )');
   If Not strLisAutInc.IsEmpty Then
     qryNFCe.SQL.Text := AnsiReplaceStr(qryNFCe.SQL.Text, '/*AUTINC*/', strTabela+'.AUTOINCREM IN ('+strLisAutInc+') OR ');
   qryNFCe.SQL.Text := AnsiReplaceStr(qryNFCe.SQL.Text, '/*AUTINC*/', ''); 
 end;
 
begin
  pAtualizaNumereroSerieVaziaSatIntegrador(VS_NumSerSat) ;

  qryNFCe.SQL.Clear;
  qryNFCe.SQL.Add('SELECT ');
  qryNFCe.SQL.Add('  MOVGER.AUTOINCREM AS AUTINC, ');
  qryNFCe.SQL.Add('  GER_VLRCON AS VLRCON, ');
  qryNFCe.SQL.Add('  GER_NUMDOC AS NUMDOC, ');
  qryNFCe.SQL.Add('  GER_ESPDOC AS ESPDOC, ');
  qryNFCe.SQL.Add('  GER_CODEMP AS CODEMP, ');
  qryNFCe.SQL.Add('  GER_SERIE_ AS SERIE_, ');
  qryNFCe.SQL.Add('  GER_CODCLI AS CODCLI, ');
  qryNFCe.SQL.Add('  GER_TIP_FC AS TIP_FC, ');
  qryNFCe.SQL.Add('  GER_NOMCON AS NOMCON, ');
  qryNFCe.SQL.Add('  NFE_OBSERV AS OBSERV, ');
  qryNFCe.SQL.Add('  NFE_STATUS AS STATUS, ');
  qryNFCe.SQL.Add('  "MOVGER"   AS TABELA  ');
  qryNFCe.SQL.Add('FROM ');
  qryNFCe.SQL.Add('  MOVGER ');
  qryNFCe.SQL.Add('JOIN LOGNFE ON ');
  qryNFCe.SQL.Add('  NFE_NUMDOC = GER_NUMDOC AND ');
  qryNFCe.SQL.Add('  NFE_ESPDOC = GER_ESPDOC AND ');
  qryNFCe.SQL.Add('  NFE_CODEMP = GER_CODEMP AND ');
  qryNFCe.SQL.Add('  NFE_CODCLI = GER_CODCLI AND ');
  qryNFCe.SQL.Add('  IFNULL(NFE_SERIE_, "") = IFNULL(GER_SERIE_, "") ');
  qryNFCe.SQL.Add('WHERE GER_ESPDOC = "IF" ');
  qryNFCe.SQL.Add('  AND GER_CODEMP = :CODEMP ');
  qryNFCe.SQL.Add('  AND NFE_STATUS IN ("OF", "EE", "GE") ');
  If (intTempoEmSegundosPendente > 0) Then
    pIncluiSentencaTempoPendente('MOVGER');

  qryNFCe.SQL.Text := qryNFCe.SQL.Text + ' UNION ALL ' + AnsiReplaceStr(qryNFCe.SQL.Text, 'MOVGER', 'NOTGER');

  If (Not fCfgSis('USNFCE', varBoolean)) And fUsaSat Then
  Begin
    qryNFCe.SQL.Add(' UNION ALL ');
    qryNFCe.SQL.Add('SELECT ');
    qryNFCe.SQL.Add('  CADFIS.AUTOINCREM AS AUTINC, ');
    qryNFCe.SQL.Add('  FIS_BASIC1 AS VLRCON, ');
    qryNFCe.SQL.Add('  FIS_NUMDOC AS NUMDOC, ');
    qryNFCe.SQL.Add('  FIS_ESPDOC AS ESPDOC, ');
    qryNFCe.SQL.Add('  FIS_CODEMP AS CODEMP, ');
    qryNFCe.SQL.Add('  FIS_SERIE_ AS SERIE_, ');
    qryNFCe.SQL.Add('  FIS_FORCLI AS CODCLI, ');
    qryNFCe.SQL.Add('  FIS_TIP_FC AS TIP_FC, ');
    qryNFCe.SQL.Add('  CLI_NOMCLI AS NOMCON, ');
    qryNFCe.SQL.Add('  LOGNFE.NFE_OBSERV AS OBSERV, ');
    qryNFCe.SQL.Add('  LOGNFE.NFE_STATUS AS STATUS, ');
    qryNFCe.SQL.Add('  "CADFIS"   AS TABELA ');
    qryNFCe.SQL.Add('FROM ');
    qryNFCe.SQL.Add('  CADFIS ');
    qryNFCe.SQL.Add('JOIN CADCLI ON ');
    qryNFCe.SQL.Add('  CLI_CODCLI = FIS_FORCLI ');
    qryNFCe.SQL.Add('JOIN LOGNFE ON ');
    qryNFCe.SQL.Add('  LOGNFE.NFE_NUMDOC = FIS_NUMDOC AND ');
    qryNFCe.SQL.Add('  LOGNFE.NFE_ESPDOC = FIS_ESPDOC AND ');
    qryNFCe.SQL.Add('  LOGNFE.NFE_CODEMP = FIS_CODEMP AND ');
    qryNFCe.SQL.Add('  LOGNFE.NFE_CODCLI = FIS_FORCLI AND ');
    qryNFCe.SQL.Add('  IFNULL(LOGNFE.NFE_SERIE_, "") = IFNULL(FIS_SERIE_, "") ');

    if fUsaIntegradorSatCitel then
    begin
      qryNFCe.SQL.Add('JOIN LOGSAT AS LS ON ');
      qryNFCe.SQL.Add('  LS.NFE_NUMDOC = FIS_NUMDOC AND ');
      qryNFCe.SQL.Add('  LS.NFE_ESPDOC = FIS_ESPDOC AND ');
      qryNFCe.SQL.Add('  LS.NFE_CODEMP = FIS_CODEMP AND ');
      qryNFCe.SQL.Add('  LS.NFE_CODCLI = FIS_FORCLI AND ');
      qryNFCe.SQL.Add('  IFNULL(LS.NFE_SERIE_, "") = IFNULL(FIS_SERIE_, "") AND ');
      qryNFCe.SQL.Add('  LS.NFE_TIP_FC = FIS_TIP_FC ');
    end ;

    qryNFCe.SQL.Add('WHERE FIS_ESPDOC = "IF" ');
    qryNFCe.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
    qryNFCe.SQL.Add('  AND FIS_TIP_FC = "C" ');
    qryNFCe.SQL.Add('  AND FIS_NFCOMP = "S" ');
    qryNFCe.SQL.Add('  AND LOGNFE.NFE_STATUS IN ("OF", "EE", "GE") ');
    if fUsaIntegradorSatCitel then
    begin
      qryNFCe.SQL.Add('  AND (LS.NFE_NUMSER = :NUMSER OR LS.NFE_NUMSER IS NULL) ');
      qryNFCe.ParamByName('NUMSER').AsString := VS_NumSerSat ;
    end ;
    If (intTempoEmSegundosPendente > 0) Then
      pIncluiSentencaTempoPendente('CADFIS');
  End;

  qryNFCe.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryNFCe.Open;
end;

function fNFCePendente(strNumDoc, strCodEmp, strCodCli, strTabela: String): Boolean;
  Var
    qryNFCe : TUniQuery;
begin
  qryNFCe := fCriaQuery(Nil);
  Try
    If (strTabela <> 'CADFIS') Then
    Begin
      qryNFCe.SQL.Clear;
      qryNFCe.SQL.Add(' SELECT COUNT(*) AS CNT ');
      qryNFCe.SQL.Add('   FROM ' + strTabela + ' ');
      qryNFCe.SQL.Add('   JOIN LOGNFE ON NFE_NUMDOC = GER_NUMDOC ');
      qryNFCe.SQL.Add('              AND NFE_ESPDOC = GER_ESPDOC ');
      qryNFCe.SQL.Add('              AND NFE_CODEMP = GER_CODEMP ');
      qryNFCe.SQL.Add('              AND NFE_CODCLI = GER_CODCLI ');
      qryNFCe.SQL.Add('              AND IFNULL(NFE_SERIE_, "") = IFNULL(GER_SERIE_, "") ');
      qryNFCe.SQL.Add('  WHERE GER_ESPDOC = "IF" ');
      qryNFCe.SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
      qryNFCe.SQL.Add('    AND GER_CODCLI = :CODCLI ');
      qryNFCe.SQL.Add('    AND GER_CODEMP = :CODEMP ');
      qryNFCe.SQL.Add('    AND (NFE_STATUS = "EE" OR NFE_STATUS = "GE" OR NFE_STATUS = "OF") ');
    End
    Else
    Begin
      qryNFCe.SQL.Add(' SELECT COUNT(*) AS CNT ');
      qryNFCe.SQL.Add('   FROM CADFIS ');
      qryNFCe.SQL.Add('   JOIN LOGNFE ON NFE_NUMDOC = FIS_NUMDOC ');
      qryNFCe.SQL.Add('              AND NFE_ESPDOC = FIS_ESPDOC ');
      qryNFCe.SQL.Add('              AND NFE_CODEMP = FIS_CODEMP ');
      qryNFCe.SQL.Add('              AND NFE_CODCLI = FIS_FORCLI ');
      qryNFCe.SQL.Add('              AND IFNULL(NFE_SERIE_, "") = IFNULL(FIS_SERIE_, "") ');
      qryNFCe.SQL.Add('  WHERE FIS_ESPDOC = "IF" ');
      qryNFCe.SQL.Add('    AND FIS_NUMDOC = :NUMDOC ');
      qryNFCe.SQL.Add('    AND FIS_TIP_FC = "C" ');
      qryNFCe.SQL.Add('    AND FIS_FORCLI = :CODCLI ');
      qryNFCe.SQL.Add('    AND FIS_CODEMP = :CODEMP ');
      qryNFCe.SQL.Add('    AND FIS_NFCOMP = "S" ');
      qryNFCe.SQL.Add('    AND (NFE_STATUS = "EE" OR NFE_STATUS = "GE" OR NFE_STATUS = "OF") ');
    End;

    qryNFCe.ParamByName('NUMDOC').AsString := strNumDoc;
    qryNFCe.ParamByName('CODCLI').AsString := strCodCli;
    qryNFCe.ParamByName('CODEMP').AsString := strCodEmp;
    qryNFCe.Open;
    Result := (qryNFCe.FieldByName('CNT').AsInteger > 0);
    qryNFCe.Close;
  Finally
    FreeAndNil(qryNFCe);
  End;
end;

function fJaCancelouLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strNumSer: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryAux.SQL.Add('   FROM LOGSAT ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('    AND NFE_NUMSER = :NUMSER ');
    qryAux.SQL.Add('    AND NFE_TIPINT = "CN" ');
    qryAux.SQL.Add('    AND NFE_STATUS = "OK" ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('NUMSER').AsString := strNumSer;
    qryAux.Open;
    Result := (qryAux.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fReenviarLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strTipInt, strNumSer, strMotCan, strImpres: String): Boolean;
  Var
    qryAux: TUniQuery;
    LblnImpressExiste: Boolean ;
begin
  LblnImpressExiste := fCampoExiste('LOGSAT', 'NFE_IMPRES', True) ;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' SELECT * ');
    qryAux.SQL.Add('   FROM LOGSAT ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Insert;
      qryAux.FieldByName('NFE_NUMDOC').AsString := strNumDoc;
      qryAux.FieldByName('NFE_ESPDOC').AsString := strEspDoc;
      qryAux.FieldByName('NFE_CODEMP').AsString := strCodEmp;
      qryAux.FieldByName('NFE_CODCLI').AsString := strCodCli;
      qryAux.FieldByName('NFE_SERIE_').AsString := strSerie;
      qryAux.FieldByName('NFE_TIP_FC').AsString := strTip_FC;
      qryAux.FieldByName('NFE_NUMSER').AsString := strNumSer;
      if LblnImpressExiste then
        qryAux.FieldByName('NFE_IMPRES').AsString := strImpres;
    End
    Else
      qryAux.Edit;

    qryAux.FieldByName('NFE_TIPINT').AsString := strTipInt;
    qryAux.FieldByName('NFE_MOTCAN').AsString := strMotCan;
    qryAux.FieldByName('NFE_STATUS').AsString := 'GE';
    qryAux.FieldByName('NFE_DTACAD').AsDateTime := VS_Date + fTime();
    qryAux.Post;

    Result := True;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGravarLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strTipInt, strNumSer, strMotCan, strImpres: String): Boolean;
Var
  qryAux: TUniQuery;
  LblnImpressExiste: Boolean ;
begin
  LblnImpressExiste := fCampoExiste('LOGSAT', 'NFE_IMPRES', True) ;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' SELECT * ');
    qryAux.SQL.Add('   FROM LOGSAT ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('    AND NFE_NUMSER = :NUMSER ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('NUMSER').AsString := strNumSer;
    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      qryAux.Insert;
      qryAux.FieldByName('NFE_NUMDOC').AsString := strNumDoc;
      qryAux.FieldByName('NFE_ESPDOC').AsString := strEspDoc;
      qryAux.FieldByName('NFE_CODEMP').AsString := strCodEmp;
      qryAux.FieldByName('NFE_CODCLI').AsString := strCodCli;
      qryAux.FieldByName('NFE_SERIE_').AsString := strSerie;
      qryAux.FieldByName('NFE_TIP_FC').AsString := strTip_FC;
      qryAux.FieldByName('NFE_NUMSER').AsString := strNumSer;
      if LblnImpressExiste then
        qryAux.FieldByName('NFE_IMPRES').AsString := strImpres;
    End
    Else
      qryAux.Edit;

    qryAux.FieldByName('NFE_TIPINT').AsString := strTipInt;
    qryAux.FieldByName('NFE_MOTCAN').AsString := strMotCan;
    qryAux.FieldByName('NFE_STATUS').AsString := 'GE';
    qryAux.FieldByName('NFE_DTACAD').AsDateTime := VS_Date + fTime();
    qryAux.Post;

    Result := True;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fVoltaStatusAnterior(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strTipInt, strNumSer: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' UPDATE LOGSAT ');
    qryAux.SQL.Add('    SET NFE_MOTCAN = :MOTCAN, ');
    qryAux.SQL.Add('        NFE_STATUS = :STATUS, ');
    qryAux.SQL.Add('        NFE_TIPINT = :NTPINT  ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC  ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC  ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP  ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI  ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_  ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC  ');
    qryAux.SQL.Add('    AND NFE_TIPINT = :TIPINT  ');
    qryAux.SQL.Add('    AND NFE_NUMSER = :NUMSER  ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('TIPINT').AsString := strTipInt;
    qryAux.ParamByName('NUMSER').AsString := strNumSer;
    qryAux.ParamByName('MOTCAN').Value := Null;
    qryAux.ParamByName('STATUS').AsString := 'OK';
    qryAux.ParamByName('NTPINT').AsString := 'EV';
    qryAux.ExecSQL;

    Result := True;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function fSATCancelado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strNumSer: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add('SELECT COUNT(*) AS QTDE FROM LOGSAT ');
    qryAux.SQL.Add('WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('  AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('  AND NFE_TIP_FC = :TIP_FC ');
    qryAux.SQL.Add('  AND NFE_NUMSER = :NUMSER ');
    qryAux.SQL.Add('  AND NFE_TIPINT = :TIPINT ');
    qryAux.SQL.Add('  AND NFE_STATUS = :STATUS ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('NUMSER').AsString := strNumSer;
    qryAux.ParamByName('TIPINT').AsString := 'CN';
    qryAux.ParamByName('STATUS').AsString := 'OK';

    qryAux.Open;

    Result := (qryAux.FieldByName('QTDE').AsInteger > 0);

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLibNfe.fConsultaStatusDFe(strChaveAcesso, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
  Var
    service: INFEService;
    fonte: IFonteDados;
begin
  pCarregarDll('', strEspDoc, '', '', '', '');

  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC);

  service := fCriarNFEService(fonte);

  Result := service.fConsultaStatusDFe(strChaveAcesso);
end;

function TLibNfe.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
  Var
    service: INFEService;
    fonte: IFonteDados;
begin
  pCarregarDll('', strEspDoc, '', '', '', '');

  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC);

  service := fCriarNFEService(fonte);

  Result := service.fConsultaStatusCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie);
end;

function TLibNfe.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strCodigoEmpresa, strCodigoCliente, strTipo_FC : String; const strModeloFiscal : String = '55'): String;
  Var
    service: INFEService;
    fonte: IFonteDados;
    strEspDoc : String;
begin
  pCarregarDll('', '', '', '', '', '');

  pSetaConfiguracoes(confignfe);

  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(confignfe);

  If (strModeloFiscal = '55') Then
    strEspDoc := 'NF'
  Else If (strModeloFiscal = '65') Then
    strEspDoc := 'IF'
  Else
    Raise Exception.Create('Modelo fiscal informado não é valido!');

  fonte := fCriarFonteDadosEmitenteBD(frmModulo.GetCurrentConnection, strNumeroDocumento, strEspDoc, strCodigoEmpresa, strCodigoCliente, strNumeroSerie, strTipo_FC);

  service := fCriarNFEService(fonte);

  Result := service.fConsultaStatusInutilizado(strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strModeloFiscal);
end;

class function TLibNfe.fDefinirPontoDeImpressao(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli : String) : String;
begin
  {*********************************************************************}
  {* NA EXPEDIÇÃO DE ROMANEIO, O SISTEMA GERA DIVERSOS DESMEMBRAMENTOS *}
  {* DE NF/MI, MAS DEVE PEDIR O PONTO DE IMPRESSÃO SOMENTE NO 1º DOC   *}
  {******************************************************************MM*}
  If VS_blnUsaPonImp Then
  Begin
    If fEmptyStr(VS_strPonImp) Then
      VS_strPonImp := fRetPontoImpressao(strEspDoc, strCodEmp);

    Result := VS_strPonImp;
  End
  Else
    Result := fRetPontoImpressao(strEspDoc, strCodEmp);
end;

function fConsultaStatusDFe(strChaveAcesso, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(strCodEmp);
  Try
    Try
      Result := libnfe.fConsultaStatusDFe(strChaveAcesso, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
    Except
      Result := '';
    End;
  Finally
    FreeAndNil(libnfe);
  End;
end;

function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(strCodEmp);
  Try
    Try
      Result := libnfe.fConsultaStatusCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
    Except
      Result := '';
    End;
  Finally
    FreeAndNil(libnfe);
  End;
end;

function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strCodigoEmpresa, strCodigoCliente, strTipo_FC : String; const strModeloFiscal : String = '55'): String;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    Try
      Result := libnfe.fConsultaStatusInutilizado(strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strCodigoEmpresa, strCodigoCliente, strTipo_FC, strModeloFiscal);
    Except
      Result := '';
    End;
  Finally
    FreeAndNil(libnfe);
  End;
end;

function fTemDocumentosPendentesDeAutorizacao(const strCodEmp : String) : Boolean;
  Var
    qryLogNfe : TUniQuery;
begin
  qryLogNfe := fCriaQuery(Nil);
  Try
    qryLogNfe.Close;
    qryLogNfe.SQL.Clear;
    qryLogNfe.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryLogNfe.SQL.Add('   FROM LOGNFE ');
    qryLogNfe.SQL.Add('  WHERE NFE_CODEMP = :CODEMP ');
    qryLogNfe.SQL.Add('    AND NFE_STATUS IN ("OF", "EE", "GE") ');
    qryLogNfe.ParamByName('CODEMP').AsString := strCodEmp;
    qryLogNfe.Open;
    Result := (qryLogNfe.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(qryLogNfe);
  End;
end;

function fDataEmissaoDocumentoFiscal(const strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc : String) : TDate;
  Var
    dtaDtaEnt : TDate;
begin
  dtaDtaEnt := fCampoTabela('FIS_DTAENT', 'CADFIS',
    ['FIS_NUMDOC', 'FIS_ESPDOC', 'FIS_CODEMP', 'FIS_FORCLI', 'FIS_SERIE_', 'FIS_TIP_FC', 'FIS_ORIDOC'],
    [strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc, 'V'], False);
  If fDataValida(dtaDtaEnt) Then
    Result := dtaDtaEnt
  Else
    Result := 0;
end;

function fCarregarViaNfeGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Integer;
  Var
    qryAux: TUniQuery;
begin
  Result := -1;

  If (strEspDoc <> 'IF') Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT COALESCE(NFE_VIANFE, -1) ');
    qryAux.SQL.Add('  FROM LOGNFE                   ');
    qryAux.SQL.Add(' WHERE NFE_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('       NFE_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('       NFE_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('       NFE_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('       IFNULL(NFE_SERIE_,"") = :SERIE_ AND ');
    qryAux.SQL.Add('       NFE_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
      Result := qryAux.Fields[0].AsInteger;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fEnviaXmlFit(const strArqXML: String): TRetornoNFE;
  Var
    libNfe: TLibNfe;
begin
  libNfe := TLibNfe.Create(VS_strCodEmp);
  Try
    Result := libNfe.fEnviaXmlFit(strArqXML);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fInsucessoNaEntregaConhecimento(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fInsucessoNaEntregaConhecimentoEletronico(strNumCTe, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fCancelamentoInsucessoNaEntregaConhecimento(strNumCTe: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fCancelamentoInsucessoNaEntregaConhecimentoEletronico(strNumCTe);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fConfirmacaoDeEntregaConhecimento(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fConfirmacaoDeEntregaConhecimentoEletronico(strNumCTe, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fCancelamentoConfirmacaoDeEntregaConhecimento(strNumCTe: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fCancelamentoConfirmacaoDeEntregaConhecimentoEletronico(strNumCTe);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fConfirmacaoDeEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fConfirmacaoDeEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fCancelamentoConfirmacaoDeEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fCancelamentoConfirmacaoDeEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fInsucessoNaEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fInsucessoNaEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fCancelamentoInsucessoNaEntregaNFe(strNumDoc, strEspDoc, strCodEmp, strSerie: String; var strMensagem: String): Boolean;
var
  libNfe: TLibNfe;
  retornoNFE: TRetornoNFE;
begin
  libnfe := TLibNfe.Create(VS_strCodEmp);
  Try
    retornoNFE := libnfe.fCancelamentoInsucessoNaEntregaNFeEletronico(strNumDoc, strEspDoc, strCodEmp, strSerie);

    Result := retornoNFE.Sucesso;

    strMensagem := retornoNFE.Mensagem;
  Finally
    FreeAndNil(libNfe);
  End;
end;

initialization
  TLibNFe.OnBeforeSetPontoImpressao := nil;

end.
