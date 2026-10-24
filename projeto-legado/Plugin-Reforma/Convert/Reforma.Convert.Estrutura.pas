unit Reforma.Convert.Estrutura;

// Convert (REFTRI-02, RN15): so confere a estrutura. Quem cria e ajusta IMPTRI, REFPRE, ITEREO, ITEREF, REFCON, REFDIV e REFTDE
// e o metodo de sanitizacao do plugin (Reforma.Repositorio.Estrutura, na subida do autcom); o Convert nao cria nem
// altera tabela. Falta alguma tabela ou coluna de controle: a conversao nao comeca. As listas de colunas sao as de
// Reforma.Repositorio.Estrutura (fonte unica), filtradas pelo que existe neste banco (Suframa e ITE_ALQFED variam).
//
// Tambem guarda os auxiliares de leitura e gravacao comuns as units do Convert.

interface

uses
  System.Generics.Collections,
  Reforma.Contrato.Gravacao,
  Reforma.Contrato.Host,
  Reforma.Contrato.Convert;

const
  TITULO_CONVERT = 'Ativar Preços Reforma Tributária';
  // Diferenca numerica que conta como alteracao ou divergencia.
  TOLERANCIA_CONVERT = 0.000001;

type
  TColunasItem = TArray<string>;

  TEstruturaConvert = class
  strict private
    FBanco: IReformaBancoHost;
    FColunas: TColunasItem;
    // 'TABELA.COLUNA' e 'TABELA' como estao no banco.
    FExistentes: TDictionary<string, Boolean>;
    procedure pLerEstrutura;
    function fFaltando(const Tabela: string; const Colunas: array of string): string;
  public
    constructor Create(const Banco: IReformaBancoHost);
    destructor Destroy; override;
    // False com Mensagem: a conversao nao comeca.
    function Validar(out Mensagem: string): Boolean;
    // Colunas ITE_* (RN15a) presentes no ITEGER, na ITEREO e na ITEREF, na ordem da lista, sem ITE_CODEMP/ITE_CODITE e
    // sem as 4 proprias (DPISCO/CBS/IBS/IS, sempre presentes na ITEREF). So depois de Validar.
    property Colunas: TColunasItem read FColunas;
    function TemColuna(const Nome: string): Boolean;
    // Coluna de qualquer tabela lida (ITEGER, PREPRO, CADITE, CADEMP, TABDET, DETCUS, ITEFOR e as do plugin). So depois
    // de Validar.
    function ColunaExiste(const Tabela, Coluna: string): Boolean;
  end;

function fNumeroConvert(const Valor: Variant): Double;
function fTextoConvert(const Valor: Variant): string;
function fParametroConvert(const Nome: string; const Valor: Variant): TValorCampo;
function fComandoConvert(const Sql: string; const Parametros: array of TValorCampo): TComandoSql;
function fResultadoConvert(const Sucesso: Boolean; const Mensagem: string): TResultadoGravacao;
// Data e hora como texto: e assim que vao para o banco (contrato: nunca TDateTime no lote).
function fDataConvert(const Momento: TDateTime): string;
function fHoraConvert(const Momento: TDateTime): string;
// Numero para REFDIV e mensagens, com ponto decimal e sem separador de milhar.
function fNumeroTextoConvert(const Valor: Double): string;
// Dentro de um except sem classe: o objeto pode ser de outro modulo (o host).
function fMensagemExcecaoConvert: string;
// Comandos pelo TBatchSQL do host em blocos de TAMANHO_BLOCO_SQL, dentro da transacao ja aberta.
function fExecutarBlocosConvert(const Host: IReformaConvertHost; const Comandos: TArray<TComandoSql>): TResultadoGravacao;
// Transacao propria (abre, executa em blocos e confirma; qualquer falha desfaz tudo).
function fGravarConvert(const Host: IReformaConvertHost; const Comandos: TArray<TComandoSql>): TResultadoGravacao;

const
  // Comandos por ExecSQL no lote do host (o mesmo tamanho da gravacao da ITEREF, RN11).
  TAMANHO_BLOCO_SQL = 100;
  MENSAGEM_TRANSACAO_ABERTA = 'Há uma transação aberta no autcom. Feche as outras telas e tente de novo.';

implementation

uses
  System.SysUtils,
  System.Math,
  System.Variants,
  Reforma.Contrato.Tipos,
  Reforma.Repositorio.Estrutura;

function fNumeroConvert(const Valor: Variant): Double;
begin
  if VarIsNull(Valor) or VarIsEmpty(Valor) then
    Result := 0
  else
    Result := VarAsType(Valor, varDouble);
end;

function fTextoConvert(const Valor: Variant): string;
begin
  Result := VarToStr(Valor);
end;

function fParametroConvert(const Nome: string; const Valor: Variant): TValorCampo;
begin
  Result.Nome := Nome;
  Result.Valor := Valor;
end;

function fComandoConvert(const Sql: string; const Parametros: array of TValorCampo): TComandoSql;
var
  Indice: Integer;
begin
  Result.Sql := Sql;
  SetLength(Result.Parametros, Length(Parametros));
  for Indice := 0 to High(Parametros) do
    Result.Parametros[Indice] := Parametros[Indice];
end;

function fResultadoConvert(const Sucesso: Boolean; const Mensagem: string): TResultadoGravacao;
begin
  Result.Sucesso := Sucesso;
  Result.LinhasAfetadas := 0;
  Result.Mensagem := Mensagem;
end;

function fDataConvert(const Momento: TDateTime): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd', Momento);
end;

function fHoraConvert(const Momento: TDateTime): string;
begin
  Result := FormatDateTime('hh":"nn":"ss', Momento);
end;

function fNumeroTextoConvert(const Valor: Double): string;
var
  Formato: TFormatSettings;
begin
  Formato := TFormatSettings.Create;
  Formato.DecimalSeparator := '.';
  Formato.ThousandSeparator := #0;
  Result := FormatFloat('0.########', Valor, Formato);
end;

function fMensagemExcecaoConvert: string;
var
  Objeto: TObject;
begin
  Result := 'Falha inesperada.';
  Objeto := ExceptObject;
  if Objeto = nil then
    Exit;

  if Objeto is Exception then
    Result := Exception(Objeto).Message
  else
    // Excecao do host: outra classe Exception, mesmo layout (mesma RTL).
    try
      Result := Exception(Objeto).Message;
    except
      Result := 'Falha inesperada.';
    end;
end;

function fExecutarBlocosConvert(const Host: IReformaConvertHost; const Comandos: TArray<TComandoSql>): TResultadoGravacao;
var
  Inicio: Integer;
  Quantidade: Integer;
begin
  Result := fResultadoConvert(True, '');
  Inicio := 0;
  while Inicio < Length(Comandos) do
  begin
    Quantidade := Min(TAMANHO_BLOCO_SQL, Length(Comandos) - Inicio);
    Result := Host.ExecutarLote(Copy(Comandos, Inicio, Quantidade));
    if not Result.Sucesso then
      Exit;
    Inc(Inicio, Quantidade);
  end;
end;

function fGravarConvert(const Host: IReformaConvertHost; const Comandos: TArray<TComandoSql>): TResultadoGravacao;
var
  Transacao: IReformaTransacao;
begin
  Transacao := Host.Gravacao.IniciarTransacao;
  if not Assigned(Transacao) then
    Exit(fResultadoConvert(False, MENSAGEM_TRANSACAO_ABERTA));

  Result := fExecutarBlocosConvert(Host, Comandos);
  if Result.Sucesso then
    Result := Transacao.Confirmar
  else
    Transacao.Desfazer;
end;

{ TEstruturaConvert }

constructor TEstruturaConvert.Create(const Banco: IReformaBancoHost);
begin
  inherited Create;
  FBanco := Banco;
  FExistentes := TDictionary<string, Boolean>.Create;
end;

destructor TEstruturaConvert.Destroy;
begin
  FreeAndNil(FExistentes);
  inherited Destroy;
end;

procedure TEstruturaConvert.pLerEstrutura;
var
  Consulta: IReformaConsulta;
  Tabelas: string;
  Tabela: string;
begin
  FExistentes.Clear;

  // So constantes do plugin no IN: nenhum valor externo entra no texto.
  Tabelas := QuotedStr('ITEGER') + ', ' + QuotedStr('PREPRO') + ', ' + QuotedStr('CADITE') + ', ' + QuotedStr('CADEMP') +
    ', ' + QuotedStr('TABDET') + ', ' + QuotedStr('DETCUS') + ', ' + QuotedStr('ITEFOR');
  for Tabela in TABELAS_PLUGIN do
    Tabelas := Tabelas + ', ' + QuotedStr(Tabela);

  Consulta := FBanco.AbrirConsulta(
    'SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS ' +
    'WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN (' + Tabelas + ')');
  Consulta.Abrir;
  while not Consulta.Fim do
  begin
    Tabela := UpperCase(fTextoConvert(Consulta.ValorCampo('TABLE_NAME')));
    FExistentes.AddOrSetValue(Tabela, True);
    FExistentes.AddOrSetValue(Tabela + '.' + UpperCase(fTextoConvert(Consulta.ValorCampo('COLUMN_NAME'))), True);
    Consulta.Proximo;
  end;
end;

function TEstruturaConvert.fFaltando(const Tabela: string; const Colunas: array of string): string;
var
  Coluna: string;
begin
  Result := '';
  for Coluna in Colunas do
    if not ColunaExiste(Tabela, Coluna) then
      Exit(Tabela + '.' + Coluna);
end;

function TEstruturaConvert.Validar(out Mensagem: string): Boolean;
const
  CONTROLE_ITEM: array[0..5] of string = ('REF_CHAVE', 'REF_LOTE', 'REF_ORIGEM', 'REF_APLICADO', 'ITE_CODEMP',
    'ITE_CODITE');
  CONTROLE_REFCON: array[0..22] of string = ('CON_ID', 'CON_CHAVE', 'CON_CODEMP', 'CON_EMPORI', 'CON_ORIGEM',
    'CON_OPCAO', 'CON_FASE', 'CON_CODOPE', 'CON_DTAINI', 'CON_HORINI', 'CON_DTAFIM', 'CON_HORFIM', 'CON_QTDITE',
    'CON_QTDAPL', 'CON_QTDDIV', 'CON_ALQCBS', 'CON_ALQIBS', 'CON_ALQIS', 'CON_ORIIMP', 'CON_SOATIV', 'CON_FILITE',
    'CON_SUBFED', 'CON_IMPFED');
  CONTROLE_REFDIV: array[0..9] of string = ('DIV_ID', 'DIV_CHAVE', 'DIV_CODEMP', 'DIV_CODITE', 'DIV_TIPO', 'DIV_CAMPO',
    'DIV_ESPERA', 'DIV_ENCONT', 'DIV_DTAREG', 'DIV_HORREG');
  CONTROLE_REFPRE: array[0..3] of string = ('ITE_CODEMP', 'ITE_CODITE', 'ITE_DPISCO', 'ITE_DESOPE');
  CONTROLE_REFTDE: array[0..14] of string = ('TDE_ID', 'TDE_CHAVE', 'TDE_LOTE', 'TDE_CODEMP', 'TDE_SEQDET', 'TDE_TABELA',
    'TDE_PRECOM', 'TDE_PRECUS', 'TDE_SUBFED', 'TDE_IMPFED', 'TDE_ICMSAI', 'TDE_DESOPE', 'TDE_OUTVAL', 'TDE_MARBRU',
    'TDE_PREVEN');
var
  Tabela: string;
  Coluna: string;
  Falta: string;
  Indice: Integer;
  Lista: TList<string>;
begin
  Result := False;
  Mensagem := '';
  FColunas := nil;
  pLerEstrutura;

  Falta := '';
  for Tabela in TABELAS_PLUGIN do
    if not FExistentes.ContainsKey(Tabela) then
    begin
      Falta := Tabela;
      Break;
    end;

  if Falta = '' then
    Falta := fFaltando('ITEREO', CONTROLE_ITEM);
  if Falta = '' then
    Falta := fFaltando('ITEREF', CONTROLE_ITEM);
  if Falta = '' then
    Falta := fFaltando('ITEREF', COLUNAS_PROPRIAS);
  if Falta = '' then
    Falta := fFaltando('REFCON', CONTROLE_REFCON);
  if Falta = '' then
    Falta := fFaltando('REFDIV', CONTROLE_REFDIV);
  if Falta = '' then
    Falta := fFaltando('REFTDE', CONTROLE_REFTDE);
  if Falta = '' then
    Falta := fFaltando('REFPRE', CONTROLE_REFPRE);
  if Falta = '' then
    for Indice := 1 to QUANTIDADE_TABELAS_PRECO do
    begin
      Falta := fFaltando('REFPRE', ['ITE_COMTB' + IntToStr(Indice)]);
      if Falta <> '' then
        Break;
    end;
  // Item ativo (opcao So itens ativos). Os campos da abreviacao do item o processo confere so quando usa.
  if Falta = '' then
    Falta := fFaltando('CADITE', ['ITE_ITEATI']);
  // Marca da empresa convertida (replica para as lojas; usuario, 2026-10-06).
  if Falta = '' then
    Falta := fFaltando('CADEMP', ['EMP_REFCON']);

  if Falta <> '' then
  begin
    Mensagem := 'As tabelas da Reforma Tributária não estão preparadas (falta ' + Falta + '). ' +
      'Saia e entre de novo no autcom para o plugin ajustar o banco.';
    Exit;
  end;

  Lista := TList<string>.Create;
  try
    for Coluna in COLUNAS_ITEGER do
      if ColunaExiste('ITEGER', Coluna) and ColunaExiste('ITEREO', Coluna) and ColunaExiste('ITEREF', Coluna) then
        Lista.Add(Coluna);
    FColunas := Lista.ToArray;
  finally
    Lista.Free;
  end;

  Result := True;
end;

function TEstruturaConvert.TemColuna(const Nome: string): Boolean;
var
  Coluna: string;
begin
  Result := False;
  for Coluna in FColunas do
    if SameText(Coluna, Nome) then
      Exit(True);
end;

function TEstruturaConvert.ColunaExiste(const Tabela, Coluna: string): Boolean;
begin
  Result := FExistentes.ContainsKey(UpperCase(Tabela + '.' + Coluna));
end;

end.