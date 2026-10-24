{*********************************************************}
{* CLASSE FRETE DE CONHECIMENTO                          *}
{*                                                       *}
{* DATA......: 31/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untEntFreCon;

interface

uses  StrUtils, SysUtils, Uni, Db, Classes, Forms, UniClientDataSet, Math,
      untFuncoesSimples, StdCtrls, untZClient, Variants, untTypesSistema,
      untEntOutrasDespesas, untParCalculaPrecoCusto, cxProgressBar,untPesqAux,
      untEntIcmsAntecipado, Windows, XMLDoc, XMLIntf, ComCtrls,
      Generics.Collections, untPortadorFornecedor, Rtti, TypInfo,
      untGravando, untTypePesCte,
      untCadLivroFiscal,
      untCancelamentoDocumentos, untFrmManipulaContasPagarPrevisaoNao;

Type




  TArrAutInc = Array Of String;
  TFreCon = Class(TComponent)
  Private
    XML: IXMLNode;
    blnUSACND : Boolean;
    blnUtilizaContabilidade : Boolean;

    blnCtpBol: Boolean;
    blnImportaPeloBancoDados: Boolean;

    FAtulizarTabela: Boolean;

    FNotEnt: TUniQuery;
    cdsNotasFiscais: TZClient;
    cdsComplementos: TZClient;
    FConsulta: TUniQuery;
    FEmpresas: TUniQuery;

    FFreIpi: Boolean;
    FIsDocDCe: Boolean;

    FGravando: TFrmGravando;

    FAutInc,
    FCgcTra,
    FCGCRem,
    FCGCDes,
    FForPag,
    FTomSer: String;
    FRemetente: TPessoaCTE ;
    FEmitente: TPessoaCTE ;
    FExpedidor: TPessoaCTE ;
    FRecebedor: TPessoaCTE ;
    FDestinatario: TPessoaCTE ;
    FTomador: TPessoaCTE ;
    FCreditaICMS: Boolean;
    FCndVaz: String;
    FSeqPag: TArrAutInc;// AUTOINCREMENTO DO PRIMEIRO REGISTRO DO CONTAS A PAGAR - SERÁ USADO NO CAIXA 2 PARA GRAVAR O VINCULO DO CONH.FRETE COM A NOTA
    FstrPath: String;
    FNumDoc: String;    // Numero do Documento
    FSerie_: String;    // Serie
    FEspDoc: String;    // Especie

    FVeioNF : String; // Veio NF
    FstrArquivoXML: String;
    FUsaChq : String; // Usa Cheque
    FPrevis : String; // Previsão
    FPagAnt : String; // Pagamento antecipado
    FUsoCon : String; // Uso e Consumo
    FTipDoc : String; // Tipo do documento
    FGuiTri : String; // Guia do Tributo
    FTipTri : String; // Tipo do Tributo

    FDeposi : String; // Deposito (S/N)
    FTRANSF: String;   // Transferencia (S/N)
    FBcoFor : String; // Conta Banco
    FBrinde : String; // Deposito (S/N)

    FModelo: String;    // Modelo Fical

    FModFre: String;    // Modalidade
    FCodTra: String;    // Transportadora
    FCodMunicipioInicio: String;
    FMunicipioDescricaoInicio: String;
    FCodMunicipioFim: String;
    FMunicipioDescricaoFim: String;
    FUFInicio: String;
    FUFFim: String;
    FTraLot: String;    // Lote Cte
    //FC_G_C_: String;    // CNPJ-CPF
    FDuplic: String;
    FLinDig: String;
    FCodBar: String;
    FEstTra: String;    // Estado da Transportadora;
    FHis001: String;    // Histórico
    FCndPag: String;    // Condição de Pagamento
    FCodCta: String;    // Plano de Contas a Pagar
    FCtaRec: String;    // Plano de Contas a Receber
    FCodEve: String;    // Evento
    FCompet: String;    // Competencia
    FCndXML: String;    // Condição de Pag encontrada no XML S/N
    FValDoc: Double;    // Valor Documento
    FValTot: Double;    // Valor Total Documentos
    FDtaEnt: TDateTime; // Data de Entrada
    FDtaDoc: TDateTime; // Data de Documento
    FDtaOpe: TDateTime; // Data de Cancelamento Operador
    FDtaCan: TDateTime; // Data de Cancelamento

    FClaFi1: String;    // Classificação Fiscal 1
    FClaFiXML: String;    // Classificação Fiscal 1
    FValCo1: Double;    // Valor Contábil 1
    FBasIc1: Double;    // Base de ICMS 1
    FAlqIc1: Double;    // Aliquota de ICMS 1
    FValIc1: Double;    // Valor de ICMS 1
    FValOu1: Double;    // Valor de Outras 1
    FValIs1: Double;    // Valor de Isento 1
    FValRe1: Double;    // Valor de Retido 1
    FBasIp1: Double;    // Base de IPI 1
    FValIp1: Double;    // Valor de IPI 1
    FBasSu1: Double;    // Base de Substituição 1
    FDesAc1: Double;    // Valor de Despesa Acessária 1

    FClaFi2: String;    // Classificação Fiscal 2
    FValCo2: Double;    // Valor Contábil 2
    FBasIc2: Double;    // Base de ICMS 2
    FAlqIc2: Double;    // Aliquota de ICMS 2
    FValIc2: Double;    // Valor de ICMS 2
    FValOu2: Double;    // Valor de Outras 2
    FValIs2: Double;    // Valor de Isento 2
    FValRe2: Double;    // Valor de Retido 2
    FBasIp2: Double;    // Base de IPI 2
    FValIp2: Double;    // Valor de IPI 2
    FBasSu2: Double;    // Base de Substituição 2
    FDesAc2: Double;    // Valor de Despesa Acessária 2

    FClaFi3: String;    // Classificação Fiscal 3
    FValCo3: Double;    // Valor Contábil 3
    FBasIc3: Double;    // Base de ICMS 3
    FAlqIc3: Double;    // Aliquota de ICMS 3
    FValIc3: Double;    // Valor de ICMS 3
    FValOu3: Double;    // Valor de Outras 3
    FValIs3: Double;    // Valor de Isento 3
    FValRe3: Double;    // Valor de Retido 3
    FBasIp3: Double;    // Base de IPI 3
    FValIp3: Double;    // Valor de IPI 3
    FBasSu3: Double;    // Base de Substituição 3
    FDesAc3: Double;    // Valor de Despesa Acessária 3

    FClaFi4: String;    // Classificação Fiscal 4
    FValCo4: Double;    // Valor Contábil 4
    FBasIc4: Double;    // Base de ICMS 4
    FAlqIc4: Double;    // Aliquota de ICMS 4
    FValIc4: Double;    // Valor de ICMS 4
    FValOu4: Double;    // Valor de Outras 4
    FValIs4: Double;    // Valor de Isento 4
    FValRe4: Double;    // Valor de Retido 4
    FBasIp4: Double;    // Base de IPI 4
    FValIp4: Double;    // Valor de IPI 4
    FBasSu4: Double;    // Base de Substituição 4
    FDesAc4: Double;    // Valor de Despesa Acessária 4

    FPesoBruto: Double;  //Peso Bruto

    FClaFi5: String;    // Classificação Fiscal 5
    FValCo5: Double;    // Valor Contábil 5
    FBasIc5: Double;    // Base de ICMS 5
    FAlqIc5: Double;    // Aliquota de ICMS 5
    FValIc5: Double;    // Valor de ICMS 5
    FValOu5: Double;    // Valor de Outras 5
    FValIs5: Double;    // Valor de Isento 5
    FValRe5: Double;    // Valor de Retido 5
    FBasIp5: Double;    // Base de IPI 5
    FValIp5: Double;    // Valor de IPI 5
    FBasSu5: Double;    // Base de Substituição 5
    FDesAc5: Double;    // Valor de Despesa Acessária 5
    FblnGraCTP: Boolean;  // Verifica se ira gravar Contas a Pagar

    FPorBai: String;    // Portador da Baixa

    FAntIc1,
    FBasAn1,
    FAntIc2,
    FBasAn2,
    FAntIc3,
    FBasAn3,
    FAntIc4,
    FBasAn4,
    FAntIc5,
    FBasAn5,

    FAlqPis,
    FAlqCof,
    FPerBasPis,
    FPerBasCof : Double;

    FCstPis,
    FCstCof,
    FAutPis,
    FAutCof,

    FAcesso : String;
    FCodEmp: string;
    FstrTipoFJ: String;

    FMemLog: TStrings;
    FMemErr: TStrings;

    FAutFis: String;

    FImpFre: Boolean;
    FEmpresaPagadora: String;

    FCtpConOutDes: Integer;

    cpcParams: TParCalculaPrecoCusto;

    blnATPVMB: array[1..7] of Boolean;
    FLogImportacao : TStringList;

    FListaClaFis: TStringList;

    cdsAbrPis,
    cdsAbrCof: TZClient;

    FPortadorFornecedor : TPortadorFornecedor;

    qryCTes: TUniQuery;
    FblnMostraLog: Boolean;

    FvREC : Double;

    {***************************************}
    {* FUNÇOES DE LEITURA DAS PROPRIEDADES *}
    {************************************AF*}
    function getAlqIc1: String;
    function getAlqIc2: String;
    function getAlqIc3: String;
    function getAlqIc4: String;
    function getAlqIc5: String;
    function getBasIc1: String;
    function getBasIc2: String;
    function getBasIc3: String;
    function getBasIc4: String;
    function getBasIc5: String;
    function getBasIp1: String;
    function getBasIp2: String;
    function getBasIp3: String;
    function getBasIp4: String;
    function getBasIp5: String;
    function getBasSu1: String;
    function getBasSu2: String;
    function getBasSu3: String;
    function getBasSu4: String;
    function getBasSu5: String;
    function getDesAc1: String;
    function getDesAc2: String;
    function getDesAc3: String;
    function getDesAc4: String;
    function getDesAc5: String;
    function getDesTra: String;
    function GetEstTra: String;
    function getDtaDoc: String;
    function getDtaEnt: String;
    function getValCo1: String;
    function getValCo2: String;
    function getValCo3: String;
    function getValCo4: String;
    function getValCo5: String;
    function getValDoc: String;
    function getValIc1: String;
    function getValIc2: String;
    function getValIc3: String;
    function getValIc4: String;
    function getValIc5: String;
    function getValIp1: String;
    function getValIp2: String;
    function getValIp3: String;
    function getValIp4: String;
    function getValIp5: String;
    function getValIs1: String;
    function getValIs2: String;
    function getValIs3: String;
    function getValIs4: String;
    function getValIs5: String;
    function getValOu1: String;
    function getValOu2: String;
    function getValOu3: String;
    function getValOu4: String;
    function getValOu5: String;
    function getValRe1: String;
    function getValRe2: String;
    function getValRe3: String;
    function getValRe4: String;
    function getValRe5: String;
    function getDesCta: String;
    function getAlqIcT: String;
    function getBasIcT: String;
    function getBasIpT: String;
    function getBasSuT: String;
    function getDesAcT: String;
    function getValCoT: String;
    function getValIcT: String;
    function getValIpT: String;
    function getValIsT: String;
    function getValOuT: String;
    function getValReT: String;
    function getValTot: Double;

    function getAntIc1: String;
    function getBasAn1: String;
    function getAntIc2: String;
    function getBasAn2: String;
    function getAntIc3: String;
    function getBasAn3: String;
    function getAntIc4: String;
    function getBasAn4: String;
    function getAntIc5: String;
    function getBasAn5: String;

    function getBasAnT: String;
    function getAntIcT: String;
    function fCarregaTXT(stlFrete: TStringList; memLog, memErr: TStrings): Boolean;
    function fGetCodEmp(CNPJ: string): string;
    function fGetSqlNotasFiscais: string;
    function fGetSqlComplementos: string;
    function fGetTipDocFrete: TTipoDocFrete;

    {*******************************************}
    {* PROCEDURES DE GRAVAÇÃO DAS PROPRIEDADES *}
    {****************************************AF*}
    procedure setAlqIc1(const Value: String);
    procedure setAlqIc2(const Value: String);
    procedure setAlqIc3(const Value: String);
    procedure setAlqIc4(const Value: String);
    procedure setAlqIc5(const Value: String);
    procedure setBasIc1(const Value: String);
    procedure setBasIc2(const Value: String);
    procedure setBasIc3(const Value: String);
    procedure setBasIc4(const Value: String);
    procedure setBasIc5(const Value: String);
    procedure setBasIp1(const Value: String);
    procedure setBasIp2(const Value: String);
    procedure setBasIp3(const Value: String);
    procedure setBasIp4(const Value: String);
    procedure setBasIp5(const Value: String);
    procedure setBasSu1(const Value: String);
    procedure setBasSu2(const Value: String);
    procedure setBasSu3(const Value: String);
    procedure setBasSu4(const Value: String);
    procedure setBasSu5(const Value: String);
    procedure setCodCta(const Value: String);
    procedure setCtaRec(const Value: String);
    procedure setCodTra(const Value: String);
    procedure setDesAc1(const Value: String);
    procedure setDesAc2(const Value: String);
    procedure setDesAc3(const Value: String);
    procedure setDesAc4(const Value: String);
    procedure setDesAc5(const Value: String);
    procedure setDtaDoc(const Value: String);
    procedure setDtaEnt(const Value: String);
    procedure setEspDoc(const Value: String);
    procedure setNumDoc(const Value: String);
    procedure setModelo(const Value: String);
    procedure setValCo1(const Value: String);
    procedure setValCo2(const Value: String);
    procedure setValCo3(const Value: String);
    procedure setValCo4(const Value: String);
    procedure setValCo5(const Value: String);
    procedure setValDoc(const Value: String);
    procedure setValIc1(const Value: String);
    procedure setValIc2(const Value: String);
    procedure setValIc3(const Value: String);
    procedure setValIc4(const Value: String);
    procedure setValIc5(const Value: String);
    procedure setValIp1(const Value: String);
    procedure setValIp2(const Value: String);
    procedure setValIp3(const Value: String);
    procedure setValIp4(const Value: String);
    procedure setValIp5(const Value: String);
    procedure setValIs1(const Value: String);
    procedure setValIs2(const Value: String);
    procedure setValIs3(const Value: String);
    procedure setValIs4(const Value: String);
    procedure setValIs5(const Value: String);
    procedure setValOu1(const Value: String);
    procedure setValOu2(const Value: String);
    procedure setValOu3(const Value: String);
    procedure setValOu4(const Value: String);
    procedure setValOu5(const Value: String);
    procedure setValRe1(const Value: String);
    procedure setValRe2(const Value: String);
    procedure setValRe3(const Value: String);
    procedure setValRe4(const Value: String);
    procedure setValRe5(const Value: String);
    procedure setClaFi1(const Value: String);
    procedure setClaFiXML(const Value: String);
    procedure setClaFi2(const Value: String);
    procedure setClaFi3(const Value: String);
    procedure setClaFi4(const Value: String);
    procedure setClaFi5(const Value: String);
    procedure setCndPag(const Value: String);
    procedure setHis001(const Value: String);

    procedure setAntIc1(const Value: String);
    procedure setBasAn1(const Value: String);
    procedure setAntIc2(const Value: String);
    procedure setBasAn2(const Value: String);
    procedure setAntIc3(const Value: String);
    procedure setBasAn3(const Value: String);
    procedure setAntIc4(const Value: String);
    procedure setBasAn4(const Value: String);
    procedure setAntIc5(const Value: String);
    procedure setBasAn5(const Value: String);
    procedure setAcesso(const Value: String);

    Function fCarregaAbrevPisCof(blnAtualizarTabela: Boolean = True): Boolean;
    Function fCarregaAbrevPisCofPrg(prgProgresso: TcxProgressBar): Boolean;
    Function fInformarPisCofins: Boolean;

    Function fRetCondicaoPagto(nodDup : IXMLNode; dtaDtaBas: TDateTime; Var strDuplictas: String): String;

    function fConfirmaImportacao(strNomArq: String; var strErroInt: String; blnRegistroCorrente: Boolean = False): Boolean;
    function fMarcaCTeImportado(): Boolean;
    function fMarcaCTeComErro(): Boolean;

    procedure pRecalculaBasIcm(strChaveCte: string; var strRelacNotas: string; var strNotasIn: string);
    function fTodas_Notas_CTE_Vinculadas_Com_Documento(strChaveCte: String): boolean;



    function fGravaCadFisSaida(strCodCli, strEmpFil, strClaFisXML: String): Boolean;

    function fGravaCadRecSaida(strCodCli, strEmpFil: String): Boolean;

    procedure pEscreveMensagemImportacao(memMsg: TStrings; strMensagem: String; intLinha: Integer = 0);
    function fValidaComparaTomadorComEmpresa: Boolean;
    Procedure pCriaClientNotas;
    function fSqlNotas: String;
    function fGravaRelacionamentoCTEcomDocumento(strChaveCTE, strAutoIncremCTE: string): boolean;
    function fAjustaMovTri_AuxMov_Frete(stlAutoIncremCTE: String): boolean;

//    procedure pCarregaTXT(stlFrete : TStringList; memLog, memErr: TStrings);
    function getLogImportao: string;
    Function fValidaPessoasCadastradasNoBanco: Boolean;

    Function fCarregaArquivoFreteXML(strNomArq : String; memLog, memErr: TStrings;
                                     blnClassificacaoEntrada: Boolean;
                                     blnEntradaDeMercadoria : Boolean;
                                     var blnNotaNaoIdentificada: Boolean;
                                     blnImpClF : Boolean = False;
                                     blnImpTransp : Boolean = False;
                                     blnImpVencimentos: Boolean = False): Boolean;
    function fRetDescricaoTipoFrete(AtpDocFrete: TTipoDocFrete): string;
    function fVerificaQuantidadeDeComplementos(strCte: String): Boolean;
    function fRetAutoincremCadFis(AstrAcesso: String): String;

    Procedure pBeforePost(dataSet: TDataSet);
    procedure pGetTagRaizCte(xmlDoc : TXMLDocument; Var nodXml: IXMLNode; var blnMod67 : Boolean);
    function fFiltra_CTE(strChaveCte: String): boolean;
    function fFiltraNotasCTE(strChaveCte: String): string;

    procedure pCarregaPessoas(xmlDoc : TXMLDocument; Var xmlNode: IXMLNode);
    procedure pCarregaPessoasBco();
    function fRetCNPJEmpresa(strCodEmp: String): String;
    function fRetonarTipoDeFrete(var strErro: String): TTipoDocFrete;
    function fValidaChaveAcessoAnexa(strChaveAcesso: String; var strErro: String; var strCfopBrinde: String): Boolean;
    function fValidaPessoasCompra(var strErro: String): TTipoDocFrete;
    function fValidaPessoasVendas(var strErro: String): TTipoDocFrete;
    function fValidaPessoasDevolucao(var strErro: String): TTipoDocFrete;
    function fValidaPessoasDevolucaoCompra(var strErro: String): TTipoDocFrete;

    function fVerificaSeCreditaICMS(intTomador: integer): Boolean;
    function fGravaPessoas(seqCTE: String): Boolean;
    procedure pLimparPessoa(var recPessoa: TPessoaCTE);
    procedure pDefinePagadorDoFrete(xmlDoc : TXMLDocument);
    function fRetornaCNPJTomador(xmlDoc : TXMLDocument; intTomador: integer): string;
    function fGetTagTomador(intTomador: integer): string;
    procedure pTomadorEEmpresaCadastrada(strCNPJTomador: string; var strCodEmpresa: string);
    function fRetNomFornecedorInt(strCodFor: String): String;
    function fGetSQLDadosCTe: string;
    function fGeraDadosImportacao: Boolean;
    function fCarregaDadosCTe(memLog, memErr: TStrings; blnClassificacaoEntrada: Boolean): Boolean;
    function fTipoDocFreteToChar(ATipoDocFrete: TTipoDocFrete): String;
    function fCharToTipoDocFrete(AstrTipoDocFrete: String): TTipoDocFrete;
    function getPesoBruto: string;
    procedure setPesoBruto(const Value: string);

    Function fIncluiProdutosParaRateioNota(strSeqGer: String): Boolean;

    Function fIncluiProdutosRateioNotasPrg(cxpProgresso: TcxProgressBar): Boolean;

    Function fIncluiProdutosRateioDuranteEntradaPrg(cxpProgresso: TcxProgressBar): Boolean;
    function fGravaDadosMunicipio(seqCTE: String): Boolean;
    function fVerificaCamposMunicipioInicioFimPreenchidos: Boolean;
    function fExisteNFeDevolucao(strNFeAcesso: String): Boolean;
    function getRemetente: TPessoaCTE;
    function getTomador: TPessoaCTE;
    function getDestinatario: TPessoaCTE;
    function getEmitente: TPessoaCTE;
    function getFExpedidor: TPessoaCTE;
    function getRecebedor: TPessoaCTE;
    procedure SetRemetente(const Value: TPessoaCTE);
    procedure SetTomador(const Value: TPessoaCTE);
    procedure SetDestinatario(const Value: TPessoaCTE);
    procedure SetEmitente(const Value: TPessoaCTE);
    procedure SetFExpedidor(const Value: TPessoaCTE);
    procedure SetRecebedor(const Value: TPessoaCTE);

    function fVerificaTemCadRecSaida(strSequen, strCodCli, strCodEmp: String): Boolean;
    function fVerificaTemCadFisSaida(strForCli, strCodEmp, strEntSai, strTip_FC: String): String;
    function fVerificaTemCadPag(strCodEmp, strSequen: String): Boolean;
    function fVerificaTemRelacionamentoCTEcomDoc(strAutoIncremCTE, strGerSeq, strCampo: string): boolean;

    function fValidarUFsPessoas(var AStrErro: String): Boolean;
    function fRetEmpresaPeloCGCLocal(strEMP_C_G_C_: String): String;

    procedure pCarregaArquivoFreteXMLEvento(strNomArq : String; memLog, memErr: TStrings);
    function fDocumentoCancelado: Boolean;
    function fDocumentoPago: Boolean;
    procedure pCarregarDadosXMLEvento;
    function fValidarXMLEvento(memErr: TStrings): Boolean;
    procedure pCancelarDocumento;
    procedure pCancelarCadFis;
    procedure pCancelarCanCTe;
    function fRetDataDoc: TDate;
    procedure pApagaCtaPagar(strForCli, strNumDoc, strCodEmp, strSerie,
      strEspDoc, strAutInc: String);

    procedure pAtualizaTentativaImp;
    function fDocumentoReferenciadoNoCTeEhDevolucaDeVenda(chaveDeAcesseo:String): Boolean;
    function fDocumentoReferenciadoNoCTeEhDevolucaDeCompra(chaveDeAcesseo:String): Boolean;
    function fCadFisExiste(Const strNumDoc: String;
                           Const strEspDoc: String;
                           Const strCodEmp: String;
                           Const strForCli: String;
                           Const strSerie: String;
                           Const strTipFC: String;
                           Const strEntSai: String):Boolean;
    function fEstaEmModoRobo():Boolean;
    function fRetornaClaFisNFe: String;
    function fExisteFornecedor(strCGC: String): Boolean;
    procedure pInsereCdsFornNaoEncontrado(strCNPJ, strCPF, strXNOME, strXFANT,
      strXLGR, strNRO, strXCPL, strXBAIRRO, strCMUN, strXMUN, strUF, strCEP,
      strCPAIS, strXPAIS, strFONE, strIE, strIEST, strIM, strCNAE: String);
  Public
    FCdsFornNaoEncontrado: TUniClientDataSet;
    blnXMLEvento: Boolean;
    blnTransferencia,
    blnVeioBoleto: Boolean;
    blnSimPau,
    blnUtiAbr: Boolean;
    tpFrete  : TTipoFrete;
    FtpDocFrete: TTipoDocFrete;
    blnImpVariosXml: Boolean;
    blnImpCTeComDCe: Boolean;


    blnDocumentoNaoExiste,
    blnDocumentoPago,
    blnDocumentoCancelado,
    blnArquivoComErro,
    blnErroGravarRegistro,
    blnDocumentoJaExiste,
    blnNfeAnexaNaoIdentificada,
    blnInformarAbreviacaoPISCOF: Boolean;

    fltVlrConNota,
    fltTotTodosFretes,


    fltCfgAlqPis,
    fltCfgAlqCof: Double;

    FComplemento: String;

    strCfgCstPis,
    strCfgCstCof: String;

    blnPerRep: Boolean;

    strEntDoc: String;
    strEntFor: String;
    strEntSer : String;
    strTransferenciaEmpOri,
    strTransferenciaEmpDes: String;

    blnImprCp: Boolean;
    strCodPor: String;
    objOutDes: TEntOutrasDespesas;

    strCodOpe: String;
    blnAltDup: Boolean;
    blnVarNot: Boolean;  // DIGITACAO DE VARIAS NOTAS PARA O CONHECIMENTO DE FRETES

    cdsRateioProdutos,
    cdsNotEnt: TZClient;

    qryTabela: TUniClientDataSet;
    dtsTabela: TDataSource;
    arrDuplicata: TarrDuplicata;
    arrDupFre: Array[0..23] Of TArrDigDuplic;
    arrDupTmp: Array[0..23] Of TArrDigDuplic;

    objIteAnt: TIcmsAntecipado;
    FStatus: Integer;

    arrLinDigCodbar: TarrLinDigCodbar;
    FValDocBoleto: Double;
    FDtaDocBoleto: TDateTime;
    FCndPagBoleto: String;
    qryGeneric: TUniQuery;
    strFCEVEN,
    strFCEDEV,
    strFCECOM: String;

    blnVerificarEndEntrega: Boolean;

    strClaFisEnt: String;
    blnLEVREC: Boolean;

    procedure pFiltraLog;

    Function fPercentualFreteSobreNotas(fltTotFre: Double): Double;

    Class Function fSQLProdutosNota(strSeqger: String = ''): String;

    Function fSQLProdutosNotaDuranteEntrada: String;

    Class Function fCriaCdsRateioProdutos(Var cdsProdutos: TZClient; strSeqger: String = ''): Boolean;

    Class Function fValidaRateioPercentual(cdsProdutos: TZClient): Boolean;

    Function fExcluiProdutosParaRateioNota(strSeqGer: String): Boolean;

    Function fIncluiProdutosRateioNotas: Boolean;

    Procedure pCalculaPisCofins(Var fltBasPis,
                                    fltBasCof,
                                    fltAlqPis,
                                    fltAlqCof,
                                    fltTotPis,
                                    fltTotCof: Double;
                                    strNotas: String);

    class function fTemFreConhecimento(strDoc, strEsp, strEmp, strSer, strFor: String): Boolean;
    class function fCarregaCTESAnteriores(strDoc, strEsp, strEmp, strSer, strFor: String): TZClient;
    function fConfirmaFreConhecimento(blnImprimeCP: Boolean; strPorBai, strNomForm, strEspDoc: String; AstrHistoricoEntrada: String = ''): Boolean;
    function fGravaXML(strAutIncCadFis: String; Arquivo: String): Boolean;
    function fSimples(strFornecedor: String): Boolean;
    function fCalculaBasePisCofinsReduzidaPelaEntradas(FBasOriginal, aValIcms: Double; strNotasEntrada: String): Double;

    Function fConfirmaFreConhecimentoVariasNotas: Boolean;
    function fValidaValores: Boolean;
    function fVerificaDocumento: Boolean;
    function fCarregaArquivoFrete(Const strArquivo: String; memLog, memErr: TStrings; blnXML: Boolean; Var blnNotaNaoIdentificada: Boolean): Boolean;
    Function  fIncluiNotaEntrada(strNumDoc, strEspDoc, strSerie, strCodFor: String; fltOutDes, fltPerRep: Double): Boolean;
    Function  fDocumentoExiste(strNumDoc, strEspDoc, strSerie, strCodFor: String;
                               Var blnConFre: Boolean; Var fltOutDes: Double): Boolean;

    Procedure pMontaDuplicatasXMl;
    Procedure pSetDupicatas;
    Procedure pSetLinDig;

    Function fCarregaAbreviacaoPisCof(strClaFis: String): Boolean;

    Function fValidaPerRep: Boolean;

    Function fValidaNumDocComChaveAcesso: Boolean;

    Procedure pExcluiNotaEntrada;
    procedure pAtualizaDados;
    function fDefineCndPag(cndDefault: String): string;
    function fCarregaPessoaConvertidaBlob(intTipoPessoa: integer): TPessoaCTE;
    procedure pEnviaDados;
    procedure pEnviaDadosPessoa;
    Procedure pMontaDuplicatasFrete(var arrDuplicata: TarrDuplicata);

    procedure pSetLinDigCodbar(value: TarrLinDigCodbar);

    procedure pLimpaDadosBoleto;

    Function fAlterouDadosBoleto: Boolean;

    procedure pControlaDigDuplicAtual(intOpc: Integer);
    function fAbreXml(strNomArq : String; blnClassificaoEntrada, blnEntradaMercadoria: Boolean; blnImpVencimentos: Boolean) : Boolean;

    Function fSelecionaAbreviacaoPis: Boolean;
    Function fSelecionaAbreviacaoCofins: Boolean;

    Constructor Create(Owner: TComponent; blnDigNot: Boolean = False); Reintroduce;
    Destructor Destroy; Override;
    Function fCarregaArquivos(strPath, strExtensao: String): Boolean; overload;
    Function fCarregaArquivos(strArquivo: String; blnClassificaoEntrada, blnEntradaMercadoria: Boolean; blnImpVencimentos: Boolean): Boolean; overload;

    Function fRetEstadoEmpresa(strCodEmp: String): String;
    Function fConfirmarCancelamento(prgProgresso: TProgressBar): Boolean;
    Function fConfirmaImportacaoFrete(prgProgresso: TProgressBar): Boolean;
    function fConfirmaImportacaoFreteBanco: Boolean;

    function fLocalizaNotas(prgProgresso: TcxProgressBar): Boolean;
    procedure pMarcarNotasQueSeraoImportadas;
    procedure pMarcaTodosArquivos(blnMarcar: Boolean = True);
    procedure pMarcaTodosCreditaICMS(blnMarcar: Boolean = True);

    function fFormatCNPJ(strCNPJ: String): string;
    function fValidaNotas: Boolean;
    procedure pLocalizaItemDuplicadoJaImportados;

    Procedure pReplicaAlqPis;
    Procedure pReplicaAlqCof;
    Function fReplicaAlqPisPrg(prgProgresso: TCxProgressBar): Boolean;
    Function fReplicaAlqCofPrg(prgProgresso: TCxProgressBar): Boolean;

    Function fSelecionaAbreviacaoPisEntrada(strClaFis: String): Boolean;
    Function fSelecionaAbreviacaoCofinsEntrada(strClaFis: String): Boolean;
    Function fVerificaAlqPisCofEntrada(strClaFis: String): Boolean;
    procedure pGravaRelacionamentoComplementos(strChave: String);
    procedure pImportaCTeBancoDados(tpOperacao: TTipoFrete);

  Published
    Function fXmlToBanco(prgProgresso: TProgressBar): Boolean;

    property strComplemento: String Read FComplemento   Write FComplemento;
    property arrSeqPag: TArrAutInc Read FSeqPag;
    property strNumDoc: String Read FNumDoc   Write setNumDoc;
    property strSerie_: String Read FSerie_   Write FSerie_;

    property blnbrinde: String Read Fbrinde   Write Fbrinde;
    property strVeioNF: String Read FVeioNF   Write FVeioNF;
    property strArquivoXML: String Read  FstrArquivoXML write FstrArquivoXML;
    property strUsaCHQ: String Read FUsaCHQ   Write FUsaCHQ;
    property strPrevis: String Read FPrevis   Write FPrevis;
    property strPagAnt: String Read FPagAnt   Write FPagAnt;
    property strUsoCon: String Read FUsoCon   Write FUsoCon;

    property strTipDoc: String Read FTipDoc   Write FTipDoc;
    property strGuiTri: String Read FGuiTri   Write FGuiTri;
    property strTipTri: String Read FTipTri   Write FTipTri;

    property strDeposi: String Read FDeposi   Write FDeposi;
    property strTransf: String Read FTransf   Write FTransf;
    property strBcoFor: String Read FBcoFor   Write FBcoFor;

    property strModFre: String Read FModFre   Write FModFre;
    property strEspDoc: String Read FEspDoc   Write setEspDoc;
    property strCodTra: String Read FCodTra   Write setCodTra;
    property strTraLot: String Read FTraLot   Write FTraLot;
    property fltValTot: Double Read GetValTot;    // Valor Total Documentos
    property strEstTra: String Read GetEstTra;
    property strDesTra: String Read getDesTra;
    property strHis001: String Read FHis001   Write setHis001;
    property strCndPag: String Read FCndPag   Write setCndPag;

    property strModelo: String Read FModelo   Write setModelo;

    property strCodCta: String Read FCodCta   Write setCodCta;

    property strCtaRec: String Read FCtaRec   Write setCtaRec;

    property strCodEve: String Read FCodEve   Write FCodEve;
    property strCompet: String Read FCompet   Write FCompet;
    property strCndXML: String Read FCndXML   Write FCndXML;
    property strDesCta: String Read getDesCta;
    property strValDoc: String Read getValDoc Write setValDoc;
    property strDtaEnt: String Read getDtaEnt Write setDtaEnt;
    property strDtaDoc: String Read getDtaDoc Write setDtaDoc;
    property strPorBai: String Read FPorBai   Write FPorBai;

    property strClaFi1: String Read FClaFi1   Write setClaFi1;
    property strClaFiXML: String Read FClaFiXML Write setClaFiXML;
    property strValCo1: String Read getValCo1 Write setValCo1;
    property strBasIc1: String Read getBasIc1 Write setBasIc1;
    property strAlqIc1: String Read getAlqIc1 Write setAlqIc1;
    property strValIc1: String Read getValIc1 Write setValIc1;
    property strValOu1: String Read getValOu1 Write setValOu1;
    property strValIs1: String Read getValIs1 Write setValIs1;
    property strValRe1: String Read getValRe1 Write setValRe1;
    property strBasIp1: String Read getBasIp1 Write setBasIp1;
    property strValIp1: String Read getValIp1 Write setValIp1;
    property strBasSu1: String Read getBasSu1 Write setBasSu1;
    property strDesAc1: String Read getDesAc1 Write setDesAc1;

    property strClaFi2: String Read FClaFi2   Write setClaFi2;
    property strValCo2: String Read getValCo2 Write setValCo2;
    property strBasIc2: String Read getBasIc2 Write setBasIc2;
    property strAlqIc2: String Read getAlqIc2 Write setAlqIc2;
    property strValIc2: String Read getValIc2 Write setValIc2;
    property strValOu2: String Read getValOu2 Write setValOu2;
    property strValIs2: String Read getValIs2 Write setValIs2;
    property strValRe2: String Read getValRe2 Write setValRe2;
    property strBasIp2: String Read getBasIp2 Write setBasIp2;
    property strValIp2: String Read getValIp2 Write setValIp2;
    property strBasSu2: String Read getBasSu2 Write setBasSu2;
    property strDesAc2: String Read getDesAc2 Write setDesAc2;

    property strClaFi3: String Read FClaFi3   Write setClaFi3;
    property strValCo3: String Read getValCo3 Write setValCo3;
    property strBasIc3: String Read getBasIc3 Write setBasIc3;
    property strAlqIc3: String Read getAlqIc3 Write setAlqIc3;
    property strValIc3: String Read getValIc3 Write setValIc3;
    property strValOu3: String Read getValOu3 Write setValOu3;
    property strValIs3: String Read getValIs3 Write setValIs3;
    property strValRe3: String Read getValRe3 Write setValRe3;
    property strBasIp3: String Read getBasIp3 Write setBasIp3;
    property strValIp3: String Read getValIp3 Write setValIp3;
    property strBasSu3: String Read getBasSu3 Write setBasSu3;
    property strDesAc3: String Read getDesAc3 Write setDesAc3;

    property strClaFi4: String Read FClaFi4   Write setClaFi4;
    property strValCo4: String Read getValCo4 Write setValCo4;
    property strBasIc4: String Read getBasIc4 Write setBasIc4;
    property strAlqIc4: String Read getAlqIc4 Write setAlqIc4;
    property strValIc4: String Read getValIc4 Write setValIc4;
    property strValOu4: String Read getValOu4 Write setValOu4;
    property strValIs4: String Read getValIs4 Write setValIs4;
    property strValRe4: String Read getValRe4 Write setValRe4;
    property strBasIp4: String Read getBasIp4 Write setBasIp4;
    property strValIp4: String Read getValIp4 Write setValIp4;
    property strBasSu4: String Read getBasSu4 Write setBasSu4;
    property strDesAc4: String Read getDesAc4 Write setDesAc4;

    property strClaFi5: String Read FClaFi5   Write setClaFi5;
    property strValCo5: String Read getValCo5 Write setValCo5;
    property strBasIc5: String Read getBasIc5 Write setBasIc5;
    property strAlqIc5: String Read getAlqIc5 Write setAlqIc5;
    property strValIc5: String Read getValIc5 Write setValIc5;
    property strValOu5: String Read getValOu5 Write setValOu5;
    property strValIs5: String Read getValIs5 Write setValIs5;
    property strValRe5: String Read getValRe5 Write setValRe5;
    property strBasIp5: String Read getBasIp5 Write setBasIp5;
    property strValIp5: String Read getValIp5 Write setValIp5;
    property strBasSu5: String Read getBasSu5 Write setBasSu5;
    property strDesAc5: String Read getDesAc5 Write setDesAc5;

    property strValCoT: String Read getValCoT;
    property strBasIcT: String Read getBasIcT;
    property strAlqIcT: String Read getAlqIcT;
    property strValIcT: String Read getValIcT;
    property strValOuT: String Read getValOuT;
    property strValIsT: String Read getValIsT;
    property strValReT: String Read getValReT;
    property strBasIpT: String Read getBasIpT;
    property strValIpT: String Read getValIpT;
    property strBasSuT: String Read getBasSuT;
    property strDesAcT: String Read getDesAcT;

    property strAntIc1: String Read getAntIc1 Write setAntIc1;
    property strBasAn1: String Read getBasAn1 Write setBasAn1;
    property strAntIc2: String Read getAntIc2 Write setAntIc2;
    property strBasAn2: String Read getBasAn2 Write setBasAn2;
    property strAntIc3: String Read getAntIc3 Write setAntIc3;
    property strBasAn3: String Read getBasAn3 Write setBasAn3;
    property strAntIc4: String Read getAntIc4 Write setAntIc4;
    property strBasAn4: String Read getBasAn4 Write setBasAn4;
    property strAntIc5: String Read getAntIc5 Write setAntIc5;
    property strBasAn5: String Read getBasAn5 Write setBasAn5;
    property strPesoBruto: string Read getPesoBruto Write setPesoBruto;
    property strAntIcT: String Read getAntIcT;
    property strBasAnT: String Read getBasAnT;
    property strAcesso: String Read FAcesso Write setAcesso;
    property strEmpresaPagadora: String Read FEmpresaPagadora Write FEmpresaPagadora;
    property objLogImportacao: string Read getLogImportao;
    property blnGraCTP: Boolean Read FblnGraCTP Write FblnGraCTP;

    property strAutFis: String Read FAutFis;
    property strCndVaz: String Read FCndVaz Write FCndVaz;

    property objPortadorFornecedor : TPortadorFornecedor read FPortadorFornecedor write FPortadorfornecedor;
    property tpDocFrete: TTipoDocFrete read fGetTipDocFrete;
    property TomSer: String read FTomSer write FTomSer;
    property Remetente: TPessoaCTE read getRemetente write SetRemetente;
    property Emitente: TPessoaCTE read getEmitente write SetEmitente;
    property Expedidor: TPessoaCTE read getFExpedidor write SetFExpedidor;
    property Recebedor: TPessoaCTE read getRecebedor write SetRecebedor;
    property Destinatario: TPessoaCTE read getDestinatario write SetDestinatario;
    property Tomador: TPessoaCTE read getTomador write SetTomador;

  End;

Const
  arrCampos: Array[0..133] Of String = ('NUMDOC', 'SERIE_', 'ESPDOC', 'CODTRA', 'CNDPAG', 'CODCTA', 'VALDOC', 'DTAENT', 'DTADOC',
                                       'CLAFI1', 'CLAFIXML', 'VALCO1', 'BASIC1', 'ALQIC1', 'VALIC1', 'VALOU1', 'VALIS1', 'VALRE1', 'BASIP1',
                                       'VALIP1', 'BASSU1', 'DESAC1', 'CLAFI2', 'VALCO2', 'BASIC2', 'ALQIC2', 'VALIC2', 'VALOU2',
                                       'VALIS2', 'VALRE2', 'BASIP2', 'VALIP2', 'BASSU2', 'DESAC2', 'CLAFI3', 'VALCO3', 'BASIC3',
                                       'ALQIC3', 'VALIC3', 'VALOU3', 'VALIS3', 'VALRE3', 'BASIP3', 'VALIP3', 'BASSU3', 'DESAC3',
                                       'CLAFI4', 'VALCO4', 'BASIC4', 'ALQIC4', 'VALIC4', 'VALOU4', 'VALIS4', 'VALRE4', 'BASIP4',
                                       'VALIP4', 'BASSU4', 'DESAC4', 'CLAFI5', 'VALCO5', 'BASIC5', 'ALQIC5', 'VALIC5', 'VALOU5',
                                       'VALIS5', 'VALRE5', 'BASIP5', 'VALIP5', 'BASSU5', 'DESAC5', 'HIS001', 'MODFRE',
 {CAMPOS REFERENTES A ANTEC. ICMS ==>}  'AntIc1', 'BasAn1', 'AntIc2', 'BasAn2', 'AntIc3', 'BasAn3', 'AntIc4', 'BasAn4', 'AntIc5', 'BasAn5',
                                        'CODEVE',
 {CAMPOS REFERENTES AO CONTR. IMPORT}   'IMPORT', 'NOMARQ', 'STATUS', 'LOGIMP', 'NOMTRA', 'ACESSO', 'CGCTRA', 'DUPLIC', 'CODEMP',
 {VErifica se Gera CTP              }   'GRACTP',
 {alíquota de PIS}                      'ALQPIS',
 {%Base PIS}                            'BASPIS',
 {alíquota de COFINS}                   'ALQCOF',
 {%Base COFINS}                         'BASCOF',
                                        'AUTPIS',
                                        'AUTCOF',
 {Veio Boleeto}                         'VEIOBO',
                                        'CSTPIS',
                                        'CSTCOF',
                                        'CGCREM',
                                        'CGCDES',
                                        'TOMSER',
                                        'FORPAG',
                                        'CTAREC',
                                        'EMPPAG',
                                        'CODBAR',
                                        'LINDIG',
   {Credita ICMS}                       'CREICM',
                                        'MODELO',
                                        'COMPET',
                                        'CNDXML',
                                        'TIPCTE',
                                        'VEIONF', // Veio NF
                                        'USACHQ', // Usa Cheque
                                        'PREVIS', // Previsão
                                        'PAGANT', // Pagamento antecipado
                                        'USOCON', // Uso e Consumo
                                        'TIPDOC', // Tipo do Documento
                                        'Q_GUIA', // Guia do Tributo
                                        'CODREC', // Tipo do Tributo
                                        'DEPOSI', // Deposito
                                        'TRANSF', // Transferencia
                                        'BRINDE', //Brinde
                                        'PESBRU', // Peso Bruto

                                        'COMPLE',
                                        'ARQUIV',
                                        'BCOFOR', // Conta Banco
                                        'DTACAN',
                                        'AUTINC',
                                        'DOCDCE',
                                        'VREC_'); // VREC_


  arrDataTypes: Array[0..133] Of TFieldType = (ftString, ftString, ftString, ftString, ftString, ftString, ftFloat, ftDate ,
                                              ftDate  , ftString, ftString, ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftString, ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftString, ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftString, ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftString, ftFloat , ftFloat , ftFloat , ftFloat , ftFloat, ftFloat,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftString, ftString,
                                              ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat , ftFloat,
                                              ftString,
                                              ftString, ftString, ftInteger, ftMemo, ftString, ftString, ftString, ftMemo, ftString, ftString,
                                              ftFloat , ftFloat, ftFloat, ftFloat, ftString, ftString, ftString, ftString, ftString, ftString,
                                              ftString, ftString, ftString, ftString, ftString, ftMemo, ftMemo, ftInteger, ftString, ftString,
                                              ftString,
                                              ftString,
                                              ftString,  // Veio NF
                                              ftString,  // Usa Cheque
                                              ftString,  // Previsão
                                              ftString,  // Pagamento antecipado
                                              ftString,  // Uso e Consumo
                                              ftString,  // Tipo do Documento
                                              ftString,  // Guia do Tributo
                                              ftString,  // Tipo do Tributo
                                              ftString,  // Deposito
                                              ftString,  // Traneferencia
                                              ftString, // Brinde
                                              ftFloat,  // Peso
                                              ftString, //Complemento
                                              ftString,
                                              ftString,// Conta Banco
                                              ftDate,
                                              ftString,
                                              ftString, // DOCDCE
                                              ftFloat); // VREC_

  arrTamanhos: Array[0..133] Of Integer = (12,  //NUMDOC
                                           03,  //SERIE_
                                           02,  //ESPDOC
                                           08,  //CODTRA
                                           50,  //CNDPAG
                                           10,  //CODCTA
                                           00,  //VALDOC
                                           00,  //DTAENT
                                           00,  //DTADOC
                                           04,  //CLAFI1
                                           04,  //CLAFIXML
                                           00,  //VALCO1
                                           00,  //BASIC1
                                           00,  //ALQIC1
                                           00,  //VALIC1
                                           00,  //VALOU1
                                           00,  //VALIS1
                                           00,  //VALRE1
                                           00,  //BASIP1
                                           00,  //VALIP1
                                           00,  //BASSU1
                                           00,  //DESAC1
                                           04,  //CLAFI2
                                           00,  //VALCO2
                                           00,  //BASIC2
                                           00,  //ALQIC2
                                           00,  //VALIC2
                                           00,  //VALOU2
                                           00,  //VALIS2
                                           00,  //VALRE2
                                           00,  //BASIP2
                                           00,  //VALIP2
                                           00,  //BASSU2
                                           00,  //DESAC2
                                           04,  //CLAFI3
                                           00,  //VALCO3
                                           00,  //BASIC3
                                           00,  //ALQIC3
                                           00,  //VALIC3
                                           00,  //VALOU3
                                           00,  //VALIS3
                                           00,  //VALRE3
                                           00,  //BASIP3
                                           00,  //VALIP3
                                           00,  //BASSU3
                                           00,  //DESAC3
                                           04,  //CLAFI4
                                           00,  //VALCO4
                                           00,  //BASIC4
                                           00,  //ALQIC4
                                           00,  //VALIC4
                                           00,  //VALOU4
                                           00,  //VALIS4
                                           00,  //VALRE4
                                           00,  //BASIP4
                                           00,  //VALIP4
                                           00,  //BASSU4
                                           00,  //DESAC4
                                           04,  //CLAFI5
                                           00,  //VALCO5
                                           00,  //BASIC5
                                           00,  //ALQIC5
                                           00,  //VALIC5
                                           00,  //VALOU5
                                           00,  //VALIS5
                                           00,  //VALRE5
                                           00,  //BASIP5
                                           00,  //VALIP5
                                           00,  //BASSU5
                                           00,  //DESAC5
                                           500, //HIS001
                                           01,  //MODFRE
                                           00,  //AntIc1
                                           00,  //BasAn1
                                           00,  //AntIc2
                                           00,  //BasAn2
                                           00,  //AntIc3
                                           00,  //BasAn3
                                           00,  //AntIc4
                                           00,  //BasAn4
                                           00,  //AntIc5
                                           00,  //BasAn5
                                           05,  //CODEVE
                                           01,  //IMPORT
                                           255, //NOMARQ
                                           00,  //STATUS
                                           00,  //LOGIMP
                                           255, //NOMTRA
                                           255, //ACESSO
                                           100, //CGCTRA
                                           00,  //DUPLIC
                                           03,  //CODEMP
                                           01,  //GRACTP
                                           00,  //ALQPIS
                                           00,  //BASPIS
                                           00,  //ALQCOF
                                           00,  //BASCOF
                                           20,  //AUTPIS
                                           20,  //AUTCOF
                                           01,  //VEIOBO
                                           02,  //CSTPIS
                                           02,  //CSTCOF
                                           100, //CGCREM
                                           100, //CGCDES
                                           10,  //TOMSER
                                           10,  //FORPAG
                                           10,  //CTAREC
                                           03,  //EMPPAG
                                           100, //CODBAR
                                           100, //LINDIG
                                           00,  //CREICM
                                           02,  //MODELO
                                           07,  //COMPET
                                           01,  //CNDXML
                                           01,  //TIPCTE;
                                           01,  //VEIONF
                                           01,  //USACHQ
                                           01,  //PREVIS
                                           01,  //PAGANT
                                           01,  //USOCON
                                           11,  //TIPDOC
                                           02,  //Q_GUIA
                                           12,  //CODREC
                                           01,  //DEPOSI
                                           01,  //TRANSF
                                           01,  //Brinde
                                           00,  //Peso Bruto
                                           01,  //Complemento
                                           255,  //Complemento
                                           20,  //BCOFOR
                                           00, //Data de Cancelamento
                                           20, // AutoIncremento
                                           1, // DOCDCE
                                           00); //VREC_
Const
  IMPORTADO_OK         = 0;
  IMPORTADO_COM_ERRO   = 1;
  COM_ERRO_GRAVACAO    = 2;
  DOCUMENTO_JA_EXISTE  = 3;
  IMPORTADO_OK_SEM_NF  = 4;
  IMPORTADO_SEM_PISCOF = 5;
  DOCUMENTO_NAO_EXISTE = 6;
  DOCUMENTO_PAGO       = 7;
  DOCUMENTO_CANCELADO  = 8;


  ConsRemetente    = 0;
  ConsEmitente     = 1;
  ConsExpedidor    = 2;
  ConsRecebedor    = 3;
  ConsDestinatario = 4;
  ConsTomador      = 5;

  tomador_Remetente    = 0;
  tomador_Expedidor    = 1;
  tomador_Recebedor    = 2;
  tomador_Destinatario = 3;
  tomador_Outros       = 4;

  tag_tomador_normal   = 'toma3';
  tag_tomador_normal2  = 'toma03';
  tag_tomador_outros   = 'toma4';
  tag_tomador_outros2  = 'toma04';


implementation

uses Controls, untConstantes, untMovBan, untCadPag, untPcmGer, untCadFis,
     untFuncoes, untTConfiguracao, untTBanCtpRepository , untFuncoesGenerica,
     untEscolhePisCofinsFrete, untDuplicatas, untCadRec,
     untEntFreConGridIdentificaDocumento, untEntFreConLista;

{ TFreCon }

constructor TFreCon.Create(Owner: TComponent; blnDigNot: Boolean = False);
  Var
    intCont: Integer;
    blnEntMer : boolean;
begin
  inherited Create(Owner);
  FIsDocDCe := False;
  blnImpCTeComDCe := False;
  FblnMostraLog := True;
  pZeraDigDuplic(arrDuplicata);
  qryGeneric := fCriaQuery;
  blnImpVariosXml := False;
  strFCEVEN := fCfgSis('FCEVEN');
  blnUSACND := fCfgSis('USACND', varBoolean);
  strFCEDEV := fCfgSis('FCEDEV');
  strFCECOM := fCfgSis('FCECOM');
  blnLEVREC := fCfgSis('LEVREC', varString) = 'S';


  blnUtilizaContabilidade := (fCfgsis('UTICON', varBoolean));
  blnEntMer := False;
  if Assigned(Owner) and (Owner is TFreConLista) then
    blnEntMer := (Owner as TFreConLista).blnEntMer;

  FFreIpi := fRateioFreteValorContabil;

  FPortadorFornecedor := TPortadorFornecedor.Create( blnEntMer );

  blnCtpBol := fCfgSis('CTPBOL', varBoolean);

  blnImportaPeloBancoDados := False;

  fltVlrConNota := 0;
  fltTotTodosFretes := 0;

  cdsRateioProdutos := Nil;

  pLimpaDadosBoleto;

  FAtulizarTabela := True;

  FAutPis := '';
  FAutCof := '';
  FCstPis := '';
  FCstCof := '';

  FCodEmp := VS_strCodEmp;
  FCodEve := '';
  tpFrete := tpfEntrada;
  blnUtiAbr := fCfgSis('UTIABR', varBoolean);
  blnPerRep := fCfgSis('PERCTE', varBoolean);

  FCodMunicipioInicio:= '';
  FMunicipioDescricaoInicio:= '';
  FCodMunicipioFim:= '';
  FMunicipioDescricaoFim:= '';
  FUFInicio := '';
  FUFFim    := '';

  blnSimPau := fCfgSis('SIMPAU', varBoolean);

  fltCfgAlqPis := fCfgSis('ALPISP', varDouble);
  fltCfgAlqCof := fCfgSis('ALCOFP', varDouble);

  strCfgCstPis := fCfgSis('CSTPIS');
  strCfgCstCof := fCfgSis('CSTCOF');

  FListaClaFis := TStringList.Create;
  FListaClaFis.Sorted := True;

  cdsAbrPis := TZClient.Create(Self);
  cdsAbrCof := TZClient.Create(Self);

  objIteAnt := Nil;

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  If blnVarNot Then
    pCriaClientNotas;

  For intCont := 1 to 7 Do
    blnAtpVmb[intCont] := (fCfgSis( IIF( intCont = 1, 'ATPVMB', 'ATPVM' + IntToStr(intCont) )) = 'P');

  FNotEnt   := Nil;
  blnVarNot := blnDigNot;
  FConsulta := fCriaQuery;
  FEmpresas := fCriaQuery;
  FComplemento := '0';
  FBrinde:= '0';
  cdsNotasFiscais := TZClient.Create(nil, fGetSqlNotasFiscais);
  cdsNotasFiscais.fAbreClient(true, 'TFreCon.Create');


  cdsComplementos := TZClient.Create(nil, fGetSqlComplementos);
  cdsComplementos.fAbreClient(true, 'TFreCon.Create');

  If blnVarNot Then
  Begin
    FNotEnt    := fCriaQuery(Self);
    objOutDes  := TEntOutrasDespesas.Create(Self);
  End Else
  Begin
    FNotEnt    := Nil;
    objOutDes  := Nil;
  End;

  blnAltDup := False;

  Try

    FImpFre := False;

    qryTabela := TUniClientDataSet.Create(Self);
    dtsTabela := fCriaDataSource(qryTabela);

    {**************************************}
    {* ADICIONA OS FIELDS                 *}
    {***********************************AF*}
    Try
      For intCont := Low(arrCampos) To High(arrCampos) Do
      Begin

        With qryTabela.FieldDefs.AddFieldDef Do
        Begin
          Name     := arrCampos[intCont];
          DataType := arrDataTypes[intCont];

          If arrTamanhos[intCont] > 0 Then
            Size := arrTamanhos[intCont];
        End;

      End;
    Except
      on E:Exception do
        pMensagemOk(e.message);
    End;

    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'REMETENTE';
      DataType := ftString;
      Size     := 400;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EMITENTE';
      DataType := ftString;
      Size     := 400;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'EXPEDIDOR';
      DataType := ftString;
      Size     := 400;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'RECEBEDOR';
      DataType := ftString;
      Size     := 400;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESTINATARIO';
      DataType := ftString;
      Size     := 400;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'TOMADOR';
      DataType := ftString;
      Size     := 400;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'UFINI_';
      DataType := ftString;
      Size:= 2;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'UFFIM_';
      DataType := ftString;
      Size:= 2;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MUNINI';
      DataType := ftString;
      Size:= 7;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'MUNFIM';
      DataType := ftString;
      Size:= 7;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESMNI';
      DataType := ftString;
      Size:= 40;
    End;
    With qryTabela.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DESMNF';
      DataType := ftString;
      Size:= 40;
    End;

    qryTabela.CreateDataSet;
    qryTabela.LogChanges := False;

    (qryTabela.FieldByName('ALQPIS') As TFloatField).DisplayFormat := fMskDigitos(4);
    (qryTabela.FieldByName('ALQCOF') As TFloatField).DisplayFormat := fMskDigitos(4);

    FLogImportacao := TStringList.Create;
    FblnGraCTP := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Ocorreu um erro ao criar o objeto FreCon!' + #13 + E.Message);
    End;
  End;

end;

Function TFreCon.fValidaPerRep: Boolean;
Begin
  If Not Assigned(cdsNotEnt) Then
  Begin
    Result := True;
    Exit;
  End;

  If cdsNotEnt.State = dsEdit Then
    cdsNotEnt.Post;

  Result := (Not cdsNotEnt.Active) Or (Not blnPerRep) Or (RoundTo(cdsNotEnt.fRetSoma('TOTREP'), -2) = 100);
End;

function TFreCon.getAlqIc1: String;
begin
  Result := FloatToStrF(FAlqIc1,ffFixed,12,2);
end;

function TFreCon.getAlqIc2: String;
begin
  Result := FloatToStrF(FAlqIc2,ffFixed,12,2);
end;

function TFreCon.getAlqIc3: String;
begin
  Result := FloatToStrF(FAlqIc3,ffFixed,12,2);
end;

function TFreCon.getAlqIc4: String;
begin
  Result := FloatToStrF(FAlqIc4,ffFixed,12,2);
end;

function TFreCon.getAlqIc5: String;
begin
  Result := FloatToStrF(FAlqIc5,ffFixed,12,2);
end;

function TFreCon.getBasIc1: String;
begin
  Result := FloatToStrF(FBasIc1,ffFixed,12,2);
end;

function TFreCon.getBasIc2: String;
begin
  Result := FloatToStrF(FBasIc2,ffFixed,12,2);
end;

function TFreCon.getBasIc3: String;
begin
  Result := FloatToStrF(FBasIc3,ffFixed,12,2);
end;

function TFreCon.getBasIc4: String;
begin
  Result := FloatToStrF(FBasIc4,ffFixed,12,2);
end;

function TFreCon.getBasIc5: String;
begin
  Result := FloatToStrF(FBasIc5,ffFixed,12,2);
end;

function TFreCon.getBasIp1: String;
begin
  Result := FloatToStrF(FBasIp1,ffFixed,12,2);
end;

function TFreCon.getBasIp2: String;
begin
  Result := FloatToStrF(FBasIp2,ffFixed,12,2);
end;

function TFreCon.getBasIp3: String;
begin
  Result := FloatToStrF(FBasIp3,ffFixed,12,2);
end;

function TFreCon.getBasIp4: String;
begin
  Result := FloatToStrF(FBasIp4,ffFixed,12,2);
end;

function TFreCon.getBasIp5: String;
begin
  Result := FloatToStrF(FBasIp5,ffFixed,12,2);
end;

function TFreCon.getBasSu1: String;
begin
  Result := FloatToStrF(FBasSu1,ffFixed,12,2);
end;

function TFreCon.getBasSu2: String;
begin
  Result := FloatToStrF(FBasSu2,ffFixed,12,2);
end;

function TFreCon.getBasSu3: String;
begin
  Result := FloatToStrF(FBasSu3,ffFixed,12,2);
end;

function TFreCon.getBasSu4: String;
begin
  Result := FloatToStrF(FBasSu4,ffFixed,12,2);
end;

function TFreCon.getBasSu5: String;
begin
  Result := FloatToStrF(FBasSu5,ffFixed,12,2);
end;

function TFreCon.getDesAc1: String;
begin
  Result := FloatToStrF(FDesAc1,ffFixed,12,2);
end;

function TFreCon.getDesAc2: String;
begin
  Result := FloatToStrF(FDesAc2,ffFixed,12,2);
end;

function TFreCon.getDesAc3: String;
begin
  Result := FloatToStrF(FDesAc3,ffFixed,12,2);
end;

function TFreCon.getDesAc4: String;
begin
  Result := FloatToStrF(FDesAc4,ffFixed,12,2);
end;

function TFreCon.getDesAc5: String;
begin
  Result := FloatToStrF(FDesAc5,ffFixed,12,2);
end;

function TFreCon.getDesCta: String;
begin
  Result := fRetNomeConta(FCodCta)
end;

function TFreCon.getDestinatario: TPessoaCTE;
begin
  Result := FDestinatario;
end;

function TFreCon.getTomador: TPessoaCTE;
begin
  Result := FTomador;
end;

function TFreCon.getDesTra: String;
begin
  Result := fRetNomFornecedor(FCodTra);
end;

function TFreCon.getDtaDoc: String;
begin

  If FDtaDoc = 0 Then
    Result := ''
  Else
    Result := FormatDateTime('dd/mm/yyyy',FDtaDoc);

end;

function TFreCon.getDtaEnt: String;
begin

  If FDtaEnt = 0 Then
    Result := ''
  Else
    Result := FormatDateTime('dd/mm/yyyy',FDtaEnt);

end;

function TFreCon.getEmitente: TPessoaCTE;
begin
  Result := FEmitente;
end;

function TFreCon.getFExpedidor: TPessoaCTE;
begin
  Result := FExpedidor;

end;

function TFreCon.getLogImportao: string;
begin
  Result := FLogImportacao.Text;
end;

function TFreCon.getPesoBruto: string;
begin
  Result := FloatToStrF(FPesoBruto,ffFixed,12,2);
end;

function TFreCon.getValCo1: String;
begin
  Result := FloatToStrF(FValCo1,ffFixed,12,2);
end;

function TFreCon.getValCo2: String;
begin
  Result := FloatToStrF(FValCo2,ffFixed,12,2);
end;

function TFreCon.getValCo3: String;
begin
  Result := FloatToStrF(FValCo3,ffFixed,12,2);
end;

function TFreCon.getValCo4: String;
begin
  Result := FloatToStrF(FValCo4,ffFixed,12,2);
end;

function TFreCon.getValCo5: String;
begin
  Result := FloatToStrF(FValCo5,ffFixed,12,2);
end;

function TFreCon.getValDoc: String;
begin
  Result := FloatToStrF(FValDoc,ffFixed,12,2);
end;

function TFreCon.getValIc1: String;
begin
  Result := FloatToStrF(FValIc1,ffFixed,12,2);
end;

function TFreCon.getValIc2: String;
begin
  Result := FloatToStrF(FValIc2,ffFixed,12,2);
end;

function TFreCon.getValIc3: String;
begin
  Result := FloatToStrF(FValIc3,ffFixed,12,2);
end;

function TFreCon.getValIc4: String;
begin
  Result := FloatToStrF(FValIc4,ffFixed,12,2);
end;

function TFreCon.getValIc5: String;
begin
  Result := FloatToStrF(FValIc5,ffFixed,12,2);
end;

function TFreCon.getValIp1: String;
begin
  Result := FloatToStrF(FValIp1,ffFixed,12,2);
end;

function TFreCon.getValIp2: String;
begin
  Result := FloatToStrF(FValIp2,ffFixed,12,2);
end;

function TFreCon.getValIp3: String;
begin
  Result := FloatToStrF(FValIp3,ffFixed,12,2);
end;

function TFreCon.getValIp4: String;
begin
  Result := FloatToStrF(FValIp4,ffFixed,12,2);
end;

function TFreCon.getValIp5: String;
begin
  Result := FloatToStrF(FValIp5,ffFixed,12,2);
end;

function TFreCon.getValIs1: String;
begin
  Result := FloatToStrF(FValIs1,ffFixed,12,2);
end;

function TFreCon.getValIs2: String;
begin
  Result := FloatToStrF(FValIs2,ffFixed,12,2);
end;

function TFreCon.getValIs3: String;
begin
  Result := FloatToStrF(FValIs3,ffFixed,12,2);
end;

function TFreCon.getValIs4: String;
begin
  Result := FloatToStrF(FValIs4,ffFixed,12,2);
end;

function TFreCon.getValIs5: String;
begin
  Result := FloatToStrF(FValIs5,ffFixed,12,2);
end;

function TFreCon.getValOu1: String;
begin
  Result := FloatToStrF(FValOu1,ffFixed,12,2);
end;

function TFreCon.getValOu2: String;
begin
  Result := FloatToStrF(FValOu2,ffFixed,12,2);
end;

function TFreCon.getValOu3: String;
begin
  Result := FloatToStrF(FValOu3,ffFixed,12,2);
end;

function TFreCon.getValOu4: String;
begin
  Result := FloatToStrF(FValOu4,ffFixed,12,2);
end;

function TFreCon.getValOu5: String;
begin
  Result := FloatToStrF(FValOu5,ffFixed,12,2);
end;

function TFreCon.getValRe1: String;
begin
  Result := FloatToStrF(FValRe1,ffFixed,12,2);
end;

function TFreCon.getValRe2: String;
begin
  Result := FloatToStrF(FValRe2,ffFixed,12,2);
end;

function TFreCon.getValRe3: String;
begin
  Result := FloatToStrF(FValRe3,ffFixed,12,2);
end;

function TFreCon.getValRe4: String;
begin
  Result := FloatToStrF(FValRe4,ffFixed,12,2);
end;

function TFreCon.getValRe5: String;
begin
  Result := FloatToStrF(FValRe5,ffFixed,12,2);
end;

procedure TFreCon.setAcesso(const Value: String);
begin
  If fEmptyStr(Value) Then
  Begin
    FAcesso := '';
    Exit;
  End;

  if fValidaChaveAcessoNFE(Value) Then
    FAcesso := Value
  Else Begin
    FAcesso := '';
    Raise Exception.Create('Chave de acesso Inválida!');
  End;
end;

procedure TFreCon.pSetLinDigCodbar(value: TarrLinDigCodbar);
Begin
  arrLinDigCodbar := value;

  FValDocBoleto := FValDoc;
  FDtaDocBoleto := FDtaDoc;
  FCndPagBoleto := FCndPag;

  pSetLinDig;
End;

Function TFreCon.fAlterouDadosBoleto: Boolean;
Begin
  Result := (FValDocBoleto <> FValDoc) Or (FDtaDocBoleto <> FDtaDoc) And
            (FCndPagBoleto <> FCndPag);
End;

Procedure TFreCon.pLimpaDadosBoleto;
Begin
  FillChar(arrLinDigCodbar, SizeOf(arrLinDigCodbar), #0);
End;

procedure TFreCon.setAlqIc1(const Value: String);
begin
  FAlqIc1 := fStrToFloat(Value);
end;

procedure TFreCon.setAlqIc2(const Value: String);
begin
  FAlqIc2 := fStrToFloat(Value);
end;

procedure TFreCon.setAlqIc3(const Value: String);
begin
  FAlqIc3 := fStrToFloat(Value);
end;

procedure TFreCon.setAlqIc4(const Value: String);
begin
  FAlqIc4 := fStrToFloat(Value);
end;

procedure TFreCon.setAlqIc5(const Value: String);
begin
  FAlqIc5 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIc1(const Value: String);
begin
  FBasIc1 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIc2(const Value: String);
begin
  FBasIc2 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIc3(const Value: String);
begin
  FBasIc3 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIc4(const Value: String);
begin
  FBasIc4 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIc5(const Value: String);
begin
  FBasIc5 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIp1(const Value: String);
begin
  FBasIp1 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIp2(const Value: String);
begin
  FBasIp2 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIp3(const Value: String);
begin
  FBasIp3 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIp4(const Value: String);
begin
  FBasIp4 := fStrToFloat(Value);
end;

procedure TFreCon.setBasIp5(const Value: String);
begin
  FBasIp5 := fStrToFloat(Value);
end;

procedure TFreCon.setBasSu1(const Value: String);
begin
  FBasSu1 := fStrToFloat(Value);
end;

procedure TFreCon.setBasSu2(const Value: String);
begin
  FBasSu2 := fStrToFloat(Value);
end;

procedure TFreCon.setBasSu3(const Value: String);
begin
  FBasSu3 := fStrToFloat(Value);
end;

procedure TFreCon.setBasSu4(const Value: String);
begin
  FBasSu4 := fStrToFloat(Value);
end;

procedure TFreCon.setBasSu5(const Value: String);
begin
  FBasSu5 := fStrToFloat(Value);
end;

procedure TFreCon.setCodCta(const Value: String);
begin

  If fEmptyStr(Value) Then
  Begin
    FCodCta := '';
    Raise Exception.Create('O código do Plano de Contas a Pagar deve ser preenchido!');
  End
  Else
    FCodCta := Value;

end;

procedure TFreCon.setCtaRec(const Value: String);
begin

  If fEmptyStr(Value) Then
  Begin
    FCtaRec := '';

    If (tpFrete = tpfSaida) Then
      Raise Exception.Create('O código do Plano de Contas a Receber deve ser preenchido!');
  End
  Else
    FCtaRec := Value;

end;

procedure TFreCon.setCodTra(const Value: String);
begin

  If fEmptyStr(Value) Then
  Begin
    FCodTra := '';
    Raise Exception.Create('O código da transportadora deve ser preenchido!');
  End
  Else
    FCodTra := Value;

  //FC_G_C_ := fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR'], [FCodTra]);

end;

{procedure TFreCon.SetC_G_C_(const Value: String);
begin
  FC_G_C_ := Value;
  FCodTra := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [FC_G_C_]);
end;}

procedure TFreCon.setDesAc1(const Value: String);
begin
  FDesAc1 := fStrToFloat(Value);
end;

procedure TFreCon.setDesAc2(const Value: String);
begin
  FDesAc2 := fStrToFloat(Value);
end;

procedure TFreCon.setDesAc3(const Value: String);
begin
  FDesAc3 := fStrToFloat(Value);
end;

procedure TFreCon.setDesAc4(const Value: String);
begin
  FDesAc4 := fStrToFloat(Value);
end;

procedure TFreCon.setDesAc5(const Value: String);
begin
  FDesAc5 := fStrToFloat(Value);
end;

procedure TFreCon.SetDestinatario(const Value: TPessoaCTE);
begin
  FDestinatario := Value;
end;

procedure TFreCon.SetTomador(const Value: TPessoaCTE);
begin
  FTomador := Value;
end;

procedure TFreCon.setDtaDoc(const Value: String);
begin

  If fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    FDtaDoc := 0;
    Raise Exception.Create('A data do documento deve ser preenchida!');
  End


  Else If (StrToDateDef(Value, 0) > (FDtaEnt))  Then
  Begin
    FDtaDoc := StrToDate(Value);
    Raise Exception.Create('A Data do Documento não pode ser maior que Data de Entrada!');
  End

  Else FDtaDoc := StrToDate(Value);

end;

procedure TFreCon.setDtaEnt(const Value: String);
begin

  If fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    FDtaEnt := 0;
    Raise Exception.Create('A data do documento deve ser preenchida!');
  End
  Else
    FDtaEnt := StrToDate(Value);
end;

procedure TFreCon.SetEmitente(const Value: TPessoaCTE);
begin
  FEmitente := Value
end;

procedure TFreCon.setEspDoc(const Value: String);
begin
  FEspDoc := Value;

  If fEmptyStr(Value) Then
    Raise Exception.Create('A espécie do documento deve ser preenchido!');
end;

procedure TFreCon.SetFExpedidor(const Value: TPessoaCTE);
begin
  FExpedidor := Value;
end;

procedure TFreCon.setHis001(const Value: String);
begin
  FHis001 := Value;
end;

procedure TFreCon.setNumDoc(const Value: String);
begin
  FNumDoc := Value;

  If fEmptyStr(Value) Then
    Raise Exception.Create('O número do documento deve ser preenchido!');
end;

procedure TFreCon.setPesoBruto(const Value: string);
begin
  FPesoBruto := fStrToFloat(Value);
end;

procedure TFreCon.SetRecebedor(const Value: TPessoaCTE);
begin
  FRecebedor:= Value;
end;

procedure TFreCon.SetRemetente(const Value: TPessoaCTE);
begin
  FRemetente := Value;
end;

procedure TFreCon.setModelo(const Value: String);
begin
  FModelo := Value;

  If fEmptyStr(Value) Then
    Raise Exception.Create('O modelo de documento deve ser preenchido!');
end;

procedure TFreCon.setValCo1(const Value: String);
begin

//  If (fStrToFloat(Value) + FValCo2 + FValCo3 + FValCo4 + FValCo5) <= FValDoc Then
    FValCo1 := fStrToFloat(Value);
//  Else
//    Raise Exception.Create('O valor da classificação ultrapassa o valor do documento!');

  If FValCo1 < 0 Then
    FValCo1 := 0;

end;

procedure TFreCon.setValCo2(const Value: String);
begin

//  If (fStrToFloat(Value) + FValCo1 + FValCo3 + FValCo4 + FValCo5) <= FValDoc Then
    FValCo2 := fStrToFloat(Value)
//  Else
//    Raise Exception.Create('O valor da classificação ultrapassa o valor do documento!');

end;

procedure TFreCon.setValCo3(const Value: String);
begin

//  If (fStrToFloat(Value) + FValCo1 + FValCo2 + FValCo4 + FValCo5) <= FValDoc Then
    FValCo3 := fStrToFloat(Value)
//  Else
//    Raise Exception.Create('O valor da classificação ultrapassa o valor do documento!');

end;

procedure TFreCon.setValCo4(const Value: String);
begin

//  If (fStrToFloat(Value) + FValCo1 + FValCo2 + FValCo3 + FValCo5) <= FValDoc Then
    FValCo4 := fStrToFloat(Value)
//  Else
//    Raise Exception.Create('O valor da classificação ultrapassa o valor do documento!');

end;

procedure TFreCon.setValCo5(const Value: String);
begin

//  If (fStrToFloat(Value) + FValCo1 + FValCo2 + FValCo3 + FValCo4) <= FValDoc Then
    FValCo5 := fStrToFloat(Value)
//  Else
//    Raise Exception.Create('O valor da classificação ultrapassa o valor do documento!');

end;

procedure TFreCon.setValDoc(const Value: String);
begin

  If fStrToFloat(Value) <= 0 Then
    Raise Exception.Create('O valor do documento deve ser maior que zero!')
  Else
    FValDoc := fStrToFloat(Value);

end;

procedure TFreCon.setValIc1(const Value: String);
begin
  FValIc1 := fStrToFloat(Value);
end;

procedure TFreCon.setValIc2(const Value: String);
begin
  FValIc2 := fStrToFloat(Value);
end;

procedure TFreCon.setValIc3(const Value: String);
begin
  FValIc3 := fStrToFloat(Value);
end;

procedure TFreCon.setValIc4(const Value: String);
begin
  FValIc4 := fStrToFloat(Value);
end;

procedure TFreCon.setValIc5(const Value: String);
begin
  FValIc5 := fStrToFloat(Value);
end;

procedure TFreCon.setValIp1(const Value: String);
begin
  FValIp1 := fStrToFloat(Value);
end;

procedure TFreCon.setValIp2(const Value: String);
begin
  FValIp2 := fStrToFloat(Value);
end;

procedure TFreCon.setValIp3(const Value: String);
begin
  FValIp3 := fStrToFloat(Value);
end;

procedure TFreCon.setValIp4(const Value: String);
begin
  FValIp4 := fStrToFloat(Value);
end;

procedure TFreCon.setValIp5(const Value: String);
begin
  FValIp5 := fStrToFloat(Value);
end;

procedure TFreCon.setValIs1(const Value: String);
begin
  FValIs1 := fStrToFloat(Value);
end;

procedure TFreCon.setValIs2(const Value: String);
begin
  FValIs2 := fStrToFloat(Value);
end;

procedure TFreCon.setValIs3(const Value: String);
begin
  FValIs3 := fStrToFloat(Value);
end;

procedure TFreCon.setValIs4(const Value: String);
begin
  FValIs4 := fStrToFloat(Value);
end;

procedure TFreCon.setValIs5(const Value: String);
begin
  FValIs5 := fStrToFloat(Value);
end;

procedure TFreCon.setValOu1(const Value: String);
begin
  FValOu1 := fStrToFloat(Value);
end;

procedure TFreCon.setValOu2(const Value: String);
begin
  FValOu2 := fStrToFloat(Value);
end;

procedure TFreCon.setValOu3(const Value: String);
begin
  FValOu3 := fStrToFloat(Value);
end;

procedure TFreCon.setValOu4(const Value: String);
begin
  FValOu4 := fStrToFloat(Value);
end;

procedure TFreCon.setValOu5(const Value: String);
begin
  FValOu5 := fStrToFloat(Value);
end;

procedure TFreCon.setValRe1(const Value: String);
begin
  FValRe1 := fStrToFloat(Value);
end;

procedure TFreCon.setValRe2(const Value: String);
begin
  FValRe2 := fStrToFloat(Value);
end;

procedure TFreCon.setValRe3(const Value: String);
begin
  FValRe3 := fStrToFloat(Value);
end;

procedure TFreCon.setValRe4(const Value: String);
begin
  FValRe4 := fStrToFloat(Value);
end;

procedure TFreCon.setValRe5(const Value: String);
begin
  FValRe5 := fStrToFloat(Value);
end;

procedure TFreCon.pAtualizaDados;

begin
  FCgcTra := qryTabela.FieldByName('CGCTRA').AsString;
  FIsDocDCe := qryTabela.FieldByName('DOCDCE').AsString = 'S';

  FCGCDes := qryTabela.FieldByName('CGCDES').AsString;

  FCGCREM := qryTabela.FieldByName('CGCREM').AsString;
  FTomSer := qryTabela.FieldByName('TOMSER').AsString;
  FForPag := qryTabela.FieldByName('FORPAG').AsString;

  FCodEmp := qryTabela.FieldByName('CODEMP').AsString;

  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;

  FDuplic := qryTabela.FieldByName('DUPLIC').AsString;
  FLinDig := qryTabela.FieldByName('LINDIG').AsString;
  FCodBar := qryTabela.FieldByName('CODBAR').AsString;

  FNumDoc := qryTabela.FieldByName('NUMDOC').AsString;
  FSerie_ := qryTabela.FieldByName('SERIE_').AsString;
  FComplemento := qryTabela.FieldByName('COMPLE').AsString;
  FBrinde := qryTabela.FieldByName('BRINDE').AsString;

  FVeioNF := qryTabela.FieldByName('VEIONF').AsString;
  FstrArquivoXML := qryTabela.FieldByName('ARQUIV').AsString;
  FUsaChq := qryTabela.FieldByName('USACHQ').AsString;
  FPrevis := qryTabela.FieldByName('PREVIS').AsString;
  FPagAnt := qryTabela.FieldByName('PAGANT').AsString;
  FUsoCon := qryTabela.FieldByName('USOCON').AsString;

  FTipDoc := qryTabela.FieldByName('TIPDOC').AsString;
  FGuiTri := qryTabela.FieldByName('Q_GUIA').AsString;
  FTipTri := qryTabela.FieldByName('CODREC').AsString;

  FDeposi := qryTabela.FieldByName('DEPOSI').AsString;
  FTransf := qryTabela.FieldByName('TRANSF').AsString;
  FBcoFor := qryTabela.FieldByName('BCOFOR').AsString;

  FModFre := qryTabela.FieldByName('MODFRE').AsString;
  FEspDoc := qryTabela.FieldByName('ESPDOC').AsString;
  FCodTra := qryTabela.FieldByName('CODTRA').AsString;
  FtpDocFrete := fCharToTipoDocFrete(qryTabela.FieldByName('TIPCTE').AsString);

  FCndPag := qryTabela.FieldByName('CNDPAG').AsString;
  FAcesso := qryTabela.FieldByName('ACESSO').AsString;
  FEmpresaPagadora := qryTabela.FieldByName('EMPPAG').AsString;

  FModelo := qryTabela.FieldByName('MODELO').AsString;

  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;

  If fEmptyStr(FCndPag ) Then
  begin
    If blnUSACND then
      FCndPag := fDefineCndPag(FCndVaz)
    Else
      FCndPag := FCndVaz;
  End;

  FCodCta := qryTabela.FieldByName('CODCTA').AsString;
  FCtaRec := qryTabela.FieldByName('CTAREC').AsString;

  FCodEve := qryTabela.FieldByName('CODEVE').AsString;
  FCompet := qryTabela.FieldByName('COMPET').AsString;
  FValDoc := qryTabela.FieldByName('VALDOC').AsFloat;
  FDtaEnt := qryTabela.FieldByName('DTAENT').AsDateTime;
  FDtaDoc := qryTabela.FieldByName('DTADOC').AsDateTime;
  FHis001 := qryTabela.FieldByName('HIS001').AsString;

  FClaFi1 := qryTabela.FieldByName('CLAFI1').AsString;
  FClaFixml := qryTabela.FieldByName('CLAFIXML').AsString;
  FValCo1 := qryTabela.FieldByName('VALCO1').AsFloat;
  FBasIc1 := qryTabela.FieldByName('BASIC1').AsFloat;
  FAlqIc1 := qryTabela.FieldByName('ALQIC1').AsFloat;
  FValIc1 := qryTabela.FieldByName('VALIC1').AsFloat;
  FValOu1 := qryTabela.FieldByName('VALOU1').AsFloat;
  FValIs1 := qryTabela.FieldByName('VALIS1').AsFloat;
  FValRe1 := qryTabela.FieldByName('VALRE1').AsFloat;
  FBasIp1 := qryTabela.FieldByName('BASIP1').AsFloat;
  FValIp1 := qryTabela.FieldByName('VALIP1').AsFloat;
  FBasSu1 := qryTabela.FieldByName('BASSU1').AsFloat;
  FDesAc1 := qryTabela.FieldByName('DESAC1').AsFloat;

  FClaFi2 := qryTabela.FieldByName('CLAFI2').AsString;
  FValCo2 := qryTabela.FieldByName('VALCO2').AsFloat;
  FBasIc2 := qryTabela.FieldByName('BASIC2').AsFloat;
  FAlqIc2 := qryTabela.FieldByName('ALQIC2').AsFloat;
  FValIc2 := qryTabela.FieldByName('VALIC2').AsFloat;
  FValOu2 := qryTabela.FieldByName('VALOU2').AsFloat;
  FValIs2 := qryTabela.FieldByName('VALIS2').AsFloat;
  FValRe2 := qryTabela.FieldByName('VALRE2').AsFloat;
  FBasIp2 := qryTabela.FieldByName('BASIP2').AsFloat;
  FValIp2 := qryTabela.FieldByName('VALIP2').AsFloat;
  FBasSu2 := qryTabela.FieldByName('BASSU2').AsFloat;
  FDesAc2 := qryTabela.FieldByName('DESAC2').AsFloat;

  FClaFi3 := qryTabela.FieldByName('CLAFI3').AsString;
  FValCo3 := qryTabela.FieldByName('VALCO3').AsFloat;
  FBasIc3 := qryTabela.FieldByName('BASIC3').AsFloat;
  FAlqIc3 := qryTabela.FieldByName('ALQIC3').AsFloat;
  FValIc3 := qryTabela.FieldByName('VALIC3').AsFloat;
  FValOu3 := qryTabela.FieldByName('VALOU3').AsFloat;
  FValIs3 := qryTabela.FieldByName('VALIS3').AsFloat;
  FValRe3 := qryTabela.FieldByName('VALRE3').AsFloat;
  FBasIp3 := qryTabela.FieldByName('BASIP3').AsFloat;
  FValIp3 := qryTabela.FieldByName('VALIP3').AsFloat;
  FBasSu3 := qryTabela.FieldByName('BASSU3').AsFloat;
  FDesAc3 := qryTabela.FieldByName('DESAC3').AsFloat;

  FClaFi4 := qryTabela.FieldByName('CLAFI4').AsString;
  FValCo4 := qryTabela.FieldByName('VALCO4').AsFloat;
  FBasIc4 := qryTabela.FieldByName('BASIC4').AsFloat;
  FAlqIc4 := qryTabela.FieldByName('ALQIC4').AsFloat;
  FValIc4 := qryTabela.FieldByName('VALIC4').AsFloat;
  FValOu4 := qryTabela.FieldByName('VALOU4').AsFloat;
  FValIs4 := qryTabela.FieldByName('VALIS4').AsFloat;
  FValRe4 := qryTabela.FieldByName('VALRE4').AsFloat;
  FBasIp4 := qryTabela.FieldByName('BASIP4').AsFloat;
  FValIp4 := qryTabela.FieldByName('VALIP4').AsFloat;
  FBasSu4 := qryTabela.FieldByName('BASSU4').AsFloat;
  FDesAc4 := qryTabela.FieldByName('DESAC4').AsFloat;

  FPesoBruto := qryTabela.FieldByName('PESBRU').AsFloat;

  FClaFi5 := qryTabela.FieldByName('CLAFI5').AsString;
  FValCo5 := qryTabela.FieldByName('VALCO5').AsFloat;
  FBasIc5 := qryTabela.FieldByName('BASIC5').AsFloat;
  FAlqIc5 := qryTabela.FieldByName('ALQIC5').AsFloat;
  FValIc5 := qryTabela.FieldByName('VALIC5').AsFloat;
  FValOu5 := qryTabela.FieldByName('VALOU5').AsFloat;
  FValIs5 := qryTabela.FieldByName('VALIS5').AsFloat;
  FValRe5 := qryTabela.FieldByName('VALRE5').AsFloat;
  FBasIp5 := qryTabela.FieldByName('BASIP5').AsFloat;
  FValIp5 := qryTabela.FieldByName('VALIP5').AsFloat;
  FBasSu5 := qryTabela.FieldByName('BASSU5').AsFloat;
  FDesAc5 := qryTabela.FieldByName('DESAC5').AsFloat;

  FAlqPis    := qryTabela.FieldByName('ALQPIS').AsFloat;
  FAlqCof    := qryTabela.FieldByName('ALQCOF').AsFloat;
  FPerBasPis := qryTabela.FieldByName('BASPIS').AsFloat;
  FPerBasCof := qryTabela.FieldByName('BASCOF').AsFloat;

  FAutPis    := qryTabela.FieldByName('AUTPIS').AsString;
  FAutCof    := qryTabela.FieldByName('AUTCOF').AsString;

  FCstPis    := qryTabela.FieldByName('CSTPIS').AsString;
  FCstCof    := qryTabela.FieldByName('CSTCOF').AsString;

  FblnGraCTP := IIf(qryTabela.FieldByName('GRACTP').AsString <> '',
                    qryTabela.FieldByName('GRACTP').AsString = 'S',
                    True);

  blnVeioBoleto := qryTabela.FieldByName('VEIOBO').AsString = 'S';

  FValTot := (FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5);

  FEstTra := fRetEstadoFornecedor(FCodTra);


  FCodMunicipioInicio   := qryTabela.FieldByName('MUNINI').AsString;
  FUFInicio             := qryTabela.FieldByName('UFINI_').AsString;
  FMunicipioDescricaoInicio:= qryTabela.FieldByName('DESMNI').AsString;
  FCodMunicipioFim      := qryTabela.FieldByName('MUNFIM').AsString;
  FUFFim                := qryTabela.FieldByName('UFFIM_').AsString;
  FMunicipioDescricaoFim:= qryTabela.FieldByName('DESMNF').AsString;


  FRemetente    := fCarregaPessoaConvertidaBlob(ConsRemetente);
  FEmitente     := fCarregaPessoaConvertidaBlob(ConsEmitente);
  FExpedidor    := fCarregaPessoaConvertidaBlob(ConsExpedidor);
  FRecebedor    := fCarregaPessoaConvertidaBlob(ConsRecebedor);
  FDestinatario := fCarregaPessoaConvertidaBlob(ConsDestinatario);
  FTomador      := fCarregaPessoaConvertidaBlob(ConsTomador);
  FCreditaICMS  := qryTabela.FieldByName('CREICM').AsInteger = 1;
  FDtaCan := qryTabela.FieldByName('DTACAN').AsDateTime;
  FAutInc := qryTabela.FieldByName('AUTINC').AsString;
  FvREC := qryTabela.FieldByName('VREC_').AsFloat;
end;

procedure TFreCon.pAtualizaTentativaImp;
var
  qryAux: TUniQuery;
  strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE MOVCTE ';
  strSQL := strSQL + 'SET CTE_TENIMP = CTE_TENIMP + 1 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTE_NUMCTE = :NUMCTE AND ';
  strSQL := strSQL + '  CTE_CODEMP = :CODEMP';

  qryAux := fCriaQuery;

  try
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMCTE').AsString := qryCTes.FieldByName('CTE_NUMCTE').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryCTes.FieldByName('CTE_CODEMP').AsString;
    qryAux.ExecSQL;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(AnsiReplaceStr(strSQL, 'MOVCTE', 'NOTCTE'));
    qryAux.ParamByName('NUMCTE').AsString := qryCTes.FieldByName('CTE_NUMCTE').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryCTes.FieldByName('CTE_CODEMP').AsString;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end
end;

function TFreCon.fCarregaPessoaConvertidaBlob(
  intTipoPessoa: integer): TPessoaCTE;
begin
  case intTipoPessoa of
    ConsRemetente   : Result.StringParaPessoaCte(qryTabela.FieldByName('REMETENTE').AsString);
    ConsEmitente    : Result.StringParaPessoaCte(qryTabela.FieldByName('EMITENTE').AsString);
    ConsExpedidor   : Result.StringParaPessoaCte(qryTabela.FieldByName('EXPEDIDOR').AsString);
    ConsRecebedor   : Result.StringParaPessoaCte(qryTabela.FieldByName('RECEBEDOR').AsString);
    ConsDestinatario: Result.StringParaPessoaCte(qryTabela.FieldByName('DESTINATARIO').AsString);
    ConsTomador     : Result.StringParaPessoaCte(qryTabela.FieldByName('TOMADOR').AsString);
  End;
end;

procedure TFreCon.pBeforePost(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If (FieldByName('IMPORT').AsString = 'S') And
       ((FieldByName('STATUS').AsInteger <> IMPORTADO_OK) And
        (FieldByName('STATUS').AsInteger <> IMPORTADO_OK_SEM_NF)And
        (FieldByName('STATUS').AsInteger <> IMPORTADO_SEM_PISCOF)) Then
     FieldByName('IMPORT').AsString := 'N';
  End;
end;

function TFreCon.fVerificaSeCreditaICMS(intTomador: integer): Boolean;
var strCodCliTomador, strEmpresaTomador: string;
begin
  Result := True;
  If (tpFrete = tpfEntrada) Then
  begin
    If fCfgSis('SIMPAU', varBoolean) Then
      Exit(False)
    Else
      Exit;
  End;

  If fCfgSis('FREICM', varBoolean) Then
    Exit;

  If intTomador in ([tomador_Remetente, tomador_Destinatario]) Then
  Begin
    strCodCliTomador := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [FTomador.strCNPJ]);
    If (Not fEmptyStr(strCodCliTomador)) And fClienteFilial(strCodCliTomador, strEmpresaTomador) Then
      Result := False;
  End;
end;

function TFreCon.fVerificaTemCadFisSaida(strForCli, strCodEmp, strEntSai, strTip_FC: String): String;
var
  qryCadFis: TUniQuery;
begin
  Result := '';

  if (not blnImportaPeloBancoDados) then
    Exit;

  qryCadFis := fCriaQuery;

  try
    qryCadFis.SQL.Add('SELECT AUTOINCREM FROM CADFIS');
    qryCadFis.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC AND ');
    qryCadFis.SQL.Add('    FIS_CODEMP = :CODEMP AND ');
    qryCadFis.SQL.Add('    FIS_ESPDOC = :ESPDOC AND ');
    qryCadFis.SQL.Add('    FIS_FORCLI = :FORCLI AND ');
    qryCadFis.SQL.Add('    FIS_ENTSAI = :ENTSAI AND ');
    qryCadFis.SQL.Add('    FIS_TIP_FC = :TIP_FC');

    qryCadFis.ParamByName('NUMDOC').AsString := FNumDoc;
    qryCadFis.ParamByName('ESPDOC').AsString := FEspDoc;
    qryCadFis.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFis.ParamByName('FORCLI').AsString := strForCli;
    qryCadFis.ParamByName('ENTSAI').AsString := strEntSai;
    qryCadFis.ParamByName('TIP_FC').AsString := strTip_FC;

    qryCadFis.Open;

    Result := qryCadFis.FieldByName('AUTOINCREM').AsString;
  finally
    FreeAndNil(qryCadFis);
  end;
end;

function TFreCon.fVerificaTemCadPag(strCodEmp, strSequen: String): Boolean;
var
  qryCadPag: TUniQuery;
begin
  Result := False;

  if (not blnImportaPeloBancoDados) then
    Exit;

  qryCadPag := fCriaQuery;

  try
    qryCadPag.SQL.Add('SELECT * FROM CADPAG');
    qryCadPag.SQL.Add('WHERE CTP_NUMDUP = :NUMDUP AND ');
    qryCadPag.SQL.Add('    CTP_PARCEL = :PARCEL AND ');
    qryCadPag.SQL.Add('    CTP_CODFOR = :CODFOR AND ');
    qryCadPag.SQL.Add('    CTP_CODEMP = :CODEMP');

    qryCadPag.ParamByName('NUMDUP').AsString := FNumDoc;
    qryCadPag.ParamByName('PARCEL').AsString := strSequen;
    qryCadPag.ParamByName('CODFOR').AsString := FCodTra;
    qryCadPag.ParamByName('CODEMP').AsString := strCodEmp;

    qryCadPag.Open;

    Result := not qryCadPag.IsEmpty;
  finally
    FreeAndNil(qryCadPag);
  end;
end;

function TFreCon.fVerificaTemCadRecSaida(strSequen, strCodCli, strCodEmp: String): Boolean;
var
  qryCadRec: TUniQuery;
begin
  Result := False;

  if (not blnImportaPeloBancoDados) then
    Exit;

  qryCadRec := fCriaQuery;

  try
    qryCadRec.SQL.Add('SELECT * FROM CADREC');
    qryCadRec.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP AND ');
    qryCadRec.SQL.Add('    CTR_PARCEL = :PARCEL AND ');
    qryCadRec.SQL.Add('    CTR_ESPDOC = :ESPDOC AND ');
    qryCadRec.SQL.Add('    CTR_CODCLI = :CODCLI AND ');
    qryCadRec.SQL.Add('    CTR_CODEMP = :CODEMP');

    qryCadRec.ParamByName('NUMDUP').AsString := FNumDoc;
    qryCadRec.ParamByName('PARCEL').AsString := strSequen;
    qryCadRec.ParamByName('ESPDOC').AsString := FEspDoc;
    qryCadRec.ParamByName('CODCLI').AsString := strCodCli;
    qryCadRec.ParamByName('CODEMP').AsString := strCodEmp;

    qryCadRec.Open;

    Result := not qryCadRec.IsEmpty;
  finally
    FreeAndNil(qryCadRec);
  end;
end;

procedure TFreCon.pEnviaDados;
begin
  qryTabela.FieldByName('CGCTRA').AsString   := FCgcTra;
  qryTabela.FieldByName('DOCDCE').AsString := IIf(FIsDocDCe, 'S', 'N');

  qryTabela.FieldByName('CGCDES').AsString   := FCgcDes;

  qryTabela.FieldByName('CGCREM').AsString   := FCgcRem;
  qryTabela.FieldByName('TOMSER').AsString   := FTomSer;
  qryTabela.FieldByName('FORPAG').AsString   := FForPag;

  If fEmptyStr(FCodEmp) Then
    FCodEmp := VS_strCodEmp;

  qryTabela.FieldByName('CODEMP').AsString   := FCodEmp;
  qryTabela.FieldByName('PESBRU').AsFloat    := FPesoBruto;

  qryTabela.FieldByName('DUPLIC').AsString   := FDuplic;
  qryTabela.FieldByName('LINDIG').AsString   := FLinDig;
  qryTabela.FieldByName('CODBAR').AsString   := FCodBar;

  qryTabela.FieldByName('ACESSO').AsString   := FAcesso;
  qryTabela.FieldByName('EMPPAG').AsString   := FEmpresaPagadora;
  qryTabela.FieldByName('NUMDOC').AsString   := FNumDoc;
  qryTabela.FieldByName('COMPLE').AsString  := FComplemento;
  qryTabela.FieldByName('BRINDE').AsString  := FBrinde;
  qryTabela.FieldByName('SERIE_').AsString   := FSerie_;

  qryTabela.FieldByName('VEIONF').AsString   := FVeioNF;
  qryTabela.FieldByName('ARQUIV').AsString  := FstrArquivoXML;

  qryTabela.FieldByName('USACHQ').AsString   := FUsaChq;
  qryTabela.FieldByName('PREVIS').AsString   := FPrevis;
  qryTabela.FieldByName('PAGANT').AsString   := FPagAnt;
  qryTabela.FieldByName('USOCON').AsString   := FUsoCon;

  qryTabela.FieldByName('TIPDOC').AsString   := FTipDoc;
  qryTabela.FieldByName('Q_GUIA').AsString   := FGuiTri;
  qryTabela.FieldByName('CODREC').AsString   := FTipTri;

  qryTabela.FieldByName('DEPOSI').AsString   := FDeposi;
  qryTabela.FieldByName('TRANSF').AsString   := FTransf;
  qryTabela.FieldByName('BCOFOR').AsString   := FBcoFor;

  qryTabela.FieldByName('MODFRE').AsString   := FModFre;
  qryTabela.FieldByName('ESPDOC').AsString   := FEspDoc;
  qryTabela.FieldByName('CODTRA').AsString   := FCodTra;
  qryTabela.FieldByName('CNDPAG').AsString   := FCndPag;
  If fEmptyStr(FCndPag ) Then
  begin
    If blnUSACND then
      qryTabela.FieldByName('CNDPAG').AsString := fDefineCndPag(FCndVaz)
    Else
      qryTabela.FieldByName('CNDPAG').AsString := FCndVaz;
  End;

  qryTabela.FieldByName('CNDXML').AsString   := FCndXML;

  qryTabela.FieldByName('TIPCTE').AsString   := fTipoDocFreteToChar(FtpDocFrete);

  qryTabela.FieldByName('MODELO').AsString   := FModelo;

  qryTabela.FieldByName('CODCTA').AsString   := FCodCta;
  qryTabela.FieldByName('CTAREC').AsString   := FCtaRec;

  qryTabela.FieldByName('CODEVE').AsString   := FCodEve;
  qryTabela.FieldByName('COMPET').AsString   := FCompet;
  qryTabela.FieldByName('VALDOC').AsFloat    := FValDoc;
  qryTabela.FieldByName('DTAENT').AsDateTime := FDtaEnt;
  qryTabela.FieldByName('DTADOC').AsDateTime := FDtaDoc;
  qryTabela.FieldByName('HIS001').AsString   := FHis001;

  qryTabela.FieldByName('CLAFI1').AsString   := FClaFi1;
  qryTabela.FieldByName('CLAFIXML').AsString   := FClaFiXML;
  qryTabela.FieldByName('VALCO1').AsFloat    := FValCo1;
  qryTabela.FieldByName('BASIC1').AsFloat    := FBasIc1;
  qryTabela.FieldByName('ALQIC1').AsFloat    := FAlqIc1;
  qryTabela.FieldByName('VALIC1').AsFloat    := FValIc1;
  qryTabela.FieldByName('VALOU1').AsFloat    := FValOu1;
  qryTabela.FieldByName('VALIS1').AsFloat    := FValIs1;
  qryTabela.FieldByName('VALRE1').AsFloat    := FValRe1;
  qryTabela.FieldByName('BASIP1').AsFloat    := FBasIp1;
  qryTabela.FieldByName('VALIP1').AsFloat    := FValIp1;
  qryTabela.FieldByName('BASSU1').AsFloat    := FBasSu1;
  qryTabela.FieldByName('DESAC1').AsFloat    := FDesAc1;

  qryTabela.FieldByName('CLAFI2').AsString   := FClaFi2;
  qryTabela.FieldByName('VALCO2').AsFloat    := FValCo2;
  qryTabela.FieldByName('BASIC2').AsFloat    := FBasIc2;
  qryTabela.FieldByName('ALQIC2').AsFloat    := FAlqIc2;
  qryTabela.FieldByName('VALIC2').AsFloat    := FValIc2;
  qryTabela.FieldByName('VALOU2').AsFloat    := FValOu2;
  qryTabela.FieldByName('VALIS2').AsFloat    := FValIs2;
  qryTabela.FieldByName('VALRE2').AsFloat    := FValRe2;
  qryTabela.FieldByName('BASIP2').AsFloat    := FBasIp2;
  qryTabela.FieldByName('VALIP2').AsFloat    := FValIp2;
  qryTabela.FieldByName('BASSU2').AsFloat    := FBasSu2;
  qryTabela.FieldByName('DESAC2').AsFloat    := FDesAc2;

  qryTabela.FieldByName('CLAFI3').AsString   := FClaFi3;
  qryTabela.FieldByName('VALCO3').AsFloat    := FValCo3;
  qryTabela.FieldByName('BASIC3').AsFloat    := FBasIc3;
  qryTabela.FieldByName('ALQIC3').AsFloat    := FAlqIc3;
  qryTabela.FieldByName('VALIC3').AsFloat    := FValIc3;
  qryTabela.FieldByName('VALOU3').AsFloat    := FValOu3;
  qryTabela.FieldByName('VALIS3').AsFloat    := FValIs3;
  qryTabela.FieldByName('VALRE3').AsFloat    := FValRe3;
  qryTabela.FieldByName('BASIP3').AsFloat    := FBasIp3;
  qryTabela.FieldByName('VALIP3').AsFloat    := FValIp3;
  qryTabela.FieldByName('BASSU3').AsFloat    := FBasSu3;
  qryTabela.FieldByName('DESAC3').AsFloat    := FDesAc3;

  qryTabela.FieldByName('CLAFI4').AsString   := FClaFi4;
  qryTabela.FieldByName('VALCO4').AsFloat    := FValCo4;
  qryTabela.FieldByName('BASIC4').AsFloat    := FBasIc4;
  qryTabela.FieldByName('ALQIC4').AsFloat    := FAlqIc4;
  qryTabela.FieldByName('VALIC4').AsFloat    := FValIc4;
  qryTabela.FieldByName('VALOU4').AsFloat    := FValOu4;
  qryTabela.FieldByName('VALIS4').AsFloat    := FValIs4;
  qryTabela.FieldByName('VALRE4').AsFloat    := FValRe4;
  qryTabela.FieldByName('BASIP4').AsFloat    := FBasIp4;
  qryTabela.FieldByName('VALIP4').AsFloat    := FValIp4;
  qryTabela.FieldByName('BASSU4').AsFloat    := FBasSu4;
  qryTabela.FieldByName('DESAC4').AsFloat    := FDesAc4;

  qryTabela.FieldByName('CLAFI5').AsString   := FClaFi5;
  qryTabela.FieldByName('VALCO5').AsFloat    := FValCo5;
  qryTabela.FieldByName('BASIC5').AsFloat    := FBasIc5;
  qryTabela.FieldByName('ALQIC5').AsFloat    := FAlqIc5;
  qryTabela.FieldByName('VALIC5').AsFloat    := FValIc5;
  qryTabela.FieldByName('VALOU5').AsFloat    := FValOu5;
  qryTabela.FieldByName('VALIS5').AsFloat    := FValIs5;
  qryTabela.FieldByName('VALRE5').AsFloat    := FValRe5;
  qryTabela.FieldByName('BASIP5').AsFloat    := FBasIp5;
  qryTabela.FieldByName('VALIP5').AsFloat    := FValIp5;
  qryTabela.FieldByName('BASSU5').AsFloat    := FBasSu5;
  qryTabela.FieldByName('DESAC5').AsFloat    := FDesAc5;
  qryTabela.FieldByName('GRACTP').AsString   := IIf(FblnGraCTP, 'S', 'N');

  qryTabela.FieldByName('ALQPIS').AsFloat    := FAlqPis;
  qryTabela.FieldByName('ALQCOF').AsFloat    := FAlqCof;
  qryTabela.FieldByName('BASPIS').AsFloat    := FPerBasPis;
  qryTabela.FieldByName('BASCOF').AsFloat    := FPerBasCof;
  qryTabela.FieldByName('AUTPIS').AsString   := FAutPis;
  qryTabela.FieldByName('AUTCOF').AsString   := FAutCof;

  qryTabela.FieldByName('CSTPIS').AsString   := FCstPis;
  qryTabela.FieldByName('CSTCOF').AsString   := FCstCof;

  qryTabela.FieldByName('VEIOBO').AsString   := IIf(blnVeioBoleto, 'S', 'N');
  qryTabela.FieldByName('CREICM').AsInteger   := IIf(FCreditaICMS, 1, 0);


  qryTabela.FieldByName('MUNINI').AsString:= FCodMunicipioInicio;
  qryTabela.FieldByName('UFINI_').AsString:= FUFInicio;
  qryTabela.FieldByName('DESMNI').AsString:= FMunicipioDescricaoInicio;
  qryTabela.FieldByName('DESMNF').AsString:= FMunicipioDescricaoFim;
  qryTabela.FieldByName('UFFIM_').AsString:= FUFFim;
  qryTabela.FieldByName('MUNFIM').AsString:= FCodMunicipioFim;
  qryTabela.FieldByName('DTACAN').AsDateTime:= FDtaCan;
  qryTabela.FieldByName('AUTINC').AsString:= FAutInc;
  qryTabela.FieldByName('VREC_').AsFloat  := FvREC;

  pEnviaDadosPessoa;
end;

procedure TFreCon.pEnviaDadosPessoa;
  procedure pProcessa(intTipoPessoa: integer; strTipoPessoa: string);
  begin
    case intTipoPessoa of
      ConsRemetente    :qryTabela.FieldByName('REMETENTE').AsString := FRemetente.PessoaCteParaString;
      ConsEmitente     :qryTabela.FieldByName('EMITENTE').AsString := FEmitente.PessoaCteParaString;
      ConsExpedidor    :qryTabela.FieldByName('EXPEDIDOR').AsString := FExpedidor.PessoaCteParaString;
      ConsRecebedor    :qryTabela.FieldByName('RECEBEDOR').AsString := FRecebedor.PessoaCteParaString;
      ConsDestinatario :qryTabela.FieldByName('DESTINATARIO').AsString := FDestinatario.PessoaCteParaString;
      ConsTomador      :qryTabela.FieldByName('TOMADOR').AsString := FTomador.PessoaCteParaString;
    End;
  End;
Begin
  pProcessa(ConsRemetente   , 'REMETENTE');
  pProcessa(ConsEmitente    , 'EMITENTE');
  pProcessa(ConsExpedidor   , 'EXPEDIDOR');
  pProcessa(ConsRecebedor   , 'RECEBEDOR');
  pProcessa(ConsDestinatario, 'DESTINATARIO');
  pProcessa(ConsTomador     , 'TOMADOR');
End;

procedure TFreCon.pEscreveMensagemImportacao(memMsg: TStrings; strMensagem: String;
  intLinha: Integer);
  var
     strTexto: string;
begin
  If Assigned(memMsg) Then
  Begin
    strTexto := FormatDateTime('hh:mm:ss', fNow());
    strTexto := strTexto + ' - ';
    strTexto := strTexto + IIF(intLinha > 0, 'Linha ' + IntToStr(intLinha) + ' - ', '');
    memMsg.Add( strTexto + strMensagem);
    Application.ProcessMessages;
  End
  Else
   pMensagemOk(strMensagem);
end;

function TFreCon.getAlqIcT: String;
begin
  Result := FloatToStrF(FAlqIc1 + FAlqIc2 + FAlqIc3 + FAlqIc4 + FAlqIc5, ffFixed, 12, 2);
end;

function TFreCon.getBasIcT: String;
begin
  Result := FloatToStrF(FBasIc1 + FBasIc2 + FBasIc3 + FBasIc4 + FBasIc5, ffFixed, 12, 2);
end;

function TFreCon.getBasIpT: String;
begin
  Result := FloatToStrF(FBasIp1 + FBasIp2 + FBasIp3 + FBasIp4 + FBasIp5, ffFixed, 12, 2);
end;

function TFreCon.getBasSuT: String;
begin
  Result := FloatToStrF(FBasSu1 + FBasSu2 + FBasSu3 + FBasSu4 + FBasSu5, ffFixed, 12, 2);
end;

function TFreCon.getDesAcT: String;
begin
  Result := FloatToStrF(FDesAc1 + FDesAc2 + FDesAc3 + FDesAc4 + FDesAc5, ffFixed, 12, 2);
end;

function TFreCon.getValCoT: String;
begin
  Result := FloatToStrF(FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5, ffFixed, 12, 2);
end;

function TFreCon.getValIcT: String;
begin
  Result := FloatToStrF(FValIc1 + FValIc2 + FValIc3 + FValIc4 + FValIc5, ffFixed, 12, 2);
end;

function TFreCon.getValIpT: String;
begin
  Result := FloatToStrF(FValIp1 + FValIp2 + FValIp3 + FValIp4 + FValIp5, ffFixed, 12, 2);
end;

function TFreCon.getValIsT: String;
begin
  Result := FloatToStrF(FValIs1 + FValIs2 + FValIs3 + FValIs4 + FValIs5, ffFixed, 12, 2);
end;

function TFreCon.getValOuT: String;
begin
  Result := FloatToStrF(FValOu1 + FValOu2 + FValOu3 + FValOu4 + FValOu5, ffFixed, 12, 2);
end;

function TFreCon.getValReT: String;
begin
  Result := FloatToStrF(FValRe1 + FValRe2 + FValRe3 + FValRe4 + FValRe5, ffFixed, 12, 2);
end;

procedure TFreCon.pMarcaTodosArquivos(blnMarcar: Boolean);
begin
  qryTabela.DisableControls;
  qryTabela.First;
  While not qryTabela.Eof Do
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('IMPORT').AsString :=IfThen(blnMarcar, 'S', 'N');
    qryTabela.Post;
    qryTabela.Next;
  End;
 qryTabela.EnableControls;

end;

procedure TFreCon.pMarcaTodosCreditaICMS(blnMarcar: Boolean);
begin
  qryTabela.DisableControls;
  qryTabela.First;
  While not qryTabela.Eof Do
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('CREICM').AsInteger := IfThen(blnMarcar, 1, 0);
    qryTabela.Post;
    qryTabela.Next;
  End;
 qryTabela.EnableControls;

end;

Procedure TFreCon.pMontaDuplicatasFrete(var arrDuplicata: TarrDuplicata);
Begin
  {******************************************}
  {* VERIFICA SE HOUVE ALTERAÇÃO DE VALORES *}
  {* OU VENCIMENTO DURANTE O LANÇAMENTO DO  *}
  {* FRETE DE CONHECIMENTO.                 *}
  {***************************************PZ*}
  If (Not blnAltDup) Then
    fDigDuplic(arrDuplicata,
               FCndPag,
               0,
               IIf(blnLEVREC and (FvREC > 0) and (tpFrete = tpfEntrada), FvREC, FValDoc),
               False,
               True,
               False,
               FDtaDoc,
               True,
               0,
               'N')
  Else
    // JOGA DO ARRDUPPRE PARA O ARRDUPLICATAS
    pControlaDigDuplicAtual(3);
End;

function TFreCon.fSimples(strFornecedor: String): Boolean;
Var qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.Close;
  qryAux.SQL.Text := 'SELECT FOR_SIMPAU FROM CADFOR WHERE FOR_CODFOR = :CODFOR';
  qryAux.ParamByName('CODFOR').AsString := strFornecedor;
  Try
    qryAux.Open;
    Result := qryAux.FieldByName('FOR_SIMPAU').AsString = 'S';
  Except
    Result := False;
  End;
  FreeAndNil(qryAux);
end;

function TFreCon.fCalculaBasePisCofinsReduzidaPelaEntradas(FBasOriginal, aValIcms: Double; strNotasEntrada: String): Double;
var qryCalculaBase: TUniQuery;
Begin
  If fCfgSis('DEIPCT', varBoolean)  Then
     FBasOriginal := FBasOriginal - aValIcms;

  If (fCfgSis('CPCICF') = '1') or (fEmptyStr(strNotasEntrada)) Then
    Exit(FBasOriginal);

  qryCalculaBase := fCriaQuery;
  Try
    qryCalculaBase.SQL.Add('SELECT');
    qryCalculaBase.SQL.Add('SUM(ROUND( DET_VLRCON * ( ROUND(:VALBAS * 100 / (SELECT SUM(GER_VLRCON) FROM MOVGER WHERE AUTOINCREM IN (' + strNotasEntrada + ') ), 2) ) / 100,    2  ) ) VAL_SEMPIS');
    qryCalculaBase.SQL.Add('FROM MOVDET');
    qryCalculaBase.SQL.Add('LEFT JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER');
    qryCalculaBase.SQL.Add('INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER');
    qryCalculaBase.SQL.Add('WHERE MOVDET.DET_SEQGER IN (' + strNotasEntrada + ')');
    qryCalculaBase.SQL.Add('AND DET_BASPIS = 0');
    qryCalculaBase.SQL.Add('AND DET_CSTPIS IN ("04","70")');

    qryCalculaBase.ParamByName('VALBAS').AsFloat :=  FBasOriginal;

    qryCalculaBase.Open;

    If qryCalculaBase.IsEmpty Then
      Exit(FBasOriginal);

    {If Not fCfgSis('ICMCRE', varBoolean)  Then
      aValIcms := 0;
    Result := (FBasOriginal - aValIcms - qryCalculaBase.FieldByName('VAL_SEMPIS').AsFloat);   }

    Result := (FBasOriginal - qryCalculaBase.FieldByName('VAL_SEMPIS').AsFloat);

    If Result < 0 Then
      Result := 0;

  Finally
    FreeAndNil(qryCalculaBase);
  End;

End;


Procedure TFreCon.pCalculaPisCofins(Var fltBasPis,
                                        fltBasCof,
                                        fltAlqPis,
                                        fltAlqCof,
                                        fltTotPis,
                                        fltTotCof: Double;
                                        strNotas: String);

Begin
  If (fCfgsis('ZPCCON', varBoolean)) And (blnSimPau Or fSimples(strCodTra)) Then
  Begin
    fltBasPis := 0;
    fltBasCof := 0;
    fltAlqPis := 0;
    fltAlqCof := 0;
    fltTotPis := 0;
    fltTotCof := 0;
  End Else
  Begin

    If blnUtiAbr {And (tpFrete = tpfEntrada)} Then
    Begin
      fltBasPis := fCalculaBasePisCofinsReduzidaPelaEntradas(FValDoc, FValIc1, strNotas) * FPerBasPis / 100;
      fltBasCof := fCalculaBasePisCofinsReduzidaPelaEntradas(FValDoc, FValIc1, strNotas) * FPerBasCof / 100;

      fltAlqPis := FAlqPis;
      fltAlqCof := FAlqCof;
    End Else
    Begin
      fltBasPis := fCalculaBasePisCofinsReduzidaPelaEntradas(FValDoc,FValIc1,strNotas);
      fltBasCof := fCalculaBasePisCofinsReduzidaPelaEntradas(FValDoc,FValIc1,strNotas);

      fltAlqPis := fltCfgAlqPis;
      fltAlqCof := fltCfgAlqCof;

      FCstPis := strCfgCstPis;
      FCstCof := strCfgCstCof;
    End;

    fltTotPis := fltBasPis * fltAlqPis / 100;
    fltTotCof := fltBasCof * fltAlqCof / 100;
  End;
End;

{**********************************************}
{* CONFIRMA GRAVAÇÃO DO FRETE DE CONHECIMENTO *}
{* não é executada pela Importação de conehecimento de frete *}
{*******************************************AF*}
function TFreCon.fConfirmaFreConhecimento(blnImprimeCP: Boolean; strPorBai, strNomForm, strEspDoc: String; AstrHistoricoEntrada: String = ''	): Boolean;
  Var
    intContador : Integer;
    strAutPag   : String;
    strHistorico: String;
    strSeqLan   : String;
    strHisBai   : String;
    strCtaBai   : String;
    strDocBai   : String;
    strOpeBai   : String;
    strClaFis   : String;
    dtaDtaPag   : TDateTime;
    fltValPag   : Double;
    intCtpCon   : Longint;
    blnGerouPagAnt: Boolean;

    fltTotPis,
    fltTotCof,
    fltBasPis,
    fltBasCof,
    fltAlqPis,
    fltAlqCof: Double;

    lstBanCtp : TBanCtpRepository;
    strNatOpe: String;
    strBasFre: String;
Begin

  Try
    SetLength(FSeqPag, 0);
    lstBanCtp := Nil;

    blnGerouPagAnt := False;
    strClaFis := '1101';
    Result := True;

    If qryTabela.IsEmpty Then
      Exit;

    pAtualizaDados;

    {**************************************}
    {* GRAVA LIVRO                        *}
    {***********************************AF*}
    If SameText(strEspDoc, 'NF') Then
    Begin
      strClaFis := FClaFi1;
      strNatOpe := fRetNatOpe(FClaFi1);

      If (Not fEmptyStr(strClaFisEnt)) Then
        strBasFre := fRetCodBaseFretePorCFOP(strClaFisEnt)
      Else
        If (Assigned(cdsNotEnt)) And (cdsNotEnt.RecordCount > 0) Then
          strBasFre := fRetCodBaseFretePorCFOP(fCampoTabela('FIS_CLFSC1', 'CADFIS',
                                                  ['FIS_FORCLI', 'FIS_NUMDOC', 'FIS_ESPDOC', 'FIS_SERIE_'],
                                                  [cdsNotEnt.FieldByName('CODFOR').AsString,cdsNotEnt.FieldByName('NUMDOC').AsString,
                                                  cdsNotEnt.FieldByName('ESPDOC').AsString,cdsNotEnt.FieldByName('SERIE_').AsString], False));

      pCalculaPisCofins(fltBasPis,
                        fltBasCof,
                        fltAlqPis,
                        fltAlqCof,
                        fltTotPis,
                        fltTotCof, '');

      Result := fGravaCadFis(FAutFis,
                             FDtaEnt,   // Data de Entrada
                             FNumDoc,   // Número do Documento
                             '',        // Número do Documento 2
                             FEspDoc,   // Espécie
                             'E',       // Entrada / Saida
                             FDtaDoc,   // Data do Documento
                             'F',       // Tipo (F)ornecedor / (C)liente
                             FCodTra,   // Código Fornecedor / Cliente
                             ReplaceStr(FHis001, STRING_QUEBRA, ' ' ), // Histórico
                             'N',       // Nfe-Complemento
                             '',        // ???

                             FClaFi1,   // Classificação Fiscal 1
                             FValCo1,   // Valor Contábil 1
                             FBasIc1,   // Base de ICMS 1
                             FAlqIc1,   // Aliquota de ICMS 1
                             FValIc1,   // Valor de ICMS 1
                             FValOu1,   // Valor de Outras 1
                             FValIs1,   // Valor de Isento 1
                             FValRe1,   // Valor de Retido 1
                             FBasIp1,   // Base de IPI 1
                             FValIp1,   // Valor de IPI 1
                             FBasSu1,   // Base de Substituição 1
                             FDesAc1,   // Valor de Despesa Acessária 1
                             FValIs1,   // Valor do ISS 1

                             FClaFi2,   // Classificação Fiscal 2
                             FValCo2,   // Valor Contábil 2
                             FBasIc2,   // Base de ICMS 2
                             FAlqIc2,   // Aliquota de ICMS 2
                             FValIc2,   // Valor de ICMS 2
                             FValOu2,   // Valor de Outras 2
                             FValIs2,   // Valor de Isento 2
                             FValRe2,   // Valor de Retido 2
                             FBasIp2,   // Base de IPI 2
                             FValIp2,   // Valor de IPI 2
                             FBasSu2,   // Base de Substituição 2
                             FDesAc2,   // Valor de Despesa Acessária 2
                             FValIs2,   // Valor do ISS 2

                             FClaFi3,   // Classificação Fiscal 3
                             FValCo3,   // Valor Contábil 3
                             FBasIc3,   // Base de ICMS 3
                             FAlqIc3,   // Aliquota de ICMS 3
                             FValIc3,   // Valor de ICMS 3
                             FValOu3,   // Valor de Outras 3
                             FValIs3,   // Valor de Isento 3
                             FValRe3,   // Valor de Retido 3
                             FBasIp3,   // Base de IPI 3
                             FValIp3,   // Valor de IPI 3
                             FBasSu3,   // Base de Substituição 3
                             FDesAc3,   // Valor de Despesa Acessária 3
                             FValIs3,   // Valor do ISS 3

                             FClaFi4,   // Classificação Fiscal 4
                             FValCo4,   // Valor Contábil 4
                             FBasIc4,   // Base de ICMS 4
                             FAlqIc4,   // Aliquota de ICMS 4
                             FValIc4,   // Valor de ICMS 4
                             FValOu4,   // Valor de Outras 4
                             FValIs4,   // Valor de Isento 4
                             FValRe4,   // Valor de Retido 4
                             FBasIp4,   // Base de IPI 4
                             FValIp4,   // Valor de IPI 4
                             FBasSu4,   // Base de Substituição 4
                             FDesAc4,   // Valor de Despesa Acessária 4
                             FValIs4,   // Valor do ISS 4

                             FClaFi5,   // Classificação Fiscal 5
                             FValCo5,   // Valor Contábil 5
                             FBasIc5,   // Base de ICMS 5
                             FAlqIc5,   // Aliquota de ICMS 5
                             FValIc5,   // Valor de ICMS 5
                             FValOu5,   // Valor de Outras 5
                             FValIs5,   // Valor de Isento 5
                             FValRe5,   // Valor de Retido 5
                             FBasIp5,   // Base de IPI 5
                             FValIp5,   // Valor de IPI 5
                             FBasSu5,   // Base de Substituição 5
                             FDesAc5,   // Valor de Despesa Acessária 5
                             FValIs5,   // Valor do ISS 5

                             fltTotPis, // TOT PIS
                             fltTotCof, // TOT COFINS
                             fltBasPis, // BASE PIS
                             fltBasCof, // BASE COFINS
                             fltAlqPis, // ALIQ PIS
                             fltAlqCof, // ALIQ COFINS

                             FCodEmp,   // Empresa
                             FSerie_,   // Série
                             FEstTra,   // Estado do Cliente / Fornecedor
                             '',        // Número de Série
                             '',        // Número COO
                             '',        // Conta Contábil
                             '',        // Documento do Conhecimento de Frete
                             strAcesso, // Chave de Acesso NF-e
                             '',        // Numero Protocolo NF-e
                             'F',       // Origem do documento
                             '',        // strEmpAut
                             0,         // fltImpMer
                             0,         // fltImpSeg
                             0,         // fltImpImp
                             0,         // fltImpPro
                             0,         // fltImpTax
                             0,         // fltImpPis
                             0,         // fltImpCof
                             '',        // strImpIC1
                             '',        // strImpIC2
                             FModFre,   // strModFre
                             0,         // fltBasIss
                             0,         // fltAlqIss
                             0,         // fltValIss
                             0,         // fltBaseII: Double = 0;
                             0,         // fltDesAdu: Double = 0;
                             0,         // fltValIOF: DOuble = 0;
                             FBasAn1,   // Base Antecipação 1
                             FAntIc1,   // Vr. Antecipação 1
                             FBasAn2,   // Base Antecipação 2
                             FAntIc2,   // Vr. Antecipação 2
                             FBasAn3,   // Base Antecipação 3
                             FAntIc3,   // Vr. Antecipação 3
                             FBasAn4,   // Base Antecipação 4
                             FAntIc4,   // Vr. Antecipação 4
                             FBasAn5,   // Base Antecipação 5
                             FAntIc5,   // Vr. Antecipação 5
                             '',        // strCstEnt
                             FblnGraCTP,// Gravou Financeiro);
                             0,         // fltBaeRe1: Double = 0;
                             0,         // fltVaeRe1: Double = 0;
                             0,         // fltBaeRe2: Double = 0;
                             0,         // fltVaeRe2: Double = 0;
                             0,         // fltBaeRe3: Double = 0;
                             0,         // fltVaeRe3: Double = 0;
                             0,         // fltBaeRe4: Double = 0;
                             0,         // fltVaeRe4: Double = 0;
                             0,         // fltBaeRe5: Double = 0;
                             0,         // fltVaeRe5: Double = 0;
                             0,         // fltBaeIP1: Double = 0;
                             0,         // fltVaeIP1: Double = 0;
                             0,         // fltBaeIP2: Double = 0;
                             0,         // fltVaeIP2: Double = 0;
                             0,         // fltBaeIP3: Double = 0;
                             0,         // fltVaeIP3: Double = 0;
                             0,         // fltBaeIP4: Double = 0;
                             0,         // fltVaeIP4: Double = 0;
                             0,         // fltBaeIP5: Double = 0;
                             0,         // fltVaeIP5: Double = 0;
                             FCstPis,
                             FCstCof,
                             FModelo,
                             IIf(FTransf = 'S', 'C', IIf(tpFrete = tpfSaida, 'V', 'C')), //SE FOR TRANSFERÊNCIA GRAVA COMO (C)OMPRA, POR CAUSA TABELA 'LANCON', REQ 284464
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             'N',
                             FPesoBruto,
                             '',
                             '',
                             strNatOpe,
                             '',
                             '',
                             strBasFre);

       //Result := Result And fGravaPessoas(FAutFis);
       Result := Result And fGravaPessoas(FAutFis) And fGravaDadosMunicipio(FAutFis);
       result := Result And fGravaXML(FAutFis, FstrPath + qryTabela.FieldByName('NOMARQ').AsString );
    End; {If NF Then}

    //Verifica se Gravara Financeiro
    If FblnGraCTP Then
    Begin

    {**************************************}
    {* GRAVA CADPAG                       *}
    {***********************************AF*}
      If Result Then
      Begin

        pMontaDuplicatasFrete(arrDuplicata);

        If fCfgSis('ENTCTP', varBoolean) And
           ((Pos(strClaFis, VS_strClaCom) > 0) Or (Not SameText(strEspDoc, 'NF'))) And
           fFornecedorGravaCtp(FCodTra)   Then
        Begin

          intContador := 0;

          intCtpCon := fRetCtpCon;

          FCtpConOutDes := intCtpCon;

          {*****************************************}
          {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
          {**************************************AF*}
          While (ArrDuplicata[intContador].dtaDtaVen <> '') And
                (intContador < 24)                          And
                (Result)                                    Do
          Begin

            If (fCfgSis('HISCTP', varBoolean)) Then
            Begin
              strHistorico := 'REF. AO DOCUMENTO No ' + fStrZero(FNumDoc, 12) + FEspDoc;
              FHis001:= FHis001 + ' ' + strHistorico +  ' ' + AstrHistoricoEntrada;
            End
            Else
              strHistorico := '';

            strHisBai := '';
            strCtaBai := '';
            strDocBai := '';
            strOpeBai := '';
            dtaDtaPag := 0;
            fltValPag := 0;
            strSeqLan := '';


            If (fCfgSis('CTPAVI', varBoolean)) And
               (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) Then
            Begin
              lstBanCtp := TBanCtpRepository.Create;
              lstBanCtp.fAdd(FNumDoc,
                             'A',
                             FSerie_,
                             VS_strCodEmp,
                             FCodTra, // Fornecedor
                             FHis001,
                             strHistorico,
                             FCodCta,
                             VS_strCodEmp,
                             0,
                             ArrDuplicata[intContador].curValor,
                             0,
                             0,
                             0,
                             0);

              strSeqLan := fGravaMovBan(FCodCta,                            // Centro de Custo
                                        strPorBai,                          // Portador da Baixa
                                        strCodOpe,                          // Operador da Baixa
                                        VS_Date,                            // Data do Lançamento
                                        fTime(),                            // Hora do Lançamento
                                        fStrZero(FNumDoc, 12),              // Numero do Documento
                                        'D',                                // Credito / Debito
                                        FCodEmp,                       // Empresa da Baixa
                                        ArrDuplicata[intContador].curValor, // Valor Do Lançamento
                                        FHis001,                            // Histórico 1
                                        '',                                 // Histórico 2
                                        '',                                 // Cliente da Duplicata
                                        FCodTra,                            // Fornecedor da Duplicata
                                        fStrZero(FNumDoc, 12),              // Número da Duplicata
                                        0,                                  // Sequencial de Baixa
                                        'A',                                // Parcela da Duplicata
                                        FCodEmp,                       // Empresa da Duplicata
                                        FSerie_,                            // Série
                                        FCodEve,                            // Código do Evento
                                        '',                                 // Documento da Baixa
                                        lstBanCtp.fGetList,                 // Log Bancário
                                        0,
                                        intCtpCon);

              Result := Not fEmptyStr(strSeqLan);

              FreeAndNil(lstBanCtp);

              If (fCfgSis('HISCTP', varBoolean)) Then
                strHisBai := 'REF. AO DOCUMENTO No ' + fStrZero(FNumDoc, 12) + FEspDoc
              Else
                strHisBai := '';

              strCtaBai := FCodCta;
              strDocBai := strSeqLan;
              strOpeBai := strLoginUsuarioLogado;
              dtaDtaPag := VS_Date;
              fltValPag := ArrDuplicata[intContador].curValor;

            End;

            strAutPag := fRetAutoIncrem('CADPAG', VS_strCodEmp);

            SetLength(FSeqPag, Succ(Length(FSeqPag)));
            FSeqPag[High(FSeqPag)] := strAutPag;

            If Pos(ArrDuplicata[intContador].strUsaChq, 'S_N_') <= 0 Then
              ArrDuplicata[intContador].strUsaChq := 'N';

            Result := Result And
                      fGravaCadPag(strNomForm,                                     // Nome Form LOGCTP
                                   'BAIXA - CONHECIMENTO DE FRETE',                // Descrição LOGCTP
                                   FCodTra,                                        // Fornecedor
                                   fStrZero(FNumDoc, 12),                          // Numero da Duplicata
                                   ArrDuplicata[intContador].strSequen,            // Parcela
                                   IIf(FEmptyStr(FEmpresaPagadora), FCodEmp, FEmpresaPagadora), // Empresa
                                   FCodCta,                                        // Centro de Custo
                                   FSerie_,                                        // Serie do Documento
                                   0,                                              // Sequencial de Baixa
                                   StrToDateDef(strDtaEnt, VS_Date),               // Data do lançamento
                                   StrToDate(ArrDuplicata[intContador].dtaDtaVen), // Data de Vencimento
                                   ArrDuplicata[intContador].curValor - fltValPag, // Valor da Duplicata
                                   ArrDuplicata[intContador].curValor,             // Valor Original
                                   IIF(fEmptyStr(FPrevis),'N',FPrevis),            // Previsão?
                                   IIf(blnVeioBoleto, 'S', 'N'),                   // Veio Boleto
                                   IIF(fEmptyStr(FDeposi),'N',FDeposi),            // Deposito
                                   FHis001,                                        // Histórico 1
                                   '',                                             // Histórico 2
                                   strHisBai,                                      // Histórico da Baixa
                                   strPorBai,                                      // Portador da Baixa
                                   strCtaBai,                                      // Centro de Custo da Baixa
                                   strDocBai,                                      // Documento da Baixa
                                   strOpeBai,                                      // Operador da Baixa
                                   dtaDtaPag,                                      // Data do Pagamento
                                   fltValPag,                                      // Valor Pago
                                   0,                                              // Valor de Juros
                                   0,                                              // Valor Desconto
                                   FCodEmp,                                        // Empresa
                                   FCodEve,                                        // Código do Evento
                                   IIF(fEmptyStr(ArrDuplicata[intContador].strUsaChq),FUsaChq,ArrDuplicata[intContador].strUsaChq),// Usa Cheque
                                   strPorBai,                                      // Codigo do Portador
                                   fStrZero(FNumDoc, 12),                          // Numero do Documento
                                   0.0,                                            // fltJurSuj
                                   0.0,                                            // fltDesSuj
                                   intCtpCon,                                      // intSeqCon
                                   False,                                          // blnResCai
                                   0,                                              // intRcxCon
                                   FTipDoc,                                        // strTipDoc
                                   0,                                              // fltVendor
                                   IIF(fEmptyStr(FVeioNF),'',FVeioNF),             // strVeioNF
                                   '',                                             // strNotEnt
                                   '',                                             // strNotTip
                                   '',                                             // strCTPCom
                                   strAutPag,                                      // strAutInc
                                   '',                                             // strDocTer
                                   '',                                             // strEspTer
                                   '',                                             // strEmpTer
                                   '',                                             // strCliTer
                                   IIF(fEmptyStr(FUsoCon),'N',FUsoCon),            // strUsoCon
                                   FCompet,                                        // strCompet
                                   '',                                             // strCodCliUC
                                   '',                                             // strNumDocUC
                                   '',                                             // strEspDocUC
                                   '',                                             // strCodEmpUC
                                   fltValPag,                                      // fltDinhei
                                   0,                                              // fltChqAvi: Double = 0;
                                   0,                                              // fltOrdPag: Double = 0;
                                   0,                                              // fltRepChq: Double = 0;
                                   '',                                             // strCodVen: String = '';
                                   0,                                              // fltJurAnt: Double = 0;
                                   0,                                              // fltDesAnt: Double = 0;
                                   IIF(blnVeioBoleto And (blnCtpBol), arrLinDigCodbar[intContador].strLinDig, ''),  // strLinDig: String = '';
                                   IIF(blnVeioBoleto And (blnCtpBol), arrLinDigCodbar[intContador].strCodBar, ''),  // strCodBar: String = '';
                                   '',
                                   '',
                                   '',
                                   FGuiTri,
                                   FTipTri,
                                   FBcoFor,
                                   '',
                                   '',
                                   IIF(fEmptyStr(FPagAnt),'N',FPagAnt));


            If (Not blnGerouPagAnt) And (fStrToFloat(strAntIcT) > 0) Then
            Begin

               // CONTAS A PAGAR DO ICMS ANTECIPADO
               Result := Result And
                          fGravaCadPag(strNomForm + 'untEntFreCon - fConfirmaFreConhecimento ',
                                       'INCLUSAO ICMS ANTECIPADO',
                                       fCfgSis('ANTFOR'),                                             // Fornecedor
                                       fRetSequencialCadPag,                                          // Numero da Duplicata
                                       'A',                                                           // Parcela
                                       IIf(FEmptyStr(FEmpresaPagadora), FCodEmp, FEmpresaPagadora),   // Empresa
                                       fCfgSis('ANTCTA'),                                             // Centro de Custo
                                       '',                                                            // Serie do Documento
                                       0,                                                             // Sequencial de Baixa
                                       StrToDateDef(strDtaEnt, VS_Date),                              // Data do lançamento
                                       fProximoVencimentoIcmAnt(fCfgSis('ANTVEN', varInteger), VS_Date),  // Data de Vencimento
                                       fStrToFloat(strAntIcT),                                        // Valor da Duplicata
                                       fStrToFloat(strAntIcT),                                        // Valor Original
                                       'N',                                                           // Previsão?
                                       IIf(blnVeioBoleto, 'S', 'N'),                                  // Veio Boleto
                                       'N',                                                           // Deposito
                                       FHis001,                                                       // Histórico 1
                                       'REF. AO ICMS ANTECIPADO DO DOCUMENTO No ' + fStrZero(FNumDoc, 12) + FEspDoc,// Histórico 2
                                       '',                                                            // Histórico da Baixa
                                       strPorBai,                                                     // Portador da Baixa
                                       '',                                                            // Centro de Custo da Baixa
                                       '',                                                            // Documento da Baixa
                                       '',                                                            // Operador da Baixa
                                       0,                                                             // Data do Pagamento
                                       0,                                                             // Valor Pago
                                       0,                                                             // Valor de Juros
                                       0,                                                             // Valor Desconto
                                       FCodEmp,                                                       // Empresa
                                       FCodEve,                                                       // Código do Evento
                                       'N',                                                           // Usa Cheque
                                       strPorBai,                                                     // Codigo do Portador
                                       '',                                                            // Nro do Documento da Baixa
                                       0.0,                                                           // fltJurSuj
                                       0.0,                                                           // fltDesSuj
                                       intCtpCon,                                                     // intSeqCon
                                       False,                                                         // blnResCai
                                       0,                                                             // intRcxCon
                                       '1',                                                           // strTipDoc
                                       0,                                                             // fltVendor
                                       '',                                                            // strVeioNF
                                       FNumDoc + FEspDoc + FCodEmp + fstrEspaco(FSerie_, 3) + FCodTra,// Nota de Entrada
                                       CTP_ICMS_ANTECIPADO,                                           // strNotTip
                                       '',                                                            // strCTPCom
                                       '',                                                            // strAutInc
                                       '',                                                            // strDocTer
                                       '',                                                            // strEspTer
                                       '',                                                            // strEmpTer
                                       '',                                                            // strCliTer
                                       'N',                                                           // strUsoCon
                                       FComPet,                                                       // competencia
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '0',
                                       '',
                                       '',
                                       '',
                                       '',
                                       'N');

               blnGerouPagAnt := True;
            End;

            If (blnImprimeCP) Then
            Begin
              pAdicionaImpressaoCP(fStrZero(FNumDoc, 12),
                                   ArrDuplicata[intContador].strSequen,
                                   FCodTra,
                                   FSerie_,
                                   strNomForm);
            End;

            strPorBai := '';
            Inc(intContador);
          End;

        End;

      End;
    End;

  Except
    On E: Exception Do
    Begin
   			pMensagensErro(E.Message,'[TFreCon.fConfirmaFreConhecimento]');
      Result := False;
    End;
  End;

End;

function TFreCon.fGravaCadFisSaida(strCodCli, strEmpFil, strClaFisXML: String): Boolean;
  Var
    strAutIncCadFisSaida,
    strEstCli: String;

    fltBasPis,
    fltBasCof,
    fltAlqPis,
    fltAlqCof,
    fltTotPis,
    fltTotCof: Double;
    strNatOpe: String;
Begin
  strAutIncCadFisSaida := fVerificaTemCadFisSaida(strCodCli, strEmpFil, 'S', 'C');

  if fEmptyStr(strAutIncCadFisSaida) then
  begin
  strEstCli := fRetEstadoCliente(strCodCli);
  strNatOpe := fRetNatOpe(FClaFi1);
  pCalculaPisCofins(fltBasPis,
                    fltBasCof,
                    fltAlqPis,
                    fltAlqCof,
                    fltTotPis,
                    fltTotCof,
                    '');

  Result := fGravaCadFis(strAutIncCadFisSaida,
                         FDtaEnt, // Data de Entrada
                         FNumDoc, // Número do Documento
                         '',      // Número do Documento 2
                         FEspDoc, // Espécie
                         'S',     // Entrada / Saida
                         FDtaDoc, // Data do Documento
                         'C',     // Tipo (F)ornecedor / (C)liente
                         strCodCli, // Código Fornecedor / Cliente
                         '',      // Histórico
                         'N',      // NFe-Complemento
                         '',      // ???

                         strClaFisXML, // Classificação Fiscal 1
                         FValCo1, // Valor Contábil 1
                         FBasIc1, // Base de ICMS 1
                         FAlqIc1, // Aliquota de ICMS 1
                         FValIc1, // Valor de ICMS 1
                         FValOu1, // Valor de Outras 1
                         FValIs1, // Valor de Isento 1
                         FValRe1, // Valor de Retido 1
                         FBasIp1, // Base de IPI 1
                         FValIp1, // Valor de IPI 1
                         FBasSu1, // Base de Substituição 1
                         FDesAc1, // Valor de Despesa Acessária 1
                         FValIs1, // Valor do ISS 1

                         FClaFi2, // Classificação Fiscal 2
                         FValCo2, // Valor Contábil 2
                         FBasIc2, // Base de ICMS 2
                         FAlqIc2, // Aliquota de ICMS 2
                         FValIc2, // Valor de ICMS 2
                         FValOu2, // Valor de Outras 2
                         FValIs2, // Valor de Isento 2
                         FValRe2, // Valor de Retido 2
                         FBasIp2, // Base de IPI 2
                         FValIp2, // Valor de IPI 2
                         FBasSu2, // Base de Substituição 2
                         FDesAc2, // Valor de Despesa Acessária 2
                         FValIs2, // Valor do ISS 2

                         FClaFi3, // Classificação Fiscal 3
                         FValCo3, // Valor Contábil 3
                         FBasIc3, // Base de ICMS 3
                         FAlqIc3, // Aliquota de ICMS 3
                         FValIc3, // Valor de ICMS 3
                         FValOu3, // Valor de Outras 3
                         FValIs3, // Valor de Isento 3
                         FValRe3, // Valor de Retido 3
                         FBasIp3, // Base de IPI 3
                         FValIp3, // Valor de IPI 3
                         FBasSu3, // Base de Substituição 3
                         FDesAc3, // Valor de Despesa Acessária 3
                         FValIs3, // Valor do ISS 3

                         FClaFi4, // Classificação Fiscal 4
                         FValCo4, // Valor Contábil 4
                         FBasIc4, // Base de ICMS 4
                         FAlqIc4, // Aliquota de ICMS 4
                         FValIc4, // Valor de ICMS 4
                         FValOu4, // Valor de Outras 4
                         FValIs4, // Valor de Isento 4
                         FValRe4, // Valor de Retido 4
                         FBasIp4, // Base de IPI 4
                         FValIp4, // Valor de IPI 4
                         FBasSu4, // Base de Substituição 4
                         FDesAc4, // Valor de Despesa Acessária 4
                         FValIs4, // Valor do ISS 4

                         FClaFi5, // Classificação Fiscal 5
                         FValCo5, // Valor Contábil 5
                         FBasIc5, // Base de ICMS 5
                         FAlqIc5, // Aliquota de ICMS 5
                         FValIc5, // Valor de ICMS 5
                         FValOu5, // Valor de Outras 5
                         FValIs5, // Valor de Isento 5
                         FValRe5, // Valor de Retido 5
                         FBasIp5, // Base de IPI 5
                         FValIp5, // Valor de IPI 5
                         FBasSu5, // Base de Substituição 5
                         FDesAc5, // Valor de Despesa Acessária 5
                         FValIs5, // Valor do ISS 5

                         fltTotPis, // TOT PIS
                         fltTotCof, // TOT COFINS
                         fltBasPis, // BASE PIS
                         fltBasCof, // BASE COFINS
                         fltAlqPis, // ALIQ PIS
                         fltAlqCof, // ALIQ COFINS

                         strEmpFil, // Empresa
                         FSerie_,      // Série
                         strEstCli,   // Estado do Cliente / Fornecedor
                         '',        // Número de Série
                         '',        // Número COO
                         '',        // Conta Contábil
                         '',        // Documento do Conhecimento de Frete
                         strAcesso, // Chave de Acessod NF-e
                         '',        // Numero Protocolo NF-e
                         'F',       // Origem do documento

                         '',           //strEmpAut
                         0,            //   fltImpMer
                         0,            //   fltImpSeg
                         0,            //   fltImpImp
                         0,            //   fltImpPro
                         0,            //   fltImpTax
                         0,            //   fltImpPis
                         0,            //   fltImpCof
                         '',           //  strImpIC1
                         '',           //  strImpIC2
                         FModFre,      //  strModFre
                         0,            //   fltBasIss
                         0,            //   fltAlqIss
                         0,            //   fltValIss
                         0,            // fltBaseII: Double = 0;
                         0,            // fltDesAdu: Double = 0;
                         0,            // fltValIOF: DOuble = 0;
                         FBasAn1,      // Base Antecipação 1
                         FAntIc1,      // Vr. Antecipação 1
                         FBasAn2,      // Base Antecipação 2
                         FAntIc2,      // Vr. Antecipação 2
                         FBasAn3,      // Base Antecipação 3
                         FAntIc3,      // Vr. Antecipação 3
                         FBasAn4,      // Base Antecipação 4
                         FAntIc4,      // Vr. Antecipação 4
                         FBasAn5,      // Base Antecipação 5
                         FAntIc5,      // Vr. Antecipação 5
                         '',            // strCstEnt
                         FblnGraCTP,  // Gravou Financeiro);
                         0, // fltBaeRe1: Double = 0;
                         0, // fltVaeRe1: Double = 0;
                         0, // fltBaeRe2: Double = 0;
                         0, // fltVaeRe2: Double = 0;
                         0, // fltBaeRe3: Double = 0;
                         0, // fltVaeRe3: Double = 0;
                         0, // fltBaeRe4: Double = 0;
                         0, // fltVaeRe4: Double = 0;
                         0, // fltBaeRe5: Double = 0;
                         0, // fltVaeRe5: Double = 0;
                         0, // fltBaeIP1: Double = 0;
                         0, // fltVaeIP1: Double = 0;
                         0, // fltBaeIP2: Double = 0;
                         0, // fltVaeIP2: Double = 0;
                         0, // fltBaeIP3: Double = 0;
                         0, // fltVaeIP3: Double = 0;
                         0, // fltBaeIP4: Double = 0;
                         0, // fltVaeIP4: Double = 0;
                         0, // fltBaeIP5: Double = 0;
                         0, // fltVaeIP5: Double = 0;
                         FCstPis,
                         FCstCof,
                         FModelo,
                         'V',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         0,
                         '',
                         0,
                         0,
                         0,
                         '',
                         'N',                         
                         FPesoBruto,
                         '',
                         '',
                         strNatOpe);
  end
  else
    Result := True;

  Result := Result And fGravaRelacionamentoCTEcomDocumento(strAcesso, strAutIncCadFisSaida);
End;

function TFreCon.fGravaCadRecSaida(strCodCli, strEmpFil: String): Boolean;
  Var
    dtaDtaPag: TDateTime;
    fltValPag: Double;

    strCtaBai,
    strDocBai,
    strOpeBai,
    strSeqLan,
    strCodPor,
    strEmpBai,
    strHisto: String;
    intContador: Integer;
    lstBanCtp : TBanCtpRepository;
Begin
  Result := True;
  If Not FblnGraCTP Then
    Exit;

  If FBrinde = '1' Then
    Exit;

  If fEmptyStr(strCodOpe) Then
    strCodOpe := strLoginUsuarioLogado;

  strHisto  := 'REF. LANCAMENTO DE CONHECIMENTOS DE FRETE ' + FNumDoc + '-' + FEspDoc + ' ';
  cdsNotasFiscais.Filtered := False;
  cdsNotasFiscais.First;
  If cdsNotasFiscais.Locate('CTE_ACESSO', FAcesso, []) Then
  Begin
    If cdsNotasFiscais.FieldByName('FIS_NUMDOC').AsString <> ''Then
    Begin
      strHisto := strHisto + ' DTA. EMISSÃO: ' + DateToStr(FDtaDoc) +
                             ' CLIENTE/FORNECEDOR: ' + cdsNotasFiscais.FieldByName('NFE_DESTINATARIO').AsString + ' - ' +
                             ' DOCUMENTO: ' + cdsNotasFiscais.FieldByName('FIS_NUMDOC').AsString +  ' - ' +
                                             cdsNotasFiscais.FieldByName('FIS_ESPDOC').AsString +  ' - ' +
                                             cdsNotasFiscais.FieldByName('FIS_CODEMP').AsString;
    End;
  End;
  intContador := 0;

  While (ArrDuplicata[intContador].dtaDtaVen <> '') And
        (intContador < 24)                          And
        (Result)                                    Do
  Begin

    strCtaBai := '';
    strDocBai := '';
    strOpeBai := '';
    dtaDtaPag := 0;
    fltValPag := 0;
    strSeqLan := '';
    strCodPor := FPorBai;
    strEmpBai := '';

    If (fCfgSis('BAIAVI', varBoolean))                            And
       (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) Then
    Begin
      lstBanCtp := TBanCtpRepository.Create;
      lstBanCtp.fAdd(FNumDoc,
                     arrDuplicata[intContador].strSequen,
                     FSerie_,
                     strEmpFil,
                     '',
                     strHisto,
                     '',
                     FCtaRec,
                     strEmpFil,
                     0,
                     ArrDuplicata[intContador].curValor,
                     0,
                     0,
                     0,
                     0);

      strSeqLan := fGravaMovBan(FCtaRec,                                                      // Centro de Custo
                                FPorBai,                                                      // Portador da Baixa
                                strCodOpe,                                                    // Operador da Baixa
                                FDtaEnt,                                                      // Data do Lançamento
                                fTime(),                                                      // Hora do Lançamento
                                fStrZero(FNumDoc, 12),                                        // Numero do Documento
                                'D',                                                          // Credito / Debito
                                strEmpFil,                                                    // Empresa da Baixa
                                ArrDuplicata[intContador].curValor,                           // Valor Do Lançamento
                                strHisto,                                                     // Histórico 1
                                '',                                                           // Histórico 2
                                strCodCli,                                                    // Cliente da Duplicata
                                '',                                                           // Fornecedor da Duplicata
                                fStrZero(FNumDoc, 12),                                        // Número da Duplicata
                                0,                                                            // Sequencial de Baixa
                                'A',                                                          // Parcela da Duplicata
                                strEmpFil,                                                    // Empresa da Duplicata
                                FSerie_,                                                      // Série
                                FCodEve,                                                      // Código do Evento
                                '',                                                           // Documento da Baixa
                                lstBanCtp.fGetList                                            // Log Bancário
                               );

      FreeAndNil(lstBanCtp);

      Result := Not fEmptyStr(strSeqLan);

      strCtaBai := strCtaRec;
      strDocBai := strSeqLan;
      strOpeBai := strCodOpe;
      dtaDtaPag := VS_Date;
      fltValPag := ArrDuplicata[intContador].curValor;
      strEmpBai := VS_strCodEmp;
    End;

    if (not fVerificaTemCadRecSaida(arrDuplicata[intContador].strSequen, strCodCli, strEmpFil)) then
    begin
    Result := Result And
              fGravaCadRec('untEntFreCon',
                           'INCLUSÃO',
                           FNumDoc,                                       // Duplicata
                           arrDuplicata[intContador].strSequen,           // Parcela
                           0,                                              // Seq. Baixa
                           FEspDoc,                                        // Especie
                           strCodCli,                                      // Cliente
                           strEmpFil,                                      // Empresa
                           strCodOpe,                                      // Vendedor
                           strCodOpe,                                      // Digitador
                           FPorBai,                                        // Portador
                           FDtaEnt,                                        // Data de cadastro
                           StrToDate(arrDuplicata[intContador].dtaDtaVen), // Data de Vencimento
                           IIf(dtaDtaPag > 0 , 0 , ArrDuplicata[intContador].curValor),             // Valor da Duplicata
                           ArrDuplicata[intContador].curValor,             // Valor Original
                           0.0,                                            // Despesa de Cobrança
                           '',                                             // Desconto
                           strHisto,                                       // Histórico 1
                           '',                                             // Histórico 2
                           strPorBai,
                           strCtaBai,
                           strOpeBai,
                           strDocBai,
                           fltValPag,
                           dtaDtaPag,
                           'N',
                           FCodEve,                                        // Código do Evento
                           '',                                             // Código Velho (CONVERSÃO)
                           '',                                             // Tipo de Fora (Condição de Pagamento)
                           '',                                             // Código da Condição de Pagamento
                           False,
                           strCtaRec,                                      // Codigo do Centro de Custo
                           IfThen(dtaDtaPag = 0, 0, StrToInt(fRetRcxCon(strEmpBai))),   // intSeqCon
                           ArrDuplicata[intContador].curValor,
                           '',                                             // Observação de Agrupamento 1
                           '',                                             // Observação de Agrupamento 2
                           '',                                             // Observação de Agrupamento 3
                           '',
                           0,
                           0,
                           0,
                           0,
                           strEmpBai,
                           '',                                        // Empresa de Origem
                           FNumDoc,
                           FEspDoc,
                           strEmpFil,
                           strCodCli,
                           0,
                           0,
                           '',
                           0,
                           0,
                           'N',
                           0,
                           0,                                            
                           0,
                           0,
                           IfThen(dtaDtaPag = 0, 0, ArrDuplicata[intContador].curValor)); // fltValDin
    end;

    Inc(intContador);
  End; {While}

End;

{**********************************************
  <JOÃO MARIN 08/08/2017 MARTFER Req: 83951>
  NA GRAVAÇÃO DO LIVRO FISCAL DO 'CTE', A BASE DE CALCULO DO ICMS, DEVE SER CALCULADA DA SEGUINTE FORMA:
    - LOCALIZANDO A 'NOTA FISCAL DE VENDA', IDENTIFICAR OS PRODUTOS COM TRIBUTAÇÃO DE ICMS
     (COM CST = 'x00', 'x10', 'x20', 'x70')                     1
    - SOMAR O 'VALOR TOTAL DOS PRODUTOS' DESSAS CSTs E DIVIDIR PELO 'VALOR TOTAL DOS PRODUTOS DA NOTA'
      PARA ENCONTRAR O PERCENTUAL DE REPRESENTATIVIDADE DOS MESMOS DENTRO DESSA NOTA.
      A NOVA BASE DE CALCULO DO CT SERÁ = BASE DE CALCULO ATUAL * PERCENTUAL DE REPRESENTATIVIDADE CALCULADO ACIMA
    - APLICAR A ALIQUOTA DE ICMS DO CT SOBRE ESSA NOVA BASE DE CALCULO, PARA CHEGAR AO VALOR DO ICMS
    - NO 'HISTORICO' DO LIVRO, IDENTIFICAR O NUMERO DO DOCUMENTO DE VENDA A QUE SE REFERE O CTE. }
{*******************************************WG*}
procedure TFreCon.pRecalculaBasIcm(strChaveCte: string; var strRelacNotas: string; var strNotasIn: string);
  var strSeqGer: string;


begin

  If Not fTodas_Notas_CTE_Vinculadas_Com_Documento(strChaveCTe) Then
    Exit;

  If Not fFiltra_CTE(strChaveCte) Then
    Exit;

  cdsNotasFiscais.First;
  strRelacNotas :=  '';
  While Not cdsNotasFiscais.Eof Do
  Begin
    // Se não encontra a chave na lista então adiciona na string da consulta da Movdet
    If Not (Pos(cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString, strSeqGer) > 0) Then
    Begin
      strSeqGer := strSeqGer + fQuotedStr(cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString) + ', ';
      strRelacNotas := strRelacNotas + cdsNotasFiscais.FieldByName('FIS_NUMDOC').Value + '-' +
                                       cdsNotasFiscais.FieldByName('FIS_ESPDOC').Value + '-' +
                                       cdsNotasFiscais.FieldByName('FIS_CODEMP').Value + ';';
    End;
    cdsNotasFiscais.Next;
  End;
  // Remove o ultimo ', '
  strSeqGer := Copy(strSeqGer, 0, length(strSeqGer) -2);
  strNotasIn := strSeqGer;
  FConsulta.Sql.Clear;
  FConsulta.Sql.Add('SELECT SUM(IF(LOCATE(RIGHT(DET_CODFIS, 2), "00_10_20_70"), DET_VLRCON, 0)) / SUM(DET_VLRCON) REPRES ');
  FConsulta.Sql.Add('  FROM MOVDET DET ');
  FConsulta.Sql.Add(' WHERE DET_SEQGER IN (' + strSeqGer + ') ');


  FConsulta.Open;

  FBasIc1 := FBasIc1 * FConsulta.FieldByName('REPRES').AsFloat;
  FValIc1 := (FBasIc1 * FAlqIc1) / 100;
  FValOu1 := fRetornaValorOutras(FValCo1, FBasIc1, 0, FValRe1, 0, 0, 0);
end;

{**********************************************}
{* CONFIRMA GRAVAÇÃO DO FRETE DE CONHECIMENTO *}
{*******************************************AF*}
function TFreCon.fConfirmaImportacao(strNomArq: String; var strErroInt: String; blnRegistroCorrente: Boolean = False): Boolean;
  Var
    intContador : Integer;
    strClaFisXML,
    strCodCliTomador,
    strHistorico: String;
    strSeqLan   : String;
    strNotasRel : String;
    strNotas    : String;
    strHisBai   : String;
    strCtaBai   : String;
    strDocBai   : String;
    strOpeBai   : String;
    strClaFis   : String;
    strNotasRecalculo: String;
    dtaDtaPag   : TDateTime;
    fltValPag   : Double;
    intCtpCon   : Longint;
    strAutIncCadFis: String;
    strAutPag   : String;
    lstBanCtp : TBanCtpRepository;
    lstMemLog, lstMemErr: TStringList;

    strEmpresaTomador,
    strEmpresaTransportadora,
    strFisCodEmp: String;
    blnEmitenteFornecedorFilial,
    blnGravaCadFis: Boolean;

    fltBasPis,
    fltBasCof,
    fltAlqPis,
    fltAlqCof,
    fltTotPis,
    fltTotCof: Double;
    objFreConLista : TFreConLista;
    dataBase: TDateTime;
    strNatOpe: String;
    strBasFre: String;
Begin
  blnEmitenteFornecedorFilial := False;
  strEmpresaTransportadora := '';
  If not Assigned(FMemLog) Then
  Begin
    lstMemLog := TStringList.Create;
    FMemLog := lstMemLog;
  End;
  If Not  Assigned(FMemErr) Then
  Begin
    lstMemErr := TStringList.Create;
    FMemErr := lstMemErr
  End;
  Try
    Try
      SetLength(FSeqPag, 0);

      strClaFis := '1101';
      Result := True;

      If (qryTabela.IsEmpty) Then
        Exit;

      fStartTransaction;

      With qryTabela Do
      Begin

        If Not blnRegistroCorrente Then
          First;

        While (Not Eof) And Result Do
        Begin

          pAtualizaDados; // PEGA O CLAFIS DO XML

          strClaFisXML := FClaFiXML;

          If Pos(LeftStr(FClaFi1, 1), '1_2_') = 0 Then
          Begin
            If Not fTemCfopCorrelataParaFrete(FClaFi1) Then
            Begin
              If LeftStr(FClaFi1, 1) = '5' Then
                FClaFi1 := '1' + RightStr(FClaFi1, 3)
              Else If LeftStr(FClaFi1, 1) = '6' Then
                FClaFi1 := '2' + RightStr(FClaFi1, 3)
              Else If fRetEstadoFornecedor(FCodTra) = fCadEmp('ESTADO') Then
                FClaFi1 := '1' + RightStr(FClaFi1, 3)
              Else
                FClaFi1 := '2' + RightStr(FClaFi1, 3);
            End;
          End;

          If FUFInicio <> FUFFim Then
          Begin
            If LeftStr(FClaFi1, 1) = '5' Then
              FClaFi1 := '6' + RightStr(FClaFi1, 3)

            Else If LeftStr(FClaFi1, 1) = '1' Then
              FClaFi1 := '2' + RightStr(FClaFi1, 3)
          End
          Else
          Begin
            If LeftStr(FClaFi1, 1) = '6' Then
              FClaFi1 := '5' + RightStr(FClaFi1, 3)

            Else If LeftStr(FClaFi1, 1) = '2' Then
              FClaFi1 := '1' + RightStr(FClaFi1, 3)
          End;
          strClaFis := FClaFi1;

          If blnUtiAbr {And (tpFrete = tpfEntrada)} Then
          Begin

          End Else
          Begin
            FCstPis := fCfgSis('CSTPIS');
            FCstCof := fCfgSis('CSTCOF');
          End;

          If (tpFrete = tpfSaida) Then
          Begin
            blnGravaCadFis   := False;
            strFisCodEmp     := '';
            strCodCliTomador := '';

           {  1.1) SE TOMADOR = CLIENTE FILIAL
                 --> Grava CADFIS, onde:
                 o FIS_CODEMP = empresa do tomador.
                 o FIS_FORCLI = emp_forfil da empresa do emitente.
                 o FIS_TIP_FC = F.
                 o FIS_ENTSAI = E.
                 o CFOP de entrada.
                 o FIS_DTAENT = data de entrada informada na tela de importação.
                 o FIS_DTADOC = data de emissao do xml. }

            blnEmitenteFornecedorFilial := fFornecedorFilial(fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [FCGCTra]));
            IF Not blnEmitenteFornecedorFilial  Then
              blnGravaCadFis := True;

            // Tomador do serviço = 0-Remetente, 1-Expedidor, 2-Recebedor, 3-Destinatário ou 4-Outros.
            If (FTomSer = '0' {Remetente}) Then
            Begin
              strCodCliTomador := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [FCGCRem]);

              If (Not fEmptyStr(strCodCliTomador)) And fClienteFilial(strCodCliTomador, strEmpresaTomador) Then
              Begin
                blnGravaCadFis := True;
                strFisCodEmp   := strEmpresaTomador;
              End;

            End

            Else If (FTomSer = '3' {Destinatário}) Then
            Begin
              strCodCliTomador := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [FCGCDes]);

              If (Not fEmptyStr(strCodCliTomador)) And fClienteFilial(strCodCliTomador, strEmpresaTomador) Then
              Begin
                blnGravaCadFis := True;
                strFisCodEmp   := strEmpresaTomador;
              End;
            End
            Else If (FTomSer = '4' {Outros}) Then
            Begin
              strCodCliTomador := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_C_G_C_'], [FTomador.strCNPJ]);

              If (Not fEmptyStr(strCodCliTomador)) And fClienteFilial(strCodCliTomador, strEmpresaTomador) Then
              Begin
                blnGravaCadFis := True;
                strFisCodEmp   := strEmpresaTomador;
              End;
            End;

          End
          Else
          Begin // Conhecimentos de entrada
            blnGravaCadFis := True;
            strFisCodEmp   := FCodEmp;
          End;

          If blnGravaCadFis And
             fCadFisExiste(FNumDoc,
                           FEspDoc,
                           IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                           FCodTra,
                           FSerie_,
                           'F',
                           'E') Then
            blnGravaCadFis := False;

          Result := True;
          strErroInt := '';
          If blnUtilizaContabilidade And (Not fTodas_Notas_CTE_Vinculadas_Com_Documento(strAcesso)) Then
          Begin
            strErroInt := 'Quando utilizar a configuração "CFG_UTICON", o conhecimento devem estar atrelados aos documentos.';
            Result := False;
          End;



          If Result And blnGravaCadFis Then
          Begin
            strNotasRel := '';
            strNatOpe := fRetNatOpe(FClaFi1);
            If fCfgSis('CRBTRI', varBoolean) Then
              pRecalculaBasIcm(strAcesso, strNotasRel, strNotas)
            Else If (tpFrete = tpfEntrada) Then
              strNotas := fFiltraNotasCTE(strAcesso);

            strNotasRecalculo := strNotas;
            If fEmptyStr(strNotasRecalculo) And (fCfgSis('CPCICF') = '2') Then
              strNotasRecalculo := fFiltraNotasCTE(strAcesso);

            pCalculaPisCofins(fltBasPis,
                              fltBasCof,
                              fltAlqPis,
                              fltAlqCof,
                              fltTotPis,
                              fltTotCof,
                              strNotasRecalculo);

            strBasFre := fRetCodBaseFretePorCFOP(fRetornaClaFisNFe);

            Result := fGravaCadFis(strAutIncCadFis,
                                   FDtaEnt, // Data de Entrada
                                   FNumDoc, // Número do Documento
                                   '',      // Número do Documento 2
                                   FEspDoc, // Espécie
                                   'E',     // Entrada / Saida
                                   FDtaDoc, // Data do Documento
                                   'F',     // Tipo (F)ornecedor / (C)liente
                                   FCodTra, // Código Fornecedor / Cliente
                                   IIf(FComplemento = '1', 'CT-e de Complemento de Valores ', '') + strNotasRel,      // Histórico
                                   IIf(FComplemento = '1','S', 'N'),     // Nfe-Complemento
                                   '',      // ???

                                   FClaFi1, // Classificação Fiscal 1
                                   FValCo1, // Valor Contábil 1
                                   IIf((Not FCreditaICMS), 0, FBasIc1), // Base de ICMS 1
                                   IIf((Not FCreditaICMS), 0, FAlqIc1), // Aliquota de ICMS 1
                                   IIf((Not FCreditaICMS), 0, FValIc1), // Valor de ICMS 1
                                   IIf((Not FCreditaICMS), IIf(FComplemento = '1', FValIc1,  FValCo1), FValOu1), // Valor de Outras 1
                                   FValIs1, // Valor de Isento 1
                                   FValRe1, // Valor de Retido 1
                                   FBasIp1, // Base de IPI 1
                                   FValIp1, // Valor de IPI 1
                                   FBasSu1, // Base de Substituição 1
                                   FDesAc1, // Valor de Despesa Acessária 1
                                   FValIs1, // Valor do ISS 1

                                   FClaFi2, // Classificação Fiscal 2
                                   FValCo2, // Valor Contábil 2
                                   FBasIc2, // Base de ICMS 2
                                   FAlqIc2, // Aliquota de ICMS 2
                                   FValIc2, // Valor de ICMS 2
                                   FValOu2, // Valor de Outras 2
                                   FValIs2, // Valor de Isento 2
                                   FValRe2, // Valor de Retido 2
                                   FBasIp2, // Base de IPI 2
                                   FValIp2, // Valor de IPI 2
                                   FBasSu2, // Base de Substituição 2
                                   FDesAc2, // Valor de Despesa Acessária 2
                                   FValIs2, // Valor do ISS 2

                                   FClaFi3, // Classificação Fiscal 3
                                   FValCo3, // Valor Contábil 3
                                   FBasIc3, // Base de ICMS 3
                                   FAlqIc3, // Aliquota de ICMS 3
                                   FValIc3, // Valor de ICMS 3
                                   FValOu3, // Valor de Outras 3
                                   FValIs3, // Valor de Isento 3
                                   FValRe3, // Valor de Retido 3
                                   FBasIp3, // Base de IPI 3
                                   FValIp3, // Valor de IPI 3
                                   FBasSu3, // Base de Substituição 3
                                   FDesAc3, // Valor de Despesa Acessária 3
                                   FValIs3, // Valor do ISS 3

                                   FClaFi4, // Classificação Fiscal 4
                                   FValCo4, // Valor Contábil 4
                                   FBasIc4, // Base de ICMS 4
                                   FAlqIc4, // Aliquota de ICMS 4
                                   FValIc4, // Valor de ICMS 4
                                   FValOu4, // Valor de Outras 4
                                   FValIs4, // Valor de Isento 4
                                   FValRe4, // Valor de Retido 4
                                   FBasIp4, // Base de IPI 4
                                   FValIp4, // Valor de IPI 4
                                   FBasSu4, // Base de Substituição 4
                                   FDesAc4, // Valor de Despesa Acessária 4
                                   FValIs4, // Valor do ISS 4

                                   FClaFi5, // Classificação Fiscal 5
                                   FValCo5, // Valor Contábil 5
                                   FBasIc5, // Base de ICMS 5
                                   FAlqIc5, // Aliquota de ICMS 5
                                   FValIc5, // Valor de ICMS 5
                                   FValOu5, // Valor de Outras 5
                                   FValIs5, // Valor de Isento 5
                                   FValRe5, // Valor de Retido 5
                                   FBasIp5, // Base de IPI 5
                                   FValIp5, // Valor de IPI 5
                                   FBasSu5, // Base de Substituição 5
                                   FDesAc5, // Valor de Despesa Acessária 5
                                   FValIs5, // Valor do ISS 5

                                   fltTotPis, // TOT PIS
                                   fltTotCof, // TOT COFINS
                                   fltBasPis, // BASE PIS
                                   fltBasCof, // BASE COFINS
                                   fltAlqPis, // ALIQ PIS
                                   fltAlqCof, // ALIQ COFINS

                                   IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),  // Empresa
                                   FSerie_,   // Série
                                   FEstTra,   // Estado do Cliente / Fornecedor
                                   '',        // Número de Série
                                   '',        // Número COO
                                   '',        // Conta Contábil
                                   '',        // Documento do Conhecimento de Frete
                                   strAcesso, // Chave de Acessod NF-e
                                   '',        // Numero Protocolo NF-e
                                   'F',       // Origem do documento

                                   '',           //strEmpAut
                                   0,            //   fltImpMer
                                   0,            //   fltImpSeg
                                   0,            //   fltImpImp
                                   0,            //   fltImpPro
                                   0,            //   fltImpTax
                                   0,            //   fltImpPis
                                   0,            //   fltImpCof
                                   '',           //  strImpIC1
                                   '',           //  strImpIC2
                                   FModFre,      //  strModFre
                                   0,            //   fltBasIss
                                   0,            //   fltAlqIss
                                   0,            //   fltValIss
                                   0,            // fltBaseII: Double = 0;
                                   0,            // fltDesAdu: Double = 0;
                                   0,            // fltValIOF: DOuble = 0;
                                   FBasAn1,      // Base Antecipação 1
                                   FAntIc1,      // Vr. Antecipação 1
                                   FBasAn2,      // Base Antecipação 2
                                   FAntIc2,      // Vr. Antecipação 2
                                   FBasAn3,      // Base Antecipação 3
                                   FAntIc3,      // Vr. Antecipação 3
                                   FBasAn4,      // Base Antecipação 4
                                   FAntIc4,      // Vr. Antecipação 4
                                   FBasAn5,      // Base Antecipação 5
                                   FAntIc5,      // Vr. Antecipação 5
                                   '',            // strCstEnt
                                   FblnGraCTP,  // Gravou Financeiro);
                                   0, // fltBaeRe1: Double = 0;
                                   0, // fltVaeRe1: Double = 0;
                                   0, // fltBaeRe2: Double = 0;
                                   0, // fltVaeRe2: Double = 0;
                                   0, // fltBaeRe3: Double = 0;
                                   0, // fltVaeRe3: Double = 0;
                                   0, // fltBaeRe4: Double = 0;
                                   0, // fltVaeRe4: Double = 0;
                                   0, // fltBaeRe5: Double = 0;
                                   0, // fltVaeRe5: Double = 0;
                                   0, // fltBaeIP1: Double = 0;
                                   0, // fltVaeIP1: Double = 0;
                                   0, // fltBaeIP2: Double = 0;
                                   0, // fltVaeIP2: Double = 0;
                                   0, // fltBaeIP3: Double = 0;
                                   0, // fltVaeIP3: Double = 0;
                                   0, // fltBaeIP4: Double = 0;
                                   0, // fltVaeIP4: Double = 0;
                                   0, // fltBaeIP5: Double = 0;
                                   0, // fltVaeIP5: Double = 0;
                                   FCstPis,
                                   FCstCof,
                                   FModelo,
                                   IIf(FTransf = 'S', 'C', IIf(tpFrete = tpfSaida, 'V', 'C')), //SE FOR TRANSFERÊNCIA GRAVA COMO (C)OMPRA, POR CAUSA TABELA 'LANCON', REQ 284464

                                    0,      //fltBFCPS1
                                    0,      //fltVFCPS1
                                    0,      //fltBFCPS2
                                    0,      //fltVFCPS2
                                    0,      //fltBFCPS3
                                    0,      //fltVFCPS3
                                    0,      //fltBFCPS4
                                    0,      //fltVFCPS4
                                    0,      //fltBFCPS5
                                    0,      //fltVFCPS5
                                    0,      //fltALQFCP
                                    0,      //fltTotRmm
                                    '',     //strCodTra

                                    0,     //FIS_REIRRF
                                    0,     //FIS_VREPIS
                                    0,     //FIS_VRECOF
                                    0,     //FIS_RECSSL
                                    0,     //FIS_RETISS
                                    0,     //FIS_REINSS


                                    0,     //fltBAFCP1
                                    0,     //fltVLFCP1
                                    0,     //fltBAFCP2
                                    0,     //fltVLFCP2
                                    0,     //fltBAFCP3
                                    0,     //fltVLFCP3
                                    0,     //fltBAFCP4
                                    0,     //fltVLFCP4
                                    0,     //fltBAFCP5
                                    0,     //fltVLFCP5
                                    fTipoDocFreteToChar(FtpDocFrete),
                                    0,
                                    0,
                                    0,
                                    '',
                                    'N',
                                    FPesoBruto,
                                    '',
                                    '',
                                    strNatOpe,
                                    '',
                                    '',
                                    strBasFre);

            Result := Result And fGravaRelacionamentoCTEcomDocumento(strAcesso, strAutIncCadFis);

            If Result And (tpFrete = tpfEntrada) And (FValCo1 > 0) Then
            begin
              objFreConLista := TFreConLista.Create(nil, False, False, objIteAnt, strAutIncCadFis, True);
              Result := objFreConLista.fRateiaConhecimentoFreteNotas(0,0, strNotas);
            end;

              Result := Result And fGravaPessoas(strAutIncCadFis) And fGravaDadosMunicipio  (strAutIncCadFis);
              Result := Result And fGravaXML(strAutIncCadFis, strNomArq);

          End;

          If Not Result Then
            Break;

            {**************************************}
            {* GRAVA CADPAG                       *}
            {***********************************AF*}
          If FblnGraCTP And ((FComplemento = '0') Or ((FComplemento = '1') And (FValCo1 > 0))) Then
          Begin
            dataBase := FDtaEnt;

            if (fCfgSis('NOCTFI', varBoolean)) and (fCfgSis('CTECPG', varString)='2') then
            begin
              dataBase := qryTabela.FieldByName('DTADOC').AsDateTime;
            end;

            fDigDuplic(arrDuplicata,
                       FCndPag,
                       0,
                       IIf(blnLEVREC and (FvREC > 0) and (tpFrete = tpfEntrada), FvREC, FValTot),
                       False,
                       True,
                       False,
                       dataBase,
                       True,
                       0,
                       'N',
                       True,
                       False,
                       0,
                       False,
                       Nil,
                       '',
                       True,
                       True,
                       Nil,
                       '',
                       False,
                       True,
                       '',
                       '',
                       Nil,
                       False,
                       False,
                       Nil,
                       False,
                       False,
                       0,
                       '',
                       '',
                       '',
                       False,
                       False,
                       True);

            If Not fEmptyStr(FDuplic) Then
              pMontaDuplicatasXMl;

            If blnGravaCadFis And
               (fCfgSis('ENTCTP', varBoolean))    And
               (Pos(strClaFis, VS_strClaCom) > 0) And
               (fFornecedorGravaCtp(FCodTra))     Then
            Begin

              intContador := 0;

              intCtpCon := fRetCtpCon;
              {*****************************************}
              {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
              {**************************************AF*}
              While (ArrDuplicata[intContador].dtaDtaVen <> '') And
                    (intContador < 24)                          And
                    (Result)                                    Do
              Begin
                cdsNotasFiscais.Filtered := False;

                If (fCfgSis('HISCTP', varBoolean)) Then
                Begin
                  strHistorico := 'REF. LANCAMENTO DE CONHECIMENTOS DE FRETE ' + FNumDoc + '-' + FEspDoc;
                  cdsNotasFiscais.Filtered := False;
                  cdsNotasFiscais.First;
                  If cdsNotasFiscais.Locate('CTE_ACESSO', FAcesso, []) Then
                  Begin
                    If cdsNotasFiscais.FieldByName('FIS_NUMDOC').AsString <> '' Then
                    Begin
                      strHistorico := strHistorico + ' DTA. EMISSÃO: ' + DateToStr(FDtaDoc) +
                                                     ' CLIENTE/FORNECEDOR: ' + cdsNotasFiscais.FieldByName('NFE_DESTINATARIO').AsString + ' - ' +
                                                     ' DOCUMENTO: ' + cdsNotasFiscais.FieldByName('FIS_NUMDOC').AsString +  ' - ' +
                                                                     cdsNotasFiscais.FieldByName('FIS_ESPDOC').AsString +  ' - ' +
                                                                     cdsNotasFiscais.FieldByName('FIS_CODEMP').AsString;
                    End;
                  End;
                End
                Else
                  strHistorico := '';

                strHisBai := '';
                strCtaBai := '';
                strDocBai := '';
                strOpeBai := '';
                dtaDtaPag := 0;
                fltValPag := 0;
                strSeqLan := '';

                If (fCfgSis('CTPAVI', varBoolean))                            And
                   (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) Then
                Begin
                  lstBanCtp := TBanCtpRepository.Create;
                  lstBanCtp.fAdd(FNumDoc,
                                 'A',
                                 FSerie_,
                                 IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                 FCodTra, // Fornecedor
                                 strHistorico,
                                 '',
                                 FCodCta,
                                 IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                 0,
                                 ArrDuplicata[intContador].curValor,
                                 0,
                                 0,
                                 0,
                                 0);

                  strSeqLan := fGravaMovBan(FCodCta,                            // Centro de Custo
                                            FPorBai,                            // Portador da Baixa
                                            strCodOpe,                          // Operador da Baixa
                                            VS_Date,                            // Data do Lançamento
                                            fTime(),                            // Hora do Lançamento
                                            FNumDoc,                            // Numero do Documento
                                            'D',                                // Credito / Debito
                                            IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                            ArrDuplicata[intContador].curValor, // Valor Do Lançamento
                                            strHistorico,                       // Histórico 1
                                            '',                                 // Histórico 2
                                            '',                                 // Cliente da Duplicata
                                            FCodTra,                            // Fornecedor da Duplicata
                                            FNumDoc,                            // Número da Duplicata
                                            0,                                  // Sequencial de Baixa
                                            'A',                                // Parcela da Duplicata
                                            IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp),
                                            FSerie_,                            // Série
                                            FCodEve,                            // Código do Evento
                                            '',                                 // Documento da Baixa
                                            lstBanCtp.fGetList,                 // Log Bancário
                                            0,
                                            intCtpCon);

                  Result := Not fEmptyStr(strSeqLan);

                  FreeAndNil(lstBanCtp);

                  If (fCfgSis('HISCTP', varBoolean)) Then
                  Begin
                    strHisBai := 'REF. LANCAMENTO DE CONHECIMENTOS DE FRETE ' + FNumDoc + '-' + FEspDoc;
                    cdsNotasFiscais.Filtered := False;
                    cdsNotasFiscais.First;
                    If cdsNotasFiscais.Locate('CTE_ACESSO', FAcesso, []) Then
                    Begin
                      If cdsNotasFiscais.FieldByName('FIS_NUMDOC').AsString <> '' Then
                      Begin
                        strHisBai := strHisBai + ' DTA. EMISSÃO: ' + DateToStr(FDtaDoc) +
                                                 ' CLIENTE/FORNECEDOR: ' + cdsNotasFiscais.FieldByName('NFE_DESTINATARIO').AsString + ' - ' +
                                                 ' DOCUMENTO: ' + cdsNotasFiscais.FieldByName('FIS_NUMDOC').AsString +  ' - ' +
                                                                 cdsNotasFiscais.FieldByName('FIS_ESPDOC').AsString +  ' - ' +
                                                                 cdsNotasFiscais.FieldByName('FIS_CODEMP').AsString;
                      End;
                    End;
                  End
                  Else
                    strHisBai := '';

                  strCtaBai := FCodCta;
                  strDocBai := strSeqLan;
                  strOpeBai := strLoginUsuarioLogado;
                  dtaDtaPag := VS_Date;
                  fltValPag := ArrDuplicata[intContador].curValor;

                End;

                if not fVerificaTemCadPag(IIf(fEmptyStr(FEmpresaPagadora),
                                          IIf(fEmptyStr(strFisCodEmp),FCodEmp ,strFisCodEmp),
                                          FEmpresaPagadora), ArrDuplicata[intContador].strSequen) then
                begin
                  strAutPag := fRetAutoIncrem('CADPAG', VS_strCodEmp);

                  SetLength(FSeqPag, Succ(Length(FSeqPag)));
                  FSeqPag[High(FSeqPag)] := strAutPag;

                  If Pos(ArrDuplicata[intContador].strUsaChq, 'S_N_') <= 0 Then
                    ArrDuplicata[intContador].strUsaChq := 'N';

                  Result := Result And
                          fGravaCadPag('frmEntFreConImportacao' + 'untEntFreCon - fConfirmaImportacao', //Nome Form LOGCTP
                                       'BAIXA - CONHECIMENTO DE FRETE',                //Descrição LOGCTP
                                       FCodTra,                                        // Fornecedor
                                       FNumDoc,                                        // Numero da Duplicata
                                       ArrDuplicata[intContador].strSequen,            // Parcela
                                       IIf(fEmptyStr(FEmpresaPagadora),
                                          IIf(fEmptyStr(strFisCodEmp),FCodEmp ,strFisCodEmp),
                                          FEmpresaPagadora),                           // Empresa
                                       FCodCta,                                        // Centro de Custo
                                       FSerie_,                                        // Serie do Documento
                                       0,                                              // Sequencial de Baixa
                                       FDtaEnt,                                        // Data do lançamento
                                       StrToDate(ArrDuplicata[intContador].dtaDtaVen), // Data de Vencimento
                                       ArrDuplicata[intContador].curValor - fltValPag, // Valor da Duplicata
                                       ArrDuplicata[intContador].curValor,             // Valor Original
                                       'N',                                            // Previsão?
                                       Iif(blnVeioBoleto, 'S', 'N'),                   // Veio Boleto
                                       'N',                                            // Deposito
                                       strHistorico,                                   // Histórico 1
                                       '',                                             // Histórico 2
                                       strHisBai,                                      // Histórico da Baixa
                                       FPorBai,                                        // Portador da Baixa
                                       strCtaBai,                                      // Centro de Custo da Baixa
                                       strDocBai,                                      // Documento da Baixa
                                       strOpeBai,                                      // Operador da Baixa
                                       dtaDtaPag,                                      // Data do Pagamento
                                       fltValPag,                                      // Valor Pago
                                       0,                                              // Valor de Juros
                                       0,                                              // Valor Desconto
                                       IIf(fEmptyStr(strFisCodEmp), FCodEmp, strFisCodEmp), // Empresa
                                       FCodEve,                                        // Código do Evento
                                       ArrDuplicata[intContador].strUsaChq,            // Usa Cheque
                                       FPorBai,                                        // Cod do Portador
                                       FNumDoc,                                        // Numero do Documento
                                       0.0,                                            // fltJurSuj
                                       0.0,                                            // fltDesSuj
                                       intCtpCon,                                      // intSeqCon
                                       False,                                          // blnResCai
                                       0,                                              // intRcxCon
                                       '',                                             // strTipDoc
                                       0,                                              // fltVendor
                                       '',                                             // strVeioNF
                                       '',                                             // strNotEnt
                                       '',                                             // strNotTip
                                       '',                                             // strCTPCom
                                       strAutPag,                                      // strAutInc
                                       '',                                             // strDocTer
                                       '',                                             // strEspTer
                                       '',                                             // strEmpTer
                                       '',                                             // strCliTer
                                       'N',                                            // strUsoCon
                                       FComPet,                                        // strCompet
                                       '',                                             // strCodCliUC
                                       '',                                             // strNumDocUC
                                       '',                                             // strEspDocUC
                                       '',                                             // strCodEmpUC
                                       fltValPag,                                      // fltDinhei
                                       0,                                              // fltChqAvi: Double = 0;
                                       0,                                              // fltOrdPag: Double = 0;
                                       0,                                              // fltRepChq: Double = 0;
                                       '',                                             // strCodVen: String = '';
                                       0,                                              // fltJurAnt: Double = 0;
                                       0,                                              // fltDesAnt: Double = 0;
                                       IIF(blnVeioBoleto And (blnCtpBol), arrLinDigCodbar[intContador].strLinDig, ''),  // strLinDig: String = '';
                                       IIF(blnVeioBoleto And (blnCtpBol), arrLinDigCodbar[intContador].strCodBar, ''),  // strCodBar: String = '';
                                       '',
                                       '',
                                       '',
                                       '0',
                                       '',
                                       '',
                                       '',
                                       '',
                                       'N');
                end;

                If Not Result Then
                  Break;

                Inc(intContador);
              End;
            End; 
          End; {do If (fCfgSis('ENTCTP', varBoolean))    And
               (Pos(strClaFis, VS_strClaCom) > 0) And
               (fFornecedorGravaCtp(FCodTra))     Then...}

          If blnGravaCadFis Then
            pEscreveMensagemImportacao(FMemLog, 'Documento ' + FNumDoc + '-' + FEspDoc + ': ' + 'Gravação efetuada com sucesso!');

          If Result And (tpFrete = tpfSaida) And (Not fEmptyStr(strCodCliTomador)) And (blnEmitenteFornecedorFilial) Then
          Begin
            strEmpresaTransportadora := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_C_G_C_'], [FCgcTra]);
            Result := Result And fGravaCadRecSaida(strCodCliTomador, IIf(fEmptyStr(strEmpresaTransportadora), FCodEmp, strEmpresaTransportadora)) And
                                 fGravaCadFisSaida(strCodCliTomador, IIf(fEmptyStr(strEmpresaTransportadora), FCodEmp, strEmpresaTransportadora), strClaFisXML);

          End;

          If blnRegistroCorrente Then
            Break
          Else
            Next;

        End; {While (Not Eof) And Result Do}

      end;

      If Result Then
        pGravaRelacionamentoComplementos(strAcesso);

      if (blnImportaPeloBancoDados) and (Result) then
        Result := fMarcaCTeImportado;

      If Result Then
        fCommit
      Else
      Begin
        fRollBack;
        pEscreveMensagemImportacao(FMemErr, 'Ocorreu um erro e não foram realizados os lançamentos!');
      End;

      if ArrDuplicata[1].strSequen = '' then
      begin
        try
          pCriarFormularios(TFrmManipulaContasPagarPrevisaoNao, frmManipulaContasPagarPrevisaoNao) ;
          frmManipulaContasPagarPrevisaoNao.AUTOINCREM := strAutPag ;
          frmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao;
          if frmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim then
            frmManipulaContasPagarPrevisaoNao.showModal;
        finally
          FreeAndNil(frmManipulaContasPagarPrevisaoNao);
        end;
      end;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pEscreveMensagemImportacao(FMemErr, 'Ocorreu um erro: ' + E.Message);
        pMensagensErro(E.Message,'[TFreCon.fConfirmaImportacao]');
        Result := False;
      End;
    End;
  Finally
    If Assigned(lstMemErr) Then
    Begin
      FreeAndNil(lstMemErr);
      FMemErr := nil;
    End;
    If Assigned(lstMemLog) Then
    Begin
      FreeAndNil(lstMemLog);
      FMemLog := nil;
    End
  End;

End;

function TFreCon.fExisteNFeDevolucao(strNFeAcesso: String): Boolean;
begin

  With FConsulta Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT COUNT(1) AS COUNT FROM CADFIS');
    SQL.Add(' INNER JOIN MOVDET ON  DET_DOCDEV = FIS_NUMDOC ');
    SQL.Add('                  AND DET_ESPDEV = FIS_ESPDOC');
    SQL.Add('                  AND DET_EMPDEV = FIS_CODEMP');
    SQL.Add(' WHERE FIS_ACESSO = "' + strNFeAcesso + '"');
    SQL.Add('   AND DET_DOCDEV IS NOT NULL');

    Open;
    Result := FConsulta.FieldByName('COUNT').AsInteger > 0;
  End;
end;

function TFreCon.fConfirmaImportacaoFrete(prgProgresso: TProgressBar): Boolean;
  Var
    strNomArq: String;
    strErroInt: String;
Begin
  FblnMostraLog := True;
  try
    Try

      With qryTabela Do
      Begin
        Result := True;
        DisableControls;
        Filter   := 'IMPORT = ' + QuotedStr('S');
        Filtered := True;

        If {(tpFrete = tpfEntrada) And}
           fInformarPisCofins Then
        Begin
          Filtered := False;
          EnableControls;
          Result   := False;
          Exit;
        End;

        First;
        Try
          If IsEmpty Then
          Begin
            Result := False;
            qryTabela.Filtered := False;
            qryTabela.EnableControls;
            pMensagemOk('Selecione os arquivos para importação!');
            FblnMostraLog := False;
            Exit;
          End;

          If Not fPergunta('Confirma a importação dos arquivos selecionados?') Then
          Begin
            Result := False;
            qryTabela.Filtered := False;
            qryTabela.EnableControls;
            Exit;
          End;

          //Ajusta notas fiscais os que serão importadas ou não
          pMarcarNotasQueSeraoImportadas;
          pLocalizaItemDuplicadoJaImportados;
          If Not fValidaNotas Then
            Exit(False);

          prgProgresso.Position := 0;
          prgProgresso.Max      := RecordCount;
          prgProgresso.Visible  := True;

          While Not Eof Do
          Begin
            strNomArq := FstrPath + FieldByName('NOMARQ').AsString;
            If fCadFisExiste(FieldByName('NUMDOC').AsString,
                             FieldByName('ESPDOC').AsString,
                             IIf(fEmptyStr(FieldByName('CODEMP').AsString), VS_strCodEmp, FieldByName('CODEMP').AsString),
                             FieldByName('CODTRA').AsString,
                             FieldByName('SERIE_').AsString,
                             'F',
                             'E') Then
            Begin
              Result := False;

              strNomArq := FieldByName('NOMARQ').AsString;

              Edit;
              FieldByName('STATUS').AsInteger := DOCUMENTO_JA_EXISTE;
              FieldByName('LOGIMP').AsString  := FieldByName('LOGIMP').AsString + ' Documento ' + FieldByName('NUMDOC').AsString + '-' + FieldByName('ESPDOC').AsString + ' já existe no sistema!';
              Post;

              // ESTÁ COM FILTRO
              If SameText(strNomArq, FieldByName('NOMARQ').AsString) Then
                Next;
            End
            Else If fConfirmaImportacao(strNomArq, strErroInt, True) Then
            Begin
              RenameFile(strNomArq, AnsiLeftStr(strNomArq, Length(strNomArq) - 3) + 'old');
              Delete;
            End
            Else
            Begin
              Result := False;

              strNomArq := FieldByName('NOMARQ').AsString;

              Edit;
              FieldByName('STATUS').AsInteger := COM_ERRO_GRAVACAO;
              FieldByName('LOGIMP').AsString := FieldByName('LOGIMP').AsString + ' ' + strErroInt;

              Post;

              // ESTÁ COM FILTRO
              If SameText(strNomArq, FieldByName('NOMARQ').AsString) Then
                Next;
            End;

            prgProgresso.StepBy(1);
            Application.ProcessMessages;
          End;

          Filtered := False;

          If Result Then
          Begin
            pMensagemOk('Arquivos importados com sucesso!');
          End Else
          Begin
            If Locate('IMPORT;STATUS', VarArrayOf(['S', '2']), []) Then
              pMensagemOk('Há arquivos com erro de gravação!');
          End;

          First;
        Finally
          qryTabela.Filtered := False;
          qryTabela.EnableControls;
          prgProgresso.Visible  := False;

        End;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TFreCon.fConfirmaImportacaoFrete]');
      End;
    End;
  Finally
    pFiltraLog;
  End;
end;

function TFreCon.fConfirmaImportacaoFreteBanco: Boolean;
var
  strErroInt: String;
  strNomArq: String;
begin
  Try
    qryTabela.Filter   := 'IMPORT = ' + QuotedStr('S');
    qryTabela.Filtered := True;

    If (tpFrete = tpfEntrada) and (not blnUtiAbr) Then
    Begin
      If qryTabela.Locate('AUTPIS',  '', []) Then
      Begin
        pGravarErro(True, 'Alíquota de PIS não informada! Verifique!', 'TFreCon.fConfirmaImportacaoFreteBanco');
        qryTabela.Filtered := False;
        Result   := False;
        Exit;
      End;

      If qryTabela.Locate('AUTCOF',  '', []) Then
      Begin
        pGravarErro(True, 'Alíquota de COFINS não informada! Verifique!', 'TFreCon.fConfirmaImportacaoFreteBanco');
        qryTabela.Filtered := False;
        Result   := False;
        Exit;
      End;
    End;

    qryTabela.First;
    Try
      //Ajusta notas fiscais os que serão importadas ou não
      If (tpFrete = tpfSaida) Then
      Begin
        cdsNotasFiscais.Filtered := False;
        cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = ''''';
        cdsNotasFisCais.Filtered := True;
        Result := cdsNotasFiscais.RecordCount = 0;
        if not Result then
        begin
          pAtualizaTentativaImp;
          pGravarErro(True, 'Existem Notas Fiscas no CTE sem as Notas Correspondentes na tabela CADFIS!', 'TFreCon.fConfirmaImportacaoFreteBanco');
          Exit;
        end;

        cdsNotasFiscais.Filtered := False;
        cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND ENT_DUPLIC = ' +QuotedStr('S');
        cdsNotasFisCais.Filtered := True;
        Result := cdsNotasFiscais.RecordCount = 0;
        if not Result then
        begin
          pAtualizaTentativaImp;
          pGravarErro(True, 'Existem Notas Fiscas no CTE duplicadas na tabela RECTNF!', 'TFreCon.fConfirmaImportacaoFreteBanco');
          Exit;
        end;
      End;

      While Not qryTabela.Eof Do
      Begin
        strNomArq := FstrPath + qryTabela.FieldByName('NOMARQ').AsString;

        If fConfirmaImportacao(strNomArq, strErroInt, True) Then
        begin
          qryTabela.Delete;
        end
        else
        Begin
          qryTabela.Edit;
          qryTabela.FieldByName('STATUS').AsInteger := COM_ERRO_GRAVACAO;
          qryTabela.FieldByName('LOGIMP').AsString := qryTabela.FieldByName('LOGIMP').AsString + ' ' + strErroInt;
          qryTabela.Post;
          qryTabela.Next;
        End;
      End;

      qryTabela.Filtered := False;

      Result := qryTabela.Locate('IMPORT;STATUS', VarArrayOf(['S', '2']), []);
      if Result then
        pGravarErro(True, FMemErr.ToString, 'TFreCon.fConfirmaImportacaoFreteBanco');
    Finally
      qryTabela.Filtered := False;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fConfirmaImportacaoFreteBanco]');
    End;
  End;
end;

destructor TFreCon.Destroy;
begin
  FreeAndNil(qryGeneric);
  FreeAndNil(qryTabela);
  FreeAndNil(FLogImportacao);
  FreeAndNil(FConsulta);
  FreeAndNil(FEmpresas);
  FreeAndNil(FPortadorFornecedor);
  FreeAndNil(cdsNotasFiscais);
  FreeAndNil(cdsComplementos);

  if Assigned(qryCTes) then
    FreeAndNil(qryCTes);
  inherited Destroy;
end;

function TFreCon.fAbreXml(strNomArq: String; blnClassificaoEntrada, blnEntradaMercadoria: Boolean; blnImpVencimentos: Boolean): Boolean;
  Var
    stlErr, stlLog : TStringList;
begin
  Try
    stlErr := TStringList.Create;
    stlLog := TStringList.Create;

    FValTot  := 0.0;
    FImpFre  := True;

    fCarregaArquivoFreteXML(strNomArq, stlLog, stlErr, blnClassificaoEntrada, blnEntradaMercadoria, blnImpVencimentos, True, True);

    Result := fEmptyStr(stlErr.Text);

    If Not Result Then
      pMensagemOk(stlErr.Text);

    FImpFre  := False;
  Finally
    FreeAndNil(stlErr);
    FreeAndNil(stlLog);
  End;

end;

function TFreCon.fCarregaArquivoFrete(const strArquivo: String; memLog,  memErr: TStrings; blnXML: Boolean;var  blnNotaNaoIdentificada: Boolean): Boolean;
  Var
    stlFrete : TStringList;
    strErroInt: String;
    function fMsgInconsistencias: String;
    begin
      Result := 'Existem ' + IntToStr(FmemErr.Count) + ' inconsistências ' +
                'no arquivo, corrigir as mesmas e tentar novamente a importação!';
    end;

begin

  Result := True;

  FValTot  := 0.0;
  FImpFre  := True;

  FMemLog := memLog;
  FMemErr := memErr;

  FmemLog.Clear;
  FmemErr.Clear;

  If Not blnXMLEvento Then
  Begin
    If fEmptyStr(FPorBai) And fCfgSis('CTPAVI', varBoolean) And blnGraCTP Then
    Begin
      pEscreveMensagemImportacao(FmemErr, 'O portador deve ser informado!');
      Result := False;
    End;

    If fEmptyStr(FCodCta) And blnGraCTP  Then
    Begin
      pEscreveMensagemImportacao(FmemErr, 'O código da conta deve ser informado!');
      Result := False;
    End;

    If Not FileExists(strArquivo) Then
    Begin
      pEscreveMensagemImportacao(FmemErr, 'O Arquivo informado não existe!');
      Result := False;
    End;
  End;

  If Not Result Then
    Exit;

  stlFrete := TStringList.Create;
  Try
    stlFrete.LoadFromFile(strArquivo);

    If (Not blnXML) And (Not blnXMLEvento) Then
      qryTabela.EmptyDataSet;

    Try

      If (stlFrete.Count = 0) Then
      Begin
        Result := False;
        pEscreveMensagemImportacao(FmemErr, 'O Arquivo informado está vazio!');
      End

      Else If (blnXML) And Not (blnXMLEvento) Then
      Begin

        If Not (Pos('<infCte', stlFrete.Text) > 0) Then
        Begin
          Result := False;
          pEscreveMensagemImportacao(FmemErr, 'Estrutura do arquivo não é compatível!');
        End;

      End
      Else If blnXMLEvento Then
      Begin
        If Not (Pos('<evCancCTe', stlFrete.Text) > 0) Then
        Begin
          Result := False;
          pEscreveMensagemImportacao(FmemErr, 'Estrutura do arquivo não é compatível!');
        End;
      End;

      If Result Then
      Begin
        If blnXML Then
          Result := fCarregaArquivoFreteXML(strArquivo, FmemLog, FmemErr, (tpFrete = tpfEntrada), False, blnNotaNaoIdentificada, True, True, True)
        Else If blnXMLEvento Then
        Begin
          pCarregaArquivoFreteXMLEvento(strArquivo, FmemLog, FmemErr);
          pCarregarDadosXMLEvento;
          Result := fValidarXMLEvento(FmemErr);
        End
        Else
          Result := fCarregaTXT(stlFrete, FmemLog, FmemErr)
      End;

      If (Not blnXML) And (Not blnXMLEvento) Then
      Begin

        If Result And qryTabela.IsEmpty Then
        Begin
          Result := False;
          pEscreveMensagemImportacao(FmemErr, 'Não há documentos para serem lançados!');
        End;

        If Not Result Then
        Begin
          Result := False;
          pEscreveMensagemImportacao(FmemLog, '******************* Nenhum arquivo foi importado - Inconsistências *******************');
          fMensagem('', '*** Nenhum arquivo foi importado *** ' + #13#10 + fMsgInconsistencias, ['&Ok']);
          pEscreveMensagemImportacao(FmemErr, '******************* Nenhum arquivo foi importado - Inconsistências *******************');
        End;

        If Result And ( fMensagem('', 'Confirma lançamentos?', ['','']) = 1 ) Then
        Begin
          Result := fConfirmaImportacao(strArquivo, strErroInt);

          If Result Then
          Begin
            RenameFile(strArquivo, AnsiLeftStr(strArquivo, Length(strArquivo) - 3) + 'old');
            pEscreveMensagemImportacao(FmemLog, 'Importação de arquivo concluída com sucesso!');
            fMensagem('','Importação de arquivo concluída com sucesso!', ['&O K']);
          End;

        End;

      End;


    Except
      On E: Exception Do
      Begin
        If Not blnXML Then
          qryTabela.EmptyDataSet;

        Result := False;
        pEscreveMensagemImportacao(FmemErr, 'Erro: ' + E.Message, 0);

        If Not blnXML Then
          pMensagensErro(E.Message,'[TFreCon.fCarregaArquivoFrete]');
      End;
    End;
  Finally
    FreeAndNil(stlFrete);
  End;
end;

function TFreCon.fRetAutoincremCadFis(AstrAcesso: String): String;
Begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT  AUTOINCREM FROM CADFIS WHERE FIS_ACESSO = ' + QuotedStr(AstrAcesso));
  FConsulta.Open;
  Result := FConsulta.FieldByName('AUTOINCREM').AsString;
End;

Function TFreCon.fValidaPessoasCadastradasNoBanco: Boolean;
  Function fValidaPessoasCadastradasNoBancoAux(APessoaCTE: TPessoaCTE; AAlias: String): Boolean;
  Begin
    If qryGeneric.Active Then
      qryGeneric.Close;

    fValidaPessoasCadastradasNoBancoAux := True;
    If APessoaCTE.strCNPJ <> '' Then
    begin
      qryGeneric.ParamByName('CNPJ').ASString := APessoaCTE.strCNPJ;
      qryGeneric.Open;
      If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
      Begin
        fValidaPessoasCadastradasNoBancoAux := False;
        FMemErr.Add('O '+AAlias+' não foi encontrado no sistema(Cad. Cliente, Cad. Fornecedor ou Cad. Empresa), Nome: '+APessoaCTE.strRAZAO_SOCIAL+' CPF/CNPJ:' + APessoaCTE.strCNPJ);
      End;
    End;
  End;

begin
  Result := True;
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT SUM(QTD) AS QTD FROM (');
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD FROM CADEMP');
  qryGeneric.SQL.Add('WHERE EMP_C_G_C_ = :CNPJ');
  qryGeneric.SQL.Add('UNION SELECT COUNT(1) AS QTD FROM CADCLI');
  qryGeneric.SQL.Add('WHERE CLI_C_G_C_ = :CNPJ');
  qryGeneric.SQL.Add('UNION SELECT COUNT(1) AS QTD FROM CADFOR');
  qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :CNPJ) TMP');

  //Verifica emitente
  IF Not fValidaPessoasCadastradasNoBancoAux(FEmitente, 'Emitente') Then
    Result := False;
//  If Not fValidaPessoasCadastradasNoBancoAux(FRecebedor, 'Recebedor') Then
//    Result := False;
  If Not fValidaPessoasCadastradasNoBancoAux(FRemetente, 'Remetente') Then
    Result := False;
//  IF Not fValidaPessoasCadastradasNoBancoAux(FExpedidor, 'Expedidor') Then
//    Result := False;
  IF Not fValidaPessoasCadastradasNoBancoAux(FDestinatario, 'Destinatario') Then
    Result := False;
  IF Not fValidaPessoasCadastradasNoBancoAux(FTomador, 'Tomador') Then
    Result := False;
End;

function TFreCon.fCarregaArquivoFreteXML(strNomArq : String; memLog, memErr: TStrings;
                                     blnClassificacaoEntrada: Boolean;
                                     blnEntradaDeMercadoria : Boolean;
                                     var blnNotaNaoIdentificada: Boolean;
                                     blnImpClF : Boolean = False;
                                     blnImpTransp : Boolean = False;
                                     blnImpVencimentos: Boolean = False): Boolean;

  function fFloatXmlToFloat(strValue : String) : Double;
  Begin
    Result := fStrToFloat(ReplaceStr(strValue, '.', ','));
  End;

  Var
    xmlNodeIde,
    xmlNode,
    xmlNodeNfe,
    xmlNodeCarga,

    xmlNodeICMS,
    xmlNodeValue : IXMLNode;
    xmlDoc       : TXMLDocument;
    intCorre     : Integer;
    fltVlrCon,
    fltVlrBcI,
    fltAliIcm,
    fltVlrIcm  : Double;

    fltValRet: Double;
    fltBasSub: Double;
    blnMod67,
    blnSoComplemento: Boolean;
    strCnpjEmpresa,
    strCnpjEmpresaLogada,
    strErro,
    strClaFis,
    strChaveNotaFiscal: String;
    intIndClaFis: Integer;
    strCfopNFE: String;
    blnEncontrouNotaQueNaoEhBrinde: Boolean;
    blnValidouNotas: Boolean;
    blnTomadorDestino: Boolean;

    qryConCta: TUniQuery;


  Const
    arrChaves : array[0..6] Of String = ('ICMS00', 'ICMS20', 'ICMS60', 'ICMS90', 'ICMSOutraUF', 'ICMS45', 'ICMSSN');
begin
  FMemLog := memLog;
  FIsDocDCe := False;
  FMemErr := memErr;

  FmemLog.Clear;
  FmemErr.Clear;

  blnNotaNaoIdentificada := False;
  blnEncontrouNotaQueNaoEhBrinde := False;
  blnValidouNotas := False;

  blnSoComplemento := False;
  Try
    FStatus := IMPORTADO_OK;
    Result := False;

    xmlDoc := TXMLDocument.Create(Self);
    qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
    Try


      FCodTra := '';
      FCndPag := '';
      FCndXML := 'N';
      FDuplic := '';

      FtpDocFrete := tpdfIndefinido;

      fltVlrBcI := 0;
      fltAliIcm := 0;
      fltVlrIcm := 0;

      fltValRet := 0;
      fltBasSub := 0;

      With xmlDoc Do
      Begin
        Try
          LoadFromFile(strNomArq);
          Active := True;
        Except
          On E : Exception Do
          Begin
            pEscreveMensagemImportacao(memErr, 'Arquivo XML Inconsistente: ' + E.Message, 0);
            FreeAndNil(xmlDoc);
            Exit;
          End;
        End;


        pGetTagRaizCte(xmlDoc,xmlNode, blnMod67);

        IF blnMod67 Then
          xmlNode := xmlDoc.ChildNodes.FindNode('cteOSProc');

        xmlNode := xmlNode.ChildNodes.FindNode('protCTe');

        If Assigned(xmlNode) Then
        Begin
          xmlNode := xmlNode.ChildNodes.FindNode('infProt');

          If Assigned(xmlNode) Then
          Begin
            xmlNodeValue := xmlNode.ChildNodes.FindNode('chCTe');
            If Assigned(xmlNodeValue) Then
              strAcesso := xmlNodeValue.NodeValue;
          End;
        End;


        FCodEmp := '';

        pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
        If Not blnMod67 Then
          xmlNode := xmlNode.ChildNodes.FindNode('CTe');

        xmlNode := xmlNode.ChildNodes.FindNode('infCte');

        FTomSer := '';
        FForPag := '';

        If (tpFrete = tpfSaida) Then
        Begin
          xmlNode    := xmlNode.ChildNodes.FindNode('ide');
          xmlNodeIde := xmlNode;

          If Assigned(xmlNode) Then
          Begin
            xmlNodeValue := xmlNode.ChildNodes.FindNode('forPag');

            If Assigned(xmlNodeValue) Then
              FForPag := xmlNodeValue.Nodevalue;

            xmlNode := xmlNode.ChildNodes.FindNode('toma3');

            If Not Assigned(xmlNode) Then
              xmlNode := xmlNodeIde.ChildNodes.FindNode('toma03');

            If Assigned(xmlNode) Then
            Begin
              xmlNodeValue := xmlNode.ChildNodes.FindNode('toma');

              If Assigned(xmlNodeValue) Then
                FTomSer := xmlNodeValue.NodeValue;
            End
            Else
            Begin
              xmlNode := xmlNodeIde;
              xmlNode := xmlNode.ChildNodes.FindNode('toma4');
              If Assigned(xmlNode) Then
                FTomSer := '4';
            end;
          End;

          pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
          If not blnMod67 Then
            xmlNode := xmlNode.ChildNodes.FindNode('CTe');
          xmlNode := xmlNode.ChildNodes.FindNode('infCte');

          xmlNode := xmlNode.ChildNodes.FindNode('rem');
        End Else
        Begin
          xmlNode := xmlNode.ChildNodes.FindNode('dest');
        End;

        FCGCRem := '';

        If Assigned(xmlNode) Then
        Begin
          xmlNodeValue := xmlNode.ChildNodes.FindNode('CNPJ');

          If Assigned(xmlNodeValue) Then
            FCGCRem := xmlNodeValue.NodeValue;

          If Assigned(xmlNodeValue) Then
            FcodEmp := fGetCodEmp(xmlNodeValue.NodeValue);
        End;

        If FEmptyStr(FCodEmp) Then
          FCodEmp := VS_strCodEmp;

        FCGCDes := '';

        If (tpFrete = tpfEntrada) Then
           pDefinePagadorDoFrete(xmlDoc);

        FstrTipoFJ := '';
        If (tpFrete = tpfSaida) Then
        Begin
          pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
          xmlNode := xmlNode.ChildNodes.FindNode('CTe');
          xmlNode := xmlNode.ChildNodes.FindNode('infCte');
          xmlNode := xmlNode.ChildNodes.FindNode('dest');

          If Assigned(xmlNode) Then
          Begin
            xmlNodeValue := xmlNode.ChildNodes.FindNode('CNPJ');
            If Assigned(xmlNodeValue) Then
            Begin
              FCGCDes := xmlNodeValue.NodeValue;
              FstrTipoFJ := TPessoaCTE.PESSOA_FISICA
            End Else
            Begin
              xmlNodeValue := xmlNode.ChildNodes.FindNode('CPF');

              If Assigned(xmlNodeValue) Then
              begin
                FCGCDes := xmlNodeValue.NodeValue;
                FstrTipoFJ := TPessoaCTE.PESSOA_FISICA;
              end;

            End;

          End;

        End;

        If blnImpTransp Then
        Begin
          pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
          if not blnMod67 Then
            xmlNode := xmlNode.ChildNodes.FindNode('CTe');
          xmlNode := xmlNode.ChildNodes.FindNode('infCte');

          xmlNode := xmlNode.ChildNodes.FindNode('emit');
          xmlNodeValue := xmlNode.ChildNodes.FindNode('CNPJ');

          If Assigned(xmlNodeValue) Then
          Begin
            FCgcTra := xmlNodeValue.NodeValue;
            FCodTra := fRetCodFornecedorPorCnpj(FCgcTra);

            If (Not fEmptyStr(FCodTra)) And (Not fEmptyStr(FCodCta)) And (fCfgSis('USACTF', varBoolean)) Then
            Begin
              qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
              pPesquisaCadCta(qryConCta, qryConCta, FCodCta, True, FCodTra);
              If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
              Begin
                pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Esse Plano de Contas: ' + FCodCta + ' não está cadastrado ou não está vinculado ao fornecedor: '+FCodTra+' .', 0);
                Result := False;
                Exit;
              End;
            End;
          End;

        End;

        strEspDoc := 'CT';
        pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
        pCarregaPessoas(xmlDoc, xmlNode);

        If (Not fExisteFornecedor(FEmitente.strCNPJ)) Then
        Begin
          If Assigned(FCdsFornNaoEncontrado) Then
          Begin
            pInsereCdsFornNaoEncontrado(FEmitente.strCNPJ,
                                        '',
                                        FEmitente.strRAZAO_SOCIAL,
                                        FEmitente.xFant,
                                        FEmitente.xLgr,
                                        FEmitente.xNro,
                                        '',//strXCPL,
                                        FEmitente.xBairro,
                                        FEmitente.strCODIBGE,
                                        FEmitente.xMun,
                                        FEmitente.strUF,
                                        FEmitente.strCEP,
                                        '',//strCPAIS,
                                        '',//strXPAIS,
                                        '',//strFONE,
                                        FEmitente.strINSCRICAO_ESTADUAL,
                                        FEmitente.strINSCRICAO_ESTADUAL,
                                        '',//strIM,
                                        '');//strCNAE
          End;
        End;

        { VALIDAR O TOMADOR: SÓ DEVEMOS VALIDAR O TOMADOR SE O RESPONSÁVEL PELO PAGAMENTO DO FRETE FOR A EMPRESA LOGADA.
          PARA VALIDAR O TOMADOR, O SISTEMA DEVE VERIFICAR SE O CNPJ DO TOMADOR INFORMADO NO XML É O MESMO CNPJ DA EMPRESA LOGADA.
          SE NÃO FOR, APRESENTAR INCONSISTÊNCIA.   }
        strCnpjEmpresa := fRetCNPJEmpresa(FCodEmp);
        strCnpjEmpresaLogada := fRetCNPJEmpresa(VS_StrCodEmp);


        pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
        if not blnMod67 Then
          xmlNode := xmlNode.ChildNodes.FindNode('CTe');
        xmlNode := xmlNode.ChildNodes.FindNode('infCte');

        xmlNode := xmlNode.ChildNodes.FindNode('ide');

        FModelo := '';

        xmlNodeValue := xmlNode.ChildNodes.FindNode('mod');
        If Assigned(xmlNodeValue) Then
          FModelo := xmlNodeValue.NodeValue;

        xmlNodeValue := xmlNode.ChildNodes.FindNode('nCT');
        If Assigned(xmlNodeValue) Then
          strNumDoc := fStrZero(string(xmlNodeValue.NodeValue), fTamNumDoc);

        FComplemento := '0';
        xmlNodeValue := xmlNode.ChildNodes.FindNode('tpCTe');
        If Assigned(xmlNodeValue) Then
          FComplemento := IIF(string(xmlNodeValue.NodeValue) = '1', '1', '0');


        If blnImpClF Then
        Begin
          xmlNodeValue := xmlNode.ChildNodes.FindNode('CFOP');
          If Assigned(xmlNodeValue) Then
          Begin
            strClaFis := xmlNodeValue.NodeValue;
            strClaFiXML := strClaFis;
          End;
        End;

        If fEmptyStr(strNumDoc) Then
        Begin
          pEscreveMensagemImportacao(memErr, 'Numero de Documento não Encontrado, Documento Inválido!', 0);
          FreeAndNil(xmlDoc);
          Exit;
        End;

        xmlNodeValue := xmlNode.ChildNodes.FindNode('cMunIni');
        If Assigned(xmlNodeValue) Then
          FCodMunicipioInicio:= xmlNodeValue.NodeValue;

        xmlNodeValue := xmlNode.ChildNodes.FindNode('xMunIni');
        If Assigned(xmlNodeValue) Then
          FMunicipioDescricaoInicio:= xmlNodeValue.NodeValue;
        xmlNodeValue := xmlNode.ChildNodes.FindNode('UFIni');
        If Assigned(xmlNodeValue) Then
          FUFInicio:= xmlNodeValue.NodeValue;
        xmlNodeValue := xmlNode.ChildNodes.FindNode('cMunFim');
        If Assigned(xmlNodeValue) Then
          FCodMunicipioFim:= xmlNodeValue.NodeValue;
        xmlNodeValue := xmlNode.ChildNodes.FindNode('xMunFim');
        If Assigned(xmlNodeValue) Then
          FMunicipioDescricaoFim:= xmlNodeValue.NodeValue;
        xmlNodeValue := xmlNode.ChildNodes.FindNode('UFFim');
        If Assigned(xmlNodeValue) Then
          FUFFim:= xmlNodeValue.NodeValue;

        xmlNodeValue := xmlNode.ChildNodes.FindNode('serie');
        If Assigned(xmlNodeValue) Then
          strSerie_ := xmlNodeValue.NodeValue;

        xmlNodeValue := xmlNode.ChildNodes.FindNode('modal');
        If Assigned(xmlNodeValue) Then
          FModFre := RightStr(xmlNodeValue.NodeValue,1);

        xmlNodeValue := xmlNode.ChildNodes.FindNode('dhEmi');
        If Assigned(xmlNodeValue) Then
          setDtaDoc(Copy(xmlNodeValue.NodeValue, 9, 2) + '/' + Copy(xmlNodeValue.NodeValue, 6, 2) + '/' + Copy(xmlNodeValue.NodeValue, 1, 4)  );

        pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);

        if Not blnMod67 Then
          xmlNode := xmlNode.ChildNodes.FindNode('CTe');
        xmlNode := xmlNode.ChildNodes.FindNode('infCte');
        xmlNode := xmlNode.ChildNodes.FindNode('dup');

        If not Assigned(xmlNode) Then
        Begin
          pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);

          If Not blnMod67 Then
            xmlNode := xmlNode.ChildNodes.FindNode('CTe');

          xmlNode := xmlNode.ChildNodes.FindNode('infCte');
          xmlNode := xmlNode.ChildNodes.FindNode('infCTeNorm');
          If Assigned(xmlNode) Then
          Begin
            xmlNode := xmlNode.ChildNodes.FindNode('cobr');
            If Assigned(xmlNode) Then
              xmlNode := xmlNode.ChildNodes.FindNode('dup');
          End;
        End;

        If Assigned(xmlNode) Then
        Begin
          FCndPag := fRetCondicaoPagto(xmlNode, FDtaDoc, FDuplic);
          If Not fEmptyStr(FCndPag) Then
            FCndXml := 'S';
        End;

        pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
        If not blnMod67 Then
          xmlNode := xmlNode.ChildNodes.FindNode('CTe');
        xmlNode := xmlNode.ChildNodes.FindNode('infCte');

        xmlNode := xmlNode.ChildNodes.FindNode('vPrest');
        xmlNodeValue := xmlNode.ChildNodes.FindNode('vTPrest');
        fltVlrCon := fFloatXmlToFloat(xmlNodeValue.NodeValue);
        FvREC := 0;
        if blnLEVREC and (tpFrete = tpfEntrada) then
        begin
          xmlNodeValue := xmlNode.ChildNodes.FindNode('vRec');
          if Assigned(xmlNodeValue) then
            FvREC := fFloatXmlToFloat(xmlNodeValue.NodeValue);
        end;

        If blnImpVariosXml then
        begin
          If (Pos(FRemetente.strUF, '_AC_AL_AM_AP_BA_CE_DF_ES_GO_MA_MG_MS_MT_PA_PB_PE_PI_PR_RJ_RN_RO_RR_RS_SC_SE_SP_TO_') <= 0) Then
          Begin
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ESTADO DO REMETENTE ' + FRemetente.strUF + ' É INVALIDO. O DOCUMENTO DEVE SER LANÇADO MANUALMENTE NO LIVRO FISCAL, INFORMANDO CORRETAMENTE O ESTADO.', 0);
            Result := False;
            Exit;
          End;
        end;

        If FTomador.strCNPJ <> strCnpjEmpresaLogada Then
        Begin
          pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': O Tomador do CTE deve ser a empresa logada.', 0);
          Result := False;
          Exit;
        End
        Else
        Begin
          {TOMADOR: VALIDAR COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE). }
          If Not fValidaComparaTomadorComEmpresa() Then
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': O Divergências entre tomador e Empresa encotradas. CNPJ + UF + Código do Município', 0);
        End;

        strTransferenciaEmpOri := IIF(fEmptyStr(fRetEmpresaPeloCGCLocal(string(FDestinatario.strCNPJ))),
                                      fRetEmpresaPeloCGCLocal(string(FRecebedor.strCNPJ)),
                                      fRetEmpresaPeloCGCLocal(string(FDestinatario.strCNPJ)));

        strTransferenciaEmpDes := IIF(fEmptyStr(fRetEmpresaPeloCGCLocal(string(FRemetente.strCNPJ))),
                                                fRetEmpresaPeloCGCLocal(string(FEmitente.strCNPJ)),
                                                fRetEmpresaPeloCGCLocal(string(FRemetente.strCNPJ)));

        blnTransferencia  := (((fRetEmpresaPeloCGCLocal(string(FDestinatario.strCNPJ)) <> '')) Or (fRetEmpresaPeloCGCLocal(string(FRecebedor.strCNPJ)) <> '')) And
                             (((fRetEmpresaPeloCGCLocal(string(FRemetente.strCNPJ)) <> '')) Or (fRetEmpresaPeloCGCLocal(string(FEmitente.strCNPJ)) <> ''));

        FTransf := 'N';
        If blnTransferencia Then
          FTransf := 'S';


        // Se for transferencia e a empresa for diferente da emitente da a mensagem
        blnTomadorDestino := ((String(FTomador.strCNPJ) = string(FDestinatario.strCNPJ)) Or (String(FTomador.strCNPJ) = string(FRecebedor.strCNPJ)));
        If blnTransferencia Then
        Begin
          If((tpFrete = tpfSaida) And (blnTomadorDestino)) Then
          Begin
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Arquivo de transferencia deve ser importado pela rotina de Entrada(tomador é o destino).', 0);
            Result := False;
            Exit;
          End
          Else
          If((tpFrete = tpfEntrada) And (Not blnTomadorDestino)) Then
          Begin
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Arquivo de transferencia deve ser importado pela rotina de Saida(tomador não é o destino).', 0);
            Result := False;
            Exit;
          End;
        End;

        If Not fValidaPessoasCadastradasNoBanco then
        Begin
          Result := False;
          Exit;
        End;


        pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
        if not blnMod67 Then
          xmlNode := xmlNode.ChildNodes.FindNode('CTe');
        xmlNode := xmlNode.ChildNodes.FindNode('infCte');

        xmlNode := xmlNode.ChildNodes.FindNode('imp');
        xmlNode := xmlNode.ChildNodes.FindNode('ICMS');

        For intCorre := 0 To 6 Do
        Begin

          xmlNodeValue := xmlNode.ChildNodes.FindNode(arrChaves[intCorre]);
          If Assigned(xmlNodeValue) Then
          Begin
            Case intCorre Of
              0, //ICMS00
              1, // ICMS20 ICMS90
              3 : Begin
                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('vBC');
                    fltVlrBcI := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('pICMS');
                    fltAliIcm := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('vICMS');
                    fltVlrIcm := fFloatXmlToFloat(xmlNodeICMS.NodeValue);
                  End;

                  //ICMS60
              2 : Begin
                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('vBCSTRet');
                    fltBasSub := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('pICMSSTRet');
                    fltAliIcm := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('vICMSSTRet');
                    fltValRet := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                  End;

                  //ICMSOutraUF
              4 : Begin
                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('vBCOutraUF');
                    fltVlrBcI := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('pICMSOutraUF');
                    fltAliIcm := fFloatXmlToFloat(xmlNodeICMS.NodeValue);

                    xmlNodeICMS := xmlNodeValue.ChildNodes.FindNode('vICMSOutraUF');
                    fltVlrIcm := fFloatXmlToFloat(xmlNodeICMS.NodeValue);
                  End;

              5,  //ICMS45 ICMSSN(SIMPLES NACIONAL)
              6 : Begin
                    fltVlrBcI := 0;
                    fltAliIcm := 0;
                    fltVlrIcm := 0;
                  End;

            End;

            If blnImpClF Then
            Begin
              strClaFi1 := strClaFis;
              If Not fTemCfopCorrelataParaFrete(FClaFi1) Then
              Begin
                If LeftStr(strClaFi1, 1) = '5' Then
                  strClaFi1 := '1353'

                Else If LeftStr(strClaFi1, 1) = '6' Then
                  strClaFi1 := '2353'

                Else If (Not fEmptyStr(FCodTra)) And (fRetEstadoFornecedor(FCodTra) <> fRetEstadoEmpresa(FCodEmp)) Then
                  strClaFi1 := '2353'
                Else
                  strClaFi1 := '1353';
              End;
            End Else
            Begin
              If Not fTemCfopCorrelataParaFrete(FClaFi1) Then
              Begin
                If LeftStr(strClaFi1, 1) = '5' Then
                  strClaFi1 := '1353'

                Else If LeftStr(strClaFi1, 1) = '6' Then
                  strClaFi1 := '2353'

                Else If (Not fEmptyStr(FCodTra)) And (fRetEstadoFornecedor(FCodTra) <> fRetEstadoEmpresa(FCodEmp)) Then
                  strClaFi1 := '2353'
                Else
                  strClaFi1 := '1353';
              End;
            End;

            If blnClassificacaoEntrada Then
            Begin
              If Not fTemCfopCorrelataParaFrete(FClaFi1) Then
              Begin
                If LeftStr(strClaFi1, 1) = '5' Then
                  strClaFi1 := '1' + RightStr(strClaFi1, 3)
                Else If LeftStr(strClaFi1, 1) = '6' Then
                  strClaFi1 := '2' + RightStr(strClaFi1, 3);

              End;
            End;

            If Not FListaClaFis.Find(strClaFi1, intIndClaFis) Then
              FListaClaFis.Add(strClaFi1);

            If (FComplemento = '0') Or ((FComplemento = '1')And (fltVlrCon > 0)) Then
              strValCo1 := FloatToStr(fltVlrCon);

            If blnSimPau And blnEntradaDeMercadoria Then
            Begin
              fltVlrBcI := 0;
              fltAliIcm := 0;
              fltVlrIcm := 0;
            End;

            strBasIc1 := FloatToStr(fltVlrBcI);
            strAlqIc1 := FloatToStr(fltAliIcm);
            strValIc1 := FloatToStr(fltVlrIcm);
            strValOu1 := FloatToStr(fRetornaValorOutras(fltVlrCon, fltVlrBcI, 0, fltValRet, 0, 0, 0));
            strValIs1 := '0';
            strBasSu1 := FloatToStr(fltBasSub);
            strValRe1 := FloatToStr(fltValRet);
            strBasIp1 := '0';
            strValIp1 := '0';
            strDesAc1 := '0';
            strValIs1 := '0';

            Break;
          End;

        End;


        FValTot := (FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5);
        FValDoc := FValTot;

        Try
          Result := fValidaValores;

          If blnImpTransp And fEmptyStr(FCodTra) Then
          Begin
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Transportadora com CNPJ ' +  FCgcTra + ' não encontrada.', 0);
            Result := False;
          End;

          If (not blnMod67) And (blnImpVencimentos And fEmptyStr(FCndPag) And fEmptyStr(FCndVaz)) And (FblnGraCTP) Then
          Begin
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Arquivo sem vencimentos.', 0);
            Result := False;
          End;

        Except
          On E: Exception Do
          Begin
            pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + E.Message, 0);
            Result := False;
          End;
        End;

        If fVerificaDocumento Then
        Begin
          pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + ' já existe no sistema!', 0);
          FStatus := DOCUMENTO_JA_EXISTE;
          Result  := False;
        End
        Else
        Begin
          If Result Then
             pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' +
                                               'carregado com sucesso (Valor: '+FormatFloat('##,#.00', FValTot)+ ')!', 0);
        End;

        //Carregar o peso
        If not blnMod67 Then
        Begin
          pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
          If not blnMod67 Then
            xmlNode := xmlNode.ChildNodes.FindNode('CTe');
          xmlNode := xmlNode.ChildNodes.FindNode('infCte');
          strPesoBruto := '0';
          xmlNode := xmlNode.ChildNodes.FindNode('infCTeNorm');
          If Assigned(xmlNode) Then
          Begin
            xmlNodeCarga := xmlNode.ChildNodes.FindNode('infCarga');
            while Assigned(xmlNodeCarga)do
            Begin
              xmlNode  := xmlNodeCarga.ChildNodes.FindNode('infQ');
              While Assigned(xmlNode)do
              Begin
                If Assigned(xmlNode) Then
                Begin
                  xmlNodeValue  := xmlNode.ChildNodes.FindNode('tpMed');
                  If Assigned(xmlNodeValue) Then
                  Begin
                    If MatchStr(UpperCase(string(xmlNodeValue.NodeValue)), ['PESO BRUTO','PESO TAXADO','PESO BASE DE CALCULO']) Then
                    Begin
                      xmlNodeValue  := xmlNode.ChildNodes.FindNode('qCarga');
                      strPesoBruto :=  StringReplace(string(xmlNodeValue.NodeValue), '.', ',', [])
                     End;
                  End;
                End;
                xmlNode := xmlNode.NextSibling;
              End;
             xmlNodeCarga := xmlNodeCarga.NextSibling;
            End;
          End;
        End;

        //Carregar notas fisais anexadas ao Cte.
        If not blnMod67 Then
        Begin
          Try
             pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
             If not blnMod67 Then
               xmlNode := xmlNode.ChildNodes.FindNode('CTe');
             xmlNode := xmlNode.ChildNodes.FindNode('infCte');

             xmlNode := xmlNode.ChildNodes.FindNode('infCTeNorm');
             If Assigned(xmlNode) Then
             Begin

               xmlNode := xmlNode.ChildNodes.FindNode('infDoc');
               xmlNodeNfe := xmlNode.ChildNodes.FindNode('infNFe');
               If Not Assigned(xmlNodeNfe) then
                  xmlNodeNfe := xmlNode.ChildNodes.FindNode('infNF');
               If Not Assigned(xmlNodeNfe) then
               Begin
                  xmlNodeNfe := xmlNode.ChildNodes.FindNode('infOutros');
//                blnInfOutros := True;
               End;

               If not Assigned(xmlNodeNfe) then
               begin
                 xmlNodeNfe := xmlNode.ChildNodes.FindNode('infDCe');
                 If Assigned(xmlNodeNfe) then
                   FIsDocDCe := True;
               end;


             End
             Else
             Begin
               pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
               If not blnMod67 Then
                 xmlNode := xmlNode.ChildNodes.FindNode('CTe');
               xmlNode := xmlNode.ChildNodes.FindNode('infCte');
               xmlNodeNfe := xmlNode.ChildNodes.FindNode('infCteComp');
             End;


          Except
            On E: Exception Do
            Begin
              pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Estrutura Inválida', 0);
              Result := False;
            End;
          End;

          If Not Assigned(xmlNodeNfe) then
            raise Exception.Create('XML com estrutura inválida para importação não foi possível identificar tags <infNF>, <infNFe>' + IIf(blnImpCTeComDCe, ', <infDCe>', '') +' ou <infOutros>');
          If FIsDocDCe and (not blnImpCTeComDCe) then
            raise Exception.Create('O documento foi identificado como DC-e; porém, a flag de permissão para importação não foi marcada.');


          strErro := '';
          If FIsDocDCe then
          begin
            If tpFrete = tpfSaida then
              FtpDocFrete :=  tpdfVenda
            else
              FtpDocFrete :=  tpdfCompra;
          end
          Else
            FtpDocFrete := fRetonarTipoDeFrete(strErro);

          If (Not blnTransferencia) Then
          Begin
            case FtpDocFrete of
              tpdfCompra,
              tpdfDevolucaoVenda : If (tpFrete = tpfSaida) Then
                                   Begin
                                     pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ' foi identificado como um frete de '+fRetDescricaoTipoFrete(FtpDocFrete)+',  Arquivo deve ser importado pela rotina de entrada.', 0);
                                     Result := False;
                                     Exit;
                                   End;
              tpdfVenda,
              tpdfDevolucaoCompra: If (tpFrete = tpfEntrada) Then
                                   Begin
                                     pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ' foi identificado como um frete de '+fRetDescricaoTipoFrete(FtpDocFrete)+', Arquivo deve ser importado pela rotina de saída.', 0);
                                     Result := False;
                                     Exit;
                                   End;
            End;
          End;

          { Precisa validar se Devolução, pois pode ocorrer de ter o CNPJ como Fornecedor e como Cliente}
          If (FtpDocFrete = tpdfCompra) Then
          Begin
            If (xmlNodeNfe.NodeName = 'infNFe') Then
            Begin
              xmlNodeValue  := xmlNodeNfe.ChildNodes.FindNode('chave');
              If Assigned(xmlNodeValue) Then
              Begin
                strChaveNotaFiscal := string(xmlNodeValue.NodeValue);
                If (Not fEmptyStr(strChaveNotaFiscal)) Then
                Begin
                   If fDocumentoReferenciadoNoCTeEhDevolucaDeVenda(strChaveNotaFiscal) Then
                    FtpDocFrete := fValidaPessoasDevolucao(strErro);
                End;
              End;
            End;
          End
          { Precisa validar como Devolução de compra, pois pode ocorrer de ter o cadastro do fornecedor como cliente }
          Else
          Begin
            If (xmlNodeNfe.NodeName = 'infNFe') or FIsDocDCe Then
            Begin
              xmlNodeValue  := xmlNodeNfe.ChildNodes.FindNode('chave');
              If Assigned(xmlNodeValue) Then
              Begin
                strChaveNotaFiscal := string(xmlNodeValue.NodeValue);
                If not FIsDocDCe then
                begin
                  If (Not fEmptyStr(strChaveNotaFiscal)) Then
                  Begin
                     If fDocumentoReferenciadoNoCTeEhDevolucaDeCompra(strChaveNotaFiscal) Then
                      FtpDocFrete := fValidaPessoasDevolucaoCompra(strErro);
                  End;
                End;
              end;
            End;
          End;

          If (FtpDocFrete = tpdfIndefinido) Or (strErro <> '')  Then
          Begin
            Result := False;
            If (FtpDocFrete = tpdfIndefinido) Then
            begin
              pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Não foi possível identificar se o CTE é de Compra, Venda ou Devolução de Venda', 0);
              If strErro <> '' Then
              Begin
                pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + strErro, 0);
                pEscreveMensagemImportacao(memLog, 'Clique em ''?'' para obter mais informações!');
              End;
            End
            Else
            Begin
              If strErro <> '' Then
                pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + strErro, 0)
              Else
                pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Não foi possível indentificar o movimento da CTE.', 0)
            End;
          End;

          If Not fValidarUFsPessoas(strErro) Then
          Begin
            pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + strErro, 0);
          End;

          blnEncontrouNotaQueNaoEhBrinde := False;
          blnValidouNotas := False;

          If not FIsDocDCe then
          begin
            While Assigned(xmlNodeNfe) Do
            Begin
              cdsNotasFiscais.Insert;
              cdsNotasFiscais.FieldByName('CTE_ACESSO').AsString := FAcesso;
              cdsNotasFiscais.FieldByName('CTE_MARCAD').AsString := 'N';
              If (xmlNodeNfe.NodeName = 'infNF') Or (xmlNodeNfe.NodeName = 'infNFe') Or (xmlNodeNfe.NodeName = 'infOutros') then
              Begin
                Try
                  //Quebrar dados da NFE pela chave de acesso
                  If (xmlNodeNfe.NodeName = 'infNFe') Then
                  Begin
                    xmlNodeValue  := xmlNodeNfe.ChildNodes.FindNode('chave');
                    cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString := string(xmlNodeValue.NodeValue);
                    If cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString <> '' Then
                    Begin
                      strErro := '';
                      If fRetAutoincremCadFis(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString) = '' Then
                      Begin
                        pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Não foi encontrada a Chave de Acesso no Livro Fiscal' +
                                                 cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 0);
                        blnNotaNaoIdentificada := True;
                      End
                      Else
                      begin
                        blnValidouNotas := True;
                        If Not fValidaChaveAcessoAnexa(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, strErro, strCfopNFE) Then
                        Begin
                          Result := False;
                          pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + strErro, 0)
                        End;
                        If (Pos(fCfgSis('CLABRI'), strCfopNFE) = 0) And (Not blnEncontrouNotaQueNaoEhBrinde)  Then
                          blnEncontrouNotaQueNaoEhBrinde  := True;
                      End;

                      cdsNotasFiscais.FieldByName('NFE_NUMDOC').AsString := fStrZero(Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 26, 9), fTamNumDoc);
                      cdsNotasFiscais.FieldByName('NFE_SERIE_').AsString := Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 23, 3);
                      cdsNotasFiscais.FieldByName('NFE_CNPJ__').AsString := fFormatCNPJ(Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 7, 14));
                    End;
                  End
                  Else If xmlNodeNfe.NodeName = 'infOutros' then
                  Begin
                    xmlNode := xmlNodeNfe.ChildNodes.FindNode('nDoc');
                    If Assigned(xmlNode) Then
                      cdsNotasFiscais.FieldByName('OUT_NUMDOC').AsString := fStrZero(string(xmlNode.NodeValue), fTamNumDoc);

                    xmlNode := xmlNodeNfe.ChildNodes.FindNode('tpDoc');
                    If Assigned(xmlNode) Then
                      cdsNotasFiscais.FieldByName('OUT_TIPDOC').AsString := string(xmlNode.NodeValue);

                    xmlNode := xmlNodeNfe.ChildNodes.FindNode('descOutros');
                    If Assigned(xmlNode) Then
                      cdsNotasFiscais.FieldByName('OUT_DESCRI').AsString := string(xmlNode.NodeValue);

                    cdsNotasFiscais.FieldByName('DESTINATARIO').AsString := string(FDestinatario.strCNPJ);
                    cdsNotasFiscais.FieldByName('FIS_ESPDOC').AsString := 'NF';
                    cdsNotasFiscais.FieldByName('FIS_CODEMP').AsString := VS_StrCodEmp;
                  End

                  Else
                  Begin
                    xmlNode := xmlNodeNfe.ChildNodes.FindNode('serie');
                    cdsNotasFiscais.FieldByName('NFE_SERIE_').AsString := string(xmlNode.NodeValue);
                    xmlNode := xmlNodeNfe.ChildNodes.FindNode('nDoc');
                    cdsNotasFiscais.FieldByName('NFE_NUMDOC').AsString := fStrZero(string(xmlNode.NodeValue), fTamNumDoc);
                  End;
                except
                  raise Exception.Create('XML com estrutura inválida para importação não foi impossível identificar tags <serie> ou <nDoc>');
                end;
              End
              Else
              Begin
                xmlNodeValue  := xmlNodeNfe.ChildNodes.FindNode('chave');
                If Not Assigned(xmlNodeValue) Then
                Begin
                  xmlNodeValue := xmlNodeNfe.ChildNodes.FindNode('chCTe');
                  If Assigned(xmlNodeValue) Then
                  Begin
                    cdsComplementos.Insert;

                    cdsComplementos.FieldByName('COM_CTEORI').AsString := fRetAutoincremCadFis(string(xmlNodeValue.NodeValue));

                    If Not fVerificaQuantidadeDeComplementos(cdsComplementos.FieldByName('COM_CTEORI').AsString) Then
                    Begin
                       cdsComplementos.Cancel;
                       raise Exception.Create('O Cte referenciado já tem 10 complementos anexado.');
                    End;

                    If cdsComplementos.FieldByName('COM_CTEORI').AsString = '' Then
                    Begin
                       cdsComplementos.Cancel;
                       raise Exception.Create('O Conhecimento referênciado neste CTE não foi encontrado no livro fiscal.');
                    End;

                    cdsComplementos.FieldByName('COM_CTECOM').AsString := '';
                    cdsComplementos.FieldByName('COM_CHAVE_').AsString := strAcesso;
                    cdsComplementos.FieldByName('ORI_CHAVE_').AsString := string(xmlNodeValue.NodeValue);

                    cdsComplementos.Post;
                    blnSoComplemento := True;
                  End;
                End;

                If Not Assigned(xmlNodeValue) Then
                  raise Exception.Create('XML com estrutura inválida para importação não foi impossível identificar tags <chave> ou <chCTe>');

                If Not blnSoComplemento Then
                  cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString := string(xmlNodeValue.NodeValue);
                //Quebrar dados da NFE pela chave de acesso
                If cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString <> '' Then
                Begin
                  cdsNotasFiscais.FieldByName('NFE_NUMDOC').AsString := fStrZero(Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 26, 9), fTamNumDoc);
                  cdsNotasFiscais.FieldByName('NFE_SERIE_').AsString := Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 23, 3);
                  cdsNotasFiscais.FieldByName('NFE_CNPJ__').AsString := fFormatCNPJ(Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 7, 14));
                End;
              End;

              If blnSoComplemento Then
              Begin
                cdsNotasFiscais.Cancel;
                Break;
              End;



              xmlNodeNfe := xmlNodeNfe.NextSibling;
              cdsNotasFiscais.Post;
            End;
          end;
        End;
      End;

      If Result And blnValidouNotas And (Not blnEncontrouNotaQueNaoEhBrinde) And (tpFrete = tpfSaida) Then
        FBrinde := '1'
      Else
        FBrinde := '0';

    Except
      On E: Exception Do
      Begin
        Result := False;
        pEscreveMensagemImportacao(memErr, 'Erro: ' + E.Message, 0);
      End;
    End;
  Finally
    FreeAndNil(xmlDoc);
    If Assigned(qryConCta) Then
      FreeAndNil(qryConCta);
  End;
end;

Function TFreCon.fCarregaArquivos(strArquivo: String; blnClassificaoEntrada, blnEntradaMercadoria: Boolean; blnImpVencimentos: Boolean): Boolean;
Begin
  Result := False;
  qryTabela.EmptyDataSet;

  If fAbreXml(strArquivo, blnClassificaoEntrada, blnEntradaMercadoria, blnImpVencimentos) Then
  Begin
    With qryTabela Do
    Begin
      Append;
      FieldByName('IMPORT').AsString := 'S';
      FieldByName('NOMARQ').AsString := strArquivo;
      FieldByName('ARQUIV').AsString := strArquivo;
      FStrArquivoXml := strArquivo;
      Post;
    End;
    If fXmlToBanco(nil) Then
    Begin
      Result := True;
    End;
  End;
End;

class function TFreCon.fCarregaCTESAnteriores(strDoc, strEsp, strEmp, strSer, strFor: String): TZClient;
begin
  Result := TZClient.Create(Nil);
  Result.qryQuery.SQL.Add('SELECT "CONFRE" AS ORIGEM, CADFIS.FIS_NUMDOC, FIS_ESPDOC, FIS_FORCLI, FIS_SERIE_, CADFIS.AUTOINCREM AS AUTFIS,  CONFRE.CON_SEQGER AUTGER FROM CADFIS');
  Result.qryQuery.SQL.Add(' INNER JOIN CONFRE ON CON_SEQFIS = CADFIS.AUTOINCREM');
  Result.qryQuery.SQL.Add(' INNER JOIN MOVGER ON MOVGER.AUTOINCREM = CONFRE.CON_SEQGER');
  Result.qryQuery.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
  Result.qryQuery.SQL.Add('   AND  GER_ESPDOC = :ESPDOC');
  Result.qryQuery.SQL.Add('   AND GER_CODEMP = :CODEMP');
  Result.qryQuery.SQL.Add('   AND  GER_CODFOR = :CODFOR');
  Result.qryQuery.SQL.Add('   AND  IFNULL(GER_SERIE_, "") = :SERIE_');
  Result.qryQuery.SQL.Add(' UNION ALL');
  Result.qryQuery.SQL.Add('SELECT "RECTNF_GER"AS ORIGEM, CADFIS.FIS_NUMDOC, FIS_ESPDOC, FIS_FORCLI, FIS_SERIE_, CADFIS.AUTOINCREM AS AUTFIS, RECTNF.REC_MOVSEQ AUTGER FROM CADFIS');
  Result.qryQuery.SQL.Add(' INNER JOIN RECTNF ON REC_CTESEQ = CADFIS.AUTOINCREM');
  Result.qryQuery.SQL.Add(' INNER JOIN MOVGER ON MOVGER.AUTOINCREM = RECTNF.REC_MOVSEQ');
  Result.qryQuery.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
  Result.qryQuery.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
  Result.qryQuery.SQL.Add('   AND GER_CODEMP = :CODEMP');
  Result.qryQuery.SQL.Add('   AND GER_CODFOR = :CODFOR');
  Result.qryQuery.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');
  Result.qryQuery.SQL.Add(' UNION ALL');
  Result.qryQuery.SQL.Add('SELECT "RECTNF_NOT"AS ORIGEM, CADFIS.FIS_NUMDOC, FIS_ESPDOC, FIS_FORCLI, FIS_SERIE_,CADFIS.AUTOINCREM AS AUTFIS,RECTNF.REC_NOTSEQ AUTGER FROM CADFIS');
  Result.qryQuery.SQL.Add(' INNER JOIN RECTNF ON REC_CTESEQ = CADFIS.AUTOINCREM');
  Result.qryQuery.SQL.Add(' INNER JOIN NOTGER ON NOTGER.AUTOINCREM = RECTNF.REC_NOTSEQ');
  Result.qryQuery.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
  Result.qryQuery.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
  Result.qryQuery.SQL.Add('   AND GER_CODEMP = :CODEMP');
  Result.qryQuery.SQL.Add('   AND GER_CODFOR = :CODFOR');
  Result.qryQuery.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');
  Result.qryQuery.ParamByName('NUMDOC').AsString := strDoc;
  Result.qryQuery.ParamByName('ESPDOC').AsString := strEsp;
  Result.qryQuery.ParamByName('CODEMP').AsString := strEmp;
  Result.qryQuery.ParamByName('CODFOR').AsString := strFor;
  Result.qryQuery.ParamByName('SERIE_').AsString := strSer;
  Result.fAbreClient(true, 'TFreCon.fCarregaCTESAnteriores');
end;

 function TFreCon.fCarregaDadosCTe(memLog, memErr: TStrings; blnClassificacaoEntrada: Boolean): Boolean;
var
  fltVlrCon,
  fltVlrBcI,
  fltAliIcm,
  fltVlrIcm  : Double;

  fltValRet: Double;
  fltBasSub: Double;

  strClaFis: String;
  intIndClaFis: Integer;
  strClaTri: string;
begin
  Try
    FStatus := IMPORTADO_OK;

    FCodTra := '';
    FCndPag := '';

    FCodMunicipioInicio:= '';
    FMunicipioDescricaoInicio:= '';
    FCodMunicipioFim:= '';
    FMunicipioDescricaoFim:= '';
    FUFInicio := '';
    FUFFim    := '';


    fltVlrBcI := 0;
    fltAliIcm := 0;
    fltVlrIcm := 0;

    fltValRet := 0;
    fltBasSub := 0;

    strAcesso := qryCTes.FieldByName('CTE_ACESSO').AsString;

    FTomSer := '';
    FForPag := '';
    FCGCDes := '';
    FTomSer := LeftStr(qryCTes.FieldByName('CTE_TOMSER').AsString, 1);

    If (tpFrete = tpfSaida) Then
    begin
      FCodEmp := qryCTes.FieldByName('CTE_CODEMP').AsString;
      FCGCDes := qryCTes.FieldByName('DESTINATARIO_CNPJ').AsString;
      FCndPag := qryCTes.FieldByName('CTE_CNDREC').AsString;
    end
    else
    begin
      FCodEmp := qryCTes.FieldByName('CTE_CODEMP').AsString;
      pTomadorEEmpresaCadastrada(IIF(FTomSer = '0', qryCTes.FieldByName('REMETENTE_CNPJ').AsString, qryCTes.FieldByName('DESTINATARIO_CNPJ').AsString), FEmpresaPagadora);
      FCndPag := qryCTes.FieldByName('CTE_CNDPAG').AsString;
    end;

    FCGCRem := qryCTes.FieldByName('REMETENTE_CNPJ').AsString;

    FCgcTra := qryCTes.FieldByName('EMITENTE_CNPJ').AsString;
    FCodTra := fRetCodFornecedorPorCnpj(FCgcTra);

    strEspDoc := 'CT';
    pCarregaPessoasBco();
    strNumDoc := fStrZero(qryCTes.FieldByName('CTE_NUMCTE').AsString, fTamNumDoc);

    strClaFis := qryCTes.FieldByName('CTE_CFOP__').AsString;

    strSerie_ := qryCTes.FieldByName('CTE_SERIE_').AsString;

    FModFre := '1';
    FDtaDoc := qryCTes.FieldByName('CTE_DTAEMI').AsDateTime;

    fltVlrCon := qryCTes.FieldByName('CTE_VLRFRE').AsFloat;

    strClaTri := LeftStr(qryCTes.FieldByName('CTE_CLATRI').AsString, 2);

    if (Pos(strClaTri, '00_20_90_') > 0) then
    begin
      fltVlrBcI := qryCTes.FieldByName('CTE_VLRBCI').AsFloat;
      fltAliIcm := qryCTes.FieldByName('CTE_ALIQUO').AsFloat;
      fltVlrIcm := qryCTes.FieldByName('CTE_VLRIMP').AsFloat;
    end;

    if (strClaTri = '60') then
    begin
      fltBasSub := qryCTes.FieldByName('CTE_VLRBCI').AsFloat;
      fltAliIcm := qryCTes.FieldByName('CTE_ALIQUO').AsFloat;
      fltValRet := qryCTes.FieldByName('CTE_VLRIMP').AsFloat;
    end;

    strClaFi1 := strClaFis;

    If blnClassificacaoEntrada Then
    Begin
      If Not fTemCfopCorrelataParaFrete(FClaFi1) Then
      Begin
        If LeftStr(strClaFi1, 1) = '5' Then
          strClaFi1 := '1' + RightStr(strClaFi1, 3)
        Else If LeftStr(strClaFi1, 1) = '6' Then
          strClaFi1 := '2' + RightStr(strClaFi1, 3);

      End;
    End;

    If Not FListaClaFis.Find(strClaFi1, intIndClaFis) Then
      FListaClaFis.Add(strClaFi1);

    strValCo1 := FloatToStr(fltVlrCon);
    strBasIc1 := FloatToStr(fltVlrBcI);
    strAlqIc1 := FloatToStr(fltAliIcm);
    strValIc1 := FloatToStr(fltVlrIcm);
    strValOu1 := FloatToStr(fRetornaValorOutras(fltVlrCon, fltVlrBcI, 0, fltValRet, 0, 0, 0));
    strValIs1 := '0';
    strBasSu1 := FloatToStr(fltBasSub);
    strValRe1 := FloatToStr(fltValRet);
    strBasIp1 := '0';
    strValIp1 := '0';
    strDesAc1 := '0';
    strValIs1 := '0';

    FValTot := (FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5);
    FValDoc := FValTot;

    Try
      Result := fValidaValores;

      If fEmptyStr(FCodTra) Then
      Begin
        pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Transportadora com CNPJ ' +  FCgcTra + ' não encontrada.', 0);
        Result := False;
      End;

      If fEmptyStr(FCndPag) And fEmptyStr(FCndVaz) Then
      Begin
        pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': Arquivo sem vencimentos.', 0);
        Result := False;
      End;

    Except
      On E: Exception Do
      Begin
        pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + E.Message, 0);
        Result := False;
      End;
    End;

    If fVerificaDocumento Then
    Begin
      pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + ' já existe no sistema!', 0);
      FStatus := DOCUMENTO_JA_EXISTE;
      Result  := False;
    End
    Else
    Begin
      If Result Then
         pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' +
                                           'carregado com sucesso (Valor: '+FormatFloat('##,#.00', FValTot)+ ')!', 0);
    End;

    //Carregar notas fiscais (nfe) anexadas ao Cte.

    //Quando Entrada não fazer o vinculo com pedido de venda
    If (tpFrete = tpfSaida) Then
    Begin
      cdsNotasFiscais.Insert;
      cdsNotasFiscais.FieldByName('CTE_ACESSO').AsString := FAcesso;
      cdsNotasFiscais.FieldByName('CTE_MARCAD').AsString := 'S';
      cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString := qryCTes.FieldByName('FIS_ACESSO').AsString;
      cdsNotasFiscais.FieldByName('NFE_NUMDOC').AsString := qryCTes.FieldByName('GER_NUMDOC').AsString; //fStrZero(Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 26, 9), fTamNumDoc);
      cdsNotasFiscais.FieldByName('NFE_SERIE_').AsString := qryCTes.FieldByName('GER_SERIE_').AsString; //Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 23, 3);
      cdsNotasFiscais.FieldByName('NFE_CNPJ__').AsString := qryCTes.FieldByName('REMETENTE_CNPJ').AsString; //fFormatCNPJ(Copy(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString, 7, 14));
      cdsNotasFiscais.Post;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pEscreveMensagemImportacao(memErr, 'Erro: ' + E.Message, 0);
      pGravarErro(True, 'Erro: ' + E.Message, 'TFreCon.fCarregaDadosCTe');
    End;
  End;
end;

function TFreCon.fCarregaArquivos(strPath, strExtensao: String): Boolean;
  Var
    srcArquivo: TSearchRec;
    intAchou  : Integer;
Begin
  Result := True;
  If RightStr(strPath,1) <> '\' Then
    strPath := strPath + '\';

  qryTabela.EmptyDataSet;
  intAchou := FindFirst(strPath + '*.XML', faArchive, srcArquivo);
  FStrPath := strPath;
  cdsNotasFiscais.EmptyDataSet;
  cdsComplementos.EmptyDataSet;
  Try
    If intAchou = 0 then
    Begin
      Repeat
        With qryTabela Do
        Begin
          Append;
          FieldByName('IMPORT').AsString := 'S';
          FieldByName('NOMARQ').AsString := srcArquivo.Name;
          FieldByName('ARQUIV').AsString := strPath+srcArquivo.Name;
          FStrArquivoXml := strPath+srcArquivo.Name;
          Post;
        End;
      Until FindNext(srcArquivo) <> 0;

      Result := True;
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fCarregaArquivos]');
    End;
  End;

end;

function TFreCon.fValidaValores: Boolean;
  Var
    strMensagem : String;
begin

  Result := True;

  If (FComplemento = '1') Then
    Exit();

  If fEmptyStr(strClaFi1 + strClaFi2 + strClaFi3 + strClaFi4 + strClaFi5) Then
  Begin
    strMensagem := 'Nenhuma coluna de classificação Fiscal foi preenchida !';
    Result := False;
  End

  Else If fFormataFloat(fStrToFloat(strBasIc1) +
                        fStrToFloat(strValIp1) +
                        fStrToFloat(strValRe1) +
                        fStrToFloat(strValIs1) +
                        fStrToFloat(strValOu1),2) <> fFormataFloat(fStrToFloat(strValCo1),2) Then
  Begin
    strMensagem := 'Divergência de valores (Vr. Contábil 1 = Base ICMS 1 + Vr.IPI 1 + Valor ICMS Sub 1 + Vr. Isentas 1 + Vr. Outras 1)';
    Result := False;
  End

  Else If fFormataFloat(fStrToFloat(strBasIc2) +
                        fStrToFloat(strValIp2) +
                        fStrToFloat(strValRe2) +
                        fStrToFloat(strValIs2) +
                        fStrToFloat(strValOu2),2) <> fFormataFloat(fStrToFloat(strValCo2),2) Then
  Begin
    strMensagem := 'Divergência de valores (Vr. Contábil 2 = Base ICMS 2 + Vr.IPI 2 + Valor ICMS Sub 2 + Vr. Isentas 2 + Vr. Outras 2)';
    Result := False;
  End

  Else If fFormataFloat(fStrToFloat(strBasIc3) +
                        fStrToFloat(strValIp3) +
                        fStrToFloat(strValRe3) +
                        fStrToFloat(strValIs3) +
                        fStrToFloat(strValOu3),2) <> fFormataFloat(fStrToFloat(strValCo3),2) Then
  Begin
    strMensagem := 'Divergência de valores (Vr. Contábil 3 = Base ICMS 3 + Vr.IPI 3 + Valor ICMS Sub 3 + Vr. Isentas 3 + Vr. Outras 3)';
    Result := False;
  End

  Else If fFormataFloat(fStrToFloat(strBasIc4) +
                        fStrToFloat(strValIp4) +
                        fStrToFloat(strValRe4) +
                        fStrToFloat(strValIs4) +
                        fStrToFloat(strValOu4),2) <> fFormataFloat(fStrToFloat(strValCo4),2) Then
  Begin
    strMensagem := 'Divergência de valores (Vr. Contábil 4 = Base ICMS 4 + Vr.IPI 4 + Valor ICMS Sub 4 + Vr. Isentas 4 + Vr. Outras 4)';
    Result := False;
  End

  Else If fFormataFloat(fStrToFloat(strBasIc5) +
                        fStrToFloat(strValIp5) +
                        fStrToFloat(strValRe5) +
                        fStrToFloat(strValIs5) +
                        fStrToFloat(strValOu5),2) <> fFormataFloat(fStrToFloat(strValCo5),2) Then
  Begin
    strMensagem := 'Divergência de valores (Vr. Contábil 5 = Base ICMS 5 + Vr.IPI 5 + Valor ICMS Sub 5 + Vr. Isentas 5 + Vr. Outras 5)';
    Result := False;
  End

  Else If (fStrToFloat(strValCo1) <> 0.0) And (fEmptyStr(strClaFi1)) Then
  Begin
    strMensagem := 'Possui valores, porém não possui código da Classificação Fiscal 1 !';
    Result := False;
  End

  Else If (fStrToFloat(strValCo2) <> 0.0) And (fEmptyStr(strClaFi2)) Then
  Begin
    strMensagem := 'Possui valores, porém não possui código da Classificação Fiscal 2 !';
    Result := False;
  End

  Else If (fStrToFloat(strValCo3) <> 0.0) And (fEmptyStr(strClaFi3)) Then
  Begin
    strMensagem := 'Possui valores, porém não possui código da Classificação Fiscal 3 !';
    Result := False;
  End

  Else If (fStrToFloat(strValCo4) <> 0.0) And (fEmptyStr(strClaFi4)) Then
  Begin
    strMensagem := 'Possui valores, porém não possui código da Classificação Fiscal 4 !';
    Result := False;
  End

  Else If (fStrToFloat(strValCo5) <> 0.0) And (fEmptyStr(strClaFi5)) Then
  Begin
    strMensagem := 'Possui valores, porém não possui código da Classificação Fiscal 6 !';
    Result := False;
  End;

  If Not Result Then
    Raise Exception.Create(strMensagem);

end;

{***********************************************}
{* VERIFICA SE DOCUMENTO EXISTE NO LIVRO E CTP *}
{* RESULTA TRUE SE EXISTIR                     *}
{********************************************AF*}
function TFreCon.fVerificaDocumento: Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try
    Result := True;
    qryGen := fCriaQuery;
    If FNumDoc = '' Then
      Exit(False);
    If FEspDoc = '' Then
      Exit(False);
    If FCodEmp = '' Then
      Exit(False);
    If FSerie_ = '' Then
      Exit(False);
    If FCodTra = '' Then
      Exit(False);
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT       ');
      SQL.Add('  FIS_NUMDOC ');
      SQL.Add('FROM         ');
      SQL.Add('  CADFIS     ');
      SQL.Add('WHERE        ');
      SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
      SQL.Add('  FIS_CODEMP = :CODEMP AND ');
      SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ AND ');
      SQL.Add('  FIS_FORCLI = :CODFOR AND ');
      SQL.Add('  FIS_TIP_FC = "F"         ');

      ParamByName('NUMDOC').AsString := FNumDoc;
      ParamByName('ESPDOC').AsString := FEspDoc;
      ParamByName('CODEMP').AsString := FCodEmp;
      ParamByName('SERIE_').AsString := FSerie_;
      ParamByName('CODFOR').AsString := FCodTra;
      Open;

      If IsEmpty Then
        Result := False;

      Close;
    End;

    If Not Result Then
    Begin

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT       ');
        SQL.Add('  CTP_NUMDUP ');
        SQL.Add('FROM         ');
        SQL.Add('  CADPAG     ');
        SQL.Add('WHERE        ');
        SQL.Add('  CTP_NUMDUP = :NUMDUP AND ');
        SQL.Add('  CTP_CODEMP = :CODEMP AND ');
        SQL.Add('  IFNULL(CTP_SERIE_, "") = :SERIE_ AND ');
        SQL.Add('  CTP_CODFOR = :CODFOR     ');

        ParamByName('NUMDUP').AsString := FNumDoc;
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('SERIE_').AsString := FSerie_;
        ParamByName('CODFOR').AsString := FCodTra;
        Open;

        If IsEmpty Then
          Result := False;

        Close;
      End;

    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function TFreCon.fVerificaQuantidadeDeComplementos(strCte: String): Boolean;
var qryConsulta: TUniQuery;
begin
  If strCte = '' Then
    Exit(True);

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD');
    qryConsulta.SQL.Add('  FROM CTECOM');
    qryConsulta.SQL.Add(' WHERE COM_CTECOM = "'+strCte+'"');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger < 10;
  Finally
    FreeAndNil(qryConsulta)
  End;
end;

function TFreCon.fVerificaTemRelacionamentoCTEcomDoc(strAutoIncremCTE, strGerSeq, strCampo: string): boolean;
var
  qryRecTNF: TUniQuery;
begin
  Result := False;

  if (not blnImportaPeloBancoDados) then
    Exit;

  qryRecTNF := fCriaQuery;

  try
    qryRecTNF.SQL.Add('SELECT * FROM RECTNF');
    qryRecTNF.SQL.Add('WHERE REC_CTESEQ = :CTESEQ AND ');
    qryRecTNF.SQL.Add('    REC_' + strCampo + ' = :GERSEQ ');

    qryRecTNF.ParamByName('CTESEQ').AsString := strAutoIncremCTE;
    qryRecTNF.ParamByName('GERSEQ').AsString := strGerSeq;
    qryRecTNF.Open;

    Result := not qryRecTNF.IsEmpty;
  finally
    FreeAndNil(qryRecTNF);
  end;
end;

procedure TFreCon.setClaFi1(const Value: String);
  Var
    strMensagem: String;
begin

  If Not fEmptyStr(Value) Then
  Begin

    strMensagem := '';

    If fVerificaClaFisExisteEst(Value,strEstTra,strMensagem) Then
      FClaFi1 := Value
    Else
      Raise Exception.Create(strMensagem);
  End
  Else
  Begin
    FClaFi1 := '';
    Raise Exception.Create('Informe a Classificação Fiscal!');
  End;

end;

procedure TFreCon.setClaFi2(const Value: String);
  Var
    strMensagem: String;
begin

  If Not fEmptyStr(Value) Then
  Begin

    strMensagem := '';

    If fVerificaClaFisExisteEst(Value,strEstTra,strMensagem) Then
      FClaFi2 := Value
    Else
      Raise Exception.Create(strMensagem);
  End
  Else
    FClaFi2 := '';

end;

procedure TFreCon.setClaFi3(const Value: String);
  Var
    strMensagem: String;
begin

  If Not fEmptyStr(Value) Then
  Begin

    strMensagem := '';

    If fVerificaClaFisExisteEst(Value,strEstTra,strMensagem) Then
      FClaFi3 := Value
    Else
      Raise Exception.Create(strMensagem);
  End
  Else
    FClaFi3 := '';

end;

procedure TFreCon.setClaFi4(const Value: String);
  Var
    strMensagem: String;
begin

  If Not fEmptyStr(Value) Then
  Begin

    strMensagem := '';

    If fVerificaClaFisExisteEst(Value,strEstTra,strMensagem) Then
      FClaFi4 := Value
    Else
      Raise Exception.Create(strMensagem);
  End
  Else
    FClaFi4 := '';

end;

procedure TFreCon.setClaFi5(const Value: String);
  Var
    strMensagem: String;
begin

  If Not fEmptyStr(Value) Then
  Begin

    strMensagem := '';

    If fVerificaClaFisExisteEst(Value,strEstTra,strMensagem) Then
      FClaFi5 := Value
    Else
      Raise Exception.Create(strMensagem);
  End
  Else
    FClaFi5 := '';

end;

procedure TFreCon.setClaFiXML(const Value: String);
begin
  FClaFiXML := Value;
end;

procedure TFreCon.setCndPag(const Value: String);
begin

  If fEmptyStr(Value) Then
    Raise Exception.Create('Condição de pagamento deve ser preenchida!')
  Else
    FCndPag := Value;
end;

{*****************************************}
{* VERIFICA SE TEM FRETE DE CONHECIMENTO *}
{**************************************AF*}
class function TFreCon.fTemFreConhecimento(strDoc, strEsp, strEmp, strSer, strFor: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '    REC_CTESEQ,CON_SEQGER,GER_NUMDOC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER G ';
  strSQL := strSQL + 'LEFT JOIN CONFRE ON CON_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + 'LEFT JOIN RECTNF ON REC_CTESEQ = G.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  GER_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := strDoc;
    ParamByName('ESPDOC').AsString := strEsp;
    ParamByName('CODEMP').AsString := strEmp;
    ParamByName('CODFOR').AsString := strFor;
    ParamByName('SERIE_').AsString := strSer;

    Open;

    Result := (qryGen.FieldByName('REC_CTESEQ').AsString <> '') Or (qryGen.FieldByName('CON_SEQGER').AsString <> '');

    Close;
  End;

  FreeAndNil(qryGen);
end;


function TFreCon.fTodas_Notas_CTE_Vinculadas_Com_Documento(strChaveCte: String): boolean;
begin
  cdsNotasFiscais.Filtered := False;
  cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND CTE_ACESSO = ' + QuotedStr(strChaveCte) + ' AND MOV_GERSEQ = ' + QuotedStr('');
  cdsNotasFiscais.Filtered := True;
  Result := cdsNotasFiscais.IsEmpty;
  cdsNotasFiscais.Filtered := False;
end;

(*procedure TFreCon.pCarregaTXT(stlFrete: TStringList; memLog, memErr: TStrings);
  Var
    intLinha : Integer;
begin
  For intLinha := 0 To stlFrete.Count - 1 Do
  Begin

    strNumDoc := Trim(Copy(stlFrete[intLinha], 001, 06));           // Posicao 1 a 6

    strNumDoc := fStrZero(strNumDoc, fTamNumDoc);

    strSerie_ := Trim(Copy(stlFrete[intLinha], 007, 03));           // Posicao 7 a 9
    strEspDoc := Trim(Copy(stlFrete[intLinha], 010, 02));           // Posicao 10 a 11
    strDtaDoc := Trim(Copy(stlFrete[intLinha], 012, 10));           // Posicao 12 a 21

    {***********************************************************************************}
    {*NECESSARIO ESTAR NO INCIO PARA PEGAR O CODIGO DA TRANSPORTADORA E O O SEU ESTADO *}
    {********************************************************************************JC*}
    {********************************************************************}
    {* COMENTADO POIS NÃO IRÁ MAIS PROCURAR A TRANSPORTADORA PELO CNPJ. *}
    {* O CNPJ QUE VEM NO ARQUIVO NÃO É O DA TRANSPORTADORA.             *}
    {*****************************************************************PZ*}
    //strC_G_C_ := Trim(Copy(stlFrete[intLinha], 882, 14));           // Posicao 882 a 895

    //If fEmptyStr(FC_G_C_) Then
    //Begin
    //  pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + ' CNPJ não foi informado no arquivo!', intLinha + 1);
    //  Continue;
    //End;

    //If fEmptyStr(FCodTra) Then
    //Begin
    //  pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' +
    //                                     'Nenhum fornecedor encontrado com o CNPJ (' + strC_G_C_ + ')!', intLinha + 1);
    //  Continue;
    //End;

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi1 := Trim(Copy(stlFrete[intLinha], 022, 04));           // Posicao 22 a 25
    strClaFi1 := '1353';
    strValCo1 := Trim(Copy(stlFrete[intLinha], 026, 14));           // Posicao 26 a 39
    strBasIc1 := Trim(Copy(stlFrete[intLinha], 040, 14));           // Posicao 40 a 53
    strAlqIc1 := Trim(Copy(stlFrete[intLinha], 054, 14));           // Posicao 54 a 67
    strValIc1 := Trim(Copy(stlFrete[intLinha], 068, 14));           // Posicao 68 a 81
    strValOu1 := Trim(Copy(stlFrete[intLinha], 082, 14));           // Posicao 82 a 95
    strValIs1 := Trim(Copy(stlFrete[intLinha], 096, 14));           // Posicao 96 a 109
    strValRe1 := Trim(Copy(stlFrete[intLinha], 110, 14));           // Posicao 110 a 123
    strBasIp1 := Trim(Copy(stlFrete[intLinha], 124, 14));           // Posicao 124 a 137
    strValIp1 := Trim(Copy(stlFrete[intLinha], 138, 14));           // Posicao 138 a 151
    strBasSu1 := Trim(Copy(stlFrete[intLinha], 152, 14));           // Posicao 152 a 165
    strDesAc1 := Trim(Copy(stlFrete[intLinha], 166, 14));           // Posicao 166 a 179
    strValIs1 := Trim(Copy(stlFrete[intLinha], 180, 14));           // Posicao 180 a 193

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi2 := Trim(Copy(stlFrete[intLinha], 194, 04));           // Posicao 194 a 197
    strClaFi2 := '1353';
    strValCo2 := Trim(Copy(stlFrete[intLinha], 198, 14));           // Posicao 198 a 211
    strBasIc2 := Trim(Copy(stlFrete[intLinha], 212, 14));           // Posicao 212 a 225
    strAlqIc2 := Trim(Copy(stlFrete[intLinha], 226, 14));           // Posicao 226 a 239
    strValIc2 := Trim(Copy(stlFrete[intLinha], 240, 14));           // Posicao 240 a 253
    strValOu2 := Trim(Copy(stlFrete[intLinha], 254, 14));           // Posicao 254 a 267
    strValIs2 := Trim(Copy(stlFrete[intLinha], 268, 14));           // Posicao 268 a 281
    strValRe2 := Trim(Copy(stlFrete[intLinha], 282, 14));           // Posicao 282 a 295
    strBasIp2 := Trim(Copy(stlFrete[intLinha], 296, 14));           // Posicao 296 a 309
    strValIp2 := Trim(Copy(stlFrete[intLinha], 310, 14));           // Posicao 310 a 323
    strBasSu2 := Trim(Copy(stlFrete[intLinha], 324, 14));           // Posicao 324 a 337
    strDesAc2 := Trim(Copy(stlFrete[intLinha], 338, 14));           // Posicao 338 a 351
    strValIs2 := Trim(Copy(stlFrete[intLinha], 352, 14));           // Posicao 352 a 365

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi3 := Trim(Copy(stlFrete[intLinha], 366, 04));           // Posicao 366 a 369
    strClaFi3 := '1353';
    strValCo3 := Trim(Copy(stlFrete[intLinha], 370, 14));           // Posicao 370 a 383
    strBasIc3 := Trim(Copy(stlFrete[intLinha], 384, 14));           // Posicao 384 a 397
    strAlqIc3 := Trim(Copy(stlFrete[intLinha], 398, 14));           // Posicao 398 a 411
    strValIc3 := Trim(Copy(stlFrete[intLinha], 412, 14));           // Posicao 412 a 425
    strValOu3 := Trim(Copy(stlFrete[intLinha], 426, 14));           // Posicao 426 a 439
    strValIs3 := Trim(Copy(stlFrete[intLinha], 440, 14));           // Posicao 440 a 453
    strValRe3 := Trim(Copy(stlFrete[intLinha], 454, 14));           // Posicao 454 a 467
    strBasIp3 := Trim(Copy(stlFrete[intLinha], 468, 14));           // Posicao 468 a 481
    strValIp3 := Trim(Copy(stlFrete[intLinha], 482, 14));           // Posicao 482 a 495
    strBasSu3 := Trim(Copy(stlFrete[intLinha], 496, 14));           // Posicao 496 a 509
    strDesAc3 := Trim(Copy(stlFrete[intLinha], 510, 14));           // Posicao 510 a 523
    strValIs3 := Trim(Copy(stlFrete[intLinha], 524, 14));           // Posicao 524 a 537

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi4 := Trim(Copy(stlFrete[intLinha], 538, 04));           // Posicao 538 a 541
    strClaFi4 := '1353';
    strValCo4 := Trim(Copy(stlFrete[intLinha], 542, 14));           // Posicao 542 a 555
    strBasIc4 := Trim(Copy(stlFrete[intLinha], 556, 14));           // Posicao 556 a 569
    strAlqIc4 := Trim(Copy(stlFrete[intLinha], 570, 14));           // Posicao 570 a 583
    strValIc4 := Trim(Copy(stlFrete[intLinha], 584, 14));           // Posicao 584 a 597
    strValOu4 := Trim(Copy(stlFrete[intLinha], 598, 14));           // Posicao 598 a 611
    strValIs4 := Trim(Copy(stlFrete[intLinha], 612, 14));           // Posicao 612 a 625
    strValRe4 := Trim(Copy(stlFrete[intLinha], 626, 14));           // Posicao 626 a 639
    strBasIp4 := Trim(Copy(stlFrete[intLinha], 640, 14));           // Posicao 640 a 653
    strValIp4 := Trim(Copy(stlFrete[intLinha], 654, 14));           // Posicao 654 a 667
    strBasSu4 := Trim(Copy(stlFrete[intLinha], 668, 14));           // Posicao 668 a 681
    strDesAc4 := Trim(Copy(stlFrete[intLinha], 682, 14));           // Posicao 682 a 695
    strValIs4 := Trim(Copy(stlFrete[intLinha], 696, 14));           // Posicao 696 a 709

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi5 := Trim(Copy(stlFrete[intLinha], 710, 04));           // Posicao 710 a 713
    strClaFi5 := '1353';
    strValCo5 := Trim(Copy(stlFrete[intLinha], 714, 14));           // Posicao 714 a 727
    strBasIc5 := Trim(Copy(stlFrete[intLinha], 728, 14));           // Posicao 728 a 741
    strAlqIc5 := Trim(Copy(stlFrete[intLinha], 742, 14));           // Posicao 742 a 755
    strValIc5 := Trim(Copy(stlFrete[intLinha], 756, 14));           // Posicao 756 a 769
    strValOu5 := Trim(Copy(stlFrete[intLinha], 770, 14));           // Posicao 770 a 783
    strValIs5 := Trim(Copy(stlFrete[intLinha], 784, 14));           // Posicao 784 a 797
    strValRe5 := Trim(Copy(stlFrete[intLinha], 798, 14));           // Posicao 798 a 811
    strBasIp5 := Trim(Copy(stlFrete[intLinha], 812, 14));           // Posicao 812 a 825
    strValIp5 := Trim(Copy(stlFrete[intLinha], 826, 14));           // Posicao 826 a 839
    strBasSu5 := Trim(Copy(stlFrete[intLinha], 840, 14));           // Posicao 840 a 853
    strDesAc5 := Trim(Copy(stlFrete[intLinha], 854, 14));           // Posicao 854 a 867
    strValIs5 := Trim(Copy(stlFrete[intLinha], 868, 14));           // Posicao 868 a 881
    //strC_G_C_ := Trim(Copy(stlFrete[intLinha], 882, 14));           // Posicao 882 a 895

    FValTot   := (FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5);

    Try
      fValidaValores;
    Except
      On E: Exception Do
      Begin
        pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + E.Message, intLinha + 1);
        Continue;
      End;
    End;

    If fVerificaDocumento Then
    Begin
      pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + ' já existe no sistema!', intLinha + 1);
      Continue;
    End
    Else
    Begin
      qryTabela.Append;
      pEnviaDados;
      qryTabela.Post;
      pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' +
                                         'Importado com sucesso (Valor: '+FormatFloat('##,#.00', FValTot)+ ')!', intLinha + 1);
    End;

  End;
end;               *)

procedure TFreCon.pCarregaPessoas(xmlDoc: TXMLDocument; var xmlNode: IXMLNode);
var intTomador : integer;
    tag_tomador_encontrada: String;

  procedure pReinicia;
    Var blnMod67 : Boolean;
  begin
    pGetTagRaizCte(xmlDoc,xmlNode, blnMod67);
    If not blnMod67 Then
      xmlNode := xmlNode.ChildNodes.FindNode('CTe');
    xmlNode := xmlNode.ChildNodes.FindNode('infCte');
    xmlNode := xmlNode.ChildNodes.FindNode('ide');
  End;

  function fRetTomador: integer;
  begin
    fRetTomador := -1;
    pReinicia;
    tag_tomador_encontrada := '';
    xmlNode := xmlNode.ChildNodes.FindNode(tag_tomador_normal);
    If Assigned(xmlNode) Then
      tag_tomador_encontrada := tag_tomador_normal
    Else
    Begin
      pReinicia;
      xmlNode := xmlNode.ChildNodes.FindNode(tag_tomador_normal2);
      If Assigned(xmlNode) Then
        tag_tomador_encontrada := tag_tomador_normal2
      Else
      begin
        pReinicia;
        xmlNode := xmlNode.ChildNodes.FindNode(tag_tomador_outros);

        If Assigned(xmlNode) Then
          tag_tomador_encontrada := tag_tomador_outros
        Else
        Begin
          pReinicia;
          xmlNode := xmlNode.ChildNodes.FindNode(tag_tomador_outros2);
          If Assigned(xmlNode) Then
            tag_tomador_encontrada := tag_tomador_outros2;
        End;
      End;
    End;

    If Assigned(xmlNode) Then
      Result := xmlNode.ChildNodes.FindNode('toma').NodeValue
  End;

  function fCarregarPessoa(tagPessoa: string): TPessoaCTE;
    Var
      blnMod67 : Boolean;
      strPessoa: String;
  Begin
    pLimparPessoa(Result);

    pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
    If not blnMod67 Then
      xmlNode := xmlNode.ChildNodes.FindNode('CTe');
    xmlNode := xmlNode.ChildNodes.FindNode('infCte');

    If (tagPessoa = tag_tomador_outros) Or (tagPessoa = tag_tomador_outros2) Then
    begin
      xmlNode := xmlNode.ChildNodes.FindNode('ide');
      xmlNode := xmlNode.ChildNodes.FindNode(tag_tomador_encontrada);
    End
    Else
      xmlNode := xmlNode.ChildNodes.FindNode(tagPessoa);
    If Not Assigned(xmlNode) Then
      Exit;
    Result.strTipoFJ := EmptyStr;
    If Assigned(xmlNode.ChildNodes.FindNode('CNPJ')) Then
    begin
      Result.strCNPJ := String(VarToStr(xmlNode.ChildNodes.FindNode('CNPJ').NodeValue));
      If Not fTestaCgc(Result.strCNPJ) then
      Begin
        If fValidaCPF(Copy(Result.strCNPJ, 4, 14)) Then
        begin
          Result.strCNPJ := Copy(Result.strCNPJ, 4, 14);
          Result.strTipoFJ := TPessoaCTE.PESSOA_FISICA;
        end
        Else
        Begin
          case AnsiIndexStr(UpperCase(tagPessoa), ['EMIT', 'REM','EXPED','RECEB','DEST']) of
            0 : strPessoa := 'Emitente';
            1 : strPessoa := 'Remetente';
            2 : strPessoa := 'Expedidor';
            3 : strPessoa := 'Recebedor';
            4 : strPessoa := 'Destinatário';
          End;
          Raise Exception.Create('O CNPJ do '+ strPessoa +' não é válido, verifique o arquivo XML.');
        End;
      End
      else
        result.strTipoFJ := TPessoaCTE.PESSOA_JURIDICA;
    End
    Else
    begin
      Result.strCNPJ := String(VarToStr(xmlNode.ChildNodes.FindNode('CPF').NodeValue));
      If Length(Result.strCNPJ) = 14 then
        Result.strCNPJ := Copy(Result.strCNPJ, 4, 14);
      Result.strTipoFJ := TPessoaCTE.PESSOA_FISICA;
    End;

    Result.strRAZAO_SOCIAL := String(xmlNode.ChildNodes.FindNode('xNome').NodeValue);

    Try
      Result.xFant := String(xmlNode.ChildNodes.FindNode('xFant').NodeValue);
    Except
      Result.xFant := '';
    End;

    If Assigned(xmlNode.ChildNodes.FindNode('IE')) Then
      Result.strINSCRICAO_ESTADUAL := String(VarToStr(xmlNode.ChildNodes.FindNode('IE').NodeValue))
    Else
      Result.strINSCRICAO_ESTADUAL := '';

    if (result.strTipoFJ = TPessoaCTE.PESSOA_JURIDICA)
        and ((result.strINSCRICAO_ESTADUAL = '') or (pos('ISENTO',UpperCase(Result.strINSCRICAO_ESTADUAL)) > 0)) then
    begin
      if Result.fCGCProvavelCPF(result.strCNPJ) then
      begin
        result.strCNPJ := Copy(Result.strCNPJ, 4, 14);
        result.strTipoFJ := TPessoaCTE.PESSOA_FISICA;
      end;
    end;

    Result.intCodTomador := intTomador;
    If tagPessoa = 'emit' Then
      xmlNode := xmlNode.ChildNodes.FindNode('enderEmit')
    Else If tagPessoa = 'rem' Then
      xmlNode := xmlNode.ChildNodes.FindNode('enderReme')
    Else If tagPessoa = 'exped' Then
      xmlNode := xmlNode.ChildNodes.FindNode('enderExped')
    Else If tagPessoa = 'receb' Then
      xmlNode := xmlNode.ChildNodes.FindNode('enderReceb')
    Else If tagPessoa = 'dest' Then
      xmlNode := xmlNode.ChildNodes.FindNode('enderDest')
    Else If (tagPessoa = tag_tomador_outros) Or (tagPessoa = tag_tomador_outros2) Then
      xmlNode := xmlNode.ChildNodes.FindNode('enderToma');
    Result.strUF := String(xmlNode.ChildNodes.FindNode('UF').NodeValue);

    Result.xLgr := String(xmlNode.ChildNodes.FindNode('xLgr').NodeValue);
    Result.xNro := String(xmlNode.ChildNodes.FindNode('nro').NodeValue);
    Result.xBairro := String(xmlNode.ChildNodes.FindNode('xBairro').NodeValue);
    Result.cMun := String(xmlNode.ChildNodes.FindNode('cMun').NodeValue);
    Result.xMun := String(xmlNode.ChildNodes.FindNode('xMun').NodeValue);

    If Assigned(xmlNode.ChildNodes.FindNode('CEP')) Then
      Result.strCEP := String(xmlNode.ChildNodes.FindNode('CEP').NodeValue);
  End;
  Var
    blnMod67 : Boolean;

begin
  pLimparPessoa(FEmitente);
  pLimparPessoa(FRemetente);
  pLimparPessoa(FExpedidor);
  pLimparPessoa(FRecebedor);
  pLimparPessoa(FDestinatario);
  pLimparPessoa(FTomador);

  pGetTagRaizCte(xmlDoc, xmlNode, blnMod67);
  If not blnMod67 Then
    xmlNode := xmlNode.ChildNodes.FindNode('CTe');
  xmlNode := xmlNode.ChildNodes.FindNode('infCte');
  xmlNode := xmlNode.ChildNodes.FindNode('ide');
  intTomador := fRetTomador;

  FEmitente  := fCarregarPessoa('emit');
  FRemetente := fCarregarPessoa('rem');
  FExpedidor := fCarregarPessoa('exped');
  FRecebedor := fCarregarPessoa('receb');
  FDestinatario := fCarregarPessoa('dest');

  If intTomador > -1 Then
  Begin
    case intTomador of
      tomador_Remetente    : FTomador := FRemetente;
      tomador_Expedidor    : FTomador := FExpedidor;
      tomador_Recebedor    : FTomador := FRecebedor;
      tomador_Destinatario : FTomador := FDestinatario;
      tomador_Outros       : FTomador := fCarregarPessoa(tag_tomador_encontrada);
    End;
  End;
  FCreditaICMS :=  fVerificaSeCreditaICMS(intTomador);
end;

procedure TFreCon.pCarregaPessoasBco;
var
  intTomador: Integer;

const tomador_Remetente    = 0;
      tomador_Expedidor    = 1;
      tomador_Recebedor    = 2;
      tomador_Destinatario = 3;
      tomador_Outros       = 4;

  function fCarregarPessoaBco(tagPessoa: string): TPessoaCTE;
  Begin
    pLimparPessoa(Result);

    If tagPessoa = 'emit' Then
    begin
      Result.strCNPJ := qryCTes.FieldByName('EMITENTE_CNPJ').AsString;
      Result.strRAZAO_SOCIAL := qryCTes.FieldByName('EMITENTE_RAZAOSOCIAL').AsString;
      Result.strINSCRICAO_ESTADUAL := qryCTes.FieldByName('EMITENTE_IE').AsString;
      Result.strUF := qryCTes.FieldByName('EMITENTE_UF').AsString;
    end
    Else If tagPessoa = 'rem' Then
    begin
      Result.strCNPJ := qryCTes.FieldByName('REMETENTE_CNPJ').AsString;
      Result.strRAZAO_SOCIAL := qryCTes.FieldByName('REMETENTE_RAZAOSOCIAL').AsString;
      Result.strINSCRICAO_ESTADUAL := qryCTes.FieldByName('REMETENTE_IE').AsString;
      Result.strUF := qryCTes.FieldByName('REMETENTE_UF').AsString;
    end
    Else If tagPessoa = 'exped' Then
      Exit
    Else If tagPessoa = 'receb' Then
      Exit
    Else If tagPessoa = 'dest' Then
    begin
      Result.strCNPJ := qryCTes.FieldByName('DESTINATARIO_CNPJ').AsString;
      Result.strRAZAO_SOCIAL := qryCTes.FieldByName('DESTINATARIO_RAZAOSOCIAL').AsString;
      Result.strINSCRICAO_ESTADUAL := qryCTes.FieldByName('DESTINATARIO_IE').AsString;
      Result.strUF := qryCTes.FieldByName('DESTINATARIO_UF').AsString;
    end
    Else
      Exit;

    Result.intCodTomador := StrToIntDef(FTomSer, -1);
  End;
begin
  pLimparPessoa(FEmitente);
  pLimparPessoa(FRemetente);
  pLimparPessoa(FExpedidor);
  pLimparPessoa(FRecebedor);
  pLimparPessoa(FDestinatario);
  pLimparPessoa(FTomador);

  FEmitente  := fCarregarPessoaBco('emit');
  FRemetente := fCarregarPessoaBco('rem');
  FExpedidor := fCarregarPessoaBco('exped');
  FRecebedor := fCarregarPessoaBco('receb');
  FDestinatario := fCarregarPessoaBco('dest');

  intTomador := StrToIntDef(FTomSer, -1);

  If intTomador > -1 Then
  Begin
    case intTomador of
      tomador_Remetente    : FTomador := FRemetente;
      tomador_Expedidor    : FTomador := FExpedidor;
      tomador_Recebedor    : FTomador := FRecebedor;
      tomador_Destinatario : FTomador := FDestinatario;
    End;
  End;
end;

function TFreCon.fVerificaCamposMunicipioInicioFimPreenchidos: Boolean;
begin
  Result:= Not(fEmptyStr(FCodMunicipioInicio)) And
    Not(fEmptyStr(FMunicipioDescricaoInicio)) And
    Not(fEmptyStr(FCodMunicipioFim)) And
    Not(fEmptyStr(FMunicipioDescricaoFim)) And
    Not(fEmptyStr(FUFInicio)) And
    Not(fEmptyStr(FUFFim));
end;

function TFreCon.fGravaDadosMunicipio(seqCTE: String): Boolean;
var
  qryInsert: TUniQuery;
Begin
  If Not blnImpVariosXml Then
    Exit(True);
  qryInsert:= fCriaQuery();
  Result    := False;
  Try
    If (fVerificaCamposMunicipioInicioFimPreenchidos) Then
    Begin
      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('INSERT INTO COMCTE( CTE_SEQCTE,     ');
      qryInsert.SQL.Add('CTE_MUNINI, CTE_DESMNI, CTE_UFINI_, ');
      qryInsert.SQL.Add('CTE_MUNFIM, CTE_DESMNF, CTE_UFFIM_) ');
      qryInsert.SQL.Add('VALUES( :SEQCTE, ');
      qryInsert.SQL.Add(':MUNINI, :DESMNI, :UFINI_,');
      qryInsert.SQL.Add(':MUNFIM, :DESMNF, :UFFIM_ )');
      qryInsert.ParamByName('SEQCTE').AsString:= seqCTE;
      qryInsert.ParamByName('MUNINI').AsString:= FCodMunicipioInicio;
      qryInsert.ParamByName('DESMNI').AsString:= FMunicipioDescricaoInicio;
      qryInsert.ParamByName('UFINI_').AsString:= FUFInicio;
      qryInsert.ParamByName('MUNFIM').AsString:= FCodMunicipioFim;
      qryInsert.ParamByName('DESMNF').AsString:= FMunicipioDescricaoFim;
      qryInsert.ParamByName('UFFIM_').AsString:= FUFFim;
      qryInsert.ExecSQL;
      Result:= qryInsert.RowsAffected > 0;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
End;

function TFreCon.fGravaPessoas(seqCTE: String): Boolean;
  var qryInsert: TUniQuery;

  procedure pGravaPessoa(recPessoa: TPessoaCte; strPessoa: string);
  Begin
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO PESCTE(');
    qryInsert.SQL.Add('CTE_CODTOM,');
    qryInsert.SQL.Add('CTE_TIPPES,');
    qryInsert.SQL.Add('CTE_SEQCTE,');
    qryInsert.SQL.Add('AUTOINCREM,');
    qryInsert.SQL.Add('CTE_C_G_C_,');
    qryInsert.SQL.Add('CTE_I_E_S_,');
    qryInsert.SQL.Add('CTE_RAZSOC,');
    qryInsert.SQL.Add('CTE_UNIFED,');
    qryInsert.SQL.Add('CTE_DESMUN,');
    qryInsert.SQL.Add('CTE_C_E_P_,');
    qryInsert.SQL.Add('CTE_DIGMAN,');
    qryInsert.SQL.Add('CTE_CODMUN,');
    qryInsert.SQL.Add('CTE_CDIBGE) VALUES (');
    qryInsert.SQL.Add(':CODTOM,');
    qryInsert.SQL.Add(':TIPPES,');
    qryInsert.SQL.Add(':SEQCTE,');
    qryInsert.SQL.Add(':SEQUEN,');
    qryInsert.SQL.Add(':C_G_C_,');
    qryInsert.SQL.Add(':I_E_S_,');
    qryInsert.SQL.Add(':RAZSOC,');
    qryInsert.SQL.Add(':UNIFED,');
    qryInsert.SQL.Add(':DESMUN,');
    qryInsert.SQL.Add(':C_E_P_,');
    qryInsert.SQL.Add(':DIGMAN,');
    qryInsert.SQL.Add(':CODMUN,');
    qryInsert.SQL.Add(':CDIBGE )');

    qryInsert.ParamByName('CODTOM').AsInteger := recPessoa.intCodTomador;
    qryInsert.ParamByName('SEQCTE').AsString  := seqCTE;
    qryInsert.ParamByName('TIPPES').AsString  := strPessoa;
    qryInsert.ParamByName('SEQUEN').AsString  := fRetAutoIncrem('PESCTE', VS_strCodEmp);
    qryInsert.ParamByName('C_G_C_').AsString  := String(recPessoa.strCNPJ);
    qryInsert.ParamByName('I_E_S_').AsString  := String(recPessoa.strINSCRICAO_ESTADUAL);
    qryInsert.ParamByName('RAZSOC').AsString  := String(recPessoa.strRAZAO_SOCIAL);
    qryInsert.ParamByName('UNIFED').AsString  := String(recPessoa.strUF);
    qryInsert.ParamByName('DESMUN').AsString  := String(recPessoa.xMun);
    qryInsert.ParamByName('CODMUN').AsString  := String(recPessoa.cMun);
    qryInsert.ParamByName('C_E_P_').AsString  := String(recPessoa.strCEP);
    qryInsert.ParamByName('DIGMAN').AsInteger := IIf(FstrArquivoXML <> '', '0', '1');
    qryInsert.ParamByName('CDIBGE').AsString  := String(recPessoa.strCODIBGE);
    qryInsert.ExecSQL;
  End;

Begin
  Result := True;
  qryInsert := fCriaQuery;
  Try
    Try
      If Not(fEmptyStr(String(FRemetente.strCNPJ))) Then
        pGravaPessoa(FRemetente, 'REMETENTE');
      If Not(fEmptyStr(String(FEmitente.strCNPJ))) Then
        pGravaPessoa(FEmitente, 'EMITENTE');
      If Not(fEmptyStr(String(FExpedidor.strCNPJ))) Then
        pGravaPessoa(FExpedidor, 'EXPEDIDOR');
      If Not(fEmptyStr(String(FRecebedor.strCNPJ))) Then
        pGravaPessoa(FRecebedor, 'RECEBEDOR');
      If Not(fEmptyStr(String(FDestinatario.strCNPJ))) Then
        pGravaPessoa(FDestinatario, 'DESTINATARIO');
      If Not(fEmptyStr(String(FTomador.strCNPJ))) Then
        pGravaPessoa(FTomador, 'TOMADOR');
    Except
      On e: Exception do
      Begin
        If Not Assigned(FMemLog) Then
          pMensagensErro(e.Message, 'TFreCon.fGravaPessoas')
        Else
          pEscreveMensagemImportacao(FMemLog, e.Message);
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
End;

procedure TFreCon.pControlaDigDuplicAtual(intOpc: Integer);
Var
  intContad: Integer;
begin

  If (intOpc = 1) Then
  Begin

    For intContad := 0 To Length(arrDuplicata) - 1 Do
    Begin
      arrDupTmp[intContad].intNumDup := ArrDuplicata[intContad].intNumDup;
      arrDupTmp[intContad].strSequen := ArrDuplicata[intContad].strSequen;
      arrDupTmp[intContad].curValor  := ArrDuplicata[intContad].curValor;
      arrDupTmp[intContad].dtaDtaVen := ArrDuplicata[intContad].dtaDtaVen;
      arrDupTmp[intContad].strUsaChq := ArrDuplicata[intContad].strUsaChq;
      arrDupTmp[intContad].strHist02 := ArrDuplicata[intContad].strHist02;
    End;

  End
  Else If (intOpc = 2) Then
  Begin

    For intContad := 0 To Length(arrDupTmp) - 1 Do
    Begin
      ArrDuplicata[intContad].intNumDup := ArrDupTmp[intContad].intNumDup;
      ArrDuplicata[intContad].strSequen := ArrDupTmp[intContad].strSequen;
      ArrDuplicata[intContad].curValor  := ArrDupTmp[intContad].curValor;
      ArrDuplicata[intContad].dtaDtaVen := ArrDupTmp[intContad].dtaDtaVen;
      ArrDuplicata[intContad].strUsaChq := ArrDupTmp[intContad].strUsaChq;
      ArrDuplicata[intContad].strHist02 := ArrDupTmp[intContad].strHist02;
    End;

  End
  Else If (intOpc = 3) Then
  Begin

    For intContad := 0 To Length(arrDupFre) - 1 Do
    Begin
      ArrDuplicata[intContad].intNumDup := ArrDupFre[intContad].intNumDup;
      ArrDuplicata[intContad].strSequen := ArrDupFre[intContad].strSequen;
      ArrDuplicata[intContad].curValor  := ArrDupFre[intContad].curValor;
      ArrDuplicata[intContad].dtaDtaVen := ArrDupFre[intContad].dtaDtaVen;
      ArrDuplicata[intContad].strUsaChq := ArrDupFre[intContad].strUsaChq;
      ArrDuplicata[intContad].strHist02 := ArrDupFre[intContad].strHist02;
    End;

  End

  Else If (intOpc = 4) Then
  Begin

    For intContad := 0 To Length(arrDuplicata) - 1 Do
    Begin
      arrDupFre[intContad].intNumDup := ArrDuplicata[intContad].intNumDup;
      arrDupFre[intContad].strSequen := ArrDuplicata[intContad].strSequen;
      arrDupFre[intContad].curValor  := ArrDuplicata[intContad].curValor;
      arrDupFre[intContad].dtaDtaVen := ArrDuplicata[intContad].dtaDtaVen;
      arrDupFre[intContad].strUsaChq := ArrDuplicata[intContad].strUsaChq;
      arrDupFre[intContad].strHist02 := ArrDuplicata[intContad].strHist02;
    End;

  End;
end;

function TFreCon.getValTot: Double;
Begin
  Result := FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5;
End;

function TFreCon.GetEstTra: String;
begin
  Result := fRetNomCidade(fCampoTabela('FOR_CODCID', 'CADFOR', ['FOR_CODFOR'], [FCodTra]), 2);
end;

function TFreCon.fDefineCndPag(cndDefault: String): String;
var qryConsulta: TUniQuery;
    strCndPag: String;
    strCodCnd: String;
begin
  Result := cndDefault;
  qryConsulta := fCriaQuery;
  Try
     qryConsulta.SQL.Add('SELECT FOR_CODCND, FOR_CNDPAG FROM CADFOR WHERE FOR_C_G_C_ = "'+FCgcTra+'"');
     qryConsulta.Open;
     If qryConsulta.FieldByName('FOR_CNDPAG').AsString <> '' then
     begin
       strCndPag := qryConsulta.FieldByName('FOR_CNDPAG').AsString;
       strCodCnd := qryConsulta.FieldByName('FOR_CODCND').AsString;
       If strCodCnd <> '' Then
       Begin
         qryConsulta.SQL.Clear;
         qryConsulta.SQL.Add('SELECT * FROM CADCND WHERE CND_CODIGO = "'+strCodCnd+'"');
         qryConsulta.Open;
         strCndPag := fRetCondicao(strCndPag,
                                   FDtaDoc,
                                   qryConsulta.FieldByName('CND_CODIGO').AsString,
                                   qryConsulta.FieldByName('CND_TIPFOR').AsString,
                                   qryConsulta.FieldByName('CND_CNDPAG').AsString,
                                   FDtaDoc,'','', True);
       End;
       Result := strCndPag;
     End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

Function TFreCon.fDocumentoExiste(strNumDoc, strEspDoc, strSerie, strCodFor: String;
                                  Var blnConFre: Boolean;
                                  Var fltOutDes: Double): Boolean;
Begin
  fltOutDes := 0;

  With FNotEnt, SQL Do
  Begin
    Close;
    Clear;

    Add('/* untEntFreCon.fDocumentoExiste */');
    Add('SELECT SQL_NO_CACHE');

    Add('  G.AUTOINCREM AS AUTINC,');
    Add('  GER_DTAENT   AS DTAENT,');
    Add('  GER_VLRCON   AS VLRCON,');

    Add('  0.00         AS PERREP,');

    Add(' IFNULL(AUX_MATREV, FOR_MATREV) AS MATREV, ');

    Add(' (  SELECT SUM(IFNULL(DET_OUTDES, 0)) FROM MOVDET D');
    Add('    INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER');
    Add('    WHERE D.DET_SEQGER = G.AUTOINCREM ');
    Add(' ) AS OUTDES');

    Add('FROM');
    Add('MOVGER G');
    Add(' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ');
    Add(' LEFT JOIN AUXMOV ON AUX_SEQGER = G.AUTOINCREM');
    Add('WHERE');

    Add('  GER_TIP_FC = "F" AND ');
    Add('  IFNULL(GER_ORIDOC, "") = "" AND ');
    Add('  GER_NUMDOC = :NUMDOC AND ');
    Add('  GER_ESPDOC = :ESPDOC AND ');
    Add('  GER_CODEMP = :CODEMP AND ');
    Add('  GER_CODFOR = :CODFOR AND ');
    Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

    ParamByName('NUMDOC').AsString  := strNumDoc;
    ParamByName('ESPDOC').AsString  := strEspDoc;
    ParamByName('SERIE_').AsString  := strSerie;
    ParamByName('CODFOR').AsString  := strCodFor;
    ParamByName('CODEMP').AsString  := FCodEmp;

    Open;

    Result := Not IsEmpty;

    blnConFre := Result And fTemFreConhecimento(strNumDoc, strEspDoc, FCodEmp, strSerie, strCodFor);

    If Not IsEmpty Then
      fltOutDes := FieldByName('OUTDES').AsFloat;
  End;
End;

Function TFreCon.fIncluiNotaEntrada(strNumDoc, strEspDoc, strSerie, strCodFor: String; fltOutDes, fltPerRep: Double): Boolean;
Begin
  Result := True;

  With cdsNotEnt Do
  If Not Locate('NUMDOC;ESPDOC;SERIE_;CODFOR',
            VarArrayOf([strNumDoc, strEspDoc, strSerie, strCodFor]), []) Then
  Begin
    Insert;
    FieldByName('NUMDOC').AsString   := strNumDoc;
    FieldByName('ESPDOC').AsString   := strEspDoc;
    FieldByName('SERIE_').AsString   := strSerie;
    FieldByName('CODFOR').AsString   := strCodFor;
    FieldByName('NOMFOR').AsString   := fRetNomFornecedor(strCodFor);
    FieldByName('DTAENT').AsDateTime := FNotEnt.FieldByName('DTAENT').AsDateTime;
    FieldByName('VLRCON').AsFloat    := FNotEnt.FieldByName('VLRCON').AsFloat;
    FieldByName('AUTINC').AsString   := FNotEnt.FieldByName('AUTINC').AsString;
    FieldByName('OUTDES').AsFloat    := fltOutDes;
    FieldByName('PERREP').AsFloat    := fltPerRep;
    FieldByName('MATREV').AsString   := FNotEnt.FieldByName('MATREV').AsString;
    Post;
  End;

End;

Procedure TFreCon.pSetDupicatas;
  Var
    stlVencimentos: TStringList;
    intContador: Integer;
Begin
  stlVencimentos := TStringList.Create;

  For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
    If arrDuplicata[intContador].curValor > 0 Then
    Begin
      arrDuplicata[intContador].strSequen := String(arrLetras[intContador]);
      stlVencimentos.Add(arrDuplicata[intContador].dtaDtaVen + ' ' +
                         FormatFloat('#0.00', arrDuplicata[intContador].curValor))
    End Else
      Break;

  FDuplic := stlVencimentos.Text;

  FreeAndNil(stlVencimentos);

  pSetLinDig;
End;

Procedure TFreCon.pSetLinDig;
  Var
    stlVencimentos: TStringList;
    intContador: Integer;
Begin
  stlVencimentos := TStringList.Create;

  stlVencimentos.Clear;
  For intContador := Low(arrLinDigCodbar) To High(arrLinDigCodbar) Do
    stlVencimentos.Add(arrLinDigCodbar[intContador].strLinDig);
  FLinDig := stlVencimentos.Text;

  stlVencimentos.Clear;
  For intContador := Low(arrLinDigCodbar) To High(arrLinDigCodbar) Do
    stlVencimentos.Add(arrLinDigCodbar[intContador].strCodBar);
  FCodBar := stlVencimentos.Text;

  FreeAndNil(stlVencimentos);
End;

function TFreCon.fRetCNPJEmpresa(strCodEmp: String): String;
begin
  If FEmpresas.IsEmpty Then
  Begin
    FEmpresas.SQL.Text := 'SELECT EMP_CODEMP, EMP_C_G_C_ FROM CADEMP';
    FEmpresas.Open;
  End;
  FEmpresas.First;
  If FEmpresas.Locate('EMP_CODEMP', strCodEmp, []) Then
    Result := FEmpresas.FieldByName('EMP_C_G_C_').AsString
  Else
    Exit('');
end;

function TFreCon.fRetCondicaoPagto(nodDup: IXMLNode; dtaDtaBas: TDateTime; var strDuplictas: String): String;
  Var
    fltValor: Double;
    dtaDtaVen: TDateTime;
    stlVencimentos: TStringList;
    intContador: Integer;
Begin
  Result := '';

  stlVencimentos := TStringList.Create;

  While Assigned(nodDup) And (nodDup.GetNodeName = 'dup') Do
  Begin
    dtaDtaVen := fGetValorXml(nodDup, 'dVenc', varDate);
    fltValor  := fGetValorXml(nodDup, 'vDup', varDouble);

    If fltValor > 0 Then
    Begin
      stlVencimentos.Add(FormatDateTime('DD/MM/YYYY', dtaDtaVen) + ' ' + FormatFloat('#0.00', fltValor));
    End;

    nodDup := nodDup.NextSibling;
  End;

  strDuplictas := stlVencimentos.Text;

  If stlVencimentos.Count > 0 Then
  Begin
    pZeraDigDuplic(arrDuplicata);

    For intContador := 0 To stlVencimentos.Count - 1 Do
      arrDuplicata[intContador].dtaDtaVen := LeftStr(stlVencimentos[intContador], 10);

    Result := fRetornaCndPag(arrDuplicata, dtaDtaBas);
  End;

  FreeAndNil(stlVencimentos);
End;

Procedure TFreCon.pExcluiNotaEntrada;
Begin
  With cdsNotEnt Do
  Begin
    If (Not IsEmpty) And fPergunta('Confirma a exclusão do documento?') Then
    Begin

     If Not fExcluiProdutosParaRateioNota(FieldByName('AUTINC').AsString) Then
       Exit;

     If Assigned(objIteAnt) Then
       objIteAnt.pExcluiItensNota(FieldByName('NUMDOC').AsString,
                                  FieldByName('ESPDOC').AsString,
                                  FieldByName('SERIE_').AsString,
                                  FieldByName('CODFOR').AsString);

      Delete;
    End;
  End;
End;

Function TFreCon.fConfirmaFreConhecimentoVariasNotas: Boolean;
  Var
    strCodForOutDes,
    strNumDocOutDes,
    strEspDocOutDes,
    strSerieOutDes,
    strTipFor: String;
    dtaDtaEntOutDes: TDateTime;
    blnVarNotOutDes: Boolean;
Begin
  Try
    dtaDtaEntOutDes := FDtaEnt;
    FCtpConOutDes   := 0;

    strTipFor := '';

    If cdsNotEnt.RecordCount = 1 Then
    Begin
      blnVarNotOutDes := False;

      strCodForOutDes := cdsNotEnt.FieldByName('CODFOR').AsString;
      strNumDocOutDes := cdsNotEnt.FieldByName('NUMDOC').AsString;
      strEspDocOutDes := cdsNotEnt.FieldByName('ESPDOC').AsString;
      strSerieOutDes  := cdsNotEnt.FieldByName('SERIE_').AsString;
      strTipFor       := cdsNotEnt.FieldByName('MATREV').AsString; //fBuscaMatRevGerele(strNumDocOutDes, strEspDocOutDes,
                         //             strSerieOutDes, FCodEmp, strCodForOutDes); //fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [strCodForOutDes]);


    End Else
    Begin
      blnVarNotOutDes := True;

      strCodForOutDes := FCodTra;
      strNumDocOutDes := FNumDoc;
      strEspDocOutDes := FEspDoc;
      strSerieOutDes  := FSerie_;
    End;

    Result := fConfirmaFreConhecimento(blnImprCp, strCodPor, 'TFreCon', cdsNotEnt.FieldByName('ESPDOC').AsString) And
              objOutDes.fGravaContasAPagar(strCodForOutDes,
                                           strNumDocOutDes,
                                           strEspDocOutDes,
                                           strTipFor,FCompet,
                                           FCodEmp,
                                           strSerieOutDes,
                                           FCtpConOutDes,
                                           dtaDtaEntOutDes,
                                           blnVarNotOutDes);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fConfirmaFreConhecimentoVariasNotas]');
    End;
  End;

End;

function TFreCon.getBasAn1: String;
begin
  Result := FloatToStrF(FBasAn1,ffFixed,12,2);
end;

function TFreCon.getBasAn2: String;
begin
  Result := FloatToStrF(FBasAn2,ffFixed,12,2);
end;

function TFreCon.getBasAn3: String;
begin
  Result := FloatToStrF(FBasAn3,ffFixed,12,2);
end;

function TFreCon.getBasAn4: String;
begin
  Result := FloatToStrF(FBasAn4,ffFixed,12,2);
end;

function TFreCon.getBasAn5: String;
begin
  Result := FloatToStrF(FBasAn5,ffFixed,12,2);
end;

function TFreCon.getBasAnT: String;
begin
  Result := FloatToStrF(FBasAn1 + FBasAn2 + FBasAn3 + FBasAn4 + FBasAn5,ffFixed,12,2);
end;

procedure TFreCon.setAntIc1(const Value: String);
begin
  FAntIc1 := fStrToFloat(Value);
end;

procedure TFreCon.setAntIc2(const Value: String);
begin
  FAntIc2 := fStrToFloat(Value);
end;

procedure TFreCon.setAntIc3(const Value: String);
begin
  FAntIc3 := fStrToFloat(Value);
end;

procedure TFreCon.setAntIc4(const Value: String);
begin
  FAntIc4 := fStrToFloat(Value);
end;

procedure TFreCon.setAntIc5(const Value: String);
begin
  FAntIc5 := fStrToFloat(Value);
end;

procedure TFreCon.setBasAn1(const Value: String);
begin
  FBasAn1 := fStrToFloat(Value);
end;

procedure TFreCon.setBasAn2(const Value: String);
begin
  FBasAn2 := fStrToFloat(Value);
end;

procedure TFreCon.setBasAn3(const Value: String);
begin
  FBasAn3 := fStrToFloat(Value);
end;

procedure TFreCon.setBasAn4(const Value: String);
begin
  FBasAn4 := fStrToFloat(Value);
end;

procedure TFreCon.setBasAn5(const Value: String);
begin
  FBasAn5 := fStrToFloat(Value);
end;

function TFreCon.getAntIc1: String;
begin
  Result := FloatToStrF(FAntIc1,ffFixed,12,2);
end;

function TFreCon.getAntIc2: String;
begin
  Result := FloatToStrF(FAntIc2,ffFixed,12,2);
end;

function TFreCon.getAntIc3: String;
begin
  Result := FloatToStrF(FAntIc3,ffFixed,12,2);
end;

function TFreCon.getAntIc4: String;
begin
  Result := FloatToStrF(FAntIc4,ffFixed,12,2);
end;

function TFreCon.getAntIc5: String;
begin
  Result := FloatToStrF(FAntIc5,ffFixed,12,2);
end;

function TFreCon.getAntIcT: String;
begin
  Result := FloatToStrF(FAntIc1 + FAntIc2 + FAntIc3 + FAntIc4 + FAntIc5,ffFixed,12,2);
end;

Function TFreCon.fCarregaTXT(stlFrete: TStringList; memLog, memErr: TStrings): Boolean;
  Var
    intLinha : Integer;
begin
  Result := False;

  For intLinha := 0 To stlFrete.Count - 1 Do
  Begin

    strNumDoc := Trim(Copy(stlFrete[intLinha], 001, 06));           // Posicao 1 a 6

    strNumDoc := fStrZero(strNumDoc, fTamNumDoc);

    strSerie_ := Trim(Copy(stlFrete[intLinha], 007, 03));           // Posicao 7 a 9
    strEspDoc := Trim(Copy(stlFrete[intLinha], 010, 02));           // Posicao 10 a 11
    strDtaDoc := Trim(Copy(stlFrete[intLinha], 012, 10));           // Posicao 12 a 21

    If LeftStr(strClaFi1, 1) = '5' Then
      strClaFi1 := '1353'

    Else If LeftStr(strClaFi1, 1) = '6' Then
      strClaFi1 := '2353'

    Else If (Not fEmptyStr(FCodTra)) And (fRetEstadoFornecedor(FCodTra) <> fRetEstadoEmpresa(FCodEmp)) Then
      strClaFi1 := '2353'
    Else
      strClaFi1 := '1353';

    strValCo1 := Trim(Copy(stlFrete[intLinha], 026, 14));           // Posicao 26 a 39
    strBasIc1 := Trim(Copy(stlFrete[intLinha], 040, 14));           // Posicao 40 a 53
    strAlqIc1 := Trim(Copy(stlFrete[intLinha], 054, 14));           // Posicao 54 a 67
    strValIc1 := Trim(Copy(stlFrete[intLinha], 068, 14));           // Posicao 68 a 81
    strValOu1 := Trim(Copy(stlFrete[intLinha], 082, 14));           // Posicao 82 a 95
    strValIs1 := Trim(Copy(stlFrete[intLinha], 096, 14));           // Posicao 96 a 109
    strValRe1 := Trim(Copy(stlFrete[intLinha], 110, 14));           // Posicao 110 a 123
    strBasIp1 := Trim(Copy(stlFrete[intLinha], 124, 14));           // Posicao 124 a 137
    strValIp1 := Trim(Copy(stlFrete[intLinha], 138, 14));           // Posicao 138 a 151
    strBasSu1 := Trim(Copy(stlFrete[intLinha], 152, 14));           // Posicao 152 a 165
    strDesAc1 := Trim(Copy(stlFrete[intLinha], 166, 14));           // Posicao 166 a 179
    strValIs1 := Trim(Copy(stlFrete[intLinha], 180, 14));           // Posicao 180 a 193

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    strClaFi2 := strClaFi1;
    strValCo2 := Trim(Copy(stlFrete[intLinha], 198, 14));           // Posicao 198 a 211
    strBasIc2 := Trim(Copy(stlFrete[intLinha], 212, 14));           // Posicao 212 a 225
    strAlqIc2 := Trim(Copy(stlFrete[intLinha], 226, 14));           // Posicao 226 a 239
    strValIc2 := Trim(Copy(stlFrete[intLinha], 240, 14));           // Posicao 240 a 253
    strValOu2 := Trim(Copy(stlFrete[intLinha], 254, 14));           // Posicao 254 a 267
    strValIs2 := Trim(Copy(stlFrete[intLinha], 268, 14));           // Posicao 268 a 281
    strValRe2 := Trim(Copy(stlFrete[intLinha], 282, 14));           // Posicao 282 a 295
    strBasIp2 := Trim(Copy(stlFrete[intLinha], 296, 14));           // Posicao 296 a 309
    strValIp2 := Trim(Copy(stlFrete[intLinha], 310, 14));           // Posicao 310 a 323
    strBasSu2 := Trim(Copy(stlFrete[intLinha], 324, 14));           // Posicao 324 a 337
    strDesAc2 := Trim(Copy(stlFrete[intLinha], 338, 14));           // Posicao 338 a 351
    strValIs2 := Trim(Copy(stlFrete[intLinha], 352, 14));           // Posicao 352 a 365

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi3 := Trim(Copy(stlFrete[intLinha], 366, 04));           // Posicao 366 a 369
    strClaFi3 := strClaFi1;
    strValCo3 := Trim(Copy(stlFrete[intLinha], 370, 14));           // Posicao 370 a 383
    strBasIc3 := Trim(Copy(stlFrete[intLinha], 384, 14));           // Posicao 384 a 397
    strAlqIc3 := Trim(Copy(stlFrete[intLinha], 398, 14));           // Posicao 398 a 411
    strValIc3 := Trim(Copy(stlFrete[intLinha], 412, 14));           // Posicao 412 a 425
    strValOu3 := Trim(Copy(stlFrete[intLinha], 426, 14));           // Posicao 426 a 439
    strValIs3 := Trim(Copy(stlFrete[intLinha], 440, 14));           // Posicao 440 a 453
    strValRe3 := Trim(Copy(stlFrete[intLinha], 454, 14));           // Posicao 454 a 467
    strBasIp3 := Trim(Copy(stlFrete[intLinha], 468, 14));           // Posicao 468 a 481
    strValIp3 := Trim(Copy(stlFrete[intLinha], 482, 14));           // Posicao 482 a 495
    strBasSu3 := Trim(Copy(stlFrete[intLinha], 496, 14));           // Posicao 496 a 509
    strDesAc3 := Trim(Copy(stlFrete[intLinha], 510, 14));           // Posicao 510 a 523
    strValIs3 := Trim(Copy(stlFrete[intLinha], 524, 14));           // Posicao 524 a 537

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi4 := Trim(Copy(stlFrete[intLinha], 538, 04));           // Posicao 538 a 541
    strClaFi4 := strClaFi1;
    strValCo4 := Trim(Copy(stlFrete[intLinha], 542, 14));           // Posicao 542 a 555
    strBasIc4 := Trim(Copy(stlFrete[intLinha], 556, 14));           // Posicao 556 a 569
    strAlqIc4 := Trim(Copy(stlFrete[intLinha], 570, 14));           // Posicao 570 a 583
    strValIc4 := Trim(Copy(stlFrete[intLinha], 584, 14));           // Posicao 584 a 597
    strValOu4 := Trim(Copy(stlFrete[intLinha], 598, 14));           // Posicao 598 a 611
    strValIs4 := Trim(Copy(stlFrete[intLinha], 612, 14));           // Posicao 612 a 625
    strValRe4 := Trim(Copy(stlFrete[intLinha], 626, 14));           // Posicao 626 a 639
    strBasIp4 := Trim(Copy(stlFrete[intLinha], 640, 14));           // Posicao 640 a 653
    strValIp4 := Trim(Copy(stlFrete[intLinha], 654, 14));           // Posicao 654 a 667
    strBasSu4 := Trim(Copy(stlFrete[intLinha], 668, 14));           // Posicao 668 a 681
    strDesAc4 := Trim(Copy(stlFrete[intLinha], 682, 14));           // Posicao 682 a 695
    strValIs4 := Trim(Copy(stlFrete[intLinha], 696, 14));           // Posicao 696 a 709

    {*****************************************}
    {* A CLASSIFICAÇÃO SERÁ SEMPRE 1353 FIXO *}
    {**************************************PZ*}
    //strClaFi5 := Trim(Copy(stlFrete[intLinha], 710, 04));           // Posicao 710 a 713
    strClaFi5 := strClaFi1;
    strValCo5 := Trim(Copy(stlFrete[intLinha], 714, 14));           // Posicao 714 a 727
    strBasIc5 := Trim(Copy(stlFrete[intLinha], 728, 14));           // Posicao 728 a 741
    strAlqIc5 := Trim(Copy(stlFrete[intLinha], 742, 14));           // Posicao 742 a 755
    strValIc5 := Trim(Copy(stlFrete[intLinha], 756, 14));           // Posicao 756 a 769
    strValOu5 := Trim(Copy(stlFrete[intLinha], 770, 14));           // Posicao 770 a 783
    strValIs5 := Trim(Copy(stlFrete[intLinha], 784, 14));           // Posicao 784 a 797
    strValRe5 := Trim(Copy(stlFrete[intLinha], 798, 14));           // Posicao 798 a 811
    strBasIp5 := Trim(Copy(stlFrete[intLinha], 812, 14));           // Posicao 812 a 825
    strValIp5 := Trim(Copy(stlFrete[intLinha], 826, 14));           // Posicao 826 a 839
    strBasSu5 := Trim(Copy(stlFrete[intLinha], 840, 14));           // Posicao 840 a 853
    strDesAc5 := Trim(Copy(stlFrete[intLinha], 854, 14));           // Posicao 854 a 867
    strValIs5 := Trim(Copy(stlFrete[intLinha], 868, 14));           // Posicao 868 a 881
    //strC_G_C_ := Trim(Copy(stlFrete[intLinha], 882, 14));           // Posicao 882 a 895

    FValTot   := (FValCo1 + FValCo2 + FValCo3 + FValCo4 + FValCo5);

    Try
      Result := fValidaValores;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + E.Message, intLinha + 1);
        Continue;
      End;
    End;

    If fVerificaDocumento Then
    Begin
      Result := False;
      pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + ' já existe no sistema!', intLinha + 1);
      Continue;
    End
    Else
    Begin
      qryTabela.Append;
      pEnviaDados;
      qryTabela.Post;
      pEscreveMensagemImportacao(memLog, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' +
                                         'carregado com sucesso (Valor: '+FormatFloat('##,#.00', FValTot)+ ')!', intLinha + 1);
    End;

  End;
end;

function TFreCon.fTipoDocFreteToChar(ATipoDocFrete: TTipoDocFrete): String;
begin
  Case  ATipoDocFrete of
   tpdfCompra: Result := 'C';
   tpdfVenda: Result := 'V';
   tpdfDevolucaoCompra: Result := 'DC';
   tpdfDevolucaoVenda: Result := 'D';
  Else
    Result := '';
  end

end;

function TFreCon.fCharToTipoDocFrete(AstrTipoDocFrete: String): TTipoDocFrete;
begin
  Result := tpdfIndefinido;
  If AstrTipoDocFrete = 'C' Then
    Result := tpdfCompra
  Else If AstrTipoDocFrete = 'V' Then
    Result := tpdfVenda
  Else If AstrTipoDocFrete = 'D' Then
    Result := tpdfDevolucaoVenda
  Else If AstrTipoDocFrete = 'DC' Then
    Result := tpdfDevolucaoCompra;
end;

function TFreCon.fGeraDadosImportacao: Boolean;
var
    memLog: TStringList;
begin
  qryTabela.EmptyDataSet;
  cdsNotasFiscais.EmptyDataSet;

  Try
    memLog := TStringList.Create;

    FMemLog :=  memLog;
    FMemErr :=  memLog;

    qryTabela.BeforePost := Nil;

    qryCTes.First;
    While Not qryCTes.Eof Do
    Begin
      qryTabela.Append;
      qryTabela.FieldByName('IMPORT').AsString := 'S';
      qryTabela.FieldByName('STATUS').AsInteger := IMPORTADO_OK;

      FValTot  := 0.0;
      FImpFre  := True;
      FmemLog.Clear;
      FmemErr.Clear;

      Result := fCarregaDadosCTe(FmemLog, FmemErr, (tpFrete = tpfEntrada));

      If Not Result Then
      Begin
        If FStatus = 0 Then
          FStatus := IMPORTADO_COM_ERRO;

        qryTabela.FieldByName('STATUS').AsInteger := FStatus;
        qryTabela.FieldByName('IMPORT').AsString  := 'N';
      End;

      qryTabela.FieldByName('LOGIMP').AsString := memLog.Text;

      pEnviaDados;

      If Not fEmptyStr(qryTabela.FieldByName('CODTRA').AsString) Then
        qryTabela.FieldByName('NOMTRA').AsString := fRetNomFornecedor(qryTabela.FieldByName('CODTRA').AsString);

      qryTabela.Post;

      if blnImportaPeloBancoDados then
        Break;

      qryCTes.Next;
    End;

    qryTabela.Filter   := 'IMPORT = ' + QuotedStr('S');
    qryTabela.Filtered := True;
    Result := (qryTabela.RecordCount > 0);
    if not Result then
      Exit;

    If (tpFrete = tpfEntrada) and (blnUtiAbr) Then
    begin
      Try
        FAtulizarTabela := True;

        Result := fCarregaAbrevPisCofPrg(nil);
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[TFreCon.fGeraDadosImportacao]');
        End;
      End;
    end
    Else
      Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarErro(True, FmemErr.ToString + 'Erro: ' + E.Message, '[TFreCon.fGeraDadosImportacao]');
    End;
  End;

  FreeAndNil(memLog);

  If (tpFrete = tpfSaida) Then
    fLocalizaNotas(nil);

  FMemLog := Nil;
  FMemErr := Nil;
end;

function TFreCon.fGetCodEmp(CNPJ: string): string;
  var
   qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery(nil);
  try
    qryConsulta.SQL.Text := 'SELECT E.EMP_CODEMP FROM CADEMP E WHERE E.EMP_C_G_C_ = "' + CNPJ + '"';
    qryConsulta.Open;
    Result := '';
    If Not qryConsulta.IsEmpty Then
       Result := qryConsulta.FieldByName('EMP_CODEMP').AsString;
  Finally
    If Result = '' then
       Result := VS_strCodEmp;
    FreeAndNil(qryConsulta);
  end;
end;

function TFreCon.fRetEmpresaPeloCGCLocal(strEMP_C_G_C_: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  If fEmptyStr(strEMP_C_G_C_) Then
    Exit('');
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_CODEMP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_C_G_C_ = :EMP_C_G_C_ ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('EMP_C_G_C_').AsString := strEMP_C_G_C_;
      Open;
      Result := FieldByName('EMP_CODEMP').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

function TFreCon.fRetEstadoEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
Begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('CID_ESTADO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

function TFreCon.fRetornaClaFisNFe: String;
Var
  LQryCon: TUniQuery;
  LAcesso: String;
begin
  LAcesso := '';
  Result := '';

  If (Not cdsNotasFiscais.Active) Or (cdsNotasFiscais.IsEmpty) Then
    Exit;

  cdsNotasFiscais.First;
  While Not cdsNotasFiscais.EOF Do
  Begin
    LAcesso := LAcesso + QuotedStr(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString) + ',';
    cdsNotasFiscais.Next;
  End;

  If (Not fEmptyStr(LAcesso)) Then
  Begin
    LAcesso := Copy(LAcesso, 1, Length(LAcesso) -1);

    LQryCon := fCriaQuery;
    Try
      LQryCon.SQL.Add('  SELECT FIS_CLFSC1 ');
      LQryCon.SQL.Add('  FROM CADFIS F ');
      LQryCon.SQL.Add('    WHERE F.FIS_ACESSO IN (' + LAcesso + ')');
      LQryCon.Open;
      Result := LQryCon.FieldByName('FIS_CLFSC1').AsString;
    Finally
      FreeAndNil(LQryCon);
    End;
  End;
end;

function TFreCon.fRetornaCNPJTomador(xmlDoc: TXMLDocument;
  intTomador: integer): string;
  var tagTomador: string;
      nodXml: IXMLNode;
      blnMod67 : Boolean;
begin
  Result := '';
  tagTomador := fGetTagTomador(intTomador);
  If tagTomador = '' Then
    Exit('');

  pGetTagRaizCte(xmlDoc, nodXml, blnMod67);
  If not blnMod67 Then
    nodXml := nodXml.ChildNodes.FindNode('CTe');

  nodXml := nodXml.ChildNodes.FindNode('infCte');
  nodXml := nodXml.ChildNodes.FindNode(tagTomador);
  nodXml := nodXml.ChildNodes.FindNode('CNPJ');
  If Assigned(nodXml) Then
    exit(nodXml.NodeValue);
end;

function TFreCon.fValidaPessoasCompra(var strErro: String): TTipoDocFrete;
Begin

  Result := tpdfCompra;

  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD FROM CADFOR');
  qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
  qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FEmitente.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FEmitente.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FEmitente.cMun;
  qryGeneric.Open;
  {$region 'EMITENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE)'}
 {EMITENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE)}
  qryGeneric.Open;
  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Compra: Divergência entre CNPJ + UF + Código do Município para o Emitente No Cadastro de Fornecedor';
    Exit;
  End;
  {$endregion}

  {$region 'REMETENTE:VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE)'}
  {REMETENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD FROM CADFOR');
  qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
  qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FRemetente.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FRemetente.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FRemetente.cMun;

  qryGeneric.Open;
  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é Compra: Divergência entre CNPJ + UF + Código do Município para o Remetente No Cadastro de Fornecedor';
    Exit;
  End;
  {$endregion}

  {$region 'DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE)'}
  {DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADEMP');
  qryGeneric.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
  qryGeneric.SQL.Add(' WHERE EMP_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('   AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('   AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
  qryGeneric.Open;

  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é Compra: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Empresa';
    Exit;
  End;
  {$endregion}
End;

function TFreCon.fValidaPessoasVendas(var strErro: String): TTipoDocFrete;
Begin


  Result := tpdfVenda;
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADFOR');
  qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
  qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FEmitente.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FEmitente.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FEmitente.cMun;
  qryGeneric.Open;

  {$region 'EMITENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE)'}
 {EMITENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE)}
  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é venda: Divergência entre CNPJ + UF + Código do Município para o Emitente No Cadastro de Fornecedor';
    Exit;
  End;
  {$endregion}
  {$region 'DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE CLIENTES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
  If FDestinatario.strUF <> 'EX' Then
  begin
    If (fCampoTabela('COUNT(1)', 'CADCLI', ['CLI_C_G_C_'], [FDestinatario.strCNPJ]) > 0 ) Then
    Begin
      {DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE CLIENTES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
      qryGeneric.SQL.Clear;
      qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADCLI');
      qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = CLI_CODCID');
      qryGeneric.SQL.Add('WHERE CLI_C_G_C_ = :C_G_C_');
      qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
      qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
      qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
      qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
      qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
      qryGeneric.Open;
      If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
      Begin
        If blnVerificarEndEntrega Then
        Begin
          qryGeneric.SQL.Clear;
          qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM ENTCLI');
          qryGeneric.SQL.Add('INNER JOIN CADCLI ON ETC_CODCLI = ETC_CODCLI');
          qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT');
          qryGeneric.SQL.Add('WHERE CLI_C_G_C_ = :C_G_C_');
          qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
          qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
          qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
          qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
          qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
          qryGeneric.Open;
          If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
          Begin
            Result :=  tpdfIndefinido;
            strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é venda: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Cliente';
            Exit;
          End;
        End
        Else
        Begin
          Result :=  tpdfIndefinido;
          strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é venda: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Cliente';
          Exit;
        End;
      End;
    End
    Else If (fCampoTabela('COUNT(1)', 'CADFOR', ['FOR_C_G_C_'], [FDestinatario.strCNPJ]) > 0 ) Then
    Begin
     {DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDOR(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE), PODE OCORRER SAÍDA PARA FORNECEDOR (DEVOLUÇÃO DE COMPRA) req 284260 }
      qryGeneric.SQL.Clear;
      qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADFOR');
      qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
      qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
      qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
      qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
      qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
      qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
      qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
      qryGeneric.Open;
      If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
      Begin
        Result :=  tpdfIndefinido;
        strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é devolução: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Forcedores';
        Exit;
      End;
    End
    Else
    Begin
      Result :=  tpdfIndefinido;
      strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é venda: O CNPJ: ' + FDestinatario.strCNPJ + ' do Destinatário não está cadastrado, por favor verificar o cadastro de clientes. ';
      Exit;
    End;
  End;
  {$endregion}

  {$region 'REMETENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
  {REMETENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADEMP');
  qryGeneric.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
  qryGeneric.SQL.Add(' WHERE EMP_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('   AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('   AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FRemetente.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FRemetente.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FRemetente.cMun;
  qryGeneric.Open;


  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é venda: Divergência entre CNPJ + UF + Código do Município para o Remetente No Cadastro de Empresa';
    Exit;
  End;
  {$endregion}

End;


function TFreCon.fValidaPessoasDevolucaoCompra(var strErro: String): TTipoDocFrete;
begin
  strErro := '';
  Result := tpdfDevolucaoCompra;

//  REMETENTE: CADASTRO DE EMPRESA (POIS A PROPRIA  EMPRESA EMITIU A NOTA DE DEVOLUÇÃO)
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADEMP');
  qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
  qryGeneric.SQL.Add('WHERE EMP_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FRemetente.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FRemetente.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FRemetente.cMun;
  qryGeneric.Open;
  If (qryGeneric.FieldByName('QTD').AsInteger = 0 ) Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Devolução de compra: Divergência entre CNPJ + UF + Código do Município para o Remente No Cadastro de Empresa';
    Exit;
  End;

//  EMITENTE: CADASTRO DE FORNECEDOR (O EMITENTE DO CTE SERÁ A TRANSPORTADORA QUE IRÁ REALIZAR A ENTREGA)
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADFOR');
  qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
  qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FEmitente.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FEmitente.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FEmitente.cMun;
  qryGeneric.Open;

  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Devolução de Compra: Divergência entre CNPJ + UF + Código do Município para o Emitente No Cadastro de Fornecedor';
    Exit;
  End;

//  DESTINATARIO: CADASTRO DE FORNECEDOR (O DESTINATARIO SERÁ O FORNECEDOR QUE A EMPRESA ESTÁ DEVOLVENDO A COMPRA)
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADFOR');
  qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
  qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
  qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
  qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
  qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
  qryGeneric.Open;
  If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
  Begin
    Result :=  tpdfIndefinido;
    strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Devolução de Compra: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Fornecedor';
    Exit;
  End;
End;

function TFreCon.fValidaPessoasDevolucao(var strErro: String): TTipoDocFrete;
Begin
  strErro := '';
  Result := tpdfDevolucaoVenda;
  If FExpedidor.strCNPJ <> '' Then
  Begin
    {$Region 'EXPEDIDOR: VALIDAR OS DADOS DO XML COM O CADASTRO DE CLEINTES(CPF/CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADCLI');
    qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = CLI_CODCID');
    qryGeneric.SQL.Add('WHERE CLI_C_G_C_ = :C_G_C_');
    qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
    qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
    qryGeneric.ParamByName('C_G_C_').AsString := FExpedidor.strCNPJ;
    qryGeneric.ParamByName('ESTADO').AsString := FExpedidor.strUF;
    qryGeneric.ParamByName('COIBGE').AsString := FExpedidor.cMun;
    qryGeneric.Open;

    If (qryGeneric.FieldByName('QTD').AsInteger = 0 ) And (FExpedidor.strCNPJ = FRemetente.strCNPJ) Then
    Begin
      Result :=  tpdfIndefinido;
      strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Expedidor No Cadastro de Cliente';
      Exit;
    End
    Else If (qryGeneric.FieldByName('QTD').AsInteger = 0 ) Then
    Begin

      qryGeneric.SQL.Clear;
      qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADFOR');
      qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
      qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
      qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
      qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
      qryGeneric.ParamByName('C_G_C_').AsString := FExpedidor.strCNPJ;
      qryGeneric.ParamByName('ESTADO').AsString := FExpedidor.strUF;
      qryGeneric.ParamByName('COIBGE').AsString := FExpedidor.cMun;
      qryGeneric.Open;

      If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
      Begin
        Result :=  tpdfIndefinido;
        strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Expedidor No Cadastro de Fornecedor';
        Exit;
      End
    End;
    {$endregion}

    {$region'SE RECEBEDOR PREENCHIDO: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
    If FRecebedor.strCNPJ <> '' Then
    Begin

      qryGeneric.SQL.Clear;
      qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADEMP');
      qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
      qryGeneric.SQL.Add('WHERE EMP_C_G_C_ = :C_G_C_');
      qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
      qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
      qryGeneric.ParamByName('C_G_C_').AsString := FRecebedor.strCNPJ;
      qryGeneric.ParamByName('ESTADO').AsString := FRecebedor.strUF;
      qryGeneric.ParamByName('COIBGE').AsString := FRecebedor.cMun;
      qryGeneric.Open;
      If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
      Begin
        Result :=  tpdfIndefinido;
        strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Recebedor No Cadastro de Empresa';
        Exit;
      End;
    End
    {$endregion}
    Else
    {$region'DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
    Begin
      qryGeneric.SQL.Clear;
      qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADEMP');
      qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
      qryGeneric.SQL.Add('WHERE EMP_C_G_C_ = :C_G_C_');
      qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
      qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
      qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
      qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
      qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
      qryGeneric.Open;
      If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
      Begin
        Result :=  tpdfIndefinido;
        strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Empresa';
        Exit;
      End;
    End;
   {$endregion}
  End
  Else
  Begin
    {$Region 'EMITENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADFOR');
    qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = FOR_CODCID');
    qryGeneric.SQL.Add('WHERE FOR_C_G_C_ = :C_G_C_');
    qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
    qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
    qryGeneric.ParamByName('C_G_C_').AsString := FEmitente.strCNPJ;
    qryGeneric.ParamByName('ESTADO').AsString := FEmitente.strUF;
    qryGeneric.ParamByName('COIBGE').AsString := FEmitente.cMun;
    qryGeneric.Open;


    {EMITENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE FORNECEDORES(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
    If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
    Begin
      Result :=  tpdfIndefinido;
      strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Emitente No Cadastro de Fornecedor';
      Exit;
    End;
    {$EndRegion}


    {$Region 'REMETENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE CLEINTES(CPF/CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
    {REMETENTE: VALIDAR OS DADOS DO XML COM O CADASTRO DE CLEINTES(CPF/CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADCLI');
    qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = CLI_CODCID');
    qryGeneric.SQL.Add('WHERE CLI_C_G_C_ = :C_G_C_');
    qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
    qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
    qryGeneric.ParamByName('C_G_C_').AsString := FRemetente.strCNPJ;
    qryGeneric.ParamByName('ESTADO').AsString := FRemetente.strUF;
    qryGeneric.ParamByName('COIBGE').AsString := FRemetente.cMun;
    qryGeneric.Open;
    If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
    Begin
     Result :=  tpdfIndefinido;
     strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') + 'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Remetente No Cadastro de Cliente';
     Exit;
    End;
    {$endregion}

    {$region'DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).'}
    {DESTINATARIO: VALIDAR OS DADOS DO XML COM O CADASTRO DE EMPRESAS(CNPJ + UF + CODIGO DO MUNICIPIO-IBGE).}
    qryGeneric.SQL.Clear;
    qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD  FROM CADEMP');
    qryGeneric.SQL.Add('INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
    qryGeneric.SQL.Add('WHERE EMP_C_G_C_ = :C_G_C_');
    qryGeneric.SQL.Add('  AND CID_ESTADO = :ESTADO');
    qryGeneric.SQL.Add('  AND CID_COIBGE = :COIBGE');
    qryGeneric.ParamByName('C_G_C_').AsString := FDestinatario.strCNPJ;
    qryGeneric.ParamByName('ESTADO').AsString := FDestinatario.strUF;
    qryGeneric.ParamByName('COIBGE').AsString := FDestinatario.cMun;
    qryGeneric.Open;
    If qryGeneric.FieldByName('QTD').AsInteger = 0 Then
    Begin
      Result :=  tpdfIndefinido;
      strErro := strErro + IIF(Not fEmptyStr(strErro), #13, '') +'Não é Devolução: Divergência entre CNPJ + UF + Código do Município para o Destinatário No Cadastro de Empresa';
      Exit;
    End;
    {$endregion}
  End;

End;

function TFreCon.fRetonarTipoDeFrete(var strErro: String): TTipoDocFrete;
var erroIgnorar: string;
begin
  If (tpFrete = tpfSaida) Then
  Begin
    Result := fValidaPessoasVendas(strErro);

    If  Result = tpdfVenda then
      If (not blnTransferencia) and (fValidaPessoasDevolucao(erroIgnorar) = tpdfDevolucaoVenda)  then
        Result := tpdfDevolucaoVenda;

    If (Result <> tpdfIndefinido) Then
      Exit;
    qryGeneric.SQL.Clear;
    Result := fValidaPessoasDevolucaoCompra(strErro);
  End
  Else
  Begin
    Result := fValidaPessoasCompra(strErro);

    If Result = tpdfCompra then
      If (FTransf = 'N') And (fValidaPessoasDevolucaoCompra(erroIgnorar) = tpdfDevolucaoCompra) Then
        Result := tpdfDevolucaoCompra;

    If (Result <> tpdfIndefinido) Then
      Exit;
    qryGeneric.SQL.Clear;
    Result := fValidaPessoasDevolucao(strErro);
  End;

end;


procedure TFreCon.pMontaDuplicatasXMl;
  Var
    stlVencimentos: TStringList;
    intContador: Integer;
    strValor: String;
Begin
  stlVencimentos := TStringList.Create;
  stlVencimentos.Text := FDuplic;

  pZeraDigDuplic(arrDuplicata);
  FillChar(arrLinDigCodbar, Sizeof(arrLinDigCodbar), #0);

  For intContador := 0 To stlVencimentos.Count - 1 Do
  Begin
    strValor := stlVencimentos[intContador];

    If StrToDateDef(LeftStr(strValor, 10), 0) > 0 Then
      arrDuplicata[intContador].dtaDtaVen := LeftStr(strValor, 10);

    Delete(strValor, 1, 11);

    arrDuplicata[intContador].curValor  := fStrToFloat(strValor);
    arrDuplicata[intContador].strSequen := String(arrLetras[intContador]);
  End;

  stlVencimentos.Text := FLinDig;
  For intContador := 0 To stlVencimentos.Count - 1 Do
    If intContador <= High(arrLinDigCodbar) Then
      arrLinDigCodbar[intContador].strLinDig := stlVencimentos[intContador];

  stlVencimentos.Text := FCodBar;
  For intContador := 0 To stlVencimentos.Count - 1 Do
    If intContador <= High(arrLinDigCodbar) Then
      arrLinDigCodbar[intContador].strCodBar := stlVencimentos[intContador];

  FreeAndNil(stlVencimentos);
end;

procedure TFreCon.pCriaClientNotas;
begin
  cdsNotEnt := TZClient.Create(Self, fSqlNotas);
  cdsNotEnt.fAbreClient(True, 'TFreCon.pCriaClientNotas');
  cdsNotEnt.pFormataDecimal('VLRCON');
  cdsNotEnt.pCriaSoma('PERREP', 'TOTREP');
  cdsNotEnt.pCriaSoma('VLRCON', 'TOTCON');

  FNotEnt := fCriaQuery(Self);
end;

procedure TFreCon.pDefinePagadorDoFrete(xmlDoc : TXMLDocument);
  var
    nodXml: IXMLNode;
    intTomador: integer;
    cnpjTomador: string;
    blnMod67 : Boolean;
begin
//LocalizaTomador
  intTomador := 0;
  pGetTagRaizCte(xmlDoc, nodXml, blnMod67);
  If not blnMod67 Then
    nodXml := nodXml.ChildNodes.FindNode('CTe');

  nodXml := nodXml.ChildNodes.FindNode('infCte');

  If not blnMod67 Then
  Begin
    nodXml := nodXml.ChildNodes.FindNode('ide');
    nodXml := nodXml.ChildNodes.FindNode('toma3');
    If Assigned(nodXml) Then
      intTomador := nodXml.ChildNodes.FindNode('toma').NodeValue;

    cnpjTomador := fRetornaCNPJTomador(xmlDoc, intTomador);
  End
  Else
  Begin
    nodXml := nodXml.ChildNodes.FindNode('toma');
    If Assigned(nodXml) Then
    Begin
      nodXml := nodXml.ChildNodes.FindNode('CNPJ');
      If Assigned(nodXml) Then
        cnpjTomador := nodXml.Text;
    End;
  End;


  pTomadorEEmpresaCadastrada(cnpjTomador, FEmpresaPagadora);
end;

function TFreCon.fSqlNotas: String;
Begin
  Result := '/* untEntFreCon.fSqlNotas */ ';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   G.AUTOINCREM AS AUTINC, ';
  Result := Result + '   GER_DTAENT   AS DTAENT, ';
  Result := Result + '   GER_NUMDOC   AS NUMDOC, ';
  Result := Result + '   GER_ESPDOC   AS ESPDOC, ';
  Result := Result + '   GER_SERIE_   AS SERIE_, ';
  Result := Result + '   GER_CODFOR   AS CODFOR, ';
  Result := Result + '   GER_VLRCON   AS VLRCON, ';
  Result := Result + '   FOR_NOMFOR   AS NOMFOR, ';
  Result := Result + '   ""           AS MATREV  ';
  Result := Result + ' FROM ';
  Result := Result + '   MOVGER G ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  Result := Result + ' WHERE FALSE ';
end;

function TFreCon.fXmlToBanco(prgProgresso: TProgressBar): Boolean;
  Var
    memLog: TStringList;
    blnNotaNaoIdentificada: Boolean;
Begin
  Try
    memLog := TStringList.Create;

    FMemLog :=  memLog;
    FMemErr :=  memLog;

    With qryTabela Do
    Begin
      DisableControls;
      BeforePost := Nil;
      if Assigned(prgProgresso) Then
      begin
        prgProgresso.Position := 0;
        prgProgresso.Max      := RecordCount;
        prgProgresso.Visible  := True;
      End;

      First;
      While Not Eof Do
      Begin
        Edit;

        memLog.Clear;

        If fCarregaArquivoFrete(FstrPath + FieldByName('NOMARQ').AsString, memLog, memLog, Not blnXMLEvento, blnNotaNaoIdentificada) Then
        Begin
          If blnNotaNaoIdentificada Then
          Begin
            FieldByName('STATUS').AsInteger := IMPORTADO_OK_SEM_NF;
            FieldByName('IMPORT').AsString  := 'N';

          End
          Else
            FieldByName('STATUS').AsInteger := IMPORTADO_OK;
        End Else
        Begin
          If FStatus = 0 Then
            FStatus := IMPORTADO_COM_ERRO;

          FieldByName('STATUS').AsInteger := FStatus;
          FieldByName('IMPORT').AsString  := 'N';
        End;

        FieldByName('LOGIMP').AsString := memLog.Text;
        If Not blnXMLEvento Then
        Begin
           If FieldByName('STATUS').AsInteger = IMPORTADO_OK Then
             If (FieldByName('AUTPIS').AsString = '') Or (FieldByName('AUTCOF').AsString = '') Then
               FieldByName('STATUS').AsInteger := IMPORTADO_SEM_PISCOF;
        End;

        pEnviaDados;

        If Not fEmptyStr(FieldByName('CODTRA').AsString) Then
          FieldByName('NOMTRA').AsString := fRetNomFornecedorInt(FieldByName('CODTRA').AsString);

        Post;

        Next;
        If Assigned(prgProgresso) Then
           prgProgresso.StepBy(1);
        Application.ProcessMessages;
      End;
    End;

  //  If (tpFrete = tpfEntrada) Then
      Result := fCarregaAbrevPisCof;
  //  Else
   //   Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fXmlToBanco]');
    End;
  End;

  FreeAndNil(memLog);

  qryTabela.BeforePost := pBeforePost;
  qryTabela.EnableControls;
  qryTabela.First;
  If Assigned(prgProgresso) Then
    prgProgresso.Visible := False;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    With frmGravando Do
    Begin
      lblGravando.Caption := 'Vinculando os documentos com as notas anexas ao CTe...';
      fExecutarAcao := fLocalizaNotas;
      ShowModal;
    End;

  Finally
    FreeAndNil(frmGravando);
  End;

  FMemLog := Nil;
  FMemErr := Nil;
end;


function TFreCon.fLocalizaNotas(prgProgresso: TcxProgressBar): Boolean;
  var
    lstTodasChaves : TStringList;
begin
  lstTodasChaves := TStringList.Create;
  Try
    Try
      cdsNotasFiscais.Filtered := False;
      cdsNotasFiscais.Filter := '';

      cdsNotasFiscais.First;
      FConsulta.SQL.Clear;
      FConsulta.SQL.Add('SELECT CADFIS.FIS_CODEMP,');
      FConsulta.SQL.Add('       CADFIS.FIS_NUMDOC,');
      FConsulta.SQL.Add('       CADFIS.FIS_ESPDOC,');
      FConsulta.SQL.Add('       CADFIS.FIS_ACESSO,');
      FConsulta.SQL.Add('       IFNULL(NOTGER.AUTOINCREM, MOVGER.AUTOINCREM) AS MOV_GERSEQ, ');
      FConsulta.SQL.Add('       NOTGER.AUTOINCREM AS NOT_GERSEQ, ');
      FConsulta.SQL.Add('       IF(IFNULL(MOVGER.GER_TIP_FC, NOTGER.GER_TIP_FC) = "F" ,');
      FConsulta.SQL.Add('        (SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = IFNULL(MOVGER.GER_CODFOR, NOTGER.GER_CODFOR)),');
      FConsulta.SQL.Add('        (SELECT CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = IFNULL(MOVGER.GER_CODCLI, NOTGER.GER_CODCLI))) AS NOMDES,');
      FConsulta.SQL.Add('       CADFIS.FIS_HISTOR');
      FConsulta.SQL.Add('  FROM CADFIS');
      FConsulta.SQL.Add(' LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC ');
      FConsulta.SQL.Add('                  AND MOVGER.GER_ESPDOC = FIS_ESPDOC ');
      FConsulta.SQL.Add('                  AND MOVGER.GER_CODEMP = FIS_CODEMP ');
      FConsulta.SQL.Add('                  AND IF(FIS_TIP_FC = "C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) = FIS_FORCLI');
      If tpFrete = tpfSaida Then
        FConsulta.SQL.Add('                  AND MOVGER.GER_CLAFIS >= 5000 ')
      Else
        FConsulta.SQL.Add('                  AND MOVGER.GER_CLAFIS < 5000 ');

      FConsulta.SQL.Add(' LEFT JOIN NOTGER ON NOTGER.GER_NUMDOC = FIS_NUMDOC ');
      FConsulta.SQL.Add('                  AND NOTGER.GER_ESPDOC = FIS_ESPDOC ');
      FConsulta.SQL.Add('                  AND NOTGER.GER_CODEMP = FIS_CODEMP ');
      FConsulta.SQL.Add('                  AND IF(FIS_TIP_FC = "C", NOTGER.GER_CODCLI, NOTGER.GER_CODFOR) = FIS_FORCLI');
      If tpFrete = tpfSaida Then
        FConsulta.SQL.Add('                  AND NOTGER.GER_CLAFIS >= 5000 ')
      Else
        FConsulta.SQL.Add('                  AND NOTGER.GER_CLAFIS < 5000 ');

      FConsulta.SQL.Add(' WHERE TRUE ');
      FConsulta.SQL.Add('   AND FIS_ESPDOC = "NF"');
      FConsulta.SQL.Add('   AND FIS_ACESSO  IN (:CHAVES)');

      If tpFrete = tpfSaida Then
        FConsulta.SQL.Add('                  AND CADFIS.FIS_CLFSC1 >= 5000 ')
      Else
        FConsulta.SQL.Add('                  AND CADFIS.FIS_CLFSC1 < 5000 ');


      // Seleciona todas as chaves de nfes encontradas
      lstTodasChaves.Clear;

      while not cdsNotasFiscais.Eof Do
      Begin
        If not fEmptyStr(cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString) Then
        Begin
          If lstTodasChaves.Text <> '' Then
            lstTodasChaves.Add(', "' + cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString + '"')
          Else
            lstTodasChaves.Add('"' + cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString + '"');
        End;
        cdsNotasFiscais.Next;
      End;
      cdsNotasFiscais.First;
      If Not fEmptyStr(lstTodasChaves.Text) Then
      Begin
        FConsulta.SQL.Text := StringReplace(FConsulta.SQL.Text, ':CHAVES', lstTodasChaves.Text, []);
        FConsulta.Open;
        FConsulta.IndexFieldNames := 'FIS_ACESSO';
        FConsulta.KeyFields := 'FIS_ACESSO';
        if Assigned(prgProgresso) then
        begin
          prgProgresso.Position := 0;
          prgProgresso.Properties.Max := cdsNotasFiscais.RecordCount;
          prgProgresso.Visible  := True;
        end;

        While not cdsNotasFiscais.Eof Do
        Begin
          cdsNotasFiscais.Edit;
          FConsulta.First;
          // Caso seja encontrado carrega as informações referente a nota fiscal
          If (FConsulta.FindKey([cdsNotasFiscais.FieldByName('NFE_ACESSO').AsString])) aND
             (Not(fEmptyStr(FConsulta.FieldByName('MOV_GERSEQ').AsString))) Then
          Begin
            cdsNotasFiscais.FieldByName('FIS_CODEMP').Value := FConsulta.FieldByName('FIS_CODEMP').Value;
            cdsNotasFiscais.FieldByName('FIS_NUMDOC').Value := fStrZero(FConsulta.FieldByName('FIS_NUMDOC').AsString, fTamNumDoc);
            cdsNotasFiscais.FieldByName('FIS_ESPDOC').Value := FConsulta.FieldByName('FIS_ESPDOC').Value;
            cdsNotasFiscais.FieldByName('MOV_GERSEQ').Value := FConsulta.FieldByName('MOV_GERSEQ').Value;
            cdsNotasFiscais.FieldByName('NFE_DESTINATARIO').Value := FConsulta.FieldByName('NOMDES').Value;
            cdsNotasFiscais.FieldByName('LOC_IMPORT').Value := 'S';
            If FConsulta.FieldByName('NOT_GERSEQ').AsString <> '' Then
              cdsNotasFiscais.FieldByName('NOTGER').AsString := 'S';
          End
          //   Senão carrega apenas como sugestão a serie e a empresa
          // para serem exibido no grid para informar o Documento referente ao cte
          Else
          Begin

            cdsNotasFiscais.FieldByName('FIS_CODEMP').Value := VS_StrCodEmp;
            cdsNotasFiscais.FieldByName('FIS_ESPDOC').Value := 'NF';
            cdsNotasFiscais.FieldByName('MOV_GERSEQ').Value := '';
            cdsNotasFiscais.FieldByName('LOC_IMPORT').Value := 'N';

          End;
          cdsNotasFiscais.FieldByName('FIS_HISTOR').Value := FConsulta.FieldByName('FIS_HISTOR').Value;
          cdsNotasFiscais.Post;
          cdsNotasFiscais.Next;
          if Assigned(prgProgresso) then
          begin
            prgProgresso.Position := cdsNotasFiscais.RecNo;
            Application.ProcessMessages;
          end;
        End;
      End;

    Except
      On E: Exception Do
         pEscreveMensagemImportacao(FMemLog, 'Erro ao tentar localizar as NFe-s' + #13 + e.message);
    End;
  Finally
    FreeAndNil(lstTodasChaves);
    FreeAndNil(FConsulta);
    FConsulta := fCriaQuery();
  End;

  Result := True;

end;

function TFreCon.fMarcaCTeComErro: Boolean;
var
  qryAux: TUniQuery;
  strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  MOVCTE ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTE_IMPORT = "E", ';
  strSQL := strSQL + '  CTE_IMPERR = :IMPERR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTE_NUMCTE = :NUMCTE ';
  strSQL := strSQL + '  AND CTE_CODEMP = :CODEMP';
  qryAux := fCriaQuery();
  try
    try
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('NUMCTE').AsString := qryCTes.FieldByName('CTE_NUMCTE').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryCTes.FieldByName('CTE_CODEMP').AsString;
      qryAux.ParamByName('IMPERR').AsString := FMemErr.Text;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add(AnsiReplaceStr(strSQL, 'MOVCTE', 'NOTCTE'));
      qryAux.ParamByName('NUMCTE').AsString := qryCTes.FieldByName('CTE_NUMCTE').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryCTes.FieldByName('CTE_CODEMP').AsString;
      qryAux.ParamByName('IMPERR').AsString := FMemErr.Text;
      qryAux.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TFreCon.fMarcaCTeImportado: Boolean;
var
  qryAux: TUniQuery;
  strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  MOVCTE ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTE_IMPORT = "S" ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTE_NUMCTE = :NUMCTE ';
  strSQL := strSQL + '  AND CTE_CODEMP = :CODEMP';
  qryAux := fCriaQuery();
  try
    try
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('NUMCTE').AsString := qryCTes.FieldByName('CTE_NUMCTE').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryCTes.FieldByName('CTE_CODEMP').AsString;
      qryAux.ExecSQL;

      qryAux.SQL.Clear;
      qryAux.SQL.Add(AnsiReplaceStr(strSQL, 'MOVCTE', 'NOTCTE'));
      qryAux.ParamByName('NUMCTE').AsString := qryCTes.FieldByName('CTE_NUMCTE').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryCTes.FieldByName('CTE_CODEMP').AsString;
      qryAux.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAux);
  end
end;

function TFreCon.fGetSqlComplementos: string;
Begin
  Result := '';
  Result := Result + 'SELECT COM_CTEORI, ';
  Result := Result + '       COM_CTECOM, ';
  Result := Result + '       CAST("" AS CHAR(44)) AS COM_CHAVE_, ';
  Result := Result + '       CAST("" AS CHAR(44)) AS ORI_CHAVE_ ';
  Result := Result + '  FROM CTECOM ';
End;

function TFreCon.fGetSQLDadosCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  ET.EMP_C_G_C_ AS EMITENTE_CNPJ, ';
  Result := Result + '  ET.EMP_NOMEMP AS EMITENTE_RAZAOSOCIAL, ';
  Result := Result + '  IF(IFNULL(ET.EMP_I_E_S_, "") = "", "ISENTO", ET.EMP_I_E_S_) AS EMITENTE_IE, ';
  Result := Result + '  CT.CID_ESTADO AS EMITENTE_UF, ';
  Result := Result + '  EC.EMP_C_G_C_ AS REMETENTE_CNPJ, ';
  Result := Result + '  EC.EMP_NOMEMP AS REMETENTE_RAZAOSOCIAL, ';
  Result := Result + '  IF(IFNULL(EC.EMP_I_E_S_, "") = "", "ISENTO", EC.EMP_I_E_S_) AS REMETENTE_IE, ';
  Result := Result + '  CC.CID_ESTADO AS REMETENTE_UF, ';
  Result := Result + '  CLI_C_G_C_ AS DESTINATARIO_CNPJ, ';
  Result := Result + '  CLI_NOMCLI AS DESTINATARIO_RAZAOSOCIAL, ';
  Result := Result + '  IF(CLI_CGCCPF = 1 AND IFNULL(CLI_I_E_S_, "") <> "", CLI_I_E_S_, "ISENTO") AS DESTINATARIO_IE, ';
  Result := Result + '  IFNULL(CCC.CID_ESTADO, CDC.CID_ESTADO) AS DESTINATARIO_UF, ';
  Result := Result + '  CTE_CODEMP, ';
  Result := Result + '  CTE_EMPCLI, ';
  Result := Result + '  CTE_NUMCTE, ';
  Result := Result + '  CTE_DTAEMI, ';
  Result := Result + '  CTE_CFOP__, ';
  Result := Result + '  CTE_SERIE_, ';
  Result := Result + '  CTE_TOMSER, ';
  Result := Result + '  CTE_CLATRI, ';
  Result := Result + '  CTE_PERRBC, ';
  Result := Result + '  CTE_VLRFRE, ';
  Result := Result + '  CTE_VLRBCI, ';
  Result := Result + '  CTE_ALIQUO, ';
  Result := Result + '  CTE_VLRIMP, ';
  Result := Result + '  CTE_VLRCRE, ';
  Result := Result + '  CTE_ACESSO, ';
  Result := Result + '  CTE_CODPOR, ';
  Result := Result + '  CTE_PLCTPG, ';
  Result := Result + '  CTE_PLCTRC, ';
  Result := Result + '  CTE_CNDPAG, ';
  Result := Result + '  CTE_CNDREC, ';
  Result := Result + '  CTE_IMPORT, ';
  Result := Result + '  GER_TOTFRE, ';
  Result := Result + '  GER_NUMDOC, ';
  Result := Result + '  GER_SERIE_, ';
  Result := Result + '  FIS_ACESSO, ';
  Result := Result + '  CTE_TENIMP  ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVCTE ';
  Result := Result + '  JOIN CADEMP ET ON CTE_CODEMP = ET.EMP_CODEMP ';
  Result := Result + '  JOIN CADCID CT ON ET.EMP_CODCID = CT.CID_CODCID ';
  Result := Result + '  JOIN CADEMP EC ON CTE_EMPCLI = EC.EMP_CODEMP ';
  Result := Result + '  JOIN CADCID CC ON EC.EMP_CODCID = CC.CID_CODCID ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  Result := Result + '  LEFT JOIN CADCID CDC ON CLI_CODCID = CDC.CID_CODCID ';
  Result := Result + '  JOIN AUXMOV ON MOVGER.AUTOINCREM = AUX_SEQGER ';
  Result := Result + '  LEFT JOIN ENTCLI ON AUX_ENTGER = ENTCLI.AUTOINCREM ';
  Result := Result + '  LEFT JOIN CADCID CCC ON ETC_CIDENT = CCC.CID_CODCID ';
  Result := Result + '  JOIN CADFIS ON GER_NUMDOC = FIS_NUMDOC ';
  Result := Result + '             AND GER_ESPDOC = FIS_ESPDOC ';
  Result := Result + '             AND GER_SERIE_ = FIS_SERIE_ ';
  Result := Result + '             AND GER_CODEMP = FIS_CODEMP ';
  Result := Result + '             AND GER_CODCLI = FIS_FORCLI ';
  Result := Result + 'WHERE ';
  Result := Result + '  CTE_CODEMP = :CODEMP ';
  Result := Result + '  AND IFNULL(CTE_ACESSO, "") <> "" ';
  Result := Result + '  AND CTE_IMPORT = "N" ';
end;

function TFreCon.fGetSqlNotasFiscais: string;
Begin
  Result := '';
  Result := Result + 'SELECT CADFIS.FIS_ACESSO AS CTE_ACESSO,';
  Result := Result + '       CADFIS.FIS_CODEMP,';
  Result := Result + '       CADFIS.FIS_NUMDOC,';
  Result := Result + '       CADFIS.FIS_ESPDOC,';
  Result := Result + '       CADFIS.FIS_TIP_FC,';
  Result := Result + '       CADFIS.FIS_FORCLI,';
  Result := Result + '       CADFIS.FIS_SERIE_,';
  Result := Result + '       "N" AS LOC_IMPORT,';  // se o documento foi encontrado pela importacao ou digitado
  Result := Result + '       "N" AS ENT_DUPLIC,';  // se a a vinculação manual esta duplicada
  Result := Result + '       "N" AS DUP_RECTNF,';  // marca se a nota esta duplicada no banco

  Result := Result + '       CADFIS.FIS_NUMDOC AS OUT_NUMDOC, '; //Numero do documento pela chave da nota no CTe
  Result := Result + '       CAST("" AS CHAR(2)) AS OUT_TIPDOC, '; //Numero do documento pela chave da nota no CTe
  Result := Result + '       CAST("" AS CHAR(10)) AS OUT_DESCRI, '; //Numero do documento pela chave da nota no CTe

  Result := Result + '       CAST("" AS CHAR(14)) AS DESTINATARIO, ';

  Result := Result + '       CAST("" AS CHAR(70)) AS NFE_DESTINATARIO, ';
  Result := Result + '       CAST("" AS CHAR(1))  AS NOTGER, ';
  Result := Result + '       CADFIS.AUTOINCREM AS MOV_GERSEQ, ';
  Result := Result + '       CADFIS.FIS_ACESSO AS NFE_ACESSO, ';
  Result := Result + '       CADFIS.FIS_NUMDOC AS NFE_NUMDOC, '; //Numero do documento pela chave da nota no CTe
  Result := Result + '       CADFIS.FIS_SERIE_ AS NFE_SERIE_, '; //Serie do documento pela chave da nota no CTe
  Result := Result + '       "00.00.0000/0000-00"  AS NFE_CNPJ__, '; //Cnpj do documento pela chave da nota no CTe
  Result := Result + '       "N"               AS CTE_MARCAD,  '; //marca se o cte esta selecionado para ser importado
  Result := Result + '       FIS_HISTOR  '; //Historico
  Result := Result + '  FROM CADFIS';
  Result := Result + ' WHERE FALSE';
End;

function TFreCon.fGetTagTomador(intTomador: integer): string;
begin
  case intTomador of
    0: Exit('rem');
    1: Exit('exped');
    2: Exit('receb');
    3: Exit('dest');
    Else
      Exit('')
  end;
end;

function TFreCon.fGetTipDocFrete: TTipoDocFrete;
begin
 Result := FtpDocFrete;

end;

procedure TFreCon.pGetTagRaizCte(xmlDoc : TXMLDocument; var nodXml: IXMLNode; var blnMod67 : Boolean);
  var
    nodXmlTmp: IXMLNode;
begin
  blnMod67 := False;
  With xmlDoc Do
  Begin
    Try
      nodXml := Node.ChildNodes.FindNode('cteProc');
      If Not Assigned(nodXml) Then
         nodXml := Node.ChildNodes.FindNode('procCTe');

      If Not Assigned(nodXml) Then
      Begin

        nodXml := Node.ChildNodes.FindNode('cteOSProc');
        If Assigned(nodXml) Then
        Begin
          nodXml := nodXml.ChildNodes.FindNode('CTeOS');
          If Assigned(nodXml) Then
          Begin
            nodXmlTmp := nodXml.ChildNodes.FindNode('infCte');

            If Assigned(nodXmlTmp) Then
            Begin
              nodXmlTmp := nodXmlTmp.ChildNodes.FindNode('ide');
              If Assigned(nodXmlTmp) Then
              Begin
                nodXmlTmp := nodXmlTmp.ChildNodes.FindNode('mod');

                If Assigned(nodXmlTmp) Then
                Begin
                  if nodXmlTmp.Text <> '67' Then
                    Abort
                  Else
                    blnMod67 := True;
                End
                Else
                  Abort;
              End
              Else
                Abort;

            End
            Else
              Abort;
          End
          Else
            Abort;


        End
        Else
          Abort;


      End;
    Except
      raise Exception.Create('Tag Raiz do CTE <cteProc> ou <procCTe> não enctontrada.');
    End;
  End;
end;

procedure TFreCon.pGravaRelacionamentoComplementos(strChave: String);
  var
    qryGen: TUniQuery;

begin
  cdsComplementos.Filtered := False;
  cdsComplementos.Filter := 'COM_CHAVE_ = ' + QuotedStr(strChave);
  cdsComplementos.Filtered := True;
  If cdsComplementos.IsEmpty Then
    Exit;
  qryGen := fCriaQuery;
  try
    qryGen.SQL.Clear;
    While Not cdsComplementos.Eof Do
    Begin
      qryGen.SQL.Add('INSERT INTO CTECOM (COM_CTEORI, COM_CTECOM) VALUES (');
      qryGen.SQL.Add(QuotedStr(cdsComplementos.FieldByName('COM_CTEORI').AsString) + ', ');
      qryGen.SQL.Add(QuotedStr(fRetAutoincremCadFis(cdsComplementos.FieldByName('COM_CHAVE_').AsString)) + ');');
      cdsComplementos.Next;
    End;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;

  cdsComplementos.Filtered := False;
  cdsComplementos.Filter := '';


end;

procedure TFreCon.pImportaCTeBancoDados(tpOperacao: TTipoFrete);
var
  strSQL: string;
  strNomeTravaCTE: string;
begin
  tpFrete := tpOperacao;
  blnImportaPeloBancoDados := True;

  if not Assigned(qryCTes) then
    qryCTes := fCriaQuery();

  strSQL := AnsiReplaceStr(fGetSQLDadosCTe, 'MOVCTE', 'NOTCTE');
  strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER');
  strSQL := AnsiReplaceStr(strSQL, 'AUXMOV', 'AUXNOT');
  strSQL := fGetSQLDadosCTe + ' UNION ALL ' + strSQL;

  qryCTes.SQL.Clear;
  qryCTes.SQL.Add('SELECT * FROM (' + strSQL + ') AS TMP ORDER BY CTE_TENIMP, CTE_NUMCTE, CTE_CODEMP LIMIT 1');
  qryCTes.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCTes.Open;

  strNomeTravaCTE :=  'IMPORTAR_CTE_' + qryCTes.FieldByName('CTE_NUMCTE').AsString + '_' + VS_strCodEmp;
  if not fLock_Unlock(strNomeTravaCTE, True, False, False, '', False) then
    Exit;

  try
    strCodOpe := strLoginUsuarioLogado;
    strPorBai := qryCTes.FieldByName('CTE_CODPOR').AsString;
    strCodCta := qryCTes.FieldByName('CTE_PLCTPG').AsString;

    if (tpOperacao = tpfSaida) then
      strCtaRec := qryCTes.FieldByName('CTE_PLCTRC').AsString;

    strDtaEnt := qryCTes.FieldByName('CTE_DTAEMI').AsString;
    strCndVaz := qryCTes.FieldByName('CTE_CNDPAG').AsString;

    if fGeraDadosImportacao then
      fConfirmaImportacaoFreteBanco
    else
    begin
      if blnImportaPeloBancoDados then
        fMarcaCTeComErro;
    end;
  finally
    fLock_Unlock(strNomeTravaCTE, False, False, False, '', False);
  end;
end;

procedure TFreCon.pLimparPessoa(var recPessoa: TPessoaCTE);
begin
  with recPessoa do
  Begin
    strCNPJ := '';
    strRAZAO_SOCIAL := '';
    strINSCRICAO_ESTADUAL := '';
    strUF := '';
    intCodTomador := -1;
  End;
end;

procedure TFreCon.pLocalizaItemDuplicadoJaImportados;
begin
  FConsulta.Sql.Clear;
  FConsulta.SQL.Add('SELECT *');
  FConsulta.SQL.Add('  FROM RECTNF');
  FConsulta.SQL.Add(' WHERE (RECTNF.REC_MOVSEQ = :MOVSEQ OR RECTNF.REC_NOTSEQ = :MOVSEQ)');
  cdsNotasFiscais.First;
  While not cdsNotasFiscais.Eof Do
  Begin
    FConsulta.ParamByName('MOVSEQ').AsString := cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString;
    FConsulta.Open;
    cdsNotasFiscais.Edit;
    If FConsulta.RecordCount > 0 Then
    Begin
      cdsNotasFiscais.FieldByName('ENT_DUPLIC').AsString := 'S';
      cdsNotasFiscais.FieldByName('DUP_RECTNF').AsString := 'S';
    End
    Else
      cdsNotasFiscais.FieldByName('DUP_RECTNF').AsString := 'N';
    cdsNotasFiscais.Post;
    cdsNotasFiscais.Next;
  End;
end;


function TFreCon.fValidaChaveAcessoAnexa(strChaveAcesso: String; var strErro: String; var strCfopBrinde: String): Boolean;
  const sqlClaFisTransfSaida = '(SELECT GROUP_CONCAT("_",IFNULL(EMP_CLAT01, ""), "_", ' +
                               '                          IFNULL(EMP_CLAT02, ""),"_",' +
                               '                          IFNULL(EMP_CLAT03, ""),"_",' +
                               '                          IFNULL(EMP_CLAT04, ""),"_",' +
                               '                          IFNULL(EMP_CLATT1, ""),"_",' +
                               '                          IFNULL(EMP_CLATT2, ""),"_",' +
                               '                          IFNULL(EMP_CLATT3, ""),"_",' +
                               '                          IFNULL(EMP_CLTTI1, ""),"_",' +
                               '                          IFNULL(EMP_CLTTI2, ""),"_",' +
                               '                          IFNULL(EMP_CLTTI3, "") SEPARATOR "")  FROM CADEMP )';
  sqlClaFisTransfEntrada = '(SELECT GROUP_CONCAT("_",IFNULL(EMP_CLTEV1, ""), "_", ' +
                           ' IFNULL(EMP_CLTEV2, ""),"_", ' +
                           ' IFNULL(EMP_CLTEV3, ""),"_", ' +
                           ' IFNULL(EMP_CLATE1, ""),"_", ' +
                           ' IFNULL(EMP_CLATE2, ""),"_", ' +
                           ' IFNULL(EMP_CLATE3 , "") SEPARATOR "")  FROM CADEMP ) ';
var i: integer;
    blnImpCtv: Boolean;

begin
  blnImpCtv := fCfgSis('IMPCTV', varBoolean);
  strErro := '';
  If FtpDocFrete = tpdfIndefinido Then
    Exit(True);
  strErro := '';

  qryGeneric.SQL.Clear;
  If (tpFrete = tpfSaida) Then
  Begin
    If strFCEVEN <> '' Then
    Begin
      qryGeneric.SQL.Add('  SELECT LOCATE(FIS_CLFSC1, CONCAT(SIS_VALCFG, "' + strFCEVEN + '", ' + sqlClaFisTransfSaida+ ')) > 0 ');
      qryGeneric.SQL.Add('  OR LOCATE(FIS_CLFSC2, CONCAT(SIS_VALCFG, "' + strFCEVEN + '", ' + sqlClaFisTransfSaida+ ')) > 0 ');
      qryGeneric.SQL.Add('  OR LOCATE(FIS_CLFSC3, CONCAT(SIS_VALCFG, "' + strFCEVEN + '", ' + sqlClaFisTransfSaida+ ')) > 0 ');
      qryGeneric.SQL.Add('  OR LOCATE(FIS_CLFSC4, CONCAT(SIS_VALCFG, "' + strFCEVEN + '", ' + sqlClaFisTransfSaida+ ')) > 0 ');
      qryGeneric.SQL.Add('  OR LOCATE(FIS_CLFSC5, CONCAT(SIS_VALCFG, "' + strFCEVEN + '", ' + sqlClaFisTransfSaida+ ')) > 0 ');
      qryGeneric.SQL.Add('  AS LOCALIZOU, FIS_NUMDOC, FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5 FROM CADFIS ')

    End
    Else
      qryGeneric.SQL.Add('  SELECT LOCATE(FIS_CLFSC1, CONCAT(SIS_VALCFG, ' + sqlClaFisTransfSaida+ ')) > 0 AS LOCALIZOU, FIS_NUMDOC, FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5 FROM CADFIS')
  End
  Else
  Begin
    If (strFCEDEV <> '') And (FtpDocFrete in [tpdfDevolucaoCompra, tpdfDevolucaoVenda]) Then
      qryGeneric.SQL.Add('  SELECT LOCATE(FIS_CLFSC1, CONCAT(SIS_VALCFG, "' + strFCEDEV + '", ' + sqlClaFisTransfEntrada+ ')) > 0 AS LOCALIZOU, FIS_NUMDOC, FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5 FROM CADFIS')
    Else If (strFCECOM <> '') And (FtpDocFrete = tpdfCompra) Then
      qryGeneric.SQL.Add('  SELECT LOCATE(FIS_CLFSC1, CONCAT(SIS_VALCFG, "' + strFCECOM + '", ' + sqlClaFisTransfEntrada+ ')) > 0 AS LOCALIZOU, FIS_NUMDOC, FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5 FROM CADFIS')
    Else
      qryGeneric.SQL.Add('  SELECT LOCATE(FIS_CLFSC1, CONCAT(SIS_VALCFG, ' + sqlClaFisTransfEntrada+ ')) > 0 AS LOCALIZOU, FIS_NUMDOC, FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5 FROM CADFIS');
  End;
  case FtpDocFrete of
   tpdfCompra      : qryGeneric.SQL.Add('INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_CLACOM" AND SIS_CODEMP = FIS_CODEMP');
   tpdfVenda       : qryGeneric.SQL.Add('INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_CLAVEN" AND SIS_CODEMP = FIS_CODEMP');
   tpdfDevolucaoCompra,
   tpdfDevolucaoVenda: qryGeneric.SQL.Add('INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_CLADEV" AND SIS_CODEMP = FIS_CODEMP');
  End;

  qryGeneric.SQL.Add('WHERE FIS_ACESSO = "' + strChaveAcesso + '"');


  case FtpDocFrete of
   tpdfDevolucaoVenda: Begin
                         If (Not blnImpCtv) Then
                            qryGeneric.SQL.Add('AND FIS_CLFSC1 < "5000"');
                       End;
   tpdfCompra      : qryGeneric.SQL.Add('AND FIS_CLFSC1 < "5000"');
   tpdfDevolucaoCompra,
   tpdfVenda       : qryGeneric.SQL.Add('AND FIS_CLFSC1 >= "5000"');
  End;

  qryGeneric.Open;
  strCfopBrinde := '';


  If blnImpCtv And
     (FtpDocFrete = tpdfDevolucaoVenda) And
     (qryGeneric.FieldByName('FIS_CLFSC1').AsInteger > 5000) And
     (Pos(qryGeneric.FieldByName('FIS_CLFSC1').AsString, fCfgSis('CLAVEN') + strFCEVEN  + sqlClaFisTransfSaida) > 0) then
  Begin
    Result := fExisteNFeDevolucao(strChaveAcesso);
    If not Result Then
    begin
      strErro := 'A NF de venda informada no conhecimento de frete ainda não possui nota de devolução.'+#13+
                  'Realizar primeiro a devolução da venda '+ qryGeneric.FieldByName('FIS_NUMDOC').AsString;
      Exit;
    End
  End;

  Result := qryGeneric.FieldByName('LOCALIZOU').AsInteger > 0;
  If Result Then
  Begin
    strCfopBrinde := qryGeneric.FieldByName('FIS_CLFSC1').AsString;
    For i := 1 To 5 Do
    Begin
      If qryGeneric.FieldByName('FIS_CLFSC' + intToStr(i)).AsString <> '' Then
      Begin
        If (Pos(fCfgSis('CLABRI'), qryGeneric.FieldByName('FIS_CLFSC' + intToStr(i)).AsString) = 0) Then
        Begin
          strCfopBrinde := '';
          Break
        End;
      End;
    End;
  End;

  If not Result Then
    case FtpDocFrete of
      tpdfCompra      : strErro := 'A chave de acesso ' + strChaveAcesso + ' Não é uma nota de Compra';
      tpdfVenda       : strErro := 'A chave de acesso ' + strChaveAcesso + ' Não é uma nota de Venda';
      tpdfDevolucaoVenda: strErro := 'A chave de acesso ' + strChaveAcesso + ' Não é uma nota de Devolução';
      tpdfDevolucaoCompra : strErro := 'A chave de acesso ' + strChaveAcesso + ' Não é uma nota de Devolução de Compra';
    End
end;

function TFreCon.fValidaComparaTomadorComEmpresa: Boolean;
begin
  qryGeneric.SQL.Clear;
  qryGeneric.SQL.Add('SELECT COUNT(1) AS QTD FROM CADEMP');
  qryGeneric.SQL.Add(' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
  qryGeneric.SQL.Add(' WHERE CID_ESTADO = :ESTADO');
  qryGeneric.SQL.Add('   AND CID_COIBGE = :COIBGE');
  qryGeneric.SQL.Add('   AND EMP_C_G_C_ = :C_G_C_');

  qryGeneric.ParamByName('ESTADO').AsString := FTomador.strUF;
  qryGeneric.ParamByName('COIBGE').AsString := FTomador.cMun;
  qryGeneric.ParamByName('C_G_C_').AsString := FTomador.strCNPJ;

  qryGeneric.Open;

  Result := qryGeneric.FieldByName('QTD').AsInteger > 0;

end;

function TFreCon.fValidaNotas: Boolean;
var
  strFilter: string;
  blnNotaSemNotaTipoDoc99: Boolean;

  function blnTemItensSemNota: Boolean;
  begin
    cdsNotasFiscais.Filtered := False;
    cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = ' + QuotedStr('') + ' AND (NFE_ACESSO <> ' + QuotedStr('') +  ' OR OUT_NUMDOC <> ' + QuotedStr('') +  ' OR NFE_NUMDOC <> ' + QuotedStr('') + ')';
    cdsNotasFisCais.Filtered := True;
    Result := cdsNotasFiscais.RecordCount > 0;

    {Validação necessária para forçar a apresentar a tela para informar o documento do cte
     quando no cte vem com a tag <infOutros> mas não vem informado o documento e utiliza a rotina de contabilidade}
    If (Not Result) And (blnUtilizaContabilidade) Then
    Begin
      cdsNotasFiscais.Filtered := False;
      cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = ' + QuotedStr('') + ' AND OUT_TIPDOC = ' + QuotedStr('99') + ' AND LOC_IMPORT = ' + QuotedStr('') ;
      cdsNotasFisCais.Filtered := True;
      Result := cdsNotasFiscais.RecordCount > 0;
      blnNotaSemNotaTipoDoc99 := Result;
    End;
  End;

  function blnTemItensDuplicados: Boolean;
  begin
    cdsNotasFiscais.Filtered := False;
    cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND ENT_DUPLIC = ' + QuotedStr('S') + ' AND NFE_ACESSO <> ' + QuotedStr('');
    cdsNotasFisCais.Filtered := True;
    Result := cdsNotasFiscais.RecordCount > 0;
  End;

begin
  blnNotaSemNotaTipoDoc99 := False;
  If cdsNotasFiscais.IsEmpty Then
     exit(True); //o modelo 67 agora importa sem nf
  Try
    //Verifica se tem itens sem nota
    If blnTemItensSemNota or blnTemItensDuplicados Then
    Begin
      pCriarFormularios(TfrmEntFreConGridIdentificaDocumento, frmEntFreConGridIdentificaDocumento);
      Try
        //Chama a tela para poder informar movger
        frmEntFreConGridIdentificaDocumento.dtsDados.DataSet := cdsNotasFiscais;
        frmEntFreConGridIdentificaDocumento.tpFrete := tpFrete;
        frmEntFreConGridIdentificaDocumento.FtpDocFrete := FtpDocFrete;

        cdsNotasFiscais.Filtered := False;

        strFilter := '';
        strFilter :=  '((CTE_MARCAD = ' + QuotedStr('S') + ' AND (NFE_ACESSO <> ' + QuotedStr('') +  ' OR OUT_NUMDOC <> ' + QuotedStr('') +  ' OR NFE_NUMDOC <> ' + QuotedStr('') + ') )';
        If blnNotaSemNotaTipoDoc99 Then
          strFilter := strFilter + '  OR ( CTE_MARCAD = ' + QuotedStr('S') + ' AND MOV_GERSEQ = ' + QuotedStr('') + ' AND OUT_TIPDOC = ' + QuotedStr('99') + ' AND LOC_IMPORT = ' + QuotedStr('') + ') ';

        strFilter := strFilter + ' )';

        cdsNotasFiscais.Filter :=  strFilter;
        cdsNotasFiscais.IndexFieldNames := 'CTE_ACESSO';
        cdsNotasFisCais.Filtered := True;

        Result := frmEntFreConGridIdentificaDocumento.Showmodal = 1;
      Finally
        FreeAndNil(frmEntFreConGridIdentificaDocumento);
      End;
    End
    Else
      Result := True;
  Finally
    cdsNotasFiscais.Filtered := False;
    cdsNotasFiscais.Filter := '';
  End;
end;

function TFreCon.fValidaNumDocComChaveAcesso: Boolean;
begin
  Result := True;

  If (Not fEmptyStr(strAcesso)) Then
  Begin
    If Copy(strNumDoc, 4, 9) = Copy(strAcesso, 26, 9) Then
    Begin
      Result := True;
    End
    Else Result := False;
  End;
end;

function TFreCon.fGravaRelacionamentoCTEcomDocumento(strChaveCTE, strAutoIncremCTE: string): boolean;
  var
    blnAtuMovTri_AuxMov: Boolean;
    blnNotGer: Boolean;
  blnExisteRelacionamento: Boolean;
begin
  blnNotGer := False;
  Try
    FConsulta.SQL.Clear;
    FConsulta.SQL.Text := 'INSERT INTO RECTNF (REC_MOVSEQ, REC_NOTSEQ, REC_CTESEQ) VALUES (:MOVSEQ, :NOTSEQ, :CTESEQ)';
    cdsNotasFiscais.Filtered := False;
    cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND CTE_ACESSO = ' + QuotedStr(strChaveCte) + ' AND MOV_GERSEQ <> ' + QuotedStr('');
    cdsNotasFiscais.Filtered := True;
    blnAtuMovTri_AuxMov := (cdsNotasFiscais.RecordCount > 0);
    While Not cdsNotasFiscais.IsEmpty Do
    Begin
      blnExisteRelacionamento := False;

  	  If (cdsNotasFiscais.FieldByName('MOV_GERSEQ').Value <> '') And (cdsNotasFiscais.FieldByName('NOTGER').AsString = 'S') Then
      Begin
        blnExisteRelacionamento := fVerificaTemRelacionamentoCTEcomDoc(strAutoIncremCTE, cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString, 'NOTSEQ');
        FConsulta.ParamByName('NOTSEQ').AsString := cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString;
        FConsulta.ParamByName('MOVSEQ').Clear;
        blnNotGer := True;
      End
      Else If (cdsNotasFiscais.FieldByName('MOV_GERSEQ').Value <> '') Then
      Begin
        blnExisteRelacionamento := fVerificaTemRelacionamentoCTEcomDoc(strAutoIncremCTE, cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString, 'MOVSEQ');
        FConsulta.ParamByName('MOVSEQ').AsString := cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString;
        FConsulta.ParamByName('NOTSEQ').Clear;
      End;

      if (not blnExisteRelacionamento) then
      begin
      FConsulta.ParamByName('CTESEQ').AsString := strAutoIncremCTE;
      FConsulta.ExecSQL;
      end;

      cdsNotasFiscais.Edit;
      cdsNotasFiscais.FieldByName('CTE_MARCAD').AsString := 'N';
      cdsNotasFiscais.Post;
    End;

    If blnAtuMovTri_AuxMov And (cdsNotasFiscais.FieldByName('NOTGER').AsString <> 'S' ) And (Not blnNotGer) Then
      Result := fAjustaMovTri_AuxMov_Frete(strAutoIncremCTE)
    Else
      Result := True;
  Except
    on e: exception do
    Begin
      pMensagensErro(E.Message,'[TFreCon.fGravaRelacionamentoCTEcomDocumento]');
      Result := False;
    End
  End;
end;

function TFreCon.fGravaXML(strAutIncCadFis: String; Arquivo: String): Boolean;
  var
    qryXmlVal : TUniQuery;
begin
  Result := True;
  If fEmptyStr(Arquivo) Then
    Exit;
  Try
    qryXmlVal := fCriaQuery;
    Try
      qryXmlVal := fCriaQuery();
      qryXmlVal.SQL.Text := 'SELECT * FROM ARQCTE WHERE FALSE';
      qryXmlVal.Open;
      qryXmlVal.Append;

      qryXmlVal.FieldByName('CTE_CADFIS').AsString   := strAutIncCadFis;
      TBlobField(qryXmlVal.FieldByName('CTE_ARQXML')).LoadFromFile(Arquivo);
      qryXmlVal.Post;
      qryXmlVal.Close;

      qryXmlVal.SQL.Text := 'UPDATE CADFIS SET FIS_LCTCTE = "I" WHERE AUTOINCREM = "'+strAutIncCadFis+'"';
      qryXmlVal.ExecSQL;
    Finally
      FreeAndNil(qryXmlVal);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, 'TFreCon.fGravaXML')
    End;
  End;
end;


function TFreCon.fAjustaMovTri_AuxMov_Frete(stlAutoIncremCTE: String): boolean;
  var
    fltResto: Double;
    fltPreSug: Double;
    qryUpdate: TUniQuery;
Begin
  Result := False;
  FConsulta.SQL.Clear;
  {PORCEN  Porcentagem do valor do item entre o valor do CTE
   PRESUG Valor proporcional do item em relacao ao valor do CTE}
  FConsulta.Sql.Add('SELECT VALFRE,');
  FConsulta.Sql.Add('       ((VALFRE * ((VLRITEM * 100) / TOTGER)) / 100) FRESUG,');
  FConsulta.Sql.Add('       ((VLRITEM * 100) / TOTGER) AS PORCEN,');
  FConsulta.Sql.Add('       SEQUENCIA');
  FConsulta.Sql.Add('  FROM (SELECT DET_TOTITE-DET_DESESP as VLRITEM,');
  FConsulta.Sql.Add('               (SELECT SUM(DET_TOTITE-DET_DESESP)');
  FConsulta.Sql.Add('                  FROM MOVDET');
  FConsulta.Sql.Add('                 WHERE MOVDET.DET_SEQGER IN ((SELECT REC_MOVSEQ');
  FConsulta.Sql.Add('                                                FROM RECTNF');
  FConsulta.Sql.Add('                                               WHERE REC_CTESEQ = :REC_CTESEQ))) AS TOTGER,');
  FConsulta.Sql.Add('               (FIS_VLCON1 + FIS_VLCON2 + FIS_VLCON3 + FIS_VLCON4 + FIS_VLCON5) AS VALFRE,');
  FConsulta.Sql.Add('               MOVDET.AUTOINCREM AS SEQUENCIA');
  FConsulta.Sql.Add('         FROM RECTNF');
  FConsulta.Sql.Add('        INNER JOIN CADFIS ON CADFIS.AUTOINCREM = REC_CTESEQ');
  FConsulta.Sql.Add('        INNER JOIN MOVDET ON MOVDET.DET_SEQGER = REC_MOVSEQ');
  FConsulta.Sql.Add('        INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
  FConsulta.Sql.Add('        WHERE REC_CTESEQ = :REC_CTESEQ) AS CALC');
  FConsulta.ParamByName('REC_CTESEQ').AsString := stlAutoIncremCTE;
  FConsulta.Open;

  If FConsulta.IsEmpty Then
    Exit;

  qryUpdate := fCriaQuery;
  fltResto := 0;
  Try
    qryUpdate.SQL.Add('UPDATE MOVTRI SET DET_FRESUG = :FRESUG WHERE MOVTRI.DET_SEQGER = :SEQGER');
    Try
      While Not FConsulta.EoF Do
      Begin
        fltPreSug := fFormataFloat(FConsulta.FieldByName('FRESUG').AsFloat, 2);
        fltResto := fltResto + fltPreSug;

        //Esta na ultima linha ajusta os centavos.
        If (FConsulta.RecordCount) = FConsulta.RecNo Then
          fltPreSug := fltPreSug + (FConsulta.FieldByName('VALFRE').AsFloat - fltResto);

        qryUpdate.ParamByName('FRESUG').Value := fltPreSug;
        qryUpdate.ParamByName('SEQGER').Value := FConsulta.FieldByName('SEQUENCIA').AsString;
        qryUpdate.ExecSQL;
        FConsulta.Next;
      End;

      //Atualizar AuxMov.DET_FRESUG somando os valores proporcionais da movtri  atualizadas no p loop anterior.
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE AUXMOV,');
      qryUpdate.SQL.Add('       (SELECT SUM(MOVTRI.DET_FRESUG) AS TOTFRE,');
      qryUpdate.SQL.Add('               MOVDET.DET_SEQGER');
      qryUpdate.SQL.Add('          FROM RECTNF');
      qryUpdate.SQL.Add('         INNER JOIN CADFIS ON CADFIS.AUTOINCREM = REC_CTESEQ');
      qryUpdate.SQL.Add('         INNER JOIN MOVDET ON MOVDET.DET_SEQGER = REC_MOVSEQ');
      qryUpdate.SQL.Add('         INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
      qryUpdate.SQL.Add('         WHERE REC_CTESEQ = :REC_CTESEQ');
      qryUpdate.SQL.Add('         GROUP BY MOVDET.DET_SEQGER) CAL');

      qryUpdate.SQL.Add('   SET AUX_FRESUG = CAL.TOTFRE,');
      qryUpdate.SQL.Add('       AUX_TRALOT = :TRALOT ');

      qryUpdate.SQL.Add(' WHERE AUXMOV.AUX_SEQGER = CAL.DET_SEQGER');
      qryUpdate.ParamByName('REC_CTESEQ').AsString := stlAutoIncremCTE;
      qryUpdate.ParamByName('TRALOT').AsString     := strTraLot;
      qryUpdate.ExecSQL;

      Result := True;
    Except
      on E: Exception do
        pMensagensErro(E.Message,'[TFreCon.fAjustaMovTri_AuxMov_Frete]');
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
End;

procedure TFreCon.pMarcarNotasQueSeraoImportadas;
begin
  Try
    // Limpa a marcação de todas as notas fiscais
    While not cdsNotasFiscais.Eof Do
    Begin
      cdsNotasFiscais.Edit;
      cdsNotasFiscais.FieldByName('CTE_MARCAD').AsString := 'N';
      cdsNotasFiscais.Post;
      cdsNotasFiscais.Next;
    End;

    while not qryTabela.Eof Do
    Begin
      cdsNotasFiscais.Filtered := False;
      cdsNotasFiscais.First;

      cdsNotasFiscais.Filter :=  'CTE_ACESSO = ' + QuotedStr(qryTabela.FieldByName('ACESSO').AsString);
      cdsNotasFiscais.Filtered := True;
      While not cdsNotasFiscais.Eof Do
      Begin
        cdsNotasFiscais.Edit;
        cdsNotasFiscais.FieldByName('CTE_MARCAD').AsString := 'S';
        cdsNotasFiscais.Post;
        cdsNotasFiscais.Next;
      End;
      qryTabela.Next;
    End
  Finally
    qryTabela.First;
  End;
end;

function TFreCon.fFiltraNotasCTE(strChaveCte: String): string;
begin
  fFiltra_CTE(strChaveCte);
  result := '';
  While Not cdsNotasFiscais.Eof Do
  Begin
    // Se não encontra a chave na lista então adiciona na string da consulta da Movdet
    If Not (Pos(cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString, result) > 0) Then
      result := result + fQuotedStr(cdsNotasFiscais.FieldByName('MOV_GERSEQ').AsString) + ', ';
    cdsNotasFiscais.Next;
  End;
   // Remove o ultimo ', '
   result := Copy(result, 0, length(result) -2);
   cdsNotasFiscais.Filtered := False;
end;

function TFreCon.fFiltra_CTE(strChaveCte: String): boolean;
begin
  Begin
    cdsNotasFiscais.Filtered := False;
    cdsNotasFiscais.Filter :=  'CTE_MARCAD = ' + QuotedStr('S') + ' AND CTE_ACESSO = ' + QuotedStr(strChaveCte) + ' AND MOV_GERSEQ <> ' + QuotedStr('');
    cdsNotasFiscais.Filtered := True;
    Result := Not cdsNotasFiscais.IsEmpty;
  End;
end;

function TFreCon.fFormatCNPJ(strCNPJ: String): string;
Begin
  Insert('.', strCNPJ, 3);
  Insert('.', strCNPJ, 7);
  Insert('/', strCNPJ, 11);
  Insert('-', strCNPJ, 16);
  Result := strCNPJ;
End;

Function TFreCon.fCarregaAbrevPisCofPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    strSQL: String;
    strRegimeTributario: String;
    cfgAPISFS,
    cfgACOSFS,
    cfgAPISFP,
    cfgACOSFP,
    strFiltroPis,
    strFiltroCof: string;

Begin
  strSQL := '';

  if FListaClaFis.IndexOf('5932') = -1 then
    FListaClaFis.Add('5932');
  if FListaClaFis.IndexOf('6932') = -1 then
    FListaClaFis.Add('6932');
  if FListaClaFis.IndexOf('1932') = -1 then
    FListaClaFis.Add('1932');
  if FListaClaFis.IndexOf('2932') = -1 then
    FListaClaFis.Add('2932');

  strRegimeTributario := fRetFornecedorRegimeTributario(FCodTra);
  cfgAPISFS := fCfgSis('APISFS');
  cfgACOSFS := fCfgSis('ACOSFS');
  cfgAPISFP := fCfgSis('APISFP');
  cfgACOSFP := fCfgSis('ACOSFP');
  strFiltroPis := '';
  strFiltroCof := '';

  If (strRegimeTributario <> 'S') And (cfgACOSFP <> '') And (cfgAPISFP <> '') Then
  Begin
    strFiltroPis := ' AND APC_CODAPC = "' + cfgAPISFP + '"';
    strFiltroCof := ' AND APC_CODAPC = "' + cfgACOSFP + '"';
  End
  Else
  If (strRegimeTributario = 'S') And (cfgACOSFS <> '') And (cfgAPISFS <> '') Then
  Begin
    strFiltroPis := ' AND APC_CODAPC = "' + cfgAPISFS + '"';
    strFiltroCof := ' AND APC_CODAPC = "' + cfgACOSFS + '"';
  End;



  If FListaClaFis.Count = 0 Then
  Begin

    If (tpFrete = tpfSaida) Then
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT , APC_ALQSAI APC_ALQENT, "     " AS CLAFIS FROM PISSAI WHERE FALSE'
    Else
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "     " AS CLAFIS FROM PISENT WHERE FALSE';

  End Else
  Begin
    For intContador := 0 To FListaClaFis.Count - 1 Do
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ';
      If  Pos(LeftStr(FListaClaFis[intContador], 1), '1_2_') = 0 Then
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT, APC_ALQSAI AS APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM PISSAI WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOSAI)' + strFiltroPis
      Else
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM PISENT WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOENT) ' + strFiltroPis;
    End;
  End;

  With cdsAbrPis Do
  Begin
    qryQuery.SQL.Text := strSQL;
    fAbreClient(True, 'TFreCon.fCarregaAbrevPisCofPrg');
    IndexFieldNames := 'CLAFIS';
  End;

  strSQL := '';

  If FListaClaFis.Count = 0 Then
  Begin
    If (tpFrete = tpfSaida) Then
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT, APC_ALQSAI AS APC_ALQENT, "     " AS CLAFIS FROM COFSAI WHERE FALSE'
    Else
      strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "     " AS CLAFIS FROM COFENT WHERE FALSE';
  End Else
  Begin

    For intContador := 0 To FListaClaFis.Count - 1 Do
    Begin
      If Not fEmptyStr(strSQL) Then
        strSQL := strSQL + ' UNION ';
      If  Pos(LeftStr(FListaClaFis[intContador], 1), '1_2_') = 0 Then
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTSAI AS APC_CSTENT, APC_BASSAI AS APC_BASENT, APC_ALQSAI AS APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM COFSAI WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOSAI) ' + strFiltroCof
      Else
        strSQL := strSQL + 'SELECT AUTOINCREM, CONCAT(APC_CODAPC, "-", APC_DESCRI) AS DESCRI, APC_CSTENT, APC_BASENT, APC_ALQENT, "' + FListaClaFis[intContador] + '" AS CLAFIS FROM COFENT WHERE LOCATE("' + FListaClaFis[intContador] + '", APC_CFOENT)' + strFiltroCof;
    End;

  End;

  With cdsAbrCof Do
  Begin
    qryQuery.SQL.Text := strSQL;
    fAbreClient(True, 'TFreCon.fCarregaAbrevPisCofPrg');
    IndexFieldNames := 'CLAFIS';

    pAlinhaCampoCentro('CLAFIS');
    pAlinhaCampoCentro('APC_CSTENT');
  End;

  If FAtulizarTabela Then
  With qryTabela Do
  Begin
    if Assigned(prgProgresso) then
    begin
      prgProgresso.Properties.Max := RecordCount;
      Application.ProcessMessages;
    end;

    cdsAbrPis.Filtered := True;
    cdsAbrCof.Filtered := True;

    First;

    While Not Eof Do
    Begin
      cdsAbrPis.Filter := 'CLAFIS = ' + QuotedStr(FieldByName('CLAFI1').AsString);
      cdsAbrCof.Filter := 'CLAFIS = ' + QuotedStr(FieldByName('CLAFI1').AsString);

      Edit;

      If cdsAbrPis.RecordCount = 1 Then
      Begin
        FieldByName('ALQPIS').AsFloat  := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
        FieldByName('BASPIS').AsFloat  := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
        FieldByName('AUTPIS').AsString := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
        FieldByName('CSTPIS').AsString := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
      End

      Else FieldByName('AUTPIS').AsString := '';

      If cdsAbrCof.RecordCount = 1 Then
      Begin
        FieldByName('ALQCOF').AsFloat  := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
        FieldByName('BASCOF').AsFloat  := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
        FieldByName('AUTCOF').AsString := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
        FieldByName('CSTCOF').AsString := cdsAbrCof.FieldByName('APC_CSTENT').AsString;
      End

      Else FieldByName('AUTCOF').AsString := '';

      Post;

      Next;

      if Assigned(prgProgresso) then
      begin
        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      end;
    End;
  End;

  Result := True;
End;

Function TFreCon.fCarregaAbrevPisCof(blnAtualizarTabela: Boolean = True): Boolean;
Begin
  Try
    FAtulizarTabela := blnAtualizarTabela;

    If Not blnUtiAbr Then
    Begin
      Result := True;
      Exit;
    End;

    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Carregando abreviação de PIS/COFINS, aguarde...';
      fExecutarAcao := fCarregaAbrevPisCofPrg;
      ShowModal;
      Result := blnConfirma;
    End;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fCarregaAbrevPisCof]');
    End;
  End;
End;

Function TFreCon.fSelecionaAbreviacaoPis: Boolean;
Begin
  Try
    cdsAbrPis.Filter   := 'CLAFIS = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
    cdsAbrPis.Filtered := True;

    If cdsAbrPis.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de PIS cadastrada para a CFOP ' + qryTabela.FieldByName('CLAFI1').AsString + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação PIS !');
      Result := False;
      Exit;
    End;

    cdsAbrPis.Locate('AUTOINCREM',  qryTabela.FieldByName('AUTPIS').AsString, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de PIS';
    frmEscolhePisCofinsFrete.chkCopTodas.Caption := 'Copiar alíquota selecionada para todos os fretes com CFOP ' + qryTabela.FieldByName('CLAFI1').AsString;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrPis.dtsSource;

    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('ALQPIS').AsFloat  := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
      qryTabela.FieldByName('BASPIS').AsFloat  := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
      qryTabela.FieldByName('AUTPIS').AsString := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
      qryTabela.FieldByName('CSTPIS').AsString := cdsAbrPis.FieldByName('APC_CSTENT').AsString;

      If qryTabela.FieldByName('STATUS').AsInteger =  IMPORTADO_SEM_PISCOF Then
        If (qryTabela.FieldByName('AUTPIS').AsString <> '') And (qryTabela.FieldByName('AUTCOF').AsString <> '') Then
          qryTabela.FieldByName('STATUS').AsInteger := IMPORTADO_OK;

      qryTabela.Post;

      If frmEscolhePisCofinsFrete.chkCopTodas.Checked Then
        pReplicaAlqPis;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fSelecionaAbreviacaoPis]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TFreCon.fSelecionaAbreviacaoPisEntrada(strClaFis: String): Boolean;
Begin
  Try
    cdsAbrPis.Filter   := 'CLAFIS = ' + QuotedStr(strClaFis);
    cdsAbrPis.Filtered := True;

    If cdsAbrPis.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de PIS cadastrada para a CFOP ' + strClaFis + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação PIS !');
      Result := False;
      Exit;
    End;

    cdsAbrPis.Locate('AUTOINCREM', FAutPis, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de PIS';
    frmEscolhePisCofinsFrete.chkCopTodas.Visible := False;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrPis.dtsSource;
    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      FAlqPis    := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
      FPerBasPis := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
      FAutPis    := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
      FCstPis    := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fSelecionaAbreviacaoPis]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TFreCon.fSelecionaAbreviacaoCofins: Boolean;
Begin
  Try
    cdsAbrCof.Filter   := 'CLAFIS = ' + QuotedStr(qryTabela.FieldByName('CLAFI1').AsString);
    cdsAbrCof.Filtered := True;

    If cdsAbrCof.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de COFINS cadastrada para a CFOP ' + qryTabela.FieldByName('CLAFI1').AsString + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação COFINS !');
      Result := False;
      Exit;
    End;

    cdsAbrCof.Locate('AUTOINCREM',  qryTabela.FieldByName('AUTCOF').AsString, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de COFINS';
    frmEscolhePisCofinsFrete.chkCopTodas.Caption := 'Copiar alíquota selecionada para todos os fretes com CFOP ' + qryTabela.FieldByName('CLAFI1').AsString;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrCof.dtsSource;

    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('ALQCOF').AsFloat  := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
      qryTabela.FieldByName('BASCOF').AsFloat  := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
      qryTabela.FieldByName('AUTCOF').AsString := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
      qryTabela.FieldByName('CSTCOF').AsString := cdsAbrCof.FieldByName('APC_CSTENT').AsString;
      If qryTabela.FieldByName('STATUS').AsInteger =  IMPORTADO_SEM_PISCOF Then
        If (qryTabela.FieldByName('AUTPIS').AsString <> '') And (qryTabela.FieldByName('AUTCOF').AsString <> '') Then
          qryTabela.FieldByName('STATUS').AsInteger := IMPORTADO_OK;
      qryTabela.Post;

      If frmEscolhePisCofinsFrete.chkCopTodas.Checked Then
        pReplicaAlqCof;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fSelecionaAbreviacaoCofins]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TFreCon.fSelecionaAbreviacaoCofinsEntrada(strClaFis: String): Boolean;
Begin
  Try
    cdsAbrCof.Filter   := 'CLAFIS = ' + QuotedStr(strClaFis);
    cdsAbrCof.Filtered := True;

    If cdsAbrCof.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma Abreviação de COFINS cadastrada para a CFOP ' + strClaFis + '.' + #13#10 +
                  'Cadastre as Abreviações em Principal/ Manutenção de Cadastros/ Auxiliares/ Abreviação COFINS !');
      Result := False;
      Exit;
    End;

    cdsAbrCof.Locate('AUTOINCREM', FAutCof, []);
    pCriarFormularios(TfrmEscolhePisCofinsFrete, frmEscolhePisCofinsFrete);
    frmEscolhePisCofinsFrete.Caption := 'Selecione a Alíquota de COFINS';
    frmEscolhePisCofinsFrete.chkCopTodas.Visible := False;
    frmEscolhePisCofinsFrete.cxgConsulta.DataController.DataSource := cdsAbrCof.dtsSource;

    Result := frmEscolhePisCofinsFrete.ShowModal = mrOk;

    If Result Then
    Begin
      FAlqCof    := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
      FPerBasCof := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
      FAutCof    := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
      FCstCof    := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fSelecionaAbreviacaoCofins]');
    End;
  End;

  pFreeAndNil(frmEscolhePisCofinsFrete);
End;

Function TFreCon.fInformarPisCofins: Boolean;
Begin
  Result := False;

  If Not blnUtiAbr Then
    Exit;

  If qryTabela.Locate('AUTPIS',  '', []) Then
  Begin
    pMensagemOk('Informe a Alíquota de PIS!');
    fSelecionaAbreviacaoPis;
    Result := True;
    Exit;
  End;

  If qryTabela.Locate('AUTCOF',  '', []) Then
  Begin
    pMensagemOk('Informe a Alíquota de Cofins!');
    fSelecionaAbreviacaoCofins;
    Result := True;
    Exit;
  End;

End;

Procedure TFreCon.pReplicaAlqPis;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Atualizando alíquota de PIS, aguarde...';
      fExecutarAcao := fReplicaAlqPisPrg;
      ShowModal;
    End;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFreCon.pReplicaAlqPis]');
    End;
  End;

End;

procedure TFreCon.pTomadorEEmpresaCadastrada(strCNPJTomador: string;
  var strCodEmpresa: string);
  var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT EMP_CODEMP FROM CADEMP WHERE EMP_C_G_C_ = :CNPJ');
    qryConsulta.ParamByName('CNPJ').AsString := strCNPJTomador;
    qryConsulta.Open;
    strCodEmpresa := qryConsulta.FieldByName('EMP_CODEMP').AsString;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TFreCon.fRetNomFornecedorInt(strCodFor: String): String;
begin
  Result := '';
  FConsulta.SQL.Clear;
  FConsulta.SQL.Text := 'SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = "' + strCodFor + '"';
  FConsulta.Open;
  If Not FConsulta.Isempty Then
    Result := FConsulta.FieldByName('FOR_NOMFOR').AsString;
End;


Procedure TFreCon.pReplicaAlqCof;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Atualizando alíquota de COFINS, aguarde...';
      fExecutarAcao := fReplicaAlqCofPrg;
      ShowModal;
    End;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFreCon.pReplicaAlqCof]');
    End;
  End;
End;

Function TFreCon.fReplicaAlqPisPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    intRecNo: Integer;
    strCSTPIS,
    strAutInc: String;
    fltAlqPis,
    fltBasPis: Double;
Begin
  intRecNo := qryTabela.RecNo;

  Try
    Result := True;

    With qryTabela Do
    Begin
      DisableControls;

      strCSTPIS := FieldByName('CSTPIS').AsString;
      strAutInc := FieldByName('AUTPIS').AsString;
      fltAlqPis := FieldByName('ALQPIS').AsFloat;
      fltBasPis := FieldByName('BASPIS').AsFloat;

      Filter   := 'CLAFI1 = ' + QuotedStr(FieldByName('CLAFI1').AsString);
      Filtered := True;

      prgProgresso.Properties.Max := RecordCount;

      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('AUTPIS').AsString := strAutInc;
        FieldByName('CSTPIS').AsString := strCSTPIS;
        FieldByName('ALQPIS').AsFloat  := fltAlqPis;
        FieldByName('BASPIS').AsFloat  := fltBasPis;
        Post;

        Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fReplicaAlqPisPrg]');
    End;
  End;

  With qryTabela Do
  Begin
    Filter   := '';
    Filtered := False;
    RecNo    := intRecNo;
    EnableControls;
  End;
End;

Function TFreCon.fReplicaAlqCofPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    intRecNo: Integer;
    strCstCof,
    strAutInc: String;
    fltAlqCof,
    fltBasCof: Double;
Begin
  intRecNo := qryTabela.RecNo;

  Try
    With qryTabela Do
    Begin
      Result := True;
      DisableControls;

      strAutInc := FieldByName('AUTCOF').AsString;
      strCstCof := FieldByName('CSTCOF').AsString;
      fltAlqCof := FieldByName('ALQCOF').AsFloat;
      fltBasCof := FieldByName('BASCOF').AsFloat;

      Filter   := 'CLAFI1 = ' + QuotedStr(FieldByName('CLAFI1').AsString);
      Filtered := True;

      prgProgresso.Properties.Max := RecordCount;

      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('AUTCOF').AsString := strAutInc;
        FieldByName('CSTCOF').AsString := strCstCof;
        FieldByName('ALQCOF').AsFloat  := fltAlqCof;
        FieldByName('BASCOF').AsFloat  := fltBasCof;
        Post;

        Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fReplicaAlqCofPrg]');
    End;
  End;

  With qryTabela Do
  Begin
    Filter   := '';
    Filtered := False;
    RecNo    := intRecNo;
    EnableControls;
  End;
End;

Function TFreCon.fVerificaAlqPisCofEntrada(strClaFis: String): Boolean;
Begin
  Result := True;

  If Not blnUtiAbr Then
    Exit;

  If tpFrete <> tpfEntrada Then
    Exit;

  If fEmptyStr(FAutPis) Then
  Begin
    pMensagemOk('Informe a alíquota de PIS!');
    Result := fSelecionaAbreviacaoPisEntrada(strClaFis);
  End;

  If Result And fEmptyStr(FAutCof) Then
  Begin
    pMensagemOk('Informe a alíquota de COFINS!');
    Result := fSelecionaAbreviacaoCofinsEntrada(strClaFis);
  End;

End;

function TFreCon.fCadFisExiste(Const strNumDoc: String;
                               Const strEspDoc: String;
                               Const strCodEmp: String;
                               Const strForCli: String;
                               Const strSerie: String;
                               Const strTipFC: String;
                               Const strEntSai: String): Boolean;
var
  qryCadFis: TUniQuery;
begin
  Result := False;
  qryCadFis := fCriaQuery();

  Try
    qryCadFis.SQL.Add('  SELECT                     ');
    qryCadFis.SQL.Add('    FIS_NUMDOC               ');
    qryCadFis.SQL.Add('  FROM                       ');
    qryCadFis.SQL.Add('    CADFIS                   ');
    qryCadFis.SQL.Add('  WHERE FIS_NUMDOC =:NUMDOC  ');
    qryCadFis.SQL.Add('    AND FIS_ESPDOC =:ESPDOC  ');
    qryCadFis.SQL.Add('    AND FIS_CODEMP =:CODEMP  ');
    qryCadFis.SQL.Add('    AND FIS_FORCLI =:FORCLI  ');
    qryCadFis.SQL.Add('    AND FIS_SERIE_ =:SERIE_  ');
    qryCadFis.SQL.Add('    AND FIS_TIP_FC =:TIP_FC  ');
    qryCadFis.SQL.Add('    AND FIS_ENTSAI =:ENTSAI  ');
    qryCadFis.SQL.Add('    LIMIT 1  ');

    qryCadFis.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCadFis.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCadFis.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFis.ParamByName('FORCLI').AsString := strForCli;
    qryCadFis.ParamByName('SERIE_').AsString := strSerie;
    qryCadFis.ParamByName('TIP_FC').AsString := strTipFC;
    qryCadFis.ParamByName('ENTSAI').AsString := strEntSai;

    qryCadFis.Open;

    If (Not qryCadFis.IsEmpty) Then
      Result := True;
  Finally
    FreeAndNil(qryCadFis);
  End;
end;

Function TFreCon.fCarregaAbreviacaoPisCof(strClaFis: String): Boolean;
Begin
  If (FListaClaFis.Count = 0) Or (FListaClaFis[0] <> strClaFis) And (strClaFis <> '') Then
  Begin
    FListaClaFis.Clear;
    FListaClaFis.Add(strClaFis);

    Result := fCarregaAbrevPisCof(False);

    If cdsAbrPis.Active And (cdsAbrPis.RecordCount = 1) Then
    Begin
      FAlqPis    := cdsAbrPis.FieldByName('APC_ALQENT').AsFloat;
      FPerBasPis := cdsAbrPis.FieldByName('APC_BASENT').AsFloat;
      FAutPis    := cdsAbrPis.FieldByName('AUTOINCREM').AsString;
      FCstPis    := cdsAbrPis.FieldByName('APC_CSTENT').AsString;
    End

    Else FAutPis := '';

    If cdsAbrCof.Active And (cdsAbrCof.RecordCount = 1) Then
    Begin
      FAlqCof    := cdsAbrCof.FieldByName('APC_ALQENT').AsFloat;
      FPerBasCof := cdsAbrCof.FieldByName('APC_BASENT').AsFloat;
      FAutCof    := cdsAbrCof.FieldByName('AUTOINCREM').AsString;
      FCstCof    := cdsAbrCof.FieldByName('APC_CSTENT').AsString;
    End

    Else FAutCof := '';

    If Not Result Then
      FListaClaFis.Clear;
  End

  Else Result := True;
End;

Class Function TFreCon.fSQLProdutosNota(strSeqger: String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                    ';
  strSQL := strSQL + '   D.DET_SEQGER AS AUTGER, ';
  strSQL := strSQL + '   D.AUTOINCREM AS AUTDET, ';
  strSQL := strSQL + '   D.DET_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '   D.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   M.MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   D.DET_QTDITE AS QTDITE, ';

  If fRateioFreteValorContabil Then
  Begin
    strSQL := strSQL + ' ROUND(D.DET_VLRCON / D.DET_QTDITE, 2) AS VALUNI, ';
    strSQL := strSQL + ' D.DET_VLRCON                          AS VALTOT, ';
  End Else
  Begin
    strSQL := strSQL + ' ROUND((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE, 2) AS VALUNI, ';
    strSQL := strSQL + ' D.DET_TOTITE - D.DET_DESESP                            AS VALTOT, ';
  End;

  strSQL := strSQL + '   C.ITE_MLTCOM AS MLTCOM, ';

  strSQL := strSQL + '   CAST(NULL AS DECIMAL(5, 2)) AS PERFRE, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(5, 2)) AS VALFRE  ';

  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '   MOVDET  D ';

  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE  ';

  strSQL := strSQL + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI   ';
  strSQL := strSQL + ' LEFT JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR   ';

  strSQL := strSQL + ' WHERE      ';

  If fEmptyStr(strSeqger) Then
    strSQL := strSQL + '  D.DET_SEQGER = :SEQGER '
  Else
    strSQL := strSQL + '  D.DET_SEQGER IN (' + strSeqger + ') ';

  Result := strSQL;
End;

Function TFreCon.fSQLProdutosNotaDuranteEntrada: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                              ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(20)) AS AUTGER, ';
  strSQL := strSQL + '   T.AUTOINCREM AS AUTDET, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(12)) AS NUMDOC, ';
  strSQL := strSQL + '   T.ENT_CODITE AS CODITE, ';
  strSQL := strSQL + '   T.ENT_DESITE AS DESITE, ';
  strSQL := strSQL + '   M.MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   T.ENT_QTDITE AS QTDITE, ';

  If fRateioFreteValorContabil Then
  Begin
    strSQL := strSQL + ' ROUND(T.ENT_VLRCON / T.ENT_QTDITE, 2) AS VALUNI, ';
    strSQL := strSQL + ' T.ENT_VLRCON                          AS VALTOT, ';
  End Else
  Begin
    strSQL := strSQL + ' ROUND((T.ENT_TOTITE - T.ENT_DESESP) / T.ENT_QTDITE, 2) AS VALUNI, ';
    strSQL := strSQL + ' T.ENT_TOTITE - T.ENT_DESESP                            AS VALTOT, ';
  End;

  strSQL := strSQL + '   C.ITE_MLTCOM AS MLTCOM, ';

  strSQL := strSQL + '   CAST(NULL AS DECIMAL(5, 2)) AS PERFRE, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(5, 2)) AS VALFRE  ';

  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '   TMP_ENTMER T ';

  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = T.ENT_CODITE  ';

  strSQL := strSQL + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = T.ENT_CODUNI   ';
  strSQL := strSQL + ' LEFT JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR   ';

  Result := strSQL;
End;

Class Function TFreCon.fCriaCdsRateioProdutos(Var cdsProdutos: TZClient; strSeqger: String = ''): Boolean;
Begin
  If Not Assigned(cdsProdutos) Then
  Begin
    cdsProdutos := TZClient.Create(Nil, fSQLProdutosNota(strSeqger));
    cdsProdutos.pCriaSoma('PERFRE', 'SUM_PERFRE');

    Result := cdsProdutos.fLeDados('TFreConLista.fCriaCdsRateioProdutos');
  End
  Else Result := True;
End;

Class Function TFreCon.fValidaRateioPercentual(cdsProdutos: TZClient): Boolean;
Begin
  If Assigned(cdsProdutos) Then
  Begin
    If cdsProdutos.State = dsEdit Then
      cdsProdutos.Post;

    Result := RoundTo(cdsProdutos.fRetSoma('SUM_PERFRE'), -2) = 100;
  End
  Else Result := False;
End;

Function TFreCon.fIncluiProdutosRateioNotas: Boolean;
Begin
  If blnVarNot Then
    Result := TfrmGravando.fExecuta(fIncluiProdutosRateioNotasPrg, FGravando, 'Carregando produtos, aguarde...')
  Else
    Result := TfrmGravando.fExecuta(fIncluiProdutosRateioDuranteEntradaPrg, FGravando, 'Carregando produtos, aguarde...')
End;

Function TFreCon.fIncluiProdutosRateioDuranteEntradaPrg(cxpProgresso: TcxProgressBar): Boolean;
Begin
  Result := fIncluiProdutosParaRateioNota('');
End;

Function TFreCon.fIncluiProdutosRateioNotasPrg(cxpProgresso: TcxProgressBar): Boolean;
Begin

  Try
    Result := True;

    cdsNotEnt.DisableControls;
    cdsNotEnt.First;

    While Not cdsNotEnt.Eof Do
    Begin
      Result := fIncluiProdutosParaRateioNota(cdsNotEnt.FieldByName('AUTINC').AsString);

      If Not Result Then
        Break;

      cdsNotEnt.Next;
    End;

    cdsNotEnt.EnableControls;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TFreConLista.fIncluiProdutosRateioNotas]');
    End;
  End;
End;

Function TFreCon.fIncluiProdutosParaRateioNota(strSeqGer: String): Boolean;
  Var
    qryItensNota: TUniQuery;
    intContador: Integer;
Begin
  qryItensNota := Nil;

  Try
    Try
      Result := fCriaCdsRateioProdutos(cdsRateioProdutos);

      If Not Result Then
        Exit;

      cdsRateioProdutos.DisableControls;

      qryItensNota := fCriaQuery;

      If blnVarNot Then
      Begin
        If cdsRateioProdutos.Locate('AUTGER', strSeqGer, []) Then
          Exit;

        qryItensNota.SQL.Text := fSQLProdutosNota;
        qryItensNota.ParamByName('SEQGER').AsString := strSeqGer;
      End Else
      Begin
        If Not cdsRateioProdutos.IsEmpty Then
          Exit;

        qryItensNota.SQL.Text := fSQLProdutosNotaDuranteEntrada;
      End;

      qryItensNota.Open;

      FGravando.lblGravando.Caption := 'Carregando os produtos da nota ' + qryItensNota.FieldByName('NUMDOC').AsString + ', aguarde...';
      FGravando.pgbStatus.Position := 0;
      FGravando.pgbStatus.Properties.Max := qryItensNota.RecordCount;
      Application.ProcessMessages;

      While Not qryItensNota.Eof Do
      Begin
        cdsRateioProdutos.Append;

        For intContador := 0 To cdsRateioProdutos.Fields.Count - 1 Do
          cdsRateioProdutos.Fields[intContador].Value := qryItensNota.Fields[intContador].Value;

        cdsRateioProdutos.Post;

        qryItensNota.Next;

        FGravando.pgbStatus.Position := FGravando.pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.message, '[TFreConLista.fIncluiProdutosParaRateioNota]');
      End;
    End;

  Finally
    cdsRateioProdutos.EnableControls;

    If Assigned(qryItensNota) Then
      FreeAndNil(qryItensNota);
  End;

End;

function TFreCon.fEstaEmModoRobo(): Boolean;
begin
  Result := SameText(ParamStr(1), 'IMPORTA-CTE');
end;

Function TFreCon.fExcluiProdutosParaRateioNota(strSeqGer: String): Boolean;
Begin
  Try
    Try
      Result := True;

      If Assigned(cdsRateioProdutos) Then
      Begin
        cdsRateioProdutos.DisableControls;
        cdsRateioProdutos.Filter   := 'AUTGER = ' + QuotedStr(strSeqGer);
        cdsRateioProdutos.Filtered := True;
        cdsRateioProdutos.First;

        While Not cdsRateioProdutos.Eof Do
          cdsRateioProdutos.Delete;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.message, '[TFreConLista.fIncluiProdutosParaRateioNota]');
      End;
    End;

  Finally
    cdsRateioProdutos.Filtered := False;
    cdsRateioProdutos.Filter   := '';
    cdsRateioProdutos.EnableControls;
  End;
End;

Function TFreCon.fPercentualFreteSobreNotas(fltTotFre: Double): Double;
  Var
    fltTotNot: Double;
Begin
  Result := 0;

  If blnVarNot Then
    fltTotNot := cdsNotEnt.fRetSoma('TOTCON')
  Else
    fltTotNot := fltVlrConNota;

  If fltTotNot > 0 Then
    Result := RoundTo((fltTotFre / fltTotNot) * 100, -2)
End;


function TFreCon.getRecebedor: TPessoaCTE;
begin
  Result := FRecebedor;
end;

function TFreCon.getRemetente: TPessoaCTE;
begin
  Result := FRemetente
end;

procedure TFreCon.pFiltraLog;
var strFiltro: String;
begin
  if Not FblnMostraLog Then
    Exit;

  strFiltro := '';

  if blnArquivoComErro Then
    strFiltro := 'STATUS = ' + IntToStr(IMPORTADO_COM_ERRO);
  if blnErroGravarRegistro Then
    strFiltro := Iif(strFiltro <> '', strFiltro + ' OR ', '') + 'STATUS = ' + IntToStr(COM_ERRO_GRAVACAO);
  if blnDocumentoJaExiste Then
    strFiltro := Iif(strFiltro <> '', strFiltro + ' OR ', '') + 'STATUS = ' + IntToStr(DOCUMENTO_JA_EXISTE);
  if blnNfeAnexaNaoIdentificada Then
    strFiltro := Iif(strFiltro <> '', strFiltro + ' OR ', '') + 'STATUS = ' + IntToStr(IMPORTADO_OK_SEM_NF);
  if blnInformarAbreviacaoPISCOF Then
    strFiltro := Iif(strFiltro <> '', strFiltro + ' OR ', '') + 'STATUS = ' + IntToStr(IMPORTADO_SEM_PISCOF);

  If strFiltro = '' then
    strFiltro :=  'STATUS = ' + IntToStr(IMPORTADO_OK);

  strFiltro := ' IMPORT = '+QuotedStr('S') + ' OR (' + strFiltro +')';

  if strFiltro <> '' Then
  Begin
    With qryTabela do
    Begin
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
    End;
  End;
end;



function TFreCon.fDocumentoCancelado: Boolean;
Var
  qryGen: TUniQuery;
Begin
  //Doc já cancelado
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT       ');
    qryGen.SQL.Add('1');
    qryGen.SQL.Add('FROM         ');
    qryGen.SQL.Add('  DEL_CADFIS     ');
    qryGen.SQL.Add('WHERE FIS_ACESSO = :ACESSO AND');
    qryGen.SQL.Add('      FIS_HISTOR =  "CANCELADO" AND');
    qryGen.SQL.Add('      NOT EXISTS (SELECT 1 FROM CADFIS WHERE FIS_ACESSO = :ACESSO)');
    qryGen.ParamByName('ACESSO').AsString := strAcesso;
    qryGen.Open;
    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TFreCon.fDocumentoPago: Boolean;
Var
  qryGen: TUniQuery;
Begin
  //Pagamento CTE ja efetuado
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Add('SELECT 1');
    qryGen.SQL.Add('FROM RECTNF');
    qryGen.SQL.Add('INNER JOIN CADFIS ON CADFIS.AUTOINCREM = RECTNF.REC_CTESEQ');
    qryGen.SQL.Add('INNER JOIN CADPAG ON CTP_CODFOR = FIS_FORCLI');
    qryGen.SQL.Add('                  AND CTP_NUMDUP = FIS_NUMDOC');
    qryGen.SQL.Add('                   AND LOCATE(FIS_NUMDOC, CTP_HIST01) > 0');
    qryGen.SQL.Add('AND CTP_DTAPAG IS NOT NULL');
    qryGen.SQL.Add('WHERE FIS_ACESSO = :ACESSO');
    qryGen.SQL.Add('UNION');
    qryGen.SQL.Add('SELECT 1');
    qryGen.SQL.Add('FROM CADFIS');
    qryGen.SQL.Add('INNER JOIN CADREC ON CTR_CODCLI = FIS_FORCLI');
    qryGen.SQL.Add('                  AND CTR_NUMDUP = FIS_NUMDOC');
    qryGen.SQL.Add('		  AND CTR_DTAREC IS NOT NULL');
    qryGen.SQL.Add('WHERE FIS_ACESSO = :ACESSO');

    qryGen.ParamByName('ACESSO').AsString := strAcesso;
    qryGen.Open;
    Result := Not qryGen.IsEmpty;


  Finally
    FreeAndNil(qryGen);
  End;
End;

function TFreCon.fDocumentoReferenciadoNoCTeEhDevolucaDeVenda(
  chaveDeAcesseo: String): Boolean;
Var
  qryGen: TUniQuery;

Begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT COUNT(1) AS QTD       ');
    qryGen.SQL.Add('   FROM CADFIS                ');
    qryGen.SQL.Add('  WHERE TRUE                  ');
    qryGen.SQL.Add('    AND FIS_ACESSO = :ACESSO  ');
    qryGen.SQL.Add('    AND FIS_CLFSC1 < "5000"   ');
    qryGen.SQL.Add('    AND FIS_ENTSAI = "E"      ');
    qryGen.SQL.Add('    AND FIS_TIP_FC = "C"      ');

    qryGen.ParambyName('ACESSO').AsString := chaveDeAcesseo;
    qryGen.Open;

    Result := qryGen.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TFreCon.fDocumentoReferenciadoNoCTeEhDevolucaDeCompra(
  chaveDeAcesseo: String): Boolean;
Var
  qryGen: TUniQuery;

Begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT COUNT(1) AS QTD       ');
    qryGen.SQL.Add('   FROM CADFIS                ');
    qryGen.SQL.Add('  WHERE TRUE                  ');
    qryGen.SQL.Add('    AND FIS_ACESSO = :ACESSO  ');
    qryGen.SQL.Add('    AND FIS_CLFSC1 > "5000"   ');
    qryGen.SQL.Add('    AND FIS_ENTSAI = "S"      ');
    qryGen.SQL.Add('    AND FIS_TIP_FC = "F"      ');

    qryGen.ParambyName('ACESSO').AsString := chaveDeAcesseo;
    qryGen.Open;

    Result := qryGen.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TFreCon.pCancelarDocumento;
Begin
  blnImportaPeloBancoDados := true;
  pAtualizaDados;
  Try
    fStartTransaction;
    pCancelarCadFis;
    fCommit;
  Except
    fRollBack;
  End;
End;

procedure TFreCon.pCancelarCadFis;
Var
  qryGen: TUniQuery;
  intContador2: Integer;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'SELECT * FROM CADFIS WHERE FIS_ACESSO = ' + strAcesso.QuotedString;
    qryGen.Open;
    While Not qryGen.Eof Do
    Begin
      qryGen.Edit;
      qryGen.FieldByName('FIS_HISTOR').AsString := 'CANCELADO';
      qryGen.FieldByName('FIS_BASPIS').Value := Null;
      qryGen.FieldByName('FIS_ALQPIS').Value := Null;
      qryGen.FieldByName('FIS_TOTPIS').Value := Null;

      qryGen.FieldByName('FIS_BASCOF').Value := Null;
      qryGen.FieldByName('FIS_ALQCOF').Value := Null;
      qryGen.FieldByName('FIS_TOTCOF').Value := Null;

      For intContador2 := 1 To 5 Do
      Begin
        qryGen.FieldByName('FIS_VLCON' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_BASIC' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_ALQIC' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_VLRIC' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_OUTRA' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_ISENT' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_RETID' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_BASIP' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_VLRIP' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_BCRET' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_DACES' + IntToStr(intContador2)).Value := Null;
        qryGen.FieldByName('FIS_VALIS' + IntToStr(intContador2)).Value := Null;
      End;
      qryGen.Post;

      qryGen.First;

      pApagaCtaPagar(qryGen.FieldByName('FIS_FORCLI').AsString,
        qryGen.FieldByName('FIS_NUMDOC').AsString,
        qryGen.FieldByName('FIS_CODEMP').AsString,
        qryGen.FieldByName('FIS_SERIE_').AsString,
        qryGen.FieldByName('FIS_ESPDOC').AsString,
        FAutInc);

      fVerificaIntegridade('frmCancelamentoFrete', 'CADFIS', qryGen, True);

      qryGen.Delete;
    End;
    pCancelarCanCTe;
  Except
    FreeAndNil(qryGen);
  End;
End;

procedure TFreCon.pCancelarCanCTe;
Var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'SELECT * FROM CANCTE WHERE FALSE';
    qryGen.Open;
    qryGen.Edit;
    qryGen.FieldByName('AUTOINCREM').Value := fRetAutoIncrem('CANCTE',FCodEmp);
    qryGen.FieldByName('CAN_CODFOR').Value := FCodTra;
    qryGen.FieldByName('CAN_CODEMP').Value := FCodEmp;
    qryGen.FieldByName('CAN_DTACAN').Value := FDtaCan;
    qryGen.FieldByName('CAN_ESPDOC').Value := FEspDoc;
    qryGen.FieldByName('CAN_NUMDOC').Value := FNumDoc;
    qryGen.FieldByName('CAN_SERIE_').AsString := FSerie_;
    qryGen.FieldByName('CAN_CODOPE').AsString := strLoginUsuarioLogado;
    qryGen.FieldByName('CAN_DTAOPE').AsString := FormatDateTime('dd/mm/yyyy',FDtaOpe);
    qryGen.FieldByName('CAN_HOROPE').AsString := FormatDateTime('hh:nn:ss',FDtaOpe);
    qryGen.Post;
  Except
    FreeAndNil(qryGen);
  End;
End;

function TFreCon.fConfirmarCancelamento(prgProgresso: TProgressBar): Boolean;
Begin
  Try
    qryTabela.DisableControls;
    qryTabela.Filter   := 'IMPORT = ' + QuotedStr('S');
    qryTabela.Filtered := True;
    qryTabela.First;
    Result := Not qryTabela.IsEmpty;
    If Not Result Then
    Begin
      qryTabela.Filtered := false;
      qryTabela.EnableControls;
      pMensagemOk('Selecione os arquivos para cancelamento!');
      Exit;
    End;

    If Not fPergunta('Confirma o cancelamento do(s) arquivo(s) selecionado(s)?') Then
    Begin
      Result := False;
      qryTabela.Filtered := False;
      qryTabela.EnableControls;
      Exit;
    End;
    FDtaOpe := fNow;
    prgProgresso.Position := 0;
    prgProgresso.Max      := qryTabela.RecordCount;
    prgProgresso.Visible  := True;
    qryTabela.First;
    While Not qryTabela.Eof Do
    Begin
      pCancelarDocumento;
      prgProgresso.StepBy(1);
      Application.ProcessMessages;
      qryTabela.NExt;
    End;

    pMensagemOk('Arquivo(s) cancelado(s) com sucesso!');

    qryTabela.Filtered := False;
    qryTabela.EnableControls;
    prgProgresso.Visible  := False;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFreCon.fConfirmaImportacaoFrete]');
    End;
  End;
  pFiltraLog;
end;


procedure TFreCon.pCarregaArquivoFreteXMLEvento(strNomArq : String; memLog, memErr: TStrings);
Var
  xmlDoc: TXMLDocument;
Begin
  Try
    FStatus := IMPORTADO_OK;
    xmlDoc := TXMLDocument.Create(Self);
    Try
      xmlDoc.LoadFromFile(strNomArq);
      xmlDoc.Active := True;
      XML := xmlDoc
        .ChildNodes
        .FindNode('procEventoCTe')
          .ChildNodes
          .FindNode('retEventoCTe')
            .ChildNodes
            .FindNode('infEvento');
    Except
      On E: Exception Do
      Begin
        FStatus := IMPORTADO_COM_ERRO;
        pEscreveMensagemImportacao(memErr, 'Arquivo XML Inconsistente: ' + E.Message, 0);
        FreeAndNil(xmlDoc);
      End;
    End;
  Finally
    FreeAndNil(xmlDoc);
  End;
End;

procedure TFreCon.pCarregarDadosXMLEvento;
Var
  strDataCancelamento: String;
Begin
  Try
    FEspDoc := 'CT';
    FCodEmp := VS_strCodEmp;
    strAcesso := XML.ChildValues['chCTe'];
    FCgcTra  := strAcesso.Substring(6,14);
    FCodTra := fRetCodFornecedorPorCnpj(FCgcTra);
    FModelo := strAcesso.Substring(20,2);
    strSerie_ := strAcesso.Substring(22,3);
    strNumDoc := strAcesso.Substring(25,9).PadLeft(12,'0');
    strDataCancelamento := XML.ChildValues['dhRegEvento'];
    strDataCancelamento := strDataCancelamento.Substring(8,2)  + '/' +
      strDataCancelamento.Substring(5,2) + '/' +
      strDataCancelamento.Substring(0,4);
    FDtaCan := StrToDateDef( strDataCancelamento,0);
    FAutInc := fRetAutoincremCadFis(strAcesso);
    FDtaDoc := fRetDataDoc;
  Except
    Abort;
  End;
End;

function TFreCon.fValidarXMLEvento(memErr: TStrings): Boolean;
Begin
  If fEmptyStr(fRetAutoincremCadFis(strAcesso)) Then
  Begin
    pEscreveMensagemImportacao(memErr, 'Documento ' + strNumDoc +'-'+ strEspDoc + ': ' + 'não existe no sistema!', 0);
    FStatus := DOCUMENTO_NAO_EXISTE;
  End
  Else If fDocumentoPago Then
  Begin
    pEscreveMensagemImportacao(memErr, 'Documento Pago ' + strNumDoc +'-'+ strEspDoc + ': ' + 'no sistema!', 0);
    FStatus := DOCUMENTO_PAGO;
  End
  Else If fDocumentoCancelado Then
  Begin
    pEscreveMensagemImportacao(memErr, 'Documento Cancelado ' + strNumDoc +'-'+ strEspDoc + ': ' + 'no sistema!', 0);
    FStatus := DOCUMENTO_CANCELADO;
  End;

  Result := FStatus = IMPORTADO_OK;
End;

function TFreCon.fRetDataDoc: TDate;
Begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT FIS_DTADOC FROM CADFIS WHERE FIS_ACESSO = ' + strAcesso.QuotedString);
  FConsulta.Open;
  Result := FConsulta.FieldByName('FIS_DTADOC').AsDateTime;
End;

function TFreCon.fRetDescricaoTipoFrete(AtpDocFrete: TTipoDocFrete): string;
begin
  case AtpDocFrete of
    tpdfIndefinido: Result := 'Indefinido';
    tpdfCompra: Result := 'Compra';
    tpdfVenda: Result := 'Venda';
    tpdfDevolucaoVenda: Result := 'Devolução de Venda';
    tpdfDevolucaoCompra: Result := 'Devolução de Compra';
  end;
  {}
end;

procedure TFreCon.pApagaCtaPagar(strForCli, strNumDoc, strCodEmp, strSerie, strEspDoc : String; strAutInc: String);
Begin
  TfrmCancelamentoDocumentos.pCancelarCTE(strNumDoc, strEspDoc, strForCli, strSerie);
End;


function TFreCon.fValidarUFsPessoas(var AStrErro: String): Boolean;
begin
  AStrErro := '';
  If (Not fEmptyStr(FRemetente.strUF)) And (Not MatchStr(FRemetente.strUF, ESTADOS)) Then
  Begin
    AStrErro := IIF(Not fEmptyStr(AStrErro), #13, '') + 'UF inválida para o remetente! UF lida: ' + FRemetente.strUF;
  End;
  If (Not fEmptyStr(FEmitente.strUF)) And (Not MatchStr(FEmitente.strUF, ESTADOS)) Then
  Begin
    AStrErro := IIF(Not fEmptyStr(AStrErro), #13, '') + 'UF inválida para o emitente! UF lida: ' + FEmitente.strUF;
  End;
  If (Not fEmptyStr(FExpedidor.strUF)) And (Not MatchStr(FExpedidor.strUF, ESTADOS)) Then
  Begin
    AStrErro := IIF(Not fEmptyStr(AStrErro), #13, '') + 'UF inválida para o expedidor! UF lida: ' + FExpedidor.strUF;
  End;
  If (Not fEmptyStr(FRecebedor.strUF)) And (Not MatchStr(FRecebedor.strUF, ESTADOS)) Then
  Begin
    AStrErro := IIF(Not fEmptyStr(AStrErro), #13, '') + 'UF inválida para o recebedor! UF lida: ' + FRecebedor.strUF;
  End;
  If (Not fEmptyStr(FDestinatario.strUF)) And (Not MatchStr(FDestinatario.strUF, ESTADOS)) Then
  Begin
    AStrErro := IIF(Not fEmptyStr(AStrErro), #13, '') +'UF inválida para o destinatário! UF lida: ' + FDestinatario.strUF;
  End;
  If (Not fEmptyStr(FTomador.strUF)) And (Not MatchStr(FTomador.strUF, ESTADOS)) Then
  Begin
    AStrErro := IIF(Not fEmptyStr(AStrErro), #13, '') + 'UF inválida para o tomador! UF lida: ' + FTomador.strUF;
  End;

  Result := fEmptyStr(AStrErro);

end;

function TFreCon.fExisteFornecedor(strCGC: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  Try
    qryGen.SQL.Add('SELECT FOR_CODFOR, FOR_MATREV FROM CADFOR');
    qryGen.SQL.Add('WHERE');
    qryGen.SQL.Add('  REPLACE(REPLACE(REPLACE(FOR_C_G_C_, "/",""), ".",""), "-","") = :C_G_C_     ');
    qryGen.SQL.Add('ORDER BY FOR_STATUS LIMIT 1');

    qryGen.ParamByName('C_G_C_').AsString := fTiraCaracEspeciais(strCGC);

    qryGen.Open;

    Result := Not qryGen.IsEmpty;

    qryGen.Close;
  Finally;
    FreeAndNil(qryGen);
  End;
End;

procedure TFreCon.pInsereCdsFornNaoEncontrado(strCNPJ,
  strCPF, strXNOME, strXFANT, strXLGR, strNRO, strXCPL, strXBAIRRO, strCMUN,
  strXMUN, strUF, strCEP, strCPAIS, strXPAIS, strFONE, strIE, strIEST, strIM,
  strCNAE: String);
begin
  FCdsFornNaoEncontrado.Insert;
  FCdsFornNaoEncontrado.FieldByName('CNPJ').AsString    := strCNPJ;
  FCdsFornNaoEncontrado.FieldByName('CPF').AsString     := strCPF;
  FCdsFornNaoEncontrado.FieldByName('xNome').AsString   := strXNOME;
  FCdsFornNaoEncontrado.FieldByName('xFant').AsString   := strXFANT;
  FCdsFornNaoEncontrado.FieldByName('xLgr').AsString    := strXLGR;
  FCdsFornNaoEncontrado.FieldByName('nro').AsString     := strNRO;
  FCdsFornNaoEncontrado.FieldByName('xCpl').AsString    := strXCPL;
  FCdsFornNaoEncontrado.FieldByName('xBairro').AsString := strXBAIRRO;
  FCdsFornNaoEncontrado.FieldByName('cMun').AsString    := strCMUN;
  FCdsFornNaoEncontrado.FieldByName('xMun').AsString    := strXMUN;
  FCdsFornNaoEncontrado.FieldByName('UF').AsString      := strUF;
  FCdsFornNaoEncontrado.FieldByName('CEP').AsString     := strCEP;
  FCdsFornNaoEncontrado.FieldByName('cPais').AsString   := strCPAIS;
  FCdsFornNaoEncontrado.FieldByName('xPais').AsString   := strXPAIS;
  FCdsFornNaoEncontrado.FieldByName('fone').AsString    := strFONE;
  FCdsFornNaoEncontrado.FieldByName('IE').AsString      := strIE;
  FCdsFornNaoEncontrado.FieldByName('IEST').AsString    := strIEST;
  FCdsFornNaoEncontrado.FieldByName('IM').AsString      := strIM;
  FCdsFornNaoEncontrado.FieldByName('CNAE').AsString    := strCNAE;
  FCdsFornNaoEncontrado.Post;
end;

end.


