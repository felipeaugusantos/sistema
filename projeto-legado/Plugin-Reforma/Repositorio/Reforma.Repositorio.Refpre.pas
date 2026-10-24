unit Reforma.Repositorio.Refpre;

// Persistencia da etapa REFTRI-01 com CFG_REFCIS = 'N': so os parametros que o usuario informa (desconto PIS/COFINS
// 2027, despesa operacional e, por tabela de preco 1 a 7, margem, preco de venda e comissao), uma linha por empresa
// e item na REFPRE. O resto da simulacao sempre parte do produto (ITEGER). A leitura usa IReformaHost.AbrirConsulta
// (so SELECT); a escrita so passa por IReformaHost.Gravacao, que o host executa na transacao dele e com LOGREP.
// Neste modo a ITEREF nao e lida nem gravada.
//
// A estrutura da tabela e a de Reforma.Repositorio.Estrutura (fonte unica). Nas tabelas 2 a 7 NULL e "nao informado":
// a carga mantem o que vem do produto naquela tabela (TabelaLida).

interface

uses
  Data.DB,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Host,
  Reforma.Contrato.Gravacao,
  Reforma.Repositorio.Banco;

type
  // Uma linha da REFPRE na ordem de TRepositorioRefpre.Campos. Null = coluna sem valor.
  TValoresRefpre = TArray<Variant>;

  TRepositorioRefpre = class(TInterfacedObject, IRepositorioSimulacao)
  strict private
    FHost: IReformaHost;
    FVerificado: Boolean;
    FDisponivel: Boolean;
    FTabelasLidas: array[1..QUANTIDADE_TABELAS_PRECO] of Boolean;
    function fPrepararTabela: Boolean;
    function fColunasDisponiveis: Boolean;
    function fTabelaLida(const Tabela: Integer): Boolean;
  public
    constructor Create(const Host: IReformaHost);
    // Colunas gravadas, na ordem de TValoresRefpre.
    class function Campos: TArray<string>; static;
    // Posicao da coluna em TValoresRefpre; -1 quando nao e coluna da REFPRE.
    class function Indice(const NomeCampo: string): Integer; static;
    // False quando a REFPRE nao existe e nao pode ser criada (sem permissao de CREATE, por exemplo): o desconto
    // funciona so em memoria, sem erro (RN07).
    function Disponivel: Boolean;
    function Gravado(const NomeCampo: string): Boolean;
    function GuardaFormacaoCompleta: Boolean;
    function Ler(const CodigoItem: string; const Dados: TDataSet): Boolean;
    function Gravar(const CodigoItem: string; const Dados: TDataSet): TResultadoGravacao;
    // Linha de outra empresa ou item (replicacao). False quando nao ha linha.
    function LerValores(const CodigoEmpresa, CodigoItem: string; out Valores: TValoresRefpre): Boolean;
    function GravarValores(const CodigoEmpresa, CodigoItem: string; const Valores: TValoresRefpre): TResultadoGravacao;
    // Os campos gravaveis do dataset da simulacao, na ordem de TValoresRefpre.
    function ValoresDoDataset(const Dados: TDataSet): TValoresRefpre;
    // Depois de Ler: True quando a tabela de preco veio da REFPRE (preco informado); False, ficou o do produto.
    property TabelaLida[const Tabela: Integer]: Boolean read fTabelaLida;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Reforma.Repositorio.Estrutura;

const
  TABELA = 'REFPRE';

class function TRepositorioRefpre.Campos: TArray<string>;
var
  Tabela: Integer;
begin
  Result := ['ITE_DPISCO', 'ITE_DESOPE'];
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    Result := Result + ['ITE_MARBR' + IntToStr(Tabela), 'ITE_PREVE' + IntToStr(Tabela), 'ITE_COMTB' + IntToStr(Tabela)];
end;

class function TRepositorioRefpre.Indice(const NomeCampo: string): Integer;
var
  Lista: TArray<string>;
  Posicao: Integer;
begin
  Lista := Campos;
  for Posicao := 0 to High(Lista) do
    if SameText(Lista[Posicao], NomeCampo) then
      Exit(Posicao);
  Result := -1;
end;

constructor TRepositorioRefpre.Create(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
end;

// Banco sem REFPRE, ou com a REFPRE de uma versao anterior: a estrutura central cria ou acrescenta o que falta. So fora
// da gravacao do produto (no MySQL o DDL confirma a transacao aberta); com o cadastro gravando o ajuste fica adiado e
// e tentado de novo na proxima consulta. Falha de verdade (sem permissao de CREATE/ALTER) nao repete na mesma tela.
function TRepositorioRefpre.fPrepararTabela: Boolean;
var
  Estrutura: TEstruturaBanco;
  Mensagem: string;
begin
  if not Assigned(FHost.Gravacao) then
  begin
    FVerificado := True;
    Exit(False);
  end;

  Estrutura := TEstruturaBanco.Create(fBancoDoHost(FHost));
  try
    Result := Estrutura.PrepararTabelas([TABELA], Mensagem);
    FVerificado := not Estrutura.Adiado;
  finally
    Estrutura.Free;
  end;
end;

// Tabela com outra estrutura que nao pode ser ajustada: coluna faltando faria o Ler falhar calado e o Gravar derrubar
// a gravacao do produto inteiro.
function TRepositorioRefpre.fColunasDisponiveis: Boolean;
var
  Consulta: IReformaConsulta;
begin
  Result := True;
  try
    Consulta := FHost.AbrirConsulta('SELECT ' + string.Join(', ', Campos) + ' FROM ' + TABELA + ' WHERE 1 = 0');
    Consulta.Abrir;
  except
    // Excecao do host: classe de outro modulo, nao da para tratar por tipo.
    Result := False;
  end;
end;

function TRepositorioRefpre.fTabelaLida(const Tabela: Integer): Boolean;
begin
  Result := (Tabela >= 1) and (Tabela <= QUANTIDADE_TABELAS_PRECO) and FTabelasLidas[Tabela];
end;

function TRepositorioRefpre.Disponivel: Boolean;
begin
  if not FVerificado then
  begin
    try
      FDisponivel := fPrepararTabela and fColunasDisponiveis;
    except
      // Qualquer falha do banco aqui nao pode derrubar o cadastro de produtos.
      FVerificado := True;
      FDisponivel := False;
    end;
  end;
  Result := FDisponivel;
end;

function TRepositorioRefpre.Gravado(const NomeCampo: string): Boolean;
begin
  Result := Indice(NomeCampo) >= 0;
end;

function TRepositorioRefpre.GuardaFormacaoCompleta: Boolean;
begin
  Result := False;
end;

function TRepositorioRefpre.LerValores(const CodigoEmpresa, CodigoItem: string; out Valores: TValoresRefpre): Boolean;
var
  Consulta: IReformaConsulta;
  Lista: TArray<string>;
  Posicao: Integer;
  Valor: Variant;
begin
  Result := False;
  Lista := Campos;
  SetLength(Valores, Length(Lista));
  for Posicao := 0 to High(Valores) do
    Valores[Posicao] := Null;

  if not Disponivel or (CodigoItem = '') then
    Exit;

  Consulta := FHost.AbrirConsulta('SELECT ' + string.Join(', ', Lista) + ' FROM ' + TABELA +
    ' WHERE ITE_CODEMP = :CODEMP AND ITE_CODITE = :CODITE');
  Consulta.DefinirParametro('CODEMP', CodigoEmpresa);
  Consulta.DefinirParametro('CODITE', CodigoItem);
  Consulta.Abrir;
  if Consulta.Vazia then
    Exit;

  for Posicao := 0 to High(Lista) do
  begin
    Valor := Consulta.ValorCampo(Lista[Posicao]);
    if VarIsNull(Valor) or VarIsEmpty(Valor) then
      Valores[Posicao] := Null
    else
      Valores[Posicao] := VarAsType(Valor, varDouble);
  end;
  Result := True;
end;

function TRepositorioRefpre.Ler(const CodigoItem: string; const Dados: TDataSet): Boolean;
var
  Valores: TValoresRefpre;
  Lista: TArray<string>;
  Posicao: Integer;
  Tabela: Integer;
begin
  Result := False;
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    FTabelasLidas[Tabela] := False;

  // Disponivel antes do codigo: na inclusao o item ainda nao tem codigo, e a tabela tem de ser preparada agora,
  // fora da transacao do cadastro, para a gravacao achar onde gravar.
  if not Disponivel or (CodigoItem = '') then
    Exit;

  // Le tudo antes de escrever: falha no meio nao mistura valores gravados com os do produto.
  try
    if not LerValores(FHost.CodigoEmpresa, CodigoItem, Valores) then
      Exit;
  except
    // Excecao do host nao e da classe Exception desta DLL: sem leitura a simulacao parte do produto.
    Exit(False);
  end;

  // Tabela com preco NULL nao foi informada: margem, preco e comissao dela ficam os do produto.
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    FTabelasLidas[Tabela] := not VarIsNull(Valores[Indice('ITE_PREVE' + IntToStr(Tabela))]);

  Lista := Campos;
  if not (Dados.State in dsEditModes) then
    Dados.Edit;
  for Posicao := 0 to High(Lista) do
  begin
    Tabela := StrToIntDef(RightStr(Lista[Posicao], 1), 0);
    if (Tabela >= 1) and (Tabela <= QUANTIDADE_TABELAS_PRECO) and not FTabelasLidas[Tabela] then
      Continue;
    if VarIsNull(Valores[Posicao]) then
      Dados.FieldByName(Lista[Posicao]).AsFloat := 0
    else
      Dados.FieldByName(Lista[Posicao]).AsFloat := Valores[Posicao];
  end;
  Result := True;
end;

function TRepositorioRefpre.ValoresDoDataset(const Dados: TDataSet): TValoresRefpre;
var
  Lista: TArray<string>;
  Posicao: Integer;
begin
  Lista := Campos;
  SetLength(Result, Length(Lista));
  for Posicao := 0 to High(Lista) do
    Result[Posicao] := Dados.FieldByName(Lista[Posicao]).AsFloat;
end;

function TRepositorioRefpre.GravarValores(const CodigoEmpresa, CodigoItem: string;
  const Valores: TValoresRefpre): TResultadoGravacao;
var
  Comando: TComandoGravacao;
  Lista: TArray<string>;
  Posicao: Integer;
begin
  Result.Sucesso := True;
  Result.LinhasAfetadas := 0;
  Result.Mensagem := '';
  // Sem codigo nao ha linha a gravar, e nao e erro (RN08).
  if (CodigoItem = '') or not Disponivel then
    Exit;

  // Insere ou atualiza pela chave unica: uma linha por empresa e item, sem apagar e recriar (RN06).
  Comando.Tabela := TABELA;
  Comando.Operacao := ogSubstituir;
  SetLength(Comando.Chave, 2);
  Comando.Chave[0].Nome := 'ITE_CODEMP';
  Comando.Chave[0].Valor := CodigoEmpresa;
  Comando.Chave[1].Nome := 'ITE_CODITE';
  Comando.Chave[1].Valor := CodigoItem;

  Lista := Campos;
  SetLength(Comando.Campos, Length(Lista));
  for Posicao := 0 to High(Lista) do
  begin
    Comando.Campos[Posicao].Nome := Lista[Posicao];
    Comando.Campos[Posicao].Valor := Valores[Posicao];
  end;

  Result := FHost.Gravacao.Executar(Comando);
end;

function TRepositorioRefpre.Gravar(const CodigoItem: string; const Dados: TDataSet): TResultadoGravacao;
begin
  Result := GravarValores(FHost.CodigoEmpresa, CodigoItem, ValoresDoDataset(Dados));
end;

end.
