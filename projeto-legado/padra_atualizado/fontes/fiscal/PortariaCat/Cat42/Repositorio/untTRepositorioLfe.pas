unit untTRepositorioLfe;

interface

uses untTTodasClassificacoesFiscaisMySQLLfe,
     untTTodosParticipantesMySQLLfe,
     untTTodosProdutosMySQLLfe,
     untTTodasEmpresasMySQL,
     untTTodasNotasMySQL,
     untTDadosAbertura;

type
  TRepositorio = class
  private
    FCfops: TTodasClassificacoesFiscaisMySQL;
    FParticipantes: TTodosParticipantesMySQL;
    FProdutos: TTodosProdutosMySQL;
    FEmpresas: TTodasEmpresasMySQL;
    FNotas: TTodasNotasMySQL;
    FAbertura: TDadosAbertura;
  public
    constructor create(abertura: TDadosAbertura);
    destructor Destroy; override;

    property cfops: TTodasClassificacoesFiscaisMySQL read FCfops write FCfops;
    property participantes: TTodosParticipantesMySQL read FParticipantes;
    property produtos: TTodosProdutosMySQL read FProdutos;
    property empresas: TTodasEmpresasMySQL read FEmpresas;
    property notas: TTodasNotasMySQL read FNotas;
  end;

implementation

{ TRepositorio }

constructor TRepositorio.create(abertura: TDadosAbertura);
begin
  inherited create;

  FCfops := TTodasClassificacoesFiscaisMySQL.create;
  FParticipantes := TTodosParticipantesMySQL.create;
  FProdutos := TTodosProdutosMySQL.create(abertura);
  FEmpresas := TTodasEmpresasMySQL.create;
  FNotas := TTodasNotasMySQL.create;
  FAbertura := abertura;
end;

destructor TRepositorio.Destroy;
begin
  FParticipantes.Free;
  FProdutos.Free;
  FEmpresas.Free;
  FNotas.Free;
  FCfops.Free;

  inherited;
end;

end.
