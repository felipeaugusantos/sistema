unit Reforma.Contrato.Gravacao;

// Porta de escrita do plugin no banco (contrato 3).
//
// Por que a porta existe: a LOGREP nasce de um gancho do UniDAC que so existe no exe (untModuloReplicacao) e
// a transacao com o LOG_IDTRAN tambem e do exe. Por isso o plugin so descreve o que gravar; quem executa e o
// host, que monta o SQL, roda na conexao dele e deixa o gancho gravar a LOGREP. Tudo que passa por esta porta
// replica: nao ha opcao de pular a LOGREP.
//
// Nenhuma excecao atravessa a fronteira exe/DLL (a classe de excecao e diferente em cada modulo, entao "is"
// e "on E: Exception" nao batem): o host captura e devolve TResultadoGravacao.

interface

type
  TValorCampo = record
    Nome: string;
    Valor: Variant;
  end;

  TOperacaoGravacao = (ogInserir, ogAtualizar, ogExcluir, ogSubstituir);

  // Operacao descrita como dado, sem SQL livre. O host aceita so tabelas que ele conhece, valida o
  // identificador dos campos e monta o SQL com parametros. ogSubstituir = insere ou atualiza pela chave unica.
  TComandoGravacao = record
    Tabela: string;
    Operacao: TOperacaoGravacao;
    Chave: array of TValorCampo;
    Campos: array of TValorCampo;
  end;

  TResultadoGravacao = record
    Sucesso: Boolean;
    LinhasAfetadas: Integer;
    Mensagem: string;
  end;

  // Transacao aberta pelo host para o plugin (tela de Convert). Liberar a interface sem Confirmar desfaz:
  // um erro ou esquecimento do plugin nunca deixa transacao aberta.
  // Herda de IInvokable (unit System) so para a interface ganhar RTTI de metodo: IInvokable nao acrescenta
  // metodo nenhum, entao a vtable e o GUID continuam os mesmos. Ver Reforma.Contrato.Assinatura.
  IReformaTransacao = interface(IInvokable)
    ['{A3EE04DB-66A5-48A0-A613-7E00128ADF47}']
    function Confirmar: TResultadoGravacao;
    procedure Desfazer;
  end;

  IReformaGravacao = interface(IInvokable)
    ['{262F271F-A6BB-403E-823B-10F9C8B63122}']
    // Comando de uma linha (chave + campos). Dentro da gravacao do produto participa da transacao do cadastro;
    // fora dela o host abre e confirma uma transacao so para o comando (a LOGREP precisa do LOG_IDTRAN).
    function Executar(const Comando: TComandoGravacao): TResultadoGravacao;
    // Comando em lote (Convert). Exige transacao aberta (a do cadastro ou a de IniciarTransacao); sem ela
    // devolve Sucesso = False.
    function ExecutarSql(const Sql: string; const Parametros: array of TValorCampo): TResultadoGravacao;
    // Devolve nil quando o host ja tem uma transacao aberta (o cadastro gravando o produto): o chamador
    // participa dela e nao confirma nem desfaz.
    function IniciarTransacao: IReformaTransacao;
    // False quando a tabela nao existe neste banco: o plugin funciona como hoje, sem gravar, ler nem avisar.
    function TabelaDisponivel(const Tabela: string): Boolean;
  end;

implementation

end.
