unit untNFESPainelFiscal;

interface

uses untInterfaces, StrUtils, Math, SysUtils, Classes, untValidadorNFE, DateUtils;

Type
  TNFESPainelFiscal = class(TAbstractAdministrativoService, INFE)
    private

      dadosEmitente: TDadosEmitente;
      dadosGerais: TDadosGerais;
      lstItens: TList;
      lstArquivo: TStringList;

      procedure pValidarDiretorios;

      function fGeraInformacoesNotaFiscalEletronica: Boolean;
      function fGeraIdentificacaoEmitente: Boolean;
      function fGeraIdentificacaoDestinatario: Boolean;
      function fGeraProdutosServicos: Boolean;
      function fGeraDadosConstrucaoCivil: Boolean;

    protected
      function fGetArquivo: TStringList;

      function fPathIn: String;
      function fPathOut: String;
      function fPathBkp: String;
      function fNomeArquivoEnvio: String;
      function fNomeArquivoRetorno: String;
      function fNomeArquivoBackup(blnEnvio: Boolean): String;

      function fMascaraArquivo: String;
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
      function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

      procedure pReimprimeDanfe(strChaveAcesso: String); overload;

      function fSuportaFuncoesAdministrativas: Boolean;
      procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
        strImpressora: String; intSequencial: Integer);
      procedure pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: string = ''); overload;
      procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
        strNumeroFinal, strDescricao: String);

      destructor Destroy; override;
      function fRetXmlNfe(strChaveAcesso: string): string;
      function fEnviaNFCeXmlOffLine: Boolean;
      function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

      function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): string;

      procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

      function fConsultaStatusDFe(strChaveAcesso: string): String;
      function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;

      function fRetornaListaChavesAcessoTerceirosPeriodo(strCodEmp: String; dtaDtaIni, dtaDtaFim: TDateTime): string;
      function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;

      function fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

      function fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
      function fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
  End;

  function fFormataValor(fltValor: Double; intTamanho, intDecimais: Integer): String;


implementation

uses
  untUtil, untConfigNFE, untUtilNFSe;

{ TNFEOphos }

destructor TNFESPainelFiscal.Destroy;
begin
  If Assigned(lstItens) Then
  Begin
    lstItens.Clear;
    FreeAndNil(lstItens);
  End;

  If Assigned(lstArquivo) Then
  Begin
    FreeAndNil(lstArquivo);
  End;
  inherited;
end;

function TNFESPainelFiscal.fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
begin
  Result := False;
end;

function TNFESPainelFiscal.fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): string;
begin
  Result := ''
end;

procedure TNFESPainelFiscal.pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);
begin

end;

function TNFESPainelFiscal.fConsultaStatusDFe(strChaveAcesso: string): String;
begin
  Result := '';
end;

function TNFESPainelFiscal.fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
begin
  Result := '';
end;

function TNFESPainelFiscal.fConsultaStatusInutilizado(const strCnpjEmitente,
  strNumeroSerie, strNumeroDocumento, strModeloFiscal: String): String;
begin
  Result := '';
end;

function TNFESPainelFiscal.fConfirmacaoOperacaoEntradaMercadoria(
  strChaveAcesso: string): string;
begin
  Result := '';  
end;

function TNFESPainelFiscal.fEnviarNota: Boolean;
  Var
    strNomArqTmp: String;
    strNomArqFin: String;
    strNomArqBkp: String;
begin
  fGetArquivo.Clear;
  pValidarDiretorios;

  strNomArqTmp := fNomeArquivoEnvio + '.CITELNFE';
  strNomArqFin := fNomeArquivoEnvio + '.TXT';
  strNomArqBkp := fNomeArquivoBackup(True) + '.TXT';

  {***********************************}
  {* REALIZA A GERAÇÃO DAS LINHAS.   *}
  {********************************MV*}
  Result := fGeraInformacoesNotaFiscalEletronica;
  Result := Result And fGeraIdentificacaoEmitente;
  Result := Result And fGeraIdentificacaoDestinatario;
  Result := Result And fGeraDadosConstrucaoCivil;  
  Result := Result And fGeraProdutosServicos;

  {***********************************}
  {* APAGA ARQUIVOS ANTIGOS.         *}
  {********************************MV*}
  pDeleteFile(fNomeArquivoRetorno + '.TXT');
  pDeleteFile(strNomArqTmp);
  pDeleteFile(strNomArqFin);

  {***********************************}
  {* FAZ A GRAVAÇÃO DEFINITIVA.      *}
  {********************************MV*}
  fGetArquivo.SaveToFile(strNomArqTmp);
  fGetArquivo.SaveToFile(strNomArqBkp);
  fRenomearArquivo(strNomArqTmp, strNomArqFin);
end;

function TNFESPainelFiscal.fMascaraArquivo: String;
begin
  Result := dadosGerais.strNumDoc + '_' +
            dadosGerais.strSerie  + '_' +
            dadosGerais.strCodEmp;
end;

function TNFESPainelFiscal.fMensagemErro: String;
begin
  Result := '';
end;

function TNFESPainelFiscal.fNomeArquivoBackup(blnEnvio: Boolean): String;
begin
  Result := fPathBkp + IfThen(blnenvio, 'NFSE_ENVI_', 'NFSE_ENVO_') + fMascaraArquivo;
end;

function TNFESPainelFiscal.fNomeArquivoEnvio: String;
begin
  Result := fPathIn + 'NFSE_ENVI_' + fMascaraArquivo;
end;

function TNFESPainelFiscal.fNomeArquivoRetorno: String;
begin
  Result := fPathOut + 'NFSE_ENVO_' + fMascaraArquivo;
end;

function TNFESPainelFiscal.fPathBkp: String;
begin
  Result := objConfigInterna.strPatNES + '\BackupCitel\';
end;

function TNFESPainelFiscal.fPathIn: String;
begin
  Result := objConfigInterna.strPatNES + '\DataIn\';
end;

function TNFESPainelFiscal.fPathOut: String;
begin
  Result := objConfigInterna.strPatNES + '\DataOut\';
end;

function TNFESPainelFiscal.fProcessarCancelamento: TRetornoNFE;
begin
  Result := nil;
end;

function TNFESPainelFiscal.fProcessarEnvio: TRetornoNFE;
  Var
    strArqRet: String;
    strArqBkp: String;

    stlArqRet: TStringList;
    strLinha: String;
    intStatus: Integer;
    strMensagem: String;
    strNumRps: String;
    strNumNFSe: String;
    dtaDtaAutorizacao: TDateTime;
begin
  strArqRet := fNomeArquivoRetorno + '.TXT';
  strArqBkp := fNomeArquivoBackup(False) + '.TXT';

  If (FileExists(strArqRet)) And (fArquivoPronto(strArqRet)) Then
  Begin
    stlArqRet := TStringList.Create;
    stlArqRet.LoadFromFile(strArqRet);

    stlArqRet.SaveToFile(strArqBkp);

    Try
      strLinha    := stlArqRet[0];
      intStatus   := StrToIntDef(fGetValorLinha(strLinha, '|', 2), 0);
      strNumRps   := fGetValorLinha(strLinha, '|', 04);
      strNumNFSe  := fGetValorLinha(strLinha, '|', 05);
      strMensagem := fGetValorLinha(strLinha, '|', 11);

      dtaDtaAutorizacao := Now();
    Except
      On E: Exception Do
      Begin
        Result := TRetornoNFE.fCriaRetornoErro('Erro ao ler arquivo de retorno: ' + E.Message);
        Exit;
      End;
    End;

    Case intStatus Of
      1: Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, strNumNFSe, strNumRps, dtaDtaAutorizacao);
      2: Result := TRetornoNFE.fCriaRetornoCancelada('');
      3: Result := TRetornoNFE.fCriaRetornoDenegada(strMensagem);
      Else Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
    End;

    FreeAndNil(stlArqRet);
  End
  Else
  Begin
    Result := TRetornoNFE.fCriaRetornoAguardando;
  End;

  If (Result.Sucesso) Then
  Begin
    pDeleteFile(strArqRet);
  End;
end;

function TNFESPainelFiscal.fProcessarStatusNota: TRetornoNFE;
begin
  Result := TRetornoNFE.fCriaRetornoSucesso('Autorizada!', '-', '-', Now());
end;

function TNFESPainelFiscal.fRetornaListaChavesAcessoTerceirosPeriodo(
  strCodEmp: String; dtaDtaIni, dtaDtaFim: TDateTime): string;
begin
  Result := '';
end;

function TNFESPainelFiscal.fRetXmlNfe(strChaveAcesso: string): string;
begin
  Result := '';
end;

function TNFESPainelFiscal.fEnviaNFCeXmlOffLine: Boolean;
Begin
  Result := False;
End;

function TNFESPainelFiscal.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := False;
end;

procedure TNFESPainelFiscal.pAdicionaItem(dadosItem: TDadosItem);
begin
  If (Not Assigned(lstItens)) Then
    lstItens := TList.Create;

  lstItens.Add(dadosItem);
end;

procedure TNFESPainelFiscal.pEnviaCartaCorrecao(strChaveAcesso: String;
  stlCorrecoes: TStringList; strImpressora: String; intSequencial: Integer);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Painel Fiscal.');
end;

procedure TNFESPainelFiscal.pInutilizarNumeros(strAno, strSerie,
  strNumeroInicial, strNumeroFinal, strDescricao: String);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Painel Fiscal.');
end;

procedure TNFESPainelFiscal.pReimprimeDanfe(strChaveAcesso: String);
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Painel Fiscal.');
end;

procedure TNFESPainelFiscal.pReimprimeDanfe(strChaveAcesso,
  strImpressora: String; strImprimirTelaPDF: string = '');
begin
  Raise Exception.Create('Funcionalidade não implementada para NFs Painel Fiscal.');
end;

procedure TNFESPainelFiscal.pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
begin
  Self.dadosEmitente := dadosEmitente;  
end;

procedure TNFESPainelFiscal.pSetaDadosGerais(dadosGerais: TDadosGerais);
begin
  Self.dadosGerais := dadosGerais;
end;

procedure TNFESPainelFiscal.pValidarDiretorios;
  Var
    strMsg: String;
begin
  strMsg := '';

  {***********************************}
  {* VERIFICA OS PATHS DO INTEGRADOR *}
  {********************************JC*}
  If (Not DirectoryExists(fPathIn)) Then
    strMsg := strMsg + 'Path de envio de dados não existe (-' + fPathIn + '-).' + #13#10;

  If (Not DirectoryExists(fPathOut)) Then
    strMsg := strMsg + 'Path de retorno de dados não existe (-' + fPathOut + '-).' + #13#10;

  If (Not DirectoryExists(fPathBkp)) Then
    strMsg := strMsg + 'Path de backup de dados não existe (-' + fPathBkp + '-).';

  If Not fEmptyStr(strMsg) Then
    Raise Exception.Create(strMsg);
end;

function fFormataValor(fltValor: Double; intTamanho,
  intDecimais: Integer): String;
begin
  Result := Trim(AnsiReplaceStr(Format('%' + IntToStr(intTamanho + 1) + '.' + IntToStr(intDecimais) + 'f', [fltValor]), ',', ''));
end;

function TNFESPainelFiscal.fGeraInformacoesNotaFiscalEletronica: Boolean;
  Var
    strLinha : String;
begin
  strLinha := '000' + '|';
  strLinha := strLinha + IntToStr(StrToIntDef(dadosGerais.strNumDoc,0)) + '|';                                        // 01 - REFERENCIA SISTEMA
  strLinha := strLinha + objConfigInterna.strCliNES                            + '|';                                        // 02 - USUARIO EMITENTE NFSE
  strLinha := strLinha + fGetNaturezaOperacao(objConfig, dadosGerais, dadosEmitente) + '|';                           // 03 - NAT. DA OPERACAO (1=TRIBUTACAO NO MUNICIPIO / 2 = Tributação fora do Município)
  strLinha := strLinha + '2|';                                                                                        // 04 - INCENTIVADOR CULTURAL (2=NÃO)
  strLinha := strLinha + FormatDateTime('YYYY', dadosGerais.dtaDtaEnt) + fPadL(RightStr(dadosGerais.strNumDoc, 11), 11, '0') + '|'; // 05 - NUMERO (ANO 4D + SEQUENCIAL 11C)
  strLinha := strLinha + dadosGerais.strSerie + '|';                                                                  // 06 - SERIE
  strLinha := strLinha + FormatDateTime('YYYYMMDDHHNNSS', dadosGerais.dtaDtaEnt + dadosGerais.dtaHorEnt) + '|';       // 07 - DATA/HORA DE EMISSAO DA NFSE
  strLinha := strLinha + '1|';                                                                                        // 08 - TIPO (1=RPS)
  strLinha := strLinha + IfThen(fSimplesPaulista(dadosGerais, dadosEmitente), '1', '2') + '|';                             // 09 - OPTANTE DO SIMPLES NACIONAL
  strLinha := strLinha + objConfigInterna.strReEsTr + '|';                                                                   // 10 - REGIME ESPECIAL DE TRIBUTAÇÃO
  strLinha := strLinha + '|';                                                                                         // 11 - CODIGO DE VERIFICAÇÃO
  strLinha := strLinha + '1|';                                                                                        // 12 - STATUS DO RPS
  strLinha := strLinha + '|';                                                                                         // 13 - NUMERO DA NFSE SUBSTITUIDA

  fGetArquivo.Add(strLinha);
  Result := True;
end;

function TNFESPainelFiscal.fGeraIdentificacaoEmitente: Boolean;
  Var
    strLinha : String;
begin
  strLinha := '001' + '|';
  strLinha := strLinha + dadosEmitente.strCnpj + '|';                           // 01 - NUMERO DO CNPJ DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strInscricaoMunicipal + '|';             // 02 - INSCR. MUNICIPAL DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strRazao + '|';                          // 03 - RAZAO OU NOME DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strFantasia + '|';                       // 04 - NOME FANTASIA
  strLinha := strLinha + dadosEmitente.strIES + '|';                            // 05 - INSCRICAO ESTADUAL DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strEMail + '|';                          // 06 - EMAIL DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strTelefone + '|';                       // 07 - TELEFONE DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strCodIbge + '|';                        // 08 - CODIGO DO MUNICIPIO IBGE
  strLinha := strLinha + dadosEmitente.strEstado + '|';                         // 09 - UF DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strBairro + '|';                         // 10 - BAIRRO DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strComplementoEnd + '|';                 // 11 - COMPLEMENTO DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strCep + '|';                            // 12 - CEP DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strEndereco + '|';                       // 13 - LOGRADOURO DO PRESTADOR
  strLinha := strLinha + dadosEmitente.strNumeroEnd + '|';                      // 14 - NRO LOGRADOURO DO PRESTADOR

  fGetArquivo.Add(strLinha);
  Result := True;
end;

function TNFESPainelFiscal.fGeraDadosConstrucaoCivil: Boolean;
  Var
    strLinha : String;
begin
  If (Not fEmptyStr(dadosGerais.strCodObr)) Then
  Begin
    strLinha := '004' + '|';
    strLinha := strLinha + dadosGerais.strCodObr + '|';                           // 01 - CÓDIGO DA OBRA (NUMERO DA MATRICULA CEI DA OBRA OU DA EMPRESA)
    strLinha := strLinha + dadosGerais.strCodArt + '|';                           // 02 - NUMERO DA ART

    fGetArquivo.Add(strLinha);
  End;

  Result := True;
end;

function TNFESPainelFiscal.fGeraIdentificacaoDestinatario: Boolean;
  Var
    strLinha : String;
begin
  strLinha := '002' + '|';
  strLinha := strLinha + dadosGerais.strCnpj + '|';                               // 01 - NUMERO DO CNPJ DO TOMADOR
  strLinha := strLinha + '|';                                                     // 02 - INSCR. MUNICIPAL DO TOMADOR
  strLinha := strLinha + dadosGerais.strNomCli + '|';                             // 03 - RAZAO OU NOME DO TOMADOR
  strLinha := strLinha + LeftStr(fApenasUmEmail(dadosGerais.strEmail), 80) + '|'; // 04 - EMAIL DO TOMADOR
  strLinha := strLinha + dadosGerais.strTelefone + '|';                           // 05 - TELEFONE DO TOMADOR
  strLinha := strLinha + dadosGerais.strCodIbge + '|';                            // 06 - CODIGO DO MUNICIPIO IBGE
  strLinha := strLinha + dadosGerais.strEstado + '|';                             // 07 - UF DO TOMADOR
  strLinha := strLinha + dadosGerais.strBairro + '|';                             // 08 - BAIRRO DO TOMADOR
  strLinha := strLinha + dadosGerais.strComplementoEnd + '|';                     // 09 - COMPLEMENTO DO TOMADOR
  strLinha := strLinha + dadosGerais.strCEP + '|';                                // 10 - CEP DO TOMADOR
  strLinha := strLinha + dadosGerais.strLogradouro + '|';                         // 11 - LOGRADOURO DO TOMADOR
  strLinha := strLinha + dadosGerais.strNumeroEnd + '|';                          // 12 - NRO LOGRADOURO DO TOMADOR

  fGetArquivo.Add(strLinha);
  Result := True;
end;

function TNFESPainelFiscal.fGeraProdutosServicos: Boolean;
  Var
    strLinha,
    strDesSer,
    strCodSLC,
    strTriMun: String;
    fltIssRet,
    fltPerIss: Double;
    intCont: Integer;
    dadosItem: TDadosItem;

  function fGetIbgeLocalServico: String;
  begin
    If fGetNaturezaOperacao(objConfig, dadosGerais, dadosEmitente) = '1' Then
      Result := dadosEmitente.strCodIbge
    Else
      Result := dadosGerais.strCodIbge;
  end;

begin
  Result := True;

  If (Not Assigned(lstItens)) Then
    Exit;

  strDesSer := '';
  strCodSLC := '';
  strTriMun := '';
  fltPerIss := 0.0;
  fltIssRet := 0.0;

  If (dadosGerais.fltTotSer > 0) Then
    fltPerIss := (dadosGerais.fltValIss / dadosGerais.fltTotSer) * 100;

  For intCont := 0 To lstItens.Count-1 Do
  Begin
    dadosItem := TDadosItem(lstItens[intCont]);

    If fEmptyStr(strCodSLC) Then strCodSLC := dadosItem.strCodSLC;
    If fEmptyStr(strTriMun) Then strTriMun := dadosItem.strTriMun;

    If (Not fEmptyStr(strDesSer)) Then
      strDesSer := strDesSer + ' / ';

    strDesSer := strDesSer + dadosItem.strDesIte;
  End;

  If Not fEmptyStr(dadosGerais.strMensagemAplicacao) Then
    strDesSer := strDesSer + ' / Informações: ' + AnsiReplaceStr(dadosGerais.strMensagemAplicacao, #13#10, ' - ');

  If dadosGerais.strRetIss = 'S' Then
    fltIssRet := dadosGerais.fltValIss;

  strLinha := '005' + '|';
  strLinha := strLinha + fFormataValor(dadosGerais.fltTotSer, 15, 2) + '|';   //01 - VALOR DO SERVIÇO PRESTADO
  strLinha := strLinha + '000|';                                              //02 - VALOR DAS DEDUCOES P/ BASE
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';                       //03 - VALOR DA RETENCAO DO PIS
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';                       //04 - VALOR DA RETENCAO DO COFINS
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';                       //05 - VALOR DA RETENCAO DO INSS
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';                       //06 - VALOR DA RETENCAO DO IR
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';                       //07 - VALOR DA RETENCAO DO CSLL
  strLinha := strLinha + '000|';                                              //08 - VALOR DE OUTRAS RETENCOES
  strLinha := strLinha + fFormataValor(dadosGerais.fltTotSer, 15, 2) + '|';   //09 - VALOR DA BASE DE CALCULO
  strLinha := strLinha + fFormataValor(fltPerIss,  5, 4) + '|';               //10 - ALIQUOTA DO SERVICO PRESTADO
  strLinha := strLinha + fFormataValor(dadosGerais.fltTotSer - fltIssRet, 15, 2) + '|';   //11 - VLR LIQUIDO
  strLinha := strLinha + fFormataValor(fltIssRet, 15, 2) + '|';               //12 - VALOR DO ISS A SER RETIDO
  strLinha := strLinha + '000|';                                              //13 - VALOR DESCONTO CONDICIONADO
  strLinha := strLinha + '000|';                                              //14 - VALOR DESCONTO INCONDICIONADO
  strLinha := strLinha + fLimpaCaracteres(strCodSLC) + '|';                   //15 - COD. SERVICO PRESTADO (LC 116/2003)
  strLinha := strLinha + '|';                                                 //16 - CNAE 2.0
  strLinha := strLinha + fLimpaCaracteres(strTriMun) + '|';                   //17 - COD. SERVICO PRESTADO PROPRIO MUNIC.
  strLinha := strLinha + strDesSer + '|';                                     //18 - DISCRIMINACAO DO SERVICO
  strLinha := strLinha + fGetIbgeLocalServico + '|';                          //19 - CODIGO DO MUNICIPIO IBGE
  strLinha := strLinha + fFormataValor(dadosGerais.fltValIss, 15, 2) + '|';   //20 - VALOR DO ISS

  fGetArquivo.Add(strLinha);
  Result := True;
end;

function TNFESPainelFiscal.fVerificarStatusNota: Boolean;
begin
  Result := True;
end;

function TNFESPainelFiscal.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

function TNFESPainelFiscal.fVerificarStatusServico(strCnpjEmitente,
  strIESEmitente: String): TRetornoStatusNFE;
begin
  Result := rsOperacional;
end;

function TNFESPainelFiscal.fGetArquivo: TStringList;
begin
  If Not Assigned(lstArquivo) Then
    lstArquivo := TStringList.Create;

  lstArquivo.Text := fTiraCaracEspeciais(lstArquivo.Text, False);
  Result := lstArquivo;
end;

function TNFESPainelFiscal.fConfirmacaoDeEntrega(strNumDoc, strEspDoc,
  strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude,
  strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFESPainelFiscal.fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strMotivo, strJustificativa, strHashEntrega,
  strHashData: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFESPainelFiscal.fCancelamentoConfirmacaoDeEntrega(strNumDoc,
  strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

function TNFESPainelFiscal.fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc,
  strCodEmp, strSerie: String): TRetornoNFE;
begin
  Result := Nil;
end;

end.
