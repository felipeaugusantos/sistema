{***************************************}
{* Importação de arquivos da FISERVBIN *}
{************************************TA*}
unit untFiservBinPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, ComCtrls,
     Forms, System.Generics.Collections, Math,

     cxProgressBar, Uni, Json,

     untIFiservBinIntegracaoLibCartoes, untTFiservBinFuncoes, untFiservBinTipos;

Type
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

    function GetJSONStringValue(AJSONObject: TJSONObject; const APropertyName: string; const ADefault: string = ''): string;

  Public
    constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

  End;

Var
  strNomArq,
  strArqAnt: String;
  intParAju: Integer;
  FImportouPagamentos: Boolean;

  FRegistroFiservBinMovimentoFinanceiro : TArrRegistroFiservBinMovimentoFinanceiro;

implementation

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

  If TFiservBinFuncoes.fEmptyStr(ADate) Then
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

    If Not TFiservBinFuncoes.fEmptyStr(AValor) Then
      Result := (StrToFloat(AValor)/100).ToString;

    Result  := StringReplace(Result,',','.',[rfReplaceAll]);
  Except
    Result := '';
  End;
end;

function TFiservBinPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not TFiservBinFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TFiservBinPgto.CorrigeNumeroParcela(AParcela: String): String;
begin
  If TFiservBinFuncoes.fEmptyStr(AParcela) Then
    AParcela := '1'
  Else If AParcela.Equals(TFiservBinFuncoes.fStrZero('0',AParcela.Length)) Then
    AParcela := '1'
  Else If Trim(AParcela).Equals('-') Then
    AParcela := '1';

  Result := LeftStr(AParcela,2);
  Result := TFiservBinFuncoes.fStrZero(Result.Replace('/',''),2);
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

destructor TFiservBinPgto.Destroy;
begin
  If Assigned(Colunas) Then
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
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante :=TFiservBinFuncoes.CorrigirTexto(Colunas.Strings[17]);

  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := CorrigeCampoNumerico(Colunas.Strings[18]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[19]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[20]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := TFiservBinFuncoes.CorrigirTexto(Colunas.Strings[21]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := Colunas.Strings[22];
  // Colunas.Strings[23] Número do Terminal
  // Colunas.Strings[24] Acquirer Reference Number
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := Colunas.Strings[25];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;


  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';


  If LeftStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].TipoComprovante, 1).Equals('D') Then
  Begin
   FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda);
   FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC);
   FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC);
  End;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
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
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(Colunas.Strings[31]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
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
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(Colunas.Strings[33]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[38]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[39];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
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
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(Colunas.Strings[30]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[31]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := strNomArq;

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
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

      rst := TFiservBinFuncoes.fStrToFloat(rst) / StrtoFloat('1' + strZeros);
    End;

    Result := rst;
  End;

begin
  If ValidarJsonMovimentacaoFinanceira(strString) Then
  Begin
    pProcessarJson(strString);
    Exit;
  End;

  lstCampos := Nil;
  Try
    lstCampos := TStringList.Create;
    lstCampos.Delimiter     := ',';
    lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    Colunas.Delimiter := RetornaDelimitador(strString);
    Colunas.StrictDelimiter := True;
    Colunas.DelimitedText := TFiservBinFuncoes.fConverteParaAcento(strString);
    If TFiservBinFuncoes.fEmptyStr(Colunas.Text) Then
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
  Finally
    If Assigned(lstCampos) Then
      FreeAndNil(lstCampos);
  End;
end;

procedure TFiservBinPgto.pGravarRegistros(pgbProg: TcxProgressBar);
Var
  LMovimentoFinanceiro : TUniQuery;
  LContador: Integer;
begin
  LMovimentoFinanceiro := Nil;
  Try
    pgbProg.Position := 0;

    If Length(FRegistroFiservBinMovimentoFinanceiro) > 0 Then
    Begin
      LMovimentoFinanceiro :=VS_FuncoesExternas.fICriaQuery;

      LMovimentoFinanceiro.Close;
      LMovimentoFinanceiro.SQL.Clear;
      LMovimentoFinanceiro.SQL.Text := TFiservBinFuncoes.RetornaSQLReplace('BIN_FVPGTO',['BIN_CONCIL']);

      pgbProg.Properties.Max := Length(FRegistroFiservBinMovimentoFinanceiro) - 1;

      For LContador := 0 To Length(FRegistroFiservBinMovimentoFinanceiro) - 1 Do
      Begin
        LMovimentoFinanceiro.Close;

        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPREG', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoRegistro));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NOMBAN', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].BandeiraCartao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_DTAPAG', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_CODEST', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].Estabelecimento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_ESTCEN', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].EstabelecimentoCentralizador));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_INSPAG', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].InstrucaoPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NUM_RV', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroResumoVenda));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_QTDROC', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].QuantidadeROC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPPAG', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPTRA', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoTransacao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_CODDES', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].CodigoDescricaoTransacao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_DESTRA', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].Descricaotransacao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_RESPAG', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ResumoPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_CNPJLC', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].CNPJBeneficiarioLockin));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPLOC', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoLockin));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPCTA', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoContaPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_STATUS', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].StatusPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_DESPAG', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DescricaoTransacaoPagamento));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_COMREF', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ChargebackComprovanteReferencia));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_REFVEN', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroComprovanteVenda));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPVEN', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoTransacaoVenda));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_DTATRA', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataTransacao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_HORTRA', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].HorarioCriacao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NUMPAR', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroParcela));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TOTPAR', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TotalParcelas));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NUMCTA', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroContaEC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_GERSOC', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataGeracaoSOC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_PAGSOC', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].DataPagamentoSOC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_CONCLI', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroControleCliente));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NUMCAR', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroCartao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_CODAUT', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].CodigoAutorizacao));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NUMNSU', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroComprovanteNSU));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TIPCON', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].TipoComprovante));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_VALBRU', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorBrutoROC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_VALTAX', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorTaxaImpostosROC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_VALLIQ', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorLiquidoROC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_TAXANT', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoROC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_LIQANT', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorLiquidoAntecipacaoROC));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_VALSAQ', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorCompraComSaque));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_VALINT', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ReversaoIntercambio));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_BRUVEN', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].ValorBrutoVenda));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_SEQARQ', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NumeroRegistroArquivo));
        TFiservBinFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'BIN_NOMARQ', CorrigeDadosBanco(FRegistroFiservBinMovimentoFinanceiro[LContador].NomeArquivo));
        LMovimentoFinanceiro.ExecSQL;

        FImportouPagamentos := True;

        TFiservBinFuncoes.pStepStatusGravacao(pgbProg);
      End;

      TFiservBinFuncoes.GravarEstabelecimentos;
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
  begin
    if LValue is TJSONString then
      Result := TEncoding.UTF8.GetString(TEncoding.ANSI.GetBytes(TJsonString(LValue).Value))
    else
      Result := LValue.Value;
  end;
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
  finally
    if Assigned(LJsonObj) then
      FreeAndNil(LJsonObj);
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
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(GetJSONStringValue(LReceipt, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaImpostosROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'discountAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'netAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeNetAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorCompraComSaque := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'cashBackAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReversaoIntercambio := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'reverseInterchange'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LReceipt, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
       (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
      VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
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
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(GetJSONStringValue(LAdjustment, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := CorrigeCampoNumerico(GetJSONStringValue(LAdjustment, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LAdjustment, 'adjustmentAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LAdjustment, 'grossAdjustmentAmount'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Descricaotransacao := TFiservBinFuncoes.CorrigirTexto(GetJSONStringValue(LAdjustment, 'adjustmentDescription'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoPagamento := GetJSONStringValue(LAdjustment, 'solicitationTypeDescription');

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LAdjustment, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;


    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU :=  GetJSONStringValue(LAdjustment, 'adjustmentNumber');
    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao :=  GetJSONStringValue(LAdjustment, 'authorizationCode');
    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela) Or
       FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela.Equals('0') then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela := '01';

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas) Or
       FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas.Equals('0') then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TotalParcelas := '01';

    if LeftStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante, 1).Equals('D') then
    begin
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoVenda);
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC);
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := ConverterParaNegativo(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC);
    end;
  end;

  If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

  if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
     (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
    VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
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
    If FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU.IsEmpty Then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := GetJSONStringValue(LReceipt, 'salesReceiptNumber');

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(GetJSONStringValue(LReceipt, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaImpostosROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'discountAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'netAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeNetAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorCompraComSaque := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReversaoIntercambio := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LReceipt, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
       (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
      VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
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
    If FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU.IsEmpty Then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := GetJSONStringValue(LReceipt, 'salesReceiptNumber');

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoComprovante := TFiservBinFuncoes.CorrigirTexto(GetJSONStringValue(LReceipt, 'receiptTypeDescription'));

    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'grossAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaImpostosROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'discountAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'netAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(GetJSONStringValue(LReceipt, 'feeModeNetAmount'));
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorCompraComSaque := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReversaoIntercambio := '';
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRegistroArquivo := GetJSONStringValue(LReceipt, 'recordNumber');
    FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NomeArquivo := strNomArq;

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroComprovanteNSU := '0';

    if TFiservBinFuncoes.FEmptyStr(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao) then
      FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoAutorizacao := '0';

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    if (FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') and
       (VS_ListaEstabelecimentos.IndexOf(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) then
      VS_ListaEstabelecimentos.Add(FRegistroFiservBinMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
  end;
end;

function TFiservBinPgto.ValidarJsonMovimentacaoFinanceira(const AJson: string): Boolean;
var
  LJsonObj: TJSONObject;
  LFileHeader: TJSONObject;
  LAcquiringName, LFileTypeDesc: string;
begin
  Result := False;

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
    FreeAndNil(LJsonObj);
  end;
end;

end.
