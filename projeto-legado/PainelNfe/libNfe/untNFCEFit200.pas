unit untNFCEFit200;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
  Forms,
  Dialogs,
{$ENDIF}
  SysUtils, Classes, NfeApiWSBean, untInterfaces, StrUtils, untConstantesNFe, Types;

Type
  TNFCEFit200 = class(TInterfacedObject, INFE)
    private
      fitWrapper: TWSNFeFitWrapper;
      lstArquivo: TStringList;
      lstItens: TList;

      dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais;
      fonteDados: IFonteDados;

      ultimoRetornoFit: TWSNfeFitRetorno;

      stlEmails: TStringList;

      fltTotFcp: Double;

      function fValor(fltValor: Double; intDecimais: Integer): String;

      function fGetArquivo: TStringList;
      procedure pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
        var intTipoEmissao: Integer; var strChaveAcesso: String;
        var intStatus: Integer; var strMensagem, strProtocolo: String;
        var dtaDataAut: TDateTime; Var strQRCode: String;
        var intStatusSefaz: Integer; Var dtaEmissao: TDateTime);
        
      function fStatusAguardando(intStatus: Integer): Boolean;
      function fStatusDenegada(intStatus: Integer): Boolean;
      function fNotaContingencia(intStatus, intTipoEmissao: Integer): Boolean;
      function fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno; arrStatusSucesso: Array Of Integer;
        intTipoEmissao: Integer; strChaveAcesso: String; intStatus: Integer;
        strMensagem, strProtocolo: String; dtaDataAut: TDateTime; blnIgnoraContingencia: Boolean): TRetornoNFE;

      function fDefineImpressora(dadosGeraisArg: TDadosGerais): String;

      procedure pPrepararEmails;

      procedure pHeader;
      procedure pNFCE;
      procedure pNFCE_Produto;
      procedure pNFCE_Produto_ICMS;
      procedure pNFCE_Produto_Simples;
      procedure pNFCE_Produto_PIS;
      procedure pNFCE_Produto_COFINS;
      procedure pNFCE_Produto_Combustiveis;
      procedure pNFCE_Modalidades;
      procedure pNFCE_Totais;
      procedure pNFCE_Dados_Adic;
      procedure pNFCE_Transporte;
      procedure pNFCE_EmailCliente;
      procedure pTrailler;

      function fIcmsNormal(dadosItem: TDadosItem): String;
      function fIcmsSt(dadosItem: TDadosItem): String;
      function fIcmsDesonerado(dadosItem: TDadosItem): String;
      function fIcmsDiferido(dadosItem: TDadosItem): String;
      function fIcmsRetido(dadosItem: TDadosItem): String;
      function fIcmsPerRed(dadosItem: TDadosItem): String;

      function fRetCSTSimples(dadosItem: TDadosItem): String;
      function fIcmsSimplesNormal(dadosItem: TDadosItem; strCstSimples: String): String;
      function fIcmsSimplesST(dadosItem: TDadosItem; strCstSimples: String): String;
      function fIcmsSimplesCredito(dadosItem: TDadosItem; strCstSimples: String): String;
      procedure pExtraiDadosRetornoIdFormatoNFE(resultadoFit: TWSNfeFitRetorno;
        var intTipoEmissao: Integer; var strChaveAcesso: String;
        var intStatus: Integer; var strMensagem, strProtocolo: String;
        var dtaDataAut: TDateTime);
      function fCriaObjetoLogPerformance(intCodigo: Integer;
        strMensagem: String): TLogPerformance;
      function fSomaAlqFCP(dadosItem: TDadosItem): Double;
      function fSomaValFCP(dadosItem: TDadosItem): Double;
      function fSomaFcpAoIcms(dadosItem: TDadosItem): Boolean;
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

      constructor Create(fonteDados: IFonteDados; blnOffLine: Boolean=False);
      destructor Destroy; override;
      function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
      function fEnviaNFCeXmlOffLine: Boolean;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

      function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean): string;
      function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;

      function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

      procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

      function fConsultaStatusDFe(strChaveAcesso: string): String;
      function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
  End;

implementation

uses untUtil, untUtilFIT, untLogDanfe, untDicSis;

{ TNFCEFit200 }

constructor TNFCEFit200.Create(fonteDados: IFonteDados; blnOffLine: Boolean=False);
begin
  Self.fCriaObjetoLogPerformance(0, ''); //Manter apenas apenas para forçar a compilação da função em desuso;

  fitWrapper := TWSNFeFitWrapper.Create;
  fitWrapper.modeEnvSoap := fGetModeEnvSoap(fonteDados);
  fitWrapper.strUrlAlternativa := objConfigInterna.strUrlNFCe;
  fitWrapper.blnOffLine := blnOffLine;
  lstArquivo := TStringList.Create;
  Self.fonteDados := fonteDados;
  stlEmails := TStringList.Create;
  fltTotFcp := 0;
end;

destructor TNFCEFit200.Destroy;
begin
  ultimoRetornoFit := Nil;
  FreeAndNil(fitWrapper);
  FreeAndNil(lstArquivo);
  FreeAndNil(stlEmails);

  If Assigned(lstItens) Then
  Begin
    FreeAndNil(lstItens);
  End;
  inherited;
end;

function TNFCEFit200.fRetXmlNfe(strChaveAcesso: string): string;
begin
  result := fitWrapper.fRetXMLNfe(strChaveAcesso);
end;

function TNFCEFit200.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;
begin
  result := fitWrapper.fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso);
end;


function TNFCEFit200.fCancelarNota(strNumDoc, strSerie,
  strMotivo: String): Boolean;
  Var
    strTexto: String;
    stlArquivo: TStringList;
begin
  strTexto := 'NFE-CANC|' +
               fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(strNumDoc), strSerie, 'IF') + '|' +
               fonteDados.fChaveAcesso + '|' +
               strMotivo + '|' +
               '|';

  stlArquivo := TStringList.Create;
  stlArquivo.Add(strTexto);
  stlArquivo.SaveToFile(ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_CANCELAMENTO.TXT');
  FreeAndNil(stlArquivo);

  ultimoRetornoFit := fitWrapper.fEnviaTextoIntegracaoNFCE_CANC(strTexto, '', 'FIT_NFE_ENVIA_TEXTO_EVENTO_FIT_NFE');

  Try
    stlArquivo := TStringList.Create;
    stlArquivo.Add(ultimoRetornoFit.Texto);
    stlArquivo.SaveToFile(ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_RETORNO_CANCELAMENTO.TXT');
    FreeAndNil(stlArquivo);
  Except
  End;

  Result := ultimoRetornoFit.RetornoOk;

end;

function TNFCEFit200.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string;
  AExtensao: Boolean): string;
begin
  Result := '';
end;

function TNFCEFit200.fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
begin
  Result := untUtilFIT.fConsultaCadastro(fitWrapper, strUf, strCnpj, strIe);
end;

function TNFCEFit200.fEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  Result := Nil;
end;

function TNFCEFit200.fEnviaNFCeXmlOffLine: Boolean;
  Var
    strTexto: String;
    stlArquivo: TStringList;
    strNotaFiscal: String;
    strCodEmpFit: String;
    strXmlOffLine: String;
begin
  strCodEmpFit  := '1';
  strNotaFiscal := fonteDados.fDadosGerais.strNumDoc;
  strXmlOffLine := fEncodeBase64(String( fonteDados.fDadosGerais.strXmlOffLine ));

  If Not fEmptyStr(strXmlOffLine) Then
  Begin
    strTexto := strNotaFiscal+'|'+strCodEmpFit+'|'+strXmlOffLine+'|';

    stlArquivo := TStringList.Create;
    stlArquivo.Add(strTexto);
    stlArquivo.SaveToFile(ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_ENVIO_NFCE_XML_OFFLINE.TXT');
    FreeAndNil(stlArquivo);

    ultimoRetornoFit := fitWrapper.fEnviaTextoIntegracaoNFCE_XML_OFFLINE(strTexto);

    Try
      stlArquivo := TStringList.Create;
      stlArquivo.Add(ultimoRetornoFit.Texto);
      stlArquivo.SaveToFile(ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_RETORNO_NFCE_XML_OFFLINE.TXT');
      FreeAndNil(stlArquivo);
    Except
    End;

    fonteDados.fDadosGerais.strMsgOffLine := fGetValorLinha(ultimoRetornoFit.Texto, '|', 3);
    Result := ultimoRetornoFit.RetornoOk;
  End
  Else
    Result := False;
end;

function TNFCEFit200.fCriaObjetoLogPerformance(intCodigo: Integer;
  strMensagem: String): TLogPerformance;
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

function TNFCEFit200.fValor(fltValor: Double; intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffNumber, 15, intDecimais);
  Result := AnsiReplaceStr(Result, ',', '');
  Result := AnsiReplaceStr(Result, '.', '');
end;

function TNFCEFit200.fDefineImpressora(dadosGeraisArg: TDadosGerais): String;
begin
  If (Not Assigned(dadosGeraisArg)) Or (fEmptyStr(dadosGeraisArg.strPontoImpressao)) Then
    Result := fIdentificarNomeDaImpressora(fonteDados, objConfig.strFitImpressoraPadrao)
  Else
    Result := fIdentificarNomeDaImpressora(fonteDados, dadosGeraisArg.strPontoImpressao);
end;

function TNFCEFit200.fEnviarNota: Boolean;
  Var
    resultValidacao: TResultadoValidacao;
    strMsg: String;
    stlRet: TStringList;
    strNFCeTextoRetorno: String;
  Const
    TEMPO_ESPERA_NFCE = 3 * 1000; // 10 SEGUNDOS;
begin
  ultimoRetornoFit := Nil;
  fGetArquivo.Clear;
  pPrepararEmails;

  pHeader;
  pNFCE;
  pNFCE_Produto;
  
  If objConfig.blnSimPau Then
    pNFCE_Produto_Simples
  Else
    pNFCE_Produto_ICMS;
    
  pNFCE_Produto_PIS;
  pNFCE_Produto_COFINS;
  pNFCE_Produto_Combustiveis;
  pNFCE_Modalidades;
  pNFCE_Totais;
  pNFCE_Dados_Adic;
  pNFCE_Transporte;
  pNFCE_EmailCliente;
  pTrailler;

  If not fitWrapper.blnOffLine Then
  Begin
    Try
      fGetArquivo.SaveToFile(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'ULTIMA_NFCE.TXT');
    Except

    End;

    ultimoRetornoFit := fitWrapper.fEnviaTextoIntegracaoNFCE(fGetArquivo.Text);
    Result := ultimoRetornoFit.RetornoOk;

    stlRet := TStringList.Create;
    stlRet.Add(ultimoRetornoFit.Texto);
    Try
      stlRet.SaveToFile(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_RETORNO_WS_NFCE.TXT');
    Except

    End;
    FreeAndNil(stlRet);

    If Not Result Then
    Begin
      strMsg := 'Erro: ' + fGetValorLinha(ultimoRetornoFit.Texto, '|', 10, True) + #13#10 +
          fGetValorLinha(ultimoRetornoFit.Texto, '|', 11, True);
      resultValidacao := TResultadoValidacao.Create;
      resultValidacao.pAdicionarErro(strMsg, Nil);
      pLogImp(strMsg);
      Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
    End;

    Sleep(TEMPO_ESPERA_NFCE);
  End
  Else
  Begin
    Try
      fGetArquivo.SaveToFile(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'assinador' + PATH_SEPARATOR + dadosGerais.strCodEmp + PATH_SEPARATOR + 'ULTIMA_NFCE.TXT');
    Except

    End;

    Result := fNFCeOffLineAssinador(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'assinador' + PATH_SEPARATOR + dadosGerais.strCodEmp,
                                    PATH_SEPARATOR + 'ULTIMA_NFCE.TXT',
                                    dadosEmitente.strFitOffLineLicenca,
                                    dadosEmitente.strFitOffLineCertJKS,
                                    dadosEmitente.strFitOffLineCertSenha,
                                    dadosEmitente.strFitOffLineIdToken,
                                    dadosEmitente.strFitOffLineNroToken,
                                    dadosEmitente.strFitAmbiente,
                                    IIF(not fEmptyStr(fCfgSisFonte(fonteDados,'TMZONE')),fCfgSisFonte(fonteDados,'TMZONE'),'-3' ),
                                    strNFCeTextoRetorno,
                                    dadosGerais.strXmlOffLine,
                                    dadosGerais.strChaveAcessoOffLine);

    ultimoRetornoFit := TWSNfeFitRetorno.Create(result,strNFCeTextoRetorno);
  End;
end;

function TNFCEFit200.fGeraRetornoNFe(resultadoFit: TWSNfeFitRetorno;
  arrStatusSucesso: array of Integer; intTipoEmissao: Integer;
  strChaveAcesso: String; intStatus: Integer; strMensagem, strProtocolo: String;
  dtaDataAut: TDateTime; blnIgnoraContingencia: Boolean): TRetornoNFE;
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
    If (fNotaContingencia(intStatus, intTipoEmissao)) And (Not blnIgnoraContingencia) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
        strProtocolo, dtaDataAut);
      Result.SetContingencia(True);
    End
    Else If fStatusArrSucesso Then
    Begin
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
        strProtocolo, dtaDataAut);
    End
    Else If fStatusDenegada(intStatus) Then
    Begin
      Result := TRetornoNFE.fCriaRetornoDenegada(strMensagem, strChaveAcesso);
    End
    Else If fStatusAguardando(intStatus) Then
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

function TNFCEFit200.fGetArquivo: TStringList;
begin
  lstArquivo.Text := fTiraCaracEspeciais(lstArquivo.Text, False);
  Result := lstArquivo;
end;

function TNFCEFit200.fIcmsDesonerado(dadosItem: TDadosItem): String;
begin
  Result := '|||';
end;

function TNFCEFit200.fIcmsDiferido(dadosItem: TDadosItem): String;
begin
  If Pos(RightStr(dadosItem.strCodSit, 2), '51') > 0 Then
  Begin
    Result := '';
    Result := Result + fValor(dadosItem.fltValIcm, 2) + '|' + // 19 - Valor do ICMS da Operação
                       fValor(100, 2) + '|' +                 // 20 - Percentual do diferimento
                       fValor(dadosItem.fltValIcm, 2) + '|';  // 21 - Valor do ICMS diferido
  End
  Else
  Begin
    Result := '|||';
  End;
end;

function TNFCEFit200.fIcmsNormal(dadosItem: TDadosItem): String;
begin
  If Pos(RightStr(dadosItem.strCodSit, 2), '00,10,20,51,70,90') > 0 Then
  Begin
    Result := '';
    Result := Result + '3|' +                                 // 06 - Modalidade de determinação BC ICMS - (3 - Valor da operação)
                       fValor(dadosItem.fltBasIcm, 2) + '|' + // 07 - Valor da Base Calculo do ICMS
                       fValor(dadosItem.fltAlqIcm + fSomaAlqFCP(dadosItem), 4) + '|' + // 08 - Alíquota do ICMS + Percentual de FCP (caso seja RJ->RJ)
                       fValor(dadosItem.fltValIcm + fSomaValFCP(dadosItem), 2) + '|';  // 09 - Valor do ICMS    + Valor do FCP (caso seja RJ->RJ)
  End
  Else
  Begin
    Result := '||||';
  End;
end;

{********************************************************************}
{* Faz parte do ICMS Normal, porém FIT adicionou o campo por último *}
{*****************************************************************NC*}
function TNFCEFit200.fIcmsPerRed(dadosItem: TDadosItem): String;
begin
  If Pos(RightStr(dadosItem.strCodSit, 2), '00,10,20,51,70,90') > 0 Then
    Result := fValor(dadosItem.fltPerRed, 4) + '|'            // 24 - Percentual da Redução de BC
  Else
    Result := '|';
end;

function TNFCEFit200.fIcmsRetido(dadosItem: TDadosItem): String;
begin
  If Pos(RightStr(dadosItem.strCodSit, 2), '60') > 0 Then
  Begin
    Result := '';
    Result := Result + fValor(dadosItem.fltBasRet, 2) + '|' + // 22 - Valor da Base Calculo do ICMS ST – Retido
                       fValor(dadosItem.fltValRet, 2) + '|';  // 23 - Valor do ICMS ST – Retido
  End
  Else
  Begin
    Result := '||';
  End;
end;

function TNFCEFit200.fIcmsSimplesCredito(dadosItem: TDadosItem; strCstSimples: String): String;
begin
  If Pos(RightStr(strCstSimples, 2), '101,201,900') > 0 Then
  Begin
    Result := '';
    Result := Result + fValor(dadosItem.fltAlqIcm, 4) + '|' + // 17 - Alíquota aplicável de cálculo do crédito (SIMPLES NACIONAL).
                       fValor(dadosItem.fltValIcm, 2) + '|';  // 18 -Valor crédito do ICMS que pode ser aproveitado nos termos do art. 23 da LC 123 (SIMPLES NACIONAL)
  End
  Else
  Begin
    Result := '|';
  End;
end;

function TNFCEFit200.fIcmsSimplesNormal(dadosItem: TDadosItem; strCstSimples: String): String;
begin
  If Pos(RightStr(strCstSimples, 2), '900') > 0 Then
  Begin
    Result := '';
    Result := Result + '3|' +                                  // 06 - Modalidade de determinação da BC do ICMS
                       fValor(dadosItem.fltBasIcm, 2) + '|' +  // 07 - Valor da BC do ICMS
                       fValor(dadosItem.fltPerRed, 4) + '|' +  // 08 - Percentual da Redução de BC
                       fValor(dadosItem.fltAlqIcm, 4) + '|' +  // 09 - Alíquota do imposto
                       fValor(dadosItem.fltValIcm, 2) + '|';   // 10 - Valor do ICMS
  End
  Else
  Begin
    Result := '|||||';
  End;
end;

function TNFCEFit200.fIcmsSimplesST(dadosItem: TDadosItem; strCstSimples: String): String;
begin
  If Pos(RightStr(strCstSimples, 2), '201,202,203,900') > 0 Then
  Begin
    Result := '';
    Result := Result + '4|' +                                 // 11 - Modalidade de determinação da BC do ICMS ST
                       fValor(dadosItem.fltValIva, 4) + '|' + // 12 - Percentual da margem de valor Adicionado do ICMS ST
                       fValor(dadosItem.fltPRedST, 4) + '|' + // 13 - Percentual da Redução de BC do ICMS ST
                       fValor(dadosItem.fltBasRet, 2) + '|' + // 14 - Valor da BC do ICMS ST
                       fValor(dadosItem.fltAlqRet, 4) + '|' + // 15 - Alíquota do imposto do ICMS ST
                       fValor(dadosItem.fltValRet, 2) + '|';  // 16 - Valor do ICMS ST
  End
  Else
  Begin
    Result := '||||||';
  End;
end;

function TNFCEFit200.fIcmsSt(dadosItem: TDadosItem): String;
begin
  If Pos(RightStr(dadosItem.strCodSit, 2), '10,30,70,90') > 0 Then
  Begin
    Result := '';
    Result := Result + '4|' +                                 // 10 - Modalidade de determinação BC ICMS ST
                       fValor(dadosItem.fltValIva, 4) + '|' + // 11 - Modalidade de determinação BC ICMS ST
                       fValor(dadosItem.fltPRedST, 4) + '|' + // 12 - Percentual de Redução de BC ICMS ST
                       fValor(dadosItem.fltBasRet, 2) + '|' + // 13 - Valor da Base Calculo do ICMS ST
                       fValor(dadosItem.fltAlqRet, 4) + '|' + // 14 - Alíquota do ICMS ST
                       fValor(dadositem.fltValRet, 2) + '|';  // 15 - Valor do ICMS ST
  End
  Else
  Begin
    Result := '||||||';
  End;
end;

function TNFCEFit200.fListagemNotas(strCodEmp: String; dtaDtaIni,
  dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
begin
  Raise Exception.Create('Operação não permitida para NFCe.');
end;

function TNFCEFit200.fMensagemErro: String;
begin
  Result := '';
end;

function TNFCEFit200.fNotaContingencia(intStatus, intTipoEmissao: Integer): Boolean;
begin
  Result := ((intStatus = 2100) And (intTipoEmissao In [6,7,9])) Or
            ((intStatus = 100) And (intTipoEmissao In [6,7,9])) Or
            ((intStatus = 5) And (intTipoEmissao In [6,7,9]));
end;

function TNFCEFit200.fProcessarCancelamento: TRetornoNFE;
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
begin
  pExtraiDadosRetornoId(ultimoRetornoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut, strQRCode, intStatusSefaz, dtaEmissao);

  Result := fGeraRetornoNFe(ultimoRetornoFit,
    [RET_CANCELAMENTO_HOMOLOGADO,
     RET_EVENTO_REGISTRADO,
     RET_STATUS_AUTORIZADA_FORA_PRAZO,
     RET_STATUS_AUTORIZADA_FORA_PRAZO_2], intTipoEmissao,
    strChaveAcesso, intStatusSefaz, strMensagem, strProtocolo, dtaDataAut, True);

  Result.SetDataEmissao(dtaEmissao);
end;

function TNFCEFit200.fProcessarEnvio: TRetornoNFE;
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
begin
  If fitWrapper.blnOffLine Then
  Begin
    Result := TRetornoNFE.Create(False, 'NFCe Off-Line', '', '', True);
    Exit;
  End;

  If Not Assigned(ultimoRetornoFit) Then
  Begin
    Result := TRetornoNFE.fCriaRetornoErro('Por favor, reenvie o documento.');
    Exit;
  End;

  stlRet := TStringList.Create;
  stlRet.Add(ultimoRetornoFit.Texto);
  Try
    stlRet.SaveToFile(ExtractFileDir(Application.ExeName) + PATH_SEPARATOR + 'ULTIMO_RETORNO_NFCE.TXT');
  Except

  End;
  FreeAndNil(stlRet);

  pExtraiDadosRetornoId(ultimoRetornoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut, strQRCode, intStatusSefaz, dtaEmissao);

  Result := fGeraRetornoNFe(ultimoRetornoFit, [5],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, False);
  Result.SetQRCode(strQRCode);
  Result.SetDataEmissao(dtaEmissao);

  {****************************************}
  {* IMPRESSAO_NOTA_FISCAL para registrar *}
  {* Tempo total para emissão NFe         *}
  {*************************************NC*}
  If (Result.Sucesso) And (FileExists('nfe.downloadxml')) Then
  Begin
    strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);
    fitWrapper.pDownloadXml(Result.ChaveAcesso, strIdNota, fNumDocEnvio(dadosGerais.strNumDoc), 'XMLNFCE');
  End;
end;

function TNFCEFit200.fProcessarStatusNota: TRetornoNFE;
  Var
    strIdNota: String;

    intStatus: Integer;
    strMensagem: String;
    intTipoEmissao: Integer;
    strChaveAcesso: String;
    strProtocolo: String;
    dtaDataAut: TDateTime;
begin
  Application.ProcessMessages;
  strIdNota := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie,
    dadosGerais.strEspDoc);

  ultimoRetornoFit := fitWrapper.fConsultaSituacaoId(strIdNota);

  Application.ProcessMessages;

  pExtraiDadosRetornoIdFormatoNFE(ultimoRetornoFit, intTipoEmissao, strChaveAcesso,
    intStatus, strMensagem, strProtocolo, dtaDataAut);

  Result := fGeraRetornoNFe(ultimoRetornoFit,
    [5,
    RET_STATUS_AUTORIZADA,
    RET_STATUS_AUTORIZADA_FORA_PRAZO,
    RET_STATUS_AUTORIZADA_FORA_PRAZO_2],
    intTipoEmissao, strChaveAcesso, intStatus, strMensagem, strProtocolo, dtaDataAut, False);
end;

function TNFCEFit200.fRetCSTSimples(dadosItem: TDadosItem): String;
  Var
    strCodSitTmp: String;
    strCstSimSubs: String;
begin
  strCstSimSubs := fGetCSTSimplesSub(dadosGerais,dadosEmitente, dadosItem);

  strCodSitTmp := RightStr(dadosItem.strCodSit, 2);

  Result := '900';

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

  Else If (strCodSitTmp = '00') Or
          ( (strCodSitTmp = '20') And (dadosItem.fltValIcm = 0) ) Then
  Begin
    If (objConfig.strCstSimTrib = '103') Then
    Begin
      Result := '103'
    End
    Else
    Begin
      If (dadosGerais.strEspDoc = 'IF') Or
         (fEmptyStr(objConfig.strCstSimTrib)) Or
         (StrToIntDef(objConfig.strCstSimTrib, 102) = 102) Then
      Begin
        Result := '102'
      End
      Else
        Result := '101';
    End;
  End

  Else If Pos(strCodSitTmp, '30_40_50') > 0 Then
    Result := '103'

  Else If Pos(strCodSitTmp, '10_60_70') > 0 Then
  Begin
    If Not fEmptyStr(strCstSimSubs) Then
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
    Result := '900';

    If (RightStr(dadosItem.strClaFis, 3) = '929') And // Confirmacao de Cupom
       ((objConfig.strCstSimTribCI) = '101')      Then
    Begin
      Result := '101';
    End;

  End;
end;

function TNFCEFit200.fSomaAlqFCP(dadosItem: TDadosItem): Double;
begin
  Result := 0;
  If fSomaFcpAoIcms(dadosItem) Then
    Result := dadosItem.fltPercentualFCP;
end;

function TNFCEFit200.fSomaFcpAoIcms(dadosItem: TDadosItem): Boolean;
begin
  Result := ((dadosGerais.strEstado = 'RJ') And (dadosEmitente.strEstado = 'RJ')) And (dadosItem.fltAlqIcm = 18);
end;

function TNFCEFit200.fSomaValFCP(dadosItem: TDadosItem): Double;
begin
  Result := 0;
  If fSomaFcpAoIcms(dadosItem) Then
  begin
    Result := dadosItem.fltValorFCP;
    fltTotFcp := fltTotFcp + Result;
  end;
end;

function TNFCEFit200.fStatusAguardando(intStatus: Integer): Boolean;
begin
  Result := False;
end;

function TNFCEFit200.fStatusDenegada(intStatus: Integer): Boolean;
begin
  Result := intStatus = 6;
end;

function TNFCEFit200.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := True;
end;

function TNFCEFit200.fVerificarStatusNota: Boolean;
begin
  Result := False;
end;

function TNFCEFit200.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
var
  strRetornoConsulta: string;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

function TNFCEFit200.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := fVerificarStatusServicoFIT(fonteDados, fitWrapper, strCnpjEmitente,
    strIESEmitente, strRetornoConsulta);
end;

procedure TNFCEFit200.pAdicionaItem(dadosItem: TDadosItem);
begin
  If (Not Assigned(lstItens)) Then
    lstItens := TList.Create;

  lstItens.Add(dadosItem);
end;

procedure TNFCEFit200.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  Raise Exception.Create('Operação não permitida para NFCe.');
end;

procedure TNFCEFit200.pExtraiDadosRetornoId(resultadoFit: TWSNfeFitRetorno;
  var intTipoEmissao: Integer; var strChaveAcesso: String;
  var intStatus: Integer; var strMensagem, strProtocolo: String;
  var dtaDataAut: TDateTime; Var strQRCode: String;
  var intStatusSefaz: Integer; Var dtaEmissao: TDateTime);
  Var
    strDataAut: String;
    strEmissao: String;
begin
  intTipoEmissao := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 19, True), 1);
  strChaveAcesso := fGetValorLinha(resultadoFit.Texto, '|', 7, True);
  intStatus := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 8, True), -1);
  intStatusSefaz := StrToIntDef(fGetValorLinha(resultadoFit.Texto, '|', 9, True), -1);
  strMensagem := fGetValorLinha(resultadoFit.Texto, '|', 10, True);
  strProtocolo := fGetValorLinha(resultadoFit.Texto, '|', 12, True);
  strDataAut := fGetValorLinha(resultadoFit.Texto, '|', 13, True);
  strQRCode := fGetValorLinha(resultadoFit.Texto, '|', 14, True);
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
end;

procedure TNFCEFit200.pExtraiDadosRetornoIdFormatoNFE(resultadoFit: TWSNfeFitRetorno;
  Var intTipoEmissao: Integer; Var strChaveAcesso: String;
  Var intStatus: Integer; Var strMensagem: String;
  Var strProtocolo: String; Var dtaDataAut: TDateTime);
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
end;

procedure TNFCEFit200.pHeader;
begin
  fGetArquivo.Add('HEADER|3.10')
end;

procedure TNFCEFit200.pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
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
end;

procedure TNFCEFit200.pNFCE;
  Var
    strLinha: string;
    strId: String;

    strBairro: String;
    strCnpj: String;

    strIndPre: String;
begin
  strBairro := dadosGerais.strBairro;
  If Length(strBairro) <= 1 Then
  Begin
    strBairro := 'N/D';
  End;

  strCnpj := dadosGerais.strCnpj;
  If (Not fValidaCnpjCpf(strCnpj)) Or (fStringRepetida(strCnpj)) Then
  Begin
    strCnpj := '';
  End;

  If dadosGerais.intTipFre <> tfSemFrete Then
    strIndPre := '4'
  Else
    strIndPre := '1';

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);
  strLinha := 'NFCE|' +                                                        // 01 - Tipo de Registro
              strId + '|' +                                                    // 02 - Chave/Numero de Referencia no seu sistema
              dadosEmitente.strCnpj + '|' +                                    // 03 - CNPJ Emitente
              LeftStr(dadosGerais.strDescricaoClaFis, 60) + '|' +              // 04 - Natureza da Operação
              IfThen(dadosGerais.strCondPagamento = '01000', '0', '1') + '|' + // 05 - Forma de Pagamento (0-Vista 1-Prazo)
              dadosGerais.strSerie + '|' +                                     // 06 - Série NFC-e
              fNumDocEnvio(dadosGerais.strNumDoc) + '|' +                      // 07 - Número NFC-e
              '|' +                                                            // 08 - Data e hora de Emissão do Documento Fiscal
              '4|' +                                                           // 09 - Formato de Impressão do DANFE (4 - DANFE NFCe)
              strIndPre + '|' +                                                // 10 - Indicador de presença do comprador no estabelecimento comercial no momento da operação (1-Operação presencial)
              strCnpj + '|' +                                                  // 11 - CNPJ/CPF Destinatário
              '|' +                                                            // 12 - Identificação do destinatário no caso de comprador estrangeiro
              LeftStr(Trim(dadosGerais.strNomCli), 60) + '|' +                 // 13 - Razão Social ou Nome do Destinatário
              LeftStr(dadosGerais.strLogradouro, 60) + '|' +                   // 14 - Logradouro Destinatário
              LeftStr(dadosGerais.strNumeroEnd, 60) + '|' +                    // 15 - Número Logradouro Destinatário
              LeftStr(dadosGerais.strComplementoEnd, 60) + '|' +               // 16 - Complemento Logradouro Destinatário
              LeftStr(strBairro, 60) + '|' +                                   // 17 - Bairro Destinatário
              dadosGerais.strCodIbge + '|' +                                   // 18 - Código IBGE do Município Destinatário
              dadosGerais.strCEP + '|' +                                       // 19 - CEP Destinatário
              '1058|' +                                                        // 20 - Código BACEN Pais Destinatário
              dadosGerais.strTelefone + '|' +                                  // 21 - Telefone Destinatário
              objConfigInterna.strPontoVenda + '|' +                           // 22 - Ponto de Venda
              '1|';                                                            // 23 - Turno

  fGetArquivo.Add(strLinha);
end;

procedure TNFCEFit200.pNFCE_Modalidades;
  Var
    intContador: Integer;
    strLinha: String;
    strId: String;
begin
  If Length(dadosGerais.arrFormasPagamento) > 20 Then
    Exit;

  For intContador := Low(dadosGerais.arrFormasPagamento) To High(dadosGerais.arrFormasPagamento) Do
  Begin
    strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

    strLinha := 'NFCE-FORMA-PAGAMENTO|' +
                strId + '|' + 
                IntToStr(intContador+1) + '|' +
                dadosGerais.arrFormasPagamento[intContador].strCodigo + '|' +
                fFormataValor(dadosGerais.arrFormasPagamento[intContador].fltValor, 13, 2) + '|' +
                arrFormasPagamentoInterna[intContador].strCnpjOperadora + '|' +
                '|' +
                arrFormasPagamentoInterna[intContador].strNumAutorizacao + '|' +
                arrFormasPagamentoInterna[intContador].strTipCar;
    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Produto;
  Var
    strId: String;
    dadosItem: TDadosItem;
    strLinha: String;
    intCont: Integer;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    If not objConfigInterna.blnUniTri Then
       dadosItem.strUnTrib := dadosItem.strUnidad ;

    strLinha  := 'NFCE-PRODUTO|' +                       // 01 - Tipo de Registro
                 strId + '|' +                           // 02 - ID Referencia
                 IntToStr(intCont+1) + '|' +             // 03 - Nr.Item
                 dadosItem.strCodIte + '|' +             // 04 - Código do Produto/Serviço
                 dadosItem.strCodBar + '|' +             // 05 - Código EAN
                 Trim(dadosItem.strDesIte) + '|' +       // 06 - Descrição do Produto
                 Trim(dadosItem.strClaIpi) + '|' +       // 07 - NCM
                 dadosItem.strClaFis + '|' +             // 08 - CFOP
                 dadosItem.strUnidad + '|' +             // 09 - Unidade Comercial
                 fValor(dadosItem.fltQtdIte, 4) + '|' +  // 10 - Quantidade Comercial
                 fValor(dadosItem.fltUnitar, 10) + '|' + // 11 - Valor Unitário Comercial
                 fValor(dadosItem.fltTotIte, 2) + '|' +  // 12 - Valor Total Bruto dos Produtos/Serviços
                 dadosItem.strCodBar + '|' +             // 13 - EAN Tributável
                 dadosItem.strUnTrib + '|' +             // 14 - Unidade Tributável
                 fValor(dadosItem.fltQtdTri, 4) + '|' +  // 15 - Quantidade Tributável
                 fValor(dadosItem.fltUniTri, 10) + '|' + // 16 - Valor Unitário de Tributação
                 fValor(dadosItem.fltTotFre, 2) + '|' +  // 17 - Valor Total do Frete
                 fValor(0,2) + '|' +                     // 18 - Valor Total do Seguro
                 fValor(dadosItem.fltDesEsp, 2) + '|' +  // 19 - Valor Total do Desconto
                 fValor(dadosItem.fltDesAce, 2) + '|' +  // 20 - Valor Outras Despesas Acesssorias
                 fValor(dadosItem.fltImpPag, 2) + '|' +  // 21 - Valor total dos tributos
                 '1|' +                                  // 22 - Indicador Totalizador NFC-e (1-Valor do Item compõe o valor total da NFC-e)
                 dadosItem.strCodigoCEST + '|';          // 23 - CEST ( Código Especificador da Substituição Tributária )

    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Produto_COFINS;
  Var
    strId: String;
    dadosItem: TDadosItem;
    strLinha: String;
    intCont: Integer;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);
    strLinha := 'NFCE-PRODUTO-COFINS|' +                  // 01 - Tipo de Registro
                strId + '|' +                             // 02 - ID Referencia
                IntToStr(intCont+1) + '|' +               // 03 - Nr.Item
                dadosItem.strCstCof + '|' +               // 04 - Código da Situação Tributária
                fValor(dadosItem.fltBasCof, 2) + '|' +    // 05 - Valor da Base de Cálculo
                fValor(dadosItem.fltAlqCof, 4) + '|' +    // 06 - Alíquota (em percentual)
                '|' +                                     // 07 - Quantidade Vendida
                '|' +                                     // 08 - Alíquota (em reais)
                fValor(dadosItem.fltValCof, 2);           // 09 - Valor Total

    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Produto_Combustiveis;
  Var
    item: TDadosItem;
    intCont: Integer;
    strLinha: String;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  For intCont := 0 To lstItens.Count -1 Do
  Begin
    item := TDadosItem(lstItens[intCont]);

    If Pos(item.strClaFis, CFOP_COMBUSTIVEL) > 0 Then
    Begin
      strLinha := '';
      strLinha := strLinha + 'NFE-COMB|';                                                        // 001 - Tipo do Registro
      strLinha := strLinha + fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc),
        dadosGerais.strSerie, dadosGerais.strEspDoc) + '|';                                      // 002 - ID Referência
      strLinha := strLinha + IntToStr(intCont+1) + '|';                                          // 003 - Nr.Item
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

      fGetArquivo.Add(strLinha);
    End;
  End;
end;

procedure TNFCEFit200.pNFCE_Produto_ICMS;
  Var
    strId: String;
    dadosItem: TDadosItem;
    strLinha: String;
    intCont: Integer;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);
    strLinha := 'NFCE-PRODUTO-ICMS|' +                   // 01 - Tipo de Registro
                strId + '|' +                            // 02 - ID Referencia
                IntToStr(intCont+1) + '|' +              // 03 - Nr.Item
                LeftStr(dadosItem.strCodSit, 1) + '|' +  // 04 - Origem da Mercadoria
                RightStr(dadosItem.strCodSit, 2) + '|' + // 05 - CST – Código da Situação Tributária
                fIcmsNormal(dadosItem) +                 // 06 - 09 - ICMS NORMAL (00, 10, 20, 51, 70, 90)
                fIcmsSt(dadosItem) +                     // 10 - 15 - ICMS ST (10, 30, 70, 90)
                fIcmsDesonerado(dadosItem) +             // 16 - 18 - ICMS DESONERADO (20, 30, 40, 41, 50, 70, 90)
                fIcmsDiferido(dadosItem) +               // 19 - 21 - ICMS DIFERIDO (51)
                fIcmsRetido(dadosItem)+                  // 22 - 23 - ICMS ST RETIDO (60)
                fIcmsPerRed(dadosItem);                  // 24 - Percentual Redução Base de Cálculo (ICMS Normal - 00, 10, 20, 51, 70, 90)

    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Produto_PIS;
  Var
    strId: String;
    dadosItem: TDadosItem;
    strLinha: String;
    intCont: Integer;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);
    strLinha := 'NFCE-PRODUTO-PIS|' +                  // 01 - Tipo de Registro
                strId + '|' +                          // 02 - ID Referencia
                IntToStr(intCont+1) + '|' +            // 03 - Nr.Item
                dadosItem.strCstPis + '|' +            // 04 - Código da Situação Tributária
                fValor(dadosItem.fltBasPis, 2) + '|' + // 05 - Valor da Base de Cálculo
                fValor(dadosItem.fltAlqPis, 4) + '|' + // 06 - Alíquota (em percentual)
                '|' +                                  // 07 - Quantidade Vendida
                '|' +                                  // 08 - Alíquota (em reais)
                fValor(dadosItem.fltValPis, 2);        // 09 - Valor Total

    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Produto_Simples;
  Var
    strId: String;
    dadosItem: TDadosItem;
    strLinha: String;
    intCont: Integer;
    strCstSimples: String;
begin
  If (Not Assigned(lstItens)) Then
    Exit;

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    strCstSimples := fRetCSTSimples(dadosItem);
    strLinha := 'NFCE-PRODUTO-SN|' +                           // 01 - Tipo de Registro
                strId + '|' +                                  // 02 - ID Referencia
                IntToStr(intCont+1) + '|' +                    // 03 - Nr.Item
                LeftStr(dadosItem.strCodSit, 1) + '|' +        // 04 - Origem da Mercadoria
                strCstSimples + '|' +                          // 05 - CST – Código da Situação Tributária
                fIcmsSimplesNormal(dadosItem, strCstSimples) + // 06 - 10 - ICMS - Normal
                fIcmsSimplesST(dadosItem, strCstSimples) +     // 11 - 16 - ICMS – Substituição Tributária
                fIcmsSimplesCredito(dadosItem, strCstSimples); // 17 - 18 - Cálculo de Crédito

    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Totais;
  Var
    strLinha: string;
    strId: String;

  function fTotalTributos: Double;
    Var
      intContador: Integer;
  begin
    Result := 0;
    If Assigned(lstItens) Then
    Begin
      For intContador := 0 To lstItens.Count-1 Do
      Begin
        Result := Result + TDadosItem(lstItens[intContador]).fltImpPag;
      End;
    End;
  end;
begin
  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  strLinha := 'NFCE-TOTAL|' +                                    // 01 - Tipo de Registro
              strId + '|' +                                      // 02 - Chave/Numero de Referencia no seu sistema
              fValor(dadosGerais.fltBasIcm, 2) + '|' +           // 03 - Valor Total Base Calculo ICMS
              fValor(dadosGerais.fltTotIcm+fltTotFcp, 2) + '|' + // 04 - Valor Total ICMS
              fValor(0, 2) + '|' +                               // 05 - Valor Total do ICMS Desonerado
              fValor(dadosGerais.fltBasRet, 2) + '|' +           // 06 - Valor Total Base Calculo ICMS ST
              fValor(dadosGerais.fltTotRet, 2) + '|' +           // 07 - Valor Total ICMS ST
              fValor(dadosGerais.fltTotPro, 2) + '|' +           // 08 - Valor Total dos Produtos e Serviços
              fValor(dadosGerais.fltTotFre, 2) + '|' +           // 09 - Valor Total do Frete
              fValor(0,2) + '|' +                                // 10 - Valor Total do Seguro
              fValor(dadosGerais.fltDesEsp, 2) + '|' +           // 11 - Valor Total do Desconto
              fValor(dadosGerais.fltValPis, 2) + '|' +           // 12 - Valor Total do PIS
              fValor(dadosGerais.fltValCof, 2) + '|' +           // 13 - Valor Total do COFINS
              fValor(dadosGerais.fltDesAce, 2) + '|' +           // 14 - Valor Total Outras Despesas Aces.
              fValor(fTotalTributos, 2) + '|' +                  // 15 - Valor Total dos Tributos
              fValor(dadosGerais.fltTotGer, 2);                  // 16 - Valor Total NFC-e

  fGetArquivo.Add(strLinha);
end;

procedure TNFCEFit200.pNFCE_Transporte;
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
        Result := '0'  // Por conta do emitente
      Else If dadosGerais.intTipFre = tfFob Then
        Result := '1'  // Por conta do destinatário/remetente
      Else If dadosGerais.intTipFre = tfTerceiros Then
        Result := '2'  // Por conta de Terceiros
      Else
        Result := '9'; // Sem frete
    End
    Else
      Result := '9';
  end;
begin
  //MODALIDADE SEMPRE IRÁ NA NFCE, DEMAIS CAMPOS SÓ SE O CNPJ DA TRANSPORTADORA FOR VÁLIDO
  strModaliAux := fModalidadeFrete;
  IdNfeFit_Aux := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  If (fValidaCnpjCpf(dadosGerais.strCgcTra)) And (Not fNumerosRepetidos(dadosGerais.strCgcTra)) And (fModalidadeFrete <> '9') Then
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
  strLinha := strLinha + 'NFCE-TRANSP|';      // 01 - Tipo do Registro
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
  strLinha := strLinha + '|';                // 16 - Placa do Veiculo (Não é permitido informar dados do veiculo)
  strLinha := strLinha + '|';                // 17 - UF Placa Veiculo (Não é permitido informar dados do veiculo)
  strLinha := strLinha + '|';                // 18 - RNTC do Veiculo  (Não é permitido informar dados do veiculo)

  fGetArquivo.Add(strLinha);
end;

procedure TNFCEFit200.pPrepararEmails;
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

procedure TNFCEFit200.pNFCE_EmailCliente;
  Var
    strLinha: String;
    intContador: Integer;
    strId: String;
begin
  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intContador := 0 To stlEmails.Count -1 Do
  Begin
    strLinha := '';
    strLinha := strLinha + 'NFCE-EMAIL|';                                          // 001 - Tipo do Registro
    strLinha := strLinha + strId  + '|';                                          // 002 - ID Referência
    strLinha := strLinha + LeftStr(Trim(stlEmails[intContador]), 255) + '|';      // 003 - Email Cliente
    strLinha := strLinha + 'S|';                                                                                 // 004 - Enviar XML
    strLinha := strLinha + 'S|';                                                                                 // 005 - Enviar PDF Danfe

    fGetArquivo.Add(strLinha);
  End;
end;

procedure TNFCEFit200.pNFCE_Dados_Adic;
  Var
    strId        : String;
    strLinha     : string;
    strCnpj      : String;
    intLinha     : Integer;
    stlMensagens : TStringList;
    fltPerImpPag: Double;
    intQtdNps : Integer;
begin
  strCnpj := dadosGerais.strCnpj;
  
  If (Not fValidaCnpjCpf(strCnpj)) Or (fStringRepetida(strCnpj)) Then
  Begin
    strCnpj := '';
  End;

  stlMensagens := TStringList.Create;

  If objConfig.blnVendad Then
  Begin
    If objConfig.blnAutCen Then
      stlMensagens.Add('Vendedor: ' + dadosGerais.strNomVen)
    Else
      stlMensagens.Add('Vendedor: ' + dadosGerais.strCodVen + ' - ' + dadosGerais.strNomVen)
  End;

  If (dadosGerais.fNotaSaida) And (fGanhouNetpoints(fonteDados,
                                                    intQtdNps)) Then
  Begin
    stlMensagens.Add(Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]));
  End;

  If     fEmptyStr(strCnpj)               Then stlMensagens.Add('Código do cliente: ' + dadosGerais.strCodCli);
  If Not fEmptyStr(dadosGerais.strMen001) Then stlMensagens.Add(dadosGerais.strMen001);
  If Not fEmptyStr(dadosGerais.strMen002) Then stlMensagens.Add(dadosGerais.strMen002);
  If Not fEmptyStr(dadosGerais.strMen003) Then stlMensagens.Add(dadosGerais.strMen003);
  If Not fEmptyStr(dadosGerais.strMen004) Then stlMensagens.Add(dadosGerais.strMen004);
  If Not fEmptyStr(dadosGerais.strMen005) Then stlMensagens.Add(dadosGerais.strMen005);
  If Not fEmptyStr(dadosGerais.strEndTelPrc) Then stlMensagens.Add(dadosGerais.strEndTelPrc);
  If Not fEmptyStr(dadosGerais.strEndTelAle) Then stlMensagens.Add(dadosGerais.strEndTelAle);

  If ((dadosGerais.fltFedImp <> 0.00) Or
      (dadosGerais.fltEstImp <> 0.00) Or
      (dadosGerais.fltMunImp <> 0.00))                         And
     ((dadosGerais.fltTotPro - dadosGerais.fltDesEsp) <> 0.00) And
      (dadosGerais.fNotaSaida)                                 And
      (objConfigInterna.strImpPag = '2')                       Then
  Begin
    stlMensagens.Add('Vlr Aprox dos Tributos: ' +
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
      stlMensagens.Add('Vlr Aprox do Tributo "R$ ' + FormatFloat('#,##0.00', dadosGerais.fltImpPag) +
        '(' + FormatFloat('#,##0.00', fltPerImpPag) +
        IIF(objConfigInterna.strImpPag = '2','%) Fonte: IBPT"','%)"') + '#');
  End;

  strId := fRetornaIdNfeFit(dadosGerais.strCodEmp, fNumDocEnvio(dadosGerais.strNumDoc), dadosGerais.strSerie, dadosGerais.strEspDoc);

  For intLinha := 1 To stlMensagens.Count Do
  Begin
    strLinha := 'NFCE-DADOS-ADIC'                   + '|' + // 01 - Tipo de Registro
                strId                               + '|' + // 02 - Chave/Numero de Referencia no seu sistema
                intToStr(intLinha)                  + '|' + // 03 - Número da Linha ( Sequencial )
                Copy(stlMensagens[Pred(intLinha)], 1, 255); // 04 - Informações Adicionais (1- 255)

    fGetArquivo.Add(strLinha);
  End;

  FreeAndNil(stlMensagens);
end;

procedure TNFCEFit200.pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');
begin

end;

procedure TNFCEFit200.pReimprimeDanfe(strChaveAcesso: String);
  Var
    strImpressora: String;
begin
  strImpressora := fDefineImpressora(fonteDados.fDadosGerais);
  pReimprimeDanfe(strChaveAcesso, fTratarNomeImpressora(strImpressora));
end;

procedure TNFCEFit200.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;
end;

procedure TNFCEFit200.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFCEFit200.pTrailler;
begin
  fGetArquivo.Add('TRAILLER|' + IntToStr(lstArquivo.Count+1));
end;

procedure TNFCEFit200.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin

end;

function TNFCEFit200.fConsultaStatusDFe(strChaveAcesso: string): String;
begin
  Result := '';
end;

function TNFCEFit200.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  Result := '';
end;

end.

