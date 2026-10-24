unit untSicrediPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, ComCtrls,
     Dialogs, Forms, System.Generics.Collections, Math,

     cxProgressBar, Uni,

     untISicrediIntegracaoLibCartoes, untTSicrediFuncoes, untSicrediTipos;

Type
  TSicrediPgto = Class(TInterfacedObject, ICartoes)
  Private
    Colunas:TStringList;
    FCampos: TStringList;

    FMeses: TStringList;

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
    procedure pGravarRegistros(pgbProg: TcxProgressBar);
    property Campos: String write SetCampos;
  End;

Var
  NomeArquivo: String;
  DataArquivo: String;
  FArquivoFiserv,
  FArquivoRelatorioPagamento: Boolean;
  FImportouPagamentos: Boolean;

  FIncAddMovimentoFinanceiro:Integer;

  FRegistroSicrediMovimentoFinanceiro : TArrRegistroSicrediMovimentoFinanceiro;

implementation

{ TSicrediPgto }

function TSicrediPgto.CorrigeCampoData(ADate: String): String;
begin
  Result := '';

  If TSicrediFuncoes.fEmptyStr(ADate) Then
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
    Raise Exception.Create('Não encontramos a coluna [' + AArrCampos[0] + '] no arquivo '+ NomeArquivo +#13#10 +
                           'Verifique se a descrição da coluna está escrita de forma idêntica ao esperado.');
  End;
end;

function TSicrediPgto.CorrigeCampoNumerico(AValor: String): String;
var
  LValor: Double;
  LTemSeparadorDecimal: Boolean;
  LValorLimpo,
  LDecimais,
  LDecimaisLimpo:String;
  LPosDecimal: Integer;
  I: Integer;
begin
  Result := '';

  try
    if TSicrediFuncoes.fEmptyStr(AValor) then
      Exit;

    LValorLimpo := '';
    for I := 1 to Length(AValor) do
    begin
      if CharInSet(AValor[i], ['0'..'9', ',', '.', '-']) then
        LValorLimpo := LValorLimpo + AValor[I];
    end;

    if TSicrediFuncoes.fEmptyStr(LValorLimpo) then
      Exit;

    // Verifica se já tem separador decimal
    LDecimais := RightStr(LValorLimpo,3);

    LPosDecimal := Pos(',', LDecimais);
    If LPosDecimal <= 0 Then
      LPosDecimal := Pos('.', LDecimais);

    LTemSeparadorDecimal := LPosDecimal > 0;

    If LTemSeparadorDecimal Then
    Begin
      LDecimais :=  Copy(LDecimais, LPosDecimal + 1, Length(LDecimais));

      LDecimaisLimpo := '';
      for I := 1 to Length(LDecimais) do
      begin
        if CharInSet(LDecimais[i], ['0'..'9']) then
          LDecimaisLimpo := LDecimaisLimpo + LDecimais[I];
      end;

      If Length(LDecimaisLimpo) = 1 Then
        LValorLimpo := LValorLimpo + '0';

    End;

    LValorLimpo := StringReplace(LValorLimpo, '.', '', [rfReplaceAll]);
    LValorLimpo := StringReplace(LValorLimpo, ',', '', [rfReplaceAll]);

    LValor := StrToFloat(LValorLimpo);

    if LTemSeparadorDecimal then
      LValor := (LValor / 100);

    Result := FormatFloat('0.00', LValor);
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  except
    Result := '';
  end;
end;

function TSicrediPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not TSicrediFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TSicrediPgto.CorrigeNumeroParcela(AParcela: String): String;
  Var
    LIndiceMes: Integer;
begin
  If TSicrediFuncoes.fEmptyStr(AParcela) Then
    AParcela := '1'
  Else If AParcela.Equals(TSicrediFuncoes.fStrZero('0',AParcela.Length)) Then
    AParcela := '1'
  Else If Trim(AParcela).Equals('-') Then
    AParcela := '1';

  if (Pos('/', AParcela) > 0) Or (Pos('-', AParcela) > 0) then
    Result := LeftStr(AParcela,2)
  else if (AParcela.Length = 3) Then
    Result := RightStr(AParcela, 2)
  Else
    Result := LeftStr(AParcela,2);

  Result := TSicrediFuncoes.fStrZero(Result.Replace('/',''),2);

  If Result.Equals('00') Then
    Result := '01';

  If TSicrediFuncoes.fRetSomenteNumeros(Result).IsEmpty Then
  Begin
    If Length(AParcela.Split(['/'])) <> 2 Then
      Exit;

    LIndiceMes := FMeses.IndexOf(AParcela.Split(['/'])[0].ToUpperInvariant);
    If LIndiceMes > -1 Then
      Result := TSicrediFuncoes.fStrZero((LIndiceMes + 1).ToString, 2);
  End;
end;

function TSicrediPgto.CorrigeQuantidadeParcela(AValorBrutoVenda,
  AValorBrutoParcela, AParcela: String): String;
  Var
    LPegaTotalDaColuna: Boolean;

    LIndiceMes: Integer;
begin
  If Length(AParcela.Split(['/'])) = 2 Then
  Begin
    LIndiceMes := FMeses.IndexOf(AParcela.Split(['/'])[1].ToUpperInvariant);
    If LIndiceMes > -1 Then
      Exit(TSicrediFuncoes.fStrZero((LIndiceMes + 1).ToString, 2));
  End;

  AValorBrutoVenda := AValorBrutoVenda.Replace('.',',');
  AValorBrutoParcela := AValorBrutoParcela.Replace('.',',');

  LPegaTotalDaColuna := AParcela.Contains('Única');
  If Not LPegaTotalDaColuna Then
    LPegaTotalDaColuna := TSicrediFuncoes.fStrToFloat(AValorBrutoParcela) < 0;

  If LPegaTotalDaColuna Then
  Begin
    Result := RightStr(Trim(AParcela),2);
    Result := TSicrediFuncoes.fStrZero(Result.Replace('/',''),2);
    Exit;
  End;

  Result := FloatToStr(Round((StrToFloat(AValorBrutoVenda) / StrToFloat(AValorBrutoParcela))));
  Result := RightStr(TSicrediFuncoes.fStrZero(Result,2), 2);
end;

constructor TSicrediPgto.Create;
Begin
  FIncAddMovimentoFinanceiro := 0;
  Colunas := TStringList.Create;
  FCampos := TStringList.Create;

  FMeses := TStringList.Create;
  FMeses.Add('JAN');
  FMeses.Add('FEV');
  FMeses.Add('MAR');
  FMeses.Add('ABR');
  FMeses.Add('MAI');
  FMeses.Add('JUN');
  FMeses.Add('JUL');
  FMeses.Add('AGO');
  FMeses.Add('SET');
  FMeses.Add('OUT');
  FMeses.Add('NOV');
  FMeses.Add('DEZ');
End;

destructor TSicrediPgto.Destroy;
begin
  If Assigned(Colunas) Then
    FreeAndNil(Colunas);

  If Assigned(FCampos) Then
    FreeAndNil(FCampos);

  If Assigned(FMeses) Then
    FreeAndNil(FMeses);
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
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := NomeArquivo;

  If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

 If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);

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
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := NomeArquivo;

  If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
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
  FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo := NomeArquivo;

  If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

  If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);
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
  If TSicrediFuncoes.fEmptyStr(Colunas.Strings[0]) Then
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

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NomeArquivo :=NomeArquivo;

    If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU) Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := '0';

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU := TSicrediFuncoes.fStrZero(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].NumeroComprovanteNSU, 9);

    If TSicrediFuncoes.FEmptyStr(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao) Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := '0';

    If FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao.Contains('Ajuste ') Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro := '021';

    If FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].Descricaotransacao.Contains(' Ajustes') Then
      FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].TipoRegistro := '021';

    FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao := TSicrediFuncoes.fStrZero(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1].CodigoAutorizacao, 6);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If (FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1 ].Estabelecimento) < 0) Then
      VS_ListaEstabelecimentos.Add(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro -1].Estabelecimento);

    If Pos('Única',Colunas.Strings[IndexCampo(['Parcelas'])]) > 0 Then
      DesmembrarParcelas(FRegistroSicrediMovimentoFinanceiro[FIncAddMovimentoFinanceiro-1]);

  Except
    Raise;
  End;
end;

procedure TSicrediPgto.pAdicionaLinha(strString: String);
begin
  Colunas.Delimiter := RetornaDelimitador(strString);

  Colunas.StrictDelimiter := True;
  Colunas.DelimitedText := TSicrediFuncoes.fConverteParaAcento(strString);

  If TSicrediFuncoes.fEmptyStr(Colunas.Text) Then
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

procedure TSicrediPgto.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LMovimentoFinanceiro : TUniQuery;
    LContador : integer;
begin
  LMovimentoFinanceiro :=Nil;
  Try

    pgbProg.Position := 0;

    If Length(FRegistroSicrediMovimentoFinanceiro)  > 0 Then
    Begin
      LMovimentoFinanceiro :=  VS_FuncoesExternas.fICriaQuery;

      LMovimentoFinanceiro.Close;
      LMovimentoFinanceiro.SQL.Clear;
      LMovimentoFinanceiro.SQL.Text := TSicrediFuncoes.RetornaSQLReplace('SIC_SIPGTO',['SIC_CONCIL']);

      pgbProg.Properties.Max :=  Length(FRegistroSicrediMovimentoFinanceiro) - 1;

      For LContador := 0 To Length(FRegistroSicrediMovimentoFinanceiro) - 1 Do
      Begin
        LMovimentoFinanceiro.Close;

        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPREG', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoRegistro));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NOMBAN', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].BandeiraCartao));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_DTAPAG', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_CODEST', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].Estabelecimento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_ESTCEN', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].EstabelecimentoCentralizador));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_INSPAG', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].InstrucaoPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NUM_RV', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroResumoVenda));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_QTDROC', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].QuantidadeROC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPPAG', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPTRA', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoTransação));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_CODDES', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].CodigoDescricaoTransacao));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_DESTRA', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].Descricaotransacao));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_RESPAG', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ResumoPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_CNPJLC', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].CNPJBeneficiarioLockin));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPLOC', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoLockin));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPCTA', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoContaPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_STATUS', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].StatusPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_DESPAG', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DescricaoTransacaoPagamento));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_COMREF', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ChargebackComprovanteReferencia));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_REFVEN', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroComprovanteVenda));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPVEN', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoTransacaoVenda));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_DTATRA', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataTransacao));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_HORTRA', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].HorarioCriacao));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NUMPAR', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroParcela));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TOTPAR', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TotalParcelas));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NUMCTA', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroContaEC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_GERSOC', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataGeracaoSOC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_PAGSOC', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].DataPagamentoSOC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_CONCLI', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroControleCliente));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NUMCAR', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroCartao,''));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_CODAUT', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].CodigoAutorizacao));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NUMNSU', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroComprovanteNSU));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TIPCON', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].TipoComprovante));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_VALBRU', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorBrutoROC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_VALTAX', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorTaxaImpostosROC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_VALLIQ', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorLiquidoROC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_TAXANT', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoROC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_LIQANT', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorLiquidoAntecipacaoROC));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_VALSAQ', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorCompraComSaque));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_VALINT', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ReversaoIntercambio));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_BRUVEN', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].ValorBrutoVenda));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_SEQARQ', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NumeroRegistroArquivo));
        TSicrediFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'SIC_NOMARQ', CorrigeDadosBanco(FRegistroSicrediMovimentoFinanceiro[LContador].NomeArquivo));
        LMovimentoFinanceiro.ExecSQL;

        FImportouPagamentos := True;

        TSicrediFuncoes.pStepStatusGravacao(pgbProg);
      End;

      TSicrediFuncoes.GravarEstabelecimentos;
    End;
  Finally
    TSicrediFuncoes.FreeAndNilDatasets(LMovimentoFinanceiro);
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
  Result := AnsiUpperCase(TSicrediFuncoes.fConverteParaAcento(ALinha));
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
