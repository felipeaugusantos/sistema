unit Reforma.Contrato.Host;

// Unica unit compartilhada entre a DLL e os 4 hosts. Cada host implementa
// IReformaHost sobre as classes do proprio target; o plugin nao conhece
// ITEGER nem TPrecoProduto. Requer ShareMem nos dois lados por causa de string.

interface

uses
  Data.DB,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Gravacao;

type
  // As interfaces do contrato herdam de IInvokable (unit System, sem metodo algum) so para ganhar RTTI de
  // metodo: sem isso TRttiInterfaceType.GetMethods devolve vazio e Reforma.Contrato.Assinatura nao enxerga
  // nada para conferir. Nao muda vtable nem GUID das interfaces.
  IReformaConsulta = interface(IInvokable)
    ['{4FE9AFF2-F084-468D-B95D-1382313200ED}']
    procedure DefinirParametro(const Nome: string; const Valor: Variant);
    procedure Abrir;
    function Vazia: Boolean;
    function ValorCampo(const Nome: string): Variant;
    // Contrato 6: navegacao. Proximo avanca e devolve False quando acabou; Fim e o Eof.
    function Proximo: Boolean;
    function Fim: Boolean;
  end;

  // So o banco, sem o cadastro de produtos: a subida do autcom prepara as tabelas do plugin com isto
  // (export fReformaPrepararBanco). Consulta so SELECT; escrita so pela porta de gravacao (LOGREP).
  IReformaBancoHost = interface(IInvokable)
    ['{B97A4735-A82C-4FBB-8A97-754044F1DCD8}']
    function AbrirConsulta(const Sql: string): IReformaConsulta;
    function Gravacao: IReformaGravacao;
  end;

  // Produto em edicao no cadastro (lado Atual). Campos pelo nome fisico de ITEGER;
  // o valor ja vem resolvido pelo host. Campo inexistente devolve 0 / vazio.
  IDadosProduto = interface(IInvokable)
    ['{EA5F3D6F-22F0-4E80-8267-2BD157F7BC7D}']
    function CodigoItem: string;
    function Estado: TEstadoCadastro;
    function ValorNumerico(const Campo: string): Double;
    function ValorTexto(const Campo: string): string;
    // DisplayFormat do campo em ITEGER; vazio quando o host nao define um.
    function FormatoExibicao(const Campo: string): string;
    // DisplayLabel do campo em ITEGER: entra nas mensagens de faixa de valor.
    function RotuloCampo(const Campo: string): string;
    // TDataSource do produto no host (dtsIteGer). O lado Atual da aba 2 liga os controles
    // direto nele, como a calculadora. Passar o objeto entre exe e DLL funciona em leitura,
    // edicao e Post, mas cada modulo tem a sua copia de Data.DB: nunca usar "is"/"as" em
    // TField ou TDataSet recebidos do host.
    function FonteDados: TDataSource;
    // Roda a validacao do host para o controle da aba 1 que mantem o campo (pValidarPrecos).
    // Devolve False quando o host recusou o valor; a mensagem ja foi mostrada por ele.
    function ValidarCampo(const Campo: string): Boolean;
  end;

  // Custo do target: o plugin nao replica formula. FormulaCusto = 4 abre form do host.
  ICalculoCustoHost = interface(IInvokable)
    ['{D3CC1572-4BA3-4117-B212-481FB0D6433A}']
    function PrecoCompraLiquido(const Entrada: TCustoEntrada): Double;
    function PrecoCusto(const Entrada: TCustoEntrada): Double;
    // Com MargemMarkup = 4 devolve o IVA (fIVAMod4) no lugar do custo real, como a calculadora.
    function CustoReal(const Entrada: TCustoRealEntrada): Double;
  end;

  ICalculoMargemHost = interface(IInvokable)
    ['{7898D718-D935-47F6-A6E1-27DD000237C6}']
    function CalcularPrecoVenda(const Opcao: TOpcaoCalculo; const Entrada: TVendaEntrada): Double;
    // Com fator de preco ativo a tabela >= 2 nao e recalculada (RN05).
    function TabelaComFatorAtivo(const TabelaPreco: Integer): Boolean;
    // fMarkupToMargem do host: depende da precisao de margem do item.
    function MarkupParaMargem(const Markup: Double): Double;
    // Margem (opcao 2 do host) com as configuracoes de outra empresa: MARMKP, PCMPRO, DECUNI, estado e ABF do item
    // nela, como o host recalcula as filiais com CFG_INFMAT (replicacao da REFPRE, REFTRI-01).
    function MargemNaEmpresa(const CodigoEmpresa, CodigoItem: string; const Entrada: TVendaEntrada): Double;
  end;

  IReformaHost = interface(IInvokable)
    ['{031FE400-F12F-4693-A12C-439DF040374F}']
    function Configuracao: TConfiguracaoReforma;
    // fCfgSis por chave (DOVCPP, DESADI, PCMPRO...): a tela replica as decisoes da calculadora
    // com as mesmas chaves em vez de o host expor um flag por regra.
    function ConfiguracaoTexto(const Chave: string): string;
    function ConfiguracaoBooleana(const Chave: string): Boolean;
    // fGetUltimaCotacaoDolarVenda; 0 quando nao ha cotacao.
    function CotacaoDolarVenda: Double;
    function CodigoEmpresa: string;
    function Produto: IDadosProduto;
    function CalculoCusto: ICalculoCustoHost;
    function CalculoMargem: ICalculoMargemHost;
    function AbrirConsulta(const Sql: string): IReformaConsulta;
    // fStrToFloat do host: o pre-commit veda as conversoes nativas de texto para numero no plugin.
    function TextoParaNumero(const Texto: string): Double;
    procedure Mensagem(const Titulo, Texto: string);
    // O controle e da VCL da DLL: o host nao o enxerga como componente, so como handle de janela.
    procedure FocarControle(const Handle: NativeUInt);
    // Left/Top/Width/Height (relativos ao pai) do controle da aba 1 pelo nome que ele tem no host.
    // False quando o host nao tem o controle. A aba 3 usa isto para ficar igual a aba 1.
    function GeometriaControle(const Chave: string; out Esquerda, Topo, Largura, Altura: Integer): Boolean;
    // Nome do estilo VCL (skin) ativo no cadastro; vazio no modo classico. A DLL tem o proprio Vcl.Themes e
    // ativa o mesmo estilo nela, senao as abas ficam no visual classico dentro de um cadastro com skin.
    function EstiloVisual: string;
    // Font.Color do rotulo da aba 1 pelo nome que ele tem no host (o cadastro pinta alguns titulos conforme a
    // matriz de margem, PROMAT). False quando o host nao tem o rotulo. A aba 3 acompanha a aba 1.
    function CorRotulo(const Chave: string; out Cor: Integer): Boolean;
    // Porta de escrita no banco: quem grava e o host (gancho da LOGREP e transacao sao dele). Ver
    // Reforma.Contrato.Gravacao.
    function Gravacao: IReformaGravacao;
    // REFTRI-01: empresas e itens que a gravacao de CodigoItem alcancou (outras empresas e o grupo de preco
    // ITE_CODGPR), com a regra de cada um. Chamado dentro da transacao da gravacao, depois de o host gravar.
    function AlvosReplicacao(const CodigoItem: string): TAlvosReplicacao;
    // Produto ja gravado (na transacao corrente) em outra empresa; nil quando a empresa nao tem o item.
    function ProdutoNaEmpresa(const CodigoEmpresa, CodigoItem: string): IDadosProduto;
    // Contrato 13: direito de acesso do operador logado (fVerificaAcessoSistema), para as abas seguirem as travas da
    // aba 1 (EDTCUS). Host cuja versao nao tem o direito devolve True, como a aba 1 dele.
    function Acesso(const Direito: string): Boolean;
  end;

implementation

end.