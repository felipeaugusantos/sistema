unit untLibNfe;

{
  CÓDIGOS DO STATUS DO LOGNFE:

  AT: NOTA AUTORIZADA
  CN: NOTA CANCELADA
  GE: GEROU ENVIO. PAINEL IRÁ PROCESSAR O RETORNO
  EE: ERRO NO ENVIO. PAINEL DISPONIBILIZARÁ FUNÇÃO PARA ENVIAR NOTA NOVAMENTE
  GC: GEROU CANCELAMENTO. PAINEL IRÁ PROCESSAR O RETORNO
  EC: ERRO NO CANCELAMENTO. PAINEL DISPONIBILIZARÁ FUNÇÃO PARA ENVIAR CANCELAMENTO
      NOVAMENTE.
  DN: DENEGADA NAO CANCELADA NO SISTEMA (AUTCOM)
  DC: DENEGADA CANCELADA NO SISTEMA (AUTCOM)
  IN: INUTILIZADA
  AM: MANIFESTO AUTORIZADO
  GM: MANIFESTO GERADO
  EM: ERRO NO MANIFESTO
}

interface

uses
{$IFDEF LINUX}
  untFuncoesDll,
{$ELSE}
  Dialogs, Windows, Forms, Controls,
{$ENDIF}
  untInterfaces, untConfigNFE, SysUtils, DateUtils,
  {$IF Defined(UNIDAC)}
    Uni,
  {$ELSE}
    ZConnection, ZDataset,
  {$IFEND}
  Variants, StrUtils, Classes, TypInfo,
  untInterfacesManifestoEletronico, untInterfacesConhecimentoEletronico;


type
  TInfParaLogNfe = Record
    intViaNfe : Integer;
    intPndPec : Integer;
    dtaDtaEnt : TDate;
    strExiFis : String;
    strJahAut : String;
    strPonImp : String;
end;

{$IFDEF LINUX}
var
  pSetaConfiguracoesPainel: procedure(objCfgNFE: TConfiguracoesNFE);
  pSetaConfiguracoes: procedure(objCfgNFE: TConfiguracoesNFE);
  pCarregaConfiguracoesLib: procedure(Database: {$IF Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND});
  fCriarFonteDadosBD: function(Database: TUniConnection; strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall;
  fCriarFonteDadosEmitenteBD: function(Database: TUniConnection; strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados;
  fCriarNFEService: function(fonteDados: IFonteDados): INFEService;
  fCriarNFEAdministrativoService: function(fonteDados: IFonteDados): INFEAdministrativoService;
  fCriarManifestoEletronicoService: function(fonteDados: IFonteDadosManifesto): IManifestoEletronicoSerivce;
  fCriarFonteDadosManifesto: function(Database: TUniConnection): IFonteDadosManifesto;
  fCriarConhecimentoEletronicoService: function(fonteDados: IFonteDadosConhecimento; fonteDadosBD: IFonteDados): IConhecimentoEletronicoService;
  fCriarFonteDadosConhecimento: function(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): IFonteDadosConhecimento;
  fSVN_RevisionLibNfe: function: String;
  pSetVirtualUIPrintPDF: procedure(AObj: IVirtualUIPrintPDF);
  pSetOnNotificarProgresso: procedure(AProc: TOnNotificarProgresso);
  dxInitializeLibNfe: procedure;
  dxFinalizeLibNfe: procedure;
  pSetaPidMD5DicSisLibNfe: procedure(const AstrPidMD5DicSis: string);
  fCriarEnviarArquivosService: function: IEnviarArquivosService;
  fCriarEnviarArquivosServiceConfigurado: function(objConfigSovos: TConfiguracoesNFE): IEnviarArquivosService;
  fCriarVerificarStatusServicoPelaUFServiceConfigurado: function(objConfigSovos: TConfiguracoesNFE): IVerificarStatusServicoService;
  fCriarImportaXMLTerceirosServiceFITConfigurado: function(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'; strSeparador: String=''): IImportaXMLTerceirosArquivosService;
  fCriarAuditarDocumentoServiceFIT: function(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IAuditarDocumentoServiceFIT;
  fCriarAmbienteEmpresaServiceFIT: function(AobjConfigSovos: TConfiguracoesNFE; AstrCNPJ: String; AstrValCfgMDEVAR: String='0'; AstrModelo: String = '55'): IAmbienteEmpresaService;
  fCriarEventoConciliacaoFinanceiraServiceFITConfigurado: function(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IEventoConciliacaoFinanceiraService;
{$ELSE}
  procedure pSetaConfiguracoesPainel(objCfgNFE: TConfiguracoesNFE); stdcall; External 'libNfe.dll';
  function fCriarFonteDadosBD(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc, strEspDoc,
           strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall; External 'libNfe.dll';
  function fCriarFonteDadosEmitenteBD(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc, strEspDoc,
           strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall; External 'libNfe.dll';
  function fCriarNFEService(fonteDados: IFonteDados): INFEService; stdcall; External 'libNfe.dll';
  function fCriarNFEAdministrativoService(fonteDados: IFonteDados): INFEAdministrativoService; stdcall; External 'libNfe.dll';
  function fNumeroSerial: Integer; stdcall; External 'libNfe.dll';
  function fCriarManifestoEletronicoService(fonteDados: IFonteDadosManifesto): IManifestoEletronicoSerivce; stdcall; External 'libNfe.dll';
  function fCriarFonteDadosManifesto(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): IFonteDadosManifesto; stdcall; External 'libNfe.dll';
  function fCriarConhecimentoEletronicoService(fonteDados: IFonteDadosConhecimento; fonteDadosBD: IFonteDados): IConhecimentoEletronicoService; stdcall; External 'libNfe.dll';
  function fCriarFonteDadosConhecimento(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): IFonteDadosConhecimento; stdcall; External 'libNfe.dll';
  procedure pCarregaConfiguracoesLib(Database: {$IF Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}); stdcall; External 'libNfe.dll';
  function fCriarEnviarArquivosService: IEnviarArquivosService; stdcall; External 'libNfe.dll';
  function fCriarEnviarArquivosServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IEnviarArquivosService; stdcall; External 'libNfe.dll';
  function fCriarVerificarStatusServicoPelaUFServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IVerificarStatusServicoService; stdcall; External 'libNfe.dll';
  function fCriarImportaXMLTerceirosServiceFITConfigurado(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'; strSeparador: String=''): IImportaXMLTerceirosArquivosService; stdcall; External 'libNfe.dll';
  function fCriarAuditarDocumentoServiceFIT(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IAuditarDocumentoServiceFIT; stdcall; External 'libNfe.dll';
  function fCriarAmbienteEmpresaServiceFIT(AobjConfigSovos: TConfiguracoesNFE; AstrCNPJ: String; AstrValCfgMDEVAR: String='0'; AstrModelo: String = '55'): IAmbienteEmpresaService; stdcall; External 'libNfe.dll';
  function fCriarEventoConciliacaoFinanceiraServiceFITConfigurado(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IEventoConciliacaoFinanceiraService; stdcall; External 'libNfe.dll';
  procedure pSetVirtualUIPrintPDF(AObj: IVirtualUIPrintPDF); stdcall; External 'libNfe.dll';
  {$IF Defined(UNIDAC)}
    procedure dxInitializeLibNfe; StdCall; External 'libNfe.dll';
    procedure dxFinalizeLibNfe; StdCall; External 'libNfe.dll';
    procedure pSetaPidMD5DicSisLibNfe(const AstrPidMD5DicSis: string); stdcall; external 'libNfe.dll';
  {$IFEND}
{$ENDIF}

  procedure pGravaNfeTempo(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie,
    strTip_FC: String; dtaIniOpe, dtaFimOpe: TDateTime; intCodEve: Integer; strDesEve: String;
    blnAtualizar: Boolean; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});

Type
  TOpcCliPro = (opcPdOrNf = 1, opcEtiqueta = 2);

Type
  TUtilizaCliPro = Set Of TOpcCliPro;

{***************************************}
{* INTERFACE ENTRE O AUTCOM E A LIBNFE *}
{************************************MV*}
Type
  TLibNfe = class(TObject)
    private

     {$IFNDEF LINUX}
      pSetaConfiguracoesBD: procedure(objCfgNFE: TConfiguracoesNFE); stdcall;
     {$ENDIF}
      fCriarFonteDadosBDSet: function(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}; strNumDoc, strEspDoc,
            strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall;

      Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};

      function fEnviarNotaInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strPontosImp: String): Boolean;
      function fEnviarCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strMotivo: String): Boolean;
      function fProcessarRetornoEnvioInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strImpressora: String): Boolean;
      function fProcessarRetornoCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String): Boolean;

      function fVerificarStatusNotaInterna(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String): TRetornoNFE;

      procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strStatus, strObserv: String; strPontoImpressao: String=''; retorno: TRetornoNFE=nil); overload;

      procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strStsSucesso, strStsFalha: String; retorno: TRetornoNFE;
        strPontoImpressao: String=''); overload;

      procedure pCarregarDll(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String; opOperacao: TOperacaoNFE);

      procedure pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String; retorno: TRetornoNFE; blnVerificaAbastecimento: Boolean = True);
      procedure pAtualizarDadosManifestoAutcom(strNumMan, strCodEmp: String;
        retorno: TRetornoNFE);

      procedure pAtualizarDadosConhecimentoAutcom(strNumCTe, strCodEmp: String; retorno: TRetornoNFE);

      procedure pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strMsgAdicional, strMsgAdicionalCom, strMsgAdicionalFis: String);

      {$HINTS OFF}
      function fNotaFiscalJaAutorizada(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String): Boolean;
      {$HINTS ON}
      function fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String): String;

      function fRetornaNomeImpressora(strNomePonto: String): String;

      procedure pAtualizaLogNfeDpecPendente(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String; retorno: TRetornoNFE);
      procedure pAtualizarSubNfs(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String; retorno: TRetornoNFE);

      function fEnviarManifestoEletronicoInterna(strNumMan, strEmpMan: String): Boolean;
      function fProcessarRetornoManifestoEletronicoInterna(strNumMan, strEmpMan: String): Boolean;

      function fEnviarConhecimentoEletronicoInterna(strNumCTe, strSerie: String): Boolean;
      function fProcessarRetornoConhecimentoEletronicoInterna(strNumCTe, strSerie: String): Boolean;

      function fGetCampoDPEC(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Integer;
      procedure pAcertaDataHoraEmissao(strNumDoc, strEspDoc, strCodEmp,
        strCodCli, strSerie, strTip_FC: String; dtaEmissao: TDateTime);
      procedure pAtualizarMensagensCupomFiscal(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC, strQRCode, strProtocolo, strObsFisco: String;
        dtaAutorizacao, dtaEmissao: TDateTime; blnNFCeOffLine: Boolean = False);

      {$HINTS OFF}
      function fExisteCadFis(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: string): boolean;
      {$HINTS ON}
      function fSerieManifesto(strEmpMan: String): string;
      function fUsaNotaServicoEletronicaEnotas: Boolean;
      procedure pAtualizaLogNfeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strStatus, strObserv: String);

      procedure pAtualizarDadosAutcomAbastecimento(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strCodCli, strTip_FC: String; retorno: TRetornoNFE);
      function fCarregarArquivoSAT(blnEnviar: Boolean; strChave, strNSerie: String): String;
      procedure pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String;
        blnEnviar: Boolean; retorno: TRetornoNFe);
      function fPodeImprimirSatIntegrador(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean ;
      function fImpressoraArqIniSatIntegrador: String;
      function fImpressoraLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
      procedure pBuscaInformacoesParaGravacaoLogNfe(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String; var recInfLog: TInfParaLogNfe);
    public
      function fEnviarNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String): Boolean;
      function fEnviarCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, strMotivo: String): Boolean;
      function fProcessarRetornoEnvio(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String): Boolean;
      function fProcessarRetornoCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String): Boolean;
      function fVerificarStatusNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String): TRetornoNFE;
      function fVerificarStatusServico(strCnpjEmitente,
        strIESEmitente: String): TRetornoStatusNFE; overload;
      function fVerificarStatusServico(strCnpjEmitente,
        strIESEmitente: String; var AError: string): TRetornoStatusNFE; overload;
      procedure pReimprimirDanfe(strChaveAcesso: String;
        strNumDocImp, strEspDocImp, strCodEmpImp, strSerieImp, strCodCliImp, strTip_FCImp: String);

      function fAcertaChaveAcessoNotaFiscal(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC: String; var blnErroRecusadaRejeitada: Boolean;
        var strMensagem: String; var blnContingenciaAutorizada: Boolean; blnRegenerando: Boolean=False): Boolean;

      function fNumeroSerialNfe: Integer;

      function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
        intTipo, intStatus: Integer): TStringList;

      function fEnviarManifestoEletronico(strNumMan, strEmpMan: String): Boolean;
      function fProcessarRetornoManifestoEletronico(strNumMan, strEmpMan: String): Boolean;

      function fEnviarConhecimentoEletronico(strNumCTe, strSerie: String): Boolean;
      function fProcessarRetornoConhecimentoEletronico(strNumCTe, strSerie: String): Boolean;

      function fStatusDocumento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
        strTip_FC: String): TRetornoNFE;

      function fConsultaCadastro(const strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;

      function fVerificarStatusServicoPelaUF(strUF: string; var strError: string): TRetornoStatusNFE; overload;
      function fVerificarStatusServicoPelaUF(strUF: string): TRetornoStatusNFE; overload;

      function fRetCodigoEmpresaNaFit: String;

      constructor Create(Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil);

      destructor Destroy; Override;

      class function fRetPontoImpressao: String;
      class function fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;

      class procedure pCarregaConfigNFE(Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
  End;

  function fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil;
    blnMostrarMsg: Boolean=True): Boolean;
  function fEnviarCancelamentoLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC: String; strMotivo: String = ''): Boolean;
  function fProcessarRetornoEnvioLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil;
    blnMostrarMsg: Boolean=True): Boolean;
  function fProcessarRetornoCancelamentoLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil;
      blnMostrarMsg: Boolean=True): Boolean;

  function fVerificarStatusNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC: String): TRetornoNFE;

  function fVerificarStatusServico(strCnpjEmitente,
    strIESEmitente: String; var strError: string): TRetornoStatusNFE; overload;

  function fVerificarStatusServico(strCnpjEmitente,
    strIESEmitente: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): TRetornoStatusNFE; overload;

  procedure pReimprimirDanfe(strChaveAcesso: String;
    strNumDocImp, strEspDocImp, strCodEmpImp, strSerieImp, strCodCliImp, strTip_FCImp: String);

  function fListagemNotasLibNfe(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
    intTipo, intStatus: Integer): TStringList;

  function fEnviarManifestoEletronico(strNumMan, strEmpMan: String): Boolean;
  function fProcessarRetornoManifestoEletronico(strNumMan: String;
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; strEmpMan: String=''): Boolean;

  function fTemNotaServicoAnteriorPendente(strNumDoc, strCodEmp: String; out strUltNot: string): Boolean;

  function fEnviarConhecimentoEletronico(strNumCTe, strSerie: String): Boolean;
  function fProcessarRetornoConhecimentoEletronico(strNumCTe, strSerie: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): Boolean;
  function fConsultaCadastro(const strUf, strCnpj, strIe: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): TRetornoConsultaCadastro;
  function fVerificarStatusServicoPelaUF(strUF: string; var strError: string): TRetornoStatusNFE; overload;
  function fVerificarStatusServicoPelaUF(strUF: string): TRetornoStatusNFE; overload;
  function fRetCodigoEmpresaNaFit: String;


Var
{$IFNDEF LINUX}
  handleBD: Cardinal;
{$ENDIF}
  VS_confignfe: TConfiguracoesNFE;

const
  MANIFESTO_STATUS_ERRO : String = 'EM';
  MANIFESTO_STATUS_GERADO : String = 'GM';
  CONHECIMENTO_STATUS_ERRO : String = 'CE';
  CONHECIMENTO_STATUS_GERADO : String = 'CG';

const
  MSG_NOTAS_SERVICO_ANTERIOR_NAO_AUTORIZADA =
    'Existe(m) nota(s) de serviços anteriores ainda não autorizadas. ' +
    'Por favor, reenvie primeiramente a nota %s e aguarde para que o painel tente autorizar as demais automaticamente. '+
    'Caso contrario, faça o reenvio manual da nota de menor número! Utilize F1 do Painel para Reenviar...';

implementation

uses
  untDicSis,
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untPontosImpressao,
  untModulo,
{$ENDIF}
{$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300) Or Defined(VER330)}
  System.UITypes, Data.DB;
{$ELSE}
  DB;
{$IFEND}

{**************************************}
{* FUNÇÃO AUXILIAR PARA ENVIAR A NOTA *}
{***********************************MV*}
function fEnviarNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil;
  blnMostrarMsg: Boolean=True ): Boolean;
Var
    libnfe: TLibNfe;
begin
  Try
    Try
      libnfe := TLibNfe.Create(Banco);
      Result := libnfe.fEnviarNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC);
    Finally
      FreeAndNil(libnfe);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If blnMostrarMsg Then
        Raise;
    End;
  End;
end;

{**************************************}
{* FUNÇÃO AUXILIAR PARA CANCELAR A    *}
{* NOTA.                              *}
{***********************************MV*}
function fEnviarCancelamentoLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; strMotivo: String = ''): Boolean;
  Var
    libnfe: TLibNfe;
begin
  Try
    libnfe := TLibNfe.Create;

    If fEmptyStr(strMotivo) Then
    Begin
      strMotivo := fRetornaMotivoCancelamento(strNumDoc, strEspDoc, strCodEmp,
        strSerie, strTip_FC);
    End;

    Result := libnfe.fEnviarCancelamento(strNumDoc, strEspDoc, strCodEmp,
      strSerie, strCodCli, strTip_FC, strMotivo);
  Finally
    FreeAndNil(libnfe);
  End;
end;

{**************************************}
{* FUNÇÃO AUXILIAR PARA VERIFICAR     *}
{* RETORNO DO ENVIO DA NOTA.          *}
{***********************************MV*}
function fProcessarRetornoEnvioLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil;
  blnMostrarMsg: Boolean=True): Boolean;
  Var
    libnfe: TLibNfe;
begin
  Try
    Try
      libnfe := TLibNfe.Create(Banco);
      Result := libnfe.fProcessarRetornoEnvio(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);
    Finally
      If Assigned(libnfe) Then
        FreeAndNil(libnfe);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If blnMostrarMsg Then
        Raise;
    End;
  End;

end;

{**************************************}
{* FUNÇÃO AUXILIAR PARA VERIFICAR     *}
{* RETORNO DO CANCELAMENTO DA NOTA.   *}
{***********************************MV*}
function fProcessarRetornoCancelamentoLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil;
  blnMostrarMsg: Boolean=True): Boolean;
  Var
    libnfe: TLibNfe;
begin
  Try
    Try
      libnfe := TLibNfe.Create(Banco);
      Result := libnfe.fProcessarRetornoCancelamento(strNumDoc, strEspDoc,
        strCodEmp, strSerie, strCodCli, strTip_FC);
    Finally
      FreeAndNil(libnfe);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      If blnMostrarMsg Then
        Raise;
    End;
  End;
end;

function fVerificarStatusNotaLibNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): TRetornoNFE;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create;

  Try
    Result := libnfe.fVerificarStatusNota(strNumDoc, strEspDoc,
      strCodEmp, strSerie, strCodCli, strTip_FC);
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
  FreeAndNil(libnfe);
end;

function fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strError: string): TRetornoStatusNFE;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(nil);
  Try
    Result := libnfe.fVerificarStatusServico(strCnpjEmitente, strIESEmitente, strError);
  Finally
    FreeAndNil(libnfe);
  End;
end;

function fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): TRetornoStatusNFE;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(Banco);

  Try
    Result := libnfe.fVerificarStatusServico(strCnpjEmitente, strIESEmitente);
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
  FreeAndNil(libnfe);
end;

{ TLibNfe }

constructor TLibNfe.Create(Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil);
begin
  inherited Create;

  If Assigned(Banco) Then
  Begin
    Self.Banco := Banco;
  End
  Else
  Begin
    Self.Banco := frmModulo.Database;
  End;

  Try
    pCarregaConfigNFE(Banco);
  Except
    On E: Exception Do
    Begin
      If Self.Banco = frmModulo.Database Then
      Begin
       {$IFDEF LINUX}
        Writeln('Atenção: não foi possível iniciar a libNfe.dll. Motivo: ' + E.Message);
       {$ELSE}
        MessageDlg('Atenção: não foi possível iniciar a libNfe.dll. Motivo: ' + E.Message, mtError, [mbOk], 0);
       {$ENDIF}
        Application.Terminate;
      End
      Else
        Raise;
    End;
  End;
end;

destructor TLibNfe.Destroy;
begin

  inherited;
end;

{**************************************}
{* ENVIA O CANCELAMENTO               *}
{***********************************MV*}
function TLibNfe.fEnviarCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMotivo: String): Boolean;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, opCancelamento);
  Result := fEnviarCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp,
    strSerie, strCodCli, strTip_FC, strMotivo)
end;

function TLibNfe.fProcessarRetornoConhecimentoEletronico(strNumCTe, strSerie: String): Boolean;
begin
  Result := fProcessarRetornoConhecimentoEletronicoInterna(strNumCTe, strSerie);
end;

{**************************************}
{* CANCELAMENTO (FUNÇÃO INTERNA).     *}
{***********************************MV*}
function TLibNfe.fEnviarCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strMotivo: String): Boolean;
  Var
    intContador: Integer;
    strErros: String;
    fonte: IFonteDados;
    service: INFEService;
    retornoNFE: TRetornoNFE;
    dtaHoraInicio: TDateTime;
begin
  pSetaConfiguracoesPainel(VS_confignfe);

 {$IFNDEF LINUX}
  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(VS_confignfe);
 {$ENDIF}

  If strEspDoc = 'IF' Then
    fonte := fCriarFonteDadosBDSet(Self.Banco, strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie, strTip_FC)
  else
    fonte := fCriarFonteDadosEmitenteBD(Self.Banco, strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie, strTip_FC);

  fonte.pSetaPathSatCitel(VS_PathSat);
  service := fCriarNFEService(fonte);

  pLogImp('cancelar > service.fCancelarNota = ' + strNumDoc);
  If fUsaSat And (strEspDoc = 'IF') And (fCfgSisPainel('SATCIT', Banco) = 'S') Then
  Begin
    Try
      Result := service.fCancelarNota(strNumDoc, strSerie, strMotivo);

      If Result Then
      Begin
        dtaHoraInicio := nOw;
        Sleep(1500);
        Repeat
          pLogImp('service.fProcessarCancelamento = ' + strNumDoc);
          retornoNFE := service.fProcessarCancelamento;
          Application.ProcessMessages;

          If SecondsBetween(nOw, dtaHoraInicio) > 120 Then
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
            retornoNFE.Mensagem, '', retornoNFE);

          pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC,
            False, retornoNFE);
        End
        Else
        begin
          pAtualizaMensagemLogSAT(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, retornoNFE.Mensagem);
          Raise Exception.Create('Não foi possível cancelar a nota: ' + retornoNFE.Mensagem);
        end;
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
        pAtualizaMensagemLogSAT(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'Erros: ' + strErros);
        Raise Exception.Create('Erro ao enviar cancelamento: ' + strErros);
      End;
      On E: Exception Do
      Begin
        pAtualizaMensagemLogSAT(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'Erro: ' + E.Message);
        raise;
      End;
    End;
  End
  Else
  Begin
    {**************************************}
    {* ENVIA SOLICITAÇÃO DE CANCELAMENTO. *}
    {***********************************MV*}
    Try
      Result := service.fCancelarNota(strNumDoc, strSerie, strMotivo);
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
        strTip_FC, 'GC', '');
    Except
      On E: ErrosValidacaoNFE Do
      Begin
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
          strTip_FC, 'EC', strErros);
        Raise Exception.Create('Erro ao enviar cancelamento: ' + strErros);
      End;

      On E: Exception Do
      Begin
        pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
          strTip_FC, 'EE', E.Message);
        Raise Exception.Create('Erro ao enviar documento: ' + #13#10 + E.Message);
      End;
    End;
  End;

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);

  pLogImp('cancelar < service.fCancelarNota = ' + strNumDoc);
end;

function TLibNfe.fEnviarConhecimentoEletronico(strNumCTe, strSerie: String): Boolean;
begin
  Result := fEnviarConhecimentoEletronicoInterna(strNumCTe, strSerie);
end;

function TLibNfe.fEnviarConhecimentoEletronicoInterna(strNumCTe, strSerie: String): Boolean;
var
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
  strErros: String;
  intContador: Integer;
  strStatusGravacaoLogNFe : string;
begin
    Try
      pSetaConfiguracoesPainel(VS_confignfe);

     {$IFNDEF LINUX}
      If (handleBD <> 0) Then
        pSetaConfiguracoesBD(VS_confignfe);
     {$ENDIF}

      fonte := fCriarFonteDadosConhecimento(Self.Banco);

      pCarregarDll('', '', '', '', '', '', opEnvio);
      fonteBD := fCriarFonteDadosBDSet(Self.Banco, strNumCTe, 'CT', VS_strCodEmp, '', strSerie, '');

      service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

      Result := service.fEnviarConhecimento(strNumCTe);

      If Result Then
        pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', CONHECIMENTO_STATUS_GERADO, '', '')
      Else
        pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', CONHECIMENTO_STATUS_ERRO, '', '');

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

        if (Pos('em processamento', AnsiLowerCase(strErros)) > 0) or
           (Pos('transmitida', AnsiLowerCase(strErros)) > 0) or
           (Pos('aguardando retorno', AnsiLowerCase(strErros)) > 0) or
           (Pos('processando/transmitindo', AnsiLowerCase(strErros)) > 0) then
          strStatusGravacaoLogNFe := CONHECIMENTO_STATUS_GERADO // Força o NfeStatus.exe verificar o retorno
        else
          strStatusGravacaoLogNFe := CONHECIMENTO_STATUS_ERRO;

        pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', strStatusGravacaoLogNFe, strErros);

        if (Pos('arquivo recebido com erros', AnsiLowerCase(strErros)) > 0) then
        begin
          Result := False;
          Exit;
        end;

        if (strStatusGravacaoLogNFe = CONHECIMENTO_STATUS_ERRO) then
          Raise Exception.Create('Erro ao enviar documento: ' + strErros)
        else
          Result := False;
      End;

      On E: Exception Do
      Begin
        pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', CONHECIMENTO_STATUS_ERRO, E.Message);
        Raise Exception.Create('Erro ao enviar documento: ' + E.Message);
      End;
    End;
end;

{**************************************}
{* ENVIA NOTA ELETRONICA.             *}
{***********************************MV*}
function TLibNfe.fEnviarNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): Boolean;
  Var
    strPontosImp: String;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, opEnvio);

  strPontosImp := fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

{  If fEmptyStr(strPontosImp) Then
  Begin
    strPontosImp := fRetPontoImpressao;
  End;}

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
    strUltNot: String;
    fonte: IFonteDados;
    service: INFEService;
begin
  Result := False;

  Try
    If (strEspDoc = 'NS') And fTemNotaServicoAnteriorPendente(strNumDoc, strCodEmp, strUltNot) Then
      Raise Exception.Create(Format(MSG_NOTAS_SERVICO_ANTERIOR_NAO_AUTORIZADA, [strUltNot]));

    pSetaConfiguracoesPainel(VS_confignfe);

   {$IFNDEF LINUX}
    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(VS_confignfe);
   {$ENDIF}

    fonte := fCriarFonteDadosBDSet(Self.Banco, strNumDoc, strEspDoc,
      strCodEmp, strCodCli, strSerie, strTip_FC);

    fonte.pSetaPathSatCitel(VS_PathSat);
    service := fCriarNFEService(fonte);

    fonte.pCarregarDados;

    If Not fEmptyStr(strPontosImp) Then
    Begin
      fonte.fDadosGerais.strPontoImpressao := strPontosImp;
    End;

    If strEspDoc <> 'IF' Then
    Begin
      Result := service.fEnviarNota;

      pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp, strSerie,
                                    strCodCli, strTip_FC,
                                    fonte.fDadosGerais.strMsgAdicional,
                                    fonte.fDadosGerais.strMsgAdicionalCom,
                                    fonte.fDadosGerais.strMsgAdicionalFis);
    End;

    pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
      strTip_FC, 'GE', '', strPontosImp);
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      pLogImp('ErrosValidacaoNFE: ' + E.Message);
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
        strTip_FC, 'EE', strErros, strPontosImp);
      Raise Exception.Create('Erro ao enviar documento: ' + strErros);
    End;

    On E: Exception Do
    Begin
      pLogImp(E.Message);
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
        strTip_FC, 'EE', E.Message, strPontosImp);
      Raise Exception.Create('Erro ao enviar documento: ' + #13#10 + E.Message);
    End;
  End;

end;

function TLibNfe.fExisteCadFis(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: string): boolean;
  var
    qryCadFis: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryCadFis := fCriaQuery(Nil, Self.Banco);
  try
    qryCadFis.SQL.Add('  SELECT COUNT(*) AS CNT ');
    qryCadFis.SQL.Add('    FROM CADFIS ');
    qryCadFis.SQL.Add('   WHERE FIS_NUMDOC = :NUMDOC ');
    qryCadFis.SQL.Add('     AND FIS_ESPDOC = :ESPDOC ');
    qryCadFis.SQL.Add('     AND FIS_CODEMP = :CODEMP ');
    qryCadFis.SQL.Add('     AND FIS_FORCLI = :FORCLI ');
    qryCadFis.SQL.Add('     AND FIS_TIP_FC = :TIP_FC ');
    qryCadFis.SQL.Add('     AND IFNULL(FIS_SERIE_, "") = :SERIE_ ');
    qryCadFis.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCadFis.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCadFis.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFis.ParamByName('FORCLI').AsString := strCodCli;
    qryCadFis.ParamByName('TIP_FC').AsString := strTip_FC;
    qryCadFis.ParamByName('SERIE_').AsString := strSerie;
    qryCadFis.Open;
    Result := (qryCadFis.FieldByName('CNT').AsInteger > 0);
    qryCadFis.Close;
  finally
    FreeAndNil(qryCadFis);
  end;
end;

function TLibNfe.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
  Var
    fonte: IFonteDados;
    service: INFEAdministrativoService;
begin
  If fNumeroSerialNfe >= 1 Then
  Begin
    pCarregarDll('', '', '', '', '', '', opEnvio);
    pSetaConfiguracoesPainel(VS_confignfe);
    fonte := fCriarFonteDadosEmitenteBD(Self.Banco, '', '', '', '', '', '');

    service := fCriarNFEAdministrativoService(fonte);
    Result := service.fListagemNotas(VS_strCodEmp, dtaDtaIni, dtaDtaFin, intTipo, intStatus);
  End
  Else
  Begin
    Result := TStringList.Create;
  End;
end;

function TLibNfe.fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): String;
begin
  Result := fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
    strSerie, strCodCli, strTip_FC);
end;

class function TLibNfe.fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): String;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := '';

  qryAux := fCriaQuery(Nil);
  Try
    If Not fCampoExiste('LOGNFE', 'NFE_PONIMP', qryAux.Connection) Then
    Begin
      Exit;
    End;

    If strEspDoc = 'ME' Then
    Begin
      qryAux.SQL.Add('SELECT NFE_PONIMP FROM LOGNFE WHERE ');
      qryAux.SQL.Add('NFE_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('NFE_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('NFE_CODEMP = :CODEMP     ');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    End
    Else
    Begin
      qryAux.SQL.Add('SELECT NFE_PONIMP FROM LOGNFE WHERE ');
      qryAux.SQL.Add('NFE_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('NFE_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('NFE_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('NFE_CODCLI = :CODCLI AND ');
      qryAux.SQL.Add('IFNULL(NFE_SERIE_," ") = :SERIE_ AND ');
      qryAux.SQL.Add('NFE_TIP_FC = :TIP_FC ');

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('SERIE_').AsString := strSerie;
      qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    End;

    qryAux.Open;

    Result := qryAux.FieldByName('NFE_PONIMP').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLibNfe.fRetornaNomeImpressora(strNomePonto: String): String;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := strNomePonto;

  qryAux := fCriaQuery(Nil, Self.Banco);
  Try
    If fCampoExiste('PONIMP', 'PON_NOMIMP', Self.Banco) Then
    Begin
      If (fArqIni(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N') Then
      Begin
        If fExisteConfiguracao('SPOIMP', Banco) Then
        Begin
          If fCfgSis('SPOIMP', varBoolean, '', Self.Banco) Then
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
        End;
      End;

      If (Not qryAux.Active) Or (qryAux.IsEmpty) Then
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
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLibNfe.fProcessarRetornoManifestoEletronico(strNumMan, strEmpMan: String): Boolean;
begin
  Result := fProcessarRetornoManifestoEletronicoInterna(strNumMan, strEmpMan);
end;

function TLibNfe.fProcessarRetornoManifestoEletronicoInterna(
  strNumMan, strEmpMan: String): Boolean;
  Var
    retornoNFE: TRetornoNFE;
    fonte: IFonteDadosManifesto;
    service: IManifestoEletronicoSerivce;
    strStsFalha: String;
    strImpressora: String;
begin
  Try
    If fEmptyStr(strEmpMan) Then
      strEmpMan := VS_strCodEmp;

    pSetaConfiguracoesPainel(VS_confignfe);

   {$IFNDEF LINUX}
    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(VS_confignfe);
   {$ENDIF}

    fonte := fCriarFonteDadosManifesto(Self.Banco);
    service := fCriarManifestoEletronicoService(fonte);

    pLogImp('fProcessarRetornoManifestoEletronicoInterna - fProcessarManifesto - inicio');

    strImpressora := fCarregarPontoImpressaoGravado(strNumMan, 'ME', strEmpMan, '', '', '');
    strImpressora := fRetornaNomeImpressora(strImpressora);

    retornoNFE := service.fProcessarManifesto(strNumMan, strImpressora);

    pLogImp('fProcessarRetornoManifestoEletronicoInterna - fProcessarManifesto - fim');

    If (retornoNFE.Sucesso) Then
    Begin
      pLogImp('fProcessarRetornoManifestoEletronicoInterna - pAtualizarDadosManifestoAutcom - inicio');
      pAtualizarDadosManifestoAutcom(strNumMan, strEmpMan, retornoNFE);
      pLogImp('fProcessarRetornoManifestoEletronicoInterna - pAtualizarDadosManifestoAutcom - fim');
    End
    Else If (retornoNFE.Aguardando) Then
      strStsFalha := 'GM'
    Else
    Begin
      strStsFalha := 'EM';
    End;

    pLogImp('fProcessarRetornoManifestoEletronicoInterna - pGravarLogNfe - inicio');
    pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '',
      '', 'AM', strStsFalha, retornoNFE);
    pLogImp('fProcessarRetornoManifestoEletronicoInterna - pGravarLogNfe - fim');

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', 'EM', 'Erro de programa: ' + E.Message);
      pLogImp('Exceção em fProcessarRetornoManifestoEletronicoInterna '+E.Message);
    End;
  End;

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

function TLibNfe.fPodeImprimirSatIntegrador(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
var
  LstrImpressoraLogSat: String;
  LstrImpressoraArqIni: String;
begin
  Result := False;

  pLogImp('fPodeImprimirSatIntegrador > ');

  if not fExisteConfiguracao('SATCIT', Banco) then
  begin
    pLogImp('fPodeImprimirSatIntegrador < Result=' + BoolToStr(Result)+' (CFG_SATCIT = (NÃO EXISTE))');
    Exit;
  end;

  if fCfgSisPainel('SATCIT', Banco) = 'N' then
  begin
    pLogImp('fPodeImprimirSatIntegrador < Result=' + BoolToStr(Result)+' (CFG_SATCIT = N)');
    Exit;
  end;

  LstrImpressoraLogSat := fImpressoraLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) ;
  LstrImpressoraArqIni := fImpressoraArqIniSatIntegrador ;

  pLogImp('LstrImpressoraLogSat: ' + LstrImpressoraLogSat);
  pLogImp('LstrImpressoraArqIni: ' + LstrImpressoraArqIni);

  if fEmptyStr(LstrImpressoraLogSat) then
  begin
    Result := True;

    pLogImp('fPodeImprimirSatIntegrador < Result=' + BoolToStr(Result)+' (LstrImpressoraLogSat = '')');
    Exit ;
  end;

  if LstrImpressoraLogSat <> LstrImpressoraArqIni then
  Begin
    pLogImp('fPodeImprimirSatIntegrador < Result=' + BoolToStr(Result)+' (LstrImpressoraLogSat <> LstrImpressoraArqIni)');
    Exit;
  End;

  Result := True;
  pLogImp('fPodeImprimirSatIntegrador < Result=' + BoolToStr(Result));

end;

function TLibNfe.fProcessarRetornoCancelamento(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): Boolean;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC,
    opProcessaCancelamento);
  Result := fProcessarRetornoCancelamentoInterna(strNumDoc, strEspDoc, strCodEmp,
    strSerie, strCodCli, strTip_FC);
end;

function TLibNfe.fProcessarRetornoCancelamentoInterna(strNumDoc, strEspDoc,
  strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
  Var
    fonte: IFonteDados;
    service: INFEService;
    retornoNFE: TRetornoNFE;
    strStsFalha: String;
begin
  pSetaConfiguracoesPainel(VS_confignfe);

 {$IFNDEF LINUX}
  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(VS_confignfe);
 {$ENDIF}

  fonte := fCriarFonteDadosEmitenteBD(Self.Banco, strNumDoc, strEspDoc, strCodEmp,
    strCodCli, strSerie, strTip_FC);

  service := fCriarNFEService(fonte);

  {**************************************}
  {* PROCESSA O RETORNO DO ENVIO.       *}
  {***********************************MV*}
  Try
    retornoNFE := service.fProcessarCancelamento;

    If (retornoNFE.Aguardando) Then
      strStsFalha := 'GC'
    Else
      strStsFalha := 'EC';

    pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
      strTip_FC, 'CN', strStsFalha, retornoNFE);

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'EC', 'Erro de programa: ' + E.Message);
      pLogImp('Exceção em fProcessarRetornoCancelamentoInterna '+E.Message);
    End;
  End;

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

function TLibNfe.fProcessarRetornoConhecimentoEletronicoInterna(strNumCTe, strSerie: String): Boolean;
var
  retornoNFE: TRetornoNFE;
  fonte: IFonteDadosConhecimento;
  fonteBD: IFonteDados;
  service: IConhecimentoEletronicoService;
  strStsFalha: String;
begin
  Result := False;

  Try
    pSetaConfiguracoesPainel(VS_confignfe);

   {$IFNDEF LINUX}
    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(VS_confignfe);
   {$ENDIF}

    fonte := fCriarFonteDadosConhecimento(Self.Banco);

    pCarregarDll('', '', '', '', '', '', opEnvio);
    fonteBD := fCriarFonteDadosBDSet(Self.Banco, strNumCTe, 'CT', VS_strCodEmp, '', strSerie, '');

    service := fCriarConhecimentoEletronicoService(fonte, fonteBD);

    retornoNFE := service.fProcessarConhecimento(strNumCTe);

    If (retornoNFE.Sucesso) Then
    Begin
      pAtualizarDadosConhecimentoAutcom(strNumCTe, VS_strCodEmp, retornoNFE);
    End
    Else If (retornoNFE.Aguardando) or (Pos('arquivo recebido com erros', AnsiLowerCase(retornoNFE.Mensagem)) > 0) Then
      strStsFalha := 'CG'
    Else
    Begin
      strStsFalha := 'CE';
    End;

    if (retornoNFE.Sucesso) and (retornoNFE.ErroImpressao) then
      pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', 'CE', retornoNFE.Mensagem, '', retornoNFE)
    else
      pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', 'AC', strStsFalha, retornoNFE);

    if (retornoNFE.Sucesso) and (not retornoNFE.ErroImpressao) then
      Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarLogNfe(strNumCTe, 'CT', VS_strCodEmp, strSerie, '', '', 'CE', 'Erro de programa: ' + E.Message);
      pLogImp('Exceção em ProcessarRetornoConhecimentoEletronicoInterna '+E.Message);
    End;
  End;

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

function TLibNfe.fProcessarRetornoEnvio(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String): Boolean;
  Var
    strImpressora: String;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, opProcessaEnvio);

  if (strEspDoc = 'IF') And (fUsaSat) and (fCfgSisPainel('SATCIT', Banco) = 'S') then
    strImpressora := VS_ImpressoraSat
  else
    strImpressora := fCarregarImpressoraPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) ;

  Result := fProcessarRetornoEnvioInterna(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strImpressora);
end;

function TLibNfe.fProcessarRetornoEnvioInterna(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strImpressora: String): Boolean;
  Var
    fonte: IFonteDados;
    service: INFEService;
    intContador: Integer;
    retornoNFE: TRetornoNFE;
    strStsFalha: String;
    strErros: String;
    strUltNot: String;
    blnAutorizado: boolean;
begin
  pLogImp('TLibNfe.fProcessarRetornoEnvioInterna >');
  Try
    If (strEspDoc = 'NS') And fTemNotaServicoAnteriorPendente(strNumDoc, strCodEmp, strUltNot) Then
      Raise Exception.Create(Format(MSG_NOTAS_SERVICO_ANTERIOR_NAO_AUTORIZADA, [strUltNot]));

    pSetaConfiguracoesPainel(VS_confignfe);

   {$IFNDEF LINUX}
    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(VS_confignfe);
   {$ENDIF}

    If strEspDoc = 'IF' Then
      fonte := fCriarFonteDadosBDSet(Self.Banco, strNumDoc, strEspDoc, strCodEmp,
        strCodCli, strSerie, strTip_FC)
    else
      fonte := fCriarFonteDadosEmitenteBD(Self.Banco, strNumDoc, strEspDoc, strCodEmp,
        strCodCli, strSerie, strTip_FC);

    fonte.pSetaPathSatCitel(VS_PathSat);
    service := fCriarNFEService(fonte);

    {**************************************}
    {* PROCESSA O retornoNFE DO ENVIO.       *}
    {***********************************MV*}
    fonte.pCarregarDados;

    If not (((strEspDoc = 'IF') And (fCfgSisPainel('PRNFCE', Banco) = 'S')) Or
            ((strEspDoc = 'NF') And (fCfgSisPainel('CITINF', Banco) = 'S'))) Then
    Begin
      strImpressora := fRetornaNomeImpressora(strImpressora);
    End;

    fonte.fDadosGerais.strPontoImpressao := strImpressora;

    If strEspDoc = 'IF' Then
    Begin
      pLogImp('Enviar > ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_FC);
      service.fEnviarNota;
      pLogImp('Enviar < ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);

      pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp, strSerie,
                                    strCodCli, strTip_FC,
                                    fonte.fDadosGerais.strMsgAdicional,
                                    fonte.fDadosGerais.strMsgAdicionalCom,
                                    fonte.fDadosGerais.strMsgAdicionalFis);
      pLogImp('Atualizou mensagens nota fiscal > ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);
    End;

    pLogImp('Processar envio > ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);
    retornoNFE := service.fProcessarEnvio;
    pLogImp('Processar envio < ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);

    blnAutorizado := False;

    If ((retornoNFE.Sucesso) And (not retornoNFE.Cancelada)) Or
       ((retornoNFE.Denegada) And (Not fEmptyStr(retornoNFE.ChaveAcesso))) Then
    Begin
      pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp, strSerie,
        strCodCli, strTip_FC, retornoNFE);

      If (strEspDoc = 'IF') Then
      Begin
        If not retornoNFE.OffLine Then
        Begin
          retornoNFE.SetOffLine(fonte.fDadosGerais.blnNFCeOffLine);
        End;

        pAtualizarMensagensCupomFiscal(strNumDoc, strEspDoc, strCodEmp,
          strSerie, strCodCli, strTip_FC, retornoNFE.QRCode, retornoNFE.NumeroProtocolo,
          retornoNFE.ObsFisco, retornoNFE.DataAutorizacao, retornoNFE.DataEmissao, retornoNFE.OffLine);

        pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, True, retornoNFE);

        if fPodeImprimirSatIntegrador(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) then
          service.pReimprimirDanfe(retornoNFE.ChaveAcesso);

      End
      Else If (strEspDoc = 'NS') Then
      Begin
        pAtualizarSubNfs(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, retornoNFE);
      End;

      blnAutorizado := True;
    End;

    If (retornoNFE.Aguardando) Then
      strStsFalha := 'GE'
    Else
    Begin
      If retornoNFE.Denegada Then
        strStsFalha := 'DN'
      Else
        strStsFalha := 'EE';
    End;

    If retornoNFE.Sucesso And retornoNFE.Cancelada Then
    Begin
      pAtualizaLogNfeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'CN', retornoNFE.Mensagem);
      blnAutorizado := True;
    End
    Else
    Begin
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'AT', strStsFalha, retornoNFE);
    End;

    If (strEspDoc = 'IF') Or (fUsaNotaServicoEletronicaEnotas And (strEspDoc = 'NS')) Then
      Result := blnAutorizado
    Else
      Result := True;

    {**********************************************************************************}
    {* CASO O DOWNLOAD DO XML TENHA FALHADO FAZ UMA NOVA TENTATIVA APÓS GRAVAR LOGNFE *}
    {******************************************************************REQ.:224932**VA*}
    If (strEspDoc = 'NF') And fEmptyStr(strStsFalha) Then
    Begin
      If (retornoNFE.Sucesso) Then
      Begin
        If (Not retornoNFE.Contingencia) Then
        Begin
          If (Not fonte.XMLJaBaixado(retornoNFE.ChaveAcesso)) Then
            fonte.pSalvarXMLNFeBD(retornoNFE.ChaveAcesso, service.fRetXmlNfe(retornoNFE.ChaveAcesso));
        End;
      End;
    End;

  Except
    On E: ErrosValidacaoNFE Do
    Begin
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
      Result := False;
      pLogImp('ErrosValidacaoNFE: ' + strErros);
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'EE', strErros);
    End;

    On E: Exception Do
    Begin
      Result := False;
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'EE', 'Erro de programa: ' + E.Message);
      pLogImp('Exceção em fProcessarRetornoEnvioInterna '+E.Message);
    End;
  End;

  if Assigned(retornoNFE) then
    FreeAndNil(retornoNFE);

  pLogImp('TLibNfe.fProcessarRetornoEnvioInterna <');
end;

procedure TLibNfe.pAtualizarSubNfs(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String; retorno: TRetornoNFE);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryFis: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If (strEspDoc = 'NS') And (Not fEmptyStr(retorno.NumeroProtocolo)) And (fTabelaExiste('SUBNFS', Self.Banco)) Then
  Begin
    pLogImp('pAtualizarSubNfs >');

    qryFis := fCriaQuery(Nil, Self.Banco);
    qryAux := fCriaQuery(Nil, Self.Banco);

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

    pLogImp('pAtualizarSubNfs <');
  End;
end;

{**************************************}
{* CARREGA CONFIGURAÇÕES.             *}
{***********************************MV*}
function TLibNfe.fAcertaChaveAcessoNotaFiscal(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String; var blnErroRecusadaRejeitada: Boolean;
  var strMensagem: String; var blnContingenciaAutorizada: Boolean; blnRegenerando: Boolean=False): Boolean;
  Var
    fonte: IFonteDados;
    service: INFEService;
    retornoNFE: TRetornoNFE;
    blnAtualizarDados: Boolean;
begin
  Result := False;

  blnErroRecusadaRejeitada := False;
  blnContingenciaAutorizada := False;
  strMensagem := '';

  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, opEnvio);

  pSetaConfiguracoesPainel(VS_confignfe);

 {$IFNDEF LINUX}
  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(VS_confignfe);
 {$ENDIF}

  fonte := fCriarFonteDadosBDSet(Self.Banco, strNumDoc, strEspDoc,
    strCodEmp, strCodCli, strSerie, strTip_FC);

  fonte.pSetaPathSatCitel(VS_PathSat);
  service := fCriarNFEService(fonte);

  Try
    fonte.pCarregarDados;

    If fonte.fdadosGerais.blnNFCeOffLine Then
    Begin
      If fonte.fDadosGerais.strStaOffLine = 'OF' Then
      Begin
        service.fEnviaNFCeXmlOffLine;
        Sleep(500);
      End;
    End;

    service.fVerificarStatusNota(strNumDoc, strSerie);

    retornoNFE := service.fProcessarStatusNota;

    If (retornoNFE.Sucesso) Or
       ((retornoNFE.Denegada) And (Not fEmptyStr(retornoNFE.ChaveAcesso))) Then
    Begin
      blnAtualizarDados := True;
      If blnRegenerando Then
        blnAtualizarDados := retornoNFE.Sucesso;

      If blnAtualizarDados Then
      Begin
        pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, retornoNFE);

        If (blnRegenerando) Then
        Begin
          pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, 'AT', retornoNFE.Mensagem, '', retornoNFE);
        End
        Else
        Begin
          If (retornoNFE.ContingenciaAutorizada = 'S') Then
          Begin
            pAtualizaLogNfeDpecPendente(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, retornoNFE);
            blnContingenciaAutorizada := True;
          End;
        End;
      End;

      Result := blnAtualizarDados;
    End
    Else
    Begin
      blnErroRecusadaRejeitada := retornoNFE.RecusadaRejeitada;

      If (blnErroRecusadaRejeitada) Then
        strMensagem := retornoNFE.Mensagem;
    End;
  Except
    On E: Exception Do
    Begin
      pGrvArqTxt(strNumDoc+'_'+strEspDoc+'_'+strCodEmp+'_'+strCodCli+'_'+strSerie, 'Exceção em fAcertaChaveAcessoNotaFiscal'+#13#13+E.Message)
    End;
  End;

  If Assigned(retornoNFE) Then
    FreeAndNil(retornoNFE);
end;

procedure TLibNfe.pAtualizaLogNfeDpecPendente(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String; retorno: TRetornoNFE);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnExisteCampoStatusPendenciaDepec : Boolean;
begin
  qryAux := fCriaQuery(Nil, Self.Banco);
  Try
    blnExisteCampoStatusPendenciaDepec := fCampoExiste('LOGNFE', 'NFE_PDSTDP', Self.Banco);

    qryAux.SQL.Add(' UPDATE LOGNFE ');
    qryAux.SQL.Add('    SET NFE_PNDPEC = 0 ');

    If (Not fEmptyStr(retorno.ChaveAcesso)) Then
      qryAux.SQL.Add('     ,NFE_ACESSO = :ACESSO ');

    If (Not fEmptyStr(retorno.Mensagem)) Then
      qryAux.SQL.Add('     ,NFE_OBSERV = :OBSERV ');

    If (blnExisteCampoStatusPendenciaDepec) Then
      qryAux.SQL.Add('     ,NFE_PDSTDP = 0 ');

    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;

    If (Not fEmptyStr(retorno.ChaveAcesso)) Then
      qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;

    If (Not fEmptyStr(retorno.Mensagem)) Then
      qryAux.ParamByName('OBSERV').AsString := retorno.Mensagem;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TLibNfe.pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String; retorno: TRetornoNFE;
  blnVerificaAbastecimento: Boolean = True);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnFldPotocExiste : Boolean;
    blnFisCodModExiste: Boolean;
    strFisCodMod: String;
begin
  pLogImp('pAtualizarDadosAutcom >');
  qryAux := fCriaQuery(Nil, Self.Banco);
  Try
    blnFldPotocExiste  := fCampoExiste('CADFIS', 'FIS_PROTOC');
    blnFisCodModExiste := fCampoExiste('CADFIS', 'FIS_CODMOD');
    strFisCodMod       := Copy(retorno.ChaveAcesso, 21, 2);

    If (strEspDoc = 'NS') Then
      strFisCodMod := '56';

    If fEmptyStr(strFisCodMod) Then
      blnFisCodModExiste := False;

    qryAux.SQL.Add('UPDATE CADFIS ');
    qryAux.SQL.Add('   SET FIS_ACESSO = :ACESSO ');

    If blnFisCodModExiste Then
      qryAux.SQL.Add('    ,FIS_CODMOD = :CODMOD ');

    If Not fEmptyStr(retorno.NumeroSerieSAT) Then
    Begin
      qryAux.SQL.Add('    ,FIS_NUMSER = :NUMSER ');
      qryAux.SQL.Add('    ,FIS_NUMCOO = :NUMCOO ');
    End;

    If (Not fEmptyStr(retorno.NumeroProtocolo)) And (blnFldPotocExiste) Then
      qryAux.SQL.Add('    ,FIS_PROTOC = :PROTOC ');

    qryAux.SQL.Add('  WHERE FIS_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND FIS_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND FIS_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND FIS_FORCLI = :CODCLI ');
    qryAux.SQL.Add('    AND IFNULL(FIS_SERIE_, "") = :SERIE_ ');
    qryAux.SQL.Add('    AND FIS_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;

    If (Not fEmptyStr(retorno.NumeroProtocolo)) And (blnFldPotocExiste) Then
      qryAux.ParamByName('PROTOC').AsString := retorno.NumeroProtocolo;

    If blnFisCodModExiste Then
      qryAux.ParamByName('CODMOD').AsString := strFisCodMod;

    If Not fEmptyStr(retorno.NumeroSerieSAT) Then
    Begin
      qryAux.ParamByName('NUMSER').AsString := retorno.NumeroSerieSAT;
      qryAux.ParamByName('NUMCOO').AsString := retorno.NumeroCFe;
    End;

    qryAux.ExecSQL;

    If (blnVerificaAbastecimento) And (strEspDoc <> 'NS') Then
      pAtualizarDadosAutcomAbastecimento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, retorno);
  Finally
    FreeAndNil(qryAux);
  End;
  pLogImp('pAtualizarDadosAutcom <');
end;

procedure TLibNfe.pAtualizarDadosAutcomAbastecimento(strNumDoc, strEspDoc,
  strCodEmp, strSerie, strCodCli, strTip_FC: String; retorno: TRetornoNFE);
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strAutInc, strDocAba, strEspAba, strEmpAba, strCliAba: String;
begin
  If (Not fCampoExiste('AUXMOV', 'AUX_DOCABA')) Or
     (Not fCampoExiste('AUXMOV', 'AUX_ESPABA')) Or
     (Not fCampoExiste('AUXMOV', 'AUX_EMPABA')) Or
     (Not fCampoExiste('AUXMOV', 'AUX_CLIABA')) Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Nil, Self.Banco);
  Try
    qryAux.SQL.Add('SELECT  ');
    qryAux.SQL.Add('  MOVGER.AUTOINCREM, AUX_DOCABA, AUX_ESPABA, AUX_EMPABA, AUX_CLIABA  ');
    qryAux.SQL.Add('FROM MOVGER  ');
    qryAux.SQL.Add('LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  IF(:TIP_FC = "C", GER_CODCLI, GER_CODFOR) = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND ');
    qryAux.SQL.Add('  GER_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;

    qryAux.Open;

    If qryAux.IsEmpty or (fEmptyStr(qryAux.FieldByName('AUX_DOCABA').AsString)) Then
    Begin
      Exit;
    End;

    strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;
    strDocAba := qryAux.FieldByName('AUX_DOCABA').AsString;
    strEspAba := qryAux.FieldByName('AUX_ESPABA').AsString;
    strEmpAba := qryAux.FieldByName('AUX_EMPABA').AsString;
    strCliAba := qryAux.FieldByName('AUX_CLIABA').AsString;

    qryAux.Close;
    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT  ');
    qryAux.SQL.Add('  GER_NUMDOC, ');
    qryAux.SQL.Add('  GER_ESPDOC, ');
    qryAux.SQL.Add('  GER_CODEMP, ');
    qryAux.SQL.Add('  IF(GER_TIP_FC = "C", GER_CODCLI, GER_CODFOR) AS GER_CODCLI,');
    qryAux.SQL.Add('  GER_SERIE_, ');
    qryAux.SQL.Add('  GER_TIP_FC  ');
    qryAux.SQL.Add('FROM MOVGER  ');
    qryAux.SQL.Add('LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  AUX_DOCABA = :DOCABA AND ');
    qryAux.SQL.Add('  AUX_ESPABA = :ESPABA AND ');
    qryAux.SQL.Add('  AUX_EMPABA = :EMPABA AND ');
    qryAux.SQL.Add('  AUX_CLIABA = :CLIABA AND ');
    qryAux.SQL.Add('  MOVGER.AUTOINCREM <> :AUTINC ');

    qryAux.ParamByName('DOCABA').AsString := strDocAba;
    qryAux.ParamByName('ESPABA').AsString := strEspAba;
    qryAux.ParamByName('EMPABA').AsString := strEmpAba;
    qryAux.ParamByName('CLIABA').AsString := strCliAba;
    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.Open;

    While Not qryAux.Eof Do
    Begin
      pAtualizarDadosAutcom(
        qryAux.FieldByName('GER_NUMDOC').AsString,
        qryAux.FieldByName('GER_ESPDOC').AsString,
        qryAux.FieldByName('GER_CODEMP').AsString,
        qryAux.FieldByName('GER_SERIE_').AsString,
        qryAux.FieldByName('GER_CODCLI').AsString,
        qryAux.FieldByName('GER_TIP_FC').AsString,
        retorno,
        False);
      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TLibNfe.pAtualizarDadosConhecimentoAutcom(strNumCte, strCodEmp: String; retorno: TRetornoNFE);
var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  pLogImp('pAtualizarDadosConhecimentoAutcom >');
  qryAux := fCriaQuery(Nil, Self.Banco);
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  MOVCTE ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  CTE_ACESSO = :ACESSO ');

  If fCampoExiste('MOVCTE', 'CTE_PROTOC') Then
  Begin
    qryAux.SQL.Add('  , CTE_PROTOC = :PROTOC ');
    qryAux.ParamByName('PROTOC').AsString := retorno.ProtocoloConhecimento;
  End;

  If fCampoExiste('MOVCTE', 'CTE_CODMOD') Then
  Begin
    qryAux.SQL.Add('  , CTE_CODMOD = :CODMOD ');
    qryAux.ParamByName('CODMOD').AsString := retorno.ModeloConhecimento;
  End;

  If fCampoExiste('MOVCTE', 'CTE_DTAHOR') Then
  Begin
    qryAux.SQL.Add('  , CTE_DTAHOR = :DTAHOR ');
    qryAux.ParamByName('DTAHOR').AsDateTime := fMontaDataHora(retorno.DataHoraConhecimento);
  End;

  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  CTE_NUMCTE = :NUMCTE ');
  qryAux.SQL.Add('  AND CTE_CODEMP = :CODEMP ');
  qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;
  qryAux.ParamByName('NUMCTE').AsString := strNumCTe;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ExecSQL;

  qryAux.SQL[1] := '  NOTCTE ';
  qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;
  qryAux.ParamByName('NUMCTE').AsString := strNumCTe;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
  pLogImp('pAtualizarDadosConhecimentoAutcom <');
end;

procedure TLibNfe.pAtualizarDadosManifestoAutcom(strNumMan, strCodEmp: String;
  retorno: TRetornoNFE);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strSeqGer: string;
begin
  qryAux := fCriaQuery(Nil, Self.Banco);
  Try
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  CADFIS ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  FIS_ACEMAN = :ACESSO ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
    if fCampoExiste('CADFIS', 'FIS_EMPMAN') then
      qryAux.SQL.Add('  FIS_EMPMAN = :CODEMP ')
    else
      qryAux.SQL.Add('  FIS_CODEMP = :CODEMP ');

    qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;

    qryAux.ParamByName('NUMMAN').AsString := strNumMan;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ExecSQL;

    if (fTabelaExiste('MDFFIS', Self.Banco)) then
    begin
      pLogImp('pAtualizarDadosManifestoAutcom > Gravação MDFFIS');

      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT AUTOINCREM FROM CADFIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
      if fCampoExiste('CADFIS', 'FIS_EMPMAN') then
        qryAux.SQL.Add('  FIS_EMPMAN = :CODEMP ')
      else
        qryAux.SQL.Add('  FIS_CODEMP = :CODEMP ');

      qryAux.ParamByName('NUMMAN').AsString := strNumMan;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.Open;

      strSeqGer := qryAux.FieldByName('AUTOINCREM').AsString;

      If not fEmptyStr(strSeqGer) Then
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('INSERT INTO MDFFIS ');
        qryAux.SQL.Add('(AUTOINCREM, MDF_SEQGER, MDF_NUMMAN, MDF_EMPMAN, MDF_PROTOC, MDF_CODMOD, MDF_DTAHOR) ');
        qryAux.SQL.Add('VALUES ');
        qryAux.SQL.Add('(:AUTOINCREM, :SEQGER, :NUMMAN, :EMPMAN, :PROTOC, :CODMOD, :DTAHOR) ');

        pLogImp('pAtualizarDadosManifestoAutcom > Gravação MDFFIS > Vai tentar retornar AUTOINCREM');

        qryAux.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MDFFIS', strCodEmp);
        qryAux.ParamByName('SEQGER').AsString     := strSeqGer;
        qryAux.ParamByName('NUMMAN').AsString     := strNumMan;
        qryAux.ParamByName('EMPMAN').AsString     := strCodEmp;
        qryAux.ParamByName('PROTOC').AsString     := retorno.ProtocoloManifesto;
        qryAux.ParamByName('CODMOD').AsString     := retorno.ModeloManifesto;
        qryAux.ParamByName('DTAHOR').AsDateTime   := fMontaDataHora(retorno.DataHoraManifesto);
        qryAux.ExecSQL;

        pLogImp('pAtualizarDadosManifestoAutcom > Gravação MDFFIS > Gravou com sucesso');
      End;
    end;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TLibNfe.pAtualizarMensagensNotaFiscal(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strMsgAdicional, strMsgAdicionalCom, strMsgAdicionalFis: String);

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
    qryMovGer: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    strAutInc: String;
    strTabela: String;
    intCnt : Integer;

  Const
    arrTabGer : Array[1..2] Of String = ('MOVGER', 'NOTGER');
    arrTabObs : Array[1..2] Of String = ('MOVOBS', 'NOTOBS');
begin
  If (Not fCampoExiste('MOVOBS', 'MOV_CNFNFE')) Then
    If (fCfgSisPainel('AXCFNS', Banco) = 'S') Then
      Exit;

  pLogImp('pAtualizarMensagensNotaFiscal >');
  pLogImp('strMsgAdicional...: '+strMsgAdicional);
  pLogImp('strMsgAdicionalCom: '+strMsgAdicionalCom);
  pLogImp('strMsgAdicionalFis: '+strMsgAdicionalFis);

  strTabela := '';
  strAutInc := '';

  qryMovGer := fCriaQuery(Nil, Self.Banco);

  With qryMovGer Do
  Begin
    For intCnt := 1 To 2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fSQLMovGer( arrTabGer[intCnt] ));
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

  If Not fEmptyStr(strTabela) Then
  Begin
    With qryMovGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ' + strTabela);
      SQL.Add('    SET MOV_OBSERV = :OBSERV ');

      If fEmptyStr(strMsgAdicional) Then
      Begin
        If fCampoExiste('MOVOBS', 'MOV_OBSFIS') Then
          SQL.Add('  , MOV_OBSFIS = :OBSFIS ');

        SQL.Add('  WHERE MOV_SEQGER = :SEQGER ');
        ParamByName('OBSERV').AsString := strMsgAdicionalCom;

        If fCampoExiste('MOVOBS', 'MOV_OBSFIS') Then
          ParamByName('OBSFIS').AsString := strMsgAdicionalFis;
      End
      Else
      Begin
        SQL.Add('  WHERE MOV_SEQGER = :SEQGER ');
        ParamByName('OBSERV').AsString := strMsgAdicional;
      End;

      ParamByName('SEQGER').AsString := strAutInc;
      ExecSQL;
    End;
  End;

  FreeAndNil(qryMovGer);

  pLogImp('pAtualizarMensagensNotaFiscal <');
end;

{**************************************}
{* SEMPRE QUE INCLUIR UMA NOVA CONFIG *}
{* AQUI, NÃO ESQUEÇA DE INCLUIR TAMBÉM*}
{* NA UNIT untLibNFe do AUTCOM.       *}
{***********************************RV*}
class procedure TLibNfe.pCarregaConfigNFE(Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});

  function fRetUtilizaCliPro: TUtilizaCliPro;
    Var
      intValCfg : Integer;
      intBitOpc : Integer;
  Begin
    Result := [];
    intValCfg := 0;
    If (fExisteConfiguracao('ACLPRO', Banco)) Then
      intValCfg := fCfgSis('ACLPRO', varString, '', Banco);
    intBitOpc := Ord( High(TOpcCliPro) );

    While ( intValCfg <> 0 ) Do
    Begin

      If (intValCfg >= Ord(TOpcCliPro( intBitOpc )) ) Then
      Begin
        Result := Result + [TOpcCliPro(intBitOpc)];
        intValCfg := intValCfg - Ord(TOpcCliPro(intBitOpc));
      End;
      intBitOpc := Trunc( intBitOpc / 2 );
    End;
  End;

begin
  If Assigned(VS_confignfe) Then
  Begin
    Exit;
  End;

  VS_confignfe := TConfiguracoesNFE.Create;
  VS_confignfe.strCodEmp := VS_strCodEmp;
  VS_confignfe.blnSimPau := fCfgSis('SIMPAU', varBoolean, '', Banco);
  VS_confignfe.strClaSub := fCfgSis('CLASUB', varString, '', Banco);
  VS_confignfe.strClaVen := fTransform(fCfgSis('CLAVEN', varString, '', Banco), 4);

  If (fExisteConfiguracao('CLACIF', Banco)) Then
    VS_confignfe.strClaCif := fTransform(fCfgSis('CLACIF', varString, '', Banco), 3)
  Else
    VS_confignfe.strClaCif := '';

  VS_confignfe.blnNFEFab := fCfgSis('NFEFAB', varBoolean, '', Banco);

  If (fExisteConfiguracao('IMPCIF', Banco)) Then
    VS_confignfe.blnImpCif := fCfgSis('IMPCIF', varBoolean, '', Banco)
  Else
    VS_confignfe.blnImpCif := False;

  If (fExisteConfiguracao('NFEMAR', Banco)) Then
    VS_confignfe.blnNFEMar := fCfgSis('NFEMAR', varBoolean, '', Banco)
  Else
    VS_confignfe.blnNFEMar := fCfgSis('NFEFAB', varBoolean, '', Banco);

  If (fExisteConfiguracao('NFELOC', Banco)) Then
    VS_confignfe.blnNFELoc := fCfgSis('NFELOC', varBoolean, '', Banco)
  Else
    VS_confignfe.blnNFELoc := False;

  VS_confignfe.blnNfeMFi := fCfgSis('NFEMFI', varBoolean, '', Banco);
  VS_confignfe.blnVendad := fCfgSis('VENDAD', varBoolean, '', Banco);
  VS_confignfe.strNfeEmp := fCfgSis('NFEEMP', varString, '', Banco);
  VS_confignfe.blnNfeDse := fCfgSis('NFEDSE', varBoolean, '', Banco);
  VS_confignfe.blnHomolo := fCfgSis('HOMOLO', varBoolean, '', Banco);
  VS_confignfe.blnCclNfe := fCfgSis('CCLNFE', varBoolean, '', Banco);
  VS_confignfe.strNfeIte := fCfgSis('NFEITE', varString, '', Banco);
  VS_confignfe.strPatOph := fCfgSis('NFEPAT', varString, '', Banco);
  VS_confignfe.strIteSer := fCfgSis('ITESER', varString, '', Banco);
  VS_confignfe.blnUsaSer := fCfgSis('USASER', varBoolean, '', Banco);
  VS_confignfe.blnCdpNfe := fCfgSis('CDPNFE',varBoolean, '', Banco);
  VS_confignfe.blnConIpi := fCfgSis('CONIPI',varBoolean, '', Banco);
  VS_confignfe.strCliPro := 'N';
  If (fExisteConfiguracao('CLIPRO', Banco)) Then
  Begin
    If (fCfgSis('CLIPRO', varString, '', Banco) = 'S') Then
      If (opcPdOrNf in fRetUtilizaCliPro) Then
        VS_confignfe.strCliPro := 'S';
  End;

  If (fExisteConfiguracao('RICMPR', Banco)) Then
    VS_confignfe.blnRIcmPr := fCfgSis('RICMPR',varBoolean, '', Banco)
  Else
    VS_confignfe.blnRIcmPr := False;

  If (fExisteConfiguracao('IMPPAG', Banco)) Then
    VS_confignfe.strImpPag := fCfgSis('IMPPAG', varString, '', Banco)
  Else
    VS_confignfe.strImpPag := '1';

  VS_confignfe.strClaDev := fTransform(fCfgSis('CLADEV', varString, '', Banco), 4);
  
  Try
    VS_confignfe.blnOrgDfi := fCfgSis('ORGDFI', varBoolean, '', Banco);  {*RV*}
  Except
    VS_confignfe.blnOrgDfi := False;
  End;

  Try
    VS_confignfe.strEndPrc := fCfgSis('ENDPRC', varString, '', Banco);              {*RV*}
  Except
    VS_confignfe.strEndPrc := '';
  End;

  Try
    VS_confignfe.strTelPrc := fCfgSis('TELPRC', varString, '', Banco);              {*RV*}
  Except
    VS_confignfe.strTelPrc := '';
  End;

  Try
    VS_confignfe.strEndAle := fCfgSis('ENDALE', varString, '', Banco);              {*RV*}
  Except
    VS_confignfe.strEndAle := '';
  End;

  Try
    VS_confignfe.strTelAle := fCfgSis('TELALE', varString, '', Banco);              {*RV*}
  Except
    VS_confignfe.strTelAle := '';
  End;
end;

{**************************************}
{* CARREGA DLL LIBNFE.DLL             *}
{***********************************MV*}
procedure TLibNfe.pCarregarDll(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC: String; opOperacao: TOperacaoNFE);
begin
 {$IFDEF LINUX}
  fCriarFonteDadosBDSet := fCriarFonteDadosBD;
 {$ELSE}
  If (handleBD <> 0) Then
    pSetaConfiguracoesBD := GetProcAddress(handleBD, PAnsiChar('pSetaConfiguracoesBD'));

  If (handleBD = 0) Then
    fCriarFonteDadosBDSet := fCriarFonteDadosBD
  Else
    fCriarFonteDadosBDSet := GetProcAddress(handleBD, PAnsiChar('fCriarFonteDadosBD'));
 {$ENDIF}
end;

procedure TLibNfe.pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strStsSucesso, strStsFalha: String; retorno: TRetornoNFE;
  strPontoImpressao: String='');
Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnEPEC: Boolean;
    recInfLog: TInfParaLogNfe;
begin
  pLogImp('pGravarLogNfe > ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);

  pBuscaInformacoesParaGravacaoLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, recInfLog);

  If (strStsFalha = 'GE') And (recInfLog.strJahAut = 'S') Then
  Begin
    pLogImp('pGravarLogNfe < Exit(fNotaFiscalJaAutorizada)');
    Exit;
  End;

  If (strEspDoc = 'NF') And (recInfLog.strExiFis = 'N') Then
  Begin
    pLogImp('pGravarLogNfe < Exit(Not fExisteCadFis)');
    Exit;
  End;

  qryAux := fCriaQuery(Nil, Self.Banco);
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

  If fCampoExiste('LOGNFE', 'NFE_DTAEMI', Self.Banco) Then
    qryAux.SQL.Add('  NFE_DTAEMI, ');

  If fCampoExiste('LOGNFE', 'NFE_VIANFE', Self.Banco) Then
    qryAux.SQL.Add('  NFE_VIANFE, ');

  qryAux.SQL.Add('  NFE_PNDPEC, ');

  If fCampoExiste('LOGNFE', 'NFE_PDSTDP', Self.Banco) Then
    qryAux.SQL.Add('  NFE_PDSTDP, ');

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

  If fCampoExiste('LOGNFE', 'NFE_DTAEMI', Self.Banco) Then
    qryAux.SQL.Add('  :DTAEMI, ');

  If fCampoExiste('LOGNFE', 'NFE_VIANFE', Self.Banco) Then
    qryAux.SQL.Add('  :VIANFE, ');

  qryAux.SQL.Add('  :PNDPEC, ');

  If fCampoExiste('LOGNFE', 'NFE_PDSTDP', Self.Banco) Then
    qryAux.SQL.Add('  :PDSTDP, ');

  qryAux.SQL.Add('  :DTAAUT, ');
  qryAux.SQL.Add('  nOw()) ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ParamByName('OBSERV').AsString := retorno.Mensagem;

  If Not fEmptyStr(strPontoImpressao) Then
    qryAux.ParamByName('PONIMP').AsString := strPontoImpressao
  Else If Not fEmptyStr(recInfLog.strPonImp) Then
    qryAux.ParamByName('PONIMP').AsString := recInfLog.strPonImp
  Else
    qryAux.ParamByName('PONIMP').AsString := fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  If retorno.Sucesso Then
  Begin
    qryAux.ParamByName('STATUS').AsString   := strStsSucesso;
    qryAux.ParamByName('ACESSO').AsString   := retorno.ChaveAcesso;
    qryAux.ParamByName('DTAAUT').AsDateTime := retorno.DataAutorizacao;
    qryAux.ParamByName('PNDPEC').AsInteger  := 0;

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
    qryAux.ParamByName('PNDPEC').AsInteger := recInfLog.intPndPec;
  End;

  If fCampoExiste('LOGNFE', 'NFE_VIANFE', Self.Banco) Then
  Begin
    If (recInfLog.intViaNfe > -1) Then
      qryAux.ParamByName('VIANFE').AsInteger := recInfLog.intViaNfe;
    If (recInfLog.intViaNfe = 0) And (qryAux.ParamByName('STATUS').AsString <> 'EE') And (qryAux.ParamByName('PONIMP').AsString = 'NENHUM') Then
      qryAux.ParamByName('PONIMP').AsString  := '';
  End;

  If Assigned(qryAux.Params.FindParam('PDSTDP')) Then
  Begin
    qryAux.ParamByName('PDSTDP').AsInteger := qryAux.ParamByName('PNDPEC').AsInteger;
  End;

  blnEPEC := qryAux.ParamByName('PNDPEC').AsInteger = 1;

  If fCampoExiste('LOGNFE', 'NFE_DTAEMI', Self.Banco) Then
  Begin
    If (recInfLog.dtaDtaEnt = 0) Then
      qryAux.ParamByName('DTAEMI').Value := Null
    Else
      qryAux.ParamByName('DTAEMI').AsDate := recInfLog.dtaDtaEnt;
  End;

  qryAux.ExecSQL;

  if (not blnEPEC) or (not fTabelaExiste('NFEPEC', Self.Banco)) then
  begin
    pLogImp('pGravarLogNfe < Retorno.Sucesso = '+IIF(Retorno.Sucesso,'True','False')+' Status = '+qryAux.ParamByName('STATUS').AsString);
    FreeAndNil(qryAux);
    Exit;
  end;

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('REPLACE INTO NFEPEC (');
  qryAux.SQL.Add('  NFE_NUMDOC, ');
  qryAux.SQL.Add('  NFE_ESPDOC, ');
  qryAux.SQL.Add('  NFE_CODEMP, ');
  qryAux.SQL.Add('  NFE_CODCLI, ');
  qryAux.SQL.Add('  NFE_SERIE_, ');
  qryAux.SQL.Add('  NFE_TIP_FC, ');
  qryAux.SQL.Add('  NFE_STATUS, ');
  qryAux.SQL.Add('  NFE_OBSERV, ');
  qryAux.SQL.Add('  NFE_ACESSO, ');
  qryAux.SQL.Add('  NFE_DTAAUT, ');
  qryAux.SQL.Add('  NFE_NUMPRO, ');
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
  qryAux.SQL.Add('  :DTAAUT, ');
  qryAux.SQL.Add('  :NUMPRO, ');
  qryAux.SQL.Add('  ' + fCurrentDateTime + ' ) ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ParamByName('OBSERV').AsString := retorno.Mensagem;
  qryAux.ParamByName('STATUS').AsString := strStsSucesso;
  qryAux.ParamByName('ACESSO').AsString := retorno.ChaveAcesso;
  qryAux.ParamByName('DTAAUT').AsDate   := retorno.DataAutorizacao;
  qryAux.ParamByName('NUMPRO').AsString := retorno.NumeroProtocolo;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);

  pLogImp('pGravarLogNfe < Retorno.Sucesso = '+IIF(Retorno.Sucesso,'True','False')+' > EM EPEC');
end;

procedure TLibNfe.pReimprimirDanfe(strChaveAcesso: String;
  strNumDocImp, strEspDocImp, strCodEmpImp, strSerieImp, strCodCliImp, strTip_FCImp: String);
  Var
    fonte: IFonteDados;
    service: INFEService;

    fonteManifesto: IFonteDadosManifesto;
    serviceManifesto: IManifestoEletronicoSerivce;

    strEspDoc: String;

    procedure pChamaTelaPontoImpressaoSeNaoImprimir;
    begin
     {$IFNDEF LINUX}
      If fEstaNoPainelNFe Then
        If (Not fEhParaImprimir(fonte.fDadosGerais.strPontoImpressao)) Then
          fonte.fDadosGerais.strPontoImpressao := fRetPontoImpressao;
     {$ENDIF}
    end;

begin
  strEspDoc := '';
  If Length(strChaveAcesso) < 44 Then
  Begin
    strEspDoc := 'NS';
  End;

  pCarregarDll('', strEspDoc, '', '', '', '', opEnvio);
  pSetaConfiguracoesPainel(VS_confignfe);

  If strEspDocImp = 'ME' Then
  Begin
    fonteManifesto := fCriarFonteDadosManifesto(Self.Banco);
    serviceManifesto := fCriarManifestoEletronicoService(fonteManifesto);

    serviceManifesto.pImprimirManifesto(strNumDocImp);
  End
  Else
  Begin
    fonte := fCriarFonteDadosEmitenteBD(Self.Banco, strNumDocImp, strEspDocImp, strCodEmpImp, strCodCliImp, strSerieImp, strTip_FCImp);

    service := fCriarNFEService(fonte);

    if fUsaSat and (strEspDoc = 'IF') and (fCfgSisPainel('SATCIT', Banco) = 'S') then
      fonte.fDadosGerais.strPontoImpressao := VS_ImpressoraSat
    else
    begin
      fonte.fDadosGerais.strPontoImpressao := fCarregarImpressoraPontoImpressaoGravado(strNumDocImp, strEspDocImp, strCodEmpImp, strSerieImp, strCodCliImp, strTip_FCImp) ;
      pChamaTelaPontoImpressaoSeNaoImprimir;
    end;

    if not (((strEspDocImp = 'IF') And (fCfgSisPainel('PRNFCE', Banco) = 'S')) or
            ((strEspDocImp = 'NF') And (fCfgSisPainel('CITINF', Banco) = 'S'))) then
    begin
      fonte.fDadosGerais.strPontoImpressao := fRetornaNomeImpressora(fonte.fDadosGerais.strPontoImpressao);
      pChamaTelaPontoImpressaoSeNaoImprimir;
    end;

    service.pReimprimirDanfe(strChaveAcesso);
  End;
end;

{**************************************}
{* FUNÇÃO AUXILIAR PARA GRAVAR LOG.   *}
{***********************************MV*}
procedure TLibNfe.pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strStatus, strObserv: String; strPontoImpressao: String=''; retorno: TRetornoNFE=nil);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    recInfLog: TInfParaLogNfe;
begin
  pLogImp('pGravarLogNfe > ' + strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);

  pBuscaInformacoesParaGravacaoLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, recInfLog);

  If (strStatus = 'GE') And (recInfLog.strJahAut = 'S') Then
  Begin
    pLogImp('pGravarLogNfe < Exit(fNotaFiscalJaAutorizada)');
    Exit;
  End;

  If (strEspDoc = 'NF') And (recInfLog.strExiFis = 'N') Then
  Begin
    pLogImp('pGravarLogNfe < Exit(Not fExisteCadFis)');
    Exit;
  End;

  qryAux := fCriaQuery(Nil, Self.Banco);
  qryAux.SQL.Add('REPLACE INTO LOGNFE (');
  qryAux.SQL.Add('  NFE_NUMDOC, ');
  qryAux.SQL.Add('  NFE_ESPDOC, ');
  qryAux.SQL.Add('  NFE_CODEMP, ');
  qryAux.SQL.Add('  NFE_CODCLI, ');
  qryAux.SQL.Add('  NFE_SERIE_, ');
  qryAux.SQL.Add('  NFE_TIP_FC, ');
  qryAux.SQL.Add('  NFE_OBSERV, ');
  qryAux.SQL.Add('  NFE_STATUS, ');
  qryAux.SQL.Add('  NFE_ACESSO, ');
  qryAux.SQL.Add('  NFE_PONIMP, ');

  If fCampoExiste('LOGNFE', 'NFE_DTAEMI', Self.Banco) Then
    qryAux.SQL.Add('  NFE_DTAEMI, ');

  If fCampoExiste('LOGNFE', 'NFE_VIANFE', Self.Banco) Then
    qryAux.SQL.Add('  NFE_VIANFE, ');

  qryAux.SQL.Add('  NFE_DTAAUT, ');
  qryAux.SQL.Add('  NFE_PNDPEC, ');
  qryAux.SQL.Add('  NFE_HORINI) ');
  qryAux.SQL.Add('VALUES ( ');
  qryAux.SQL.Add('  :NUMDOC, ');
  qryAux.SQL.Add('  :ESPDOC, ');
  qryAux.SQL.Add('  :CODEMP, ');
  qryAux.SQL.Add('  :CODCLI, ');
  qryAux.SQL.Add('  :SERIE_, ');
  qryAux.SQL.Add('  :TIP_FC, ');
  qryAux.SQL.Add('  :OBSERV, ');
  qryAux.SQL.Add('  :STATUS, ');
  qryAux.SQL.Add('  :ACESSO, ');
  qryAux.SQL.Add('  :PONIMP, ');

  If fCampoExiste('LOGNFE', 'NFE_DTAEMI', Self.Banco) Then
    qryAux.SQL.Add('  :DTAEMI, ');

  If fCampoExiste('LOGNFE', 'NFE_VIANFE', Self.Banco) Then
    qryAux.SQL.Add('  :VIANFE, ');

  qryAux.SQL.Add('  :DTAAUT, ');
  qryAux.SQL.Add('  :PNDPEC, ');
  qryAux.SQL.Add('  nOw()) ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ParamByName('STATUS').AsString := strStatus;
  qryAux.ParamByName('OBSERV').AsString := strObserv;

  If Not fEmptyStr(strPontoImpressao) Then
    qryAux.ParamByName('PONIMP').AsString := strPontoImpressao
  Else If Not fEmptyStr(recInfLog.strPonImp) Then
    qryAux.ParamByName('PONIMP').AsString := recInfLog.strPonImp
  Else
    qryAux.ParamByName('PONIMP').AsString := fCarregarPontoImpressaoGravado(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC);

  if (retorno = nil) then
  begin
    qryAux.ParamByName('ACESSO').Value    := Null;
    qryAux.ParamByName('DTAAUT').Value    := Null;
  end
  else
  begin
    qryAux.ParamByName('ACESSO').AsString    := retorno.ChaveAcesso;
    qryAux.ParamByName('DTAAUT').AsDateTime  := retorno.DataAutorizacao;
  end;

  If fCampoExiste('LOGNFE', 'NFE_VIANFE', Self.Banco) Then
  Begin
    If (recInfLog.intViaNfe > -1) Then
      qryAux.ParamByName('VIANFE').AsInteger := recInfLog.intViaNfe;
    If (recInfLog.intViaNfe = 0) And (qryAux.ParamByName('STATUS').AsString <> 'EE') And (qryAux.ParamByName('PONIMP').AsString = 'NENHUM') Then
      qryAux.ParamByName('PONIMP').AsString  := '';
  End;

  qryAux.ParamByName('PNDPEC').Value    := recInfLog.intPndPec;

  If fCampoExiste('LOGNFE', 'NFE_DTAEMI', Self.Banco) Then
  Begin
    If (recInfLog.dtaDtaEnt = 0) Then
      qryAux.ParamByName('DTAEMI').Value := Null
    Else
      qryAux.ParamByName('DTAEMI').AsDate := recInfLog.dtaDtaEnt;
  End;

  qryAux.ExecSQL;

  pLogImp('pGravarLogNfe < Status = '+qryAux.ParamByName('STATUS').AsString);

  FreeAndNil(qryAux);
end;

class function TLibNfe.fRetPontoImpressao: String;
  Var
    strSQL: String;
    qryPon: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '';

  qryPon := fCriaQuery(Nil);
  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  *      ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  PONIMP ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  PON_CODEMP = :CODEMP ';

      If (fArqIni(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N') Then
      Begin
        If fExisteConfiguracao('SPOIMP') Then
        Begin
          If fCfgSis('SPOIMP', varBoolean) Then
            strSQL := strSQL + '  AND PON_SPOIMP = "S" '
          Else
            strSQL := strSQL + '  AND PON_SPOIMP = "N" ';
        End;
      End;

      With qryPon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        {************************************************}
        {* SE EXISTIR SOMENTE UM PONTO DE IMPRESSÃO     *}
        {* CADASTRADO, APENAS RETORNA O NOME DO PONTO,  *}
        {* SE EXISTIR MAIS DE UM PONTO CADASTRADO, ABRE *}
        {* A TELA PARA QUE O USUARIO ESCOLHA O PONTO DE *}
        {* IMPRESSÃO QUE DESEJA.                        *}
        {*********************************************PZ*}
        If (RecordCount = 1) Then
          Result := FieldByName('PON_NOMPON').AsString
        Else If (RecordCount > 1) Then
        Begin
         {$IFNDEF LINUX}
          frmPontosImpressao := TfrmPontosImpressao.Create(Application);
          Try
            frmPontosImpressao.qryPon := qryPon;
            frmPontosImpressao.ShowModal;

            If (frmPontosImpressao.ModalResult = mrOk) Then
              Result := frmPontosImpressao.strPonImp;
          Finally
            FreeAndNil(frmPontosImpressao);
          End;
         {$ENDIF}
        End;
      End;
    Except
      On E: Exception Do
      Begin
        //
      End;
    End;
  Finally
    FreeAndNil(qryPon);
  End;
end;

function TLibNfe.fVerificarStatusNota(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): TRetornoNFE;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, opEnvio);

  Result := fVerificarStatusNotaInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
    strCodCli, strTip_FC);
end;

function TLibNfe.fVerificarStatusNotaInterna(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): TRetornoNFE;
  Var
    fonte: IFonteDados;
    service: INFEService;
    retornoNFE: TRetornoNFE;

    strStatus: String;
begin
  pSetaConfiguracoesPainel(VS_confignfe);

 {$IFNDEF LINUX}
  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(VS_confignfe);
 {$ENDIF}

  fonte := fCriarFonteDadosBD(Self.Banco, strNumDoc, strEspDoc,
    strCodEmp, strCodCli, strSerie, strTip_FC);

  fonte.pSetaPathSatCitel(VS_PathSat);
  service := fCriarNFEService(fonte);

  Try
    fonte.pCarregarDados;
    service.fVerificarStatusNota(strNumDoc, strSerie);

    retornoNFE := service.fProcessarStatusNota;
    While (Not retornoNFE.Sucesso) Do
    Begin
      Application.ProcessMessages;
      Sleep(500);
      retornoNFE := service.fProcessarStatusNota;
    End;

    retornoNFE.SetaComoNaoSucesso;
    If retornoNFE.Inutilizada Then
      strStatus := 'IN'
    Else If retornoNFE.Denegada Then
      strStatus := 'DN'
    Else If retornoNFE.Cancelada Then
      strStatus := 'CN'
    Else If retornoNFE.Contingencia Then
      strStatus := 'EE'
    Else If retornoNFE.Aguardando Then
      strStatus := 'GE'
    Else If Not fEmptyStr(retornoNFE.ChaveAcesso) Then
    Begin
      strStatus := 'AT';
      retornoNFE.SetaComoSucesso;
    End
    eLSE
      strStatus := 'EE';

    Result := retornoNFE;

    pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strStatus, strStatus, Result);

    If retornoNFE.Sucesso Then
    Begin
      pAtualizarDadosAutcom(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, retornoNFE);
    End;

    {**********************************************************************************}
    {* CASO O DOWNLOAD DO XML TENHA FALHADO FAZ UMA NOVA TENTATIVA APÓS GRAVAR LOGNFE *}
    {******************************************************************REQ.:224932**VA*}
    If (strEspDoc = 'NF') And (strStatus = 'AT') Then
    Begin
      If (retornoNFE.Sucesso) Then
      Begin
        If (Not retornoNFE.Contingencia) Then
        Begin
          If (Not fonte.XMLJaBaixado(retornoNFE.ChaveAcesso)) Then
            fonte.pSalvarXMLNFeBD(retornoNFE.ChaveAcesso, service.fRetXmlNfe(retornoNFE.ChaveAcesso));
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
        strTip_FC, 'EE', E.Message);
      Raise Exception.Create('Erro ao enviar comando de status: ' + #13#10 + E.Message);
    End;
  End;
end;

function TLibNfe.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
var
  strError: string;
begin
  Result := fVerificarStatusServico(strCnpjEmitente, strIESEmitente, strError);
end;

function TLibNfe.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var AError: string): TRetornoStatusNFE;
  Var
    service: INFEService;
    fonte: IFonteDados;
    strRetornoConsulta: string;
begin
  pCarregarDll('', '', '', '', '', '', opEnvio);
  pSetaConfiguracoesPainel(VS_confignfe);
  fonte := fCriarFonteDadosEmitenteBD(Self.Banco, '', '', '', '', '', '');

  service := fCriarNFEService(fonte);

  Try
    Result := service.fVerificarStatusServico(strCnpjEmitente, strIESEmitente, strRetornoConsulta);
    if Result = rsErroGeral then
      AError := strRetornoConsulta;
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      AError := E.Message;
      If (Pos('conexão', AnsiLowerCase(E.Message)) > 0) Or
         (Pos('conectar', AnsiLowerCase(E.Message)) > 0) Or
         (Pos('connect', AnsiLowerCase(E.Message)) > 0) Then
      Begin
        Result := rsTimeoutIntegrador;
      End
      Else
      Begin
        Raise;
      End;
    End;
  End;
end;

function TLibNfe.fVerificarStatusServicoPelaUF(strUF: string): TRetornoStatusNFE;
  Var
    strError: string;
begin
  Result := Self.fVerificarStatusServicoPelaUF(strUF, strError);
end;

function TLibNfe.fRetCodigoEmpresaNaFit: String;
  Var
    AmbienteEmpresa: IAmbienteEmpresaService;
    objConfigSovos: TConfiguracoesNFE;
    strValCfgMDEVAR: String;
    LstrCnpj:String;
    LstrIes: String;
    LstrUF:  String;
begin
  objConfigSovos := TConfiguracoesNFE.Create;
  objConfigSovos.strFitUrlWebService := fCfgSisPainel('CITURL');
  objConfigSovos.strFitLicenca       := fCfgSisPainel('CITLIC');
  objConfigSovos.strFitUsuario       := fCfgSisPainel('CITUSU');
  objConfigSovos.strFitSenha         := fCfgSisPainel('CITSEN');
  strValCfgMDEVAR := '';
  If fExisteConfiguracao('MDEVAR') Then
    strValCfgMDEVAR := fCfgSisPainel('MDEVAR');

  If fDadosEmitenteStatusServico(LstrCnpj, LstrIes, LstrUF, nil) Then
  Begin
    AmbienteEmpresa := fCriarAmbienteEmpresaServiceFIT(objConfigSovos, LstrCnpj, strValCfgMDEVAR);
    Try
      Result := AmbienteEmpresa.fCodigoEmpresaNaFit;
    Except
      //
    End;
  End;

  If Assigned(objConfigSovos) Then
    FreeAndNil(objConfigSovos);
end;

function TLibNfe.fVerificarStatusServicoPelaUF(strUF: string; var strError: string): TRetornoStatusNFE;
  Var
    VerificarStatusServico: IVerificarStatusServicoService;
    objConfigSovos: TConfiguracoesNFE;
    strRetornoConsulta: string;
    strValCfgMDEVAR: String;
begin
  objConfigSovos := TConfiguracoesNFE.Create;
  objConfigSovos.strFitUrlWebService := fCfgSisPainel('CITURL');
  objConfigSovos.strFitLicenca       := fCfgSisPainel('CITLIC');
  objConfigSovos.strFitUsuario       := fCfgSisPainel('CITUSU');
  objConfigSovos.strFitSenha         := fCfgSisPainel('CITSEN');
  strValCfgMDEVAR := '';
  If fExisteConfiguracao('MDEVAR') Then
    strValCfgMDEVAR := fCfgSisPainel('MDEVAR');

  VerificarStatusServico := fCriarVerificarStatusServicoPelaUFServiceConfigurado(objConfigSovos);
  Try
    Result := VerificarStatusServico.fVerificarStatusServicoPelaUF(strUF, strRetornoConsulta, strValCfgMDEVAR);
    If Result = rsErroGeral Then
      strError := strRetornoConsulta;
  Except
    On E: ErrosValidacaoNFE Do
    Begin
      strError := E.Message;
      If (Pos('conexão', AnsiLowerCase(E.Message)) > 0) Or
         (Pos('conectar', AnsiLowerCase(E.Message)) > 0) Or
         (Pos('connect', AnsiLowerCase(E.Message)) > 0) Then
      Begin
        Result := rsTimeoutIntegrador;
      End
      Else
      Begin
        If Assigned(objConfigSovos) Then
         FreeAndNil(objConfigSovos);

        Raise;
      End;
    End;
  End;

  If Assigned(objConfigSovos) Then
    FreeAndNil(objConfigSovos);
end;

function TLibNfe.fNotaFiscalJaAutorizada(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): Boolean;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil, Self.Banco);

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

function TLibNfe.fNumeroSerialNfe: Integer;
begin
  Result := fNumeroSerial;
end;

function TLibNfe.fEnviarManifestoEletronico(strNumMan, strEmpMan: String): Boolean;
begin
  Result := fEnviarManifestoEletronicoInterna(strNumMan, strEmpMan);
end;

function TLibNfe.fEnviarManifestoEletronicoInterna(strNumMan, strEmpMan: String): Boolean;
  Var
    fonte: IFonteDadosManifesto;
    service: IManifestoEletronicoSerivce;
    strErros: String;
    intContador: Integer;
    strStatusGravacaoLogNFe : string;
begin
  If fEmptyStr(strEmpMan) Then
    strEmpMan := VS_strCodEmp;

  Try
    pSetaConfiguracoesPainel(VS_confignfe);

   {$IFNDEF LINUX}
    If (handleBD <> 0) Then
      pSetaConfiguracoesBD(VS_confignfe);
   {$ENDIF}

    fonte := fCriarFonteDadosManifesto(Self.Banco);
    service := fCriarManifestoEletronicoService(fonte);

    Result := service.fEnviarManifesto(strNumMan);

    pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', MANIFESTO_STATUS_GERADO, '', '');

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

      if (Pos('em processamento', AnsiLowerCase(strErros)) > 0) then
        strStatusGravacaoLogNFe := MANIFESTO_STATUS_GERADO // Força o NfeStatus.exe verificar o retorno
      else
        strStatusGravacaoLogNFe := MANIFESTO_STATUS_ERRO;

      pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', strStatusGravacaoLogNFe, strErros);

      if (strStatusGravacaoLogNFe = MANIFESTO_STATUS_ERRO) then
        Raise Exception.Create('Erro ao enviar documento: ' + strErros)
      else
        Result := False;
    End;

    On E: Exception Do
    Begin
      pGravarLogNfe(strNumMan, 'ME', strEmpMan, fSerieManifesto(strEmpMan), '', '', MANIFESTO_STATUS_ERRO, E.Message);
    	Raise Exception.Create('Erro ao enviar documento: ' + E.Message);
    End;
  End;
end;

procedure pReimprimirDanfe(strChaveAcesso: String;
  strNumDocImp, strEspDocImp, strCodEmpImp, strSerieImp, strCodCliImp, strTip_FCImp: String);
  Var
    libnfe: TLibNfe;
begin
  Try
    libnfe := TLibNfe.Create;
    libnfe.pReimprimirDanfe(strChaveAcesso, strNumDocImp, strEspDocImp, strCodEmpImp,
      strSerieImp, strCodCliImp, strTip_FCImp);
  Finally
    FreeAndNil(libnfe);
  End;
end;

function fListagemNotasLibNfe(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
  intTipo, intStatus: Integer): TStringList;
  Var
    libnfe: TLibNfe;
begin
  libnfe := TLibNfe.Create;
  Try
    Try
      Result := libnfe.fListagemNotas(strCodEmp, dtaDtaIni, dtaDtaFin, intTipo, intStatus);
    Except
      Result := TStringList.Create;
    End;
  Finally
    FreeAndNil(libnfe);
  End;
end;

function fEnviarManifestoEletronico(strNumMan, strEmpMan: String): Boolean;
  Var
    libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create;
  Try
    Result := libnfe.fEnviarManifestoEletronico(strNumMan, strEmpMan);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fProcessarRetornoManifestoEletronico(strNumMan: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; strEmpMan: String=''): Boolean;
  Var
    libNfe: TLibNfe;
begin
  If fEmptyStr(strEmpMan) Then
    strEmpMan := VS_strCodEmp;

  libnfe := TLibNfe.Create(Banco);
  Try
    Result := libnfe.fProcessarRetornoManifestoEletronico(strNumMan, strEmpMan);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fEnviarConhecimentoEletronico(strNumCTe, strSerie: String): Boolean;
var
  libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create;
  Try
    Result := libnfe.fEnviarConhecimentoEletronico(strNumCTe, strSerie);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fProcessarRetornoConhecimentoEletronico(strNumCTe, strSerie: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): Boolean;
var
  libNfe: TLibNfe;
begin
  libnfe := TLibNfe.Create(Banco);
  Try
    Result := libnfe.fProcessarRetornoConhecimentoEletronico(strNumCTe, strSerie);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fConsultaCadastro(const strUf, strCnpj, strIe: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): TRetornoConsultaCadastro;
  Var
    libNfe : TLibNfe;
begin
  libnfe := TLibNfe.Create(Banco);
  Try
    Result := libnfe.fConsultaCadastro(strUf, strCnpj, strIe);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fVerificarStatusServicoPelaUF(strUF: string; var strError: string): TRetornoStatusNFE; overload;
  Var
    libNfe : TLibNfe;
begin
  libNfe := TLibNfe.Create;
  Try
    Result := libNfe.fVerificarStatusServicoPelaUF(strUF, strError);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fVerificarStatusServicoPelaUF(strUF: string): TRetornoStatusNFE;
  Var
    libNfe  : TLibNfe;
    strError: String;
begin
  libNfe := TLibNfe.Create;
  Try
    Result := libNfe.fVerificarStatusServicoPelaUF(strUF, strError);
  Finally
    FreeAndNil(libNfe);
  End;
end;

function fRetCodigoEmpresaNaFit: String;
  Var
    libNfe  : TLibNfe;
begin
  libNfe := TLibNfe.Create;
  Try
    Result := libNfe.fRetCodigoEmpresaNaFit;
  Finally
    FreeAndNil(libNfe);
  End;
end;

procedure pGravaNfeTempo(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie,
  strTip_FC: String; dtaIniOpe, dtaFimOpe: TDateTime; intCodEve: Integer; strDesEve: String;
  blnAtualizar: Boolean; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
  Var
    qryIns: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fCfgSisPainel('CITMON', Banco) <> 'S' Then
    Exit;

  pLogImp('pGravaNfeTempo >');
  pLogImp('Atenção: CFG_CITMON está ATIVADA. Desative se não precisar olhar NFE_TEMPO!');

  qryIns := fCriaQuery(Nil, Banco);
  If blnAtualizar Then
  Begin
    qryIns.SQL.Add('UPDATE NFE_TEMPO SET ');
    qryIns.SQL.Add('  NFE_FIMOPE = :FIMOPE ');
    qryIns.SQL.Add('WHERE ');
    qryIns.SQL.Add('  NFE_ORIGEM = :ORIGEM AND ');
    qryIns.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
    qryIns.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
    qryIns.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
    qryIns.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
    qryIns.SQL.Add('  NFE_SERIE_ = :SERIE_ AND ');
    qryIns.SQL.Add('  NFE_TIP_FC = :TIP_FC AND ');
    qryIns.SQL.Add('  NFE_CODEVE = :CODEVE ');
    qryIns.SQL.Add('ORDER BY NFE_INIOPE DESC ');
    qryIns.SQL.Add('LIMIT 1');
  End
  Else
  Begin
    qryIns.SQL.Add('INSERT INTO NFE_TEMPO ( ');
    qryIns.SQL.Add('  NFE_ORIGEM, ');
    qryIns.SQL.Add('  NFE_NUMDOC, ');
    qryIns.SQL.Add('  NFE_ESPDOC, ');
    qryIns.SQL.Add('  NFE_CODEMP, ');
    qryIns.SQL.Add('  NFE_CODCLI, ');
    qryIns.SQL.Add('  NFE_SERIE_, ');
    qryIns.SQL.Add('  NFE_TIP_FC, ');
    qryIns.SQL.Add('  NFE_INIOPE, ');
    qryIns.SQL.Add('  NFE_FIMOPE, ');
    qryIns.SQL.Add('  NFE_CODEVE, ');
    qryIns.SQL.Add('  NFE_DESEVE) ');
    qryIns.SQL.Add('VALUES ( ');
    qryIns.SQL.Add('  :ORIGEM, ');
    qryIns.SQL.Add('  :NUMDOC, ');
    qryIns.SQL.Add('  :ESPDOC, ');
    qryIns.SQL.Add('  :CODEMP, ');
    qryIns.SQL.Add('  :CODCLI, ');
    qryIns.SQL.Add('  :SERIE_, ');
    qryIns.SQL.Add('  :TIP_FC, ');
    qryIns.SQL.Add('  :INIOPE, ');
    qryIns.SQL.Add('  :FIMOPE, ');
    qryIns.SQL.Add('  :CODEVE, ');
    qryIns.SQL.Add('  :DESEVE) ');
  End;

  qryIns.ParamByName('ORIGEM').AsString := 'PainelNFe';
  qryIns.ParamByName('NUMDOC').AsString := strNumDoc;
  qryIns.ParamByName('ESPDOC').AsString := strEspDoc;
  qryIns.ParamByName('CODEMP').AsString := strCodEmp;
  qryIns.ParamByName('CODCLI').AsString := strCodCli;
  qryIns.ParamByName('SERIE_').AsString := strSerie;
  qryIns.ParamByName('TIP_FC').AsString := strTip_FC;
  qryIns.ParamByName('FIMOPE').AsDateTime := dtaFimOpe;
  qryIns.ParamByName('CODEVE').AsInteger := intCodEve;

  If Not blnAtualizar Then
  Begin
    qryIns.ParamByName('INIOPE').AsDateTime := dtaIniOpe;
    qryIns.ParamByName('DESEVE').AsString := strDesEve;
  End;

  qryIns.ExecSQL;

  FreeAndNil(qryIns);
  pLogImp('pGravaNfeTempo <');
end;

function TLibNfe.fSerieManifesto(strEmpMan: String): string;
begin
  Result := '001';
  if fExisteConfiguracao('SERMDF') then
    Result := fCfgSis('SERMDF', varString, strEmpMan);
end;

function TLibNfe.fUsaNotaServicoEletronicaEnotas: Boolean;
begin
  Result := False;

  if fExisteConfiguracao('NFSENO') then
    Result := (fCfgSis('NFSENO') = 'S');
end;

function TLibNfe.fStatusDocumento(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC: String): TRetornoNFE;
  Var
    fonte: IFonteDados;
    service: INFEService;
begin
  pCarregarDll(strNumDoc, strEspDoc, strCodEmp, strSerie,strCodCli, strTip_FC, opEnvio);
  pSetaConfiguracoesPainel(VS_confignfe);

 {$IFNDEF LINUX}
  If (handleBD <> 0) Then
    pSetaConfiguracoesBD(VS_confignfe);
 {$ENDIF}

  fonte := fCriarFonteDadosBDSet(Self.Banco, strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie, strTip_FC);

  service := fCriarNFEService(fonte);
  Result := service.fProcessarStatusNota;
end;

function TLibNfe.fGetCampoDPEC(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Integer;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := 0;
  Try
    qryAux := fCriaQuery(Nil, Self.Banco);

    With qryAux, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT ');
      Add('  NFE_PNDPEC ');
      Add('FROM ');
      Add('  LOGNFE ');
      Add('WHERE ');
      Add('  NFE_NUMDOC = :NUMDOC AND ');
      Add('  NFE_ESPDOC = :ESPDOC AND ');
      Add('  NFE_CODEMP = :CODEMP AND ');
      Add('  NFE_TIP_FC = :TIP_FC AND ');
      Add('  NFE_CODCLI = :CODCLI AND ');
      Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('SERIE_').AsString := strSerie;
      ParamByName('TIP_FC').AsString := strTip_FC;

      Open;

      if not isEmpty then
        Result := FieldByName('NFE_PNDPEC').AsInteger ;
    End;
  Finally
    FreeAndNil(qryAux);
  End;

End;

function TLibNfe.fImpressoraArqIniSatIntegrador: String;
var
  LstrDirIni: String ;
begin
  pLogImp('fImpressoraArqIniSatIntegrador > ');

  LstrDirIni := fArqIni(0, 'GERAL', 'PATSAT', '', 'opcoes_integrador_sat.ini');

  Result := fArqIni(0, 'SATCFE', 'IMPRESSORA', '', LstrDirIni + PATH_SEPARATOR + 'opcoes_sat.ini');

  pLogImp('fImpressoraArqIniSatIntegrador < ' + Result);
end;

function TLibNfe.fImpressoraLogSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): String;
var
  qryCadFis: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := '' ;

  pLogImp('fImpressoraLogSat > ');

  if not fCampoExiste('LOGSAT', 'NFE_IMPRES') then
  begin
    pLogImp('fImpressoraLogSat < LOGSAT-NFE_IMPRES (NÃO EXISTE)');
    exit;
  end;

  qryCadFis := fCriaQuery(Nil, Self.Banco);
  try
    qryCadFis.SQL.Add(' SELECT NFE_IMPRES ');
    qryCadFis.SQL.Add('     FROM LOGSAT ');
    qryCadFis.SQL.Add('     WHERE NFE_NUMDOC = :NUMDOC ');
    qryCadFis.SQL.Add('           AND NFE_ESPDOC = :ESPDOC ');
    qryCadFis.SQL.Add('           AND NFE_CODEMP = :CODEMP ');
    qryCadFis.SQL.Add('           AND NFE_CODCLI = :CODCLI ');
    qryCadFis.SQL.Add('           AND NFE_SERIE_ = :SERIE_ ');
    qryCadFis.SQL.Add('           AND  NFE_TIP_FC = :TIP_FC ');
    qryCadFis.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCadFis.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCadFis.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFis.ParamByName('CODCLI').AsString := strCodCli;
    qryCadFis.ParamByName('TIP_FC').AsString := strTip_FC;
    qryCadFis.ParamByName('SERIE_').AsString := strSerie;
    qryCadFis.Open;
    if not qryCadFis.IsEmpty then
      Result := qryCadFis.FieldByName('NFE_IMPRES').AsString ;
  finally
    FreeAndNil(qryCadFis);
  end;

  pLogImp('fImpressoraLogSat < ' + Result);
end;

procedure TLibNfe.pAcertaDataHoraEmissao(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie, strTip_FC: String; dtaEmissao: TDateTime);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strTabGer: String;
    strTabDet: String;
begin
  If not (pos(strEspDoc, 'NS_IF_') > 0) Then
    Exit;

  If dtaEmissao <= 0 Then
    Exit;

  If fGetCampoDPEC(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC) = 1 Then
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

procedure TLibNfe.pAtualizarMensagensCupomFiscal(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli, strTip_FC, strQRCode, strProtocolo, strObsFisco: String;
  dtaAutorizacao, dtaEmissao: TDateTime; blnNFCeOffLine: Boolean = False);
  Var
    qryMovObs: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryMovGer: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

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
  If Not fCampoExiste('MOVOBS', 'MOV_QRCODE') Then
    Exit;

  If Not fCampoExiste('MOVOBS', 'MOV_PROTOC') Then
    Exit;

  If Not fCampoExiste('MOVOBS', 'MOV_DPROTO') Then
    Exit;

  If Not fCampoExiste('MOVOBS', 'MOV_OBSFIS') Then
    Exit;

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
  strSQL := strSQL + '  IF(:TIP_FC = "C", GER_CODCLI, GER_CODFOR) = :CODCLI AND ';
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

    If blnNFCeOffLine And fCampoExiste(strTabela, 'MOV_STAOFF') Then
    Begin
      qryMovObs.SQL.Add('  MOV_STAOFF = :STAOFF, ');
    End;

    qryMovObs.SQL.Add('  MOV_OBSFIS = CONCAT(COALESCE(MOV_OBSFIS, ""), IF(COALESCE(MOV_OBSFIS, "") <> "", "\n", ""), :OBSFIS) ');
    qryMovObs.SQL.Add('WHERE ');
    qryMovObs.SQL.Add('  MOV_SEQGER = :SEQGER');

    qryMovObs.ParamByName('QRCODE').AsString := strQRCode;
    qryMovObs.ParamByName('PROTOC').AsString := strProtocolo;
    qryMovObs.ParamByName('DPROTO').AsDateTime := dtaAutorizacao;

    If blnNFCeOffLine And fCampoExiste(strTabela, 'MOV_STAOFF') Then
    Begin
      qryMovObs.ParamByName('STAOFF').AsString := 'AT';
    End;

    qryMovObs.ParamByName('OBSFIS').AsString := strObsFisco;
    qryMovObs.ParamByName('SEQGER').AsString := strAutInc;
    qryMovObs.ExecSQL;
    FreeAndNil(qryMovObs);
  End;
end;

procedure TLibNfe.pAtualizaLogNfeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strStatus, strObserv: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil, Self.Banco);

  Try
    qryAux.SQL.Add('UPDATE LOGNFE SET ');
    qryAux.SQL.Add('  NFE_STATUS = :STATUS, ');
    qryAux.SQL.Add('  NFE_OBSERV = :OBSERV, ');
    qryAux.SQL.Add('  NFE_DTAAUT = nOw()    ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_ AND ');
    qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  NFE_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('STATUS').AsString := strStatus;
    qryAux.ParamByName('OBSERV').AsString := strObserv;

    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLibNFe.fCarregarArquivoSAT(blnEnviar: Boolean; strChave, strNSerie: String): String;
  Var
    strArquivo: String;
    stlArq: TStringList;
begin
  strArquivo := fSepDir(ExtractFilePath(Application.ExeName) + 'XMLSAT') +
                FormatDateTime('yyyymmdd', Date) + PATH_SEPARATOR + strNSerie + PATH_SEPARATOR + IIF(blnEnviar, '', 'CANC_') + strChave + '.XML';

  stlArq := TStringList.Create;
  Try
    stlArq.LoadFromFile(strArquivo);
    Result := stlArq.Text;
    Result := AnsiReplaceStr(Result, #13#10, '<<csq>>');
    Result := AnsiReplaceStr(Result, #10#13, '<<csq>>');
  Finally
    FreeAndNil(stlArq);
  End;
end;

procedure TLibNfe.pSalvarXMLSat(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String;
  blnEnviar: Boolean; retorno: TRetornoNFe);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strAutoInc: String;
begin
  If (strEspDoc <> 'IF') Then
    Exit;

  If (Not fUsaSat) Then
    Exit;

  pLogImp('pSalvarXMLSat > '+strNumDoc + strEspDoc + strCodEmp + strSerie + strCodCli + strTip_Fc);

  qryAux := fCriaQuery(Nil, Self.Banco);
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

  pLogImp('pSalvarXMLSat <');
end;

function fTemNotaServicoAnteriorPendente(strNumDoc, strCodEmp: String; out strUltNot: string): Boolean;
Var
  strSQL: String;
  qryGenNFE: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  Try
    qryGenNFE := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT    ';
    strSQL := strSQL + '  NFE_NUMDOC  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  LOGNFE  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  NFE_STATUS NOT IN("AT","CN","OK","DC","IN") AND  ';
    strSQL := strSQL + '  NFE_ESPDOC = "NS"    AND ';
    strSQL := strSQL + '  NFE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  NFE_NUMDOC < :NUMDOC  ';

    With qryGenNFE Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMDOC').AsString := strNumDoc;

      Open;

      Result := (Not IsEmpty);

      If Result Then
        strUltNot := qryGenNFE.Fields[0].AsString;
    End;

  Finally
    FreeAndNil(qryGenNFE);
  End;

end;

procedure TLibNfe.pBuscaInformacoesParaGravacaoLogNfe(const strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String; var recInfLog: TInfParaLogNfe);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnBuscaViaNfe: Boolean;
    blnBuscaPonImp: Boolean;
Begin
  FillChar(recInfLog, SizeOf(recInfLog), #0);

  recInfLog.intViaNfe := -1;
  recInfLog.intPndPec :=  0;
  recInfLog.dtaDtaEnt :=  0;
  recInfLog.strExiFis := 'N';
  recInfLog.strJahAut := 'N';

  qryAux := fCriaQuery(Nil, Self.Banco);
  Try
    blnBuscaViaNfe := ((Pos(strEspDoc, 'NF_IF_')) > 0) And (fCampoExiste('LOGNFE', 'NFE_VIANFE', qryAux.Connection));
    blnBuscaPonImp := (fCampoExiste('LOGNFE', 'NFE_PONIMP', qryAux.Connection));

    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('   F.AUTOINCREM AS FIS_AUTINC, ');
    qryAux.SQL.Add(IIF(blnBuscaViaNfe,' COALESCE(L.NFE_VIANFE, -1) ',' -1 ')    + ' AS NFE_VIANFE, ');
    qryAux.SQL.Add(IIF(blnBuscaPonImp,' L.NFE_PONIMP ',' CAST("" AS CHAR(1)) ') + ' AS NFE_PONIMP, ');
    qryAux.SQL.Add('   L.NFE_PNDPEC,     ');
    qryAux.SQL.Add('   L.NFE_STATUS,     ');
    qryAux.SQL.Add('   F.FIS_DTAENT,     ');
    qryAux.SQL.Add('   F.FIS_ACESSO,     ');
    qryAux.SQL.Add('   F.FIS_ORIDOC      ');
    qryAux.SQL.Add('  FROM CADFIS F      ');
    qryAux.SQL.Add('       LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = F.FIS_NUMDOC ');
    qryAux.SQL.Add('                         AND L.NFE_ESPDOC = F.FIS_ESPDOC ');
    qryAux.SQL.Add('                         AND L.NFE_CODEMP = F.FIS_CODEMP ');
    qryAux.SQL.Add('                         AND L.NFE_CODCLI = F.FIS_FORCLI ');
    qryAux.SQL.Add('                         AND L.NFE_TIP_FC = F.FIS_TIP_FC ');
    qryAux.SQL.Add('                         AND IFNULL(L.NFE_SERIE_, "") = IFNULL(F.FIS_SERIE_, "") ');
    qryAux.SQL.Add(' WHERE F.FIS_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('       F.FIS_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('       F.FIS_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('       F.FIS_FORCLI = :CODCLI AND ');
    qryAux.SQL.Add('       IFNULL(F.FIS_SERIE_, "") = :SERIE_ AND ');
    qryAux.SQL.Add('       F.FIS_TIP_FC = :TIP_FC ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;

    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin
      recInfLog.strExiFis := IIF(fEmptyStr(qryAux.FieldByName('FIS_AUTINC').AsString),'N','S');
      recInfLog.intViaNfe := qryAux.FieldByName('NFE_VIANFE').AsInteger;
      recInfLog.intPndPec := qryAux.FieldByName('NFE_PNDPEC').AsInteger;
      recInfLog.strPonImp := qryAux.FieldByName('NFE_PONIMP').AsString;
      If (qryAux.FieldByName('FIS_ORIDOC').AsString = 'V') Then
      Begin
        recInfLog.dtaDtaEnt := qryAux.FieldByName('FIS_DTAENT').AsDateTime;
        If (Not fDataValida(recInfLog.dtaDtaEnt)) Then
          recInfLog.dtaDtaEnt := 0;
      End;
      If (qryAux.FieldByName('NFE_STATUS').AsString = 'AT') Then
      Begin
        If (Not fEmptyStr(qryAux.FieldByName('FIS_ACESSO').AsString)) Then
          recInfLog.strJahAut := 'S';
      End;
    End;

    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLibNfe.fConsultaCadastro(const strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
  Var
    fonte : IFonteDados;
    service : INFEAdministrativoService;
begin
  pSetaConfiguracoesPainel(VS_confignfe);
  fonte := fCriarFonteDadosEmitenteBD(Self.Banco, '', '', '', '', '', '');
  service := fCriarNFEAdministrativoService(fonte);
  Result := service.fConsultaCadastro(strUf, strCnpj, strIe);
end;

{$IFDEF LINUX}
procedure LoadMethods;
begin
  pSetaConfiguracoesPainel := @untFuncoesDll.pSetaConfiguracoesPainel;
  pSetaConfiguracoes := @untFuncoesDll.pSetaConfiguracoes;
  pCarregaConfiguracoesLib := @untFuncoesDll.pCarregaConfiguracoesLib;
  fCriarFonteDadosBD := @untFuncoesDll.fCriarFonteDadosBD;
  fCriarFonteDadosEmitenteBD := @untFuncoesDll.fCriarFonteDadosEmitenteBD;
  fCriarNFEService := @untFuncoesDll.fCriarNFEService;
  fCriarNFEAdministrativoService := @untFuncoesDll.fCriarNFEAdministrativoService;
  fCriarManifestoEletronicoService := @untFuncoesDll.fCriarManifestoEletronicoService;
  fCriarFonteDadosManifesto := @untFuncoesDll.fCriarFonteDadosManifesto;
  fCriarConhecimentoEletronicoService := @untFuncoesDll.fCriarConhecimentoEletronicoService;
  fCriarFonteDadosConhecimento := @untFuncoesDll.fCriarFonteDadosConhecimento;
  fSVN_RevisionLibNfe := @untFuncoesDll.fSVN_RevisionLibNfe;
  pSetVirtualUIPrintPDF := @untFuncoesDll.pSetVirtualUIPrintPDF;
  pSetOnNotificarProgresso := @untFuncoesDll.pSetOnNotificarProgresso;
  dxInitializeLibNfe := @untFuncoesDll.dxInitializeLibNfe;
  dxFinalizeLibNfe := @untFuncoesDll.dxFinalizeLibNfe;
  pSetaPidMD5DicSisLibNfe := @untFuncoesDll.pSetaPidMD5DicSisLibNfe;
  fCriarEnviarArquivosService := @untFuncoesDll.fCriarEnviarArquivosService;
  fCriarEnviarArquivosServiceConfigurado := @untFuncoesDll.fCriarEnviarArquivosServiceConfigurado;
  fCriarVerificarStatusServicoPelaUFServiceConfigurado := @untFuncoesDll.fCriarVerificarStatusServicoPelaUFServiceConfigurado;
  fCriarImportaXMLTerceirosServiceFITConfigurado := @untFuncoesDll.fCriarImportaXMLTerceirosServiceFITConfigurado;
  fCriarEventoConciliacaoFinanceiraServiceFITConfigurado := @untFuncoesDll.fCriarEventoConciliacaoFinanceiraServiceFITConfigurado;
  fCriarAuditarDocumentoServiceFIT := @untFuncoesDll.fCriarAuditarDocumentoServiceFIT;
  fCriarAmbienteEmpresaServiceFIT := @untFuncoesDll.fCriarAmbienteEmpresaServiceFIT;
end;
{$ENDIF}

initialization

{$IFDEF LINUX}
  LoadMethods;
{$ELSE}
  handleBD := LoadLibrary({$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280)}PWideChar{$ELSE}PChar{$IFEND}('libNfeBD.dll'));
{$ENDIF}

finalization

 {$IFNDEF LINUX}
  If handleBD <> 0 Then
    FreeLibrary(handleBD);
 {$ENDIF}

  If Assigned(VS_confignfe) Then
    FreeAndNil(VS_confignfe);

end.
