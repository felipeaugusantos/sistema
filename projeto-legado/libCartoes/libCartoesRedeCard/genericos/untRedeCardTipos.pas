unit untRedeCardTipos;

interface

Const
  NOME_CONCILIACAO = 'REDECARD';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
  //API
  TRedeCardRegistroPgto = class
    private
    public
      CodigoEstabelecimento,
      TipoRegistro,
      DataPagamento,
      NumeroRV,
      NumeroOrdem,
      CodigoBandeira,
      DescricaoTipo,
      DataImportacao,
      PagamentoID: String;

      ValorBruto,
      ValorDesconto,
      ValorLiquido: Double;
  end;

  TRedeCardAPIRegistroVenda = class
    private
    public
      CodigoEstabelecimento,
      TipoRegistro,
      DataRV,
      NumeroRV,
      NumeroOrdem,
      NumeroDocumento,
      CodigoBandeira,
      DataImportacao,
      RazaoSocial,
      NomeFantasia,
      Autorizacao,
      NSU,
      TID,
      NomeProduto,
      CodigoProduto,
      TotalParcelas,
      DataVenda,
      Status,
      ChargeBackStatus,
      TipoMaquina,
      CodigoTerminal,
      TipoCaptura,
      CodigoCaptura,
      Ard,
      Flex,
      NumeroCartao: String;

      ValorBruto,
      ValorDesconto,
      ValorLiquido,
      TaxaMDR,
      ValorMDR,
      TaxaFlex,
      ValorFlex,
      PercentualTaxa,
      ValorEmbarque: Double;
  end;

  TRedeCardAPIRegistroVendaParcelada = class
    private
    public
      CodigoEstabelecimento,
      DataRV,
      DataVenda,
      DataVencimento,
      NumeroRV,
      DataImportacao,
      NSU,
      TID,
      Parcela,
      TotalParcelas: String;

      ValorParcela,
      ValorDesconto,
      ValorLiquido,
      TaxaMDR,
      ValorMDR,
      PercentualTaxa,
      ValorVenda: Double;
  end;

  TRedeCardAPIRegistroAjuste = class
    private
    public
      CodigoAjuste,
      DescricaoAjuste,
      CodigoEstabelecimento,
      NumeroRV,
      DataPagamento,
      DataRV,
      NumeroDebito,
      NumeroDocumento,
      NomeFantasia,
      NumeroAviso,
      RazaoSocial,
      DataExpiracao,
      NumeroPedido,
      TipoRegistro,
      DataImportacao: String;

      ValorAjuste,
      ValorAjusteFuturo,
      ValorPago: Double;
  end;


  //Arquivos
  TRegistro5 = Record
    strTipReg: String;  // 1ª 002 Num. Tipo de registro
    strNum_PV: String;  // 2ª 009 Num. N.º de filiação do Ponto de Venda
    strNum_RV: String;  // 3ª 009 Num. N.º do Resumo de Vendas
    strDta_CV: String;  // 4ª 008 Num. Data do CV (DDMMAAAA)
    fltValBru: Double;  // 5ª 015 9(13)V99 Valor bruto (para o Compre e Saque, este campo será
                        //                 composto pelo “Valor da Compra” + “Valor do Saque”)
    fltValDes: Double;  // 6ª 015 9(13)V99 Valor desconto
    fltValLiq: Double;  // 7ª 015 9(13)V99 Valor líquido
    strNumCar: String;  // 8ª 019 Alfa Número do cartão
    strTipTra: String;  // 9ª 001 Alfa Tipo de transação
    strNum_CV: String;  // 10ª 012 Num. Número do CV
    strDtaCre: String;  // 11ª 008 Num. Data do crédito
    strStsTra: String;  // 12ª 002 Num. Status da transação (01 – acatada)
    strHraTra: String;  // 13ª 006 Num. Hora da transação (HHMMSS)
    strNumTer: String;  // 14ª 008 Alfa Número do terminal
    strTipCap: String;  // 15ª 002 Num. Tipo de captura
    strNumRes: String;  // 16ª 005 Num. Reservado
    fltValCom: Double;  // 17ª 015 9(13)V99 Valor da compra (para o Compre e Saque )
    fltValSaq: Double;  // 18ª 015 9(13)V99 Valor do saque (para o Compre e Saque)
    strCodBan: String;  // 19ª 001 Alfa Bandeira
    strCodAut: String;  // 20ª 007 Num. Código da autorização
    strBaixad: String;  // Se o registro já foi baixado no Autcom "S" ou "N"
    strSeqLot: String;  // Sequencial de controle por lote (6 números + CODEMP)
    strNomArq: String;  // Nome do arquivo importado
    strDtaArq: String;  // Data do arquivo importado
    strDtaImp: String;  // Data da Importação
    strMotAju: String;  // Motivo do Ajuste (Registro 11)
  End;

Type
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

  TEstruturaReg05 = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistro5 = Array Of TRegistro5;
  TArrEstruturaReg05 = Array Of TEstruturaReg05;

implementation

end.
