unit untNFSEnotas;

interface

uses untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils, NfeApiEnotas;

Type
  TNFSEnotas = class(TAbstractAdministrativoService, INFE)
    private
      EnotasWrapper: TWSNFeEnotas;
      fonteDados: IFonteDados;

      dadosGerais: TDadosGerais;
      dadosEmitente: TDadosEmitente;
      TotalServico: TTotalServico;
      lstItens: TList;
      strDiscriminacaoServico : String;
      strRegimeEspecialTributacaoIntermunicipal: String;
      blnGeraSchemaReformaTributaria: Boolean;

      stlEmails: TStringList;

      strNumeroNSe: String;
      strNumeroRps: String;
      strSerieRps: String;

      fltIBPT_F: Double;
      fltIBPT_E: Double;
      fltIBPT_M: Double;
      fltIBPT_P: Double;

      function fAmbienteDeHomologacao: Boolean;
      function fLimpaCaracteresInvalidos(strTexto: String): String;
      function fFormataCampo(strValor: String): String;
      function fNumerico(fltValor: Double; intDecimais: Integer): String;
      function fRetornaId: String;
      procedure pAcrescentaResponsavelRetencao;
      procedure pCalculaTotalServico;
      procedure pPreparaNotaFiscal(stlArquivo: TStringList);
      procedure pServicoPrestado(stlArquivo: TStringList);
      procedure pMontaLinhaDescricaoServicos(dadosItem: TDadosItem; var strDesSer: String);
      procedure pAcrescentaMensagemDescricaoServicos(var strDesSer: String);
      procedure pAcrescentaDescricaoServicos(var strDesSer: String);
      procedure pAdicionarServicosConcatenados(stlArquivo: TStringList);

      procedure pImprimirDanfeInterna(strChaveAcesso, strImpressora: String; intViasServidor: Integer; strIdNota: String; strImprimirTelaPDF: String = '');
      function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
      procedure pPrepararEmails;
      function fStatusAguardando(strMensagem: String): Boolean;
      function fIBGEsQueObrigamCodigosFormatados(const strCodigoIBGE: String): Boolean;
      function fDataHora(const dta: TDateTime): String;
      function fRetornaLocalDoServico: String;
      function fGetIbgeLocalServico: String;
      function fRetornaNaturezaOperacao: String;
      function fRetornaNaturezaOperacaoPrioritaria(strNatSer: String): String;
      procedure pIntegracaoPainelCitelNFSe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
      procedure pIntegracaoPainelCitelNFSeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
      procedure pMontaMetadados(stlArquivo: TStringList);
      function fAjustaCNAE(const strCNAE: String): String;
      function fAjustaSerieRPS(const strSerieRps: String): String;
      function fRetornaQuebraDeLinha: String;
      function fEhServicoParaClienteConsumidor: Boolean;
      function fUsaMetadados: Boolean;
      function fUsaMetadadosParaRegimeEspecialTributacaoIntermunicipal: Boolean;
      function fUsaMetadadosParaEnviarLocalDaObra: Boolean;
      function fUsaMetadadosParaEnviarEnderecoDoLocalDaObra: Boolean;
      function fUsaMetadadosParaEnviarCidadeDoEmitenteComoMunicipioDeIncidenciaDeISS: Boolean;
      function fRetornaMensagemDadosFiscais: String;
      function fEnviaAliquotaISS: Boolean;
      procedure pCalculaIBPT;
      function fTraduzTipoEnteGovernamental(const strOpc: String): string;
      function fTraduzTipoOperacaoEnteGovernamental(const strOpc: String): string;
    public
      function fEnviarNota: Boolean;
      function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
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
      function fRetXMLNfe(strChaveAcesso: string): string;
      function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
      function fEnviaNFCeXmlOffLine: Boolean;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

      function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;

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
  end;

implementation

uses untUtilNFSe, untUtil, untFuncoesLibNfe, untConstantesNFe, untDicSis;

{ TNFSEnotas }

constructor TNFSEnotas.Create(fonteDados: IFonteDados);
begin
  Self.fonteDados := fonteDados;
  EnotasWrapper   := TWSNFeEnotas.Create;
  TotalServico    := TTotalServico.Create;
  stlEmails       := TStringList.Create;

  pLogEnotas('TNFSEnotas.Create');
end;

destructor TNFSEnotas.Destroy;
begin
  If Assigned(lstItens) Then
    FreeAndNil(lstItens);

  If Assigned(EnotasWrapper) Then
    FreeAndNil(EnotasWrapper);

  If Assigned(TotalServico) Then
    FreeAndNil(TotalServico);

  If Assigned(stlEmails) Then
    FreeAndNil(stlEmails);

  pLogEnotas('TNFSEnotas.Destroy');

  inherited;
end;

function TNFSEnotas.fAmbienteDeHomologacao: Boolean;
begin
  Result := (pos('hom',fCfgSisFonte(Self.FonteDados, 'CITURL')) > 0);
end;

function TNFSEnotas.fRetornaId: String;
var
  strIdExterno : string;
begin
  strIdExterno := dadosGerais.strNumDoc + '-' +
                  dadosGerais.strEspDoc + '-' +
                  dadosGerais.strCodEmp + '-' +
                  dadosGerais.strCodCli + '-' +
                  dadosGerais.strSerie  + '-' +
                  dadosGerais.strTip_FC;

  If fAmbienteDeHomologacao Then
    Result := 'H-' + strIdExterno
  Else
    Result := 'P-' + strIdExterno;
end;

function TNFSEnotas.fRetXMLNfe(strChaveAcesso: string): string;
begin
  EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

  result := EnotasWrapper.fRetXMLNfe(strChaveAcesso);
End;

// https://api.enotasgw.com.br/v1/empresas/{empresaId}/nfes/porIdExterno/{idExterno}
function TNFSEnotas.fCancelarNota(strNumDoc, strSerie,  strMotivo: String): Boolean;
Var
  retornoEnotas: TWSNfeEnotasRetorno;
  intStatus: Integer;
  strMensagem: String;
  stlArquivo: TStringList;
begin
  EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

  retornoEnotas := EnotasWrapper.fConsultaSituacaoId(fRetornaId);

  intStatus   := StrToIntDef(fGetValorLinha(retornoEnotas.Texto, '|', 1), 0);
  strMensagem := fGetValorLinha(retornoEnotas.Texto, '|', 2);

  If (intStatus = 200) And (strMensagem = 'Cancelada') Then
  Begin
    Result := True;
    Exit;
  End;

  retornoEnotas := EnotasWrapper.fCancelaNotaFiscal(fRetornaId);

  stlArquivo := TStringList.Create;
  Try
    stlArquivo.Add(retornoEnotas.Texto);
    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_CANC_NFS.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  If Not retornoEnotas.RetornoOk Then
  Begin
    Raise ErrosValidacaoNFE.fCriaErroSimples(retornoEnotas.Texto);
  End;

  Result := retornoEnotas.RetornoOk;

end;

function TNFSEnotas.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
  Result := '';

  If fEmptyStr(AChaveAcesso) Then
  Begin
    Raise Exception.Create('A chave de acesso deve ser informada.');
  End;

  Try
    EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

    Result := EnotasWrapper.fDownloadDanfe(AChaveAcesso, dadosGerais.strNumDoc, 'DownloadPDF', 0, AChaveAcesso, Self.fonteDados, False, 'PDF', AIgnorarLayoutSimplificado);
  Except
    On E: Exception Do
    Begin
      Raise ErrosValidacaoNFE.fCriaErroSimples(E.Message);
    End;
  End;
end;

procedure TNFSEnotas.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
var
  NFSeXML: TNFSeXML;
begin
  If (fCfgSisFonte(Self.fonteDados, 'NFSCIT') <> 'S') Then
    Exit;

  pLogEnotas('pGerarXmlCitel >');

  If (Not Assigned(lstItens)) Or (lstItens.Count = 0) Then
  Begin
    pLogEnotas('pGerarXmlCitel < lstItens vazio - fluxo de status, XML não gerado');
    Exit;
  End;

  Try
    Try
      NFSeXML := TNFSeXML.Create(fonteDados, lstItens, TotalServico);
      NFSeXML.pGerarXML(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso);
    Finally
      FreeAndNil(NFSeXML);
    End;
  Except
    On E: Exception Do
      pLogEnotas('pGerarXmlCitel Exception: ' + E.Message);
  End;

  pLogEnotas('pGerarXmlCitel <');
end;

function TNFSEnotas.fEnviarNota: Boolean;
Var
  stlArquivo: TStringList;
  retornoEnotas: TWSNfeEnotasRetorno;
begin
  pLogEnotas('TNFSEnotas.fEnviarNota >');

  EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

  pPrepararEmails;

  stlArquivo := TStringList.Create;
  Try
    pCalculaTotalServico;

    pPreparaNotaFiscal(stlArquivo);

    retornoEnotas := EnotasWrapper.fEnviaNotaFiscal(stlArquivo.Text);

    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_ENVIO_NFS.TXT'));

      Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                    dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ENVIO', stlArquivo.Text);
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  If Not retornoEnotas.RetornoOk Then
  Begin
    Raise ErrosValidacaoNFE.fCriaErroSimples(retornoEnotas.Texto);
  End;

  If retornoEnotas.RetornoOk Then
  Begin
    pGerarXmlCitel(strNumeroNSe, strNumeroRps, strSerieRps, fRetornaId);
  End;

  Result := retornoEnotas.RetornoOk;

  pLogEnotas('TNFSEnotas.fEnviarNota <');
end;

function TNFSEnotas.fDataHora(const dta: TDateTime): String;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', dta);
end;

function TNFSEnotas.fAjustaSerieRPS(const strSerieRps: String): String;
var
  strSerieComplementar: String;
begin
  Result := strSerieRps;

  strSerieComplementar := fCfgSisFonte(Self.FonteDados, 'NSSERC') ;

  If not fEmptyStr(strSerieComplementar) Then
  Begin
    Result := Result + strSerieComplementar;
    Exit;
  End;

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE LIMEIRA') Then
    Result := 'RPSL';
end;

procedure TNFSEnotas.pCalculaIBPT;
var
  dadosItem: TDadosItem;
begin
  Self.fltIBPT_F := 0;
  Self.fltIBPT_E := 0;
  Self.fltIBPT_M := 0;
  Self.fltIBPT_P := 0;

  If not Assigned(lstItens) Then
    Exit;

  dadosItem := TDadosItem(lstItens[0]);

  Self.fltIBPT_F := dadosItem.fltIBPT_F;
  Self.fltIBPT_E := dadosItem.fltIBPT_E;
  Self.fltIBPT_M := dadosItem.fltIBPT_M;
  Self.fltIBPT_P := Self.fltIBPT_F + Self.fltIBPT_M;
end;

function TNFSEnotas.fTraduzTipoEnteGovernamental(const strOpc: String): string;
begin
  Result := '';
  If fEmptyStr(strOpc) Then
    Exit;

  Case AnsiUpperCase(strOpc)[1] Of
    'U': Result := 'Uniao';
    'E': Result := 'Estado';
    'D': Result := 'DistritoFederal';
    'M': Result := 'Municipio';
    Else Result := '';
  End;
end;

function TNFSEnotas.fTraduzTipoOperacaoEnteGovernamental(const strOpc: String): string;
begin
  Result := '';
  If fEmptyStr(strOpc) Then
    Exit;

  Case AnsiUpperCase(strOpc)[1] Of
    '1': Result := 'FornecimentoComPagamentoPosterior';
    '2': Result := 'RecebimentoDoPagamentoComFornecimentoJaRealizado';
    '3': Result := 'FornecimentoComPagamentoJaRealizado';
    '4': Result := 'RecebimentoDoPagamentoComFornecimentoPosterior';
    '5': Result := 'FornecimentoERecebimentoDoPagamentoConcomitantes';
    Else Result := '';
  End;
end;

procedure TNFSEnotas.pPreparaNotaFiscal(stlArquivo: TStringList);
Var
  strNomeCidade: String;
  strLogradouro: String;
  strNumeroEnd: String;
  strComplementoEnd: String;
  strBairro: String;
  strCodIbge: String;
  strCEP: String;
  strUF: String;

  strTipoRpsSub: String;
  intIntRps : Integer;
  strIntRps : String;
  strInscMunicipal : String;
  strInscEstadual : String;
  strCnpjDestinatario : String;
  strTipoPessoaDestinatario: String;
  strMensagemDadosFiscais: String;
  strDataCompetencia: String;
  fltPercentualIcmsSimples: Double;

  function fEnviarObservacoes: Boolean;
  begin
    Result := False;

    If fEmptyStr(strMensagemDadosFiscais) Then
      Exit;

    If fCfgSisFonte(Self.FonteDados, 'MENNFS') = 'S' Then
      Exit;

    Result := True;
  end;

  function fEnviaIBPT: Boolean;
  begin
    Result := False;

    If (fCfgSisFonte(Self.FonteDados, 'IBPTNA') = 'S') Then
      Exit;

    If not (fCfgSisFonte(Self.FonteDados, 'IBPTNS') = 'S') Then
      Exit;

    If not (Self.fltIBPT_P > 0) Then
      Exit;

    Result := True;
  end;

  function fEnviaIBPT_Nacional: Boolean;
  begin
    Result := False;

    If not (fCfgSisFonte(Self.FonteDados, 'IBPTNS') = 'S') Then
      Exit;

    If not (fCfgSisFonte(Self.FonteDados, 'IBPTNA') = 'S') Then
      Exit;

    Result := True;
  end;

  procedure pInverteDiscriminacao_e_Mensagem;
  var
    strDiscriminacaoServicoOriginal: String;
    strMensagemDadosFiscaisOriginal: String;
  begin
    If not (fCfgSisFonte(Self.FonteDados, 'ENOINV') = 'S') Then
      Exit;

    strDiscriminacaoServicoOriginal := strDiscriminacaoServico;
    strMensagemDadosFiscaisOriginal := strMensagemDadosFiscais;

    strDiscriminacaoServico := strMensagemDadosFiscaisOriginal;
    strMensagemDadosFiscais := strDiscriminacaoServicoOriginal;
  end;

  function fRetornaNaturezaDaOperacao: String;
  var
    intCont: Integer;
    dadosItem: TDadosItem;
  Begin
    Result := fRetornaNaturezaOperacao;

    If not (fCfgSisFonte(Self.FonteDados, 'NSNATP') = 'S') Then
      Exit;

    If (Not Assigned(lstItens)) Then
      Exit;

    For intCont := 0 To lstItens.Count-1 Do
    Begin
      dadosItem := TDadosItem(lstItens[intCont]);

      If not fEmptyStr(dadosItem.strNfsNat) Then
      Begin
        Result := dadosItem.strNfsNat;
        Break;
      End;
    End;
  End;

  function fModeloSimplesNacional: Boolean;
  begin
    Result := False;

    If not (fCfgSisFonte(Self.FonteDados, 'SIMPAU') = 'S') Then
      Exit;

    If not (fCfgSisFonte(Self.FonteDados, 'IBPT_S') = 'S') Then
      Exit;

    Result := True;
  end;

begin

  blnGeraSchemaReformaTributaria := (fCfgSisFonte(Self.FonteDados, 'USANSR') = 'S');

  strIntRps := fCfgSisFonte(Self.FonteDados, 'INTRPS');

  If Not fEmptyStr(strIntRps) Then
    intIntRps := StrToIntDef(strIntRps, 0)
  Else
    intIntRps := 0;

  strNumeroNSe := IntToStr(Floor(StrToFloat(dadosGerais.strNumDoc)));
  strNumeroRps := IntToStr(Floor(StrToFloat(dadosGerais.strNumDoc)) - intIntRps);
  strSerieRps  := dadosGerais.strSerie;

  strNomeCidade       := dadosGerais.strNomeCidade;
  strLogradouro       := dadosGerais.strLogradouro;
  strNumeroEnd        := dadosGerais.strNumeroEnd;
  strComplementoEnd   := dadosGerais.strComplementoEnd;
  strBairro           := dadosGerais.strBairro;
  strCodIbge          := dadosGerais.strCodIbge;
  strCEP              := dadosGerais.strCEP;
  strUF               := dadosGerais.strEstado;
  strInscEstadual     := dadosGerais.strIES;
  strInscMunicipal    := dadosGerais.strInscMunicipal;
  strDataCompetencia  := fDataHora(dadosGerais.dtaCompetencia);

  strCnpjDestinatario := IIF((fCfgSisFonte(Self.FonteDados, 'NSSCPF') = 'S') And fEmptyStr(dadosGerais.strCnpj),
                              IIF((fCfgSisFonte(Self.FonteDados, 'CPFBRA') = 'S'), '', '00000000000'),
                              dadosGerais.strCnpj);

  strTipoPessoaDestinatario := IIF(Length(strCnpjDestinatario) = 14, 'J', 'F');

  strTipoRpsSub := '';
  If Not fEmptyStr(dadosGerais.strNumeroRpsSubstituto) Then
  Begin
    strTipoRpsSub := '1';
  End;

  If fEmptyStr(strNumeroEnd) Or (strNumeroEnd = '0') Then
    strNumeroEnd := '00';

  If Not fEmptyStr(dadosGerais.strDisSer) Then
    strDiscriminacaoServico := AnsiReplaceStr(dadosGerais.strDisSer, '<<csq>>', ' ')
  Else
    strDiscriminacaoServico := '';

  If (fEmptyStr(strInscMunicipal)) And
     (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
  Begin
    strInscMunicipal := '000000000';
  End;

  strSerieRps := fAjustaSerieRPS(strSerieRps);

  strRegimeEspecialTributacaoIntermunicipal := fCfgSisFonte(Self.FonteDados, 'ENORET');

  strDiscriminacaoServico := fTiraCaracEspeciais(strDiscriminacaoServico, False);
  strDiscriminacaoServico := AnsiReplaceStr(AnsiReplaceStr(strDiscriminacaoServico, #13, fRetornaQuebraDeLinha), #10, '');

  strMensagemDadosFiscais := fRetornaMensagemDadosFiscais;

  fltPercentualIcmsSimples := StrToFloatDef(fCfgSisFonte(Self.FonteDados, 'ICMSIM'), 0);
  fltPercentualIcmsSimples := IIF(fltPercentualIcmsSimples > 0, fltPercentualIcmsSimples, 0);

  pCalculaIBPT;

  pInverteDiscriminacao_e_Mensagem;

  stlArquivo.Add('{');
  stlArquivo.Add('   "idExterno":"'+fRetornaId+'",');

  If fAmbienteDeHomologacao Then
    stlArquivo.Add('   "ambienteEmissao":"Homologacao",')
  Else
    stlArquivo.Add('   "ambienteEmissao":"Producao",');

  stlArquivo.Add('   "numeroRps":'+strNumeroRps+','); //Inteiro - Enviado quando o sistema de origem opta por realizar o gerenciamento do RPS
  stlArquivo.Add('   "serieRps": "'+strSerieRps+'",'); //String - Enviado quando o sistema de origem opta por realizar o gerenciamento da série do RPS
  stlArquivo.Add('   "tipo":"NFS-e",');
  stlArquivo.Add('   "dataCompetencia": "'+strDataCompetencia+'", ');
  stlArquivo.Add('   "enviarPorEmail":'+IIF(fCfgSisFonte(Self.FonteDados, 'ENOEMA') = 'S', 'true', 'false')+',');

  If fEnviaIBPT_Nacional Then
  Begin
    If fModeloSimplesNacional Then
    Begin
      stlArquivo.Add('   "percentualAproximadoTributos": {');
      stlArquivo.Add('     "simplesNacional": {');
      stlArquivo.Add('        "aliquota":'+fNumerico(fltPercentualIcmsSimples, 2)+' ');
      stlArquivo.Add('        }');
      stlArquivo.Add('   },');
    End
    Else
    Begin
      stlArquivo.Add('   "percentualAproximadoTributos": {');
      stlArquivo.Add('     "detalhado": {');
      stlArquivo.Add('        "percentualFederal":'+fNumerico(Self.fltIBPT_F, 2)+', ');
      stlArquivo.Add('        "percentualEstadual":'+fNumerico(Self.fltIBPT_E, 2)+', ');
      stlArquivo.Add('        "percentualMunicipal":'+fNumerico(Self.fltIBPT_M, 2)+' ');
      stlArquivo.Add('        }');
      stlArquivo.Add('   },');
    End;
  End;

  If fEnviaIBPT Then
  Begin
    stlArquivo.Add('   "fontePercentualAproximadoTributos": "IBPT",');
    stlArquivo.Add('   "percentualAproximadoTributos":'+fNumerico(Self.fltIBPT_P, 2)+',');

    strMensagemDadosFiscais := strMensagemDadosFiscais + ' Conf.Lei 12.741/12 – Valor Aprox.dos Tributos: Federal: '+FormatFloat('0.00', Self.fltIBPT_F)+'% e Municipal: '+FormatFloat('0.00', Self.fltIBPT_M)+'% ';
  End;

  stlArquivo.Add('   "dadosAdicionaisEmail":{');
  stlArquivo.Add('      "outrosDestinatarios":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strEmails, False))+'');
  stlArquivo.Add('   },');

  If fEhServicoParaClienteConsumidor Then
  Begin
    stlArquivo.Add('   "cliente":{');
    stlArquivo.Add('      "tipoPessoa": "F",');
    stlArquivo.Add('      "nome": "AO CONSUMIDOR",');
    stlArquivo.Add('      "email": null,');
    stlArquivo.Add('      "cpfCnpj": null,');
    stlArquivo.Add('      "inscricaoMunicipal": null,');
    stlArquivo.Add('      "inscricaoEstadual": null,');
    stlArquivo.Add('      "telefone": null');
    stlArquivo.Add('   },');
  End
  Else
  Begin
    stlArquivo.Add('   "cliente":{');
    stlArquivo.Add('      "tipoPessoa":"'+strTipoPessoaDestinatario+'",');
    stlArquivo.Add('      "nome":'+fFormataCampo(dadosGerais.strNomCli)+',');
    stlArquivo.Add('      "email":"'+fApenasUmEmail(fTiraCaracEspeciais(dadosGerais.strEmail, False))+'",');
    stlArquivo.Add('      "cpfCnpj":'+fFormataCampo(strCnpjDestinatario)+',');
    stlArquivo.Add('      "inscricaoMunicipal":'+fFormataCampo(strInscMunicipal)+',');
    stlArquivo.Add('      "inscricaoEstadual":'+fFormataCampo(strInscEstadual)+',');
    stlArquivo.Add('      "telefone":'+fFormataCampo(dadosGerais.strTelefone));

    stlArquivo.Add(',     "endereco":{');

    If strUF = 'EX' Then
      stlArquivo.Add('         "pais":'+fFormataCampo(dadosGerais.strCodigoPais)+',');

    stlArquivo.Add('         "uf":'+fFormataCampo(strUF)+',');
    stlArquivo.Add('         "cidade":'+fFormataCampo(strCodIbge)+',');
    stlArquivo.Add('         "logradouro":'+fFormataCampo(strLogradouro)+',');
    stlArquivo.Add('         "numero":'+fFormataCampo(fTiraCaracEspeciais(strNumeroEnd))+',');
    stlArquivo.Add('         "complemento":'+fFormataCampo(fTiraCaracEspeciais(strComplementoEnd, False))+',');
    stlArquivo.Add('         "bairro":'+fFormataCampo(strBairro)+',');
    stlArquivo.Add('         "cep":'+fFormataCampo(strCEP)+'');
    stlArquivo.Add('      }');
    stlArquivo.Add('   },');
  End;

  pServicoPrestado(stlArquivo);

  stlArquivo.Add('   "naturezaOperacao": '+fFormataCampo(fRetornaNaturezaDaOperacao)+',');
  stlArquivo.Add('   "deducoes":'+fNumerico(TotalServico.fltValDed, 2)+',');

  If dadosGerais.fltTotDescInc > 0 Then
    stlArquivo.Add('   "deducoes":'+fNumerico(dadosGerais.fltTotDescInc, 2)+',');

  stlArquivo.Add('   "valorTotal":'+fNumerico(dadosGerais.fltTotSer, 2)+',');

  If not fEmptyStr(dadosGerais.strIdNFSeSub) Then
  Begin
    stlArquivo.Add('   "idExternoSubstituir":'+fFormataCampo(dadosGerais.strIdNFSeSub)+',');
  End;

  If not fEmptyStr(dadosGerais.strCodObr) Then
  Begin
    stlArquivo.Add('   "construcaoCivil": { ');
    stlArquivo.Add('     "inscricaoImobiliariaFiscal":'+fFormataCampo(dadosGerais.strInsImo)+',');
    stlArquivo.Add('     "art":'+fFormataCampo(dadosGerais.strCodArt)+',');
    stlArquivo.Add('     "codigoObra":'+fFormataCampo(dadosGerais.strCodObr)+',');
    stlArquivo.Add('     "codigoCIB":'+fFormataCampo(dadosGerais.strCodCib)+',');
    stlArquivo.Add('     "cei":'+fFormataCampo(dadosGerais.strCodCno)+',');

    If fEmptyStr(dadosGerais.strNomCidEndEnt) Then
    Begin
      stlArquivo.Add('     "enderecoObra": { ');
      stlArquivo.Add('       "logradouro":'+fFormataCampo(dadosGerais.strLogradouro)+',');
      stlArquivo.Add('       "numero":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strNumeroEnd))+',');
      stlArquivo.Add('       "complemento":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strComplementoEnd))+',');
      stlArquivo.Add('       "bairro":'+fFormataCampo(dadosGerais.strBairro)+',');
      stlArquivo.Add('       "cep":'+fFormataCampo(dadosGerais.strCEP)+'');
      stlArquivo.Add('     } ');
    End
    Else
    Begin
      stlArquivo.Add('     "enderecoObra": { ');
      stlArquivo.Add('       "logradouro":'+fFormataCampo(dadosGerais.strLogradouroEndEnt)+',');
      stlArquivo.Add('       "numero":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strNumeroEndEnt))+',');
      stlArquivo.Add('       "complemento":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strComplementoEndEnt))+',');
      stlArquivo.Add('       "bairro":'+fFormataCampo(dadosGerais.strBairroEndEnt)+',');
      stlArquivo.Add('       "cep":'+fFormataCampo(dadosGerais.strCEPEndEnt)+'');
      stlArquivo.Add('     } ');
    End;

    stlArquivo.Add('   }, ');
  end;

  If fEnviarObservacoes Then
    stlArquivo.Add('   "observacoes":'+fFormataCampo(fTiraCaracEspeciais(strMensagemDadosFiscais, False)))
  Else
    stlArquivo.Add('   "observacoes":"-"');

  pMontaMetadados(stlArquivo);

  stlArquivo.Add('}');

end;

procedure TNFSEnotas.pMontaLinhaDescricaoServicos(dadosItem: TDadosItem; var strDesSer: String);
begin
  If (Not fEmptyStr(strDesSer)) Then
    strDesSer := strDesSer + fRetornaQuebraDeLinha;

  If (objConfigInterna.strTpNfCr = J_A_MASSA_CONCRETO) Then
    strDesSer := strDesSer + dadosItem.strDesIte + ' R$ ' + FormatFloat('###,###,##0.00', dadosItem.fltUnitar)
  Else
    strDesSer := strDesSer + dadosItem.strDesIte;

end;

function TNFSEnotas.fRetornaMensagemDadosFiscais: String;
begin
  If Not fEmptyStr(dadosGerais.strMen001) then
    Result := Result + ' ' + dadosGerais.strMen001;

  If Not fEmptyStr(dadosGerais.strMen002) then
    Result := Result + ' ' + dadosGerais.strMen002;

  If Not fEmptyStr(dadosGerais.strMen003) then
    Result := Result + ' ' + dadosGerais.strMen003;

  If Not fEmptyStr(dadosGerais.strMen004) then
    Result := Result + ' ' + dadosGerais.strMen004;

  If Not fEmptyStr(dadosGerais.strMen005) then
    Result := Result + ' ' + dadosGerais.strMen005;
end;

procedure TNFSEnotas.pAcrescentaMensagemDescricaoServicos(var strDesSer: String);
begin
  If fCfgSisFonte(Self.FonteDados, 'MENNFS') = 'S' Then
  Begin
    If Not fEmptyStr(dadosGerais.strMen001) then
      strDesSer := strDesSer + ' ' + dadosGerais.strMen001;

    If Not fEmptyStr(dadosGerais.strMen002) then
      strDesSer := strDesSer + ' ' + dadosGerais.strMen002;

    If Not fEmptyStr(dadosGerais.strMen003) then
      strDesSer := strDesSer + ' ' + dadosGerais.strMen003;

    If Not fEmptyStr(dadosGerais.strMen004) then
      strDesSer := strDesSer + ' ' + dadosGerais.strMen004;

    If Not fEmptyStr(dadosGerais.strMen005) then
      strDesSer := strDesSer + ' ' + dadosGerais.strMen005;
  End;
end;

procedure TNFSEnotas.pAcrescentaDescricaoServicos(var strDesSer: String);
begin
  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS') Then
  Begin
    If Not fEmptyStr(dadosGerais.strDisSer) Then
      strDesSer := AnsiReplaceStr(dadosGerais.strDisSer, '<<csq>>', '');
  End
  Else
  If (objConfigInterna.strTpNfCr = J_A_MASSA_CONCRETO) Then
  Begin
    If Not fEmptyStr(dadosGerais.strDisSer) Then
      strDesSer := strDesSer + ' ' + AnsiReplaceStr(dadosGerais.strDisSer, '<<csq>>', '');
  End;

  If Not fEmptyStr(dadosGerais.strOrdMaoObraCli) Then
    strDesSer := strDesSer + ' ' + dadosGerais.strOrdMaoObraCli;

  If Not fEmptyStr(dadosGerais.strObsNFSOrdServ) Then
    strDesSer := strDesSer + ' ' + dadosGerais.strObsNFSOrdServ;

  pAcrescentaMensagemDescricaoServicos(strDesSer);

  If Not fEmptyStr(dadosGerais.strMensagemAplicacao) Then
  begin
    If (Not fEmptyStr(strDesSer)) Then
      strDesSer := strDesSer + fRetornaQuebraDeLinha;
    strDesSer := strDesSer + ' ' + 'Informações: ' + AnsiReplaceStr(dadosGerais.strMensagemAplicacao, '<<csq>>', '');
  end;

  strDesSer := fTiraCaracEspeciais(strDesSer, False);
  strDesSer := AnsiReplaceStr(AnsiReplaceStr(strDesSer, #13, ''), #10, '');
end;

function TNFSEnotas.fIBGEsQueObrigamCodigosFormatados(const strCodigoIBGE: String): Boolean;
begin
  Result := True;

  If (strCodigoIBGE = '3549706') Then
    Exit;

  If (strCodigoIBGE = '3522307') Then
    Exit;

  If (strCodigoIBGE = '3538709') Then
    Exit;

  If (strCodigoIBGE = '4314902') Then
    Exit;

  If (strCodigoIBGE = '3526902') Then
    Exit;

  If (strCodigoIBGE = '3132404') Then
    Exit;

  If (strCodigoIBGE = '3171303') Then
    Exit;

  If (strCodigoIBGE = '3136702') Then
    Exit;

  If (strCodigoIBGE = '1504208') Then
    Exit;

  If fEssaCidadeObrigaCodigoFormatado(Self.FonteDados, strCodigoIBGE) Then
    Exit;

  Result := False;
end;

function TNFSEnotas.fRetornaLocalDoServico: String;
var
  LNtOpNS: String;
begin
  If fEmptyStr(dadosGerais.strNtOpNS) Then
  Begin
    LNtOpNS := IIF(fEmptyStr(objConfigInterna.strNtOpNS), '0', objConfigInterna.strNtOpNS);

    If not (LNtOpNS = '0') Then
    Begin
      If (LNtOpNS = '1') Or
         (dadosGerais.strCodIbgeEntrega = dadosEmitente.strCodIbge) Then
        Result := '1' // Tributação no Município
      Else
        Result := '2'; // Tributação fora do Município
    End;

    If not fEmptyStr(dadosGerais.strNaturezaServico) Then
      Result := dadosGerais.strNaturezaServico; // Informado no cadastro do cliente
  End
  Else
  Begin
    Result := dadosGerais.strNtOpNS;
  End;
end;

function TNFSEnotas.fGetIbgeLocalServico: String;
begin
  If (fRetornaLocalDoServico = '1') Then
    Result := dadosEmitente.strCodIbge
  Else
    Result := dadosGerais.strCodIbgeEntrega;

  //CS FERRAMENTAS
  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
    Result := dadosEmitente.strCodIbge;

  If fUsaMetadadosParaEnviarEnderecoDoLocalDaObra Then
    Result := dadosGerais.strCodIbgeEntrega;
end;

function TNFSEnotas.fRetornaNaturezaOperacao: String;
  var
    LNatSer: String;
begin
  Result := fRetornaLocalDoServico;

  If (fCfgSisFonte(fonteDados, 'USANOP') = 'S') Then
  Begin
    Result := fRetornaNaturezaOperacaoPrioritaria(Result);
    Exit;
  End;

  If not (fCfgSisFonte(fonteDados, 'CIDNFS') = 'PREFEITURA DE CAMPINAS-SP') Then
    Exit;

  // Documento de Venda
  If not fEmptyStr(dadosGerais.strNatSer) Then
  Begin
    Result := dadosGerais.strNatSer;
    Exit;
  End;

  // Cadastro do cliente
  If not fEmptyStr(dadosGerais.strNaturezaServico) Then
  Begin
    Result := dadosGerais.strNaturezaServico;
    Exit;
  End;

  LNatSer := fCfgSisFonte(fonteDados, 'NFSNAT');

  // Configuração
  If not fEmptyStr(LNatSer) Then
  Begin
    Result := LNatSer;
    Exit;
  End;
end;

function TNFSEnotas.fRetornaNaturezaOperacaoPrioritaria(strNatSer: String): String;
var
  strNfsNop: String;
begin
  Result := strNatSer;

  strNfsNop := fCfgSisFonte(fonteDados, 'NFSNOP');

  If fEmptyStr(strNfsNop) Then
    Exit;

  Result := strNfsNop;
end;

function TNFSEnotas.fAjustaCNAE(const strCNAE: String): String;
begin
  Result := '';

  If (fCfgSisFonte(fonteDados, 'NSCNAE') = 'S') Then
    Exit;

  Result := strCNAE;

  If fEmptyStr(Result) then
    Result := dadosEmitente.strCNAEFiscal;
end;

procedure TNFSEnotas.pAdicionarServicosConcatenados(stlArquivo: TStringList);
Var
  strTipoEnteGove,
  strTipoOperEnteGove,
  strDesSer,
  strCodSLC,
  strTriMun,
  strCodNBS,
  strCNAE,
  strCstPIS,
  strSerClaTri,
  strSerIndOpe: String;
  intCont: Integer;
  dadosItem: TDadosItem;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strDesSer := '';
  strCodSLC := '';
  strTriMun := '';
  strCodNBS := '';
  strCNAE   := '';
  strSerClaTri := '';
  strSerIndOpe := '';

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    If fEmptyStr(strCodSLC) Then strCodSLC := dadosItem.strCodSLC;
    If fEmptyStr(strTriMun) Then strTriMun := dadosItem.strTriMun;
    If fEmptyStr(strCodNBS) Then strCodNBS := dadosItem.strCodNBS;
    If fEmptyStr(strCstPIS) Then strCstPIS := dadosItem.strCstPIS;

    If fEmptyStr(strSerClaTri) Then strSerClaTri := dadosItem.strSerClaTri;
    If fEmptyStr(strSerIndOpe) Then strSerIndOpe := dadosItem.strSerIndOpe;

    If (fEmptyStr(strCNAE)) And
       (Not fEmptyStr(dadosItem.strCnaeFiscal)) And
       (fCfgSisFonte(fonteDados, 'CNAESV') = 'S') Then
      strCNAE := dadosItem.strCnaeFiscal;

    If dadosGerais.strOpcDoc = 'CF' Then
    Begin
      If Pos(dadosItem.strDesIte, strDesSer) <=0 Then
      Begin
        pMontaLinhaDescricaoServicos(dadosItem, strDesSer);
      End;
    End
    Else
    Begin
      pMontaLinhaDescricaoServicos(dadosItem, strDesSer);
    End;
  End;

  If fEmptyStr(strCstPIS) Then
    strCstPIS := dadosGerais.strCstPIS;

  strCNAE := fAjustaCNAE(strCNAE);

  pAcrescentaDescricaoServicos(strDesSer);

  If (strTriMun = '010500') And
     ((dadosEmitente.strCnpj = '01919383000169') Or (dadosEmitente.strCnpj = '51212892000125')) Then
  Begin
    strDesSer := strDesSer + ' NÃO HÁ RETENÇÃO DE CSRF NO SERVIÇO LICENCIAMENTO OU CESSÃO DE USO, NÃO SE TRATA DE SERVIÇO DE PROGRAMAÇÃO (SC COSIT N° 157/2023 (CSLL E PIS/COFINS); SC COSIT N° 243/2017).';
  End;

  If (dadosEmitente.strCodIbge = '3513801') Then
    strTriMun := LowerCase(strTriMun);

  stlArquivo.Add('   "servico":{');
  stlArquivo.Add('      "descricao":'+fFormataCampo(IIF(not fEmptyStr(strDiscriminacaoServico), strDiscriminacaoServico, strDesSer))+',');
  stlArquivo.Add('      "aliquotaIss":'+ fNumerico(IIF(fEnviaAliquotaISS, TotalServico.fltPerIss, 0), StrToIntDef(fCfgSisFonte(Self.FonteDados, 'ENODEC'), 2)) +',');
  stlArquivo.Add('      "issRetidoFonte":'+IIF(dadosGerais.strRetIss = 'S', 'true','false')+',');
  stlArquivo.Add('      "codigoServicoMunicipio":'+IIF(fIBGEsQueObrigamCodigosFormatados(dadosEmitente.strCodIbge), '"'+strTriMun+'"', fFormataCampo(fLimpaCaracteres(strTriMun)))+',');
  stlArquivo.Add('      "descricaoServicoMunicipio":'+fFormataCampo(strDesSer)+',');
  stlArquivo.Add('      "itemListaServicoLC116":'+IIF(fIBGEsQueObrigamCodigosFormatados(dadosEmitente.strCodIbge), '"'+strCodSLC+'"', fFormataCampo(fLimpaCaracteres(strCodSLC)))+',');
  stlArquivo.Add('      "cnae":'+fFormataCampo(strCNAE)+',');

  If not fEmptyStr(strCodNBS) Then
  Begin
    stlArquivo.Add('      "codigoNBS":'+fFormataCampo(strCodNBS)+',');
  End;

  If blnGeraSchemaReformaTributaria Then
  Begin
    stlArquivo.Add('      "ibsCbs": {');
    stlArquivo.Add('        "classificacaoTributaria":'+fFormataCampo(strSerClaTri)+',');
    stlArquivo.Add('        "codigoIndicadorOperacao":'+fFormataCampo(strSerIndOpe)+'');

    If (dadosGerais.blnOrgPub) Then
    Begin
      strTipoEnteGove     := fTraduzTipoEnteGovernamental(dadosGerais.strEntGov);
      strTipoOperEnteGove := fTraduzTipoOperacaoEnteGovernamental(dadosGerais.strTpOpEg);

      If (Not fEmptyStr(strTipoEnteGove + strTipoOperEnteGove)) Then
      Begin
        stlArquivo.Add('    ,"operacaoGovernamental": {');
        stlArquivo.Add('       "tipoOperacao":'+fFormataCampo(strTipoOperEnteGove)+',');
        stlArquivo.Add('       "tipoEnteGovernamental":'+fFormataCampo(strTipoEnteGove)+'');
        stlArquivo.Add('     }');
      End;
    End;

    stlArquivo.Add('      },');
  End;

  If (fCfgSisFonte(Self.FonteDados, 'ENOMPS') = 'S') Then
  Begin
    stlArquivo.Add('      "municipioPrestacaoServico": '+fFormataCampo(fGetIbgeLocalServico)+',');
  End;

  If (fCfgSisFonte(Self.FonteDados, 'ENOPIS') = 'S') Then
  Begin
    If (dadosGerais.fltPisRet > 0) Then
    Begin
      stlArquivo.Add('      "situacaoTributariaPisCofins":'+fFormataCampo(strCstPIS)+',');
      stlArquivo.Add('      "tipoRetencaoPisCofins": "PisCofinsRetido",');
      stlArquivo.Add('      "valorPis":'+ fNumerico(dadosGerais.fltPisRet, 2) + ',');
      stlArquivo.Add('      "valorCofins":'+ fNumerico(dadosGerais.fltCofRet, 2) + ',');
    End
    Else
    Begin
      stlArquivo.Add('      "situacaoTributariaPisCofins":'+fFormataCampo(strCstPIS)+',');
      stlArquivo.Add('      "tipoRetencaoPisCofins": "PisCofinsNaoRetido",');
      stlArquivo.Add('      "valorPis":'+ fNumerico(dadosGerais.fltValPis, 2) + ',');
      stlArquivo.Add('      "valorCofins":'+ fNumerico(dadosGerais.fltValCof, 2) + ',');
    End;
  End
  Else
  Begin
    stlArquivo.Add('      "valorPis":'+ fNumerico(dadosGerais.fltPisRet, 2) + ',');
    stlArquivo.Add('      "valorCofins":'+ fNumerico(dadosGerais.fltCofRet, 2) + ',');
  End;

  stlArquivo.Add('      "valorCsll":'+fNumerico(dadosGerais.fltCslRet, 2)+',');
  stlArquivo.Add('      "valorInss":'+fNumerico(dadosGerais.fltVlSgSo, 2)+',');
  stlArquivo.Add('      "valorIr":'+fNumerico(dadosGerais.fltIrfRet, 2)+'');
  stlArquivo.Add('   },');

end;

procedure TNFSEnotas.pServicoPrestado(stlArquivo: TStringList);
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  pAdicionarServicosConcatenados(stlArquivo);
end;

procedure TNFSEnotas.pAcrescentaResponsavelRetencao;
begin
  If (fConfiguracaoExisteFonte(Self.FonteDados, 'RSRTNS')) Then
    TotalServico.strRespRet := Trim(fCfgSisFonte(Self.FonteDados, 'RSRTNS'))
  Else
    TotalServico.strRespRet := '1';
end;

procedure TNFSEnotas.pCalculaTotalServico;
begin
  TotalServico.fltPerIss := dadosGerais.fltPerIss;
  TotalServico.fltValIss := dadosGerais.fltValIss;
  TotalServico.fltIssRet := 0;

  If dadosGerais.fltBasIss <= 0 Then
    dadosGerais.fltBasIss := dadosGerais.fltTotSer;

  If (TotalServico.fltPerIss <= 0) And (dadosGerais.fltBasIss > 0) Then
    TotalServico.fltPerIss := (TotalServico.fltValIss / dadosGerais.fltBasIss) * 100;

  If dadosGerais.strRetIss = 'S' Then
  Begin
    TotalServico.fltIssRet := TotalServico.fltValIss;
    If objConfigInterna.blnZerIss Then
      TotalServico.fltValIss := 0;
  End;

  TotalServico.fltOutRet := dadosGerais.fltPisRet +
                            dadosGerais.fltCofRet +
                            dadosGerais.fltIrfRet +
                            dadosGerais.fltCslRet +
                            dadosGerais.fltVlSgSo;

  TotalServico.fltValLiq := dadosGerais.fltTotSer - TotalServico.fltOutRet - TotalServico.fltIssRet;

  TotalServico.fltOutRet := 0;

  //Deducoes na base de calculo do ISS (exemplo: "prestcon" onde a base iss
  //pode ser a diferenca entre o total do concreto e o custo do mesmo).
  TotalServico.fltValDed := dadosGerais.fltTotSer - dadosGerais.fltBasIss;

  {**************************************************************************}
  {* E208 - Valor do iss não pode ser superior a R$ 0,00 (zero) quando o    *}
  {* contribuinte for optante do simples nacional e não tiver iss           *}
  {* retido na fonte. - Informe o campo de Valor do iss igual               *}
  {* a R$ 0,00 (zero) quando o contribuinte for optante do simples nacional *}
  {**********************************************************************JC**}
  If Not objConfigInterna.blnSimISS Then
  Begin
    If fSimplesPaulista(dadosGerais, dadosEmitente) And (TotalServico.fltIssRet = 0) Then
      TotalServico.fltValIss := 0;
  End;

  If dadosGerais.fltReceitaBrutaNS >= 0 Then
    TotalServico.strRecBru := fNumerico(dadosGerais.fltReceitaBrutaNS, 2) + '|'
  Else
    TotalServico.strRecBru := '';

  pAcrescentaResponsavelRetencao;

end;

function TNFSEnotas.fLimpaCaracteresInvalidos(strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result, 'º', '');
  Result := AnsiReplaceStr(Result, 'ª', '');
  Result := AnsiReplaceStr(Result, '"', '');
  Result := AnsiReplaceStr(Result, '''', '');
  Result := AnsiReplaceStr(Result, '\', '/');
end;

function TNFSEnotas.fFormataCampo(strValor: String): String;
begin
  if not fEmptyStr(strValor) Then
    Result := '"'+ Trim(fLimpaCaracteresInvalidos(strValor)) +'"'
  else
    Result := 'null';
end;

function TNFSEnotas.fNumerico(fltValor: Double; intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, 12, intDecimais);
  Result := AnsiReplaceStr(Result, '.', '');
  Result := AnsiReplaceStr(Result, ',', '.');
end;

function TNFSEnotas.fMensagemErro: String;
begin
  Result := '';
end;

function TNFSEnotas.fProcessarCancelamento: TRetornoNFE;
Var
  retornoEnotas: TWSNfeEnotasRetorno;
  intStatus: Integer;
  strMensagem: String;
  stlRetorno: TStringList;
  strChaveAcesso: String;
  strNumRps: String;
begin
  EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

  retornoEnotas := EnotasWrapper.fConsultaSituacaoId(fRetornaId);

  stlRetorno := TStringList.Create;
  Try
    stlRetorno.Add(retornoEnotas.Texto);
    Try
      stlRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFS_CANC.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlRetorno);
  End;

  intStatus      := StrToIntDef(fGetValorLinha(retornoEnotas.Texto, '|', 1), 0);
  strMensagem    := fGetValorLinha(retornoEnotas.Texto, '|', 2);
  strChaveAcesso := fGetValorLinha(retornoEnotas.Texto, '|', 3);
  strNumRps      := fGetValorLinha(retornoEnotas.Texto, '|', 5);

  If (intStatus = 200) And (strMensagem = 'Cancelada') Then
  Begin
    pIntegracaoPainelCitelNFSeCancelamento(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                           dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ND');

    Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, fRetornaId, strNumRps, nOw());
  End
  Else If fStatusAguardando(strMensagem) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoAguardando;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End;
end;

function TNFSEnotas.fStatusAguardando(strMensagem: String): Boolean;
begin
  Result := (strMensagem = 'AguardandoAutorizacao') or
            (strMensagem = 'SolicitandoAutorizacao') or
            (strMensagem = 'AutorizacaoSolicitada') or
            (strMensagem = 'EmProcessoDeAutorizacao') or
            (strMensagem = 'AutorizadaAguardandoGeracaoPDF') or

            (strMensagem = 'SolicitandoCancelamento') or
            (strMensagem = 'CancelamentoSolicitado') or
            (strMensagem = 'EmProcessoDeCancelamento') or
            (strMensagem = 'CanceladaAguardandoAtualizacaoPDF');

  If Not Result Then
    Result := (Pos('nota fiscal não foi encontrada', LowerCase(strMensagem)) > 0);
end;

function TNFSEnotas.fProcessarEnvio: TRetornoNFE;
Var
  retornoEnotas: TWSNfeEnotasRetorno;
  intStatus: Integer;
  strMensagem: String;
  stlRetorno: TStringList;
  strChaveAcesso : String;
  strProtocolo : String;
  strNumRps : String;
  blnDocumentoImpresso: Boolean;
begin
  pLogEnotas('fProcessarEnvio >');

  EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

  retornoEnotas := EnotasWrapper.fConsultaSituacaoId(fRetornaId);

  stlRetorno := TStringList.Create;
  Try
    stlRetorno.Add(retornoEnotas.Texto);

    Try
      stlRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFS.TXT'));

      Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                    dadosGerais.strCodCli, dadosGerais.strTip_FC, 'RETORNO', stlRetorno.Text);
    Except

    End;
  Finally
    FreeAndNil(stlRetorno);
  End;

  intStatus      := StrToIntDef(fGetValorLinha(retornoEnotas.Texto, '|', 1), 0);
  strMensagem    := fGetValorLinha(retornoEnotas.Texto, '|', 2);
  strChaveAcesso := fGetValorLinha(retornoEnotas.Texto, '|', 3);
  strProtocolo   := fGetValorLinha(retornoEnotas.Texto, '|', 4);
  strNumRps      := fGetValorLinha(retornoEnotas.Texto, '|', 5);

  If (intStatus = 200) And (strMensagem = 'Autorizada') Then
  Begin
    Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, fRetornaId, strNumRps, nOw());

    pGerarXmlCitel(IntToStr(Floor(fStrToFloat(dadosGerais.strNumDoc))), strNumRps, dadosGerais.strSerie, fRetornaId);

    pLogEnotas('pGravarLogNfe');
    Self.fonteDados.pGravarLogNfe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie, dadosGerais.strCodCli,
                                  dadosGerais.strTip_FC, 'AF', strMensagem, Result.ChaveAcesso, nOw(), fDefineImpressora(dadosGerais));

    pLogEnotas('pAtualizaDataDeAutorizacao');
    Self.fonteDados.pAtualizaDataDeAutorizacao(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie, dadosGerais.strCodCli);

    pLogEnotas('pIntegracaoPainelCitelNFSe');
    pIntegracaoPainelCitelNFSe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                               dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ND');

    pLogEnotas('fRetornaDocumentoImpresso');
    blnDocumentoImpresso := Self.fonteDados.fRetornaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                                                      dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);

    If not blnDocumentoImpresso Then
    Begin
      pImprimirDanfeInterna(fRetornaId, fDefineImpressora(dadosGerais), 0, fRetornaId);

      pLogEnotas('pGravaDocumentoImpresso');
      Self.fonteDados.pGravaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                              dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);
    End;
  End
  Else If (intStatus = 200) And (strMensagem = 'Cancelada') Then
  Begin
    Result := TRetornoNFE.fCriaRetornoCancelada(strProtocolo, True);
  End
  Else If fStatusAguardando(strMensagem) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoAguardando;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End;

  pLogEnotas('fProcessarEnvio <');
end;

function TNFSEnotas.fProcessarStatusNota: TRetornoNFE;
begin
  Result := fProcessarEnvio;
end;

function TNFSEnotas.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;   // Modificada para True para poder passar para a reimpressão de Danfe.
                    // Utilizando a mesma lógica das classes referentes a NFE (untNFEFit400)
                    // Na untLibNfe tem a condição "If service.fSuportaFuncoesAdministrativas" então chama a reimpresssão.
end;

function TNFSEnotas.fVerificarStatusNota: Boolean;
begin
  Result := True;
end;

function TNFSEnotas.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

function TNFSEnotas.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

procedure TNFSEnotas.pAdicionaItem(dadosItem: TDadosItem);
begin
  If (Not Assigned(lstItens)) Then
    lstItens := TList.Create;

  lstItens.Add(dadosItem);
end;

procedure TNFSEnotas.pImprimirDanfeInterna(strChaveAcesso, strImpressora: String; intViasServidor: Integer; strIdNota: String; strImprimirTelaPDF: String = '');
begin
  pLogEnotas('pImprimirDanfeInterna >');
  If fEmptyStr(strChaveAcesso) Then
  Begin
    Raise Exception.Create('A chave de acesso deve ser informada.');
  End;

  Try
    EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

    EnotasWrapper.fDownloadDanfe(strChaveAcesso, dadosGerais.strNumDoc, strImpressora, intViasServidor, strIdNota, Self.fonteDados, False, strImprimirTelaPDF);
  Except
    On E: Exception Do
    Begin
      Raise ErrosValidacaoNFE.fCriaErroSimples(E.Message);
    End;
  End;
  pLogEnotas('pImprimirDanfeInterna <');
end;

function TNFSEnotas.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := False;
End;

procedure TNFSEnotas.pReimprimeDanfe(strChaveAcesso: String);
Var
  strImpressora: String;
begin
  strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
  pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
end;

procedure TNFSEnotas.pPrepararEmails;
Var
  intPosEmail: Integer;
  strEmailPChar: {$IF Defined(VER250) Or Defined(UNIDAC)} PWideChar {$ELSE} PAnsiChar {$IFEND};
begin
  stlEmails.Clear;
  {$IF Defined(VER250) Or Defined(UNIDAC)}
    strEmailPChar := PWideChar(dadosGerais.strEmail);
  {$ELSE}
    strEmailPChar := PAnsiChar(dadosGerais.strEmail);
  {$IFEND};
  ExtractStrings([';'], [], strEmailPChar, stlEmails);

  intPosEmail := Pos(';', dadosGerais.strEmail);
  If intPosEmail > 0 Then
  Begin
    fonteDados.fDadosGerais.strEmail := LeftStr(dadosGerais.strEmail, intPosEmail-1);
  End;
end;

function TNFSEnotas.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
begin
  If (Not Assigned(dadosGeraisArg)) Or (fEmptyStr(dadosGeraisArg.strPontoImpressao)) Then
    Result := fIdentificarNomeDaImpressora(fonteDados, objConfig.strFitImpressoraPadrao)
  Else
    Result := fIdentificarNomeDaImpressora(fonteDados, dadosGeraisArg.strPontoImpressao);
end;

procedure TNFSEnotas.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
begin
  If fEmptyStr(strChaveAcesso) Then
    Raise Exception.Create('A chave de acesso deve ser informada.');

  pSetaDadosGerais(fonteDados.fDadosGerais);

  pImprimirDanfeInterna(strChaveAcesso, strImpressora, 0, strChaveAcesso, strImprimirTelaPDF);
end;

procedure TNFSEnotas.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TNFSEnotas.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFSEnotas.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

procedure TNFSEnotas.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

function TNFSEnotas.fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

function TNFSEnotas.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
End;

function TNFSEnotas.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

procedure TNFSEnotas.pIntegracaoPainelCitelNFSe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE_XML');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE_PDF');
end;

procedure TNFSEnotas.pIntegracaoPainelCitelNFSeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE_CANCELAMENTO');
end;

function TNFSEnotas.fUsaMetadadosParaRegimeEspecialTributacaoIntermunicipal: Boolean;
begin
  Result := False;

  If not (fCfgSisFonte(fonteDados, 'CIDNFS') = 'PREFEITURA DE CAMPINAS-SP') Then
    Exit;

  If not (fCfgSisFonte(Self.FonteDados, 'ENOMPS') = 'S') Then
    Exit;

  If fEmptyStr(fCfgSisFonte(Self.FonteDados, 'ENORET')) Then
    Exit;

  If (dadosEmitente.strCodIbge = fGetIbgeLocalServico) Then
    Exit;

  Result := True;
end;

function TNFSEnotas.fUsaMetadadosParaEnviarLocalDaObra: Boolean;
begin
  Result := False;

  If (fCfgSisFonte(Self.FonteDados, 'MUNINC') = 'S') Then
    Exit;

  If not (fCfgSisFonte(Self.FonteDados, 'ENOOBR') = 'S') Then
    Exit;

  Result := True;
end;

function TNFSEnotas.fUsaMetadadosParaEnviarCidadeDoEmitenteComoMunicipioDeIncidenciaDeISS: Boolean;
begin
  Result := False;

  If (fCfgSisFonte(Self.FonteDados, 'ENOOBR') = 'S') Then
    Exit;

  If not (fCfgSisFonte(Self.FonteDados, 'MUNINC') = 'S') Then
    Exit;

  Result := True;
end;

function TNFSEnotas.fUsaMetadados: Boolean;
begin
  Result := False;

  If (fCfgSisFonte(fonteDados, 'ENOMET') = 'S') Then
  Begin
    Result := True;
    Exit;
  End;

  If fUsaMetadadosParaRegimeEspecialTributacaoIntermunicipal Then
  Begin
    Result := True;
    Exit;
  End;

  If fUsaMetadadosParaEnviarLocalDaObra Then
  Begin
    Result := True;
    Exit;
  End;

end;

function TNFSEnotas.fUsaMetadadosParaEnviarEnderecoDoLocalDaObra: Boolean;
begin
  Result := False;

  If not fUsaMetadadosParaEnviarLocalDaObra Then
    Exit;

  If (fCfgSisFonte(fonteDados, 'CIDNFS') = 'PREFEITURA DE BRAGANÇA PAULISTA-SP') Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCfgSisFonte(fonteDados, 'CIDNFS') = 'PREFEITURA DE RIBEIRÃO PRETO') Then
  Begin
    Result := True;
    Exit;
  End;
end;

procedure TNFSEnotas.pMontaMetadados(stlArquivo: TStringList);
var
  intCont: Integer;
  dadosItem: TDadosItem;
  blnVirgula: Boolean;
begin
  If not fUsaMetadados Then
    Exit;

  blnVirgula := False;

  stlArquivo.Add('  ,"metadados": { ');

  If fUsaMetadadosParaRegimeEspecialTributacaoIntermunicipal Then
  Begin
    stlArquivo.Add('   "Tributacao": '+fFormataCampo(strRegimeEspecialTributacaoIntermunicipal)+' ');
    blnVirgula := True;
  End;

  If fUsaMetadadosParaEnviarLocalDaObra Then
  Begin
    If blnVirgula Then
      stlArquivo.Add(',');

    stlArquivo.Add('   "enviarLocalObra": true ');
    blnVirgula := True;
  End;

  {************************************************************************************************}
  {* Por falta de campos, o eNotas usa o grupo "cidadeprestacao" para duas finalidades distintas: *}
  {* 1 - Quando é preechido "municipio" e "siglaUF" serve para Incidência de ISS                  *}
  {* 2 - Quando é preechido "municipio", "siglaUF", "logradouro", etc serve para Local da Obra    *}
  {*********************************************************************************************BZ*}
  If fUsaMetadadosParaEnviarEnderecoDoLocalDaObra Then
  Begin
    If blnVirgula Then
      stlArquivo.Add(',');

    If (fRetornaLocalDoServico = '1') Then
    Begin
      stlArquivo.Add('   "cidadeprestacao":{ ');
      stlArquivo.Add('     "municipio":'+fFormataCampo(dadosGerais.strNomeCidade)+',');
      stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosGerais.strEstado)+',');
      stlArquivo.Add('     "logradouro":'+fFormataCampo(dadosGerais.strLogradouro)+',');
      stlArquivo.Add('     "numero":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strNumeroEnd))+',');
      stlArquivo.Add('     "bairro":'+fFormataCampo(dadosGerais.strBairro)+',');
      stlArquivo.Add('     "cep":'+fFormataCampo(dadosGerais.strCEP)+'');
      stlArquivo.Add('   } ');
    End
    Else
    Begin
      If fEmptyStr(dadosGerais.strNomCidEndEnt) Then
      Begin
        stlArquivo.Add('   "cidadeprestacao":{ ');
        stlArquivo.Add('     "municipio":'+fFormataCampo(dadosGerais.strNomeCidade)+',');
        stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosGerais.strEstado)+',');
        stlArquivo.Add('     "logradouro":'+fFormataCampo(dadosGerais.strLogradouro)+',');
        stlArquivo.Add('     "numero":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strNumeroEnd))+',');
        stlArquivo.Add('     "bairro":'+fFormataCampo(dadosGerais.strBairro)+',');
        stlArquivo.Add('     "cep":'+fFormataCampo(dadosGerais.strCEP)+'');
        stlArquivo.Add('   } ');
      End
      Else
      Begin
        stlArquivo.Add('   "cidadeprestacao":{ ');
        stlArquivo.Add('     "municipio":'+fFormataCampo(dadosGerais.strNomCidEndEnt)+',');
        stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosGerais.strEstadoEndEnt)+',');
        stlArquivo.Add('     "logradouro":'+fFormataCampo(dadosGerais.strLogradouroEndEnt)+',');
        stlArquivo.Add('     "numero":'+fFormataCampo(fTiraCaracEspeciais(dadosGerais.strNumeroEndEnt))+',');
        stlArquivo.Add('     "bairro":'+fFormataCampo(dadosGerais.strBairroEndEnt)+',');
        stlArquivo.Add('     "cep":'+fFormataCampo(dadosGerais.strCEPEndEnt)+'');
        stlArquivo.Add('   } ');
      End;
    End;

    blnVirgula := True;
  End
  Else If fUsaMetadadosParaEnviarCidadeDoEmitenteComoMunicipioDeIncidenciaDeISS Then
  Begin
    If blnVirgula Then
      stlArquivo.Add(',');

    stlArquivo.Add('   "cidadeprestacao":{ ');
    stlArquivo.Add('     "municipio":'+fFormataCampo(dadosEmitente.strNomeCidade)+',');
    stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosEmitente.strEstado)+'');
    stlArquivo.Add('   } ');

    blnVirgula := True;
  End
  Else
  Begin
    If blnVirgula Then
      stlArquivo.Add(',');

    If (fRetornaLocalDoServico = '1') Then
    Begin
      stlArquivo.Add('   "cidadeprestacao":{ ');
      stlArquivo.Add('     "municipio":'+fFormataCampo(dadosEmitente.strNomeCidade)+',');
      stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosEmitente.strEstado)+'');
      stlArquivo.Add('   } ');
    End
    Else
    Begin
      If fEmptyStr(dadosGerais.strNomCidEndEnt) Then
      Begin
        stlArquivo.Add('   "cidadeprestacao":{ ');
        stlArquivo.Add('     "municipio":'+fFormataCampo(dadosGerais.strNomeCidade)+',');
        stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosGerais.strEstado)+'');
        stlArquivo.Add('   } ');
      End
      Else
      Begin
        stlArquivo.Add('   "cidadeprestacao":{ ');
        stlArquivo.Add('     "municipio":'+fFormataCampo(dadosGerais.strNomCidEndEnt)+',');
        stlArquivo.Add('     "siglaUF":'+fFormataCampo(dadosGerais.strEstadoEndEnt)+'');
        stlArquivo.Add('   } ');
      End;
    End;

    blnVirgula := True;
  End;

  If (fCfgSisFonte(fonteDados, 'ENOMET') = 'S') Then
  Begin
    If blnVirgula Then
      stlArquivo.Add(',');

    stlArquivo.Add('   "itens": [ ');

    For intCont := 0 To lstItens.Count-1 Do
    Begin
      dadosItem := TDadosItem(lstItens[intCont]);

      stlArquivo.Add('  { ');
      stlArquivo.Add('    "discriminacaoServico": '+fFormataCampo(dadosItem.strDesIte)+ ',');
      stlArquivo.Add('    "quantidade": '+fNumerico(dadosItem.fltQtdIte, 4)+ ',');
      stlArquivo.Add('    "valorUnitario": '+fNumerico(dadosItem.fltUnitar, 2)+ ',');
      stlArquivo.Add('    "tributavel": "'+IIF(fEmptyStr(dadosItem.strServicoTributavel), 'N', dadosItem.strServicoTributavel)+'" ');
      stlArquivo.Add('  } ');

      If intCont < lstItens.Count-1 Then
        stlArquivo.Add(',');
    End;

    stlArquivo.Add(' ]');
  End;

  stlArquivo.Add(' }');
end;

function TNFSEnotas.fRetornaQuebraDeLinha: String;
begin
  Result := ' | ';

  If not (fCfgSisFonte(fonteDados, 'ENOQUE') = 'S') Then
    Exit;

  Result := '\n';
end;

function TNFSEnotas.fConsultaStatusDFe(strChaveAcesso: string): String;
Var
  retornoEnotas: TWSNfeEnotasRetorno;
  intStatus: Integer;
  strMensagem: String;
  stlRetorno: TStringList;
begin
  pLogEnotas('TNFSEnotas.fConsultaStatusDFe >');

  If fEmptyStr(strChaveAcesso) Then
    Exit;

  EnotasWrapper.pCarregaConfiguracoesEnotas(fonteDados);

  retornoEnotas := EnotasWrapper.fConsultaSituacaoId(strChaveAcesso);

  pLogEnotas(retornoEnotas.Texto);

  stlRetorno := TStringList.Create;
  Try
    stlRetorno.Add(retornoEnotas.Texto);

    Try
      stlRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_STATUS_DFE.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlRetorno);
  End;

  intStatus   := StrToIntDef(fGetValorLinha(retornoEnotas.Texto, '|', 1), 0);
  strMensagem := fGetValorLinha(retornoEnotas.Texto, '|', 2);

  If (intStatus = 200) Then
  Begin
    Result := strMensagem;
  End;
End;

function TNFSEnotas.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  Result := '';
end;

function TNFSEnotas.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55'): String;
begin
  Result := '';
end;

function TNFSEnotas.fEhServicoParaClienteConsumidor: Boolean;
begin
  Result := False;

 If not (dadosGerais.strConsum = 'S') Then
   Exit;

  If not (fCfgSisFonte(fonteDados, 'ENOCON') = 'S') Then
    Exit;

 Result := True;
end;

{******************************************************************************************}
{* A aliquota do ISSQN so deve ser informada quando: o ISSQN for devido a outro municipio *}
{* ou o prestador do servico for optante pelo Simples Nacional e houver retencao do ISSQN *}
{***************************************************************************************BZ*}
function TNFSEnotas.fEnviaAliquotaISS: Boolean;
begin

  Result := True;

  If not (fCfgSisFonte(fonteDados, 'REGISS') = 'S') Then
    Exit;

  Result := False;

  If fSimplesPaulista(dadosGerais, dadosEmitente) And (TotalServico.fltIssRet > 0) Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCfgSisFonte(Self.FonteDados, 'ENOMPS') = 'S') And (dadosEmitente.strCodIbge <> fGetIbgeLocalServico) Then
  Begin
    Result := True;
    Exit;
  End;

end;

function TNFSEnotas.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude,
  strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFSEnotas.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFSEnotas.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega,
  strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFSEnotas.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

end.
