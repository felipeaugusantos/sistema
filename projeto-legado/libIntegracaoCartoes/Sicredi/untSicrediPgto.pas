{***************************************}
{* Importação de arquivos da Sicredi *}
{************************************MT*}
unit untSicrediPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms, untFuncoesSimples,
     Uni,Math;


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
    TipoTransação,
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

  TArrRegistroSicrediMovimentoFinanceiro  = Array Of TRegistroMovimentoFinanceiro;

  TSicrediPgto = Class(TInterfacedObject, ICartoes)
  Private
    Colunas:TStringList;
    FIncAddMovimentoFinanceiro:Integer;
    FCampos: TStringList;

    function RetornaDelimitador(AText: String): Char;
    procedure ImportaCreditoParcelado;
    procedure ImportaRelatorioPagamentoSicredi;
    procedure ImportaCredito;
    procedure ImportaDebitos;
    procedure DesmembrarParcelas(FRegistroAtual: TRegistroMovimentoFinanceiro);
    function ConverteStringParaCurr(const Value: string): Currency;
    function CorrigeCampoData(ADate: String): String;
    function CorrigeCampoNumerico(AValor: String): String;
    function CorrigeDadosBanco(AValor: Variant): Variant; Overload;
    function CorrigeDadosBanco(AValor: Variant; ADefault: Variant): Variant; Overload;
    function CorrigeNumeroParcela(AParcela:String): String;
    function CorrigeQuantidadeParcela(AValorBrutoVenda,AValorBrutoParcela,AParcela: String): String;
    function IndexCampo(AArrCampos: Array Of String): Integer;
    procedure SetCampos(const Value: String);
    function RetornaLinhaFormatada(ALinha: String): String;
  Public
    constructor Create;
    Destructor Destroy; Override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);
    property Campos: String write SetCampos;
  End;

Var
  FNomeArquivoImportado: String;
  FArquivoFiserv: Boolean;
  FArquivoRelatorioPagamento: Boolean;

implementation

uses untFuncoes, untIDataSet, untSicredi;

{ TSicrediPgto }

function TSicrediPgto.CorrigeCampoData(ADate: String): String;
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

function TSicrediPgto.IndexCampo(AArrCampos: Array Of String): Integer;
Var
  LContador: Integer;
begin
  Result := -1;

  For LContador := Low(AArrCampos) To High(AArrCampos) Do
  Begin
    Result := FCampos.IndexOf(AArrCampos[LContador]);

    If Result >= 0 Then
      Break;
  End;

  If Result = -1 Then
  Begin
    SetLength(FRegistroSicrediMovimentoFinanceiro,0);
    Raise Exception.Create('Não encontramos a coluna [' + AArrCampos[0] + '] no arquivo '+ FNomeArquivoImportado +#13#10 +
                           'Verifique se a descrição da coluna está escrita de forma idêntica ao esperado.');
  End;
end;

function TSicrediPgto.CorrigeCampoNumerico(AValor: String): String;
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

function TSicrediPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TSicrediPgto.CorrigeNumeroParcela(AParcela: String): String;
begin
  If fEmptyStr(AParcela) Then
    AParcela := '1'
  Else If AParcela.Equals(fStrZero('0',AParcela.Length)) Then
    AParcela := '1'
  Else If Trim(AParcela).Equals('-') Then
    AParcela := '1';

  if (Pos('/', AParcela) > 0) Or (Pos('-', AParcela) > 0) then
    Result := LeftStr(AParcela,2)
  else if (AParcela.Length = 3) Then
    Result := RightStr(AParcela, 2)
  Else
    Result := LeftStr(AParcela,2);

  Result := fStrZero(Result.Replace('/',''),2);

  If Result.Equals('00') Then
    Result := '01';
end;

function TSicrediPgto.CorrigeQuantidadeParcela(AValorBrutoVenda,
  AValorBrutoParcela, AParcela: String): String;
  Var
    LPegaTotalDaColuna: Boolean;
begin
  AValorBrutoVenda := AValorBrutoVenda.Replace('.',',');
  AValorBrutoParcela := AValorBrutoParcela.Replace('.',',');

  LPegaTotalDaColuna := AParcela.Contains('Única');
  If Not LPegaTotalDaColuna Then
    LPegaTotalDaColuna := fStrToFloat(AValorBrutoParcela) < 0;

  If LPegaTotalDaColuna Then
  Begin
    Result := RightStr(Trim(AParcela),2);
    Result := fStrZero(Result.Replace('/',''),2);
    Exit;
  End;

  Result := FloatToStr(Round((StrToFloat(AValorBrutoVenda) / StrToFloat(AValorBrutoParcela))));
  Result := RightStr(fStrZero(Result,2), 2);
end;

constructor TSicrediPgto.Create;
Begin
  FIncAddMovimentoFinanceiro := 0;
  Colunas := TStringList.Create;
  FCampos := TStringList.Create;
End;

destructor TSicrediPgto.Destroy;
begin
  FreeAndNil(Colunas);
  FreeAndNil(FCampos);
  inherited;
end;


procedure TSicrediPgto.ImportaCredito;
begin
  SetLength(FRegistroSicrediMovimentoFinanceiro, Length(FRegistroSicrediMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransação := Colunas.Strings[09];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := Colunas.Strings[20];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[21]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[22];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[23];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[24]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[25]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[26];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[27];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[28];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[29];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := Colunas.Strings[30];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[31]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[36];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := FNomeArquivoImportado;

  If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSicrediPgto.ImportaCreditoParcelado;
begin
  SetLength(FRegistroSicrediMovimentoFinanceiro, Length(FRegistroSicrediMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransação := Colunas.Strings[9];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := Colunas.Strings[20];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[21]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[22];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := CorrigeNumeroParcela(Colunas.Strings[23]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := Colunas.Strings[24];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[25];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[26]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[27]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[28];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[29];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[30];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[31];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := Colunas.Strings[32];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[37]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := '';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := '';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[38];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := FNomeArquivoImportado;

  If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;



procedure TSicrediPgto.ImportaDebitos;
begin
  SetLength(FRegistroSicrediMovimentoFinanceiro, Length(FRegistroSicrediMovimentoFinanceiro)+1);
  Inc(FIncAddMovimentoFinanceiro);

  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro  := Colunas.Strings[0];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao := Colunas.Strings[1];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento := CorrigeCampoData(Colunas.Strings[2]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento := Colunas.Strings[3];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[4];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].InstrucaoPagamento := Colunas.Strings[5];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda := Colunas.Strings[6];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].QuantidadeROC := Colunas.Strings[7];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento := Colunas.Strings[8];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransação := Colunas.Strings[9];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao := Colunas.Strings[10];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao := Colunas.Strings[11];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento := Colunas.Strings[12];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CNPJBeneficiarioLockin := Colunas.Strings[13];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoLockin := Colunas.Strings[14];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoContaPagamento := Colunas.Strings[15];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento := Colunas.Strings[16];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DescricaoTransacaoPagamento := Colunas.Strings[17];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ChargebackComprovanteReferencia := Colunas.Strings[18];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteVenda := Colunas.Strings[19];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransacaoVenda := '';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao := CorrigeCampoData(Colunas.Strings[20]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao := Colunas.Strings[21];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela := '01';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := '01';
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroContaEC := Colunas.Strings[22];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataGeracaoSOC := CorrigeCampoData(Colunas.Strings[23]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamentoSOC := CorrigeCampoData(Colunas.Strings[24]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroControleCliente := Colunas.Strings[25];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao := Colunas.Strings[26];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := Colunas.Strings[27];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := Colunas.Strings[28];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante := Colunas.Strings[29];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC := CorrigeCampoNumerico(Colunas.Strings[30]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC := CorrigeCampoNumerico(Colunas.Strings[31]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC := CorrigeCampoNumerico(Colunas.Strings[32]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[33]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoAntecipacaoROC := CorrigeCampoNumerico(Colunas.Strings[34]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorCompraComSaque  := CorrigeCampoNumerico(Colunas.Strings[35]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ReversaoIntercambio  := CorrigeCampoNumerico(Colunas.Strings[36]);
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroRegistroArquivo := Colunas.Strings[37];
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := FNomeArquivoImportado;

  If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (lstEstabel.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    lstEstabel.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
end;

procedure TSicrediPgto.DesmembrarParcelas(FRegistroAtual: TRegistroMovimentoFinanceiro);
var
  LQuantidadeParcelas: Integer;
  LValorBrutoVenda, LValorBrutoROC, LValorTaxaImpostosROC, LValorLiquidoROC: Currency;
  LValorParcelaBrutoVenda, LValorParcelaBrutoROC, LValorParcelaTaxaImpostosROC, LValorParcelaLiquidoROC: Currency;
  LResíduoBrutoVenda, LResíduoBrutoROC, LResíduoTaxaImpostosROC, LResíduoLiquidoROC: Currency;
  I: Integer;
begin
  LQuantidadeParcelas := StrToInt(FRegistroAtual.TotalParcelas); // Número de parcelas

  // Convertendo os valores de string para Currency
  LValorBrutoVenda := ConverteStringParaCurr(FRegistroAtual.ValorBrutoVenda);
  LValorBrutoROC := ConverteStringParaCurr(FRegistroAtual.ValorBrutoROC);
  LValorTaxaImpostosROC := ConverteStringParaCurr(FRegistroAtual.ValorTaxaImpostosROC);
  LValorLiquidoROC := ConverteStringParaCurr(FRegistroAtual.ValorLiquidoROC);

  SetLength(FRegistroSicrediMovimentoFinanceiro, Length(FRegistroSicrediMovimentoFinanceiro) + (LQuantidadeParcelas - 1));

  // Calcula os valores de cada parcela
  LValorParcelaBrutoVenda := RoundTo(LValorBrutoVenda / LQuantidadeParcelas,-2);
  LValorParcelaBrutoROC := RoundTo(LValorBrutoROC / LQuantidadeParcelas,-2);
  LValorParcelaTaxaImpostosROC := RoundTo(LValorTaxaImpostosROC / LQuantidadeParcelas,-2);
  LValorParcelaLiquidoROC := RoundTo(LValorLiquidoROC / LQuantidadeParcelas,-2);

  // Calcula resíduos para a última parcela
  LResíduoBrutoVenda := LValorBrutoVenda - (LValorParcelaBrutoVenda * LQuantidadeParcelas);
  LResíduoBrutoROC := LValorBrutoROC - (LValorParcelaBrutoROC * LQuantidadeParcelas);
  LResíduoTaxaImpostosROC := LValorTaxaImpostosROC - (LValorParcelaTaxaImpostosROC * LQuantidadeParcelas);
  LResíduoLiquidoROC := LValorLiquidoROC - (LValorParcelaLiquidoROC * LQuantidadeParcelas);
  for I := 0 to LQuantidadeParcelas - 1 do
  begin
    FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)] := FRegistroAtual; // Copiar o registro atual
    FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].NumeroParcela := IntToStr(I + 1); // Atualizar número da parcela

    // Distribuir os valores para as parcelas
    FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorBrutoVenda := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaBrutoVenda));
    FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorBrutoROC := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaBrutoROC));
    FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorTaxaImpostosROC := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaTaxaImpostosROC));
    FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorLiquidoROC := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaLiquidoROC));

    // Ajustar a última parcela para o resíduo
    if I = LQuantidadeParcelas - 1 then
    begin
      FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorBrutoVenda := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaBrutoVenda + LResíduoBrutoVenda));
      FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorBrutoROC := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaBrutoROC + LResíduoBrutoROC));
      FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorTaxaImpostosROC := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaTaxaImpostosROC + LResíduoTaxaImpostosROC));
      FRegistroSicrediMovimentoFinanceiro[(FIncAddMovimentoFinanceiro - 1)].ValorLiquidoROC := CorrigeCampoNumerico(FormatFloat('0.00', LValorParcelaLiquidoROC + LResíduoLiquidoROC));
    end;

    Inc(FIncAddMovimentoFinanceiro);
  end;

  FIncAddMovimentoFinanceiro := (FIncAddMovimentoFinanceiro - 1);
end;

function TSicrediPgto.ConverteStringParaCurr(const Value: string): Currency;
var
  ValueConvertido: string;
begin
  ValueConvertido := StringReplace(Value, '.', ',', [rfReplaceAll]);
  try
    Result := StrToCurr(ValueConvertido);
  except
    on E: EConvertError do
    begin
      ShowMessage('Erro na conversão de valor numérico: ' + E.Message);
      Result := 0; // Retorna 0 caso a conversão falhe
    end;
  end;
end;

procedure TSicrediPgto.ImportaRelatorioPagamentoSicredi;
begin
  If fEmptyStr(Colunas.Strings[0]) Then
    Exit;

  Try
    SetLength(FRegistroSicrediMovimentoFinanceiro, Length(FRegistroSicrediMovimentoFinanceiro)+1);
    Inc(FIncAddMovimentoFinanceiro);

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro                 := 'ARP';

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataPagamento                := CorrigeCampoData(Colunas.Strings[IndexCampo(['Data de pagamento'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ResumoPagamento              := Colunas.Strings[IndexCampo(['Código de pagamento'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoPagamento                := Colunas.Strings[IndexCampo(['Tipo de pagamento'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].DataTransacao                := CorrigeCampoData(Colunas.Strings[IndexCampo(['Data da venda'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].HorarioCriacao               := Colunas.Strings[IndexCampo(['Hora da venda'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Estabelecimento              := Colunas.Strings[IndexCampo(['Número do estabelecimento'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].EstabelecimentoCentralizador := Colunas.Strings[IndexCampo(['Número do estabelecimento'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao            := Colunas.Strings[IndexCampo(['Código de autorização'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU         := Colunas.Strings[IndexCampo(['Comprovante da venda'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroResumoVenda            := Colunas.Strings[IndexCampo(['Código do pedido'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoTransação                := Colunas.Strings[IndexCampo(['Canal'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoDescricaoTransacao     := Colunas.Strings[IndexCampo(['Número do terminal'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao           := Colunas.Strings[IndexCampo(['Produto'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroParcela                := CorrigeNumeroParcela(Colunas.Strings[IndexCampo(['Parcelas'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoComprovante              := Colunas.Strings[IndexCampo(['Tipo de Cartão'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].BandeiraCartao               := Colunas.Strings[IndexCampo(['Bandeira'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].StatusPagamento              := Colunas.Strings[IndexCampo(['Status da venda'])];
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoVenda              := CorrigeCampoNumerico(Colunas.Strings[IndexCampo(['Valor bruto da transação', 'Valor bruto'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC                := CorrigeCampoNumerico(Colunas.Strings[IndexCampo(['Valor bruto da parcela paga', 'Bruto da parcela'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorTaxaImpostosROC         := CorrigeCampoNumerico(Colunas.Strings[IndexCampo(['Valor da taxa (MDR)', 'Desconto MDR'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorLiquidoROC              := CorrigeCampoNumerico(Colunas.Strings[IndexCampo(['Valor líquido da parcela/transação', 'líquido da venda', 'Valor líquido'])]);
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroCartao                 := Colunas.Strings[IndexCampo(['Número do cartão'])];

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TotalParcelas := CorrigeQuantidadeParcela(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoVenda,
                                                                                                                FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].ValorBrutoROC,
                                                                                                                Colunas.Strings[IndexCampo(['Parcelas'])]);

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := FNomeArquivoImportado;

    If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := fStrZero(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU, 9);

    If FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

    If FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao.Contains('Ajuste ') Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro := '021';
    
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := fStrZero(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao, 6);

    If Not Assigned(lstEstabel) Then
      lstEstabel := TStringList.Create;

    If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
       (lstEstabel.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
      lstEstabel.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);

    If Pos('Única',Colunas.Strings[IndexCampo(['Parcelas'])]) > 0 Then
      DesmembrarParcelas(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1]);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TSicrediPgto.pAdicionaLinha(strString: String);
begin
  Colunas.Delimiter := RetornaDelimitador(strString);

  Colunas.StrictDelimiter := True;
  Colunas.DelimitedText := fConverteParaAcento(strString);

  If fEmptyStr(Colunas.Text) Then
    Exit;

  If FArquivoFiserv Then
  Begin
    // Registro 025 – Detalhamento Ordem de Pagamento de Crédito Parcelado
    If Colunas.Strings[0].Equals('025') Then
      ImportaCreditoParcelado

   // Detalhamento (Pagamento) – Registro 021 – Detalhamento Ordem de Pagamento de Débito
    Else If Colunas.Strings[0].Equals('021') Then
      ImportaDebitos

   // Detalhamento (Pagamento) – Registro 023 – Detalhamento Ordem de Pagamento de Crédito
    Else If Colunas.Strings[0].Equals('023') Then
      ImportaCredito;
  End

  Else If FArquivoRelatorioPagamento Then
  Begin
    ImportaRelatorioPagamentoSicredi;
  End;

end;

procedure TSicrediPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LMovimentoFinanceiro : TUniQuery;
    LContador: Integer;
begin
  Try

    Try
      pgbProg.Position := 0;

      If Length(FRegistroSicrediMovimentoFinanceiro) > 0 Then
      Begin
        LMovimentoFinanceiro := untFuncoes.CriarQueryDLL;

        LMovimentoFinanceiro.Close;
        LMovimentoFinanceiro.SQL.Clear;
        LMovimentoFinanceiro.SQL.Text := RetornaReplaceTabela('SIC_SIPGTO',['SIC_CONCIL']);


        pgbProg.Max := Length(FRegistroSicrediMovimentoFinanceiro) - 1;

        For LContador := 0 To Length(FRegistroSicrediMovimentoFinanceiro) - 1 Do
        Begin
          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.ParamByName('SIC_TIPREG').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoRegistro);
          LMovimentoFinanceiro.ParamByName('SIC_NOMBAN').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].BandeiraCartao);
          LMovimentoFinanceiro.ParamByName('SIC_DTAPAG').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_CODEST').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].Estabelecimento);
          LMovimentoFinanceiro.ParamByName('SIC_ESTCEN').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].EstabelecimentoCentralizador);
          LMovimentoFinanceiro.ParamByName('SIC_INSPAG').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].InstrucaoPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_NUM_RV').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroResumoVenda);
          LMovimentoFinanceiro.ParamByName('SIC_QTDROC').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].QuantidadeROC);
          LMovimentoFinanceiro.ParamByName('SIC_TIPPAG').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_TIPTRA').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoTransação);
          LMovimentoFinanceiro.ParamByName('SIC_CODDES').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].CodigoDescricaoTransacao);
          LMovimentoFinanceiro.ParamByName('SIC_DESTRA').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].Descricaotransacao);
          LMovimentoFinanceiro.ParamByName('SIC_RESPAG').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ResumoPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_CNPJLC').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].CNPJBeneficiarioLockin);
          LMovimentoFinanceiro.ParamByName('SIC_TIPLOC').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoLockin);
          LMovimentoFinanceiro.ParamByName('SIC_TIPCTA').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoContaPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_STATUS').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].StatusPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_DESPAG').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DescricaoTransacaoPagamento);
          LMovimentoFinanceiro.ParamByName('SIC_COMREF').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ChargebackComprovanteReferencia);
          LMovimentoFinanceiro.ParamByName('SIC_REFVEN').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroComprovanteVenda);
          LMovimentoFinanceiro.ParamByName('SIC_TIPVEN').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoTransacaoVenda);
          LMovimentoFinanceiro.ParamByName('SIC_DTATRA').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataTransacao);
          LMovimentoFinanceiro.ParamByName('SIC_HORTRA').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].HorarioCriacao);
          LMovimentoFinanceiro.ParamByName('SIC_NUMPAR').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroParcela);
          LMovimentoFinanceiro.ParamByName('SIC_TOTPAR').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TotalParcelas);
          LMovimentoFinanceiro.ParamByName('SIC_NUMCTA').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroContaEC);
          LMovimentoFinanceiro.ParamByName('SIC_GERSOC').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataGeracaoSOC);
          LMovimentoFinanceiro.ParamByName('SIC_PAGSOC').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataPagamentoSOC);
          LMovimentoFinanceiro.ParamByName('SIC_CONCLI').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroControleCliente);
          LMovimentoFinanceiro.ParamByName('SIC_NUMCAR').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroCartao,'');
          LMovimentoFinanceiro.ParamByName('SIC_CODAUT').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].CodigoAutorizacao);
          LMovimentoFinanceiro.ParamByName('SIC_NUMNSU').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroComprovanteNSU);
          LMovimentoFinanceiro.ParamByName('SIC_TIPCON').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoComprovante);
          LMovimentoFinanceiro.ParamByName('SIC_VALBRU').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorBrutoROC);
          LMovimentoFinanceiro.ParamByName('SIC_VALTAX').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorTaxaImpostosROC);
          LMovimentoFinanceiro.ParamByName('SIC_VALLIQ').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorLiquidoROC);
          LMovimentoFinanceiro.ParamByName('SIC_TAXANT').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoROC);
          LMovimentoFinanceiro.ParamByName('SIC_LIQANT').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorLiquidoAntecipacaoROC);
          LMovimentoFinanceiro.ParamByName('SIC_VALSAQ').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorCompraComSaque);
          LMovimentoFinanceiro.ParamByName('SIC_VALINT').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ReversaoIntercambio);
          LMovimentoFinanceiro.ParamByName('SIC_BRUVEN').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorBrutoVenda);
          LMovimentoFinanceiro.ParamByName('SIC_SEQARQ').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroRegistroArquivo);
          LMovimentoFinanceiro.ParamByName('SIC_NOMARQ').Value := CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NomeArquivo);
          LMovimentoFinanceiro.ExecSQL;
          pStep(pgbProg);
        End;

        SetLength(FRegistroSicrediMovimentoFinanceiro,0);

        Try
          LMovimentoFinanceiro.Close;
          LMovimentoFinanceiro.SQL.Text := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "SICREDI")';
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


function TSicrediPgto.RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

function TSicrediPgto.RetornaLinhaFormatada(ALinha: String): String;
begin
  Result := AnsiUpperCase(fConverteParaAcento(ALinha));
end;

procedure TSicrediPgto.SetCampos(const Value: String);
begin
  FCampos.Delimiter := RetornaDelimitador(Value);
  FCampos.StrictDelimiter := True;
  FCampos.DelimitedText := RetornaLinhaFormatada(Value);
end;

function TSicrediPgto.CorrigeDadosBanco(AValor, ADefault: Variant): Variant;
begin
  Result := CorrigeDadosBanco(AValor);
  If VarIsNull(Result) Then
    Result := ADefault;
end;

end.
