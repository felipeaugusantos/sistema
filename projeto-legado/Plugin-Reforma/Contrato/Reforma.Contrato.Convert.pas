unit Reforma.Contrato.Convert;

// Contrato do Convert (REFTRI-02, contrato 7): a tela e as regras ficam na DLL; o calculo e a gravacao de preco seguem
// o motor nativo de cada host (TPrecoProduto no 150.x, rotinas do cadastro no 72/74.111). Nenhuma excecao atravessa a
// fronteira: tudo devolve TResultadoGravacao.

interface

uses
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Gravacao,
  Reforma.Contrato.Host;

type
  TOpcaoConversao = (ocvRecalcularPrecoVenda, ocvRecalcularMargem);

  // mtcMantemPreco: Valor e o preco de venda; o host calcula a margem. mtcMantemMargem: Valor e a margem; o host
  // calcula o preco.
  TModoTabelaConversao = (mtcMantemPreco, mtcMantemMargem);

  TAlvoTabelaConversao = record
    Modo: TModoTabelaConversao;
    Valor: Double;
  end;

  TAlvosConversao = array[1..QUANTIDADE_TABELAS_PRECO] of TAlvoTabelaConversao;

  TValoresTabelasConversao = array[1..QUANTIDADE_TABELAS_PRECO] of Double;

  // Tudo que a DLL decide para o item da empresa logada. Os valores das demais empresas o host deriva (RN03 a RN08).
  TEntradaConversao = record
    CodigoItem: string;
    PrecoCompra: Double;
    DespesaOperacional: Double;
    Alvos: TAlvosConversao;
    // Comissao por tabela ja resolvida pela DLL (REFPRE ou ITEGER atual, RN09). O host grava antes de recalcular.
    Comissao: TValoresTabelasConversao;
  end;

  // Linha da ITEREF: valores de uma empresa para o item depois do calculo. Origem: 'L' logada, 'F' usa o preco da
  // logada, 'R' responsavel pelo fornecedor.
  TValoresConversao = record
    CodigoEmpresa: string;
    Origem: Char;
    PrecoCompra: Double;
    PrecoCusto: Double;
    ImpostoFederal: Double;
    SubFederal: Double;
    AliquotaFederal: Double;
    DespesaOperacional: Double;
    IcmsSaida: Double;
    OutrosValores: Double;
    PrecoVenda: TValoresTabelasConversao;
    MargemBruta: TValoresTabelasConversao;
    Comissao: TValoresTabelasConversao;
  end;

  TListaValoresConversao = array of TValoresConversao;

  // Um comando do lote: SQL com :PARAMETROS e os valores. Tipos aceitos no Valor: Null, inteiro, Double/Currency e
  // string. Data e hora vao como string ('yyyy-mm-dd' / 'hh:nn:ss'), nunca TDateTime.
  TComandoSql = record
    Sql: string;
    Parametros: TArray<TValorCampo>;
  end;

  IReformaProgresso = interface(IInvokable)
    ['{5A32D540-CBCD-4AF6-954C-01189ACFB05E}']
    procedure Definir(const Texto: string; const Maximo: Integer);
    procedure Avancar(const Quantidade: Integer);
  end;

  // Implementada pela DLL; o host executa dentro do frmGravando. Nao deixa excecao sair.
  IReformaTarefa = interface(IInvokable)
    ['{34CBDD60-2DA4-456D-9AA2-6F568959F496}']
    function Executar(const Progresso: IReformaProgresso): TResultadoGravacao;
  end;

  // Herda AbrirConsulta e Gravacao de IReformaBancoHost (contrato 6): a Convert.Estrutura recebe o host como banco.
  IReformaConvertHost = interface(IReformaBancoHost)
    ['{6C4BEC27-3C35-4128-A665-E52BA22D3F0F}']
    function CodigoEmpresa: string;
    function Operador: string;
    // fNow do host: data e hora gravadas (nunca a funcao de data do MySQL no SQL, RN17).
    function DataHora: TDateTime;
    // DECUNI limitado como TPrecoProduto.pCarregaConfiguracoes (4 quando passa das casas de ITE_PREVE1).
    function DecimaisUnitarios: Integer;
    // VS_strTabPrc: 'S'/'N' por tabela, 7 posicoes.
    function TabelasAtivas: string;
    // fRetEmpresasUsamPrecoMatriz da logada, sem a logada, separadas por ';' (vazio = nenhuma).
    function EmpresasPrecoMatriz: string;
    // True nos hosts com PREPRO (150.x).
    function UsaPrePro: Boolean;
    function ConfiguracaoTexto(const Chave: string): string;
    function EstiloVisual: string;
    // Handle da janela principal do autcom: dono da tela modal do Convert.
    function JanelaPrincipal: NativeUInt;
    procedure Mensagem(const Titulo, Texto: string);
    // Tratamento que devolve mais de um item: Texto e o cabecalho e Linhas a lista, na tela de log do host (TfrmLog).
    procedure MostrarLista(const Titulo, Texto: string; const Linhas: TArray<string>);
    function Confirmar(const Titulo, Texto: string): Boolean;
    function ExecutarComProgresso(const Titulo: string; const Tarefa: IReformaTarefa): TResultadoGravacao;
    // Varios comandos de uma vez (TBatchSQL do host: parametros viram literal e os comandos vao juntos, separados
    // por ';', num so ExecSQL). Exige transacao aberta. Mesmo caminho da efetivacao de precos 150.100
    // (FobjBatchPrePro), entao a LOGREP ja conhece esse formato.
    function ExecutarLote(const Comandos: TArray<TComandoSql>): TResultadoGravacao;
    // Motor nativo so em memoria: nada e gravado. Iniciar uma vez, CalcularItem por item, Finalizar no fim.
    function IniciarCalculo(const Opcao: TOpcaoConversao): TResultadoGravacao;
    function CalcularItem(const Entrada: TEntradaConversao; out Valores: TListaValoresConversao): TResultadoGravacao;
    procedure FinalizarCalculo;
    // Grava ITEREF (chave + lote) no produto pelas regras da familia. Exige transacao aberta (IniciarTransacao).
    function AplicarLote(const Chave: string; const Lote: Integer): TResultadoGravacao;
    // CFG_REFCIS = 'S' e limpeza do cache de configuracao. Exige transacao aberta.
    function AtivarReforma(const CodigoEmpresa: string): TResultadoGravacao;
    // Contrato 11 (Reverter; usuario, 2026-10-06): o AplicarLote ao contrario, com a ITEREO (valores de antes da
    // conversao) como origem, nas linhas ja aplicadas (REF_APLICADO = 'S') do lote. Mesma gravacao sem cascata, mesmo
    // historico (com um agrupador proprio, comecado no primeiro lote). Exige transacao aberta.
    function ReverterLote(const Chave: string; const Lote: Integer; const PrimeiroLote: Boolean): TResultadoGravacao;
    // CFG_REFCIS = 'N' e limpeza do cache de configuracao, o inverso de AtivarReforma. Exige transacao aberta.
    function DesativarReforma(const CodigoEmpresa: string): TResultadoGravacao;
    // Campos de custo (ITE_*, separados por ';') que a empresa da Origem ('F' usa o preco da logada, 'R' responsavel
    // pelo fornecedor) recebe da logada, como o cadastro de produtos desta versao; 'L': vazio. Nao inclui os que vem
    // calculados em TValoresConversao. A ITEREF dessas empresas guarda os valores da logada e o AplicarLote os grava.
    function CamposCustoDaLogada(const Origem: Char): string;
    // Contrato 10 (conversao por grupo de preco; usuario, 2026-10-06).
    // fRetEmpresasUsamPrecoMatriz como se a empresa indicada estivesse logada: ela primeiro, depois as que usam o preco
    // dela, separadas por ';'.
    function EmpresasPrecoDe(const CodigoEmpresa: string): string;
    // Troca a empresa logada sem senha e sem tela (variaveis globais e configuracoes da empresa, como a rotina
    // automatica do autcom). A tela do Convert troca no inicio de cada grupo e, no fim, volta para a original.
    function TrocarEmpresa(const CodigoEmpresa: string): TResultadoGravacao;
  end;

  // Contrato 11 (aba 4 "Calculo Convert" do cadastro de produtos; usuario, 2026-10-06): o calculo do Convert para o
  // produto em tela, para o operador 998 conferir antes de converter e, depois, comparar com a aba 1. O adaptador do
  // cadastro implementa; a DLL o pega de IReformaHost por Supports. Nada e gravado.
  IReformaCalculoConvert = interface(IInvokable)
    ['{AC61A986-2204-4E4E-A21D-EEC4470E47FF}']
    function Operador: string;
    // O mesmo DecimaisUnitarios de IReformaConvertHost (preco de compra com o desconto PIS/COFINS).
    function DecimaisUnitarios: Integer;
    // O CalcularItem do Convert (IniciarCalculo, CalcularItem, FinalizarCalculo), so a empresa logada. Base: campos do
    // produto pelo nome do ITEGER (ITE_PRECOM, ITE_PREVE1...) que entram no lugar dos gravados na linha do item lida do
    // banco, antes do calculo. O item tem de estar gravado.
    function CalcularItemBase(const Opcao: TOpcaoConversao; const Entrada: TEntradaConversao;
      const Base: TArray<TValorCampo>; out Valores: TValoresConversao): TResultadoGravacao;
  end;

implementation

end.
