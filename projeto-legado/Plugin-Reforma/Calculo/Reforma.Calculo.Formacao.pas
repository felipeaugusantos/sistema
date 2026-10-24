unit Reforma.Calculo.Formacao;

// Formacao de custo dos lados Novo e Futuro. As formulas de custo e margem
// pertencem ao host de cada target (Suframa, PDISIF, TARE, credito de ICMS);
// aqui ficam so a ordem de recalculo e as contas iguais em todos os targets.
// Novo e Futuro usam a mesma conta na calculadora, entao um lado e apenas um
// parametro e nao uma segunda implementacao.

interface

uses
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Calculo.Modelo;

type
  // grInicial reproduz pCopiaDadosIteger da calculadora: o preco de venda do produto passa a ser o
  // preco pago pelo cliente e o preco de venda e derivado dele pelas aliquotas.
  // grExibicao so recalcula o custo de venda por tabela.
  // grCarga: os valores gravados (ITEREF) voltam como estavam; so o que o banco nao guarda (custo liquido,
  // custo real, preco cliente, custo de venda) e recalculado.
  // grFatorTabela: edicao do Fator Tabela (exclusivo 150.x, ver spec.md RN12) - o preco de venda da tabela
  // passa a ser derivado do preco da tabela padrao da empresa.
  // grPrecoLiquido: edicao do Preco de Compra da aba 3 com o desconto PIS/COFINS ligado (REFTRI-01, RN04) - o
  // valor digitado e o preco com desconto, e o preco de compra e refeito de tras para frente.
  // grCargaParametros: carga da REFPRE (REFTRI-01, RN05) - o grInicial ja rodou com os parametros gravados; as
  // tabelas voltaram com preco de venda e margem gravados e so o preco cliente delas e refeito.
  // grSincronizacaoProduto: o lado Novo voltou a espelhar o produto com CFG_REFCIS = 'N' (REFTRI-01) e o custo
  // mudou - como no grCargaParametros o grInicial ja rodou e as tabelas voltaram com os valores do Novo; elas refazem
  // o preco de venda ou a margem pelo CFG_VENMAR, como o cadastro faz ao mudar o custo, e o preco cliente.
  TGatilhoRecalculo = (grInicial, grCusto, grMargem, grComissao, grPrecoVenda, grPrecoCliente, grExibicao,
    grCarga, grFatorTabela, grPrecoLiquido, grCargaParametros, grSincronizacaoProduto);

  ICalculoFormacao = interface
    ['{A1E1E79C-109E-43B8-AE1A-9B34D547F08D}']
    function Carregar(const Produto: IDadosProduto; const Lado: TLadoSimulacao;
      const Aliquotas: TAliquotasReforma): TFormacaoCusto;
    // Tabela so importa para margem, comissao, preco de venda e preco cliente.
    procedure Recalcular(var Formacao: TFormacaoCusto; const Gatilho: TGatilhoRecalculo;
      const Tabela: Integer = 1);
    // Replicacao da REFPRE para outra empresa (REFTRI-01, CFG_INFMAT): a margem de cada tabela pelo custo do lado
    // Novo da formacao (preco com desconto, impostos federais zerados), mantendo o preco de venda. A conta de margem
    // e a do host com as configuracoes daquela empresa; sem a reducao TARE, que e da aba 1 da empresa logada.
    procedure RecalcularMargensNaEmpresa(var Formacao: TFormacaoCusto; const CodigoEmpresa, CodigoItem: string);
  end;

  TCalculoFormacao = class(TInterfacedObject, ICalculoFormacao)
  strict private
    FHost: IReformaHost;
    FConfiguracao: TConfiguracaoReforma;
    // CFG_FATPRE: fator de cada tabela (FATPRE.FAT_VALFAT), lido uma vez; 0 = sem fator lido.
    FFatoresLidos: Boolean;
    FFatores: array[1..QUANTIDADE_TABELAS_PRECO] of Double;
    procedure LerFatoresPreco;
    procedure AplicarFatorPreco(var Formacao: TFormacaoCusto);
    function MontarEntradaCusto(const Formacao: TFormacaoCusto): TCustoEntrada;
    function MontarEntradaVenda(const Formacao: TFormacaoCusto; const Tabela: Integer): TVendaEntrada;
    procedure AplicarTare(const Formacao: TFormacaoCusto; const Tabela: Integer;
      out PrecoCusto, IcmsSaida: Double);
    function CalcularVenda(const Formacao: TFormacaoCusto; const Opcao: TOpcaoCalculo;
      const Tabela: Integer): Double;
    function SomaAliquotas(const Formacao: TFormacaoCusto): Double;
    function PrecoComDesconto(const PrecoCompra, Desconto: Double): Double;
    function PrecoCompraPeloLiquido(const PrecoLiquido, Desconto: Double): Double;
    procedure AtualizarPrecoComDesconto(var Formacao: TFormacaoCusto);
    procedure AtualizarPrecoCompraPeloLiquido(var Formacao: TFormacaoCusto);
    procedure RecalcularCusto(var Formacao: TFormacaoCusto; const CalcularPrecoCusto: Boolean);
    procedure RecalcularTabela(var Formacao: TFormacaoCusto; const Tabela: Integer);
    procedure RecalcularTabelas(var Formacao: TFormacaoCusto);
    procedure RecalcularCustoReal(var Formacao: TFormacaoCusto);
    procedure RecalcularPrecoCliente(var Formacao: TFormacaoCusto; const Tabela: Integer);
    procedure RecalcularPrecosCliente(var Formacao: TFormacaoCusto);
    procedure RecalcularCustosVenda(var Formacao: TFormacaoCusto);
    procedure RecalcularFatoresTabela(var Formacao: TFormacaoCusto; const TabelaEditada: Integer);
    procedure ZerarImpostosFederais(var Formacao: TFormacaoCusto);
    procedure AtualizarPrecoVendaPeloCliente(var Formacao: TFormacaoCusto; const Tabela: Integer);
    procedure AtualizarPrecoVendaPeloFator(var Formacao: TFormacaoCusto; const Tabela: Integer);
  public
    constructor Create(const Host: IReformaHost);
    function Carregar(const Produto: IDadosProduto; const Lado: TLadoSimulacao;
      const Aliquotas: TAliquotasReforma): TFormacaoCusto;
    procedure Recalcular(var Formacao: TFormacaoCusto; const Gatilho: TGatilhoRecalculo;
      const Tabela: Integer = 1);
    procedure RecalcularMargensNaEmpresa(var Formacao: TFormacaoCusto; const CodigoEmpresa, CodigoItem: string);
  end;

implementation

uses
  System.SysUtils,
  System.Math,
  System.Variants,
  Reforma.Calculo.CustoVenda;

constructor TCalculoFormacao.Create(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
  FConfiguracao := Host.Configuracao;
end;

function TCalculoFormacao.Carregar(const Produto: IDadosProduto; const Lado: TLadoSimulacao;
  const Aliquotas: TAliquotasReforma): TFormacaoCusto;
var
  Indice: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);

  Result.Lado := Lado;
  Result.Estado := Produto.Estado;
  Result.Aliquotas := Aliquotas;

  Result.Custo.PrecoCompra := Produto.ValorNumerico('ITE_PRECOM');
  for Indice := Low(Result.Custo.Descontos) to High(Result.Custo.Descontos) do
    Result.Custo.Descontos[Indice] := Produto.ValorNumerico('ITE_DESF0' + IntToStr(Indice));
  Result.Custo.IcmsEntrada := Produto.ValorNumerico('ITE_ICMENT');
  Result.Custo.IpiEntrada := Produto.ValorNumerico('ITE_IPIENT');
  Result.Custo.FreteEntrada := Produto.ValorNumerico('ITE_FREENT');
  Result.Custo.ValorFrete := Produto.ValorNumerico('ITE_VALFRE');
  Result.Custo.AcrescimoFinanceiro := Produto.ValorNumerico('ITE_ACRFIN');
  Result.Custo.Substituicao := Produto.ValorNumerico('ITE_SUBSTI');
  Result.Custo.SubFederal := Produto.ValorNumerico('ITE_SUBFED');
  Result.Custo.DescontoAdicional := Produto.ValorNumerico('ITE_DESADB');
  Result.Custo.SuframaTcif := Produto.ValorNumerico('ITE_TCIFCU');
  Result.Custo.SuframaTs := Produto.ValorNumerico('ITE_TSCUST');
  Result.Custo.SuframaDescontoPisCofins := Produto.ValorNumerico('ITE_DEPICO');
  Result.Custo.SuframaDescontoIcms := Produto.ValorNumerico('ITE_DEICMS');
  Result.Custo.SuframaFatorRegional := Produto.ValorNumerico('ITE_FATREG');
  Result.Custo.ConverterMoeda := Produto.ValorTexto('ITE_PREDOL') = 'S';

  Result.OutrosValores := Produto.ValorNumerico('ITE_OUTVAL');
  Result.IcmsSaida := Produto.ValorNumerico('ITE_ICMSAI');
  Result.ImpostoFederal := Produto.ValorNumerico('ITE_IMPFED');
  Result.DespesaOperacional := Produto.ValorNumerico('ITE_DESOPE');

  for Indice := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    Result.Tabelas[Indice].PrecoVenda := Produto.ValorNumerico('ITE_PREVE' + IntToStr(Indice));
    Result.Tabelas[Indice].MargemBruta := Produto.ValorNumerico('ITE_MARBR' + IntToStr(Indice));
    Result.Tabelas[Indice].Comissao := Produto.ValorNumerico('ITE_COMTB' + IntToStr(Indice));
  end;
end;

// O host calcula o custo sobre o preco com desconto PIS/COFINS (REFTRI-01, RN02): a formula de custo de cada
// host nao muda. Sem desconto o preco com desconto e o proprio preco de compra.
function TCalculoFormacao.MontarEntradaCusto(const Formacao: TFormacaoCusto): TCustoEntrada;
begin
  Result := Formacao.Custo;
  Result.PrecoCompra := Formacao.PrecoCompraComDesconto;
end;

// Mesma conta de pCalculaPrecoLiquidoComDesconto da calculadora. Sem desconto o preco fica como esta, sem
// arredondar: com CFG_REFCIS = 'S' o custo tem de sair igual ao de antes do REFTRI-01. Desconto de 100% ou
// mais e recusado na tela; aqui so nao pode zerar o divisor do inverso.
function TCalculoFormacao.PrecoComDesconto(const PrecoCompra, Desconto: Double): Double;
begin
  if (Desconto <= 0) or (Desconto >= 100) then
    Result := PrecoCompra
  else
    Result := RoundTo(PrecoCompra * (1 - Desconto / 100), -FConfiguracao.DecimaisUnitarios);
end;

// Inverso do anterior (RN04): o preco de compra que, com o desconto, da o preco com desconto digitado.
function TCalculoFormacao.PrecoCompraPeloLiquido(const PrecoLiquido, Desconto: Double): Double;
begin
  if (Desconto <= 0) or (Desconto >= 100) then
    Result := PrecoLiquido
  else
    Result := RoundTo(PrecoLiquido / (1 - Desconto / 100), -FConfiguracao.DecimaisUnitarios);
end;

// So refaz o preco com desconto quando o preco de compra ou o desconto mudou: depois de grPrecoLiquido o
// preco de compra veio arredondado do inverso, e refazer daqui devolveria outro valor que nao o digitado.
procedure TCalculoFormacao.AtualizarPrecoComDesconto(var Formacao: TFormacaoCusto);
begin
  if (Formacao.Custo.PrecoCompra = Formacao.BasePrecoCompra) and
     (Formacao.DescontoPisCofins = Formacao.BaseDescontoPisCofins) then
    Exit;

  Formacao.PrecoCompraComDesconto := PrecoComDesconto(Formacao.Custo.PrecoCompra, Formacao.DescontoPisCofins);
  Formacao.BasePrecoCompra := Formacao.Custo.PrecoCompra;
  Formacao.BaseDescontoPisCofins := Formacao.DescontoPisCofins;
end;

// Preco com desconto que ja bate com o preco de compra (revalidacao ao entrar na aba 3) nao mexe no preco de
// compra: o inverso arredondado poderia move-lo sem o usuario ter editado nada.
procedure TCalculoFormacao.AtualizarPrecoCompraPeloLiquido(var Formacao: TFormacaoCusto);
begin
  if not SameValue(Formacao.PrecoCompraComDesconto,
                   PrecoComDesconto(Formacao.Custo.PrecoCompra, Formacao.DescontoPisCofins)) then
    Formacao.Custo.PrecoCompra := PrecoCompraPeloLiquido(Formacao.PrecoCompraComDesconto, Formacao.DescontoPisCofins);

  Formacao.BasePrecoCompra := Formacao.Custo.PrecoCompra;
  Formacao.BaseDescontoPisCofins := Formacao.DescontoPisCofins;
end;

// Reducao TARE da tabela, como a aba 1 do 150.x (TPrecoProduto.fCalculaPrecoCustoTare e fCalculaIcmSaiTabela):
// na tabela com TARE o custo e recalculado com o ICMS de entrada reduzido e o ICMS de saida cai pelo mesmo
// percentual. O Preco de Custo exibido fica sem a reducao, igual ao PRO_PRECUS da aba 1. O percentual vem do
// host (CAMPO_REDUCAO_TARE); zero nos hosts sem TARE, e entao nada muda.
procedure TCalculoFormacao.AplicarTare(const Formacao: TFormacaoCusto; const Tabela: Integer;
  out PrecoCusto, IcmsSaida: Double);
var
  Reducao: Double;
  Custo: TCustoEntrada;
begin
  PrecoCusto := Formacao.PrecoCusto;
  IcmsSaida := Formacao.IcmsSaida;

  if not Assigned(FHost.Produto) then
    Exit;

  Reducao := FHost.Produto.ValorNumerico(CAMPO_REDUCAO_TARE + IntToStr(Tabela));
  if Reducao = 0 then
    Exit;

  Custo := MontarEntradaCusto(Formacao);
  Custo.IcmsEntrada := Custo.IcmsEntrada * (100 - Reducao) / 100;
  PrecoCusto := FHost.CalculoCusto.PrecoCusto(Custo);
  IcmsSaida := IcmsSaida * (100 - Reducao) / 100;
end;

function TCalculoFormacao.MontarEntradaVenda(const Formacao: TFormacaoCusto;
  const Tabela: Integer): TVendaEntrada;
begin
  Result.TabelaPreco := Tabela;
  AplicarTare(Formacao, Tabela, Result.PrecoCusto, Result.IcmsSaida);
  Result.OutrosValores := Formacao.OutrosValores;
  Result.PrecoVenda := Formacao.Tabelas[Tabela].PrecoVenda;
  Result.MargemBruta := Formacao.Tabelas[Tabela].MargemBruta;
  Result.ImpostoFederal := Formacao.ImpostoFederal;
  Result.DespesaOperacional := Formacao.DespesaOperacional;
  Result.Comissao := Formacao.Tabelas[Tabela].Comissao;
  Result.PrecoCompraLiquido := Formacao.PrecoCompraLiquido;
  Result.IpiEntrada := Formacao.Custo.IpiEntrada;
end;

function TCalculoFormacao.CalcularVenda(const Formacao: TFormacaoCusto; const Opcao: TOpcaoCalculo;
  const Tabela: Integer): Double;
begin
  // Com fator de preco ativo a tabela >= 2 nao e recalculada, so a margem.
  if (Opcao = ocMargem) or (Tabela = 1) or not FHost.CalculoMargem.TabelaComFatorAtivo(Tabela) then
    Result := FHost.CalculoMargem.CalcularPrecoVenda(Opcao, MontarEntradaVenda(Formacao, Tabela))
  else if Opcao = ocPrecoVenda then
    Result := Formacao.Tabelas[Tabela].PrecoVenda
  else
    Result := Formacao.Tabelas[Tabela].MargemBruta;
end;

function TCalculoFormacao.SomaAliquotas(const Formacao: TFormacaoCusto): Double;
begin
  Result := (Formacao.Aliquotas.Cbs + Formacao.Aliquotas.Ibs + Formacao.Aliquotas.ImpostoSeletivo) / 100;
end;

procedure TCalculoFormacao.RecalcularCusto(var Formacao: TFormacaoCusto; const CalcularPrecoCusto: Boolean);
var
  Entrada: TCustoEntrada;
begin
  Entrada := MontarEntradaCusto(Formacao);
  Formacao.PrecoCompraLiquido := FHost.CalculoCusto.PrecoCompraLiquido(Entrada);

  if CalcularPrecoCusto then
    Formacao.PrecoCusto := FHost.CalculoCusto.PrecoCusto(Entrada);
end;

// CFG_VENMAR: 1 refaz o preco de venda pela margem, 2 a margem pelo preco. Na inclusao a tabela sem preco sempre
// ganha o preco calculado.
procedure TCalculoFormacao.RecalcularTabela(var Formacao: TFormacaoCusto; const Tabela: Integer);
begin
  if FConfiguracao.RecalculaPrecoPelaMargem or
     ((Formacao.Estado = ecInclusao) and (Formacao.Tabelas[Tabela].PrecoVenda = 0)) then
    Formacao.Tabelas[Tabela].PrecoVenda := CalcularVenda(Formacao, ocPrecoVenda, Tabela)
  else
    Formacao.Tabelas[Tabela].MargemBruta := CalcularVenda(Formacao, ocMargem, Tabela);
end;

procedure TCalculoFormacao.RecalcularTabelas(var Formacao: TFormacaoCusto);
var
  Tabela: Integer;
begin
  if FConfiguracao.PrecosDaMatriz then
    Exit;

  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    RecalcularTabela(Formacao, Tabela);
end;

procedure TCalculoFormacao.RecalcularCustoReal(var Formacao: TFormacaoCusto);
var
  Entrada: TCustoRealEntrada;
begin
  Entrada.PrecoCusto := Formacao.PrecoCusto;
  Entrada.OutrosValores := Formacao.OutrosValores;
  Entrada.IcmsSaida := Formacao.IcmsSaida;
  Entrada.ImpostoFederal := Formacao.ImpostoFederal;
  Entrada.DespesaOperacional := Formacao.DespesaOperacional;
  Formacao.CustoReal := FHost.CalculoCusto.CustoReal(Entrada);
end;

procedure TCalculoFormacao.RecalcularPrecoCliente(var Formacao: TFormacaoCusto; const Tabela: Integer);
begin
  Formacao.Tabelas[Tabela].PrecoCliente := RoundTo(
    Formacao.Tabelas[Tabela].PrecoVenda +
    Formacao.Tabelas[Tabela].PrecoVenda * (1 - Formacao.IcmsSaida / 100) * SomaAliquotas(Formacao),
    -FConfiguracao.DecimaisUnitarios);
end;

procedure TCalculoFormacao.RecalcularPrecosCliente(var Formacao: TFormacaoCusto);
var
  Tabela: Integer;
begin
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    RecalcularPrecoCliente(Formacao, Tabela);
end;

procedure TCalculoFormacao.AtualizarPrecoVendaPeloCliente(var Formacao: TFormacaoCusto;
  const Tabela: Integer);
var
  Divisor: Double;
begin
  // ICMS de saida acima de 100% com aliquotas altas zeraria ou inverteria o divisor: o preco fica.
  Divisor := 1 + (1 - Formacao.IcmsSaida / 100) * SomaAliquotas(Formacao);
  if Divisor <= 0 then
    Exit;

  // Quatro casas fixas, como pAtualizaPrecoVenda da calculadora: o inverso nao arredonda por DECUNI.
  Formacao.Tabelas[Tabela].PrecoVenda := RoundTo(Formacao.Tabelas[Tabela].PrecoCliente / Divisor, -4);
end;

procedure TCalculoFormacao.RecalcularCustosVenda(var Formacao: TFormacaoCusto);
var
  Tabela: Integer;
  PrecoCusto: Double;
  IcmsSaida: Double;
begin
  // Mesma TARE da venda: fCalculaCustoVendaTabela da aba 1 tambem usa o custo e o ICMS de saida reduzidos.
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    AplicarTare(Formacao, Tabela, PrecoCusto, IcmsSaida);
    Formacao.Tabelas[Tabela].CustoVenda := fCustoVenda(FConfiguracao, PrecoCusto,
      Formacao.OutrosValores, Formacao.Tabelas[Tabela].PrecoVenda, IcmsSaida,
      Formacao.ImpostoFederal, Formacao.DespesaOperacional, Formacao.Tabelas[Tabela].Comissao);
  end;
end;

// Fator Tabela = preco da tabela / preco da tabela padrao da empresa (EMP_TABPAD), 4 casas - mesma conta
// de fCalculaFatorPrecoTabela no host (untPrecoProduto.pas). A propria tabela padrao fica sem fator (o
// host deixa FATPRE nulo nela); TabelaEditada pula a tabela cujo fator o usuario acabou de digitar, para
// o arredondamento do preco nao devolver um fator diferente do que foi digitado.
// TabelaPadrao = 0 nos hosts sem fator de preco (72 e 74.111 nao preenchem): o metodo vira no-op.
procedure TCalculoFormacao.RecalcularFatoresTabela(var Formacao: TFormacaoCusto; const TabelaEditada: Integer);
var
  Tabela: Integer;
  PrecoPadrao: Double;
begin
  if (FConfiguracao.TabelaPadrao < 1) or (FConfiguracao.TabelaPadrao > QUANTIDADE_TABELAS_PRECO) then
    Exit;

  PrecoPadrao := Formacao.Tabelas[FConfiguracao.TabelaPadrao].PrecoVenda;

  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    if (Tabela = FConfiguracao.TabelaPadrao) or (Tabela = TabelaEditada) then
      Continue;

    if PrecoPadrao > 0 then
      Formacao.Tabelas[Tabela].FatorTabela := RoundTo(Formacao.Tabelas[Tabela].PrecoVenda / PrecoPadrao, -4)
    else
      Formacao.Tabelas[Tabela].FatorTabela := 0;
  end;

  Formacao.Tabelas[FConfiguracao.TabelaPadrao].FatorTabela := 0;
end;

// Inverso do anterior, como pAtualizaPrecoVendaFator no host: o preco segue o DECUNI do produto.
procedure TCalculoFormacao.AtualizarPrecoVendaPeloFator(var Formacao: TFormacaoCusto; const Tabela: Integer);
begin
  if (FConfiguracao.TabelaPadrao < 1) or (FConfiguracao.TabelaPadrao > QUANTIDADE_TABELAS_PRECO) then
    Exit;
  // A padrao nao tem fator, e sem preco nela o fator zeraria o preco da tabela.
  if (Tabela = FConfiguracao.TabelaPadrao) or (Formacao.Tabelas[FConfiguracao.TabelaPadrao].PrecoVenda <= 0) then
    Exit;

  Formacao.Tabelas[Tabela].PrecoVenda := RoundTo(
    Formacao.Tabelas[FConfiguracao.TabelaPadrao].PrecoVenda * Formacao.Tabelas[Tabela].FatorTabela,
    -FConfiguracao.DecimaisUnitarios);
end;

// Na Reforma os impostos federais dao lugar a CBS, IBS e IS: na simulacao eles valem zero, nao
// importa o que o produto tenha. Zerar aqui (e nao na carga) cobre tambem o caminho grCarga, em
// que a formacao volta de uma simulacao gravada antes desta regra existir.
procedure TCalculoFormacao.ZerarImpostosFederais(var Formacao: TFormacaoCusto);
begin
  Formacao.Custo.SubFederal := 0;
  Formacao.ImpostoFederal := 0;
end;

procedure TCalculoFormacao.RecalcularMargensNaEmpresa(var Formacao: TFormacaoCusto;
  const CodigoEmpresa, CodigoItem: string);
var
  Tabela: Integer;
  Entrada: TVendaEntrada;
begin
  ZerarImpostosFederais(Formacao);
  AtualizarPrecoComDesconto(Formacao);
  RecalcularCusto(Formacao, True);
  RecalcularCustoReal(Formacao);

  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    Entrada.TabelaPreco := Tabela;
    Entrada.PrecoCusto := Formacao.PrecoCusto;
    Entrada.OutrosValores := Formacao.OutrosValores;
    Entrada.PrecoVenda := Formacao.Tabelas[Tabela].PrecoVenda;
    Entrada.MargemBruta := Formacao.Tabelas[Tabela].MargemBruta;
    Entrada.IcmsSaida := Formacao.IcmsSaida;
    Entrada.ImpostoFederal := Formacao.ImpostoFederal;
    Entrada.DespesaOperacional := Formacao.DespesaOperacional;
    Entrada.Comissao := Formacao.Tabelas[Tabela].Comissao;
    Entrada.PrecoCompraLiquido := Formacao.PrecoCompraLiquido;
    Entrada.IpiEntrada := Formacao.Custo.IpiEntrada;
    Formacao.Tabelas[Tabela].MargemBruta := FHost.CalculoMargem.MargemNaEmpresa(CodigoEmpresa, CodigoItem, Entrada);
  end;
end;

// CFG_FATPRE (TFatorPreco do host): o fator de cada tabela vem da FATPRE da empresa. Quem diz se a tabela usa o fator
// e o host (TabelaComFatorAtivo); aqui so o valor. Falha na leitura deixa sem fator, como antes.
procedure TCalculoFormacao.LerFatoresPreco;
var
  Consulta: IReformaConsulta;
  Tabela: Integer;
begin
  FFatoresLidos := True;
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    FFatores[Tabela] := 0;
  try
    Consulta := FHost.AbrirConsulta('SELECT FAT_NUMFAT, FAT_VALFAT FROM FATPRE WHERE FAT_CODEMP = :CODEMP');
    Consulta.DefinirParametro('CODEMP', FHost.CodigoEmpresa);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Tabela := StrToIntDef(VarToStr(Consulta.ValorCampo('FAT_NUMFAT')), 0);
      if (Tabela >= 2) and (Tabela <= QUANTIDADE_TABELAS_PRECO) and not VarIsNull(Consulta.ValorCampo('FAT_VALFAT')) then
        FFatores[Tabela] := Consulta.ValorCampo('FAT_VALFAT');
      Consulta.Proximo;
    end;
  except
    // Excecao do host: classe de outro modulo. Sem a FATPRE as tabelas ficam como estavam.
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      FFatores[Tabela] := 0;
  end;
end;

// Teste de 2026-10-15: com CFG_FATPRE a aba 1 refaz o preco das tabelas 2 a 7 com fator ativo a partir do preco da
// tabela 1 (fCalculaPrecoVendaFator: preco 1 x fator, nas casas do DECUNI) e a margem pelo preco (opcao 2), como o
// Convert ja fazia. A aba 3 ficava com o preco antigo nessas tabelas ate a ativacao.
procedure TCalculoFormacao.AplicarFatorPreco(var Formacao: TFormacaoCusto);
var
  Tabela: Integer;
begin
  if not FFatoresLidos then
    LerFatoresPreco;

  for Tabela := 2 to QUANTIDADE_TABELAS_PRECO do
    if (FFatores[Tabela] > 0) and FHost.CalculoMargem.TabelaComFatorAtivo(Tabela) then
    begin
      Formacao.Tabelas[Tabela].PrecoVenda := SimpleRoundTo(Formacao.Tabelas[1].PrecoVenda * FFatores[Tabela],
        -FConfiguracao.DecimaisUnitarios);
      Formacao.Tabelas[Tabela].MargemBruta := CalcularVenda(Formacao, ocMargem, Tabela);
      RecalcularPrecoCliente(Formacao, Tabela);
    end;
end;

procedure TCalculoFormacao.Recalcular(var Formacao: TFormacaoCusto; const Gatilho: TGatilhoRecalculo;
  const Tabela: Integer);
var
  Indice: Integer;
begin
  // Gatilho por tabela fora de 1..7 indexaria Tabelas[] fora da faixa.
  if (Gatilho in [grMargem, grComissao, grPrecoVenda, grPrecoCliente, grFatorTabela]) and
     ((Tabela < 1) or (Tabela > QUANTIDADE_TABELAS_PRECO)) then
    Exit;

  ZerarImpostosFederais(Formacao);

  // O preco com desconto e a base de todo custo calculado abaixo, inclusive o da TARE no custo de venda.
  if Gatilho = grPrecoLiquido then
    AtualizarPrecoCompraPeloLiquido(Formacao)
  else
    AtualizarPrecoComDesconto(Formacao);

  case Gatilho of
    grInicial:
      begin
        RecalcularCusto(Formacao, True);
        // Sem isto o custo real fica 0 ate a primeira revalidacao (a aba 3 grid so roda grExibicao).
        RecalcularCustoReal(Formacao);
        for Indice := 1 to QUANTIDADE_TABELAS_PRECO do
        begin
          Formacao.Tabelas[Indice].PrecoCliente := Formacao.Tabelas[Indice].PrecoVenda;
          AtualizarPrecoVendaPeloCliente(Formacao, Indice);
          Formacao.Tabelas[Indice].MargemBruta := CalcularVenda(Formacao, ocMargem, Indice);
        end;
      end;
    grCusto, grPrecoLiquido:
      begin
        // pRecalculaPrecosNovo da calculadora sai antes de tocar em custo e tabelas (blnPreMat).
        RecalcularCusto(Formacao, not FConfiguracao.PrecosDaMatriz);
        RecalcularTabelas(Formacao);
        RecalcularCustoReal(Formacao);
      end;
    grMargem, grComissao:
      Formacao.Tabelas[Tabela].PrecoVenda := CalcularVenda(Formacao, ocPrecoVenda, Tabela);
    grPrecoVenda:
      Formacao.Tabelas[Tabela].MargemBruta := CalcularVenda(Formacao, ocMargem, Tabela);
    grPrecoCliente:
      begin
        AtualizarPrecoVendaPeloCliente(Formacao, Tabela);
        Formacao.Tabelas[Tabela].MargemBruta := CalcularVenda(Formacao, ocMargem, Tabela);
      end;
    grFatorTabela:
      begin
        AtualizarPrecoVendaPeloFator(Formacao, Tabela);
        Formacao.Tabelas[Tabela].MargemBruta := CalcularVenda(Formacao, ocMargem, Tabela);
      end;
    grCarga:
      begin
        RecalcularCusto(Formacao, False);
        RecalcularCustoReal(Formacao);
        RecalcularPrecosCliente(Formacao);
      end;
    grCargaParametros:
      RecalcularPrecosCliente(Formacao);
    grSincronizacaoProduto:
      begin
        RecalcularTabelas(Formacao);
        RecalcularPrecosCliente(Formacao);
      end;
  end;

  // Carga e exibicao mostram o que o produto ou a REFPRE tem; depois de qualquer edicao as tabelas com fator seguem a
  // tabela 1. Empresa que recebe os precos da matriz nao recalcula tabelas (RecalcularTabelas).
  if not (Gatilho in [grInicial, grExibicao, grCarga, grCargaParametros]) and not FConfiguracao.PrecosDaMatriz then
    AplicarFatorPreco(Formacao);

  // Editar o proprio preco cliente nao o recalcula, senao o arredondamento devolve outro valor.
  // No carregamento inicial o preco cliente e o preco do produto: recalcula-lo o trocaria. Na carga da REFPRE
  // e na sincronizacao com o produto o preco cliente ja foi refeito acima.
  if not (Gatilho in [grInicial, grPrecoCliente, grExibicao, grCarga, grCargaParametros,
                      grSincronizacaoProduto]) then
    RecalcularPrecosCliente(Formacao);

  RecalcularCustosVenda(Formacao);

  // grExibicao nao mexe em preco, entao nao refaz o fator: depois de grFatorTabela ele recalcularia o
  // fator digitado a partir do preco arredondado (1,1111 viraria 1,1100). O host mantem o digitado.
  if Gatilho = grFatorTabela then
    RecalcularFatoresTabela(Formacao, Tabela)
  else if Gatilho <> grExibicao then
    RecalcularFatoresTabela(Formacao, 0);
end;

end.