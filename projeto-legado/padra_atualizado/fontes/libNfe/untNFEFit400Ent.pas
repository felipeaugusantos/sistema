unit untNFEFit400Ent;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Dialogs, Forms,
{$ENDIF}
  untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils,
  NfeApiWSBean, untConstantesNFe, Contnrs, untUtilFIT,
  Types, DB, MaskUtils;

Type
  TNFEFit400Ent = class(TInterfacedObject, INFE, INFEFit)
  private
    dadosEmitente: TDadosEmitente;
    dadosGerais: TDadosGerais;
    fonteDados: IFonteDados;
    fitWrapper: TWSNFeFitWrapper;
    stlArquivo: TStringList;

    lstItens: TObjectList;
    stlEmails: TStringList;

    fltTotalIcmsInterestadualDestino: Double;
    fltTotalIcmsInterestadualOrigem: Double;
    fltTotalIcmsDesonerado: Double;
    fltToTalDesconto: Double;
    fltToTalProdutos: Double;
    fltTotalFCP: Double;

    fltTotalFCP_189: Double;
    fltTotalFCP_192: Double;

    fltTotalIPIDevolvido : Double;
    fltTotalIPI: Double;

    blnIcmsDesonerado : Boolean;

    procedure pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
      var intTipoEmissao: Integer; var strChaveAcesso: String;
      var intStatus: Integer; var strMensagem, strProtocolo: String;
      var dtaDataAut: TDateTime);

    function fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno;
      arrStatusSucesso: array of Integer; intTipoEmissao: Integer;
      strChaveAcesso: String; intStatus: Integer; strMensagem,
      strProtocolo: String; dtaDataAut: TDateTime;
      blnIgnoraContingencia: Boolean; blnVerificarStatusEPEC: Boolean): TRetornoNFE;

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

    function fRetornaCSTSimples(dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais; dadosItem: TDadosItem;
      blnIteSer: Boolean): String;

    function fItemServico(item: TDadosItem): Boolean;
    function fDeterminaCSTIpi(item: TDadosItem; blnIteSer: Boolean): String;

    function fTotalImpostoImportacao: Double;

    function fFinalidadeEmissao: String;
    procedure pGerarConteudoNFe;
    function fCriaObjetoLogPerformance(intCodigo: Integer;
      strMensagem: String): TLogPerformance;
    procedure pImprimirDanfeInterna(strChaveAcesso, strImpressora: String;
      intViasServidor: Integer; strIdNota: String);
    function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;

    procedure pInserirDadosNFComplemento;
    procedure pPrepararEmails;
    function fCfopDevolucao: Boolean;
    function fIndicadorConsumidorFinal: String;
    function fIndicadorIEDestinatario: String;
    function fLocalDestinoOperacao: String;
    function fNotaDeComplemento: Boolean;
    function fValorCampo(strNomeTabela, strNomeCampo: String;
      arrParametros: Array Of String; arrValores: Array Of Variant): Variant;
  public
    function fEnviarNota: Boolean;
    function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
    function fRetXmlNfe(strChaveAcesso: string): string; overload;
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

uses untUtil, untFuncoesLibNfe, untDicSis;

Const
  FINALIDADE_DEVOLUCAO = '4';
  FINALIDADE_AJUSTE = '3';
  FINALIDADE_COMPLEMENTAR = '2';
  FINALIDADE_NORMAL = '1';

{ TNFEFit400Ent }

constructor TNFEFit400Ent.Create(fonteDados: IFonteDados);
begin
  Self.fCriaObjetoLogPerformance(0, ''); //Manter apenas apenas para forçar a compilação da função em desuso;

  Self.fonteDados := fonteDados;
  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);
  lstItens := TObjectList.Create(False);
  stlArquivo := TStringList.Create;
  stlEmails := TStringList.Create;
  blnIcmsDesonerado := False;
end;

destructor TNFEFit400Ent.Destroy;
begin
  lstItens.Clear;
  FreeAndNil(lstItens);
  FreeAndNil(fitWrapper);
  FreeAndNil(stlArquivo);
  FreeAndNil(stlEmails);
  inherited;
end;

function TNFEFit400Ent.fAtendeRegrasDifal(strOpcDoc: String): Boolean;
begin
  Result := (fIndicadorIEDestinatario = '9') And
            (fLocalDestinoOperacao = '2') And
            (fIndicadorConsumidorFinal = '1') And
            (Pos(strOpcDoc, 'CO_') <= 0);
end;

function TNFEFit400Ent.fCancelarNota(strNumDoc, strSerie,
  strMotivo: String): Boolean;
begin
  Result := fEnviaCancelamentoFit(fNumDocEnvio(strNumDoc), strSerie, dadosGerais.strCodEmp,
    fonteDados.fChaveAcesso, strMotivo, Self, fitWrapper, 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', '');
end;

function TNFEFit400Ent.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
  Result := ''
end;

function TNFEFit400Ent.fRetXmlNfe(strChaveAcesso: string): string;
begin
  Result := fitWrapper.fRetXMLNfe(strChaveAcesso);
end;

function TNFEFit400Ent.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
begin
  result := fitWrapper.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
end;


function TNFEFit400Ent.fCfopDevolucao: Boolean;
begin
  Result := False;
  If lstItens.Count > 0 Then
  Begin
    Result := Pos(TDadosItem(lstItens[0]).strClaFis, CFOP_DEVOLUCAO) > 0;
  End;
end;

function TNFEFit400Ent.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  Result := untUtilFIT.fConsultaCadastro(fitWrapper, strUf, strCnpj, strIe);
end;

function TNFEFit400Ent.fEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  Result := Nil;
end;

function TNFEFit400Ent.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := False;
End;

function TNFEFit400Ent.fData(const dta: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyy', dta);
end;

function TNFEFit400Ent.fDataHora(const dta: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyyhhnnss', dta);
end;

function TNFEFit400Ent.fEnviarNota: Boolean;
  Var
    retornoFit: TWSNfeFitRetorno;
    //strMsg: String;
    //resultValidacao: TResultadoValidacao;
    STATUS_OK: TIntegerDynArray;
    stlRetWS: TStringList;
begin
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
  fltTotalFCP := 0;
  fltTotalFCP_189 := 0;
  fltTotalFCP_192 := 0;
  fltTotalIPIDevolvido := 0;
  fltTotalIPI := 0;

  pInserirDadosNFComplemento;
  pGerarConteudoNFe;

  retornoFit := fitWrapper.fEnviaTextoIntegracao(stlArquivo.Text, '', 'FIT_NFE_ENVIA_TEXTO_NFE_TERCEIROS_LAYOUT', 8, STATUS_OK);

  Try
    stlArquivo.SaveToFile(fPnlDir('ULTIMA_NOTA.TXT'));
  Except

  End;

  Result := retornoFit.RetornoOk;

  stlRetWS := TStringList.Create;
  Try
    stlRetWS.Add(retornoFit.Texto);
    Try
      stlRetWS.SaveToFile(fPnlDir(objConfigInterna.strArqEnt));
    Except

    End;
  Finally
     FreeAndNil(stlRetWS);
  End;
end;

procedure TNFEFit400Ent.pGerarConteudoNFe;
  Var
    fltFatura : Double;
begin
  pPrepararEmails;

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
  pNFEProdutosServicos;
  pNFEProdutosIPI;
  pNFEProdutoPIS;
  pNFEProdutoCOFINS;
  pNFEProdutoISSQN;
  pNFEProdutoII;
  pNFEProdutoDeclaracaoImportacao;
  pNFEProdutoAdicoes;
  pNFEProdutoCombustiveis;
  pNFEProdutoICMSUFDestino;
  pNFETranspVolume;
  pNFEDadosAdicionais;
  pNFETotal;
  pNFEEmailCliente;
  pNFEAutorizacaoDownloadXml;
  pNFEInformacoesDePagamento;
  pNFETrailler;

  stlArquivo.Text := fTiraCaracEspeciais(stlArquivo.Text, False, False, False);
end;

function TNFEFit400Ent.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
  Var
    strTexto: String;
begin
  Result := TStringList.Create;
  strTexto := strCodEmp + '|' + FormatDateTime('ddmmyyyyhhnnss', dtaDtaIni) + '|' +
    FormatDateTime('ddmmyyyyhhnnss', dtaDtaFin+StrToTime('23:59:59')) + '|' +
    IntToStr(intTipo) + '|' + IntToStr(intStatus);

  fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_LISTA_NFE_PROPRIA_TIPO_EMISSAO_PERIODO');
  Result.Text := fitWrapper.strUltimoRetorno;
end;

function TNFEFit400Ent.fMensagemErro: String;
begin
  Result := '';
end;

function TNFEFit400Ent.fNotaAindaAutorizadaNaFit(strNumDoc, strSerie,
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
begin
  retornoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(strNumDoc), strSerie, strCodEmp);
  pExtraiDadosRetornoId(retornoFit, intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut);
  strCancelado := fGetValorLinha(retornoFit.Texto, '|', 20);

  Result := (intStatus = RET_STATUS_AUTORIZADA);
  If Not Result Then
  Begin
    Result := strCancelado <> 'S';
  End;
end;

function TNFEFit400Ent.fProcessarCancelamento: TRetornoNFE;
  Var
    resultadoFit: TWSNfeFitRetorno;
    intStatus: Integer;
    strMensagem: String;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    strIdNota: String;
begin

  Application.ProcessMessages;

  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  resultadoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strCodEmp);

  pExtraiDadosRetornoId(resultadoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut);

  Result := fGeraRetornoNFe(resultadoFit,
    [RET_CANCELAMENTO_HOMOLOGADO,
     RET_EVENTO_REGISTRADO,
     RET_STATUS_AUTORIZADA_FORA_PRAZO,
     RET_STATUS_AUTORIZADA_FORA_PRAZO_2,
     RET_STATUS_DUPLICIDADE_EVENTO], 1,
    strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, True, False);

  If Result.Sucesso Then
  Begin
    If Not Result.Contingencia Then
    Begin
      fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc), 'XMLNFE_CANCEL');
    End;
  End;

end;

function TNFEFit400Ent.fProcessarEnvio: TRetornoNFE;
  Var
    resultadoFit: TWSNfeFitRetorno;
    intStatus: Integer;

    strMensagem: String;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    intTipoEmissao: Integer;
    stlRet: TStringList;

    strIdNota: String;
begin

  Application.ProcessMessages;
  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  resultadoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strCodEmp);

  stlRet := TStringList.Create;
  Try
    stlRet.Add(resultadoFit.Texto);
    Try
      stlRet.SaveToFile(fPnlDir('ULTIMO_RETORNO.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlRet);
  End;

  Application.ProcessMessages;

  pExtraiDadosRetornoId(resultadoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut);

  Result := fGeraRetornoNFe(resultadoFit,
    [RET_STATUS_AUTORIZADA, RET_STATUS_AUTORIZADA_FORA_PRAZO, RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, False, False);

  If Result.Sucesso Then
  Begin
    If Not Result.Contingencia Then
    Begin
      fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc));
    End;

    Result.SetContingencia(False);

    Application.ProcessMessages;

    pImprimirDanfeInterna(Result.ChaveAcesso, fDefineImpressora(dadosGerais), 0, strIdNota);
  End;

  Application.ProcessMessages;
end;

function TNFEFit400Ent.fProcessarStatusNota: TRetornoNFE;
  Var
    strIdNota: String;
    resultadoFit: TWSNfeFitRetorno;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    intStatus: Integer;
    strMensagem: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
begin
  Application.ProcessMessages;
  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  resultadoFit := fitWrapper.fConsultaSituacaoId(fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strCodEmp);

  Application.ProcessMessages;

  pExtraiDadosRetornoId(resultadoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut);

  Result := fGeraRetornoNFe(resultadoFit,
    [RET_STATUS_AUTORIZADA, RET_STATUS_AUTORIZADA_FORA_PRAZO, RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, True, True);
end;

function TNFEFit400Ent.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;
end;

function TNFEFit400Ent.fTotalImpostoImportacao: Double;
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

function TNFEFit400Ent.fFinalidadeEmissao: String;
begin
  If (dadosGerais.blnCreditoIcms) Or (dadosGerais.blnTransfIcms) Or
     ( (Not fCfopDevolucao) And (dadosGerais.blnEst_DV) And (Not dadosGerais.blnComplementoIcms) ) Or
     (dadosGerais.blnRestituicaoIcms) Then
    Result := FINALIDADE_AJUSTE // 3-Ajuste
  Else If (dadosGerais.blnNfComp Or dadosGerais.blnComVal) And
          (dadosGerais.blnComplementoIcms Or dadosGerais.blnComplementoValor)Then
    Result := FINALIDADE_COMPLEMENTAR // 2-Complementar
  Else If (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
    Result := FINALIDADE_DEVOLUCAO // 4-Devolução
  Else
    Result := FINALIDADE_NORMAL; // 1-Normal
end;

function TNFEFit400Ent.fValor(const fltValor: Double; intPrecisao,
  intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TNFEFit400Ent.fValorCond(blnCondicao: Boolean; fltValor: Double;
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

function TNFEFit400Ent.fVerificarStatusNota: Boolean;
begin
  Result := True;
end;

function TNFEFit400Ent.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
var
  strRetornoConsulta: string;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

function TNFEFit400Ent.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

procedure TNFEFit400Ent.pAdicionaItem(dadosItem: TDadosItem);
begin
  lstItens.Add(dadosItem);
end;

procedure TNFEFit400Ent.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
  Var
    strTexto: String;
    intContador: Integer;
    retornoFit: TWSNfeFitRetorno;
    strMensagem: String;
    strNumDoc: String;
    intStatusOk: TIntegerDynArray;
begin
  SetLength(intStatusOk, 1);
  intStatusOk[0] := RET_EVENTO_REGISTRADO;

  strTexto := '';
  For intContador := 0 To stlCorrecoes.Count-1 Do
  Begin
    strTexto := strTexto + stlCorrecoes[intContador] + '#';
  End;

  strTexto := 'NFE-ENVIO-CCE|' +
              '|' +
              strChaveAcesso + '|' +
              strTexto + '|' +
              FormatDateTime('ddmmyyyyhhnnss', IncMinute(Now(), -5)) + '|' +
              IntToStr(intSequencial);


  retornoFit := fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', 4, intStatusOk);
  If Not retornoFit.RetornoOk Then
  Begin
    {**********************************************}
    {* DUPLICIDADE DE EVENTO, IRÁ CONSIDERAR COMO *}
    {* AUTORIZADO. PODE ACONTECER SE DER ALGUM    *}
    {* PROBLEMA NA IMPRESSÃO POR EXEMPLO          *}
    {******************************************MV**}
    If StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 4), -1) <> RET_STATUS_DUPLICIDADE_EVENTO Then
    Begin
      strMensagem := fGetValorLinha(retornoFit.Texto, '|', 5);
      Raise ErrosValidacaoNFE.fCriaErroSimples(strMensagem);
    End;
  End;

  strNumDoc := Copy(strChaveAcesso, 26, 9);
  fitWrapper.fDownloadDanfe(strChaveAcesso, fNumDocEnvio(strNumDoc), strImpressora,
    TMetodoImpressaoFactory.fCriarCartaCorrecao('CCe_'), 0, '');
end;

procedure TNFEFit400Ent.pInserirDadosNFComplemento;

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

  function fImprimeIPIDadosProprios: Boolean;
  begin
    Result := untFuncoesLibNfe.fImprimeIPIDadosProprios(dadosGerais.strClaFis,
      objConfig.strClaVen, objConfig.strOpcImpValIpi, objConfig.blnConIpi);
  end;

  function fImprimeSubTributariaDadosProprios: Boolean;
    Var
      strCfgRegSt : String;
      strClaSub : String;
  begin
    strCfgRegSt := fCfgRegimeSubstituicaoTributaria(fonteDados, fonteDados.fDadosGerais.strOpcDoc);

    If (strCfgRegSt <> 'CLASUB') Then
      strClaSub := fRegimeSubstituicaoTributaria(fonteDados, fonteDados.fDadosGerais.strOpcDoc)
    Else
      strClaSub := objConfig.strClaSub;

    Result := untFuncoesLibNfe.fImprimeSubTributariaDadosProprios(dadosGerais.strClaFis,
      objConfig.strClaVen, strClaSub, objConfig.blnSimPau);
  end;

begin
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
        fltAlqIpi := fFormataFloat(dadosGerais.fltTotIpi / dadosGerais.fltBasIpi * 100, 1);

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
           dadosGerais.blnRestituicaoIcms Then
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

      dadosItem.fltBasIcm := dadosGerais.fltBasIcm;

      If (dadosGerais.blnNfComp) And (dadosGerais.fltAlqIcm <> 0) Then
        dadosItem.fltAlqIcm := dadosGerais.fltAlqIcm
      Else
        dadosItem.fltAlqIcm := IfThen(dadosGerais.fltBasIcm <> 0, fFormataFloat((dadosGerais.fltTotIcm / (fltBasIcmDiv)*100), 1), 0);

      dadosItem.fltValIcm := dadosGerais.fltTotIcm;

      dadosItem.fltBasRet := dadosGerais.fltBasRet;
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

      If dadosGerais.fltTotIpi <> 0 Then
        dadosItem.strCSTIpi := '50'
      Else
        dadosItem.strCSTIpi := '53';

      dadosItem.fltBasIpi := dadosGerais.fltBasIpi;
      dadosItem.fltAlqIpi := fltAlqIpi;
      dadosItem.fltValIpi := dadosGerais.fltTotIpi;

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

        dadosItem.strCodIte := itemNfComp.strCodIte;
        dadosItem.strDesIte := itemNfComp.strDesIte;
        dadosItem.strClaIpi := itemNfComp.strClaIpi;
        dadosItem.strExcIpi := itemNfComp.strExcIpi;
        dadosItem.strCodigoCEST := itemNfComp.strCdCEST;

        dadosItem.strClaFis := itemNfComp.strClaFis;
        dadosItem.strUnidad := itemNfComp.strUnidad;
        dadosItem.strUnTrib := itemNfComp.strUnidad;
        dadosItem.fltQtdIte := 0;
        dadosItem.fltUnitar := 0;
        dadosItem.fltTotIte := 0;
        dadosItem.fltQtdTri := 0;
        dadosItem.fltUniTri := 0;
        dadosItem.fltDesAce := 0;

        If (dadosGerais.blnComplementoValor) And (itemNfComp.fltValCom > 0) Then
        Begin
          dadosItem.fltTotIte   := itemNfComp.fltValCom;
          dadosGerais.fltTotGer := dadosGerais.fltTotPro + dadosGerais.fltTotIpi + dadosGerais.fltTotRet + dadosGerais.fltDesAce;
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
        dadosItem.fltTotIte := dadosItem.fltTotIte + dadosItem.fltValIcm;

        //Zera o valor do icms no produto
        dadosItem.fltBasIcm := 0;
        dadosItem.fltValIcm := 0;
        dadosItem.fltAlqIcm := 0;
      End;

    End;

  End;
end;

procedure TNFEFit400Ent.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
  Var
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
    strMensagem: String;
    intStatus: Integer;
    intTentativas: Integer;
    intStatusOk: TIntegerDynArray;
begin
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

end;

function TNFEFit400Ent.fLocalDestinoOperacao: String;
begin
  If Pos(LeftStr(dadosGerais.strClaFis, 1), '1,5') > 0 Then
    Result := '1'  // Operação interna
  Else If Pos(LeftStr(dadosGerais.strClaFis, 1), '2,6') > 0 Then
    Result := '2'  // Operação interestadual
  Else
    Result := '3'; // Operação com exterior
end;

function TNFEFit400Ent.fIndicadorIEDestinatario: String;

  function fTemIESUni: Boolean;
  Begin
    Result:= (fonteDados.fCampoExiste('CADCLI', 'CLI_IESUNI'));
  End;

begin
  If (((Not fTemIESUni) And fEmptyStr(dadosGerais.strIES)) Or (fTemIESUni And fEmptyStr(dadosGerais.strIES) And (fonteDados.fDadosGerais.strIESUni = 'S'))) Or
      (Pos(fonteDados.fDadosGerais.strCodAti, objConfig.strVS_CliAti) > 0)                                                                                   Or
      ((fonteDados.fDadosGerais.strProdutorRural = 'S') And (Not fTemIESUni))                                                                                Or
      ((fonteDados.fDadosGerais.strProdutorRural = 'S') And (fTemIESUni) And (fonteDados.fDadosGerais.strIESUni = 'S'))                                      Then
    Result := '9'  // Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS.
  Else If fonteDados.fDadosGerais.strEstado = 'EX' Then
    Result := '1' // Contribuinte ICMS (informar a IE do destinatário);
  Else If Pos('ISENT', dadosGerais.strIES) > 0 Then
    Result := '2'  // Contribuinte isento de Inscrição no cadastro de Contribuintes do ICMS;
  Else
    Result := '1'; // Contribuinte ICMS (informar a IE do destinatário);
end;

function TNFEFit400Ent.fIndicadorConsumidorFinal: String;
begin
  Result := IfThen(dadosGerais.strCliCon <> 'S', '0', '1');
end;

procedure TNFEFit400Ent.pNFE;
  Var
    strLinha: String;

  function fIndicadorPresenca: String;
     Var
       strIdentPorCfg: String;
  begin
    strIdentPorCfg := fCfgSisFonte(fonteDados, 'HRIDLK');

    If (fonteDados.fDadosGerais.strEstado = 'EX') Or (dadosGerais.blnEntFat And (Not dadosGerais.blnVenPre)) Then
      Result := '9' // 9 – Operação não presencial, outros.
    Else If Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_COMPLEMENTAR) > 0 Then
      Result := '0' // 0 – Não se aplica (por exemplo, Nota Fiscal complementar ou de ajuste)
    Else If Not fEmptyStr(strIdentPorCfg) Then
      Result := strIdentPorCfg //HENRIMAR usa essa abordagem;
    Else If Not fEmptyStr(dadosGerais.strPedSit) Then
      Result := '2' // 2 – Operação não presencial, pela Internet;
    Else If Not fEmptyStr(dadosGerais.strNumPok) Then
      Result := '9' // 9 – Operação não presencial, outros.
    Else
      Result := '1'; // 1 – Operação presencial;

    // NOVA OPÇÃO: 5 – Operação presencial, fora do estabelecimento
  end;
begin
  strLinha := '';
  strLinha := strLinha + 'NFE|';                                                              // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
  strLinha := strLinha + dadosEmitente.strCnpj + '|';                                          // 03 - CNPJ Emitente

  If dadosGerais.blnEst_Dv Then
    strLinha := strLinha + LeftStr('999 - Estorno de NF-e não cancelada no prazo legal', 60) + '|'   // 04 - Natureza da Operação
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

  strLinha := strLinha + dadosGerais.strCnpj + '|';                                            // 20 - CNPJ/CPF Destinatário
  strLinha := strLinha + '00000|';                                                             // 21 - Identificação do destinatário no caso de comprador estrangeiro
  strLinha := strLinha + LeftStr(dadosGerais.strNomCli, 60) + '|';                             // 22 - Razão Social ou Nome do Destinatário
  strLinha := strLinha + '|';                                                                  // 23 - Nome Fantasia do Destinatário
  strLinha := strLinha + dadosGerais.strLogradouro + '|';                                      // 24 - Logradouro Destinatário
  strLinha := strLinha + dadosGerais.strNumeroEnd + '|';                                       // 25 - Número Logradouro Destinatário
  strLinha := strLinha + dadosGerais.strComplementoEnd + '|';                                  // 26 - Complemento Logradouro Destinatário
  strLinha := strLinha + dadosGerais.strBairro + '|';                                          // 27 - Bairro Destinatário
  strLinha := strLinha + dadosGerais.strCodIbge + '|';                                         // 28 - Código IBGE do Município Destinatário
  strLinha := strLinha + dadosGerais.strCEP + '|';                                             // 29 - CEP Destinatário
  strLinha := strLinha + dadosGerais.strCodigoPais + '|';                                      // 30 - Código BACEN Pais Destinatário
  strLinha := strLinha + dadosGerais.strTelefone + '|';                                        // 31 - Telefone Destinatário
  strLinha := strLinha + fIndicadorIEDestinatario + '|';                                       // 32 - Indicador da IE do Destinatário
  strLinha := strLinha + IfThen(Pos(fIndicadorIEDestinatario, '19') > 0, dadosGerais.strIES, '') + '|'; // 33 - Inscrição Estadual Destinatário
  strLinha := strLinha + dadosGerais.strSuframa + '|';                                         // 34 - Inscrição Suframa Destinatário
  strLinha := strLinha + '|';                                                                  // 35 - Inscrição Municipal do Tomador do Serviço (não é obrigatório)
  strLinha := strLinha + dadosGerais.strEmail + '|';                                           // 36 - e-mail destinatário
  strLinha := strLinha + '|';                                                                  // 37 - Numero do Pedido
  strLinha := strLinha + '|';                                                                  // 38 - Carga / Rota
  strLinha := strLinha + dadosEmitente.strIESST + '|';                                         // 39 - Inscrição Estadual S.T.
  strLinha := strLinha + fontedados.fChaveAcesso + '|';                                        // 40 - Chave de Acesso

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400Ent.pNFEAutorizacaoDownloadXml;
  Var
    strLinha : String;
begin
  If (Not dadosGerais.blnTemItemTigre) Or (fCfgSisFonte(fonteDados, 'AUTCGC') = dadosGerais.strCnpj) Then
    Exit;

  strLinha := '';
  strLinha := strLinha + 'NFE-PESSOA-DOWNLOAD-XML|';                                                  // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                         IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
  strLinha := strLinha + '1|';                                                                        // 03 - Número do Item
  strLinha := strLinha + fCfgSisFonte(fonteDados, 'AUTCGC');                                          // 04 - CPF/CNPJ Destinatário

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400Ent.pNFEInformacoesDePagamento;
  Var
    strLinha : String;
    intContador : Integer;
    fltValor : Double;
begin
  If (Length(dadosGerais.arrFormasPagamento) <= 0) Then
    Exit;

  For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
  Begin
    strLinha := '';
    strLinha := strLinha + 'NFE-FORMA-PAGAMENTO|';                                                      // 01 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                           IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência

    strLinha := strLinha + IntToStr(intContador+1) + '|';                                               // 03 - Número do Item

    fltValor := dadosGerais.arrFormasPagamento[intContador].fltValor;

    If (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_DEVOLUCAO) > 0) Or (Length(dadosGerais.arrDuplicatas) <= 0) Then
    Begin
      strLinha := strLinha + '90' + '|';
      fltValor := 0;
    End
    Else
      strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].strCodigo + '|'; // 14, 04 - Forma de Pagamento

    strLinha := strLinha + fValor(fltValor, 15, 2) + '|';                                               // 05 - Valor do Pagamento
    strLinha := strLinha + fValor(0, 15, 2) + '|';                                                      // 06 - Valor do Troco
    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400Ent.pNFEDadosAdicionais;
  Var
    strTexto: String;
    stlMensagens: TStringList;
    intContador: Integer;
    strLinha: String;
    intLinha: Integer;

    procedure pAddMensagem(strMsg: String='');
    Begin
      If fEmptyStr(strMsg) Then
      Begin
        strMsg := stlMensagens[intContador];
      End;

      If Not fEmptyStr(strMsg) Then
      Begin
        strLinha := '';
        strLinha := strLinha + 'NFE-DADOS-ADIC|';                                                 // 01 - Tipo do Registro
        strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                               IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
        strLinha := strLinha + IntToStr(intLinha) + '|';                                          // 03 - Número da Linha ( Sequencial )
        strLinha := strLinha + strMsg + '|';                                                      // 04 - Informações Adicionais

        stlArquivo.Add(strLinha);
        Inc(intLinha);
      End;
    End;
begin
  stlMensagens := TStringList.Create;

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

  FreeAndNil(stlMensagens);

  If (fAtendeRegrasDifal(dadosGerais.strOpcDoc) And (Not dadosGerais.blnVenPre)) Then
  Begin
    If intLinha < 500 Then
    Begin
      intLinha := 500;
    End;

    If (fCfgSisFonte(fonteDados, 'SIMPAU') = 'S') And
       (fCfgSisFonte(fonteDados, 'DIFREM') = 'N') And
       (fCfgSisFonte(fonteDados, 'DIFDES') = 'N') Then
    Begin
      pAddMensagem('NÃO APLICA DIFAL DA EMENDA CONSTITUCIONAL 87/2015 – CONFORME ADI N.º 5.464.');
    End
    Else
    Begin
      pAddMensagem('Valor do ICMS DIFAL devido a UF de origem: R$' + FloatToStrF(fltTotalIcmsInterestadualOrigem, ffNumber, 12, 2));
      pAddMensagem('Valor do ICMS DIFAL devido a UF de destino: R$' + FloatToStrF(fltTotalIcmsInterestadualDestino, ffNumber, 12, 2));
    End;
  End;

  If fltTotalFCP > 0 Then
    pAddMensagem('Valor do Fundo de Combate a Pobreza: R$' + FloatToStrF(fltTotalFCP, ffNumber, 12, 2));

  If (blnIcmsDesonerado) Then
    pAddMensagem('ICMS DESONERADO: R$' + FloatToStrF(fltTotalIcmsDesonerado, ffNumber, 12, 2));
end;

procedure TNFEFit400Ent.pNFEDuplicata(Var fltFatura: Double);
  Var
    strLinha: String;
    intCont: Integer;
    intNDup : Integer;
begin
  fltFatura := 0;
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

      strLinha := '';
      strLinha := strLinha + 'NFE-DUPLICATA|';                                                 // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                             IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
      strLinha := strLinha + fStrZero(intNDup, 3) + '|';                                       // 03 - Número da Duplicata
      strLinha := strLinha + fData(dadosGerais.arrDuplicatas[intCont].dtaDtaVen) + '|';        // 04 - Data de Vencimento
      strLinha := strLinha + fValor(dadosGerais.arrDuplicatas[intCont].fltValDup, 15, 2) + '|';// 05 - Valor da Duplicata
      fltFatura := fltFatura + fFormataFloat(dadosGerais.arrDuplicatas[intCont].fltValDup, 2);

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEECFReferenciado;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin
  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If docRef.strTipoChave = DOCUMENTO_REF_ECF Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-REF-ECF|';                                                 // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                             IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
      strLinha := strLinha + docRef.strModeloDocFiscalIF + '|';                              // 03 - Modelo
      strLinha := strLinha + fStrZero(docRef.strNumOrdSequencialECF, 3) + '|';               // 04 - Numero ECF
      strLinha := strLinha + RightStr(docRef.strNumeroCOO,6) + '|';                                      // 05 - Numero COO

      stlArquivo.Add(strLinha);
    End;
  End;

end;

procedure TNFEFit400Ent.pNFEEDadosExportacao;
  Var
    strLinha: String;
begin
  Try
    If fEmptyStr(dadosGerais.strUFEmba) Then
      Exit ;

    strLinha := '';
    strLinha := strLinha + 'NFE-EXPORT|';                                                        // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                           IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';  // 002 - ID Referência
    strLinha := strLinha + dadosGerais.strUFEmba + '|';                                          // 003 - UF Embarque ou de transposição de fronteira
    strLinha := strLinha + dadosGerais.strLoEmba + '|';                                          // 004 - Local de Embarque ou de transposição de fronteira
    strLinha := strLinha + dadosGerais.strLocDes + '|';                                          // 005 - Descrição do local de despacho - Informação do Recinto Alfandegado

    stlArquivo.Add(strLinha);
  Except

  End;
end;

procedure TNFEFit400Ent.pNFEEletronicaReferenciada;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin
  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If (docRef.strTipoChave = DOCUMENTO_REF_NFe_Modelo_55) Or
       (docRef.strTipoChave = DOCUMENTO_REF_NFCE) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-REF-NFE|';                                                // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                             IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
      strLinha := strLinha + docRef.strChaveAcessoNfe + '|';                                 // 03 - Número da Chave Acesso Referenciada

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEEmailCliente;
  Var
    strLinha: String;
    intContador: Integer;
begin
  For intContador := 0 To stlEmails.Count -1 Do Begin
    If (Not fEmptyStr(stlEmails[intContador])) Then Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-EMAIL|';                                                                         // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                             IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 002 - ID Referência
      strLinha := strLinha + LeftStr(Trim(stlEmails[intContador]), 255) + '|';                                     // 003 - Email Cliente
      strLinha := strLinha + 'S|';                                                                                 // 004 - Enviar XML
      strLinha := strLinha + 'S|';                                                                                 // 005 - Enviar PDF Danfe

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEEntrega;
  Var
    strLinha: String;
begin
  If fEmptyStr(dadosGerais.strLogradouroEndEnt) Then
  Begin
    Exit;
  End;

  strLinha := '';
  strLinha := strLinha + 'NFE-ENTREGA|';                                                // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                         IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência

  If dadosGerais.blnVenPre Then
  Begin
    strLinha := strLinha + dadosEmitente.strCnpj + '|';                                    // 03 - CNPJ/CPF
    strLinha := strLinha + dadosEmitente.strEndereco + '|';                                // 04 - Logradouro
    strLinha := strLinha + dadosEmitente.strNumeroEnd + '|';                               // 05 - Número
    strLinha := strLinha + dadosEmitente.strComplementoEnd + '|';                          // 06 - Complemento
    strLinha := strLinha + dadosEmitente.strBairro + '|';                                  // 07 - Bairro
    strLinha := strLinha + dadosEmitente.strCodIbge + '|';                                 // 08 - Código IBGE do Município
  End
  Else
  Begin
    strLinha := strLinha + dadosGerais.strCnpj + '|';                                      // 03 - CNPJ/CPF
    strLinha := strLinha + dadosGerais.strLogradouroEndEnt + '|';                          // 04 - Logradouro
    strLinha := strLinha + dadosGerais.strNumeroEndEnt + '|';                              // 05 - Número
    strLinha := strLinha + dadosGerais.strComplementoEndEnt + '|';                         // 06 - Complemento
    strLinha := strLinha + dadosGerais.strBairroEndEnt + '|';                              // 07 - Bairro
    strLinha := strLinha + dadosGerais.strCodIbgeEntrega + '|';                            // 08 - Código IBGE do Município
  End;

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400Ent.pNFEFatura(fltFatura: Double);
  Var
    strLinha : String;
begin
  If (fFormataFloat(fltFatura, 2) <> 0) Then
  Begin
    strLinha := '';
    strLinha := strLinha + 'NFE-FATURA|';                                                     // 01 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                           IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|'; // 02 - ID Referência
    strLinha := strLinha + dadosGerais.strNumDoc   + '|';                                     // 03 - Número da Fatura
    strLinha := strLinha + fValor(fltFatura, 15, 2) + '|';                                    // 04 - Valor Original
    strLinha := strLinha + fValor(0.00,      15, 2) + '|';                                    // 05 - Valor Desconto
    strLinha := strLinha + fValor(fltFatura, 15, 2) + '|';                                    // 06 - Valor Liquido
    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400Ent.pNFEHeader;
begin
  stlArquivo.Add('HEADER|4.00');
end;

procedure TNFEFit400Ent.pNFEModelo1AReferenciado;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin
  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If docRef.strTipoChave = DOCUMENTO_REF_NF_Modelo_1_1A Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-REF|';                                                    // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência
      strLinha := strLinha + docRef.strUfIbgeEmitente + '|';                                 // 03 - UF
      strLinha := strLinha + docRef.strAnoMesEmissao + '|';                                  // 04 - Ano / Mês
      strLinha := strLinha + fTiraCaracEspeciaisPonto(docRef.strCnpjEmitente) + '|';               // 05 - CNPJ Emitente
      strLinha := strLinha + docRef.strModeloDocFiscalNF + '|';                              // 06 - Modelo Documento
      strLinha := strLinha + docRef.strSerieFiscal + '|';                                    // 07 - Série
      strLinha := strLinha + fNumDocEnvio(docRef.strDocumentoFiscal) + '|';                  // 08 - Numero documento

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEProdutoCOFINS;
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
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
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

procedure TNFEFit400Ent.pNFEProdutoCombustiveis;
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
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                      // 002 - ID Referência
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

      strLinha := strLinha + IIF(fEmptyStr(item.strDesANP),'COMBUSTIVEL',item.strDesANP) + '|';  // 017	- Descrição do produto conforme ANP - (obrigatório)
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

procedure TNFEFit400Ent.pNFEProdutoDeclaracaoImportacao;
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
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                  // 002 - ID Referência
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

procedure TNFEFit400Ent.pNFEProdutoAdicoes;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;
    strIdRef: String;
begin
 strIdRef := fRetornaIdNfeFit(dadosGerais.strCodEmp,
    fNumDocEnvio(dadosGerais.strNumDoc), IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc);

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);
    If Assigned(item.documentoImportacao) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-ADIC'              + '|'; // 001 - Tipo do Registro
      strLinha := strLinha + strIdRef                + '|'; // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|'; // 003 - Nr.Item

      If (item.documentoImportacao.intAdicao <> 0) Then  //Informado, senão repassa 1 padrão
        strLinha := strLinha + IntToStr(item.documentoImportacao.intAdicao) + '|' // 004 - Número da Adição (Se foi digitado)
      Else
        strLinha := strLinha + '1'                     + '|'; // 004 - Número da Adição (Se não foi digitado)

      strLinha := strLinha + '1'                     + '|'; // 005 - Número Seqüencial do item dentro da adição
      strLinha := strLinha + item.strCodFab          + '|'; // 006 - Código do fabricante estrangeiro usado nos sistemas internos de informação do emitente de NF-e
      strLinha := strLinha + ''                      + '|'; // 007 - Valor do Desconto do Item da DI – Adição
      strLinha := strLinha + ''                      + '|'; // 008 - Número do ato concessório de Drawback
      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEProdutoICMSUFDestino;
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
        Result := 2;
      If fonteDados.fDadosGerais.strEstado = 'PI' Then
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
    Result := (fSuportaOperacaoBanco(fonteDados)) And (fonteDados.fDadosGerais.blnComplementoValor) And
              (fonteDados.fTabelaExiste('COMICD'));

    If (Result) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ICD_SEQITE ';
      strSQL := strSQL + '   FROM COMICD ';
      strSQL := strSQL + '  WHERE ICD_SEQITE = :AUTINC ';
      qryAux := fonteDados.fExecutaQuery(strSQL, ['AUTINC'], [strAutInc]);
      Result := (Not qryAux.IsEmpty);
      FreeAndNil(qryAux);
    End;
  end;

  procedure pGravaRegistros;
  Begin
    fltTotalIcmsInterestadualDestino := fltTotalIcmsInterestadualDestino + fltIcmsDestino;
    fltTotalIcmsInterestadualOrigem := fltTotalIcmsInterestadualOrigem + fltIcmsOrigem;
    fltTotalFCP := fltTotalFCP + fltValorFCP;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO-ICMS-UF-DEST|';                                   // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                 // 003 - Nr.Item
    strLinha := strLinha + fValor(fltBaseDestino, 15, 2) + '|';                           // 004 - Valor da Base ICMS UF Dest.
    strLinha := strLinha + fValor(fltPercentualFCP, 7, 4) + '|';                          // 005 - Perc. ICMS Fundo Combate Pobreza Dest.
    strLinha := strLinha + fValor(fltAliquotaInternaDestino, 7, 4) + '|';                 // 006 - Perc. ICMS Interna UF Dest.
    strLinha := strLinha + fValor(fltAliquotaInterestadualGerar, 7, 4) + '|';             // 007 - Perc. ICMS Interestadual
    strLinha := strLinha + fValor(fltPercentualPartilha, 7, 4) + '|';                     // 008 - Perc. Provisório de partilha do ICMS Interestadual
    strLinha := strLinha + fValor(fltValorFCP, 15, 2) + '|';                              // 009 - Valor do ICMS FCP UF Destino
    strLinha := strLinha + fValor(fltIcmsDestino, 15, 2) + '|';                           // 010 - Valor do ICMS Interestadual para UF do Destino
    strLinha := strLinha + fValor(fltIcmsOrigem, 15, 2) + '|';                            // 011 - Valor do ICMS Interestadual para UF do Remetente
    strLinha := strLinha + fValor(fltBaseFCP, 15, 2) + '|';                               // 012 - Valor da Base de Cálculo do FCP na UF de destino.

    stlArquivo.Add(strLinha);
  End;

begin
  If (lstItens.Count > 0) And (Assigned(TDadosItem(lstItens[0]))) And
     (fTemRegistroDifalFcpComplementoValor(TDadosItem(lstItens[0]).strAutInc)) Then
  Begin
    For intContador := 0 To lstItens.Count -1 Do
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

      pGravaRegistros;
    End;
  End
  Else
  Begin
    If Not fAtendeRegrasDifal(fonteDados.fDadosGerais.strOpcDoc) Then
    Begin
      If ((Not fonteDados.fDadosGerais.blnVenPre) And
          fSuportaOperacaoBanco(fonteDados) And
          fonteDados.fTabelaExiste('MOVICD')) Then
      Begin
        For intContador := 0 To lstItens.Count -1 Do
        Begin
          item := TDadosItem(lstItens[intContador]);

          If (item.fltValorFCP > 0) then
          Begin
            fltBaseDestino                := item.fltBaseUfDestino;
            fltPercentualFCP              := item.fltPercentualFCP;
            fltAliquotaInternaDestino     := item.fltAliquotaDestino;
            fltAliquotaInterestadualGerar := item.fltAliquotaInterestadual;
            fltPercentualPartilha         := item.fltPercentualPartilha;
            fltValorFCP                   := item.fltValorFCP;
            fltIcmsDestino                := item.fltValorIcmsDestino;
            fltIcmsOrigem                 := item.fltValorIcmsOrigem;
            fltBaseFCP                    := item.fltBaseFCP;

            pGravaRegistros;
          End;
        End;

      End;

      Exit;
    End;

    blnExisteMovIcd := fonteDados.fTabelaExiste('MOVICD');

    For intContador := 0 To lstItens.Count -1 Do
    Begin
      item := TDadosItem(lstItens[intContador]);

      If (fSuportaOperacaoBanco(fonteDados)) And
       ((Not blnExisteMovIcd) Or (Not fExisteRegistroTabela(['MOVICD', 'NOTICD'], ['ICD_SEQGER'], [item.strAutInc]))) Then
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
          fltPerBasDifalOrigem := 0;
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
                  fltPerBasDifalOrigem  := fValorCampo('CADCLI', 'CLI_PEBADF', ['CLI_CODCLI'], [fonteDados.fDadosGerais.strCodCli]);
                  fltPerBasDifalDestino := fValorCampo('CADCLI', 'CLI_PEBDDF', ['CLI_CODCLI'], [fonteDados.fDadosGerais.strCodCli]);
                End;
              End;
            End
            Else If (fCfgSisFonte(fonteDados, 'BASDFL') = 'S') Then
            Begin
              If fonteDados.fCampoExiste('CADABF', 'ABF_BASDOR') Then
                fltPerBasDifalOrigem  := fValorCampo('CADABF', 'ABF_BASDOR', ['ABF_CODABF','ABF_ESTADO'], [item.strCodAbf, fonteDados.fDadosGerais.strEstado]);

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
              If (fltPerBasDifalOrigem > 0) And (fltPerBasDifalDestino > 0) Then
              Begin
                fltBaseIcmsItem := fFormataFloat(((item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce)) * (fltPerBasDifalOrigem  / 100), 2);
                fltBaseDestino  := fFormataFloat(((item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce)) * (fltPerBasDifalDestino / 100), 2);
              End
              Else If (fltPeBaDf > 0) Then
              Begin
                fltBaseIcmsItem := (item.fltTotIte - item.fltDesEsp + item.fltTotFre + item.fltDesAce) * (fltPeBaDf / 100);
                fltBaseDestino  := fltBaseIcmsItem;
              End
              Else
                fltBaseDestino := fltBaseIcmsItem;
            End
            Else
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
        End
        Else
        Begin
          fltAlqInterestadualCalc := fCalculaAliquotaInterestadual;
        End;

        If (objConfig.blnSimPau) Then
        Begin
          If fCfgSisFonte(fonteDados, 'DIFREM') = 'N' Then
          Begin
            fltIcmsOrigem := 0;
          End;
        End;

        fltPercentualPartilha := fPercentualProvisorioPartilha;
        fltAliquotaInternaDestino := fRetAliquotaInternaEstadoDestino;
        fltAliquotaInterestadualGerar := IIF((fltBaseDestino > 0) And (Not objConfig.blnSimPau) And (Not blnProdutoST), item.fltAlqIcm, fltAlqInterestadualCalc);
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

      pGravaRegistros;
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEProdutoII;
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
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                           // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|';                                           // 003 - Nr.Item
      strLinha := strLinha + fValor(item.documentoImportacao.fltBaseImpostoImportacao, 15, 2) + '|';  // 004 - Valor Base de Calculo do II
      strLinha := strLinha + fValor(item.documentoImportacao.fltDespesasAduaneiras, 15, 2) + '|';     // 005 - Valor das Despesas Aduaneiras
      strLinha := strLinha + fValor(item.documentoImportacao.fltValorImpostoImportacao, 15, 2) + '|'; // 006 - Valor do II
      strLinha := strLinha + fValor(item.documentoImportacao.fltValorIOF, 15, 2) + '|';               // 007 - Valor do IOF

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFEFit400Ent.pNFEProdutoISSQN;
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
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
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

procedure TNFEFit400Ent.pNFEProdutoPIS;
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
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                 // 002 - ID Referência
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

procedure TNFEFit400Ent.pNFEProdutosIPI;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;

    strCstIpi: String;
    strEnqIpi: String;
begin
  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    strCstIpi := fDeterminaCSTIpi(item, fItemServico(item));

    If fEmptyStr(item.strEnqIpi) Then
      strEnqIpi := '999'
    Else
      strEnqIpi := item.strEnqIpi;

    If Not fEmptyStr(strCstIpi) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-PRODUTO-IPI|';                                           // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                 // 02 - ID Referência
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

        If (fFormataFloat(item.fltPerDevolvido, 2) > 0) Then
        Begin
          strLinha := strLinha +  '|';  // 013 - Alíquota IPI
          strLinha := strLinha +  '|';  // 014 - Valor do IPI
        End
        Else
        Begin
          strLinha := strLinha + fValor(item.fltAlqIpi, 7, 4) + '|';                          // 013 - Alíquota IPI
          strLinha := strLinha + fValor(item.fltValIpi, 15, 2) + '|';                         // 014 - Valor do IPI
          fltTotalIPI := fltTotalIPI + item.fltValIpi;
        End;
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

procedure TNFEFit400Ent.pNFEProdutosServicos;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;

    strCstSimples: String;
    fltValorIcmsOperacao: Double;
    blnNotaImportacao: Boolean;

    fltValUnt: Double;
    fltValTot: Double;
    fltValDes: Double;
    fltUniTri: Double;

  procedure pSetaInformacoesDesonerado;
  begin
    If (item.fltIcmOrg > 0) Or (item.fltVrdIcm > 0) Then
    Begin
      If item.fltIcmOrg > 0 Then
      Begin
        fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + item.fltIcmOrg;
        strLinha := strLinha + fValor(item.fltIcmOrg, 15, 2) + '|';                      // Valor do ICMS desoneração
        If (dadosGerais.strZonFra = 'S') Then
          strLinha := strLinha + '7|'                                                    // Motivo da desoneração do ICMS
        Else
          strLinha := strLinha + '8|';                                                   // Motivo da desoneração do ICMS
      End
      Else If item.fltVrdIcm > 0 Then
      Begin
        fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                      // Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                     // Motivo da desoneração do ICMS
      End;
    End
    Else
    Begin
      strLinha := strLinha + '|';                                                        // Valor do ICMS desoneração
      strLinha := strLinha + '|';                                                        // Motivo da desoneração do ICMS
    End;
  end;

  function fFcpST: Boolean;
  begin
    Result := (((Pos(RightStr(item.strCodSit, 2), '10_30_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False))) Or
              (Pos(strCstSimples, '201, 202, 203, 900') > 0)) And (fFormataFloat(item.fltPercentualFCP, 2) > 0) And
              (item.fltBasRet > 0);
  end;

  function fFcpVaiNoCampoDestino: Boolean;
  begin
    // Operação Interestadual E Consumidor Final
    Result := ((fLocalDestinoOperacao = '2') And (fIndicadorConsumidorFinal = '1'));
  end;

begin
  fltTotalIcmsDesonerado := 0;
  fltTotalDesconto := 0;
  fltTotalProdutos := 0;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    blnNotaImportacao := (LeftStr(item.strClaFis, 1) = '3');
    strCstSimples     := fRetornaCSTSimples(dadosEmitente, dadosGerais, item, fItemServico(item));

    If not objConfigInterna.blnUniTri Then
       item.strUnTrib := item.strUnidad ;

    If (fFinalidadeEmissao = '2') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'IMPRNF'))) Or (fCfgSisFonte(fonteDados, 'IMPRNF') = '1') Then
    Begin
      fltValUnt := item.fltUnitar;
      fltValTot := item.fltTotIte;
      fltValDes := item.fltDesEsp;
      fltUniTri := item.fltUniTri;
    End
    Else
    Begin
      fltValUnt := Iif(item.fltUnitar < item.fltUniOri, item.fltUniOri, item.fltUnitar);
      fltValTot := item.fltQtdIte * fltValUnt;
      fltValDes := fltValTot - (item.fltTotIte - item.fltDesEsp);
      fltUniTri := Iif(item.fltUnitar < item.fltUniOri, item.fltUniTrO, item.fltUniTri);
    End;

    If (dadosGerais.strZonFra = 'S') And (item.fltIcmOrg > 0) Then
    Begin
      fltValDes := 0;
      blnIcmsDesonerado := True;
    End;

    fltTotalDesconto := fltTotalDesconto + fltValDes;
    fltTotalProdutos := fltTotalProdutos + fltValTot;

    strLinha := '';
    strLinha := strLinha + 'NFE-PRODUTO|';                                                 // 001 - Tipo do Registro
    strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
      IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                  // 002 - ID Referência
    strLinha := strLinha + IntToStr(intContador+1) + '|';                                  // 003 - Nr.Item
    strLinha := strLinha + item.strCodIte + '|';                                           // 004 - Código do Produto/Serviço
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
    strLinha := strLinha + fValor(item.fltDesAce, 15, 2) + '|';                            // 023 - Valor Outras Despesas Acesssorias
    strLinha := strLinha + '1|';                                                           // 024 - Indicador Totalizador NF-e (0-Não compõe Total, 1-Compõe Total)

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
      strLinha := strLinha + '4|';                                                         // 037 - Modalidade de determinação BC ICMS Subt.Trib (4-Margem Valor Agregado (%))
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
        fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                        // 050 - Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                       // 051 - Motivo da desoneração do ICMS
      End
      Else
      Begin
        strLinha := strLinha + '|';                                                        // 050 - Valor do ICMS desonerado
        strLinha := strLinha + '|';                                                        // 051 - Motivo da desoneração do ICMS
      End;
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 9); // 43 - 51 - ICMS X20
    End;

    If (RightStr(item.strCodSit, 2) = '30') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 052 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 053 - CST – Tributação do ICMS
      strLinha := strLinha + '4|';                                                         // 054 - Modalidade de determinação BC ICMS Subt.Trib (4-Margem Valor Agregado (%))
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

    If (RightStr(item.strCodSit, 2) = '51') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao) Then
    Begin
      fltValorIcmsOperacao := 0;
      If item.strRICMPR='S' Then
      Begin
        fltValorIcmsOperacao := fFormataFloatInterna(item.fltBasIcm * item.fltAlqIcm / 100, 2);
      End;

      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                                                 // 066 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                                                // 067 - CST – Tributação do ICMS
      strLinha := strLinha + '3|';                                                                             // 068 - Modalidade de determinação BC ICMS
      strLinha := strLinha + fValorCond(item.strRICMPR='S', 0, 15, 2) + '|';                                   // 069 - Percentual de Redução de BC ICMS
      strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltBasIcm, 15, 2) + '|';                      // 070 - Valor da Base Calculo do ICMS
      strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltAlqIcm, 7, 4) + '|';                       // 071 - Alíquota do ICMS (sem FCP)
      strLinha := strLinha + fValorCond(item.strRICMPR='S', fltValorIcmsOperacao, 15, 2) + '|';                // 072 - Valor do ICMS da Operação
      strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltPerRed, 15, 4) + '|';                      // 073 - Percentual do diferimento
      strLinha := strLinha + fValorCond(item.strRICMPR='S', fltValorIcmsOperacao-item.fltValIcm, 15, 2) + '|'; // 074 - Valor do ICMS diferido
      strLinha := strLinha + fValorCond(item.strRICMPR='S', item.fltValIcm, 15, 2) + '|';                      // 075 - Valor do ICMS
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 10); // 66 - 75 - ICMS X51
    End;

    If (RightStr(item.strCodSit, 2) = '60') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                             // 076 - Origem da Mercadoria
      strLinha := strLinha + RightStr(item.strCodSit, 2) + '|';                            // 077 - CST – Tributação do ICMS
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 078 - Valor da Base Calculo do ICMS ST – Retido
      strLinha := strLinha + fValor(item.fltValRet, 15 ,2) + '|';                          // 079 - Valor do ICMS ST – Retido
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
      strLinha := strLinha + '4|';                                                         // 087 - Modalidade de determinação BC ICMS ST
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                           // 088 - Percentual da MVA
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                           // 089 - Percentual de Redução de BC ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 090 - Valor da Base Calculo do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                           // 091 - Alíquota do ICMS Subst.Trib. (sem FCP)
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 092 - Valor do ICMS Subst.Trib

      If (item.fltVrdIcm > 0) Then
      Begin
        fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                        // 093 - Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                       // 094 - Motivo da desoneração do ICMS
      End
      Else
      Begin
        strLinha := strLinha + '|';                                                        // 093 - Valor do ICMS desonerado
        strLinha := strLinha + '|';                                                        // 094 - Motivo da desoneração do ICMS
      End;
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
      strLinha := strLinha + '4|';                                                         // 102 - Modalidade de determinação BC ICMS ST
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
    strLinha := strLinha + fReplicatorStr('|', 6);  // 123 - 128 - ICMS ST – repasse de ICMS ST retido anteriormente em operações interestaduais com repasses através do Substituto Tributário

    If strCstSimples = '101' Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 129 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 130 - CST – Tributação do ICMS
      strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                          // 131 - Alíquota aplicável de cálculo do crédito (Simples Nacional).
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                         // 132 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
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
      strLinha := strLinha + '4|';                                                        // 137 - Modalidade de determinação BC ICMS ST (4-Margem Valor Agregado (%))
      strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                          // 138 - Percentual da margem de valor Adicionado do ICMS ST
      strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                          // 139 - Percentual da Redução de BC do ICMS ST
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                         // 140 - Valor da BC do ICMS ST
      strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                          // 141 - Alíquota do imposto do ICMS ST
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                         // 142 - Valor do ICMS ST
      strLinha := strLinha + '0|';                                                        // 143 - Alíquota aplicável de cálculo do crédito (SIMPLES NACIONAL).
      strLinha := strLinha + '0|';                                                        // 144 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (SIMPLES NACIONAL)
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 10);  // 133 - 134 - ICMS SIMPLES X201
    End;

    If Pos(strCstSimples, '202, 203') > 0 Then
    Begin
      strLinha := strLinha + LeftStr(item.strCodSit, 1) + '|';                            // 145 - Origem da Mercadoria
      strLinha := strLinha + RightStr(strCstSimples, 3) + '|';                            // 146 - CST – Tributação do ICMS
      strLinha := strLinha + '4|';                                                        // 147 - Modalidade de determinação BC ICMS ST (4-Margem Valor Agregado (%))
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
      strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                         // 155 - Valor da BC do ICMS ST
      strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                         // 156 - Valor do ICMS ST
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
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                         // 163 - Valor do ICMS
      strLinha := strLinha + '4|';                                                        // 164 - Modalidade de determinação da BC do ICMS ST
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

    strLinha := strLinha + LeftStr(item.strAnotacoes, 500) + '|';                         // 172 - Informações Adicionais Produto
    strLinha := strLinha + item.strPedCom   + '|';                                        // 173 - Numero do Pedido de Compra
    strLinha := strLinha + item.strNItemPed + '|';                                        // 174 - Numero do Item do Pedido de Compra
    strLinha := strLinha + '|';                                                           // 175 - Perc Desconto (Não Informar)
    strLinha := strLinha + fValor(IIF(item.fltImpPag <> 0, item.fltImpPag,
                                                           item.fltMunImp +
                                                           item.fltEstImp +
                                                           item.fltFedImp), 15, 2) + '|'; // 176 - Valor Total dos Tributos
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
      strLinha := strLinha + item.strCdbFis + '|';                                        // 186 - Código de Benefício Fiscal na UF aplicada ao Item
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 3);

    If (Pos(RightStr(item.strCodSit, 2), '10_20_51_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And
       (fFormataFloat(item.fltBaseFCP, 2) > 0) And (item.fltBasRet = 0) Then
    Begin
      strLinha := strLinha + fValor(item.fltBaseFCP, 15, 2) + '|';                        // 187 - Valor da Base de Cálculo do FCP
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 1);

    If (Not fFcpST) And ((Pos(RightStr(item.strCodSit, 2), '00_10_20_51_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And
                         (fFormataFloat(item.fltPercentualFCP, 2) > 0)) And
       (Not fFcpVaiNoCampoDestino) Then
    Begin
      strLinha := strLinha + fValor(item.fltPercentualFCP, 7, 4) + '|';                   // 188 - Percentual do Fundo de Combate à Pobreza (FCP)
      strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                       // 189 - Valor do Fundo de Combate à Pobreza (FCP)
      fltTotalFCP_189 := fltTotalFCP_189 + item.fltValorFCP;
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 2);

    If (fFcpST) And (Not fFcpVaiNoCampoDestino) Then
    Begin
      strLinha := strLinha + fValor(item.fltBaseFCP, 15, 2) + '|';                        // 190 - Valor da Base de Cálculo do FCP retido por Substituição Tributária
      strLinha := strLinha + fValor(item.fltPercentualFCP, 7, 4) + '|';                   // 191 - Percentual do FCP retido por Substituição Tributária
      strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                       // 192 - Valor do FCP retido por Substituição Tributária
      fltTotalFCP_192 := fltTotalFCP_192 + item.fltValorFCP;
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 3);

    If ((RightStr(item.strCodSit, 2) = '60') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False))) Or
       (strCstSimples = '500') Then
    Begin
      strLinha := strLinha + '' + '|';                                                    // 193 - Valor da Base de Cálculo do FCP retido anteriormente por Substituição Tributária
      strLinha := strLinha + '' + '|';                                                    // 194 - Percentual do FCP retido anteriormente por Substituição Tributária
      strLinha := strLinha + '' + '|';                                                    // 195 - Valor do FCP retido anteriormente por Substituição Tributária
      strLinha := strLinha + fValor(0, 7, 4) + '|';                                       // 196 - Alíquota suportada pelo Consumidor Final
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 4); // 193 - 196 - ICMS X60

    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFEFit400Ent.pNFETotal;
  Var
    strLinha: String;

  function fTotalTributos: Double;
    Var
      intContador: Integer;
      item: TDadosItem;
  begin
    Result := 0;
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
begin
  strLinha := '';
  strLinha := strLinha + 'NFE-TOTAL|';                                                                             // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                                            // 002 - ID Referência
  strLinha := strLinha + fValor(dadosGerais.fltBasIcm, 15, 2) + '|';                                               // 003 - Valor Total Base Calculo ICMS
  strLinha := strLinha + fValor(dadosGerais.fltTotIcm, 15, 2) + '|';                                               // 004 - Valor Total ICMS
  strLinha := strLinha + fValor(fltTotalIcmsDesonerado,15, 2) + '|';                                               // 005 - Valor Total do ICMS desonerado
  strLinha := strLinha + fValor(dadosGerais.fltBasRet, 15, 2) + '|';                                               // 006 - Valor Total Base Calculo ICMS ST
  strLinha := strLinha + fValor(dadosGerais.fltTotRet, 15, 2) + '|';                                               // 007 - Valor Total ICMS ST

  If (fFinalidadeEmissao = '2') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'IMPRNF'))) Or (fCfgSisFonte(fonteDados, 'IMPRNF') = '1') Then
    strLinha := strLinha + fValor(dadosGerais.fltTotPro, 15, 2) + '|'                                              // 008 - Valor Total dos Produtos e Serviços
  Else
    strLinha := strLinha + fValor(fltTotalProdutos, 15, 2) + '|';                                                  // 008 - Valor Total dos Produtos e Serviços

  strLinha := strLinha + fValor(dadosGerais.fltTotFre, 15, 2) + '|';                                               // 009 - Valor Total do Frete
  strLinha := strLinha + '0|';                                                                                     // 010 - Valor Total do Seguro

  If (((fFinalidadeEmissao = '2') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'IMPRNF'))) Or (fCfgSisFonte(fonteDados, 'IMPRNF') = '1'))) And
     (Not blnIcmsDesonerado) Then
    strLinha := strLinha + fValor(dadosGerais.fltDesEsp, 15, 2) + '|'                                              // 011 - Valor Total do Desconto
  Else
    strLinha := strLinha + fValor(fltTotalDesconto, 15, 2) + '|';                                                  // 011 - Valor Total do Desconto

  strLinha := strLinha + fValor(fTotalImpostoImportacao, 15, 2) + '|' ;                                            // 012 - Valor Total do Imposto Importação
  strLinha := strLinha + fValor(fltTotalIPI, 15, 2) + '|';                                                         // 013 - Valor Total do IPI
  strLinha := strLinha + fValor(dadosGerais.fltValPis, 15, 2) + '|';                                               // 014 - Valor Total do PIS
  strLinha := strLinha + fValor(dadosGerais.fltValCof, 15, 2) + '|';                                               // 015 - Valor Total do COFINS
  strLinha := strLinha + fValor(dadosGerais.fltDesAce, 15, 2) + '|';                                               // 016 - Valor Total Outras Despesas Aces.
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
  strLinha := strLinha + IfThen(dadosGerais.fltIrfRet > 0, fFormataValor(dadosGerais.fltTotPro, 15, 2), '') + '|'; // 042 - Valor Total Base Calculo IRRF
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

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400Ent.pNFETrailler;
begin
  stlArquivo.Add('TRAILLER|' + IntToStr(stlArquivo.Count+1));
end;

procedure TNFEFit400Ent.pNFETransporte;
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
    If Not dadosGerais.blnTransfIcms Then
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
  IdNfeFit_Aux := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc);

  If (fValidaCnpjCpf(dadosGerais.strCgcTra, fonteDados)) And (Not fNumerosRepetidos(dadosGerais.strCgcTra)) Then
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
  strLinha := strLinha + '|';                 // 16 - Placa do Veiculo (strPlaVeiAux)
  strLinha := strLinha + '|';                 // 17 - UF Placa Veiculo (strEstVeiAux)
  strLinha := strLinha + '|';                 // 18 - RNTC do Veiculo (strC_AnttAux)

  stlArquivo.Add(strLinha);
end;

procedure TNFEFit400Ent.pNFETranspVolume;
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
    IIF(strToIntDef(dadosGerais.strSerie,0)=0,'000',dadosGerais.strSerie), dadosGerais.strEspDoc) + '|';                                                            // 002 - ID Referência
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

procedure TNFEFit400Ent.pPrepararEmails;
  Var
    intPosEmail: Integer;
    strEmailPChar: {$IF Defined(VER250) Or Defined(UNIDAC)} PWideChar {$ELSE} PAnsiChar {$IFEND};
begin
  stlEmails.Clear;
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strEmailPChar := PWideChar(fonteDados.fDadosGerais.strEmail);
  {$ELSE}
    strEmailPChar := PAnsiChar(fonteDados.fDadosGerais.strEmail);
  {$IFEND};
  ExtractStrings([';'], [], strEmailPChar, stlEmails);

  intPosEmail := Pos(';', fonteDados.fDadosGerais.strEmail);
  If intPosEmail > 0 Then
  Begin
    fonteDados.fDadosGerais.strEmail := LeftStr(fonteDados.fDadosGerais.strEmail, intPosEmail-1);
  End;
end;

procedure TNFEFit400Ent.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
  Var
    strIdNota: String;
begin
  strIdNota := fRetornaIdNfeFit(objConfig.strCodEmp,
    Copy(strChaveAcesso, 26, 9), fonteDados.fDadosGerais.strSerie,
    fonteDados.fDadosGerais.strEspDoc);
  pImprimirDanfeInterna(strChaveAcesso, strImpressora, 1, strIdNota);
end;

procedure TNFEFit400Ent.pReimprimeDanfe(strChaveAcesso: String);
  Var
    strImpressora: String;
begin
  strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
  pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
end;

procedure TNFEFit400Ent.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TNFEFit400Ent.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFEFit400Ent.pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
  Var intTipoEmissao: Integer; Var strChaveAcesso: String;
  Var intStatus: Integer; Var strMensagem: String;
  Var strProtocolo: String; Var dtaDataAut: TDateTime);
  Var
    strDataAut: String;
    strMsgValidacaoEstrutura: String;
begin
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

function TNFEFit400Ent.fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno; arrStatusSucesso: Array Of Integer;
  intTipoEmissao: Integer; strChaveAcesso: String;
  intStatus: Integer; strMensagem: String;
  strProtocolo: String; dtaDataAut: TDateTime; blnIgnoraContingencia: Boolean;
  blnVerificarStatusEPEC: Boolean): TRetornoNFE;
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
    If (fNotaContingencia(intTipoEmissao)) And (intStatus=RET_EVENTO_REGISTRADO_NAO_VINCULADO) And (Not blnIgnoraContingencia) Then
    Begin
      If intTipoEmissao = TIPO_DPEC Then
      Begin
        Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
          strProtocolo, dtaDataAut);
        Result.SetContingencia(True);
      End
      Else
      Begin
        Result := TRetornoNFE.fCriaRetornoContingencia(strMensagem);
      End;
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
    Else
    Begin
      Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
    End;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
  End;
end;

function TNFEFit400Ent.fItemServico(item: TDadosItem): Boolean;
begin
  Result := Pos(item.strClaFis, '5933_6933_1933_2933_') > 0;
end;

function TNFEFit400Ent.fNotaContingencia(intTipoEmissao: Integer): Boolean;
begin
  Result := (intTipoEmissao in [TIPO_CONTINGENCIA, TIPO_SCAN, TIPO_DPEC]);
end;

function TNFEFit400Ent.fNotaDeComplemento: Boolean;
begin
  Result := (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE+','+FINALIDADE_COMPLEMENTAR) > 0) And
            (Not dadosGerais.blnEst_Dv) And (Not dadosGerais.blnNotEsp) And (Not dadosGerais.blnComVal);
end;

function TNFEFit400Ent.fValorCampo(strNomeTabela, strNomeCampo: String;
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

function TNFEFit400Ent.fStatusAguardando(intStatus: Integer): Boolean;
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

function TNFEFit400Ent.fRetornaCSTSimples(dadosEmitente: TDadosEmitente;
  dadosGerais: TDadosGerais; dadosItem: TDadosItem; blnIteSer: Boolean): String;
  Var
    strCodSitTmp: String;
    strCstSimSubs: String;
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

  strCstSimSubs := fGetCSTSimplesSub(dadosGerais,dadosEmitente, dadosItem);

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

  Else If Pos(RightStr(dadosGerais.strClaFis, 3), CLASS_FISCAL_TRANSFER) > 0 Then
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

  Else If Pos(strCodSitTmp, '30_40_50') > 0 Then
    Result := '103'

  Else If Pos(strCodSitTmp, '10_60_70') > 0 Then
  Begin
    If (fIndicadorIEDestinatario = '9') And
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

function TNFEFit400Ent.fDeterminaCSTIpi(item: TDadosItem; blnIteSer: Boolean): String;
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

function TNFEFit400Ent.fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
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
  Result.dtaHoraInicial := Now();
  Result.intCodigo := intCodigo;
  Result.strMensagem := strMensagem;
end;

procedure TNFEFit400Ent.pImprimirDanfeInterna(strChaveAcesso, strImpressora: String;
  intViasServidor: Integer; strIdNota: String);
  Var
    strNumDoc: String;
begin
  If fEmptyStr(strChaveAcesso) Then
  Begin
    Raise Exception.Create('A chave de acesso deve ser informada.');
  End;

  If fEmptyStr(objConfigInterna.strFitIntegradorImpressao) Then
  Begin
    strNumDoc := Copy(strChaveAcesso, 26, 9);
    fitWrapper.fDownloadDanfe(strChaveAcesso, fNumDocEnvio(strNumDoc), strImpressora,
      TMetodoImpressaoFactory.fCriarNotaFiscal(''), intViasServidor, strIdNota, Nil);
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

function TNFEFit400Ent.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
begin
  If (Not Assigned(dadosGeraisArg)) Or (fEmptyStr(dadosGeraisArg.strPontoImpressao)) Then
    Result := fIdentificarNomeDaImpressora(fonteDados, objConfig.strFitImpressoraPadrao)
  Else
    Result := fIdentificarNomeDaImpressora(fonteDados, dadosGeraisArg.strPontoImpressao);
end;

procedure TNFEFit400Ent.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin

end;

function TNFEFit400Ent.fConsultaStatusDFe(strChaveAcesso: string): String;
begin
  Result := '';
end;

function TNFEFit400Ent.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  Result := '';
end;

function TNFEFit400Ent.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55'): String;
begin
  Result := '';
end;

function TNFEFit400Ent.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude,
  strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFEFit400Ent.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFEFit400Ent.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega,
  strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFEFit400Ent.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

end.
