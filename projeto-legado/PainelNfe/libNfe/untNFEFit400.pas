unit untNFEFit400;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Dialogs, Forms,
{$ENDIF}
{$IF Defined(UNIDAC)}
  System.Generics.Collections,
{$IFEND}
  untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils,
  NfeApiWSBean, untConstantesNFe, Contnrs, untUtilFIT, untReformaTributaria,
  Types, DB, MaskUtils, untUtil;

Type
  TNFEFit400 = class(TInterfacedObject, INFE, INFEFit)
  private
    ReformaTributaria: TReformaTributaria;
    dadosEmitente: TDadosEmitente;
    dadosGerais: TDadosGerais;
    fonteDados: IFonteDados;
    fitWrapper: TWSNFeFitWrapper;
    stlArquivo: TStringList;

    lstItens: TObjectList;
    stlEmails: TStringList;
    stlEmailsTra: TStringList;

    fltTotalIcmsInterestadualDestino: Double;
    fltTotalIcmsInterestadualOrigem: Double;

    fltTotalBaseIcmsDesonerado: Double;
    fltTotalValorIcmsDesonerado: Double;

    fltToTalDesconto: Double;
    fltToTalProdutos: Double;

    fltAliqFCP: Double;
    fltTotalFCP: Double;
    fltTotalBaseFCP: Double;

    fltAliqFCP_189: Double;
    fltTotalFCP_189: Double;
    fltTotalBaseFCP_189: Double;

    fltAliqFCP_192: Double;
    fltTotalFCP_192: Double;
    fltTotalBaseFCP_192: Double;

    fltTotalIPIDevolvido : Double;
    fltTotalIPI: Double;

    fltTotalQtdeMonofasicoRetidoAnteriormente : Double;
    fltTotalIcmsMonofasicoRetidoAnteriormente : Double;

    fltBaseRetido: Double;
    fltValorRetido: Double;

    fltBaseEfetivo: Double;
    fltValorEfetivo: Double;

    fltBasIcmDif: Double;

    blnIcmsDesonerado : Boolean;
    blnIcmsDesoneradoX40: boolean;
    strProtocoloCartaCorrecao : String;
    strMensagemCartaCorrecao : String;

    blnInformarTagsObscontXCampoVendedor: Boolean;

    stlEmailsTraRed: TStringList;

    {$IF Defined(UNIDAC)}
    dicForTag: TDictionary<string, boolean>;
    {$IFEND}

    function fEstornoEntregaFutura : Boolean;
    procedure pExtraiDadosRetornoCartaCorrecao(const ARetornoFit: TWSNfeFitRetorno; var strProtocolo: String; var strMensagem: String);

    procedure pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
      var intTipoEmissao: Integer; var strChaveAcesso: String;
      var intStatus: Integer; var strMensagem, strProtocolo: String;
      var dtaDataAut: TDateTime; Var blnRejeitadaRecusada: Boolean;
      Var blnContingencia: Boolean; Var strContingenciaAutorizada: String);

    function fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno;
      arrStatusSucesso: array of Integer; intTipoEmissao: Integer;
      strChaveAcesso: String; intStatus: Integer; strMensagem,
      strProtocolo: String; dtaDataAut: TDateTime;
      blnIgnoraContingencia: Boolean; blnVerificarStatusEPEC: Boolean;
      blnRejeitadaRecusada: Boolean; blnProcessandoCancelamento: Boolean;
      blnContingencia: Boolean; strContingenciaAutorizada: String): TRetornoNFE;

    function fNotaContingencia(intTipoEmissao: Integer): Boolean;
    function fStatusAguardando(intStatus: Integer): Boolean;

    function fDataHora(const dta: TDateTime): String;
    function fData(const dta: TDateTime): String;
    function fValor(const fltValor: Double; intPrecisao, intDecimais: Integer): String;
    function fValorCond(blnCondicao: Boolean; fltValor: Double; intPrecisao, intDecimais: Integer; strElse: String=''): String;

    procedure pNFEHeader;
    procedure pNFE;
    procedure pNFEEntrega;
    procedure pNFETransporte;
    procedure pNFEDuplicata(Var fltFatura: Double);
    procedure pNFEFatura(fltFatura: Double);
    procedure pNFEEletronicaReferenciada;
    procedure pNFEModelo1AReferenciado;
    procedure pNFEECFReferenciado;
    procedure pNFEEDadosExportacao;
    procedure pNFEInformacoesDeProcessoReferenciado;
    procedure pNFEProdutosServicos;
    procedure pNFEProdutosIPI;
    procedure pNFEProdutoPIS;
    procedure pNFEProdutoCOFINS;
    procedure pNFEProdutoISSQN;
    procedure pNFEProdutoII;
    procedure pNFEProdutoDeclaracaoImportacao;
    procedure pNFEProdutoAdicoes;
    procedure pNFEProdutoCombustiveis;
    procedure pNFEProdutoICMSUFDestino;
    function fAtendeRegrasDifal(strOpcDoc: String): Boolean;
    procedure pNFETranspVolume;
    procedure pNFEDadosAdicionais;
    procedure pNFETotal;
    procedure pNFEEmailCliente;
    procedure pNFETrailler;
    procedure pNFEAutorizacaoDownloadXml;
    procedure pNFEInformacoesDePagamento;
    procedure pNFEInformacoesDoIntermediadorDaTransacao;
    procedure pNFECompra;
    procedure pNFEGrupoExportacao;
    procedure pNFEMedicamentos;
    procedure pNFERastreabilidade;
    procedure pNFEDadosAdicLivre;
    procedure pDFeReformaTributaria;

    function fRetornaCSTSimples(dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais; dadosItem: TDadosItem;
      blnIteSer: Boolean): String;

    function fItemServico(item: TDadosItem): Boolean;
    function fDeterminaCSTIpi(item: TDadosItem; blnIteSer: Boolean): String;

    function fTotalImpostoImportacao: Double;

    function fRetornaListaDuplicataQuitadaCredito(tLisDup: TListaDuplicata): String;
    
    function fFinalidadeEmissao: String;
    procedure pGerarConteudoNFe;
    function fCriaObjetoLogPerformance(intCodigo: Integer;
      strMensagem: String): TLogPerformance;
    procedure pImprimirDanfeInterna(strChaveAcesso, strImpressora: String;
      intViasServidor: Integer; strIdNota: String; blnContingencia: Boolean;
      intTipoEmissao: Integer = 0; strImprimirTelaPDF: String = '');
    function fRetornaPontoImpressao(dadosGeraisArg: TDadosGerais): String;
    function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;

    procedure pInserirDadosNFComplemento;
    procedure pReformaTributariaFinalidadeCreditoDebito;
    procedure pPrepararEmails;
    function fCfopDevolucao: Boolean;
    function fIndicadorConsumidorFinal: String;
    function fIndicadorPresenca: String;
    function fIndicadorIntermediador: String;
    function fUsarEnderecoDeEntregaComoEnderecoPrincipal: Boolean;
    function fIndicadorIEDestinatario: String;
    function fLocalDestinoOperacao: String;
    function fNotaDeComplemento: Boolean;
    function fNotaDeComplementoDebitoCredito: Boolean;
    function fValorCampo(strNomeTabela, strNomeCampo: String;
      arrParametros: Array Of String; arrValores: Array Of Variant): Variant;
    function fEnviaDadosTransportadora(const strModFrete: String): Boolean;
    function fEhNotaDeComplementoDeIcmsDeCapa: Boolean;
    function fEhNotaDeAjusteDeIcmsMaior: Boolean;
    function fEhNotaDeComplementoDeFrete: Boolean;
    function fEhSefazVirtualContingencia(const intTipoEmissao: Integer): Boolean;
    function fUsaTag_NFE_RETIRA: Boolean;
    function fRetTag_NFE_RETIRA_NFE_ENTREGA: String;
    function fEhDevolucaoParaFornecedorComIcmsDesoneradoX40(item: TDadosItem): Boolean;
    procedure pIntegracaoPainelCitelNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
    procedure pIntegracaoPainelCitelNFeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
    procedure pIntegracaoPainelCitelNFeCartaCorrecao(AChaveAcesso, AProtocolo: String);
    procedure pEnviaCartaCorrecaoInterna(strChaveAcesso: String; stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);

    function fExibeTagsObscontXCampoVendedor(const item: TDadosItem): Boolean;
    function fEhDevolucaoParaFornecedor(item: TDadosItem): Boolean;
    function fEhDevolucaoParaFornecedorSimplesNacionalComDiferimento(item: TDadosItem): Boolean;
    function fRetornaValorDoIcmsSimplesNacional(item: TDadosItem): Double;
    function fEhFornecedorTigreConfigurado(strCodFor: String): Boolean;
    function fDeveProcessarContingencia(const intTipoEmissao: Integer; const strContingenciaAutorizada: String): Boolean;

    procedure pAdicionarChaveReferenciadaNFE(const stlChavesInformadas: TStrings;
      const strChave: String);
    function fRetEndToEndIdPixDocumento(const ADadosGerais: TDadosGerais) : TStringList;
    function fDocumentoSeraEmitidoComTagEntrega(const strTag : String) : Boolean;
    function fRetEndToEndIdPixSemModalidade(const ADadosGerais: TDadosGerais) : TStringList;
    function fTransferenciaDeveUsarCSOSN400 : Boolean;
    function fRetornoEvento(const ARetornoFit: TWSNfeFitRetorno): TRetornoNFE;
    procedure pEnviarEventos;
    procedure pEnviarEventoInsucesso;
  public
    function fEnviarNota: Boolean;
    function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
    function fRetXmlNfe(strChaveAcesso: string): string;
    function fProcessarEnvio: TRetornoNFE;
    function fProcessarCancelamento: TRetornoNFE;

    function fMensagemErro: String;

    procedure pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
    procedure pSetaDadosGerais(dadosGerais: TDadosGerais);
    procedure pAdicionaItem(dadosItem: TDadosItem);

    function fVerificarStatusNota: Boolean;
    function fProcessarStatusNota: TRetornoNFE;

    function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String): TRetornoStatusNFE; overload;

    procedure pReimprimeDanfe(strChaveAcesso: String); overload;

    function fSuportaFuncoesAdministrativas: Boolean;
    procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer);
    procedure pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = ''); overload;
    procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
      strNumeroFinal, strDescricao: String);

    function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
      intTipo, intStatus: Integer): TStringList;

    function fNotaAindaAutorizadaNaFit(strNumDoc, strSerie, strCodEmp: String): Boolean;
    function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
    function fEnviaNFCeXmlOffLine: Boolean;
    function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

    function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
      AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;

    function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;

    function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

    procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

    function fConsultaStatusDFe(strChaveAcesso: string): String;
    function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
    function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;

    function fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

    function fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

    constructor Create(fonteDados: IFonteDados);
    destructor Destroy; override;
  End;

implementation

uses untFuncoesLibNfe, untLogDanfe, untDicSis;

Const
  FINALIDADE_DEVOLUCAO = '4';
  FINALIDADE_AJUSTE = '3';
  FINALIDADE_COMPLEMENTAR = '2';
  FINALIDADE_NORMAL = '1';
  OPERACAO_INTERNA : String = '1';

{ TNFEFit400 }

constructor TNFEFit400.Create(fonteDados: IFonteDados);
begin
  Self.fCriaObjetoLogPerformance(0, ''); //Manter apenas apenas para forçar a compilação da função em desuso;

  objLogDanfe.AddLog('TNFEFit400.Create');
  Self.fonteDados := fonteDados;
  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);
  ReformaTributaria := TReformaTributaria.Create(fonteDados);
  lstItens := TObjectList.Create(False);
  stlArquivo := TStringList.Create;
  stlEmails := TStringList.Create;
  stlEmailsTra := TStringList.Create;
  stlEmailsTraRed := TStringList.Create;
  blnIcmsDesonerado := False;
  blnIcmsDesoneradoX40 := False;
end;

destructor TNFEFit400.Destroy;
begin
  objLogDanfe.AddLog('TNFEFit400.Destroy');
  lstItens.Clear;
  FreeAndNil(lstItens);
  FreeAndNil(fitWrapper);
  FreeAndNil(ReformaTributaria);
  FreeAndNil(stlArquivo);
  FreeAndNil(stlEmails);
  FreeAndNil(stlEmailsTra);
  FreeAndNil(stlEmailsTraRed);

  {$IF Defined(UNIDAC)}
  If Assigned(dicForTag) Then
    FreeAndNil(dicForTag);
  {$IFEND}

  inherited;
end;

function TNFEFit400.fAtendeRegrasDifal(strOpcDoc: String): Boolean;
begin
  Result := (fIndicadorIEDestinatario = '9') And
            (fLocalDestinoOperacao = '2') And
            (fIndicadorConsumidorFinal = '1') And
            (Pos(strOpcDoc, 'CO_') <= 0) ;
end;

function TNFEFit400.fCancelarNota(strNumDoc, strSerie,
  strMotivo: String): Boolean;
begin
  pLogImp('TNFEFit400.fCancelarNota');
  Result := fEnviaCancelamentoFit(fNumDocEnvio(strNumDoc), strSerie, dadosGerais.strCodEmp,
    fonteDados.fChaveAcesso, strMotivo, Self, fitWrapper, 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', '');
end;

function TNFEFit400.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
  pLogImp('TNFEFit400.fCarregaNfePdf');
  Result := fitWrapper.fCarregaNfePdf(AChaveAcesso, ANomeArquivo, AExtensao, fonteDados, AIgnorarLayoutSimplificado);
end;

function TNFEFit400.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
Begin
  pLogImp('TNFEFit400.fConfirmacaoOperacaoEntradaMercadoria');
  result := fitWrapper.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
End;


function TNFEFit400.fRetXmlNfe(strChaveAcesso: string): string;
begin
  pLogImp('TNFEFit400.fRetXmlNfe');
  result := fitWrapper.fRetXMLNfe(strChaveAcesso);
end;

function TNFEFit400.fCfopDevolucao: Boolean;
begin
  Result := False;
  If lstItens.Count > 0 Then
  Begin
    Result := Pos(TDadosItem(lstItens[0]).strClaFis, CFOP_DEVOLUCAO) > 0;
  End;
end;

function TNFEFit400.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  pLogImp('TNFEFit400.fConsultaCadastro');
  Result := untUtilFIT.fConsultaCadastro(fitWrapper, strUf, strCnpj, strIe);
end;

function TNFEFit400.fEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  pLogImp('TNFEFit400.fEnviaCartaCorrecao');
  pEnviaCartaCorrecaoInterna(strChaveAcesso, stlCorrecoes, strImpressora, intSequencial);
  Result := TRetornoCartaCorrecao.Create;
  Result.strProtocolo := strProtocoloCartaCorrecao;
  Result.strMensagem  := strMensagemCartaCorrecao;
end;

function TNFEFit400.fEnviaDadosTransportadora(const strModFrete: String): Boolean;
begin
  {***********************************************************************************************************'}
  {* NT 2021.004: Regra de Validação para proibir o preenchimento do grupo de transporte (campo: transporta) *'}
  {* quando foi informado na Modalidade do Frete que não houve transporte (campo: modFrete = 9).              *}
  {*********************************************************************************************************BZ*}
  If (strModFrete = '9') Then //sem frete
  Begin
    Result := False;
    Exit;
  End;

  If dadosGerais.strEstado = 'EX' Then
  Begin
    Result := True;
    Exit;
  End;

  If fNumerosRepetidos(dadosGerais.strCgcTra) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not fValidaCnpjCpf(dadosGerais.strCgcTra, fonteDados) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;
end;

function TNFEFit400.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := False;
End;

function TNFEFit400.fData(const dta: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyy', dta);
end;

function TNFEFit400.fDataHora(const dta: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyyhhnnss', dta);
end;

procedure TNFEFit400.pEnviarEventos;
begin
  pEnviarEventoInsucesso;
end;

function TNFEFit400.fEnviarNota: Boolean;
  Var
    retornoFit: TWSNfeFitRetorno;
    strMsg: String;
    resultValidacao: TResultadoValidacao;
    STATUS_OK: TIntegerDynArray;
    stlRetWS: TStringList;
begin

  pEnviarEventos;

  pLogImp('TNFEFit400.fEnviarNota');

  SetLength(STATUS_OK, 6);
  STATUS_OK[0] := 1;
  STATUS_OK[1] := 2;
  STATUS_OK[2] := 3;
  STATUS_OK[3] := 5;
  STATUS_OK[4] := 6;
  STATUS_OK[5] := 4; // Denegada

  stlArquivo.Clear;

  fltTotalIcmsInterestadualDestino := 0;
  fltTotalIcmsInterestadualOrigem := 0;

  fltAliqFCP := 0;
  fltTotalFCP := 0;
  fltTotalBaseFCP := 0;

  fltAliqFCP_189 := 0;
  fltTotalFCP_189 := 0;
  fltTotalBaseFCP_189 := 0;

  fltAliqFCP_192 := 0;
  fltTotalFCP_192 := 0;
  fltTotalBaseFCP_192 := 0;

  fltTotalIPIDevolvido := 0;
  fltTotalIPI := 0;

  fltBaseRetido  := 0;
  fltValorRetido := 0;

  fltBaseEfetivo  := 0;
  fltValorEfetivo := 0;

  fltTotalQtdeMonofasicoRetidoAnteriormente := 0;
  fltTotalIcmsMonofasicoRetidoAnteriormente := 0;

  pInserirDadosNFComplemento;
  pReformaTributariaFinalidadeCreditoDebito;
  pGerarConteudoNFe;

  retornoFit := fitWrapper.fEnviaTextoIntegracao(stlArquivo.Text, '', 'FIT_NFE_ENVIA_TEXTO_AUTORIZACAO_FIT_NFE', 8, STATUS_OK);

  Try
    stlArquivo.SaveToFile(fPnlDir('ULTIMA_NOTA.TXT'));

    Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                  dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ENVIO', stlArquivo.Text);
  Except

  End;

  Result := retornoFit.RetornoOk;

  stlRetWS := TStringList.Create;
  Try
    stlRetWS.Add(retornoFit.Texto);
    Try
      stlRetWS.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFE_WS.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlRetWS);
  End;

 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Transmitindo documento, aguarde ...');
 {$IFEND}

  If (Not Result) Or (fGetValorLinha(retornoFit.Texto, '|', 9)='999') Then
  Begin
    If (fCountChar(retornoFit.Texto, '|') >= 10) Then
    Begin
      If fEmptyStr(fGetValorLinha(retornoFit.Texto, '|', 11)) Then
        strMsg := 'Erro: ' + fGetValorLinha(retornoFit.Texto, '|', 10)
      Else
        strMsg := 'Erro: ' + fGetValorLinha(retornoFit.Texto, '|', 11);
    End
    Else
      strMsg := 'Erro: ' + retornoFit.Texto;

    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFEFit400.fExibeTagsObscontXCampoVendedor(
  const item: TDadosItem): Boolean;
begin
  Result := False;

  If (fCfgSisFonte(fonteDados, 'TAGOXV') = 'S') And
     (fEhFornecedorTigreConfigurado(Trim(item.strCodFor))) Then
    Result := True;
end;

procedure TNFEFit400.pGerarConteudoNFe;
  Var
    fltFatura : Double;
begin
  pPrepararEmails;
  blnInformarTagsObscontXCampoVendedor := False;

  pNFEHeader;
  PNFE;

  If fonteDados.fDadosGerais.strEstado <> 'EX' Then
  Begin
    pNFEEntrega;
  End;

  pNFETransporte;
  pNFEDuplicata(fltFatura);
  pNFEFatura(fltFatura);
  pNFEEletronicaReferenciada;
  pNFEModelo1AReferenciado;
  pNFEECFReferenciado;
  pNFEEDadosExportacao;
  pNFEInformacoesDeProcessoReferenciado;
  pNFEProdutosServicos;
  pNFEGrupoExportacao;
  pNFEProdutosIPI;
  pNFEProdutoPIS;
  pNFEProdutoCOFINS;
  pNFEProdutoISSQN;
  pNFEProdutoII;
  pNFEProdutoDeclaracaoImportacao;
  pNFEProdutoAdicoes;
  pNFEProdutoCombustiveis;
  pNFEMedicamentos;
  pNFERastreabilidade;
  pNFEProdutoICMSUFDestino;
  pNFETranspVolume;
  pNFEDadosAdicionais;
  pNFECompra;
  pNFETotal;
  pNFEEmailCliente;
  pNFEAutorizacaoDownloadXml;
  pNFEInformacoesDePagamento;
  pNFEInformacoesDoIntermediadorDaTransacao;
  pNFEDadosAdicLivre;
  pDFeReformaTributaria;
  pNFETrailler;

  stlArquivo.Text := fTiraCaracEspeciais(stlArquivo.Text, False, False, False);
end;

function TNFEFit400.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
  Var
    strTexto: String;
begin
  pLogImp('TNFEFit400.fListagemNotas');
  Result := TStringList.Create;
  strTexto := strCodEmp + '|' + FormatDateTime('ddmmyyyyhhnnss', dtaDtaIni) + '|' +
    FormatDateTime('ddmmyyyyhhnnss', dtaDtaFin+StrToTime('23:59:59')) + '|' +
    IntToStr(intTipo) + '|' + IntToStr(intStatus);

  fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_LISTA_NFE_PROPRIA_TIPO_EMISSAO_PERIODO');
  Result.Text := fitWrapper.strUltimoRetorno;
end;

function TNFEFit400.fMensagemErro: String;
begin
  Result := '';
end;

function TNFEFit400.fNotaAindaAutorizadaNaFit(strNumDoc, strSerie,
  strCodEmp: String): Boolean;
  Var
    retornoFit: TWSNfeFitRetorno;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    intStatus: Integer;
    strMensagem: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    strCancelado: String;
    blnRejeitadaRecusada: Boolean;
    blnContingencia: Boolean;
    strContingenciaAutorizada: String;
begin
  pLogImp('TNFEFit400.fNotaAindaAutorizadaNaFit');
  retornoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(strNumDoc), strSerie, strCodEmp);

  pExtraiDadosRetornoId(retornoFit, intTipoEmissao, strChaveAcesso,
                        intStatus, strMensagem, strProtocolo, dtaDataAut,
                        blnRejeitadaRecusada, blnContingencia, strContingenciaAutorizada);

  strCancelado := fGetValorLinha(retornoFit.Texto, '|', 20);

  Result := (intStatus = RET_STATUS_AUTORIZADA);
  If Not Result Then
  Begin
    Result := strCancelado <> 'S';
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFEFit400.fProcessarCancelamento: TRetornoNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatus: Integer;
    strMensagem: String;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    strIdNota: String;
    blnRejeitadaRecusada : Boolean;
    blnContingencia: Boolean;
    strContingenciaAutorizada: String;
begin
  pLogImp('TNFEFit400.fProcessarCancelamento');

  Application.ProcessMessages;

  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  retornoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strCodEmp);

  pExtraiDadosRetornoId(retornoFit, intTipoEmissao, strChaveAcesso,
                        intStatus, strMensagem, strProtocolo, dtaDataAut,
                        blnRejeitadaRecusada, blnContingencia, strContingenciaAutorizada);

  Result := fGeraRetornoNFe(retornoFit,
    [RET_CANCELAMENTO_HOMOLOGADO,
     RET_EVENTO_REGISTRADO,
     RET_STATUS_AUTORIZADA_FORA_PRAZO,
     RET_STATUS_AUTORIZADA_FORA_PRAZO_2,
     RET_STATUS_DUPLICIDADE_EVENTO], 1,
    strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, True, False, blnRejeitadaRecusada, True, blnContingencia, strContingenciaAutorizada);

  If Result.Sucesso Then
  Begin
    If Not Result.Contingencia Then
    Begin
      fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc), 'XMLNFE_CANCEL', fonteDados);

      pIntegracaoPainelCitelNFeCancelamento(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                            dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, strProtocolo);
    End;
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFEFit400.fProcessarEnvio: TRetornoNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatus: Integer;

    strMensagem: String;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    intTipoEmissao: Integer;
    stlRet: TStringList;

    strIdNota: String;
    blnRejeitadaRecusada : Boolean;
    blnContingencia: Boolean;
    strContingenciaAutorizada: String;
    blnDocumentoImpresso: Boolean;
    blnIgnoraContingencia : Boolean;

    function fContingencia_SVCAN_Autorizada(AResultado: TRetornoNFE): Boolean;
    Begin
      Result := AResultado.Sucesso And (intTipoEmissao = 6) And (strContingenciaAutorizada = 'S');
    End;

begin
  blnIgnoraContingencia := True;

 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Processando retorno, aguarde ...');
 {$IFEND}

  pLogImp('TNFEFit400.fProcessarEnvio');

  Application.ProcessMessages;
  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  retornoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strCodEmp);

  stlRet := TStringList.Create;
  Try
    stlRet.Add(retornoFit.Texto);
    Try
      stlRet.SaveToFile(fPnlDir('ULTIMO_RETORNO.TXT'));

      Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                    dadosGerais.strCodCli, dadosGerais.strTip_FC, 'RETORNO', stlRet.Text);
    Except

    End;
  Finally
    FreeAndNil(stlRet);
  End;

  Application.ProcessMessages;

  pExtraiDadosRetornoId(retornoFit, intTipoEmissao, strChaveAcesso,
                        intStatus, strMensagem, strProtocolo, dtaDataAut,
                        blnRejeitadaRecusada, blnContingencia, strContingenciaAutorizada);

  if (fDeveProcessarContingencia(intTipoEmissao, strContingenciaAutorizada)) then
    blnIgnoraContingencia := False;

  objLogDanfe.AddLog('documento................: ' + dadosGerais.strNumDoc + '-' + dadosGerais.strEspDoc + '-' + dadosGerais.strCodEmp);
  objLogDanfe.AddLog('intTipoEmissao...........: ' + IntToStr(intTipoEmissao));
  objLogDanfe.AddLog('blnContingencia..........: ' + fBooleanToString(blnContingencia));
  objLogDanfe.AddLog('strContingenciaAutorizada: ' + strContingenciaAutorizada);
  objLogDanfe.AddLog('blnIgnoraContingencia....: ' + fBooleanToString(blnIgnoraContingencia));
  objLogDanfe.AddLog('resultadoFit.Texto.......: ' + retornoFit.Texto);

  Result := fGeraRetornoNFe(retornoFit,
    [RET_STATUS_AUTORIZADA, RET_STATUS_AUTORIZADA_FORA_PRAZO, RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, blnIgnoraContingencia, True, blnRejeitadaRecusada, False, blnContingencia, strContingenciaAutorizada);

  If Result.Sucesso Then
  Begin
   {$IF Defined(VER180)}
   {$ELSE}
    if Assigned(untUtil.OnNotificarProgresso) then
      untUtil.OnNotificarProgresso('Autorizado com sucesso ...');
   {$IFEND}

    Self.fonteDados.pGravarLogNfe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie, dadosGerais.strCodCli,
                                  dadosGerais.strTip_FC, 'AF', strMensagem, Result.ChaveAcesso, nOw(), fDefineImpressora(dadosGerais));

    pIntegracaoPainelCitelNFe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                              dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, strProtocolo);

    objLogDanfe.AddLog('fContingencia_SVCAN_Autorizada=' + fBooleanToString(fContingencia_SVCAN_Autorizada(Result)));

    If (Not Result.Contingencia) Or fContingencia_SVCAN_Autorizada(Result) Then
    Begin
     {$IF Defined(VER180)}
     {$ELSE}
      if Assigned(untUtil.OnNotificarProgresso) then
        untUtil.OnNotificarProgresso('Download do XML, aguarde ...');
     {$IFEND}

      fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc), EmptyStr, fonteDados);
    End;

    Application.ProcessMessages;

    fonteDados.pAtualizaDadosAutorizacaoNFe(Result.ChaveAcesso,
                                            Result.NumeroProtocolo,
                                            dadosGerais.strNumDoc,
                                            dadosGerais.strEspDoc,
                                            dadosGerais.strCodEmp,
                                            dadosGerais.strSerie,
                                            dadosGerais.strCodCli,
                                            dadosGerais.strTip_FC);

    blnDocumentoImpresso := Self.fonteDados.fRetornaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                                                      dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);

    If (not blnDocumentoImpresso) And ((strContingenciaAutorizada <> 'S') Or fContingencia_SVCAN_Autorizada(Result)) Then
    Begin
     {$IF Defined(VER180)}
     {$ELSE}
      if Assigned(untUtil.OnNotificarProgresso) then
        untUtil.OnNotificarProgresso('Enviando para impressão, aguarde ...');
     {$IFEND}

      pImprimirDanfeInterna(Result.ChaveAcesso, fDefineImpressora(dadosGerais), 0, strIdNota, Result.Contingencia, intTipoEmissao);
      Self.fonteDados.pGravaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                              dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);
    End;

  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);

  Application.ProcessMessages;
end;

function TNFEFit400.fProcessarStatusNota: TRetornoNFE;
  Var
    strIdNota: String;
    retornoFit: TWSNfeFitRetorno;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    intStatus: Integer;
    strMensagem: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    blnRejeitadaRecusada : Boolean;
    blnContingencia: Boolean;
    strContingenciaAutorizada: String;
    blnIgnoraContingencia : Boolean;
begin
  pLogImp('TNFEFit400.fProcessarStatusNota');
  blnIgnoraContingencia := True;

  Application.ProcessMessages;
  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  retornoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strCodEmp);

  Application.ProcessMessages;

  pExtraiDadosRetornoId(retornoFit, intTipoEmissao, strChaveAcesso,
                        intStatus, strMensagem, strProtocolo, dtaDataAut,
                        blnRejeitadaRecusada, blnContingencia, strContingenciaAutorizada);

  if (fDeveProcessarContingencia(intTipoEmissao, strContingenciaAutorizada)) then
    blnIgnoraContingencia := False;

  objLogDanfe.AddLog('documento................: ' + dadosGerais.strNumDoc + '-' + dadosGerais.strEspDoc + '-' + dadosGerais.strCodEmp);
  objLogDanfe.AddLog('intTipoEmissao...........: ' + IntToStr(intTipoEmissao));
  objLogDanfe.AddLog('blnContingencia..........: ' + fBooleanToString(blnContingencia));
  objLogDanfe.AddLog('strContingenciaAutorizada: ' + strContingenciaAutorizada);
  objLogDanfe.AddLog('blnIgnoraContingencia....: ' + fBooleanToString(blnIgnoraContingencia));
  objLogDanfe.AddLog('resultadoFit.Texto.......: ' + retornoFit.Texto);

  Result := fGeraRetornoNFe(retornoFit,
    [RET_STATUS_AUTORIZADA, RET_STATUS_AUTORIZADA_FORA_PRAZO, RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, blnIgnoraContingencia, True, blnRejeitadaRecusada, False, blnContingencia, strContingenciaAutorizada);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFEFit400.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;
end;

function TNFEFit400.fTotalImpostoImportacao: Double;
  Var
    intContador: Integer;
    docImportacao: TDocumentoImportacao;
begin
  Result := 0;
  If Assigned(lstItens) Then
    For intContador := 0 To lstItens.Count-1 Do
    Begin
      docImportacao := TDadosItem(lstItens[intContador]).documentoImportacao;

      If Assigned(docImportacao) Then
        Result := Result + docImportacao.fltValorImpostoImportacao;
    End;
end;

function TNFEFit400.fFinalidadeEmissao: String;
begin
  If (dadosGerais.strDevSim = 'S') Then
    Result := FINALIDADE_NORMAL // 1-Normal
  Else If (dadosGerais.blnCreditoIcms) Or (dadosGerais.blnTransfIcms) Or
     ( (Not fCfopDevolucao) And (dadosGerais.blnEst_DV) And (Not dadosGerais.blnComplementoIcms) ) Or
     (dadosGerais.blnRestituicaoIcms) Or (dadosGerais.blnEstornoDeCredito) Or (dadosGerais.blnNFAjusteICMSaMaior) Then
    Result := FINALIDADE_AJUSTE // 3-Ajuste
  Else If (dadosGerais.blnNfComp Or dadosGerais.blnComVal) And
          (dadosGerais.blnComplementoIcms Or dadosGerais.blnComplementoValor Or
           dadosGerais.blnComplementoDifal Or dadosGerais.blnComplementoStPerfilCnc Or
           dadosGerais.blnComplementoStPerfilTrs Or dadosGerais.blnComplementoFrete)Then
    Result := FINALIDADE_COMPLEMENTAR // 2-Complementar
  Else If (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
    Result := FINALIDADE_DEVOLUCAO // 4-Devolução
  Else If (dadosGerais.blnInconsistenciaEFD_Gravar) Then
    Result := FINALIDADE_AJUSTE // 3-Ajuste
  Else If (dadosGerais.strOpcDoc = 'CA') Then
  Begin
    If fCfgSisFonte(fonteDados, 'FINNFA') = '3' Then
      Result := FINALIDADE_AJUSTE // // 3-Ajuste
    Else
      Result := FINALIDADE_NORMAL; // 1-Normal
  End
  Else
    Result := FINALIDADE_NORMAL; // 1-Normal

  If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
    Result := dadosGerais.strFinalidade ;

end;

function TNFEFit400.fValor(const fltValor: Double; intPrecisao,
  intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TNFEFit400.fValorCond(blnCondicao: Boolean; fltValor: Double;
  intPrecisao, intDecimais: Integer; strElse: String=''): String;
begin
  If blnCondicao Then
  Begin
    Result := fValor(fltValor, intPrecisao, intDecimais);
  End
  Else
  Begin
    Result := strElse;
  End;
end;

function TNFEFit400.fVerificarStatusNota: Boolean;
begin
  Result := True;
end;

function TNFEFit400.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
var
  strRetornoConsulta: string;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

function TNFEFit400.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

procedure TNFEFit400.pAdicionaItem(dadosItem: TDadosItem);
begin
  lstItens.Add(dadosItem);
end;

procedure TNFEFit400.pAdicionarChaveReferenciadaNFE(
  const stlChavesInformadas: TStrings; const strChave: String);
var
  strLinha : String;
begin
  If (stlChavesInformadas.IndexOf(strChave) >= 0) Then
    Exit;

  stlChavesInformadas.Add(strChave);

  strLinha := '';
  strLinha := strLinha + 'NFE-REF-NFE|';                                         // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp,
                                          fNumDocEnvio(dadosGerais.strNumDoc),
                                          dadosGerais.strSerie,
                                          dadosGerais.strEspDoc) + '|';          // 02 - ID Referência
  strLinha := strLinha + strChave + '|';                                         // 03 - Número da Chave Acesso Referenciada
  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  pLogImp('TNFEFit400.pEnviaCartaCorrecao');
  pEnviaCartaCorrecaoInterna(strChaveAcesso, stlCorrecoes, strImpressora, intSequencial);
end;

procedure TNFEFit400.pEnviaCartaCorrecaoInterna(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
  Var
    strTexto: String;
    intContador: Integer;
    retornoFit: TWSNfeFitRetorno;
    strNumDoc: String;
    intStatusOk: TIntegerDynArray;
    blnDuplicidadeDeEvento: Boolean;
begin
  blnDuplicidadeDeEvento    := False;
  strProtocoloCartaCorrecao := '';
  strMensagemCartaCorrecao  := '';

  SetLength(intStatusOk, 1);
  intStatusOk[0] := RET_EVENTO_REGISTRADO;

  strTexto := '';
  For intContador := 0 To stlCorrecoes.Count-1 Do
  Begin
    strTexto := strTexto + stlCorrecoes[intContador] + '#';
  End;

  strTexto := fTiraCaracEspeciais(strTexto, False, False, False);

  strTexto := 'NFE-ENVIO-CCE|' +
              '|' +
              strChaveAcesso + '|' +
              strTexto + '|' +
              FormatDateTime('ddmmyyyyhhnnss', IncMinute(nOw(), -5)) + '|' +
              IntToStr(intSequencial);

  pSalvarTXTSemErro(strTexto, 'ULTIMO_ENVIO_CARTA_CORRECAO.TXT');

  retornoFit := fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', 4, intStatusOk);

  pSalvarTXTSemErro(retornoFit.Texto, 'ULTIMO_RETORNO_CARTA_CORRECAO.TXT');

  pExtraiDadosRetornoCartaCorrecao(retornoFit, strProtocoloCartaCorrecao, strMensagemCartaCorrecao);

  If (Pos('DUPLICIDADE DE EVENTO', UpperCase(strMensagemCartaCorrecao)) > 0) Then
  Begin
    strProtocoloCartaCorrecao := 'ND';
    strMensagemCartaCorrecao  := '';
    blnDuplicidadeDeEvento    := True;
  End;

  If (retornoFit.RetornoOk) Or (blnDuplicidadeDeEvento) Then
  Begin
    fitWrapper.pDownloadXmlCCe(fonteDados, fNumDocEnvio(strNumDoc), strChaveAcesso, strProtocoloCartaCorrecao);

    pIntegracaoPainelCitelNFeCartaCorrecao(strChaveAcesso, strProtocoloCartaCorrecao);

    strNumDoc := Copy(strChaveAcesso, 26, 9);

    fitWrapper.fDownloadDanfe(strChaveAcesso, fNumDocEnvio(strNumDoc), strImpressora,
                              TMetodoImpressaoFactory.fCriarCartaCorrecao('CCe_'), 0, '', nil, fonteDados);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFEFit400.fNotaDeComplementoDebitoCredito: Boolean;
begin
  Result := False;

  If not dadosGerais.blnNfComp Then
    Exit;

  If not (pos(dadosGerais.strFinalidade, '5_6_') > 0) Then
    Exit;

  Result := True;
end;

procedure TNFEFit400.pInserirDadosNFComplemento;

  procedure pSetPisCofDefault(dadosItem: TDadosItem);
  begin
    dadosItem.strCstPis := '07';
    dadosItem.strCstCof := '07';

    dadosItem.fltBasPis := 0.0;
    dadosItem.fltBasCof := 0.0;

    dadosItem.fltAlqPis := 0.0;
    dadosItem.fltAlqCof := 0.0;

    dadosItem.fltValPis := 0.0;
    dadosItem.fltValCof := 0.0;
  end;

  procedure pSetPisCofItem(dadosItem: TDadosItem; itemNfComp: TItemNfComp);
  begin
    If (Not fEmptyStr(itemNfComp.strCstPis)) Then
    Begin
      dadosItem.strCstPis := itemNfComp.strCstPis;
      dadosItem.fltBasPis := itemNfComp.fltBasPis;
      dadosItem.fltAlqPis := itemNfComp.fltAlqPis;
      dadosItem.fltValPis := itemNfComp.fltValPis;
      dadosItem.strCstCof := itemNfComp.strCstCof;
      dadosItem.fltBasCof := itemNfComp.fltBasCof;
      dadosItem.fltAlqCof := itemNfComp.fltAlqCof;
      dadosItem.fltValCof := itemNfComp.fltValCof;

      dadosGerais.fltValPis := dadosGerais.fltValPis + dadosItem.fltValPis;
      dadosGerais.fltValCof := dadosGerais.fltValCof + dadosItem.fltValCof;
    End
    Else
      pSetPisCofDefault(dadosItem);
  end;

  Var
    dadosItem: TDadosItem;
    fltBasIcmDiv: Double;
    fltBasRetDiv: Double;
    fltAlqIpi: Double;
    intItem: Integer;
    itemNfComp: TItemNfComp;
    blnGeraSchemaReformaTributaria: Boolean;

  function fImprimeIPIDadosProprios: Boolean;
  begin
    Result := untFuncoesLibNfe.fImprimeIPIDadosProprios(dadosGerais.strClaFis,
      objConfig.strClaVen, objConfig.strOpcImpValIpi, objConfig.blnConIpi);
  end;

  function fImprimeSubTributariaDadosProprios: Boolean;
    Var
      strForcaSubTributariaEmDadosPropriosLocal: String;
      strCfgRegSt : String;
      strClaSub : String;
  begin
    strCfgRegSt := fCfgRegimeSubstituicaoTributaria(fonteDados, fonteDados.fDadosGerais.strOpcDoc);

    If (strCfgRegSt <> 'CLASUB') Then
      strClaSub := fRegimeSubstituicaoTributaria(fonteDados, fonteDados.fDadosGerais.strOpcDoc)
    Else
      strClaSub := objConfig.strClaSub;

    strForcaSubTributariaEmDadosPropriosLocal := '';
    If fForcaSubTributariaEmDadosProprios(dadosGerais.strOpcDoc, dadosItem.fltValRet, dadosItem.fltValorFCP, dadosItem.fltValorFCPST) Then
      strForcaSubTributariaEmDadosPropriosLocal := 'S';

    If (strForcaSubTributariaEmDadosPropriosLocal <> 'S') And
       fForcaSubTributariaEmDadosPropriosRegraEspecial(dadosGerais.strOpcDoc, dadosGerais.strTip_FC, dadosGerais.strClaFis, dadosItem.strCodSit,
                                                       objConfig.blnSimPau, dadosItem.fltValRet, dadosItem.fltValorFCP, dadosItem.fltValorFCPST) Then
      strForcaSubTributariaEmDadosPropriosLocal := 'S';

    If (strForcaSubTributariaEmDadosPropriosLocal <> 'S') And
       fForcaSubTributariaEmDadosPropriosRegraBrinde(dadosGerais.strClaFis, dadosItem.fltValRet, (fCfgSisFonte(fonteDados, 'BRI_ST') = 'S')) Then
      strForcaSubTributariaEmDadosPropriosLocal := 'S';

    Result := untFuncoesLibNfe.fImprimeSubTributariaDadosProprios(dadosGerais.strClaFis,
      objConfig.strClaVen, strClaSub, objConfig.blnSimPau, strForcaSubTributariaEmDadosPropriosLocal);
  end;

  procedure pAdicionaReformaTributariaItem;
  begin
    If not blnGeraSchemaReformaTributaria Then
      Exit;

    dadosItem.ReformaTributaria := TDadosReformaTributaria.Create;
    dadosItem.ReformaTributaria.IBS_CBS := TIBS_CBS.Create;
    dadosItem.ReformaTributaria.IBS_CBS.strCodigoCST := '410';
    dadosItem.ReformaTributaria.IBS_CBS.strClassTrib := '410029';
    dadosItem.ReformaTributaria.IBS_CBS.fltValor     := 0;
    dadosItem.ReformaTributaria.IBS_CBS.fltBase      := 0;
    dadosItem.ReformaTributaria.IBS_CBS.fltTotal     := 0;
  end;

  procedure pAdicionaReformaTributariaTotal;
  begin
    If Not blnGeraSchemaReformaTributaria Then
      Exit;

    If Not Assigned(dadosGerais.ReformaTributariaTotal) Then
      dadosGerais.ReformaTributariaTotal := TIBS_CBS_SEL_TOTAL.Create;

    dadosGerais.ReformaTributariaTotal.fltValorTotalBase     := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalIS       := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalCBS      := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_UF   := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_MUN  := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalGrupoIBS := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalNFe      := 0;
  end;

begin

  blnGeraSchemaReformaTributaria := fGeraSchemaReformaTributaria(fonteDados, dadosGerais.strCodEmp);

  If fNotaDeComplementoDebitoCredito Then
    Exit;

  If fNotaDeComplemento Then
  Begin
    If Length(dadosGerais.arrItensNfComp) = 0 Then
    Begin
      dadosItem := TDadosItem.Create;

      fltBasIcmDiv := dadosGerais.fltBasIcm;
      If RoundTo(fltBasIcmDiv, -2) = 0 Then
        fltBasIcmDiv := 1;

      fltBasRetDiv := dadosGerais.fltBasRet;
      If RoundTo(fltBasRetDiv, -2) = 0 Then
        fltBasRetDiv := 1;

      fltAlqIpi := 0.00;
      If dadosGerais.fltBasIpi <> 0 Then
        fltAlqIpi := fFormataFloat(dadosGerais.fltTotIpi / dadosGerais.fltBasIpi * 100, 2);

      {**********************************************************************************}
      {* USADO PELA GOTAD. SE CASO FOR NOTA DE COMPLEMENTO E TIVER CODSIT PREENCHIDO    *}
      {* NÃO ALTERA O MESMO, POIS O MESMO FOI PREENCHIDO NO ATO DA NOTA. PARA OS DEMAIS *}
      {* CLIENTE IRÁ SEGUIR A MESMA REGRA. 21-10-2014                                   *}
      {*******************************************************************************FC*}
      If (dadosGerais.blnNfComp And
          {(Not dadosGerais.blnCreditoIcms) And
          (Not dadosGerais.blnTransfIcms) And}
          (Not fEmptyStr(dadosGerais.strCodSit))) Then
        dadosItem.strCodSit := dadosGerais.strCodSit
      Else
      Begin
        If dadosGerais.blnCreditoIcms Or
           dadosGerais.blnTransfIcms Or
           dadosGerais.blnRestituicaoIcms Or
           dadosGerais.blnEstornoDeCredito Then
          dadosItem.strCodSit := '090'

        Else If dadosGerais.fltTotRet > 0 Then
          dadosItem.strCodSit := '010'

        Else
          dadosItem.strCodSit := '000';
      End;

      If dadosGerais.blnNfComp And
         dadosGerais.blnTransfIcms Then
      Begin
        pSetPisCofDefault(dadosItem);
      End;

      If (dadosGerais.blnNfComp) And
         (dadosGerais.blnComplementoIcms) And
         (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
      Begin
        dadosItem.strCstPis := '49';
        dadosItem.strCstCof := '49';

        dadosItem.fltBasPis := 0.0;
        dadosItem.fltBasCof := 0.0;

        dadosItem.fltAlqPis := 0.0;
        dadosItem.fltAlqCof := 0.0;

        dadosItem.fltValPis := 0.0;
        dadosItem.fltValCof := 0.0;
      End;

      dadosItem.fltBasIcm := dadosGerais.fltBasIcm;

      If (dadosGerais.blnNfComp) And (dadosGerais.fltAlqIcm <> 0) Then
        dadosItem.fltAlqIcm := dadosGerais.fltAlqIcm
      Else
        dadosItem.fltAlqIcm := IfThen(dadosGerais.fltBasIcm <> 0, fFormataFloat((dadosGerais.fltTotIcm / (fltBasIcmDiv)*100), 1), 0);

      dadosItem.fltValIcm := dadosGerais.fltTotIcm;

      dadosItem.fltBasRet := dadosGerais.fltBasRet;

      If (dadosGerais.blnNfComp or dadosGerais.blnCreditoIcms) And (fFormataFloat(dadosGerais.fltBasRet,2) = 0) Then
        dadosItem.fltAlqRet := 0
      Else
        dadosItem.fltAlqRet := dadosGerais.fltTotRet/(fltBasRetDiv*100);

      dadosItem.fltValRet := dadosGerais.fltTotRet;

      dadosItem.strCodIte := 'CFOP' + dadosGerais.strClaFis;
      dadosItem.strDesIte := dadosGerais.strDesIteNC;
      dadosItem.strClaIpi := '00000000';
      dadosItem.strExcIpi := '';
      dadosItem.strCodigoCEST := '0000000';

      dadosItem.strClaFis := dadosGerais.strClaFis;
      dadosItem.strUnidad := 'UN';
      dadosItem.strUnTrib := 'UN';
      dadosItem.fltQtdIte := 0;
      dadosItem.fltUnitar := dadosGerais.fltTotPro;
      dadosItem.fltTotIte := dadosGerais.fltTotPro;
      dadosItem.fltQtdTri := 0;
      dadosItem.fltUniTri := dadosGerais.fltTotPro;
      dadosItem.fltDesAce := dadosGerais.fltDesAce;

      dadosItem.fltPercentualFCP := dadosGerais.fltPerFcpComplementoIcmsCapa;
      dadosItem.fltValorFCP      := dadosGerais.fltValFcpComplementoIcmsCapa;
      dadosItem.fltBaseFCP       := dadosGerais.fltBasFcpComplementoIcmsCapa;


      dadosItem.fltBaseFCPST       := dadosGerais.fltBasFcpST;
      dadosItem.fltPercentualFCPST := dadosGerais.fltAlqFcpST;
      dadosItem.fltValorFCPST      := dadosGerais.fltTotFcpST;

      If dadosGerais.fltTotIpi <> 0 Then
        dadosItem.strCSTIpi := '50'
      Else
        dadosItem.strCSTIpi := '53';

      dadosItem.fltBasIpi := dadosGerais.fltBasIpi;
      dadosItem.fltAlqIpi := fltAlqIpi;
      dadosItem.fltValIpi := dadosGerais.fltTotIpi;

      If (dadosGerais.strNfCIAP = 'S') Then
      Begin
        dadosItem.fltBasPis := 0.0;
        dadosItem.fltBasCof := 0.0;

        dadosItem.fltAlqPis := 0.0;
        dadosItem.fltAlqCof := 0.0;

        dadosItem.fltValPis := 0.0;
        dadosItem.fltValCof := 0.0;

        dadosItem.strCstPis := dadosGerais.strCstPIS;
        dadosItem.strCstCof := dadosGerais.strCstCOF;
        dadosItem.strCstIpi := dadosGerais.strCstIPI;
      End;

      If dadosGerais.blnComplementoFrete Then
      Begin
        dadosItem.fltQtdIte := 0;
        dadosItem.fltUnitar := 0;
        dadosItem.fltTotIte := 0;
        dadosItem.fltQtdTri := 0;
        dadosItem.fltUniTri := 0;
        dadosItem.fltTotFre := dadosGerais.fltTotFre;
      End;

      If dadosGerais.blnComplementoIcms And (dadosGerais.fltIcmDif > 0) Then
      Begin
        dadosItem.strCodSit := IIF(RightStr(dadosGerais.strCodSit, 2) = '51', dadosGerais.strCodSit, '051');
        dadosItem.fltAlqIcm := dadosGerais.fltPerIcm;
        dadosItem.fltIcmsOP := dadosGerais.fltIcmsOP;
        dadosItem.fltPerDif := dadosGerais.fltPerDif;
        dadosItem.fltIcmDif := dadosGerais.fltIcmDif;
        dadosItem.fltValIcm := dadosGerais.fltVlrIcm;
      End;

      pAdicionaReformaTributariaItem;

      pAdicionaItem(dadosItem);
    End
    Else
    Begin
      dadosGerais.fltValPis := 0;
      dadosGerais.fltValCof := 0;

      For intItem := Low(dadosGerais.arrItensNfComp) To High(dadosGerais.arrItensNfComp) Do
      Begin
        itemNfComp := dadosGerais.arrItensNfComp[intItem];
        dadosItem  := TDadosItem.Create;

        dadosItem.strAutInc := itemNfComp.strAutInc;
        dadosItem.strCodSit := itemNfComp.strCodFis;

        If (dadosGerais.blnComplementoValor) Then
          pSetPisCofItem(dadosItem, itemNfComp)
        Else If dadosGerais.blnNfComp And
           dadosGerais.blnTransfIcms Then
        Begin
          pSetPisCofDefault(dadosItem);
        End;

        dadosItem.fltBasIcm := itemNfComp.fltBasIcm;
        dadosItem.fltAlqIcm := itemNfComp.fltAlqIcm;
        dadosItem.fltValIcm := itemNfComp.fltValIcm;

        dadosItem.fltBasRet := itemNfComp.fltBasRet;
        dadosItem.fltAlqRet := itemNfComp.fltAlqRet;
        dadosItem.fltValRet := itemNfComp.fltValRet;

        dadosItem.fltBaseFCPST       := itemNfComp.fltBasFcpST;
        dadosItem.fltPercentualFCPST := itemNfComp.fltAlqFcpST;
        dadosItem.fltValorFCPST      := itemNfComp.fltValFcpST;

        dadosItem.strCodIte := itemNfComp.strCodIte;
        dadosItem.strRefere := itemNfComp.strCodIte;
        dadosItem.strCodFab := itemNfComp.strCodFab;
        dadosItem.strDesIte := itemNfComp.strDesIte;
        dadosItem.strClaIpi := itemNfComp.strClaIpi;
        dadosItem.strExcIpi := itemNfComp.strExcIpi;
        dadosItem.strCodigoCEST := itemNfComp.strCdCEST;

        dadosItem.strClaFis := itemNfComp.strClaFis;
        dadosItem.strUnidad := itemNfComp.strUnidad;
        dadosItem.strUnTrib := itemNfComp.strUnidad;

        dadosItem.fltQtdIte := itemNfComp.fltQtdIte;
        dadosItem.fltUnitar := itemNfComp.fltUnitar;

        If dadosGerais.blnComplementoIcms And (itemNfComp.fltIcmDif > 0) Then
        Begin
          dadosItem.strCodSit := IIF(RightStr(dadosItem.strCodSit, 2) = '51', dadosItem.strCodSit, '051');
          dadosItem.fltIcmsOP := itemNfComp.fltIcmsOP;
          dadosItem.fltPerDif := itemNfComp.fltPerDif;
          dadosItem.fltIcmDif := itemNfComp.fltIcmDif;
        End;

        dadosItem.fltTotIte := 0;
        dadosItem.fltQtdTri := 0;
        dadosItem.fltUniTri := 0;
        dadosItem.fltDesAce := 0;

        If (dadosGerais.blnComplementoValor Or dadosGerais.blnComplementoDifal) And (itemNfComp.fltValCom > 0) Then
        Begin
          dadosItem.fltTotIte   := itemNfComp.fltValCom;
          dadosGerais.fltTotGer := dadosGerais.fltTotPro + dadosGerais.fltTotIpi + dadosGerais.fltTotRet + dadosGerais.fltTotFcpST + dadosGerais.fltDesAce;
        End;

        If dadosGerais.blnComplementoStPerfilCnc Or dadosGerais.blnComplementoStPerfilTrs Then
        Begin
          dadosItem.fltSICMEF := itemNfComp.fltSICMEF;
          dadosItem.fltBSTANT := itemNfComp.fltBSTANT;
          dadosItem.fltVSTANT := itemNfComp.fltVSTANT;
        End;

        If dadosGerais.fltTotIpi <> 0 Then
          dadosItem.strCSTIpi := '50'
        Else
          dadosItem.strCSTIpi := '53';

        dadosItem.fltBasIpi := itemNfComp.fltBasIpi;
        dadosItem.fltAlqIpi := itemNfComp.fltAlqIpi;
        dadosItem.fltValIpi := itemNfComp.fltValIpi;

        If Not fImprimeSubTributariaDadosProprios Then
        Begin
          If (dadosItem.fltValRet > 0) And (dadosItem.fltValorFCP > 0) Then
          Begin
            dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValorFCP;
            dadosItem.fltValorFCP := 0.0;
          End;

          dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValRet;
          dadosItem.fltBasRet := 0.0;
          dadosItem.fltValRet := 0.0;
        End;

        If Not fImprimeIPIDadosProprios Then
        Begin
          dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValIpi;
          dadosItem.fltBasIpi := 0.0;
          dadosItem.fltValIpi := 0.0;
        End;

        dadosItem.fltBaseUfDestino := itemNfComp.fltBasDes;
        dadosItem.fltPercentualFCP := itemNfComp.fltPerFCP;
        dadosItem.fltAliquotaDestino := itemNfComp.fltAlqUfd;
        dadosItem.fltAliquotaInterestadual := itemNfComp.fltAlqIne;
        dadosItem.fltPercentualPartilha := itemNfComp.fltPerPar;
        dadosItem.fltValorFCP := itemNfComp.fltValFCP;
        dadosItem.fltValorIcmsDestino := itemNfComp.fltValDes;
        dadosItem.fltValorIcmsOrigem := itemNfComp.fltValOri;
        dadosItem.fltBaseFCP := itemNfComp.fltBasFCP;

        dadosItem.strCodLub := itemNfComp.strCodLub;
        dadosItem.strDesANP := itemNfComp.strDesANP;

        If Assigned(itemNfComp.documentoImportacao) Then
        Begin
          dadosItem.documentoImportacao := TDocumentoImportacao.Create;
          dadosItem.documentoImportacao.strNumeroDi                := itemNfComp.documentoImportacao.strNumeroDi;
          dadosItem.documentoImportacao.dtaDataDi                  := itemNfComp.documentoImportacao.dtaDataDi;
          dadosItem.documentoImportacao.strLocalizacaoDesembaracao := itemNfComp.documentoImportacao.strLocalizacaoDesembaracao;
          dadosItem.documentoImportacao.strUFDesembaraco           := itemNfComp.documentoImportacao.strUFDesembaraco;
          dadosItem.documentoImportacao.dtaDataDesembaraco         := itemNfComp.documentoImportacao.dtaDataDesembaraco;

          dadosItem.documentoImportacao.intViaTransporte      := itemNfComp.documentoImportacao.intViaTransporte;
          dadosItem.documentoImportacao.fltValorAFRMM         := itemNfComp.documentoImportacao.fltValorAFRMM;
          dadosItem.documentoImportacao.intFormaIntermediacao := itemNfComp.documentoImportacao.intFormaIntermediacao;
          dadosItem.documentoImportacao.strCNPJAdquirente     := itemNfComp.documentoImportacao.strCNPJAdquirente;
          dadosItem.documentoImportacao.strUFAdquirente       := itemNfComp.documentoImportacao.strUFAdquirente;
        End;

        If (objConfig.strNfeIte <> '1') And (Not fEmptyStr(dadosItem.strCodFab)) Then
          dadosItem.strCodIte := dadosItem.strCodFab;

        If (fEmptyStr(dadosItem.strCdbFis)) Then
        Begin
          If (fCfgSisFonte(fonteDados, 'OBRBEN') = 'S') Then
          Begin
            If (fEmptyStr(dadosItem.strCodAbf)) Then
              dadosItem.strCodAbf := fCodigoAbreviacaoProduto(fonteDados, dadosItem.strCodIte);

            dadosItem.strCdbFis := fCodigoBeneficioFiscal(fonteDados, dadosItem.strCodSit, dadosItem.strCodAbf, fonteDados.fDadosGerais.strPerfil, dadosItem.strClaFis);
          End;
        End;

        pAdicionaReformaTributariaItem;

        pAdicionaItem(dadosItem);
      End;

    End;

    {**************************************************************************}
    {* CFG_TCRICM - "Quando da emissão de Nota Fiscal de Transferência de     *}
    {*               Saldo Credor/Devedor de ICMS, imprimir o valor do icms   *}
    {*               nos campos da nota fiscal:"                              *}
    {*                                                                        *}
    {*   1 - Campo de valor do icms.                                          *}
    {*   2 - Campo de valor dos produtos e campo de total da nota fiscal      *}
    {*                                                                        *}
    {*********************************************************************JC***}
    If dadosGerais.blnTransfIcms And (objConfigInterna.strTCrIcm = '2') Then
    Begin
      //Soma o valor do icms ao valor total dos produtos e total da nota
      dadosGerais.fltTotPro := dadosGerais.fltTotPro + dadosGerais.fltTotIcm;
      dadosGerais.fltTotGer := dadosGerais.fltTotGer + dadosGerais.fltTotIcm;

      //Zera o valor do icms geral
      dadosGerais.fltBasIcm := 0;
      dadosGerais.fltTotIcm := 0;
      dadosGerais.fltAlqIcm := 0;

      For intItem := 0 To lstItens.Count -1 Do
      Begin
        dadosItem := TDadosItem(lstItens[intItem]);

        //Soma o valor do icms ao valor total do produto
        dadosItem.fltUnitar := dadosItem.fltUnitar + dadosItem.fltValIcm;
        dadosItem.fltTotIte := dadosItem.fltTotIte + dadosItem.fltValIcm;

        //Zera o valor do icms no produto
        dadosItem.fltBasIcm := 0;
        dadosItem.fltValIcm := 0;
        dadosItem.fltAlqIcm := 0;
      End;

    End;

    If dadosGerais.blnComplementoFrete Then
    Begin
      dadosGerais.fltTotPro := 0;
    End;

    pAdicionaReformaTributariaTotal;

  End;
end;

procedure TNFEFit400.pReformaTributariaFinalidadeCreditoDebito;
Var
  dadosItem: TDadosItem;

  function fEhCstReformaTributariaSemAliquota: Boolean;
  begin
    Result := pos(dadosItem.ReformaTributaria.IBS_CBS.strCodigoCST, CST_REFORMA_TRIBUTARIA_SEM_ALIQUOTA) > 0 ;
  end;

begin
  If not fGeraSchemaReformaTributaria(fonteDados, dadosGerais.strCodEmp) Then
    Exit;

  If not fNotaDeComplementoDebitoCredito Then
    Exit;

  If Length(dadosGerais.arrItensNfComp) = 0 Then
  Begin
    dadosItem := TDadosItem.Create;

    dadosItem.strCodIte := 'CFOP' + dadosGerais.strClaFis;
    dadosItem.strDesIte := dadosGerais.strDesIteNC;
    dadosItem.strClaIpi := '00000000';
    dadosItem.strExcIpi := '';
    dadosItem.strCodigoCEST := '0000000';

    dadosItem.strClaFis := dadosGerais.strClaFis;
    dadosItem.strUnidad := 'UN';
    dadosItem.strUnTrib := 'UN';
    dadosItem.fltQtdIte := 1;
    dadosItem.fltUniOri := dadosGerais.fltTotPro;
    dadosItem.fltUnitar := dadosGerais.fltTotPro;
    dadosItem.fltTotIte := dadosGerais.fltTotPro;
    dadosItem.fltQtdTri := 1;
    dadosItem.fltUniTri := dadosGerais.fltTotPro;
    dadosItem.fltDesAce := dadosGerais.fltDesAce;
    dadosItem.fltDesEsp := 0;

    If Assigned(dadosGerais.arrChavesReferenciadas[0]) Then
    Begin
      dadosItem.strChvRef := dadosGerais.arrChavesReferenciadas[0].strChaveAcessoNfe;
      dadosItem.strIteRef := '1';
    End;

    dadosItem.ReformaTributaria := TDadosReformaTributaria.Create;
    dadosItem.ReformaTributaria.IBS_CBS := TIBS_CBS.Create;
    dadosItem.ReformaTributaria.IBS_CBS.strCodigoCST := dadosGerais.ReformaTributariaCreditoDebito.strCodigoCST;
    dadosItem.ReformaTributaria.IBS_CBS.strClassTrib := dadosGerais.ReformaTributariaCreditoDebito.strClassTrib;
    dadosItem.ReformaTributaria.IBS_CBS.fltValor     := dadosItem.fltTotIte;
    dadosItem.ReformaTributaria.IBS_CBS.fltBase      := IIF(fEhCstReformaTributariaSemAliquota, 0, dadosGerais.ReformaTributariaCreditoDebito.fltBasCal);
    dadosItem.ReformaTributaria.IBS_CBS.fltTotal     := dadosItem.fltTotIte;
    dadosItem.ReformaTributaria.IBS_CBS.fltValIBS    := dadosGerais.ReformaTributariaCreditoDebito.fltValIBS ;

    dadosItem.ReformaTributaria.CBS := TCBS.Create;
    dadosItem.ReformaTributaria.CBS.fltAliquota := dadosGerais.ReformaTributariaCreditoDebito.fltAlqCBS ;
    dadosItem.ReformaTributaria.CBS.fltValor    := dadosGerais.ReformaTributariaCreditoDebito.fltValCBS ;
    dadosItem.ReformaTributaria.CBS.fltPerDif   := 0;
    dadosItem.ReformaTributaria.CBS.fltValDif   := 0;
    dadosItem.ReformaTributaria.CBS.fltTriDev   := 0;
    dadosItem.ReformaTributaria.CBS.fltPerRed   := 0;
    dadosItem.ReformaTributaria.CBS.fltAlqEfe   := 0;

    dadosItem.ReformaTributaria.IBS_UF := TIBS_UF.Create;
    dadosItem.ReformaTributaria.IBS_UF.fltAliquota := dadosGerais.ReformaTributariaCreditoDebito.fltAlqIBS ;
    dadosItem.ReformaTributaria.IBS_UF.fltValor    := dadosGerais.ReformaTributariaCreditoDebito.fltValIBS ;
    dadosItem.ReformaTributaria.IBS_UF.fltPerDif   := 0;
    dadosItem.ReformaTributaria.IBS_UF.fltValDif   := 0;
    dadosItem.ReformaTributaria.IBS_UF.fltTriDev   := 0;
    dadosItem.ReformaTributaria.IBS_UF.fltPerRed   := 0;
    dadosItem.ReformaTributaria.IBS_UF.fltAlqEfe   := 0;

    dadosItem.ReformaTributaria.IBS_MUN := TIBS_MUN.Create;
    dadosItem.ReformaTributaria.IBS_MUN.fltAliquota := 0;
    dadosItem.ReformaTributaria.IBS_MUN.fltValor    := 0;
    dadosItem.ReformaTributaria.IBS_MUN.fltPerDif   := 0;
    dadosItem.ReformaTributaria.IBS_MUN.fltValDif   := 0;
    dadosItem.ReformaTributaria.IBS_MUN.fltTriDev   := 0;
    dadosItem.ReformaTributaria.IBS_MUN.fltPerRed   := 0;
    dadosItem.ReformaTributaria.IBS_MUN.fltAlqEfe   := 0;

    If Not Assigned(dadosGerais.ReformaTributariaTotal) Then
      dadosGerais.ReformaTributariaTotal := TIBS_CBS_SEL_TOTAL.Create;

    dadosGerais.ReformaTributariaTotal.fltValorTotalBase     := IIF(fEhCstReformaTributariaSemAliquota, 0, dadosGerais.ReformaTributariaCreditoDebito.fltBasCal) ;
    dadosGerais.ReformaTributariaTotal.fltValorTotalIS       := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalCBS      := IIF(fEhCstReformaTributariaSemAliquota, 0, dadosGerais.ReformaTributariaCreditoDebito.fltValCBS) ;
    dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_UF   := IIF(fEhCstReformaTributariaSemAliquota, 0, dadosGerais.ReformaTributariaCreditoDebito.fltValIBS) ;
    dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_MUN  := 0;
    dadosGerais.ReformaTributariaTotal.fltValorTotalGrupoIBS := IIF(fEhCstReformaTributariaSemAliquota, 0, dadosGerais.ReformaTributariaCreditoDebito.fltValIBS) ;
    dadosGerais.ReformaTributariaTotal.fltValorTotalNFe      := dadosItem.fltTotIte;

    pAdicionaItem(dadosItem);
  End;

end;

procedure TNFEFit400.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
  Var
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
    strMensagem: String;
    intStatus: Integer;
    intTentativas: Integer;
    intStatusOk: TIntegerDynArray;
begin
  pLogImp('TNFEFit400.pInutilizarNumeros');
  intTentativas := 0;

  SetLength(intStatusOk, 1);
  intStatusOk[0] := 1;

  strNumeroInicial := IntToStr(StrToInt(strNumeroInicial));
  strNumeroFinal := IntToStr(StrToInt(strNumeroFinal));

  strTexto := 'NFE-INUT|' +
              fonteDados.fDadosEmitente.strCnpj + '|' +
              strAno + '|' +
              strSerie + '|' +
              strNumeroInicial + '|' +
              strNumeroFinal + '|' +
              strDescricao + '|' +
              '|' +
              '55';

  retornoFit := fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', 7, intStatusOk);
  If Not retornoFit.RetornoOk Then
  Begin
    pGrvArqTxt('ENVIO_INUT_' + strNumeroInicial + '_' + strNumeroFinal + '_' + strSerie + '_' + objConfig.strCodEmp, retornoFit.Texto);

    strMensagem := fGetValorLinha(retornoFit.Texto, '|', 8);
    Raise ErrosValidacaoNFE.fCriaErroSimples(strMensagem);
  End;

  Repeat
    Sleep(1000);
    retornoFit := fitWrapper.fConsultaSituacaoInutilizacao(fonteDados.fDadosEmitente.strCnpj, strSerie, strNumeroInicial);
    intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 16), 0);
    If (fEmptyStr(fGetValorLinha(retornoFit.Texto, '|', 7))) Then
    Begin
      intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 5), 0);
    End;

    If (intStatus > 200) Or (intTentativas = 180) Then
    Begin
      pGrvArqTxt('CONSULTA_INUT_' + strNumeroInicial + '_' + strNumeroFinal + '_' + strSerie + '_' + objConfig.strCodEmp, retornoFit.Texto);

      If (fEmptyStr(fGetValorLinha(retornoFit.Texto, '|', 7))) Then
      Begin
        Raise ErrosValidacaoNFE.fCriaErroSimples(fGetValorLinha(retornoFit.Texto, '|', 6));
      End
      Else
      Begin
        Raise ErrosValidacaoNFE.fCriaErroSimples(fGetValorLinha(retornoFit.Texto, '|', 8));
      End;
    End;
    Inc(intTentativas);
  Until (intStatus = RET_INUTILIZACAO_OK) Or (intStatus = RET_INUTILIZACAO_OK_FIT);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFEFit400.fLocalDestinoOperacao: String;
begin
  If Pos(LeftStr(dadosGerais.strClaFis, 1), '1,5') > 0 Then
    Result := '1'  // Operação interna
  Else If Pos(LeftStr(dadosGerais.strClaFis, 1), '2,6') > 0 Then
    Result := '2'  // Operação interestadual
  Else
    Result := '3'; // Operação com exterior
end;

function TNFEFit400.fIndicadorIEDestinatario: String;

  function fTemIESUni: Boolean;
  Begin
    Result:= (fonteDados.fCampoExiste('CADCLI', 'CLI_IESUNI'));
  End;

  function fEhContribuinte: Boolean;
  Begin
    Result := (fonteDados.fDadosGerais.strEstado = 'EX');
  End;

  function fEhNaoContribuinte: Boolean;
  Begin
    Result := False;

    If ((Not fTemIESUni) And fEmptyStr(dadosGerais.strIES)) Then
    Begin
      Result := True;
      Exit;
    End;

    If (fTemIESUni And (fonteDados.fDadosGerais.strIESUni = 'S')) Then
    Begin
      Result := True;
      Exit;
    End;

    If (Pos(fonteDados.fDadosGerais.strCodAti, objConfig.strVS_CliAti) > 0) Then
    Begin
      Result := True;
      Exit;
    End;

    If ((Length(dadosGerais.strCnpj) = 11) And (Pos('ISENT', dadosGerais.strIES) > 0)) Then
    Begin
      Result := True;
      Exit;
    End;

    If ((fonteDados.fDadosGerais.strProdutorRural = 'S') And (Not fTemIESUni)) Then
    Begin
      Result := True;
      Exit;
    End;

    If ((fonteDados.fDadosGerais.strProdutorRural = 'S') And (fTemIESUni) And (fonteDados.fDadosGerais.strIESUni = 'S')) Then
    Begin
      Result := True;
      Exit;
    End;
  End;

  function fEhContribuinteIsento: Boolean;
  Begin
    Result := (Pos('ISENT', dadosGerais.strIES) > 0);
  End;

begin
  Result := '1'; // Contribuinte ICMS (informar a IE do destinatário);

  If fEhContribuinte Then
  Begin
    Result := '1'; // Contribuinte ICMS (informar a IE do destinatário);
    Exit;
  End;

  If fEhNaoContribuinte Then
  Begin
    Result := '9'; // Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS.
    Exit;
  End;

  If fEhContribuinteIsento Then
  Begin
    Result := '2'; // Contribuinte isento de Inscrição no cadastro de Contribuintes do ICMS;
    Exit;
  End;
end;

function TNFEFit400.fDeveProcessarContingencia(const intTipoEmissao: Integer; const strContingenciaAutorizada: String): Boolean;
begin
  Result := False;

  If (strContingenciaAutorizada <> 'S') Then
  begin
    pLogImp('fDeveProcessarContingencia = Não (strContingenciaAutorizada = "N")');
    Exit;
  end;

  If fEhSefazVirtualContingencia(intTipoEmissao) Then
  Begin
    Result := True;
    pLogImp('fDeveProcessarContingencia = Sim (fEhSefazVirtualContingencia)');
    Exit;
  End;

  If (intTipoEmissao = TIPO_DPEC) Then
  Begin
    Result := True;
    pLogImp('fDeveProcessarContingencia = Sim (intTipoEmissao = TIPO_DPEC)');
    Exit;
  End;
end;

function TNFEFit400.fTransferenciaDeveUsarCSOSN400 : Boolean;
  Var
    strTRCSOS : String;
begin
  Result := True;
  If (objConfig.strAPCSOS <> 'S') Then
    Exit;
  strTRCSOS := fCfgSisFonte(fonteDados, 'TRCSOS');
  If fEmptyStr(strTRCSOS) Then
    Exit;
  Result := (strTRCSOS = 'N');
end;

function TNFEFit400.fDocumentoSeraEmitidoComTagEntrega(
  const strTag: String): Boolean;
begin
  Result := (strTag = 'NFE-ENTREGA|');
end;

function TNFEFit400.fIndicadorConsumidorFinal: String;
begin
  if (dadosGerais.strOriundoOS = 'S') and (fCfgSisFonte(fonteDados, 'SIMPAU') = 'S') and (fCfgSisFonte(fonteDados, 'CSTCEQ') = 'S') then
    Result := '1'
  else
    Result := IfThen(dadosGerais.strCliCon <> 'S', '0', '1');
end;

function TNFEFit400.fIndicadorPresenca: String;
   Var
     strIdentPorCfg: String;
     strINDPRES: String;
begin
  strIdentPorCfg := fCfgSisFonte(fonteDados, 'HRIDLK');
  strINDPRES := fCfgSisFonte(fonteDados, 'INDPRE');

  If Not fEmptyStr(strIdentPorCfg) Then
    Result := strIdentPorCfg //HENRIMAR usa essa abordagem;
  Else If ((fonteDados.fDadosGerais.strEstado = 'EX') Or (dadosGerais.blnEntFat)) And (Not dadosGerais.blnVenPre) Then
  Begin
    Result := '9'; // 9 – Operação não presencial, outros.

    If (fonteDados.fDadosGerais.strEstado = 'EX') And (LeftStr(dadosGerais.strClaFis, 1) = '3') And (Not fEmptyStr(strINDPRES)) Then
      Result := strINDPRES;
  End
  Else If Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_COMPLEMENTAR) > 0 Then
  begin
    if fonteDados.fDadosGerais.blnVenPre then
      Result := '1'
    else
      Result := '0'; // 0 – Não se aplica (por exemplo, Nota Fiscal complementar ou de ajuste)
  end
  Else If Not fEmptyStr(dadosGerais.strPedSit) Then
    Result := '2' // 2 – Operação não presencial, pela Internet;
  Else If (fonteDados.fDadosGerais.blnVenPre) Then
    Result := '1' // 1 – Operação presencial;
  Else If Not fEmptyStr(dadosGerais.strNumPok) Then
    Result := '9' // 9 – Operação não presencial, outros.
  Else If (fonteDados.fDadosGerais.strEstado <> dadosEmitente.strEstado) Then
    Result := '9' // 9 – Operação não presencial, outros.
  Else
    Result := '1'; // 1 – Operação presencial;

  // NOVA OPÇÃO: 5 – Operação presencial, fora do estabelecimento
end;

function TNFEFit400.fIndicadorIntermediador: String;
  Var
    strValCfg: String;
begin
  Result := '';
    
  strValCfg := fCfgSisFonte(fonteDados, 'IDIMNF');
  If (Pos(fIndicadorPresenca, strValCfg) > 0) Then 
    Result := IfThen(dadosGerais.strCnpjIntermediadorTransacao = '','0','1');
end;

function TNFEFit400.fUsarEnderecoDeEntregaComoEnderecoPrincipal: Boolean;
begin

  Result := False;

  If not (fCfgSisFonte(fonteDados, 'UEENTP') = 'S') Then
    Exit;

  If not (fonteDados.fDadosGerais.strEstado <> dadosEmitente.strEstado) Then
    Exit;

  If not fonteDados.fDadosGerais.blnVenPre then
    Exit;

  If not (fonteDados.fDadosGerais.strEstadoEndEnt = dadosEmitente.strEstado) Then
    Exit;

  If not (fCfgSisFonte(fonteDados, 'VPDEFO') = 'D') Then
    Exit;

  If not (fonteDados.fDadosGerais.strRegFis = '2') Then
    Exit;

  Result := True;

end;

procedure TNFEFit400.pNFE;
  Var
    strLinha: String;
    strCnpjDestinatario : String;

  function fInscricaoEstadualSubstitutoTributario: String;
   Var
     strLisUFNaoEnviaIE: String;
  begin
    Result := dadosEmitente.strIESST;

    If (fonteDados.fDadosGerais.blnVenPre) Then
    Begin
      strLisUFNaoEnviaIE := fCfgSisFonte(fonteDados, 'SUTBNF'); //Não envia no arquivio a IE do Substituto Tributario
      
      If (Pos(dadosEmitente.strEstado, strLisUFNaoEnviaIE) > 0) Then
        Result := '';

      If (Not fEmptyStr(Result)) And (fDocumentoEntregaFuturaClienteVaiRetirar(fonteDados)) Then
        Result := '';
    End;
  End;
 {********************************************************************************}
 {* ESSE TRECHO FOI FEITO PARA ATENDER VERSÕES QUE NÃO TEM O CAMPO DE FINALIDADE *}
 {*****************************************************************************BZ*}
  procedure pPreparaTipoDeCreditoDebito;
  begin
    If dadosGerais.blnDesativaSinief_08_2026 Then
      Exit;

    If not fEmptyStr(dadosGerais.strFinalidade) Then
      Exit;

    If not fEmptyStr(dadosGerais.strTipoDebito + dadosGerais.strTipoCredito) Then
      Exit;

    If (Pos(dadosGerais.strClaFis, '5922_6922_') > 0) Then
    Begin
      dadosGerais.strFinalidade  := '6';
      dadosGerais.strTipoDebito  := '06';
      dadosGerais.strTipoCredito := '';
    End;

    If (Pos(dadosGerais.strClaFis, '5927_6927_') > 0) Then
    Begin
      dadosGerais.strFinalidade  := '6';
      dadosGerais.strTipoDebito  := '07';
      dadosGerais.strTipoCredito := '';
    End;
  end;

begin
  pPreparaTipoDeCreditoDebito;

  strLinha := '';
  strLinha := strLinha + 'NFE|';                                                              // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                        // 02 - ID Referência
  strLinha := strLinha + dadosEmitente.strCnpj + '|';                                          // 03 - CNPJ Emitente

  If dadosGerais.blnEst_Dv Then
  Begin
    If (fEstornoEntregaFutura) Then
      strLinha := strLinha + LeftStr(dadosGerais.strDescricaoClaFis, 60) + '|'                         // 04 - Natureza da Operação
    Else
      strLinha := strLinha + LeftStr('999 - Estorno de NF-e não cancelada no prazo legal', 60) + '|'   // 04 - Natureza da Operação
  End
  Else
    strLinha := strLinha + LeftStr(dadosGerais.strDescricaoClaFis, 60) + '|';                  // 04 - Natureza da Operação

  strLinha := strLinha + '|';                                                                  // 05 - Forma de Pagamento (0-A Vista,1-A Prazo,2-Outros)
  strLinha := strLinha + IfThen(dadosGerais.strEspDoc='IF', '65', '55') + '|';                 // 06 - Código do modelo do documento fiscal (55-NFe, 65-NFCe)
  strLinha := strLinha + dadosGerais.strSerie + '|';                                           // 07 - Série
  strLinha := strLinha + fNumDocEnvio(dadosGerais.strNumDoc) + '|';                            // 08 - Número
  strLinha := strLinha + fDataHora(dadosGerais.dtaDtaEnt + dadosGerais.dtaHorEnt) + '|';       // 09 - Data e hora de emissão do documento fiscal

  If dadosGerais.dtaDtaDoc > 0 Then
    strLinha := strLinha + fDataHora(dadosGerais.dtaDtaDoc + dadosGerais.dtaHorDoc) + '|'      // 10 - Data e hora de saída do documento fiscal
  Else
    strLinha := strLinha + '|';                                                                // 10 - Data e hora de saída do documento fiscal

  strLinha := strLinha + '|';                                                                  // 11 - Hora de saída / entrada (não utilizado);
  strLinha := strLinha + IfThen(dadosGerais.strClaFis > '5000', 'S', 'E') + '|';               // 12 - Entrada / Saída
  strLinha := strLinha + fLocalDestinoOperacao + '|';                                          // 13 - Identificador do local de destino de operação
  strLinha := strLinha + IfThen(objConfig.blnHomolo, '2', '1') + '|';                          // 14 - Tipo de Ambiente 1-Produção 2-Homologação
  strLinha := strLinha + fFinalidadeEmissao + '|';                                             // 15 - Finalidade Emissão NF-e
  strLinha := strLinha + dadosEmitente.strCodIbge + '|';                                       // 16 - Código do Município do Fato Gerador
  strLinha := strLinha + '1' + '|';                                                            // 17 - Formato de Impressão do DANFE (Fixo 1-Retrato)
  strLinha := strLinha + fIndicadorConsumidorFinal + '|';                                      // 18 - Indica operação com Consumidor final (0-Normal 1-Consumidor Final)
  strLinha := strLinha + fIndicadorPresenca + '|';                                             // 19 - Indicador de presença do comprador no estabelecimento comercial no momento da operação

  strCnpjDestinatario := dadosGerais.strCnpj;
  If (fEmptyStr(strCnpjDestinatario)) And (Not fEmptyStr(dadosGerais.strIdEstrangeiro)) Then
    strCnpjDestinatario := '00000000000';

  strLinha := strLinha + strCnpjDestinatario + '|';                                            // 20 - CNPJ/CPF Destinatário
  strLinha := strLinha + dadosGerais.strIdEstrangeiro + '|';                                   // 21 - Identificação do destinatário no caso de comprador estrangeiro
  strLinha := strLinha + LeftStr(dadosGerais.strNomCli, 60) + '|';                             // 22 - Razão Social ou Nome do Destinatário
  strLinha := strLinha + '|';                                                                  // 23 - Nome Fantasia do Destinatário

  If fUsarEnderecoDeEntregaComoEnderecoPrincipal Then
  Begin
    strLinha := strLinha + Trim(LeftStr(dadosGerais.strLogradouroEndEnt, 60)) + '|';           // 24 - Logradouro Destinatário
    strLinha := strLinha + dadosGerais.strNumeroEndEnt + '|';                                  // 25 - Número Logradouro Destinatário
    strLinha := strLinha + LeftStr(dadosGerais.strComplementoEndEnt, 60) + '|';                // 26 - Complemento Logradouro Destinatário
    strLinha := strLinha + dadosGerais.strBairroEndEnt + '|';                                  // 27 - Bairro Destinatário
    strLinha := strLinha + dadosGerais.strCodIbgeEntrega + '|';                                // 28 - Código IBGE do Município Destinatário
    strLinha := strLinha + dadosGerais.strCEPEndEnt + '|';                                     // 29 - CEP Destinatário
  End
  Else
  Begin
    strLinha := strLinha + Trim(LeftStr(dadosGerais.strLogradouro, 60)) + '|';                 // 24 - Logradouro Destinatário
    strLinha := strLinha + dadosGerais.strNumeroEnd + '|';                                     // 25 - Número Logradouro Destinatário
    strLinha := strLinha + LeftStr(dadosGerais.strComplementoEnd, 60) + '|';                   // 26 - Complemento Logradouro Destinatário
    strLinha := strLinha + dadosGerais.strBairro + '|';                                        // 27 - Bairro Destinatário
    strLinha := strLinha + dadosGerais.strCodIbge + '|';                                       // 28 - Código IBGE do Município Destinatário
    strLinha := strLinha + dadosGerais.strCEP + '|';                                           // 29 - CEP Destinatário
  End;

  strLinha := strLinha + dadosGerais.strCodigoPais + '|';                                      // 30 - Código BACEN Pais Destinatário
  strLinha := strLinha + dadosGerais.strTelefone + '|';                                        // 31 - Telefone Destinatário
  strLinha := strLinha + fIndicadorIEDestinatario + '|';                                       // 32 - Indicador da IE do Destinatário
  strLinha := strLinha + IfThen(Pos(fIndicadorIEDestinatario, '19') > 0, dadosGerais.strIES, '') + '|'; // 33 - Inscrição Estadual Destinatário
  strLinha := strLinha + dadosGerais.strSuframa + '|';                                         // 34 - Inscrição Suframa Destinatário
  strLinha := strLinha + '|';                                                                  // 35 - Inscrição Municipal do Tomador do Serviço (não é obrigatório)
  strLinha := strLinha + Trim(dadosGerais.strEmail) + '|';                                     // 36 - e-mail destinatário
  strLinha := strLinha + LeftStr(dadosGerais.strDocsPD, 12) + '|';                             // 37 - Numero do Pedido
  strLinha := strLinha + '|';                                                                  // 38 - Carga / Rota
  strLinha := strLinha + fInscricaoEstadualSubstitutoTributario + '|';                         // 39 - Inscrição Estadual S.T.
  strLinha := strLinha + '|';                                                                  // 40 - Chave de Acesso - Chave de Acesso da NF-e Caso esse campo não seja informado, o sistema gerará automaticamente
  strLinha := strLinha + '|';                                                                  // 41 - ID Externo - Codigo Referencial
  strLinha := strLinha + '|';                                                                  // 42 - Codigo Verificador Chave Acesso - cDIV
  strLinha := strLinha + '|';                                                                  // 43 - Codigo do Cliente - Codigo do cliente para impressão na DANFE
  strLinha := strLinha + '|';                                                                  // 44 - Descrição IBGE do Município Destinatário - Só informar caso não queira utilizar a descrição padrão
  strLinha := strLinha + '|';                                                                  // 45 - Tipo de emissão - Não obrigatório. Informar 2 para emissão em contingencia FS - Formulário de Segurança.
  strLinha := strLinha + '|';                                                                  // 46 - Regime Tributário (CRT) - 1 - Simples Nacional; 2 - Simples Nacional, excesso sublimite de receita bruta; 3 - Regime Normal. Quando não informado o sistema pegará do Cadastro da Empresa.
  strLinha := strLinha + '|';                                                                  // 47 - Envio Assíncrono - - Sim N - Não Default N. Determina se o envio do documento da Sefaz será assíncrono. Caso SIM, irá retornar para o client logo após validar o schema do XML.
  strLinha := strLinha + '|';                                                                  // 48 - Versão da Aplicação -
  strLinha := strLinha + fIndicadorIntermediador + '|';                                        // 49 - Indicador de intermediador/marketplace - 0 – Operação sem intermediador (em site ou plataforma própria); 1 – Operação em site ou plataforma de terceiros (intermediadores/marketplace)
  strLinha := strLinha + '|';                                                                  // 50 - Código do Município do Fato Gerador IBS/CBS
  strLinha := strLinha + dadosGerais.strTipoDebito + '|';                                      // 51 - Tipo de Nota de Débito
  strLinha := strLinha + dadosGerais.strTipoCredito + '|';                                     // 52 - Tipo de Nota de Crédito

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFEAutorizacaoDownloadXml;
  Var
    strLinha : String;
    strCgc   : String;
begin
  strCgc := '';
  If dadosGerais.blnTemEscritorioCredenciado Then
  Begin
    if (fCfgSisFonte(fonteDados, 'ESCDOW') = 'S') then
    begin
      if not(fEmptyStr(dadosGerais.strEscCre)) then
        strCgc := dadosGerais.strEscCre
      else if not(fEmptyStr(fCfgSisFonte(fonteDados, 'ESCCGC'))) then
        strCgc := fCfgSisFonte(fonteDados, 'ESCCGC')
      else
        Exit;
    end
    Else
      Exit;
  End
  Else
  Begin
    If (fEmptyStr(strCgc)) And
       ((Not dadosGerais.blnTemItemTigre) Or (fCfgSisFonte(fonteDados, 'AUTCGC') = dadosGerais.strCnpj)) Then
    Begin
      Exit;
    End
    else
    Begin
      strCgc := fCfgSisFonte(fonteDados, 'AUTCGC');
    End;
  End;

  If fCfgSisFonte(fonteDados, 'ESCCGC') = dadosGerais.strCnpj Then
    Exit;

  strLinha := '';
  strLinha := strLinha + 'NFE-PESSOA-DOWNLOAD-XML|';                                                  // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                          dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';         // 02 - ID Referência
  strLinha := strLinha + '1|';                                                                        // 03 - Número do Item
  strLinha := strLinha + strCgc;                                                                      // 04 - CPF/CNPJ Destinatário

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFECompra;

  function fTemItemOrgPub(var strPedCmps: string): boolean;
    var
      item: TDadosItem;
      intContador: integer;
  begin
    strPedCmps := '';

    Result := False;

    if not Assigned(lstItens) then
      exit;

    For intContador := 0 To lstItens.Count -1 Do
    Begin
      item := TDadosItem(lstItens[intContador]);

      if not Assigned(item) then
        Continue;

      if (item.fltIcmOrg > 0) Or (item.fltVrdIcm > 0) then
      begin
        if (not fEmptyStr(item.strPedCom)) and (Pos(item.strPedCom, strPedCmps) <= 0) then
        begin
          if fEmptyStr(strPedCmps) then
            strPedCmps := item.strPedCom
          else
            strPedCmps := strPedCmps + ', ' + item.strPedCom;
        end;
        Result := True;
      end;
    end;
  end;

  var
    strLinha : string;
    strPedCmp: string;
begin
  if not ((dadosGerais.blnOrgPub) and (fTemItemOrgPub(strPedCmp))) then
    exit;

  if fEmptyStr(strPedCmp) then
    exit;

  strLinha := '';
  strLinha := strLinha + 'NFE-COMPRA|';                                                                     // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                     // 002 - ID Referência
  strLinha := strLinha + LeftStr(strPedCmp, 22) + '|';                                                      // 003 - Nota de Empenho       1-22
  strLinha := strLinha + LeftStr(strPedCmp, 60) + '|';                                                      // 004 - Pedido de Compra      1-60
  strLinha := strLinha + '|';                                                                               // 005 - Contrato de Compra    1-60
  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFEInformacoesDePagamento;
  Var
    strLinha : String;
    intContador : Integer;
    fltValor : Double;
    fltTroco : Double;
    strCNPJ_InstDePagto : String;
    arrEndToEndIdPixDistribuido : TArrString;
    stlRetEndToEndIdPixSemModalidade : TStringList;
    intCntPix : Integer;

    function fCalculaTroco: Double;
    var intPosicao: Integer;
        fltTotalNota,
        fltTotalModalidade: Double;
    Begin
      fltTotalModalidade := 0;
      fltTotalNota := dadosGerais.fltTotGer;

      For intPosicao := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
        fltTotalModalidade := fltTotalModalidade + dadosGerais.arrFormasPagamento[intPosicao].fltValor;

      Result := (fltTotalModalidade - fltTotalNota);

      If Result < 0 Then
        Result := 0;
    End;

    function fTipoIntegracaoPix: String;
    Begin
      Result := '2';

      If fEmptyStr(dadosGerais.arrFormasPagamento[intContador].strCnpjFinanceira) Then
        Exit;

      If fEmptyStr(dadosGerais.arrFormasPagamento[intContador].strCnpjBeneficiario) Then
        Exit;

      Result := '1';
    End;

    function fEhPagamentoPosterior: Boolean;
    begin
      Result := False;

      if not (fCfgSisFonte(fonteDados, 'NFE_PP') = 'S') then
        Exit;

      If fEmptyStr(dadosGerais.strCondPagamento) Then
        Exit;

      If (dadosGerais.strCondPagamento = '01000') Then
        Exit;

      If (Copy(dadosGerais.strCondPagamento, 3, 3) = '000') Then
        Exit;

      If Pos(dadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_17_20_') > 0 Then
        Exit;

      Result := True;
    end;

begin
  If (Length(dadosGerais.arrFormasPagamento) <= 0) Then
    Exit;

  fltTroco := fCalculaTroco;

  SetLength(arrEndToEndIdPixDistribuido, 0);

  For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
  Begin
    strLinha := '';
    strLinha := strLinha + 'NFE-FORMA-PAGAMENTO|';                                                      // 01 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                            dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';         // 02 - ID Referência

    strLinha := strLinha + IntToStr(intContador+1) + '|';                                               // 03 - Número do Item

    fltValor := dadosGerais.arrFormasPagamento[intContador].fltValor;

    If (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_DEVOLUCAO) > 0) Or (Length(dadosGerais.arrDuplicatas) <= 0) Then
    Begin
      strLinha := strLinha + '90' + '|';                                                           // 04 - Forma de Pagamento
      strLinha := strLinha + fValor(0, 15, 2) + '|';                                               // 05 - Valor do Pagamento
      strLinha := strLinha + fValor(0, 15, 2) + '|';                                               // 06 - Valor do Troco
      strLinha := strLinha + '0|';                                                                 // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo
    End
    Else
    If fEhPagamentoPosterior Then
    Begin
      strLinha := strLinha + '91' + '|';                                                           // 04 - Forma de Pagamento
      strLinha := strLinha + fValor(0, 15, 2) + '|';                                               // 05 - Valor do Pagamento
      strLinha := strLinha + fValor(0, 15, 2) + '|';                                               // 06 - Valor do Troco
      strLinha := strLinha + '1|';                                                                 // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo
    End
    Else
    Begin
      strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strCodigo + '|';          // 14, 04 - Forma de Pagamento
      strLinha := strLinha + fValor(fltValor, 15, 2) + '|';                                        // 05 - Valor do Pagamento
      strLinha := strLinha + fValor(fltTroco, 15, 2) + '|';                                        // 06 - Valor do Troco
      strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].indPag + '|';             // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo

      If Pos(dadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_17_20_') > 0 Then
      Begin
        strLinha := strLinha                                                                + '|'; // 08 - Descrição do Meio de Pagamento
        strLinha := strLinha                                                                + '|'; // 09 - CNPJ transacional do pagamento
        strLinha := strLinha                                                                + '|'; // 10 - UF do CNPJ do estabelecimento onde o pagamento foi processado/transacionado/recebido
        strLinha := strLinha + fData(dadosGerais.arrFormasPagamento[intContador].dtaDtaPag) + '|'; // 11 - Data do Pagamento
      End;
    End;

    stlArquivo.Add(strLinha);

    If Pos(dadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_') > 0 Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-GRUPO-CARTOES|';                                                      // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                              dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';       // 02 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                                  // 03 - Número do Item

      If Not fEmptyStr(dadosGerais.strCnpjIntermediadorTransacao) Then
        strCNPJ_InstDePagto := dadosGerais.strCnpjIntermediadorTransacao
      Else
        strCNPJ_InstDePagto := arrFormasPagamentoInterna[intContador].strCnpjOperadora;

      strLinha := strLinha + strCNPJ_InstDePagto                                        + '|';            // 04 - CNPJ Credenciadora
      strLinha := strLinha + arrFormasPagamentoInterna[intContador].strBandeira         + '|';            // 05 - Bandeira
      strLinha := strLinha + arrFormasPagamentoInterna[intContador].strNumAutorizacao   + '|';            // 06 - Num.Aut.
      strLinha := strLinha + arrFormasPagamentoInterna[intContador].strTipCar           + '|';            // 07 - POS / TEF
      strLinha := strLinha + arrFormasPagamentoInterna[intContador].strCnpjBeneficiario + '|';            // 08 - CNPJ do beneficiário do pagamento

      stlArquivo.Add(strLinha);
    End

    Else If ((fCfgSisFonte(fonteDados, 'PGPIXL') = 'S') Or (dadosGerais.strFinalidade = '6')) And
            (dadosGerais.arrFormasPagamento[intContador].strCodigo = FORMA_PAGTO_PIX) Then
    Begin
      If (Not fEmptyStr(dadosGerais.arrFormasPagamento[intContador].strEndToEndIdPix)) And
         (Not fExisteElementoMatriz(dadosGerais.arrFormasPagamento[intContador].strEndToEndIdPix, arrEndToEndIdPixDistribuido)) Then
      Begin
        strLinha := '';
        strLinha := strLinha + 'NFE-GRUPO-CARTOES|';                                                      // 01 - Tipo do Registro
        strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                                dadosGerais.strSerie, dadosGerais.strEspDoc)   + '|';     // 02 - ID Referência
        strLinha := strLinha + IntToStr(intContador+1)                                         + '|';     // 03 - Número do Item
        strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strCnpjFinanceira   + '|';     // 04 - CNPJ Credenciadora
        strLinha := strLinha                                                                   + '|';     // 05 - Bandeira
        strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strEndToEndIdPix    + '|';     // 06 - Num.Aut.
        strLinha := strLinha + fTipoIntegracaoPix                                              + '|';     // 07 - POS / TEF
        strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strCnpjBeneficiario + '|';     // 08 - CNPJ do beneficiário do pagamento

        stlArquivo.Add(strLinha);
        pAcrescentaElementoMatriz(dadosGerais.arrFormasPagamento[intContador].strEndToEndIdPix, arrEndToEndIdPixDistribuido);
      End
      Else
      Begin
        stlRetEndToEndIdPixSemModalidade := fRetEndToEndIdPixSemModalidade(dadosGerais);
        Try
          For intCntPix := 0 To Pred(stlRetEndToEndIdPixSemModalidade.Count) Do
          Begin
            If (fExisteElementoMatriz(stlRetEndToEndIdPixSemModalidade[intCntPix], arrEndToEndIdPixDistribuido)) Then
              Continue;
            strLinha := '';
            strLinha := strLinha + 'NFE-GRUPO-CARTOES|';                                                      // 01 - Tipo do Registro
            strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                                    dadosGerais.strSerie, dadosGerais.strEspDoc)   + '|';     // 02 - ID Referência
            strLinha := strLinha + IntToStr(intContador+1)                                         + '|';     // 03 - Número do Item
            strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strCnpjFinanceira   + '|';     // 04 - CNPJ Credenciadora
            strLinha := strLinha                                                                   + '|';     // 05 - Bandeira
            strLinha := strLinha + stlRetEndToEndIdPixSemModalidade[intCntPix]                     + '|';     // 06 - Num.Aut.
            strLinha := strLinha + fTipoIntegracaoPix                                              + '|';     // 07 - POS / TEF
            strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strCnpjBeneficiario + '|';     // 08 - CNPJ do beneficiário do pagamento

            stlArquivo.Add(strLinha);
            pAcrescentaElementoMatriz(stlRetEndToEndIdPixSemModalidade[intCntPix], arrEndToEndIdPixDistribuido);
            Break;
          End;
        Finally
          FreeAndNil(stlRetEndToEndIdPixSemModalidade);
        End;
      End;
    End;

  End;
end;

procedure TNFEFit400.pNFEInformacoesDoIntermediadorDaTransacao;
Var
  strLinha: String;
  strIDRef: String;
begin
  If fEmptyStr(dadosGerais.strCnpjIntermediadorTransacao) Then
    Exit;

  If fEmptyStr(fIndicadorIntermediador) Then
    Exit;

  strIDRef := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  strLinha := '';
  strLinha := strLinha + 'NFE-INTERMEDIADOR-TRANSACAO|';                          // 01 - Tipo do Registro
  strLinha := strLinha + strIDRef + '|';                                          // 02 - ID Referência
  strLinha := strLinha + dadosgerais.strCnpjIntermediadorTransacao+ '|';          // 03 - CNPJ do Intermediador da Transação (agenciador, plataforma de delivery, marketplace e similar) de serviços e de negócios
  strLinha := strLinha + dadosgerais.strIdentificacaoIntermediadorTransacao+ '|'; // 04 - Identificador cadastrado no intermediador - Nome do usuário ou identificação do perfil do vendedor no site do intermediador (agenciador, plataforma de delivery, marketplace e similar) de serviços e de negócios.

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFEDadosAdicionais;
  Const
    MAX_LENGTH_INFADFISCO : Integer = 2000;
    MAX_LENGTH_INFCPL : Integer = 5000;
  Var
    strTexto: String;
    strAuxil: String;
    stlMensagens: TStringList;
    intContador: Integer;
    strLinha: String;
    intLinha: Integer;
    intUtilizadoInfAdFisco : Integer;
    intUtilizadoInfCpl : Integer;

    function fEhMensagemInteresseFisco(const intNLinha : Integer): Boolean;
    begin
      Result := (intNLinha >= 500) And (intNLinha <= 900);
    end;

    procedure pAddMensagem(strMsg: String='');
      Var
        intLengthMsg : Integer;
    Begin
      If fEmptyStr(strMsg) Then
        strMsg := stlMensagens[intContador];

      If fEmptyStr(strMsg) Then
        Exit;

      intLengthMsg := Length(strMsg);

      If fEhMensagemInteresseFisco(intLinha) Then
      Begin
        If ((intLengthMsg + intUtilizadoInfAdFisco) > MAX_LENGTH_INFADFISCO) Then
          Exit;
        intUtilizadoInfAdFisco := intUtilizadoInfAdFisco + intLengthMsg;
      End
      Else
      Begin
        If ((intLengthMsg + intUtilizadoInfCpl) > MAX_LENGTH_INFCPL) Then
          Exit;
        intUtilizadoInfCpl := intUtilizadoInfCpl + intLengthMsg;
      End;

      strLinha := '';
      strLinha := strLinha + 'NFE-DADOS-ADIC|';                                                 // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                     // 02 - ID Referência
      strLinha := strLinha + IntToStr(intLinha) + '|';                                          // 03 - Número da Linha ( Sequencial )
      strLinha := strLinha + strMsg + '|';                                                      // 04 - Informações Adicionais
      stlArquivo.Add(strLinha);
      Inc(intLinha);
    End;

    function fEhIcmsDesoneradoX40: Boolean;
    Begin
      Result := False;

      If (dadosGerais.strZonFra = 'S') And (dadosGerais.strDesZon = 'S') Then
        Exit;

      Result := blnIcmsDesoneradoX40 And (fltTotalValorIcmsDesonerado > 0);
    End;

begin
  stlMensagens := TStringList.Create;

  Try
    intUtilizadoInfAdFisco := 0;
    intUtilizadoInfCpl := 0;

    {***********************************************}
    {* AQUI INICIA MENSAGENS ADICIONAIS COMERCIAIS *}
    {********************************************BZ*}
    If Not fEmptyStr(dadosGerais.strMsgAdicional) Then
    Begin
      strTexto := AnsiReplaceStr(dadosGerais.strMsgAdicional, '#', sLineBreak);
      strTexto := AnsiReplaceStr(strTexto, '<<csq>>', sLineBreak);
      strTexto := WrapText(strTexto, 255);

      stlMensagens.Text := strTexto;
      intLinha := 1;

      For intContador := 0 To stlMensagens.Count -1 Do
        pAddMensagem;
    End
    Else
    Begin
      {***********************************}
      {* MENSAGENS ADICIONAIS COMERCIAIS *}
      {********************************FC*}
      If Not fEmptyStr(dadosGerais.strMsgAdicionalCom) Then
      Begin
        strTexto := AnsiReplaceStr(dadosGerais.strMsgAdicionalCom, '#', sLineBreak);
        strTexto := AnsiReplaceStr(strTexto, '<<csq>>', sLineBreak);
        strTexto := WrapText(strTexto, 255);

        stlMensagens.Text := strTexto;
        intLinha := 1;

        For intContador := 0 To stlMensagens.Count -1 Do
          pAddMensagem;
      End;
    End;

    If (fCfgSisFonte(fonteDados, 'DUPADC') = 'S') Then
    Begin
      strAuxil := fRetornaListaDuplicataQuitadaCredito(dupCredito);
      If (Not fEmptyStr(strAuxil)) Then
        pAddMensagem('Duplics. Creditos.: '+strAuxil);

      strAuxil := fRetornaListaDuplicataQuitadaCredito(dupQuitada);
      If (Not fEmptyStr(strAuxil)) Then
        pAddMensagem('Duplics. Quitadas.: '+strAuxil);
    End;

    {********************************************}
    {* AQUI INICIA MENSAGENS ADICIONAIS FISCAIS *}
    {*****************************************BZ*}
    If fEmptyStr(dadosGerais.strMsgAdicional) Then
    Begin
      {********************************}
      {* MENSAGENS ADICIONAIS FISCAIS *}
      {*****************************FC*}
      If Not fEmptyStr(dadosGerais.strMsgAdicionalFis) Then
      Begin
        stlMensagens.Clear;
        strTexto := AnsiReplaceStr(dadosGerais.strMsgAdicionalFis, '#', sLineBreak);
        strTexto := AnsiReplaceStr(strTexto, '<<csq>>', sLineBreak);
        strTexto := WrapText(strTexto, 255);

        stlMensagens.Text := strTexto;
        intLinha := 500;

        For intContador := 0 To stlMensagens.Count -1 Do
          pAddMensagem;
      End;
    End;

  Finally
    FreeAndNil(stlMensagens);
  End;

  If intLinha < 500 Then
  Begin
    intLinha := 500;
  End;

  If (fAtendeRegrasDifal(dadosGerais.strOpcDoc) And (Not dadosGerais.blnVenPre)) Then
  Begin
    If (fCfgSisFonte(fonteDados, 'SIMPAU') = 'S') And
       (fCfgSisFonte(fonteDados, 'DIFREM') = 'N') And
       (fCfgSisFonte(fonteDados, 'DIFDES') = 'N') Then
    Begin
      pAddMensagem('NÃO APLICA DIFAL DA EMENDA CONSTITUCIONAL 87/2015 – CONFORME ADI N.º 5.464.');
    End
    Else If (fltTotalIcmsInterestadualDestino > 0) Or (fltTotalIcmsInterestadualOrigem > 0) Then
    Begin
      pAddMensagem('Valor do ICMS DIFAL devido a UF de origem: R$' + FloatToStrF(fltTotalIcmsInterestadualOrigem, ffNumber, 12, 2));
      pAddMensagem('Valor do ICMS DIFAL devido a UF de destino: R$' + FloatToStrF(fltTotalIcmsInterestadualDestino, ffNumber, 12, 2));
    End;
  End;

  If fltTotalFCP_189 > 0 Then
    pAddMensagem('BC.FCP R$ '+FloatToStrF(fltTotalBaseFCP_189, ffNumber, 12, 2)+' Aliq.FCP '+FloatToStrF(fltAliqFCP_189, ffNumber, 12, 2)+'% Vr.FCP R$ ' + FloatToStrF(fltTotalFCP_189, ffNumber, 12, 2));
  // Banzato  - Provisorio, aguardar confirmação do André se vai retirar a tag de NFE-PRODUTO-ICMS-UF-DEST quando existir FCP ST
  If fltTotalFCP_192 > 0 Then
    pAddMensagem('BC.FCP.ST R$ '+FloatToStrF(fltTotalBaseFCP_192, ffNumber, 12, 2)+' Aliq.FCP.ST '+FloatToStrF(fltAliqFCP_192, ffNumber, 12, 2)+'% Vr.FCP.ST R$ ' + FloatToStrF(fltTotalFCP_192, ffNumber, 12, 2))
  Else If ((fltTotalFCP > 0) And (fEmptyStr(dadosGerais.strPerfil) Or (dadosGerais.strPerfil = '_SAI_NCO') Or (dadosGerais.strPerfil = '_SAI_CTA'))) Then
    pAddMensagem('BC.FCP.DIFAL R$ '+FloatToStrF(fltTotalBaseFCP, ffNumber, 12, 2)+' Aliq.FCP.DIFAL '+FloatToStrF(fltAliqFCP, ffNumber, 12, 2)+'% Vr.FCP.DIFAL R$ ' + FloatToStrF(fltTotalFCP, ffNumber, 12, 2));

  If (blnIcmsDesonerado) Then
  Begin
    If (dadosGerais.strZonFra = 'S') And (fltTotalBaseIcmsDesonerado > 0) Then
      pAddMensagem(fRetornaMensagemBaseDesonerado(fonteDados, fltTotalBaseIcmsDesonerado));

    If (fltTotalValorIcmsDesonerado > 0) Then
      pAddMensagem('ICMS DESONERADO: R$ ' + FloatToStrF(fltTotalValorIcmsDesonerado, ffNumber, 12, 2));
  end;

  If (fFormataFloat(fltTotalIPIDevolvido, 2) <> 0) Then
    pAddMensagem('Total de IPI Devolvido: ' + FloatToStrF(fltTotalIPIDevolvido, ffNumber, 12, 2));

  If fltBaseRetido > 0 Then
    pAddMensagem('BC.ST Retido R$ '+FloatToStrF(fltBaseRetido, ffNumber, 12, 2)+' Vr.ST Retido R$ ' + FloatToStrF(fltValorRetido, ffNumber, 12, 2));

  If fltBaseEfetivo > 0 Then
    pAddMensagem('BC.Efetivo R$ '+FloatToStrF(fltBaseEfetivo, ffNumber, 12, 2)+' Vr.Efetivo R$ ' + FloatToStrF(fltValorEfetivo, ffNumber, 12, 2));

  If fEhIcmsDesoneradoX40 Then
    pAddMensagem('VALOR DISPENSADO: R$ ' + FloatToStrF(fltTotalValorIcmsDesonerado, ffNumber, 12, 2) +
                 ' MOTIVO DA DESONERAÇÃO DO ICMS: 9' + IIF(dadosEmitente.strEstado = 'SP', ' ICMS ISENTO DE ACORDO COM O ART 66 DO ANEXO I DO DEC 45490/2000 PRORROGADO ATÉ 31/10/2020, CONF. CONV. CONFAZ 133/2019.', ''));

  If (dadosGerais.blnInconsistenciaEFD_Gravar) Then
    pAddMensagem(dadosGerais.strInconsistenciaEFD_InfAdc);
end;

function TNFEFit400.fRetEndToEndIdPixDocumento(const ADadosGerais: TDadosGerais) : TStringList;
  Var
    strEndToEndIdPixRecebimento : {$IF Defined(VER250) Or Defined(UNIDAC)} PWideChar {$ELSE} PAnsiChar {$IFEND};
begin
  Result := TStringList.Create;

  {$IF Defined(VER250) Or Defined(UNIDAC)}
  strEndToEndIdPixRecebimento := PWideChar(ADadosGerais.strEndToEndIdPixRecebimento);
  {$ELSE}
  strEndToEndIdPixRecebimento := PAnsiChar(ADadosGerais.strEndToEndIdPixRecebimento);
  {$IFEND};

  If (Pos(';', ADadosGerais.strEndToEndIdPixRecebimento) > 0) Then
    ExtractStrings([';'], [], strEndToEndIdPixRecebimento, Result)
  Else
  Begin
    If (Not fEmptyStr(ADadosGerais.strEndToEndIdPixRecebimento)) And (Result.IndexOf(ADadosGerais.strEndToEndIdPixRecebimento) < 0) Then
      Result.Add(ADadosGerais.strEndToEndIdPixRecebimento);
  End;

  If (Not fEmptyStr(ADadosGerais.strEndToEndIdPixPedido)) And (Result.IndexOf(ADadosGerais.strEndToEndIdPixPedido) < 0) Then
    Result.Add(ADadosGerais.strEndToEndIdPixPedido);
end;

function TNFEFit400.fRetEndToEndIdPixSemModalidade(const ADadosGerais: TDadosGerais) : TStringList;
  Var
    intCnt : Integer;
    intIndex : Integer;
begin
  Result := fRetEndToEndIdPixDocumento(ADadosGerais);
  For intCnt := Low(ADadosGerais.arrFormasPagamento) To High(ADadosGerais.arrFormasPagamento) Do
  Begin
    If (fEmptyStr(ADadosGerais.arrFormasPagamento[intCnt].strEndToEndIdPix)) Then
      Continue;
    intIndex := Result.IndexOf(ADadosGerais.arrFormasPagamento[intCnt].strEndToEndIdPix);
    If (intIndex >= 0) Then
      Result.Delete(intIndex);
  End;
end;

procedure TNFEFit400.pNFEDadosAdicLivre;
  Var
    strLinha : String;
    strIdNfeFit : String;
begin
  strLinha := '';
  strIdNfeFit := fRetornaIdNfeFit(dadosGerais.strCodEmp,
                                  fNumDocEnvio(dadosGerais.strNumDoc),
                                  dadosGerais.strSerie,
                                  dadosGerais.strEspDoc);

  If (dadosGerais.strOpcDoc = 'CA') And (fCfgSisFonte(fonteDados, 'CPTNFA') = 'S') Then
  Begin
    strLinha := 'NFE-OBSERVACAO|';                                                 //IDENTIFICADOR DA TAG
    strLinha := strLinha + strIdNfeFit + '|';                                      //ID REFERENCIA AUTCOM
    strLinha := strLinha + 'F|';                                                   //F - FISCO
    strLinha := strLinha + '1|';                                                   //NUMERO DO ITEM (1-10)
    strLinha := strLinha + 'NF0200|';                                              //NOME DE IDENTIFICAÇÃO DO CAMPO
    strLinha := strLinha + dadosGerais.strMesAno + '|';                            //CONTEUDO DO CAMPO
  End;

  If (dadosGerais.blnInconsistenciaEFD_Gravar) Then
  Begin
    strLinha := 'NFE-OBSERVACAO|';                                                 //IDENTIFICADOR DA TAG
    strLinha := strLinha + strIdNfeFit + '|';                                      //ID REFERENCIA AUTCOM
    strLinha := strLinha + 'F|';                                                   //F - FISCO
    strLinha := strLinha + '1|';                                                   //NUMERO DO ITEM (1-10)
    strLinha := strLinha + dadosGerais.strInconsistenciaEFD_Identi + '|';          //NOME DE IDENTIFICAÇÃO DO CAMPO
    strLinha := strLinha + dadosGerais.strInconsistenciaEFD_Period + '|';          //CONTEUDO DO CAMPO
  End;

  If (blnInformarTagsObscontXCampoVendedor) Then
  Begin
    strLinha := 'NFE-DADOS-ADIC-LIVRE|';                                           //IDENTIFICADOR DA TAG
    strLinha := strLinha + strIdNfeFit + '|';                                      //ID REFERENCIA AUTCOM
    strLinha := strLinha + 'Vendedor' + '|';                                       //NOME DO VENDEDOR
    strLinha := strLinha + dadosGerais.strCpfVen + '|';                            //CONTEUDO DO CAMPO - CPF VENDEDOR
  End
  Else If (Not fEmptyStr(dadosGerais.strXCampo)) Then
  Begin
    strLinha := 'NFE-DADOS-ADIC-LIVRE|';                                           //IDENTIFICADOR DA TAG
    strLinha := strLinha + strIdNfeFit + '|';                                      //ID REFERENCIA AUTCOM
    strLinha := strLinha + dadosGerais.strXCampo + '|';
    strLinha := strLinha + dadosGerais.strXTexto + '|';
  End;

  If (Not fEmptyStr(strLinha)) Then
    stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFEDuplicata(Var fltFatura: Double);
  Var
    strLinha: String;
    intCont: Integer;
    intNDup : Integer;

    function fRetornaQtdeParcelas: Integer;
    var
      intContador: Integer;
    begin
      Result := 0;

      For intContador := Low(dadosGerais.arrDuplicatas) To High(dadosGerais.arrDuplicatas) Do
      Begin
        If Assigned(dadosGerais.arrDuplicatas[intContador]) Then
        Begin
          If (dadosGerais.arrDuplicatas[intContador].dtaDtaVen = 0) Then
          Begin
            Break;
          End;

          Result := Result + 1;
        End;
      End;
    end;

    function fEhPagamentoAVista: Boolean;
    begin
      Result := False;

      If not Assigned(dadosGerais.arrDuplicatas) Then
        Exit;

      If (fRetornaQtdeParcelas > 1) Then
        Exit;

      If not Assigned(dadosGerais.arrDuplicatas[0]) Then
        Exit;

      If not (dadosGerais.dtaDtaEnt >= dadosGerais.arrDuplicatas[0].dtaDtaVen) Then
        Exit;

      Result := True;
    end;

begin
  fltFatura := 0;
  intNDup := 0;

  If (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_DEVOLUCAO) > 0) Then
    Exit;

  If fEhPagamentoAVista Then
    Exit;

  For intCont := Low(dadosGerais.arrDuplicatas) To High(dadosGerais.arrDuplicatas) Do
  Begin
    If Assigned(dadosGerais.arrDuplicatas[intCont]) Then
    Begin
      If (dadosGerais.arrDuplicatas[intCont].dtaDtaVen = 0) Then
      Begin
        Break;
      End;

      Inc(intNDup);

      strLinha := '';
      strLinha := strLinha + 'NFE-DUPLICATA|';                                                 // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                    // 02 - ID Referência
      strLinha := strLinha + fStrZero(intNDup, 3) + '|';                                       // 03 - Número da Duplicata

      If (DateOf(nOw()) > dadosGerais.arrDuplicatas[intCont].dtaDtaVen) Then
        strLinha := strLinha + fData(DateOf(nOw())) + '|'                                      // 04 - Data de Vencimento
      Else
        strLinha := strLinha + fData(dadosGerais.arrDuplicatas[intCont].dtaDtaVen) + '|';      // 04 - Data de Vencimento

      strLinha := strLinha + fValor(dadosGerais.arrDuplicatas[intCont].fltValDup, 15, 2) + '|';// 05 - Valor da Duplicata
      fltFatura := fltFatura + fFormataFloat(dadosGerais.arrDuplicatas[intCont].fltValDup, 2);

      stlArquivo.Add(strLinha);
    End;
  End;
end;

function TNFEFit400.fRetornaListaDuplicataQuitadaCredito(tLisDup: TListaDuplicata): String;
  Var
    intCont: Integer;
    intNDup : Integer;

    function fStrDup: String;
    begin
      Result := fStrZero(intNDup, 3) + '-'+ 
                FormatDateTime('dd/mm/yyyy', dadosGerais.arrDuplicatas[intCont].dtaDtaVen) + '-R$' +
                FloatToStrF(dadosGerais.arrDuplicatas[intCont].fltValDup, ffNumber, 12, 2);
    end;
    
begin
  Result := '';
  intNDup := 0;
  
  If (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_DEVOLUCAO) > 0) Then
    Exit;

  For intCont := Low(dadosGerais.arrDuplicatas) To High(dadosGerais.arrDuplicatas) Do
  Begin
    If Assigned(dadosGerais.arrDuplicatas[intCont]) Then
    Begin
      If (dadosGerais.arrDuplicatas[intCont].dtaDtaVen = 0) Then
      Begin
        Break;
      End;

      Inc(intNDup);

      If (tLisDup=dupCredito) Then
      Begin
        If (RightStr(dadosGerais.arrDuplicatas[intCont].strNumDup, 3) = consCredito) Then
          Result := Result + IIF(fEmptyStr(Result),'',' / ') + fStrDup 
      End    
      Else
      Begin
        If (RightStr(dadosGerais.arrDuplicatas[intCont].strNumDup, 2) = consQuitada) Then
          Result := Result + IIF(fEmptyStr(Result),'',' / ') + fStrDup 
      End; 
    End;
  End;
end;

procedure TNFEFit400.pNFEECFReferenciado;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin

  If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
    Exit;

  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If docRef.strTipoChave = DOCUMENTO_REF_ECF Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-REF-ECF|';                                                 // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência
      strLinha := strLinha + docRef.strModeloDocFiscalIF + '|';                              // 03 - Modelo
      strLinha := strLinha + fStrZero(docRef.strNumOrdSequencialECF, 3) + '|';               // 04 - Numero ECF
      strLinha := strLinha + RightStr(docRef.strNumeroCOO,6) + '|';                                      // 05 - Numero COO

      stlArquivo.Add(strLinha);
    End;
  End;

end;

procedure TNFEFit400.pNFEEDadosExportacao;
  Var
    strLinha: String;
begin
    If fEmptyStr(dadosGerais.strUFEmba) Then
      Exit ;

    strLinha := '';
    strLinha := strLinha + 'NFE-EXPORT|';                                                        // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                            dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';  // 002 - ID Referência
    strLinha := strLinha + dadosGerais.strUFEmba + '|';                                          // 003 - UF Embarque ou de transposição de fronteira
    strLinha := strLinha + dadosGerais.strLoEmba + '|';                                          // 004 - Local de Embarque ou de transposição de fronteira
    strLinha := strLinha + dadosGerais.strLocDes + '|';                                          // 005 - Descrição do local de despacho - Informação do Recinto Alfandegado

    stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFEEletronicaReferenciada;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    stlChavesInformadas: TStrings;

    function fEnviaNFEEletronicaReferenciada: Boolean;
    begin
      Result := True ;

      If (dadosGerais.strFinalidade = '4') Then
      Begin
        If not dadosGerais.blnDesativaDfeReferenciado Then
          Result := False;

        Exit;
      End;

      If (dadosGerais.strFinalidade = '6') Then
      Begin
        Result := False;
        Exit;
      End;

      If (dadosGerais.strFinalidade = '5') And (dadosGerais.strTipoCredito = '06') Then
      Begin
        Result := False;
        Exit;
      End;
      {********************************************************************************}
      {* ESSE TRECHO FOI FEITO PARA ATENDER VERSÕES QUE NÃO TEM O CAMPO DE FINALIDADE *}
      {*****************************************************************************BZ*}
      If fEmptyStr(dadosGerais.strFinalidade) And (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
      begin
        If not dadosGerais.blnDesativaDfeReferenciado Then
          Result := False;

        Exit;
      end;
    end;

begin

  If not fEnviaNFEEletronicaReferenciada Then
    Exit;

  stlChavesInformadas := TStringList.Create;
  Try
    For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
    Begin
      docRef := dadosGerais.arrChavesReferenciadas[intIndice];

      If (docRef.strTipoChave = DOCUMENTO_REF_NFe_Modelo_55) Or
         (docRef.strTipoChave = DOCUMENTO_REF_NFCE) Then
        pAdicionarChaveReferenciadaNFE(stlChavesInformadas, docRef.strChaveAcessoNfe);
    End;

    If (dadosGerais.blnInconsistenciaEFD_Gravar) And (Not fEmptyStr(dadosGerais.strInconsistenciaEFD_RefNfe)) Then
      pAdicionarChaveReferenciadaNFE(stlChavesInformadas, dadosGerais.strInconsistenciaEFD_RefNfe);

    For intIndice := Low(dadosGerais.arrChaveNFRefExportacao) To High(dadosGerais.arrChaveNFRefExportacao) Do
      pAdicionarChaveReferenciadaNFE(stlChavesInformadas, dadosGerais.arrChaveNFRefExportacao[intIndice]);
  Finally
    FreeAndNil(stlChavesInformadas);
  End;
end;

procedure TNFEFit400.pNFEEmailCliente;
  Var
    strLinha: String;
    intContador: Integer;
begin
  For intContador := 0 To stlEmails.Count -1 Do Begin
    If (Not fEmptyStr(stlEmails[intContador])) Then Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-EMAIL|';                                                                         // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                            dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                  // 002 - ID Referência
      strLinha := strLinha + LeftStr(Trim(stlEmails[intContador]), 255) + '|';                                     // 003 - Email Cliente
      strLinha := strLinha + 'S|';                                                                                 // 004 - Enviar XML

      If (fCfgSisFonte(fonteDados, 'QNEENT') = 'X') Then
        strLinha := strLinha + 'N|'                                                                                  // 005 - Enviar PDF Danfe
      Else
        strLinha := strLinha + 'S|';

      stlArquivo.Add(strLinha);
    End;
  End;

  For intContador := 0 To stlEmailsTra.Count -1 Do Begin
    If (Not fEmptyStr(stlEmailsTra[intContador])) Then Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-EMAIL|';                                                                         // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                            dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                  // 002 - ID Referência
      strLinha := strLinha + LeftStr(Trim(stlEmailsTra[intContador]), 255) + '|';                                     // 003 - Email Cliente
      strLinha := strLinha + 'S|';                                                                                 // 004 - Enviar XML

      If (fCfgSisFonte(fonteDados, 'QNEENT') = 'X') Then
        strLinha := strLinha + 'N|'                                                                                  // 005 - Enviar PDF Danfe
      Else
        strLinha := strLinha + 'S|';

      stlArquivo.Add(strLinha);
    End;
  End;

  For intContador := 0 To stlEmailsTraRed.Count -1 Do Begin
    If (Not fEmptyStr(stlEmailsTraRed[intContador])) Then Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-EMAIL|';                                                                         // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                            dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                  // 002 - ID Referência
      strLinha := strLinha + LeftStr(Trim(stlEmailsTraRed[intContador]), 255) + '|';                                     // 003 - Email Cliente
      strLinha := strLinha + 'S|';                                                                                 // 004 - Enviar XML
      strLinha := strLinha + 'S|';                                                                                 // 005 - Enviar PDF Danfe

      stlArquivo.Add(strLinha);
    End;
  End;
end;

function TNFEFit400.fUsaTag_NFE_RETIRA: Boolean;
begin
  Result := False;

  If (dadosGerais.strClaFis > '5000') Then
    Exit;

  If not (fLocalDestinoOperacao = '1') Then
    Exit;

  If (fIndicadorConsumidorFinal = '1') Then
    Exit;

  If fUsarEnderecoDeEntregaComoEnderecoPrincipal Then
    Exit;

  If (dadosGerais.strEstado = dadosEmitente.strEstado) Then
    Exit;

  Result := True;
end;

function TNFEFit400.fRetTag_NFE_RETIRA_NFE_ENTREGA: String;
begin
  Result := 'NFE-ENTREGA|';

  If fUsaTag_NFE_RETIRA Then
  Begin
    Result := 'NFE-RETIRA|';
    Exit;
  End;

  If Not dadosGerais.blnVenPre Then
    Exit;

  If StrToIntDef(LeftStr(dadosGerais.strClaFis, 1), 0) < 6 Then
    Exit;

  If fEmptyStr(fCfgSisFonte(fonteDados, 'TAGEND')) Then
    Exit;

  Result := fCfgSisFonte(fonteDados, 'TAGEND')+'|';
end;

procedure TNFEFit400.pNFEEntrega;
  Var
    strLinha : String;
    strTagEntrega : String;
begin
  If fEmptyStr(dadosGerais.strLogradouroEndEnt) Then
  Begin
    Exit;
  End;

  If Not dadosGerais.blnEnviaEnderecoDeEntrega Then
    Exit;

  strLinha := '';
  strTagEntrega := fRetTag_NFE_RETIRA_NFE_ENTREGA;
  strLinha := strLinha + strTagEntrega;                                                  // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência

  If IIF(fonteDados.fCampoExiste('AUXMOV', 'AUX_ENTGER'),
                                (dadosGerais.blnVenPre And fEmptyStr(dadosGerais.strAuxEntGer)) Or
                                ((fCfgSisFonte(fonteDados, 'NFREND') = 'S') And (not dadosGerais.blnEntFat) And
                                  fEmptyStr(dadosGerais.strAuxEntGer) And (fCfgSisFonte(fonteDados, 'ENDRET') = 'N')) Or
                                (dadosGerais.blnVenPre And (Not fEmptyStr(dadosGerais.strAuxEntGer)) And
                                (dadosGerais.strUfIbgeEntrega <> dadosEmitente.strUfIbge)), dadosGerais.blnVenPre) Then
  Begin
    strLinha := strLinha + dadosEmitente.strCnpj + '|';                                    // 03 - CNPJ/CPF
    strLinha := strLinha + Trim(LeftStr(dadosEmitente.strEndereco, 60)) + '|';             // 04 - Logradouro
    strLinha := strLinha + dadosEmitente.strNumeroEnd + '|';                               // 05 - Número
    strLinha := strLinha + LeftStr(dadosEmitente.strComplementoEnd, 60) + '|';             // 06 - Complemento
    strLinha := strLinha + dadosEmitente.strBairro + '|';                                  // 07 - Bairro
    strLinha := strLinha + dadosEmitente.strCodIbge + '|';                                 // 08 - Código IBGE do Município
    strLinha := strLinha + '|';                                                            // 09 - Razão Social ou Nome do Expedidor
    strLinha := strLinha + dadosEmitente.strCep + '|';                                     // 10 - CEP
    strLinha := strLinha + dadosEmitente.strCodigoPais  + '|';                             // 11 - Código do País
    strLinha := strLinha + dadosEmitente.strNomePais + '|';                                // 12 - Nome do País
    strLinha := strLinha + dadosEmitente.strTelefone + '|';                                // 13 - Telefone
    strLinha := strLinha + '|';                                                            // 14 - Endereço de email do Expedidor
    strLinha := strLinha + dadosEmitente.strIES + '|';                                     // 15 - Inscrição Estadual
  End
  Else
  Begin
    If (fDocumentoSeraEmitidoComTagEntrega(strTagEntrega)) And (Not fEmptyStr(dadosGerais.strCNPJEndEnt)) Then
      strLinha := strLinha + dadosGerais.strCNPJEndEnt + '|'                               // 03 - CNPJ/CPF
    Else
      strLinha := strLinha + '|';                                                          // 03 - CNPJ/CPF

    strLinha := strLinha + Trim(LeftStr(dadosGerais.strLogradouroEndEnt, 60)) + '|';       // 04 - Logradouro
    strLinha := strLinha + dadosGerais.strNumeroEndEnt + '|';                              // 05 - Número
    strLinha := strLinha + LeftStr(dadosGerais.strComplementoEndEnt, 60) + '|';            // 06 - Complemento
    strLinha := strLinha + dadosGerais.strBairroEndEnt + '|';                              // 07 - Bairro
    strLinha := strLinha + dadosGerais.strCodIbgeEntrega + '|';                            // 08 - Código IBGE do Município
    strLinha := strLinha + '|';                                                            // 09 - Razão Social ou Nome do Expedidor
    strLinha := strLinha + dadosGerais.strCEPEndEnt + '|';                                 // 10 - CEP
    strLinha := strLinha + dadosGerais.strPaisEndEnt  + '|';                               // 11 - Código do País
    strLinha := strLinha + fRetNomePais(fonteDados, dadosGerais.strPaisEndEnt) + '|';      // 12 - Nome do País
    strLinha := strLinha + dadosGerais.strFoneEndEnt + '|';                                // 13 - Telefone
    strLinha := strLinha + '|';                                                            // 14 - Endereço de email do Expedidor

    If (fDocumentoSeraEmitidoComTagEntrega(strTagEntrega)) And (Not fEmptyStr(dadosGerais.strIESEndEnt)) Then
      strLinha := strLinha + dadosGerais.strIESEndEnt + '|'                                // 15 - Inscrição Estadual
    Else
      strLinha := strLinha + '|';                                                          // 15 - Inscrição Estadual
  End;

  stlArquivo.Add(strLinha);
end;


procedure TNFEFit400.pNFEFatura(fltFatura: Double);
  Var
    strLinha : String;
begin
  If (fFormataFloat(fltFatura, 2) <> 0) Then
  Begin
    strLinha := '';
    strLinha := strLinha + 'NFE-FATURA|';                                                     // 01 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                     // 02 - ID Referência
    strLinha := strLinha + dadosGerais.strNumDoc   + '|';                                     // 03 - Número da Fatura
    strLinha := strLinha + fValor(fltFatura, 15, 2) + '|';                                    // 04 - Valor Original
    strLinha := strLinha + fValor(0.00,      15, 2) + '|';                                    // 05 - Valor Desconto
    strLinha := strLinha + fValor(fltFatura, 15, 2) + '|';                                    // 06 - Valor Liquido
    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400.pNFEGrupoExportacao;
var
  item: TDadosItem;
  intContador: integer;
  strLinha: string;
begin
  for intContador := 0 to lstItens.Count - 1 do
  begin
    item := TDadosItem(lstItens[intContador]);

    if (not fEmptyStr(item.strChaveAcesso)) or (not fEmptyStr(item.strNumDrw)) then
    begin
      strLinha := '';
      strLinha := strLinha + 'NFE-GRUPO-EXPORTACAO|';
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';
      strLinha := strLinha + IntToStr(intContador+1) + '|';
      strLinha := strLinha + IIF(not fEmptyStr(item.strNumDrw), item.strNumDrw, dadosGerais.strNumeroDrawback) + '|';

      if fEmptyStr(item.strChaveAcesso) then
        strLinha := strLinha + '|||'
      else
      begin
        strLinha := strLinha + '0|';
        strLinha := strLinha + item.strChaveAcesso + '|';
        strLinha := strLinha + fValor(item.fltQtItCo, 11, 4) + '|';
      end;

      stlArquivo.Add(strLinha);
    end;
  end;
end;

procedure TNFEFit400.pNFEHeader;
begin
  stlArquivo.Add('HEADER|4.00');
end;

procedure TNFEFit400.pNFEMedicamentos;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If Not item.blnMedicamento Then
      Continue;

    strLinha := '';
    strLinha := strLinha + 'NFE-MEDIC|';
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';
    strLinha := strLinha + IntToStr(intContador +1) + '|'; //Número do Item
    strLinha := strLinha + '|';                            //Campo não utilizado. Enviar em branco
    strLinha := strLinha + '|';                            //Campo não utilizado. Enviar em branco
    strLinha := strLinha + '|';                            //Campo não utilizado. Enviar em branco
    strLinha := strLinha + '|';                            //Campo não utilizado. Enviar em branco
    strLinha := strLinha + '0|';                           //Preço Máximo ao Consumidor
    strLinha := strLinha + item.strCodPrdAnvisa + '|';     //Código de Produto da ANVISA
    strLinha := strLinha + item.strMotIseAnvisa + '|';     //Motivo da isenção da ANVISA
    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400.pNFERastreabilidade;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
    dtaFabLot, dtaValLot: TDateTime;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If Not item.blnRastreavel Then
      Continue;

    strLinha := '';
    strLinha := strLinha + 'NFE-RASTREABILIDADE|';
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';
    strLinha := strLinha + IntToStr(intContador +1) + '|';    //Número do Item
    strLinha := strLinha + item.strNumLot + '|';              //Número do Lote
    strLinha := strLinha + fValor(item.fltQtdIte,8,3) + '|';  //Quantidade de Produto no Lote

    dtaFabLot := StrToDateDef(item.strFabLot, 0);
    If dtaFabLot > 0 Then
      strLinha := strLinha + fData(dtaFabLot) + '|'           //Data de Fabricação
    Else
      strLinha := strLinha + '|';

    dtaValLot := StrToDateDef(item.strValLot, 0);
    If dtaValLot > 0 Then
      strLinha := strLinha + fData(dtaValLot) + '|'           //Data de Validade
    Else
      strLinha := strLinha + '|';

    strLinha := strLinha + '|';                               //Código de Agregação
    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400.pNFEModelo1AReferenciado;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin

  If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
    Exit;

  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If docRef.strTipoChave = DOCUMENTO_REF_NF_Modelo_1_1A Then
    Begin
      If not fEmptyStr(docRef.strDocumentoFiscal) Then
      Begin
        strLinha := '';
        strLinha := strLinha + 'NFE-REF|';                                                    // 01 - Tipo do Registro
        strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
          dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência
        strLinha := strLinha + docRef.strUfIbgeEmitente + '|';                                 // 03 - UF
        strLinha := strLinha + docRef.strAnoMesEmissao + '|';                                  // 04 - Ano / Mês
        strLinha := strLinha + fTiraCaracEspeciaisPonto(docRef.strCnpjEmitente) + '|';               // 05 - CNPJ Emitente
        strLinha := strLinha + docRef.strModeloDocFiscalNF + '|';                              // 06 - Modelo Documento
        strLinha := strLinha + docRef.strSerieFiscal + '|';                                    // 07 - Série
        strLinha := strLinha + fNumDocEnvio(docRef.strDocumentoFiscal) + '|';                  // 08 - Numero documento

        stlArquivo.Add(strLinha);
      End;
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoCOFINS;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If Not fEmptyStr(item.strCstCof) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-COFINS|';                                        // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                 // 003 - Nr.Item

      If Pos(item.strCstCof, '01, 02') > 0 Then
      Begin
        strLinha := strLinha + item.strCstCof + '|';                                        // 004 - Código de Situação Tributária do COFINS
        strLinha := strLinha + fValor(item.fltBasCof, 15, 2) + '|';                         // 005 - Valor da Base de Cálculo do COFINS
        strLinha := strLinha + fValor(item.fltAlqCof, 7, 4) + '|';                          // 006 - Alíquota do COFINS (em percentual)
        strLinha := strLinha + fValor(item.fltValCof, 15, 2) + '|';                         // 007 - Valor do COFINS
      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 4); // 004 - 007 - COFINS CST 01, 02
      End;

      If Pos(item.strCstCof,'03') > 0 Then                           //PIS Tributado por Quantidade = CST 03
      Begin
        strLinha := strLinha + item.strCstCof   + '|';
        strLinha := strLinha + fValor(0, 15, 4) + '|';
        strLinha := strLinha + fValor(0, 7, 4)  + '|';
        strLinha := strLinha + fValor(0,15, 2)  + '|';
      End
      Else
        strLinha := strLinha + fReplicatorStr('|', 4);                                        // 008 - 011 - COFINS CST 03

      If Pos(item.strCstCof, '04,05,06,07,08,09') > 0 Then
      Begin
        strLinha := strLinha + item.strCstCof + '|';                                        // 012 - Código de Situação Tributária do COFINS
      End
      Else
      Begin
        strLinha := strLinha + '|';                                                         // 012 - Código de Situação Tributária do COFINS
      End;

      If Pos(item.strCstCof, '49,50,51,52,53,54,55,56,60,61,62,63,64,65,66,67,70,71,72,73,74,75,98,99') > 0 Then
      Begin
        strLinha := strLinha + item.strCstCof + '|';                                        // 013 - Código de Situação Tributária do COFINS
        strLinha := strLinha + fValor(item.fltBasCof, 15, 2) + '|';                         // 014 - Valor da Base de Cálculo do COFINS
        strLinha := strLinha + fValor(item.fltAlqCof, 7, 4) + '|';                          // 015 - Alíquota do COFINS (em percentual)
        strLinha := strLinha + '|';                                                         // 016 - Quantidade Vendida
        strLinha := strLinha + '|';                                                         // 017 - Alíquota do COFINS (em reais)
        strLinha := strLinha + fValor(item.fltValCof, 15, 2) + '|';                         // 018 - Valor do COFINS
      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 6); // 013 - 018 - COFINS CST OUTRAS
      End;

      strLinha := strLinha + fReplicatorStr('|', 5);                                        // 019 - 023 - COFINS SUSBSTITUIÇÃO TRIBUTÁRIA

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoCombustiveis;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If Pos(item.strClaFis, CFOP_COMBUSTIVEL) > 0 Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-COMB|';                                                        // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                      // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                      // 003 - Nr.Item
      strLinha := strLinha + IIF(fEmptyStr(item.strCodLub), '999999999', item.strCodLub) + '|';  // 004 - Código do Produto na ANP
      strLinha := strLinha + '|';                                                                // 005 - Percentual de Gás Natural para o produto GLP (cProdANP=210203001)
      strLinha := strLinha + '|';                                                                // 006 - Código autorização CODIF
      strLinha := strLinha + '|';                                                                // 007 - Quantidade de combustível faturada à temperatura ambiente.
      strLinha := strLinha + '|';                                                                // 008 - Base Calculo da CIDE em quantidade
      strLinha := strLinha + '|';                                                                // 009 - Valor Alíquota CIDE
      strLinha := strLinha + '|';                                                                // 010 - Valor da CIDE
      strLinha := strLinha + dadosGerais.strEstado + '|';                                        // 011 - UF Consumo
      strLinha := strLinha + '|';                                                                // 012	- Número de identificação do bico utilizado no abastecimento
      strLinha := strLinha + '|';                                                                // 013	- Número de identificação da bomba ao qual o bico está interligado
      strLinha := strLinha + '|';                                                                // 014	- Número de identificação do tanque ao qual o bico está interligado
      strLinha := strLinha + '|';                                                                // 015	- Valor do Encerrante no início do abastecimento
      strLinha := strLinha + '|';                                                                // 016	- Valor do Encerrante no final do abastecimento

      strLinha := strLinha + item.strDesANP + '|';                                               // 017	- Descrição do produto conforme ANP - (obrigatório)
                                                                                                 // Utilizar a descrição de produtos do Sistema de
                                                                                                 // Informações de Movimentação de Produtos - SIMP

      strLinha := strLinha + '|';                                                                // 018	- Percentual do GLP derivado do petróleo no produto GLP (cProdANP=210203001)
      strLinha := strLinha + '|';                                                                // 019	- Percentual de Gás Natural Nacional – GLGNn para o produto GLP (cProdANP=210203001)
      strLinha := strLinha + '|';                                                                // 020	- Percentual de Gás Natural Importado – GLGNi para o produto GLP (cProdANP=210203001)
      strLinha := strLinha + '|';                                                                // 021	- Valor de partida (cProdANP=210203001)


      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoDeclaracaoImportacao;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If Assigned(item.documentoImportacao) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-DI|';                                                     // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                  // 003 - Nr.Item
      strLinha := strLinha + item.documentoImportacao.strNumeroDi + '|';                     // 004 - Número do Documento de Importação
      strLinha := strLinha + fData(item.documentoImportacao.dtaDataDi) + '|';                // 005 - Data de Registro (DI/DSI/DA)
      strLinha := strLinha + item.documentoImportacao.strLocalizacaoDesembaracao + '|';      // 006 - Local de Desembaraço
      strLinha := strLinha + item.documentoImportacao.strUFDesembaraco + '|';                // 007 - UF Desembaraço Aduaneiro
      strLinha := strLinha + fData(item.documentoImportacao.dtaDataDesembaraco) + '|';       // 008 - Data do Desembaraço Aduaneiro
      strLinha := strLinha + IntToStr(item.documentoImportacao.intViaTransporte) + '|';      // 009 - Via de transporte internacional informada na Declaração de Importação (DI)
      strLinha := strLinha + IfThen(item.documentoImportacao.intViaTransporte=1,
                                    fValor(item.documentoImportacao.fltValorAFRMM, 13, 2),
                                    '') + '|';                                               // 010 - Valor da AFRMM – Adicional ao Frete para Renovação da Marinha Mercante
      strLinha := strLinha + IntToStr(item.documentoImportacao.intFormaIntermediacao) + '|'; // 011 - Forma de importação quanto a intermediação
      strLinha := strLinha + item.documentoImportacao.strCNPJAdquirente + '|';               // 012 - CNPJ do adquirente ou do encomendante
      strLinha := strLinha + item.documentoImportacao.strUFAdquirente + '|';                 // 013 - Sigla da UF do adquirente ou do encomendante
      strLinha := strLinha + dadosGerais.strCodCli + '|';                                    // 014 - Código do Exportador

      stlArquivo.Add(strLinha);
    End;
  End;

end;

procedure TNFEFit400.pNFEProdutoAdicoes;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
    strIdRef: String;
begin
 strIdRef := fRetornaIdNfeFit(dadosGerais.strCodEmp,
    fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);
    If Assigned(item.documentoImportacao) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-ADIC'               + '|'; // 001 - Tipo do Registro
      strLinha := strLinha + strIdRef                 + '|'; // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1)  + '|'; // 003 - Nr.Item
      If (item.documentoImportacao.intAdicao <> 0) Then  //Informado, senão repassa 1 padrão
        strLinha := strLinha + IntToStr(item.documentoImportacao.intAdicao) + '|' // 004 - Número da Adição (Se foi digitado)
      Else
        strLinha := strLinha + '1'                     + '|'; // 004 - Número da Adição (Se não foi digitado)
      strLinha := strLinha + '1'                      + '|'; // 005 - Número Seqüencial do item dentro da adição
      strLinha := strLinha + item.strCodFab           + '|'; // 006 - Código do fabricante estrangeiro usado nos sistemas internos de informação do emitente de NF-e
      strLinha := strLinha + ''                       + '|'; // 007 - Valor do Desconto do Item da DI – Adição

      If (Not fEmptyStr(item.strNumDrw)) Then
        strLinha := strLinha + item.strNumDrw + '|' // 008 - Número do ato concessório de Drawback
      Else
        strLinha := strLinha + dadosGerais.strNumeroDrawback + '|'; // 008 - Número do ato concessório de Drawback

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoICMSUFDestino;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
    fltBaseDestino: Double;
    fltDifAliquota: Double;
    fltIcmsDifAliquota: Double;

    fltIcmsDestino: Double;
    fltIcmsOrigem: Double;

    fltBaseInterestadual: Double;
    fltIcmsTotalOrigem: Double;
    fltIcmsTotalDestino: Double;
    fltIcmsTotalDiferenca: Double;
    fltAlqInterestadualCalc: Double;
    fltBaseIcmsItem: Double;
    blnCalcularDifalProdutoST: Boolean;
    blnProdutoST: Boolean;
    fltAliquotaInternaDestino: Double;
    fltAliquotaInterestadualGerar: Double;
    fltPercentualPartilha: Double;
    fltPercentualFCP: Double;
    fltValorFCP: Double;
    fltBaseFCP: Double;

    fltPeBaDf: Double;

    fltPerBasDifalOrigem: Double;
    fltPerBasDifalDestino: Double;

    fltIcmsDifalOrigem  :Double;
    fltIcmsDifalDestino :Double;

    blnExisteMovIcd: Boolean;

//    fltValorIcmsCargaDestino: Double;
//    fltValorIcmsInterno: Double;

    //ESTADOS QUE ALTERARAM A ALÍQUOTA PARA 18% E AS RESPECTIVAS DATAS DE INÍCIO DE EFEITO
    {AP - 01/02/2016 << atenção, fevereiro!
    AM - 08/01/2016
    DF - 01/01/2016
    MA - 01/01/2016
    PB - 01/01/2016
    PE - 18% de 01/01/2016 até 31/12/2019, a partir de 01/01/2020 = 17%
    RN - 01/01/2016
    RS - 01/01/2016
    SE - 01/01/2016
    TO - 01/01/2016}

    function fRetAliquotaInternaEstadoDestino: Double;
    begin
{      If fonteDados.fDadosGerais.strEstado = 'RJ' Then
        Result := 19
      Else If Pos(fonteDados.fDadosGerais.strEstado, 'AM_DF_MA_PB_PE_RN_RS_SE_TO_MG_PR_SP_') > 0 Then
        Result := 18
      Else If (fonteDados.fDadosGerais.strEstado = 'AP') And (fonteDados.fDadosGerais.dtaDtaEnt >= EncodeDate(2016, 2, 1)) Then
        Result := 18
      Else
        Result := 17;}
      If Pos(fonteDados.fDadosGerais.strEstado, 'AM_DF_MA_PB_PE_RN_RS_SE_TO_MG_PR_SP_RJ_CE_PI_') > 0 Then
        Result := 18
      Else If (fonteDados.fDadosGerais.strEstado = 'AP') And (fonteDados.fDadosGerais.dtaDtaEnt >= EncodeDate(2016, 2, 1)) Then
        Result := 18
      Else If (fonteDados.fDadosGerais.strEstado = 'BA') And (fonteDados.fDadosGerais.dtaDtaEnt >= EncodeDate(2016, 3, 10)) Then
        Result := 18
      Else If (fonteDados.fDadosGerais.strEstado = 'RO') Then
        Result := 17.5
      Else
        Result := 17;
    end;

    function fRetAliquotaFCP: Double;
    begin
      Result := 0;
      If fonteDados.fDadosGerais.strEstado = 'RJ' Then
        Result := 2
      Else If Pos(fonteDados.fDadosGerais.strEstado, 'AL_') > 0 Then
        Result := 1;
    end;

    function fPercentualProvisorioPartilha: Double;
      Var
        wrdAno: Word;
    begin
      wrdAno := YearOf(fonteDados.fDadosGerais.dtaDtaEnt);
      Case wrdAno Of
        2015: Result := 20;
        2016: Result := 40;
        2017: Result := 60;
        2018: Result := 80;
        Else Result := 100;
      End;
    end;

    function fCalculaAliquotaInterestadual: Double;
    begin
      If Pos(LeftStr(item.strCodSit, 1), '1,2,3,8') > 0 Then
      Begin
        Result := 4;
      End
      Else If (Pos(dadosEmitente.strEstado, 'RS,SC,SP,MG,RJ,PR') > 0) And
              (Pos(dadosGerais.strEstado, 'RS,SC,SP,MG,RJ,PR') <= 0) Then
      Begin
        Result := 7;
      End
      Else
      Begin
        Result := 12;
      End;
    End;

  function fExisteRegistroTabela(arrNomeTabela: Array Of String;
    arrParametros: Array Of String; arrValores: Array Of Variant): Boolean;
    Var
      intIndTab,
      intIndPar: Integer;
      strSQL  : String;
      qryAux  : TDataSet;
  begin
    Result := False;

    intIndTab := 0;

    While (intIndTab <= High(arrNomeTabela)) Do
    Begin
      If fonteDados.fTabelaExiste(arrNomeTabela[intIndTab]) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + arrNomeTabela[intIndTab];
        strSQL := strSQL + ' WHERE ';

        intIndPar := 0;

        While (intIndPar <= High(arrParametros)) Do
        Begin
          strSQL := strSQL + arrParametros[intIndPar] + ' = :' + arrParametros[intIndPar] + IIF(intIndPar = High(arrParametros), ' ', ' AND ');
          Inc(intIndPar);
        End;

        qryAux := fonteDados.fExecutaQuery(strSQL, arrParametros, arrValores);

        With qryAux Do
        Begin
          If Not IsEmpty Then
            Result := FieldByName('QTD').AsInteger > 0;
        End;

        FreeAndNil(qryAux);
      End;

      If Result Then
        Break;

      Inc(intIndTab);
    End;
  end;

  function fTemRegistroDifalFcpComplementoValor(strAutInc: String): Boolean;
    Var
      strSQL : String;
      qryAux : TDataSet;
  begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ICD_SEQITE ';
    strSQL := strSQL + '   FROM COMICD ';
    strSQL := strSQL + '  WHERE ICD_SEQITE = :AUTINC ';
    qryAux := fonteDados.fExecutaQuery(strSQL, ['AUTINC'], [strAutInc]);
    Result := (Not qryAux.IsEmpty);
    FreeAndNil(qryAux);
  end;

  function fEhComplementoDeValorETemRegistrosDifalFcp(lstDados: TObjectList): Boolean;
    Var
      strSQL : String;
      qryAux : TDataSet;
      intCnt : Integer;
      strInc : String;
  begin
    Result := (fSuportaOperacaoBanco(fonteDados)) And (fonteDados.fDadosGerais.blnComplementoValor Or fonteDados.fDadosGerais.blnComplementoDifal) And
              (fonteDados.fTabelaExiste('COMICD'));

    If (Result) Then
    Begin
      strInc := '';
      For intCnt := 0 To lstItens.Count -1 Do
      Begin
        If (Not fEmptyStr(TDadosItem(lstItens[intCnt]).strAutInc)) Then
        Begin
          If fEmptyStr(strInc) Then
            strInc := QuotedStr(TDadosItem(lstItens[intCnt]).strAutInc)
          Else
            strInc := strInc + ', ' + QuotedStr(TDadosItem(lstItens[intCnt]).strAutInc);
        End;
      End;

      If fEmptyStr(strInc) Then
        Result := False
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT COUNT(*) CNT ';
        strSQL := strSQL + '   FROM COMICD ';
        strSQL := strSQL + '  WHERE :BOOL ';
        strSQL := strSQL + '    AND ICD_SEQITE IN (' + strInc + ') ';
        qryAux := fonteDados.fExecutaQuery(strSQL, ['BOOL'], [True]);
        Result := (qryAux.FieldByName('CNT').AsInteger > 0);
        qryAux.Close;
        FreeAndNil(qryAux);
      End;
    End;
  end;

  procedure pGravaRegistros;
    Var
      strTabela: String;
  Begin
    if (fltIcmsOrigem < 0) then
      fltIcmsOrigem := 0;

    if (fltIcmsDestino < 0) then
      fltIcmsDestino := 0;

    fltTotalIcmsInterestadualDestino := fltTotalIcmsInterestadualDestino + fltIcmsDestino;
    fltTotalIcmsInterestadualOrigem := fltTotalIcmsInterestadualOrigem + fltIcmsOrigem;

    fltAliqFCP := fltPercentualFCP;
    fltTotalFCP := fltTotalFCP + fltValorFCP;
    fltTotalBaseFCP := fltTotalBaseFCP + fltBaseFCP;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-ICMS-UF-DEST|';                                   // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                 // 003 - Nr.Item
    strLinha := strLinha + fValor(fltBaseDestino, 15, 2) + '|';                           // 004 - Valor da Base ICMS UF Dest.
    strLinha := strLinha + fValor(fltPercentualFCP, 7, 4) + '|';                          // 005 - Perc. ICMS Fundo Combate Pobreza Dest.

    //fRetAliquotaInternaEstadoDestino
    if (fFormataFloat(fltAliquotaInternaDestino, 2) = 0) and (dadosGerais.blnComplementoValor Or dadosGerais.blnComplementoDifal) then
      strLinha := strLinha + fValor(fRetAliquotaInternaEstadoDestino, 7, 4) + '|'         // 006 - Perc. ICMS Interna UF Dest.
    else
      strLinha := strLinha + fValor(fltAliquotaInternaDestino, 7, 4) + '|';               // 006 - Perc. ICMS Interna UF Dest.

    if ((fFormataFloat(fltAliquotaInterestadualGerar, 2) = 0)) and (dadosGerais.blnComplementoValor Or dadosGerais.blnComplementoDifal) then
      strLinha := strLinha + fValor(fCalculaAliquotaInterestadual, 7, 4) + '|'            // 007 - Perc. ICMS Interestadual
    else
      strLinha := strLinha + fValor(fltAliquotaInterestadualGerar, 7, 4) + '|';           // 007 - Perc. ICMS Interestadual

    if (fFormataFloat(fltPercentualPartilha, 2) = 0) then
      strLinha := strLinha + fValor(fPercentualProvisorioPartilha, 7, 4) + '|'            // 008 - Perc. Provisório de partilha do ICMS Interestadual
    else
      strLinha := strLinha + fValor(fltPercentualPartilha, 7, 4) + '|';                   // 008 - Perc. Provisório de partilha do ICMS Interestadual

    strLinha := strLinha + fValor(fltValorFCP, 15, 2) + '|';                              // 009 - Valor do ICMS FCP UF Destino
    strLinha := strLinha + fValor(fltIcmsDestino, 15, 2) + '|';                           // 010 - Valor do ICMS Interestadual para UF do Destino
    strLinha := strLinha + fValor(fltIcmsOrigem, 15, 2) + '|';                            // 011 - Valor do ICMS Interestadual para UF do Remetente
    strLinha := strLinha + fValor(fltBaseFCP, 15, 2) + '|';                               // 012 - Valor da Base de Cálculo do FCP na UF de destino.

    stlArquivo.Add(strLinha);

    If fonteDados.fChaveTabela = 'MOVDET' Then
      strTabela := 'MOVICD_ESPEC'
    Else If fonteDados.fChaveTabela = 'NOTDET' Then
      strTabela := 'NOTICD_ESPEC'
    Else
      strTabela := EmptyStr;

    If Not fEmptyStr(strTabela) Then
    Begin
      If fonteDados.fTabelaExiste(strTabela) Then
        fonteDados.pGravaTabela(item, strTabela);
    End;
  End;

  function fGravaRegistros: Boolean;
  begin
    Result := False;

    If fEhNotaDeComplementoDeIcmsDeCapa Then
      Exit;

    If fEhNotaDeAjusteDeIcmsMaior Then
      Exit;

    If fEhNotaDeComplementoDeFrete Then
      Exit;

    If (dadosGerais.strFinalidade = '5') And (dadosGerais.strTipoCredito = '06') Then
      Exit;

    If (dadosGerais.strFinalidade = '6') And (dadosGerais.strTipoDebito = '04') Then
      Exit;

    Result := True;
  end;

begin
  If (fCfgSisFonte(fonteDados, 'DIFREM') = 'N') And
     (fCfgSisFonte(fonteDados, 'DIFDES') = 'N') And
     (fCfgSisFonte(fonteDados, 'VPDEFO') = 'F') And
     (fCfgSisFonte(fonteDados, 'SIMPAU') = 'S') And
     (fonteDados.fDadosGerais.blnVenPre) Then
  Begin
    Exit;
  End;

  If (lstItens.Count > 0) And (Assigned(TDadosItem(lstItens[0]))) And
     (fEhComplementoDeValorETemRegistrosDifalFcp(lstItens)) Then
  Begin
    If (Not (fLocalDestinoOperacao = OPERACAO_INTERNA)) Then
    Begin
      For intContador := 0 To lstItens.Count -1 Do
      Begin
        If (fTemRegistroDifalFcpComplementoValor(TDadosItem(lstItens[intContador]).strAutInc)) Then
        Begin
          item := TDadosItem(lstItens[intContador]);

          fltBaseDestino                := item.fltBaseUfDestino;
          fltPercentualFCP              := item.fltPercentualFCP;
          fltAliquotaInternaDestino     := item.fltAliquotaDestino;
          fltAliquotaInterestadualGerar := item.fltAliquotaInterestadual;
          fltPercentualPartilha         := item.fltPercentualPartilha;
          fltValorFCP                   := item.fltValorFCP;
          fltIcmsDestino                := item.fltValorIcmsDestino;
          fltIcmsOrigem                 := item.fltValorIcmsOrigem;
          fltBaseFCP                    := item.fltBaseFCP;
          // Banzato  - Provisorio, aguardar confirmação do André se vai retirar a tag de NFE-PRODUTO-ICMS-UF-DEST quando existir FCP ST
          If item.fltValRet = 0 Then
            pGravaRegistros;
        End;
      End;
    End;
  End
  Else
  Begin
    If (Not fAtendeRegrasDifal(fonteDados.fDadosGerais.strOpcDoc)) Then
    Begin
      Exit;
    End;

    blnExisteMovIcd := fonteDados.fTabelaExiste('MOVICD');

    For intContador := 0 To lstItens.Count -1 Do
    Begin
      item := TDadosItem(lstItens[intContador]);

      If (fSuportaOperacaoBanco(fonteDados)) And (fCfgSisFonte(fonteDados, 'DIFAUT') <> 'S') And
         ((Not blnExisteMovIcd) Or (Not fExisteRegistroTabela(['MOVICD', 'NOTICD'], ['ICD_SEQGER'], [item.strAutInc]))) Then
      Begin
        If Not (Pos(RightStr(item.strCodSit, 2), '30,60') > 0) Then
        Begin
          fltPercentualFCP := fRetAliquotaFCP;
          fltValorFCP := 0;

          fltBaseDestino := 0;
          fltIcmsDestino := 0;
          fltIcmsOrigem := 0;
          fltAlqInterestadualCalc := item.fltAlqIcm;
          fltBaseIcmsItem := item.fltBasIcm;

          blnCalcularDifalProdutoST := (fCfgSisFonte(fonteDados, 'DIFPST') = 'S');
          blnProdutoST := Pos(RightStr(item.strCodSit, 2), '10,30,60,70') > 0;

          If (item.fltBasIcm > 0) Or
             ( (objConfig.blnSimPau) And (Pos(RightStr(item.strCodSit, 2), '00,20') > 0) ) Or
             ( (blnCalcularDifalProdutoST) And (blnProdutoST) ) Then
          Begin
            If (objConfig.blnSimPau) Or
               ( (blnCalcularDifalProdutoST) And (blnProdutoST) ) Then
            Begin
              fltBaseIcmsItem := item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce + item.fltValIpi;
              fltAlqInterestadualCalc := fCalculaAliquotaInterestadual;
            End;

            fltPeBaDf := 0;
            fltPerBasDifalOrigem := 100;
            fltPerBasDifalDestino := 0;

            If (fonteDados.fSuportaOperacaoBanco) Then
            Begin
              If (fCfgSisFonte(fonteDados, 'PEBADF') = 'S') Then
              Begin
                If fonteDados.fCampoExiste('CADCLI', 'CLI_PEBADF') Then
                Begin
                  fltPeBaDf := fValorCampo('CADCLI', 'CLI_PEBADF', ['CLI_CODCLI'], [fonteDados.fDadosGerais.strCodCli]);

                  If fonteDados.fCampoExiste('CADCLI', 'CLI_PEBDDF') Then
                  Begin
                    fltPerBasDifalDestino := fValorCampo('CADCLI', 'CLI_PEBDDF', ['CLI_CODCLI'], [fonteDados.fDadosGerais.strCodCli]);
                  End;
                End;
              End
              Else If (fCfgSisFonte(fonteDados, 'BASDFL') = 'S') Then
              Begin
                If fonteDados.fCampoExiste('CADABF', 'ABF_BASDDS') Then
                  fltPerBasDifalDestino := fValorCampo('CADABF', 'ABF_BASDDS', ['ABF_CODABF','ABF_ESTADO'], [item.strCodAbf, fonteDados.fDadosGerais.strEstado]);
              End;
            End;

            If fCfgSisFonte(fonteDados, 'DIFCPD') <> 'N' Then
            Begin
              fltBaseInterestadual := fFormataFloat(fltBaseIcmsItem / (1 - (fltAlqInterestadualCalc / 100) ), 2);
              fltIcmsTotalOrigem := fFormataFloat(fltBaseInterestadual * fltAlqInterestadualCalc / 100, 2);

              fltBaseDestino := fFormataFloat(fltBaseIcmsItem / (1 - (fRetAliquotaInternaEstadoDestino / 100) ), 2);
              fltIcmsTotalDestino := fFormataFloat(fltBaseDestino * fRetAliquotaInternaEstadoDestino / 100, 2);

              If (blnCalcularDifalProdutoST) And (blnProdutoST) Then
              Begin
                fltIcmsTotalDiferenca := fltIcmsTotalDestino;
              End
              Else
              Begin
                fltIcmsTotalDiferenca := fltIcmsTotalDestino - fltIcmsTotalOrigem;
              End;

              fltIcmsDestino    := fFormataFloat(fltIcmsTotalDiferenca *  fPercentualProvisorioPartilha / 100, 2);
              fltIcmsOrigem    := fltIcmsTotalDiferenca - fltIcmsDestino;

              {***************************************************}
              {* ESTAVA INDO COM VALOR TENTANDO FAZER O CALCULO  *}
              {* E DAVA ERRADO POIS O fltValorFCP VAI ESTAR 0.00 *}
              {*************************************************LE}
              fltPercentualFCP := 0;
            End
            Else
            Begin
              If (fCfgSisFonte(fonteDados, 'PEBADF') = 'S') Or (fCfgSisFonte(fonteDados, 'BASDFL') = 'S') Then
              Begin
                If (fltPerBasDifalDestino > 0) Then
                Begin
                  fltBaseIcmsItem := fFormataFloat(item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce + item.fltValIpi, 2);
                  fltBaseDestino  := fFormataFloat(((item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce + item.fltValIpi)) * (fltPerBasDifalDestino / 100), 2);
                End
                Else If (fltPeBaDf > 0) Then
                Begin
                  fltBaseIcmsItem := (item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce + item.fltValIpi) * (fltPeBaDf / 100);
                  fltBaseDestino  := fltBaseIcmsItem;
                End
                Else
                  fltBaseDestino := fltBaseIcmsItem;

                fltIcmsDifalOrigem  := fFormataFloat(((fltBaseIcmsItem * fltAlqInterestadualCalc) / 100), 2);
                fltIcmsDifalDestino := fFormataFloat(((fltBaseDestino * fRetAliquotaInternaEstadoDestino) / 100), 2);

                fltIcmsDifAliquota := fFormataFloat(fltIcmsDifalDestino - fltIcmsDifalOrigem, 2);
                fltIcmsDestino := fFormataFloat(fltIcmsDifAliquota * fPercentualProvisorioPartilha / 100, 2);
                fltIcmsOrigem := fltIcmsDifAliquota - fltIcmsDestino;

                If (item.fltBasRet > 0) Then
                  fltBaseFCP := item.fltBasRet
                Else
                  fltBaseFCP := fltBaseDestino;

                fltValorFCP := fFormataFloat(fltBaseFCP * fRetAliquotaFCP / 100, 2);

              End
              Else
              Begin
                fltBaseDestino := fltBaseIcmsItem;

                If (blnCalcularDifalProdutoST) And (blnProdutoST) Then
                Begin
                  If (item.fltBasRet > 0) Then
                    fltBaseFCP := item.fltBasRet
                  Else
                    fltBaseFCP := fltBaseDestino;

                  fltIcmsDifAliquota := fFormataFloat((fltBaseDestino + item.fltTotFre) * ((fRetAliquotaInternaEstadoDestino  - fltAlqInterestadualCalc) / 100), 2);
                  fltValorFCP := fFormataFloat(fltBaseFCP * fRetAliquotaFCP / 100, 2);
                End
                Else
                Begin
                  fltDifAliquota := fFormataFloat(fRetAliquotaInternaEstadoDestino - fltAlqInterestadualCalc, 2);

                  If (item.fltBasRet > 0) Then
                    fltBaseFCP := item.fltBasRet
                  Else
                    fltBaseFCP := fltBaseIcmsItem;

                  If (fltPerBasDifalOrigem > 0) And (fltPerBasDifalDestino > 0) Then
                    fltIcmsDifAliquota := fFormataFloat(fltBaseDestino * fltDifAliquota / 100, 2)
                  Else
                    fltIcmsDifAliquota := fFormataFloat(fltBaseIcmsItem * fltDifAliquota / 100, 2);

                  fltValorFCP := fFormataFloat(fltBaseFCP * fRetAliquotaFCP / 100, 2);
                End;

                If fltIcmsDifAliquota < 0 Then
                Begin
                  fltIcmsDifAliquota := 0;
                End;

                fltIcmsDestino := fFormataFloat(fltIcmsDifAliquota * fPercentualProvisorioPartilha / 100, 2);
                fltIcmsOrigem := fltIcmsDifAliquota - fltIcmsDestino;
              End;
            End;
          End
          Else
          Begin
            fltAlqInterestadualCalc := fCalculaAliquotaInterestadual;
          End;

          If (objConfig.blnSimPau) Then
          Begin
            If fCfgSisFonte(fonteDados, 'DIFREM') = 'N' Then
              fltIcmsOrigem := 0;

            If fCfgSisFonte(fonteDados, 'DIFDES') = 'N' Then
              fltIcmsDestino := 0;
          End;

          fltPercentualPartilha := fPercentualProvisorioPartilha;
          fltAliquotaInternaDestino := fRetAliquotaInternaEstadoDestino;
          fltAliquotaInterestadualGerar := IIF((fltBaseDestino > 0) And (Not objConfig.blnSimPau) And (Not blnProdutoST), item.fltAlqIcm, fltAlqInterestadualCalc);
        End;
      End
      Else
      Begin
        fltBaseDestino := item.fltBaseUfDestino;
        fltPercentualFCP := item.fltPercentualFCP;
        fltAliquotaInternaDestino := item.fltAliquotaDestino;
        fltAliquotaInterestadualGerar := item.fltAliquotaInterestadual;
        fltPercentualPartilha := item.fltPercentualPartilha;
        fltValorFCP := item.fltValorFCP;
        fltIcmsDestino := item.fltValorIcmsDestino;
        fltIcmsOrigem := item.fltValorIcmsOrigem;
        fltBaseFCP := item.fltBaseFCP;
      End;

      If fGravaRegistros Then
        pGravaRegistros;
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoII;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If (StrToIntDef(LeftStr(dadosGerais.strClaFis, 1), 0) = 3) And Assigned(item.documentoImportacao) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-II|';                                                      // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                           // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                           // 003 - Nr.Item
      strLinha := strLinha + fValor(item.documentoImportacao.fltBaseImpostoImportacao, 15, 2) + '|';  // 004 - Valor Base de Calculo do II
      strLinha := strLinha + fValor(item.documentoImportacao.fltDespesasAduaneiras, 15, 2) + '|';     // 005 - Valor das Despesas Aduaneiras
      strLinha := strLinha + fValor(item.documentoImportacao.fltValorImpostoImportacao, 15, 2) + '|'; // 006 - Valor do II
      strLinha := strLinha + fValor(item.documentoImportacao.fltValorIOF, 15, 2) + '|';               // 007 - Valor do IOF

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoISSQN;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;

    fltAlqIss: Double;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If fItemServico(item) Then
    Begin
      fltAlqIss := dadosGerais.fltValIss / dadosGerais.fltBasIss * 100;

      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-ISSQN|';                                         // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                 // 003 - Nr.Item
      strLinha := strLinha + fValor(item.fltTotIte, 15, 2) + '|';                           // 004 - Valor da Base de Cálculo do ISSQN
      strLinha := strLinha + fValor(fltAlqIss, 7, 4) + '|';                                 // 005 - Alíquota do ISSQN
      strLinha := strLinha + fValor(item.fltTotIte * fltAlqIss / 100, 15, 2) + '|';         // 006 - Valor do ISSQN
      strLinha := strLinha + dadosEmitente.strCodIbge + '|';                                // 007 - Código do Município de ocorrência do fato gerador do ISSQN
      strLinha := strLinha + FormatMaskText('99.99;0;_', item.strCodListaServ) + '|';       // 008 - Código da Lista de Serviços
      strLinha := strLinha + 'N|';                                                          // 009 - Código de Tributação do ISSQN (N-NORMAL)
      strLinha := strLinha + ' |';                                                          // 010 - Valor deduçãoo para redução da Base de Calculo
      strLinha := strLinha + ' |';                                                          // 011 - Valor Outras Retenções
      strLinha := strLinha + ' |';                                                          // 012 - Valor Desconto Incondicionado
      strLinha := strLinha + ' |';                                                          // 013 - Valor Desconto Condicionado
      strLinha := strLinha + ' |';                                                          // 014 - Valor Retenção ISS
      strLinha := strLinha + '2|';                                                          // 015 - Indicador da Exigibilidade do ISS A 2 S 1=Exigível, 2=Não incidência; 3=Isenção; 4=Exportação; 5=Imunidade; 6=Exigibilidade
      strLinha := strLinha + ' |';                                                          // 016 - Codigo do serviço prestado dentro do município
      strLinha := strLinha + ' |';                                                          // 017 - Codigo do Municipio de Incidencia do imposto
      strLinha := strLinha + ' |';                                                          // 018 - Codigo do Pais onde o serviço foi prestado
      strLinha := strLinha + ' |';                                                          // 019 - Numero do Processo, informar somente quando declarada a suspensão da exigibilidade do ISSQN
      strLinha := strLinha + '2|';                                                          // 020 - Indicador de Incentivo Fiscal 1 – Sim / 2 - Não

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutoPIS;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    If Not fEmptyStr(item.strCstPis) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-PIS|';                                           // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                 // 003 - Nr.Item

      If Pos(item.strCstPis, '01, 02') > 0 Then
      Begin
        strLinha := strLinha + item.strCstPis + '|';                                        // 004 - Código de Situação Tributária do PIS
        strLinha := strLinha + fValor(item.fltBasPis, 15, 2) + '|';                         // 005 - Valor da Base de Cálculo do PIS
        strLinha := strLinha + fValor(item.fltAlqPis, 7, 4) + '|';                          // 006 - Alíquota do PIS (em percentual)
        strLinha := strLinha + fValor(item.fltValPis, 15, 2) + '|';                          // 007 - Valor do PIS
      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 4); // 004 - 007 - PIS CST 01, 02
      End;

      If Pos(item.strCstPis,'03') > 0 Then                           //PIS Tributado por Quantidade = CST 03
      Begin
        strLinha := strLinha + item.strCstPis    + '|';
        strLinha := strLinha + fValor(0, 15, 4)  + '|';
        strLinha := strLinha + fValor(0, 7, 4)   + '|';
        strLinha := strLinha + fValor(0, 15, 2)  + '|';
      End
      Else
        strLinha := strLinha + fReplicatorStr('|', 4);                                        // 008 - 011 - PIS CST 03

      If Pos(item.strCstPis, '04,05,06,07,08,09') > 0 Then
      Begin
        strLinha := strLinha + item.strCstPis + '|';                                        // 012 - Código de Situação Tributária do PIS
      End
      Else
      Begin
        strLinha := strLinha + '|';                                                         // 012 - Código de Situação Tributária do PIS
      End;

      If Pos(item.strCstPis, '49,50,51,52,53,54,55,56,60,61,62,63,64,65,66,67,70,71,72,73,74,75,98,99') > 0 Then
      Begin
        strLinha := strLinha + item.strCstPis + '|';                                        // 013 - Código de Situação Tributária do PIS
        strLinha := strLinha + fValor(item.fltBasPis, 15, 2) + '|';                         // 014 - Valor da Base de Cálculo do PIS
        strLinha := strLinha + fValor(item.fltAlqPis, 7, 4) + '|';                          // 015 - Alíquota do PIS (em percentual)
        strLinha := strLinha + '|';                                                         // 016 - Quantidade Vendida
        strLinha := strLinha + '|';                                                         // 017 - Alíquota do PIS (em reais)
        strLinha := strLinha + fValor(item.fltValPis, 15, 2) + '|';                         // 018 - Valor do PIS
      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 6); // 013 - 018 - PIS CST OUTRAS
      End;

      strLinha := strLinha + fReplicatorStr('|', 5);                                        // 019 - 023 - PIS SUSBSTITUIÇÃO TRIBUTÁRIA

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEProdutosIPI;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;

    strCstIpi: String;
    strEnqIpi: String;
begin
  If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
    Exit;

  If (fCfgSisFonte(fonteDados, 'SIMPAU') = 'S') And
     (fCfgSisFonte(fonteDados, 'SIMIPI') = 'S') And 
     (dadosGerais.fltTotIpi = 0) Then
  Begin   
    Exit;
  End;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    strCstIpi := fDeterminaCSTIpi(item, fItemServico(item));

    If fEmptyStr(item.strEnqIpi) Then
      strEnqIpi := '999'
    Else
      strEnqIpi := item.strEnqIpi;

    If (Not fEmptyStr(strCstIpi)) And (fFormataFloat(item.fltPerDevolvido, 2) = 0) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-IPI|';                                           // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                 // 02 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                 // 003 - Nr.Item
      strLinha := strLinha + '|';                                                           // 004 - Classe de enquadramento do IPI
      strLinha := strLinha + '|';                                                           // 005 - CNPJ Produtor
      strLinha := strLinha + '|';                                                           // 006 - Código do selo de controle do IPI
      strLinha := strLinha + '|';                                                           // 007 - Quantidade do selo de controle IPI
      strLinha := strLinha + strEnqIpi + '|';                                               // 008 - Código do Enquadramento Legal do IPI

      If Pos(strCstIpi, '00, 49, 50, 99') > 0 Then
      Begin
        strLinha := strLinha + strCstIpi + '|';                                             // 009 - CST – Tributação do IPI
        strLinha := strLinha + fValor(item.fltBasIpi, 15, 2) + '|';                         // 010 - Base Calculo IPI
        strLinha := strLinha + '|';                                                         // 011 - Quantidade total unidade
        strLinha := strLinha + '|';                                                         // 012 - Valor por unidade tributável
        strLinha := strLinha + fValor(item.fltAlqIpi, 7, 4) + '|';                          // 013 - Alíquota IPI
        strLinha := strLinha + fValor(item.fltValIpi, 15, 2) + '|';                         // 014 - Valor do IPI
        fltTotalIPI := fltTotalIPI + item.fltValIpi;
      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 6); // 009 - 014 - IPI 00,49,50,99
      End;

      If Pos(strCstIpi, '01,02,03,04,05,51,52,53,54,55') > 0 Then
      Begin
        strLinha := strLinha + strCstIpi + '|';                                             // 015- CST – Tributação do IPI
      End
      Else
      Begin
        strLinha := strLinha + '|';                                                         // 015- CST – Tributação do IPI
      End;

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400.pNFEInformacoesDeProcessoReferenciado;
  Var
    strLinha: String;
begin
  If (not fEmptyStr(dadosGerais.strIprNum)) And (not fEmptyStr(dadosGerais.strIprOri)) Then
  Begin
    strLinha := '';
    strLinha := strLinha + 'NFE-PROCESSO-REF|';                                            // 01 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência
    strLinha := strLinha + '1|';                                                           // 03 - ID Processo Referenciado
    strLinha := strLinha + dadosGerais.strIprNum + '|';                                    // 04 - Número Identificador do processo ou Ato Concessório
    strLinha := strLinha + dadosGerais.strIprOri + '|';                                    // 05 - Indicador da origem do processo

    If (dadosGerais.strIprOri = '0') And (not fEmptyStr(dadosGerais.strIprTip)) Then
      strLinha := strLinha + dadosGerais.strIprTip + '|'                                   // 06 - Tipo do ato concessório
    Else
      strLinha := strLinha + '|';                                                          // 06 - Tipo do ato concessório

    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400.pNFEProdutosServicos;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;

    strCstSimples: String;
    fltValorIcmsOperacao: Double;
    fltValorIcmsDiferido: Double;
    fltPercentualDiferido: Double;
    fltAliquotaIcmsOperacao: Double;
    blnNotaImportacao: Boolean;

    fltValUnt: Double;
    fltValTot: Double;
    fltValDes: Double;
    fltUniTri: Double;
    fltAliquotaIcmsComFCPIcms : double;
    fltPercentualReducao : double;
    fltValorFcpDiferido : double;
    fltValorFcpEfetivo : double;

    blnExisteMovIcd: Boolean;

  function fGetRegraMDBCST: string;
    const
      _0_PRECO_TABELA_OU_MAXIMO_SUGERIDO : string = '0';
      _4_MARGEM_VALOR_AGREGADO_PERCENTUAL : string = '4';
      _6_VALOR_DA_OPERACAO : string = '6';
  begin

    Result := fBuscaRegraModalidadeDeterminacaoBCST(fonteDados, item.strCodSit, (item.fltValIva <> 0));

    if fEmptyStr(Result) then
    begin
      If ((RightStr(item.strCodSit, 2) = '90') And (item.fltValIva = 0)) Or
         ((RightStr(item.strCodSit, 2) = '10') And (dadosGerais.strPerfil = '_SAI_CCO') And (item.fltValIva = 0)) Then
        Result := _6_VALOR_DA_OPERACAO
      else if (item.fltValIva = 0) And (Pos(dadosEmitente.strEstado, fCfgSisFonte(fonteDados, 'UFSMVA')) > 0) Then
        Result := _0_PRECO_TABELA_OU_MAXIMO_SUGERIDO
      else
        Result := _4_MARGEM_VALOR_AGREGADO_PERCENTUAL;
    end;
  end;

  procedure pSetarAnotacoesDadosItem(AValue: string; dadosItem: TDadosItem);
  begin
    if fEmptyStr(AValue) then
      exit;

    if not fEmptyStr(dadosItem.strAnotacoes) Then
      dadosItem.strAnotacoes := dadosItem.strAnotacoes + ' - ' + AValue
    else
      dadosItem.strAnotacoes := AValue;
  end;

  function fInsereMsgDesonerado: Boolean;
  var
    strMseDes: String;
  begin
    Result := True;

    If not (LeftStr(item.strClaFis, 1) = '7') Then
      Exit;

    strMseDes := fCfgSisFonte(fonteDados, 'MSEDES');

    strMseDes := IIF(fEmptyStr(strMseDes), 'S', strMseDes);

    If not (strMseDes = 'N') Then
      Exit;

    Result := False;
  end;

  procedure pSetaInformacoesDesonerado;
    const
      MOTIVO_DESONERACAO_7_SUFRAMA : String = '7';
      MOTIVO_DESONERACAO_8_ORGAO_PUBLICO : String = '8';
      MOTIVO_DESONERACAO_9_OUTROS : String = '9';

    var fltAlqDes,
        fltBasDes,
        fltIcmDes: Double;
  begin
    If (item.fltIcmOrg > 0) Or (item.fltVrdIcm > 0) Then
    Begin
      If item.fltIcmOrg > 0 Then
      Begin
        fltTotalValorIcmsDesonerado := fltTotalValorIcmsDesonerado + item.fltIcmOrg;
        strLinha := strLinha + fValor(item.fltIcmOrg, 15, 2) + '|';                      // Valor do ICMS desoneração
        If (dadosGerais.strZonFra = 'S') Then
          strLinha := strLinha + MOTIVO_DESONERACAO_7_SUFRAMA + '|'                      // Motivo da desoneração do ICMS
        Else
        Begin
          if dadosGerais.strMotDes = '9' then
            strLinha := strLinha + MOTIVO_DESONERACAO_9_OUTROS + '|'             // Motivo da desoneração do ICMS
          else
            strLinha := strLinha + MOTIVO_DESONERACAO_8_ORGAO_PUBLICO + '|'             // Motivo da desoneração do ICMS
        End;
      End
      Else If item.fltVrdIcm > 0 Then
      Begin
        blnIcmsDesoneradoX40 := True;
        fltTotalValorIcmsDesonerado := fltTotalValorIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                      // Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                     // Motivo da desoneração do ICMS
      End;
    End
    Else If (not (dadosGerais.strDesativaTagsDesoneracao = 'S')) And (Pos(dadosEmitente.strEstado, fCfgSisFonte(fonteDados, 'DESOUT')) > 0) Then
    Begin
      if (item.fltAlqIcm > 0) then
        fltAlqDes := item.fltAlqIcm
      else
        fltAlqDes := fBuscaAliquotaDeIcmsDaOperacaoPropria(fonteDados, item.strCodIte, item.strCodAbf, dadosGerais.strEstado, dadosGerais.strPerfil, dadosGerais.strCodEmp);

      if (fltAlqDes = 0) then
        fltAlqDes := fAliquotaIcmsUF(fonteDados, dadosGerais.strEstado);

      if (fCfgSisFonte(fonteDados, 'RGDESO') = '2') then
      begin
        // ( Vr.Produto x ( 1 - ( ALQICM+FCP x ( 1 - PERRED ) ) )  / ( 1 - ALQICM+FCP ) - Vr.Produto )
        if (item.fltPerBas > 0) and (item.fltPerBas < 100) then
        Begin
          fltPercentualReducao := (100-item.fltPerBas)/100;
          fltAliquotaIcmsComFCPIcms := (fltAlqDes + item.fltPercentualFCP)/100;
          fltIcmDes := ((item.fltTotIte - item.fltDesEsp) * ( 1 - ( fltAliquotaIcmsComFCPIcms * ( 1 - fltPercentualReducao))) / ( 1 - fltAliquotaIcmsComFCPIcms ) - (item.fltTotIte - item.fltDesEsp) );
        End
        Else
        Begin
          fltAliquotaIcmsComFCPIcms := (fltAlqDes + item.fltPercentualFCP);
          fltIcmDes := (((item.fltTotIte - item.fltDesEsp) * fltAliquotaIcmsComFCPIcms) / 100);
        End;
        fltBasDes := fFormataFloatInterna((item.fltTotIte - item.fltDesEsp), 2);
        fltIcmDes := fFormataFloatInterna(fltIcmDes, 2);
        if (fltIcmDes < 0) then
          fltIcmDes := 0;
      end
      else
      begin
        if (item.fltPerBas > 0) and (item.fltPerBas < 100) then
        begin
          fltBasDes := fFormataFloatInterna((((item.fltTotIte - item.fltDesEsp) * (100-item.fltPerBas)) / 100), 2);
          fltIcmDes := fFormataFloatInterna(((((item.fltTotIte - item.fltDesEsp) * (100-item.fltPerBas)) / 100) * fltAlqDes) / 100, 2)
        end
        else
        begin
          fltBasDes := fFormataFloatInterna((item.fltTotIte - item.fltDesEsp), 2);
          fltIcmDes := fFormataFloatInterna(((item.fltTotIte - item.fltDesEsp) * fltAlqDes) / 100, 2);
        end;
      end;

      fonteDados.pGravaIcmsDesonerado(IIF(fonteDados.fChaveTabela = 'MOVDET', 'MOVTRI', 'NOTTRI'), item.strAutInc, '9', fltIcmDes);

      If fInsereMsgDesonerado Then
      Begin
        pSetarAnotacoesDadosItem('MOT.DESONER.: 9', item);
        pSetarAnotacoesDadosItem('VLR.DESONER.: ' + FloatToStrF(fltIcmDes, ffNumber, 12, 2) + ' ', item);
      End;

      fltTotalBaseIcmsDesonerado  := fltTotalBaseIcmsDesonerado  + fltBasDes;
      fltTotalValorIcmsDesonerado := fltTotalValorIcmsDesonerado + fltIcmDes;

      strLinha := strLinha + fValor(fltIcmDes, 15, 2) + '|';                             // Valor do ICMS desoneração
      strLinha := strLinha + '9|';                                                       // Motivo da desoneração do ICMS
    End
    Else
    Begin
      strLinha := strLinha + '|';                                                        // Valor do ICMS desoneração
      strLinha := strLinha + '|';                                                        // Motivo da desoneração do ICMS
    End;
  end;

  function fFcpST(fltPercentualFCP: Double): Boolean;
  begin
    Result := (((Pos(RightStr(item.strCodSit, 2), '10_30_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False))) Or
              (Pos(strCstSimples, '201, 202, 203, 900') > 0)) And (fFormataFloat(fltPercentualFCP, 2) > 0) And
              ((item.fltBasRet > 0) Or ((item.fltValorFCPST > 0) And (item.fltBasRet = 0) And (dadosGerais.blnNfComp)));
  end;

  function fFcpVaiNoCampoDestino: Boolean;
  begin
    // Operação Interestadual E Consumidor Final
    Result := ((fLocalDestinoOperacao = '2') And (fIndicadorConsumidorFinal = '1'));
  end;

  function fImprimeIPIDadosProprios: Boolean;
  begin
    Result := untFuncoesLibNfe.fImprimeIPIDadosProprios(dadosGerais.strClaFis,
      objConfig.strClaVen, objConfig.strOpcImpValIpi, objConfig.blnConIpi);
  end;

  function fCalculaDiferimentoDeICMS: Boolean;
  begin
    Result := False;

    If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
      Exit;

    Result := (RightStr(item.strCodSit, 2) = '51') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao);
  end;

  function fCalculaDiferimentoTotalDeICMS: Boolean;
  begin
    Result := False;

    If not fCalculaDiferimentoDeICMS Then
      Exit;

    If (item.strDiferi = 'S') And (item.fltPerRed = 100) Then
    Begin
      Result := True;
      Exit;
    End;

    If (item.strRICMPR = 'S') And (item.fltPerRed = 100) Then
    Begin
      Result := True;
      Exit;
    End;

    If (Pos(dadosEmitente.strEstado, fCfgSisFonte(fonteDados, 'DIFX51')) > 0) And (item.strRICMPR <> 'S') Then
    Begin
      Result := True;
      Exit;
    End;
  end;

  function fCalculaDiferimentoDeFCP: Boolean;
  begin
    Result := fCalculaDiferimentoDeICMS And (item.fltValorIcmsDestino = 0) And (item.fltValorFCP > 0);
  end;

  function fAliquotaSuportadoPeloConsumidorFinal: Double;
  begin
    Result := item.fltAlqFin;

    If fonteDados.fTabelaExiste('ABFICM') Then
      Exit;

    If not (dadosEmitente.strEstado = 'RJ') Then
      Exit;

    Result := 22.0;
  end;

  function fInformaIndicadorDeDesoneracaoSuframa: Boolean;
  begin
    Result := False;

    If not (Pos(RightStr(item.strCodSit, 2), '20_30_40_41_50_70_90_') > 0) Then
      Exit;

    If not (fltTotalValorIcmsDesonerado > 0) Then
      Exit;

    If (item.fltIcmOrg > 0) And (dadosGerais.strZonFra = 'S') Then
    Begin
      Result := True;
      Exit;
    End;

    If (item.fltVrdIcm > 0) And (item.strMtdIcm = '7') Then
    Begin
      Result := True;
      Exit;
    End
  end;

  function fEnviaDadosDeIcmsStRetido: Boolean;
  begin
    Result := (fCfgSisFonte(fonteDados, 'UTIE48') = 'S') And
              (dadosGerais.strEstado = dadosEmitente.strEstado) And
              (dadosGerais.strCliCon = 'N') And
              (item.fltVSTANT > 0);
  end;

  function fEnviaDadosDeIcmsStRepasse: Boolean;
  begin
    Result := (fCfgSisFonte(fonteDados, 'ICMREP') = 'S') And
              (dadosGerais.strEstado = dadosEmitente.strEstado) And
              (dadosGerais.strCliCon = 'S') And
              (item.fltVSTANT > 0);
  end;

  function fRetornoCodigoBeneficioFiscal: String;
  begin
    Result := fTiraCaracEspeciais(item.strCdbFis);

    If (RightStr(item.strCodSit, 2) = '00') Then
      Result := '';

    If (RightStr(item.strCodSit, 2) = '90') And (dadosEmitente.strEstado = 'GO') Then
      Result := 'SEM CBENEF';
  end;

  function fReformaTributariaRetornaValorTotalDoItem: String;
  begin
    Result := '';

    If not Assigned(item.ReformaTributaria) Then
      Exit;

    If not Assigned(item.ReformaTributaria.IBS_CBS) Then
      Exit;

    If not fGeraSchemaReformaTributaria(fonteDados, dadosGerais.strCodEmp) Then
      Exit;

    Result := fValor(Item.ReformaTributaria.IBS_CBS.fltTotal, 15, 2);
  end;

  function fProdutoComIcmsDesoneradoX40: Boolean;
  begin
    Result := (item.fltVrdIcm > 0) and (RightStr(item.strCodSit, 2) = '40');

    If not Result Then
      Exit;

    If (dadosGerais.strZonFra = 'S') And (dadosGerais.strDesZon = 'S') then
      Result := False;
  end;

begin
  fltTotalBaseIcmsDesonerado  := 0;
  fltTotalValorIcmsDesonerado := 0;
  fltTotalDesconto := 0;
  fltTotalProdutos := 0;
  fltBasIcmDif := 0;

  fltTotalBaseIcmsDesonerado := dadosGerais.fltBasOrg + dadosGerais.fltBasVrd;

  blnExisteMovIcd := fonteDados.fTabelaExiste('MOVICD');

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    blnNotaImportacao := (LeftStr(item.strClaFis, 1) = '3');
    strCstSimples     := fRetornaCSTSimples(dadosEmitente, dadosGerais, item, fItemServico(item));

    If not fUsaUniTri(item.strClaFis) Then
       item.strUnTrib := item.strUnidad ;

    If fEhDevolucaoParaFornecedor(item) Or (fFinalidadeEmissao = '2') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'IMPRNF'))) Or (fCfgSisFonte(fonteDados, 'IMPRNF') = '1') Then
    Begin
      fltValUnt := item.fltUnitar;
      fltValTot := item.fltTotIte;
      fltValDes := item.fltDesEsp;
      fltUniTri := item.fltUniTri;
    End
    Else
    Begin
      fltValUnt := Iif(item.fltUnitar < item.fltUniOri, item.fltUniOri, item.fltUnitar);
      fltValTot := fFormataFloat(item.fltQtdIte * fltValUnt, 2);
      fltValDes := fFormataFloat(fltValTot - (item.fltTotIte - item.fltDesEsp), 2);
      fltUniTri := Iif(item.fltUnitar < item.fltUniOri, item.fltUniTrO, item.fltUniTri);
    End;

    If (fCfgSisFonte(fonteDados, 'UNITRI') = 'S') And
       (not fEmptyStr(fCfgSisFonte(fonteDados, 'UTCFOP'))) And
       (not fUsaUniTri(item.strClaFis)) Then
    Begin
      item.strUnTrib := item.strUnidad ;
      item.fltQtdTri := item.fltQtdIte ;
      fltUniTri      := fltValUnt ;
    End;

    If fEhDevolucaoParaFornecedorComIcmsDesoneradoX40(item) Then
    Begin
      item.strMtdIcm := '9';
    End;

    If (dadosGerais.strZonFra = 'S') And (item.fltIcmOrg > 0) Then
    Begin
      blnIcmsDesonerado := True;
      if (item.fltDesEsp - item.fltIcmOrg) > 0 then
        fltValDes := item.fltDesEsp - item.fltIcmOrg
      else
        fltValDes := 0;
    End
    else if fProdutoComIcmsDesoneradoX40 then
    begin
      if (item.fltDesEsp - item.fltVrdIcm) > 0 then
        fltValDes := item.fltDesEsp - item.fltVrdIcm
      else
        fltValDes := 0;
    end;

    If (pos(dadosGerais.strFinalidade, '5_6_') > 0) Then
    Begin
      item.fltImpPag := 0;
      item.fltMunImp := 0;
      item.fltEstImp := 0;
      item.fltFedImp := 0;
      item.fltVrdIcm := 0;
    End;

    fltTotalDesconto := fltTotalDesconto + fltValDes;
    fltTotalProdutos := fltTotalProdutos + fltValTot;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO|';                                                 // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                  // 003 - Nr.Item

    If (objConfig.strCliPro = 'S') And (Not fEmptyStr(item.strCod_Nf)) Then
      strLinha := strLinha + item.strCodIte + '|'                                           // 004 - Código do relacionado Cliente-Produto
    Else If (fCfgSisFonte(fonteDados, 'NFEREF') = 'S') And (not dadosGerais.blnNfComp) Then
      strLinha := strLinha + item.strRefere + '|'                                          // 004 - Ite_Refere do Produto
    Else
      strLinha := strLinha + item.strCodIte + '|';                                         // 004 - Código do Produto/Serviço

    strLinha := strLinha + item.strCodBar + '|';                                           // 005 - Código EAN
    strLinha := strLinha + item.strDesIte + IIF(Not fEmptyStr(item.strCoiCmp),' - Cód. Interno: '+item.strCoiCmp,'') + '|'; // 006 - Descrição do Produto
    strLinha := strLinha + item.strClaIpi + '|';                                           // 007 - NCM
    strLinha := strLinha + '|';                                                            // 008 - Codificação NVE – Nomenclatura de Valor Aduaneiro e Estatística.
    strLinha := strLinha + item.strExcIpi + '|';                                           // 009 - EXTIPI
    strLinha := strLinha + '|';                                                            // 010 - GENERO
    strLinha := strLinha + item.strClaFis + '|';                                           // 011 - CFOP
    strLinha := strLinha + item.strUnidad + '|';                                           // 012 - Unidade Comercial
    strLinha := strLinha + fValor(item.fltQtdIte, 15, 4) + '|';                            // 013 - Quantidade Comercial
    strLinha := strLinha + fValor(fltValUnt, 11, 10) + '|';                                // 014 - Valor Unitário Comercial
    strLinha := strLinha + fValor(fltValTot, 15, 2) + '|';                                 // 015 - Valor Total Bruto dos Produtos/Serviços
    strLinha := strLinha + item.strCdGTin + '|';                                           // 016 - EAN Tributável
    strLinha := strLinha + item.strUnTrib + '|';                                           // 017 - Unidade Tributável
    strLinha := strLinha + fValor(item.fltQtdTri, 15,4) + '|';                             // 018 - Quantidade Tributável
    strLinha := strLinha + fValor(fltUniTri, 11, 10) + '|';                                // 019 - Valor Unitário de Tributação
    strLinha := strLinha + fValor(item.fltTotFre, 15, 2) + '|';                            // 020 - Valor Total do Frete
    strLinha := strLinha + '|';                                                            // 021 - Valor Total do Seguro
    strLinha := strLinha + fValor(fltValDes, 15, 2) + '|';                                 // 022 - Valor Total do Desconto

    If (Not fImprimeIPIDadosProprios) And (item.fltPerDevolvido > 0) Then
      strLinha := strLinha + fValor(item.fltDesAce - item.fltValIpiDadosAdicionais, 15, 2) + '|'  // 023 - Valor Outras Despesas Acesssorias
    Else
      strLinha := strLinha + fValor(item.fltDesAce, 15, 2) + '|';                                 // 023 - Valor Outras Despesas Acesssorias

    strLinha := strLinha + IIF(dadosGerais.blnComplementoFrete, '0|', '1|');               // 024 - Indicador Totalizador NF-e (0-Não compõe Total, 1-Compõe Total)

    If (RightStr(item.strCodSit, 2) = '00') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 025 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 026 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                         // 027 - Modalidade de determinação BC ICMS (3-Valor da operação)
      strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';                          // 028 - Valor da Base Calculo do ICMS
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4)+ '|';                            // 029 - Alíquota do ICMS (sem o FCP)
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                          // 030 - Valor do ICMS
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 6); // 25 - 30 - ICMS X00
    End;

    If (RightStr(item.strCodSit, 2) = '10') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 031 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 032 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                         // 033 - Modalidade de determinação BC ICMS (3-Valor da operação)
      strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';                          // 034 - Valor da Base Calculo do ICMS
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4)+ '|';                            // 035 - Alíquota do ICMS
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                          // 036 - Valor do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                        // 037 - Modalidade de determinação BC ICMS Subt.Trib
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                           // 038 - Percentual da MVA ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                           // 039 - Percentual de Redução de BC ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 040 - Valor da Base Calculo do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                           // 041 - Alíquota do ICMS Subst.Trib. (sem o FCP)
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 042 - Valor do ICMS Subst.Trib
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 12); // 31 - 42 - ICMS X10
    End;

    If (RightStr(item.strCodSit, 2) = '20') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 043 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 044 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                         // 045 - Modalidade de determinação BC ICMS (3-Valor da operação)
      strLinha := strLinha + fValor(item.fltPerRed, 7, 4) + '|';                           // 046 - Percentual de Redução de BC ICMS
      strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';                          // 047 - Valor da Base Calculo do ICMS
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4)+ '|';                            // 048 - Alíquota do ICMS (sem o FCP)
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                          // 049 - Valor do ICMS

      If (item.fltVrdIcm > 0) Then
      Begin
        fltTotalValorIcmsDesonerado := fltTotalValorIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                        // 050 - Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                       // 051 - Motivo da desoneração do ICMS
      End
      Else
        pSetaInformacoesDesonerado;

    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 9); // 43 - 51 - ICMS X20
    End;

    If (RightStr(item.strCodSit, 2) = '30') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 052 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 053 - CST – Tributação do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                        // 054 - Modalidade de determinação BC ICMS Subt.Trib
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                           // 055 - Percentual da MVA ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                           // 056 - Percentual de Redução de BC ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 057 - Valor da Base Calculo do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                           // 058 - Alíquota do ICMS Subst.Trib. (sem FCP)
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 059 - Valor do ICMS Subst.Trib
      pSetaInformacoesDesonerado;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 10); // 52 - 61 - ICMS X30
    End;

    If (Pos(RightStr(item.strCodSit, 2), '40_41_50_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 062 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 063 - CST – Tributação do ICMS
      pSetaInformacoesDesonerado;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 4); // 62 - 65 - ICMS X40, X41, X50
    End;

    If fCalculaDiferimentoDeICMS Then
    Begin
      If dadosGerais.blnComplementoIcms And (item.fltIcmDif > 0) Then
      Begin
        strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';     // 066 - Origem da Mercadoria
        strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';    // 067 - CST – Tributação do ICMS
        strLinha := strLinha + '3|';                                 // 068 - Modalidade de determinação BC ICMS
        strLinha := strLinha + fValor( 0, 15, 2) + '|';              // 069 - Percentual de Redução de BC ICMS
        strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';  // 070 - Valor da Base Calculo do ICMS
        strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';   // 071 - Alíquota do ICMS (sem FCP)
        strLinha := strLinha + fValor(item.fltIcmsOP, 15, 2) + '|';  // 072 - Valor do ICMS da Operação
        strLinha := strLinha + fValor(item.fltPerDif, 15, 4) + '|';  // 073 - Percentual do diferimento
        strLinha := strLinha + fValor(item.fltIcmDif, 15, 2) + '|';  // 074 - Valor do ICMS diferido
        strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';  // 075 - Valor do ICMS
      End
      Else If fCalculaDiferimentoTotalDeICMS Then
      Begin
        fltAliquotaIcmsOperacao  := fAliquotaIcmsUF(fonteDados, dadosGerais.strEstado);
        fltValorIcmsOperacao     := fFormataFloatInterna((item.fltTotIte * fltAliquotaIcmsOperacao) / 100, 2);

        strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';              // 066 - Origem da Mercadoria
        strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';             // 067 - CST – Tributação do ICMS
        strLinha := strLinha + '3|';                                          // 068 - Modalidade de determinação BC ICMS
        strLinha := strLinha + fValor( 0, 15, 2) + '|';                       // 069 - Percentual de Redução de BC ICMS
        strLinha := strLinha + fValor( item.fltTotIte, 15, 2) + '|';          // 070 - Valor da Base Calculo do ICMS
        strLinha := strLinha + fValor( fltAliquotaIcmsOperacao, 7, 4) + '|';  // 071 - Alíquota do ICMS (sem FCP)
        strLinha := strLinha + fValor( fltValorIcmsOperacao, 15, 2) + '|';    // 072 - Valor do ICMS da Operação
        strLinha := strLinha + fValor( 100, 15, 4) + '|';                     // 073 - Percentual do diferimento
        strLinha := strLinha + fValor( fltValorIcmsOperacao, 15, 2) + '|';    // 074 - Valor do ICMS diferido
        strLinha := strLinha + fValor( 0, 15, 2) + '|';                       // 075 - Valor do ICMS

        fltBasIcmDif := fltBasIcmDif + item.fltTotIte;
      End
      Else If dadosGerais.strEstado = 'EX' Then
      Begin
        fltValorIcmsOperacao  := fFormataFloatInterna(item.fltBasIcm * item.fltAlqIcm / 100, 2);
        fltValorIcmsDiferido  := IIF(item.fltValDif > 0, item.fltValDif, fltValorIcmsOperacao - item.fltValIcm);
        fltPercentualDiferido := IIF(item.fltPerDif > 0, item.fltPerDif, item.fltPerRed);

        strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';              // 066 - Origem da Mercadoria
        strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';             // 067 - CST – Tributação do ICMS
        strLinha := strLinha + '3|';                                          // 068 - Modalidade de determinação BC ICMS
        strLinha := strLinha + fValor(0, 15, 2) + '|';                        // 069 - Percentual de Redução de BC ICMS
        strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';           // 070 - Valor da Base Calculo do ICMS
        strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';            // 071 - Alíquota do ICMS (sem FCP)
        strLinha := strLinha + fValor(fltValorIcmsOperacao, 15, 2) + '|';     // 072 - Valor do ICMS da Operação
        strLinha := strLinha + fValor(fltPercentualDiferido, 15, 4) + '|';    // 073 - Percentual do diferimento
        strLinha := strLinha + fValor(fltValorIcmsDiferido, 15, 2) + '|';     // 074 - Valor do ICMS diferido
        strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';           // 075 - Valor do ICMS
      End
      Else
      Begin
        fltValorIcmsOperacao := 0;
        fltValorIcmsDiferido := 0;

        If item.strRICMPR='S' Then
        Begin
          fltValorIcmsOperacao  := fFormataFloatInterna(item.fltBasIcm * item.fltAlqIcm / 100, 2);
          fltValorIcmsDiferido  := IIF(item.fltValDif > 0, item.fltValDif, fltValorIcmsOperacao - item.fltValIcm);
          fltPercentualDiferido := IIF(item.fltPerDif > 0, item.fltPerDif, item.fltPerRed);

          If fEhDevolucaoParaFornecedor(item) Then
          Begin
            If (fltPercentualDiferido > 0) And (item.fltValDif > 0) Then
              fltValorIcmsDiferido := item.fltValDif
            Else
              fltValorIcmsDiferido := IIF(item.fltValDif > 0, fltValorIcmsOperacao - item.fltValDif, fltValorIcmsOperacao - item.fltValIcm);
          End;
        End;

        strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                                                 // 066 - Origem da Mercadoria
        strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                                                // 067 - CST – Tributação do ICMS
        strLinha := strLinha + '3|';                                                                             // 068 - Modalidade de determinação BC ICMS
        strLinha := strLinha + fValorCond(item.strRICMPR='S', 0, 15, 2) + '|';                                   // 069 - Percentual de Redução de BC ICMS
        strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltBasIcm, 15, 2) + '|';                      // 070 - Valor da Base Calculo do ICMS
        strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltAlqIcm, 7, 4) + '|';                       // 071 - Alíquota do ICMS (sem FCP)
        strLinha := strLinha + fValorCond(item.strRICMPR='S', fltValorIcmsOperacao, 15, 2) + '|';                // 072 - Valor do ICMS da Operação
        strLinha := strLinha + fValorCond(item.strRICMPR='S', fltPercentualDiferido, 15, 4) + '|';               // 073 - Percentual do diferimento
        strLinha := strLinha + fValorCond(item.strRICMPR='S', fltValorIcmsDiferido, 15, 2) + '|';                // 074 - Valor do ICMS diferido
        strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltValIcm, 15, 2) + '|';                      // 075 - Valor do ICMS
      End;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 10); // 66 - 75 - ICMS X51
    End;

    If (RightStr(item.strCodSit, 2) = '60') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 076 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 077 - CST – Tributação do ICMS

      If fEnviaDadosDeIcmsStRetido Then
      Begin
        strLinha := strLinha + fValor(item.fltBSTANT, 15, 2) + '|';                       // 078 - Valor da Base Calculo do ICMS ST – Retido
        strLinha := strLinha + fValor(item.fltVSTANT, 15 ,2) + '|';                       // 079 - Valor do ICMS ST – Retido

        fltBaseRetido  := fltBaseRetido  + item.fltBSTANT;
        fltValorRetido := fltValorRetido + item.fltVSTANT;
      End
      Else
      Begin
        strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                       // 078 - Valor da Base Calculo do ICMS ST – Retido
        strLinha := strLinha + fValor(item.fltValRet, 15 ,2) + '|';                       // 079 - Valor do ICMS ST – Retido
      End;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 4); // 76 - 79 - ICMS X60
    End;

    If (RightStr(item.strCodSit, 2) = '70') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 080 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 081 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                         // 082 - Modalidade de determinação BC ICMS (3-Valor da operação)
      strLinha := strLinha + fValor(item.fltPerRed, 7, 4) + '|';                           // 083 - Percentual de Redução de BC ICMS
      strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';                          // 084 - Valor da Base Calculo do ICMS
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                           // 085 - Alíquota do ICMS
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                          // 086 - Valor do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                        // 087 - Modalidade de determinação BC ICMS ST
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                           // 088 - Percentual da MVA
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                           // 089 - Percentual de Redução de BC ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 090 - Valor da Base Calculo do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                           // 091 - Alíquota do ICMS Subst.Trib. (sem FCP)
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 092 - Valor do ICMS Subst.Trib

      If (item.fltVrdIcm > 0) Then
      Begin
        fltTotalValorIcmsDesonerado := fltTotalValorIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                        // 093 - Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                       // 094 - Motivo da desoneração do ICMS
      End
      Else
        pSetaInformacoesDesonerado;

    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 15); // 80 - 94 - ICMS X70
    End;

    If (RightStr(item.strCodSit, 2) = '90') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 095 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 096 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                         // 097 - Modalidade de determinação
      strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';                          // 098 - Valor da Base Calculo do ICMS
      strLinha := strLinha + fValor(item.fltPerRed, 7, 4) + '|';                           // 099 - Percentual de Redução de BC ICMS
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                           // 100 - Alíquota do ICMS (sem FCP)
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                          // 101 - Valor do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                        // 102 - Modalidade de determinação BC ICMS Subt.Trib
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                           // 103 - Percentual da MVA – ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                           // 104 - Percentual de Redução de BC ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 105 - Valor da Base Calculo do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                           // 106 - Alíquota do ICMS Subst.Trib.
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 107 - Valor do ICMS Subst.Trib
      // desonerado 90 ?? (novo) ?
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 13); // 95 - 107 - ICMS X90
    End;

    strLinha := strLinha + fReplicatorStr('|', 15); // 108 - 122 - DADOS DE PARTILHA DE ICMS

    If (RightStr(item.strCodSit, 2) = '60') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And fEnviaDadosDeIcmsStRepasse Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 123 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 124 - CST – Tributação do ICMS

      strLinha := strLinha + fValor(item.fltBSTANT, 15, 2) + '|';                          // 125 - Informar o valor da BC do ICMS ST retido na UF remetente
      strLinha := strLinha + fValor(item.fltVSTANT, 15, 2) + '|';                          // 126 - Informar o valor do ICMS ST retido na UF remetente

      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 127 - Informar o valor da BC do ICMS ST da UF destino
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 128 - Informar o valor da BC do ICMS ST da UF destino

      fltBaseRetido  := fltBaseRetido  + item.fltBSTANT;
      fltValorRetido := fltValorRetido + item.fltVSTANT;
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 6);  // 123 - 128 - ICMS ST – repasse de ICMS ST retido anteriormente em operações interestaduais com repasses através do Substituto Tributário

   If strCstSimples = '101' Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 129 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 130 - CST – Tributação do ICMS
      If (dadosGerais.fltBasIcmSimples > 0) Then
      Begin
        strLinha := strLinha + fValor(item.fltAlqCreIcmSimples, 7, 4) + '|';                // 131 - Alíquota aplicável de cálculo do crédito (Simples Nacional).
        strLinha := strLinha + fValor(item.fltValCreIcmSimples, 15, 2) + '|';               // 132 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
      End
      Else
      Begin
        strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                          // 131 - Alíquota aplicável de cálculo do crédito (Simples Nacional).
        strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                         // 132 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
      End;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 4);  // 129 - 132 - ICMS SIMPLES X101
    End;

    If Pos(strCstSimples, '102, 103, 300, 400') > 0 Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 133 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 134 - CST – Tributação do ICMS
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 2);  // 133 - 134 - ICMS SIMPLES X102, X103, X300, X400
    End;

    If strCstSimples = '201' Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 135 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 136 - CST – Tributação do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                       // 137 - Modalidade de determinação BC ICMS ST
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                          // 138 - Percentual da margem de valor Adicionado do ICMS ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                          // 139 - Percentual da Redução de BC do ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                         // 140 - Valor da BC do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                          // 141 - Alíquota do imposto do ICMS ST
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                         // 142 - Valor do ICMS ST

      If (dadosGerais.fltBasIcmSimples > 0) Then
      Begin
        strLinha := strLinha + fValor(item.fltAlqCreIcmSimples, 7, 4) + '|';              // 143 - Alíquota aplicável de cálculo do crédito (SIMPLES NACIONAL).
        strLinha := strLinha + fValor(item.fltValCreIcmSimples, 15, 2) + '|';             // 144 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (SIMPLES NACIONAL)
      End
      Else
      Begin
        strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                        // 143 - Alíquota aplicável de cálculo do crédito (SIMPLES NACIONAL).
        strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                       // 144 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (SIMPLES NACIONAL)
      End;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 10);  // 133 - 134 - ICMS SIMPLES X201
    End;

    If Pos(strCstSimples, '202, 203') > 0 Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 145 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 146 - CST – Tributação do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                       // 147 - Modalidade de determinação BC ICMS ST
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                          // 148 - Percentual da margem de valor Adicionado do ICMS ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                          // 149 - Percentual da Redução de BC do ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                         // 150 - Valor da BC do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                          // 151 - Alíquota do imposto do ICMS ST
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                         // 152 - Valor do ICMS ST
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 8);  // 145 - 152 - ICMS SIMPLES X202, X203
    End;

    If strCstSimples = '500' Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 153 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 154 - CST – Tributação do ICMS

      If ((fCfgSisFonte(fonteDados, 'UTIE48') = 'S') And
          (dadosGerais.strEstado = dadosEmitente.strEstado) And (dadosGerais.strCliCon = 'N') And (item.fltVSTANT > 0)) Or fEnviaDadosDeIcmsStRepasse Then
      Begin
        strLinha := strLinha + fValor(item.fltBSTANT, 15, 2) + '|';                       // 155 - Valor da BC do ICMS ST
        strLinha := strLinha + fValor(item.fltVSTANT, 15 ,2) + '|';                       // 156 - Valor do ICMS ST

        fltBaseRetido  := fltBaseRetido  + item.fltBSTANT;
        fltValorRetido := fltValorRetido + item.fltVSTANT;
      End
      Else
      Begin
        strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                       // 155 - Valor da BC do ICMS ST
        strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                       // 156 - Valor do ICMS ST
      End;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 4);  // 153 - 156 - ICMS SIMPLES X500
    End;

    If strCstSimples = '900' Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 157 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 158 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                        // 159 - Modalidade de determinação da BC do ICMS
      strLinha := strLinha + fValor(item.fltBasIcm, 15, 2) + '|';                         // 160 - Valor da BC do ICMS
      strLinha := strLinha + fValor(item.fltPerRed, 7, 4) + '|';                          // 161 - Percentual da Redução de BC
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                          // 162 - Alíquota do imposto
      strLinha := strLinha + fValor(fRetornaValorDoIcmsSimplesNacional(item), 15, 2) + '|'; // 163 - Valor do ICMS
      strLinha := strLinha + fGetRegraMDBCST + '|';                                       // 164 - Modalidade de determinação da BC do ICMS ST
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                          // 165 - Percentual da margem de valor Adicionado do ICMS ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                          // 166 - Percentual da Redução de BC do ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                         // 167 - Valor da BC do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                          // 168 - Alíquota do imposto do ICMS ST
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                         // 169 - Valor do ICMS ST
      strLinha := strLinha + '0|';                                                        // 170 - Alíquota aplicável de cálculo do crédito (SIMPLES NACIONAL).
      strLinha := strLinha + '0|';                                                        // 171 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (SIMPLES NACIONAL)
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 15);  // 157 - 171 - ICMS SIMPLES X900
    End;

    If (IfEmptyStr(fCfgSisFonte(fonteDados, 'PAIORG'), 'S') = 'S') then
    Begin
      If (Pos(LeftStr(dadosGerais.strClaFis, 1), '7') > 0) Then
      Begin
        pSetarAnotacoesDadosItem('APLICACAO: ' + fSubstituirEnterPorEspaco(fTiraCaracEspeciais(item.strAplica)), item);
        pSetarAnotacoesDadosItem('PAÍS DE ORIGEM: BRASIL', item);
      End
      Else
      If (Pos(LeftStr(dadosGerais.strClaFis, 1), '3') > 0) Then
      Begin
        pSetarAnotacoesDadosItem('APLICACAO: ' + fSubstituirEnterPorEspaco(fTiraCaracEspeciais(item.strAplica)), item);
        pSetarAnotacoesDadosItem('CODIGO DO FORNECEDOR: ' + fTiraCaracEspeciais(item.strCForDi), item);
        pSetarAnotacoesDadosItem('PAÍS DE ORIGEM: ' + fTiraCaracEspeciais(fRetNomePais(fonteDados, dadosGerais.strCodigoPais)), item);
      End;
    End;

    strLinha := strLinha + LeftStr(item.strAnotacoes, 500) + '|';                         // 172 - Informações Adicionais Produto
    strLinha := strLinha + item.strPedCom   + '|';                                        // 173 - Numero do Pedido de Compra
    strLinha := strLinha + item.strNItemPed + '|';                                        // 174 - Numero do Item do Pedido de Compra
    strLinha := strLinha + '|';                                                           // 175 - Perc Desconto (Não Informar)

    If objConfigInterna.blnZeraIBPT Then
      strLinha := strLinha + '|'                                                          // 176 - Valor Total dos Tributos
    Else
      strLinha := strLinha + fValor(IIF(item.fltImpPag <> 0, item.fltImpPag,
                                                             item.fltMunImp +
                                                             item.fltEstImp +
                                                             item.fltFedImp), 15, 2)+'|'; // 176 - Valor Total dos Tributos

    strLinha := strLinha + item.strNumFCI + '|';                                          // 177 - Numero de controle da FCI – Ficha de Conteudo de Importação
    strLinha := strLinha + '|';                                                           // 178 - Número do RECOPI
    strLinha := strLinha + fValor(item.fltPerDevolvido, 5, 2) + '|';                      // 179 - Percentual da mercadoria devolvida

    If (fFormataFloat(item.fltPerDevolvido, 2) > 0) Then
    Begin
      strLinha := strLinha + fValor(item.fltValIpi + item.fltValIpiDadosAdicionais, 15, 2) + '|';  // 180 - Valor do IPI devolvido
      fltTotalIPIDevolvido := fltTotalIPIDevolvido + item.fltValIpi + item.fltValIpiDadosAdicionais;
    End
    Else
      strLinha := strLinha + '|';                                                         // 180 - Valor do IPI devolvido

    strLinha := strLinha + '|';                                                           // 181 - Valor do ICMS desonerado
    strLinha := strLinha + '|';                                                           // 182 - Motivo da desoneração do ICMS
    strLinha := strLinha + item.strCodigoCEST + '|';                                      // 183 - CEST (Código Especificador da Substituição Tributária)

    If (item.strEniEcb = 'S') Then
    Begin
      strLinha := strLinha + item.strIndEsc + '|';                                        // 184 - Indicador de Escala Relevante
      strLinha := strLinha + item.strCnpFab + '|';                                        // 185 - CNPJ do Fabricante da Mercadoria
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 2);

    strLinha := strLinha + fRetornoCodigoBeneficioFiscal + '|';                           // 186 - Código de Benefício Fiscal na UF aplicada ao Item

    If (item.fltValorIcmsDestino > 0) Then
    Begin
      strLinha := strLinha + fReplicatorStr('|', 64);                                     // 187 - 250 - Grupo FCP - Preenche vazio porque será enviado pela procedure pNFEProdutoICMSUFDestino
      strLinha := strLinha + fReformaTributariaRetornaValorTotalDoItem + '|';             // 251 - Valor total do Item, correspondente à sua participação no total da nota. A soma dos itens deverá corresponder ao total da nota.
    End
    Else
    Begin
      If  fProdutoIndustrializadoDentroDoEstado(fonteDados, DadosGerais, DadosEmitente, item) Or
          fProdutoRevendaDentroDoEstado(fonteDados, DadosGerais, DadosEmitente, item) Or
         (Pos(dadosGerais.strOpcDoc, 'OF_OU_OE_FE_BD_NG_') > 0) Or
         (dadosGerais.blnNfComp And dadosGerais.blnComplementoIcms) Or
         (dadosGerais.blnNfComp And dadosGerais.blnNFAjusteICMSaMaior) Or
         (fForcaSubTributariaEmDadosProprios(dadosGerais.strOpcDoc, item.fltValRet, item.fltValorFCP, item.fltValorFCPST)) Or
         (fGarantiaTemStOuFcpDeSt(dadosGerais.strOpcDoc, item.fltValRet, item.fltValorFCP, item.fltValorFCPST)) Or
         ( (fCalcBeneficioReducaoBase(fonteDados, DadosGerais, DadosEmitente) Or fCalculaFCPComReducaoBaseIcmsST(fonteDados, DadosGerais, DadosEmitente)) And (pos(fGetTipoAbreviacao(DadosGerais), 'CNC_TRS_') > 0) And
         (RightStr(item.strCodSit, 2) = '70') And ((item.fltValorFCP > 0) Or (item.fltValorFCPST > 0)) ) Then
      Begin
        If (Pos(RightStr(item.strCodSit, 2), '10_20_51_70_90_') > 0) And (fFormataFloat(item.fltBaseFCP, 2) > 0) And (item.fltValorFCP > 0) Then
        Begin
          strLinha := strLinha + fValor(item.fltBaseFCP, 15, 2) + '|';                        // 187 - Valor da Base de Cálculo do FCP
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 1);

        If (Pos(RightStr(item.strCodSit, 2), '00_10_20_51_70_90_') > 0) And (item.fltValorFCP > 0) And (fCfgSisFonte(fonteDados, 'SIMPAU') <> 'S') Then
        Begin
          strLinha := strLinha + fValor(item.fltPercentualFCP, 7, 4) + '|';                   // 188 - Percentual do Fundo de Combate à Pobreza (FCP)

          If fCalculaDiferimentoDeFCP Then
          Begin
            strLinha := strLinha + fValor(0, 15, 2) + '|';                                    // 189 - Valor do Fundo de Combate à Pobreza (FCP)
          End
          Else
          Begin
            strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                     // 189 - Valor do Fundo de Combate à Pobreza (FCP)
            fltAliqFCP_189 := item.fltPercentualFCP;
            fltTotalFCP_189 := fltTotalFCP_189 + item.fltValorFCP;
            fltTotalBaseFCP_189 := fltTotalBaseFCP_189 + item.fltBaseFCP;
          End;
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 2);

        If (item.fltValorFCPST > 0) Then
        Begin
          strLinha := strLinha + fValor(item.fltBaseFCPST, 15, 2) + '|';                        // 190 - Valor da Base de Cálculo do FCP retido por Substituição Tributária
          strLinha := strLinha + fValor(item.fltPercentualFCPST, 7, 4) + '|';                   // 191 - Percentual do FCP retido por Substituição Tributária
          strLinha := strLinha + fValor(item.fltValorFCPST, 15, 2) + '|';                       // 192 - Valor do FCP retido por Substituição Tributária
          fltAliqFCP_192 := item.fltPercentualFCPST;
          fltTotalFCP_192 := fltTotalFCP_192 + item.fltValorFCPST;
          fltTotalBaseFCP_192 := fltTotalBaseFCP_192 + item.fltBaseFCPST;
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 3);
      End
      Else
      Begin
        If (Pos(RightStr(item.strCodSit, 2), '10_20_51_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And
           (fFormataFloat(item.fltBaseFCP, 2) > 0) And (item.fltBasRet = 0) And (item.fltPercentualFCP > 0) Then
        Begin
          strLinha := strLinha + fValor(item.fltBaseFCP, 15, 2) + '|';                        // 187 - Valor da Base de Cálculo do FCP
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 1);

        If (Not fFcpST(item.fltPercentualFCP)) And ((Pos(RightStr(item.strCodSit, 2), '00_10_20_51_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And
           (fFormataFloat(item.fltPercentualFCP, 2) > 0)) And (Not fFcpVaiNoCampoDestino) Then
        Begin
          strLinha := strLinha + fValor(item.fltPercentualFCP, 7, 4) + '|';                   // 188 - Percentual do Fundo de Combate à Pobreza (FCP)

          If fCalculaDiferimentoDeFCP Then
          Begin
            strLinha := strLinha + fValor(0, 15, 2) + '|';                                    // 189 - Valor do Fundo de Combate à Pobreza (FCP)
          End
          Else
          Begin
            strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                     // 189 - Valor do Fundo de Combate à Pobreza (FCP)
            fltAliqFCP_189 := item.fltPercentualFCP;
            fltTotalFCP_189 := fltTotalFCP_189 + item.fltValorFCP;
            fltTotalBaseFCP_189 := fltTotalBaseFCP_189 + item.fltBaseFCP;
          End;
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 2);

        If (fFcpST(item.fltPercentualFCPST)) And
           (dadosGerais.blnNfComp Or (Not blnExisteMovIcd)) Then
        begin
          strLinha := strLinha + fValor(item.fltBaseFCPST, 15, 2) + '|';                      // 190 - Valor da Base de Cálculo do FCP retido por Substituição Tributária
          strLinha := strLinha + fValor(item.fltPercentualFCPST, 7, 4) + '|';                 // 191 - Percentual do FCP retido por Substituição Tributária
          strLinha := strLinha + fValor(item.fltValorFCPST, 15, 2) + '|';                     // 192 - Valor do FCP retido por Substituição Tributária
          fltAliqFCP_192 := item.fltPercentualFCPST;
          fltTotalFCP_192 := fltTotalFCP_192 + item.fltValorFCPST;
          fltTotalBaseFCP_192 := fltTotalBaseFCP_192 + item.fltBaseFCPST;
        end
        else
        begin
          If (fFcpST(item.fltPercentualFCP)) Then
          Begin
            strLinha := strLinha + fValor(item.fltBaseFCP, 15, 2) + '|';                        // 190 - Valor da Base de Cálculo do FCP retido por Substituição Tributária
            strLinha := strLinha + fValor(item.fltPercentualFCP, 7, 4) + '|';                   // 191 - Percentual do FCP retido por Substituição Tributária
            strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                       // 192 - Valor do FCP retido por Substituição Tributária
            fltAliqFCP_192 := item.fltPercentualFCP;
            fltTotalFCP_192 := fltTotalFCP_192 + item.fltValorFCP;
            fltTotalBaseFCP_192 := fltTotalBaseFCP_192 + item.fltBaseFCP;
          End
          Else
            strLinha := strLinha + fReplicatorStr('|', 3);
        end;
      End;

      If ((RightStr(item.strCodSit, 2) = '60') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False))) Or
         (strCstSimples = '500') Then
      Begin
        strLinha := strLinha + '' + '|';                                                    // 193 - Valor da Base de Cálculo do FCP retido anteriormente por Substituição Tributária
        strLinha := strLinha + '' + '|';                                                    // 194 - Percentual do FCP retido anteriormente por Substituição Tributária
        strLinha := strLinha + '' + '|';                                                    // 195 - Valor do FCP retido anteriormente por Substituição Tributária

        If fEnviaDadosDeIcmsStRetido Or fEnviaDadosDeIcmsStRepasse Then
          strLinha := strLinha + fValor(fAliquotaSuportadoPeloConsumidorFinal, 7, 4) + '|'  // 196 - Alíquota suportada pelo Consumidor Final
        Else
          strLinha := strLinha  + '' + '|';                                                 // 196 - Alíquota suportada pelo Consumidor Final

        If (fCfgSisFonte(fonteDados, 'UTIR48') = 'S') And
           ((dadosGerais.strEstado = dadosEmitente.strEstado) Or (dadosGerais.blnVenPre)) And (dadosGerais.strCliCon = 'S') And (item.fltVICMEF >= 0) Then
        Begin
          strLinha := strLinha + fValor(item.fltPICMEF,  7, 4) + '|';                       // 197 - Percentual de redução da base de cálculo efetiva
          strLinha := strLinha + fValor(item.fltBICMEF, 15, 2) + '|';                       // 198 - Valor da base de cálculo efetiva
          strLinha := strLinha + fValor(item.fltAICMEF,  7, 4) + '|';                       // 199 - Alíquota do ICMS efetiva
          strLinha := strLinha + fValor(item.fltVICMEF, 15, 2) + '|';                       // 200 - Valor do ICMS efetivo
          strLinha := strLinha + '' + '|';                                                  // 201 - Valor do ICMS Próprio do Substituto cobrado em operação anterior
          strLinha := strLinha + '' + '|';                                                  // 202 - Código de barras diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 203 - Código de barras da unidade tributária que seja diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 204 - Valor do ICMS-ST desonerado
          strLinha := strLinha + '' + '|';                                                  // 205 - Motivo da desoneração do ICMS-ST

          fltBaseEfetivo  := fltBaseEfetivo  + item.fltBICMEF;
          fltValorEfetivo := fltValorEfetivo + item.fltVICMEF;
        End

        Else If ((fCfgSisFonte(fonteDados, 'UTIE48') = 'S') And
                 ((dadosGerais.strEstado = dadosEmitente.strEstado) Or (dadosGerais.blnVenPre)) And (dadosGerais.strCliCon = 'N') And (item.fltSICMEF >= 0)) Or fEnviaDadosDeIcmsStRepasse Then
        Begin
          strLinha := strLinha + '' + '|';                                                  // 197 - Percentual de redução da base de cálculo efetiva
          strLinha := strLinha + '' + '|';                                                  // 198 - Valor da base de cálculo efetiva
          strLinha := strLinha + '' + '|';                                                  // 199 - Alíquota do ICMS efetiva
          strLinha := strLinha + '' + '|';                                                  // 200 - Valor do ICMS efetivo
          strLinha := strLinha + fValor(item.fltSICMEF, 15, 2) + '|';                       // 201 - Valor do ICMS Próprio do Substituto cobrado em operação anterior
          strLinha := strLinha + '' + '|';                                                  // 202 - Código de barras diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 203 - Código de barras da unidade tributária que seja diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 204 - Valor do ICMS-ST desonerado
          strLinha := strLinha + '' + '|';                                                  // 205 - Motivo da desoneração do ICMS-ST
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 9); // 196 - 205

      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 4); // 193 - 196 - ICMS X60

        If (Pos(RightStr(item.strCodSit, 2), '10_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And (item.fltVDesST > 0) Then
        Begin
          strLinha := strLinha + '' + '|';                                                  // 197 - Percentual de redução da base de cálculo efetiva
          strLinha := strLinha + '' + '|';                                                  // 198 - Valor da base de cálculo efetiva
          strLinha := strLinha + '' + '|';                                                  // 199 - Alíquota do ICMS efetiva
          strLinha := strLinha + '' + '|';                                                  // 200 - Valor do ICMS efetivo
          strLinha := strLinha + '' + '|';                                                  // 201 - Valor do ICMS Próprio do Substituto cobrado em operação anterior
          strLinha := strLinha + '' + '|';                                                  // 202 - Código de barras diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 203 - Código de barras da unidade tributária que seja diferente do padrão GTIN
          strLinha := strLinha + fValor(item.fltVDesST, 15, 2) + '|';                       // 204 - Valor do ICMS-ST desonerado
          strLinha := strLinha + item.strMDesST + '|';                                      // 205 - Motivo da desoneração do ICMS-ST
        End
        Else
        Begin
          strLinha := strLinha + '' + '|';                                                  // 197 - Percentual de redução da base de cálculo efetiva
          strLinha := strLinha + '' + '|';                                                  // 198 - Valor da base de cálculo efetiva
          strLinha := strLinha + '' + '|';                                                  // 199 - Alíquota do ICMS efetiva
          strLinha := strLinha + '' + '|';                                                  // 200 - Valor do ICMS efetivo
          strLinha := strLinha + '' + '|';                                                  // 201 - Valor do ICMS Próprio do Substituto cobrado em operação anterior
          strLinha := strLinha + '' + '|';                                                  // 202 - Código de barras diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 203 - Código de barras da unidade tributária que seja diferente do padrão GTIN
          strLinha := strLinha + '' + '|';                                                  // 204 - Valor do ICMS-ST desonerado
          strLinha := strLinha + '' + '|';                                                  // 205 - Motivo da desoneração do ICMS-ST
        End;
      End;

      If fCalculaDiferimentoDeFCP Then
      Begin
        If fCalculaDiferimentoTotalDeICMS Then
        Begin
          strLinha := strLinha + fValor(100, 15, 4) + '|';                                 // 206 - Percentual do diferimento do ICMS relativo ao Fundo de Combate a Pobreza FCP
          strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                    // 207 - Valor do ICMS relativo ao Fundo de Combate a Pobreza FCP diferido
          strLinha := strLinha + fValor(0, 15, 2) + '|';                                   // 208 - Valor efetivo do ICMS relativo ao Fundo de Combate a Pobreza FCP
        End
        Else If (item.fltPerRed > 0) Then
        Begin
          fltValorFcpDiferido := fFormataFloat(item.fltValorFCP * item.fltPerRed / 100, 2);
          fltValorFcpEfetivo  := (item.fltValorFCP - fltValorFcpDiferido);

          strLinha := strLinha + fValor(item.fltPerRed, 15, 4) + '|';                      // 206 - Percentual do diferimento do ICMS relativo ao Fundo de Combate a Pobreza FCP
          strLinha := strLinha + fValor(fltValorFcpDiferido, 15, 2) + '|';                 // 207 - Valor do ICMS relativo ao Fundo de Combate a Pobreza FCP diferido
          strLinha := strLinha + fValor(fltValorFcpEfetivo, 15, 2) + '|';                  // 208 - Valor efetivo do ICMS relativo ao Fundo de Combate a Pobreza FCP
        End;

        strLinha := strLinha + fReplicatorStr('|', 29);

        If (item.fltEnvPre = 'S') Then
        Begin
          If (RightStr(item.strCodSit, 2) = '51') Then
            strLinha := strLinha + fTiraCaracEspeciais(item.strCdbFis) + '|'                     // 238 - Código de Benefício Fiscal na UF aplicado ao item quando houver RBC
          Else
            strLinha := strLinha + '' + '|';                                                     // 238 - Código de Benefício Fiscal na UF aplicado ao item quando houver RBC

          If (item.fltValPre > 0) Then
          Begin
            strLinha := strLinha + fTiraCaracEspeciais(item.strCodPre) + '|';                    // 239 - Primeiro Código de Benefício Fiscal de Crédito Presumido na UF aplicado ao item
            strLinha := strLinha + fValor(item.fltPerPre, 15, 4) + '|';                          // 240 - Primeiro Percentual do Crédito Presumido
            strLinha := strLinha + fValor(item.fltValPre, 15, 2) + '|';                          // 241 - Primeiro Valor do Crédito Presumido
          End
          Else
            strLinha := strLinha + fReplicatorStr('|', 3);
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 4);
      End
      Else
      Begin
        strLinha := strLinha + fReplicatorStr('|', 26);

        If (RightStr(item.strCodSit, 2) = '61')  Then
        Begin
          strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 232 - Origem da Mercadoria
          strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 233 - CST – Tributação do ICMS
          strLinha := strLinha + fValor(item.fltBimRet, 15, 4) + '|';                          // 234 - Quantidade tributada retida anteriormente
          strLinha := strLinha + fValor(item.fltAimRet, 15, 4) + '|';                          // 235 - Alíquota ad rem do imposto retido anteriormente
          strLinha := strLinha + fValor(item.fltVimRet, 15, 2) + '|';                          // 236 - Valor do ICMS retido anteriormente

          fltTotalQtdeMonofasicoRetidoAnteriormente := fltTotalQtdeMonofasicoRetidoAnteriormente + item.fltBimRet;
          fltTotalIcmsMonofasicoRetidoAnteriormente := fltTotalIcmsMonofasicoRetidoAnteriormente + item.fltVimRet;
        End
        Else
          strLinha := strLinha + fReplicatorStr('|', 5);

        strLinha := strLinha + IIF(fInformaIndicadorDeDesoneracaoSuframa, '1','') +  '|';        // 237 - Indicador se o Valor do ICMS Desonerado Deduz do Valor total do item
        strLinha := strLinha + fReplicatorStr('|', 4);
      End;

      strLinha := strLinha + fReplicatorStr('|', 9);

      strLinha := strLinha + fReformaTributariaRetornaValorTotalDoItem + '|';                    // 251 - Valor total do Item, correspondente à sua participação no total da nota. A soma dos itens deverá corresponder ao total da nota.

    End;

    stlArquivo.Add(strLinha);

    If (Not blnInformarTagsObscontXCampoVendedor) Then
      blnInformarTagsObscontXCampoVendedor := fExibeTagsObscontXCampoVendedor(item);
  End;

  {$IF Defined(UNIDAC)}
  If Assigned(dicForTag) Then
    FreeAndNil(dicForTag);
  {$IFEND}
end;

procedure TNFEFit400.pNFETotal;
  Var
    strLinha: String;

  function fTotalTributos: Double;
    Var
      intContador: Integer;
      item: TDadosItem;
  begin
    Result := 0;

    If (pos(dadosGerais.strFinalidade, '5_6_') > 0) Then
      Exit;

    If objConfigInterna.blnZeraIBPT Then
      Exit;

    If Assigned(lstItens) Then
    Begin
      For intContador := 0 To lstItens.Count-1 Do
      Begin
        item := TDadosItem(lstItens[intContador]);
        Result := Result + IIF(item.fltImpPag <> 0, item.fltImpPag,
                                                    item.fltMunImp +
                                                    item.fltEstImp +
                                                    item.fltFedImp);
      End;
    End;
  end;

  function fImprimeIPIDadosProprios: Boolean;
  begin
    Result := untFuncoesLibNfe.fImprimeIPIDadosProprios(dadosGerais.strClaFis,
      objConfig.strClaVen, objConfig.strOpcImpValIpi, objConfig.blnConIpi);
  end;

  function fRetornaBaseDeIRRF: Double;
  begin
    Result := dadosGerais.fltTotPro;

    If not dadosGerais.blnOrgPub Then
      Exit;

    If (fCfgSisFonte(fonteDados, 'RETIPI') = 'S') Then
      Result := Result + dadosGerais.fltTotIpi;

    If not (fCfgSisFonte(fonteDados, 'RETLIQ') = 'S') Then
      Exit;

    Result := Result - dadosGerais.fltIcmOrg;
  end;

begin
  strLinha := '';
  strLinha := strLinha + 'NFE-TOTAL|';                                                                             // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                            // 002 - ID Referência
  strLinha := strLinha + fValor(dadosGerais.fltBasIcm + fltBasIcmDif, 15, 2) + '|';                                // 003 - Valor Total Base Calculo ICMS
  strLinha := strLinha + fValor(dadosGerais.fltTotIcm, 15, 2) + '|';                                               // 004 - Valor Total ICMS
  strLinha := strLinha + fValor(fltTotalValorIcmsDesonerado,15, 2) + '|';                                          // 005 - Valor Total do ICMS desonerado
  strLinha := strLinha + fValor(dadosGerais.fltBasRet, 15, 2) + '|';                                               // 006 - Valor Total Base Calculo ICMS ST
  strLinha := strLinha + fValor(dadosGerais.fltTotRet, 15, 2) + '|';                                               // 007 - Valor Total ICMS ST

  If (fFinalidadeEmissao = '2') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'IMPRNF'))) Or (fCfgSisFonte(fonteDados, 'IMPRNF') = '1') Then
    strLinha := strLinha + fValor(dadosGerais.fltTotPro, 15, 2) + '|'                                              // 008 - Valor Total dos Produtos e Serviços
  Else
    strLinha := strLinha + fValor(fltTotalProdutos, 15, 2) + '|';                                                  // 008 - Valor Total dos Produtos e Serviços

  strLinha := strLinha + fValor(dadosGerais.fltTotFre, 15, 2) + '|';                                               // 009 - Valor Total do Frete
  strLinha := strLinha + '0|';                                                                                     // 010 - Valor Total do Seguro

  If (((fFinalidadeEmissao = '2') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'IMPRNF'))) Or (fCfgSisFonte(fonteDados, 'IMPRNF') = '1'))) And
     (Not blnIcmsDesonerado) and
     (not blnIcmsDesoneradoX40) then
    strLinha := strLinha + fValor(dadosGerais.fltDesEsp, 15, 2) + '|'                                              // 011 - Valor Total do Desconto
  Else
    strLinha := strLinha + fValor(fltTotalDesconto, 15, 2) + '|';                                                  // 011 - Valor Total do Desconto

  strLinha := strLinha + fValor(fTotalImpostoImportacao, 15, 2) + '|' ;                                            // 012 - Valor Total do Imposto Importação
  strLinha := strLinha + fValor(fltTotalIPI, 15, 2) + '|';                                                         // 013 - Valor Total do IPI
  strLinha := strLinha + fValor(dadosGerais.fltValPis, 15, 2) + '|';                                               // 014 - Valor Total do PIS
  strLinha := strLinha + fValor(dadosGerais.fltValCof, 15, 2) + '|';                                               // 015 - Valor Total do COFINS

  If (Not fImprimeIPIDadosProprios) And (fltTotalIPIDevolvido > 0) Then
    strLinha := strLinha + fValor(dadosGerais.fltDesAce - fltTotalIPIDevolvido, 15, 2) + '|'                      // 016 - Valor Total Outras Despesas Aces.
  Else
    strLinha := strLinha + fValor(dadosGerais.fltDesAce, 15, 2) + '|';                                            // 016 - Valor Total Outras Despesas Aces.

  strLinha := strLinha + fValor(dadosGerais.fltTotGer, 15, 2) + '|';                                               // 017 - Valor Total NF-e
  strLinha := strLinha + IfThen(dadosGerais.fltTotSer > 0, fFormataValor(dadosGerais.fltTotSer, 15, 2), '') + '|'; // 018 - Valor Total dos Serviços
  strLinha := strLinha + IfThen(dadosGerais.fltTotSer > 0, fFormataValor(dadosGerais.fltBasIss, 15, 2), '') + '|'; // 019 - Valor Total Base Calculo ISS
  strLinha := strLinha + IfThen(dadosGerais.fltTotSer > 0, fFormataValor(dadosGerais.fltValIss, 15, 2), '') + '|'; // 020 - Valor Total ISS
  strLinha := strLinha + '|';                                                                                      // 021 - Valor Total do PIS (ISSQN)
  strLinha := strLinha + '|';                                                                                      // 022 - Valor Total do COFINS (ISSQN)
  strLinha := strLinha + fData(dadosGerais.dtaDtaEnt) + '|';                                                       // 023 - Data da prestação do serviço
  strLinha := strLinha + '|';                                                                                      // 024 - Valor dedução para redução da Base de Cálculo
  strLinha := strLinha + '|';                                                                                      // 025 - Valor retenção INSS
  strLinha := strLinha + '|';                                                                                      // 026 - Valor retenção IR
  strLinha := strLinha + '|';                                                                                      // 027 - Valor retenção CSLL
  strLinha := strLinha + '|';                                                                                      // 028 - Valor outras retenções
  strLinha := strLinha + '|';                                                                                      // 029 - Valor desconto incondicionado
  strLinha := strLinha + '|';                                                                                      // 030 - Valor desconto condicionado
  strLinha := strLinha + '2|';                                                                                     // 031 - Indicador de ISS retido
  strLinha := strLinha + '1|';                                                                                     // 032 - Indicador da exigibilidade do ISS (1 - Exigível)
  strLinha := strLinha + '|';                                                                                      // 033 - Código do serviço prestado dentro do município
  strLinha := strLinha + '|';                                                                                      // 034 - Código do Município de incidência do imposto
  strLinha := strLinha + '|';                                                                                      // 035 - Código do País onde serviço foi prestado
  strLinha := strLinha + '|';                                                                                      // 036 - Número do processo judicial ou administrativo de suspensão da exigibilidade
  strLinha := strLinha + '|';                                                                                      // 037 - Código do Regime Especial de Tributação
  strLinha := strLinha + '2|';                                                                                     // 038 - Indicador de incentivo Fiscal (2-Não)
  strLinha := strLinha + fValor(dadosGerais.fltPisRet, 15, 2) + '|';                                               // 039 - Valor Total Retido do PIS
  strLinha := strLinha + fValor(dadosGerais.fltCofRet, 15, 2) + '|';                                               // 040 - Valor Total Retido do COFINS
  strLinha := strLinha + fValor(dadosGerais.fltCslRet, 15, 2) + '|';                                               // 041 - Valor Total Retido de CSLL
  strLinha := strLinha + IfThen(dadosGerais.fltIrfRet > 0, fFormataValor(fRetornaBaseDeIRRF, 15, 2), '') + '|';    // 042 - Valor Total Base Calculo IRRF
  strLinha := strLinha + fValor(dadosGerais.fltIrfRet, 15, 2) + '|';                                               // 043 - Valor Total IRRF
  strLinha := strLinha + '|';                                                                                      // 044 - Valor Total Base Calculo Ret. Prev.
  strLinha := strLinha + '|';                                                                                      // 045 - Valor Total Retenção Prev. Social

  strLinha := strLinha + fValor(fTotalTributos, 15, 2) + '|';                                                      // 046 - Valor Total Aproximado do Tributos ( Lei Transparencia )

  strLinha := strLinha + fValor(fltTotalFCP, 15, 2) + '|';                                                         // 047 - Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) da UF de destino
  strLinha := strLinha + fValor(fltTotalIcmsInterestadualDestino, 15, 2) + '|';                                    // 048 - Valor do ICMS Interestadual para a UF de destino
  strLinha := strLinha + fValor(fltTotalIcmsInterestadualOrigem, 15, 2) + '|';                                     // 049 - Valor do ICMS Interestadual para a UF do remetente

  strLinha := strLinha + '|';                                                                                      // 050 - Valor Retenção ISS
  strLinha := strLinha + '|';                                                                                      // 051 - Valor Retencão Prev.Social

  If (fFormataFloat(fltTotalFCP_189, 2) > 0) Then
    strLinha := strLinha + fValor(fltTotalFCP_189, 15, 2) + '|'                                                    // 052 - Valor Total do FCP (Fundo de Combate à Pobreza)
  Else
    strLinha := strLinha + '' + '|';

  If (fFormataFloat(fltTotalFCP_192, 2) > 0) Then
    strLinha := strLinha + fValor(fltTotalFCP_192, 15, 2) + '|'                                                    // 053 - Valor Total do FCP (Fundo de Combate à Pobreza) retido por substituição tributária
  Else
    strLinha := strLinha + '' + '|';

  strLinha := strLinha + '' + '|';                                                                                 // 054 - Valor Total do FCP retido anteriormente por Substituição Tributária

  strLinha := strLinha + fValor(fltTotalIPIDevolvido, 15, 2) + '|';                                                // 055 - Valor Total do IPI devolvido

  strLinha := strLinha + '|';                                                                                      // 056 - Valor total da quantidade tributada do ICMS monofásico próprio
  strLinha := strLinha + '|';                                                                                      // 057 - Valor total do ICMS monofásico próprio
  strLinha := strLinha + '|';                                                                                      // 058 - Valor total da quantidade tributada do ICMS monofásico sujeito a retenção
  strLinha := strLinha + '|';                                                                                      // 059 - Valor total do ICMS monofásico sujeito a retenção
  strLinha := strLinha + fValor(fltTotalQtdeMonofasicoRetidoAnteriormente, 15, 2) + '|';                           // 060 - Valor total da quantidade tributada do ICMS monofásico retido anteriormente
  strLinha := strLinha + fValor(fltTotalIcmsMonofasicoRetidoAnteriormente, 15, 2) + '|';                           // 061 - Valor total do ICMS monofásico retido anteriormente

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFETrailler;
begin
  stlArquivo.Add('TRAILLER|' + IntToStr(stlArquivo.Count+1));
end;

procedure TNFEFit400.pNFETransporte;
  Var
    strLinha,
    strCgcTraAux,
    strIesTraAux,
    IdNfeFit_Aux,
    strModaliAux,
    strNomTraAux,
    strEndTraAux,
    strCidTraAux,
    strEstTraAux,
    strPlaVeiAux,
    strEstVeiAux,
    strC_AnttAux: String;

  function fModalidadeFrete: String;
  begin
    If (Not dadosGerais.blnTransfIcms) And
       (Not ((dadosGerais.blnNfComp) And (dadosGerais.blnVenPre))) And
       (Not ((dadosGerais.blnCreditoIcms) And (dadosGerais.blnVenPre))) Then
    Begin
      If dadosGerais.intTipFre = tfCif Then
        Result := '0'  // Por conta do Remetente
      Else If dadosGerais.intTipFre = tfFob Then
        Result := '1'  // Por conta do destinatário/remetente
      Else If dadosGerais.intTipFre = tfTerceiros Then
        Result := '2'  // Por conta de Terceiros
      Else If dadosGerais.intTipFre = tfTransporteProprioRemetente Then
        Result := '3'  // Transporte Próprio por conta do Remetente
      Else If dadosGerais.intTipFre = tfTransporteProprioDestinatario Then
        Result := '4'  // Transporte Próprio por conta do Destinatário
      Else
        Result := '9'; // Sem frete
    End
    Else
      Result := '9';
  end;
begin
  //MODALIDADE SEMPRE IRÁ NA NFE, DEMAIS CAMPOS SÓ SE O CNPJ DA TRANSPORTADORA FOR VÁLIDO
  strModaliAux := fModalidadeFrete;
  IdNfeFit_Aux := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  If fEnviaDadosTransportadora(strModaliAux) Then
  Begin
    strCgcTraAux := dadosGerais.strCgcTra;
    strNomTraAux := dadosGerais.strNomTra;
    strIesTraAux := dadosGerais.strIesTra;
    strEndTraAux := dadosGerais.strEndTra;
    strCidTraAux := dadosGerais.strCidTra;
    strEstTraAux := dadosGerais.strEstTra;
    strPlaVeiAux := dadosGerais.strPlaVei;
    strEstVeiAux := dadosGerais.strEstVei;
    strC_AnttAux := LeftStr(dadosGerais.strC_Antt, 20);
  End;

  If (fCfgSisFonte(fonteDados, 'TRACLI') = 'S') Then
  Begin
    If (fFinalidadeEmissao = FINALIDADE_DEVOLUCAO) And (strModaliAux = '4') Then
    Begin
      strCgcTraAux := dadosEmitente.strCnpj;
      strNomTraAux := LeftStr(dadosEmitente.strRazao, 60);
      strIesTraAux := dadosEmitente.strIES;
      strEndTraAux := dadosEmitente.strEndereco + IIF(Not fEmptyStr(dadosEmitente.strNumeroEnd), ', '+ dadosEmitente.strNumeroEnd, '');
      strCidTraAux := dadosEmitente.strNomeCidade;
      strEstTraAux := dadosEmitente.strEstado;
      strPlaVeiAux := '';
      strEstVeiAux := '';
      strC_AnttAux := '';
    End
    Else If (strModaliAux = '4') Or ((fFinalidadeEmissao = FINALIDADE_DEVOLUCAO) And (strModaliAux = '3')) Then
    Begin
      strCgcTraAux := dadosGerais.strCnpj;
      strNomTraAux := LeftStr(dadosGerais.strNomCli, 60);
      strIesTraAux := dadosGerais.strIES;
      strEndTraAux := LeftStr(dadosGerais.strLogradouroEndEnt, 60);
      strCidTraAux := dadosGerais.strNomCidEndEnt;
      strEstTraAux := dadosGerais.strEstadoEndEnt;
      strPlaVeiAux := '';
      strEstVeiAux := '';
      strC_AnttAux := '';
    End;
  End;

  strLinha := '';
  strLinha := strLinha + 'NFE-TRANSP|';       // 01 - Tipo do Registro
  strLinha := strLinha + IdNfeFit_Aux + '|';  // 02 - ID Referência
  strLinha := strLinha + strModaliAux + '|';  // 03 - Modalidade do Frete
  strLinha := strLinha + strCgcTraAux + '|';  // 04 - CNPJ / CPF Transportador
  strLinha := strLinha + strNomTraAux + '|';  // 05 - Razão Social ou Nome Transportador
  strLinha := strLinha + strIesTraAux + '|';  // 06 - Inscrição Estadual Transportador
  strLinha := strLinha + strEndTraAux + '|';  // 07 - Endereço Transportador
  strLinha := strLinha + strCidTraAux + '|';  // 08 - Município Transportador
  strLinha := strLinha + strEstTraAux + '|';  // 09 - UF Transportador
  strLinha := strLinha + '|';                 // 10 - Valor do Serviço
  strLinha := strLinha + '|';                 // 11 - Base Calculo Retenção ICMS
  strLinha := strLinha + '|';                 // 12 - Alíquota ICMS Retido
  strLinha := strLinha + '|';                 // 13 - Valor ICMS Retido
  strLinha := strLinha + '|';                 // 14 - CFOP Retenção
  strLinha := strLinha + '|';                 // 15 - Código Município Fator Gerador
  strLinha := strLinha + strPlaVeiAux + '|';  // 16 - Placa do Veiculo
  strLinha := strLinha + strEstVeiAux + '|';  // 17 - UF Placa Veiculo
  strLinha := strLinha + strC_AnttAux + '|';  // 18 - RNTC do Veiculo

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pNFETranspVolume;
  Var
    strLinha: String;
    strQtdTraTxt: String;
begin
  strQtdTraTxt := '';

  If fNotaDeComplemento Then
  Begin
    strQtdTraTxt := '0';
  End
  Else
  Begin
    If dadosGerais.intQtdTra > 0 Then
    Begin
      strQtdTraTxt := IntToStr(dadosGerais.intQtdTra);
    End
    Else
    Begin
      {************************************************************}
      {* ALTERAÇÃO PEDIDA PELO MÁRIO / RONALDO NO DIA 27/01/2015  *}
      {* O SISTEMA ESTÁ DEIXANDO PASSAR ZERO NO VOLUME. NÃO PODE. *}
      {* AINDA IRÃO FAZER AS CORREÇÕES NECESSÁRIAS NO AUTCOM.     *}
      {*********************************************************MV*}
      strQtdTraTxt := '1';
    End;
  End;

  strLinha := '';
  strLinha := strLinha + 'NFE-TRANSP-VOLUME|';                                                                     // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                            // 002 - ID Referência
  strLinha := strLinha + '1|'; // 003 - Nr.Item
  strLinha := strLinha + strQtdTraTxt + '|'; // 004 - Quantidade de Volumes
  strLinha := strLinha + dadosGerais.strEspTra + '|'; // 005 - Espécie dos Volumes Transportados
  strLinha := strLinha + dadosGerais.strMarTra + '|'; // 006 - Marca dos Volumes Transportados
  strLinha := strLinha + dadosGerais.strNumera + '|'; // 007 - Numeração dos Volumes Transportados

  If dadosGerais.fltPesLiq < 0.01 Then
    strLinha := strLinha + fFormataValor(dadosGerais.fltPesBru, 15, 3) + '|'  // 008 - Peso Liquido
  Else
    strLinha := strLinha + fFormataValor(dadosGerais.fltPesLiq, 15, 3) + '|'; // 008 - Peso Liquido

  strLinha := strLinha + fFormataValor(dadosGerais.fltPesBru, 15, 3);  // 009 - Peso Bruto

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400.pPrepararEmails;
  Var
    intPosEmail: Integer;
    strEmailPChar, strEmailTraPChar, strEmailTraRedPChar: {$IF Defined(VER250) Or Defined(UNIDAC)} PWideChar {$ELSE} PAnsiChar {$IFEND};
begin
  stlEmails.Clear;
  stlEmailsTra.Clear;
  stlEmailsTraRed.Clear;
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strEmailPChar    := PWideChar(fonteDados.fDadosGerais.strEmail);
    strEmailTraPChar := PWideChar(fonteDados.fDadosGerais.strEmaTra);
    strEmailTraRedPchar := PWideChar(fonteDados.fDadosGerais.strEmaTrr);
  {$ELSE}
    strEmailPChar    := PAnsiChar(fonteDados.fDadosGerais.strEmail);
    strEmailTraPChar := PAnsiChar(fonteDados.fDadosGerais.strEmaTra);
    strEmailTraRedPchar := PAnsiChar(fonteDados.fDadosGerais.strEmaTrr);
  {$IFEND};
  ExtractStrings([';'], [], strEmailPChar, stlEmails);

  intPosEmail := Pos(';', fonteDados.fDadosGerais.strEmail);
  If intPosEmail > 0 Then
  Begin
    fonteDados.fDadosGerais.strEmail := LeftStr(fonteDados.fDadosGerais.strEmail, intPosEmail-1);
  End;
  ExtractStrings([';'], [], strEmailTraPChar, stlEmailsTra);
  ExtractStrings([';'], [], strEmailTraRedPChar, stlEmailsTraRed);
end;

procedure TNFEFit400.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
  Var
    strIdNota: String;
begin
  pLogImp('TNFEFit400.pReimprimeDanfe('+strChaveAcesso+', '+strImpressora+IIF(fEmptyStr(strImprimirTelaPDF), '', ', '+strImprimirTelaPDF)+')');
  strIdNota := fRetornaIdNfeFit(objConfig.strCodEmp,
    Copy(strChaveAcesso, 26, 9), fonteDados.fDadosGerais.strSerie,
    fonteDados.fDadosGerais.strEspDoc);
  pImprimirDanfeInterna(strChaveAcesso, strImpressora, 1, strIdNota, False, 0, strImprimirTelaPDF);
end;

procedure TNFEFit400.pReimprimeDanfe(strChaveAcesso: String);
  Var
    strImpressora: String;
begin
  pLogImp('TNFEFit400.pReimprimeDanfe('+strChaveAcesso+')');
  strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
  pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
end;

procedure TNFEFit400.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TNFEFit400.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFEFit400.pExtraiDadosRetornoCartaCorrecao(const ARetornoFit: TWSNfeFitRetorno; var strProtocolo: String; var strMensagem: String);
begin
  If (Not AnsiStartsText('NFE-RET-CCE', ARetornoFit.Texto)) Then
    Exit;

  strMensagem  := fGetValorLinha(ARetornoFit.Texto, '|', 5);
  strProtocolo := fGetValorLinha(ARetornoFit.Texto, '|', 6);
end;

procedure TNFEFit400.pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
  Var intTipoEmissao: Integer; Var strChaveAcesso: String;
  Var intStatus: Integer; Var strMensagem: String;
  Var strProtocolo: String; Var dtaDataAut: TDateTime;
  Var blnRejeitadaRecusada: Boolean; Var blnContingencia: Boolean;
  Var strContingenciaAutorizada: String);
  Var
    strDataAut: String;
    strMsgValidacaoEstrutura: String;
    strNumeroRegistroEPEC: String;
begin
  blnRejeitadaRecusada := False;

  If AnsiStartsText('NFE-RET-ENVIO-DPEC', resultadoFit.Texto) Then
  Begin
    intTipoEmissao := TIPO_DPEC;
    strChaveAcesso := fGetValorLinha(resultadoFit.Texto, '|', 5);
    intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 3), -1);
    strMensagem := fGetValorLinha(resultadoFit.Texto, '|', 4);
    strDataAut := fGetValorLinha(resultadoFit.Texto, '|', 7);
    strProtocolo := fGetValorLinha(resultadoFit.Texto, '|', 6);
  End
  Else If AnsiStartsText('NFE-RET-CONS-SIT', resultadoFit.Texto) Then
  Begin
    intTipoEmissao := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 6), TIPO_NORMAL);
    strChaveAcesso := fGetValorLinha(resultadoFit.Texto, '|', 8);
    intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 10), -1);

    strMensagem := fGetValorLinha(resultadoFit.Texto, '|', 11);

    strProtocolo := fGetValorLinha(resultadoFit.Texto, '|', 12);
    strDataAut := fGetValorLinha(resultadoFit.Texto, '|', 13);

    If (fCountChar(resultadoFit.Texto, '|') >= 19) Then
      blnRejeitadaRecusada := (fGetValorLinha(resultadoFit.Texto, '|', 19) = '4');

    {*************************************************************}
    {* Conforme orientações do Leandro da FIT, para saber se a   *}
    {* Nota Fiscal em contingência foi autorizada, o número do   *}
    {* registro EPEC vai estar preenchido e a mensagem de Status *}
    {* vai ter a palavra Autorizado                              *}
    {**********************************************************BZ*}

    strNumeroRegistroEPEC := fGetValorLinha(resultadoFit.Texto, '|', 26);
    blnContingencia := not fEmptyStr(strNumeroRegistroEPEC);

    If (Not blnContingencia) Then
      blnContingencia := fEhSefazVirtualContingencia(intTipoEmissao);

    If (Not blnContingencia) Then
      blnContingencia := fNotaContingencia(intTipoEmissao);

    strContingenciaAutorizada := IIF( blnContingencia And (pos('Autorizado', strMensagem) > 0), 'S','N' );

  End
  Else
  Begin
    intTipoEmissao := TIPO_NORMAL;
    strChaveAcesso := fGetValorLinha(resultadoFit.Texto, '|', 7);
    intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 8), -1);

    strMensagem := fGetValorLinha(resultadoFit.Texto, '|', 10);
    strMsgValidacaoEstrutura := fGetValorLinha(resultadoFit.Texto, '|', 11);
    If Not fEmptyStr(strMsgValidacaoEstrutura) Then
    Begin
      strMensagem := strMensagem + #13#10 + strMsgValidacaoEstrutura;
    End;

    strProtocolo := fGetValorLinha(resultadoFit.Texto, '|', 12);
    strDataAut := fGetValorLinha(resultadoFit.Texto, '|', 13);
  End;

  dtaDataAut := StrToDateTimeDef(Copy(strDataAut, 01, 02) + '/' +
                          Copy(strDataAut, 03, 02) + '/' +
                          Copy(strDataAut, 05, 04) + ' ' +
                          Copy(strDataAut, 09, 02) + ':' +
                          Copy(strDataAut, 11, 02) + ':' +
                          Copy(strDataAut, 13, 02), 0);
end;

function TNFEFit400.fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno; arrStatusSucesso: Array Of Integer;
  intTipoEmissao: Integer; strChaveAcesso: String;
  intStatus: Integer; strMensagem: String;
  strProtocolo: String; dtaDataAut: TDateTime; blnIgnoraContingencia: Boolean;
  blnVerificarStatusEPEC: Boolean; blnRejeitadaRecusada: Boolean; blnProcessandoCancelamento: Boolean;
  blnContingencia: Boolean; strContingenciaAutorizada: String): TRetornoNFE;
  function fStatusArrSucesso: Boolean;
    Var
      intIndice: Integer;
  begin
    Result := False;
    For intIndice := Low(arrStatusSucesso) To High(arrStatusSucesso) Do
    Begin
      If intStatus = arrStatusSucesso[intIndice] Then
      Begin
        Result := True;
      End;
    End;

  end;
begin
  If (resultadoFit.RetornoOk) Then
  Begin
    If (fNotaContingencia(intTipoEmissao)) And (Not blnIgnoraContingencia) Then // (intStatus=RET_EVENTO_REGISTRADO_NAO_VINCULADO)
    Begin
      //Assumindo que acima de 200 somente tem erros nos status
      If (intStatus <= 200) Then
      Begin
        Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso, strProtocolo, dtaDataAut);
        Result.SetContingencia(True);
        Result.SetContingenciaAutorizada(strContingenciaAutorizada);
      End
      Else
        Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
    End
    Else If fStatusArrSucesso Then
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
        strProtocolo, dtaDataAut);
    End
    Else If (fStatusAguardando(intStatus)) Or
            ( (blnVerificarStatusEPEC) And (intStatus = RET_EVENTO_REGISTRADO_NAO_VINCULADO) ) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoAguardando;
    End

    Else If (blnProcessandoCancelamento) and (intStatus = RET_STATUS_AUTORIZADA) then
    begin
      Result := TRetornoNFE.fCriaRetornoAguardando;
    end

    Else
    Begin
      Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
      If (blnRejeitadaRecusada) Then
        result.SetRecusadaRejeitada;
    End;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
    If (blnRejeitadaRecusada) Then
      result.SetRecusadaRejeitada;
  End;
end;

function TNFEFit400.fItemServico(item: TDadosItem): Boolean;
begin
  Result := Pos(item.strClaFis, '5933_6933_1933_2933_') > 0;
end;

function TNFEFit400.fNotaContingencia(intTipoEmissao: Integer): Boolean;
begin
  {*******************************************************************************}
  {* 1 = Emissão normal (não em contingência)                                    *}
  {* 2 = Contingência FS-IA, com impressão do DANFE em formulário de segurança   *}
  {* 3 = Contingência SCAN (Sistema de Contingência do Ambiente Nacional)        *}
  {* 4 = Contingência DPEC (Declaração Prévia da Emissão em Contingência)        *}
  {* 5 = Contingência FS-DA, com impressão do DANFE em formulário de segurança   *}
  {* 6 = Contingência SVC-AN (SEFAZ Virtual de Contingência do AN)               *}
  {* 7 = Contingência SVC-RS (SEFAZ Virtual de Contingência do RS)               *}
  {* 8 = Contingência SVC-SP (SEFAZ Virtual de Contingência do SP)               *}
  {* 9 = Contingência off-line da NFC-e                                          *}
  {****************************************************************************BZ*}

  Result := (intTipoEmissao > 1);
end;

function TNFEFit400.fNotaDeComplemento: Boolean;
begin
  Result := (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE+','+FINALIDADE_COMPLEMENTAR) > 0) And
            (Not dadosGerais.blnEst_Dv) And (Not dadosGerais.blnNotEsp) And (Not dadosGerais.blnComVal) And
            (dadosGerais.strOpcDoc <> 'CA');

  If not Result Then
    Result := fNotaDeComplementoDebitoCredito;
end;

function TNFEFit400.fValorCampo(strNomeTabela, strNomeCampo: String;
  arrParametros: Array Of String; arrValores: Array Of Variant): Variant;
  Var
    intIndPar: Integer;
    strSQL  : String;
    qryAux  : TDataSet;
begin
  If fonteDados.fSuportaOperacaoBanco And
     fonteDados.fTabelaExiste(strNomeTabela) And
     fonteDados.fCampoExiste(strNomeTabela, strNomeCampo) Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + strNomeCampo;
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomeTabela;
    strSQL := strSQL + ' WHERE ';

    intIndPar := 0;

    While (intIndPar <= High(arrParametros)) Do
    Begin
      strSQL := strSQL + arrParametros[intIndPar] + ' = :' + arrParametros[intIndPar] + IIF(intIndPar = High(arrParametros), ' ', ' AND ');
      Inc(intIndPar);
    End;

    qryAux := fonteDados.fExecutaQuery(strSQL, arrParametros, arrValores);

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName(strNomeCampo).Value;

    FreeAndNil(qryAux);
  end;
end;

function TNFEFit400.fStatusAguardando(intStatus: Integer): Boolean;
  Var
    intIndice: Integer;
  Const
    RET_STATUS_AGUARDANDO: Array[1..10] Of Integer = (1, 2, 3, 103, 104, 105, 106, 204, 990, 9998);
begin
  Result := False;
  For intIndice := Low(RET_STATUS_AGUARDANDO) To High(RET_STATUS_AGUARDANDO) Do
  Begin
    If RET_STATUS_AGUARDANDO[intIndice] = intStatus Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TNFEFit400.fRetornaCSTSimples(dadosEmitente: TDadosEmitente;
  dadosGerais: TDadosGerais; dadosItem: TDadosItem; blnIteSer: Boolean): String;
  Var
    strCodSitTmp: String;
    strCstSimSubs: String;
    strCSOSNSubs: String;
begin
  If blnIteSer Then
  Begin
    Result := '';
    Exit;
  End;

  If Not fSimplesPaulista(dadosGerais, dadosEmitente, False) Then
  Begin
    Result := '';
    Exit;
  End;

  If (dadosGerais.strOpcDoc = 'OF') And (objConfig.blnSimPau) and (Pos(dadosItem.strClaFis, CFOP_DEVOLUCAO) > 0) And (dadosItem.fltValIcm > 0) Then
  Begin
    Result := '900';
    Exit;
  End;

  If (dadosGerais.strOpcDoc = 'OE') And (Pos(dadosEmitente.strREGTRI, 'S_M_') > 0) And (RightStr(dadosItem.strCodSit, 2) = '41') Then
  Begin
    Result := '102';
    Exit;
  End;

  strCstSimSubs := fGetCSTSimplesSub(dadosGerais,dadosEmitente, dadosItem);
  strCSOSNSubs  := fGetCSOSNSubstituicao(dadosGerais, dadosEmitente);

  strCodSitTmp := RightStr(dadosItem.strCodSit, 2);

  Result := '900';

  If (objConfig.blnSimPau) and (dadosItem.strProPCD = 'S') and ( Pos( strCodSitTmp, '00' ) > 0 ) then
  Begin
    Result := '300';
  End
  Else
  If (LeftStr(dadosGerais.strClaFis, 1) = '7') Then
  Begin
    Result := '300';
  End
  Else If (LeftStr(dadosGerais.strClaFis, 1) = '3') Then
  Begin
    Result := '900';
  End

  Else If (Pos(RightStr(dadosGerais.strClaFis, 3), CLASS_FISCAL_TRANSFER) > 0) And
          (LeftStr(dadosGerais.strClafis, 1) <= '5') And (dadosItem.fltValRet = 0) And
          (fTransferenciaDeveUsarCSOSN400) Then
  Begin
    Result := '400';
  End

  Else If Pos(strCodSitTmp, '00_20_') > 0 Then
  Begin
    If (objConfig.strCstSimTrib = '103') Then
    Begin
      Result := '103'
    End
    Else
    Begin
      If (fIndicadorIEDestinatario = '9') And
         (LeftStr(dadosGerais.strClafis, 1) >= '5') And
         (Pos(RightStr(dadosGerais.strClaFis, 3), '912_913_915_916_') <= 0) Then
      Begin
        Result := '102';
      End
      Else If (dadosGerais.strEspDoc = 'IF') Or
              (fEmptyStr(objConfig.strCstSimTrib)) Or
              (StrToIntDef(objConfig.strCstSimTrib, 102) = 102) Then
      Begin
        Result := '102'
      End
      Else
      Begin
        If (fIndicadorConsumidorFinal = '1') Then
          Result := '102' //Contribuinte e consumidor Final 102
        Else
          Result := '101' //Contribuinte e não consumidor Final 101
      End;
    End;
  End

  Else If (dadosItem.fltValRet > 0) And (dadosGerais.strZonFra = 'S') Then
    Result := '203'

  Else If Pos(strCodSitTmp, '40_50') > 0 Then
    Result := '103'

  Else If Pos(strCodSitTmp, '10_30_60_70') > 0 Then
  Begin
    If (Not fEmptyStr(strCSOSNSubs)) And (objConfig.strAPCSOS = 'S') Then
      Result := strCSOSNSubs
    Else If (strCodSitTmp = '30') Then
      Result := '103'
    Else If (fIndicadorIEDestinatario = '9') And
            (LeftStr(dadosGerais.strClafis, 1) >= '5') And
            (Pos(RightStr(dadosGerais.strClaFis, 3), '912_913_915_916_') <= 0) Then
    Begin
      Result := '500';
    End
    Else If Not fEmptyStr(strCstSimSubs) Then
    Begin
      If StrToIntDef(strCstSimSubs, 202) = 201 Then
        Result := '201'
      Else If StrToIntDef(strCstSimSubs, 202) = 202 Then
        Result := '202'
      Else
        Result := '500';
    End
    Else
      Result := '202';
  End

  Else If Pos(strCodSitTmp, '41_51') > 0 Then
  Begin
    If (objConfig.strCstSimTrib = '103') Then
      Result := '103'
    Else
      Result := '400'
  End

  Else If strCodSitTmp = '90' Then
  Begin
    If (fIndicadorIEDestinatario = '9') And // Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS.
       (RightStr(dadosItem.strClaFis, 3) = '910') Then // Bonificacao
    Begin
      Result := '400';
    End
    Else If (RightStr(dadosItem.strClaFis, 3) = '929') And // Confirmacao de Cupom
            ((objConfig.strCstSimTribCI) = '101')      Then
    Begin
      Result := '101';
    End
    Else
      Result := '900';
  End;

end;

function TNFEFit400.fDeterminaCSTIpi(item: TDadosItem; blnIteSer: Boolean): String;
begin

  Result := '';

  If blnIteSer Then
  Begin
    Result := '';
    Exit;
  End;

  If Not fEmptyStr(item.strCSTIpi) Then
  Begin
    Result := item.strCSTIpi;
    Exit;
  End;

  If (StrToIntDef(LeftStr(item.strClaFis, 1),0) < 5) Then
  Begin
    If objConfigInterna.blnCstIpiOutras Then
      Result := '49'
    Else
    Begin
      Result := '03';

      If item.fltValipi <> 0 Then
        Result := '00'
    End;
  End
  Else
  Begin
    If objConfigInterna.blnCstIpiOutras Then
      Result := '99'
    Else
    Begin
      Result := '53';

      If item.fltValipi <> 0 Then
        Result := '50'
    End;
  End;

end;

function TNFEFit400.fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
begin
  Result := Nil;
  Exit;

  Result := TLogPerformance.Create;
  Result.strOrigem := Self.ClassName;
  Result.strNumDoc := dadosGerais.strNumDoc;
  Result.strEspDoc := dadosGerais.strEspDoc;
  Result.strCodEmp := dadosGerais.strCodEmp;
  Result.strCodCli := dadosGerais.strCodCli;
  Result.strSerie := dadosGerais.strSerie;
  Result.strTipFc := '';
  Result.dtaHoraInicial := nOw();
  Result.intCodigo := intCodigo;
  Result.strMensagem := strMensagem;
end;

procedure TNFEFit400.pImprimirDanfeInterna(strChaveAcesso, strImpressora: String;
  intViasServidor: Integer; strIdNota: String; blnContingencia: Boolean;
  intTipoEmissao: Integer = 0; strImprimirTelaPDF: String = '');
  Var
    strNumDoc: String;
    strImpressoraPDF: String;
begin
  If fEmptyStr(strChaveAcesso) Then
  Begin
    Raise Exception.Create('A chave de acesso deve ser informada.');
  End;

  If fEmptyStr(objConfigInterna.strFitIntegradorImpressao) Then
  Begin
    strNumDoc := Copy(strChaveAcesso, 26, 9);

    if strImprimirTelaPDF = 'TelaPDF' then
    begin
      strImpressora := 'ImpressaoEmTelaPDF';
      fitWrapper.fDownloadDanfe(strChaveAcesso, fNumDocEnvio(strNumDoc), strImpressora,
        TMetodoImpressaoFactory.fCriarNotaFiscal('Tela'), intViasServidor, strIdNota,
        Nil, fonteDados, blnContingencia, intTipoEmissao, strImprimirTelaPDF);
    end
    else
    begin
      fitWrapper.fDownloadDanfe(strChaveAcesso, fNumDocEnvio(strNumDoc), strImpressora,
        TMetodoImpressaoFactory.fCriarNotaFiscal(''), intViasServidor, strIdNota, Nil, fonteDados, blnContingencia,
        intTipoEmissao, strImprimirTelaPDF);

      if (Assigned(fonteDados)) and
         (fonteDados.fTabelaExiste('PDFNFE')) then
      begin
        strImpressoraPDF := 'DownloadPDF';
        fitWrapper.fDownloadDanfe(strChaveAcesso, fNumDocEnvio(strNumDoc), strImpressoraPDF,
          TMetodoImpressaoFactory.fCriarNotaFiscal('Tela'), intViasServidor, strIdNota, Nil, fonteDados, blnContingencia,
          intTipoEmissao, 'PDF');
      end;
    end;
  End
  Else
  Begin
    With TImpressaoIntegradorLocal.Create(fitWrapper, objConfigInterna.strFitIntegradorImpressao,
      strImpressora) Do
    Begin
      pImprime(strIdNota);
    End;
  End;
end;

function TNFEFit400.fRetornaPontoImpressao(dadosGeraisArg: TDadosGerais): String;
begin
  Result := objConfig.strFitImpressoraPadrao;

  If (Not Assigned(dadosGeraisArg)) Then
    Exit;

  If fEmptyStr(dadosGeraisArg.strPontoImpressao) Then
    Exit;

  Result := dadosGeraisArg.strPontoImpressao;
end;

function TNFEFit400.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
  Var
    strImpressora : String;
    strCodEmp : String;
begin
  strImpressora := fRetornaPontoImpressao(dadosGeraisArg);

  strCodEmp := '';
  If (Assigned(dadosGeraisArg)) Then
    strCodEmp := dadosGeraisArg.strCodEmp;

  strImpressora := fAcharImpressoraPeloPonto(strImpressora, strCodEmp, fonteDados);
  Result := fIdentificarNomeDaImpressora(fonteDados, strImpressora);
end;

function TNFEFit400.fEhNotaDeComplementoDeIcmsDeCapa: Boolean;
begin
  Result := False;

  If not fSuportaOperacaoBanco(fonteDados) Then
    Exit;

  If Not Assigned(dadosGerais) Then
    Exit;

  If not fNotaDeComplemento Then
    Exit;

  If not dadosGerais.blnComplementoIcms Then
    Exit;

  If not (Length(dadosGerais.arrItensNfComp) = 0) Then
    Exit;

  Result := True;
end;

function TNFEFit400.fEhNotaDeAjusteDeIcmsMaior: Boolean;
begin
  Result := False;

  If not fSuportaOperacaoBanco(fonteDados) Then
    Exit;

  If Not Assigned(dadosGerais) Then
    Exit;

  If not fNotaDeComplemento Then
    Exit;

  If not dadosGerais.blnNFAjusteICMSaMaior Then
    Exit;

  If not (Length(dadosGerais.arrItensNfComp) = 0) Then
    Exit;

  Result := True;
end;

function TNFEFit400.fEhNotaDeComplementoDeFrete: Boolean;
begin
  Result := False;

  If not fSuportaOperacaoBanco(fonteDados) Then
    Exit;

  If Not Assigned(dadosGerais) Then
    Exit;

  If not fNotaDeComplemento Then
    Exit;

  If not dadosGerais.blnComplementoFrete Then
    Exit;

  If not (Length(dadosGerais.arrItensNfComp) = 0) Then
    Exit;

  Result := True;
end;

function TNFEFit400.fEhSefazVirtualContingencia(const intTipoEmissao: Integer): Boolean;
begin
  Result := False;

  if (intTipoEmissao = TIPO_SVC_AN) then
  begin
    Result := True;
    Exit;
  end;

  if (intTipoEmissao = TIPO_SVC_RS) then
  begin
    Result := True;
    Exit;
  end;
end;

function TNFEFit400.fEhDevolucaoParaFornecedorComIcmsDesoneradoX40(item: TDadosItem): Boolean;
begin
  Result := False;

  If Not (dadosGerais.strOpcDoc = 'OF') Then
    Exit;

  If Not fCfopDevolucao Then
    Exit;

  If (dadosGerais.strZonFra = 'S') And (dadosGerais.strDesZon = 'S') Then
    Exit;

  If Not ((item.fltVrdIcm > 0) and (RightStr(item.strCodSit, 2) = '40')) Then
    Exit;

  Result := True;
end;

procedure TNFEFit400.pIntegracaoPainelCitelNFe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFE');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFE_XML');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFE_PDF');
end;

procedure TNFEFit400.pIntegracaoPainelCitelNFeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFE_CANCELAMENTO');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFE_CANCELAMENTO_XML');
end;

procedure TNFEFit400.pIntegracaoPainelCitelNFeCartaCorrecao(AChaveAcesso, AProtocolo: String);
var
  qryAux : TDataSet;
  LSQL, LNumDoc, LEspDoc, LCodEmp, LSerie, LCodCli, LTip_FC: String;
begin
  LSQL := '';
  LSQL := LSQL + ' SELECT ';
  LSQL := LSQL + '  FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, FIS_SERIE_, FIS_FORCLI, FIS_TIP_FC ';
  LSQL := LSQL + ' FROM CADFIS ';
  LSQL := LSQL + ' WHERE FIS_ACESSO = :ACESSO ';

  qryAux := fonteDados.fExecutaQuery(LSQL, ['ACESSO'], [AChaveAcesso]);

  Try
    If (Not qryAux.IsEmpty) Then
    Begin
      LNumDoc := qryAux.FieldByName('FIS_NUMDOC').AsString;
      LEspDoc := qryAux.FieldByName('FIS_ESPDOC').AsString;
      LCodEmp := qryAux.FieldByName('FIS_CODEMP').AsString;
      LSerie  := qryAux.FieldByName('FIS_SERIE_').AsString;
      LCodCli := qryAux.FieldByName('FIS_FORCLI').AsString;
      LTip_FC := qryAux.FieldByName('FIS_TIP_FC').AsString;

      Self.fonteDados.pGravaDocumentoPainelCitel(LNumDoc, LEspDoc, LCodEmp, LSerie,  LCodCli, LTip_FC, AProtocolo, 'NFE_CARTA_CORRECAO');
      Self.fonteDados.pGravaDocumentoPainelCitel(LNumDoc, LEspDoc, LCodEmp, LSerie,  LCodCli, LTip_FC, AProtocolo, 'NFE_CARTA_CORRECAO_XML');
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TNFEFit400.fEhDevolucaoParaFornecedor(item: TDadosItem): Boolean;
begin
  Result := False;

  If Not (dadosGerais.strOpcDoc = 'OF') Then
    Exit;

  If Not fCfopDevolucao Then
    Exit;

  Result := True;
end;

function TNFEFit400.fEhDevolucaoParaFornecedorSimplesNacionalComDiferimento(item: TDadosItem): Boolean;
begin
  Result := False;

  If Not (dadosGerais.strOpcDoc = 'OF') Then
    Exit;

  If Not fCfopDevolucao Then
    Exit;

  If not objConfig.blnSimPau Then
    Exit;

  If not (fCfgSisFonte(fonteDados, 'ZERSIM') = 'S') Then
    Exit;

  If not (item.fltValDif > 0) Then
    Exit;

  Result := True;
end;

function TNFEFit400.fRetornaValorDoIcmsSimplesNacional(item: TDadosItem): Double;
begin
  Result := item.fltValIcm;

  If fEhDevolucaoParaFornecedorSimplesNacionalComDiferimento(item) Then
  Begin
    Result := item.fltValIcm - item.fltValDif;

    dadosGerais.fltTotIcm := dadosGerais.fltTotIcm - item.fltValDif;
  End;
end;

function TNFEFit400.fEhFornecedorTigreConfigurado(strCodFor: String): Boolean;
  Var
    qryForTag: TDataSet;
    strSQL: String;
begin
  Result := False;

  If (Not fonteDados.fTabelaExiste('FORTAG')) Then
  Begin
    Result := (Not fEmptyStr(fCfgSisFonte(fonteDados, 'DCTGOX'))) And
      (Trim(fCfgSisFonte(fonteDados, 'DCTGOX')) = strCodFor);
    Exit;
  End;

  {$IF Defined(UNIDAC)}
  If (Not Assigned(dicForTag)) Then
  Begin
    dicForTag := TDictionary<string, boolean>.Create;
    Try
      strSQL := ' SELECT                              '+
                '   CONCAT(FTG_CODEMP,"-",FTG_CODFOR) '+
                ' FROM                                '+
                '   FORTAG                            '+
                ' WHERE                               '+
                '   FTG_CODEMP = :CODEMP              ';

      qryForTag := fonteDados.fExecutaQuery(strSQL, ['CODEMP'], [dadosGerais.strCodEmp]);

      qryForTag.First;
      If (Not qryForTag.IsEmpty) Then
      Begin
        While Not qryForTag.Eof Do
        Begin
          dicForTag.AddOrSetValue(qryForTag.Fields[0].AsString, True);

          qryForTag.Next;
        End;
      End;
    Finally
      FreeAndNil(qryForTag);
    End;
  End;

  If (dicForTag.ContainsKey(dadosGerais.strCodEmp+'-'+strCodFor)) Then
    Result := True;
  Exit;
  {$IFEND}

  Try
    strSQL := ' SELECT                     '+
              '   FTG_CODFOR               '+
              ' FROM                       '+
              '   FORTAG                   '+
              ' WHERE                      '+
              '   FTG_CODEMP = :CODEMP AND '+
              '   FTG_CODFOR = :CODFOR     ';

    qryForTag := fonteDados.fExecutaQuery(strSQL, ['CODEMP', 'CODFOR'], [dadosGerais.strCodEmp, strCodFor]);

    If qryForTag.IsEmpty Then
      Exit;

    Result := True;
  Finally
    FreeAndNil(qryForTag);
  End;
end;

procedure TNFEFit400.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin

end;

function TNFEFit400.fConsultaStatusDFe(strChaveAcesso: string): String;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatus: Integer;
    strMensagem: String;
    strCancelado: String;

    stlArquivo: TStringList;
begin
  pLogImp('TNFEFit400.fConsultaStatusDFe >');

  If fEmptyStr(strChaveAcesso) Then
    Exit;

  retornoFit := fitWrapper.fConsultaStatusDFe('FIT_NFE_CONSULTA_CHAVE_ACESSO', strChaveAcesso);

  stlArquivo := TStringList.Create;
  Try
    stlArquivo.Text := retornoFit.Texto;
    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_RETORNO_STATUS_DFE.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  intStatus    := strToIntDef(fGetValorLinha(retornoFit.Texto, '|', 10), 0);
  strMensagem  := fGetValorLinha(retornoFit.Texto, '|', 11);
  strCancelado := fGetValorLinha(retornoFit.Texto, '|', 20);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);

  If (strCancelado = 'S') Then
  Begin
    Result := 'Cancelada';
    Exit;
  End;

  Case intStatus Of
    RET_STATUS_AUTORIZADA,
    RET_STATUS_AUTORIZADA_FORA_PRAZO,
    RET_STATUS_AUTORIZADA_FORA_PRAZO_2: Result := 'Autorizada';
  Else
    Result := strMensagem;
  End

end;

function TNFEFit400.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
  Var
    retornoFit: TWSNfeFitRetorno;
begin
  retornoFit := fitWrapper.fConsultaStatusCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie);
  Try
    If (fCountChar(retornoFit.Texto, '|') >= 5) Then
      Result := fGetValorLinha(retornoFit.Texto, '|', 5)
    Else
      Result := retornoFit.Texto;
  Finally
    FreeAndNil(retornoFit);
  End;
end;

function TNFEFit400.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;
  Var
    retornoFit : TWSNfeFitRetorno;
    intStatus : Integer;
    strNumeroInicial : String;
begin
  Try
    strNumeroInicial := IntToStr(StrToInt(strNumeroDocumento));
    retornoFit := fitWrapper.fConsultaSituacaoInutilizacao(strCnpjEmitente, strNumeroSerie, strNumeroInicial, strModeloFiscal);
    intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 16), 0);
    If (fEmptyStr(fGetValorLinha(retornoFit.Texto, '|', 7))) Then
      intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 5), 0);
    If (intStatus > 200) Then
    Begin
      If (fEmptyStr(fGetValorLinha(retornoFit.Texto, '|', 7))) Then
        Result := fGetValorLinha(retornoFit.Texto, '|', 6)
      Else
        Result := fGetValorLinha(retornoFit.Texto, '|', 8);
    End;
    If (intStatus = RET_INUTILIZACAO_OK) Or (intStatus = RET_INUTILIZACAO_OK_FIT) Then
      Result := 'Inutilizado';
  Except
    On E: Exception Do
      Result := 'Erro: ' + E.Message;
  End;
end;

procedure TNFEFit400.pDFeReformaTributaria;
begin
  ReformaTributaria.pReformaTributaria(dadosEmitente, dadosGerais, lstItens, stlArquivo);
end;

function TNFEFit400.fEstornoEntregaFutura: Boolean;
  Var
    qryCadFis : TDataSet;
begin
  Result := False;
  If (Not Assigned(fonteDados)) Then
    Exit;
  If (Length(dadosGerais.arrChavesReferenciadas) = 0) Then
    Exit;
  If fEmptyStr(dadosGerais.arrChavesReferenciadas[0].strChaveAcessoNfe) Then
    Exit;
  qryCadFis := fonteDados.fExecutaQuery('SELECT FIS_CLFSC1 FROM CADFIS WHERE FIS_ACESSO = :ACESSO', ['ACESSO'], [dadosGerais.arrChavesReferenciadas[0].strChaveAcessoNfe]);
  Try
    Result := (RightStr(qryCadFis.FieldByName('FIS_CLFSC1').AsString, 3) = '922');
  Finally
    FreeAndNil(qryCadFis);
  End;
end;

procedure TNFEFit400.pEnviarEventoInsucesso;
Var
  resultValidacao: TResultadoValidacao;
  retornoFit: TWSNfeFitRetorno;
  docRef: TChaveReferenciada;
  intIndice: Integer;
  strLinha: String;
  strRejeicao: String;
  strMensagem: String;
  blnFalhou: Boolean;

  function fResult: Boolean;
  var
    intStatus: Integer;
  begin
    intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 4), 0);
    Result := ((intStatus  = 135) Or (intStatus  = 573));
  end;

begin
  retornoFit := Nil;
  blnFalhou := False;

  If pos(dadosGerais.strFinalidade, '5_6_') > 0 Then
    Exit;

  If not (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
    Exit;

  If not fEmptyStr(fonteDados.fChaveAcesso) Then
    Exit;

  If not (fCfgSisFonte(fonteDados, 'USAINS') = 'S') Then
    Exit;

  pLogImp('TNFEFit400.pEnviarEventoInsucesso >');

  Try
    For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
    Begin
      docRef := dadosGerais.arrChavesReferenciadas[intIndice];

      If not (docRef.strTipoChave = DOCUMENTO_REF_NFe_Modelo_55) Then
        Continue;

      If fEmptyStr(docRef.strHashEntrega) Then
        Continue;

      strLinha :=            'NFE-INSUCESSO-ENTREGA|';
      strLinha := strLinha + '|';
      strLinha := strLinha + docRef.strChaveAcessoNfe + '|';
      strLinha := strLinha + fDataHora(nOw()) + '|';
      strLinha := strLinha + '|';
      strLinha := strLinha + '2|';
      strLinha := strLinha + '|';
      strLinha := strLinha + '|';
      strLinha := strLinha + '|';
      strLinha := strLinha + docRef.strHashEntrega + '|';
      strLinha := strLinha + fDataHora(nOw()) + '|';

      If Assigned(retornoFit) Then
        FreeAndNil(retornoFit);

      retornoFit := fitWrapper.fEnviaTextoIntegracao(strLinha, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

      If not fResult Then
      Begin
        strRejeicao := fGetValorLinha(retornoFit.Texto, '|', 5);
        strMensagem := IIF(fEmptyStr(strRejeicao), retornoFit.Texto, strRejeicao);
        blnFalhou := True;
        Break;
      End;
    End;

    If blnFalhou Then
    Begin
      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMensagem, Nil);
      pLogImp(strMensagem);
      Raise ErrosValidacaoNFE.Create(strMensagem, resultValidacao);
    End;

  Finally
    pLogImp('TNFEFit400.pEnviarEventoInsucesso <');

    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

function TNFEFit400.fRetornoEvento(const ARetornoFit: TWSNfeFitRetorno): TRetornoNFE;
var
  intStatus: Integer;
  strMensagem: String;
begin
  intStatus   := StrToIntDef(fGetValorLinha(ARetornoFit.Texto, '|', 4), 0);
  strMensagem := fGetValorLinha(ARetornoFit.Texto, '|', 5);

  If (intStatus > 0) Then
    strMensagem := IntToStr(intStatus) + ' - ' + strMensagem
  Else
    strMensagem := ARetornoFit.Texto;

  If (intStatus  = 135) Then
    Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, '', '', nOw())
  Else
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
end;

function TNFEFit400.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
var
  strLinha: String;
  strIdNota: String;
  retornoFit: TWSNfeFitRetorno;
  intStatus: Integer;
begin
  retornoFit := nil;
  Try
    strIdNota  := fRetornaIdNfeFit(strCodEmp, fNumDocEnvio(strNumDoc), strSerie, strEspDoc);
    retornoFit := fitWrapper.fConsultaSituacaoId(strIdNota);
    intStatus  := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 10), -1);

    If not (intStatus in [100, 135]) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoErro('Não é possível enviar o evento. Nota não está autorizada (status ' + IntToStr(intStatus) + ').');
      Exit;
    End;

    strLinha :=            'NFE-CONFIRMACAO-ENTREGA|';    // 01 - Tipo de Registro
    strLinha := strLinha + strIdNota +  '|';              // 02 - ID Referencia
    strLinha := strLinha + '|';                           // 03 - Numero da Chave de Acesso
    strLinha := strLinha + fDataHora(nOw()) + '|';        // 04 - Data e Hora da Entrega
    strLinha := strLinha + strDocumentoRecebedor + '|';   // 05 - Número do Documento do Recebedor
    strLinha := strLinha + strNomeRecebedor +  '|';       // 06 - Nome do Recebedor
    strLinha := strLinha + strLatitude + '|';             // 07 - Número Latitude
    strLinha := strLinha + strLongitude + '|';            // 08 - Númedo Longitude
    strLinha := strLinha + strHashEntrega + '|';          // 09 - Hash de Entrega
    strLinha := strLinha + strHashData + '|';             // 10 - Data/Hora Hash de Entrega

    pGrvArqTxt('ULTIMO_ENVIO_NFE_CONFIRMACAO_ENTREGA', strLinha);

    FreeAndNil(retornoFit);

    retornoFit := fitWrapper.fEnviaTextoIntegracao(strLinha, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

    pGrvArqTxt('ULTIMO_RETORNO_NFE_CONFIRMACAO_ENTREGA', retornoFit.Texto);

    Result := fRetornoEvento(retornoFit);

  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

function TNFEFit400.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
var
  strLinha: String;
  strIdNota: String;
  retornoFit: TWSNfeFitRetorno;
  intStatus: Integer;
begin
  retornoFit := nil;
  Try
    strIdNota  := fRetornaIdNfeFit(strCodEmp, fNumDocEnvio(strNumDoc), strSerie, strEspDoc);
    retornoFit := fitWrapper.fConsultaSituacaoId(strIdNota);
    intStatus  := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 10), -1);

    If not (intStatus in [100, 135]) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoErro('Não é possível enviar o evento. Nota não está autorizada (status ' + IntToStr(intStatus) + ').');
      Exit;
    End;

    strLinha :=            'NFE-CANCELAMENTO-CONFIRMACAO-ENTREGA|'; // 01 - Tipo de Registro
    strLinha := strLinha + strIdNota + '|';                         // 02 - ID Referencia
    strLinha := strLinha + '|';                                     // 03 - Numero da Chave de Acesso
    strLinha := strLinha + '|';                                     // 04 - Número Protocolo Comprovante de Entrega

    pGrvArqTxt('ULTIMO_ENVIO_NFE_CANCELAMENTO_CONFIRMACAO_ENTREGA', strLinha);

    FreeAndNil(retornoFit);

    retornoFit := fitWrapper.fEnviaTextoIntegracao(strLinha, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

    pGrvArqTxt('ULTIMO_RETORNO_NFE_CANCELAMENTO_CONFIRMACAO_ENTREGA', retornoFit.Texto);

    Result := fRetornoEvento(retornoFit);

  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

function TNFEFit400.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
var
  strLinha: String;
  strIdNota: String;
  retornoFit: TWSNfeFitRetorno;
  intStatus: Integer;
begin
  retornoFit := nil;
  Try
    strIdNota  := fRetornaIdNfeFit(strCodEmp, fNumDocEnvio(strNumDoc), strSerie, strEspDoc);
    retornoFit := fitWrapper.fConsultaSituacaoId(strIdNota);
    intStatus  := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 10), -1);

    If not (intStatus in [100, 135]) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoErro('Não é possível enviar o evento. Nota não está autorizada (status ' + IntToStr(intStatus) + ').');
      Exit;
    End;

    strLinha :=            'NFE-INSUCESSO-ENTREGA|';            // 01 - Tipo de Registro
    strLinha := strLinha + strIdNota +  '|';                    // 02 - ID Referencia
    strLinha := strLinha + '|';                                 // 03 - Numero da Chave de Acesso
    strLinha := strLinha +  fDataHora(nOw()) + '|';             // 04 - Data e Hora da Tentativa da Entrega ddMMyyyyHHmmss
    strLinha := strLinha + '|';                                 // 05 - Número da tentativa de entrega
    strLinha := strLinha + strMotivo +  '|';                    // 06 - Motivo do insucesso 1- Recebedor não encontrado; 2- Recusa do recebedor; 3- Endereço inexistente; 4- Outros (exige informar justificativa)
    strLinha := strLinha + strJustificativa + '|';              // 07 - Justificativa do Motivo de insucesso
    strLinha := strLinha + '|';                                 // 08 - Número Latitude
    strLinha := strLinha + '|';                                 // 09 - Númedo Longitude
    strLinha := strLinha + strHashEntrega + '|';                // 10 - Hash Tentativa de Entrega
    strLinha := strLinha + strHashData + '|';                   // 11 - Data/Hora Hash Tentativa de Entrega

    pGrvArqTxt('ULTIMO_ENVIO_NFE_INSUCESSO_ENTREGA', strLinha);

    FreeAndNil(retornoFit);

    retornoFit := fitWrapper.fEnviaTextoIntegracao(strLinha, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

    pGrvArqTxt('ULTIMO_RETORNO_NFE_INSUCESSO_ENTREGA', retornoFit.Texto);

    Result := fRetornoEvento(retornoFit);

  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

function TNFEFit400.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
var
  strLinha: String;
  strIdNota: String;
  retornoFit: TWSNfeFitRetorno;
  intStatus: Integer;
begin
  retornoFit := nil;
  Try
    strIdNota  := fRetornaIdNfeFit(strCodEmp, fNumDocEnvio(strNumDoc), strSerie, strEspDoc);
    retornoFit := fitWrapper.fConsultaSituacaoId(strIdNota);
    intStatus  := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 10), -1);

    If not (intStatus in [100, 135]) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoErro('Não é possível enviar o evento. Nota não está autorizada (status ' + IntToStr(intStatus) + ').');
      Exit;
    End;

    strLinha :=            'NFE-CANCELAMENTO-INSUCESSO-ENTREGA|'; // 01 - Tipo de Registro
    strLinha := strLinha + strIdNota + '|';                       // 02 - ID Referencia
    strLinha := strLinha + '|';                                   // 03 - Numero da Chave de Acesso
    strLinha := strLinha + '|';                                   // 04 - Número Protocolo CT-e
    strLinha := strLinha + '|';                                   // 05 - Número Protocolo Comprovante de Entrega

    pGrvArqTxt('ULTIMO_ENVIO_NFE_CANCELAMENTO_INSUCESSO_ENTREGA', strLinha);

    FreeAndNil(retornoFit);

    retornoFit := fitWrapper.fEnviaTextoIntegracao(strLinha, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

    pGrvArqTxt('ULTIMO_RETORNO_NFE_CANCELAMENTO_INSUCESSO_ENTREGA', retornoFit.Texto);

    Result := fRetornoEvento(retornoFit);

  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

end.
