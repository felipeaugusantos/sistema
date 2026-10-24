unit untCTEFit300;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Forms,
  Dialogs,
{$ENDIF}
  untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils,
  NfeApiWSBean, untConhecimentoEletronico, untInterfacesConhecimentoEletronico,
  untConstantesNFe, untUtilFIT, Types;

Type
  TIntegracaoConhecimentoFit = class(TInterfacedObject, IIntegracaoConhecimentoEletronico)
  private
    fonteDados: IFonteDados;
    fitWrapper: TWSNFeFitWrapper;

    strProtocoloConhecimento : String;
    strModeloConhecimento    : String;
    strDataHoraConhecimento  : String;

    procedure pGeraHeader(stlTexto: TStringList);
    procedure pGeraCabecalho(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraTomador(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraIdentificacaoEmitente(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraRemetente(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraDestinatario(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraValoresPrestacaoServico(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesImpostos(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesPartilha(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesCarga(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesQtdeCarga(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesNFe(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesServicoPrestado(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraInformacoesRodoviario(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
    procedure pGeraCTeTrailler(stlTexto: TStringList);
    procedure pGeraDadosAdicionais(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);

    function fFormataValorFit(fltValor: Double; intPrecisao, intDecimais: Integer): String;

    function fGeraRetornoConhecimento(conhecimento: TConhecimentoEletronico; retornoFit: TWSNfeFitRetorno): TRetornoNFE;
    function fRetornoPipe(const intIndexPipe, intQtdePipes: Integer; const strTextoRetorno: String): String;
    procedure pIntegracaoPainelCitelCTe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
    procedure pIntegracaoPainelCitelCTeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
  public
    constructor Create(fonteDados: IFonteDados);
    destructor Destroy; Override;
    function fEnviarConhecimento(conhecimento: TConhecimentoEletronico): Boolean;
    function fProcessarConhecimento(conhecimento: TConhecimentoEletronico): TRetornoNFE;
    procedure pImprimirConhecimento(conhecimento: TConhecimentoEletronico; strImpressora: String; strForcarImpressaoPDF: String = 'N');
    function fCancelarConhecimento(conhecimento: TConhecimentoEletronico; strJustificativa, strNomeUsuario: String): Boolean;

  end;

implementation

uses untUtil, untUtilBD, untLogDanfe;

{ TIntegracaoConhecimentoFit }

constructor TIntegracaoConhecimentoFit.Create(fonteDados: IFonteDados);
begin
  Self.fonteDados := fonteDados;
  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);
  If Not fEmptyStr(objConfig.strFitUrlWebServiceConhecimento) Then
    fitWrapper.strUrlAlternativa := objConfig.strFitUrlWebServiceConhecimento;
end;

destructor TIntegracaoConhecimentoFit.Destroy;
begin
  FreeAndNil(fitWrapper);
  inherited;
end;

function TIntegracaoConhecimentoFit.fCancelarConhecimento(conhecimento: TConhecimentoEletronico; strJustificativa, strNomeUsuario: String): Boolean;
var
  strTexto: String;
  retornoFit: TWSNfeFitRetorno;
begin
  strTexto := 'CTE-CANC|' +                        // 01 - Tipo de Registro
              conhecimento.strIdReferencia + '|' + // 02 - ID Referência
              '|' +                                // 03 - Chave de Acesso
              strJustificativa + '|' +             // 04 - Justificativa
              Copy(strNomeUsuario, 1, 20);         // 05 - Nome do usuário que efetua o cancelamento

  strTexto := fTiraCaracEspeciais(strTexto, False, False, False);

  retornoFit := fitWrapper.fEnviaTextoIntegracaoCTE_CANC(strTexto);

  Result := retornoFit.RetornoOk;

  If Result Then
  Begin
    pIntegracaoPainelCitelCTeCancelamento(conhecimento.strNumeroConhecimento, 'CT', conhecimento.strCodEmp, conhecimento.strSerie, ' ', ' ', 'ND');
    fitWrapper.pDownloadXmlCTe(fonteDados, conhecimento.strNumeroConhecimento, conhecimento.strChaveAcesso, true);
  End;

  If Not Result Then
  Begin
    if (fCountChar(retornoFit.Texto, '|') >= 10) then
      Raise Exception.Create('Não foi possível enviar o cancelamento do conhecimento: ' + 'Status: ' + fGetValorLinha(retornoFit.Texto, '|', 8) +
                             ' - Cod.Retorno Sefaz: ' + fGetValorLinha(retornoFit.Texto, '|', 9) +
                             ' - Descrição: ' + fGetValorLinha(retornoFit.Texto, '|', 10))
    else
      Raise Exception.Create('Não foi possível enviar o cancelamento do conhecimento: ' + retornoFit.Texto);
  End;
end;

function TIntegracaoConhecimentoFit.fEnviarConhecimento(conhecimento: TConhecimentoEletronico): Boolean;
Var
  stlTexto        : TStringList;
  retorno         : TWSNfeFitRetorno;
  strMsg          : String;
  resultValidacao : TResultadoValidacao;
  strPipe3,
  strPipe7        : String;
  intQtdePipes    : Integer;
  strAcesso       : String;
begin
  stlTexto := TStringList.Create;

  try

    pGeraHeader(stlTexto);
    pGeraCabecalho(stlTexto, conhecimento);
    pGeraTomador(stlTexto, conhecimento);
    pGeraDadosAdicionais(stlTexto, conhecimento);
    pGeraIdentificacaoEmitente(stlTexto, conhecimento);
    pGeraRemetente(stlTexto, conhecimento);
    pGeraDestinatario(stlTexto, conhecimento);
    pGeraValoresPrestacaoServico(stlTexto, conhecimento);
    pGeraInformacoesImpostos(stlTexto, conhecimento);
    pGeraInformacoesPartilha(stlTexto, conhecimento);
    pGeraInformacoesCarga(stlTexto, conhecimento);
    pGeraInformacoesQtdeCarga(stlTexto, conhecimento);
    pGeraInformacoesNFe(stlTexto, conhecimento);
    pGeraInformacoesServicoPrestado(stlTexto, conhecimento);
    pGeraInformacoesRodoviario(stlTexto, conhecimento);
    pGeraCTeTrailler(stlTexto);

    stlTexto.Text := fTiraCaracEspeciais(stlTexto.Text, False, False, False);

    Try
      stlTexto.SaveToFile('ULTIMO_CTE.TXT');
    Except

    End;

    retorno := fitWrapper.fEnviaTextoIntegracaoCTE(Trim(stlTexto.Text));

    Result := retorno.RetornoOk;

    stlTexto.Clear;
    stlTexto.Add(retorno.Texto);

    Try
      stlTexto.SaveToFile(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_RETORNO_CTE.TXT');
    Except

    End;

  finally
    FreeAndNil(stlTexto);
  end;

  If Result Then
  Begin
    strAcesso := fGetValorLinha(retorno.Texto, '|', 9);

    If not fEmptyStr(strAcesso) Then
    Begin
      pIntegracaoPainelCitelCTe(conhecimento.strNumeroConhecimento, 'CT', conhecimento.strCodEmp, conhecimento.strSerie, ' ', ' ', 'ND');
      fitWrapper.pDownloadXmlCTe(fonteDados, conhecimento.strNumeroConhecimento, strAcesso, false);
      fitWrapper.pDownloadPdfCTe(fonteDados, conhecimento.strNumeroConhecimento, strAcesso);
    End;
  End;

  If Not Result Then
  Begin
    intQtdePipes := fCountChar(retorno.Texto, '|');
    strPipe3 := fRetornoPipe(3, intQtdePipes, retorno.Texto);
    strPipe7 := fRetornoPipe(7, intQtdePipes, retorno.Texto);

    If (strPipe7 = '57') Then
    Begin
      Result := True;
      Exit;
    End;

    if (Pos('arquivo recebido com erros', AnsiLowerCase(strPipe3)) > 0) then
    begin
      if (intQtdePipes >= 12) then
      begin
        strMsg := 'Erro: ' + fGetValorLinha(retorno.Texto, '|', 12);
        if (intQtdePipes >= 13) then
          strMsg := strMsg + ': ' + fGetValorLinha(retorno.Texto, '|', 13);
      end
      else
        strMsg := 'Erro: ' + retorno.Texto;
    end
    else If Not fEmptyStr(strPipe3 + strPipe7) Then
      strMsg := 'Erro: ' + strPipe3 + ': ' + strPipe7
    Else
      strMsg := IIF(fEmptyStr(retorno.Texto), '(Não obteve nenhum retorno da FIT)', retorno.Texto);

    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    pLogImp(strMsg);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;
end;

function TIntegracaoConhecimentoFit.fFormataValorFit(fltValor: Double; intPrecisao, intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TIntegracaoConhecimentoFit.fGeraRetornoConhecimento(conhecimento: TConhecimentoEletronico; retornoFit: TWSNfeFitRetorno): TRetornoNFE;
var
  intStatus: Integer;
  strMsg: string;
  strAcesso: string;
  stlRet: TStringList;
begin
  stlRet := TStringList.Create;
  Try
    Try
      stlRet.Add(retornoFit.Texto);
      stlRet.SaveToFile(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_RETORNO_CTE.TXT');
    Except
    End;
  finally
    FreeAndNil(stlRet);
  end;

  strMsg := fGetValorLinha(retornoFit.Texto, '|', 11);

  If Not retornoFit.RetornoOk Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro(strMsg)
  End
  Else
  Begin
    intStatus := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 10), -1);
    strAcesso := fGetValorLinha(retornoFit.Texto, '|', 8);

    strProtocoloConhecimento := fGetValorLinha(retornoFit.Texto, '|', 12);
    strModeloConhecimento    := fGetValorLinha(retornoFit.Texto, '|', 5);
    strDataHoraConhecimento  := fGetValorLinha(retornoFit.Texto, '|', 13);

    If (intStatus In [1,2,3,4,5,6,9,103,104,105]) Then
      Result := TRetornoNFE.fCriaRetornoAguardando
    Else If (intStatus in [101,135]) Then
      Result := TRetornoNFE.fCriaRetornoCancelada('')
    Else If intStatus = 100 Then
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMsg, strAcesso, '', nOw());
      Result := TRetornoNFE.fCriaRetornoConhecimento(Result, strProtocoloConhecimento, strModeloConhecimento, strDataHoraConhecimento);
    End
    Else
      Result := TRetornoNFE.fCriaRetornoErro(strMsg);

    If (intStatus = 100) Then
    Begin
      pIntegracaoPainelCitelCTe(conhecimento.strNumeroConhecimento, 'CT', conhecimento.strCodEmp, conhecimento.strSerie, ' ', ' ', 'ND');
      fitWrapper.pDownloadXmlCTe(fonteDados, conhecimento.strNumeroConhecimento, strAcesso, false);
      fitWrapper.pDownloadPdfCTe(fonteDados, conhecimento.strNumeroConhecimento, strAcesso, conhecimento.tipoImpressao);
    End;

  End;
end;

function TIntegracaoConhecimentoFit.fProcessarConhecimento(conhecimento: TConhecimentoEletronico): TRetornoNFE;
var
  retornoFit: TWSNfeFitRetorno;
begin
  retornoFit := fitWrapper.fConsultaSituacaoIdConhecimento(conhecimento.strIdReferencia);

  Result := fGeraRetornoConhecimento(conhecimento, retornoFit);

  If Result.Sucesso Then
  Begin
    try
      pImprimirConhecimento(conhecimento, objConfig.strFitImpressoraPadrao);
    Except
      On E: Exception Do
      Begin
        Result.SetaErroImpressao(E.Message);
      End;
    End;
  End;
end;

function TIntegracaoConhecimentoFit.fRetornoPipe(const intIndexPipe, intQtdePipes: Integer; const strTextoRetorno: String): String;
begin
  Result := '';
  If (intQtdePipes >= intIndexPipe) Then
    Result := fGetValorLinha(strTextoRetorno, '|', intIndexPipe);
end;

procedure TIntegracaoConhecimentoFit.pGeraCabecalho(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE|' +                                                                        // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                       + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.IdentificacaoEmitente.strCnpj                         + '|' +      // 03 - CNPJ da empresa emissor da NF-e
    conhecimento.IdentificacaoEmitente.strUfIbge                       + '|' +      // 04 - Código da UF do emitente do CT-e. Utilizar a Tabela do IBGE.
    conhecimento.strCFOP                                               + '|' +      // 05 - Código Fiscal de Operações e Prestações.
    conhecimento.strNaturezaOperacao                                   + '|' +      // 06 - Natureza da Operação
                                                                         '|' +      // 07 - Campo não utilizado. Enviar em branco/vazio
    conhecimento.strSerie                                              + '|' +      // 08 - Serie documento fiscal, informar zero para série única.
    conhecimento.strNumeroConhecimento                                 + '|' +      // 09 - Número do documento fiscal
    FormatDateTime('ddmmyyyy', conhecimento.dtaDataEmissao)            + '|' +      // 10 -
    FormatDateTime('hhmmss', nOw())                                    + '|' +      // 11 -
    IIF(objConfig.blnHomolo, '2', '1')                                 + '|' +      // 12 - 1 - Produção; 2 – Homologação
    conhecimento.strTipoCTe                                            + '|' +      // 13 - 0 - CT-e Normal; 1 - CT-e de Complemento de Valores; 2 - CT-e de Anulação de Valores; 3 - CT-e Substituto.
                                                                         '|' +      // 14 - Campo não utilizado. Enviar em branco/vazio.
    conhecimento.IdentificacaoEmitente.strCodIbge                      + '|' +      // 15 - Utilizar a tabela do IBGE. Informar 9999999 para as operações com o exterior.
    conhecimento.strModal                                              + '|' +      // 16 - 01-Rodoviário; 02-Aéreo; 03-Aquaviário; 04-Ferroviário; 05-Dutoviário; 06-Multimodal;
    conhecimento.strTipoServico                                        + '|' +      // 17 - 0 - Normal; 1 - Subcontratação; 2 - Redespacho; 3 - Redespacho Intermediário; 4 - Serviço Vinculado a Multimodal; 6 - Transporte de Pessoas (CT-e OS); 7 - Transporte de Valores (CT-e OS); 8 - Excesso de Bagagem (CT-e OS)
    conhecimento.strCodIBGEInicioPrestacao                             + '|' +      // 18 - Utilizar a tabela do IBGE. Informar 9999999 para operações com o exterior.
    conhecimento.strCodIBGEFimPrestacao                                + '|' +      // 19 - Utilizar a tabela do IBGE. Informar 9999999 para operações com o exterior.
    conhecimento.strIndicadorRetira                                    + '|' +      // 20 - Preencher com: 0 - sim; 1 – não
                                                                         '|' +      // 21 - Detalhes da retirada.
                                                                         '|' +      // 22 - Código da Rota
    fFormataValorFit(conhecimento.fltValorPrestacaoServico, 15, 2)     + '|' +      // 23 - Valor Total da Prestação do Serviço
    fFormataValorFit(conhecimento.fltValoraReceber, 15, 2)             + '|' +      // 24 - Valor a Receber
                                                                         '|' +      // 25 - Descontinuado - como procecer????
                                                                         '|' +      // 26 - Chave de Acesso do CT-e. Caso esse campo não seja informado, o sistema gerará automaticamente.
                                                                         '|' +      // 27 - Informar valor 1 quando for globalizado e não informar a tag nas demais situações.
    conhecimento.strModeloDocumentoFiscal                              + '|'        // 28 - 57 - CTE; 67 – CTE-OS (Outros Serviços)
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraCTeTrailler(stlTexto: TStringList);
begin
  stlTexto.Add('TRAILLER|' + IntToStr(stlTexto.Count+1));
end;

procedure TIntegracaoConhecimentoFit.pGeraDestinatario(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-DESTINATARIO|' +                                                           // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                       + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.Destinatario.strCPFCNPJ                               + '|' +      // 03 - Informar o CNPJ ou o CPF, em caso de empresa não estabelecida no Brasil, será informado o CNPJ com zeros. Informar os zeros não significativos.
    conhecimento.Destinatario.strInscricaoEstadual                     + '|' +      // 04 - Informar a IE do tomador ou ISENTO se tomador é contribuinte do ICMS isento de inscrição no cadastro de contribuintes do ICMS. Caso o tomador não seja contribuinte do ICMS não informar o conteúdo.
    conhecimento.Destinatario.strRazaoSocialNome                       + '|' +      // 05 - Razão Social ou Nome
    conhecimento.Destinatario.strTelefone                              + '|' +      // 06 - Telefone
    conhecimento.Destinatario.strSuframa                               + '|' +      // 07 - (Obrigatório nas operações com as áreas com benefícios de incentivos fiscais sob controle da SUFRAMA)
    conhecimento.Destinatario.strLogradouro                            + '|' +      // 08 - Logradouro
    conhecimento.Destinatario.strNumero                                + '|' +      // 09 - Número
    conhecimento.Destinatario.strComplemento                           + '|' +      // 10 - Complemento
    conhecimento.Destinatario.strBairro                                + '|' +      // 11 - Bairro
    conhecimento.Destinatario.strCodIBGE                               + '|' +      // 12 - Utilizar a tabela do IBGE. Informar 9999999 para as operações com o exterior.
    conhecimento.Destinatario.strCEP                                   + '|' +      // 13 - Informar os zeros não significativos
    conhecimento.Destinatario.strCodPais                               + '|' +      // 14 - Utilizar a tabela do BACEN
    conhecimento.Destinatario.strEmail                                 + '|'        // 15 - Endereço do email
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraHeader(stlTexto: TStringList);
begin
  stlTexto.Add('HEADER|3.00')
end;

procedure TIntegracaoConhecimentoFit.pGeraIdentificacaoEmitente(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-EMITENTE|' +                                                               // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                       + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.IdentificacaoEmitente.strCnpj                         + '|' +      // 03 -
    conhecimento.IdentificacaoEmitente.strIES                          + '|' +      // 04 -
    conhecimento.IdentificacaoEmitente.strRazao                        + '|' +      // 05 -
    conhecimento.IdentificacaoEmitente.strFantasia                     + '|' +      // 06 -
    conhecimento.IdentificacaoEmitente.strEndereco                     + '|' +      // 07 -
    conhecimento.IdentificacaoEmitente.strNumeroEnd                    + '|' +      // 08 -
    conhecimento.IdentificacaoEmitente.strComplementoEnd               + '|' +      // 09 -
    conhecimento.IdentificacaoEmitente.strBairro                       + '|' +      // 10 -
    conhecimento.IdentificacaoEmitente.strCodIbge                      + '|' +      // 11 -
    fRetSomenteNumeros(conhecimento.IdentificacaoEmitente.strCep)      + '|' +      // 12 -
    conhecimento.IdentificacaoEmitente.strTelefone                     + '|' +      // 13 -
    conhecimento.IdentificacaoEmitente.strIESST                        + '|'        // 14 -
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesCarga(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-CARGA|' +                                                                             // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                                  + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    fFormataValorFit(conhecimento.InformacoesCarga.fltValorTotal, 15, 2)          + '|' +      // 03 - Dever ser informado para todos os modais de transporte, com exceção do Dutoviário.
    conhecimento.InformacoesCarga.strProdutoPredominante                          + '|' +      // 04 - Informar a Descrição do produto predominante.
    conhecimento.InformacoesCarga.strOutrasCaracteristicas                        + '|' +      // 05 - "FRIA", "GRANEL", "REFRIGERADA", "Medidas: 12X12X12"
    fFormataValorFit(conhecimento.InformacoesCarga.fltValorCargaAverbacao, 15, 2) + '|'        // 06 - Normalmente igual ao valor declarado da mercadoria, diferente por exemplo, quando a mercadoria transportada é isenta de tributos nacionais para exportação, onde é preciso averbar um valor maior, pois no caso de indenização, o valor a ser pago será maior.
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesImpostos(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
var
  strValores: string;
  strCodClass: string;
begin
  strValores := '';
  strCodClass :=  Trim(LeftStr(conhecimento.InformacoesImpostos.strClassificacaoTS, 2));
  if (strCodClass = '1') then
  begin
    strValores := IIF(conhecimento.InformacoesImpostos.fltValorICMS > 0,
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorICMS, 15, 2), '');    // Valor Total Aproximado dos Impostos
    strCodClass := StringOfChar('|', 26) + strCodClass + '|';
  end
  else if (strCodClass = '00') then
    strValores := fFormataValorFit(conhecimento.InformacoesImpostos.fltValorBCIcms, 15, 2)  + '|' +     // Valor da BC do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltAliquotaICMS, 15, 2) + '|' +     // Aliquota do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorICMS, 15, 2)    + '|'       // Valor do ICMS
  else if (strCodClass = '20') then
    strValores := fFormataValorFit(conhecimento.InformacoesImpostos.fltPercentualReducaoBC, 15, 2)  + '|' +     // Percentual da redução da BC
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorBCIcms, 15, 2)          + '|' +     // Valor da BC do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltAliquotaICMS, 15, 2)         + '|' +     // Aliquota do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorICMS, 15, 2)            + '|'       // Valor do ICMS
  else if (strCodClass = '60') then
    strValores := fFormataValorFit(conhecimento.InformacoesImpostos.fltValorBCIcms, 15, 2)       + '|' +     // Valor da BC do ICMS ST retido
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorICMS, 15, 2)         + '|' +     // Valor do ICMS ST retido
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltAliquotaICMS, 15, 2)      + '|' +     // Aliquota do ICMS
                  IIF(conhecimento.InformacoesImpostos.fltValorCredito > 0,
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorCredito, 15, 2), '') + '|'       // Valor do Crédito Outorgado/presumido
  else if (conhecimento.InformacoesImpostos.strClassificacaoTS = '90 - ICMS outros') then
    strValores := IIF(conhecimento.InformacoesImpostos.fltPercentualReducaoBC > 0,
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltPercentualReducaoBC, 15, 2), '')  + '|' +     // Percentual da redução da BC
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorBCIcms, 15, 2)               + '|' +     // Valor da BC do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltAliquotaICMS, 15, 2)              + '|' +     // Aliquota do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorICMS, 15, 2)                 + '|' +     // Valor do ICMS
                  IIF(conhecimento.InformacoesImpostos.fltValorCredito > 0,
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorCredito, 15, 2), '')         + '|'       // Valor do Crédito Outorgado/presumido
  else if (strCodClass = '90') then
    strValores := IIF(conhecimento.InformacoesImpostos.fltPercentualReducaoBC > 0,
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltPercentualReducaoBC, 15, 2), '')  + '|' +     // Percentual da redução da BC
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorBCIcms, 15, 2)               + '|' +     // Valor da BC do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltAliquotaICMS, 15, 2)              + '|' +     // Aliquota do ICMS
                  fFormataValorFit(conhecimento.InformacoesImpostos.fltValorICMS, 15, 2)                 + '|';      // Valor do ICMS devido outra UF

  stlTexto.Add(
    'CTE-IMPOSTOS|' +                                                               // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                       + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.InformacoesImpostos.strTipoCTE                        + '|' +      // 03 - 0 – CTE 1 – CTE Complementado
    strCodClass                                                        + '|' +      // Classificação Tributária do Serviço
    strValores                                                         + '|'
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesNFe(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
var
  intIndex: Integer;
begin
  for intIndex := 0 to conhecimento.intQtdInformacoesNFe - 1 do
  begin
    stlTexto.Add(
      'CTE-NFE|' +                                                                                            // 01 - Tipo de Registro
      conhecimento.strIdReferencia                                                                 + '|' +    // 02 - Chave/Numero de Referencia no seu sistema
      conhecimento.CTeInformacoesNFe[intIndex].strChaveAcessoNFe                                   + '|' +    // 03 -
      conhecimento.CTeInformacoesNFe[intIndex].strPinSuframa                                       + '|' +    // 04 - PIN atribuído pela SUFRAMA para a operação.
      IIF(conhecimento.CTeInformacoesNFe[intIndex].dtaDataPrevisaoEntrega=0, '',
      FormatDateTime('ddmmyyyy', conhecimento.CTeInformacoesNFe[intIndex].dtaDataPrevisaoEntrega)) + '|'      // 05 - Data prevista de entrega
    )
  end;
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesPartilha(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  if not Assigned(conhecimento.Partilha) then
    Exit;

  stlTexto.Add(
    'CTE-ICMS-UF-FIM|' +                                                                         // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                                    + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    fFormataValorFit(conhecimento.Partilha.fltValorBaseCalculoIcmsUfDestino, 15, 2) + '|' +      // 03 - Valor da Base de cálculo do ICMS na UF de término da prestação do serviço de transporte
    fFormataValorFit(conhecimento.Partilha.fltAliquotaIcmsInternaUfDestino, 15, 2)  + '|' +      // 04 - Alíquota interna na UF de término da prestação do serviço de transporte
    fFormataValorFit(conhecimento.Partilha.fltAliquotaIcmsInterestadual, 15, 2)     + '|' +      // 05 - Alíquota Interestadual das UF envolvidas
                                                                                      '|' +      // 06 - Descontinuado enviar vazio
    fFormataValorFit(conhecimento.Partilha.fltValorIcmsPartilhaTermino, 15, 2)      + '|' +      // 07 - Valor do ICMS de partilha para UF de término da prestação do serviço de transporte
    fFormataValorFit(conhecimento.Partilha.fltValorIcmsPartilhaInicio, 15, 2)       + '|' +      // 08 - Valor do ICMS de partilha pra UF de Inicio da prestação do serviço de transporte
    fFormataValorFit(conhecimento.Partilha.fltAliquotaFcp, 15, 2)                   + '|' +      // 09 - Percentual de ICMS relativo ao Fundo de Combate à Pobreza (FCP) na UF de término da prestação
    fFormataValorFit(conhecimento.Partilha.fltValorFcpDestino, 15, 2)               + '|'        // 10 - Valor do ICMS relativo ao Fundo de Combate à Pobreza (FCP) da UF de término da prestação
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesQtdeCarga(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
var
  intIndex: Integer;
begin
  for intIndex := 0 to conhecimento.intQtdCTeInformacoesQtdeCarga -1 do
  begin
    stlTexto.Add(
      'CTE-CARGA-QTDE|' +                                                                                // 01 - Tipo de Registro
      conhecimento.strIdReferencia                                                          + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
      IntToStr(intIndex)                                                                    + '|' +      // 03 -
      conhecimento.CTeInformacoesQtdeCarga[intIndex].strCodUnidadeMedida                    + '|' +      // 04 - 00-M3; 01-KG; 02-TON; 03-UNIDADE; 04-LITROS; 05-MMBTU
      conhecimento.CTeInformacoesQtdeCarga[intIndex].strTipoMedida                          + '|' +      // 05 - Exemplos: PESO BRUTO, PESO DECLARADO, PESO CUBADO, PESO AFORADO, PESO AFERIDO, PESO BASE DE 7CÁLCULO, LITRAGEM, CAIXAS e etc.
      fFormataValorFit(conhecimento.CTeInformacoesQtdeCarga[intIndex].fltQuantidade, 15, 4) + '|'        // 06 -
    )
  end;
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesRodoviario(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-RODOVIARIO|' +                                                                        // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                                  + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.InformacoesRodoviario.strRegistroNacionalANTT                    + '|' +      // 03 - Registro Nacional de Transportadores Rodoviários de Carga
    '|||'                                                                                      //    - Campos inutilizados de 04 a 06
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraInformacoesServicoPrestado(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-SERVICO-OS|' +                                                                         // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                                   + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.InformacoesServicoPrestado.strDescricaoServico                    + '|' +      // 03 -
    fFormataValorFit(conhecimento.InformacoesServicoPrestado.fltQtdeCargas, 15, 4) + '|'        // 04 -
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraDadosAdicionais(stlTexto: TStringList;
  conhecimento: TConhecimentoEletronico);
begin
  if conhecimento.fltPercAproximadosTributos <> 0.00 then
    stlTexto.Add(
      'CTE-DADOS-ADIC|' +                                                                                                // 01 - Tipo de Registr
      conhecimento.strIdReferencia                                                                              + '|' +  // 02 - Chave/Numero de Referencia no seu sistema
      '1'                                                                                                       + '|' +  // 03 - Número da Linha ( Sequencial )
      'VALOR APROXIMADO DOS TRIBUTOS ' + FormatFloat('#,##0.00', conhecimento.fltPercAproximadosTributos) + '%' + '|'    // 06 - Informações Adicionais
    )
end;

procedure TIntegracaoConhecimentoFit.pGeraRemetente(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-REMETENTE|' +                                                                // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                       + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.Remetente.strCPFCNPJ                                  + '|' +      // 03 - Informar o CNPJ ou o CPF, em caso de empresa não estabelecida no Brasil, será informado o CNPJ com zeros. Informar os zeros não significativos.
    conhecimento.Remetente.strInscricaoEstadual                        + '|' +      // 04 - Informar a IE do tomador ou ISENTO se tomador é contribuinte do ICMS isento de inscrição no cadastro de contribuintes do ICMS. Caso o tomador não seja contribuinte do ICMS não informar o conteúdo.
    conhecimento.Remetente.strRazaoSocialNome                          + '|' +      // 05 - Razão Social ou Nome
    conhecimento.Remetente.strNomeFantasia                             + '|' +      // 06 - Nome Fantasia
    conhecimento.Remetente.strTelefone                                 + '|' +      // 07 - Telefone
    conhecimento.Remetente.strLogradouro                               + '|' +      // 08 - Logradouro
    conhecimento.Remetente.strNumero                                   + '|' +      // 09 - Número
    conhecimento.Remetente.strComplemento                              + '|' +      // 10 - Complemento
    conhecimento.Remetente.strBairro                                   + '|' +      // 11 - Bairro
    conhecimento.Remetente.strCodIBGE                                  + '|' +      // 12 - Utilizar a tabela do IBGE. Informar 9999999 para as operações com o exterior.
    conhecimento.Remetente.strCEP                                      + '|' +      // 13 - Informar os zeros não significativos
    conhecimento.Remetente.strCodPais                                  + '|' +      // 14 - Utilizar a tabela do BACEN
    conhecimento.Remetente.strEmail                                    + '|'        // 15 - Endereço do email
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraTomador(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-TOMADOR|' +                                                                // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                       + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.Tomador.strTomadorServico                             + '|' +      // 03 - 0-Remetente; 1-Expedidor; 2-Recebedor; 3-Destinatário; Serão utilizadas as informações contidas no respectivo grupo, conforme indicado pelo conteúdo deste campo.; 4 - Outros; Obs: Informar os dados cadastrais do tomador do serviço; Obs: Para CT-e OS enviar sempre 3
    conhecimento.Tomador.strCPFCNPJ                                    + '|' +      // 04 - Informar o CNPJ ou o CPF, em caso de empresa não estabelecida no Brasil, será informado o CNPJ com zeros. Informar os zeros não significativos.
    conhecimento.Tomador.strInscricaoEstadual                          + '|' +      // 05 - Informar a IE do tomador ou ISENTO se tomador é contribuinte do ICMS isento de inscrição no cadastro de contribuintes do ICMS. Caso o tomador não seja contribuinte do ICMS não informar o conteúdo.
    conhecimento.Tomador.strRazaoSocialNome                            + '|' +      // 06 - Razão Social ou Nome
    conhecimento.Tomador.strNomeFantasia                               + '|' +      // 07 - Nome Fantasia
    conhecimento.Tomador.strTelefone                                   + '|' +      // 08 - Telefone
    conhecimento.Tomador.strLogradouro                                 + '|' +      // 09 - Logradouro
    conhecimento.Tomador.strNumero                                     + '|' +      // 10 - Número
    conhecimento.Tomador.strComplemento                                + '|' +      // 11 - Complemento
    conhecimento.Tomador.strBairro                                     + '|' +      // 12 - Bairro
    conhecimento.Tomador.strCodIBGE                                    + '|' +      // 13 - Utilizar a tabela do IBGE. Informar 9999999 para as operações com o exterior.
    conhecimento.Tomador.strCEP                                        + '|' +      // 14 - Informar os zeros não significativos
    conhecimento.Tomador.strCodPais                                    + '|' +      // 15 - Utilizar a tabela do BACEN
    conhecimento.Tomador.strEmail                                      + '|' +      // 16 - Endereço do email
    conhecimento.Tomador.strIndicador                                  + '|'        // 17 - Aplica-se ao tomador que for indicado no toma3 ou toma4; 1 – Contribuinte ICMS; 2 – Contribuinte isento de inscrição; 9 – Não Contribuinte
  )
end;

procedure TIntegracaoConhecimentoFit.pGeraValoresPrestacaoServico(stlTexto: TStringList; conhecimento: TConhecimentoEletronico);
begin
  stlTexto.Add(
    'CTE-SERV-COMP|' +                                                                  // 01 - Tipo de Registro
    conhecimento.strIdReferencia                                           + '|' +      // 02 - Chave/Numero de Referencia no seu sistema
    conhecimento.ValoresPrestacaoServico.strTipoCTE                        + '|' +      // 03 - 0 – CTE 1 – CTE Complementado
    conhecimento.ValoresPrestacaoServico.strNroItem                        + '|' +      // 04 -
    conhecimento.ValoresPrestacaoServico.strNomeComponente                 + '|' +      // 05 - Exemplos: FRETE PESO, FRETE VALOR, SEC/CAT, ADEME, AGENDAMENTO, etc.
    fFormataValorFit(conhecimento.ValoresPrestacaoServico.fltValor, 15, 2) + '|'        // 06 -
  )
end;

procedure TIntegracaoConhecimentoFit.pImprimirConhecimento(conhecimento: TConhecimentoEletronico; strImpressora: String; strForcarImpressaoPDF: String = 'N');
var
  metodoImpressao: IMetodoImpressao;
begin
  metodoImpressao := TMetodoImpressaoFactory.fCriarConhecimento(strForcarImpressaoPDF);

  fitWrapper.fDownloadDanfe('', conhecimento.strNumeroConhecimento,
    strImpressora, metodoImpressao, 1, IntToStr(StrToInt64(conhecimento.strIdReferencia)), nil, nil, False, 0, '',
    conhecimento.tipoImpressao, conhecimento.strCodEmp);
end;

procedure TIntegracaoConhecimentoFit.pIntegracaoPainelCitelCTe(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  If not Assigned(Self.fonteDados) Then
    Exit;

  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, 'CTE');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, 'CTE_XML');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, 'CTE_PDF');
end;

procedure TIntegracaoConhecimentoFit.pIntegracaoPainelCitelCTeCancelamento(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc: String);
begin
  If not Assigned(Self.fonteDados) Then
    Exit;

  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, 'CTE_CANCELAMENTO');
  Self.fonteDados.pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, 'CTE_CANCELAMENTO_XML');
end;

end.
