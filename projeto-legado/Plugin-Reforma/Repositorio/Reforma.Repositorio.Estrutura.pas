unit Reforma.Repositorio.Estrutura;

// Estrutura de banco que o plugin espera: IMPTRI, REFPRE, ITEREO, ITEREF, REFCON, REFDIV e REFTDE, mais a coluna EMP_REFCON
// no CADEMP (tabela do autcom: so ganha a coluna, no fim). Fonte unica, igual a
// IA\specs\REFTRI-02\REFTRI-02-tabelas.sql. Para o banco acompanhar uma versao nova do plugin basta mudar a definicao
// aqui (pMontarDefinicoes): tabela que falta e criada; tabela que existe ganha as colunas e os indices que faltam.
// Nada e apagado, renomeado nem trocado de tipo.
//
// Quem chama:
//  - o host, ao subir o autcom com a DLL na pasta (export fReformaPrepararBanco): prepara todas;
//  - o cadastro de produtos, ao abrir, para as que ele usa (REFPRE e IMPTRI), caso o banco ainda nao tenha passado
//    pela subida.
//
// Cada DDL vai pela porta de gravacao do host (com LOGREP, replica para as filiais) numa transacao propria: no MySQL o
// DDL confirma a transacao aberta, entao nada roda dentro de outra gravacao. Com uma transacao aberta (o cadastro
// gravando) o ajuste fica adiado e e tentado de novo na proxima vez.
//
// MySQL 5.7 nao tem ADD COLUMN IF NOT EXISTS: a estrutura atual e lida do information_schema antes de cada ajuste.
// Outra estacao pode ter ajustado no meio: se o ALTER falhar, a estrutura e lida de novo antes de dar como erro.

interface

uses
  System.Generics.Collections,
  Reforma.Contrato.Host;

// Fonte unica das listas: o DDL desta unit e a conferencia do Convert (Reforma.Convert.Estrutura) usam as mesmas.
const
  // Colunas de ITEREO/ITEREF copiadas do ITEGER, com o tipo do ITEGER do proprio banco (spec REFTRI-02, RN15a). A que
  // o ITEGER daquele banco nao tem fica de fora.
  COLUNAS_ITEGER: array[0..48] of string = (
    'ITE_PRECOM', 'ITE_PREDOL', 'ITE_DESF01', 'ITE_DESF02', 'ITE_DESF03', 'ITE_DESF04', 'ITE_DESF05', 'ITE_DESF06',
    'ITE_ICMENT', 'ITE_SUBFED', 'ITE_ALQENT', 'ITE_ALQFED', 'ITE_IPIENT', 'ITE_FREENT', 'ITE_VALFRE', 'ITE_ACRFIN',
    'ITE_SUBSTI', 'ITE_DESADB', 'ITE_PRECUS', 'ITE_TCIFCU', 'ITE_TSCUST', 'ITE_DEPICO', 'ITE_DEICMS', 'ITE_FATREG',
    'ITE_OUTVAL', 'ITE_ICMSAI', 'ITE_IMPFED', 'ITE_DESOPE',
    'ITE_PREVE1', 'ITE_PREVE2', 'ITE_PREVE3', 'ITE_PREVE4', 'ITE_PREVE5', 'ITE_PREVE6', 'ITE_PREVE7',
    'ITE_MARBR1', 'ITE_MARBR2', 'ITE_MARBR3', 'ITE_MARBR4', 'ITE_MARBR5', 'ITE_MARBR6', 'ITE_MARBR7',
    'ITE_COMTB1', 'ITE_COMTB2', 'ITE_COMTB3', 'ITE_COMTB4', 'ITE_COMTB5', 'ITE_COMTB6', 'ITE_COMTB7');

  // Proprias do Convert em ITEREO/ITEREF: nao vem do ITEGER.
  COLUNAS_PROPRIAS: array[0..3] of string = ('ITE_DPISCO', 'ITE_CBS', 'ITE_IBS', 'ITE_IS');

  // Tabelas do plugin, na ordem em que a estrutura as cria.
  TABELAS_PLUGIN: array[0..6] of string = ('IMPTRI', 'REFPRE', 'ITEREO', 'ITEREF', 'REFCON', 'REFDIV', 'REFTDE');

type
  TEstruturaBanco = class
  public
    type
      TColuna = record
        Nome: string;
        Definicao: string;
      end;

      TIndice = record
        Nome: string;
        // Clausula do CREATE/ALTER: 'UNIQUE KEY UK_REFPRE_01 (ITE_CODEMP, ITE_CODITE)'.
        Definicao: string;
      end;

      TTabela = record
        Nome: string;
        Colunas: TArray<TColuna>;
        // Coluna da chave primaria (AUTO_INCREMENT).
        ChavePrimaria: string;
        Indices: TArray<TIndice>;
        // Tabela do autcom (CADEMP): so ganha as colunas que faltam, no fim; nunca e criada nem recebe indice.
        Sistema: Boolean;
      end;
  strict private
    var
      FBanco: IReformaBancoHost;
      FTabelas: TList<TTabela>;
      // 'TABELA.COLUNA' -> COLUMN_TYPE do ITEGER e da CADOPE do proprio banco.
      FTiposBanco: TDictionary<string, string>;
      // 'TABELA.COLUNA' e 'TABELA' das tabelas do plugin como estao no banco agora.
      FColunasExistentes: TDictionary<string, Boolean>;
      FIndicesExistentes: TDictionary<string, Boolean>;
      FAdiado: Boolean;
    function fTipoBanco(const Tabela, Coluna, Padrao: string): string;
    function fListaTabelas: string;
    procedure pLerTiposBanco;
    procedure pLerEstruturaAtual;
    procedure pMontarDefinicoes;
    procedure pAdicionarTabela(const Nome, ChavePrimaria: string; const Colunas: TArray<TColuna>;
      const Indices: TArray<TIndice>);
    procedure pAdicionarColunasSistema(const Nome: string; const Colunas: TArray<TColuna>);
    function fSincronizarReforma(out Erro: string): Boolean;
    function fExecutar(const Sql: string; out Erro: string): Boolean;
    function fSqlCriar(const Tabela: TTabela): string;
    function fColunasFaltando(const Tabela: TTabela): TArray<TColuna>;
    function fIndicesFaltando(const Tabela: TTabela): TArray<TIndice>;
    function fPrepararTabela(const Tabela: TTabela; out Erro: string): Boolean;
    function fAcrescentarColunas(const Tabela: TTabela; out Erro: string): Boolean;
    function fAcrescentarIndices(const Tabela: TTabela; out Erro: string): Boolean;
    function fGarantirAliquotaReferencia(out Erro: string): Boolean;
  public
    constructor Create(const Banco: IReformaBancoHost);
    destructor Destroy; override;
    // Todas as tabelas. False quando alguma nao ficou como o plugin espera; Mensagem diz qual e por que.
    function Preparar(out Mensagem: string): Boolean;
    // So as tabelas indicadas, pelo nome.
    function PrepararTabelas(const Nomes: array of string; out Mensagem: string): Boolean;
    // True quando algum ajuste nao rodou porque havia uma transacao aberta (tentar de novo depois).
    property Adiado: Boolean read FAdiado;
  end;

// O cadastro de produtos tem IReformaHost; a estrutura so precisa da consulta e da porta de gravacao dele.
function fBancoDoHost(const Host: IReformaHost): IReformaBancoHost;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Reforma.Contrato.Gravacao;

type
  TBancoDoHost = class(TInterfacedObject, IReformaBancoHost)
  strict private
    FHost: IReformaHost;
  public
    constructor Create(const Host: IReformaHost);
    function AbrirConsulta(const Sql: string): IReformaConsulta;
    function Gravacao: IReformaGravacao;
  end;

const
  TABELA_ALIQUOTAS = 'IMPTRI';

function fColuna(const Nome, Definicao: string): TEstruturaBanco.TColuna;
begin
  Result.Nome := Nome;
  Result.Definicao := Definicao;
end;

function fIndice(const Nome, Definicao: string): TEstruturaBanco.TIndice;
begin
  Result.Nome := Nome;
  Result.Definicao := Definicao;
end;

{ TBancoDoHost }

constructor TBancoDoHost.Create(const Host: IReformaHost);
begin
  inherited Create;
  FHost := Host;
end;

function TBancoDoHost.AbrirConsulta(const Sql: string): IReformaConsulta;
begin
  Result := FHost.AbrirConsulta(Sql);
end;

function TBancoDoHost.Gravacao: IReformaGravacao;
begin
  Result := FHost.Gravacao;
end;

function fBancoDoHost(const Host: IReformaHost): IReformaBancoHost;
begin
  Result := TBancoDoHost.Create(Host);
end;

{ TEstruturaBanco }

constructor TEstruturaBanco.Create(const Banco: IReformaBancoHost);
begin
  inherited Create;
  FBanco := Banco;
  FTabelas := TList<TTabela>.Create;
  FTiposBanco := TDictionary<string, string>.Create;
  FColunasExistentes := TDictionary<string, Boolean>.Create;
  FIndicesExistentes := TDictionary<string, Boolean>.Create;
end;

destructor TEstruturaBanco.Destroy;
begin
  FreeAndNil(FIndicesExistentes);
  FreeAndNil(FColunasExistentes);
  FreeAndNil(FTiposBanco);
  FreeAndNil(FTabelas);
  inherited Destroy;
end;

function TEstruturaBanco.fTipoBanco(const Tabela, Coluna, Padrao: string): string;
begin
  if not FTiposBanco.TryGetValue(UpperCase(Tabela + '.' + Coluna), Result) then
    Result := Padrao;
end;

function TEstruturaBanco.fListaTabelas: string;
var
  Tabela: TTabela;
begin
  Result := '';
  for Tabela in FTabelas do
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + QuotedStr(Tabela.Nome);
  end;
end;

// Tipos de ITEGER, CADOPE, CADEMP, TABDET e DETCUS deste banco: ITEREO, ITEREF, REFCON, REFDIV e REFTDE usam os mesmos
// (os tipos variam por base).
procedure TEstruturaBanco.pLerTiposBanco;
var
  Consulta: IReformaConsulta;
begin
  FTiposBanco.Clear;
  Consulta := FBanco.AbrirConsulta(
    'SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE FROM information_schema.COLUMNS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN (''ITEGER'', ''CADOPE'', ''CADEMP'', ''TABDET'', ''DETCUS'')');
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    FTiposBanco.AddOrSetValue(UpperCase(VarToStr(Consulta.ValorCampo('TABLE_NAME')) + '.' +
      VarToStr(Consulta.ValorCampo('COLUMN_NAME'))), VarToStr(Consulta.ValorCampo('COLUMN_TYPE')));
    Consulta.Proximo;
  end;
end;

procedure TEstruturaBanco.pLerEstruturaAtual;
var
  Consulta: IReformaConsulta;
  Tabela: string;
begin
  FColunasExistentes.Clear;
  FIndicesExistentes.Clear;

  Consulta := FBanco.AbrirConsulta(
    'SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN (' + fListaTabelas + ')');
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Tabela := UpperCase(VarToStr(Consulta.ValorCampo('TABLE_NAME')));
    FColunasExistentes.AddOrSetValue(Tabela, True);
    FColunasExistentes.AddOrSetValue(Tabela + '.' + UpperCase(VarToStr(Consulta.ValorCampo('COLUMN_NAME'))), True);
    Consulta.Proximo;
  end;

  Consulta := FBanco.AbrirConsulta(
    'SELECT DISTINCT TABLE_NAME, INDEX_NAME FROM information_schema.STATISTICS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN (' + fListaTabelas + ')');
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    FIndicesExistentes.AddOrSetValue(UpperCase(VarToStr(Consulta.ValorCampo('TABLE_NAME')) + '.' +
      VarToStr(Consulta.ValorCampo('INDEX_NAME'))), True);
    Consulta.Proximo;
  end;
end;

procedure TEstruturaBanco.pAdicionarTabela(const Nome, ChavePrimaria: string; const Colunas: TArray<TColuna>;
  const Indices: TArray<TIndice>);
var
  Tabela: TTabela;
begin
  Tabela.Nome := Nome;
  Tabela.ChavePrimaria := ChavePrimaria;
  Tabela.Colunas := Colunas;
  Tabela.Indices := Indices;
  Tabela.Sistema := False;
  FTabelas.Add(Tabela);
end;

procedure TEstruturaBanco.pAdicionarColunasSistema(const Nome: string; const Colunas: TArray<TColuna>);
var
  Tabela: TTabela;
begin
  Tabela.Nome := Nome;
  Tabela.ChavePrimaria := '';
  Tabela.Colunas := Colunas;
  Tabela.Indices := nil;
  Tabela.Sistema := True;
  FTabelas.Add(Tabela);
end;

// A definicao do banco que o plugin espera. Evoluir o banco = mudar aqui (e o REFTRI-02-tabelas.sql de referencia).
procedure TEstruturaBanco.pMontarDefinicoes;
var
  Colunas: TArray<TColuna>;
  Tabela: Integer;
  Nome: string;
  TipoEmpresa: string;
  TipoItem: string;

  procedure pAcrescentar(const Nome, Definicao: string);
  begin
    SetLength(Colunas, Length(Colunas) + 1);
    Colunas[High(Colunas)] := fColuna(Nome, Definicao);
  end;

  // ITEREO (valores antigos) e ITEREF (valores novos) tem a mesma estrutura (spec REFTRI-02, RN15).
  procedure pAdicionarTabelaItem(const Nome: string);
  var
    Coluna: string;
  begin
    Colunas := nil;
    pAcrescentar('REF_ID', 'BIGINT(20) NOT NULL AUTO_INCREMENT');
    pAcrescentar('REF_CHAVE', 'CHAR(38) NOT NULL');
    pAcrescentar('REF_LOTE', 'INT(11) NOT NULL DEFAULT 0');
    pAcrescentar('REF_ORIGEM', 'CHAR(1) NOT NULL DEFAULT ''L''');
    pAcrescentar('REF_APLICADO', 'CHAR(1) NOT NULL DEFAULT ''N''');
    pAcrescentar('ITE_CODEMP', TipoEmpresa + ' NOT NULL');
    pAcrescentar('ITE_CODITE', TipoItem + ' NOT NULL');
    for Coluna in COLUNAS_ITEGER do
      if FTiposBanco.ContainsKey('ITEGER.' + Coluna) then
        pAcrescentar(Coluna, fTipoBanco('ITEGER', Coluna, '') + ' NULL DEFAULT NULL');
    for Coluna in COLUNAS_PROPRIAS do
      pAcrescentar(Coluna, 'DECIMAL(5,2) NULL DEFAULT NULL');

    // Unico por conversao (REF_CHAVE): a empresa que foi F ou R na conversao de uma matriz pode voltar como R na de
    // outra matriz, cada conversao com o proprio backup (REFTRI-02, decisao de 2026-10-05).
    pAdicionarTabela(Nome, 'REF_ID', Colunas, [
      fIndice('UK_' + Nome + '_01', 'UNIQUE KEY UK_' + Nome + '_01 (REF_CHAVE, ITE_CODEMP, ITE_CODITE)'),
      fIndice('IDX_' + Nome + '_01', 'KEY IDX_' + Nome + '_01 (REF_CHAVE, REF_LOTE)')]);
  end;

begin
  FTabelas.Clear;
  TipoEmpresa := fTipoBanco('ITEGER', 'ITE_CODEMP', 'CHAR(3)');
  TipoItem := fTipoBanco('ITEGER', 'ITE_CODITE', 'VARCHAR(5)');

  // 1. IMPTRI: aliquotas CBS/IBS/IS (primeira linha). Sem chave primaria, como sempre foi.
  pAdicionarTabela(TABELA_ALIQUOTAS, '', [
    fColuna('CBS', 'DECIMAL(5,2) DEFAULT NULL'),
    fColuna('IBS', 'DECIMAL(5,2) DEFAULT NULL'),
    fColuna('`IS`', 'DECIMAL(5,2) DEFAULT NULL')], []);

  // 2. REFPRE: parametros do Calculo Novo por empresa e item (REFTRI-01). A tabela 1 mantem tipo e default de
  //    sempre; as tabelas 2 a 7 sao NULL DEFAULT NULL: NULL e "nao informado" (o plugin e o Convert usam o produto).
  Colunas := nil;
  pAcrescentar('REF_ID', 'BIGINT(20) NOT NULL AUTO_INCREMENT');
  pAcrescentar('ITE_CODEMP', 'CHAR(3) NOT NULL');
  pAcrescentar('ITE_CODITE', 'VARCHAR(7) NOT NULL');
  pAcrescentar('ITE_DPISCO', 'DECIMAL(5,2) NOT NULL DEFAULT 0.00');
  pAcrescentar('ITE_DESOPE', 'DECIMAL(12,2) NOT NULL DEFAULT 0.00');
  pAcrescentar('ITE_MARBR1', 'DECIMAL(18,8) DEFAULT 0.00000000');
  pAcrescentar('ITE_PREVE1', 'DECIMAL(26,10) DEFAULT NULL');
  pAcrescentar('ITE_COMTB1', 'DECIMAL(12,2) NOT NULL DEFAULT 0.00');
  for Tabela := 2 to 7 do
  begin
    Nome := IntToStr(Tabela);
    pAcrescentar('ITE_MARBR' + Nome, 'DECIMAL(18,8) NULL DEFAULT NULL');
    pAcrescentar('ITE_PREVE' + Nome, 'DECIMAL(26,10) NULL DEFAULT NULL');
    pAcrescentar('ITE_COMTB' + Nome, 'DECIMAL(12,2) NULL DEFAULT NULL');
  end;
  pAdicionarTabela('REFPRE', 'REF_ID', Colunas, [
    fIndice('UK_REFPRE_01', 'UNIQUE KEY UK_REFPRE_01 (ITE_CODEMP, ITE_CODITE)')]);

  // 3. ITEREO e ITEREF: backup do Convert (REFTRI-02).
  pAdicionarTabelaItem('ITEREO');
  pAdicionarTabelaItem('ITEREF');

  // 4. REFCON: controle da conversao, uma linha por conversao e empresa.
  pAdicionarTabela('REFCON', 'CON_ID', [
    fColuna('CON_ID', 'BIGINT(20) NOT NULL AUTO_INCREMENT'),
    fColuna('CON_CHAVE', 'CHAR(38) NOT NULL'),
    fColuna('CON_CODEMP', TipoEmpresa + ' NOT NULL'),
    fColuna('CON_EMPORI', TipoEmpresa + ' NOT NULL'),
    fColuna('CON_ORIGEM', 'CHAR(1) NOT NULL'),
    fColuna('CON_OPCAO', 'CHAR(1) NOT NULL'),
    fColuna('CON_FASE', 'CHAR(1) NOT NULL'),
    fColuna('CON_CODOPE', fTipoBanco('CADOPE', 'OPE_CODOPE', 'VARCHAR(20)') + ' NOT NULL'),
    fColuna('CON_DTAINI', 'DATE NOT NULL'),
    fColuna('CON_HORINI', 'TIME NOT NULL'),
    fColuna('CON_DTAFIM', 'DATE NULL DEFAULT NULL'),
    fColuna('CON_HORFIM', 'TIME NULL DEFAULT NULL'),
    fColuna('CON_QTDITE', 'INT(11) NOT NULL DEFAULT 0'),
    fColuna('CON_QTDAPL', 'INT(11) NOT NULL DEFAULT 0'),
    fColuna('CON_QTDDIV', 'INT(11) NOT NULL DEFAULT 0'),
    fColuna('CON_ALQCBS', 'DECIMAL(5,2) NULL DEFAULT NULL'),
    fColuna('CON_ALQIBS', 'DECIMAL(5,2) NULL DEFAULT NULL'),
    fColuna('CON_ALQIS', 'DECIMAL(5,2) NULL DEFAULT NULL'),
    // Opcoes da tela, guardadas para a retomada: origem de CBS/IBS/IS ('T' tabela estatica IMPTRI, 'A' abreviacao
    // do item) e so itens ativos ('S'/'N').
    fColuna('CON_ORIIMP', 'CHAR(1) NOT NULL DEFAULT ''T'''),
    fColuna('CON_SOATIV', 'CHAR(1) NOT NULL DEFAULT ''S'''),
    // Filtro de itens do operador 998 (codigos separados por ';'); NULL = todos os itens (usuario, 2026-10-06).
    fColuna('CON_FILITE', 'TEXT NULL'),
    // EMP_SUBFED e EMP_IMPFED da empresa antes da ativacao, que os zera; o Reverter os devolve. NULL = conversao
    // ativada antes desta regra: o Reverter nao mexe no CADEMP (usuario, 2026-10-15).
    fColuna('CON_SUBFED', fTipoBanco('CADEMP', 'EMP_SUBFED', 'DECIMAL(12,4)') + ' NULL DEFAULT NULL'),
    fColuna('CON_IMPFED', fTipoBanco('CADEMP', 'EMP_IMPFED', 'DECIMAL(12,4)') + ' NULL DEFAULT NULL'),
    fColuna('CON_MENSAG', 'VARCHAR(255) NULL DEFAULT NULL')], [
    fIndice('UK_REFCON_01', 'UNIQUE KEY UK_REFCON_01 (CON_CHAVE, CON_CODEMP)'),
    fIndice('IDX_REFCON_01', 'KEY IDX_REFCON_01 (CON_CODEMP)')]);

  // 5. REFDIV: divergencias e alertas da conferencia do Convert.
  pAdicionarTabela('REFDIV', 'DIV_ID', [
    fColuna('DIV_ID', 'BIGINT(20) NOT NULL AUTO_INCREMENT'),
    fColuna('DIV_CHAVE', 'CHAR(38) NOT NULL'),
    fColuna('DIV_CODEMP', TipoEmpresa + ' NOT NULL'),
    fColuna('DIV_CODITE', TipoItem + ' NULL DEFAULT NULL'),
    fColuna('DIV_TIPO', 'VARCHAR(10) NOT NULL'),
    fColuna('DIV_CAMPO', 'VARCHAR(20) NULL DEFAULT NULL'),
    fColuna('DIV_ESPERA', 'VARCHAR(40) NULL DEFAULT NULL'),
    fColuna('DIV_ENCONT', 'VARCHAR(40) NULL DEFAULT NULL'),
    fColuna('DIV_DTAREG', 'DATE NOT NULL'),
    fColuna('DIV_HORREG', 'TIME NOT NULL')], [
    fIndice('IDX_REFDIV_01', 'KEY IDX_REFDIV_01 (DIV_CHAVE, DIV_CODEMP)')]);

  // 6. REFTDE: TABDET e DETCUS de antes da conversao, para o Reverter (CFG_TABPRD; usuario, 2026-10-19). Uma linha por
  //    TABDET ligada ao item (TDE_TABELA 0: custo e impostos federais) e uma por DETCUS dela (TDE_TABELA = DET_TABELA:
  //    preco, margem, ICMS de saida, despesa e outros valores). Sem TABDET/DETCUS no banco, os tipos sao os padrao.
  pAdicionarTabela('REFTDE', 'TDE_ID', [
    fColuna('TDE_ID', 'BIGINT(20) NOT NULL AUTO_INCREMENT'),
    fColuna('TDE_CHAVE', 'CHAR(38) NOT NULL'),
    fColuna('TDE_LOTE', 'INT(11) NOT NULL DEFAULT 0'),
    fColuna('TDE_CODEMP', TipoEmpresa + ' NOT NULL'),
    fColuna('TDE_SEQDET', fTipoBanco('TABDET', 'AUTOINCREM', 'CHAR(20)') + ' NOT NULL'),
    fColuna('TDE_TABELA', 'INT(11) NOT NULL DEFAULT 0'),
    fColuna('TDE_PRECOM', fTipoBanco('TABDET', 'ITE_PRECOM', 'DECIMAL(12,4)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_PRECUS', fTipoBanco('TABDET', 'ITE_PRECUS', 'DECIMAL(12,4)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_SUBFED', fTipoBanco('TABDET', 'ITE_SUBFED', 'DECIMAL(5,2)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_IMPFED', fTipoBanco('TABDET', 'ITE_IMPFED', 'DECIMAL(5,2)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_ICMSAI', fTipoBanco('DETCUS', 'DET_ICMSAI', 'DECIMAL(12,2)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_DESOPE', fTipoBanco('DETCUS', 'DET_DESOPE', 'DECIMAL(12,2)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_OUTVAL', fTipoBanco('DETCUS', 'DET_OUTVAL', 'DECIMAL(12,2)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_MARBRU', fTipoBanco('DETCUS', 'DET_MARBRU', 'DECIMAL(18,8)') + ' NULL DEFAULT NULL'),
    fColuna('TDE_PREVEN', fTipoBanco('DETCUS', 'DET_PREVEN', 'DECIMAL(14,4)') + ' NULL DEFAULT NULL')], [
    fIndice('UK_REFTDE_01', 'UNIQUE KEY UK_REFTDE_01 (TDE_CHAVE, TDE_CODEMP, TDE_SEQDET, TDE_TABELA)'),
    fIndice('IDX_REFTDE_01', 'KEY IDX_REFTDE_01 (TDE_CHAVE, TDE_LOTE)')]);

  // 7. CADEMP.EMP_REFCON: empresa convertida pelo Convert ('S'). A CFGSIS nao replica e o CADEMP sim: nas lojas a
  //    CFG_REFCIS e ligada por este campo ao subir o autcom (fSincronizarReforma; REFTRI-02, usuario, 2026-10-06).
  pAdicionarColunasSistema('CADEMP', [fColuna('EMP_REFCON', 'CHAR(1) NOT NULL DEFAULT ''N''')]);
end;

// Mesmo padrao de sempre para DDL: transacao propria pela porta do host. Sem ela (o cadastro gravando) fica adiado.
function TEstruturaBanco.fExecutar(const Sql: string; out Erro: string): Boolean;
var
  Gravacao: IReformaGravacao;
  Transacao: IReformaTransacao;
  Resultado: TResultadoGravacao;
begin
  Result := False;
  Erro := '';

  Gravacao := FBanco.Gravacao;
  if not Assigned(Gravacao) then
  begin
    Erro := 'O host nao tem porta de gravacao.';
    Exit;
  end;

  Transacao := Gravacao.IniciarTransacao;
  if not Assigned(Transacao) then
  begin
    FAdiado := True;
    Erro := 'Ha uma transacao aberta; o ajuste fica para a proxima vez.';
    Exit;
  end;

  Resultado := Gravacao.ExecutarSql(Sql, []);
  if Resultado.Sucesso then
    Resultado := Transacao.Confirmar
  else
    Transacao.Desfazer;

  Result := Resultado.Sucesso;
  Erro := Resultado.Mensagem;
end;

function TEstruturaBanco.fSqlCriar(const Tabela: TTabela): string;
var
  Coluna: TColuna;
  Indice: TIndice;
begin
  Result := '';
  for Coluna in Tabela.Colunas do
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + Coluna.Nome + ' ' + Coluna.Definicao;
  end;

  if Tabela.ChavePrimaria <> '' then
    Result := Result + ', PRIMARY KEY (' + Tabela.ChavePrimaria + ')';

  for Indice in Tabela.Indices do
    Result := Result + ', ' + Indice.Definicao;

  Result := 'CREATE TABLE IF NOT EXISTS ' + Tabela.Nome + ' (' + Result + ') ENGINE=InnoDB DEFAULT CHARSET=latin1';
end;

function TEstruturaBanco.fColunasFaltando(const Tabela: TTabela): TArray<TColuna>;
var
  Coluna: TColuna;
begin
  Result := nil;
  for Coluna in Tabela.Colunas do
    if not FColunasExistentes.ContainsKey(UpperCase(Tabela.Nome + '.' + ReplaceStr(Coluna.Nome, '`', ''))) then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Coluna;
    end;
end;

function TEstruturaBanco.fIndicesFaltando(const Tabela: TTabela): TArray<TIndice>;
var
  Indice: TIndice;
begin
  Result := nil;
  for Indice in Tabela.Indices do
    if not FIndicesExistentes.ContainsKey(UpperCase(Tabela.Nome + '.' + Indice.Nome)) then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := Indice;
    end;
end;

// Um ALTER so para todas as colunas que faltam, cada uma na posicao da definicao (AFTER a anterior). A chave
// primaria AUTO_INCREMENT so pode entrar junto com a PRIMARY KEY, e so se a tabela ainda nao tiver uma.
function TEstruturaBanco.fAcrescentarColunas(const Tabela: TTabela; out Erro: string): Boolean;
var
  Faltando: TArray<TColuna>;
  Coluna: TColuna;
  Indice: Integer;
  Anterior: string;
  Sql: string;
begin
  Erro := '';
  Faltando := fColunasFaltando(Tabela);
  if Length(Faltando) = 0 then
    Exit(True);

  Sql := '';
  for Coluna in Faltando do
  begin
    Anterior := '';
    for Indice := 0 to High(Tabela.Colunas) do
      if Tabela.Colunas[Indice].Nome = Coluna.Nome then
      begin
        if Indice > 0 then
          Anterior := Tabela.Colunas[Indice - 1].Nome;
        Break;
      end;

    if Sql <> '' then
      Sql := Sql + ', ';
    Sql := Sql + 'ADD COLUMN ' + Coluna.Nome + ' ' + Coluna.Definicao;
    // Tabela do autcom: a coluna nova vai para o fim.
    if not Tabela.Sistema then
      if Anterior = '' then
        Sql := Sql + ' FIRST'
      else
        Sql := Sql + ' AFTER ' + Anterior;

    if SameText(Coluna.Nome, Tabela.ChavePrimaria) then
    begin
      if FIndicesExistentes.ContainsKey(UpperCase(Tabela.Nome + '.PRIMARY')) then
      begin
        Erro := 'A tabela ' + Tabela.Nome + ' tem outra chave primaria; falta a coluna ' + Coluna.Nome +
          '. Ajuste a estrutura manualmente.';
        Exit(False);
      end;
      Sql := Sql + ', ADD PRIMARY KEY (' + Coluna.Nome + ')';
    end;
  end;

  Result := fExecutar('ALTER TABLE ' + Tabela.Nome + ' ' + Sql, Erro);

  // Outra estacao pode ter acrescentado as mesmas colunas no meio.
  if not Result and not FAdiado then
  begin
    pLerEstruturaAtual;
    Result := Length(fColunasFaltando(Tabela)) = 0;
  end;

  if not Result and (Erro <> '') then
    Erro := 'Nao foi possivel acrescentar colunas em ' + Tabela.Nome + ': ' + Erro;
end;

// Um ALTER por indice: um UNIQUE que falha por linha duplicada nao impede os outros.
function TEstruturaBanco.fAcrescentarIndices(const Tabela: TTabela; out Erro: string): Boolean;
var
  Indice: TIndice;
  ErroIndice: string;
begin
  Result := True;
  Erro := '';
  for Indice in fIndicesFaltando(Tabela) do
    if not fExecutar('ALTER TABLE ' + Tabela.Nome + ' ADD ' + Indice.Definicao, ErroIndice) then
    begin
      Result := False;
      if Erro <> '' then
        Erro := Erro + sLineBreak;
      Erro := Erro + 'Nao foi possivel criar o indice ' + Indice.Nome + ' em ' + Tabela.Nome + ': ' + ErroIndice;
    end;
end;

// A IMPTRI tem de ter a linha de referencia (CBS 9%, IBS 1%, IS 0%) quando esta vazia; o INSERT e idempotente, mas so
// roda com a tabela vazia para nao gerar LOGREP a cada subida.
function TEstruturaBanco.fGarantirAliquotaReferencia(out Erro: string): Boolean;
var
  Consulta: IReformaConsulta;
begin
  Erro := '';
  Consulta := FBanco.AbrirConsulta('SELECT 1 AS TEM FROM IMPTRI LIMIT 1');
  Consulta.Abrir;
  if not Consulta.Vazia then
    Exit(True);

  Result := fExecutar('INSERT INTO IMPTRI (CBS, IBS, `IS`) ' +
    'SELECT 9.00, 1.00, 0.00 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM IMPTRI)', Erro);
end;

function TEstruturaBanco.fPrepararTabela(const Tabela: TTabela; out Erro: string): Boolean;
var
  ErroIndice: string;
begin
  Erro := '';

  // Tabela do autcom: sem ela (banco incompleto) nao ha o que ajustar aqui.
  if Tabela.Sistema then
  begin
    if not FColunasExistentes.ContainsKey(UpperCase(Tabela.Nome)) then
      Exit(True);
    Exit(fAcrescentarColunas(Tabela, Erro));
  end;

  if not FColunasExistentes.ContainsKey(UpperCase(Tabela.Nome)) then
  begin
    Result := fExecutar(fSqlCriar(Tabela), Erro);
    if not Result then
    begin
      if not FAdiado then
        Erro := 'Nao foi possivel criar a tabela ' + Tabela.Nome + ': ' + Erro;
      Exit;
    end;
    pLerEstruturaAtual;
  end
  else
  begin
    Result := fAcrescentarColunas(Tabela, Erro);
    if not Result then
      Exit;
    if not fAcrescentarIndices(Tabela, ErroIndice) then
    begin
      Result := False;
      Erro := ErroIndice;
      Exit;
    end;
  end;

  if SameText(Tabela.Nome, TABELA_ALIQUOTAS) then
    Result := fGarantirAliquotaReferencia(Erro);
end;

function TEstruturaBanco.PrepararTabelas(const Nomes: array of string; out Mensagem: string): Boolean;
var
  Tabela: TTabela;
  Erro: string;
begin
  Result := True;
  Mensagem := '';
  FAdiado := False;

  try
    pLerTiposBanco;
    pMontarDefinicoes;
    pLerEstruturaAtual;

    for Tabela in FTabelas.ToArray do
    begin
      if (Length(Nomes) > 0) and not MatchText(Tabela.Nome, Nomes) then
        Continue;

      if not fPrepararTabela(Tabela, Erro) then
      begin
        Result := False;
        if Mensagem <> '' then
          Mensagem := Mensagem + sLineBreak;
        Mensagem := Mensagem + Erro;
        // Sem transacao livre nao adianta tentar as outras agora.
        if FAdiado then
          Exit;
      end;
    end;
  except
    // Excecao do host (classe de outro modulo): vira mensagem.
    on E: Exception do
    begin
      Result := False;
      Mensagem := 'Falha ao preparar as tabelas do plugin: ' + E.Message;
    end
    else
    begin
      Result := False;
      Mensagem := 'Falha ao preparar as tabelas do plugin.';
    end;
  end;
end;

// Lojas: a conversao roda no servidor e marca EMP_REFCON = 'S' (replica); a CFG_REFCIS (nao replica) e ligada aqui, na
// subida do autcom de cada base. So com a coluna existindo e so quando ha o que mudar (sem LOGREP a cada subida).
// Reverter (usuario, 2026-10-06): o EMP_REFCON fica 'R' (replica) e a REFCON da conversao e apagada; a CFG_REFCIS e
// desligada so na empresa com EMP_REFCON = 'R'. A convertida antes do EMP_REFCON existir ('N') nao e afetada.
function TEstruturaBanco.fSincronizarReforma(out Erro: string): Boolean;
const
  FILTRO_LIGAR = ' FROM CFGSIS C INNER JOIN CADEMP E ON E.EMP_CODEMP = C.SIS_CODEMP' +
    ' WHERE C.SIS_CODCFG = ''CFG_REFCIS'' AND E.EMP_REFCON = ''S'' AND C.SIS_VALCFG <> ''S''';
  FILTRO_DESLIGAR = ' FROM CFGSIS C INNER JOIN CADEMP E ON E.EMP_CODEMP = C.SIS_CODEMP' +
    ' WHERE C.SIS_CODCFG = ''CFG_REFCIS'' AND E.EMP_REFCON = ''R'' AND C.SIS_VALCFG <> ''N''';
var
  Consulta: IReformaConsulta;
begin
  Result := True;
  Erro := '';

  Consulta := FBanco.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.COLUMNS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ''CADEMP'' AND COLUMN_NAME = ''EMP_REFCON''');
  Consulta.Abrir;
  if StrToIntDef(VarToStr(Consulta.ValorCampo('QTD')), 0) = 0 then
    Exit;

  Consulta := FBanco.AbrirConsulta('SELECT COUNT(*) AS QTD' + FILTRO_LIGAR);
  Consulta.Abrir;
  if StrToIntDef(VarToStr(Consulta.ValorCampo('QTD')), 0) > 0 then
  begin
    Result := fExecutar('UPDATE CFGSIS C INNER JOIN CADEMP E ON E.EMP_CODEMP = C.SIS_CODEMP SET C.SIS_VALCFG = ''S''' +
      ' WHERE C.SIS_CODCFG = ''CFG_REFCIS'' AND E.EMP_REFCON = ''S'' AND C.SIS_VALCFG <> ''S''', Erro);
    if not Result then
    begin
      if not FAdiado then
        Erro := 'Nao foi possivel ligar a CFG_REFCIS das empresas convertidas: ' + Erro;
      Exit;
    end;
  end;

  Consulta := FBanco.AbrirConsulta('SELECT COUNT(*) AS QTD' + FILTRO_DESLIGAR);
  Consulta.Abrir;
  if StrToIntDef(VarToStr(Consulta.ValorCampo('QTD')), 0) = 0 then
    Exit;

  Result := fExecutar('UPDATE CFGSIS C INNER JOIN CADEMP E ON E.EMP_CODEMP = C.SIS_CODEMP SET C.SIS_VALCFG = ''N''' +
    ' WHERE C.SIS_CODCFG = ''CFG_REFCIS'' AND E.EMP_REFCON = ''R'' AND C.SIS_VALCFG <> ''N''', Erro);
  if not Result and not FAdiado then
    Erro := 'Nao foi possivel desligar a CFG_REFCIS das empresas revertidas: ' + Erro;
end;

function TEstruturaBanco.Preparar(out Mensagem: string): Boolean;
var
  Erro: string;
begin
  Result := PrepararTabelas([], Mensagem);
  if FAdiado then
    Exit;

  try
    if not fSincronizarReforma(Erro) then
    begin
      Result := False;
      if Mensagem <> '' then
        Mensagem := Mensagem + sLineBreak;
      Mensagem := Mensagem + Erro;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      Mensagem := 'Falha ao ligar a CFG_REFCIS das empresas convertidas: ' + E.Message;
    end
    else
    begin
      Result := False;
      Mensagem := 'Falha ao ligar a CFG_REFCIS das empresas convertidas.';
    end;
  end;
end;

end.
