unit Reforma.Contrato.Exportacao;

// Assinaturas das funcoes exportadas por libReformaPrecos.dll.
// O host carrega por LoadLibrary/GetProcAddress (padrao untInicializarDllAutTin).
// Handles em NativeUInt: nenhuma classe atravessa a fronteira.

interface

uses
  Reforma.Contrato.Host,
  Reforma.Contrato.Convert;

const
  NOME_DLL = 'libReformaPrecos.dll';

  // Sobe a cada mudanca de Reforma.Contrato.* (interface, record, assinatura de export). O host
  // compara com o valor devolvido pela DLL antes de qualquer outra chamada e, se diferir, nao
  // carrega o plugin: exe e DLL precisam ser compilados do mesmo contrato.
  // v4: TConfiguracaoReforma.TabelaPadrao (Fator Tabela, RN12) - campo em tipo de RETORNO de
  // IReformaHost.Configuracao, a assinatura RTTI (fDescricaoMetodo) nao pega isso sozinha; bump
  // manual obrigatorio e recompilar DLL + os 5 hosts juntos (ver plan.md Secao 1.1).
  // v5 (REFTRI-01): TReformaGravar recebe o codigo do item. Export fica fora da assinatura RTTI: bump manual.
  // v6: IReformaConsulta.Proximo/Fim, IReformaBancoHost e export fReformaPrepararBanco (estrutura do banco na subida
  // do autcom); replicacao da REFPRE (AlvosReplicacao, ProdutoNaEmpresa, MargemNaEmpresa).
  // v7 (REFTRI-02): pReformaAbrirConvert recebe IReformaConvertHost; export fReformaConvertDisponivel. Bump manual.
  // v8 (REFTRI-03): export obrigatorio fReformaAbaVisivel (a DLL decide se a aba 3 aparece). Bump manual.
  // v9 (REFTRI-02): IReformaConvertHost.MostrarLista (lista de itens na tela de log do host).
  // v10 (REFTRI-02): IReformaConvertHost.EmpresasPrecoDe/TrocarEmpresa (conversao por grupo de preco).
  // v11 (REFTRI-02): aba 4 "Calculo Convert" (IReformaCalculoConvert e exports fReformaCriarAba4/fReformaCriarAba4Grid);
  // Reverter (IReformaConvertHost.ReverterLote/DesativarReforma).
  // v12 (REFTRI-02): fReformaConvertDisponivel recebe operador e data (menu so para o 998 ou a partir de 26/12/2026).
  // v13 (teste de 2026-10-15): IReformaHost.Acesso (EDTCUS nas abas 2 e 3); campos virtuais CAMPO_PERCENTUAL_TARE e
  // CAMPO_USA_TARE (Reducao TARE na aba 3); PrecosDaMatriz passa a vir do host (abas 2 e 3 so de consulta).
  VERSAO_CONTRATO = 13;

  EXPORT_VERSAO      = 'fReformaVersaoContrato';

  EXPORT_INICIALIZAR = 'pReformaInicializar';
  EXPORT_CRIAR_ABA2  = 'fReformaCriarAba2';
  EXPORT_CRIAR_ABA3  = 'fReformaCriarAba3';
  // Variante da aba 3 para hosts cuja aba 1 e grid vertical multi-record (familia 150.x).
  // Mesma assinatura de TReformaCriarAba; export adicional, nao substitui EXPORT_CRIAR_ABA3.
  EXPORT_CRIAR_ABA3_GRID = 'fReformaCriarAba3Grid';
  // Aba 4 "Calculo Convert" (contrato 11): classica (72/74.111) e grid vertical (150.x). So aparece quando
  // fReformaAbaVisivel(4) da True (operador 998, antes da conversao).
  EXPORT_CRIAR_ABA4 = 'fReformaCriarAba4';
  EXPORT_CRIAR_ABA4_GRID = 'fReformaCriarAba4Grid';
  EXPORT_CARREGAR    = 'pReformaCarregar';
  EXPORT_ENTRAR_ABA  = 'pReformaEntrarAba';
  EXPORT_ATUALIZAR_ATUAL = 'pReformaAtualizarAtual';
  EXPORT_CONFIRMAR_EDICAO = 'pReformaConfirmarEdicao';
  EXPORT_FINALIZAR   = 'pReformaFinalizar';
  EXPORT_PENDENTE    = 'fReformaPendente';
  EXPORT_GRAVAR      = 'pReformaGravar';
  EXPORT_DESCARTAR   = 'pReformaDescartar';
  EXPORT_ABRIR_CONVERT = 'pReformaAbrirConvert';
  EXPORT_PREPARAR_BANCO = 'fReformaPrepararBanco';
  EXPORT_CONVERT_DISPONIVEL = 'fReformaConvertDisponivel';
  EXPORT_ABA_VISIVEL = 'fReformaAbaVisivel';
  // Assinatura estrutural (RTTI) do contrato: ver Reforma.Contrato.Assinatura. O loader a confere depois
  // de carregar os demais exports, mesmo com VERSAO_CONTRATO igual.
  EXPORT_ASSINATURA = 'fReformaAssinaturaContrato';

type
  TReformaVersaoContrato = function: Integer; stdcall;

  TReformaInicializar = procedure(const Host: IReformaHost); stdcall;

  // Recebe o handle da aba vazia criada pelo host e devolve o handle do frame criado.
  TReformaCriarAba = function(const PaiHandle: NativeUInt): NativeUInt; stdcall;

  // Chamado quando o produto em edicao muda: equivale a pCopiaDadosIteger da calculadora.
  TReformaCarregar = procedure(const CodigoItem: string); stdcall;

  // Chamado ao entrar na aba 2 ou 3 (pgcPrecosChange): recarrega aliquotas e recalcula.
  TReformaEntrarAba = procedure(const Aba: Integer); stdcall;

  // O host chama quando o produto muda na aba 1 ou o estado de edicao do cadastro muda (consulta,
  // inclusao, alteracao): reexibe o lado Atual da aba 2 e habilita ou desabilita os campos das abas.
  TReformaAtualizarAtual = procedure; stdcall;

  // Dispara a validacao do campo que esta com foco na DLL. O host chama antes de gravar o produto e ao
  // trocar de aba; quando o foco sai para outro controle do host a propria DLL confirma o campo (gancho
  // de foco em Reforma.View.Hospedeira), sem o host precisar chamar.
  TReformaConfirmarEdicao = procedure; stdcall;

  TReformaFinalizar = procedure; stdcall;

  // True quando a simulacao (abas 2 e 3) foi alterada desde que foi carregada ou gravada e ha onde gravar.
  // O host so chama TReformaGravar quando isto der True.
  TReformaPendente = function: Boolean; stdcall;

  // O host chama dentro da transacao do cadastro, depois de gravar o produto: o plugin grava pela porta
  // IReformaHost.Gravacao. False devolve a mensagem; o host desfaz a transacao inteira (produto e plugin).
  // CodigoItem e o codigo do produto que o cadastro acabou de gravar: na inclusao ele so existe a partir da
  // gravacao, entao o plugin usa este e nao IDadosProduto.CodigoItem (REFTRI-01, RN08).
  TReformaGravar = function(const CodigoItem: string; out Mensagem: string): Boolean; stdcall;

  // Cancelamento da edicao do produto: a simulacao volta ao que esta gravado (ou ao produto, sem gravacao).
  TReformaDescartar = procedure; stdcall;

  // REFTRI-03: o host pergunta logo depois de TReformaInicializar, antes de criar as abas. False: o host nao cria a aba
  // e a esconde (TabVisible), e os atalhos a pulam. Hoje so a aba 3 some, com CFG_REFCIS = 'S'; a regra e da DLL.
  TReformaAbaVisivel = function(const Aba: Integer): Boolean; stdcall;

  // True quando esta DLL esta apta a fazer o Convert (o host so mostra o menu nesse caso).
  TReformaConvertDisponivel = function(const Operador: string; const Data: TDateTime): Boolean; stdcall;

  // Abre a tela do Convert, modal sobre a janela principal. Direito de acesso e validacoes de empresa sao do host.
  // O Convert recebe o proprio host: nao depende de pReformaInicializar (cadastro de produtos).
  TReformaAbrirConvert = procedure(const Host: IReformaConvertHost); stdcall;

  // O host chama ao subir o autcom, com a DLL na pasta e sem transacao aberta: cria as tabelas do plugin que faltam e
  // acrescenta as colunas e os indices que faltam nas que existem (Reforma.Repositorio.Estrutura). False devolve o
  // motivo; o host decide se mostra. Nenhuma excecao sai da DLL.
  TReformaPrepararBanco = function(const Banco: IReformaBancoHost; out Mensagem: string): Boolean; stdcall;

  // Hash calculado por RTTI sobre as interfaces do contrato (Reforma.Contrato.Assinatura). O host compara
  // o valor que ele mesmo calcula (compilado do seu proprio Reforma.Contrato.*) com o que a DLL devolve:
  // diferente, mesmo com VERSAO_CONTRATO igual, significa que um dos dois foi compilado de um contrato com
  // estrutura diferente (campo, parametro ou metodo mudado sem o bump manual).
  TReformaAssinatura = function: Cardinal; stdcall;

implementation

end.