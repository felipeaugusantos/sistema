unit untShopeePayPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, Data.DB,

     cxProgressBar, Uni,

     untIShopeeIntegracaoLibCartoes, untShopeeTipos, untTShopeeFuncoes;

Type
  TShopeePayPgto = Class(TInterfacedObject, ICartoesShopee)
  Private
    Colunas:TStringList;
    intPosicaoAtual: Integer;
    FIncAddOrder:Integer;
    FIncAddRepasse:Integer;
    lstCamposOrderAll : TStringList;

    function IsDate(ADate:String): Boolean;
    function IndexOrderAll(ACampo:String):Integer;
    function fRetVal(strVal: Variant; IsDate: Boolean = False; ACampoFloat: Boolean = False): Variant;
    procedure ImportaDeclaracaoDeConta;
    procedure ImportaInformacaoConta;
    procedure ImportaOrderAll; // Arquivo detalhado
    function RetornaLinhaFormatada(ALinha: String): String;
    procedure ImportaRepasse;
    function RetornaCodigoAutorizacao(ADescricao: String): String;
    function LancamentoDeAjuste(ADescricao:String): String;
    function FormatDate(ADate: String): String;
    function FormatFloat(AFloat:String): String;
    function AjusteJaConciliado(ADataDeclaracao,
                                AValor,
                                ADescricao,
                                AAutorizacao: Variant):Boolean;

    procedure CorrigeSeparadorDoCupom(Var ALinhaTexto: String);

    function RetornaValorColunaOrderAll(ANomeCampo: String;
                                        AObrigatorio: Boolean = False;
                                        AValorDefault: String = ''): String;

    procedure ValidaSeVeioDescontoOriginalMasNaoPossuiOCampoSHO_DESORI(var ADataset: TUniQuery;
                                                                       AValorDescontoOriginal,
                                                                       AValorDescontoShopee: String);

    function ReprocessaCodigoAutorizacao(ARegistro: TRegistroPgto): String;
    procedure ApagaRegistroCasoTenhaSidoImportadoAnteriormenteComoTraco(ARegistro: TRegistroPgto);
  Public
    constructor Create;
    Destructor Destroy; Override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(var pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaShopeePayPgto;
  End;

  function RetornaDelimitador(AText: String): Char;

Var
  strNomArq,
  strCodEmp : String;
  FArquivoOrderAll: Boolean;
  FArquivoRepasse:Boolean;
  FArquivoInformacaoConta:Boolean;
  FPossuiTodosRegistros: Boolean;
  FPossuiCamposHub: Boolean;

  FEstShopeePayPgto : TArrEstruturaShopeePayPgto;
  FRegShopeePayPgto : TArrRegistroShopeePayPgto;
  FRegShopeePayPgtoPedido : TArrRegistroShopeePayPedidoPgto;
  FRegShopeePayPgtoRepasse : TArrRegistroShopeePayRepassePgto;

implementation

uses untShopeePay;

{ TShopeePayPgto }

function TShopeePayPgto.AjusteJaConciliado(ADataDeclaracao, AValor, ADescricao, AAutorizacao: Variant): Boolean;
  Var
    qryAjuste : TUniQuery;
begin
  qryAjuste := VS_FuncoesExternas.fICriaQuery;
  Result := False;

  Try
    Try
      qryAjuste.Close;
      qryAjuste.SQL.Text := ' SELECT                        '+
                            '   *                           '+
                            ' FROM                          '+
                            '   SHO_SHAJUS                  '+
                            ' WHERE SHO_DTADEC = :DTADEC    '+
                            '   AND SHO_VALPAG = :VALPAG    '+
                            '   AND SHO_DESCRI = :DESCRI    '+
                            '   AND SHO_CODAUT = :CODAUT    '+
                            '   AND SHO_CONCIL = 1          ';

      qryAjuste.ParamByName('DTADEC').Value := ADataDeclaracao;
      qryAjuste.ParamByName('VALPAG').Value := AValor;
      qryAjuste.ParamByName('DESCRI').Value := ADescricao;
      qryAjuste.ParamByName('CODAUT').Value := AAutorizacao;
      qryAjuste.Open;

      Result := Not qryAjuste.IsEmpty;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    qryAjuste.Close;
    FreeAndNil(qryAjuste);
  End;
end;

procedure TShopeePayPgto.ApagaRegistroCasoTenhaSidoImportadoAnteriormenteComoTraco(
  ARegistro: TRegistroPgto);
  Var
    LRegistroTraco: TUniQuery;

    LTabela: String;

    LCommita: Boolean;
begin
  LRegistroTraco := Nil;
  LTabela := '   SHO_SHPGTO ';
  If ARegistro.LAjuste.Equals('S') Then
    LTabela := '   SHO_SHAJUS ';

  Try
    LRegistroTraco := VS_FuncoesExternas.fICriaQuery;
    LCommita := Not LRegistroTraco.Connection.InTransaction;

    LRegistroTraco.SQL.Text := ' SELECT                        '+
                               '   *                           '+
                               ' FROM                          '+
                               LTabela +
                               ' WHERE SHO_DTADEC = :DTADEC    '+
                               '   AND SHO_VALPAG = :VALPAG    '+
                               '   AND SHO_DESCRI = :DESCRI    '+
                               '   AND SHO_CODAUT = :CODAUT    ';

    LRegistroTraco.ParamByName('DTADEC').Value := fRetVal(ARegistro.LDtaDec, True);
    LRegistroTraco.ParamByName('VALPAG').Value := fRetVal(ARegistro.LValPag);
    LRegistroTraco.ParamByName('DESCRI').Value := fRetVal(ARegistro.LDescri);
    LRegistroTraco.ParamByName('CODAUT').Value := fRetVal(ARegistro.LCodAut);
    LRegistroTraco.Open;

    If LRegistroTraco.IsEmpty Then
      Exit;

    If ARegistro.LAjuste.Equals('S') Then
    Begin
      If LRegistroTraco.FieldByName('SHO_CONCIL').AsString.Equals('1') Then
        Exit;
    End;

    Try
      If LCommita Then
        VS_FuncoesExternas.fIStartTransaction;

      LRegistroTraco.Delete;

      If LCommita Then
        VS_FuncoesExternas.fICommit;
    Except
      If LCommita Then
        VS_FuncoesExternas.fIRollBack;

      Raise;
    End;
  Finally
    TShopeeFuncoes.FreeAndNilDatasets(LRegistroTraco);
  End;
end;

procedure TShopeePayPgto.CorrigeSeparadorDoCupom(var ALinhaTexto: String);
  Var
    LPrimeraParte,
    LTextoColuna: String;

    LIndiceColunaCupons: Integer;
begin
  If ALinhaTexto.ToUpperInvariant.Contains('ID DO PEDIDO') Then
    Exit;

  If Length(ALinhaTexto.Split([';'])) < 11 Then
    Exit;

  If RightStr(ALinhaTexto, 1) = ';' Then
    ALinhaTexto := ALinhaTexto + 'a';

  If Length(ALinhaTexto.Split([';'])) <= lstCamposOrderAll.Count Then
    Exit;

  LIndiceColunaCupons := IndexOrderAll('Código do Cupom') + 1;

  Try
    Repeat
      LTextoColuna := ALinhaTexto.Split([';'])[LIndiceColunaCupons];
      LPrimeraParte := LeftStr(ALinhaTexto, Pos(LTextoColuna, ALinhaTexto) - 2) + ',' + LTextoColuna;
      ALinhaTexto := LPrimeraParte +
                     Copy(ALinhaTexto, Length(LPrimeraParte), Length(ALinhaTexto));

      ALinhaTexto := StringReplace(ALinhaTexto,'"','',[rfReplaceAll]);

    Until(Length(ALinhaTexto.Split([';'])) <= lstCamposOrderAll.Count);
  Except
    On E: Exception Do
      Raise E;
  End;
end;

constructor TShopeePayPgto.Create;
Begin
  intPosicaoAtual := 0;
  FIncAddOrder := 0;
  Colunas := TStringList.Create;
  lstCamposOrderAll :=  TStringList.Create;
  FPossuiTodosRegistros := False;

  FPossuiCamposHub := TShopeeFuncoes.CampoExiste('SHO_PDPGTO', 'SHO_IMPAPI');
End;

destructor TShopeePayPgto.Destroy;
begin
  FreeAndNil(Colunas);
  FreeAndNil(lstCamposOrderAll);
  inherited;
end;

function TShopeePayPgto.FormatDate(ADate: String): String;
begin
  Try
    ADate  := StringReplace(ADate,'-','',[rfReplaceAll]);
    Result := Concat(Copy(ADate,7,2),'/',Copy(ADate,5,2),'/',Copy(ADate,1,4));
    StrToDate(Result);
  Except
    Result := ADate;
  End;
end;

function TShopeePayPgto.FormatFloat(AFloat: String): String;
begin
  Result := AFloat.Replace('.', ',');
  Result := AnsiReplaceStr(Result,'R$','');
end;

class function TShopeePayPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaShopeePayPgto;
Begin
  If strTabela = 'SHO_SHPGTO' Then
  Begin
    SetLength(Result, 11);

    Result[00].strDescri   := 'SHO_DTADEC'; Result[00].strTipCmp   := 'DATE';
    Result[01].strDescri   := 'SHO_HRADEC'; Result[01].strTipCmp   := 'TIME';
    Result[02].strDescri   := 'SHO_BENEFI'; Result[02].strTipCmp   := 'VARCHAR(255)';
    Result[03].strDescri   := 'SHO_VALPAG'; Result[03].strTipCmp   := 'DECIMAL(9,2)';
    Result[04].strDescri   := 'SHO_DESCRI'; Result[04].strTipCmp   := 'VARCHAR(255)';
    Result[05].strDescri   := 'SHO_CODAUT'; Result[05].strTipCmp   := 'VARCHAR(40)';
    Result[06].strDescri   := 'SHO_STATUS'; Result[06].strTipCmp   := 'VARCHAR(255)';
    Result[07].strDescri   := 'SHO_SALCAR'; Result[07].strTipCmp   := 'DECIMAL(9,2)';
    Result[08].strDescri   := 'SHO_NOMARQ'; Result[08].strTipCmp   := 'VARCHAR(255)';
    Result[09].strDescri   := 'SHO_CONCIL'; Result[09].strTipCmp   := 'INT DEFAULT 0';
    Result[10].strDescri   := 'SHO_CODEMP'; Result[10].strTipCmp   := 'CHAR(3)';
  End

  Else If strTabela = 'SHO_SHAJUS' Then
  Begin
    SetLength(Result, 11);

    Result[00].strDescri   := 'SHO_DTADEC'; Result[00].strTipCmp   := 'DATE';
    Result[01].strDescri   := 'SHO_HRADEC'; Result[01].strTipCmp   := 'TIME';
    Result[02].strDescri   := 'SHO_BENEFI'; Result[02].strTipCmp   := 'VARCHAR(255)';
    Result[03].strDescri   := 'SHO_VALPAG'; Result[03].strTipCmp   := 'DECIMAL(9,2)';
    Result[04].strDescri   := 'SHO_DESCRI'; Result[04].strTipCmp   := 'VARCHAR(255)';
    Result[05].strDescri   := 'SHO_CODAUT'; Result[05].strTipCmp   := 'VARCHAR(40)';
    Result[06].strDescri   := 'SHO_STATUS'; Result[06].strTipCmp   := 'VARCHAR(255)';
    Result[07].strDescri   := 'SHO_SALCAR'; Result[07].strTipCmp   := 'DECIMAL(9,2)';
    Result[08].strDescri   := 'SHO_NOMARQ'; Result[08].strTipCmp   := 'VARCHAR(255)';
    Result[09].strDescri   := 'SHO_CONCIL'; Result[09].strTipCmp   := 'INT DEFAULT 0';
    Result[10].strDescri   := 'SHO_CODEMP'; Result[10].strTipCmp   := 'CHAR(3)';
  End;

End;

class function TShopeePayPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
 Var arrCampos: TArrEstruturaShopeePayPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(SHO_DTADEC,SHO_VALPAG,SHO_CODAUT,SHO_DESCRI)) ENGINE INNODB '
end;

function TShopeePayPgto.fRetVal(strVal: Variant; IsDate: Boolean = False;
  ACampoFloat: Boolean = False ): Variant;
Begin
  If TShopeeFuncoes.fEmptyStr(strVal) Then
    Exit(Null);

  Result := strVal;
  If IsDate Then
    Result := StrToDate(Result)
  Else If ACampoFloat Then
    Result := TShopeeFuncoes.fStrToFloat(VarToStr(Result).Replace(',', EmptyStr).Replace('.', ','));
End;

procedure TShopeePayPgto.ImportaDeclaracaoDeConta;
begin
  Inc(intPosicaoAtual);
  FRegShopeePayPgto[intPosicaoAtual-1].LDtaDec := FormatDate(Copy(Colunas.Strings[0],1,11));    // Data da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LHraDec := Copy(Colunas.Strings[0],12,5);                // Hora da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LBenefi := Colunas.Strings[1];                           // Beneficiario
  FRegShopeePayPgto[intPosicaoAtual-1].LValPag := TShopeeFuncoes.fStrToFloat(FormatFloat(Colunas.Strings[2])); // Pagamento
  FRegShopeePayPgto[intPosicaoAtual-1].LDescri := Colunas.Strings[3];                           // Descrição
  FRegShopeePayPgto[intPosicaoAtual-1].LCodAut := RetornaCodigoAutorizacao(Colunas.Strings[3]); // codigo da autorização
  FRegShopeePayPgto[intPosicaoAtual-1].LStatus := Colunas.Strings[4];                           // Status
  FRegShopeePayPgto[intPosicaoAtual-1].LSalCar := TShopeeFuncoes.fStrToFloat(FormatFloat(Colunas.Strings[5])); // Saldo da Carteira
  FRegShopeePayPgto[intPosicaoAtual-1].LAjuste := LancamentoDeAjuste(Colunas.Strings[3]);       // Ajuste (S/N)
  FRegShopeePayPgto[intPosicaoAtual-1].LNomArq := strNomArq;                                    // Nome do Arquivo
  FRegShopeePayPgto[intPosicaoAtual-1].LCodEmp := strCodEmp;                                    // Código da Empresa

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegShopeePayPgto[intPosicaoAtual - 1].LCodEmp <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegShopeePayPgto[intPosicaoAtual -1 ].LCodEmp) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegShopeePayPgto[intPosicaoAtual -1].LCodEmp);
end;

procedure TShopeePayPgto.ImportaInformacaoConta;
begin
  Inc(intPosicaoAtual);
  FRegShopeePayPgto[intPosicaoAtual-1].LDtaDec := FormatDate(Copy(Colunas.Strings[0],1,11));    // Data da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LHraDec := Copy(Colunas.Strings[0],12,5);                // Hora da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LBenefi := Colunas.Strings[1];                           // Beneficiario
  FRegShopeePayPgto[intPosicaoAtual-1].LValPag := TShopeeFuncoes.fStrToFloat(FormatFloat(Colunas.Strings[5])); // Pagamento
  FRegShopeePayPgto[intPosicaoAtual-1].LDescri := Colunas.Strings[2];                           // Descrição
  FRegShopeePayPgto[intPosicaoAtual-1].LCodAut := Colunas.Strings[3];                           // codigo da autorização
  FRegShopeePayPgto[intPosicaoAtual-1].LStatus := Colunas.Strings[6];                           // Status
  FRegShopeePayPgto[intPosicaoAtual-1].LSalCar := TShopeeFuncoes.fStrToFloat(FormatFloat(Colunas.Strings[7])); // Saldo da Carteira
  FRegShopeePayPgto[intPosicaoAtual-1].LAjuste := LancamentoDeAjuste(Colunas.Strings[2]);       // Ajuste (S/N)
  FRegShopeePayPgto[intPosicaoAtual-1].LNomArq := strNomArq;                                    // Nome do Arquivo
  FRegShopeePayPgto[intPosicaoAtual-1].LCodEmp := strCodEmp;                                    // Código da Empresa

  If FRegShopeePayPgto[intPosicaoAtual-1].LCodAut.Trim.Equals('-') Then
    FRegShopeePayPgto[intPosicaoAtual-1].LCodAut := ReprocessaCodigoAutorizacao(FRegShopeePayPgto[intPosicaoAtual-1]);

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If (FRegShopeePayPgto[intPosicaoAtual - 1].LCodEmp <> '') And
     (VS_ListaEstabelecimentos.IndexOf(FRegShopeePayPgto[intPosicaoAtual -1 ].LCodEmp) < 0) Then
    VS_ListaEstabelecimentos.Add(FRegShopeePayPgto[intPosicaoAtual -1].LCodEmp);
end;

procedure TShopeePayPgto.ImportaOrderAll;
begin
  Try
    Inc(FIncAddOrder);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].IDPedido := Colunas.Strings[IndexOrderAll('ID do pedido')];
    FRegShopeePayPgtoPedido[FIncAddOrder-1].StatusPedido := RetornaValorColunaOrderAll('Status do pedido', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].CancelarMotivo := RetornaValorColunaOrderAll('Cancelar Motivo', False);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].StatusDevolucao := RetornaValorColunaOrderAll('Status da Devolução / Reembolso');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].NumeroRastreamento := RetornaValorColunaOrderAll('Número de rastreamento');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].OpcaoEnvio := RetornaValorColunaOrderAll('Opção de envio', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].MetodoEnvio := RetornaValorColunaOrderAll('Método de envio');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DataPrevistaEnvio := RetornaValorColunaOrderAll('Data prevista de envio');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TempoEnvio := RetornaValorColunaOrderAll('Tempo de Envio');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DataCriacaoPedido := RetornaValorColunaOrderAll('Data de criação do pedido', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DataPagamentoPedido := LeftStr(RetornaValorColunaOrderAll('Hora do pagamento do pedido', True),10);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].HoraPagamentoPedido := RightStr(RetornaValorColunaOrderAll('Hora do pagamento do pedido', True),5);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].NumeroSKUPrincipal := RetornaValorColunaOrderAll('Nº de referência do SKU principal');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].NomeProduto := RetornaValorColunaOrderAll('Nome do Produto');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].NumeroSKU := RetornaValorColunaOrderAll('Número de referência SKU');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].NomeVariacao := RetornaValorColunaOrderAll('Nome da variação');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].PrecoOriginal := RetornaValorColunaOrderAll('Preço original', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].PrecoAcordado := RetornaValorColunaOrderAll('Preço acordado', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].Quantidade := RetornaValorColunaOrderAll('Quantidade', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].SubtotalProduto := RetornaValorColunaOrderAll('Subtotal do produto', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoVendedor1 := RetornaValorColunaOrderAll('Desconto do vendedor', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoVendedor2 := Colunas.Strings[IndexOrderAll('Desconto do vendedor') + 1];
    FRegShopeePayPgtoPedido[FIncAddOrder-1].ReembolsoShopee :=  RetornaValorColunaOrderAll('Reembolso Shopee', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].PesoTotalSKU := RetornaValorColunaOrderAll('Peso total SKU');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].QuantidadePedidos := RetornaValorColunaOrderAll('Número de produtos pedidos', False, '1');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].PesoTotalPedido := RetornaValorColunaOrderAll('Peso total do pedido');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].CodigoCupom := RetornaValorColunaOrderAll('Código do Cupom');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].CupomVendedor := RetornaValorColunaOrderAll('Cupom do vendedor');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].CoinCashback := RetornaValorColunaOrderAll('Seller Absorbed Coin Cashback', False, '0');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].CupomShopee := RetornaValorColunaOrderAll('Cupom Shopee', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].IndicadorLeveMaisPorMenos := RetornaValorColunaOrderAll('Indicador da Leve Mais por Menos', False, 'N');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoShopeeLeveMaisPorMenos := RetornaValorColunaOrderAll('Desconto Shopee da Leve Mais por Menos', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoLeveMaisPorMenosVendedor := RetornaValorColunaOrderAll('Desconto da Leve Mais por Menos do vendedor', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].CompensarMoedasShopee := RetornaValorColunaOrderAll('Compensar Moedas Shopee', False, 'N');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TotalDescontadoCartaoCredito := RetornaValorColunaOrderAll('Total descontado Cartão de Crédito', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].ValorTotal := RetornaValorColunaOrderAll('Valor Total', True);
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaEnvioPagaPeloComprador := RetornaValorColunaOrderAll('Taxa de envio pagas pelo comprador', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoFreteAproximado := RetornaValorColunaOrderAll('Desconto de Frete Aproximado', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaEnvioReversa := RetornaValorColunaOrderAll('Taxa de Envio Reversa', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaTransacao := RetornaValorColunaOrderAll('Taxa de transação', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaComissao := RetornaValorColunaOrderAll('Taxa de comissão', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaServico := RetornaValorColunaOrderAll('Taxa de serviço', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].TotalGlobal := RetornaValorColunaOrderAll('Total global', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].ValorEstimadoFrete := RetornaValorColunaOrderAll('Valor estimado do frete', False, '0.00');
    FRegShopeePayPgtoPedido[FIncAddOrder-1].ImportadoPelaAPI := 'N';
    FRegShopeePayPgtoPedido[FIncAddOrder-1].NomeArquivo := strNomArq;
    FRegShopeePayPgtoPedido[FIncAddOrder-1].Empresa := strCodEmp;


    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If (FRegShopeePayPgtoPedido[FIncAddOrder - 1].Empresa <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FRegShopeePayPgtoPedido[FIncAddOrder -1 ].Empresa) < 0) Then
      VS_ListaEstabelecimentos.Add(FRegShopeePayPgtoPedido[FIncAddOrder -1].Empresa);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TShopeePayPgto.ImportaRepasse;
begin
  Inc(FIncAddRepasse);
  FRegShopeePayPgtoRepasse[FIncAddRepasse-1].DataPagamento := Colunas.Strings[0];
  FRegShopeePayPgtoRepasse[FIncAddRepasse-1].Descricao     := Colunas.Strings[1];
  FRegShopeePayPgtoRepasse[FIncAddRepasse-1].ValorPago     := FormatFloat(Colunas.Strings[2]);
  FRegShopeePayPgtoRepasse[FIncAddRepasse-1].Autorizacao   := Colunas.Strings[3];
  FRegShopeePayPgtoRepasse[FIncAddRepasse-1].NomeArquivo   := strNomArq;
end;

function TShopeePayPgto.IndexOrderAll(ACampo: String): Integer;
begin
  Result := lstCamposOrderAll.IndexOf(AnsiUpperCase(ACampo));

  If Result = -1 Then
  Begin
    SetLength(FRegShopeePayPgto,0);
    SetLength(FRegShopeePayPgtoPedido,0);
    SetLength(FRegShopeePayPgtoRepasse,0);
    Raise Exception.Create('Não encontramos a coluna [' + ACampo + '] no arquivo '+ strNomArq +#13#10 +
                           'Verifique se a descrição da coluna está escrita de forma idêntica ao esperado.');
  End;
end;

function TShopeePayPgto.IsDate(ADate: String): Boolean;
  Var
    DateTime : TDateTime;
begin
  Result   := False;
  Try
    DateTime := StrToDate(FormatDate(ADate));
    If DateTime <> 0 Then
      Result := True;
  Except
    Result := False;
  End;
end;

function TShopeePayPgto.LancamentoDeAjuste(ADescricao:String): String;
begin
  Result := 'S';

  If Pos('Renda do pedido',ADescricao) > 0 Then
    Result := 'N';

  If Pos('Income from Order',ADescricao) > 0 Then
    Result := 'N';

  If Pos('Credito por item perdido ou danificado no envio', ADescricao) > 0 Then
    Result := 'N';
end;

function TShopeePayPgto.RetornaLinhaFormatada(ALinha: String): String;
begin
  Result := AnsiUpperCase(TShopeeFuncoes.fConverteParaAcento(ALinha));
end;

function TShopeePayPgto.RetornaValorColunaOrderAll(ANomeCampo: String;
  AObrigatorio: Boolean; AValorDefault: String): String;
  Var
    LIndice: Integer;
begin
  Result := AValorDefault;

  LIndice := lstCamposOrderAll.IndexOf(AnsiUpperCase(ANomeCampo));

  If LIndice = -1 Then
  Begin
    If AObrigatorio Then
    Begin
      SetLength(FRegShopeePayPgto,0);
      SetLength(FRegShopeePayPgtoPedido,0);
      SetLength(FRegShopeePayPgtoRepasse,0);

      Raise Exception.Create('Não encontramos a coluna [' + ANomeCampo + '] no arquivo '+ strNomArq +#13#10 +
                             'Verifique se a descrição da coluna está escrita de forma idêntica ao esperado.');
    End;

    Exit;
  End;

  Result := Colunas.Strings[LIndice];
end;

procedure TShopeePayPgto.ValidaSeVeioDescontoOriginalMasNaoPossuiOCampoSHO_DESORI(
  var ADataset: TUniQuery; AValorDescontoOriginal, AValorDescontoShopee: String);
begin
  If fRetVal(AValorDescontoOriginal, False, True) = Null Then
  Begin
    If fRetVal(AValorDescontoShopee, False, True) = Null Then
      Exit;
  End;

  If MatchStr(AValorDescontoOriginal, ['0', '0.00']) Then
  Begin
    If MatchStr(AValorDescontoShopee, ['0', '0.00']) Then
      Exit;
  End;

  If ADataset.FindParam('SHO_DESORI') <> Nil Then
    Exit;

  ADataset.ParamByName('SHO_REESHO').AsFloat := TShopeeFuncoes.IfNull(ADataset.ParamByName('SHO_REESHO').Value, 0) +
                                                TShopeeFuncoes.IfNull(fRetVal(AValorDescontoOriginal, False, True), 0) -
                                                TShopeeFuncoes.IfNull(fRetVal(AValorDescontoShopee, False, True), 0);
end;

procedure TShopeePayPgto.pAdicionaLinha(strString: String);
begin
  Try
    If TShopeeFuncoes.fEmptyStr(strString) Then
      Exit;

    Colunas.Delimiter := RetornaDelimitador(strString);

    Colunas.StrictDelimiter := True;
    Colunas.DelimitedText := TShopeeFuncoes.fConverteParaAcento(strString);

    If FArquivoOrderAll Then
    Begin
      If TShopeeFuncoes.fEmptyStr(lstCamposOrderAll.DelimitedText) Then
      Begin
        lstCamposOrderAll.Delimiter     := RetornaDelimitador(strString);

        lstCamposOrderAll.StrictDelimiter := True;
        lstCamposOrderAll.DelimitedText := RetornaLinhaFormatada(strString);
      End
      Else If lstCamposOrderAll.Delimiter = ';' Then
      Begin
        CorrigeSeparadorDoCupom(strString);
        Colunas.DelimitedText := TShopeeFuncoes.fConverteParaAcento(strString);
      End;
    End;

    If TShopeeFuncoes.fEmptyStr(Colunas.Text) Then
      Exit;

    If FArquivoOrderAll Then
    Begin

      If (Colunas.Count < 11) Then
        Exit;

      If Not (Pos('ID DO PEDIDO', AnsiUpperCase(strString)) > 0) Then
      Begin
        SetLength(FRegShopeePayPgtoPedido, Length(FRegShopeePayPgtoPedido)+1);
        ImportaOrderAll;
      End;
    End
    Else If FArquivoRepasse Then
    Begin
      If Not (Pos('DATA', Trim(AnsiUpperCase(strString))) > 0) Then
      Begin
        SetLength(FRegShopeePayPgtoRepasse, Length(FRegShopeePayPgtoRepasse)+1);
        ImportaRepasse;
      End;
    End
    Else If FArquivoInformacaoConta Then
    Begin
      If IsDate(Copy(Colunas.Strings[0],1,11)) Then
      Begin
        SetLength(FRegShopeePayPgto, Length(FRegShopeePayPgto)+1);
        ImportaInformacaoConta;
      End;
    End
    Else
    Begin
      If IsDate(Copy(Colunas.Strings[0],1,11)) Then
      Begin
        SetLength(FRegShopeePayPgto, Length(FRegShopeePayPgto)+1);
        ImportaDeclaracaoDeConta;
      End;
    End;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TShopeePayPgto.pGravarRegistros(var pgbProg: TcxProgressBar);
  Var
    qryPagamento,
    qryAjuste: TUniQuery;

    intCont: Integer;

    LDataImportacao: TDateTime;

    LImportadoPelaAPI: Boolean;

    LValorTotal: Double;

    LIndiceNaoEncontrado: Integer;
begin

  qryPagamento := VS_FuncoesExternas.fICriaQuery;
  qryAjuste    := VS_FuncoesExternas.fICriaQuery;

  Try
    If (Length(FRegShopeePayPgto) > 0) Then
    Begin
      FPossuiTodosRegistros := True;

      qryPagamento.Close;
      qryPagamento.SQL.Text := TShopeeFuncoes.RetornaSQLReplace('SHO_SHPGTO', ['SHO_CONCIL']);

      qryAjuste.Close;
      qryAjuste.SQL.Text := TShopeeFuncoes.RetornaSQLReplace('SHO_SHAJUS', ['SHO_CONCIL']);

      pgbProg.Position := 0;
      pgbProg.Properties.Max := Length(FRegShopeePayPgto) - 1;

      VS_FuncoesExternas.fIStartTransaction;
      For intCont := 0 To Length(FRegShopeePayPgto) - 1 Do
      Begin
        If FRegShopeePayPgto[intCont].LAjuste.Equals('N') Then
        Begin
          qryPagamento.Close;

          If FRegShopeePayPgto[intCont].LCodAut.Trim.Equals('-') Then
            FRegShopeePayPgto[intCont].LCodAut := ReprocessaCodigoAutorizacao(FRegShopeePayPgto[intCont]);

          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DTADEC', fRetVal(FRegShopeePayPgto[intCont].LDtaDec,True)); // Data da Declaracão
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_HRADEC', fRetVal(FRegShopeePayPgto[intCont].LHraDec)); // Hora da Declaracão
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_BENEFI', fRetVal(FRegShopeePayPgto[intCont].LBenefi)); // Beneficiario
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_VALPAG', fRetVal(FRegShopeePayPgto[intCont].LValPag)); // Pagamento
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESCRI', fRetVal(FRegShopeePayPgto[intCont].LDescri)); // Descrição
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CODAUT', fRetVal(FRegShopeePayPgto[intCont].LCodAut)); // codigo da autorização
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_STATUS', fRetVal(FRegShopeePayPgto[intCont].LStatus)); // Status
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_SALCAR', fRetVal(FRegShopeePayPgto[intCont].LSalCar)); // Saldo da Carteira
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_NOMARQ', fRetVal(FRegShopeePayPgto[intCont].LNomArq)); // Nome do Arquivo
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CODEMP', fRetVal(FRegShopeePayPgto[intCont].LCodEmp)); // Código da Empresa
          qryPagamento.ExecSQL;

          FPossuiTodosRegistros := True;
        End
        Else If FRegShopeePayPgto[intCont].LAjuste.Equals('S') Then
        Begin

          If AjusteJaConciliado(fRetVal(FRegShopeePayPgto[intCont].LDtaDec,True),
                                fRetVal(FRegShopeePayPgto[intCont].LValPag),
                                fRetVal(FRegShopeePayPgto[intCont].LDescri),
                                fRetVal(FRegShopeePayPgto[intCont].LCodAut)) Then
            Continue;

          If FRegShopeePayPgto[intCont].LCodAut.Trim.Equals('-') Then
            FRegShopeePayPgto[intCont].LCodAut := ReprocessaCodigoAutorizacao(FRegShopeePayPgto[intCont]);

          qryAjuste.Close;
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_DTADEC', fRetVal(FRegShopeePayPgto[intCont].LDtaDec,True)); // Data da Declaracão
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_HRADEC', fRetVal(FRegShopeePayPgto[intCont].LHraDec)); // Hora da Declaracão
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_BENEFI', fRetVal(FRegShopeePayPgto[intCont].LBenefi)); // Beneficiario
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_VALPAG', fRetVal(FRegShopeePayPgto[intCont].LValPag)); // Pagamento
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_DESCRI', fRetVal(FRegShopeePayPgto[intCont].LDescri)); // Descrição
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_CODAUT', fRetVal(FRegShopeePayPgto[intCont].LCodAut)); // codigo da autorização
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_STATUS', fRetVal(FRegShopeePayPgto[intCont].LStatus)); // Status
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_SALCAR', fRetVal(FRegShopeePayPgto[intCont].LSalCar)); // Saldo da Carteira
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_NOMARQ', fRetVal(FRegShopeePayPgto[intCont].LNomArq)); // Nome do Arquivo
          TShopeeFuncoes.CarregaParametroDataset(qryAjuste, 'SHO_CODEMP', fRetVal(FRegShopeePayPgto[intCont].LCodEmp)); // Código da Empresa
          qryAjuste.ExecSQL;
        End;

        TShopeeFuncoes.pStepStatusGravacao(pgbProg);
      End;

      pgbProg.Position := Length(FRegShopeePayPgto) - 1;

       VS_FuncoesExternas.fICommit;
    End;


    Try
      If (Length(FRegShopeePayPgtoPedido) > 0) Then
      Begin
        LDataImportacao := TShopeeFuncoes.RetornaDataHoraServidor;
        qryPagamento.Close;
        qryPagamento.SQL.Text := TShopeeFuncoes.RetornaSQLReplace('SHO_PDPGTO', []);

        pgbProg.Position := 0;
        pgbProg.Properties.Max := Length(FRegShopeePayPgtoPedido) - 1;

        VS_FuncoesExternas.fIStartTransaction;
        For intCont := 0 To Length(FRegShopeePayPgtoPedido) - 1 Do
        Begin
          If FRegShopeePayPgtoPedido[intCont].IDPedido.IsEmpty Or
             FRegShopeePayPgtoPedido[intCont].StatusPedido.IsEmpty Then
          Begin
            TShopeeFuncoes.pStepStatusGravacao(pgbProg);
            Continue;
          End;

          LImportadoPelaAPI := FRegShopeePayPgtoPedido[intCont].ImportadoPelaAPI.Equals('S');

          qryPagamento.Close;
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_ID_PED', fRetVal(FRegShopeePayPgtoPedido[intCont].IDPedido));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_STATUS', fRetVal(FRegShopeePayPgtoPedido[intCont].StatusPedido));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_MOTCAN', fRetVal(FRegShopeePayPgtoPedido[intCont].CancelarMotivo));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_STADEV', fRetVal(FRegShopeePayPgtoPedido[intCont].StatusDevolucao));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_NUMRAT', fRetVal(FRegShopeePayPgtoPedido[intCont].NumeroRastreamento));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_OPCENV', fRetVal(FRegShopeePayPgtoPedido[intCont].OpcaoEnvio));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_METENV', fRetVal(FRegShopeePayPgtoPedido[intCont].MetodoEnvio));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DTAENV', fRetVal(FRegShopeePayPgtoPedido[intCont].DataPrevistaEnvio));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TMPENV', fRetVal(FRegShopeePayPgtoPedido[intCont].TempoEnvio));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DTACRE', fRetVal(FRegShopeePayPgtoPedido[intCont].DataCriacaoPedido));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DTAPAG', fRetVal(FRegShopeePayPgtoPedido[intCont].DataPagamentoPedido));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_HORPAG', fRetVal(FRegShopeePayPgtoPedido[intCont].HoraPagamentoPedido));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_SKUPRI', fRetVal(FRegShopeePayPgtoPedido[intCont].NumeroSKUPrincipal));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_NOMPRO', fRetVal(FRegShopeePayPgtoPedido[intCont].NomeProduto));

		      TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_SKUREF', fRetVal(FRegShopeePayPgtoPedido[intCont].NumeroSKU));
          If qryPagamento.ParamByName('SHO_SKUREF').Value = Null Then
            qryPagamento.ParamByName('SHO_SKUREF').AsString := '';

          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_NOMVAR', fRetVal(FRegShopeePayPgtoPedido[intCont].NomeVariacao));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_PREORI', fRetVal(FRegShopeePayPgtoPedido[intCont].PrecoOriginal, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_PREACO', fRetVal(FRegShopeePayPgtoPedido[intCont].PrecoAcordado, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_QTDPRO', fRetVal(FRegShopeePayPgtoPedido[intCont].Quantidade));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_SUBTOT', fRetVal(FRegShopeePayPgtoPedido[intCont].SubtotalProduto, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESVEN', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoVendedor1, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESVE2', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoVendedor2, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_REESHO', fRetVal(FRegShopeePayPgtoPedido[intCont].ReembolsoShopee, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_PESSKU', fRetVal(FRegShopeePayPgtoPedido[intCont].PesoTotalSKU));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_QTDPED', fRetVal(FRegShopeePayPgtoPedido[intCont].QuantidadePedidos));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_PESPED', fRetVal(FRegShopeePayPgtoPedido[intCont].PesoTotalPedido));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CODCUP', fRetVal(FRegShopeePayPgtoPedido[intCont].CodigoCupom));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CUPVEN', fRetVal(FRegShopeePayPgtoPedido[intCont].CupomVendedor, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CASCOI', fRetVal(FRegShopeePayPgtoPedido[intCont].CoinCashback, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CUPSHO', fRetVal(FRegShopeePayPgtoPedido[intCont].CupomShopee, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_LEVMAI', fRetVal(FRegShopeePayPgtoPedido[intCont].IndicadorLeveMaisPorMenos));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESLEV', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoShopeeLeveMaisPorMenos, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESLVV', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoLeveMaisPorMenosVendedor, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_MOESHO', fRetVal(FRegShopeePayPgtoPedido[intCont].CompensarMoedasShopee));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESCAR', fRetVal(FRegShopeePayPgtoPedido[intCont].TotalDescontadoCartaoCredito, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_VALTOT', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorTotal, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TAXENC', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaEnvioPagaPeloComprador, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESFRE', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoFreteAproximado, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TAXENR', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaEnvioReversa, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TAXTRA', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaTransacao, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TAXCOM', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaComissao, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TAXSER', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaServico, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TXPROT', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaProtecaoEnvio, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TOTGLO', fRetVal(FRegShopeePayPgtoPedido[intCont].TotalGlobal, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_FREEST', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorEstimadoFrete, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CODEMP', fRetVal(FRegShopeePayPgtoPedido[intCont].Empresa));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_NOMARQ', fRetVal(FRegShopeePayPgtoPedido[intCont].NomeArquivo));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_CONCIL', 0);

     		  TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_COMAMS', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorComisaoAMS, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DTAIMP', LDataImportacao);
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_IMPAPI', fRetVal(FRegShopeePayPgtoPedido[intCont].ImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TOTAJU', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorTotalAjustado, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TRSCON', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaTransacaoComprador, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_TOTREC', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorTotalRecebido, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_VALDEV', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorDevolucao, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESORI', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoOriginalShopee, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESSHO', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoShopee, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DESPIX', fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoPix, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_ADSFEE', fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaPublicidade, False, LImportadoPelaAPI));
          TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_DRCREF', fRetVal(FRegShopeePayPgtoPedido[intCont].ReembolsoAjustavelDisputa, False, LImportadoPelaAPI));

          ValidaSeVeioDescontoOriginalMasNaoPossuiOCampoSHO_DESORI(qryPagamento,
                                                                   FRegShopeePayPgtoPedido[intCont].DescontoOriginalShopee,
                                                                   FRegShopeePayPgtoPedido[intCont].DescontoShopee);

          If LImportadoPelaAPI Then
          Begin
            TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_MOESHO', fRetVal(FRegShopeePayPgtoPedido[intCont].CompensarMoedasShopee, False, LImportadoPelaAPI) * 100);

            LValorTotal := qryPagamento.ParamByName('SHO_VALTOT').AsFloat;
            LValorTotal := LValorTotal + fRetVal(FRegShopeePayPgtoPedido[intCont].ValorFinalFrete, False, True);

            TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_VALTOT', LValorTotal);

            If fRetVal(FRegShopeePayPgtoPedido[intCont].ValorFreteAtual, False, LImportadoPelaAPI) > 0 Then
              TShopeeFuncoes.CarregaParametroDataset(qryPagamento, 'SHO_FREEST', fRetVal(FRegShopeePayPgtoPedido[intCont].ValorFreteAtual, False, LImportadoPelaAPI));
          End;

          qryPagamento.ExecSQL;

          LIndiceNaoEncontrado := TShopeePay.GetNaoImportadosHub.IndexOf(FRegShopeePayPgtoPedido[intCont].IDPedido);
          If LIndiceNaoEncontrado > -1 Then
            TShopeePay.GetNaoImportadosHub.Delete(LIndiceNaoEncontrado);

          TShopeeFuncoes.pStepStatusGravacao(pgbProg);
        End;
        VS_FuncoesExternas.fICommit;
      End;


      If (Length(FRegShopeePayPgtoRepasse) > 0) Then
      Begin
        qryPagamento.Close;
        qryPagamento.SQL.Text := TShopeeFuncoes.RetornaSQLReplace('SHO_SHREPA', []);

        pgbProg.Position := 0;
        pgbProg.Properties.Max := Length(FRegShopeePayPgtoRepasse) - 1;

        VS_FuncoesExternas.fIStartTransaction;
        For intCont := 0 To Length(FRegShopeePayPgtoRepasse) - 1 Do
        Begin
          qryPagamento.Close;
          qryPagamento.ParamByName('SHO_DTAPAG').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].DataPagamento,True);
          qryPagamento.ParamByName('SHO_DESCRI').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].Descricao);
          qryPagamento.ParamByName('SHO_VALPAG').Value := fRetVal(TShopeeFuncoes.fSTrToFloat(FRegShopeePayPgtoRepasse[intCont].ValorPago));
          qryPagamento.ParamByName('SHO_CODAUT').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].Autorizacao);
          qryPagamento.ParamByName('SHO_NOMARQ').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].NomeArquivo);
          qryPagamento.ParamByName('SHO_DTAIMP').Value := Date;

          qryPagamento.ExecSQL;

          TShopeeFuncoes.pStepStatusGravacao(pgbProg);
        End;

         VS_FuncoesExternas.fICommit;
      End;

      TShopeeFuncoes.GravarEstabelecimentos;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollback;

        Raise E;
      End;
    End;
  Finally
    SetLength(FRegShopeePayPgto,0);
    SetLength(FRegShopeePayPgtoRepasse,0);

    qryPagamento.Close;
    qryAjuste.Close;
    FreeAndNil(qryPagamento);
    FreeAndNil(qryAjuste);
  End;
end;

function TShopeePayPgto.ReprocessaCodigoAutorizacao(
  ARegistro: TRegistroPgto): String;
  Var
    LCodigoPedidoExtraido: String;
begin
  Result := ARegistro.LCodAut.Trim;

  If Not Result.Equals('-') Then
    Exit;

  LCodigoPedidoExtraido := RightStr(ARegistro.LDescri, 16);

  If LeftStr(LCodigoPedidoExtraido, 2).Equals('- ') Then
  Begin
    Result := RightStr(LCodigoPedidoExtraido, LCodigoPedidoExtraido.Length - 2);

    ApagaRegistroCasoTenhaSidoImportadoAnteriormenteComoTraco(ARegistro);
  End;
end;

function TShopeePayPgto.RetornaCodigoAutorizacao(ADescricao: String): String;
begin
  If Pos('#',ADescricao) > 0 Then
    Result := Copy(ADescricao, Pos('#',ADescricao) + 1, 40)
  Else
    Result := '0';
end;

function RetornaDelimitador(AText: String): Char;
begin
  Result := ',';

  If Pos(';',AText) > 0 Then
    Result := ';';
end;

end.
