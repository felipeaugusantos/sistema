unit untFuncoesDll;

interface

uses
{$IF Defined(VER250) Or Defined(UNIDAC)}
  Uni, {$IFNDEF LINUX}dxCore,{$ENDIF}
{$ELSE}
  ZConnection,
{$IFEND}
  untUtilBD,
  untNFEServiceImpl,
  untManifestoEletronico,
  untInterfacesManifestoEletronico,
  untInterfacesIntegradorSAT,
  untIntegradorSAT,
  untUtilBDEnt,
  untConhecimentoEletronico,
  untConfigNFE,
  untInterfaces,
  untFonteDados,
  untInterfacesConhecimentoEletronico,
  SysUtils,
  Contnrs;

procedure pSetaConfiguracoes(objCfgNFE: TConfiguracoesNFE); stdcall;
procedure pSetaConfiguracoesPainel(objCfgNFE: TConfiguracoesNFE); stdcall;
function fCriarFonteDadosBD(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall;
function fCriarFonteDadosBDEnt(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String; strArqEnt: String): IFonteDados; stdcall;
function fCriarFonteDadosEmitenteBD(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados; stdcall;
function fCriarNFEService(fonteDados: IFonteDados): INFEService; stdcall;
function fCriarNFEServiceEnt(fonteDados: IFonteDados): INFEService; stdcall;
function fCriarNFEAdministrativoService(fonteDados: IFonteDados): INFEAdministrativoService; stdcall;

function fCriarManifestoEletronicoService(fonteDados: IFonteDadosManifesto): IManifestoEletronicoSerivce; stdcall;
function fCriarFonteDadosManifesto(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}): IFonteDadosManifesto; stdcall;

function fCriarConhecimentoEletronicoService(fonteDados: IFonteDadosConhecimento; fonteDadosBD: IFonteDados): IConhecimentoEletronicoService; stdcall;
function fCriarFonteDadosConhecimento(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}): IFonteDadosConhecimento; stdcall;

//NÃO USAR MAIS pCarregaConfiguracoesLib (ELA FOI CRIADA PARA ENVIAR XML/SAT MAS ELA DEIXAR PRESA UMA CONEXÃO PRESA)
procedure pCarregaConfiguracoesLib(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}); stdcall;
function fCriarEnviarArquivosService: IEnviarArquivosService; stdcall;
function fCriarEnviarArquivosServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IEnviarArquivosService; stdcall;
function fCriarVerificarStatusServicoPelaUFServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IVerificarStatusServicoService; stdcall;
function fCriarImportaXMLTerceirosServiceFITConfigurado(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'; strSeparador: String=''): IImportaXMLTerceirosArquivosService; stdcall;
function fCriarAuditarDocumentoServiceFIT(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IAuditarDocumentoServiceFIT; stdcall;
function fCriarAmbienteEmpresaServiceFIT(AobjConfigSovos: TConfiguracoesNFE; AstrCNPJ: String; AstrValCfgMDEVAR: String='0'; AstrModelo: String = '55'): IAmbienteEmpresaService; stdcall;
function fCriarEventoConciliacaoFinanceiraServiceFITConfigurado(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IEventoConciliacaoFinanceiraService; stdcall;
function fCriarIntegradorSAT(strPastaInput, strPastaOutput: String; intTimeOut: Integer; strComponente: String): IIntegradorSAT; stdcall;

function fSVN_RevisionLibNfe: String; stdcall;

function fCriarNFEServiceImpl(fonteDados: IFonteDados): TNFEServiceImpl;
function fCriarNFEServiceImplEnt(fonteDados: IFonteDados): TNFEServiceImpl;

function fNumeroSerial: Integer; stdcall;

function fGetDisparadorEventos: IDisparadorEventos; stdcall;

procedure pSetVirtualUIPrintPDF(AObj: IVirtualUIPrintPDF); stdcall;
{$IF Defined(VER250) Or Defined(UNIDAC)}
procedure dxInitializeLibNfe; stdcall;
procedure dxFinalizeLibNfe; stdcall;
procedure pSetaPidMD5DicSisLibNfe(const AstrPidMD5DicSis: string); stdcall;
{$IFEND}

{$IF Defined(VER180)}
{$ELSE}
procedure pSetOnNotificarProgresso(AProc: TOnNotificarProgresso); stdcall;
{$IFEND}

implementation

uses
  untUtil,
  untValidadorNFE,
  untManifestoEletronicoServiceImpl,
  untConhecimentoEletronicoServiceImpl,
  untDisparadorEventos,
  untEnviarArquivosServiceFIT,
  untImportaXMLTerceirosServiceFIT,
  untAuditarDocumentoServiceFIT,
  untEventoConciliacaoFinanceiraServiceFIT,
  untDicSis, untUtilFIT;

procedure pSetaConfiguracoes(objCfgNFE: TConfiguracoesNFE);
begin
  objConfig := objCfgNFE;

  If (Length(objConfig.strCodEmp) = 3) Then
    VS_strCodPnlDir := objConfig.strCodEmp;
end;

procedure pSetaConfiguracoesPainel(objCfgNFE: TConfiguracoesNFE);
begin
  If Not Assigned(objConfig) Then
  Begin
    objConfig := objCfgNFE;
  End
  Else
  Begin
    Try
      objConfig.strClaSub := objConfig.strClaSub;
    Except
      objConfig := objCfgNFE;
    End;
  End;

  If (Length(objConfig.strCodEmp) = 3) Then
    VS_strCodPnlDir := objConfig.strCodEmp;
end;

function fCriarFonteDadosBD(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados;
begin
  Result := TFonteDadosBD.Create(Database, strNumDoc, strEspDoc, strCodEmp,
    strCodCli, strSerie, strTip_FC);
end;

function fCriarFonteDadosBDEnt(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
        strCodEmp, strCodCli, strSerie, strTip_FC: String; strArqEnt: String): IFonteDados;
begin
  Result := TFonteDadosBDEnt.Create(Database, strNumDoc, strEspDoc, strCodEmp,
    strCodCli, strSerie, strTip_FC, False, strArqEnt)
end;

function fCriarFonteDadosEmitenteBD(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}; strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strSerie, strTip_FC: String): IFonteDados;
begin
  Result := TFonteDadosBD.Create(Database, strNumDoc, strEspDoc, strCodEmp,
    strCodCli, strSerie, strTip_FC, True);
end;

function fCriarNFEService(fonteDados: IFonteDados): INFEService;
begin
  Result := fCriarNFEServiceImpl(fonteDados);
end;

function fCriarNFEServiceEnt(fonteDados: IFonteDados): INFEService;
begin
  Result := fCriarNFEServiceImplEnt(fonteDados);
end;

function fCriarNFEAdministrativoService(fonteDados: IFonteDados): INFEAdministrativoService;
begin
  Result := fCriarNFEServiceImpl(fonteDados);
end;

function fCriarManifestoEletronicoService(fonteDados: IFonteDadosManifesto): IManifestoEletronicoSerivce;
begin
  Result := TManifestoEletronicoServiceImpl.Create(fonteDados,
    TManifestoEletronicoFactory.CreateIntegracaoManifesto(fonteDados));
end;

function fCriarConhecimentoEletronicoService(fonteDados: IFonteDadosConhecimento; fonteDadosBD: IFonteDados): IConhecimentoEletronicoService;
begin
  Result := TConhecimentoEletronicoServiceImpl.Create(fonteDados, TConhecimentoEletronicoFactory.CreateIntegracaoConhecimento(fonteDadosBD));
end;

function fCriarNFEServiceImpl(fonteDados: IFonteDados): TNFEServiceImpl;
  Var
    formatador: IFonteDadosFormatador;
    validador: IValidadorNFE;
    NFE: INFE;
    factory: INFEFactory;
begin
  Try
    fonteDados.pCarregaConfiguracoesInternas(objConfigInterna);
  Except
  End;

  formatador := TFonteDadosFormatadorImpl.Create;
  formatador.pSetaFonteDados(fonteDados);

  If fNotaFiscalServicosEletronicaDef(fonteDados) then
  begin
    If fUsaNotaServicoEletronicaEnotas(fonteDados) Then
      factory := TNFSEnotasFactory.Create
    Else
      factory := TNFESFactory.Create
  end
  Else
    factory := TNFEFactory.Create;

  validador := TValidadorNFE.Create(factory.CreateValidadorItem);

  NFE := factory.CreateNFE(fonteDados);

  Result := TNFEServiceImpl.Create(fonteDados, formatador, validador, NFE);
end;

function fCriarNFEServiceImplEnt(fonteDados: IFonteDados): TNFEServiceImpl;
  Var
    formatador: IFonteDadosFormatador;
    validador: IValidadorNFE;
    NFE: INFE;
    factory: INFEFactory;
begin
  Try
    fonteDados.pCarregaConfiguracoesInternas(objConfigInterna);
  Except
  End;

  formatador := TFonteDadosFormatadorImpl.Create;
  formatador.pSetaFonteDados(fonteDados);

  If fNotaFiscalServicosEletronicaDef(fonteDados) then
    factory := TNFESFactory.Create
  Else
    factory := TNFEFactory.Create;

  validador := TValidadorNFE.Create(factory.CreateValidadorItem);

  NFE := factory.CreateNFEnt(fonteDados);

  Result := TNFEServiceImpl.Create(fonteDados, formatador, validador, NFE);
end;

{$IfDef VER150}
function fSVN_RevisionLibNfe: String;
Begin
  Result := '';
End;
{$Else}
function fSVN_RevisionLibNfe: String;
Begin

End;
{$EndIf}

function fCriarFonteDadosManifesto(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}): IFonteDadosManifesto;
begin
  Result := TFonteDadosBD.Create(Database);
end;

function fCriarFonteDadosConhecimento(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND}): IFonteDadosConhecimento;
begin
  Result := TFonteDadosBD.Create(Database);
end;

//NÃO USAR MAIS pCarregaConfiguracoesLib (ELA FOI CRIADA PARA ENVIAR XML/SAT MAS ELA DEIXAR PRESA UMA CONEXÃO PRESA)
procedure pCarregaConfiguracoesLib(Database: {$IF Defined(VER250) Or Defined(UNIDAC)}TUniConnection{$ELSE}TZConnection{$IFEND});
begin
  TFonteDadosBD.Create(Database);
end;

function fCriarEnviarArquivosService: IEnviarArquivosService;
begin
  Result := TEnviarArquivosServiceFIT.Create
end;

function fCriarEnviarArquivosServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IEnviarArquivosService;
begin
  Result := TEnviarArquivosServiceFIT.Create(objConfigSovos)
end;

function fCriarVerificarStatusServicoPelaUFServiceConfigurado(objConfigSovos: TConfiguracoesNFE): IVerificarStatusServicoService; stdcall;
begin
  Result := TVerificarStatusServicoService.Create(objConfigSovos);
end;

function fCriarImportaXMLTerceirosServiceFITConfigurado(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'; strSeparador: String=''): IImportaXMLTerceirosArquivosService;
begin
  Result := TImportaXMLTerceirosServiceFIT.Create(objConfigSovos, strValCfgMDEVAR, strSeparador);
end;

function fCriarAuditarDocumentoServiceFIT(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IAuditarDocumentoServiceFIT;
begin
  Result := TAuditarDocumentoServiceFIT.Create(objConfigSovos, strValCfgMDEVAR);
end;

function fCriarAmbienteEmpresaServiceFIT(AobjConfigSovos: TConfiguracoesNFE; AstrCNPJ: String; AstrValCfgMDEVAR: String='0'; AstrModelo: String = '55'): IAmbienteEmpresaService;
begin
  Result := TAmbienteEmpresa.Create(AobjConfigSovos, AstrCNPJ, AstrValCfgMDEVAR, AstrModelo);
end;

function fCriarEventoConciliacaoFinanceiraServiceFITConfigurado(objConfigSovos: TConfiguracoesNFE; strValCfgMDEVAR: string='0'): IEventoConciliacaoFinanceiraService; stdcall;
begin
  Result := TEventoConciliacaoFinanceiraServiceFIT.Create(objConfigSovos, strValCfgMDEVAR);
end;

function fCriarIntegradorSAT(strPastaInput, strPastaOutput: String; intTimeOut: Integer; strComponente: String): IIntegradorSAT;
begin
  Result := TIntegradorSAT.Create(strPastaInput, strPastaOutput, intTimeOut, strComponente);
end;

function fNumeroSerial: Integer;
begin
  Result := 1;
end;

function fGetDisparadorEventos: IDisparadorEventos;
begin
  Result := TDisparadorEventos.GetDisparador;
end;

procedure pSetVirtualUIPrintPDF(AObj: IVirtualUIPrintPDF);
begin
  untUtil.objVirtualUIPrintPDF := AObj;
end;

{$IF Defined(VER180)}
{$ELSE}
procedure pSetOnNotificarProgresso(AProc: TOnNotificarProgresso);
begin
  untUtil.OnNotificarProgresso := AProc;
end;
{$IFEND}

{$IF Defined(VER250) Or Defined(UNIDAC)}
procedure dxInitializeLibNfe;
begin
{$IFNDEF LINUX}
  dxInitialize;
{$ENDIF}
end;
{$IFEND}

{$IF Defined(VER250) Or Defined(UNIDAC)}
procedure dxFinalizeLibNfe;
begin
{$IFNDEF LINUX}
  dxFinalize;
{$ENDIF}
end;
{$IFEND}

{$IF Defined(VER250) Or Defined(UNIDAC)}
procedure pSetaPidMD5DicSisLibNfe(const AstrPidMD5DicSis: string);
begin
  VS_PidMD5DicSis := AstrPidMD5DicSis;
  VS_dicDicSis.Clear;
  VS_dicDicSis.TrimExcess;
end;
{$IFEND}

end.
