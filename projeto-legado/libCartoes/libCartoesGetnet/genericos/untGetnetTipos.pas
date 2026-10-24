unit untGetnetTipos;

interface

Const
  NOME_CONCILIACAO = 'GETNET';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

Type
// +---------------------------------------------------------------------------------+
// |                      CRITÉRIOS DE EDIÇÃO DOS DADOS                              |
// +---------------------------------------------------------------------------------+
// |  Tipo do registro               | “1” = Pagamentos                              |
// +---------------------------------------------------------------------------------+
// |  Cod Estabelecimento            | Código do Estabelecimento junto a AMEX        |
// +---------------------------------------------------------------------------------+
// |  Data do Pagamento              | Data do pagamento//previsão da transação      |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido PG               | Valor Líquido da transação                    |
// +---------------------------------------------------------------------------------+
// |  Código do Banco                | Código do Banco onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  Código da Agéncia              | Código da Agêcnia onde será realizado o Pgto  |
// +---------------------------------------------------------------------------------+
// |  Número da Conta Corrente       | Número da Conta onde será realizado o Pgto    |
// +---------------------------------------------------------------------------------+
// |  Código da Moeda                | "091"=Real - "001"=Dólar                      |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto PG                 | Valor Bruto do Pgto                           |
// +---------------------------------------------------------------------------------+
// |  Valor de Desconto PG           | Valor de Desconto do Pgto                     |
// +---------------------------------------------------------------------------------+
// |  Encargos da Antecipação PG     | Encargos de Antecipação do Pgto               |
// +---------------------------------------------------------------------------------+
// |  Tipo de Lançamento             | "P" = Pagamento - "F" = Lançamento Futuro     |
// +---------------------------------------------------------------------------------+
// |  Número do RO                   | Número do RO                                  |
// +---------------------------------------------------------------------------------+
// |  Valor Bruto RO                 | Valor Bruto do RO                             |
// +---------------------------------------------------------------------------------+
// |  Valor de Desconto RO           | Valor de Desconto do Ro                       |
// +---------------------------------------------------------------------------------+
// |  Encargos da Antecipação RO     | Encargos de Antecipação do RO                 |
// +---------------------------------------------------------------------------------+
// |  Valor Líquido RO               | Valor Líquido RO (Valor-Valor Des-Valor Ant)  |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de Parcelas da Venda                    |
// +---------------------------------------------------------------------------------+
// |  Número da Antecipação          | Número da Antecipação                         |
// +---------------------------------------------------------------------------------+
// |  Data da Antecipação            | Data do Pagamento da Antecipação              |
// +---------------------------------------------------------------------------------+
// |  Código da Autorização          | Código da Autorização do CV (CCD)             |
// +---------------------------------------------------------------------------------+
// |  Número do Cartão               | Número do Cartão do CV                        |
// +---------------------------------------------------------------------------------+
// |  Valor da Venda                 | Valor Total da Venda                          |
// +---------------------------------------------------------------------------------+
// |  Valor da Primeira Parcela      | Valor da Primeira Parcela da Venda            |
// +---------------------------------------------------------------------------------+
// |  Valor das Demais Parcelas      | Valor das Demais Parcelas da Venda            |
// +---------------------------------------------------------------------------------+
// |  Total de Parcelas              | Total de Parcelas da Venda                    |
// +---------------------------------------------------------------------------------+
// |  Número da Parcela              | Parcela que está sendo paga                   |
// +---------------------------------------------------------------------------------+
// |  Número do NSU                  | Número do NSU com 9 Dígitos                   |
// +---------------------------------------------------------------------------------+
// |  Número do NSU REF              | Número do NSU com 15 Dígitos                  |
// +---------------------------------------------------------------------------------+
// |  Nome do Arquivo                | Nome do Arquivo importado                     |
// +---------------------------------------------------------------------------------+
// |  Data do Arquivo                | Data do Arquivo importado                     |
// +---------------------------------------------------------------------------------+

  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strNum_RV: String;
    strDta_RV: String;
    strDtaPag: String;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    fltRV_Bru: Double;
    fltRV_Liq: Double;
    fltValTax: Double;
    fltValDes: Double;
    fltValPag: Double;
    fltValEnc: Double;
    strRVNPar: String;
    strRVTPar: String;
    strNumAnt: String;
    strVenOri: String;
    fltLiqAnt: Double;
    strNumNSU: String;
    strDtaTra: String;
    strNumCar: String;
    fltValVen: Double;
    strTotPar: String;
    strNumPar: String;
    fltValPar: Double;
    strCodAut: String;
    strStatus: String;
    strNumTer: String;
    strTipPag: String;
    strNomArq: String;
    strDtaArq: String;
    strMotAju: String;

    Metadado01,
    ContaPagamento,
    IDRecorrencia,
    ConteudoRecorrencia,
    InformacoesAdicionais,

    IdentificadorAjuste,

    VersaoArquivo: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TRegistroGetNetPgto10_1 = record
    TipoRegistro,
    CodigoEstabelecimento,

    CodigoProduto,
    FormaCaptura,

    NumeroRV,
    DataRV,
    DataPagamento,

    NumeroNSU,
    CodigoAutorizacao,
    DataTransacao,
    NumeroCartao,
    StatusTransacao,

    CodigoTerminal,
    CarteiraDigital,

    CodigoBanco,
    CodigoAgencia,
    CodigoContaCorrente,

    TipoPagamentoOperacao,
    NumeroParcela,
    TotalParcelas,
    CentralizadorPagamento,

    DataVencimentoOriginal,
    NumeroControle,
    ChaveUR,

    Metadados,

    IdentificadorAjuste,
    MotivoAjuste,
    DataCartaCancelamento,
    NumeroRVOriginal,
    NSUOriginal,
    DataPagamentoOriginal,

    NumeroOperacao,
    TipoConta,
    CanalOperacao,
    TipoMovimento: String;

    ValorBrutoRV,
    ValorLiquidoRV,
    ValorTaxaRV,
    ValorRejeitadoRV,
    ValorCreditadoRV,
    ValorLiquidoCI,
    ValorParcela,
    ValorComissaoMDR,
    TaxaMensalOperacao,
    ValorTransacao,
    ValorTarifaRV: Double;

    DataArquivo,
    NomeArquivo,
    TipoArquivo: String;

    VersaoArquivo: String;
  End;

  TArrRegistroGetNetPgto10_1 = Array Of TRegistroGetNetPgto10_1;

  TArrRegistroGetNetPgto  = Array Of TRegistroPgto;

  TArrEstruturaGetNetPgto  = Array Of TEstruturaPgto;

   {* Exclusão arquivos *}
  type
  IOperadora = interface
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
    function fGetNomeOperadora: string;

    property ColunaDTAARQ: string read fGetColunaDTAARQ;
    property ColunaNOMARQ: string read fGetColunaNOMARQ;
    property ColunaCONCIL: string read fGetColunaCONCIL;
    property DireitoAcesso: string read fGetDireitoAcesso;
    property NomeRotina: string read fGetNomeRotina;
    property Tabela: string read fGetTabela;
    property NomeOperadora: string read fGetNomeOperadora;
  end;

  TGetnetExclusao = class(TInterfacedObject, IOperadora)
  private
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeOperadora: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
  end;

implementation

{ TGetNetExclusao }

function TGetNetExclusao.fGetColunaCONCIL: string;
begin
  Result := 'GET_CONCIL';
end;

function TGetNetExclusao.fGetColunaDTAARQ: string;
begin
  Result := 'GET_DTAARQ';
end;

function TGetNetExclusao.fGetColunaNOMARQ: string;
begin
  Result := 'GET_NOMARQ';
end;

function TGetNetExclusao.fGetDireitoAcesso: string;
begin
  Result := 'mnuExcluirArquivoDaGetNet';
end;

function TGetNetExclusao.fGetNomeOperadora: string;
begin
  Result := 'GetNet';
end;

function TGetNetExclusao.fGetNomeRotina: string;
begin
  Result := 'Excluir arquivos importados da GetNet';
end;

function TGetNetExclusao.fGetTabela: string;
begin
  Result := 'GET_GEPGTO';
end;


end.
