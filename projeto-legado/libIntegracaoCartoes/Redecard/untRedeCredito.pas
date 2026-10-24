unit untRedeCredito;
{**********************************************}
{* Versão do arquivo (V2.02 – 07/2009 – EEVC) *}
{*                                            *}
{* Obs: Caso modifique a vs, colocar aqui a   *}
{* nova versão.                               *}
{*******************************************AF*}

{**********************************************}
{* Versão do arquivo (V3.01 – 09/06 - EEFI)   *}
{*                                            *}
{* Obs: Caso modifique a vs, colocar aqui a   *}
{* nova versão.                               *}
{*******************************************AF*}

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Forms, Dialogs,
     DB {$IF Defined(VER180)}  {$ELSE}, frxClass, Graphics {$IFEND};

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “006” = RV Crédito Rotativo                   |
// +---------------------------------------------------------------------------------+
// |  Nº PV                          | Código do Ponto de Venda                      |
// +---------------------------------------------------------------------------------+
// |  Número do RV                   | Número do Resumo de Vendas                    |
// +---------------------------------------------------------------------------------+
// |  Nº do Banco                    | Código de registro do banco no Banco          |
// |                                 | Central                                       |
// +---------------------------------------------------------------------------------+
// |  Nº da Agência                  | Prefixo da agência                            |
// +---------------------------------------------------------------------------------+
// |  Nº da conta-corrente           | Número da conta-corrente                      |
// +---------------------------------------------------------------------------------+
// |  Data do RV (DDMMAAAA)          | Data do Resumo de Vendas Numérico,            |
// |                                 | no formato DDMMAAAA                           |
// +---------------------------------------------------------------------------------+
// |  Quantidade de CV/NSUs Acatados | Quantidade de Comprovantes de Vendas          |
// |                                 | Acatados que compõem o RV                     |
// +---------------------------------------------------------------------------------+
// |  Valor bruto                    | Soma dos valores dos comprovantes de          |
// |                                 | vendas apresentados ou capturados             |
// +---------------------------------------------------------------------------------+
// |  Valor da gorjeta               | Soma dos valores de gorjeta ou taxas de       |
// |                                 | serviço cobrados no ato da compra             |
// +---------------------------------------------------------------------------------+
// |  Valor rejeitado                | Soma dos valores dos comprovantes rejeitados  |
// +---------------------------------------------------------------------------------+
// |  Valor do desconto              | Valor referente à taxa de desconto            |
// +---------------------------------------------------------------------------------+
// |  Valor líquido                  | Valor correspondente ao crédito que será      |
// |                                 | realizado no domicílio bancário. Neste valor  |
// |                                 | não estão contemplados os ajustes Net.        |
// +---------------------------------------------------------------------------------+
// |  Data de crédito (DDMMAAAA)     | Data que o crédito será realizado             |
// |                                 | Numérico, no formato DDMMAAAA                 |
// +---------------------------------------------------------------------------------+
// |  Bandeira (2)                   | Identifica o cartão utilizado (ver Tabela I)  |
// +---------------------------------------------------------------------------------+
  TRegistro6 = Record
    strTipReg: String; // 001 003 003 Num. Tipo de registro (“006”)
    strNum_PV: String; // 004 012 009 Num. Número do PV
    strNum_RV: String; // 013 021 009 Num. Número do RV
    strNumBco: String; // 022 024 003 Num. Nº do banco
    strNumAge: String; // 025 029 005 Num. Nº da agência
    strNumCCo: String; // 030 040 011 Num. Nº da conta-corrente
    strDta_RV: String; // 041 048 008 Num. Data do RV (DDMMAAAA)
    strQtdCVa: String; // 049 053 005 Num. Quantidade de CV/NSUs acatados (somente aprovadas)
    fltValBru: Double; // 054 068 015 9(13)V99 Valor bruto
    fltValGor: Double; // 069 083 015 9(13)V99 Valor da gorjeta
    fltValRej: Double; // 084 098 015 9(13)V99 Valor rejeitado (Transações manuais e TO)
    fltValDes: Double; // 099 113 015 9(13)V99 Valor do desconto
    fltValLiq: Double; // 114 128 015 9(13)V99 Valor líquido
    strDtaCre: String; // 129 136 008 Num. Data de crédito (DDMMAAAA)
    strCodBan: String; // 137 137 001 Alfa Bandeira (2)
  End;

// +------------------------------------------------------------------------------------------+
// |                            CRITÉRIOS DE EDIÇÃO DOS DADOS                                 |
// +------------------------------------------------------------------------------------------+
// | Tipo do registro          | “008” = CV/NSU crédito rotativo                              |
// +------------------------------------------------------------------------------------------+
// | Número do PV              | Código do Ponto de Venda                                     |
// +------------------------------------------------------------------------------------------+
// | Número do RV              | Número do Resumo de Vendas                                   |
// +------------------------------------------------------------------------------------------+
// | Data do CV/NSU (DDMMAAAA) | Data do Comprovante de Vendas                                |
// |                           | Numérico, no formato DDMMAAAA                                |
// +------------------------------------------------------------------------------------------+
// | Número do CV/NSU          | Número do Comprovante de Vendas                              |
// |                           | Contém zeros quando o CV/NSU é manual                        |
// +------------------------------------------------------------------------------------------+
// | Valor do CV/NSU           | Valor do Comprovante de Vendas                               |
// +------------------------------------------------------------------------------------------+
// | Valor da gorjeta          | Valor da gorjeta ou taxa de serviços cobrada no ato da venda |
// +------------------------------------------------------------------------------------------+
// | Número do cartão          | Número do cartão de crédito                                  |
// | Status do CV/NSU (4)      | Identifica se o CV/NSU foi acatado ou não e o motivo da      |
// |                           | rejeição em caso de não acatamento da operação (Tabela III)  |
// +------------------------------------------------------------------------------------------+
// | Número de referência      | Número enviado nas transações offline de vendas              |
// +------------------------------------------------------------------------------------------+
// | Valor do desconto         | Valor referente à taxa de desconto                           |
// +------------------------------------------------------------------------------------------+
// | Número da autorização     | Número da autorização                                        |
// +------------------------------------------------------------------------------------------+
// | Hora da transação         | Hora do CV/NSU (HHMMSS)                                      |
// +------------------------------------------------------------------------------------------+
// | Número do bilhete         | Número do bilhete aéreo (apenas para companhias aéreas)      |
// +------------------------------------------------------------------------------------------+
// | Tipo de captura           | Forma que foi capturada a transação – Tabela II              |
// +------------------------------------------------------------------------------------------+
// | Valor líquido             | Valor líquido                                                |
// +------------------------------------------------------------------------------------------+
// | Número do terminal        | Número do terminal que capturou a transação                  |
// +------------------------------------------------------------------------------------------+
// | Livre                     | Livre                                                        |
// +------------------------------------------------------------------------------------------+
// | Livre                     | Livre                                                        |
// +------------------------------------------------------------------------------------------+
  TRegistro8 = Record
    strTipReg: String; // 001 003 003 Num. Tipo de registro (“008”)
    strNum_PV: String; // 004 012 009 Num. Número do PV
    strNum_RV: String; // 013 021 009 Num. Número do RV
    strDta_CV: String; // 022 029 008 Num. Data do CV/NSU (DDMMAAAA)
    strZeros_: String; // 030 037 008 Num. Zeros
    fltVal_CV: Double; // 038 052 015 9(13)V99 Valor do CV/NSU
    fltValGer: Double; // 053 067 015 9(13)V99 Valor da gorjeta
    strNumCar: String; // 068 083 016 Alfa Número do cartão
    strSts_CV: String; // 084 086 003 Alfa Status do CV/NSU (4)
    strNum_CV: String; // 087 098 012 Num. Número do CV/NSU
    strNumRef: String; // 099 111 013 Alfa Número de Referência
    fltValDes: Double; // 112 126 015 9(13)V99 Valor do desconto
    strNumAut: String; // 127 132 006 Alfa Nº autorização
    strHraTra: String; // 133 138 006 Num. Hora da transação (HHMMSS)
    strNumBi1: String; // 139 154 016 Alfa Nº do bilhete
    strNumBi2: String; // 155 170 016 Alfa Nº do bilhete
    strNumBi3: String; // 171 186 016 Alfa Nº do bilhete
    strNumBi4: String; // 187 202 016 Alfa Nº do bilhete
    strTipCap: String; // 203 203 001 Alfa Tipo de captura
    fltValLiq: Double; // 204 218 015 9(13)V99 Valor líquido
    strNumTer: String; // 219 226 008 Alfa Número do terminal
    strSigPai: String; // 227 229 003 Alfa Sigla do país
    strCodBan: String; // 230 230 001 Alfa Bandeira
    strBaixad: String; // Se o registro já foi baixado no Autcom "S" ou "N"
    strSeqLot: String;  // Sequencial de controle por lote (6 números + CODEMP)
  End;

// +------------------------------------------------------------------------------------------+
// |                            CRITÉRIOS DE EDIÇÃO DOS DADOS                                 |
// +------------------------------------------------------------------------------------------+
// | Tipo do registro              | “010” = RV Parcelado sem juros                           |
// +------------------------------------------------------------------------------------------+
// | Nº PV                         | Código do Ponto de Venda                                 |
// +------------------------------------------------------------------------------------------+
// | Número do RV                  | Número do Resumo de Vendas                               |
// +------------------------------------------------------------------------------------------+
// | Nº do Banco                   | Código de registro do banco no Banco Central             |
// +------------------------------------------------------------------------------------------+
// | Nº da Agência                 | Prefixo da agência                                       |
// +------------------------------------------------------------------------------------------+
// | Nº da conta-corrente          | Número da conta-corrente                                 |
// +------------------------------------------------------------------------------------------+
// | Data do RV (DDMMAAAA)         | Data do Resumo de Vendas                                 |
// |                               | Numérico, no formato DDMMAAAA                            |
// +------------------------------------------------------------------------------------------+
// | Quantidade de CV/NSU´s        | Quantidade de Comprovantes de Vendas que compõem o RV    |
// +------------------------------------------------------------------------------------------+
// | Valor bruto                   | Soma dos valores dos Comprovantes de Vendas apresentados |
// |                               | ou capturados                                            |
// +------------------------------------------------------------------------------------------+
// | Valor da gorjeta              | Soma dos valores de gorjeta ou taxas de serviço cobrados |
// |                               | no ato da compra                                         |
// +------------------------------------------------------------------------------------------+
// | Valor rejeitado               | Soma dos valores dos comprovantes rejeitados             |
// +------------------------------------------------------------------------------------------+
// | Valor do desconto             | Valor referente à taxa de desconto                       |
// +------------------------------------------------------------------------------------------+
// | Valor líquido                 | Valor correspondente ao crédito que será realizado no    |
// |                               | domicílio bancário. Neste valor não estão contemplados   |
// |                               | os ajustes Net.                                          |
// +------------------------------------------------------------------------------------------+
// | Data de crédito da 1ª parcela | Data que o crédito será realizado                        |
// | (DDMMAAAA)                    | Numérico, no formato DDMMAAAA                            |
// +------------------------------------------------------------------------------------------+
// | Bandeira (2)                  | Identifica o cartão utilizado (ver Tabela I)             |
// +------------------------------------------------------------------------------------------+
  TRegistro10 = Record
    strTipReg: String; // 001 003 003 Num. Tipo de registro (“010”)
    strNum_PV: String; // 004 012 009 Num. Número do PV
    strNum_RV: String; // 013 021 009 Num. Número do RV
    strNumBco: String; // 022 024 003 Num. Nº do banco
    strNumAge: String; // 025 029 005 Num. Nº da agência
    strNumCCo: String; // 030 040 011 Num. Nº da conta-corrente
    strDta_RV: String; // 041 048 008 Num. Data do RV (DDMMAAAA)
    strQtd_CV: String; // 049 053 005 Num. Quantidade de CV/NSU´s
    fltValBru: Double; // 054 068 015 9(13)V99 Valor bruto
    fltValGor: Double; // 069 083 015 9(13)V99 Valor da gorjeta
    fltValRej: Double; // 084 098 015 9(13)V99 Valor rejeitado
    fltValDes: Double; // 099 113 015 9(13)V99 Valor do desconto
    fltValLiq: Double; // 114 128 015 9(13)V99 Valor líquido
    strDtaCre: String; // 129 136 008 Num. Data de crédito da 1ª parcela (DDMMAAAA)
    strCodBan: String; // 137 137 001 Alfa Bandeira (2)
  End;

// +------------------------------------------------------------------------------------------+
// |                            CRITÉRIOS DE EDIÇÃO DOS DADOS                                 |
// +------------------------------------------------------------------------------------------+
// | Tipo do registro          | “012” = CV/NSU Parcelado sem juros                           |
// +------------------------------------------------------------------------------------------+
// | Número do PV              | Código do Ponto de Venda                                     |
// +------------------------------------------------------------------------------------------+
// | Número do RV              | Número do Resumo de Vendas                                   |
// +------------------------------------------------------------------------------------------+
// | Data do CV/NSU (DDMMAAAA) | Data do Comprovante de Vendas                                |
// |                           | Numérico, no formato DDMMAAAA                                |
// +------------------------------------------------------------------------------------------+
// | Valor do CV/NSU           | Valor do Comprovante de Vendas                               |
// +------------------------------------------------------------------------------------------+
// | Valor da gorjeta          | Valor da gorjeta ou taxa de serviços cobrada no ato da venda |
// +------------------------------------------------------------------------------------------+
// | Número do cartão          | Número do cartão de crédito                                  |
// +------------------------------------------------------------------------------------------+
// | Status do CV/NSU (4)      | Identifica se o CV/NSU foi acatado ou não e o motivo da      |
// |                           | rejeição em caso de não acaTam.ento da operação (Tabela III) |
// +------------------------------------------------------------------------------------------+
// | Número de parcelas        | Quantidade de parcelas da transação                          |
// +------------------------------------------------------------------------------------------+
// | Número do CV/NSU          | Número do Comprovante de Vendas                              |
// |                           | Contém zeros quando o CV/NSU é manual                        |
// +------------------------------------------------------------------------------------------+
// | Número de referência      | Número enviado nas transações off-line de vendas             |
// +------------------------------------------------------------------------------------------+
// | Valor do desconto         | Valor referente à taxa de desconto                           |
// +------------------------------------------------------------------------------------------+
// | Número da autorização     | Número da autorização                                        |
// +------------------------------------------------------------------------------------------+
// | Hora da transação         | Hora do CV/NSU (HHMMSS)                                      |
// +------------------------------------------------------------------------------------------+
// | Número do bilhete         | Número do bilhete aéreo (apenas para companhias aéreas)      |
// +------------------------------------------------------------------------------------------+
// | Tipo de captura           | Forma que foi capturada a transação – Tabela II              |
// +------------------------------------------------------------------------------------------+
// | Valor líquido do CV/NSU   | Valor líquido do CV/NSU                                      |
// +------------------------------------------------------------------------------------------+
// | Valor líquido da primeira parcela                                                        |
// +------------------------------------------------------------------------------------------+
// | Valor líquido das demais parcelas                                                        |
// +------------------------------------------------------------------------------------------+
// | Número do terminal        | Número do terminal que capturou a transação                  |
// +------------------------------------------------------------------------------------------+
// | Reservado                                                                                |
// +------------------------------------------------------------------------------------------+
// | Reservado                                                                                |
// +------------------------------------------------------------------------------------------+
  TRegistro12 = Record
    strTipReg: String; // 001 003 003 Num. Tipo de registro (“012”)
    strNum_PV: String; // 004 012 009 Num. Número do PV
    strNum_RV: String; // 013 021 009 Num. Número do RV
    strDta_CV: String; // 022 029 008 Num. Data do CV/NSU (DDMMAAAA)
    strZeros_: String; // 030 037 008 Num. Zeros
    fltVal_CV: Double; // 038 052 015 9(13)V99 Valor do CV/NSU
    fltValGor: Double; // 053 067 015 9(13)V99 Valor da gorjeta
    strNumCar: String; // 068 083 016 Alfa Número do cartão
    strSts_CV: String; // 084 086 003 Alfa Status do CV/NSU (1)
    strQtdPar: String; // 087 088 002 Num. Número de parcelas
    strNum_CV: String; // 089 100 012 Num. Número do CV/NSU
    strNumRef: String; // 101 113 013 Alfa Número de Referência
    fltValDes: Double; // 114 128 015 9(13)V99 Valor do desconto
    strNumAut: String; // 129 134 006 Alfa Nº Autorização
    strHraTra: String; // 135 140 006 Num. Hora da transação (HHMMSS)
    strNumBi1: String; // 141 156 016 Alfa Nº do bilhete
    strNumBi2: String; // 157 172 016 Alfa Nº do bilhete
    strNumBi3: String; // 173 188 016 Alfa Nº do bilhete
    strNumBi4: String; // 189 204 016 Alfa Nº do bilhete
    strTipCap: String; // 205 205 001 Alfa Tipo de captura
    fltValLiq: Double; // 206 220 015 9(13)V99 Valor líquido do CV/NSU
    fltLiqPri: Double; // 221 235 015 9(13)V99 Valor líquido da primeira parcela
    fltLiqDem: Double; // 236 250 015 9(13)V99 Valor líquido das demais parcelas
    strNumTer: String; // 251 258 008 Alfa Número do terminal
    strSigPai: String; // 259 261 003 Alfa Sigla do país
    strCodBan: String; // 262 262 001 Alfa Bandeira
    strBaixad: String; // Se o registro já foi baixado no Autcom "S" ou "N"
    strSeqLot: String;  // Sequencial de controle por lote (6 números + CODEMP)
  End;

// +------------------------------------------------------------------------------------------+
// |                            CRITÉRIOS DE EDIÇÃO DOS DADOS                                 |
// +------------------------------------------------------------------------------------------+
// | Tipo do registro             | “014” = Parcelas - parcelado sem juros                    |
// +------------------------------------------------------------------------------------------+
// | Número do PV                 | Código do Ponto de Venda                                  |
// +------------------------------------------------------------------------------------------+
// | Número do RV                 | Número do Resumo de Vendas                                |
// +------------------------------------------------------------------------------------------+
// | Data do RV (DDMMAAAA)        | Data do Resumo de Vendas                                  |
// |                              | Numérico, no formato DDMMAAAA                             |
// +------------------------------------------------------------------------------------------+
// | Brancos                      |                                                           |
// +------------------------------------------------------------------------------------------+
// | Número da parcela            | Número sequencial da parcela                              |
// +------------------------------------------------------------------------------------------+
// | Valor da parcela             | Valor da parcela líquida                                  |
// +------------------------------------------------------------------------------------------+
// | Valor do desconto da parcela | Valor a deduzir da parcela                                |
// +------------------------------------------------------------------------------------------+
// | Data do crédito (DDMMAAAA)   | Data que o crédito será realizado                         |
// |                              | Formato DDMMAAAA                                          |
// +------------------------------------------------------------------------------------------+
  TRegistro14 = Record
    strTipReg: String; // 001 003 003 Num. Tipo de registro (“014”)
    strNum_PV: String; // 004 012 009 Num. Número do PV
    strNum_RV: String; // 013 021 009 Num. Número do RV
    strDta_RV: String; // 022 029 008 Num. Data do RV (DDMMAAAA)
    strQtdPar: String; // 038 039 002 Num. Número da parcela
    fltValBru: Double; // 040 054 015 9(13)V99 Valor da parcela bruto
    fltValDes: Double; // 055 069 015 9(13)V99 Valor do desconto sobre a parcela
    fltValLiq: Double; // 070 084 015 9(13)V99 Valor da parcela líquida
    strDtaCre: String; // 085 092 008 Num. Data do crédito (DDMMAAAA)
  End;

// +------------------------------------------------------------------------------------------+
// |                            CRITÉRIOS DE EDIÇÃO DOS DADOS                                 |
// +------------------------------------------------------------------------------------------+
// | Tipo do registro             | “034” = Créditos / "036" = Antecipações                   |
// +------------------------------------------------------------------------------------------+
// | Número do PV                 | Número do PV creditado                                    |
// +------------------------------------------------------------------------------------------+
// | Número do documento          | Número da Ordem de crédito                                |
// +------------------------------------------------------------------------------------------+
// | Data do lançamento           | Data que será realizado o lançamento no domicílio bancário|
// +------------------------------------------------------------------------------------------+
// | Valor do lançamento          | Valor do lançamento a ser realizado                       |
// +------------------------------------------------------------------------------------------+
// | C (crédito)                  | Indicador de crédito                                      |
// +------------------------------------------------------------------------------------------+
// | Banco                        | Código de Registro do Banco no Banco Central              |
// +------------------------------------------------------------------------------------------+
// | Agência                      | Prefixo da agência                                        |
// +------------------------------------------------------------------------------------------+
// | Conta-corrente               | Número da Conta-corrente                                  |
// +------------------------------------------------------------------------------------------+
// | Data do movimento (DDMMAAAA) | Data da emissão da ODC DDMMAAAA                           |
// +------------------------------------------------------------------------------------------+
// | Número do RV                 | Número do RV que originou o crédito                       |
// +------------------------------------------------------------------------------------------+
// | Data do RV (DDMMAAAA)        | Data do RV no formato DDMMAAAA                            |
// +------------------------------------------------------------------------------------------+
// | Bandeira                     | Identifica a bandeira do cartão                           |
// +------------------------------------------------------------------------------------------+
// | Tipo de transação            | Identifica transações à vista, parceladas, etc. (Tabela I)|
// +------------------------------------------------------------------------------------------+
// | Valor bruto do RV            | Valor total do RV acatado pela Rede no processamento, já  |
// |                              | descontadas as rejeições                                  |
// +------------------------------------------------------------------------------------------+
// | Valor da taxa de desconto    | Valor total da taxa de desconto                           |
// +------------------------------------------------------------------------------------------+
// | Número da Parcela/Total      | Número da parcela/total que será creditada, caso seja um  |
// |                              | resumo parcelado (XX/XX)                                  |
// +------------------------------------------------------------------------------------------+
// | Status do Crédito            | Status do crédito - Tabela II                             |
// +------------------------------------------------------------------------------------------+
// | Número do PV Original        | Número do PV que originou o crédito                       |
// +------------------------------------------------------------------------------------------+
  TRegistro34 = Record
    strTipReg: String; // 001 003 003 Num. Tipo de registro (“034” "036")
    strNum_PV: String; // 004 012 009 Num. Número do PV centralizador
    strNumDoc: String; // 013 023 011 Num. Número do documento
    strDtaLan: String; // 024 031 008 Num. Data do lançamento (DDMMAAAA)
    fltValLan: Double; // 032 046 015 9(13)V99 Valor do lançamento
    strCredit: String; // 047 047 001 Alfa C (crédito)
    strNumBco: String; // 048 050 003 Num. Banco
    strNumAge: String; // 051 056 006 Num. Agência
    strNumCCo: String; // 057 067 011 Num. Conta-corrente
    strDtaMov: String; // 068 075 008 Num. Data do movimento (DDMMAAAA)
    strNum_RV: String; // 076 084 009 Num. Número do RV
    strDta_RV: String; // 085 092 008 Num. Data do RV (DDMMAAAA)
    strCodBan: String; // 093 093 001 Num. Bandeira
    strTipTra: String; // 094 094 001 Num. Tipo de transação
    fltValBru: Double; // 095 109 015 9(13)V99 Valor bruto do RV
    fltValDes: Double; // 110 124 015 9(13)V99 Valor da taxa de desconto
    strParTot: String; // 125 129 005 Alfa Número da parcela/total
    strStsCre: String; // 130 131 002 Alfa Status do crédito - Tabela II
    strPV_Ori: String; // 132 140 009 Num. Nº PV Original
    strDtaVen: String; // Vencimento Original (Registro "036")
    fltValOri: Double; // crédito Original (Registro "036")
    strDtaArq: String; //Data do arquivo importado
    strNomArq: String; //Nome do arquivo eefi importado
    strParcel: String; //Parcela
    strDtaImp: String; // Data da Importação
    strCarDeb: String; // Cartão do registro 35
    strRegDeb: String; //Verifica se possui registro 035
    fltValDeb: Double; //Valor do Débito
    strAutDeb: String; //Código da autorização do~Débito
    strNSUDeb: String; //Número da NSU da Autorização do Débito
    strMotAju: String; // Motivo do Ajuste

    TipoNegociacao,
    ContratoNegociacao,
    CNPJParceiro,
    NumeroOC,
    DataNegociacao: String;
  End;

  TEstruturaCred = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistro6  = Array Of TRegistro6;
  TArrRegistro8  = Array Of TRegistro8;
  TArrRegistro10 = Array Of TRegistro10;
  TArrRegistro12 = Array Of TRegistro12;
  TArrRegistro14 = Array Of TRegistro14;
  TArrRegistro34 = Array Of TRegistro34;
  TArrEstruturaCred = Array Of TEstruturaCred;

  TRedeCredito = Class(TInterfacedObject, ICartoes)
  Private
    FstrNomEmp: String;

    intPosicaoAtualFReg6,
    intPosicaoAtualFReg8,
    intPosicaoAtualFReg10,
    intPosicaoAtualFReg12,
    intPosicaoAtualFReg14,
    intPosicaoAtualFReg34,
    LContadorReg35: Integer;

    function fFloatToInt(fltNumero: Double): Integer;
    function fGetLetraAlfa(intCol: Integer): String;
  Public
    property strNomEmp: String read FstrNomEmp write FstrNomEmp;

    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaReg6: String;
    class function fRetSQLTabelaReg8: String;
    class function fRetSQLTabelaReg10: String;
    class function fRetSQLTabelaReg12: String;
    class function fRetSQLTabelaReg14: String;
    class function fRetSQLTabelaReg34: String;
    class function fRetEstruturaCred(strTabela: String): TArrEstruturaCred;
  End;

Var
  strNomArq: String;
  strDtaArq: String;
  VersaoMenil: Boolean;

implementation

uses untFuncoes, untIDataSet {$IF Defined(VER180)} {$ELSE}, untRelCartaoImportacao {$IFEND};

{ TRedeCredito }

constructor TRedeCredito.Create;
begin
  intPosicaoAtualFReg6  := 0;
  intPosicaoAtualFReg8  := 0;
  intPosicaoAtualFReg10 := 0;
  intPosicaoAtualFReg12 := 0;
  intPosicaoAtualFReg14 := 0;
  intPosicaoAtualFReg34 := 0;

  LContadorReg35 := 1;
end;

{**********************************************}
{* RETORNA A ESTRUTURA DAS TABELAS DE CRÉDITO *}
{* RED_EVCR06, RED_EVCR08, RED_EVCR10,        *}
{* RED_EVCR12, RED_EVCR14 E RED_EFIR34        *}
{*REQ. 32397 02/04/2015*********************JU*}
class function TRedeCredito.fRetEstruturaCred(strTabela: String): TArrEstruturaCred;
Begin

  If strTabela = 'RED_EVCR06' Then
  Begin
    SetLength(Result, 15);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_NUMBCO'; Result[3].strTipCmp  := 'CHAR(3)'      ;
    Result[4].strDescri  := 'RED_NUMAGE'; Result[4].strTipCmp  := 'VARCHAR(5)'   ;
    Result[5].strDescri  := 'RED_NUMCCO'; Result[5].strTipCmp  := 'VARCHAR(11)'  ;
    Result[6].strDescri  := 'RED_DTA_RV'; Result[6].strTipCmp  := 'DATE'         ;
    Result[7].strDescri  := 'RED_QTDCVA'; Result[7].strTipCmp  := 'VARCHAR(5)'   ;
    Result[8].strDescri  := 'RED_VALBRU'; Result[8].strTipCmp  := 'DECIMAL(13,2)';
    Result[9].strDescri  := 'RED_VALGOR'; Result[9].strTipCmp  := 'DECIMAL(13,2)';
    Result[10].strDescri := 'RED_VALREJ'; Result[10].strTipCmp := 'DECIMAL(13,2)';
    Result[11].strDescri := 'RED_VALDES'; Result[11].strTipCmp := 'DECIMAL(13,2)';
    Result[12].strDescri := 'RED_VALLIQ'; Result[12].strTipCmp := 'DECIMAL(13,2)';
    Result[13].strDescri := 'RED_DTACRE'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'RED_CODBAN'; Result[14].strTipCmp := 'CHAR(1)'      ;

  End
  Else If strTabela = 'RED_EVCR08' Then
  Begin
    SetLength(Result, 24);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_DTA_CV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_VAL_CV'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
    Result[5].strDescri  := 'RED_VALGER'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
    Result[6].strDescri  := 'RED_NUMCAR'; Result[6].strTipCmp  := 'VARCHAR(16)'  ;
    Result[7].strDescri  := 'RED_STS_CV'; Result[7].strTipCmp  := 'VARCHAR(4)'   ;
    Result[8].strDescri  := 'RED_NUM_CV'; Result[8].strTipCmp  := 'VARCHAR(12)'  ;
    Result[9].strDescri  := 'RED_NUMREF'; Result[9].strTipCmp  := 'VARCHAR(13)'  ;
    Result[10].strDescri := 'RED_VALDES'; Result[10].strTipCmp := 'DECIMAL(13,2)';
    Result[11].strDescri := 'RED_NUMAUT'; Result[11].strTipCmp := 'VARCHAR(6)'   ;
    Result[12].strDescri := 'RED_HRATRA'; Result[12].strTipCmp := 'TIME'         ;
    Result[13].strDescri := 'RED_NUMBI1'; Result[13].strTipCmp := 'VARCHAR(16)'  ;
    Result[14].strDescri := 'RED_NUMBI2'; Result[14].strTipCmp := 'VARCHAR(16)'  ;
    Result[15].strDescri := 'RED_NUMBI3'; Result[15].strTipCmp := 'VARCHAR(16)'  ;
    Result[16].strDescri := 'RED_NUMBI4'; Result[16].strTipCmp := 'VARCHAR(16)'  ;
    Result[17].strDescri := 'RED_TIPCAP'; Result[17].strTipCmp := 'CHAR(1)'      ;
    Result[18].strDescri := 'RED_VALLIQ'; Result[18].strTipCmp := 'DECIMAL(13,2)';
    Result[19].strDescri := 'RED_NUMTER'; Result[19].strTipCmp := 'VARCHAR(8)'   ;
    Result[20].strDescri := 'RED_SIGPAI'; Result[20].strTipCmp := 'CHAR(3)'      ;
    Result[21].strDescri := 'RED_CODBAN'; Result[21].strTipCmp := 'CHAR(1)'      ;
    Result[22].strDescri := 'RED_BAIXAD'; Result[22].strTipCmp := 'CHAR(1)'      ;
    Result[23].strDescri := 'RED_SEQLOT'; Result[23].strTipCmp := 'VARCHAR(9)'   ;

  End
  Else If strTabela = 'RED_EVCR10' Then
  Begin
    SetLength(Result, 15);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_CODBCO'; Result[3].strTipCmp  := 'CHAR(3)'      ;
    Result[4].strDescri  := 'RED_NUMAGE'; Result[4].strTipCmp  := 'VARCHAR(5)'   ;
    Result[5].strDescri  := 'RED_NUMCCO'; Result[5].strTipCmp  := 'VARCHAR(11)'  ;
    Result[6].strDescri  := 'RED_DTA_RV'; Result[6].strTipCmp  := 'DATE'         ;
    Result[7].strDescri  := 'RED_QTD_CV'; Result[7].strTipCmp  := 'VARCHAR(5)'   ;
    Result[8].strDescri  := 'RED_VALBRU'; Result[8].strTipCmp  := 'DECIMAL(13,2)';
    Result[9].strDescri  := 'RED_VALGOR'; Result[9].strTipCmp  := 'DECIMAL(13,2)';
    Result[10].strDescri := 'RED_VALREJ'; Result[10].strTipCmp := 'DECIMAL(13,2)';
    Result[11].strDescri := 'RED_VALDES'; Result[11].strTipCmp := 'DECIMAL(13,2)';
    Result[12].strDescri := 'RED_VALLIQ'; Result[12].strTipCmp := 'DECIMAL(13,2)';
    Result[13].strDescri := 'RED_DTACRE'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'RED_CODBAN'; Result[14].strTipCmp := 'CHAR(1)'      ;

  End
  Else If strTabela = 'RED_EVCR12' Then
  Begin
    SetLength(Result, 27);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_DTA_CV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_VAL_CV'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
    Result[5].strDescri  := 'RED_VALGOR'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
    Result[6].strDescri  := 'RED_NUMCCO'; Result[6].strTipCmp  := 'VARCHAR(16)'  ;
    Result[7].strDescri  := 'RED_STS_CV'; Result[7].strTipCmp  := 'CHAR(3)'      ;
    Result[8].strDescri  := 'RED_QTDPAR'; Result[8].strTipCmp  := 'CHAR(2)'      ;
    Result[9].strDescri  := 'RED_NUM_CV'; Result[9].strTipCmp  := 'VARCHAR(12)'  ;
    Result[10].strDescri := 'RED_NUMREF'; Result[10].strTipCmp := 'VARCHAR(13)'  ;
    Result[11].strDescri := 'RED_VALDES'; Result[11].strTipCmp := 'DECIMAL(13,2)';
    Result[12].strDescri := 'RED_NUMAUT'; Result[12].strTipCmp := 'VARCHAR(6)'   ;
    Result[13].strDescri := 'RED_HRATRA'; Result[13].strTipCmp := 'TIME'         ;
    Result[14].strDescri := 'RED_NUMBI1'; Result[14].strTipCmp := 'VARCHAR(16)'  ;
    Result[15].strDescri := 'RED_NUMBI2'; Result[15].strTipCmp := 'VARCHAR(16)'  ;
    Result[16].strDescri := 'RED_NUMBI3'; Result[16].strTipCmp := 'VARCHAR(16)'  ;
    Result[17].strDescri := 'RED_NUMBI4'; Result[17].strTipCmp := 'VARCHAR(16)'  ;
    Result[18].strDescri := 'RED_TIPCAP'; Result[18].strTipCmp := 'CHAR(1)'      ;
    Result[19].strDescri := 'RED_VALLIQ'; Result[19].strTipCmp := 'DECIMAL(13,2)';
    Result[20].strDescri := 'RED_LIQPRI'; Result[20].strTipCmp := 'DECIMAL(13,2)';
    Result[21].strDescri := 'RED_LIQDEM'; Result[21].strTipCmp := 'DECIMAL(13,2)';
    Result[22].strDescri := 'RED_NUMTER'; Result[22].strTipCmp := 'VARCHAR(8)'   ;
    Result[23].strDescri := 'RED_SIGPAI'; Result[23].strTipCmp := 'VARCHAR(3)'   ;
    Result[24].strDescri := 'RED_CODBAN'; Result[24].strTipCmp := 'CHAR(1)'      ;
    Result[25].strDescri := 'RED_BAIXAD'; Result[25].strTipCmp := 'CHAR(1)'      ;
    Result[26].strDescri := 'RED_SEQLOT'; Result[26].strTipCmp := 'VARCHAR(9)'   ;

  End
  Else If strTabela = 'RED_EVCR14' Then
  Begin
    SetLength(Result, 9);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'RED_DTA_RV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_QTDPAR'; Result[4].strTipCmp  := 'CHAR(2)'      ;
    Result[5].strDescri  := 'RED_VALBRU'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
    Result[6].strDescri  := 'RED_VALDES'; Result[6].strTipCmp  := 'DECIMAL(13,2)';
    Result[7].strDescri  := 'RED_VALLIQ'; Result[7].strTipCmp  := 'DECIMAL(13,2)';
    Result[8].strDescri  := 'RED_DTACRE'; Result[8].strTipCmp  := 'DATE'         ;

  End
  Else If strTabela = 'RED_EFIR34' Then
  Begin
    SetLength(Result, 36);

    Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(3)'      ;
    Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
    Result[2].strDescri  := 'RED_NUMDOC'; Result[2].strTipCmp  := 'VARCHAR(11)'  ;
    Result[3].strDescri  := 'RED_DTALAN'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'RED_VALLAN'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
    Result[5].strDescri  := 'RED_CREDIT'; Result[5].strTipCmp  := 'CHAR(1)'      ;
    Result[6].strDescri  := 'RED_NUMBCO'; Result[6].strTipCmp  := 'CHAR(3)'      ;
    Result[7].strDescri  := 'RED_NUMAGE'; Result[7].strTipCmp  := 'VARCHAR(6)'   ;
    Result[8].strDescri  := 'RED_NUMCCO'; Result[8].strTipCmp  := 'VARCHAR(11)'  ;
    Result[9].strDescri  := 'RED_DTAMOV'; Result[9].strTipCmp  := 'DATE'         ;
    Result[10].strDescri := 'RED_NUM_RV'; Result[10].strTipCmp := 'VARCHAR(9)'   ;
    Result[11].strDescri := 'RED_DTA_RV'; Result[11].strTipCmp := 'DATE'         ;
    Result[12].strDescri := 'RED_CODBAN'; Result[12].strTipCmp := 'CHAR(1)'      ;
    Result[13].strDescri := 'RED_TIPTRA'; Result[13].strTipCmp := 'CHAR(1)'      ;
    Result[14].strDescri := 'RED_VALBRU'; Result[14].strTipCmp := 'DECIMAL(13,2)';
    Result[15].strDescri := 'RED_VALDES'; Result[15].strTipCmp := 'DECIMAL(13,2)';
    Result[16].strDescri := 'RED_PARTOT'; Result[16].strTipCmp := 'VARCHAR(5)'   ;
    Result[17].strDescri := 'RED_STSCRE'; Result[17].strTipCmp := 'CHAR(2)'      ;
    Result[18].strDescri := 'RED_PV_ORI'; Result[18].strTipCmp := 'VARCHAR(9)'   ;
    Result[19].strDescri := 'RED_DTAVEN'; Result[19].strTipCmp := 'DATE'         ;
    Result[19].strDescri := 'RED_VALORI'; Result[19].strTipCmp := 'DECIMAL(15,2)';
    Result[20].strDescri := 'RED_DTAARQ'; Result[20].strTipCmp := 'DATE'         ;
    Result[21].strDescri := 'RED_NOMARQ'; Result[21].strTipCmp := 'VARCHAR(255)' ;
    Result[22].strDescri := 'RED_CONCIL'; Result[22].strTipCmp := 'INTEGER DEFAULT 0';
    Result[22].strDescri := 'RED_PARCEL'; Result[22].strTipCmp := 'CHAR(1)       ';
    Result[23].strDescri := 'RED_IMPTOT'; Result[23].strTipCmp := 'INTEGER DEFAULT 0';
    Result[24].strDescri := 'RED_DTAIMP'; Result[24].strTipCmp := 'DATE'         ;
    Result[25].strDescri := 'RED_CARDEB'; Result[25].strTipCmp := 'VARCHAR(16)'  ;
    Result[26].strDescri := 'RED_REGDEB'; Result[26].strTipCmp := 'CHAR(3)'      ;
    Result[27].strDescri := 'RED_VALDEB'; Result[27].strTipCmp := 'DECIMAL(15,2)';
    Result[28].strDescri := 'RED_AUTDEB'; Result[28].strTipCmp := 'VARCHAR(6)'   ;
    Result[29].strDescri := 'RED_NSUDEB'; Result[29].strTipCmp := 'VARCHAR(12)'  ;
    Result[30].strDescri := 'RED_MOTAJU'; Result[30].strTipCmp := 'VARCHAR(28)'  ;
    Result[31].strDescri := 'RED_CONNEG'; Result[31].strTipCmp := 'VARCHAR(17)'  ;
    Result[32].strDescri := 'RED_CNPPAR'; Result[32].strTipCmp := 'VARCHAR(15)'  ;
    Result[33].strDescri := 'RED_NUM_OC'; Result[33].strTipCmp := 'VARCHAR(11) DEFAULT '''''  ;
    Result[34].strDescri := 'RED_DTANEG'; Result[34].strTipCmp := 'DATE'         ;
    Result[35].strDescri := 'RED_TIPNEG'; Result[35].strTipCmp := 'VARCHAR(1)'   ;
  End;

End;

class function TRedeCredito.fRetSQLTabelaReg6: String;
begin
  Result := 'CREATE TABLE RED_EVCR06(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_NUMBCO CHAR(03),                  ' +
            '  RED_NUMAGE VARCHAR(05),               ' +
            '  RED_NUMCCO VARCHAR(11),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_QTDCVA VARCHAR(05),               ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALGOR DECIMAL(13,2),             ' +
            '  RED_VALREJ DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_DTACRE DATE,                      ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_DTA_RV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg8: String;
begin
  Result := 'CREATE TABLE RED_EVCR08(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_CV DATE,                      ' +
            '  RED_VAL_CV DECIMAL(13,2),             ' +
            '  RED_VALGER DECIMAL(13,2),             ' +
            '  RED_NUMCAR VARCHAR(16),               ' +
            '  RED_STS_CV VARCHAR(04),               ' +
            '  RED_NUM_CV VARCHAR(12),               ' +
            '  RED_NUMREF VARCHAR(13),               ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_NUMAUT VARCHAR(06),               ' +
            '  RED_HRATRA TIME,                      ' +
            '  RED_NUMBI1 VARCHAR(16),               ' +
            '  RED_NUMBI2 VARCHAR(16),               ' +
            '  RED_NUMBI3 VARCHAR(16),               ' +
            '  RED_NUMBI4 VARCHAR(16),               ' +
            '  RED_TIPCAP CHAR(01),                  ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_NUMTER VARCHAR(08),               ' +
            '  RED_SIGPAI CHAR(03),                  ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  RED_BAIXAD CHAR(01),                  ' +
            '  RED_SEQLOT VARCHAR(09),               ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_NUM_CV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg10: String;
begin
  Result := 'CREATE TABLE RED_EVCR10(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_CODBCO CHAR(03),                  ' +
            '  RED_NUMAGE VARCHAR(05),               ' +
            '  RED_NUMCCO VARCHAR(11),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_QTD_CV VARCHAR(05),               ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALGOR DECIMAL(13,2),             ' +
            '  RED_VALREJ DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_DTACRE DATE,                      ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_DTA_RV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg12: String;
begin
  Result := 'CREATE TABLE RED_EVCR12(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_CV DATE,                      ' +
            '  RED_VAL_CV DECIMAL(13,2),             ' +
            '  RED_VALGOR DECIMAL(13,2),             ' +
            '  RED_NUMCCO VARCHAR(16),               ' +
            '  RED_STS_CV CHAR(03),                  ' +
            '  RED_QTDPAR CHAR(02),                  ' +
            '  RED_NUM_CV VARCHAR(12),               ' +
            '  RED_NUMREF VARCHAR(13),               ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_NUMAUT VARCHAR(06),               ' +
            '  RED_HRATRA TIME,                      ' +
            '  RED_NUMBI1 VARCHAR(16),               ' +
            '  RED_NUMBI2 VARCHAR(16),               ' +
            '  RED_NUMBI3 VARCHAR(16),               ' +
            '  RED_NUMBI4 VARCHAR(16),               ' +
            '  RED_TIPCAP VARCHAR(01),               ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_LIQPRI DECIMAL(13,2),             ' +
            '  RED_LIQDEM DECIMAL(13,2),             ' +
            '  RED_NUMTER VARCHAR(08),               ' +
            '  RED_SIGPAI CHAR(03),                  ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  RED_BAIXAD CHAR(01),                  ' +
            '  RED_SEQLOT VARCHAR(09),               ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_NUM_CV)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg14: String;
begin
  Result := 'CREATE TABLE RED_EVCR14(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_QTDPAR CHAR(02),                  ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_DTACRE DATE,                      ' +
            '  PRIMARY KEY(RED_TIPREG,RED_NUM_PV,RED_NUM_RV,RED_DTA_RV,RED_QTDPAR)) ENGINE INNODB';
end;

class function TRedeCredito.fRetSQLTabelaReg34: String;
begin
  Result := 'CREATE TABLE RED_EFIR34(                ' +
            '  RED_TIPREG CHAR(03),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUMDOC VARCHAR(11),               ' +
            '  RED_DTALAN DATE,                      ' +
            '  RED_VALLAN DECIMAL(13,2),             ' +
            '  RED_CREDIT CHAR(01),                  ' +
            '  RED_NUMBCO CHAR(03),                  ' +
            '  RED_NUMAGE VARCHAR(06),               ' +
            '  RED_NUMCCO VARCHAR(11),               ' +
            '  RED_DTAMOV DATE,                      ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_RV DATE,                      ' +
            '  RED_CODBAN VARCHAR(01),               ' +
            '  RED_TIPTRA VARCHAR(01),               ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_PARTOT VARCHAR(05),               ' +
            '  RED_STSCRE CHAR(02),                  ' +
            '  RED_PV_ORI VARCHAR(09),               ' +
            '  RED_DTAVEN DATE,                      ' +
            '  RED_VALORI DECIMAL(15,2),             ' +
            '  RED_DTAARQ DATE,                      ' +
            '  RED_NOMARQ VARCHAR(255),              ' +
            '  RED_CONCIL INTEGER DEFAULT 0,         ' +
            '  RED_PARCEL CHAR(1),                   ' +
            '  RED_IMPTOT INTEGER DEFAULT 0,         ' +
            '  RED_DTAIMP DATE,                      ' +
            '  RED_CARDEB VARCHAR(16),               ' +
            '  RED_REGDEB CHAR(3),                   ' +
            '  RED_VALDEB DECIMAL(15,2),             ' +
            '  RED_AUTDEB VARCHAR(6),                ' +
            '  RED_NSUDEB VARCHAR(12),               ' +
            '  RED_MOTAJU VARCHAR(28),               ' +
            '  RED_TIPNEG VARCHAR(1),                ' +
            '  RED_CONNEG VARCHAR(17),               ' +
            '  RED_CNPPAR VARCHAR(15),               ' +
            '  RED_NUM_OC VARCHAR(11) DEFAUT '''',   ' +
            '  RED_DTANEG DATE,                      ' +
            '  PRIMARY KEY(RED_TIPREG,               ' +
            '              RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_DTA_RV,               ' +
            '              RED_PARTOT,               ' +
            '              RED_NUM_OC)) ENGINE INNODB';
end;

procedure TRedeCredito.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;

  function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    Var
      rst: Variant;
  Begin
    rst := Trim(Copy(strString, intIni, intTam));
    If blnFlt Then rst := fStrToFloat(rst) / 100;

    Result := rst;
  End;

begin

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If LeftStr(strString, 3) = '006' Then
  Begin
    If intPosicaoAtualFReg6 = Length(FReg6) Then
    Begin
      SetLength(FReg6, Length(FReg6)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg6[intPosicaoAtualFReg6].strTipReg := fGetDados(001,03);
    FReg6[intPosicaoAtualFReg6].strNum_PV := fGetDados(004,09);
    FReg6[intPosicaoAtualFReg6].strNum_RV := fGetDados(013,09);
    FReg6[intPosicaoAtualFReg6].strNumBco := fGetDados(022,03);
    FReg6[intPosicaoAtualFReg6].strNumAge := fGetDados(025,05);
    FReg6[intPosicaoAtualFReg6].strNumCCo := fGetDados(030,11);
    FReg6[intPosicaoAtualFReg6].strDta_RV := fGetDados(041,08);
    FReg6[intPosicaoAtualFReg6].strQtdCVa := fGetDados(049,05);
    FReg6[intPosicaoAtualFReg6].fltValBru := fGetDados(054,15,True);
    FReg6[intPosicaoAtualFReg6].fltValGor := fGetDados(069,15,True);
    FReg6[intPosicaoAtualFReg6].fltValRej := fGetDados(084,15,True);
    FReg6[intPosicaoAtualFReg6].fltValDes := fGetDados(099,15,True);
    FReg6[intPosicaoAtualFReg6].fltValLiq := fGetDados(114,15,True);
    FReg6[intPosicaoAtualFReg6].strDtaCre := fGetDados(129,08);
    FReg6[intPosicaoAtualFReg6].strCodBan := fGetDados(137,01);

    Inc(intPosicaoAtualFReg6);
  End

  Else If LeftStr(strString, 3) = '008' Then
  Begin
    If intPosicaoAtualFReg8 = Length(FReg8) Then
    Begin
      SetLength(FReg8, Length(FReg8)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg8[intPosicaoAtualFReg8].strTipReg := fGetDados(001,03);
    FReg8[intPosicaoAtualFReg8].strNum_PV := fGetDados(004,09);
    FReg8[intPosicaoAtualFReg8].strNum_RV := fGetDados(013,09);
    FReg8[intPosicaoAtualFReg8].strDta_CV := fGetDados(022,08);
    FReg8[intPosicaoAtualFReg8].strZeros_ := fGetDados(030,08);
    FReg8[intPosicaoAtualFReg8].fltVal_CV := fGetDados(038,15,True);
    FReg8[intPosicaoAtualFReg8].fltValGer := fGetDados(053,15,True);
    FReg8[intPosicaoAtualFReg8].strNumCar := fGetDados(068,16);
    FReg8[intPosicaoAtualFReg8].strSts_CV := fGetDados(084,03);
    FReg8[intPosicaoAtualFReg8].strNum_CV := fGetDados(087,12);
    FReg8[intPosicaoAtualFReg8].strNumRef := fGetDados(099,13);
    FReg8[intPosicaoAtualFReg8].fltValDes := fGetDados(112,15,True);
    FReg8[intPosicaoAtualFReg8].strNumAut := fGetDados(127,06);
    FReg8[intPosicaoAtualFReg8].strHraTra := fGetDados(133,06);
    FReg8[intPosicaoAtualFReg8].strNumBi1 := fGetDados(139,16);
    FReg8[intPosicaoAtualFReg8].strNumBi2 := fGetDados(155,16);
    FReg8[intPosicaoAtualFReg8].strNumBi3 := fGetDados(171,16);
    FReg8[intPosicaoAtualFReg8].strNumBi4 := fGetDados(187,16);
    FReg8[intPosicaoAtualFReg8].strTipCap := fGetDados(203,01);
    FReg8[intPosicaoAtualFReg8].fltValLiq := fGetDados(204,15,True);
    FReg8[intPosicaoAtualFReg8].strNumTer := fGetDados(219,08);
    FReg8[intPosicaoAtualFReg8].strSigPai := fGetDados(227,03);
    FReg8[intPosicaoAtualFReg8].strCodBan := fGetDados(230,01);
    FReg8[intPosicaoAtualFReg8].strBaixad := 'N';
    FReg8[intPosicaoAtualFReg8].strSeqLot := '';

    Inc(intPosicaoAtualFReg8);
  End

  Else If LeftStr(strString, 3) = '010' Then
  Begin
    If intPosicaoAtualFReg10 = Length(FReg10) Then
    Begin
      SetLength(FReg10, Length(FReg10)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg10[intPosicaoAtualFReg10].strTipReg := fGetDados(001,03);
    FReg10[intPosicaoAtualFReg10].strNum_PV := fGetDados(004,09);
    FReg10[intPosicaoAtualFReg10].strNum_RV := fGetDados(013,09);
    FReg10[intPosicaoAtualFReg10].strNumBco := fGetDados(022,03);
    FReg10[intPosicaoAtualFReg10].strNumAge := fGetDados(025,05);
    FReg10[intPosicaoAtualFReg10].strNumCCo := fGetDados(030,11);
    FReg10[intPosicaoAtualFReg10].strDta_RV := fGetDados(041,08);
    FReg10[intPosicaoAtualFReg10].strQtd_CV := fGetDados(049,05);
    FReg10[intPosicaoAtualFReg10].fltValBru := fGetDados(054,15,True);
    FReg10[intPosicaoAtualFReg10].fltValGor := fGetDados(069,15,True);
    FReg10[intPosicaoAtualFReg10].fltValRej := fGetDados(084,15,True);
    FReg10[intPosicaoAtualFReg10].fltValDes := fGetDados(099,15,True);
    FReg10[intPosicaoAtualFReg10].fltValLiq := fGetDados(114,15,True);
    FReg10[intPosicaoAtualFReg10].strDtaCre := fGetDados(129,08);
    FReg10[intPosicaoAtualFReg10].strCodBan := fGetDados(137,01);

    Inc(intPosicaoAtualFReg10);
  End

  Else If LeftStr(strString, 3) = '012' Then
  Begin
    If intPosicaoAtualFReg12 = Length(FReg12) Then
    Begin
      SetLength(FReg12, Length(FReg12)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg12[intPosicaoAtualFReg12].strTipReg := fGetDados(001,03);
    FReg12[intPosicaoAtualFReg12].strNum_PV := fGetDados(004,09);
    FReg12[intPosicaoAtualFReg12].strNum_RV := fGetDados(013,09);
    FReg12[intPosicaoAtualFReg12].strDta_CV := fGetDados(022,08);
    FReg12[intPosicaoAtualFReg12].strZeros_ := fGetDados(030,08);
    FReg12[intPosicaoAtualFReg12].fltVal_CV := fGetDados(038,15,True);
    FReg12[intPosicaoAtualFReg12].fltValGor := fGetDados(053,15,True);
    FReg12[intPosicaoAtualFReg12].strNumCar := fGetDados(068,16);
    FReg12[intPosicaoAtualFReg12].strSts_CV := fGetDados(084,03);
    FReg12[intPosicaoAtualFReg12].strQtdPar := fGetDados(087,02);
    FReg12[intPosicaoAtualFReg12].strNum_CV := fGetDados(089,12);
    FReg12[intPosicaoAtualFReg12].strNumRef := fGetDados(101,13);
    FReg12[intPosicaoAtualFReg12].fltValDes := fGetDados(114,15,True);
    FReg12[intPosicaoAtualFReg12].strNumAut := fGetDados(129,06);
    FReg12[intPosicaoAtualFReg12].strHraTra := fGetDados(135,06);
    FReg12[intPosicaoAtualFReg12].strNumBi1 := fGetDados(141,16);
    FReg12[intPosicaoAtualFReg12].strNumBi2 := fGetDados(157,16);
    FReg12[intPosicaoAtualFReg12].strNumBi3 := fGetDados(173,16);
    FReg12[intPosicaoAtualFReg12].strNumBi4 := fGetDados(189,16);
    FReg12[intPosicaoAtualFReg12].strTipCap := fGetDados(205,01);
    FReg12[intPosicaoAtualFReg12].fltValLiq := fGetDados(206,15,True);
    FReg12[intPosicaoAtualFReg12].fltLiqPri := fGetDados(221,15,True);
    FReg12[intPosicaoAtualFReg12].fltLiqDem := fGetDados(236,15,True);
    FReg12[intPosicaoAtualFReg12].strNumTer := fGetDados(251,08);
    FReg12[intPosicaoAtualFReg12].strSigPai := fGetDados(259,03);
    FReg12[intPosicaoAtualFReg12].strCodBan := fGetDados(262,01);
    FReg12[intPosicaoAtualFReg12].strBaixad := 'N';
    FReg12[intPosicaoAtualFReg12].strSeqLot := '';

    Inc(intPosicaoAtualFReg12);
  End

  Else If LeftStr(strString, 3) = '014' Then
  Begin
    If intPosicaoAtualFReg14 = Length(FReg14) Then
    Begin
      SetLength(FReg14, Length(FReg14)+AUMENTO_CAPACIDADE_FREG);
    End;

    FReg14[intPosicaoAtualFReg14].strTipReg := fGetDados(001,03);
    FReg14[intPosicaoAtualFReg14].strNum_PV := fGetDados(004,09);
    FReg14[intPosicaoAtualFReg14].strNum_RV := fGetDados(013,09);
    FReg14[intPosicaoAtualFReg14].strDta_RV := fGetDados(022,08);
    FReg14[intPosicaoAtualFReg14].strQtdPar := fGetDados(038,02);
    FReg14[intPosicaoAtualFReg14].fltValBru := fGetDados(040,15,True);
    FReg14[intPosicaoAtualFReg14].fltValDes := fGetDados(055,15,True);
    FReg14[intPosicaoAtualFReg14].fltValLiq := fGetDados(070,15,True);
    FReg14[intPosicaoAtualFReg14].strDtaCre := fGetDados(085,08);

    Inc(intPosicaoAtualFReg14);
  End

  Else If (LeftStr(strString, 3) = '034') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
    Begin
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);
    End;

    If (Trim(fGetDados(125,05)) <> '') Then
    Begin
      FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
      FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
      FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
      FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(032,15,True);
      FReg34[intPosicaoAtualFReg34].strCredit := fGetDados(047,01);
      FReg34[intPosicaoAtualFReg34].strNumBco := fGetDados(048,03);
      FReg34[intPosicaoAtualFReg34].strNumAge := fGetDados(051,06);
      FReg34[intPosicaoAtualFReg34].strNumCCo := fGetDados(057,11);
      FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(068,08);
      FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(076,09);
      FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(085,08);
      FReg34[intPosicaoAtualFReg34].strCodBan := fGetDados(093,01);
      FReg34[intPosicaoAtualFReg34].strTipTra := fGetDados(094,01);
      FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(095,15,True);
      FReg34[intPosicaoAtualFReg34].fltValDes := fGetDados(110,15,True);
      FReg34[intPosicaoAtualFReg34].strParTot := fGetDados(125,05);
      FReg34[intPosicaoAtualFReg34].strStsCre := fGetDados(130,02);
      FReg34[intPosicaoAtualFReg34].strPV_Ori := fGetDados(132,09);
      FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
      FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;
      FReg34[intPosicaoAtualFReg34].strParcel := fGetLetraAlfa(StrtoInt(LeftStr(FReg34[intPosicaoAtualFReg34].strParTot,2)));

      If FReg34[intPosicaoAtualFReg34].strParcel = #0 Then
        FReg34[intPosicaoAtualFReg34].strParcel := 'A';

      FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

      If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
       (lstEstabel.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
      lstEstabel.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

      Inc(intPosicaoAtualFReg34);
    end;
  End
  Else If (LeftStr(strString, 3) = '036') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
    Begin
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);
    End;

    If (Trim(fGetDados(108,05)) <> '') Then
    Begin
      FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
      FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
      FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
      FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(032,15,True);
      FReg34[intPosicaoAtualFReg34].strCredit := fGetDados(047,01);
      FReg34[intPosicaoAtualFReg34].strNumBco := fGetDados(048,03);
      FReg34[intPosicaoAtualFReg34].strNumAge := fGetDados(051,06);
      FReg34[intPosicaoAtualFReg34].strNumCCo := fGetDados(057,11);
      FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(068,09);
      FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(077,08);
      FReg34[intPosicaoAtualFReg34].fltValOri := fGetDados(085,15,True);
      FReg34[intPosicaoAtualFReg34].strDtaVen := fGetDados(100,08);
      FReg34[intPosicaoAtualFReg34].strParTot := fGetDados(108,05);
      FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(113,15,True);
      FReg34[intPosicaoAtualFReg34].fltValDes := fGetDados(128,15,True);
      FReg34[intPosicaoAtualFReg34].strPV_Ori := fGetDados(143,09);
      FReg34[intPosicaoAtualFReg34].strCodBan := fGetDados(152,01);
      FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
      FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;
      FReg34[intPosicaoAtualFReg34].strParcel := fGetLetraAlfa(StrtoInt(LeftStr(FReg34[intPosicaoAtualFReg34].strParTot,2)));

      If FReg34[intPosicaoAtualFReg34].strParcel = #0 Then
        FReg34[intPosicaoAtualFReg34].strParcel := 'A';

      FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

      If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
       (lstEstabel.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
      lstEstabel.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

      Inc(intPosicaoAtualFReg34);
    End;
  End
  Else If (LeftStr(strString, 3) = '035') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);

    FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
    FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
    FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(171,08);
    if fGetDados(171,08) = '00000000' then
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
    FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(030,15,True) * (-1);
    FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(209,15,True);
    FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(100,09);
    FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(092,08);
    FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(092,08);

    If FReg34[intPosicaoAtualFReg34].strDta_RV = '00000000' Then
      FReg34[intPosicaoAtualFReg34].strDta_RV := FReg34[intPosicaoAtualFReg34].strDtaLan;

    FReg34[intPosicaoAtualFReg34].strRegDeb := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].fltValDeb := fGetDados(155,15,True);
    If (fGetDados(045,01) = 'D') And (FReg34[intPosicaoAtualFReg34].fltValDeb > 0) Then
      FReg34[intPosicaoAtualFReg34].fltValDeb := FReg34[intPosicaoAtualFReg34].fltValDeb * (-1);
    FReg34[intPosicaoAtualFReg34].strAutDeb := fGetDados(251,06);
    FReg34[intPosicaoAtualFReg34].strNSUDeb := fGetDados(239,12);
    FReg34[intPosicaoAtualFReg34].strCarDeb := fGetDados(076,16);
    FReg34[intPosicaoAtualFReg34].strMotAju := fGetDados(048,28);
    FReg34[intPosicaoAtualFReg34].strParTot := '01/01';

    FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
    FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;
    FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If FReg34[intPosicaoAtualFReg34].strNum_RV = '000000000' Then
    Begin
      FReg34[intPosicaoAtualFReg34].strNum_RV := '00000' + IntToStr(LContadorReg35);

      If FReg34[intPosicaoAtualFReg34].strNsuDeb = '000000000000' Then
        FReg34[intPosicaoAtualFReg34].strNsuDeb := '00000' + IntToStr(LContadorReg35);

      Inc(LContadorReg35);
    End;

    Inc(intPosicaoAtualFReg34);
  End
  Else If (LeftStr(strString, 3) = '045') Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);

    FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
    FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
    FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(219,08);
    if fGetDados(219,08) = '00000000' then
      FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(024,08);
    FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(032,15,True) * (-1);
    FReg34[intPosicaoAtualFReg34].strMotAju := fGetDados(049,28);
    FReg34[intPosicaoAtualFReg34].strCarDeb := fGetDados(077,16);
    FReg34[intPosicaoAtualFReg34].strNSUDeb := fGetDados(093,12);
    FReg34[intPosicaoAtualFReg34].strAutDeb := fGetDados(113,06);
    FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(119,15,True);
    FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(134,09);

    FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(143,08);
    FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(143,08);
    FReg34[intPosicaoAtualFReg34].strRegDeb := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].fltValDeb := fGetDados(204,15,True) * (-1);

    If fGetDados(143,08) = '00000000' Then
    Begin
      FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(024,08);
      FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(024,08);
    End;

    FReg34[intPosicaoAtualFReg34].fltValDes := 0;
    FReg34[intPosicaoAtualFReg34].strParTot := '01/01';
    FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
    FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;

    FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
     (lstEstabel.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
    lstEstabel.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

    Inc(intPosicaoAtualFReg34);
  End
  Else If (MatchStr(LeftStr(strString, 3), ['046', '047'])) Then
  Begin
    If intPosicaoAtualFReg34 = Length(FReg34) Then
      SetLength(FReg34, Length(FReg34)+AUMENTO_CAPACIDADE_FREG);

    FReg34[intPosicaoAtualFReg34].strTipReg := fGetDados(001,03);
    FReg34[intPosicaoAtualFReg34].strNum_PV := fGetDados(004,09);
    FReg34[intPosicaoAtualFReg34].strNumDoc := fGetDados(013,11);
    FReg34[intPosicaoAtualFReg34].strDtaLan := fGetDados(146,08);
    FReg34[intPosicaoAtualFReg34].fltValLan := fGetDados(121,17,True);
    FReg34[intPosicaoAtualFReg34].fltValBru := fGetDados(024,17,True);
    FReg34[intPosicaoAtualFReg34].fltValOri := fGetDados(024,17,True);
    FReg34[intPosicaoAtualFReg34].strNum_RV := fGetDados(058,09);
    FReg34[intPosicaoAtualFReg34].strPV_Ori := fGetDados(049,09);
    FReg34[intPosicaoAtualFReg34].strTipTra := fGetDados(075,01);
    FReg34[intPosicaoAtualFReg34].strCodBan := fGetDados(076,01);

    FReg34[intPosicaoAtualFReg34].strDtaMov := fGetDados(041,08);
    FReg34[intPosicaoAtualFReg34].strDta_RV := fGetDados(067,08);

    FReg34[intPosicaoAtualFReg34].strStsCre := fGetDados(174,02);

    FReg34[intPosicaoAtualFReg34].TipoNegociacao := fGetDados(077,01);
    FReg34[intPosicaoAtualFReg34].ContratoNegociacao := fGetDados(078,17);
    FReg34[intPosicaoAtualFReg34].CNPJParceiro := fGetDados(095,15);
    FReg34[intPosicaoAtualFReg34].NumeroOC := fGetDados(110,11);
    FReg34[intPosicaoAtualFReg34].DataNegociacao := fGetDados(138,08);

    FReg34[intPosicaoAtualFReg34].strNumBco := fGetDados(154,03);
    FReg34[intPosicaoAtualFReg34].strNumAge := fGetDados(157,06);
    FReg34[intPosicaoAtualFReg34].strNumCCo := fGetDados(163,11);

    FReg34[intPosicaoAtualFReg34].fltValDes := 0;
    FReg34[intPosicaoAtualFReg34].strParTot := '01/01';
    FReg34[intPosicaoAtualFReg34].strNomArq := strNomArq;
    FReg34[intPosicaoAtualFReg34].strDtaArq := strDtaArq;

    FReg34[intPosicaoAtualFReg34].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg34[intPosicaoAtualFReg34].strNum_PV <> '') And
     (lstEstabel.IndexOf(FReg34[intPosicaoAtualFReg34].strNum_PV) < 0) Then
    lstEstabel.Add(FReg34[intPosicaoAtualFReg34].strNum_PV);

    Inc(intPosicaoAtualFReg34);
  End;

end;

procedure TRedeCredito.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados: IDataSet;
    intCont  : Integer;
    stlArquiv: TStringList;
    strNomEmp: String;

  function fRetVal(strVal: String): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else Result := strVal;
  End;

begin

  strNomEmp := FstrNomEmp;
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'REPLACE INTO RED_EVCR06 (                                     ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUM_RV, RED_NUMBCO, RED_NUMAGE, ' +
                  '  RED_NUMCCO, RED_DTA_RV, RED_QTDCVA, RED_VALBRU, RED_VALGOR, ' +
                  '  RED_VALREJ, RED_VALDES, RED_VALLIQ, RED_DTACRE, RED_CODBAN  ' +
                  '  ) VALUES (                                                  ' +
                  '  :TIPREG, :NUM_PV, :NUM_RV, :NUMBCO, :NUMAGE,                ' +
                  '  :NUMCCO, :DTA_RV, :QTDCVA, :VALBRU, :VALGOR,                ' +
                  '  :VALREJ, :VALDES, :VALLIQ, :DTACRE, :CODBAN)                ';

  pgbProg.Position := 0;

  If Length(FReg6) > 0 Then
  Begin
    Application.ProcessMessages;
    pgbProg.Max      := Length(FReg6)-1;
    For intCont := 0 To Length(FReg6)-1 Do
    Begin
      If fEmptyStr(FReg6[intCont].strTipReg) Then
      Begin
        pgbProg.Position := pgbProg.Max;
        Break;
      End;

      Application.ProcessMessages;

      If fRetData(FReg6[intCont].strDta_RV) =  Null Then
        Continue;

      qryDados.Close;

      qryDados.ParamByName('TIPREG').Value   := fRetVal(FReg6[intCont].strTipReg);
      qryDados.ParamByName('NUM_PV').Value   := fRetVal(FReg6[intCont].strNum_PV);
      qryDados.ParamByName('NUM_RV').Value   := fRetVal(FReg6[intCont].strNum_RV);
      qryDados.ParamByName('NUMBCO').Value   := fRetVal(FReg6[intCont].strNumBco);
      qryDados.ParamByName('NUMAGE').Value   := fRetVal(FReg6[intCont].strNumAge);
      qryDados.ParamByName('NUMCCO').Value   := fRetVal(FReg6[intCont].strNumCCo);
      qryDados.ParamByName('DTA_RV').Value   := fRetData(FReg6[intCont].strDta_RV);
      qryDados.ParamByName('QTDCVA').Value   := fRetVal(FReg6[intCont].strQtdCVa);
      qryDados.ParamByName('VALBRU').AsFloat := FReg6[intCont].fltValBru;
      qryDados.ParamByName('VALGOR').AsFloat := FReg6[intCont].fltValGor;
      qryDados.ParamByName('VALREJ').AsFloat := FReg6[intCont].fltValRej;
      qryDados.ParamByName('VALDES').AsFloat := FReg6[intCont].fltValDes;
      qryDados.ParamByName('VALLIQ').AsFloat := FReg6[intCont].fltValLiq;
      qryDados.ParamByName('DTACRE').Value   := fRetVal(FReg6[intCont].strDtaCre);
      qryDados.ParamByName('CODBAN').Value   := fRetVal(FReg6[intCont].strCodBan);

      qryDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;

  qryDados.Close;
  qryDados.SQL := 'INSERT INTO RED_EVCR08 (                                      ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUM_RV, RED_DTA_CV, RED_VAL_CV, ' +
                  '  RED_VALGER, RED_NUMCAR, RED_STS_CV, RED_NUM_CV, RED_NUMREF, ' +
                  '  RED_VALDES, RED_NUMAUT, RED_HRATRA, RED_NUMBI1, RED_NUMBI2, ' +
                  '  RED_NUMBI3, RED_NUMBI4, RED_TIPCAP, RED_VALLIQ, RED_NUMTER, ' +
                  '  RED_SIGPAI, RED_CODBAN, RED_BAIXAD, RED_SEQLOT              ' +
                  '  ) VALUES (                                                  ' +
                  '  :TIPREG, :NUM_PV, :NUM_RV, :DTA_CV, :VAL_CV,                ' +
                  '  :VALGER, :NUMCAR, :STS_CV, :NUM_CV, :NUMREF,                ' +
                  '  :VALDES, :NUMAUT, :HRATRA, :NUMBI1, :NUMBI2,                ' +
                  '  :NUMBI3, :NUMBI4, :TIPCAP, :VALLIQ, :NUMTER,                ' +
                  '  :SIGPAI, :CODBAN, :BAIXAD, :SEQLOT)                         ';

  pgbProg.Position := 0;

  If Length(FReg8) > 0 Then
  Begin
    pgbProg.Max      := Length(FReg8)-1;
    For intCont := 0 To Length(FReg8)-1 Do
    Begin
      If fEmptyStr(FReg8[intCont].strTipReg) Then
      Begin
        pgbProg.Position := pgbProg.Max;
        Break;
      End;

      Application.ProcessMessages;
      qryDados.Close;

      Try
        qryDados.ParamByName('TIPREG').Value   := fRetVal(FReg8[intCont].strTipReg);
        qryDados.ParamByName('NUM_PV').Value   := fRetVal(FReg8[intCont].strNum_PV);
        qryDados.ParamByName('NUM_RV').Value   := fRetVal(FReg8[intCont].strNum_RV);
        qryDados.ParamByName('DTA_CV').Value   := fRetData(FReg8[intCont].strDta_CV);
        qryDados.ParamByName('VAL_CV').AsFloat := FReg8[intCont].fltVal_CV;
        qryDados.ParamByName('VALGER').AsFloat := FReg8[intCont].fltValGer;
        qryDados.ParamByName('NUMCAR').Value   := fRetVal(FReg8[intCont].strNumCar);
        qryDados.ParamByName('STS_CV').Value   := fRetVal(FReg8[intCont].strSts_CV);
        qryDados.ParamByName('NUM_CV').Value   := fRetVal(FReg8[intCont].strNum_CV);
        qryDados.ParamByName('NUMREF').Value   := fRetVal(FReg8[intCont].strNumRef);
        qryDados.ParamByName('VALDES').AsFloat := FReg8[intCont].fltValDes;
        qryDados.ParamByName('NUMAUT').Value   := fRetVal(FReg8[intCont].strNumAut);
        qryDados.ParamByName('HRATRA').Value   := fRetData(FReg8[intCont].strHraTra);
        qryDados.ParamByName('NUMBI1').Value   := fRetVal(FReg8[intCont].strNumBi1);
        qryDados.ParamByName('NUMBI2').Value   := fRetVal(FReg8[intCont].strNumBi2);
        qryDados.ParamByName('NUMBI3').Value   := fRetVal(FReg8[intCont].strNumBi3);
        qryDados.ParamByName('NUMBI4').Value   := fRetVal(FReg8[intCont].strNumBi4);
        qryDados.ParamByName('TIPCAP').Value   := fRetVal(FReg8[intCont].strTipCap);
        qryDados.ParamByName('VALLIQ').AsFloat := FReg8[intCont].fltValLiq;
        qryDados.ParamByName('NUMTER').Value   := fRetVal(FReg8[intCont].strNumTer);
        qryDados.ParamByName('SIGPAI').Value   := fRetVal(FReg8[intCont].strSigPai);
        qryDados.ParamByName('CODBAN').Value   := fRetVal(FReg8[intCont].strCodBan);
        qryDados.ParamByName('BAIXAD').Value   := fRetVal(FReg8[intCont].strBaixad);
        qryDados.ParamByName('SEQLOT').Value   := fRetVal(FReg8[intCont].strSeqLot);

        qryDados.ExecSQL;
      Except

      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;

  qryDados.Close;
  qryDados.SQL := 'REPLACE INTO RED_EVCR10 (                                     ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUM_RV, RED_CODBCO, RED_NUMAGE, ' +
                  '  RED_NUMCCO, RED_DTA_RV, RED_QTD_CV, RED_VALBRU, RED_VALGOR, ' +
                  '  RED_VALREJ, RED_VALDES, RED_VALLIQ, RED_DTACRE, RED_CODBAN  ' +
                  '  ) VALUES (                                                  ' +
                  '  :TIPREG, :NUM_PV, :NUM_RV, :CODBCO, :NUMAGE,                ' +
                  '  :NUMCCO, :DTA_RV, :QTD_CV, :VALBRU, :VALGOR,                ' +
                  '  :VALREJ, :VALDES, :VALLIQ, :DTACRE, :CODBAN) ';

  pgbProg.Position := 0;

  If Length(FReg10) > 0 Then
  Begin
    pgbProg.Max      := Length(FReg10)-1;
    For intCont := 0 To Length(FReg10)-1 Do
    Begin
      If fEmptyStr(FReg10[intCont].strTipReg) Then
      Begin
        pgbProg.Position := pgbProg.Max;
        Break;
      End;

      Application.ProcessMessages;

      If fRetData(FReg10[intCont].strDta_RV) =  Null Then
        Continue;

      qryDados.Close;

      qryDados.ParamByName('TIPREG').Value  := fRetVal(FReg10[intCont].strTipReg);
      qryDados.ParamByName('NUM_PV').Value  := fRetVal(FReg10[intCont].strNum_PV);
      qryDados.ParamByName('NUM_RV').Value  := fRetVal(FReg10[intCont].strNum_RV);
      qryDados.ParamByName('CODBCO').Value  := fRetVal(FReg10[intCont].strNumBco);
      qryDados.ParamByName('NUMAGE').Value  := fRetVal(FReg10[intCont].strNumAge);
      qryDados.ParamByName('NUMCCO').Value  := fRetVal(FReg10[intCont].strNumCCo);
      qryDados.ParamByName('DTA_RV').Value  := fRetData(FReg10[intCont].strDta_RV);
      qryDados.ParamByName('QTD_CV').Value  := fRetVal(FReg10[intCont].strQtd_CV);
      qryDados.ParamByName('VALBRU').AsFloat:= FReg10[intCont].fltValBru;
      qryDados.ParamByName('VALGOR').AsFloat:= FReg10[intCont].fltValGor;
      qryDados.ParamByName('VALREJ').AsFloat:= FReg10[intCont].fltValBru;
      qryDados.ParamByName('VALDES').AsFloat:= FReg10[intCont].fltValDes;
      qryDados.ParamByName('VALLIQ').AsFloat:= FReg10[intCont].fltValLiq;
      qryDados.ParamByName('DTACRE').Value  := fRetData(FReg10[intCont].strDtaCre);
      qryDados.ParamByName('CODBAN').Value  := fRetVal(FReg10[intCont].strCodBan);

      qryDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;

  qryDados.Close;
  qryDados.SQL := 'REPLACE INTO RED_EVCR12 (                                     ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUM_RV, RED_DTA_CV, RED_VAL_CV, ' +
                  '  RED_VALGOR, RED_NUMCCO, RED_STS_CV, RED_QTDPAR, RED_NUM_CV, ' +
                  '  RED_NUMREF, RED_VALDES, RED_NUMAUT, RED_HRATRA, RED_NUMBI1, ' +
                  '  RED_NUMBI2, RED_NUMBI3, RED_NUMBI4, RED_TIPCAP, RED_VALLIQ, ' +
                  '  RED_LIQPRI, RED_LIQDEM, RED_NUMTER, RED_SIGPAI, RED_CODBAN, ' +
                  '  RED_BAIXAD, RED_SEQLOT)                                     ' +
                  '  VALUES (                                                    ' +
                  '  :TIPREG, :NUM_PV, :NUM_RV, :DTA_CV, :VAL_CV,                ' +
                  '  :VALGOR, :NUMCCO, :STS_CV, :QTDPAR, :NUM_CV,                ' +
                  '  :NUMREF, :VALDES, :NUMAUT, :HRATRA, :NUMBI1,                ' +
                  '  :NUMBI2, :NUMBI3, :NUMBI4, :TIPCAP, :VALLIQ,                ' +
                  '  :LIQPRI, :LIQDEM, :NUMTER, :SIGPAI, :CODBAN,                ' +
                  '  :BAIXAD, :SEQLOT) '                                           ;

  pgbProg.Position := 0;

  If Length(FReg12) > 0 Then
  Begin
    pgbProg.Max      := Length(FReg12)-1;
    For intCont := 0 To Length(FReg12) - 1 Do
    Begin
      If fEmptyStr(FReg12[intCont].strTipReg) Then
      Begin
        pgbProg.Position := pgbProg.Max;
        Break;
      End;

      Application.ProcessMessages;
      qryDados.Close;

      qryDados.ParamByName('TIPREG').Value  := fRetVal(FReg12[intCont].strTipReg);
      qryDados.ParamByName('NUM_PV').Value  := fRetVal(FReg12[intCont].strNum_PV);
      qryDados.ParamByName('NUM_RV').Value  := fRetVal(FReg12[intCont].strNum_RV);
      qryDados.ParamByName('DTA_CV').Value  := fRetData(FReg12[intCont].strDta_CV);
      qryDados.ParamByName('VAL_CV').AsFloat:= FReg12[intCont].fltVal_CV;
      qryDados.ParamByName('VALGOR').AsFloat:= FReg12[intCont].fltValGor;
      qryDados.ParamByName('NUMCCO').Value  := fRetVal(FReg12[intCont].strNumCar);
      qryDados.ParamByName('STS_CV').Value  := fRetVal(FReg12[intCont].strSts_CV);
      qryDados.ParamByName('QTDPAR').Value  := fRetVal(FReg12[intCont].strQtdPar);
      qryDados.ParamByName('NUM_CV').Value  := fRetVal(FReg12[intCont].strNum_CV);
      qryDados.ParamByName('NUMREF').Value  := fRetVal(FReg12[intCont].strNumRef);
      qryDados.ParamByName('VALDES').AsFloat:= FReg12[intCont].fltValDes;
      qryDados.ParamByName('NUMAUT').Value  := fRetVal(FReg12[intCont].strNumAut);
      qryDados.ParamByName('HRATRA').Value  := fRetData(FReg12[intCont].strHraTra);
      qryDados.ParamByName('NUMBI1').Value  := fRetVal(FReg12[intCont].strNumBi1);
      qryDados.ParamByName('NUMBI2').Value  := fRetVal(FReg12[intCont].strNumBi2);
      qryDados.ParamByName('NUMBI3').Value  := fRetVal(FReg12[intCont].strNumBi3);
      qryDados.ParamByName('NUMBI4').Value  := fRetVal(FReg12[intCont].strNumBi4);
      qryDados.ParamByName('TIPCAP').Value  := fRetVal(FReg12[intCont].strTipCap);
      qryDados.ParamByName('VALLIQ').Value  := FReg12[intCont].fltValLiq;
      qryDados.ParamByName('LIQPRI').Value  := FReg12[intCont].fltLiqPri;
      qryDados.ParamByName('LIQDEM').Value  := FReg12[intCont].fltLiqDem;
      qryDados.ParamByName('NUMTER').Value  := fRetVal(FReg12[intCont].strNumTer);
      qryDados.ParamByName('SIGPAI').Value  := fRetVal(FReg12[intCont].strSigPai);
      qryDados.ParamByName('CODBAN').Value  := fRetVal(FReg12[intCont].strCodBan);
      qryDados.ParamByName('BAIXAD').Value  := fRetVal(FReg12[intCont].strBaixad);
      qryDados.ParamByName('SEQLOT').Value  := fRetVal(FReg12[intCont].strSeqLot);

      qryDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;

  qryDados.Close;
  qryDados.SQL := 'REPLACE INTO RED_EVCR14 (                                     ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV, RED_QTDPAR, ' +
                  '  RED_VALBRU, RED_VALDES, RED_VALLIQ, RED_DTACRE)             ' +
                  '  VALUES (                                                    ' +
                  '  :TIPREG, :NUM_PV, :NUM_RV, :DTA_RV, :QTDPAR,                ' +
                  '  :VALBRU, :VALDES, :VALLIQ, :DTACRE)                         ';

  pgbProg.Position := 0;

  If Length(FReg14) > 0 Then
  Begin
    pgbProg.Max      := Length(FReg14)-1;
    For intCont := 0 To Length(FReg14) - 1 Do
    Begin
      If fEmptyStr(FReg14[intCont].strTipReg) Then
      Begin
        pgbProg.Position := pgbProg.Max;
        Break;
      End;

      Application.ProcessMessages;
      qryDados.Close;

      qryDados.ParamByName('TIPREG').Value  := fRetVal(FReg14[intCont].strTipReg);
      qryDados.ParamByName('NUM_PV').Value  := fRetVal(FReg14[intCont].strNum_PV);
      qryDados.ParamByName('NUM_RV').Value  := fRetVal(FReg14[intCont].strNum_RV);
      qryDados.ParamByName('DTA_RV').Value  := fRetData(FReg14[intCont].strDta_RV);
      qryDados.ParamByName('QTDPAR').Value  := fRetVal(FReg14[intCont].strQtdPar);
      qryDados.ParamByName('VALBRU').AsFloat:= FReg14[intCont].fltValBru;
      qryDados.ParamByName('VALDES').AsFloat:= FReg14[intCont].fltValDes;
      qryDados.ParamByName('VALLIQ').AsFloat:= FReg14[intCont].fltValLiq;
      qryDados.ParamByName('DTACRE').Value  := fRetData(FReg14[intCont].strDtaCre);

      qryDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
    End;
  End;

  qryDados.Close;
  qryDados.SQL := 'REPLACE INTO RED_EFIR34 ( ' +
                  '  RED_TIPREG, RED_NUM_PV, RED_NUMDOC, RED_DTALAN, RED_VALLAN, ' +
                  '  RED_CREDIT, RED_NUMBCO, RED_NUMAGE, RED_NUMCCO, RED_DTAMOV, ' +
                  '  RED_NUM_RV, RED_DTA_RV, RED_CODBAN, RED_TIPTRA, RED_VALBRU, ' +
                  '  RED_VALDES, RED_PARTOT, RED_STSCRE, RED_PV_ORI, RED_DTAVEN, ' +
                  '  RED_VALORI, RED_NOMARQ, RED_DTAARQ, RED_PARCEL, RED_DTAIMP, ' +
                  '  RED_CARDEB, RED_REGDEB, RED_VALDEB, RED_AUTDEB, RED_NSUDEB, ' +
                  '  RED_MOTAJU, RED_CONNEG, RED_CNPPAR, RED_NUM_OC, RED_DTANEG, ' +
                  '  RED_TIPNEG)                                                 ' +
                  '  VALUES (                                                    ' +
                  '  :TIPREG, :NUM_PV, :NUMDOC, :DTALAN, :VALLAN,                ' +
                  '  :CREDIT, :NUMBCO, :NUMAGE, :NUMCCO, :DTAMOV,                ' +
                  '  :NUM_RV, :DTA_RV, :CODBAN, :TIPTRA, :VALBRU,                ' +
                  '  :VALDES, :PARTOT, :STSCRE, :PV_ORI, :DTAVEN, :VALORI,       ' +
                  '  :NOMARQ, :DTAARQ, :PARCEL, :DTAIMP, :CARDEB, :REGDEB,       ' +
                  '  :VALDEB, :AUTDEB, :NSUDEB, :MOTAJU, :CONNEG, :CNPPAR,       ' +
                  '  :NUM_OC, :DTANEG, :TIPNEG)                                  ';

  pgbProg.Position := 0;

  stlArquiv := TStringList.Create;
  If Length(FReg34) > 0 Then
  Begin
    pgbProg.Max      := Length(FReg34)-1;
    For intCont := 0 To Length(FReg34) - 1 Do
    Begin
      If fEmptyStr(FReg34[intCont].strTipReg) Then
      Begin
        pgbProg.Position := pgbProg.Max;
        Break;
      End;

      Application.ProcessMessages;

      If fRetData(FReg34[intCont].strDta_RV) =  Null Then
        Continue;

      qryDados.Close;

      qryDados.ParamByName('TIPREG').Value  := fRetVal(FReg34[intCont].strTipReg);
      qryDados.ParamByName('NUM_PV').Value  := fRetVal(FReg34[intCont].strNum_PV);
      qryDados.ParamByName('NUMDOC').Value  := fRetVal(FReg34[intCont].strNumDoc);

      If (fRetVal(FReg34[intCont].strTipReg) <> '045') Then
        qryDados.ParamByName('DTALAN').Value  := fRetData(FReg34[intCont].strDtaLan)
      Else
        qryDados.ParamByName('DTALAN').Value  := fAcertaDataParaDiaUtil(fRetData(FReg34[intCont].strDtaLan) + 1);

      qryDados.ParamByName('VALLAN').AsFloat:= FReg34[intCont].fltValLan;
      qryDados.ParamByName('CREDIT').Value  := fRetVal(FReg34[intCont].strCredit);
      qryDados.ParamByName('NUMBCO').Value  := fRetVal(FReg34[intCont].strNumBco);
      qryDados.ParamByName('NUMAGE').Value  := fRetVal(FReg34[intCont].strNumAge);
      qryDados.ParamByName('NUMCCO').Value  := fRetVal(FReg34[intCont].strNumCCo);
      qryDados.ParamByName('DTAMOV').Value  := fRetData(FReg34[intCont].strDtaMov);
      qryDados.ParamByName('NUM_RV').Value  := fRetVal(FReg34[intCont].strNum_RV);
      qryDados.ParamByName('DTA_RV').Value  := fRetData(FReg34[intCont].strDta_RV);
      qryDados.ParamByName('CODBAN').Value  := fRetVal(FReg34[intCont].strCodBan);
      qryDados.ParamByName('TIPTRA').Value  := fRetVal(FReg34[intCont].strTipTra);
      qryDados.ParamByName('VALBRU').AsFloat:= FReg34[intCont].fltValBru;
      qryDados.ParamByName('VALDES').AsFloat:= FReg34[intCont].fltValDes;
      qryDados.ParamByName('PARTOT').Value  := fRetVal(FReg34[intCont].strParTot);
      qryDados.ParamByName('STSCRE').Value  := fRetVal(FReg34[intCont].strStsCre);
      qryDados.ParamByName('PV_ORI').Value  := fRetVal(FReg34[intCont].strPV_Ori);
      qryDados.ParamByName('DTAVEN').Value  := fRetData(FReg34[intCont].strDtaVen);
      qryDados.ParamByName('VALORI').AsFloat:= FReg34[intCont].fltValOri;
      qryDados.ParamByName('DTAARQ').Value  := fRetData(FReg34[intCont].strDtaArq);
      qryDados.ParamByName('NOMARQ').Value  := FReg34[intCont].strNomArq;
      qryDados.ParamByName('PARCEL').Value  := FReg34[intCont].strParcel;
      qryDados.ParamByName('DTAIMP').Value  := FReg34[intCont].strDtaImp;
      qryDados.ParamByName('CARDEB').Value  := FReg34[intCont].strCarDeb;
      qryDados.ParamByName('REGDEB').Value  := FReg34[intCont].strRegDeb;
      qryDados.ParamByName('VALDEB').AsFloat:= FReg34[intCont].fltValDeb;
      qryDados.ParamByName('AUTDEB').Value  := FReg34[intCont].strAutDeb;
      qryDados.ParamByName('NSUDEB').Value  := FReg34[intCont].strNSUDeb;
      qryDados.ParamByName('MOTAJU').Value  := FReg34[intCont].strMotAju;

      qryDados.ParamByName('TIPNEG').Value  := FReg34[intCont].TipoNegociacao;
      qryDados.ParamByName('DTANEG').Value  := fRetData(FReg34[intCont].DataNegociacao);
      qryDados.ParamByName('CONNEG').Value  := FReg34[intCont].ContratoNegociacao;
      qryDados.ParamByName('CNPPAR').Value  := FReg34[intCont].CNPJParceiro;
      qryDados.ParamByName('NUM_OC').Value  := FReg34[intCont].NumeroOC;

      qryDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;

      If stlArquiv.IndexOf(FReg34[intCont].strNomArq) < 0 Then
        stlArquiv.Add(FReg34[intCont].strNomArq);
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "REDECARD")';
      For intCont := 0 To lstEstabel.Count - 1 Do
      Begin
        qryDados.ParamByName('ESTAB').AsString := lstEstabel[intCont];
        qryDados.ExecSQL;
      End;
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

  End;

  {************************************}
  {* MARCANDO OS ARQUIVOS CONCILIADOS *}
  {* POR COMPLETO                     *}
  {*********************************AJ*}
  qryDados.Close;
  qryDados.SQL := 'UPDATE RED_EFIR34 A SET RED_IMPTOT=1 WHERE ' +
                  ' A.RED_IMPTOT = 0 AND A.RED_TIPREG NOT IN ("035", "045") AND ' +
                  ' A.RED_DTAIMP = ' + objFunctions.fICurrentDate + ' AND ' +
                  '(((SELECT COUNT(*) FROM RED_EVCR10 B WHERE ' +
                  ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                  ' B.RED_DTA_RV=A.RED_DTA_RV) > 0) AND ' +
                  '((SELECT COUNT(*) FROM RED_EVCR12 B WHERE ' +
                  ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                  ' B.RED_DTA_CV=A.RED_DTA_RV) > 0)) ';
  qryDados.ExecSql;

  qryDados.Close;
  qryDados.SQL := 'UPDATE RED_EFIR34 A SET RED_IMPTOT=1 WHERE ' +
                  ' A.RED_IMPTOT = 0 AND A.RED_TIPREG NOT IN ("035", "045") AND ' +
                  ' A.RED_DTAIMP = ' + objFunctions.fICurrentDate + ' AND ' +
                  '(((SELECT COUNT(*) FROM RED_EVCR06 B WHERE ' +
                  ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                  ' B.RED_DTA_RV=A.RED_DTA_RV) > 0) AND ' +
                  '((SELECT COUNT(*) FROM RED_EVCR08 B WHERE ' +
                  ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                  ' B.RED_DTA_CV=A.RED_DTA_RV) > 0)) ';
  qryDados.ExecSql;

  Application.ProcessMessages;

  qryDados.Close;

  {$IF Defined(VER180)}

  {$ELSE}
    qryDados.SQL := 'SELECT RED_NOMARQ, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV, RED_TIPREG, ' +
                    ' RED_DTALAN, RED_VALLAN, RED_PARTOT FROM RED_EFIR34 ' +
                    ' WHERE RED_IMPTOT=0 AND RED_DTAIMP = CURRENT_DATE AND RED_TIPREG NOT IN ("035", "045", "047") ' +
                    ' GROUP BY RED_NOMARQ, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV ORDER BY  ' +
                    ' RED_NOMARQ, RED_NUM_PV, RED_NUM_RV, RED_DTA_RV ';
    qryDados.Open;

    If qryDados.RecordCount > 0 Then
    Begin
      objFunctions.fIMensagem('AVISO','Foram encontrados RVs com arquivos de venda faltando!',['&OK']);

      frmRelCartaoImportacao := TfrmRelCartaoImportacao.Create(frmRelCartaoImportacao);
      With frmRelCartaoImportacao.cdsRelat Do
      Begin
        CreateDataSet;
        Open;
        qryDados.First;
        While Not qryDados.Eof Do
        Begin
          Insert;
          FieldByName('RED_NOMARQ').AsString := qryDados.FieldByName('RED_NOMARQ').AsString;
          FieldByName('RED_NUM_PV').AsString := qryDados.FieldByName('RED_NUM_PV').AsString;
          FieldByName('RED_NUM_RV').AsString := qryDados.FieldByName('RED_NUM_RV').AsString;
          FieldByName('RED_DTA_RV').AsString := qryDados.FieldByName('RED_DTA_RV').AsString;
          FieldByName('RED_DTALAN').AsString := qryDados.FieldByName('RED_DTALAN').AsString;
          FieldByName('RED_PARCEL').AsString := qryDados.FieldByName('RED_PARTOT').AsString;
          FieldByName('RED_VALLAN').Value    := qryDados.FieldByName('RED_VALLAN').AsFloat;
          FieldByName('RED_TIPREG').AsString := qryDados.FieldByName('RED_TIPREG').AsString;
          Post;

          qryDados.Next;
        End;
      End;

      frmRelCartaoImportacao.frxInconsist.Script.Variables['NOMEMP'] := strNomEmp;
      frmRelCartaoImportacao.frxInconsist.Script.Variables['NOMREL'] := 'RELATÓRIO DE RVs FALTANDO ARQUIVOS DE VENDA - REDECARD';
      TfrxMemoView(frmRelCartaoImportacao.frxInconsist.FindObject('rllZebra')).Highlight.Color     := clMoneyGreen;
      TfrxMemoView(frmRelCartaoImportacao.frxInconsist.FindObject('rllZebra')).Highlight.Condition := 'Frac(<Line> / 2) = 0.5';
      frmRelCartaoImportacao.frxInconsist.PrepareReport;
      pExibirRelatorio('frmRelCartaoImportacao', 'Relatório de RVs faltando arquivos de venda - redecard', TReport.New(frmRelCartaoImportacao.frxInconsist));

      FreeAndNil(frmRelCartaoImportacao);
    End;
  {$IFEND}
end;

function TRedeCredito.fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

function TRedeCredito.fGetLetraAlfa(intCol: Integer): String;
  Var
    strLetra : String;
    intLetra1: Integer;
    intLetra2: Integer;
    fltValor : Double;
begin
  strLetra := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  If intCol > 26 Then
  Begin
    fltValor  := (intCol / 26);
    intLetra1 := fFloatToInt(fltValor - Frac(fltValor));
    intLetra2 := fFloatToInt(intcol Mod 26);

    If intLetra2 = 0 Then
    Begin
      Dec(intLetra1);
      intLetra2 := 26;
    End;

    Result    := strLetra[intLetra1] + strLetra[intLetra2];
  End
  Else
    Result   := strLetra[intCol];

end;

end.
