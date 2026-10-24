unit Reforma.Convert.Processo;

// Convert (REFTRI-02): orquestra as tres fases da conversao. A DLL decide o que converter; o host calcula e grava pelo
// motor nativo (IReformaConvertHost).
//  P (preparacao, RN11): calcula todos os itens so em memoria no host e grava ITEREF (valores novos) e ITEREO (valores
//    atuais) em blocos de 100 linhas, cada bloco com a ITEREO das proprias linhas na mesma transacao (decisao do
//    usuario, 2026-10-05: nunca fica ITEREF sem backup). Ao fim, o grupo de precos recebe os valores do ultimo (RN23).
//    As aliquotas CBS/IBS/IS do preco (RN09) vem da IMPTRI (tabela estatica) ou, por item, da procedure
//    pRefTrib_CalculaAliquotasEfetivasItens (abreviacao do item); nesse caso todos os itens sao conferidos antes e,
//    faltando aliquota em algum, a conversao nao comeca (usuario, 2026-10-05).
//  A (aplicacao, RN12): por lote de 1000 itens, numa transacao: confere que o produto nao mudou, o host grava a ITEREF
//    no produto e o lote fica aplicado.
//  C (conferencia e ativacao, RN18/RN19): limpa o lixo (item excluido), confere e, sem divergencia bloqueante, liga a
//    CFG_REFCIS na logada e nas empresas que usam o preco dela.
// Tudo que grava vai pela porta do host (LOGREP). Nenhum valor vem da data do MySQL nem de AUTO_INCREMENT: a chave e um GUID e as
// datas vem de IReformaConvertHost.DataHora (RN17). A conversao para e retoma pela REFCON (RN16), mas falha antes de
// qualquer lote aplicado volta ao inicio: apaga REFCON, ITEREF, ITEREO e REFDIV da chave, como se nunca tivesse
// comecado (usuario, 2026-10-05). Tratamento que acha mais de um item devolve a lista inteira em Detalhes.

interface

uses
  System.Classes,
  System.Generics.Collections,
  Reforma.Contrato.Tipos,
  Reforma.Contrato.Gravacao,
  Reforma.Contrato.Host,
  Reforma.Contrato.Convert,
  Reforma.Convert.Estrutura;

const
  // Itens de L por lote (REF_LOTE). Era 10 enquanto a Fase A rodava a cascata de triggers da PREPRO (cerca de 1 segundo
  // por lote de 10; com 1000, cerca de 2 minutos e a janela congelada). Sem a cascata (2026-10-06) o lote de 10 leva
  // cerca de 150 ms e o custo fixo de cada lote (conferencia, marcacao, commit) pesa: 100 (usuario, 2026-10-06).
  TAMANHO_LOTE = 100;

  // Fase P: itens calculados em memoria antes de gravar ITEREF/ITEREO (sempre em lotes inteiros). Cada gravacao sao
  // poucos comandos (INSERT de varias linhas + copia do ITEGER por origem + ITEREO), e a memoria fica limitada (o exe e
  // 32 bits: guardar a base inteira com muitas lojas nao cabe).
  TAMANHO_GRAVACAO = 500;
  // Linhas por INSERT de varias linhas.
  LINHAS_POR_INSERT = 250;

type
  TFaseConversao = (fcNova, fcPreparando, fcAplicando, fcConcluida, fcDivergente);

  // Origem de CBS/IBS/IS: IMPTRI (1a linha) ou a procedure de aliquotas efetivas pela abreviacao do item.
  TOrigemImpostosConversao = (oicTabelaEstatica, oicAbreviacaoItem);

  // Opcoes da tela, gravadas na REFCON (a retomada usa as gravadas).
  TParametrosConversao = record
    Opcao: TOpcaoConversao;
    Origem: TOrigemImpostosConversao;
    SomenteAtivos: Boolean;
    // Filtro de itens do operador 998 (fNormalizarItensConvert): codigos separados por ';'; vazio = todos.
    Itens: string;
  end;

  TSituacaoConversao = record
    Chave: string;
    Fase: TFaseConversao;
    Parametros: TParametrosConversao;
  end;

  TFuncaoFaseConvert = reference to function(const Progresso: IReformaProgresso): TResultadoGravacao;

  TProcessoConversao = class
  strict private
    FHost: IReformaConvertHost;
    FEstrutura: TEstruturaConvert;
    FChave: string;
    FOpcao: TOpcaoConversao;
    FOrigem: TOrigemImpostosConversao;
    FSomenteAtivos: Boolean;
    FItens: string;
    FEmpresa: string;
    FEmpresasF: TArray<string>;
    FDecimais: Integer;
    FCbs: Variant;
    FIbs: Variant;
    FImpostoSeletivo: Variant;
    FAliquotasTabela: TAliquotasReforma;
    FAliquotasItem: TDictionary<string, TAliquotasReforma>;
    FTravado: Boolean;
    FJaConcluida: Boolean;
    FAtivou: Boolean;
    FBloqueantes: Integer;
    FAlertas: Integer;
    FDetalhes: TStringList;
    // Gravacao da ITEREF em bloco: INSERT so com as colunas calculadas (o resto nasce NULL) e, por origem (L, F, R), um
    // UPDATE que copia do ITEGER as demais (F e R levam da logada os campos de custo que o host indica).
    FSqlIterefInsert: string;
    FSqlIterefValores: string;
    FSqlIterefCopia: array['F'..'R'] of string;
    FSqlIterefBackup: string;
    // CFG_TABPRD (usuario, 2026-10-19): TABDET/DETCUS acompanham a aplicacao. FTabelasFornecedor: as tabelas e colunas
    // existem neste banco; FTabelasLigadas: as tabelas de preco ativas com ITEGER.ITE_TABPRn; FCustoTabelaFornecedor: a
    // funcao fCalculaPrecodeCusto existe (custo das TABDET alem da 1a sem o ITE_SUBFED).
    FTabelasFornecedor: Boolean;
    FTabelasLigadas: TArray<Integer>;
    FCustoTabelaFornecedor: Boolean;
    function fEmpresasAfetadas: TArray<string>;
    function fNomeTrava: string;
    function fPrepararAmbiente(out Mensagem: string): Boolean;
    procedure pLerAliquotas;
    procedure pDefinirParametros(const Parametros: TParametrosConversao);
    function fAliquotasDoItem(const Item: string): TAliquotasReforma;
    function fConferirRefcis(out Mensagem: string): Boolean;
    function fTravar(out Mensagem: string): Boolean;
    procedure pDestravar;
    function fIniciarConversao: TResultadoGravacao;
    function fGarantirEmpresasRefcon: TResultadoGravacao;
    function fDefinirFase(const Fase: Char): TResultadoGravacao;
    procedure pMontarSqlItem;
    function fComandoGrupo: TComandoSql;
    function fPreparar(const Progresso: IReformaProgresso): TResultadoGravacao;
    function fAplicar(const Progresso: IReformaProgresso): TResultadoGravacao;
    function fDescartarPendentes(const Alterados: TList<TPair<string, string>>): TResultadoGravacao;
    function fLimparExcluidos: TResultadoGravacao;
    function fConferirEAtivar(const Progresso: IReformaProgresso): TResultadoGravacao;
    function fExecutarFase(const Titulo: string; const Funcao: TFuncaoFaseConvert; out Mensagem: string): Boolean;
    function fComandosZerarImpostosFederais(const Empresa: string): TArray<TComandoSql>;
    function fResumo: string;
    function fCamposAbreviacao(out Mensagem: string): Boolean;
    function fMarcadaConvertida: Boolean;
    function fItensSemPrePro: TResultadoGravacao;
    function fResultadoLista(const Cabecalho: string; const Linhas: TStrings): TResultadoGravacao;
    procedure pVoltarAoInicio(var Mensagem: string);
    function fSqlFiltroItens(const Coluna: string): string;
    function fParametrosFiltroItens: TArray<TValorCampo>;
    procedure pDefinirFiltroItens(const Consulta: IReformaConsulta);
    function fCondicaoAlterado: string;
    function fConfirmarAlterados: TResultadoGravacao;
    function fReverter(const Progresso: IReformaProgresso): TResultadoGravacao;
    function fAtualizarAbreviacoes: TResultadoGravacao;
    procedure pLerTabelasFornecedor;
    function fComandosTabelasFornecedor(const Lote: Integer): TArray<TComandoSql>;
    function fComandosReverterTabelasFornecedor(const Lote: Integer): TArray<TComandoSql>;
  public
    constructor Create(const Host: IReformaConvertHost);
    destructor Destroy; override;
    // Ultima conversao da empresa logada pela REFCON. Sem a tabela ou sem linha: fcNova.
    class function Situacao(const Host: IReformaConvertHost): TSituacaoConversao; static;
    // Executa a conversao inteira (nova ou retomada). Mensagem: resumo final ou motivo da parada.
    function Executar(const Parametros: TParametrosConversao; out Mensagem: string): Boolean;
    // So a Fase C (botao Conferir), para a ultima conversao em 'C' ou 'D'.
    function Conferir(out Mensagem: string): Boolean;
    // Reverter (usuario, 2026-10-06): a ultima conversao da logada volta aos valores de antes (ITEREO) em ITEGER/PREPRO,
    // lote a lote, e no fim a CFG_REFCIS das empresas dela volta a 'N', o EMP_REFCON fica 'R' e a ITEREO, a ITEREF, a
    // REFDIV e a REFCON da chave sao apagadas. Item alterado depois da conversao: o operador decide se reverte tambem.
    // Parou no meio: Reverter de novo continua.
    function Reverter(out Mensagem: string): Boolean;
    // Itens (ou empresas) do tratamento que parou a execucao, quando sao mais de um; a Mensagem e o cabecalho.
    function Detalhes: TArray<string>;
  end;

// Filtro de itens do operador 998 (usuario, 2026-10-06): codigos separados por virgula, ponto e virgula, espaco ou
// quebra de linha, com ou sem aspas ('90401', '90402'). Devolve os codigos separados por ';', sem repetir; vazio = todos.
function fNormalizarItensConvert(const Texto: string): string;

implementation

uses
  System.SysUtils,
  System.Types,
  System.StrUtils,
  System.Variants,
  System.JSON,
  Reforma.Repositorio.Estrutura,
  Reforma.Convert.Regra,
  Reforma.Convert.Conferencia;

type
  // IReformaTarefa sobre uma fase do processo: o host a roda dentro do frmGravando. Nenhuma excecao sai daqui.
  TTarefaConvert = class(TInterfacedObject, IReformaTarefa)
  strict private
    FFuncao: TFuncaoFaseConvert;
  public
    constructor Create(const Funcao: TFuncaoFaseConvert);
    function Executar(const Progresso: IReformaProgresso): TResultadoGravacao;
  end;

  // Linha calculada da ITEREF, guardada ate a gravacao do bloco.
  TLinhaIteref = record
    Lote: Integer;
    Item: string;
    Valores: TValoresConversao;
    Dpisco: Variant;
    Aliquotas: TAliquotasReforma;
  end;

  // Item da logada ainda sem ITEREF na chave: ITEGER atual e REFPRE.
  TItemPendente = record
    Origem: TItemOrigemConversao;
    Ncm: string;
    NcmExcecao: string;
    Abreviacao: string;
    PrecoCompra: Double;
    DespesaOperacional: Double;
    TemRefpre: Boolean;
    Desconto: Double;
    DespesaRefpre: Double;
  end;

const
  TITULO_REVERTER = 'Reverter conversão';
  MENSAGEM_JA_CONVERTIDA = 'Empresa já convertida.';
  MENSAGEM_ALTERADOS = 'Produtos alterados durante a conversão. Execute novamente para recalcular os itens pendentes.';

function fCodigoOpcao(const Opcao: TOpcaoConversao): string;
begin
  if Opcao = ocvRecalcularMargem then
    Result := 'M'
  else
    Result := 'P';
end;

function fCodigoOrigem(const Origem: TOrigemImpostosConversao): string;
begin
  if Origem = oicAbreviacaoItem then
    Result := 'A'
  else
    Result := 'T';
end;

function fCodigoSimNao(const Valor: Boolean): string;
begin
  if Valor then
    Result := 'S'
  else
    Result := 'N';
end;

function fNormalizarItensConvert(const Texto: string): string;
var
  Partes: TStringList;
  Parte: string;
  Codigo: string;
begin
  Partes := TStringList.Create;
  try
    Partes.Sorted := True;
    Partes.Duplicates := dupIgnore;
    Partes.CaseSensitive := False;
    for Parte in SplitString(Texto, ',; ' + #9 + #13 + #10) do
    begin
      Codigo := Trim(StringReplace(StringReplace(Parte, '''', '', [rfReplaceAll]), '"', '', [rfReplaceAll]));
      if Codigo <> '' then
        Partes.Add(Codigo);
    end;
    Partes.Delimiter := ';';
    Partes.StrictDelimiter := True;
    Result := Partes.DelimitedText;
  finally
    Partes.Free;
  end;
end;

// Texto vazio vai como NULL.
function fTextoOuNulo(const Texto: string): Variant;
begin
  if Texto = '' then
    Result := Null
  else
    Result := Texto;
end;

function fListaTexto(const Lista: TArray<string>): string;
var
  Texto: string;
begin
  Result := '';
  for Texto in Lista do
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + Texto;
  end;
end;

{ TTarefaConvert }

constructor TTarefaConvert.Create(const Funcao: TFuncaoFaseConvert);
begin
  inherited Create;
  FFuncao := Funcao;
end;

function TTarefaConvert.Executar(const Progresso: IReformaProgresso): TResultadoGravacao;
begin
  try
    Result := FFuncao(Progresso);
  except
    Result := fResultadoConvert(False, fMensagemExcecaoConvert);
  end;
end;

{ TProcessoConversao }

constructor TProcessoConversao.Create(const Host: IReformaConvertHost);
begin
  inherited Create;
  FHost := Host;
  FEstrutura := TEstruturaConvert.Create(Host);
  FCbs := Null;
  FIbs := Null;
  FImpostoSeletivo := Null;
  FAliquotasItem := TDictionary<string, TAliquotasReforma>.Create;
  FDetalhes := TStringList.Create;
end;

destructor TProcessoConversao.Destroy;
begin
  pDestravar;
  FreeAndNil(FAliquotasItem);
  FreeAndNil(FDetalhes);
  FreeAndNil(FEstrutura);
  inherited Destroy;
end;

class function TProcessoConversao.Situacao(const Host: IReformaConvertHost): TSituacaoConversao;
var
  Consulta: IReformaConsulta;
  Fase: string;
begin
  Result.Chave := '';
  Result.Fase := fcNova;
  Result.Parametros.Opcao := ocvRecalcularPrecoVenda;
  Result.Parametros.Origem := oicTabelaEstatica;
  Result.Parametros.SomenteAtivos := True;
  Result.Parametros.Itens := '';

  Consulta := Host.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.TABLES ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :TABELA');
  Consulta.DefinirParametro('TABELA', 'REFCON');
  Consulta.Abrir;
  if fNumeroConvert(Consulta.ValorCampo('QTD')) = 0 then
    Exit;

  Consulta := Host.AbrirConsulta('SELECT CON_CHAVE, CON_FASE, CON_OPCAO, CON_ORIIMP, CON_SOATIV, CON_FILITE FROM REFCON ' +
    'WHERE CON_CODEMP = :CODEMP AND CON_ORIGEM = ''L'' ORDER BY CON_ID DESC LIMIT 1');
  Consulta.DefinirParametro('CODEMP', Host.CodigoEmpresa);
  Consulta.Abrir;
  if Consulta.Vazia then
    Exit;

  Result.Chave := fTextoConvert(Consulta.ValorCampo('CON_CHAVE'));
  Fase := fTextoConvert(Consulta.ValorCampo('CON_FASE'));
  if Fase = 'P' then
    Result.Fase := fcPreparando
  else if Fase = 'A' then
    Result.Fase := fcAplicando
  else if Fase = 'C' then
    Result.Fase := fcConcluida
  else if Fase = 'D' then
    Result.Fase := fcDivergente;
  if fTextoConvert(Consulta.ValorCampo('CON_OPCAO')) = 'M' then
    Result.Parametros.Opcao := ocvRecalcularMargem;
  if fTextoConvert(Consulta.ValorCampo('CON_ORIIMP')) = 'A' then
    Result.Parametros.Origem := oicAbreviacaoItem;
  Result.Parametros.SomenteAtivos := fTextoConvert(Consulta.ValorCampo('CON_SOATIV')) <> 'N';
  Result.Parametros.Itens := fTextoConvert(Consulta.ValorCampo('CON_FILITE'));
end;

function TProcessoConversao.fEmpresasAfetadas: TArray<string>;
begin
  Result := [FEmpresa] + FEmpresasF;
end;

function TProcessoConversao.fNomeTrava: string;
begin
  Result := 'REFTRI_CONVERT_' + FEmpresa;
end;

procedure TProcessoConversao.pLerAliquotas;
var
  Consulta: IReformaConsulta;
begin
  // Tabela estatica (1a linha da IMPTRI). Sem linha, ou campo nulo, a aliquota e zero e o preco fica o do ITEGER.
  FAliquotasTabela.Cbs := 0;
  FAliquotasTabela.Ibs := 0;
  FAliquotasTabela.ImpostoSeletivo := 0;
  Consulta := FHost.AbrirConsulta('SELECT CBS, IBS, `IS` FROM IMPTRI LIMIT 1');
  Consulta.Abrir;
  if Consulta.Vazia then
    Exit;
  FCbs := Consulta.ValorCampo('CBS');
  FIbs := Consulta.ValorCampo('IBS');
  FImpostoSeletivo := Consulta.ValorCampo('IS');
  FAliquotasTabela.Cbs := fNumeroConvert(FCbs);
  FAliquotasTabela.Ibs := fNumeroConvert(FIbs);
  FAliquotasTabela.ImpostoSeletivo := fNumeroConvert(FImpostoSeletivo);
end;

procedure TProcessoConversao.pDefinirParametros(const Parametros: TParametrosConversao);
begin
  FOpcao := Parametros.Opcao;
  FOrigem := Parametros.Origem;
  FSomenteAtivos := Parametros.SomenteAtivos;
  FItens := fNormalizarItensConvert(Parametros.Itens);
  // Na REFCON as aliquotas so fazem sentido com a tabela estatica; por item elas ficam na ITEREF.
  if FOrigem = oicAbreviacaoItem then
  begin
    FCbs := Null;
    FIbs := Null;
    FImpostoSeletivo := Null;
  end;
end;

function TProcessoConversao.fAliquotasDoItem(const Item: string): TAliquotasReforma;
begin
  if (FOrigem = oicTabelaEstatica) or not FAliquotasItem.TryGetValue(Item, Result) then
    Result := FAliquotasTabela;
end;

// RN24: a linha CFG_REFCIS tem de existir em todas as empresas afetadas antes de qualquer preco mudar.
function TProcessoConversao.fConferirRefcis(out Mensagem: string): Boolean;
var
  Empresa: string;
  Consulta: IReformaConsulta;
  Faltando: TStringList;
begin
  Faltando := TStringList.Create;
  try
    for Empresa in fEmpresasAfetadas do
    begin
      Consulta := FHost.AbrirConsulta('SELECT COUNT(*) AS QTD FROM CFGSIS WHERE SIS_CODEMP = :CODEMP ' +
        'AND SIS_CODCFG = :CODCFG');
      Consulta.DefinirParametro('CODEMP', Empresa);
      Consulta.DefinirParametro('CODCFG', 'CFG_REFCIS');
      Consulta.Abrir;
      if fNumeroConvert(Consulta.ValorCampo('QTD')) = 0 then
        Faltando.Add(Empresa);
    end;
    Result := Faltando.Count = 0;
    if Faltando.Count = 1 then
      Mensagem := 'Configuração CFG_REFCIS não encontrada para a empresa ' + Faltando[0] + '.'
    else if Faltando.Count > 1 then
      Mensagem := fResultadoLista('Configuração CFG_REFCIS não encontrada em ' + IntToStr(Faltando.Count) +
        ' empresas:', Faltando).Mensagem;
  finally
    Faltando.Free;
  end;
end;

function TProcessoConversao.fPrepararAmbiente(out Mensagem: string): Boolean;
var
  Empresa: string;
begin
  Result := False;
  if not FEstrutura.Validar(Mensagem) then
    Exit;

  FEmpresa := FHost.CodigoEmpresa;
  FEmpresasF := nil;
  for Empresa in SplitString(FHost.EmpresasPrecoMatriz, ';') do
    if (Trim(Empresa) <> '') and (Trim(Empresa) <> FEmpresa) then
      FEmpresasF := FEmpresasF + [Trim(Empresa)];
  FDecimais := FHost.DecimaisUnitarios;
  pLerTabelasFornecedor;

  pLerAliquotas;
  if not fConferirRefcis(Mensagem) then
    Exit;

  pMontarSqlItem;
  Result := True;
end;

// RN16: uma estacao por vez. GET_LOCK roda na mesma conexao que grava (a do host).
function TProcessoConversao.fTravar(out Mensagem: string): Boolean;
var
  Consulta: IReformaConsulta;
begin
  Consulta := FHost.AbrirConsulta('SELECT GET_LOCK(:NOME, 0) AS OK');
  Consulta.DefinirParametro('NOME', fNomeTrava);
  Consulta.Abrir;
  FTravado := fNumeroConvert(Consulta.ValorCampo('OK')) = 1;
  Result := FTravado;
  if not Result then
    Mensagem := 'A ativação dos preços já está em execução em outra estação.';
end;

procedure TProcessoConversao.pDestravar;
var
  Consulta: IReformaConsulta;
begin
  if not FTravado then
    Exit;
  FTravado := False;
  try
    Consulta := FHost.AbrirConsulta('SELECT RELEASE_LOCK(:NOME) AS OK');
    Consulta.DefinirParametro('NOME', fNomeTrava);
    Consulta.Abrir;
  except
    // A trava cai sozinha quando a conexao fecha.
  end;
end;

function TProcessoConversao.fIniciarConversao: TResultadoGravacao;
var
  Comandos: TArray<TComandoSql>;
  Empresa: string;
  Momento: TDateTime;
  Origem: string;
begin
  Momento := FHost.DataHora;
  Comandos := nil;
  for Empresa in fEmpresasAfetadas do
  begin
    Origem := IfThen(Empresa = FEmpresa, 'L', 'F');
    Comandos := Comandos + [fComandoConvert(
      'INSERT INTO REFCON (CON_CHAVE, CON_CODEMP, CON_EMPORI, CON_ORIGEM, CON_OPCAO, CON_FASE, CON_CODOPE, ' +
      'CON_DTAINI, CON_HORINI, CON_ALQCBS, CON_ALQIBS, CON_ALQIS, CON_ORIIMP, CON_SOATIV, CON_FILITE) VALUES (:CHAVE, ' +
      ':CODEMP, :EMPORI, :ORIGEM, :OPCAO, ''P'', :CODOPE, :DTAINI, :HORINI, :CBS, :IBS, :ISEL, :ORIIMP, :SOATIV, :FILITE)',
      [fParametroConvert('CHAVE', FChave),
       fParametroConvert('CODEMP', Empresa),
       fParametroConvert('EMPORI', FEmpresa),
       fParametroConvert('ORIGEM', Origem),
       fParametroConvert('OPCAO', fCodigoOpcao(FOpcao)),
       fParametroConvert('CODOPE', FHost.Operador),
       fParametroConvert('DTAINI', fDataConvert(Momento)),
       fParametroConvert('HORINI', fHoraConvert(Momento)),
       fParametroConvert('CBS', FCbs),
       fParametroConvert('IBS', FIbs),
       fParametroConvert('ISEL', FImpostoSeletivo),
       fParametroConvert('ORIIMP', fCodigoOrigem(FOrigem)),
       fParametroConvert('SOATIV', fCodigoSimNao(FSomenteAtivos)),
       fParametroConvert('FILITE', fTextoOuNulo(FItens))])];
  end;
  Result := fGravarConvert(FHost, Comandos);
end;

// Retomada: empresa que passou a usar o preco da logada depois do inicio ganha a linha dela na REFCON.
function TProcessoConversao.fGarantirEmpresasRefcon: TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Existentes: TList<string>;
  Comandos: TArray<TComandoSql>;
  Empresa: string;
  Momento: TDateTime;
begin
  Existentes := TList<string>.Create;
  try
    Consulta := FHost.AbrirConsulta('SELECT CON_CODEMP FROM REFCON WHERE CON_CHAVE = :CHAVE');
    Consulta.DefinirParametro('CHAVE', FChave);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Existentes.Add(fTextoConvert(Consulta.ValorCampo('CON_CODEMP')));
      Consulta.Proximo;
    end;

    Momento := FHost.DataHora;
    Comandos := nil;
    for Empresa in FEmpresasF do
      if not Existentes.Contains(Empresa) then
        Comandos := Comandos + [fComandoConvert(
          'INSERT INTO REFCON (CON_CHAVE, CON_CODEMP, CON_EMPORI, CON_ORIGEM, CON_OPCAO, CON_FASE, CON_CODOPE, ' +
          'CON_DTAINI, CON_HORINI, CON_ALQCBS, CON_ALQIBS, CON_ALQIS, CON_ORIIMP, CON_SOATIV, CON_FILITE) VALUES (' +
          ':CHAVE, :CODEMP, :EMPORI, ''F'', :OPCAO, ''P'', :CODOPE, :DTAINI, :HORINI, :CBS, :IBS, :ISEL, :ORIIMP, :SOATIV, ' +
          ':FILITE)',
          [fParametroConvert('CHAVE', FChave),
           fParametroConvert('CODEMP', Empresa),
           fParametroConvert('EMPORI', FEmpresa),
           fParametroConvert('OPCAO', fCodigoOpcao(FOpcao)),
           fParametroConvert('CODOPE', FHost.Operador),
           fParametroConvert('DTAINI', fDataConvert(Momento)),
           fParametroConvert('HORINI', fHoraConvert(Momento)),
           fParametroConvert('CBS', FCbs),
           fParametroConvert('IBS', FIbs),
           fParametroConvert('ISEL', FImpostoSeletivo),
           fParametroConvert('ORIIMP', fCodigoOrigem(FOrigem)),
           fParametroConvert('SOATIV', fCodigoSimNao(FSomenteAtivos)),
           fParametroConvert('FILITE', fTextoOuNulo(FItens))])];
  finally
    Existentes.Free;
  end;

  if Length(Comandos) = 0 then
    Exit(fResultadoConvert(True, ''));
  Result := fGravarConvert(FHost, Comandos);
end;

// EMP_REFCON = 'S': a empresa ja foi convertida (pelo Convert desta base ou, na loja, pela replicacao).
function TProcessoConversao.fMarcadaConvertida: Boolean;
var
  Consulta: IReformaConsulta;
begin
  Consulta := FHost.AbrirConsulta('SELECT EMP_REFCON FROM CADEMP WHERE EMP_CODEMP = :CODEMP');
  Consulta.DefinirParametro('CODEMP', FEmpresa);
  Consulta.Abrir;
  Result := (not Consulta.Vazia) and SameText(fTextoConvert(Consulta.ValorCampo('EMP_REFCON')), 'S');
end;

function TProcessoConversao.fDefinirFase(const Fase: Char): TResultadoGravacao;
begin
  Result := fGravarConvert(FHost, [fComandoConvert('UPDATE REFCON SET CON_FASE = :FASE WHERE CON_CHAVE = :CHAVE',
    [fParametroConvert('FASE', string(Fase)), fParametroConvert('CHAVE', FChave)])]);
end;

// Valor da linha que o host calculou para a coluna, quando a coluna e calculada (as outras vem do ITEGER).
function fValorCalculado(const Coluna: string; const Valores: TValoresConversao; out Valor: Double): Boolean;
var
  Tabela: Integer;
  Sufixo: string;
begin
  Result := True;
  if SameText(Coluna, 'ITE_PRECOM') then
    Valor := Valores.PrecoCompra
  else if SameText(Coluna, 'ITE_PRECUS') then
    Valor := Valores.PrecoCusto
  else if SameText(Coluna, 'ITE_IMPFED') then
    Valor := Valores.ImpostoFederal
  else if SameText(Coluna, 'ITE_SUBFED') then
    Valor := Valores.SubFederal
  else if SameText(Coluna, 'ITE_ALQFED') then
    Valor := Valores.AliquotaFederal
  else if SameText(Coluna, 'ITE_DESOPE') then
    Valor := Valores.DespesaOperacional
  else if SameText(Coluna, 'ITE_ICMSAI') then
    Valor := Valores.IcmsSaida
  else if SameText(Coluna, 'ITE_OUTVAL') then
    Valor := Valores.OutrosValores
  // ALQENT zerado em todas as empresas da conversao (usuario, 2026-10-05), como o ALQFED.
  else if SameText(Coluna, 'ITE_ALQENT') then
    Valor := 0
  else
  begin
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      Sufixo := IntToStr(Tabela);
      if SameText(Coluna, 'ITE_PREVE' + Sufixo) then
      begin
        Valor := Valores.PrecoVenda[Tabela];
        Exit;
      end;
      if SameText(Coluna, 'ITE_MARBR' + Sufixo) then
      begin
        Valor := Valores.MargemBruta[Tabela];
        Exit;
      end;
      if SameText(Coluna, 'ITE_COMTB' + Sufixo) then
      begin
        Valor := Valores.Comissao[Tabela];
        Exit;
      end;
    end;
    Result := False;
  end;
end;

// O texto da ITEREF e da copia para a ITEREO nao muda durante a conversao: montado uma vez, com as colunas deste banco.
procedure TProcessoConversao.pMontarSqlItem;
var
  Coluna: string;
  Colunas: string;
  Copia: string;
  Exemplo: TValoresConversao;
  Numero: Double;

  // Colunas nao calculadas: as que a origem recebe da logada vem do ITEGER dela (L); o resto, da propria empresa (G).
  function fSqlCopia(const Origem: Char): string;
  var
    Campo: string;
    DaLogada: TStringDynArray;
    Atribuicoes: string;
  begin
    if Origem = 'L' then
      DaLogada := nil
    else
      DaLogada := SplitString(UpperCase(FHost.CamposCustoDaLogada(Origem)), ';');
    Atribuicoes := '';
    for Campo in FEstrutura.Colunas do
      if not fValorCalculado(Campo, Exemplo, Numero) then
      begin
        if Atribuicoes <> '' then
          Atribuicoes := Atribuicoes + ', ';
        if MatchText(Campo, DaLogada) then
          Atribuicoes := Atribuicoes + 'F.' + Campo + ' = L.' + Campo
        else
          Atribuicoes := Atribuicoes + 'F.' + Campo + ' = G.' + Campo;
      end;
    Result := '';
    if Atribuicoes <> '' then
      Result := 'UPDATE ITEREF F' +
        ' INNER JOIN ITEGER G ON G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE' +
        ' INNER JOIN ITEGER L ON L.ITE_CODEMP = :LOGADA AND L.ITE_CODITE = F.ITE_CODITE' +
        ' SET ' + Atribuicoes +
        ' WHERE F.REF_CHAVE = :CHAVE AND F.REF_ORIGEM = :ORIGEM AND F.REF_LOTE BETWEEN :LOTEINI AND :LOTEFIM';
  end;

begin
  Exemplo := Default(TValoresConversao);
  Colunas := '';
  Copia := '';
  FSqlIterefValores := '';
  for Coluna in FEstrutura.Colunas do
  begin
    Colunas := Colunas + ', ' + Coluna;
    Copia := Copia + ', G.' + Coluna;
    if fValorCalculado(Coluna, Exemplo, Numero) then
      FSqlIterefValores := FSqlIterefValores + ', ' + Coluna;
  end;

  // Cabecalho do INSERT de varias linhas; os VALUES de cada linha sao montados na gravacao do bloco.
  FSqlIterefInsert := 'INSERT INTO ITEREF (REF_CHAVE, REF_LOTE, REF_ORIGEM, REF_APLICADO, ITE_CODEMP, ITE_CODITE' +
    FSqlIterefValores + ', ITE_DPISCO, ITE_CBS, ITE_IBS, ITE_IS) VALUES ';
  FSqlIterefCopia['L'] := fSqlCopia('L');
  FSqlIterefCopia['F'] := fSqlCopia('F');
  FSqlIterefCopia['R'] := fSqlCopia('R');

  FSqlIterefBackup :=
    'INSERT INTO ITEREO (REF_CHAVE, REF_LOTE, REF_ORIGEM, REF_APLICADO, ITE_CODEMP, ITE_CODITE' + Colunas + ')' +
    ' SELECT F.REF_CHAVE, F.REF_LOTE, F.REF_ORIGEM, ''N'', G.ITE_CODEMP, G.ITE_CODITE' + Copia +
    ' FROM ITEREF F' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE' +
    ' LEFT JOIN ITEREO O ON O.REF_CHAVE = F.REF_CHAVE AND O.ITE_CODEMP = F.ITE_CODEMP AND O.ITE_CODITE = F.ITE_CODITE' +
    ' WHERE F.REF_CHAVE = :CHAVE AND F.REF_LOTE BETWEEN :LOTEINI AND :LOTEFIM AND O.REF_ID IS NULL';
end;

// RN23: no grupo de precos (CADITE.ITE_CODGPR) vale o ultimo processado, o item de maior codigo, em cada empresa.
// Teste de 2026-10-15: o item novo do grupo, sem REFPRE, era o de maior codigo e levava o calculo "sem REFPRE" para o
// grupo todo. Agora vale o maior codigo entre os que tem REFPRE na logada (REF_ORIGEM 'L'); sem nenhum, o maior codigo.
// So as linhas ainda nao aplicadas recebem a copia; ITE_DPISCO/CBS/IBS/IS ficam como estavam.
function TProcessoConversao.fComandoGrupo: TComandoSql;
var
  Coluna: string;
  Lista: string;
begin
  Lista := '';
  for Coluna in FEstrutura.Colunas do
  begin
    if Lista <> '' then
      Lista := Lista + ', ';
    Lista := Lista + 'D.' + Coluna + ' = O.' + Coluna;
  end;

  Result := fComandoConvert(
    'UPDATE ITEREF D' +
    ' INNER JOIN CADITE CD ON CD.ITE_CODITE = D.ITE_CODITE' +
    ' INNER JOIN (SELECT C.ITE_CODGPR,' +
    '                    COALESCE(MAX(CASE WHEN R.ITE_CODITE IS NOT NULL THEN C.ITE_CODITE END), MAX(C.ITE_CODITE)) AS ULTIMO' +
    '               FROM CADITE C' +
    '              INNER JOIN ITEREF X ON X.ITE_CODITE = C.ITE_CODITE AND X.REF_CHAVE = :CHAVE1' +
    '               LEFT JOIN REFPRE R ON R.ITE_CODEMP = X.ITE_CODEMP AND R.ITE_CODITE = X.ITE_CODITE AND X.REF_ORIGEM = ''L''' +
    '             WHERE IFNULL(C.ITE_CODGPR, '''') <> '''' GROUP BY C.ITE_CODGPR) U ON U.ITE_CODGPR = CD.ITE_CODGPR' +
    ' INNER JOIN ITEREF O ON O.REF_CHAVE = D.REF_CHAVE AND O.ITE_CODEMP = D.ITE_CODEMP AND O.ITE_CODITE = U.ULTIMO' +
    ' SET ' + Lista +
    ' WHERE D.REF_CHAVE = :CHAVE2 AND D.REF_APLICADO = ''N'' AND D.ITE_CODITE <> U.ULTIMO',
    [fParametroConvert('CHAVE1', FChave), fParametroConvert('CHAVE2', FChave)]);
end;

function fMensagemSemAliquota(const Itens: TStringList): string;
begin
  Result := IntToStr(Itens.Count) + ' item(ns) sem alíquota de CBS/IBS/IS pela abreviação do item. ' +
    'Todos têm de ser ajustados antes da conversão:';
end;

function TProcessoConversao.fResultadoLista(const Cabecalho: string; const Linhas: TStrings): TResultadoGravacao;
begin
  FDetalhes.Assign(Linhas);
  Result := fResultadoConvert(False, Cabecalho);
end;

function TProcessoConversao.Detalhes: TArray<string>;
begin
  Result := FDetalhes.ToStringArray;
end;

// 150.x: o motor do cadastro so calcula item com PREPRO nas tabelas ativas (sem ela o host para no item). Todos os
// pendentes sao conferidos antes, e a lista sai inteira.
function TProcessoConversao.fItensSemPrePro: TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Ativas: string;
  Tabelas: string;
  Tabela: Integer;
  Itens: TStringList;
begin
  Result := fResultadoConvert(True, '');
  if not FHost.UsaPrePro then
    Exit;

  Ativas := FHost.TabelasAtivas;
  Tabelas := '';
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    if (Tabela <= Length(Ativas)) and SameText(Ativas[Tabela], 'S') then
      Tabelas := Tabelas + IfThen(Tabelas <> '', ', ', '') + IntToStr(Tabela);
  if Tabelas = '' then
    Tabelas := '0';

  Itens := TStringList.Create;
  try
    Consulta := FHost.AbrirConsulta('SELECT G.ITE_CODITE FROM ITEGER G' +
      ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE' +
      ' WHERE G.ITE_CODEMP = :CODEMP' +
      IfThen(FSomenteAtivos, ' AND C.ITE_ITEATI = ''S''', '') +
      fSqlFiltroItens('G.ITE_CODITE') +
      '   AND NOT EXISTS (SELECT 1 FROM ITEREF F WHERE F.REF_CHAVE = :CHAVE AND F.ITE_CODEMP = G.ITE_CODEMP' +
      '                    AND F.ITE_CODITE = G.ITE_CODITE)' +
      '   AND NOT EXISTS (SELECT 1 FROM PREPRO P WHERE P.PRO_CODEMP = G.ITE_CODEMP AND P.PRO_CODITE = G.ITE_CODITE' +
      '                    AND P.PRO_NROTAB IN (' + Tabelas + '))' +
      ' ORDER BY G.ITE_CODITE');
    Consulta.DefinirParametro('CODEMP', FEmpresa);
    Consulta.DefinirParametro('CHAVE', FChave);
    pDefinirFiltroItens(Consulta);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Itens.Add(fTextoConvert(Consulta.ValorCampo('ITE_CODITE')) + ': o item não tem preço (PREPRO) nas tabelas ativas.');
      Consulta.Proximo;
    end;
    Consulta := nil;

    if Itens.Count > 0 then
      Result := fResultadoLista(IntToStr(Itens.Count) + ' item(ns) sem preço (PREPRO) nas tabelas ativas. ' +
        'Todos têm de ser ajustados (ou inativados) antes da conversão:', Itens);
  finally
    Itens.Free;
  end;
end;

// Falha antes de qualquer lote aplicado: nenhum ITEGER/PREPRO mudou, entao a conversao volta ao inicio (as opcoes da
// tela ficam livres de novo). Com lote aplicado fica como esta, para a retomada.
procedure TProcessoConversao.pVoltarAoInicio(var Mensagem: string);
var
  Consulta: IReformaConsulta;
  Resultado: TResultadoGravacao;
begin
  if FChave = '' then
    Exit;
  try
    Consulta := FHost.AbrirConsulta('SELECT COUNT(*) AS QTD FROM ITEREF WHERE REF_CHAVE = :CHAVE ' +
      'AND REF_APLICADO = ''S''');
    Consulta.DefinirParametro('CHAVE', FChave);
    Consulta.Abrir;
    if fNumeroConvert(Consulta.ValorCampo('QTD')) > 0 then
      Exit;
    Consulta := nil;

    Resultado := fGravarConvert(FHost, [
      fComandoConvert('DELETE FROM ITEREF WHERE REF_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
      fComandoConvert('DELETE FROM ITEREO WHERE REF_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
      fComandoConvert('DELETE FROM REFDIV WHERE DIV_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
      fComandoConvert('DELETE FROM REFTDE WHERE TDE_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
      fComandoConvert('DELETE FROM REFCON WHERE CON_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)])]);
    if Resultado.Sucesso then
      Mensagem := Mensagem + sLineBreak + sLineBreak + 'Nenhum preço foi alterado: a conversão voltou ao início.';
  except
    // Fica na fase em que parou; a proxima execucao retoma.
  end;
end;

function TProcessoConversao.fPreparar(const Progresso: IReformaProgresso): TResultadoGravacao;
var
  Itens: TList<TItemPendente>;
  Item: TItemPendente;
  Consulta: IReformaConsulta;
  Sql: string;
  Tabela: Integer;
  Sufixo: string;
  Valor: Variant;
  LoteInicial: Integer;
  Lote: Integer;
  LoteBuffer: Integer;
  LoteInicioBuffer: Integer;
  ItensBuffer: Integer;
  Indice: Integer;
  Buffer: TList<TLinhaIteref>;
  LinhaIteref: TLinhaIteref;
  Entrada: TEntradaConversao;
  Valores: TListaValoresConversao;
  Linha: TValoresConversao;
  Desconto: Double;
  Regra: IRegraPrecoConversao;
  Comandos: TArray<TComandoSql>;
  Empresa: string;
  Quantidades: TDictionary<string, Integer>;
  Quantidade: Integer;
  Aliquotas: TAliquotasReforma;
  SemAliquota: TStringList;

  // Grava o bloco (lotes LoteInicioBuffer..LoteBuffer) numa transacao: INSERT de varias linhas so com as colunas
  // calculadas, a copia do ITEGER por origem e a ITEREO das linhas (nunca fica ITEREF sem backup).
  function fDescarregar: TResultadoGravacao;
  var
    Gravacao: TArray<TComandoSql>;
    Comando: TComandoSql;
    Parametros: TList<TValorCampo>;
    Texto: TStringBuilder;
    Posicao: Integer;
    Inicio: Integer;
    Sufixo: string;
    Coluna: string;
    Numero: Double;
    Origem: Char;
  begin
    Result := fResultadoConvert(True, '');
    if Buffer.Count = 0 then
      Exit;
    Gravacao := nil;
    Texto := TStringBuilder.Create;
    Parametros := nil;
    try
      Parametros := TList<TValorCampo>.Create;
      Posicao := 0;
      while Posicao < Buffer.Count do
      begin
        Texto.Clear;
        Texto.Append(FSqlIterefInsert);
        Parametros.Clear;
        Parametros.Add(fParametroConvert('CHAVE', FChave));
        Inicio := Posicao;
        while (Posicao < Buffer.Count) and (Posicao - Inicio < LINHAS_POR_INSERT) do
        begin
          LinhaIteref := Buffer[Posicao];
          // Sufixo de largura fixa: um nome nunca e prefixo de outro.
          Sufixo := '_' + Format('%.6d', [Posicao]);
          if Posicao > Inicio then
            Texto.Append(', ');
          Texto.Append('(:CHAVE, :LOTE' + Sufixo + ', :ORIGEM' + Sufixo + ', ''N'', :EMPRESA' + Sufixo + ', :ITEM' + Sufixo);
          Parametros.Add(fParametroConvert('LOTE' + Sufixo, LinhaIteref.Lote));
          Parametros.Add(fParametroConvert('ORIGEM' + Sufixo, string(LinhaIteref.Valores.Origem)));
          Parametros.Add(fParametroConvert('EMPRESA' + Sufixo, LinhaIteref.Valores.CodigoEmpresa));
          Parametros.Add(fParametroConvert('ITEM' + Sufixo, LinhaIteref.Item));
          for Coluna in FEstrutura.Colunas do
            if fValorCalculado(Coluna, LinhaIteref.Valores, Numero) then
            begin
              Texto.Append(', :V' + Sufixo + Coluna);
              Parametros.Add(fParametroConvert('V' + Sufixo + Coluna, Numero));
            end;
          // DPISCO: o desconto que o item tinha na REFPRE da logada, em todas as empresas (as outras usam o custo da
          // logada, ja com o desconto; teste de 2026-10-15); as aliquotas do preco (RN09).
          Texto.Append(', :DPISCO' + Sufixo + ', :CBS' + Sufixo + ', :IBS' + Sufixo + ', :ISEL' + Sufixo + ')');
          Parametros.Add(fParametroConvert('DPISCO' + Sufixo, LinhaIteref.Dpisco));
          Parametros.Add(fParametroConvert('CBS' + Sufixo, LinhaIteref.Aliquotas.Cbs));
          Parametros.Add(fParametroConvert('IBS' + Sufixo, LinhaIteref.Aliquotas.Ibs));
          Parametros.Add(fParametroConvert('ISEL' + Sufixo, LinhaIteref.Aliquotas.ImpostoSeletivo));
          Inc(Posicao);
        end;
        Comando.Sql := Texto.ToString;
        Comando.Parametros := Parametros.ToArray;
        Gravacao := Gravacao + [Comando];
      end;
    finally
      Parametros.Free;
      Texto.Free;
    end;

    for Origem in ['L', 'F', 'R'] do
      if FSqlIterefCopia[Origem] <> '' then
        Gravacao := Gravacao + [fComandoConvert(FSqlIterefCopia[Origem],
          [fParametroConvert('CHAVE', FChave), fParametroConvert('ORIGEM', string(Origem)),
           fParametroConvert('LOGADA', FEmpresa), fParametroConvert('LOTEINI', LoteInicioBuffer),
           fParametroConvert('LOTEFIM', LoteBuffer)])];
    Gravacao := Gravacao + [fComandoConvert(FSqlIterefBackup,
      [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTEINI', LoteInicioBuffer),
       fParametroConvert('LOTEFIM', LoteBuffer)])];

    Result := fGravarConvert(FHost, Gravacao);
    Buffer.Clear;
    ItensBuffer := 0;
  end;

begin
  Result := fDefinirFase('P');
  if not Result.Sucesso then
    Exit;

  Sql := 'SELECT G.ITE_CODITE, G.ITE_PRECOM, G.ITE_DESOPE, G.ITE_ICMSAI, R.ITE_DPISCO AS REF_DPISCO, ' +
    'R.ITE_DESOPE AS REF_DESOPE, CASE WHEN R.ITE_CODITE IS NULL THEN ''N'' ELSE ''S'' END AS TEM_REFPRE';
  if FOrigem = oicAbreviacaoItem then
    Sql := Sql + ', C.ITE_CLAIPI, C.ITE_EXCIPI, C.ITE_EXCBFR, C.ITE_ABFREF';
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
  begin
    Sufixo := IntToStr(Tabela);
    Sql := Sql + ', G.ITE_PREVE' + Sufixo + ', G.ITE_MARBR' + Sufixo + ', G.ITE_COMTB' + Sufixo +
      ', R.ITE_COMTB' + Sufixo + ' AS REF_ITE_COMTB' + Sufixo + ', R.ITE_MARBR' + Sufixo + ' AS REF_ITE_MARBR' + Sufixo;
  end;
  Sql := Sql +
    ' FROM ITEGER G' +
    ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE' +
    ' LEFT JOIN REFPRE R ON R.ITE_CODEMP = G.ITE_CODEMP AND R.ITE_CODITE = G.ITE_CODITE' +
    ' WHERE G.ITE_CODEMP = :CODEMP' +
    IfThen(FSomenteAtivos, ' AND C.ITE_ITEATI = ''S''', '') +
    fSqlFiltroItens('G.ITE_CODITE') +
    '   AND NOT EXISTS (SELECT 1 FROM ITEREF F WHERE F.REF_CHAVE = :CHAVE AND F.ITE_CODEMP = G.ITE_CODEMP' +
    '                    AND F.ITE_CODITE = G.ITE_CODITE)' +
    ' ORDER BY G.ITE_CODITE';

  Regra := fRegraPreco;
  Itens := TList<TItemPendente>.Create;
  Buffer := nil;
  Quantidades := nil;
  try
    Buffer := TList<TLinhaIteref>.Create;
    Quantidades := TDictionary<string, Integer>.Create;
    // Tudo em memoria antes de calcular: o host consulta o banco a cada item na mesma conexao.
    Consulta := FHost.AbrirConsulta(Sql);
    Consulta.DefinirParametro('CODEMP', FEmpresa);
    Consulta.DefinirParametro('CHAVE', FChave);
    pDefinirFiltroItens(Consulta);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Item.Origem.CodigoItem := fTextoConvert(Consulta.ValorCampo('ITE_CODITE'));
      Item.PrecoCompra := fNumeroConvert(Consulta.ValorCampo('ITE_PRECOM'));
      Item.DespesaOperacional := fNumeroConvert(Consulta.ValorCampo('ITE_DESOPE'));
      Item.TemRefpre := fTextoConvert(Consulta.ValorCampo('TEM_REFPRE')) = 'S';
      Item.Desconto := fNumeroConvert(Consulta.ValorCampo('REF_DPISCO'));
      Item.DespesaRefpre := fNumeroConvert(Consulta.ValorCampo('REF_DESOPE'));
      Item.Origem.IcmsSaida := fNumeroConvert(Consulta.ValorCampo('ITE_ICMSAI'));
      Item.Ncm := '';
      Item.NcmExcecao := '';
      Item.Abreviacao := '';
      if FOrigem = oicAbreviacaoItem then
      begin
        Item.Ncm := fTextoConvert(Consulta.ValorCampo('ITE_CLAIPI'));
        Item.NcmExcecao := fTextoConvert(Consulta.ValorCampo('ITE_EXCIPI'));
        // Mesmo filtro do cadastro: a abreviacao da reforma so vai quando o item tem a excecao marcada.
        if fTextoConvert(Consulta.ValorCampo('ITE_EXCBFR')) = 'S' then
          Item.Abreviacao := fTextoConvert(Consulta.ValorCampo('ITE_ABFREF'));
      end;
      for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      begin
        Sufixo := IntToStr(Tabela);
        Item.Origem.PrecoVendaAtual[Tabela] := fNumeroConvert(Consulta.ValorCampo('ITE_PREVE' + Sufixo));
        Item.Origem.MargemAtual[Tabela] := fNumeroConvert(Consulta.ValorCampo('ITE_MARBR' + Sufixo));
        Item.Origem.ComissaoAtual[Tabela] := fNumeroConvert(Consulta.ValorCampo('ITE_COMTB' + Sufixo));

        Valor := Consulta.ValorCampo('REF_ITE_COMTB' + Sufixo);
        Item.Origem.ComissaoRefpre[Tabela].Existe := Item.TemRefpre and not VarIsNull(Valor);
        Item.Origem.ComissaoRefpre[Tabela].Valor := fNumeroConvert(Valor);

        Valor := Consulta.ValorCampo('REF_ITE_MARBR' + Sufixo);
        Item.Origem.MargemRefpre[Tabela].Existe := Item.TemRefpre and not VarIsNull(Valor);
        Item.Origem.MargemRefpre[Tabela].Valor := fNumeroConvert(Valor);
      end;
      Itens.Add(Item);
      Consulta.Proximo;
    end;

    Consulta := FHost.AbrirConsulta('SELECT COALESCE(MAX(REF_LOTE), 0) AS LOTE FROM ITEREF WHERE REF_CHAVE = :CHAVE');
    Consulta.DefinirParametro('CHAVE', FChave);
    Consulta.Abrir;
    LoteInicial := Round(fNumeroConvert(Consulta.ValorCampo('LOTE'))) + 1;
    Consulta := nil;

    Result := fItensSemPrePro;
    if not Result.Sucesso then
      Exit;

    // Abreviacao do item: todos os itens pendentes tem de ter aliquota calculada pela procedure antes de qualquer
    // calculo; faltando em algum, a conversao para e lista os itens para o operador ajustar.
    FAliquotasItem.Clear;
    if FOrigem = oicAbreviacaoItem then
    begin
      Progresso.Definir('Conferindo alíquotas dos itens', Itens.Count);
      SemAliquota := TStringList.Create;
      try
        for Item in Itens do
        begin
          Consulta := FHost.AbrirConsulta('CALL pRefTrib_CalculaAliquotasEfetivasItens(CAST(:PITENS AS JSON))');
          Consulta.DefinirParametro('PITENS', fJsonItemAliquota(FEmpresa, Item.Origem.CodigoItem, Item.Ncm,
            Item.NcmExcecao, Item.Abreviacao));
          Consulta.Abrir;
          if Consulta.Vazia then
            SemAliquota.Add(Item.Origem.CodigoItem + ': a procedure não devolveu alíquota.')
          else if fTextoConvert(Consulta.ValorCampo('RET_STATUS')) <> 'CALCULADO' then
            SemAliquota.Add(Item.Origem.CodigoItem + ': ' + fTextoConvert(Consulta.ValorCampo('RET_MENSAGEM')))
          else
          begin
            Aliquotas.Cbs := fNumeroConvert(Consulta.ValorCampo('ALQ_CBS_EFETIVA'));
            Aliquotas.Ibs := fNumeroConvert(Consulta.ValorCampo('ALQ_IBS_TOTAL_EFETIVA'));
            Aliquotas.ImpostoSeletivo := fNumeroConvert(Consulta.ValorCampo('RTE_ALIQIS'));
            FAliquotasItem.AddOrSetValue(Item.Origem.CodigoItem, Aliquotas);
          end;
          Consulta := nil;
          Progresso.Avancar(1);
        end;

        if SemAliquota.Count > 0 then
          Exit(fResultadoLista(fMensagemSemAliquota(SemAliquota), SemAliquota));
      finally
        SemAliquota.Free;
      end;
    end;

    Progresso.Definir('Preparando itens', Itens.Count);

    // Sempre, mesmo sem item: IniciarCalculo comeca uma execucao (o host zera o agrupador do historico).
    Result := FHost.IniciarCalculo(FOpcao);
    if not Result.Sucesso then
      Exit;
    try
      LoteBuffer := LoteInicial;
      LoteInicioBuffer := LoteInicial;
      ItensBuffer := 0;
      for Indice := 0 to Itens.Count - 1 do
      begin
        Item := Itens[Indice];
        Lote := LoteInicial + (Indice div TAMANHO_LOTE);
        if Lote <> LoteBuffer then
        begin
          // Grava so em lote inteiro, quando o bloco encheu.
          if ItensBuffer >= TAMANHO_GRAVACAO then
          begin
            Result := fDescarregar;
            if not Result.Sucesso then
              Exit;
            LoteInicioBuffer := Lote;
          end;
          LoteBuffer := Lote;
        end;

        // RN02: fora de 0 <= x < 100 vale 0 (a conferencia grava o alerta, lendo a REFPRE).
        Desconto := Item.Desconto;
        if (Desconto < 0) or (Desconto >= 100) then
          Desconto := 0;

        Entrada.CodigoItem := Item.Origem.CodigoItem;
        Entrada.PrecoCompra := fPrecoCompraConvertido(Item.PrecoCompra, Desconto, FDecimais);
        // RN03: a despesa operacional e a da REFPRE quando o item tem linha nela.
        if Item.TemRefpre then
          Entrada.DespesaOperacional := Item.DespesaRefpre
        else
          Entrada.DespesaOperacional := Item.DespesaOperacional;
        Aliquotas := fAliquotasDoItem(Item.Origem.CodigoItem);
        Entrada.Alvos := Regra.Alvos(Item.Origem, FOpcao, Aliquotas);
        Entrada.Comissao := Regra.Comissoes(Item.Origem);

        Valores := nil;
        Result := FHost.CalcularItem(Entrada, Valores);
        if not Result.Sucesso then
        begin
          // RN22: o que ja foi calculado fica; a retomada continua deste item.
          fDescarregar;
          Result := fResultadoConvert(False, 'Item ' + Item.Origem.CodigoItem + ': ' + Result.Mensagem);
          Exit;
        end;

        for Linha in Valores do
        begin
          LinhaIteref.Lote := Lote;
          LinhaIteref.Item := Item.Origem.CodigoItem;
          LinhaIteref.Valores := Linha;
          LinhaIteref.Dpisco := Desconto;
          LinhaIteref.Aliquotas := Aliquotas;
          Buffer.Add(LinhaIteref);
        end;
        Inc(ItensBuffer);

        Progresso.Avancar(1);
      end;

      Result := fDescarregar;
      if not Result.Sucesso then
        Exit;
    finally
      FHost.FinalizarCalculo;
    end;

    Result := fGravarConvert(FHost, [fComandoGrupo]);
    if not Result.Sucesso then
      Exit;

    // Fase A e itens de cada empresa (calculados aqui: o COUNT no SQL dependeria do ITEGER da filial, RN17).
    Consulta := FHost.AbrirConsulta('SELECT ITE_CODEMP, COUNT(*) AS QTD FROM ITEREF WHERE REF_CHAVE = :CHAVE ' +
      'GROUP BY ITE_CODEMP');
    Consulta.DefinirParametro('CHAVE', FChave);
    Consulta.Abrir;
    while not Consulta.Fim do
    begin
      Quantidades.AddOrSetValue(fTextoConvert(Consulta.ValorCampo('ITE_CODEMP')),
        Round(fNumeroConvert(Consulta.ValorCampo('QTD'))));
      Consulta.Proximo;
    end;
    Consulta := nil;

    Comandos := nil;
    for Empresa in fEmpresasAfetadas do
    begin
      if not Quantidades.TryGetValue(Empresa, Quantidade) then
        Quantidade := 0;
      Comandos := Comandos + [fComandoConvert('UPDATE REFCON SET CON_FASE = ''A'', CON_QTDITE = :QTD ' +
        'WHERE CON_CHAVE = :CHAVE AND CON_CODEMP = :CODEMP',
        [fParametroConvert('QTD', Quantidade), fParametroConvert('CHAVE', FChave),
         fParametroConvert('CODEMP', Empresa)])];
    end;
    Result := fGravarConvert(FHost, Comandos);
  finally
    Quantidades.Free;
    Buffer.Free;
    Itens.Free;
  end;
end;

// RN12.1: alterado depois da preparacao = descarta o que nao foi aplicado; a proxima execucao prepara de novo.
function TProcessoConversao.fDescartarPendentes(const Alterados: TList<TPair<string, string>>): TResultadoGravacao;
var
  Comandos: TArray<TComandoSql>;
  Par: TPair<string, string>;
  Momento: TDateTime;
begin
  Momento := FHost.DataHora;
  Comandos := nil;
  for Par in Alterados do
    Comandos := Comandos + [fComandoDivergencia(FChave, fDivergencia(Par.Key, Par.Value, TIPO_ALTERADO, '', '', ''),
      Momento)];
  Comandos := Comandos + [
    fComandoConvert('DELETE FROM ITEREF WHERE REF_CHAVE = :CHAVE AND REF_APLICADO = ''N''',
      [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('DELETE FROM ITEREO WHERE REF_CHAVE = :CHAVE AND REF_APLICADO = ''N''',
      [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('UPDATE REFCON SET CON_FASE = ''P'' WHERE CON_CHAVE = :CHAVE',
      [fParametroConvert('CHAVE', FChave)])];
  Result := fGravarConvert(FHost, Comandos);
end;

function TProcessoConversao.fAplicar(const Progresso: IReformaProgresso): TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Lotes: TList<TPair<Integer, Integer>>;
  Lote: TPair<Integer, Integer>;
  Alterados: TList<TPair<string, string>>;
  Par: TPair<string, string>;
  Listados: TStringList;
  Total: Integer;
  Sql: string;
  Coluna: string;
  Condicao: string;
  Transacao: IReformaTransacao;
begin
  // A condicao de alteracao vem da lista de colunas (o texto e o mesmo em todos os lotes).
  Condicao := '';
  for Coluna in FEstrutura.Colunas do
  begin
    if Condicao <> '' then
      Condicao := Condicao + ' OR ';
    if SameText(Coluna, 'ITE_PREDOL') then
      Condicao := Condicao + 'IFNULL(G.' + Coluna + ', '''') <> IFNULL(O.' + Coluna + ', '''')'
    else
      Condicao := Condicao + 'ABS(IFNULL(G.' + Coluna + ', 0) - IFNULL(O.' + Coluna + ', 0)) > 0.000001';
  end;
  Sql := 'SELECT O.ITE_CODEMP, O.ITE_CODITE FROM ITEREO O' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = O.ITE_CODEMP AND G.ITE_CODITE = O.ITE_CODITE' +
    ' WHERE O.REF_CHAVE = :CHAVE AND O.REF_LOTE = :LOTE AND (' + Condicao + ') LIMIT 200';

  Lotes := TList<TPair<Integer, Integer>>.Create;
  Alterados := nil;
  try
    Alterados := TList<TPair<string, string>>.Create;
    Consulta := FHost.AbrirConsulta('SELECT REF_LOTE, COUNT(*) AS QTD FROM ITEREF WHERE REF_CHAVE = :CHAVE ' +
      'AND REF_ORIGEM = ''L'' AND REF_APLICADO = ''N'' GROUP BY REF_LOTE ORDER BY REF_LOTE');
    Consulta.DefinirParametro('CHAVE', FChave);
    Consulta.Abrir;
    Total := 0;
    while not Consulta.Fim do
    begin
      Lotes.Add(TPair<Integer, Integer>.Create(Round(fNumeroConvert(Consulta.ValorCampo('REF_LOTE'))),
        Round(fNumeroConvert(Consulta.ValorCampo('QTD')))));
      Inc(Total, Lotes.Last.Value);
      Consulta.Proximo;
    end;
    Consulta := nil;

    Result := fDefinirFase('A');
    if not Result.Sucesso then
      Exit;

    Progresso.Definir('Aplicando preços', Total);
    for Lote in Lotes do
    begin
      Transacao := FHost.Gravacao.IniciarTransacao;
      if not Assigned(Transacao) then
        Exit(fResultadoConvert(False, MENSAGEM_TRANSACAO_ABERTA));

      Alterados.Clear;
      Consulta := FHost.AbrirConsulta(Sql);
      Consulta.DefinirParametro('CHAVE', FChave);
      Consulta.DefinirParametro('LOTE', Lote.Key);
      Consulta.Abrir;
      while not Consulta.Fim do
      begin
        Alterados.Add(TPair<string, string>.Create(fTextoConvert(Consulta.ValorCampo('ITE_CODEMP')),
          fTextoConvert(Consulta.ValorCampo('ITE_CODITE'))));
        Consulta.Proximo;
      end;
      Consulta := nil;

      if Alterados.Count > 0 then
      begin
        Transacao.Desfazer;
        Transacao := nil;
        Result := fDescartarPendentes(Alterados);
        if Result.Sucesso then
        begin
          Listados := TStringList.Create;
          try
            for Par in Alterados do
              Listados.Add('Empresa ' + Par.Key + ', item ' + Par.Value + '.');
            Result := fResultadoLista(MENSAGEM_ALTERADOS, Listados);
          finally
            Listados.Free;
          end;
        end;
        Exit;
      end;

      Result := FHost.AplicarLote(FChave, Lote.Key);
      if Result.Sucesso then
        Result := fExecutarBlocosConvert(FHost, fComandosTabelasFornecedor(Lote.Key) + [
          fComandoConvert('UPDATE ITEREF SET REF_APLICADO = ''S'' WHERE REF_CHAVE = :CHAVE AND REF_LOTE = :LOTE',
            [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTE', Lote.Key)]),
          fComandoConvert('UPDATE ITEREO SET REF_APLICADO = ''S'' WHERE REF_CHAVE = :CHAVE AND REF_LOTE = :LOTE',
            [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTE', Lote.Key)]),
          fComandoConvert('UPDATE REFCON SET CON_QTDAPL = CON_QTDAPL + :QTD WHERE CON_CHAVE = :CHAVE ' +
            'AND CON_CODEMP = :CODEMP',
            [fParametroConvert('QTD', Lote.Value), fParametroConvert('CHAVE', FChave),
             fParametroConvert('CODEMP', FEmpresa)])]);
      if Result.Sucesso then
        Result := Transacao.Confirmar
      else
        Transacao.Desfazer;
      Transacao := nil;

      if not Result.Sucesso then
        Exit(fResultadoConvert(False, 'Lote ' + IntToStr(Lote.Key) + ': ' + Result.Mensagem));

      Progresso.Avancar(Lote.Value);
    end;

    Result := fResultadoConvert(True, '');
  finally
    Alterados.Free;
    Lotes.Free;
  end;
end;

// Item excluido do ITEGER depois da preparacao: a linha dele na ITEREF/ITEREO e lixo. Sai, e a REFDIV registra
// EXCLUIDO (alerta, nao bloqueia).
function TProcessoConversao.fLimparExcluidos: TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Comandos: TArray<TComandoSql>;
  Momento: TDateTime;
begin
  Momento := FHost.DataHora;
  Comandos := nil;
  Consulta := FHost.AbrirConsulta('SELECT F.ITE_CODEMP, F.ITE_CODITE FROM ITEREF F WHERE F.REF_CHAVE = :CHAVE ' +
    'AND NOT EXISTS (SELECT 1 FROM ITEGER G WHERE G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE)');
  Consulta.DefinirParametro('CHAVE', FChave);
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Comandos := Comandos + [fComandoDivergencia(FChave, fDivergencia(fTextoConvert(Consulta.ValorCampo('ITE_CODEMP')),
      fTextoConvert(Consulta.ValorCampo('ITE_CODITE')), TIPO_EXCLUIDO, '', '', ''), Momento)];
    Consulta.Proximo;
  end;
  Consulta := nil;

  if Length(Comandos) = 0 then
    Exit(fResultadoConvert(True, ''));

  Comandos := Comandos + [
    fComandoConvert('DELETE O FROM ITEREO O WHERE O.REF_CHAVE = :CHAVE AND NOT EXISTS (SELECT 1 FROM ITEGER G ' +
      'WHERE G.ITE_CODEMP = O.ITE_CODEMP AND G.ITE_CODITE = O.ITE_CODITE)', [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('DELETE F FROM ITEREF F WHERE F.REF_CHAVE = :CHAVE AND NOT EXISTS (SELECT 1 FROM ITEGER G ' +
      'WHERE G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE)', [fParametroConvert('CHAVE', FChave)])];
  Result := fGravarConvert(FHost, Comandos);
end;

function TProcessoConversao.fConferirEAtivar(const Progresso: IReformaProgresso): TResultadoGravacao;
var
  Conferencia: TConferenciaConvert;
  Empresa: string;
  Comandos: TArray<TComandoSql>;
  Transacao: IReformaTransacao;
  Momento: TDateTime;
begin
  FAtivou := False;
  Result := fLimparExcluidos;
  if not Result.Sucesso then
    Exit;

  Comandos := nil;
  Conferencia := TConferenciaConvert.Create(FHost, FEstrutura, FChave, fEmpresasAfetadas, FDecimais, FSomenteAtivos,
    fSqlFiltroItens('G.ITE_CODITE'), fParametrosFiltroItens);
  try
    Result := Conferencia.Executar(Progresso);
    if not Result.Sucesso then
      Exit;
    FBloqueantes := Conferencia.TotalBloqueantes;
    FAlertas := Conferencia.Alertas;

    if (FBloqueantes > 0) or FJaConcluida then
    begin
      // Concluida (botao Conferir) continua 'C': a CFG_REFCIS ja foi ligada; so a contagem e atualizada.
      for Empresa in fEmpresasAfetadas do
        Comandos := Comandos + [fComandoConvert('UPDATE REFCON SET CON_FASE = :FASE, CON_QTDDIV = :QTD ' +
          'WHERE CON_CHAVE = :CHAVE AND CON_CODEMP = :CODEMP',
          [fParametroConvert('FASE', IfThen(FJaConcluida, 'C', 'D')),
           fParametroConvert('QTD', Conferencia.Bloqueantes(Empresa)),
           fParametroConvert('CHAVE', FChave),
           fParametroConvert('CODEMP', Empresa)])];
      // Concluida antes do EMP_REFCON existir: a conferencia limpa marca as empresas (e zera os impostos federais
      // padrao, como a ativacao abaixo).
      if FJaConcluida and (FBloqueantes = 0) then
        for Empresa in fEmpresasAfetadas do
          Comandos := Comandos + fComandosZerarImpostosFederais(Empresa);
      Exit(fGravarConvert(FHost, Comandos));
    end;
  finally
    Conferencia.Free;
  end;

  // RN19: tudo ou nada, numa transacao.
  Transacao := FHost.Gravacao.IniciarTransacao;
  if not Assigned(Transacao) then
    Exit(fResultadoConvert(False, MENSAGEM_TRANSACAO_ABERTA));

  for Empresa in fEmpresasAfetadas do
  begin
    Result := FHost.AtivarReforma(Empresa);
    if not Result.Sucesso then
    begin
      Transacao.Desfazer;
      Exit;
    end;
  end;

  Momento := FHost.DataHora;
  Comandos := [fComandoConvert('UPDATE REFCON SET CON_FASE = ''C'', CON_DTAFIM = :DTAFIM, ' +
    'CON_HORFIM = :HORFIM, CON_QTDDIV = 0 WHERE CON_CHAVE = :CHAVE',
    [fParametroConvert('DTAFIM', fDataConvert(Momento)), fParametroConvert('HORFIM', fHoraConvert(Momento)),
     fParametroConvert('CHAVE', FChave)])];
  // EMP_REFCON: a marca que replica para as lojas (a CFGSIS nao replica); la a sanitizacao do plugin liga a CFG_REFCIS
  // ao subir o autcom (usuario, 2026-10-06).
  for Empresa in fEmpresasAfetadas do
    Comandos := Comandos + fComandosZerarImpostosFederais(Empresa);
  Result := fExecutarBlocosConvert(FHost, Comandos);
  if Result.Sucesso then
    Result := Transacao.Confirmar
  else
    Transacao.Desfazer;
  FAtivou := Result.Sucesso;
end;

// EMP_SUBFED e EMP_IMPFED (usuario, 2026-10-15): sao o padrao dos impostos federais do produto novo (cadastro, filiais,
// importacao em massa). Depois da conversao os campos ficam ocultos e os impostos federais dao lugar a CBS, IBS e IS: o
// padrao vai a zero junto com a marca EMP_REFCON. Antes, os valores vao para a REFCON da conversao (CON_SUBFED e
// CON_IMPFED), para o Reverter devolver. So a primeira vez: uma nova conferencia nao troca o guardado pelo zero.
function TProcessoConversao.fComandosZerarImpostosFederais(const Empresa: string): TArray<TComandoSql>;
begin
  Result := [
    fComandoConvert('UPDATE REFCON R INNER JOIN CADEMP E ON E.EMP_CODEMP = R.CON_CODEMP ' +
      'SET R.CON_SUBFED = COALESCE(E.EMP_SUBFED, 0), R.CON_IMPFED = COALESCE(E.EMP_IMPFED, 0) ' +
      'WHERE R.CON_CHAVE = :CHAVE AND R.CON_CODEMP = :CODEMP AND R.CON_SUBFED IS NULL AND R.CON_IMPFED IS NULL',
      [fParametroConvert('CHAVE', FChave), fParametroConvert('CODEMP', Empresa)]),
    fComandoConvert('UPDATE CADEMP SET EMP_REFCON = ''S'', EMP_SUBFED = 0, EMP_IMPFED = 0 WHERE EMP_CODEMP = :CODEMP',
      [fParametroConvert('CODEMP', Empresa)])];
end;

// CFG_TABPRD (usuario, 2026-10-19): com a tabela de preco por produto, o cadastro de produtos le o custo da TABDET da 1a
// tabela ativa ligada ao item (ITEGER.ITE_TABPRn = TABDET.ITE_CODTAB) e grava so a DETCUS (fTabelaPrecoToPrePro, ou
// fTabelaPrecoToIteger no 74.111, e fAtualizaTabDetCus). Sem acompanhar a conversao, a primeira gravacao do produto
// devolvia o custo antigo, com os impostos federais. Aqui so se confere o que existe neste banco; o 72 nao tem DETCUS.
procedure TProcessoConversao.pLerTabelasFornecedor;
const
  COLUNAS_TABDET: array[0..8] of string = ('AUTOINCREM', 'ITE_CODEMP', 'ITE_CODITE', 'ITE_CODTAB', 'ITE_SEQGER',
    'ITE_PRECOM', 'ITE_PRECUS', 'ITE_SUBFED', 'ITE_IMPFED');
  COLUNAS_DETCUS: array[0..6] of string = ('DET_SEQDET', 'DET_TABELA', 'DET_ICMSAI', 'DET_DESOPE', 'DET_OUTVAL',
    'DET_MARBRU', 'DET_PREVEN');
  // Parametros de fCalculaPrecodeCusto que vem da TABDET.
  COLUNAS_CUSTO: array[0..12] of string = ('ITE_DESF01', 'ITE_DESF02', 'ITE_DESF03', 'ITE_DESF04', 'ITE_DESF05',
    'ITE_DESF06', 'ITE_IPIENT', 'ITE_SUBSTI', 'ITE_ICMENT', 'ITE_FREENT', 'ITE_VALFRE', 'ITE_ACRFIN', 'ITE_DESADB');
var
  Coluna: string;
  Ativas: string;
  Tabela: Integer;
  Consulta: IReformaConsulta;
begin
  FTabelasFornecedor := False;
  FTabelasLigadas := nil;
  FCustoTabelaFornecedor := False;

  for Coluna in COLUNAS_TABDET do
    if not FEstrutura.ColunaExiste('TABDET', Coluna) then
      Exit;
  for Coluna in COLUNAS_DETCUS do
    if not FEstrutura.ColunaExiste('DETCUS', Coluna) then
      Exit;
  if not FEstrutura.ColunaExiste('ITEFOR', 'AUTOINCREM') or not FEstrutura.ColunaExiste('ITEFOR', 'ITE_CNVCUS') then
    Exit;
  FTabelasFornecedor := True;

  // Sem empresa com CFG_TABPRD no banco, a aplicacao nao leva comando nenhum (a reversao continua pela REFTDE).
  Consulta := FHost.AbrirConsulta('SELECT COUNT(*) AS QTD FROM CFGSIS ' +
    'WHERE SIS_CODCFG = ''CFG_TABPRD'' AND SIS_VALCFG = ''S''');
  Consulta.Abrir;
  if fNumeroConvert(Consulta.ValorCampo('QTD')) = 0 then
    Exit;
  Consulta := nil;

  Ativas := FHost.TabelasAtivas;
  for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
    if (Tabela <= Length(Ativas)) and SameText(Ativas[Tabela], 'S') and
       FEstrutura.ColunaExiste('ITEGER', 'ITE_TABPR' + IntToStr(Tabela)) then
      FTabelasLigadas := FTabelasLigadas + [Tabela];

  for Coluna in COLUNAS_CUSTO do
    if not FEstrutura.ColunaExiste('TABDET', Coluna) then
      Exit;
  Consulta := FHost.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.ROUTINES ' +
    'WHERE ROUTINE_SCHEMA = DATABASE() AND ROUTINE_TYPE = ''FUNCTION'' AND ROUTINE_NAME = ''fCalculaPrecodeCusto''');
  Consulta.Abrir;
  FCustoTabelaFornecedor := fNumeroConvert(Consulta.ValorCampo('QTD')) > 0;
end;

// Na aplicacao do lote, na mesma transacao e depois do AplicarLote (o ITEGER ja tem os valores convertidos), so nas
// empresas com CFG_TABPRD = 'S' e so nas TABDET ligadas ao item, como o cadastro:
//  1. REFTDE guarda a TABDET (custo e federais) e a DETCUS (preco, margem, ICMS, despesa, outros) de antes;
//  2. TABDET: ITE_SUBFED e ITE_IMPFED zerados; o custo sem o ITE_SUBFED pela fCalculaPrecodeCusto (a diferenca entre
//     a conta com zero e com o atual, para nao perder o que a conta do Delphi tem a mais, como Suframa e dolar);
//  3. TABDET da 1a tabela ativa: ITE_PRECOM e ITE_PRECUS do produto convertido, na unidade do fornecedor
//     (x ITE_CNVCUS), porque e dela que a gravacao do produto le o custo;
//  4. DETCUS: preco (x ITE_CNVCUS) e margem da tabela vem do ITEGER (fAtualizaTabDetCus), ja calculados pela opcao da
//     tela; na 1a tabela ativa tambem o ICMS de saida, a despesa e os outros valores (x ITE_CNVCUS), que a gravacao do
//     produto le de la.
// Um comando por tabela ligada, com T.ITE_CODTAB = G.ITE_TABPRn: com OR entre as tabelas o MySQL nao usa o indice
// (ITE_CODTAB, ITE_CODITE, ITE_CODEMP) e varria a TABDET da empresa a cada item. A linha ligada a mais de uma tabela
// entra uma vez: o backup confere a REFTDE e o custo so muda enquanto o ITE_SUBFED nao e zero.
// Parametros: so :CHAVE e :LOTE (nenhum nome e inicio de outro, por causa do TBatchSQL do 72/74.111).
function TProcessoConversao.fComandosTabelasFornecedor(const Lote: Integer): TArray<TComandoSql>;
const
  CONVERSAO = 'IF(IFNULL(I.ITE_CNVCUS, 0) <= 0, 1, I.ITE_CNVCUS)';
var
  Tabela: Integer;
  Numero: string;
  Primeira: Integer;
  Ligada: string;
  Item: string;
  Filtro: string;
  Matriz: string;
  Configuracao: string;
  Comandos: TArray<TComandoSql>;

  function fCusto(const SubFederal: string): string;
  begin
    Result := 'fCalculaPrecodeCusto(CF.SIS_VALCFG, CO.SIS_VALCFG, CD.SIS_VALCFG, T.ITE_PRECOM, ' +
      'IFNULL(T.ITE_DESF01, 0), IFNULL(T.ITE_DESF02, 0), IFNULL(T.ITE_DESF03, 0), IFNULL(T.ITE_DESF04, 0), ' +
      'IFNULL(T.ITE_DESF05, 0), IFNULL(T.ITE_DESF06, 0), IFNULL(T.ITE_IPIENT, 0), IFNULL(T.ITE_SUBSTI, 0), ' +
      'IFNULL(T.ITE_ICMENT, 0), IFNULL(T.ITE_FREENT, 0), IFNULL(T.ITE_VALFRE, 0), IFNULL(T.ITE_ACRFIN, 0), ' +
      SubFederal + ', IFNULL(T.ITE_DESADB, 0))';
  end;

  procedure pAdicionar(const Sql: string);
  begin
    Comandos := Comandos + [fComandoConvert(Sql, [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTE', Lote)])];
  end;

begin
  Result := nil;
  if not FTabelasFornecedor or (Length(FTabelasLigadas) = 0) then
    Exit;

  Comandos := nil;
  Configuracao := '';
  Primeira := FTabelasLigadas[0];

  // O item da conversao no lote, com a CFG_TABPRD da propria empresa.
  Item :=
    ' INNER JOIN ITEREF F ON F.ITE_CODEMP = T.ITE_CODEMP AND F.ITE_CODITE = T.ITE_CODITE' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE' +
    ' INNER JOIN CFGSIS P ON P.SIS_CODEMP = F.ITE_CODEMP AND P.SIS_CODCFG = ''CFG_TABPRD'' AND P.SIS_VALCFG = ''S''';
  Filtro := ' WHERE F.REF_CHAVE = :CHAVE AND F.REF_LOTE = :LOTE';

  if FCustoTabelaFornecedor then
  begin
    if FEstrutura.ColunaExiste('CADEMP', 'EMP_PREMAT') and FEstrutura.ColunaExiste('CADEMP', 'EMP_CODMAT') then
      Matriz := 'IF(IFNULL(E.EMP_PREMAT, '''') = ''S'', E.EMP_CODMAT, T.ITE_CODEMP)'
    else
      Matriz := 'T.ITE_CODEMP';
    // Configuracoes da empresa que define o preco, como a tela de tabela de precos.
    Configuracao :=
      ' LEFT JOIN CADEMP E ON E.EMP_CODEMP = T.ITE_CODEMP' +
      ' LEFT JOIN CFGSIS CF ON CF.SIS_CODEMP = ' + Matriz + ' AND CF.SIS_CODCFG = ''CFG_FRMCUS''' +
      ' LEFT JOIN CFGSIS CO ON CO.SIS_CODEMP = ' + Matriz + ' AND CO.SIS_CODCFG = ''CFG_OPEADI''' +
      ' LEFT JOIN CFGSIS CD ON CD.SIS_CODEMP = ' + Matriz + ' AND CD.SIS_CODCFG = ''CFG_DECUNI''';
  end;

  for Tabela in FTabelasLigadas do
  begin
    Numero := IntToStr(Tabela);
    Ligada := ' AND T.ITE_CODTAB = G.ITE_TABPR' + Numero;

    // 1. Backup (so a primeira vez de cada linha na conversao).
    pAdicionar(
      'INSERT INTO REFTDE (TDE_CHAVE, TDE_LOTE, TDE_CODEMP, TDE_SEQDET, TDE_TABELA, TDE_PRECOM, TDE_PRECUS, ' +
      'TDE_SUBFED, TDE_IMPFED) SELECT F.REF_CHAVE, F.REF_LOTE, T.ITE_CODEMP, T.AUTOINCREM, 0, T.ITE_PRECOM, ' +
      'T.ITE_PRECUS, T.ITE_SUBFED, T.ITE_IMPFED FROM TABDET T' + Item + Filtro + Ligada +
      ' AND NOT EXISTS (SELECT 1 FROM REFTDE B WHERE B.TDE_CHAVE = F.REF_CHAVE AND B.TDE_CODEMP = T.ITE_CODEMP' +
      ' AND B.TDE_SEQDET = T.AUTOINCREM AND B.TDE_TABELA = 0)');
    pAdicionar(
      'INSERT INTO REFTDE (TDE_CHAVE, TDE_LOTE, TDE_CODEMP, TDE_SEQDET, TDE_TABELA, TDE_ICMSAI, TDE_DESOPE, ' +
      'TDE_OUTVAL, TDE_MARBRU, TDE_PREVEN) SELECT F.REF_CHAVE, F.REF_LOTE, T.ITE_CODEMP, T.AUTOINCREM, D.DET_TABELA, ' +
      'D.DET_ICMSAI, D.DET_DESOPE, D.DET_OUTVAL, D.DET_MARBRU, D.DET_PREVEN FROM TABDET T' + Item +
      ' INNER JOIN DETCUS D ON D.DET_SEQDET = T.AUTOINCREM AND D.DET_TABELA = ' + Numero + Filtro + Ligada +
      ' AND NOT EXISTS (SELECT 1 FROM REFTDE B WHERE B.TDE_CHAVE = F.REF_CHAVE AND B.TDE_CODEMP = T.ITE_CODEMP' +
      ' AND B.TDE_SEQDET = T.AUTOINCREM AND B.TDE_TABELA = D.DET_TABELA)');

    // 2. Custo sem o ITE_SUBFED (antes de zerar: a conta usa o valor atual) e federais zerados.
    if FCustoTabelaFornecedor then
      pAdicionar(
        'UPDATE TABDET T' + Item + Configuracao +
        ' SET T.ITE_PRECUS = T.ITE_PRECUS + ' + fCusto('0') + ' - ' + fCusto('IFNULL(T.ITE_SUBFED, 0)') +
        Filtro + Ligada + ' AND IFNULL(T.ITE_SUBFED, 0) <> 0');
    pAdicionar(
      'UPDATE TABDET T' + Item + ' SET T.ITE_SUBFED = 0, T.ITE_IMPFED = 0' + Filtro + Ligada +
      ' AND (IFNULL(T.ITE_SUBFED, 0) <> 0 OR IFNULL(T.ITE_IMPFED, 0) <> 0)');

    // 3. A 1a tabela ativa recebe o custo do produto.
    if Tabela = Primeira then
      pAdicionar(
        'UPDATE TABDET T' + Item + ' LEFT JOIN ITEFOR I ON I.AUTOINCREM = T.ITE_SEQGER' +
        ' SET T.ITE_PRECOM = G.ITE_PRECOM * ' + CONVERSAO + ', T.ITE_PRECUS = G.ITE_PRECUS * ' + CONVERSAO +
        Filtro + Ligada);

    // 4. DETCUS da tabela.
    if Tabela = Primeira then
      pAdicionar(
        'UPDATE TABDET T' + Item +
        ' INNER JOIN DETCUS D ON D.DET_SEQDET = T.AUTOINCREM AND D.DET_TABELA = ' + Numero +
        ' LEFT JOIN ITEFOR I ON I.AUTOINCREM = T.ITE_SEQGER' +
        ' SET D.DET_PREVEN = G.ITE_PREVE' + Numero + ' * ' + CONVERSAO + ', D.DET_MARBRU = G.ITE_MARBR' + Numero +
        ', D.DET_ICMSAI = G.ITE_ICMSAI, D.DET_DESOPE = G.ITE_DESOPE, D.DET_OUTVAL = G.ITE_OUTVAL * ' + CONVERSAO +
        Filtro + Ligada)
    else
      pAdicionar(
        'UPDATE TABDET T' + Item +
        ' INNER JOIN DETCUS D ON D.DET_SEQDET = T.AUTOINCREM AND D.DET_TABELA = ' + Numero +
        ' LEFT JOIN ITEFOR I ON I.AUTOINCREM = T.ITE_SEQGER' +
        ' SET D.DET_PREVEN = G.ITE_PREVE' + Numero + ' * ' + CONVERSAO + ', D.DET_MARBRU = G.ITE_MARBR' + Numero +
        Filtro + Ligada);
  end;
  Result := Comandos;
end;

// Reverter do lote: a TABDET e a DETCUS voltam ao que a REFTDE guardou na aplicacao, e as linhas dela saem. So os itens
// que voltam (ITEREO 'S'): o alterado que o operador mandou manter ('X') fica com a tabela igual ao produto. Roda antes
// de as linhas do lote sairem da ITEREO. Conversao aplicada antes da REFTDE: nada a devolver.
function TProcessoConversao.fComandosReverterTabelasFornecedor(const Lote: Integer): TArray<TComandoSql>;
var
  Parametros: TArray<TValorCampo>;
begin
  Parametros := [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTE', Lote)];
  Result := nil;
  if FTabelasFornecedor then
    Result := [
      fComandoConvert('UPDATE TABDET T INNER JOIN REFTDE B ON B.TDE_CODEMP = T.ITE_CODEMP ' +
        'AND B.TDE_SEQDET = T.AUTOINCREM ' +
        'INNER JOIN ITEREO O ON O.REF_CHAVE = B.TDE_CHAVE AND O.REF_LOTE = B.TDE_LOTE ' +
        'AND O.ITE_CODEMP = T.ITE_CODEMP AND O.ITE_CODITE = T.ITE_CODITE AND O.REF_APLICADO = ''S'' ' +
        'SET T.ITE_PRECOM = B.TDE_PRECOM, T.ITE_PRECUS = B.TDE_PRECUS, ' +
        'T.ITE_SUBFED = B.TDE_SUBFED, T.ITE_IMPFED = B.TDE_IMPFED ' +
        'WHERE B.TDE_CHAVE = :CHAVE AND B.TDE_LOTE = :LOTE AND B.TDE_TABELA = 0', Parametros),
      fComandoConvert('UPDATE DETCUS D INNER JOIN TABDET T ON T.AUTOINCREM = D.DET_SEQDET ' +
        'INNER JOIN REFTDE B ON B.TDE_CODEMP = T.ITE_CODEMP AND B.TDE_SEQDET = D.DET_SEQDET ' +
        'AND B.TDE_TABELA = D.DET_TABELA ' +
        'INNER JOIN ITEREO O ON O.REF_CHAVE = B.TDE_CHAVE AND O.REF_LOTE = B.TDE_LOTE ' +
        'AND O.ITE_CODEMP = T.ITE_CODEMP AND O.ITE_CODITE = T.ITE_CODITE AND O.REF_APLICADO = ''S'' ' +
        'SET D.DET_ICMSAI = B.TDE_ICMSAI, D.DET_DESOPE = B.TDE_DESOPE, ' +
        'D.DET_OUTVAL = B.TDE_OUTVAL, D.DET_MARBRU = B.TDE_MARBRU, D.DET_PREVEN = B.TDE_PREVEN ' +
        'WHERE B.TDE_CHAVE = :CHAVE AND B.TDE_LOTE = :LOTE AND B.TDE_TABELA > 0', Parametros)];
  Result := Result + [fComandoConvert('DELETE FROM REFTDE WHERE TDE_CHAVE = :CHAVE AND TDE_LOTE = :LOTE', Parametros)];
end;

function TProcessoConversao.fExecutarFase(const Titulo: string; const Funcao: TFuncaoFaseConvert;
  out Mensagem: string): Boolean;
var
  Resultado: TResultadoGravacao;
begin
  // Com a conversao por grupo, o titulo diz de qual empresa e a fase (usuario, 2026-10-06).
  Resultado := FHost.ExecutarComProgresso(Titulo + ' - Empresa ' + FEmpresa, TTarefaConvert.Create(Funcao));
  Result := Resultado.Sucesso;
  if not Result then
    Mensagem := Resultado.Mensagem;
end;

function TProcessoConversao.fResumo: string;
begin
  if FJaConcluida then
  begin
    if FBloqueantes > 0 then
      Result := 'Conversão concluída, mas a conferência atual encontrou ' + IntToStr(FBloqueantes) +
        ' divergência(s).'
    else
      Result := 'Conferência sem divergências.';
  end
  else if FAtivou then
    Exit('Conversão concluída.')
  else
    Result := 'A conferência encontrou ' + IntToStr(FBloqueantes) + ' divergência(s): a CFG_REFCIS não foi ligada.' +
      sLineBreak + 'Veja as divergências na tela, corrija e clique em Continuar.';

  if FAlertas > 0 then
    Result := Result + sLineBreak + 'Alertas: ' + IntToStr(FAlertas) + '.';
end;

// Abreviacao do item: os campos do CADITE que a procedure recebe (os mesmos do cadastro).
function TProcessoConversao.fCamposAbreviacao(out Mensagem: string): Boolean;
const
  CAMPOS: array[0..3] of string = ('ITE_CLAIPI', 'ITE_EXCIPI', 'ITE_EXCBFR', 'ITE_ABFREF');
var
  Coluna: string;
begin
  Result := True;
  for Coluna in CAMPOS do
    if not FEstrutura.ColunaExiste('CADITE', Coluna) then
    begin
      Mensagem := 'A origem "Abreviação do Item" exige a coluna CADITE.' + Coluna + ', que não existe neste banco.';
      Exit(False);
    end;
end;

function TProcessoConversao.Executar(const Parametros: TParametrosConversao; out Mensagem: string): Boolean;
var
  Atual: TSituacaoConversao;
  Resultado: TResultadoGravacao;
begin
  Result := False;
  Mensagem := '';
  FDetalhes.Clear;
  try
    if not fPrepararAmbiente(Mensagem) then
      Exit;
    if not fTravar(Mensagem) then
      Exit;
    try
      // Com a trava: outra estacao pode ter avancado a conversao antes.
      Atual := Situacao(FHost);
      FJaConcluida := False;
      Resultado := fResultadoConvert(True, '');
      case Atual.Fase of
        fcConcluida:
          begin
            Mensagem := MENSAGEM_JA_CONVERTIDA;
            Exit;
          end;
        fcNova:
          begin
            if (UpperCase(FHost.ConfiguracaoTexto('REFCIS')) = 'S') or fMarcadaConvertida then
            begin
              Mensagem := MENSAGEM_JA_CONVERTIDA;
              Exit;
            end;
            FChave := TGUID.NewGuid.ToString;
            pDefinirParametros(Parametros);
            if (FOrigem = oicAbreviacaoItem) and not fCamposAbreviacao(Mensagem) then
              Exit;
            Resultado := fIniciarConversao;
          end;
      else
        FChave := Atual.Chave;
        pDefinirParametros(Atual.Parametros);
        if (FOrigem = oicAbreviacaoItem) and not fCamposAbreviacao(Mensagem) then
          Exit;
        Resultado := fGarantirEmpresasRefcon;
      end;
      if not Resultado.Sucesso then
      begin
        Mensagem := Resultado.Mensagem;
        Exit;
      end;

      // Antes do calculo: com a opcao Abreviacao do Item ele ja usa as aliquotas da IMPTRI.
      Resultado := fAtualizarAbreviacoes;
      if not Resultado.Sucesso then
      begin
        Mensagem := 'Abreviações da reforma: ' + Resultado.Mensagem;
        Exit;
      end;

      if not fExecutarFase('Preparando itens', fPreparar, Mensagem) then
      begin
        pVoltarAoInicio(Mensagem);
        Exit;
      end;
      if not fExecutarFase('Aplicando preços', fAplicar, Mensagem) then
      begin
        pVoltarAoInicio(Mensagem);
        Exit;
      end;
      if not fExecutarFase('Conferindo', fConferirEAtivar, Mensagem) then
        Exit;

      Mensagem := fResumo;
      Result := FAtivou;
    finally
      pDestravar;
    end;
  except
    Result := False;
    Mensagem := fMensagemExcecaoConvert;
  end;
end;

// ' AND <coluna> IN (...)' com os itens do filtro (literais: os codigos ja vem sem aspas de fNormalizarItensConvert);
// vazio sem filtro.
// Um parametro por codigo (FILITE0, FILITE1...): o texto digitado nunca entra no SQL.
function TProcessoConversao.fSqlFiltroItens(const Coluna: string): string;
var
  Indice: Integer;
begin
  Result := '';
  for Indice := 0 to High(fParametrosFiltroItens) do
    Result := Result + IfThen(Result <> '', ', ', '') + ':FILITE' + IntToStr(Indice);
  if Result <> '' then
    Result := ' AND ' + Coluna + ' IN (' + Result + ')';
end;

// Os valores dos parametros de fSqlFiltroItens, na mesma ordem.
function TProcessoConversao.fParametrosFiltroItens: TArray<TValorCampo>;
var
  Codigo: string;
begin
  Result := nil;
  for Codigo in SplitString(FItens, ';') do
    if Codigo <> '' then
      Result := Result + [fParametroConvert('FILITE' + IntToStr(Length(Result)), Codigo)];
end;

procedure TProcessoConversao.pDefinirFiltroItens(const Consulta: IReformaConsulta);
var
  Parametro: TValorCampo;
begin
  for Parametro in fParametrosFiltroItens do
    Consulta.DefinirParametro(Parametro.Nome, Parametro.Valor);
end;

// Produto diferente do que a conversao gravou (ITEGER G x ITEREF F): preco, custo, margem e comissao.
function TProcessoConversao.fCondicaoAlterado: string;
const
  CAMPOS: array[0..4] of string = ('ITE_PRECOM', 'ITE_PRECUS', 'ITE_DESOPE', 'ITE_ICMSAI', 'ITE_OUTVAL');
  POR_TABELA: array[0..2] of string = ('ITE_PREVE', 'ITE_MARBR', 'ITE_COMTB');
var
  Coluna: string;
  Raiz: string;
  Tabela: Integer;
  Texto: string;

  procedure pAdicionar(const Nome: string);
  begin
    if not MatchText(Nome, FEstrutura.Colunas) then
      Exit;
    if Texto <> '' then
      Texto := Texto + ' OR ';
    Texto := Texto + 'ABS(IFNULL(G.' + Nome + ', 0) - IFNULL(F.' + Nome + ', 0)) > 0.000001';
  end;

begin
  Texto := '';
  for Coluna in CAMPOS do
    pAdicionar(Coluna);
  for Raiz in POR_TABELA do
    for Tabela := 1 to QUANTIDADE_TABELAS_PRECO do
      pAdicionar(Raiz + IntToStr(Tabela));
  if Texto = '' then
    Texto := '1 = 0';
  Result := Texto;
end;

// Itens alterados depois da conversao (usuario, 2026-10-06): a lista vai para a tela de log do host e o operador
// decide. Nao: as linhas deles ficam 'X' na ITEREO (o produto fica como esta) e o resto e revertido.
function TProcessoConversao.fConfirmarAlterados: TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Condicao: string;
  Linhas: TArray<string>;
begin
  Result := fResultadoConvert(True, '');
  Condicao := fCondicaoAlterado;
  Linhas := nil;
  Consulta := FHost.AbrirConsulta('SELECT F.ITE_CODEMP, F.ITE_CODITE FROM ITEREF F' +
    ' INNER JOIN ITEREO O ON O.REF_CHAVE = F.REF_CHAVE AND O.ITE_CODEMP = F.ITE_CODEMP AND O.ITE_CODITE = F.ITE_CODITE' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = F.ITE_CODEMP AND G.ITE_CODITE = F.ITE_CODITE' +
    ' WHERE F.REF_CHAVE = :CHAVE AND O.REF_APLICADO = ''S'' AND (' + Condicao + ')' +
    ' ORDER BY F.ITE_CODITE, F.ITE_CODEMP');
  Consulta.DefinirParametro('CHAVE', FChave);
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Linhas := Linhas + ['Empresa ' + fTextoConvert(Consulta.ValorCampo('ITE_CODEMP')) + ', item ' +
      fTextoConvert(Consulta.ValorCampo('ITE_CODITE')) + '.'];
    Consulta.Proximo;
  end;
  Consulta := nil;
  if Length(Linhas) = 0 then
    Exit;

  FHost.MostrarLista(TITULO_REVERTER, IntToStr(Length(Linhas)) +
    ' item(ns) com preço alterado depois da conversão:', Linhas);
  if FHost.Confirmar(TITULO_REVERTER, 'Reverter também esses itens?') then
    Exit;

  // Nao reverte esses: um comando so, pela mesma condicao.
  Result := fGravarConvert(FHost, [fComandoConvert('UPDATE ITEREO O' +
    ' INNER JOIN ITEREF F ON F.REF_CHAVE = O.REF_CHAVE AND F.ITE_CODEMP = O.ITE_CODEMP AND F.ITE_CODITE = O.ITE_CODITE' +
    ' INNER JOIN ITEGER G ON G.ITE_CODEMP = O.ITE_CODEMP AND G.ITE_CODITE = O.ITE_CODITE' +
    ' SET O.REF_APLICADO = ''X''' +
    ' WHERE O.REF_CHAVE = :CHAVE AND O.REF_APLICADO = ''S'' AND (' + Condicao + ')',
    [fParametroConvert('CHAVE', FChave)])]);
end;

// Lote a lote, numa transacao cada: o host grava a ITEREO no produto (ReverterLote) e as linhas do lote saem da ITEREO
// e da ITEREF. No fim, numa transacao: CFG_REFCIS = 'N' (DesativarReforma) e EMP_REFCON = 'R' em todas as empresas da
// conversao, e o que sobrou da chave (itens mantidos 'X', REFDIV, REFCON) e apagado (usuario, 2026-10-06).
function TProcessoConversao.fReverter(const Progresso: IReformaProgresso): TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Lotes: TList<TPair<Integer, Integer>>;
  Lote: TPair<Integer, Integer>;
  Total: Integer;
  Primeiro: Boolean;
  Transacao: IReformaTransacao;
  Empresas: TArray<string>;
  Empresa: string;
  Comandos: TArray<TComandoSql>;
  ImpostosFederais: TArray<TComandoSql>;
begin
  Lotes := TList<TPair<Integer, Integer>>.Create;
  try
    Consulta := FHost.AbrirConsulta('SELECT REF_LOTE, SUM(CASE WHEN REF_ORIGEM = ''L'' THEN 1 ELSE 0 END) AS QTD ' +
      'FROM ITEREO WHERE REF_CHAVE = :CHAVE AND REF_APLICADO = ''S'' GROUP BY REF_LOTE ORDER BY REF_LOTE');
    Consulta.DefinirParametro('CHAVE', FChave);
    Consulta.Abrir;
    Total := 0;
    while not Consulta.Fim do
    begin
      Lotes.Add(TPair<Integer, Integer>.Create(Round(fNumeroConvert(Consulta.ValorCampo('REF_LOTE'))),
        Round(fNumeroConvert(Consulta.ValorCampo('QTD')))));
      Inc(Total, Lotes.Last.Value);
      Consulta.Proximo;
    end;
    Consulta := nil;

    Progresso.Definir('Revertendo preços', Total);
    Primeiro := True;
    for Lote in Lotes do
    begin
      Transacao := FHost.Gravacao.IniciarTransacao;
      if not Assigned(Transacao) then
        Exit(fResultadoConvert(False, MENSAGEM_TRANSACAO_ABERTA));

      Result := FHost.ReverterLote(FChave, Lote.Key, Primeiro);
      // A ITEREF antes: ela acha as linhas do lote pela ITEREO.
      if Result.Sucesso then
        Result := fExecutarBlocosConvert(FHost, fComandosReverterTabelasFornecedor(Lote.Key) + [
          fComandoConvert('DELETE F FROM ITEREF F INNER JOIN ITEREO O ON O.REF_CHAVE = F.REF_CHAVE ' +
            'AND O.ITE_CODEMP = F.ITE_CODEMP AND O.ITE_CODITE = F.ITE_CODITE ' +
            'WHERE O.REF_CHAVE = :CHAVE AND O.REF_LOTE = :LOTE AND O.REF_APLICADO = ''S''',
            [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTE', Lote.Key)]),
          fComandoConvert('DELETE FROM ITEREO WHERE REF_CHAVE = :CHAVE AND REF_LOTE = :LOTE ' +
            'AND REF_APLICADO = ''S''', [fParametroConvert('CHAVE', FChave), fParametroConvert('LOTE', Lote.Key)])]);
      if Result.Sucesso then
        Result := Transacao.Confirmar
      else
        Transacao.Desfazer;
      Transacao := nil;
      if not Result.Sucesso then
        Exit(fResultadoConvert(False, 'Lote ' + IntToStr(Lote.Key) + ': ' + Result.Mensagem));

      Primeiro := False;
      Progresso.Avancar(Lote.Value);
    end;
  finally
    Lotes.Free;
  end;

  Empresas := nil;
  ImpostosFederais := nil;
  Consulta := FHost.AbrirConsulta('SELECT CON_CODEMP, CON_SUBFED, CON_IMPFED FROM REFCON WHERE CON_CHAVE = :CHAVE ' +
    'ORDER BY CON_ID');
  Consulta.DefinirParametro('CHAVE', FChave);
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Empresa := fTextoConvert(Consulta.ValorCampo('CON_CODEMP'));
    Empresas := Empresas + [Empresa];
    // Os impostos federais padrao que a ativacao zerou (fComandosZerarImpostosFederais). NULL: ativada antes da regra.
    if not VarIsNull(Consulta.ValorCampo('CON_SUBFED')) and not VarIsNull(Consulta.ValorCampo('CON_IMPFED')) then
      ImpostosFederais := ImpostosFederais + [fComandoConvert('UPDATE CADEMP SET EMP_SUBFED = :SUBFED, ' +
        'EMP_IMPFED = :IMPFED WHERE EMP_CODEMP = :CODEMP',
        [fParametroConvert('SUBFED', fNumeroConvert(Consulta.ValorCampo('CON_SUBFED'))),
         fParametroConvert('IMPFED', fNumeroConvert(Consulta.ValorCampo('CON_IMPFED'))),
         fParametroConvert('CODEMP', Empresa)])];
    Consulta.Proximo;
  end;
  Consulta := nil;

  Transacao := FHost.Gravacao.IniciarTransacao;
  if not Assigned(Transacao) then
    Exit(fResultadoConvert(False, MENSAGEM_TRANSACAO_ABERTA));

  for Empresa in Empresas do
  begin
    Result := FHost.DesativarReforma(Empresa);
    if not Result.Sucesso then
    begin
      Transacao.Desfazer;
      Exit;
    end;
  end;

  Comandos := [
    fComandoConvert('DELETE FROM ITEREF WHERE REF_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('DELETE FROM ITEREO WHERE REF_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('DELETE FROM REFDIV WHERE DIV_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('DELETE FROM REFTDE WHERE TDE_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)]),
    fComandoConvert('DELETE FROM REFCON WHERE CON_CHAVE = :CHAVE', [fParametroConvert('CHAVE', FChave)])];
  // EMP_REFCON = 'R' replica para as lojas e e o sinal da reversao (a REFCON foi apagada): la a sanitizacao desliga a
  // CFG_REFCIS.
  for Empresa in Empresas do
    Comandos := Comandos + [fComandoConvert('UPDATE CADEMP SET EMP_REFCON = ''R'' WHERE EMP_CODEMP = :CODEMP',
      [fParametroConvert('CODEMP', Empresa)])];
  Comandos := Comandos + ImpostosFederais;
  Result := fExecutarBlocosConvert(FHost, Comandos);
  if Result.Sucesso then
    Result := Transacao.Confirmar
  else
    Transacao.Desfazer;
end;

// Usuario, 2026-10-06: na conversao, todas as abreviacoes da reforma (ABFRTE, entrada e saida) recebem CBS e IBS UF da
// 1a linha da IMPTRI. IS, diferimento e reducao ficam. Sem a tabela ou as colunas, sem linha na IMPTRI ou com o campo
// nulo, aquele campo nao muda. Valor por parametro (a LOGREP leva o numero). Nao volta no Reverter: a ABFRTE nao tem
// empresa e vale para todos os grupos. Nenhum nome de parametro e inicio de outro: o TBatchSQL do 72/74.111 troca
// ':NOME' por StringReplace, e :CBS estragava :CBS_ATUAL.
function TProcessoConversao.fAtualizarAbreviacoes: TResultadoGravacao;
var
  Consulta: IReformaConsulta;
  Cbs: Variant;
  Ibs: Variant;
  Comandos: TArray<TComandoSql>;
begin
  Result := fResultadoConvert(True, '');
  Consulta := FHost.AbrirConsulta('SELECT COUNT(*) AS QTD FROM information_schema.COLUMNS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ''ABFRTE'' AND COLUMN_NAME IN (''RTE_CBSALQ'', ''RTE_IBSUFA'')');
  Consulta.Abrir;
  if Round(fNumeroConvert(Consulta.ValorCampo('QTD'))) < 2 then
    Exit;

  Consulta := FHost.AbrirConsulta('SELECT CBS, IBS FROM IMPTRI LIMIT 1');
  Consulta.Abrir;
  if Consulta.Vazia then
    Exit;
  Cbs := Consulta.ValorCampo('CBS');
  Ibs := Consulta.ValorCampo('IBS');
  Consulta := nil;

  Comandos := nil;
  if not VarIsNull(Cbs) then
    Comandos := Comandos + [fComandoConvert('UPDATE ABFRTE SET RTE_CBSALQ = :NOVO_CBS WHERE NOT (RTE_CBSALQ <=> :ATUAL_CBS)',
      [fParametroConvert('NOVO_CBS', fNumeroConvert(Cbs)), fParametroConvert('ATUAL_CBS', fNumeroConvert(Cbs))])];
  if not VarIsNull(Ibs) then
    Comandos := Comandos + [fComandoConvert('UPDATE ABFRTE SET RTE_IBSUFA = :NOVO_IBS WHERE NOT (RTE_IBSUFA <=> :ATUAL_IBS)',
      [fParametroConvert('NOVO_IBS', fNumeroConvert(Ibs)), fParametroConvert('ATUAL_IBS', fNumeroConvert(Ibs))])];
  if Length(Comandos) > 0 then
    Result := fGravarConvert(FHost, Comandos);
end;

function TProcessoConversao.Reverter(out Mensagem: string): Boolean;
var
  Atual: TSituacaoConversao;
  Resultado: TResultadoGravacao;
begin
  Result := False;
  Mensagem := '';
  FDetalhes.Clear;
  try
    if not fPrepararAmbiente(Mensagem) then
      Exit;
    if not fTravar(Mensagem) then
      Exit;
    try
      Atual := Situacao(FHost);
      if not (Atual.Fase in [fcAplicando, fcConcluida, fcDivergente]) then
      begin
        Mensagem := 'Não há conversão aplicada para reverter.';
        Exit;
      end;
      FChave := Atual.Chave;
      pDefinirParametros(Atual.Parametros);

      Resultado := fConfirmarAlterados;
      if not Resultado.Sucesso then
      begin
        Mensagem := Resultado.Mensagem;
        Exit;
      end;

      if not fExecutarFase('Revertendo preços', fReverter, Mensagem) then
        Exit;

      Mensagem := 'Conversão revertida.';
      Result := True;
    finally
      pDestravar;
    end;
  except
    Result := False;
    Mensagem := fMensagemExcecaoConvert;
  end;
end;

function TProcessoConversao.Conferir(out Mensagem: string): Boolean;
var
  Atual: TSituacaoConversao;
begin
  Result := False;
  Mensagem := '';
  FDetalhes.Clear;
  try
    if not fPrepararAmbiente(Mensagem) then
      Exit;
    if not fTravar(Mensagem) then
      Exit;
    try
      Atual := Situacao(FHost);
      if not (Atual.Fase in [fcConcluida, fcDivergente]) then
      begin
        Mensagem := 'Não há conversão concluída ou com divergência para conferir.';
        Exit;
      end;
      FChave := Atual.Chave;
      pDefinirParametros(Atual.Parametros);
      FJaConcluida := Atual.Fase = fcConcluida;

      if not fExecutarFase('Conferindo', fConferirEAtivar, Mensagem) then
        Exit;

      Mensagem := fResumo;
      Result := FAtivou or (FJaConcluida and (FBloqueantes = 0));
    finally
      pDestravar;
    end;
  except
    Result := False;
    Mensagem := fMensagemExcecaoConvert;
  end;
end;

end.
