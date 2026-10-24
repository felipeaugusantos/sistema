unit untGranitoPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, ComCtrls,
     Forms, System.Generics.Collections, Math,

     cxProgressBar, Uni, Json,

     untIGranitoIntegracaoLibCartoes, untTGranitoFuncoes, untGranitoTipos;

Type
  TGranitoPgto = Class(TInterfacedObject, ICartoes)
  Private
    FIncAddMovimentoFinanceiro:Integer;

    strRegAnt: String;
    intPosicaoAtual: Integer;
    Colunas:TStringList;

    function CorrigeDadosBanco(AValor: Variant): Variant;
    function CorrigeParcela(ACodigo : string): integer;
    function fDescricaoBandeira(ACodigo : string): string;
    procedure pImportaTransacao(strString: String);

    function fGetDados(ATexto : String; intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
  Public
    constructor Create;
    Destructor Destroy; Override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);
  End;

Var
  strNomArq,
  FNomeEmpresa,
  FCNPJ,
  FHoraGeracao,
  FNumeroSequencial,
  FCodigoDestinatario,
  FDataDoArquivo ,
  strArqAnt: String;
  intParAju: Integer;
  FImportouPagamentos: Boolean;

  FRegistroGranitoMovimentoFinanceiro : TArrRegistroGranitoMovimentoFinanceiro;

implementation

{ TGranitoPgto }

function TGranitoPgto.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not TGranitoFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

function TGranitoPgto.CorrigeParcela(ACodigo: string): integer;
begin
  result := StrToInt(ACodigo);

    IF ACodigo.Equals('00') THEN
      RESULT := 1;
end;

constructor TGranitoPgto.Create;
Begin
  intPosicaoAtual := 0;
  FIncAddMovimentoFinanceiro := 0;
  strRegAnt := '';
  FIncAddMovimentoFinanceiro := 0;
  Colunas := TStringList.Create;
  FImportouPagamentos := False;
End;

destructor TGranitoPgto.Destroy;
begin
  TGranitoFuncoes.FreeAndNilStringLists(Colunas);
  inherited;
end;

function TGranitoPgto.fDescricaoBandeira(ACodigo: string): string;
begin
  case StrToIntDef(ACodigo, -1) of
    0:  Result := 'Não se aplica';
    1:  Result := 'VISA';
    2:  Result := 'MASTERCARD';
    3:  Result := 'VISA ELECTRON';
    4:  Result := 'MAESTRO';
    12: Result := 'ELO CRÉDITO';
    13: Result := 'ELO DÉBITO';
    16: Result := 'AMERICAN EXPRESS';
    19: Result := 'HIPERCARD';
    20: Result := 'HIPER';
    55: Result := 'TICKET RESTAURANTE';
    56: Result := 'TICKET ALIMENTAÇÃO';
    57: Result := 'TICKET CULTURA';
    58: Result := 'TICKET';
    65: Result := 'VR AUTO';
    66: Result := 'VR ALIMENTAÇÃO';
    67: Result := 'VR REFEIÇÃO';
    68: Result := 'VR CULTURA';
    84: Result := 'SODEXO ALIMENTAÇÃO';
    85: Result := 'SODEXO REFEIÇÃO';
    86: Result := 'SODEXO COMBUSTÍVEL';
    87: Result := 'SODEXO CULTURA';
    88: Result := 'SODEXO GIFT';
    89: Result := 'SODEXO PREMIUM';
  else
    Result := 'DESCONHECIDO';
  end;
end;

function TGranitoPgto.fGetDados(ATexto: String; intIni, intTam: Integer; blnFlt: Boolean): Variant;
Var
  Lrst: Variant;
Begin
  Lrst := Trim(Copy(ATexto, intIni, intTam));
  If blnFlt Then Lrst := TGranitoFuncoes.fStrToFloat(Lrst) / 100;
  Result := Lrst;
End;

procedure TGranitoPgto.pAdicionaLinha(strString: String);
begin
  If fGetDados(strString, 001, 01) = '9' Then // última linha do arquivo
    Exit

  else If fGetDados(strString, 001, 01) = '0' Then // Cabeçalho
  begin
    FNomeEmpresa := fGetDados(strString, 2, 30);    // Nome da Empresa
    FCNPJ := fGetDados(strString, 32, 14);           // CNPJ da Empresa
    FDataDoArquivo := fGetDados(strString, 46, 8);     // Data de Geração do Arquivo
    FHoraGeracao := fGetDados(strString, 54, 6);     // Hora de Geração do Arquivo
    FNumeroSequencial := fGetDados(strString, 60, 10); // Número Sequencial do Arquivo
    FCodigoDestinatario := fGetDados(strString, 70, 12); // Código do Destinatário
  end
  Else
    pImportaTransacao(strString);
end;

procedure TGranitoPgto.pGravarRegistros(pgbProg: TcxProgressBar);
Var
  LMovimentoFinanceiro: TUniQuery;
  LContador: Integer;
begin
  LMovimentoFinanceiro := Nil;
  Try
    pgbProg.Position := 0;

    If Length(FRegistroGranitoMovimentoFinanceiro) = 0 Then
      Exit;

    LMovimentoFinanceiro := VS_FuncoesExternas.fICriaQuery;

    LMovimentoFinanceiro.Close;
    LMovimentoFinanceiro.SQL.Clear;
    LMovimentoFinanceiro.SQL.Text := TGranitoFuncoes.RetornaSQLReplace('GRA_GTPGTO', ['GRA_CONCIL']);

    pgbProg.Properties.Max := Length(FRegistroGranitoMovimentoFinanceiro) - 1;

    For LContador := 0 To Length(FRegistroGranitoMovimentoFinanceiro) - 1 Do
    Begin
      // Cabeçalho do arquivo
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_HNOMEP', CorrigeDadosBanco(FNomeEmpresa));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_HCNPJP', CorrigeDadosBanco(FCNPJ));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_HDTGER', CorrigeDadosBanco(FDataDoArquivo));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_HHRGER', CorrigeDadosBanco(FHoraGeracao));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_HSEQAR', CorrigeDadosBanco(FNumeroSequencial)); //Número sequencial único do arquivo  para o destinatário
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CODEST', CorrigeDadosBanco(FCodigoDestinatario)); //Número identificador do destinatário  na Granito
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NOMARQ', CorrigeDadosBanco(strNomArq)); //nome arquivo

      // Corpo do registro
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TIPREG', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TipoRegistro)); //1 – Transação 2 – Cancelamento / Desfazimento  3 – Ajuste 4 – Cobrança  5 - Recebimento Pix
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_SEQREG', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].SequencialRegistro)); //Número sequencial dos registros no arquivo  iniciando com 1
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CNPJCL', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].Estabelecimento));  //CPF/CNPJ do client
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NUM_RV', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].IDTransacao)); // Número identificador da transação
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_DTATRA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].DataTransacao)); //Data da transação no formato AAAAMMDD
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_HORTRA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].HoraTransacao)); //Hora da transação no formato HHMMSS
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TIPTRA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TipoTransacao));  //Conteúdo: Indica o tipo de transação (Crédito, Débito, etc.).
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TIPCON', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TipoTransacaoDescricao));  //Conteúdo: Indica a descrição transação (Crédito, Débito, etc.).
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CODBAN', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].BandeiraCartao));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NOMBAN', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].DescricaoBandeiraCartao));   //bandeira
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_VALBRU', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorBruto));     //valor bruto
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_VALADM', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorTaxaADM)); //Valor da taxa de administração
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_VALANT', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorTaxaAntecipacao)); //Valor da taxa de antecipação
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_VALLIQ', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorLiquido));   //valor liquido
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TOTPAR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].QuantidadeParcelas));  //qtd parcea
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NUMPAR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].NumeroParcela));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_BRUPAR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorBrutoParcela));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_ADMPAR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorTaxaADMParcela));//Valor da taxa de administração da  parcela
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TAXANT', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorTaxaAntecipacaoParcela)); //Valor da taxa de antecipação da parcela
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_LIQPAR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorLiquidoParcela));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_DTAPAG', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].DataPagamento));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TIPLAN', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TipoLancamento));  //Conteúdo: Define o tipo de lançamento: Previsão, Liquidação, Liquidação Antecipada.
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_IDTORI', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].IDTransacaoOriginal)); // ID da transação original nos casos de cancelamentos e ajustes
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TIPAJU', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TipoAjuste));  // 0 – Não se aplica ao tipo de registro 1 – Crédito 2 – Débito
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_VALIOF', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ValorIOF));  //Valor do IOF em casos de antecipaçã
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_DTORIG', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].DataOrigem)); // Data de lançamento original no formato AAAAMMDD, para casos de antecipação
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CODANT', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].CodigoSimulacao)); //Código informado para o cálculo da  antecipação quando realizado em ambiente externo a granito
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_ORITRA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].OrigemTransacao));  // 0 - Manual 1 – POS  2 – E-Commerc
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_IDETRA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].IdtransacaoECommerce));  //Identificador único da transação E Commerce
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_IDECLI', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].IdtransacaoiDTransacaoCliente)); // Identificador da transação E-Commerce  gerado pelo cliente
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_IDRETC', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].IdtransacaoRetCliente));  //Código de retorno da transação E Commerce
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CNPJPR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].CNPJPrincipal)); // CNPJ do estabelecimento principal nos  casos de divisão operação
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CNPJPA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].CNPJParceiro)); //CNPJ do parceiro vinculado ao cliente
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_BANCO', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].Banco));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_AGENCI', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].Agencia));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CONTA', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].Conta));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TXMDR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TaxaMDR));  //Percentual da taxa administrativa
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TXANTE', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TaxaAntecipacao));  //Percentual da taxa de antecipação
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_TIPTRN', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].TipoRegistroMovimento));
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_CODAUT', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].Autorizacao));  // Código da autorização da transação na  rede adquirente
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NUMNSU', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].NumeroNSU)); //NSU da transação na rede adquirente
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_RECORR', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].NumeroRecorrente)); //Identificador único da recorrência na  GRANITO
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_IDPROJ', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].IDProjeto));  //Identificador do projeto na GRANITo
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_REFPIX', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].ReferenciaPIX)); // Identificador do pagamento PIX
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NSUDPV', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].NSUPDV)); // NSU do PDV que foi realizado a transação
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_NUMPDV', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].NumeroPDV)); // Número do PDV do estabelecimento
      TGranitoFuncoes.CarregaParametroDataset(LMovimentoFinanceiro, 'GRA_DOCVIN', CorrigeDadosBanco(FRegistroGranitoMovimentoFinanceiro[LContador].DocumentoVinculado)); // Identificador do documento vinculado à  transação no sistema integrado do estabelecimento

      LMovimentoFinanceiro.ExecSQL;

      FImportouPagamentos := True;

      TGranitoFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TGranitoFuncoes.GravarEstabelecimentos;
  Finally
    TGranitoFuncoes.FreeAndNilDatasets(LMovimentoFinanceiro);
  End;
end;


procedure TGranitoPgto.pImportaTransacao(strString: String);
begin
  SetLength(FRegistroGranitoMovimentoFinanceiro, Length(FRegistroGranitoMovimentoFinanceiro) + 1);
  Inc(FIncAddMovimentoFinanceiro);

  // Corpo do registro
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoRegistro := fGetDados(strString, 1, 1); //1 – Transação 2 – Cancelamento / Desfazimento  3 – Ajuste 4 – Cobrança  5 - Recebimento Pix
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].SequencialRegistro := fGetDados(strString, 2, 6); //Número sequencial dos registros no arquivo  iniciando com 1
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento := fGetDados(strString, 8, 14);  //CPF/CNPJ do client
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].IDTransacao := fGetDados(strString, 22, 12); // Número identificador da transação
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataTransacao := fGetDados(strString, 34, 8); //Data da transação no formato AAAAMMDD
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].HoraTransacao := fGetDados(strString, 42, 6); //Hora da transação no formato HHMMSS
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao := fGetDados(strString, 48, 1);   //Conteúdo: Indica o tipo de transação (Crédito, Débito, etc.).

  if FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao = '1' THEN
    FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaodescricao := 'CRÉDITO'
  else if FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacao = '2' then
    FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaodescricao := 'DÉBITO'
  ELSE
    FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoTransacaodescricao := 'NÃO SE APLICA';

  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao := fGetDados(strString, 49, 2);// //bandeira
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DescricaoBandeiraCartao :=  fDescricaoBandeira(FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].BandeiraCartao );

  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBruto := (fGetDados(strString, 51, 10, true));  // Valor Bruto da Transação
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaADM := fGetDados(strString, 61, 10, true);  // Valor da Taxa ADM
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacao := fGetDados(strString, 71, 10, true);  // Valor da Taxa de Antecipação
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquido := fGetDados(strString, 81, 10, true);  // Valor Líquido
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].QuantidadeParcelas := CorrigeParcela(fGetDados(strString, 91, 2)); // Número de Parcelas
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroParcela :=CorrigeParcela(fGetDados(strString, 93, 2)); // Número da Parcela
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorBrutoParcela := fGetDados(strString, 95, 10, true); // Valor Bruto da Parcela
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaADMParcela := fGetDados(strString, 105, 10, true); // Valor da Taxa ADM da Parcela
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorTaxaAntecipacaoParcela := fGetDados(strString, 115, 10, true); // Valor da Taxa de Antecipação da Parcela
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorLiquidoParcela := fGetDados(strString, 125, 10, true); // Valor Líquido da Parcela
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataLancamento := fGetDados(strString, 135, 8); // Data de Lançamento
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Datapagamento := fGetDados(strString, 135, 8);
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoLancamento := fGetDados(strString, 143, 1); // Tipo de Lançamento (1 - Previsão, 2 - Liquidação, 3 - Liquidação Antecipada)
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].IDTransacaoOriginal := fGetDados(strString, 144, 12); // ID da Transação Original
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TipoAjuste := fGetDados(strString, 156, 1); // Tipo de Ajuste (0 - Não se aplica, 1 - Crédito, 2 - Débito)
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ValorIOF := fGetDados(strString, 157, 10, true); // Valor do IOF
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DataOrigem := fGetDados(strString, 167, 8); // Data de Lançamento Original
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CodigoSimulacaoAntecipacao := fGetDados(strString, 175, 10); // Código da Simulação de Antecipação
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].OrigemTransacao := fGetDados(strString, 188, 1); // Origem da Transação
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].IDTransacaoECommerce := fGetDados(strString, 189, 36); // ID da Transação E-Commerce
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].IdtransacaoiDTransacaoCliente := fGetDados(strString, 225, 40); // Merchant Order ID da Transação E-Commerce
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].IdtransacaoRetCliente := fGetDados(strString, 265, 7); // Código de Retorno E-Commerce
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CNPJPrincipal := fGetDados(strString, 272, 14); // CNPJ Principal
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].CNPJParceiro := fGetDados(strString, 298, 14); // CNPJ Parceiro
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Banco := fGetDados(strString, 312, 3); // Banco
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Agencia := fGetDados(strString, 315, 5); // Agência
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Conta := fGetDados(strString, 320, 12); // Conta
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TaxaMDR := fGetDados(strString, 332, 4); // Taxa de MDR
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].TaxaAntecipacao := fGetDados(strString, 336, 4); // Taxa de Antecipação
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Tiporegistromovimento := fGetDados(strString, 340, 3); // Tipo registro movimento

  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Autorizacao := fGetDados(strString, 343, 12); // Autorização
  if  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Autorizacao  = '' then // se autorização vazio
    FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Autorizacao := '000000'; // Autorização

  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroNSU := fGetDados(strString, 355, 32); // NSU da Rede Adquirente
  if  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroNSU = '' then
    FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroNSU := '000000';

  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroRecorrente := fGetDados(strString, 387, 10); // Recorrência
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].IDProjeto := fGetDados(strString, 397, 4); // ID do Projeto
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].ReferenciaPIX := fGetDados(strString, 401, 36); // Reference Number Pix
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NSUPDV := fGetDados(strString, 438, 6); // NSU do PDV
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].NumeroPDV := fGetDados(strString, 444, 6); // Número do PDV
  FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].DocumentoVinculado := fGetDados(strString, 450, 40); // Documento Vinculado

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegistroGranitoMovimentoFinanceiro[FIncAddMovimentoFinanceiro - 1].Estabelecimento);
end;


end.
