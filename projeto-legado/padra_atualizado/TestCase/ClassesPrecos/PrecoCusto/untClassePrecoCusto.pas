unit untClassePrecoCusto;

interface

uses untAbstractConsulta, untIConsulta, untIGerarTeste, untAbstractGerarTeste,
  System.SysUtils, System.StrUtils, UniClientDataSet, untICasosTestesLog,
  untCasosTestesLog, untCasosTestesLogImpl, untModulo, untFuncoes,
  Faturamento.Precos.Interfaces.PrecoCusto, Faturamento.Precos.Tipos.PrecoCusto,
  untFatCalcularPrecosService, untTypes, Faturamento.Impostos.Calculos.TesteUnitarioLog,
  fs_iinterpreter,
  untParametrosComparacaoPrecoCusto, Shared.Functions.FloatUtils, fs_ipascal,
  Shared.Functions.Types;

Type
  TConsultaPrecoCusto = class(TAbstractConsulta)
  private
    function RetornarColunasSQL(const ADoctosConfirmacao: boolean) : String;
    function RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
    function RetornarFiltrosSQL: string;
    function AjustaTabelasDocumentoConfirmacao(const ASQLTabelas: string): string;
    function RetornarColunaDET_ICMPAV(const ADoctosConfirmacao: Boolean): String;
  public
    Class function New : IConsulta;
    function fRetornarSQLPrecoCusto : String; override;
  end;

Type
  TGerarTestePrecoCusto = class(TAbstractGerarTeste)
  private
    FQuantidadeRegistro: Integer;
    FQtdeRegistrosPrecoCustoRealVendaProcessados: integer;
    FQtdeRegistrosPrecoCustoMargemMarkupProcessados: integer;
    FResultadoServicosClassePrecoCustoRealVenda: IResultadoServicosClassePrecoCusto;
    FResultadoServicosClassePrecoCustoMargemMarkupOuProduto: IResultadoServicosClassePrecoCusto;
    FTipoAbfCliente: String;
    FQtdeRegistrosPrecoCustoRealVendaAcerto: integer;
    FQtdeRegistrosPrecoCustoRealVendaErro: integer;
    FQtdeRegistrosPrecoCustoRealVendaDuplicados: Integer;
    FQtdeRegistrosPrecoCustoRealVendaIgnorados: integer;
    FQtdeRegistrosPrecoCustoMargemMarkupAcerto: integer;
    FQtdeRegistrosPrecoCustoMargemMarkupErro: integer;
    FQtdeRegistrosPrecoCustoMargemMarkupDuplicados: Integer;
    FQtdeRegistrosPrecoCustoMargemMarkupIgnorados: integer;
    FResultadoComparacaoPrecoCustoMargemMarkupOuProduto: TResultadoComparacao;

    function ResultadoComparacaoPrecoCustoRealVenda(const ADados: TUniClientDataSet): TResultadoComparacao;
    function ResultadoComparacaoPrecoCustoMargemMarkupOuProduto(const ADados: TUniClientDataSet): TResultadoComparacao;
    function RetornarResultadoComparacaoPrecoCustoRealVenda(Const ADados : TUniClientDataSet): TResultadoComparacao;
    function RetornarResultadoComparacaoPrecoCustoMargemMarkup(Const ADados : TUniClientDataSet): TResultadoComparacao;
    function AdicionarLogEspeciesIgnoradasPrecoCustoRealVenda(const ADados: TUniClientDataSet;
      const AResultadoComparacao: TResultadoComparacao;
      const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto): Boolean;
//    function RetornarValidacaoClienteIndustria: Boolean;
    function RetornarTipoAbreviacaoCliente: String;

    function RetornarIcmsDeSaida(const ADados: TUniClientDataSet): Double;
    function RetornarOutrosValores(const ADados: TUniClientDataSet): Double;
    function RetornarPrecoVenda(const ADados: TUniClientDataSet): Double;
    function PodeAdicionarLogIgnoradasPrecoCusto(const ADados: TUniClientDataSet; const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto): Boolean;
    function ValidarSeDeveAdicionarLogEspeciesIgnoradas(const ADados: TUniClientDataSet): Boolean;

    function CalcularPrecoCustoRealVenda(const ADados: TUniClientDataSet): IResultadoServicosClassePrecoCusto;
    function CalcularPrecoCustoMargemMarkup(const ADados: TUniClientDataSet): IResultadoServicosClassePrecoCusto;
    function CalcularPrecoCustoProduto(const ADados: TUniClientDataSet): IResultadoServicosClassePrecoCusto;

//    function ItemEspecialDocumentoNaoEhDevolucao(const ADados: TUniClientDataSet): Boolean;
    function RetornarObjetoParametrosPrecoCusto(const ADados: TUniClientDataSet; const AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto): TObject;
    function RetornarTOTCUS(const ADados: TUniClientDataSet; const AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto): Double;

    procedure InicializarVariaveisRegistros;
    Procedure pTesteUnitarioLogCustoRealVenda(AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto; ADados: TUniClientDataSet);
    Procedure pTesteUnitarioLogCustoMargemMarkupOuProduto(AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto; ADados: TUniClientDataSet);
    procedure ZerarRegistrosDoProcessamento;
    procedure CasosTestesLogPrecoCustoRealVenda(ACasosTestesLogPrecoCusto: ICasosTestesLog; AResultadoComparacaoPrecoCustoReal: TResultadoComparacao; ADados: TUniClientDataSet);
    procedure CasosTestesLogPrecoCustoMargemMarkup(ACasosTestesLogPrecoCusto: ICasosTestesLog; AResultadoComparacaoPrecoCustoMargemMarkup: TResultadoComparacao; ADados: TUniClientDataSet);
    procedure TotalizarRegistrosProcessamentoPrecoCustoRealVenda;
    procedure TotalizarRegistrosProcessamentoPrecoCustoMargemMarkup;
    procedure TotalizarRegistrosProcessamentoGeral;
    procedure SetarTotaisDoProcessamentoDoPrecoCustoRealVenda;
    procedure SetarTotaisDoProcessamentoDoPrecoCustoMargemMarkup;
    procedure SetarTotaisDoProcessamentoFinal;
    procedure ResultadoServicosClassePrecoCustoMargemMarkupOuProduto(const ADados: TUniClientDataSet);
    function ValidarSeDeveIgnorarRegistro(
      const ADados: TUniClientDataSet): boolean;
    function ValidarSeDeveIgnorarRegistroDeTinta(
      const AIdentificacaoDoProduto: string): boolean;
  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTestePrecoCusto(const ADados: OleVariant): Boolean; override;

    function CompararResultadoPrecoCustoRealVenda(const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto; const ADados: TUniClientDataSet) : Boolean;
    function CompararResultadoPrecoCustoMargemMarkup(const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto; const ADados: TUniClientDataSet) : Boolean;
  end;

implementation

{ TGerarTestePrecoCusto }

function TGerarTestePrecoCusto.AdicionarLogEspeciesIgnoradasPrecoCustoRealVenda(
  const ADados: TUniClientDataSet;
  const AResultadoComparacao: TResultadoComparacao;
  const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto): Boolean;
begin
  Result := False;

  If (AResultadoComparacao = rcoTrue) Then
    Exit;

  If Not PodeAdicionarLogIgnoradasPrecoCusto(ADados, AResultadoCalculoPrecoCusto) Then
    Exit;

  Result := True;
end;

function TGerarTestePrecoCusto.CalcularPrecoCustoProduto(
  const ADados: TUniClientDataSet): IResultadoServicosClassePrecoCusto;
var
  LParametrosPrecoCustoProduto: IParametrosServicoPrecoCusto;
begin
  LParametrosPrecoCustoProduto :=
    TParametrosServicoPrecoCusto.New
      .PrecoDeCompra(ADados.FieldByName('ITE_PRECOM').AsFloat)
      .Desconto01(ADados.FieldByName('ITE_DESF01').AsFloat)
      .Desconto02(ADados.FieldByName('ITE_DESF02').AsFloat)
      .Desconto03(ADados.FieldByName('ITE_DESF03').AsFloat)
      .Desconto04(ADados.FieldByName('ITE_DESF04').AsFloat)
      .Desconto05(ADados.FieldByName('ITE_DESF05').AsFloat)
      .Desconto06(ADados.FieldByName('ITE_DESF06').AsFloat)
      .Desconto07(0)
      .IcmsDeEntrada(ADados.FieldByName('ITE_ICMENT').AsFloat)
      .ImpostoFederal(ADados.FieldByName('ITE_SUBFED').AsFloat)
      .IpiDeEntrada(ADados.FieldByName('ITE_IPIENT').AsFloat)
      .PercentualFreteDeEntrada(ADados.FieldByName('ITE_FREENT').AsFloat)
      .ValorDoFrete(ADados.FieldByName('ITE_VALFRE').AsFloat)
      .AcrescimoFinal(ADados.FieldByName('ITE_ACRFIN').AsFloat)
      .SubstituicaoTributaria(ADados.FieldByName('ITE_SUBSTI').AsFloat)
      .DescontosAdicionais(ADados.FieldByName('ITE_DESADB').AsFloat)
      .TipoMoeda(moeDolar)
      .TaxaDeControleDeIncentivosFiscaisSuframa(ADados.FieldByName('ITE_TCIFCU').AsFloat)
      .TaxaDeServicoSuframa(ADados.FieldByName('ITE_TSCUST').AsFloat)
      .DescontoPISCOFINS(ADados.FieldByName('ITE_DEPICO').AsFloat)
      .DescontoDeIcms(ADados.FieldByName('ITE_DEICMS').AsFloat)
      .FatorRegional(ADados.FieldByName('ITE_FATREG').AsFloat);

  Result := GetFaturamentoPrecosService.PrecoCusto.CalculaPrecoCusto(LParametrosPrecoCustoProduto);
end;

function TGerarTestePrecoCusto.CalcularPrecoCustoMargemMarkup(
  const ADados: TUniClientDataSet): IResultadoServicosClassePrecoCusto;
var
  LParametrosPrecoCustoMargemMarkup: IParametrosServicoPrecoCustoMargemMarkup;
  LPrecoVenda: Double;
begin
  LPrecoVenda := ((ADados.FieldByName('DET_UNITAR').AsFloat * ADados.FieldByName('DET_QTDITE').AsFloat) - ADados.FieldByName('DET_DESESP').AsFloat);

  LParametrosPrecoCustoMargemMarkup :=
    TParametrosServicoPrecoCustoMargemMarkup.New()
      .PrecoDeVenda(LPrecoVenda)
      .Margem(fGetValorConfiguracao('MMIIES', varDouble));

  Result := GetFaturamentoPrecosService.PrecoCusto.CalculaPrecoCusto(LParametrosPrecoCustoMargemMarkup);
end;

function TGerarTestePrecoCusto.CalcularPrecoCustoRealVenda(
  const ADados: TUniClientDataSet): IResultadoServicosClassePrecoCusto;
var
  LPrecoVenda: Double;
  LIcmsSaida: Double;
  LOutrosValores: Double;
  LParametrosPrecoCustoRealVenda: IParametrosCalculoPrecoCustoRealVenda;
begin
  LPrecoVenda    := RetornarPrecoVenda(ADados);
  LIcmsSaida     := RetornarIcmsDeSaida(ADados);
  LOutrosValores := RetornarOutrosValores(ADados);

  FTipoAbfCliente := RetornarTipoAbreviacaoCliente;

  LParametrosPrecoCustoRealVenda :=
    TParametrosCalculoPrecoCustoRealVenda.New
      .PrecoDeVenda(LPrecoVenda)
      .PrecoDeCusto(ADados.FieldByName('DET_TOTCUS').AsFloat)
      .OutrosValores(LOutrosValores)
      .IcmsDeSaida(LIcmsSaida)
      .ImpostosFederais(ADados.FieldByName('ITE_IMPFED').AsFloat)
      .DespesasOperacionais(ADados.FieldByName('ITE_DESOPE').AsFloat)
      .AliquotaDoDifal(ADados.FieldByName('ICD_ALQUFD').AsFloat)
      .AliquotaDoFcp(ADados.FieldByName('ICD_PERFCP').AsFloat)
      .TaxaDeJuros(0);

  Result := GetFaturamentoPrecosService.PrecoCusto.CalculaPrecoCustoRealVenda(LParametrosPrecoCustoRealVenda);
end;

procedure TGerarTestePrecoCusto.CasosTestesLogPrecoCustoMargemMarkup(
  ACasosTestesLogPrecoCusto: ICasosTestesLog;
  AResultadoComparacaoPrecoCustoMargemMarkup: TResultadoComparacao;
  ADados: TUniClientDataSet);
begin
  ACasosTestesLogPrecoCusto.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoPrecoCustoMargemMarkup)
      .RetornarNomeOperacao('REGRA_PRECOCUSTOMARGEMMARKUPOUPRODUTO')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(FTipoAbfCliente)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogPrecoCustoMargemMarkup)
  );
end;

procedure TGerarTestePrecoCusto.CasosTestesLogPrecoCustoRealVenda(
  ACasosTestesLogPrecoCusto: ICasosTestesLog;
  AResultadoComparacaoPrecoCustoReal: TResultadoComparacao;
  ADados: TUniClientDataSet);
begin
  ACasosTestesLogPrecoCusto.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoPrecoCustoReal)
      .RetornarNomeOperacao('REGRA_PRECOCUSTOREALVENDA')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento(ADados.FieldByName('AUX_OPCDOC').AsString)
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal(FTipoAbfCliente)
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogPrecoCustoRealVenda)
  );
end;

function TGerarTestePrecoCusto.CompararResultadoPrecoCustoMargemMarkup(
  const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoPrecoCusto.ValorCalculadoPrecoCusto, (ADados.FieldByName('DET_TOTCUS').AsFloat / ADados.FieldByName('DET_QTDITE').AsFloat)) Then
  Begin
    Exit;
  End;

  Result := True;
end;

function TGerarTestePrecoCusto.CompararResultadoPrecoCustoRealVenda(
  const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoPrecoCusto.ValorCalculadoPrecoCusto, ADados.FieldByName('DET_TOTCU2').AsFloat) Then
  Begin
    Exit;
  End;

  Result := True;
end;

constructor TGerarTestePrecoCusto.Create;
begin

end;

destructor TGerarTestePrecoCusto.Destroy;
begin

  inherited;
end;

function TGerarTestePrecoCusto.fGerarTestePrecoCusto(
  const ADados: OleVariant): Boolean;
var
  LDados: TUniClientDataSet;
  LCasosTestesLogPrecoCustoRealVenda: ICasosTestesLog;
  LCasosTestesLogPrecoCustoMargemMarkup: ICasosTestesLog;
  LResultadoComparacaoPrecoCustoRealVenda: TResultadoComparacao;

{  LCasosTestesLogIcms             : ICasosTestesLog;
  LCasosTestesLogSt               : ICasosTestesLog;
  LCasosTestesLogIcmsOrgaoPublico : ICasosTestesLog;
  LCasosTestesLogStCustoAquisicao : ICasosTestesLog;

  LResultadoComparacaoIcms             : TResultadoComparacao;
  LResultadoComparacaoSt               : TResultadoComparacao;
  LResultadoComparacaoIcmsOrgaoPublico : TResultadoComparacao;
  LResultadoComparacaoStCustoAquisicao : TResultadoComparacao;

  FParametrosIcms               : IParametrosServicoIcmsSt;
  FMetodoArredondamentoICMSECF  : TMetodoArredondamentoICMSECF;

  LNotaEEspecialFornecedor      : Boolean;
  LUtilizarSatCFe               : Boolean;
  LClienteIndustria             : Boolean;
  LEstadoCliente                : String;

  LParametrosClienteConsumidor  : IParametrosFaturamentoImpostosClienteConsumidor;}
begin
  Result := True;

//  FMetodoArredondamentoICMSECF := Nil;

  LCasosTestesLogPrecoCustoRealVenda := TCasosTestesLog.New();
  LCasosTestesLogPrecoCustoMargemMarkup := TCasosTestesLog.New();
{  LCasosTestesLogSt   := TCasosTestesLog.New();
  LCasosTestesLogIcmsOrgaoPublico := TCasosTestesLog.New();
  LCasosTestesLogStCustoAquisicao := TCasosTestesLog.New();}

  LDados := TUniClientDataSet.Create(Nil);

  InicializarVariaveisRegistros;

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    FQuantidadeRegistro := frmModulo.Registros;

    frmModulo.Registros(frmModulo.Registros * 2);

    Try
      While Not LDados.Eof Do
      Begin
        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        FResultadoServicosClassePrecoCustoRealVenda := CalcularPrecoCustoRealVenda(LDados);
        ResultadoServicosClassePrecoCustoMargemMarkupOuProduto(LDados);
//        FResultadoServicosClassePrecoCustoMargemMarkup := CalcularPrecoCustoMargemMarkup(LDados);

        LResultadoComparacaoPrecoCustoRealVenda := ResultadoComparacaoPrecoCustoRealVenda(LDados);
//        LResultadoComparacaoPrecoCustoMargemMarkupOuProduto := ResultadoComparacaoPrecoCustoMargemMarkupOuProduto(LDados);

        pTesteUnitarioLogCustoRealVenda(FResultadoServicosClassePrecoCustoRealVenda, LDados);
        pTesteUnitarioLogCustoMargemMarkupOuProduto(FResultadoServicosClassePrecoCustoMargemMarkupOuProduto, LDados);
        ZerarRegistrosDoProcessamento;

        //Metodo CalculaPrecoCustoRealVenda
        CasosTestesLogPrecoCustoRealVenda(LCasosTestesLogPrecoCustoRealVenda, LResultadoComparacaoPrecoCustoRealVenda, LDados);
        TotalizarRegistrosProcessamentoPrecoCustoRealVenda;
        ZerarRegistrosDoProcessamento;

        //Metodo CalculaPrecoCusto(Parametros de margem markup)
        CasosTestesLogPrecoCustoMargemMarkup(LCasosTestesLogPrecoCustoMargemMarkup, FResultadoComparacaoPrecoCustoMargemMarkupOuProduto, LDados);
        TotalizarRegistrosProcessamentoPrecoCustoMargemMarkup;

        TotalizarRegistrosProcessamentoGeral;

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      frmModulo.Registros(FQuantidadeRegistro);

      SetarTotaisDoProcessamentoDoPrecoCustoRealVenda;
      LCasosTestesLogPrecoCustoRealVenda.GerarLog('PrecoCusto\PrecoCustoRealVenda');

      SetarTotaisDoProcessamentoDoPrecoCustoMargemMarkup;
      LCasosTestesLogPrecoCustoMargemMarkup.GerarLog('PrecoCusto\PrecoCustoMargemMarkup');

      SetarTotaisDoProcessamentoFinal;
    Except
      On E : Exception do
        pFinalizarProcessamentoComErro(LDados, E.Message);
    End;
  Finally
    FreeAndNil(LDados);
  End;
end;

procedure TGerarTestePrecoCusto.InicializarVariaveisRegistros;
begin
  FQuantidadeRegistro := 0;
  //Preco Custo Real Venda
  FQtdeRegistrosPrecoCustoRealVendaProcessados := 0;
  FQtdeRegistrosPrecoCustoRealVendaAcerto      := 0;
  FQtdeRegistrosPrecoCustoRealVendaErro        := 0;
  FQtdeRegistrosPrecoCustoRealVendaDuplicados  := 0;
  FQtdeRegistrosPrecoCustoRealVendaIgnorados   := 0;
  //Preco Custo Margem Markup
  FQtdeRegistrosPrecoCustoMargemMarkupProcessados := 0;
  FQtdeRegistrosPrecoCustoMargemMarkupAcerto      := 0;
  FQtdeRegistrosPrecoCustoMargemMarkupErro        := 0;
  FQtdeRegistrosPrecoCustoMargemMarkupDuplicados  := 0;
  FQtdeRegistrosPrecoCustoMargemMarkupIgnorados   := 0;
end;

//function TGerarTestePrecoCusto.ItemEspecialDocumentoNaoEhDevolucao(
//  const ADados: TUniClientDataSet): Boolean;
//begin
//  Result := False;
//
//  If (Pos(ADados.FieldByName('AUX_OPCDOC').AsString, 'DV_PR_') > 0) Then
//    Exit;
//
//  If (fGetValorConfiguracao('CUSESP', varBoolean)) Then
//    Exit;
//
//  If (Pos('ITEM ESPECIAL', ADados.FieldByName('ITE_DESITE').AsString) <= 0) Then
//    Exit;
//
//  Result := True;
//end;

class function TGerarTestePrecoCusto.New: IGerarTeste;
begin
  Result := Self.Create;
end;

function TGerarTestePrecoCusto.PodeAdicionarLogIgnoradasPrecoCusto(
  const ADados: TUniClientDataSet;
  const AResultadoCalculoPrecoCusto: IResultadoCalculoPrecoCusto): Boolean;
begin
  Result := True;

  If ValidarSeDeveAdicionarLogEspeciesIgnoradas(ADados) Then
    Exit;

  if ADados.FieldByName('DET_PROMOC').AsString = 'S' Then
    Exit;


  Result := False;
end;

procedure TGerarTestePrecoCusto.pTesteUnitarioLogCustoMargemMarkupOuProduto(
  AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto;
  ADados: TUniClientDataSet);
begin
//  pTesteUnitarioLogPrecoCusto(AResultadoServicosClassePrecoCusto, ADados, 'CalculaPrecoCusto');

 {Setando os Valores do CALCULO DE PRECO DE CUSTO MARGEM MARKUP}

  SetarResultadosComparacao(AResultadoServicosClassePrecoCusto.ResultadoCalculoPrecoCusto);

  SetarParametrosComparacao(
    TParametrosComparacaoPrecoCustoMargemMarkup.New()
      .TotalDoPrecoCusto(RetornarTOTCUS(ADados, AResultadoServicosClassePrecoCusto))); //ADados.FieldByName('DET_TOTCUS').AsFloat

  pGerarLogTesteUnitario(RetornarObjetoParametrosPrecoCusto(ADados, AResultadoServicosClassePrecoCusto),
    (AResultadoServicosClassePrecoCusto.ResultadoCalculoPrecoCusto as TObject), Nil, 'CalculaPrecoCusto');
end;

procedure TGerarTestePrecoCusto.pTesteUnitarioLogCustoRealVenda(
  AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto;
  ADados: TUniClientDataSet);
begin
//  pTesteUnitarioLogPrecoCusto(AResultadoServicosClassePrecoCusto, ADados, 'CalculaPrecoCustoRealVenda');

 {Setando os Valores do CALCULO DE PRECO DE CUSTO REAL VENDA}

  SetarResultadosComparacao(AResultadoServicosClassePrecoCusto.ResultadoCalculoPrecoCusto);

  SetarParametrosComparacao(
    TParametrosComparacaoPrecoCustoRealVenda.New()
      .TotalDoPrecoCustoRealVenda(ADados.FieldByName('DET_TOTCU2').AsFloat));

  pGerarLogTesteUnitario((AResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoRealVenda as TObject),
    (AResultadoServicosClassePrecoCusto.ResultadoCalculoPrecoCusto as TObject), Nil, 'CalculaPrecoCustoRealVenda');
end;

function TGerarTestePrecoCusto.ResultadoComparacaoPrecoCustoMargemMarkupOuProduto(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoPrecoCustoMargemMarkup(ADados);

  if ADados.FieldByName('DET_PROMOC').AsString = 'S' Then
    result := rcoIgnorado;

  //  If Not AdicionarLogEspeciesIgnoradasPrecoCustoMargemMarkup(ADados, Result, FResultadoServicosClassePrecoCustoMargemMarkup.ResultadoCalculoPrecoCusto) Then
//    Exit;
//
//  Result := rcoIgnorado;
end;

function TGerarTestePrecoCusto.ResultadoComparacaoPrecoCustoRealVenda(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoPrecoCustoRealVenda(ADados);

  If Not AdicionarLogEspeciesIgnoradasPrecoCustoRealVenda(ADados, Result, FResultadoServicosClassePrecoCustoRealVenda.ResultadoCalculoPrecoCusto) Then
    Exit;

  Result := rcoIgnorado;
end;

function TGerarTestePrecoCusto.ValidarSeDeveIgnorarRegistroDeTinta(const AIdentificacaoDoProduto: string): boolean;
begin
  Result := False;

  If (SameText(AIdentificacaoDoProduto, 'NOR')) then
    Exit;

  Result := True;
end;

function TGerarTestePrecoCusto.ValidarSeDeveIgnorarRegistro(const ADados: TUniClientDataSet): boolean;
begin
  result := True;

  If ValidarSeDeveIgnorarRegistroDeTinta(ADados.FieldByName('DET_IDEPRO').AsString) Then
    Exit;

  result := False;
end;

procedure TGerarTestePrecoCusto.ResultadoServicosClassePrecoCustoMargemMarkupOuProduto(const ADados: TUniClientDataSet);
begin
  FResultadoServicosClassePrecoCustoMargemMarkupOuProduto := CalcularPrecoCustoMargemMarkup(ADados);
  FResultadoComparacaoPrecoCustoMargemMarkupOuProduto     := ResultadoComparacaoPrecoCustoMargemMarkupOuProduto(ADados);

  If FResultadoComparacaoPrecoCustoMargemMarkupOuProduto = rcoTrue Then
    Exit;

  FResultadoServicosClassePrecoCustoMargemMarkupOuProduto := CalcularPrecoCustoProduto(ADados);
  FResultadoComparacaoPrecoCustoMargemMarkupOuProduto     := ResultadoComparacaoPrecoCustoMargemMarkupOuProduto(ADados);

  If FResultadoComparacaoPrecoCustoMargemMarkupOuProduto = rcoTrue Then
    Exit;

  If not ValidarSeDeveIgnorarRegistro(ADados) Then
    Exit;

  FResultadoComparacaoPrecoCustoMargemMarkupOuProduto := rcoIgnorado;
end;

function TConsultaPrecoCusto.RetornarColunaDET_ICMPAV(
  const ADoctosConfirmacao: Boolean): String;
begin
  Result := ' 0.00 AS DET_ICMPAV, ';

  if (ADoctosCOnfirmacao) then
    Exit;

  Result := ' T.DET_ICMPAV, ';
end;

function TGerarTestePrecoCusto.RetornarIcmsDeSaida(
  const ADados: TUniClientDataSet): Double;
begin
  If (fGetValorConfiguracao('IMPCF4', varBoolean)) And (fGetValorConfiguracao('RAICF4', varBoolean)) And (ADados.FieldByName('DET_PERBAS').AsFloat > 0) Then
  Begin
    Result := fFormataFloat((ADados.FieldByName('DET_ALQICM').AsFloat * ADados.FieldByName('DET_PERBAS').AsFloat) / 100, 2);
    Exit;
  End;

  If (objFloatUtils.fFormataFloat((ADados.FieldByName('DET_ICMSAI').AsFloat / ADados.FieldByName('DET_QTDITE').AsFloat),4)) = ADados.FieldByName('DET_ICMPAV').AsFloat Then
  Begin
    Result := 0;
    Exit;
  End;

  If (ADados.FieldByName('AUX_OPCDOC').AsString = '11') And (ADados.FieldByName('DET_NUM_PD').AsString = '') Or
     (fGetValorConfiguracao('IMPCF4') = 'S') And (Not fGetValorConfiguracao('RAICF4', varBoolean)) Then
  Begin
    Result := ADados.FieldByName('DET_ALQICM').AsFloat;
    Exit;
  End;

  Result := ADados.FieldByName('ITE_ICMSAI').AsFloat;
end;

function TGerarTestePrecoCusto.RetornarObjetoParametrosPrecoCusto(
  const ADados: TUniClientDataSet;
  const AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto): TObject;
begin
  If Assigned(AResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoMargemMarkup) Then
  Begin
    Result := (AResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoMargemMarkup as TObject);
    Exit;
  End;

  Result := (AResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCusto as TObject);
end;

function TGerarTestePrecoCusto.RetornarOutrosValores(
  const ADados: TUniClientDataSet): Double;
begin
  Result := ADados.FieldByName('ITE_OUTVAL').AsFloat + objFloatUtils.fFormataFloat((ADados.FieldByName('DET_ICMPAV').AsFloat * ADados.FieldByName('DET_QTDITE').AsFloat),4);

  If (objFloatUtils.fFormataFloat((ADados.FieldByName('DET_ICMSAI').AsFloat / ADados.FieldByName('DET_QTDITE').AsFloat),4)) = ADados.FieldByName('DET_ICMPAV').AsFloat Then
    Exit;

  Result := ADados.FieldByName('ITE_OUTVAL').AsFloat;
end;

function TGerarTestePrecoCusto.RetornarPrecoVenda(
  const ADados: TUniClientDataSet): Double;
begin
  If ADados.FieldByName('AUX_OPCDOC').AsString = 'BF' Then
  Begin
    Result := (ADados.FieldByName('DET_VLRCON').AsFloat); // * ADados.FieldByName('DET_QTDITE').AsFloat
    Exit;
  End;

  Result := ((ADados.FieldByName('DET_UNITAR').AsFloat * ADados.FieldByName('DET_QTDITE').AsFloat) - ADados.FieldByName('DET_DESESP').AsFloat);
end;

function TGerarTestePrecoCusto.RetornarResultadoComparacaoPrecoCustoMargemMarkup(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If Not CompararResultadoPrecoCustoMargemMarkup(FResultadoServicosClassePrecoCustoMargemMarkupOuProduto.ResultadoCalculoPrecoCusto, ADados) Then
    Exit;

  Result := rcoTrue;
end;

function TGerarTestePrecoCusto.RetornarResultadoComparacaoPrecoCustoRealVenda(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := rcoFalse;

  If Not CompararResultadoPrecoCustoRealVenda(FResultadoServicosClassePrecoCustoRealVenda.ResultadoCalculoPrecoCusto, ADados) Then
    Exit;

  Result := rcoTrue;
end;

function TGerarTestePrecoCusto.RetornarTipoAbreviacaoCliente: String;
begin
  Result := '';
//      fGetTipoAbfCliente(FDados.FieldByName('DET_CODCLI').AsString,
//                         FDados.FieldByName('GER_CONSUM').AsString,
//                         FDados.FieldByName('GER_IESCON').AsString,
//                         RetornarValidacaoClienteIndustria);
end;

function TGerarTestePrecoCusto.RetornarTOTCUS(const ADados: TUniClientDataSet;
  const AResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto): Double;
begin
  If Assigned(AResultadoServicosClassePrecoCusto.ParametrosCalculoPrecoCustoMargemMarkup) Then
  Begin
    Result := ADados.FieldByName('DET_TOTCUS').AsFloat;
    Exit;
  End;

  Result := (ADados.FieldByName('DET_TOTCUS').AsFloat / ADados.FieldByName('DET_QTDITE').AsFloat);
end;

//function TGerarTestePrecoCusto.RetornarValidacaoClienteIndustria: Boolean;
//begin
//  Result := False;
//    ValidarClienteIndustria(
//      FDados.FieldByName('AUX_TPOPER').AsString,
//      FDados.FieldByName('CLI_INDUST').AsString);
//end;

procedure TGerarTestePrecoCusto.SetarTotaisDoProcessamentoDoPrecoCustoMargemMarkup;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosPrecoCustoMargemMarkupProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosPrecoCustoMargemMarkupAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosPrecoCustoMargemMarkupErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosPrecoCustoMargemMarkupIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosPrecoCustoMargemMarkupDuplicados);
end;

procedure TGerarTestePrecoCusto.SetarTotaisDoProcessamentoDoPrecoCustoRealVenda;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosPrecoCustoRealVendaProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosPrecoCustoRealVendaAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosPrecoCustoRealVendaErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosPrecoCustoRealVendaIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosPrecoCustoRealVendaDuplicados);
end;

procedure TGerarTestePrecoCusto.SetarTotaisDoProcessamentoFinal;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosPrecoCustoRealVendaProcessados + FQtdeRegistrosPrecoCustoMargemMarkupProcessados);
  frmModulo.Registros(FQuantidadeRegistro * 2);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosPrecoCustoRealVendaAcerto + FQtdeRegistrosPrecoCustoMargemMarkupAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosPrecoCustoRealVendaErro + FQtdeRegistrosPrecoCustoMargemMarkupErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosPrecoCustoRealVendaIgnorados + FQtdeRegistrosPrecoCustoMargemMarkupIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosPrecoCustoRealVendaDuplicados + FQtdeRegistrosPrecoCustoMargemMarkupDuplicados);
end;

procedure TGerarTestePrecoCusto.TotalizarRegistrosProcessamentoGeral;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosPrecoCustoRealVendaProcessados + FQtdeRegistrosPrecoCustoMargemMarkupProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosPrecoCustoRealVendaAcerto + FQtdeRegistrosPrecoCustoMargemMarkupAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosPrecoCustoRealVendaErro + FQtdeRegistrosPrecoCustoMargemMarkupErro);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosPrecoCustoRealVendaDuplicados + FQtdeRegistrosPrecoCustoMargemMarkupDuplicados);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosPrecoCustoRealVendaIgnorados + FQtdeRegistrosPrecoCustoMargemMarkupIgnorados);
end;

procedure TGerarTestePrecoCusto.TotalizarRegistrosProcessamentoPrecoCustoMargemMarkup;
begin
  Inc(FQtdeRegistrosPrecoCustoMargemMarkupProcessados);
  FQtdeRegistrosPrecoCustoMargemMarkupAcerto     := FQtdeRegistrosPrecoCustoMargemMarkupAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosPrecoCustoMargemMarkupErro       := FQtdeRegistrosPrecoCustoMargemMarkupErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosPrecoCustoMargemMarkupDuplicados := FQtdeRegistrosPrecoCustoMargemMarkupDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosPrecoCustoMargemMarkupIgnorados  := FQtdeRegistrosPrecoCustoMargemMarkupIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

procedure TGerarTestePrecoCusto.TotalizarRegistrosProcessamentoPrecoCustoRealVenda;
begin
  Inc(FQtdeRegistrosPrecoCustoRealVendaProcessados);
  FQtdeRegistrosPrecoCustoRealVendaAcerto     := FQtdeRegistrosPrecoCustoRealVendaAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosPrecoCustoRealVendaErro       := FQtdeRegistrosPrecoCustoRealVendaErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosPrecoCustoRealVendaDuplicados := FQtdeRegistrosPrecoCustoRealVendaDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosPrecoCustoRealVendaIgnorados  := FQtdeRegistrosPrecoCustoRealVendaIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

function TGerarTestePrecoCusto.ValidarSeDeveAdicionarLogEspeciesIgnoradas(
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := True;

  If (ADados.FieldByName('AUX_OPCDOC').AsString = '') And (ADados.FieldByName('DET_CLAFIS').AsInteger < 5000) Then
    Exit;

  Result := False;
end;

procedure TGerarTestePrecoCusto.ZerarRegistrosDoProcessamento;
begin
  frmModulo.RegistrosProcessadosAcerto(0);
  frmModulo.RegistrosProcessadosErro(0);
  frmModulo.RegistrosProcessadosDuplicados(0);
  frmModulo.RegistrosProcessadosIgnorados(0);
end;

{ TConsultaPrecoCusto }

function TConsultaPrecoCusto.AjustaTabelasDocumentoConfirmacao(
  const ASQLTabelas: string): string;
begin
  Result := ASQLTabelas;
  Result := AnsiReplaceStr(Result, 'MOVGER', 'NOTGER');
  Result := AnsiReplaceStr(Result, 'MOVDET', 'NOTDET');
  Result := AnsiReplaceStr(Result, 'MOVTRI', 'NOTTRI');
  Result := AnsiReplaceStr(Result, 'MOVICD', 'NOTICD');
end;

function TConsultaPrecoCusto.fRetornarSQLPrecoCusto: String;
const
  UNION_ALL = ' UNION ALL ';
begin
  Result := EmptyStr;
  Result := Result + RetornarColunasSQL(False);
  Result := Result + RetornarTabelasSQL(False);
  Result := Result + RetornarFiltrosSQL;
  Result := Result + UNION_ALL;
  Result := Result + RetornarColunasSQL(True);
  Result := Result + RetornarTabelasSQL(True);
  Result := Result + RetornarFiltrosSQL;
end;

class function TConsultaPrecoCusto.New: IConsulta;
begin
  Result := Self.Create;
end;

function TConsultaPrecoCusto.RetornarColunasSQL(
  const ADoctosConfirmacao: boolean): String;
begin
  Result :=
    ' SELECT ' +
    '    D.DET_UNITAR, ' +
    '    D.DET_QTDITE, ' +
    '    D.DET_TOTCUS, ' +
    '    D.DET_TOTCU2, ' +
    '    D.DET_DESESP, ' +

    '    D.DET_NUMDOC, ' +
    '    D.DET_ESPDOC, ' +
    '    D.DET_CODEMP, ' +
    '    D.DET_CODITE, ' +
    '    D.DET_CODCLI, ' +

    '    D.DET_DTAENT, ' +
    '    D.DET_CLAFIS, ' +
    '    D.DET_CODFIS, ' +
    '    D.DET_ESTADO, ' +
    '    D.DET_IDEPRO, ' +
    '    D.DET_PROMOC, ' +

    RetornarColunaDET_ICMPAV(ADoctosConfirmacao) + //    '    T.DET_ICMPAV, ' +

    '    D.DET_ALQICM, ' +
    '    D.DET_NUM_PD, ' +
    '    D.DET_VLRCON, ' +
    '    D.DET_PERBAS, ' +

    '    T.DET_ICMSAI, ' +

    '    A.AUX_OPCDOC, ' +

    '    I.ITE_ICMSAI, ' +

    '    I.ITE_OUTVAL, ' +
//    '    IF(T.DET_ICMSAI > 0, IF(D.DET_ALQICM = 0, I.ITE_ICMSAI, D.DET_ALQICM), 0) AS ITE_ICMSAI, ' +
    '    I.ITE_IMPFED, ' +
    '    I.ITE_DESOPE, ' +

    '    C.ITE_DESITE, ' +

    '    I.ITE_PRECOM, ' +
    '    I.ITE_DESF01, ' +
    '    I.ITE_DESF02, ' +
    '    I.ITE_DESF03, ' +
    '    I.ITE_DESF04, ' +
    '    I.ITE_DESF05, ' +
    '    I.ITE_DESF06, ' +
//    '    I.ITE_DESF07, ' +
    '    I.ITE_ICMENT, ' +
    '    I.ITE_SUBFED, ' +
    '    I.ITE_IPIENT, ' +
    '    I.ITE_FREENT, ' +
    '    I.ITE_VALFRE, ' +
    '    I.ITE_ACRFIN, ' +
    '    I.ITE_SUBSTI, ' +
    '    I.ITE_DESADB, ' +

    '    I.ITE_TCIFCU, ' +
    '    I.ITE_TSCUST, ' +
    '    I.ITE_DEPICO, ' +
    '    I.ITE_DEICMS, ' +
    '    I.ITE_FATREG, ' +

    '    IF(ICD.ICD_ALQUFD > 0 AND ICD.ICD_BCUFDE > 0, ICD.ICD_ALQUFD - ICD.ICD_ALQINE, 0) AS ICD_ALQUFD, ' +
    '    ICD.ICD_PERFCP, ' +
    '    ICD.ICD_ALQINE  ';

  If Not ADoctosConfirmacao Then
    Exit;

  Result := AjustaTabelasDocumentoConfirmacao(Result);
end;

function TConsultaPrecoCusto.RetornarFiltrosSQL: string;
begin
  Result :=
    '  WHERE G.GER_CODEMP = :CODEMP       ' +
    '    AND G.GER_ORIDOC <> "D"          ' +
    '    AND G.GER_DTAENT BETWEEN :DTAINI ' +
    '                         AND :DTAFIM ' ;
end;

function TConsultaPrecoCusto.RetornarTabelasSQL(
  const ADoctosConfirmacao: boolean): string;
begin
  Result := ' FROM MOVGER G ' +
            ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ' +
            ' INNER JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE ' +
            ' INNER JOIN ITEGER I ON I.ITE_CODITE = D.DET_CODITE ' +
            '                    AND I.ITE_CODEMP = D.DET_CODEMP ' +
            ' LEFT JOIN AUXMOV A ON A.AUX_SEQGER  = D.DET_SEQGER ' +
            ' LEFT JOIN MOVTRI T  ON D.AUTOINCREM      = T.DET_SEQGER ' +
            ' LEFT JOIN MOVICD ICD ON D.AUTOINCREM     = ICD.ICD_SEQGER ';

  If (Not ADoctosConfirmacao) Then
    Exit;

  Result := AjustaTabelasDocumentoConfirmacao(Result);
end;

end.
