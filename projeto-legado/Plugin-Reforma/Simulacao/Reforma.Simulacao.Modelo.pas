unit Reforma.Simulacao.Modelo;

// Dataset unico compartilhado pelas abas 2 e 3, como objPrecoCliente na calculadora:
// editar o preco de compra numa aba muda o mesmo campo na outra. Nada aqui e gravado
// em ITEGER (RN11). Com CFG_REFCIS = 'N' os parametros vao, por IReformaHost.Gravacao, para a REFPRE
// (Reforma.Repositorio.Refpre, REFTRI-01); com 'S', ou sem a tabela, o dataset vive so enquanto o cadastro estiver
// aberto (Reforma.Repositorio.Banco, REFTRI-02 RN20).

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, Data.DB, UniClientDataSet,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Contrato.Gravacao,
  Reforma.Calculo.Modelo,
  Reforma.Calculo.Formacao,
  Reforma.Aliquotas.Fonte,
  Reforma.Repositorio.Banco,
  Reforma.Repositorio.Refpre,
  Reforma.Simulacao.Replicacao;

type
  TSimulacaoReforma = class
  strict private
    FHost: IReformaHost;
    FCalculo: ICalculoFormacao;
    FFonteAliquotas: IFonteAliquotas;
    FDados: TUniClientDataSet;
    FFormacao: TFormacaoCusto;
    FOuvintes: TList<TNotifyEvent>;
    FRepositorio: IRepositorioSimulacao;
    // O mesmo objeto de FRepositorio com CFG_REFCIS = 'N' (quem o mantem vivo e a interface); nil com 'S'.
    FRefpre: TRepositorioRefpre;
    // CFG_REFCIS = 'N' (REFTRI-01): desconto PIS/COFINS 2027 ligado e persistencia na REFPRE. Lido uma vez.
    FUsaDescontoPisCofins: Boolean;
    // Assinatura dos campos gravaveis na ultima carga ou gravacao: Pendente = mudou desde entao.
    FBase: string;
    // Assinatura de todos os campos na ultima carga: o usuario digitou nas abas desde entao (vale tambem sem
    // persistencia, com CFG_REFCIS = 'S', em que FBase fica vazia).
    FBaseEdicao: string;
    // Os valores vieram da ITEREF: a aliquota gravada vale, IMPTRI nao a sobrescreve (RN01). A REFPRE nao
    // guarda aliquota, entao com ela isto fica False.
    FDoBanco: Boolean;
    // A ultima carga achou a linha do produto na REFPRE.
    FTemParametros: Boolean;
    // Aba 4 (CriarSomenteLeitura): os valores vem prontos do Convert (MostrarConvert); nada e digitado nem recalculado.
    FSomenteLeitura: Boolean;
    procedure pCriarCampos;
    procedure pAplicarFormatos;
    procedure pEditar;
    procedure pGravar(const Formacao: TFormacaoCusto);
    procedure pNotificar;
    function fLer: TFormacaoCusto;
    function fLerParametros: Boolean;
    function fAssinatura(const TodosOsCampos: Boolean = False): string;
    function fEditado: Boolean;
    function fMesmoCusto(const Anterior, Atual: TFormacaoCusto): Boolean;
    function fItemDoGrupoComRefpre(const CodigoItem: string): string;
  public
    constructor Create(const Host: IReformaHost);
    // Aba 4 "Calculo Convert": mesmos campos da aba 3, sem REFPRE e sem edicao.
    constructor CriarSomenteLeitura(const Host: IReformaHost);
    destructor Destroy; override;
    // Aba 4: mostra a formacao calculada pelo Convert, refazendo so o que a tela deriva dela (preco liquido, custo
    // real, preco cliente e custo de venda), como na carga de valores gravados.
    procedure MostrarConvert(const Formacao: TFormacaoCusto);
    // Equivale a pCopiaDadosIteger: copia o produto em edicao e deriva custo, preco de venda e margem.
    procedure Carregar;
    // Equivale a pCarregaAliquotas: relê IMPTRI e recalcula so o preco cliente.
    procedure CarregarAliquotas;
    procedure Recalcular(const Gatilho: TGatilhoRecalculo; const Tabela: Integer = 1);
    // REFTRI-01 com CFG_REFCIS = 'N': os campos que a REFPRE nao guarda nao sao digitados nas abas 2 e 3, eles
    // seguem o produto. Refaz a formacao a partir do produto mantendo os parametros gravados ou digitados; sem
    // nenhum dos dois o lado Novo inteiro segue o produto (inclusao, heranca). Com 'S' so na inclusao, enquanto
    // nada foi digitado nas abas 2 e 3, o lado Novo volta a ser carregado do produto.
    procedure SincronizarProduto;
    // Com CFG_REFCIS = 'N' so os campos gravados na REFPRE sao digitaveis nas abas 2 e 3, mais o preco de venda com
    // impostos (ITE_PRECLn), que vira preco de venda e margem (grPrecoCliente); com 'S', todos.
    function CampoEditavel(const NomeCampo: string): Boolean;
    // Aba 4: a margem desta tabela e a que o Convert vai ler da REFPRE (a linha gravada tem a tabela, ou ha alteracao
    // pendente, que o cadastro grava com as 7 tabelas).
    function MargemNaRefpre(const Tabela: Integer): Boolean;
    function EmEdicao: Boolean;
    // A calculadora mostra a margem com 8 casas ao entrar no campo e com 2 ao sair.
    procedure DefinirFormatoMargem(const Tabela, Digitos: Integer);
    // Fator Tabela (RN12) nao mora no dataset: FATPRE nao e coluna de ITEGER (no host e um
    // CAST(NULL) no SELECT, calculado em memoria), entao nada ha para gravar nem persistir.
    // A aba grava o valor digitado direto na formacao e manda recalcular por grFatorTabela.
    procedure DefinirFatorTabela(const Tabela: Integer; const Valor: Double);
    // True quando a simulacao mudou desde a carga e ha onde gravar.
    function Pendente: Boolean;
    // O que o host pergunta antes de gravar o produto (fReformaPendente): Pendente, ou produto sem linha na REFPRE e
    // sem nada digitado, que ainda pode receber a REFPRE do grupo de preco na gravacao (Persistir).
    function GravacaoPendente: Boolean;
    // Grava pela porta do host. Nao zera Pendente: so a recarga depois do commit do cadastro o faz, para uma
    // gravacao desfeita (rollback do produto) ser tentada de novo na proxima vez. O codigo vem do host na
    // gravacao (RN08 do REFTRI-01): na inclusao ele so existe depois que o cadastro o gera.
    function Persistir(const CodigoItem: string): TResultadoGravacao;
    // Cancelamento da edicao: volta ao que esta gravado, ou ao produto quando nao ha gravacao.
    procedure Descartar;
    // Normalizar ao abrir a aba (aliquotas, revalidacao) mexe nos valores sem ser edicao do usuario: quem
    // estava sem pendencia continua sem.
    procedure ExecutarSemMarcar(const Acao: TProc);
    property Dados: TUniClientDataSet read FDados;
    property Formacao: TFormacaoCusto read FFormacao;
    // CFG_REFCIS = 'N': as abas mostram o desconto PIS/COFINS e a aba 3 edita o preco com desconto.
    property UsaDescontoPisCofins: Boolean read FUsaDescontoPisCofins;
    // Aba 4 (CriarSomenteLeitura).
    property SomenteLeitura: Boolean read FSomenteLeitura;
    // As duas abas assinam para reexibir os campos calculados que nao sao data-aware.
    procedure AdicionarOuvinte(const Ouvinte: TNotifyEvent);
    procedure RemoverOuvinte(const Ouvinte: TNotifyEvent);
  end;

// Estrutura de campos da simulacao, compartilhada com a consulta da conversao (REFTRI-03, ITEREO/ITEREF): mesmos
// nomes, entao a aba 2 liga os mesmos controles em qualquer um dos datasets. Cria e abre o dataset vazio.
procedure pCriarCamposFormacao(const Dados: TUniClientDataSet);
// Mascaras e rotulos dos campos iguais aos do produto no host (IDadosProduto.FormatoExibicao).
procedure pAplicarFormatosFormacao(const Dados: TDataSet; const Produto: IDadosProduto);
// Formacao a partir do registro corrente de um dataset com os campos de pCriarCamposFormacao. Base traz o que nao
// mora no dataset (custo real, custo de venda, lado, estado); o desconto PIS/COFINS so entra com UsaDescontoPisCofins.
function fLerFormacao(const Dados: TDataSet; const Base: TFormacaoCusto;
  const UsaDescontoPisCofins: Boolean): TFormacaoCusto;

implementation

uses
  System.Math,
  System.Variants;

const
  CAMPOS_NUMERICOS: array[0..24] of string = (
    'ITE_PRECOM', 'ITE_DESF01', 'ITE_DESF02', 'ITE_DESF03', 'ITE_DESF04', 'ITE_DESF05',
    'ITE_DESF06', 'ITE_ICMENT', 'ITE_IPIENT', 'ITE_FREENT', 'ITE_ACRFIN', 'ITE_SUBSTI',
    'ITE_VALFRE', 'ITE_DESADB', 'ITE_TCIFCU', 'ITE_TSCUST', 'ITE_DEPICO', 'ITE_DEICMS',
    'ITE_FATREG', 'ITE_PRECUS', 'ITE_OUTVAL', 'ITE_ICMSAI', 'ITE_DESOPE', 'ITE_SUBFED',
    'ITE_IMPFED');

  CAMPOS_POR_TABELA: array[0..3] of string = ('ITE_PREVE', 'ITE_MARBR', 'ITE_COMTB', 'ITE_PRECL');

constructor TSimulacaoReforma.Create(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
  FCalculo := TCalculoFormacao.Create(Host);
  FFonteAliquotas := TFonteAliquotasImptri.Create(Host);
  FOuvintes := TList<TNotifyEvent>.Create;
  // Com CFG_REFCIS = 'N' so a REFPRE e lida e gravada; com 'S' a simulacao fica so em memoria (REFTRI-02, RN20).
  FUsaDescontoPisCofins := not Host.ConfiguracaoBooleana('REFCIS');
  if FUsaDescontoPisCofins then
  begin
    FRefpre := TRepositorioRefpre.Create(Host);
    FRepositorio := FRefpre;
  end
  else
    FRepositorio := TRepositorioSemPersistencia.Create;
  FDados := TUniClientDataSet.Create(nil);
  pCriarCampos;
end;

// A aba 4 so existe antes da conversao (CFG_REFCIS = 'N'): mostra o desconto PIS/COFINS como a aba 3.
constructor TSimulacaoReforma.CriarSomenteLeitura(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
  FSomenteLeitura := True;
  FCalculo := TCalculoFormacao.Create(Host);
  FFonteAliquotas := TFonteAliquotasImptri.Create(Host);
  FOuvintes := TList<TNotifyEvent>.Create;
  FUsaDescontoPisCofins := True;
  FRepositorio := TRepositorioSemPersistencia.Create;
  FDados := TUniClientDataSet.Create(nil);
  pCriarCampos;
end;

procedure TSimulacaoReforma.MostrarConvert(const Formacao: TFormacaoCusto);
var
  Calculada: TFormacaoCusto;
begin
  Calculada := Formacao;
  Calculada.Estado := FHost.Produto.Estado;
  FCalculo.Recalcular(Calculada, grCarga);
  if FDados.IsEmpty then
    FDados.Append;
  pGravar(Calculada);
  FDados.Post;
  FFormacao := Calculada;
  pAplicarFormatos;
  pNotificar;
end;

destructor TSimulacaoReforma.Destroy;
begin
  FRepositorio := nil;
  FreeAndNil(FDados);
  FreeAndNil(FOuvintes);
  inherited Destroy;
end;

procedure pCriarCamposFormacao(const Dados: TUniClientDataSet);
var
  Campo: string;
  Tabela: Integer;
  Indice: Integer;
begin
  for Campo in CAMPOS_NUMERICOS do
    Dados.FieldDefs.Add(Campo, ftFloat);
  Dados.FieldDefs.Add('ITE_CBS', ftFloat);
  Dados.FieldDefs.Add('ITE_IBS', ftFloat);
  Dados.FieldDefs.Add('ITE_IS', ftFloat);
  Dados.FieldDefs.Add('ITE_PREDOL', ftString, 1);
  // Desconto PIS/COFINS 2027 e preco de compra com ele (REFTRI-01): nao existem no produto.
  Dados.FieldDefs.Add('ITE_DPISCO', ftFloat);
  Dados.FieldDefs.Add('ITE_PRELIQ', ftFloat);

  for Indice := Low(CAMPOS_POR_TABELA) to High(CAMPOS_POR_TABELA) do
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      Dados.FieldDefs.Add(CAMPOS_POR_TABELA[Indice] + IntToStr(Tabela), ftFloat);

  Dados.CreateDataSet;
end;

procedure pAplicarFormatosFormacao(const Dados: TDataSet; const Produto: IDadosProduto);

  procedure pFormatar(const Campo, Origem: string; const CopiarRotulo: Boolean = True);
  var
    Formato: string;
    Rotulo: string;
  begin
    Formato := Produto.FormatoExibicao(Origem);
    if Formato <> '' then
      (Dados.FieldByName(Campo) as TFloatField).DisplayFormat := Formato;

    if not CopiarRotulo then
      Exit;

    Rotulo := Produto.RotuloCampo(Origem);
    if Rotulo <> '' then
      Dados.FieldByName(Campo).DisplayLabel := Rotulo;
  end;

var
  Campo: string;
  Tabela: Integer;
begin
  for Campo in CAMPOS_NUMERICOS do
    pFormatar(Campo, Campo);

  // CBS, IBS e IS nao existem no produto: herdam o formato do imposto federal.
  pFormatar('ITE_CBS', 'ITE_IMPFED');
  pFormatar('ITE_IBS', 'ITE_IMPFED');
  pFormatar('ITE_IS', 'ITE_IMPFED');

  // O desconto tem o formato de percentual da despesa operacional; o preco com desconto, o do preco de compra.
  pFormatar('ITE_DPISCO', 'ITE_DESOPE', False);
  pFormatar('ITE_PRELIQ', 'ITE_PRECOM', False);
  Dados.FieldByName('ITE_DPISCO').DisplayLabel := 'Desconto PIS/COFINS 2027';
  Dados.FieldByName('ITE_PRELIQ').DisplayLabel := 'Preço Líquido com Desconto';

  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    pFormatar('ITE_PREVE' + IntToStr(Tabela), 'ITE_PREVE' + IntToStr(Tabela));
    pFormatar('ITE_MARBR' + IntToStr(Tabela), 'ITE_MARBR' + IntToStr(Tabela));
    pFormatar('ITE_COMTB' + IntToStr(Tabela), 'ITE_COMTB' + IntToStr(Tabela));
    pFormatar('ITE_PRECL' + IntToStr(Tabela), 'ITE_PREVE' + IntToStr(Tabela));
  end;
end;

function fLerFormacao(const Dados: TDataSet; const Base: TFormacaoCusto;
  const UsaDescontoPisCofins: Boolean): TFormacaoCusto;

  function fNumero(const Campo: string): Double;
  begin
    Result := Dados.FieldByName(Campo).AsFloat;
  end;

var
  Indice: Integer;
  Sufixo: string;
begin
  Result := Base;

  Result.Custo.PrecoCompra := fNumero('ITE_PRECOM');
  for Indice := Low(Result.Custo.Descontos) to High(Result.Custo.Descontos) do
    Result.Custo.Descontos[Indice] := fNumero('ITE_DESF0' + IntToStr(Indice));
  Result.Custo.IcmsEntrada := fNumero('ITE_ICMENT');
  Result.Custo.IpiEntrada := fNumero('ITE_IPIENT');
  Result.Custo.FreteEntrada := fNumero('ITE_FREENT');
  Result.Custo.ValorFrete := fNumero('ITE_VALFRE');
  Result.Custo.AcrescimoFinanceiro := fNumero('ITE_ACRFIN');
  Result.Custo.Substituicao := fNumero('ITE_SUBSTI');
  Result.Custo.SubFederal := fNumero('ITE_SUBFED');
  Result.Custo.DescontoAdicional := fNumero('ITE_DESADB');
  Result.Custo.SuframaTcif := fNumero('ITE_TCIFCU');
  Result.Custo.SuframaTs := fNumero('ITE_TSCUST');
  Result.Custo.SuframaDescontoPisCofins := fNumero('ITE_DEPICO');
  Result.Custo.SuframaDescontoIcms := fNumero('ITE_DEICMS');
  Result.Custo.SuframaFatorRegional := fNumero('ITE_FATREG');
  Result.Custo.ConverterMoeda := Dados.FieldByName('ITE_PREDOL').AsString = 'S';
  // Com CFG_REFCIS = 'S' nao ha desconto: o preco com desconto sai igual ao preco de compra.
  if UsaDescontoPisCofins then
    Result.DescontoPisCofins := fNumero('ITE_DPISCO')
  else
    Result.DescontoPisCofins := 0;
  Result.PrecoCompraComDesconto := fNumero('ITE_PRELIQ');

  Result.PrecoCusto := fNumero('ITE_PRECUS');
  Result.OutrosValores := fNumero('ITE_OUTVAL');
  Result.IcmsSaida := fNumero('ITE_ICMSAI');
  Result.ImpostoFederal := fNumero('ITE_IMPFED');
  Result.DespesaOperacional := fNumero('ITE_DESOPE');
  Result.Aliquotas.Cbs := fNumero('ITE_CBS');
  Result.Aliquotas.Ibs := fNumero('ITE_IBS');
  Result.Aliquotas.ImpostoSeletivo := fNumero('ITE_IS');

  for Indice := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    Sufixo := IntToStr(Indice);
    Result.Tabelas[Indice].PrecoVenda := fNumero('ITE_PREVE' + Sufixo);
    Result.Tabelas[Indice].MargemBruta := fNumero('ITE_MARBR' + Sufixo);
    Result.Tabelas[Indice].Comissao := fNumero('ITE_COMTB' + Sufixo);
    Result.Tabelas[Indice].PrecoCliente := fNumero('ITE_PRECL' + Sufixo);
  end;
end;

procedure TSimulacaoReforma.pCriarCampos;
begin
  pCriarCamposFormacao(FDados);
end;

procedure TSimulacaoReforma.pAplicarFormatos;
begin
  pAplicarFormatosFormacao(FDados, FHost.Produto);
end;

procedure TSimulacaoReforma.pEditar;
begin
  if not (FDados.State in dsEditModes) then
    FDados.Edit;
end;

procedure TSimulacaoReforma.pNotificar;
var
  Ouvinte: TNotifyEvent;
begin
  for Ouvinte in FOuvintes do
    Ouvinte(Self);
end;

procedure TSimulacaoReforma.AdicionarOuvinte(const Ouvinte: TNotifyEvent);
begin
  FOuvintes.Add(Ouvinte);
end;

procedure TSimulacaoReforma.RemoverOuvinte(const Ouvinte: TNotifyEvent);
begin
  FOuvintes.Remove(Ouvinte);
end;

function TSimulacaoReforma.fAssinatura(const TodosOsCampos: Boolean): string;
var
  Indice: Integer;
  Campo: TField;
begin
  // Seis casas: abaixo disso e ruido de recalculo, nao edicao.
  Result := '';
  for Indice := 0 to FDados.FieldCount - 1 do
  begin
    Campo := FDados.Fields[Indice];
    if TodosOsCampos or FRepositorio.Gravado(Campo.FieldName) then
    begin
      if Campo.DataType = ftString then
        Result := Result + Campo.AsString + '|'
      else
        Result := Result + FormatFloat('0.000000', Campo.AsFloat) + '|';
    end;
  end;
end;

function TSimulacaoReforma.fEditado: Boolean;
begin
  Result := (FBaseEdicao <> '') and (fAssinatura(True) <> FBaseEdicao);
end;

function TSimulacaoReforma.fLer: TFormacaoCusto;
begin
  // Parte do ultimo calculo para manter o que nao mora no dataset (custo real, custo de venda).
  Result := fLerFormacao(FDados, FFormacao, FUsaDescontoPisCofins);
  Result.Estado := FHost.Produto.Estado;
end;

procedure TSimulacaoReforma.pGravar(const Formacao: TFormacaoCusto);
var
  Indice: Integer;
  Sufixo: string;
begin
  pEditar;

  FDados.FieldByName('ITE_PRECOM').AsFloat := Formacao.Custo.PrecoCompra;
  for Indice := Low(Formacao.Custo.Descontos) to High(Formacao.Custo.Descontos) do
    FDados.FieldByName('ITE_DESF0' + IntToStr(Indice)).AsFloat := Formacao.Custo.Descontos[Indice];
  FDados.FieldByName('ITE_ICMENT').AsFloat := Formacao.Custo.IcmsEntrada;
  FDados.FieldByName('ITE_IPIENT').AsFloat := Formacao.Custo.IpiEntrada;
  FDados.FieldByName('ITE_FREENT').AsFloat := Formacao.Custo.FreteEntrada;
  FDados.FieldByName('ITE_VALFRE').AsFloat := Formacao.Custo.ValorFrete;
  FDados.FieldByName('ITE_ACRFIN').AsFloat := Formacao.Custo.AcrescimoFinanceiro;
  FDados.FieldByName('ITE_SUBSTI').AsFloat := Formacao.Custo.Substituicao;
  FDados.FieldByName('ITE_SUBFED').AsFloat := Formacao.Custo.SubFederal;
  FDados.FieldByName('ITE_DESADB').AsFloat := Formacao.Custo.DescontoAdicional;
  FDados.FieldByName('ITE_TCIFCU').AsFloat := Formacao.Custo.SuframaTcif;
  FDados.FieldByName('ITE_TSCUST').AsFloat := Formacao.Custo.SuframaTs;
  FDados.FieldByName('ITE_DEPICO').AsFloat := Formacao.Custo.SuframaDescontoPisCofins;
  FDados.FieldByName('ITE_DEICMS').AsFloat := Formacao.Custo.SuframaDescontoIcms;
  FDados.FieldByName('ITE_FATREG').AsFloat := Formacao.Custo.SuframaFatorRegional;
  if Formacao.Custo.ConverterMoeda then
    FDados.FieldByName('ITE_PREDOL').AsString := 'S'
  else
    FDados.FieldByName('ITE_PREDOL').AsString := 'N';
  FDados.FieldByName('ITE_DPISCO').AsFloat := Formacao.DescontoPisCofins;
  FDados.FieldByName('ITE_PRELIQ').AsFloat := Formacao.PrecoCompraComDesconto;

  FDados.FieldByName('ITE_PRECUS').AsFloat := Formacao.PrecoCusto;
  FDados.FieldByName('ITE_OUTVAL').AsFloat := Formacao.OutrosValores;
  FDados.FieldByName('ITE_ICMSAI').AsFloat := Formacao.IcmsSaida;
  FDados.FieldByName('ITE_IMPFED').AsFloat := Formacao.ImpostoFederal;
  FDados.FieldByName('ITE_DESOPE').AsFloat := Formacao.DespesaOperacional;
  FDados.FieldByName('ITE_CBS').AsFloat := Formacao.Aliquotas.Cbs;
  FDados.FieldByName('ITE_IBS').AsFloat := Formacao.Aliquotas.Ibs;
  FDados.FieldByName('ITE_IS').AsFloat := Formacao.Aliquotas.ImpostoSeletivo;

  for Indice := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    Sufixo := IntToStr(Indice);
    FDados.FieldByName('ITE_PREVE' + Sufixo).AsFloat := Formacao.Tabelas[Indice].PrecoVenda;
    FDados.FieldByName('ITE_MARBR' + Sufixo).AsFloat := Formacao.Tabelas[Indice].MargemBruta;
    FDados.FieldByName('ITE_COMTB' + Sufixo).AsFloat := Formacao.Tabelas[Indice].Comissao;
    FDados.FieldByName('ITE_PRECL' + Sufixo).AsFloat := Formacao.Tabelas[Indice].PrecoCliente;
  end;
end;

// Copia o produto para o dataset e deixa o repositorio trocar os parametros gravados (REFPRE); a formacao
// passa a partir deles. Sem linha ou sem tabela nada muda e o desconto fica 0.
function TSimulacaoReforma.fLerParametros: Boolean;
begin
  pGravar(FFormacao);
  Result := FRepositorio.Ler(FHost.Produto.CodigoItem, FDados);
  if Result then
    FFormacao := fLer;
end;

procedure TSimulacaoReforma.Carregar;
var
  Parametros: Boolean;
  Gravadas: array[1..QUANTIDADE_TABELAS_PRECO] of TTabelaPreco;
  Tabela: Integer;
begin
  FFormacao := FCalculo.Carregar(FHost.Produto, lsFuturo, FFonteAliquotas.Obter);

  if FDados.IsEmpty then
    FDados.Append;

  // REFPRE (RN05 do REFTRI-01): desconto, despesa operacional e comissoes gravados entram antes do calculo
  // inicial, para o custo ja sair com eles.
  Parametros := not FRepositorio.GuardaFormacaoCompleta and fLerParametros;
  FTemParametros := Parametros;
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    Gravadas[Tabela] := FFormacao.Tabelas[Tabela];

  FCalculo.Recalcular(FFormacao, grInicial);

  // As tabelas voltam com o preco de venda e a margem gravados; so o preco cliente delas e refeito.
  if Parametros then
  begin
    // Tabela sem preco informado na REFPRE (NULL) segue o carregamento inicial, como sem linha.
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      if FRefpre.TabelaLida[Tabela] then
      begin
        FFormacao.Tabelas[Tabela].PrecoVenda := Gravadas[Tabela].PrecoVenda;
        FFormacao.Tabelas[Tabela].MargemBruta := Gravadas[Tabela].MargemBruta;
      end;
    FCalculo.Recalcular(FFormacao, grCargaParametros);
  end;

  pGravar(FFormacao);
  // pCopiaDadosIteger termina em Post; a edicao volta quando a aba pede o recalculo.
  FDados.Post;

  // A simulacao gravada substitui os valores derivados do produto; so o que o banco nao guarda e recalculado.
  FDoBanco := FRepositorio.GuardaFormacaoCompleta and FRepositorio.Ler(FHost.Produto.CodigoItem, FDados);
  if FDoBanco then
  begin
    FFormacao := fLer;
    FCalculo.Recalcular(FFormacao, grCarga);
    pGravar(FFormacao);
    FDados.Post;
  end;
  FBase := fAssinatura;
  FBaseEdicao := fAssinatura(True);

  pAplicarFormatos;
  pNotificar;
end;

procedure TSimulacaoReforma.CarregarAliquotas;
var
  Aliquotas: TAliquotasReforma;
begin
  if FDados.IsEmpty or FDoBanco or FSomenteLeitura then
    Exit;

  Aliquotas := FFonteAliquotas.Obter;
  pEditar;
  FDados.FieldByName('ITE_CBS').AsFloat := Aliquotas.Cbs;
  FDados.FieldByName('ITE_IBS').AsFloat := Aliquotas.Ibs;
  FDados.FieldByName('ITE_IS').AsFloat := Aliquotas.ImpostoSeletivo;
  FFormacao := fLer;
  pNotificar;
end;

procedure TSimulacaoReforma.Recalcular(const Gatilho: TGatilhoRecalculo; const Tabela: Integer);
var
  Calculada: TFormacaoCusto;
begin
  if FDados.IsEmpty or FSomenteLeitura then
    Exit;

  pEditar;
  Calculada := fLer;
  FCalculo.Recalcular(Calculada, Gatilho, Tabela);
  pGravar(Calculada);
  FFormacao := Calculada;
  pNotificar;
end;

// O que a conta de venda le do custo (MontarEntradaVenda): sem mudanca nisso as tabelas ficam como estavam.
function TSimulacaoReforma.fMesmoCusto(const Anterior, Atual: TFormacaoCusto): Boolean;
begin
  Result := SameValue(Anterior.PrecoCusto, Atual.PrecoCusto) and
    SameValue(Anterior.PrecoCompraLiquido, Atual.PrecoCompraLiquido) and
    SameValue(Anterior.IcmsSaida, Atual.IcmsSaida) and
    SameValue(Anterior.OutrosValores, Atual.OutrosValores) and
    SameValue(Anterior.Custo.IpiEntrada, Atual.Custo.IpiEntrada);
end;

// Sem linha na REFPRE e sem parametro digitado (inclusao, inclusao por heranca, produto que nunca foi gravado na
// REFPRE) o lado Novo e o produto, como na carga sem linha: a aba 1 preenchida depois da carga - os precos
// herdados, por exemplo - aparece inteira no Novo, inclusive despesa, margem, preco e comissao da tabela 1.
// Com linha ou com parametro digitado sao os mesmos passos da carga com a REFPRE, com os parametros tirados da
// propria simulacao em vez do banco: desconto, despesa operacional e comissoes antes do grInicial, preco de venda e
// margem das tabelas depois. Se o custo mudou, as tabelas seguem o CFG_VENMAR (grSincronizacaoProduto).
// Sem linha na REFPRE espelhar o produto nao marca pendencia (nao cria a linha so por isso). Com linha marca: o
// preco ou a margem da tabela 1 que mudou com o custo tem de ser regravado, senao a proxima carga traria o par
// antigo.
procedure TSimulacaoReforma.SincronizarProduto;
var
  Anterior: TFormacaoCusto;
  Pendencia: Boolean;
  Tabela: Integer;
begin
  if FDados.IsEmpty then
    Exit;

  Pendencia := (FBase <> '') and (fAssinatura <> FBase);

  // CFG_REFCIS = 'S': o lado Novo e simulacao livre. So na inclusao, sem nada digitado nele, ele acompanha o
  // produto: a carga foi feita com o produto vazio, e os precos chegam depois (inclusao por heranca).
  if not FUsaDescontoPisCofins then
  begin
    if (FHost.Produto.Estado = ecInclusao) and not fEditado then
      Carregar;
    Exit;
  end;

  pEditar;
  Anterior := fLer;

  FFormacao := FCalculo.Carregar(FHost.Produto, lsFuturo, Anterior.Aliquotas);

  if not FTemParametros and not Pendencia then
    FCalculo.Recalcular(FFormacao, grInicial)
  else
  begin
    FFormacao.DescontoPisCofins := Anterior.DescontoPisCofins;
    FFormacao.DespesaOperacional := Anterior.DespesaOperacional;
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      FFormacao.Tabelas[Tabela].Comissao := Anterior.Tabelas[Tabela].Comissao;
    FCalculo.Recalcular(FFormacao, grInicial);

    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      FFormacao.Tabelas[Tabela].PrecoVenda := Anterior.Tabelas[Tabela].PrecoVenda;
      FFormacao.Tabelas[Tabela].MargemBruta := Anterior.Tabelas[Tabela].MargemBruta;
    end;
    if fMesmoCusto(Anterior, FFormacao) then
      FCalculo.Recalcular(FFormacao, grCargaParametros)
    else
      FCalculo.Recalcular(FFormacao, grSincronizacaoProduto);
  end;

  pGravar(FFormacao);
  if not FTemParametros and not Pendencia and (FBase <> '') then
    FBase := fAssinatura;
  pNotificar;
end;

function TSimulacaoReforma.CampoEditavel(const NomeCampo: string): Boolean;
var
  Prefixo: string;
  Tabela: Integer;
begin
  if FSomenteLeitura then
    Exit(False);

  // CFG_FATPRE: margem e preco das tabelas 2 a 7 com fator ativo seguem a tabela 1 (TCalculoFormacao.AplicarFatorPreco),
  // como na aba 1, onde ficam somente leitura. O Fator Tabela (ITE_FATPR) tambem: o preco digitado por ele seria trocado
  // pelo da FATPRE no mesmo recalculo e a tela mostraria um fator que nao bate com o preco (DelphAI, 2026-10-15).
  Prefixo := UpperCase(Copy(NomeCampo, 1, Length(NomeCampo) - 1));
  Tabela := StrToIntDef(Copy(NomeCampo, Length(NomeCampo), 1), 0);
  if ((Prefixo = 'ITE_MARBR') or (Prefixo = 'ITE_PREVE') or (Prefixo = 'ITE_PRECL') or (Prefixo = 'ITE_FATPR')) and
     (Tabela >= 2) and
     (Tabela <= QUANTIDADE_TABELAS_PRECO) and FHost.CalculoMargem.TabelaComFatorAtivo(Tabela) then
    Exit(False);

  // Preco de venda com impostos (usuario, 2026-10-06): nao e coluna da REFPRE, mas digitado vira preco de venda e
  // margem, que ela grava.
  Result := not FUsaDescontoPisCofins or FRepositorio.Gravado(NomeCampo) or
    SameText(Copy(NomeCampo, 1, Length('ITE_PRECL')), 'ITE_PRECL');
end;

function TSimulacaoReforma.MargemNaRefpre(const Tabela: Integer): Boolean;
begin
  Result := FUsaDescontoPisCofins and Assigned(FRefpre) and FRefpre.Disponivel and
    (Pendente or FRefpre.TabelaLida[Tabela]);
end;

function TSimulacaoReforma.EmEdicao: Boolean;
begin
  Result := FDados.State in dsEditModes;
end;

procedure TSimulacaoReforma.DefinirFormatoMargem(const Tabela, Digitos: Integer);
begin
  (FDados.FieldByName('ITE_MARBR' + IntToStr(Tabela)) as TFloatField).DisplayFormat :=
    '#,##0.' + StringOfChar('0', Digitos);
end;

procedure TSimulacaoReforma.DefinirFatorTabela(const Tabela: Integer; const Valor: Double);
begin
  if (Tabela < 1) or (Tabela > QUANTIDADE_TABELAS_PRECO) then
    Exit;

  FFormacao.Tabelas[Tabela].FatorTabela := Valor;
end;

function TSimulacaoReforma.Pendente: Boolean;
begin
  Result := FDados.Active and (FBase <> '') and FRepositorio.Disponivel and (fAssinatura <> FBase);
end;

// Teste de 2026-10-15: item incluido (ou gravado) num grupo de preco (CADITE.ITE_CODGPR) cujos itens ja tem REFPRE
// ficava sem linha, e o Convert levava o calculo dele para o grupo todo. Sem linha e sem nada digitado a gravacao
// passa a acontecer, e o Persistir decide se ha o que gravar.
// Empresa que recebe os precos da matriz (PrecosDaMatriz): as abas 2 e 3 sao so consulta e a REFPRE dela vem da
// replicacao da matriz. Gravar o produto nela nao cria nem copia linha (DelphAI, 2026-10-15).
function TSimulacaoReforma.GravacaoPendente: Boolean;
begin
  Result := not FHost.Configuracao.PrecosDaMatriz and
    (Pendente or
     (FUsaDescontoPisCofins and not FSomenteLeitura and Assigned(FRefpre) and FDados.Active and not FTemParametros and
      FRefpre.Disponivel));
end;

// Outro item do mesmo grupo de preco com linha na REFPRE da logada: o de maior codigo, o mesmo que o Convert usa como
// ultimo do grupo (RN23). Vazio sem grupo, sem linha no grupo ou com falha na leitura (a gravacao do produto segue).
function TSimulacaoReforma.fItemDoGrupoComRefpre(const CodigoItem: string): string;
var
  Consulta: IReformaConsulta;
  Valor: Variant;
begin
  Result := '';
  if CodigoItem = '' then
    Exit;
  try
    Consulta := FHost.AbrirConsulta(
      'SELECT MAX(R.ITE_CODITE) AS ITEM_GRUPO' +
      '  FROM CADITE O' +
      ' INNER JOIN CADITE C ON C.ITE_CODGPR = O.ITE_CODGPR AND C.ITE_CODITE <> O.ITE_CODITE' +
      ' INNER JOIN REFPRE R ON R.ITE_CODEMP = :CODEMP AND R.ITE_CODITE = C.ITE_CODITE' +
      ' WHERE O.ITE_CODITE = :CODITE AND IFNULL(O.ITE_CODGPR, '''') <> ''''');
    Consulta.DefinirParametro('CODEMP', FHost.CodigoEmpresa);
    Consulta.DefinirParametro('CODITE', CodigoItem);
    Consulta.Abrir;
    if Consulta.Vazia then
      Exit;
    Valor := Consulta.ValorCampo('ITEM_GRUPO');
    if not VarIsNull(Valor) and not VarIsEmpty(Valor) then
      Result := Trim(VarToStr(Valor));
  except
    // Excecao do host: classe de outro modulo. Sem a leitura o item fica sem linha, como antes.
    Result := '';
  end;
end;

// Com a REFPRE, a linha gravada acompanha o que o cadastro fez com os precos nas outras empresas e no grupo de preco
// (Reforma.Simulacao.Replicacao). Falha em qualquer linha devolve False: o host desfaz a gravacao inteira.
function TSimulacaoReforma.Persistir(const CodigoItem: string): TResultadoGravacao;
var
  Replicacao: TReplicacaoRefpre;
  ItemDoGrupo: string;
begin
  // Sem nada digitado e sem linha (GravacaoPendente): so grava quando o grupo de preco ja tem REFPRE. A linha do outro
  // item entra no dataset e segue o caminho normal (gravar e replicar), como se tivesse sido digitada.
  if not Pendente then
  begin
    Result.Sucesso := True;
    Result.LinhasAfetadas := 0;
    Result.Mensagem := '';
    if not Assigned(FRefpre) or not FDados.Active or FHost.Configuracao.PrecosDaMatriz then
      Exit;
    ItemDoGrupo := fItemDoGrupoComRefpre(CodigoItem);
    if (ItemDoGrupo = '') or not FRefpre.Ler(ItemDoGrupo, FDados) then
      Exit;
  end;

  Result := FRepositorio.Gravar(CodigoItem, FDados);
  if not Result.Sucesso or not Assigned(FRefpre) or (CodigoItem = '') or not FRefpre.Disponivel then
    Exit;

  Replicacao := TReplicacaoRefpre.Create(FHost, FCalculo, FRefpre);
  try
    Result := Replicacao.Replicar(CodigoItem, FRefpre.ValoresDoDataset(FDados), FFormacao.Aliquotas);
  finally
    Replicacao.Free;
  end;
end;

procedure TSimulacaoReforma.Descartar;
begin
  if FDados.Active then
    Carregar;
end;

procedure TSimulacaoReforma.ExecutarSemMarcar(const Acao: TProc);
var
  Pendencia: Boolean;
  Editado: Boolean;
begin
  Pendencia := Pendente;
  Editado := fEditado;
  Acao();
  if (not Pendencia) and (FBase <> '') then
    FBase := fAssinatura;
  if not Editado then
    FBaseEdicao := fAssinatura(True);
end;

end.