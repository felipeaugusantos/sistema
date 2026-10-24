{***************************************}
{* Importação de arquivos da FISERVBIN *}
{************************************TA*}
unit untFiservBinPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms,
     Math, Uni,untFuncoesSimples,Json;

Type
  TRegistroMovimentoFinanceiro = Record
    TipoRegistro,
    BandeiraCartao,
    DataPagamento,
    Estabelecimento,
    EstabelecimentoCentralizador,
    InstrucaoPagamento,
    NumeroResumoVenda,
    QuantidadeROC,
    TipoPagamento,
    TipoTransacao,
    CodigoDescricaoTransacao,
    Descricaotransacao,
    ResumoPagamento,
    CNPJBeneficiarioLockin,
    TipoLockin,
    TipoContaPagamento,
    StatusPagamento,
    DescricaoTransacaoPagamento,
    ChargebackComprovanteReferencia,
    NumeroComprovanteVenda,
    TipoTransacaoVenda,
    DataTransacao,
    HorarioCriacao,
    NumeroParcela,
    TotalParcelas,
    NumeroContaEC,
    DataGeracaoSOC,
    DataPagamentoSOC,
    NumeroControleCliente,
    NumeroCartao,
    CodigoAutorizacao,
    NumeroComprovanteNSU,
    TipoComprovante,
    ValorBrutoROC,
    ValorTaxaImpostosROC,
    ValorLiquidoROC,
    ValorTaxaAntecipacaoROC,
    ValorLiquidoAntecipacaoROC,
    ValorCompraComSaque,
    ReversaoIntercambio,
    ValorBrutoVenda,
    NumeroRegistroArquivo,
    NomeArquivo: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaFiservBinPgto  = Array Of TEstruturaPgto;

  TArrRegistroFiservBinMovimentoFinanceiro = Array Of TRegistroMovimentoFinanceiro;
  TFiservBinPgto = Class(TInterfacedObject, ICartoes)
  Private
    strRegAnt: String;
    intPosicaoAtual: Integer;
    FIncAddMovimentoFinanceiro:Integer;
    Colunas:TStringList;
    procedure ImportaCreditoParcelado;
    procedure ImportaAjustesProgramados;
    procedure ImportaCredito;
    procedure ImportaDebitos;
    function CorrigeCampoData(ADate: String): String;
    function CorrigeNumeroParcela(AParcela:String): String;
    function CorrigeCampoNumerico(AValor: String): String;
    function RetornaDelimitador(AText: String): Char;
    function CorrigeDadosBanco(AValor: Variant): Variant;
    function ConverterParaNegativo(AValor:String): String;
    function ValidarJsonMovimentacaoFinanceira(const AJson: string): Boolean;
    procedure ProcessarJsonMovimentoFinanceiro(const AConteudoJson: string);

    procedure ProcessarFinanceAdjustments(LAdjustments: TJSONArray);

    procedure ProcessarDebitFinanceSummary(LDebitFinance: TJSONArray);
    procedure ProcessarDebitFinanceReceipt(LReceipt: TJSONObject);

    procedure ProcessarCreditFinanceSummary(LCreditFinance: TJSONArray);
    procedure ProcessarCreditFinanceReceipt(LReceipt: TJSONObject);

    procedure ProcessarInstallmentFinanceSummary(LInstallmentFinance: TJSONArray);
    procedure ProcessarInstallmentFinanceReceipt(LReceipt: TJSONObject);


    procedure ProcessarAdjustment(LAdjustment: TJSONObject);
    procedure pProcessarJson(const AConteudoJson: string);

    // Helper functions para JSON
    function GetJSONStringValue(AJSONObject: TJSONObject; const APropertyName: string; const ADefault: string = ''): string;

  Public
    constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

  End;

Var
  strNomArq,
  strArqAnt: String;
  intParAju: Integer;
  FImportouPagamentos: Boolean;

implementation

uses untFuncoes, untIDataSet;

{ TFiservBinPgto }

function TFiservBinPgto.ConverterParaNegativo(AValor: String): String;
var
  ValorNumerico: Double;
begin

  if TryStrToFloat(AValor.Replace('.',','), ValorNumerico) then
  begin
    if ValorNumerico > 0 then
      Result := FloatToStr(-ValorNumerico).Replace(',','.')
    else
      Result := FloatToStr(ValorNumerico).Replace(',','.');
  end
  else
    Result := AValor;
end;

function TFiservBinPgto.CorrigeCampoData(ADate: String): String;
begin
  Result := '';

  If fEmptyStr(ADate) Then
    Exit;

  Try
    ADate  := StringReplace(ADate,'-','',[rfReplaceAll]);
    ADate  := StringReplace(ADate,'/','',[rfReplaceAll]);
    Result := Concat(Copy(ADate,5,4),'-',Copy(ADate,3,2),'-',Copy(ADate,1,2));
  Except
    Result := '';
  End;
end;

function TFiservBinPgto.CorrigeCampoNumerico(AValor: String): String;
begin
  Result := '';

  Try
    AValor := StringReplace(AValor,',','',[rfReplaceAll]);
    AValor := StringReplace(AValor,'.','',[rfReplaceAll]);
    AValor := StringReplace(AValor,'R$','',[rfReplaceAll]);

    If Not fEmptyStr(AValor) Then
      Result := (StrToFloat(AValor)/100).ToString;

    Result  := StringReplace(Result,',','.',[rfReplaceAll]);
  Except
    Result := '';
  End;
end;

function TFiservBinPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TFiservBinPgto.CorrigeNumeroParcela(AParcela: String): String;
begin
  If fEmptyStr(AParcela) Then
    AParcela := '1'
  Else If AParcela.Equals(fStrZero('0',AParcela.Length)) Then
    AParcela := '1'
  Else If Trim(AParcela).Equals('-') Then
    AParcela := '1';

  Result := LeftStr(AParcela,2);
  Result := fStrZero(Result.Replace('/',''),2);
end;

constructor TFiservBinPgto.Create;
Begin
  intPosicaoAtual := 0;
  FIncAddMovimentoFinanceiro := 0;
  strRegAnt := '';
  FIncAddMovimentoFinanceiro := 0;
  Colunas := TStringList.Create;
  FImportouPagamentos := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* FIS_FVPGTO                                   *}
{*********************************************TA*}
destructor TFiservBinPgto.Destroy;
begin
  FreeAndNil(Colunas);
  inherited;
end;

procedure TFiservBinPgto.ImportaAjustesProgramados;
begin
  SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro) + 1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := Colunas.Strings[0];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := Colunas.Strings[1];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := Colunas.Strings[3];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := Colunas.Strings[4];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := Colunas.Strings[5];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := Colunas.Strings [6];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := Colunas.Strings [7];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(Colunas.Strings[8]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := Colunas.Strings[9];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := Colunas.Strings[10];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSoc := CorrigeCampoData(Colunas.Strings[11]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := Colunas.Strings[12];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := Colunas.Strings[13];
  // Colunas.Strings[14] Número referência da conta de pagamento
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := Colunas.Strings[15];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := Colunas.Strings[16];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := CorrigirTexto(Colunas.Strings[17]);

  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := CorrigeCampoNumerico(Colunas.Strings[18]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[19]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[20]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := CorrigirTexto(Colunas.Strings[21]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := Colunas.Strings[22];
  // Colunas.Strings[23] Número do Terminal
  // Colunas.Strings[24] Acquirer Reference Number
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := Colunas.Strings[25];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;


  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';


 If LeftStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].TipoComprovante, 1).Equals('D') Then
 Begin
   FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda);
   FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC);
   FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC);
 End;

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
end;

procedure TFiservBinPgto.ImportaCredito;
begin
  SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := Colunas.Strings[09];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := Colunas.Strings[20];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[21]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[22];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[23];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[24]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[25]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[26];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[27];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[29];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[30];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := CorrigirTexto(Colunas.Strings[31]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TFiservBinPgto.ImportaCreditoParcelado;
begin
  SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := Colunas.Strings[9];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := Colunas.Strings[20];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[21]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[22];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := CorrigeNumeroParcela(Colunas.Strings[23]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := Colunas.Strings[24];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[25];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[26]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[27]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[28];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[29];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[31];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[32];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := CorrigirTexto(Colunas.Strings[33]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[38]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[39];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TFiservBinPgto.ImportaDebitos;
begin
  SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacao := Colunas.Strings[9];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[20]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[21];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[22];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[23]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[24]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[25];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[26];

  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[28];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[29];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := CorrigirTexto(Colunas.Strings[30]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[31]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TFiservBinPgto.pAdicionaLinha(strString: String);
Var
  lstCampos: TStringList;

  function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
    Var
      rst     : Variant;
      i       : Integer;
      strZeros: String;
  Begin
    rst := strValor;
    If blnFlt Then
    Begin
      strZeros := '';
      For i := 1 to intCasas do
        strZeros := strZeros + '0';

      rst := fStrToFloat(rst) / StrtoFloat('1' + strZeros);
    End;

    Result := rst;
  End;

begin
  If ValidarJsonMovimentacaoFinanceira(strString) Then
  Begin
    pProcessarJson(strString);
    Exit;
  End;

  lstCampos := TStringList.Create;
  lstCampos.Delimiter     := ',';
  lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  Colunas.Delimiter := RetornaDelimitador(strString);
  Colunas.StrictDelimiter := True;
  Colunas.DelimitedText := fConverteParaAcento(strString);
  If fEmptyStr(Colunas.Text) Then
    Exit;

  // Registro 025 – Detalhamento Ordem de Pagamento de Crédito Parcelado
  If Colunas.Strings[0].Equals('025') Then
  begin
    ImportaCreditoParcelado;
  end

  // Detalhamento (Pagamento) – Registro 021 – Detalhamento Ordem de Pagamento de Débito
  Else If Colunas.Strings[0].Equals('021') Then
  begin
    ImportaDebitos;
  end

  // Detalhamento (Pagamento) – Registro 023 – Detalhamento Ordem de Pagamento de Crédito
  Else IF Colunas.Strings[0].Equals('023') Then
  begin
    ImportaCredito;
  end
  // Registro 031 – Ajustes Programados (Próximos 30 Dias)
  Else IF Colunas.Strings[0].Equals('031') Then
  begin
    ImportaAjustesProgramados;
  end;

end;

procedure TFiservBinPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LMovimentoFinanceiro : TUniQuery;
    LContador: Integer;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 5, 4) + '/' + Copy(strVal, 3, 2) + '/' + Copy(strVal, 1, 2)
      else
        Result := strVal;
    End;
  End;

begin


  Try

    Try
      pgbProg.Position := 0;

      If Length(FRegistroFiservBinMovimentoFinanceiro) > 0 Then
      Begin
        LMovimentoFinanceiro := untFuncoes.CriarQueryDLL;

        LMovimentoFinanceiro.Close;
        LMovimentoFinanceiro.SQL.Clear;
        LMovimentoFinanceiro.SQL.Text := RetornaReplaceTabela('BIN_FVPGTO',['BIN_CONCIL']);


        pgbProg.Max := Length(FRegistroFiservBinMovimentoFinanceiro) - 1;

        For LContador := 0 To Length(FRegistroFiservBinMovimentoFinanceiro) - 1 Do
        Begin
          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.ParamByName('BIN_TIPREG').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoRegistro);
          LMovimentoFinanceiro.ParamByName('BIN_NOMBAN').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].BandeiraCartao);
          LMovimentoFinanceiro.ParamByName('BIN_DTAPAG').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_CODEST').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].Estabelecimento);
          LMovimentoFinanceiro.ParamByName('BIN_ESTCEN').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].EstabelecimentoCentralizador);
          LMovimentoFinanceiro.ParamByName('BIN_INSPAG').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].InstrucaoPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_NUM_RV').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroResumoVenda);
          LMovimentoFinanceiro.ParamByName('BIN_QTDROC').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].QuantidadeROC);
          LMovimentoFinanceiro.ParamByName('BIN_TIPPAG').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_TIPTRA').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoTransacao);
          LMovimentoFinanceiro.ParamByName('BIN_CODDES').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].CodigoDescricaoTransacao);
          LMovimentoFinanceiro.ParamByName('BIN_DESTRA').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].Descricaotransacao);
          LMovimentoFinanceiro.ParamByName('BIN_RESPAG').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ResumoPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_CNPJLC').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].CNPJBeneficiarioLockin);
          LMovimentoFinanceiro.ParamByName('BIN_TIPLOC').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoLockin);
          LMovimentoFinanceiro.ParamByName('BIN_TIPCTA').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoContaPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_STATUS').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].StatusPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_DESPAG').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DescricaoTransacaoPagamento);
          LMovimentoFinanceiro.ParamByName('BIN_COMREF').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ChargebackComprovanteReferencia);
          LMovimentoFinanceiro.ParamByName('BIN_REFVEN').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroComprovanteVenda);
          LMovimentoFinanceiro.ParamByName('BIN_TIPVEN').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoTransacaoVenda);
          LMovimentoFinanceiro.ParamByName('BIN_DTATRA').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataTransacao);
          LMovimentoFinanceiro.ParamByName('BIN_HORTRA').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].HorarioCriacao);
          LMovimentoFinanceiro.ParamByName('BIN_NUMPAR').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroParcela);
          LMovimentoFinanceiro.ParamByName('BIN_TOTPAR').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TotalParcelas);
          LMovimentoFinanceiro.ParamByName('BIN_NUMCTA').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroContaEC);
          LMovimentoFinanceiro.ParamByName('BIN_GERSOC').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataGeracaoSOC);
          LMovimentoFinanceiro.ParamByName('BIN_PAGSOC').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataPagamentoSOC);
          LMovimentoFinanceiro.ParamByName('BIN_CONCLI').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroControleCliente);
          LMovimentoFinanceiro.ParamByName('BIN_NUMCAR').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroCartao);
          LMovimentoFinanceiro.ParamByName('BIN_CODAUT').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].CodigoAutorizacao);
          LMovimentoFinanceiro.ParamByName('BIN_NUMNSU').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroComprovanteNSU);
          LMovimentoFinanceiro.ParamByName('BIN_TIPCON').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoComprovante);
          LMovimentoFinanceiro.ParamByName('BIN_VALBRU').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorBrutoROC);
          LMovimentoFinanceiro.ParamByName('BIN_VALTAX').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorTaxaImpostosROC);
          LMovimentoFinanceiro.ParamByName('BIN_VALLIQ').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorLiquidoROC);
          LMovimentoFinanceiro.ParamByName('BIN_TAXANT').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoROC);
          LMovimentoFinanceiro.ParamByName('BIN_LIQANT').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorLiquidoAntecipacaoROC);
          LMovimentoFinanceiro.ParamByName('BIN_VALSAQ').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorCompraComSaque);
          LMovimentoFinanceiro.ParamByName('BIN_VALINT').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ReversaoIntercambio);
          LMovimentoFinanceiro.ParamByName('BIN_BRUVEN').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorBrutoVenda);
          LMovimentoFinanceiro.ParamByName('BIN_SEQARQ').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroRegistroArquivo);
          LMovimentoFinanceiro.ParamByName('BIN_NOMARQ').Value := CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NomeArquivo);
          LMovimentoFinanceiro.ExecSQL;

          If Not MatchStr(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoRegistro,['031']) Then
            FImportouPagamentos := True;

          pStep(pgbProg);
        End;

        SetLength(FRegistroFiservBinMovimentoFinanceiro,0);

        Try
          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.SQL.Text := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "FISERVBIN")';
          For LContador := 0 To lstEstabel.Count - 1 Do
          Begin
            LMovimentoFinanceiro.ParamByName('ESTAB').AsString := lstEstabel[LContador];
            LMovimentoFinanceiro.ExecSQL;
          End;
        Except
          Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
        End;


      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    If Assigned(LMovimentoFinanceiro) Then
      FreeAndNil(LMovimentoFinanceiro);
  End;

end;

function TFiservBinPgto.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

procedure TFiservBinPgto.pProcessarJson(const AConteudoJson: string);
begin
  if AConteudoJson.Trim = '' then
    Exit;

  ProcessarJsonMovimentoFinanceiro(AConteudoJson);
end;

function TFiservBinPgto.GetJSONStringValue(AJSONObject: TJSONObject; const APropertyName: string; const ADefault: string = ''): string;
var
  LValue: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AJSONObject) then
    Exit;

  LValue := AJSONObject.GetValue(APropertyName);
  if Assigned(LValue) and not LValue.Null then
    Result := LValue.Value;
end;


procedure TFiservBinPgto.ProcessarJsonMovimentoFinanceiro(const AConteudoJson: string);
var
  LJsonObj: TJSONObject;
  LDebitFinance: TJSONArray;
  LCreditFinance: TJSONArray;
  LInstallmentFinance: TJSONArray;
  LAdjustments: TJSONArray;
begin
  LJsonObj := nil;
  try
    try
      LJsonObj := TJSONObject.ParseJSONValue(AConteudoJson) as TJSONObject;
      if not Assigned(LJsonObj) then
        Exit;

      // Processa Debit Finance Summary (registros 020/021)
      if LJsonObj.TryGetValue<TJSONArray>('debitFinanceSummary', LDebitFinance) then
        ProcessarDebitFinanceSummary(LDebitFinance);

      // Processa Credit Finance Summary (registros 022/023)
      if LJsonObj.TryGetValue<TJSONArray>('creditFinanceSummary', LCreditFinance) then
        ProcessarCreditFinanceSummary(LCreditFinance);

      // Processa Installment Finance Summary (registros 024/025)
      if LJsonObj.TryGetValue<TJSONArray>('installmentFinanceSummary', LInstallmentFinance) then
        ProcessarInstallmentFinanceSummary(LInstallmentFinance);

      // Processa Finance Adjustments (registros 031)
      if LJsonObj.TryGetValue<TJSONArray>('financeAdjustments', LAdjustments) then
        ProcessarFinanceAdjustments(LAdjustments);

    except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    end;
  finally
    if Assigned(LJsonObj) then
      LJsonObj.Free;
  end;
end;

procedure TFiservBinPgto.ProcessarDebitFinanceSummary(LDebitFinance: TJSONArray);
var
  I: Integer;
  LDebitItem: TJSONObject;
  LReceipts: TJSONArray;
  J: Integer;
begin
  for I := 0 to LDebitFinance.Count - 1 do
  begin
    LDebitItem := LDebitFinance.Items[I] as TJSONObject;

    // Processa os receipts (registros 021)
    if LDebitItem.TryGetValue<TJSONArray>('debitFinanceReceipt', LReceipts) then
    begin
      for J := 0 to LReceipts.Count - 1 do
      begin
        ProcessarDebitFinanceReceipt(LReceipts.Items[J] as TJSONObject);
      end;
    end;
  end;
end;

procedure TFiservBinPgto.ProcessarDebitFinanceReceipt(LReceipt: TJSONObject);
var
  LTipoRegistro: string;
begin
  LTipoRegistro := GetJSONStringValue(LReceipt, 'recordType');

  // Detalhamento (Pagamento) – Registro 021 – Detalhamento Ordem de Pagamento de Débito
  if (LTipoRegistro = '021') then
  begin
    SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro) + 1);
    Inc(FIncAddMovimentoFinanceiro);

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := GetJSONStringValue(LReceipt, 'recordType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := GetJSONStringValue(LReceipt, 'cardSchemeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(GetJSONStringValue(LReceipt, 'paymentDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := GetJSONStringValue(LReceipt, 'clientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].EstabelecimentoCentralizador := GetJSONStringValue(LReceipt, 'centralizingClientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].InstrucaoPagamento := GetJSONStringValue(LReceipt, 'paymentInstructionNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := GetJSONStringValue(LReceipt, 'salesSummaryNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].QuantidadeROC := GetJSONStringValue(LReceipt, 'quantityOfSales');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := GetJSONStringValue(LReceipt, 'paymentTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := GetJSONStringValue(LReceipt, 'transactionTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoDescricaoTransacao := GetJSONStringValue(LReceipt, 'transactionDescriptionCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := GetJSONStringValue(LReceipt, 'transactionDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ResumoPagamento := GetJSONStringValue(LReceipt, 'financeSummaryNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CNPJBeneficiarioLockin := GetJSONStringValue(LReceipt, 'beneficiaryInstituteLockin');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoLockin := GetJSONStringValue(LReceipt, 'lockinType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoContaPagamento := GetJSONStringValue(LReceipt, 'accountTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].StatusPagamento := GetJSONStringValue(LReceipt, 'paymentStatus');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DescricaoTransacaoPagamento := GetJSONStringValue(LReceipt, 'paymentTransactionTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ChargebackComprovanteReferencia := GetJSONStringValue(LReceipt, 'chargeBack');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := GetJSONStringValue(LReceipt, 'salesReference');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(GetJSONStringValue(LReceipt, 'transactionDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].HorarioCriacao := GetJSONStringValue(LReceipt, 'transactionTime');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := '01';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := '01';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroContaEC := GetJSONStringValue(LReceipt, 'accountNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSOC := CorrigeCampoData(GetJSONStringValue(LReceipt, 'recordDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamentoSOC := CorrigeCampoData(GetJSONStringValue(LReceipt, 'valueDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := GetJSONStringValue(LReceipt, 'clientControlNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := GetJSONStringValue(LReceipt, 'maskedCardNumber');

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := GetJSONStringValue(LReceipt, 'authorizationCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := GetJSONStringValue(LReceipt, 'salesReceiptNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := CorrigirTexto(GetJSONStringValue(LReceipt, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaImpostosROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'discountAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'netAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeNetAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorCompraComSaque := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'cashBackAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReversaoIntercambio := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'reverseInterchange'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LReceipt, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    if not Assigned(lstEstabel) then
      lstEstabel := TStringList.Create;

    if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
       (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
      lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
  end;
end;

procedure TFiservBinPgto.ProcessarFinanceAdjustments(LAdjustments: TJSONArray);
var
  I: Integer;
  LAdjustment: TJSONObject;
begin
  for I := 0 to LAdjustments.Count - 1 do
  begin
    LAdjustment := LAdjustments.Items[I] as TJSONObject;
    ProcessarAdjustment(LAdjustment);
  end;
end;

procedure TFiservBinPgto.ProcessarAdjustment(LAdjustment: TJSONObject);
var
  LTipoRegistro: string;
begin
  LTipoRegistro := GetJSONStringValue(LAdjustment, 'recordType');

  if (LTipoRegistro = '031') then
  begin
    SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro) + 1);
    Inc(FIncAddMovimentoFinanceiro);

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := GetJSONStringValue(LAdjustment, 'recordType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := GetJSONStringValue(LAdjustment, 'cardSchemeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(GetJSONStringValue(LAdjustment, 'adjustmentPaymentDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := GetJSONStringValue(LAdjustment, 'adjustmentClientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := GetJSONStringValue(LAdjustment, 'adjustmentNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := GetJSONStringValue(LAdjustment, 'transactionType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := GetJSONStringValue(LAdjustment, 'transactionDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := GetJSONStringValue(LAdjustment, 'salesReceiptNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(GetJSONStringValue(LAdjustment, 'transactionDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := GetJSONStringValue(LAdjustment, 'installmentNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := GetJSONStringValue(LAdjustment, 'totalInstallments');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSOC := CorrigeCampoData(GetJSONStringValue(LAdjustment, 'recordDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := GetJSONStringValue(LAdjustment, 'clientControlNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := GetJSONStringValue(LAdjustment, 'maskedCardNumber');

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := GetJSONStringValue(LAdjustment, 'authorizationCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := GetJSONStringValue(LAdjustment, 'chargebackReferenceCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := CorrigirTexto(GetJSONStringValue(LAdjustment, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := CorrigeCampoNumerico(GetJSONStringValue(LAdjustment, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LAdjustment, 'adjustmentAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LAdjustment, 'grossAdjustmentAmount'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := CorrigirTexto(GetJSONStringValue(LAdjustment, 'adjustmentDescription'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := GetJSONStringValue(LAdjustment, 'solicitationTypeDescription');

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LAdjustment, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;


    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU :=  GetJSONStringValue(LAdjustment, 'adjustmentNumber');
    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao :=  GetJSONStringValue(LAdjustment, 'authorizationCode');
    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela) Or
       FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela.Equals('0') then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := '01';

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas) Or
       FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas.Equals('0') then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := '01';

    if LeftStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante, 1).Equals('D') then
    begin
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda);
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC);
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC);
    end;
  end;

  if not Assigned(lstEstabel) then
    lstEstabel := TStringList.Create;

  if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
     (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
    lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
end;

procedure TFiservBinPgto.ProcessarCreditFinanceSummary(LCreditFinance: TJSONArray);
var
  I: Integer;
  LCreditItem: TJSONObject;
  LReceipts: TJSONArray;
  J: Integer;
begin
  for I := 0 to LCreditFinance.Count - 1 do
  begin
    LCreditItem := LCreditFinance.Items[I] as TJSONObject;

    // Processa os receipts (registros 023)
    if LCreditItem.TryGetValue<TJSONArray>('creditFinanceReceipt', LReceipts) then
    begin
      for J := 0 to LReceipts.Count - 1 do
      begin
        ProcessarCreditFinanceReceipt(LReceipts.Items[J] as TJSONObject);
      end;
    end;
  end;
end;

procedure TFiservBinPgto.ProcessarCreditFinanceReceipt(LReceipt: TJSONObject);
var
  LTipoRegistro: string;
begin
  LTipoRegistro := GetJSONStringValue(LReceipt, 'recordType');

  // Processa registro 023 - Detalhamento Ordem de Pagamento de Crédito
  if (LTipoRegistro = '023') then
  begin
    SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro) + 1);
    Inc(FIncAddMovimentoFinanceiro);

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := GetJSONStringValue(LReceipt, 'recordType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := GetJSONStringValue(LReceipt, 'cardSchemeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(GetJSONStringValue(LReceipt, 'paymentDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := GetJSONStringValue(LReceipt, 'clientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].EstabelecimentoCentralizador := GetJSONStringValue(LReceipt, 'centralizingClientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].InstrucaoPagamento := GetJSONStringValue(LReceipt, 'paymentInstructionNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := GetJSONStringValue(LReceipt, 'salesSummaryNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].QuantidadeROC := GetJSONStringValue(LReceipt, 'quantityOfSales');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := GetJSONStringValue(LReceipt, 'paymentTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := GetJSONStringValue(LReceipt, 'transactionTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoDescricaoTransacao := GetJSONStringValue(LReceipt, 'transactionDescriptionCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := GetJSONStringValue(LReceipt, 'transactionDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ResumoPagamento := GetJSONStringValue(LReceipt, 'financeSummaryNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CNPJBeneficiarioLockin := GetJSONStringValue(LReceipt, 'beneficiaryInstituteLockin');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoLockin := GetJSONStringValue(LReceipt, 'lockinType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoContaPagamento := GetJSONStringValue(LReceipt, 'accountTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].StatusPagamento := GetJSONStringValue(LReceipt, 'paymentStatus');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DescricaoTransacaoPagamento := GetJSONStringValue(LReceipt, 'paymentTransactionTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ChargebackComprovanteReferencia := GetJSONStringValue(LReceipt, 'chargeBack');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := GetJSONStringValue(LReceipt, 'salesReceiptNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := GetJSONStringValue(LReceipt, 'salesTransactionType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(GetJSONStringValue(LReceipt, 'transactionDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].HorarioCriacao := GetJSONStringValue(LReceipt, 'transactionTime');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := '01';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := '01';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroContaEC := GetJSONStringValue(LReceipt, 'accountNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSOC := CorrigeCampoData(GetJSONStringValue(LReceipt, 'recordDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamentoSOC := CorrigeCampoData(GetJSONStringValue(LReceipt, 'valueDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := GetJSONStringValue(LReceipt, 'clientControlNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := GetJSONStringValue(LReceipt, 'maskedCardNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := GetJSONStringValue(LReceipt, 'authorizationCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := GetJSONStringValue(LReceipt, 'retrievalReferenceNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := CorrigirTexto(GetJSONStringValue(LReceipt, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaImpostosROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'discountAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'netAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeNetAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorCompraComSaque := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReversaoIntercambio := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LReceipt, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    if not Assigned(lstEstabel) then
      lstEstabel := TStringList.Create;

    if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
       (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
      lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
  end;
end;

procedure TFiservBinPgto.ProcessarInstallmentFinanceSummary(LInstallmentFinance: TJSONArray);
var
  I: Integer;
  LInstallmentItem: TJSONObject;
  LReceipts: TJSONArray;
  J: Integer;
begin
  for I := 0 to LInstallmentFinance.Count - 1 do
  begin
    LInstallmentItem := LInstallmentFinance.Items[I] as TJSONObject;

    // Processa os receipts (registros 025)
    if LInstallmentItem.TryGetValue<TJSONArray>('installmentFinanceReceipt', LReceipts) then
    begin
      for J := 0 to LReceipts.Count - 1 do
      begin
        ProcessarInstallmentFinanceReceipt(LReceipts.Items[J] as TJSONObject);
      end;
    end;
  end;
end;

procedure TFiservBinPgto.ProcessarInstallmentFinanceReceipt(LReceipt: TJSONObject);
var
  LTipoRegistro: string;
begin
  LTipoRegistro := GetJSONStringValue(LReceipt, 'recordType');

  // Processa registro 025 - Detalhamento Ordem de Pagamento de Crédito Parcelado
  if (LTipoRegistro = '025') then
  begin
    SetLength(FRegistroFiservBinMovimentoFinanceiro, Length(FRegistroFiservBinMovimentoFinanceiro) + 1);
    Inc(FIncAddMovimentoFinanceiro);

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := GetJSONStringValue(LReceipt, 'recordType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := GetJSONStringValue(LReceipt, 'cardSchemeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamento := CorrigeCampoData(GetJSONStringValue(LReceipt, 'paymentDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := GetJSONStringValue(LReceipt, 'clientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].EstabelecimentoCentralizador := GetJSONStringValue(LReceipt, 'centralizingClientCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].InstrucaoPagamento := GetJSONStringValue(LReceipt, 'paymentInstructionNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroResumoVenda := GetJSONStringValue(LReceipt, 'salesSummaryNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].QuantidadeROC := GetJSONStringValue(LReceipt, 'quantityOfSales');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := GetJSONStringValue(LReceipt, 'paymentTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := GetJSONStringValue(LReceipt, 'transactionTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoDescricaoTransacao := GetJSONStringValue(LReceipt, 'transactionDescriptionCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := GetJSONStringValue(LReceipt, 'transactionDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ResumoPagamento := GetJSONStringValue(LReceipt, 'financeSummaryNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CNPJBeneficiarioLockin := GetJSONStringValue(LReceipt, 'beneficiaryInstituteLockin');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoLockin := GetJSONStringValue(LReceipt, 'lockinType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoContaPagamento := GetJSONStringValue(LReceipt, 'accountTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].StatusPagamento := GetJSONStringValue(LReceipt, 'paymentStatus');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DescricaoTransacaoPagamento := GetJSONStringValue(LReceipt, 'paymentTransactionTypeDescription');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ChargebackComprovanteReferencia := GetJSONStringValue(LReceipt, 'chargeBack');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteVenda := GetJSONStringValue(LReceipt, 'salesReceiptNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaoVenda := GetJSONStringValue(LReceipt, 'salesTransactionType');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := CorrigeCampoData(GetJSONStringValue(LReceipt, 'transactionDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].HorarioCriacao := GetJSONStringValue(LReceipt, 'transactionTime');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := CorrigeNumeroParcela(GetJSONStringValue(LReceipt, 'installmentNumber'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := GetJSONStringValue(LReceipt, 'totalInstallments');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroContaEC := GetJSONStringValue(LReceipt, 'accountNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataGeracaoSOC := CorrigeCampoData(GetJSONStringValue(LReceipt, 'recordDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataPagamentoSOC := CorrigeCampoData(GetJSONStringValue(LReceipt, 'valueDate'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroControleCliente := GetJSONStringValue(LReceipt, 'clientControlNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroCartao := GetJSONStringValue(LReceipt, 'maskedCardNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := GetJSONStringValue(LReceipt, 'authorizationCode');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := GetJSONStringValue(LReceipt, 'retrievalReferenceNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := CorrigirTexto(GetJSONStringValue(LReceipt, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaImpostosROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'discountAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'netAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeNetAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorCompraComSaque := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReversaoIntercambio := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LReceipt, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    if FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    if not Assigned(lstEstabel) then
      lstEstabel := TStringList.Create;

    if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
       (lstEstabel.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
      lstEstabel.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
  end;
end;

function TFiservBinPgto.ValidarJsonMovimentacaoFinanceira(const AJson: string): Boolean;
var
  LJsonObj: TJSONObject;
  LFileHeader: TJSONObject;
  LAcquiringName, LFileTypeDesc: string;
begin
  Result := False;

  try
    if AJson.Trim = '' then
      Exit;

    LJsonObj := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
    if not Assigned(LJsonObj) then
      Exit;

    try
      if not LJsonObj.TryGetValue('fileHeader', LFileHeader) then
        Exit;

      if Assigned(LFileHeader.Get('acquiringName')) then
        LAcquiringName := LFileHeader.GetValue<string>('acquiringName')
      else
        Exit;

      if LAcquiringName <> 'Bin' then
        Exit;

      if Assigned(LFileHeader.Get('fileTypeDescription')) then
        LFileTypeDesc := LFileHeader.GetValue<string>('fileTypeDescription')
      else
        Exit;

      Result := LFileTypeDesc = 'Movimento Financeiro';

    finally
      LJsonObj.Free;
    end;

  except
    on E: Exception do
      Result := False;
  end;

end;

end.
