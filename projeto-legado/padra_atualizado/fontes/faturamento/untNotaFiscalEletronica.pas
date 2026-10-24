unit untNotaFiscalEletronica;

interface

uses SysUtils, Classes, Uni,  Forms, DB, untTypesSistema,
  DBTables, UniClientDataSet, Variants, IdIcmpClient, StrUtils, untFuncFatTypes,
  untFuncoesSimples, Math, untFuncFat, StdCtrls, Graphics,
  xmldom, XMLIntf, msxmldom, XMLDoc, Windows,
  Controls, ExtCtrls, Dialogs, untNotaFiscalEletronicaAbs,
  cxProgressBar;

Type
  {**************************************************}
  {* EVENTOS DISPARADOS AO LONGO DOS PROCESSAMENTOS *}
  {***********************************************PH*}
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;
  TipoIdIcmpClient = Class(TIdIcmpClient);
  TNotaFiscalEletronica = class(TAbstractNotaFiscalEletronica)
  private
    {***********}
    {* EVENTOS *}
    {********PH*}
    FRegistraProgresso: TEventoProgresso;
    FRegistraAcao: TEventoStrAcao;

    {*******************************************}
    {* NUMERO DA NOTA FISCAL                   *}
    {****************************************PH*}
    strNumDoc: String;

    {*************************}
    {* ARQUIVO DE SAIDA NF-e *}
    {**********************PH*}
    txtArquivoSaida: TextFile;
    strPatNfe: String;
    strCodEmp: String;
    //strSeriNf: String;

    {********************}
    {* DADOS DA EMPRESA *}
    {*****************PH*}
    qryCadEmp: TUniQuery;

    {*******************************************}
    {* OBJETOS VINDO DA VENDA                  *}
    {****************************************PH*}
    FItens: TMatrizFechamento;
    FDuplicatas: TDigDuplicArray;
    FVenda: TFatVenda;

    {*******************************************}
    {* DADOS DO CANCELAMENTO DE NOTAFISCAL     *}
    {****************************************PH*}
    qryCadCli: TDataSet;
    blnCliente: Boolean;

    {***********************}
    {* DADOS DO RETORNO    *}
    {********************PH*}
    FStrChaveAcesso: String;
    FStrNumeroProtocolo: String;
    FStrRetorno: String;

    {********************************************}
    {* GERACAO DO ARQUIVO PARA SUYNCHRO(SERASA) *}
    {*****************************************PH*}
    xmlDoc: TXMLDocument;
    FStrMotivoCancelamento: String;

    {**************************************************}
    {* FUNCOES AUXILIARES PARA A GERACAO DOS ARQUIVOS *}
    {***********************************************PH*}
    function fRetCodigoUfIbge(strCodCid: String): String;
    function fRetCodMun(strCodCid: String): String;
    function fRetDescricaoCfop(strCfop: String): String;
//    function fRetCliEmail(strCodCli: String; strTipFc: String): String;
    function fRetModadalidadeIcms(strCodSit: String): String;
    function fRetNumSerie(): String;
    function fRetDtaDoc(): TDateTime;
    function fRetDadosCnfe(intLargura: Integer): String;
    function fImprimeDuplicatasCnfe: Boolean;

    function fFormataValor(fltValor: Double; intTamanho, intDecimais: Integer): String;
    function fLimpaCaracteres(strTexto: String): String;
    function fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
    function fLimpaCaracteresTelefone(strTexto: String): String;

    function fTrocaExtensaoNomeArq(strNomeArq, strNovaExt: String): String;
    procedure pApagaArquivosDataOut(strNomeArq, strOperacaoOri, strOperacaoDest: String);
    function fArquivoPronto(strArquivo: String): Boolean;

    function fRetLinhaST(strCodSit: String; intItemIndex: Integer): String;
    function fRetSituacaoTributaria(strClaFis: String; ItemIndex: Integer): String;
    function fRetEntradaSaida(strClaFis: String): String; overload;
    function fRetEntradaSaida(): String; overload;
    function fRetValoresSituacaoTrinbutarias(strCodSit: String; intIndex: Integer): String;
    function fRetOrigemMercadoria(strCodsit: String): String;
    procedure pRecarregaTransportadora();
    procedure pCarregaDadosItens();
    function fRetDataEmissaoNfe(): TDate;

    {************************************************************************************}
    {* VERIFICACOES NECESSARIAS PARA PROCESSAMENTO DOS ARQUIVOS DA NFe.                 *}
    {* VERIFICAR SE ESSA NOTA JA FOI GERADA E VERIFICAR SE JA CONSTA NO BANCO O RETORNO *}
    {*********************************************************************************PH*}
    function fVerificaNotaJaGerada(): Boolean;
    function fVerificaNotaJaRetornada(): Boolean;

    {*******************************************}
    {* CRIA BACKUP DO ARQUIVO ESPECIFICADO     *}
    {****************************************PH*}
    procedure pCriarBackupArquivo(strNomArq: String);

    {***************************************************}
    {* FUNCOES AUXILIARES PARA GERACAO DE ARQUIVOS XML *}
    {************************************************PH*}
    function fXmlFormataValor(fltValor: Double; intTamanho, intDecimais: Integer): String;

    function fXmlRetIcmsSt(xmlNoPai: IXMLNode; intItemIndex: Integer): IXMLNode;
    function fXmlRetIpiSt(xmlNoPai: IXMLNode; intItemIndex: Integer): IXMLNode;
    function fXmlRetPisSt(xmlNoPai: IXMLNode; intItemIndex: Integer): IXMLNode;
    function fXmlRetCofinsSt(xmlNoPai: IXMLNode; intItemIndex: Integer): IXMLNode;

    {*********************************************}
    {* FUNCOES PARA LER INFORMACOES DOS RETORNOS *}
    {******************************************PH*}
    function fRetStatusRetorno(strArquivo: String): Integer;
    function fRetStatusRetornoCancelamento(strArquivo: String): Integer;
    function fRetChaveAcesso(strArquivo: String): String;
    function fRetProtocolo(strArquivo: String): String;
    function fRetMensagemRetorno(strArquivo: String): String;
    function fRetInformacoesAdicionais(): String;
    function fRetInformacoesAdicionaisNotImp: String;
    function fRetInformacoesAdicionaisNotComp: String;
    function fQuebraStringLinhas(strMensagem: String; intTamanho: Integer): String;

    function fImprimeSubTributariaDadosProprios: Boolean;
    function fImprimeIPIDadosProprios: Boolean;    

    function GetDuplicata(Index: Integer): TArrDigDuplic;
    function GetItens(Index: Integer): TDadosFechamento;

    function fRetPontoImpressao: String;

    procedure SetDuplicata(Index: Integer; Duplicata: TArrDigDuplic);
    procedure SetItens(Index: Integer; DadosFechamento: TDadosFechamento);
    procedure SetStrChaveAcesso(const Value: String);
    procedure SetStrNumeroProtocolo(const Value: String);
    procedure SetStrRetorno(const Value: String);
    function GetNumeroEnderecoCliente(strCodCli: String): String;
    procedure SetStrMotivoCancelamento(const Value: String);

  protected
    {*******************************************************}
    {* FUNCOES RELACIONADAS A GERACAO DE ARQUIVO TXT OPHOS *}
    {****************************************************PH*}
    function fGeraInformacoesNotaFiscalEletronica(): Boolean;
    function fGeraIdentificacaoEmitente(): Boolean;
    function fGeraIdentificacaoDestinatario(): Boolean;
    function fGeraDadosdasDuplicatas(): Boolean;
    function fGeraDadosTransportes(): Boolean;
    function fGeraDadosVolume(): Boolean;
    function fGeraProdutosServicos(): Boolean;

    function fGeraDadosCancelamento(): Boolean;

    function fGeraChavesReferenciadas(): Boolean;
    function fGeraProdutoNfeComplemento(): Boolean;

    {***********************************************************}
    {* FUNCOES AUXILIARES PARA GERACAO DE ARQUIVO XML (SERASA) *}
    {********************************************************PH*}
    function fXmlGeraNFe(): Boolean;
    function fXmlGeraDadosNFe(): Boolean;
    function fXmlGeraIdentificacaoNFe(): Boolean;
    function fXmlGeraIdentificacaoEmitenteNFe(): Boolean;
    function fXmlGeraIdentificacaoDestinatarioNFe(): Boolean;
    function fXmlGeraDetalhamentoProdutosNFe(): Boolean;
    function fXmlGeraValoresTotaisNFe(): Boolean;
    function fXmlGeraInformacoesTransporteNFe(): Boolean;

    function fXmlGeraDadosCancelamento(strArqNfe: String): Boolean;

    {******************************************************************}
    {* VERIFICA SE EXISTE O CAMINHO/ARQUIVO NA REDE OU NO DISCO LOCAL *}
    {***************************************************************PH*}
    function fFileExists(strPath: String; intTimeOut: Integer = 5000): Boolean;

    {*********************************************}
    {* GERA A MATRIZ DE ITENS/SERVICOS DA VENDA  *}
    {******************************************JC*}
    function fGerarMatrizItensServicos(Itens: TMatrizFechamento; Venda: TFatVenda): TMatrizFechamento;

  public

    strNomeArquivoAtual: String;

    { CONSTRUTOR PADRAO }
    constructor Create(AOwner: TComponent; strNumDoc: String); reintroduce; overload;

    { CONSTRUTOR USADO PARA GERACAO DE ARQUIVOS DA VENDA }
    constructor Create(AOwner: TComponent; strNumDoc: String;
      Itens: TMatrizFechamento; Duplicatas: TDigDuplicArray; Venda: TFatVenda); reintroduce; overload;

    { CONSTRUTOR USADO PARA A TELA CANCELAMENTO DE DOCUMENTO }
    constructor Create(AOwner: TComponent; strNumDoc: String; qryCadCli: TDataSet); reintroduce; overload;

    { CONSTRUTOR USADO PARA CANCELAR UMA NOTA DURANTE A VENDA }
    constructor Create(AOwner: TComponent; strNumDoc: String; Venda: TFatVenda); reintroduce; overload;

    destructor Destroy; override;

    {***********************************************}
    {* GERA ARQUIVOS DE ENVIO DA NF E CANCELAMENTO *}
    {********************************************PH*}
    function fGerarArquivo(): Boolean;
    function fCancelarNotaFiscal(): Boolean;
    {***********************************************}
    {* GERAR ARQUIVO DE NOTA FISCAL DE COMPLEMENTO *}
    {********************************************PH*}
    function fGerarArquivoComplemento(): Boolean;

    {*******************************************}
    {* PROCESSA OS ARQUIVOS DE RETORNO         *}
    {****************************************PH*}
    function fProcessarRetorno(): Boolean;
    function fProcessaRetornoCancelamento(): Boolean;

    property Itens[Index: Integer]: TDadosFechamento Read GetItens Write SetItens;
    property Duplicatas[Index: Integer]: TArrDigDuplic Read GetDuplicata Write SetDuplicata;
    property Venda : TFatVenda Read FVenda Write FVenda;

    procedure pGravarLogNFE(strNumIp, strNomArq, strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie: String);
    procedure pAtualizarLogNFE(strNumIp, strNomArq: String; intCodAut: Integer;
      strAcesso: String);
    procedure pAtualizarStatusLogNFE(strNumIp, strNomArq, strStatus: String);
    procedure pDeletarLogNFE;

    class function fTemCancelamentoPendente: Boolean;
    class function fCancelamentosPendentes(pgbProgresso: TcxProgressBar): Boolean;
    class procedure pVerificaCancelamentosPendentes;
    class function  fVerificaCancelamentosPendentesPainel(strEspecie: String = ''): Boolean;
    class procedure pEnviarCancelamentoNFE(strNumDoc, strCodCli, strArquivo: String;
      pgbProgresso: TcxProgressBar);

  published
    property RegistraProgresso: TEventoProgresso Read FRegistraProgresso Write FRegistraProgresso;
    property RegistraAcao: TEventoStrAcao Read FRegistraAcao Write FRegistraAcao;
    property StrChaveAcesso: String read FStrChaveAcesso write SetStrChaveAcesso;
    property StrNumeroProtocolo: String read FStrNumeroProtocolo write SetStrNumeroProtocolo;
    property StrRetorno: String read FStrRetorno write SetStrRetorno;
    property StrMotivoCancelamento: String read FStrMotivoCancelamento write SetStrMotivoCancelamento;
  end;

  {***********************************************}
  {* EXECOES GERADAS PELA NOTA FISCAL ELETRONICA *}
  {********************************************PH*}
  ExceptionNFeNaoAutorizada = Class(Exception)
    public
      constructor Create(var notaFiscalEletronica: TNotaFiscalEletronica);
  End;

  ExceptionFalhaNFe = class(Exception);
  ExceptionFalhaRetornoNFe = class(Exception);
  ExceptionNFeJaEmitida = class(Exception);
  ExceptionNFeJaRetornarda = class(Exception);
  EVerificacaoCancelamentoPendenteCancelada = class(Exception);

Var
  NFE_AbortarVerificacaoCancelamentoPendente: Boolean = False;

{*****************************************}
{* CONSTANTES PARA LOGNFE                *}
{**************************************MV*}
Const
  NFE_OPERACAO_OK = 'OK';
  NFE_CANCELAMENTO_PENDENTE = 'CP';
  NFE_TEMPO_ESPERA_CP = '00:30:00';
  MAX_SERVICOS_VENDA = 6;

implementation

uses untFuncoes, untFuncMacro, untGravando, TypInfo, untPontosImpressao;

{ TNotaFiscalEletronica }

destructor TNotaFiscalEletronica.Destroy;
begin
  If Assigned(qryCadEmp) Then FreeAndNil(qryCadEmp);
  If Assigned(xmlDoc) Then FreeAndNil(xmlDoc);
  inherited;
end;

function TNotaFiscalEletronica.fFormataValor(fltValor: Double; intTamanho, intDecimais: Integer): String;
begin
  Result := Trim(AnsiReplaceStr(Format('%' + IntToStr(intTamanho + 1) + '.' + IntToStr(intDecimais) + 'f', [fltValor]), ',', ''));
end;

function TNotaFiscalEletronica.fGeraIdentificacaoEmitente: Boolean;
  Var
    strLinha : String;
    strAux: String;
    strEndCmp: String;
begin
  strLinha := '001' + '|';
  strEndCmp := qryCadEmp.FieldByName('EMP_ENDCMP').AsString;

  strAux := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_C_G_C_').AsString);
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('CNPJ do Emitente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                           // 001 - S - C - 014 - NUMERO DO CNPJ DO EMITENTE

  strAux := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Nome do Emitente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                             // 002 - S - C - 060 - RAZAO SOCIAL OU NOME DO EMITENTE
  strLinha := strLinha + strAux + '|';                                             // 003 - N - C - 060 - NOME FANTASIA

  strAux := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Endereço do Emitente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                             // 004 - S - C - 060 - LOGRADOURO DO EMITENTE

  strAux := qryCadEmp.FieldByName('EMP_ENDNUM').AsString;
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Número do endereço do Emitente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                             // 005 - S - C - 060 - NUMERO DO LOGRADOURO DO EMITENTE
  strLinha := strLinha + strEndCmp + '|';                                          // 006 - S - C - 060 - COMPLEMENTO DO LOGRADOURO DO EMITENTE

  strAux := qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Bairro do Emitente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                             // 007 - S - C - 060 - BAIRRO DO LOGRADOURO DO EMITENTE

  Try
    strAux := fRetCodMun(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    If fEmptyStr(strAux) Then
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE da cidade do emitente!');
    End;
  Except
    On E: ExceptionFalhaNFe Do
    Begin
      Raise;
    End;

    On E: Exception Do
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE da cidade do emitente!');
    End;
  End;

  strLinha := strLinha + strAux + '|';                                 // 008 - N - N - 007 - CODIGO DO MUNICIPIO IBGE

  strAux := fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
  If fEmptyStr(strAux) Then
  Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o nome da cidade do emitente!');
  End;
  strLinha := strLinha + strAux + '|';                              // 009 - S - C - 060 - NOME DO MUNICIPIO

  strAux := fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Não foi possivel obter o estado do emitente!');
  End;
  strLinha := strLinha + strAux + '|';                           // 010 - S - C - 002 - UF

  strAux := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_C_E_P_').AsString);
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('CEP do emitnente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                           // 011 - S - C - 008 - CEP

  strLinha := strLinha + '|';                                                                                            // 012 - N - N - 004 - CODIGO DO PAIS
  strLinha := strLinha + '|';                                                                                            // 013 - N - C - 060 - NOME DO PAIS
  strLinha := strLinha + fLimpaCaracteresTelefone(qryCadEmp.FieldByName('EMP_FONE01').AsString) + '|';                   // 014 - N - C - 010 - TELEFONE

  strAux := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_I_E_S_').AsString);
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('IES do emitente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                           // 015 - S - C - 014 - INSCRICAO ESTADUAL

  strLinha := strLinha + '|';                                                                                            // 016 - N - C - 014 - INSCRICAO ESTADUAL DO ST

  strAux := '';
  If Venda.fltTotSer > 0 Then
    strAux := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_INSMUN').AsString);

  strLinha := strLinha + strAux + '|';                                                                                   // 017 - N - C - 015 - INSCRICAO MUNICIPAL
  strLinha := strLinha + '';                                                                                             // 018 - N - N - 007 - CNAE FISCAL

  Writeln(txtArquivoSaida, strLinha);
  Result := True;
end;

function TNotaFiscalEletronica.fGeraInformacoesNotaFiscalEletronica: Boolean;
  Var
    strLinha : String;
    strPonImp: String;
    strAux   : String;

    fltBasRet,
    fltTotRet,
    fltTotIpi: Double;
begin

  If fImprimeSubTributariaDadosProprios Then
  Begin
    fltBasRet := Venda.fltBasRet;
    fltTotRet := Venda.fltTotRet;
  End
  Else
  Begin
    fltBasRet := 0.0;
    fltTotRet := 0.0;
  End;

  If fImprimeIPIDadosProprios Then
    fltTotIpi := Venda.fltTotIpi
  Else
    fltTotIpi := 0.0;

  strLinha := '000' + '|' ;
  strLinha := strLinha + IntToStr(StrToIntDef(strNumDoc,0)) + '|';                                                            // 001 - S - C - 0020,00 - CODIGO ALTERNATIVO

  strAux := fCfgSis('NFEEMP');
  If fEmptyStr(strAux) Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário Ophos não está configurado!', ['OK']);
    Result := False;
    Exit;
  End;

  {************************************************}
  {* RETORNA O PONTO DE IMPRESSÃO CONFIGURADO.    *}
  {* SE EXISTIR ALGUM ENVIA O PONTO DE IMPRESSÃO  *}
  {* SENÃO ENVIA O CÓDIGO DA EMPRESA CONFIGURADA. *}
  {* ALTERADO CONFORME ORIENTAÇÃO DO RONALDO.     *}
  {*********************************************PZ*}
  strPonImp := fRetPontoImpressao;

  If (fEmptyStr(strPonImp)) Then
    strLinha := strLinha + strAux + '|'                                                                                    // 002 - S - C - 0020,00 - CODIGO DE REFERENCIA DO USUARIO
  Else
    strLinha := strLinha + strPonImp + '|';                                                                                // 002 - S - C - 0020,00 - CODIGO DE REFERENCIA DO USUARIO


  Try
    strAux := fRetCodigoUfIbge(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    If fEmptyStr(strAux) Then
    Begin
      Raise ExceptionFalhaNFe.Create(Format('Não foi possivel obter o código IBGE da cidade %s - %s - %s',
        [qryCadEmp.FieldByName('EMP_CODCID').AsString,
        fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString),
        fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1)]));
    End;
  Except
    On E: ExceptionFalhaNFe Do
    Begin
      Raise;
    End;

    On E: Exception Do
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE do estado da empresa!');
    End
  End;
  strLinha := strLinha + strAux + '|';                                                                                   // 003 - S - N - 0002,00 - CODIGO UF IBGE

  strLinha := strLinha + fRetDescricaoCfop(Venda.FClaFis) + '|';                                                         // 004 - S - C - 0060,00 - DESCRICAO NATUREZA DE OPERACAO
  strLinha := strLinha + IfThen(Venda.strConPag = '01000', '0', '1') + '|';                                              // 005 - S - N - 0001,00 - FORMA DE PAGAMENTO (0 - A VISTA, 1 - PAGAMENTO A PRAZO, 2 - OUTROS)
  strLinha := strLinha + '55' + '|';                                                                                     // 006 -- S - N - 0002,00 - CODIGO DO MODELO QDE DOCUMENTO
  strLinha := strLinha + Venda.strSerFsc + '|';                                                                                // 007 - S - N - 0003,00 - SERIE DO DOCUMENTO
  strLinha := strLinha + strNumDoc + '|';                                                                                // 008 - S - C - 0009,00 - NUMERO DO DOCUMENTO
  strLinha := strLinha + FormatDateTime('YYYYMMDDHHNNSS', VS_Date+Time) + '|' ;                                          // 009 - S - C - 0012,00 - DATA DE EMISSAO DO DOCUMENTO

  If fCfgSis('NFEDSE', varBoolean) Then
    strLinha := strLinha + FormatDateTime('YYYYMMDDHHNNSS', VS_Date+Time) + '|'                                          // 010 - N - C - 0012,00 - DATA DE SAIDA/ENTRADA DO DOCUMENTO
  Else
    strLinha := strLinha + '|';

  strLinha := strLinha + IfThen(fRetEntradaSaida(Venda.strClaFis) = 'E', '0', '1') + '|';                                // 011 - S - N - 0001,00 - TIPO DO DOCUMENTO / ENTRADA OU SAIDA

  Try
    strAux := fRetCodMun(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    If fEmptyStr(strAux) Then
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE da cidade da empresa!');
    End;
  Except
    On E: ExceptionFalhaNFe Do
    Begin
      Raise;
    End;

    On E: Exception Do
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE da cidade do emitente!');
    End;
  End;
  strLinha := strLinha + strAux + '|';                                                                                   // 012 - S - N - 0007,00 - CODIGO DO MUNICIPIO DE OCORRENCIA

  strLinha := strLinha + '0' + '|';                                                                                      // 013 - S - N - 0001,00 - FORMATO DE IMPRESSAO DANFE (0-RETRATO, 1-PAISAGEM)
  strLinha := strLinha + '0' + '|';                                                                                      // 014 - S - N - 0001,00 - FORMA DE EMISSAO DA NF-E (0-NORMAL, 1-CONTINGENCIA
  strLinha := strLinha + IfThen(fCfgSis('HOMOLO') = 'S', '1', '0') + '|';                                                // 015 - S - N - 0001,00 - IDENTIFICACAO DO AMBIENTE (0-PRODUCAO, 1-HOMOLOGACAO)
  strLinha := strLinha + '0' + '|';                                                                                      // 016 - S - N - 0001,00 - FINALIDADE DA EMISSAO DA NF-E (0- NFE NORMAL, 1- NFE COMPLEMENTAR, NFE DE AJUSTE)
  strLinha := strLinha + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Venda.fltBasIcm, 15, 2)) + '|';              // 017 - S - N - 0015,20 - BC DO ICMS
  strLinha := strLinha + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Venda.fltTotIcm, 15, 2)) + '|';              // 018 - S - N - 0015,20 - VALOR TOTAL DO ICMS
  strLinha := strLinha + fFormataValor(fltBasRet, 15, 2)       + '|';                                                    // 019 - S - N - 0015,20 - BC DO ICMS ST
  strLinha := strLinha + fFormataValor(fltTotRet, 15, 2)       + '|';                                                    // 020 - S - N - 0015,20 - VALOR TOTAL DO ICMS ST
  strLinha := strLinha + fFormataValor(IIF(Venda.fltImpPro > 0, Venda.fltImpPro, Venda.fltTotPro), 15, 2) + '|';         // 021 - S - N - 0015,20 - VALOR TOTAL DOS PRODUTOS E SERVICOS
  strLinha := strLinha + fFormataValor(Venda.fltValFre, 15, 2) + '|';                                                    // 022 - S - N - 0015,20 - VALOR TOTAL DO FRETE
  strLinha := strLinha + fFormataValor(0.0, 15, 2) + '|';                                                                // 023 - S - N - 0015,20 - VALOR TOTAL DO SEGURO
  strLinha := strLinha + fFormataValor(Venda.fltDesEsp, 15, 2) + '|';                                                    // 024 - S - N - 0015,20 - VALOR TOTAL DO DESCONTO
  strLinha := strLinha + '0' + '|';                                                                                      // 025 - S - N - 0015,20 - VALOR TOTAL DO II
  strLinha := strLinha + fFormataValor(fltTotIpi, 15, 2)       + '|';                                                    // 026 - S - N - 0015,20 - VALOR TOTAL DO IPI
  strLinha := strLinha + fFormataValor(Venda.fltTotPis, 15, 2) + '|';                                                    // 027 - S - N - 0015,20 - VALOR DO PIS
  strLinha := strLinha + fFormataValor(Venda.fltTotCof, 15, 2) + '|';                                                    // 028 - S - N - 0015,20 - VALOR DO COFINS
  strLinha := strLinha + fFormataValor(Venda.fltDesAce, 15, 2) + '|';                                                    // 029 - S - N - 0015,20 - OUTRAS DESPESAS ACESSORIAS
  strLinha := strLinha + fFormataValor(Venda.fltTotGer, 15, 2) + '|';                                                    // 030 - S - N - 0015,20 - VALOR TOTAL DA NFE
  strLinha := strLinha + IIF(Venda.fltTotSer > 0, fFormataValor(Venda.fltTotSer, 15, 2),'') + '|';                       // 031 - N - N - 0015,20 - VALOR TOTAL DOS SERVICOS SOB NÃO INCIDENCIA PELO ICMS
  strLinha := strLinha + IIF(Venda.fltTotSer > 0, fFormataValor(Venda.fltTotSer, 15, 2),'') + '|';                       // 032 - N - N - 0015,20 - BASE DE CALCULO DO ISS
  strLinha := strLinha + IIF(Venda.fltTotSer > 0, fFormataValor(Venda.fltValIss, 15, 2),'') + '|';                       // 033 - N - N - 0015,20 - VALOR TOTAL DE ISS
  strLinha := strLinha + '|';                                                                                            // 034 - N - N - 0015,20 - VALOR DO PIS SOBRE SERVICOS
  strLinha := strLinha + '|';                                                                                            // 035 - N - N - 0015,20 - VALOR DO COFINS SOBRE SERVICOS
  strLinha := strLinha + '|';                                                                                            // 036 - N - N - 0015,20 - VALOR RETIDO DO PIS
  strLinha := strLinha + '|';                                                                                            // 037 - N - N - 0015,20 - VALOR RETIDO DO COFINS
  strLinha := strLinha + '|';                                                                                            // 038 - N - N - 0015,20 - VALOR RETIDO DO CSLL
  strLinha := strLinha + '|';                                                                                            // 039 - N - N - 0015,20 - BASE DE CALCULO DO IRRF
  strLinha := strLinha + '|';                                                                                            // 040 - N - N - 0015,20 - VALOR RETIDO DE IRRF
  strLinha := strLinha + '|';                                                                                            // 041 - N - N - 0015,20 - BASE DE CALCULO DA RETENCAO DA PREVIDENCIA SOCIAL
  strLinha := strLinha + '|';                                                                                            // 042 - N - N - 0015,20 - VALOR DA RETENCAO DA PREVIDENCIA SOCIAL
  strLinha := strLinha + '|';                                                                                            // 043 - N - C - 0255,00 - INFORMACOES ADICIONAIS DE INTERESSE DO FISCO

  Try
    If Venda.strOpcDoc = 'NC' Then
    Begin
      strLinha := strLinha + fRetInformacoesAdicionaisNotComp + '|'
    End
    Else
    Begin
      If Venda.strNotImp = 'S' Then
        strLinha := strLinha + fRetInformacoesAdicionaisNotImp + '|'                                                         // 044 - N - C - 4000,00 - INFORMACOES COMPLEMENTARES DE INTERESSE DE CONTRIBUINTE
      Else
        strLinha := strLinha + fRetInformacoesAdicionais() + '|';                                                            // 044 - N - C - 4000,00 - INFORMACOES COMPLEMENTARES DE INTERESSE DE CONTRIBUINTE
    End;
  Except
    Raise ExceptionFalhaNFe.Create('Não foi possivel obter os dados adicionais!');
  End;

//  If Venda.strNotImp = 'S' Then
//    strLinha := strLinha + fRetInformacoesAdicionaisNotImp + '|'                                                         // 044 - N - C - 4000,00 - INFORMACOES COMPLEMENTARES DE INTERESSE DE CONTRIBUINTE
//  Else
//    strLinha := strLinha + fRetInformacoesAdicionais() + '|';                                                            // 044 - N - C - 4000,00 - INFORMACOES COMPLEMENTARES DE INTERESSE DE CONTRIBUINTE

  strLinha := strLinha + '|';                                                                                            // 045 - S - C - 0002,00 - UF DE ONDE OCORRERA O EMBARQUE DOS PRODUTOS
  strLinha := strLinha + '|';                                                                                            // 046 - S - C - 0060,00 - LOCAL ONDE OCORRERA O EMBARQUE DOS PRODUTOS
  strLinha := strLinha + '|';                                                                                            // 047 - N - C - 0017,00 - NOTA DE EMNPENHO
  strLinha := strLinha + '|';                                                                                            // 048 - N - C - 0060,00 - INFORMACAO DO PEDIDO
  strLinha := strLinha + '';                                                                                             // 049 - N - C - 0060,00 - INFORMACAO DO CONTRATO

  Writeln(txtArquivoSaida, strLinha);
  Result := True;
end;

function TNotaFiscalEletronica.fGerarArquivo: Boolean;
  Var
    strNumNf: String;
    strArqNfe: String;
    strArqFinal: String;

  procedure Limpar();
  Begin
    CloseFile(txtArquivoSaida);
    pCriarBackupArquivo(strArqNfe);

    strArqFinal := AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT');
    //RenameFile(strArqNfe, AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT'));
    fRenomearArquivo(strArqNfe, strArqFinal);
  End;
begin
  If Not (Assigned(FItens) And Assigned(FVenda)) Then
  Begin
    pMensagensErro('FItens, FVenda não configurados!', '[TNotaFiscalEletronica.fGerarArquivo]');
    Result := False;
    Exit;
  End;


  { GERACAO DE ARQUIVO TXT (OPHOS) }
  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin

    If Not fFileExists(strPatNfe + '\DataIn') Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', 'Não é possivel encontrar o path ' + strPatNfe + '\DataIn', ['OK']);
      Exit;
    End;

    strNumNf := fStrZero(strNumDoc, 9);
    strArqNfe := strPatNfe + '\DataIn\NFE_ENVI_' + fStrZero(strCodEmp, 2) + '_' + fStrZero(VS_strCodEmp, 3) + '_' + strNumNf + '.CITELNFE';

    pApagaArquivosDataOut(strArqNfe, 'ENVI', 'ENVO');
    
    Try
      CloseFile(txtArquivoSaida);
    Except
      /////Para Nao dar Erro
    End;

    DeleteFile(PChar(strArqNfe));

    Try
      AssignFile(txtArquivoSaida, strArqNfe);
      Rewrite(txtArquivoSaida);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalEletronica.fGerarArquivo]');
      End;
    End;

    If fVerificaNotaJaGerada() Then
    Begin
      Limpar;
      Raise ExceptionFalhaNFe.Create('Essa Nota Fiscal Eletrônica já foi gerada no sistema!');
    End;

    Try
      pCarregaDadosItens();

      Result := fGeraInformacoesNotaFiscalEletronica;
      Result := Result And fGeraIdentificacaoEmitente;
      Result := Result And fGeraIdentificacaoDestinatario;
      Result := Result And fGeraDadosdasDuplicatas;
      Result := Result And fGeraDadosTransportes;
      Result := Result And fGeraDadosVolume;
      Result := Result And fGeraProdutosServicos;
    Except
      On E: Exception Do
      Begin
        CloseFile(txtArquivoSaida);
        DeleteFile(PChar(strArqNfe));
        Raise;
      End;
    End;

    Limpar;
    pGravarLogNFE(GetIPAddressAsString, strArqFinal, strNumDoc, FVenda.strEspDoc, VS_strCodEmp,
      FVenda.strCodCli, FVenda.strSerFsc);

  End

  Else

  { GERACAO DE ARQUIVO XML (SYNCHRO) }
  Begin
    strArqNfe := strPatNfe + '\SAIDA_' + VS_strCodEmp + '_' + Venda.strSerFsc + '_' + strNumDoc + '.XML';

    xmlDoc.Active := True;
    xmlDoc.Version := '1.0';
    xmlDoc.Encoding := 'UTF-8';

    Result := fXmlGeraNFe;
    Result := Result And fXmlGeraDadosNFe;
    Result := Result And fXmlGeraIdentificacaoNFe;
    Result := Result And fXmlGeraIdentificacaoEmitenteNFe;
    Result := Result And fXmlGeraIdentificacaoDestinatarioNFe;
    Result := Result And fXmlGeraDetalhamentoProdutosNFe;
    Result := Result And fXmlGeraValoresTotaisNFe;
    Result := Result And fXmlGeraInformacoesTransporteNFe;

    If Result Then
      xmlDoc.SaveToFile(strArqNfe);
  End;

end;

function TNotaFiscalEletronica.fRetCodigoUfIbge(strCodCid: String): String;
  Var
    qryGen: TUniQuery;
    strAux: String;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Add(' SELECT DISTINCT ');
  qryGen.SQL.Add(' 	LEFT(CID_COIBGE, 2) IBG_CODUF_ '); // O MESMO QUE O CODIGO DO UF
  qryGen.SQL.Add(' FROM  ');
  qryGen.SQL.Add(' 	CADCID ');
  qryGen.SQL.Add(' WHERE ');
  qryGen.SQL.Add(' 	CID_CODCID = :CODCID ');

  qryGen.ParamByName('CODCID').AsString := strCodCid;
  qryGen.Open;

  Result := qryGen.FieldByName('IBG_CODUF_').AsString;

  If (qryGen.IsEmpty) Or (fEmptyStr(qryGen.FieldByName('IBG_CODUF_').AsString)) Then
  Begin
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT DISTINCT  ');
    qryGen.SQL.Add(' 	IBG_CODUF_  ');
    qryGen.SQL.Add(' FROM CADCID INNER JOIN IBG_CADIBG ON CID_NOMCID = IBG_NOMMUN AND CID_ESTADO = IBG_UF ');
    qryGen.SQL.Add(' 	AND CID_ESTADO = IBG_UF  ');
    qryGen.SQL.Add(' WHERE CID_CODCID = :CODCID ');
    qryGen.ParamByName('CODCID').AsString := strCodCid;
    qryGen.Open;

    Result := qryGen.FieldByName('IBG_CODUF_').AsString;
  End
  Else
  Begin
    {********************************************************}
    {* VALIDA O ESTADO DA CIDADE JUNTO COM O CODIGO DO IBGE *}
    {*****************************************************PH*}
    strAux := qryGen.FieldByName('IBG_CODUF_').AsString;

    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT DISTINCT   ');
    qryGen.SQL.Add('   IBG_UF ');
    qryGen.SQL.Add(' FROM IBG_CADIBG ');
    qryGen.SQL.Add(' WHERE IBG_CODUF_ = :CODUF ');
    qryGen.ParamByName('CODUF').AsString := strAux;
    qryGen.Open;

    strAux := qryGen.FieldByName('IBG_UF').AsString;

    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('   CID_CODCID, ');
    qryGen.SQL.Add('   CID_NOMCID, ');
    qryGen.SQL.Add('   CID_ESTADO, ');
    qryGen.SQL.Add('   CID_COIBGE ');
    qryGen.SQL.Add(' FROM CADCID ');
    qryGen.SQL.Add(' WHERE CID_CODCID = :CODCID ');
    qryGen.ParamByName('CODCID').AsString := strCodCid;
    qryGen.Open;

    If qryGen.FieldByName('CID_ESTADO').AsString <>  strAux Then
      Raise ExceptionFalhaNFe.Create(Format('A cidade %s - %s - %s está com o codigo IBGE de outro estado (%s)',
        [qryGen.FieldByName('CID_CODCID').AsString,
        qryGen.FieldByName('CID_NOMCID').AsString,
        qryGen.FieldByName('CID_ESTADO').AsString,
        strAux]));
  End;

  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fRetCodMun(strCodCid: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Add(' SELECT DISTINCT ');
  qryGen.SQL.Add(' 	CID_COIBGE IBG_CODMUN ');
  qryGen.SQL.Add(' FROM  ');
  qryGen.SQL.Add(' 	CADCID ');
  qryGen.SQL.Add(' WHERE ');
  qryGen.SQL.Add(' 	CID_CODCID = :CODCID ');

  qryGen.ParamByName('CODCID').AsString := strCodCid;
  qryGen.Open;

  If (qryGen.IsEmpty) Or (fEmptyStr(qryGen.FieldByName('IBG_CODMUN').AsString)) Then
  Begin
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT DISTINCT  ');
    qryGen.SQL.Add(' 	IBG_CODMUN  ');
    qryGen.SQL.Add(' FROM  ');
    qryGen.SQL.Add(' 	CADCID  ');
    qryGen.SQL.Add(' 	INNER JOIN IBG_CADIBG ON CID_ESTADO = IBG_UF  ');
    qryGen.SQL.Add(' 	AND CID_NOMCID = IBG_NOMMUN  ');
    qryGen.SQL.Add(' WHERE  ');
    qryGen.SQL.Add(' 	CID_CODCID = :CODCID ');

    qryGen.ParamByName('CODCID').AsString := strCodCid;
    qrygen.Open;
  End
  Else
  Begin
    Try
      fRetCodigoUfIbge(strCodCid);
    Except
      Raise;
    End;
  End;


  Result := qryGen.FieldByName('IBG_CODMUN').AsString;
  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fRetDescricaoCfop(strCfop: String): String;
  Var
//    intCfop: Integer;
    qryGen: TUniQuery;
begin

  Result := '';
  qryGen := fCriaQuery(Self);
  strCfop := strCfop + '/';

  While Pos('//', strCfop) > 0 Do
  Begin
    strCfop := AnsiReplaceStr(strCfop, '//', '/');
  End;

  While Not fEmptyStr(strCfop) Do
  Begin
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT CFO_NATOPE FROM CADCFO WHERE CFO_CODCFO = :CFOP';
    qryGen.ParamByName('CFOP').AsString := Copy(strCfop, 1, Pos('/', strCfop) - 1);
    qryGen.Open;
    Result := Result + qryGen.FieldByName('CFO_NATOPE').AsString + '/';
    strCfop := Copy(strCfop, Pos('/', strCfop) + 1, Length(strCfop));
  End;

  Result := Copy(Result, 1, Length(Result) - 1);
  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fGeraIdentificacaoDestinatario: Boolean;
  Var
    strLinha : String;
    strAux,
    strCliNum,
    strCliEnd: String;
    posNum,
    posCom: Integer;
begin
  strLinha := '002' + '|';

  strAux := fLimpaCaracteres(Venda.strCliCgc);
  If fEmptyStr(strAux) Then
  Begin
    raise ExceptionFalhaNFe.Create('CNPJ / CPF do cliente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                                             // 001 - S - C - 014 - NUMERO DO CNPJ

  strAux := IIF(fClienteConsumidor(Venda.strCliOri), Venda.strCliNom, Venda.strCliOri);
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Nome do cliente está em branco!');
  End;

  If fCfgSis('CCLNFE', varBoolean) Then
    strLinha := strLinha + strAux + ' ' + Venda.strCodCli +  '|'                                                                               // 002 - S - C - 060 - RAZAO SOCIAL OU NOME DO DESTINATARIO
  Else
    strLinha := strLinha + strAux +  '|';                                                                                                      // 002 - S - C - 060 - RAZAO SOCIAL OU NOME DO DESTINATARIO

  strCliEnd := Venda.strCliEnd;

  posNum := Pos(Venda.strCliNum,strCliEnd);
  If posNum > 0 Then
    Delete(strCliEnd,posNum,Length(Venda.strCliNum));

  posCom := Pos(Venda.strCliCom,strCliEnd);
  If posCom > 0 Then
    Delete(strCliEnd,posCom,Length(Venda.strCliCom));

  strCliEnd := Trim(strCliEnd);
  While (Not fEmptyStr(strCliEnd)) And CharInSet(RightStr(strCliEnd,1)[1], ['-',',']) Do
  Begin
    Delete(strCliEnd,Length(strCliEnd),1);
    strCliEnd := Trim(strCliEnd);
  End;

  If fEmptyStr(strCliEnd) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Endereço do cliente está em branco!');
  End;
  strLinha := strLinha + strCliEnd + '|';                                                                            // 003 - S - C - 060 - LOGRADOURO DO DESTINATARIO

  strCliNum := Venda.strCliNum;
  If fEmptyStr(strCliNum) Then
    strCliNum := '0';
  strLinha := strLinha + strCliNum + '|';                                                                            // 004 - S - C - 060 - NUMERO DO LOGRADOURO DO DESTINATARIO

  strLinha := strLinha +  Venda.strCliCom + '|';                                                                     // 005 - N - C - 060 - COMPLEMENTO DO LOGRADOURO DO DESTINATARIO

  strAux := Venda.strCliBai;
  If fEmptyStr(Venda.strCliBai) Then
  Begin
    Raise Exception.Create('O bairro do cliente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                                                               // 006 - S - C - 060 - BAIRRO DO LOGRADOURO

  Try

    If Venda.strCliEst = 'EX' Then
      strAux := '9999999'
    Else
      strAux := fRetCodMun(Venda.strCodCid);
      
    If fEmptyStr(strAux) Then
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE da cidade do cliente!');
    End;
  Except
    On E: ExceptionFalhaNFe Do
    Begin
      Raise;
    End;

    On E: Exception Do
    Begin
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter o código IBGE da cidade do cliente!');
    End;

  End;
  strLinha := strLinha + strAux + '|';                                                                   // 007 - S - N - 007 - CODIGO DO MUNICIPIO

  strAux := fRetNomCidade(Venda.strCodCid);
  If fEmptyStr(strAux) Then
  Begin
    raise ExceptionFalhaNFe.Create('Não foi possivel obter o código da cidade do cliente!');
  End;
  strLinha := strLinha + strAux + '|';                                                                // 008 - S - C - 060 - NOME DO MUNICIPIO

  strAux := fRetNomCidade(Venda.strCodCid, 1);
  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNfe.Create('Não foi possivel obter o estado do cliente!');
  End;
  strLinha := strLinha + strAux + '|';                                                             // 009 - S - C - 002 - SIGLA UF

  If Venda.strCliEst = 'EX' Then
    strAux := '00000000'
  Else
    strAux := fLimpaCaracteres(Venda.strCliCep);

  If fEmptyStr(strAux) Then
  Begin
    Raise ExceptionFalhaNFe.Create('Cep do cliente está em branco!');
  End;
  strLinha := strLinha + strAux + '|';                                                             // 010 - N - C - 008 - CEP

  strLinha := strLinha + '|';                                                                                                 // 011 - N - N - 004 - CODIGO DO PAIS
  strLinha := strLinha + '|';                                                                                                 // 012 - N - C - 060 - NOME DO PAIS

  strAux := fLimpaCaracteres(Venda.strCliTel);
  If (Not fEmptyStr(strAux)) And (Length(strAux) < 10) Then
    Raise ExceptionFalhaNFe.Create('O Telefone não está preenchido corretamente (' + strAux + ')!');

  strLinha := strLinha + strAux + '|';                                                        // 013 - N - C - 010 - TELEFONE

  If (fEmptyStr(fLimpaCaracteres(Venda.strCliIes)) Or (fLimpaCaracteres(Venda.strCliIes) = '0')) Then
    strLinha := strLinha + 'ISENTO' + '|'
  Else
    strLinha := strLinha + fLimpaCaracteres(Venda.strCliIes) + '|';                                                           // 014 - S - C - 014 - INSCRICAO ESTADUAL

  strLinha := strLinha + '|';                                                                                                 // 015 - N - C - 009 - INSCRICAO NO SUFRAMA

  If Not fEmptyStr(Venda.strCliEm2) Then
    strLinha := strLinha + LeftStr(Trim(Venda.strCliEma) + ';' + Trim(Venda.strCliEm2), 100) + '|'                            // 016 - N - C - 100 - EMAIL
  Else strLinha := strLinha + LeftStr(Venda.strCliEma, 100) + '|';

  strLinha := strLinha + '';                                                                                                  // 017 - N - C - 060 - NOME FANTASIA

  Writeln(txtArquivoSaida, strLinha);
  Result := True;
end;

function TNotaFiscalEletronica.fLimpaCaracteres(strTexto: String): String;
begin
  Result := fTiraCaracEspeciais(strTexto);

  While Pos('.', Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, '.', '');
  End;

  Result := AnsiReplaceStr(AnsiReplaceStr(Result, '(', ''), ')', '');
end;

function TNotaFiscalEletronica.fGeraDadosdasDuplicatas: Boolean;
  Var
    strLinha : String;
    intCont: Integer;
begin

  {***********************************}
  {* DIFERENTE DE NOTA DE IMPORTAÇÃO *}
  {* E NOTA DE BONIFICAÇÃO           *}
  {********************************AF*}
  If (Venda.strNotImp <> 'S')               And
     (RightStr(Venda.strClaFis,3) <> '910') And
     (fImprimeDuplicatasCnfe)               Then
  Begin

    For intCont := Low(FDuplicatas) To High(FDuplicatas) Do
    Begin
      If Duplicatas[intCont].curValor > 0 Then
      Begin
        If fEmptyStr(arrDuplicata[intCont].dtaDtaVen) Then
          Break;

        strLinha := '004' + '|';
        strLinha := strLinha + strNumDoc + '/' + Duplicatas[intCont].strSequen + '|';                       // 001 - N - C - 060,00 - NUMERO DA DUPLICATA
        strLinha := strLinha + FormatDateTime('yyyymmdd', StrToDate(Duplicatas[intCont].dtaDtaVen)) + '|';  // 002 - N - C - 008,00 - DATA DE VENCIMENTO DA DUPLICATA
        strLinha := strLinha + fFormataValor(Duplicatas[intCont].curValor, 15, 4);                          // 003 - N - N - 015,40 - VALOR DA DUPLICATA
        Writeln(txtArquivoSaida, strLinha);
      End;
    End;
  End;  

  Result := True;
end;

constructor TNotaFiscalEletronica.Create(AOwner: TComponent; strNumDoc: String;
  Itens: TMatrizFechamento; Duplicatas: TDigDuplicArray; Venda: TFatVenda);
begin
  Create(AOwner, strNumDoc);

  FVenda := Venda;
  FItens := fGerarMatrizItensServicos(Itens, Venda);
  FDuplicatas := Duplicatas;

end;

function TNotaFiscalEletronica.GetDuplicata(Index: Integer): TArrDigDuplic;
begin
  If (Index >= 0) And (Index < Length(FDuplicatas)) Then
    Result := FDuplicatas[Index];
end;

function TNotaFiscalEletronica.GetItens(Index: Integer): TDadosFechamento;
begin
  If (Index >= 0) And (Index < Length(FItens)) Then
    Result := FItens[Index]
end;

procedure TNotaFiscalEletronica.SetDuplicata(Index: Integer;
  Duplicata: TArrDigDuplic);
begin
  If (Index >= 0) And (Index < Length(FDuplicatas)) Then
    FDuplicatas[Index] := Duplicata;
end;

procedure TNotaFiscalEletronica.SetItens(Index: Integer;
  DadosFechamento: TDadosFechamento);
begin
  If (Index >= 0) And (Index < Length(FItens)) Then
    FItens[Index] := DadosFechamento;
end;

//function TNotaFiscalEletronica.fRetCliEmail(strCodCli,
//  strTipFc: String): String;
//  Var
//    qryGen: TUniQuery;
//begin
//  qryGen := fCriaQuery(Self);
//
//  If strTipFc = 'F' Then
//    qryGen.Sql.Text := 'SELECT FOR_EMAIL_ AS CLI_EMAIL_ FROM CADFOR WHERE FOR_CODFOR = :CODFOR'
//  Else
//    qryGen.SQL.Text := 'SELECT CLI_EMAIL_ FROM CADCLI WHERE CLI_CODCLI = :CODFOR';
//
//  qryGen.ParamByName('CODFOR').AsString := strCodCli;
//  qryGen.Open;
//  Result := qryGen.FieldByName('CLI_EMAIL_').AsString;
//  FreeAndNil(qryGen);
//end;

function TNotaFiscalEletronica.fGeraDadosTransportes: Boolean;
  Var
    strLinha : String;
begin
  pRecarregaTransportadora();

  strLinha := '006' + '|';

  strLinha := strLinha + IntToStr(StrToIntDef(Venda.strTipFre, 0) - 1) + '|'; // 001 - S - N - 001,00 - MODALIDADE DO FRETE
  strLinha := strLinha + RightStr(Venda.strCgcTra, 14) + '|';           // 002 - N - C - 014,00 - CNPJ/CPF DO TRANSPOTADOR
  strLinha := strLinha + RightStr(Venda.strNomTra, 60) + '|';           // 003 - N - C - 060,00 - RAZAO SOCIAL OU NOME
  strLinha := strLinha + RightStr(Venda.strIesTra, 14) + '|';           // 004 - N - C - 014,00 - INSCRICAO ESTADUAL
  strLinha := strLinha + RightStr(Venda.strEndTra, 60) + '|';           // 005 - N - C - 060,00 - ENDERECO COMPLETO
  strLinha := strLinha + RightStr(Venda.strCidTra, 60) + '|';           // 006 - N - C - 060,00 - NOME DO MUNICIPIO
  strLinha := strLinha + RightStr(Venda.strEstTra, 02) + '|';           // 007 - N - C - 002,00 - SIGLA UF
  strLinha := strLinha + '|';                                           // 008 - S - N - 015,20 - VALOR DO SERVICO
  strLinha := strLinha + '|';                                           // 009 - S - N - 015,20 - BC DA RETENCAO DO ICMS
  strLinha := strLinha + '|';                                           // 010 - S - N - 005,20 - ALIQUOTA DA RETENCAO DO ICMS
  strLinha := strLinha + '|';                                           // 011 - S - N - 015,20 - VALOR DO ICMS RETIDO
  strLinha := strLinha + '|';                                           // 012 - S - N - 004,00 - CODIGO FISCAL DE OPRACAO E PRESTACOES
  strLinha := strLinha + '|';                                           // 013 - S - N - 007,00 - CODIGO DO MUNICIPIO DE OCORRENCIA IBGE
  strLinha := strLinha + '|';                                           // 014 - S - C - 008,00 - PLACA DO VEICULO
  strLinha := strLinha + '|';                                           // 015 - S - C - 002,00 - UF
  strLinha := strLinha + '';                                            // 016 - N - C - 020,00 - REGISTRO NACIONAL DE TRANSPORTE DE CARGA (ANTT)

  Writeln(txtArquivoSaida, strLinha);
  Result := True;
end;

function TNotaFiscalEletronica.fGeraDadosVolume: Boolean;
  Var
    strLinha : String;
begin
  strLinha := '008' + '|';
  strLinha := strLinha + IntToStr(Venda.intQtdTra) + '|';             // 001 - N - N - 015,00 - QUANTIDADE DE VOLUMES TRANPORTADOS
  strLinha := strLinha + Venda.strEspTra + '|';                       // 002 - N - C - 060,00 - ESPECIE DOS VOLUMES TRANSPORTADOS
  strLinha := strLinha + Venda.strMarTra + '|';                       // 003 - N - C - 060,00 - MARCA DOS VOLUMES TRANSPORTADOS
  strLinha := strLinha + '' + '|';                                    // 004 - N - C - 060,00 - UMERACAO DOS VOLUMES TRANSPORTADOS

  If fFormataFloat(Venda.fltPesLiq,2) <= 0 Then
    strLinha := strLinha + fFormataValor(Venda.fltPesBru, 15, 3) + '|'  // 005 - N - N - 015,30 - PESO LIQUIDO (EM KG)
  Else
    strLinha := strLinha + fFormataValor(Venda.fltPesLiq, 15, 3) + '|'; // 005 - N - N - 015,30 - PESO LIQUIDO (EM KG)

  strLinha := strLinha + fFormataValor(Venda.fltPesBru, 15, 3);       // 006 - N - N - 015,30 - PESO BRUTO (EM KG)

  Writeln(txtArquivoSaida, strLinha);
  Result := True;
end;

function TNotaFiscalEletronica.fGeraProdutosServicos: Boolean;
  Var
    strLinha : String;
    intCont: Integer;
    strSitTrib: String;
    strSigUni,
    strCodIte,
    strAnotacoes: String;
    strCodFab   : String;

    fltBasPisCof: Double;
    fltAlqPisLiv: Double;
    fltAlqCofLiv: Double;

    Procedure pTrataAnotacoes;
    Begin
      strAnotacoes := '';

      If Not fEmptyStr(Itens[intCont].strDesNes) Then
      Begin
        strAnotacoes := AnsiReplaceText(Itens[intCont].strDesNes, #13#10, ' ');
      End

      Else
      Begin
        If fCfgSis('NFEFAB', varBoolean) Then
        Begin
          strCodFab := fRetCodFabrica(Itens[intCont].strCodIte);
          If Not fEmptyStr(strCodFab) Then
            strAnotacoes := ' COD.FABRICA: ' +  strCodFab;

          If Not fEmptyStr(strAnotacoes) Then
            strAnotacoes := strAnotacoes + ' - ';

           strAnotacoes := strAnotacoes + 'MARCA: ' + fRetNomMarca(Itens[intCont].strCodMar);
        End;

        If fCfgSis('NFEMFI', varBoolean) Then
        Begin
          If Not fEmptyStr(Itens[intCont].strMenFis) Then
          Begin
            If Not fEmptyStr(strAnotacoes) Then
              strAnotacoes := strAnotacoes + ' - ';

            strAnotacoes := strAnotacoes + ' ' + Itens[intCont].strMenFis;
          End;
        End;
      End;

      If Not fEmptyStr(Itens[intCont].strNumLot) then
      Begin
        If Not fEmptyStr(strAnotacoes) Then
          strAnotacoes := strAnotacoes + ' - ';
        strAnotacoes := strAnotacoes + 'LOTE: ' + Itens[intCont].strNumLot;
      End;

      {*****************************************}
      {* ACRESCENTA O COMPLEMENTO DA DESCRIÇÃO *}
      {* DO PRODUTO NA NOTA FISCAL ELETRONICA  *}
      {**************************************PE*}
      If Not fEmptyStr(Itens[intCont].strComple) Then
      Begin
        strAnotacoes := AnsiReplaceText(Itens[intCont].strComple, #13#10, ' ');
      End;

      strAnotacoes := LeftStr(strAnotacoes, 500);
    End;

begin

  fltAlqPisLiv := fCfgSis('ALPISP', varDouble);
  fltAlqCofLiv := fCfgSis('ALCOFP', varDouble);

  For intCont := Low(FItens) To High(FItens) Do
  Begin

    fltBasPisCof := Itens[intCont].fltTotIte - Itens[intCont].fltDesEsp;

    strLinha := '014' + '|';
    strLinha := strLinha + IntToStr(intCont + 1) + '|';                                                                      //001 - S - N - 003,00-NUMERO DO ITEM

    If fCfgSis('NFEITE') = '1' Then
      strCodIte := Itens[intCont].strCodIte
    Else
      strCodIte := fRetCodFabrica(Itens[intCont].strCodIte);

    If fEmptyStr(strCodIte) Then
      strCodIte := Itens[intCont].strCodIte;

    pTrataAnotacoes;
      
    strLinha := strLinha + strCodIte + '|';                                                                                  //002 - S - C - 060,00-CODIGO DO PRODUTO OU SERVICO
    strLinha := strLinha + fRetCodBarra(Itens[intCont].strCodIte) + '|';                                                                                              //003 - S - C - 014,00-GTIN DO PRODUTO

    If fCfgSis('DESFAB') = 'S' Then
    Begin                                                                                                                   //004 - S - C - 120,00-DESCRICAO DO PRODUTO OU SERVICO
      strLinha := strLinha + Itens[intCont].strDesIte + ' ' + Itens[intCont].strComple + '|';
    End
    Else
    Begin
      If  Not fEmptyStr(Itens[intCont].strDesFab) Then
        strLinha := strLinha + Itens[intCont].strDesFab + '|'
      Else
        strLinha := strLinha + Itens[intCont].strDesIte + ' ' + Itens[intCont].strComple + '|';
    End;

    strLinha := strLinha + LeftStr(fLimpaCaracteres(Itens[intCont].strClaIpi), 8) + '|';                                     //005 - N - C - 008,00-CODIGO NCM
    strLinha := strLinha + '|';                                                                                              //006 - N - C - 003,00-CODIGO EX TIPI
    strLinha := strLinha + '|';                                                                                              //007 - N - C - 002,00-GENERO DO PRODUTO OU SERVICO
    strLinha := strLinha + Itens[intCont].strClaFis + '|';                                                                   //008 - S - N - 004,00-CODIGO FISCAL DE OPERACOES E PRESTACOES

    strSigUni := fRetSiglaUnidade(Itens[intCont].strCodUni);

    If fEmptyStr(strSigUni) Then
    Begin
      Raise ExceptionFalhaNFe.Create(Format('Unidade do item %s está em branco',[Itens[intCont].strCodIte]));
    End;
    strLinha := strLinha + strSigUni + '|';                                                                                     //009 - S - C - 006,00-UNIDADE COMERCIAL

    strLinha := strLinha + fFormataValor(Itens[intCont].fltQtdIte, 12, 4) + '|';                                             //010 - S - N - 012,40-QUANTIDADE COMERCIAL
    strLinha := strLinha + fFormataValor(Itens[intCont].fltUniTar, 16, 4) + '|';                                             //011 - S - N - 016,40-VALOR UNITARIO DO PRODUTO
    strLinha := strLinha + fFormataValor(Itens[intCont].fltTotIte, 15, 2) + '|';                                             //012 - S - N - 015,20-VALOR BRUTO                                                                                                     5
    strLinha := strLinha + fStrZero(Itens[intCont].strCodIte, 08) + '|';                                                     //013 - S - C - 014,00-GTIN DA UNIDADE TRIBUTAVEL

    strLinha := strLinha + IfThen(fCfgSis('SIMPAU') = 'S', strSigUni, strSigUni) + '|';                                             //014 - S - C - 006,00-UNIADE TRIBUTAVEL

    strLinha := strLinha + IfThen(fCfgSis('SIMPAU') = 'S', '00000', fFormataValor(Itens[intCont].fltQtdIte, 12, 4)) + '|';   //015 - S - N - 012,40-QUANTIDADE TRIBUTAVEL
    strLinha := strLinha + IfThen(fCfgSis('SIMPAU') = 'S', '00000', fFormataValor(Itens[intCont].fltUniTar, 16, 4)) + '|';   //016 - S - N - 016,40-VALOR UNITARIO DE TRIBUTACAO
    strLinha := strLinha + '|';                                                                                              //017 - N - N - 015,20-VALOR TOTAL DO FRETE
    strLinha := strLinha + '|';                                                                                              //018 - N - N - 015,20-VALOR TOTAL DO SEGURO
    strLinha := strLinha + '|';                                                                                              //019 - N - N - 015,20-VALOR DO DESCONTO
    strLinha := strlinha + fRetModadalidadeIcms(Itens[intCont].strCodSit) + '|';                                             //020 - S - N - 002,00 - MODALIDADE DO ICMS
    strLinha := strLinha + fRetLinhaST(Itens[intCont].strCodSit, intCont) {+ '|'};
    strLinha := strLinha + '|';                                                                                              // 084 - N - C - 005,00 - CLASSE DE ENQUADRAMENTO DO IPI PARA CIGARROS E BEBIDAS
    strLinha := strLinha + '|';                                                                                              // 085 - N - C - 014,00 - CNPJ DO PRODUTO DA MERCADORIA
    strLinha := strLinha + '|';                                                                                              // 086 - N - C - 010,00 - CODIGO DO SELO DE CONTROLE DO IPI
    strLinha := strLinha + '|';                                                                                              // 087 - N - N - 012,00 - QUANTIDADE DE SELO DE CONTROLE DO IPI
    strLinha := strLinha + '999' + '|';                                                                                      // 088 - S - C - 003,00 - CODIGO DE ENQUADRAMENTO LEGAL DE IPI

    strSitTrib := fRetSituacaoTributaria(Itens[intCont].strClaFis, intCont);                                                 // 089 - S - N - 001,00 - SITUACAO TRIBUTARIA DO IPI
    strLinha := strLinha + fRetValoresSituacaoTrinbutarias(strSitTrib, intCont) ;

    strLinha := strLinha + '|';                                                                                              // 095 - S - N - 015,20 - BASE BC IMPOSTO IMPORTACAO
    strLinha := strLinha + '|';                                                                                              // 096 - S - N - 015,20 - VALOR DESPESAS ADUANEIRAS
    strLinha := strLinha + '|';                                                                                              // 097 - S - N - 015,20 - VALOR DO IMPOSTO IMPORTACAO
    strLinha := strLinha + '|';                                                                                              // 098 - S - N - 015,20 - VALOR DO IMPOSTO SOBRE OPERACOES FINANCEIRAS

    If (Itens[intCont].strIncPis = 'S') Then
    Begin
      strLinha := strLinha + '0' + '|';                                                                                      // 099 - S - N - 001,00 - SITUACAO TRIBUTARIA DO PIS
      strLinha := strLinha + fFormataValor(fltBasPisCof, 15, 2) + '|';                                                       // 100 - S - N - 015,20 - VALOR DA BC DO PIS
      strLinha := strLinha + fFormataValor(fltAlqPisLiv, 5, 2) +  '|';                                                       // 101 - S - N - 005,20 - ALIQUOTA DO PIS (EM PERCENTUAL)
      strLinha := strLinha + fFormataValor(fltBasPisCof*fltAlqPisLiv/100, 15, 2) + '|';                                      // 102 - S - N - 015,20 - VALOR DO PIS
    End
    Else
    Begin
      strLinha := strLinha + '5' + '|';                                                                                      // 099 - S - N - 001,00 - SITUACAO TRIBUTARIA DO PIS
      strLinha := strLinha + '|';                                                                                            // 100 - S - N - 015,20 - VALOR DA BC DO PIS
      strLinha := strLinha + '|';                                                                                            // 101 - S - N - 005,20 - ALIQUOTA DO PIS (EM PERCENTUAL)
      strLinha := strLinha + '|';                                                                                            // 102 - S - N - 015,20 - VALOR DO PIS
    End;

    strLinha := strLinha + '|';                                                                                              // 103 - S - N - 015,20 - QUANTIDADE VENDIDA
    strLinha := strLinha + '|';                                                                                              // 104 - S - N - 015,20 - ALIQUOTA PIS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 105 - S - N - 015,20 - VALOR DO PIS
    strLinha := strLinha + '|';                                                                                              // 106 - S - N - 015,20 - VALOR DO BC DO PIS
    strLinha := strLinha + '|';                                                                                              // 107 - S - N - 005,20 - ALIQUOTA DO PIS EM PROCENTAGEM
    strLinha := strLinha + '|';                                                                                              // 108 - S - N - 015,20 - QUANTIDADE VENDIDA
    strLinha := strLinha + '|';                                                                                              // 109 - S - N - 015,40 - ALIQUOTA DO PIS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 110 - S - N - 015,20 - VALOR DO PIS
    strLinha := strLinha + '|';                                                                                              // 111 - S - N - 015,20 - VALOR DO BC DO PIS ST
    strLinha := strLinha + '|';                                                                                              // 112 - S - N - 005,20 - ALIQUOTA DO PIS ST
    strLinha := strLinha + '|';                                                                                              // 113 - S - N - 016,40 - QUANTIDADE VENDIDA
    strLinha := strLinha + '|';                                                                                              // 114 - S - N - 015,40 - ALIQUOTA DO PIS ST (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 115 - S - N - 015,20 - VALOR DO PIS ST

    If (Itens[intCont].strIncPis = 'S') Then
    Begin
      strLinha := strLinha + '0' + '|';                                                                                      // 116 - S - N - 001,00 - SITUACAO TRIBUTARIA COFINS
      strLinha := strLinha + fFormataValor(fltBasPisCof, 15, 2) + '|';                                                       // 117 - S - N - 015,20 - VALOR DA BASE DE CALCULO DO COFINS
      strLinha := strLinha + fFormataValor(fltAlqCofLiv, 5, 2) +  '|';                                                       // 118 - S - N - 005,20 - ALIQUOTA DO COFINS
      strLinha := strLinha + fFormataValor(fltBasPisCof*fltAlqCofLiv/100, 15, 2) + '|';                                      // 119 - S - N - 015,20 - VALOR DO COFINS
    End
    Else
    Begin
      strLinha := strLinha + '5' + '|';                                                                                      // 116 - S - N - 001,00 - SITUACAO TRIBUTARIA COFINS
      strLinha := strLinha + '|';                                                                                            // 117 - S - N - 015,20 - VALOR DA BASE DE CALCULO DO COFINS
      strLinha := strLinha + '|';                                                                                            // 118 - S - N - 005,20 - ALIQUOTA DO COFINS
      strLinha := strLinha + '|';                                                                                            // 119 - S - N - 015,20 - VALOR DO COFINS
    End;

    strLinha := strLinha + '|';                                                                                              // 120 - S - N - 016,40 - QUANTIDADE VENDIDA
    strLinha := strLinha + '|';                                                                                              // 121 - S - N - 015,40 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 122 - S - N - 015,20 - VALOR DO COFINS
    strLinha := strLinha + '|';                                                                                              // 123 - S - N - 015,20 - VALOR DA BASE DE CALCULO DO COFINS
    strLinha := strLinha + '|';                                                                                              // 124 - S - N - 005,20 - ALIQUOTA DO COFINS (EM PERCENTUAL)
    strLinha := strLinha + '|';                                                                                              // 125 - S - N - 015,20 - VALOR DO COFINS
    strLinha := strLinha + '|';                                                                                              // 126 - S - N - 015,20 - QUANTIDADE VENDIDA
    strLinha := strLinha + '|';                                                                                              // 127 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 128 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 129 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 130 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 131 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 132 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 133 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 134 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 135 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 136 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + '|';                                                                                              // 137 - S - N - 015,20 - ALIQUOTA DO COFINS (EM REAIS)
    strLinha := strLinha + strAnotacoes;                                                                                     // 138 -         500    - ANOTACOES

    Writeln(txtArquivoSaida, strLinha);
  End;

  Result := True;
end;

function TNotaFiscalEletronica.fRetModadalidadeIcms(
  strCodSit: String): String;
  Const
    arrCodigos: Array[0..9] Of String =
      ('00', '10', '20', '30', '40', '41', '50', '51', '60', '70');
  Var
    intCont: Integer;
begin

  For intCont := 0 To 9 Do
  Begin
    If arrCodigos[intCont] =  RightStr(strCodSit, 2) Then
    Begin
      Result := IntToStr(intCont);

//      If fCfgSis('SIMPAU') = 'S' Then
//        Result := '5';

      Exit;
    End;
  End;

  Result := '10';
end;

function TNotaFiscalEletronica.fRetLinhaST(strCodSit: String; intItemIndex: Integer): String;
  var
    strRetorno: String;
begin
  strRetorno := fRetModadalidadeIcms(strCodSit);

  {**************************************************}
  {* QUANDO SIMPLES NACIONAL NAO SERA TRIBUTADA (5) *}
  {***********************************************PH*}
//  If fCfgSis('SIMPAU', varBoolean) Then
//    StrRetorno := '5';

  Result := '';

  If strRetorno = '0' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                               //021-S-N-001,00-ORIGEM DA MERCADORIA
    Result := Result + '0' + '|';                                                                                           //022-S-N-001,00-MODALIDADE DA BC DO ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2)) + '|';     //023-S-N-015,20-VALOR DA BC DO ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2)) + '|';     //024-S-N-005,20-ALIQUOTA ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltValIcm, 15, 2)) + '|';     //025-S-N-015,20-VALOR DO ICMS
  End
  Else
    Result := Result + fReplicatorStr('|', 05);

  If strRetorno = '1' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                                                              //026-S-N-001,00-ORIGEM DA MERCADORIA
    Result := Result + '0' + '|';                                                                                                                                          //027-S-N-001,00-MODALIDADE DA BC DO ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2)) + '|';                                                    //028-S-N-015,20-VALOR DA BC DO ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2)) + '|';                                                    //029-S-N-005,20-ALIQUOTA ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltValIcm, 15, 2)) + '|';                                                    //030-S-N-015,20-VALOR DO ICMS
    Result := Result + '4' + '|';                                                                                                                                          //031-S-N-001,00-MODALIDADE DA BC DO ICMS
    Result := Result + '|';                                                                                                                                                //032-N-N-005,20-PERCENTUAL DA MARGEM DE VALOR ADICIONADO ICMS ST
    Result := Result + '|';                                                                                                                                                //033-N-N-005,20-PERCENTUAL DE REDUCAO DA BC ICMS ST
    Result := Result + fFormataValor(IfThen(Itens[intItemIndex].fltBasRet <= 0, 0, Itens[intItemIndex].fltBasRet), 15, 2) + '|';                                           //034-S-N-015,20-VALOR DA BC DO ICMS ST
    Result := Result + fFormataValor(IfThen(Itens[intItemIndex].fltBasRet <= 0, 0, Itens[intItemIndex].fltAlqRet), 05, 2) + '|';                                           //035-S-N-005,20-ALIQUOTA ICMS ST
    Result := Result + fFormataValor(IfThen(Itens[intItemIndex].fltBasRet <= 0, 0, Itens[intItemIndex].fltValRet), 15, 2) + '|';                                           //036-S-N-015,20-VALOR ICMS ST
  End
  Else
    Result := Result + fReplicatorStr('|', 11);

  If strRetorno = '2' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      //037 - S - N - 001,00-ORIGEM DA MERCADORIA
    Result := Result + '0' + '|';                                                                                                  //038 - S - N - 001,00-MODALIDADE DE DETERMINACAO DA BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2)) + '|';            //039 - S - N - 015,20-VALOR DA BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2)) + '|';            //040 - S - N - 005,20-ALIQUOTA ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltValIcm, 15, 2)) + '|';            //041 - S - N - 015,20-VALOR ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltPerRed, 05, 2)) + '|';            //042 - S - N - 005,20-PERCENTUAL DE REDUCAO DA BC
  End
  Else
    Result := Result + fReplicatorStr('|', 06);

  If strRetorno = '3' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      //043 - S - N - 001,00-ORIGEM DA MERCADORIA
    Result := Result + '4' + '|';                                                                                                  //044 - S - N - 001,00-MODALIDADE DA BC DO ICMS ST
    Result := Result + '|';                                                                                                        //045 - N - N - 005,20-PERCENTUAL DE MARGEM ADICIONADO ICMS ST
    Result := Result + '|';                                                                                                        //046 - N - N - 005,20-PERCENTUAL DA REDUCAO DA BC ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltBasRet, 15, 2)) + '|'; //047 - S - N - 015,20-VALOR DA BC ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltAlqRet, 05, 2)) + '|'; //048 - S - N - 005,20-ALIQUOTA ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltValRet, 15, 2)) + '|'; //049 - S - N - 015,20-VALOR ICMS ST
  End
  Else
    Result := Result + fReplicatorStr('|', 07);

  If (Pos(strRetorno, '_4_5_6_') > 0) Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      // 050 - S - N - 001,00 - ORIGEM DA MERCADORIA
  End
  Else
    Result := Result + '|';


  If strRetorno = '7' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      // 051 - S - N - 001,00 - ORIGEM DA MERCADORIA
    Result := Result + '0' + '|';                                                                                                  // 052 - S - N - 001,00 - MODALIDADE BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2)) + '|';            // 053 - S - N - 015,20 - VALOR BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2)) + '|';            // 054 - S - N - 005,20 - ALIQUOTA ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltValIcm, 15, 2)) + '|';            // 055 - S - N - 015,20 - VALOR ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltPerRed, 05, 2)) + '|';            // 056 - S - N - 005,20 - PERCENTUAL REDUCAO BC

  End
  Else
    Result := Result + fReplicatorStr('|', 06);

  If strRetorno = '8' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      // 057 - S - N - 001,00 - ORIGEM DA MERCADORIA
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasRet, 15, 2)) + '|';                                                  // 058 - S - N - 015,20 - VALOR BC ICMS ST
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fformataValor(Itens[intItemIndex].fltValRet, 15, 2)) + '|';                                                  // 059 - S - N - 015,20 - VALOR ICMS ST
  End
  Else
    Result := Result + fReplicatorStr('|', 03);

  If strRetorno = '9' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      // 060 - S - N - 001,00 - ORIGEM DA MERCADORIA
    Result := Result + '0' + '|';                                                                                                  // 061 - S - N - 001,00 - MODALIDADE BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2)) + '|';            // 062 - S - N - 015,20 - VALOR DA BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2)) + '|';            // 063 - S - N - 005,20 - ALIQUOTA ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltValIcm, 15, 2)) + '|';            // 064 - S - N - 015,20 - VALOR ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltPerRed, 15, 2)) + '|';            // 065 - S - N - 005,20 - PERCENTUAL DE REDUCAO BC
    Result := Result + '0' + '|';                                                                                                  // 066 - S - N - 001,00 - MODALIDADE BC ICMS ST
    Result := Result + '|';                                                                                                        // 067 - N - N - 005,20 - PERCENTUAL MARGEM VALOR ADICIONADO ICMS ST
    Result := Result + '|';                                                                                                        // 068 - N - N - 005,20 - PERCENTUAL REDUCAO BC ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltBasRet, 15, 2)) + '|'; // 069 - S - N - 015,20 - VALOR BC ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltAlqRet, 05, 2)) + '|'; // 070 - S - N - 005,20 - ALIQUOTA ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltValRet, 15, 2)) + '|'; // 071 - S - N - 015,20 - VALOR ICMS ST
  End
  Else
    Result := Result + fReplicatorStr('|', 12);

  If strRetorno = '10' Then
  Begin
    Result := Result + fRetOrigemMercadoria(strCodSit) + '|';                                                                      // 072 - S - N - 001,00 - ORIGEM DA MERCADORIA
    Result := Result + '0' + '|';                                                                                                  // 073 - S - N - 001,00 - MODALIDADE BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2)) + '|';            // 074 - S - N - 015,20 - VALOR BC ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2)) + '|';            // 075 - S - N - 005,20 - ALIQUOTA ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltValIcm, 15, 2)) + '|';            // 076 - S - N - 015,20 - VALOR ICMS
    Result := Result + IfThen(fCfgSis('SIMPAU') = 'S', '0', fFormataValor(Itens[intItemIndex].fltPerRed, 05, 2)) + '|';            // 077 - S - N - 005,20 - PERCENTUAL REDUCAO DA BC
    Result := Result + '0' + '|';                                                                                                  // 078 - S - N - 001,00 - MODALIDADE BC ICMS ST
    Result := Result + '|';                                                                                                        // 079 - N - N - 005,20 - PERCENTUAL MARGEM VALOR ADICIONADO ICMS ST
    Result := Result + '|';                                                                                                        // 080 - N - N - 005,20 - PERCENTUAL DE REDUCAO BC ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltBasRet, 15, 2)) + '|'; // 081 - S - N - 015,20 - VALOR BC ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltAlqRet, 05, 2)) + '|'; // 082 - S - N - 005,20 - ALIQUOTA ICMS ST
    Result := Result + IfThen(Itens[intItemIndex].fltBasRet <= 0, '0', fFormataValor(Itens[intItemIndex].fltValRet, 15, 2)) + '|'; // 083 - S - N - 015,20 - VALOR ICMS ST
  End
  Else
    Result := result + fReplicatorStr('|', 12);

End;

function TNotaFiscalEletronica.fRetSituacaoTributaria(
  strClaFis: String; ItemIndex: Integer): String;
begin

  If (StrToIntDef(LeftStr(strClaFis, 1),0) < 5) Then
  Begin
    Result := '3';

    If Itens[ItemIndex].fltValipi <> 0 Then
      Result := '0'
  End
  Else
  Begin
    Result := '10';

    If Itens[ItemIndex].fltValipi <> 0 Then
      Result := '7'
  End;


end;

function TNotaFiscalEletronica.fRetEntradaSaida(strClaFis: String): String;
begin
  If StrToIntDef(strClaFis, 0) < 5000 Then
    Result := 'E'
  Else
    Result := 'S';
end;

function TNotaFiscalEletronica.fProcessarRetorno: Boolean;
  Var
    intEspera: Integer;
    intStatus: Integer;

    strArquivo: String;
    strNumNf: String;

    strArqCop: String;

    procedure Limpar();
    Begin
      DeleteFile(PChar(strArquivo));
      DeleteFile(PChar(strArqCop));
    End;
begin
  intEspera := fCfgSis('NFEESP', varInteger);
  strNumNf := fStrZero(strNumDoc, 9);

  If Not fCfgSis('NFEXML', varBoolean) Then
    strArquivo := strPatNfe + '\DataOUT\NFE_ENVO_' + fStrZero(strCodEmp, 2) + '_' + fStrZero(VS_strCodEmp, 3) + '_' + strNumNf + '.TXT'
  Else
    strArquivo := strPatNfe + '\RETORNO_' +  VS_strCodEmp + '_' + Venda.strSerFsc + '_' + strNumDoc + '.XML';

  Try
    While True Do
    Begin
      Sleep(intEspera * 400);

      If (fFileExists(strArquivo)) And (fArquivoPronto(strArquivo)) Then
      Begin
        CopyFile(PChar(strArquivo), PChar(AnsiReplaceStr(strArquivo, ExtractFileExt(strArquivo), '.CITELNFE')), False);
        pCriarBackupArquivo(strArquivo);
        strArqCop := AnsiReplaceStr(strArquivo, ExtractFileExt(strArquivo), '.CITELNFE');

        intStatus := fRetStatusRetorno(strArqCop);

        Case intStatus Of
          1:
            Begin
              Result := True;
              StrChaveAcesso := fRetChaveAcesso(strArqCop);

              If (Not fEmptyStr(StrChaveAcesso)) And (fVerificaNotaJaRetornada) Then
              Begin
                Raise ExceptionNFeJaRetornarda.Create(Format('Já existe uma nota fiscal eletrônica com essa chave de acesso: %s ', [StrChaveAcesso]));
              End;

              StrNumeroProtocolo := fRetProtocolo(strArqCop);
              StrRetorno := fRetMensagemRetorno(strArqCop) + #13#10 + ' Número da Nota Fiscal: ' + strNumDoc;
              Limpar;
              Exit;
            End;
          22, 23, 24, 11:
            Begin
              StrRetorno := fRetMensagemRetorno(strArqCop);
              Continue;
            End;
          Else
            Begin
              Result := False;
              StrRetorno := fRetMensagemRetorno(strArqCop);

              pDeletarLogNFE;

              Limpar;
              Exit;
            End;
        End;
      End;

      Application.ProcessMessages;
    End;
  Except
    On E: Exception Do
    Begin
      pDeletarLogNFE;
      Raise;
    End;
  End;
end;

function TNotaFiscalEletronica.fRetStatusRetorno(
  strArquivo: String): Integer;
  Var
    txtArquivo: TextFile;
    strLinha: String;
    intCont: Integer;

    xmlRetorno: TXMLDocument;
    strRetorno: String;
begin

  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin
    Try
      AssignFile(txtArquivo, strArquivo);
      Reset(txtArquivo);
    Except
      Result := 24;
      Exit;
    End;
    Readln(txtArquivo, strLinha);

    For intCont := 1 To 4 Do
    Begin
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));
    End;
    strLinha := Copy(strLinha, 1, Pos('|', strLinha) - 1);

    Result := StrToIntDef(strLinha,0);
    CloseFile(txtArquivo);
  End
  Else
  Begin
    If Not fFileExists(strArquivo) Then
    Begin
      Result := 2;
      Exit;
    End;

    Try
      xmlRetorno := TXMLDocument.Create(Self);
      xmlRetorno.FileName := strArquivo;
      xmlRetorno.Active := True;
    Except
      Result := 3;
      Exit;
    End;

    strRetorno := xmlRetorno.Node.ChildNodes.FindNode('resNFe').ChildNodes.FindNode('codSitucao').Text;

    If (StrToIntDef(RightStr(strRetorno, 3),0) < 53) Then
      Result := 1
    Else
      Result := 3;

  End;


end;


constructor TNotaFiscalEletronica.Create(AOwner: TComponent;
  strNumDoc: String);
begin
  inherited Create(AOwner);
  strPatNfe := fCfgSis('NFEPAT');
  strCodEmp := fCfgSis('NFEEMP');
  //strSeriNf := fCfgSis('SERFSC');
  Self.strNumDoc := strNumDoc;

  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.SQL.Text := 'SELECT * FROM CADEMP WHERE EMP_CODEMP = :CODEMP';
  qryCadEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadEmp.Open;

  If fCfgSis('NFEXML', varBoolean) Then
  Begin
    xmlDoc := TXMLDocument.Create(Self);
    xmlDoc.Options := [doNodeAutoCreate,doNodeAutoIndent,doAutoPrefix,doNamespaceDecl];
  End;

  StrRetorno := '';
  StrChaveAcesso := '';
  StrNumeroProtocolo := '';
end;

function TNotaFiscalEletronica.fCancelarNotaFiscal: Boolean;
  Var
    strNumNf: String;
    strArqNfe: String;
    strArqFinal: String;

  procedure Limpar();
  Begin
    CloseFile(txtArquivoSaida);
    pCriarBackupArquivo(strArqNfe);

    strArqFinal := AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT');
    //RenameFile(strArqNfe, AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT'));
    fRenomearArquivo(strArqNfe, strArqFinal);
  End;
begin
  strNumNf := fStrZero(strNumDoc, 9);

  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin
    strArqNfe := strPatNfe + '\DataIn\NFE_CANI_' + fStrZero(strCodEmp, 2) + '_' + fStrZero(VS_strCodEmp, 3) + '_' + strNumNf + '.CITELNFE';

    pApagaArquivosDataOut(strArqNfe, 'CANI', 'CANO');

    If Not fFileExists(strPatNfe + '\DataIn') Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', 'Não é possivel encontrar o path ' + strPatNfe + '\DataIn', ['OK']);
      Exit;
    End;

    Try
      AssignFile(txtArquivoSaida, strArqNfe);
      Rewrite(txtArquivoSaida);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalEletronica.fCancelarNotaFiscal]');
      End;
    End;

    Result := fGeraDadosCancelamento;
    Limpar();
  End
  Else
  Begin
    strArqNfe := strPatNfe + '\CANCELAMENTO_' + VS_strCodEmp + '_' + Venda.strSerFsc + '_' + strNumDoc + '.XML';
    Result := fXmlGeraDadosCancelamento(strArqNfe);
  End;

end;

function TNotaFiscalEletronica.fGeraDadosCancelamento: Boolean;
  Var
    strLinha: String;
begin
  strLinha := '001' + '|';
  strLinha := strLinha + qryCadEmp.FieldByName('EMP_C_G_C_').AsString + '|';

  strLinha := strLinha + strNumDoc + '|';
  strLinha := strLinha + strNumDoc + '|';
  strLinha := strLinha + fRetNumSerie + '|';
  strLinha := strLinha + Format('Cancelamento da Nota Fiscal %s. Motivo: %s', [strNumDoc, FStrMotivoCancelamento]) + '|';
  strLinha := strLinha + fCfgSis('NFEEMP');

  Writeln(txtArquivoSaida, strLinha);
  Result := True;
end;


constructor TNotaFiscalEletronica.Create(AOwner: TComponent;
  strNumDoc: String; qryCadCli: TDataSet);
begin
  Create(AOwner, strNumDoc);
  Self.qryCadCli := qryCadCli;

  blnCliente := Not (qryCadCli.FieldByName('CLI_CODCLI') = nil);
end;

function TNotaFiscalEletronica.fRetNumSerie: String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT GER_SERIE_ ');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	MOVGER');
  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('	(GER_ESPDOC = "NF" OR GER_ESPDOC = "EL") ');
  qryGen.SQL.Add('	AND GER_NUMDOC = :NUMDOC');
  If blnCliente Then
    qryGen.SQL.Add('	AND GER_CODCLI = :CODCLI')
  Else
    qryGen.SQL.Add('	AND GER_CODFOR = :CODCLI');


  qryGen.ParamByName('NUMDOC').AsString := strNumDoc;

  {CASO A NOTA ESTEJA SENDO CANCELADA NO NO MOMENTO DA VENDA E NAO TENHA ENTRADO NO MOVGER}
  If Assigned(qryCadCli) Then
  Begin
    If blnCliente Then
      qryGen.ParamByName('CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString
    Else
      qryGen.ParamByName('CODCLI').AsString := qryCadCli.FieldByName('FOR_CODFOR').AsString;
  End
  Else
  Begin
    qryGen.ParamByName('CODCLI').AsString := Venda.strCodCli;
  End;

  qryGen.Open;

  {CASO A NOTA ESTEJA SENDO CANCELADA NO NO MOMENTO DA VENDA E NAO TENHA ENTRADO NO MOVGER}
  If qryGen.IsEmpty Then
    Result := fCfgSis('SERFSC')
  Else
    Result := qryGen.FieldByName('GER_SERIE_').AsString;

  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fProcessaRetornoCancelamento: Boolean;
  Var
    intEspera: Integer;
    intStatus: Integer;

    strArquivo: String;
    strNumNf: String;
    strArqCop: String;
begin
  intEspera := fCfgSis('NFEESP', varInteger);
  strNumNf := fStrZero(strNumDoc, 9);

  If Not fCfgSis('NFEXML', varBoolean) Then
    strArquivo := strPatNfe + '\DataOUT\NFE_CANO_' + fStrZero(strCodEmp, 2) + '_' + fStrZero(VS_strCodEmp, 3) + '_' + strNumNf + '.TXT'
  Else
    strArquivo := strPatNfe + '\RETORNO_' + VS_strCodEmp + '_' + Venda.strSerFsc + '_' + strNumDoc + '.XML';

  While True Do
  Begin
    Sleep(intEspera * 400);

    If (fFileExists(strArquivo)) And (fArquivoPronto(strArquivo))  Then
    Begin
      CopyFile(PChar(strArquivo), PChar(AnsiReplaceStr(strArquivo, ExtractFileExt(strArquivo), '.CITELNFE')), False);
      pCriarBackupArquivo(strArquivo);
      strArqCop := AnsiReplaceStr(strArquivo, ExtractFileExt(strArquivo), '.CITELNFE');

      intStatus := fRetStatusRetornoCancelamento(strArquivo);

      Case intStatus Of
        1:
          Begin
            Result := True;
            StrRetorno := fRetMensagemRetorno(strArquivo);
            DeleteFile(PChar(strArqCop));
            DeleteFile(PChar(strArquivo));
            Exit;
          End;
        22, 23, 24:
          Begin
            Continue;
          End;
        Else
        Begin
          Result := False;
          StrRetorno := fRetMensagemRetorno(strArquivo);
          DeleteFile(PChar(strArqCop));
          DeleteFile(PChar(strArquivo));
          Exit;
        End;
      End;

    End;

    Application.ProcessMessages;

  End;

  Raise Exception.Create('Não foi possivel receber o retorno do governo');
end;

function TNotaFiscalEletronica.fRetStatusRetornoCancelamento(
  strArquivo: String): Integer;
  Var
    txtArquivo: TextFile;
    strLinha: String;
    intCont: Integer;

    xmlRetorno: TXMLDocument;
begin

  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin
    Try
      AssignFile(txtArquivo, strArquivo);
      Reset(txtArquivo);
    Except
      Result := 24;
      Exit;
    End;
    Readln(txtArquivo, strLinha);

    For intCont := 1 To 5 Do
    Begin
      strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));
    End;
    strLinha := Copy(strLinha, 1, Pos('|', strLinha) - 1);

    Result := StrToIntDef(strLinha, 0);
    CloseFile(txtArquivo);
  End
  Else
  Begin
    If Not fFileExists(strArquivo) Then
    Begin
      Result := 2;
      Exit;
    End;

    Try
      xmlRetorno := TXMLDocument.Create(Self);
      xmlRetorno.FileName := strArquivo;
      xmlRetorno.Active := True;
    Except
      Result := 3;
      Exit;
    End;

    strRetorno := xmlRetorno.Node.ChildNodes.FindNode('resNFe').ChildNodes.FindNode('codSitucao').Text;

    If (StrToIntDef(RightStr(strRetorno, 3), 0) < 53) Then
      Result := 1
    Else
      Result := 3;

  End;
end;

procedure TNotaFiscalEletronica.SetStrChaveAcesso(const Value: String);
begin
  FStrChaveAcesso := Value;
end;

procedure TNotaFiscalEletronica.SetStrNumeroProtocolo(const Value: String);
begin
  FStrNumeroProtocolo := Value;
end;

function TNotaFiscalEletronica.fRetChaveAcesso(strArquivo: String): String;
  Var
    txtArquivo: TextFile;
    strLinha : String;
    intCont: Integer;

    xmlRetorno: TXMLDocument;
begin

  If Not fFileExists(strArquivo) Then
  Begin
    Result := '';
    Exit;
  End;


  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin
    Try
      AssignFile(txtArquivo, strArquivo);
      Reset(txtArquivo);
      Readln(txtArquivo);
      Readln(txtArquivo, strLinha);

      For intCont := 1 To 1 Do
      Begin
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));
      End;

      strLinha := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      Result := strLinha;
    Except
      Result := '';
    End;

    CloseFile(txtArquivo);
  End
  Else
  Begin

    Try
      xmlRetorno := TXMLDocument.Create(Self);
      xmlRetorno.FileName := strArquivo;
      xmlRetorno.Active := True;
    Except
      Result := '';
      Exit;
    End;

    Result := xmlRetorno.ChildNodes.FindNode('resNFe').ChildNodes.FindNode('chNFe').NodeValue;

    FreeAndNil(xmlRetorno);
  End;
end;

function TNotaFiscalEletronica.fRetProtocolo(strArquivo: String): String;
  Var
    txtArquivo: TextFile;
    strLinha : String;
    intCont: Integer;

    xmlRetorno: TXMLDocument;
begin
  If Not fFileExists(strArquivo) Then
  Begin
    Result := '';
    Exit;
  End;

  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin
    Try
      AssignFile(txtArquivo, strArquivo);
      Reset(txtArquivo);
      Readln(txtArquivo);
      Readln(txtArquivo, strLinha);

      For intCont := 1 To 2 Do
      Begin
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));
      End;

      strLinha := Copy(strLinha, 1, Pos('|', strLinha) - 1);
      Result := strLinha;
    Except
      Result := '';
    End;

    CloseFile(txtArquivo);
  End
  Else
  Begin

    Try
      xmlRetorno := TXMLDocument.Create(Self);
      xmlRetorno.FileName := strArquivo;
      xmlRetorno.Active := True;
    Except
      Result := '';
      Exit;
    End;

    Result := xmlRetorno.ChildNodes.FindNode('resNFe').ChildNodes.FindNode('nProt').NodeValue;
    FreeAndNil(xmlRetorno);
  End;
end;

procedure TNotaFiscalEletronica.SetStrRetorno(const Value: String);
begin
  FStrRetorno := Value;
end;

function TNotaFiscalEletronica.fRetMensagemRetorno(
  strArquivo: String): String;
  Var
    txtArquivo: TextFile;
    strLinha : String;
    intCont: Integer;

    xmlRetorno: TXMLDocument;
begin
  If Not fFileExists(strArquivo) Then
  Begin
    Result := '';
    Exit;
  End;

  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin

    Try
      AssignFile(txtArquivo, strArquivo);
      Reset(txtArquivo);
      Readln(txtArquivo, strLinha);

      For intCont := 1 To 6 Do
      Begin
        strLinha := Copy(strLinha, Pos('|', strLinha) + 1, Length(strLinha));
      End;

      strLinha := Copy(strLinha, 1, Length(strLinha));
      Result := strLinha;
    Except
      Result := '';
    End;

    CloseFile(txtArquivo);
  End
  Else
  Begin

    Try
      xmlRetorno := TXMLDocument.Create(Self);
      xmlRetorno.FileName := strArquivo;
      xmlRetorno.Active := True;
    Except
      Result := '';
      Exit;
    End;

    Result := xmlRetorno.ChildNodes.FindNode('resNFe').ChildNodes.FindNode('descSituacao').NodeValue;
    FreeAndNil(xmlRetorno);
  End;
end;

function TNotaFiscalEletronica.fXmlGeraNFe: Boolean;
begin
  xmlDoc.AddChild('NFe');
  Result := True;
end;

function TNotaFiscalEletronica.fXmlGeraDadosNFe: Boolean;
  Var
    xmlNo: IXMLNode;
begin
  xmlNo := fProcurarElemento(xmlDoc.Node, 'NFe');
  xmlNo.AddChild('infNFe').Attributes['versao'] := '1.10';
  Result := True;
end;

function TNotaFiscalEletronica.fProcurarElemento(ElementoPai: IXMLNode;
  strNome: String): IXMLNode;
begin
  If ElementoPai = nil Then
  Begin
    Result := nil;
    Exit;
  End;

  If ElementoPai.LocalName = strNome Then
  Begin
    Result := ElementoPai;
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.ChildNodes.First, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.NextSibling, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := nil;
end;

function TNotaFiscalEletronica.fXmlGeraIdentificacaoNFe: Boolean;
  Var
    xmlNo: IXMLNode;
begin
  xmlNo := fProcurarElemento(xmlDoc.Node, 'infNFe').AddChild('ide');
    xmlNo.AddChild('cUF').NodeValue := fRetCodigoUfIbge(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    xmlNo.AddChild('natOP').NodeValue := fRetDescricaoCfop(Venda.FClaFis);
    xmlNo.AddChild('cNOP').NodeValue := Venda.FClaFis;
    xmlNo.AddChild('cESPECIE').NodeValue := 'NF';
    xmlNo.AddChild('indPag').NodeValue := IfThen(Venda.strConPag = '01000', '0', '1');
    xmlNo.AddChild('mod').NodeValue := 55;
    xmlNo.AddChild('serie').NodeValue := Venda.strSerFsc;
    xmlNo.AddChild('nNF').NodeValue := StrToIntDef(strNumDoc, 0);
    xmlNo.AddChild('dEmi').NodeValue := FormatDateTime('YYYY-MM-DD', VS_Date);
    xmlNo.AddChild('dSaiEnt').NodeValue := FormatDateTime('YYYY-MM-DD', VS_Date);
    xmlNo.AddChild('tpNF').NodeValue := IfThen(fRetEntradaSaida(Venda.strClaFis) = 'E', '0', '1');
    xmlNo.AddChild('cMunFG').NodeValue := fRetCodMun(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    xmlNo.AddChild('tpImp').NodeValue := 1;
    xmlNo.AddChild('tpEmis').NodeValue := 1;
    xmlNo.AddChild('finNFe').NodeValue := 1;
    xmlNo.AddChild('chaveOrigem').NodeValue := strNumDoc;

  Result := True;
end;

function TNotaFiscalEletronica.fXmlGeraIdentificacaoEmitenteNFe: Boolean;
  Var
    xmlNo: IXMLNode;
begin

  xmlNo := fProcurarElemento(xmlDoc.Node, 'infNFe').AddChild('emit');
    xmlNo.AddChild('CNPJ').NodeValue := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_C_G_C_').AsString);
    xmlNo.AddChild('xNome').NodeValue := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
    xmlNo.AddChild('xFant').NodeValue := qryCadEmp.FieldByName('EMP_NOMFAN').AsString;
    xmlNo := xmlNo.AddChild('enderEmit');
      xmlNo.AddChild('xLgr').NodeValue := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
      xmlNo.AddChild('nro').NodeValue := qryCadEmp.FieldByName('EMP_ENDNUM').AsString;
      xmlNo.AddChild('xBairro').NodeValue := qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
      xmlNo.AddChild('cMun').NodeValue := fRetCodMun(qryCadEmp.FieldByName('EMP_CODCID').AsString);
      xmlNo.AddChild('xMun').NodeValue := fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
      xmlNo.AddChild('UF').NodeValue := fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
      xmlNo.AddChild('CEP').NodeValue := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_C_E_P_').AsString);
      xmlNo.AddChild('cPais').NodeValue := 1058;
      xmlNo.AddChild('xPais').NodeValue := 'BRASIL';
      xmlNo.AddChild('fone').NodeValue := AnsiReplaceStr(fLimpaCaracteres(qryCadEmp.FieldByName('EMP_FONE01').AsString), ' ', '');
      xmlNo.AddChild('IE').NodeValue := fLimpaCaracteres(qryCadEmp.FieldByName('EMP_I_E_S_').AsString);

  Result := True;
end;

function TNotaFiscalEletronica.fXmlGeraIdentificacaoDestinatarioNFe: Boolean;
  Var
    xmlNo: IXMLNode;
begin
  xmlNo := fProcurarElemento(xmlDoc.Node, 'infNFe').AddChild('dest');
  xmlNo.AddChild('CNPJ').NodeValue := fLimpaCaracteres(Venda.strCliCgc);
  xmlNo.AddChild('xNome').NodeValue  := IIF(fClienteConsumidor(Venda.strCliOri), Venda.strCliNom, Venda.strCliOri); // Nome Consumidor;
  xmlNo := xmlNo.AddChild('enderDest');

  xmlNo.AddChild('xLgr').NodeValue := Venda.strCliEnd;
  xmlNo.AddChild('nro').NodeValue := 0;
  xmlNo.AddChild('xBairro').NodeValue := Venda.strCliBai;

  If fRetNomCidade(Venda.strCodCid, 1) <> 'EX' Then
  Begin
    xmlNo.AddChild('cMun').NodeValue := fRetCodMun(Venda.strCodCid);
    xmlNo.AddChild('xMun').NodeValue := fRetNomCidade(Venda.strCodCid);
    xmlNo.AddChild('UF').NodeValue   := fRetNomCidade(Venda.strCodCid, 1);
    xmlNo.AddChild('CEP').NodeValue  := fLimpaCaracteres(Venda.strCliCep);
  End
  Else
  Begin
    xmlNo.AddChild('cMun').NodeValue := '9999999';
    xmlNo.AddChild('xMun').NodeValue := 'EXTERIOR';
    xmlNo.AddChild('UF').NodeValue   := 'EX';
    xmlNo.AddChild('CEP').NodeValue  := '00000000'
  End;

  xmlNo.AddChild('cPais').NodeValue := 1058;
  xmlNo.AddChild('xPais').NodeValue := 'BRASIL';
  xmlNo.AddChild('strFone01').NodeValue := Venda.strFone01;
  xmlNo.AddChild('IE').NodeValue := fLimpaCaracteres(Venda.strCliIes);

  Result := True;
end;

function TNotaFiscalEletronica.fXmlGeraDetalhamentoProdutosNFe: Boolean;
  Var
    intCont: Integer;

    xmlNoDet: IXMLNode;
    xmlNoProd: IXMLNode;
    xmlNoImposto: IXMLNode;
    xmlNoIcms: IXMLNode;
    xmlNoIpi: IXMLNode;
    xmlNoPis: IXMLNode;
    xmlNoCofins: IXMLNode;
begin

  For intCont := Low(FItens) To High(FItens) Do
  Begin
    xmlNoDet := fProcurarElemento(xmlDoc.Node, 'infNFe').AddChild('det');
    xmlNoDet.Attributes['nItem'] := intCont + 1;

    xmlNoProd := xmlNoDet.AddChild('prod');
      xmlNoProd.AddChild('cProd').NodeValue := Itens[intCont].strCodIte;
      xmlNoProd.AddChild('cEAN').NodeValue := fRetCodBarra(Itens[intCont].strCodIte);
      xmlNoProd.AddChild('xProd').NodeValue := Itens[intCont].strDesIte;
      xmlNoProd.AddChild('CFOP').NodeValue := Itens[intCont].strClaFis;
      xmlNoProd.AddChild('uCom').NodeValue := Itens[intCont].strCodUni;
      xmlNoProd.AddChild('qCom').NodeValue := Itens[intCont].fltQtdIte;
      xmlNoProd.AddChild('vUnCom').NodeValue := fXmlFormataValor(Itens[intCont].fltUniTar, 16, 4);
      xmlNoProd.AddChild('vProd').NodeValue := fXmlFormataValor(Itens[intCont].fltTotIte, 15, 2);
      xmlNoProd.AddChild('cEANtrib').NodeValue := '';
      xmlNoProd.AddChild('uTrib').NodeValue := '';
      xmlNoProd.AddChild('qTrib').NodeValue := '';
      xmlNoProd.AddChild('vUnTrib').NodeValue := '';


    xmlNoImposto := xmlNoDet.AddChild('imposto');
      xmlNoIcms := xmlNoImposto.AddChild('ICMS');
        xmlNoIcms.ChildNodes.Add(fXmlRetIcmsSt(xmlNoIcms, intCont));

      If (Not fCfgSis('SIMPAU', varBoolean)) And (Itens[intCont].fltValipi <> 0) Then
      Begin
        xmlNoIpi := xmlNoImposto.AddChild('IPI');
          xmlNoIpi.AddChild('cEnq').NodeValue := '999';
          xmlNoIpi.ChildNodes.Add(fXmlRetIpiSt(xmlNoIpi, intCont));
      End;

      xmlNoPis := xmlNoImposto.AddChild('PIS');
        xmlNoPis.ChildNodes.Add(fXmlRetPisSt(xmlNoPis, intCont));

      xmlNoCofins := xmlNoImposto.AddChild('COFINS');
        xmlNoCofins.ChildNodes.Add(fXmlRetCofinsSt(xmlNoCofins, intCont));
  End;
  Result := True;
end;

function TNotaFiscalEletronica.fXmlRetIcmsSt(xmlNoPai: IXMLNode; intItemIndex: Integer): IXMLNode;
begin
  If fCfgSis('SIMPAU', varBoolean) Then
  Begin
    Result := xmlNoPai.AddChild('ICMS40');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '41';
  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '00' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS00');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '00';
      Result.AddChild('modBC').NodeValue := '0';
      Result.AddChild('vBC').NodeValue   := fXmlFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2);
      Result.AddChild('pICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2);
      Result.AddChild('vICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValIcm, 15, 2);

  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '10' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS10');
      Result.AddChild('ori').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '10';
      Result.AddChild('modBC').NodeValue := '0';
      Result.AddChild('vBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2);
      Result.AddChild('pICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2);
      Result.AddChild('vICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValIcm, 15, 2);
      Result.AddChild('modBCST').NodeValue := '4';
      Result.AddChild('vBCST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasRet, 15, 2);
      Result.AddChild('pICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqRet, 15, 2);
      Result.AddChild('vICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValRet, 15, 2);
  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '20' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS20');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '20';
      Result.AddChild('modBC').NodeValue := '0';
      Result.AddChild('pRedBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltPerRed, 15, 2);
      Result.AddChild('vBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2);
      Result.AddChild('pICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2);
      Result.AddChild('vICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValIcm, 15, 2);
  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '30' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS30');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '30';
      Result.AddChild('modBCST').NodeValue := '4';
      Result.AddChild('vBCST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasRet, 15, 2);
      Result.AddChild('pICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqRet, 15, 2);
      Result.AddChild('vICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValRet, 15, 2);
  End
  Else If Pos(RightStr(Itens[intItemIndex].strCodSit, 2), '_40_41_50_') > 0 Then
  Begin
    Result := xmlNoPai.AddChild('ICMS40');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := RightStr(Itens[intItemIndex].strCodSit, 2);
  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '51' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS51');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '51';
      Result.AddChild('modBC').NodeValue := '0';
      Result.AddChild('pRedBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltPerRed, 15, 2);
      Result.AddChild('vBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2);
      Result.AddChild('pICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2);
      Result.AddChild('vICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValIcm, 15, 2);
  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '60' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS60');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '60';
      Result.AddChild('vBCST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasRet, 15, 2);
      Result.AddChild('vICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValRet, 15, 2);
  End
  Else If RightStr(Itens[intItemIndex].strCodSit, 2) = '70' Then
  Begin
    Result := xmlNoPai.AddChild('ICMS70');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '70';
      Result.AddChild('modBC').NodeValue := '0';
      Result.AddChild('pRedBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltPerRed, 15, 2);
      Result.AddChild('vBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2);
      Result.AddChild('pICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2);
      Result.AddChild('vICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValIcm, 15, 2);
      Result.AddChild('modBCST').NodeValue := '4';
      Result.AddChild('vBCST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasRet, 15, 2);
      Result.AddChild('pICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqRet, 15, 2);
      Result.AddChild('vICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValRet, 15, 2);
  End
  Else
  Begin
    Result := xmlNoPai.AddChild('ICMS90');
      Result.AddChild('orig').NodeValue := '0';
      Result.AddChild('CST').NodeValue := '90';
      Result.AddChild('modBC').NodeValue := '0';
      Result.AddChild('pRedBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltPerRed, 15, 2);
      Result.AddChild('vBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasIcm, 15, 2);
      Result.AddChild('pICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIcm, 05, 2);
      Result.AddChild('vICMS').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValIcm, 15, 2);
      Result.AddChild('modBCST').NodeValue := '4';
      Result.AddChild('vBCST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasRet, 15, 2);
      Result.AddChild('pICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqRet, 15, 2);
      Result.AddChild('vICMSST').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValRet, 15, 2);
  End;
end;

function TNotaFiscalEletronica.fXmlRetIpiSt(xmlNoPai: IXMLNode;
  intItemIndex: Integer): IXMLNode;
begin
  If (Pos(RightStr(Itens[intItemIndex].strClaIpi, 2), '_00_49_50_99_') > 0) Then
  Begin
    Result := xmlNoPai.AddChild('IPITRIB');
      Result.AddChild('CST').NodeValue := RightStr(Itens[intItemIndex].strCodSit, 2);
      Result.AddChild('vBC').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltBasIpi, 15, 2);
      Result.AddChild('pIPI').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltAlqIpi, 05, 2);
      Result.AddChild('vIPI').NodeValue := fXmlFormataValor(Itens[intItemIndex].fltValipi, 15, 2);
  End
  Else If (Pos(RightStr(Itens[intItemIndex].strCodSit, 2), '_01_02_03_04_51_52_53_54_55_') > 0) Then
  Begin
    Result := xmlNoPai.AddChild('IPINT');
      Result.AddChild('CST').NodeValue := RightStr(Itens[intItemIndex].strCodSit, 2);
  End;
end;

function TNotaFiscalEletronica.fXmlRetPisSt(xmlNoPai: IXMLNode;
  intItemIndex: Integer): IXMLNode;
begin
  //Código  	Descrição
  //01 	      Operação Tributável (base de cálculo = valor da operação alíquota normal (cumulativo/não cumulativo)).
  //02 	      Operação Tributável (base de cálculo = valor da operação (alíquota diferenciada)).
  //03 	      Operação Tributável (base de cálculo = quantidade vendida x alíquota por unidade de produto).
  //04 	      Operação Tributável (tributação monofásica (alíquota zero)).
  //06 	      Operação Tributável (alíquota zero).
  //07 	      Operação Isenta da Contribuição.
  //08 	      Operação Sem Incidência da Contribuição.
  //09 	      Operação com Suspensão da Contribuição.
  //99 	      Outras Operações
  If fCfgSis('SIMPAU', varBoolean) Then
  Begin
    Result := xmlNoPai.AddChild('PISOutr');
      Result.AddChild('CST').NodeValue := '99';
      Result.AddChild('vBC').NodeValue := 0;
      Result.AddChild('pPIS').NodeValue := 0;
      Result.AddChild('vPIS').NodeValue := 0;
  End
  Else
  Begin
    Result := xmlNoPai.AddChild('PISAliq');
      Result.AddChild('CST').NodeValue := '01';
      Result.AddChild('vBC').NodeValue := 0;
      Result.AddChild('pPIS').NodeValue := 0;
      Result.AddChild('vPIS').NodeValue := 0;
  End;

end;

function TNotaFiscalEletronica.fXmlRetCofinsSt(xmlNoPai: IXMLNode;
  intItemIndex: Integer): IXMLNode;
begin
//Código  	Descrição
//01 	      Operação Tributável (base de cálculo = valor da operação (alíquota normal (cumulativo/não cumulativo))).
//02 	      Operação Tributável (base de cálculo = valor da operação (alíquota diferenciada)).
//03 	      Operação Tributável (base de cálculo = quantidade vendida (alíquota por unidade de produto)).
//04 	      Operação Tributável (tributação monofásica (alíquota zero)).
//06 	      Operação Tributável (alíquota zero).
//07 	      Operação Isenta da Contribuição.
//08 	      Operação Sem Incidência da Contribuição.
//09 	      Operação com Suspensão da Contribuição.
//99 	      Outras Operações

  If fCfgSis('SIMPAU', varBoolean) Then
  Begin
    Result := xmlNoPai.AddChild('COFINSOutr');
      Result.AddChild('CST').NodeValue := 99;
      Result.AddChild('vBC').NodeValue := 0;
      Result.AddChild('pCOFINS').NodeValue := 0;
      Result.AddChild('vCOFINS').NodeValue := 0;
  End
  Else
  Begin
    Result := xmlNoPai.AddChild('COFINSAliq');
      Result.AddChild('CST').NodeValue := '01';
      Result.AddChild('vBC').NodeValue := 0;
      Result.AddChild('pCOFINS').NodeValue := 0;
      Result.AddChild('vCOFINS').NodeValue := 0;
  End;
end;

function TNotaFiscalEletronica.fXmlGeraValoresTotaisNFe: Boolean;
  Var
    xmlNoTotal: IXMLNode;
    xmlNoIcmsTot: IXMLNode;

    fltBasRet,
    fltTotRet,
    fltTotIpi: Double;
begin

  If fImprimeSubTributariaDadosProprios Then
  Begin
    fltBasRet := Venda.fltBasRet;
    fltTotRet := Venda.fltTotRet;
  End
  Else
  Begin
    fltBasRet := 0.0;
    fltTotRet := 0.0;
  End;

  If fImprimeIPIDadosProprios Then
    fltTotIpi := Venda.fltTotIpi
  Else
    fltTotIpi := 0.0;

  xmlNoTotal := fProcurarElemento(xmlDoc.Node, 'infNFe').AddChild('total');
    xmlNoIcmsTot := xmlNoTotal.AddChild('ICMSTot');
      xmlNoIcmsTot.AddChild('vBC').NodeValue := fXmlFormataValor(Venda.fltBasIcm, 15, 2);
      xmlNoIcmsTot.AddChild('vICMS').NodeValue := fXmlFormataValor(Venda.fltTotIcm, 15, 2);
      xmlNoIcmsTot.AddChild('vBCST').NodeValue := fXmlFormataValor(fltBasRet, 15, 2);
      xmlNoIcmsTot.AddChild('vST').NodeValue := fXmlFormataValor(fltTotRet, 15, 2);
      xmlNoIcmsTot.AddChild('vProd').NodeValue := fXmlFormataValor(Venda.fltTotPro, 15, 2);
      xmlNoIcmsTot.AddChild('vFrete').NodeValue := fXmlFormataValor(Venda.fltValFre, 15, 2);
      xmlNoIcmsTot.AddChild('vSeg').NodeValue := fXmlFormataValor(0.0, 15, 2);
      xmlNoIcmsTot.AddChild('vDesc').NodeValue := fXmlFormataValor(Venda.fltTotDes, 15, 2);
      xmlNoIcmsTot.AddChild('VII').NodeValue := 0;
      xmlNoIcmsTot.AddChild('vIPI').NodeValue := fXmlFormataValor(fltTotIpi, 15, 2);
      xmlNoIcmsTot.AddChild('vPIS').NodeValue := 0;
      xmlNoIcmsTot.AddChild('vCOFINS').NodeValue := fXmlFormataValor(Venda.fltValCof, 15, 2);
      xmlNoIcmsTot.AddChild('vOutro').NodeValue := fXmlFormataValor(Venda.fltDesAce, 15, 2);
      xmlNoIcmsTot.AddChild('vNF').NodeValue := fXmlFormataValor(Venda.fltTotGer, 15, 2);
  Result := True;
end;

function TNotaFiscalEletronica.fXmlGeraInformacoesTransporteNFe: Boolean;
  Var
    xmlNoTransporte: IXMLNode;
begin
  xmlNoTransporte := fProcurarElemento(xmlDoc.Node, 'infNFe').AddChild('transp');
    xmlNoTransporte.AddChild('modFrete').NodeValue := StrToIntDef(Venda.strTipFre, 0) - 1;

  Result := True;
end;

function TNotaFiscalEletronica.fXmlFormataValor(fltValor: Double;
  intTamanho, intDecimais: Integer): String;
begin
  Result := AnsiReplaceStr(Format('%.' + IntToStr(intDecimais) + 'f', [fltValor]), ',', '.');
end;

function TNotaFiscalEletronica.fXmlGeraDadosCancelamento(strArqNfe: String): Boolean;
  Var
    xmlDocC: TXMLDocument;
    xmlNoInf: IXMLNode;
begin
  xmlDocC := TXMLDocument.Create(Self);
  xmlDocC.Options := [doNodeAutoCreate,doNodeAutoIndent,doAutoPrefix,doNamespaceDecl];
  xmlDocC.Active := True;
  xmlDocC.Version := '1.0';
  xmlDocC.Encoding := 'UTF-8';
  xmlNoInf := xmlDocC.AddChild('infNFe');
  xmlNoInf.Attributes['versao'] := '1.01';

  If Assigned(qryCadCli) Then
  Begin
    If blnCliente Then
      xmlNoInf.AddChild('CNPJ').NodeValue := fLimpaCaracteres(qryCadCli.FieldByName('CLI_C_G_C_').AsString)
    Else
      xmlNoInf.AddChild('CNPJ').NodeValue := fLimpaCaracteres(qryCadCli.FieldByName('FOR_C_G_C_').AsString);
  End
  Else
  Begin
    xmlNoInf.AddChild('CNPJ').NodeValue := fLimpaCaracteres(Venda.strCliCgc);
  End;

  xmlNoInf.AddChild('mod').NodeValue := 55;
  xmlNoInf.AddChild('nNF').NodeValue := strNumDoc;
  xmlNoInf.AddChild('dEmi').Text := FormatDateTime('YYYY-MM-DD', fRetDtaDoc);
  xmlNoInf.AddChild('tpNF').NodeValue := fRetEntradaSaida;
  xmlNoInf.AddChild('chaveOrigem').NodeValue := VS_strCodEmp + strNumDoc + 'NF' + fRetNumSerie;

  xmlDocC.SaveToFile(strArqNfe);

  Result := True;
end;

function TNotaFiscalEletronica.fRetDtaDoc: TDateTime;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT GER_DTADOC ');
  qryGen.SQL.Add('FROM ');
  qryGen.SQL.Add('	MOVGER');
  qryGen.SQL.Add('WHERE');
  qryGen.SQL.Add('	(GER_ESPDOC = "NF" OR GER_ESPDOC = "EL")');
  qryGen.SQL.Add('	AND GER_NUMDOC = :NUMDOC');
  qryGen.SQL.Add('  AND IFNULL(GER_SERIE_, "") = :NUMSERIE');

  If blnCliente Then
    qryGen.SQL.Add('	AND GER_CODCLI = :CODCLI')
  Else
    qryGen.SQL.Add('	AND GER_CODFOR = :CODCLI');

  qryGen.ParamByName('NUMDOC').AsString := strNumDoc;

  If Assigned(qryCadCli) Then
  Begin
    If blnCliente Then
      qryGen.ParamByName('CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString
    Else
      qryGen.ParamByName('CODCLI').AsString := qryCadCli.FieldByName('FOR_CODFOR').AsString;
  End
  Else
  Begin
    qryGen.ParamByName('CODCLI').AsString := Venda.strCodCli;
  End;

  qryGen.ParamByName('NUMSERIE').AsString := fRetNumSerie;

  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := VS_Date
  Else
    Result := qryGen.FieldByName('GER_DTADOC').AsDateTime;

  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fRetEntradaSaida: String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Add(' SELECT  ');
  qryGen.SQL.Add(' 	FIS_ENTSAI ');
  qryGen.SQL.Add(' FROM  ');
  qryGen.SQL.Add(' 	CADFIS ');
  qryGen.SQL.Add(' WHERE ');
  qryGen.SQL.Add(' 	FIS_CODEMP = :CODEMP ');
  qryGen.SQL.Add(' 	AND FIS_NUMDOC = :NUMDOC ');
  qryGen.SQL.Add(' 	AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL")');
  qryGen.SQL.Add(' 	AND IFNULL(FIS_SERIE_, "") = :SERIE ');

  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
  qryGen.ParamByName('SERIE').AsString := fRetNumSerie;

  qryGen.Open;
  Result := IfThen(qryGen.FieldByName('FIS_ENTSAI').AsString = 'E', '0', '1');
  FreeAndNil(qryGen);
end;

constructor TNotaFiscalEletronica.Create(AOwner: TComponent;
  strNumDoc: String; Venda: TFatVenda);
begin
  Create(AOwner, strNumDoc);

  FVenda := Venda;
end;

function TNotaFiscalEletronica.fFileExists(strPath: String; intTimeOut: Integer = 5000): Boolean;
  Var
    IPTesta: TipoIdIcmpClient;
    strIP: String;
    intPos: Integer;
begin
  If Copy(strPath, 1, 2) = '\\' Then
  Begin

    intPos := PosEx('\', strPath, 3);
    strIP := Copy(strPath, 3, intPos - 3);

    IPTesta := TipoIdIcmpClient.Create(nil);
    IPTesta.Host := strIP;
    Try
      IPTesta.ReceiveTimeout := intTimeOut;
      IPTesta.Ping();
    Except
    End;

    case IPTesta.ReplyStatus.ReplyStatusType of
      rsError: Result := False;
      rsErrorTTLExceeded: Result := False;
      rsErrorUnreachable: Result := False;
      rsTimeOut: Result := False;
    Else
      Result := True;
    End;

    If Result Then
    Begin
      Result := FileExists(strPath);

      If Not Result Then
        Result := DirectoryExists(strPath);
    End;

    FreeAndNil(IPTesta);
  End
  Else
  Begin
    Result := FileExists(strPath);

    If Not Result Then
      Result := DirectoryExists(strPath);
  End;
end;

function TNotaFiscalEletronica.fRetValoresSituacaoTrinbutarias(
  strCodSit: String; intIndex: Integer): String;
begin
  Result := strCodSit + '|';

  If Pos(strCodSit, '_0_6_7_13_') > 0 Then
  Begin
    Result := Result + fFormataValor(Itens[intIndex].fltBasIpi, 15, 2) + '|';                                            // 090 - S - N - 015,20 - VALOR DO BC DO IPI
    Result := Result + '|';                                                                                              // 091 - S - N - 016,40 - QUANTIDADE TOTAL NA UNIDADE PADRAO PARA TRIBUTACAO
    Result := Result + '|';                                                                                              // 092 - S - N - 015,40 - VALOR POR UNIDADE TRIBUTAVEL
    Result := Result + IfThen(Itens[intIndex].fltValipi <> 0, fFormataValor(Itens[intIndex].fltAlqIpi, 05, 2)) + '|';    // 093 - S - N - 005,20 - ALIQUOTA IPI
    Result := Result + IfThen(Itens[intIndex].fltValipi <> 0, fFormataValor(Itens[intIndex].fltValipi, 15, 2)) + '|';    // 094 - S - N - 015,20 - VALOR IPI
  End
  Else
    Result := Result + fReplicatorStr('|', 5);
end;

function TNotaFiscalEletronica.fRetInformacoesAdicionaisNotImp: String;
  Var
    strMenSubIPI: String;
Begin
  Result := '';

  Result := Result + fPadR('Mercadorias....................' + fPadL(FloatToStrF(Venda.fltImpMer, ffNumber, 15, 2), 15), 108);
  Result := Result + fPadR('Frete e seguro internacional...' + fPadL(FloatToStrF(Venda.fltImpSeg, ffNumber, 15, 2), 15), 108);
  Result := Result + fPadR('Imposto de Importação..........' + fPadL(FloatToStrF(Venda.fltImpImp, ffNumber, 15, 2), 15), 108);
  Result := Result + fPadR('Valor dos Produtos.............' + fPadL(FloatToStrF(Venda.fltImpPro, ffNumber, 15, 2), 15), 108);
  Result := Result + fPadR('Taxa do SISCOMEX...............' + fPadL(FloatToStrF(Venda.fltImpTax, ffNumber, 15, 2), 15), 108);
  Result := Result + fPadR('PIS/PASEP......................' + fPadL(FloatToStrF(Venda.fltImpPis, ffNumber, 15, 2), 15), 108);
  Result := Result + fPadR('COFINS.........................' + fPadL(FloatToStrF(Venda.fltImpCof, ffNumber, 15, 2), 15), 108);

  If Not fEmptyStr(Venda.strImpIC1) Then
    Result := Result + fPadR('ICMS:' + Venda.strImpIC1, 108);
  If Not fEmptyStr(Venda.strImpIC2) Then
    Result := Result + fPadR(Venda.strImpIC2, 108);

  strMenSubIPI := '';

  If (Not fImprimeSubTributariaDadosProprios) Then
  Begin
    If Not fEmptyStr(strMenSubIPI) Then strMenSubIPI := strMenSubIPI + ' / ';
    strMenSubIPI := 'Bc.ST: ' + FloatToStrF(Venda.fltBasRet, ffNumber, 12, 2) + ' / Vl. ST: ' + FloatToStrF(Venda.fltTotRet, ffNumber, 12, 2);
  End;

  If (Not fImprimeIPIDadosProprios) Then
  Begin
    If Not fEmptyStr(strMenSubIPI) Then strMenSubIPI := strMenSubIPI + ' / ';
    strMenSubIPI := strMenSubIPI + 'Vl. IPI: ' + FloatToStrF(Venda.fltTotIpi, ffNumber, 12, 2);
  End;

  If Not fEmptyStr(strMenSubIPI) Then
    Result := Result + fPadR(strMenSubIPI, 108);
End;

function TNotaFiscalEletronica.fRetInformacoesAdicionais: String;
  Var
    intCont: Integer;
    arrAbf: Array Of Array [1..2] Of String;
    strMenSubIPI: String;
  Const
    intLargura : Integer = 108;

  function procuraAbd(strCodAbf: String): Boolean;
    Var
      i: Integer;
  Begin

    For i := Low(arrAbf) To High(arrAbf) Do
    Begin
      If (arrAbf[i][1] = strCodAbf) Then
      Begin
        Result := True;
        Exit;
      End;
    End;

    Result := False;
  End;

begin
  SetLength(arrAbf, 0);
  For intCont := Low(FItens) To High(FItens) Do
  Begin
    If (Not procuraAbd(Itens[intCont].strCodAbf) And (Not fEmptyStr(Itens[intCont].strMen__S))) Then
    Begin
      SetLength(arrAbf, Length(arrAbf) + 1);
      arrAbf[Length(arrAbf) - 1][1] := Itens[intCont].strCodAbf;
      arrAbf[Length(arrAbf) - 1][2] := Itens[intCont].strMen__S;
    End;
  End;

  If fCfgSis('VENDAD', varBoolean) Then
    Result := fPadR('Vendedor: ' + Venda.strCodVen + ' - ' + Venda.strNomVen, intLargura)
  Else
    Result := '';

  If fCfgSis('CDPNFE',varBoolean) Then
    Result := Result + fPadR('Cond.Pag: ' + fRetDesFpg(Venda.strCodFpg), intLargura)
  Else
    Result := '';

  {******************************************}
  {* CARREGA DADOS ADICIONAIS CONFORME LEI  *}
  {* 5817/10 DO ESTADO DO RJ PARA IMPRESSAO *}
  {***************************************IV*}
  Venda.pCarregaLei5817;
  
  If Venda.strClaFis >= '5000' Then
  Begin
    Try
      Result := Result + fRetDadosCnfe(intLargura);
    Except
      Raise ExceptionFalhaNFe.Create('Não foi possivel obter os dados adicionais!');
    End;

    For intCont := Low(arrAbf) To High(arrAbf) Do
    Begin
      Result := Result +  fQuebraStringLinhas(Trim(arrAbf[intCont][2]), intLargura);
    End;
  End;

  If Not fEmptyStr(Venda.strMen001) Then Result := Result + fPadR(Venda.strMen001, intLargura);
  If Not fEmptyStr(Venda.strMen002) Then Result := Result + fPadR(Venda.strMen002, intLargura);
  If Not fEmptyStr(Venda.strMen003) Then Result := Result + fPadR(Venda.strMen003, intLargura);
  If Not fEmptyStr(Venda.strMen004) Then Result := Result + fPadR(Venda.strMen004, intLargura);
  If Not fEmptyStr(Venda.strMen005) Then Result := Result + fPadR(Venda.strMen005, intLargura);

  strMenSubIPI := '';

  If (Not fImprimeSubTributariaDadosProprios) Then
  Begin
    If Not fEmptyStr(strMenSubIPI) Then strMenSubIPI := strMenSubIPI + ' / ';
    strMenSubIPI := 'Bc.ST: ' + FloatToStrF(Venda.fltBasRet, ffNumber, 12, 2) + ' / Vl. ST: ' + FloatToStrF(Venda.fltTotRet, ffNumber, 12, 2);
  End;

  If (Not fImprimeIPIDadosProprios) Then
  Begin
    If Not fEmptyStr(strMenSubIPI) Then strMenSubIPI := strMenSubIPI + ' / ';
    strMenSubIPI := strMenSubIPI + 'Vl. IPI: ' + FloatToStrF(Venda.fltTotIpi, ffNumber, 12, 2);
  End;

  If Not fEmptyStr(strMenSubIPI) Then
    Result := Result + fPadR(strMenSubIPI, intLargura);

  Result := LeftStr(Trim(AnsiReplaceStr(Result, #13#10, ' ')), 4000);
end;

function TNotaFiscalEletronica.fRetDadosCnfe(intLargura: Integer): String;
  Var
    qryCnf: TUniQuery;
begin

  Result := '';

  qryCnf := fCriaQuery(Self);
  qryCnf.SQL.Text := 'SELECT * FROM CNF_NFE WHERE CNF_SETOR_ = "06" AND CNF_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ORDER BY CNF_IDENTI ';
  qryCnf.Open;

  If qryCnf.IsEmpty Then
  Begin
    Exit;
  End;

  { FUNC MACRO }
  pInicializaVariaveis;

  While Not qryCnf.Eof Do
  Begin
    Result := Result + fQuebraStringLinhas(fProcessaMacro(Venda, nil, qryCnf.FieldByName('CNF_DESCAM').AsString), intLargura);
    lstVariaveis.Clear;
    qryCnf.Next;
  End;

  lstVariaveis.Clear;
  FreeAndNil(qryCnf);
end;

procedure TNotaFiscalEletronica.pRecarregaTransportadora;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM CADTRA WHERE TRA_CODTRA = :CODTRA';
  qryGen.ParamByName('CODTRA').AsString := Venda.strCodTra;
  qryGen.Open;

  Venda.strCgcTra := qryGen.FieldByName('TRA_C_G_C_').AsString;
  Venda.strNomTra := qryGen.FieldByName('TRA_NOMTRA').AsString;
  Venda.strIesTra := qryGen.FieldByName('TRA_I_E_S_').AsString;
  Venda.strEndTra := qryGen.FieldByName('TRA_ENDERE').AsString;
  Venda.strCidTra := fRetNomCidade(qryGen.FieldByName('TRA_CODCID').AsString);
  Venda.strEstTra := fRetNomCidade(qryGen.FieldByName('TRA_CODCID').AsString, 2);

  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fLimpaCaracteresTelefone(
  strTexto: String): String;
begin
  Result := fLimpaCaracteres(strTexto);
  Result := AnsiReplaceStr(AnsiReplaceStr(Result, '(', ''), ')', '');
  While Pos(' ', Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, ' ', '');
  End;


  While Pos(' ', Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, ' ', '');
  End;
end;

function TNotaFiscalEletronica.fVerificaNotaJaGerada: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Add('SELECT COUNT(*) QTD');
  qryGen.SQL.Add('FROM CADFIS');
  qryGen.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC');
  qryGen.SQL.Add('    AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL")');
  qryGen.SQL.Add('    AND IFNULL(FIS_SERIE_, "") = :SERIE');
  qryGen.SQL.Add('    AND FIS_CODEMP = :CODEMP');
  qryGen.SQL.Add('    AND FIS_TIP_FC = "C"');
  qryGen.SQL.Add('    AND FIS_ACESSO = :ACESSO');

  qryGen.ParamByName('NUMDOC').AsString := Venda.recNfeComplemento.strNumDoc;
  qryGen.ParamByName('SERIE').AsString := Venda.recNfeComplemento.strSerie;
  qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGen.ParamByName('ACESSO').AsString := Venda.recNfeComplemento.strChaveAcesso;

  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fVerificaNotaJaRetornada: Boolean;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('  COUNT(*)    QTD');
  qryGen.SQL.Add('FROM CADFIS');
  qryGen.SQL.Add('WHERE FIS_ACESSO = :ACESSO');

  qryGen.ParamByName('ACESSO').AsString := StrChaveAcesso;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);

end;

procedure TNotaFiscalEletronica.pCriarBackupArquivo(strNomArq: String);
  Var
    strArqDest: String;
    strExt: String;
begin
  Try
    If Not DirectoryExists(strPatNfe + '\BackupCitel') Then
      ForceDirectories(strPatNfe + '\BackupCitel');

    strArqDest := strPatNfe + '\BackupCitel\' + ExtractFileName(strNomArq);

    strExt := ExtractFileExt(strArqDest);
    strArqDest := AnsiReplaceStr(strArqDest, strExt, '_' + FormatDateTime('yyyymmddhhnnss', Now) + strExt);

    CopyFile(PChar(strNomArq), PChar(AnsiReplaceStr(strArqDest, '.CITELNFE', '.TXT')), False);
  Except
    pGravarErro(True, Format('Não foi possivel criar o arquivo de backup "%s"', [strArqDest]));
  End;

end;

function TNotaFiscalEletronica.fGerarArquivoComplemento: Boolean;
  Var
    strNumNf: String;
    strArqNfe: String;

    procedure Limpar();
    Begin
      CloseFile(txtArquivoSaida);
      pCriarBackupArquivo(strArqNfe);
      //RenameFile(strArqNfe, AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT'));
      fRenomearArquivo(strArqNfe, AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT'));
      strArqNfe := AnsiReplaceStr(strArqNfe, 'CITELNFE', 'TXT');
    End;
begin

  Result := False;

  If Not Assigned(FVenda) Then
  Begin
    pMensagensErro('FVenda não configurados!', '[TNotaFiscalEletronica.fGerarArquivoComplemento]');
    Result := False;
    Exit;
  End;

  If Not fCfgSis('NFEXML', varBoolean) Then
  Begin

    If Not fFileExists(strPatNfe + '\DataIn') Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', 'Não é possivel encontrar o path ' + strPatNfe + '\DataIn', ['OK']);
      Exit;
    End;

    strNumNf := fStrZero(strNumDoc, 9);
    strArqNfe := strPatNfe + '\DataIn\NFE_ENVI_' + fStrZero(strCodEmp, 2) + '_' + fStrZero(VS_strCodEmp, 3) + '_' + strNumNf + '.CITELNFE';

    pApagaArquivosDataOut(strArqNfe, 'ENVI', 'ENVO');

    Try
      AssignFile(txtArquivoSaida, strArqNfe);
      Rewrite(txtArquivoSaida);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TNotaFiscalEletronica.fGerarArquivoComplemento]');
      End;
    End;

    If (Not fEmptyStr(Venda.recNfeComplemento.strNumDoc)) And (Not fVerificaNotaJaGerada()) Then
    Begin
      Limpar;
      Raise ExceptionNFeJaEmitida.Create('Não foi possivel encontrar a nota fiscal original!');
    End;

    Try

      Result := fGeraInformacoesNotaFiscalEletronica;
      Result := Result And fGeraIdentificacaoEmitente;
      Result := Result And fGeraIdentificacaoDestinatario;
      Result := Result And fGeraDadosdasDuplicatas;
      Result := Result And fGeraDadosTransportes;
      Result := Result And fGeraDadosVolume;

      Result := Result And fGeraChavesReferenciadas;
      Result := Result And fGeraProdutoNfeComplemento;

    Except
      On E: Exception Do
      Begin
        CloseFile(txtArquivoSaida);
        Raise;
      End;
    End;

    Limpar;
    pGravarLogNFE(GetIPAddressAsString, strArqNfe, strNumDoc, FVenda.strEspDoc, strCodEmp,
      FVenda.strCodCli, FVenda.strSerFsc); 

  End;

  If Not Result Then
    DeleteFile(PChar(strArqNfe));

end;

function TNotaFiscalEletronica.fGeraChavesReferenciadas: Boolean;
  Var
    strLinha: String;
begin

  Try
    strLinha := '013' + '|';
    strLinha := strLinha + Venda.recNfeComplemento.strChaveAcesso + '|';
    strLinha := strLinha + fCadEmp('C_G_C_') + '|';
    strLinha := strlinha + '01' + '|';
    strLinha := strLinha + fRetCodigoUfIbge(fCadEmp('CODCID')) + '|';
    strLinha := strLinha + Venda.recNfeComplemento.strSerie + '|';
    strLinha := strLinha + Venda.recNfeComplemento.strNumDoc + '|';

    If Not fEmptyStr(Venda.recNfeComplemento.strChaveAcesso) Then
      strLinha := strLinha + FormatDateTime('YYMM', fRetDataEmissaoNfe)
    Else
      strLinha := strLinha + FormatDateTime('YYMM', Venda.dtaDtaEnt);

    Writeln(txtArquivoSaida, strLinha);
  Except

  End;

  Result := True;  
end;


function TNotaFiscalEletronica.fRetDataEmissaoNfe: TDate;
  Var
    qryGen : TUniQuery;
begin
  Result := 0;
  qryGen := fCriaQuery(Self);

  if Not fEmptyStr(Venda.recNfeComplemento.strChaveAcesso) then
  begin
    qryGen.SQL.Clear;

    qryGen.SQL.Add('SELECT *');
    qryGen.SQL.Add('FROM CADFIS');
    qryGen.SQL.Add('WHERE FIS_ACESSO = :ACESSO');
    qryGen.SQL.Add('    AND FIS_NUMDOC = :NUMDOC');
    qryGen.SQL.Add('    AND FIS_CODEMP = :CODEMP');
    qryGen.SQL.Add('    AND IFNULL(FIS_SERIE_, "") = :SERIE');
    qryGen.SQL.Add('    AND FIS_TIP_FC = "C"');
    qryGen.SQL.Add('    AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL")');

    qrygen.ParamByName('ACESSO').AsString := Venda.recNfeComplemento.strChaveAcesso;
    qryGen.ParamByName('NUMDOC').AsString := Venda.recNfeComplemento.strNumDoc;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('SERIE').AsString := Venda.recNfeComplemento.strSerie;

    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      FreeAndNil(qryGen);
      Raise ExceptionFalhaNFe.Create(Format('Não foi possivel encontrar nota fiscal eletrônica com a seguinte chave de acesso: #13#10 %s', [Venda.strChaveAcesso]));
    End;

    If fEmptyStr(qryGen.FieldByName('FIS_ACESSO').AsString) Then
    Begin
      FreeAndNil(qryGen);
      Raise ExceptionFalhaNFe.Create(Format('A data do cocumento não está preenchida!', []));
    End;

    Result := qrygen.FieldByName('FIS_DTADOC').AsDateTime;
  end;

  FreeAndNil(qryGen);
end;

function TNotaFiscalEletronica.fGeraProdutoNfeComplemento: Boolean;
  Var
    strLinha : String;
begin
  strLinha := '014' + '|';
  strLinha := strLinha + fStrZero('1', 3) + '|';
  strLinha := strLinha + '1' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + Venda.recNfeComplemento.strDescriItem + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + Venda.strClaFis + '|';
  strLinha := strLinha + 'UN' + '|';
  strLinha := strLinha + fFormataValor(0, 12, 4) + '|';
  strLinha := strLinha + fFormataValor(0, 16, 4) + '|';
  strLinha := stRlinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + 'UN' + '|';
  strLinha := strLinha + fFormataValor(0, 12, 4) + '|';
  strLinha := strLinha + fFormataValor(0, 16, 4) + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + '10' + '|';
  strLinha := strLinha + fReplicatorStr('|', 5);
  strLinha := strLinha + fReplicatorStr('|', 11);
  strLinha := strLinha + fReplicatorStr('|', 6);
  strLinha := strLinha + fReplicatorStr('|', 7);
  strLinha := strLinha + fReplicatorStr('|', 1);
  strLinha := strLinha + fReplicatorStr('|', 6);
  strLinha := strLinha + fReplicatorStr('|', 3);
  strLinha := strLinha + fReplicatorStr('|', 12);
  strLinha := strLinha + '0' + '|';
  strLinha := strLinha + '0' + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 5, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 5, 2) + '|';
  strLinha := strLinha + '0' + '|';
  strLinha := strLinha + fFormataValor(0, 5, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 5, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 5, 2) + '|';
  strLinha := strLinha + fFormataValor(0, 15, 2) + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '999' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '0' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '0' + '|';
  strLinha := strLinha + '0' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '' + '|';
  strLinha := strLinha + '5' + '|';
  strLinha := strLinha + fReplicatorStr('|', 15) + '|';
  strLinha := strLinha + '5' + '|';
  strLinha := strLinha + fReplicatorStr('|', 21);

  Writeln(txtArquivoSaida, strLinha);
  Result := True;

end;

function TNotaFiscalEletronica.fRetInformacoesAdicionaisNotComp: String;
  Const
    intLargura: Integer = 108;
begin
  Result := fPadR(Venda.strMenNc01, intLargura);
  Result := Result + fPadR(Venda.strMenNc02, intLargura);
  Result := Result + fPadR(Venda.strMenNc03, intLargura);
  Result := Result + fPadR(Venda.strMenNc04, intLargura);
  Result := Result + fPadR(Venda.strMenNc05, intLargura);
  Result := Result + fPadR(Venda.strMenNc06, intLargura);
  Result := Result + fPadR(Venda.strMenNc07, intLargura);
  Result := Result + fPadR(Venda.strMenNc08, intLargura);
  Result := Result + fPadR(Venda.strMenNc09, intLargura);
  Result := Result + fPadR(Venda.strMenNc10, intLargura);
  Result := Result + fRetInformacoesAdicionais();
  Result := Trim(Result);
end;

{**************************************************************************************}
{* - QUANDO FOR CFOP DE VENDA, CONTINUAR COMO E´ HOJE, INFORMANDO ESTES VALORES       *}
{*   NOS CAMPOS PROPRIOS, INDEPENDENTE SE A EMPRESA FOR SUBSTITUIDO OU SUBSTITUTO     *}
{*   E NAO INFORMAR NADA NOS DADOS ADICIONAIS.                                        *}
{*   - QUANDO NAO FOR CFOP DE VENDA, PROCEDER DA SEGUINTE FORMA:                      *}
{*     - SE A EMPRESA FOR 1-SUBSTITUÍDO TRIBUTARIO, IMPRIMIR ZERO NOS CAMPOS PROPRIOS *}
{*       PARA ESTES VALORES e INFORMAR NOS DADOS ADICIONAIS OS MESMOS.                *}
{*     - SE A EMPRESA FOR 2-SUBSTITUTO TRIBUTARIO, IMPRIMIR OS VALORES NOS CAMPOS     *}
{*       PROPRIOS E NAO INFORMAR NADA NOS DADOS ADICIONAIS.                           *}
{***********************************************************************************MV*}
function TNotaFiscalEletronica.fImprimeSubTributariaDadosProprios: Boolean;
begin

  {*****************************************}
  {* CLASSIFICAÇÃO DE VENDA                *}
  {**************************************MV*}
  If (Pos(Venda.strClaFis, VS_strClaVen) > 0) Or (Venda.strNotImp = 'S') Then
    Result := True
  Else
  Begin

    {*****************************************}
    {* 1 - SUBSTITUIDO TRIBUTARIO            *}
    {**************************************MV*}
    If (fCfgSis('CLASUB') = '1') Then
      Result := False

    {*****************************************}
    {* 2 - SUBSTITUTO TRIBUTÁRIO             *}
    {**************************************MV*}
    Else
      Result := True;

  End;


end;

function TNotaFiscalEletronica.fImprimeIPIDadosProprios: Boolean;
begin
  {*****************************************}
  {* CLASSIFICAÇÃO DE VENDA                *}
  {**************************************MV*}
  If (Pos(Venda.strClaFis, VS_strClaVen) > 0) Then
    Result := True
  Else
    Result := fCfgSis('CONIPI', varBoolean);
end;

{*****************************************}
{* ATENÇÃO: ESTA FUNÇÃO NÃO MUDA A EX-   *}
{* TENSÃO DO ARQUIVO EM SI, APENAS RETOR-*}
{* NA UMA STRING COM O NOME ALTERADO.    *}
{**************************************MV*}
function TNotaFiscalEletronica.fTrocaExtensaoNomeArq(
  strNomeArq, strNovaExt: String): String;
  Var
    strExt: String;
begin
  If (Not AnsiStartsText('.', strNovaExt)) Then
    strNovaExt := '.' + strNovaExt;

  strExt := ExtractFileExt(strNomeArq);
  Result := strNomeArq;

  Result := AnsiReplaceStr(Result, strExt, strNovaExt);
end;

procedure TNotaFiscalEletronica.pApagaArquivosDataOut(strNomeArq,
  strOperacaoOri, strOperacaoDest: String);
  Var
    strArqDataOut: String;
begin
  strArqDataOut := AnsiReplaceText(AnsiReplaceStr(strNomeArq, strOperacaoOri, strOperacaoDest), 'DataIn', 'DataOut');
  DeleteFile(PChar(strArqDataOut));

  strArqDataOut := fTrocaExtensaoNomeArq(strArqDataOut, '.TXT');
  DeleteFile(PChar(strArqDataOut));
end;

procedure TNotaFiscalEletronica.pAtualizarLogNFE(strNumIp,
  strNomArq: String; intCodAut: Integer; strAcesso: String);
  Var
    qryAux: TUniQuery;
begin

  strNomArq := AnsiReplaceStr(strNomArq, 'ENVO', 'ENVI');

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE LOGNFE SET ');
  qryAux.SQL.Add('  NFE_CODAUT = :CODAUT, ');
  qryAux.SQL.Add('  NFE_ACESSO = :ACESSO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  NFE_NOMARQ = :NOMARQ AND ');
  qryAux.SQL.Add('  NFE_CODEMP = :CODEMP ');

  qryAux.ParamByName('CODAUT').AsInteger := intCodAut;
  qryAux.ParamByName('ACESSO').AsString  := strAcesso;

  qryAux.ParamByName('NOMARQ').AsString := ExtractFileName(strNomArq);
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TNotaFiscalEletronica.pAtualizarStatusLogNFE(strNumIp, strNomArq,
  strStatus: String);
  Var
    qryAux: TUniQuery;
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strSerie: String;
begin

  If fEmptyStr(strNomArq) Then
    strNomArq := strNomeArquivoAtual;

  strNomArq := AnsiReplaceStr(strNomArq, 'ENVO', 'ENVI');

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE LOGNFE SET ');
  qryAux.SQL.Add('  NFE_STATUS = :STATUS ');

  If strStatus = NFE_OPERACAO_OK Then
    qryAux.SQL.Add('  , NFE_EMPROC = :EMPROC ');

  qryAux.SQL.Add('WHERE ');

  qryAux.SQL.Add('  NFE_NOMARQ = :NOMARQ AND ');
  qryAux.SQL.Add('  NFE_CODEMP = :CODEMP ');

  qryAux.ParamByName('STATUS').AsString := strStatus;

  If strStatus = NFE_OPERACAO_OK Then
    qryAux.ParamByName('EMPROC').AsInteger := 0;

  qryAux.ParamByName('NOMARQ').AsString := ExtractFileName(strNomArq);
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryAux.ExecSQL;

  If (strStatus = NFE_OPERACAO_OK) Then
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  NFE_NUMDOC, ');
    qryAux.SQL.Add('  NFE_ESPDOC, ');
    qryAux.SQL.Add('  NFE_CODEMP, ');
    qryAux.SQL.Add('  NFE_CODCLI, ');
    qryAux.SQL.Add('  NFE_SERIE_ ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  LOGNFE ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  NFE_NOMARQ = :NOMARQ AND ');
    qryAux.SQL.Add('  NFE_CODEMP = :CODEMP ');

    qryAux.ParamByName('NOMARQ').AsString := ExtractFileName(strNomArq);
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    strNumDoc := qryAux.FieldByName('NFE_NUMDOC').AsString;
    strEspDoc := qryAux.FieldByName('NFE_ESPDOC').AsString;
    strCodEmp := qryAux.FieldByName('NFE_CODEMP').AsString;
    strCodCli := qryAux.FieldByName('NFE_CODCLI').AsString;
    strSerie  := qryAux.FieldByName('NFE_SERIE_').AsString;

    qryAux.Close;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE LOGNFE SET ');
    qryAux.SQL.Add('  NFE_STATUS = :STATUS, ');
    qryAux.SQL.Add('  NFE_EMPROC = :EMPROC ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  NFE_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(NFE_SERIE_, "") = :SERIE_ ');

    qryAux.ParamByName('STATUS').AsString := strStatus;
    qryAux.ParamByName('EMPROC').AsInteger := 0;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ExecSQL;
  End;

  FreeAndNil(qryAux);
end;

procedure TNotaFiscalEletronica.pGravarLogNFE(strNumIp, strNomArq,
  strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String);
  Var
    qryAux: TUniQuery;
begin

  strNomArq := ExtractFileName(strNomArq);
  strNomArq := FormatDateTime('yyyymmddhhnnss', VS_Date + Time) + '_' + strNomArq;

  strNomeArquivoAtual := strNomArq;
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('INSERT INTO LOGNFE (');
  qryAux.SQL.Add('  NFE_NUM_IP, ');
  qryAux.SQL.Add('  NFE_NOMARQ, ');
  qryAux.SQL.Add('  NFE_NUMDOC, ');
  qryAux.SQL.Add('  NFE_ESPDOC, ');
  qryAux.SQL.Add('  NFE_CODEMP, ');
  qryAux.SQL.Add('  NFE_CODCLI, ');
  qryAux.SQL.Add('  NFE_SERIE_, ');
  qryAux.SQL.Add('  NFE_STATUS, ');
  qryAux.SQL.Add('  NFE_EMPROC, ');
  qryAux.SQL.Add('  NFE_HORINI) ');
  qryAux.SQL.Add('VALUES ( ');
  qryAux.SQL.Add('  :NUM_IP, ');
  qryAux.SQL.Add('  :NOMARQ, ');
  qryAux.SQL.Add('  :NUMDOC, ');
  qryAux.SQL.Add('  :ESPDOC, ');
  qryAux.SQL.Add('  :CODEMP, ');
  qryAux.SQL.Add('  :CODCLI, ');
  qryAux.SQL.Add('  :SERIE_, ');
  qryAux.SQL.Add('  :STATUS, ');
  qryAux.SQL.Add('  :EMPROC, ');
  qryAux.SQL.Add('  :HORINI) ');

  qryAux.ParamByName('NUM_IP').AsString   := strNumIp;
  qryAux.ParamByName('NOMARQ').AsString   := strNomArq;
  qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString   := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString   := strCodCli;
  qryAux.ParamByName('SERIE_').AsString   := fStrZero(strSerie, 3);
  qryAux.ParamByName('STATUS').AsString   := NFE_CANCELAMENTO_PENDENTE;
  qryAux.ParamByName('EMPROC').AsInteger  := 0;
  qryAux.ParamByName('HORINI').AsDateTime := VS_Date + Time;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

class function TNotaFiscalEletronica.fCancelamentosPendentes(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogNfe: TUniQuery;
    strNumDoc: String;
    strCodCli: String;
    strArquivo: String;

    procedure pTravarTabela(strNomeTabela: String; blnTravar: Boolean);
    begin
      fLock_Unlock(strNomeTabela, blnTravar, True, True)
    end;

begin

  Result := True;

  If Not fTemCancelamentoPendente Then
    Exit;

  strNumDoc  := '';
  strCodCli  := '';
  strArquivo := '';

  qryLogNfe := fCriaQuery(Nil);
  qryLogNfe.SQL.Add('SELECT ');
  qryLogNfe.SQL.Add('  NFE_NUMDOC, ');
  qryLogNfe.SQL.Add('  NFE_CODCLI, ');
  qryLogNfe.SQL.Add('  NFE_NOMARQ, ');
  qryLogNfe.SQL.Add('  NFE_EMPROC ');
  qryLogNfe.SQL.Add('FROM ');
  qryLogNfe.SQL.Add('  LOGNFE ');
  qryLogNfe.SQL.Add('WHERE ');
  qryLogNfe.SQL.Add('  NFE_STATUS = :STATUS AND ');
  qryLogNfe.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
  qryLogNfe.SQL.Add('  NFE_EMPROC = FALSE   AND ');
  qryLogNfe.SQL.Add('  TIMEDIFF(NOW(), NFE_HORINI) > "' + NFE_TEMPO_ESPERA_CP + '" ');
  qryLogNfe.SQL.Add('ORDER BY ');
  qryLogNfe.SQL.Add('  NFE_NUMDOC ');
  qryLogNfe.SQL.Add('LIMIT 1 ');

  Try
    //pTravarTabela('LOGNFE', True);

    qryLogNfe.Close;

    qryLogNfe.ParamByName('STATUS').AsString := NFE_CANCELAMENTO_PENDENTE;
    qryLogNfe.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryLogNfe.Open;

    strNumDoc  := qryLogNfe.FieldByName('NFE_NUMDOC').AsString;
    strCodCli  := qryLogNfe.FieldByName('NFE_CODCLI').AsString;
    strArquivo := qryLogNfe.FieldByName('NFE_NOMARQ').AsString;

//    qryLogNfe.Edit;
//    qryLogNfe.FieldByName('NFE_EMPROC').AsInteger := 1;
//    qryLogNfe.Post;
    If fLock_Unlock('NFE_' + strNumDoc + '_' + strArquivo, True, False, True) Then
    Begin

      //pTravarTabela('LOGNFE', False);

      If Not fEmptyStr(strNumDoc) Then
      Begin
        If fMensagem('ATENÇÃO!', 'A nota fiscal eletrônica Nº ' + strNumDoc + ' do cliente ' +
                                 fRetNomCliente(strCodCli) + ' não está totalmente cancelada. ' +
                                 'Deseja enviar seu cancelamento agora?', ['&Sim', '&Não']) = 1 Then
        Begin
          pEnviarCancelamentoNFE(strNumDoc, strCodCli, strArquivo, pgbProgresso);
        End
        Else
        Begin
          Result := False;
        End;
      End;

      fLock_Unlock('NFE_' + strNumDoc + '_' + strArquivo, False, False, True);

    End
    Else
      NFE_AbortarVerificacaoCancelamentoPendente := True;

//    qryLogNfe.Edit;
//    qryLogNfe.FieldByName('NFE_EMPROC').AsInteger := 0;
//    qryLogNfe.Post;

  Except
    On E: Exception Do
    Begin
      Raise;
      //pTravarTabela('LOGNFE', False);
    End;
  End;
  FreeAndNil(qryLogNfe);

end;

class procedure TNotaFiscalEletronica.pEnviarCancelamentoNFE(strNumDoc,
  strCodCli, strArquivo: String; pgbProgresso: TcxProgressBar);
  Var
    qryCodCli: TUniQuery;
    notaEletronica: TNotaFiscalEletronica;
    blnResult: Boolean;
begin
  qryCodCli := fCriaQuery(Nil);
  qryCodCli.SQL.Add('SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
  qryCodCli.ParamByName('CODCLI').AsString := strCodCli;
  qryCodCli.Open;

  notaEletronica := TNotaFiscalEletronica.Create(Nil, strNumDoc, qryCodCli);

  blnResult := notaEletronica.fCancelarNotaFiscal;
  If blnResult Then
    pgbProgresso.Position := pgbProgresso.Position + 1;

  blnResult := blnResult And notaEletronica.fProcessaRetornoCancelamento;

  If blnResult Then
    pgbProgresso.Position := pgbProgresso.Position + 1;

  If Not blnResult Then
  Begin
    fRollBack;
    fMensagem('ATENÇÃO', notaEletronica.StrRetorno, ['OK']);
  End
  Else
  Begin
    notaEletronica.pAtualizarStatusLogNFE('', strArquivo, NFE_OPERACAO_OK);
  End;

  FreeAndNil(notaEletronica);

  FreeAndNil(qryCodCli);
end;

class function TNotaFiscalEletronica.fTemCancelamentoPendente: Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM LOGNFE WHERE NFE_CODEMP = :CODEMP AND NFE_STATUS = :STATUS AND ');
  qryAux.SQL.Add('TIMEDIFF(NOW(), NFE_HORINI) > "' + NFE_TEMPO_ESPERA_CP + '"');

  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('STATUS').AsString := NFE_CANCELAMENTO_PENDENTE;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

class procedure TNotaFiscalEletronica.pVerificaCancelamentosPendentes;
begin
  //CHAMAR O GRAVANDO AQUI
  NFE_AbortarVerificacaoCancelamentoPendente := False;
  While (fTemCancelamentoPendente) And (Not NFE_AbortarVerificacaoCancelamentoPendente) Do
  Begin
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCancelamentosPendentes;
    frmGravando.lblGravando.Caption      := 'Aguarde, enviando cancelamento...';
    frmGravando.blnConfirma              := False;
    frmGravando.pgbStatus.Position       := 0;
    frmGravando.pgbStatus.Properties.Max := 2;
    frmGravando.ShowModal;

    If (Not frmGravando.blnConfirma) Then
    Begin
      pFreeAndNil(frmGravando);
      Raise EVerificacaoCancelamentoPendenteCancelada.Create('Verificação de cancelamento cancelada. Não será permitido prosseguir.');
    End;

    pFreeAndNil(frmGravando);
  End;
end;

procedure TNotaFiscalEletronica.pDeletarLogNFE;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('DELETE FROM LOGNFE WHERE NFE_NOMARQ = :NOMARQ AND NFE_CODEMP = :CODEMP ');
  qryAux.ParamByName('NOMARQ').AsString := ExtractFileName(strNomeArquivoAtual);
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

function TNotaFiscalEletronica.GetNumeroEnderecoCliente(
  strCodCli: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT CLI_ENDNUM FROM CADCLI WHERE CLI_CODCLI = :CODCLI';
  qryGen.ParamByName('CODCLI').AsString := strCodCli;
  qryGen.Open;

  Result := qryGen.FieldByName('CLI_ENDNUM').AsString;
  FreeAndNil(qryGen);
end;

procedure TNotaFiscalEletronica.SetStrMotivoCancelamento(
  const Value: String);
begin
  FStrMotivoCancelamento := Value;
end;

function TNotaFiscalEletronica.fRetPontoImpressao: String;
Var
  strSQL: String;
  qryPon: TUniQuery;
begin

  Result := '';

  Try

    qryPon := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  PONIMP ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PON_CODEMP = :CODEMP ';

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
        pCriarFormularios(TfrmPontosImpressao, frmPontosImpressao);
        frmPontosImpressao.qryPon := qryPon;
        frmPontosImpressao.ShowModal;

        If (frmPontosImpressao.ModalResult = mrOk) Then
          Result := frmPontosImpressao.strPonImp;

        pFreeAndNil(frmPontosImpressao);
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TNotaFiscalEletronica.fRetPontoImpressao]');
  End;

end;

function TNotaFiscalEletronica.fImprimeDuplicatasCnfe: Boolean;
  Var
    qryCnf: TUniQuery;
    strRetorno: String;
begin

  Result := True;

  qryCnf := fCriaQuery(Self);
  qryCnf.SQL.Text := 'SELECT * FROM CNF_NFE WHERE CNF_SETOR_ = "02" AND CNF_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ORDER BY CNF_IDENTI ';
  qryCnf.Open;

  If qryCnf.IsEmpty Then
  Begin
    Exit;
  End;

  { FUNC MACRO }
  pInicializaVariaveis;

  strRetorno := fProcessaMacro(Venda, nil, qryCnf.FieldByName('CNF_DESCAM').AsString);

  Result := (StrToIntDef(strRetorno, 0) = 1);

  lstVariaveis.Clear;
  FreeAndNil(qryCnf);
end;

{ ExceptionNFeNaoAutorizada }

function TNotaFiscalEletronica.fRetOrigemMercadoria(
  strCodsit: String): String;
begin
  Result := LeftStr(strCodsit, 1);
end;

{ ExceptionNFeNaoAutorizada }

constructor ExceptionNFeNaoAutorizada.Create(var
  notaFiscalEletronica: TNotaFiscalEletronica);
  Var
    strRetorno: String;
begin
  strRetorno := notaFiscalEletronica.StrRetorno;
  FreeAndNil(notaFiscalEletronica);
  inherited Create(strRetorno);
end;

{*****************************************************************************************}
{* CARREGA AS VARIAVEIS DOS ITENS QUE NÃO SÃO CARREGADAS POR ALGUM MOTIVO NO FATURAMENTO *}
{**************************************************************************************PH*}
procedure TNotaFiscalEletronica.pCarregaDadosItens;
  Var
    intCont: Integer;
    qryGen: TUniQuery;
begin

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE';

  For intCont := Low(FItens) To High(FItens) Do
  Begin

    qryGen.Close;
    qryGen.ParamByName('CODITE').AsString := Itens[intCont].strCodIte;
    qryGen.Open;

    FItens[intCont].strClaIpi := qryGen.FieldByName('ITE_CLAIPI').AsString;
  End;

  {****************************************************}
  {* CARREGA NOME DA CIDADE CASO NAO ESTAJA CARREGADA *}
  {*************************************************PH*}
  If Not fEmptyStr(fRetNomCidade(Venda.strCidEnt)) Then
    Venda.strCidEnt := fRetNomCidade(Venda.strCidEnt);

  If fEmptyStr(Venda.strCliNum) Then
    Venda.strCliNum := GetNumeroEnderecoCliente(Venda.strCodCli);    
end;

function TNotaFiscalEletronica.fQuebraStringLinhas(strMensagem: String;
  intTamanho: Integer): String;
  Var
    stlMsg : TStringList;
    intCont: Integer;
begin

  Result := '';

  stlMsg := TStringList.Create;
  stlMsg.Text := WrapText(strMensagem, #13#10, [' '], intTamanho);

  For IntCont := 0 To stlMsg.Count -1 Do
    Result := Result + fPadR(AnsiReplaceStr(stlMsg[IntCont], #13#10, ''), intTamanho);

  FreeAndNil(stlMsg);
end;

{*****************************************}
{* VERIFICA SE O ARQUIVO ESTÁ PRONTO.    *}
{* PARA TAL, VERIFICA SE O ARQUIVO PODE  *}
{* SER ABERTO. CASO POSITIVO, VERIFICA,  *}
{* ATRAVÉS DO SEU TAMANHO, SE O MESMO JÁ *}
{* TERMINOU DE SER ESCRITO.              *}
{**************************************MV*}
function TNotaFiscalEletronica.fArquivoPronto(strArquivo: String): Boolean;
  Var
    sfsArquivo: TFileStream;
    intTamanho: Cardinal;
    blnDiferente: Boolean;
    intCont: Integer;
begin

  Result := False;
  Try
    sfsArquivo := TFileStream.Create(strArquivo, fmOpenRead Or fmShareExclusive);
    FreeAndNil(sfsArquivo);

    intTamanho := fTamanhoArquivo(strArquivo);
    blnDiferente := False;

    For intCont := 1 To 3 Do
    Begin

      Sleep(200);
      If intTamanho <> fTamanhoArquivo(strArquivo) Then
      Begin
        blnDiferente := True;
      End;

    End;

    Result := (Not blnDiferente);
  Except
    //
  End;

end;

{********************************************************}
{* FAZ UMA COPIA DA MATRIZ DE ITENS DA VENDA, PARA SER  *}
{* UTILIZADA PELA NFE, NO CASO DE HAVER ITEM DE SERVIÇO *}
{* INSERE OS SERVICOS DIGITADOS COMO SE FOSSEM ITENS    *}
{* DO DOCUMENTO....                                     *}
{*****************************************************JC*}
function TNotaFiscalEletronica.fGerarMatrizItensServicos(Itens: TMatrizFechamento; Venda: TFatVenda): TMatrizFechamento;
  Var
    intIndex : Integer;
    intAux   : Integer;

    procedure pAdicionarRegistro(recDados: TDadosFechamento);
    begin
       SetLength(Result, Length(Result) + 1);
       Result[Length(Result) - 1] := recDados;
    end;

begin
  SetLength(Result, 0);

  For intIndex := Low(Itens) To High(Itens) Do
    If Not fEhItemServico(Itens[intIndex].strCodIte) Then
      pAdicionarRegistro(Itens[intIndex])
    Else
      For intAux := 1 To MAX_SERVICOS_VENDA Do
        If Not fEmptyStr(GetPropValue(Venda, 'strDesS' + FormatFloat('00', intAux))) Then
        Begin
          pAdicionarRegistro(Itens[intIndex]);
          Result[Length(Result) - 1].strDesIte := GetPropValue(Venda, 'strDesS' + FormatFloat('00', intAux));
          Result[Length(Result) - 1].fltUniTar := GetPropValue(Venda, 'fltValS' + FormatFloat('00', intAux));
          Result[Length(Result) - 1].fltTotIte := GetPropValue(Venda, 'fltValS' + FormatFloat('00', intAux));
          Result[Length(Result) - 1].fltTotcus := GetPropValue(Venda, 'fltValS' + FormatFloat('00', intAux));
        End;
end;

class function TNotaFiscalEletronica.fVerificaCancelamentosPendentesPainel(strEspecie: String = ''): Boolean;
Var
  strSQL: String;
  qryGenNFE: TUniQuery;
begin
  Try

    qryGenNFE := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT    ';
    strSQL := strSQL + '  NFE_NUMDOC  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  LOGNFE  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  NFE_ESPDOC <> "IF" AND ';
    strSQL := strSQL + '  NFE_ESPDOC <> "IV" AND ';
    strSQL := strSQL + '  NFE_STATUS NOT IN("AT","CN","OK","DC","IN") AND  ';
    strSQL := strSQL + '  NFE_CODEMP = :CODEMP  ';

    If Not fEmptyStr(strEspecie) Then
      strSQL := strSQL + '  AND NFE_ESPDOC = :ESPDOC ';

    With qryGenNFE Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(strEspecie) Then
        ParamByName('ESPDOC').AsString := strEspecie;

      Open;

      Result := (IsEmpty);
    End;

  Finally
    FreeAndNil(qryGenNFE);
  End;

end;

end.
