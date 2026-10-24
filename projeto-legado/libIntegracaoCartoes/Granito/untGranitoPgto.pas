unit untGranitoPgto;

interface

uses
  Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
  Dialogs, Forms, untFuncoesSimples, Uni;

type
  TRegistroGranito = record
  private
    FValorTaxaAntecipacaoParcela: Double;
    FValorBrutoParcela: Double;
    FValorTaxaADMParcela: Double;
    FIDProjetoGranito: Integer;
    FIDTransacaoOriginal: Int64;
    FIDRecorrenciaGranito: Integer;
    FTipoAjuste: Integer;
    FQuantidadeParcelasTransacao: Integer;
    FIDTransacao: Int64;
    FContaDeposito: string;
    FCodigoRetornoTransacaoECommerce: string;
    FIDTransacaoECommerce: string;
    FCodigoSimulacaoAntecipacao: Int64;
    FCNPJPrincipal: string;
    FIDPagamentoPix: string;
    FPercentualTaxaMDR: Double;
    FAgenciaDeposito: string;
    FNumeroParcela: Integer;
    FCNPJParceiro: string;
    FValorLiquidoTransacao: Double;
    FAutorizacao: string;
    FNumeroPDV: Integer;
    FBandeira: Integer;
    FNSUHost: string;
    FIDTransacaoECommerceCliente: string;
    FTipoTransacao: Integer;
    FDocumentoVinculado: string;
    FOrigemTransacao: Integer;
    FValorIOF: Double;
    FValorLiquidoParcela: Double;
    FDataLancamentoOriginal: TDate;
    FDataTransacao: TDate;
    FTipoLancamento: Integer;
    FNumeroSequencial: Integer;
    FNSUPDV: string;
    FDataLancamento: TDate;
    FCNPJEstabelecimento: string;
    FValorTaxaAntecipacaoTransacao: Double;
    FValorBrutoTransacao: Double;
    FCreditoDebitoTransacao: Integer;
    FValorTaxaADMTransacao: Double;
    FPercentualTaxaAntecipacao: Double;
    FCodigoBancoDeposito: Integer;
    FHoraTransacao: TTime;
    FTipoRegistro: Integer;
    function GetNomeBandeira: string;
  public
    property NumeroSequencial: Integer read FNumeroSequencial;
    property TipoRegistro: Integer read FTipoRegistro;
    property CNPJEstabelecimento: string read FCNPJEstabelecimento;
    property IDTransacao: Int64 read FIDTransacao;
    property DataTransacao: TDate read FDataTransacao;
    property HoraTransacao: TTime read FHoraTransacao;
    property CreditoDebitoTransacao: Integer read FCreditoDebitoTransacao;
    property Bandeira: Integer read FBandeira;
    property ValorBrutoTransacao: Double read FValorBrutoTransacao;
    property ValorTaxaADMTransacao: Double read FValorTaxaADMTransacao;
    property ValorTaxaAntecipacaoTransacao: Double read FValorTaxaAntecipacaoTransacao;
    property ValorLiquidoTransacao: Double read FValorLiquidoTransacao;
    property QuantidadeParcelasTransacao: Integer read FQuantidadeParcelasTransacao;
    property NumeroParcela: Integer read FNumeroParcela;
    property ValorBrutoParcela: Double read FValorBrutoParcela;
    property ValorTaxaADMParcela: Double read FValorTaxaADMParcela;
    property ValorTaxaAntecipacaoParcela: Double read FValorTaxaAntecipacaoParcela;
    property ValorLiquidoParcela: Double read FValorLiquidoParcela;
    property DataLancamento: TDate read FDataLancamento;
    property TipoLancamento: Integer read FTipoLancamento;
    property IDTransacaoOriginal: Int64 read FIDTransacaoOriginal;
    property TipoAjuste: Integer read FTipoAjuste;
    property ValorIOF: Double read FValorIOF;
    property DataLancamentoOriginal: TDate read FDataLancamentoOriginal;
    property CodigoSimulacaoAntecipacao: Int64 read FCodigoSimulacaoAntecipacao;
    property NumeroPDV: Integer read FNumeroPDV;
    property OrigemTransacao: Integer read FOrigemTransacao;
    property IDTransacaoECommerce: string read FIDTransacaoECommerce;
    property IDTransacaoECommerceCliente: string read FIDTransacaoECommerceCliente;
    property CodigoRetornoTransacaoECommerce: string read FCodigoRetornoTransacaoECommerce;
    property CNPJPrincipal: string read FCNPJPrincipal;
    property DocumentoVinculado: string read FDocumentoVinculado;
    property CNPJParceiro: string read FCNPJParceiro;
    property CodigoBancoDeposito: Integer read FCodigoBancoDeposito;
    property AgenciaDeposito: string read FAgenciaDeposito;
    property ContaDeposito: string read FContaDeposito;
    property PercentualTaxaMDR: Double read FPercentualTaxaMDR;
    property PercentualTaxaAntecipacao: Double read FPercentualTaxaAntecipacao;
    property TipoTransacao: Integer read FTipoTransacao;
    property Autorizacao: string read FAutorizacao;
    property NSUHost: string read FNSUHost;
    property IDRecorrenciaGranito: Integer read FIDRecorrenciaGranito;
    property IDProjetoGranito: Integer read FIDProjetoGranito;
    property IDPagamentoPix: string read FIDPagamentoPix;
    property NSUPDV: string read FNSUPDV;
    property NomeBandeira: string read GetNomeBandeira;
  end;

  TArrRegistroGranitoMovimentoFinanceiro = array of TRegistroGranito;

  TEstruturaPgto = record
    strDescri: string;
    strTipCmp: string;
  end;

  TGranitoPgto = class(TInterfacedObject, ICartoes)
  private
    FNomeArquivoImportado: string;
  public
    constructor Create;
    destructor Destroy; override;

    function fConverterParaDate(AValor: string): TDate;
    function fConverterParaDouble(AValor: string): Double;
    function fConverterParaInteger(AValor: string): Integer;
    function fConverterParaBigInt(AValor: string): Int64;
    function fConverterParaString(AValor: string): string;
    function fConverterParaTime(AValor: string): TTime;
    function fExtrairValor(AStrString: string; AIndex, ALength: Integer; AVarType: TVarType): Variant;

    procedure pAdicionaLinha(strString: string); overload;
    procedure pGravarRegistros(pgbProg: TProgressBar);

    property NomeArquivoImportado: string read FNomeArquivoImportado write FNomeArquivoImportado;
  end;

implementation

uses
  untGranito, untFuncoes;

constructor TGranitoPgto.Create;
begin
  FNomeArquivoImportado := '';
end;

destructor TGranitoPgto.Destroy;
begin
  inherited;
end;

function TGranitoPgto.fExtrairValor(
  AStrString: string; AIndex,
  ALength: Integer;
  AVarType: TVarType): Variant;
var
  sValorExtraido: string;
begin
  sValorExtraido := Copy(AStrString, AIndex, ALength);
  case AVarType of
    varInteger:
      Result := fConverterParaInteger(sValorExtraido);

    varInt64:
      Result := fConverterParaBigInt(sValorExtraido);

    varDouble:
      Result := fConverterParaDouble(sValorExtraido);

    varDate:
      if ALength = 8 then
        Result := fConverterParaDate(sValorExtraido)
      else
        Result := fConverterParaTime(sValorExtraido);
  else
    Result := fConverterParaString(sValorExtraido);
  end;
end;

function TGranitoPgto.fConverterParaBigInt(AValor: string): Int64;
begin
  Result := StrToInt64Def(AValor, 0);
end;

function TGranitoPgto.fConverterParaDate(AValor: string): TDate;
var
  iDia, iMes, iAno: Word;
begin
//   Formato AAAAMMDD
  iAno := StrToIntDef(Copy(AValor, 1, 4), 0);
  iMes := StrToIntDef(Copy(AValor, 5, 2), 0);
  iDia := StrToIntDef(Copy(AValor, 7, 2), 0);
  Result := EncodeDate(iAno, iMes, iDia);
end;

function TGranitoPgto.fConverterParaTime(AValor: string): TTime;
var
  iHor, iMin, iSeg: Word;
begin
//   Formato HHMMSS
  iHor := StrToIntDef(Copy(AValor, 1, 2), 0);
  iMin := StrToIntDef(Copy(AValor, 3, 2), 0);
  iSeg := StrToIntDef(Copy(AValor, 5, 2), 0);
  Result := EncodeTime(iHor, iMin, iSeg, 0);
end;

function TGranitoPgto.fConverterParaDouble(AValor: string): Double;
begin
  Result := fStrToFloat(AValor);
end;

function TGranitoPgto.fConverterParaInteger(AValor: string): Integer;
begin
  Result := StrToIntDef(AValor, 0);
end;

function TGranitoPgto.fConverterParaString(AValor: string): string;
begin
  Result := Trim(AValor);
end;

procedure TGranitoPgto.pAdicionaLinha(strString: string);
var
  T: ^TRegistroGranito;
  iTipoRegistro: Integer;
begin
  iTipoRegistro := fExtrairValor(strString, 1, 1, varInteger);

//  *** Tipo registro ***
//  0 - Header do arquivo
//  1 – Transação
//  2 – Cancelamento / Desfazimento
//  3 – Ajuste
//  4 – Cobrança
//  5 - Recebimento PIX

  if iTipoRegistro = 0 then { HEADER DO ARQUIVO }
    Exit;

  SetLength(FRegistroGranitoMovimentoFinanceiro, Length(FRegistroGranitoMovimentoFinanceiro)+1);
  T := @FRegistroGranitoMovimentoFinanceiro[Length(FRegistroGranitoMovimentoFinanceiro)-1];

  T^.FNumeroSequencial := fExtrairValor(strString, 2, 6, varInteger);
  T^.FTipoRegistro := iTipoRegistro;
  T^.FCNPJEstabelecimento := fExtrairValor(strString, 8, 14, varString);
  T^.FIDTransacao := fExtrairValor(strString, 22, 12, varInt64);
  T^.FDataTransacao := fExtrairValor(strString, 34, 8, varDate);
  T^.FHoraTransacao := fExtrairValor(strString, 42, 6, varDate);

  T^.FCreditoDebitoTransacao := fExtrairValor(strString, 48, 1, varInteger);
//  *** Tipo da transação ***
//  0 – Não se aplica
//  1 – Crédito
//  2 – Débito

  T^.FBandeira := fExtrairValor(strString, 49, 2, varInteger);
//  *** Bandeira ***
//  0 – Não se aplica
//  1 - VISA
//  2 - MASTERCARD
//  3 - VISA ELECTRON
//  4 – MAESTRO
//  12 – ELO CRÉDITO
//  13 – ELO DÉBITO
//  16 – AMERICAN EXPRESS
//  19 – HIPERCARD
//  20 – HIPER

  T^.FValorBrutoTransacao := fExtrairValor(strString, 51, 10, varDouble);
  T^.FValorTaxaADMTransacao := fExtrairValor(strString, 61, 10, varDouble);
  T^.FValorTaxaAntecipacaoTransacao := fExtrairValor(strString, 71, 10, varDouble);
  T^.FValorLiquidoTransacao := fExtrairValor(strString, 81, 10, varDouble);
  T^.FQuantidadeParcelasTransacao := fExtrairValor(strString, 91, 2, varInteger);
  T^.FNumeroParcela := fExtrairValor(strString, 93, 2, varInteger);
  T^.FValorBrutoParcela := fExtrairValor(strString, 95, 10, varDouble);
  T^.FValorTaxaADMParcela := fExtrairValor(strString, 105, 10, varDouble);
  T^.FValorTaxaAntecipacaoParcela := fExtrairValor(strString, 115, 10, varDouble);
  T^.FValorLiquidoParcela := fExtrairValor(strString, 125, 10, varDouble);
  T^.FDataLancamento := fExtrairValor(strString, 135, 8, varDate);

  T^.FTipoLancamento := fExtrairValor(strString, 143, 1, varInteger);
//  *** Tipo Lancamento ***
//  1 – Previsão
//  2 – Liquidação
//  3 – Liquidação antecipada

  T^.FIDTransacaoOriginal := fExtrairValor(strString, 144, 12, varInt64);

  T^.FTipoAjuste := fExtrairValor(strString, 156, 1, varInteger);
//  *** Tipo Ajuste ***
//  0 – Não se aplica ao tipo de registro
//  1 – Crédito
//  2 – Débito

  T^.FValorIOF := fExtrairValor(strString, 157, 10, varDouble);
  T^.FDataLancamentoOriginal := fExtrairValor(strString, 167, 8, varDate);
  T^.FCodigoSimulacaoAntecipacao := fExtrairValor(strString, 175, 10, varInt64);
  T^.FNumeroPDV := fExtrairValor(strString, 185, 3, varInteger);

  T^.FOrigemTransacao := fExtrairValor(strString, 188, 1, varInteger);
//  *** Origem Transação ***
//  0 - Manual
//  1 – POS
//  2 – E-Commerce

  T^.FIDTransacaoECommerce := fExtrairValor(strString, 189, 36, varString);
  T^.FIDTransacaoECommerceCliente := fExtrairValor(strString, 225, 40, varString);
  T^.FCodigoRetornoTransacaoECommerce := fExtrairValor(strString, 265, 7, varString);
  T^.FCNPJPrincipal := fExtrairValor(strString, 272, 14, varString);
  T^.FDocumentoVinculado := fExtrairValor(strString, 286, 12, varString);
  T^.FCNPJParceiro := fExtrairValor(strString, 298, 14, varString);
  T^.FCodigoBancoDeposito := fExtrairValor(strString, 312, 3, varInteger);
  T^.FAgenciaDeposito := fExtrairValor(strString, 315, 5, varString);
  T^.FContaDeposito := fExtrairValor(strString, 320, 12, varString);
  T^.FPercentualTaxaMDR := fExtrairValor(strString, 332, 4, varDouble);
  T^.FPercentualTaxaAntecipacao := fExtrairValor(strString, 336, 4, varDouble);

  T^.FTipoTransacao := fExtrairValor(strString, 340, 3, varInteger);
//  *** Tipo Transação ***
//  0 – Não se aplica
//  1 - Transação a crédito
//  2 - Transação a débito
//  3 - Transação a crédito antecipada
//  400 - Cancelamento com o cartão maquininha
//  420 - Desfazimento automático na maquininha ou servidor devido a problemas na comunicação
//  450 - Cancelamento por solicitação estabelecimento
//  460 - Desfazimento vindo da bandeira por solicitação do cliente final ou alguma inconsistência
//  490 - Cancelamento parcial de transação
//  500 - Débito por pagamento duplicado
//  502 - Débito por pagamento indevido
//  520 - Débito acordado com o financeiro da GRANITO
//  521 - Débito referente à reposição de equipamentos
//  522 - Cobrança referente utilização do chip telefonia
//  530 - Tarifa referente a emissão de cartão pré-pago
//  600 - Crédito transação cancelada indevidamente
//  620 - Crédito valor cobrado indevidamente pedido
//  700 - Crédito por taxa de antecipação indevida
//  701 - Crédito por taxa de administração indevida
//  702 - Pagamentos de transações de outro cadastro
//  703 - Crédito por diferença entre valores a pagar e valores pagos
//  800 - Serviço de cobrança utilizado por parceiros
//  801 - Crédito por cobrança não efetivada
//  810 - Débito referente a transferência de recebível solicitada por cliente parceiro
//  811 - Crédito referente a transferência de recebível de cliente parceiro
//  812 - Débito referente a compra de recebíveis
//  813 - Crédito referente a compra de recebíveis
//  814 - Recebíveis cedidos à empresa de fomento atráves de pagamento antecipado
//  815 - Transferência para validar os dados bancários informados no cadastro
//  816 - Crédito em cartão pré-pago de filial GRANITO
//  817 - Débito referente à pagamento de máquinas
//  818 - Recebíveis de parcelas de recorrente cedidos
//  819 - Recebíveis de parcelas de recorrente captados
//  820 - Chargeback Débito
//  821 - Crédito referente a bonificação do plano de incentivo.
//  822 - Crédito referente a chargeback regularizado por parceiro

  T^.FAutorizacao := fExtrairValor(strString, 343, 12, varString);
  T^.FNSUHost := fExtrairValor(strString, 355, 32, varString);
  T^.FIDRecorrenciaGranito := fExtrairValor(strString, 387, 10, varInteger);
  T^.FIDProjetoGranito := fExtrairValor(strString, 397, 4, varInteger);
  T^.FIDPagamentoPix := fExtrairValor(strString, 401, 36, varString);
  T^.FNSUPDV := fExtrairValor(strString, 438, 32, varString);
end;

procedure TGranitoPgto.pGravarRegistros(pgbProg: TProgressBar);
var
  Query: TUniQuery;
  rGranito: TRegistroGranito;
  sEstabelecimento: string;
begin
  Query := untFuncoes.CriarQueryDLL;
  try
    pgbProg.Position := 0;

    if Length(FRegistroGranitoMovimentoFinanceiro) = 0 then
      Exit;

    Query.SQL.Text := RetornaReplaceTabela('GRA_GRPGTO', ['GRA_CONCIL']);
    pgbProg.Max := Length(FRegistroGranitoMovimentoFinanceiro) - 1;

    for rGranito in FRegistroGranitoMovimentoFinanceiro do
    begin
      Query.Close;

      Query.ParamByName('GRA_NUMSEQ').AsInteger := rGranito.FNumeroSequencial;
      Query.ParamByName('GRA_TIPREG').AsInteger := rGranito.FTipoRegistro;
      Query.ParamByName('GRA_CNPJES').AsString := rGranito.FCNPJEstabelecimento;
      Query.ParamByName('GRA_NUMTRA').AsLargeInt := rGranito.FIDTransacao;
      Query.ParamByName('GRA_DTATRA').AsDate := rGranito.FDataTransacao;
      Query.ParamByName('GRA_HORTRA').AsTime := rGranito.FHoraTransacao;
      Query.ParamByName('GRA_CREDEB').AsInteger := rGranito.FCreditoDebitoTransacao;
      Query.ParamByName('GRA_NUMBAN').AsInteger := rGranito.FBandeira;
      Query.ParamByName('GRA_BRUTRA').AsFloat := rGranito.FValorBrutoTransacao;
      Query.ParamByName('GRA_TAXTRA').AsFloat := rGranito.FValorTaxaADMTransacao;
      Query.ParamByName('GRA_ANTTRA').AsFloat := rGranito.FValorTaxaAntecipacaoTransacao;
      Query.ParamByName('GRA_LIQTRA').AsFloat := rGranito.FValorLiquidoTransacao;
      Query.ParamByName('GRA_TOTPAR').AsInteger := rGranito.FQuantidadeParcelasTransacao;
      Query.ParamByName('GRA_NUMPAR').AsInteger := rGranito.FNumeroParcela;
      Query.ParamByName('GRA_VALBRU').AsFloat := rGranito.FValorBrutoParcela;
      Query.ParamByName('GRA_VALTAX').AsFloat := rGranito.FValorTaxaADMParcela;
      Query.ParamByName('GRA_TAXANT').AsFloat := rGranito.FValorTaxaAntecipacaoParcela;
      Query.ParamByName('GRA_VALLIQ').AsFloat := rGranito.FValorLiquidoParcela;
      Query.ParamByName('GRA_DTALAN').AsDate := rGranito.FDataLancamento;
      Query.ParamByName('GRA_TIPLAN').AsInteger := rGranito.FTipoLancamento;
      Query.ParamByName('GRA_IDTORI').AsLargeInt := rGranito.FIDTransacaoOriginal;
      Query.ParamByName('GRA_TIPAJU').AsInteger := rGranito.FTipoAjuste;
      Query.ParamByName('GRA_IOFANT').AsFloat := rGranito.FValorIOF;
      Query.ParamByName('GRA_LANORI').AsDate := rGranito.FDataLancamentoOriginal;
      Query.ParamByName('GRA_CODSML').AsLargeInt := rGranito.FCodigoSimulacaoAntecipacao;
      Query.ParamByName('GRA_ESTPDV').AsInteger := rGranito.FNumeroPDV;
      Query.ParamByName('GRA_ORITRA').AsInteger := rGranito.FOrigemTransacao;
      Query.ParamByName('GRA_IDTECM').AsString := rGranito.FIDTransacaoECommerce;
      Query.ParamByName('GRA_IDCECM').AsString := rGranito.FIDTransacaoECommerceCliente;
      Query.ParamByName('GRA_RETECM').AsString := rGranito.FCodigoRetornoTransacaoECommerce;
      Query.ParamByName('GRA_CNPJPR').AsString := rGranito.FCNPJPrincipal;
      Query.ParamByName('GRA_DOCVIN').AsString := rGranito.FDocumentoVinculado;
      Query.ParamByName('GRA_CNPJPA').AsString := rGranito.FCNPJParceiro;
      Query.ParamByName('GRA_BANDEP').AsInteger := rGranito.FCodigoBancoDeposito;
      Query.ParamByName('GRA_AGEDEP').AsString := rGranito.FAgenciaDeposito;
      Query.ParamByName('GRA_CNTDEP').AsString := rGranito.FContaDeposito;
      Query.ParamByName('GRA_PERTAX').AsFloat := rGranito.FPercentualTaxaMDR;
      Query.ParamByName('GRA_PERANT').AsFloat := rGranito.FPercentualTaxaAntecipacao;
      Query.ParamByName('GRA_TIPTRA').AsInteger := rGranito.FTipoTransacao;
      Query.ParamByName('GRA_CODAUT').AsString := rGranito.FAutorizacao;
      Query.ParamByName('GRA_NUMNSU').AsString := rGranito.FNSUHost;
      Query.ParamByName('GRA_IDTREC').AsInteger := rGranito.FIDRecorrenciaGranito;
      Query.ParamByName('GRA_IDTPRO').AsInteger := rGranito.FIDProjetoGranito;
      Query.ParamByName('GRA_NUMPIX').AsString := rGranito.FIDPagamentoPix;
      Query.ParamByName('GRA_NSUPDV').AsString := rGranito.FNSUPDV;
      Query.ParamByName('GRA_NOMARQ').AsString := FNomeArquivoImportado;
      Query.ParamByName('GRA_NOMBAN').AsString := rGranito.GetNomeBandeira;

      Query.ExecSQL;
      pStep(pgbProg);
    end;

    SetLength(FRegistroGranitoMovimentoFinanceiro, 0);

    try
      Query.SQL.Text := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "GRANITO")';
      for sEstabelecimento in lstEstabel do
      begin
        Query.ParamByName('ESTAB').AsString := sEstabelecimento;
        Query.ExecSQL;
      end;
    except
      raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    end;
  finally
    Query.Free;
  end;
end;

{ TRegistroGranito }

function TRegistroGranito.GetNomeBandeira: string;
begin
  case FBandeira of
    01: Result := 'VISA';
    02: Result := 'MASTERCARD';
    03: Result := 'VISA ELECTRON';
    04: Result := 'MAESTRO';
    12: Result := 'ELO CRÉDITO';
    13: Result := 'ELO DÉBITO';
    16: Result := 'AMERICAN EXPRESS';
    19: Result := 'HIPERCARD';
    20: Result := 'HIPER';
  else
    Result := '';
  end;
end;

end.
