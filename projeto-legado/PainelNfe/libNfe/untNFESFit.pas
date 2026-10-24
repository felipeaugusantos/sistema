unit untNFESFit;

interface

uses untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils,
  NfeApiWSBean;

Type
  TNFESFit = class(TAbstractAdministrativoService, INFE)
    private
      fitWrapper: TWSNFeFitWrapper;
      fonteDados: IFonteDados;

      dadosGerais: TDadosGerais;
      dadosEmitente: TDadosEmitente;
      lstItens: TList;

      SUCESSO: Integer;
      ERRO_ESTRUTURA: Integer;
      ERRO: Integer;
      CANCELADA: Integer;

      stlEmails: TStringList;

      strNumeroNSe: String;
      strNumeroRps: String;
      strSerieRps: String;

      TotalServico: TTotalServico;

      function fNumerico(fltValor: Double; intDecimais: Integer): String;
      function fRetornaId: String;
      procedure pCabecalho(stlArquivo: TStringList);
      procedure pHeader(stlArquivo: TStringList);
      procedure pServicoPrestado(stlArquivo: TStringList);
      procedure pAdicionarServicosConcatenados(stlArquivo: TStringList);
      procedure pAdicionarMaisDeUmServico(stlArquivo: TStringList);
      procedure pNFETrailler(stlArquivo: TStringList);
      procedure pReformaTributaria(stlArquivo: TStringList; strSerIndOpe: String);
      function fGetIbgeLocalServico: String;
      function fPrefeituraPermiteMaisDeUmItem: Boolean;
      procedure pTotalServico(stlArquivo: TStringList);
      function fStatusAguardando(intStatus: Integer): Boolean;

      function fTrataRetornoNFSeRoraimaComErro(Var intStatus: Integer; Var strMensagem, strNumRps: String): Boolean;

      procedure pImprimirDanfeInterna(strChaveAcesso, strImpressora: String; intViasServidor: Integer; strIdNota: String; strImprimirTelaPDF: String = '');
      function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
      procedure pPrepararEmails;
      procedure pNFSEEmailCliente(stlArquivo: TStringList);
      procedure pIntegracaoPainelCitelNFSe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
      procedure pIntegracaoPainelCitelNFSeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
      function fPrefeituraDisponibilizaCampoObservacao: Boolean;
      function fEnviaAliquotaISS: Boolean;
    public

      function fEnviarNota: Boolean;
      function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
      function fRetXMLNfe(strChaveAcesso: string): string;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

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
      function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
      function fEnviaNFCeXmlOffLine: Boolean;

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

{ TNFESFit }

constructor TNFESFit.Create(fonteDados: IFonteDados);
begin
  SUCESSO        := 100;
  ERRO_ESTRUTURA := 4;
  ERRO           := 999;
  CANCELADA      := 101;
  Self.fonteDados := fonteDados;
  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);
  stlEmails := TStringList.Create;
  TotalServico := TTotalServico.Create;
end;

destructor TNFESFit.Destroy;
begin
  If Assigned(lstItens) Then
    FreeAndNil(lstItens);

  If Assigned(fitWrapper) Then
    FreeAndNil(fitWrapper);

  If Assigned(stlEmails) Then
    FreeAndNil(stlEmails);

  If Assigned(TotalServico) Then
    FreeAndNil(TotalServico);

  inherited;
end;

function TNFESFit.fRetXMLNfe(strChaveAcesso: string): string;
begin
  result := fitWrapper.fRetXMLNfe(strChaveAcesso);
End;

function TNFESFit.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
begin
  result := fitWrapper.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
End;


function TNFESFit.fCancelarNota(strNumDoc, strSerie,
  strMotivo: String): Boolean;
  Var
    stlArquivo: TStringList;
    strTexto: String;
    retornoFit: TWSNfeFitRetorno;
begin
  strTexto := 'NFSE-CANC|'  +
               fRetornaId() + '|' +
               strMotivo    + '|' +
               '|';

  retornoFit := fitWrapper.fEnviaTextoIntegracaoServico(strTexto);

  stlArquivo := TStringList.Create;
  Try
    stlArquivo.Add(strTexto);
    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_CANC_NFS.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  If Not retornoFit.RetornoOk Then
  Begin
    Raise ErrosValidacaoNFE.fCriaErroSimples(fGetValorLinha(retornoFit.Texto, '|', 3))
  End;

  Result := retornoFit.RetornoOk;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFESFit.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
begin
  Result := fitWrapper.fCarregaNfePdf(AChaveAcesso, ANomeArquivo, AExtensao, fonteDados, AIgnorarLayoutSimplificado);
end;

function TNFESFit.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

procedure TNFESFit.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
var
  NFSeXML: TNFSeXML;
begin
  If (fCfgSisFonte(Self.fonteDados, 'NFSCIT') <> 'S') Then
    Exit;

  pLogImp('pGerarXmlCitel >');

  If (Not Assigned(lstItens)) Or (lstItens.Count = 0) Then
  Begin
    pLogImp('pGerarXmlCitel < lstItens vazio - fluxo de status, XML não gerado');
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
      pLogImp('pGerarXmlCitel Exception: ' + E.Message);
  End;

  pLogImp('pGerarXmlCitel <');
end;

function TNFESFit.fEnviarNota: Boolean;
  Var
    stlArquivo: TStringList;
    retornoFit: TWSNfeFitRetorno;
begin
  pLogImp('TNFESFit.fEnviarNota >');

  pPrepararEmails;

  stlArquivo := TStringList.Create;
  Try
    pHeader(stlArquivo);
    pCabecalho(stlArquivo);
    pServicoPrestado(stlArquivo);
    pTotalServico(stlArquivo);
    pNFSEEmailCliente(stlArquivo);
    pNFETrailler(stlArquivo);

    stlArquivo.Text := fTiraCaracEspeciais(stlArquivo.Text, False, False, False, True);

    retornoFit := fitWrapper.fEnviaTextoIntegracaoServico(stlArquivo.Text);

    Try
      stlArquivo.SaveToFile(fPnlDir('ULTIMO_ENVIO_NFS.TXT'));

      Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                    dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ENVIO', stlArquivo.Text);
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  If Not retornoFit.RetornoOk Then
  Begin
    Raise ErrosValidacaoNFE.fCriaErroSimples(fGetValorLinha(retornoFit.Texto, '|', 3))
  End;

  If retornoFit.RetornoOk Then
  Begin
    pGerarXmlCitel(strNumeroNSe, strNumeroRps, strSerieRps, fRetornaId);
  End;

  Result := retornoFit.RetornoOk;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);

  pLogImp('TNFESFit.fEnviarNota <');
end;

procedure TNFESFit.pNFSEEmailCliente(stlArquivo: TStringList);
  Var
    strLinha: String;
    intContador: Integer;
begin
  For intContador := 0 To stlEmails.Count -1 Do
  Begin
    If (Not fEmptyStr(stlEmails[intContador])) Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFSE-EMAIL|';                                                                         // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaId + '|';                                                                      // 002 - ID Referência
      strLinha := strLinha + LeftStr(Trim(stlEmails[intContador]), 255) + '|';                                      // 003 - Email Cliente
      strLinha := strLinha + 'S|';                                                                                  // 004 - Enviar XML
      strLinha := strLinha + 'S|';                                                                                  // 005 - Enviar PDF Danfe
      stlArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFESFit.pHeader(stlArquivo: TStringList);
begin
  stlArquivo.Add('HEADER|1.00');
end;

procedure TNFESFit.pCabecalho(stlArquivo: TStringList);
  Var
    strLogradouro: String;
    strNumeroEnd: String;
    strComplementoEnd: String;
    strBairro: String;
    strCodIbge: String;
    strCEP: String;

    strTipoRpsSub: String;
    intIntRps : Integer;
    strIntRps : String;
    intLength : Integer;
    strDiscriminacaoServico : String;
    strInscMunicipal : String;
    strCnpjDestinatario : String;
    strObservacoes: String;
begin
  intLength := Length(fNumDocEnvio(dadosGerais.strNumDoc));

  strIntRps := fCfgSisFonte(Self.FonteDados, 'INTRPS');

  If Not fEmptyStr(strIntRps) Then
    intIntRps := StrToIntDef(strIntRps, 0)
  Else
    intIntRps := 0;

  strNumeroNSe := fStrZero(fNumDocEnvio(dadosGerais.strNumDoc), intLength);
  strNumeroRps := fStrZero(IntToStr(Floor(StrToFloat(fNumDocEnvio(dadosGerais.strNumDoc))) - intIntRps), intLength);
  strSerieRps  := dadosGerais.strSerie;

  strLogradouro       := dadosGerais.strLogradouro;
  strNumeroEnd        := dadosGerais.strNumeroEnd;
  strComplementoEnd   := dadosGerais.strComplementoEnd;
  strBairro           := dadosGerais.strBairro;
  strCodIbge          := dadosGerais.strCodIbge;
  strCEP              := dadosGerais.strCEP;
  strInscMunicipal    := dadosGerais.strInscMunicipal;
  strCnpjDestinatario := IIF((fCfgSisFonte(Self.FonteDados, 'NSSCPF') = 'S') And fEmptyStr(dadosGerais.strCnpj),
                              IIF((fCfgSisFonte(Self.FonteDados, 'CPFBRA') = 'S'), '', '00000000000'),
                              dadosGerais.strCnpj);

  strTipoRpsSub := '';
  If Not fEmptyStr(dadosGerais.strNumeroRpsSubstituto) Then
  Begin
    strTipoRpsSub := '1';
  End;

  If fEmptyStr(strNumeroEnd) Or (strNumeroEnd = '0') Then
    strNumeroEnd := '00';

  If Not fEmptyStr(dadosGerais.strDisSer) Then
    strDiscriminacaoServico := AnsiReplaceStr(AnsiReplaceStr(dadosGerais.strDisSer, #13#10, '#'), '<<csq>>', '#')
  Else
    strDiscriminacaoServico := '';

  If (fEmptyStr(strInscMunicipal)) And
     (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
  Begin
    strInscMunicipal := '000000000';
  End;

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SERTAOZINHO') Then
    strSerieRps := '00000';

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE LIMEIRA') Then
    strSerieRps := 'RPSL';

  strDiscriminacaoServico := fTiraCaracEspeciais(strDiscriminacaoServico, False);
  strDiscriminacaoServico := AnsiReplaceStr(AnsiReplaceStr(strDiscriminacaoServico, #13, ''), #10, '');

  strObservacoes := EmptyStr;
  If fPrefeituraDisponibilizaCampoObservacao Then
  Begin
    If Not fEmptyStr(dadosGerais.strMen001) then
      strObservacoes := dadosGerais.strMen001;

    If Not fEmptyStr(dadosGerais.strMen002) then
      strObservacoes := IIF(not fEmptyStr(strObservacoes), strObservacoes + '#', '') + dadosGerais.strMen002;

    If Not fEmptyStr(dadosGerais.strMen003) then
      strObservacoes := IIF(not fEmptyStr(strObservacoes), strObservacoes + '#', '') + dadosGerais.strMen003;

    If Not fEmptyStr(dadosGerais.strMen004) then
      strObservacoes := IIF(not fEmptyStr(strObservacoes), strObservacoes + '#', '') + dadosGerais.strMen004;

    If Not fEmptyStr(dadosGerais.strMen005) then
      strObservacoes := IIF(not fEmptyStr(strObservacoes), strObservacoes + '#', '') + dadosGerais.strMen005;
  End;

  stlArquivo.Add('' +
                 'NFSE-RPS|'                                                    +       //01 FIXO NFSE-RPS
                 fRetornaId()                                                   + '|' + //02 ID DA NOTA
                 dadosEmitente.strCnpj                                          + '|' + //03 CNPJ EMITENTE
                 strNumeroRps                                                   + '|' + //04 NÚMERO DO RPS
                 strSerieRps                                                    + '|' + //05 SÉRIE DO RPS
                 '1'                                                            + '|' + //06 TIPO RPS
                 FormatDateTime('dd/mm/yyyyhh:nn:ss', dadosGerais.dtaDtaEnt + dadosGerais.dtaHorEnt)    + '|' + //07 DATA EMISSÃO RPS
                 fGetNaturezaOperacao(objConfig, dadosGerais, dadosEmitente)    + '|' + //08 NATUREZA DA OPERAÇÃO
                 fGetRegimeEspecial(objConfig, dadosGerais, dadosEmitente)      + '|' + //09 REGIME ESPECIAL
                 IfThen(fSimplesPaulista(dadosGerais, dadosEmitente), 'S', 'N') + '|' + //10 OPTANTE PELO SIMPLES
                 'N'                                                            + '|' + //11 INCENTIVO CULTURAL
                 dadosGerais.strNumeroRpsSubstituto                             + '|' + //12 NÚMERO RPS SUBSTITUTO
                 dadosGerais.strSerieRpsSubstituto                              + '|' + //13 SÉRIE RPS SUBSTITUTO
                 strTipoRpsSub                                                  + '|' + //14 TIPO RPS SUBSTITUTO (1–RPS, 2–Nota Fiscal Conjugada ( mista ), 3–Cupom)
                 dadosGerais.strCodObr                                          + '|' + //15 CÓDIGO DA OBRA
                 dadosGerais.strCodArt                                          + '|' + //16 CODIGO ART
                 strCnpjDestinatario                                            + '|' + //17 CNPJ DESTINATÁRIO
                 dadosGerais.strNomCli                                          + '|' + //18 RAZÃO SOCIAL DESTINATÁRIO
                 dadosGerais.strNomCli                                          + '|' + //19 NOME FANTASIA DESTINATÁRIO
                 strLogradouro                                                  + '|' + //20 LOGRADOURO DESTINATÁRIO
                 strNumeroEnd                                                   + '|' + //21 NÚMERO LOGRADOURO DESTINATÁRIO
                 strComplementoEnd                                              + '|' + //22 COMPLEMENTO LOGRADOURO DESTINATÁRIO
                 strBairro                                                      + '|' + //23 BAIRRO
                 strCodIbge                                                     + '|' + //24 IBGE DESTINATÁRIO
                 strCEP                                                         + '|' + //25 CEP DESTINATÁRIO
                 dadosGerais.strCodigoPais                                      + '|' + //26 CÓDIGO PAÍS
                 dadosGerais.strTelefone                                        + '|' + //27 TELEFONE DESTINATÁRIO
                 dadosGerais.strIES                                             + '|' + //28 IES DESTINATÁRIO
                 dadosGerais.strSuframa                                         + '|' + //29 SUFRAMA DESTINATÁRIO
                 fApenasUmEmail(dadosGerais.strEmail)                           + '|' + //30 E-MAIL DESTINATÁRIO
                 '|'                                                                  + //31 CNPJ/CPF Intermediário Serviço
                 '|'                                                                  + //32 Razão Social ou Nome do Intermediário Serviço
                 '|'                                                                  + //33 Nome Fantasia do Intermediário Serviço
                 '|'                                                                  + //34 Logradouro Intermediário Serviço
                 '|'                                                                  + //35 Número Logradouro Intermediário Serviço
                 '|'                                                                  + //36 Complemento Logradouro Intermediário Serviço
                 '|'                                                                  + //37 Bairro Intermediário Serviço
                 '|'                                                                  + //38 Código IBGE do Município Intermediário Serviço
                 '|'                                                                  + //39 CEP Intermediário Serviço
                 '|'                                                                  + //40 Código BACEN Pais Intermediário Serviço
                 '|'                                                                  + //41 Telefone Intermediário Serviço
                 '|'                                                                  + //42 Inscrição Estadual Intermediário Serviço
                 '|'                                                                  + //43 Inscrição Suframa Intermediário Serviço
                 '|'                                                                  + //44 e-mail Intermediário Serviço
                 strInscMunicipal                                               + '|' + //45 Inscrição Municipal Tomador ( Destinatário )
                 '|'                                                                  + //46 Numero da NFS-e, Informar numero da NFS-e, quando a prefeitura aceitar o numero e não vier no retorno da prefeitura
                 strObservacoes                                                 + '|' + //47 Observações, Verificar se a prefeitura permite
                 '|'                                                                  + //48 Codigo Externo, Uso livre
                 strDiscriminacaoServico                                        + '|' +  //49 Discriminação do conteúdo da NFS-e.(Usado para prefeitura padrão SIMPLISS)
                 '|'                                                                  + //50 AIDF
                 dadosGerais.strDesCondPagamento                                + '|'   //51 Forma de pagamento
                 );
end;

function TNFESFit.fRetornaId: String;
  var
    strEmpNFSe : string;
    strComplementoID: string;
begin
  strEmpNFSe       := fCfgSisFonte(Self.FonteDados, 'EMPSER');
  strComplementoID := fCfgSisFonte(Self.FonteDados, 'NFS_ID');

  //ALTERADO A PEDIDO DO MÁRIO / ELMA, POR CONTA DA PREFEITURA DE PASSOS/MG QUE REINICIA O CONTADOR DE NOTAS TODO ANO.
  //REQUISITO 36325
  Result := RightStr(IntToStr(YearOf(nOw())), 2) +
            fStrZero(fNumDocEnvio(dadosGerais.strNumDoc),9) +
            IIF(fEmptyStr(strComplementoID), '99', strComplementoID) +
            IIF( (strEmpNFSe = 'PREFEITURA DE ARARAS'), '000', fStrZero(dadosGerais.strSerie,3) ) +
            dadosGerais.strCodEmp;
end;

procedure TNFESFit.pAdicionarServicosConcatenados(stlArquivo: TStringList);
  Var
    strDesSer,
    strCodSLC,
    strTriMun,
    strCNAE: String;
    strCodNBS: String;
    strSerIndOpe: String;
    intCont: Integer;
    dadosItem: TDadosItem;
    blnEmissaoNotaPropriaCitel: Boolean;

  procedure pMontaLinhaDescricaoServicos;
  begin
    If (Not fEmptyStr(strDesSer)) Then
      strDesSer := strDesSer + '#'{' / '};

    If (objConfigInterna.strTpNfCr = J_A_MASSA_CONCRETO) Then
      strDesSer := strDesSer + dadosItem.strDesIte + ' R$ ' + FormatFloat('###,###,##0.00', dadosItem.fltUnitar)
    Else
      strDesSer := strDesSer + dadosItem.strDesIte;

  end;

begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strDesSer := '';
  strCodSLC := '';
  strTriMun := '';
  strCNAE   := '';
  strCodNBS := '';
  strSerIndOpe := '';

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    If fEmptyStr(strCodSLC) Then strCodSLC := dadosItem.strCodSLC;
    If fEmptyStr(strTriMun) Then strTriMun := dadosItem.strTriMun;
    If fEmptyStr(strCodNBS) Then strCodNBS := dadosItem.strCodNBS;
    If fEmptyStr(strSerIndOpe) Then strSerIndOpe := dadosItem.strSerIndOpe;

    If (fEmptyStr(strCNAE)) And
       (Not fEmptyStr(dadosItem.strCnaeFiscal)) And
       (fCfgSisFonte(fonteDados, 'CNAESV') = 'S') Then
      strCNAE := dadosItem.strCnaeFiscal;

    If dadosGerais.strOpcDoc = 'CF' Then
    Begin
      If Pos(dadosItem.strDesIte, strDesSer) <=0 Then
      Begin
        pMontaLinhaDescricaoServicos;
      End;
    End
    Else
    Begin
      pMontaLinhaDescricaoServicos;
    End;
  End;

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SERTAOZINHO') Then
    strCNAE := ''
  Else
  begin
    if fEmptyStr(strCNAE) then
      strCNAE := dadosEmitente.strCNAEFiscal;
  end;

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS') Then
  Begin
    If Not fEmptyStr(dadosGerais.strDisSer) Then
      strDesSer := AnsiReplaceStr(AnsiReplaceStr(dadosGerais.strDisSer, #13#10, '#'), '<<csq>>', '#');
  End
  Else
  If (objConfigInterna.strTpNfCr = J_A_MASSA_CONCRETO) Then
  Begin
    If Not fEmptyStr(dadosGerais.strDisSer) Then
      strDesSer := strDesSer + '#' + AnsiReplaceStr(AnsiReplaceStr(dadosGerais.strDisSer, #13#10, '#'), '<<csq>>', '#');
  End;

  If Not fEmptyStr(dadosGerais.strOrdMaoObraCli) Then
    strDesSer := strDesSer + '#' + dadosGerais.strOrdMaoObraCli;

  If Not fEmptyStr(dadosGerais.strObsNFSOrdServ) Then
    strDesSer := strDesSer + '#' + dadosGerais.strObsNFSOrdServ;

  If (fCfgSisFonte(Self.FonteDados, 'MENNFS') = 'S') And
     (not fPrefeituraDisponibilizaCampoObservacao) Then
  Begin
    If Not fEmptyStr(dadosGerais.strMen001) then
      strDesSer := strDesSer + '#' + dadosGerais.strMen001;

    If Not fEmptyStr(dadosGerais.strMen002) then
      strDesSer := strDesSer + '#' + dadosGerais.strMen002;

    If Not fEmptyStr(dadosGerais.strMen003) then
      strDesSer := strDesSer + '#' + dadosGerais.strMen003;

    If Not fEmptyStr(dadosGerais.strMen004) then
      strDesSer := strDesSer + '#' + dadosGerais.strMen004;

    If Not fEmptyStr(dadosGerais.strMen005) then
      strDesSer := strDesSer + '#' + dadosGerais.strMen005;
  End;

  If Not fEmptyStr(dadosGerais.strMensagemAplicacao) Then
    strDesSer := strDesSer + '#Informações: ' + AnsiReplaceStr(AnsiReplaceStr(dadosGerais.strMensagemAplicacao, #13#10, '#'), '<<csq>>', '#');

  If (strTriMun = '010500') And
     ((dadosEmitente.strCnpj = '01919383000169') Or (dadosEmitente.strCnpj = '51212892000125')) Then
  Begin
    If (Not fEmptyStr(strDesSer)) Then
      strDesSer := strDesSer + '#';

    strDesSer := strDesSer + 'NÃO HÁ RETENÇÃO DE CSRF NO SERVIÇO LICENCIAMENTO OU CESSÃO DE USO, NÃO SE TRATA DE SERVIÇO DE PROGRAMAÇÃO (SC COSIT N° 157/2023 (CSLL E PIS/COFINS); SC COSIT N° 243/2017).';
  End;

  blnEmissaoNotaPropriaCitel := (fCfgSisFonte(Self.fonteDados, 'AXCFNS') = 'S');
  If (blnEmissaoNotaPropriaCitel) Then
    strDesSer := AnsiReplaceStr(strDesSer, '<<csq>>', ' ');

  strDesSer := fTiraCaracEspeciais(strDesSer, False);
  strDesSer := AnsiReplaceStr(AnsiReplaceStr(strDesSer, #13, ''), #10, '');

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE CAMPO LARGO') Or (objConfigInterna.strEmpNFSe = 'PREFEITURA DE LIMEIRA') Or (blnEmissaoNotaPropriaCitel) Then
    strDesSer := AnsiReplaceStr(strDesSer, '#', ' - ');

  stlArquivo.Add( 'NFSE-RPS-SERVICO'          + '|' +  //01 FIXO
                  fRetornaId                  + '|' +  //02 ID REFERÊNCIA
                  strCodSLC                   + '|' +  //03 CÓDIGO DO SERVIÇO
                  strCNAE                     + '|' +  //04 CNAE
                  strTriMun                   + '|' +  //05 CÓDIGO TRIBUTAÇÃO MUNICÍPIO
                  strDesSer                   + '|' +  //06 DESCRIÇÃO DO SERVIÇO
                  fGetIbgeLocalServico        + '|' +  //07 CÓDIGO IBGE MUNICÍPIO
                                                '|' +  //08 NUMERO DO ITEM (Apenas quando a prefeitura permitir mais de um item na NFS-e)
                                                '|' +  //09 VALOR          (Apenas quando a prefeitura permitir mais de um item na NFS-e)
                                                '|' +  //10 QUANTIDADE     (Apenas quando a prefeitura permitir mais de um item na NFS-e)
                                                '|' +  //11 CÓDIGO MUNÍCIPIO INCIDÊNCIA (CASO NÃO INFORMADO)
                                                '|' +  //12 CÓDIGO DO PAÍS (NFS-E PADRÃO NACIONAL)
                  strCodNBS                            //13 CÓDIGO NBS (NFS-E PADRÃO NACIONAL)
                );

  pReformaTributaria(stlArquivo, strSerIndOpe);
end;

function TNFESFit.fPrefeituraDisponibilizaCampoObservacao: Boolean;
begin
  Result := False;
  If (fCfgSisFonte(Self.FonteDados, 'CIDNFS') = 'PREFEITURA DE TUBARÃO-SC') Then
    Result := True;
end;

procedure TNFESFit.pServicoPrestado(stlArquivo: TStringList);
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  If fPrefeituraPermiteMaisDeUmItem Then
    pAdicionarMaisDeUmServico(stlArquivo)
  Else
    pAdicionarServicosConcatenados(stlArquivo);
end;

procedure TNFESFit.pAdicionarMaisDeUmServico(stlArquivo: TStringList);
  Var
    intCont: Integer;
    dadosItem: TDadosItem;
    strDesSer,
    strCNAE: String;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    strDesSer := dadosItem.strDesIte;

    If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SERTAOZINHO') Then
      strCNAE := ''
    Else
    Begin
      If (Not fEmptyStr(dadosItem.strCnaeFiscal)) And
         (fCfgSisFonte(fonteDados, 'CNAESV') = 'S') Then
        strCNAE := dadosItem.strCnaeFiscal
      Else
        strCNAE := dadosEmitente.strCNAEFiscal;
    End;

    If (intCont = 0) And (Not fEmptyStr(dadosGerais.strMensagemAplicacao)) Then
      strDesSer := strDesSer + IfThen(fEmptyStr(strDesSer), '', '#') + 'Informações: ' + AnsiReplaceStr(AnsiReplaceStr(dadosGerais.strMensagemAplicacao, #13#10, '#'), '<<csq>>', '#');

    If (dadosItem.strTriMun = '010500') And
       ((dadosEmitente.strCnpj = '01919383000169') Or (dadosEmitente.strCnpj = '51212892000125')) Then
    Begin
      If (Not fEmptyStr(strDesSer)) Then
        strDesSer := strDesSer + '#';

      strDesSer := strDesSer + 'NÃO HÁ RETENÇÃO DE CSRF NO SERVIÇO LICENCIAMENTO OU CESSÃO DE USO, NÃO SE TRATA DE SERVIÇO DE PROGRAMAÇÃO (SC COSIT N° 157/2023 (CSLL E PIS/COFINS); SC COSIT N° 243/2017).';
    End;

    stlArquivo.Add( 'NFSE-RPS-SERVICO'                + '|' +  //01 FIXO
                    fRetornaId                        + '|' +  //02 ID REFERÊNCIA
                    dadosItem.strCodSLC               + '|' +  //03 CÓDIGO DO SERVIÇO
                    strCNAE                           + '|' +  //04 CNAE
                    dadosItem.strTriMun               + '|' +  //05 CÓDIGO TRIBUTAÇÃO MUNICÍPIO
                    strDesSer                         + '|' +  //06 DESCRIÇÃO DO SERVIÇO
                    fGetIbgeLocalServico              + '|' +  //07 CÓDIGO IBGE MUNICÍPIO
                    fStrZero(intCont+1, 3)            + '|' +  //08 NUMERO DO ITEM (Apenas quando a prefeitura permitir mais de um item na NFS-e)
                    fNumerico(dadosItem.fltTotIte-
                              dadosItem.fltDesEsp, 2) + '|' +  //09 VALOR          (Apenas quando a prefeitura permitir mais de um item na NFS-e)
                    fNumerico(dadosItem.fltQtdIte, 4) + '|' +  //10 QUANTIDADE     (Apenas quando a prefeitura permitir mais de um item na NFS-e)
                                                        '|' +  //11 CÓDIGO MUNÍCIPIO INCIDÊNCIA (CASO NÃO INFORMADO)
                                                        '|' +  //12 CÓDIGO DO PAÍS (NFS-E PADRÃO NACIONAL)
                    dadosItem.strCodNBS                        //13 CÓDIGO NBS (NFS-E PADRÃO NACIONAL)
                  );

    pReformaTributaria(stlArquivo, dadosItem.strSerIndOpe);
  End;
end;

function TNFESFit.fGetIbgeLocalServico: String;
begin
  If fGetNaturezaOperacao(objConfig, dadosGerais, dadosEmitente) = '1' Then
    Result := dadosEmitente.strCodIbge
  Else
    Result := dadosGerais.strCodIbgeEntrega;

  //CS FERRAMENTAS
  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SOROCABA') Then
    Result := dadosEmitente.strCodIbge;
end;

procedure TNFESFit.pTotalServico(stlArquivo: TStringList);
  Var
    fltPerIss: Double;
    fltValIss: Double;
    fltIssRet: Double;
    fltValLiq: Double;
    fltOutRet: Double;
    fltValDed: Double;
    fltCslEnv: Double;
    strRecBru: String;
    strRespRet: String;
    LStringParaEnvio : string;
begin
  fltPerIss := dadosGerais.fltPerIss;
  fltValIss := dadosGerais.fltValIss;
  fltIssRet := 0;

  If dadosGerais.fltBasIss <= 0 Then
    dadosGerais.fltBasIss := dadosGerais.fltTotSer;

  If (fltPerIss <= 0) And (dadosGerais.fltBasIss > 0) Then
    fltPerIss := (fltValIss / dadosGerais.fltBasIss) * 100;

  If dadosGerais.strRetIss = 'S' Then
  Begin
    fltIssRet := fltValIss;
    If objConfigInterna.blnZerIss Then
      fltValIss := 0;
  End;

  fltOutRet := dadosGerais.fltPisRet +
               dadosGerais.fltCofRet +
               dadosGerais.fltIrfRet +
               dadosGerais.fltCslRet +
               dadosGerais.fltVlSgSo;

  fltValLiq := dadosGerais.fltTotSer - fltOutRet - fltIssRet;

  fltOutRet := 0;

  fltCslEnv := dadosGerais.fltCslRet;

  If (dadosGerais.strRetPco = 'S') Then
  Begin
    fltCslEnv := dadosGerais.fltCslRet +
                 dadosGerais.fltPisRet +
                 dadosGerais.fltCofRet;
  End;

  //Deducoes na base de calculo do ISS (exemplo: "prestcon" onde a base iss
  //pode ser a diferenca entre o total do concreto e o custo do mesmo).
  fltValDed := dadosGerais.fltTotSer - dadosGerais.fltBasIss;

  {**************************************************************************}
  {* E208 - Valor do iss não pode ser superior a R$ 0,00 (zero) quando o    *}
  {* contribuinte for optante do simples nacional e não tiver iss           *}
  {* retido na fonte. - Informe o campo de Valor do iss igual               *}
  {* a R$ 0,00 (zero) quando o contribuinte for optante do simples nacional *}
  {**********************************************************************JC**}
  If Not objConfigInterna.blnSimISS Then
  Begin
    If fSimplesPaulista(dadosGerais, dadosEmitente) And (fltIssRet = 0) Then
      fltValIss := 0;
  End;

  If dadosGerais.fltReceitaBrutaNS >= 0 Then
    strRecBru := fNumerico(dadosGerais.fltReceitaBrutaNS, 2) + '|'
  Else
    strRecBru := '';

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE SERTAOZINHO') Then
    strRespRet := ''
  Else If (fConfiguracaoExisteFonte(Self.FonteDados, 'RSRTNS')) Then
    strRespRet := Trim(fCfgSisFonte(Self.FonteDados, 'RSRTNS'))
  Else
    strRespRet := '1';

  TotalServico.fltPerIss  := fltPerIss;
  TotalServico.fltValIss  := fltValIss;
  TotalServico.fltIssRet  := fltIssRet;
  TotalServico.fltValLiq  := fltValLiq;
  TotalServico.fltOutRet  := fltOutRet;
  TotalServico.fltValDed  := fltValDed;
  TotalServico.strRecBru  := strRecBru;
  TotalServico.strRespRet := strRespRet;

  LStringParaEnvio := '' +
                      'NFSE-RPS-TOTAL|'                                                         +       //01 FIXO
                      fRetornaId                                                                + '|' + //02 ID REFERÊNCIA
                      fNumerico(dadosGerais.fltTotSer, 2                           )            + '|' + //03 Valor Serviços
                      fNumerico(fltValDed, 2)                                                   + '|' + //04 Valor Deduções
                      IIF(objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS', fNumerico(0, 2), fNumerico(dadosGerais.fltPisRet, 2)) + '|' + //05 Valor PIS
                      IIF(objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS', fNumerico(0, 2), fNumerico(dadosGerais.fltCofRet, 2)) + '|' + //06 Valor COFINS
                      fNumerico(dadosGerais.fltIrfRet, 2)                                       + '|' + //07 Valor IR
                      fNumerico(fltCslEnv, 2)                                                   + '|' + //08 Valor CSLL
                      dadosGerais.strRetIss                                                     + '|' + //09 ISS Retido
                      fNumerico(fltIssRet, 2)                                                   + '|' + //10 Valor ISS Retido
                      fNumerico(fltOutRet, 2)                                                   + '|' + //11 Valor Outras Retenções
                      fNumerico(IIF(fEnviaAliquotaISS, dadosGerais.fltBasIss, 0), 2)            + '|' + //12 Valor Base Calculo
                      fNumerico(IIF(fEnviaAliquotaISS,             fltPerIss, 0), 4)            + '|' + //13 Alíquota ISS
                      fNumerico(IIF(fEnviaAliquotaISS,             fltValIss, 0), 2)            + '|' + //14 Valor do ISS
                      fNumerico(fltValLiq, 2)                                                   + '|' + //15 Valor Liquido NFS-e
                      fNumerico(0, 2)                                                           + '|' + //16 Valor Desconto Incondicional
                      fNumerico(0, 2)                                                           + '|' + //17 Valor Desconto Condicional
                      fNumerico(dadosGerais.fltVlSgSo, 2)                                       + '|' + //18 Valor INSS (Seguridade Social)
                      strRespRet                                                                + '|' + //19 Responsável Retenção: 1 – Tomador  / 2 – Intermediario ( quando opção 2 obrigatorio informar CpfCnpjTomador )
                      strRecBru                                                                 + '|' + //20 Receita Bruta
                                                                                                  '|' + //21 Alíquota ISS Retido
                                                                                                  '|' + //22 Valor Base Calculo IRRF
                                                                                                  '|' + //23 Alíquota IRRF
                                                                                                  '|' + //24 Valor Base Calculo INSS
                                                                                                  '|' + //25 Alíquota INSS
                      IIF(dadosGerais.strRetPco = 'S',fNumerico(dadosGerais.fltTotSer,2),'')    + '|' + //26 Valor Base Calculo PIS
                      IIF(dadosGerais.strRetPco = 'S',fNumerico(dadosGerais.fltAlqPisRet,4),'') + '|' + //27 Alíquota PIS
                      IIF(dadosGerais.strRetPco = 'S',fNumerico(dadosGerais.fltTotSer,2),'')    + '|' + //28 Valor Base Calculo COFINS
                      IIF(dadosGerais.strRetPco = 'S',fNumerico(dadosGerais.fltAlqCofRet,4),'') + '|' + //29 Alíquota COFINS
                      IIF(dadosGerais.strRetPco = 'S',fNumerico(dadosGerais.fltTotSer,2),'')    + '|' + //30 Valor Base Calculo CSLL
                      IIF(dadosGerais.strRetPco = 'S',fNumerico(dadosGerais.fltAlqCslRet,4),'') + '|' + //31 Alíquota CSLL
                                                                                                  '|' + //32 ISS Retido no Município Prestado
                                                                                                  '|' + //33 Discriminaçao de retençao e/ou dedução.
                                                                                                  '|' + //34 Valor da Carga Tributária
                                                                                                '01|' + //35 CST do PIS / COFINS (NFS-e Padrão Nacional)
                      IIF(dadosGerais.strRetPco = 'S', '3','0')                                 + '|' + //36 Tipo de Retenção do PIS / COFINS (NFS-e Padrão Nacional)
                      fNumerico(0, 2)                                                           + '|' + //37 Valor Total dos Tributos Federais (NFS-e Padrão Nacional)
                      fNumerico(0, 2)                                                           + '|' + //38 Valor Total dos Tributos Estaduais (NFS-e Padrão Nacional)
                      fNumerico(IIF(fEnviaAliquotaISS, fltValIss, 0), 2)                        + '|' ; //39 Valor Total dos Tributos Municipais (NFS-e Padrão Nacional)

  if  objConfigInterna.strEmpNFSe = 'PREFEITURA DE ARARAS' then
    LStringParaEnvio :=  LStringParaEnvio                                 + '|' +
                         fNumerico(0, 4)                                  + '|' + //21 Alíquota ISS Retido

                         IIF(dadosGerais.fltIrfRet = 0,
                             fNumerico(0, 2),
                             fNumerico(dadosGerais.fltTotSer, 2))         + '|' + //22 Valor Base Calculo IRRF
                         IIF(dadosGerais.fltIrfRet = 0,
                             fNumerico(0, 4),
                             fNumerico(dadosGerais.fltAliquotaIRRF, 4))   + '|' + //23 Alíquota IRRF

                         fNumerico(0, 2)                                  + '|' + //24 Valor Base Calculo INSS
                         fNumerico(0, 4)                                  + '|' + //25 Alíquota INSS
                         fNumerico(0, 2)                                  + '|' + //26 Valor Base Calculo PIS
                         fNumerico(0, 4)                                  + '|' + //27 Alíquota PIS
                         fNumerico(0, 2)                                  + '|' + //28 Valor Base Calculo COFINS
                         fNumerico(0, 4)                                  + '|' + //29 Alíquota COFINS

                         IIF(dadosGerais.fltCslRet = 0,
                             fNumerico(0, 2),
                             fNumerico(dadosGerais.fltTotSer, 2))         + '|' + //30 Valor Base Calculo CSLL
                         IIF(dadosGerais.fltCslRet = 0,
                             fNumerico(0, 4),
                             fNumerico(dadosGerais.fltAliquotaCSLL, 4))   ;       //31 Alíquota CSLL

  stlArquivo.Add(LStringParaEnvio);
end;

function TNFESFit.fNumerico(fltValor: Double; intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, 12, intDecimais);
  Result := AnsiReplaceStr(Result, '.', '');
  Result := AnsiReplaceStr(Result, ',', '');
end;

function TNFESFit.fMensagemErro: String;
begin
  Result := '';
end;

function TNFESFit.fPrefeituraPermiteMaisDeUmItem: Boolean;
begin
  Result := False;

  If (objConfigInterna.strEmpNFSe = 'PREFEITURA DE PIRACICABA') Then
    Result := True;
end;

function TNFESFit.fProcessarCancelamento: TRetornoNFE;
Var
  retornoFit: TWSNfeFitRetorno;
  intStatus: Integer;
  strMensagem: String;
  stlRetorno: TStringList;
  strNumRps: String;
begin
  retornoFit := fitWrapper.fConsultaSituacaoServico(fRetornaId);

  stlRetorno := TStringList.Create;
  Try
    stlRetorno.Add(retornoFit.Texto);
    Try
      stlRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFS_CANC.TXT'));
    Except

    End;
  Finally
    FreeAndNil(stlRetorno);
  End;

  intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 3), 0);
  strMensagem := fGetValorLinha(retornoFit.Texto, '|', 4);
  strNumRps := fGetValorLinha(retornoFit.Texto, '|', 7);

  If intStatus = CANCELADA Then
  Begin
    pIntegracaoPainelCitelNFSeCancelamento(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                           dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ND');

    Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, fRetornaId, strNumRps, nOw());
  End
  Else If (intStatus = ERRO) Or
          (intStatus = ERRO_ESTRUTURA) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End
  Else If fStatusAguardando(intStatus) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoAguardando;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFESFit.fProcessarEnvio: TRetornoNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatus: Integer;
    strMensagem: String;
    stlRetorno: TStringList;
    strNumRps: String;
    blnLiberadaManualmente: Boolean;
    blnDocumentoImpresso: Boolean;
begin
  retornoFit := fitWrapper.fConsultaSituacaoServico(fRetornaId);

  stlRetorno := TStringList.Create;
  Try
    stlRetorno.Add(retornoFit.Texto);
    Try
      stlRetorno.SaveToFile(fPnlDir('ULTIMO_RETORNO_NFS.TXT'));

      Self.fonteDados.pGravarLogFit(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie,
                                    dadosGerais.strCodCli, dadosGerais.strTip_FC, 'RETORNO', stlRetorno.Text);
    Except

    End;
  Finally
    FreeAndNil(stlRetorno);
  End;

  intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 3), 0);
  strMensagem := fGetValorLinha(retornoFit.Texto, '|', 4);
  strNumRps := fGetValorLinha(retornoFit.Texto, '|', 7);

  blnLiberadaManualmente := fTrataRetornoNFSeRoraimaComErro(intStatus, strMensagem, strNumRps);

  If intStatus = SUCESSO Then
  Begin
    Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, fRetornaId, strNumRps, nOw());

    Self.fonteDados.pGravarLogNfe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp, dadosGerais.strSerie, dadosGerais.strCodCli,
                                  dadosGerais.strTip_FC, 'AF', strMensagem, fRetornaId, nOw(), fDefineImpressora(dadosGerais));

    pIntegracaoPainelCitelNFSe(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                               dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC, 'ND');

    blnDocumentoImpresso := Self.fonteDados.fRetornaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                                                      dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);

    If (Not blnLiberadaManualmente) And (Not blnDocumentoImpresso) Then
    Begin
      pImprimirDanfeInterna(fRetornaId, fDefineImpressora(dadosGerais), 0, fRetornaId);
      Self.fonteDados.pGravaDocumentoImpresso(dadosGerais.strNumDoc, dadosGerais.strEspDoc, dadosGerais.strCodEmp,
                                              dadosGerais.strSerie,  dadosGerais.strCodCli, dadosGerais.strTip_FC);
    End;
  End
  Else If (intStatus = ERRO) Or
          (intStatus = ERRO_ESTRUTURA) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End
  Else If fStatusAguardando(intStatus) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoAguardando;
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFESFit.fTrataRetornoNFSeRoraimaComErro(Var intStatus: Integer; Var strMensagem, strNumRps: String): Boolean;
begin
  Result := False;
   
  If (Assigned(fonteDados) And Assigned(fonteDados.fDadosEmitente)) And
     (fonteDados.fDadosEmitente.strEstado = 'RR') And
     (intStatus = ERRO) Then
  Begin
    If fMessageDlg('Erro ao processar retorno NFSe',
                   'A nota de serviço ' + strNumRps + ' teve um retorno desconhecido enviado pelo orgão ' + #13#10 +
                   'municipal responsável. Mensagem de Erro: "' + strMensagem + '". ' + #13#10 + 'Caso a mesma esteja autorizada ' +
                   'no site da Prefeitura, selecione a opção [Autorizada]:', 'Não Autorizada', 'Autorizada') = 'Autorizada' Then
    Begin
      Result      := True;    
      intStatus   := SUCESSO;
      strMensagem := 'Autorizada manualmente pelo usuário';
    End;
  End;  
  
end;

function TNFESFit.fStatusAguardando(intStatus: Integer): Boolean;
  Var
    intIndice: Integer;
  Const
    RET_STATUS_AGUARDANDO: Array[1..3] Of Integer = (1, 2, 3);
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

function TNFESFit.fProcessarStatusNota: TRetornoNFE;
begin
  Result := fProcessarEnvio;
end;

function TNFESFit.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;   // Modificada para True para poder passar para a reimpressão de Danfe.
                    // Utilizando a mesma lógica das classes referentes a NFE (untNFEFit400)
                    // Na untLibNfe tem a condição "If service.fSuportaFuncoesAdministrativas" então chama a reimpresssão.
end;

function TNFESFit.fVerificarStatusNota: Boolean;
begin
  Result := True;
end;

function TNFESFit.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

function TNFESFit.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

procedure TNFESFit.pAdicionaItem(dadosItem: TDadosItem);
begin
  If (Not Assigned(lstItens)) Then
    lstItens := TList.Create;

  lstItens.Add(dadosItem);
end;

procedure TNFESFit.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

procedure TNFESFit.pImprimirDanfeInterna(strChaveAcesso, strImpressora: String;
  intViasServidor: Integer; strIdNota: String; strImprimirTelaPDF: String = '');
  Var
    strNumDoc: String;
begin
  If fEmptyStr(strChaveAcesso) Then
  Begin
    Raise Exception.Create('A chave de acesso deve ser informada.');
  End;

  strNumDoc := LeftStr(strChaveAcesso,  9);
  If Not fEmptyStr(strIdNota) Then
    strIdNota := IntToStr(StrToInt64(strIdNota));

  fitWrapper.fDownloadDanfe(IntToStr(StrToInt64(strChaveAcesso)), fNumDocEnvio(strNumDoc), strImpressora,
    TMetodoImpressaoFactory.fCriarNotaServico('NFSe_'), intViasServidor, strIdNota, Nil, Self.fonteDados, False, 0, strImprimirTelaPDF);
end;

procedure TNFESFit.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
  strNumeroFinal, strDescricao: String);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Citel.');
end;

function TNFESFit.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := False;
End;

procedure TNFESFit.pReimprimeDanfe(strChaveAcesso: String);
  Var
    strImpressora: String;
begin
  strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
  pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
end;

procedure TNFESFit.pPrepararEmails;
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

function TNFESFit.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
begin
  If (Not Assigned(dadosGeraisArg)) Or (fEmptyStr(dadosGeraisArg.strPontoImpressao)) Then
    Result := fIdentificarNomeDaImpressora(fonteDados, objConfig.strFitImpressoraPadrao)
  Else
    Result := fIdentificarNomeDaImpressora(fonteDados, dadosGeraisArg.strPontoImpressao);
end;

procedure TNFESFit.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
begin
  If fEmptyStr(strChaveAcesso) Then
    Raise Exception.Create('A chave de acesso deve ser informada.');

  pSetaDadosGerais(fonteDados.fDadosGerais);

  pImprimirDanfeInterna(fRetornaId, strImpressora, 0, fRetornaId, strImprimirTelaPDF);
end;

procedure TNFESFit.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TNFESFit.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFESFit.pIntegracaoPainelCitelNFSe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE_XML');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE_PDF');
end;

procedure TNFESFit.pIntegracaoPainelCitelNFSeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli, strTip_FC, strProtoc, 'NFSE_CANCELAMENTO');
end;

function TNFESFit.fConsultaStatusDFe(strChaveAcesso: string): String;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatus: Integer;
    strMensagem: String;
    strCancelado: String;

    stlArquivo: TStringList;
begin
  pLogImp('TNFESFit.fConsultaStatusDFe >');

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

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function TNFESFit.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  Result := '';
end;

function TNFESFit.fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55'): String;
begin
  Result := '';
end;

{*******************************************************************************}
{* O Valor do ISS só deve ser informado em casos onde o contribuinte prestador *}
{* é Simples Nacional ou a prestação de serviço é em outro município.          *}
{****************************************************************************BZ*}
function TNFESFit.fEnviaAliquotaISS: Boolean;
begin

  Result := True;

  If not (fCfgSisFonte(fonteDados, 'REGISS') = 'S') Then
    Exit;

  Result := False;

  If fSimplesPaulista(dadosGerais, dadosEmitente) Then
  Begin
    Result := True;
    Exit;
  End;

  If (dadosEmitente.strCodIbge <> fGetIbgeLocalServico) Then
  Begin
    Result := True;
    Exit;
  End;

end;

procedure TNFESFit.pNFETrailler(stlArquivo: TStringList);
begin
  stlArquivo.Add('TRAILLER|' + IntToStr(stlArquivo.Count+1));
end;

procedure TNFESFit.pReformaTributaria(stlArquivo: TStringList; strSerIndOpe: String);
begin

  stlArquivo.Add('' +
                 'NFSE-RPS-IBSCBS|'                                       +       // 01 FIXO NFSE-RPS
                 fRetornaId()                                             + '|' + // 02 ID DA NOTA
                 '000'                                                    + '|' + // 03 Código de Situação Tributária do IBS e da CBS
                 '000001'                                                 + '|' + // 04 Código de Classificação Tributária do IBS e da CBS
                 ''                                                       + '|' + // 05 Código de classificação do crédito presumido: IBS e CBS.
                 ''                                                       + '|' + // 06 Código de Situação Tributária do IBS e da CBS de tributação regular.
                 ''                                                       + '|' + // 07 Código da Classificação Tributária do IBS e da CBS de tributação regular
                 '0'                                                      + '|' + // 08 Indicador da finalidade da emissão de NFS-e: 0 - NFS-e regular
                 ''                                                       + '|' + // 09 Indica operação de uso ou consumo pessoal. 0 – Não 1 – Sim
                 strSerIndOpe                                             + '|' + // 10 Código indicador da operação de fornecimento, conforme tabela “código indicador de operação”
                 ''                                                       + '|' + // 11 Tipo de ente governamental Para administração pública direta e suas autarquias e fundações: 1 – União 2 – Estado 3 – Distrito Federal 4 – Município
                 ''                                                       + '|' + // 12 Tipo de Operação com Entes Governanementais ou outros serviços sobre bens imóveis: 1 – Fornecimento com pagamento posterior; 2 - Recebimento do pagamento com fornecimento já realizado; 3 – Fornecimento com pagamento já realizado; 4 – Recebimento do pagamento com fornecimento posterior; 5 – Fornecimento e recebimento do pagamento concomitantes
                 '0'                                                      + '|' + // 13 A respeito do Destinatário dos serviços: 0 – O tomador identificado na NFS-e é o adquirente e o destinatário do fornecimento (tomador = adquirente = destinatário); 1 – O tomador e o adquirente são a mesma pessoa, mas o destinatário é uma pessoa física ou jurídica ou equiparada diversa do indicado; como tomador/adquirente ou se trata de um estabelecimento do adquirente diferente do indicado no campo “tomador” (tomador = adquirente <> destinatário).
                 ''                                                       + '|' + // 14 Percentual de diferimento para o IBS estadual.
                 ''                                                       + '|' + // 15 Percentual de diferimento para o IBS municipal.
                 '')                                                              // 16 Percentual de diferimento para a CBS.

end;

function TNFESFit.fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude,
  strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFESFit.fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFESFit.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega,
  strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFESFit.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

end.
