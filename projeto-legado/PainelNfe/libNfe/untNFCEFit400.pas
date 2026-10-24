unit untNFCEFit400;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Dialogs, Forms,
{$ENDIF}
  untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils, untReformaTributaria,
  NfeApiWSBean, untConstantesNFe, Contnrs, untUtilFIT, Types, DB, MaskUtils, untUtil;

Type
  TNFCEFit400 = class(TInterfacedObject, INFE)
  private
    ReformaTributaria: TReformaTributaria;
    ultimoRetornoFit: TWSNfeFitRetorno;
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
    fltTotalIcmsDesonerado: Double;
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

    stlEmailsTraRed: TStringList;

    blnJaCanceladaNaSefaz: Boolean;
    strProtocoloJaCancelada: String;
    dtaDataJaCancelada: TDateTime;

    procedure pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
      var intTipoEmissao: Integer; var strChaveAcesso: String;
      var intStatus: Integer; var strMensagem, strProtocolo: String;
      var dtaDataAut: TDateTime; Var strQRCode: String;
      var intStatusSefaz: Integer; Var dtaEmissao: TDateTime;
      Var blnContingencia: Boolean; Var strContingenciaAutorizada: String;
      Var strProtMsg: String);

    function fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno; arrStatusSucesso: Array Of Integer;
        intTipoEmissao: Integer; strChaveAcesso: String; intStatus: Integer;
        strMensagem, strProtocolo: String; dtaDataAut: TDateTime;
        blnIgnoraContingencia: Boolean; blnOffLine: Boolean;
        strContingenciaAutorizada, strContingenciaRecusadaRejeitada: String; intStatusSefaz: Integer): TRetornoNFE;

    function fNotaContingencia(intStatus, intTipoEmissao: Integer): Boolean;
    function fStatusDenegada(intStatus: Integer): Boolean;
    function fStatusAguardando(intStatus: Integer; strMensagem: String): Boolean;

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
    procedure pNFEInformacoesDoIntermediadorDaTransacao;
    procedure pDFeReformaTributaria;

    function fAjustaCSTSimplesX40_e_X41(strCodSit, strCSOSN: String): String;
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
    function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;

    procedure pInserirDadosNFComplemento;
    procedure pPrepararEmails;
    function fCfopDevolucao: Boolean;
    function fIndicadorConsumidorFinal: String;
    function fModalidadeFrete: String;
    function fIndicadorPresenca: String;
    function fIndicadorIntermediador: String;
    function fIndicadorIEDestinatario: String;
    function fLocalDestinoOperacao: String;
    function fNotaDeComplemento: Boolean;
    function fValorCampo(strNomeTabela, strNomeCampo: String;
      arrParametros: Array Of String; arrValores: Array Of Variant): Variant;
    procedure pExtraiDadosRetornoIdFormatoNFE(resultadoFit: TWSNfeFitRetorno;
        var intTipoEmissao: Integer; var strChaveAcesso: String;
        var intStatus: Integer; var strMensagem, strProtocolo: String;
        var dtaDataAut: TDateTime;
        Var strContingenciaAutorizada: String;
        Var strContingenciaRecusadaRejeitada: String);
    function fEmissaoContingencia(intTipoEmissao: Integer): Boolean;
    function fImpressoraConfiguradaOpcoesNfce: string;
    function fDocumentoInvalido(strRetorno: String): Boolean;
    function fContingenciaAutorizada(const intTipoEmissao: Integer; const strMensagem, strTextoRetornoFit: String; const intPosicaoStatusNFE: Integer): Boolean;
    function fContingenciaRecusadaRejeitada(const intTipoEmissao: Integer; const strTextoRetornoFit: String; const intPosicaoStatusNFE: Integer): Boolean;
    procedure pIntegracaoPainelCitelNFCe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
    procedure pIntegracaoPainelCitelNFCeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
    function fBaixaEntregaFuturaComoControleDeEntregaSemDuplicatas: Boolean;
    function fRetEndToEndIdPixDocumento(const ADadosGerais: TDadosGerais) : TStringList;
    function fRetEndToEndIdPixSemModalidade(const ADadosGerais: TDadosGerais) : TStringList;
    function fTransferenciaDeveUsarCSOSN400 : Boolean;
    procedure pZeraUltimoRetornoFit;
    function fCupomAindaAutorizadaNaSefaz(const strChaveAcesso: String; var strProtocolo: String; var dtaDataAut: TDateTime): Boolean;
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

    function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
    function fEnviaNFCeXmlOffLine: Boolean;
    function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

    function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;

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

    constructor Create(fonteDados: IFonteDados; blnOffLine: Boolean=False);
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

{ TNFCEFit400 }

constructor TNFCEFit400.Create(fonteDados: IFonteDados; blnOffLine: Boolean=False);
begin
  Self.fCriaObjetoLogPerformance(0, ''); //Manter apenas apenas para forçar a compilação da função em desuso;

  objLogDanfe.AddLog('TNFCEFit400.Create');
  Self.fonteDados := fonteDados;
  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);
  ReformaTributaria := TReformaTributaria.Create(fonteDados);
  fitWrapper.blnOffLine := blnOffLine;
  lstItens := TObjectList.Create(False);
  stlArquivo := TStringList.Create;
  stlEmails := TStringList.Create;
  stlEmailsTra := TStringList.Create;
  stlEmailsTraRed := TStringList.Create;
  blnIcmsDesonerado := False;
end;

destructor TNFCEFit400.Destroy;
begin
  objLogDanfe.AddLog('TNFCEFit400.Destroy');
  lstItens.Clear;
  pZeraUltimoRetornoFit;
  FreeAndNil(lstItens);
  FreeAndNil(fitWrapper);
  FreeAndNil(ReformaTributaria);
  FreeAndNil(stlArquivo);
  FreeAndNil(stlEmails);
  FreeAndNil(stlEmailsTra);
  FreeAndNil(stlEmailsTraRed);
  inherited;
end;

function TNFCEFit400.fAtendeRegrasDifal(strOpcDoc: String): Boolean;
begin
  Result := (fIndicadorIEDestinatario = '9') And
            (fLocalDestinoOperacao = '2') And
            (fIndicadorConsumidorFinal = '1') And
            (Pos(strOpcDoc, 'CO_') <= 0);
end;

function TNFCEFit400.fBaixaEntregaFuturaComoControleDeEntregaSemDuplicatas: Boolean;
begin
  Result := False;

  If fCfgSisFonte(fonteDados, 'HEFCOE') <> 'S' Then
    Exit;

  If fCfgSisFonte(fonteDados, 'BFUTTP') <> '2' Then
    Exit;

  If dadosGerais.strOpcDoc <> 'BF' Then
    Exit;

  If fFinalidadeEmissao <> FINALIDADE_NORMAL Then
    Exit;

  If Length(dadosGerais.arrDuplicatas) > 0 Then
    Exit;

  Result := True;
end;

function TNFCEFit400.fCancelarNota(strNumDoc, strSerie,
  strMotivo: String): Boolean;
  Var
    strTexto: String;
    stlArquivo: TStringList;
begin
  pLogImp('TNFCEFit400.fCancelarNota');

  blnJaCanceladaNaSefaz := False;
  strProtocoloJaCancelada := '';
  dtaDataJaCancelada := 0;

  If (Not fEmptyStr(fonteDados.fChaveAcesso)) Then
  Begin
    Try
      blnJaCanceladaNaSefaz := Not fCupomAindaAutorizadaNaSefaz(fonteDados.fChaveAcesso, strProtocoloJaCancelada, dtaDataJaCancelada);
    Except
      blnJaCanceladaNaSefaz := False;
    End;
  End;

  If blnJaCanceladaNaSefaz Then
  Begin
    pZeraUltimoRetornoFit;

    stlArquivo := TStringList.Create;
    Try
      stlArquivo.Add('Nota ja estava cancelada na Sefaz. Protocolo: ' + strProtocoloJaCancelada);
      Try
        stlArquivo.SaveToFile(fPnlDir('ULTIMO_RETORNO_CANCELAMENTO.TXT'));
      Except

      End;
    Finally
      FreeAndNil(stlArquivo);
    End;

    Result := True;
    Exit;
  End;

  strTexto := 'NFE-CANC|' +
               fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(strNumDoc), strSerie, 'IF') + '|' +
               fonteDados.fChaveAcesso + '|' +
               strMotivo + '|' +
               '|';

  pZeraUltimoRetornoFit;
  ultimoRetornoFit := fitWrapper.fEnviaTextoIntegracaoNFCE_CANC(strTexto, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

  stlArquivo := TStringList.Create;
  Try
    stlArquivo.Add(strTexto);
    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_CANCELAMENTO.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  stlArquivo := TStringList.Create;
  Try
   stlArquivo.Add(ultimoRetornoFit.Texto);
    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_RETORNO_CANCELAMENTO.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  Result := ultimoRetornoFit.RetornoOk;
end;

function TNFCEFit400.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
  Result := '';
end;

function TNFCEFit400.fEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  Result := Nil;
end;

function TNFCEFit400.fEnviaNFCeXmlOffLine: Boolean;
  Var
    strTexto: String;
    stlArquivo: TStringList;
    strNotaFiscal: String;
    strCodEmpFit: String;
    strXmlOffLine: String;
begin
  pLogImp('TNFCEFit400.fEnviaNFCeXmlOffLine');
  strCodEmpFit  := '1';
  strXmlOffLine := fEncodeBase64(String( fonteDados.fDadosGerais.strXmlOffLine ));
  strNotaFiscal := fRetornaIdNfeFit(fonteDados.fDadosGerais.strCodEmp, fNumDocEnvio(fonteDados.fDadosGerais.strNumDoc), fonteDados.fDadosGerais.strSerie, fonteDados.fDadosGerais.strEspDoc);

  If Not fEmptyStr(strXmlOffLine) Then
  Begin
    strTexto := strNotaFiscal+'|'+strCodEmpFit+'|'+strXmlOffLine+'|';

    pZeraUltimoRetornoFit;
    ultimoRetornoFit := fitWrapper.fEnviaTextoIntegracaoNFCE_XML_OFFLINE(strTexto);

    stlArquivo := TStringList.Create;
    Try
      stlArquivo.Add(strTexto);
      Try
        stlArquivo.SaveToFile(fPnlDir('ULTIMO_ENVIO_NFCE_XML_OFFLINE.TXT'));
      Except

      End;
    Finally
      FreeAndNil(stlArquivo);
    End;

    stlArquivo := TStringList.Create;
    Try
      stlArquivo.Add(ultimoRetornoFit.Texto);
      Try
        stlArquivo.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFCE_XML_OFFLINE.TXT'));
      Except

      End;
    Finally
      FreeAndNil(stlArquivo);
    End;

    If (fCountChar(ultimoRetornoFit.Texto, '|') >= 3) Then
      fonteDados.fDadosGerais.strMsgOffLine := fGetValorLinha(ultimoRetornoFit.Texto, '|', 3)
    Else If (fCountChar(ultimoRetornoFit.Texto, '|') = 1) Then
      fonteDados.fDadosGerais.strMsgOffLine := Copy(ultimoRetornoFit.Texto, Pos('|', ultimoRetornoFit.Texto), Length(ultimoRetornoFit.Texto))
    Else
      fonteDados.fDadosGerais.strMsgOffLine := ultimoRetornoFit.Texto;

    Result := ultimoRetornoFit.RetornoOk;
  End
  Else
    Result := False;
end;

function TNFCEFit400.fRetXmlNfe(strChaveAcesso: string): string;
begin
  pLogImp('TNFCEFit400.fRetXmlNfe');
  result := fitWrapper.fRetXMLNfe(strChaveAcesso);
end;

function TNFCEFit400.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
begin
  pLogImp('TNFCEFit400.fConfirmacaoOperacaoEntradaMercadoria');
  result := fitWrapper.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
end;

function TNFCEFit400.fCfopDevolucao: Boolean;
begin
  Result := False;
  If lstItens.Count > 0 Then
  Begin
    Result := Pos(TDadosItem(lstItens[0]).strClaFis, CFOP_DEVOLUCAO) > 0;
  End;
end;

function TNFCEFit400.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  pLogImp('TNFCEFit400.fConsultaCadastro');
  Result := untUtilFIT.fConsultaCadastro(fitWrapper, strUf, strCnpj, strIe);
end;

function TNFCEFit400.fData(const dta: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyy', dta);
end;

function TNFCEFit400.fDataHora(const dta: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyyhhnnss', dta);
end;

function TNFCEFit400.fEnviarNota: Boolean;
  Var
    strMsg: String;
    resultValidacao: TResultadoValidacao;
    STATUS_OK: TIntegerDynArray;
    intStatus: Integer;
    stlRetWS: TStringList;
    strNFCeTextoRetorno: String;
    horPrimeiroEnvio: TDateTime;
    horPrimeiraTentat : TDateTime;
    strIdNota : String;
    strStatus : String;
    blnAutorizada : Boolean;
    blnSituacaoAssincrona : Boolean;
    intStatusNfe : Integer;
    blnRetornoDoEnvio : Boolean;
  Const
    TEMPO_ESPERA_NFCE = 2 * 1000; // 2 SEGUNDOS;
    LOTE_RECEBIDO = 3;
begin
 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Transmitindo NFCe - ' + dadosgerais.strNumDoc + '-' + dadosgerais.strEspDoc + ', aguarde ...');
 {$IFEND}
 
  pLogImp('TNFCEFit400.fEnviarNota');
  ultimoRetornoFit := Nil;
  SetLength(STATUS_OK, 6);
  STATUS_OK[0] := 1;
  STATUS_OK[1] := 2;
  STATUS_OK[2] := 3;//Lote recebido com sucesso
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
  pGerarConteudoNFe;

  If not fitWrapper.blnOffLine Then
  Begin
    horPrimeiroEnvio := nOw();

    Result := False;

    strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

    While True Do
    Begin
      pZeraUltimoRetornoFit;
      ultimoRetornoFit := fitWrapper.fEnviaTextoIntegracao(stlArquivo.Text, '', 'FIT_NFE_ENVIA_TEXTO_AUTORIZACAO_FIT_NFE', 8, STATUS_OK);

      Try
        stlArquivo.SaveToFile(fPnlDir('ULTIMA_NFCE.TXT'));

        Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                      dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ENVIO', stlArquivo.Text);
      Except

      End;

      intStatus := StrToIntDef(fGetValorLinha(ultimoRetornoFit.Texto, '|', 8), -1);
      strStatus := fGetValorLinha(ultimoRetornoFit.Texto, '|', 10);
      blnRetornoDoEnvio := ultimoRetornoFit.RetornoOk;

      blnSituacaoAssincrona := (intStatus = 1) or (Pos('importada', LowerCase(strStatus)) > 0) or (Pos('digitando', LowerCase(strStatus)) > 0);

      If (blnSituacaoAssincrona) Then
      Begin
        horPrimeiraTentat := nOw();
        blnAutorizada := False;
        While True Do
        Begin
          pZeraUltimoRetornoFit;
          // ultimoRetornoFit := fitWrapper.fConsultaSituacaoId(strIdNota+'|65');
          // Proteção do '88' em fRetornaIdNfeFit() para espécie IF
          // Foi usado fConsultaSituacaoIdNFeNFCe() por causa do retorno NFE-NFCE-RETORNO| compativel com o retorno de fEnviaTextoIntegracao, seré lido em fProcessarEnvio
          ultimoRetornoFit := fitWrapper.fConsultaSituacaoIdNFeNFCe(strIdNota);
          strStatus := fGetValorLinha(ultimoRetornoFit.Texto, '|', 10);
          intStatusNfe := StrToIntDef(fGetValorLinha(ultimoRetornoFit.Texto, '|', 9), -1);
          blnAutorizada := (Pos('autorizado o uso', LowerCase(strStatus)) > 0) or (intStatusNfe In [100, 150, 155]);
          If (blnAutorizada) Then
            Break;
          If SecondsBetween(nOw(), horPrimeiraTentat) > 30 Then
            Break;
          Sleep(TEMPO_ESPERA_NFCE);
        End;
        If (blnAutorizada) Then
        Begin
          Result := ultimoRetornoFit.RetornoOk;
          Break;
        End;
      End;

      Result := blnRetornoDoEnvio;

      If (Not blnSituacaoAssincrona) Then
      Begin
        If intStatus <> LOTE_RECEBIDO Then
          Break;
      End;

      If SecondsBetween(nOw(), horPrimeiroEnvio) > 10 Then
        Break;

      Sleep(TEMPO_ESPERA_NFCE);
    End;

    stlRetWS := TStringList.Create;
    Try
      stlRetWS.Add(ultimoRetornoFit.Texto);
      Try
        stlRetWS.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFCE_WS.TXT'));
      Except

      End;
    Finally
      FreeAndNil(stlRetWS);
    End;

    If (Not Result) Or (fGetValorLinha(ultimoRetornoFit.Texto, '|', 9)='999') Then
    Begin
      If (fCountChar(ultimoRetornoFit.Texto, '|') >= 10) Then
      Begin
        If fEmptyStr(fGetValorLinha(ultimoRetornoFit.Texto, '|', 11)) Then
          strMsg := 'Erro: ' + fGetValorLinha(ultimoRetornoFit.Texto, '|', 10)
        Else
          strMsg := 'Erro: ' + fGetValorLinha(ultimoRetornoFit.Texto, '|', 11);
      End
      Else
        strMsg := 'Erro: ' + ultimoRetornoFit.Texto;

      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMsg, Nil);
      pLogImp(strMsg);
      Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
    End;

  End
  Else
  Begin
    Try
      stlArquivo.SaveToFile(dadosEmitente.strFitOffLinePath + PATH_SEPARATOR + dadosGerais.strCodEmp + PATH_SEPARATOR + 'ULTIMA_NFCE.TXT');
    Except

    End;

    Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                  dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ENVIO', stlArquivo.Text);

    Result := fNFCeOffLineAssinador(dadosEmitente.strFitOffLinePath + PATH_SEPARATOR + dadosGerais.strCodEmp,
                                    'ULTIMA_NFCE.TXT',
                                    dadosEmitente.strFitOffLineLicenca,
                                    dadosEmitente.strFitOffLineCertJKS,
                                    dadosEmitente.strFitOffLineCertSenha,
                                    dadosEmitente.strFitOffLineIdToken,
                                    dadosEmitente.strFitOffLineNroToken,
                                    dadosEmitente.strFitAmbiente,
                                    IIF(not fEmptyStr(fCfgSisFonte(fonteDados,'TMZONE')),fCfgSisFonte(fonteDados,'TMZONE'),'-3'),
                                    strNFCeTextoRetorno,
                                    dadosGerais.strXmlOffLine,
                                    dadosGerais.strChaveAcessoOffLine);

    pZeraUltimoRetornoFit;
    ultimoRetornoFit := TWSNfeFitRetorno.Create(result,strNFCeTextoRetorno);
  End;

end;

procedure TNFCEFit400.pGerarConteudoNFe;
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
  pNFEInformacoesDoIntermediadorDaTransacao;
  pDFeReformaTributaria;
  pNFETrailler;

  stlArquivo.Text := fTiraCaracEspeciais(stlArquivo.Text, False, False, False);
end;

function TNFCEFit400.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
  Var
    strTexto: String;
begin
  pLogImp('TNFCEFit400.fListagemNotas');
  Result := TStringList.Create;
  strTexto := strCodEmp + '|' + FormatDateTime('ddmmyyyyhhnnss', dtaDtaIni) + '|' +
    FormatDateTime('ddmmyyyyhhnnss', dtaDtaFin+StrToTime('23:59:59')) + '|' +
    IntToStr(intTipo) + '|' + IntToStr(intStatus);

  fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_LISTA_NFE_PROPRIA_TIPO_EMISSAO_PERIODO');
  Result.Text := fitWrapper.strUltimoRetorno;
end;

function TNFCEFit400.fMensagemErro: String;
begin
  Result := '';
end;

function TNFCEFit400.fProcessarCancelamento: TRetornoNFE;
  Var
    intStatus: Integer;
    strMensagem: String;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    strQRCode: String;
    intStatusSefaz: Integer;
    dtaEmissao: TDateTime;
    blnContingencia: Boolean;
    strContingenciaAutorizada: String;
    strContingenciaRecusadaRejeitada: String;
    strProtMsg: String;
    strIdNota: String;
begin
  pLogImp('TNFCEFit400.fProcessarCancelamento');

  If blnJaCanceladaNaSefaz Then
  Begin
    strProtocolo := strProtocoloJaCancelada;
    Result := TRetornoNFE.fCriaRetornoSucesso('Nota ja estava cancelada na Sefaz.', fonteDados.fChaveAcesso, strProtocoloJaCancelada, dtaDataJaCancelada);
  End
  Else
  Begin
    pExtraiDadosRetornoId(ultimoRetornoFit, intTipoEmissao, strChaveAcesso,
      intStatus, strMensagem, strProtocolo, dtaDataAut, strQRCode, intStatusSefaz,
      dtaEmissao, blnContingencia, strContingenciaAutorizada, strProtMsg);

    Result := fGeraRetornoNFe(ultimoRetornoFit,
      [RET_CANCELAMENTO_HOMOLOGADO,
       RET_EVENTO_REGISTRADO,
       RET_STATUS_AUTORIZADA_FORA_PRAZO,
       RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
      intTipoEmissao, strChaveAcesso, intStatusSefaz, strMensagem, strProtocolo,
      dtaDataAut, True, False, strContingenciaAutorizada, strContingenciaRecusadaRejeitada, intStatusSefaz);

    Result.SetDataEmissao(dtaEmissao);
  End;

  If Result.Sucesso Then
  Begin
    strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);
    fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc), 'XMLNFE_CANCEL', fonteDados);

    pIntegracaoPainelCitelNFCeCancelamento(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                           dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, strProtocolo);
  End;
end;

function TNFCEFit400.fProcessarEnvio: TRetornoNFE;
  Var
    intStatus: Integer;

    strMensagem: String;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    intTipoEmissao: Integer;
    stlRet: TStringList;

    strIdNota: String;
    strQRCode: String;
    intStatusSefaz: Integer;
    dtaEmissao: TDateTime;
    blnContingencia: Boolean;
    strContingenciaAutorizada: String;
    strContingenciaRecusadaRejeitada: String;
    strProtMsg: String;
    blnDocumentoImpresso: Boolean;
begin
 {$IF Defined(VER180)}
 {$ELSE}
  if Assigned(untUtil.OnNotificarProgresso) then
    untUtil.OnNotificarProgresso('Processando retorno NFCe, aguarde ...');
 {$IFEND}

  pLogImp('TNFCEFit400.fProcessarEnvio');
  If Not Assigned(ultimoRetornoFit) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro('Por favor, reenvie o documento.');
    Exit;
  End;

  stlRet := TStringList.Create;
  Try
    stlRet.Add(ultimoRetornoFit.Texto);
    Try
      stlRet.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFCE.TXT'));

      Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                    dadosGerais.strCodCli, dadosGerais.strTip_FC, 'RETORNO', stlRet.Text);
    Except

    End;
  Finally
    FreeAndNil(stlRet);
  End;

  pExtraiDadosRetornoId(ultimoRetornoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut, strQRCode, intStatusSefaz,
    dtaEmissao, blnContingencia, strContingenciaAutorizada, strProtMsg);

  Result := fGeraRetornoNFe(ultimoRetornoFit, [5],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, False, fitWrapper.blnOffLine,
    strContingenciaAutorizada, strContingenciaRecusadaRejeitada, intStatusSefaz);
  Result.SetQRCode(strQRCode);
  Result.SetDataEmissao(dtaEmissao);
  Result.SetProtMsg(strProtMsg);

  If Result.Sucesso Then
  Begin
   {$IF Defined(VER180)}
   {$ELSE}
    if Assigned(untUtil.OnNotificarProgresso) then
      untUtil.OnNotificarProgresso('NFCe autorizada ...');
   {$IFEND}

    Self.fonteDados.pGravarLogNfe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie, dadosGerais.strCodCli,
                                  dadosGerais.strTip_FC, 'AF', strMensagem, Result.ChaveAcesso, nOw(), fDefineImpressora(dadosGerais));

    pIntegracaoPainelCitelNFCe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                               dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, strProtocolo);
  End;

  {****************************************}
  {* IMPRESSAO_NOTA_FISCAL para registrar *}
  {* Tempo total para emissão NFe         *}
  {*************************************NC*}
  If (Result.Sucesso) Then
  Begin
   {$IF Defined(VER180)}
   {$ELSE}
    if Assigned(untUtil.OnNotificarProgresso) then
      untUtil.OnNotificarProgresso('Download do XML, aguarde ...');
   {$IFEND}
    strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);
    fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc), 'XMLNFCE', fonteDados);
  End;

  blnDocumentoImpresso := Self.fonteDados.fRetornaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                                                    dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);

  If (Result.Sucesso) And (not blnDocumentoImpresso) And (fCfgSisFonte(fonteDados,'PRNFCE') = 'S') And (strContingenciaAutorizada <> 'S') Then
  Begin
   {$IF Defined(VER180)}
   {$ELSE}
    if Assigned(untUtil.OnNotificarProgresso) then
     untUtil.OnNotificarProgresso('Enviando para impressão, aguarde ...');
   {$IFEND}

    pReimprimeDanfe(strChaveAcesso);
    Self.fonteDados.pGravaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                            dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);
  End;
end;

function TNFCEFit400.fProcessarStatusNota: TRetornoNFE;
  Var
    strIdNota: String;

    intStatus: Integer;
    intStatusSefaz: Integer;
    strMensagem: String;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
    strContingenciaAutorizada: String;
    strContingenciaRecusadaRejeitada: String;
begin
  pLogImp('TNFCEFit400.fProcessarStatusNota');
  Application.ProcessMessages;

  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  pZeraUltimoRetornoFit;
  ultimoRetornoFit := fitWrapper.fConsultaSituacaoId(strIdNota+'|65');

  Application.ProcessMessages;

  If (ultimoRetornoFit.RetornoOk) And (fDocumentoInvalido(ultimoRetornoFit.Texto)) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro('Documento não encontrado ou emitido em contingência off-line, aguarde e tente reenviar o documento mais tarde.');
    Exit;
  End
  Else
  Begin
    pExtraiDadosRetornoIdFormatoNFE(ultimoRetornoFit, intTipoEmissao, strChaveAcesso,
      intStatus, strMensagem, strProtocolo, dtaDataAut, strContingenciaAutorizada, strContingenciaRecusadaRejeitada);

    intStatusSefaz := intStatus;

    objLogDanfe.AddLog('documento..................: ' + dadosGerais.strNumDoc + '-' + dadosGerais.strEspDoc + '-' + dadosGerais.strCodEmp);
    objLogDanfe.AddLog('intTipoEmissao.............: ' + IntToStr(intTipoEmissao));
    objLogDanfe.AddLog('strContingenciaAutorizada..: ' + strContingenciaAutorizada);
    objLogDanfe.AddLog('blnIgnoraContingencia=false: ');
    objLogDanfe.AddLog('resultadoFit.Texto.........: ' + ultimoRetornoFit.Texto);

    Result := fGeraRetornoNFe(ultimoRetornoFit,
      [5,
      RET_STATUS_AUTORIZADA,
      RET_STATUS_AUTORIZADA_FORA_PRAZO,
      RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
      intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, False, False,
      strContingenciaAutorizada, strContingenciaRecusadaRejeitada, intStatusSefaz);
  End;
end;

function TNFCEFit400.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;
end;

function TNFCEFit400.fTotalImpostoImportacao: Double;
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

function TNFCEFit400.fTransferenciaDeveUsarCSOSN400: Boolean;
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

function TNFCEFit400.fFinalidadeEmissao: String;
begin
  If (dadosGerais.blnCreditoIcms) Or (dadosGerais.blnTransfIcms) Or
     ( (Not fCfopDevolucao) And (dadosGerais.blnEst_DV) And (Not dadosGerais.blnComplementoIcms) ) Or
     (dadosGerais.blnRestituicaoIcms) Or (dadosGerais.blnEstornoDeCredito) Then
    Result := FINALIDADE_AJUSTE // 3-Ajuste
  Else If (dadosGerais.blnNfComp Or dadosGerais.blnComVal) And
          (dadosGerais.blnComplementoIcms Or dadosGerais.blnComplementoValor)Then
    Result := FINALIDADE_NORMAL // 1-Normal
  Else If (Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO) > 0) Then
    Result := FINALIDADE_DEVOLUCAO // 4-Devolução
  Else
    Result := FINALIDADE_NORMAL; // 1-Normal
end;

function TNFCEFit400.fValor(const fltValor: Double; intPrecisao,
  intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TNFCEFit400.fValorCond(blnCondicao: Boolean; fltValor: Double;
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

function TNFCEFit400.fVerificarStatusNota: Boolean;
begin
  Result := True;
end;

function TNFCEFit400.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
var
  strRetornoConsulta: string;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

function TNFCEFit400.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

procedure TNFCEFit400.pAdicionaItem(dadosItem: TDadosItem);
begin
  lstItens.Add(dadosItem);
end;

procedure TNFCEFit400.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
  Var
    strTexto: String;
    intContador: Integer;
    retornoFit: TWSNfeFitRetorno;
    strMensagem: String;
    strNumDoc: String;
    intStatusOk: TIntegerDynArray;
begin
  pLogImp('TNFCEFit400.pEnviaCartaCorrecao');
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
              FormatDateTime('ddmmyyyyhhnnss', IncMinute(nOw(), -5)) + '|' +
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

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

procedure TNFCEFit400.pInserirDadosNFComplemento;

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
        dadosItem.fltTotIte := dadosItem.fltTotIte + dadosItem.fltValIcm;

        //Zera o valor do icms no produto
        dadosItem.fltBasIcm := 0;
        dadosItem.fltValIcm := 0;
        dadosItem.fltAlqIcm := 0;
      End;

    End;

    pAdicionaReformaTributariaTotal;

  End;
end;

procedure TNFCEFit400.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
  Var
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
    strMensagem: String;
    intStatus: Integer;
    intTentativas: Integer;
    intStatusOk: TIntegerDynArray;
begin
  pLogImp('TNFCEFit400.pInutilizarNumeros');
  intTentativas := 0;

  SetLength(intStatusOk, 2);
  intStatusOk[0] := 1;
  intStatusOk[1] := 2;

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
              '65';

  retornoFit := fitWrapper.fEnviaTextoIntegracao(strTexto, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE', 7, intStatusOk);
  If Not retornoFit.RetornoOk Then
  Begin
    pGrvArqTxt('ENVIO_INUT_' + strNumeroInicial + '_' + strNumeroFinal + '_' + strSerie + '_' + objConfig.strCodEmp, retornoFit.Texto);

    strMensagem := fGetValorLinha(retornoFit.Texto, '|', 8);
    Raise ErrosValidacaoNFE.fCriaErroSimples(strMensagem);
  End;

  Repeat
    Sleep(1000);
    retornoFit := fitWrapper.fConsultaSituacaoInutilizacao(fonteDados.fDadosEmitente.strCnpj, strSerie, strNumeroInicial + '|65');
    intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 7), 0);
    If (intStatus > 200) Or (intTentativas = 180) Then
    Begin
      pGrvArqTxt('CONSULTA_INUT_' + strNumeroInicial + '_' + strNumeroFinal + '_' + strSerie + '_' + objConfig.strCodEmp, retornoFit.Texto);

      Raise ErrosValidacaoNFE.fCriaErroSimples(fGetValorLinha(retornoFit.Texto, '|', 8));
    End;
    Inc(intTentativas);
  Until (intStatus = RET_INUTILIZACAO_OK) Or (intStatus = RET_INUTILIZACAO_OK_FIT);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFCEFit400.fLocalDestinoOperacao: String;
begin
  If Pos(LeftStr(dadosGerais.strClaFis, 1), '1,5') > 0 Then
    Result := '1'  // Operação interna
  Else If Pos(LeftStr(dadosGerais.strClaFis, 1), '2,6') > 0 Then
    Result := '2'  // Operação interestadual
  Else
    Result := '3'; // Operação com exterior
end;

function TNFCEFit400.fIndicadorIEDestinatario: String;

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

function TNFCEFit400.fImpressoraConfiguradaOpcoesNfce: string;
  var
    strPathOpcoesNFCe : String;
begin
  Result := '';
  strPathOpcoesNFCe := fCfgSisFonte(fonteDados,'PTNFCE');
  If fEmptyStr(strPathOpcoesNFCe) Then
    Exit;
  try
    Result := fArqIniLocal(0, 'NFCE', 'IMPRESSORA', '', strPathOpcoesNFCe + PATH_SEPARATOR + 'opcoes_nfce.ini');
    If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
      if fCfgSisFonte(fonteDados, 'SPOIMP') = 'S' then
        Result := fArqIniLocal(0, 'NFCE', 'PONTO_IMPRESSAO', '', strPathOpcoesNFCe + PATH_SEPARATOR + 'opcoes_nfce.ini');
  except
    Result := '';
  end;
end;

function TNFCEFit400.fIndicadorConsumidorFinal: String;
begin
  Result := IfThen(dadosGerais.strCliCon <> 'S', '0', '1');
end;

function TNFCEFit400.fModalidadeFrete: String;
begin
  If ((Not dadosGerais.blnTransfIcms) And (Not dadosGerais.blnNfComp)) Then
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

function TNFCEFit400.fIndicadorPresenca: String;
   Var
     strIdentPorCfg: String;

   function fTemNumPok: Boolean;
   begin
     Result := False;

     If pos('AC_', UpperCase(dadosGerais.strNumPok)) > 0 Then
       Exit;

     If pos('PV_TS', UpperCase(dadosGerais.strNumPok)) > 0 Then
       Exit;

     If fEmptyStr(dadosGerais.strNumPok) Then
       Exit;

     Result := True;
   end;
begin
  strIdentPorCfg := fCfgSisFonte(fonteDados, 'HRIDLK');

  If Not fEmptyStr(strIdentPorCfg) Then
    Result := strIdentPorCfg //HENRIMAR usa essa abordagem;
  Else If (fonteDados.fDadosGerais.strEstado = 'EX') Then
    Result := '9' // 9 – Operação não presencial, outros.
  Else If (dadosGerais.blnEntFat And (Not dadosGerais.blnVenPre)) And
     ((fValidaCnpjCpf(dadosGerais.strCgcTra, fonteDados)) And (Not fNumerosRepetidos(dadosGerais.strCgcTra))) And
     (fModalidadeFrete <> '9') Then
    Result := '4' // 4 - NFC-e em operação com entrega a domicílio
  Else If (dadosGerais.blnEntFat And (Not dadosGerais.blnVenPre)) And
          (Not ((fValidaCnpjCpf(dadosGerais.strCgcTra, fonteDados)) And (Not fNumerosRepetidos(dadosGerais.strCgcTra)))) Then
    Result := '1' // 1 – Operação presencial;  ( ENTREGA DEVERIA IDENTIFICAR )
  Else If Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_COMPLEMENTAR) > 0 Then
    Result := '0' // 0 – Não se aplica (por exemplo, Nota Fiscal complementar ou de ajuste)
  Else If (fonteDados.fDadosGerais.blnVenPre) Then
    Result := '1' // 1 – Operação presencial;
  Else If fTemNumPok Then
    Result := '9' // 9 – Operação não presencial, outros.
  Else If (fonteDados.fDadosGerais.strEstado <> dadosEmitente.strEstado) then
    Result := '9' // 9 – Operação não presencial, outros.
  Else
    Result := '1'; // 1 – Operação presencial;

  // NOVA OPÇÃO: 5 – Operação presencial, fora do estabelecimento
end;

function TNFCEFit400.fIndicadorIntermediador: String;
  Var
    strValCfg: String;
begin
  Result := '';
    
  strValCfg := fCfgSisFonte(fonteDados, 'IDIMIF');
  If (Pos(fIndicadorPresenca, strValCfg) > 0) Then 
    Result := IfThen(dadosGerais.strCnpjIntermediadorTransacao = '','0','1');
end;

procedure TNFCEFit400.pNFE;
  Var
    strLinha: String;
    strCnpj : String;
    strBairro : String;

  function fInscricaoEstadualSubstitutoTributario: String;
    Var
      strLisUFNaoEnviaIE: String;
      blnConIpi : Boolean;
      blnDentroEstado : Boolean;
  begin
    Result := dadosEmitente.strIESST;

    strLisUFNaoEnviaIE := fCfgSisFonte(fonteDados, 'SUTBNF');

    if (Not fEmptyStr(Result)) and (not fEmptyStr(strLisUFNaoEnviaIE)) then
    begin
      blnConIpi := (fCfgSisFonte(fonteDados, 'CONIPI') = 'S');
      blnDentroEstado := (dadosEmitente.strEstado = fonteDados.fDadosGerais.strEstado);

      If (fonteDados.fDadosGerais.blnVenPre) Or (blnDentroEstado And blnConIpi) Then
      Begin
        If (Pos(dadosEmitente.strEstado, strLisUFNaoEnviaIE) > 0) Then //Não envia no arquivo a IE do Substituto Tributario
          Result := '';
      End;
    End;
  End;

begin
  strBairro := dadosGerais.strBairro;
  If Length(strBairro) <= 1 Then
  Begin
    strBairro := 'N/D';
  End;

  strCnpj := dadosGerais.strCnpj;
  If (fEmptyStr(strCnpj)) And (Not fEmptyStr(dadosGerais.strIdEstrangeiro)) Then
    strCnpj := '00000000000';

  strLinha := '';
  strLinha := strLinha + 'NFE|';                                                              // 01 - Tipo do Registro

  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                          dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';// 02 - ID Referência

  strLinha := strLinha + dadosEmitente.strCnpj + '|';                                          // 03 - CNPJ Emitente

  If dadosGerais.blnEst_Dv Then
    strLinha := strLinha + LeftStr('999 - Estorno de NF-e não cancelada no prazo legal', 60) + '|'   // 04 - Natureza da Operação
  Else
    strLinha := strLinha + LeftStr(dadosGerais.strDescricaoClaFis, 60) + '|';                  // 04 - Natureza da Operação

  strLinha := strLinha + '|';                                                                  // 05 - Forma de Pagamento (0-A Vista,1-A Prazo,2-Outros)
  strLinha := strLinha + IfThen(dadosGerais.strEspDoc='IF', '65', '55') + '|';                 // 06 - Código do modelo do documento fiscal (55-NFe, 65-NFCe)
  strLinha := strLinha + dadosGerais.strSerie + '|';                                           // 07 - Série
  strLinha := strLinha + fNumDocEnvio(dadosGerais.strNumDoc) + '|';                            // 08 - Número

  If (dadosGerais.blnNFCeOffLine Or fitWrapper.blnOffLine) Then
    strLinha := strLinha + fDataHora(nOw) + '|'                                                // 09 - Data e hora de emissão do documento fiscal
  Else
    // Oriantado por detinho a enviar em branco, a fit preencherá esse campo! (Rejeição 705: NFC-e com data de entrada/saída)
    strLinha := strLinha + '|';                                                                // 09 - Data e hora de emissão do documento fiscal

  //Rejeição 705: NFC-e com data de entrada/saída
  strLinha := strLinha + '|';                                                                  // 10 - Data e hora de saída do documento fiscal

  strLinha := strLinha + '|';                                                                  // 11 - Hora de saída / entrada (não utilizado);
  strLinha := strLinha + IfThen(dadosGerais.strClaFis > '5000', 'S', 'E') + '|';               // 12 - Entrada / Saída
  strLinha := strLinha + fLocalDestinoOperacao + '|';                                          // 13 - Identificador do local de destino de operação
  strLinha := strLinha + IfThen(objConfig.blnHomolo, '2', '1') + '|';                          // 14 - Tipo de Ambiente 1-Produção 2-Homologação
  strLinha := strLinha + fFinalidadeEmissao + '|';                                             // 15 - Finalidade Emissão NF-e
  strLinha := strLinha + dadosEmitente.strCodIbge + '|';                                       // 16 - Código do Município do Fato Gerador
  strLinha := strLinha + '1' + '|';                                                            // 17 - Formato de Impressão do DANFE (Fixo 1-Retrato)
  strLinha := strLinha + fIndicadorConsumidorFinal + '|';                                      // 18 - Indica operação com Consumidor final (0-Normal 1-Consumidor Final)
  strLinha := strLinha + fIndicadorPresenca + '|';                                             // 19 - Indicador de presença do comprador no estabelecimento comercial no momento da operação

  strLinha := strLinha + strCnpj + '|';                                                        // 20 - CNPJ/CPF Destinatário
  strLinha := strLinha + dadosGerais.strIdEstrangeiro + '|';                                   // 21 - Identificação do destinatário no caso de comprador estrangeiro
  strLinha := strLinha + LeftStr(dadosGerais.strNomCli, 60) + '|';                             // 22 - Razão Social ou Nome do Destinatário
  strLinha := strLinha + '|';                                                                  // 23 - Nome Fantasia do Destinatário
  strLinha := strLinha + Trim(dadosGerais.strLogradouro) + '|';                                // 24 - Logradouro Destinatário
  strLinha := strLinha + dadosGerais.strNumeroEnd + '|';                                       // 25 - Número Logradouro Destinatário
  strLinha := strLinha + dadosGerais.strComplementoEnd + '|';                                  // 26 - Complemento Logradouro Destinatário
  strLinha := strLinha + strBairro + '|';                                                      // 27 - Bairro Destinatário
  strLinha := strLinha + dadosGerais.strCodIbge + '|';                                         // 28 - Código IBGE do Município Destinatário
  strLinha := strLinha + dadosGerais.strCEP + '|';                                             // 29 - CEP Destinatário
  strLinha := strLinha + dadosGerais.strCodigoPais + '|';                                      // 30 - Código BACEN Pais Destinatário
  strLinha := strLinha + dadosGerais.strTelefone + '|';                                        // 31 - Telefone Destinatário
  strLinha := strLinha + fIndicadorIEDestinatario + '|';                                       // 32 - Indicador da IE do Destinatário
  strLinha := strLinha + IfThen(Pos(fIndicadorIEDestinatario, '19') > 0, dadosGerais.strIES, '') + '|'; // 33 - Inscrição Estadual Destinatário
  strLinha := strLinha + dadosGerais.strSuframa + '|';                                         // 34 - Inscrição Suframa Destinatário
  strLinha := strLinha + '|';                                                                  // 35 - Inscrição Municipal do Tomador do Serviço (não é obrigatório)
  strLinha := strLinha + Trim(dadosGerais.strEmail) + '|';                                     // 36 - e-mail destinatário
  strLinha := strLinha + '|';                                                                  // 37 - Numero do Pedido
  strLinha := strLinha + '|';                                                                  // 38 - Carga / Rota
  strLinha := strLinha + fInscricaoEstadualSubstitutoTributario + '|';                         // 39 - Inscrição Estadual S.T.
  strLinha := strLinha + '|';                                                                  // 40 - Chave de Acesso da NF-e Caso esse campo não seja informado, o sistema gerará automaticamente
  strLinha := strLinha + '|';                                                                  // 41 - Codigo Referencial
  strLinha := strLinha + '|';                                                                  // 42 - cDIV
  strLinha := strLinha + '|';                                                                  // 43 - Codigo do cliente para impressão na DANFE
  strLinha := strLinha + dadosGerais.strNomeCidade + '|' ;                                     // 44 - Descrição IBGE do Município Destinatário. Só informar caso não queira utilizar a descrição padrão
  strLinha := strLinha + '|';                                                                  // 45 - Não obrigatório. Informar 2 para emissão em contingencia FS - Formulário de Segurança. stlArquivo.Add(strLinha);
  strLinha := strLinha + fRegimeTributarioEmitente(fCfgSisFonte(fonteDados,'SIMPAU'),
                                                   fCfgSisFonte(fonteDados,'SIMBRU')) + '|';   // 46 - 1 - Simples Nacional; 2 - Simples Nacional, excesso sublimite de receita bruta; 3 - Regime Normal.
  strLinha := strLinha + '|';                                                                  // 47 - Envio Assíncrono - - Sim N - Não Default N. Determina se o envio do documento da Sefaz será assíncrono. Caso SIM, irá retornar para o client logo após validar o schema do XML.
  strLinha := strLinha + '|';                                                                  // 48 - Versão da Aplicação -
  strLinha := strLinha + fIndicadorIntermediador + '|';                                        // 49 - Indicador de intermediador/marketplace - 0 – Operação sem intermediador (em site ou plataforma própria); 1 – Operação em site ou plataforma de terceiros (intermediadores/marketplace)

  stlArquivo.Add(strLinha);
end;

procedure TNFCEFit400.pNFEAutorizacaoDownloadXml;
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

  strLinha := '';
  strLinha := strLinha + 'NFE-PESSOA-DOWNLOAD-XML|';                                                  // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
                                          dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';         // 02 - ID Referência
  strLinha := strLinha + '1|';                                                                        // 03 - Número do Item
  strLinha := strLinha + strCgc;                                                                      // 04 - CPF/CNPJ Destinatário

  stlArquivo.Add(strLinha);
end;

procedure TNFCEFit400.pNFEInformacoesDePagamento;
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

      if not (fCfgSisFonte(fonteDados, 'NFCEPP') = 'S') then
        Exit;

      If fEmptyStr(dadosGerais.strCondPagamento) Then
        Exit;

      If (dadosGerais.strCondPagamento = '01000') Then
        Exit;

      If (Copy(dadosGerais.strCondPagamento, 3, 3) = '000') Then
        Exit;

      If Pos(dadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_') > 0 Then
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

    If dadosGerais.blnNfComp Then
    Begin
      strLinha := strLinha + '99|';                                                                // 04 - Forma de Pagamento
      strLinha := strLinha + '0|';                                                                 // 05 - Valor do Pagamento
      strLinha := strLinha + '0|';                                                                 // 06 - Valor do Troco
      strLinha := strLinha + '0|';                                                                 // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo
      strLinha := strLinha + 'Outros|';                                                            // 08 - Descrição do Meio de Pagamento, quando for 99-outros
    End
    Else If fBaixaEntregaFuturaComoControleDeEntregaSemDuplicatas Then
    Begin
      strLinha := strLinha + '99|';                                                                // 04 - Forma de Pagamento
      strLinha := strLinha + fValor(fltValor, 15, 2) + '|';                                        // 05 - Valor do Pagamento
      strLinha := strLinha + fValor(fltTroco, 15, 2) + '|';                                        // 06 - Valor do Troco
      strLinha := strLinha + '0|';                                                                 // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo
      strLinha := strLinha + 'Outros|';                                                            // 08 - Descrição do Meio de Pagamento, quando for 99-outros
    End
    Else If (Length(dadosGerais.arrDuplicatas) <= 0) And (RightStr(dadosGerais.strClaFis, 3) = '910') Then
    Begin
      strLinha := strLinha + '99|';                                                                // 04 - Forma de Pagamento
      strLinha := strLinha + fValor(fltValor, 15, 2) + '|';                                        // 05 - Valor do Pagamento
      strLinha := strLinha + fValor(fltTroco, 15, 2) + '|';                                        // 06 - Valor do Troco
      strLinha := strLinha + '0|';                                                                 // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo
      strLinha := strLinha + 'Outros|';                                                            // 08 - Descrição do Meio de Pagamento, quando for 99-outros
    End
    Else If (Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE + ',' + FINALIDADE_DEVOLUCAO) > 0) Or (Length(dadosGerais.arrDuplicatas) <= 0) Then
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
      strLinha := strLinha + dadosGerais.arrFormasPagamento[intContador].indPag           + '|';   // 07 - Indicador da Forma de Pagamento - 0 - Pagamento à Vista; 1 - Pagamento à Prazo

      If Pos(dadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_17_') > 0 Then
      Begin
        strLinha := strLinha                                                                 + '|'; // 08 - Descrição do Meio de Pagamento
        strLinha := strLinha                                                                 + '|'; // 09 - CNPJ transacional do pagamento
        strLinha := strLinha                                                                 + '|'; // 10 - UF do CNPJ do estabelecimento onde o pagamento foi processado/transacionado/recebido
        strLinha := strLinha + fData(dadosGerais.arrFormasPagamento[intContador].dtaDtaPag)  + '|'; // 11 - Data do Pagamento
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

    Else If (fCfgSisFonte(fonteDados, 'PGPIXL') = 'S') And (dadosGerais.arrFormasPagamento[intContador].strCodigo = FORMA_PAGTO_PIX) Then
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

procedure TNFCEFit400.pNFEInformacoesDoIntermediadorDaTransacao;
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

function TNFCEFit400.fRetEndToEndIdPixDocumento(const ADadosGerais: TDadosGerais) : TStringList;
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

function TNFCEFit400.fRetEndToEndIdPixSemModalidade(const ADadosGerais: TDadosGerais) : TStringList;
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

procedure TNFCEFit400.pNFEDadosAdicionais;
  Var
    strTexto: String;
    stlMensagens: TStringList;
    intContador: Integer;
    strLinha: String;
    intLinha: Integer;
    fltPerImpPag : Double;

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
          dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                     // 02 - ID Referência
        strLinha := strLinha + IntToStr(intLinha) + '|';                                          // 03 - Número da Linha ( Sequencial )
        strLinha := strLinha + strMsg + '|';                                                      // 04 - Informações Adicionais

        stlArquivo.Add(strLinha);
        Inc(intLinha);
      End;
    End;
begin
  stlMensagens := TStringList.Create;

  Try
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

    If not objConfigInterna.blnZeraIBPT And (not objConfigInterna.blnImpIBP) Then
    Begin
      If ((dadosGerais.fltFedImp <> 0.00) Or
          (dadosGerais.fltEstImp <> 0.00) Or
          (dadosGerais.fltMunImp <> 0.00))                         And
         ((dadosGerais.fltTotPro - dadosGerais.fltDesEsp) <> 0.00) And
          (dadosGerais.fNotaSaida)                                 And
          (objConfigInterna.strImpPag = '2')                       Then
      Begin
        pAddMensagem('Vlr Aprox dos Tributos: ' +
          IIF(dadosGerais.fltFedImp <> 0.00, 'R$ ' + FormatFloat('#,##0.00', dadosGerais.fltFedImp) + ' Federal ', '') +
          IIF(dadosGerais.fltEstImp <> 0.00, ' / R$ ' + FormatFloat('#,##0.00', dadosGerais.fltEstImp) + ' Estadual ', '') +
          IIF(dadosGerais.fltMunImp <> 0.00, ' / R$ ' + FormatFloat('#,##0.00', dadosGerais.fltMunImp) + ' Municipal ', '') +
          '- Fonte: IBPT' + '#');
      End
      Else
      Begin
        fltPerImpPag := 0.00;

        If (dadosGerais.fltImpPag <> 0.00) And ((dadosGerais.fltTotPro - dadosGerais.fltDesEsp) <> 0.00) Then
          fltPerImpPag := dadosGerais.fltImpPag / (dadosGerais.fltTotPro - dadosGerais.fltDesEsp) * 100.00;

        If (fltPerImpPag <> 0.00) And (dadosGerais.fNotaSaida) Then
          pAddMensagem('Vlr Aprox do Tributo "R$ ' + FormatFloat('#,##0.00', dadosGerais.fltImpPag) +
            '(' + FormatFloat('#,##0.00', fltPerImpPag) +
            IIF(objConfigInterna.strImpPag = '2','%) Fonte: IBPT"','%)"') + '#');
      End;
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
    Else
    Begin
      pAddMensagem('Valor do ICMS DIFAL devido a UF de origem: R$' + FloatToStrF(fltTotalIcmsInterestadualOrigem, ffNumber, 12, 2));
      pAddMensagem('Valor do ICMS DIFAL devido a UF de destino: R$' + FloatToStrF(fltTotalIcmsInterestadualDestino, ffNumber, 12, 2));
    End;
  End;

  If fltTotalFCP_189 > 0 Then
    pAddMensagem('BC.FCP R$ '+FloatToStrF(fltTotalBaseFCP_189, ffNumber, 12, 2)+' Aliq.FCP '+FloatToStrF(fltAliqFCP_189, ffNumber, 12, 2)+'% Vr.FCP R$ ' + FloatToStrF(fltTotalFCP_189, ffNumber, 12, 2));
  // Banzato  - Aguardar confirmação do André se vai retirar a tag de NFE-PRODUTO-ICMS-UF-DEST quando existir FCP ST
  If fltTotalFCP_192 > 0 Then
    pAddMensagem('BC.FCP.ST R$ '+FloatToStrF(fltTotalBaseFCP_192, ffNumber, 12, 2)+' Aliq.FCP.ST '+FloatToStrF(fltAliqFCP_192, ffNumber, 12, 2)+'% Vr.FCP.ST R$ ' + FloatToStrF(fltTotalFCP_192, ffNumber, 12, 2))
  Else If ((fltTotalFCP > 0) And (fEmptyStr(dadosGerais.strPerfil) Or (dadosGerais.strPerfil = '_SAI_NCO') Or (dadosGerais.strPerfil = '_SAI_CTA'))) Then
    pAddMensagem('BC.FCP.DIFAL R$ '+FloatToStrF(fltTotalBaseFCP, ffNumber, 12, 2)+' Aliq.FCP.DIFAL '+FloatToStrF(fltAliqFCP, ffNumber, 12, 2)+'% Vr.FCP.DIFAL R$ ' + FloatToStrF(fltTotalFCP, ffNumber, 12, 2));

  If (blnIcmsDesonerado) Then
    pAddMensagem('ICMS DESONERADO: R$' + FloatToStrF(fltTotalIcmsDesonerado, ffNumber, 12, 2));

  If fltBaseRetido > 0 Then
    pAddMensagem('BC.ST Retido R$ '+FloatToStrF(fltBaseRetido, ffNumber, 12, 2)+' Vr.ST Retido R$ ' + FloatToStrF(fltValorRetido, ffNumber, 12, 2));

  If fltBaseEfetivo > 0 Then
    pAddMensagem('BC.Efetivo R$ '+FloatToStrF(fltBaseEfetivo, ffNumber, 12, 2)+' Vr.Efetivo R$ ' + FloatToStrF(fltValorEfetivo, ffNumber, 12, 2));
end;

procedure TNFCEFit400.pNFEDuplicata(Var fltFatura: Double);
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
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                    // 02 - ID Referência
      strLinha := strLinha + untUtil.fStrZero(intNDup, 3) + '|';                                       // 03 - Número da Duplicata

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

procedure TNFCEFit400.pNFEECFReferenciado;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin

  If (pos(dadosGerais.strFinalidade, '5_6_') > 0) Then
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
      strLinha := strLinha + untUtil.fStrZero(docRef.strNumOrdSequencialECF, 3) + '|';               // 04 - Numero ECF
      strLinha := strLinha + RightStr(docRef.strNumeroCOO,6) + '|';                                      // 05 - Numero COO

      stlArquivo.Add(strLinha);
    End;
  End;

end;

procedure TNFCEFit400.pNFEEDadosExportacao;
  Var
    strLinha: String;
begin
  Try
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
  Except

  End;
end;

procedure TNFCEFit400.pNFEEletronicaReferenciada;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin

  If (pos(dadosGerais.strFinalidade, '5_6_') > 0) Then
    Exit;

  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If (docRef.strTipoChave = DOCUMENTO_REF_NFe_Modelo_55) Or
       (docRef.strTipoChave = DOCUMENTO_REF_NFCE) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-REF-NFE|';                                                // 01 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência
      strLinha := strLinha + docRef.strChaveAcessoNfe + '|';                                 // 03 - Número da Chave Acesso Referenciada

      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFCEFit400.pNFEEmailCliente;
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
      strLinha := strLinha + 'S|';                                                                                 // 005 - Enviar PDF Danfe

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
      strLinha := strLinha + 'S|';                                                                                 // 005 - Enviar PDF Danfe

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

procedure TNFCEFit400.pNFEEntrega;
  Var
    strLinha: String;
    strBairro : String;
    strBairroEndEnt : String;
begin
  strBairro := dadosEmitente.strBairro;
  If Length(strBairro) <= 1 Then
    strBairro := 'N/D';

  strBairroEndEnt := dadosGerais.strBairroEndEnt;
  If Length(strBairroEndEnt) <= 1 Then
    strBairroEndEnt := 'N/D';

  If fEmptyStr(dadosGerais.strLogradouroEndEnt) Then
  Begin
    Exit;
  End;

  If Not dadosGerais.blnEnviaEnderecoDeEntrega Then
    Exit;

  strLinha := '';
  strLinha := strLinha + 'NFE-ENTREGA|';                                                // 01 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                  // 02 - ID Referência

  If dadosGerais.blnVenPre Then
  Begin
    strLinha := strLinha + dadosEmitente.strCnpj + '|';                                    // 03 - CNPJ/CPF
    strLinha := strLinha + Trim(LeftStr(dadosEmitente.strEndereco, 60)) + '|';             // 04 - Logradouro
    strLinha := strLinha + dadosEmitente.strNumeroEnd + '|';                               // 05 - Número
    strLinha := strLinha + LeftStr(dadosEmitente.strComplementoEnd, 60) + '|';             // 06 - Complemento
    strLinha := strLinha + strBairro + '|';                                                // 07 - Bairro
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
    If (Not fEmptyStr(dadosGerais.strCNPJEndEnt)) Then
      strLinha := strLinha + dadosGerais.strCNPJEndEnt + '|'                               // 03 - CNPJ/CPF
    Else
      strLinha := strLinha + '|';                                                          // 03 - CNPJ/CPF

    strLinha := strLinha + Trim(LeftStr(dadosGerais.strLogradouroEndEnt, 60)) + '|';       // 04 - Logradouro
    strLinha := strLinha + dadosGerais.strNumeroEndEnt + '|';                              // 05 - Número
    strLinha := strLinha + LeftStr(dadosGerais.strComplementoEndEnt, 60) + '|';            // 06 - Complemento
    strLinha := strLinha + strBairroEndEnt + '|';                                          // 07 - Bairro
    strLinha := strLinha + dadosGerais.strCodIbgeEntrega + '|';                            // 08 - Código IBGE do Município
    strLinha := strLinha + '|';                                                            // 09 - Razão Social ou Nome do Expedidor
    strLinha := strLinha + dadosGerais.strCEPEndEnt + '|';                                 // 10 - CEP
    strLinha := strLinha + dadosGerais.strPaisEndEnt  + '|';                               // 11 - Código do País
    strLinha := strLinha + fRetNomePais(fonteDados, dadosGerais.strPaisEndEnt) + '|';      // 12 - Nome do País
    strLinha := strLinha + dadosGerais.strFoneEndEnt + '|';                                // 13 - Telefone
    strLinha := strLinha + '|';                                                            // 14 - Endereço de email do Expedidor
    If (Not fEmptyStr(dadosGerais.strIESEndEnt)) Then
      strLinha := strLinha + dadosGerais.strIESEndEnt + '|'                                // 15 - Inscrição Estadual
    Else
      strLinha := strLinha + '|';                                                          // 15 - Inscrição Estadual
  End;

  stlArquivo.Add(strLinha);
end;

procedure TNFCEFit400.pNFEFatura(fltFatura: Double);
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

procedure TNFCEFit400.pNFEHeader;
begin
  stlArquivo.Add('HEADER|4.00');
end;

procedure TNFCEFit400.pNFEModelo1AReferenciado;
  Var
    docRef: TChaveReferenciada;
    intIndice: Integer;
    strLinha: String;
begin

  If (pos(dadosGerais.strFinalidade, '5_6_') > 0) Then
    Exit;

  For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
  Begin
    docRef := dadosGerais.arrChavesReferenciadas[intIndice];

    If docRef.strTipoChave = DOCUMENTO_REF_NF_Modelo_1_1A Then
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
end;

procedure TNFCEFit400.pNFEProdutoCOFINS;
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

procedure TNFCEFit400.pNFEProdutoCombustiveis;
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

procedure TNFCEFit400.pNFEProdutoDeclaracaoImportacao;
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

procedure TNFCEFit400.pNFEProdutoAdicoes;
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
      strLinha := strLinha + 'NFE-ADIC'              + '|'; // 001 - Tipo do Registro
      strLinha := strLinha + strIdRef                + '|'; // 002 - ID Referência
      strLinha := strLinha + IntToStr(intContador+1) + '|'; // 003 - Nr.Item
      strLinha := strLinha + '1'                     + '|'; // 004 - Número da Adição
      strLinha := strLinha + '1'                     + '|'; // 005 - Número Seqüencial do item dentro da adição
      strLinha := strLinha + item.strCodFab          + '|'; // 006 - Código do fabricante estrangeiro usado nos sistemas internos de informação do emitente de NF-e
      strLinha := strLinha + ''                      + '|'; // 007 - Valor do Desconto do Item da DI – Adição
      strLinha := strLinha + ''                      + '|'; // 008 - Número do ato concessório de Drawback
      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFCEFit400.pNFEProdutoICMSUFDestino;
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
    Result := (fSuportaOperacaoBanco(fonteDados)) And (fonteDados.fDadosGerais.blnComplementoValor) And
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
    fltIcmsOrigem  := IIF(fltIcmsOrigem  > 0, fltIcmsOrigem,  0);
    fltIcmsDestino := IIF(fltIcmsDestino > 0, fltIcmsDestino, 0);

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
    strLinha := strLinha + fValor(fltAliquotaInternaDestino, 7, 4) + '|';                 // 006 - Perc. ICMS Interna UF Dest.
    strLinha := strLinha + fValor(fltAliquotaInterestadualGerar, 7, 4) + '|';             // 007 - Perc. ICMS Interestadual
    strLinha := strLinha + fValor(fltPercentualPartilha, 7, 4) + '|';                     // 008 - Perc. Provisório de partilha do ICMS Interestadual
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

begin
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

procedure TNFCEFit400.pNFEProdutoII;
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

procedure TNFCEFit400.pNFEProdutoISSQN;
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

procedure TNFCEFit400.pNFEProdutoPIS;
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

procedure TNFCEFit400.pNFEProdutosIPI;
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

procedure TNFCEFit400.pNFEProdutosServicos;
  Var
    item: TDadosItem;
    intContador: Integer;
    strLinha: String;

    strCstSimples: String;
    fltValorIcmsOperacao: Double;
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

  function fGetRegraMDBCST: string;
    const
      _0_PRECO_TABELA_OU_MAXIMO_SUGERIDO : string = '0';
      _4_MARGEM_VALOR_AGREGADO_PERCENTUAL : string = '4';
  begin
    Result := fBuscaRegraModalidadeDeterminacaoBCST(fonteDados, item.strCodSit, (item.fltValIva <> 0));
    if fEmptyStr(Result) then
    begin
      If (item.fltValIva = 0) And (Pos(dadosEmitente.strEstado, fCfgSisFonte(fonteDados, 'UFSMVA')) > 0) Then
        Result := _0_PRECO_TABELA_OU_MAXIMO_SUGERIDO
      else
        Result := _4_MARGEM_VALOR_AGREGADO_PERCENTUAL;
    end;
  end;

  procedure pSetaInformacoesDesonerado;
    var fltAlqDes,
        fltIcmDes: Double;
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
        fltIcmDes := fFormataFloatInterna(fltIcmDes, 2);
        if (fltIcmDes < 0) then
          fltIcmDes := 0;
      end
      else
      begin
        if (item.fltPerBas > 0) and (item.fltPerBas < 100) then
          fltIcmDes := fFormataFloatInterna(((((item.fltTotIte - item.fltDesEsp) * (100-item.fltPerBas)) / 100) * fltAlqDes) / 100, 2)
        else
          fltIcmDes := fFormataFloatInterna(((item.fltTotIte - item.fltDesEsp) * fltAlqDes) / 100, 2);
      end;

      fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + fltIcmDes;

      strLinha := strLinha + fValor(fltIcmDes, 15, 2) + '|';                             // Valor do ICMS desoneração
      strLinha := strLinha + '9|';                                                       // Motivo da desoneração do ICMS
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

  function fCalculaDiferimentoDeICMS: Boolean;
  begin
    Result := (RightStr(item.strCodSit, 2) = '51') And ((Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) Or blnNotaImportacao);
  end;

  function fCalculaDiferimentoTotalDeICMS: Boolean;
  begin
    Result := fCalculaDiferimentoDeICMS And (Pos(dadosEmitente.strEstado, fCfgSisFonte(fonteDados, 'DIFX51')) > 0) And (item.strRICMPR <> 'S');
  end;

  function fCalculaDiferimentoDeFCP: Boolean;
  begin
    Result := fCalculaDiferimentoDeICMS And (item.fltValorIcmsDestino = 0) And (item.fltValorFCP > 0);
  end;

  function fRetornoCodigoBeneficioFiscal: String;
  begin
    Result := fTiraCaracEspeciais(item.strCdbFis);

    If (RightStr(item.strCodSit, 2) = '00') Then
      Result := '';

    If (RightStr(item.strCodSit, 2) = '90') And (dadosEmitente.strEstado = 'GO') Then
      Result := 'SEM CBENEF';
  end;

  function fUsaDecretoDoCeara: Boolean;
  begin
    Result := False;

    If not (dadosEmitente.strEstado = 'CE') Then
      Exit;

    If fCfgSisFonte(fonteDados, 'USADCE') <> 'S' Then
      Exit;

    Result := True;
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

begin
  fltTotalIcmsDesonerado := 0;
  fltTotalDesconto := 0;
  fltTotalProdutos := 0;
  fltBasIcmDif := 0;

  For intContador := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intContador]);

    blnNotaImportacao := (LeftStr(item.strClaFis, 1) = '3');
    strCstSimples     := fRetornaCSTSimples(dadosEmitente, dadosGerais, item, fItemServico(item));

    If not fUsaUniTri(item.strClaFis) Then
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

    If (dadosGerais.strZonFra = 'S') And (item.fltIcmOrg > 0) Then
    Begin
      fltValDes := 0;
      blnIcmsDesonerado := True;
    End;

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

    If (fCfgSisFonte(fonteDados, 'NFEREF') = 'S') Then
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
        fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                        // 050 - Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                       // 051 - Motivo da desoneração do ICMS
      End
      Else
      Begin
        pSetaInformacoesDesonerado;
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
      If fCalculaDiferimentoTotalDeICMS Then
      Begin
        fltAliquotaIcmsOperacao := fAliquotaIcmsUF(fonteDados, dadosGerais.strEstado);
        fltValorIcmsOperacao    := fFormataFloatInterna((item.fltTotIte * fltAliquotaIcmsOperacao) / 100, 2);

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
      Else
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

      If (fCfgSisFonte(fonteDados, 'UTIE48') = 'S') And
         (dadosGerais.strEstado = dadosEmitente.strEstado) And (dadosGerais.strCliCon = 'N') And (item.fltVSTANT > 0) Then
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
        fltTotalIcmsDesonerado := fltTotalIcmsDesonerado + item.fltVrdIcm;
        strLinha := strLinha + fValor(item.fltVrdIcm, 15, 2) + '|';                        // 093 - Valor do ICMS desoneração
        strLinha := strLinha + item.strMtdIcm + '|';                                       // 094 - Motivo da desoneração do ICMS
      End
      Else
      Begin
        pSetaInformacoesDesonerado;
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

      If not fUsaDecretoDoCeara Then
      Begin
        strLinha := strLinha + fGetRegraMDBCST + '|';                                        // 102 - Modalidade de determinação BC ICMS Subt.Trib
        strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                           // 103 - Percentual da MVA – ST
        strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                           // 104 - Percentual de Redução de BC ICMS ST
        strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                          // 105 - Valor da Base Calculo do ICMS ST
        strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                           // 106 - Alíquota do ICMS Subst.Trib.
        strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                          // 107 - Valor do ICMS Subst.Trib
      End
      Else
        strLinha := strLinha + fReplicatorStr('|', 6); // 102 - 107 - ICMS X90
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
      If (dadosGerais.fltBasIcmSimples > 0) Then
      Begin
        strLinha := strLinha + fValor(item.fltAlqCreIcmSimples, 7, 4) + '|';              // 131 - Alíquota aplicável de cálculo do crédito (Simples Nacional).
        strLinha := strLinha + fValor(item.fltValCreIcmSimples, 15, 2) + '|';             // 132 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
      End
      Else
      Begin
        strLinha := strLinha + fValor(item.fltAlqIcm, 7, 4) + '|';                        // 131 - Alíquota aplicável de cálculo do crédito (Simples Nacional).
        strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                       // 132 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (Simples Nacional)
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

      If (fCfgSisFonte(fonteDados, 'UTIE48') = 'S') And
         (dadosGerais.strEstado = dadosEmitente.strEstado) And (dadosGerais.strCliCon = 'N') And (item.fltVSTANT > 0) Then
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
      strLinha := strLinha + fValor(item.fltValIcm, 15, 2) + '|';                         // 163 - Valor do ICMS

      If (item.fltValRet > 0) Then
      Begin
        strLinha := strLinha + fGetRegraMDBCST + '|';                                     // 164 - Modalidade de determinação da BC do ICMS ST
        strLinha := strLinha + fValor(item.fltValIva, 7, 4) + '|';                        // 165 - Percentual da margem de valor Adicionado do ICMS ST
        strLinha := strLinha + fValor(item.fltPRedST, 7, 4) + '|';                        // 166 - Percentual da Redução de BC do ICMS ST
        strLinha := strLinha + fValor(item.fltBasRet, 15, 2) + '|';                       // 167 - Valor da BC do ICMS ST
        strLinha := strLinha + fValor(item.fltAlqRet, 7, 4) + '|';                        // 168 - Alíquota do imposto do ICMS ST
        strLinha := strLinha + fValor(item.fltValRet, 15, 2) + '|';                       // 169 - Valor do ICMS ST
        strLinha := strLinha + '0|';                                                      // 170 - Alíquota aplicável de cálculo do crédito (SIMPLES NACIONAL).
        strLinha := strLinha + '0|';                                                      // 171 - Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (SIMPLES NACIONAL)
      End
      Else
        strLinha := strLinha + fReplicatorStr('|', 8);  // 164 - 171 - ICMS SIMPLES X900
    End
    Else
    Begin
      strLinha := strLinha + fReplicatorStr('|', 15);  // 157 - 171 - ICMS SIMPLES X900
    End;

    strLinha := strLinha + LeftStr(item.strAnotacoes, 500) + '|';                         // 172 - Informações Adicionais Produto
    strLinha := strLinha + item.strPedCom   + '|';                                        // 173 - Numero do Pedido de Compra
    strLinha := strLinha + item.strNItemPed + '|';                                        // 174 - Numero do Item do Pedido de Compra
    strLinha := strLinha + '|';                                                           // 175 - Perc Desconto (Não Informar)
    strLinha := strLinha + fValor(item.fltImpPag, 15, 2) + '|';                           // 176 - Valor Total dos Tributos
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

    If (Pos(RightStr(item.strCodSit, 2), '10_20_51_70_90_') > 0) And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False)) And
       (fFormataFloat(item.fltBaseFCP, 2) > 0) And (item.fltBasRet = 0) And (item.fltPercentualFCP > 0) Then
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

      If fCalculaDiferimentoDeFCP Then
      Begin
        strLinha := strLinha + fValor(0, 15, 2) + '|';                                    // 189 - Valor do Fundo de Combate à Pobreza (FCP)
      End
      Else
      Begin
        strLinha := strLinha + fValor(item.fltValorFCP, 15, 2) + '|';                       // 189 - Valor do Fundo de Combate à Pobreza (FCP)
        fltAliqFCP_189 := item.fltPercentualFCP;
        fltTotalFCP_189 := fltTotalFCP_189 + item.fltValorFCP;
        fltTotalBaseFCP_189 := fltTotalBaseFCP_189 + item.fltBaseFCP;
      End;
    End
    Else
      strLinha := strLinha + fReplicatorStr('|', 2);

    If (fFcpST) And (Not fFcpVaiNoCampoDestino) Then
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

    If ((RightStr(item.strCodSit, 2) = '60') And (Not fSimplesPaulista(dadosGerais, dadosEmitente, False))) Or
       (strCstSimples = '500') Then
    Begin
      strLinha := strLinha + '' + '|';                                                    // 193 - Valor da Base de Cálculo do FCP retido anteriormente por Substituição Tributária
      strLinha := strLinha + '' + '|';                                                    // 194 - Percentual do FCP retido anteriormente por Substituição Tributária
      strLinha := strLinha + '' + '|';                                                    // 195 - Valor do FCP retido anteriormente por Substituição Tributária
      strLinha := strLinha + fValor(0, 7, 4) + '|';                                       // 196 - Alíquota suportada pelo Consumidor Final

      If (fCfgSisFonte(fonteDados, 'UTIR48') = 'S') And
         (dadosGerais.strEstado = dadosEmitente.strEstado) And (dadosGerais.strCliCon = 'S') And (item.fltVICMEF > 0) Then
      Begin
        strLinha := strLinha + fValor(item.fltPICMEF,  7, 4) + '|';                       // 197 - Percentual de redução da base de cálculo efetiva
        strLinha := strLinha + fValor(item.fltBICMEF, 15, 2) + '|';                       // 198 - Valor da base de cálculo efetiva
        strLinha := strLinha + fValor(item.fltAICMEF,  7, 4) + '|';                       // 199 - Alíquota do ICMS efetiva
        strLinha := strLinha + fValor(item.fltVICMEF, 15, 2) + '|';                       // 200 - Valor do ICMS efetivo
        strLinha := strLinha + fValor(item.fltSICMEF, 15, 2) + '|';                       // 201 - Valor do ICMS Próprio do Substituto cobrado emoperação anterior

        strLinha := strLinha + '' + '|';                                                  // 202 - Código de barras diferente do padrão GTIN
        strLinha := strLinha + '' + '|';                                                  // 203 - Código de barras da unidade tributária que seja diferente do padrão GTIN
        strLinha := strLinha + '' + '|';                                                  // 204 - Valor do ICMS-ST desonerado
        strLinha := strLinha + '' + '|';                                                  // 205 - Motivo da desoneração do ICMS-ST

        fltBaseEfetivo  := fltBaseEfetivo  + item.fltBICMEF;
        fltValorEfetivo := fltValorEfetivo + item.fltVICMEF;
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

      strLinha := strLinha + fReplicatorStr('|', 5);
    End;

    strLinha := strLinha + fReplicatorStr('|', 9);

    strLinha := strLinha + fReformaTributariaRetornaValorTotalDoItem + '|';                    // 251 - Valor total do Item, correspondente à sua participação no total da nota. A soma dos itens deverá corresponder ao total da nota.

    stlArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit400.pNFETotal;
  Var
    strLinha: String;

  function fTotalTributos: Double;
    Var
      intContador: Integer;
      item: TDadosItem;
  begin
    Result := 0;

    If objConfigInterna.blnZeraIBPT Then
      Exit;

    If Assigned(lstItens) Then
    Begin
      For intContador := 0 To lstItens.Count-1 Do
      Begin
        item := TDadosItem(lstItens[intContador]);
        Result := Result + item.fltImpPag;
      End;
    End;
  end;
begin
  strLinha := '';
  strLinha := strLinha + 'NFE-TOTAL|';                                                                             // 001 - Tipo do Registro
  strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
    dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                                            // 002 - ID Referência
  strLinha := strLinha + fValor(dadosGerais.fltBasIcm  + fltBasIcmDif, 15, 2) + '|';                               // 003 - Valor Total Base Calculo ICMS
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

  strLinha := strLinha + '|';                                                                                      // 056 - Valor total da quantidade tributada do ICMS monofásico próprio
  strLinha := strLinha + '|';                                                                                      // 057 - Valor total do ICMS monofásico próprio
  strLinha := strLinha + '|';                                                                                      // 058 - Valor total da quantidade tributada do ICMS monofásico sujeito a retenção
  strLinha := strLinha + '|';                                                                                      // 059 - Valor total do ICMS monofásico sujeito a retenção
  strLinha := strLinha + fValor(fltTotalQtdeMonofasicoRetidoAnteriormente, 15, 2) + '|';                           // 060 - Valor total da quantidade tributada do ICMS monofásico retido anteriormente
  strLinha := strLinha + fValor(fltTotalIcmsMonofasicoRetidoAnteriormente, 15, 2) + '|';                           // 061 - Valor total do ICMS monofásico retido anteriormente

  stlArquivo.Add(strLinha);
end;

procedure TNFCEFit400.pNFETrailler;
begin
  stlArquivo.Add('TRAILLER|' + IntToStr(stlArquivo.Count+1));
end;

procedure TNFCEFit400.pNFETransporte;
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
    If ((Not dadosGerais.blnTransfIcms) And (Not dadosGerais.blnNfComp)) Then
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

  If (fValidaCnpjCpf(dadosGerais.strCgcTra, fonteDados)) And (Not fNumerosRepetidos(dadosGerais.strCgcTra)) And (fModalidadeFrete <> '9') Then
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
  strLinha := strLinha + strPlaVeiAux + '|';  // 16 - Placa do Veiculo
  strLinha := strLinha + strEstVeiAux + '|';  // 17 - UF Placa Veiculo
  strLinha := strLinha + strC_AnttAux + '|';  // 18 - RNTC do Veiculo

  stlArquivo.Add(strLinha);
end;

procedure TNFCEFit400.pNFETranspVolume;
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

procedure TNFCEFit400.pPrepararEmails;
  Var
    intPosEmail: Integer;
    strEmailPChar, strEmailTraPChar, strEmailTraRedPChar: {$IF Defined(VER250) Or Defined(UNIDAC)} PWideChar {$ELSE} PAnsiChar {$IFEND};
begin
  stlEmails.Clear;
  stlEmailsTra.Clear;
  stlEmailsTraRed.Clear;
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strEmailPChar       := PWideChar(fonteDados.fDadosGerais.strEmail);
    strEmailTraPChar    := PWideChar(fonteDados.fDadosGerais.strEmaTra);
    strEmailTraRedPchar := PWideChar(fonteDados.fDadosGerais.strEmaTrr);
  {$ELSE}
    strEmailPChar       := PAnsiChar(fonteDados.fDadosGerais.strEmail);
    strEmailTraPChar    := PAnsiChar(fonteDados.fDadosGerais.strEmaTra);
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

procedure TNFCEFit400.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
begin
  pLogImp('TNFCEFit400.pReimprimeDanfe('+strChaveAcesso+', '+strImpressora+IIF(fEmptyStr(strImprimirTelaPDF), '', ', '+strImprimirTelaPDF)+')');
  If not fEmptyStr(strChaveAcesso) Then
    TImpressaoDiretaCitel.pImprimir(fonteDados.fDadosGerais.strCodEmp , strImpressora, strChaveAcesso, 'NFCE');
end;

procedure TNFCEFit400.pReimprimeDanfe(strChaveAcesso: String);
  Var
    strImpressora: String;
begin
  pLogImp('TNFCEFit400.pReimprimeDanfe('+strChaveAcesso+')');
  If not fEmptyStr(strChaveAcesso) Then
  Begin
    strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
    pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
  End;
end;

procedure TNFCEFit400.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TNFCEFit400.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFCEFit400.pZeraUltimoRetornoFit;
begin
  If Assigned(Self.ultimoRetornoFit) Then
    FreeAndNil(Self.ultimoRetornoFit);
end;

procedure TNFCEFit400.pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
  var intTipoEmissao: Integer; var strChaveAcesso: String;
  var intStatus: Integer; var strMensagem, strProtocolo: String;
  var dtaDataAut: TDateTime; Var strQRCode: String;
  var intStatusSefaz: Integer; Var dtaEmissao: TDateTime;
  Var blnContingencia: Boolean; Var strContingenciaAutorizada: String;
  Var strProtMsg: String);
  Var
    strDataAut: String;
    strEmissao: String;
    strTextoPuroPosicao14 : String;
begin
  intTipoEmissao := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 19, True), 1);
  strChaveAcesso := fGetValorLinha(resultadoFit.Texto, '|', 7, True);
  intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 8, True), -1);
  intStatusSefaz := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 9, True), -1);
  strMensagem := fGetValorLinha(resultadoFit.Texto, '|', 10, True);
  strProtocolo := fGetValorLinha(resultadoFit.Texto, '|', 12, True);
  strDataAut := fGetValorLinha(resultadoFit.Texto, '|', 13, True);
  strTextoPuroPosicao14 := fGetValorLinha(resultadoFit.Texto, '|', 14, True);

  Try
    strQRCode := fDecodeBase64(strTextoPuroPosicao14);
  Except
    On E: Exception Do
    Begin
      If (Pos(LowerCase('Invalid Base64'), LowerCase(E.Message)) > 0) Then
        strQRCode := strTextoPuroPosicao14
      Else
        Raise;
    End;
  End;

  strEmissao := fGetValorLinha(resultadoFit.Texto, '|', 16, True);
  If fEmptyStr(strEmissao) Then
    strEmissao := strDataAut;

  dtaDataAut := StrToDateTimeDef(Copy(strDataAut, 01, 02) + '/' +
                          Copy(strDataAut, 03, 02) + '/' +
                          Copy(strDataAut, 05, 04) + ' ' +
                          Copy(strDataAut, 09, 02) + ':' +
                          Copy(strDataAut, 11, 02) + ':' +
                          Copy(strDataAut, 13, 02), 0);

  dtaEmissao := StrToDateTimeDef(Copy(strEmissao, 01, 02) + '/' +
                          Copy(strEmissao, 03, 02) + '/' +
                          Copy(strEmissao, 05, 04) + ' ' +
                          Copy(strEmissao, 09, 02) + ':' +
                          Copy(strEmissao, 11, 02) + ':' +
                          Copy(strEmissao, 13, 02), dtaDataAut);

  blnContingencia := fEmissaoContingencia(intTipoEmissao) ;
  strContingenciaAutorizada := IIF( blnContingencia And (pos('Autorizado', strMensagem) > 0), 'S','N' );

  strProtMsg := EmptyStr;
  If fCountChar(resultadoFit.Texto, '|') >= 23 Then
  Begin
    strProtMsg := fGetValorLinha(resultadoFit.Texto, '|', 23, True);
    If (Not fEmptyStr(strProtMsg)) Then
    Begin
      If fEhNumero(strProtMsg[1]) And fEhNumero(strProtMsg[2]) And
         fEhNumero(strProtMsg[3]) And fEhNumero(strProtMsg[4]) And (Not fEhNumero(strProtMsg[5])) Then
        strProtMsg := Copy(strProtMsg, 5, Length(strProtMsg));

      strProtMsg := Trim(AnsiReplaceStr(strProtMsg, '#PIPE', '|'));
    End;
  End;
end;

function TNFCEFit400.fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno;
  arrStatusSucesso: array of Integer; intTipoEmissao: Integer;
  strChaveAcesso: String; intStatus: Integer; strMensagem, strProtocolo: String;
  dtaDataAut: TDateTime; blnIgnoraContingencia: Boolean; blnOffLine: Boolean;
  strContingenciaAutorizada, strContingenciaRecusadaRejeitada: String; intStatusSefaz: Integer): TRetornoNFE;
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
    If blnOffLine Then
    Begin
      If Pos('Xml Gerado com sucesso', strMensagem) > 0 Then
      Begin
        Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso, strProtocolo, dtaDataAut);
      End
      Else
      Begin
        Result := TRetornoNFE.fCriaRetornoAguardando;
      End;

      Result.SetOffLine(blnOffLine);
    End
    Else If (fNotaContingencia(intStatus, intTipoEmissao)) And (Not blnIgnoraContingencia) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
        strProtocolo, dtaDataAut);
      Result.SetContingencia(True);
      Result.SetContingenciaAutorizada(strContingenciaAutorizada);
      If (strContingenciaRecusadaRejeitada = 'S') Then
        Result.SetRecusadaRejeitada;
    End
    Else If fStatusArrSucesso Then
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
        strProtocolo, dtaDataAut);
    End
    Else If fStatusDenegada(intStatusSefaz) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoDenegada(strMensagem, strChaveAcesso);
    End
    Else If fStatusAguardando(intStatus, strMensagem) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoAguardando;
    End
    Else
    Begin
      Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
      Result.SetRecusadaRejeitada;
    End;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem + ' Status: ' + IntToStr(intStatus) + #13#10 + resultadoFit.Texto);
    Result.SetRecusadaRejeitada;
  End;

end;

function TNFCEFit400.fItemServico(item: TDadosItem): Boolean;
begin
  Result := Pos(item.strClaFis, '5933_6933_1933_2933_') > 0;
end;

function TNFCEFit400.fEmissaoContingencia(intTipoEmissao: Integer): Boolean;
begin
  Result := (intTipoEmissao In [4,6,7,9]) ;
end;

function TNFCEFit400.fNotaContingencia(intStatus, intTipoEmissao: Integer): Boolean;
begin
  Result := ((intStatus = 2100) And fEmissaoContingencia(intTipoEmissao)) Or
            ((intStatus = 100) And fEmissaoContingencia(intTipoEmissao)) Or
            ((intStatus = 5) And fEmissaoContingencia(intTipoEmissao));
end;

function TNFCEFit400.fNotaDeComplemento: Boolean;
begin
  Result := ((Pos(fFinalidadeEmissao, FINALIDADE_AJUSTE+','+FINALIDADE_COMPLEMENTAR) > 0) And
             (Not dadosGerais.blnEst_Dv) And (Not dadosGerais.blnNotEsp) And (Not dadosGerais.blnComVal)) Or dadosGerais.blnNfComp;
end;

procedure TNFCEFit400.pExtraiDadosRetornoIdFormatoNFE(resultadoFit: TWSNfeFitRetorno;
  Var intTipoEmissao: Integer; Var strChaveAcesso: String;
  Var intStatus: Integer; Var strMensagem: String;
  Var strProtocolo: String; Var dtaDataAut: TDateTime;
  Var strContingenciaAutorizada: String;
  Var strContingenciaRecusadaRejeitada: String);
  Const
    POSICAO_STATUS_NFE : Integer = 19;
  Var
    strDataAut: String;
begin
  intTipoEmissao := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 6), 1);
  strChaveAcesso := fGetValorLinha(resultadoFit.Texto, '|', 8);
  intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 10), -1);
  strMensagem := fGetValorLinha(resultadoFit.Texto, '|', 11);
  strProtocolo := fGetValorLinha(resultadoFit.Texto, '|', 12);
  strDataAut := fGetValorLinha(resultadoFit.Texto, '|', 13);

  dtaDataAut := StrToDateTimeDef(Copy(strDataAut, 01, 02) + '/' +
                          Copy(strDataAut, 03, 02) + '/' +
                          Copy(strDataAut, 05, 04) + ' ' +
                          Copy(strDataAut, 09, 02) + ':' +
                          Copy(strDataAut, 11, 02) + ':' +
                          Copy(strDataAut, 13, 02), 0);

  If (Length(strChaveAcesso)=1) Then
  Begin
    intTipoEmissao := 1;
    strChaveAcesso := '';
    intStatus := -1;
    strMensagem := resultadoFit.Texto;
    strProtocolo := '';
    strDataAut := '';
    dtaDataAut := 0;
    pLog('extrair dados retorno formato nfe: ' + resultadoFit.Texto);
  End;

  If fContingenciaAutorizada(intTipoEmissao, strMensagem, resultadoFit.Texto, POSICAO_STATUS_NFE) Then
    strContingenciaAutorizada := 'S'
  Else
    strContingenciaAutorizada := 'N';

  If fContingenciaRecusadaRejeitada(intTipoEmissao, resultadoFit.Texto, POSICAO_STATUS_NFE) Then
    strContingenciaRecusadaRejeitada := 'S'
  Else
    strContingenciaRecusadaRejeitada := 'N';
end;

function TNFCEFit400.fValorCampo(strNomeTabela, strNomeCampo: String;
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

function TNFCEFit400.fStatusDenegada(intStatus: Integer): Boolean;
  Const
    RET_DENEGADA: Array[1..5] Of Integer = (DENEGADA_110, DENEGADA_205, DENEGADA_301, DENEGADA_302, DENEGADA_303);
  Var
    intIndice: Integer;
begin
  Result := False;

  For intIndice := Low(RET_DENEGADA) To High(RET_DENEGADA) Do
  Begin
    If RET_DENEGADA[intIndice] = intStatus Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TNFCEFit400.fStatusAguardando(intStatus: Integer; strMensagem: String): Boolean;
  Var
    intIndice: Integer;
  const
    MSG_MESMO_HASH = 'HASH do Arquivo TXT igual ao ultimo Arquivo Enviado ou Arquivo em looping';
    MSG_MAX_REENVIOS = 'Processando/Transmitindo - Maximo de reenvios atingido (5)';
  Const
    RET_STATUS_AGUARDANDO: Array[1..10] Of Integer = (1, 2, 3, 103, 104, 105, 106, 204, 990, 9998);
begin
  Result := False;
  //Documento estava com erro(s) e reenviou sem corrigir.
  If strMensagem = MSG_MESMO_HASH Then
    Exit;
  //Documento estava com erro(s) e reenviou sem corrigir.
  If strMensagem = MSG_MAX_REENVIOS Then
    Exit;
  For intIndice := Low(RET_STATUS_AGUARDANDO) To High(RET_STATUS_AGUARDANDO) Do
  Begin
    If RET_STATUS_AGUARDANDO[intIndice] = intStatus Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TNFCEFit400.fAjustaCSTSimplesX40_e_X41(strCodSit, strCSOSN: String): String;
var
  strCsoX40: String;
begin
  Result := strCSOSN;

  If not (Pos(strCodSit, '40_41_') > 0) Then
    Exit;

  strCsoX40 := fCfgSisFonte(fonteDados, 'CSOX40');

  If fEmptyStr(strCsoX40) Then
    Exit;

  Result := strCsoX40;
end;

function TNFCEFit400.fRetornaCSTSimples(dadosEmitente: TDadosEmitente;
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
    Result := '900'

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

  Result := fAjustaCSTSimplesX40_e_X41(strCodSitTmp, Result);

end;

function TNFCEFit400.fDeterminaCSTIpi(item: TDadosItem; blnIteSer: Boolean): String;
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

function TNFCEFit400.fDocumentoInvalido(strRetorno: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(strRetorno)) Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCountChar(strRetorno, '|') = 1) Then
  Begin
    Result := True;
    Exit;
  End;
end;

function TNFCEFit400.fContingenciaAutorizada(const intTipoEmissao: Integer; const strMensagem, strTextoRetornoFit: String; const intPosicaoStatusNFE: Integer): Boolean;
  Const
    STATUS_AUTORIZADA : String = '5';
begin
  Result := False;

  If (Not fEmissaoContingencia(intTipoEmissao)) Then
    Exit;

  If (Pos('Autorizado', strMensagem) > 0) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not fEmptyStr(strTextoRetornoFit)) And
     (fCountChar(strTextoRetornoFit, '|') >= intPosicaoStatusNFE) Then
  Begin
    If (fGetValorLinha(strTextoRetornoFit, '|', intPosicaoStatusNFE) = STATUS_AUTORIZADA) And
       (Pos('Off-Line', strMensagem) > 0) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TNFCEFit400.fContingenciaRecusadaRejeitada(const intTipoEmissao: Integer; const strTextoRetornoFit: String; const intPosicaoStatusNFE: Integer): Boolean;
  Const
    STATUS_RECUSADA_REJEITADA : String = '4';
begin
  Result := False;

  If (Not fEmissaoContingencia(intTipoEmissao)) Then
    Exit;

  If (Not fEmptyStr(strTextoRetornoFit)) And
     (fCountChar(strTextoRetornoFit, '|') >= intPosicaoStatusNFE) Then
  Begin
    If (fGetValorLinha(strTextoRetornoFit, '|', intPosicaoStatusNFE) = STATUS_RECUSADA_REJEITADA) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TNFCEFit400.fCriaObjetoLogPerformance(intCodigo: Integer; strMensagem: String): TLogPerformance;
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

function TNFCEFit400.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
  var
    strImpressoraNFCe : String;
begin
  If (Not Assigned(dadosGeraisArg)) Or (fEmptyStr(dadosGeraisArg.strPontoImpressao)) Then
  begin
    Result := fRetornaFilaImpressaoNFCe(fonteDados);
    pLogImp('Filas de impressao NFCe (FILNFC): "' + Result + '"');
    If fEmptyStr(Result) Then
    Begin
      strImpressoraNFCe := '';
      if (fCfgSisFonte(fonteDados,'PRNFCE') = 'S') then
      Begin
        strImpressoraNFCe := fImpressoraConfiguradaOpcoesNfce;
        pLogImp('Impressora opcoes_nfce.ini: "' + strImpressoraNFCe + '"');
      End;
      If (fEmptyStr(strImpressoraNFCe)) Then
      Begin
        strImpressoraNFCe := objConfig.strFitImpressoraPadrao;
        pLogImp('objConfig.strFitImpressoraPadrao: "' + strImpressoraNFCe + '"');
      End;
      Result := fIdentificarNomeDaImpressora(fonteDados, strImpressoraNFCe);
    End;
  End
  Else
  Begin
    pLogImp('dadosGeraisArg.strPontoImpressao: "' + dadosGeraisArg.strPontoImpressao + '"');
    Result := fIdentificarNomeDaImpressora(fonteDados, dadosGeraisArg.strPontoImpressao);
  End;
  pLogImp('Impressora para impressao NFCe: "' + Result + '"');
end;

procedure TNFCEFit400.pIntegracaoPainelCitelNFCe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFCE');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFCE_XML');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFCE_PDF');
end;

procedure TNFCEFit400.pIntegracaoPainelCitelNFCeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFCE_CANCELAMENTO');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFCE_CANCELAMENTO_XML');
end;

procedure TNFCEFit400.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin

end;

function TNFCEFit400.fConsultaStatusDFe(strChaveAcesso: string): String;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatus: Integer;
    strMensagem: String;
    strCancelado: String;

    stlArquivo: TStringList;
begin
  pLogImp('TNFCEFit400.fConsultaStatusDFe >');

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
  End;
end;

function TNFCEFit400.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
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

function TNFCEFit400.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55'): String;
  Var
    retornoFit : TWSNfeFitRetorno;
    intStatus : Integer;
begin
  Try
    retornoFit := fitWrapper.fConsultaSituacaoInutilizacao(strCnpjEmitente, strNumeroSerie, strNumeroDocumento, strModeloFiscal);
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

procedure TNFCEFit400.pDFeReformaTributaria;
var
  LNFCeOffLine: Boolean;
begin
  LNFCeOffLine := (dadosGerais.blnNFCeOffLine Or fitWrapper.blnOffLine);

  ReformaTributaria.pReformaTributaria(dadosEmitente, dadosGerais, lstItens, stlArquivo, LNFCeOffLine);
end;

function TNFCEFit400.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude,
  strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFCEFit400.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFCEFit400.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega,
  strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFCEFit400.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFCEFit400.fCupomAindaAutorizadaNaSefaz(const strChaveAcesso: String; var strProtocolo: String; var dtaDataAut: TDateTime): Boolean;
  Var
    retornoFit: TWSNfeFitRetorno;
    strCancelado: String;
    strDataAut: String;
begin
  pLogImp('TNFCEFit400.fCupomAindaAutorizadaNaSefaz');

  strProtocolo := '';
  dtaDataAut   := 0;

  retornoFit := fitWrapper.fConsultaStatusDFe('FIT_NFE_CONSULTA_CHAVE_ACESSO', strChaveAcesso);
  Try
    strCancelado := fGetValorLinha(retornoFit.Texto, '|', 20);
    strProtocolo := fGetValorLinha(retornoFit.Texto, '|', 12);
    strDataAut   := fGetValorLinha(retornoFit.Texto, '|', 13);

    dtaDataAut := StrToDateTimeDef(Copy(strDataAut, 01, 02) + '/' +
                                   Copy(strDataAut, 03, 02) + '/' +
                                   Copy(strDataAut, 05, 04) + ' ' +
                                   Copy(strDataAut, 09, 02) + ':' +
                                   Copy(strDataAut, 11, 02) + ':' +
                                   Copy(strDataAut, 13, 02), 0);

    Result := (strCancelado <> 'S');
  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);
  End;
end;

end.
