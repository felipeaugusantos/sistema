{***************************************}
{* Importação de arquivos da ShopeePay *}
{************************************MT*}
unit untShopeePayPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
  TRegistroRepassePgto = Record
    DataPagamento,
    Descricao,
    ValorPago,
    Autorizacao,
    NomeArquivo: String;
  End;

Type
  TRegistroPedidoPgto = Record // Arquivo completo (detalhado)
    IDPedido,
    StatusPedido,
    CancelarMotivo,
    StatusDevolucao,
    NumeroRastreamento,
    OpcaoEnvio,
    MetodoEnvio,
    DataPrevistaEnvio,
    TempoEnvio,
    DataCriacaoPedido,
   	DataPagamentoPedido,
    HoraPagamentoPedido,
    NumeroSKUPrincipal,
    NomeProduto,
    NumeroSKU,
    NomeVariacao,
    PrecoOriginal,
    PrecoAcordado,
    Quantidade,
    SubtotalProduto,
    DescontoVendedor1,
    DescontoVendedor2,
    ReembolsoShopee,
    PesoTotalSKU,
    QuantidadePedidos,
    PesoTotalPedido,
    CodigoCupom,
    CupomVendedor,
    CoinCashback,
    CupomShopee,
    IndicadorLeveMaisPorMenos,
    DescontoShopeeLeveMaisPorMenos,
    DescontoLeveMaisPorMenosVendedor,
    CompensarMoedasShopee,
    TotalDescontadoCartaoCredito,
    ValorTotal,
    ValorTotalRecebido,
    ValorDevolucao,
    TaxaEnvioPagaPeloComprador,
    DescontoFreteAproximado,
    TaxaEnvioReversa,
    TaxaTransacao,
    TaxaTransacaoComprador,
    TaxaComissao,
    TaxaServico,
    TotalGlobal,
    ValorEstimadoFrete,
    ValorFreteAtual,
    ValorFinalFrete,
    ValorComisaoAMS,
    ValorTotalAjustado,
    ImportadoPelaAPI,
    Empresa,
    NomeArquivo : String;
  End;

  Type
  TRegistroPgto = Record
    LDtaDec: String; // Data da Declaracão
    LHraDec: String; // Hora da Declaracão
    LBenefi: String; // Beneficiario
    LValPag: Double; // Pagamento
    LDescri: String; // Descrição
    LCodAut: String; // codigo da autorização
    LStatus: String; // Status
    LSalCar: Double; // Saldo da Carteira
    LAjuste: String; // Ajuste (S/N)
    LNomArq: String; // Nome do Arquivo
    LCodEmp: String; // Código da Empresa
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroShopeePayPgto  = Array Of TRegistroPgto;
  TArrRegistroShopeePayPedidoPgto  = Array Of TRegistroPedidoPgto;
  TArrRegistroShopeePayRepassePgto  = Array Of TRegistroRepassePgto;


  TArrEstruturaShopeePayPgto  = Array Of TEstruturaPgto;

  TShopeePayPgto = Class(TInterfacedObject, ICartoes)
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
    function RetornaReplaceTabela(ATabela: String): String;
    function RetornaReplaceOrderAll: String;
    function RetornaReplaceRepasse: String;
    function AjusteJaConciliado(ADataDeclaracao,
                                AValor,
                                ADescricao,
                                AAutorizacao: Variant):Boolean;

    procedure CorrigeSeparadorDoCupom(Var ALinhaTexto: String);

    function ReprocessaCodigoAutorizacao(ARegistro: TRegistroPgto): String;
    procedure ApagaRegistroCasoTenhaSidoImportadoAnteriormenteComoTraco(ARegistro: TRegistroPgto);
  Public
    constructor Create;
    Destructor Destroy; Override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

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

implementation

uses untFuncoes, untIDataSet, untShopeePay, untFuncoesSimples;

{ TShopeePayPgto }

function TShopeePayPgto.AjusteJaConciliado(ADataDeclaracao, AValor, ADescricao, AAutorizacao: Variant): Boolean;
  Var
    qryAjuste : IDataSet;
begin
  qryAjuste := objFunctions.fGetDataSet;
  Result := False;

  Try
    Try
      qryAjuste.Close;
      qryAjuste.SQL := ' SELECT                        '+
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
    qryAjuste := Nil;
  End;
end;

procedure TShopeePayPgto.ApagaRegistroCasoTenhaSidoImportadoAnteriormenteComoTraco(
  ARegistro: TRegistroPgto);
  Var
    LRegistroTraco: IDataset;

    LTabela: String;
begin
  LRegistroTraco := Nil;
  LTabela := '   SHO_SHPGTO ';
  If ARegistro.LAjuste.Equals('S') Then
    LTabela := '   SHO_SHAJUS ';

  LRegistroTraco := objFunctions.fGetDataSet;

  LRegistroTraco.SQL := ' SELECT                        '+
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

  LRegistroTraco.Delete;
  LRegistroTraco.Close;
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
    Until(Length(ALinhaTexto.Split([';'])) <= lstCamposOrderAll.Count);
  Except
    On E: Exception Do
      Raise E;
  End;
end;

constructor TShopeePayPgto.Create;
  Var
    LConsulta: IDataset;
Begin
  intPosicaoAtual := 0;
  FIncAddOrder := 0;
  Colunas := TStringList.Create;
  lstCamposOrderAll :=  TStringList.Create;
  FPossuiTodosRegistros := False;

  LConsulta := objFunctions.fGetDataSet;
  LConsulta.SQL := 'SELECT * FROM SHO_PDPGTO WHERE FALSE';
  LConsulta.Open;
  FPossuiCamposHub := LConsulta.FindField('SHO_IMPAPI') <> Nil;
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
  If fEmptyStr(strVal) Then
    Exit(Null);

  Result := strVal;
  If IsDate Then
    Result := StrToDate(Result)
  Else If ACampoFloat Then
    Result := fStrToFloat(VarToStr(Result).Replace(',', EmptyStr).Replace('.', ','), 2);
End;

procedure TShopeePayPgto.ImportaDeclaracaoDeConta;
begin
  Inc(intPosicaoAtual);
  FRegShopeePayPgto[intPosicaoAtual-1].LDtaDec := FormatDate(Copy(Colunas.Strings[0],1,11));    // Data da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LHraDec := Copy(Colunas.Strings[0],12,5);                // Hora da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LBenefi := Colunas.Strings[1];                           // Beneficiario
  FRegShopeePayPgto[intPosicaoAtual-1].LValPag := fStrToFloat(FormatFloat(Colunas.Strings[2])); // Pagamento
  FRegShopeePayPgto[intPosicaoAtual-1].LDescri := Colunas.Strings[3];                           // Descrição
  FRegShopeePayPgto[intPosicaoAtual-1].LCodAut := RetornaCodigoAutorizacao(Colunas.Strings[3]); // codigo da autorização
  FRegShopeePayPgto[intPosicaoAtual-1].LStatus := Colunas.Strings[4];                           // Status
  FRegShopeePayPgto[intPosicaoAtual-1].LSalCar := fStrToFloat(FormatFloat(Colunas.Strings[5])); // Saldo da Carteira
  FRegShopeePayPgto[intPosicaoAtual-1].LAjuste := LancamentoDeAjuste(Colunas.Strings[3]);       // Ajuste (S/N)
  FRegShopeePayPgto[intPosicaoAtual-1].LNomArq := strNomArq;                                    // Nome do Arquivo
  FRegShopeePayPgto[intPosicaoAtual-1].LCodEmp := strCodEmp;                                    // Código da Empresa


  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegShopeePayPgto[intPosicaoAtual - 1].LCodEmp <> '') And
     (lstEstabel.IndexOf(FRegShopeePayPgto[intPosicaoAtual -1 ].LCodEmp) < 0) Then
    lstEstabel.Add(FRegShopeePayPgto[intPosicaoAtual -1].LCodEmp);
end;

procedure TShopeePayPgto.ImportaInformacaoConta;
begin
  Inc(intPosicaoAtual);
  FRegShopeePayPgto[intPosicaoAtual-1].LDtaDec := FormatDate(Copy(Colunas.Strings[0],1,11));    // Data da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LHraDec := Copy(Colunas.Strings[0],12,5);                // Hora da Declaracão
  FRegShopeePayPgto[intPosicaoAtual-1].LBenefi := Colunas.Strings[1];                           // Beneficiario
  FRegShopeePayPgto[intPosicaoAtual-1].LValPag := fStrToFloat(FormatFloat(Colunas.Strings[5])); // Pagamento
  FRegShopeePayPgto[intPosicaoAtual-1].LDescri := Colunas.Strings[2];                           // Descrição
  FRegShopeePayPgto[intPosicaoAtual-1].LCodAut := Colunas.Strings[3];                           // codigo da autorização
  FRegShopeePayPgto[intPosicaoAtual-1].LStatus := Colunas.Strings[6];                           // Status
  FRegShopeePayPgto[intPosicaoAtual-1].LSalCar := fStrToFloat(FormatFloat(Colunas.Strings[7])); // Saldo da Carteira
  FRegShopeePayPgto[intPosicaoAtual-1].LAjuste := LancamentoDeAjuste(Colunas.Strings[2]);       // Ajuste (S/N)
  FRegShopeePayPgto[intPosicaoAtual-1].LNomArq := strNomArq;                                    // Nome do Arquivo
  FRegShopeePayPgto[intPosicaoAtual-1].LCodEmp := strCodEmp;                                    // Código da Empresa


  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegShopeePayPgto[intPosicaoAtual - 1].LCodEmp <> '') And
     (lstEstabel.IndexOf(FRegShopeePayPgto[intPosicaoAtual -1 ].LCodEmp) < 0) Then
    lstEstabel.Add(FRegShopeePayPgto[intPosicaoAtual -1].LCodEmp);
end;

procedure TShopeePayPgto.ImportaOrderAll;
begin
  Inc(FIncAddOrder);
  FRegShopeePayPgtoPedido[FIncAddOrder-1].IDPedido := Colunas.Strings[IndexOrderAll('ID do pedido')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].StatusPedido := Colunas.Strings[IndexOrderAll('Status do pedido')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].CancelarMotivo := Colunas.Strings[IndexOrderAll('Cancelar Motivo')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].StatusDevolucao := Colunas.Strings[IndexOrderAll('Status da Devolução / Reembolso')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].NumeroRastreamento := Colunas.Strings[IndexOrderAll('Número de rastreamento')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].OpcaoEnvio := Colunas.Strings[IndexOrderAll('Opção de envio')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].MetodoEnvio := Colunas.Strings[IndexOrderAll('Método de envio')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DataPrevistaEnvio := Colunas.Strings[IndexOrderAll('Data prevista de envio')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TempoEnvio := Colunas.Strings[IndexOrderAll('Tempo de Envio')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DataCriacaoPedido := Colunas.Strings[IndexOrderAll('Data de criação do pedido')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DataPagamentoPedido := LeftStr(Colunas.Strings[IndexOrderAll('Hora do pagamento do pedido')],10);
  FRegShopeePayPgtoPedido[FIncAddOrder-1].HoraPagamentoPedido := RightStr(Colunas.Strings[IndexOrderAll('Hora do pagamento do pedido')],5);
  FRegShopeePayPgtoPedido[FIncAddOrder-1].NumeroSKUPrincipal := Colunas.Strings[IndexOrderAll('Nº de referência do SKU principal')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].NomeProduto := Colunas.Strings[IndexOrderAll('Nome do Produto')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].NumeroSKU := Colunas.Strings[IndexOrderAll('Número de referência SKU')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].NomeVariacao := Colunas.Strings[IndexOrderAll('Nome da variação')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].PrecoOriginal := Colunas.Strings[IndexOrderAll('Preço original')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].PrecoAcordado := Colunas.Strings[IndexOrderAll('Preço acordado')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].Quantidade := Colunas.Strings[IndexOrderAll('Quantidade')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].SubtotalProduto := Colunas.Strings[IndexOrderAll('Subtotal do produto')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoVendedor1 := Colunas.Strings[IndexOrderAll('Desconto do vendedor')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoVendedor2 := Colunas.Strings[IndexOrderAll('Desconto do vendedor') + 1];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].ReembolsoShopee :=  Colunas.Strings[IndexOrderAll('Reembolso Shopee')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].PesoTotalSKU := Colunas.Strings[IndexOrderAll('Peso total SKU')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].QuantidadePedidos := Colunas.Strings[IndexOrderAll('Número de produtos pedidos')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].PesoTotalPedido := Colunas.Strings[IndexOrderAll('Peso total do pedido')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].CodigoCupom := Colunas.Strings[IndexOrderAll('Código do Cupom')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].CupomVendedor := Colunas.Strings[IndexOrderAll('Cupom do vendedor')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].CoinCashback := Colunas.Strings[IndexOrderAll('Seller Absorbed Coin Cashback')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].CupomShopee := Colunas.Strings[IndexOrderAll('Cupom Shopee')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].IndicadorLeveMaisPorMenos := Colunas.Strings[IndexOrderAll('Indicador da Leve Mais por Menos')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoShopeeLeveMaisPorMenos := Colunas.Strings[IndexOrderAll('Desconto Shopee da Leve Mais por Menos')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoLeveMaisPorMenosVendedor := Colunas.Strings[IndexOrderAll('Desconto da Leve Mais por Menos do vendedor')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].CompensarMoedasShopee := Colunas.Strings[IndexOrderAll('Compensar Moedas Shopee')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TotalDescontadoCartaoCredito := Colunas.Strings[IndexOrderAll('Total descontado Cartão de Crédito')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].ValorTotal := Colunas.Strings[IndexOrderAll('Valor Total')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaEnvioPagaPeloComprador := Colunas.Strings[IndexOrderAll('Taxa de envio pagas pelo comprador')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].DescontoFreteAproximado := Colunas.Strings[IndexOrderAll('Desconto de Frete Aproximado')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaEnvioReversa := Colunas.Strings[IndexOrderAll('Taxa de Envio Reversa')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaTransacao := Colunas.Strings[IndexOrderAll('Taxa de transação')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaComissao := Colunas.Strings[IndexOrderAll('Taxa de comissão')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TaxaServico := Colunas.Strings[IndexOrderAll('Taxa de serviço')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].TotalGlobal := Colunas.Strings[IndexOrderAll('Total global')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].ValorEstimadoFrete := Colunas.Strings[IndexOrderAll('Valor estimado do frete')];
  FRegShopeePayPgtoPedido[FIncAddOrder-1].ImportadoPelaAPI := 'N';
  FRegShopeePayPgtoPedido[FIncAddOrder-1].NomeArquivo := strNomArq;
  FRegShopeePayPgtoPedido[FIncAddOrder-1].Empresa := strCodEmp;


  If Not Assigned(lstEstabel) Then
    lstEstabel := TStringList.Create;

  If (FRegShopeePayPgtoPedido[FIncAddOrder - 1].Empresa <> '') And
     (lstEstabel.IndexOf(FRegShopeePayPgtoPedido[FIncAddOrder -1 ].Empresa) < 0) Then
    lstEstabel.Add(FRegShopeePayPgtoPedido[FIncAddOrder -1].Empresa);
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
  Result := AnsiUpperCase(fConverteParaAcento(ALinha));
end;

procedure TShopeePayPgto.pAdicionaLinha(strString: String);
begin
Try
  If fEmptyStr(strString) Then
    Exit;

  Colunas.Delimiter := RetornaDelimitador(strString);

  Colunas.StrictDelimiter := True;
  Colunas.DelimitedText := fConverteParaAcento(strString);

  If FArquivoOrderAll Then
  Begin
    If fEmptyStr(lstCamposOrderAll.DelimitedText) Then
    Begin
      lstCamposOrderAll.Delimiter     := RetornaDelimitador(strString);

      lstCamposOrderAll.StrictDelimiter := True;
      lstCamposOrderAll.DelimitedText := RetornaLinhaFormatada(strString);
    End
    Else If lstCamposOrderAll.Delimiter = ';' Then
    Begin
      CorrigeSeparadorDoCupom(strString);
      Colunas.DelimitedText := fConverteParaAcento(strString);
    End;
  End;

  If fEmptyStr(Colunas.Text) Then
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
    Raise E;
End;

end;

procedure TShopeePayPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryPagamento : IDataSet;
    qryAjuste : IDataSet;
    intCont: Integer;

    LDataImportacao: TDateTime;

    LImportadoPelaAPI: Boolean;

    LValorTotal: Double;
begin

  qryPagamento := objFunctions.fGetDataSet;
  qryAjuste    := objFunctions.fGetDataSet;


  If (Length(FRegShopeePayPgto) > 0) Then
  Begin
    FPossuiTodosRegistros := True;

    qryPagamento.Close;
    qryPagamento.SQL := RetornaReplaceTabela('SHO_SHPGTO');

    qryAjuste.Close;
    qryAjuste.SQL := RetornaReplaceTabela('SHO_SHAJUS');

    pgbProg.Position := 0;
    pgbProg.Max := Length(FRegShopeePayPgto) - 1;

    For intCont := 0 To Length(FRegShopeePayPgto) - 1 Do
    Begin

      Application.ProcessMessages;

      If FRegShopeePayPgto[intCont].LAjuste.Equals('N') Then
      Begin
        qryPagamento.Close;

        If FRegShopeePayPgto[intCont].LCodAut.Trim.Equals('-') Then
          FRegShopeePayPgto[intCont].LCodAut := ReprocessaCodigoAutorizacao(FRegShopeePayPgto[intCont]);

        qryPagamento.ParamByName('SHO_DTADEC').Value   := fRetVal(FRegShopeePayPgto[intCont].LDtaDec,True); // Data da Declaracão
        qryPagamento.ParamByName('SHO_HRADEC').Value   := fRetVal(FRegShopeePayPgto[intCont].LHraDec); // Hora da Declaracão
        qryPagamento.ParamByName('SHO_BENEFI').Value   := fRetVal(FRegShopeePayPgto[intCont].LBenefi); // Beneficiario
        qryPagamento.ParamByName('SHO_VALPAG').Value   := fRetVal(FRegShopeePayPgto[intCont].LValPag); // Pagamento
        qryPagamento.ParamByName('SHO_DESCRI').Value   := fRetVal(FRegShopeePayPgto[intCont].LDescri); // Descrição
        qryPagamento.ParamByName('SHO_CODAUT').Value   := fRetVal(FRegShopeePayPgto[intCont].LCodAut); // codigo da autorização
        qryPagamento.ParamByName('SHO_STATUS').Value   := fRetVal(FRegShopeePayPgto[intCont].LStatus); // Status
        qryPagamento.ParamByName('SHO_SALCAR').Value   := fRetVal(FRegShopeePayPgto[intCont].LSalCar); // Saldo da Carteira
        qryPagamento.ParamByName('SHO_NOMARQ').Value   := fRetVal(FRegShopeePayPgto[intCont].LNomArq); // Nome do Arquivo
        qryPagamento.ParamByName('SHO_CODEMP').Value   := fRetVal(FRegShopeePayPgto[intCont].LCodEmp); // Código da Empresa
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
        qryAjuste.ParamByName('SHO_DTADEC').Value   := fRetVal(FRegShopeePayPgto[intCont].LDtaDec,True); // Data da Declaracão
        qryAjuste.ParamByName('SHO_HRADEC').Value   := fRetVal(FRegShopeePayPgto[intCont].LHraDec); // Hora da Declaracão
        qryAjuste.ParamByName('SHO_BENEFI').Value   := fRetVal(FRegShopeePayPgto[intCont].LBenefi); // Beneficiario
        qryAjuste.ParamByName('SHO_VALPAG').Value   := fRetVal(FRegShopeePayPgto[intCont].LValPag); // Pagamento
        qryAjuste.ParamByName('SHO_DESCRI').Value   := fRetVal(FRegShopeePayPgto[intCont].LDescri); // Descrição
        qryAjuste.ParamByName('SHO_CODAUT').Value   := fRetVal(FRegShopeePayPgto[intCont].LCodAut); // codigo da autorização
        qryAjuste.ParamByName('SHO_STATUS').Value   := fRetVal(FRegShopeePayPgto[intCont].LStatus); // Status
        qryAjuste.ParamByName('SHO_SALCAR').Value   := fRetVal(FRegShopeePayPgto[intCont].LSalCar); // Saldo da Carteira
        qryAjuste.ParamByName('SHO_NOMARQ').Value   := fRetVal(FRegShopeePayPgto[intCont].LNomArq); // Nome do Arquivo
        qryAjuste.ParamByName('SHO_CODEMP').Value   := fRetVal(FRegShopeePayPgto[intCont].LCodEmp); // Código da Empresa
        qryAjuste.ExecSQL;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    pgbProg.Position := Length(FRegShopeePayPgto) - 1;
  End;


  Try
    If (Length(FRegShopeePayPgtoPedido) > 0) Then
    Begin
      LDataImportacao := fRetDataServidor + fRetHoraServidor;
      qryPagamento.Close;
      qryPagamento.SQL := RetornaReplaceOrderAll;

      pgbProg.Position := 0;
      pgbProg.Max := Length(FRegShopeePayPgtoPedido) - 1;

      For intCont := 0 To Length(FRegShopeePayPgtoPedido) - 1 Do
      Begin
        If FRegShopeePayPgtoPedido[intCont].IDPedido.IsEmpty Or
           FRegShopeePayPgtoPedido[intCont].StatusPedido.IsEmpty Then
        Begin
          pgbProg.Position := pgbProg.Position + 1;
          Continue;
        End;

        LImportadoPelaAPI := FRegShopeePayPgtoPedido[intCont].ImportadoPelaAPI.Equals('S');

        Application.ProcessMessages;
        qryPagamento.Close;
        qryPagamento.ParamByName('SHO_ID_PED').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].IDPedido);
        qryPagamento.ParamByName('SHO_STATUS').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].StatusPedido);
        qryPagamento.ParamByName('SHO_MOTCAN').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CancelarMotivo);
        qryPagamento.ParamByName('SHO_STADEV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].StatusDevolucao);
        qryPagamento.ParamByName('SHO_NUMRAT').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].NumeroRastreamento);
        qryPagamento.ParamByName('SHO_OPCENV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].OpcaoEnvio);
        qryPagamento.ParamByName('SHO_METENV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].MetodoEnvio);
        qryPagamento.ParamByName('SHO_DTAENV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DataPrevistaEnvio);
        qryPagamento.ParamByName('SHO_TMPENV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TempoEnvio);
        qryPagamento.ParamByName('SHO_DTACRE').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DataCriacaoPedido);
        qryPagamento.ParamByName('SHO_DTAPAG').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DataPagamentoPedido);
        qryPagamento.ParamByName('SHO_HORPAG').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].HoraPagamentoPedido);
        qryPagamento.ParamByName('SHO_SKUPRI').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].NumeroSKUPrincipal);
        qryPagamento.ParamByName('SHO_NOMPRO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].NomeProduto);

        qryPagamento.ParamByName('SHO_SKUREF').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].NumeroSKU);
        If qryPagamento.ParamByName('SHO_SKUREF').Value = Null Then
          qryPagamento.ParamByName('SHO_SKUREF').AsString := '';

        qryPagamento.ParamByName('SHO_NOMVAR').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].NomeVariacao);
        qryPagamento.ParamByName('SHO_PREORI').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].PrecoOriginal, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_PREACO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].PrecoAcordado, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_QTDPRO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].Quantidade);
        qryPagamento.ParamByName('SHO_SUBTOT').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].SubtotalProduto, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_DESVEN').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoVendedor1, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_DESVE2').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoVendedor2, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_REESHO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ReembolsoShopee, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_PESSKU').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].PesoTotalSKU);
        qryPagamento.ParamByName('SHO_QTDPED').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].QuantidadePedidos);
        qryPagamento.ParamByName('SHO_PESPED').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].PesoTotalPedido);
        qryPagamento.ParamByName('SHO_CODCUP').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CodigoCupom);
        qryPagamento.ParamByName('SHO_CUPVEN').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CupomVendedor, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_CASCOI').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CoinCashback, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_CUPSHO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CupomShopee, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_LEVMAI').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].IndicadorLeveMaisPorMenos);
        qryPagamento.ParamByName('SHO_DESLEV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoShopeeLeveMaisPorMenos, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_DESLVV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoLeveMaisPorMenosVendedor, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_MOESHO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CompensarMoedasShopee);
        qryPagamento.ParamByName('SHO_DESCAR').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TotalDescontadoCartaoCredito, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_VALTOT').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorTotal, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_TAXENC').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaEnvioPagaPeloComprador, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_DESFRE').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].DescontoFreteAproximado, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_TAXENR').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaEnvioReversa, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_TAXTRA').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaTransacao, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_TAXCOM').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaComissao, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_TAXSER').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaServico, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_TOTGLO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TotalGlobal, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_FREEST').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorEstimadoFrete, False, LImportadoPelaAPI);
        qryPagamento.ParamByName('SHO_CODEMP').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].Empresa);
        qryPagamento.ParamByName('SHO_NOMARQ').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].NomeArquivo);
        qryPagamento.ParamByName('SHO_CONCIL').Value := 0;

        If FPossuiCamposHub Then
        Begin
          qryPagamento.ParamByName('SHO_COMAMS').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorComisaoAMS, False, LImportadoPelaAPI);
          qryPagamento.ParamByName('SHO_DTAIMP').Value := LDataImportacao;
          qryPagamento.ParamByName('SHO_IMPAPI').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ImportadoPelaAPI);
          qryPagamento.ParamByName('SHO_TOTAJU').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorTotalAjustado, False, LImportadoPelaAPI);
          qryPagamento.ParamByName('SHO_TRSCON').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].TaxaTransacaoComprador, False, LImportadoPelaAPI);
          qryPagamento.ParamByName('SHO_TOTREC').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorTotalRecebido, False, LImportadoPelaAPI);
          qryPagamento.ParamByName('SHO_VALDEV').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorDevolucao, False, LImportadoPelaAPI);

          If LImportadoPelaAPI Then
          Begin
            qryPagamento.ParamByName('SHO_MOESHO').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].CompensarMoedasShopee, False, LImportadoPelaAPI) * 100;

            LValorTotal := qryPagamento.ParamByName('SHO_VALTOT').AsFloat;
            LValorTotal := LValorTotal + fRetVal(FRegShopeePayPgtoPedido[intCont].ValorFinalFrete, False, True);

            qryPagamento.ParamByName('SHO_VALTOT').Value := LValorTotal;

            If fRetVal(FRegShopeePayPgtoPedido[intCont].ValorFreteAtual, False, LImportadoPelaAPI) > 0 Then
              qryPagamento.ParamByName('SHO_FREEST').Value := fRetVal(FRegShopeePayPgtoPedido[intCont].ValorFreteAtual, False, LImportadoPelaAPI);
          End;
        End;

        qryPagamento.ExecSQL;

        pgbProg.Position := pgbProg.Position + 1;
      End;
    End;


    If (Length(FRegShopeePayPgtoRepasse) > 0) Then
    Begin
      qryPagamento.Close;
      qryPagamento.SQL := RetornaReplaceRepasse;


      pgbProg.Position := 0;
      pgbProg.Max := Length(FRegShopeePayPgtoRepasse) - 1;

      For intCont := 0 To Length(FRegShopeePayPgtoRepasse) - 1 Do
      Begin

        Application.ProcessMessages;
        qryPagamento.Close;
        qryPagamento.ParamByName('SHO_DTAPAG').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].DataPagamento,True);
        qryPagamento.ParamByName('SHO_DESCRI').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].Descricao);
        qryPagamento.ParamByName('SHO_VALPAG').Value := fRetVal(fSTrToFloat(FRegShopeePayPgtoRepasse[intCont].ValorPago));
        qryPagamento.ParamByName('SHO_CODAUT').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].Autorizacao);
        qryPagamento.ParamByName('SHO_NOMARQ').Value := fRetVal(FRegShopeePayPgtoRepasse[intCont].NomeArquivo);
        qryPagamento.ParamByName('SHO_DTAIMP').Value := Date;

        qryPagamento.ExecSQL;

        pgbProg.Position := pgbProg.Position + 1;

      End;


    End;
  Except
    On E: Exception Do
      Raise E;
  End;

  SetLength(FRegShopeePayPgto,0);
  SetLength(FRegShopeePayPgtoPedido,0);
  SetLength(FRegShopeePayPgtoRepasse,0);

  Try
    qryPagamento.Close;
    qryPagamento.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "SHOPEE")';
    For intCont := 0 To lstEstabel.Count - 1 Do
    Begin
      qryPagamento.ParamByName('ESTAB').AsString := lstEstabel[intCont];
      qryPagamento.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
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

function TShopeePayPgto.RetornaReplaceOrderAll: String;
begin
  Result := 'REPLACE INTO SHO_PDPGTO (   '+
            '  SHO_ID_PED,   '+
            '  SHO_STATUS,   '+
            '  SHO_MOTCAN,   '+
            '  SHO_STADEV,   '+
            '  SHO_NUMRAT,   '+
            '  SHO_OPCENV,   '+
            '  SHO_METENV,   '+
            '  SHO_DTAENV,   '+
            '  SHO_TMPENV,   '+
            '  SHO_SKUPRI,   '+
            '  SHO_NOMPRO,   '+
            '  SHO_SKUREF,   '+
            '  SHO_NOMVAR,   '+
            '  SHO_PREORI,   '+
            '  SHO_PREACO,   '+
            '  SHO_QTDPRO,   '+
            '  SHO_SUBTOT,   '+
            '  SHO_DESVEN,   '+
            '  SHO_REESHO,   '+
            '  SHO_PESSKU,   '+
            '  SHO_QTDPED,   '+
            '  SHO_PESPED,   '+
            '  SHO_CODCUP,   '+
            '  SHO_CUPVEN,   '+
            '  SHO_CASCOI,   '+
            '  SHO_CUPSHO,   '+
            '  SHO_LEVMAI,   '+
            '  SHO_DESLEV,   '+
            '  SHO_MOESHO,   '+
            '  SHO_DESCAR,   '+
            '  SHO_VALTOT,   '+
            '  SHO_TAXENC,   '+
            '  SHO_DESFRE,   '+
            '  SHO_TAXENR,   '+
            '  SHO_TAXTRA,   '+
            '  SHO_TAXCOM,   '+
            '  SHO_TAXSER,   '+
            '  SHO_TOTGLO,   '+
            '  SHO_FREEST,   '+
            '  SHO_DTAPAG,   '+
            '  SHO_HORPAG,   '+
            '  SHO_DESLVV,   '+
            '  SHO_CONCIL,   '+
            '  SHO_DESVE2,   '+
            '  SHO_DTACRE,   '+
            '  SHO_CODEMP,   '+
            '  SHO_NOMARQ    ';

  If FPossuiCamposHub Then
    Result := Result +
              ', SHO_COMAMS,   ' +
              '  SHO_DTAIMP,   ' +
              '  SHO_IMPAPI,   ' +
              '  SHO_TOTAJU,   ' +
              '  SHO_TRSCON,   ' +
              '  SHO_TOTREC,   ' +
              '  SHO_VALDEV    ';

  Result := Result +
            ')               '+
            'VALUES          '+
            '  (             '+
            '    :SHO_ID_PED,   '+
            '    :SHO_STATUS,   '+
            '    :SHO_MOTCAN,   '+
            '    :SHO_STADEV,   '+
            '    :SHO_NUMRAT,   '+
            '    :SHO_OPCENV,   '+
            '    :SHO_METENV,   '+
            '    :SHO_DTAENV,   '+
            '    :SHO_TMPENV,   '+
            '    :SHO_SKUPRI,   '+
            '    :SHO_NOMPRO,   '+
            '    :SHO_SKUREF,   '+
            '    :SHO_NOMVAR,   '+
            '    :SHO_PREORI,   '+
            '    :SHO_PREACO,   '+
            '    :SHO_QTDPRO,   '+
            '    :SHO_SUBTOT,   '+
            '    :SHO_DESVEN,   '+
            '    :SHO_REESHO,   '+
            '    :SHO_PESSKU,   '+
            '    :SHO_QTDPED,   '+
            '    :SHO_PESPED,   '+
            '    :SHO_CODCUP,   '+
            '    :SHO_CUPVEN,   '+
            '    :SHO_CASCOI,   '+
            '    :SHO_CUPSHO,   '+
            '    :SHO_LEVMAI,   '+
            '    :SHO_DESLEV,   '+
            '    :SHO_MOESHO,   '+
            '    :SHO_DESCAR,   '+
            '    :SHO_VALTOT,   '+
            '    :SHO_TAXENC,   '+
            '    :SHO_DESFRE,   '+
            '    :SHO_TAXENR,   '+
            '    :SHO_TAXTRA,   '+
            '    :SHO_TAXCOM,   '+
            '    :SHO_TAXSER,   '+
            '    :SHO_TOTGLO,   '+
            '    :SHO_FREEST,   '+
            '    :SHO_DTAPAG,   '+
            '    :SHO_HORPAG,   '+
            '    :SHO_DESLVV,   '+
            '    :SHO_CONCIL,   '+
            '    :SHO_DESVE2,   '+
            '    :SHO_DTACRE,   '+
            '    :SHO_CODEMP,   '+
            '    :SHO_NOMARQ    ';

  If FPossuiCamposHub Then
    Result := Result +
              ', :SHO_COMAMS,   ' +
              '  :SHO_DTAIMP,   ' +
              '  :SHO_IMPAPI,   ' +
              '  :SHO_TOTAJU,   ' +
              '  :SHO_TRSCON,   ' +
              '  :SHO_TOTREC,   ' +
              '  :SHO_VALDEV    ';

  Result := Result +
            '  )';
end;

function TShopeePayPgto.RetornaReplaceRepasse: String;
begin
  Result := 'REPLACE INTO SHO_SHREPA (   '+
            '  SHO_DTAPAG,   '+
            '  SHO_DESCRI,   '+
            '  SHO_VALPAG,   '+
            '  SHO_CODAUT,   '+
            '  SHO_NOMARQ,   '+
            '  SHO_DTAIMP    '+
            ')               '+
            'VALUES          '+
            '  (             '+
            '    :SHO_DTAPAG,   '+
            '    :SHO_DESCRI,   '+
            '    :SHO_VALPAG,   '+
            '    :SHO_CODAUT,   '+
            '    :SHO_NOMARQ,   '+
            '    :SHO_DTAIMP  ) ';

end;

function TShopeePayPgto.RetornaReplaceTabela(ATabela: String): String;
  Var
    intCont  : Integer;
    arrCampos: TArrEstruturaShopeePayPgto;
    strSQL : String;
begin
  arrCampos := fRetEstruturaPgto(ATabela);

  strSQL :=          'REPLACE INTO '+ATabela+' (';

  For intCont := 0 to Length(arrCampos) - 1 do
  Begin
    If (arrCampos[intCont].strDescri <> 'SHO_CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  End;

  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';

  For intCont := 0 to Length(arrCampos) - 1 do
  Begin
    If (arrCampos[intCont].strDescri <> 'SHO_CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  End;

  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  Result := strSQL;
End;

end.
