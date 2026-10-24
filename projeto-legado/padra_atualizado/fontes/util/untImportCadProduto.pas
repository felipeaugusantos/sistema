unit untImportCadProduto;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, Math, untTGerenciaItegerPermiteEdicao,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  untParCalculaPrecoCusto, untTValidaExcel, cxProgressBar, Datasnap.DBClient,
  untImportCadProdutoConfirma, untTypesSistema, EditFocus, System.Character;

type


  TTipoPesquisa = (pesCodIte, pesCodBar, pesCodFab, pesIteForCodFab, pesNenhuma, pesDesIte);

  TfrmImportCadProduto = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    gpbRecalcular: TGroupBox;
    rdbMargem: TRadioButton;
    rdbPreVen: TRadioButton;
    btnGravar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    pgbGeral: TcxProgressBar;
    btnCancelaValidacao: TBitBtnLocked;
    btnConfigura: TBitBtnLocked;
    cdsCampos: TUniClientDataSet;
    cdsCamposDESCRI: TStringField;
    cdsCamposCOLUNA: TStringField;
    cdsCamposMARDES: TStringField;
    cdsCamposINDEX: TIntegerField;
    ChkNaoReduzirPrecoCompra: TCheckBox;
    chkCnvCus: TCheckBox;
    cdsCamposFIELD: TStringField;
    GroupBox2: TGroupBox;
    edtDecUni: TEditFocus;
    chkArrMai: TCheckBox;
    procedure pCriarCds;
    procedure pLimparCDS;
    procedure pFormatarCampo(strCampo: string; blnTem_ITE: boolean = False);
    procedure btnGravarClick(Sender: TObject);
    procedure pInsereItensCDS(intLinha: integer);
    function fItemComMesmaDecricao(strDesIte: String): Boolean;
    function fAlterouPreco(cdsItens: TZClient): boolean;
    function fAlterou(cdsItens: TZClient; strField: String; blnArredonda: Boolean = False; intPrecisao : integer = -1): Boolean;

    procedure pPopulaCDSEstIm(strCodIte, strLista, strField: String; var strErro: String);
    function fDuplicadadeIteFor(var strMensagem: string): boolean;
    function fConvetVazioToNull(texto: string): Variant;

    function fSQLIteger(pesTipPes: TTipoPesquisa): String;

    function  fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
    function  fTemTitulo: boolean;

    function  fLocalizaItemIteger(qryLocaliza: TUniQuery; intLinha: Integer; Var strErro: String; var TipoPesquisa: TTipoPesquisa): boolean;

    Procedure pCalcularPrecos(cdsItens: TZClient; Var recPrecos: TArrRecPrecos; fltCnvCus: Double);
    function  fRetPrecoCusto(fltPreCom,
                             fltDesF01,
                             fltDesF02,
                             fltDesF03,
                             fltDesF04,
                             fltDesF05,
                             fltDesF06,
                             fltICMEnt,
                             fltSubFed,
                             fltIpiEnt,
                             fltFreEnt,
                             fltAcrFin,
                             fltSubsti,
                             fltDesAdb,
                             fltVrFret: Double;
                             blnPreDol: Boolean;
                             fltTCIFCu,
                             fltTSCust,
                             fltDePiCo,
                             fltDeICMS,
                             fltFatReg: Double): Double;
    function fSqlBase: string;
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaValidacaoClick(Sender: TObject);
    procedure btnConfiguraClick(Sender: TObject);
    function fValidaListaOpcEstoqueMinimo(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fValidaListaSituacaoProduto(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    function fValidaListaAbreviacaoFiscal(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
    procedure pValidaEstoqueMAximoEMinimo(var strErro: String);
    function fValidarChecklistGarantiaMercadoria(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
    function fValidarChecklistTrocaMercadoria(strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
    procedure chkArrMaiClick(Sender: TObject);
    function fGetSQLIteEmb() : String;
    function ValidarCaractereInvalido(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;

  private
    lstDesIte: TStringList;
    blnArqCsv: Boolean;
    lst: TStringList;
    intSequencial: Integer;
    Excel : Variant;
    objFatPre: TFatorPreco;
    cdsItens : TZClient;
    cdsItensEmbalagem: TZClient;
    cdsItensEmbDescFech: TZClient;
    cdsESTMIN_ESTMAX: TZClient;
    qryConsulta: TUniQuery;
    qryItensEncontrados: TUniQuery;
    GerenciaItegerPermiteEdicao : TGerenciaItegerPermiteEdicao;
    cpcParams: TParCalculaPrecoCusto;
    recPrecos: TArrRecPrecos;
    objValidaExcel: TValidadorExcel;

    strDesValFre: String;
    blnUsaQtdPen: Boolean;

    qryCodBar,
    qryCodFab: TUniQuery;

    intDecUni: Integer;

    strEstEmp,
    strCnvEmb,
    strMarMkp,
    strPcmPro: String;
    blnProCod: Boolean;
    blnURapel: Boolean;
    function fValidarTipoFrete(strColuna, strTabela, strCampo, strValor: string;
      var strMensagem: String): boolean;

    function fValidarEstoqueMinimo(strColuna, strTabela, strCampo, strValor: string;
      var strMensagem: String): boolean;

    const cQtdColunas = 173;
    const cCODITE = 'A';  // COD.CITEL
          cCODBAR = 'B';  // COD.BARRAS
          cCODFAB = 'C';  // COD.FABRICA
          cCODFOR = 'D';  // COD.FORNECEDOR
          cCODDEP = 'E';  // COD.DEPARTAMENTO
          cCODGRU = 'F';  // COD.LINHA/GRUPO
          cDESITE = 'G';  // DESCRICAO DO PRODUTO
          cDESFAB = 'H';  // DESCRICAO DO FABRICANTE
          cCODMAR = 'I';  // COD.MARCA
          cREFERE = 'J';  // REFERENCIA
          cCODUNI = 'K';  // COD.UNIDADE DE VENDA
          cUNICOM = 'L';  // COD.UNIDADE DE COMPRA
          cCODABF = 'M';  // COD.ABREVIACAO ICMS
          cABFPIS = 'N';  // COD.ABREVIACAO PIS
          cABFCOF = 'O';  // COD.ABREVIACAO COFINS
          cABFIPI = 'P';  // COD.ABREVIACAO IPI
          cIPISAI = 'Q';  // % IPI DE SAIDA
          cINCPIS = 'R';  // INCIDE PIS/COFINS ( S/N )
          cCLAIPI = 'S';  // NCM
          cEXCIPI = 'T';  // COD.EX NCM
          cCDCEST = 'U';  // COD.CLASSIFICACAO CEST
          cCODONU = 'V';  // COD.CLASSIFICACAO ONU
          cIMPLIS = 'W';  // IMPRIME LISTA ( S/N )
          cITEATI = 'X';  // PRODUTO ATIVO ( S/N )
          cATICOM = 'Y';  // ATIVO PARA COMPRAS ( S/N )
          cPESOIT = 'Z';  // PESO BRUTO
          cCODGPR = 'AA'; // COD.GRUPO DE PREÇOS
          cPRDGRU = 'AB'; // COD.GRUPO DE PRODUTOS
          cGRUCMP = 'AC'; // COD.GRUPO DE COMPRAS
          cMLTVEN = 'AD'; // MULTIPLO DE VENDA
          cMLTCOM = 'AE'; // MULTIPLO DE COMPRA
          cNVLGIR = 'AF'; // NIVEL DE GIRO GERAL
          cACOOBJ = 'AG'; // ACORDO DE OBJETIVOS
          cAPLICA = 'AH'; // APLICACAO
          cPRECOM = 'AI'; // PR.COMPRA
          cDESF01 = 'AJ'; // % DESCONTO FORNECEDOR 1 (-)
          cDESF02 = 'AK'; // % DESCONTO FORNECEDOR 2 (-)
          cDESF03 = 'AL'; // % DESCONTO FORNECEDOR 3 (-)
          cDESF04 = 'AM'; // % DESCONTO FORNECEDOR 4 (-)
          cDESF05 = 'AN'; // % DESCONTO FORNECEDOR 5 (-)
          cDESF06 = 'AO'; // % DESCONTO FORNECEDOR 6 (-)
          cICMENT = 'AP'; // % ICMS ENTRADA (-)
          cSUBFED = 'AQ'; // % IMPOSTOS FEDERAIS (-)
          cIPIENT = 'AR'; // % IPI ENTRADA (+)
          cFREENT = 'AS'; // % FRETE (+)
          cVALFRE = 'AT'; // VALOR DE FRETE (+)
          cACRFIN = 'AU'; // % ACRESCIMO FINANCEIRO (+)
          cSUBSTI = 'AV'; // % SUB.TRIBUTARIA (+)
          cDESADB = 'AW'; // % XXXXXXXXXXXXXXXXXXXXXXXXXXXXX   ( exibir
          cOUTVAL = 'AX'; // % OUTROS VALORES (+)              ( exibir
          cICMSAI = 'AY'; // % ICMS SAIDA (+)
          cIMPFED = 'AZ'; // % IMPOSTOS FEDERAIS (+)
          cDESOPE = 'BA'; // % DESPESAS OPERACIONAIS (+)
          cMARBR1 = 'BB'; // % MARGEM/MARKUP TAB 1
          cCOMTB1 = 'BC'; // % COMISSAO TAB 1
          cPREVE1 = 'BD'; // PREÇO DE VENDA TAB 1
          cMARBR2 = 'BE'; // % MARGEM/MARKUP TAB 2
          cCOMTB2 = 'BF'; // % COMISSAO TAB 2
          cPREVE2 = 'BG'; // PREÇO DE VENDA TAB 2
          cMARBR3 = 'BH'; // % MARGEM/MARKUP TAB 3
          cCOMTB3 = 'BI'; // % COMISSAO TAB 3
          cPREVE3 = 'BJ'; // PREÇO DE VENDA TAB 3
          cMARBR4 = 'BK'; // % MARGEM/MARKUP TAB 4
          cCOMTB4 = 'BL'; // % COMISSAO TAB 4
          cPREVE4 = 'BM'; // PREÇO DE VENDA TAB 4
          cMARBR5 = 'BN'; // % MARGEM/MARKUP TAB 5
          cCOMTB5 = 'BO'; // % COMISSAO TAB 5
          cPREVE5 = 'BP'; // PREÇO DE VENDA TAB 5
          cMARBR6 = 'BQ'; // % MARGEM/MARKUP TAB 6
          cCOMTB6 = 'BR'; // % COMISSAO TAB 6
          cPREVE6 = 'BS'; // PREÇO DE VENDA TAB 6
          cMARBR7 = 'BT'; // % MARGEM/MARKUP TAB 7
          cCOMTB7 = 'BU'; // % COMISSAO TAB 7
          cPREVE7 = 'BV'; // PREÇO DE VENDA TAB 7
          cCOMVAR = 'BW'; // % COMISSAO VENDEDOR INTERNO LOJA
          cCOMATA = 'BX'; // % COMISSAO VENDEDOR EXTERNO LOJA
          cCOMDIS = 'BY'; // % COMISSAO VENDEDOR EXTERNO DISTRIBUIDOR
          cCOMPRO = 'BZ'; // % COMISSAO PROFISSIONAL
          cDESMAX = 'CA'; // % DESCONTO MAXIMO VENDEDOR
          cDESMSU = 'CB'; // % DESCONTO MAXIMO SUB-GERENTE
          cDESMGE = 'CC'; // % DESCONTO MAXIMO GERENTE
          cMARMIN = 'CD'; // % MARGEM MINIMA VENDEDOR
          cMARMSG = 'CE'; // % MARGEM MINIMA SUB-GERENTE
          cMARMGE = 'CF'; // % MARGEM MINIMA GERENTE
          cTMPGAR = 'CG'; // TEMPO DE GARANTIA ( MESES )
          cINFGAR = 'CH'; // INFORMACOES DA GARANTIA DO PRODUTO
          cLOCFIS = 'CI'; // LOCALIZACAO FISICA
          cLOCSUP = 'CJ'; // LOCALIZACAO SUPER ESTOQUE
          cITEBAS = 'CK'; // PRODUTO BASE
          cITEPIG = 'CL'; // ITEM PIGMENTO
          cBAREXP = 'CM'; // OBRIGATORIO CÓDIGO DE BARRAS EXPEDIÇÃO
          cCPRCEN = 'CN'; // COMPRA CENTRALIZADA
          cCODMON = 'CO'; // Codigo de montadora separado por
          cNIVGIR = 'CP'; // Nivel de Giro por empresa
          cPESLIQ = 'CQ'; // Peso Liquído
          cCODLSE = 'CR'; // Local de Separação
          cDIAFOR = 'CS'; // Dias Para  Entrega do Fornecedor
          //Dados E-Commerce
          cEXPSIT = 'CT'; //Exportação para E-Commerce

          cDSSITE = 'CU'; //Descrição do Produto (E-Commerce)
          cDADTEC = 'CV'; //Dados Técnicos (E-Commerce)
          cURLIMG = 'CW'; //URL da imagem (E-Commerce)
          cNOMITE = 'CX'; //Nome do Produto (E-Commerce)
          cAPLITE = 'CY'; //Aplicação (E-Commerce)
          cINCLUS = 'CZ'; //Itens Inclusos (E-Commerce)
          cEXPALT = 'DA'; //Altura (E-Commerce)
          cEXPLAR = 'DB'; //Largura (E-Commerce)
          cEXPPRO = 'DC'; //Profundidade (E-Commerce)
          cDESSIT = 'DD'; //Desconto para Site (E-Commerce)
          cCODCAT = 'DE'; //Categorias (E-Commerce)
          cDESTAQ = 'DF'; //Destaque (E-Commerce)
          cATZPRE = 'DG'; //Atualiza preços no site? (E-Commerce)
          cEXPAPP = 'DH'; //Exportação APP Venda Assistida


          cITEFOR_CODFOR = 'DI'; //Aba fornecedor FORNECEDOR
          cITEFOR_CODITF = 'DJ'; //Aba Fornecedor CODFAB Fornecedor
          cITEFOR_CODCNA = 'DK'; //Aba Fornecedor CODCNA
          cESTMIN = 'DL'; //Estoque Minimo
          cESTMAX = 'DM'; //Estoque Maximo
          cTCIFCU = 'DN'; //TCIF (+)
          cTSCUST = 'DO'; //TS (+)
          cDEPICO = 'DP'; //DESCONTO PIS/COFINS (-)
          cDEICMS = 'DQ'; //DESCONTO ICMS (-)
          cFATREG = 'DR'; //FATOR REGIONAL (+)
          cEMBALA = 'DS'; //embalagem
          cUNITRI = 'DT'; //Unidade Tributacao
          cEXPPOK = 'DU'; //Exporta Tablet
          cTIPPRO = 'DV'; //Tipo de produto
          cINDREV = 'DW'; //Industrialização ou Revenda
          cIMPDIR = 'DX'; //Importação Direta

          cMSGLV1 = 'DY'; //Mensagem Livre 1
          cMSGLV2 = 'DZ'; //Mensagem Livre 2
          cPEEFUT = 'EA'; //Permitir Entrega Futura com Status "Aguardando o Cliente"
          cPEFUTP = 'EB'; //Permitir Entrega Futura com Status "Previsão de Entrega"
          cPEFFPR = 'EC'; //Permitir Entrega Futura com Status "Falta de Produto"

          cESMIDG_LISTA = 'ED'; //Lista de Opção para estoque mínimo
          cESTMIN_LISTA = 'EE'; //Opção para estoque mínimo
          cESTMAX_LISTA = 'EF'; //Opção para estoque maximo
          cSITPRO_LISTA = 'EG'; //Lista de Situação do Produto

          cDESSIM = 'EH';  // Descrição Simplificada
          cTIPFRE = 'EI';  // Tipo de Frete
          cVLCFRE = 'EJ';  // Valor de Frete
          cQRCODE = 'EK';  // QRCode
          cEXPB2B = 'EL';  // Exportar para B2B
          cPRAVAL = 'EM';  // Prazo de Vaidade (MESES)
          cNVLCRI = 'EN';  // Nivel de Criticidade
          cABVFIS_LISTA = 'EO';  // Abreviação fiscal
          cRECDEV = 'EP';  // Permitir receber devolução deste produto
          cVALOBR = 'EQ';  //Validade Obrigatoria
          cCOMPOS = 'ER';  //Composição
          cITESAC = 'ES';  //SAC
          cPAISOR = 'ET';  //PAIS ORIGEM
          cCODATC = 'EU';  // código assistência técnica

          cMARGE1 = 'EX';  // Margem Ideal 1
          cMARGE2 = 'EY';  // Margem Ideal 2
          cMARGE3 = 'EZ';  // Margem Ideal 3
          cMARGE4 = 'FA';  // Margem Ideal 4
          cMARGE5 = 'FB';  // Margem Ideal 5
          cMARGE6 = 'FC';  // Margem Ideal 6
          cMARGE7 = 'FD';  // Margem Ideal 7

          cSOBENC = 'FE';  // Sob encomenda?
          cQTDPES = 'FF';  // Qtde mín. estoque para ponta de estoque
          cPORPES = 'FG';  // % de desconto aplicado para ponta de estoque
          cMLTRCA = 'FH';  // Múltiplo na rotina Citel Abastece

          cPER_CI = 'FI';  // Percentual (CI)
          cNUMFCI = 'FJ';  // Número da Ficha (FCI)

          cFATUTR = 'FK';  // Fator Conversão (Unid. Trib)
          cPRAPEL = 'FL';  //Desconto Referente Rapel
          cITEEMB = 'FM';  //Desconto Embalagem Fechada(ITEEMB)
          cCEREPI = 'FN';  //Certificado de Aprovação de EPI
          cMARPAD = 'FO';  //Margem Padrão
          cTPESTM_LISTA = 'FP';  //Tipo de Estoque Mínimo

          cABFPIS_LISTA = 'FQ';  // Abreviação fiscal PIS
          cABFCOF_LISTA = 'FR';  // Abreviação fiscal COFINS

          {IMPORTANTE - Ao criar campo novo, deve aumentar a quantidade de linha
          em constante declarada acima(const cQtdColunas = 170)}

    const cDesCODITE = 'Cód. Produto';
          cDesCODBAR = 'Cód. Barras';
          cDesCODFAB = 'Cód. Fabrica';
          cDesCODFOR = 'Cód. Fornecedor';
          cDesCODDEP = 'Cód. Departamento';
          cDesCODGRU = 'Cód. Linha/Grupo';
          cDesDESITE = 'Descrição do Produto';
          cDesDESFAB = 'Descrição do Fabricante';
          cDesCODMAR = 'Cód. Marca';
          cDesREFERE = 'Referencia';
          cDesCODUNI = 'Cód. Unidade de Venda';
          cDesUNICOM = 'Cód. Unidade de Compra';
          cDesCODABF = 'Cód. Abreviação ICMS';
          cDesABFPIS = 'Cód. Abreviação PIS';
          cDesABFCOF = 'Cód. Abreviação COFINS';
          cDesABFIPI = 'Cód. Abreviação IPI';
          cDesIPISAI = '% IPI de Saída';
          cDesINCPIS = 'Incide PIS/COFINS';
          cDesCLAIPI = 'NCM';
          cDesEXCIPI = 'Cód.Ex NCM';
          cDesCDCEST = 'Cód. Classificação CEST';
          cDesCODONU = 'Cód. Classificação ONU';
          cDesIMPLIS = 'Imprime Lista';
          cDesITEATI = 'Produto Ativo';
          cDesATICOM = 'Ativo Para Compras';
          cDesPESOIT = 'Peso Produto';
          cDesCODGPR = 'Cód.Grupo de Preços';
          cDesPRDGRU = 'Cód. Grupo de Produtos';
          cDesGRUCMP = 'Cód. Grupo de Compras';
          cDesMLTVEN = 'Mlt Venda';
          cDesMLTCOM = 'Mlt Compra';
          cDesNVLGIR = 'Nivel de Giro';
          cDesACOOBJ = 'Acordo de Objetivos';
          cDesAPLICA = 'Aplicação';
          cDesPRECOM = 'Preço Compra';
          cDesDESF01 = '% Desconto Fornecedor 1 (-)';
          cDesDESF02 = '% Desconto Fornecedor 2 (-)';
          cDesDESF03 = '% Desconto Fornecedor 3 (-)';
          cDesDESF04 = '% Desconto Fornecedor 4 (-)';
          cDesDESF05 = '% Desconto Fornecedor 5 (-)';
          cDesDESF06 = '% Desconto Fornecedor 6 (-)';
          cDesICMENT = '% ICMS Entrada (-)';
          cDesSUBFED = '% Impostos Federais (-)';
          cDesIPIENT = '% IPI Entrada (+)';
          cDesFREENT = '% Frete (+)';
          cDesVALFRE = 'Valor de Frete (+)';
          cDesACRFIN = '% Acrecimo Financeiro (+)';
          cDesSUBSTI = '% Sub.Tributaria (+)';
          cDesDESADB = '';
          cDesOUTVAL = '';
          cDesICMSAI = '% ICMS Saída (+)';
          cDesIMPFED = '% Impostos Federais (+)';
          cDesDESOPE = '% Despesas Operacionais (+)';
          cDesMARBR1 = '% Margem/Markup Tab 1';
          cDesCOMTB1 = '% Comissão Tab 1';
          cDesPREVE1 = 'Preço de Venda Tab 1';
          cDesMARBR2 = '% Margem/Markup Tab 2';
          cDesCOMTB2 = '% Comissão Tab 2';
          cDesPREVE2 = 'Preço de Venda Tab 2';
          cDesMARBR3 = '% Margem/Markup Tab 3';
          cDesCOMTB3 = '% Comissão Tab 3';
          cDesPREVE3 = 'Preço de Venda Tab 3';
          cDesMARBR4 = '% Margem/Markup Tab 4';
          cDesCOMTB4 = '% Comissão Tab 4';
          cDesPREVE4 = 'Preço de Venda Tab 4';
          cDesMARBR5 = '% Margem/Markup Tab 5';
          cDesCOMTB5 = '% Comissão Tab 5';
          cDesPREVE5 = 'Preço de Venda Tab 5';
          cDesMARBR6 = '% Margem/Markup Tab 6';
          cDesCOMTB6 = '% Comissão TAB 6';
          cDesPREVE6 = 'Preço de Venda Tab 6';
          cDesMARBR7 = '% Margem/Markup Tab 7';
          cDesCOMTB7 = '% Comissão Tab 7';
          cDesPREVE7 = 'Preço de Venda Tab 7';
          cDesCOMVAR = '% Comissão Vendedor Interno Loja';
          cDesCOMATA = '% Comissão Vendedor Externo Loja';
          cDesCOMDIS = '% Comissão Vendedor Externo Distribuidor';
          cDesCOMPRO = '% Comissão Profissional';
          cDesDESMAX = '% Desconto Máximo Vendedor';
          cDesDESMSU = '% Desconto Máximo Sub-Gerente';
          cDesDESMGE = '% Desconto Máximo Gerente';
          cDesMARMIN = '% Margem Minima Vendedor';
          cDesMARMSG = '% Margem Minima Sub-Gerente';
          cDesMARMGE = '% Margem Minima Gerente';
          cDesTMPGAR = 'Tempo de Garantia(Meses)';
          cDesINFGAR = 'Informações Garantia Produto';
          cDesLOCFIS = 'Localização Fisica';
          cDesLOCSUP = 'Localização Super Estoque';
          cDesITEBAS = 'Produto Base';
          cDesITEPIG = 'Item Pigmento';
          cDesBAREXP = 'Obrigatório Cód. Barras Expedicao';
          cDesCPRCEN = 'Compra Centralizada';
          cDesCODMON = 'Cód de montadora';
          cDesNIVGIR = 'Nivel de Giro por Empresa';
          cDesPESLIQ = 'Peso Líquido';
          cDesCODLSE = 'Local de Separação';
          cDesDIAFOR = 'Dias para Entrega do Fornecedor';
          //Dados E-Commerce
          cDesEXPSIT = 'Exportação para E-Commerce';
          cDesDSSITE = 'Descrição do Produto (E-Commerce)';
          cDesDADTEC = 'Dados Técnicos (E-Commerce)';
          cDesURLIMG = 'URL da imagem (E-Commerce)';
          cDesNOMITE = 'Nome do Produto (E-Commerce)';
          cDesAPLITE = 'Aplicação (E-Commerce)';
          cDesINCLUS = 'Itens Inclusos (E-Commerce)';
          cDesEXPALT = 'Altura (E-Commerce)';
          cDesEXPLAR = 'Largura (E-Commerce)';
          cDesEXPPRO = 'Profundidade (E-Commerce)';
          cDesDESSIT = 'Desconto para Site (E-Commerce)';
          cDesCODCAT = 'Categorias (E-Commerce)';
          cDesDESTAQ = 'Destaque (E-Commerce)';
          cDesATZPRE = 'Atualiza preços no site? (E-Commerce)';
          cDesEXPAPP = 'Exportação APP Venda Assistida (E-Commerce)';

          cDesITEFOR_CODFOR = 'Lista de Fornecedores';
          cDesITEFOR_CODITF = 'Lista De Código de Fábrica';
          cDesITEFOR_CODCNA = 'Lista de Código CNA';

          cDesESTMIN = 'Estoque Mínimo';
          cDesESTMAX = 'Estoque Máximo';

          cDesTCIFCU = 'TCIF (+)';
          cDesTSCUST = 'TS (+)';
          cDesDEPICO = 'Desconto de PIS/COFINS (-)';
          cDesDEICMS = 'Desconto ICMS (-)';
          cDesFATREG = 'Fator Regional (+)';
          cDesEMBALA = 'Embalagens';

          cDesUNITRI = 'Unidade Tributação';
          cDesEXPPOK = 'Exporta Tablet';
          cDesTIPPRO = 'Tipo de produto';
          cDesINDREV = 'Industrialização ou Revenda';
          cDesIMPDIR = 'Importação Direta';

          cDesMsgLv1 = 'Mensagem Livre 1';
          cDesMsgLv2 = 'Mensagem Livre 2';
          cDesPEEFUT = 'Permitir Entrega Futura com Status "Aguardando o Cliente"';
          cDesPEFUTP = 'Permitir Entrega Futura com Status "Previsão de Entrega"';
          cDesPEFFPR = 'Permitir Entrega Futura com Status "Falta de Produto"';
          cDesESMIDG_LISTA = 'Lista de Opção para estoque mínimo';
          cDesESTMIN_LISTA = 'Lista de estoque mínimo';
          cDesESTMAX_LISTA = 'Lista de estoque maximo';
          cDesSITPRO_LISTA = 'Lista de Situação do Produto';
          cDesDESSIM = 'Descrição do Produto';

          cDesTIPFRE = 'Tipo de Frete';  // Tipo de Frete
          cDesVLCFRE = 'Valor de Frete';  // Valor de Frete
          cDesQRCODE = 'URL para Qrcode - Etiqueta de Produtos';
          cDesEXPB2B = 'Exportar para B2B';
          cDesPRAVAL = 'Prazo de Vaidade (Meses)';
          cDesNVLCRI = 'Nivel de Criticidade';

          cDesABVFIS_LISTA  = 'Lista de Abreviação Fiscal';
          cDesABVFIS_PIS    = 'Lista de Abreviação Fiscal PIS';
          cDesABVFIS_COFINS = 'Lista de Abreviação Fiscal COFINS';
          cDesRECDEV = 'Permitir receber devolução deste produto';
          cDesVALOBR = 'Validade Obrigatória';
          cDesCOMPOS = 'Composição';
          cDesSAC    = 'SAC';
          cDesPAISOR = 'País de Origem';
          cDesCODATC = 'Assistência técnica';
          cDESMARGE1 = 'Margem Ideal 1';
          cDESMARGE2 = 'Margem Ideal 2';
          cDESMARGE3 = 'Margem Ideal 3';
          cDESMARGE4 = 'Margem Ideal 4';
          cDESMARGE5 = 'Margem Ideal 5';
          cDESMARGE6 = 'Margem Ideal 6';
          cDESMARGE7 = 'Margem Ideal 7';
          cDESSOBENC = 'Sob encomenda?';
          cDESMLTRCA = 'Múltiplo na rotina Citel Abastece';

          cDesQTDPES = 'Qtde mín. estoque para ponta de estoque';
          cDesPORPES = '% de desconto aplicado para ponta de estoque';

          cDesPER_CI = 'Percentual (CI)';
          cDesNUMFCI = 'Número da Ficha (FCI)';

          cDesFATUTR = 'Fator Conversão (Unid. Trib)';
          cDesPRAPEL = 'Desconto Referente Rapel';
          cDesITEEMB = 'Desconto Embalagem Fechada';
          cDesCEREPI = 'Certificado de Aprovação EPI';
          cDesMARPAD = 'Margem Padrão';
          cDesTPESTM_LISTA = 'Tipo Estoque Mínimo';

     function fTemCodBarDuplicado(strCodBar, strCodIte: String; Var strDuplicados: String): Boolean;
     function fTemCodFabDuplicado(strCodFab, strCodFor, strCodIte: String; Var strDuplicados: String): Boolean;

     Procedure pGetCodigos(Var strCodIte, strCodBar, strCodFor, strCodFab, strIteAti, strDesIte: String; intLinha: Integer);
     Procedure pPreparaValidador;
     procedure pAtualizaInfoValidador;
     function fProcessaValorDefault(cCampo, strValor: String): String;

     function fValidaIteFor(strValores :array of Variant; inLinhaAtual: integer; var strMensagem: string): boolean;
     function fValidaEmbalagem(objValores : TCampoEmbalagem; inLinhaAtual: Integer; var strMensagem: string): boolean;
     function fValidaDescontoEmbalagem(objValores : TCampoIteEmbalagem; inLinhaAtual: Integer; var strMensagem: string): boolean;
     function fTemCodBarDuplicadoPlanilha(strCodBar: String): Boolean;
     procedure pPopulaCDS;
     function fCampoAltera(strColuna: String; blnForcaPesquisa: Boolean = False; strCampo: String = ''): Boolean;
     function fValidaTipoProdutoSped(strValor: String; inLinhaAtual: integer; var strMensagem: string): boolean;
     function fDefineAliasIndRev: String;
     function fDefineAliasImpDir: String;
     function fValidaTipoCampo(const Str: string): Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

  var
  frmImportCadProduto: TfrmImportCadProduto;

implementation

{$R *.dfm}

uses untTConfiguracao, untImportTabPrecosItegerConfirma, untImportComisVendTabPrecoConfirma,
  untIcmsSTParteVenda, untImportCadProdutoCamposAtualiza, untConstantes,
  untController.CheckListGarantia;

{ TfrmImportCadProduto }

procedure TfrmImportCadProduto.pPreparaValidador;
const CompletaComZeros = true;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODITE, cCODITE, fTamCodIte, True, False, '', '', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODFOR, cCODFOR, 8, True, False, 'CADFOR', 'FOR_CODFOR', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODDEP, cCODDEP, 3, True, False, 'CADDEP', 'DEP_CODIGO', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODGRU, cCODGRU, 6, True, False, 'CADGRU', 'GRU_CODGRU', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODMAR, cCODMAR, 6, True, False, 'CADMAR', 'MAR_CODMAR', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODUNI, cCODUNI, 2, True, False, 'CADUNI', 'UNI_CODUNI', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesUNICOM, cUNICOM, 2, True, False, 'CADUNI', 'UNI_CODUNI', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODABF, cCODABF, IIf(fCfgSis('USASAN') = 'S', 7, 3), True, False, 'ABFICM', 'ABF_CODABF', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesABFPIS, cABFPIS, 3, True, False, 'PISSAI', 'APC_CODAPC', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesABFCOF, cABFCOF, 3, True, False, 'COFSAI', 'APC_CODAPC', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesABFIPI, cABFIPI, 3, True, False, 'IPISAI', 'APC_CODAPC', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCDCEST, cCDCEST, 7, False, False,'CDCEST', 'CES_CDCEST', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODONU, cCODONU, 3, True, False, 'CADONU', 'ONU_CODONU', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesIMPLIS, cIMPLIS, 1, True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesITEATI, cITEATI, 1, True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesATICOM, cATICOM, 1, True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPESOIT, cPESOIT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODGPR, cCODGPR, 6, True, False, 'CADGPR', 'GPR_CODIGO', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesPRDGRU, cPRDGRU, 5, True, False, 'GRPPRD', 'PRD_CODGRU', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesGRUCMP, cGRUCMP, 3, True, False, 'GRU_COMPRA', 'GRU_CODIGO', CompletaComZeros));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMLTVEN, cMLTVEN));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMLTCOM, cMLTCOM));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcGirNiv, cDesNVLGIR, cNVLGIR, 1, True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcGirNiv, cDesNIVGIR, cNIVGIR, 1, True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcNIVCRI, cDesNVLCRI, cNVLCRI, 1, True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesACOOBJ, cACOOBJ, 20, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPRECOM, cPRECOM));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESF01, cDESF01));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESF02, cDESF02));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESF03, cDESF03));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESF04, cDESF04));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESF05, cDESF05));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESF06, cDESF06));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesICMENT, cICMENT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesSUBFED, cSUBFED));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesIPIENT, cIPIENT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesFREENT, cFREENT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(strDesValFre, cVALFRE));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesACRFIN, cACRFIN));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesSUBSTI, cSUBSTI));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESADB, cDESADB));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesOUTVAL, cOUTVAL));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesICMSAI, cICMSAI));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesIMPFED, cIMPFED));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESOPE, cDESOPE));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR1, cMARBR1));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB1, cCOMTB1));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE1, cPREVE1));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR2, cMARBR2));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB2, cCOMTB2));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE2, cPREVE2));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR3, cMARBR3));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB3, cCOMTB3));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE3, cPREVE3));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR4, cMARBR4));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB4, cCOMTB4));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE4, cPREVE4));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR5, cMARBR5));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB5, cCOMTB5));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE5, cPREVE5));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR6, cMARBR6));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB6, cCOMTB6));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE6, cPREVE6));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARBR7, cMARBR7));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMTB7, cCOMTB7));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPREVE7, cPREVE7));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMVAR, cCOMVAR));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMATA, cCOMATA));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMDIS, cCOMDIS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesCOMPRO, cCOMPRO));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESMAX, cDESMAX));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESMSU, cDESMSU));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDESMGE, cDESMGE));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARMIN, cMARMIN));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARMSG, cMARMSG));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARMGE, cMARMGE));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt  (cDesTMPGAR, cTMPGAR));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesINFGAR, cINFGAR, 50, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesLOCFIS, cLOCFIS, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesLOCSUP, cLOCSUP, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesITEBAS, cITEBAS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesITEPIG, cITEPIG));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesBAREXP, cBAREXP));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesCPRCEN, cCPRCEN));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoListaCodigo(cDesCODMON, cCODMON, False, 'CADMON', 'MON_CODMON', ','));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPESLIQ, cPESLIQ));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODLSE, cCODLSE, fTamCodLse, False, False, 'CADLSE', 'LSE_CODIGO'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesDIAFOR, cDIAFOR));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesEXPSIT, cEXPSIT,   1, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDSSITE, cDSSITE, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDADTEC, cDADTEC, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesURLIMG, cURLIMG, 255, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNOMITE, cNOMITE, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesAPLITE, cAPLITE, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesINCLUS, cINCLUS, 0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat (cDesEXPALT, cEXPALT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat (cDesEXPLAR, cEXPLAR));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat (cDesEXPPRO, cEXPPRO));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat (cDesDESSIT, cDESSIT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODCAT, cCODCAT, 255, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDESTAQ, cDESTAQ,   1, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesATZPRE, cATZPRE,   1, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesEXPAPP, cEXPAPP,   1, False, False, '', ''));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoListaCodigo(cDesITEFOR_CODFOR, cITEFOR_CODFOR, False, 'CADFOR', 'FOR_CODFOR', ','));

  // a ordem das colunas é a mesma ordem de valores que sera devolvida  na fValidaIteFor
  objValidaExcel.pAddCampo(objValidaExcel.fMontaValidacaoLista('Fornecedores', VarArrayOf([cITEFOR_CODFOR, cITEFOR_CODITF, cITEFOR_CODCNA]), VarArrayOf([cITEFOR_CODCNA]),fValidaIteFor));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesESTMIN, cESTMIN));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesESTMAX, cESTMAX));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesTCIFCU, cTCIFCU));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesTSCUST, cTSCUST));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDEPICO, cDEPICO));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesDEICMS, cDEICMS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesFATREG, cFATREG));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaValidacaoCampoEmbalagem(cDesEMBALA, cEMBALA, fValidaEmbalagem));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaValidacaoCampoDescontoEmbalagem(cDesITEEMB, cITEEMB, fValidaDescontoEmbalagem));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesUNITRI, cUNITRI, 2, True, False, 'CADUNI', 'UNI_CODUNI'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesEXPPOK, cEXPPOK));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaValidacaoCampoTipoProdutoSped(cDesTIPPRO, cTIPPRO, fValidaTipoProdutoSped));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_IR, cDesINDREV, cINDREV));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesIMPDIR, cIMPDIR));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesPEEFUT, cPEEFUT));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesPEFUTP, cPEFUTP));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesPEFFPR, cPEFFPR));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesESMIDG_LISTA, cESMIDG_LISTA, 0, False, False, fValidaListaOpcEstoqueMinimo));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesSITPRO_LISTA, cSITPRO_LISTA, 0, False, False, fValidaListaSituacaoProduto));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesABVFIS_LISTA, cABVFIS_LISTA, 0, False, False, fValidaListaAbreviacaoFiscal));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesABVFIS_PIS, cABFPIS_LISTA, 0, False, False, fValidaListaAbreviacaoFiscal));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesABVFIS_COFINS, cABFCOF_LISTA, 0, False, False, fValidaListaAbreviacaoFiscal));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesTIPFRE, cTIPFRE, 1, True, False, fValidarTipoFrete));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesVLCFRE, cVLCFRE));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesQRCODE, cQRCODE ,   0, False, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesEXPB2B, cEXPB2B));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt  (cDesPRAVAL, cPRAVAL));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesRECDEV, cRECDEV));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDesVALOBR, cVALOBR));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCOMPOS, cCOMPOS, 0, True, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesSAC, cITESAC, 0, True, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesPAISOR, cPAISOR, 0, True, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODATC, cCODATC, 5, True, False, 'CADATC','ATC_CODIGO', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE1, cMARGE1));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE2, cMARGE2));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE3, cMARGE3));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE4, cMARGE4));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE5, cMARGE5));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE6, cMARGE6));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESMARGE7, cMARGE7));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcChar_SN, cDESSOBENC, cSOBENC, 1, True));

  if fCfgSis('UTPEST', varBoolean) then
  begin
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESQTDPES, cQTDPES));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDESPORPES, cPORPES));
  end;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcMltRca, cDESMLTRCA, cMLTRCA, 1, True));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampo(tcPercen, cDesPER_CI, cPER_CI, 0, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesNUMFCI, cNUMFCI, 50, False, False, '', ''));

  if fCfgSis('UNITRI', varBoolean) then
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesFATUTR, cFATUTR));

  If blnURapel Then
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPRAPEL, cPRAPEL));


   objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCEREPI, cCEREPI, 0, False, False, '', ''));

  if fCfgSis('MARPAD', varBoolean) then
   objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesMARPAD, cMARPAD));

  if fCfgSis('MINPRO', varBoolean) then
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesTPESTM_LISTA, cTPESTM_LISTA, 0, False, False, fValidarEstoqueMinimo));

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDESITE, cDESITE, 0, False, False, ValidarCaractereInvalido));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDESSIM, cDESSIM, 0, False, False, ValidarCaractereInvalido));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesREFERE, cREFERE, 0, False, False, ValidarCaractereInvalido));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODFAB, cCODFAB, 0, False, False, ValidarCaractereInvalido));
End;

procedure TfrmImportCadProduto.pValidaEstoqueMAximoEMinimo(var strErro: String);
begin
  strErro := '';
  While not cdsESTMIN_ESTMAX.Eof Do
  Begin
     If IIf(cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN').AsString = '',
            cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN_OLD').AsFloat,
            cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN').AsFloat) > IIf(cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX').AsString = '',
                                                                   cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX_OLD').AsFloat,
                                                                   cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX').AsFloat) Then
     Begin
       If Not fEmptyStr(strErro) Then
         strErro := strErro + #$A#$D;
       strErro := strErro + ' ' + cdsESTMIN_ESTMAX.FieldByName('ITE_CODEMP').AsString +
                                                  'Estoque Mínimo [' + IIf(cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN').AsString = '',
                                                                           cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN_OLD').AsString,
                                                                           cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN').AsString) + '] não pode ser maior que o ' +
                                                  'Estoque Máximo [' + IIf(cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX').AsString = '',
                                                                           cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX_OLD').AsString,
                                                                           cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX').AsString) + ']';
     End;

     cdsESTMIN_ESTMAX.Next;
  End;

end;

function TfrmImportCadProduto.ValidarCaractereInvalido(strColuna, strTabela,
  strCampo, strValor: string; var strMensagem: String): boolean;
begin
  Result := True;

  If strValor <> '' Then
  Begin
    strValor := trim(strValor);

    If (Pos('|', strValor) > 0) Then
    Begin
      Result := False;
      strMensagem := 'Caractere inválido "|" encontrado na coluna ' + strColuna + '.';
    End;
  End;
end;

function TfrmImportCadProduto.fValidaIteFor(strValores: array of Variant; inLinhaAtual: Integer; var strMensagem: string): boolean;
Begin
  Result := fValidaCodForFabItem(strValores[0], strValores[1], objValidaExcel.fGetValueCSV(inLinhaAtual, cCODITE), False, strMensagem);
  If not Result Then
    strMensagem := 'Código de Fornecedor ' + strValores[0] + ' + Fábrica ' + strValores[1] + ' já cadastrados no Item ' + strMensagem;

End;

function TfrmImportCadProduto.fValidaListaOpcEstoqueMinimo(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
var i, x: integer;
    strCodEmp,
    strValorLista: String;
begin
  Result := True;
  x  := Pos('=', strValor);
  If x > 0 Then
  Begin
    lst.Text := '';
    lst.StrictDelimiter := True;
    lst.Delimiter := '|';
    lst.DelimitedText := strValor;

    For i := 0 To lst.Count -1 do
    Begin
      strCodEmp := copy(lst[i], 0, x -1);
      strValorLista := copy(lst[i], x + 1, Length(lst[i]));
      Result := (Pos(strValorLista,'DG') > 0);
      If Not Result Then
      Begin
        strMensagem := 'O Valor Atribuido as Empresas deve ser "D" ou "G"';
        Break;
      End;
    End;
  End
  Else
  If strValor <> '' Then
  Begin
    strValor := trim(strValor);
    Result := (Pos(strValor,'DG') > 0);
    If Not Result Then
      strMensagem := 'O Valor deve ser "D" ou "G"'
  End;

end;

function TfrmImportCadProduto.fValidarTipoFrete(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
Begin
  Result := False;
  If Not fEmptyStr(strValor) then
  Begin
    Result := Pos(strValor,'PFU') > 0;
    If (Not Result) Then
      strMensagem := 'O valor do tipo de frete é diferente de "(P, F, U)".';
  End;
End;

function TfrmImportCadProduto.fValidarEstoqueMinimo(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
var i, x: integer;
    strCodEmp,
    strValorLista: String;

Begin
  Result := True;
  x  := Pos('=', strValor);
  If x > 0 Then
  Begin
    lst.Text := '';
    lst.StrictDelimiter := True;
    lst.Delimiter := '|';
    lst.DelimitedText := strValor;

    For i := 0 To lst.Count -1 do
    Begin
      strCodEmp := copy(lst[i], 0 , x -1);
      strValorLista := copy(lst[i], x + 1, Length(lst[i]));
      Result := Pos(strValorLista,'DNS') > 0;
      If (Not Result) Then
        strMensagem := 'Na Empresa ' + strCodEmp + ' o tipo de Estoque Mínimo é diferente de "(D, N, S)".';
    End;
  End
  Else
  If strValor <> '' Then
  Begin
    If Not fEmptyStr(strValor) then
    Begin
      Result := Pos(strValor,'DNS') > 0;
      If (Not Result) Then
        strMensagem := 'O tipo de Estoque Mínimo é diferente de "(D, N, S)".';
    End;
  End;
End;

function TfrmImportCadProduto.fValidaListaAbreviacaoFiscal(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
var
  i, x, intig: integer;
  strCodEmp,
  strValorLista, abrFiscal: String;
begin
  Result := True;
  abrFiscal := '';
  x  := Pos('=', strValor);
  If x > 0 Then
  Begin
    lst.Text := '';
    lst.StrictDelimiter := True;
    lst.Delimiter := '|';
    lst.DelimitedText := strValor;

    For i := 0 To lst.Count -1 do
    Begin
      intig := Pos('=', lst[i]);
      strCodEmp := Trim(copy(lst[i], 0 , intig -1));
      strValorLista := Trim(copy(lst[i], intig + 1, Length(lst[i])));

      qryConsulta.sql.Clear;
      qryConsulta.SQL.Add('SELECT AUTOINCREM FROM ');

      if strColuna = 'EO' then
        qryConsulta.SQL.Add('ABFICM WHERE ABF_CODABF = :valor');

      if strColuna = 'FQ' then
      begin
        qryConsulta.SQL.Add('PISSAI WHERE APC_CODAPC = :valor');
        abrFiscal := '"PIS"';
      end;

      if strColuna = 'FR' then
      begin
        qryConsulta.SQL.Add('COFSAI WHERE APC_CODAPC = :valor');
        abrFiscal := '"COFINS"';
      end;

      qryConsulta.ParamByName('valor').AsString := strValorLista;
      qryConsulta.Open;
      If qryConsulta.IsEmpty Then
      Begin
        Result := False;

        strMensagem := Format(
          'Não foi encontrada nenhuma abreviação fiscal %s com o código "%s" no cadastro de abreviações fiscais'
          , [abrFiscal,strValorLista]);
        Break;
      End;

      qryConsulta.sql.Clear;
      qryConsulta.SQL.Text := 'SELECT AUTOINCREM FROM CADEMP WHERE EMP_CODEMP = "' + strCodEmp + '"';
      qryConsulta.Open;
      If qryConsulta.IsEmpty Then
      Begin
        Result := False;
        strMensagem := 'Não foi encontrada nenhuma empresa com o código "' + strCodEmp + '" no cadastro de empresas';
        Break;
      End;
    End;
  End;
End;


function TfrmImportCadProduto.fValidaListaSituacaoProduto(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
var i, x: integer;
    strCodEmp,
    strValorLista: String;
begin
  Result := True;
  x  := Pos('=', strValor);
  If x > 0 Then
  Begin
    lst.Text := '';
    lst.StrictDelimiter := True;
    lst.Delimiter := '|';
    lst.DelimitedText := strValor;

    For i := 0 To lst.Count -1 do
    Begin
      strCodEmp := copy(lst[i], 0 , x -1);
      strValorLista := copy(lst[i], x + 1, Length(lst[i]));
      qryConsulta.sql.Clear;
      qryConsulta.SQL.Text := 'SELECT COUNT(1) QTD FROM SITPRO WHERE SIT_CODIGO = "' + strValorLista + '"';
      qryConsulta.Open;
      If qryConsulta.FieldByName('QTD').AsInteger  = 0  Then
      Begin
        Result := False;
        strMensagem := 'Não foi encontrado ' + strValorLista + ' no cadastro de Situação do produto';
        Break;
      End;
    End;
  End
  Else
  If strValor <> '' Then
  Begin
    strValor := trim(strValor);
    qryConsulta.sql.Clear;
    qryConsulta.SQL.Text := 'SELECT COUNT(1) QTD FROM SITPRO WHERE SIT_CODIGO = "' + strValor + '"';
    qryConsulta.Open;
    If qryConsulta.FieldByName('QTD').AsInteger  = 0 Then
    Begin
      Result := False;
      strMensagem := 'Não foi encontrado ' + strValor + ' no cadastro de Situação do produto';
    End;
  End;
End;


function TfrmImportCadProduto.fValidaEmbalagem(objValores : TCampoEmbalagem; inLinhaAtual: Integer; var strMensagem: string): boolean;
  var
    strDuplicados: String;
begin
  Result := True;
  If Not fEmptyStr(objValores.strCodFor) Then
    result := fRetNomFornecedor(objValores.strCodFor) <> '' ;

  If Not Result Then
    strMensagem := 'Código de Fornecedor ' + objValores.strCodFor + ' não esta cadastrado'
  Else
  Begin
    Result := False;
    If fTemCodBarDuplicado(objValores.strCodBar, objValidaExcel.fGetValueCSV(inLinhaAtual, cCODITE), strDuplicados) Then
      strMensagem := ' Item ' + strDuplicados + ' já possui o mesmo Código de Barras (' + objValores.strCodBar+ ').'
    Else
      Result := True
  End;
end;

function TfrmImportCadProduto.fValidaDescontoEmbalagem(objValores : TCampoIteEmbalagem; inLinhaAtual: Integer; var strMensagem: string): boolean;
  var fltValor : Double;
      cdsIteEmb : TZClient;
begin
  Result := True;

  If objValores.strITB_TABPRE <> 'TODAS' Then
  Begin
    If (Not TryStrToFloat(objValores.strITB_TABPRE,fltValor)) or (fltValor > 7) Then
    Begin
      strMensagem := 'Tabela de Preço ' + objValores.strITB_TABPRE + ' não está cadastrada';
      result := False;
    End;
  End;

  If Not TryStrToFloat(objValores.strITB_QTDEMB,fltValor ) Then
  Begin
    strMensagem := 'Valor '+ objValores.strITB_QTDEMB +' para o campo Quantidade não é um tipo númerico válido.';
    result := False;
  End
  Else If Not TryStrToFloat(objValores.strITB_DESCON,fltValor ) Then
  Begin
    strMensagem := 'Valor '+ objValores.strITB_DESCON +' para o campo Desconto não é um tipo númerico válido.';
    result := False;
  End;

  Try
    cdsIteEmb := TZClient.Create(Self, fGetSQLIteEmb);

    cdsIteEmb.qryQuery.Close;
    cdsIteEmb.qryQuery.ParamByName('CODITE').AsString := objValidaExcel.fGetValueCSV(inLinhaAtual, cCODITE);
    cdsIteEmb.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

    cdsIteEmb.fAbreClient(True, 'TfrmCadProdutos.pAbreIteEmb');


    If (Not cdsIteEmb.Locate('ITB_QTDEMB;ITB_TABPRE', VarArrayOf([objValores.strITB_QTDEMB, objValores.strITB_TABPRE]), [])) Then
    Begin
      if cdsIteEmb.Locate('ITB_QTDEMB',  objValores.strITB_QTDEMB, []) and (cdsIteEmb.FieldByName('ITB_TABPRE').AsString = '')  then
      begin
        strMensagem := 'Não é possível adicionar essa quantidade, pois a mesma já foi adicionada em "TODAS" as tabelas!';
        result := False;
      end;

    End
    Else
    Begin
      If (Not cdsIteEmb.Locate('ITB_QTDEMB;ITB_TABPRE', VarArrayOf([objValores.strITB_QTDEMB, '']), [])) Then
      Begin
        if cdsIteEmb.Locate('ITB_QTDEMB', objValores.strITB_QTDEMB, []) then
        begin
          strMensagem := 'Não é possível adicionar essa quantidade em "TODAS" as tabelas, pois a mesma já foi adicionada em tabela específica!';
          result := False;
        end
      End;
    End;
  Finally
    FreeAndNil(cdsIteEmb);
  End;

end;

function TfrmImportCadProduto.fGetSQLIteEmb : String;
Begin
  Result := '';
  Result := Result + ' SELECT AUTOINCREM,                               ';
  Result := Result + '        ITB_CODITE,                               ';
  Result := Result + '        ITB_CODEMP,                               ';
  Result := Result + '        ITB_QTDEMB,                               ';
  Result := Result + '        ITB_DESCON,                               ';
  Result := Result + '        ITB_TABPRE,                               ';
  Result := Result + '        ITB_PRIROM,                               ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN1, ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN2, ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN3, ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN4, ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN5, ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN6, ';
  Result := Result + '        CAST("0" AS DECIMAL(12,4)) AS ITB_PRCUN7  ';
  Result := Result + ' FROM ITEEMB                                      ';
  Result := Result + ' WHERE ITB_CODITE = :CODITE                       ';
  Result := Result + '   AND ITB_CODEMP = :CODEMP                       ';
  Result := Result + ' ORDER BY ITB_QTDEMB DESC                         ';
End;

function TfrmImportCadProduto.fAlterou(cdsItens: TZClient; strField: String; blnArredonda: Boolean = False; intPrecisao: integer = -1): Boolean;
  var blnValOri,
    blnValNov: Double;
begin
  If  cdsItens.FieldByName(strField + '_NOV').IsNull Then
    Exit(False)
  Else
  Begin
    If blnArredonda Then
       blnValOri := fStrToFloat(FormatFloat(fMskDigitos(intDecUni) , cdsItens.FieldByName(strField).AsFloat))
     Else
       blnValOri := cdsItens.FieldByName(strField).AsFloat;
     blnValNov :=  cdsItens.FieldByName(strField + '_NOV').AsFloat;
     Result :=  blnValNov <> blnValOri;
  End;
End;

function TfrmImportCadProduto.fAlterouPreco(cdsItens: TZClient): boolean;
var
  i: integer;
begin
  Result := False;
  If (fAlterou(cdsItens, 'ITE_PRECOM'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF01'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF02'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF03'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF04'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF05'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF06'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_ICMENT'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_SUBFED'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_IPIENT'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_FREENT'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_ACRFIN'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_SUBSTI'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESADB'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_VALFRE'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_PRECUS'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_OUTVAL'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_ICMSAI'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESOPE'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_IMPFED'))Then
    Exit(True);
  If (fAlterou(cdsItens, 'ITE_DESF06')) Then
      Exit(True);
  If (fAlterou(cdsItens, 'ITE_TCIFCU'))Then
      Exit(True);
  If (fAlterou(cdsItens, 'ITE_TSCUST'))Then
      Exit(True);
  If (fAlterou(cdsItens, 'ITE_DEPICO'))Then
      Exit(True);
  If (fAlterou(cdsItens, 'ITE_DEICMS'))Then
      Exit(True);
  If (fAlterou(cdsItens, 'ITE_FATREG'))Then
      Exit(True);

  For i := 1 To 7 do
  Begin
    If (fAlterou(cdsItens, 'ITE_COMTB' +  IntToStr(i)))Then
      Exit(True);
  End;

  For i := 1 To 7 do
  Begin
    If (fAlterou(cdsItens, 'ITE_PREVE' +  IntToStr(i), True, intDecUni))Then
      Exit(True);
  End;

  For i := 1 To 7 do
  Begin
    If (fAlterou(cdsItens, 'ITE_MARBR' +  IntToStr(i), True, fRetPrecisaoMargemItem))Then
      Exit(True);
  End;
end;

function TfrmImportCadProduto.fCampoAltera(strColuna: String; blnForcaPesquisa: Boolean = False; strCampo: String = ''): Boolean;
begin
  Result := True;

  If (cdsItens.FieldByName('IMPORT').AsInteger = 0) And (Not blnForcaPesquisa) Then
    Exit;

  cdsCampos.First;

  If cdsCampos.Locate('COLUNA', strColuna, []) Then
    Result := cdsCamposMARDES.AsString = 'S';

  If Result And (not FEmptyStr(strCampo)) Then
    Result := GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_'+Copy(strCampo, 2, Length(strCampo)));
end;

procedure TfrmImportCadProduto.pPopulaCDS;
  procedure pAddCampo(cdsCampo: TUniClientDataSet; StrDescricao: String; StrCOLUNA: String);
  begin
    cdsCampo.Append;
    cdsCampo.FieldByName('DESCRI').AsString := StrDescricao;
    cdsCampo.FieldByName('COLUNA').AsString := StrCOLUNA;

    if (StrDescricao = cDesABVFIS_PIS) or (StrDescricao = cDesABVFIS_COFINS) then
      cdsCampo.FieldByName('MARDES').AsString := 'N'
    else
      cdsCampo.FieldByName('MARDES').AsString := 'S';
    cdsCampo.FieldByName('INDEX').AsInteger := TValidadorExcel.fRetValorNumericoColuna(strColuna);
    cdsCampo.Post;
  end;
Begin


  pAddCampo(cdsCampos, cDesCODBAR, cCODBAR);
  pAddCampo(cdsCampos, cDesCODFAB, cCODFAB);
  pAddCampo(cdsCampos, cDesCODFOR, cCODFOR);
  pAddCampo(cdsCampos, cDesCODDEP, cCODDEP); // COD.DEPARTAMENTO;
  pAddCampo(cdsCampos, cDesCODGRU, cCODGRU); // COD.LINHA/GRUPO;
  pAddCampo(cdsCampos, cDesDESITE, cDESITE); // DESCRICAO DO PRODUTO
  pAddCampo(cdsCampos, cDesDESSIM, cDESSIM); // DESCRICAO DO PRODUTO
  pAddCampo(cdsCampos, cDesDESFAB, cDESFAB); // DESCRICAO DO FABRICANTE
  pAddCampo(cdsCampos, cDesCODMAR, cCODMAR); // COD.MARCA;
  pAddCampo(cdsCampos, cDesEMBALA, cEMBALA); // EMBALA;
  pAddCampo(cdsCampos, cDesITEEMB, cITEEMB); // DESCONTO EMBALAGEM FECHADA;
  pAddCampo(cdsCampos, cDesREFERE, cREFERE); // REFERENCIA
  pAddCampo(cdsCampos, cDesCODUNI, cCODUNI); // COD.UNIDADE DE VENDA;
  pAddCampo(cdsCampos, cDesUNICOM, cUNICOM); // COD.UNIDADE DE COMPRA;
  pAddCampo(cdsCampos, cDesCODABF, cCODABF); // COD.ABREVIACAO ICMS;
  pAddCampo(cdsCampos, cDesABFPIS, cABFPIS); // COD.ABREVIACAO PIS;
  pAddCampo(cdsCampos, cDesABFCOF, cABFCOF); // COD.ABREVIACAO COFINS;
  pAddCampo(cdsCampos, cDesABFIPI, cABFIPI); // COD.ABREVIACAO IPI;
  pAddCampo(cdsCampos, cDesIPISAI, cIPISAI); // % IPI DE SAIDA
  pAddCampo(cdsCampos, cDesINCPIS, cINCPIS); // INCIDE PIS/COFINS ( S/N )
  pAddCampo(cdsCampos, cDesCLAIPI, cCLAIPI); // NCM
  pAddCampo(cdsCampos, cDesEXCIPI, cEXCIPI); // COD.EX NCM;
  pAddCampo(cdsCampos, cDesCDCEST, cCDCEST); // COD.CLASSIFICACAO CEST;
  pAddCampo(cdsCampos, cDesCODONU, cCODONU); // COD.CLASSIFICACAO ONU;
  pAddCampo(cdsCampos, cDesIMPLIS, cIMPLIS); // IMPRIME LISTA ( S/N )
  pAddCampo(cdsCampos, cDesITEATI, cITEATI); // PRODUTO ATIVO ( S/N )
  pAddCampo(cdsCampos, cDesATICOM, cATICOM); // ATIVO PARA COMPRAS ( S/N )
  pAddCampo(cdsCampos, cDesPESOIT, cPESOIT); // PESO BRUTO
  pAddCampo(cdsCampos, cDesCODGPR, cCODGPR); // COD.GRUPO DE PREÇOS;
  pAddCampo(cdsCampos, cDesPRDGRU, cPRDGRU); // COD.GRUPO DE PRODUTOS;
  pAddCampo(cdsCampos, cDesGRUCMP, cGRUCMP); // COD.GRUPO DE COMPRAS;
  pAddCampo(cdsCampos, cDesMLTVEN, cMLTVEN); // MULTIPLO DE VENDA
  pAddCampo(cdsCampos, cDesMLTCOM, cMLTCOM); // MULTIPLO DE COMPRA
  pAddCampo(cdsCampos, cDesNVLGIR, cNVLGIR); // NIVEL DE GIRO GERAL
  pAddCampo(cdsCampos, cDesACOOBJ, cACOOBJ); // ACORDO DE OBJETIVOS
  pAddCampo(cdsCampos, cDesAPLICA, cAPLICA); // APLICACAO
  pAddCampo(cdsCampos, cDesPRECOM, cPRECOM); // PR.COMPRA;
  pAddCampo(cdsCampos, cDesDESF01, cDESF01); // % DESCONTO FORNECEDOR 1 (-)
  pAddCampo(cdsCampos, cDesDESF02, cDESF02); // % DESCONTO FORNECEDOR 2 (-)
  pAddCampo(cdsCampos, cDesDESF03, cDESF03); // % DESCONTO FORNECEDOR 3 (-)
  pAddCampo(cdsCampos, cDesDESF04, cDESF04); // % DESCONTO FORNECEDOR 4 (-)
  pAddCampo(cdsCampos, cDesDESF05, cDESF05); // % DESCONTO FORNECEDOR 5 (-)
  pAddCampo(cdsCampos, cDesDESF06, cDESF06); // % DESCONTO FORNECEDOR 6 (-)
  pAddCampo(cdsCampos, cDesICMENT, cICMENT); // % ICMS ENTRADA (-)
  pAddCampo(cdsCampos, cDesSUBFED, cSUBFED); // % IMPOSTOS FEDERAIS (-)
  pAddCampo(cdsCampos, cDesIPIENT, cIPIENT); // % IPI ENTRADA (+)
  pAddCampo(cdsCampos, cDesFREENT, cFREENT); // % FRETE (+)
  pAddCampo(cdsCampos, strDesValFre, cVALFRE); // VALOR DE FRETE (+)
  pAddCampo(cdsCampos, cDesACRFIN, cACRFIN); // % ACRESCIMO FINANCEIRO (+)
  pAddCampo(cdsCampos, cDesSUBSTI, cSUBSTI); // % SUB.TRIBUTARIA (+);
  pAddCampo(cdsCampos, fCfgSis('DESADI')+' ('+fCfgSis('OPEADI')+')', cDESADB);// % XXXXXXXXXXXXXXXXXXXXXXXXXXXXX   ( exibir
  pAddCampo(cdsCampos, fCfgSis('DOVCPP')+' (+)', cOUTVAL);                    // % OUTROS VALORES (+)              ( exibir
  pAddCampo(cdsCampos, cDesICMSAI, cICMSAI); // % ICMS SAIDA (+)
  pAddCampo(cdsCampos, cDesIMPFED, cIMPFED); // % IMPOSTOS FEDERAIS (+)
  pAddCampo(cdsCampos, cDesDESOPE, cDESOPE); // % DESPESAS OPERACIONAIS (+)
  pAddCampo(cdsCampos, cDesMARBR1, cMARBR1); // % MARGEM/MARKUP TAB 1
  pAddCampo(cdsCampos, cDesCOMTB1, cCOMTB1); // % COMISSAO TAB 1
  pAddCampo(cdsCampos, cDesPREVE1, cPREVE1); // PREÇO DE VENDA TAB 1
  pAddCampo(cdsCampos, cDesMARBR2, cMARBR2); // % MARGEM/MARKUP TAB 2
  pAddCampo(cdsCampos, cDesCOMTB2, cCOMTB2); // % COMISSAO TAB 2
  pAddCampo(cdsCampos, cDesPREVE2, cPREVE2); // PREÇO DE VENDA TAB 2
  pAddCampo(cdsCampos, cDesMARBR3, cMARBR3); // % MARGEM/MARKUP TAB 3
  pAddCampo(cdsCampos, cDesCOMTB3, cCOMTB3); // % COMISSAO TAB 3
  pAddCampo(cdsCampos, cDesPREVE3, cPREVE3); // PREÇO DE VENDA TAB 3
  pAddCampo(cdsCampos, cDesMARBR4, cMARBR4); // % MARGEM/MARKUP TAB 4
  pAddCampo(cdsCampos, cDesCOMTB4, cCOMTB4); // % COMISSAO TAB 4
  pAddCampo(cdsCampos, cDesPREVE4, cPREVE4); // PREÇO DE VENDA TAB 4
  pAddCampo(cdsCampos, cDesMARBR5, cMARBR5); // % MARGEM/MARKUP TAB 5
  pAddCampo(cdsCampos, cDesCOMTB5, cCOMTB5); // % COMISSAO TAB 5
  pAddCampo(cdsCampos, cDesPREVE5, cPREVE5); // PREÇO DE VENDA TAB 5
  pAddCampo(cdsCampos, cDesMARBR6, cMARBR6); // % MARGEM/MARKUP TAB 6
  pAddCampo(cdsCampos, cDesCOMTB6, cCOMTB6); // % COMISSAO TAB 6
  pAddCampo(cdsCampos, cDesPREVE6, cPREVE6); // PREÇO DE VENDA TAB 6
  pAddCampo(cdsCampos, cDesMARBR7, cMARBR7); // % MARGEM/MARKUP TAB 7
  pAddCampo(cdsCampos, cDesCOMTB7, cCOMTB7); // % COMISSAO TAB 7
  pAddCampo(cdsCampos, cDesPREVE7, cPREVE7); // PREÇO DE VENDA TAB 7
  pAddCampo(cdsCampos, cDesCOMVAR, cCOMVAR); // % COMISSAO VENDEDOR INTERNO LOJA
  pAddCampo(cdsCampos, cDesCOMATA, cCOMATA); // % COMISSAO VENDEDOR EXTERNO LOJA
  pAddCampo(cdsCampos, cDesCOMDIS, cCOMDIS); // % COMISSAO VENDEDOR EXTERNO DISTRIBUIDOR
  pAddCampo(cdsCampos, cDesCOMPRO, cCOMPRO); // % COMISSAO PROFISSIONAL
  pAddCampo(cdsCampos, cDesDESMAX, cDESMAX); // % DESCONTO MAXIMO VENDEDOR
  pAddCampo(cdsCampos, cDesDESMSU, cDESMSU); // % DESCONTO MAXIMO SUB-GERENTE
  pAddCampo(cdsCampos, cDesDESMGE, cDESMGE); // % DESCONTO MAXIMO GERENTE
  pAddCampo(cdsCampos, cDesMARMIN, cMARMIN); // % MARGEM MINIMA VENDEDOR
  pAddCampo(cdsCampos, cDesMARMSG, cMARMSG); // % MARGEM MINIMA SUB-GERENTE
  pAddCampo(cdsCampos, cDesMARMGE, cMARMGE); // % MARGEM MINIMA GERENTE
  pAddCampo(cdsCampos, cDesTMPGAR, cTMPGAR); // TEMPO DE GARANTIA ( MESES )
  pAddCampo(cdsCampos, cDesINFGAR, cINFGAR); // INFORMACOES DA GARANTIA DO PRODUTO
  pAddCampo(cdsCampos, cDesLOCFIS, cLOCFIS); // LOCALIZACAO FISICA
  pAddCampo(cdsCampos, cDesLOCSUP, cLOCSUP); // LOCALIZACAO SUPER ESTOQUE
  pAddCampo(cdsCampos, cDesITEBAS, cITEBAS); // PRODUTO BASE
  pAddCampo(cdsCampos, cDesITEPIG, cITEPIG); // ITEM PIGMENTO
  pAddCampo(cdsCampos, cDesBAREXP, cBAREXP); // OBRIGATORIO CÓDIGO DE BARRAS EXPEDIÇÃO
  pAddCampo(cdsCampos, cDesCPRCEN, cCPRCEN); // COMPRA CENTRALIZADA
  pAddCampo(cdsCampos, cDesCODMON, cCODMON); // Codigo de montadora separado por
  pAddCampo(cdsCampos, cDesNIVGIR, cNIVGIR); // Nivel de Giro por empresa
  pAddCampo(cdsCampos, cDesNVLCRI, cNVLCRI); // Nivel de Criticidade
  pAddCampo(cdsCampos, cDesPESLIQ, cPESLIQ); // Peso Liquído
  pAddCampo(cdsCampos, cDesCODLSE, cCODLSE); // Local de Separação
  pAddCampo(cdsCampos, cDesDIAFOR, cDIAFOR); // Dias Para  Entrega do Fornecedor
  pAddCampo(cdsCampos, cDesEXPSIT, cEXPSIT); // Exportação para E-Commerce
  pAddCampo(cdsCampos, cDesDSSITE, cDSSITE); // Descrição do Produto (E-Commerce)
  pAddCampo(cdsCampos, cDesDADTEC, cDADTEC); // Dados Técnicos (E-Commerce)
  pAddCampo(cdsCampos, cDesURLIMG, cURLIMG); // URL da imagem (E-Commerce)
  pAddCampo(cdsCampos, cDesNOMITE, cNOMITE); // Nome do Produto (E-Commerce)
  pAddCampo(cdsCampos, cDesAPLITE, cAPLITE); // Aplicação (E-Commerce)
  pAddCampo(cdsCampos, cDesINCLUS, cINCLUS); // Itens Inclusos (E-Commerce)
  pAddCampo(cdsCampos, cDesEXPALT, cEXPALT); // Altura (E-Commerce)
  pAddCampo(cdsCampos, cDesEXPLAR, cEXPLAR); // Largura (E-Commerce)
  pAddCampo(cdsCampos, cDesEXPPRO, cEXPPRO); // Profundidade (E-Commerce)
  pAddCampo(cdsCampos, cDesDESSIT, cDESSIT); // Desconto para Site (E-Commerce)
  pAddCampo(cdsCampos, cDesCODCAT, cCODCAT); // Categorias (E-Commerce)
  pAddCampo(cdsCampos, cDesDESTAQ, cDESTAQ); // Destaque (E-Commerce)
  pAddCampo(cdsCampos, cDesATZPRE, cATZPRE); // Atualiza preços no site? (E-Commerce)
  pAddCampo(cdsCampos, cDesEXPAPP, cEXPAPP); // Exportação APP Venda Assistida
  pAddCampo(cdsCampos, cDesITEFOR_CODFOR, cITEFOR_CODFOR); // Aba fornecedor FORNECEDOR
  pAddCampo(cdsCampos, cDesITEFOR_CODITF, cITEFOR_CODITF); // Aba Fornecedor CODFAB Fornecedor
  pAddCampo(cdsCampos, cDesITEFOR_CODCNA, cITEFOR_CODCNA); // Aba Fornecedor CODCNA
  pAddCampo(cdsCampos, cDesESTMIN, cESTMIN); // Estoque Minimo
  pAddCampo(cdsCampos, cDesESTMAX, cESTMAX); // Estoque Maximo
  pAddCampo(cdsCampos, cDesTCIFCU, cTCIFCU); // TCIF (+)
  pAddCampo(cdsCampos, cDesTSCUST, cTSCUST); // TS (+)
  pAddCampo(cdsCampos, cDesDEPICO, cDEPICO); // DESCONTO PIS/COFINS (-)
  pAddCampo(cdsCampos, cDesDEICMS, cDEICMS); // DESCONTO ICMS (-)
  pAddCampo(cdsCampos, cDesFATREG, cFATREG); // FATOR REGIONAL (+)
  pAddCampo(cdsCampos, cDesEMBALA, cEMBALA); // embalagem


  pAddCampo(cdsCampos, cDesUNITRI, cUNITRI);
  pAddCampo(cdsCampos, cDesEXPPOK, cEXPPOK);
  pAddCampo(cdsCampos, cDesTIPPRO, cTIPPRO);
  pAddCampo(cdsCampos, cDesINDREV, cINDREV);
  pAddCampo(cdsCampos, cDesIMPDIR, cIMPDIR);

  pAddCampo(cdsCampos, cDesMsgLv1, cMsgLv1);
  pAddCampo(cdsCampos, cDesMsgLv2, cMsgLv2);
  pAddCampo(cdsCampos, cDesPEEFUT, cPEEFUT);
  pAddCampo(cdsCampos, cDesPEFUTP, cPEFUTP);
  pAddCampo(cdsCampos, cDesPEFFPR, cPEFFPR);
  pAddCampo(cdsCampos, cDesESMIDG_LISTA, cESMIDG_LISTA);
  pAddCampo(cdsCampos, cDesESTMIN_LISTA, cESTMIN_LISTA);
  pAddCampo(cdsCampos, cDesESTMAX_LISTA, cESTMAX_LISTA);
  pAddCampo(cdsCampos, cDesSITPRO_LISTA, cSITPRO_LISTA);
  pAddCampo(cdsCampos, cDesABVFIS_LISTA, cABVFIS_LISTA);
  pAddCampo(cdsCampos, cDesABVFIS_PIS, cABFPIS_LISTA);
  pAddCampo(cdsCampos, cDesABVFIS_COFINS, cABFCOF_LISTA);

  pAddCampo(cdsCampos, cDesTIPFRE, cTIPFRE);
  pAddCampo(cdsCampos, cDesVLCFRE, cVLCFRE);
  pAddCampo(cdsCampos, cDesQRCODE, cQRCODE);
  pAddCampo(cdsCampos, cDesEXPB2B, cEXPB2B);
  pAddCampo(cdsCampos, cDesPRAVAL, cPRAVAL);
  pAddCampo(cdsCampos, cDesRECDEV, cRECDEV); //Permitir receber devolução deste produto
  pAddCampo(cdsCampos, cDesVALOBR, cVALOBR); //Validade Obrigatoria
  pAddCampo(cdsCampos, cDesCOMPOS, cCOMPOS); //Composição
  pAddCampo(cdsCampos, cDesSAC,    cITESAC); //SAC
  pAddCampo(cdsCampos, cDesPAISOR, cPAISOR); //Pais de Origem
  pAddCampo(cdsCampos, cDesCODATC, cCODATC); //Código Assistência Técnica

  pAddCampo(cdsCampos, cDESMARGE1, cMARGE1); //Margem Ideal 1
  pAddCampo(cdsCampos, cDESMARGE2, cMARGE2); //Margem Ideal 2
  pAddCampo(cdsCampos, cDESMARGE3, cMARGE3); //Margem Ideal 3
  pAddCampo(cdsCampos, cDESMARGE4, cMARGE4); //Margem Ideal 4
  pAddCampo(cdsCampos, cDESMARGE5, cMARGE5); //Margem Ideal 5
  pAddCampo(cdsCampos, cDESMARGE6, cMARGE6); //Margem Ideal 6
  pAddCampo(cdsCampos, cDESMARGE7, cMARGE7); //Margem Ideal 7

  pAddCampo(cdsCampos, cDESSOBENC, cSOBENC); // SOB ENCOMENDA? ( S/N )

  if fCfgSis('UTPEST', varBoolean) then
  begin
    pAddCampo(cdsCampos, cDESQTDPES, cQTDPES); //Qtde mín. estoque para ponta de estoque
    pAddCampo(cdsCampos, cDESPORPES, cPORPES); //% de desconto aplicado para ponta de estoque
  end;

  pAddCampo(cdsCampos, cDESMLTRCA, cMLTRCA); // Múltiplo na rotina Citel Abastece

  pAddCampo(cdsCampos, cDesPER_CI, cPER_CI); // Percentual (CI)
  pAddCampo(cdsCampos, cDesNUMFCI, cNUMFCI); // Número da Ficha (FCI)

  if fCfgSis('UNITRI', varBoolean) then
    pAddCampo(cdsCampos, cDesFATUTR, cFATUTR); // Fator Conversão (Unid. Trib)

  If blnURapel Then
    pAddCampo(cdsCampos, cDesPRAPEL, cPRAPEL); //Desconto Referente Rapel

  pAddCampo(cdsCampos, cDesCEREPI, cCEREPI); //Certificado de Aprovação EPI

  if fCfgSis('MARPAD', varBoolean) then
    pAddCampo(cdsCampos, cDesMARPAD, cMARPAD); //Margem Padrão

  if fCfgSis('MINPRO', varBoolean) then
    pAddCampo(cdsCampos, cDesTPESTM_LISTA, cTPESTM_LISTA); //Tipo de Estoque Mínimo

End;

procedure TfrmImportCadProduto.pPopulaCDSEstIm(strCodIte, strLista, strField: String; var strErro: String);
var intPos: integer;
    i: integer;
    intig: integer;
    strCodEmp,
    strValorLista: String;
begin
  strErro := '';
  Try
    intPos := Pos('=', strLista) ;

    If IntPos > 0 Then
    Begin
      lst.Text := '';
      lst.StrictDelimiter := True;
      lst.Delimiter := '|';
      lst.DelimitedText := strLista;

      For i := 0 To lst.Count -1 do
      Begin
        intig := Pos('=', lst[i]);
        strCodEmp := Trim(copy(lst[i], 0, intig -1));
        strValorLista := Trim(copy(lst[i], intig + 1, Length(lst[i])));

        cdsESTMIN_ESTMAX.First;
        If cdsESTMIN_ESTMAX.Locate('ID;ITE_CODEMP', VarArrayOf([intSequencial, strCodEmp]), [] ) Then
           cdsESTMIN_ESTMAX.Edit
        Else
        Begin
           cdsESTMIN_ESTMAX.Insert;
           cdsESTMIN_ESTMAX.FieldByName('ID').AsInteger := intSequencial;
           cdsESTMIN_ESTMAX.FieldByName('ITE_CODEMP').AsString := strCodEmp;
        End;
        cdsESTMIN_ESTMAX.FieldByName(strField).Value := strValorLista;

        If (strCodIte <> '') And (cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX').Value = null) Then
        Begin
          qryConsulta.SQL.Text := 'SELECT ITE_ESTMIN, ITE_ESTMAX FROM ITEGER WHERE ITE_CODEMP = "' + strCodEmp + '" AND ITE_CODITE = "' + strCodite + '"';
          qryConsulta.Open;
          If Not qryConsulta.IsEmpty Then
          Begin
            cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN_OLD').AsFloat := qryConsulta.FieldByName('ITE_ESTMIN').AsFloat;
            cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX_OLD').AsFloat := qryConsulta.FieldByName('ITE_ESTMAX').AsFloat;
          End;
        End;

        cdsESTMIN_ESTMAX.Post;
      End;
    End
    Else
    Begin
      cdsESTMIN_ESTMAX.First;
      If cdsESTMIN_ESTMAX.Locate('ID;ITE_CODEMP', VarArrayOf([intSequencial, VS_StrCodEmp]), [] ) Then
         cdsESTMIN_ESTMAX.Edit
      Else
      Begin
         cdsESTMIN_ESTMAX.Insert;
         cdsESTMIN_ESTMAX.FieldByName('ID').AsInteger := intSequencial;
         cdsESTMIN_ESTMAX.FieldByName('ITE_CODEMP').AsString := VS_StrCodEmp;
      End;

      If (strCodIte <> '') And (cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX').Value = null) Then
      Begin
        qryConsulta.SQL.Text := 'SELECT ITE_ESTMIN, ITE_ESTMAX FROM ITEGER WHERE ITE_CODEMP = "' + VS_StrCodEmp + '" AND ITE_CODITE = "' + strCodite + '"';
        qryConsulta.Open;
        If Not qryConsulta.IsEmpty Then
        Begin
          cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMIN_OLD').AsFloat := qryConsulta.FieldByName('ITE_ESTMIN').AsFloat;
          cdsESTMIN_ESTMAX.FieldByName('ITE_ESTMAX_OLD').AsFloat := qryConsulta.FieldByName('ITE_ESTMAX').AsFloat;
        End;
      End;
      cdsESTMIN_ESTMAX.FieldByName(strField).Value := strLista;

      cdsESTMIN_ESTMAX.Post;
    End;
  Except
    On e: Exception do
     strErro := e.message + ' Erro ao carregar a lista [' + strField + ']' ;
  End
end;

procedure TfrmImportCadProduto.btnCancelaValidacaoClick(Sender: TObject);
begin
  inherited;
  objValidaExcel.blnCancela := True;
end;

procedure TfrmImportCadProduto.btnConfiguraClick(Sender: TObject);
begin
  If Not cdsCampos.Active then
    cdsCampos.CreateDataSet;

  pCriarFormularios(TfrmImportCadProdutoCamposAtualiza, frmImportCadProdutoCamposAtualiza);
  Try
    frmImportCadProdutoCamposAtualiza.cdsCampos.Data := cdsCampos.Data;

    If (frmImportCadProdutoCamposAtualiza.ShowModal = mrOk) then
      cdsCampos.Data := frmImportCadProdutoCamposAtualiza.cdsCampos.Data;

  Finally
    pFreeAndNil(frmImportCadProdutoCamposAtualiza);
  End;
end;

procedure TfrmImportCadProduto.btnGravarClick(Sender: TObject);
  Var
   intValIni, intContador : Integer;

   ArrCamposReplaceCharEspecial : TArrCamposReplaceCharEspecial;
begin
  inherited;
  lstDesIte.Clear;
  {*******************************}
  { VERIRICA SE O ARQUIVO EXISTE  }
  {****************************LU*}

  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  if chkArrMai.Checked then
  Begin
    if ( StrToIntDef(edtDecUni.Text,0) < 0 ) Or
       ( StrToIntDef(edtDecUni.Text,0) > fCfgSis('DECUNI', varInteger) ) Then
    Begin
      fMensagem('ATENÇÃO', 'Valor indicado para arredondamento das casas decimais deve ser entre 0 e ' + fCfgSis('DECUNI', varString) + ' !', ['&OK']);
      exit
    End;
  End;
  
  GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;
  GerenciaItegerPermiteEdicao.pSetaEmpresa(VS_StrCodEmp, '');

  try

    SetLength(ArrCamposReplaceCharEspecial, 3);

    ArrCamposReplaceCharEspecial[0].FColuna := cDSSITE;
    ArrCamposReplaceCharEspecial[0].TipoReplaceEnter := trcetml;
    ArrCamposReplaceCharEspecial[1].FColuna := cAPLITE;
    ArrCamposReplaceCharEspecial[1].TipoReplaceEnter := trcetml;
    ArrCamposReplaceCharEspecial[2].FColuna := cNOMITE;
    ArrCamposReplaceCharEspecial[2].TipoReplaceEnter := trcetml;

    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCODITE, '', 0, ArrCamposReplaceCharEspecial);
    pPreparaValidador;
    If fMensagem('Atenção', 'Deseja validar os dados contidos no arquivo informado', ['&Sim', '&Não']) = 1 Then
    Begin
      Try

        pgbGeral.Visible := True;
        btnGravar.Enabled := True;
        btnCancelaValidacao.Visible := True;
        If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
          Exit;
      Finally
        btnGravar.Enabled := False;
        btnCancelaValidacao.Visible := False;
      End;
    End;

    If fVerificaCampos Then
    Begin
      btnHlpImp.Enabled     := False;
      btnGravar.Enabled     := False;
      btnSair.Enabled       := False;
      edtPath.Enabled       := False;
      gpbRecalcular.Enabled := False;

      pnlInfo.Caption       := 'Aguarde... Carregando cadastro de Produtos...';

      Mouse.SettingChanged(10);
      pgbGeral.Visible := True;
      Application.ProcessMessages;
      pnlInfo.Caption       := 'Aguarde... Importando Tabela de Preços...';
      edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');
      pCriarCds;
      Try
        blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

        If Not blnArqCsv Then
        Begin
          {**************************************}
          {* ABRE EXCEL E ARQUIVO XLS           *}
          {***********************************LU*}
          Excel := CreateOleObject('Excel.Application');
          Excel.Visible       := False;
          Excel.DisplayAlerts := False;
          Excel.WorkBooks.Open(Filename := objValidaExcel.NomeArquivo);

          {****************************************}
          {* VAI PARA A ULTIMA CELULA COM DADOS   *}
          {* PARA PEGAR A QUANTIDADE DE REGISTROS *}
          {*************************************LU*}

          {xlCellTypeLastCell. A última célula no intervalo usado}
          Excel.Selection.SpecialCells(11).Select;

          pgbGeral.Properties.Max := Excel.ActiveCell.Row -1;
        End
        Else
          pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;

        pgbGeral.Position := 0;

        pLimparCDS;
        intValIni := IIf(fTemTitulo, 1 , 0);
        intSequencial := 1;
        For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
        Begin
          If blnArqCsv Then
            If intContador > objValidaExcel.ArquivoCSV.Count Then
              Continue;
          pInsereItensCDS(intContador);
          pgbGeral.Position := pgbGeral.Position + 1;
          Application.ProcessMessages;
          inc(intSequencial);

        End;

        If not cdsItens.IsEmpty Then
        Begin

          pCriarFormularios(TfrmImportCadProdutoConfirma, frmImportCadProdutoConfirma);
          Try
            frmImportCadProdutoConfirma.strArqCSV :=  objValidaExcel.ArquivoCSV.Text;

            frmImportCadProdutoConfirma.blnProCod := blnProCod;
            frmImportCadProdutoConfirma.blnPrecoVenda := rdbPreVen.Checked;

            if rdbPreVen.Checked Then
              frmImportCadProdutoConfirma.intArredondamento := StrToInt(edtDecUni.Text);

            frmImportCadProdutoConfirma.strPath := edtPath.Text;
            frmImportCadProdutoConfirma.strNdeDuz := IIF(ChkNaoReduzirPrecoCompra.Checked,'S','N');
            frmImportCadProdutoConfirma.fExibirTela(cdsItens, cdsItensEmbalagem, cdsItensEmbDescFech, cdsESTMIN_ESTMAX,
            edtPath.Text,
            IIF(rdbPreVen.Checked, 'PREÇO DE VENDA','MARGEM LUCRO'),
            IIF(ChkNaoReduzirPrecoCompra.Checked,'S','N'));

          Finally
            pFreeAndNil(frmImportCadProdutoConfirma);
          End;
        End;
        SetForegroundWindow(Handle);

        edtPath.Clear;
        btnHlpImp.Enabled     := True;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;
        gpbRecalcular.Enabled := True;
        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);
        cdsItens.Close;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmImportCadProduto.btnGravarClick]');
          btnHlpImp.Enabled     := True;
          btnGravar.Enabled     := True;
          btnSair.Enabled       := True;
          edtPath.Enabled       := True;
          gpbRecalcular.Enabled := True;
          pnlInfo.Caption       := '';
          pgbGeral.Position     := 0;
          pSetFocus(btnSair);
        End;
      End;

    End;

    If Not blnArqCsv Then
    Begin
      Excel.WorkBooks.Close;
      Excel.Quit;
    End
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;
    gpbRecalcular.Enabled := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;
    FreeAndNIl(GerenciaItegerPermiteEdicao);

  End
end;

procedure TfrmImportCadProduto.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportCadProduto.chkArrMaiClick(Sender: TObject);
begin
  inherited;
  edtDecUni.Enabled := chkArrMai.Checked;
end;

procedure TfrmImportCadProduto.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;



function TfrmImportCadProduto.fItemComMesmaDecricao(strDesIte: String): Boolean;
begin
  Result := lstDesIte.IndexOf(strDesIte) <> -1;
  lstDesIte.Add(strDesIte);
end;

Procedure TfrmImportCadProduto.pCalcularPrecos(cdsItens: TZClient; Var recPrecos: TArrRecPrecos; fltCnvCus: Double);
  var
   fltIcmsSTParteVenda,
   fltPreCus,
   fltOutVal,
   fltIcmSai,
   fltDesOpe,
   fltPrecom,
   fltImpFed: Double;
   i, intTabela: integer;
   blnST: Boolean;
begin
  fltPreCus := fRetPrecoCusto(IfThen(cdsItens.FieldByName('ITE_PRECOM_NOV').IsNull, cdsItens.FieldByName('ITE_PRECOM').AsFloat, cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat/fltCnvCus),
                              IfThen(cdsItens.FieldByName('ITE_DESF01_NOV').IsNull, cdsItens.FieldByName('ITE_DESF01').AsFloat, cdsItens.FieldByName('ITE_DESF01_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF02_NOV').IsNull, cdsItens.FieldByName('ITE_DESF02').AsFloat, cdsItens.FieldByName('ITE_DESF02_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF03_NOV').IsNull, cdsItens.FieldByName('ITE_DESF03').AsFloat, cdsItens.FieldByName('ITE_DESF03_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF04_NOV').IsNull, cdsItens.FieldByName('ITE_DESF04').AsFloat, cdsItens.FieldByName('ITE_DESF04_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF05_NOV').IsNull, cdsItens.FieldByName('ITE_DESF05').AsFloat, cdsItens.FieldByName('ITE_DESF05_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESF06_NOV').IsNull, cdsItens.FieldByName('ITE_DESF06').AsFloat, cdsItens.FieldByName('ITE_DESF06_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_ICMENT_NOV').IsNull, cdsItens.FieldByName('ITE_ICMENT').AsFloat, cdsItens.FieldByName('ITE_ICMENT_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_SUBFED_NOV').IsNull, cdsItens.FieldByName('ITE_SUBFED').AsFloat, cdsItens.FieldByName('ITE_SUBFED_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_IPIENT_NOV').IsNull, cdsItens.FieldByName('ITE_IPIENT').AsFloat, cdsItens.FieldByName('ITE_IPIENT_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_FREENT_NOV').IsNull, cdsItens.FieldByName('ITE_FREENT').AsFloat, cdsItens.FieldByName('ITE_FREENT_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_ACRFIN_NOV').IsNull, cdsItens.FieldByName('ITE_ACRFIN').AsFloat, cdsItens.FieldByName('ITE_ACRFIN_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_SUBSTI_NOV').IsNull, cdsItens.FieldByName('ITE_SUBSTI').AsFloat, cdsItens.FieldByName('ITE_SUBSTI_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DESADB_NOV').IsNull, cdsItens.FieldByName('ITE_DESADB').AsFloat, cdsItens.FieldByName('ITE_DESADB_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_VALFRE_NOV').IsNull, cdsItens.FieldByName('ITE_VALFRE').AsFloat, cdsItens.FieldByName('ITE_VALFRE_NOV').AsFloat/fltCnvCus),
                              cdsItens.FieldByName('ITE_PREDOL').AsString = 'S',
                              IfThen(cdsItens.FieldByName('ITE_TCIFCU_NOV').IsNull, cdsItens.FieldByName('ITE_TCIFCU').AsFloat, cdsItens.FieldByName('ITE_TCIFCU_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_TSCUST_NOV').IsNull, cdsItens.FieldByName('ITE_TSCUST').AsFloat, cdsItens.FieldByName('ITE_TSCUST_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DEPICO_NOV').IsNull, cdsItens.FieldByName('ITE_DEPICO').AsFloat, cdsItens.FieldByName('ITE_DEPICO_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_DEICMS_NOV').IsNull, cdsItens.FieldByName('ITE_DEICMS').AsFloat, cdsItens.FieldByName('ITE_DEICMS_NOV').AsFloat),
                              IfThen(cdsItens.FieldByName('ITE_FATREG_NOV').IsNull, cdsItens.FieldByName('ITE_FATREG').AsFloat, cdsItens.FieldByName('ITE_FATREG_NOV').AsFloat));

  cdsItens.FieldByName('ITE_PRECUS_NOV').AsFloat := fltPreCus;

  fltOutVal := IfThen(cdsItens.FieldByName('ITE_OUTVAL_NOV').IsNull, cdsItens.FieldByName('ITE_OUTVAL').AsFloat, cdsItens.FieldByName('ITE_OUTVAL_NOV').AsFloat/fltCnvCus);
  cdsItens.FieldByName('ITE_OUTVAL_NOV').AsFloat := fltOutVal;
  fltIcmSai := IfThen(cdsItens.FieldByName('ITE_ICMSAI_NOV').IsNull, cdsItens.FieldByName('ITE_ICMSAI').AsFloat, cdsItens.FieldByName('ITE_ICMSAI_NOV').AsFloat);
  cdsItens.FieldByName('ITE_ICMSAI_NOV').AsFloat := fltIcmSai;
  fltDesOpe := IfThen(cdsItens.FieldByName('ITE_DESOPE_NOV').IsNull, cdsItens.FieldByName('ITE_DESOPE').AsFloat, cdsItens.FieldByName('ITE_DESOPE_NOV').AsFloat);
  cdsItens.FieldByName('ITE_DESOPE_NOV').AsFloat := fltDesOpe;
  fltImpFed := IfThen(cdsItens.FieldByName('ITE_IMPFED_NOV').IsNull, cdsItens.FieldByName('ITE_IMPFED').AsFloat, cdsItens.FieldByName('ITE_IMPFED_NOV').AsFloat);
  cdsItens.FieldByName('ITE_IMPFED_NOV').AsFloat := fltImpFed;

  For i := 1 To 7 do
   recPrecos[i].fltComiss := IfThen(cdsItens.FieldByName('ITE_COMTB' +  IntToStr(i)+ '_NOV').IsNull,
                                    cdsItens.FieldByName('ITE_COMTB' +  IntToStr(i)).AsFloat,
                                    cdsItens.FieldByName('ITE_COMTB' +  IntToStr(i)+ '_NOV').AsFloat);

  fltPrecom := IfThen(cdsItens.FieldByName('ITE_PRECOM_NOV').IsNull, cdsItens.FieldByName('ITE_PRECOM').AsFloat, cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat/fltCnvCus);
  cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat := fltPrecom;

  If strMarMkp = '4'  Then
  Begin

    fltIcmsSTParteVenda := TfrmImportCadProdutoConfirma.fGetIcmsSTParteVenda(strEstEmp, strMarMkp,blnST, TfrmImportCadProdutoConfirma.fGetValorStr(cdsItens, 'ITE_CODABF'),

                              fCalculaPrecoCompraLiq(fltPrecom,
                                                     TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_DESF01'),
                                                     TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_DESF02'),
                                                     TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_DESF03'),
                                                     TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_DESF04'),
                                                     TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_DESF05'),
                                                     TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_DESF06'),
                                                     intDecUni,
                                                     cdsItens.FieldByName('ITE_PREDOL').AsString = 'S'),

                               TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_IPIENT'),
                               TfrmImportCadProdutoConfirma.fGetValor(cdsItens, 'ITE_ICMSAI'))
  End
  Else
  Begin
    blnST := False;
    fltIcmsSTParteVenda := 0;
  End;

  If rdbPreVen.Checked Then
  Begin
    For intTabela := 1 To 7 Do
    Begin
      recPrecos[intTabela].fltComiss := IfThen(cdsItens.FieldByName('ITE_COMTB' +  IntToStr(IntTabela)+ '_NOV').IsNull,
                                               cdsItens.FieldByName('ITE_COMTB' +  IntToStr(IntTabela)).AsFloat,
                                               cdsItens.FieldByName('ITE_COMTB' +  IntToStr(IntTabela)+ '_NOV').AsFloat);

      recPrecos[intTabela].fltMarBru := IfThen(cdsItens.FieldByName('ITE_MARBR' +  IntToStr(IntTabela)+ '_NOV').IsNull,
                                    cdsItens.FieldByName('ITE_MARBR' +  IntToStr(IntTabela)).AsFloat,
                                    cdsItens.FieldByName('ITE_MARBR' +  IntToStr(IntTabela)+ '_NOV').AsFloat);


      If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabela))))) Or (intTabela = 1) Then
      Begin
        recPrecos[intTabela].fltPreVen := fCalculaPrecoVenda(1,
                                                          fltPreCus + fltOutVal,
                                                          0,
                                                          recPrecos[intTabela].fltMarBru,
                                                          fltIcmSai,
                                                          fltImpFed,
                                                          fltDesOpe,
                                                          recPrecos[intTabela].fltComiss,
                                                          strMarMkp,
                                                          strPcmPro,
                                                          intDecUni,
                                                          fltIcmsSTParteVenda,
                                                          blnST);
        recPrecos[intTabela].fltVariacao :=  (recPrecos[intTabela].fltPreVen/cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat -1) * 100;

        recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                          fltPreCus + fltOutVal,
                                                          recPrecos[intTabela].fltPreVen,
                                                          0,
                                                          fltIcmSai,
                                                          fltImpFed,
                                                          fltDesOpe,
                                                          recPrecos[intTabela].fltComiss,
                                                          strMarMkp,
                                                          strPcmPro,
                                                          intDecUni,
                                                          fltIcmsSTParteVenda,
                                                          blnST);


        If chkArrMai.Checked Then
        Begin
          recPrecos[intTabela].fltPreVen := RoundTo(recPrecos[intTabela].fltPreVen, StrToIntDef(edtDecUni.Text,0) * -1 );

          recPrecos[intTabela].fltVariacao :=  (recPrecos[intTabela].fltPreVen/cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat -1) * 100;

          recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                          fltPreCus + fltOutVal,
                                                          recPrecos[intTabela].fltPreVen,
                                                          0,
                                                          fltIcmSai,
                                                          fltImpFed,
                                                          fltDesOpe,
                                                          recPrecos[intTabela].fltComiss,
                                                          strMarMkp,
                                                          strPcmPro,
                                                          intDecUni,
                                                          fltIcmsSTParteVenda,
                                                          blnST);
        End;



      End
      Else
      Begin
        If objFatPre.fTabelaAtiva(intTabela) Then
          recPrecos[intTabela].fltPreVen := objFatPre.fCalculaPrecoVendaFator(IfThen(cdsItens.FieldByName('ITE_PREVE1_NOV').IsNull,
                                             cdsItens.FieldByName('ITE_PREVE1').AsFloat,
                                             cdsItens.FieldByName('ITE_PREVE1_NOV').AsFloat/fltCnvCus), intTabela);

        recPrecos[intTabela].fltVariacao :=  (recPrecos[intTabela].fltPreVen/cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat -1) * 100;
        recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                          fltPreCus + fltOutVal,
                                                          recPrecos[intTabela].fltPreVen,
                                                          0,
                                                          fltIcmSai,
                                                          fltImpFed,
                                                          fltDesOpe,
                                                          recPrecos[intTabela].fltComiss,
                                                          strMarMkp,
                                                          strPcmPro,
                                                          intDecUni,
                                                          fltIcmsSTParteVenda,
                                                          blnST);


        If chkArrMai.Checked Then
        Begin
          If objFatPre.fTabelaAtiva(intTabela) Then
           recPrecos[intTabela].fltPreVen := objFatPre.fCalculaPrecoVendaFator(IfThen(cdsItens.FieldByName('ITE_PREVE1_NOV').IsNull,
                                             cdsItens.FieldByName('ITE_PREVE1').AsFloat,
                                             RoundTo(cdsItens.FieldByName('ITE_PREVE1_NOV').AsFloat, StrToIntDef(edtDecUni.Text,0) * -1 )/fltCnvCus), intTabela);

           recPrecos[intTabela].fltVariacao :=  (recPrecos[intTabela].fltPreVen/cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat -1) * 100;
           recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                          fltPreCus + fltOutVal,
                                                          recPrecos[intTabela].fltPreVen,
                                                          0,
                                                          fltIcmSai,
                                                          fltImpFed,
                                                          fltDesOpe,
                                                          recPrecos[intTabela].fltComiss,
                                                          strMarMkp,
                                                          strPcmPro,
                                                          intDecUni,
                                                          fltIcmsSTParteVenda,
                                                          blnST);
        end;

      End;
    End;
  End
  Else
  Begin
    For intTabela := 1 To 7 Do
    Begin
      recPrecos[intTabela].fltPreVen := IfThen(cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)+ '_NOV').IsNull,
                                    cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat,
                                    cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)+ '_NOV').AsFloat/fltCnvCus);

      recPrecos[intTabela].fltVariacao :=  (recPrecos[intTabela].fltPreVen/cdsItens.FieldByName('ITE_PREVE' +  IntToStr(IntTabela)).AsFloat -1) * 100;

      recPrecos[intTabela].fltMarBru := fCalculaPrecoVenda(2,
                                                        fltPreCus + fltOutVal,
                                                        recPrecos[intTabela].fltPreVen,
                                                        0,
                                                        fltIcmSai,
                                                        fltImpFed,
                                                        fltDesOpe,
                                                        recPrecos[intTabela].fltComiss,
                                                        strMarMkp,
                                                        strPcmPro,
                                                        intDecUni,
                                                        fltIcmsSTParteVenda,
                                                        blnST);
    End;
  End;
end;

Procedure TfrmImportCadProduto.pGetCodigos(Var strCodIte, strCodBar, strCodFor, strCodFab, strIteAti, strDesIte: String; intLinha: Integer);
Begin
  If Not blnArqCsv Then
  Begin
    If Not fEmptyStr(Trim(fRetSomenteNumeros(Excel.Range[cCodIte + IntToStr(intLinha)].Value))) Then
      strCodIte := Format('%0.'+IntToStr(fTamCodIte)+'d', [StrToInt(Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value))])
    Else
      strCodIte := '';

    strCodBar := Trim(Excel.Range[cCodBar + IntToStr(intLinha)].Value);
    strCodFor := Trim(Excel.Range[cCodFor + IntToStr(intLinha)].Value);
    strCodFab := Trim(Excel.Range[cCodFab + IntToStr(intLinha)].Value);
    strIteAti := Trim(Excel.Range[cITEATI + IntToStr(intLinha)].Value);
    strDesIte := Trim(Excel.Range[cDESITE + IntToStr(intLinha)].Value);
  End
  Else
  Begin
    strCodIte := objValidaExcel.fGetValueCSV(intLinha, cCODITE);
    strCodBar := objValidaExcel.fGetValueCSV(intLinha, cCODBAR);
    strCodFor := objValidaExcel.fGetValueCSV(intLinha, cCODFOR);
    strCodFab := objValidaExcel.fGetValueCSV(intLinha, cCODFAB);
    strIteAti := objValidaExcel.fGetValueCSV(intLinha, cITEATI);
    strDesIte := objValidaExcel.fGetValueCSV(intLinha, cDESITE);
  End;
End;

procedure TfrmImportCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  lstDesIte := TStringList.Create;
  lst := TStringList.Create;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  strDesValFre := fCfgSis('DESVFR');

  blnUsaQtdPen := fUsaQtdPendenteEntregaFutura(True, '', True);

  strCnvEmb := fCfgSis('CNVEMB');
  intDecUni := fCfgSis('DECUNI', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');
  blnProCod := fUsaProCodigo('CADITE');
  strEstEmp := fCadEmp('ESTADO');
  blnURapel := fCfgSis('URAPEL', varBoolean);

  qryItensEncontrados := fCriaQuery();
  qryConsulta := fCriaQuery();

  rdbMargem.Checked := fCfgSis('VENMAR') ='2';

  qryCodBar := fCriaQuery(Self);
  qryCodBar.SQL.Text := 'SELECT CAST(GROUP_CONCAT(BAR_CODITE) AS CHAR(255)) AS DUPLICADOS FROM ITEBAR WHERE BAR_CODBAR = :CODBAR AND BAR_CODITE <> :CODITE';

  qryCodFab := fCriaQuery(Self);
  qryCodFab.SQL.Text := 'SELECT CAST(GROUP_CONCAT(ITE_CODITE) AS CHAR(255)) AS DUPLICADOS FROM CADITE WHERE ITE_CODFAB = :CODFAB AND ITE_CODFOR = :CODFOR AND ITE_CODITE <> :CODITE';

  if Not cdsCampos.Active then
    cdsCampos.CreateDataSet;

  pPopulaCDS;

end;

procedure TfrmImportCadProduto.FormDestroy(Sender: TObject);
begin
  pFreeAndNil(lstDesIte);
  pFreeAndNil(qryItensEncontrados);
  pFreeAndNil(cpcParams);
  pFreeAndNil(qryConsulta);
  pFreeAndNil(lst);
  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);
  If Assigned(cdsItensEmbalagem) Then
    FreeAndNil(cdsItensEmbalagem);

  If Assigned(cdsItensEmbDescFech) Then
    FreeAndNil(cdsItensEmbDescFech);

   FreeAndNil(cdsESTMIN_ESTMAX);

  If Assigned(GerenciaItegerPermiteEdicao) Then
    FreeAndNil(GerenciaItegerPermiteEdicao);
  inherited;
end;

function TfrmImportCadProduto.fProcessaValorDefault(cCampo, strValor: String): String;
begin
  If strValor <> '' Then
     Result := strValor
  Else If (SameText(cITEBAS, cCampo)) And (cdsItens.FieldByName('ITE_ITEBAS').AsString <> '') Then
    Result := cdsItens.FieldByName('ITE_ITEBAS').AsString
  Else If (SameText(cITEPIG, cCampo)) And (cdsItens.FieldByName('ITE_ITEPIG').AsString <> '') Then
    Result := cdsItens.FieldByName('ITE_ITEPIG').AsString
  Else If (SameText(cBAREXP, cCampo)) And (cdsItens.FieldByName('ITE_BAREXP').AsString <> '') Then
    Result := cdsItens.FieldByName('ITE_BAREXP').AsString
  Else If (SameText(cITEBAS, cCampo)) Or (SameText(cITEPIG, cCampo)) Then
    Result := 'N'
  Else If (SameText(cBAREXP, cCampo)) Then
    Result := 'S';
end;

function TfrmImportCadProduto.fRetPrecoCusto(fltPreCom, fltDesF01, fltDesF02, fltDesF03, fltDesF04, fltDesF05, fltDesF06, fltICMEnt, fltSubFed, fltIpiEnt, fltFreEnt, fltAcrFin, fltSubsti, fltDesAdb, fltVrFret: Double; blnPreDol: Boolean; fltTCIFCu, fltTSCust, fltDePiCo, fltDeICMS, fltFatReg: Double): Double;
begin
  Try
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fltDesF01;
      curDesF02 := fltDesF02;
      curDesF03 := fltDesF03;
      curDesF04 := fltDesF04;
      curDesF05 := fltDesF05;
      curDesF06 := fltDesF06;
      curICMSEnt:= fltICMEnt;
      curIPIEnt := fltIpiEnt;
      curFrete  := fltFreEnt;
      curAcrFin := fltAcrFin;
      curSubsti := fltSubsti;
      curDesAdb := fltDesAdb;
      curSubFed := fltSubFed;
      curValFre := fltVrFret;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := fltTCIFCu;
        curTSCust := fltTSCust;
        curDePiCo := fltDePiCo;
        curDeICMS := fltDeICMS;
        curFatReg := fltFatReg;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    Result := cpcParams.fCalculaPrecoCusto(blnPreDol)
  Finally
  End;
end;

function TfrmImportCadProduto.fSqlBase: string;

  procedure pAddCampoSQL(strCampo: string; strAlias: string = ''; strOrigem: string = '';  blnNovo: boolean = True; blnVirgula: boolean = True);
  begin
    If Not fEmptyStr(strAlias) Then
      strAlias := strAlias + '.';

    If fEmptyStr(strOrigem) Then
      Result := Result + ' ' + strAlias  + ' ITE_' +  strCampo + IIf(blnVirgula, ',', '')
    Else
      Result := Result + ' ' + strAlias  + ' ITE_' +  strCampo + ' AS ITE_' + strCampo + '_' + strOrigem + IIf(blnVirgula, ',', '') ;

    If blnNovo Then
      Result := Result + IIf(Not blnVirgula, ', ', '') +
         ' ' + strAlias  + ' ITE_' +  strCampo +
         ' AS ITE_' + strCampo + IIf(fEmptyStr(strOrigem), '', '_' + strOrigem )+ '_NOV' + IIf(blnVirgula, ',', '');
  end;

begin
  pAddCampoSQL('CODITE', 'I', '', False);

  Result := Result + '   (SELECT GROUP_CONCAT(BAR_CODBAR) ';
  Result := Result + '    FROM ITEBAR ';
  Result := Result + '    WHERE I.ITE_CODITE = BAR_CODITE) AS ITE_CODBAR, ';

  Result := Result + ' I.ITE_CODBAR AS ITE_CODBAR_NOV, ';

  Result := Result + ' I.ITE_EMBALA AS FATEMB, ';

  Result := Result + ' UNI_SIGUNI AS SIGUNI, ';

  Result := Result + ' 0.0000 AS VARIACAO1, ';
  Result := Result + ' 0.0000 AS VARIACAO2, ';
  Result := Result + ' 0.0000 AS VARIACAO3, ';
  Result := Result + ' 0.0000 AS VARIACAO4, ';
  Result := Result + ' 0.0000 AS VARIACAO5, ';
  Result := Result + ' 0.0000 AS VARIACAO6, ';
  Result := Result + ' 0.0000 AS VARIACAO7, ';

  pAddCampoSQL('CODFAB', 'I');
  pAddCampoSQL('DTAULT', 'G');

  pAddCampoSQL('CODFOR', 'I');
  pAddCampoSQL('CODDEP');
  pAddCampoSQL('CODGRU');
  pAddCampoSQL('DESITE', 'I');
  pAddCampoSQL('DESSIM', 'I');
  pAddCampoSQL('ESTMIN', 'G');
  pAddCampoSQL('ESTMAX', 'G');
  pAddCampoSQL('DESFAB');
  pAddCampoSQL('CODMAR');

  pAddCampoSQL('REFERE');
  pAddCampoSQL('CODUNI');
  pAddCampoSQL('UNICOM');

  pAddCampoSQL('MSGLV1');
  pAddCampoSQL('MSGLV2');
  pAddCampoSQL('PEEFUT');
  pAddCampoSQL('PEFUTP');
  pAddCampoSQL('PEFFPR');

  pAddCampoSQL('CODABF', IIf(fCfgSIs('TIPABF') = '2', 'G', 'I'));

  pAddCampoSQL('ABFPIS', IIf(fCfgSIs('TPABPC') = '2', 'G', 'I'));
  pAddCampoSQL('ABFCOF', IIf(fCfgSIs('TPABPC') = '2', 'G', 'I'));
  pAddCampoSQL('ABFIPI', IIf(fCfgSIs('TPABPC') = '2', 'G', 'I'));
  pAddCampoSQL('IPISAI');
  pAddCampoSQL('INCPIS');
  pAddCampoSQL('CLAIPI');
  pAddCampoSQL('EXCIPI', 'I');
  pAddCampoSQL('CDCEST');
  pAddCampoSQL('CODONU');
  pAddCampoSQL('IMPLIS', 'G');
  pAddCampoSQL('ITEATI');
  pAddCampoSQL('ATICOM', 'I');
  pAddCampoSQL('PESOIT');
  pAddCampoSQL('CODGPR');
  pAddCampoSQL('PRDGRU');
  pAddCampoSQL('GRUCMP');
  pAddCampoSQL('MLTVEN');
  pAddCampoSQL('MLTCOM');
  pAddCampoSQL('NVLGIR','I');
  pAddCampoSQL('NIVGIR');
  pAddCampoSQL('NVLCRI','I');
  pAddCampoSQL('ACOOBJ');
  pAddCampoSQL('APLICA');
  pAddCampoSQL('PRECOM');
  pAddCampoSQL('DESF01');
  pAddCampoSQL('DESF02');
  pAddCampoSQL('DESF03');
  pAddCampoSQL('DESF04');
  pAddCampoSQL('DESF05');
  pAddCampoSQL('DESF06');
  pAddCampoSQL('ICMENT');
  pAddCampoSQL('SUBFED');
  pAddCampoSQL('IPIENT');
  pAddCampoSQL('FREENT');
  pAddCampoSQL('VALFRE');
  pAddCampoSQL('ACRFIN');
  pAddCampoSQL('SUBSTI');
  pAddCampoSQL('DESADB');
  pAddCampoSQL('OUTVAL');
  pAddCampoSQL('ICMSAI');
  pAddCampoSQL('IMPFED');
  pAddCampoSQL('DESOPE');
  pAddCampoSQL('MARBR1');
  pAddCampoSQL('COMTB1');
  pAddCampoSQL('PREVE1');
  pAddCampoSQL('MARBR2');
  pAddCampoSQL('COMTB2');
  pAddCampoSQL('PREVE2');
  pAddCampoSQL('MARBR3');
  pAddCampoSQL('COMTB3');
  pAddCampoSQL('PREVE3');
  pAddCampoSQL('MARBR4');
  pAddCampoSQL('COMTB4');
  pAddCampoSQL('PREVE4');
  pAddCampoSQL('MARBR5');
  pAddCampoSQL('COMTB5');
  pAddCampoSQL('PREVE5');
  pAddCampoSQL('MARBR6');
  pAddCampoSQL('COMTB6');
  pAddCampoSQL('PREVE6');
  pAddCampoSQL('MARBR7');
  pAddCampoSQL('COMTB7');
  pAddCampoSQL('PREVE7');
  pAddCampoSQL('COMVAR');
  pAddCampoSQL('COMATA');
  pAddCampoSQL('COMDIS');
  pAddCampoSQL('COMPRO');
  pAddCampoSQL('DESMAX');
  pAddCampoSQL('DESMSU');
  pAddCampoSQL('DESMGE');
  pAddCampoSQL('MARMIN');
  pAddCampoSQL('MARMSG');
  pAddCampoSQL('MARMGE');
  pAddCampoSQL('TMPGAR');
  pAddCampoSQL('INFGAR');
  pAddCampoSQL('LOCFIS');
  pAddCampoSQL('PRECUS', 'G');
  pAddCampoSQL('PREDOL', 'G');
  pAddCampoSQL('LOCSUP');
  pAddCampoSQL('ITEBAS');
  pAddCampoSQL('ITEPIG');
  pAddCampoSQL('BAREXP');
  pAddCampoSQL('PESLIQ');
  pAddCampoSQL('CODLSE');
  pAddCampoSQL('DIAFOR');
  //Dados E-Commerce
  pAddCampoSQL('EXPSIT');
  pAddCampoSQL('DESITE', 'S','SITE');
  pAddCampoSQL('DADTEC');
  pAddCampoSQL('URLIMG');
  pAddCampoSQL('NOMITE');
  pAddCampoSQL('APLITE');
  pAddCampoSQL('INCLUS');
  pAddCampoSQL('EXPALT');
  pAddCampoSQL('EXPLAR');
  pAddCampoSQL('EXPPRO');
  pAddCampoSQL('DESSIT');
  pAddCampoSQL('CODCAT');
  pAddCampoSQL('DESTAQ');
  pAddCampoSQL('ATZPRE');
  pAddCampoSQL('EXPAPP');
  pAddCampoSQL('TCIFCU');
  pAddCampoSQL('TSCUST');
  pAddCampoSQL('DEPICO');
  pAddCampoSQL('DEICMS');
  pAddCampoSQL('FATREG');
  pAddCampoSQL('CEREPI');

  if fCfgSis('MARPAD', varBoolean) then
    pAddCampoSQL('MARPAD');

  pAddCampoSQL('UNITRI');
  pAddCampoSQL('EXPPOK');
  pAddCampoSQL('TIPPRO', 'G');
  pAddCampoSQL('SOBENC', 'G');
  pAddCampoSQL('MLTRCA', 'G');
  pAddCampoSQL('INDREV', fDefineAliasIndRev);
  pAddCampoSQL('IMPDIR', fDefineAliasImpDir);

  pAddCampoSQL('TIPFRE');
  pAddCampoSQL('VLCFRE');
  pAddCampoSQL('QRCODE');
  pAddCampoSQL('EXPB2B','I');
  pAddCampoSQL('PRAVAL','I');
  pAddCampoSQL('NVLCRI','I');

//  if fCfgSis('MINPRO', varBoolean) then
//    pAddCampoSQL('TPESTM');

  Result := Result + '   (SELECT GROUP_CONCAT(ITM_CODMON) ';
  Result := Result + '    FROM ITEMON ';
  Result := Result + '   WHERE ITM_CODITE = G.ITE_CODITE) ITE_CODMON, ';
  Result := Result + ' CAST("" AS CHAR(255)) AS ITE_CODMON_NOV, ';



  Result := Result + '   (SELECT GROUP_CONCAT(BAR_CODBAR) ';
  Result := Result + '    FROM ITEBAR ';
  Result := Result + '    WHERE I.ITE_CODITE = BAR_CODITE) AS ITE_CODBAR, ';

  Result := Result + '   CAST((SELECT GROUP_CONCAT(BAR_CODBAR) ';
  Result := Result + '    FROM ITEBAR ';
  Result := Result + '    WHERE I.ITE_CODITE = BAR_CODITE) AS CHAR(254)) AS ITE_EMBALA, ';


  Result := Result + '   CONCAT("(", CAST((SELECT GROUP_CONCAT(CONCAT(ITB_QTDEMB, ",", ITB_DESCON, ",", COALESCE(NULLIF(ITB_TABPRE, ""),"TODAS"))SEPARATOR "),(" ) ';
  Result := Result + '    FROM ITEEMB ';
  Result := Result + '    WHERE I.ITE_CODITE = ITB_CODITE AND I.ITE_CODEMP = ITB_CODEMP) AS CHAR(254)),")") AS ITE_ITEEMB, ';

  Result := Result + '   CAST("" AS CHAR(255)) AS ITE_ITEEMB_NOV, ';


  Result := Result + ' CAST("" AS CHAR(254)) AS ITE_EMBALA_NOV, ';

  Result := Result + ' 0 AS MARCADO, ';

  Result := Result + ' (SELECT SUM(ROUND(S.ITE_SALDOS + (IFNULL(S.ITE_SAL_ML, 0) / IF(ITE_CNV_ML IS NULL OR ITE_CNV_ML = 0, 1, ITE_CNV_ML)), 4)) FROM ITEGER S WHERE S.ITE_CODITE = G.ITE_CODITE)' + ' AS SALDOS, ';

  If blnUsaQtdPen Then
    Result := Result + ' (SELECT SUM(ROUND( IFNULL(S.ITE_QTEF_A, 0) +  IFNULL(S.ITE_QTEF_F, 0) + IFNULL(S.ITE_QTEF_P, 0) + IFNULL(S.ITE_QTPDBF, 0), 4)) FROM ITEGER S WHERE S.ITE_CODITE = G.ITE_CODITE)' + ' AS ENTFUT, ';

  pAddCampoSQL('CPRCEN', 'I', '', True);
  pAddCampoSQL('RECDEV', 'G', '', True, True);
  pAddCampoSQL('VALOBR', 'I', '', True, True);
  pAddCampoSQL('COMPOS', 'I', '', True, True);
  pAddCampoSQL('ITESAC', 'I', '', True, True);
  pAddCampoSQL('PAISOR', 'I', '', True, True);
  pAddCampoSQL('CODATC', 'G');

  pAddCampoSQL('MARID1', 'G', '', True, True);
  pAddCampoSQL('MARID2', 'G', '', True, True);
  pAddCampoSQL('MARID3', 'G', '', True, True);
  pAddCampoSQL('MARID4', 'G', '', True, True);
  pAddCampoSQL('MARID5', 'G', '', True, True);
  pAddCampoSQL('MARID6', 'G', '', True, True);
  pAddCampoSQL('MARID7', 'G', '', True, True);

  if fCfgSis('UTPEST', varBoolean) then
  begin
    pAddCampoSQL('QTDPES', 'I', '', True, True);
    pAddCampoSQL('PORPES', 'I', '', True, True);
  end;

  pAddCampoSQL('NUMFCI', 'I');

  if fCfgSis('UNITRI', varBoolean) then
    pAddCampoSQL('FATUTR', 'I');

  If blnURapel Then
    pAddCampoSQL('PRAPEL', 'I');

  pAddCampoSQL('PER_CI', 'I', '', True, False);
  
end;

function TfrmImportCadProduto.fValidaMargem(intTabPreco: Integer; cdsIte: TZClient; objPrecos: TArrRecPrecos): Boolean;
begin
  Result := cdsIte.FieldByName('ITE_IMPFED_NOV').AsFloat +
            cdsIte.FieldByName('ITE_DESOPE_NOV').AsFloat +
            cdsIte.FieldByName('ITE_ICMSAI_NOV').AsFloat +
            IIF(fCfgSis('PCMPRO') = '2', cdsIte.FieldByName('ITE_COMTB' + intToStr(intTabPreco)).AsFloat, 0) +
            IIF(fCfgSis('MARMKP') = '1', objPrecos[intTabPreco].fltMarBru, 0) <= 100;
end;

function TfrmImportCadProduto.fValidarChecklistGarantiaMercadoria(strValor: Variant; inLinhaAtual: Integer;
  var strMensagem: string): boolean;
  Var
    lstrValor: String;
begin
  lstrValor := VarToStrDef(strValor, '');
  Result := TCheckListGarantiaController.fValidaImportacaoCklGar(lstrValor, inLinhaAtual, strMensagem);
end;

function TfrmImportCadProduto.fValidarChecklistTrocaMercadoria(strValor: Variant; inLinhaAtual: Integer;
  var strMensagem: string): boolean;
  Var
    lstrValor: String;
begin
  lstrValor := VarToStrDef(strValor, '');
  Result := TCheckListGarantiaController.fValidaImportacaoCklTro(lstrValor, inLinhaAtual, strMensagem);
end;

function TfrmImportCadProduto.fValidaTipoProdutoSped(strValor: String; inLinhaAtual: integer; var strMensagem: string): boolean;
var
  intContador: Integer;
begin
  Result := False;
  strMensagem := 'Código do tipo de produto sped ' + strValor + ' é inválido!';
  For intContador := Low(TIPO_PRODUTO_SPED) To High(TIPO_PRODUTO_SPED) Do
  Begin
    If TIPO_PRODUTO_SPED[intContador][0] = strValor Then
    Begin
      Result := True;
      strMensagem := '';
      Exit;
    End;
  End;
end;

function TfrmImportCadProduto.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If Not blnArqCsv Then
  Begin
    If Trim(Excel.Range[cCodIte + IntToStr(1)].Value) <> '' Then
      Result := not TryStrToInt(Trim(Excel.Range[cCodIte + IntToStr(1)].Value), intValDef)
    Else
      Result := False;
  End
  Else
  Begin
    If objValidaExcel.fGetValueCSV(0, cCODITE) <> '' Then
      Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCODITE)), intValDef)
    Else
      Result := False;
  End
end;

procedure TfrmImportCadProduto.pCriarCds;
  var
    strSQLEmbalagem,strSQLEmbaDescFech, strSQL_ESTMIN_ESTMAX, strSql: string;
    i: integer;
begin
  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);
  If Assigned(cdsItensEmbalagem) Then
    FreeAndNil(cdsItensEmbalagem);

  If Assigned(cdsItensEmbDescFech) Then
    FreeAndNil(cdsItensEmbDescFech);


  If Assigned(cdsESTMIN_ESTMAX) Then
     FreeAndNil(cdsESTMIN_ESTMAX);

  strSql := strSql + ('SELECT ');
  strSql := strSql + fSqlBase;
  strSql := strSql + (', CAST("" AS CHAR(1000)) AS DESEXC, ');
  strSql := strSql + (' 0 AS IMPORT,');
  strSql := strSql + (' 0 AS ALTPRE,');
  strSql := strSql + (' 0 AS SEMRED,');
  strSql := strSql + (' 0 AS ID,');

  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_ESMIDG,');
  if fCfgSis('MINPRO', varBoolean) then
    strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_TPESTM,');

  strSql := strSql + (' CAST("" AS CHAR(1000)) AS LIS_ESTMIN,');
  strSql := strSql + (' CAST("" AS CHAR(1000)) AS LIS_ESTMAX,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_SITPRO,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_ABVFIS,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_ABFPIS,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_ABFCOF,');

  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_CODFOR,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_CODFAB,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS LIS_CODCNA,');
  strSql := strSql + (' CAST("" AS CHAR(255)) AS ITE_EMBALA');
  strSql := strSql + (' FROM ITEGER G');
  strSql := strSql + (' LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE AND B.BAR_CODEMP = G.ITE_CODEMP');
  strSql := strSql + ('  LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
  strSql := strSql + ('  LEFT JOIN DESSIT S ON S.ITE_CODITE = G.ITE_CODITE');
  strSql := strSql + ('  LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = I.ITE_CODUNI');
  strSql := strSql + ('  WHERE FALSE');
  // destruido no destoy do forme ou se chamar esta procedure novamente.
  cdsItens := TZClient.Create(Self, strSql);

  cdsItens.fAbreClient(True,'[TfrmImportCadProduto.pCriarCds]');

  cdsItens.LogChanges := False;

  strSQLEmbalagem := '';

  strSQLEmbalagem := strSQLEmbalagem + 'SELECT BAR_CODBAR, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_CODFOR, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_EMBALA, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_PREVEN, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_DESCRI, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_TABPRE, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_PRINCI, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_COMPRA, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_EXBFAT, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_ALTURA, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_LARGUR, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_PROFUN, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_LASTRO, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_CAMADA, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_EMPMAX, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_PESOBR, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_PESOLQ, ';
  strSQLEmbalagem := strSQLEmbalagem + '    BAR_PRINCI AS BAR_GERAUT, ';
  strSQLEmbalagem := strSQLEmbalagem + '    0 AS ID ';
  strSQLEmbalagem := strSQLEmbalagem + ' FROM ITEBAR ';
  strSQLEmbalagem := strSQLEmbalagem + ' WHERE FALSE ';

  cdsItensEmbalagem := TZClient.Create(Self, strSQLEmbalagem);
  cdsItensEmbalagem.fAbreClient(True,'[TfrmImportCadProduto.pCriarCds]');


  strSQLEmbaDescFech := '';

  strSQLEmbaDescFech := strSQLEmbaDescFech + 'SELECT ITB_CODEMP, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    ITB_CODEMP, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    ITB_CODITE, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    ITB_DESCON, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    ITB_PRIROM, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    ITB_QTDEMB, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    ITB_TABPRE, ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + '    0 AS ID ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + ' FROM ITEEMB ';
  strSQLEmbaDescFech := strSQLEmbaDescFech + ' WHERE FALSE ';

  cdsItensEmbDescFech := TZClient.Create(Self, strSQLEmbaDescFech);
  cdsItensEmbDescFech.fAbreClient(True,'[TfrmImportCadProduto.pCriarCds]');

  strSQL_ESTMIN_ESTMAX := '';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  'SELECT ITE_CODEMP, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ESTMIN, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ESTMAX, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ESTMAX AS ITE_ESTMIN_OLD, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ESTMAX AS ITE_ESTMAX_OLD, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_SITPRO, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_CODABF, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ABFPIS, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ABFCOF, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_TPESTM, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_NIVCRI, ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '       ITE_ESMIDG, 0 AS ID ';
  strSQL_ESTMIN_ESTMAX := strSQL_ESTMIN_ESTMAX +  '  FROM ITEGER WHERE FALSE';

  cdsESTMIN_ESTMAX := TZClient.Create(Self, strSQL_ESTMIN_ESTMAX);
  cdsESTMIN_ESTMAX.fAbreClient(True,'[TfrmImportCadProduto.pCriarCds]');

  cdsESTMIN_ESTMAX.IndexFieldNames := 'ID;ITE_CODEMP';


  {Formata os campos usando format #,##0.00}
  pFormatarCampo('DESF01', True);
  pFormatarCampo('DESF02', True);
  pFormatarCampo('DESF03', True);
  pFormatarCampo('DESF04', True);
  pFormatarCampo('DESF05', True);
  pFormatarCampo('DESF06', True);
  pFormatarCampo('ICMENT', True);
  pFormatarCampo('SUBFED', True);
  pFormatarCampo('IPIENT', True);
  pFormatarCampo('FREENT', True);
  pFormatarCampo('VALFRE', True);
  pFormatarCampo('ACRFIN', True);
  pFormatarCampo('SUBSTI', True);
  pFormatarCampo('DESADB', True);
  pFormatarCampo('ICMSAI', True);
  pFormatarCampo('IMPFED', True);
  pFormatarCampo('OUTVAL', True);
  pFormatarCampo('DESOPE', True);
  pFormatarCampo('PRECOM', True);
  pFormatarCampo('EXPALT', True);
  pFormatarCampo('EXPLAR', True);
  pFormatarCampo('EXPPRO', True);
  pFormatarCampo('DESSIT', True);
  pFormatarCampo('TCIFCU', True);
  pFormatarCampo('TSCUST', True);
  pFormatarCampo('DEPICO', True);
  pFormatarCampo('DEICMS', True);
  pFormatarCampo('FATREG', True);

  for i := 1 To 7 do
  Begin
    pFormatarCampo('COMTB' + IntToStr(i), True);
    pFormatarCampo('PREVE' + IntToStr(i), True);
    pFormatarCampo('MARBR' + IntToStr(i), True);
    pFormatarCampo('MARID' + IntToStr(i), True);
  End;

  if fCfgSis('UTPEST', varBoolean) then
  begin
    pFormatarCampo('QTDPES', True);
    pFormatarCampo('PORPES', True);
  end;

  if fCfgSis('UNITRI', varBoolean) then
    pFormatarCampo('FATUTR', True);

  If blnURapel Then
    pFormatarCampo('PRAPEL', True);
end;

procedure TfrmImportCadProduto.pFormatarCampo(strCampo: string; blnTem_ITE: boolean = False);
begin
  if not blnTem_ITE then
  Begin
    (cdsItens.FieldByName(strCampo) as TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('ITE_' + strCampo + '_NOV') as TFloatField).DisplayFormat := '#,##0.00';
  end
  Else
  Begin
    (cdsItens.FieldByName('ITE_' + strCampo) as TFloatField).DisplayFormat := '#,##0.00';
    (cdsItens.FieldByName('ITE_' + strCampo + '_NOV') as TFloatField).DisplayFormat := '#,##0.00';
  End

end;

procedure TfrmImportCadProduto.pInsereItensCDS(intLinha: integer);
  var
    intEmbalagem,
    i: integer;
    strMensagem,
    strErro,
    strCodIte,
    strCodBar,
    strCodFor,
    strCodFab,
    strDesite,
    strDuplicados,
    strTabelasTABPRC: String;
    strIteAti: String;
    arrCampoEmbalagem: TCampoEmbalagemArr;
    arrIteEmbalagemArr: TCampoIteEmbalagemArr;

    TipoPesquisa: TTipoPesquisa;
    fltFatEmb: Double;

  function fValidaCampoDefaut(cCampo, strCampo: string): Boolean;
  begin
    Result := True;
    If (SameText(cITEBAS, cCampo)) And (cdsItens.FieldByName('ITE_ITEBAS').AsString <> '') Then
      cdsItens.FieldByName(strCampo).Value := cdsItens.FieldByName('ITE_ITEBAS').AsString
    Else If (SameText(cITEPIG, cCampo)) And (cdsItens.FieldByName('ITE_ITEPIG').AsString <> '') Then
      cdsItens.FieldByName(strCampo).Value := cdsItens.FieldByName('ITE_ITEPIG').AsString
    Else If (SameText(cBAREXP, cCampo)) And (cdsItens.FieldByName('ITE_BAREXP').AsString <> '') Then
      cdsItens.FieldByName(strCampo).Value := cdsItens.FieldByName('ITE_BAREXP').AsString
    Else If (SameText(cITEBAS, cCampo)) Or (SameText(cITEPIG, cCampo)) Then
      cdsItens.FieldByName(strCampo).Value := 'N'
    Else If (SameText(cBAREXP, cCampo)) Then
      cdsItens.FieldByName(strCampo).Value := 'S'
    Else
      Result := False;
  End;

  procedure fAtualizaCDSItens(cCampo, strCampo: string; blnFloat: boolean = False);
  begin
    If Not fEmptyStr(Excel.Range[cCampo + IntToStr(intLinha)].Text) Then
    Begin
      If blnFloat Then
        cdsItens.FieldByName(strCampo).AsFloat := fFormataFloat(Excel.Range[cCampo + IntToStr(intLinha)].Value, intDecUni)
      Else
        cdsItens.FieldByName(strCampo).Value := Excel.Range[cCampo + IntToStr(intLinha)].Value
      End
    Else If Not fValidaCampoDefaut(cCampo,strCampo) Then
      cdsItens.FieldByName(strCampo).Value   := Null;
  end;

begin
   fltfatemb := 0;
   TipoPesquisa := pesNenhuma;
   strTabelasTABPRC:= fCfgSis('TABPRC', varString);
   pGetCodigos(strCodIte, strCodBar, strCodFor, strCodFab, strIteAti,strDesIte, intLinha);


   Try
     strErro := '';

     If (strCodIte + strCodBar + strCodFor +  strCodFab) = '' then
     Begin
       strErro := 'Sem identificador para localizar o item, informar: Código do Item ( Coluna A ) ou Código de Barras ( Coluna B ) ou Código do Fornecedor + Código de Fábrica ( Coluna D + Coluna C )  ';
     End;

     If (Not fEmptyStr(strCodFab)) And (Not fEmptyStr(strCodFor)) And
        cdsItens.Locate('ITE_CODFAB_NOV;ITE_CODFOR_NOV', VarArrayOf([strCodFab, strCodFor]), []) Then
     Begin
       strErro := 'Registro com Código de Fábrica e Fornecedor duplicado nessa panilha. ';
     End;

     If (Not fEmptyStr(strCodBar)) And
        cdsItens.Locate('ITE_CODBAR_NOV', strCodBar, []) Then
     Begin
       strErro := strErro + 'Registro com Código de Barras duplicado nessa panilha. ';
     End;

     cdsItens.Insert;

     cdsItens.FieldByName('ID').AsInteger := intSequencial;

     cdsItens.FieldByName('DESEXC').AsString := '';

     If Not fEmptyStr(strErro) Then
     Begin

       cdsItens.FieldByName('DESEXC').AsString := strErro;
       cdsItens.FieldByName('IMPORT').AsInteger := 2;


     End
     Else If fLocalizaItemIteger(qryItensEncontrados, intLinha, strErro, TipoPesquisa) Then
     Begin

       For i := 0 to qryItensEncontrados.Fields.Count -1 do
         cdsItens.FieldByName(qryItensEncontrados.Fields[i].FieldName).Value := qryItensEncontrados.Fields[i].Value;

       { Para exitir o campo na função fIncluirPreIte }
       cdsItens.FieldByName('IMPORT').AsInteger := 1;

       If Not fEmptyStr(strErro) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End
       Else If fEmptyStr(strCodIte) And (Not fEmptyStr(qryItensEncontrados.FieldbyName('ITE_CODITE').AsString)) Then
       Begin
         strCodIte := qryItensEncontrados.FieldbyName('ITE_CODITE').AsString;
       End;

     End
     Else
     Begin
       If (strCodIte + strCodBar + strCodFor +  strCodFab) <> '' then
       begin
         //Caso não utilizar procod para  cadite e não tiver o codigo cadastrado então retorna como erro
         cdsItens.FieldByName('IMPORT').AsInteger := 0
       end
       else
       begin
         cdsItens.Cancel;
         exit;
       end;

     End;

     If Not blnArqCsv Then
     Begin
       fAtualizaCDSItens(cCODBAR, 'ITE_CODBAR_NOV');
       fAtualizaCDSItens(cCODFOR, 'ITE_CODFOR_NOV');
       fAtualizaCDSItens(cCODFAB, 'ITE_CODFAB_NOV');

       fAtualizaCDSItens(cCODDEP, 'ITE_CODDEP_NOV');
       fAtualizaCDSItens(cCODGRU, 'ITE_CODGRU_NOV');
       fAtualizaCDSItens(cDESITE, 'ITE_DESITE_NOV');
       fAtualizaCDSItens(cDESSIM, 'ITE_DESSIM_NOV');
       fAtualizaCDSItens(cDESFAB, 'ITE_DESFAB_NOV');
       fAtualizaCDSItens(cCODMAR, 'ITE_CODMAR_NOV');
       fAtualizaCDSItens(cREFERE, 'ITE_REFERE_NOV');
       fAtualizaCDSItens(cCODUNI, 'ITE_CODUNI_NOV');
       fAtualizaCDSItens(cUNICOM, 'ITE_UNICOM_NOV');
       fAtualizaCDSItens(cCODABF, 'ITE_CODABF_NOV');
       fAtualizaCDSItens(cABFPIS, 'ITE_ABFPIS_NOV');
       fAtualizaCDSItens(cABFCOF, 'ITE_ABFCOF_NOV');
       fAtualizaCDSItens(cABFIPI, 'ITE_ABFIPI_NOV');
       fAtualizaCDSItens(cIPISAI, 'ITE_IPISAI_NOV');
       fAtualizaCDSItens(cINCPIS, 'ITE_INCPIS_NOV');
       fAtualizaCDSItens(cCLAIPI, 'ITE_CLAIPI_NOV');
       fAtualizaCDSItens(cEXCIPI, 'ITE_EXCIPI_NOV');
       fAtualizaCDSItens(cCDCEST, 'ITE_CDCEST_NOV');
       fAtualizaCDSItens(cCODONU, 'ITE_CODONU_NOV');
       fAtualizaCDSItens(cIMPLIS, 'ITE_IMPLIS_NOV');
       fAtualizaCDSItens(cITEATI, 'ITE_ITEATI_NOV');
       fAtualizaCDSItens(cATICOM, 'ITE_ATICOM_NOV');
       fAtualizaCDSItens(cPESOIT, 'ITE_PESOIT_NOV');
       fAtualizaCDSItens(cCODGPR, 'ITE_CODGPR_NOV');
       fAtualizaCDSItens(cPRDGRU, 'ITE_PRDGRU_NOV');
       fAtualizaCDSItens(cGRUCMP, 'ITE_GRUCMP_NOV');
       fAtualizaCDSItens(cMLTVEN, 'ITE_MLTVEN_NOV');
       fAtualizaCDSItens(cMLTCOM, 'ITE_MLTCOM_NOV');
       fAtualizaCDSItens(cNVLGIR, 'ITE_NVLGIR_NOV');
       fAtualizaCDSItens(cNIVGIR, 'ITE_NIVGIR_NOV');
       fAtualizaCDSItens(cNVLCRI, 'ITE_NVLCRI_NOV');

       fAtualizaCDSItens(cACOOBJ, 'ITE_ACOOBJ_NOV');
       fAtualizaCDSItens(cAPLICA, 'ITE_APLICA_NOV');
       fAtualizaCDSItens(cPRECOM, 'ITE_PRECOM_NOV', True);
       fAtualizaCDSItens(cDESF01, 'ITE_DESF01_NOV', True);
       fAtualizaCDSItens(cDESF02, 'ITE_DESF02_NOV', True);
       fAtualizaCDSItens(cDESF03, 'ITE_DESF03_NOV', True);
       fAtualizaCDSItens(cDESF04, 'ITE_DESF04_NOV', True);
       fAtualizaCDSItens(cDESF05, 'ITE_DESF05_NOV', True);
       fAtualizaCDSItens(cDESF06, 'ITE_DESF06_NOV', True);
       fAtualizaCDSItens(cICMENT, 'ITE_ICMENT_NOV');
       fAtualizaCDSItens(cSUBFED, 'ITE_SUBFED_NOV');
       fAtualizaCDSItens(cIPIENT, 'ITE_IPIENT_NOV');
       fAtualizaCDSItens(cFREENT, 'ITE_FREENT_NOV');
       fAtualizaCDSItens(cVALFRE, 'ITE_VALFRE_NOV');
       fAtualizaCDSItens(cACRFIN, 'ITE_ACRFIN_NOV');
       fAtualizaCDSItens(cSUBSTI, 'ITE_SUBSTI_NOV');
       fAtualizaCDSItens(cDESADB, 'ITE_DESADB_NOV');
       fAtualizaCDSItens(cOUTVAL, 'ITE_OUTVAL_NOV');
       fAtualizaCDSItens(cICMSAI, 'ITE_ICMSAI_NOV');
       fAtualizaCDSItens(cIMPFED, 'ITE_IMPFED_NOV');
       fAtualizaCDSItens(cDESOPE, 'ITE_DESOPE_NOV');
       fAtualizaCDSItens(cMARBR1, 'ITE_MARBR1_NOV', True);
       fAtualizaCDSItens(cCOMTB1, 'ITE_COMTB1_NOV', True);
       fAtualizaCDSItens(cPREVE1, 'ITE_PREVE1_NOV', True);
       fAtualizaCDSItens(cMARBR2, 'ITE_MARBR2_NOV', True);
       fAtualizaCDSItens(cCOMTB2, 'ITE_COMTB2_NOV', True);
       fAtualizaCDSItens(cPREVE2, 'ITE_PREVE2_NOV', True);
       fAtualizaCDSItens(cMARBR3, 'ITE_MARBR3_NOV', True);
       fAtualizaCDSItens(cCOMTB3, 'ITE_COMTB3_NOV', True);
       fAtualizaCDSItens(cPREVE3, 'ITE_PREVE3_NOV', True);
       fAtualizaCDSItens(cMARBR4, 'ITE_MARBR4_NOV', True);
       fAtualizaCDSItens(cCOMTB4, 'ITE_COMTB4_NOV', True);
       fAtualizaCDSItens(cPREVE4, 'ITE_PREVE4_NOV', True);
       fAtualizaCDSItens(cMARBR5, 'ITE_MARBR5_NOV', True);
       fAtualizaCDSItens(cCOMTB5, 'ITE_COMTB5_NOV', True);
       fAtualizaCDSItens(cPREVE5, 'ITE_PREVE5_NOV', True);
       fAtualizaCDSItens(cMARBR6, 'ITE_MARBR6_NOV', True);
       fAtualizaCDSItens(cCOMTB6, 'ITE_COMTB6_NOV', True);
       fAtualizaCDSItens(cPREVE6, 'ITE_PREVE6_NOV', True);
       fAtualizaCDSItens(cMARBR7, 'ITE_MARBR7_NOV', True);
       fAtualizaCDSItens(cCOMTB7, 'ITE_COMTB7_NOV', True);
       fAtualizaCDSItens(cPREVE7, 'ITE_PREVE7_NOV', True);
       fAtualizaCDSItens(cCOMVAR, 'ITE_COMVAR_NOV');
       fAtualizaCDSItens(cCOMATA, 'ITE_COMATA_NOV');
       fAtualizaCDSItens(cCOMDIS, 'ITE_COMDIS_NOV');
       fAtualizaCDSItens(cCOMPRO, 'ITE_COMPRO_NOV');
       fAtualizaCDSItens(cDESMAX, 'ITE_DESMAX_NOV');
       fAtualizaCDSItens(cDESMSU, 'ITE_DESMSU_NOV');
       fAtualizaCDSItens(cDESMGE, 'ITE_DESMGE_NOV');
       fAtualizaCDSItens(cMARMIN, 'ITE_MARMIN_NOV');
       fAtualizaCDSItens(cMARMSG, 'ITE_MARMSG_NOV');
       fAtualizaCDSItens(cMARMGE, 'ITE_MARMGE_NOV');
       fAtualizaCDSItens(cTMPGAR, 'ITE_TMPGAR_NOV');
       fAtualizaCDSItens(cINFGAR, 'ITE_INFGAR_NOV');
       fAtualizaCDSItens(cLOCFIS, 'ITE_LOCFIS_NOV');
       fAtualizaCDSItens(cLOCSUP, 'ITE_LOCSUP_NOV');

       fAtualizaCDSItens(cITEBAS, 'ITE_ITEBAS_NOV');
       fAtualizaCDSItens(cITEPIG, 'ITE_ITEPIG_NOV');
       fAtualizaCDSItens(cBAREXP, 'ITE_BAREXP_NOV');

       fAtualizaCDSItens(cCPRCEN, 'ITE_CPRCEN_NOV');
       fAtualizaCDSItens(cCODMON, 'ITE_CODMON_NOV');
       fAtualizaCDSItens(cPESLIQ, 'ITE_PESLIQ_NOV');
       fAtualizaCDSItens(cCODLSE, 'ITE_CODLSE_NOV');
       fAtualizaCDSItens(cDIAFOR, 'ITE_DIAFOR_NOV');

       //Dados E-Commerce
       fAtualizaCDSItens(cEXPSIT, 'ITE_EXPSIT_NOV');
       fAtualizaCDSItens(cDSSITE, 'ITE_DESITE_SITE_NOV');
       fAtualizaCDSItens(cDADTEC, 'ITE_DADTEC_NOV');
       fAtualizaCDSItens(cURLIMG, 'ITE_URLIMG_NOV');
       fAtualizaCDSItens(cNOMITE, 'ITE_NOMITE_NOV');
       fAtualizaCDSItens(cAPLITE, 'ITE_APLITE_NOV');
       fAtualizaCDSItens(cINCLUS, 'ITE_INCLUS_NOV');
       fAtualizaCDSItens(cEXPALT, 'ITE_EXPALT_NOV');
       fAtualizaCDSItens(cEXPLAR, 'ITE_EXPLAR_NOV');
       fAtualizaCDSItens(cEXPPRO, 'ITE_EXPPRO_NOV');
       fAtualizaCDSItens(cDESSIT, 'ITE_DESSIT_NOV');
       fAtualizaCDSItens(cCODCAT, 'ITE_CODCAT_NOV');
       fAtualizaCDSItens(cDESTAQ, 'ITE_DESTAQ_NOV');
       fAtualizaCDSItens(cATZPRE, 'ITE_ATZPRE_NOV');
       fAtualizaCDSItens(cEXPAPP, 'ITE_EXPAPP_NOV');

       fAtualizaCDSItens(cTCIFCU, 'ITE_TCIFCU_NOV');
       fAtualizaCDSItens(cTSCUST, 'ITE_TSCUST_NOV');
       fAtualizaCDSItens(cDEPICO, 'ITE_DEPICO_NOV');
       fAtualizaCDSItens(cDEICMS, 'ITE_DEICMS_NOV');
       fAtualizaCDSItens(cFATREG, 'ITE_FATREG_NOV');

       fAtualizaCDSItens(cEMBALA, 'ITE_EMBALA_NOV');
       fAtualizaCDSItens(cITEEMB, 'ITE_ITEEMB_NOV');
       fAtualizaCDSItens(cUNITRI, 'ITE_UNITRI_NOV');
       fAtualizaCDSItens(cEXPPOK, 'ITE_EXPPOK_NOV');
       fAtualizaCDSItens(cTIPPRO, 'ITE_TIPPRO_NOV');
       fAtualizaCDSItens(cINDREV, 'ITE_INDREV_NOV');
       fAtualizaCDSItens(cIMPDIR, 'ITE_IMPDIR_NOV');

       fAtualizaCDSItens(cMSGLV1, 'ITE_MSGLV1_NOV');
       fAtualizaCDSItens(cMSGLV2, 'ITE_MSGLV2_NOV');
       fAtualizaCDSItens(cPEEFUT, 'ITE_PEEFUT_NOV');
       fAtualizaCDSItens(cPEFUTP, 'ITE_PEFUTP_NOV');
       fAtualizaCDSItens(cPEFFPR, 'ITE_PEFFPR_NOV');

       fAtualizaCDSItens(cTIPFRE, 'ITE_TIPFRE_NOV');
       fAtualizaCDSItens(cVLCFRE, 'ITE_VLCFRE_NOV');
       fAtualizaCDSItens(cQRCODE, 'ITE_QRCODE_NOV');
       fAtualizaCDSItens(cEXPB2B, 'ITE_EXPB2B_NOV');
       fAtualizaCDSItens(cPRAVAL, 'ITE_PRAVAL_NOV');
       fAtualizaCDSItens(cRECDEV, 'ITE_RECDEV_NOV');
       fAtualizaCDSItens(cVALOBR, 'ITE_VALOBR_NOV');
       fAtualizaCDSItens(cCOMPOS, 'ITE_COMPOS_NOV');
       fAtualizaCDSItens(cITESAC, 'ITE_ITESAC_NOV');
       fAtualizaCDSItens(cPAISOR, 'ITE_PAISOR_NOV');
       fAtualizaCDSItens(cCODATC, 'ITE_CODATC_NOV');

       fAtualizaCDSItens(cMARGE1, 'ITE_MARID1_NOV');
       fAtualizaCDSItens(cMARGE2, 'ITE_MARID2_NOV');
       fAtualizaCDSItens(cMARGE3, 'ITE_MARID3_NOV');
       fAtualizaCDSItens(cMARGE4, 'ITE_MARID4_NOV');
       fAtualizaCDSItens(cMARGE5, 'ITE_MARID5_NOV');
       fAtualizaCDSItens(cMARGE6, 'ITE_MARID6_NOV');
       fAtualizaCDSItens(cMARGE7, 'ITE_MARID7_NOV');

       fAtualizaCDSItens(cSOBENC, 'ITE_SOBENC_NOV');

       if fCfgSis('UTPEST', varBoolean) then
       begin
         fAtualizaCDSItens(cQTDPES, 'ITE_QTDPES_NOV');
         fAtualizaCDSItens(cPORPES, 'ITE_PORPES_NOV');
       end;

       fAtualizaCDSItens(cMLTRCA, 'ITE_MLTRCA_NOV');

       fAtualizaCDSItens(cPER_CI, 'ITE_PER_CI');
       fAtualizaCDSItens(cNUMFCI, 'ITE_NUMFCI');

       if fCfgSis('UNITRI', varBoolean) then
         fAtualizaCDSItens(cNUMFCI, 'ITE_FATUTR');

       If blnURapel Then
         fAtualizaCDSItens(cPRAPEL, 'ITE_PRAPEL_NOV');

       fAtualizaCDSItens(cCEREPI, 'ITE_CEREPI_NOV');

       if fCfgSis('MARPAD', varBoolean) then
        fAtualizaCDSItens(cMARPAD, 'ITE_MARPAD_NOV');
     End
     Else
     Begin
       If (TipoPesquisa <> pesIteForCodFab) Then
         cdsItens.FieldByName('ITE_CODFAB_NOV').Value := IIf(fCampoAltera(cCODFAB), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODFAB)), Null);
       cdsItens.FieldByName('ITE_CODBAR_NOV').Value := IIf(fCampoAltera(cCODBAR), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODBAR)), Null);
       If (TipoPesquisa <> pesIteForCodFab) Then
         cdsItens.FieldByName('ITE_CODFOR_NOV').Value := IIf(fCampoAltera(cCODFOR), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODFOR)), Null);

       cdsItens.FieldByName('ITE_CODDEP_NOV').Value := IIf(fCampoAltera(cCODDEP), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODDEP)), Null);
       cdsItens.FieldByName('ITE_CODGRU_NOV').Value := IIf(fCampoAltera(cCODGRU), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODGRU)), Null);

       cdsItens.FieldByName('ITE_DESITE_NOV').Value := IIf(fCampoAltera(cDESITE), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESITE)), Null);
       cdsItens.FieldByName('ITE_DESSIM_NOV').Value := IIf(fCampoAltera(cDESSIM), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESSIM)), Null);

       cdsItens.FieldByName('ITE_DESFAB_NOV').Value := IIf(fCampoAltera(cDESFAB),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESFAB)), Null);
       cdsItens.FieldByName('ITE_CODMAR_NOV').Value := IIf(fCampoAltera(cCODMAR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODMAR)), Null);
       cdsItens.FieldByName('ITE_REFERE_NOV').Value := IIf(fCampoAltera(cREFERE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cREFERE)), Null);
       cdsItens.FieldByName('ITE_CODUNI_NOV').Value := IIf(fCampoAltera(cCODUNI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODUNI)), Null);
       cdsItens.FieldByName('ITE_UNICOM_NOV').Value := IIf(fCampoAltera(cUNICOM),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cUNICOM)), Null);
       cdsItens.FieldByName('ITE_CODABF_NOV').Value := IIf(fCampoAltera(cCODABF),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODABF)), Null);
       cdsItens.FieldByName('ITE_ABFPIS_NOV').Value := IIf(fCampoAltera(cABFPIS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cABFPIS)), Null);
       cdsItens.FieldByName('ITE_ABFCOF_NOV').Value := IIf(fCampoAltera(cABFCOF),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cABFCOF)), Null);
       cdsItens.FieldByName('ITE_ABFIPI_NOV').Value := IIf(fCampoAltera(cABFIPI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cABFIPI)), Null);
       cdsItens.FieldByName('ITE_IPISAI_NOV').Value := IIf(fCampoAltera(cIPISAI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIPISAI)), Null);
       cdsItens.FieldByName('ITE_INCPIS_NOV').Value := IIf(fCampoAltera(cINCPIS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cINCPIS)), Null);
       cdsItens.FieldByName('ITE_CLAIPI_NOV').Value := IIf(fCampoAltera(cCLAIPI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCLAIPI)), Null);
       cdsItens.FieldByName('ITE_EXCIPI_NOV').Value := IIf(fCampoAltera(cEXCIPI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cEXCIPI)), Null);
       cdsItens.FieldByName('ITE_CDCEST_NOV').Value := IIf(fCampoAltera(cCDCEST),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCDCEST)), Null);
       cdsItens.FieldByName('ITE_CODONU_NOV').Value := IIf(fCampoAltera(cCODONU),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODONU)), Null);
       cdsItens.FieldByName('ITE_IMPLIS_NOV').Value := IIf(fCampoAltera(cIMPLIS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIMPLIS)), Null);
       cdsItens.FieldByName('ITE_ITEATI_NOV').Value := IIf(fCampoAltera(cITEATI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cITEATI)), Null);
       cdsItens.FieldByName('ITE_ATICOM_NOV').Value := IIf(fCampoAltera(cATICOM),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cATICOM)), Null);
       cdsItens.FieldByName('ITE_PESOIT_NOV').Value := IIf(fCampoAltera(cPESOIT),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPESOIT)), Null);
       cdsItens.FieldByName('ITE_CODGPR_NOV').Value := IIf(fCampoAltera(cCODGPR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODGPR)), Null);
       cdsItens.FieldByName('ITE_PRDGRU_NOV').Value := IIf(fCampoAltera(cPRDGRU),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPRDGRU)), Null);
       cdsItens.FieldByName('ITE_GRUCMP_NOV').Value := IIf(fCampoAltera(cGRUCMP),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cGRUCMP)), Null);
       cdsItens.FieldByName('ITE_MLTVEN_NOV').Value := IIf(fCampoAltera(cMLTVEN),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMLTVEN)), Null);
       cdsItens.FieldByName('ITE_MLTCOM_NOV').Value := IIf(fCampoAltera(cMLTCOM),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMLTCOM)), Null);
       cdsItens.FieldByName('ITE_NVLGIR_NOV').Value := IIf(fCampoAltera(cNVLGIR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNVLGIR)), Null);
       cdsItens.FieldByName('ITE_NIVGIR_NOV').Value := IIf(fCampoAltera(cNIVGIR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNIVGIR)), Null);
       cdsItens.FieldByName('ITE_NVLCRI_NOV').Value := IIf(fCampoAltera(cNVLCRI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNVLCRI)), Null);

       cdsItens.FieldByName('ITE_ACOOBJ_NOV').Value := IIf(fCampoAltera(cACOOBJ),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cACOOBJ)), Null);
       cdsItens.FieldByName('ITE_APLICA_NOV').Value := IIf(fCampoAltera(cAPLICA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cAPLICA)), Null);
       cdsItens.FieldByName('ITE_PRECOM_NOV').Value := IIf(fCampoAltera(cPRECOM, False, 'cPRECOM'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPRECOM)), Null);

       If (ChkNaoReduzirPrecoCompra.Checked)  Then
          If (cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat < cdsItens.FieldByName('ITE_PRECOM').AsFloat) and (cdsItens.FieldByName('SALDOS').Value > 0)  Then
             cdsItens.FieldByName('SEMRED').Value:= 1;

       cdsItens.FieldByName('ITE_DESF01_NOV').Value := IIf(fCampoAltera(cDESF01, False, 'cDESF01'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESF01)), Null);
       cdsItens.FieldByName('ITE_DESF02_NOV').Value := IIf(fCampoAltera(cDESF02, False, 'cDESF02'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESF02)), Null);
       cdsItens.FieldByName('ITE_DESF03_NOV').Value := IIf(fCampoAltera(cDESF03, False, 'cDESF03'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESF03)), Null);
       cdsItens.FieldByName('ITE_DESF04_NOV').Value := IIf(fCampoAltera(cDESF04, False, 'cDESF04'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESF04)), Null);
       cdsItens.FieldByName('ITE_DESF05_NOV').Value := IIf(fCampoAltera(cDESF05, False, 'cDESF05'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESF05)), Null);
       cdsItens.FieldByName('ITE_DESF06_NOV').Value := IIf(fCampoAltera(cDESF06, False, 'cDESF06'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESF06)), Null);
       cdsItens.FieldByName('ITE_ICMENT_NOV').Value := IIf(fCampoAltera(cICMENT, False, 'cICMENT'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cICMENT)), Null);
       cdsItens.FieldByName('ITE_SUBFED_NOV').Value := IIf(fCampoAltera(cSUBFED, False, 'cSUBFED'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cSUBFED)), Null);
       cdsItens.FieldByName('ITE_IPIENT_NOV').Value := IIf(fCampoAltera(cIPIENT, False, 'cIPIENT'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIPIENT)), Null);
       cdsItens.FieldByName('ITE_FREENT_NOV').Value := IIf(fCampoAltera(cFREENT, False, 'cFREENT'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cFREENT)), Null);
       cdsItens.FieldByName('ITE_VALFRE_NOV').Value := IIf(fCampoAltera(cVALFRE, False, 'cVALFRE'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVALFRE)), Null);
       cdsItens.FieldByName('ITE_ACRFIN_NOV').Value := IIf(fCampoAltera(cACRFIN, False, 'cACRFIN'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cACRFIN)), Null);
       cdsItens.FieldByName('ITE_SUBSTI_NOV').Value := IIf(fCampoAltera(cSUBSTI, False, 'cSUBSTI'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cSUBSTI)), Null);
       cdsItens.FieldByName('ITE_DESADB_NOV').Value := IIf(fCampoAltera(cDESADB, False, 'cDESADB'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESADB)), Null);
       cdsItens.FieldByName('ITE_OUTVAL_NOV').Value := IIf(fCampoAltera(cOUTVAL, False, 'cOUTVAL'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cOUTVAL)), Null);
       cdsItens.FieldByName('ITE_ICMSAI_NOV').Value := IIf(fCampoAltera(cICMSAI, False, 'cICMSAI'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cICMSAI)), Null);
       cdsItens.FieldByName('ITE_IMPFED_NOV').Value := IIf(fCampoAltera(cIMPFED, False, 'cIMPFED'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIMPFED)), Null);
       cdsItens.FieldByName('ITE_DESOPE_NOV').Value := IIf(fCampoAltera(cDESOPE, False, 'cDESOPE'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESOPE)), Null);
       cdsItens.FieldByName('ITE_MARBR1_NOV').Value := IIf(fCampoAltera(cMARBR1, False, 'cMARBR1'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR1)), Null);
       cdsItens.FieldByName('ITE_COMTB1_NOV').Value := IIf(fCampoAltera(cCOMTB1, False, 'cCOMTB1'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB1)), Null);
       cdsItens.FieldByName('ITE_PREVE1_NOV').Value := IIf(fCampoAltera(cPREVE1, False, 'cPREVE1'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE1)), Null);
       cdsItens.FieldByName('ITE_MARBR2_NOV').Value := IIf(fCampoAltera(cMARBR2, False, 'cMARBR2'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR2)), Null);
       cdsItens.FieldByName('ITE_COMTB2_NOV').Value := IIf(fCampoAltera(cCOMTB2, False, 'cCOMTB2'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB2)), Null);
       cdsItens.FieldByName('ITE_PREVE2_NOV').Value := IIf(fCampoAltera(cPREVE2, False, 'cPREVE2'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE2)), Null);
       cdsItens.FieldByName('ITE_MARBR3_NOV').Value := IIf(fCampoAltera(cMARBR3, False, 'cMARBR3'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR3)), Null);
       cdsItens.FieldByName('ITE_COMTB3_NOV').Value := IIf(fCampoAltera(cCOMTB3, False, 'cCOMTB3'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB3)), Null);
       cdsItens.FieldByName('ITE_PREVE3_NOV').Value := IIf(fCampoAltera(cPREVE3, False, 'cPREVE3'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE3)), Null);
       cdsItens.FieldByName('ITE_MARBR4_NOV').Value := IIf(fCampoAltera(cMARBR4, False, 'cMARBR4'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR4)), Null);
       cdsItens.FieldByName('ITE_COMTB4_NOV').Value := IIf(fCampoAltera(cCOMTB4, False, 'cCOMTB4'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB4)), Null);
       cdsItens.FieldByName('ITE_PREVE4_NOV').Value := IIf(fCampoAltera(cPREVE4, False, 'cPREVE4'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE4)), Null);
       cdsItens.FieldByName('ITE_MARBR5_NOV').Value := IIf(fCampoAltera(cMARBR5, False, 'cMARBR5'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR5)), Null);
       cdsItens.FieldByName('ITE_COMTB5_NOV').Value := IIf(fCampoAltera(cCOMTB5, False, 'cCOMTB5'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB5)), Null);
       cdsItens.FieldByName('ITE_PREVE5_NOV').Value := IIf(fCampoAltera(cPREVE5, False, 'cPREVE5'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE5)), Null);
       cdsItens.FieldByName('ITE_MARBR6_NOV').Value := IIf(fCampoAltera(cMARBR6, False, 'cMARBR6'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR6)), Null);
       cdsItens.FieldByName('ITE_COMTB6_NOV').Value := IIf(fCampoAltera(cCOMTB6, False, 'cCOMTB6'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB6)), Null);
       cdsItens.FieldByName('ITE_PREVE6_NOV').Value := IIf(fCampoAltera(cPREVE6, False, 'cPREVE6'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE6)), Null);
       cdsItens.FieldByName('ITE_MARBR7_NOV').Value := IIf(fCampoAltera(cMARBR7, False, 'cMARBR7'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARBR7)), Null);
       cdsItens.FieldByName('ITE_COMTB7_NOV').Value := IIf(fCampoAltera(cCOMTB7, False, 'cCOMTB7'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMTB7)), Null);
       cdsItens.FieldByName('ITE_PREVE7_NOV').Value := IIf(fCampoAltera(cPREVE7, False, 'cPREVE7'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPREVE7)), Null);
       cdsItens.FieldByName('ITE_COMVAR_NOV').Value := IIf(fCampoAltera(cCOMVAR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMVAR)), Null);
       cdsItens.FieldByName('ITE_COMATA_NOV').Value := IIf(fCampoAltera(cCOMATA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMATA)), Null);
       cdsItens.FieldByName('ITE_COMDIS_NOV').Value := IIf(fCampoAltera(cCOMDIS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMDIS)), Null);
       cdsItens.FieldByName('ITE_COMPRO_NOV').Value := IIf(fCampoAltera(cCOMPRO),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMPRO)), Null);
       cdsItens.FieldByName('ITE_DESMAX_NOV').Value := IIf(fCampoAltera(cDESMAX),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESMAX)), Null);
       cdsItens.FieldByName('ITE_DESMSU_NOV').Value := IIf(fCampoAltera(cDESMSU),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESMSU)), Null);
       cdsItens.FieldByName('ITE_DESMGE_NOV').Value := IIf(fCampoAltera(cDESMGE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDESMGE)), Null);
       cdsItens.FieldByName('ITE_MARMIN_NOV').Value := IIf(fCampoAltera(cMARMIN),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARMIN)), Null);
       cdsItens.FieldByName('ITE_MARMSG_NOV').Value := IIf(fCampoAltera(cMARMSG),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARMSG)), Null);
       cdsItens.FieldByName('ITE_MARMGE_NOV').Value := IIf(fCampoAltera(cMARMGE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARMGE)), Null);
       cdsItens.FieldByName('ITE_TMPGAR_NOV').Value := IIf(fCampoAltera(cTMPGAR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTMPGAR)), Null);
       cdsItens.FieldByName('ITE_INFGAR_NOV').Value := IIf(fCampoAltera(cINFGAR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cINFGAR)), Null);
       cdsItens.FieldByName('ITE_LOCFIS_NOV').Value := IIf(fCampoAltera(cLOCFIS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cLOCFIS)), Null);
       cdsItens.FieldByName('ITE_LOCSUP_NOV').Value := IIf(fCampoAltera(cLOCSUP),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cLOCSUP)), Null);

       cdsItens.FieldByName('ITE_ITEBAS_NOV').Value := IIf(fCampoAltera(cITEBAS),fConvetVazioToNull(fProcessaValorDefault(cITEBAS, objValidaExcel.fGetValueCSV(intLinha, cITEBAS))), Null);
       cdsItens.FieldByName('ITE_ITEPIG_NOV').Value := IIf(fCampoAltera(cITEPIG),fConvetVazioToNull(fProcessaValorDefault(cITEPIG, objValidaExcel.fGetValueCSV(intLinha, cITEPIG))), Null);
       cdsItens.FieldByName('ITE_BAREXP_NOV').Value := IIf(fCampoAltera(cBAREXP),fConvetVazioToNull(fProcessaValorDefault(cBAREXP, objValidaExcel.fGetValueCSV(intLinha, cBAREXP))), Null);
       cdsItens.FieldByName('ITE_CPRCEN_NOV').Value := IIf(fCampoAltera(cCPRCEN),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCPRCEN)), Null);
       cdsItens.FieldByName('ITE_CODMON_NOV').Value := IIf(fCampoAltera(cCODMON),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODMON)), Null);
       cdsItens.FieldByName('ITE_PESLIQ_NOV').Value := IIf(fCampoAltera(cPESLIQ),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPESLIQ)), Null);
       cdsItens.FieldByName('ITE_CODLSE_NOV').Value := IIf(fCampoAltera(cCODLSE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODLSE)), Null);
       cdsItens.FieldByName('ITE_DIAFOR_NOV').Value := IIf(fCampoAltera(cDIAFOR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDIAFOR)), Null);

      //Dados E-Commerce
       cdsItens.FieldByName('ITE_EXPSIT_NOV').Value := IIf(fCampoAltera(cEXPSIT),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cEXPSIT)), Null);
       cdsItens.FieldByName('ITE_DESITE_SITE_NOV').Value := IIf(fCampoAltera(cDSSITE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cDSSITE)), Null);
       cdsItens.FieldByName('ITE_DADTEC_NOV').Value := IIf(fCampoAltera(cDADTEC),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cDADTEC)), Null);
       cdsItens.FieldByName('ITE_URLIMG_NOV').Value := IIf(fCampoAltera(cURLIMG),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cURLIMG)), Null);
       cdsItens.FieldByName('ITE_NOMITE_NOV').Value := IIf(fCampoAltera(cNOMITE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cNOMITE)), Null);
       cdsItens.FieldByName('ITE_APLITE_NOV').Value := IIf(fCampoAltera(cAPLITE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cAPLITE)), Null);
       cdsItens.FieldByName('ITE_INCLUS_NOV').Value := IIf(fCampoAltera(cINCLUS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cINCLUS)), Null);
       cdsItens.FieldByName('ITE_EXPALT_NOV').Value := IIf(fCampoAltera(cEXPALT),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cEXPALT)), Null);
       cdsItens.FieldByName('ITE_EXPLAR_NOV').Value := IIf(fCampoAltera(cEXPLAR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cEXPLAR)), Null);
       cdsItens.FieldByName('ITE_EXPPRO_NOV').Value := IIf(fCampoAltera(cEXPPRO),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cEXPPRO)), Null);
       cdsItens.FieldByName('ITE_DESSIT_NOV').Value := IIf(fCampoAltera(cDESSIT),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cDESSIT)), Null);
       cdsItens.FieldByName('ITE_CODCAT_NOV').Value := IIf(fCampoAltera(cCODCAT),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cCODCAT)), Null);
       cdsItens.FieldByName('ITE_DESTAQ_NOV').Value := IIf(fCampoAltera(cDESTAQ),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cDESTAQ)), Null);
       cdsItens.FieldByName('ITE_ATZPRE_NOV').Value := IIf(fCampoAltera(cATZPRE),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cATZPRE)), Null);
       cdsItens.FieldByName('ITE_EXPAPP_NOV').Value := IIf(fCampoAltera(cEXPAPP),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cEXPAPP)), Null);
       cdsItens.FieldByName('LIS_CODFOR').Value     := IIf(fCampoAltera(cITEFOR_CODFOR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cITEFOR_CODFOR )), Null);
       cdsItens.FieldByName('LIS_CODFAB').Value     := IIf(fCampoAltera(cITEFOR_CODITF),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cITEFOR_CODITF )), Null);
       cdsItens.FieldByName('LIS_CODCNA').Value     := IIf(fCampoAltera(cITEFOR_CODCNA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cITEFOR_CODCNA )), Null);
       cdsItens.FieldByName('ITE_ESTMIN_NOV').Value := IIf(fCampoAltera(cESTMIN),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cESTMIN)), Null);
       cdsItens.FieldByName('ITE_ESTMAX_NOV').Value := IIf(fCampoAltera(cESTMAX),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cESTMAX)), Null);
       cdsItens.FieldByName('ITE_TCIFCU_NOV').Value := IIf(fCampoAltera(cTCIFCU, False, 'cTCIFCU'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTCIFCU)), Null);
       cdsItens.FieldByName('ITE_TSCUST_NOV').Value := IIf(fCampoAltera(cTSCUST, False, 'cTSCUST'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTSCUST)), Null);
       cdsItens.FieldByName('ITE_DEPICO_NOV').Value := IIf(fCampoAltera(cDEPICO, False, 'cDEPICO'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDEPICO)), Null);
       cdsItens.FieldByName('ITE_DEICMS_NOV').Value := IIf(fCampoAltera(cDEICMS, False, 'cDEICMS'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cDEICMS)), Null);
       cdsItens.FieldByName('ITE_FATREG_NOV').Value := IIf(fCampoAltera(cFATREG, False, 'cFATREG'),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cFATREG)), Null);
       cdsItens.FieldByName('ITE_EMBALA_NOV').Value := IIf(fCampoAltera(cEMBALA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cEMBALA)), Null);
       cdsItens.FieldByName('ITE_ITEEMB_NOV').Value := IIf(fCampoAltera(cITEEMB),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cITEEMB)), Null);
       cdsItens.FieldByName('ITE_UNITRI_NOV').Value := IIf(fCampoAltera(cUNITRI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cUNITRI)), Null);
       cdsItens.FieldByName('ITE_EXPPOK_NOV').Value := IIf(fCampoAltera(cEXPPOK),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cEXPPOK)), Null);
       cdsItens.FieldByName('ITE_TIPPRO_NOV').Value := IIf(fCampoAltera(cTIPPRO),fConvetVazioToNull(LeftStr(objValidaExcel.fGetValueCSV(intLinha, cTIPPRO),2)), Null);
       cdsItens.FieldByName('ITE_INDREV_NOV').Value := IIf(fCampoAltera(cINDREV),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cINDREV)), Null);
       cdsItens.FieldByName('ITE_IMPDIR_NOV').Value := IIf(fCampoAltera(cIMPDIR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIMPDIR)), Null);

       cdsItens.FieldByName('ITE_MSGLV1_NOV').Value := IIf(fCampoAltera(cMSGLV1),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMSGLV1)), Null);
       cdsItens.FieldByName('ITE_MSGLV2_NOV').Value := IIf(fCampoAltera(cMSGLV2),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMSGLV2)), Null);
       cdsItens.FieldByName('ITE_PEEFUT_NOV').Value := IIf(fCampoAltera(cPEEFUT),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPEEFUT)), Null);
       cdsItens.FieldByName('ITE_PEFUTP_NOV').Value := IIf(fCampoAltera(cPEFUTP),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPEFUTP)), Null);
       cdsItens.FieldByName('ITE_PEFFPR_NOV').Value := IIf(fCampoAltera(cPEFFPR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPEFFPR)), Null);

       cdsItens.FieldByName('LIS_ESMIDG').Value := IIf(fCampoAltera(cESMIDG_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cESMIDG_LISTA)), Null);
       cdsItens.FieldByName('LIS_ESTMIN').Value := IIf(fCampoAltera(cESTMIN_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cESTMIN_LISTA)), Null);
       cdsItens.FieldByName('LIS_ESTMAX').Value := IIf(fCampoAltera(cESTMAX_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cESTMAX_LISTA)), Null);
       cdsItens.FieldByName('LIS_SITPRO').Value := IIf(fCampoAltera(cSITPRO_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cSITPRO_LISTA)), Null);
       cdsItens.FieldByName('LIS_ABVFIS').Value := IIf(fCampoAltera(cABVFIS_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cABVFIS_LISTA)), Null);

       cdsItens.FieldByName('LIS_ABFPIS').Value := IIf(fCampoAltera(cABFPIS_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cABFPIS_LISTA)), Null);
       cdsItens.FieldByName('LIS_ABFCOF').Value := IIf(fCampoAltera(cABFCOF_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cABFCOF_LISTA)), Null);

       cdsItens.FieldByName('ITE_TIPFRE_NOV').Value := IIf(fCampoAltera(cTIPFRE), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTIPFRE)), Null);
       cdsItens.FieldByName('ITE_VLCFRE_NOV').Value := IIF(fCampoAltera(cVLCFRE), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVLCFRE)), Null);
       cdsItens.FieldByName('ITE_QRCODE_NOV').Value := IIF(fCampoAltera(cQRCODE), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cQRCODE)), Null);
       cdsItens.FieldByName('ITE_EXPB2B_NOV').Value := IIF(fCampoAltera(cEXPB2B), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cEXPB2B)), Null);
       cdsItens.FieldByName('ITE_PRAVAL_NOV').Value := IIF(fCampoAltera(cPRAVAL), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPRAVAL)), Null);
       cdsItens.FieldByName('ALTPRE').AsInteger := IIf(fAlterouPreco(cdsItens), 1, 0);
       cdsItens.FieldByName('ITE_RECDEV_NOV').Value := IIF(fCampoAltera(cRECDEV), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cRECDEV)), Null);
       cdsItens.FieldByName('ITE_VALOBR_NOV').Value := IIF(fCampoAltera(cVALOBR), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVALOBR)), Null);
       cdsItens.FieldByName('ITE_COMPOS_NOV').Value     := IIf(fCampoAltera(cCOMPOS),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCOMPOS )), Null);
       cdsItens.FieldByName('ITE_ITESAC_NOV').Value     := IIf(fCampoAltera(cITESAC),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cITESAC )), Null);
       cdsItens.FieldByName('ITE_PAISOR_NOV').Value     := IIf(fCampoAltera(cPAISOR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPAISOR  )), Null);

       cdsItens.FieldByName('ITE_CODATC_NOV').Value  := IIF(fCampoAltera(cCODATC), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODATC)), Null);

       cdsItens.FieldByName('ITE_MARID1_NOV').Value := IIF(fCampoAltera(cMARGE1), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE1)), Null);
       cdsItens.FieldByName('ITE_MARID2_NOV').Value := IIF(fCampoAltera(cMARGE2), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE2)), Null);
       cdsItens.FieldByName('ITE_MARID3_NOV').Value := IIF(fCampoAltera(cMARGE3), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE3)), Null);
       cdsItens.FieldByName('ITE_MARID4_NOV').Value := IIF(fCampoAltera(cMARGE4), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE4)), Null);
       cdsItens.FieldByName('ITE_MARID5_NOV').Value := IIF(fCampoAltera(cMARGE5), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE5)), Null);
       cdsItens.FieldByName('ITE_MARID6_NOV').Value := IIF(fCampoAltera(cMARGE6), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE6)), Null);
       cdsItens.FieldByName('ITE_MARID7_NOV').Value := IIF(fCampoAltera(cMARGE7), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cMARGE7)), Null);

       cdsItens.FieldByName('ITE_SOBENC_NOV').Value := IIf(fCampoAltera(cSOBENC),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cSOBENC)), Null);

       if fCfgSis('UTPEST', varBoolean) then
       begin
         cdsItens.FieldByName('ITE_QTDPES_NOV').Value := IIF(fCampoAltera(cQTDPES), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cQTDPES)), Null);
         cdsItens.FieldByName('ITE_PORPES_NOV').Value := IIF(fCampoAltera(cPORPES), fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha,cPORPES)), Null);
       end;

       cdsItens.FieldByName('ITE_MLTRCA_NOV').Value := IIf(fCampoAltera(cMLTRCA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMLTRCA)), Null);

       cdsItens.FieldByName('ITE_PER_CI_NOV').Value := IIf(fCampoAltera(cPER_CI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPER_CI)), Null);
       cdsItens.FieldByName('ITE_NUMFCI_NOV').Value := IIf(fCampoAltera(cNUMFCI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cNUMFCI)), Null);

       if fCfgSis('UNITRI', varBoolean) then
         cdsItens.FieldByName('ITE_FATUTR_NOV').Value := IIf(fCampoAltera(cFATUTR),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cFATUTR)), Null);

       If blnURapel Then
         cdsItens.FieldByName('ITE_PRAPEL_NOV').Value := IIf(fCampoAltera(cPRAPEL),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPRAPEL)), Null);

       cdsItens.FieldByName('ITE_CEREPI_NOV').Value := IIf(fCampoAltera(cCEREPI),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCEREPI)), Null);

       if fCfgSis('MARPAD', varBoolean) then
         cdsItens.FieldByName('ITE_MARPAD_NOV').Value := IIf(fCampoAltera(cMARPAD),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMARPAD)), Null);

       if fCfgSis('MINPRO', varBoolean) then
         cdsItens.FieldByName('LIS_TPESTM').Value := IIf(fCampoAltera(cTPESTM_LISTA),fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTPESTM_LISTA)), Null);

       fltFatEmb := cdsItens.FieldByName('FATEMB').AsFloat;

       If fCampoAltera(cEMBALA) Then
         arrCampoEmbalagem := objValidaExcel.fRetEmbalagens(objValidaExcel.fGetValueCSV(intLinha, cEMBALA));

       If fCampoAltera(cITEEMB) Then
         arrIteEmbalagemArr := objValidaExcel.fRetDescontoEmbalagemFechada(objValidaExcel.fGetValueCSV(intLinha, cITEEMB));

       For intEmbalagem := 0 To High(arrCampoEmbalagem) Do
       Begin

         strMensagem := '';
         If (arrCampoEmbalagem[intEmbalagem].strCodBar <> '') And
            (fTemCodBarDuplicado(arrCampoEmbalagem[intEmbalagem].strCodBar,
                                  cdsItens.FieldByName('ITE_CODITE').AsString, strDuplicados)) Then
           strMensagem := ' Item ' + strDuplicados + ' já possui o mesmo Código de Barras (' + arrCampoEmbalagem[intEmbalagem].strCodBar + ').'
         Else If (arrCampoEmbalagem[intEmbalagem].strCodBar <> '') And
              fTemCodBarDuplicadoPlanilha(arrCampoEmbalagem[intEmbalagem].strCodBar) Then
           strMensagem := 'Código de Barras (' + arrCampoEmbalagem[intEmbalagem].strCodBar + ') esta para mais de um item na planilha.';

         If Not fEmptyStr(strMensagem) Then
         Begin
           cdsItens.FieldByName('IMPORT').AsInteger := 2;
           cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D + strMensagem;
           strMensagem := '';
         End
         Else

         begin
           cdsItensEmbalagem.Insert;

           cdsItensEmbalagem.FieldByName('BAR_CODBAR').AsString  := arrCampoEmbalagem[intEmbalagem].strCodBar;
           cdsItensEmbalagem.FieldByName('BAR_CODFOR').AsString  := arrCampoEmbalagem[intEmbalagem].strCodFor;
           cdsItensEmbalagem.FieldByName('BAR_EMBALA').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltEmbala;
           cdsItensEmbalagem.FieldByName('BAR_PREVEN').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltPreVen;
           cdsItensEmbalagem.FieldByName('BAR_DESCRI').AsString  := arrCampoEmbalagem[intEmbalagem].strDescri;

           If arrCampoEmbalagem[intEmbalagem].intTabPre > 0 Then
             cdsItensEmbalagem.FieldByName('BAR_TABPRE').AsInteger := arrCampoEmbalagem[intEmbalagem].intTabPre;

           cdsItensEmbalagem.FieldByName('BAR_PRINCI').AsInteger := IIf(arrCampoEmbalagem[intEmbalagem].blnPrinci, 1, 0);
           cdsItensEmbalagem.FieldByName('BAR_COMPRA').AsInteger := IIf(arrCampoEmbalagem[intEmbalagem].blnCompra, 1, 0);
           If cdsItensEmbalagem.FieldByName('BAR_COMPRA').AsInteger = 1 Then
              fltFatEmb := cdsItensEmbalagem.FieldByName('BAR_EMBALA').AsFloat;

           cdsItensEmbalagem.FieldByName('BAR_EXBFAT').AsString  := IIf(arrCampoEmbalagem[intEmbalagem].blnExbFat, 'S', 'N');
           cdsItensEmbalagem.FieldByName('BAR_ALTURA').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltAltura;
           cdsItensEmbalagem.FieldByName('BAR_LARGUR').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltLargur;
           cdsItensEmbalagem.FieldByName('BAR_PROFUN').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltProfun;
           cdsItensEmbalagem.FieldByName('BAR_LASTRO').AsInteger := arrCampoEmbalagem[intEmbalagem].intLastro;
           cdsItensEmbalagem.FieldByName('BAR_CAMADA').AsInteger := arrCampoEmbalagem[intEmbalagem].intCamada;
           cdsItensEmbalagem.FieldByName('BAR_EMPMAX').AsInteger := arrCampoEmbalagem[intEmbalagem].intEmpMax;
           cdsItensEmbalagem.FieldByName('BAR_PESOBR').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltPesoBR;
           cdsItensEmbalagem.FieldByName('BAR_PESOLQ').AsFloat   := arrCampoEmbalagem[intEmbalagem].fltPesoLQ;
           cdsItensEmbalagem.FieldByName('BAR_GERAUT').AsInteger := IIf(arrCampoEmbalagem[intEmbalagem].blnAtuCodBarCadIte, 1, 0);
           cdsItensEmbalagem.FieldByName('ID').AsInteger := intSequencial;

           cdsItensEmbalagem.Post;
         End;
       End;


       For intEmbalagem := 0 To High(arrIteEmbalagemArr) Do
       Begin

         strMensagem := '';

         If arrIteEmbalagemArr[intEmbalagem].strITB_TABPRE <> 'TODAS' Then
         Begin
           If Not fValidaTipoCampo(arrIteEmbalagemArr[intEmbalagem].strITB_TABPRE) Then
           Begin
             strMensagem := 'Tabela preço não existe (' + arrIteEmbalagemArr[intEmbalagem].strITB_TABPRE + ')';
           End
         End
         Else If Not fValidaTipoCampo(arrIteEmbalagemArr[intEmbalagem].strITB_QTDEMB) Then
            strMensagem := 'Campo quantidade não é um número válido (' + arrIteEmbalagemArr[intEmbalagem].strITB_QTDEMB + ')'
         Else If Not fValidaTipoCampo(arrIteEmbalagemArr[intEmbalagem].strITB_QTDEMB) Then
            strMensagem := 'Desconto embalagem não é um número válido (' + arrIteEmbalagemArr[intEmbalagem].strITB_DESCON + ')';

         If Not fEmptyStr(strMensagem) Then
         Begin
            cdsItens.FieldByName('IMPORT').AsInteger := 2;
            cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D + strMensagem;
            strMensagem := '';
         End
         Else
         begin
           cdsItensEmbDescFech.Insert;
           cdsItensEmbDescFech.FieldByName('ITB_CODEMP').AsString := VS_strCodEmp;
           cdsItensEmbDescFech.FieldByName('ITB_CODITE').AsString := strCodIte;
           cdsItensEmbDescFech.FieldByName('ITB_QTDEMB').AsFloat  := strToFloat(arrIteEmbalagemArr[intEmbalagem].strITB_QTDEMB);
           cdsItensEmbDescFech.FieldByName('ITB_DESCON').AsFloat  := strToFloat(arrIteEmbalagemArr[intEmbalagem].strITB_DESCON);

           If arrIteEmbalagemArr[intEmbalagem].strITB_TABPRE <> 'TODAS' Then
             cdsItensEmbDescFech.FieldByName('ITB_TABPRE').AsString := arrIteEmbalagemArr[intEmbalagem].strITB_TABPRE
           Else
             cdsItensEmbDescFech.FieldByName('ITB_TABPRE').AsString := '';

           cdsItensEmbDescFech.FieldByName('ID').AsInteger := intSequencial;

           cdsItensEmbDescFech.Post;
         End;
       End;


       cdsItens.FieldByName('MARCADO').Value := 1;

     End;


     If (Not chkCnvCus.Checked) Or (fltFatEmb = 0) then
        fltFatEmb := 1;

     pCalcularPrecos(cdsItens, recPrecos, fltFatEmb);

     //Novos Valores Para Margem e Preco Venda
     For i := 1 to 7 Do
     Begin
       cdsItens.FieldByName('ITE_MARBR' + IntToStr(i) + '_NOV').AsFloat := recPrecos[i].fltMarBru;
       cdsItens.FieldByName('ITE_PREVE' + IntToStr(i) + '_NOV').AsFloat := recPrecos[i].fltPreVen;
       cdsItens.FieldByName('VARIACAO' + IntToStr(i)).AsFloat := recPrecos[i].fltVariacao;

       if strTabelasTABPRC[i] = 'S' Then
       Begin
         If not fValidaMargem(i, cdsItens, recPrecos) Then
         Begin
           if cdsItens.FieldByName('DESEXC').AsString <> '' then
              cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
           cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + 'TABELA DE PREÇOS ' +
                                                      IntToStr(i) + ': A SOMA DO "ICMS SAÍDA" + "IMPOSTOS FEDERAIS" + "DESPESAS OPERACIONAIS" ' +
                                                      IIF(fCfgSis('MARMKP') = '1', ' + "MARGEM BRUTA" ', '') +
                                                      IIF(fCfgSis('PCMPRO') = '2', '+ "COMISSÃO" ', '') + ' NÃO PODEM SER SUPERIOR A 100%.  PORCENTAGEM "MARGEM BRUTA": ' +
                                                      FormatFloat('#,###0.00', recPrecos[i].fltMarBru) + IIF(fCfgSis('PCMPRO') = '2', '  PORCENTAGEM "COMISSÃO": ' + FormatFloat('#,###0.00', recPrecos[i].fltComiss), '');
           cdsItens.FieldByName('IMPORT').AsInteger := 2;
         End;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('LIS_ESTMIN').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_ESTMIN').AsString, 'ITE_ESTMIN',  strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('LIS_ESTMAX').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_ESTMAX').AsString, 'ITE_ESTMAX', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('LIS_SITPRO').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_SITPRO').AsString, 'ITE_SITPRO', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If fCfgSis('MINPRO', varBoolean) Then
     Begin
       If Not fEmptyStr(cdsItens.FieldByName('LIS_TPESTM').AsString) Then
       Begin
         strErro := '';
         pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_TPESTM').AsString, 'ITE_TPESTM', strErro);
         If strErro <> '' Then
         Begin
           cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
           cdsItens.FieldByName('IMPORT').AsInteger := 2;
         End;
       End;
     End;

    If Not fEmptyStr(cdsItens.FieldByName('LIS_ABVFIS').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_ABVFIS').AsString, 'ITE_CODABF', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('LIS_ABFPIS').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_ABFPIS').AsString, 'ITE_ABFPIS', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('LIS_ABFCOF').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_ABFCOF').AsString, 'ITE_ABFCOF', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('LIS_ESMIDG').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('LIS_ESMIDG').AsString, 'ITE_ESMIDG', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If Not fEmptyStr(cdsItens.FieldByName('ITE_NVLCRI').AsString) Then
     Begin
       strErro := '';
       pPopulaCDSEstIm(cdsItens.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('ITE_NVLCRI_NOV').AsString, 'ITE_NIVCRI', strErro);
       If strErro <> '' Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strErro;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;
     End;

     If (cdsItens.FieldByName('LIS_ESTMAX').AsString <> '') Or
        (cdsItens.FieldByName('LIS_ESTMIN').AsString <> '') Then
     Begin
       cdsESTMIN_ESTMAX.Filtered := False;
       cdsESTMIN_ESTMAX.Filter := 'ID = '+ inttoStr(intSequencial);
       cdsESTMIN_ESTMAX.Filtered := True;
       cdsESTMIN_ESTMAX.First;
       If Not cdsESTMIN_ESTMAX.IsEmpty Then
       Begin
         strErro := '';
         pValidaEstoqueMAximoEMinimo(strErro);
         IF strErro <> '' Then
         Begin
           IF cdsItens.FieldByName('DESEXC').AsString <> '' Then
             cdsItens.FieldByName('DESEXC').AsString :=  cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
           cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + strErro;
           cdsItens.FieldByName('IMPORT').AsInteger := 2;
         End;
       End;
     End;
     cdsESTMIN_ESTMAX.Filtered := False;
     cdsESTMIN_ESTMAX.Filter := '';


     If cdsItens.FieldByName('IMPORT').AsInteger = 0 Then
     Begin
       If (Not blnProCod) and  fEmptyStr(strCodIte) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' O Sistema não esta configurado para gerar o código do item automaticamente, e o código do item não foi informado no arquivo.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_CODGRU_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Código do grupo em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_DESITE_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Descrição do produto em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_CODMAR_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Código da Marca em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_CODUNI_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Código da unidade em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If (strCnvEmb <> 'N') And fEmptyStr(cdsItens.FieldByName('ITE_UNICOM_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Código da unidade de compra em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If cdsItens.FieldByName('ITE_PRECOM_NOV').AsFloat = 0 Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Preço de compra zerado.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If cdsItens.FieldByName('ITE_MLTVEN_NOV').AsFloat = 0 Then
       Begin
         cdsItens.FieldByName('ITE_MLTVEN_NOV').AsInteger := 1;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_CODABF_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Abreviação fiscal em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_CLAIPI_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' NCM em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If fEmptyStr(cdsItens.FieldByName('ITE_CODFOR_NOV').AsString) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Fornecedor em branco.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       If blnURapel And (cdsItens.FieldByName('ITE_PRAPEL_NOV').AsFloat < 0) Then
       Begin
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' Desconto Rapel deve ser maior ou igual a zero.';
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End;

       // VALIDAR
       //   LINHA E GRUPO, DESCRIÇÃO, MARCA, FORNECEDOR, UNIDADE DE VENDA, UNIDADE DE COMPRA, PREÇO DE COMPRA, NCM,
       //   ABREVIAÇÃO FISCAL, MULTIPLO PRA VENDA


       If Not blnArqCsv Then
       Begin
         cdsItens.FieldByName('ITE_CODITE').AsString := Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value);
       End
       Else
       Begin
         cdsItens.FieldByName('ITE_CODITE').AsString := objValidaExcel.fGetValueCSV(intLinha, cCodIte);
       End;
     End;

     If (Not fEmptyStr(cdsItens.FieldByName('LIS_CODFOR').AsString)) And (Not fEmptyStr(cdsItens.FieldByName('ITE_CODITE').AsString)) Then
     Begin
       If fDuplicadadeIteFor(strMensagem) Then
       Begin
         If Not fEmptyStr(cdsItens.FieldByName('DESEXC').AsString) Then
            cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' + strMensagem;
         cdsItens.FieldByName('IMPORT').AsInteger := 2;
       End
     End;

     If IIf(cdsItens.FieldByName('ITE_ESTMIN_NOV').AsString = '',
            cdsItens.FieldByName('ITE_ESTMIN').AsFloat,
            cdsItens.FieldByName('ITE_ESTMIN_NOV').AsFloat) > IIf(cdsItens.FieldByName('ITE_ESTMAX_NOV').AsString = '',
                                                                   cdsItens.FieldByName('ITE_ESTMAX').AsFloat,
                                                                   cdsItens.FieldByName('ITE_ESTMAX_NOV').AsFloat) Then
     Begin
       If Not fEmptyStr(cdsItens.FieldByName('DESEXC').AsString) Then
         cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + #$A#$D;
       cdsItens.FieldByName('DESEXC').AsString := cdsItens.FieldByName('DESEXC').AsString + ' ' +
                                                  'Estoque Mínimo [' + IIf(cdsItens.FieldByName('ITE_ESTMIN_NOV').AsString = '',
                                                                           cdsItens.FieldByName('ITE_ESTMIN').AsString,
                                                                           cdsItens.FieldByName('ITE_ESTMIN_NOV').AsString) + '] não pode ser maior que o ' +
                                                  'Estoque Máximo [' + IIf(cdsItens.FieldByName('ITE_ESTMAX_NOV').AsString = '',
                                                                           cdsItens.FieldByName('ITE_ESTMAX').AsString,
                                                                           cdsItens.FieldByName('ITE_ESTMAX_NOV').AsString) + ']';
       cdsItens.FieldByName('IMPORT').AsInteger := 2;
     End;

     cdsItens.FieldByName('DESEXC').AsString := Trim( cdsItens.FieldByName('DESEXC').AsString);


     cdsItens.Post;
   Except
     on E: Exception do
        pMensagensErro(E.Message, '[TfrmImportCadProduto.pInsereItensCDS]');
   End;
end;



procedure TfrmImportCadProduto.pLimparCDS;
begin
  cdsItens.EmptyDataSet;
end;

function TfrmImportCadProduto.fSQLIteger(pesTipPes: TTipoPesquisa): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  strSQL := strSQL +   fSqlBase;

  strSQL := strSQL + ' FROM';
  strSQL := strSQL + '   ITEGER G ';
  strSQL := strSQL + '   LEFT JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE  ';
  If pesTipPes = pesCodBar Then
    strSQL := strSQL + '   LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE '
  Else
    strSQL := strSQL + '   LEFT JOIN ITEBAR B ON B.BAR_CODITE = G.ITE_CODITE AND B.BAR_CODBAR = I.ITE_CODBAR ';
  strSql := strSql + '   LEFT JOIN DESSIT S ON S.ITE_CODITE = G.ITE_CODITE  ';
  strSql := strSql + '  LEFT JOIN CADUNI ON CADUNI.UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + '   WHERE G.ITE_CODEMP = :CODEMP ';

  Case pesTipPes Of
    pesCodIte: strSQL := strSQL + ' AND G.ITE_CODITE = :CODITE ';
    pesCodBar: strSQL := strSQL + ' AND B.BAR_CODBAR = :CODBAR ';
    pesCodFab: strSQL := strSQL + ' AND (I.ITE_CODFAB = :CODFAB AND I.ITE_CODFOR = :CODFOR) ';
    pesIteForCodFab: begin
                     strSQL := strSQL + ' AND (SELECT COUNT(1) ';
                     strSQL := strSQL + '        FROM ITEFOR F';
                     strSQL := strSQL + '       WHERE F.ITE_CODITE = G.ITE_CODITE ';
                     strSQL := strSQL + '         AND F.ITE_CODFOR = :CODFOR ';
                     strSQL := strSQL + '         AND F.ITE_CODITF = :CODFAB) > 0 ';
                   end;
    pesDesIte: strSQL := strSQL + ' AND I.ITE_DESITE = :DESITE ';
  End;

  Result := strSQL;
End;

function TfrmImportCadProduto.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

function TfrmImportCadProduto.fDefineAliasImpDir: String;
begin
  Result := 'G';

  If fCfgSis('IMPDIG') = '2' Then
    Exit;

  Result := 'I';
end;

function TfrmImportCadProduto.fDefineAliasIndRev: String;
begin
  Result := 'G';

  If fCfgSis('INDREV') = '2' Then
    Exit;

  Result := 'I';
end;

function TfrmImportCadProduto.fDuplicadadeIteFor(
  var strMensagem: string): boolean;
  var
    i,
    IntQtdRegistros: integer;
    List: TStringList;
begin
{}
  Result := False;
  List := TStringList.Create();
  Try
    List.StrictDelimiter := True;
    List.Delimiter := ',';
    List.StrictDelimiter := True;
    IntQtdRegistros := cdsItens.FieldByName('LIS_CODFOR').AsString.CountChar(',');
    List.DelimitedText := cdsItens.FieldByName('LIS_CODFOR').AsString + ',' + cdsItens.FieldByName('LIS_CODFAB').AsString;
    For i := 0 To IntQtdRegistros Do
    Begin
      If Not fValidaCodForFabItem(List[i], List[i + IntQtdRegistros + 1], cdsItens.FieldByName('ITE_CODITE').AsString, False,  strMensagem) Then
      begin
        Result := True;
        strMensagem := 'Código de Fornecedor ' + List[i] + ' + Fábrica ' + List[i + IntQtdRegistros + 1] + ' já cadastrados no Item ' + strMensagem;
        Break;
      End;
    End
  Finally
    FreeAndNil(List);
  End;

end;

function TfrmImportCadProduto.fTemCodBarDuplicado(strCodBar, strCodIte: String; Var strDuplicados: String): Boolean;
Begin
  strDuplicados := '';

  With qryCodBar Do
  Begin
    qryCodBar.Close;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODBAR').AsString := strCodBar;

    qryCodBar.Open;

    If Not IsEmpty Then
      strDuplicados := qryCodBar.FieldByName('DUPLICADOS').AsString;

    Result := Not fEmptyStr(strDuplicados);
  End;
End;

function TfrmImportCadProduto.fTemCodBarDuplicadoPlanilha(strCodBar: String): Boolean;
begin
  cdsItensEmbalagem.Filtered := False;
  cdsItensEmbalagem.Filter := 'BAR_CODBAR = ' + QuotedStr(strCodBar) + ' AND ID <> ' + IntToStr(intSequencial);
  cdsItensEmbalagem.Filtered := True;
  Result := Not cdsItensEmbalagem.IsEmpty;
  cdsItensEmbalagem.Filtered := False;
  cdsItensEmbalagem.Filter := '';
end;

function TfrmImportCadProduto.fTemCodFabDuplicado(strCodFab, strCodFor, strCodIte: String; Var strDuplicados: String): Boolean;
Begin
  strDuplicados := '';

  With qryCodFab Do
  Begin
    qryCodFab.Close;
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODFAB').AsString := strCodFab;
    ParamByName('CODFOR').AsString := strCodFor;

    qryCodFab.Open;

    If Not IsEmpty Then
      strDuplicados := FieldByName('DUPLICADOS').AsString;

    Result := Not fEmptyStr(strDuplicados);
  End;
End;


function TfrmImportCadProduto.fLocalizaItemIteger(qryLocaliza: TUniQuery; intLinha: Integer; Var strErro: String; var TipoPesquisa: TTipoPesquisa): boolean;
  Var
    strDuplicados,
    strCodIte,
    strCodBar,
    strCodFor,
    strCodFab,
    strDesIte,
    strIteAti: String;
begin
  Result := False;

  strDuplicados := '';

  TipoPesquisa := pesNenhuma;

  pGetCodigos(strCodIte, strCodBar, strCodFor, strCodFab, strIteAti, strDesIte, intLinha);
  Try
    qryLocaliza.Close;

    If (Not Result) And (Not fEmptyStr(strCodIte)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesCodIte);

      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODITE').AsString := strCodIte;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
      TipoPesquisa := pesCodIte;

      If Result Then
      Begin

        If (fCampoAltera('cCODBAR', True)) And (Not fEmptyStr(strCodBar)) And (qryLocaliza.FieldByName('ITE_CODBAR').AsString <> strCodBar) And
           fTemCodBarDuplicado(strCodBar, strCodIte, strDuplicados)  Then
          strErro := strErro + ' Item ' + strDuplicados + ' já possui o mesmo Código de Barras (' + strCodBar + ').';

        If ((fCampoAltera('cCODFAB', True)) And (Not fEmptyStr(strCodFab)) And (Not fEmptyStr(strCodFor))) And
           (( (Not fEmptyStr(qryLocaliza.FieldByName('ITE_CODFAB').AsString)) And (qryLocaliza.FieldByName('ITE_CODFAB').AsString <> strCodFab) ) Or {Referente ao cód fábrica}
            ( (qryLocaliza.FieldByName('ITE_CODFOR').AsString <> strCodFor) )) And {Referente ao cód Fornecedor}
           fTemCodFabDuplicado(IIF(fEmptyStr(strCodFab), qryLocaliza.FieldByName('ITE_CODFAB').AsString, strCodFab),
                               IIF(fEmptyStr(strCodFor), qryLocaliza.FieldByName('ITE_CODFOR').AsString, strCodFor), strCodIte, strDuplicados) Then
          strErro := strErro + ' Item ' + strDuplicados + ' já possui os mesmos Códigos de Fábrica (' +
                                                               IIF(fEmptyStr(strCodFab), qryLocaliza.FieldByName('ITE_CODFAB').AsString, strCodFab) +
                                          ') e Fornecedor (' + IIF(fEmptyStr(strCodFor), qryLocaliza.FieldByName('ITE_CODFOR').AsString, strCodFor) + ').';
      End;

    End;

    If (Not Result) And (Not fEmptyStr(strCodBar)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesCodBar);


      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODBAR').AsString := strCodBar;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
      TipoPesquisa := pesCodBar;


      If (Result) And (fCampoAltera('cCODFAB', True)) And (((Not fEmptyStr(strCodFab)) And (qryLocaliza.FieldByName('ITE_CODFAB').AsString <> '') And (qryLocaliza.FieldByName('ITE_CODFAB').AsString <> strCodFab)) Or
          ((Not fEmptyStr(strCodFor)) And (qryLocaliza.FieldByName('ITE_CODFOR').AsString <> strCodFor))) And
         fTemCodFabDuplicado(IIF(fEmptyStr(strCodFab), qryLocaliza.FieldByName('ITE_CODFAB').AsString, strCodFab),
                             IIF(fEmptyStr(strCodFor), qryLocaliza.FieldByName('ITE_CODFOR').AsString, strCodFor),
                             qryLocaliza.FieldByName('ITE_CODITE').AsString, strDuplicados) Then
        strErro := strErro + ' Item ' + strDuplicados + ' já possui os mesmos Códigos de Fábrica (' +
                                                             IIF(fEmptyStr(strCodFab), qryLocaliza.FieldByName('ITE_CODFAB').AsString, strCodFab) +
                                        ') e Fornecedor (' + IIF(fEmptyStr(strCodFor), qryLocaliza.FieldByName('ITE_CODFOR').AsString, strCodFor) + ').';

    End;

    If (Not Result) And (Not fEmptyStr(strCodFab)) And (Not fEmptyStr(strCodFor)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesCodFab);
      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODFAB').AsString := strCodFab;
      qryLocaliza.ParamByName('CODFOR').AsString := strCodFor;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
       TipoPesquisa := pesCodFab;

      If (Result) And (fCampoAltera('cCODBAR', True)) And (Not fEmptyStr(strCodBar)) And (qryLocaliza.FieldByName('ITE_CODBAR').AsString <> strCodBar) And
         fTemCodBarDuplicado(strCodBar, qryLocaliza.FieldByName('ITE_CODITE').AsString, strDuplicados)  Then
        strErro := strErro + ' Item ' + strDuplicados + ' já possui o mesmo Código de Barras (' + strCodBar + ').';
    End;

    If (Not Result) And (Not fEmptyStr(strCodFab)) And (Not fEmptyStr(strCodFor)) And (Not fCfgSis('TABPRF', varBoolean)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesIteForCodFab);
      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('CODFAB').AsString := strCodFab;
      qryLocaliza.ParamByName('CODFOR').AsString := strCodFor;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
      TipoPesquisa := pesIteForCodFab;

      If qryLocaliza.RecordCount > 1 Then
        strErro := strErro + ' Mais de um item localizado com Cód. Fábrica ' + strCodFab + ' Para o fornecedor ' + strCodFor + '.';
      If Not Result Then
        TipoPesquisa := pesNenhuma;
    End;

    {
    If (Not Result) And (Not fEmptyStr(strDesIte)) And (fEmptyStr(strCodIte)) Then
    Begin
      qryLocaliza.SQL.Text := fSQLIteger(pesDesIte);
      qryLocaliza.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLocaliza.ParamByName('DESITE').AsString := strDesIte;
      qryLocaliza.Open;
      Result := qryLocaliza.RecordCount > 0;
      TipoPesquisa := pesDesIte;

      If qryLocaliza.RecordCount > 0 Then
        strErro := strErro + ' Mais de um item localizado com a Descrição ' + strDesIte + ' Para o fornecedor ' + strCodFor + '.';
      If Not Result Then
        TipoPesquisa := pesNenhuma;
    End;
    }


    If Result Then
    Begin
      If (strIteAti = 'N') And (qryLocaliza.FieldByName('ITE_ITEATI').AsString = 'S') And (qryLocaliza.FieldByName('SALDOS').AsFloat > 0) Then
        strErro := strErro + ' Item possui saldo não pode ser inativado.'
      Else If blnUsaQtdPen And (strIteAti = 'N') And (qryLocaliza.FieldByName('ITE_ITEATI').AsString = 'S') And (qryLocaliza.FieldByName('ENTFUT').AsFloat > 0) Then
        strErro := strErro + ' Item possui saldo reservado não pode ser inativado.';
    End;

    If (Not fEmptyStr(strDesIte)) And
      (fItemComMesmaDecricao(strDesIte)) then
    Begin
      cdsItens.FieldByName('IMPORT').AsInteger := 2;
      cdsItens.FieldByName('DESEXC').AsString := Trim( cdsItens.FieldByName('DESEXC').AsString) + ' Descrição repetida na planilha';
    End;

   Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmImportCadProduto.fLocalizaItemIteger]');
  End;

end;


function TfrmImportCadProduto.fValidaTipoCampo(const Str: string): Boolean;
var
  CharIndex: Integer;
begin
  Result := True;
  for CharIndex := 1 to Length(Str) do
  begin
    if not Str[CharIndex].IsDigit then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

end.








